Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47BEB739384
	for <lists+linux-nfs@lfdr.de>; Thu, 22 Jun 2023 02:05:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230267AbjFVAFg (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 21 Jun 2023 20:05:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231284AbjFVAFV (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 21 Jun 2023 20:05:21 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BD111FF6
        for <linux-nfs@vger.kernel.org>; Wed, 21 Jun 2023 17:04:52 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-3129c55e1d1so19281f8f.0
        for <linux-nfs@vger.kernel.org>; Wed, 21 Jun 2023 17:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687392217; x=1689984217;
        h=autocrypt:subject:from:to:content-language:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=IhNywDV9X2n8iEOdHi0Od9BqO5JN/SHtopjAtx8syYw=;
        b=qUq70+z0gUr12P0BgI2jvolrq8MzcshytkIkzTu1TvUj+yKT3mYs93FDUuslAqKfI6
         uwRF93MBjKKqcOrFWHxjIVzLFf7dvxTa4A87BBrmTdecrjmGX1ZGtUNrDLey6o71+KGF
         tF91xbpgVBNiy59tIjL30bINJb0wCQVCe8fUdwbdSz+0AznA+n2PU8Cx2rGo9B24Qz9z
         twrf5tu41ufJ6Rv08RWN61APzBI+f+8XGN/yEz54Yxq3v0OGa6fWUuPMQVKUxQAwCZsN
         3vyilYUUKO9ATZGiTZc3Y/KidkT+fHkER4HZR7AvNS8+5V6eJX+xwGxqpPSsvz6BRWm5
         tBjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687392217; x=1689984217;
        h=autocrypt:subject:from:to:content-language:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IhNywDV9X2n8iEOdHi0Od9BqO5JN/SHtopjAtx8syYw=;
        b=JVll+gajmWu1ACLso6SD1QPJTZHDrO73Ufpq5MFUUZCPBXce/TxpDEl5xNRTjZ8JIo
         3uupvLKSPkjB+ygsn9l99eedLDN5Ck9UBtAjpg9//NdjGOcVGttTy48yyuQNCdEtBVE0
         KTVPNo5EVl3V0PY11hRItMGriudc7vkzwXgk/Ug6MGKcx+3XY6f/1nTFgitRmfIpnyGn
         bCpuV8GRjqmwdwQOqkQWRkjz96ZmRRHUDZ+VcBg6Ft8/GPiqMraDIsG+U5jPRmL6I3kP
         UbNAClyTvNsV7mfek/8D5UzsGLi8+xci105dEVnJs5cv/KQKwFRpYwEa+1gT5YMWlGcj
         8REg==
X-Gm-Message-State: AC+VfDw89DkzFlFw0l2okIifGLHhLfygUUOsSvKpJqfOIXigRtsQR8/L
        dV2OxO/vau7LJe2VavfPIY4Zf+HNdKY=
X-Google-Smtp-Source: ACHHUZ5OcgBNzSE1f+7tXVTTlGPMrBK2Be/HoyTkr7lNKziW94CuzHJw50Qq2tIDbMYLYVTP8LKJGA==
X-Received: by 2002:a5d:4149:0:b0:311:1b83:e1e4 with SMTP id c9-20020a5d4149000000b003111b83e1e4mr15906044wrq.5.1687392217206;
        Wed, 21 Jun 2023 17:03:37 -0700 (PDT)
Received: from [10.55.2.20] (178.pool95-22-72.dynamic.orange.es. [95.22.72.178])
        by smtp.gmail.com with ESMTPSA id f20-20020a7bcc14000000b003f8044b3436sm17170377wmh.23.2023.06.21.17.03.36
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Jun 2023 17:03:36 -0700 (PDT)
Message-ID: <c8926a74-3a4f-9922-b064-3810fbb539ba@gmail.com>
Date:   Thu, 22 Jun 2023 02:03:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Content-Language: en-US, es
To:     linux-nfs@vger.kernel.org
From:   "David C. Manuelda" <stormbyte@gmail.com>
Subject: [PATCH] Fix building with musl as libc
Autocrypt: addr=stormbyte@gmail.com; keydata=
 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
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------xgeIHNDXs0v73ZY1kGCAmvw4"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------xgeIHNDXs0v73ZY1kGCAmvw4
Content-Type: multipart/mixed; boundary="------------549rj9dCtRR202U5curOeb0P";
 protected-headers="v1"
From: "David C. Manuelda" <stormbyte@gmail.com>
To: linux-nfs@vger.kernel.org
Message-ID: <c8926a74-3a4f-9922-b064-3810fbb539ba@gmail.com>
Subject: [PATCH] Fix building with musl as libc

--------------549rj9dCtRR202U5curOeb0P
Content-Type: multipart/mixed; boundary="------------5EXI46hsd4B5slHumY4MMKE5"

--------------5EXI46hsd4B5slHumY4MMKE5
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

IEZyb20gMTRhZWU5ODI1NTg0NWM4OTEwMGM0MGU0NTQzMDQ0NWVhNzM4ZDViNCBNb24gU2Vw
IDE3IDAwOjAwOjAwIDIwMDENCkZyb206IERhdmlkIENhcmxvcyBNYW51ZWxkYSA8U3Rvcm1C
eXRlQGdtYWlsLmNvbT4NCkRhdGU6IFRodSwgMjIgSnVuIDIwMjMgMDE6NTg6MDEgKzAyMDAN
ClN1YmplY3Q6IFtQQVRDSF0gRml4IG11c2wrY2xhbmcgY29tcGlsZToNCg0KKiBSZXBsYWNl
IF9fYXR0cmlidXRlX21hbGxvY19fIHdpdGggX19hdHRyaWJ1dGVfXygoX19tYWxsb2NfXykp
DQoqIFRoZSBBTExQRVJNUyBkZWZpbmUgaXMgbm90IHNwZWNpZmllZCBpbiBQT1NJWCBzbyBk
ZWZpbmUgdGhlbSBhcyBleHBlY3RlZA0KLS0tDQogwqBzdXBwb3J0L2luY2x1ZGUvanVuY3Rp
b24uaMKgwqAgfMKgIDIgKy0NCiDCoHN1cHBvcnQvanVuY3Rpb24vanVuY3Rpb24uY8KgIHzC
oCAzICsrKw0KIMKgc3VwcG9ydC9qdW5jdGlvbi9sb2NhdGlvbnMuYyB8wqAgMiArLQ0KIMKg
c3VwcG9ydC9qdW5jdGlvbi9uZnMuY8KgwqDCoMKgwqDCoCB8wqAgMyArKysNCiDCoHN1cHBv
cnQvanVuY3Rpb24vcGF0aC5jwqDCoMKgwqDCoCB8IDEwICsrKysrKysrKy0NCiDCoDUgZmls
ZXMgY2hhbmdlZCwgMTcgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCg0KZGlmZiAt
LWdpdCBhL3N1cHBvcnQvaW5jbHVkZS9qdW5jdGlvbi5oIGIvc3VwcG9ydC9pbmNsdWRlL2p1
bmN0aW9uLmgNCmluZGV4IDcyNTdkODAuLjQzMTA1YWEgMTAwNjQ0DQotLS0gYS9zdXBwb3J0
L2luY2x1ZGUvanVuY3Rpb24uaA0KKysrIGIvc3VwcG9ydC9pbmNsdWRlL2p1bmN0aW9uLmgN
CkBAIC0xMjUsNyArMTI1LDcgQEAgdm9pZMKgwqDCoCDCoMKgwqAgwqAgbmZzX2ZyZWVfbG9j
YXRpb24oc3RydWN0IG5mc19mc2xvYyANCipsb2NhdGlvbik7DQogwqB2b2lkwqDCoMKgIMKg
wqDCoCDCoCBuZnNfZnJlZV9sb2NhdGlvbnMoc3RydWN0IG5mc19mc2xvYyAqbG9jYXRpb25z
KTsNCiDCoHN0cnVjdCBuZnNfZnNsb2MgKm5mc19uZXdfbG9jYXRpb24odm9pZCk7DQoNCi1f
X2F0dHJpYnV0ZV9tYWxsb2NfXw0KK19fYXR0cmlidXRlX18oKF9fbWFsbG9jX18pKQ0KIMKg
Y2hhcsKgwqDCoCDCoMKgwqAgKipuZnNfZHVwX3N0cmluZ19hcnJheShjaGFyICoqYXJyYXkp
Ow0KIMKgdm9pZMKgwqDCoCDCoMKgwqAgwqAgbmZzX2ZyZWVfc3RyaW5nX2FycmF5KGNoYXIg
KiphcnJheSk7DQoNCmRpZmYgLS1naXQgYS9zdXBwb3J0L2p1bmN0aW9uL2p1bmN0aW9uLmMg
Yi9zdXBwb3J0L2p1bmN0aW9uL2p1bmN0aW9uLmMNCmluZGV4IDA2MjhiYjAuLjRjNDM2Njcg
MTAwNjQ0DQotLS0gYS9zdXBwb3J0L2p1bmN0aW9uL2p1bmN0aW9uLmMNCisrKyBiL3N1cHBv
cnQvanVuY3Rpb24vanVuY3Rpb24uYw0KQEAgLTI5LDYgKzI5LDkgQEANCg0KIMKgI2luY2x1
ZGUgPHN5cy90eXBlcy5oPg0KIMKgI2luY2x1ZGUgPHN5cy9zdGF0Lmg+DQorI2lmbmRlZiBB
TExQRVJNUw0KKyNkZWZpbmUgQUxMUEVSTVMgKFNfSVNVSUR8U19JU0dJRHxTX0lTVlRYfFNf
SVJXWFV8U19JUldYR3xTX0lSV1hPKQ0KKyNlbmRpZg0KDQogwqAjaW5jbHVkZSA8c3RkYm9v
bC5oPg0KIMKgI2luY2x1ZGUgPHN0ZGlvLmg+DQpkaWZmIC0tZ2l0IGEvc3VwcG9ydC9qdW5j
dGlvbi9sb2NhdGlvbnMuYyBiL3N1cHBvcnQvanVuY3Rpb24vbG9jYXRpb25zLmMNCmluZGV4
IGM1Nzc5ODEuLmU3YmMyMWQgMTAwNjQ0DQotLS0gYS9zdXBwb3J0L2p1bmN0aW9uL2xvY2F0
aW9ucy5jDQorKysgYi9zdXBwb3J0L2p1bmN0aW9uL2xvY2F0aW9ucy5jDQpAQCAtNjMsNyAr
NjMsNyBAQCBuZnNfZnJlZV9zdHJpbmdfYXJyYXkoY2hhciAqKmFycmF5KQ0KIMKgICoNCiDC
oCAqIENhbGxlciBtdXN0IGZyZWUgdGhlIHJldHVybmVkIGFycmF5IHdpdGggbmZzX2ZyZWVf
c3RyaW5nX2FycmF5KCkNCiDCoCAqLw0KLV9fYXR0cmlidXRlX21hbGxvY19fIGNoYXIgKioN
CitfX2F0dHJpYnV0ZV9fKChfX21hbGxvY19fKSkgY2hhciAqKg0KIMKgbmZzX2R1cF9zdHJp
bmdfYXJyYXkoY2hhciAqKmFycmF5KQ0KIMKgew0KIMKgwqDCoMKgIHVuc2lnbmVkIGludCBz
aXplLCBpOw0KZGlmZiAtLWdpdCBhL3N1cHBvcnQvanVuY3Rpb24vbmZzLmMgYi9zdXBwb3J0
L2p1bmN0aW9uL25mcy5jDQppbmRleCA3M2UzNTMzLi4wNjk2MGVlIDEwMDY0NA0KLS0tIGEv
c3VwcG9ydC9qdW5jdGlvbi9uZnMuYw0KKysrIGIvc3VwcG9ydC9qdW5jdGlvbi9uZnMuYw0K
QEAgLTcwLDYgKzcwLDkgQEANCg0KIMKgI2luY2x1ZGUgPHN5cy90eXBlcy5oPg0KIMKgI2lu
Y2x1ZGUgPHN5cy9zdGF0Lmg+DQorI2lmbmRlZiBBTExQRVJNUw0KKyNkZWZpbmUgQUxMUEVS
TVMgKFNfSVNVSUR8U19JU0dJRHxTX0lTVlRYfFNfSVJXWFV8U19JUldYR3xTX0lSV1hPKQ0K
KyNlbmRpZg0KDQogwqAjaW5jbHVkZSA8c3RkYm9vbC5oPg0KIMKgI2luY2x1ZGUgPHN0ZGlv
Lmg+DQpkaWZmIC0tZ2l0IGEvc3VwcG9ydC9qdW5jdGlvbi9wYXRoLmMgYi9zdXBwb3J0L2p1
bmN0aW9uL3BhdGguYw0KaW5kZXggMTNhMTQzOC4uMmFhZDkxNSAxMDA2NDQNCi0tLSBhL3N1
cHBvcnQvanVuY3Rpb24vcGF0aC5jDQorKysgYi9zdXBwb3J0L2p1bmN0aW9uL3BhdGguYw0K
QEAgLTIzLDYgKzIzLDE0IEBADQogwqAgKsKgwqDCoCBodHRwOi8vd3d3LmdudS5vcmcvbGlj
ZW5zZXMvb2xkLWxpY2Vuc2VzL2dwbC0yLjAudHh0DQogwqAgKi8NCg0KKyNpZmRlZiBIQVZF
X0NPTkZJR19IDQorI2luY2x1ZGUgPGNvbmZpZy5oPg0KKyNlbmRpZg0KKw0KKyNpZmRlZiBI
QVZFX0xJTUlUU19IDQorI2luY2x1ZGUgPGxpbWl0cy5oPg0KKyNlbmRpZg0KKw0KIMKgI2lu
Y2x1ZGUgPHN5cy90eXBlcy5oPg0KIMKgI2luY2x1ZGUgPHN5cy9zdGF0Lmg+DQoNCkBAIC05
OSw3ICsxMDcsNyBAQCBuc2RiX2FsbG9jX3plcm9fY29tcG9uZW50X3BhdGhuYW1lKGNoYXIg
KioqcGF0aF9hcnJheSkNCiDCoCAqIFJlbW92ZSBtdWx0aXBsZSBzZXF1ZW50aWFsIHNsYXNo
ZXMgYW5kIGFueSB0cmFpbGluZyBzbGFzaGVzLA0KIMKgICogYnV0IGxlYXZlICIvIiBieSBp
dHNlbGYgYWxvbmUuDQogwqAgKi8NCi1zdGF0aWMgX19hdHRyaWJ1dGVfbWFsbG9jX18gY2hh
ciAqDQorc3RhdGljIF9fYXR0cmlidXRlX18oKF9fbWFsbG9jX18pKSBjaGFyICoNCiDCoG5z
ZGJfbm9ybWFsaXplX3BhdGgoY29uc3QgY2hhciAqcGF0aG5hbWUpDQogwqB7DQogwqDCoMKg
wqAgc2l6ZV90IGksIGosIGxlbjsNCi0tIA0KMi40MS4wDQoNCg==
--------------5EXI46hsd4B5slHumY4MMKE5
Content-Type: application/pgp-keys; name="OpenPGP_0x4EBA943B451A6C63.asc"
Content-Disposition: attachment; filename="OpenPGP_0x4EBA943B451A6C63.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
ivVXbVjtizQ=3D
=3DtHru
-----END PGP PUBLIC KEY BLOCK-----

--------------5EXI46hsd4B5slHumY4MMKE5--

--------------549rj9dCtRR202U5curOeb0P--

--------------xgeIHNDXs0v73ZY1kGCAmvw4
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEEWccGxv57GsMrElb4TrqUO0UabGMFAmSTj9cFAwAAAAAACgkQTrqUO0UabGPU
khAAgaECV+so7VGVjfrImYu9qZg94oOdbP4YgJCeNC5QgglE/Nw1UbzCnwuIsOfqvIIHsR3OZg0Z
2amnQDGr5TLwBgvJFuzoIBWLTSQLN7eW293ae90tc7fXLV3LmZ6ybgHyPQRWqkLzcf6fzYdwy3bY
Uq6X0yW/qTdqwfxjS0FyO/uAFtoRAYwiWKF2wByrby3k+aU6KDeE6EzehQftcu1jB3ZFkIFnsgO4
hfh/XJR9jatTNgsg/QnJp7fC4VEqT4h7+8T/nK3nFHiaDoWuyAHQd3kzlk97U7L02byTU5Vtd0BR
a1rSqW+Eorzch/FBiHN5bqmsY0oAl4FziOxwXvzVDClfNKjgX1N3Cls2TMpTU1aX9JecqRVNc3Yd
/IymcxsHbpGal8AsnetXaSnUOsGuIu+AyNA7xJ3vYJafQzC1Cj90nbMpIZIDKODuPyqVwlKoTyJl
D0I8QTVgZCkYa0Bqo6sgMLpbrJWSDVjlPDInw8OHMK5f+PC91/m5oSmG6nTPgVfeBOXj8+mHXv3y
TjD8kE/pIVHygyp+7Lk/yPzoSDAh2XIr1naK+yTQaN4jB7RS+GcXFmemCyqCfU/BW+dz6EkYdeiP
P7zr997WfZ+0c5J/lFJmHld2joWXJ288APWeomwnWb7a+jp9Ak/Xt8Z8VE0DjeGwQERASgLhtWmg
a8I=
=GQW+
-----END PGP SIGNATURE-----

--------------xgeIHNDXs0v73ZY1kGCAmvw4--
