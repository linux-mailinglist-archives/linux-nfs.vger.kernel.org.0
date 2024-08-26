Return-Path: <linux-nfs+bounces-5755-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 204F495F21C
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Aug 2024 14:54:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 949161F22DB1
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Aug 2024 12:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B185918E02B;
	Mon, 26 Aug 2024 12:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a885E9PO"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89E2918D634;
	Mon, 26 Aug 2024 12:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724676617; cv=none; b=GTX7v64nUoFO+vIEurNN1trD7GfF0xcASqaQug+ixuJ+MWrsyuEk88dAGyf1nUYa/buqRKdqQNn/shSbW4RC32hKAXFnb8NimLPzTq/e1sOBijdPK6H3bkZgbDAuAiuq7cyuO4uSXcSQ0pKIb4+eBVsdW9LjfnPlFqQ9cwTMuYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724676617; c=relaxed/simple;
	bh=jaLAOBhtQ23Mxe3I8x/MN/JlMJPGuatZ77ZZrAQldNg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NTBy0KSo9uKztRjc8ZkYjbdimunS9e/mVJiBr4c2g7eNiQEx3bsC8uLYIyeIye0Yq4OTl8RmZBeiiTUia1Z4RDt97dVycpY85X9OofNwPUUc8HoPr8uxZfD3YtclSYapfKEOCPyk7JcDVtAMoQCucQRRcXJrq5XROY+ke2dGcs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a885E9PO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BD4FC4FEF0;
	Mon, 26 Aug 2024 12:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724676617;
	bh=jaLAOBhtQ23Mxe3I8x/MN/JlMJPGuatZ77ZZrAQldNg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=a885E9PO5/hRZXeEGgslQY+EDoX/O7FfWd3FojTlTnNRKOh8NDCIi29xdiaS26xMl
	 mwuT3T0KvkTctv4Ie97HhG0o0Q8addN+9nUHnKCdlFyrTr5nRDErmt7DKOn/CKuR3j
	 M00MGiYW6brXZanYH/m4ayXgq/6h9O6SFBIHW4F9Zozj2dc7/cAS1Ony4UU+hLc9B7
	 cI1lGRRRiaFJAgC+UJxDraWZOTh9NhLMfYaUcS6BxyLZ/SILQ8xvKwwf6qIbXKcfDG
	 RE3+3vpK+nRJuwiRcprwmHfSAojJKbtIHvQEP/rgXrSZWBmySOTULyM4R4CrtCQr0U
	 HBTdO2CqGqaDQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 26 Aug 2024 08:50:13 -0400
Subject: [PATCH 3/3] nfsd: add more nfsd_cb tracepoints
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240826-nfsd-cb-v1-3-82d3a4e5913b@kernel.org>
References: <20240826-nfsd-cb-v1-0-82d3a4e5913b@kernel.org>
In-Reply-To: <20240826-nfsd-cb-v1-0-82d3a4e5913b@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>, 
 Olga Kornievskaia <kolga@netapp.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2718; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=jaLAOBhtQ23Mxe3I8x/MN/JlMJPGuatZ77ZZrAQldNg=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBmzHoF16TD2KYxszyHQmgDLZBUYzkUDutv3Ob5K
 tZyEL16IEqJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZsx6BQAKCRAADmhBGVaC
 FRaSEADW56ICHIlY78FVgCn9+Gd7SNdTLWiTBoVwBKC6wjO5h/47vSH+/9GbzLCIC15zm4yaWNa
 2ir9V0jfa6yOoeThPRthiOcsVoZfSlFdFr6P4+9d9IuocU4q6b0X6BI7FOZDatB9gFFdtAk1dCO
 8ZvMSLt9eXMO0VJP9xW0AeAdxSXfwUzBvmKKCHqdhDV9Ad0cOgSViU4D+CrV/JdxK2mRgzX95EL
 HePzP5opDfTHU3MwPXn9V3sWOGZoxfjdPiBKQ7Ol9fODcV+kRQYEM2tzbGk5/jUm5Ifs4gb2eMU
 6Ibl4426ReGmDO0B/EM04/AApKpdDb8wd8NpZ9PPTpXxiVOgp0rkrAUQJyL00FscHRL/mEWs+fV
 pUBr+KtCabujItFSTMBuNHfNhvSD/SykYULr1w5vWl6RQHLdb3jp/2gIPRJw9lfS7lJDcJdb99f
 yjyZxWirjQnQUgZ3HCfuBjJ+pjO9k+1J++yE+L4Umze08V29Mp7PZyc8nMQS+WNc3sRryhAGryz
 DsNG1OrMAMzr4QlRlBhR1hm5pCkW7ryeYgW/n9Vc0yvflnYxZUDDZTJft+KoidqMBT3IEpnt+OK
 HYdCUvnQpF4zBwLsa+kuf8ZzapyF7n4ppSDKao3UC0kmr/v8EKdx04zoGE+uZ7PFALzgqlTPFO+
 uNpxPwHCQzlYOsQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Add some tracepoints in the callback client RPC operations. Also
