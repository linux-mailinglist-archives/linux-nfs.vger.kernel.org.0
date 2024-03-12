Return-Path: <linux-nfs+bounces-2267-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 118808792E6
	for <lists+linux-nfs@lfdr.de>; Tue, 12 Mar 2024 12:23:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 350871C21629
	for <lists+linux-nfs@lfdr.de>; Tue, 12 Mar 2024 11:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E731179DDB;
	Tue, 12 Mar 2024 11:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sQQtTRv4"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C177179B77
	for <linux-nfs@vger.kernel.org>; Tue, 12 Mar 2024 11:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710242559; cv=none; b=f/PLYTGjYKlXHynhtFbZzG1WPIpCDAlP7J4fIBcQqKG6R70PEuke5mH1x9jr+yM9a6Mx4PvvbvSujb/h48hWa7snBx+330EoMYApuBm2PDYhKmq9BoYvuBynStJOZepxsjWZUyy52Sb6DjAr2F2sFNcLPgjPIa17hYifRsdTYUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710242559; c=relaxed/simple;
	bh=vFCSmgHelTcjcgR+uOeupzYna8EcKjSNMBCa2Qdo4P0=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bgh7A0aw8UV/kh+i9cYalyAJlJFe1deqeM3nCT0XDJcXjOjUg7wO6h22OEP8FBZjqSHZQC52gd9spLtSCUCuj7egmrvZouCgnvbAmLc+FBtzX9GhiTqMGtKbAkEP+cgdkAgqz7BUD7ZBGjmFPr5AqZy853dpFqMG1uoR/YSu7tQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sQQtTRv4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15367C43390;
	Tue, 12 Mar 2024 11:22:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710242559;
	bh=vFCSmgHelTcjcgR+uOeupzYna8EcKjSNMBCa2Qdo4P0=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=sQQtTRv40iJv1vK/VcdfCQoGmdhDq+JXudIaLWcWFFHZaEf7xT6wPu4WLB9bv/NjA
	 UQ0LP5cpkMLSMxkMRiUk7ujB8y0DoRtCIN+CqykABSffKV51FKCx5OZGA+t2Ar6sOr
	 pImC1Zyloh+d/ElgVgPVLLYVKIHmhLEwOnpn94Mkfs3A25/bW1pY3DR/hfmFg1LbNl
	 YNh9eY5aAxqvJffDb4TjUE2jZoE6KnbtDkhLHz5tjZwBmwZhICbFw9qH0UGsrDl/qY
	 PMtgPWXQxocZZRy1E3kti40WhwQAgCdEjpwgsigwIfx6byUiSePw30o+CFMji0QhMv
	 SZBnjybtbyQQw==
Message-ID: <75a8d4ca3617818c2b520de6d4f1abdb2a9545a9.camel@kernel.org>
Subject: Re: nfsd hangs and nfsd_break_deleg_cb+0x170/0x190 warning
From: Jeff Layton <jlayton@kernel.org>
To: Rik Theys <Rik.Theys@esat.kuleuven.be>, Linux Nfs
	 <linux-nfs@vger.kernel.org>
Date: Tue, 12 Mar 2024 07:22:37 -0400
In-Reply-To: <55366184-94bb-4054-8025-1125db3788ff@esat.kuleuven.be>
References: <55366184-94bb-4054-8025-1125db3788ff@esat.kuleuven.be>
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

On Mon, 2024-03-11 at 19:43 +0100, Rik Theys wrote:
> =A0
>=20
>=20
>=20
> Hi,
> =A0
>=20
>=20
>=20
> Since a few weeks our Rocky Linux 9 NFS server has periodically logged hu=
ng nfsd tasks. The initial effect was that some clients could no longer acc=
ess the NFS server. This got worse and worse (probably as more nfsd threads=
 got blocked) and we had to restart the server. Restarting the server also =
