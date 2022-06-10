Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B5AE54594C
	for <lists+linux-nfs@lfdr.de>; Fri, 10 Jun 2022 02:46:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234650AbiFJAqh (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 9 Jun 2022 20:46:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229833AbiFJAqg (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 9 Jun 2022 20:46:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4B0A8193C6
        for <linux-nfs@vger.kernel.org>; Thu,  9 Jun 2022 17:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654821994;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=1Stu6eYcCsvNbH1bXoHjmMrsen1z74suT3kc/XAUwyc=;
        b=SOkSvTm0oqUx5KELFgT0srLXZTGDlIF4cNxau0bi9P2oLSgwoHRaILRDq9zEiJML/27luX
        l0RRA5UUWQ2mtuKYijj0d+5irK7MVYuVxEqy/j/oiEvy3hp9VaSwgJEwMWJTbQAgefiYlJ
        INVuyTjfxk2aoqgOBLEhG33tWgIBKA8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-491-d91FCD1SMPSOi3RZLp8o-Q-1; Thu, 09 Jun 2022 20:46:31 -0400
X-MC-Unique: d91FCD1SMPSOi3RZLp8o-Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D769F800124;
        Fri, 10 Jun 2022 00:46:30 +0000 (UTC)
Received: from dwysocha.rdu.csb (unknown [10.22.8.9])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4BA032026D64;
        Fri, 10 Jun 2022 00:46:30 +0000 (UTC)
From:   Dave Wysochanski <dwysocha@redhat.com>
To:     NeilBrown <neilb@suse.de>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH] NFSv4: Add FMODE_CAN_ODIRECT after successful open of a NFS4.x file
Date:   Thu,  9 Jun 2022 20:46:29 -0400
Message-Id: <20220610004629.30264-1-dwysocha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Commit a2ad63daa88b ("VFS: add FMODE_CAN_ODIRECT file flag")
added the FMODE_CAN_ODIRECT flag for NFSv3 but neglected to add
it for NFSv4.x.  This causes direct io on NFSv4.x to fail open
with EINVAL:
  mount -o vers=4.2 127.0.0.1:/export /mnt/nfs4
  dd if=/dev/zero of=/mnt/nfs4/file.bin bs=128k count=1 oflag=direct
  dd: failed to open '/mnt/nfs4/file.bin': Invalid argument
  dd of=/dev/null if=/mnt/nfs4/file.bin bs=128k count=1 iflag=direct
  dd: failed to open '/mnt/dir1/file1.bin': Invalid argument

Fixes: a2ad63daa88b ("VFS: add FMODE_CAN_ODIRECT file flag")
Signed-off-by: Dave Wysochanski <dwysocha@redhat.com>
---
 fs/nfs/dir.c      | 1 +
 fs/nfs/nfs4file.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index a8ecdd527662..0c4e8dd6aa96 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -2124,6 +2124,7 @@ int nfs_atomic_open(struct inode *dir, struct dentry *dentry,
 		}
 		goto out;
 	}
+	file->f_mode |= FMODE_CAN_ODIRECT;
 
 	err = nfs_finish_open(ctx, ctx->dentry, file, open_flags);
 	trace_nfs_atomic_open_exit(dir, ctx, open_flags, err);
diff --git a/fs/nfs/nfs4file.c b/fs/nfs/nfs4file.c
index 03d3a270eff4..e88f6b18445e 100644
--- a/fs/nfs/nfs4file.c
+++ b/fs/nfs/nfs4file.c
@@ -93,6 +93,7 @@ nfs4_file_open(struct inode *inode, struct file *filp)
 	nfs_file_set_open_context(filp, ctx);
 	nfs_fscache_open_file(inode, filp);
 	err = 0;
+	filp->f_mode |= FMODE_CAN_ODIRECT;
 
 out_put_ctx:
 	put_nfs_open_context(ctx);
-- 
2.27.1