add a tracepoint to nfsd4_cb_getattr_done.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4callback.c | 5 +++++
 fs/nfsd/nfs4state.c    | 3 +++
 fs/nfsd/trace.h        | 4 ++++
 3 files changed, 12 insertions(+)

diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
index dee9477cc5b5..b5b3ab9d719a 100644
--- a/fs/nfsd/nfs4callback.c
+++ b/fs/nfsd/nfs4callback.c
@@ -1223,6 +1223,7 @@ static void nfsd4_cb_prepare(struct rpc_task *task, void *calldata)
 	 * cb_seq_status is only set in decode_cb_sequence4res,
 	 * and so will remain 1 if an rpc level failure occurs.
 	 */
+	trace_nfsd_cb_rpc_prepare(clp);
 	cb->cb_seq_status = 1;
 	cb->cb_status = 0;
 	if (minorversion && !nfsd41_cb_get_slot(cb, task))
@@ -1329,6 +1330,8 @@ static void nfsd4_cb_done(struct rpc_task *task, void *calldata)
 	struct nfsd4_callback *cb = calldata;
 	struct nfs4_client *clp = cb->cb_clp;
 
+	trace_nfsd_cb_rpc_done(clp);
+
 	if (!nfsd4_cb_sequence_done(task, cb))
 		return;
 
@@ -1360,6 +1363,8 @@ static void nfsd4_cb_release(void *calldata)
 {
 	struct nfsd4_callback *cb = calldata;
 
+	trace_nfsd_cb_rpc_release(cb->cb_clp);
+
 	if (cb->cb_need_restart)
 		nfsd4_queue_cb(cb);
 	else
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 2843f623163d..918d15fb76b2 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -3057,7 +3057,10 @@ nfsd4_cb_getattr_done(struct nfsd4_callback *cb, struct rpc_task *task)
 {
 	struct nfs4_cb_fattr *ncf =
 			container_of(cb, struct nfs4_cb_fattr, ncf_getattr);
+	struct nfs4_delegation *dp =
+			container_of(ncf, struct nfs4_delegation, dl_cb_fattr);
 
+	trace_nfsd_cb_getattr_done(&dp->dl_stid.sc_stateid, task);
 	ncf->ncf_cb_status = task->tk_status;
 	switch (task->tk_status) {
 	case -NFS4ERR_DELAY:
diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
index 476f278e7115..592bf759b85b 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -1486,6 +1486,9 @@ DEFINE_NFSD_CB_EVENT(new_state);
 DEFINE_NFSD_CB_EVENT(probe);
 DEFINE_NFSD_CB_EVENT(lost);
 DEFINE_NFSD_CB_EVENT(shutdown);
+DEFINE_NFSD_CB_EVENT(rpc_prepare);
+DEFINE_NFSD_CB_EVENT(rpc_done);
+DEFINE_NFSD_CB_EVENT(rpc_release);
 
 TRACE_DEFINE_ENUM(RPC_AUTH_NULL);
 TRACE_DEFINE_ENUM(RPC_AUTH_UNIX);
@@ -1845,6 +1848,7 @@ DEFINE_NFSD_CB_DONE_EVENT(nfsd_cb_recall_done);
 DEFINE_NFSD_CB_DONE_EVENT(nfsd_cb_notify_lock_done);
 DEFINE_NFSD_CB_DONE_EVENT(nfsd_cb_layout_done);
 DEFINE_NFSD_CB_DONE_EVENT(nfsd_cb_offload_done);
+DEFINE_NFSD_CB_DONE_EVENT(nfsd_cb_getattr_done);
 
 TRACE_EVENT(nfsd_cb_recall_any_done,
 	TP_PROTO(

-- 
2.46.0


