Return-Path: <linux-nfs+bounces-2682-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CCDB89A451
	for <lists+linux-nfs@lfdr.de>; Fri,  5 Apr 2024 20:41:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 88AB7B21FFC
	for <lists+linux-nfs@lfdr.de>; Fri,  5 Apr 2024 18:41:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C153172BD5;
	Fri,  5 Apr 2024 18:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mT46KpkE"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3427C172BCE;
	Fri,  5 Apr 2024 18:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712342464; cv=none; b=mb95Yoy4Kyun9EmJutbQGpgm185zlYHG2Enqp/I58uZwK0JfuGDoMPW9H1P0PySjfsUBAMqC/EiX82SU4V65wGL6FkOFk/YpavYf1g/md3zfb6wJuKqP5SOranAlRLVxwdB3ewksetL1f8fgwb8FE/WSd00LZIBTDDLMYgoeM5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712342464; c=relaxed/simple;
	bh=1Pi5PIFKWzOHDFMVv16vL3HB67cVIN7Y+lJtjE4ssfE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tO9YT7KnUt4ccnNKdyZbA3DSr9SusHxtOJ+IJEaVdvCsLQ/53iBMEIKgd5UPQg62CD2kJzCVwRuJzTwGleRP45iyFmy3eIzTWAFBV+V8JSigaIIF7DgnhU0qCxJQ0vxo5vmYj9TRZSn8tDiycMwrHzfC9Ih7DlJuqeQoB/kG1Rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mT46KpkE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D956C4166C;
	Fri,  5 Apr 2024 18:41:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712342463;
	bh=1Pi5PIFKWzOHDFMVv16vL3HB67cVIN7Y+lJtjE4ssfE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=mT46KpkEDRoMkbW7ty3vb6LL9KcuNG3LLV2IF2AxpZO4RcVf/Bu+rL/0Z9CP0lrQg
	 buEXmW3jpS358YrzDzvDc+1Axi5QuJiBt0SbjHo2mKmeJpomnZoLJDhUAaayfLfq4L
	 Q8Cofnh0Xxp9XqMt9z4qUfHmH2Mvg8eedD9fdYwLaw5UP7tIfpdqho0qfPX2Gzxdwo
	 /3io6CEvcOaqOQArSbfy430Zq2nUXrba8RAoUh1ab1QVMulaNpSofvtJax+tmW1zOT
	 PFKqieyGZKL/yEo3IjMS4GuGFRjOF6FrYelq6cuTl/7yfq6SrsY5+G8IWiWDo18tG+
	 bGmtr0J/v9/dQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Fri, 05 Apr 2024 14:40:51 -0400
Subject: [PATCH 3/3] nfsd: add tracepoint in mark_client_expired_locked
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240405-nfsd-fixes-v1-3-e017bfe9a783@kernel.org>
References: <20240405-nfsd-fixes-v1-0-e017bfe9a783@kernel.org>
In-Reply-To: <20240405-nfsd-fixes-v1-0-e017bfe9a783@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>, 
 Olga Kornievskaia <kolga@netapp.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1863; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=1Pi5PIFKWzOHDFMVv16vL3HB67cVIN7Y+lJtjE4ssfE=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBmEEW75SjWy1aDQNBXHYSBcZlz91tWhCKwzax8x
 9ciP6k6H1GJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZhBFuwAKCRAADmhBGVaC
 FeEdD/43xhDGNY39uWy/9tVuzu+E2f47ecY7C9qqmJFImxRJXJhBEEiQNNaF8i3+RTUXRhjn6MT
 LSGNfVp0lyk9SRmx7UXRjiwSe3a0k/Una9UAHI2DThnERxSyOGmX+NNCpfDf5e/xZ2bWDyzmKgd
 xIHIEN3vQyYqVcuzpLvdtofkzDo2y+GCV4dHjvC6tvAnsh0TwD36TjNSa4oq/1Rdts4azGXhvoN
 KX/0LbTtjloH9qP4bGNqtA8nn3hxVD7bdg8FXKERNUCEQYgGYVcspI++EipiMrNYMOPnpEUNKzu
 n3+ITqUHClpX39CqxUV4s6/hZe/WJ7w6Tw08LbsAIMyqXUlXN1ZusWzYK/qIjBz6eoEn0G42uOg
 IGK6TpSi/n5lGd9Ir+yFMBonH6F/A9WfXJDmK2zEWvMlTYT1edC8zUXf3obyFGGxTva35faXb3V
 aQ8BJ5ujKYmCibMw8cwnR8j90RgoD8X9P4sMVTx0uV0qrXjNsU7R3c25SE9as3WVVVyXK419bo0
 v3PTLw36klCAVWpFiPAmpZKna81syGMgMV1TGeqnIY3lmWlz47idtz6maR+rR3ojA8eO8KMneBs
 4+Un0ibPa3rlBQgcM+jEzgnIGTakuQI+HVg/eelUCb6OKhUp4kmgskUuZONeUsPOk+nOYcP5Gou
 lOBmFN1CS+ygq1Q==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Show client info alongside the number of cl_rpc_users. If that's
elevated, then we can infer that this function returned nfserr_jukebox.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4state.c |  6 +++++-
 fs/nfsd/trace.h     | 24 ++++++++++++++++++++++++
 2 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 5891bc3e2b0b..2b5dadeed8c9 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -2352,7 +2352,11 @@ unhash_client(struct nfs4_client *clp)
 
 static __be32 mark_client_expired_locked(struct nfs4_client *clp)
 {
-	if (atomic_read(&clp->cl_rpc_users))
+	int users = atomic_read(&clp->cl_rpc_users);
+
+	trace_mark_client_expired_locked(clp, users);
+
+	if (users)
 		return nfserr_jukebox;
 	unhash_client_locked(clp);
 	return nfs_ok;
diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
index ec00ca7ecfc8..b50d6a71c7d9 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -1576,6 +1576,30 @@ TRACE_EVENT(check_slot_seqid,
 	)
 );
 
+TRACE_EVENT(mark_client_expired_locked,
+	TP_PROTO(
+		const struct nfs4_client *clp,
+		int cl_rpc_users
+	),
+	TP_ARGS(clp, cl_rpc_users),
+	TP_STRUCT__entry(
+		__field(int, cl_rpc_users)
+		__field(u32, cl_boot)
+		__field(u32, cl_id)
+		__sockaddr(addr, clp->cl_cb_conn.cb_addrlen)
+	),
+	TP_fast_assign(
+		__entry->cl_rpc_users = cl_rpc_users;
+		__entry->cl_boot = clp->cl_clientid.cl_boot;
+		__entry->cl_id = clp->cl_clientid.cl_id;
+		__assign_sockaddr(addr, &clp->cl_cb_conn.cb_addr,
+				  clp->cl_cb_conn.cb_addrlen)
+	),
+	TP_printk("addr=%pISpc client %08x:%08x cl_rpc_users=%d",
+		__get_sockaddr(addr), __entry->cl_boot, __entry->cl_id,
+		__entry->cl_rpc_users)
+);
+
 TRACE_EVENT(nfsd_cb_free_slot,
 	TP_PROTO(
 		const struct rpc_task *task,

-- 
2.44.0


