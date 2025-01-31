Return-Path: <linux-nfs+bounces-9809-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 95F2CA23F7C
	for <lists+linux-nfs@lfdr.de>; Fri, 31 Jan 2025 16:14:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 181C3168EA4
	for <lists+linux-nfs@lfdr.de>; Fri, 31 Jan 2025 15:14:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF65F1C1F13;
	Fri, 31 Jan 2025 15:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GHMIIsUi"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B0743D66
	for <linux-nfs@vger.kernel.org>; Fri, 31 Jan 2025 15:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738336486; cv=none; b=SZa4ubfjNDFqGtD0n23SWPs++jQ3AP9O2VX94xJjKM7NjgsJ4c2iZbDI/IjuwCprBggN8lN/Z1cVzi40cuWSrHQfz+0vKbCIdBJZnwp4O4DODcnYvOrv9fhmSIymDbtMVh48iMZ6Sf0lPSAzCi+Ey+hwkJ4si7QA1miPsimgv7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738336486; c=relaxed/simple;
	bh=onO5Qn10UPpOTClYNHI9XcBHlW1tq6U38rvNU9KXPIg=;
	h=From:Date:MIME-Version:Content-Type:To:Message-ID:Subject; b=qH0hqawkRLXkgn7iMps1Yfejw8xm6B5mTE9hBTdyJtgCsQCSW4nIqC95akjbVxgCqmj1YSMDRAUJ1kBPCelNx9/wgYehhKMXxbUksB42vbHEu8RRE8+fDtqg5bfbGxAA692krFFwSiyCZGySPoICImJ1guABTkJWPH/DkrKD+as=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GHMIIsUi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1D7FC4CED1;
	Fri, 31 Jan 2025 15:14:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738336484;
	bh=onO5Qn10UPpOTClYNHI9XcBHlW1tq6U38rvNU9KXPIg=;
	h=From:Date:To:Subject:From;
	b=GHMIIsUiYw8xnkAvi838fmaEbO/LsyJnZRrlD2AIbNKDxd8AZfAbhgCNQecWgF93X
	 YEpKWrSTWLj9IR33IQK+qjbb8FRnS+n1HSjDbayZlZau16sYWr65SaOfbm7lBQEMXb
	 bChH0g3ob4qU5ciWQTQUEcWfG67ocXr/t3jWKdYzdMNgjlnB/hQdfFY2/mOr+F/LJg
	 DExDxc0+mmLrJZ83h9XnRVbmxGgSqGBy7ORFQYZOD+ATi3QqbMlrRxbXT7IJT8Ah68
	 yEG2TVhxyAQNJsCtQnQ4EBfP+zuTBU2DZKS5XLqMXsqUeDZgHySrz6nmz0arKDWuso
	 Biz7REUZOyNdQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 790BE380AA7D;
	Fri, 31 Jan 2025 15:15:11 +0000 (UTC)
From: Rin Cat via Bugspray Bot <bugbot@kernel.org>
Date: Fri, 31 Jan 2025 15:15:08 +0000
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: trondmy@kernel.org, linux-nfs@vger.kernel.org, cel@kernel.org, 
 jlayton@kernel.org, anna@kernel.org
Message-ID: <20250131-b217973c0-a2ac608a1bf9@bugzilla.kernel.org>
Subject: CFI failure at nfsd4_encode_operation+0xa2/0x210 [nfsd]
X-Bugzilla-Product: File System
X-Bugzilla-Component: NFSD
X-Mailer: bugspray 0.1-dev

Rin Cat writes via Kernel.org Bugzilla:

When enabled LLVM/clang Control Flow Integrity in the kernel config, nfs caused kernel panic due to violate validation.

Linux: 6.1.55
Clang: 16.0.6


[ 1512.331974] CFI failure at nfsd4_encode_operation+0xa2/0x210 [nfsd] (target: nfs4svc_encode_compoundres+0xb10/0x6f40 [nfsd]; expected type: 0x5d70b2b0)
[ 1512.331991] WARNING: CPU: 6 PID: 16245 at nfsd4_encode_operation+0xa2/0x210 [nfsd]
[ 1512.332000] Modules linked in: macvlan ebtable_filter ebtables ip6table_raw ip6table_mangle ip6table_nat ip6table_filter ip6_tables iptable_raw iptable_mangle iptable_nat iptable_filter ip_tables bpfilter fuse zram wireguard ip6_udp_tunnel udp_tunnel libchacha20poly1305 poly1305_x86_64 chacha_x86_64 curve25519_x86_64 libcurve25519_generic libchacha nfs fscache netfs nfsd auth_rpcgss lockd grace cfg80211 rfkill 8021q mrp garp stp llc sunrpc nft_chain_nat nf_nat nft_ct nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 nf_tables nfnetlink msr tcp_bbr sch_fq nls_iso8859_1 vfat fat amdgpu snd_hda_codec_realtek snd_hda_codec_generic drm_buddy ledtrig_audio video drm_ttm_helper snd_hda_codec_hdmi ttm amd64_edac drm_display_helper edac_mce_amd snd_hda_intel snd_intel_dspcfg drm_kms_helper snd_hda_codec kvm_amd gpu_sched mxm_wmi wmi_bmof snd_hda_core kvm snd_hwdep snd_pcm irqbypass crct10dif_pclmul snd_timer drm snd ghash_clmulni_intel backlight soundcore k10temp pcspkr rapl wmi acpi_cpufreq efiv
 arfs
