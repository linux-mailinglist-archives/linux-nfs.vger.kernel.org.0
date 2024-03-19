Return-Path: <linux-nfs+bounces-2389-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4502387FBE9
	for <lists+linux-nfs@lfdr.de>; Tue, 19 Mar 2024 11:39:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99E4F282A4D
	for <lists+linux-nfs@lfdr.de>; Tue, 19 Mar 2024 10:39:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0948242A82;
	Tue, 19 Mar 2024 10:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rUXn91tX"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7DDB41A84
	for <linux-nfs@vger.kernel.org>; Tue, 19 Mar 2024 10:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710844751; cv=none; b=rCFPaM0f5FFZ4xIiL656PvsawiAO92xGzEwaBt6iOdAiwOiMqi5pQjPuiT3E+4ETlq0naNmrIyJDWkqYG19mATHJQ5gsba0wIlR6qgpef8emywXVKLksGyWdGvKm8JvuFqVVgLTcOAxSaOhrmUUZjwvx3I+L2+8my0b0BWVSM/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710844751; c=relaxed/simple;
	bh=bLH6+QlNnN7YhCNz4dqLIr3yUtmCu5HIz3NaT2whMy8=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PEgnuvi+aOXKieQ8jPzVnva13jsG85XKyNB3ZFJJI4LUbEF8hu+P8sCxWCLfrRsXq0gz9U0UCu6ZsjRluVWNfbpheMUSh8017h7Piv3070xAYzcPnMm0f7s1wJLl3SX56nOY+PYMnGzKzG3YIEwCgiwvLV+RXvJkW+AeywH6iZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rUXn91tX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B900C433C7;
	Tue, 19 Mar 2024 10:39:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710844751;
	bh=bLH6+QlNnN7YhCNz4dqLIr3yUtmCu5HIz3NaT2whMy8=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=rUXn91tXdNsh2Mn7Pu3m9MAhOTyq3f9uthWNJGKG+WZaOekrnyQ2SrVeQHDkyoe82
	 4FG0t91VWfn4VGnI5nWofL2IjaYPedJLppB17MZ4+z3nafJZEvibfQFSAs/uKoEKV9
	 5fzitHeVYiH84AeU76t7gPF1mmzJlnyzjsFIh4BLvsC7RcRzkcA/UV6Wslz1OYI7zn
	 N0i6a5Iy49yhnBwNm0mttst3S6KFChz60upXFYX3D7YkatBDw0vuc06RZ0PwMtdRPs
	 TsiXkmJtzW3f80eH/1MyYk7x5G80mM4a9lCmNq5EPgrE5XJGsOWrfFMTSrDQcUzXuH
	 7ZOPmPKt/ieCw==
Message-ID: <caeb133cc80c730e84f97732581d8d59def342b8.camel@kernel.org>
Subject: Re: nfsd hangs and nfsd_break_deleg_cb+0x170/0x190 warning
From: Jeff Layton <jlayton@kernel.org>
To: Rik Theys <Rik.Theys@esat.kuleuven.be>, Linux Nfs
	 <linux-nfs@vger.kernel.org>
Date: Tue, 19 Mar 2024 06:39:09 -0400
In-Reply-To: <c7dbc796-7e7d-4041-ac71-eea02a701b12@esat.kuleuven.be>
References: <66c98f4c-5e52-4fa3-8a2c-9379cfec2a9a@esat.kuleuven.be>
	 <44c2101e756f7c3b876fb9c58da3ebd089dc14d5.camel@kernel.org>
	 <e3ba6e04-ea06-4035-8546-639f11d6b79c@esat.kuleuven.be>
	 <41325088-aa6d-4dcf-b105-8994350168c3@esat.kuleuven.be>
	 <7d244882d769e377b06f39234bd5ee7dddb72a55.camel@kernel.org>
	 <c7dbc796-7e7d-4041-ac71-eea02a701b12@esat.kuleuven.be>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
	kZWuOsJdJQdmwlWC5L5ln9xgfr/4mOY38B0U=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-03-19 at 08:58 +0100, Rik Theys wrote:
> Hi,
>=20
> On 3/18/24 22:54, Jeff Layton wrote:
> > On Mon, 2024-03-18 at 22:15 +0100, Rik Theys wrote:
> > > Hi,
> > >=20
> > > On 3/18/24 21:21, Rik Theys wrote:
> > > > Hi Jeff,
> > > >=20
> > > > On 3/12/24 13:47, Jeff Layton wrote:
> > > > > On Tue, 2024-03-12 at 13:24 +0100, Rik Theys wrote:
> > > > > > Hi Jeff,
> > > > > >=20
> > > > > > On 3/12/24 12:22, Jeff Layton wrote:
> > > > > > > On Mon, 2024-03-11 at 19:43 +0100, Rik Theys wrote:
> > > > > > > > Since a few weeks our Rocky Linux 9 NFS server has periodic=
ally
> > > > > > > > logged hung nfsd tasks. The initial effect was that some cl=
ients
> > > > > > > > could no longer access the NFS server. This got worse and w=
orse
> > > > > > > > (probably as more nfsd threads got blocked) and we had to r=
estart
> > > > > > > > the server. Restarting the server also failed as the NFS se=
rver
> > > > > > > > service could no longer be stopped.
> > > > > > > >=20
> > > > > > > > The initial kernel we noticed this behavior on was
> > > > > > > > kernel-5.14.0-362.18.1.el9_3.x86_64. Since then we've insta=
lled
> > > > > > > > kernel-5.14.0-419.el9.x86_64 from CentOS Stream 9. The same=
 issue
