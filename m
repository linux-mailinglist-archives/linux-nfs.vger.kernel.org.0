Return-Path: <linux-nfs+bounces-2438-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CEAD88620D
	for <lists+linux-nfs@lfdr.de>; Thu, 21 Mar 2024 21:49:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F1602824A2
	for <lists+linux-nfs@lfdr.de>; Thu, 21 Mar 2024 20:49:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CE9B135A6A;
	Thu, 21 Mar 2024 20:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UhSJ5a0x"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 354771350E8
	for <linux-nfs@vger.kernel.org>; Thu, 21 Mar 2024 20:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711054094; cv=none; b=tX0RGRBgre0ifPo+SLWcVEra1eJ767Mz/slDGXYqavjTJ4X8AbyK3ruTmZxzJKo2Pq8ainUmGnNtiSOWHzfIBpwHfVfJDnqOWzldwrrUFGTr8uCMW+pzZmpem4vlQsHD++vj2tUrIGlpTqdClYj8Cl8J1fnB8qYKLBCvzR2gvl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711054094; c=relaxed/simple;
	bh=Q/wTKbX+m3D4/Ve84waY9DciRVZLtjDUYiQcUe10xZE=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PfyVhjuB4sT8qv2Dj4xSqxFGRTp2bn17dxmPw+x28x/ChBLQT/XFD+cBImMOf6S7u06B61VVQsBbaBCSNVFhWCrWWSyAyqB1hUA7Yuu0G4X+fwJzqSh96ffiQ3hdYO4sFWObA8a4ycWMR3po832nxuX8s4yUkc/oWq8YfG6PI4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UhSJ5a0x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54BA0C433F1;
	Thu, 21 Mar 2024 20:48:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711054093;
	bh=Q/wTKbX+m3D4/Ve84waY9DciRVZLtjDUYiQcUe10xZE=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=UhSJ5a0xIlJ4mUZsceaPQ/FQ4ngqJz21toBEpUSsYuiIzhGxxKrt3/oy/262ZDYeq
	 FVQftrgPzl5XAx0xbTXa0Bi8ppF20/HMXJmdfHXmNUwSnyn4nCiwdZqu1iF/H4zDIA
	 bWswk1ZN7WkiqHPhWe2O5nYl6LBKUxZxVMmAt0Uqc3lMmTISH1tX2CE5MXKTQZMEkZ
	 aEkuDFLF7NkiUwhsPe5Q1oRcvKSw7+ZEIPRSnjk/A4wZfus0ean7BtKx1E2NcHloFR
	 QwmHAZdRRHaT3zCuC8a+7aXLYEEyF7j4Q9GFoyP7FgATG7Ij1xc0JTwTE82Qo9c9zO
	 ovBHuaoKjXPHg==
Message-ID: <22444404d4af6c705d5ad15e0e1f3c5c679844c6.camel@kernel.org>
Subject: Re: nfsd hangs and nfsd_break_deleg_cb+0x170/0x190 warning
From: Jeff Layton <jlayton@kernel.org>
To: Rik Theys <Rik.Theys@esat.kuleuven.be>, Dai Ngo <dai.ngo@oracle.com>, 
	Linux Nfs <linux-nfs@vger.kernel.org>
Date: Thu, 21 Mar 2024 16:48:12 -0400
In-Reply-To: <cc8ad258-dbf3-4efe-b719-4576ffb5f4b0@esat.kuleuven.be>
References: <66c98f4c-5e52-4fa3-8a2c-9379cfec2a9a@esat.kuleuven.be>
	 <44c2101e756f7c3b876fb9c58da3ebd089dc14d5.camel@kernel.org>
	 <e3ba6e04-ea06-4035-8546-639f11d6b79c@esat.kuleuven.be>
	 <41325088-aa6d-4dcf-b105-8994350168c3@esat.kuleuven.be>
	 <7d244882d769e377b06f39234bd5ee7dddb72a55.camel@kernel.org>
	 <c7dbc796-7e7d-4041-ac71-eea02a701b12@esat.kuleuven.be>
	 <50dd9475-b485-4b9b-bcbd-5f7dfabfbac5@oracle.com>
	 <d90551d6-a48f-4c25-a2f0-8dbd2b5e5830@esat.kuleuven.be>
	 <819fec01-6689-4949-b996-6e36b0b0fb4e@oracle.com>
	 <cc8ad258-dbf3-4efe-b719-4576ffb5f4b0@esat.kuleuven.be>
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

On Wed, 2024-03-20 at 20:41 +0100, Rik Theys wrote:
> Hi,
>=20
> On 3/19/24 22:42, Dai Ngo wrote:
> >=20
> > On 3/19/24 12:41 PM, Rik Theys wrote:
> > > Hi,
> > >=20
> > > On 3/19/24 18:09, Dai Ngo wrote:
> > > >=20
> > > > On 3/19/24 12:58 AM, Rik Theys wrote:
> > > > > Hi,
> > > > >=20
> > > > > On 3/18/24 22:54, Jeff Layton wrote:
> > > > > > On Mon, 2024-03-18 at 22:15 +0100, Rik Theys wrote:
> > > > > > > Hi,
> > > > > > >=20
> > > > > > > On 3/18/24 21:21, Rik Theys wrote:
> > > > > > > > Hi Jeff,
> > > > > > > >=20
> > > > > > > > On 3/12/24 13:47, Jeff Layton wrote:
> > > > > > > > > On Tue, 2024-03-12 at 13:24 +0100, Rik Theys wrote:
> > > > > > > > > > Hi Jeff,
> > > > > > > > > >=20
> > > > > > > > > > On 3/12/24 12:22, Jeff Layton wrote:
> > > > > > > > > > > On Mon, 2024-03-11 at 19:43 +0100, Rik Theys wrote:
> > > > > > > > > > > > Since a few weeks our Rocky Linux 9 NFS server has =
periodically
> > > > > > > > > > > > logged hung nfsd tasks. The initial effect was that=
 some=20
> > > > > > > > > > > > clients
> > > > > > > > > > > > could no longer access the NFS server. This got wor=
se and worse
> > > > > > > > > > > > (probably as more nfsd threads got blocked) and we =
had to=20
> > > > > > > > > > > > restart
> > > > > > > > > > > > the server. Restarting the server also failed as th=
e NFS server
> > > > > > > > > > > > service could no longer be stopped.
> > > > > > > > > > > >=20
> > > > > > > > > > > > The initial kernel we noticed this behavior on was
> > > > > > > > > > > > kernel-5.14.0-362.18.1.el9_3.x86_64. Since then we'=
ve installed
> > > > > > > > > > > > kernel-5.14.0-419.el9.x86_64 from CentOS Stream 9. =
The same=20
> > > > > > > > > > > > issue
> > > > > > > > > > > > happened again on this newer kernel version:
> > > > > > > > > 419 is fairly up to date with nfsd changes. There are som=
e=20
> > > > > > > > > known bugs
> > > > > > > > > around callbacks, and there is a draft MR in flight to fi=
x it.
> > > > > > > > >=20
> > > > > > > > > What kernel were you on prior to 5.14.0-362.18.1.el9_3.x8=
6_64 ?=20
> > > > > > > > > If we
> > > > > > > > > can bracket the changes around a particular version, then=
 that=20
> > > > > > > > > might
> > > > > > > > > help identify the problem.
> > > > > > > > >=20
> > > > > > > > > > > > [Mon Mar 11 14:10:08 2024] =C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0Not tainted=20
> > > > > > > > > > > > 5.14.0-419.el9.x86_64 #1
> > > > > > > > > > > > =C2=A0=C2=A0 =C2=A0[Mon Mar 11 14:10:08 2024] "echo=
 0 >
