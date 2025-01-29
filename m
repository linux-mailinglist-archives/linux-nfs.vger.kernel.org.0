Return-Path: <linux-nfs+bounces-9745-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46516A21E06
	for <lists+linux-nfs@lfdr.de>; Wed, 29 Jan 2025 14:41:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C844B167AA3
	for <lists+linux-nfs@lfdr.de>; Wed, 29 Jan 2025 13:41:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49C741DE3BE;
	Wed, 29 Jan 2025 13:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TU+RGDwF"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21CB31DE2DA;
	Wed, 29 Jan 2025 13:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738158021; cv=none; b=rENegM9FV/V2Z44ZsMpZZnMWxzSlAYtYgZGpLxPie2MO4Nqh+AUHRxFJyzavnTO8hVabHZ1tdo+KsZ0neNWInr7WrZd4AW4Hyw8xurIs/hLZfCjCm5tFgUeUNfFEGo/UpmaPbMWU0HwMy9FsyZdTSSrD5qJthLf9YuQKSFPtQRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738158021; c=relaxed/simple;
	bh=XRM38jRIULWRrASi88vSoSIfhko5eGFiVikgJOw1cSE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qdyB61LUmhZK7p109mNXBZgs+iQeY64VFZ9b7qZ/75ceoA1bXLcMviBZspMi/QG0EfJGig6Q07ENrynJrlHV6j/n7j/uV6YLU+Yz0Wkv85Ha+m3f5IoYyMV2cE0aBta5hyxdP/33oEqLlWwBjYwzzKiNS9wR9PNx3M/W6HraBIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TU+RGDwF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B173C4CEDF;
	Wed, 29 Jan 2025 13:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738158020;
	bh=XRM38jRIULWRrASi88vSoSIfhko5eGFiVikgJOw1cSE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=TU+RGDwFdUGOXhGbNYyzyWRlu4hY+f40pbYyZ4Dc6ipEw8bMEhJhDmcbkngs6rQaP
	 GIvDcaBMqMEb8wsxcjj/5Rllgl0gwg7UgD/fYOUzVgKKRfWWkGvCjm633IUZbK2DLt
	 6IgoqC29RFpOxa9wBCq3ZFDAQ2T/KrXYnM7mauhpqSs2T1kRAQgJZWV2qYC4WUCyIJ
	 7ey5Xxg0NsOBsZq7elgZBGiBwmNRFC7e+YQxsIAn9asy7fCe4vWNOXtZWf89Hs5moZ
	 VkX4VugN/4DMTyaKNWsWg5dj7ZX2AncTwJTIKxZQ5bjn0BeJ2ymZnpkrpGjRmtOdwy
	 Iq9L9mbNQEepg==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 29 Jan 2025 08:40:00 -0500
Subject: [PATCH v2 7/7] sunrpc: make rpc_restart_call() and
 rpc_restart_call_prepare() void return
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250129-nfsd-6-14-v2-7-2700c92f3e44@kernel.org>
References: <20250129-nfsd-6-14-v2-0-2700c92f3e44@kernel.org>
In-Reply-To: <20250129-nfsd-6-14-v2-0-2700c92f3e44@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, "J. Bruce Fields" <bfields@fieldses.org>, 
 Kinglong Mee <kinglongmee@gmail.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3539; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=XRM38jRIULWRrASi88vSoSIfhko5eGFiVikgJOw1cSE=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBnmi+6MedxE93caz5mYVpn2gv168dCijgVSwuwv
 tmExDu9RIWJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZ5ovugAKCRAADmhBGVaC
 Ff+PD/413D7uS7fy71dd1XzTlUOQO8X/fCCOX3fW0qnNE4JeKf3qhEnu7lGY6b6yrl2uoPLYb3S
 gRft5nxplKgPOYxBp9ePAc+E5gf3RREP/wH3q5Fr7ixJcj91PJ0WgDAKbbKCxa/iToAQV51Vbvl
 K8torRLyVBXBYhMqbmc1IqivGFUzrn61KjNUBVylG88oa7xwMy2bAum9JtqGyp7yLQFlcOCz97m
 APFu3hx85CnVjJ9j275tCfq2NA+mEZiAqJrB9AgcYdNUeJx4kEH4XEXGIT0ck9ujtWDSxRikUF/
 dX/vzoNOd4BieJszhArBdXgc1UbmCrqhDPlyR3dp1Wv7KRgyyhFuU+4WcNeiCLxogplUyzqMglQ
 s+1v5IKwExK6KUZ2cwkS9eXIZyTKEyTO4cDsut2ZBQ+G9RPf/Jtly72wdC10VN6PEnP175Q2cP5
 g1XS7t9RXhx+M5zTOTvqObEDFmB5Y7jHDcDbs+YuN1gLT0vjUQA8IxWqyWd3LdVplwaBcy7UWWg
 gRPwUU5Jxwk60BE8WVXDsrYib6YWaMv5yW+Vtr+2kUcOTNhLNnRMZBACnJN/oZs6PweSsL+VXZj
 DTtfFJ28yn/wCDmXkj5WL68cvqACTxNbl/XF5d7UMDrmNa7LKeNhIfBGBu/YQWyfjVMO5YenXgn
 cc14cCXLFLCaMFQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

