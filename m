Return-Path: <linux-nfs+bounces-20462-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QAuLGnmfxmnrMQUAu9opvQ
	(envelope-from <linux-nfs+bounces-20462-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Mar 2026 16:17:13 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CAA673468CA
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Mar 2026 16:17:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 63D58301DB82
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Mar 2026 15:12:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A471E30FF31;
	Fri, 27 Mar 2026 15:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SzQMzEW0"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63EA030F55B
	for <linux-nfs@vger.kernel.org>; Fri, 27 Mar 2026 15:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774624319; cv=none; b=jcTL4pOA0MYGo7YAOcTzLW291W6eagED4cprSJBGMm8dCRiFOO02/W09tAtYspoXJVekWA0BULXKsL+kRXRPW3DlUZVt0vesGnbveIgR2Cy7QBYurYrRx0T+TRqJovDibPyVD+JintVX6V/6/c1MreTwBwSCf2R9kojNEdH9D4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774624319; c=relaxed/simple;
	bh=2p3fD49wJzWiu/wtzycOYIdzBl3AWM31ZAZDLSOU6SY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NgwT18hEq143ZWqQfsV8ufuoep48JMhYK2KldK6T6hScuMjMyH31a/CX+NxfdBPkSxGhEgNwOJaQbupFFs9WH36ESqE7JDMrvHd2Yod9uTX5tVEQxZQWtVsfuOcqIIvESPPLVrpylcrNly0K5xRYghPXzROTaZrvBUW0tGIAogI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SzQMzEW0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774624317;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=sMlbPnGV7wIwqOG5qjD7XaNTHjDBkMZBoc2Olh2FJwc=;
	b=SzQMzEW0YZZM1D0jwjzmx5cyDgAdnVixx5VRD3BHN1i7UPfLiKmCn6X/KS5I76/+RwGUtU
	WnsAf7j0L8/WkStXOJPiFhMiCp6hzCXDZeKd8Plkh9InAqmbkR84oGQ0t5eqJ6JbLgKM+f
	bW91ms//952kXvbpxDkgINuhuJT4tdo=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-122-agmjW8F3N1aqHCDXRuDN2w-1; Fri,
 27 Mar 2026 11:11:53 -0400
X-MC-Unique: agmjW8F3N1aqHCDXRuDN2w-1
X-Mimecast-MFC-AGG-ID: agmjW8F3N1aqHCDXRuDN2w_1774624312
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7776518005B3;
	Fri, 27 Mar 2026 15:11:52 +0000 (UTC)
Received: from okorniev-mac.redhat.com (unknown [10.22.81.48])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BBFF330001A1;
	Fri, 27 Mar 2026 15:11:51 +0000 (UTC)
From: Olga Kornievskaia <okorniev@redhat.com>
To: trond.myklebust@hammerspace.com,
	anna@kernel.org
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH 1/1] NFSv4.2: fix CLONE attrs in presence of delegated attributes
Date: Fri, 27 Mar 2026 11:11:49 -0400
Message-ID: <20260327151149.25317-1-okorniev@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
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
	TAGGED_FROM(0.00)[bounces-20462-lists,linux-nfs=lfdr.de];
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
X-Rspamd-Queue-Id: CAA673468CA
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

Fixes: e12912d94137 ("NFSv4: Add support for delegated atime and mtime attributes")
Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
---
 fs/nfs/nfs42proc.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/nfs42proc.c b/fs/nfs/nfs42proc.c
index 7e5c1172fc11..f6a7cfa12225 100644
--- a/fs/nfs/nfs42proc.c
+++ b/fs/nfs/nfs42proc.c
@@ -1306,7 +1306,15 @@ static int _nfs42_proc_clone(struct rpc_message *msg, struct file *src_f,
 		if (count == 0 && res.dst_fattr->valid & NFS_ATTR_FATTR_SIZE)
 			count = nfs_size_to_loff_t(res.dst_fattr->size) - dst_offset;
 		nfs42_copy_dest_done(dst_f, dst_offset, count, oldsize_dst);
-		status = nfs_post_op_update_inode(dst_inode, res.dst_fattr);
+		nfs_update_delegated_mtime(dst_inode);
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


