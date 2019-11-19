#include QMK_KEYBOARD_H

const uint16_t PROGMEM keymaps[][MATRIX_ROWS][MATRIX_COLS] = {
	[0] = LAYOUT(KC_GRV, KC_1, KC_2, KC_3, KC_4, KC_5, KC_6, KC_7, KC_8, KC_9, KC_0, KC_BSPC, KC_TAB, KC_Q, KC_W, KC_E, KC_R, KC_T, KC_Y, KC_U, KC_I, KC_O, KC_P, KC_BSLS, KC_ESC, KC_A, KC_S, KC_D, KC_F, KC_G, KC_H, KC_J, KC_K, KC_L, KC_SCLN, KC_QUOT, KC_LSFT, KC_Z, KC_X, KC_C, KC_V, KC_B, KC_MPLY, KC_NO, KC_N, KC_M, KC_COMM, KC_DOT, KC_SLSH, MO(2), KC_LCTL, KC_LGUI, KC_LALT, LT(1,KC_SPC), KC_ENT, KC_RSFT),
	[1] = LAYOUT(KC_NO, KC_NO, KC_NO, KC_NO, KC_NO, KC_LPRN, KC_RPRN, KC_NO, KC_NO, KC_MINS, KC_EQL, KC_INS, KC_NO, KC_NO, KC_NO, KC_NO, KC_NO, KC_LBRC, KC_RBRC, KC_NO, KC_NO, KC_UNDS, KC_PLUS, KC_DEL, KC_NO, KC_NO, KC_NO, KC_NO, KC_NO, KC_NO, KC_LEFT, KC_DOWN, KC_UP, KC_RGHT, KC_HOME, KC_PGUP, KC_NO, KC_NO, LCTL(KC_DEL), LCTL(KC_INS), LSFT(KC_INS), KC_LCBR, KC_NO, KC_NO, KC_RCBR, KC_NO, KC_NO, KC_NO, KC_END, KC_PGDN, KC_NO, KC_NO, KC_NO, KC_TRNS, KC_NO, KC_APP),
	[2] = LAYOUT(KC_F12, KC_F1, KC_F2, KC_F3, KC_F4, KC_F5, KC_F6, KC_F7, KC_F8, KC_F9, KC_F10, KC_F11, RGB_TOG, KC_NO, KC_NO, KC_NO, KC_NO, KC_NO, KC_NO, KC_NO, KC_NO, KC_NO, KC_NO, KC_NO, RGB_MOD, KC_NO, KC_NO, KC_NO, KC_NO, KC_NO, KC_NO, KC_NO, RGB_HUI, RGB_SAI, RGB_VAI, KC_NO, RGB_RMOD, KC_MPRV, KC_MNXT, KC_CALC, KC_NO, KC_NO, KC_NO, KC_NO, KC_NO, KC_NO, RGB_HUD, RGB_SAD, RGB_VAD, KC_TRNS, KC_NO, KC_NO, KC_NO, KC_NO, KC_NO, KC_NO)
};

#ifdef ENCODER_ENABLE
void encoder_update_user(uint8_t index, bool clockwise) {
    if (index == 0) {
        switch (biton32(layer_state)) {
            case 1:
                clockwise ? tap_code(KC_AUDIO_VOL_DOWN) : tap_code(KC_AUDIO_VOL_UP);
                break;
            case 2:
                clockwise ? rgblight_decrease_hue() : rgblight_increase_hue();
                break;
            default:
                clockwise ? tap_code(KC_MS_WH_UP) : tap_code(KC_MS_WH_DOWN);
                break;
        }
    }
}
#endif  // ENCODER_ENABLE