failed as the NFS server service could no longer be stopped.
> =A0
>=20
>=20
>=20
> The initial kernel we noticed this behavior on was kernel-5.14.0-362.18.1=
.el9_3.x86_64. Since then we've installed kernel-5.14.0-419.el9.x86_64 from=
 CentOS Stream 9. The same issue happened again on this newer kernel versio=
n:
> =A0
>=20
>=20
>=20
> [Mon Mar 11 14:10:08 2024] =A0=A0=A0=A0=A0=A0Not tainted 5.14.0-419.el9.x=
86_64 #1=20
> =A0[Mon Mar 11 14:10:08 2024] "echo 0 > /proc/sys/kernel/hung_task_timeou=
t_secs" disables this message.=20
> =A0[Mon Mar 11 14:10:08 2024] task:nfsd =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
state:D stack:0 =A0=A0=A0=A0pid:8865 =A0ppid:2 =A0=A0=A0=A0=A0flags:0x00004=
000=20
> =A0[Mon Mar 11 14:10:08 2024] Call Trace:=20
> =A0[Mon Mar 11 14:10:08 2024] =A0<TASK>=20
> =A0[Mon Mar 11 14:10:08 2024] =A0__schedule+0x21b/0x550=20
> =A0[Mon Mar 11 14:10:08 2024] =A0schedule+0x2d/0x70=20
> =A0[Mon Mar 11 14:10:08 2024] =A0schedule_timeout+0x11f/0x160=20
> =A0[Mon Mar 11 14:10:08 2024] =A0? select_idle_sibling+0x28/0x430=20
> =A0[Mon Mar 11 14:10:08 2024] =A0? wake_affine+0x62/0x1f0=20
> =A0[Mon Mar 11 14:10:08 2024] =A0__wait_for_common+0x90/0x1d0=20
> =A0[Mon Mar 11 14:10:08 2024] =A0? __pfx_schedule_timeout+0x10/0x10=20
> =A0[Mon Mar 11 14:10:08 2024] =A0__flush_workqueue+0x13a/0x3f0=20
> =A0[Mon Mar 11 14:10:08 2024] =A0nfsd4_shutdown_callback+0x49/0x120 [nfsd=
]=20
> =A0[Mon Mar 11 14:10:08 2024] =A0? nfsd4_cld_remove+0x54/0x1d0 [nfsd]=20
> =A0[Mon Mar 11 14:10:08 2024] =A0? nfsd4_return_all_client_layouts+0xc4/0=
xf0 [nfsd]=20
> =A0[Mon Mar 11 14:10:08 2024] =A0? nfsd4_shutdown_copy+0x68/0xc0 [nfsd]=
=20
> =A0[Mon Mar 11 14:10:08 2024] =A0__destroy_client+0x1f3/0x290 [nfsd]=20
> =A0[Mon Mar 11 14:10:08 2024] =A0nfsd4_exchange_id+0x75f/0x770 [nfsd]=20
> =A0[Mon Mar 11 14:10:08 2024] =A0? nfsd4_decode_opaque+0x3a/0x90 [nfsd]=
=20
> =A0[Mon Mar 11 14:10:08 2024] =A0nfsd4_proc_compound+0x44b/0x700 [nfsd]=
=20
> =A0[Mon Mar 11 14:10:08 2024] =A0nfsd_dispatch+0x94/0x1c0 [nfsd]=20
> =A0[Mon Mar 11 14:10:08 2024] =A0svc_process_common+0x2ec/0x660 [sunrpc]=
=20
> =A0[Mon Mar 11 14:10:08 2024] =A0? __pfx_nfsd_dispatch+0x10/0x10 [nfsd]=
=20
> =A0[Mon Mar 11 14:10:08 2024] =A0? __pfx_nfsd+0x10/0x10 [nfsd]=20
> =A0[Mon Mar 11 14:10:08 2024] =A0svc_process+0x12d/0x170 [sunrpc]=20
> =A0[Mon Mar 11 14:10:08 2024] =A0nfsd+0x84/0xb0 [nfsd]=20
> =A0[Mon Mar 11 14:10:08 2024] =A0kthread+0xdd/0x100=20
> =A0[Mon Mar 11 14:10:08 2024] =A0? __pfx_kthread+0x10/0x10=20
> =A0[Mon Mar 11 14:10:08 2024] =A0ret_from_fork+0x29/0x50=20
> =A0[Mon Mar 11 14:10:08 2024] =A0</TASK>=20
> =A0[Mon Mar 11 14:10:08 2024] INFO: task nfsd:8866 blocked for more than =
122 seconds.=20
> =A0[Mon Mar 11 14:10:08 2024] =A0=A0=A0=A0=A0=A0Not tainted 5.14.0-419.el=
9.x86_64 #1=20
> =A0[Mon Mar 11 14:10:08 2024] "echo 0 > /proc/sys/kernel/hung_task_timeou=
t_secs" disables this message.=20
> =A0[Mon Mar 11 14:10:08 2024] task:nfsd =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
state:D stack:0 =A0=A0=A0=A0pid:8866 =A0ppid:2 =A0=A0=A0=A0=A0flags:0x00004=
000=20
> =A0[Mon Mar 11 14:10:08 2024] Call Trace:=20
> =A0[Mon Mar 11 14:10:08 2024] =A0<TASK>=20
> =A0[Mon Mar 11 14:10:08 2024] =A0__schedule+0x21b/0x550=20
> =A0[Mon Mar 11 14:10:08 2024] =A0schedule+0x2d/0x70=20
> =A0[Mon Mar 11 14:10:08 2024] =A0schedule_timeout+0x11f/0x160=20
> =A0[Mon Mar 11 14:10:08 2024] =A0? select_idle_sibling+0x28/0x430=20
> =A0[Mon Mar 11 14:10:08 2024] =A0? tcp_recvmsg+0x196/0x210=20
> =A0[Mon Mar 11 14:10:08 2024] =A0? wake_affine+0x62/0x1f0=20
> =A0[Mon Mar 11 14:10:08 2024] =A0__wait_for_common+0x90/0x1d0=20
> =A0[Mon Mar 11 14:10:08 2024] =A0? __pfx_schedule_timeout+0x10/0x10=20
> =A0[Mon Mar 11 14:10:08 2024] =A0__flush_workqueue+0x13a/0x3f0=20
> =A0[Mon Mar 11 14:10:08 2024] =A0nfsd4_destroy_session+0x1a4/0x240 [nfsd]=
=20
> =A0[Mon Mar 11 14:10:08 2024] =A0nfsd4_proc_compound+0x44b/0x700 [nfsd]=
=20
> =A0[Mon Mar 11 14:10:08 2024] =A0nfsd_dispatch+0x94/0x1c0 [nfsd]=20
> =A0[Mon Mar 11 14:10:08 2024] =A0svc_process_common+0x2ec/0x660 [sunrpc]=
=20
> =A0[Mon Mar 11 14:10:08 2024] =A0? __pfx_nfsd_dispatch+0x10/0x10 [nfsd]=
=20
> =A0[Mon Mar 11 14:10:08 2024] =A0? __pfx_nfsd+0x10/0x10 [nfsd]=20
> =A0[Mon Mar 11 14:10:08 2024] =A0svc_process+0x12d/0x170 [sunrpc]=20
> =A0[Mon Mar 11 14:10:08 2024] =A0nfsd+0x84/0xb0 [nfsd]=20
> =A0[Mon Mar 11 14:10:08 2024] =A0kthread+0xdd/0x100=20
> =A0[Mon Mar 11 14:10:08 2024] =A0? __pfx_kthread+0x10/0x10=20
> =A0[Mon Mar 11 14:10:08 2024] =A0ret_from_fork+0x29/0x50=20
> =A0[Mon Mar 11 14:10:08 2024] =A0</TASK>
> =A0
> =A0
>=20
>=20
>=20
>=20
>=20
>=20
>=20
> Hi,
> =A0
>=20
>=20
>=20
>=20
>=20
>=20
>=20
> Since a few weeks our Rocky Linux 9 NFS server has periodically logged hu=
ng nfsd tasks. The initial effect was that some clients could no longer acc=
ess the NFS server. This got worse and worse (probably as more nfsd threads=
 got blocked) and we had to restart the server. Restarting the server also =
