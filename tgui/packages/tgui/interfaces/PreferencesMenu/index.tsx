import { useEffect, useState } from 'react';
import { useBackend } from 'tgui/backend';
import { Window } from 'tgui/layouts';
import {
  Box,
  Button,
  Dropdown,
  Input,
  LabeledList,
  Section,
  Stack,
  Tabs,
} from 'tgui-core/components';

type CharacterData = {
  age: string;
  age_options: string[];
  allowed_taur_types: boolean;
  body_size: number;
  can_open_lobby: boolean;
  class_roles: ClassRoleData[];
  char_accent: string;
  char_mannerism: string;
  customizer_count: number;
  customizers: CustomizerData[];
  descriptors: DescriptorData[];
  descriptor_count: number;
  family: string;
  features: Record<string, string>;
  flavortext: string;
  gender: string;
  gender_options: string[];
  has_descriptors: boolean;
  has_mutant_colors: boolean;
  has_mutant_skin: boolean;
  has_race_bonus: boolean;
  has_titles: boolean;
  headshot_link: string | null;
  preview_image: string;
  highlight_color: string;
  keybindings: KeybindingData[];
  active_slot: number;
  character_slots: CharacterSlotData[];
  favorited_slots: number[];
  job_preference_count: number;
  jobless_role: string;
  flaw_name: string;
  marking_count: number;
  markings: MarkingZoneData[];
  mutant_skin: boolean;
  nickname: string;
  nsfwflavortext: string;
  ooc_notes: string;
  pronouns: string;
  pronoun_options: string[];
  race_bonus: string;
  race_title: string;
  real_name: string;
  skin_tone: string;
  skin_tone_wording: string;
  species: string;
  species_options: string[];
  use_skintones: boolean;
  update_mutant_colors: boolean;
  voice_color: string;
  voice_pack: string;
  voice_pitch: number;
  voice_type: string;
  virtue: string;
  virtue_two: string;
  vice: string;
  charflaw_name: string;
  villain_roles: VillainRoleData[];
};

type ClassRoleData = {
  department: string;
  locked: boolean;
  name: string;
  priority: number;
  reason: string;
  slots: number;
  title: string;
  tutorial: string;
};

type VillainRoleData = {
  enabled: boolean;
  locked: boolean;
  name: string;
  reason: string;
};

type KeybindingData = {
  can_add: boolean;
  category: string;
  default_keys: string[];
  description: string;
  full_name: string;
  name: string;
  user_keys: string[];
};

type CharacterSlotData = {
  active: boolean;
  empty: boolean;
  favorite: boolean;
  index: number;
  name: string;
  species: string;
};

type CustomizerData = {
  accessory: string | null;
  accessory_options: string[];
  allows_disabling: boolean;
  choice: string;
  choice_options: string[];
  color_labels: string[];
  colors: string[];
  disabled: boolean;
  name: string;
  type: string;
};

type DescriptorData = {
  choice_type: string;
  name: string;
  options: string[];
  selected: string;
};

type MarkingZoneData = {
  can_add: boolean;
  markings: { color: string; name: string }[];
  name: string;
  zone: string;
};

enum Subtab {
  Identity,
  Appearance,
  Descriptors,
  Class,
  Villain,
  Keybindings,
  Slots,
}

const subtabLabels = [
  { label: 'Identity', icon: 'address-card' },
  { label: 'Appearance', icon: 'person-rays' },
  { label: 'Descriptors', icon: 'note-sticky' },
  { label: 'Class', icon: 'dungeon' },
  { label: 'Villain', icon: 'skull' },
  { label: 'Keybindings', icon: 'keyboard' },
  { label: 'Characters', icon: 'users' },
];

