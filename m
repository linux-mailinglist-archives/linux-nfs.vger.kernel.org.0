Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FF66232001
	for <lists+linux-nfs@lfdr.de>; Wed, 29 Jul 2020 16:12:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726724AbgG2OMv (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 29 Jul 2020 10:12:51 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:58289 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726645AbgG2OMv (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 29 Jul 2020 10:12:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596031969;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=Sxvpy87d5Vab50/XQgKs9K2RBO/Dznmf8wgzdG9msaU=;
        b=NznXPpmeE+eT1RS4XEYZmf81WaCqtGmW4TB5C0jIAPV0LHI+mpSf4R3sJM9kstUPM9nv6P
        KUSjFchq8/xeZeVtn+FwyGjJqJdbdd9NAM/c4+jE7mUAyROcy1QtfeuMsKfWTriOCD92Mu
        DLqZ+AACfATBKsZrjV4R75LhM1t6ehc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-232-j9r6HIdhPD-thQ_YZFw3pw-1; Wed, 29 Jul 2020 10:12:48 -0400
X-MC-Unique: j9r6HIdhPD-thQ_YZFw3pw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E6F4A106B242;
        Wed, 29 Jul 2020 14:12:46 +0000 (UTC)
Received: from dwysocha.rdu.csb (ovpn-113-23.rdu2.redhat.com [10.10.113.23])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6E6BA71923;
        Wed, 29 Jul 2020 14:12:46 +0000 (UTC)
From:   Dave Wysochanski <dwysocha@redhat.com>
To:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>
Cc:     linux-nfs@vger.kernel.org, linux-cachefs@redhat.com
Subject: [RFC PATCH v2 09/14] NFS: Only use and unuse an fscache cookie a single time based on NFS_INO_FSCACHE
Date:   Wed, 29 Jul 2020 10:12:24 -0400
Message-Id: <1596031949-26793-10-git-send-email-dwysocha@redhat.com>
In-Reply-To: <1596031949-26793-1-git-send-email-dwysocha@redhat.com>
References: <1596031949-26793-1-git-send-email-dwysocha@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

For NFS, we only want to make a decision whether to "use" a inode based
fscache cookie one time, not multiple times, and based on whether the
inode is open for write by any process.  Achieve this by gating the
call to fscache_use_cookie / fscache_unuse_cookie by the NFS_INO_FSCACHE
flag on the nfs_inode.

Signed-off-by: Dave Wysochanski <dwysocha@redhat.com>
---
 fs/nfs/fscache.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/fs/nfs/fscache.c b/fs/nfs/fscache.c
index 1c4ced273fb7..00bb720cccfa 100644
--- a/fs/nfs/fscache.c
+++ b/fs/nfs/fscache.c
@@ -285,8 +285,10 @@ void nfs_fscache_clear_inode(struct inode *inode)
 
 	dfprintk(FSCACHE, "NFS: clear cookie (0x%p/0x%p)\n", nfsi, cookie);
 
-	nfs_fscache_update_auxdata(&auxdata, nfsi);
-	fscache_unuse_cookie(cookie, &auxdata, NULL);
+	if (test_and_clear_bit(NFS_INO_FSCACHE, &NFS_I(inode)->flags)) {
+		nfs_fscache_update_auxdata(&auxdata, nfsi);
+		fscache_unuse_cookie(cookie, &auxdata, NULL);
+	}
 	fscache_relinquish_cookie(cookie, false);
 	nfsi->fscache = NULL;
 }
@@ -321,18 +323,23 @@ void nfs_fscache_open_file(struct inode *inode, struct file *filp)
 {
 	struct nfs_inode *nfsi = NFS_I(inode);
 	struct fscache_cookie *cookie = nfs_i_fscache(inode);
+	struct nfs_fscache_inode_auxdata auxdata;
 
 	if (!fscache_cookie_valid(cookie))
 		return;
 
 	if (inode_is_open_for_write(inode)) {
-		dfprintk(FSCACHE, "NFS: nfsi 0x%p disabling cache\n", nfsi);
-		clear_bit(NFS_INO_FSCACHE, &nfsi->flags);
+		if (test_and_clear_bit(NFS_INO_FSCACHE, &nfsi->flags)) {
+			dfprintk(FSCACHE, "NFS: nfsi 0x%p disabling cache\n", nfsi);
+			nfs_fscache_update_auxdata(&auxdata, nfsi);
+			fscache_unuse_cookie(cookie, &auxdata, NULL);
+		}
 	} else {
-		dfprintk(FSCACHE, "NFS: nfsi 0x%p enabling cache\n", nfsi);
-		set_bit(NFS_INO_FSCACHE, &NFS_I(inode)->flags);
+		if (!test_and_set_bit(NFS_INO_FSCACHE, &nfsi->flags)) {
+			dfprintk(FSCACHE, "NFS: nfsi 0x%p enabling cache\n", nfsi);
+			fscache_use_cookie(cookie, false);
+		}
 	}
-	fscache_use_cookie(cookie, false);
 }
 EXPORT_SYMBOL_GPL(nfs_fscache_open_file);
 
-- 
1.8.3.1

