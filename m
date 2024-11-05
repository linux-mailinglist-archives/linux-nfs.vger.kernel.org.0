Return-Path: <linux-nfs+bounces-7679-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D605A9BD92E
	for <lists+linux-nfs@lfdr.de>; Tue,  5 Nov 2024 23:55:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 48201B20FC6
	for <lists+linux-nfs@lfdr.de>; Tue,  5 Nov 2024 22:55:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C0B2216435;
	Tue,  5 Nov 2024 22:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s05xbXMs"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72DAE1F80C4;
	Tue,  5 Nov 2024 22:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730847315; cv=none; b=pxQiP2v1bt0fvIL3uNTonmQsuakVo5Vgj/eycbv6uFkZIw7394sZsj+FcEdwx7A3zYEQVLKPxOq3OH2T0cf3e7CAEectvDe+lCV7HV4yduYkjnKXsz7vEeVoD0dFrTIGC0z2w2PEG6sZiB1a7EV/T1oen1G80JbjkfzZ+7EZdJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730847315; c=relaxed/simple;
	bh=B3911xppQLEkN+UpFa9iouTwQPbZMtSslhXeg2GyJ1o=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=p91FDf0U0AHHsnjJBz2CL4DVbeGZveGIffZcnqRMeEy3iqd0WeP53lPa1Ca5Kp67BagcUvgbjQlV05h4ChSfwHSoL9jPwUhfUiTBnScRIYKvZVcdfCsQAxRcGcwGaiYxsHela018oJMrBiJnENDMD/w8TwoWG1wjGjR5VEon3cE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s05xbXMs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F717C4CECF;
	Tue,  5 Nov 2024 22:55:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730847315;
	bh=B3911xppQLEkN+UpFa9iouTwQPbZMtSslhXeg2GyJ1o=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=s05xbXMsag4xSuTIXZqEdmX7KkQYcQm/OY7UXfFT/7Oi6ghPeHwrGk6e648RJuDbP
	 Oh5h47q6VJTRMhnHlyXHYHs51Ac3A5QrBCXPiF7xLSSs2KlCdZOJpTCKHvhfUwBUfY
	 gR3CYyR7qC5V6aGRoilewK7Dwhx67XU/iSUeMaw8lSNiRXLMZpEYGhBCO8NxVpLaLu
	 DP9VlPOsLBLhHcE3nEeSl41qTXBlcwR4NMnOQ53SI1lJiyD3gbz2pewx/0kKbDKWLd
	 KI93Hpqa1wyPgeWx3sfjTc8D8UYk99sgL1aBKMUKs0Q4T98RXdWzVSrHbGE//JumRz
	 Tjm7uz2Hm1XzQ==
Message-ID: <714a3ab2918ac90aca06de13712a5d66a89acbc1.camel@kernel.org>
Subject: Re: [PATCH v3 0/2] nfsd: allow the use of multiple backchannel slots
From: Jeff Layton <jlayton@kernel.org>
To: Olga Kornievskaia <aglo@umich.edu>
Cc: cel@kernel.org, Neil Brown <neilb@suse.de>, Dai Ngo
 <Dai.Ngo@oracle.com>,  Tom Talpey <tom@talpey.com>, Chuck Lever
 <chuck.lever@oracle.com>, Olga Kornievskaia <okorniev@redhat.com>, 
 linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 05 Nov 2024 17:55:12 -0500
In-Reply-To: <CAN-5tyHo_3b7gGVnrnkr3J+tAYSUB=70UZyesAE4fEwOTzso4A@mail.gmail.com>
References: <20241030-bcwide-v3-0-c2df49a26c45@kernel.org>
	 <173032010891.47979.16372737966948328031.b4-ty@oracle.com>
	 <CAN-5tyEtZbD8TDMbyxutf_LCT1-aoG_BUF2gjBiMJ0HG9eLMMg@mail.gmail.com>
	 <badb3156aa3778c21b3c76e5ad129eb6f91fb799.camel@kernel.org>
	 <CAN-5tyHo_3b7gGVnrnkr3J+tAYSUB=70UZyesAE4fEwOTzso4A@mail.gmail.com>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-11-05 at 17:40 -0500, Olga Kornievskaia wrote:
> On Tue, Nov 5, 2024 at 5:27=E2=80=AFPM Jeff Layton <jlayton@kernel.org> w=
rote:
> >=20
> > On Tue, 2024-11-05 at 17:08 -0500, Olga Kornievskaia wrote:
> > > Hi Jeff/Chuck,
> > >=20
> > > Hitting the following softlockup when running using nfsd-next code.
> > > testing is same open bunch of file get delegations, do local
> > > conflicting operation. Network trace shows a few cb_recalls occurring
> > > successfully before the soft lockup (I can confirm that more than 1
> > > slot was used. But I also see that the server isn't trying to use the
> > > lowest available slot but instead just bumps the number and uses the
> > > next one. By that I mean, say slot 0 was used and a reply came back
> > > but the next callback would use slot 1 instead of slot 0).
> > >=20
> >=20
> > If the slots are being consumed and not released then that's what you'd
> > see. The question is why those slots aren't being released.
> >=20
> > Did the client return a SEQUENCE error on some of those callbacks? It
> > looks like the slot doesn't always get released if that occurs, so that
> > might be one possibility.
>=20
> No sequence errors. CB_SEQUENCE and CB_RECALL replies are all successful.
>=20

Nevermind. I think I see the problem. I think I've got the
rpc_sleep_on() handling all wrong here. I'll have to respin this patch.
Chuck, mind dropping this one for now?

Thanks,
Jeff

