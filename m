Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE8A52BB71F
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Nov 2020 21:42:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731375AbgKTUe0 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 20 Nov 2020 15:34:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731207AbgKTUe0 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 20 Nov 2020 15:34:26 -0500
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01047C0613CF
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 12:34:26 -0800 (PST)
Received: by mail-qt1-x842.google.com with SMTP id b16so8111704qtb.6
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 12:34:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=KZmzsQKEKT00RlpYJLgR749zMr7KPAOcy56jG6x7lwg=;
        b=fXTgW6KVKeknarAkk7BsyMG0subZ6s31dNqitcD0nHbRUQTTKO6U8CC/aUOqYnOzjI
         xyGnYML/82rK2SbwjFAz+V/NK6C55X5KGXn2kxDKrQ2Rt8q9K9ipSIS2G/aXFskgD95+
         o937/Aq+OiRDlk7TRsNzuS7ELWiMcMQGddhDt4EUh3aNQmEA3+Xc5E8QOPXR6zPgd7FK
         SHUNqGHFW0uMwCZ7YpFqvexL84IaoS20ygTOA8pDIQBscQZ4udGJ7pINc8wJQNXj2gsK
         bA5zsdQY0VjRqS+HKWhmfYwUW6pwYuJAD5tu6fwz/XzYl8AHCIhhjcYqxLQA8zcGDTHX
         +ClQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=KZmzsQKEKT00RlpYJLgR749zMr7KPAOcy56jG6x7lwg=;
        b=b6qlLhIJCCgKKMS5WPkC8DejXS5HW214CwkFW7bvXeVwKlQbg7TpFZwUEADhUbk6Dt
         j+Mbov/0BCHn1fzzFVog+0Ib0ysvHDHvT8mCX4a/4b6NgmD5v0nFX2KmxvGcd3fJ/QCN
         mrLRaae/4y0s3SLSe4BDxLLMk6cluRA3NW6YJwqfFLfGSIjAED9CNDKTnwfIrEg7fQkr
         T3IJwcDOYiZV0QdpLonZxdSfi+mITbx6PrpgudBMcmbNfKQpcsj//WJneK98S+3OmPLQ
         nM/Jx6R6GMXS1qLi97n+3ySHSaRFB+wU+PQifmHZCxmtZ5yvKfHoWT4Y2yz7heVO/pPo
         jV2g==
X-Gm-Message-State: AOAM532mGINaGSltKQ49ltPkjqqTrTuyUVA+pKkPxVNesnIACtNYVV7H
        N7+K/EDXZPPCHXiiywSjw1/0SiQvKRE=
X-Google-Smtp-Source: ABdhPJyodKEN+QCq19ABOLG7LdKvkswzmzQE+icwEerfesPp+xJt9koGGxabWwLxcVJdc+Ru049p1g==
X-Received: by 2002:ac8:3499:: with SMTP id w25mr17092230qtb.44.1605904464828;
        Fri, 20 Nov 2020 12:34:24 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id q20sm2712879qke.0.2020.11.20.12.34.23
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Nov 2020 12:34:24 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0AKKYNqC029223
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 20:34:23 GMT
Subject: [PATCH v2 007/118] NFSD: Replace READ* macros in
 nfsd4_decode_stateid()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Fri, 20 Nov 2020 15:34:23 -0500
Message-ID: <160590446314.1340.5000887327010395359.stgit@klimt.1015granger.net>
In-Reply-To: <160590425404.1340.8850646771948736468.stgit@klimt.1015granger.net>
References: <160590425404.1340.8850646771948736468.stgit@klimt.1015granger.net>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

And also rename it to reflect the actual name of the stateid4 type
defined in RFC 8881.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4xdr.c |   61 +++++++++++++++++++++++++++--------------------------
 1 file changed, 31 insertions(+), 30 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 5ef14c41fabe..027582d682ae 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -426,15 +426,16 @@ nfsd4_decode_fattr(struct nfsd4_compoundargs *argp, u32 *bmval,
 }
 
 static __be32
