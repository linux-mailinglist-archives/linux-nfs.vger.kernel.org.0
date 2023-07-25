Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42EC1761CF6
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Jul 2023 17:09:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232986AbjGYPJL (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 25 Jul 2023 11:09:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232359AbjGYPIz (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 25 Jul 2023 11:08:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F05419A2
        for <linux-nfs@vger.kernel.org>; Tue, 25 Jul 2023 08:08:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690297693;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Kt8q8QZziuRWXJKh0z3q2q1mZYTDO/d2/gDNEqkZdz8=;
        b=Q56QmKp8yhlBpmiSVVg2Fn12id5ERyTkOSakyOczfzg+sjJGaDLkOt/Be4T7n1cvb87PhV
        uhusIBFuyf18sLJOWf5VL3+F9kJVQqQkyp5TiZXvbmFP+II1B2sKurhHqdzLroVBeDmd82
        9Ig2PPXz86eQdTsvU2HrwZBbadA1kwc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-302-EWmQt4bINb24psP_a5dLBQ-1; Tue, 25 Jul 2023 11:08:09 -0400
X-MC-Unique: EWmQt4bINb24psP_a5dLBQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 966C1830DB1;
        Tue, 25 Jul 2023 15:08:08 +0000 (UTC)
Received: from aion.redhat.com (unknown [10.22.8.81])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7F764492CAC;
        Tue, 25 Jul 2023 15:08:08 +0000 (UTC)
Received: by aion.redhat.com (Postfix, from userid 1000)
        id 0148762729; Tue, 25 Jul 2023 11:08:07 -0400 (EDT)
From:   Scott Mayhew <smayhew@redhat.com>
To:     trond.myklebust@hammerspace.com, anna@kernel.org
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 0/1] Fix potential oops in nfs_inode_remove_request()
Date:   Tue, 25 Jul 2023 11:08:06 -0400
Message-ID: <20230725150807.8770-1-smayhew@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

IBM reported a panic in nfs_inode_remove_request() while running LTP
(based on the the NFS mounts and the processes in the vmcore I'm pretty
sure it was in the nfslock3t_01 test):

BUG: Kernel NULL pointer dereference on read at 0x00000000
Faulting instruction address: 0xc008000005015600
Oops: Kernel access of bad area, sig: 11 [#1]
LE PAGE_SIZE=64K MMU=Radix SMP NR_CPUS=2048 NUMA pSeries
Modules linked in: loop dummy can_bcm can vcan can_dev veth vsock_loopback vmw_vsock_virtio_transport_common vsock tun tcp_dctcp nft_limit xt_limit xt_multiport xt_LOG nf_log_syslog n_hdlc sch_netem tcp_bbr overlay exfat vfat fat squashfs brd uinput snd_hrtimer snd_seq snd_timer snd_seq_device snd soundcore sctp_diag sctp xt_sctp act_tunnel_key nft_tunnel tunnel6 ip6_udp_tunnel xfrm4_tunnel udp_tunnel tunnel4 ip_tunnel xt_dccp xfrm_ipcomp nft_xfrm ext4 mbcache jbd2 nft_counter nft_compat nf_tables nfnetlink rpcsec_gss_krb5 nfsv4 dns_resolver rpadlpar_io rpaphp xsk_diag rpcrdma rdma_cm iw_cm ib_cm nfsv3 ib_core nfs bonding fscache netfs tls rfkill binfmt_misc pseries_rng nfsd auth_rpcgss nfs_acl lockd grace sunrpc drm drm_panel_orientation_quirks xfs libcrc32c dm_service_time sd_mod t10_pi sg ibmvfc ibmvnic scsi_transport_fc vmx_crypto pseries_wdt dm_multipath dm_mirror dm_region_hash dm_log dm_mod fuse [last unloaded: ltp_fw_load]
CPU: 0 PID: 3878459 Comm: kworker/u128:7 Tainted: G           OE     -------  ---  5.14.0-316.el9.ppc64le #1
Workqueue: nfsiod rpc_async_release [sunrpc]
NIP:  c008000005015600 LR: c008000005015598 CTR: c000000000f6d9d0
REGS: c0000001aecd3840 TRAP: 0300   Tainted: G           OE     -------  ---   (5.14.0-316.el9.ppc64le)
MSR:  800000000280b033 <SF,VEC,VSX,EE,FP,ME,IR,DR,RI,LE>  CR: 24002820  XER: 00000001
CFAR: c0080000050155bc DAR: 0000000000000000 DSISR: 40000000 IRQMASK: 0 
GPR00: c008000005015598 c0000001aecd3ae0 c008000005069000 0000000000000000 
GPR04: 0000000000000001 0000000000000000 0000000000000000 0000000000000005 
GPR08: 0000000000000001 0000000000000000 0000000000000002 c008000005033420 
GPR12: c000000000f6d9d0 c000000002eb0000 c0000000001876a8 c000000150c7e200 
GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000000 
GPR20: 0000000000000000 c000000002c1d238 0000000000000000 c000000002650e40 
GPR24: c00000008a941b74 0000000000000000 c0000006774cafd0 c0000006774cafe0 
GPR28: c008000001ee26f0 c00c000001d49580 c0000006774cae00 c00000016fb2a600 
NIP [c008000005015600] nfs_inode_remove_request+0x1c8/0x240 [nfs]
LR [c008000005015598] nfs_inode_remove_request+0x160/0x240 [nfs]
Call Trace:
[c0000001aecd3ae0] [c008000005015464] nfs_inode_remove_request+0x2c/0x240 [nfs] (unreliable)
[c0000001aecd3b30] [c008000005015d50] nfs_commit_release_pages+0x298/0x410 [nfs]
[c0000001aecd3c00] [c008000005013250] nfs_commit_release+0x38/0x80 [nfs]
[c0000001aecd3c30] [c008000001e53410] rpc_free_task+0x58/0xc0 [sunrpc]
[c0000001aecd3c60] [c008000001e534b8] rpc_async_release+0x40/0x70 [sunrpc]
[c0000001aecd3c90] [c00000000017a0b8] process_one_work+0x298/0x580
[c0000001aecd3d30] [c00000000017aa48] worker_thread+0xa8/0x620
[c0000001aecd3dc0] [c0000000001877c4] kthread+0x124/0x130
[c0000001aecd3e10] [c00000000000cd64] ret_from_kernel_thread+0x5c/0x64
Instruction dump:
e8410018 4800002c 60000000 60000000 e9230008 3949ffff 71290001 7c63509e 
e9230000 75290008 4082ffc8 e8630018 <e9230000> 3929ff38 7d4048a8 314affff 
---[ end trace 2902c6562da6500b ]---

In the vmcore, I can see that the folio->mapping was NULL:

crash> nfs_page.wb_folio c00000016fb2a600
    wb_folio = 0xc00c000001d49580
crash> folio.mapping 0xc00c000001d49580
      mapping = 0x0,

Note that I have *not* been able to reproduce the panic myself, but it
looks to me like once nfs_inode_remove_request() calls
folio_clear_private(), another process can come in and clobber the
folio->mapping, for example:

nfs_file_write
  nfs_clear_invalid_mapping
    nfs_invalidate_mapping
      invalidate_inode_pages2
        invalidate_inode_pages2_range
          invalidate_complete_folio2
            __filemap_remove_folio

or:

drop_pagecache_sb
  invalidate_mapping_pages
    invalidate_mapping_pagevec
      mapping_evict_folio
        remove_mapping
          __remove_mapping
            __filemap_remove_folio

So the nfs_inode should probably be initialized in the beginning of
nfs_inode_remove_request(), which is what it used to do before commit 
0c493b5cf16e.

Scott Mayhew (1):
  NFS: Fix potential oops in nfs_inode_remove_request()

 fs/nfs/write.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

-- 
2.41.0

