Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 739923328C5
	for <lists+linux-nfs@lfdr.de>; Tue,  9 Mar 2021 15:42:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230081AbhCIOlw (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 9 Mar 2021 09:41:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbhCIOlS (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 9 Mar 2021 09:41:18 -0500
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5E21C06174A
        for <linux-nfs@vger.kernel.org>; Tue,  9 Mar 2021 06:41:17 -0800 (PST)
Received: by mail-il1-x12e.google.com with SMTP id c10so12354274ilo.8
        for <linux-nfs@vger.kernel.org>; Tue, 09 Mar 2021 06:41:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=W+TH84BJZU8LkJpJyWn70AQ7P3aTegNBu5O2F2xMVds=;
        b=Ta5eFCLq4gEYeSikigFbbOakOhXQqy4cfszwXWk3ti84VOdRFKI14ndK6QsjY6MlzP
         eQVUmUBMNKsObJbYN3tkY1E36bvGOLuxueumZLeO6ljP3UJAM7O079RaeMJU73yCz1Ib
         qvFjyIRAUcwkyOSaKM+vC3QrVFt68DOUygmnwqo6CO/2CLE03wYOpN4poPgo570ZitGF
         qD7JHM+iFzKxN19cDH5wS3FwRzh8BRYsmsSKPRonO70j+MnCxQi1EfkeoRTwPeN0VAke
         VfmFBZP5IS0KUCtwSE0FzreXfGIOBlDkSNZOevplzRBT9fSJofHnO1w0nvadiuCujhYU
         KaGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=W+TH84BJZU8LkJpJyWn70AQ7P3aTegNBu5O2F2xMVds=;
        b=OyTrDM7SdTxXKD/4bRVv0ZHhXtZh4elbkeKlL/b/26PmaHYgl2ogNNd32m2dVKnG/R
         Uk5CuUZugxeDQO1A1c2soLtEwfKUaQWaetzgdPm7FLwQWTQV82+w1zf9QZ2yTc9xhZ4E
         f2iGsAOsWYacG2KyLAXo774/LZDDJl+KZKtTzjt9KbxIZs8s6zlw4zg1jILQFWtIclFz
         RSzD/9PyBJE4q1jLr0B6D/Bzs+YmQg60kRvCRxb9I+ajr9tupNTudGlOHsZVupVn9iu4
         aw12oamJThtOYI8S8i9TJH63ny0FQCHEW1rtMc+Fr08rQlXvXnaH7F1FV9bY2R4Ldx9S
         R06w==
X-Gm-Message-State: AOAM530sG8ZbkG7MBk0eJV7RqVyAoNHluMmJn1bxRUsdpIBfgB2FEHCT
        OZO08HawvVKnnERD8Eb9LeE=
X-Google-Smtp-Source: ABdhPJwFIjbc9OgpPxfNcX59Drib7zp4pRlHgQ5lkBzQMs4i6vDIQzOcXS/kq0HXs+57j11skgFLpQ==
X-Received: by 2002:a92:d8d1:: with SMTP id l17mr25553350ilo.85.1615300877344;
        Tue, 09 Mar 2021 06:41:17 -0800 (PST)
Received: from kolga-mac-1.lan (50-124-244-195.alma.mi.frontiernet.net. [50.124.244.195])
        by smtp.gmail.com with ESMTPSA id o7sm7834008ilj.67.2021.03.09.06.41.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Mar 2021 06:41:16 -0800 (PST)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     bfields@redhat.com, chuck.lever@oracle.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 1/1] NFSD: fix dest to src mount in inter-server COPY
Date:   Tue,  9 Mar 2021 09:41:14 -0500
Message-Id: <20210309144114.57778-1-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Olga Kornievskaia <kolga@netapp.com>

A cleanup of the inter SSC copy needs to call fput() of the source
file handle to make sure that file structure is freed as well as
drop the reference on the superblock to unmount the source server.

Fixes: 36e1e5ba90fb ("NFSD: Fix use-after-free warning when doing inter-server copy")
Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
---
 fs/nfsd/nfs4proc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 8d6d2678abad..3581ce737e85 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -1304,7 +1304,7 @@ nfsd4_cleanup_inter_ssc(struct vfsmount *ss_mnt, struct nfsd_file *src,
 			struct nfsd_file *dst)
 {
 	nfs42_ssc_close(src->nf_file);
-	/* 'src' is freed by nfsd4_do_async_copy */
+	fput(src->nf_file);
 	nfsd_file_put(dst);
 	mntput(ss_mnt);
 }
-- 
2.27.0

