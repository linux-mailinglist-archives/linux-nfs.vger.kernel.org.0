Return-Path: <linux-nfs+bounces-6609-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 007E597EDC8
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Sep 2024 17:11:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA7511F221B0
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Sep 2024 15:11:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4047C1A0705;
	Mon, 23 Sep 2024 15:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HLiD8JQj"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84E501A01BC
	for <linux-nfs@vger.kernel.org>; Mon, 23 Sep 2024 15:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727104146; cv=none; b=ebjv1RysyzknVA1/JWqQdwaxjzwgY1KdRsuq0t4Sutw4i4gErgxj5M+DnK4BEuUGDF49SApl2NY+tk6wX30vIo9+Sp5FVTEg9ZpzHiuEdmF+neIzW1HF/PUMnYK8ztUXPerjQj1eyUxwLtJG60Vbgu6ZnCqBF8VfbhkppjzP/iQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727104146; c=relaxed/simple;
	bh=rtYlhOMdVR41jeKY9q/c0ZlVGDD4ajFvswOXM9o792g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b/gsMuyx9UsrOHY5GcGmQqY0fN2f/5n6VYL6J8gd0PvSEFSEunZRiRqV3+wkPWa9uSPBeTQcRMRExV6WxXX/07rEmZ67PPn8vVYXb3LsPkP3s+ONkjJQr36faiJ3xBBauPoE+gq3RQ/zz8T9KwCUqhQluvipFwbeFR9QyM6MtpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HLiD8JQj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727104143;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=en0FbhjuTrTUZN9cCFkNjaE5g8iEA8EQ8DfNicZc0lg=;
	b=HLiD8JQjUomoDgh24PmhqAw7PsQCSITEtbNDbl1bSn7m6iCKeMaLqYrvAwZyhUz0JiEcPk
	CymWJ079NumM1RLP9pjDnyDD/ubp+v0XXL00a1OJLiZ40UQluvVA1Rll+XTdglcV7p8tDd
	p1Jvckqyl7x6RQ7p4zxz05HMT/YQj98=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-118-hNdBfCa9Nk6QzasA8zlp7Q-1; Mon,
 23 Sep 2024 11:08:57 -0400
X-MC-Unique: hNdBfCa9Nk6QzasA8zlp7Q-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (unknown [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 102351895D51;
	Mon, 23 Sep 2024 15:08:50 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.145])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C5CF4197700E;
	Mon, 23 Sep 2024 15:08:42 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>,
	Steve French <sfrench@samba.org>,
	Marc Dionne <marc.dionne@auristor.com>
Cc: David Howells <dhowells@redhat.com>,
	Paulo Alcantara <pc@manguebit.com>,
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
	Shyam Prasad N <nspmangalore@gmail.com>,
	Rohith Surabattula <rohiths.msft@gmail.com>
Subject: [PATCH 7/8] cifs: Fix reversion of the iter in cifs_readv_receive().
Date: Mon, 23 Sep 2024 16:07:51 +0100
Message-ID: <20240923150756.902363-8-dhowells@redhat.com>
In-Reply-To: <20240923150756.902363-1-dhowells@redhat.com>
References: <20240923150756.902363-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

cifs_read_iter_from_socket() copies the iterator that's passed in for the
socket to modify as and if it will, and then advances the original iterator
by the amount sent.  However, both callers revert the advancement (although
receive_encrypted_read() zeros beyond the iterator first).  The problem is,
though, that cifs_readv_receive() reverts by the original length, not the
amount transmitted which can cause an oops in iov_iter_revert().

Fix this by:

 (1) Remove the iov_iter_advance() from cifs_read_iter_from_socket().

 (2) Remove the iov_iter_revert() from both callers.  This fixes the bug in
     cifs_readv_receive().

 (3) In receive_encrypted_read(), if we didn't get back as much data as the
     buffer will hold, copy the iterator, advance the copy and use the copy
     to drive iov_iter_zero().

As a bonus, this gets rid of some unnecessary work.

This was triggered by generic/074 with the "-o sign" mount option.

Fixes: 3ee1a1fc3981 ("cifs: Cut over to using netfslib")
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Steve French <sfrench@samba.org>
cc: Paulo Alcantara <pc@manguebit.com>
cc: Shyam Prasad N <nspmangalore@gmail.com>
cc: Rohith Surabattula <rohiths.msft@gmail.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: linux-cifs@vger.kernel.org
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/smb/client/connect.c   | 6 +-----
 fs/smb/client/smb2ops.c   | 9 ++++++---
 fs/smb/client/transport.c | 3 ---
 3 files changed, 7 insertions(+), 11 deletions(-)

diff --git a/fs/smb/client/connect.c b/fs/smb/client/connect.c
index 08a41c7aaf72..be6e632388f8 100644
--- a/fs/smb/client/connect.c
+++ b/fs/smb/client/connect.c
@@ -811,13 +811,9 @@ cifs_read_iter_from_socket(struct TCP_Server_Info *server, struct iov_iter *iter
 			   unsigned int to_read)
 {
 	struct msghdr smb_msg = { .msg_iter = *iter };
-	int ret;
 
 	iov_iter_truncate(&smb_msg.msg_iter, to_read);
-	ret = cifs_readv_from_socket(server, &smb_msg);
-	if (ret > 0)
-		iov_iter_advance(iter, ret);
-	return ret;
+	return cifs_readv_from_socket(server, &smb_msg);
 }
 
 static bool
diff --git a/fs/smb/client/smb2ops.c b/fs/smb/client/smb2ops.c
index 7381ec333c6d..1ee2dd4a1cae 100644
--- a/fs/smb/client/smb2ops.c
+++ b/fs/smb/client/smb2ops.c
@@ -4869,9 +4869,12 @@ receive_encrypted_read(struct TCP_Server_Info *server, struct mid_q_entry **mid,
 		goto discard_data;
 
 	server->total_read += rc;
-	if (rc < len)
-		iov_iter_zero(len - rc, &iter);
-	iov_iter_revert(&iter, len);
+	if (rc < len) {
+		struct iov_iter tmp = iter;
+
+		iov_iter_advance(&tmp, rc);
+		iov_iter_zero(len - rc, &tmp);
+	}
 	iov_iter_truncate(&iter, dw->len);
 
 	rc = cifs_discard_remaining_data(server);
diff --git a/fs/smb/client/transport.c b/fs/smb/client/transport.c
index fd5a85d43759..91812150186c 100644
--- a/fs/smb/client/transport.c
+++ b/fs/smb/client/transport.c
@@ -1817,11 +1817,8 @@ cifs_readv_receive(struct TCP_Server_Info *server, struct mid_q_entry *mid)
 		length = data_len; /* An RDMA read is already done. */
 	else
 #endif
-	{
 		length = cifs_read_iter_from_socket(server, &rdata->subreq.io_iter,
 						    data_len);
-		iov_iter_revert(&rdata->subreq.io_iter, data_len);
-	}
 	if (length > 0)
 		rdata->got_bytes += length;
 	server->total_read += length;