failed as the NFS server service could no longer be stopped.
> =A0
>=20
>=20
>=20
>=20
>=20
>=20
>=20
> The initial kernel we noticed this behavior on was kernel-5.14.0-362.18.1=
.el9_3.x86_64. Since then we've installed kernel-5.14.0-419.el9.x86_64 from=
 CentOS Stream 9. The same issue happened again on this newer kernel versio=
n:
> =A0
>=20
>=20
>=20
>=20
>=20
>=20
>=20
> [Mon Mar 11 14:10:08 2024] =A0=A0=A0=A0=A0=A0Not tainted 5.14.0-419.el9.x=
86_64 #1=20
> =A0[Mon Mar 11 14:10:08 2024] "echo 0 > /proc/sys/kernel/hung_task_timeou=
t_secs" disables this message.=20
> =A0[Mon Mar 11 14:10:08 2024] task:nfsd =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
state:D stack:0 =A0=A0=A0=A0pid:8865 =A0ppid:2 =A0=A0=A0=A0=A0flags:0x00004=
000=20
> =A0[Mon Mar 11 14:10:08 2024] Call Trace:=20
> =A0[Mon Mar 11 14:10:08 2024] =A0<TASK>=20
> =A0[Mon Mar 11 14:10:08 2024] =A0__schedule+0x21b/0x550=20
> =A0[Mon Mar 11 14:10:08 2024] =A0schedule+0x2d/0x70=20
> =A0[Mon Mar 11 14:10:08 2024] =A0schedule_timeout+0x11f/0x160=20
> =A0[Mon Mar 11 14:10:08 2024] =A0? select_idle_sibling+0x28/0x430=20
> =A0[Mon Mar 11 14:10:08 2024] =A0? wake_affine+0x62/0x1f0=20
> =A0[Mon Mar 11 14:10:08 2024] =A0__wait_for_common+0x90/0x1d0=20
> =A0[Mon Mar 11 14:10:08 2024] =A0? __pfx_schedule_timeout+0x10/0x10=20
> =A0[Mon Mar 11 14:10:08 2024] =A0__flush_workqueue+0x13a/0x3f0=20
> =A0[Mon Mar 11 14:10:08 2024] =A0nfsd4_shutdown_callback+0x49/0x120 [nfsd=
]=20
> =A0[Mon Mar 11 14:10:08 2024] =A0? nfsd4_cld_remove+0x54/0x1d0 [nfsd]=20
> =A0[Mon Mar 11 14:10:08 2024] =A0? nfsd4_return_all_client_layouts+0xc4/0=
xf0 [nfsd]=20
> =A0[Mon Mar 11 14:10:08 2024] =A0? nfsd4_shutdown_copy+0x68/0xc0 [nfsd]=
=20
> =A0[Mon Mar 11 14:10:08 2024] =A0__destroy_client+0x1f3/0x290 [nfsd]=20
> =A0[Mon Mar 11 14:10:08 2024] =A0nfsd4_exchange_id+0x75f/0x770 [nfsd]=20
> =A0[Mon Mar 11 14:10:08 2024] =A0? nfsd4_decode_opaque+0x3a/0x90 [nfsd]=
=20
> =A0[Mon Mar 11 14:10:08 2024] =A0nfsd4_proc_compound+0x44b/0x700 [nfsd]=
=20
> =A0[Mon Mar 11 14:10:08 2024] =A0nfsd_dispatch+0x94/0x1c0 [nfsd]=20
> =A0[Mon Mar 11 14:10:08 2024] =A0svc_process_common+0x2ec/0x660 [sunrpc]=
=20
> =A0[Mon Mar 11 14:10:08 2024] =A0? __pfx_nfsd_dispatch+0x10/0x10 [nfsd]=
=20
> =A0[Mon Mar 11 14:10:08 2024] =A0? __pfx_nfsd+0x10/0x10 [nfsd]=20
> =A0[Mon Mar 11 14:10:08 2024] =A0svc_process+0x12d/0x170 [sunrpc]=20
> =A0[Mon Mar 11 14:10:08 2024] =A0nfsd+0x84/0xb0 [nfsd]=20
> =A0[Mon Mar 11 14:10:08 2024] =A0kthread+0xdd/0x100=20
> =A0[Mon Mar 11 14:10:08 2024] =A0? __pfx_kthread+0x10/0x10=20
> =A0[Mon Mar 11 14:10:08 2024] =A0ret_from_fork+0x29/0x50=20
> =A0[Mon Mar 11 14:10:08 2024] =A0</TASK>=20
> =A0[Mon Mar 11 14:10:08 2024] INFO: task nfsd:8866 blocked for more than =
122 seconds.=20
> =A0[Mon Mar 11 14:10:08 2024] =A0=A0=A0=A0=A0=A0Not tainted 5.14.0-419.el=
9.x86_64 #1=20
> =A0[Mon Mar 11 14:10:08 2024] "echo 0 > /proc/sys/kernel/hung_task_timeou=
t_secs" disables this message.=20
> =A0[Mon Mar 11 14:10:08 2024] task:nfsd =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
state:D stack:0 =A0=A0=A0=A0pid:8866 =A0ppid:2 =A0=A0=A0=A0=A0flags:0x00004=
000=20
> =A0[Mon Mar 11 14:10:08 2024] Call Trace:=20
> =A0[Mon Mar 11 14:10:08 2024] =A0<TASK>=20
> =A0[Mon Mar 11 14:10:08 2024] =A0__schedule+0x21b/0x550=20
> =A0[Mon Mar 11 14:10:08 2024] =A0schedule+0x2d/0x70=20
> =A0[Mon Mar 11 14:10:08 2024] =A0schedule_timeout+0x11f/0x160=20
> =A0[Mon Mar 11 14:10:08 2024] =A0? select_idle_sibling+0x28/0x430=20
> =A0[Mon Mar 11 14:10:08 2024] =A0? tcp_recvmsg+0x196/0x210=20
> =A0[Mon Mar 11 14:10:08 2024] =A0? wake_affine+0x62/0x1f0=20
> =A0[Mon Mar 11 14:10:08 2024] =A0__wait_for_common+0x90/0x1d0=20
> =A0[Mon Mar 11 14:10:08 2024] =A0? __pfx_schedule_timeout+0x10/0x10=20
> =A0[Mon Mar 11 14:10:08 2024] =A0__flush_workqueue+0x13a/0x3f0=20
> =A0[Mon Mar 11 14:10:08 2024] =A0nfsd4_destroy_session+0x1a4/0x240 [nfsd]=
=20
> =A0[Mon Mar 11 14:10:08 2024] =A0nfsd4_proc_compound+0x44b/0x700 [nfsd]=
=20
> =A0[Mon Mar 11 14:10:08 2024] =A0nfsd_dispatch+0x94/0x1c0 [nfsd]=20
> =A0[Mon Mar 11 14:10:08 2024] =A0svc_process_common+0x2ec/0x660 [sunrpc]=
=20
> =A0[Mon Mar 11 14:10:08 2024] =A0? __pfx_nfsd_dispatch+0x10/0x10 [nfsd]=
=20
> =A0[Mon Mar 11 14:10:08 2024] =A0? __pfx_nfsd+0x10/0x10 [nfsd]=20
> =A0[Mon Mar 11 14:10:08 2024] =A0svc_process+0x12d/0x170 [sunrpc]=20
> =A0[Mon Mar 11 14:10:08 2024] =A0nfsd+0x84/0xb0 [nfsd]=20
> =A0[Mon Mar 11 14:10:08 2024] =A0kthread+0xdd/0x100=20
> =A0[Mon Mar 11 14:10:08 2024] =A0? __pfx_kthread+0x10/0x10=20
> =A0[Mon Mar 11 14:10:08 2024] =A0ret_from_fork+0x29/0x50=20
> =A0[Mon Mar 11 14:10:08 2024] =A0</TASK>
>=20

