Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D30222B1DF9
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Nov 2020 16:03:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726768AbgKMPDR (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 13 Nov 2020 10:03:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726746AbgKMPDQ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 13 Nov 2020 10:03:16 -0500
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3507FC0617A6
        for <linux-nfs@vger.kernel.org>; Fri, 13 Nov 2020 07:03:04 -0800 (PST)
Received: by mail-qt1-x842.google.com with SMTP id j31so6822097qtb.8
        for <linux-nfs@vger.kernel.org>; Fri, 13 Nov 2020 07:03:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=eLLQwoKcC18iMIoMv1izVgViwhMFF/Voc8Id1GLEMDY=;
        b=G6Oek43VIOwzVGC/V4u/xR9/KPyS5xptfEmvT31osVmPWIaH3BV7hKE2/TFacxmzwy
         JtREpO8qo0jgJJ1SfLWHI/gwx1SJR93u3xrlTAPtZ9+iEMQIwqHv9fMy1IR6gAEUstHv
         c1pdSfprIEKXrZy6CdRAHX58oeaRKlxv55Ggcb/Z/KpNugIYBqQcjk0xPr+xukDClnhB
         l8rMIzveBBxKa0Zxr2AZ40qBS3xLNvlPREXF7cLk6swg3derdHst/H34jts/JCpLCDeu
         YeFjt+npsJseswZSTIZQffl7qkX62LzPxjL2XuDHIBYI216FLy/EVScfqtzmZhZ2B8kd
         Lomw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=eLLQwoKcC18iMIoMv1izVgViwhMFF/Voc8Id1GLEMDY=;
        b=onDEA+kORHXCcsGLzcCuapL3FB06TunOlINPcVXlbW3TyeVhzErOW0cUizoveJ5mGa
         EqvPgDBvsfB/45Om7b28kTu86+7kqAZxPa7l//1uLAgw8LaY+xSeehJw2hXhKxmv6s3S
         7bPQUo/7EwaTiP50cWj9HstcJJAm4dJeLSwD3dXWGATFx1w/0U12QbLd5KzdZGPhWv+4
         R2cJS5PXZC4LQrbYUdxWtVM9ErntABrYGvrSb0KiwtPcwdCq2P1ddh7Ds3nT/yVosHW8
         zfAL6Mc0dJPfCbS6bPBD3Mbad1g/kP6ObohckxJ/ari4SD/cMn/A3bavke8KauqYQiLx
         nEjg==
X-Gm-Message-State: AOAM533SnR6AbweKI4vnKi4rS7IRd8JMnudsg4iLILv51TbT5ShpmjHO
        3zbvluwMmKMBIzfbObFkVe1V37O6I1E=
X-Google-Smtp-Source: ABdhPJz0+AJunKRtor2oZoNx31BqhH9f/WdoExYkvzyDKlvP+VL+X+rvnobrsmiphM29yZD+mgAMMA==
X-Received: by 2002:a05:622a:294:: with SMTP id z20mr2167382qtw.321.1605279782104;
        Fri, 13 Nov 2020 07:03:02 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id a1sm6549144qtw.11.2020.11.13.07.03.01
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Nov 2020 07:03:01 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0ADF30M4032658
        for <linux-nfs@vger.kernel.org>; Fri, 13 Nov 2020 15:03:00 GMT
Subject: [PATCH v1 07/61] NFSD: Replace READ* macros in nfsd4_decode_close()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Fri, 13 Nov 2020 10:03:00 -0500
Message-ID: <160527978038.6186.4530707404283867683.stgit@klimt.1015granger.net>
In-Reply-To: <160527962905.6186.17550620763636619885.stgit@klimt.1015granger.net>
References: <160527962905.6186.17550620763636619885.stgit@klimt.1015granger.net>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4xdr.c |   72 +++++++++++++++++++++++++++--------------------------
 1 file changed, 37 insertions(+), 35 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index ee9ba5f0faff..b04407d492bb 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -426,15 +426,18 @@ nfsd4_decode_fattr(struct nfsd4_compoundargs *argp, u32 *bmval,
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
+		goto xdr_error;
 	sid->si_generation = be32_to_cpup(p++);
-	COPYMEM(&sid->si_opaque, sizeof(stateid_opaque_t));
-
-	DECODE_TAIL;
+	memcpy(&sid->si_opaque, p, sizeof(sid->si_opaque));
+	return nfs_ok;
+xdr_error:
+	return nfserr_bad_xdr;
 }
 
 static __be32 nfsd4_decode_cb_sec(struct nfsd4_compoundargs *argp, struct nfsd4_cb_sec *cbs)
@@ -556,13 +559,12 @@ static __be32 nfsd4_decode_bind_conn_to_session(struct nfsd4_compoundargs *argp,
 static __be32
 nfsd4_decode_close(struct nfsd4_compoundargs *argp, struct nfsd4_close *close)
 {
-	DECODE_HEAD;
-
-	READ_BUF(4);
-	close->cl_seqid = be32_to_cpup(p++);
-	return nfsd4_decode_stateid(argp, &close->cl_stateid);
+	if (xdr_stream_decode_u32(argp->xdr, &close->cl_seqid) < 0)
+		goto xdr_error;
+	return nfsd4_decode_stateid4(argp, &close->cl_stateid);
 
-	DECODE_TAIL;
+xdr_error:
+	return nfserr_bad_xdr;
 }
 
 
@@ -626,7 +628,7 @@ nfsd4_decode_create(struct nfsd4_compoundargs *argp, struct nfsd4_create *create
 static inline __be32
 nfsd4_decode_delegreturn(struct nfsd4_compoundargs *argp, struct nfsd4_delegreturn *dr)
 {
-	return nfsd4_decode_stateid(argp, &dr->dr_stateid);
+	return nfsd4_decode_stateid4(argp, &dr->dr_stateid);
 }
 
 static inline __be32
@@ -670,7 +672,7 @@ nfsd4_decode_lock(struct nfsd4_compoundargs *argp, struct nfsd4_lock *lock)
 	if (lock->lk_is_new) {
 		READ_BUF(4);
 		lock->lk_new_open_seqid = be32_to_cpup(p++);
-		status = nfsd4_decode_stateid(argp, &lock->lk_new_open_stateid);
+		status = nfsd4_decode_stateid4(argp, &lock->lk_new_open_stateid);
 		if (status)
 			return status;
 		READ_BUF(8 + sizeof(clientid_t));
@@ -680,7 +682,7 @@ nfsd4_decode_lock(struct nfsd4_compoundargs *argp, struct nfsd4_lock *lock)
 		READ_BUF(lock->lk_new_owner.len);
 		READMEM(lock->lk_new_owner.data, lock->lk_new_owner.len);
 	} else {
-		status = nfsd4_decode_stateid(argp, &lock->lk_old_lock_stateid);
+		status = nfsd4_decode_stateid4(argp, &lock->lk_old_lock_stateid);
 		if (status)
 			return status;
 		READ_BUF(4);
@@ -719,7 +721,7 @@ nfsd4_decode_locku(struct nfsd4_compoundargs *argp, struct nfsd4_locku *locku)
 	if ((locku->lu_type < NFS4_READ_LT) || (locku->lu_type > NFS4_WRITEW_LT))
 		goto xdr_error;
 	locku->lu_seqid = be32_to_cpup(p++);
-	status = nfsd4_decode_stateid(argp, &locku->lu_stateid);
+	status = nfsd4_decode_stateid4(argp, &locku->lu_stateid);
 	if (status)
 		return status;
 	READ_BUF(16);
@@ -912,7 +914,7 @@ nfsd4_decode_open(struct nfsd4_compoundargs *argp, struct nfsd4_open *open)
 		open->op_delegate_type = be32_to_cpup(p++);
 		break;
 	case NFS4_OPEN_CLAIM_DELEGATE_CUR:
-		status = nfsd4_decode_stateid(argp, &open->op_delegate_stateid);
+		status = nfsd4_decode_stateid4(argp, &open->op_delegate_stateid);
 		if (status)
 			return status;
 		READ_BUF(4);
@@ -931,7 +933,7 @@ nfsd4_decode_open(struct nfsd4_compoundargs *argp, struct nfsd4_open *open)
 	case NFS4_OPEN_CLAIM_DELEG_CUR_FH:
 		if (argp->minorversion < 1)
 			goto xdr_error;
-		status = nfsd4_decode_stateid(argp, &open->op_delegate_stateid);
+		status = nfsd4_decode_stateid4(argp, &open->op_delegate_stateid);
 		if (status)
 			return status;
 		break;
@@ -950,7 +952,7 @@ nfsd4_decode_open_confirm(struct nfsd4_compoundargs *argp, struct nfsd4_open_con
 	if (argp->minorversion >= 1)
 		return nfserr_notsupp;
 
-	status = nfsd4_decode_stateid(argp, &open_conf->oc_req_stateid);
+	status = nfsd4_decode_stateid4(argp, &open_conf->oc_req_stateid);
 	if (status)
 		return status;
 	READ_BUF(4);
@@ -964,7 +966,7 @@ nfsd4_decode_open_downgrade(struct nfsd4_compoundargs *argp, struct nfsd4_open_d
 {
 	DECODE_HEAD;
 		    
-	status = nfsd4_decode_stateid(argp, &open_down->od_stateid);
+	status = nfsd4_decode_stateid4(argp, &open_down->od_stateid);
 	if (status)
 		return status;
 	READ_BUF(4);
@@ -1007,7 +1009,7 @@ nfsd4_decode_read(struct nfsd4_compoundargs *argp, struct nfsd4_read *read)
 {
 	DECODE_HEAD;
 
-	status = nfsd4_decode_stateid(argp, &read->rd_stateid);
+	status = nfsd4_decode_stateid4(argp, &read->rd_stateid);
 	if (status)
 		return status;
 	READ_BUF(12);
@@ -1115,7 +1117,7 @@ nfsd4_decode_setattr(struct nfsd4_compoundargs *argp, struct nfsd4_setattr *seta
 {
 	__be32 status;
 
-	status = nfsd4_decode_stateid(argp, &setattr->sa_stateid);
+	status = nfsd4_decode_stateid4(argp, &setattr->sa_stateid);
 	if (status)
 		return status;
 	return nfsd4_decode_fattr(argp, setattr->sa_bmval, &setattr->sa_iattr,
@@ -1192,7 +1194,7 @@ nfsd4_decode_write(struct nfsd4_compoundargs *argp, struct nfsd4_write *write)
 {
 	DECODE_HEAD;
 
-	status = nfsd4_decode_stateid(argp, &write->wr_stateid);
+	status = nfsd4_decode_stateid4(argp, &write->wr_stateid);
 	if (status)
 		return status;
 	READ_BUF(16);
@@ -1437,7 +1439,7 @@ nfsd4_decode_test_stateid(struct nfsd4_compoundargs *argp, struct nfsd4_test_sta
 		INIT_LIST_HEAD(&stateid->ts_id_list);
 		list_add_tail(&stateid->ts_id_list, &test_stateid->ts_stateid_list);
 
-		status = nfsd4_decode_stateid(argp, &stateid->ts_id_stateid);
+		status = nfsd4_decode_stateid4(argp, &stateid->ts_id_stateid);
 		if (status)
 			goto out;
 	}
@@ -1513,7 +1515,7 @@ nfsd4_decode_layoutget(struct nfsd4_compoundargs *argp,
 	p = xdr_decode_hyper(p, &lgp->lg_seg.length);
 	p = xdr_decode_hyper(p, &lgp->lg_minlength);
 
-	status = nfsd4_decode_stateid(argp, &lgp->lg_sid);
+	status = nfsd4_decode_stateid4(argp, &lgp->lg_sid);
 	if (status)
 		return status;
 
@@ -1535,7 +1537,7 @@ nfsd4_decode_layoutcommit(struct nfsd4_compoundargs *argp,
 	p = xdr_decode_hyper(p, &lcp->lc_seg.length);
 	lcp->lc_reclaim = be32_to_cpup(p++);
 
-	status = nfsd4_decode_stateid(argp, &lcp->lc_sid);
+	status = nfsd4_decode_stateid4(argp, &lcp->lc_sid);
 	if (status)
 		return status;
 
@@ -1587,7 +1589,7 @@ nfsd4_decode_layoutreturn(struct nfsd4_compoundargs *argp,
 		p = xdr_decode_hyper(p, &lrp->lr_seg.offset);
 		p = xdr_decode_hyper(p, &lrp->lr_seg.length);
 
-		status = nfsd4_decode_stateid(argp, &lrp->lr_sid);
+		status = nfsd4_decode_stateid4(argp, &lrp->lr_sid);
 		if (status)
 			return status;
 
@@ -1612,7 +1614,7 @@ nfsd4_decode_fallocate(struct nfsd4_compoundargs *argp,
 {
 	DECODE_HEAD;
 
-	status = nfsd4_decode_stateid(argp, &fallocate->falloc_stateid);
+	status = nfsd4_decode_stateid4(argp, &fallocate->falloc_stateid);
 	if (status)
 		return status;
 
@@ -1628,10 +1630,10 @@ nfsd4_decode_clone(struct nfsd4_compoundargs *argp, struct nfsd4_clone *clone)
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
 
@@ -1684,10 +1686,10 @@ nfsd4_decode_copy(struct nfsd4_compoundargs *argp, struct nfsd4_copy *copy)
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
 
@@ -1731,7 +1733,7 @@ static __be32
 nfsd4_decode_offload_status(struct nfsd4_compoundargs *argp,
 			    struct nfsd4_offload_status *os)
 {
-	return nfsd4_decode_stateid(argp, &os->stateid);
+	return nfsd4_decode_stateid4(argp, &os->stateid);
 }
 
 static __be32
@@ -1740,7 +1742,7 @@ nfsd4_decode_copy_notify(struct nfsd4_compoundargs *argp,
 {
 	__be32 status;
 
-	status = nfsd4_decode_stateid(argp, &cn->cpn_src_stateid);
+	status = nfsd4_decode_stateid4(argp, &cn->cpn_src_stateid);
 	if (status)
 		return status;
 	return nfsd4_decode_nl4_server(argp, &cn->cpn_dst);
@@ -1751,7 +1753,7 @@ nfsd4_decode_seek(struct nfsd4_compoundargs *argp, struct nfsd4_seek *seek)
 {
 	DECODE_HEAD;
 
-	status = nfsd4_decode_stateid(argp, &seek->seek_stateid);
+	status = nfsd4_decode_stateid4(argp, &seek->seek_stateid);
 	if (status)
 		return status;
 


