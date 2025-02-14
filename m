Return-Path: <linux-nfs+bounces-10126-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9997BA36297
	for <lists+linux-nfs@lfdr.de>; Fri, 14 Feb 2025 17:03:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D2E63A87E5
	for <lists+linux-nfs@lfdr.de>; Fri, 14 Feb 2025 15:59:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B95E426770D;
	Fri, 14 Feb 2025 15:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VzAt66Pq"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 958D026738D
	for <linux-nfs@vger.kernel.org>; Fri, 14 Feb 2025 15:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739548672; cv=none; b=X4cqeSO/1SB1sisJETVWxNmlp+97B8tidzPSEGkUjCOPG5XpH32P0OPy+XvlWZrmxvAq1++qAKehdzZq0+bKPizNvF6nT9U4LJbxipnGutz4XA/kzyzezzwYkjie8VyhS31kyEWatXb1eoOxk+ewv1aHVWOTTSXH7yItTC5JjPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739548672; c=relaxed/simple;
	bh=Xu7KCb1VWPuRPNPIq+Q6ZEqjYKWcK/YdB2+TRse8TaQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A5EXDreS4C/D6NRna2wfsw6GR0VIFhkrJ2BO7PAMN2vEJ9Dgjjy93i8BlREfWBCpVAPEnRVxeVu5WTX9hf5znso5/Sj7fCo2Kwz3JP+s5KGyAM1+VHEogbrVEbeSo6eWbljJtGPO/k+WZz8/3GTlDNM4PcOpahl8LQkFEgJkBu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VzAt66Pq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 599D1C4CEEE;
	Fri, 14 Feb 2025 15:57:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739548672;
	bh=Xu7KCb1VWPuRPNPIq+Q6ZEqjYKWcK/YdB2+TRse8TaQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VzAt66Pq0D1D4VzlPgJmy+EJPbzqve5lPOlX6+oRwG8Ewv0+I+eXoD8+0mBPgn1nD
	 CieoYyvNHhxmIIWHizQpmHa1RvBGHA6+zSeEgQ1Vzco89DpFacIeZEQolkV09JW+Y/
	 nqkOvVrQF3GEW8MZ2MCXzyZDVKpMMYqjsoEl+mxqQe4g6mUaTDxdo5yzTyKj+vBtZ0
	 xsnDhjlWQr1435KgCV3M7KOx4w1UGEPlUt9LILN4CMo/qiGNTyb48+RPMRoXbwB/FK
	 2J/3x7wpiJ5KovCwU3lP5ewR0JSf9dOA1YYH2YK+FllI5SzOI9/Swmx4Ol4wCoqjkG
	 Q6E5+N7tVPfCA==
From: cel@kernel.org
To: Neil Brown <neilb@suse.de>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [RFC PATCH 2/3] NFSD: Implement CB_SEQUENCE referring call lists
Date: Fri, 14 Feb 2025 10:57:45 -0500
Message-ID: <20250214155746.18016-3-cel@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250214155746.18016-1-cel@kernel.org>
References: <20250214155746.18016-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

NFSD has yet to implement a mechanism for resolving races between
a server's reply and a related callback operation. For example,
a CB_OFFLOAD callback can race with the matching COPY response.
The client will not recognize the copy state ID in the CB_OFFLOAD
callback until the COPY response arrives.

Trond points out:
> It is also needed for the same kind of race with delegation
> recalls, layout recalls, CB_NOTIFY_DEVICEID and would also be
> helpful (although not as strongly required) for CB_NOTIFY_LOCK.

RFC 8881 Section 20.9.3 describes referring call lists this way:
> The csa_referring_call_lists array is the list of COMPOUND
> requests, identified by session ID, slot ID, and sequence ID.
> These are requests that the client previously sent to the server.
> These previous requests created state that some operation(s) in
> the same CB_COMPOUND as the csa_referring_call_lists are
> identifying. A session ID is included because leased state is tied
> to a client ID, and a client ID can have multiple sessions. See
> Section 2.10.6.3.

Introduce the XDR infrastructure for populating the
csa_referring_call_lists argument of CB_SEQUENCE. Subsequent patches
will put the referring call list to use.

Note that cb_sequence_enc_sz estimates that only zero or one rcl is
included in each CB_SEQUENCE, but the new infrastructure can
manage any number of referring calls.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4callback.c | 132 +++++++++++++++++++++++++++++++++++++++--
 fs/nfsd/state.h        |  22 +++++++
 fs/nfsd/xdr4cb.h       |   5 +-
 3 files changed, 153 insertions(+), 6 deletions(-)

diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
index 50e468bdb8d4..0bdae29cf0bb 100644
--- a/fs/nfsd/nfs4callback.c
+++ b/fs/nfsd/nfs4callback.c
@@ -419,6 +419,29 @@ static u32 highest_slotid(struct nfsd4_session *ses)
 	return idx;
 }
 
