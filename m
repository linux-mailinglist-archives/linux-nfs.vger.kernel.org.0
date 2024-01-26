Return-Path: <linux-nfs+bounces-1494-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B57683E0CF
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Jan 2024 18:47:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D544F1F23940
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Jan 2024 17:47:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08C29208AF;
	Fri, 26 Jan 2024 17:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EJwpLSad"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D82CF208A7
	for <linux-nfs@vger.kernel.org>; Fri, 26 Jan 2024 17:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706291143; cv=none; b=sGJ7WSgnLw3tw+6fSw27ZIGksOOjHymSQuBGd7dtX2tlPtWbcn7mjbHB5MPWdog5we1p7RsJClqJSRFqQ8/CK95z37Mssgx0SCEiZCnvyYUyaoaGfWlrgmUQOc2sI9dNMV0QnlGGGFFkJgRK05WwFUtWem2XwDIpHUtdQtDRom0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706291143; c=relaxed/simple;
	bh=cr/g7ElMEoUZAmCdl0hrZBH1qX2uPnDEWweEB9gQNfk=;
	h=Subject:From:To:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Bv6+u38S8vjT3Ue7klKS+fxkq4GIGepGzNG7uVUGLkj31bzXXnn9+BL0uc5bKCLz6RG3eHyINmnpPO1Ls6Ag/5bCXOvy7mzZi4nqJocq55Og7hxPHY7jU3m98jUY+sUvlURrad6H9PeYA0rwu5WX4ClifI52T0MRhlbRXP6hKXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EJwpLSad; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AAABC433F1
	for <linux-nfs@vger.kernel.org>; Fri, 26 Jan 2024 17:45:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706291143;
	bh=cr/g7ElMEoUZAmCdl0hrZBH1qX2uPnDEWweEB9gQNfk=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=EJwpLSadWI1G1mDww/iRlujv4plpo3ai/m2hG6K7kiHj4fU/61UVikSiYDYeKDOwm
	 dehm0muH/OqBLej0NL0ypbjU7TCJdln3mUXdcbxzzeZc8QDsFzajyABOwxTBMt00JQ
	 vVYEfQADhx+vnEhgabYsMiOetVjjLiICV1dkd4CT30YCUyKOX8/7ZaqgSVbwWqOfRK
	 wGc64Gk41B2LIhpYVn779Ih0yB2bMEnUpHeos4sZRsudq/wYCGaIMGDAVJRdxS+KVQ
	 zcH6qfTSGKMueC0GmITzG5VSG4Hb0Egnni3+nePRuKJPmPKFzUXMRDMxRMDWs24mcL
	 IotX1rl2ghH9g==
Subject: [PATCH 2 05/14] NFSD: Add nfsd_seq4_status trace event
From: Chuck Lever <cel@kernel.org>
To: linux-nfs@vger.kernel.org
Date: Fri, 26 Jan 2024 12:45:42 -0500
Message-ID: 
 <170629114243.20612.6785316387431284189.stgit@manet.1015granger.net>
In-Reply-To: 
 <170629091560.20612.563908774748586696.stgit@manet.1015granger.net>
References: 
 <170629091560.20612.563908774748586696.stgit@manet.1015granger.net>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Chuck Lever <chuck.lever@oracle.com>

Add a trace point that records SEQ4_STATUS flags returned in an
NFSv4.1 SEQUENCE response. SEQ4_STATUS flags report backchannel
issues and changes to lease state to clients. Knowing what the
server is reporting to clients is useful for debugging both
configuration and operational issues in real time.

For example, upcoming patches will enable server administrators to
revoke parts of a client's lease; that revocation is indicated to
the client when a subsequent SEQUENCE operation has one or more
SEQ4_STATUS flags that are set.

Sample trace records:

nfsd-927   [006]   615.581821: nfsd_seq4_status:     xid=0x095ded07 sessionid=65a032c3:b7845faf:00000001:00000000 status_flags=BACKCHANNEL_FAULT
nfsd-927   [006]   615.588043: nfsd_seq4_status:     xid=0x0a5ded07 sessionid=65a032c3:b7845faf:00000001:00000000 status_flags=BACKCHANNEL_FAULT
nfsd-928   [003]   615.588448: nfsd_seq4_status:     xid=0x0b5ded07 sessionid=65a032c3:b7845faf:00000001:00000000 status_flags=BACKCHANNEL_FAULT

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4state.c |    1 +
 fs/nfsd/trace.h     |   35 +++++++++++++++++++++++++++++++++++
 2 files changed, 36 insertions(+)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index d7d561b29fb0..3d6e3dcfdee1 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -4058,6 +4058,7 @@ nfsd4_sequence(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	}
 	if (!list_empty(&clp->cl_revoked))
 		seq->status_flags |= SEQ4_STATUS_RECALLABLE_STATE_REVOKED;
+	trace_nfsd_seq4_status(rqstp, seq);
 out_no_session:
 	if (conn)
 		free_conn(conn);
diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
index d1e8cf079b0f..38d11b43779c 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -696,6 +696,41 @@ DEFINE_EVENT(nfsd_stid_class, nfsd_stid_##name,			\
 
 DEFINE_STID_EVENT(revoke);
 
+TRACE_EVENT_CONDITION(nfsd_seq4_status,
+	TP_PROTO(
+		const struct svc_rqst *rqstp,
+		const struct nfsd4_sequence *sequence
+	),
+	TP_ARGS(rqstp, sequence),
+	TP_CONDITION(sequence->status_flags),
+	TP_STRUCT__entry(
+		__field(unsigned int, netns_ino)
+		__field(u32, xid)
+		__field(u32, cl_boot)
+		__field(u32, cl_id)
+		__field(u32, seqno)
+		__field(u32, reserved)
+		__field(unsigned long, status_flags)
+	),
+	TP_fast_assign(
+		const struct nfsd4_sessionid *sid =
+			(struct nfsd4_sessionid *)&sequence->sessionid;
+
+		__entry->netns_ino = SVC_NET(rqstp)->ns.inum;
+		__entry->xid = be32_to_cpu(rqstp->rq_xid);
+		__entry->cl_boot = sid->clientid.cl_boot;
+		__entry->cl_id = sid->clientid.cl_id;
+		__entry->seqno = sid->sequence;
+		__entry->reserved = sid->reserved;
+		__entry->status_flags = sequence->status_flags;
+	),
+	TP_printk("xid=0x%08x sessionid=%08x:%08x:%08x:%08x status_flags=%s",
+		__entry->xid, __entry->cl_boot, __entry->cl_id,
+		__entry->seqno, __entry->reserved,
+		show_nfs4_seq4_status(__entry->status_flags)
+	)
+);
+
 DECLARE_EVENT_CLASS(nfsd_clientid_class,
 	TP_PROTO(const clientid_t *clid),
 	TP_ARGS(clid),