export const PreferencesMenu = () => {
  const { act, data } = useBackend<CharacterData>();
  const [subtab, setSubtab] = useState(Subtab.Identity);
  const [name, setName] = useState(data.real_name || '');
  const [nickname, setNickname] = useState(data.nickname || '');

  useEffect(() => setName(data.real_name || ''), [data.real_name]);
  useEffect(() => setNickname(data.nickname || ''), [data.nickname]);

  const content = (() => {
    switch (subtab) {
      case Subtab.Identity:
        return (
          <IdentityTab
            act={act}
            data={data}
            name={name}
            nickname={nickname}
            setName={setName}
            setNickname={setNickname}
          />
        );
      case Subtab.Appearance:
        return <AppearanceTab act={act} data={data} />;
      case Subtab.Descriptors:
        return <DescriptorsTab act={act} data={data} />;
      case Subtab.Class:
        return <ClassTab act={act} data={data} />;
      case Subtab.Villain:
        return <VillainTab act={act} data={data} />;
      case Subtab.Keybindings:
        return <KeybindingsTab act={act} data={data} />;
      case Subtab.Slots:
        return <SlotManager act={act} data={data} />;
    }
  })();

  return (
    <Window title="Character Creator" width={1000} height={800}>
      <Window.Content className="PreferencesMenu">
        <Stack fill>
          <Stack.Item width={18} mr={2}>
            <CreatorSidebar act={act} data={data} setSubtab={setSubtab} />
          </Stack.Item>
          <Stack.Item grow minWidth={0}>
            <Stack fill vertical>
              <Stack.Item>
                <Tabs fluid>
                  {subtabLabels.map(({ label, icon }, index) => (
                    <Tabs.Tab
                      key={label}
                      icon={icon}
                      selected={subtab === index}
                      onClick={() => setSubtab(index)}
                    >
                      {label}
                    </Tabs.Tab>
                  ))}
                </Tabs>
              </Stack.Item>
              <Stack.Item grow minHeight={0}>
                {content}
              </Stack.Item>
            </Stack>
          </Stack.Item>
        </Stack>
      </Window.Content>
    </Window>
  );
};

const CreatorSidebar = ({ act, data, setSubtab }) => (
  <Stack fill vertical className="PreferencesMenu__Sidebar">
    <Stack.Item>
      <Button fluid icon="bars" onClick={() => setSubtab(Subtab.Slots)}>
        Change Character
      </Button>
    </Stack.Item>
    {data.can_open_lobby && (
      <Stack.Item>
        <Button fluid icon="arrow-left" onClick={() => act('open_lobby')}>
          Return to Lobby
        </Button>
      </Stack.Item>
    )}
    <Stack.Item>
      <Button fluid icon="gear" onClick={() => act('open_game_settings')}>
        Game Settings
      </Button>
    </Stack.Item>
    <Stack.Divider />
    <Stack.Item fontSize={1.3} style={{ wordBreak: 'break-word' }}>
      {data.real_name || 'Unnamed Character'}
    </Stack.Item>
    <Stack.Item>
      <Section
        fill
        className="PreferencesMenu__Sidebar__Preview"
        style={{
          alignItems: 'center',
          background:
            'radial-gradient(ellipse at 50% 70%, #55483a 0%, #211c19 68%)',
          display: 'flex',
          height: '18rem',
          justifyContent: 'center',
          overflow: 'hidden',
        }}
      >
        <img
          alt="Live character preview"
          src={data.preview_image}
          style={{
            imageRendering: 'pixelated',
            maxHeight: '100%',
            maxWidth: '100%',
          }}
        />
      </Section>
    </Stack.Item>
    <Stack.Item>
      <Stack>
        <Stack.Item grow>
          <Button
            fluid
            icon="rotate-left"
            onClick={() => act('rotate_preview', { rotation: 'left' })}
          >
            Rotate
          </Button>
        </Stack.Item>
        <Stack.Item grow>
          <Button
            fluid
            icon="rotate-right"
            onClick={() => act('rotate_preview', { rotation: 'right' })}
          >
            Rotate
          </Button>
        </Stack.Item>
      </Stack>
    </Stack.Item>
    <Stack.Item>
      <Button
        fluid
        icon="camera"
        onClick={() => act('legacy_preference', { preference: 'headshot' })}
      >
        {data.headshot_link ? 'Change Headshot' : 'Set Headshot'}
      </Button>
    </Stack.Item>
    <Stack.Item grow />
    <Stack.Item>
      <Section title="Character">
        <Box color="label">
          {data.species} · {data.age}
        </Box>
        <Box color="label">{data.pronouns}</Box>
      </Section>
    </Stack.Item>
  </Stack>
);

