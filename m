Return-Path: <linux-nfs+bounces-1532-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41548840223
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Jan 2024 10:50:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1BBB284F51
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Jan 2024 09:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48EA158133;
	Mon, 29 Jan 2024 09:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ddo3xmi5"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AAEB57876
	for <linux-nfs@vger.kernel.org>; Mon, 29 Jan 2024 09:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706521783; cv=none; b=tz3SOrQhVGFlhz9uca56Ph/DlQyl0fO17McyQOIzJNf4LNK2wbqOVXcPO5t+F5zlhYaCz4UjNIxUYfWnmf6rj856Eq6zwa8qpC+eqjEkKBo82tNVki5lug00je1si2laieBLqejGgAd9ew3uhtkGZnMCFCpEaRkRbqgr4+Q59ZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706521783; c=relaxed/simple;
	bh=GNEZC7jukHLtUekXJTCkBRDymlNX9cTfVheqMT+wF+4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hGm0O3gTGHZgOB3nshOuib1KTVEONOV4csrzeeWLyclgpiY7bjHMZqocjqwVhqu1gKlihbPJK7w4fGgaLTrZGN21o6Rmy8O66zMF03xZt7fFrr5DVDIgdhmi5xAfyFhKLo7ZMkwkHBoHCrYDRp6iMXK0Y04SS5G3+fjzqsXR9fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ddo3xmi5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706521780;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ty0Sx4Ua+2bn5g9HXUfTFpOpeFYCT/PUmNHnpETf4uo=;
	b=ddo3xmi5FNEtITVh40eljg/sOUWZ2KS/bNInO5f2O7ajtnFP4U3rCT1Ybn6gjja7ghgGr1
	sahWb0jDhDmo6zKQEImCgI8vGSuh+kpKE5IzqJf++Zaa6IT1JYsmtZfp0RWN+6J1GK5/6M
	4ScpvAzzIBLozZ9Ka+juIwVgcKssnhg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-605-X_1LCiW7OoeQwPj1VhB6fQ-1; Mon, 29 Jan 2024 04:49:35 -0500
X-MC-Unique: X_1LCiW7OoeQwPj1VhB6fQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8808688B7A3;
	Mon, 29 Jan 2024 09:49:34 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.245])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 79BAB492BE2;
	Mon, 29 Jan 2024 09:49:32 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>
Cc: David Howells <dhowells@redhat.com>,
	Eric Van Hensbergen <ericvh@kernel.org>,
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
	linux_oss@crudebyte.com
Subject: [PATCH 2/2] netfs: Fix missing zero-length check in unbuffered write
Date: Mon, 29 Jan 2024 09:49:19 +0000
Message-ID: <20240129094924.1221977-3-dhowells@redhat.com>
In-Reply-To: <20240129094924.1221977-1-dhowells@redhat.com>
References: <20240129094924.1221977-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10

Fix netfs_unbuffered_write_iter() to return immediately if
generic_write_checks() returns 0, indicating there's nothing to write.
Note that netfs_file_write_iter() already does this.

Also, whilst we're at it, put in checks for the size being zero before we
even take the locks.  Note that generic_write_checks() can still reduce the
size to zero, so we still need that check.

Without this, a warning similar to the following is logged to dmesg:

	netfs: Zero-sized write [R=1b6da]

and the syscall fails with EIO, e.g.:

	/sbin/ldconfig.real: Writing of cache extension data failed: Input/output error

This can be reproduced on 9p by:

	xfs_io -f -c 'pwrite 0 0' /xfstest.test/foo

Fixes: 153a9961b551 ("netfs: Implement unbuffered/DIO write support")
Reported-by: Eric Van Hensbergen <ericvh@kernel.org>
Link: https://lore.kernel.org/r/ZbQUU6QKmIftKsmo@FV7GG9FTHL/
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Dominique Martinet <asmadeus@codewreck.org>
cc: Jeff Layton <jlayton@kernel.org>
cc: v9fs@lists.linux.dev
cc: linux_oss@crudebyte.com
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/netfs/buffered_write.c | 3 +++
 fs/netfs/direct_write.c   | 5 ++++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/netfs/buffered_write.c b/fs/netfs/buffered_write.c
index a3059b3168fd..9a0d32e4b422 100644
--- a/fs/netfs/buffered_write.c
+++ b/fs/netfs/buffered_write.c
@@ -477,6 +477,9 @@ ssize_t netfs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 
 	_enter("%llx,%zx,%llx", iocb->ki_pos, iov_iter_count(from), i_size_read(inode));
 
+	if (!iov_iter_count(from))
+		return 0;
+
 	if ((iocb->ki_flags & IOCB_DIRECT) ||
 	    test_bit(NETFS_ICTX_UNBUFFERED, &ictx->flags))
 		return netfs_unbuffered_write_iter(iocb, from);
diff --git a/fs/netfs/direct_write.c b/fs/netfs/direct_write.c
index 60a40d293c87..bee047e20f5d 100644
--- a/fs/netfs/direct_write.c
+++ b/fs/netfs/direct_write.c
@@ -139,6 +139,9 @@ ssize_t netfs_unbuffered_write_iter(struct kiocb *iocb, struct iov_iter *from)
 
 	_enter("%llx,%zx,%llx", iocb->ki_pos, iov_iter_count(from), i_size_read(inode));
 
+	if (!iov_iter_count(from))
+		return 0;
+
 	trace_netfs_write_iter(iocb, from);
 	netfs_stat(&netfs_n_rh_dio_write);
 
@@ -146,7 +149,7 @@ ssize_t netfs_unbuffered_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	if (ret < 0)
 		return ret;
 	ret = generic_write_checks(iocb, from);
-	if (ret < 0)
+	if (ret <= 0)
 		goto out;
 	ret = file_remove_privs(file);
 	if (ret < 0)