> > > > > > > > happened again on this newer kernel version:
> > > > > 419 is fairly up to date with nfsd changes. There are some known =
bugs
> > > > > around callbacks, and there is a draft MR in flight to fix it.
> > > > >=20
> > > > > What kernel were you on prior to 5.14.0-362.18.1.el9_3.x86_64 ? I=
f we
> > > > > can bracket the changes around a particular version, then that mi=
ght
> > > > > help identify the problem.
> > > > >=20
> > > > > > > > [Mon Mar 11 14:10:08 2024] =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0Not tainted 5.14.0-419.el9.x86_64 #1
> > > > > > > >  =C2=A0 =C2=A0[Mon Mar 11 14:10:08 2024] "echo 0 >
> > > > > > > > /proc/sys/kernel/hung_task_timeout_secs" disables this mess=
age.
> > > > > > > >  =C2=A0 =C2=A0[Mon Mar 11 14:10:08 2024]task:nfsd=C2=A0 =C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0state:D stac=
k:0
> > > > > > > >  =C2=A0=C2=A0=C2=A0=C2=A0pid:8865 =C2=A0ppid:2 =C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0flags:0x00004000
> > > > > > > >  =C2=A0 =C2=A0[Mon Mar 11 14:10:08 2024] Call Trace:
> > > > > > > >  =C2=A0 =C2=A0[Mon Mar 11 14:10:08 2024] =C2=A0<TASK>
> > > > > > > >  =C2=A0 =C2=A0[Mon Mar 11 14:10:08 2024] =C2=A0__schedule+0=
x21b/0x550
> > > > > > > >  =C2=A0 =C2=A0[Mon Mar 11 14:10:08 2024] =C2=A0schedule+0x2=
d/0x70
> > > > > > > >  =C2=A0 =C2=A0[Mon Mar 11 14:10:08 2024] =C2=A0schedule_tim=
eout+0x11f/0x160
> > > > > > > >  =C2=A0 =C2=A0[Mon Mar 11 14:10:08 2024] =C2=A0? select_idl=
e_sibling+0x28/0x430
> > > > > > > >  =C2=A0 =C2=A0[Mon Mar 11 14:10:08 2024] =C2=A0? wake_affin=
e+0x62/0x1f0
> > > > > > > >  =C2=A0 =C2=A0[Mon Mar 11 14:10:08 2024] =C2=A0__wait_for_c=
ommon+0x90/0x1d0
> > > > > > > >  =C2=A0 =C2=A0[Mon Mar 11 14:10:08 2024] =C2=A0? __pfx_sche=
dule_timeout+0x10/0x10
> > > > > > > >  =C2=A0 =C2=A0[Mon Mar 11 14:10:08 2024] =C2=A0__flush_work=
queue+0x13a/0x3f0
> > > > > > > >  =C2=A0 =C2=A0[Mon Mar 11 14:10:08 2024] =C2=A0nfsd4_shutdo=
wn_callback+0x49/0x120
> > > > > > > > [nfsd]
> > > > > > > >  =C2=A0 =C2=A0[Mon Mar 11 14:10:08 2024] =C2=A0? nfsd4_cld_=
remove+0x54/0x1d0 [nfsd]
> > > > > > > >  =C2=A0 =C2=A0[Mon Mar 11 14:10:08 2024] =C2=A0?
> > > > > > > > nfsd4_return_all_client_layouts+0xc4/0xf0 [nfsd]
> > > > > > > >  =C2=A0 =C2=A0[Mon Mar 11 14:10:08 2024] =C2=A0? nfsd4_shut=
down_copy+0x68/0xc0 [nfsd]
> > > > > > > >  =C2=A0 =C2=A0[Mon Mar 11 14:10:08 2024] =C2=A0__destroy_cl=
ient+0x1f3/0x290 [nfsd]
> > > > > > > >  =C2=A0 =C2=A0[Mon Mar 11 14:10:08 2024] =C2=A0nfsd4_exchan=
ge_id+0x75f/0x770 [nfsd]
> > > > > > > >  =C2=A0 =C2=A0[Mon Mar 11 14:10:08 2024] =C2=A0? nfsd4_deco=
de_opaque+0x3a/0x90 [nfsd]
> > > > > > > >  =C2=A0 =C2=A0[Mon Mar 11 14:10:08 2024] =C2=A0nfsd4_proc_c=
ompound+0x44b/0x700 [nfsd]
> > > > > > > >  =C2=A0 =C2=A0[Mon Mar 11 14:10:08 2024] =C2=A0nfsd_dispatc=
h+0x94/0x1c0 [nfsd]
> > > > > > > >  =C2=A0 =C2=A0[Mon Mar 11 14:10:08 2024] =C2=A0svc_process_=
common+0x2ec/0x660
> > > > > > > > [sunrpc]
> > > > > > > >  =C2=A0 =C2=A0[Mon Mar 11 14:10:08 2024] =C2=A0? __pfx_nfsd=
_dispatch+0x10/0x10 [nfsd]
> > > > > > > >  =C2=A0 =C2=A0[Mon Mar 11 14:10:08 2024] =C2=A0? __pfx_nfsd=
+0x10/0x10 [nfsd]
> > > > > > > >  =C2=A0 =C2=A0[Mon Mar 11 14:10:08 2024] =C2=A0svc_process+=
0x12d/0x170 [sunrpc]
> > > > > > > >  =C2=A0 =C2=A0[Mon Mar 11 14:10:08 2024] =C2=A0nfsd+0x84/0x=
b0 [nfsd]
> > > > > > > >  =C2=A0 =C2=A0[Mon Mar 11 14:10:08 2024] =C2=A0kthread+0xdd=
/0x100
> > > > > > > >  =C2=A0 =C2=A0[Mon Mar 11 14:10:08 2024] =C2=A0? __pfx_kthr=
ead+0x10/0x10
> > > > > > > >  =C2=A0 =C2=A0[Mon Mar 11 14:10:08 2024] =C2=A0ret_from_for=
k+0x29/0x50
> > > > > > > >  =C2=A0 =C2=A0[Mon Mar 11 14:10:08 2024] =C2=A0</TASK>
> > > > > > > >  =C2=A0 =C2=A0[Mon Mar 11 14:10:08 2024] INFO: task nfsd:88=
66 blocked for
> > > > > > > > more than 122 seconds.
> > > > > > > >  =C2=A0 =C2=A0[Mon Mar 11 14:10:08 2024] =C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0Not tainted
> > > > > > > > 5.14.0-419.el9.x86_64 #1
> > > > > > > >  =C2=A0 =C2=A0[Mon Mar 11 14:10:08 2024] "echo 0 >
> > > > > > > > /proc/sys/kernel/hung_task_timeout_secs" disables this mess=
age.
> > > > > > > >  =C2=A0 =C2=A0[Mon Mar 11 14:10:08 2024]task:nfsd=C2=A0 =C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0state:D stac=
k:0
> > > > > > > >  =C2=A0=C2=A0=C2=A0=C2=A0pid:8866 =C2=A0ppid:2 =C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0flags:0x00004000
> > > > > > > >  =C2=A0 =C2=A0[Mon Mar 11 14:10:08 2024] Call Trace:
> > > > > > > >  =C2=A0 =C2=A0[Mon Mar 11 14:10:08 2024] =C2=A0<TASK>
> > > > > > > >  =C2=A0 =C2=A0[Mon Mar 11 14:10:08 2024] =C2=A0__schedule+0=
x21b/0x550
> > > > > > > >  =C2=A0 =C2=A0[Mon Mar 11 14:10:08 2024] =C2=A0schedule+0x2=
d/0x70
> > > > > > > >  =C2=A0 =C2=A0[Mon Mar 11 14:10:08 2024] =C2=A0schedule_tim=
eout+0x11f/0x160
> > > > > > > >  =C2=A0 =C2=A0[Mon Mar 11 14:10:08 2024] =C2=A0? select_idl=
e_sibling+0x28/0x430
> > > > > > > >  =C2=A0 =C2=A0[Mon Mar 11 14:10:08 2024] =C2=A0? tcp_recvms=
g+0x196/0x210
> > > > > > > >  =C2=A0 =C2=A0[Mon Mar 11 14:10:08 2024] =C2=A0? wake_affin=
e+0x62/0x1f0
> > > > > > > >  =C2=A0 =C2=A0[Mon Mar 11 14:10:08 2024] =C2=A0__wait_for_c=
ommon+0x90/0x1d0
> > > > > > > >  =C2=A0 =C2=A0[Mon Mar 11 14:10:08 2024] =C2=A0? __pfx_sche=
dule_timeout+0x10/0x10
> > > > > > > >  =C2=A0 =C2=A0[Mon Mar 11 14:10:08 2024] =C2=A0__flush_work=
queue+0x13a/0x3f0
> > > > > > > >  =C2=A0 =C2=A0[Mon Mar 11 14:10:08 2024] =C2=A0nfsd4_destro=
y_session+0x1a4/0x240
> > > > > > > > [nfsd]
> > > > > > > >  =C2=A0 =C2=A0[Mon Mar 11 14:10:08 2024] =C2=A0nfsd4_proc_c=
ompound+0x44b/0x700 [nfsd]
> > > > > > > >  =C2=A0 =C2=A0[Mon Mar 11 14:10:08 2024] =C2=A0nfsd_dispatc=
h+0x94/0x1c0 [nfsd]
> > > > > > > >  =C2=A0 =C2=A0[Mon Mar 11 14:10:08 2024] =C2=A0svc_process_=
common+0x2ec/0x660
> > > > > > > > [sunrpc]
> > > > > > > >  =C2=A0 =C2=A0[Mon Mar 11 14:10:08 2024] =C2=A0? __pfx_nfsd=
_dispatch+0x10/0x10 [nfsd]
> > > > > > > >  =C2=A0 =C2=A0[Mon Mar 11 14:10:08 2024] =C2=A0? __pfx_nfsd=
+0x10/0x10 [nfsd]
> > > > > > > >  =C2=A0 =C2=A0[Mon Mar 11 14:10:08 2024] =C2=A0svc_process+=
0x12d/0x170 [sunrpc]
> > > > > > > >  =C2=A0 =C2=A0[Mon Mar 11 14:10:08 2024] =C2=A0nfsd+0x84/0x=
b0 [nfsd]
> > > > > > > >  =C2=A0 =C2=A0[Mon Mar 11 14:10:08 2024] =C2=A0kthread+0xdd=
/0x100
> > > > > > > >  =C2=A0 =C2=A0[Mon Mar 11 14:10:08 2024] =C2=A0? __pfx_kthr=
ead+0x10/0x10
> > > > > > > >  =C2=A0 =C2=A0[Mon Mar 11 14:10:08 2024] =C2=A0ret_from_for=
k+0x29/0x50
> > > > > > > >  =C2=A0 =C2=A0[Mon Mar 11 14:10:08 2024] =C2=A0</TASK>
> > > > > > > >=20
> > > > > > > The above threads are trying to flush the workqueue, so that =
probably
> > > > > > > means that they are stuck waiting on a workqueue job to finis=
h.
> > > > > > > >  =C2=A0 =C2=A0The above is repeated a few times, and then t=
his warning is
> > > > > > > > also logged:
> > > > > > > >  =C2=A0=C2=A0 [Mon Mar 11 14:12:04 2024] ------------[ cut =
here ]------------
> > > > > > > >  =C2=A0 =C2=A0[Mon Mar 11 14:12:04 2024] WARNING: CPU: 39 P=
ID: 8844 at
> > > > > > > > fs/nfsd/nfs4state.c:4919 nfsd_break_deleg_cb+0x170/0x190 [n=
fsd]
> > > > > > > >  =C2=A0 =C2=A0[Mon Mar 11 14:12:05 2024] Modules linked in:=
 nfsv4