const IdentityTab = ({ act, data, name, nickname, setName, setNickname }) => (
  <Section fill scrollable>
    <Box
      style={{
        display: 'grid',
        gap: '0.75rem',
        gridTemplateColumns: 'repeat(2, minmax(0, 1fr))',
      }}
    >
      <Stack vertical>
        <Stack.Item>
          <Section title="Info">
            <LabeledList>
              <LabeledList.Item label="Race">
                <Dropdown
                  fluid
                  selected={data.species}
                  options={data.species_options}
                  onSelected={(value) => act('set_species', { value })}
                />
              </LabeledList.Item>
              {data.has_race_bonus && (
                <LabeledList.Item label="Race Bonus">
                  <Button
                    fluid
                    onClick={() =>
                      act('legacy_preference', {
                        preference: 'race_bonus_select',
                      })
                    }
                  >
                    {data.race_bonus}
                  </Button>
                </LabeledList.Item>
              )}
              <LabeledList.Item label="Name">
                <Stack>
                  <Stack.Item grow>
                    <Input
                      fluid
                      value={name}
                      onChange={setName}
                      onEnter={() => act('set_name', { value: name })}
                    />
                  </Stack.Item>
                  <Stack.Item>
                    <Button
                      icon="save"
                      tooltip="Save name"
                      onClick={() => act('set_name', { value: name })}
                    />
                  </Stack.Item>
                  <Stack.Item>
                    <Button
                      icon="dice"
                      tooltip="Randomize name"
                      onClick={() => act('randomize_name')}
                    />
                  </Stack.Item>
                </Stack>
              </LabeledList.Item>
              <LabeledList.Item label="Nickname">
                <Stack>
                  <Stack.Item grow>
                    <Input
                      fluid
                      value={nickname}
                      onChange={setNickname}
                      onEnter={() => act('set_nickname', { value: nickname })}
                    />
                  </Stack.Item>
                  <Stack.Item>
                    <Button
                      icon="save"
                      tooltip="Save nickname"
                      onClick={() => act('set_nickname', { value: nickname })}
                    />
                  </Stack.Item>
                  <Stack.Item>
                    <Button
                      tooltip={`Highlight color: ${data.highlight_color}`}
                      style={{ backgroundColor: `#${data.highlight_color}` }}
                      onClick={() =>
                        act('legacy_preference', {
                          preference: 'highlight_color',
                        })
                      }
                    >
                      &nbsp;
                    </Button>
                  </Stack.Item>
                </Stack>
              </LabeledList.Item>
              <LabeledList.Item label="Pronouns">
                <Dropdown
                  fluid
                  selected={data.pronouns}
                  options={data.pronoun_options}
                  onSelected={(value) => act('set_pronouns', { value })}
                />
              </LabeledList.Item>
              {data.has_titles && (
                <LabeledList.Item label="Race Title">
                  <Button
                    fluid
                    onClick={() =>
                      act('legacy_preference', { preference: 'race_title' })
                    }
                  >
                    {data.race_title || 'None'}
                  </Button>
                </LabeledList.Item>
              )}
              <LabeledList.Item label="Family">
                <Button
                  fluid
                  onClick={() =>
                    act('legacy_preference', { preference: 'family' })
                  }
                >
                  {data.family || 'None'}
                </Button>
              </LabeledList.Item>
            </LabeledList>
          </Section>
        </Stack.Item>
        <Stack.Item>
          <Section title="Voice">
            <LabeledList>
              <LabeledList.Item label="Voice Identity">
                <Button
                  fluid
                  onClick={() =>
                    act('legacy_preference', { preference: 'voicetype' })
                  }
                >
                  {data.voice_type}
                </Button>
              </LabeledList.Item>
              <LabeledList.Item label="Voice Pack">
                <Button
                  fluid
                  onClick={() =>
                    act('legacy_preference', { preference: 'voicepack' })
                  }
                >
                  {data.voice_pack}
                </Button>
              </LabeledList.Item>
              <LabeledList.Item label="Voice Color">
                <Button
                  fluid
                  style={{ backgroundColor: `#${data.voice_color}` }}
                  onClick={() =>
                    act('legacy_preference', { preference: 'voice' })
                  }
                >
                  Change
                </Button>
              </LabeledList.Item>
              <LabeledList.Item label="Voice Pitch">
                <Button
                  fluid
                  onClick={() =>
                    act('legacy_preference', { preference: 'voice_pitch' })
                  }
                >
                  {data.voice_pitch}
                </Button>
              </LabeledList.Item>
            </LabeledList>
          </Section>
        </Stack.Item>
        <Stack.Item>
          <Section
            title="Character Traits"
            buttons={
              <Button icon="sliders" onClick={() => act('open_virtues')}>
                Configure
              </Button>
            }
          >
            <LabeledList>
              <LabeledList.Item label="Virtues">
                {data.virtue}
                {data.virtue_two !== 'None' ? ` · ${data.virtue_two}` : ''}
              </LabeledList.Item>
              <LabeledList.Item label="Vice">{data.vice}</LabeledList.Item>
              <LabeledList.Item label="Flaw">
                <Button
                  fluid
                  onClick={() =>
                    act('legacy_preference', { preference: 'charflaw' })
                  }
                >
                  {data.charflaw_name}
                </Button>
              </LabeledList.Item>
            </LabeledList>
          </Section>
        </Stack.Item>
      </Stack>
      <Stack vertical>
        <Stack.Item>
          <Section title="Gameplay">
            <LabeledList>
              <LabeledList.Item label="Age">
                <Dropdown
                  fluid
                  selected={data.age}
                  options={data.age_options}
                  onSelected={(value) => act('set_age', { value })}
                />
              </LabeledList.Item>
              <LabeledList.Item label="Body Type">
                <Dropdown
                  fluid
                  selected={data.gender}
                  options={data.gender_options}
                  onSelected={(value) => act('set_gender', { value })}
                />
              </LabeledList.Item>
              <LabeledList.Item label="Dominant Hand">
                <Button
                  fluid
                  onClick={() =>
                    act('legacy_preference', { preference: 'domhand' })
                  }
                >
                  Change
                </Button>
              </LabeledList.Item>
              <LabeledList.Item label="Combat Music">
                <Button
                  fluid
                  onClick={() =>
                    act('legacy_preference', { preference: 'combat_music' })
                  }
                >
                  Configure
                </Button>
              </LabeledList.Item>
            </LabeledList>
          </Section>
        </Stack.Item>
        <Stack.Item>
          <Section title="Class and Villain Preferences">
            <Stack>
              <Stack.Item grow>
                <Button fluid onClick={() => act('open_classes')}>
                  Class Preferences ({data.job_preference_count})
                </Button>
              </Stack.Item>
              <Stack.Item grow>
                <Button fluid onClick={() => act('open_villains')}>
                  Villain Roles
                </Button>
              </Stack.Item>
            </Stack>
          </Section>
        </Stack.Item>
      </Stack>
    </Box>
  </Section>
);

