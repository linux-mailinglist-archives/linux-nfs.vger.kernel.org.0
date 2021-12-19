Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C60C479EB8
	for <lists+linux-nfs@lfdr.de>; Sun, 19 Dec 2021 02:44:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231693AbhLSBow (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 18 Dec 2021 20:44:52 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:60812 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233942AbhLSBov (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 18 Dec 2021 20:44:51 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 561C260C63
        for <linux-nfs@vger.kernel.org>; Sun, 19 Dec 2021 01:44:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64A7AC36AE5;
        Sun, 19 Dec 2021 01:44:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639878290;
        bh=puqq6gkqJQQwR9QpNHLUq+p4MgUyq0Ts5PtO6DVqyvg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ehdLOSBH/b/V7+He7hcZ6zPZNNnG8CvEAHeTGP9RGphvRX2t56ttTjoHB6DMjv0MB
         ND9QMsWRzvdto+8ujFFggpA0Mf7TjM/m8zc9HRsyorhLUN74vU+OcrjQdEt2K0KBpp
         gG+ciSWLtFIAbFN7q5geWsBckh4dbKggod32xtmnK9tOFq7+l+iVEt8ApaADaWGg1N
         4V/KDHk3ZfWChwHz53TVcWlkFd1Bk2lRGGpX21lQeZS1PAhIsS1nkj22zbrY/BAf2r
         YcVcWAaBvFf9bnNIF7eyUAT/qfN/ylpnimxVAld77obgq9wafrQ85nhdZ8NFImo0NS
         Sj1RsaH+GdUCw==
From:   trondmy@kernel.org
To:     Chuck Lever <chuck.lever@oracle.com>,
        "J. Bruce Fields" <bfields@redhat.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 01/10] nfsd: map EBADF
Date:   Sat, 18 Dec 2021 20:37:54 -0500
Message-Id: <20211219013803.324724-2-trondmy@kernel.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211219013803.324724-1-trondmy@kernel.org>
References: <20211219013803.324724-1-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Peng Tao <tao.peng@primarydata.com>

Now that we have open file cache, it is possible that another client
deletes the file and DP will not know about it. Then IO to MDS would
fail with BADSTATEID and knfsd would start state recovery, which
should fail as well and then nfs read/write will fail with EBADF.
And it triggers a WARN() in nfserrno().

-----------[ cut here ]------------
WARNING: CPU: 0 PID: 13529 at fs/nfsd/nfsproc.c:758 nfserrno+0x58/0x70 [nfsd]()
nfsd: non-standard errno: -9
modules linked in: nfsv3 nfs_layout_flexfiles rpcsec_gss_krb5 nfsv4 dns_resolver nfs fscache ip6t_rpfilter ip6t_REJECT nf_reject_ipv6 xt_connt
pata_acpi floppy
CPU: 0 PID: 13529 Comm: nfsd Tainted: G        W       4.1.5-00307-g6e6579b #7
Hardware name: VMware, Inc. VMware Virtual Platform/440BX Desktop Reference Platform, BIOS 6.00 09/30/2014
 0000000000000000 00000000464e6c9c ffff88079085fba8 ffffffff81789936
 0000000000000000 ffff88079085fc00 ffff88079085fbe8 ffffffff810a08ea
 ffff88079085fbe8 ffff88080f45c900 ffff88080f627d50 ffff880790c46a48
 all Trace:
 [<ffffffff81789936>] dump_stack+0x45/0x57
 [<ffffffff810a08ea>] warn_slowpath_common+0x8a/0xc0
 [<ffffffff810a0975>] warn_slowpath_fmt+0x55/0x70
 [<ffffffff81252908>] ? splice_direct_to_actor+0x148/0x230
 [<ffffffffa02fb8c0>] ? fsid_source+0x60/0x60 [nfsd]
 [<ffffffffa02f9918>] nfserrno+0x58/0x70 [nfsd]
 [<ffffffffa02fba57>] nfsd_finish_read+0x97/0xb0 [nfsd]
 [<ffffffffa02fc7a6>] nfsd_splice_read+0x76/0xa0 [nfsd]
 [<ffffffffa02fcca1>] nfsd_read+0xc1/0xd0 [nfsd]
 [<ffffffffa0233af2>] ? svc_tcp_adjust_wspace+0x12/0x30 [sunrpc]
 [<ffffffffa03073da>] nfsd3_proc_read+0xba/0x150 [nfsd]
 [<ffffffffa02f7a03>] nfsd_dispatch+0xc3/0x210 [nfsd]
 [<ffffffffa0233af2>] ? svc_tcp_adjust_wspace+0x12/0x30 [sunrpc]
 [<ffffffffa0232913>] svc_process_common+0x453/0x6f0 [sunrpc]
 [<ffffffffa0232cc3>] svc_process+0x113/0x1b0 [sunrpc]
 [<ffffffffa02f740f>] nfsd+0xff/0x170 [nfsd]
 [<ffffffffa02f7310>] ? nfsd_destroy+0x80/0x80 [nfsd]
 [<ffffffff810bf3a8>] kthread+0xd8/0xf0
 [<ffffffff810bf2d0>] ? kthread_create_on_node+0x1b0/0x1b0
 [<ffffffff817912a2>] ret_from_fork+0x42/0x70
 [<ffffffff810bf2d0>] ? kthread_create_on_node+0x1b0/0x1b0

Signed-off-by: Peng Tao <tao.peng@primarydata.com>
Signed-off-by: Lance Shelton <lance.shelton@hammerspace.com>
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfsd/nfsproc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/nfsd/nfsproc.c b/fs/nfsd/nfsproc.c
index eea5b59b6a6c..0a2b2795585f 100644
--- a/fs/nfsd/nfsproc.c
+++ b/fs/nfsd/nfsproc.c
@@ -850,6 +850,7 @@ nfserrno (int errno)
 		{ nfserr_io, -EIO },
 		{ nfserr_nxio, -ENXIO },
 		{ nfserr_fbig, -E2BIG },
+		{ nfserr_stale, -EBADF },
 		{ nfserr_acces, -EACCES },
 		{ nfserr_exist, -EEXIST },
 		{ nfserr_xdev, -EXDEV },
-- 
2.33.1