> > > > > > > > > > > > /proc/sys/kernel/hung_task_timeout_secs" disables t=
his message.
> > > > > > > > > > > > =C2=A0=C2=A0 =C2=A0[Mon Mar 11 14:10:08 2024]task:n=
fsd =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0state=
:D=20
> > > > > > > > > > > > stack:0
> > > > > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0pid:8865 =C2=A0ppid:2=
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0flags:0x00004000
> > > > > > > > > > > > =C2=A0=C2=A0 =C2=A0[Mon Mar 11 14:10:08 2024] Call =
Trace:
> > > > > > > > > > > > =C2=A0=C2=A0 =C2=A0[Mon Mar 11 14:10:08 2024] =C2=
=A0<TASK>
> > > > > > > > > > > > =C2=A0=C2=A0 =C2=A0[Mon Mar 11 14:10:08 2024] =C2=
=A0__schedule+0x21b/0x550
> > > > > > > > > > > > =C2=A0=C2=A0 =C2=A0[Mon Mar 11 14:10:08 2024] =C2=
=A0schedule+0x2d/0x70
> > > > > > > > > > > > =C2=A0=C2=A0 =C2=A0[Mon Mar 11 14:10:08 2024] =C2=
=A0schedule_timeout+0x11f/0x160
> > > > > > > > > > > > =C2=A0=C2=A0 =C2=A0[Mon Mar 11 14:10:08 2024] =C2=
=A0?=20
> > > > > > > > > > > > select_idle_sibling+0x28/0x430
> > > > > > > > > > > > =C2=A0=C2=A0 =C2=A0[Mon Mar 11 14:10:08 2024] =C2=
=A0? wake_affine+0x62/0x1f0
> > > > > > > > > > > > =C2=A0=C2=A0 =C2=A0[Mon Mar 11 14:10:08 2024] =C2=
=A0__wait_for_common+0x90/0x1d0
> > > > > > > > > > > > =C2=A0=C2=A0 =C2=A0[Mon Mar 11 14:10:08 2024] =C2=
=A0?=20
> > > > > > > > > > > > __pfx_schedule_timeout+0x10/0x10
> > > > > > > > > > > > =C2=A0=C2=A0 =C2=A0[Mon Mar 11 14:10:08 2024] =C2=
=A0__flush_workqueue+0x13a/0x3f0
> > > > > > > > > > > > =C2=A0=C2=A0 =C2=A0[Mon Mar 11 14:10:08 2024]=20
> > > > > > > > > > > > =C2=A0nfsd4_shutdown_callback+0x49/0x120
> > > > > > > > > > > > [nfsd]
> > > > > > > > > > > > =C2=A0=C2=A0 =C2=A0[Mon Mar 11 14:10:08 2024] =C2=
=A0?=20
> > > > > > > > > > > > nfsd4_cld_remove+0x54/0x1d0 [nfsd]
> > > > > > > > > > > > =C2=A0=C2=A0 =C2=A0[Mon Mar 11 14:10:08 2024] =C2=
=A0?
> > > > > > > > > > > > nfsd4_return_all_client_layouts+0xc4/0xf0 [nfsd]
> > > > > > > > > > > > =C2=A0=C2=A0 =C2=A0[Mon Mar 11 14:10:08 2024] =C2=
=A0?=20
> > > > > > > > > > > > nfsd4_shutdown_copy+0x68/0xc0 [nfsd]
> > > > > > > > > > > > =C2=A0=C2=A0 =C2=A0[Mon Mar 11 14:10:08 2024] =C2=
=A0__destroy_client+0x1f3/0x290=20
> > > > > > > > > > > > [nfsd]
> > > > > > > > > > > > =C2=A0=C2=A0 =C2=A0[Mon Mar 11 14:10:08 2024]=20
> > > > > > > > > > > > =C2=A0nfsd4_exchange_id+0x75f/0x770 [nfsd]
> > > > > > > > > > > > =C2=A0=C2=A0 =C2=A0[Mon Mar 11 14:10:08 2024] =C2=
=A0?=20
> > > > > > > > > > > > nfsd4_decode_opaque+0x3a/0x90 [nfsd]
> > > > > > > > > > > > =C2=A0=C2=A0 =C2=A0[Mon Mar 11 14:10:08 2024]=20
> > > > > > > > > > > > =C2=A0nfsd4_proc_compound+0x44b/0x700 [nfsd]
> > > > > > > > > > > > =C2=A0=C2=A0 =C2=A0[Mon Mar 11 14:10:08 2024] =C2=
=A0nfsd_dispatch+0x94/0x1c0 [nfsd]
> > > > > > > > > > > > =C2=A0=C2=A0 =C2=A0[Mon Mar 11 14:10:08 2024] =C2=
=A0svc_process_common+0x2ec/0x660
> > > > > > > > > > > > [sunrpc]
> > > > > > > > > > > > =C2=A0=C2=A0 =C2=A0[Mon Mar 11 14:10:08 2024] =C2=
=A0?=20
> > > > > > > > > > > > __pfx_nfsd_dispatch+0x10/0x10 [nfsd]
> > > > > > > > > > > > =C2=A0=C2=A0 =C2=A0[Mon Mar 11 14:10:08 2024] =C2=
=A0? __pfx_nfsd+0x10/0x10 [nfsd]
> > > > > > > > > > > > =C2=A0=C2=A0 =C2=A0[Mon Mar 11 14:10:08 2024] =C2=
=A0svc_process+0x12d/0x170=20
> > > > > > > > > > > > [sunrpc]
> > > > > > > > > > > > =C2=A0=C2=A0 =C2=A0[Mon Mar 11 14:10:08 2024] =C2=
=A0nfsd+0x84/0xb0 [nfsd]
> > > > > > > > > > > > =C2=A0=C2=A0 =C2=A0[Mon Mar 11 14:10:08 2024] =C2=
=A0kthread+0xdd/0x100
> > > > > > > > > > > > =C2=A0=C2=A0 =C2=A0[Mon Mar 11 14:10:08 2024] =C2=
=A0? __pfx_kthread+0x10/0x10
> > > > > > > > > > > > =C2=A0=C2=A0 =C2=A0[Mon Mar 11 14:10:08 2024] =C2=
=A0ret_from_fork+0x29/0x50
> > > > > > > > > > > > =C2=A0=C2=A0 =C2=A0[Mon Mar 11 14:10:08 2024] =C2=
=A0</TASK>
> > > > > > > > > > > > =C2=A0=C2=A0 =C2=A0[Mon Mar 11 14:10:08 2024] INFO:=
 task nfsd:8866 blocked for
> > > > > > > > > > > > more than 122 seconds.
> > > > > > > > > > > > =C2=A0=C2=A0 =C2=A0[Mon Mar 11 14:10:08 2024] =C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Not tainted
> > > > > > > > > > > > 5.14.0-419.el9.x86_64 #1
> > > > > > > > > > > > =C2=A0=C2=A0 =C2=A0[Mon Mar 11 14:10:08 2024] "echo=
 0 >