const AppearanceTab = ({ act, data }) => (
  <Section fill scrollable>
    <Stack vertical>
      <Stack.Item>
        <Section title="Body">
          <LabeledList>
            <LabeledList.Item label={data.skin_tone_wording}>
              <Button
                fluid
                disabled={!data.use_skintones}
                onClick={() =>
                  act('legacy_preference', { preference: 's_tone' })
                }
              >
                {data.skin_tone || 'Change'}
              </Button>
            </LabeledList.Item>
            {data.has_mutant_skin && (
              <LabeledList.Item label="Mutant Skin">
                <Button
                  fluid
                  selected={data.mutant_skin}
                  onClick={() =>
                    act('legacy_preference', { preference: 'mutant_skin' })
                  }
                >
                  {data.mutant_skin ? 'Enabled' : 'Disabled'}
                </Button>
              </LabeledList.Item>
            )}
            <LabeledList.Item label="Sprite Scale">
              <Button
                fluid
                onClick={() =>
                  act('legacy_preference', { preference: 'body_size' })
                }
              >
                {data.body_size}%
              </Button>
            </LabeledList.Item>
            <LabeledList.Item label="Update Features on Change">
              <Button.Checkbox
                fluid
                checked={data.update_mutant_colors}
                selected={data.update_mutant_colors}
                onClick={() =>
                  act('legacy_preference', {
                    preference: 'update_mutant_colors',
                  })
                }
              >
                {data.update_mutant_colors ? 'Enabled' : 'Disabled'}
              </Button.Checkbox>
            </LabeledList.Item>
            {data.has_mutant_colors &&
              Object.entries(data.features).map(([key, color], index) => (
                <LabeledList.Item
                  key={key}
                  label={`Mutant Color #${index + 1}`}
                >
                  <Button
                    fluid
                    style={{ backgroundColor: `#${color}` }}
                    onClick={() =>
                      act('legacy_preference', {
                        preference: index
                          ? `mutant_color${index + 1}`
                          : 'mutant_color',
                      })
                    }
                  >
                    Change
                  </Button>
                </LabeledList.Item>
              ))}
          </LabeledList>
          {data.allowed_taur_types && (
            <Button
              fluid
              mt={1}
              onClick={() =>
                act('legacy_preference', { preference: 'taur_type' })
              }
            >
              Configure Taur Body and Colors
            </Button>
          )}
        </Section>
      </Stack.Item>
      <Stack.Item>
        <Section title="Features">
          <Box
            style={{
              display: 'grid',
              gap: '0.5rem',
              gridTemplateColumns: 'repeat(2, minmax(0, 1fr))',
            }}
          >
            {data.customizers.map((customizer) => (
              <CustomizerCard
                key={customizer.type}
                act={act}
                customizer={customizer}
              />
            ))}
          </Box>
          {!data.customizers.length && (
            <Box color="label">No configurable features for this species.</Box>
          )}
          <Button
            fluid
            mt={1}
            icon="sliders"
            onClick={() => act('open_customizers')}
          >
            Open Advanced Customizer
          </Button>
        </Section>
      </Stack.Item>
      <Stack.Item>
        <Section title="Markings">
          <Box
            style={{
              display: 'grid',
              gap: '0.5rem',
              gridTemplateColumns: 'repeat(2, minmax(0, 1fr))',
            }}
          >
            {data.markings.map((zone) => (
              <Section key={zone.zone} title={zone.name}>
                {zone.markings.map((marking) => (
                  <Stack key={`${zone.zone}-${marking.name}`} align="center">
                    <Stack.Item grow minWidth={0}>
                      <Button
                        fluid
                        ellipsis
                        onClick={() =>
                          act('marking_action', {
                            marking_action: 'change_marking',
                            zone: zone.zone,
                            name: marking.name,
                          })
                        }
                      >
                        {marking.name}
                      </Button>
                    </Stack.Item>
                    <Stack.Item>
                      <Button
                        style={{
                          backgroundColor: marking.color.startsWith('#')
                            ? marking.color
                            : `#${marking.color}`,
                        }}
                        tooltip="Change marking color"
                        onClick={() =>
                          act('marking_action', {
                            marking_action: 'change_color',
                            zone: zone.zone,
                            name: marking.name,
                          })
                        }
                      >
                        &nbsp;
                      </Button>
                    </Stack.Item>
                    <Stack.Item>
                      <Button
                        icon="rotate-left"
                        tooltip="Reset color"
                        onClick={() =>
                          act('marking_action', {
                            marking_action: 'reset_color',
                            zone: zone.zone,
                            name: marking.name,
                          })
                        }
                      />
                    </Stack.Item>
                    <Stack.Item>
                      <Button
                        icon="trash"
                        tooltip="Remove marking"
                        onClick={() =>
                          act('marking_action', {
                            marking_action: 'remove_marking',
                            zone: zone.zone,
                            name: marking.name,
                          })
                        }
                      />
                    </Stack.Item>
                  </Stack>
                ))}
                {zone.can_add && (
                  <Button
                    fluid
                    mt={1}
                    icon="plus"
                    onClick={() =>
                      act('marking_action', {
                        marking_action: 'add_marking',
                        zone: zone.zone,
                      })
                    }
                  >
                    Add Marking
                  </Button>
                )}
              </Section>
            ))}
          </Box>
          <Stack mt={1}>
            <Stack.Item grow>
              <Button
                fluid
                onClick={() =>
                  act('marking_action', { marking_action: 'use_preset' })
                }
              >
                Use Markings Preset
              </Button>
            </Stack.Item>
            <Stack.Item grow>
              <Button
                fluid
                onClick={() =>
                  act('marking_action', {
                    marking_action: 'reset_all_colors',
                  })
                }
              >
                Reset All Colors
              </Button>
            </Stack.Item>
            <Stack.Item>
              <Button
                icon="arrow-up-right-from-square"
                onClick={() => act('open_markings')}
              >
                Advanced Editor
              </Button>
            </Stack.Item>
          </Stack>
        </Section>
      </Stack.Item>
      <Stack.Item>
        <Section title="Speech">
          <LabeledList>
            <LabeledList.Item label="Accent">
              <Button
                fluid
                onClick={() =>
                  act('legacy_preference', { preference: 'char_accent' })
                }
              >
                {data.char_accent}
              </Button>
            </LabeledList.Item>
            <LabeledList.Item label="Speech Mannerism">
              <Button
                fluid
                onClick={() =>
                  act('legacy_preference', { preference: 'char_mannerism' })
                }
              >
                {data.char_mannerism}
              </Button>
            </LabeledList.Item>
          </LabeledList>
        </Section>
      </Stack.Item>
    </Stack>
  </Section>
);

