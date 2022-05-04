Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 601A051A0CF
	for <lists+linux-nfs@lfdr.de>; Wed,  4 May 2022 15:22:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350654AbiEDN0G (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 4 May 2022 09:26:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350646AbiEDNZh (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 4 May 2022 09:25:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BF1C944769
        for <linux-nfs@vger.kernel.org>; Wed,  4 May 2022 06:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651670472;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Qe4yVAvzQpTnaqUWjZUA3f+aoL1YlAlWs24T4YHjd4M=;
        b=CgQ2E7Dm2zy6yXW5oxb7C4pBd3pJ4GfcSIokfxC121/ZcsNPGjofLQDLgE1m8Mm1ez8OVW
        FWxZaN8BGveJfMA0iGXNWdWO9qDDlNuOS9pfG5O1A1jVFL1dAgJ6Bp8otF2NhOJno+0JSq
        tTYfQthFt5v/9Jyrm7CgKhOKWQzCoe8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-218-EKKuowZ6PWWny_NHZe8fbw-1; Wed, 04 May 2022 09:21:09 -0400
X-MC-Unique: EKKuowZ6PWWny_NHZe8fbw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C4440899ED3;
        Wed,  4 May 2022 13:21:08 +0000 (UTC)
Received: from dwysocha.rdu.csb (unknown [10.22.9.36])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 82A86155BC8B;
        Wed,  4 May 2022 13:21:08 +0000 (UTC)
From:   Dave Wysochanski <dwysocha@redhat.com>
To:     Anna Schumaker <anna.schumaker@netapp.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>
Cc:     linux-nfs@vger.kernel.org, linux-cachefs@redhat.com,
        David Howells <dhowells@redhat.com>,
        Daire Byrne <daire.byrne@gmail.com>
Subject: [PATCH] NFS: Pass i_size to fscache_unuse_cookie() when a file is released
Date:   Wed,  4 May 2022 09:21:06 -0400
Message-Id: <20220504132106.28812-1-dwysocha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Pass updated i_size in fscache_unuse_cookie() when called
from nfs_fscache_release_file(), which ensures the size of
an fscache object gets written to the cache storage.  Failing
to do so results in unnessary reads from the NFS server, even
when the data is cached, due to a cachefiles object coherency
check failing with a trace similar to the following:
  cachefiles_coherency: o=0000000e BAD osiz B=afbb3 c=0

This problem can be reproduced as follows:
  #!/bin/bash
  v=4.2; NFS_SERVER=127.0.0.1
  set -e; trap cleanup EXIT; rc=1
  function cleanup {
          umount /mnt/nfs > /dev/null 2>&1
          RC_STR="TEST PASS"
          [ $rc -eq 1 ] && RC_STR="TEST FAIL"
          echo "$RC_STR on $(uname -r) with NFSv$v and server $NFS_SERVER"
  }
  mount -o vers=$v,fsc $NFS_SERVER:/export /mnt/nfs
  rm -f /mnt/nfs/file1.bin > /dev/null 2>&1
  dd if=/dev/zero of=/mnt/nfs/file1.bin bs=4096 count=1 > /dev/null 2>&1
  echo 3 > /proc/sys/vm/drop_caches
  echo Read file 1st time from NFS server into fscache
  dd if=/mnt/nfs/file1.bin of=/dev/null > /dev/null 2>&1
  umount /mnt/nfs && mount -o vers=$v,fsc $NFS_SERVER:/export /mnt/nfs
  echo 3 > /proc/sys/vm/drop_caches
  echo Read file 2nd time from fscache
  dd if=/mnt/nfs/file1.bin of=/dev/null > /dev/null 2>&1
  echo Check mountstats for NFS read
  grep -q "READ: 0" /proc/self/mountstats # (1st number) == 0
  [ $? -eq 0 ] && rc=0

Fixes: a6b5a28eb56c "nfs: Convert to new fscache volume/cookie API"
Signed-off-by: Dave Wysochanski <dwysocha@redhat.com>
---
 fs/nfs/fscache.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/fs/nfs/fscache.c b/fs/nfs/fscache.c
index f73c09a9cf0a..e861d7bae305 100644
--- a/fs/nfs/fscache.c
+++ b/fs/nfs/fscache.c
@@ -231,11 +231,10 @@ void nfs_fscache_release_file(struct inode *inode, struct file *filp)
 {
 	struct nfs_fscache_inode_auxdata auxdata;
 	struct fscache_cookie *cookie = nfs_i_fscache(inode);
+	loff_t i_size = i_size_read(inode);
 
-	if (fscache_cookie_valid(cookie)) {
-		nfs_fscache_update_auxdata(&auxdata, inode);
-		fscache_unuse_cookie(cookie, &auxdata, NULL);
-	}
+	nfs_fscache_update_auxdata(&auxdata, inode);
+	fscache_unuse_cookie(cookie, &auxdata, &i_size);
 }
 
 /*
-- 
2.27.1

