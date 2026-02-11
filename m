Return-Path: <linux-nfs+bounces-18876-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YGfdBXQqjGmsigAAu9opvQ
	(envelope-from <linux-nfs+bounces-18876-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Feb 2026 08:06:28 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B2294121C8A
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Feb 2026 08:06:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 91391304299E
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Feb 2026 07:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12CBA32E6BA;
	Wed, 11 Feb 2026 07:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="LMvy3gUv"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8234C34EF0B
	for <linux-nfs@vger.kernel.org>; Wed, 11 Feb 2026 07:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770793546; cv=none; b=C5cZh/9Dkd1K0sdIm1OMr0n6nFvx4+M8eTilhkiRHX63cbChJm8dm2JihtJGeMhZK0Z+UVTMEVQkpoag82y0hgGKjD6jvmGswcTbbSxNcjtl9EfwOLi9rPCjNWiu7p/W3QMPBIHHl6p6k6bnLa+KO6tAwpz7T2Vx2E4O7EumS5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770793546; c=relaxed/simple;
	bh=M1NRjmEMDyy+oOgvl+VQv+6y7EvEZ/LU64AnDJ077DQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=AN1L8wJbBE494yqfjyeaK4kEJTK8awMT7riyXJaMym3+DvNHLuvNL0DkW7NMDvWhQDQXOMtofr9BuNdfWWd0KaY1pZ6syZ5vxvjnux/q3IzDf50gIa4QLOICUnX8+hCHw++fGPnXtU2Wuy9mSHTfhim4AgH1eKmu5DAd3AzatLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=LMvy3gUv; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20260211070542epoutp037fd694b1f3b935987fc39e55fdd6aa98~TH1gphX1W2858228582epoutp03k
	for <linux-nfs@vger.kernel.org>; Wed, 11 Feb 2026 07:05:41 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20260211070542epoutp037fd694b1f3b935987fc39e55fdd6aa98~TH1gphX1W2858228582epoutp03k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1770793542;
	bh=edeVYa6HjHZ4mu4TNinC+G+5M3aq+ckeGzSwrEoltMw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LMvy3gUvCJf/1DJaXIxfPG1cRevV5P4rAjpge+evgwIifTEksyawHm4a+gn35ta/E
	 owRP/ZQMK01O1dDKzMzZMSQ5a6T9B6mojpdsSE9y7SZTXEzgYqHFiDVnKy2M65N/C9
	 zg0ub7EQvBLwn2n3xvDTUlK9iICuT7ZlPO4msXx4=
Received: from epsnrtp04.localdomain (unknown [182.195.42.156]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPS id
	20260211070541epcas5p22ea11564e42c12bf2d2a7997c38e4772~TH1gGnm850532905329epcas5p2P;
	Wed, 11 Feb 2026 07:05:41 +0000 (GMT)
Received: from epcas5p2.samsung.com (unknown [182.195.38.89]) by
	epsnrtp04.localdomain (Postfix) with ESMTP id 4f9qFw3zKpz6B9m5; Wed, 11 Feb
	2026 07:05:40 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20260211070540epcas5p3ba81064a4695a85d47735158b49f16e7~TH1e6Q9yM1263912639epcas5p3N;
	Wed, 11 Feb 2026 07:05:40 +0000 (GMT)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20260211070537epsmtip2d73bad556e4e9fae0a3866bd2089ad7c~TH1cP-LPZ0195901959epsmtip2X;
	Wed, 11 Feb 2026 07:05:37 +0000 (GMT)
From: Kundan Kumar <kundan.kumar@samsung.com>
To: jaegeuk@kernel.org, chao@kernel.org, agruenba@redhat.com,
	trondmy@kernel.org, anna@kernel.org, hch@lst.de, brauner@kernel.org,
	jack@suse.cz, viro@zeniv.linux.org.uk, djwong@kernel.org,
	pankaj.raghav@linux.dev
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
	gfs2@lists.linux.dev, linux-nfs@vger.kernel.org, gost.dev@samsung.com,
	anuj20.g@samsung.com, vishak.g@samsung.com, joshi.k@samsung.com,
	mcgrof@kernel.org, Kundan Kumar <kundan.kumar@samsung.com>
Subject: [PATCH 2/4] f2fs: stop using writeback internals for dirty_exceeded
 checks
Date: Wed, 11 Feb 2026 12:30:55 +0530
Message-Id: <20260211070057.22001-3-kundan.kumar@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260211070057.22001-1-kundan.kumar@samsung.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260211070540epcas5p3ba81064a4695a85d47735158b49f16e7
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20260211070540epcas5p3ba81064a4695a85d47735158b49f16e7
References: <20260211070057.22001-1-kundan.kumar@samsung.com>
	<CGME20260211070540epcas5p3ba81064a4695a85d47735158b49f16e7@epcas5p3.samsung.com>
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
	TAGGED_FROM(0.00)[bounces-18876-lists,linux-nfs=lfdr.de];
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
X-Rspamd-Queue-Id: B2294121C8A
X-Rspamd-Action: no action

Replace direct dereferences of dirty_exceeded with the core helper
bdi_wb_dirty_exceeded(), removing f2fs dependencies on writeback
internals.

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