const CustomizerCard = ({
  act,
  customizer,
}: {
  act: (action: string, params?: Record<string, unknown>) => void;
  customizer: CustomizerData;
}) => (
  <Section
    title={customizer.name}
    buttons={
      customizer.allows_disabling ? (
        <Button.Checkbox
          inline
          checked={!customizer.disabled}
          selected={!customizer.disabled}
          onClick={() =>
            act('toggle_customizer', { customizer: customizer.type })
          }
        />
      ) : undefined
    }
  >
    {customizer.disabled ? (
      <Box color="label">Disabled</Box>
    ) : (
      <Stack vertical>
        {customizer.choice_options.length > 1 && (
          <Stack.Item>
            <Dropdown
              fluid
              selected={customizer.choice}
              options={customizer.choice_options}
              onSelected={(choice) =>
                act('set_customizer_choice', {
                  customizer: customizer.type,
                  choice,
                })
              }
            />
          </Stack.Item>
        )}
        {customizer.accessory_options.length > 0 && (
          <Stack.Item>
            <Dropdown
              fluid
              selected={customizer.accessory}
              options={customizer.accessory_options}
              onSelected={(accessory) =>
                act('set_customizer_accessory', {
                  customizer: customizer.type,
                  accessory,
                })
              }
            />
          </Stack.Item>
        )}
        {customizer.colors.map((color, index) => (
          <Stack.Item key={`${customizer.type}-color-${index}`}>
            <Button
              fluid
              style={{
                backgroundColor: color.startsWith('#') ? color : `#${color}`,
              }}
              onClick={() =>
                act('set_customizer_color', {
                  customizer: customizer.type,
                  color_index: index + 1,
                })
              }
            >
              {customizer.color_labels[index] || `Color ${index + 1}`}
            </Button>
          </Stack.Item>
        ))}
      </Stack>
    )}
  </Section>
);

