Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2328C2FD66F
	for <lists+linux-nfs@lfdr.de>; Wed, 20 Jan 2021 18:05:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391623AbhATRFU (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 20 Jan 2021 12:05:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:60175 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2391303AbhATRBe (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 20 Jan 2021 12:01:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611161997;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=I3SFxsb7at1NLkvLBwhkWtXDZDEHXS6qkMyuJFUQUcA=;
        b=aGr9MutRrf/hSn6vB/DP3aWfPQ6tLRUiqKj7gnDrN/gwJVAjfuKMQU5ftxhkO7QAbSCBLF
        sb72/6BcNdqTa1rngDBEUF5foiSIaC/AcPnc5SR0XjtzT8dIlVAIDXRe24FFRMsWuGhhHo
        axF/Vgv+zwCqMqk0BJZok1R787IfOTo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-502-JKJMqBr3PMeouaemXeFrRw-1; Wed, 20 Jan 2021 11:59:55 -0500
X-MC-Unique: JKJMqBr3PMeouaemXeFrRw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0642F8735C2
        for <linux-nfs@vger.kernel.org>; Wed, 20 Jan 2021 16:59:55 +0000 (UTC)
Received: from bcodding.csb (ovpn-64-66.rdu2.redhat.com [10.10.64.66])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D1B735D9C2
        for <linux-nfs@vger.kernel.org>; Wed, 20 Jan 2021 16:59:54 +0000 (UTC)
Received: by bcodding.csb (Postfix, from userid 24008)
        id 6EE2F10E3EE7; Wed, 20 Jan 2021 11:59:54 -0500 (EST)
From:   Benjamin Coddington <bcodding@redhat.com>
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v1 01/10] NFS: save the directory's change attribute on pagecache pages
Date:   Wed, 20 Jan 2021 11:59:45 -0500
Message-Id: <628bd528d5b2e8e714e9c0eeb9d891713fc885b6.1611160120.git.bcodding@redhat.com>
In-Reply-To: <cover.1611160120.git.bcodding@redhat.com>
References: <cover.1611160120.git.bcodding@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

After a pagecache page has been filled with entries, set PagePrivate and
the directory's change attribute on the page.  This will help us perform
per-page invalidations in a later patch.

Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
---
 fs/nfs/dir.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index ef827ae193d2..ade73ca42a52 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -53,6 +53,9 @@ static int nfs_closedir(struct inode *, struct file *);
 static int nfs_readdir(struct file *, struct dir_context *);
 static int nfs_fsync_dir(struct file *, loff_t, loff_t, int);
 static loff_t nfs_llseek_dir(struct file *, loff_t, int);
+static void nfs_readdir_invalidatepage(struct page *,
+			unsigned int, unsigned int);
+static int nfs_readdir_clear_page(struct page*, gfp_t);
 static void nfs_readdir_clear_array(struct page*);
 
 const struct file_operations nfs_dir_operations = {
@@ -65,6 +68,8 @@ const struct file_operations nfs_dir_operations = {
 };
 
 const struct address_space_operations nfs_dir_aops = {
+	.invalidatepage = nfs_readdir_invalidatepage,
+	.releasepage = nfs_readdir_clear_page,
 	.freepage = nfs_readdir_clear_array,
 };
 
@@ -181,6 +186,27 @@ static void nfs_readdir_page_init_array(struct page *page, u64 last_cookie)
 	array->last_cookie = last_cookie;
 	array->cookies_are_ordered = 1;
 	kunmap_atomic(array);
+	set_page_private(page, 0);
+}
+
+static int
+nfs_readdir_clear_page(struct page *page, gfp_t gfp_mask)
+{
+	detach_page_private(page);
+	return 1;
+}
+
+static void
+nfs_readdir_invalidatepage(struct page *page, unsigned int offset,
+							unsigned int length)
+{
+	nfs_readdir_clear_page(page, GFP_KERNEL);
+}
+
+static void
+nfs_readdir_set_page_verifier(struct page *page, unsigned long verf)
+{
+	attach_page_private(page, (void *)verf);
 }
 
 /*
@@ -744,6 +770,8 @@ static int nfs_readdir_page_filler(struct nfs_readdir_descriptor *desc,
 		if (status != -ENOSPC)
 			continue;
 
+		nfs_readdir_set_page_verifier(page, desc->dir_verifier);
+
 		if (page->mapping != mapping) {
 			if (!--narrays)
 				break;
@@ -770,10 +798,13 @@ static int nfs_readdir_page_filler(struct nfs_readdir_descriptor *desc,
 	case -EBADCOOKIE:
 		if (entry->eof) {
 			nfs_readdir_page_set_eof(page);
+			nfs_readdir_set_page_verifier(page, desc->dir_verifier);
 			status = 0;
 		}
 		break;
 	case -ENOSPC:
+		nfs_readdir_set_page_verifier(page, desc->dir_verifier);
+		fallthrough;
 	case -EAGAIN:
 		status = 0;
 		break;
-- 
2.25.4

