Return-Path: <linux-nfs+bounces-21484-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8MpCEdvAAmpJwQEAu9opvQ
	(envelope-from <linux-nfs+bounces-21484-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2026 07:55:39 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 96E1E51A822
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2026 07:55:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E855031B8D15
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2026 05:43:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A2733CA48C;
	Tue, 12 May 2026 05:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fBrYSimV"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3C933CA49A;
	Tue, 12 May 2026 05:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778564243; cv=none; b=icBJbFTSNHzuxPNldBsL7hoZr+AnXuDGCC/qZvvM6WbCv9ywjklLYmMGCrdyyLC1L7pHpOQmTzloOt4hCmn0IUwAnht0/ApwOuYSKxVKXNaAvP6HxVVgcHWXzl48UFTtC05Cw+squpfsfFEr7XfTHUsTfEr7OIPGqnz0ToZS6PA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778564243; c=relaxed/simple;
	bh=H+fAAR2VWfWsbK/34vSWvBipMN322TyubCQwnIT5NmA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TDpGO6yUglm7a7SMDq2bAgVJ6V2BfiiQdiKeCU/aSOVScBZJaHEIOvfwMSv773eNjeFKE1JXEffwHBgXxkTFjyy39qOk3lI3fDqT9zU1jXHKzINhEyStvFlowoTpKI+ZgyBka0MUMmJTdCsqoswCQZZ6zAvUkPc7zjOBjQNE4x0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=fBrYSimV; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=SFnfiE6eXJFzgFJiNYniWIOwAjN0Z4qYfw3E7XgNBJs=; b=fBrYSimVUdqrWfQJb5ZGKTYrxO
	a4Q2JOWiqE1CrUKooGJ+LnGljcIS8i0i67sgotq7jYGDfkK4CReONqXDgpdqL0znEO5HEjqAeTVi8
	xILDvqBWxJWjF/OI/KDh56u7zEK8MasUS6riWjIJ6RJO/PBZmt7PIHIwBbtxNNUzWvywTl8FBUngp
	ttTGV9wVPAzvKL/ydNorpVDlfSZXsRT+mFxIzvvFpNdabt4qSFEM+hU4NtmDYDGVH/LhwHQYIXmNg
	+785VZ7NDn66h/wVUqsB1lC5B/w0u/0Zv8F7lWQfn8l8nnNUP7CB+0nr3BgxUAS9rRdxQv0hrzSEf
	sYvsiBQw==;
Received: from 2a02-8389-2341-5b80-decc-1a96-daaa-a2cc.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:decc:1a96:daaa:a2cc] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMfns-0000000FfM7-0BDl;
	Tue, 12 May 2026 05:37:12 +0000
From: Christoph Hellwig <hch@lst.de>
To: Andrew Morton <akpm@linux-foundation.org>,
	Chris Li <chrisl@kernel.org>,
	Kairui Song <kasong@tencent.com>
Cc: Christian Brauner <brauner@kernel.org>,
	"Darrick J . Wong " <djwong@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	David Sterba <dsterba@suse.com>,
	"Theodore Ts'o" <tytso@mit.edu>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Hyunchul Lee <hyc.lee@gmail.com>,
	Steve French <sfrench@samba.org>,
	Paulo Alcantara <pc@manguebit.org>,
	Carlos Maiolino <cem@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	Naohiro Aota <naohiro.aota@wdc.com>,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-mm@kvack.org,
	linux-block@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-nfs@vger.kernel.org,
	linux-cifs@vger.kernel.org
Subject: [PATCH 05/12] swap: cleanup setup_swap_extents
Date: Tue, 12 May 2026 07:35:21 +0200
Message-ID: <20260512053625.2950900-6-hch@lst.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260512053625.2950900-1-hch@lst.de>
References: <20260512053625.2950900-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Rspamd-Queue-Id: 96E1E51A822
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[lst.de : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21484-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[29];
	FREEMAIL_CC(0.00)[kernel.org,kernel.dk,suse.com,mit.edu,gmail.com,samba.org,manguebit.org,wdc.com,vger.kernel.org,kvack.org,lists.sourceforge.net];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@lst.de,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[infradead.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lst.de:email,lst.de:mid,infradead.org:dkim]
X-Rspamd-Action: no action

Reflow setup_swap_extents so that the flag checking is not conditional on
a swap_activate method.  This is currently a no-op because the swapoff
code still checks the presence of a swap_deactivate method, but it
simplifies adding a new check, and also makes the SWP_ACTIVATED flag
more consistent.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 mm/swapfile.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index 651c1b59ff9f..1b7fc03612f4 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -2783,25 +2783,24 @@ static int setup_swap_extents(struct swap_info_struct *sis,
 {
 	struct address_space *mapping = swap_file->f_mapping;
 	struct inode *inode = mapping->host;
-	int ret;
+	int ret, error = 0;
 
 	if (S_ISBLK(inode->i_mode))
 		return add_swap_extent(sis, sis->max, 0);
 
-	if (swap_file->f_op->swap_activate) {
+	if (swap_file->f_op->swap_activate)
 		ret = swap_file->f_op->swap_activate(swap_file, sis);
-		if (ret < 0)
-			return ret;
-		sis->flags |= SWP_ACTIVATED;
-		if ((sis->flags & SWP_FS_OPS) &&
-		    sio_pool_init() != 0) {
-			destroy_swap_extents(sis, swap_file);
-			return -ENOMEM;
-		}
+	else
+		ret = generic_swap_activate(swap_file, sis);
+	if (ret < 0)
 		return ret;
-	}
 
-	return generic_swap_activate(swap_file, sis);
+	sis->flags |= SWP_ACTIVATED;
+	if (sis->flags & SWP_FS_OPS)
+		error = sio_pool_init();
+	if (error)
+		destroy_swap_extents(sis, swap_file);
+	return error;
 }
 
 static void _enable_swap_info(struct swap_info_struct *si)
-- 
2.53.0


