Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67F3E42C3A0
	for <lists+linux-nfs@lfdr.de>; Wed, 13 Oct 2021 16:41:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236315AbhJMOnE (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 13 Oct 2021 10:43:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:50398 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230015AbhJMOnE (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 13 Oct 2021 10:43:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B9C026112D;
        Wed, 13 Oct 2021 14:41:00 +0000 (UTC)
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@redhat.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v1 1/3] NFSD: Save location of NFSv4 COMPOUND status
Date:   Wed, 13 Oct 2021 10:40:59 -0400
Message-Id:  <163413605956.5966.9433907577871478748.stgit@bazille.1015granger.net>
X-Mailer: git-send-email 2.33.0.113.g6c40894d24
In-Reply-To:  <163413598146.5966.14139533676554616065.stgit@bazille.1015granger.net>
References:  <163413598146.5966.14139533676554616065.stgit@bazille.1015granger.net>
User-Agent: StGit/1.1+62.ged16
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=2172; h=from:subject:message-id; bh=GkaRRyqGP/lPfvswDDgGdJJjDZcGuM4BivIHqor7dDM=; b=owEBbQKS/ZANAwAIATNqszNvZn+XAcsmYgBhZu/7+l+V2uMCcDa9gymPHm+IzHO78/SY1235yQS0 OoLxFWCJAjMEAAEIAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCYWbv+wAKCRAzarMzb2Z/l1pPEA C0KDxxIxQcUEELlu+2jfAfO0XdR9XZR8IDv0W64FRZzSfCcrGFrfbFrj07dU0EEGvWdI0Mp3/HhtCB ebXuSWxSFOsT7JcWB2iCpbFkeGt/CyN0KLAuOFWHr2uurNGi71EiO9INS7FkRfaz0uw7K4zBk1L5BA UVNKktMgJswc8FutHtLpLfzfF3z10tZ8T6SuyqLlUByPcOldP1svxGEbyF58DDOpttSIbysR8G/V4/ aUtKn6dNk6DAalEh0B0Qf8JCclYwbIiZVVIznMlOWY2uTDWi8tX1sTxq+O1wXuXSdMjkIxH8WWmKKV UKm8FfGPoY1ZRsA8GXEeJlYXJSdIfEdn3d2mlQ2raumGwg00lFEEPYARu3246IFM1N4AfQYULVilel /M6zy1N4pfZJBIVbMmOm1ivBQlZtJ1nmoOLg6C3Q8rCGcZFu47QENQAJuYHtBCNIgfSz/unRZDY3Bj 1o0W0SYYxGY9fcbrQv0QYvkYreRCMBxenWsKy0i7EGCtkDKPwqq5GjjrP9G+4Igg/q6QHl81J2vwK3 f/6HHR1W3xVuUd5znjufxI6YcyblKXf1MkxcPC2KYSv8Jo3cswwdmKV1Adw97MULFyjA6GcVXPQquc iOJ7pHw1G/tkaE/+5s961NZf5hYNzifaSjO9c+x+Ch/gDfpea2BfPe/rp6pQ==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp; fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Refactor: Currently nfs4svc_encode_compoundres() relies on the NFS
dispatcher to pass in the buffer location of the COMPOUND status.
Instead, save that buffer location in struct nfsd4_compoundres.

The compound tag follows immediately after.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4proc.c |    2 +-
 fs/nfsd/nfs4xdr.c  |    9 +++++++--
 fs/nfsd/xdr4.h     |    3 ++-
 3 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 55c9551fa74e..7bc306ee3e59 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -2461,11 +2461,11 @@ nfsd4_proc_compound(struct svc_rqst *rqstp)
 	__be32		status;
 
 	resp->xdr = &rqstp->rq_res_stream;
+	resp->statusp = resp->xdr->p;
 
 	/* reserve space for: NFS status code */
 	xdr_reserve_space(resp->xdr, XDR_UNIT);
 
-	resp->tagp = resp->xdr->p;
 	/* reserve space for: taglen, tag, and opcnt */
 	xdr_reserve_space(resp->xdr, XDR_UNIT * 2 + args->taglen);
 	resp->taglen = args->taglen;
diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 9099f489f60d..8623aea38d58 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -5435,11 +5435,16 @@ nfs4svc_encode_compoundres(struct svc_rqst *rqstp, __be32 *p)
 	WARN_ON_ONCE(buf->len != buf->head[0].iov_len + buf->page_len +
 				 buf->tail[0].iov_len);
 
-	*p = resp->cstate.status;
+	/*
+	 * Send buffer space for the following items is reserved
+	 * at the top of nfsd4_proc_compound().
+	 */
+	p = resp->statusp;
+
+	*p++ = resp->cstate.status;
 
 	rqstp->rq_next_page = resp->xdr->page_ptr + 1;
 
-	p = resp->tagp;
 	*p++ = htonl(resp->taglen);
 	memcpy(p, resp->tag, resp->taglen);
 	p += XDR_QUADLEN(resp->taglen);
diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
index 8812256cd520..6aeb6755278f 100644
--- a/fs/nfsd/xdr4.h
+++ b/fs/nfsd/xdr4.h
@@ -702,10 +702,11 @@ struct nfsd4_compoundres {
 	struct xdr_stream		*xdr;
 	struct svc_rqst *		rqstp;
 
+	__be32				*statusp;
 	u32				taglen;
 	char *				tag;
 	u32				opcnt;
-	__be32 *			tagp; /* tag, opcount encode location */
+
 	struct nfsd4_compound_state	cstate;
 };
 

