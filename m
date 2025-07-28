Return-Path: <linux-nfs+bounces-13282-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A8E7B13794
	for <lists+linux-nfs@lfdr.de>; Mon, 28 Jul 2025 11:34:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABF86188778D
	for <lists+linux-nfs@lfdr.de>; Mon, 28 Jul 2025 09:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C84512522B1;
	Mon, 28 Jul 2025 09:34:35 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1052122C35D
	for <linux-nfs@vger.kernel.org>; Mon, 28 Jul 2025 09:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753695275; cv=none; b=m4264fAHpXJYEpr9OZYW+Cktrtk7KJMrSwk8A8WsEf2JQIkyRq0bmSxZ/bH0unKelnWxNG1nilg13DXSKyCA9u8Wvc6rUFpOy/FD+u6iZ0YItkBrVFUHbHI9iCAr9qXqjEA8N0zTEDw06WUgehnmiqMuWi5gWm2dG0f1lpK2K7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753695275; c=relaxed/simple;
	bh=ME2sXheKPwUhgeX8VCgIjKWE2o5IusPoGre5VtpnZ1o=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=NFKgSxeie156QcMXYRsp/8YB8OmHvt/1juE6Otu8KrrKBK2cjWsAM4HTRL1TqD2Yg8CraalJI5WNJPPEJqC9d7WwV77aQ5iAatlRUKhgI6EZTb2bjq3aGF4w818iapW/af433Oqi54KyOdi7v40TzaekmHdsyheTwbZHhF+3Bvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1ugKFO-003hOF-7L;
	Mon, 28 Jul 2025 09:34:19 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neil@brown.name>
To: "Harshvardhan Jha" <harshvardhan.j.jha@oracle.com>
Cc: "Mark Brown" <broonie@kernel.org>, trondmy@kernel.org,
 linux-nfs@vger.kernel.org, Aishwarya.TCV@arm.com, ltp@lists.linux.it,
 "Chuck Lever" <chuck.lever@oracle.com>, "Jeff Layton" <jlayton@kernel.org>,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <Dai.Ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>, "Anna Schumaker" <anna@kernel.org>
Subject: Re: [PATCH 1/2] SUNRPC: Don't allow waiting for exiting tasks
In-reply-to: <b0393ddb-fca7-48b9-832f-ed17ccec1f19@oracle.com>
References: <>, <b0393ddb-fca7-48b9-832f-ed17ccec1f19@oracle.com>
Date: Mon, 28 Jul 2025 19:34:19 +1000
Message-id: <175369525960.2234665.4427615634985880450@noble.neil.brown.name>

On Mon, 28 Jul 2025, Harshvardhan Jha wrote:
> On 27/07/25 10:20 AM, NeilBrown wrote:
> > On Fri, 25 Jul 2025, Harshvardhan Jha wrote:
> >> On 23/07/25 1:37 PM, NeilBrown wrote:
> >>> On Wed, 23 Jul 2025, Harshvardhan Jha wrote:
> >>>> On 08/04/25 4:01 PM, Mark Brown wrote:
> >>>>> On Fri, Mar 28, 2025 at 01:40:44PM -0400, trondmy@kernel.org wrote:
> >>>>>> From: Trond Myklebust <trond.myklebust@hammerspace.com>
> >>>>>>
> >>>>>> Once a task calls exit_signals() it can no longer be signalled. So do
> >>>>>> not allow it to do killable waits.
> >>>>> We're seeing the LTP acct02 test failing in kernels with this patch
> >>>>> applied, testing on systems with NFS root filesystems:
> >>>>>
> >>>>> 10271 05:03:09.064993  tst_test.c:1900: TINFO: LTP version: 20250130-=
1-g60fe84aaf
> >>>>> 10272 05:03:09.076425  tst_test.c:1904: TINFO: Tested kernel: 6.15.0-=
rc1 #1 SMP PREEMPT Sun Apr  6 21:18:14 UTC 2025 aarch64
> >>>>> 10273 05:03:09.076733  tst_kconfig.c:88: TINFO: Parsing kernel config=
 '/proc/config.gz'
> >>>>> 10274 05:03:09.087803  tst_test.c:1722: TINFO: Overall timeout per ru=
n is 0h 01m 30s
> >>>>> 10275 05:03:09.088107  tst_kconfig.c:88: TINFO: Parsing kernel config=
 '/proc/config.gz'
