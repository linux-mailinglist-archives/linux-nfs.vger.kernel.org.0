Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53FCC79DB3B
	for <lists+linux-nfs@lfdr.de>; Tue, 12 Sep 2023 23:55:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237695AbjILVz3 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 12 Sep 2023 17:55:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235507AbjILVz0 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 12 Sep 2023 17:55:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E668710F2
        for <linux-nfs@vger.kernel.org>; Tue, 12 Sep 2023 14:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694555633;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qoUjRDOou+oTZqqwqurF1Ivsy3RlyYHW0xfYpau32qA=;
        b=duAJQyzVccGicHSiIdL2BXSYS15C2g+inRRO03CSZYAsgefU4Adcin+QJGMIeS1v3WaaXM
        gO/xhzzyxV6U+DY/ok0c/brVijDuXXNpN8ST5wPq2rgchQyrdshAUOjVBF58kVdcODkhnK
        L4sBbiwKP8TvYQgm4i1LF73/b/Zbbzw=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-85-dxXtEViPN5CgeWoEZd50fg-1; Tue, 12 Sep 2023 17:53:50 -0400
X-MC-Unique: dxXtEViPN5CgeWoEZd50fg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 72F2C2999B29;
        Tue, 12 Sep 2023 21:53:49 +0000 (UTC)
Received: from fs-i40c-03.fs.lab.eng.bos.redhat.com (fs-i40c-03.fs.lab.eng.bos.redhat.com [10.16.224.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2643C40C2009;
        Tue, 12 Sep 2023 21:53:49 +0000 (UTC)
From:   Alexander Aring <aahringo@redhat.com>
To:     linux-nfs@vger.kernel.org
Cc:     gfs2@lists.linux.dev, ocfs2-devel@lists.linux.dev,
        linux-fsdevel@vger.kernel.org, teigland@redhat.com,
        rpeterso@redhat.com, agruenba@redhat.com,
        trond.myklebust@hammerspace.com, anna@kernel.org,
        chuck.lever@oracle.com, jlayton@kernel.org, aahringo@redhat.com
Subject: [PATCHv2 nfsd/master 7/7] dlm: implement EXPORT_OP_ASYNC_LOCK
Date:   Tue, 12 Sep 2023 17:53:24 -0400
Message-Id: <20230912215324.3310111-8-aahringo@redhat.com>
In-Reply-To: <20230912215324.3310111-1-aahringo@redhat.com>
References: <20230912215324.3310111-1-aahringo@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

This patch is activating the EXPORT_OP_ASYNC_LOCK export flag to
signal lockd that both filesystems are able to handle async lock
requests. The cluster filesystems gfs2 and ocfs2 will redirect their
lock requests to DLMs plock implementation that can handle async lock
requests.

Signed-off-by: Alexander Aring <aahringo@redhat.com>
---
 fs/gfs2/export.c  | 1 +
 fs/ocfs2/export.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/fs/gfs2/export.c b/fs/gfs2/export.c
index cf40895233f5..ef1013eff936 100644
--- a/fs/gfs2/export.c
+++ b/fs/gfs2/export.c
@@ -192,5 +192,6 @@ const struct export_operations gfs2_export_ops = {
 	.fh_to_parent = gfs2_fh_to_parent,
 	.get_name = gfs2_get_name,
 	.get_parent = gfs2_get_parent,
+	.flags = EXPORT_OP_ASYNC_LOCK,
 };
 
diff --git a/fs/ocfs2/export.c b/fs/ocfs2/export.c
index eaa8c80ace3c..b8b6a191b5cb 100644
--- a/fs/ocfs2/export.c
+++ b/fs/ocfs2/export.c
@@ -280,4 +280,5 @@ const struct export_operations ocfs2_export_ops = {
 	.fh_to_dentry	= ocfs2_fh_to_dentry,
 	.fh_to_parent	= ocfs2_fh_to_parent,
 	.get_parent	= ocfs2_get_parent,
+	.flags		= EXPORT_OP_ASYNC_LOCK,
 };
-- 
2.31.1