> > > > > > > > > > > > /proc/sys/kernel/hung_task_timeout_secs" disables t=
his message.
> > > > > > > > > > > > =C2=A0=C2=A0 =C2=A0[Mon Mar 11 14:10:08 2024]task:n=
fsd =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0state=
:D=20
> > > > > > > > > > > > stack:0
> > > > > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0pid:8866 =C2=A0ppid:2=
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0flags:0x00004000
> > > > > > > > > > > > =C2=A0=C2=A0 =C2=A0[Mon Mar 11 14:10:08 2024] Call =
Trace:
> > > > > > > > > > > > =C2=A0=C2=A0 =C2=A0[Mon Mar 11 14:10:08 2024] =C2=
=A0<TASK>
> > > > > > > > > > > > =C2=A0=C2=A0 =C2=A0[Mon Mar 11 14:10:08 2024] =C2=
=A0__schedule+0x21b/0x550
> > > > > > > > > > > > =C2=A0=C2=A0 =C2=A0[Mon Mar 11 14:10:08 2024] =C2=
=A0schedule+0x2d/0x70
> > > > > > > > > > > > =C2=A0=C2=A0 =C2=A0[Mon Mar 11 14:10:08 2024] =C2=
=A0schedule_timeout+0x11f/0x160
> > > > > > > > > > > > =C2=A0=C2=A0 =C2=A0[Mon Mar 11 14:10:08 2024] =C2=
=A0?=20
> > > > > > > > > > > > select_idle_sibling+0x28/0x430
> > > > > > > > > > > > =C2=A0=C2=A0 =C2=A0[Mon Mar 11 14:10:08 2024] =C2=
=A0? tcp_recvmsg+0x196/0x210
> > > > > > > > > > > > =C2=A0=C2=A0 =C2=A0[Mon Mar 11 14:10:08 2024] =C2=
=A0? wake_affine+0x62/0x1f0
> > > > > > > > > > > > =C2=A0=C2=A0 =C2=A0[Mon Mar 11 14:10:08 2024] =C2=
=A0__wait_for_common+0x90/0x1d0
> > > > > > > > > > > > =C2=A0=C2=A0 =C2=A0[Mon Mar 11 14:10:08 2024] =C2=
=A0?=20
> > > > > > > > > > > > __pfx_schedule_timeout+0x10/0x10
> > > > > > > > > > > > =C2=A0=C2=A0 =C2=A0[Mon Mar 11 14:10:08 2024] =C2=
=A0__flush_workqueue+0x13a/0x3f0
> > > > > > > > > > > > =C2=A0=C2=A0 =C2=A0[Mon Mar 11 14:10:08 2024]=20
> > > > > > > > > > > > =C2=A0nfsd4_destroy_session+0x1a4/0x240
> > > > > > > > > > > > [nfsd]
> > > > > > > > > > > > =C2=A0=C2=A0 =C2=A0[Mon Mar 11 14:10:08 2024]=20
> > > > > > > > > > > > =C2=A0nfsd4_proc_compound+0x44b/0x700 [nfsd]
> > > > > > > > > > > > =C2=A0=C2=A0 =C2=A0[Mon Mar 11 14:10:08 2024] =C2=
=A0nfsd_dispatch+0x94/0x1c0 [nfsd]
> > > > > > > > > > > > =C2=A0=C2=A0 =C2=A0[Mon Mar 11 14:10:08 2024] =C2=
=A0svc_process_common+0x2ec/0x660
> > > > > > > > > > > > [sunrpc]
> > > > > > > > > > > > =C2=A0=C2=A0 =C2=A0[Mon Mar 11 14:10:08 2024] =C2=
=A0?=20
> > > > > > > > > > > > __pfx_nfsd_dispatch+0x10/0x10 [nfsd]
> > > > > > > > > > > > =C2=A0=C2=A0 =C2=A0[Mon Mar 11 14:10:08 2024] =C2=
=A0? __pfx_nfsd+0x10/0x10 [nfsd]
> > > > > > > > > > > > =C2=A0=C2=A0 =C2=A0[Mon Mar 11 14:10:08 2024] =C2=
=A0svc_process+0x12d/0x170=20
> > > > > > > > > > > > [sunrpc]
> > > > > > > > > > > > =C2=A0=C2=A0 =C2=A0[Mon Mar 11 14:10:08 2024] =C2=
=A0nfsd+0x84/0xb0 [nfsd]
> > > > > > > > > > > > =C2=A0=C2=A0 =C2=A0[Mon Mar 11 14:10:08 2024] =C2=
=A0kthread+0xdd/0x100
> > > > > > > > > > > > =C2=A0=C2=A0 =C2=A0[Mon Mar 11 14:10:08 2024] =C2=
=A0? __pfx_kthread+0x10/0x10
> > > > > > > > > > > > =C2=A0=C2=A0 =C2=A0[Mon Mar 11 14:10:08 2024] =C2=
=A0ret_from_fork+0x29/0x50
> > > > > > > > > > > > =C2=A0=C2=A0 =C2=A0[Mon Mar 11 14:10:08 2024] =C2=
=A0</TASK>
> > > > > > > > > > > >=20
> > > > > > > > > > > The above threads are trying to flush the workqueue, =
so that=20
> > > > > > > > > > > probably
> > > > > > > > > > > means that they are stuck waiting on a workqueue job =
to finish.
> > > > > > > > > > > > =C2=A0=C2=A0 =C2=A0The above is repeated a few time=
s, and then this warning is
> > > > > > > > > > > > also logged:
> > > > > > > > > > > > =C2=A0=C2=A0=C2=A0 [Mon Mar 11 14:12:04 2024] -----=
-------[ cut here=20
> > > > > > > > > > > > ]------------
> > > > > > > > > > > > =C2=A0=C2=A0 =C2=A0[Mon Mar 11 14:12:04 2024] WARNI=
NG: CPU: 39 PID: 8844 at
> > > > > > > > > > > > fs/nfsd/nfs4state.c:4919 nfsd_break_deleg_cb+0x170/=
0x190 [nfsd]
> > > > > > > > > > > > =C2=A0=C2=A0 =C2=A0[Mon Mar 11 14:12:05 2024] Modul=
es linked in: nfsv4
> > > > > > > > > > > > dns_resolver nfs fscache netfs rpcsec_gss_krb5 rpcr=
dma rdma_cm
> > > > > > > > > > > > iw_cm ib_cm ib_core binfmt_misc bonding tls rfkill=
=20
> > > > > > > > > > > > nft_counter nft_ct
> > > > > > > > > > > > =C2=A0=C2=A0 =C2=A0nf_conntrack nf_defrag_ipv6 nf_d=
efrag_ipv4 nft_reject_inet
> > > > > > > > > > > > nf_reject_ipv4 nf_reject_ipv6 nft_reject nf_tables =
nfnetlink=20
> > > > > > > > > > > > vfat
> > > > > > > > > > > > fat dm_thin_pool dm_persistent_data dm_bio_prison d=
m_bufio l
> > > > > > > > > > > > =C2=A0=C2=A0 =C2=A0ibcrc32c dm_service_time dm_mult=
ipath intel_rapl_msr
> > > > > > > > > > > > intel_rapl_common intel_uncore_frequency
> > > > > > > > > > > > intel_uncore_frequency_common isst_if_common skx_ed=
ac nfit
> > > > > > > > > > > > libnvdimm ipmi_ssif x86_pkg_temp
> > > > > > > > > > > > =C2=A0=C2=A0 =C2=A0_thermal intel_powerclamp corete=
mp kvm_intel kvm irqbypass
> > > > > > > > > > > > dcdbas rapl intel_cstate mgag200 i2c_algo_bit drm_s=
hmem_helper
> > > > > > > > > > > > dell_smbios drm_kms_helper dell_wmi_descriptor wmi_=
bmof intel_u
> > > > > > > > > > > > =C2=A0=C2=A0 =C2=A0ncore syscopyarea pcspkr sysfill=
rect mei_me sysimgblt=20
> > > > > > > > > > > > acpi_ipmi
> > > > > > > > > > > > mei fb_sys_fops i2c_i801 ipmi_si intel_pch_thermal =
lpc_ich
> > > > > > > > > > > > ipmi_devintf i2c_smbus ipmi_msghandler joydev acpi_=
power_meter
> > > > > > > > > > > > =C2=A0=C2=A0 =C2=A0nfsd auth_rpcgss nfs_acl drm loc=
kd grace fuse sunrpc ext4
> > > > > > > > > > > > mbcache jbd2 sd_mod sg lpfc
> > > > > > > > > > > > =C2=A0=C2=A0 =C2=A0[Mon Mar 11 14:12:05 2024] =C2=
=A0nvmet_fc nvmet nvme_fc=20
> > > > > > > > > > > > nvme_fabrics
> > > > > > > > > > > > crct10dif_pclmul ahci libahci crc32_pclmul nvme_cor=
e=20
> > > > > > > > > > > > crc32c_intel
> > > > > > > > > > > > ixgbe megaraid_sas libata nvme_common ghash_clmulni=
_int
> > > > > > > > > > > > =C2=A0=C2=A0 =C2=A0el t10_pi wdat_wdt scsi_transpor=
t_fc mdio wmi dca dm_mirror
> > > > > > > > > > > > dm_region_hash dm_log dm_mod
> > > > > > > > > > > > =C2=A0=C2=A0 =C2=A0[Mon Mar 11 14:12:05 2024] CPU: =
39 PID: 8844 Comm: nfsd Not
> > > > > > > > > > > > tainted 5.14.0-419.el9.x86_64 #1
> > > > > > > > > > > > =C2=A0=C2=A0 =C2=A0[Mon Mar 11 14:12:05 2024] Hardw=
are name: Dell Inc.=20
> > > > > > > > > > > > PowerEdge
> > > > > > > > > > > > R740/00WGD1, BIOS 2.20.1 09/13/2023
> > > > > > > > > > > > =C2=A0=C2=A0 =C2=A0[Mon Mar 11 14:12:05 2024] RIP:
> > > > > > > > > > > > 0010:nfsd_break_deleg_cb+0x170/0x190 [nfsd]
> > > > > > > > > > > > =C2=A0=C2=A0 =C2=A0[Mon Mar 11 14:12:05 2024] Code:=
 a6 95 c5 f3 e9 ff fe ff=20
> > > > > > > > > > > > ff 48
> > > > > > > > > > > > 89 df be 01 00 00 00 e8 34 b5 13 f4 48 8d bb 98 00 =
00 00 e8=20
> > > > > > > > > > > > c8 f9
> > > > > > > > > > > > 00 00 84 c0 0f 85 2e ff ff ff <0f> 0b e9 27 ff ff f=
f be
> > > > > > > > > > > > =C2=A0=C2=A0 =C2=A002 00 00 00 48 89 df e8 0c b5 13=
 f4 e9 01
> > > > > > > > > > > > =C2=A0=C2=A0 =C2=A0[Mon Mar 11 14:12:05 2024] RSP: =
0018:ffff9929e0bb7b80=20
> > > > > > > > > > > > EFLAGS:
> > > > > > > > > > > > 00010246
> > > > > > > > > > > > =C2=A0=C2=A0 =C2=A0[Mon Mar 11 14:12:05 2024] RAX: =
0000000000000000 RBX:
> > > > > > > > > > > > ffff8ada51930900 RCX: 0000000000000024
> > > > > > > > > > > > =C2=A0=C2=A0 =C2=A0[Mon Mar 11 14:12:05 2024] RDX: =
ffff8ada519309c8 RSI:
> > > > > > > > > > > > ffff8ad582933c00 RDI: 0000000000002000
> > > > > > > > > > > > =C2=A0=C2=A0 =C2=A0[Mon Mar 11 14:12:05 2024] RBP: =
ffff8ad46bf21574 R08:
> > > > > > > > > > > > ffff9929e0bb7b48 R09: 0000000000000000
> > > > > > > > > > > > =C2=A0=C2=A0 =C2=A0[Mon Mar 11 14:12:05 2024] R10: =
ffff8aec859a2948 R11:
> > > > > > > > > > > > 0000000000000000 R12: ffff8ad6f497c360
> > > > > > > > > > > > =C2=A0=C2=A0 =C2=A0[Mon Mar 11 14:12:05 2024] R13: =
ffff8ad46bf21560 R14:
> > > > > > > > > > > > ffff8ae5942e0b10 R15: ffff8ad6f497c360
> > > > > > > > > > > > =C2=A0=C2=A0 =C2=A0[Mon Mar 11 14:12:05 2024] FS: =
=C2=A00000000000000000(0000)
> > > > > > > > > > > > GS:ffff8b031fcc0000(0000) knlGS:0000000000000000
> > > > > > > > > > > > =C2=A0=C2=A0 =C2=A0[Mon Mar 11 14:12:05 2024] CS: =
=C2=A00010 DS: 0000 ES: 0000 CR0:
> > > > > > > > > > > > 0000000080050033
> > > > > > > > > > > > =C2=A0=C2=A0 =C2=A0[Mon Mar 11 14:12:05 2024] CR2: =
00007fafe2060744 CR3:
> > > > > > > > > > > > 00000018e58de006 CR4: 00000000007706e0
> > > > > > > > > > > > =C2=A0=C2=A0 =C2=A0[Mon Mar 11 14:12:05 2024] DR0: =
0000000000000000 DR1:
> > > > > > > > > > > > 0000000000000000 DR2: 0000000000000000
> > > > > > > > > > > > =C2=A0=C2=A0 =C2=A0[Mon Mar 11 14:12:05 2024] DR3: =
0000000000000000 DR6:
> > > > > > > > > > > > 00000000fffe0ff0 DR7: 0000000000000400
> > > > > > > > > > > > =C2=A0=C2=A0 =C2=A0[Mon Mar 11 14:12:05 2024] PKRU:=
 55555554
