Return-Path: <linux-nfs+bounces-20830-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MFcVJ4Vz3WngeQkAu9opvQ
	(envelope-from <linux-nfs+bounces-20830-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 14 Apr 2026 00:51:49 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 37C4E3F411E
	for <lists+linux-nfs@lfdr.de>; Tue, 14 Apr 2026 00:51:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9F418301652B
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Apr 2026 22:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABCBC39B4A1;
	Mon, 13 Apr 2026 22:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fOsxfS09"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56BB3358367
	for <linux-nfs@vger.kernel.org>; Mon, 13 Apr 2026 22:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776120707; cv=none; b=tlvQ/J/YKtiXkPfmjC53cqvQryB3+Yto2ifQVfpefrHgNAotmKBTglIAhok7f81S0tkwiRcAT4gcX6wF+BBMH6ZRJW9TBWpt2oK1QnzKszeVd0sB66jJ41o7GAY9hFriGz6caCnkTjc1z/oBUk2YwnUWcca7g5iYygS57TAHapk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776120707; c=relaxed/simple;
	bh=pCl1aGimqx4jp6VSZdsV9FM1KOCfOfa4EjtcMAoZN6U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FE7vfLIU07hub5L6oGQhmhS8u/ga63mUbQgIne8IR7P/lKHy0rNPl4D5EXc/hoFkmJJJVkdMB2f0YhzWHmGueno8+kaGJ744LV39BXND9ztyiiab5RKoSXW0ZaJFymMJ6aOsBj4l9LAKlZgwM7AA1FMuCH7i7c7GVn0xRmkXQDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fOsxfS09; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776120705;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=/MSemWMPCVky0j62HEtelaJKijh2WpZN/g+H/jpSra0=;
	b=fOsxfS09V2ZD7t3l7dZpF7kiXqQvAAhCqLRBgwLxCJFX8vdLGu7gxdLbJh76seJ39RxyZq
	oh6tFADixov084dmffFi2BALjvDW1mMYPeE8BE52GJmKUBjMIPZLmwHA3DmPK7CRI5tH84
	Dj2a2C43W1MCtlM1hRBMbjuMCliFiKo=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-614-8g5Bvt1QPpK2jRLSRdnrwA-1; Mon,
 13 Apr 2026 18:51:44 -0400
X-MC-Unique: 8g5Bvt1QPpK2jRLSRdnrwA-1
X-Mimecast-MFC-AGG-ID: 8g5Bvt1QPpK2jRLSRdnrwA_1776120703
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 148B31800372;
	Mon, 13 Apr 2026 22:51:43 +0000 (UTC)
Received: from okorniev-mac.redhat.com (unknown [10.22.64.155])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5599B180049F;
	Mon, 13 Apr 2026 22:51:42 +0000 (UTC)
From: Olga Kornievskaia <okorniev@redhat.com>
To: trondmy@kernel.org,
	anna@kernel.org
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH v2 1/1] NFSv4.2: fix COPY attrs in presence of delegated timestamps
Date: Mon, 13 Apr 2026 18:51:41 -0400
Message-ID: <20260413225141.90956-1-okorniev@redhat.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-20830-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[okorniev@redhat.com,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TAGGED_RCPT(0.00)[linux-nfs];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 37C4E3F411E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

A similar to generic/407 test can be done with a COPY operation
instead of CLONE (reflink). And it leads to same problem that ctime
and mtime saved before doing a "cp" operation are the same as after.

Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
---
 fs/nfs/nfs42proc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/nfs/nfs42proc.c b/fs/nfs/nfs42proc.c
index 7b3ca68fb4bb..596866f3d049 100644
--- a/fs/nfs/nfs42proc.c
+++ b/fs/nfs/nfs42proc.c
@@ -502,6 +502,7 @@ static ssize_t _nfs42_proc_copy(struct file *src,
 
 	nfs42_copy_dest_done(dst, pos_dst, res->write_res.count, oldsize_dst);
 	nfs_invalidate_atime(src_inode);
+	nfs_update_delegated_mtime(dst_inode);
 	status = res->write_res.count;
 out:
 	if (args->sync)
-- 
2.52.0


