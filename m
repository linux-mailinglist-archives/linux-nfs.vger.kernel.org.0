Return-Path: <linux-nfs+bounces-2491-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF36688DC13
	for <lists+linux-nfs@lfdr.de>; Wed, 27 Mar 2024 12:08:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E22221C21FE5
	for <lists+linux-nfs@lfdr.de>; Wed, 27 Mar 2024 11:08:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F5D63A1DF;
	Wed, 27 Mar 2024 11:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lwd5gl+f"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC5223610A
	for <linux-nfs@vger.kernel.org>; Wed, 27 Mar 2024 11:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711537682; cv=none; b=ovtMRgqbSKnnyDAt3H1h/cmVtSrb+c6iBjTVQ9RKCklpDExNmD1SKIYN+jmBw5SthZw7VFPrZrTdj5plNV9KX3Lxn8+Dl47Z1BYt5r2eIC3RsCuy0bO55bmDMTyFWwS1EIDn/Tx1UX/urrLuh1S0YRnZHWo6d/i9bY2EBqiH/IE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711537682; c=relaxed/simple;
	bh=UvahTjj0F9WM0RsBYZFc3WQGM4pEWgbtP93KHWEy0WQ=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gDEDBrHeTOmV6AHKGKnhBbHcHEmC0r3ro1wL+h0A1g13+dghgp06cnjFu9CJ8o8ii+DyxEI4MLHrb1heFo9uNs2dNYirMAdG1Xo5KvC20hydE1ysv8WQWtg50dFKPFos8963UO64w1TsC/0l6xP2JUWnN+uvgJiIJRjkhsN5Qis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lwd5gl+f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC416C433C7;
	Wed, 27 Mar 2024 11:08:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711537681;
	bh=UvahTjj0F9WM0RsBYZFc3WQGM4pEWgbtP93KHWEy0WQ=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=Lwd5gl+fCuC/zrdVPqfBx7Zdc1WI0FjRtHBQeeFzCIFPqc2fyaDo6x3cg32r6vnad
	 uTQvEetpXnvWkRbtUOTCokFt6jLpfQl/HGFKbRB84L+eoD6yAofh5P+ZNWHLR0BJtc
	 hIDLTAfbUwa1aNQ2PdxffXbxTs7+oh1ROZMI1WVaxOqPy4vKAQEzlaZz2TqE1O8Dw2
	 +GogBFWGrxuQqj5XGCtrHj/JhTjIFrWx5Gd+BWo6tQDMMi4GPr56x9jrWTc+3dd05G
	 t7Xf1+K+ozgO42RQbDE9G9cbsCWR3KzqZnd816UoHR0UAQEQuqwUAmQozHg8JdAdUZ
	 Hg9qBT+xJ4BIA==
Message-ID: <474380e6098676a95f38dbaffcaeb633fe602167.camel@kernel.org>
Subject: Re: WARN_ONCE from nfsd_break_one_deleg
From: Jeff Layton <jlayton@kernel.org>
To: Dai Ngo <dai.ngo@oracle.com>, Chuck Lever <chuck.lever@oracle.com>, 
 Donald Buczek <buczek@molgen.mpg.de>, linux-nfs@vger.kernel.org,
 it+linux@molgen.mpg.de