> > > > > > > > dns_resolver nfs fscache netfs rpcsec_gss_krb5 rpcrdma rdma=
_cm
> > > > > > > > iw_cm ib_cm ib_core binfmt_misc bonding tls rfkill nft_coun=
ter nft_ct
> > > > > > > >  =C2=A0 =C2=A0nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 nf=
t_reject_inet
> > > > > > > > nf_reject_ipv4 nf_reject_ipv6 nft_reject nf_tables nfnetlin=
k vfat
> > > > > > > > fat dm_thin_pool dm_persistent_data dm_bio_prison dm_bufio =
l
> > > > > > > >  =C2=A0 =C2=A0ibcrc32c dm_service_time dm_multipath intel_r=
apl_msr
> > > > > > > > intel_rapl_common intel_uncore_frequency
> > > > > > > > intel_uncore_frequency_common isst_if_common skx_edac nfit
> > > > > > > > libnvdimm ipmi_ssif x86_pkg_temp
> > > > > > > >  =C2=A0 =C2=A0_thermal intel_powerclamp coretemp kvm_intel =
kvm irqbypass
> > > > > > > > dcdbas rapl intel_cstate mgag200 i2c_algo_bit drm_shmem_hel=
per
> > > > > > > > dell_smbios drm_kms_helper dell_wmi_descriptor wmi_bmof int=
el_u
> > > > > > > >  =C2=A0 =C2=A0ncore syscopyarea pcspkr sysfillrect mei_me s=
ysimgblt acpi_ipmi
> > > > > > > > mei fb_sys_fops i2c_i801 ipmi_si intel_pch_thermal lpc_ich
> > > > > > > > ipmi_devintf i2c_smbus ipmi_msghandler joydev acpi_power_me=
ter
> > > > > > > >  =C2=A0 =C2=A0nfsd auth_rpcgss nfs_acl drm lockd grace fuse=
 sunrpc ext4
