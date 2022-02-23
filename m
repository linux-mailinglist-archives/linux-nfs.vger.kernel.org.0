Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1CB24C1465
	for <lists+linux-nfs@lfdr.de>; Wed, 23 Feb 2022 14:41:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240996AbiBWNlJ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 23 Feb 2022 08:41:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240976AbiBWNlI (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 23 Feb 2022 08:41:08 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2E3A0AC06B
        for <linux-nfs@vger.kernel.org>; Wed, 23 Feb 2022 05:40:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645623639;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fjTKGeI8OtqK7SBy1Z/zaXir5SneRCC72cv4gdc2uQI=;
        b=E6ETOLeCMF8dBIcby89h12Oks5Xhl7Urlq9952Q+Eh0WuklwQbCe6FL+dpFnnhAnGQiCdu
        lrSRhsj/sJ/ofOCu0LP2xOPnLnVA5h/YoUMitQjirnQ5sHQ4qHjRrGIhqdOt9p3BdEUiGi
        Sn2McQ7wqs4RlLort180ycXbRu+/rT4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-391-vdH1e-aVNYqmdLOxdHuEBw-1; Wed, 23 Feb 2022 08:40:38 -0500
X-MC-Unique: vdH1e-aVNYqmdLOxdHuEBw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1D717FC80
        for <linux-nfs@vger.kernel.org>; Wed, 23 Feb 2022 13:40:37 +0000 (UTC)
Received: from bcodding.csb (ovpn-64-2.rdu2.redhat.com [10.10.64.2])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E9F381073023
        for <linux-nfs@vger.kernel.org>; Wed, 23 Feb 2022 13:40:36 +0000 (UTC)
Received: by bcodding.csb (Postfix, from userid 24008)
        id 1622A10C3115; Wed, 23 Feb 2022 08:40:36 -0500 (EST)
From:   Benjamin Coddington <bcodding@redhat.com>
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v3 8/8] NFS: Revalidate the directory pagecache on every nfs_readdir()
Date:   Wed, 23 Feb 2022 08:40:35 -0500
Message-Id: <f5f8213a46c4dd30ec202af1b75bb702db99acf5.1645623510.git.bcodding@redhat.com>
In-Reply-To: <71835b457fb123f8e4d51ea9fb586e46016562ff.1645623510.git.bcodding@redhat.com>
References: <d759b6df8acd82b8d44e2afcf11a7a94dcf85ba6.1645623510.git.bcodding@redhat.com> <eedb07d14a96caef1de663a436a326b2c5012ab4.1645623510.git.bcodding@redhat.com> <aaedb2e378800a5cdb7071d65690b981274f2c22.1645623510.git.bcodding@redhat.com> <5479c8c5be9cf3f387edac54f170461f8f7b89e2.1645623510.git.bcodding@redhat.com> <c597a8ae5ea99de277b3f2e6486fe3bde1c5f64a.1645623510.git.bcodding@redhat.com> <19ef38cda6b0eb6548c65c2bff7a4d4dd1baa122.1645623510.git.bcodding@redhat.com> <71835b457fb123f8e4d51ea9fb586e46016562ff.1645623510.git.bcodding@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Since there's no longer a significant performance penalty for dropping the
pagecache, and because we want to ensure that the directory's change
attribute is accurate before validating pagecache pages, revalidate the
directory's mapping on every call to nfs_readdir().

Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
---
 fs/nfs/dir.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index a570f14633ab..565ff26e1b52 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -1271,11 +1271,9 @@ static int nfs_readdir(struct file *file, struct dir_context *ctx)
 	 * to either find the entry with the appropriate number or
 	 * revalidate the cookie.
 	 */
-	if (ctx->pos == 0 || nfs_attribute_cache_expired(inode)) {
-		res = nfs_revalidate_mapping(inode, file->f_mapping);
-		if (res < 0)
-			goto out;
-	}
+	res = nfs_revalidate_mapping(inode, file->f_mapping);
+	if (res < 0)
+		goto out;
 
 	res = -ENOMEM;
 	desc = kzalloc(sizeof(*desc), GFP_KERNEL);
-- 
2.31.1

