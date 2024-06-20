Return-Path: <linux-nfs+bounces-4184-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BC8E910F3F
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Jun 2024 19:45:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E9171C2017D
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Jun 2024 17:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A55431BA09B;
	Thu, 20 Jun 2024 17:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BodO+GlQ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D87E1BA099
	for <linux-nfs@vger.kernel.org>; Thu, 20 Jun 2024 17:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718904847; cv=none; b=DxnbKsxUdKHT3x2ErP/Yf7h5WhyoPdMJncYlp1q6sbjP7vVzWmKwSmMxGyYVzsDoUhDZHYgel6MCd/InfSz5Xo3s/1UBJPmnU4JWsI/0eZHubJjWLMzsI+3q+Ihx68mL8cL7sxd/UeB/lKbuUG3/FrgxJLdpeaQsyQxn6L8j4PQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718904847; c=relaxed/simple;
	bh=3UMfps3MS4tY9CuK1J7SRtFHrACvZi/2d9Tc1nHpwWc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=odTrjXMENEElAww1Ny7iHX+TzhC/L8aPdbDZoXXfGVTa0EW5HKVtLYCp5fD4IQ1g23+qKvI8hrnYNL2cg0f/GAjdVCdkHoai589deS70KxuzTqQzIIBnp26952TR4jE+WqOb6WF8oISnFxHWbycOAKZgCPNkZBN8f10OW4u4D7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BodO+GlQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718904845;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OdyodcaxIsN9yjCj5kMWkPV/Ay0KIsoiyQ6+poCT0PE=;
	b=BodO+GlQpsX/el5yw9+he6DFhOmuAC1V6KWDh24Y3HVc6zQjJxUKVVm8QpEA9mMan85re/
	HVOF3NPL1FdWpV6OecXNdWVrwp3CQkFMbir0QSsYMXvWG7KFU5DUvTR7Fg/HrOLPD5kR8U
	ZSJWl6Ba8f3hYbB3lI5qKEPwCHoYdbE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-99-kf0yI3oINji29pOmCBJ72w-1; Thu,
 20 Jun 2024 13:34:01 -0400
X-MC-Unique: kf0yI3oINji29pOmCBJ72w-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8CFEC1956063;
	Thu, 20 Jun 2024 17:33:58 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.39.195.156])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9316B3000218;
	Thu, 20 Jun 2024 17:33:52 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>,
	Steve French <smfrench@gmail.com>,
	Matthew Wilcox <willy@infradead.org>
Cc: David Howells <dhowells@redhat.com>,
	Jeff Layton <jlayton@kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Marc Dionne <marc.dionne@auristor.com>,
	Paulo Alcantara <pc@manguebit.com>,
	Shyam Prasad N <sprasad@microsoft.com>,
	Tom Talpey <tom@talpey.com>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Ilya Dryomov <idryomov@gmail.com>,
	netfs@lists.linux.dev,
	linux-afs@lists.infradead.org,
	linux-cifs@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	v9fs@lists.linux.dev,
	linux-erofs@lists.ozlabs.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 16/17] afs: Make read subreqs async
Date: Thu, 20 Jun 2024 18:31:34 +0100
Message-ID: <20240620173137.610345-17-dhowells@redhat.com>
In-Reply-To: <20240620173137.610345-1-dhowells@redhat.com>
References: <20240620173137.610345-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Perform AFS read subrequests in a work item rather than in the calling
thread.  For normal buffered reads, this will allow the calling thread to
copy data from the pagecache to the application at the same time as the
demarshalling thread is shovelling data from skbuffs into the pagecache.

This will also allow the RA mark to trigger a new read before we've
finished shovelling the data from the current one.

Note: This would be a bit safer if the FS.FetchData RPC ops returned the
metadata (including the data version number) before returning the data.
This would allow me to flush the pagecache before installing the new data.

In future, it may be possible to asynchronously flush the pagecache either
side of the region being read.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: linux-afs@lists.infradead.org
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/afs/file.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/fs/afs/file.c b/fs/afs/file.c
index c3f0c45ae9a9..addb106dba4c 100644
--- a/fs/afs/file.c
+++ b/fs/afs/file.c
@@ -304,8 +304,9 @@ int afs_fetch_data(struct afs_vnode *vnode, struct afs_read *req)
 	return afs_do_sync_operation(op);
 }
 
-static void afs_issue_read(struct netfs_io_subrequest *subreq)
+static void afs_read_worker(struct work_struct *work)
 {
+	struct netfs_io_subrequest *subreq = container_of(work, struct netfs_io_subrequest, work);
 	struct afs_vnode *vnode = AFS_FS_I(subreq->rreq->inode);
 	struct afs_read *fsreq;
 
@@ -324,6 +325,12 @@ static void afs_issue_read(struct netfs_io_subrequest *subreq)
 	afs_put_read(fsreq);
 }
 
+static void afs_issue_read(struct netfs_io_subrequest *subreq)
+{
+	INIT_WORK(&subreq->work, afs_read_worker);
+	queue_work(system_long_wq, &subreq->work);
+}
+
 static int afs_symlink_read_folio(struct file *file, struct folio *folio)
 {
 	struct afs_vnode *vnode = AFS_FS_I(folio->mapping->host);


