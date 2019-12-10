Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1DB1E119003
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Dec 2019 19:49:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727568AbfLJSt3 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 10 Dec 2019 13:49:29 -0500
Received: from fieldses.org ([173.255.197.46]:57800 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726771AbfLJSt3 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 10 Dec 2019 13:49:29 -0500
Received: by fieldses.org (Postfix, from userid 2815)
        id A33B41C22; Tue, 10 Dec 2019 13:49:28 -0500 (EST)
Date:   Tue, 10 Dec 2019 13:49:28 -0500
From:   Bruce Fields <bfields@fieldses.org>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     Jeff Layton <jlayton@redhat.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: CPU lockup in or near new filecache code
Message-ID: <20191210184928.GA29657@fieldses.org>
References: <9977648B-7D14-42EB-BD4A-CBD041A0C21A@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9977648B-7D14-42EB-BD4A-CBD041A0C21A@oracle.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Dec 10, 2019 at 11:27:15AM -0500, Chuck Lever wrote:
> Under stress, I'm seeing BUGs similar to this quite a bit on my v5.5-rc1 NFS server.
> As near as I can tell, the nfsd thread is looping under nfsd_file_acquire somewhere.

Thanks.  Olga also reported a soft lockup in the new file caching code,
though with a different stack.

--b.

> 
> Dec  9 13:22:52 klimt kernel: watchdog: BUG: soft lockup - CPU#0 stuck for 22s! [nfsd:2002]
> Dec  9 13:22:52 klimt kernel: Modules linked in: rpcsec_gss_krb5 ocfs2_dlmfs ocfs2_stack_o2cb ocfs2_dlm ocfs2_nodemanager ocfs2_stackglue ib_umad ib_ipoib mlx4_ib sb_edac x86_pkg_temp_thermal coretemp kvm_intel kvm irqbypass ext4 crct10dif_pclmul crc32_pclmul ghash_clmulni_intel mbcache jbd2 iTCO_wdt iTCO_vendor_support aesni_intel glue_helper crypto_simd cryptd pcspkr rpcrdma i2c_i801 lpc_ich rdma_ucm mfd_core ib_iser rdma_cm mei_me mei iw_cm raid0 ib_cm libiscsi sg scsi_transport_iscsi ioatdma wmi ipmi_si ipmi_devintf ipmi_msghandler acpi_power_meter nfsd nfs_acl lockd auth_rpcgss grace sunrpc ip_tables xfs libcrc32c mlx4_en sr_mod cdrom sd_mod qedr ast drm_vram_helper drm_ttm_helper ttm drm_kms_helper crc32c_intel syscopyarea sysfillrect sysimgblt fb_sys_fops drm ahci libahci libata igb mlx4_core dca i2c_algo_bit i2c_core nvme nvme_core qede qed dm_mirror dm_region_hash dm_log dm_mod crc8 ib_uverbs dax ib_core
> Dec  9 13:22:52 klimt kernel: CPU: 0 PID: 2002 Comm: nfsd Tainted: G             L    5.5.0-rc1-00002-gc56d8b96a170 #1400
> Dec  9 13:22:52 klimt kernel: Hardware name: Supermicro Super Server/X10SRL-F, BIOS 1.0c 09/09/2015
> Dec  9 13:22:52 klimt kernel: RIP: 0010:put_task_struct+0xc/0x28
> Dec  9 13:22:52 klimt kernel: Code: 05 11 01 00 75 17 48 c7 c7 b1 b4 eb 81 31 c0 c6 05 4f 05 11 01 01 e8 a7 ad fd ff 0f 0b c3 48 8d 57 20 83 c8 ff f0 0f c1 47 20 <83> f8 01 75 05 e9 cf 7e fd ff 85 c0 7f 0d be 03 00 00 00 48 89 d7
> Dec  9 13:22:52 klimt kernel: RSP: 0018:ffffc90000f7bb88 EFLAGS: 00000213 ORIG_RAX: ffffffffffffff13
> Dec  9 13:22:52 klimt kernel: RAX: 0000000000000002 RBX: ffff888844120000 RCX: 0000000000000000
> Dec  9 13:22:52 klimt kernel: RDX: ffff888844120020 RSI: 0000000000000000 RDI: ffff888844120000
> Dec  9 13:22:52 klimt kernel: RBP: 0000000000000001 R08: ffff888817527b00 R09: ffffffff8121d707
> Dec  9 13:22:52 klimt kernel: R10: ffffc90000f7bbc8 R11: 000000008e6571d9 R12: ffff888855055750
> Dec  9 13:22:52 klimt kernel: R13: 0000000000000000 R14: ffff88882dcd9320 R15: ffff88881741a8c0
> Dec  9 13:22:52 klimt kernel: FS:  0000000000000000(0000) GS:ffff88885fc00000(0000) knlGS:0000000000000000
> Dec  9 13:22:52 klimt kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> Dec  9 13:22:52 klimt kernel: CR2: 00007f816a386000 CR3: 0000000855686003 CR4: 00000000001606f0
> Dec  9 13:22:52 klimt kernel: Call Trace:
> Dec  9 13:22:52 klimt kernel: wake_up_q+0x34/0x40
> Dec  9 13:22:52 klimt kernel: __mutex_unlock_slowpath.isra.14+0x9d/0xeb
> Dec  9 13:22:52 klimt kernel: fsnotify_add_mark+0x53/0x5d
> Dec  9 13:22:52 klimt kernel: nfsd_file_acquire+0x423/0x576 [nfsd]
> Dec  9 13:22:52 klimt kernel: nfs4_get_vfs_file+0x14c/0x20f [nfsd]
> Dec  9 13:22:52 klimt kernel: nfsd4_process_open2+0xcd6/0xd98 [nfsd]
> Dec  9 13:22:52 klimt kernel: ? fh_verify+0x42e/0x4ef [nfsd]
> Dec  9 13:22:52 klimt kernel: ? nfsd4_process_open1+0x233/0x29d [nfsd]
> Dec  9 13:22:52 klimt kernel: nfsd4_open+0x500/0x5cb [nfsd]
> Dec  9 13:22:52 klimt kernel: nfsd4_proc_compound+0x32a/0x5c7 [nfsd]
> Dec  9 13:22:52 klimt kernel: nfsd_dispatch+0x102/0x1e2 [nfsd]
> Dec  9 13:22:52 klimt kernel: svc_process_common+0x3b3/0x65d [sunrpc]
> Dec  9 13:22:52 klimt kernel: ? svc_xprt_put+0x12/0x21 [sunrpc]
> Dec  9 13:22:52 klimt kernel: ? nfsd_svc+0x2be/0x2be [nfsd]
> Dec  9 13:22:52 klimt kernel: ? nfsd_destroy+0x51/0x51 [nfsd]
> Dec  9 13:22:52 klimt kernel: svc_process+0xf6/0x115 [sunrpc]
> Dec  9 13:22:52 klimt kernel: nfsd+0xf2/0x149 [nfsd]
> Dec  9 13:22:52 klimt kernel: kthread+0xf6/0xfb
> Dec  9 13:22:52 klimt kernel: ? kthread_queue_delayed_work+0x74/0x74
> Dec  9 13:22:52 klimt kernel: ret_from_fork+0x3a/0x50
> 
> 
> --
> Chuck Lever
> 
> 