const DescriptorsTab = ({ act, data }) => (
  <Section fill scrollable>
    <Stack vertical>
      <Stack.Item>
        <Section title="Mechanical Descriptions">
          {data.descriptors.length ? (
            <LabeledList>
              {data.descriptors.map((descriptor) => (
                <LabeledList.Item
                  key={descriptor.choice_type}
                  label={descriptor.name}
                >
                  <Dropdown
                    fluid
                    selected={descriptor.selected}
                    options={descriptor.options}
                    onSelected={(value) =>
                      act('set_descriptor', {
                        choice_type: descriptor.choice_type,
                        descriptor: value,
                      })
                    }
                  />
                </LabeledList.Item>
              ))}
            </LabeledList>
          ) : (
            <Box color="label">This species has no mechanical descriptors.</Box>
          )}
          <Button
            fluid
            mt={1}
            icon="sliders"
            onClick={() => act('open_descriptors')}
          >
            Edit Custom Descriptors
          </Button>
        </Section>
      </Stack.Item>
      <Stack.Item>
        <Section title="Character Descriptions">
          <LabeledList>
            <LabeledList.Item label="Flavortext">
              <Button
                fluid
                onClick={() =>
                  act('legacy_preference', { preference: 'flavortext' })
                }
              >
                {data.flavortext ? 'Edit description' : 'Write description'}
              </Button>
            </LabeledList.Item>
            <LabeledList.Item label="NSFW Flavortext">
              <Button
                fluid
                onClick={() =>
                  act('legacy_preference', {
                    preference: 'nsfwflavortext',
                  })
                }
              >
                {data.nsfwflavortext ? 'Edit description' : 'Write description'}
              </Button>
            </LabeledList.Item>
            <LabeledList.Item label="OOC Notes">
              <Button
                fluid
                onClick={() =>
                  act('legacy_preference', { preference: 'ooc_notes' })
                }
              >
                {data.ooc_notes ? 'Edit notes' : 'Write notes'}
              </Button>
            </LabeledList.Item>
            <LabeledList.Item label="Headshot">
              <Button
                fluid
                onClick={() =>
                  act('legacy_preference', { preference: 'headshot' })
                }
              >
                {data.headshot_link ? 'Change Headshot' : 'Add Headshot'}
              </Button>
            </LabeledList.Item>
          </LabeledList>
        </Section>
      </Stack.Item>
      <Stack.Item>
        <Section title="Character Creator Actions">
          <Button fluid icon="dice" onClick={() => act('randomize_character')}>
            Randomize Characteristics
          </Button>
        </Section>
      </Stack.Item>
    </Stack>
  </Section>
);

