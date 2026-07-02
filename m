Return-Path: <linux-nfs+bounces-22948-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 7MeFCm2aRmp/ZwsAu9opvQ
	(envelope-from <linux-nfs+bounces-22948-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 02 Jul 2026 19:05:49 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CABF6FAF8A
	for <lists+linux-nfs@lfdr.de>; Thu, 02 Jul 2026 19:05:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=stwm.de header.s=stwm-20170627 header.b=NT9aQbnn;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22948-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22948-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=stwm.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E738332F26DE
	for <lists+linux-nfs@lfdr.de>; Thu,  2 Jul 2026 16:53:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 037FA1C695;
	Thu,  2 Jul 2026 16:53:45 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from email.studentenwerk.mhn.de (email.studentenwerk.mhn.de [141.84.225.229])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14767246BBA;
	Thu,  2 Jul 2026 16:53:40 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783011224; cv=none; b=HtiwwdLtQRqE8kyz37ALueqAiAAxG652KawegvN1dQJIsLL8ZbOn0vOWIe41IjlSFQRx9SGABpxDs2+NzJf0fzhOXjhEpfdsiooUrm8l5gQSZejSHfBzqZj3yApCN8QzNo0Ixoo1NaUoy3yzw6axnmr1htC6oYodYb5f8h6s1p0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783011224; c=relaxed/simple;
	bh=0IL2Oedj9OnKMJgSKaU2Tf3CENmlz8XISnSdUmrPbEc=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=i/1NJdNYMBL1tfeXtOe2Pdd7iaP60lG4d8BO6qcHE87wKqu27gT73Ja1CbRdLGzA4givq0FV498sN0vfgAel2oi3Dn2n89xCEen/nhRwWkQKXFVoUR6wv6bQE2Olk/Vs9mlHe9FnZUuYSZOwhVDIgJR3NoRZ+S6107P1z7eC4p0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stwm.de; spf=pass smtp.mailfrom=stwm.de; dkim=pass (2048-bit key) header.d=stwm.de header.i=@stwm.de header.b=NT9aQbnn; arc=none smtp.client-ip=141.84.225.229
Received: from mailhub.studentenwerk.mhn.de (mailhub.studentenwerk.mhn.de [127.0.0.1])
	by email.studentenwerk.mhn.de (Postfix) with ESMTPS id 4grjd764D4zRhRJ;
	Thu, 02 Jul 2026 18:53:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stwm.de; s=stwm-20170627;
	t=1783011211;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qIlNLJtnFmcmw0twf/6KR0j6K9wyJ946/zyW1rg+aK8=;
	b=NT9aQbnnYaVtZ29mHqUlkKvsgCkB9A/uYhf/cIYkgP5h3X+MICe17IZFf6SKtQu4YhpZBk
	e/0SBjg4mo3c3bZm+4u9YVCpK4sjYRcWnMvY4H7XfLVNcgAUwz1HtAszN/NjVZNd3SyJBk
	OzNP/7cbKQfOXwSzUVjkFfKAdcl9cqqL3jvMM3NV+VAxIa9lTk1oUuLYOBwiPALj1SAWnI
	hPsY52xyDE4273znZb9h6Bo9y6TJ4J09SmGfMmOd0VMshV3XmZ8BcwBOHNuTqNdt1raMjh
	mK/Bm/1nEzYkyuK3igjtFg1BOpfdFY5j2T4ivHncnjS6sJ0gL7tr5LAM83f9ZA==
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 02 Jul 2026 18:53:31 +0200
From: Wolfgang Walter <linux@stwm.de>
To: Chuck Lever <cel@kernel.org>
Cc: stable@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 patches@lists.linux.dev, Jeff Layton <jlayton@kernel.org>, Alexandr
 Alexandrov <alexandr.alexandrov@oracle.com>, Yang Erkun
 <yangerkun@huawei.com>, linux-nfs@vger.kernel.org
Subject: Re: 6.18.37 has problems with nfs4 (server), 6.18.36 works
In-Reply-To: <20260701234349.354512-1-cel@kernel.org>
References: <6eccafaaaa60651ef091257c3439c46b@stwm.de>
 <20260701234349.354512-1-cel@kernel.org>
Message-ID: <114a396bac4fc5e1aa730ea58d59a78f@stwm.de>
X-Sender: linux@stwm.de
Organization: =?UTF-8?Q?Studierendenwerk_M=C3=BCnchen_Oberbayern?=
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[stwm.de,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[stwm.de:s=stwm-20170627];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-22948-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:cel@kernel.org,m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:jlayton@kernel.org,m:alexandr.alexandrov@oracle.com,m:yangerkun@huawei.com,m:linux-nfs@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[linux@stwm.de,linux-nfs@vger.kernel.org];
	HAS_ORG_HEADER(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[stwm.de:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linux@stwm.de,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8CABF6FAF8A

Hi!

Am 2026-07-02 01:43, schrieb Chuck Lever:
> Hi Wolfgang,
> 
> Thanks for the report, and for narrowing it to 6.18.36 vs 6.18.37.
> 
> You've picked the right commit to suspect: 95f9eb19d5e6 ("Revert
> 'NFSD: Defer sub-object cleanup in export put callbacks'") is the
> *only* change to the NFS server between 6.18.36 and 6.18.37, so an
> A/B test around it is exactly the right experiment. Two things would
> let us pin this down.
> 
> 1. The full kernel log. The trace you sent begins in the middle of a
> register dump, and the task that actually triggered the stall isn't
> in it -- the RCU stall names CPU 13 / PID 8887 (nfsd), and that
> backtrace is above where your paste starts. Could you send the
> complete log from the first "soft lockup" / "rcu ... stall" /
> "hung task" line onward, with all CPU backtraces? The part before
> what you already sent is the piece I need. If the machine wedges
> hard, a serial console or netconsole capture (or pstore/ramoops read
> back after reboot) will get the whole thing.

systemd-journald didn't catch it. But /var/log/messages seems to have 
logged it, hope this is it:

Jul  1 16:27:24 fileserver kernel: [76950.437185] PGD 0 P4D 0
Jul  1 16:27:24 fileserver kernel: [76950.437193] Oops: Oops: 0000 [#1] 
SMP NOPTI
Jul  1 16:27:24 fileserver kernel: [76950.437202] CPU: 2 UID: 0 PID: 
8844 Comm: nfsd Not tainted 6.18.37-debian64.all+1.3 #1 PREEMPT(full)
Jul  1 16:27:24 fileserver kernel: [76950.437215] Hardware name: 
Supermicro X10DRi/X10DRI-T, BIOS 1.1a 10/16/2015
Jul  1 16:27:24 fileserver kernel: [76950.437225] RIP: 
0010:__list_del_entry_valid_or_report+0x8/0x110
Jul  1 16:27:24 fileserver kernel: [76950.437240] Code: 48 89 c1 e8 ea 
18 94 ff 0f 0b 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90 90 90 90 90 
90 90 90 90 90 f3 0f 1e fa 48 83 ec 10 <48> 8b 17 48 8b 4f 08 48 89 fe 
48 85 d2 0f 84 b8 a3 95 ff 48 85 c9
Jul  1 16:27:24 fileserver kernel: [76950.437262] RSP: 
0018:ffffd3aba4433c88 EFLAGS: 00010286
Jul  1 16:27:24 fileserver kernel: [76950.437271] RAX: 0000000000000000 
RBX: 0000000000000000 RCX: ffff8acfa99d4e10
Jul  1 16:27:24 fileserver kernel: [76950.437281] RDX: 0000000000000001 
RSI: 0000000000000001 RDI: 0000000000000000
Jul  1 16:27:24 fileserver kernel: [76950.437290] RBP: ffffffff99659a00 
R08: 0000000000480000 R09: ffff8ae70680f000
Jul  1 16:27:24 fileserver kernel: [76950.437299] R10: 0000000000480000 
R11: 0000000000000002 R12: ffffd3aba4433ca8
Jul  1 16:27:24 fileserver kernel: [76950.437308] R13: ffff8acfa99d4e10 
R14: ffff8acfa99d4f68 R15: ffff8ae7072d8000
Jul  1 16:27:24 fileserver kernel: [76950.437318] FS:  
0000000000000000(0000) GS:ffff8ae7065cf000(0000) knlGS:0000000000000000
Jul  1 16:27:24 fileserver kernel: [76950.437328] CS:  0010 DS: 0000 ES: 
0000 CR0: 0000000080050033
Jul  1 16:27:24 fileserver kernel: [76950.437336] CR2: 0000000000000000 
CR3: 00000011a3624002 CR4: 00000000001726f0
Jul  1 16:27:24 fileserver kernel: [76950.437345] Call Trace:
Jul  1 16:27:24 fileserver kernel: [76950.437351]  <TASK>
Jul  1 16:27:24 fileserver kernel: [76950.437358]  
remove_blocked_locks+0x91/0x1d0 [nfsd]
Jul  1 16:27:24 fileserver kernel: [76950.437453]  
__destroy_client+0x1b4/0x2a0 [nfsd]
Jul  1 16:27:24 fileserver kernel: [76950.437500]  
nfsd4_destroy_clientid+0xe6/0x1c0 [nfsd]
Jul  1 16:27:24 fileserver kernel: [76950.437545]  
nfsd4_proc_compound+0x325/0x680 [nfsd]
Jul  1 16:27:24 fileserver kernel: [76950.437594]  
nfsd_dispatch+0xc6/0x210 [nfsd]
Jul  1 16:27:24 fileserver kernel: [76950.437652]  
svc_process_common+0x4c3/0x6a0 [sunrpc]
Jul  1 16:27:24 fileserver kernel: [76950.437772]  ? 
__pfx_nfsd_dispatch+0x10/0x10 [nfsd]
Jul  1 16:27:24 fileserver kernel: [76950.437837]  
svc_process+0x142/0x210 [sunrpc]
Jul  1 16:27:24 fileserver kernel: [76950.437900]  svc_recv+0x7e5/0x9b0 
[sunrpc]
Jul  1 16:27:24 fileserver kernel: [76950.437955]  ? 
__pfx_nfsd+0x10/0x10 [nfsd]
Jul  1 16:27:24 fileserver kernel: [76950.438008]  nfsd+0x8f/0xf0 [nfsd]
Jul  1 16:27:24 fileserver kernel: [76950.438058]  kthread+0xfc/0x230
Jul  1 16:27:24 fileserver kernel: [76950.438068]  ? 
__pfx_kthread+0x10/0x10
Jul  1 16:27:24 fileserver kernel: [76950.438077]  
ret_from_fork+0x231/0x260
Jul  1 16:27:24 fileserver kernel: [76950.438086]  ? 
__pfx_kthread+0x10/0x10
Jul  1 16:27:24 fileserver kernel: [76950.438094]  
ret_from_fork_asm+0x1a/0x30
Jul  1 16:27:24 fileserver kernel: [76950.438104]  </TASK>
Jul  1 16:27:24 fileserver kernel: [76950.438108] Modules linked in: 
rpcsec_gss_krb5 msr 8021q garp stp llc mrp binfmt_misc intel_rapl_msr 
intel_rapl_common sb_edac x86_pkg_temp_thermal intel_powerclamp coretemp 
ipmi_ssif kvm_intel kvm snd_pcm irqbypass polyval_clmulni snd_timer 
ghash_clmulni_intel rapl ast snd intel_cstate drm_client_lib vga16fb 
soundcore drm_shmem_helper intel_uncore drm_kms_helper vgastate pcspkr 
iTCO_wdt mei_me intel_pmc_bxt iTCO_vendor_support i2c_algo_bit mei 
watchdog ioatdma evdev joydev acpi_power_meter ipmi_si acpi_ipmi 
ipmi_devintf ipmi_msghandler button sg nfsd nfs_acl lockd 
chacha20poly1305 fileserverth_rpcgss aesni_intel grace cryptd 
nfs_localio drbd drm sunrpc fuse lru_cache loop efi_pstore configfs 
ip_tables x_tables fileservertofs4 ext4 crc16 mbcache jbd2 efivarfs 
raid10 raid456 async_raid6_recov async_memcpy async_pq async_xor 
async_tx xor raid6_pq raid0 linear dm_mod raid1 hid_generic md_mod ses 
enclosure usbhid hid sd_mod ixgbe libie_fwlog xfrm_algo dca mdio_devres 
of_mdio ahci fixed_phy xhci_pci libahci fwnode_mdio mpt3sas ehci_pci
Jul  1 16:27:24 fileserver kernel: [76950.438181]  libphy raid_class 
xhci_hcd libata ehci_hcd mdio_bus scsi_transport_sas i2c_i801 usbcore 
ptp i2c_smbus lpc_ich scsi_mod pps_core usb_common mdio scsi_common wmi
Jul  1 16:27:24 fileserver kernel: [76950.439549] CR2: 0000000000000000
Jul  1 16:27:24 fileserver kernel: [76950.439820] ---[ end trace 
0000000000000000 ]---


> 
> While you're at it: roughly what was the server doing (client count,
> NFS version, and was an "exportfs -r", mount, or umount in play), and
> does it reproduce or was it a one-off after ~1 day?

NFS 4.2 with sec=krb5p

The kernel of the clients vary, a lot have a 6.18 kernel, but a lot also 
use their distribution kernels.

I would think that at that moment when it crashed about 50 people were 
still using it. Probably quit some people where shuting down der clients 
at that time as it was almost 16:30.

It happened suddenly. Nothing special on the server.

It wasn't a reproduce, it was the first time 6.18.37 was running, I 
upgraded to 6.18.37 the evening before.

We had to hard reset the server after about 1/2 our as neither rebooting 
nor syncing seemed to make progress.

As this did some damage to the filesystem we hat to fsck it which needed 
some time so I decided to downgrade to 6.18.36 again.

> 
> 2. The revert test, if you're willing to spend the rebuild. On a
> v6.18.37 tree:
> 
>     git revert --no-edit 95f9eb19d5e6
> 
> That reverts the revert -- i.e. restores the 6.18.36 behavior for this
> code. If that build stays healthy, it strongly implicates the change;
> if it still locks up, we've ruled it out and should look at the NFSv4
> laundromat/grace-period path instead. One caveat: this also brings
> back a separate problem the revert fixed (a lingering mount reference
> that can make "exportfs -r" followed by umount fail with EBUSY), so
> treat it as a diagnostic build, not something to run long term.
> 

Ok, I think this would be acceptable. Maybe I encountered that in 
6.18.19, I wrote a report that nfsd got stuck when rebooting, but maybe 
it is something different as it seems to have disappeared in the last 
6.18 kernels.

So I will give 3.18.37 with this change reverted a try.

Regards and thanks for your help,
-- 
Wolfgang Walter
Studierendenwerk München Oberbayern
Anstalt des öffentlichen Rechts