+static void
+encode_referring_call4(struct xdr_stream *xdr,
+		       const struct nfsd4_referring_call *rc)
+{
+	encode_uint32(xdr, rc->rc_sequenceid);
+	encode_uint32(xdr, rc->rc_slotid);
+}
+
+static void
+encode_referring_call_list4(struct xdr_stream *xdr,
+			    const struct nfsd4_referring_call_list *rcl)
+{
+	struct nfsd4_referring_call *rc;
+	__be32 *p;
+
+	p = xdr_reserve_space(xdr, NFS4_MAX_SESSIONID_LEN);
+	xdr_encode_opaque_fixed(p, rcl->rcl_sessionid.data,
+					NFS4_MAX_SESSIONID_LEN);
+	encode_uint32(xdr, rcl->__nr_referring_calls);
+	list_for_each_entry(rc, &rcl->rcl_referring_calls, __list)
+		encode_referring_call4(xdr, rc);
+}
+
 /*
  * CB_SEQUENCE4args
  *
@@ -436,6 +459,7 @@ static void encode_cb_sequence4args(struct xdr_stream *xdr,
 				    struct nfs4_cb_compound_hdr *hdr)
 {
 	struct nfsd4_session *session = cb->cb_clp->cl_cb_session;
+	struct nfsd4_referring_call_list *rcl;
 	__be32 *p;
 
 	if (hdr->minorversion == 0)
@@ -444,12 +468,16 @@ static void encode_cb_sequence4args(struct xdr_stream *xdr,
 	encode_nfs_cb_opnum4(xdr, OP_CB_SEQUENCE);
 	encode_sessionid4(xdr, session);
 
-	p = xdr_reserve_space(xdr, 4 + 4 + 4 + 4 + 4);
+	p = xdr_reserve_space(xdr, XDR_UNIT * 4);
 	*p++ = cpu_to_be32(session->se_cb_seq_nr[cb->cb_held_slot]);	/* csa_sequenceid */
 	*p++ = cpu_to_be32(cb->cb_held_slot);		/* csa_slotid */
 	*p++ = cpu_to_be32(highest_slotid(session)); /* csa_highest_slotid */
 	*p++ = xdr_zero;			/* csa_cachethis */
-	xdr_encode_empty_array(p);		/* csa_referring_call_lists */
+
+	/* csa_referring_call_lists */
+	encode_uint32(xdr, cb->cb_nr_referring_call_list);
+	list_for_each_entry(rcl, &cb->cb_referring_call_list, __list)
+		encode_referring_call_list4(xdr, rcl);
 
 	hdr->nops++;
 }
@@ -1306,10 +1334,102 @@ static void nfsd41_destroy_cb(struct nfsd4_callback *cb)
 	nfsd41_cb_inflight_end(clp);
 }
 
-/*
- * TODO: cb_sequence should support referring call lists, cachethis,
- * and mark callback channel down on communication errors.
+/**
+ * nfsd41_cb_referring_call - add a referring call to a callback operation
+ * @cb: context of callback to add the rc to
+ * @sessionid: referring call's session ID
+ * @slotid: referring call's session slot index
+ * @seqno: referring call's slot sequence number
+ *
+ * Caller serializes access to @cb.
+ *
+ * NB: If memory allocation fails, the referring call is not added.
  */
