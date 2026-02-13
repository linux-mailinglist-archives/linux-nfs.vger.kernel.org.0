Return-Path: <linux-nfs+bounces-18916-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qP63LSS8jmkWEQEAu9opvQ
	(envelope-from <linux-nfs+bounces-18916-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Feb 2026 06:52:36 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E00B9133190
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Feb 2026 06:52:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1C27430152CD
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Feb 2026 05:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E34D274B44;
	Fri, 13 Feb 2026 05:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="U02feq5O"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD0727FD45
	for <linux-nfs@vger.kernel.org>; Fri, 13 Feb 2026 05:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770961902; cv=none; b=ckT7WCs1yPCec0Gz4b8Q9D+c9vOlDkznQcZqpKq0jKyd1zXqUQwReVKoRwSWGqoM//p48F0wp5s+7QLeXoLSFOEFbcshwcMAcszVhKJ7YAAVI1nevbTFsei0BpN/iP9AZLotAr4R9XAQRHEAqRnSuEXmHMIb1H8+2oZaO3GY9Jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770961902; c=relaxed/simple;
	bh=/fK1jbngMa6/JqpfIDNdSzD4oX+xXtcOum67V4za5Oo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=aulcVqTfoV8hySgU80/YCae/43xhrQFEf4r8Xo7wX8xLMUsFD9+E0h96hdtdig1qfrDpPxz+ieaLFyAnYT1XR4oRGpLrG/Cp/8+6pQdDjjLnnclxJ9BS0kGRp4CPvSVJIyv2Ph3H9Krr/JfD5i+i39V9vvplNld7LyQnUNmZW6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=U02feq5O; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20260213055138epoutp043d0a4acd610568343dcbb9e153922123~TuHa_dj4x1088410884epoutp04L
	for <linux-nfs@vger.kernel.org>; Fri, 13 Feb 2026 05:51:38 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20260213055138epoutp043d0a4acd610568343dcbb9e153922123~TuHa_dj4x1088410884epoutp04L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1770961898;
	bh=GDVcAGbX+6+fS68q52mUWNCiGdwubcd88imzb/VPBgA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=U02feq5OZn+prBrZ000m3xY3Q7QnAOuiFmLpupV/9E5QYUsvmsjVgQidPaarY+R91
	 dcpYqLoGcAJMNaaYzHFpml2wIcn/kJK94lcNyANF+RzNcX8VXwykYFbOZkOJ3wO1t8
	 ty1HtwnJCiXyi8r8xjIgPP+WJpQvfv5o44yV+yto=
Received: from epsnrtp03.localdomain (unknown [182.195.42.155]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPS id
	20260213055138epcas5p2cff9e249420c9e1e49533df5ec6b97a5~TuHaeL41X0260502605epcas5p2D;
	Fri, 13 Feb 2026 05:51:38 +0000 (GMT)
Received: from epcas5p4.samsung.com (unknown [182.195.38.87]) by
	epsnrtp03.localdomain (Postfix) with ESMTP id 4fC1WY09tSz3hhTJ; Fri, 13 Feb
	2026 05:51:37 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20260213055136epcas5p2f13881eb387cff40137199086e06f965~TuHY1bZy32327923279epcas5p2L;
	Fri, 13 Feb 2026 05:51:36 +0000 (GMT)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20260213055131epsmtip21d249fe955d6286e5d3a1f88d5825e9f~TuHUyS2XA2622126221epsmtip2D;
	Fri, 13 Feb 2026 05:51:31 +0000 (GMT)
From: Kundan Kumar <kundan.kumar@samsung.com>
To: jaegeuk@kernel.org, chao@kernel.org, agruenba@redhat.com,
	trondmy@kernel.org, anna@kernel.org, hch@lst.de, brauner@kernel.org,
	jack@suse.cz, viro@zeniv.linux.org.uk, djwong@kernel.org, jlayton@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
	gfs2@lists.linux.dev, linux-nfs@vger.kernel.org, gost.dev@samsung.com,
	anuj20.g@samsung.com, vishak.g@samsung.com, joshi.k@samsung.com, Kundan
	Kumar <kundan.kumar@samsung.com>
Subject: [PATCH v2 3/4] gfs2: stop using writeback internals for
 dirty_exceeded check
Date: Fri, 13 Feb 2026 11:16:33 +0530
Message-Id: <20260213054634.79785-4-kundan.kumar@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260213054634.79785-1-kundan.kumar@samsung.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260213055136epcas5p2f13881eb387cff40137199086e06f965
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20260213055136epcas5p2f13881eb387cff40137199086e06f965
References: <20260213054634.79785-1-kundan.kumar@samsung.com>
	<CGME20260213055136epcas5p2f13881eb387cff40137199086e06f965@epcas5p2.samsung.com>
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
	TAGGED_FROM(0.00)[bounces-18916-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[samsung.com:mid,samsung.com:dkim,samsung.com:email,lst.de:email];
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
X-Rspamd-Queue-Id: E00B9133190
X-Rspamd-Action: no action

Convert gfs2 dirty_exceeded handling to use the writeback core helper
instead of accessing writeback directly.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Reviewed-by: Andreas Gruenbacher <agruenba@redhat.com>
Suggested-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Kundan Kumar <kundan.kumar@samsung.com>
Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
---
 fs/gfs2/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/gfs2/super.c b/fs/gfs2/super.c
index f6cd907b3ec6..7ddeee19dec4 100644
--- a/fs/gfs2/super.c
+++ b/fs/gfs2/super.c
@@ -447,7 +447,7 @@ static int gfs2_write_inode(struct inode *inode, struct writeback_control *wbc)
 		gfs2_log_flush(GFS2_SB(inode), ip->i_gl,
 			       GFS2_LOG_HEAD_FLUSH_NORMAL |
 			       GFS2_LFC_WRITE_INODE);
-	if (bdi->wb.dirty_exceeded)
+	if (bdi_wb_dirty_exceeded(bdi))
 		gfs2_ail1_flush(sdp, wbc);
 	else
 		filemap_fdatawrite(metamapping);
-- 
2.25.1


