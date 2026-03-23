Return-Path: <linux-nfs+bounces-20322-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OFy/M7PnwGl6OQQAu9opvQ
	(envelope-from <linux-nfs+bounces-20322-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Mar 2026 08:11:47 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 49DB42ED548
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Mar 2026 08:11:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 547F8303D2ED
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Mar 2026 07:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 504DD35DA56;
	Mon, 23 Mar 2026 07:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hqlUgWlO"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1577235D615;
	Mon, 23 Mar 2026 07:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774249693; cv=none; b=DFFQja73v1dzhu9UKIId+lVjF55Z42ngQ43WhZ5G6PChlVCS6iJ8JC7TeF0MHtAyZTci+gEl2/I1Yk1UUnHSwieSAdZVPCaBBYtvMfbZ34ZRH0RakcLs81HOZtIm5hzHH61S2In985cRl0YmvdKt1Zgu/4JHzTcSA2u7/vwtSWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774249693; c=relaxed/simple;
	bh=gzgkeVdrcAuemWHiyZDuhYNQ+ZxC+E1VhWzlMbeJpN0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rS9OT2hpdh6LgAq0iJQU+lr6DLITMFRu7qGec+/J6Sb5x6QYgVAXDlp6pRKdrXPncHtIEpMZevQPHPqWlERWGWxFz0dNOIIzlUTLIes9QEFjz8vX8SIFKomWXXRdN8HcidTywYzsDXqjzu28g3PFdtinUX+ygiH1dhpjhhRUevU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=hqlUgWlO; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=ShY/Bhmu2Gwar+ZmjbjrgOxtlsTF4MqK+A/Ie9KeEjo=; b=hqlUgWlOWcsY933tYLbze7PPpL
	FwJcR5ZMscaRFdt2zpooaJPG05pa5v9eQJaS2nCcqyewKb4vVJ9l+RnpBDhvAoakw98mkocj9K0rf
	ke8bP01jQj96hn6qamuCus8estYD3bquqdPZIvDUldHlnWk/Xqtgco9BCbFhfMW2f3HSN998HnNKk
	GWCbWV7PavbmziB5k2RDubVXYUmDX1GLqDs4h+1Lg9VNxKcC81U8GpFHvgPO+jjhJq/kWbHpePRbq
	fxv2EOGhHhSPKdDyUx6BfABY+cOIkFsoRDgASgQNLUZcRo0PyBUcYsUhMVKcs/V78jb/051Qgltsq
	8ahWmOjg==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w4ZOU-0000000GAMk-2Lbn;
	Mon, 23 Mar 2026 07:08:10 +0000
From: Christoph Hellwig <hch@lst.de>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>
Cc: NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	Carlos Maiolino <cem@kernel.org>,
	linux-nfs@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 4/7] nfsd: support multiple pNFS device IDs
