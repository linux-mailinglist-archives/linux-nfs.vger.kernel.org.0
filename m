Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B2CC405DE2
	for <lists+linux-nfs@lfdr.de>; Thu,  9 Sep 2021 22:13:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233128AbhIIUOp (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 9 Sep 2021 16:14:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233562AbhIIUOk (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 9 Sep 2021 16:14:40 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EDF6C061756
        for <linux-nfs@vger.kernel.org>; Thu,  9 Sep 2021 13:13:30 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id s32so2594231qtc.12
        for <linux-nfs@vger.kernel.org>; Thu, 09 Sep 2021 13:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=heO/PnWO3hIIWrwJHmqz4P8HqtU69LSaosobg4HtgS0=;
        b=IfEY6u54+gcj09XRk3JeAiko3HG1kF7bsz0//vNS4nN4Z7lMsWK8pMagRn68SYel4B
         bEyP4H8Yg9K4hkfd88mGSdwXhxpdgN4M5jTPwSCP9CGzToWaITRikvmgG0yFNpdwAd9I
         zKgv3G48vLuznjOblYAmFyStHU9zDv/1z5FQn9cUO5x9r7S/3sz4/xJxLOn5D6SjIpzn
         e0KsHV1gP4KqhONOUtbiBS94BIPenUs7TKFSiiD1ckDhiA8ep4KHD+NmmURCkw2ph0Zn
         7bNsRgIbtryUQ51sRzWAZlbf+w7V0OW4wRG94UxYG3+X15I8jjYg5/3iYADMAGc0T/Ow
         VjRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=heO/PnWO3hIIWrwJHmqz4P8HqtU69LSaosobg4HtgS0=;
        b=EVfinWcHsbZAkx7Y0PHl/GlNS/Zd0Gaort7TV4kKvMa7Fj2KYKKnsQgAR3qDQ9Y3lO
         7Oh2VtRDDsRQihQIVQzOj0UZ2A7TytzqXpMuqVeYyHt9eDDgAneFzTFs9P6NDjxk/t6S
         npMduXIVQVZcFkaFY4S+vsQx5I6qZb7YMMWolncrUUqzltnfbdYE20B2iP74/6HqLQx9
         q62Z4HFFEyxT/bZNm7sNnoJ5Xe39bc8RXvphTqEUGs2fnzUgSojqnOv2QUm31XdoZ5nR
         zr2HQRPN2ymRCK+MyFAobJ9KHmtqujpqyfltZDVFw4TW7sAFUBsKJwz3TlfRB5OjEWDE
         7MqA==
X-Gm-Message-State: AOAM533DOomq1un++nPVvk4OJ7cSQIClMvmuDLob+5hRYftVI70g5i5o
        GYY4TMs2jHoFUqqwZ6HWzBE=
X-Google-Smtp-Source: ABdhPJwgSbrhwPF81XFzSlakyDTVS1/iPszwkAGMteouLSLcd3yRWUIxCWXBIt68WouzrHh5RKxNig==
X-Received: by 2002:ac8:5f89:: with SMTP id j9mr4545050qta.209.1631218409629;
        Thu, 09 Sep 2021 13:13:29 -0700 (PDT)
Received: from localhost.localdomain ([2601:401:100:a3a:aa6d:aaff:fe2e:8a6a])
        by smtp.gmail.com with ESMTPSA id l13sm2104020qkp.97.2021.09.09.13.13.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Sep 2021 13:13:29 -0700 (PDT)
Sender: Anna Schumaker <schumakeranna@gmail.com>
From:   schumaker.anna@gmail.com
X-Google-Original-From: Anna.Schumaker@Netapp.com
To:     Trond.Myklebust@hammerspace.com, linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [PATCH 02/14] NFS: Remove the nfs4_label from the nfs_entry struct
Date:   Thu,  9 Sep 2021 16:13:15 -0400
Message-Id: <20210909201327.108759-3-Anna.Schumaker@Netapp.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210909201327.108759-1-Anna.Schumaker@Netapp.com>
References: <20210909201327.108759-1-Anna.Schumaker@Netapp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Anna Schumaker <Anna.Schumaker@Netapp.com>

And instead allocate the fattr using nfs_alloc_fattr_with_label()

Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
---
 fs/nfs/dir.c            | 21 +++++++--------------
 fs/nfs/nfs4xdr.c        |  2 +-
 include/linux/nfs_xdr.h |  1 -
 3 files changed, 8 insertions(+), 16 deletions(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index 1a6d2867fba4..3daa1fd60751 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -680,7 +680,8 @@ void nfs_prime_dcache(struct dentry *parent, struct nfs_entry *entry,
 			nfs_set_verifier(dentry, dir_verifier);
 			status = nfs_refresh_inode(d_inode(dentry), entry->fattr);
 			if (!status)
-				nfs_setsecurity(d_inode(dentry), entry->fattr, entry->label);
+				nfs_setsecurity(d_inode(dentry), entry->fattr,
+						entry->fattr->label);
 			goto out;
 		} else {
 			d_invalidate(dentry);
@@ -694,7 +695,7 @@ void nfs_prime_dcache(struct dentry *parent, struct nfs_entry *entry,
 		goto out;
 	}
 
-	inode = nfs_fhget(dentry->d_sb, entry->fh, entry->fattr, entry->label);
+	inode = nfs_fhget(dentry->d_sb, entry->fh, entry->fattr, entry->fattr->label);
 	alias = d_splice_alias(inode, dentry);
 	d_lookup_done(dentry);
 	if (alias) {
@@ -730,8 +731,8 @@ static int nfs_readdir_page_filler(struct nfs_readdir_descriptor *desc,
 	xdr_set_scratch_page(&stream, scratch);
 
 	do {
-		if (entry->label)
-			entry->label->len = NFS4_MAXLABELLEN;
+		if (entry->fattr->label)
+			entry->fattr->label->len = NFS4_MAXLABELLEN;
 
 		status = xdr_decode(desc, entry, &stream);
 		if (status != 0)
@@ -836,21 +837,15 @@ static int nfs_readdir_xdr_to_array(struct nfs_readdir_descriptor *desc,
 		return -ENOMEM;
 	entry->cookie = nfs_readdir_page_last_cookie(page);
 	entry->fh = nfs_alloc_fhandle();
-	entry->fattr = nfs_alloc_fattr();
+	entry->fattr = nfs_alloc_fattr_with_label(NFS_SERVER(inode));
 	entry->server = NFS_SERVER(inode);
 	if (entry->fh == NULL || entry->fattr == NULL)
 		goto out;
 
-	entry->label = nfs4_label_alloc(NFS_SERVER(inode), GFP_NOWAIT);
-	if (IS_ERR(entry->label)) {
-		status = PTR_ERR(entry->label);
-		goto out;
-	}
-
 	array_size = (dtsize + PAGE_SIZE - 1) >> PAGE_SHIFT;
 	pages = nfs_readdir_alloc_pages(array_size);
 	if (!pages)
-		goto out_release_label;
+		goto out;
 
 	do {
 		unsigned int pglen;
@@ -873,8 +868,6 @@ static int nfs_readdir_xdr_to_array(struct nfs_readdir_descriptor *desc,
 	} while (!status && nfs_readdir_page_needs_filling(page));
 
 	nfs_readdir_free_pages(pages, array_size);
-out_release_label:
-	nfs4_label_free(entry->label);
 out:
 	nfs_free_fattr(entry->fattr);
 	nfs_free_fhandle(entry->fh);
diff --git a/fs/nfs/nfs4xdr.c b/fs/nfs/nfs4xdr.c
index a8cff19c6f00..466b2832de75 100644
--- a/fs/nfs/nfs4xdr.c
+++ b/fs/nfs/nfs4xdr.c
@@ -7475,7 +7475,7 @@ int nfs4_decode_dirent(struct xdr_stream *xdr, struct nfs_entry *entry,
 		return -EAGAIN;
 
 	if (decode_getfattr_attrs(xdr, bitmap, entry->fattr, entry->fh,
-			NULL, entry->label, entry->server) < 0)
+			NULL, entry->fattr->label, entry->server) < 0)
 		return -EAGAIN;
 	if (entry->fattr->valid & NFS_ATTR_FATTR_MOUNTED_ON_FILEID)
 		entry->ino = entry->fattr->mounted_on_fileid;
diff --git a/include/linux/nfs_xdr.h b/include/linux/nfs_xdr.h
index e9698b6278a5..9960f6628066 100644
--- a/include/linux/nfs_xdr.h
+++ b/include/linux/nfs_xdr.h
@@ -753,7 +753,6 @@ struct nfs_entry {
 	int			eof;
 	struct nfs_fh *		fh;
 	struct nfs_fattr *	fattr;
-	struct nfs4_label  *label;
 	unsigned char		d_type;
 	struct nfs_server *	server;
 };
-- 
2.33.0