const ClassTab = ({ act, data }) => (
  <Section fill scrollable title="Class Preferences">
    <Stack vertical>
      <Stack.Item>
        <Section
          title="If Your Preferred Class Is Unavailable"
          buttons={
            <Button icon="shuffle" onClick={() => act('toggle_jobless_role')}>
              {data.jobless_role}
            </Button>
          }
        >
          Choose whether to return to the lobby or be assigned a random role.
        </Section>
      </Stack.Item>
      {data.class_roles.map((role) => (
        <Stack.Item key={role.title}>
          <Section
            title={role.name}
            buttons={<Box color="label">{role.department}</Box>}
          >
            <Stack align="center">
              <Stack.Item grow>
                <Box color={role.locked ? 'bad' : 'label'}>
                  {role.locked
                    ? role.reason
                    : `${role.slots} slot${role.slots === 1 ? '' : 's'} available`}
                </Box>
                {role.tutorial && <Box mt={0.5}>{role.tutorial}</Box>}
              </Stack.Item>
              <Stack.Item>
                <Stack>
                  {[
                    { label: 'High', value: 3 },
                    { label: 'Medium', value: 2 },
                    { label: 'Low', value: 1 },
                    { label: 'Never', value: 0 },
                  ].map(({ label, value }) => (
                    <Stack.Item key={label}>
                      <Button
                        selected={role.priority === value}
                        disabled={role.locked}
                        onClick={() =>
                          act('set_job_priority', {
                            job: role.title,
                            priority: value,
                          })
                        }
                      >
                        {label}
                      </Button>
                    </Stack.Item>
                  ))}
                </Stack>
              </Stack.Item>
            </Stack>
          </Section>
        </Stack.Item>
      ))}
      {!data.class_roles.length && (
        <Stack.Item>
          <Box color="label">No class preferences are currently available.</Box>
        </Stack.Item>
      )}
      <Stack.Item>
        <Button
          fluid
          onClick={() =>
            act('legacy_preference', { preference: 'subclassoutfit' })
          }
        >
          Preview Subclass Outfit
        </Button>
      </Stack.Item>
    </Stack>
  </Section>
);

const VillainTab = ({ act, data }) => (
  <Section fill scrollable title="Villain Preferences">
    <Box mb={1}>
      Choose which villain roles you are willing to play. Availability and bans
      are enforced by the server.
    </Box>
    <Stack vertical>
      {data.villain_roles.map((role) => (
        <Stack.Item key={role.name}>
          <Section title={role.name}>
            <Stack align="center">
              <Stack.Item grow color={role.locked ? 'bad' : 'label'}>
                {role.reason || (role.enabled ? 'Enabled' : 'Disabled')}
              </Stack.Item>
              <Stack.Item>
                <Button.Checkbox
                  checked={role.enabled}
                  selected={role.enabled}
                  disabled={role.locked}
                  onClick={() =>
                    act('toggle_villain_role', { role: role.name })
                  }
                >
                  {role.enabled ? 'Enabled' : 'Disabled'}
                </Button.Checkbox>
              </Stack.Item>
            </Stack>
          </Section>
        </Stack.Item>
      ))}
      {!data.villain_roles.length && (
        <Stack.Item>
          <Box color="label">No villain roles are currently configured.</Box>
        </Stack.Item>
      )}
    </Stack>
  </Section>
);

const KeybindingsTab = ({ act, data }) => {
  const [search, setSearch] = useState('');
  const normalizedSearch = search.trim().toLowerCase();
  const keybindings = data.keybindings.filter(
    (keybinding) =>
      !normalizedSearch ||
      keybinding.full_name.toLowerCase().includes(normalizedSearch) ||
      keybinding.category.toLowerCase().includes(normalizedSearch),
  );
  const categories: string[] = Array.from(
    new Set<string>(keybindings.map(({ category }) => category)),
  );

  return (
    <Section
      fill
      scrollable
      title="Keybindings"
      buttons={
        <Button icon="rotate-left" onClick={() => act('reset_keybindings')}>
          Reset to Defaults
        </Button>
      }
    >
      <Box mb={1}>
        Select a binding to capture a key. Use Escape in the capture window to
        clear a binding.
      </Box>
      <Input
        fluid
        mb={1}
        placeholder="Search keybindings"
        value={search}
        onChange={setSearch}
      />
      <Stack vertical>
        {categories.map((category) => (
          <Stack.Item key={category}>
            <Section title={category}>
              <Stack vertical>
                {keybindings
                  .filter((keybinding) => keybinding.category === category)
                  .map((keybinding) => (
                    <Stack.Item key={keybinding.name}>
                      <Stack align="center">
                        <Stack.Item grow>
                          <Box bold>{keybinding.full_name}</Box>
                          <Box color="label">
                            {keybinding.description || 'No description'}
                          </Box>
                          <Box color="label">
                            Default:{' '}
                            {keybinding.default_keys.join(', ') || 'Unbound'}
                          </Box>
                        </Stack.Item>
                        <Stack.Item>
                          <Stack>
                            {keybinding.user_keys.map((key) => (
                              <Stack.Item key={key}>
                                <Button
                                  onClick={() =>
                                    act('capture_keybinding', {
                                      keybinding: keybinding.name,
                                      old_key: key,
                                    })
                                  }
                                >
                                  {key}
                                </Button>
                              </Stack.Item>
                            ))}
                            {keybinding.can_add && (
                              <Stack.Item>
                                <Button
                                  icon="plus"
                                  onClick={() =>
                                    act('capture_keybinding', {
                                      keybinding: keybinding.name,
                                    })
                                  }
                                >
                                  Add
                                </Button>
                              </Stack.Item>
                            )}
                          </Stack>
                        </Stack.Item>
                      </Stack>
                    </Stack.Item>
                  ))}
              </Stack>
            </Section>
          </Stack.Item>
        ))}
      </Stack>
    </Section>
  );
};

