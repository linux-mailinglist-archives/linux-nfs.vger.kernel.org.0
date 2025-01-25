Return-Path: <linux-nfs+bounces-9608-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A3C5A1C52F
	for <lists+linux-nfs@lfdr.de>; Sat, 25 Jan 2025 21:44:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D4C31887107
	for <lists+linux-nfs@lfdr.de>; Sat, 25 Jan 2025 20:44:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B7D086329;
	Sat, 25 Jan 2025 20:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d+eUWXYd"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59BFF1862A;
	Sat, 25 Jan 2025 20:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737837866; cv=none; b=ZWWYH4xowJ03ec0pMIW3qtKKEvtv4jTw0iQPdSp6o+4PqmBeJUpLVjUWtV0lOs6R07AHQ857Sd+XLH9uKDu9Xa3IqfRU0Dcsf4jQsJkLmG4jekMlyMoTJrBuPQtfGAAobt5u/P3gh+rPg8QynmkEbhRJDrwZqiGb067YC2XibLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737837866; c=relaxed/simple;
	bh=HSiEmow2ccHTI5lYIZQxboNYPbWION2Y7/qSOWRyTEQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=DrONCKlReF3K4DgjGAeGq6Oevlcormc1b63RlM8snggbT+R149I3RXkdyRNX+Oqeru89eNGBR8fWD3mE8O8DGnstra+YMbopOiRQOkKm22J4bHugEX06hb9c9il8SGJQO5VIPF29HTk9gKdC1k/y5AG9+3nNwIbT8mnat3PMD40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d+eUWXYd; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-aaec111762bso660336866b.2;
        Sat, 25 Jan 2025 12:44:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737837862; x=1738442662; darn=vger.kernel.org;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ict5zfBUa80pQ3rcHdUDnHQXovCFcOsTvF1cjUc5ADg=;
        b=d+eUWXYdhFebs0I39rLujtMGOS+WsbDeLeM3e0/RawHvD2C2CQtA2+D4u9raaObPTH
         J7ZRGJ8juU5wF7dxwS6hZbJqubuXIud6w5o4Mm9ob6lhQKvOYO3vAM37WDVaStxYjMIS
         XbgmzdjvWBvXirtoIFLnRT85AmZZZelXZmhLVam6dmm1550CyIISGlRNQUxVrGpIBrAj
         KTyXwPZragPupP6gMZkZuoCxlyhUt+KvBloLBOnltVfAxiPxPfkR1ZZSJXNH0m7KV68Q
         xLrEFZsxhir0e2Ot0nakeCnqY/0wmQugrA5M2PSLLKym4+Kyl30LAl8oLDPJhiwh0JW8
         dOnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737837862; x=1738442662;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ict5zfBUa80pQ3rcHdUDnHQXovCFcOsTvF1cjUc5ADg=;
        b=tzfLpKm//mjBRuz9T73ahb+MbWOpScg8KeFEZDIbf6fv1FRFKPnU/QCemTOdlaxsGv
         MfwTI9fWKFTUpIHrU8/w84ugmh8rXhDGqlaXd+AjY2OeFzv5YTgjD8yIrG1EcKy0+Olm
         sc6foqbN2SwdAopUR/3KQ4ojOVVX2CzlprvHb7G1d+gT80rylvx72MwDsQHJSSgr8UMM
         A8Dx5D6AErWnfhexSWn2JIHMyWKLfAVLSct+DTevNl+VNC/kH60HZ/CcNmHJ/tfGvPNM
         sh3EVD69mBigHW/++rknGnKNij+olPgf5OL46gQHmMi5kQTHJI+76Dk/S5n5Ic6ucvcL
         HhXg==
X-Forwarded-Encrypted: i=1; AJvYcCXWOI0+glmUx5zao7bDYc6lk7VN5es3qUd2QaEdJhmIGiQwUpK0HBrtsFnhhaZYG+Dt4RtF/nRqB8Xa6Kc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmCZtFUl+sW7wbeibjdBu94ESUcmWJyFhFsvcmMOd6coJaH6fR
	OVdCFka140xb9afwEPGXHgLTvlZdlZpo0/kZiF7lL/OQJnekO8dg
