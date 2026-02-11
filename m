Return-Path: <linux-nfs+bounces-18877-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gIhqD4YqjGmFigAAu9opvQ
	(envelope-from <linux-nfs+bounces-18877-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Feb 2026 08:06:46 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AB5AC121C91
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Feb 2026 08:06:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 72AF83025C5B
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Feb 2026 07:06:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4ADC34D90E;
	Wed, 11 Feb 2026 07:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Rqm4prS3"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80C0834C981
	for <linux-nfs@vger.kernel.org>; Wed, 11 Feb 2026 07:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770793548; cv=none; b=MuLra1IHuTPX2NvqhwSU7a9QU40bPyZKf8zbw1JxJ/YaxEDMSlT2/1dvahXLq8uL2v47uouK+WvcfKmuyBs1n/3SKuIyr6iLeI9qMOGkG/k+a4CZ3VrEN+k3+EyBfbtSjbQaNhaalIdcHEFMFl8lwWKEh0idcEfsxvRuJ9sPEI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770793548; c=relaxed/simple;
	bh=djZiiRv4Atfe0TSz4MTf3POZZCovBo80N3X43c5UC2o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=YWcVjhomnylGJj+17+UeppuxTTDQFrLxuNaFA1BhncvepdR8AA47ld9gPC1EdGupTwnHQGFxxE/koakrunYPTs7sPSTlJYPL5Iki9XeDMYAHltLVkfAlsDmw4UrXP51xh+CwmffeNlp3pZ9qcEEVObhgOImN/jamTJ+Fa8tGM74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=Rqm4prS3; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20260211070539epoutp048ffec40b52a9d705439cd2aa342de74b~TH1edlVzN0340803408epoutp04h
	for <linux-nfs@vger.kernel.org>; Wed, 11 Feb 2026 07:05:39 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20260211070539epoutp048ffec40b52a9d705439cd2aa342de74b~TH1edlVzN0340803408epoutp04h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1770793539;
	bh=BF/a5V2IAl0CQ6EVXzXFAOoP6G59N24GE3IM1SlFR8I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Rqm4prS3JvFvBnhAHAlZW+81XvflSxaRZtvoTeqYOtyvBNmkKIOcc9+DanCwx1QJv
	 ujey0xlDsQWfVMS6hrz3kLfj/7UU7v5G+aFSQb7BMvXQDrGdzjZxdNEDBpI1shlsD8
	 dtQNU3H3uQR0YN8/NAku305i1yMutgyEg3m/2Cw0=
Received: from epsnrtp02.localdomain (unknown [182.195.42.154]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPS id
	20260211070538epcas5p1be00489644f05334d8d9ef50a4e4f4c5~TH1dpqVRp2433424334epcas5p1J;
	Wed, 11 Feb 2026 07:05:38 +0000 (GMT)
Received: from epcas5p2.samsung.com (unknown [182.195.38.94]) by
	epsnrtp02.localdomain (Postfix) with ESMTP id 4f9qFs5bzlz2SSKh; Wed, 11 Feb
	2026 07:05:37 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20260211070537epcas5p11bcbdc3d5ab68e1b9b7ec68feda22487~TH1cO4IxW2671026710epcas5p1J;
	Wed, 11 Feb 2026 07:05:37 +0000 (GMT)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20260211070534epsmtip2c653cdb90b99f4e1ceaad6e2f182b918~TH1ZWrf7i0195901959epsmtip2W;
	Wed, 11 Feb 2026 07:05:33 +0000 (GMT)
From: Kundan Kumar <kundan.kumar@samsung.com>
To: jaegeuk@kernel.org, chao@kernel.org, agruenba@redhat.com,
	trondmy@kernel.org, anna@kernel.org, hch@lst.de, brauner@kernel.org,
	jack@suse.cz, viro@zeniv.linux.org.uk, djwong@kernel.org,
	pankaj.raghav@linux.dev
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
	gfs2@lists.linux.dev, linux-nfs@vger.kernel.org, gost.dev@samsung.com,
	anuj20.g@samsung.com, vishak.g@samsung.com, joshi.k@samsung.com,
	mcgrof@kernel.org, Kundan Kumar <kundan.kumar@samsung.com>
Subject: [PATCH 1/4] writeback: prep helpers for dirty-limit and writeback
 accounting
Date: Wed, 11 Feb 2026 12:30:54 +0530
Message-Id: <20260211070057.22001-2-kundan.kumar@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260211070057.22001-1-kundan.kumar@samsung.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260211070537epcas5p11bcbdc3d5ab68e1b9b7ec68feda22487
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20260211070537epcas5p11bcbdc3d5ab68e1b9b7ec68feda22487
References: <20260211070057.22001-1-kundan.kumar@samsung.com>
	<CGME20260211070537epcas5p11bcbdc3d5ab68e1b9b7ec68feda22487@epcas5p1.samsung.com>
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
	RCPT_COUNT_TWELVE(0.00)[21];
	TAGGED_FROM(0.00)[bounces-18877-lists,linux-nfs=lfdr.de];
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
X-Rspamd-Queue-Id: AB5AC121C91
X-Rspamd-Action: no action

Add helper APIs needed by filesystems to avoid poking into writeback
internals.

Suggested-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Kundan Kumar <kundan.kumar@samsung.com>
Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
---
 include/linux/backing-dev.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/linux/backing-dev.h b/include/linux/backing-dev.h
index 0c8342747cab..4165ad3ddf00 100644
--- a/include/linux/backing-dev.h
+++ b/include/linux/backing-dev.h
@@ -78,6 +78,17 @@ static inline s64 wb_stat_sum(struct bdi_writeback *wb, enum wb_stat_item item)
 
 extern void wb_writeout_inc(struct bdi_writeback *wb);
 
+static inline int bdi_wb_dirty_exceeded(struct backing_dev_info *bdi)
+{
+	return bdi->wb.dirty_exceeded;
+}
+
+static inline void bdi_wb_stat_mod(struct backing_dev_info *bdi,
+				   enum wb_stat_item item, s64 amount)
+{
+	wb_stat_mod(&bdi->wb, item, amount);
+}
+
 /*
  * maximal error of a stat counter.
  */
-- 
2.25.1


