Return-Path: <linux-nfs+bounces-10403-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3225EA4AD5F
	for <lists+linux-nfs@lfdr.de>; Sat,  1 Mar 2025 19:32:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B83B51896D76
	for <lists+linux-nfs@lfdr.de>; Sat,  1 Mar 2025 18:32:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87BA51E5B8D;
	Sat,  1 Mar 2025 18:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GcfHMiq5"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62B4070808
	for <linux-nfs@vger.kernel.org>; Sat,  1 Mar 2025 18:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740853920; cv=none; b=bbRTNz725wTiqqRBAW35R1covUCozVqrmH4y20jtMwcSWmKg6r6IPE/BRXie05BKQIK6RokW1SzVPfeXuPhMrzN8ccIZ/unhn3X9qSYVvCMZVfh6ZVdxA7YGXE1JdOPdMPKoDP1OoQ/ZtM/FSHrO89rmUlBlVaAWUV58bPydzDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740853920; c=relaxed/simple;
	bh=JbfakIFrF6miKJDOEy4NTY3WujsJoSrvbVTZpKBoTsk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BjIZSx3FvqO0BX368TfomaxbYhR5j3h6uJNpd4zPVOSYueIb9dRJkECux+8tEMdjwLbD8plsQvFOIDOiaPOx58S9CY0T5k6FNk94zai4vIayMArGN0yA3yasHgm/m9O0pNcM9+N0Ee4jV65SUoyg5IXEM0bsE+tFJuooJDD05Tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GcfHMiq5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 238A6C4CEE2;
	Sat,  1 Mar 2025 18:31:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740853919;
	bh=JbfakIFrF6miKJDOEy4NTY3WujsJoSrvbVTZpKBoTsk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GcfHMiq51n2x8cIXMBMmreJwrlp7qlvcV4hMiEw49u+MkkoicIU22wgQDBFQ97x9H
	 Lz5GdLb6WoO/c6uoJ3vmaAF5oh6DKlO3jqB83snRLbeQ5g/FGBG2XHydvnytMz7osz
	 +FtY4/gmX8LLvBq3/H3HpdmBayGH5DMjxAQjT0Qjk4pY1H3uoiNbAQ7yjRxPmXVPwe
	 ebcqFh5lq5mRfF6ZOlRtJBbILyFdOQofzufxvrtIW82id5qYu9dnhSSVYXKdMGEZ2+
	 TCc9zMb3kfjweh8u/jkQGdDx+iNqlwliabOTmnCd5jJ1RICqlPid+bl1wdK3eBcjTy
	 idZTDUma2QfZg==
From: cel@kernel.org
To: Neil Brown <neilb@suse.de>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Trond Myklebust <trondmy@hammerspace.com>
Subject: [PATCH v2 5/5] NFSD: Use a referring call list for CB_OFFLOAD
Date: Sat,  1 Mar 2025 13:31:51 -0500
Message-ID: <20250301183151.11362-6-cel@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250301183151.11362-1-cel@kernel.org>
References: <20250301183151.11362-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

Help the client resolve the race between the reply to an
asynchronous COPY reply and the associated CB_OFFLOAD callback by
planting the session, slot, and sequence number of the COPY in the
CB_SEQUENCE contained in the CB_OFFLOAD COMPOUND.

Suggested-by: Trond Myklebust <trondmy@hammerspace.com>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4proc.c | 9 +++++++++
 fs/nfsd/xdr4.h     | 4 ++++
 2 files changed, 13 insertions(+)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 3431b695882d..48c1e3600d75 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -1716,6 +1716,7 @@ static int nfsd4_cb_offload_done(struct nfsd4_callback *cb,
 			return 0;
 		}
 	}
+	nfsd41_cb_destroy_referring_call_list(cb);
 	return 1;
 }
 
@@ -1848,6 +1849,9 @@ static void nfsd4_send_cb_offload(struct nfsd4_copy *copy)
 
 	nfsd4_init_cb(&cbo->co_cb, copy->cp_clp, &nfsd4_cb_offload_ops,
 		      NFSPROC4_CLNT_CB_OFFLOAD);
+	nfsd41_cb_referring_call(&cbo->co_cb, &cbo->co_referring_sessionid,
+				 cbo->co_referring_slotid,
+				 cbo->co_referring_seqno);
 	trace_nfsd_cb_offload(copy->cp_clp, &cbo->co_res.cb_stateid,
 			      &cbo->co_fh, copy->cp_count, copy->nfserr);
 	nfsd4_run_cb(&cbo->co_cb);
@@ -1964,6 +1968,11 @@ nfsd4_copy(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 		memcpy(&result->cb_stateid, &copy->cp_stateid.cs_stid,
 			sizeof(result->cb_stateid));
 		dup_copy_fields(copy, async_copy);
+		memcpy(async_copy->cp_cb_offload.co_referring_sessionid.data,
+		       cstate->session->se_sessionid.data,
+		       NFS4_MAX_SESSIONID_LEN);
+		async_copy->cp_cb_offload.co_referring_slotid = cstate->slot->sl_index;
+		async_copy->cp_cb_offload.co_referring_seqno = cstate->slot->sl_seqid;
 		async_copy->copy_task = kthread_create(nfsd4_do_async_copy,
 				async_copy, "%s", "copy thread");
 		if (IS_ERR(async_copy->copy_task))
diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
index c26ba86dbdfd..aa2a356da784 100644
--- a/fs/nfsd/xdr4.h
+++ b/fs/nfsd/xdr4.h
@@ -676,6 +676,10 @@ struct nfsd4_cb_offload {
 	__be32			co_nfserr;
 	unsigned int		co_retries;
 	struct knfsd_fh		co_fh;
+
+	struct nfs4_sessionid	co_referring_sessionid;
+	u32			co_referring_slotid;
+	u32			co_referring_seqno;
 };
 
 struct nfsd4_copy {
-- 
2.47.0