Date: Wed, 27 Mar 2024 07:07:59 -0400
In-Reply-To: <530ec24d-c22d-4fea-a9f7-7a462ab1af9d@oracle.com>
References: <5b63ad24-1967-4e0c-b52b-f3a853b613ff@molgen.mpg.de>
	 <39c143cd-c84b-47b8-945f-bd0bbe8babfc@oracle.com>
	 <530ec24d-c22d-4fea-a9f7-7a462ab1af9d@oracle.com>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
	kZWuOsJdJQdmwlWC5L5ln9xgfr/4mOY38B0U=
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-03-26 at 18:59 -0700, Dai Ngo wrote:
> On 3/26/24 9:42 AM, Chuck Lever wrote:
> >=20
> > On 3/26/24 11:04 AM, Donald Buczek wrote:
> > > Hi,
> > >=20
> > > we just got this on a nfs file server on 6.6.12 :
> > >=20
> > > [2719554.674554] receive_cb_reply: Got unrecognized reply: calldir=
=20
> > > 0x1 xpt_bc_xprt 00000000432042d3 xid c369f54d
> > > [2719555.391416] receive_cb_reply: Got unrecognized reply: calldir=
=20
> > > 0x1 xpt_bc_xprt 0000000017cc0507 xid d6018727
> > > [2719555.742118] receive_cb_reply: Got unrecognized reply: calldir=
=20
> > > 0x1 xpt_bc_xprt 000000008f2509ff xid 83d0248e
> > > [2719555.742566] receive_cb_reply: Got unrecognized reply: calldir=
=20
> > > 0x1 xpt_bc_xprt 00000000637a135a xid 7064546d
> > > [2719555.742803] receive_cb_reply: Got unrecognized reply: calldir=
=20
> > > 0x1 xpt_bc_xprt 0000000044ea3c51 xid a184bbe5
> > > [2719555.742836] receive_cb_reply: Got unrecognized reply: calldir=
=20
> > > 0x1 xpt_bc_xprt 00000000b6992e65 xid ed3fe82e
> > > [2719555.785358] receive_cb_reply: Got unrecognized reply: calldir=
=20
> > > 0x1 xpt_bc_xprt 0000000044ea3c51 xid a384bbe5
> > > [2719588.733414] receive_cb_reply: Got unrecognized reply: calldir=
=20
> > > 0x1 xpt_bc_xprt 000000008f2509ff xid 89d0248e
> > > [2719592.067221] receive_cb_reply: Got unrecognized reply: calldir=
=20
> > > 0x1 xpt_bc_xprt 00000000b6992e65 xid f33fe82e
> > > [2719807.431344] receive_cb_reply: Got unrecognized reply: calldir=
=20
> > > 0x1 xpt_bc_xprt 00000000fd87f88f xid 28b51379
> > > [2719838.510792] receive_cb_reply: Got unrecognized reply: calldir=
=20
> > > 0x1 xpt_bc_xprt 00000000432042d3 xid fa69f54d
> > > [2719852.493779] receive_cb_reply: Got unrecognized reply: calldir=
=20
> > > 0x1 xpt_bc_xprt 00000000ac1e99fe xid a16378bb
> > > [2719852.494853] receive_cb_reply: Got unrecognized reply: calldir=
=20
> > > 0x1 xpt_bc_xprt 0000000017cc0507 xid 0f028727
> > > [2719852.515457] receive_cb_reply: Got unrecognized reply: calldir=
=20
> > > 0x1 xpt_bc_xprt 0000000017cc0507 xid 10028727
> >=20
> > These clients are sending NFSv4 callback replies that the server does=
=20
> > not have a waiting XID for. It's a sign of a significant communication=
=20
> > mix-up between the server and client.
> >=20
> > It would help us to get some details about your clients, the NFS=20
> > version in use, and how long you've been using this kernel. Also, a=20
> > raw packet capture might shed a little more light on the issue.
>=20
> This warning has has no effect on the server operation and was remove.
> See commit 05a4b58301c3.
>=20

Yes. It usually just means the job is already scheduled or is running,
which is harmless. That said, that can be indicative of the workqueue
job being stuck.

Typically, backchannel jobs should run quickly, but lease breaks can
come in quick succession too, so this warning never meant much.