> >>>>> 10276 05:03:09.093097  acct02.c:63: TINFO: CONFIG_BSD_PROCESS_ACCT_V3=
=3Dy
> >>>>> 10277 05:03:09.093400  acct02.c:240: TINFO: Verifying using 'struct a=
cct_v3'
> >>>>> 10278 05:03:10.053504  <6>[   98.043143] Process accounting resumed
> >>>>> 10279 05:03:10.053935  <6>[   98.043143] Process accounting resumed
> >>>>> 10280 05:03:10.064653  acct02.c:193: TINFO: =3D=3D entry 1 =3D=3D
> >>>>> 10281 05:03:10.064953  acct02.c:84: TINFO: ac_comm !=3D 'acct02_helpe=
r' ('acct02')
> >>>>> 10282 05:03:10.076029  acct02.c:133: TINFO: ac_exitcode !=3D 32768 (0)
> >>>>> 10283 05:03:10.076331  acct02.c:141: TINFO: ac_ppid !=3D 2466 (2461)
> >>> It seems that the acct02 process got logged..
> >>> Maybe the vfork attempt (trying to run acct02_helper) got half way an
> >>> aborted.
> >>> It got far enough that accounting got interested.
> >>> It didn't get far enough to update the ppid.
> >>> I'd be surprised if that were even possible....
> >>>
> >>> If you would like to help debug this, changing the
> >>>
> >>> +       if (unlikely(current->flags & PF_EXITING))
> >>>
> >>> to
> >>>
> >>> +       if (unlikely(WARN_ON(current->flags & PF_EXITING)))
> >>>
> >>> would provide stack traces so we can wee where -EINTR is actually being
> >>> returned.  That should provide some hints.
> >>>
> >>> NeilBrown
> >> Hi Neil,
> >>
> >> Upon this addition I got this in the logs
> > Thanks for testing.  Was there anything new in the kernel logs?  I was
> > expecting a WARNING message followed by a "Call Trace".
> >
> > If there wasn't, then this patch cannot have caused the problem.
> > If there was, then I need to see it.
> >
> > Thanks,
> > NeilBrown
>=20
> This is what the dmesg contains:
>=20
> [=C2=A0 678.814887] LTP: starting acct02
> [=C2=A0 679.831232] ------------[ cut here ]------------
> [=C2=A0 679.833500] WARNING: CPU: 6 PID: 88930 at net/sunrpc/sched.c:279
> rpc_wait_bit_killable+0x76/0x90 [sunrpc]
> [=C2=A0 679.837308] Modules linked in: rpcsec_gss_krb5 nfsv4 dns_resolver n=
fs
> netfs rpcrdma rdma_cm iw_cm ib_cm ib_core nfsd auth_rpcgss nfs_acl lockd
> grace loop nft_redir ipt_REJECT xt_comment xt_owner nft_compat
> nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib rfkill nft_reject_inet
> nf_reject_
> ipv4 nf_reject_ipv6 nft_reject nft_ct nft_chain_nat nf_nat nf_conntrack
> nf_defrag_ipv6 nf_defrag_ipv4 ip_set cuse vfat fat intel_rapl_msr
> intel_rapl_common kvm_amd ccp kvm drm_shmem_helper irqbypass i2c_piix4
> drm_kms_helper pcspkr pvpanic_mmio i2c_smbus pvpanic drm fuse xfs
> crc32c_generic
> =C2=A0nvme_tcp nvme_fabrics nvme_core nvme_keyring nvme_auth sd_mod
> virtio_net sg net_failover virtio_scsi failover ata_generic pata_acpi
> ata_piix ghash_clmulni_intel libata sha512_ssse3 virtio_pci sha256_ssse3
> virtio_pci_legacy_dev sha1_ssse3 virtio_pci_modern_dev serio_raw
> dm_multipath btrfs
> =C2=A0blake2b_generic xor zstd_compress raid6_pq sunrpc dm_mirror
> dm_region_hash dm_log dm_mod be2iscsi bnx2i cnic uio cxgb4i cxgb4 tls
> cxgb3i cxgb3 mdio libcxgbi libcxgb
> [=C2=A0 679.837524]=C2=A0 qla4xxx iscsi_tcp libiscsi_tcp libiscsi
> scsi_transport_iscsi iscsi_ibft iscsi_boot_sysfs qemu_fw_cfg aesni_intel
> crypto_simd cryptd [last unloaded: kheaders]
> [=C2=A0 679.873316] CPU: 6 UID: 0 PID: 88930 Comm: acct02_helper Kdump:
> loaded Not tainted 6.15.8-1.el9.rc2.x86_64 #1 PREEMPT(voluntary)
> [=C2=A0 679.877769] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
> BIOS 1.6.4 02/27/2023
> [=C2=A0 679.880782] RIP: 0010:rpc_wait_bit_killable+0x76/0x90 [sunrpc]
> [=C2=A0 679.883189] Code: 01 b8 00 fe ff ff 75 d5 48 8b 85 48 0d 00 00 5b 5d
> 48 c1 e8 08 83 e0 01 f7 d8 19 c0 25 00 fe ff ff 31 d2 31 f6 e9 8a e6 c4
> d4 <0f> 0b b8 fc ff ff ff 5b 5d 31 d2 31 f6 e9 78 e6 c4 d4 0f 1f 84 00
> [=C2=A0 679.889976] RSP: 0018:ffffaf47811a7770 EFLAGS: 00010202
> [=C2=A0 679.892196] RAX: ffff97be48e00330 RBX: ffffaf47811a77c0 RCX:
> 0000000000000000
> [=C2=A0 679.894978] RDX: 0000000000000001 RSI: 0000000000002102 RDI:
> ffffaf47811a77c0
> [=C2=A0 679.897786] RBP: ffff97be61588000 R08: 0000000000000000 R09:
> 0000000000000000
> [=C2=A0 679.900600] R10: 0000000000000000 R11: 0000000000000000 R12:
> 0000000000002102
> [=C2=A0 679.903432] R13: ffffffff96408ea0 R14: ffffaf47811a77d8 R15:
> ffffffffc07568e0
> [=C2=A0 679.906233] FS:=C2=A0 00007fc2563f8600(0000) GS:ffff97c5c890f000(00=
00)
> knlGS:0000000000000000
> [=C2=A0 679.909289] CS:=C2=A0 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [=C2=A0 679.911736] CR2: 00007fc2561fba70 CR3: 00000003bce3a000 CR4:
> 00000000003506f0
> [=C2=A0 679.914555] Call Trace:
> [=C2=A0 679.915918]=C2=A0 <TASK>
> [=C2=A0 679.917215]=C2=A0 __wait_on_bit+0x31/0xa0
> [=C2=A0 679.918932]=C2=A0 out_of_line_wait_on_bit+0x93/0xc0
> [=C2=A0 679.920914]=C2=A0 ? __pfx_wake_bit_function+0x10/0x10
> [=C2=A0 679.922944]=C2=A0 __rpc_execute+0x109/0x310 [sunrpc]
> [=C2=A0 679.925024]=C2=A0 rpc_execute+0x137/0x160 [sunrpc]
> [=C2=A0 679.927020]=C2=A0 rpc_run_task+0x107/0x170 [sunrpc]
> [=C2=A0 679.929032]=C2=A0 nfs4_call_sync_sequence+0x74/0xc0 [nfsv4]
> [=C2=A0 679.931319]=C2=A0 _nfs4_proc_statfs+0xc7/0x100 [nfsv4]
> [=C2=A0 679.933520]=C2=A0 ? srso_return_thunk+0x5/0x5f
> [=C2=A0 679.935391]=C2=A0 nfs4_proc_statfs+0x6b/0xb0 [nfsv4]
> [=C2=A0 679.937367]=C2=A0 nfs_statfs+0x7e/0x1e0 [nfs]
> [=C2=A0 679.939138]=C2=A0 statfs_by_dentry+0x67/0xa0
> [=C2=A0 679.940887]=C2=A0 vfs_statfs+0x1c/0x40
> [=C2=A0 679.942596]=C2=A0 check_free_space+0x71/0x110

