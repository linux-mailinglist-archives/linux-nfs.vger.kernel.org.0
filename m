Return-Path: <linux-nfs+bounces-16974-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F3067CAA8AC
	for <lists+linux-nfs@lfdr.de>; Sat, 06 Dec 2025 15:48:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5A5DA3059964
	for <lists+linux-nfs@lfdr.de>; Sat,  6 Dec 2025 14:48:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8BFA223336;
	Sat,  6 Dec 2025 14:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FIn1Kaov"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 910B979C8
	for <linux-nfs@vger.kernel.org>; Sat,  6 Dec 2025 14:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765032507; cv=none; b=H0NF/t/rXKBsbBAvmEtXKBf4Qqtwp++Yqqp++Lk5MfbhryIt1edUO9q+mvsnmgiDYEDJQ4/gadQdEOBvnXulz5YvopUi2hVdi2g7g949sIghgeIWoe1eJ2Rpy8kHM+gBGMdSA6j7xPF8c06ripeJH8Yo54tFs6pryBQ3Ut9XlLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765032507; c=relaxed/simple;
	bh=5A1QVpOTBNxLxRPQY5MwmuNm9jLldFhQquetG3X0rIw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AfHwq993YjviYxIx9+Eg20Rw31iA4qdCjf7BgW1I2s1aJH+wQKiEg36kERy9UJu3mDef80EjIqDpTwJP5l8z9GopOHh0kZoHFj9tWqAytcyPdg25tTGTs4khSbgG5jQaHtbbl/T39ZcYrErN75t/Yj6yNgyh0craKqQeqHT8nvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FIn1Kaov; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 613FAC4CEF5;
	Sat,  6 Dec 2025 14:48:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765032506;
	bh=5A1QVpOTBNxLxRPQY5MwmuNm9jLldFhQquetG3X0rIw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FIn1KaovnjDeLRHvjW9sa0CUy/8ewwmh2INpHGqbfUU5jI4tjrkGZhlZ0DZ3AL0Nb
	 Kp0EdTVsINZ/3JHObQwWSrS+nv8kIBjDTr1xIw1yO6LAlDrpuKHFAAjKlTGUQi0/aG
	 kl9clWIg4bKglHKSPNybxQR9l7jstp5zPkfxRRcNJRSSdPFG/4PBdaV2xaR+9kIvmg
	 HWn0e3wr7/wVi+UYycCMv6GXnoFUG0MsONf/oJ3tHKzd4br64P0SPEEBT0zXUrB9Zu
	 kLILbksKGtOx+XPVc+qVq75sZ7EF2TwGd87SMq9AP4fijCjr50/i9jOQK7e5HO10tP
	 D4exBOLUI2Emw==
From: Chuck Lever <cel@kernel.org>
To: jlayton@kernel.org,
	Olga Kornievskaia <okorniev@redhat.com>
Cc: Chuck Lever <chuck.lever@oracle.com>,
	linux-nfs@vger.kernel.org,
	neilb@brown.name,
	Dai.Ngo@oracle.com,
	tom@talpey.com
Subject: Re: [PATCH 1/1] nfsd: check that server is running in unlock_filesystem
Date: Sat,  6 Dec 2025 09:48:22 -0500
Message-ID: <176503249208.64607.318563193496080721.b4-ty@oracle.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251205184156.10983-1-okorniev@redhat.com>
References: <20251205184156.10983-1-okorniev@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