The above threads are trying to flush the workqueue, so that probably
means that they are stuck waiting on a workqueue job to finish.
>=20
> =A0The above is repeated a few times, and then this warning is also logge=
d:
> =A0
> [Mon Mar 11 14:12:04 2024] ------------[ cut here ]------------=20
> =A0[Mon Mar 11 14:12:04 2024] WARNING: CPU: 39 PID: 8844 at fs/nfsd/nfs4s=
tate.c:4919 nfsd_break_deleg_cb+0x170/0x190 [nfsd]=20
> =A0[Mon Mar 11 14:12:05 2024] Modules linked in: nfsv4 dns_resolver nfs f=
scache netfs rpcsec_gss_krb5 rpcrdma rdma_cm iw_cm ib_cm ib_core binfmt_mis=
c bonding tls rfkill nft_counter nft_ct=20
> =A0nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 nft_reject_inet nf_reject_i=
pv4 nf_reject_ipv6 nft_reject nf_tables nfnetlink vfat fat dm_thin_pool dm_=
persistent_data dm_bio_prison dm_bufio l
> =A0ibcrc32c dm_service_time dm_multipath intel_rapl_msr intel_rapl_common=
 intel_uncore_frequency intel_uncore_frequency_common isst_if_common skx_ed=
ac nfit libnvdimm ipmi_ssif x86_pkg_temp
> =A0_thermal intel_powerclamp coretemp kvm_intel kvm irqbypass dcdbas rapl=
 intel_cstate mgag200 i2c_algo_bit drm_shmem_helper dell_smbios drm_kms_hel=