-nfsd4_decode_stateid(struct nfsd4_compoundargs *argp, stateid_t *sid)
+nfsd4_decode_stateid4(struct nfsd4_compoundargs *argp, stateid_t *sid)
 {
-	DECODE_HEAD;
+	__be32 *p;
 
-	READ_BUF(sizeof(stateid_t));
+	p = xdr_inline_decode(argp->xdr, NFS4_STATEID_SIZE);
+	if (!p)
+		return nfserr_bad_xdr;
 	sid->si_generation = be32_to_cpup(p++);
-	COPYMEM(&sid->si_opaque, sizeof(stateid_opaque_t));
-
-	DECODE_TAIL;
+	memcpy(&sid->si_opaque, p, sizeof(sid->si_opaque));
+	return nfs_ok;
 }
 
 static __be32 nfsd4_decode_cb_sec(struct nfsd4_compoundargs *argp, struct nfsd4_cb_sec *cbs)
@@ -561,7 +562,7 @@ nfsd4_decode_close(struct nfsd4_compoundargs *argp, struct nfsd4_close *close)
 
 	READ_BUF(4);
 	close->cl_seqid = be32_to_cpup(p++);
-	return nfsd4_decode_stateid(argp, &close->cl_stateid);
+	return nfsd4_decode_stateid4(argp, &close->cl_stateid);
 
 	DECODE_TAIL;
 }
