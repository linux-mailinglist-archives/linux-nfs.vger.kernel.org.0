Return-Path: <linux-nfs+bounces-20475-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2GeuL0DQxmkCPAUAu9opvQ
	(envelope-from <linux-nfs+bounces-20475-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Mar 2026 19:45:20 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 383723491CC
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Mar 2026 19:45:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F1333302444B
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Mar 2026 18:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 942494070F4;
	Fri, 27 Mar 2026 18:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stwm.de header.i=@stwm.de header.b="dGJbHjfK"
X-Original-To: linux-nfs@vger.kernel.org
Received: from email.studentenwerk.mhn.de (dresden.studentenwerk.mhn.de [141.84.225.229])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7FD53FBEA1
	for <linux-nfs@vger.kernel.org>; Fri, 27 Mar 2026 18:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.84.225.229
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774637070; cv=none; b=qgCesVmdJC2EyJ7gshi2PRCUoYwtNalNxsFMAgWJk1z1TZocKkhjRBO8lBXfgFa2GK7GKDtZ5Rv8CF/5VzddQzWVUEwCo4dwjb18fSQpOxMbr0HbLFbh2qOWZnGUXOb2Xr32EUdUtIAExPr3JVLVCYvblA0p3dXfJxJzp6ZediI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774637070; c=relaxed/simple;
	bh=nhRONqpYuagmomyCQ4xfcVpx8he8Wi8qzkZO80ZB0ls=;
	h=MIME-Version:Date:From:To:Subject:Message-ID:Content-Type; b=ZVRBaAC7NjMLga1ggDW0NS1mSkDBJAsja/gAVulrmWgcH5deB6iJIv9FO7ue3UWOIMFEHCeQTi/GxbesVOWvX5qg/1sIRFXNvfaZ2H8bvkADhG5N1nRooAQDfs7POPTqS/CJSEZjOeVcphYidPsVxiD0dzUj1FgaKfssaf1RI0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stwm.de; spf=pass smtp.mailfrom=stwm.de; dkim=pass (2048-bit key) header.d=stwm.de header.i=@stwm.de header.b=dGJbHjfK; arc=none smtp.client-ip=141.84.225.229
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stwm.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stwm.de
Received: from mailhub.studentenwerk.mhn.de (mailhub.studentenwerk.mhn.de [127.0.0.1])
	by email.studentenwerk.mhn.de (Postfix) with ESMTPS id 4fj8Wq2lBNzRhRC
	for <linux-nfs@vger.kernel.org>; Fri, 27 Mar 2026 19:37:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stwm.de; s=stwm-20170627;
	t=1774636647;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=QAaWKOCnuMpVrJqoyNAflfQPmYRYzxfta4IdUVNz628=;
	b=dGJbHjfKGQIXmPFsvpx37rHJIUKFzzq+EyaphXC95GsveHlka0gIs5C80Q1NaBxBVVawa5
	wUK8fJtsS1jrpZeCCMaPsEVCujm3SDA5krcAbBzWDstkLNII7Ll72PAi7URwj3LlKadyuS
	cj5mMMXE4EcNh9NVlOUipKilbEEZS8iyY3MwKl+VCN9jwKhK/+cdDrMsc02IAfJC9T6oAM
	MpQOnPvwzX0BTeNBuzL0Ry9eB68kT6bXr1BhEZ0rJm/czh4pRKA2s4QPOxjdGo3otV/0NL
	lYOuRt9BVgyhZcyhGz8jTHfQ5hyeZe1Ib96ye4dcWEqEPuP+xu8J/k08DQkoCg==
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 27 Mar 2026 19:37:27 +0100
From: Wolfgang Walter <linux@stwm.de>
To: linux-nfs@vger.kernel.org
Subject: 6.18.19 (and probably earlier): get BUG nfsd_file (Not tainted):
 Objects remaining on __kmem_cache_shutdown()
Message-ID: <aa45976e7e85e06a426765c5a17865c1@stwm.de>
X-Sender: linux@stwm.de
Organization: =?UTF-8?Q?Studierendenwerk_M=C3=BCnchen_Oberbayern?=
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[stwm.de,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[stwm.de:s=stwm-20170627];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	HAS_ORG_HEADER(0.00)[];
	DKIM_TRACE(0.00)[stwm.de:+];
	RCPT_COUNT_ONE(0.00)[1];
	TAGGED_FROM(0.00)[bounces-20475-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linux@stwm.de,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[stwm.de:dkim,stwm.de:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 383723491CC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello,

wenn rebooting our nfs-server I get almost always the following BUG:

Mar 27 18:27:40 rummelplatz kernel: BUG nfsd_file (Not tainted): Objects 
remaining on __kmem_cache_shutdown()
Mar 27 18:27:40 rummelplatz kernel: 
-----------------------------------------------------------------------------
Mar 27 18:27:40 rummelplatz kernel: Object 0x000000004cc0c6e6 
@offset=144
Mar 27 18:27:40 rummelplatz kernel: Slab 0x00000000e17f7a52 objects=28 
used=1 fp=0x00000000988570d2 
flags=0x57ffffc0000200(workingset|node=1|zone=2|lastcpupid=0x1fffff)
Mar 27 18:27:40 rummelplatz kernel: Disabling lock debugging due to 
kernel taint
Mar 27 18:27:40 rummelplatz kernel: ------------[ cut here ]------------
Mar 27 18:27:40 rummelplatz kernel: WARNING: CPU: 3 PID: 1775323 at 
mm/slub.c:1256 __slab_err+0x19/0x20
Mar 27 18:27:40 rummelplatz kernel: Modules linked in: cpuid 
rpcsec_gss_krb5 msr 8021q garp stp llc mrp binfmt_misc intel_rapl_msr 
intel_rapl_common sb_edac x86_pkg_temp_thermal intel_powerclamp coretemp 
kvm_intel ipmi_ssif kvm snd_pcm irqbypass polyval_clmulni 
ghash_clmulni_intel snd_timer rapl snd intel_cstate ast soundcore 
drm_client_lib intel_uncore drm_shmem_helper vga16fb iTCO_wdt mei_me 
vgastate pcspkr intel_pmc_bxt drm_kms_helper iTCO_vendor_support 
acpi_power_meter mei watchdog ipmi_si i2c_algo_bit acpi_ipmi ioatdma 
ipmi_devintf ipmi_msghandler evdev joydev button sg nfsd nfs_acl 
chacha20poly1305 lockd aesni_intel cryptd auth_rpcgss grace nfs_localio 
drbd drm sunrpc fuse lru_cache loop efi_pstore configfs ip_tables 
x_tables autofs4 ext4 crc16 mbcache jbd2 efivarfs raid10 raid456 
async_raid6_recov async_memcpy async_pq async_xor async_tx xor raid6_pq 
raid0 linear dm_mod raid1 md_mod hid_generic ses enclosure sd_mod usbhid 
hid ixgbe libie_fwlog xfrm_algo dca mdio_devres of_mdio fixed_phy 
xhci_pci ahci fwnode_mdio libahci mpt3sas
Mar 27 18:27:40 rummelplatz kernel:  ehci_pci libphy xhci_hcd raid_class 
libata ehci_hcd mdio_bus scsi_transport_sas usbcore ptp i2c_i801 
i2c_smbus lpc_ich scsi_mod pps_core usb_common mdio scsi_common wmi
Mar 27 18:27:40 rummelplatz kernel: CPU: 3 UID: 0 PID: 1775323 Comm: 
rpc.nfsd Tainted: G    B               6.18.19-debian64.all+1.3 #1 
PREEMPT(full)
Mar 27 18:27:40 rummelplatz kernel: Tainted: [B]=BAD_PAGE
Mar 27 18:27:40 rummelplatz kernel: Hardware name: Supermicro 
X10DRi/X10DRI-T, BIOS 1.1a 10/16/2015
Mar 27 18:27:40 rummelplatz kernel: RIP: 0010:__slab_err+0x19/0x20
Mar 27 18:27:40 rummelplatz kernel: Code: 00 90 90 90 90 90 90 90 90 90 
90 90 90 90 90 90 90 0f 1f 44 00 00 e8 76 ff ff ff be 01 00 00 00 bf 05 
00 00 00 e8 47 e5 0e 00 <0f> 0b c3 cc cc cc cc 90 90 90 90 90 90 90 90 
90 90 90 90 90 90 90
Mar 27 18:27:40 rummelplatz kernel: RSP: 0018:ffffcd1b7ca83cb0 EFLAGS: 
00010082
Mar 27 18:27:40 rummelplatz kernel: RAX: 0000000000000000 RBX: 
ffff89ac480e1fc0 RCX: 0000000000000027
Mar 27 18:27:40 rummelplatz kernel: RDX: 0000000000000005 RSI: 
0000000000000001 RDI: ffff89aa5fadcd80
Mar 27 18:27:40 rummelplatz kernel: RBP: ffff89ac76c35d80 R08: 
0000000000000000 R09: 00000000ffffdfff
Mar 27 18:27:40 rummelplatz kernel: R10: ffffffff853559a0 R11: 
ffffcd1b7ca83b50 R12: fffff85323756ac0
Mar 27 18:27:40 rummelplatz kernel: R13: ffffcd1b7ca83cc8 R14: 
ffff89aad5e5b800 R15: fffff85328203840
Mar 27 18:27:40 rummelplatz kernel: FS:  00007fe216a77740(0000) 
GS:ffff89aada811000(0000) knlGS:0000000000000000
Mar 27 18:27:40 rummelplatz kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 
0000000080050033
Mar 27 18:27:40 rummelplatz kernel: CR2: 00007f6d30aca3d8 CR3: 
00000018eed27002 CR4: 00000000001726f0
Mar 27 18:27:40 rummelplatz kernel: Call Trace:
Mar 27 18:27:40 rummelplatz kernel:  <TASK>
Mar 27 18:27:40 rummelplatz kernel:  
__kmem_cache_shutdown.cold+0xe0/0xe5
Mar 27 18:27:40 rummelplatz kernel:  kmem_cache_destroy+0x55/0x150
Mar 27 18:27:40 rummelplatz kernel:  nfsd_file_cache_shutdown+0x7a/0x180 
[nfsd]
Mar 27 18:27:40 rummelplatz kernel:  nfsd_destroy_serv+0x16c/0x1b0 
[nfsd]
Mar 27 18:27:40 rummelplatz kernel:  nfsd_svc+0x1ee/0x320 [nfsd]
Mar 27 18:27:40 rummelplatz kernel:  write_threads+0xbb/0x180 [nfsd]
Mar 27 18:27:40 rummelplatz kernel:  ? __check_object_size+0x86/0x1f0
Mar 27 18:27:40 rummelplatz kernel:  ? _copy_from_user+0x27/0x60
Mar 27 18:27:40 rummelplatz kernel:  ? simple_transaction_get+0xd8/0x100
Mar 27 18:27:40 rummelplatz kernel:  ? __pfx_write_threads+0x10/0x10 
[nfsd]
Mar 27 18:27:40 rummelplatz kernel:  nfsctl_transaction_write+0x4a/0x80 
[nfsd]
Mar 27 18:27:40 rummelplatz kernel:  vfs_write+0xce/0x440
Mar 27 18:27:40 rummelplatz kernel:  ? do_sys_openat2+0x88/0xc0
Mar 27 18:27:40 rummelplatz kernel:  ksys_write+0x6a/0xe0
Mar 27 18:27:40 rummelplatz kernel:  do_syscall_64+0x63/0x800
Mar 27 18:27:40 rummelplatz kernel:  ? exc_page_fault+0x7e/0x1a0
Mar 27 18:27:40 rummelplatz kernel:  
entry_SYSCALL_64_after_hwframe+0x76/0x7e
Mar 27 18:27:40 rummelplatz kernel: RIP: 0033:0x7fe216b72340
Mar 27 18:27:40 rummelplatz kernel: Code: 40 00 48 8b 15 c1 aa 0d 00 f7 
d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f 00 80 3d a1 32 0e 00 00 74 
17 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 58 c3 0f 1f 80 00 00 00 
00 48 83 ec 28 48 89
Mar 27 18:27:40 rummelplatz kernel: RSP: 002b:00007ffffd5bb0b8 EFLAGS: 
00000202 ORIG_RAX: 0000000000000001
Mar 27 18:27:40 rummelplatz kernel: RAX: ffffffffffffffda RBX: 
0000000000000003 RCX: 00007fe216b72340
Mar 27 18:27:40 rummelplatz kernel: RDX: 0000000000000002 RSI: 
000055c4e1a64300 RDI: 0000000000000003
Mar 27 18:27:40 rummelplatz kernel: RBP: 000055c4e1a64300 R08: 
0000000000000000 R09: 0000000000000064
Mar 27 18:27:40 rummelplatz kernel: R10: 00007ffffd5bae07 R11: 
0000000000000202 R12: 0000000000000007
Mar 27 18:27:40 rummelplatz kernel: R13: 0000000000000007 R14: 
00007ffffd5bb2b8 R15: 000055c4e1a64020
Mar 27 18:27:40 rummelplatz kernel:  </TASK>
Mar 27 18:27:40 rummelplatz kernel: ---[ end trace 0000000000000000 ]---
Mar 27 18:27:40 rummelplatz kernel: ------------[ cut here ]------------
Mar 27 18:27:40 rummelplatz kernel: kmem_cache_destroy nfsd_file: Slab 
cache still has objects when called from 
nfsd_file_cache_shutdown+0x7a/0x180 [nfsd]
Mar 27 18:27:40 rummelplatz kernel: WARNING: CPU: 3 PID: 1775323 at 
mm/slab_common.c:531 kmem_cache_destroy+0x142/0x150
Mar 27 18:27:40 rummelplatz kernel: Modules linked in: cpuid 
rpcsec_gss_krb5 msr 8021q garp stp llc mrp binfmt_misc intel_rapl_msr 
intel_rapl_common sb_edac x86_pkg_temp_thermal intel_powerclamp coretemp 
kvm_intel ipmi_ssif kvm snd_pcm irqbypass polyval_clmulni 
ghash_clmulni_intel snd_timer rapl snd intel_cstate ast soundcore 
drm_client_lib intel_uncore drm_shmem_helper vga16fb iTCO_wdt mei_me 
vgastate pcspkr intel_pmc_bxt drm_kms_helper iTCO_vendor_support 
acpi_power_meter mei watchdog ipmi_si i2c_algo_bit acpi_ipmi ioatdma 
ipmi_devintf ipmi_msghandler evdev joydev button sg nfsd nfs_acl 
chacha20poly1305 lockd aesni_intel cryptd auth_rpcgss grace nfs_localio 
drbd drm sunrpc fuse lru_cache loop efi_pstore configfs ip_tables 
x_tables autofs4 ext4 crc16 mbcache jbd2 efivarfs raid10 raid456 
async_raid6_recov async_memcpy async_pq async_xor async_tx xor raid6_pq 
raid0 linear dm_mod raid1 md_mod hid_generic ses enclosure sd_mod usbhid 
hid ixgbe libie_fwlog xfrm_algo dca mdio_devres of_mdio fixed_phy 
xhci_pci ahci fwnode_mdio libahci mpt3sas
Mar 27 18:27:40 rummelplatz kernel:  ehci_pci libphy xhci_hcd raid_class 
libata ehci_hcd mdio_bus scsi_transport_sas usbcore ptp i2c_i801 
i2c_smbus lpc_ich scsi_mod pps_core usb_common mdio scsi_common wmi
Mar 27 18:27:40 rummelplatz kernel: CPU: 3 UID: 0 PID: 1775323 Comm: 
rpc.nfsd Tainted: G    B   W           6.18.19-debian64.all+1.3 #1 
PREEMPT(full)
Mar 27 18:27:40 rummelplatz kernel: Tainted: [B]=BAD_PAGE, [W]=WARN
Mar 27 18:27:40 rummelplatz kernel: Hardware name: Supermicro 
X10DRi/X10DRI-T, BIOS 1.1a 10/16/2015
Mar 27 18:27:40 rummelplatz kernel: RIP: 
0010:kmem_cache_destroy+0x142/0x150
Mar 27 18:27:40 rummelplatz kernel: Code: 00 85 ed 74 9a eb b1 e8 9c f1 
e1 ff eb 97 48 8b 53 68 48 8b 4c 24 10 48 c7 c6 60 25 04 84 48 c7 c7 78 
d6 4b 84 e8 2e 43 d6 ff <0f> 0b e9 16 ff ff ff c3 cc cc cc cc 66 90 90 
90 90 90 90 90 90 90
Mar 27 18:27:40 rummelplatz kernel: RSP: 0018:ffffcd1b7ca83d18 EFLAGS: 
00010246
Mar 27 18:27:40 rummelplatz kernel: RAX: 0000000000000000 RBX: 
ffff89aad5e5b800 RCX: 0000000000000027
Mar 27 18:27:40 rummelplatz kernel: RDX: ffff89aa5fadcd88 RSI: 
0000000000000001 RDI: ffff89aa5fadcd80
Mar 27 18:27:40 rummelplatz kernel: RBP: 0000000000000001 R08: 
0000000000000000 R09: 00000000ffffdfff
Mar 27 18:27:40 rummelplatz kernel: R10: ffffffff853559a0 R11: 
ffffcd1b7ca83bc0 R12: ffff89aac74fa190
Mar 27 18:27:40 rummelplatz kernel: R13: ffffcd1b7ca83dbc R14: 
0000000000000000 R15: 0000000000000001
Mar 27 18:27:40 rummelplatz kernel: FS:  00007fe216a77740(0000) 
GS:ffff89aada811000(0000) knlGS:0000000000000000
Mar 27 18:27:40 rummelplatz kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 
0000000080050033
Mar 27 18:27:40 rummelplatz kernel: CR2: 00007f6d30aca3d8 CR3: 
00000018eed27002 CR4: 00000000001726f0
Mar 27 18:27:40 rummelplatz kernel: Call Trace:
Mar 27 18:27:40 rummelplatz kernel:  <TASK>
Mar 27 18:27:40 rummelplatz kernel:  nfsd_file_cache_shutdown+0x7a/0x180 
[nfsd]
Mar 27 18:27:40 rummelplatz kernel:  nfsd_destroy_serv+0x16c/0x1b0 
[nfsd]
Mar 27 18:27:40 rummelplatz kernel:  nfsd_svc+0x1ee/0x320 [nfsd]
Mar 27 18:27:40 rummelplatz kernel:  write_threads+0xbb/0x180 [nfsd]
Mar 27 18:27:40 rummelplatz kernel:  ? __check_object_size+0x86/0x1f0
Mar 27 18:27:40 rummelplatz kernel:  ? _copy_from_user+0x27/0x60
Mar 27 18:27:40 rummelplatz kernel:  ? simple_transaction_get+0xd8/0x100
Mar 27 18:27:40 rummelplatz kernel:  ? __pfx_write_threads+0x10/0x10 
[nfsd]
Mar 27 18:27:40 rummelplatz kernel:  nfsctl_transaction_write+0x4a/0x80 
[nfsd]
Mar 27 18:27:40 rummelplatz kernel:  vfs_write+0xce/0x440
Mar 27 18:27:40 rummelplatz kernel:  ? do_sys_openat2+0x88/0xc0
Mar 27 18:27:40 rummelplatz kernel:  ksys_write+0x6a/0xe0
Mar 27 18:27:40 rummelplatz kernel:  do_syscall_64+0x63/0x800
Mar 27 18:27:40 rummelplatz kernel:  ? exc_page_fault+0x7e/0x1a0
Mar 27 18:27:40 rummelplatz kernel:  
entry_SYSCALL_64_after_hwframe+0x76/0x7e
Mar 27 18:27:40 rummelplatz kernel: RIP: 0033:0x7fe216b72340
Mar 27 18:27:40 rummelplatz kernel: Code: 40 00 48 8b 15 c1 aa 0d 00 f7 
d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f 00 80 3d a1 32 0e 00 00 74 
17 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 58 c3 0f 1f 80 00 00 00 
00 48 83 ec 28 48 89
Mar 27 18:27:40 rummelplatz kernel: RSP: 002b:00007ffffd5bb0b8 EFLAGS: 
00000202 ORIG_RAX: 0000000000000001
Mar 27 18:27:40 rummelplatz kernel: RAX: ffffffffffffffda RBX: 
0000000000000003 RCX: 00007fe216b72340
Mar 27 18:27:40 rummelplatz kernel: RDX: 0000000000000002 RSI: 
000055c4e1a64300 RDI: 0000000000000003
Mar 27 18:27:40 rummelplatz kernel: RBP: 000055c4e1a64300 R08: 
0000000000000000 R09: 0000000000000064
Mar 27 18:27:40 rummelplatz kernel: R10: 00007ffffd5bae07 R11: 
0000000000000202 R12: 0000000000000007
Mar 27 18:27:40 rummelplatz kernel: R13: 0000000000000007 R14: 
00007ffffd5bb2b8 R15: 000055c4e1a64020
Mar 27 18:27:40 rummelplatz kernel:  </TASK>
Mar 27 18:27:40 rummelplatz kernel: ---[ end trace 0000000000000000 ]---


The kernel is vanilla stable 6.18.19. I built it myself.

Regrads
-- 
Wolfgang Walter
Studierendenwerk München Oberbayern
Anstalt des öffentlichen Rechts

