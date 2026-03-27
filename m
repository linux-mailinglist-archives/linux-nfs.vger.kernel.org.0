Return-Path: <linux-nfs+bounces-20471-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eDHGJkq3xmnoNwUAu9opvQ
	(envelope-from <linux-nfs+bounces-20471-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Mar 2026 17:58:50 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3985A347F5A
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Mar 2026 17:58:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 31BCB3012865
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Mar 2026 16:58:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E12F436492A;
	Fri, 27 Mar 2026 16:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZKivW1PF"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41A533659E7
	for <linux-nfs@vger.kernel.org>; Fri, 27 Mar 2026 16:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774630687; cv=none; b=d52omjayhbIrH0m/QAyAxQSccFX2UyiV9O6KZKElJqx7sJlY1cMJnQ7FSRfhsMLwxiblfkUktNMTPwJUQ0kUbMBq6oi796iAw80dC36ShKiPKwGGetCTNsDQrjS6+pHYOLtIpAUeLrxubpPBFbzqu8jGalSNa07dXnxznas1F8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774630687; c=relaxed/simple;
	bh=Jo/wrZi1nK0dR+j6QZbuiaL/6c+ExB2RFSw3XGZmBEQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=e/Sx5cXx+G4goenxrLX1jt8WwkcYXSJYb+5evAdSXMgnYk/IKUyRG/UO1VAGqSgKx9w8HEjZsOYxoMrkvMWpf0leL2NL1ZsLpAmiWpCME1aeMga5II7FoVtqRU8CxbEUyddMV4pyBxzUJqoGfCFKkA6A/2JA/8UXDiJfpI08E0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZKivW1PF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774630684;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=DUy088I9PaBtmp8Ts6SOF57NfBaFK2FYZXm+a+A1WrM=;
	b=ZKivW1PFDIx87YdUzfZPU0Kk56og3LuxfGLQXzNvuqnyTmbpPTo/BstIG2fHx0FdWUwNuf
	HXRs3B8vKE3vvhgDJV5B0f6PKHWklwj5QFGEx9n3YAqtyLDuh7uQmJ6V1q8w+z861LqO/P
	bAKufU8X+puCs+qROibRR3mRg8H2r0c=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-116-u7bukZbMOYerRE05QJVeAQ-1; Fri,
 27 Mar 2026 12:58:00 -0400
X-MC-Unique: u7bukZbMOYerRE05QJVeAQ-1
X-Mimecast-MFC-AGG-ID: u7bukZbMOYerRE05QJVeAQ_1774630679
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3911B18002E9;
	Fri, 27 Mar 2026 16:57:59 +0000 (UTC)
Received: from okorniev-mac.redhat.com (unknown [10.22.81.48])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 13EEF180035F;
	Fri, 27 Mar 2026 16:57:57 +0000 (UTC)
From: Olga Kornievskaia <okorniev@redhat.com>
To: trond.myklebust@hammerspace.com,
	anna@kernel.org
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH 1/1] NFSv4.2: fix COPY attrs in presence of delegated timestamps
Date: Fri, 27 Mar 2026 12:57:57 -0400
Message-ID: <20260327165757.28948-1-okorniev@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-20471-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3985A347F5A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

A similar to generic/407 test can be done with a COPY operation
instead of CLONE (reflink). And it leads to same problem that ctime
and mtime saved before doing a "cp" operation are the same as after.

Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
---
 fs/nfs/nfs42proc.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/nfs/nfs42proc.c b/fs/nfs/nfs42proc.c
index f77372a78be7..ea420dc94875 100644
--- a/fs/nfs/nfs42proc.c
+++ b/fs/nfs/nfs42proc.c
@@ -502,6 +502,12 @@ static ssize_t _nfs42_proc_copy(struct file *src,
 
 	nfs42_copy_dest_done(dst, pos_dst, res->write_res.count, oldsize_dst);
 	nfs_invalidate_atime(src_inode);
+	if (nfs_have_delegated_attributes(dst_inode)) {
+		nfs_update_delegated_mtime(dst_inode);
+		spin_lock(&dst_inode->i_lock);
+		nfs_set_cache_invalid(dst_inode, NFS_INO_INVALID_BLOCKS);
+		spin_unlock(&dst_inode->i_lock);
+	}
 	status = res->write_res.count;
 out:
 	if (args->sync)
-- 
2.52.0


