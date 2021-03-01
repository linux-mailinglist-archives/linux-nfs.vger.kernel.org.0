Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9926A32820F
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Mar 2021 16:17:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237083AbhCAPQp (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 1 Mar 2021 10:16:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:40216 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236981AbhCAPQH (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 1 Mar 2021 10:16:07 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3C894614A5
        for <linux-nfs@vger.kernel.org>; Mon,  1 Mar 2021 15:15:25 +0000 (UTC)
Subject: [PATCH v1 01/42] NFSD: Extract the svcxdr_init_encode() helper
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Mon, 01 Mar 2021 10:15:24 -0500
Message-ID: <161461172449.8508.5387365342766187229.stgit@klimt.1015granger.net>
In-Reply-To: <161461145466.8508.13379815439337754427.stgit@klimt.1015granger.net>
References: <161461145466.8508.13379815439337754427.stgit@klimt.1015granger.net>
User-Agent: StGit/1.0-5-g755c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

NFSD initializes an encode xdr_stream only after the RPC layer has
already inserted the RPC Reply header. Thus it behaves differently
than xdr_init_encode does, which assumes the passed-in xdr_buf is
entirely devoid of content.

nfs4proc.c has this server-side stream initialization helper, but
it is visible only to the NFSv4 code. Move this helper to a place
that can be accessed by NFSv2 and NFSv3 server XDR functions.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4proc.c         |   31 +++---------
 fs/nfsd/nfs4state.c        |    6 +-
 fs/nfsd/nfs4xdr.c          |  110 ++++++++++++++++++++++----------------------
 fs/nfsd/nfssvc.c           |    4 +-
 fs/nfsd/xdr4.h             |    2 -
 include/linux/sunrpc/svc.h |   25 ++++++++++
 6 files changed, 94 insertions(+), 84 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index acdb3cd806a1..b749033e467f 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -2262,25 +2262,6 @@ static bool need_wrongsec_check(struct svc_rqst *rqstp)
 	return !(nextd->op_flags & OP_HANDLES_WRONGSEC);
 }
 
-static void svcxdr_init_encode(struct svc_rqst *rqstp,
-			       struct nfsd4_compoundres *resp)
-{
-	struct xdr_stream *xdr = &resp->xdr;
-	struct xdr_buf *buf = &rqstp->rq_res;
-	struct kvec *head = buf->head;
-
-	xdr->buf = buf;
-	xdr->iov = head;
-	xdr->p   = head->iov_base + head->iov_len;
-	xdr->end = head->iov_base + PAGE_SIZE - rqstp->rq_auth_slack;
-	/* Tail and page_len should be zero at this point: */
-	buf->len = buf->head[0].iov_len;
-	xdr_reset_scratch_buffer(xdr);
-	xdr->page_ptr = buf->pages - 1;
-	buf->buflen = PAGE_SIZE * (1 + rqstp->rq_page_end - buf->pages)
-		- rqstp->rq_auth_slack;
-}
-
 #ifdef CONFIG_NFSD_V4_2_INTER_SSC
 static void
 check_if_stalefh_allowed(struct nfsd4_compoundargs *args)
@@ -2335,10 +2316,14 @@ nfsd4_proc_compound(struct svc_rqst *rqstp)
 	struct nfsd_net *nn = net_generic(SVC_NET(rqstp), nfsd_net_id);
 	__be32		status;
 
-	svcxdr_init_encode(rqstp, resp);
-	resp->tagp = resp->xdr.p;
+	resp->xdr = &rqstp->rq_res_stream;
+
+	/* reserve space for: NFS status code */
+	xdr_reserve_space(resp->xdr, XDR_UNIT);
+
+	resp->tagp = resp->xdr->p;
 	/* reserve space for: taglen, tag, and opcnt */
-	xdr_reserve_space(&resp->xdr, 8 + args->taglen);
+	xdr_reserve_space(resp->xdr, XDR_UNIT * 2 + args->taglen);
 	resp->taglen = args->taglen;
 	resp->tag = args->tag;
 	resp->rqstp = rqstp;
@@ -2444,7 +2429,7 @@ nfsd4_proc_compound(struct svc_rqst *rqstp)
 encode_op:
 		if (op->status == nfserr_replay_me) {
 			op->replay = &cstate->replay_owner->so_replay;
-			nfsd4_encode_replay(&resp->xdr, op);
+			nfsd4_encode_replay(resp->xdr, op);
 			status = op->status = op->replay->rp_status;
 		} else {
 			nfsd4_encode_operation(resp, op);
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 61552e89bd89..83a498ccab19 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -2903,7 +2903,7 @@ gen_callback(struct nfs4_client *clp, struct nfsd4_setclientid *se, struct svc_r
 static void
 nfsd4_store_cache_entry(struct nfsd4_compoundres *resp)
 {
-	struct xdr_buf *buf = resp->xdr.buf;
+	struct xdr_buf *buf = resp->xdr->buf;
 	struct nfsd4_slot *slot = resp->cstate.slot;
 	unsigned int base;
 
@@ -2973,7 +2973,7 @@ nfsd4_replay_cache_entry(struct nfsd4_compoundres *resp,
 			 struct nfsd4_sequence *seq)
 {
 	struct nfsd4_slot *slot = resp->cstate.slot;
-	struct xdr_stream *xdr = &resp->xdr;
+	struct xdr_stream *xdr = resp->xdr;
 	__be32 *p;
 	__be32 status;
 
@@ -3708,7 +3708,7 @@ nfsd4_sequence(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 {
 	struct nfsd4_sequence *seq = &u->sequence;
 	struct nfsd4_compoundres *resp = rqstp->rq_resp;
-	struct xdr_stream *xdr = &resp->xdr;
+	struct xdr_stream *xdr = resp->xdr;
 	struct nfsd4_session *session;
 	struct nfs4_client *clp;
 	struct nfsd4_slot *slot;
diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index eaaa1605b5b5..e0f06d3cbd44 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -3581,7 +3581,7 @@ nfsd4_encode_stateid(struct xdr_stream *xdr, stateid_t *sid)
 static __be32
 nfsd4_encode_access(struct nfsd4_compoundres *resp, __be32 nfserr, struct nfsd4_access *access)
 {
-	struct xdr_stream *xdr = &resp->xdr;
+	struct xdr_stream *xdr = resp->xdr;
 	__be32 *p;
 
 	p = xdr_reserve_space(xdr, 8);
@@ -3594,7 +3594,7 @@ nfsd4_encode_access(struct nfsd4_compoundres *resp, __be32 nfserr, struct nfsd4_
 
 static __be32 nfsd4_encode_bind_conn_to_session(struct nfsd4_compoundres *resp, __be32 nfserr, struct nfsd4_bind_conn_to_session *bcts)
 {
-	struct xdr_stream *xdr = &resp->xdr;
+	struct xdr_stream *xdr = resp->xdr;
 	__be32 *p;
 
 	p = xdr_reserve_space(xdr, NFS4_MAX_SESSIONID_LEN + 8);
@@ -3611,7 +3611,7 @@ static __be32 nfsd4_encode_bind_conn_to_session(struct nfsd4_compoundres *resp,
 static __be32
 nfsd4_encode_close(struct nfsd4_compoundres *resp, __be32 nfserr, struct nfsd4_close *close)
 {
-	struct xdr_stream *xdr = &resp->xdr;
+	struct xdr_stream *xdr = resp->xdr;
 
 	return nfsd4_encode_stateid(xdr, &close->cl_stateid);
 }
@@ -3620,7 +3620,7 @@ nfsd4_encode_close(struct nfsd4_compoundres *resp, __be32 nfserr, struct nfsd4_c
 static __be32
 nfsd4_encode_commit(struct nfsd4_compoundres *resp, __be32 nfserr, struct nfsd4_commit *commit)
 {
-	struct xdr_stream *xdr = &resp->xdr;
+	struct xdr_stream *xdr = resp->xdr;
 	__be32 *p;
 
 	p = xdr_reserve_space(xdr, NFS4_VERIFIER_SIZE);
@@ -3634,7 +3634,7 @@ nfsd4_encode_commit(struct nfsd4_compoundres *resp, __be32 nfserr, struct nfsd4_
 static __be32
 nfsd4_encode_create(struct nfsd4_compoundres *resp, __be32 nfserr, struct nfsd4_create *create)
 {
-	struct xdr_stream *xdr = &resp->xdr;
+	struct xdr_stream *xdr = resp->xdr;
 	__be32 *p;
 
 	p = xdr_reserve_space(xdr, 20);
@@ -3649,7 +3649,7 @@ static __be32
 nfsd4_encode_getattr(struct nfsd4_compoundres *resp, __be32 nfserr, struct nfsd4_getattr *getattr)
 {
 	struct svc_fh *fhp = getattr->ga_fhp;
-	struct xdr_stream *xdr = &resp->xdr;
+	struct xdr_stream *xdr = resp->xdr;
 
 	return nfsd4_encode_fattr(xdr, fhp, fhp->fh_export, fhp->fh_dentry,
 				    getattr->ga_bmval, resp->rqstp, 0);
@@ -3658,7 +3658,7 @@ nfsd4_encode_getattr(struct nfsd4_compoundres *resp, __be32 nfserr, struct nfsd4
 static __be32
 nfsd4_encode_getfh(struct nfsd4_compoundres *resp, __be32 nfserr, struct svc_fh **fhpp)
 {
-	struct xdr_stream *xdr = &resp->xdr;
+	struct xdr_stream *xdr = resp->xdr;
 	struct svc_fh *fhp = *fhpp;
 	unsigned int len;
 	__be32 *p;
@@ -3713,7 +3713,7 @@ nfsd4_encode_lock_denied(struct xdr_stream *xdr, struct nfsd4_lock_denied *ld)
 static __be32
 nfsd4_encode_lock(struct nfsd4_compoundres *resp, __be32 nfserr, struct nfsd4_lock *lock)
 {
-	struct xdr_stream *xdr = &resp->xdr;
+	struct xdr_stream *xdr = resp->xdr;
 
 	if (!nfserr)
 		nfserr = nfsd4_encode_stateid(xdr, &lock->lk_resp_stateid);
@@ -3726,7 +3726,7 @@ nfsd4_encode_lock(struct nfsd4_compoundres *resp, __be32 nfserr, struct nfsd4_lo
 static __be32
 nfsd4_encode_lockt(struct nfsd4_compoundres *resp, __be32 nfserr, struct nfsd4_lockt *lockt)
 {
-	struct xdr_stream *xdr = &resp->xdr;
+	struct xdr_stream *xdr = resp->xdr;
 
 	if (nfserr == nfserr_denied)
 		nfsd4_encode_lock_denied(xdr, &lockt->lt_denied);
@@ -3736,7 +3736,7 @@ nfsd4_encode_lockt(struct nfsd4_compoundres *resp, __be32 nfserr, struct nfsd4_l
 static __be32
 nfsd4_encode_locku(struct nfsd4_compoundres *resp, __be32 nfserr, struct nfsd4_locku *locku)
 {
-	struct xdr_stream *xdr = &resp->xdr;
+	struct xdr_stream *xdr = resp->xdr;
 
 	return nfsd4_encode_stateid(xdr, &locku->lu_stateid);
 }
@@ -3745,7 +3745,7 @@ nfsd4_encode_locku(struct nfsd4_compoundres *resp, __be32 nfserr, struct nfsd4_l
 static __be32
 nfsd4_encode_link(struct nfsd4_compoundres *resp, __be32 nfserr, struct nfsd4_link *link)
 {
-	struct xdr_stream *xdr = &resp->xdr;
+	struct xdr_stream *xdr = resp->xdr;
 	__be32 *p;
 
 	p = xdr_reserve_space(xdr, 20);
@@ -3759,7 +3759,7 @@ nfsd4_encode_link(struct nfsd4_compoundres *resp, __be32 nfserr, struct nfsd4_li
 static __be32
 nfsd4_encode_open(struct nfsd4_compoundres *resp, __be32 nfserr, struct nfsd4_open *open)
 {
-	struct xdr_stream *xdr = &resp->xdr;
+	struct xdr_stream *xdr = resp->xdr;
 	__be32 *p;
 
 	nfserr = nfsd4_encode_stateid(xdr, &open->op_stateid);
@@ -3853,7 +3853,7 @@ nfsd4_encode_open(struct nfsd4_compoundres *resp, __be32 nfserr, struct nfsd4_op
 static __be32
 nfsd4_encode_open_confirm(struct nfsd4_compoundres *resp, __be32 nfserr, struct nfsd4_open_confirm *oc)
 {
-	struct xdr_stream *xdr = &resp->xdr;
+	struct xdr_stream *xdr = resp->xdr;
 
 	return nfsd4_encode_stateid(xdr, &oc->oc_resp_stateid);
 }
@@ -3861,7 +3861,7 @@ nfsd4_encode_open_confirm(struct nfsd4_compoundres *resp, __be32 nfserr, struct
 static __be32
 nfsd4_encode_open_downgrade(struct nfsd4_compoundres *resp, __be32 nfserr, struct nfsd4_open_downgrade *od)
 {
-	struct xdr_stream *xdr = &resp->xdr;
+	struct xdr_stream *xdr = resp->xdr;
 
 	return nfsd4_encode_stateid(xdr, &od->od_stateid);
 }
@@ -3871,7 +3871,7 @@ static __be32 nfsd4_encode_splice_read(
 				struct nfsd4_read *read,
 				struct file *file, unsigned long maxcount)
 {
-	struct xdr_stream *xdr = &resp->xdr;
+	struct xdr_stream *xdr = resp->xdr;
 	struct xdr_buf *buf = xdr->buf;
 	int status, space_left;
 	u32 eof;
@@ -3937,7 +3937,7 @@ static __be32 nfsd4_encode_readv(struct nfsd4_compoundres *resp,
 				 struct nfsd4_read *read,
 				 struct file *file, unsigned long maxcount)
 {
-	struct xdr_stream *xdr = &resp->xdr;
+	struct xdr_stream *xdr = resp->xdr;
 	u32 eof;
 	int starting_len = xdr->buf->len - 8;
 	__be32 nfserr;
@@ -3976,7 +3976,7 @@ nfsd4_encode_read(struct nfsd4_compoundres *resp, __be32 nfserr,
 		  struct nfsd4_read *read)
 {
 	unsigned long maxcount;
-	struct xdr_stream *xdr = &resp->xdr;
+	struct xdr_stream *xdr = resp->xdr;
 	struct file *file;
 	int starting_len = xdr->buf->len;
 	__be32 *p;
@@ -3990,7 +3990,7 @@ nfsd4_encode_read(struct nfsd4_compoundres *resp, __be32 nfserr,
 		WARN_ON_ONCE(test_bit(RQ_SPLICE_OK, &resp->rqstp->rq_flags));
 		return nfserr_resource;
 	}
-	if (resp->xdr.buf->page_len &&
+	if (resp->xdr->buf->page_len &&
 	    test_bit(RQ_SPLICE_OK, &resp->rqstp->rq_flags)) {
 		WARN_ON_ONCE(1);
 		return nfserr_resource;
@@ -4020,7 +4020,7 @@ nfsd4_encode_readlink(struct nfsd4_compoundres *resp, __be32 nfserr, struct nfsd
 	int maxcount;
 	__be32 wire_count;
 	int zero = 0;
-	struct xdr_stream *xdr = &resp->xdr;
+	struct xdr_stream *xdr = resp->xdr;
 	int length_offset = xdr->buf->len;
 	int status;
 	__be32 *p;
@@ -4072,7 +4072,7 @@ nfsd4_encode_readdir(struct nfsd4_compoundres *resp, __be32 nfserr, struct nfsd4
 	int bytes_left;
 	loff_t offset;
 	__be64 wire_offset;
-	struct xdr_stream *xdr = &resp->xdr;
+	struct xdr_stream *xdr = resp->xdr;
 	int starting_len = xdr->buf->len;
 	__be32 *p;
 
@@ -4083,8 +4083,8 @@ nfsd4_encode_readdir(struct nfsd4_compoundres *resp, __be32 nfserr, struct nfsd4
 	/* XXX: Following NFSv3, we ignore the READDIR verifier for now. */
 	*p++ = cpu_to_be32(0);
 	*p++ = cpu_to_be32(0);
-	resp->xdr.buf->head[0].iov_len = ((char *)resp->xdr.p)
-				- (char *)resp->xdr.buf->head[0].iov_base;
+	xdr->buf->head[0].iov_len = (char *)xdr->p -
+				    (char *)xdr->buf->head[0].iov_base;
 
 	/*
 	 * Number of bytes left for directory entries allowing for the
@@ -4159,7 +4159,7 @@ nfsd4_encode_readdir(struct nfsd4_compoundres *resp, __be32 nfserr, struct nfsd4
 static __be32
 nfsd4_encode_remove(struct nfsd4_compoundres *resp, __be32 nfserr, struct nfsd4_remove *remove)
 {
-	struct xdr_stream *xdr = &resp->xdr;
+	struct xdr_stream *xdr = resp->xdr;
 	__be32 *p;
 
 	p = xdr_reserve_space(xdr, 20);
@@ -4172,7 +4172,7 @@ nfsd4_encode_remove(struct nfsd4_compoundres *resp, __be32 nfserr, struct nfsd4_
 static __be32
 nfsd4_encode_rename(struct nfsd4_compoundres *resp, __be32 nfserr, struct nfsd4_rename *rename)
 {
-	struct xdr_stream *xdr = &resp->xdr;
+	struct xdr_stream *xdr = resp->xdr;
 	__be32 *p;
 
 	p = xdr_reserve_space(xdr, 40);
@@ -4255,7 +4255,7 @@ static __be32
 nfsd4_encode_secinfo(struct nfsd4_compoundres *resp, __be32 nfserr,
 		     struct nfsd4_secinfo *secinfo)
 {
-	struct xdr_stream *xdr = &resp->xdr;
+	struct xdr_stream *xdr = resp->xdr;
 
 	return nfsd4_do_encode_secinfo(xdr, secinfo->si_exp);
 }
@@ -4264,7 +4264,7 @@ static __be32
 nfsd4_encode_secinfo_no_name(struct nfsd4_compoundres *resp, __be32 nfserr,
 		     struct nfsd4_secinfo_no_name *secinfo)
 {
-	struct xdr_stream *xdr = &resp->xdr;
+	struct xdr_stream *xdr = resp->xdr;
 
 	return nfsd4_do_encode_secinfo(xdr, secinfo->sin_exp);
 }
@@ -4276,7 +4276,7 @@ nfsd4_encode_secinfo_no_name(struct nfsd4_compoundres *resp, __be32 nfserr,
 static __be32
 nfsd4_encode_setattr(struct nfsd4_compoundres *resp, __be32 nfserr, struct nfsd4_setattr *setattr)
 {
-	struct xdr_stream *xdr = &resp->xdr;
+	struct xdr_stream *xdr = resp->xdr;
 	__be32 *p;
 
 	p = xdr_reserve_space(xdr, 16);
@@ -4300,7 +4300,7 @@ nfsd4_encode_setattr(struct nfsd4_compoundres *resp, __be32 nfserr, struct nfsd4
 static __be32
 nfsd4_encode_setclientid(struct nfsd4_compoundres *resp, __be32 nfserr, struct nfsd4_setclientid *scd)
 {
-	struct xdr_stream *xdr = &resp->xdr;
+	struct xdr_stream *xdr = resp->xdr;
 	__be32 *p;
 
 	if (!nfserr) {
@@ -4324,7 +4324,7 @@ nfsd4_encode_setclientid(struct nfsd4_compoundres *resp, __be32 nfserr, struct n
 static __be32
 nfsd4_encode_write(struct nfsd4_compoundres *resp, __be32 nfserr, struct nfsd4_write *write)
 {
-	struct xdr_stream *xdr = &resp->xdr;
+	struct xdr_stream *xdr = resp->xdr;
 	__be32 *p;
 
 	p = xdr_reserve_space(xdr, 16);
@@ -4341,7 +4341,7 @@ static __be32
 nfsd4_encode_exchange_id(struct nfsd4_compoundres *resp, __be32 nfserr,
 			 struct nfsd4_exchange_id *exid)
 {
-	struct xdr_stream *xdr = &resp->xdr;
+	struct xdr_stream *xdr = resp->xdr;
 	__be32 *p;
 	char *major_id;
 	char *server_scope;
@@ -4419,7 +4419,7 @@ static __be32
 nfsd4_encode_create_session(struct nfsd4_compoundres *resp, __be32 nfserr,
 			    struct nfsd4_create_session *sess)
 {
-	struct xdr_stream *xdr = &resp->xdr;
+	struct xdr_stream *xdr = resp->xdr;
 	__be32 *p;
 
 	p = xdr_reserve_space(xdr, 24);
@@ -4472,7 +4472,7 @@ static __be32
 nfsd4_encode_sequence(struct nfsd4_compoundres *resp, __be32 nfserr,
 		      struct nfsd4_sequence *seq)
 {
-	struct xdr_stream *xdr = &resp->xdr;
+	struct xdr_stream *xdr = resp->xdr;
 	__be32 *p;
 
 	p = xdr_reserve_space(xdr, NFS4_MAX_SESSIONID_LEN + 20);
@@ -4495,7 +4495,7 @@ static __be32
 nfsd4_encode_test_stateid(struct nfsd4_compoundres *resp, __be32 nfserr,
 			  struct nfsd4_test_stateid *test_stateid)
 {
-	struct xdr_stream *xdr = &resp->xdr;
+	struct xdr_stream *xdr = resp->xdr;
 	struct nfsd4_test_stateid_id *stateid, *next;
 	__be32 *p;
 
@@ -4516,7 +4516,7 @@ static __be32
 nfsd4_encode_getdeviceinfo(struct nfsd4_compoundres *resp, __be32 nfserr,
 		struct nfsd4_getdeviceinfo *gdev)
 {
-	struct xdr_stream *xdr = &resp->xdr;
+	struct xdr_stream *xdr = resp->xdr;
 	const struct nfsd4_layout_ops *ops;
 	u32 starting_len = xdr->buf->len, needed_len;
 	__be32 *p;
@@ -4572,7 +4572,7 @@ static __be32
 nfsd4_encode_layoutget(struct nfsd4_compoundres *resp, __be32 nfserr,
 		struct nfsd4_layoutget *lgp)
 {
-	struct xdr_stream *xdr = &resp->xdr;
+	struct xdr_stream *xdr = resp->xdr;
 	const struct nfsd4_layout_ops *ops;
 	__be32 *p;
 
@@ -4599,7 +4599,7 @@ static __be32
 nfsd4_encode_layoutcommit(struct nfsd4_compoundres *resp, __be32 nfserr,
 			  struct nfsd4_layoutcommit *lcp)
 {
-	struct xdr_stream *xdr = &resp->xdr;
+	struct xdr_stream *xdr = resp->xdr;
 	__be32 *p;
 
 	p = xdr_reserve_space(xdr, 4);
@@ -4620,7 +4620,7 @@ static __be32
 nfsd4_encode_layoutreturn(struct nfsd4_compoundres *resp, __be32 nfserr,
 		struct nfsd4_layoutreturn *lrp)
 {
-	struct xdr_stream *xdr = &resp->xdr;
+	struct xdr_stream *xdr = resp->xdr;
 	__be32 *p;
 
 	p = xdr_reserve_space(xdr, 4);
@@ -4638,7 +4638,7 @@ nfsd42_encode_write_res(struct nfsd4_compoundres *resp,
 		struct nfsd42_write_res *write, bool sync)
 {
 	__be32 *p;
-	p = xdr_reserve_space(&resp->xdr, 4);
+	p = xdr_reserve_space(resp->xdr, 4);
 	if (!p)
 		return nfserr_resource;
 
@@ -4647,11 +4647,11 @@ nfsd42_encode_write_res(struct nfsd4_compoundres *resp,
 	else {
 		__be32 nfserr;
 		*p++ = cpu_to_be32(1);
-		nfserr = nfsd4_encode_stateid(&resp->xdr, &write->cb_stateid);
+		nfserr = nfsd4_encode_stateid(resp->xdr, &write->cb_stateid);
 		if (nfserr)
 			return nfserr;
 	}
-	p = xdr_reserve_space(&resp->xdr, 8 + 4 + NFS4_VERIFIER_SIZE);
+	p = xdr_reserve_space(resp->xdr, 8 + 4 + NFS4_VERIFIER_SIZE);
 	if (!p)
 		return nfserr_resource;
 
@@ -4665,7 +4665,7 @@ nfsd42_encode_write_res(struct nfsd4_compoundres *resp,
 static __be32
 nfsd42_encode_nl4_server(struct nfsd4_compoundres *resp, struct nl4_server *ns)
 {
-	struct xdr_stream *xdr = &resp->xdr;
+	struct xdr_stream *xdr = resp->xdr;
 	struct nfs42_netaddr *addr;
 	__be32 *p;
 
@@ -4713,7 +4713,7 @@ nfsd4_encode_copy(struct nfsd4_compoundres *resp, __be32 nfserr,
 	if (nfserr)
 		return nfserr;
 
-	p = xdr_reserve_space(&resp->xdr, 4 + 4);
+	p = xdr_reserve_space(resp->xdr, 4 + 4);
 	*p++ = xdr_one; /* cr_consecutive */
 	*p++ = cpu_to_be32(copy->cp_synchronous);
 	return 0;
@@ -4723,7 +4723,7 @@ static __be32
 nfsd4_encode_offload_status(struct nfsd4_compoundres *resp, __be32 nfserr,
 			    struct nfsd4_offload_status *os)
 {
-	struct xdr_stream *xdr = &resp->xdr;
+	struct xdr_stream *xdr = resp->xdr;
 	__be32 *p;
 
 	p = xdr_reserve_space(xdr, 8 + 4);
@@ -4740,7 +4740,7 @@ nfsd4_encode_read_plus_data(struct nfsd4_compoundres *resp,
 			    unsigned long *maxcount, u32 *eof,
 			    loff_t *pos)
 {
-	struct xdr_stream *xdr = &resp->xdr;
+	struct xdr_stream *xdr = resp->xdr;
 	struct file *file = read->rd_nf->nf_file;
 	int starting_len = xdr->buf->len;
 	loff_t hole_pos;
@@ -4799,7 +4799,7 @@ nfsd4_encode_read_plus_hole(struct nfsd4_compoundres *resp,
 	count = data_pos - read->rd_offset;
 
 	/* Content type, offset, byte count */
-	p = xdr_reserve_space(&resp->xdr, 4 + 8 + 8);
+	p = xdr_reserve_space(resp->xdr, 4 + 8 + 8);
 	if (!p)
 		return nfserr_resource;
 
@@ -4817,7 +4817,7 @@ nfsd4_encode_read_plus(struct nfsd4_compoundres *resp, __be32 nfserr,
 		       struct nfsd4_read *read)
 {
 	unsigned long maxcount, count;
-	struct xdr_stream *xdr = &resp->xdr;
+	struct xdr_stream *xdr = resp->xdr;
 	struct file *file;
 	int starting_len = xdr->buf->len;
 	int last_segment = xdr->buf->len;
@@ -4888,7 +4888,7 @@ static __be32
 nfsd4_encode_copy_notify(struct nfsd4_compoundres *resp, __be32 nfserr,
 			 struct nfsd4_copy_notify *cn)
 {
-	struct xdr_stream *xdr = &resp->xdr;
+	struct xdr_stream *xdr = resp->xdr;
 	__be32 *p;
 
 	if (nfserr)
@@ -4924,7 +4924,7 @@ nfsd4_encode_seek(struct nfsd4_compoundres *resp, __be32 nfserr,
 {
 	__be32 *p;
 
-	p = xdr_reserve_space(&resp->xdr, 4 + 8);
+	p = xdr_reserve_space(resp->xdr, 4 + 8);
 	*p++ = cpu_to_be32(seek->seek_eof);
 	p = xdr_encode_hyper(p, seek->seek_pos);
 
@@ -4985,7 +4985,7 @@ static __be32
 nfsd4_encode_getxattr(struct nfsd4_compoundres *resp, __be32 nfserr,
 		      struct nfsd4_getxattr *getxattr)
 {
-	struct xdr_stream *xdr = &resp->xdr;
+	struct xdr_stream *xdr = resp->xdr;
 	__be32 *p, err;
 
 	p = xdr_reserve_space(xdr, 4);
@@ -5009,7 +5009,7 @@ static __be32
 nfsd4_encode_setxattr(struct nfsd4_compoundres *resp, __be32 nfserr,
 		      struct nfsd4_setxattr *setxattr)
 {
-	struct xdr_stream *xdr = &resp->xdr;
+	struct xdr_stream *xdr = resp->xdr;
 	__be32 *p;
 
 	p = xdr_reserve_space(xdr, 20);
@@ -5050,7 +5050,7 @@ static __be32
 nfsd4_encode_listxattrs(struct nfsd4_compoundres *resp, __be32 nfserr,
 			struct nfsd4_listxattrs *listxattrs)
 {
-	struct xdr_stream *xdr = &resp->xdr;
+	struct xdr_stream *xdr = resp->xdr;
 	u32 cookie_offset, count_offset, eof;
 	u32 left, xdrleft, slen, count;
 	u32 xdrlen, offset;
@@ -5161,7 +5161,7 @@ static __be32
 nfsd4_encode_removexattr(struct nfsd4_compoundres *resp, __be32 nfserr,
 			 struct nfsd4_removexattr *removexattr)
 {
-	struct xdr_stream *xdr = &resp->xdr;
+	struct xdr_stream *xdr = resp->xdr;
 	__be32 *p;
 
 	p = xdr_reserve_space(xdr, 20);
@@ -5301,7 +5301,7 @@ __be32 nfsd4_check_resp_size(struct nfsd4_compoundres *resp, u32 respsize)
 void
 nfsd4_encode_operation(struct nfsd4_compoundres *resp, struct nfsd4_op *op)
 {
-	struct xdr_stream *xdr = &resp->xdr;
+	struct xdr_stream *xdr = resp->xdr;
 	struct nfs4_stateowner *so = resp->cstate.replay_owner;
 	struct svc_rqst *rqstp = resp->rqstp;
 	const struct nfsd4_operation *opdesc = op->opdesc;
@@ -5430,14 +5430,14 @@ int
 nfs4svc_encode_compoundres(struct svc_rqst *rqstp, __be32 *p)
 {
 	struct nfsd4_compoundres *resp = rqstp->rq_resp;
-	struct xdr_buf *buf = resp->xdr.buf;
+	struct xdr_buf *buf = resp->xdr->buf;
 
 	WARN_ON_ONCE(buf->len != buf->head[0].iov_len + buf->page_len +
 				 buf->tail[0].iov_len);
 
 	*p = resp->cstate.status;
 
-	rqstp->rq_next_page = resp->xdr.page_ptr + 1;
+	rqstp->rq_next_page = resp->xdr->page_ptr + 1;
 
 	p = resp->tagp;
 	*p++ = htonl(resp->taglen);
diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index 6de406322106..d909e4956244 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -997,7 +997,7 @@ int nfsd_dispatch(struct svc_rqst *rqstp, __be32 *statp)
 	 * NFSv4 does some encoding while processing
 	 */
 	p = resv->iov_base + resv->iov_len;
-	resv->iov_len += sizeof(__be32);
+	svcxdr_init_encode(rqstp);
 
 	*statp = proc->pc_func(rqstp);
 	if (*statp == rpc_drop_reply || test_bit(RQ_DROPME, &rqstp->rq_flags))
@@ -1052,7 +1052,7 @@ int nfssvc_decode_voidarg(struct svc_rqst *rqstp, __be32 *p)
  */
 int nfssvc_encode_voidres(struct svc_rqst *rqstp, __be32 *p)
 {
-        return xdr_ressize_check(rqstp, p);
+	return 1;
 }
 
 int nfsd_pool_stats_open(struct inode *inode, struct file *file)
diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
index c300885ae75d..fe540a3415c6 100644
--- a/fs/nfsd/xdr4.h
+++ b/fs/nfsd/xdr4.h
@@ -698,7 +698,7 @@ struct nfsd4_compoundargs {
 
 struct nfsd4_compoundres {
 	/* scratch variables for XDR encode */
-	struct xdr_stream		xdr;
+	struct xdr_stream		*xdr;
 	struct svc_rqst *		rqstp;
 
 	u32				taglen;
diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
index 31ee3b6047c3..e91d51ea028b 100644
--- a/include/linux/sunrpc/svc.h
+++ b/include/linux/sunrpc/svc.h
@@ -248,6 +248,7 @@ struct svc_rqst {
 	size_t			rq_xprt_hlen;	/* xprt header len */
 	struct xdr_buf		rq_arg;
 	struct xdr_stream	rq_arg_stream;
+	struct xdr_stream	rq_res_stream;
 	struct page		*rq_scratch_page;
 	struct xdr_buf		rq_res;
 	struct page		*rq_pages[RPCSVC_MAXPAGES + 1];
@@ -574,4 +575,28 @@ static inline void svcxdr_init_decode(struct svc_rqst *rqstp)
 	xdr_set_scratch_page(xdr, rqstp->rq_scratch_page);
 }
 
+/**
+ * svcxdr_init_encode - Prepare an xdr_stream for svc Reply encoding
+ * @rqstp: controlling server RPC transaction context
+ *
+ */
+static inline void svcxdr_init_encode(struct svc_rqst *rqstp)
+{
+	struct xdr_stream *xdr = &rqstp->rq_res_stream;
+	struct xdr_buf *buf = &rqstp->rq_res;
+	struct kvec *resv = buf->head;
+
+	xdr_reset_scratch_buffer(xdr);
+
+	xdr->buf = buf;
+	xdr->iov = resv;
+	xdr->p   = resv->iov_base + resv->iov_len;
+	xdr->end = resv->iov_base + PAGE_SIZE - rqstp->rq_auth_slack;
+	buf->len = resv->iov_len;
+	xdr->page_ptr = buf->pages - 1;
+	buf->buflen = PAGE_SIZE * (1 + rqstp->rq_page_end - buf->pages);
+	buf->buflen -= rqstp->rq_auth_slack;
+	xdr->rqst = NULL;
+}
+
 #endif /* SUNRPC_SVC_H */