per dell_wmi_descriptor wmi_bmof intel_u
> =A0ncore syscopyarea pcspkr sysfillrect mei_me sysimgblt acpi_ipmi mei fb=
_sys_fops i2c_i801 ipmi_si intel_pch_thermal lpc_ich ipmi_devintf i2c_smbus=
 ipmi_msghandler joydev acpi_power_meter
> =A0nfsd auth_rpcgss nfs_acl drm lockd grace fuse sunrpc ext4 mbcache jbd2=
 sd_mod sg lpfc=20
> =A0[Mon Mar 11 14:12:05 2024] =A0nvmet_fc nvmet nvme_fc nvme_fabrics crct=
10dif_pclmul ahci libahci crc32_pclmul nvme_core crc32c_intel ixgbe megarai=
d_sas libata nvme_common ghash_clmulni_int
> =A0el t10_pi wdat_wdt scsi_transport_fc mdio wmi dca dm_mirror dm_region_=
hash dm_log dm_mod=20
> =A0[Mon Mar 11 14:12:05 2024] CPU: 39 PID: 8844 Comm: nfsd Not tainted 5.=
14.0-419.el9.x86_64 #1=20
> =A0[Mon Mar 11 14:12:05 2024] Hardware name: Dell Inc. PowerEdge R740/00W=
GD1, BIOS 2.20.1 09/13/2023=20
> =A0[Mon Mar 11 14:12:05 2024] RIP: 0010:nfsd_break_deleg_cb+0x170/0x190 [=
nfsd]=20
> =A0[Mon Mar 11 14:12:05 2024] Code: a6 95 c5 f3 e9 ff fe ff ff 48 89 df b=
e 01 00 00 00 e8 34 b5 13 f4 48 8d bb 98 00 00 00 e8 c8 f9 00 00 84 c0 0f 8=
5 2e ff ff ff <0f> 0b e9 27 ff ff ff be=20
> =A002 00 00 00 48 89 df e8 0c b5 13 f4 e9 01=20
> =A0[Mon Mar 11 14:12:05 2024] RSP: 0018:ffff9929e0bb7b80 EFLAGS: 00010246=
=20
> =A0[Mon Mar 11 14:12:05 2024] RAX: 0000000000000000 RBX: ffff8ada51930900=
 RCX: 0000000000000024=20
