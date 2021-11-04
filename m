Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0BBC445B88
	for <lists+linux-nfs@lfdr.de>; Thu,  4 Nov 2021 22:10:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231849AbhKDVMn (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 4 Nov 2021 17:12:43 -0400
Received: from outgoing-stata.csail.mit.edu ([128.30.2.210]:55369 "EHLO
        outgoing-stata.csail.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230162AbhKDVMn (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 4 Nov 2021 17:12:43 -0400
Received: from c-24-60-30-97.hsd1.ma.comcast.net ([24.60.30.97] helo=crash.local)
        by outgoing-stata.csail.mit.edu with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.82)
        (envelope-from <rtm@csail.mit.edu>)
        id 1mijzm-000Sna-4B; Thu, 04 Nov 2021 17:10:02 -0400
Received: from crash.local (localhost [127.0.0.1])
        by crash.local (Postfix) with ESMTP id 941FB11E96830;
        Thu,  4 Nov 2021 17:10:01 -0400 (EDT)
To:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>
cc:     linux-nfs@vger.kernel.org
From:   rtm@csail.mit.edu
Reply-To: rtm@csail.mit.edu
Subject: another NFS client RPC bug
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Date:   Thu, 04 Nov 2021 17:10:01 -0400
Message-ID: <8046.1636060201@crash.local>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

--=-=-=
Content-Type: text/plain

In decode_op_map() in fs/nfs/nfs4xdr.c:

        uint32_t bitmap_words;
        ...;
        bitmap_words = be32_to_cpup(p++);
        if (bitmap_words > NFS4_OP_MAP_NUM_WORDS)
                return -EIO;
        ...;
        p = xdr_inline_decode(xdr, 4 * bitmap_words);
        for (i = 0; i < bitmap_words; i++)
                op_map->u.words[i] = be32_to_cpup(p++);

The return value from xdr_inline_decode() isn't checked, so there can be
a null-pointer dereference if there aren't enough bytes left in the RPC
message.

I've attached a program that produces the bug on my 5.15 machine:

# cc nfs_2.c
# ./a.out
mount:mount.nfs: timeout set for Thu Nov  4 21:10:28 2021
mount.nfs: trying text-based options 'vers=4.2,addr=127.0.0.1,clientaddr=127.0.0.1'
[   29.133142] random: fast init done
accept returned 4
proc 0
proc 1
[   19.298637] Unable to handle kernel access to user memory without uaccess routines at virtual address 0000000000000000
[   19.316686] Oops [#1]
[   19.322023] Modules linked in:
[   19.329310] CPU: 0 PID: 61 Comm: mount.nfs Not tainted 5.15.0-rc7-dirty #15
[   19.341196] Hardware name: ucbbar,riscvemu-bare (DT)
[   19.350236] epc : decode_op_map+0x78/0xba
[   19.357992]  ra : decode_op_map+0x62/0xba
[   19.365744] epc : ffffffff8022d93c ra : ffffffff8022d926 sp : ffffffd0005736e0
...
[   19.504650] status: 0000000200000121 badaddr: 0000000000000000 cause: 000000000000000d
[   19.518135] [<ffffffff8022d93c>] decode_op_map+0x78/0xba
[   19.528276] [<ffffffff80239db4>] nfs4_xdr_dec_exchange_id+0x1a6/0x57e
[   19.540304] [<ffffffff8071af74>] rpcauth_unwrap_resp_decode+0x12/0x1a
[   19.552386] [<ffffffff8071bc30>] rpcauth_unwrap_resp+0x12/0x1a
[   19.563960] [<ffffffff80711fcc>] call_decode+0x112/0x176
[   19.574123] [<ffffffff8071a4b0>] __rpc_execute+0x76/0x216
[   19.584286] [<ffffffff8071aace>] rpc_execute+0x58/0x7e
[   19.594443] [<ffffffff80713358>] rpc_run_task+0x12c/0x16c
[   19.604541] [<ffffffff80224eba>] nfs4_run_exchange_id+0x1d8/0x262
[   19.616149] [<ffffffff80224f68>] _nfs4_proc_exchange_id+0x24/0x2ba
[   19.627761] [<ffffffff8022cfc4>] nfs4_proc_exchange_id+0x30/0x50
[   19.639397] [<ffffffff8023ea3e>] nfs41_discover_server_trunking+0x1c/0xa8
[   19.651468] [<ffffffff80240d64>] nfs4_discover_server_trunking+0x7c/0x1e8
[   19.663549] [<ffffffff80249114>] nfs4_init_client+0x92/0xf6
[   19.673663] [<ffffffff80205412>] nfs_get_client+0x36a/0x394
[   19.683817] [<ffffffff80248844>] nfs4_set_client+0xd6/0x13e
[   19.693935] [<ffffffff80249830>] nfs4_create_server+0xb8/0x208
[   19.705529] [<ffffffff8024161c>] nfs4_try_get_tree+0x16/0x4c
[   19.717147] [<ffffffff80218bac>] nfs_get_tree+0x34a/0x3ac
[   19.727243] [<ffffffff8012bce4>] vfs_get_tree+0x18/0x88
[   19.737351] [<ffffffff8014a28e>] path_mount+0x4f4/0x77a
[   19.747521] [<ffffffff8014a560>] do_mount+0x4c/0x7e
[   19.757264] [<ffffffff8014a912>] sys_mount+0xca/0x14e
[   19.767418] [<ffffffff80003046>] ret_from_syscall+0x0/0x2


--=-=-=
Content-Type: application/octet-stream
Content-Disposition: attachment; filename=nfs_2.c
Content-Transfer-Encoding: base64

I2luY2x1ZGUgPHN0ZGlvLmg+CiNpbmNsdWRlIDxzdGRsaWIuaD4KI2luY2x1ZGUgPHVuaXN0ZC5o
PgojaW5jbHVkZSA8c3RyaW5nLmg+CiNpbmNsdWRlIDxzeXMvc29ja2V0Lmg+CiNpbmNsdWRlIDxz
eXMvaW9jdGwuaD4KI2luY2x1ZGUgPG5ldGluZXQvaW4uaD4KI2luY2x1ZGUgPHN5cy93YWl0Lmg+
CiNpbmNsdWRlIDxzeXMvcmVzb3VyY2UuaD4KCnVuc2lnbmVkIGxvbmcgbG9uZyBhYWFbXSA9IHsK
MHgwdWxsLAoweDB1bGwsCjB4MHVsbCwKMHgwdWxsLAoweDB1bGwsCjB4MHVsbCwKMHgwdWxsLAow
eDB1bGwsCjB4MHVsbCwKMHgwdWxsLAoweDB1bGwsCjB4MHVsbCwKMHgwdWxsLAoweDB1bGwsCjB4
MHVsbCwKMHgwdWxsLAoweDB1bGwsCjB4MHVsbCwKMHgwdWxsLAoweGM0ZmZmZmZmMDAwMDAwMDB1
bGwsCjB4MHVsbCwKMHgwdWxsLAoweDB1bGwsCjB4MHVsbCwKMHgwdWxsLAoweDB1bGwsCjB4MHVs
bCwKMHgwdWxsLAoweGZmZmZmZmZmZDVmZmZmZmZ1bGwsCjB4MHVsbCwKMHgwdWxsLAoweGZiZmZm
ZmZmZmVmZmZmZmZ1bGwsCjB4MHVsbCwKMHgwdWxsLAoweDB1bGwsCjB4MHVsbCwKMHgwdWxsLAow
eDB1bGwsCjB4MHVsbCwKMHgwdWxsLAoweDB1bGwsCjB4MHVsbCwKMHgwdWxsLAoweDB1bGwsCjB4
MHVsbCwKMHgwdWxsLAoweDB1bGwsCjB4MHVsbCwKMHgwdWxsLAoweDB1bGwsCjB4MHVsbCwKMHgw
dWxsLAoweDB1bGwsCjB4MHVsbCwKMHgwdWxsLAoweDB1bGwsCjB4MHVsbCwKMHgwdWxsLAoweDB1
bGwsCjB4MHVsbCwKMHgwdWxsLAoweDB1bGwsCjB4MHVsbCwKMHgwdWxsLAp9OwppbnQgaWlpID0g
MDsKCmludCByZWFkbihpbnQgZmQsIGNoYXIgKmJ1ZiwgaW50IG4pIHsKICBpbnQgb3JpZyA9IG47
CiAgd2hpbGUobiA+IDApewogICAgaW50IGNjID0gcmVhZChmZCwgYnVmLCBuKTsKICAgIGlmKGNj
IDw9IDApIHsgcGVycm9yKCJyZWFkIik7IHJldHVybiAtMTsgfQogICAgbiAtPSBjYzsKICAgIGJ1
ZiArPSBjYzsKICB9CiAgcmV0dXJuIG9yaWc7Cn0KCmludAptYWluKCl7CiAgc3RydWN0IHJsaW1p
dCByOwogIHIucmxpbV9jdXIgPSByLnJsaW1fbWF4ID0gMDsKICBzZXRybGltaXQoUkxJTUlUX0NP
UkUsICZyKTsKCiAgaW50IHMgPSBzb2NrZXQoQUZfSU5FVCwgU09DS19TVFJFQU0sIDApOwogIHN0
cnVjdCBzb2NrYWRkcl9pbiBzaW47CiAgbWVtc2V0KCZzaW4sIDAsIHNpemVvZihzaW4pKTsKICBz
aW4uc2luX2ZhbWlseSA9IEFGX0lORVQ7CiAgc2luLnNpbl9wb3J0ID0gaHRvbnMoMjA0OSk7CiAg
aWYoYmluZChzLCAoc3RydWN0IHNvY2thZGRyICopJnNpbiwgc2l6ZW9mKHNpbikpIDwgMCl7CiAg
ICBwZXJyb3IoImJpbmQiKTsgZXhpdCgxKTsKICB9CiAgbGlzdGVuKHMsIDEwKTsKICBzeW5jKCk7
IHNsZWVwKDEpOyBzbGVlcCgxKTsgc2xlZXAoMSk7CgogIGlmKGZvcmsoKSA9PSAwKXsKICAgIGlm
KHN5c3RlbSgiZWNobyAtbiBtb3VudDogOyBtb3VudCAtdiAtdCBuZnMgMTI3LjAuMC4xOi90bXAg
L21udCIpID09IDApewogICAgICBzeXN0ZW0oImVjaG8gLW4gbHM6IDsgbHMgLWwgL21udC8uIC9t
bnQveiIpOwogICAgICBzeXN0ZW0oImVjaG8gLW4gZWNobzogOyBlY2hvIGhpID4gL21udC94Iik7
CiAgICAgIHN5c3RlbSgiZWNobyAtbiB1bW91bnQ6IDsgdW1vdW50IC9tbnQiKTsKICAgIH0KICAg
IGV4aXQoMCk7CiAgfQoKICBpZihmb3JrKCkgPT0gMCl7CiNkZWZpbmUgTkFBIDY0CiAgICB1bnNp
Z25lZCBsb25nIGxvbmcgYWFbTkFBXTsKICAgIGZvcihpbnQgaSA9IDA7IGkgPCBOQUE7IGkrKykg
YWFbaV0gPSBhYWFbaWlpKytdOwogICAgaW50IGlpID0gMDsKCiAgICBzb2NrbGVuX3Qgc2lubGVu
ID0gc2l6ZW9mKHNpbik7CiAgICBpbnQgczEgPSBhY2NlcHQocywgKHN0cnVjdCBzb2NrYWRkciAq
KSAmc2luLCAmc2lubGVuKTsKICAgIHByaW50ZigiYWNjZXB0IHJldHVybmVkICVkXG4iLCBzMSk7
CiAgICBpZihzMSA8IDApIHsgcGVycm9yKCJhY2NlcHQiKTsgZXhpdCgxKTsgfQogICAgY2xvc2Uo
cyk7CiAgCiAgICB3aGlsZSgxKXsKICAgICAgdW5zaWduZWQgaW50IGlsZW47CiAgICAgIGlmKHJl
YWRuKHMxLCAoY2hhciopJmlsZW4sIDQpIDwgMCkgYnJlYWs7CiAgICAgIGlsZW4gPSBudG9obChp
bGVuKTsKICAgICAgaWxlbiAmPSAweDdmZmZmZmZmOwogICAgICBjaGFyIGlidWZbMTAyNF07CiAg
ICAgIGlmKHJlYWRuKHMxLCAoY2hhciopaWJ1ZiwgaWxlbikgPCAwKSBicmVhazsKICAgICAgaW50
IHhpZCA9ICooaW50KikoaWJ1ZiswKTsKICAgICAgaW50IHByb2MgPSBudG9obCgqKGludCopKGli
dWYrMjApKTsKICAgICAgcHJpbnRmKCJwcm9jICVkXG4iLCBwcm9jKTsKICAgICAgCiAgICAgIGNo
YXIgb2J1ZlsxMjhdOwogICAgICBpbnQgb2xlbiA9IHNpemVvZihvYnVmKTsKICAgICAgaW50IGR1
bW15ID0gaHRvbmwob2xlbiB8IDB4ODAwMDAwMDApOwogICAgICB3cml0ZShzMSwgJmR1bW15LCA0
KTsKICAgICAgbWVtc2V0KG9idWYsIDB4ZmYsIHNpemVvZihvYnVmKSk7CiAgICAgIGZvcihpbnQg
aSA9IDA7IGkrOCA8PSBzaXplb2Yob2J1ZikgJiYgaWkgPCBOQUE7IGkgKz0gOCkKICAgICAgICAq
KHVuc2lnbmVkIGxvbmcgbG9uZyAqKShvYnVmICsgaSkgXj0gYWFbaWkrK107CiAgICAgICooaW50
Kikob2J1ZiswKSA9IHhpZDsKICAgICAgKihpbnQqKShvYnVmKzQpID0gaHRvbmwoMSk7IC8vIFJF
UExZCiAgICAgICooaW50Kikob2J1Zis4KSA9IGh0b25sKDApOyAvLyBNU0dfQUNDRVBURUQKICAg
ICAgKihpbnQqKShvYnVmKzEyKSA9IGh0b25sKDApOyAvLyBvcGFxdWVfYXV0aCBmbGF2b3IgPSBB
VVRIX05VTEwKICAgICAgKihpbnQqKShvYnVmKzE2KSA9IGh0b25sKDApOyAvLyBvcGFxdWVfYXV0
aCBsZW5ndGgKICAgICAgKihpbnQqKShvYnVmKzIwKSA9IGh0b25sKDApOyAvLyBTVUNDRVNTCiAg
ICAgIGlmKHdyaXRlKHMxLCBvYnVmLCBvbGVuKTw9MCkgcGVycm9yKCJ3cml0ZSIpOwogICAgfQog
ICAgZXhpdCgxKTsKICB9CiAgY2xvc2Uocyk7CiAgc2xlZXAoNyk7Cn0K
--=-=-=--
