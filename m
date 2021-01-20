Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD0FA2FD668
	for <lists+linux-nfs@lfdr.de>; Wed, 20 Jan 2021 18:05:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391722AbhATRFF (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 20 Jan 2021 12:05:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:46424 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2391597AbhATRBf (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 20 Jan 2021 12:01:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611161998;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lEnzzn2Hgl9Ay5ghThhbcNflPzdpaCrMRx+VWv5YTe4=;
        b=OMdvi1fcpjxsYL46Qc65b1RPu/U9iTIH1WfBQPClTeRdKpj/CU+aodMFcjSG1xAnTtFrlR
        sCh3PmwfrZ3zMu47kyiIDyd6Y765tK6E8V4F0fvNGQC07WEIJOMve6nnc0IgH9XCPz84CJ
        FXh5rhb4VWXX9ww2fey1bB8diu1Mf94=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-196-XcRtagvjPsKWioqQ8PMCiQ-1; Wed, 20 Jan 2021 11:59:56 -0500
X-MC-Unique: XcRtagvjPsKWioqQ8PMCiQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A29518030A7
        for <linux-nfs@vger.kernel.org>; Wed, 20 Jan 2021 16:59:55 +0000 (UTC)
Received: from bcodding.csb (ovpn-64-66.rdu2.redhat.com [10.10.64.66])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7B2685D76F
        for <linux-nfs@vger.kernel.org>; Wed, 20 Jan 2021 16:59:55 +0000 (UTC)
Received: by bcodding.csb (Postfix, from userid 24008)
        id E276110E5BF8; Wed, 20 Jan 2021 11:59:54 -0500 (EST)
From:   Benjamin Coddington <bcodding@redhat.com>
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v1 09/10] NFS: Remove nfs_readdir_dont_search_cache()
Date:   Wed, 20 Jan 2021 11:59:53 -0500
Message-Id: <1ebc4a7d527775b03efc21f39d04072e4d118516.1611160121.git.bcodding@redhat.com>
In-Reply-To: <cover.1611160120.git.bcodding@redhat.com>
References: <cover.1611160120.git.bcodding@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Since we can now fill the pagecache at arbitrary offsets, we no longer need
this optimization.

Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
---
 fs/nfs/dir.c | 17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index 7ca79d4b25ec..fc9e72341220 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -1036,28 +1036,11 @@ static int find_and_lock_cache_page(struct nfs_readdir_descriptor *desc)
 	return res;
 }
 
-static bool nfs_readdir_dont_search_cache(struct nfs_readdir_descriptor *desc)
-{
-	struct address_space *mapping = desc->file->f_mapping;
-	struct inode *dir = file_inode(desc->file);
-	unsigned int dtsize = NFS_SERVER(dir)->dtsize;
-	loff_t size = i_size_read(dir);
-
-	/*
-	 * Default to uncached readdir if the page cache is empty, and
-	 * we're looking for a non-zero cookie in a large directory.
-	 */
-	return desc->dir_cookie != 0 && mapping->nrpages == 0 && size > dtsize;
-}
-
 /* Search for desc->dir_cookie from the beginning of the page cache */
 static int readdir_search_pagecache(struct nfs_readdir_descriptor *desc)
 {
 	int res;
 
-	if (nfs_readdir_dont_search_cache(desc))
-		return -EBADCOOKIE;
-
 	do {
 		if (desc->pgc.page_index == 0) {
 			desc->current_index = 0;
-- 
2.25.4