> > > > > > > > mbcache jbd2 sd_mod sg lpfc
> > > > > > > >  =C2=A0 =C2=A0[Mon Mar 11 14:12:05 2024] =C2=A0nvmet_fc nvm=
et nvme_fc nvme_fabrics
> > > > > > > > crct10dif_pclmul ahci libahci crc32_pclmul nvme_core crc32c=
_intel
> > > > > > > > ixgbe megaraid_sas libata nvme_common ghash_clmulni_int
> > > > > > > >  =C2=A0 =C2=A0el t10_pi wdat_wdt scsi_transport_fc mdio wmi=
 dca dm_mirror
> > > > > > > > dm_region_hash dm_log dm_mod
> > > > > > > >  =C2=A0 =C2=A0[Mon Mar 11 14:12:05 2024] CPU: 39 PID: 8844 =
Comm: nfsd Not
> > > > > > > > tainted 5.14.0-419.el9.x86_64 #1
> > > > > > > >  =C2=A0 =C2=A0[Mon Mar 11 14:12:05 2024] Hardware name: Del=
l Inc. PowerEdge
> > > > > > > > R740/00WGD1, BIOS 2.20.1 09/13/2023
> > > > > > > >  =C2=A0 =C2=A0[Mon Mar 11 14:12:05 2024] RIP:
> > > > > > > > 0010:nfsd_break_deleg_cb+0x170/0x190 [nfsd]
> > > > > > > >  =C2=A0 =C2=A0[Mon Mar 11 14:12:05 2024] Code: a6 95 c5 f3 =
e9 ff fe ff ff 48
> > > > > > > > 89 df be 01 00 00 00 e8 34 b5 13 f4 48 8d bb 98 00 00 00 e8=
 c8 f9
> > > > > > > > 00 00 84 c0 0f 85 2e ff ff ff <0f> 0b e9 27 ff ff ff be
> > > > > > > >  =C2=A0 =C2=A002 00 00 00 48 89 df e8 0c b5 13 f4 e9 01
> > > > > > > >  =C2=A0 =C2=A0[Mon Mar 11 14:12:05 2024] RSP: 0018:ffff9929=
e0bb7b80 EFLAGS:
> > > > > > > > 00010246
> > > > > > > >  =C2=A0 =C2=A0[Mon Mar 11 14:12:05 2024] RAX: 0000000000000=
000 RBX:
> > > > > > > > ffff8ada51930900 RCX: 0000000000000024
> > > > > > > >  =C2=A0 =C2=A0[Mon Mar 11 14:12:05 2024] RDX: ffff8ada51930=
9c8 RSI:
> > > > > > > > ffff8ad582933c00 RDI: 0000000000002000
> > > > > > > >  =C2=A0 =C2=A0[Mon Mar 11 14:12:05 2024] RBP: ffff8ad46bf21=
574 R08:
> > > > > > > > ffff9929e0bb7b48 R09: 0000000000000000
> > > > > > > >  =C2=A0 =C2=A0[Mon Mar 11 14:12:05 2024] R10: ffff8aec859a2=
948 R11:
> > > > > > > > 0000000000000000 R12: ffff8ad6f497c360
> > > > > > > >  =C2=A0 =C2=A0[Mon Mar 11 14:12:05 2024] R13: ffff8ad46bf21=
560 R14:
> > > > > > > > ffff8ae5942e0b10 R15: ffff8ad6f497c360
> > > > > > > >  =C2=A0 =C2=A0[Mon Mar 11 14:12:05 2024] FS: =C2=A000000000=
00000000(0000)
> > > > > > > > GS:ffff8b031fcc0000(0000) knlGS:0000000000000000
> > > > > > > >  =C2=A0 =C2=A0[Mon Mar 11 14:12:05 2024] CS: =C2=A00010 DS:=
 0000 ES: 0000 CR0:
> > > > > > > > 0000000080050033
> > > > > > > >  =C2=A0 =C2=A0[Mon Mar 11 14:12:05 2024] CR2: 00007fafe2060=
744 CR3:
> > > > > > > > 00000018e58de006 CR4: 00000000007706e0
> > > > > > > >  =C2=A0 =C2=A0[Mon Mar 11 14:12:05 2024] DR0: 0000000000000=
000 DR1:
> > > > > > > > 0000000000000000 DR2: 0000000000000000
> > > > > > > >  =C2=A0 =C2=A0[Mon Mar 11 14:12:05 2024] DR3: 0000000000000=
000 DR6:
> > > > > > > > 00000000fffe0ff0 DR7: 0000000000000400
> > > > > > > >  =C2=A0 =C2=A0[Mon Mar 11 14:12:05 2024] PKRU: 55555554
> > > > > > > >  =C2=A0 =C2=A0[Mon Mar 11 14:12:05 2024] Call Trace:
> > > > > > > >  =C2=A0 =C2=A0[Mon Mar 11 14:12:05 2024] =C2=A0<TASK>
> > > > > > > >  =C2=A0 =C2=A0[Mon Mar 11 14:12:05 2024] =C2=A0? show_trace=
_log_lvl+0x1c4/0x2df
> > > > > > > >  =C2=A0 =C2=A0[Mon Mar 11 14:12:05 2024] =C2=A0? show_trace=
_log_lvl+0x1c4/0x2df
> > > > > > > >  =C2=A0 =C2=A0[Mon Mar 11 14:12:05 2024] =C2=A0? __break_le=
ase+0x16f/0x5f0
> > > > > > > >  =C2=A0 =C2=A0[Mon Mar 11 14:12:05 2024] =C2=A0? nfsd_break=
_deleg_cb+0x170/0x190
> > > > > > > > [nfsd]
> > > > > > > >  =C2=A0 =C2=A0[Mon Mar 11 14:12:05 2024] =C2=A0? __warn+0x8=
1/0x110
> > > > > > > >  =C2=A0 =C2=A0[Mon Mar 11 14:12:05 2024] =C2=A0? nfsd_break=
_deleg_cb+0x170/0x190
> > > > > > > > [nfsd]
> > > > > > > >  =C2=A0 =C2=A0[Mon Mar 11 14:12:05 2024] =C2=A0? report_bug=
+0x10a/0x140
> > > > > > > >  =C2=A0 =C2=A0[Mon Mar 11 14:12:05 2024] =C2=A0? handle_bug=
+0x3c/0x70
> > > > > > > >  =C2=A0 =C2=A0[Mon Mar 11 14:12:05 2024] =C2=A0? exc_invali=
d_op+0x14/0x70
> > > > > > > >  =C2=A0 =C2=A0[Mon Mar 11 14:12:05 2024] =C2=A0? asm_exc_in=
valid_op+0x16/0x20
> > > > > > > >  =C2=A0 =C2=A0[Mon Mar 11 14:12:05 2024] =C2=A0? nfsd_break=
_deleg_cb+0x170/0x190
> > > > > > > > [nfsd]
> > > > > > > >  =C2=A0 =C2=A0[Mon Mar 11 14:12:05 2024] =C2=A0__break_leas=
e+0x16f/0x5f0
> > > > > > > >  =C2=A0 =C2=A0[Mon Mar 11 14:12:05 2024] =C2=A0?
> > > > > > > > nfsd_file_lookup_locked+0x117/0x160 [nfsd]
> > > > > > > >  =C2=A0 =C2=A0[Mon Mar 11 14:12:05 2024] =C2=A0? list_lru_d=
el+0x101/0x150
> > > > > > > >  =C2=A0 =C2=A0[Mon Mar 11 14:12:05 2024] =C2=A0nfsd_file_do=
_acquire+0x790/0x830
> > > > > > > > [nfsd]
> > > > > > > >  =C2=A0 =C2=A0[Mon Mar 11 14:12:05 2024] =C2=A0nfs4_get_vfs=
_file+0x315/0x3a0 [nfsd]
> > > > > > > >  =C2=A0 =C2=A0[Mon Mar 11 14:12:05 2024] =C2=A0nfsd4_proces=
s_open2+0x430/0xa30 [nfsd]
> > > > > > > >  =C2=A0 =C2=A0[Mon Mar 11 14:12:05 2024] =C2=A0? fh_verify+=
0x297/0x2f0 [nfsd]
> > > > > > > >  =C2=A0 =C2=A0[Mon Mar 11 14:12:05 2024] =C2=A0nfsd4_open+0=
x3ce/0x4b0 [nfsd]
> > > > > > > >  =C2=A0 =C2=A0[Mon Mar 11 14:12:05 2024] =C2=A0nfsd4_proc_c=
ompound+0x44b/0x700 [nfsd]
> > > > > > > >  =C2=A0 =C2=A0[Mon Mar 11 14:12:05 2024] =C2=A0nfsd_dispatc=
h+0x94/0x1c0 [nfsd]
> > > > > > > >  =C2=A0 =C2=A0[Mon Mar 11 14:12:05 2024] =C2=A0svc_process_=
common+0x2ec/0x660
> > > > > > > > [sunrpc]
> > > > > > > >  =C2=A0 =C2=A0[Mon Mar 11 14:12:05 2024] =C2=A0? __pfx_nfsd=
_dispatch+0x10/0x10 [nfsd]
> > > > > > > >  =C2=A0 =C2=A0[Mon Mar 11 14:12:05 2024] =C2=A0? __pfx_nfsd=
+0x10/0x10 [nfsd]
> > > > > > > >  =C2=A0 =C2=A0[Mon Mar 11 14:12:05 2024] =C2=A0svc_process+=
0x12d/0x170 [sunrpc]
> > > > > > > >  =C2=A0 =C2=A0[Mon Mar 11 14:12:05 2024] =C2=A0nfsd+0x84/0x=
b0 [nfsd]
> > > > > > > >  =C2=A0 =C2=A0[Mon Mar 11 14:12:05 2024] =C2=A0kthread+0xdd=
/0x100
> > > > > > > >  =C2=A0 =C2=A0[Mon Mar 11 14:12:05 2024] =C2=A0? __pfx_kthr=
ead+0x10/0x10
> > > > > > > >  =C2=A0 =C2=A0[Mon Mar 11 14:12:05 2024] =C2=A0ret_from_for=
k+0x29/0x50
> > > > > > > >  =C2=A0 =C2=A0[Mon Mar 11 14:12:05 2024] =C2=A0</TASK>
> > > > > > > >  =C2=A0 =C2=A0[Mon Mar 11 14:12:05 2024] ---[ end trace 7a0=
39e17443dc651 ]---
> > > > > > > This is probably this WARN in nfsd_break_one_deleg:
> > > > > > >=20
> > > > > > > WARN_ON_ONCE(!nfsd4_run_cb(&dp->dl_recall));
> > > > > > >=20
> > > > > > > It means that a delegation break callback to the client could=
n't be
> > > > > > > queued to the workqueue, and so it didn't run.
> > > > > > >=20
> > > > > > > > Could this be the same issue as described
> > > > > > > > here:https://lore.kernel.org/linux-nfs/af0ec881-5ebf-4feb-9=
8ae-3ed2a77f86f1@oracle.com/
> > > > > > > > ?
> > > > > > > Yes, most likely the same problem.
> > > > > > If I read that thread correctly, this issue was introduced betw=
een
> > > > > > 6.1.63 and 6.6.3? Is it possible the EL9 5.14.0-362.18.1.el9_3
> > > > > > backported these changes, or were we hitting some other bug wit=
h that
> > > > > > version? It seems the 6.1.x kernel is not affected? If so, that
> > > > > > would be
> > > > > > the recommended kernel to run?
> > > > > Anything is possible. We have to identify the problem first.
> > > > > > > > As described in that thread, I've tried to obtain the reque=
sted
> > > > > > > > information.
> > > > > > > >=20
> > > > > > > > Is it possible this is the issue that was fixed by the patc=
hes
> > > > > > > > described
> > > > > > > > here?https://lore.kernel.org/linux-nfs/2024022054-cause-suf=
fering-eae8@gregkh/
> > > > > > > >=20
> > > > > > > Doubtful. Those are targeted toward a different set of issues=
.
> > > > > > >=20
> > > > > > > If you're willing, I do have some patches queued up for CentO=
S here
> > > > > > > that
> > > > > > > fix some backchannel problems that could be related. I'm main=
ly
> > > > > > > waiting
> > > > > > > on Chuck to send these to Linus and then we'll likely merge t=
hem into
> > > > > > > CentOS soon afterward:
> > > > > > >=20
> > > > > > > https://gitlab.com/redhat/centos-stream/src/kernel/centos-str=
eam-9/-/merge_requests/3689
> > > > > > >=20
> > > > > > >=20
> > > > > > If you can send me a patch file, I can rebuild the C9S kernel w=
ith that
> > > > > > patch and run it. It can take a while for the bug to trigger as=
 I