const SlotManager = ({ act, data }) => {
  const [sourceSlot, setSourceSlot] = useState(`${data.active_slot}`);
  const [targetSlot, setTargetSlot] = useState(
    `${data.character_slots.find((slot) => slot.empty)?.index || data.active_slot}`,
  );
  const slotOptions = data.character_slots.map(({ index }) => `${index}`);

  useEffect(() => {
    setSourceSlot(`${data.active_slot}`);
  }, [data.active_slot]);

  return (
    <Section fill scrollable title="Character Slots">
      <Section title="Copy Character">
        <Stack align="center">
          <Stack.Item grow>
            <LabeledList>
              <LabeledList.Item label="From">
                <Dropdown
                  fluid
                  selected={sourceSlot}
                  options={slotOptions}
                  onSelected={setSourceSlot}
                />
              </LabeledList.Item>
              <LabeledList.Item label="To">
                <Dropdown
                  fluid
                  selected={targetSlot}
                  options={slotOptions}
                  onSelected={setTargetSlot}
                />
              </LabeledList.Item>
            </LabeledList>
          </Stack.Item>
          <Stack.Item>
            <Button
              icon="copy"
              disabled={
                sourceSlot === targetSlot ||
                data.character_slots.find(
                  (slot) => `${slot.index}` === sourceSlot,
                )?.empty
              }
              onClick={() =>
                act('copy_character_slot', {
                  from: Number(sourceSlot),
                  to: Number(targetSlot),
                })
              }
            >
              Copy
            </Button>
          </Stack.Item>
        </Stack>
      </Section>
      <Section title="Favorite Order">
        {!data.favorited_slots.length ? (
          <Box color="label">
            Favorite slots to pin them here for quick access.
          </Box>
        ) : (
          <Stack>
            {data.favorited_slots.map((index, position) => (
              <Stack.Item key={index}>
                <Button
                  icon="arrow-up"
                  disabled={position === 0}
                  onClick={() =>
                    act('move_favorite_slot', { index, direction: 'up' })
                  }
                />
                <Button
                  icon="arrow-down"
                  disabled={position === data.favorited_slots.length - 1}
                  onClick={() =>
                    act('move_favorite_slot', { index, direction: 'down' })
                  }
                >
                  Slot {index}
                </Button>
              </Stack.Item>
            ))}
          </Stack>
        )}
      </Section>
      <Stack vertical>
        {data.character_slots.map((slot) => (
          <Stack.Item key={slot.index}>
            <Section
              title={`Slot ${slot.index}: ${slot.name}`}
              buttons={
                <Button.Checkbox
                  checked={slot.favorite}
                  selected={slot.favorite}
                  onClick={() =>
                    act('toggle_favorite_slot', { index: slot.index })
                  }
                >
                  Favorite
                </Button.Checkbox>
              }
            >
              <Stack align="center">
                <Stack.Item grow color="label">
                  {slot.empty
                    ? 'Empty'
                    : `${slot.species || 'Unknown species'}${slot.active ? ' · Active' : ''}`}
                </Stack.Item>
                <Stack.Item>
                  <Button
                    icon="user-check"
                    selected={slot.active}
                    onClick={() =>
                      act('select_character_slot', { index: slot.index })
                    }
                  >
                    {slot.active ? 'Selected' : 'Load'}
                  </Button>
                  <Button
                    icon="trash"
                    disabled={slot.empty || slot.active}
                    onClick={() =>
                      act('delete_character_slot', { index: slot.index })
                    }
                  >
                    Delete
                  </Button>
                </Stack.Item>
              </Stack>
            </Section>
          </Stack.Item>
        ))}
      </Stack>
    </Section>
  );
};