> > > [  344.045843] watchdog: BUG: soft lockup - CPU#0 stuck for 26s!
> > > [kworker/u24:28:205]
> > > [  344.047669] Modules linked in: rpcrdma rdma_cm iw_cm ib_cm ib_core
> > > nfsd auth_rpcgss nfs_acl lockd grace uinput isofs snd_seq_dummy
> > > snd_hrtimer vsock_loopback vmw_vsock_virtio_transport_common qrtr
> > > rfkill vmw_vsock_vmci_transport vsock sunrpc vfat fat uvcvideo
> > > snd_hda_codec_generic snd_hda_intel videobuf2_vmalloc snd_intel_dspcf=
g
> > > videobuf2_memops uvc snd_hda_codec videobuf2_v4l2 snd_hda_core
> > > snd_hwdep videodev snd_seq snd_seq_device videobuf2_common snd_pcm mc
> > > snd_timer snd vmw_vmci soundcore xfs libcrc32c vmwgfx nvme
> > > drm_ttm_helper ttm crct10dif_ce ghash_ce sha2_ce sha256_arm64
> > > drm_kms_helper nvme_core sha1_ce sr_mod e1000e nvme_auth cdrom drm sg
> > > fuse
> > > [  344.050421] CPU: 0 UID: 0 PID: 205 Comm: kworker/u24:28 Kdump:
> > > loaded Not tainted 6.12.0-rc4+ #42
> > > [  344.050821] Hardware name: VMware, Inc. VMware20,1/VBSA, BIOS
> > > VMW201.00V.21805430.BA64.2305221830 05/22/2023
> > > [  344.051248] Workqueue: rpciod rpc_async_schedule [sunrpc]
> > > [  344.051513] pstate: 11400005 (nzcV daif +PAN -UAO -TCO +DIT -SSBS =
BTYPE=3D--)
> > > [  344.051821] pc : kasan_check_range+0x0/0x188
> > > [  344.052011] lr : __kasan_check_write+0x1c/0x28
> > > [  344.052208] sp : ffff800087027920
> > > [  344.052352] x29: ffff800087027920 x28: 0000000000040000 x27: ffff0=
000a520f170
> > > [  344.052710] x26: 0000000000000000 x25: 1fffe00014a41e2e x24: ffff0=
002841692c0
> > > [  344.053159] x23: ffff0002841692c8 x22: 0000000000000000 x21: 1ffff=
00010e04f2a
> > > [  344.053612] x20: ffff0002841692c0 x19: ffff80008318c2c0 x18: 00000=
00000000000
> > > [  344.054054] x17: 0000006800000000 x16: 1fffe0000010fd60 x15: 0a0d3=
7303736205d
> > > [  344.054501] x14: 3136335b0a0d3630 x13: 1ffff000104751c9 x12: ffff6=
00014a41e2f
> > > [  344.054952] x11: 1fffe00014a41e2e x10: ffff600014a41e2e x9 : dfff8=
00000000000
> > > [  344.055402] x8 : 00009fffeb5be1d2 x7 : ffff0000a520f173 x6 : 00000=
00000000001
> > > [  344.055735] x5 : ffff0000a520f170 x4 : 0000000000000000 x3 : ffff8=
000823129fc
> > > [  344.056058] x2 : 0000000000000001 x1 : 0000000000000002 x0 : ffff0=
000a520f172
> > > [  344.056479] Call trace:
> > > [  344.056636]  kasan_check_range+0x0/0x188
> > > [  344.056886]  queued_spin_lock_slowpath+0x5f4/0xaa0
> > > [  344.057192]  _raw_spin_lock+0x180/0x1a8
> > > [  344.057436]  rpc_sleep_on+0x78/0xe8 [sunrpc]
> > > [  344.057700]  nfsd4_cb_prepare+0x15c/0x468 [nfsd]
> > > [  344.057935]  rpc_prepare_task+0x70/0xa0 [sunrpc]
> > > [  344.058165]  __rpc_execute+0x1e8/0xa48 [sunrpc]
> > > [  344.058388]  rpc_async_schedule+0x90/0x100 [sunrpc]
> > > [  344.058623]  process_one_work+0x598/0x1100
> > > [  344.058818]  worker_thread+0x6c0/0xa58
> > > [  344.058992]  kthread+0x288/0x310
> > > [  344.059145]  ret_from_fork+0x10/0x20
> > > [  344.075846] watchdog: BUG: soft lockup - CPU#1 stuck for 26s!
> > > [kworker/u24:27:204]
> > > [  344.076295] Modules linked in: rpcrdma rdma_cm iw_cm ib_cm ib_core
> > > nfsd auth_rpcgss nfs_acl lockd grace uinput isofs snd_seq_dummy
> > > snd_hrtimer vsock_loopback vmw_vsock_virtio_transport_common qrtr
> > > rfkill vmw_vsock_vmci_transport vsock sunrpc vfat fat uvcvideo
> > > snd_hda_codec_generic snd_hda_intel videobuf2_vmalloc snd_intel_dspcf=
g
> > > videobuf2_memops uvc snd_hda_codec videobuf2_v4l2 snd_hda_core
> > > snd_hwdep videodev snd_seq snd_seq_device videobuf2_common snd_pcm mc
> > > snd_timer snd vmw_vmci soundcore xfs libcrc32c vmwgfx nvme
> > > drm_ttm_helper ttm crct10dif_ce ghash_ce sha2_ce sha256_arm64
> > > drm_kms_helper nvme_core sha1_ce sr_mod e1000e nvme_auth cdrom drm sg
> > > fuse
> > > [  344.079648] CPU: 1 UID: 0 PID: 204 Comm: kworker/u24:27 Kdump:
> > > loaded Tainted: G             L     6.12.0-rc4+ #42
> > > [  344.080290] Tainted: [L]=3DSOFTLOCKUP
> > > [  344.080495] Hardware name: VMware, Inc. VMware20,1/VBSA, BIOS
> > > VMW201.00V.21805430.BA64.2305221830 05/22/2023
> > > [  344.080930] Workqueue: rpciod rpc_async_schedule [sunrpc]
> > > [  344.081212] pstate: 21400005 (nzCv daif +PAN -UAO -TCO +DIT -SSBS =
BTYPE=3D--)
> > > [  344.081630] pc : _raw_spin_lock+0x108/0x1a8
> > > [  344.081815] lr : _raw_spin_lock+0xf4/0x1a8
> > > [  344.081998] sp : ffff800087017a30
> > > [  344.082146] x29: ffff800087017a90 x28: ffff0000a520f170 x27: ffff6=
000148a1081
> > > [  344.082467] x26: 1fffe000148a1081 x25: ffff0000a450840c x24: ffff0=
000a520ed40
> > > [  344.082892] x23: ffff0000a4508404 x22: ffff0002e9028000 x21: ffff8=
00087017a50
> > > [  344.083338] x20: 1ffff00010e02f46 x19: ffff0000a520f170 x18: 00000=
00000000000
> > > [  344.083775] x17: 0000000000000000 x16: 0000000000000000 x15: 0000a=
aab024bdd10
> > > [  344.084217] x14: 0000000000000000 x13: 0000000000000000 x12: ffff7=
00010e02f4b
> > > [  344.084625] x11: 1ffff00010e02f4a x10: ffff700010e02f4a x9 : dfff8=
00000000000
> > > [  344.084945] x8 : 0000000000000004 x7 : 0000000000000003 x6 : 00000=
00000000001
> > > [  344.085264] x5 : ffff800087017a50 x4 : ffff700010e02f4a x3 : ffff8=
00082311154
> > > [  344.085587] x2 : 0000000000000001 x1 : 0000000000000000 x0 : 00000=
00000000000
> > > [  344.085915] Call trace:
> > > [  344.086028]  _raw_spin_lock+0x108/0x1a8
> > > [  344.086210]  rpc_wake_up_queued_task+0x5c/0xf8 [sunrpc]
> > > [  344.086465]  nfsd4_cb_prepare+0x168/0x468 [nfsd]
> > > [  344.086694]  rpc_prepare_task+0x70/0xa0 [sunrpc]
> > > [  344.086922]  __rpc_execute+0x1e8/0xa48 [sunrpc]
> > > [  344.087148]  rpc_async_schedule+0x90/0x100 [sunrpc]
> > > [  344.087389]  process_one_work+0x598/0x1100
> > > [  344.087584]  worker_thread+0x6c0/0xa58
> > > [  344.087758]  kthread+0x288/0x310
> > > [  344.087909]  ret_from_fork+0x10/0x20
> > >=20
> > > On Wed, Oct 30, 2024 at 4:30=E2=80=AFPM <cel@kernel.org> wrote:
> > > >=20
> > > > From: Chuck Lever <chuck.lever@oracle.com>
> > > >=20
> > > > On Wed, 30 Oct 2024 10:48:45 -0400, Jeff Layton wrote:
> > > > > A few more minor updates to the set to fix some small-ish bugs, a=
nd do a
> > > > > bit of cleanup. This seems to test OK for me so far.
> > > > >=20
> > > > >=20
> > > >=20
> > > > Applied to nfsd-next for v6.13, thanks! Still open for comments and
> > > > test results.
> > > >=20
> > > > [1/2] nfsd: make nfsd4_session->se_flags a bool
> > > >       commit: d10f8b7deb4e8a3a0c75855fdad7aae9c1943816
> > > > [2/2] nfsd: allow for up to 32 callback session slots
> > > >       commit: 6c8910ac1cd360ea01136d707158690b5159a1d0
> > > >=20
> > > > --
> > > > Chuck Lever
> > > >=20
> > > >=20
> >=20
> > --
> > Jeff Layton <jlayton@kernel.org>

--=20
Jeff Layton <jlayton@kernel.org>