+void nfsd41_cb_referring_call(struct nfsd4_callback *cb,
+			      struct nfs4_sessionid *sessionid,
+			      u32 slotid, u32 seqno)
+{
+	struct nfsd4_referring_call_list *rcl;
+	struct nfsd4_referring_call *rc;
+	bool found;
+
+	might_sleep();
+
+	found = false;
+	list_for_each_entry(rcl, &cb->cb_referring_call_list, __list) {
+		if (!memcmp(rcl->rcl_sessionid.data, sessionid->data,
+			   NFS4_MAX_SESSIONID_LEN)) {
+			found = true;
+			break;
+		}
+	}
+	if (!found) {
+		rcl = kmalloc(sizeof(*rcl), GFP_KERNEL);
+		if (!rcl)
+			return;
+		memcpy(rcl->rcl_sessionid.data, sessionid->data,
+		       NFS4_MAX_SESSIONID_LEN);
+		rcl->__nr_referring_calls = 0;
+		INIT_LIST_HEAD(&rcl->rcl_referring_calls);
+		list_add(&rcl->__list, &cb->cb_referring_call_list);
+		cb->cb_nr_referring_call_list++;
+	}
+
+	found = false;
+	list_for_each_entry(rc, &rcl->rcl_referring_calls, __list) {
+		if (rc->rc_sequenceid == seqno && rc->rc_slotid == slotid) {
+			found = true;
+			break;
+		}
+	}
+	if (!found) {
+		rc = kmalloc(sizeof(*rc), GFP_KERNEL);
+		if (!rc)
+			goto out;
+		rc->rc_sequenceid = seqno;
+		rc->rc_slotid = slotid;
+		rcl->__nr_referring_calls++;
+		list_add(&rc->__list, &rcl->rcl_referring_calls);
+	}
+
+out:
+	if (!rcl->__nr_referring_calls) {
+		cb->cb_nr_referring_call_list--;
+		kfree(rcl);
+	}
+}
+
+/**
+ * nfsd41_cb_destroy_referring_call_list - release referring call info
+ * @cb: context of a callback that has completed
+ *
+ * Callers who allocate referring calls using nfsd41_cb_referring_call() must
+ * release those resources by calling nfsd41_cb_destroy_referring_call_list.
+ *
+ * Caller serializes access to @cb.
+ */
+void nfsd41_cb_destroy_referring_call_list(struct nfsd4_callback *cb)
+{
+	struct nfsd4_referring_call_list *rcl;
+	struct nfsd4_referring_call *rc;
+
+	while (!list_empty(&cb->cb_referring_call_list)) {
+		rcl = list_first_entry(&cb->cb_referring_call_list,
+				       struct nfsd4_referring_call_list,
+				       __list);
+
+		while (!list_empty(&rcl->rcl_referring_calls)) {
+			rc = list_first_entry(&rcl->rcl_referring_calls,
+					      struct nfsd4_referring_call,
+					      __list);
+			list_del(&rc->__list);
+			kfree(rc);
+		}
+		list_del(&rcl->__list);
+		kfree(rcl);
+	}
+}
+
 static void nfsd4_cb_prepare(struct rpc_task *task, void *calldata)
 {
 	struct nfsd4_callback *cb = calldata;
@@ -1622,6 +1742,8 @@ void nfsd4_init_cb(struct nfsd4_callback *cb, struct nfs4_client *clp,
 	cb->cb_status = 0;
 	cb->cb_need_restart = false;
 	cb->cb_held_slot = -1;
+	cb->cb_nr_referring_call_list = 0;
+	INIT_LIST_HEAD(&cb->cb_referring_call_list);
 }
 
 /**
diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
index 74d2d7b42676..b4af840fc4f9 100644
--- a/fs/nfsd/state.h
+++ b/fs/nfsd/state.h
@@ -64,6 +64,21 @@ typedef struct {
 	refcount_t		cs_count;
 } copy_stateid_t;
 
+struct nfsd4_referring_call {
+	struct list_head	__list;
+
+	u32			rc_sequenceid;
+	u32			rc_slotid;
+};
+
+struct nfsd4_referring_call_list {
+	struct list_head	__list;
+
+	struct nfs4_sessionid	rcl_sessionid;
+	int			__nr_referring_calls;
+	struct list_head	rcl_referring_calls;
+};
+
 struct nfsd4_callback {
 	struct nfs4_client *cb_clp;
 	struct rpc_message cb_msg;
@@ -73,6 +88,9 @@ struct nfsd4_callback {
 	int cb_status;
 	int cb_held_slot;
 	bool cb_need_restart;
+
+	int cb_nr_referring_call_list;
+	struct list_head cb_referring_call_list;
 };
 
 struct nfsd4_callback_ops {
@@ -777,6 +795,10 @@ extern __be32 nfs4_check_open_reclaim(struct nfs4_client *);
 extern void nfsd4_probe_callback(struct nfs4_client *clp);
 extern void nfsd4_probe_callback_sync(struct nfs4_client *clp);
 extern void nfsd4_change_callback(struct nfs4_client *clp, struct nfs4_cb_conn *);
+extern void nfsd41_cb_referring_call(struct nfsd4_callback *cb,
+				     struct nfs4_sessionid *sessionid,
+				     u32 slotid, u32 seqno);
+extern void nfsd41_cb_destroy_referring_call_list(struct nfsd4_callback *cb);
 extern void nfsd4_init_cb(struct nfsd4_callback *cb, struct nfs4_client *clp,
 		const struct nfsd4_callback_ops *ops, enum nfsd4_cb_op op);
 extern bool nfsd4_run_cb(struct nfsd4_callback *cb);
diff --git a/fs/nfsd/xdr4cb.h b/fs/nfsd/xdr4cb.h
index f1a315cd31b7..f4e29c0c701c 100644
--- a/fs/nfsd/xdr4cb.h
+++ b/fs/nfsd/xdr4cb.h
@@ -6,8 +6,11 @@
 #define cb_compound_enc_hdr_sz		4
 #define cb_compound_dec_hdr_sz		(3 + (NFS4_MAXTAGLEN >> 2))
 #define sessionid_sz			(NFS4_MAX_SESSIONID_LEN >> 2)
+#define enc_referring_call4_sz		(1 + 1)
+#define enc_referring_call_list4_sz	(sessionid_sz + 1 + \
+					enc_referring_call4_sz)
 #define cb_sequence_enc_sz		(sessionid_sz + 4 +             \
-					1 /* no referring calls list yet */)
+					enc_referring_call_list4_sz)
 #define cb_sequence_dec_sz		(op_dec_sz + sessionid_sz + 4)
 
 #define op_enc_sz			1
-- 
2.47.0


