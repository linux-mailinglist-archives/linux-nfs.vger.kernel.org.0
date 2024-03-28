Return-Path: <linux-nfs+bounces-2535-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EAFA8905E8
	for <lists+linux-nfs@lfdr.de>; Thu, 28 Mar 2024 17:44:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCC8F292D01
	for <lists+linux-nfs@lfdr.de>; Thu, 28 Mar 2024 16:44:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DB8A13248E;
	Thu, 28 Mar 2024 16:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a0kRtS2l"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF97013B5A1
	for <linux-nfs@vger.kernel.org>; Thu, 28 Mar 2024 16:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711643887; cv=none; b=VojlTYxdDxCMx+Fcx8lc7XbYDygFHKq6qqgSWbp95cbwN1vl/kALlSu/vSr+fs3E73UukAlawiKsMg9GE6x0P8v/BbasvYU8b3djaFCdb9rbBiuhOmkm3hH2leI0E8fjGN6g499v4qFd6HJZP8KKUJi2TSwyfNtmLUWm7bOUEsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711643887; c=relaxed/simple;
	bh=YOFdy5xHJExTdGSNGA/bjJfdcMMA97H0CVe8osQSYQE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EUi3HjuRfcGL21V7tbogYurWlnrY1hh+osgChWKq7zYMO+KnKGQCbjdMwl21FjOm0Z91SU4Ztvw64h1IojbOw9N3Ii2rAfhMDfsHDpqJHjUEuQcZGPBTPRz5u6Y4H14WhJVMbP56aWR/axt1TvQp0OA1oKa5LG7/+bKkJFKrE5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a0kRtS2l; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711643884;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YXmc3YCo60jECje6D8F3mfZ1bN1Jr5ynl0cOwSqeZGY=;
	b=a0kRtS2lK0VbUF1BgLbovdbk+iixr9We0QtcZ9XPjomZG/l1fIQleqd+8KN3Q1rYA88549
	Vi2BiTjCIBQ0kHj9iSAp2iCm7Mc0oKPB55vh9KHcVeOudb5NPTUxlBDqYYAL8+VLXEnAtI
	hisn5DVTLH7G9jyi09Fo392RLfQtftE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-252-8jp_rTaQOFW2Kmd5vBMnHA-1; Thu, 28 Mar 2024 12:38:02 -0400
X-MC-Unique: 8jp_rTaQOFW2Kmd5vBMnHA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5A18A88F2EC;
	Thu, 28 Mar 2024 16:38:01 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.146])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 72392492BD0;
	Thu, 28 Mar 2024 16:37:58 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>,
	Jeff Layton <jlayton@kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Dominique Martinet <asmadeus@codewreck.org>
Cc: David Howells <dhowells@redhat.com>,
	Matthew Wilcox <willy@infradead.org>,
	Steve French <smfrench@gmail.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Paulo Alcantara <pc@manguebit.com>,
	Shyam Prasad N <sprasad@microsoft.com>,
	Tom Talpey <tom@talpey.com>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Ilya Dryomov <idryomov@gmail.com>,
	netfs@lists.linux.dev,
	linux-cachefs@redhat.com,
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
Subject: [PATCH 17/26] netfs: Fix writethrough-mode error handling
Date: Thu, 28 Mar 2024 16:34:09 +0000
Message-ID: <20240328163424.2781320-18-dhowells@redhat.com>
In-Reply-To: <20240328163424.2781320-1-dhowells@redhat.com>
References: <20240328163424.2781320-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10

Fix the error return in netfs_perform_write() acting in writethrough-mode
to return any cached error in the case that netfs_end_writethrough()
returns 0.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/netfs/buffered_write.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/fs/netfs/buffered_write.c b/fs/netfs/buffered_write.c
index 8e4a3fb287e3..db4ad158948b 100644
--- a/fs/netfs/buffered_write.c
+++ b/fs/netfs/buffered_write.c
@@ -188,7 +188,7 @@ ssize_t netfs_perform_write(struct kiocb *iocb, struct iov_iter *iter,
 	enum netfs_how_to_modify howto;
 	enum netfs_folio_trace trace;
 	unsigned int bdp_flags = (iocb->ki_flags & IOCB_SYNC) ? 0: BDP_ASYNC;
-	ssize_t written = 0, ret;
+	ssize_t written = 0, ret, ret2;
 	loff_t i_size, pos = iocb->ki_pos, from, to;
 	size_t max_chunk = PAGE_SIZE << MAX_PAGECACHE_ORDER;
 	bool maybe_trouble = false;
@@ -409,10 +409,12 @@ ssize_t netfs_perform_write(struct kiocb *iocb, struct iov_iter *iter,
 
 out:
 	if (unlikely(wreq)) {
-		ret = netfs_end_writethrough(wreq, iocb);
+		ret2 = netfs_end_writethrough(wreq, iocb);
 		wbc_detach_inode(&wbc);
-		if (ret == -EIOCBQUEUED)
-			return ret;
+		if (ret2 == -EIOCBQUEUED)
+			return ret2;
+		if (ret == 0)
+			ret = ret2;
 	}
 
 	iocb->ki_pos += written;


