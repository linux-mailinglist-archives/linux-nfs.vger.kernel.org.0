Return-Path: <linux-nfs+bounces-1390-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A364383C7F5
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Jan 2024 17:29:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 439771F279E7
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Jan 2024 16:29:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DE157762A;
	Thu, 25 Jan 2024 16:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Araa1xZu"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AA2A73177
	for <linux-nfs@vger.kernel.org>; Thu, 25 Jan 2024 16:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706200147; cv=none; b=OHG7mQn9gpozGNFqbVWpU7Xr4iYRfExwJ78oUWN+6Gj2iiUZLHvdFac6h9AmSm4h7ahZZzFOLC5LRROQNXumZiLPsUmobvJL+flYbGEM12op7NMOMp8ctkE17Xi6DYGDdYlAoyaNtP60BHpZ8YG9+2LoKx+utn2v4OIPGS2ggNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706200147; c=relaxed/simple;
	bh=8GoL0ubXrSyZcwFONaLSEzFwk/AxuWvp02+Msco9Cnk=;
	h=Subject:From:To:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kLPgkamIGQu1U25zgan+A0r4Hqnhdi0M+NW87lHCOMlRSMDjM3+jtFAPQ25tiKd/j6hUmxQaksZaoiLs0WRoCRPdl1DXdF+Lbvug1/eXa3LuXvgEgNGn0fRCF3oTBMERmHkTRJcVVeuHBMrZ2yLGZk77ZF9LO7SMRQUjuzCa5fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Araa1xZu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BE6DC433C7
	for <linux-nfs@vger.kernel.org>; Thu, 25 Jan 2024 16:29:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706200146;
	bh=8GoL0ubXrSyZcwFONaLSEzFwk/AxuWvp02+Msco9Cnk=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=Araa1xZuDhuUuknAXXIb7p0fy55ZQqFBmqxGn4k7Djh6MVcaAVA4ypeT2bgXW9G6c
	 bXZT6q6KRtA+2xAIN5xzeXzCEOgSZlislxHu/dcBvH5QzSs9Do6GVZCq9IC5SpGznH
	 1VysYlZPTCFtPCcRa6D4lnL6OzxRmOTw6Dz5L4dfevdpf/zzFx8z9qU7cG2nn8W4Yy
	 isUfbDYAiOcqarbLBC0Wp+ucCo/gDAynjngFE35wk8o5JOB07KnCC0ZW4ZBiQU7bbd
	 TPQWaaz5y670/pq1UHtUUyDllB2B3ced2qcZouHRI1wKl0BJnd7D8EReiBNs+ITw/r
	 fDUKuJODdKFaw==
Subject: [PATCH RFC 04/13] NFSD: Add nfsd_seq4_status trace event
From: Chuck Lever <cel@kernel.org>
To: linux-nfs@vger.kernel.org
Date: Thu, 25 Jan 2024 11:29:05 -0500
Message-ID: 
 <170620014547.2833.2715928724069344285.stgit@manet.1015granger.net>
In-Reply-To: 
 <170619984210.2833.7173004255003914651.stgit@manet.1015granger.net>
References: 
 <170619984210.2833.7173004255003914651.stgit@manet.1015granger.net>
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



