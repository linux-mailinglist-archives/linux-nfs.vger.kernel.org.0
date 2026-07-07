Return-Path: <linux-nfs+bounces-23138-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id RYVbHZQXTWrauwEAu9opvQ
	(envelope-from <linux-nfs+bounces-23138-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 07 Jul 2026 17:13:24 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CEBF71D1C4
	for <lists+linux-nfs@lfdr.de>; Tue, 07 Jul 2026 17:13:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=hammerspace.com header.s=google header.b=d+eD1bW3;
	dmarc=pass (policy=quarantine) header.from=hammerspace.com;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-23138-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-23138-lists+linux-nfs=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2A9A830D0E4B
	for <lists+linux-nfs@lfdr.de>; Tue,  7 Jul 2026 15:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 120123769E5;
	Tue,  7 Jul 2026 15:07:22 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BD9E379EE7
	for <linux-nfs@vger.kernel.org>; Tue,  7 Jul 2026 15:07:20 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783436842; cv=none; b=qalTV2oi6BUpMLK99xXZxmTk6WW+GVP2UY8dx83DtafqyOjLiRIoP/AK7mSvK5+xFmzkuohx9C9GXrVfRxzGe0iwGvNlfe6yE3OZl085hMmFMrFGpuRadfvP7t5x+TLnXDjC8N+ZjyH3vOgr6WOV0LsqVXIc6URQaRE086DUTqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783436842; c=relaxed/simple;
	bh=o/gNpYdhlekp4QQxaZfqu1tGOARHkU79BudSbfccIlE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nRq1KlnA5KlsGrDXmY04Jehtqw9hUAe6KWnpM0Nkazw487ZwGF4k3f8EN9sxbSoDgNyeBvsPmIAefS3bDeGf3nFFBGDZm5O0ASAQiaGHaBDI6SCVe1y8L3o6muCjDeAL/a8VacLdNpG1i9TeiHRnxm5IpGtJ/ECG5VUPErOJ6U8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (2048-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=d+eD1bW3; arc=none smtp.client-ip=209.85.160.41
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-44ce674ed17so2574379fac.0
        for <linux-nfs@vger.kernel.org>; Tue, 07 Jul 2026 08:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hammerspace.com; s=google; t=1783436839; x=1784041639; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=+dZPKZaCOxwYzuh4Lwb0MsDL6tOjQMEMgThRNAVB0nI=;
        b=d+eD1bW3jBYdEQcD4NgsHxOOKF2RwRGqRbaEEeAZeaFb02j7oOKmKJSebmTKx2srSh
         iQsYGsoGRid9/U7UzYyMbtSTucBvIgxVhF/cPmyTGnQ49j1zNVnmMMFzY0gU1DaOZAfT
         GoPlHqOnQ20piicYknCWUYQkZj1yr82euwC2h6F3NU0TFvcwiHdsPchBP55SaTvP7xnf
         5MYCeptGxNqFfGryGYHkFhJlctTNcCj0VNTAtr2uZF0UGF3lu/YWe38XqSbW+K4UG9zR
         i3RZm5Zv/oOwFHXzFv4kyQBlHOMQqaYLWyG9owt5QsjCfEf1RhEw66oxlCusaHhWIKoJ
         XHSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783436839; x=1784041639;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+dZPKZaCOxwYzuh4Lwb0MsDL6tOjQMEMgThRNAVB0nI=;
        b=Ovu8FviG7k9ZpXk+NKEZmpw/Kxj/l24Tx099FXNHNG3Lx6shRq+tIcljEa9G7YkNpb
         ybVCIy0EmdopIoNknaE+ANOk+2P33fr11mhVLakQSl/Yw7nECidjqF2udm6Z0b/fOvMR
         x68e7QmVDMOcE6o/zDAFoS4nZADbeFUog1gH9CxSLmMzdn2gnguJx2q2CaK6ww29t5NU
         xKB1QMS2Q6YQ75tYVdAF/uwEKc8PxWrYlu7wGELHJP9zpt06+/qGgpNw62jtQEmnH54r
         PMhw7mN3GeS51JHhTRrcv9qHvl/h6BNbsDEJTigEro3IjGLBgOKnTIwzS0EMn6wzc5hy
         pWGQ==
X-Gm-Message-State: AOJu0YzEEV0ExgtD9gPQDKBewciGT3aDbrtejmkXnBtOGNncSMf0Sbke
	34ssvWhqoyyFosZERDgAulOVdJYR+23Uh2XYlGht9/WDMtcT4FnydgESjJN9K1CnWsiBdm219AG
	Psi5k
X-Gm-Gg: AfdE7cmFgdxfLSRBzlXjCaGYVnhnLP6TR2OOQOkaQkb/phSz0sGNBWYHCHIhVhATHh8
	qA5829Rj+F1itvitu9vMVXFVCoqu9HdsdT2ogn9mfCv/IknHJ8ASz7WBtxH23eKakLOodHF/csa
	U+cH8tuWVSWA9LzLO19eD9+urH4N750Rr5w6Pl/mR8ABxbVRtDCAMYJfhGqzyc9+kGil28l+0g9
	AFiOIez2Wr0iSYWr6gueAnU1VPbxmNLMqeSKKNGBArCzN3PwRVQvp8ONBJVW2K7tCh/i4scvIgc
	1JDcxBfKCGJ7EOT6JtxmQFBtqB79FIV+ZKt5E02oPjgUCQKj1dnHTZpIO5nEie7le9IQODTAgE0
	kekIRj8jzb/Y+g86PO3eE+6pnRl1k2+IBBQZ/kevGPPpld/Cr/RSCBnOKEyupUjDRJMt+HmRyfY
	c4cxR30qW2zjJSrp1R8IB3nUN18J6cMGybb32vgaZDhtFFAmP3y06ZuL7IRLw=
X-Received: by 2002:a05:6870:7191:b0:447:1ceb:7cc6 with SMTP id 586e51a60fabf-451059c2cafmr3548693fac.15.1783436838973;
        Tue, 07 Jul 2026 08:07:18 -0700 (PDT)
Received: from bcodding.csb.hammerspace.com ([66.97.168.37])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-44cfb559559sm14219839fac.9.2026.07.07.08.07.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 08:07:18 -0700 (PDT)
From: Benjamin Coddington <ben.coddington@hammerspace.com>
X-Google-Original-From: Benjamin Coddington <bcodding@hammerspace.com>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH] NFS: Charge unstable writes by request size, not folio size
Date: Tue,  7 Jul 2026 11:07:16 -0400
Message-ID: <96cb0f45621309481c96cb1e81ef3175257161ec.1783436588.git.bcodding@hammerspace.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[hammerspace.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[hammerspace.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-23138-lists,linux-nfs=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER(0.00)[ben.coddington@hammerspace.com,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:trondmy@kernel.org,m:anna@kernel.org,m:linux-nfs@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[hammerspace.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[ben.coddington@hammerspace.com,linux-nfs@vger.kernel.org];
	ALIAS_RESOLVED(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,anthropic.com:email,hammerspace.com:from_mime,hammerspace.com:email,hammerspace.com:mid,hammerspace.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6CEBF71D1C4

nfs_folio_mark_unstable() and nfs_folio_clear_commit() charge and
uncharge NR_WRITEBACK/WB_WRITEBACK by folio_nr_pages(folio) once per
*request* added to or removed from a commit list. This is correct only
when a folio has a single associated request. When pg_test splits a
folio into N sub-folio requests (e.g. pNFS flexfiles striping with a
stripe unit smaller than the folio size, or plain wsize-limited
splitting), each of the N requests independently charges the whole
folio's page count, inflating the accounting by a factor of N per
folio. With large folios and small stripe units this reaches multiple
orders of magnitude: a 2 MiB folio split into 512 4 KiB requests can
charge up to 512x its real size, pushing global dirty+writeback
accounting past the system's dirty threshold and forcing every
buffered writer on the host into the hard-throttle path, including
unrelated in-kernel NFS server threads sharing the box.

Charge each request only for the pages it actually covers.

Fixes: 0c493b5cf16e ("NFS: Convert buffered writes to use folios")
Cc: stable@vger.kernel.org
Signed-off-by: Benjamin Coddington <bcodding@hammerspace.com>
Assisted-By: Claude Sonnet 5 <noreply@anthropic.com>
---
 fs/nfs/internal.h | 12 +++++++-----
 fs/nfs/pnfs_nfs.c |  2 +-
 fs/nfs/write.c    | 14 ++++++++------
 3 files changed, 16 insertions(+), 12 deletions(-)

diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index 18d46b0e71dd..1d5d62f88dde 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -847,17 +847,19 @@ void nfs_super_set_maxbytes(struct super_block *sb, __u64 maxfilesize)
 }
 
 /*
- * Record the page as unstable (an extra writeback period) and mark its
- * inode as dirty.
+ * Record the request's range as unstable (an extra writeback period) and
+ * mark its inode as dirty.
  */
-static inline void nfs_folio_mark_unstable(struct folio *folio,
+static inline void nfs_folio_mark_unstable(struct nfs_page *req,
 					   struct nfs_commit_info *cinfo)
 {
+	struct folio *folio = nfs_page_to_folio(req);
+
 	if (folio && !cinfo->dreq) {
 		struct inode *inode = folio->mapping->host;
-		long nr = folio_nr_pages(folio);
+		long nr = DIV_ROUND_UP(req->wb_bytes, PAGE_SIZE);
 
-		/* This page is really still in write-back - just that the
+		/* This range is really still in write-back - just that the
 		 * writeback is happening on the server now.
 		 */
 		node_stat_mod_folio(folio, NR_WRITEBACK, nr);
diff --git a/fs/nfs/pnfs_nfs.c b/fs/nfs/pnfs_nfs.c
index 12632a706da8..3a12d06a9928 100644
--- a/fs/nfs/pnfs_nfs.c
+++ b/fs/nfs/pnfs_nfs.c
@@ -1199,7 +1199,7 @@ pnfs_layout_mark_request_commit(struct nfs_page *req,
 
 	nfs_request_add_commit_list_locked(req, list, cinfo);
 	mutex_unlock(&NFS_I(cinfo->inode)->commit_mutex);
-	nfs_folio_mark_unstable(nfs_page_to_folio(req), cinfo);
+	nfs_folio_mark_unstable(req, cinfo);
 	return;
 out_resched:
 	mutex_unlock(&NFS_I(cinfo->inode)->commit_mutex);
diff --git a/fs/nfs/write.c b/fs/nfs/write.c
index d7c399763ad9..f7a5fb8140c4 100644
--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -807,7 +807,7 @@ nfs_request_add_commit_list(struct nfs_page *req, struct nfs_commit_info *cinfo)
 	mutex_lock(&NFS_I(cinfo->inode)->commit_mutex);
 	nfs_request_add_commit_list_locked(req, &cinfo->mds->list, cinfo);
 	mutex_unlock(&NFS_I(cinfo->inode)->commit_mutex);
-	nfs_folio_mark_unstable(nfs_page_to_folio(req), cinfo);
+	nfs_folio_mark_unstable(req, cinfo);
 }
 EXPORT_SYMBOL_GPL(nfs_request_add_commit_list);
 
@@ -866,10 +866,12 @@ nfs_mark_request_commit(struct nfs_page *req, struct pnfs_layout_segment *lseg,
 	nfs_request_add_commit_list(req, cinfo);
 }
 
-static void nfs_folio_clear_commit(struct folio *folio)
+static void nfs_folio_clear_commit(struct nfs_page *req)
 {
+	struct folio *folio = nfs_page_to_folio(req);
+
 	if (folio) {
-		long nr = folio_nr_pages(folio);
+		long nr = DIV_ROUND_UP(req->wb_bytes, PAGE_SIZE);
 
 		node_stat_mod_folio(folio, NR_WRITEBACK, -nr);
 		bdi_wb_stat_mod(folio->mapping->host, WB_WRITEBACK, -nr);
@@ -889,7 +891,7 @@ static void nfs_clear_request_commit(struct nfs_commit_info *cinfo,
 			nfs_request_remove_commit_list(req, cinfo);
 		}
 		mutex_unlock(&NFS_I(inode)->commit_mutex);
-		nfs_folio_clear_commit(nfs_page_to_folio(req));
+		nfs_folio_clear_commit(req);
 	}
 }
 
@@ -1741,7 +1743,7 @@ void nfs_retry_commit(struct list_head *page_list,
 		req = nfs_list_entry(page_list->next);
 		nfs_list_remove_request(req);
 		nfs_mark_request_commit(req, lseg, cinfo, ds_commit_idx);
-		nfs_folio_clear_commit(nfs_page_to_folio(req));
+		nfs_folio_clear_commit(req);
 		nfs_unlock_and_release_request(req);
 	}
 }
@@ -1813,7 +1815,7 @@ static void nfs_commit_release_pages(struct nfs_commit_data *data)
 		req = nfs_list_entry(data->pages.next);
 		nfs_list_remove_request(req);
 		folio = nfs_page_to_folio(req);
-		nfs_folio_clear_commit(folio);
+		nfs_folio_clear_commit(req);
 
 		dprintk("NFS:       commit (%s/%llu %d@%lld)",
 			nfs_req_openctx(req)->dentry->d_sb->s_id,
-- 
2.53.0


