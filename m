Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E95EE32B74D
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Mar 2021 12:06:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245234AbhCCK5J (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 3 Mar 2021 05:57:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:29689 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1350897AbhCBVAT (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 2 Mar 2021 16:00:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614718701;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=pOvwgDCVFoFp8x5o6ZXGiZ7wNi+/BiGbbICIxdJ/OOE=;
        b=O0YLwfLs2SuNKTgXglaxulKtTaPMK0d+RXcL+MvcTmOWm2BvN3AxKjKxY3URZxqo/Xo4b6
        vWsOhhIsNTUOAzqGg49LAUTjqispm1wHUORuVCVj/rcwEBUN6BdhZZoWrAav+jgGTeKAuY
        1lUQWzwLvaLqufSETVJdfzqrY20xV4E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-583-B4XBUjfcPA-CK4UY2sEhnA-1; Tue, 02 Mar 2021 15:58:19 -0500
X-MC-Unique: B4XBUjfcPA-CK4UY2sEhnA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EA45510082F5
        for <linux-nfs@vger.kernel.org>; Tue,  2 Mar 2021 20:58:18 +0000 (UTC)
Received: from bearskin.sorenson.redhat.com (ovpn-114-44.phx2.redhat.com [10.3.114.44])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id AC2EC6F996;
        Tue,  2 Mar 2021 20:58:15 +0000 (UTC)
From:   Frank Sorenson <sorenson@redhat.com>
To:     linux-nfs@vger.kernel.org
Cc:     sorenson@redhat.com
Subject: [PATCH] NFS: Correct size calculation for create reply length
Date:   Tue,  2 Mar 2021 14:58:14 -0600
Message-Id: <20210302205814.1228549-1-sorenson@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

CREATE requests return a post_op_fh3, rather than nfs_fh3. The
post_op_fh3 includes an extra word to indicate 'handle_follows'.

Without that additional word, create fails when full 64-byte
filehandles are in use.

Add NFS3_post_op_fh_sz, and correct the size calculation for
NFS3_createres_sz.

Signed-off-by: Frank Sorenson <sorenson@redhat.com>
---
 fs/nfs/nfs3xdr.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/nfs3xdr.c b/fs/nfs/nfs3xdr.c
index ca10072644ff..ed1c83738c30 100644
--- a/fs/nfs/nfs3xdr.c
+++ b/fs/nfs/nfs3xdr.c
@@ -36,6 +36,7 @@
 #define NFS3_pagepad_sz		(1) /* Page padding */
 #define NFS3_fhandle_sz		(1+16)
 #define NFS3_fh_sz		(NFS3_fhandle_sz)	/* shorthand */
+#define NFS3_post_op_fh_sz	(1+NFS3_fh_sz)
 #define NFS3_sattr_sz		(15)
 #define NFS3_filename_sz	(1+(NFS3_MAXNAMLEN>>2))
 #define NFS3_path_sz		(1+(NFS3_MAXPATHLEN>>2))
@@ -73,7 +74,7 @@
 #define NFS3_readlinkres_sz	(1+NFS3_post_op_attr_sz+1+NFS3_pagepad_sz)
 #define NFS3_readres_sz		(1+NFS3_post_op_attr_sz+3+NFS3_pagepad_sz)
 #define NFS3_writeres_sz	(1+NFS3_wcc_data_sz+4)
-#define NFS3_createres_sz	(1+NFS3_fh_sz+NFS3_post_op_attr_sz+NFS3_wcc_data_sz)
+#define NFS3_createres_sz	(1+NFS3_post_op_fh_sz+NFS3_post_op_attr_sz+NFS3_wcc_data_sz)
 #define NFS3_renameres_sz	(1+(2 * NFS3_wcc_data_sz))
 #define NFS3_linkres_sz		(1+NFS3_post_op_attr_sz+NFS3_wcc_data_sz)
 #define NFS3_readdirres_sz	(1+NFS3_post_op_attr_sz+2+NFS3_pagepad_sz)
-- 
2.29.2

