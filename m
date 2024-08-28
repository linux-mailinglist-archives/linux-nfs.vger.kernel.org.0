Return-Path: <linux-nfs+bounces-5884-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D22996337F
	for <lists+linux-nfs@lfdr.de>; Wed, 28 Aug 2024 23:05:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5AFC282161
	for <lists+linux-nfs@lfdr.de>; Wed, 28 Aug 2024 21:05:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E86AC1AD3FC;
	Wed, 28 Aug 2024 21:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aUCl8CDd"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E5701AD3F6
	for <linux-nfs@vger.kernel.org>; Wed, 28 Aug 2024 21:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724879025; cv=none; b=tH7QkYEBLJeEqgkYQZ9WQj3d5qsMQaKfFVAvhm1ZeJFaj/R5F+JooUsPfSNi9TZeuIuirXAH7T6Cdi5jgbzQcgyrK0r7LE/lq8hUn0COf5WaYlk2sP7E36j/cVD3MzVv7aJasDI+Rvmnci8RKjLiXe+0NcVERbmmtJAIOWmD2+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724879025; c=relaxed/simple;
	bh=GqAZTFDhWoAAL3jOA2SgFLky3SYLYBcGRQ3LRzMI+NU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NWaRIaXm0g10jXhjhY/BZZl0zvYY6vwSARf0Dr/5q7/ooz4Nt6lWqMUe1eg/s3ndqOltCLSKUmp+p71cK+oH4+hhsfYVjXBlQDnKxbAhnqCHG3PQ2FKVA9Hg/xBj5rJ8pN4xOuXOtkKu2tEZFeKQPpcs+XcE1H3yuzPIg9v7K/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aUCl8CDd; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724879023;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cZLOwDsDBBJUFs2hQlOukyGuDHu131MWSIeu0yUM/RI=;
	b=aUCl8CDdxJQ9A5HaTLTS+e3wXVxPEM4LVuRUwEoC0KkG9kmQMm4PW+h5r9ge++K5n8d6g9
	3uKGuAZ5IJap4sjd+EyePoDi5f5tZlaoF1XtOCgKfZpVi2hfrx2IlSiZHIspJ4Wc1x+ezu
	hCL5+VNwIrdVgabNAVqyeS8r755bRfI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-465-vc_IMyGmMNa-yhlY57doPw-1; Wed,
 28 Aug 2024 17:03:40 -0400
X-MC-Unique: vc_IMyGmMNa-yhlY57doPw-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 06D7A1955D48;
	Wed, 28 Aug 2024 21:03:37 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.30])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4C66B30001A1;
	Wed, 28 Aug 2024 21:03:30 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>,
	Steve French <sfrench@samba.org>
Cc: David Howells <dhowells@redhat.com>,
	Paulo Alcantara <pc@manguebit.com>,
	Tom Talpey <tom@talpey.com>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Jeff Layton <jlayton@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	netfs@lists.linux.dev,
	linux-afs@lists.infradead.org,
	linux-cifs@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	v9fs@lists.linux.dev,
	linux-erofs@lists.ozlabs.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Steve French <stfrench@microsoft.com>,
	Zhang Xiaoxu <zhangxiaoxu5@huawei.com>,
	Pavel Shilovsky <pshilov@microsoft.com>,
	Shyam Prasad N <nspmangalore@gmail.com>,
	Rohith Surabattula <rohiths.msft@gmail.com>
Subject: [PATCH 5/6] cifs: Fix FALLOC_FL_ZERO_RANGE to preflush buffered part of target region
Date: Wed, 28 Aug 2024 22:02:46 +0100
Message-ID: <20240828210249.1078637-6-dhowells@redhat.com>
In-Reply-To: <20240828210249.1078637-1-dhowells@redhat.com>
References: <20240828210249.1078637-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Under certain conditions, the range to be cleared by FALLOC_FL_ZERO_RANGE
may only be buffered locally and not yet have been flushed to the server.
For example:

	xfs_io -f -t -c "pwrite -S 0x41 0 4k" \
		     -c "pwrite -S 0x42 4k 4k" \
		     -c "fzero 0 4k" \
		     -c "pread -v 0 8k" /xfstest.test/foo

will write two 4KiB blocks of data, which get buffered in the pagecache,
and then fallocate() is used to clear the first 4KiB block on the server -
but we don't flush the data first, which means the EOF position on the
server is wrong, and so the FSCTL_SET_ZERO_DATA RPC fails (and xfs_io
ignores the error), but then when we try to read it, we see the old data.

Fix this by preflushing any part of the target region that above the
server's idea of the EOF position to force the server to update its EOF
position.

Note, however, that we don't want to simply expand the file by moving the
EOF before doing the FSCTL_SET_ZERO_DATA[*] because someone else might see
the zeroed region or if the RPC fails we then have to try to clean it up or
risk getting corruption.

[*] And we have to move the EOF first otherwise FSCTL_SET_ZERO_DATA won't
do what we want.

This fixes the generic/008 xfstest.

[!] Note: A better way to do this might be to split the operation into two
parts: we only do FSCTL_SET_ZERO_DATA for the part of the range below the
server's EOF and then, if that worked, invalidate the buffered pages for the
part above the range.

Fixes: 6b69040247e1 ("cifs/smb3: Fix data inconsistent when zero file range")
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Steve French <stfrench@microsoft.com>
cc: Zhang Xiaoxu <zhangxiaoxu5@huawei.com>
cc: Pavel Shilovsky <pshilov@microsoft.com>
cc: Paulo Alcantara <pc@manguebit.com>
cc: Shyam Prasad N <nspmangalore@gmail.com>
cc: Rohith Surabattula <rohiths.msft@gmail.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: linux-cifs@vger.kernel.org
cc: linux-mm@kvack.org
---
 fs/smb/client/smb2ops.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/fs/smb/client/smb2ops.c b/fs/smb/client/smb2ops.c
index a6f00b157275..4df84ebe8dbe 100644
--- a/fs/smb/client/smb2ops.c
+++ b/fs/smb/client/smb2ops.c
@@ -3237,13 +3237,15 @@ static long smb3_zero_data(struct file *file, struct cifs_tcon *tcon,
 }
 
 static long smb3_zero_range(struct file *file, struct cifs_tcon *tcon,
-			    loff_t offset, loff_t len, bool keep_size)
+			    unsigned long long offset, unsigned long long len,
+			    bool keep_size)
 {
 	struct cifs_ses *ses = tcon->ses;
 	struct inode *inode = file_inode(file);
 	struct cifsInodeInfo *cifsi = CIFS_I(inode);
 	struct cifsFileInfo *cfile = file->private_data;
-	unsigned long long new_size;
+	struct netfs_inode *ictx = netfs_inode(inode);
+	unsigned long long i_size, new_size, remote_size;
 	long rc;
 	unsigned int xid;
 
@@ -3255,6 +3257,16 @@ static long smb3_zero_range(struct file *file, struct cifs_tcon *tcon,
 	inode_lock(inode);
 	filemap_invalidate_lock(inode->i_mapping);
 
+	i_size = i_size_read(inode);
+	remote_size = ictx->remote_i_size;
+	if (offset + len >= remote_size && offset < i_size) {
+		unsigned long long top = umin(offset + len, i_size);
+
+		rc = filemap_write_and_wait_range(inode->i_mapping, offset, top - 1);
+		if (rc < 0)
+			goto zero_range_exit;
+	}
+
 	/*
 	 * We zero the range through ioctl, so we need remove the page caches
 	 * first, otherwise the data may be inconsistent with the server.