> > > > > > > > > > > > =C2=A0=C2=A0 =C2=A0[Mon Mar 11 14:12:05 2024] Call =
Trace:
> > > > > > > > > > > > =C2=A0=C2=A0 =C2=A0[Mon Mar 11 14:12:05 2024] =C2=
=A0<TASK>
> > > > > > > > > > > > =C2=A0=C2=A0 =C2=A0[Mon Mar 11 14:12:05 2024] =C2=
=A0?=20
> > > > > > > > > > > > show_trace_log_lvl+0x1c4/0x2df
> > > > > > > > > > > > =C2=A0=C2=A0 =C2=A0[Mon Mar 11 14:12:05 2024] =C2=
=A0?=20
> > > > > > > > > > > > show_trace_log_lvl+0x1c4/0x2df
> > > > > > > > > > > > =C2=A0=C2=A0 =C2=A0[Mon Mar 11 14:12:05 2024] =C2=
=A0? __break_lease+0x16f/0x5f0
> > > > > > > > > > > > =C2=A0=C2=A0 =C2=A0[Mon Mar 11 14:12:05 2024] =C2=
=A0?=20
> > > > > > > > > > > > nfsd_break_deleg_cb+0x170/0x190
> > > > > > > > > > > > [nfsd]
> > > > > > > > > > > > =C2=A0=C2=A0 =C2=A0[Mon Mar 11 14:12:05 2024] =C2=
=A0? __warn+0x81/0x110
> > > > > > > > > > > > =C2=A0=C2=A0 =C2=A0[Mon Mar 11 14:12:05 2024] =C2=
=A0?=20
> > > > > > > > > > > > nfsd_break_deleg_cb+0x170/0x190
> > > > > > > > > > > > [nfsd]
> > > > > > > > > > > > =C2=A0=C2=A0 =C2=A0[Mon Mar 11 14:12:05 2024] =C2=
=A0? report_bug+0x10a/0x140
> > > > > > > > > > > > =C2=A0=C2=A0 =C2=A0[Mon Mar 11 14:12:05 2024] =C2=
=A0? handle_bug+0x3c/0x70
> > > > > > > > > > > > =C2=A0=C2=A0 =C2=A0[Mon Mar 11 14:12:05 2024] =C2=
=A0? exc_invalid_op+0x14/0x70
> > > > > > > > > > > > =C2=A0=C2=A0 =C2=A0[Mon Mar 11 14:12:05 2024] =C2=
=A0? asm_exc_invalid_op+0x16/0x20
> > > > > > > > > > > > =C2=A0=C2=A0 =C2=A0[Mon Mar 11 14:12:05 2024] =C2=
=A0?=20
> > > > > > > > > > > > nfsd_break_deleg_cb+0x170/0x190
> > > > > > > > > > > > [nfsd]
> > > > > > > > > > > > =C2=A0=C2=A0 =C2=A0[Mon Mar 11 14:12:05 2024] =C2=
=A0__break_lease+0x16f/0x5f0
> > > > > > > > > > > > =C2=A0=C2=A0 =C2=A0[Mon Mar 11 14:12:05 2024] =C2=
=A0?
> > > > > > > > > > > > nfsd_file_lookup_locked+0x117/0x160 [nfsd]
> > > > > > > > > > > > =C2=A0=C2=A0 =C2=A0[Mon Mar 11 14:12:05 2024] =C2=
=A0? list_lru_del+0x101/0x150
> > > > > > > > > > > > =C2=A0=C2=A0 =C2=A0[Mon Mar 11 14:12:05 2024]=20
> > > > > > > > > > > > =C2=A0nfsd_file_do_acquire+0x790/0x830
> > > > > > > > > > > > [nfsd]
> > > > > > > > > > > > =C2=A0=C2=A0 =C2=A0[Mon Mar 11 14:12:05 2024]=20
> > > > > > > > > > > > =C2=A0nfs4_get_vfs_file+0x315/0x3a0 [nfsd]
> > > > > > > > > > > > =C2=A0=C2=A0 =C2=A0[Mon Mar 11 14:12:05 2024]=20
> > > > > > > > > > > > =C2=A0nfsd4_process_open2+0x430/0xa30 [nfsd]
> > > > > > > > > > > > =C2=A0=C2=A0 =C2=A0[Mon Mar 11 14:12:05 2024] =C2=
=A0? fh_verify+0x297/0x2f0 [nfsd]
> > > > > > > > > > > > =C2=A0=C2=A0 =C2=A0[Mon Mar 11 14:12:05 2024] =C2=
=A0nfsd4_open+0x3ce/0x4b0 [nfsd]
> > > > > > > > > > > > =C2=A0=C2=A0 =C2=A0[Mon Mar 11 14:12:05 2024]=20
> > > > > > > > > > > > =C2=A0nfsd4_proc_compound+0x44b/0x700 [nfsd]
> > > > > > > > > > > > =C2=A0=C2=A0 =C2=A0[Mon Mar 11 14:12:05 2024] =C2=
=A0nfsd_dispatch+0x94/0x1c0 [nfsd]
> > > > > > > > > > > > =C2=A0=C2=A0 =C2=A0[Mon Mar 11 14:12:05 2024] =C2=
=A0svc_process_common+0x2ec/0x660
> > > > > > > > > > > > [sunrpc]
> > > > > > > > > > > > =C2=A0=C2=A0 =C2=A0[Mon Mar 11 14:12:05 2024] =C2=
=A0?=20
> > > > > > > > > > > > __pfx_nfsd_dispatch+0x10/0x10 [nfsd]
> > > > > > > > > > > > =C2=A0=C2=A0 =C2=A0[Mon Mar 11 14:12:05 2024] =C2=
=A0? __pfx_nfsd+0x10/0x10 [nfsd]
> > > > > > > > > > > > =C2=A0=C2=A0 =C2=A0[Mon Mar 11 14:12:05 2024] =C2=
=A0svc_process+0x12d/0x170=20
> > > > > > > > > > > > [sunrpc]
> > > > > > > > > > > > =C2=A0=C2=A0 =C2=A0[Mon Mar 11 14:12:05 2024] =C2=
=A0nfsd+0x84/0xb0 [nfsd]
> > > > > > > > > > > > =C2=A0=C2=A0 =C2=A0[Mon Mar 11 14:12:05 2024] =C2=
=A0kthread+0xdd/0x100
> > > > > > > > > > > > =C2=A0=C2=A0 =C2=A0[Mon Mar 11 14:12:05 2024] =C2=
=A0? __pfx_kthread+0x10/0x10
> > > > > > > > > > > > =C2=A0=C2=A0 =C2=A0[Mon Mar 11 14:12:05 2024] =C2=
=A0ret_from_fork+0x29/0x50
> > > > > > > > > > > > =C2=A0=C2=A0 =C2=A0[Mon Mar 11 14:12:05 2024] =C2=
=A0</TASK>
> > > > > > > > > > > > =C2=A0=C2=A0 =C2=A0[Mon Mar 11 14:12:05 2024] ---[ =
end trace=20
> > > > > > > > > > > > 7a039e17443dc651 ]---
> > > > > > > > > > > This is probably this WARN in nfsd_break_one_deleg:
> > > > > > > > > > >=20
> > > > > > > > > > > WARN_ON_ONCE(!nfsd4_run_cb(&dp->dl_recall));
> > > > > > > > > > >=20
> > > > > > > > > > > It means that a delegation break callback to the clie=
nt=20
> > > > > > > > > > > couldn't be
> > > > > > > > > > > queued to the workqueue, and so it didn't run.
> > > > > > > > > > >=20
> > > > > > > > > > > > Could this be the same issue as described
> > > > > > > > > > > > here:https://urldefense.com/v3/__https://lore.kerne=
l.org/linux-nfs/af0ec881-5ebf-4feb-98ae-3ed2a77f86f1@oracle.com/__;!!ACWV5N=
9M2RV99hQ!LV3yWeoSOhNAkRHkxFCH2tlm0iNFVD78mxnSLyP6lrX7yBVeA2TOJ4nv6oZsqLwP4=
kW56CMpDWhkjjwSkdBV9En7$=20
> > > > > > > > > > > > ?
> > > > > > > > > > > Yes, most likely the same problem.
> > > > > > > > > > If I read that thread correctly, this issue was introdu=
ced=20
> > > > > > > > > > between
> > > > > > > > > > 6.1.63 and 6.6.3? Is it possible the EL9 5.14.0-362.18.=
1.el9_3
> > > > > > > > > > backported these changes, or were we hitting some other=
 bug=20
> > > > > > > > > > with that
> > > > > > > > > > version? It seems the 6.1.x kernel is not affected? If =
so, that
> > > > > > > > > > would be
> > > > > > > > > > the recommended kernel to run?
> > > > > > > > > Anything is possible. We have to identify the problem fir=
st.
> > > > > > > > > > > > As described in that thread, I've tried to obtain t=
he requested
> > > > > > > > > > > > information.
> > > > > > > > > > > >=20
> > > > > > > > > > > > Is it possible this is the issue that was fixed by =
the patches
> > > > > > > > > > > > described
> > > > > > > > > > > > here?https://urldefense.com/v3/__https://lore.kerne=
l.org/linux-nfs/2024022054-cause-suffering-eae8@gregkh/__;!!ACWV5N9M2RV99hQ=
!LV3yWeoSOhNAkRHkxFCH2tlm0iNFVD78mxnSLyP6lrX7yBVeA2TOJ4nv6oZsqLwP4kW56CMpDW=
hkjjwSkedtUP09$=20
> > > > > > > > > > > >=20
> > > > > > > > > > > Doubtful. Those are targeted toward a different set o=
f issues.
> > > > > > > > > > >=20
> > > > > > > > > > > If you're willing, I do have some patches queued up f=
or=20
> > > > > > > > > > > CentOS here
> > > > > > > > > > > that
> > > > > > > > > > > fix some backchannel problems that could be related. =
I'm mainly
> > > > > > > > > > > waiting
> > > > > > > > > > > on Chuck to send these to Linus and then we'll likely=
 merge=20
