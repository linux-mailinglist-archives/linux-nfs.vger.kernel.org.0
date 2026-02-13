Return-Path: <linux-nfs+bounces-18917-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ODTCAz68jmkWEQEAu9opvQ
	(envelope-from <linux-nfs+bounces-18917-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Feb 2026 06:53:02 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 803251331AC
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Feb 2026 06:53:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E115A30A8CAB
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Feb 2026 05:51:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43BD326CE2B;
	Fri, 13 Feb 2026 05:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="sR5Bd++N"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA58626E173
	for <linux-nfs@vger.kernel.org>; Fri, 13 Feb 2026 05:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770961909; cv=none; b=u+IqvCsfHA1llSySgX8XFUYrsW5SaAQUG9bso2L5y7UTGelAe+YRlb2HfV15voFsFrMvCmMeb2C4dBq4sV0RW9fQ8234OsEG9imaJK+K11FmS91lM+Tq4Mlm4p+qDmVKcFcFfOVJ/S3Bw6LLkRjZFG8qEag6I+U72j4kvGY3NRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770961909; c=relaxed/simple;
	bh=j+bCGXMTmziZDXXtEy5hW+Hxg9b93ucLfIZcyJ7PM6g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=bGNtSG0d51Ml7H3hpYEyWkEnXy1Ncyz7D4CRhe0HOidOfymoD5rjz3C28/g2mfEtvToVj6B9LFRAxD18ze4aVwZgTU18ArM7KdiFK6+ebroSYGdqG8P39pPu5/TsrwTIJvxZf2L37BSVHW7OKZloDO8AbQVfXZa7eCNuE+jW730=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=sR5Bd++N; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20260213055145epoutp021ee30d9001d3f6e815466d9d95e56fce~TuHhrfdMB3228632286epoutp02e
	for <linux-nfs@vger.kernel.org>; Fri, 13 Feb 2026 05:51:45 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20260213055145epoutp021ee30d9001d3f6e815466d9d95e56fce~TuHhrfdMB3228632286epoutp02e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1770961905;
	bh=WVUkVxdLZh7dLWtrxwE5uvhOTSw4xvRRD2G/b4/jnPQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sR5Bd++N6xGlqfBAAQiW4PWY+ytP+oZxAcdXOEaUOH6XAZb1QkXjhFn4p88p7fSQp
	 IgW4+oU4mBdLfnk6XE2hKG56ZHj1qHTbApD7vuAr2A7jSdX/EN3ss1wPf4YyS9iNad
	 ATftZG7KD0BUsolWwXrEw1qL9TWSqOL+eBeNyUQw=
Received: from epsnrtp04.localdomain (unknown [182.195.42.156]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPS id
	20260213055145epcas5p4af1fac07bbabbaf11e521102bd53c538~TuHhJu_df2583525835epcas5p4U;
	Fri, 13 Feb 2026 05:51:45 +0000 (GMT)
Received: from epcas5p3.samsung.com (unknown [182.195.38.88]) by
	epsnrtp04.localdomain (Postfix) with ESMTP id 4fC1Wd1twtz6B9m5; Fri, 13 Feb
	2026 05:51:41 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20260213055140epcas5p31b62f7026bd30c79f804c8c0fc02e276~TuHcw1i4J2435024350epcas5p3_;
	Fri, 13 Feb 2026 05:51:40 +0000 (GMT)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20260213055136epsmtip2f67a407f2147b68c7ca6a288c6a4ead3~TuHZIiX9u2622126221epsmtip2G;
	Fri, 13 Feb 2026 05:51:36 +0000 (GMT)
From: Kundan Kumar <kundan.kumar@samsung.com>
To: jaegeuk@kernel.org, chao@kernel.org, agruenba@redhat.com,
	trondmy@kernel.org, anna@kernel.org, hch@lst.de, brauner@kernel.org,
	jack@suse.cz, viro@zeniv.linux.org.uk, djwong@kernel.org, jlayton@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
	gfs2@lists.linux.dev, linux-nfs@vger.kernel.org, gost.dev@samsung.com,
	anuj20.g@samsung.com, vishak.g@samsung.com, joshi.k@samsung.com, Kundan
	Kumar <kundan.kumar@samsung.com>
Subject: [PATCH v2 4/4] nfs: stop using writeback internals for WB_WRITEBACK
 accounting
Date: Fri, 13 Feb 2026 11:16:34 +0530
Message-Id: <20260213054634.79785-5-kundan.kumar@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260213054634.79785-1-kundan.kumar@samsung.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260213055140epcas5p31b62f7026bd30c79f804c8c0fc02e276
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20260213055140epcas5p31b62f7026bd30c79f804c8c0fc02e276
References: <20260213054634.79785-1-kundan.kumar@samsung.com>
	<CGME20260213055140epcas5p31b62f7026bd30c79f804c8c0fc02e276@epcas5p3.samsung.com>
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
	TAGGED_FROM(0.00)[bounces-18917-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,samsung.com:mid,samsung.com:dkim,samsung.com:email,lst.de:email];
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
X-Rspamd-Queue-Id: 803251331AC
X-Rspamd-Action: no action

Convert NFS WB_WRITEBACK accounting to writeback helper, eliminating
direct access to writeback.

Suggested-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Kundan Kumar <kundan.kumar@samsung.com>
Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
---
 fs/nfs/internal.h | 2 +-
 fs/nfs/write.c    | 3 +--
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index 2e596244799f..96249d6d9132 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -866,7 +866,7 @@ static inline void nfs_folio_mark_unstable(struct folio *folio,
 		 * writeback is happening on the server now.
 		 */
 		node_stat_mod_folio(folio, NR_WRITEBACK, nr);
-		wb_stat_mod(&inode_to_bdi(inode)->wb, WB_WRITEBACK, nr);
+		bdi_wb_stat_mod(inode, WB_WRITEBACK, nr);
 		__mark_inode_dirty(inode, I_DIRTY_DATASYNC);
 	}
 }
diff --git a/fs/nfs/write.c b/fs/nfs/write.c
index bf412455e8ed..9053e0c4a836 100644
--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -872,8 +872,7 @@ static void nfs_folio_clear_commit(struct folio *folio)
 		long nr = folio_nr_pages(folio);
 
 		node_stat_mod_folio(folio, NR_WRITEBACK, -nr);
-		wb_stat_mod(&inode_to_bdi(folio->mapping->host)->wb,
-			    WB_WRITEBACK, -nr);
+		bdi_wb_stat_mod(folio->mapping->host, WB_WRITEBACK, -nr);
 	}
 }
 
-- 
2.25.1


