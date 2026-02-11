Return-Path: <linux-nfs+bounces-18879-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cMaiMJMqjGmqigAAu9opvQ
	(envelope-from <linux-nfs+bounces-18879-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Feb 2026 08:06:59 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4749C121C9F
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Feb 2026 08:06:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 19092307DFFF
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Feb 2026 07:06:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F313350281;
	Wed, 11 Feb 2026 07:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="WWUr6nZc"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BAA91FC0EF
	for <linux-nfs@vger.kernel.org>; Wed, 11 Feb 2026 07:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770793551; cv=none; b=HSPPR/kM2C0cwDP49aeZaxn3tYO39XhCuhwKcjEi+Ib0BNVzsgYoE43BzN6sMy+Jm1nK1wuIQFPyzqp+CWwPwVRKXz21rIL9BROLJa8ZTmGi4HTQCEOzoMsxzzWxEVBzcoDF8wB3/K9SuFZHNFOeQQQb3SLjderZ/uK00VnWs40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770793551; c=relaxed/simple;
	bh=HA3V9wjv2k47ahT8HxVZRWsPsA1moBTdIeFNk9xDkW4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=NYkR1vJZ44xNmecoZraYnG6iKplk8ch0WjFmUAZlI0X+Ws5adUK+yvamu8CkaY4Rqwk52MevTWlwj/miwBzB2E2baMxwWCNYrUjbhRxRptu4J8NL9cyvLejF14N31S2VNOFPtqmzEnjftHpIkcDgnBu/WGOTdnQAeFo7E74+nW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=WWUr6nZc; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20260211070548epoutp041386ab923dc83977d237bcf8ddf8843f~TH1mZjn8k0334503345epoutp04y
	for <linux-nfs@vger.kernel.org>; Wed, 11 Feb 2026 07:05:48 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20260211070548epoutp041386ab923dc83977d237bcf8ddf8843f~TH1mZjn8k0334503345epoutp04y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1770793548;
	bh=zszdhhsrv+up7ZflU5pHLQgNi3Fdy52nk5y4MQowDYA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WWUr6nZcjgHEPbuOWxqLj6c5sQ+lkAaT3ncuY1G/MbqO/p3AMo70C+4eq5S56ReMj
	 ECOVKuaONKdh16KXE//3K0JTSjleo8r614eFQ/c/+euucns5DCg9j7GcyQeNjr3JDe
	 +/+ROg7B5TVn4MzxYmzW2L2YyVxzE3bs/H+GnQhg=
Received: from epsnrtp03.localdomain (unknown [182.195.42.155]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPS id
	20260211070547epcas5p1025d920a110b5eea592d51eb0e1aec0c~TH1l5Q-u02670926709epcas5p1c;
	Wed, 11 Feb 2026 07:05:47 +0000 (GMT)
Received: from epcas5p1.samsung.com (unknown [182.195.38.91]) by
	epsnrtp03.localdomain (Postfix) with ESMTP id 4f9qG26XHvz3hhTC; Wed, 11 Feb
	2026 07:05:46 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20260211070546epcas5p486d5ecfe6754e6237fe3a428705db456~TH1kyHT_a2610826108epcas5p4S;
	Wed, 11 Feb 2026 07:05:46 +0000 (GMT)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20260211070543epsmtip238fdf67c48a700330e71852ca4040edb~TH1iDhZo40199301993epsmtip2i;
	Wed, 11 Feb 2026 07:05:43 +0000 (GMT)
From: Kundan Kumar <kundan.kumar@samsung.com>
To: jaegeuk@kernel.org, chao@kernel.org, agruenba@redhat.com,
	trondmy@kernel.org, anna@kernel.org, hch@lst.de, brauner@kernel.org,
	jack@suse.cz, viro@zeniv.linux.org.uk, djwong@kernel.org,
	pankaj.raghav@linux.dev
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
	gfs2@lists.linux.dev, linux-nfs@vger.kernel.org, gost.dev@samsung.com,
	anuj20.g@samsung.com, vishak.g@samsung.com, joshi.k@samsung.com,
	mcgrof@kernel.org, Kundan Kumar <kundan.kumar@samsung.com>
Subject: [PATCH 4/4] nfs: stop using writeback internals for WB_WRITEBACK
 accounting
Date: Wed, 11 Feb 2026 12:30:57 +0530
Message-Id: <20260211070057.22001-5-kundan.kumar@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260211070057.22001-1-kundan.kumar@samsung.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260211070546epcas5p486d5ecfe6754e6237fe3a428705db456
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20260211070546epcas5p486d5ecfe6754e6237fe3a428705db456
References: <20260211070057.22001-1-kundan.kumar@samsung.com>
	<CGME20260211070546epcas5p486d5ecfe6754e6237fe3a428705db456@epcas5p4.samsung.com>
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
	TAGGED_FROM(0.00)[bounces-18879-lists,linux-nfs=lfdr.de];
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
X-Rspamd-Queue-Id: 4749C121C9F
X-Rspamd-Action: no action

Convert NFS WB_WRITEBACK accounting to bdi-scoped writeback helper,
eliminating direct access to writeback.

Suggested-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Kundan Kumar <kundan.kumar@samsung.com>
Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
---
 fs/nfs/internal.h | 2 +-
 fs/nfs/write.c    | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index 2e596244799f..a738c357b153 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -866,7 +866,7 @@ static inline void nfs_folio_mark_unstable(struct folio *folio,
 		 * writeback is happening on the server now.
 		 */
 		node_stat_mod_folio(folio, NR_WRITEBACK, nr);
-		wb_stat_mod(&inode_to_bdi(inode)->wb, WB_WRITEBACK, nr);
+		bdi_wb_stat_mod(inode_to_bdi(inode), WB_WRITEBACK, nr);
 		__mark_inode_dirty(inode, I_DIRTY_DATASYNC);
 	}
 }
diff --git a/fs/nfs/write.c b/fs/nfs/write.c
index bf412455e8ed..c56b15b5380f 100644
--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -872,8 +872,8 @@ static void nfs_folio_clear_commit(struct folio *folio)
 		long nr = folio_nr_pages(folio);
 
 		node_stat_mod_folio(folio, NR_WRITEBACK, -nr);
-		wb_stat_mod(&inode_to_bdi(folio->mapping->host)->wb,
-			    WB_WRITEBACK, -nr);
+		bdi_wb_stat_mod(inode_to_bdi(folio->mapping->host),
+				WB_WRITEBACK, -nr);
 	}
 }
 
-- 
2.25.1


