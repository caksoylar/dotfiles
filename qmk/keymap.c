#include QMK_KEYBOARD_H

#define _QWERTY 0
#define _LOWER 1
#define _RAISE 2
#define _TMUX 3

#define LW_SPC LT(_LOWER, KC_SPC)
#define TM_GRV LT(_TMUX, KC_GRV)
#define LC_MIN LCTL_T(KC_MINS)
#define LA_EQL LALT_T(KC_EQL)
#define CT_DEL LCTL(KC_DEL)
#define ST_DEL LSFT(KC_DEL)
#define ST_INS LSFT(KC_INS)
#define CT_F4 LCTL(KC_F4)
#define ALT_F4 LALT(KC_F4)
#define LCG_LT LCTL(LGUI(KC_LEFT))
#define LCG_RT LCTL(LGUI(KC_RGHT))

const uint16_t PROGMEM keymaps[][MATRIX_ROWS][MATRIX_COLS] = {
    [_QWERTY] = LAYOUT(
    //┌────────┬────────┬────────┬────────┬────────┬────────┐                          ┌────────┬────────┬────────┬────────┬────────┬────────┐
       TM_GRV,  KC_1,    KC_2,    KC_3,    KC_4,    KC_5,                               KC_6,    KC_7,    KC_8,    KC_9,    KC_0,    KC_BSPC,
    //├────────┼────────┼────────┼────────┼────────┼────────┤                          ├────────┼────────┼────────┼────────┼────────┼────────┤
       KC_TAB,  KC_Q,    KC_W,    KC_E,    KC_R,    KC_T,                               KC_Y,    KC_U,    KC_I,    KC_O,    KC_P,    KC_BSLS,
    //├────────┼────────┼────────┼────────┼────────┼────────┤                          ├────────┼────────┼────────┼────────┼────────┼────────┤
       KC_ESC,  KC_A,    KC_S,    KC_D,    KC_F,    KC_G,                               KC_H,    KC_J,    KC_K,    KC_L,    KC_SCLN, KC_QUOT,
    //├────────┼────────┼────────┼────────┼────────┼────────┼────────┐        ┌────────┼────────┼────────┼────────┼────────┼────────┼────────┤
       KC_LSFT, KC_Z,    KC_X,    KC_C,    KC_V,    KC_B,    KC_MPLY,          KC_NO,   KC_N,    KC_M,    KC_COMM, KC_DOT,  KC_SLSH, MO(_RAISE),
    //└────────┴────────┴────────┴───┬────┴───┬────┴───┬────┴───┬────┘        └───┬────┴───┬────┴───┬────┴───┬────┴────────┴────────┴────────┘
                                      LC_MIN,  KC_LGUI, LA_EQL,                    LW_SPC,  KC_ENT,  KC_RSFT
                                  // └────────┴────────┴────────┘                 └────────┴────────┴────────┘
    ),

    [_LOWER] = LAYOUT(
    //┌────────┬────────┬────────┬────────┬────────┬────────┐                          ┌────────┬────────┬────────┬────────┬────────┬────────┐
       _______, _______, _______, _______, _______, KC_LPRN,                            KC_RPRN, _______, _______, KC_MINS, KC_EQL,  KC_INS,
    //├────────┼────────┼────────┼────────┼────────┼────────┤                          ├────────┼────────┼────────┼────────┼────────┼────────┤
       _______, ALT_F4,  CT_F4,   _______, _______, KC_LBRC,                            KC_RBRC, _______, _______, KC_UNDS, KC_PLUS, KC_DEL,
    //├────────┼────────┼────────┼────────┼────────┼────────┤                          ├────────┼────────┼────────┼────────┼────────┼────────┤
       _______, LCG_LT,  _______, LCG_RT,  _______, _______,                            KC_LEFT, KC_DOWN, KC_UP,   KC_RGHT, KC_HOME, KC_PGUP,
    //├────────┼────────┼────────┼────────┼────────┼────────┼────────┐        ┌────────┼────────┼────────┼────────┼────────┼────────┼────────┤
       _______, _______, CT_DEL,  ST_DEL,  ST_INS,  KC_LCBR, _______,          _______, KC_RCBR, _______, _______, _______, KC_END,  KC_PGDN,
    //└────────┴────────┴────────┴───┬────┴───┬────┴───┬────┴───┬────┘        └───┬────┴───┬────┴───┬────┴───┬────┴────────┴────────┴────────┘
                                      _______, _______, _______,                   KC_TRNS, _______, KC_APP
                                  // └────────┴────────┴────────┘                 └────────┴────────┴────────┘
    ),

    [_RAISE] = LAYOUT(
    //┌────────┬────────┬────────┬────────┬────────┬────────┐                          ┌────────┬────────┬────────┬────────┬────────┬────────┐
       KC_F12,  KC_F1,   KC_F2,   KC_F3,   KC_F4,   KC_F5,                              KC_F6,   KC_F7,   KC_F8,   KC_F9,   KC_F10,  KC_F11,
    //├────────┼────────┼────────┼────────┼────────┼────────┤                          ├────────┼────────┼────────┼────────┼────────┼────────┤
       RGB_TOG, _______, _______, _______, _______, _______,                            _______, _______, _______, _______, _______, _______,
    //├────────┼────────┼────────┼────────┼────────┼────────┤                          ├────────┼────────┼────────┼────────┼────────┼────────┤
       RGB_MOD, _______, _______, _______, _______, _______,                            _______, _______, RGB_HUI, RGB_SAI, RGB_VAI, _______,
    //├────────┼────────┼────────┼────────┼────────┼────────┼────────┐        ┌────────┼────────┼────────┼────────┼────────┼────────┼────────┤
       RGB_RMOD,KC_MPRV, KC_MNXT, KC_CALC, _______, _______, _______,          _______, _______, _______, RGB_HUD, RGB_SAD, RGB_VAD, KC_TRNS,
    //└────────┴────────┴────────┴───┬────┴───┬────┴───┬────┴───┬────┘        └───┬────┴───┬────┴───┬────┴───┬────┴────────┴────────┴────────┘
                                      _______, _______, _______,                   _______, _______, _______
                                  // └────────┴────────┴────────┘                 └────────┴────────┴────────┘
    ),

    [_TMUX] = LAYOUT(
    //┌────────┬────────┬────────┬────────┬────────┬────────┐                          ┌────────┬────────┬────────┬────────┬────────┬────────┐
       _______, _______, _______, _______, _______, _______,                            _______, _______, _______, _______, _______, _______,
    //├────────┼────────┼────────┼────────┼────────┼────────┤                          ├────────┼────────┼────────┼────────┼────────┼────────┤
       _______, _______, _______, _______, _______, _______,                            _______, _______, _______, _______, _______, _______,
    //├────────┼────────┼────────┼────────┼────────┼────────┤                          ├────────┼────────┼────────┼────────┼────────┼────────┤
       _______, _______, _______, _______, _______, _______,                            _______, _______, _______, _______, _______, _______,
    //├────────┼────────┼────────┼────────┼────────┼────────┼────────┐        ┌────────┼────────┼────────┼────────┼────────┼────────┼────────┤
       _______, _______, _______, _______, _______, _______, _______,          _______, _______, _______, _______, _______, _______, _______,
    //└────────┴────────┴────────┴───┬────┴───┬────┴───┬────┴───┬────┘        └───┬────┴───┬────┴───┬────┴───┬────┴────────┴────────┴────────┘
                                      _______, _______, _______,                   _______, _______, _______
                                  // └────────┴────────┴────────┘                 └────────┴────────┴────────┘
    )
};

bool process_record_user(uint16_t keycode, keyrecord_t *record) {
    if (IS_LAYER_ON(_TMUX)) {
        if (record->event.pressed) {
            tap_code16(LCTL(KC_SPC));
            wait_ms(10);
            tap_code(keycode);
        }
        /*else
            layer_off(_TMUX);*/
        return false;
    }
    return true;
}

#ifdef ENCODER_ENABLE
void encoder_update_user(uint8_t index, bool clockwise) {
    if (index == 0) {
        switch (get_highest_layer(layer_state)) {
            case _LOWER:
                clockwise ? tap_code(KC_AUDIO_VOL_UP) : tap_code(KC_AUDIO_VOL_DOWN);
                break;
            case _RAISE:
                clockwise ? rgblight_increase_hue() : rgblight_decrease_hue();
                break;
            default:
                clockwise ? tap_code(KC_MS_WH_DOWN) : tap_code(KC_MS_WH_UP);
                break;
        }
    }
}
#endif  // ENCODER_ENABLE
