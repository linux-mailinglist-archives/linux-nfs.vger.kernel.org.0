Return-Path: <linux-nfs+bounces-3489-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BEB7D8D4C8B
	for <lists+linux-nfs@lfdr.de>; Thu, 30 May 2024 15:24:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32BF51F21DC9
	for <lists+linux-nfs@lfdr.de>; Thu, 30 May 2024 13:24:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 503CD1C2A8;
	Thu, 30 May 2024 13:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LYl2pK/E"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 815AE4D8DC
	for <linux-nfs@vger.kernel.org>; Thu, 30 May 2024 13:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717075460; cv=none; b=hYXOtnMuRi6GiWq/jjYVTMPR3f3dQ8HStUTA/5L4ceT+4zcC9pdnKuBbzaR2qn0RAQgpLxFbiqNETQlzdvqN243pWgfUd86upEpfpA5EZJcPgOwYwexTQ1mUHiYRLkmVQiYLRdhcr/0kCP+B/2nVwq4vbTGOYcW7ImR8xjJIixE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717075460; c=relaxed/simple;
	bh=voq/P7MD5XEk9VZEE0aFQJuFPPTRpMyL6TD4WBoaDyQ=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=o5p9XwXGdXy9uTF4zBO2+JxXsSbw8dA4f2FDU7wGigLslMlyyZag45dUjkr128uFYu7UAIAQ4jAtijPc1BRelHvRUFPRqKl5NlWj6UQ+VjEeUZ6qAH/Ty3Jh9287iQ26FFVpmzfKoM1bJTZjmVhQmG2EBCUNfvenrPb403aj0Iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LYl2pK/E; arc=none smtp.client-ip=209.85.222.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-80ac7d0905eso279110241.0
        for <linux-nfs@vger.kernel.org>; Thu, 30 May 2024 06:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717075457; x=1717680257; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Z1wf86rhc//hrXTmx06EkBUykqafTMVQ7bFCGB2R5oc=;
        b=LYl2pK/E6cn1W2V8DiPud8iCW7VtCQXshjro88tQOpOZNMwvT58Y3hwIC65hyFV6vF
         3YiIPetgUXH5HNcjsisKg6kCDnuW0X6/Lw26LRrVosCcJa3KqFzqUcUQMDu4Wsj2z65f
         5vQ8p32wcuQwTlwBQHtGrCDKRqaKTkB6vDQbGLy5pZLIpqAlAv0nfNfWRnSabe/6iuUm
         cA7S5qnZ410TRbVodDjrWSMC6I6tB90cGpsOvknudEkWIVHXfwlx/cmY2Kt3JRP6ywAa
         xHWfD5Jd/w84F6wkfgnYLpedYjoXKvTRERzJ5gijLy2ZmPdaYJwhJ8vFvflkcW5I0WU4
         d74g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717075457; x=1717680257;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Z1wf86rhc//hrXTmx06EkBUykqafTMVQ7bFCGB2R5oc=;
        b=S/mR/zJLz8/hE+3pt2Q0+ZJlIbOZuAZJt0qBpw6N9uE5s5Tl/PD8uAXRZck0B3KUeE
         gKIYrZv+W6F3EYJ0GdYMszvdib6iKA7zEuUPcDrFdseElBeboOsyIFUF/IOeLydFf/oP
         gwHhlH21up7m9/J8Dtrv5RDl3QW+9H/VAxAj7NkCNerMosrDiNmWGSUUa13bS4Yrf+Gm
         6GXxxnHjLRbP/+beC/3jvRq2I90fXMzJYeoAcHRt8woYq2h0oSOtZvvTgRBKuWK9PwQQ
         BGu/1DFqOisM0OwfuZXwtHxiAuAev4MYXc66py5LKihV5zoIprkxKlfEwti31lbITA3G
         rxOw==
X-Forwarded-Encrypted: i=1; AJvYcCVOqsqPmnhkIlllcYGXoTj2NeKayYAYmhegQ6xawkJGuBS3l9B6AtXXD38sfD2v+CM/4B7Nr8yH5B9UlAT8u2BTTG7uwVWyCkb4
X-Gm-Message-State: AOJu0YzoGIRpTe/3TFx0MK2isLSjY7JHPp99Mbs3LKJvaT5vz8vUB6hO
	PLeVZWXt1lGFet4Oxv6rvvXVWWmdwCwS8FvLWJcEG3tBmtbh36f+4Y7VL0EMcSeyfvCF1fcu+hM
	peL5h+O1ZypgtW7fL7u3M1/3lXQ+vjr2Wh0IiUg==
