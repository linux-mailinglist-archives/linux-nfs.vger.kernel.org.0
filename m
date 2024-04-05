Return-Path: <linux-nfs+bounces-2681-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90F2089A44F
	for <lists+linux-nfs@lfdr.de>; Fri,  5 Apr 2024 20:41:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BD03284B10
	for <lists+linux-nfs@lfdr.de>; Fri,  5 Apr 2024 18:41:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5650E172BB4;
	Fri,  5 Apr 2024 18:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r43JJnJS"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C096172BAD;
	Fri,  5 Apr 2024 18:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712342463; cv=none; b=HS2FqnqynYJFvaKKbpHWxmDLVHRRyvhpY1HC4m+UOqBa9di/q7KhQvGr2MzDPwP0HlgYM0R5UGFEAL893fbJkx8b6ZEBani2m1jF5UkGDS8Ox420ivHrz2rKqG2DRJ/g3f+vK8dZpLu7viYMjGcuI5zuZBAq9yESqONFKWfQbs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712342463; c=relaxed/simple;
	bh=rQwjRf05WXQlBMs/WtRYxy6v/FNdP0cw9aIf47YxhnM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QiNEBgkDXEQFoVbmv8AqRZnj8q8Z/IWox9dBKy6qLTpSL0YtCP/vLuDVjFyk2INDGt/R5spev0lkhJVihKG10I/fMntgLBYuQv1lV4Caa4cc0AJvqKZ0s3RPqjOint6UBfdWZXgAuojoZujmY1PMsCjaSUTYudbilJpIqL5HwVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r43JJnJS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E581C433A6;
	Fri,  5 Apr 2024 18:41:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712342462;
	bh=rQwjRf05WXQlBMs/WtRYxy6v/FNdP0cw9aIf47YxhnM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=r43JJnJSyrN6RFOhELqb8qsMzuFs1dKAD7gtvKQqH1Qx2d9U4fsUr6JvH2L1Xheyk
	 ImddD7IkmtB5uogUE++viuwAL5d++/2BHy0Z5K3YbP0ZBU5jbJP/m7gAVxHIJuNDrr
	 RcQshFdhmzEtJXKXMz6Jn6N1x7nRgxNx79JNfbfjMvVNTt8r53vwR1ZRFw5t/zoYnU
	 gXjTLMe+2mg60jsbwQLTKVyEaN3fVZbctoiqVifXMhuCbzYpZyQHCmR3qFEpWhdR4X
	 0QQXwz+9bkARbxvLDk7Jj66Y43gjzL0qRh+2Tk8J+L9SuXLe9IEQSLCrHcVOGXigBX
	 GIbrjw5kj2qCg==
From: Jeff Layton <jlayton@kernel.org>
Date: Fri, 05 Apr 2024 14:40:50 -0400
Subject: [PATCH 2/3] nfsd: new tracepoint for check_slot_seqid
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240405-nfsd-fixes-v1-2-e017bfe9a783@kernel.org>
References: <20240405-nfsd-fixes-v1-0-e017bfe9a783@kernel.org>
In-Reply-To: <20240405-nfsd-fixes-v1-0-e017bfe9a783@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>, 
 Olga Kornievskaia <kolga@netapp.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3299; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=rQwjRf05WXQlBMs/WtRYxy6v/FNdP0cw9aIf47YxhnM=;
 b=kA0DAAgBAA5oQRlWghUByyZiAGYQRbugltUmiXpvYNW1qux1n7woBXkotb2EfOYgOWqHFDeZL
 YkCMwQAAQgAHRYhBEvA17JEcbKhhOr10wAOaEEZVoIVBQJmEEW7AAoJEAAOaEEZVoIVMSMQAIoE
 vIdc02UpvfeOcWveg/KPeeiFDhm6H0RytxV2WAlx5EfUxqHbz9AKhyMVyo0Qp4iFI45mE5bclTZ
 A/S0CWtceiNwBzqNVoEfy8n9J4UdSosmoAiYEFEYZUyn6NYXxnVemEOF/Zl4NRQI2cW5ceftvsY
 SlvbBb0YzVAlnod8pWgCsbLZS9DIuCxgDcBOa8Rrqcco8tbsEKrqM3xDMOJSIlM5Z+iwiIHLek/
 K4oo2F9IqQ0VsftWNb4spE7tHEar8FktDJq59OjQKrjG/4VBC/DBChYFmSOhVjK1DnzDpQEBntG
 aFZsxSowQn5HqIKxpJNpZT8MQl3zvjvQ3nDxC8ypZz9c8Epop2Ob3WgwRX1aa7BEkt+6NtmUG0N
 8v/i6LcuEtOPVD+XIt1EF8p259oUOo0Qzw8vVeia9Rs0b36fDSR/GQimOqoWR4C6tMMO1wPvQq9
 JoSkMbqRVuNdqx5otSxX/yRCe6w5aDqwQy13riWw1kTUVctA4nVfL1niKyoZzdt3sndwo4OI5OO
 BVrrqnaBCkoUWXpWbNVdtPzM0QdOz26OiFXJF8xfkqkw0fergX4fwL0+qxn9aADiCXFRVt/+FoQ
 gQwx7Z3jVHOKJfAq7+zi70EdnhSZeEq7SC0rl3qC/D5XTOj6Ez2IxIdhLgw+pDIVHxfgYksDSZ0
 AR2vy
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Replace a dprintk in check_slot_seqid with a new tracepoint.  Add a
nfs4_client argument to check_slot_seqid so that we can pass the
appropriate info to the tracepoint.

