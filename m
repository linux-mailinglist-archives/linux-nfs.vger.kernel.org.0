Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF6C12FD66A
	for <lists+linux-nfs@lfdr.de>; Wed, 20 Jan 2021 18:05:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390641AbhATRFO (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 20 Jan 2021 12:05:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:21280 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2391612AbhATRBf (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 20 Jan 2021 12:01:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611161998;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=12Eg8CvR+Ni0Oe8ekqduRsnlP5+EIgifm7UScIeUTpM=;
        b=E7rHnyniYBMmeWQ7h9Ec57QO70mRUlCSKXz/imf+/us3e7DiTVfqxLVGzDJRncIcD1PVyU
        kqB0rLN9EzvMVSsPf//6BjxSfhHlthfD2EwnjONk9Pkuq507Mi9N6eoVUep32JP0/kao/w
        Rz6B+F2blqRQ77a8q0vjXsoEV3wPDhY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-224-zYrIYeRLNm2JzzjbuiRriw-1; Wed, 20 Jan 2021 11:59:56 -0500
X-MC-Unique: zYrIYeRLNm2JzzjbuiRriw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B7DDF107ACE8
        for <linux-nfs@vger.kernel.org>; Wed, 20 Jan 2021 16:59:55 +0000 (UTC)
Received: from bcodding.csb (ovpn-64-66.rdu2.redhat.com [10.10.64.66])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8A5291001281
        for <linux-nfs@vger.kernel.org>; Wed, 20 Jan 2021 16:59:55 +0000 (UTC)
Received: by bcodding.csb (Postfix, from userid 24008)
        id ED9B910E5BFF; Wed, 20 Jan 2021 11:59:54 -0500 (EST)
From:   Benjamin Coddington <bcodding@redhat.com>
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v1 10/10] NFS: Revalidate the directory pagecache on every nfs_readdir()
Date:   Wed, 20 Jan 2021 11:59:54 -0500
Message-Id: <3e1c54f1a5e50fdeeb814c4067d1462da3f36dfd.1611160121.git.bcodding@redhat.com>
In-Reply-To: <cover.1611160120.git.bcodding@redhat.com>
References: <cover.1611160120.git.bcodding@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
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
index fc9e72341220..842412454e3d 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -1167,11 +1167,9 @@ static int nfs_readdir(struct file *file, struct dir_context *ctx)
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
2.25.4

