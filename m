Return-Path: <linux-nfs+bounces-18914-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +MogEgK8jmkWEQEAu9opvQ
	(envelope-from <linux-nfs+bounces-18914-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Feb 2026 06:52:02 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 07753133169
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Feb 2026 06:52:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 97DB63086791
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Feb 2026 05:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49083274B59;
	Fri, 13 Feb 2026 05:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ItMoBkkq"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C037B26D4C3
	for <linux-nfs@vger.kernel.org>; Fri, 13 Feb 2026 05:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770961898; cv=none; b=h7Xnniu+XOXQw/xMJ6pW+ZDT4R0JNigTktVltfXjDDCyGHSq8YXV66jOkMWhWa+L2/9IXekALq2kv/x+IjMRT9clSLZCer2MUj+xQguGqB872BfID13CRjh+uGOcNBPoE24G16OY4GvrlLxMkhkiRqRquJXd+S0PlOs3ggqRFfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770961898; c=relaxed/simple;
	bh=8DkBz+LDe0vWcQaiQfjGq3gTPU8y8dyPEHcSrr7tb/0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=cqRqYX/Hxadmvn3TBu+qyXdkaQih+PJ6tiSwQ3xMiEUINjnhlGLqLpNbQHaO+H2J5KUO3lEz2jVCnj1YhyO7AvcwY19Pr/ROBszI7I7KESgxBcxueeSxY6AXq7e3pwK0S643cAl5e/z2eL50XeWs8bniJHWdo4Qqf5U707oZoSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=ItMoBkkq; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20260213055134epoutp015275c03544129c8417c17c2f190102e3~TuHWuy5M02707127071epoutp01W
	for <linux-nfs@vger.kernel.org>; Fri, 13 Feb 2026 05:51:34 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20260213055134epoutp015275c03544129c8417c17c2f190102e3~TuHWuy5M02707127071epoutp01W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1770961894;
	bh=+fi7XhvBJA/4rcnBtM8yogDXj5mpCvXE4Mbm87A1wDE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ItMoBkkq5IrA8Ex59WnNNdjgMr1vhmXjJ0IHxPwpReoGvK3Hdqko9ISywXs9RAO+0
	 0vAwr/weEvNt+Eka+5v8rFFjs0HgPTAOvsk2lupNIASKeDJ9sEE4tVWTOuzr42e8PW
	 1rc6F22RsvwcCXGDohpWKqM/WqUEPUJyiecY7bAg=
Received: from epsnrtp03.localdomain (unknown [182.195.42.155]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPS id
	20260213055133epcas5p2bc20a1e513af52dc8ccc5c79fd94f8ea~TuHV5j2sM2327923279epcas5p2E;
	Fri, 13 Feb 2026 05:51:33 +0000 (GMT)
Received: from epcas5p3.samsung.com (unknown [182.195.38.90]) by
	epsnrtp03.localdomain (Postfix) with ESMTP id 4fC1WS1V73z3hhT7; Fri, 13 Feb
	2026 05:51:32 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20260213055131epcas5p1fdfcb9e38e3301e0f9f718a751a362f9~TuHUiimdv0793307933epcas5p1J;
	Fri, 13 Feb 2026 05:51:31 +0000 (GMT)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20260213055128epsmtip2f14b508cf8119d23c4449c8e45185d26~TuHRwQL8u2471724717epsmtip2Q;
	Fri, 13 Feb 2026 05:51:28 +0000 (GMT)
From: Kundan Kumar <kundan.kumar@samsung.com>
To: jaegeuk@kernel.org, chao@kernel.org, agruenba@redhat.com,
	trondmy@kernel.org, anna@kernel.org, hch@lst.de, brauner@kernel.org,
	jack@suse.cz, viro@zeniv.linux.org.uk, djwong@kernel.org, jlayton@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
	gfs2@lists.linux.dev, linux-nfs@vger.kernel.org, gost.dev@samsung.com,
	anuj20.g@samsung.com, vishak.g@samsung.com, joshi.k@samsung.com, Kundan
	Kumar <kundan.kumar@samsung.com>
Subject: [PATCH v2 2/4] f2fs: stop using writeback internals for
 dirty_exceeded checks
Date: Fri, 13 Feb 2026 11:16:32 +0530
Message-Id: <20260213054634.79785-3-kundan.kumar@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260213054634.79785-1-kundan.kumar@samsung.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260213055131epcas5p1fdfcb9e38e3301e0f9f718a751a362f9
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20260213055131epcas5p1fdfcb9e38e3301e0f9f718a751a362f9
References: <20260213054634.79785-1-kundan.kumar@samsung.com>
	<CGME20260213055131epcas5p1fdfcb9e38e3301e0f9f718a751a362f9@epcas5p1.samsung.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[samsung.com,none];
	R_DKIM_ALLOW(-0.20)[samsung.com:s=mail20170921];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	TAGGED_FROM(0.00)[bounces-18914-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[samsung.com:mid,samsung.com:dkim,samsung.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,lst.de:email];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kundan.kumar@samsung.com,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[samsung.com:+];
	PRECEDENCE_BULK(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 07753133169
X-Rspamd-Action: no action

Replace direct dereferences of dirty_exceeded with the core helper
bdi_wb_dirty_exceeded(), removing f2fs dependencies on writeback
internals.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Reviewed-by: Andreas Gruenbacher <agruenba@redhat.com>
Suggested-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Kundan Kumar <kundan.kumar@samsung.com>
Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
---
 fs/f2fs/node.c    | 4 ++--
 fs/f2fs/segment.h | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 482a362f2625..d450b282cc55 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -78,7 +78,7 @@ bool f2fs_available_free_memory(struct f2fs_sb_info *sbi, int type)
 		if (excess_cached_nats(sbi))
 			res = false;
 	} else if (type == DIRTY_DENTS) {
-		if (sbi->sb->s_bdi->wb.dirty_exceeded)
+		if (bdi_wb_dirty_exceeded(sbi->sb->s_bdi))
 			return false;
 		mem_size = get_pages(sbi, F2FS_DIRTY_DENTS);
 		res = mem_size < ((avail_ram * nm_i->ram_thresh / 100) >> 1);
@@ -119,7 +119,7 @@ bool f2fs_available_free_memory(struct f2fs_sb_info *sbi, int type)
 		res = false;
 #endif
 	} else {
-		if (!sbi->sb->s_bdi->wb.dirty_exceeded)
+		if (!bdi_wb_dirty_exceeded(sbi->sb->s_bdi))
 			return true;
 	}
 	return res;
diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
index 07dcbcbeb7c6..d7166f1f000a 100644
--- a/fs/f2fs/segment.h
+++ b/fs/f2fs/segment.h
@@ -1000,7 +1000,7 @@ static inline bool sec_usage_check(struct f2fs_sb_info *sbi, unsigned int secno)
  */
 static inline int nr_pages_to_skip(struct f2fs_sb_info *sbi, int type)
 {
-	if (sbi->sb->s_bdi->wb.dirty_exceeded)
+	if (bdi_wb_dirty_exceeded(sbi->sb->s_bdi))
 		return 0;
 
 	if (type == DATA)
-- 
2.25.1


