Return-Path: <linux-nfs+bounces-20943-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id k8ThDveZ4mkC8AAAu9opvQ
	(envelope-from <linux-nfs+bounces-20943-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Apr 2026 22:37:11 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8045F41E85C
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Apr 2026 22:37:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0BD83303A121
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Apr 2026 20:35:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C818B1C84AB;
	Fri, 17 Apr 2026 20:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aLegbY9u"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB372D73B8
	for <linux-nfs@vger.kernel.org>; Fri, 17 Apr 2026 20:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776458153; cv=none; b=pucyvZ28O6wEMEBWqu6qyRrQWLNK4GJ6a7xSFBidvw46s/d4C8wfd5hIwHCBBV8w9UzQjEw1gtKhYmQ8It4MymxzhJMZGR4V37YZp9P74LI4yYyOH6iUUU0rF3kiaA91nbZcBB3YAq6YGYqZSNv7J+5b6pvUWi0Y8Y/zMQZFhdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776458153; c=relaxed/simple;
	bh=9eHtg/dUPFfVjRXUU4psQ/1x9fZ20qYpopczXhkLl/A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lmDdDRelJyWj8pueyYAQRbVZobHoQh5aLXmjD3+WLoddffKo7p0VTs4PqDMqSWif+utIKdyhv1xhozAEiPUQVqzZdn1zRw7Sm8+fcbJnF+5dmhMBcxTM0e73I8Fwf4Ja1Z3e1GF46oiTCFeQYxcOK2k00mADuEgX5KOTxgUL2zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aLegbY9u; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776458151;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=rUSgvD5vnP0dmHwvqyX+f+RKTTrihLRjPlW0LCrCBNI=;
	b=aLegbY9uiPBuXA1pa8rwWR/ELVNZaT7RtpQ/1lwFOTppZZK/tcLoHbXCUxzwmMR/GlRNNb
	0qBwhNOsknSnpir26LLcH7bO7Bs5OlusycFCHY7L/Gh51cBpQJjDaNb8QAfpeSQCxQ/ATC
	vxhxqlQv9VdSoGOd6iJO2ZgGxJyOZJw=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-58-wBEMUu4eOFCBGO3hUE3tpA-1; Fri,
 17 Apr 2026 16:35:46 -0400
X-MC-Unique: wBEMUu4eOFCBGO3hUE3tpA-1
X-Mimecast-MFC-AGG-ID: wBEMUu4eOFCBGO3hUE3tpA_1776458145
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2FDF819560BB;
	Fri, 17 Apr 2026 20:35:45 +0000 (UTC)
Received: from okorniev-mac.redhat.com (unknown [10.22.81.224])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 71D191800357;
	Fri, 17 Apr 2026 20:35:44 +0000 (UTC)
From: Olga Kornievskaia <okorniev@redhat.com>
To: trondmy@kernel.org,
	anna@kernel.org
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH v5 1/1] NFSv4.2: fix CLONE/COPY attrs in presence of delegated attributes
Date: Fri, 17 Apr 2026 16:35:43 -0400
Message-ID: <20260417203543.39757-1-okorniev@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-20943-lists,linux-nfs=lfdr.de];
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
X-Rspamd-Queue-Id: 8045F41E85C
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

--v5 change nfs_update_delegated_mtime() placement
--v4 this version removes the need for having
"NFSv4.2: fix COPY attrs in presence of delegated timestamps"
---
 fs/nfs/nfs42proc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/nfs/nfs42proc.c b/fs/nfs/nfs42proc.c
index 7b3ca68fb4bb..6e195619a232 100644
--- a/fs/nfs/nfs42proc.c
+++ b/fs/nfs/nfs42proc.c
@@ -401,6 +401,7 @@ static void nfs42_copy_dest_done(struct file *file, loff_t pos, loff_t len,
 					     NFS_INO_INVALID_MTIME |
 					     NFS_INO_INVALID_BLOCKS);
 	spin_unlock(&inode->i_lock);
+	nfs_update_delegated_mtime(inode);
 }
 
 static ssize_t _nfs42_proc_copy(struct file *src,
-- 
2.52.0