> > > > > > > > > > > them into
> > > > > > > > > > > CentOS soon afterward:
> > > > > > > > > > >=20
> > > > > > > > > > > https://urldefense.com/v3/__https://gitlab.com/redhat=
/centos-stream/src/kernel/centos-stream-9/-/merge_requests/3689__;!!ACWV5N9=
M2RV99hQ!LV3yWeoSOhNAkRHkxFCH2tlm0iNFVD78mxnSLyP6lrX7yBVeA2TOJ4nv6oZsqLwP4k=
W56CMpDWhkjjwSkdvDn8y7$=20
> > > > > > > > > > >=20
> > > > > > > > > > >=20
> > > > > > > > > > If you can send me a patch file, I can rebuild the C9S =
kernel=20
> > > > > > > > > > with that
> > > > > > > > > > patch and run it. It can take a while for the bug to tr=
igger as I
> > > > > > > > > > believe it seems to be very workload dependent (we were=
=20
> > > > > > > > > > running very
> > > > > > > > > > stable for months and now hit this bug every other week=
).
> > > > > > > > > >=20
> > > > > > > > > >=20
> > > > > > > > > It's probably simpler to just pull down the build artifac=
ts for=20
> > > > > > > > > that MR.
> > > > > > > > > You have to drill down through the CI for it, but they ar=
e here:
> > > > > > > > >=20
> > > > > > > > > https://urldefense.com/v3/__https://s3.amazonaws.com/arr-=
cki-prod-trusted-artifacts/index.html?prefix=3Dtrusted-artifacts*1194300175=
*publish_x86_64*6278921877*artifacts*__;Ly8vLy8!!ACWV5N9M2RV99hQ!LV3yWeoSOh=
NAkRHkxFCH2tlm0iNFVD78mxnSLyP6lrX7yBVeA2TOJ4nv6oZsqLwP4kW56CMpDWhkjjwSkaP5e=
W8V$=20
> > > > > > > > >=20
> > > > > > > > >=20
> > > > > > > > > There's even a repo file you can install on the box to pu=
ll=20
> > > > > > > > > them down.
> > > > > > > > We installed this kernel on the server 3 days ago. Today, a=
 user