> =A0[Mon Mar 11 14:12:05 2024] RDX: ffff8ada519309c8 RSI: ffff8ad582933c00=
 RDI: 0000000000002000=20
> =A0[Mon Mar 11 14:12:05 2024] RBP: ffff8ad46bf21574 R08: ffff9929e0bb7b48=
 R09: 0000000000000000=20
> =A0[Mon Mar 11 14:12:05 2024] R10: ffff8aec859a2948 R11: 0000000000000000=
 R12: ffff8ad6f497c360=20
> =A0[Mon Mar 11 14:12:05 2024] R13: ffff8ad46bf21560 R14: ffff8ae5942e0b10=
 R15: ffff8ad6f497c360=20
> =A0[Mon Mar 11 14:12:05 2024] FS: =A00000000000000000(0000) GS:ffff8b031f=
cc0000(0000) knlGS:0000000000000000=20
> =A0[Mon Mar 11 14:12:05 2024] CS: =A00010 DS: 0000 ES: 0000 CR0: 00000000=
80050033=20
> =A0[Mon Mar 11 14:12:05 2024] CR2: 00007fafe2060744 CR3: 00000018e58de006=
 CR4: 00000000007706e0=20
> =A0[Mon Mar 11 14:12:05 2024] DR0: 0000000000000000 DR1: 0000000000000000=
 DR2: 0000000000000000=20
