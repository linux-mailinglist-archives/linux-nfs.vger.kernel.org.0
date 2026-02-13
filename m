Return-Path: <linux-nfs+bounces-18915-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iEaNMAK8jmknEQEAu9opvQ
	(envelope-from <linux-nfs+bounces-18915-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Feb 2026 06:52:02 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FC9C13316B
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Feb 2026 06:52:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A6EB9302D530
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Feb 2026 05:51:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ABBD27874F;
	Fri, 13 Feb 2026 05:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="EN9aElZA"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C84AC26E173
	for <linux-nfs@vger.kernel.org>; Fri, 13 Feb 2026 05:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770961898; cv=none; b=Bz13STT13g7eG/S9REefRepaNXPJn+w9+wJjAwArHakv7+lVL//TDax9KO2bn38a0RZ1LEAzyBMCl7Z74RiynvEvn9ysg+mdGDXxE2VyQ4rjUz8ggPErIPO/ZAkVJPQafFlaJpA2DxNoAD0GteJmIVEsyyLEGMZxRKyc4VT4ypE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770961898; c=relaxed/simple;
	bh=wQWIr+CWGB+z47NEiJyXgIVKlRtwG2/3Z60WkHTEQ2s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=iSih05bVp4nOG4WBEd+hRJzmWMyYyqtg4jRt6q9mkc8l2ZRDBPYIrl+8HMSLgalABkbEhKDFiTbLPgxdQDhrP4c2C8wZBsiArsTjySFazfF+N6QK4/hZ5tywjLNhtIazYXnIt5BA26OLMVE1fF017NVOpjoXL4E78npe1bg7X/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=EN9aElZA; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20260213055133epoutp0242fcb325aa32f48f6feef4341885d4c1~TuHWd0FAz3182431824epoutp02y
	for <linux-nfs@vger.kernel.org>; Fri, 13 Feb 2026 05:51:33 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20260213055133epoutp0242fcb325aa32f48f6feef4341885d4c1~TuHWd0FAz3182431824epoutp02y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1770961893;
	bh=azX7HNGdMHPiAlnAiQeuCQh9Wq2SAgq9ch93GVn8UK8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EN9aElZAQxIyB4n8Pa2DGWReaHupTLRwpMdNjzX2DHAxiQj9eD2Eb5PegbFcF7lPl
	 eoddUb+xpO8B5rFKJBBsR6vKT8oTrssnbiRAxYRIMro7ktDiuMsRgX6J7WxzuqIAmW
	 6CT5nfiEQKyShMv23YYmy5xVyHoDHIvfqTRGG3Mg=
Received: from epsnrtp04.localdomain (unknown [182.195.42.156]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPS id
	20260213055133epcas5p1a2d1507d8072b3f6d79ee3da36344158~TuHV1YxhF0793407934epcas5p1K;
	Fri, 13 Feb 2026 05:51:33 +0000 (GMT)
Received: from epcas5p1.samsung.com (unknown [182.195.38.91]) by
	epsnrtp04.localdomain (Postfix) with ESMTP id 4fC1WP1XTCz6B9mB; Fri, 13 Feb
	2026 05:51:29 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20260213055128epcas5p485b1d6ad7d811fa71e0e61e6c0a608eb~TuHRc2CNu2345423454epcas5p4R;
	Fri, 13 Feb 2026 05:51:28 +0000 (GMT)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20260213055124epsmtip2c23bb158484bad0746e1e08e0f3f6bb1~TuHNnkB8M2587625876epsmtip2p;
	Fri, 13 Feb 2026 05:51:23 +0000 (GMT)
From: Kundan Kumar <kundan.kumar@samsung.com>
To: jaegeuk@kernel.org, chao@kernel.org, agruenba@redhat.com,
	trondmy@kernel.org, anna@kernel.org, hch@lst.de, brauner@kernel.org,
	jack@suse.cz, viro@zeniv.linux.org.uk, djwong@kernel.org, jlayton@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
	gfs2@lists.linux.dev, linux-nfs@vger.kernel.org, gost.dev@samsung.com,
	anuj20.g@samsung.com, vishak.g@samsung.com, joshi.k@samsung.com, Kundan
	Kumar <kundan.kumar@samsung.com>
Subject: [PATCH v2 1/4] writeback: prep helpers for dirty-limit and
 writeback accounting
Date: Fri, 13 Feb 2026 11:16:31 +0530
Message-Id: <20260213054634.79785-2-kundan.kumar@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260213054634.79785-1-kundan.kumar@samsung.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260213055128epcas5p485b1d6ad7d811fa71e0e61e6c0a608eb
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20260213055128epcas5p485b1d6ad7d811fa71e0e61e6c0a608eb
References: <20260213054634.79785-1-kundan.kumar@samsung.com>
	<CGME20260213055128epcas5p485b1d6ad7d811fa71e0e61e6c0a608eb@epcas5p4.samsung.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[samsung.com,none];
	R_DKIM_ALLOW(-0.20)[samsung.com:s=mail20170921];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	TAGGED_FROM(0.00)[bounces-18915-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[samsung.com:mid,samsung.com:dkim,samsung.com:email,suse.cz:email,lst.de:email];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kundan.kumar@samsung.com,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[samsung.com:+];
	PRECEDENCE_BULK(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 2FC9C13316B
X-Rspamd-Action: no action

Add helper APIs needed by filesystems to avoid poking into writeback
internals.

Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Reviewed-by: Andreas Gruenbacher <agruenba@redhat.com>
Suggested-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Kundan Kumar <kundan.kumar@samsung.com>
Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
---
 include/linux/backing-dev.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/include/linux/backing-dev.h b/include/linux/backing-dev.h
index 0c8342747cab..5b7d12b40d5e 100644
--- a/include/linux/backing-dev.h
+++ b/include/linux/backing-dev.h
@@ -136,6 +136,19 @@ static inline bool mapping_can_writeback(struct address_space *mapping)
 	return inode_to_bdi(mapping->host)->capabilities & BDI_CAP_WRITEBACK;
 }
 
+/* Must not be used by file systems that support cgroup writeback */
+static inline int bdi_wb_dirty_exceeded(struct backing_dev_info *bdi)
+{
+	return bdi->wb.dirty_exceeded;
+}
+
+/* Must not be used by file systems that support cgroup writeback */
+static inline void bdi_wb_stat_mod(struct inode *inode, enum wb_stat_item item,
+				   s64 amount)
+{
+	wb_stat_mod(&inode_to_bdi(inode)->wb, item, amount);
+}
+
 #ifdef CONFIG_CGROUP_WRITEBACK
 
 struct bdi_writeback *wb_get_lookup(struct backing_dev_info *bdi,
-- 
2.25.1