> > > > > > > > informed us that their screen was black after logging in.=
=20
> > > > > > > > Similar to
> > > > > > > > other occurrences of this issue, the mount command on the c=
lient=20
> > > > > > > > was
> > > > > > > > hung. But in contrast to the other times, there were no mes=
sages in
> > > > > > > > the logs kernel logs on the server. Even restarting the cli=
ent does
> > > > > > > > not resolve the issue.
> > > > > >=20
> > > > > > Ok, so you rebooted the client and it's still unable to mount? =
That
> > > > > > sounds like a server problem if so.
> > > > > >=20
> > > > > > Are both client and server running the same kernel?
> > > > > No, the server runs 5.14.0-427.3689_1194299994.el9 and the client=
=20
> > > > > 5.14.0-362.18.1.el9_3.
> > > > > >=20
> > > > > > > > Something still seems to be wrong on the server though. Whe=
n I=20
> > > > > > > > look at
> > > > > > > > the directories under /proc/fs/nfsd/clients, there's still =
a=20
> > > > > > > > directory
> > > > > > > > for the specific client, even though it's no longer running=
:
> > > > > > > >=20
> > > > > > > > # cat 155/info
> > > > > > > > clientid: 0xc8edb7f65f4a9ad
> > > > > > > > address: "10.87.31.152:819"
> > > > > > > > status: confirmed
> > > > > > > > seconds from last renew: 33163
> > > > > > > > name: "Linux NFSv4.2 bersalis.esat.kuleuven.be"
> > > > > > > > minor version: 2
> > > > > > > > Implementation domain: "kernel.org"
> > > > > > > > Implementation name: "Linux 5.14.0-362.18.1.el9_3.0.1.x86_6=
4 #1 SMP
> > > > > > > > PREEMPT_DYNAMIC Sun Feb 11 13:49:23 UTC 2024 x86_64"
> > > > > > > > Implementation time: [0, 0]
> > > > > > > > callback state: DOWN
> > > > > > > > callback address: 10.87.31.152:0
> > > > > > > >=20
> > > > > > If you just shut down the client, the server won't immediately=
=20
> > > > > > purge its
> > > > > > record. In fact, assuming you're running the same kernel on the=
=20
> > > > > > server,
> > > > > > it won't purge the client record until there is a conflicting r=
equest
> > > > > > for its state.
> > > > > Is there a way to force such a conflicting request (to get the=
=20
> > > > > client record to purge)?
> > > >=20
> > > > Try:
> > > >=20
> > > > # echo "expire" > /proc/fs/nfsd/clients/155/ctl
> > >=20
> > > I've tried that. The command hangs and can not be interrupted with=
=20
> > > ctrl-c.
> > > I've now also noticed in the dmesg output that the kernel issued the=
=20
> > > following WARNING a few hours ago. It wasn't directly triggered by=
=20
> > > the echo command above, but seems to have been triggered a few hours=
=20
> > > ago (probably when another client started to have the same problem as=
=20
> > > more clients are experiencing issues now).
> >=20
> > I think this warning message is harmless. However it indicates potentia=
l
> > problem with the workqueue which might be related to memory shortage.
> >=20
> > What the output of 'cat /proc/meminfo' looks like?
>=20
> I doubt the current values are useful, but they are:
>=20
> MemTotal: =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0196110860 kB
> MemFree: =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A029357112 kB
> MemAvailable: =C2=A0=C2=A0179529420 kB
> Buffers: =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A011996096 kB
> Cached: =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0130589396 kB
> SwapCached: =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A05=
2 kB
> Active: =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A01136988 kB
> Inactive: =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0144192468 kB
> Active(anon): =C2=A0=C2=A0=C2=A0=C2=A0698564 kB
> Inactive(anon): =C2=A02657256 kB
> Active(file): =C2=A0=C2=A0=C2=A0=C2=A0438424 kB
> Inactive(file): 141535212 kB
> Unevictable: =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A072140 kB
> Mlocked: =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A06906=
8 kB
> SwapTotal: =C2=A0=C2=A0=C2=A0=C2=A0=C2=A067108860 kB
> SwapFree: =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A067106276 kB
> Zswap: =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A00 kB
> Zswapped: =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A00 kB
> Dirty: =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A080812 kB
> Writeback: =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A00 kB
> AnonPages: =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A02806592 kB
> Mapped: =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A032270=
0 kB
> Shmem: =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
599308 kB
> KReclaimable: =C2=A0=C2=A016977000 kB
> Slab: =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A01889873=
6 kB
> SReclaimable: =C2=A0=C2=A016977000 kB
> SUnreclaim: =C2=A0=C2=A0=C2=A0=C2=A0=C2=A01921736 kB
> KernelStack: =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A018128 kB
> PageTables: =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A031716 kB
> SecPageTables: =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A00 kB
> NFS_Unstable: =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A00 kB
> Bounce: =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A00 kB
> WritebackTmp: =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A00 kB
> CommitLimit: =C2=A0=C2=A0=C2=A0165164288 kB
> Committed_AS: =C2=A0=C2=A0=C2=A05223940 kB
> VmallocTotal: =C2=A0=C2=A034359738367 kB
> VmallocUsed: =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0300064 kB
> VmallocChunk: =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A00 kB
> Percpu: =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A045888 kB
> HardwareCorrupted: =C2=A0=C2=A0=C2=A0=C2=A00 kB
> AnonHugePages: =C2=A0=C2=A02451456 kB
> ShmemHugePages: =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A00 kB
> ShmemPmdMapped: =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A00 kB
> FileHugePages: =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A00 kB
> FilePmdMapped: =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A00 kB
> CmaTotal: =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A00 kB
> CmaFree: =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A00 kB
> Unaccepted: =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A00 kB
> HugePages_Total: =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A00
> HugePages_Free: =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A00
> HugePages_Rsvd: =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A00
> HugePages_Surp: =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A00
> Hugepagesize: =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A02048 kB
> Hugetlb: =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A00 kB
> DirectMap4k: =C2=A0=C2=A0=C2=A0=C2=A01303552 kB
> DirectMap2M: =C2=A0=C2=A0=C2=A028715008 kB
> DirectMap1G: =C2=A0=C2=A0=C2=A0171966464 kB
>=20
>=20
> >=20
> > Did you try 'echo 3 > /proc/sys/vm/drop_caches'?
>=20
> Yes, I tried that when the first client hit the issue, but it didn't=20
> result in any unlocking of the client.
>=20
>=20
> >=20
> > >=20
> > > [Tue Mar 19 14:53:44 2024] ------------[ cut here ]------------
> > > [Tue Mar 19 14:53:44 2024] WARNING: CPU: 44 PID: 5843 at=20
> > > fs/nfsd/nfs4state.c:4920 nfsd_break_deleg_cb+0x170/0x190 [nfsd]
> > > [Tue Mar 19 14:53:44 2024] Modules linked in: nf_conntrack_netlink=
=20
> > > nfsv4 dns_resolver nfs fscache netfs binfmt_misc xsk_diag=20
> > > rpcsec_gss_krb5 rpcrdma rdma_cm iw_cm ib_cm ib_core bonding tls=20
> > > rfkill nft_counter nft_ct nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4=
=20
> > > nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nf_tables=
=20
> > > nfnetlink vfat fat dm_thin_pool dm_persistent_data dm_bio_prison=20
> > > dm_bufio libcrc32c dm_service_time dm_multipath intel_rapl_msr=20
> > > intel_rapl_common intel_uncore_frequency=20
> > > intel_uncore_frequency_common isst_if_common skx_edac nfit libnvdimm=
=20
> > > x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel kvm dcdbas=
=20
> > > irqbypass ipmi_ssif rapl intel_cstate mgag200 i2c_algo_bit=20
> > > drm_shmem_helper drm_kms_helper dell_smbios syscopyarea intel_uncore=
=20
> > > sysfillrect wmi_bmof dell_wmi_descriptor pcspkr sysimgblt fb_sys_fops=
=20
> > > mei_me i2c_i801 mei intel_pch_thermal acpi_ipmi i2c_smbus lpc_ich=20
> > > ipmi_si ipmi_devintf ipmi_msghandler joydev acpi_power_meter nfsd=20
> > > nfs_acl lockd auth_rpcgss grace drm fuse sunrpc ext4
> > > [Tue Mar 19 14:53:44 2024]=C2=A0 mbcache jbd2 sd_mod sg lpfc nvmet_fc=
=20
> > > nvmet nvme_fc nvme_fabrics crct10dif_pclmul crc32_pclmul nvme_core=
=20
> > > ixgbe crc32c_intel ahci libahci nvme_common megaraid_sas t10_pi=20
> > > ghash_clmulni_intel wdat_wdt libata scsi_transport_fc mdio dca wmi=
=20
> > > dm_mirror dm_region_hash dm_log dm_mod
> > > [Tue Mar 19 14:53:44 2024] CPU: 44 PID: 5843 Comm: nfsd Not tainted=
=20
> > > 5.14.0-427.3689_1194299994.el9.x86_64 #1
> > > [Tue Mar 19 14:53:44 2024] Hardware name: Dell Inc. PowerEdge=20
> > > R740/00WGD1, BIOS 2.20.1 09/13/2023
> > > [Tue Mar 19 14:53:44 2024] RIP: 0010:nfsd_break_deleg_cb+0x170/0x190=
=20
> > > [nfsd]
> > > [Tue Mar 19 14:53:44 2024] Code: 76 76 cd de e9 ff fe ff ff 48 89 df=
=20
> > > be 01 00 00 00 e8 34 a1 1b df 48 8d bb 98 00 00 00 e8 a8 fe 00 00 84=
=20
> > > c0 0f 85 2e ff ff ff <0f> 0b e9 27 ff ff ff be 02 00 00 00 48 89 df=
=20
> > > e8 0c a1 1b df e9 01
> > > [Tue Mar 19 14:53:44 2024] RSP: 0018:ffffb2878f2cfc38 EFLAGS: 0001024=
6
> > > [Tue Mar 19 14:53:44 2024] RAX: 0000000000000000 RBX:=20
> > > ffff88d5171067b8 RCX: 0000000000000000
> > > [Tue Mar 19 14:53:44 2024] RDX: ffff88d517106880 RSI:=20
> > > ffff88bdceec8600 RDI: 0000000000002000
> > > [Tue Mar 19 14:53:44 2024] RBP: ffff88d68a38a284 R08:=20
> > > ffffb2878f2cfc00 R09: 0000000000000000
> > > [Tue Mar 19 14:53:44 2024] R10: ffff88bf57dd7878 R11:=20
> > > 0000000000000000 R12: ffff88d5b79c4798
> > > [Tue Mar 19 14:53:44 2024] R13: ffff88d68a38a270 R14:=20
> > > ffff88cab06ad0c8 R15: ffff88d5b79c4798
> > > [Tue Mar 19 14:53:44 2024] FS:=C2=A0 0000000000000000(0000)=20
> > > GS:ffff88d4a1180000(0000) knlGS:0000000000000000
> > > [Tue Mar 19 14:53:44 2024] CS:=C2=A0 0010 DS: 0000 ES: 0000 CR0:=20
> > > 0000000080050033
> > > [Tue Mar 19 14:53:44 2024] CR2: 00007fe46ef90000 CR3:=20
> > > 000000019d010004 CR4: 00000000007706e0
> > > [Tue Mar 19 14:53:44 2024] DR0: 0000000000000000 DR1:=20
> > > 0000000000000000 DR2: 0000000000000000
> > > [Tue Mar 19 14:53:44 2024] DR3: 0000000000000000 DR6:=20
> > > 00000000fffe0ff0 DR7: 0000000000000400
> > > [Tue Mar 19 14:53:44 2024] PKRU: 55555554
> > > [Tue Mar 19 14:53:44 2024] Call Trace:
> > > [Tue Mar 19 14:53:44 2024]=C2=A0 <TASK>
> > > [Tue Mar 19 14:53:44 2024]=C2=A0 ? show_trace_log_lvl+0x1c4/0x2df
> > > [Tue Mar 19 14:53:44 2024]=C2=A0 ? show_trace_log_lvl+0x1c4/0x2df
> > > [Tue Mar 19 14:53:44 2024]=C2=A0 ? __break_lease+0x16f/0x5f0
> > > [Tue Mar 19 14:53:44 2024]=C2=A0 ? nfsd_break_deleg_cb+0x170/0x190 [n=
fsd]
> > > [Tue Mar 19 14:53:44 2024]=C2=A0 ? __warn+0x81/0x110
> > > [Tue Mar 19 14:53:44 2024]=C2=A0 ? nfsd_break_deleg_cb+0x170/0x190 [n=
fsd]
> > > [Tue Mar 19 14:53:44 2024]=C2=A0 ? report_bug+0x10a/0x140
> > > [Tue Mar 19 14:53:44 2024]=C2=A0 ? handle_bug+0x3c/0x70
> > > [Tue Mar 19 14:53:44 2024]=C2=A0 ? exc_invalid_op+0x14/0x70
> > > [Tue Mar 19 14:53:44 2024]=C2=A0 ? asm_exc_invalid_op+0x16/0x20
> > > [Tue Mar 19 14:53:44 2024]=C2=A0 ? nfsd_break_deleg_cb+0x170/0x190 [n=
fsd]
> > > [Tue Mar 19 14:53:44 2024]=C2=A0 ? nfsd_break_deleg_cb+0x96/0x190 [nf=
sd]
> > > [Tue Mar 19 14:53:44 2024]=C2=A0 __break_lease+0x16f/0x5f0
> > > [Tue Mar 19 14:53:44 2024]=C2=A0 nfs4_get_vfs_file+0x164/0x3a0 [nfsd]
> > > [Tue Mar 19 14:53:44 2024]=C2=A0 nfsd4_process_open2+0x430/0xa30 [nfs=
d]
> > > [Tue Mar 19 14:53:44 2024]=C2=A0 ? fh_verify+0x297/0x2f0 [nfsd]
> > > [Tue Mar 19 14:53:44 2024]=C2=A0 nfsd4_open+0x3ce/0x4b0 [nfsd]
> > > [Tue Mar 19 14:53:44 2024]=C2=A0 nfsd4_proc_compound+0x44b/0x700 [nfs=
d]
> > > [Tue Mar 19 14:53:44 2024]=C2=A0 nfsd_dispatch+0x94/0x1c0 [nfsd]
> > > [Tue Mar 19 14:53:44 2024]=C2=A0 svc_process_common+0x2ec/0x660 [sunr=
pc]
> > > [Tue Mar 19 14:53:44 2024]=C2=A0 ? __pfx_nfsd_dispatch+0x10/0x10 [nfs=
d]
> > > [Tue Mar 19 14:53:44 2024]=C2=A0 ? __pfx_nfsd+0x10/0x10 [nfsd]
> > > [Tue Mar 19 14:53:44 2024]=C2=A0 svc_process+0x12d/0x170 [sunrpc]
> > > [Tue Mar 19 14:53:44 2024]=C2=A0 nfsd+0x84/0xb0 [nfsd]
> > > [Tue Mar 19 14:53:44 2024]=C2=A0 kthread+0xdd/0x100
> > > [Tue Mar 19 14:53:44 2024]=C2=A0 ? __pfx_kthread+0x10/0x10
> > > [Tue Mar 19 14:53:44 2024]=C2=A0 ret_from_fork+0x29/0x50
> > > [Tue Mar 19 14:53:44 2024]=C2=A0 </TASK>
> > > [Tue Mar 19 14:53:44 2024] ---[ end trace ed0b2b3f135c637d ]---
> > >=20
> > > It again seems to have been triggered in nfsd_break_deleg_cb?
> > >=20
> > > I also had the following perf command running a tmux on the server:
> > >=20
> > > perf trace -e nfsd:nfsd_cb_recall_any
> > >=20
> > > This has spewed a lot of messages. I'm including a short list here:
> > >=20
> > > ...
> > >=20
> > > 33464866.721 kworker/u98:5/1591466 nfsd:nfsd_cb_recall_any(cl_boot:=
=20
> > > 1710533037, cl_id: 210688785, bmval0: 1, addr: 0x7f331bb116c8)
> > > 33464866.724 kworker/u98:5/1591466 nfsd:nfsd_cb_recall_any(cl_boot:=
=20
> > > 1710533037, cl_id: 210688827, bmval0: 1, addr: 0x7f331bb11738)
> > > 33464866.729 kworker/u98:5/1591466 nfsd:nfsd_cb_recall_any(cl_boot:=
=20
> > > 1710533037, cl_id: 210688767, bmval0: 1, addr: 0x7f331bb117a8)
> > > 33464866.732 kworker/u98:5/1591466 nfsd:nfsd_cb_recall_any(cl_boot:=
=20
> > > 1710533037, cl_id: 210718132, bmval0: 1, addr: 0x7f331bb11818)
> > > 33464866.737 kworker/u98:5/1591466 nfsd:nfsd_cb_recall_any(cl_boot:=
=20
> > > 1710533037, cl_id: 210688952, bmval0: 1, addr: 0x7f331bb11888)
> > > 33464866.741 kworker/u98:5/1591466 nfsd:nfsd_cb_recall_any(cl_boot:=
=20
> > > 1710533037, cl_id: 210702355, bmval0: 1, addr: 0x7f331bb118f8)
> > > 33868414.001 kthreadd/1597068 nfsd:nfsd_cb_recall_any(cl_boot:=20
> > > 1710533037, cl_id: 210688751, bmval0: 1, addr: 0x7f331be68620)
> > > 33868414.014 kthreadd/1597068 nfsd:nfsd_cb_recall_any(cl_boot:=20
> > > 1710533037, cl_id: 210718536, bmval0: 1, addr: 0x7f331be68690)
> > > 33868414.018 kthreadd/1597068 nfsd:nfsd_cb_recall_any(cl_boot:=20
> > > 1710533037, cl_id: 210719074, bmval0: 1, addr: 0x7f331be68700)
> > > 33868414.022 kthreadd/1597068 nfsd:nfsd_cb_recall_any(cl_boot:=20
> > > 1710533037, cl_id: 210688916, bmval0: 1, addr: 0x7f331be68770)
> > > 33868414.026 kthreadd/1597068 nfsd:nfsd_cb_recall_any(cl_boot:=20
> > > 1710533037, cl_id: 210688941, bmval0: 1, addr: 0x7f331be687e0)
> > > ...
> > >=20
> > > 33868414.924 kthreadd/1597068 nfsd:nfsd_cb_recall_any(cl_boot:=20
> > > 1710533037, cl_id: 210688744, bmval0: 1, addr: 0x7f331be6d7f0)
> > > 33868414.929 kthreadd/1597068 nfsd:nfsd_cb_recall_any(cl_boot:=20
> > > 1710533037, cl_id: 210717223, bmval0: 1, addr: 0x7f331be6d860)
> > > 33868414.934 kthreadd/1597068 nfsd:nfsd_cb_recall_any(cl_boot:=20
> > > 1710533037, cl_id: 210716137, bmval0: 1, addr: 0x7f331be6d8d0)
> > > 34021240.903 kworker/u98:5/1591466 nfsd:nfsd_cb_recall_any(cl_boot:=
=20
> > > 1710533037, cl_id: 210688941, bmval0: 1, addr: 0x7f331c207de8)
> > > 34021240.917 kworker/u98:5/1591466 nfsd:nfsd_cb_recall_any(cl_boot:=
=20
> > > 1710533037, cl_id: 210718750, bmval0: 1, addr: 0x7f331c207e58)
> > > 34021240.922 kworker/u98:5/1591466 nfsd:nfsd_cb_recall_any(cl_boot:=
=20
> > > 1710533037, cl_id: 210688955, bmval0: 1, addr: 0x7f331c207ec8)
> > > 34021240.925 kworker/u98:5/1591466 nfsd:nfsd_cb_recall_any(cl_boot:=
=20
> > > 1710533037, cl_id: 210688975, bmval0: 1, addr: 0x7f331c207f38)
> > > ...
> > >=20
> > > I assume the cl_id is the client id? How can I map this to a client=
=20
> > > from /proc/fs/nfsd/clients?
> >=20
> > The hex value of 'clientid' printed from /proc/fs/nfsd/clients/XX/info
> > is a 64-bit value composed of:
> >=20
> > typedef struct {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u32=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cl_boot;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u32=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cl_id;
> > } clientid_t
> >=20
> > For example:
> >=20
> > clientid: 0xc8edb7f65f4a9ad
> >=20
> > cl_boot:=C2=A0 65f4a9add (1710533037)
> > cl_id:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 c8edb7f (21068895)
> >=20
> > This should match a trace event with:
> >=20
> > nfsd:nfsd_cb_recall_any(cl_boot: 1710533037, cl_id: 21068895, bmval0:=
=20
> > XX, addr: 0xYYYYY)
> >=20
> > >=20
> > > If I understand it correctly, the recall_any should be called when=
=20
> > > either the system starts to experience memory pressure,
> >=20
> > yes.
> It seems odd that the system gets in such a state that has such high=20
> memory pressure. It doesn't run much else than NFS and Samba.
> >=20
> > > or it reaches the delegation limits?
> >=20
> > No, this feature was added to nfsd very recently. I don't think your=
=20
> > kernel has it.
> >=20
> > > I doubt the system is actually running out of memory here as there=
=20
> > > are no other indications.
> > > Shouldn't I get those "page allocation failure" messages if it does?=
=20
> > > How can I check the number of delegations/leases currently issued,
> > > what the current maximum is and how to increase it?
> >=20
> > Max delegations is 4 per 1MB of available memory. There is no
> > admin tool to adjust this value.
> /proc/locks currently has about 130k DELEG lines, so that should be a=20
> lot lower than the limit on a 192G ram server.
>
>
> >=20
> > I do not recommend running a production system with delegation
> > disabled. But for this specific issue, it might help to temporarily
> > disable delegation to isolate problem areas.
>=20
>=20
> I'm going to reboot the system with the 6.1.82 kernel (kernel-lt from=20
> elrepo). Maybe it has less new modern developments that may have=20
> introduced this.
>=20

