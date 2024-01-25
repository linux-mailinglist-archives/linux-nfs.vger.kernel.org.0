Return-Path: <linux-nfs+bounces-1393-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D43BA83C7FE
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Jan 2024 17:29:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 130F91C21B92
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Jan 2024 16:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED5C512A151;
	Thu, 25 Jan 2024 16:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iprIkzQm"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA41012A14C
	for <linux-nfs@vger.kernel.org>; Thu, 25 Jan 2024 16:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706200159; cv=none; b=unMzz0lsXErSIn2qLkWXISSqf9bXxdZKk1sCL303jUIV1YHKsQ74BJSPwu/NFiL7FlFDcI0B2KKzuIBsy6lglv2UElyjN3DT+ULlhWwLIJiopIrCQZj4ZXPWxHZi5IAQL+h2zEwyBgVzABw5KwlxVr60pvt1tjyYmEX5S94n/m4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706200159; c=relaxed/simple;
	bh=oyWw8rysShVN6IpXiV9QH8TKsHat67OtD+iwKutFCOY=;
	h=Subject:From:To:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pAAVnzXq4IeFxu0isBCemfkbuLEU1kVelrkBY6FhEHHzLnCenuyHIJRTUSvtC5ulWwI4K6ebzGP0bUL3SNliP/a0zZs59skqhLMS9F2bKGMk+0nzQye1T2EaxIPc72CMqtBeOMSRwLebvjq3r63p1zCPWGg0VcYEkfw4gFH/VzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iprIkzQm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 364CBC43399
	for <linux-nfs@vger.kernel.org>; Thu, 25 Jan 2024 16:29:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706200159;
	bh=oyWw8rysShVN6IpXiV9QH8TKsHat67OtD+iwKutFCOY=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=iprIkzQmdrGzPKFMH+J1mfZmhFOMR0+JRrQg+OaFU6szpPUmy/zsjohnpP1ZlW/q6
	 SwXfmjGbEbh3e/tRmW9EL3vO7oJIsrZBq+aCPgDcq+z/RBTf5+I7BZTZM0LSL7/8IF
	 W/PJMFIDAdcv9ytaAWHQMoIgVeMhRxKP9eeMMeX3N+3XfrfpIJmLDm1qGU0Vb3SGHX
	 bso0F2Omyodk3cBLJR0AUZNSHDwKiDCWb8xahCl1hgmsTvEIcCuTXdE8X6300RZN1a
	 cT6qVy/waeaOnJcVWdxnt9tdQPIfOgzyNXuKO76DRJDjK1bG0avBh8WLNTS58I2eob
	 t5kDtm86vuDvw==
Subject: [PATCH RFC 06/13] NFSD: Rename nfsd_cb_state trace point
From: Chuck Lever <cel@kernel.org>
To: linux-nfs@vger.kernel.org
Date: Thu, 25 Jan 2024 11:29:18 -0500
Message-ID: 
 <170620015818.2833.16183397044635913129.stgit@manet.1015granger.net>
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

Make it clear where backchannel state is updated.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4callback.c |    4 +++-
 fs/nfsd/trace.h        |    3 ++-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
index 9f5aebeef83c..1c85426830b1 100644
--- a/fs/nfsd/nfs4callback.c
+++ b/fs/nfsd/nfs4callback.c
@@ -999,7 +999,7 @@ static void nfsd4_mark_cb_state(struct nfs4_client *clp, int newstate)
 {
 	if (clp->cl_cb_state != newstate) {
 		clp->cl_cb_state = newstate;
-		trace_nfsd_cb_state(clp);
+		trace_nfsd_cb_new_state(clp);
 	}
 }
 
@@ -1383,6 +1383,8 @@ nfsd4_run_cb_work(struct work_struct *work)
 	struct rpc_clnt *clnt;
 	int flags;
 
+	trace_nfsd_cb_start(clp);
+
 	if (clp->cl_flags & NFSD4_CLIENT_CB_FLAG_MASK)
 		nfsd4_process_cb_update(cb);
 
diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
index c134c755ae5d..6003af2bee33 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -1371,7 +1371,8 @@ DEFINE_EVENT(nfsd_cb_class, nfsd_cb_##name,		\
 	TP_PROTO(const struct nfs4_client *clp),	\
 	TP_ARGS(clp))
 
-DEFINE_NFSD_CB_EVENT(state);
+DEFINE_NFSD_CB_EVENT(start);
+DEFINE_NFSD_CB_EVENT(new_state);
 DEFINE_NFSD_CB_EVENT(probe);
 DEFINE_NFSD_CB_EVENT(lost);
 DEFINE_NFSD_CB_EVENT(shutdown);