> > > > > > believe it seems to be very workload dependent (we were running=
 very
> > > > > > stable for months and now hit this bug every other week).
> > > > > >=20
> > > > > >=20
> > > > > It's probably simpler to just pull down the build artifacts for t=
hat MR.
> > > > > You have to drill down through the CI for it, but they are here:
> > > > >=20
> > > > > https://s3.amazonaws.com/arr-cki-prod-trusted-artifacts/index.htm=
l?prefix=3Dtrusted-artifacts/1194300175/publish_x86_64/6278921877/artifacts=
/
> > > > >=20
> > > > >=20
> > > > > There's even a repo file you can install on the box to pull them =
down.
> > > > We installed this kernel on the server 3 days ago. Today, a user
> > > > informed us that their screen was black after logging in. Similar t=
o
> > > > other occurrences of this issue, the mount command on the client wa=
s
> > > > hung. But in contrast to the other times, there were no messages in
> > > > the logs kernel logs on the server. Even restarting the client does
> > > > not resolve the issue.
> >=20
> > Ok, so you rebooted the client and it's still unable to mount? That
> > sounds like a server problem if so.
> >=20
> > Are both client and server running the same kernel?
> No, the server runs 5.14.0-427.3689_1194299994.el9 and the client=20
> 5.14.0-362.18.1.el9_3.

Ok.

> >=20
> > > > Something still seems to be wrong on the server though. When I look=
 at
> > > > the directories under /proc/fs/nfsd/clients, there's still a direct=
ory
> > > > for the specific client, even though it's no longer running:
> > > >=20
> > > > # cat 155/info
> > > > clientid: 0xc8edb7f65f4a9ad
> > > > address: "10.87.31.152:819"
> > > > status: confirmed
> > > > seconds from last renew: 33163
> > > > name: "Linux NFSv4.2 bersalis.esat.kuleuven.be"
> > > > minor version: 2
> > > > Implementation domain: "kernel.org"
> > > > Implementation name: "Linux 5.14.0-362.18.1.el9_3.0.1.x86_64 #1 SMP
> > > > PREEMPT_DYNAMIC Sun Feb 11 13:49:23 UTC 2024 x86_64"
> > > > Implementation time: [0, 0]
> > > > callback state: DOWN
> > > > callback address: 10.87.31.152:0
> > > >=20
> > If you just shut down the client, the server won't immediately purge it=
s
> > record. In fact, assuming you're running the same kernel on the server,
> > it won't purge the client record until there is a conflicting request
> > for its state.
> Is there a way to force such a conflicting request (to get the client=20
> record to purge)?