@@ -627,7 +628,7 @@ nfsd4_decode_create(struct nfsd4_compoundargs *argp, struct nfsd4_create *create
 static inline __be32
 nfsd4_decode_delegreturn(struct nfsd4_compoundargs *argp, struct nfsd4_delegreturn *dr)
 {
-	return nfsd4_decode_stateid(argp, &dr->dr_stateid);
+	return nfsd4_decode_stateid4(argp, &dr->dr_stateid);
 }
 
 static inline __be32
@@ -671,7 +672,7 @@ nfsd4_decode_lock(struct nfsd4_compoundargs *argp, struct nfsd4_lock *lock)
 	if (lock->lk_is_new) {
 		READ_BUF(4);
 		lock->lk_new_open_seqid = be32_to_cpup(p++);
-		status = nfsd4_decode_stateid(argp, &lock->lk_new_open_stateid);
+		status = nfsd4_decode_stateid4(argp, &lock->lk_new_open_stateid);
 		if (status)
 			return status;
 		READ_BUF(8 + sizeof(clientid_t));
@@ -681,7 +682,7 @@ nfsd4_decode_lock(struct nfsd4_compoundargs *argp, struct nfsd4_lock *lock)
 		READ_BUF(lock->lk_new_owner.len);
 		READMEM(lock->lk_new_owner.data, lock->lk_new_owner.len);
 	} else {
-		status = nfsd4_decode_stateid(argp, &lock->lk_old_lock_stateid);
+		status = nfsd4_decode_stateid4(argp, &lock->lk_old_lock_stateid);
 		if (status)
 			return status;
 		READ_BUF(4);
@@ -720,7 +721,7 @@ nfsd4_decode_locku(struct nfsd4_compoundargs *argp, struct nfsd4_locku *locku)
 	if ((locku->lu_type < NFS4_READ_LT) || (locku->lu_type > NFS4_WRITEW_LT))
 		goto xdr_error;
 	locku->lu_seqid = be32_to_cpup(p++);
-	status = nfsd4_decode_stateid(argp, &locku->lu_stateid);
+	status = nfsd4_decode_stateid4(argp, &locku->lu_stateid);
 	if (status)
 		return status;
 	READ_BUF(16);
@@ -913,7 +914,7 @@ nfsd4_decode_open(struct nfsd4_compoundargs *argp, struct nfsd4_open *open)
 		open->op_delegate_type = be32_to_cpup(p++);
 		break;
 	case NFS4_OPEN_CLAIM_DELEGATE_CUR:
-		status = nfsd4_decode_stateid(argp, &open->op_delegate_stateid);
+		status = nfsd4_decode_stateid4(argp, &open->op_delegate_stateid);
 		if (status)
 			return status;
 		READ_BUF(4);
@@ -932,7 +933,7 @@ nfsd4_decode_open(struct nfsd4_compoundargs *argp, struct nfsd4_open *open)
 	case NFS4_OPEN_CLAIM_DELEG_CUR_FH:
 		if (argp->minorversion < 1)
 			goto xdr_error;
-		status = nfsd4_decode_stateid(argp, &open->op_delegate_stateid);
+		status = nfsd4_decode_stateid4(argp, &open->op_delegate_stateid);
 		if (status)
 			return status;
 		break;
@@ -951,7 +952,7 @@ nfsd4_decode_open_confirm(struct nfsd4_compoundargs *argp, struct nfsd4_open_con
 	if (argp->minorversion >= 1)
 		return nfserr_notsupp;
 
-	status = nfsd4_decode_stateid(argp, &open_conf->oc_req_stateid);
+	status = nfsd4_decode_stateid4(argp, &open_conf->oc_req_stateid);
 	if (status)
 		return status;
 	READ_BUF(4);
@@ -965,7 +966,7 @@ nfsd4_decode_open_downgrade(struct nfsd4_compoundargs *argp, struct nfsd4_open_d
 {
 	DECODE_HEAD;
 		    
-	status = nfsd4_decode_stateid(argp, &open_down->od_stateid);
+	status = nfsd4_decode_stateid4(argp, &open_down->od_stateid);
 	if (status)
 		return status;
 	READ_BUF(4);
@@ -1008,7 +1009,7 @@ nfsd4_decode_read(struct nfsd4_compoundargs *argp, struct nfsd4_read *read)
 {
 	DECODE_HEAD;
 
-	status = nfsd4_decode_stateid(argp, &read->rd_stateid);
+	status = nfsd4_decode_stateid4(argp, &read->rd_stateid);
 	if (status)
 		return status;
 	READ_BUF(12);
@@ -1116,7 +1117,7 @@ nfsd4_decode_setattr(struct nfsd4_compoundargs *argp, struct nfsd4_setattr *seta
 {
 	__be32 status;
 
-	status = nfsd4_decode_stateid(argp, &setattr->sa_stateid);
+	status = nfsd4_decode_stateid4(argp, &setattr->sa_stateid);
 	if (status)
 		return status;
 	return nfsd4_decode_fattr(argp, setattr->sa_bmval, &setattr->sa_iattr,
@@ -1193,7 +1194,7 @@ nfsd4_decode_write(struct nfsd4_compoundargs *argp, struct nfsd4_write *write)
 {
 	DECODE_HEAD;
 
-	status = nfsd4_decode_stateid(argp, &write->wr_stateid);
+	status = nfsd4_decode_stateid4(argp, &write->wr_stateid);
 	if (status)
 		return status;
 	READ_BUF(16);
@@ -1438,7 +1439,7 @@ nfsd4_decode_test_stateid(struct nfsd4_compoundargs *argp, struct nfsd4_test_sta
 		INIT_LIST_HEAD(&stateid->ts_id_list);
 		list_add_tail(&stateid->ts_id_list, &test_stateid->ts_stateid_list);
 
-		status = nfsd4_decode_stateid(argp, &stateid->ts_id_stateid);
+		status = nfsd4_decode_stateid4(argp, &stateid->ts_id_stateid);
 		if (status)
 			goto out;
 	}
@@ -1514,7 +1515,7 @@ nfsd4_decode_layoutget(struct nfsd4_compoundargs *argp,
 	p = xdr_decode_hyper(p, &lgp->lg_seg.length);
 	p = xdr_decode_hyper(p, &lgp->lg_minlength);
 
-	status = nfsd4_decode_stateid(argp, &lgp->lg_sid);
+	status = nfsd4_decode_stateid4(argp, &lgp->lg_sid);
 	if (status)
 		return status;
 
@@ -1536,7 +1537,7 @@ nfsd4_decode_layoutcommit(struct nfsd4_compoundargs *argp,
 	p = xdr_decode_hyper(p, &lcp->lc_seg.length);
 	lcp->lc_reclaim = be32_to_cpup(p++);
 
-	status = nfsd4_decode_stateid(argp, &lcp->lc_sid);
+	status = nfsd4_decode_stateid4(argp, &lcp->lc_sid);
 	if (status)
 		return status;
 
@@ -1588,7 +1589,7 @@ nfsd4_decode_layoutreturn(struct nfsd4_compoundargs *argp,
 		p = xdr_decode_hyper(p, &lrp->lr_seg.offset);
 		p = xdr_decode_hyper(p, &lrp->lr_seg.length);
 
-		status = nfsd4_decode_stateid(argp, &lrp->lr_sid);
+		status = nfsd4_decode_stateid4(argp, &lrp->lr_sid);
 		if (status)
 			return status;
 
@@ -1613,7 +1614,7 @@ nfsd4_decode_fallocate(struct nfsd4_compoundargs *argp,
 {
 	DECODE_HEAD;
 
-	status = nfsd4_decode_stateid(argp, &fallocate->falloc_stateid);
+	status = nfsd4_decode_stateid4(argp, &fallocate->falloc_stateid);
 	if (status)
 		return status;
 
@@ -1629,10 +1630,10 @@ nfsd4_decode_clone(struct nfsd4_compoundargs *argp, struct nfsd4_clone *clone)
 {
 	DECODE_HEAD;
 
-	status = nfsd4_decode_stateid(argp, &clone->cl_src_stateid);
+	status = nfsd4_decode_stateid4(argp, &clone->cl_src_stateid);
 	if (status)
 		return status;
-	status = nfsd4_decode_stateid(argp, &clone->cl_dst_stateid);
+	status = nfsd4_decode_stateid4(argp, &clone->cl_dst_stateid);
 	if (status)
 		return status;
 
@@ -1685,10 +1686,10 @@ nfsd4_decode_copy(struct nfsd4_compoundargs *argp, struct nfsd4_copy *copy)
 	struct nl4_server *ns_dummy;
 	int i, count;
 
-	status = nfsd4_decode_stateid(argp, &copy->cp_src_stateid);
+	status = nfsd4_decode_stateid4(argp, &copy->cp_src_stateid);
 	if (status)
 		return status;
-	status = nfsd4_decode_stateid(argp, &copy->cp_dst_stateid);
+	status = nfsd4_decode_stateid4(argp, &copy->cp_dst_stateid);
 	if (status)
 		return status;
 
@@ -1732,7 +1733,7 @@ static __be32
 nfsd4_decode_offload_status(struct nfsd4_compoundargs *argp,
 			    struct nfsd4_offload_status *os)
 {
-	return nfsd4_decode_stateid(argp, &os->stateid);
+	return nfsd4_decode_stateid4(argp, &os->stateid);
 }
 
 static __be32
@@ -1741,7 +1742,7 @@ nfsd4_decode_copy_notify(struct nfsd4_compoundargs *argp,
 {
 	__be32 status;
 
-	status = nfsd4_decode_stateid(argp, &cn->cpn_src_stateid);
+	status = nfsd4_decode_stateid4(argp, &cn->cpn_src_stateid);
 	if (status)
 		return status;
 	return nfsd4_decode_nl4_server(argp, &cn->cpn_dst);
@@ -1752,7 +1753,7 @@ nfsd4_decode_seek(struct nfsd4_compoundargs *argp, struct nfsd4_seek *seek)
 {
 	DECODE_HEAD;
 
-	status = nfsd4_decode_stateid(argp, &seek->seek_stateid);
+	status = nfsd4_decode_stateid4(argp, &seek->seek_stateid);
 	if (status)
 		return status;
 


