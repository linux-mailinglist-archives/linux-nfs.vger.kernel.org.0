Return-Path: <linux-nfs+bounces-9610-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD1A3A1C58E
	for <lists+linux-nfs@lfdr.de>; Sat, 25 Jan 2025 23:55:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0DBAC7A3732
	for <lists+linux-nfs@lfdr.de>; Sat, 25 Jan 2025 22:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE44B1FE47F;
	Sat, 25 Jan 2025 22:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vRwe2kJ3"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 787721DE4EA;
	Sat, 25 Jan 2025 22:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737845752; cv=none; b=TqGwUi7anMKr2B04jzFkeSV3xieGni+hLkqX5zJAWMZFQNFZ6DcIsXm+qsyGx8h1E2ujnVFt6AJV0wPW6o5ZwhiWf+tNGmNYORyXjg53sJDkEPrabbRkvrV/GPXrR5lk+VbAbksWV4Ha3havekYbzUTeCckafEVrXZjKn9BQJzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737845752; c=relaxed/simple;
	bh=IOlaWMjiz+9Hdm9a1FBmv+xj+eHV1MzMXTbjk35D1kc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pwcAoRlFVheVXxQ1HUDTwutuaxMwseWgPMVN55CcsWB7jn6EfLCMVZ8kqHRC4sB7AQflngiEch1bnMjMG1m/VvP5Byqh6PVx9/OHq8LE5v3Ge9zYNpc5yi6YKmp3BBis136J4Utfh3xBfJqtZC4EOlSKhb3iZxzNvmt/3/6CxS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vRwe2kJ3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B04DC4CED6;
	Sat, 25 Jan 2025 22:55:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737845751;
	bh=IOlaWMjiz+9Hdm9a1FBmv+xj+eHV1MzMXTbjk35D1kc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=vRwe2kJ3jCNKQQMpydMGwv35lgIabmXXxUbxnNs+JM1b9FGn/1BVH+a+r76CQdh9L
	 K7I32+poz7KVzTt/tzoFhgxGqMX/uqEpNMKD3VK+ngMnlq4OyZUWXVTJfqHtXp/Gfu
	 K/Igu33aIZvzd6Uq2aa1n2ALCx11sbS8+Sz7BapuH8Lm3Zz7p5uoORHoxCVACHUfas
	 gCEv4cEPqrqoWf1hKyZzas+fyp3K/8SuQW0MjbynkFsQNQMLfULT3dkRDXpsUfsFUT
	 xIjJ6VyJxfkkYs3eRn+Hh7CLKjX2x3UuHlWoeER1fMMWaXHFNW48iCjsYPYs+EiJK+
	 o87GRU1U4NAcg==
Message-ID: <7d9f2a8aede4f7ca9935a47e1d405643220d7946.camel@kernel.org>
Subject: Re: kernel NULL pointer dereference: Workqueue: events_unbound
 nfsd_file_gc_worker, RIP: 0010:svc_wake_up+0x9/0x20
From: Jeff Layton <jlayton@kernel.org>
To: Salvatore Bonaccorso <carnil@debian.org>, Chuck Lever	
 <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>, Olga Kornievskaia	
 <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey
 <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Sat, 25 Jan 2025 17:55:50 -0500
In-Reply-To: <Z5VNJJUuCwFrl2Pj@eldamar.lan>
References: <Z5VNJJUuCwFrl2Pj@eldamar.lan>
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

On Sat, 2025-01-25 at 21:44 +0100, Salvatore Bonaccorso wrote:
> Hi Chuck, Jeff, NFSD maintainers,
>=20
> In Debian we got a report from a user which triggered an issue during
> package updates hwere nfs-kernel-server restart was involved, then
> hanging and included a kernel trace of a NULL pointer dereference.
>=20
> The full report is at:
> https://bugs.debian.org/1093734
>=20
> While I was not able to trigger the issue, the provided log is as
> follows:
>=20
> 2025-01-21T12:07:01.516291+01:00 $HOST kernel: device-mapper: core: CONFI=
G_IMA_DISABLE_HTABLE is disabled. Duplicate IMA measurements will not be re=
corded in the IMA log.
> 2025-01-21T12:07:01.516310+01:00 $HOST kernel: device-mapper: uevent: ver=
sion 1.0.3
> 2025-01-21T12:07:01.516312+01:00 $HOST kernel: device-mapper: ioctl: 4.48=
.0-ioctl (2023-03-01) initialised: dm-devel@lists.linux.dev
> 2025-01-21T12:07:13.528044+01:00 $HOST kernel: NFSD: Using nfsdcld client=
 tracking operations.
> 2025-01-21T12:07:13.528061+01:00 $HOST kernel: NFSD: no clients to reclai=
m, skipping NFSv4 grace period (net f0000000)
> 2025-01-21T12:07:17.558915+01:00 $HOST blkmapd[1148]: exit on signal(15)
> 2025-01-21T12:07:17.574410+01:00 $HOST blkmapd[239859]: open pipe file /r=
un/rpc_pipefs/nfs/blocklayout failed: No such file or directory
> 2025-01-21T12:07:18.015541+01:00 $HOST kernel: BUG: kernel NULL pointer d=
ereference, address: 0000000000000090