On Fri, 05 Dec 2025 13:41:56 -0500, Olga Kornievskaia wrote:
> If we are trying to unlock the filesystem via an administrative
> interface and nfsd isn't running, it crashes the server.
> 
> [   59.445578] Modules linked in: nfsd nfs_acl lockd grace nfs_localio ext4 crc16 mbcache jbd2 overlay uinput snd_seq_dummy snd_hrtimer qrtr rfkill vfat fat uvcvideo snd_hda_codec_generic videobuf2_vmalloc videobuf2_memops uvc videobuf2_v4l2 videobuf2_common snd_hda_intel snd_intel_dspcfg snd_hda_codec videodev snd_hda_core snd_hwdep mc snd_seq snd_seq_device snd_pcm snd_timer snd soundcore sg loop auth_rpcgss vsock_loopback vmw_vsock_virtio_transport_common vmw_vsock_vmci_transport vmw_vmci vsock xfs ghash_ce nvme e1000e nvme_core nvme_keyring nvme_auth hkdf sr_mod cdrom vmwgfx drm_ttm_helper ttm 8021q garp stp llc mrp sunrpc dm_mirror dm_region_hash dm_log iscsi_tcp libiscsi_tcp libiscsi scsi_transport_iscsi fuse dm_multipath dm_mod nfnetlink
> [   59.451979] CPU: 4 UID: 0 PID: 5193 Comm: bash Kdump: loaded Tainted: G    B               6.18.0-rc4+ #74 PREEMPT(voluntary)
> [   59.453311] Tainted: [B]=BAD_PAGE
> [   59.453913] Hardware name: VMware, Inc. VMware20,1/VBSA, BIOS VMW201.00V.24006586.BA64.2406042154 06/04/2024
> [   59.454869] pstate: 61400005 (nZCv daif +PAN -UAO -TCO +DIT -SSBS BTYPE=--)
> [   59.455463] pc : nfsd4_revoke_states+0x1b4/0x898 [nfsd]
> [   59.456069] lr : nfsd4_revoke_states+0x19c/0x898 [nfsd]
> [   59.456701] sp : ffff80008cd67900
> [   59.457115] x29: ffff80008cd679d0 x28: 1fffe00016a53f84 x27: dfff800000000000
> [   59.458006] x26: 04b800ef00000000 x25: 1fffe00016a53f80 x24: ffff0000a796ea00
> [   59.458872] x23: ffff0000b89d6000 x22: ffff0000b6c36900 x21: ffff0000b6c36580
> [   59.459738] x20: ffff80008cd67990 x19: ffff0000b6c365c0 x18: 0000000000000000
> [   59.460602] x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
> [   59.461480] x14: 0000000000000000 x13: 0000000000000001 x12: ffff7000119acf13
> [   59.462272] x11: 1ffff000119acf12 x10: ffff7000119acf12 x9 : dfff800000000000
> [   59.463002] x8 : ffff80008cd67810 x7 : 0000000000000000 x6 : 0097001de0000000
> [   59.463732] x5 : 0000000000000004 x4 : ffff0000b5818000 x3 : 04b800ef00000004
> [   59.464368] x2 : 0000000000000000 x1 : 0000000000000005 x0 : 04b800ef00000000
> [   59.465072] Call trace:
> [   59.465308]  nfsd4_revoke_states+0x1b4/0x898 [nfsd] (P)
> [   59.465830]  write_unlock_fs+0x258/0x440 [nfsd]
> [   59.466278]  nfsctl_transaction_write+0xb0/0x120 [nfsd]
> [   59.466780]  vfs_write+0x1f0/0x938
> [   59.467088]  ksys_write+0xfc/0x1f8
> [   59.467395]  __arm64_sys_write+0x74/0xb8
> [   59.467746]  invoke_syscall.constprop.0+0xdc/0x1e8
> [   59.468177]  do_el0_svc+0x154/0x1d8
> [   59.468489]  el0_svc+0x40/0xe0
> [   59.468767]  el0t_64_sync_handler+0xa0/0xe8
> [   59.469138]  el0t_64_sync+0x1ac/0x1b0
> [   59.469472] Code: 91001343 92400865 d343fc66 110004a1 (38fb68c0)
> [   59.470012] SMP: stopping secondary CPUs
> [   59.472070] Starting crashdump kernel...
> [   59.472537] Bye!
> 
> [...]

Applied to nfsd-testing, thanks!

[1/1] nfsd: check that server is running in unlock_filesystem
      commit: 93a8a71809edddea8212e726abf7b9bf2379bd0c

--
Chuck Lever