X-Google-Smtp-Source: AGHT+IGkpezCmFIsSNHIXWWg711MfwaflaRlyGo0iVwc0c38BOJYKlEcuRFsht2/xa2Si8cst7kM/ZupsnWV43DFYAM=
X-Received: by 2002:a05:6122:d0d:b0:4da:a82e:95f5 with SMTP id
 71dfb90a1353d-4eaf21af5b3mr2676650e0c.5.1717075456991; Thu, 30 May 2024
 06:24:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 30 May 2024 18:54:05 +0530
Message-ID: <CA+G9fYuzd9Cz2Ndwc7HFOimJPRZL7w376N=2R2cV-d0mjzT+nw@mail.gmail.com>
Subject: WARNING: at fs/nfs/nfs3xdr.c:188 encode_filename3 on rk3399
To: open list <linux-kernel@vger.kernel.org>, lkft-triage@lists.linaro.org, 
	Linux Regressions <regressions@lists.linux.dev>, linux-nfs@vger.kernel.org
Cc: NeilBrown <neilb@suse.de>, Arnd Bergmann <arnd@arndb.de>, 
	Dan Carpenter <dan.carpenter@linaro.org>, 
	Trond Myklebust <trond.myklebust@hammerspace.com>, Anna Schumaker <anna@kernel.org>, kasong@tencent.com, 
	LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="UTF-8"

