Return-Path: <linux-nfs+bounces-22825-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 8ku7G9CePGpqpwgAu9opvQ
	(envelope-from <linux-nfs+bounces-22825-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Jun 2026 05:21:52 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 140B76C2909
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Jun 2026 05:21:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=Ulslqdok;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22825-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22825-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AD39C302E430
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Jun 2026 03:21:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8379D176238;
	Thu, 25 Jun 2026 03:21:47 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 845D6269B1C
	for <linux-nfs@vger.kernel.org>; Thu, 25 Jun 2026 03:21:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782357707; cv=none; b=SCumtxn69Nn+Iyf3CA6ead2FMEv3yptUr/qPPN8pi4igoD+nyckw6VsNM8nef4DAsy5No4VEoXD2Mj1xOXUZc+S3Rt9ab6E5ctmIkmglKhi4gxafzalJeWOHl3asa35kuhEezunutfficVR3wdETOKd1yXdd5tVhVaUHWsi+yy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782357707; c=relaxed/simple;
	bh=7fe5YUQelrz99no22IDrBvfMH2KB987+xVQctm+LpQQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qfmZMRoaw+evceLsVwPznnqNoth1thRCOzpO5wiHXdNFUuPVsSSuXjydgjqmblYOSUTIBGhMva8Z6kHp9rM8x98MghyWf0/ph/duaJ5BoyvXPSLXECQdfNkXo/i43ipTUoxZXm80rJxryORIaLz2D2A/CmzXkrljvwt7iKIcxjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Ulslqdok; arc=none smtp.client-ip=95.215.58.171
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782357703;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Qf+3UnoDvVCpaNzggO2d5gHMeWx7PRDz/tRLqXgBv0E=;
	b=UlslqdokznXe6aw9N+41HmJwagL2YWuLeychpnv1/IGvkZh0VQAXkelcCKPLu6HxB0rsiO
	ja7SkdfZwYQ38Wt6q3cGR3wRnEB2CTaPDNxbeigRhBymwcqWnmm3uaI/aQ2rDotGxjHwCt
	LH/PlPJqH7gxAvmYTDX1Mmad5YSW7ZI=
From: zhang.guodong@linux.dev
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	ZhangGuoDong <zhangguodong@kylinos.cn>
Subject: [PATCH 2/2] pnfs/blocklayout: Fix device leaks on parse failure
Date: Thu, 25 Jun 2026 11:20:38 +0800
Message-ID: <20260625032038.11535-2-zhang.guodong@linux.dev>
In-Reply-To: <20260625032038.11535-1-zhang.guodong@linux.dev>
References: <20260625032038.11535-1-zhang.guodong@linux.dev>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:trondmy@kernel.org,m:anna@kernel.org,m:linux-nfs@vger.kernel.org,m:zhangguodong@kylinos.cn,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-22825-lists,linux-nfs=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[zhang.guodong@linux.dev,linux-nfs@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhang.guodong@linux.dev,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-nfs];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,linux.dev:dkim,linux.dev:mid,linux.dev:from_mime,kylinos.cn:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 140B76C2909

From: ZhangGuoDong <zhangguodong@kylinos.cn>

bl_parse_concat() and bl_parse_stripe() allocate a child device array and
then parse each child in turn.  If parsing a child fails, the failed child is
not counted in nr_children and the parent may be left with a children array
that bl_free_device() will not release when nr_children is zero.

Release the failed child and the already parsed children before returning the
error.  Also make bl_free_device() release the child array whenever the
children pointer is set, so that partially initialised concat or stripe
devices are cleaned up correctly.

bl_parse_scsi() can also fail after assigning d->bdev_file and dropping the
file reference.  Clear the pointer after fput() so that an outer cleanup path
does not put it again.

Signed-off-by: ZhangGuoDong <zhangguodong@kylinos.cn>
---
 fs/nfs/blocklayout/dev.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/fs/nfs/blocklayout/dev.c b/fs/nfs/blocklayout/dev.c
index bb35f8850..db4bb0a62 100644
--- a/fs/nfs/blocklayout/dev.c
+++ b/fs/nfs/blocklayout/dev.c
@@ -85,15 +85,17 @@ bl_free_device(struct pnfs_block_dev *dev)
 {
 	bl_unregister_dev(dev);
 
-	if (dev->nr_children) {
+	if (dev->children) {
 		int i;
 
 		for (i = 0; i < dev->nr_children; i++)
 			bl_free_device(&dev->children[i]);
 		kfree(dev->children);
-	} else {
-		if (dev->bdev_file)
-			fput(dev->bdev_file);
+		dev->children = NULL;
+		dev->nr_children = 0;
+	} else if (dev->bdev_file) {
+		fput(dev->bdev_file);
+		dev->bdev_file = NULL;
 	}
 }
 
@@ -437,6 +439,7 @@ bl_parse_scsi(struct nfs_server *server, struct pnfs_block_dev *d,
 
 out_blkdev_put:
 	fput(d->bdev_file);
+	d->bdev_file = NULL;
 	return error;
 }
 
@@ -472,8 +475,11 @@ bl_parse_concat(struct nfs_server *server, struct pnfs_block_dev *d,
 	for (i = 0; i < v->concat.volumes_count; i++) {
 		ret = bl_parse_deviceid(server, &d->children[i],
 				volumes, v->concat.volumes[i], gfp_mask);
-		if (ret)
+		if (ret) {
+			bl_free_device(&d->children[i]);
+			bl_free_device(d);
 			return ret;
+		}
 
 		d->nr_children++;
 		d->children[i].start += len;
@@ -501,8 +507,11 @@ bl_parse_stripe(struct nfs_server *server, struct pnfs_block_dev *d,
 	for (i = 0; i < v->stripe.volumes_count; i++) {
 		ret = bl_parse_deviceid(server, &d->children[i],
 				volumes, v->stripe.volumes[i], gfp_mask);
-		if (ret)
+		if (ret) {
+			bl_free_device(&d->children[i]);
+			bl_free_device(d);
 			return ret;
+		}
 
 		d->nr_children++;
 		len += d->children[i].len;
-- 
2.43.0