> =A0[Mon Mar 11 14:12:05 2024] DR3: 0000000000000000 DR6: 00000000fffe0ff0=
 DR7: 0000000000000400=20
> =A0[Mon Mar 11 14:12:05 2024] PKRU: 55555554=20
> =A0[Mon Mar 11 14:12:05 2024] Call Trace:=20
> =A0[Mon Mar 11 14:12:05 2024] =A0<TASK>=20
> =A0[Mon Mar 11 14:12:05 2024] =A0? show_trace_log_lvl+0x1c4/0x2df=20
> =A0[Mon Mar 11 14:12:05 2024] =A0? show_trace_log_lvl+0x1c4/0x2df=20
> =A0[Mon Mar 11 14:12:05 2024] =A0? __break_lease+0x16f/0x5f0=20
> =A0[Mon Mar 11 14:12:05 2024] =A0? nfsd_break_deleg_cb+0x170/0x190 [nfsd]=
=20
> =A0[Mon Mar 11 14:12:05 2024] =A0? __warn+0x81/0x110=20
> =A0[Mon Mar 11 14:12:05 2024] =A0? nfsd_break_deleg_cb+0x170/0x190 [nfsd]=
=20
> =A0[Mon Mar 11 14:12:05 2024] =A0? report_bug+0x10a/0x140=20
> =A0[Mon Mar 11 14:12:05 2024] =A0? handle_bug+0x3c/0x70=20
> =A0[Mon Mar 11 14:12:05 2024] =A0? exc_invalid_op+0x14/0x70=20
> =A0[Mon Mar 11 14:12:05 2024] =A0? asm_exc_invalid_op+0x16/0x20=20
> =A0[Mon Mar 11 14:12:05 2024] =A0? nfsd_break_deleg_cb+0x170/0x190 [nfsd]=
=20
> =A0[Mon Mar 11 14:12:05 2024] =A0__break_lease+0x16f/0x5f0=20
> =A0[Mon Mar 11 14:12:05 2024] =A0? nfsd_file_lookup_locked+0x117/0x160 [n=
fsd]=20
> =A0[Mon Mar 11 14:12:05 2024] =A0? list_lru_del+0x101/0x150=20
> =A0[Mon Mar 11 14:12:05 2024] =A0nfsd_file_do_acquire+0x790/0x830 [nfsd]=
=20
> =A0[Mon Mar 11 14:12:05 2024] =A0nfs4_get_vfs_file+0x315/0x3a0 [nfsd]=20
> =A0[Mon Mar 11 14:12:05 2024] =A0nfsd4_process_open2+0x430/0xa30 [nfsd]=
=20
> =A0[Mon Mar 11 14:12:05 2024] =A0? fh_verify+0x297/0x2f0 [nfsd]=20
> =A0[Mon Mar 11 14:12:05 2024] =A0nfsd4_open+0x3ce/0x4b0 [nfsd]=20
> =A0[Mon Mar 11 14:12:05 2024] =A0nfsd4_proc_compound+0x44b/0x700 [nfsd]=
=20
> =A0[Mon Mar 11 14:12:05 2024] =A0nfsd_dispatch+0x94/0x1c0 [nfsd]=20
> =A0[Mon Mar 11 14:12:05 2024] =A0svc_process_common+0x2ec/0x660 [sunrpc]=
=20
> =A0[Mon Mar 11 14:12:05 2024] =A0? __pfx_nfsd_dispatch+0x10/0x10 [nfsd]=
=20
> =A0[Mon Mar 11 14:12:05 2024] =A0? __pfx_nfsd+0x10/0x10 [nfsd]=20
> =A0[Mon Mar 11 14:12:05 2024] =A0svc_process+0x12d/0x170 [sunrpc]=20
> =A0[Mon Mar 11 14:12:05 2024] =A0nfsd+0x84/0xb0 [nfsd]=20
> =A0[Mon Mar 11 14:12:05 2024] =A0kthread+0xdd/0x100=20
> =A0[Mon Mar 11 14:12:05 2024] =A0? __pfx_kthread+0x10/0x10=20
> =A0[Mon Mar 11 14:12:05 2024] =A0ret_from_fork+0x29/0x50=20
> =A0[Mon Mar 11 14:12:05 2024] =A0</TASK>=20
> =A0[Mon Mar 11 14:12:05 2024] ---[ end trace 7a039e17443dc651 ]---

This is probably this WARN in nfsd_break_one_deleg:

        WARN_ON_ONCE(!nfsd4_run_cb(&dp->dl_recall));                  =20

It means that a delegation break callback to the client couldn't be
queued to the workqueue, and so it didn't run.

>=20
> Could this be the same issue as described here:https://lore.kernel.org/li=
nux-nfs/af0ec881-5ebf-4feb-98ae-3ed2a77f86f1@oracle.com/ ?
> =A0

Yes, most likely the same problem.


> As described in that thread, I've tried to obtain the requested informati=
on.
> =A0
>=20

> Is it possible this is the issue that was fixed by the patches described =
here? https://lore.kernel.org/linux-nfs/2024022054-cause-suffering-eae8@gre=
gkh/
>=20

Doubtful. Those are targeted toward a different set of issues.

If you're willing, I do have some patches queued up for CentOS here that
fix some backchannel problems that could be related. I'm mainly waiting
on Chuck to send these to Linus and then we'll likely merge them into
CentOS soon afterward:

https://gitlab.com/redhat/centos-stream/src/kernel/centos-stream-9/-/merge_=
requests/3689

--=20
Jeff Layton <jlayton@poochiereds.net>