From the server or a different client, you can try opening the inodes
that the stuck client is holding open. If you open them for write, that
may trigger the server to kick out the old client record.

The problem is that they are disconnected dentries, so finding them to
open via path may be difficult...

> >=20
> > > The nfsdclnts command for this client shows the following delegations=
:
> > >=20
> > > # nfsdclnts -f 155/states -t all
> > > Inode number | Type=C2=A0=C2=A0 | Access | Deny | ip address=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | Filename
> > > 169346743=C2=A0=C2=A0=C2=A0 | open=C2=A0=C2=A0 | r-=C2=A0=C2=A0=C2=A0=
=C2=A0 | --=C2=A0=C2=A0 | 10.87.31.152:819=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |
> > > disconnected dentry
> > > 169346743=C2=A0=C2=A0=C2=A0 | deleg=C2=A0 | r=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 10.87.31.152:819=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 |
> > > disconnected dentry
> > > 169346746=C2=A0=C2=A0=C2=A0 | open=C2=A0=C2=A0 | r-=C2=A0=C2=A0=C2=A0=
=C2=A0 | --=C2=A0=C2=A0 | 10.87.31.152:819=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |
> > > disconnected dentry
> > > 169346746=C2=A0=C2=A0=C2=A0 | deleg=C2=A0 | r=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 10.87.31.152:819=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 |
> > > disconnected dentry
> > >=20
> > > I see a lot of recent patches regarding directory delegations. Could
> > > this be related to this?
> > >=20
> > > Will a 5.14.0-362.18.1.el9_3.0.1 kernel try to use a directory delega=
tion?
> > >=20
> > >=20
> > No. Directory delegations are a new feature that's still under
> > development. They use some of the same machinery as file delegations,
> > but they wouldn't be a factor here.
> >=20
> > > > The system seems to have identified that the client is no longer
> > > > reachable, but the client entry does not go away. When a mount was
> > > > hanging on the client, there would be two directories in clients fo=
r
> > > > the same client. Killing the mount command clears up the second ent=
ry.
> > > >=20
> > > > Even after running conntrack -D on the server to remove the tcp
> > > > connection from the conntrack table, the entry doesn't go away and =
the
> > > > client still can not mount anything from the server.
> > > >=20
> > > > A tcpdump on the client while a mount was running logged the follow=
ing
> > > > messages over and over again:
> > > >=20
> > > > request:
> > > >=20
> > > > Frame 1: 378 bytes on wire (3024 bits), 378 bytes captured (3024 bi=
ts)
> > > > Ethernet II, Src: HP_19:7d:4b (e0:73:e7:19:7d:4b), Dst:
> > > > ArubaaHe_f9:8e:00 (88:3a:30:f9:8e:00)
> > > > Internet Protocol Version 4, Src: 10.87.31.152, Dst: 10.86.18.14
> > > > Transmission Control Protocol, Src Port: 932, Dst Port: 2049, Seq: =
1,
> > > > Ack: 1, Len: 312
> > > > Remote Procedure Call, Type:Call XID:0x1d3220c4
> > > > Network File System
> > > >  =C2=A0=C2=A0=C2=A0 [Program Version: 4]
> > > >  =C2=A0=C2=A0=C2=A0 [V4 Procedure: COMPOUND (1)]
> > > >  =C2=A0=C2=A0=C2=A0 GSS Data, Ops(1): CREATE_SESSION
> > > >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Length: 152
> > > >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 GSS Sequence Number: 76
> > > >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Tag: <EMPTY>
> > > >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 minorversion: 2
> > > >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Operations (count: 1): =
CREATE_SESSION
> > > >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [Main Opcode: CREATE_SE=
SSION (43)]
> > > >  =C2=A0=C2=A0=C2=A0 GSS Checksum:
> > > > 00000028040404ffffffffff000000002c19055f1f8d442d594c13849628affc279=
7cbb2=E2=80=A6
> > > >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 GSS Token Length: 40
> > > >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 GSS-API Generic Securit=
y Service Application Program Interface
> > > >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 krb5_blob:
> > > > 040404ffffffffff000000002c19055f1f8d442d594c13849628affc2797cbb23fa=
080b0=E2=80=A6
> > > >=20
> > > > response:
> > > >=20
> > > > Frame 2: 206 bytes on wire (1648 bits), 206 bytes captured (1648 bi=
ts)
> > > > Ethernet II, Src: ArubaaHe_f9:8e:00 (88:3a:30:f9:8e:00), Dst:
> > > > HP_19:7d:4b (e0:73:e7:19:7d:4b)
> > > > Internet Protocol Version 4, Src: 10.86.18.14, Dst: 10.87.31.152
> > > > Transmission Control Protocol, Src Port: 2049, Dst Port: 932, Seq: =
1,
> > > > Ack: 313, Len: 140
> > > > Remote Procedure Call, Type:Reply XID:0x1d3220c4
> > > > Network File System
> > > >  =C2=A0=C2=A0=C2=A0 [Program Version: 4]
> > > >  =C2=A0=C2=A0=C2=A0 [V4 Procedure: COMPOUND (1)]
> > > >  =C2=A0=C2=A0=C2=A0 GSS Data, Ops(1): CREATE_SESSION(NFS4ERR_DELAY)
> > > >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Length: 24
> > > >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 GSS Sequence Number: 76
> > > >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Status: NFS4ERR_DELAY (=
10008)
> > > >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Tag: <EMPTY>
> > > >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Operations (count: 1)
> > > >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [Main Opcode: CREATE_SE=
SSION (43)]
> > > >  =C2=A0=C2=A0=C2=A0 GSS Checksum:
> > > > 00000028040405ffffffffff000000000aa742d0798deaad1a8aa2d7c3a91bf4f62=
74222=E2=80=A6
> > > >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 GSS Token Length: 40
> > > >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 GSS-API Generic Securit=
y Service Application Program Interface
> > > >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 krb5_blob:
> > > > 040405ffffffffff000000000aa742d0798deaad1a8aa2d7c3a91bf4f627422226d=
74923=E2=80=A6
> > > >=20
> > > > I was hoping that giving the client a different IP address would
> > > > resolve the issue for this client, but it didn't. Even though the
> > > > client had a new IP address (hostname was kept the same), it failed=
 to
