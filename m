Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AE1E66100F
	for <lists+linux-nfs@lfdr.de>; Sat,  7 Jan 2023 16:45:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232124AbjAGPpD (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 7 Jan 2023 10:45:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbjAGPpC (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 7 Jan 2023 10:45:02 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7714D43D84
        for <linux-nfs@vger.kernel.org>; Sat,  7 Jan 2023 07:44:59 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id l26so3017312wme.5
        for <linux-nfs@vger.kernel.org>; Sat, 07 Jan 2023 07:44:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:from:cc:to:content-language:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=szhQJ0YJPffgee99PVP7kUu86boihwos4p5lXk+fcK0=;
        b=l3lM+zqPTtvpxARmVa4oWgVc9T9PIyQGTGlkMk0l86phHnfDuqUHS4CszTRfkqksM8
         bXpxR6JSa/zapwda3y7CrPyATt3GAfy8VQKkue+BmaTjBl/EhGXPzwm2O3e4B1BFIvPA
         jwZLI4QHQYIBTTMLMdAmg5C5WlJIGF3Hyflp+rLSRsVgZOUWmaWd5SpKZlmrSv3aoAYI
         ywlnWvyjSxp/XVidaFQNVQJADaE2GQnflPpaJRZW4nYffM2WpguNrwXy7TP+tt83PuHP
         J1CsU4GJDy00JRz+rsF+AjKQBwOO3avJ7Ui4rOJx3gL0kLEVTAZuv91VoOZCbPbWXoiG
         4oKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=subject:from:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=szhQJ0YJPffgee99PVP7kUu86boihwos4p5lXk+fcK0=;
        b=ZOQu21tu0Ke8J9JAOlm1Ulf9vRLQJHeRDoZ50mw4s8WnfLEU3yhJzCo44Uo8/k928d
         hJ267yi7E9tjF+qDgtCjTS409K5inmWR/a8797BZvcU4ZJHk5HB094gezqGy0TZcorVy
         dMW2eWSItT2lctouYNXrTt7CiIPUm2p4SDRKtcnM5S2MbYQvltk68kl2PojtAI3I8hor
         3abLHbZ4FL3JVYSx5kT/BdYo0yja8HpkE36JysWCk9/Z2lomGqph1PknH+NQeJPXLO0I
         V7h57fK9vOV13rctdXskrk5psbU4aqhQsfGkJKHVZ57FXmSRfXDu5SGTkDF4eBQz0vut
         j+lw==
X-Gm-Message-State: AFqh2krl8awICHy6ZQ9qveTjSfkZwpP2z+61TlT0JPijY1121RXVBxl3
        LWoS91RvB/QHu/S1xrQuXTlyUw==
X-Google-Smtp-Source: AMrXdXsICmLFpqZ6+PY6MWLho8utt2FXa+kMGOkDjEdQBahCa7hueIaZs5Zdp/cRNhdqdPAfqn/V1A==
X-Received: by 2002:a05:600c:5113:b0:3d3:5c21:dd99 with SMTP id o19-20020a05600c511300b003d35c21dd99mr41443264wms.18.1673106297975;
        Sat, 07 Jan 2023 07:44:57 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id bh13-20020a05600c3d0d00b003d358beab9dsm5548585wmb.47.2023.01.07.07.44.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Jan 2023 07:44:57 -0800 (PST)
Content-Type: multipart/mixed; boundary="------------Phq3h2f4wbxq6ektjuHw1trb"
Message-ID: <f591b13c-4600-e2a4-8efa-aac6ad828dd1@linaro.org>
Date:   Sat, 7 Jan 2023 16:44:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Content-Language: en-US
To:     Anna Schumaker <Anna.Schumaker@Netapp.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>
Cc:     linux-nfs@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Regression: NULL pointer dereference after NFS_V4_2_READ_PLUS (commit
 7fd461c47)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

This is a multi-part message in MIME format.
--------------Phq3h2f4wbxq6ektjuHw1trb
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

Bisect identified commit 7fd461c47c6c ("NFSv4.2: Change the default
KConfig value for READ_PLUS") as one leading to NULL pointer exception
when mounting NFS root on NFSv4 client:

[   25.739003] systemd[1]: Set hostname to <odroidhc1>.
[   25.771714] systemd[1]: Failed to bump fs.file-max, ignoring: Invalid
argument
[   26.199478] 8<--- cut here ---
[   26.201366] Unable to handle kernel NULL pointer dereference at
virtual address 00000004
...
[   26.555522]  mmiocpy from xdr_inline_decode+0xec/0x16c
[   26.560628]  xdr_inline_decode from nfs4_xdr_dec_read_plus+0x178/0x358
[   26.567130]  nfs4_xdr_dec_read_plus from call_decode+0x204/0x304

Full OOPS attached. Full log available here:
https://krzk.eu/#/builders/21/builds/3901/steps/15/logs/serial0

Disabling NFS_V4_2_READ_PLUS fixes the issue, so obviously the commit is
not the cause, but rather making it default caused the regression.

I did not make the bisect yet which commit introduced it, if every
config includes NFS_V4_2_READ_PLUS.


Some details about platform:

1. Arch ARM Linux
2. exynos_defconfig
3. Odroid HC1 board with ARMv7, octa-core (Cortex-A7+A15), Exynos5422 SoC
4. systemd, boot up with static IP set in kernel command line
5. No swap
6. Kernel, DTB and initramfs are downloaded with TFTP
7. NFS root (NFS client) mounted from a NFSv4 server


Best regards,
Krzysztof
--------------Phq3h2f4wbxq6ektjuHw1trb
Content-Type: text/plain; charset=UTF-8; name="log.txt"
Content-Disposition: attachment; filename="log.txt"
Content-Transfer-Encoding: base64

MjUuNjI4MDc1XSBzeXN0ZW1kWzFdOiBzeXN0ZW1kIDI0Mi4yOS0xLWFyY2ggcnVubmluZyBp
biBzeXN0ZW0gbW9kZS4gKCtQQU0gK0FVRElUIC1TRUxJTlVYIC1JTUEgLUFQUEFSTU9SICtT
TUFDSyAtU1lTVklOSVQgK1VUTVAgK0xJQkNSWVBUU0VUVVAgK0dDUllQVCArR05VVExTICtB
Q0wgK1haICtMWjQgK1NFQ0NPTVAgK0JMS0lEICtFTEZVVElMUyArS01PRCArSUROMiAtSURO
ICtQQ1JFMiBkZWZhdWx0LWhpZXJhcmNoeT1oeWJyaWQpClsgwqAgMjUuNjU2MjAyXSBzeXN0
ZW1kWzFdOiBEZXRlY3RlZCBhcmNoaXRlY3R1cmUgYXJtLgpbIMKgIDI1LjY2NDAwN10gcmFu
ZG9tOiBjcm5nIGluaXQgZG9uZQoKV2VsY29tZSB0byBBcmNoIExpbnV4IEFSTSEKClsgwqAg
MjUuNzM5MDAzXSBzeXN0ZW1kWzFdOiBTZXQgaG9zdG5hbWUgdG8gPG9kcm9pZGhjMT4uClsg
wqAgMjUuNzcxNzE0XSBzeXN0ZW1kWzFdOiBGYWlsZWQgdG8gYnVtcCBmcy5maWxlLW1heCwg
aWdub3Jpbmc6IEludmFsaWQgYXJndW1lbnQKWyDCoCAyNi4xOTk0NzhdIDg8LS0tIGN1dCBo
ZXJlIC0tLQpbIMKgIDI2LjIwMTM2Nl0gVW5hYmxlIHRvIGhhbmRsZSBrZXJuZWwgTlVMTCBw
b2ludGVyIGRlcmVmZXJlbmNlIGF0IHZpcnR1YWwgYWRkcmVzcyAwMDAwMDAwNApbIMKgIDI2
LjIwOTM4OV0gWzAwMDAwMDA0XSAqcGdkPTAwMDAwMDAwClsgwqAgMjYuMjEyOTYyXSBJbnRl
cm5hbCBlcnJvcjogT29wczogNSBbIzFdIFBSRUVNUFQgU01QIEFSTQpbIMKgIDI2LjIxODA5
MV0gTW9kdWxlcyBsaW5rZWQgaW46ClsgwqAgMjYuMjIxMTIwXSBDUFU6IDQgUElEOiA2MiBD
b21tOiBrd29ya2VyL3UxNjoxIE5vdCB0YWludGVkIDYuMS4wLTAzMjUwLWdhMDQ0ZGFiNWU2
ZTUgIzkyClsgwqAgMjYuMjI5MTc1XSBIYXJkd2FyZSBuYW1lOiBTYW1zdW5nIEV4eW5vcyAo
RmxhdHRlbmVkIERldmljZSBUcmVlKQpbIMKgIDI2LjIzNTI0MV0gV29ya3F1ZXVlOiBycGNp
b2QgcnBjX2FzeW5jX3NjaGVkdWxlClsgwqAgMjYuMjM5ODI4XSBQQyBpcyBhdCBtbWlvY3B5
KzB4NGMvMHgzMzQKWyDCoCAyNi4yNDM2MzldIExSIGlzIGF0IHhkcl9pbmxpbmVfZGVjb2Rl
KzB4ZWMvMHgxNmMKWyDCoCAyNi4yNDgzMjBdIHBjIDogWzxjMGI5MzhlYz5dIMKgIMKgbHIg
OiBbPGMwYjVmNzQwPl0gwqAgwqBwc3I6IDIwMGEwMTEzClsgwqAgMjYuMjU0NTYxXSBzcCA6
IGYwYTcxZDk4IMKgaXAgOiAwMDAwMDAwMCDCoGZwIDogZjBhNzFkYTgKWyDCoCAyNi4yNTk3
NTldIHIxMDogMDAwMDMwMDAgwqByOSA6IDAwMDAwMDA5IMKgcjggOiBjMWQxZGMxOApbIMKg
IDI2LjI2NDk1Nl0gcjcgOiAwMDAwMGZmYyDCoHI2IDogZjBhNzFlMjQgwqByNSA6IDAwMDAw
MDA0IMKgcjQgOiBmMGE3MWU2MApbIMKgIDI2LjI3MTQ1N10gcjMgOiAwMDAwMDAwMCDCoHIy
IDogMDAwMDBmN2MgwqByMSA6IDAwMDAwMDA0IMKgcjAgOiBmMGE3MWUyNApbIMKgIDI2LjI3
Nzk1Nl0gRmxhZ3M6IG56Q3YgwqBJUlFzIG9uIMKgRklRcyBvbiDCoE1vZGUgU1ZDXzMyIMKg
SVNBIEFSTSDCoFNlZ21lbnQgbm9uZQpbIMKgIDI2LjI4NTA2NF0gQ29udHJvbDogMTBjNTM4
N2QgwqBUYWJsZTogNDQwNzAwNmEgwqBEQUM6IDAwMDAwMDUxClsgwqAgMjYuMjkwNzg3XSBS
ZWdpc3RlciByMCBpbmZvcm1hdGlvbjogMi1wYWdlIHZtYWxsb2MgcmVnaW9uIHN0YXJ0aW5n
IGF0IDB4ZjBhNzAwMDAgYWxsb2NhdGVkIGF0IGtlcm5lbF9jbG9uZSsweDU4LzB4M2ZjClsg
wqAgMjYuMzAxNDQ2XSBSZWdpc3RlciByMSBpbmZvcm1hdGlvbjogbm9uLXBhZ2VkIG1lbW9y
eQpbIMKgIDI2LjMwNjQ2NF0gUmVnaXN0ZXIgcjIgaW5mb3JtYXRpb246IG5vbi1wYWdlZCBt
ZW1vcnkKWyDCoCAyNi4zMTE0OTBdIFJlZ2lzdGVyIHIzIGluZm9ybWF0aW9uOiBOVUxMIHBv
aW50ZXIKWyDCoCAyNi4zMTYxNjldIFJlZ2lzdGVyIHI0IGluZm9ybWF0aW9uOiAyLXBhZ2Ug
dm1hbGxvYyByZWdpb24gc3RhcnRpbmcgYXQgMHhmMGE3MDAwMCBhbGxvY2F0ZWQgYXQga2Vy
bmVsX2Nsb25lKzB4NTgvMHgzZmMKWyDCoCAyNi4zMjY4MzhdIFJlZ2lzdGVyIHI1IGluZm9y
bWF0aW9uOiBub24tcGFnZWQgbWVtb3J5ClsgwqAgMjYuMzMxODU2XSBSZWdpc3RlciByNiBp
bmZvcm1hdGlvbjogMi1wYWdlIHZtYWxsb2MgcmVnaW9uIHN0YXJ0aW5nIGF0IDB4ZjBhNzAw
MDAgYWxsb2NhdGVkIGF0IGtlcm5lbF9jbG9uZSsweDU4LzB4M2ZjClsgwqAgMjYuMzQyNTIy
XSBSZWdpc3RlciByNyBpbmZvcm1hdGlvbjogbm9uLXBhZ2VkIG1lbW9yeQpbIMKgIDI2LjM0
NzU0MV0gUmVnaXN0ZXIgcjggaW5mb3JtYXRpb246IHNsYWIga21hbGxvYy0yNTYgc3RhcnQg
YzFkMWRjMDAgcG9pbnRlciBvZmZzZXQgMjQgc2l6ZSAyNTYKWyDCoCAyNi4zNTYyMTFdIFJl
Z2lzdGVyIHI5IGluZm9ybWF0aW9uOiBub24tcGFnZWQgbWVtb3J5ClsgwqAgMjYuMzYxMjMy
XSBSZWdpc3RlciByMTAgaW5mb3JtYXRpb246IG5vbi1wYWdlZCBtZW1vcnkKWyDCoCAyNi4z
NjYzNDVdIFJlZ2lzdGVyIHIxMSBpbmZvcm1hdGlvbjogMi1wYWdlIHZtYWxsb2MgcmVnaW9u
IHN0YXJ0aW5nIGF0IDB4ZjBhNzAwMDAgYWxsb2NhdGVkIGF0IGtlcm5lbF9jbG9uZSsweDU4
LzB4M2ZjClsgwqAgMjYuMzc3MDk4XSBSZWdpc3RlciByMTIgaW5mb3JtYXRpb246IE5VTEwg
cG9pbnRlcgpbIMKgIDI2LjM4MTg1Nl0gUHJvY2VzcyBrd29ya2VyL3UxNjoxIChwaWQ6IDYy
LCBzdGFjayBsaW1pdCA9IDB4ODljYTgwNzcpClsgwqAgMjYuMzg4MjcxXSBTdGFjazogKDB4
ZjBhNzFkOTggdG8gMHhmMGE3MjAwMCkKWyDCoCAyNi4zOTI2MDBdIDFkODA6IMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIDAwMDAwMDA0IGYwYTcxZTI0ClsgwqAgMjYuNDAwNzY2XSAx
ZGEwOiBjMWQxZGMxOCAwMDAwMDAwOSBmMGE3MWUyNCBmMGE3MWU2MCBjMWQxZGMwMCBjMGI1
Zjc0MCAwMDAwMDAwMSBmMGE3MWU2MApbIMKgIDI2LjQwODg5OF0gMWRjMDogYzFkOTExMDAg
MDAwMDAwMDkgYzFkMWRjMTggYzA0ODcwZjggYzFlNTI3ZDggYzExNzE1ODQgMDAwMDAwMDAg
MDAwMDAwMDAKWyDCoCAyNi40MTcwNDNdIDFkZTA6IDAwMDAwMDAzIDAwMDAwMDAwIDAwMDAw
MDAwIDAwMDAwMDAwIDAwMDAwMDFhIDAwMDAwMDA0IGMyNmZhYTFjIDAwMDAwMDAwClsgwqAg
MjYuNDI1MTg5XSAxZTAwOiBjMjZmYWE5NCAwMDAwMDAwMCBjMTdmMTQ5OCBjMzMyMTYwMCAw
MDAwMDAwMCAwMDAwMzAwMCAwMDAwMDAwMCAwMDAwMzAwMApbIMKgIDI2LjQzMzMzNV0gMWUy
MDogMDAwMDMwMDAgYzI1ZGEwMDAgYzFkOTBmNTggMDAwMDAwMDAgZjBhNzFlNjAgMmI3NTBk
ODQgMDAwMDAwMDAgYzFkOTBmNTgKWyDCoCAyNi40NDE0NzldIDFlNDA6IGM0MGE0MDAwIGMx
MzYwMTgwIGMxMjA4ZjEwIGM0MGE0MDMwIGMxZTUyMDAwIGMwYjM0MGIwIGMxZDkwZjc0IGMw
YjM0MmI0ClsgwqAgMjYuNDQ5NjI2XSAxZTYwOiAwMDAwMTAwMCBjNDBhNDAzMCAwMDAwMTAw
MCAwMDAwMDAwMCBmMGE3MWUyNCAwMDAwMDAxMCBjMzMyMTYwYyAwMDAwMmMyNApbIMKgIDI2
LjQ1Nzc3MV0gMWU4MDogYzQwYTQwMDAgMmI3NTBkODQgYzEyMDhmMTAgYzFkOTBmNTggYzFl
NTIwMDAgYzEyMDhmMTAgYzBiMzQwYjAgYzEzNjAxNjAKWyDCoCAyNi40NjU5MTZdIDFlYTA6
IGMwYjRlOGY0IGMwYjRmMDYwIDAwMDAwMDAwIDAwMDAwMDAxIDA0MjQ4MTYwIGMxMzU3ZDU3
IGMxMTcxNTg0IDAwMDAwMDAwClsgwqAgMjYuNDc0MDYyXSAxZWMwOiAwMDAwMDAwMSAyYjc1
MGQ4NCAwMDAwMDAwMiBjMWU1MjAwMCAwNDIwODE2MCBjMWMwOGUwMCBjMjc1MjkwMCBjMWU1
MjAwMApbIMKgIDI2LjQ4MjIwOF0gMWVlMDogYzEzNTg5ODAgYzEyMDhmMTAgYzI3NTI5MDUg
YzBiNGY4MjggYzFkOTBmN2MgYzFjZmZkMDAgYzFjMDhlMDAgYzAxNDgxNDAKWyDCoCAyNi40
OTAzNTNdIDFmMDA6IDAwMDAwMDAxIDAwMDAwMDAwIGMwMTQ4MDljIGMxZTUyMDAwIDAwMDAy
ZGZkIDAwMDAwMDAwIGMxZTUyMDAwIGMxYzA4ZTAwClsgwqAgMjYuNDk4NDk4XSAxZjIwOiBj
MTlkYmI2MCBjMTdmMTQ5OCAwMDAwMDAwMCBjMGY1ZmZlYyAwMDAwMDAwMCAyYjc1MGQ4NCBj
MWMwOGUwMCBjMWNmZmQwMApbIMKgIDI2LjUwNjY0NF0gMWY0MDogYzFjMDhlMDAgYzFjZmZk
MTggYzFjMDhlM2MgYzEyMDVkNDAgMDAwMDAwODggYzFlNTIwMDAgYzFjMDhlMDAgYzAxNDhh
NjAKWyDCoCAyNi41MTQ3ODldIDFmNjA6IGMxZTUyMDAwIGMxMzU3ZTQwIGMxZTcwZjgwIGMx
ZjJiMGMwIGMxZTUyMDAwIGMwMTQ4YTBjIGMxY2ZmZDAwIGMxZTcwZjgwClsgwqAgMjYuNTIy
OTM1XSAxZjgwOiBmMDg4ZGVhNCAwMDAwMDAwMCAwMDAwMDAwMCBjMDE1MTEwOCBjMWYyYjBj
MCBjMDE1MTAxOCAwMDAwMDAwMCAwMDAwMDAwMApbIMKgIDI2LjUzMTA4MV0gMWZhMDogMDAw
MDAwMDAgMDAwMDAwMDAgMDAwMDAwMDAgYzAxMDAxMDggMDAwMDAwMDAgMDAwMDAwMDAgMDAw
MDAwMDAgMDAwMDAwMDAKWyDCoCAyNi41MzkyMjZdIDFmYzA6IDAwMDAwMDAwIDAwMDAwMDAw
IDAwMDAwMDAwIDAwMDAwMDAwIDAwMDAwMDAwIDAwMDAwMDAwIDAwMDAwMDAwIDAwMDAwMDAw
ClsgwqAgMjYuNTQ3MzcxXSAxZmUwOiAwMDAwMDAwMCAwMDAwMDAwMCAwMDAwMDAwMCAwMDAw
MDAwMCAwMDAwMDAxMyAwMDAwMDAwMCAwMDAwMDAwMCAwMDAwMDAwMApbIMKgIDI2LjU1NTUy
Ml0gwqBtbWlvY3B5IGZyb20geGRyX2lubGluZV9kZWNvZGUrMHhlYy8weDE2YwpbIMKgIDI2
LjU2MDYyOF0gwqB4ZHJfaW5saW5lX2RlY29kZSBmcm9tIG5mczRfeGRyX2RlY19yZWFkX3Bs
dXMrMHgxNzgvMHgzNTgKWyDCoCAyNi41NjcxMzBdIMKgbmZzNF94ZHJfZGVjX3JlYWRfcGx1
cyBmcm9tIGNhbGxfZGVjb2RlKzB4MjA0LzB4MzA0ClsgwqAgMjYuNTczMTA3XSDCoGNhbGxf
ZGVjb2RlIGZyb20gX19ycGNfZXhlY3V0ZSsweGY4LzB4OGE0ClsgwqAgMjYuNTc4MjE4XSDC
oF9fcnBjX2V4ZWN1dGUgZnJvbSBycGNfYXN5bmNfc2NoZWR1bGUrMHgxYy8weDM0ClsgwqAg
MjYuNTgzODQ4XSDCoHJwY19hc3luY19zY2hlZHVsZSBmcm9tIHByb2Nlc3Nfb25lX3dvcmsr
MHgyOTQvMHg3OGMKWyDCoCAyNi41ODk5MTZdIMKgcHJvY2Vzc19vbmVfd29yayBmcm9tIHdv
cmtlcl90aHJlYWQrMHg1NC8weDUxOApbIMKgIDI2LjU5NTQ1OV0gwqB3b3JrZXJfdGhyZWFk
IGZyb20ga3RocmVhZCsweGYwLzB4MTI0ClsgwqAgMjYuNjAwMjI2XSDCoGt0aHJlYWQgZnJv
bSByZXRfZnJvbV9mb3JrKzB4MTQvMHgyYwpbIMKgIDI2LjYwNDkwM10gRXhjZXB0aW9uIHN0
YWNrKDB4ZjBhNzFmYjAgdG8gMHhmMGE3MWZmOCkKWyDCoCAyNi42MDk5MzFdIDFmYTA6IMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIDAw
MDAwMDAwIDAwMDAwMDAwIDAwMDAwMDAwIDAwMDAwMDAwClsgwqAgMjYuNjE4MDgyXSAxZmMw
OiAwMDAwMDAwMCAwMDAwMDAwMCAwMDAwMDAwMCAwMDAwMDAwMCAwMDAwMDAwMCAwMDAwMDAw
MCAwMDAwMDAwMCAwMDAwMDAwMApbIMKgIDI2LjYyNjIyNl0gMWZlMDogMDAwMDAwMDAgMDAw
MDAwMDAgMDAwMDAwMDAgMDAwMDAwMDAgMDAwMDAwMTMgMDAwMDAwMDAKWyDCoCAyNi42MzI4
MTRdIENvZGU6IGJhMDAwMDAyIGY1ZDFmMDNjIGY1ZDFmMDVjIGY1ZDFmMDdjIChlOGIxNTM3
OCkgClsgwqAgMjYuNjM4OTc2XSAtLS1bIGVuZCB0cmFjZSAwMDAwMDAwMDAwMDAwMDAwIF0t
LS0KWyDCoCAzOS41MTIyOTldIHZkZF9sZG8xMjogZGlzYWJsaW5nClsgwqAgMzkuNTE2NDI2
XSB2ZGRfbGRvMTY6IGRpc2FibGluZwpbIMKgIDM5LjUyMjQ4OF0gdmRkX2xkbzI0OiBkaXNh
YmxpbmcKWyDCoCAzOS41MjY1ODJdIHZkZF9sZG8yNjogZGlzYWJsaW5nClsgwqAgMzkuNTQ0
Nzg2XSB2ZGRfdm1lbTogZGlzYWJsaW5nCgoK

--------------Phq3h2f4wbxq6ektjuHw1trb--
