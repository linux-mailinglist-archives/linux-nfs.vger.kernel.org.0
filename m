Return-Path: <linux-nfs+bounces-18878-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cHZKM4kqjGmFigAAu9opvQ
	(envelope-from <linux-nfs+bounces-18878-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Feb 2026 08:06:49 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F35E121C98
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Feb 2026 08:06:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 79351307A385
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Feb 2026 07:06:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9333D34C981;
	Wed, 11 Feb 2026 07:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="vG2Z/AmV"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4116434D4CF
	for <linux-nfs@vger.kernel.org>; Wed, 11 Feb 2026 07:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770793550; cv=none; b=qf9LP5x8pQ9thfW9nA0KK+0ozP7kRBNpLIBb6gcT7SaNdHkNGYjVmFKm9kzoI4sxR4ycO+RQFhNyE0RByYWijdUNWocpRipvzKHnmbvQEQ2eDep7d0EP9DhxeS45/RZ72n3AnqYFdXn2l+BDcmqfbUQFeHFvX6K/HrkJc3TwTL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770793550; c=relaxed/simple;
	bh=TpVVBK8Q3EN3PZEIhIdwOba0ifpOdZlfesfY2OP6b4w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=HnnkQLXkklTXYmRiI7I6tHobkDGL25nixItfrq18FH9TknevNhzKgL7nZflZWJhXTs0f+b5MbO8nj2d1xPJX9aeRRK05HhT1E4peZThsHIA2CpYI2w7FF8lYs0Vrk8P19y/9KfIwqtrFfXMWw+AMeDzN3KOrYfeK+zh721XxBoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=vG2Z/AmV; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20260211070547epoutp0490c0b750ac917928632f0ec3b9f32f30~TH1lkK1_g0341003410epoutp04k
	for <linux-nfs@vger.kernel.org>; Wed, 11 Feb 2026 07:05:47 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20260211070547epoutp0490c0b750ac917928632f0ec3b9f32f30~TH1lkK1_g0341003410epoutp04k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1770793547;
	bh=h24FKhiaOy+Lutbyj9qFXxdAOruWVEGhaIk65WyfYFw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vG2Z/AmVmSMN84JJ+vsOkVuF7lFFsK0R5hYzz0oYPh1uoUuPMZ6QiNHtULXIteLpQ
	 WjKfPmY0665Xo2HoaNAMPa52J6w/xjlgnUHv0T8JCDzg/ptzMhXxKZ4bRyZcD8gQlN
	 6dKXWahYbbuid/Dc3pA82J+CQcGw4EidKrtpZq+k=
Received: from epsnrtp02.localdomain (unknown [182.195.42.154]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPS id
	20260211070544epcas5p4534cc829b35964b66e7e9dec40deae2f~TH1i76OZH3071530715epcas5p4t;
	Wed, 11 Feb 2026 07:05:44 +0000 (GMT)
Received: from epcas5p1.samsung.com (unknown [182.195.38.93]) by
	epsnrtp02.localdomain (Postfix) with ESMTP id 4f9qFz4rwrz2SSKf; Wed, 11 Feb
	2026 07:05:43 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20260211070543epcas5p44f11ea9b90ce0eb480e2b5ce0941559a~TH1hzeg-k3071530715epcas5p4i;
	Wed, 11 Feb 2026 07:05:43 +0000 (GMT)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20260211070540epsmtip2df267b8ed7e5bbd98bb7dfe147df4c7a~TH1fKMRAL0204902049epsmtip2K;
	Wed, 11 Feb 2026 07:05:40 +0000 (GMT)
From: Kundan Kumar <kundan.kumar@samsung.com>
To: jaegeuk@kernel.org, chao@kernel.org, agruenba@redhat.com,
	trondmy@kernel.org, anna@kernel.org, hch@lst.de, brauner@kernel.org,
	jack@suse.cz, viro@zeniv.linux.org.uk, djwong@kernel.org,
	pankaj.raghav@linux.dev
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
	gfs2@lists.linux.dev, linux-nfs@vger.kernel.org, gost.dev@samsung.com,
	anuj20.g@samsung.com, vishak.g@samsung.com, joshi.k@samsung.com,
	mcgrof@kernel.org, Kundan Kumar <kundan.kumar@samsung.com>
Subject: [PATCH 3/4] gfs2: stop using writeback internals for dirty_exceeded
 check
Date: Wed, 11 Feb 2026 12:30:56 +0530
Message-Id: <20260211070057.22001-4-kundan.kumar@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260211070057.22001-1-kundan.kumar@samsung.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260211070543epcas5p44f11ea9b90ce0eb480e2b5ce0941559a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20260211070543epcas5p44f11ea9b90ce0eb480e2b5ce0941559a
References: <20260211070057.22001-1-kundan.kumar@samsung.com>
	<CGME20260211070543epcas5p44f11ea9b90ce0eb480e2b5ce0941559a@epcas5p4.samsung.com>
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
	TAGGED_FROM(0.00)[bounces-18878-lists,linux-nfs=lfdr.de];
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
X-Rspamd-Queue-Id: 8F35E121C98
X-Rspamd-Action: no action

Convert gfs2 dirty_exceeded handling to use the writeback core helper
instead of accessing writeback directly.

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


