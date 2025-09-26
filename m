Return-Path: <linux-nfs+bounces-14748-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97C8CBA4819
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Sep 2025 17:52:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 534273A3968
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Sep 2025 15:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF41C223DF6;
	Fri, 26 Sep 2025 15:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TjteM2Jn"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 871CA129A78;
	Fri, 26 Sep 2025 15:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758901958; cv=none; b=KCx+/eZpTHGLGZPXvGRuIcvuPB7bOSzJ5mkdnEDSIlq3GmrMd7m/lx9rWBS4sgfn3LvxFoa594KpYzLsX0H2KUiOD8nYhuYTy61l2qhV1RAHOXF8u7OJmDqP1tWKEEmyCIe2QjmXjVjqpBjC2UmWe11Dy+KVDqrR6Iu3dC9/QCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758901958; c=relaxed/simple;
	bh=jQshrCPL1uTx+E5ztfz9raA8WJc5kB5Vjkv8hhkiHdI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mbnKaITIaMlOghgZNNo5gu+JEEzANrlehaMokcvPMMwerpV4F7J4JESNB1GL0WPqBirmkoSfLfGiDhWKXXKu/VuF5lqs96WvdVvkkBnV+/GAnhwL+YNyvQDrTHTJZZ/Pk4ItHslLq8rMgRsA51SYpH9QtEnx2B7Pnnq/G0RZFpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TjteM2Jn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EC22C4CEF4;
	Fri, 26 Sep 2025 15:52:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758901958;
	bh=jQshrCPL1uTx+E5ztfz9raA8WJc5kB5Vjkv8hhkiHdI=;
	h=From:To:Cc:Subject:Date:From;
	b=TjteM2JnXAUlpcZt5MU5wfACscG37vIIskqAODBdbFO4BVe+Gad6KL2cdYs4+amac
	 7bLvWS1zz1/27ba82SV5bHiZVRFl5oqctg7vZJmnySeEoAqawr2HTDwrsolSl6E8Nw
	 AZHv2bv3dz2RnGlc8fdesgVvLZEv/njt5b180nDv2MWi0HzKhD5liKgexY69nAsvC5
	 bOfhi0odt6i4OQiH+Cq5xsujNFrph6vnICNYaP78dkVcbdDIsd0moaiOkNLvDP4krj
	 t/dpxkd1hOHUc/dlV59OaUdwzwW8Z5NpUa9+GoaWiRFBuWjnRMu5ILJNHVrggZBylf
	 3eyZDOIkY7vFg==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v1] svcrdma: Increase the server's default RPC/RDMA credit grant
Date: Fri, 26 Sep 2025 11:52:35 -0400
Message-ID: <20250926155235.60924-1-cel@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

Now that the nfsd thread count can scale to more threads, permit
individual clients to make more use of those threads. Increase the
RPC/RDMA per-connection credit grant from 64 to 128 -- same as the
Linux NFS client.

Simple single client fio-based benchmarking so far shows only
improvement, no regression.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/sunrpc/svc_rdma.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/sunrpc/svc_rdma.h b/include/linux/sunrpc/svc_rdma.h
index 22704c2e5b9b..57f4fd94166a 100644
--- a/include/linux/sunrpc/svc_rdma.h
+++ b/include/linux/sunrpc/svc_rdma.h
@@ -131,7 +131,7 @@ static inline struct svcxprt_rdma *svc_rdma_rqst_rdma(struct svc_rqst *rqstp)
  */
 enum {
 	RPCRDMA_LISTEN_BACKLOG	= 10,
-	RPCRDMA_MAX_REQUESTS	= 64,
+	RPCRDMA_MAX_REQUESTS	= 128,
 	RPCRDMA_MAX_BC_REQUESTS	= 2,
 };
 
-- 
2.51.0