[ 1512.332048]  dm_crypt dm_mod dax sd_mod igb mlx4_en i2c_algo_bit nvme i2c_core nvme_core dca crc32_pclmul t10_pi ptp mlx4_core xhci_pci crc32c_intel ahci xhci_hcd crc64_rocksoft pps_core libahci crc64
[ 1512.332060] CPU: 6 PID: 16245 Comm: nfsd Tainted: P                   6.1.55-x86_64 #1
[ 1512.332062] Hardware name: System manufacturer System Product Name/PRIME X570-PRO, BIOS 4602 02/23/2023
[ 1512.332063] RIP: 0010:nfsd4_encode_operation+0xa2/0x210 [nfsd]
[ 1512.332071] Code: 01 00 00 8d 48 b4 83 f9 b6 0f 86 81 01 00 00 4c 8b 1c c5 d0 d0 ae c0 48 8d 53 20 4c 89 ef 41 ba 50 4d 8f a2 45 03 53 fc 74 02 <0f> 0b 2e e8 e6 df 34 e4 89 43 04 49 83 7f 28 00 75 10 85 c0 74 1b
[ 1512.332073] RSP: 0018:ffffbe7f067bbdc0 EFLAGS: 00010287
[ 1512.332074] RAX: 0000000000000009 RBX: ffffa2a2e30de480 RCX: 00000000ffffffbd
[ 1512.332076] RDX: ffffa2a2e30de4a0 RSI: 0000000000000000 RDI: ffffa2a2e30dc000
[ 1512.332077] RBP: ffffffffc0aec1d8 R08: 0000000000000000 R09: 0000000000000000
[ 1512.332078] R10: 0000000094d577e1 R11: ffffffffc0ab3640 R12: ffffa2a163100000
[ 1512.332080] R13: ffffa2a2e30dc000 R14: ffffa2a3ea430058 R15: ffffa2a163100230
[ 1512.332081] FS:  0000000000000000(0000) GS:ffffa2afeeb80000(0000) knlGS:0000000000000000
[ 1512.332083] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1512.332084] CR2: 00007efee25ff000 CR3: 0000000323380000 CR4: 0000000000350ee0
[ 1512.332085] Call Trace:
[ 1512.332086]  <TASK>
[ 1512.332087]  ? __warn+0xac/0x160
[ 1512.332090]  ? nfsd4_encode_operation+0xa2/0x210 [nfsd]
[ 1512.332098]  ? report_cfi_failure+0x45/0x70
[ 1512.332100]  ? handle_cfi_failure+0x143/0x1d0
[ 1512.332103]  ? nfs4svc_encode_compoundres+0xb10/0x6f40 [nfsd]
[ 1512.332112]  ? handle_bug+0x4f/0xa0
[ 1512.332114]  ? exc_invalid_op+0x16/0x50
[ 1512.332116]  ? asm_exc_invalid_op+0x16/0x20
[ 1512.332119]  ? nfs4svc_encode_compoundres+0xb10/0x6f40 [nfsd]
[ 1512.332128]  ? nfsd4_encode_operation+0xa2/0x210 [nfsd]
[ 1512.332137]  warn_on_nonidempotent_op+0x417d/0x4370 [nfsd]
[ 1512.332146]  nfsd_dispatch+0x170/0x210 [nfsd]
[ 1512.332155]  svc_process+0x3d4/0x780 [sunrpc]
[ 1512.332165]  ? __cfi_nfsd_dispatch+0x10/0x10 [nfsd]
[ 1512.332173]  svc_process+0xdc/0x780 [sunrpc]
[ 1512.332183]  i_am_nfsd+0x109/0x1d0 [nfsd]
[ 1512.332192]  ? i_am_nfsd+0x40/0x1d0 [nfsd]
[ 1512.332200]  kthread+0x114/0x130
[ 1512.332202]  ? __cfi_kthread+0x10/0x10
[ 1512.332204]  ret_from_fork+0x22/0x30
[ 1512.332207]  </TASK>
[ 1512.332207] ---[ end trace 0000000000000000 ]---

View: https://bugzilla.kernel.org/show_bug.cgi?id=217973#c0
You can reply to this message to join the discussion.
-- 
Deet-doot-dot, I am a bot.
Kernel.org Bugzilla (bugspray 0.1-dev)