X-Gm-Gg: ASbGncsT0MKpF2i6JZK3D7x84CD+HVX+NEIGpxTVJ5fhK5krqdLpP+CMcavsSskoY1J
	qfHxSg5Fa/bmFu03xM/LQR29fhYVs94JETeIZ4iC+78exa9JXKYNA7XrWA7aO1ok29CL2+8LmnE
	rrumU2ueuSCSWPCzjbMOYxh0Aq4X10GntrEvtHphEpPN7ZWydRmxjiGTeh5v47k3pCx6X1YUYJY
	rCU0X2J4u7Q8ZYQoJXYk3q9LSt+Z1JIzA/nlDUlLO3Tc7q3Ch2xvBTGZoLgzGiQKlIy4qsHxVMg
	ZK9vX+7hUca4RnKTdYkINeBJGulhm6ZS4DpmUg==
X-Google-Smtp-Source: AGHT+IGmvea2Rg4z5l2gHzvAdQFRX3lMdjGT4QUIQdpO/RumzQNpBeS/sFRtxo5DaW57atQMZZ9Qsg==
X-Received: by 2002:a17:906:dc8f:b0:ab3:85e1:f11a with SMTP id a640c23a62f3a-ab38b10af27mr3496163666b.13.1737837862262;
        Sat, 25 Jan 2025 12:44:22 -0800 (PST)
