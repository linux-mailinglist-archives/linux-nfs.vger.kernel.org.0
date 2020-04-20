Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E04DE1B00DD
	for <lists+linux-nfs@lfdr.de>; Mon, 20 Apr 2020 07:00:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725872AbgDTFAC (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 20 Apr 2020 01:00:02 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:55595 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725815AbgDTFAC (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 20 Apr 2020 01:00:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587358801;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=a8NlP/8IMjqncSyB+WZ1HvHgg3EQ8VUS33dMd8/Toi4=;
        b=Q+LvA/8AYOsVzsHNw5OvyeJEt6ou+/UX6eFUcgKWSy0+UbsLNYWKGV0GPv5A9TvvUNy74B
        KEqYEFYhnSu9G4Treu9V+BZNKZC5d9AJbUT3jAkBltEAibHnn0QXOgvvTGmglOjAWHCHYO
        BK7DelqecVCVMddWnyjDLmXweoJjsZA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-513-fwBXtdteNbWGXOb2uWOXcg-1; Mon, 20 Apr 2020 00:59:59 -0400
X-MC-Unique: fwBXtdteNbWGXOb2uWOXcg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 20C53800D5C;
        Mon, 20 Apr 2020 04:59:58 +0000 (UTC)
Received: from nevermore.foobar.lan (unknown [10.74.8.230])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 016E728980;
        Mon, 20 Apr 2020 04:59:55 +0000 (UTC)
Date:   Mon, 20 Apr 2020 10:29:52 +0530
From:   Achilles Gaikwad <agaikwad@redhat.com>
To:     linux-nfs@vger.kernel.org
Cc:     bfields@fieldses.org, trondmy@hammerspace.com, kdsouza@redhat.com
Subject: [PATCH v2] nfsd4: add filename to states output
Message-ID: <20200420045952.GA61440@nevermore.foobar.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
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
index e32ecedece0f..f1cc825ff20b 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -2404,6 +2404,11 @@ static void states_stop(struct seq_file *s, void *v)
 	spin_unlock(&clp->cl_lock);
 }
 
+static void nfs4_show_fname(struct seq_file *s, struct nfsd_file *f)
+{
+         seq_printf(s, "filename: \"%pD2\"", f->nf_file);
+}
+
 static void nfs4_show_superblock(struct seq_file *s, struct nfsd_file *f)
 {
 	struct inode *inode = f->nf_inode;
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