Signed-off-by: Jeffrey Layton <jlayton@redhat.com>
---
 fs/nfsd/nfs4state.c | 12 ++++++------
 fs/nfsd/trace.h     | 34 ++++++++++++++++++++++++++++++++++
 2 files changed, 40 insertions(+), 6 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 3cef81e196c6..5891bc3e2b0b 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -3642,10 +3642,9 @@ nfsd4_exchange_id(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 }
 
 static __be32
-check_slot_seqid(u32 seqid, u32 slot_seqid, int slot_inuse)
+check_slot_seqid(struct nfs4_client *clp, u32 seqid, u32 slot_seqid, bool slot_inuse)
 {
-	dprintk("%s enter. seqid %d slot_seqid %d\n", __func__, seqid,
-		slot_seqid);
+	trace_check_slot_seqid(clp, seqid, slot_seqid, slot_inuse);
 
 	/* The slot is in use, and no response has been sent. */
 	if (slot_inuse) {
@@ -3827,7 +3826,8 @@ nfsd4_create_session(struct svc_rqst *rqstp,
 		cs_slot = &conf->cl_cs_slot;
 	else
 		cs_slot = &unconf->cl_cs_slot;
-	status = check_slot_seqid(cr_ses->seqid, cs_slot->sl_seqid, 0);
+	status = check_slot_seqid(conf ? conf : unconf, cr_ses->seqid,
+				  cs_slot->sl_seqid, false);
 	switch (status) {
 	case nfs_ok:
 		cs_slot->sl_seqid++;
@@ -4221,8 +4221,8 @@ nfsd4_sequence(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	 * sr_highest_slotid and the sr_target_slot id to maxslots */
 	seq->maxslots = session->se_fchannel.maxreqs;
 
-	status = check_slot_seqid(seq->seqid, slot->sl_seqid,
-					slot->sl_flags & NFSD4_SLOT_INUSE);
+	status = check_slot_seqid(clp, seq->seqid, slot->sl_seqid,
+				  slot->sl_flags & NFSD4_SLOT_INUSE);
 	if (status == nfserr_replay_cache) {
 		status = nfserr_seq_misordered;
 		if (!(slot->sl_flags & NFSD4_SLOT_INITIALIZED))
diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
index 7f1a6d568bdb..ec00ca7ecfc8 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -1542,6 +1542,40 @@ TRACE_EVENT(nfsd_cb_seq_status,
 	)
 );
 
+TRACE_EVENT(check_slot_seqid,
+	TP_PROTO(
+		const struct nfs4_client *clp,
+		u32 seqid,
+		u32 slot_seqid,
+		bool inuse
+	),
+	TP_ARGS(clp, seqid, slot_seqid, inuse),
+	TP_STRUCT__entry(
+		__field(u32, seqid)
+		__field(u32, slot_seqid)
+		__field(u32, cl_boot)
+		__field(u32, cl_id)
+		__sockaddr(addr, clp->cl_cb_conn.cb_addrlen)
+		__field(bool, conf)
+		__field(bool, inuse)
+	),
+	TP_fast_assign(
+		__entry->cl_boot = clp->cl_clientid.cl_boot;
+		__entry->cl_id = clp->cl_clientid.cl_id;
+		__assign_sockaddr(addr, &clp->cl_cb_conn.cb_addr,
+				  clp->cl_cb_conn.cb_addrlen);
+		__entry->seqid = seqid;
+		__entry->slot_seqid = slot_seqid;
+		__entry->conf = test_bit(NFSD4_CLIENT_CONFIRMED, &clp->cl_flags);
+		__entry->inuse = inuse;
+	),
+	TP_printk("addr=%pISpc %s client %08x:%08x seqid=%u slot_seqid=%u inuse=%d",
+		__get_sockaddr(addr), __entry->conf ? "conf" : "unconf",
+		__entry->cl_boot, __entry->cl_id,
+		__entry->seqid, __entry->slot_seqid, __entry->inuse
+	)
+);
+
 TRACE_EVENT(nfsd_cb_free_slot,
 	TP_PROTO(
 		const struct rpc_task *task,

-- 
2.44.0


