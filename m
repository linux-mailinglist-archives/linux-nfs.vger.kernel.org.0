Return-Path: <linux-nfs+bounces-10332-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BC84A43E59
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Feb 2025 12:55:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CE943A94C0
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Feb 2025 11:51:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F08EB267B14;
	Tue, 25 Feb 2025 11:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AIsh+J33"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9E31267B0D
	for <linux-nfs@vger.kernel.org>; Tue, 25 Feb 2025 11:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740484325; cv=none; b=YoQHVsdZrV7w3SaWATibBGcx5SO/KuSYr4aC42XXlPQ3LLATVJ+iDOs2j/0drxMLpblym4Uy5PpmSybJlWfwO/memAxiGjE4JtejhnI8u3QwpH5dGQEzctCtLiXpceSsinRf+k7juViLWU9lyBRUtmrlF13rimRZNl4Ot8vjS2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740484325; c=relaxed/simple;
	bh=24TPwuR7cOC68UrJcUsmB9pJrm6UafX94cAPzDW6WaQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Kp7dQn55MXJkf1V/h9fitkNNj9me0yHVgEMoBlqAlne+MCRx217IkzoD4L8DdzUjaE8z6ttinVi4OKKaVCC8qYJ/GLkWbKYdN2xDJRndag9IU3Ksk3rLIL7MPd9sug3zSQXw6+6UWIvAXtPjqhVnIhr5YdRB9XtxgNqIY+0Td2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AIsh+J33; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3417BC4CEDD;
	Tue, 25 Feb 2025 11:52:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740484325;
	bh=24TPwuR7cOC68UrJcUsmB9pJrm6UafX94cAPzDW6WaQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=AIsh+J33N8InjY/JrvBHbXeudNFedvb0NybVX5yF6Xh2VnQYbS01GVkzoJFhKEAC3
	 c8rP6AIbxeR1tXnFevtkBfLpBC5nOscOYIyBjZbVPbSEpQuzyP3+ddjQ2ZGcKsOBMM
	 ZFygTsUJ31YGp9fqRckrki8FAJsO+iWW2zs5GWN/Mr4LcaEPCiugLyjRzTx3VzVGPY
	 eDgnm5rrq6Da7Y3PAm+zKGL/G8UDUPwQ6UfiYlbeuJLzDzI+Iuniyv6YU3oeXFOOPO
	 8mA6j+VqMSLXTAN7HRpGO2hpSWBezZb0hqOC7mblvTYOx3ZMOcf8+VeVm38OEnDlKh
	 eXK8g+lo87IZw==
Message-ID: <090bbf28ace1a6f7c05da726b62cd642f24b01d0.camel@kernel.org>
Subject: Re: [Question]Is a Kernel Timeout Recovery Mechanism Needed for
 Prolonged User-Space Downcall Unresponsiveness?
From: Jeff Layton <jlayton@kernel.org>
To: Li Lingfeng <lilingfeng3@huawei.com>, Chuck Lever
 <chuck.lever@oracle.com>,  NeilBrown <neilb@suse.de>, Olga Kornievskaia
 <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,  Tom Talpey
 <tom@talpey.com>
Cc: "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>, Yu Kuai
	 <yukuai1@huaweicloud.com>, Hou Tao <houtao1@huawei.com>, "zhangyi (F)"
	 <yi.zhang@huawei.com>, yangerkun <yangerkun@huawei.com>, Li Lingfeng
	 <lilingfeng@huaweicloud.com>, "zhangjian (CG)" <zhangjian496@huawei.com>