Date: Mon, 23 Mar 2026 08:07:20 +0100
Message-ID: <20260323070746.2940140-5-hch@lst.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260323070746.2940140-1-hch@lst.de>
References: <20260323070746.2940140-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[lst.de : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-20322-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[oracle.com,kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[infradead.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@lst.de,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lst.de:email,lst.de:mid]
X-Rspamd-Queue-Id: 49DB42ED548
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add support for a device index in the device ID so that we can support
multiple different devices and not just different generations when
the devids are refreshed.  This will be used for block layout exports
of multi-device file systems.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/nfsd/blocklayout.c    | 2 +-
 fs/nfsd/flexfilelayout.c | 3 +--
 fs/nfsd/nfs4layouts.c    | 3 ++-
 fs/nfsd/pnfs.h           | 2 +-
 fs/nfsd/xdr4.h           | 5 +++--
 5 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/fs/nfsd/blocklayout.c b/fs/nfsd/blocklayout.c
index 0dd36f3d5a51..8ca8fd8f70cb 100644
--- a/fs/nfsd/blocklayout.c
+++ b/fs/nfsd/blocklayout.c
@@ -75,7 +75,7 @@ nfsd4_block_map_extent(struct inode *inode, const struct svc_fh *fhp,
 		return nfserr_layoutunavailable;
 	}
 
-	error = nfsd4_set_deviceid(&bex->vol_id, fhp, device_generation);
+	error = nfsd4_set_deviceid(&bex->vol_id, fhp, 0, device_generation);
 	if (error)
 		return nfserrno(error);
 
diff --git a/fs/nfsd/flexfilelayout.c b/fs/nfsd/flexfilelayout.c
index 6d531285ab43..b57db4b4dda7 100644
--- a/fs/nfsd/flexfilelayout.c
+++ b/fs/nfsd/flexfilelayout.c
@@ -24,7 +24,6 @@ nfsd4_ff_proc_layoutget(struct svc_rqst *rqstp, struct inode *inode,
 		const struct svc_fh *fhp, struct nfsd4_layoutget *args)
 {
 	struct nfsd4_layout_seg *seg = &args->lg_seg;
-	u32 device_generation = 0;
 	int error;
 	uid_t u;
 
@@ -57,7 +56,7 @@ nfsd4_ff_proc_layoutget(struct svc_rqst *rqstp, struct inode *inode,
 		fl->uid = inode->i_uid;
 	fl->gid = inode->i_gid;
 
-	error = nfsd4_set_deviceid(&fl->deviceid, fhp, device_generation);
+	error = nfsd4_set_deviceid(&fl->deviceid, fhp, 0, 0);
 	if (error)
 		goto out_error;
 
diff --git a/fs/nfsd/nfs4layouts.c b/fs/nfsd/nfs4layouts.c
index 7b849b637b5e..ace6057f5d63 100644
--- a/fs/nfsd/nfs4layouts.c
+++ b/fs/nfsd/nfs4layouts.c
@@ -110,7 +110,7 @@ nfsd4_find_devid_map(int idx)
 
 int
 nfsd4_set_deviceid(struct nfsd4_deviceid *id, const struct svc_fh *fhp,
-		u32 device_generation)
+		u32 dev_idx, u32 device_generation)
 {
 	if (!fhp->fh_export->ex_devid_map) {
 		nfsd4_alloc_devid_map(fhp);
@@ -120,6 +120,7 @@ nfsd4_set_deviceid(struct nfsd4_deviceid *id, const struct svc_fh *fhp,
 
 	id->fsid_idx = fhp->fh_export->ex_devid_map->idx;
 	id->generation = device_generation;
+	id->dev_idx = dev_idx;
 	return 0;
 }
 
diff --git a/fs/nfsd/pnfs.h b/fs/nfsd/pnfs.h
index db9af780438b..4a6b0ad2ec9b 100644
--- a/fs/nfsd/pnfs.h
+++ b/fs/nfsd/pnfs.h
@@ -65,7 +65,7 @@ __be32 nfsd4_return_client_layouts(struct svc_rqst *rqstp,
 		struct nfsd4_compound_state *cstate,
 		struct nfsd4_layoutreturn *lrp);
 int nfsd4_set_deviceid(struct nfsd4_deviceid *id, const struct svc_fh *fhp,
-		u32 device_generation);
+		u32 dev_idx, u32 device_generation);
 struct nfsd4_deviceid_map *nfsd4_find_devid_map(int idx);
 #endif /* CONFIG_NFSD_V4 */
 
diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
index 417e9ad9fbb3..ddeba134b9af 100644
--- a/fs/nfsd/xdr4.h
+++ b/fs/nfsd/xdr4.h
@@ -602,6 +602,7 @@ struct nfsd4_reclaim_complete {
 struct nfsd4_deviceid {
 	u64			fsid_idx;
 	u32			generation;
+	u32			dev_idx;
 };
 
 static inline __be32 *
@@ -612,7 +613,7 @@ svcxdr_encode_deviceid4(__be32 *p, const struct nfsd4_deviceid *devid)
 	*q = (__force __be64)devid->fsid_idx;
 	p += 2;
 	*p++ = (__force __be32)devid->generation;
-	*p++ = xdr_zero;
+	*p++ = (__force __be32)devid->dev_idx;
 	return p;
 }
 
@@ -624,7 +625,7 @@ svcxdr_decode_deviceid4(__be32 *p, struct nfsd4_deviceid *devid)
 	devid->fsid_idx = (__force u64)(*q);
 	p += 2;
 	devid->generation = (__force u32)(*p++);
-	p++; /* NFSD does not use the remaining octets */
+	devid->dev_idx = (__force u32)(*p++);
 	return p;
 }
 
-- 
2.47.3