>=20
> >=20
> > > [2719917.753429] ------------[ cut here ]------------
> > > [2719917.758951] WARNING: CPU: 1 PID: 1448 at=20
> > > fs/nfsd/nfs4state.c:4939 nfsd_break_deleg_cb+0x115/0x190 [nfsd]
> > > [2719917.769208] Modules linked in: af_packet xt_nat xt_tcpudp=20
> > > iptable_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4=20
> > > rpcsec_gss_krb5 nfsv4 nfs i915 iosf_mbi drm_buddy drm_display_helper=
=20
> > > ttm intel_gtt video 8021q garp stp mrp llc input_leds=20
> > > x86_pkg_temp_thermal led_class hid_generic usbhid coretemp kvm_intel=
=20
> > > kvm irqbypass tg3 libphy smartpqi mgag200 i2c_algo_bit efi_pstore=20
> > > iTCO_wdt i40e crc32c_intel wmi_bmof pstore iTCO_vendor_support wmi=
=20
> > > ipmi_si nfsd auth_rpcgss oid_registry nfs_acl lockd grace sunrpc=20
> > > efivarfs ip_tables x_tables ipv6 autofs4
> > > [2719917.818740] CPU: 1 PID: 1448 Comm: nfsd Not tainted=20
> > > 6.6.12.mx64.461 #1
> > > [2719917.825777] Hardware name: Dell Inc. PowerEdge T440/021KCD, BIOS=
=20
> > > 2.12.2 07/09/2021
> > > [2719917.833781] RIP: 0010:nfsd_break_deleg_cb+0x115/0x190 [nfsd]
> > > [2719917.839911] Code: 00 00 00 e8 3d ae e8 e0 e9 5f ff ff ff 48 89=
=20
> > > df be 01 00 00 00 e8 8b 1f 3d e1 48 8d bb 98 00 00 00 e8 ef 10 01 00=
=20
> > > 84 c0 75 8a <0f> 0b eb 86 65 8b 05 0c 66 e0 5f 89 c0 48 0f a3 05 d6=
=20
> > > 1a 75 e2 0f
> > > [2719917.859303] RSP: 0018:ffffc9000bae7b70 EFLAGS: 00010246
> > > [2719917.864962] RAX: 0000000000000000 RBX: ffff8881e2fd6000 RCX:=20
> > > 0000000000000024
> > > [2719917.872520] RDX: ffff8881e2fd60c8 RSI: ffff889086d5de00 RDI:=20
> > > 0000000000000200
> > > [2719917.880050] RBP: ffff889301aa812c R08: 0000000000033580 R09:=20
> > > 0000000000000000
> > > [2719917.887575] R10: ffff889ef63b20d8 R11: 0000000000000000 R12:=20
> > > ffff888104cfb290
> > > [2719917.895095] R13: ffff889301aa8118 R14: ffff88989c8ace00 R15:=20
> > > ffff888104cfb290
> > > [2719917.902625] FS:=A0 0000000000000000(0000)=20
> > > GS:ffff88a03fc00000(0000) knlGS:0000000000000000
> > > [2719917.911094] CS:=A0 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > [2719917.917236] CR2: 00007fb8a1cfc418 CR3: 000000000262c006 CR4:=20
> > > 00000000007706e0
> > > [2719917.924760] DR0: 0000000000000000 DR1: 0000000000000000 DR2:=20
> > > 0000000000000000
> > > [2719917.932285] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:=20
> > > 0000000000000400
> > > [2719917.939833] PKRU: 55555554
> > > [2719917.942971] Call Trace:
> > > [2719917.945834]=A0 <TASK>
> > > [2719917.948344]=A0 ? __warn+0x81/0x140
> > > [2719917.951983]=A0 ? nfsd_break_deleg_cb+0x115/0x190 [nfsd]
> > > [2719917.957470]=A0 ? report_bug+0x171/0x1a0
> > > [2719917.961562]=A0 ? handle_bug+0x3c/0x70
> > > [2719917.965459]=A0 ? exc_invalid_op+0x17/0x70
> > > [2719917.969715]=A0 ? asm_exc_invalid_op+0x1a/0x20
> > > [2719917.974317]=A0 ? nfsd_break_deleg_cb+0x115/0x190 [nfsd]
> > > [2719917.979820]=A0 __break_lease+0x24b/0x7c0
> > > [2719917.983991]=A0 ? __pfx_nfsd_acceptable+0x10/0x10 [nfsd]
> > > [2719917.989495]=A0 nfs4_get_vfs_file+0x195/0x380 [nfsd]
> > > [2719917.994740]=A0 ? prepare_creds+0x14c/0x240
> > > [2719917.999164]=A0 nfsd4_process_open2+0x3ed/0x16b0 [nfsd]
> > > [2719918.004570]=A0 ? nfsd_permission+0x4e/0x100 [nfsd]
> > > [2719918.009618]=A0 ? fh_verify+0x17b/0x8a0 [nfsd]
> > > [2719918.014243]=A0 nfsd4_open+0x6ae/0xcd0 [nfsd]
> > > [2719918.018777]=A0 ? nfsd4_encode_operation+0xa6/0x290 [nfsd]
> > > [2719918.024524]=A0 nfsd4_proc_compound+0x2f2/0x6a0 [nfsd]
> > > [2719918.029922]=A0 nfsd_dispatch+0xee/0x220 [nfsd]
> > > [2719918.034619]=A0 ? __pfx_nfsd+0x10/0x10 [nfsd]
> > > [2719918.039144]=A0 svc_process_common+0x307/0x730 [sunrpc]
> > > [2719918.044551]=A0 ? __pfx_nfsd_dispatch+0x10/0x10 [nfsd]
> > > [2719918.049883]=A0 ? __pfx_nfsd+0x10/0x10 [nfsd]
> > > [2719918.054404]=A0 svc_process+0x131/0x180 [sunrpc]
> > > [2719918.059171]=A0 nfsd+0x84/0xd0 [nfsd]
> > > [2719918.063012]=A0 kthread+0xe5/0x120
> > > [2719918.066539]=A0 ? __pfx_kthread+0x10/0x10
> > > [2719918.070664]=A0 ret_from_fork+0x31/0x50
> > > [2719918.074611]=A0 ? __pfx_kthread+0x10/0x10
> > > [2719918.078735]=A0 ret_from_fork_asm+0x1b/0x30
> > > [2719918.083018]=A0 </TASK>
> > > [2719918.085563] ---[ end trace 0000000000000000 ]---
> > >=20
> > > nfsd_break_deleg_cb+0x115 is the=20
> > > `WARN_ON_ONCE(!nfsd4_run_cb(&dp->dl_recall))` in=20
> > > nfsd_break_one_deleg() in our compilation
> > >=20
> > > I think that means, that the callback is already scheduled?
> > >=20
> > > One nfs client hung trying to mount something from that server.
> > >=20
> > > Best
> > >=20
> > > =A0=A0 Donald
> > >=20
> >=20
>=20

--=20
Jeff Layton <jlayton@kernel.org>