These functions always return 1. Make them void return and fix up the
places that check the return code.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfs/nfs4proc.c           | 12 +++++-------
 fs/nfsd/nfs4callback.c      |  4 ++--
 include/linux/sunrpc/clnt.h |  4 ++--
 net/sunrpc/clnt.c           |  7 +++----
 4 files changed, 12 insertions(+), 15 deletions(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 405f17e6e0b45b26cebae06c5bbe932895af9a56..cda20bfeca56db1ef8c51e524d08908b93bfeba6 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -968,15 +968,13 @@ static int nfs41_sequence_process(struct rpc_task *task,
 retry_new_seq:
 	++slot->seq_nr;
 retry_nowait:
-	if (rpc_restart_call_prepare(task)) {
-		nfs41_sequence_free_slot(res);
-		task->tk_status = 0;
-		ret = 0;
-	}
+	rpc_restart_call_prepare(task);
+	nfs41_sequence_free_slot(res);
+	task->tk_status = 0;
+	ret = 0;
 	goto out;
 out_retry:
-	if (!rpc_restart_call(task))
-		goto out;
+	rpc_restart_call(task);
 	rpc_delay(task, NFS4_POLL_RETRY_MAX);
 	return 0;
 }
diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
index 2cfff984b42f0ef7fe885d57d57b3d318ed966e0..d101f18012bfe89169d8218b46183cab6c06d1bf 100644
--- a/fs/nfsd/nfs4callback.c
+++ b/fs/nfsd/nfs4callback.c
@@ -1450,8 +1450,8 @@ static bool nfsd4_cb_sequence_done(struct rpc_task *task, struct nfsd4_callback
 		if (RPC_SIGNALLED(task))
 			goto need_restart;
 		cb->cb_seq_status = 1;
-		if (rpc_restart_call(task))
-			rpc_delay(task, 2 * HZ);
+		rpc_restart_call(task);
+		rpc_delay(task, 2 * HZ);
 		return false;
 	case -NFS4ERR_SEQ_MISORDERED:
 		/*
diff --git a/include/linux/sunrpc/clnt.h b/include/linux/sunrpc/clnt.h
index 5321585c778fcc1fef0e0420cb481786c02a7aac..e56f15c97fa24c735090c21c51ef312bfd877cfd 100644
--- a/include/linux/sunrpc/clnt.h
+++ b/include/linux/sunrpc/clnt.h
@@ -213,8 +213,8 @@ int		rpc_call_sync(struct rpc_clnt *clnt,
 			      const struct rpc_message *msg, int flags);
 struct rpc_task *rpc_call_null(struct rpc_clnt *clnt, struct rpc_cred *cred,
 			       int flags);
-int		rpc_restart_call_prepare(struct rpc_task *);
-int		rpc_restart_call(struct rpc_task *);
+void		rpc_restart_call_prepare(struct rpc_task *task);
+void		rpc_restart_call(struct rpc_task *task);
 void		rpc_setbufsize(struct rpc_clnt *, unsigned int, unsigned int);
 struct net *	rpc_net_ns(struct rpc_clnt *);
 size_t		rpc_max_payload(struct rpc_clnt *);
diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
index 0090162ee8c350568c91f1bcd951675ac3ae141c..3d2989120599ccee32e8827b1790d4be7d7a565a 100644
--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -1670,20 +1670,19 @@ void rpc_force_rebind(struct rpc_clnt *clnt)
 }
 EXPORT_SYMBOL_GPL(rpc_force_rebind);
 
-static int
+static void
 __rpc_restart_call(struct rpc_task *task, void (*action)(struct rpc_task *))
 {
 	task->tk_status = 0;
 	task->tk_rpc_status = 0;
 	task->tk_action = action;
-	return 1;
 }
 
 /*
  * Restart an (async) RPC call. Usually called from within the
  * exit handler.
  */
-int
+void
 rpc_restart_call(struct rpc_task *task)
 {
 	return __rpc_restart_call(task, call_start);
@@ -1694,7 +1693,7 @@ EXPORT_SYMBOL_GPL(rpc_restart_call);
  * Restart an (async) RPC call from the call_prepare state.
  * Usually called from within the exit handler.
  */
-int
+void
 rpc_restart_call_prepare(struct rpc_task *task)
 {
 	if (task->tk_ops->rpc_call_prepare != NULL)

-- 
2.48.1


