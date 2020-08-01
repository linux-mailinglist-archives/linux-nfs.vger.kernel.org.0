Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C06992351D7
	for <lists+linux-nfs@lfdr.de>; Sat,  1 Aug 2020 13:10:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728531AbgHALKp (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 1 Aug 2020 07:10:45 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:54092 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728418AbgHALKo (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 1 Aug 2020 07:10:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596280243;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iUDWn7O+gKFLZMJSiLkM1M/5/GiJ3nnxzmIjw/TR8oo=;
        b=ZCICIz+A0VOZm/2l8qhC6XUxTLoqkyN10oAJ8QESLE2/prULfzSHJKPOMVDBhmvyY8iRR/
        v8kphvjtm1NEp5mpEa5M4Gt22V2G+VipJfyCj3moq0ThNJ6Nq3DdTZ4LGLjhYi+G/G0K3A
        Q5QZsTW3rLXxMpH7K9YVIP+KBP6vd4s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-148-xS_n-wJnO6OmeHCvTaOOWw-1; Sat, 01 Aug 2020 07:10:41 -0400
X-MC-Unique: xS_n-wJnO6OmeHCvTaOOWw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B87A3106B242;
        Sat,  1 Aug 2020 11:10:40 +0000 (UTC)
Received: from aion.usersys.redhat.com (ovpn-115-198.rdu2.redhat.com [10.10.115.198])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6703E6FEEB;
        Sat,  1 Aug 2020 11:10:40 +0000 (UTC)
Received: by aion.usersys.redhat.com (Postfix, from userid 1000)
        id 92A091A0008; Sat,  1 Aug 2020 07:10:39 -0400 (EDT)
From:   Scott Mayhew <smayhew@redhat.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 2/2] nfs: nfs_file_write() should check for writeback errors
Date:   Sat,  1 Aug 2020 07:10:39 -0400
Message-Id: <20200801111039.1407632-3-smayhew@redhat.com>
In-Reply-To: <20200801111039.1407632-1-smayhew@redhat.com>
References: <20200801111039.1407632-1-smayhew@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The NFS_CONTEXT_ERROR_WRITE flag (as well as the check of said flag) was
removed by commit 6fbda89b257f.  The absence of an error check allows
writes to be continually queued up for a server that may no longer be
able to handle them.  Fix it by adding an error check using the generic
error reporting functions.

Fixes: 6fbda89b257f ("NFS: Replace custom error reporting mechanism with
generic one")
Signed-off-by: Scott Mayhew <smayhew@redhat.com>
---
 fs/nfs/file.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/fs/nfs/file.c b/fs/nfs/file.c
index d72496efa17b..63940a7a70be 100644
--- a/fs/nfs/file.c
+++ b/fs/nfs/file.c
@@ -590,12 +590,14 @@ static const struct vm_operations_struct nfs_file_vm_ops = {
 	.page_mkwrite = nfs_vm_page_mkwrite,
 };
 
-static int nfs_need_check_write(struct file *filp, struct inode *inode)
+static int nfs_need_check_write(struct file *filp, struct inode *inode,
+				int error)
 {
 	struct nfs_open_context *ctx;
 
 	ctx = nfs_file_open_context(filp);
-	if (nfs_ctx_key_to_expire(ctx, inode))
+	if (nfs_error_is_fatal_on_server(error) ||
+	    nfs_ctx_key_to_expire(ctx, inode))
 		return 1;
 	return 0;
 }
@@ -606,6 +608,8 @@ ssize_t nfs_file_write(struct kiocb *iocb, struct iov_iter *from)
 	struct inode *inode = file_inode(file);
 	unsigned long written = 0;
 	ssize_t result;
+	errseq_t since;
+	int error;
 
 	result = nfs_key_timeout_notify(file, inode);
 	if (result)
@@ -630,6 +634,7 @@ ssize_t nfs_file_write(struct kiocb *iocb, struct iov_iter *from)
 	if (iocb->ki_pos > i_size_read(inode))
 		nfs_revalidate_mapping(inode, file->f_mapping);
 
+	since = filemap_sample_wb_err(file->f_mapping);
 	nfs_start_io_write(inode);
 	result = generic_write_checks(iocb, from);
 	if (result > 0) {
@@ -648,7 +653,8 @@ ssize_t nfs_file_write(struct kiocb *iocb, struct iov_iter *from)
 		goto out;
 
 	/* Return error values */
-	if (nfs_need_check_write(file, inode)) {
+	error = filemap_check_wb_err(file->f_mapping, since);
+	if (nfs_need_check_write(file, inode, error)) {
 		int err = nfs_wb_all(inode);
 		if (err < 0)
 			result = err;
-- 
2.25.4

