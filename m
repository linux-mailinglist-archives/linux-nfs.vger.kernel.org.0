Return-Path: <linux-nfs+bounces-542-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 089A9811720
	for <lists+linux-nfs@lfdr.de>; Wed, 13 Dec 2023 16:34:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 368F7B20FF9
	for <lists+linux-nfs@lfdr.de>; Wed, 13 Dec 2023 15:34:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67B4E67B6E;
	Wed, 13 Dec 2023 15:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FDBoO83X"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 774C6107
	for <linux-nfs@vger.kernel.org>; Wed, 13 Dec 2023 07:26:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702481171;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bK45Roxm3IC/nkVEsH43k2qGwF+l+q9rJ2GGBczBW+0=;
	b=FDBoO83X4x5kZPnh0AFEoQJI7BMNpggVCjU/ugWgEz1iZFQrF+o0sfPR3lyQY1/pCRFqHr
	V9Ht8QWBRwWZ1RQm8YbJRab5aIwYKnqxvvRa83Fs6rJOT+DdMr6LQq3OuRLHYNxyat5Hj4
	6cqce2jzM3OghSCKivrFxEHny1o9eJA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-286-0fI0XmfbP--2wLLfUpTaCw-1; Wed, 13 Dec 2023 10:26:09 -0500
X-MC-Unique: 0fI0XmfbP--2wLLfUpTaCw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 35572101CC6E;
	Wed, 13 Dec 2023 15:26:07 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.2])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 937E41121312;
	Wed, 13 Dec 2023 15:26:03 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Jeff Layton <jlayton@kernel.org>,
	Steve French <smfrench@gmail.com>
Cc: David Howells <dhowells@redhat.com>,
	Matthew Wilcox <willy@infradead.org>,
	Marc Dionne <marc.dionne@auristor.com>,
	Paulo Alcantara <pc@manguebit.com>,
	Shyam Prasad N <sprasad@microsoft.com>,
	Tom Talpey <tom@talpey.com>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Ilya Dryomov <idryomov@gmail.com>,
	Christian Brauner <christian@brauner.io>,
	linux-cachefs@redhat.com,
	linux-afs@lists.infradead.org,
	linux-cifs@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	v9fs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 30/39] netfs: Implement buffered write API
Date: Wed, 13 Dec 2023 15:23:40 +0000
Message-ID: <20231213152350.431591-31-dhowells@redhat.com>
In-Reply-To: <20231213152350.431591-1-dhowells@redhat.com>
References: <20231213152350.431591-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

Institute a netfs write helper, netfs_file_write_iter(), to be pointed at
by the network filesystem ->write_iter() call.  Make it handled buffered
writes by calling the previously defined netfs_perform_write() to copy the
source data into the pagecache.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: linux-cachefs@redhat.com
cc: linux-fsdevel@vger.kernel.org
cc: linux-mm@kvack.org
---
 fs/netfs/buffered_write.c | 83 +++++++++++++++++++++++++++++++++++++++
 include/linux/netfs.h     |  3 ++
 2 files changed, 86 insertions(+)

diff --git a/fs/netfs/buffered_write.c b/fs/netfs/buffered_write.c
index b76688e98f81..f244123ab568 100644
--- a/fs/netfs/buffered_write.c
+++ b/fs/netfs/buffered_write.c
@@ -333,3 +333,86 @@ ssize_t netfs_perform_write(struct kiocb *iocb, struct iov_iter *iter,
 	goto out;
 }
 EXPORT_SYMBOL(netfs_perform_write);
+
+/**
+ * netfs_buffered_write_iter_locked - write data to a file
+ * @iocb:	IO state structure (file, offset, etc.)
+ * @from:	iov_iter with data to write
+ * @netfs_group: Grouping for dirty pages (eg. ceph snaps).
+ *
+ * This function does all the work needed for actually writing data to a
+ * file. It does all basic checks, removes SUID from the file, updates
+ * modification times and calls proper subroutines depending on whether we
+ * do direct IO or a standard buffered write.
+ *
+ * The caller must hold appropriate locks around this function and have called
+ * generic_write_checks() already.  The caller is also responsible for doing
+ * any necessary syncing afterwards.
+ *
+ * This function does *not* take care of syncing data in case of O_SYNC write.
+ * A caller has to handle it. This is mainly due to the fact that we want to
+ * avoid syncing under i_rwsem.
+ *
+ * Return:
+ * * number of bytes written, even for truncated writes
+ * * negative error code if no data has been written at all
+ */
+ssize_t netfs_buffered_write_iter_locked(struct kiocb *iocb, struct iov_iter *from,
+					 struct netfs_group *netfs_group)
+{
+	struct file *file = iocb->ki_filp;
+	ssize_t ret;
+
+	trace_netfs_write_iter(iocb, from);
+
+	ret = file_remove_privs(file);
+	if (ret)
+		return ret;
+
+	ret = file_update_time(file);
+	if (ret)
+		return ret;
+
+	return netfs_perform_write(iocb, from, netfs_group);
+}
+EXPORT_SYMBOL(netfs_buffered_write_iter_locked);
+
+/**
+ * netfs_file_write_iter - write data to a file
+ * @iocb: IO state structure
+ * @from: iov_iter with data to write
+ *
+ * Perform a write to a file, writing into the pagecache if possible and doing
+ * an unbuffered write instead if not.
+ *
+ * Return:
+ * * Negative error code if no data has been written at all of
+ *   vfs_fsync_range() failed for a synchronous write
+ * * Number of bytes written, even for truncated writes
+ */
+ssize_t netfs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
+{
+	struct file *file = iocb->ki_filp;
+	struct inode *inode = file->f_mapping->host;
+	struct netfs_inode *ictx = netfs_inode(inode);
+	ssize_t ret;
+
+	_enter("%llx,%zx,%llx", iocb->ki_pos, iov_iter_count(from), i_size_read(inode));
+
+	if ((iocb->ki_flags & IOCB_DIRECT) ||
+	    test_bit(NETFS_ICTX_UNBUFFERED, &ictx->flags))
+		return netfs_unbuffered_write_iter(iocb, from);
+
+	ret = netfs_start_io_write(inode);
+	if (ret < 0)
+		return ret;
+
+	ret = generic_write_checks(iocb, from);
+	if (ret > 0)
+		ret = netfs_buffered_write_iter_locked(iocb, from, NULL);
+	netfs_end_io_write(inode);
+	if (ret > 0)
+		ret = generic_write_sync(iocb, ret);
+	return ret;
+}
+EXPORT_SYMBOL(netfs_file_write_iter);
diff --git a/include/linux/netfs.h b/include/linux/netfs.h
index 00c87f4e809c..702b864a4993 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -385,7 +385,10 @@ ssize_t netfs_unbuffered_read_iter(struct kiocb *iocb, struct iov_iter *iter);
 /* High-level write API */
 ssize_t netfs_perform_write(struct kiocb *iocb, struct iov_iter *iter,
 			    struct netfs_group *netfs_group);
+ssize_t netfs_buffered_write_iter_locked(struct kiocb *iocb, struct iov_iter *from,
+					 struct netfs_group *netfs_group);
 ssize_t netfs_unbuffered_write_iter(struct kiocb *iocb, struct iov_iter *from);
+ssize_t netfs_file_write_iter(struct kiocb *iocb, struct iov_iter *from);
 
 /* Address operations API */
 struct readahead_control;


