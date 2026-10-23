import { useBackend } from 'tgui/backend';
import { Window } from 'tgui/layouts';
import { Box, Button, Section, Stack } from 'tgui-core/components';

type LobbyClass = {
  department: string;
  job: string;
  players: string[];
};

type LateJoinRole = {
  available_slots: number;
  department: string;
  name: string;
  title: string;
  tutorial: string;
  unlimited: boolean;
};

type LobbyData = {
  can_late_join: boolean;
  late_join_disabled: boolean;
  late_join_menu_open: boolean;
  late_join_roles: LateJoinRole[];
  motd: string;
  ready: number;
  ready_classes: LobbyClass[];
  ready_count: number;
  ready_to_observe: number;
  ready_to_play: number;
  not_ready: number;
  round_started: boolean;
  timer_status: string;
};

export const NewPlayerPanel = () => {
  const { act, data } = useBackend<LobbyData>();
  const ready = data.ready === data.ready_to_play;

  return (
    <Window title="Ratwood Lobby" width={850} height={650}>
      <Window.Content>
        <Stack fill vertical>
          <Stack.Item>
            <Section
              title={
                data.round_started
                  ? 'The Round Is In Progress'
                  : 'The Round Is Starting'
              }
            >
              <Stack align="center">
                <Stack.Item grow>
                  <Box fontSize={1.4}>{data.timer_status}</Box>
                  <Box color="label">
                    {data.ready_count} player{data.ready_count === 1 ? '' : 's'}{' '}
                    ready
                  </Box>
                </Stack.Item>
                {!data.round_started ? (
                  <>
                    <Stack.Item>
                      <Button
                        icon={ready ? 'circle-minus' : 'circle-check'}
                        color={ready ? 'bad' : 'good'}
                        onClick={() =>
                          act('set_ready', {
                            state: ready ? data.not_ready : data.ready_to_play,
                          })
                        }
                      >
                        {ready ? 'Unready' : 'Ready'}
                      </Button>
                    </Stack.Item>
                    <Stack.Item>
                      <Button
                        icon="eye"
                        selected={data.ready === data.ready_to_observe}
                        onClick={() =>
                          act('set_ready', { state: data.ready_to_observe })
                        }
                      >
                        Observe
                      </Button>
                    </Stack.Item>
                  </>
                ) : (
                  <>
                    <Stack.Item>
                      <Button
                        icon="door-open"
                        color="good"
                        disabled={
                          !data.can_late_join || data.late_join_disabled
                        }
                        onClick={() => act('late_join')}
                      >
                        Late Join
                      </Button>
                    </Stack.Item>
                    <Stack.Item>
                      <Button icon="eye" onClick={() => act('observe')}>
                        Observe
                      </Button>
                    </Stack.Item>
                  </>
                )}
              </Stack>
            </Section>
          </Stack.Item>
          {data.motd && (
            <Stack.Item>
              <Section title="Message of the Day">
                <Box>{data.motd}</Box>
              </Section>
            </Stack.Item>
          )}
          <Stack.Item grow minHeight={0}>
            {data.late_join_menu_open ? (
              <Section
                fill
                scrollable
                title="Choose a Class"
                buttons={
                  <Button
                    icon="arrow-left"
                    onClick={() => act('cancel_late_join')}
                  >
                    Back to Lobby
                  </Button>
                }
              >
                <Stack vertical>
                  {data.late_join_roles.map((role) => (
                    <Stack.Item key={role.title}>
                      <Section
                        title={`${role.department}: ${role.name}`}
                        buttons={
                          <Button
                            icon="door-open"
                            color="good"
                            onClick={() =>
                              act('select_late_join_role', {
                                job: role.title,
                              })
                            }
                          >
                            Join
                          </Button>
                        }
                      >
                        <Box color="label">
                          {role.unlimited
                            ? 'Open positions'
                            : `${role.available_slots} position${role.available_slots === 1 ? '' : 's'} available`}
                        </Box>
                        {role.tutorial && <Box mt={0.5}>{role.tutorial}</Box>}
                      </Section>
                    </Stack.Item>
                  ))}
                  {!data.late_join_roles.length && (
                    <Stack.Item>
                      <Box color="label">
                        No classes are currently available for late joining.
                      </Box>
                    </Stack.Item>
                  )}
                </Stack>
              </Section>
            ) : (
              <Section fill scrollable title="Ready Classes">
                {data.ready_classes.length ? (
                  <Stack vertical>
                    {data.ready_classes.map((entry) => (
                      <Stack.Item key={`${entry.department}-${entry.job}`}>
                        <Section title={`${entry.department}: ${entry.job}`}>
                          {entry.players.join(', ')}
                        </Section>
                      </Stack.Item>
                    ))}
                  </Stack>
                ) : (
                  <Box color="label">
                    Ready players with a preferred class will appear here.
                  </Box>
                )}
              </Section>
            )}
          </Stack.Item>
          <Stack.Item>
            <Stack>
              <Stack.Item grow>
                <Button
                  fluid
                  icon="user-pen"
                  onClick={() => act('open_character')}
                >
                  Character
                </Button>
              </Stack.Item>
              <Stack.Item grow>
                <Button fluid icon="gear" onClick={() => act('open_settings')}>
                  Settings
                </Button>
              </Stack.Item>
              <Stack.Item grow>
                <Button fluid icon="list" onClick={() => act('open_manifest')}>
                  Manifest
                </Button>
              </Stack.Item>
              <Stack.Item grow>
                <Button
                  fluid
                  icon="book-open"
                  onClick={() => act('open_changelog')}
                >
                  Changelog
                </Button>
              </Stack.Item>
            </Stack>
          </Stack.Item>
        </Stack>
      </Window.Content>
    </Window>
  );
};