Date: Tue, 25 Feb 2025 06:52:02 -0500
In-Reply-To: <c44533cc-f625-4eda-b47b-c6f6dd01c991@huawei.com>
References: <c44533cc-f625-4eda-b47b-c6f6dd01c991@huawei.com>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-02-25 at 16:51 +0800, Li Lingfeng wrote:
> =C2=A0
>=20
> Hi.
> =C2=A0Recently, during fault injection testing, we found an issue where n=
fsd
> =C2=A0process cannot exit when /proc/fs/nfsd/threads is written to 0, cau=
sing
> =C2=A0other processes to be unable to acquire nfsd_mutex, leading to a hu=
ngtask.
> =C2=A0This is the stack trace of the nfsd process:
> =C2=A0PID: 107326=C2=A0 TASK: ffff8881013a4040=C2=A0 CPU: 1=C2=A0=C2=A0 C=
OMMAND: "nfsd"
> =C2=A0=C2=A0#0 [ffffc900077077d8] __schedule at ffffffff9c6434b6
> =C2=A0=C2=A0#1 [ffffc900077078d8] schedule at ffffffff9c643e28
> =C2=A0=C2=A0#2 [ffffc90007707900] schedule_timeout at ffffffff9c64bf16
> =C2=A0=C2=A0#3 [ffffc90007707a68] wait_for_common at ffffffff9c645346
> =C2=A0=C2=A0#4 [ffffc90007707b38] nfsd4_cld_create at ffffffff9b80626a
> =C2=A0=C2=A0#5 [ffffc90007707c40] nfsd4_open_confirm at ffffffff9b7f41d9
> =C2=A0=C2=A0#6 [ffffc90007707ce0] nfsd4_proc_compound at ffffffff9b7c872a
> =C2=A0=C2=A0#7 [ffffc90007707d80] nfsd_dispatch at ffffffff9b79f20d
> =C2=A0=C2=A0#8 [ffffc90007707dc8] svc_process_common at ffffffff9c4ad9fb
> =C2=A0=C2=A0#9 [ffffc90007707ea0] svc_process at ffffffff9c4adf15
> =C2=A0#10 [ffffc90007707ed8] nfsd at ffffffff9b79ba18
> =C2=A0#11 [ffffc90007707f10] kthread at ffffffff9af908c4
> =C2=A0#12 [ffffc90007707f50] ret_from_fork at ffffffff9ae048df
> =C2=A0
>=20
> =C2=A0This is because the nfsdcld process exited abnormally, causing the =
nfsd
> =C2=A0process to wait indefinitely for a downcall response after initiati=
ng an
> =C2=A0upcall.
> =C2=A0Here is the log of nfsdcld:
> =C2=A0Jan=C2=A0 4 02:22:29 localhost nfsdcld[696]: cld_message_size inval=
id upcall version 0
> =C2=A0Jan=C2=A0 4 02:22:29 localhost systemd[1]: nfsdcld.service: Main pr=
ocess exited, code=3Dexited, status=3D1/FAILURE
> =C2=A0Jan=C2=A0 4 02:22:29 localhost systemd[1]: nfsdcld.service: Failed =
with result 'exit-code'.
> =C2=A0
>=20
> =C2=A0Memory fault injection caused the kernel to report cld_msg in v1 fo=
rmat,
> =C2=A0and nfsdcld parsed it incorrectly, leading to an abnormal exit.
> =C2=A0
>=20
> =C2=A0// Expected Scenario
> =C2=A0nfsd4_client_tracking_init
> =C2=A0=C2=A0nn->client_tracking_ops =3D &nfsd4_cld_tracking_ops; // Initi=
alize to v1
> =C2=A0=C2=A0nfsd4_cld_tracking_init
> =C2=A0=C2=A0 nfsd4_cld_get_version
> =C2=A0=C2=A0=C2=A0 cld_pipe_upcall // Request version information from us=
er space
> =C2=A0=C2=A0=C2=A0 nn->client_tracking_ops =3D &nfsd4_cld_tracking_ops_v2=
; // Initialize to v2
> =C2=A0
>=20
> =C2=A0// Actual Scenario
> =C2=A0nfsd4_client_tracking_init
> =C2=A0=C2=A0nn->client_tracking_ops =3D &nfsd4_cld_tracking_ops; // Initi=
alize to v1
> =C2=A0=C2=A0nfsd4_cld_tracking_init
> =C2=A0=C2=A0 nfsd4_cld_get_version
> =C2=A0=C2=A0=C2=A0 alloc_cld_upcall // A failure is returned due to memor=
y fault
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // injection, and the upca=
ll is skipped.
> =C2=A0=C2=A0 nfsd4_cld_grace_start
> =C2=A0=C2=A0=C2=A0 alloc_cld_upcall // A failure is returned due to memor=
y fault
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // injection, and the upca=
ll is skipped.
> =C2=A0=C2=A0nn->client_tracking_ops =3D &nfsd4_cld_tracking_ops_v0 // Ini=
tialize to v1
> =C2=A0
>=20
> I was wondering if the kernel might benefit from having a timeout mechani=
sm
> =C2=A0in place to gracefully handle situations where nfsdcld is unable to=
 send a
> =C2=A0downcall for certain reasons, ensuring that the nfsd process can ex=
it properly.
>=20
> =C2=A0Link:https://lore.kernel.org/all/3e26c767-f347-4dbe-ae04-aabe8e87af=
12@huawei.com/
> =C2=A0

That does sound like a real bug to me. Looks like there is a similar
problem in the client-side block layout upcall (bl_resolve_deviceid)
too.

In practice, this could even happen while the server was running, which
would probably cause a RECLAIM_COMPLETE or OPEN operation to hang
indefinitely. Adding a timeout sounds reasonable.
--=20
Jeff Layton <jlayton@kernel.org>

