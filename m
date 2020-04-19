Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E9791AFCD5
	for <lists+linux-nfs@lfdr.de>; Sun, 19 Apr 2020 19:36:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726211AbgDSRge (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 19 Apr 2020 13:36:34 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:42752 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725793AbgDSRgd (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 19 Apr 2020 13:36:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587317792;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=9NPLb1IEzjPoPFaaQ4Uq6iVKVpYroRh0Uyv80k1lMUE=;
        b=gwn5Jd97iAkvOhDbHv5GcFC9+NYROSbiYhD5Y7vA3sOHT2q6Edx5DARPnNpKzufP8OLL1n
        7367JyJ/hAtdQ4o00vTK6VqjmjClhGJZmuMIoZOYWhIWgWxCUed5hDd15hH/IhCdPD/pgi
        Z+2mibUVIvfzewfHlhLw3SQZGc8i4Dc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-115-z2IBL0AgPk-UY1eXdsY95w-1; Sun, 19 Apr 2020 13:36:30 -0400
X-MC-Unique: z2IBL0AgPk-UY1eXdsY95w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AFF5F8017F3;
        Sun, 19 Apr 2020 17:36:25 +0000 (UTC)
Received: from nevermore.foobar.lan (unknown [10.74.8.50])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4BE8D99DEF;
        Sun, 19 Apr 2020 17:36:24 +0000 (UTC)
Date:   Sun, 19 Apr 2020 23:06:20 +0530
From:   Achilles Gaikwad <agaikwad@redhat.com>
To:     linux-nfs@vger.kernel.org
Cc:     bfields@fieldses.org
Subject: [PATCH] nfsd4: add filename to states output
Message-ID: <20200419173620.GA98107@nevermore.foobar.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Add filename to states output for ease of debugging.

Signed-off-by: Achilles Gaikwad <agaikwad@redhat.com>
Signed-off-by: Kenneth Dsouza <kdsouza@redhat.com>
---
 fs/nfsd/nfs4state.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index e32ecedece0f..0f4ed5e3fbe4 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -2414,6 +2414,11 @@ static void nfs4_show_superblock(struct seq_file *s, struct nfsd_file *f)
 					 inode->i_ino);
 }
 
+static void nfs4_show_fname(struct seq_file *s, struct nfsd_file *f)
+{
+	seq_printf(s, "filename: \"%s\"", f->nf_file->f_path.dentry->d_name.name);
+}
+
 static void nfs4_show_owner(struct seq_file *s, struct nfs4_stateowner *oo)
 {
 	seq_printf(s, "owner: ");
@@ -2449,6 +2454,8 @@ static int nfs4_show_open(struct seq_file *s, struct nfs4_stid *st)
 
 	nfs4_show_superblock(s, file);
 	seq_printf(s, ", ");
+	nfs4_show_fname(s, file);
+	seq_printf(s, ", ");
 	nfs4_show_owner(s, oo);
 	seq_printf(s, " }\n");
 	nfsd_file_put(file);
@@ -2480,6 +2487,8 @@ static int nfs4_show_lock(struct seq_file *s, struct nfs4_stid *st)
 	nfs4_show_superblock(s, file);
 	/* XXX: open stateid? */
 	seq_printf(s, ", ");
+	nfs4_show_fname(s, file);
+	seq_printf(s, ", ");
 	nfs4_show_owner(s, oo);
 	seq_printf(s, " }\n");
 	nfsd_file_put(file);
@@ -2506,6 +2515,7 @@ static int nfs4_show_deleg(struct seq_file *s, struct nfs4_stid *st)
 	/* XXX: lease time, whether it's being recalled. */
 
 	nfs4_show_superblock(s, file);
+	nfs4_show_fname(s, file);
 	seq_printf(s, " }\n");
 
 	return 0;
@@ -2524,6 +2534,7 @@ static int nfs4_show_layout(struct seq_file *s, struct nfs4_stid *st)
 	/* XXX: What else would be useful? */
 
 	nfs4_show_superblock(s, file);
+	nfs4_show_fname(s, file);
 	seq_printf(s, " }\n");
 
 	return 0;
-- 
2.25.3