Thanks.  I'm not sure why this causes a problem as if vfs_statfs() fail,
check_free_space() assumes there is still free space.
However it does strongly suggest that we still need to NFS to work in
processes where signals have been shutdown.

Could you change rpc_wait_bit_killable() to be the following and retest?
I intention is that when the process is exiting, we wait up to 5 seconds
for each request and then fail.  It's a bit ugly, but it is a rather
strange situation.  It blocking forever that we really want to avoid
here, not blocking at all.

Thanks,
NeilBrown


static int rpc_wait_bit_killable(struct wait_bit_key *key, int mode)
{
	if (unlikely(current->flags & PF_EXITING)) {
		if (schedule_timeout(5*HZ) > 0)
			/* timed out */
			return 0;
		return -EINTR;
	}
	schedule();
	if (signal_pending_state(mode, current))
		return -ERESTARTSYS;
	return 0;
}


> [=C2=A0 679.944433]=C2=A0 acct_write_process+0x45/0x180
> [=C2=A0 679.946313]=C2=A0 acct_process+0xff/0x180
> [=C2=A0 679.948003]=C2=A0 do_exit+0x216/0x480
> [=C2=A0 679.949799]=C2=A0 ? srso_return_thunk+0x5/0x5f
> [=C2=A0 679.951621]=C2=A0 do_group_exit+0x30/0x80
> [=C2=A0 679.953329]=C2=A0 __x64_sys_exit_group+0x18/0x20
> [=C2=A0 679.955217]=C2=A0 x64_sys_call+0xfdb/0x14f0
> [=C2=A0 679.956971]=C2=A0 do_syscall_64+0x82/0x7a0
> [=C2=A0 679.958717]=C2=A0 ? srso_return_thunk+0x5/0x5f
> [=C2=A0 679.960550]=C2=A0 ? ___pte_offset_map+0x1b/0x1a0
> [=C2=A0 679.962434]=C2=A0 ? srso_return_thunk+0x5/0x5f
> [=C2=A0 679.964261]=C2=A0 ? __alloc_frozen_pages_noprof+0x18d/0x340
> [=C2=A0 679.966389]=C2=A0 ? srso_return_thunk+0x5/0x5f
> [=C2=A0 679.968183]=C2=A0 ? srso_return_thunk+0x5/0x5f
> [=C2=A0 679.969945]=C2=A0 ? __mod_memcg_lruvec_state+0xb6/0x1b0
> [=C2=A0 679.971977]=C2=A0 ? srso_return_thunk+0x5/0x5f
> [=C2=A0 679.973690]=C2=A0 ? __lruvec_stat_mod_folio+0x83/0xd0
> [=C2=A0 679.975671]=C2=A0 ? srso_return_thunk+0x5/0x5f
> [=C2=A0 679.977392]=C2=A0 ? srso_return_thunk+0x5/0x5f
> [=C2=A0 679.979079]=C2=A0 ? set_ptes.isra.0+0x36/0x90
> [=C2=A0 679.980771]=C2=A0 ? srso_return_thunk+0x5/0x5f
> [=C2=A0 679.982375]=C2=A0 ? srso_return_thunk+0x5/0x5f
> [=C2=A0 679.984052]=C2=A0 ? wp_page_copy+0x333/0x730
> [=C2=A0 679.985648]=C2=A0 ? srso_return_thunk+0x5/0x5f
> [=C2=A0 679.987220]=C2=A0 ? __handle_mm_fault+0x397/0x6f0
> [=C2=A0 679.988818]=C2=A0 ? srso_return_thunk+0x5/0x5f
> [=C2=A0 679.990411]=C2=A0 ? __count_memcg_events+0xbb/0x150
> [=C2=A0 679.992111]=C2=A0 ? srso_return_thunk+0x5/0x5f
> [=C2=A0 679.993689]=C2=A0 ? count_memcg_events.constprop.0+0x26/0x50
> [=C2=A0 679.995590]=C2=A0 ? srso_return_thunk+0x5/0x5f
> [=C2=A0 679.997177]=C2=A0 ? handle_mm_fault+0x245/0x350
> [=C2=A0 679.998807]=C2=A0 ? srso_return_thunk+0x5/0x5f
> [=C2=A0 680.000339]=C2=A0 ? do_user_addr_fault+0x221/0x690
> [=C2=A0 680.002042]=C2=A0 ? srso_return_thunk+0x5/0x5f
> [=C2=A0 680.003553]=C2=A0 ? arch_exit_to_user_mode_prepare.isra.0+0x1e/0xd0
> [=C2=A0 680.005643]=C2=A0 ? srso_return_thunk+0x5/0x5f
> [=C2=A0 680.007202]=C2=A0 entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [=C2=A0 680.009025] RIP: 0033:0x7fc2560d985d
> [=C2=A0 680.010510] Code: Unable to access opcode bytes at 0x7fc2560d9833.
> [=C2=A0 680.012660] RSP: 002b:00007ffde591df68 EFLAGS: 00000246 ORIG_RAX:
> 00000000000000e7
> [=C2=A0 680.015355] RAX: ffffffffffffffda RBX: 00007fc2561f59e0 RCX:
> 00007fc2560d985d
> [=C2=A0 680.017749] RDX: 00000000000000e7 RSI: ffffffffffffff88 RDI:
> 0000000000000080
> [=C2=A0 680.020292] RBP: 0000000000000080 R08: 0000000000000000 R09:
> 0000000000000020
> [=C2=A0 680.022729] R10: 00007ffde591de10 R11: 0000000000000246 R12:
> 00007fc2561f59e0
> [=C2=A0 680.025174] R13: 00007fc2561faf20 R14: 0000000000000001 R15:
> 00007fc2561faf08
> [=C2=A0 680.027593]=C2=A0 </TASK>
> [=C2=A0 680.028661] ---[ end trace 0000000000000000 ]---
>=20
>=20
> Thanks & Regards,
> Harshvardhan
>=20
> >
> >> <<<test_start>>>
> >> tag=3Dacct02 stime=3D1753444172
> >> cmdline=3D"acct02"
> >> contacts=3D""
> >> analysis=3Dexit
> >> <<<test_output>>>
> >> tst_kconfig.c:88: TINFO: Parsing kernel config
> >> '/lib/modules/6.15.8-1.bug38227970.el9.rc2.x86_64/config'
> >> tst_tmpdir.c:316: TINFO: Using /tmpdir/ltp-w1ozKKlJ6n/LTP_acc4RRfLh as
> >> tmpdir (nfs filesystem)
> >> tst_test.c:2004: TINFO: LTP version: 20250530-105-gda73e1527
> >> tst_test.c:2007: TINFO: Tested kernel:
> >> 6.15.8-1.bug38227970.el9.rc2.x86_64 #1 SMP PREEMPT_DYNAMIC Fri Jul 25
> >> 02:03:04 PDT 2025 x86_64
> >> tst_kconfig.c:88: TINFO: Parsing kernel config
> >> '/lib/modules/6.15.8-1.bug38227970.el9.rc2.x86_64/config'
> >> tst_test.c:1825: TINFO: Overall timeout per run is 0h 00m 30s
> >> tst_kconfig.c:88: TINFO: Parsing kernel config
> >> '/lib/modules/6.15.8-1.bug38227970.el9.rc2.x86_64/config'
> >> acct02.c:61: TINFO: CONFIG_BSD_PROCESS_ACCT_V3=3Dy
> >> acct02.c:238: TINFO: Verifying using 'struct acct_v3'
> >> acct02.c:191: TINFO: =3D=3D entry 1 =3D=3D
> >> acct02.c:82: TINFO: ac_comm !=3D 'acct02_helper' ('acct02')
> >> acct02.c:131: TINFO: ac_exitcode !=3D 32768 (0)
> >> acct02.c:139: TINFO: ac_ppid !=3D 88929 (88928)
> >> acct02.c:181: TFAIL: end of file reached
> >>
> >> HINT: You _MAY_ be missing kernel fixes:
> >>
> >> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commi=
t/?id=3D4d9570158b626
> >>
> >> Summary:
> >> passed=C2=A0 =C2=A00
> >> failed=C2=A0 =C2=A01
> >> broken=C2=A0 =C2=A00
> >> skipped=C2=A0 0
> >> warnings 0
> >> incrementing stop
> >> <<<execution_status>>>
> >> initiation_status=3D"ok"
> >> duration=3D1 termination_type=3Dexited termination_id=3D1 corefile=3Dno
> >> cutime=3D0 cstime=3D20
> >>
> >> <<<test_end>>>
> >>
> >>
> >> Thanks & Regards,
> >>
> >> Harshvardhan
>=20