Thanks for the bug report. It's getting late here, so I can only take a
quick look. svc_wake_up is pretty small:

void svc_wake_up(struct svc_serv *serv)
{
        struct svc_pool *pool =3D &serv->sv_pools[0];

        set_bit(SP_TASK_PENDING, &pool->sp_flags);
        svc_pool_wake_idle_thread(pool);
}

pahole on my machine says that struct svc_serv has this at offset 0x90:

	struct svc_pool *          sv_pools;             /*  0x90   0x8 */

So it looks like the nn->nfsd_serv was a NULL pointer. That only
happens when we shut down the server, so this looks like a race between
filecache garbage collection with shutdown.

The filecache gets shut down in nfsd_shutdown_net, which gets called
_after_ setting the nn->nfsd_serv pointer to NULL. We'll have to look
at whether we can reorder the NULL pointer setting to later, or work
around this some other way.

Could I trouble you to open a bug for this at bugzilla.kernel.org?

> 2025-01-21T12:07:18.015563+01:00 $HOST kernel: #PF: supervisor read acces=
s in kernel mode
> 2025-01-21T12:07:18.015566+01:00 $HOST kernel: #PF: error_code(0x0000) - =
not-present page
> 2025-01-21T12:07:18.015567+01:00 $HOST kernel: PGD 14b3d9067 P4D 14b3d906=
7 PUD 14b3da067 PMD 0=20
> 2025-01-21T12:07:18.015568+01:00 $HOST kernel: Oops: Oops: 0000 [#1] PREE=
MPT SMP NOPTI
> 2025-01-21T12:07:18.015569+01:00 $HOST kernel: CPU: 8 UID: 0 PID: 231280 =
Comm: kworker/u67:2 Tainted: G        W          6.12.9-amd64 #1  Debian 6.=
12.9-1
> 2025-01-21T12:07:18.015570+01:00 $HOST kernel: Tainted: [W]=3DWARN
> 2025-01-21T12:07:18.015572+01:00 $HOST kernel: Hardware name: Supermicro =
AS -2014S-TR/H12SSL-i, BIOS 2.9 05/28/2024
> 2025-01-21T12:07:18.015573+01:00 $HOST kernel: Workqueue: events_unbound =
nfsd_file_gc_worker [nfsd]
> 2025-01-21T12:07:18.015573+01:00 $HOST kernel: RIP: 0010:svc_wake_up+0x9/=
0x20 [sunrpc]
> 2025-01-21T12:07:18.015574+01:00 $HOST kernel: Code: e1 bd ea 0f 0b e9 73=
 ff ff ff 0f 1f 80 00 00 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90=
 90 f3 0f 1e fa 0f 1f 44 00 00 <48> 8b bf 90 00 00 00 f0 80 8f b8 00 00 00 =
01 e9 63 aa fe ff 0f 1f
> 2025-01-21T12:07:18.015575+01:00 $HOST kernel: RSP: 0018:ffffa9b9690abde8=
 EFLAGS: 00010286
> 2025-01-21T12:07:18.015576+01:00 $HOST kernel: RAX: 0000000000000001 RBX:=
 ffff9d03f84f6c58 RCX: ffffa9b9690abe30
> 2025-01-21T12:07:18.015576+01:00 $HOST kernel: RDX: ffff9d034a5aa2a8 RSI:=
 ffff9d034a5aa2a8 RDI: 0000000000000000
> 2025-01-21T12:07:18.015577+01:00 $HOST kernel: RBP: ffff9d034a5aa2a0 R08:=
 ffff9d034a5aa2a8 R09: ffffa9b9690abe28
> 2025-01-21T12:07:18.015578+01:00 $HOST kernel: R10: ffff9d0451cff780 R11:=
 000000000000000f R12: ffffa9b9690abe30
> 2025-01-21T12:07:18.015578+01:00 $HOST kernel: R13: ffff9d034a5aa2a8 R14:=
 ffff9d035451a000 R15: ffff9d034a5aa2a8
> 2025-01-21T12:07:18.015579+01:00 $HOST kernel: FS:  0000000000000000(0000=
) GS:ffff9d228ec00000(0000) knlGS:0000000000000000
> 2025-01-21T12:07:18.015580+01:00 $HOST kernel: CS:  0010 DS: 0000 ES: 000=
0 CR0: 0000000080050033
> 2025-01-21T12:07:18.015580+01:00 $HOST kernel: CR2: 0000000000000090 CR3:=
 0000000106e24003 CR4: 0000000000f70ef0
> 2025-01-21T12:07:18.015581+01:00 $HOST kernel: PKRU: 55555554
> 2025-01-21T12:07:18.015582+01:00 $HOST kernel: Call Trace:
> 2025-01-21T12:07:18.015582+01:00 $HOST kernel:  <TASK>
> 2025-01-21T12:07:18.015583+01:00 $HOST kernel:  ? __die_body.cold+0x19/0x=
27
> 2025-01-21T12:07:18.015584+01:00 $HOST kernel:  ? page_fault_oops+0x15a/0=
x2d0
> 2025-01-21T12:07:18.015585+01:00 $HOST kernel:  ? exc_page_fault+0x7e/0x1=
80
> 2025-01-21T12:07:18.015585+01:00 $HOST kernel:  ? asm_exc_page_fault+0x26=
/0x30
> 2025-01-21T12:07:18.015586+01:00 $HOST kernel:  ? svc_wake_up+0x9/0x20 [s=
unrpc]
> 2025-01-21T12:07:18.015586+01:00 $HOST kernel:  ? srso_alias_return_thunk=
+0x5/0xfbef5
> 2025-01-21T12:07:18.015587+01:00 $HOST kernel:  nfsd_file_dispose_list_de=
layed+0xa7/0xd0 [nfsd]
> 2025-01-21T12:07:18.015588+01:00 $HOST kernel:  nfsd_file_gc_worker+0x190=
/0x2c0 [nfsd]
> 2025-01-21T12:07:18.015588+01:00 $HOST kernel:  process_one_work+0x177/0x=
330
> 2025-01-21T12:07:18.015589+01:00 $HOST kernel:  worker_thread+0x252/0x390
> 2025-01-21T12:07:18.015590+01:00 $HOST kernel:  ? __pfx_worker_thread+0x1=
0/0x10
> 2025-01-21T12:07:18.015611+01:00 $HOST kernel:  kthread+0xd2/0x100
> 2025-01-21T12:07:18.015612+01:00 $HOST kernel:  ? __pfx_kthread+0x10/0x10
> 2025-01-21T12:07:18.015613+01:00 $HOST kernel:  ret_from_fork+0x34/0x50
> 2025-01-21T12:07:18.015615+01:00 $HOST kernel:  ? __pfx_kthread+0x10/0x10
> 2025-01-21T12:07:18.015616+01:00 $HOST kernel:  ret_from_fork_asm+0x1a/0x=
30
> 2025-01-21T12:07:18.015618+01:00 $HOST kernel:  </TASK>
> 2025-01-21T12:07:18.015619+01:00 $HOST kernel: Modules linked in: dm_mod =
tls cpufreq_conservative msr binfmt_misc quota_v2 quota_tree nls_ascii nls_=
cp437 vfat fat ipmi_ssif rpcrdma rdma_ucm ib_iser nf_conntrack_ftp nf_log_s=
yslog ib_umad nft_log amd_atl intel_rapl_msr intel_rapl_common rdma_cm ib_i=
poib amd64_edac iw_cm libiscsi edac_mce_amd nft_limit scsi_transport_iscsi =
ib_cm kvm_amd nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject kvm =
crct10dif_pclmul ghash_clmulni_intel nft_ct ast sha512_ssse3 sha256_ssse3 j=
c42 drm_shmem_helper sha1_ssse3 aesni_intel gf128mul crypto_simd drm_kms_he=
lper cryptd wmi_bmof ee1004 rapl acpi_cpufreq pcspkr i2c_algo_bit ccp acpi_=
ipmi sp5100_tco k10temp watchdog button nft_masq ipmi_si ipmi_devintf ipmi_=
msghandler evdev joydev sg nfsd nft_chain_nat nf_nat nf_conntrack nf_defrag=
_ipv6 nf_defrag_ipv4 auth_rpcgss nfs_acl lockd grace nf_tables sunrpc drm c=
onfigfs efi_pstore nfnetlink ip_tables x_tables autofs4 ext4 crc16 mbcache =
jbd2 efivarfs raid10 raid0 hid_generic usbhid hid raid456 async_raid6_recov=
 async_memcpy
> 2025-01-21T12:07:18.015622+01:00 $HOST kernel:  async_pq async_xor async_=
tx xor rndis_host cdc_ether usbnet mii raid6_pq libcrc32c crc32c_generic ml=
x5_ib ib_uverbs ib_core raid1 md_mod ses enclosure scsi_transport_sas sd_mo=
d mlx5_core ahci libahci xhci_pci libata xhci_hcd megaraid_sas tg3 crc32_pc=
lmul scsi_mod crc32c_intel mlxfw usbcore libphy pci_hyperv_intf scsi_common=
 i2c_piix4 i2c_smbus usb_common wmi
> 2025-01-21T12:07:18.015624+01:00 $HOST kernel: CR2: 0000000000000090
> 2025-01-21T12:07:18.015625+01:00 $HOST kernel: ---[ end trace 00000000000=
00000 ]---
>=20
> The used kernel version from the user is 6.12.9 based.
>=20
> Does this ring a bell? Might 8e6e2ffa6569 ("nfsd: add list_head nf_gc
> to struct nfsd_file") be related?
>=20



--=20
Jeff Layton <jlayton@kernel.org>