Received: from eldamar.lan (c-82-192-244-13.customer.ggaweb.ch. [82.192.244.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab675e121b8sm343167166b.30.2025.01.25.12.44.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jan 2025 12:44:21 -0800 (PST)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Received: by eldamar.lan (Postfix, from userid 1000)
	id 0F50EBE2EE7; Sat, 25 Jan 2025 21:44:20 +0100 (CET)
Date: Sat, 25 Jan 2025 21:44:20 +0100
From: Salvatore Bonaccorso <carnil@debian.org>
To: Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>,
	Neil Brown <neilb@suse.de>, Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: kernel NULL pointer dereference: Workqueue: events_unbound
 nfsd_file_gc_worker, RIP: 0010:svc_wake_up+0x9/0x20
Message-ID: <Z5VNJJUuCwFrl2Pj@eldamar.lan>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Chuck, Jeff, NFSD maintainers,

In Debian we got a report from a user which triggered an issue during
package updates hwere nfs-kernel-server restart was involved, then
hanging and included a kernel trace of a NULL pointer dereference.

The full report is at:
https://bugs.debian.org/1093734

While I was not able to trigger the issue, the provided log is as
follows:

2025-01-21T12:07:01.516291+01:00 $HOST kernel: device-mapper: core: CONFIG_=
IMA_DISABLE_HTABLE is disabled. Duplicate IMA measurements will not be reco=
rded in the IMA log.
2025-01-21T12:07:01.516310+01:00 $HOST kernel: device-mapper: uevent: versi=
on 1.0.3
2025-01-21T12:07:01.516312+01:00 $HOST kernel: device-mapper: ioctl: 4.48.0=
-ioctl (2023-03-01) initialised: dm-devel@lists.linux.dev
2025-01-21T12:07:13.528044+01:00 $HOST kernel: NFSD: Using nfsdcld client t=
racking operations.
2025-01-21T12:07:13.528061+01:00 $HOST kernel: NFSD: no clients to reclaim,=
 skipping NFSv4 grace period (net f0000000)
2025-01-21T12:07:17.558915+01:00 $HOST blkmapd[1148]: exit on signal(15)
2025-01-21T12:07:17.574410+01:00 $HOST blkmapd[239859]: open pipe file /run=
/rpc_pipefs/nfs/blocklayout failed: No such file or directory
2025-01-21T12:07:18.015541+01:00 $HOST kernel: BUG: kernel NULL pointer der=
eference, address: 0000000000000090
2025-01-21T12:07:18.015563+01:00 $HOST kernel: #PF: supervisor read access =
in kernel mode
2025-01-21T12:07:18.015566+01:00 $HOST kernel: #PF: error_code(0x0000) - no=
t-present page
2025-01-21T12:07:18.015567+01:00 $HOST kernel: PGD 14b3d9067 P4D 14b3d9067 =
PUD 14b3da067 PMD 0=20
2025-01-21T12:07:18.015568+01:00 $HOST kernel: Oops: Oops: 0000 [#1] PREEMP=
T SMP NOPTI
2025-01-21T12:07:18.015569+01:00 $HOST kernel: CPU: 8 UID: 0 PID: 231280 Co=
mm: kworker/u67:2 Tainted: G        W          6.12.9-amd64 #1  Debian 6.12=
=2E9-1
2025-01-21T12:07:18.015570+01:00 $HOST kernel: Tainted: [W]=3DWARN
2025-01-21T12:07:18.015572+01:00 $HOST kernel: Hardware name: Supermicro AS=
 -2014S-TR/H12SSL-i, BIOS 2.9 05/28/2024
2025-01-21T12:07:18.015573+01:00 $HOST kernel: Workqueue: events_unbound nf=
sd_file_gc_worker [nfsd]
2025-01-21T12:07:18.015573+01:00 $HOST kernel: RIP: 0010:svc_wake_up+0x9/0x=
20 [sunrpc]
2025-01-21T12:07:18.015574+01:00 $HOST kernel: Code: e1 bd ea 0f 0b e9 73 f=
f ff ff 0f 1f 80 00 00 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 9=
0 f3 0f 1e fa 0f 1f 44 00 00 <48> 8b bf 90 00 00 00 f0 80 8f b8 00 00 00 01=
 e9 63 aa fe ff 0f 1f
2025-01-21T12:07:18.015575+01:00 $HOST kernel: RSP: 0018:ffffa9b9690abde8 E=
FLAGS: 00010286
2025-01-21T12:07:18.015576+01:00 $HOST kernel: RAX: 0000000000000001 RBX: f=
fff9d03f84f6c58 RCX: ffffa9b9690abe30
2025-01-21T12:07:18.015576+01:00 $HOST kernel: RDX: ffff9d034a5aa2a8 RSI: f=
fff9d034a5aa2a8 RDI: 0000000000000000
2025-01-21T12:07:18.015577+01:00 $HOST kernel: RBP: ffff9d034a5aa2a0 R08: f=
fff9d034a5aa2a8 R09: ffffa9b9690abe28
2025-01-21T12:07:18.015578+01:00 $HOST kernel: R10: ffff9d0451cff780 R11: 0=
00000000000000f R12: ffffa9b9690abe30
2025-01-21T12:07:18.015578+01:00 $HOST kernel: R13: ffff9d034a5aa2a8 R14: f=
fff9d035451a000 R15: ffff9d034a5aa2a8
2025-01-21T12:07:18.015579+01:00 $HOST kernel: FS:  0000000000000000(0000) =
GS:ffff9d228ec00000(0000) knlGS:0000000000000000
2025-01-21T12:07:18.015580+01:00 $HOST kernel: CS:  0010 DS: 0000 ES: 0000 =
CR0: 0000000080050033
2025-01-21T12:07:18.015580+01:00 $HOST kernel: CR2: 0000000000000090 CR3: 0=
000000106e24003 CR4: 0000000000f70ef0
2025-01-21T12:07:18.015581+01:00 $HOST kernel: PKRU: 55555554
2025-01-21T12:07:18.015582+01:00 $HOST kernel: Call Trace:
2025-01-21T12:07:18.015582+01:00 $HOST kernel:  <TASK>
2025-01-21T12:07:18.015583+01:00 $HOST kernel:  ? __die_body.cold+0x19/0x27
2025-01-21T12:07:18.015584+01:00 $HOST kernel:  ? page_fault_oops+0x15a/0x2=
d0
2025-01-21T12:07:18.015585+01:00 $HOST kernel:  ? exc_page_fault+0x7e/0x180
2025-01-21T12:07:18.015585+01:00 $HOST kernel:  ? asm_exc_page_fault+0x26/0=
x30
2025-01-21T12:07:18.015586+01:00 $HOST kernel:  ? svc_wake_up+0x9/0x20 [sun=
rpc]
2025-01-21T12:07:18.015586+01:00 $HOST kernel:  ? srso_alias_return_thunk+0=
x5/0xfbef5
2025-01-21T12:07:18.015587+01:00 $HOST kernel:  nfsd_file_dispose_list_dela=
yed+0xa7/0xd0 [nfsd]
2025-01-21T12:07:18.015588+01:00 $HOST kernel:  nfsd_file_gc_worker+0x190/0=
x2c0 [nfsd]
2025-01-21T12:07:18.015588+01:00 $HOST kernel:  process_one_work+0x177/0x330
2025-01-21T12:07:18.015589+01:00 $HOST kernel:  worker_thread+0x252/0x390
2025-01-21T12:07:18.015590+01:00 $HOST kernel:  ? __pfx_worker_thread+0x10/=
0x10
2025-01-21T12:07:18.015611+01:00 $HOST kernel:  kthread+0xd2/0x100
2025-01-21T12:07:18.015612+01:00 $HOST kernel:  ? __pfx_kthread+0x10/0x10
2025-01-21T12:07:18.015613+01:00 $HOST kernel:  ret_from_fork+0x34/0x50
2025-01-21T12:07:18.015615+01:00 $HOST kernel:  ? __pfx_kthread+0x10/0x10
2025-01-21T12:07:18.015616+01:00 $HOST kernel:  ret_from_fork_asm+0x1a/0x30
2025-01-21T12:07:18.015618+01:00 $HOST kernel:  </TASK>
2025-01-21T12:07:18.015619+01:00 $HOST kernel: Modules linked in: dm_mod tl=
s cpufreq_conservative msr binfmt_misc quota_v2 quota_tree nls_ascii nls_cp=
437 vfat fat ipmi_ssif rpcrdma rdma_ucm ib_iser nf_conntrack_ftp nf_log_sys=
log ib_umad nft_log amd_atl intel_rapl_msr intel_rapl_common rdma_cm ib_ipo=
ib amd64_edac iw_cm libiscsi edac_mce_amd nft_limit scsi_transport_iscsi ib=
_cm kvm_amd nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject kvm cr=
ct10dif_pclmul ghash_clmulni_intel nft_ct ast sha512_ssse3 sha256_ssse3 jc4=
2 drm_shmem_helper sha1_ssse3 aesni_intel gf128mul crypto_simd drm_kms_help=
er cryptd wmi_bmof ee1004 rapl acpi_cpufreq pcspkr i2c_algo_bit ccp acpi_ip=
mi sp5100_tco k10temp watchdog button nft_masq ipmi_si ipmi_devintf ipmi_ms=
ghandler evdev joydev sg nfsd nft_chain_nat nf_nat nf_conntrack nf_defrag_i=
pv6 nf_defrag_ipv4 auth_rpcgss nfs_acl lockd grace nf_tables sunrpc drm con=
figfs efi_pstore nfnetlink ip_tables x_tables autofs4 ext4 crc16 mbcache jb=
d2 efivarfs raid10 raid0 hid_generic usbhid hid raid456 async_raid6_recov a=
sync_memcpy
2025-01-21T12:07:18.015622+01:00 $HOST kernel:  async_pq async_xor async_tx=
 xor rndis_host cdc_ether usbnet mii raid6_pq libcrc32c crc32c_generic mlx5=
_ib ib_uverbs ib_core raid1 md_mod ses enclosure scsi_transport_sas sd_mod =
mlx5_core ahci libahci xhci_pci libata xhci_hcd megaraid_sas tg3 crc32_pclm=
ul scsi_mod crc32c_intel mlxfw usbcore libphy pci_hyperv_intf scsi_common i=
2c_piix4 i2c_smbus usb_common wmi
2025-01-21T12:07:18.015624+01:00 $HOST kernel: CR2: 0000000000000090
2025-01-21T12:07:18.015625+01:00 $HOST kernel: ---[ end trace 0000000000000=
000 ]---

The used kernel version from the user is 6.12.9 based.

Does this ring a bell? Might 8e6e2ffa6569 ("nfsd: add list_head nf_gc
to struct nfsd_file") be related?

Regards,
Salvatore

