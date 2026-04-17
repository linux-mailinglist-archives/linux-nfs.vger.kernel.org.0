Return-Path: <linux-nfs+bounces-20942-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yF4aMi6A4mnk6gAAu9opvQ
	(envelope-from <linux-nfs+bounces-20942-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Apr 2026 20:47:10 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 51E3D41E0D4
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Apr 2026 20:47:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AC2AD300C91D
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Apr 2026 18:47:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 401AA32D0D4;
	Fri, 17 Apr 2026 18:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jRPe1yE9"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FC6D28C87C
	for <linux-nfs@vger.kernel.org>; Fri, 17 Apr 2026 18:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776451624; cv=none; b=f83FknBbckfTiyVMBtvetr79JVdaQ8U/ExE6CBjN5QBH82cUr/Xxn0QShTcAv9FlaEgKrFuWi1r5CKolVpZdZj9YbgSg9duUXzHkofevEJjsOgkwlr6CXuzo2ZCZfRNcK4En8j3YXUTHRCnOcL8rp2x3BONbfAZfjWXtQHMfmVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776451624; c=relaxed/simple;
	bh=b3Zh2Df3E2t0eXAc0ug8O4qqR2tRryvc9yRFfQ01J4k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MTkl9d3dINIk4o9WD7u4eNnXqrUH49LviZUUkY1oR6dXc4fgvt0Q28znKzGJF4dIwfhSlw8HXJBS5BXugOu6Ph9g5GsRHCKaMDciK7Y/008PtR7/XYNP8e9qylxwUaQXd/bd/5DOtRyyJCTRFqpK3ZmrS2AY3ku3Qw50iqBFxj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jRPe1yE9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776451621;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=vu8fPZPmHmyb5AqMO4S4gV/lsdilYmglL+hQzlILElQ=;
	b=jRPe1yE99PceuX76UJwv4x2PLQCgUZpQhweTAp6tz3ajYPBQNyJtfKX2B3BR+jEM2dmwMj
	X8CvcvjY61JRUySNiijQtmJN9CC2FFx7mkSpDgM+TNQzXqq0RabORMFBUxWwicpEkhhqcp
	UmhxPjOrXUHWT3LIwC52yewkn/awlZE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-445-CdYycrt_OSW27b8kvzz9Fg-1; Fri,
 17 Apr 2026 14:46:58 -0400
X-MC-Unique: CdYycrt_OSW27b8kvzz9Fg-1
X-Mimecast-MFC-AGG-ID: CdYycrt_OSW27b8kvzz9Fg_1776451617
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CC88D1956089;
	Fri, 17 Apr 2026 18:46:57 +0000 (UTC)
Received: from okorniev-mac.redhat.com (unknown [10.22.81.224])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1552A195608E;
	Fri, 17 Apr 2026 18:46:56 +0000 (UTC)
From: Olga Kornievskaia <okorniev@redhat.com>
To: trondmy@kernel.org,
	anna@kernel.org
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH v4 1/1] NFSv4.2: fix CLONE/COPY attrs in presence of delegated attributes
Date: Fri, 17 Apr 2026 14:46:56 -0400
Message-ID: <20260417184656.36191-1-okorniev@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-20942-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[okorniev@redhat.com,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TAGGED_RCPT(0.00)[linux-nfs];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 51E3D41E0D4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

xfstest generic/407 is failing in 2 ways. It detects that after
doing a clone the client does not update it's mtime and it's ctime.
CLONE always sends a GETATTR operation and then calls
nfs_post_op_update_inode() based on the returned attributes.
Because of the delegated attributes the client ignores updating
the mtime. Then also, when delegated attributes are present, for
the change_attr the server replies with the same values as what
the client cached before and thus the generic/407 would flag that.
Instead, make sure we invalidate the blocks attr.

By adding updating delegated attributes in nfs42_copy_dest_done()
both COPY and CLONE would update mtime appropriately.

Fixes: e12912d94137 ("NFSv4: Add support for delegated atime and mtime attributes")
Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>

--v4 this version removes the need for having
"NFSv4.2: fix COPY attrs in presence of delegated timestamps"
---
 fs/nfs/nfs42proc.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/nfs42proc.c b/fs/nfs/nfs42proc.c
index 7b3ca68fb4bb..fad0784349c7 100644
--- a/fs/nfs/nfs42proc.c
+++ b/fs/nfs/nfs42proc.c
@@ -393,6 +393,7 @@ static void nfs42_copy_dest_done(struct file *file, loff_t pos, loff_t len,
 	WARN_ON_ONCE(invalidate_inode_pages2_range(mapping, pos >> PAGE_SHIFT,
 						   end >> PAGE_SHIFT));
 
+	nfs_update_delegated_mtime(inode);
 	spin_lock(&inode->i_lock);
 	if (newsize > i_size_read(inode))
 		i_size_write(inode, newsize);
@@ -1306,7 +1307,14 @@ static int _nfs42_proc_clone(struct rpc_message *msg, struct file *src_f,
 		if (count == 0 && res.dst_fattr->valid & NFS_ATTR_FATTR_SIZE)
 			count = nfs_size_to_loff_t(res.dst_fattr->size) - dst_offset;
 		nfs42_copy_dest_done(dst_f, dst_offset, count, oldsize_dst);
-		status = nfs_post_op_update_inode(dst_inode, res.dst_fattr);
+		if (!nfs_have_delegated_attributes(dst_inode))
+			status = nfs_post_op_update_inode(dst_inode,
+							  res.dst_fattr);
+		else {
+			spin_lock(&dst_inode->i_lock);
+			nfs_set_cache_invalid(dst_inode, NFS_INO_INVALID_BLOCKS);
+			spin_unlock(&dst_inode->i_lock);
+		}
 	}
 
 	kfree(res.dst_fattr);
-- 
2.52.0