If v6.1-ish kernel turns out to not help, then you may want to give a
v6.7 or v6.8 kernel a try. It helps if we know whether this problem is
reproducible on in more up to date kernels.

> I've been able to reproduce the situation on an additional client now=20
> that the issue happens on the server:
>=20
>  1. Log in on a client and mount the NFS share.
>  2. Open a file from the NFS share in vim so the client gets a read
>     delegation from the server
>  3. Verify on the server in /proc/fs/nfsd/clients/*/states that the
>     client has a delegation for the file
>  4. Forcefully reboot the client by running 'echo b > /proc/sysrq-trigger=
'
>  5. Watch the /proc/fs/nfsd/clients/*/info file on the server.
>=20
> The "seconds from last renew" will go up and at some point the callback=
=20
> state changes to "FAULT". Even when the lease delegation time (90s by=20
> default?) is over, the
>=20
> seconds from last renew keeps increasing. At some point the callback=20
> state changes to "DOWN". When the client is up again and remounts the=20
> share, the mount hangs on the client
>=20
> and on the server I notice there's a second directory for this client in=
=20
> the clients directory, even though the clientid is the same. The=20
> callback state for this new client is "UNKNOWN" and the callback address=
=20
> is "(einval)".
>=20
> This is on a client running Fedora 39 with the 6.7.9 kernel.
>=20

I'm a little unclear...do the above steps work correctly when the server
isn't in this state? I assume the above steps are not sufficient to
cause a problem when the server is behaving normally?

>=20
> I don't know yet if the same procedure can be used to trigger the=20
> behavior after the server is rebooted. I'm going to try to reproduce=20
> this on another system first.
>=20
> I would expect the delegations to expire automatically after 90s, but=20
> they remain in the states file of the "DOWN" client.
>=20

That would have been true a year or so ago, but there were some recent
changes to make the server more "courteous" toward clients that lose
contact for a while. If there are no conflicting requests for the state
they hold then the server will hold onto the lease (basically)
indefinitely, until there is such a conflict.

The client _should_ be able to log in and it cancel the old client
record though. It sounds like that's not working properly for some
reason and it's interfering with the ability to do a CREATE_SESSION.

>=20
> >=20
> > -Dai
> >=20
> > >=20
> > > Regarding the recall any call: from what I've read on kernelnewbies,=
=20
> > > this feature was introduced in the 6.2 kernel? When I look at the=20
> > > tree for 6.1.x, it was backported in 6.1.81? Is there a way to=20
> > > disable this support somehow?
> > >=20
> > > Regards,
> > >=20
> > > Rik
> > >=20
> > >=20
> > > >=20
> > > > -Dai
> > > >=20
> > > > > >=20
> > > > > >=20
> > > > > > > The nfsdclnts command for this client shows the following=20
> > > > > > > delegations:
> > > > > > >=20
> > > > > > > # nfsdclnts -f 155/states -t all
> > > > > > > Inode number | Type=C2=A0=C2=A0 | Access | Deny | ip address =
| Filename
> > > > > > > 169346743=C2=A0=C2=A0=C2=A0 | open=C2=A0=C2=A0 | r-=C2=A0=C2=
=A0=C2=A0=C2=A0 | --=C2=A0=C2=A0 | 10.87.31.152:819 |
> > > > > > > disconnected dentry
> > > > > > > 169346743=C2=A0=C2=A0=C2=A0 | deleg=C2=A0 | r=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 10.87.31.152:819 |
> > > > > > > disconnected dentry
> > > > > > > 169346746=C2=A0=C2=A0=C2=A0 | open=C2=A0=C2=A0 | r-=C2=A0=C2=
=A0=C2=A0=C2=A0 | --=C2=A0=C2=A0 | 10.87.31.152:819 |
> > > > > > > disconnected dentry
> > > > > > > 169346746=C2=A0=C2=A0=C2=A0 | deleg=C2=A0 | r=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 10.87.31.152:819 |
> > > > > > > disconnected dentry
> > > > > > >=20
> > > > > > > I see a lot of recent patches regarding directory delegations=
. Could
> > > > > > > this be related to this?
> > > > > > >=20
> > > > > > > Will a 5.14.0-362.18.1.el9_3.0.1 kernel try to use a director=
y=20
> > > > > > > delegation?
> > > > > > >=20
> > > > > > >=20
> > > > > > No. Directory delegations are a new feature that's still under
> > > > > > development. They use some of the same machinery as file delega=
tions,
> > > > > > but they wouldn't be a factor here.
> > > > > >=20
> > > > > > > > The system seems to have identified that the client is no l=
onger
> > > > > > > > reachable, but the client entry does not go away. When a mo=
unt was
> > > > > > > > hanging on the client, there would be two directories in cl=
ients=20
> > > > > > > > for
> > > > > > > > the same client. Killing the mount command clears up the se=
cond=20
> > > > > > > > entry.
> > > > > > > >=20
> > > > > > > > Even after running conntrack -D on the server to remove the=
 tcp
> > > > > > > > connection from the conntrack table, the entry doesn't go a=
way=20
> > > > > > > > and the
> > > > > > > > client still can not mount anything from the server.
> > > > > > > >=20
> > > > > > > > A tcpdump on the client while a mount was running logged th=
e=20
> > > > > > > > following
> > > > > > > > messages over and over again:
> > > > > > > >=20
> > > > > > > > request:
> > > > > > > >=20
> > > > > > > > Frame 1: 378 bytes on wire (3024 bits), 378 bytes captured =
(3024=20
> > > > > > > > bits)
> > > > > > > > Ethernet II, Src: HP_19:7d:4b (e0:73:e7:19:7d:4b), Dst:
> > > > > > > > ArubaaHe_f9:8e:00 (88:3a:30:f9:8e:00)
> > > > > > > > Internet Protocol Version 4, Src: 10.87.31.152, Dst: 10.86.=
18.14
> > > > > > > > Transmission Control Protocol, Src Port: 932, Dst Port: 204=
9,=20
> > > > > > > > Seq: 1,
> > > > > > > > Ack: 1, Len: 312
> > > > > > > > Remote Procedure Call, Type:Call XID:0x1d3220c4
> > > > > > > > Network File System
> > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0 [Program Version: 4]
> > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0 [V4 Procedure: COMPOUND (1)]
> > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0 GSS Data, Ops(1): CREATE_SESSION
> > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Length: 15=
2
> > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 GSS Sequen=
ce Number: 76
> > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Tag: <EMPT=
Y>
> > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 minorversi=
on: 2
> > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Operations=
 (count: 1): CREATE_SESSION
> > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [Main Opco=
de: CREATE_SESSION (43)]
> > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0 GSS Checksum:
> > > > > > > > 00000028040404ffffffffff000000002c19055f1f8d442d594c1384962=
8affc2797cbb2=E2=80=A6=20
> > > > > > > >=20
> > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 GSS Token =
Length: 40
> > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 GSS-API Ge=
neric Security Service Application Program=20
> > > > > > > > Interface
> > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 krb5_blob:
> > > > > > > > 040404ffffffffff000000002c19055f1f8d442d594c13849628affc279=
7cbb23fa080b0=E2=80=A6=20
> > > > > > > >=20
> > > > > > > >=20
> > > > > > > > response:
> > > > > > > >=20
> > > > > > > > Frame 2: 206 bytes on wire (1648 bits), 206 bytes captured =
(1648=20
> > > > > > > > bits)
> > > > > > > > Ethernet II, Src: ArubaaHe_f9:8e:00 (88:3a:30:f9:8e:00), Ds=
t:
> > > > > > > > HP_19:7d:4b (e0:73:e7:19:7d:4b)
> > > > > > > > Internet Protocol Version 4, Src: 10.86.18.14, Dst: 10.87.3=
1.152
> > > > > > > > Transmission Control Protocol, Src Port: 2049, Dst Port: 93=
2,=20
> > > > > > > > Seq: 1,
> > > > > > > > Ack: 313, Len: 140
> > > > > > > > Remote Procedure Call, Type:Reply XID:0x1d3220c4
> > > > > > > > Network File System
> > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0 [Program Version: 4]
> > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0 [V4 Procedure: COMPOUND (1)]
> > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0 GSS Data, Ops(1): CREATE_SESSION(N=
FS4ERR_DELAY)
> > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Length: 24
> > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 GSS Sequen=
ce Number: 76
> > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Status: NF=
S4ERR_DELAY (10008)
> > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Tag: <EMPT=
Y>
> > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Operations=
 (count: 1)
> > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [Main Opco=
de: CREATE_SESSION (43)]
> > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0 GSS Checksum:
> > > > > > > > 00000028040405ffffffffff000000000aa742d0798deaad1a8aa2d7c3a=
91bf4f6274222=E2=80=A6=20
> > > > > > > >=20
> > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 GSS Token =
Length: 40
> > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 GSS-API Ge=
neric Security Service Application Program=20
> > > > > > > > Interface
> > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 krb5_blob:
> > > > > > > > 040405ffffffffff000000000aa742d0798deaad1a8aa2d7c3a91bf4f62=
7422226d74923=E2=80=A6=20
> > > > > > > >=20
> > > > > > > >=20
> > > > > > > > I was hoping that giving the client a different IP address =
would
> > > > > > > > resolve the issue for this client, but it didn't. Even thou=
gh the
> > > > > > > > client had a new IP address (hostname was kept the same), i=
t=20
> > > > > > > > failed to
> > > > > > > > mount anything from the server.
> > > > > > > >=20
> > > > > > Changing the IP address won't help. The client is probably usin=
g the
> > > > > > same long-form client id as before, so the server still identif=
ies=20
> > > > > > the
> > > > > > client even with the address change.
> > > > > How is the client id determined? Will changing the hostname of th=
e=20
> > > > > client trigger a change of the client id?
> > > > > >=20
> > > > > > Unfortunately, the cause of an NFS4ERR_DELAY error is tough to =
guess.
> > > > > > The client is expected to back off and retry, so if the server =
keeps
> > > > > > returning that repeatedly, then a hung mount command is expecte=
d.
> > > > > >=20
> > > > > > The question is why the server would keep returning DELAY. A lo=
t of
> > > > > > different problems ranging from memory allocation issues to pro=
tocol
> > > > > > problems can result in that error. You may want to check the NF=
S=20
> > > > > > server
> > > > > > and see if anything was logged there.
> > > > > There are no messages in the system logs that indicate any sort o=
f=20
> > > > > memory issue. We also increased the min_kbytes_free sysctl to 2G =
on=20
> > > > > the server before we restarted it with the newer kernel.
> > > > > >=20
> > > > > > This is on a CREATE_SESSION call, so I wonder if the record hel=
d=20
> > > > > > by the
> > > > > > (courteous) server is somehow blocking the attempt to reestabli=
sh the
> > > > > > session?
> > > > > >=20
> > > > > > Do you have a way to reproduce this? Since this is a centos=20
> > > > > > kernel, you
> > > > > > could follow the page here to open a bug:
> > > > >=20
> > > > > Unfortunately we haven't found a reliable way to reproduce it. Bu=
t=20
> > > > > we do seem to trigger it more and more lately.
> > > > >=20
> > > > > Regards,
> > > > >=20
> > > > > Rik
> > > > >=20
> > > > > >=20
> > > > > > https://urldefense.com/v3/__https://wiki.centos.org/ReportBugs.=
html__;!!ACWV5N9M2RV99hQ!LV3yWeoSOhNAkRHkxFCH2tlm0iNFVD78mxnSLyP6lrX7yBVeA2=
TOJ4nv6oZsqLwP4kW56CMpDWhkjjwSkWIqsboq$=20
> > > > > >=20
> > > > > >=20
> > > > > > > > I created another dump of the workqueues and worker pools o=
n the=20
> > > > > > > > server:
> > > > > > > >=20
> > > > > > > > [Mon Mar 18 14:59:33 2024] Showing busy workqueues and work=
er=20
> > > > > > > > pools:
> > > > > > > > [Mon Mar 18 14:59:33 2024] workqueue events: flags=3D0x0
> > > > > > > > [Mon Mar 18 14:59:33 2024] =C2=A0=C2=A0pwq 54: cpus=3D27 no=
de=3D1 flags=3D0x0=20
> > > > > > > > nice=3D0
> > > > > > > > active=3D1/256 refcnt=3D2
> > > > > > > > [Mon Mar 18 14:59:33 2024] =C2=A0=C2=A0=C2=A0=C2=A0pending:=
 drm_fb_helper_damage_work
> > > > > > > > [drm_kms_helper]
> > > > > > > > [Mon Mar 18 14:59:33 2024] workqueue events_power_efficient=
:=20
> > > > > > > > flags=3D0x80
> > > > > > > > [Mon Mar 18 14:59:33 2024] =C2=A0=C2=A0pwq 54: cpus=3D27 no=
de=3D1 flags=3D0x0=20
> > > > > > > > nice=3D0
> > > > > > > > active=3D1/256 refcnt=3D2
> > > > > > > > [Mon Mar 18 14:59:33 2024] =C2=A0=C2=A0=C2=A0=C2=A0pending:=
 fb_flashcursor
> > > > > > > > [Mon Mar 18 14:59:33 2024] workqueue mm_percpu_wq: flags=3D=
0x8
> > > > > > > > [Mon Mar 18 14:59:33 2024] =C2=A0=C2=A0pwq 54: cpus=3D27 no=
de=3D1 flags=3D0x0=20
> > > > > > > > nice=3D0
> > > > > > > > active=3D1/256 refcnt=3D3
> > > > > > > > [Mon Mar 18 14:59:33 2024] =C2=A0=C2=A0=C2=A0=C2=A0pending:=
 lru_add_drain_per_cpu=20
> > > > > > > > BAR(362)
> > > > > > > > [Mon Mar 18 14:59:33 2024] workqueue kblockd: flags=3D0x18
> > > > > > > > [Mon Mar 18 14:59:33 2024] =C2=A0=C2=A0pwq 55: cpus=3D27 no=
de=3D1 flags=3D0x0=20
> > > > > > > > nice=3D-20
> > > > > > > > active=3D1/256 refcnt=3D2
> > > > > > > > [Mon Mar 18 14:59:33 2024] =C2=A0=C2=A0=C2=A0=C2=A0pending:=
 blk_mq_timeout_work
> > > > > > > >=20
> > > > > > > >=20
> > > > > > > > In contrast to last time, it doesn't show anything regardin=
g nfs=20
> > > > > > > > this
> > > > > > > > time.
> > > > > > > >=20
> > > > > > > > I also tried the suggestion from Dai Ngo (echo 3 >
> > > > > > > > /proc/sys/vm/drop_caches), but that didn't seem to make any=
=20
> > > > > > > > difference.
> > > > > > > >=20
> > > > > > > > We haven't restarted the server yet as it seems the impact =
seems to
> > > > > > > > affect fewer clients that before. Is there anything we can =
run=20
> > > > > > > > on the
> > > > > > > > server to further debug this?
> > > > > > > >=20
> > > > > > > > In the past, the issue seemed to deteriorate rapidly and=
=20
> > > > > > > > resulted in
> > > > > > > > issues for almost all clients after about 20 minutes. This =
time the
> > > > > > > > impact seems to be less, but it's not gone.
> > > > > > > >=20
> > > > > > > > How can we force the NFS server to forget about a specific=
=20
> > > > > > > > client? I
> > > > > > > > haven't tried to restart the nfs service yet as I'm afraid =
it will
> > > > > > > > fail to stop as before.
> > > > > > > >=20
> > > > > > Not with that kernel. There are some new administrative interfa=
ces=20
> > > > > > that
> > > > > > might allow that in the future, but they were just merged upstr=
eam=20
> > > > > > and
> > > > > > aren't in that kernel.
> > > > > >=20
> > > > > > --=20
> > > > > > Jeff Layton <jlayton@kernel.org>
> > > > >=20

--=20
Jeff Layton <jlayton@kernel.org>