The following kernel warning has been noticed while running LTP statvfs01
testcase on arm64 device rk3399-rock-pi-4b with NFS mounted test setup and
started from Linux next-20240522 tag and till next-20240529.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Test log:
-----
mke2fs 1.47.0 (5-Feb-2023)
tst_test.c:1131: TINFO: Mounting /dev/loop0 to /scratch/ltp-9gvw[
5211.161721] EXT4-fs (loop0): mounting ext2 file system using the ext4
subsystem
F2L8n6/LTP_stadLH0F7/mntpoint fstyp=ext2 flags=0
[ 5211.169391] EXT4-fs (loop0): mounted filesystem
af9dfac2-88f6-453d-9d02-c14cc888a51d r/w without journal. Quota mode:
none.
statvfs01.c:32: TPASS: statvfs(TEST_PATH, &buf) passed
[ 5211.175518] ------------[ cut here ]------------
statvfs01.c:44: TPASS: creat(valid_fname, 0444) returned fd 3
[ 5211.175938] WARNING: CPU: 5 PID: 786885 at fs/nfs/nfs3xdr.c:188
encode_filename3+0x4c/0x60
[ 5211.175962] Modules linked in: tun overlay btrfs blake2b_generic
libcrc32c xor xor_neon raid6_pq zstd_compress hantro_vpu
snd_soc_hdmi_codec brcmfmac panfrost v4l2_vp9 snd_soc_simple_card
dw_hdmi_i2s_audio dw_hdmi_cec crct10dif_ce snd_soc_audio_graph_card
snd_soc_spdif_tx brcmutil drm_shmem_helper v4l2_h264
snd_soc_simple_card_utils gpu_sched rockchipdrm hci_uart analogix_dp
btqca v4l2_mem2mem dw_mipi_dsi btbcm videobuf2_dma_contig dw_hdmi cec
phy_rockchip_pcie cfg80211 rtc_rk808 bluetooth videobuf2_memops
snd_soc_rockchip_i2s drm_display_helper drm_dma_helper videobuf2_v4l2
rfkill rockchip_saradc videobuf2_common drm_kms_helper snd_soc_es8316
industrialio_triggered_buffer rockchip_thermal kfifo_buf
coresight_cpu_debug pcie_rockchip_host fuse drm backlight dm_mod
ip_tables x_tables
[ 5211.176075] CPU: 5 PID: 786885 Comm: statvfs01 Not tainted
6.10.0-rc1-next-20240529 #1
[ 5211.176083] Hardware name: Radxa ROCK Pi 4B (DT)
[ 5211.176086] pstate: 20000005 (nzCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[ 5211.176092] pc : encode_filename3+0x4c/0x60
[ 5211.176100] lr : nfs3_xdr_enc_create3args+0x4c/0x108
[ 5211.176109] sp : ffff80008b1ab7a0
[ 5211.176111] x29: ffff80008b1ab7a0 x28: ffff80008b1abc40 x27: 0000000000000001
[ 5211.176120] x26: 0000000000440040 x25: 0000000000000000 x24: ffff800081492c70
[ 5211.176128] x23: 0000000000000100 x22: ffff00000a274010 x21: ffff00002d1b9800
[ 5211.176136] x20: ffff00000a274010 x19: 0000000000000100 x18: 0000000000000000
[ 5211.176143] x17: 0000000000000000 x16: 0000000000000000 x15: 6262626262626262
[ 5211.176150] x14: 6262626262626262 x13: 90d1d5e100000000 x12: 40a645896bf3b486
[ 5211.176158] x11: a16c80bf234c2437 x10: 5702b6d600000000 x9 : ffff80008059040c
[ 5211.176165] x8 : a16c80bf234c2437 x7 : 5702b6d600000000 x6 : 600aa44181070001
[ 5211.176173] x5 : ffff00003109d080 x4 : ffff0000661a4232 x3 : ffff8000805903c0
[ 5211.176180] x2 : 0000000000000100 x1 : ffff00000a274010 x0 : ffff80008b1ab828
[ 5211.176187] Call trace:
[ 5211.176190]  encode_filename3+0x4c/0x60
[ 5211.176198]  nfs3_xdr_enc_create3args+0x4c/0x108
[ 5211.176206]  rpcauth_wrap_req_encode+0x24/0x40
[ 5211.176216]  rpcauth_wrap_req+0x28/0x40
[ 5211.176223]  call_encode+0x130/0x358
[ 5211.176231]  __rpc_execute+0xb4/0x638
[ 5211.176238]  rpc_execute+0x168/0x1e8
[ 5211.176244]  rpc_run_task+0x12c/0x1d8
[ 5211.176251]  rpc_call_sync+0x70/0xe0
[ 5211.176257]  nfs3_rpc_wrapper+0x48/0x98
[ 5211.176264]  nfs3_proc_create+0xb8/0x2d0
[ 5211.176272]  nfs_do_create+0x9c/0x1f0
[ 5211.176280]  nfs_atomic_open_v23+0x98/0xd8
[ 5211.176288]  path_openat+0x6d4/0xf50
[ 5211.176296]  do_filp_open+0xa4/0x160
[ 5211.176301]  do_sys_openat2+0xcc/0x108
[ 5211.176310]  __arm64_sys_openat+0x6c/0xc0
[ 5211.176317]  invoke_syscall+0x50/0x128
[ 5211.176327]  el0_svc_common.constprop.0+0x48/0xf0
[ 5211.176335]  do_el0_svc+0x24/0x38
[ 5211.176342]  el0_svc+0x3c/0x108
[ 5211.176351]  el0t_64_sync_handler+0x120/0x130
[ 5211.176355]  el0t_64_sync+0x190/0x198
[ 5211.176361] ---[ end trace 0000000000000000 ]---
statvfs01.c:48: TFAIL: creat(toolong_fname, 0444) expected ENAMETOOLONG: EIO (5)
[ 5211.432692] EXT4-fs (loop0): unmounting filesystem
af9dfac2-88f6-453d-9d02-c14cc888a51d.

metadata:
----
  git_describe: next-20240522 and next-20240529
  git_repo: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next
  arch: arm64
  test: LTP syscalls statvfs01

Links:
 - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20240529/testrun/24131502/suite/log-parser-test/test/check-kernel-exception/log
 - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20240529/testrun/24131502/suite/log-parser-test/test/check-kernel-warning-4a4050f2ba224c26acd76ee5aebc8fa78eb1cf8c315c763fd7b55e6a1d6e38b7/history/
 - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20240529/testrun/24131502/suite/log-parser-test/tests/


--
Linaro LKFT
https://lkft.linaro.org