> > > > mount anything from the server.
> > > >=20
> > Changing the IP address won't help. The client is probably using the
> > same long-form client id as before, so the server still identifies the
> > client even with the address change.
> How is the client id determined? Will changing the hostname of the=20
> client trigger a change of the client id?

In the client record you showed a bit above, there is a "name" field:

    name: "Linux NFSv4.2 bersalis.esat.kuleuven.be"

That's the string the server uses to uniquely identify the client. So
yes, changing the hostname should change that string.

> >=20
> > Unfortunately, the cause of an NFS4ERR_DELAY error is tough to guess.
> > The client is expected to back off and retry, so if the server keeps
> > returning that repeatedly, then a hung mount command is expected.
> >=20
> > The question is why the server would keep returning DELAY. A lot of
> > different problems ranging from memory allocation issues to protocol
> > problems can result in that error. You may want to check the NFS server
> > and see if anything was logged there.
> There are no messages in the system logs that indicate any sort of=20
> memory issue. We also increased the min_kbytes_free sysctl to 2G on the=
=20
> server before we restarted it with the newer kernel.

Ok, I didn't expect to see anything like that, but it was a possibility.

> >=20
> > This is on a CREATE_SESSION call, so I wonder if the record held by the
> > (courteous) server is somehow blocking the attempt to reestablish the
> > session?
> >=20
> > Do you have a way to reproduce this? Since this is a centos kernel, you
> > could follow the page here to open a bug:
>=20
> Unfortunately we haven't found a reliable way to reproduce it. But we do=
=20
> seem to trigger it more and more lately.
>=20
>=20

Bummer, ok. Let us know if you figure out a way to reproduce it.

> >      https://wiki.centos.org/ReportBugs.html
> >=20
> >=20
> > > > I created another dump of the workqueues and worker pools on the se=
rver:
> > > >=20
> > > > [Mon Mar 18 14:59:33 2024] Showing busy workqueues and worker pools=
:
> > > > [Mon Mar 18 14:59:33 2024] workqueue events: flags=3D0x0
> > > > [Mon Mar 18 14:59:33 2024] =C2=A0=C2=A0pwq 54: cpus=3D27 node=3D1 f=
lags=3D0x0 nice=3D0
> > > > active=3D1/256 refcnt=3D2
> > > > [Mon Mar 18 14:59:33 2024] =C2=A0=C2=A0=C2=A0=C2=A0pending: drm_fb_=
helper_damage_work
> > > > [drm_kms_helper]
> > > > [Mon Mar 18 14:59:33 2024] workqueue events_power_efficient: flags=
=3D0x80
> > > > [Mon Mar 18 14:59:33 2024] =C2=A0=C2=A0pwq 54: cpus=3D27 node=3D1 f=
lags=3D0x0 nice=3D0
> > > > active=3D1/256 refcnt=3D2
> > > > [Mon Mar 18 14:59:33 2024] =C2=A0=C2=A0=C2=A0=C2=A0pending: fb_flas=
hcursor
> > > > [Mon Mar 18 14:59:33 2024] workqueue mm_percpu_wq: flags=3D0x8
> > > > [Mon Mar 18 14:59:33 2024] =C2=A0=C2=A0pwq 54: cpus=3D27 node=3D1 f=
lags=3D0x0 nice=3D0
> > > > active=3D1/256 refcnt=3D3
> > > > [Mon Mar 18 14:59:33 2024] =C2=A0=C2=A0=C2=A0=C2=A0pending: lru_add=
_drain_per_cpu BAR(362)
> > > > [Mon Mar 18 14:59:33 2024] workqueue kblockd: flags=3D0x18
> > > > [Mon Mar 18 14:59:33 2024] =C2=A0=C2=A0pwq 55: cpus=3D27 node=3D1 f=
lags=3D0x0 nice=3D-20
> > > > active=3D1/256 refcnt=3D2
> > > > [Mon Mar 18 14:59:33 2024] =C2=A0=C2=A0=C2=A0=C2=A0pending: blk_mq_=
timeout_work
> > > >=20
> > > >=20
> > > > In contrast to last time, it doesn't show anything regarding nfs th=
is
> > > > time.
> > > >=20
> > > > I also tried the suggestion from Dai Ngo (echo 3 >
> > > > /proc/sys/vm/drop_caches), but that didn't seem to make any differe=
nce.
> > > >=20
> > > > We haven't restarted the server yet as it seems the impact seems to
> > > > affect fewer clients that before. Is there anything we can run on t=
he
> > > > server to further debug this?
> > > >=20
> > > > In the past, the issue seemed to deteriorate rapidly and resulted i=
n
> > > > issues for almost all clients after about 20 minutes. This time the
> > > > impact seems to be less, but it's not gone.
> > > >=20
> > > > How can we force the NFS server to forget about a specific client? =
I
> > > > haven't tried to restart the nfs service yet as I'm afraid it will
> > > > fail to stop as before.
> > > >=20
> > Not with that kernel. There are some new administrative interfaces that
> > might allow that in the future, but they were just merged upstream and
> > aren't in that kernel.
> >=20
> > --
> > Jeff Layton <jlayton@kernel.org>
>=20

--=20
Jeff Layton <jlayton@kernel.org>

