Return-Path: <linux-nfs+bounces-12590-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3181CAE1ACB
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Jun 2025 14:17:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29B491BC7DE9
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Jun 2025 12:17:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F4E628C855;
	Fri, 20 Jun 2025 12:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hn/dGWNV"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4774728C5B0;
	Fri, 20 Jun 2025 12:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750421788; cv=none; b=kV7bVh7f+/M7d7jlsuT5SSlJQEF6T5fY0wLzasKRroAIV/Q55gZfuCWNR4ZLrbJKqDIjYZ3tXLpM2f4f/MCOcM6LUS5ZYZ+Bc3a715Yh2e/kg9HVmF3HA6ucvUO3Kg8QQmv1frb+WQVVbNcs3wUx7x7m7TpZHy2NwMCqf4SgyrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750421788; c=relaxed/simple;
	bh=0l4BD1yI58JbChFClcUlD9ZRDy3Sd0tEqpzraV6lGrM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TdelfYqWj/WIfFaCD7NpPbthn7Pqgdsa0FWByxdmVHlT/ABYrnvg0ZSR/2uBTT/GgDxSgyJnn1Pxkvza+blwak5gv87QA72Ve77rVO/JfCB4OIdUDmDotJH36cslGsfn2fnK4Zik+SeYYmIi9QNp90kJYepfvQbdxRSYCeI4VXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hn/dGWNV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CEC6C4CEE3;
	Fri, 20 Jun 2025 12:16:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750421787;
	bh=0l4BD1yI58JbChFClcUlD9ZRDy3Sd0tEqpzraV6lGrM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=hn/dGWNVV8myptoxZCC08dcKwD2/jlF+BOKGzNTSNjH1nTtlzS7EMbayYugBrCT+P
	 LxKAHRKGrcQVyYokjOEw6nASpDJl1NVgYHKQHdnIOLgJRK2E6Oz9gX+ofGUgsznTCs
	 yb89AgKLU6H9chovxOj+PL5S5ZT9aXvvpDBAEoNBj3vaaznAnn2BzveZT4tFHNxg32
	 brtII/WJ32mLCIKAPozQW8C69vkD0t/sZsr0RCuFoVTx84qroRPRZOtz4veocIgdTm
	 WumGbrTvv2jkWlKYoF6Oi8P4S9/AcqKuF79iro5Q8y/9NUKjEXWQiCrRmHvkqX+N3N
	 MhuxuSbnYPTPg==
From: Jeff Layton <jlayton@kernel.org>
Date: Fri, 20 Jun 2025 08:16:04 -0400
Subject: [PATCH 4/6] sunrpc: return better error in svcauth_gss_accept() on
 alloc failure
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250620-rpc-6-17-v1-4-a309177d713b@kernel.org>
References: <20250620-rpc-6-17-v1-0-a309177d713b@kernel.org>
In-Reply-To: <20250620-rpc-6-17-v1-0-a309177d713b@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1209; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=0l4BD1yI58JbChFClcUlD9ZRDy3Sd0tEqpzraV6lGrM=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBoVVEWAd1MllaNBLFKnFldt4g2w2AbxGkz+hpZe
 b148DBYG+yJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaFVRFgAKCRAADmhBGVaC
 FSLpEACwAzl96h1wHe3xdohmuU08mz5yA8o+0gn5wbfHhMKaFjceLynvWr2jAkLhNNVVfTuzTHd
 GYCHltMCX7i6pBWWed5jRcrn4kDzfWRQ/ZpVn6xZTkCMMeW9lOSGlFH+vTBRZIeO/YLFjrhz+c/
 H+KKI7i2fDiyBxqgWpcbBOS/CP8RGCLwCTOFLQCzJG9d+PsxB89rDX3jhmYBdEwo8vP9pxxfHg1
 E+EKSbajAyH9B849KoGlJr5ALJ1NZEcbHfHREX4om5q0T/2k3cmvsNnGYqfhpnWnO8xBzTnWtal
 dG+MJIdQwNcbspRSOyAPk+IQlirOgSLEQZF2CKxB1RYQiKKkclXUA+ldoxHlLH25T70gMJ6fC8J
 yGGAoH8hfNPMPiKGiDZg+CGZZwRZFd2SLVJYrWMMuNgCUL91TrdcDWAF+tJmVdfY2sx/2LsxfZ+
 +iIslHcgWJReFsYJelxPs7qcU3mwRWmCHpjSpgUJK35Kfo+3JOgoO8B9SehWibCLw7LIQwijVYf
 1BVXrjGxEgomUNFLTUmnAFO+Z5rt0HTY7qnP8Sst6aTPh+QzqNaWdr3hTuvkzwbrKyfYGPyyCNr
 ABftbpp9W3OaxaZRxq/T8N4mNmV0qUB2RU8Xk3GnTExHP4mO7wCtyt6frIW2mWBHbNFbAdlh7vo
 OkJBns9xhFCjCYA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

This ends up returning AUTH_BADCRED when memory allocation fails today.
Fix it to return AUTH_FAILED, which better indicates a failure on the
server.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 net/sunrpc/auth_gss/svcauth_gss.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/sunrpc/auth_gss/svcauth_gss.c b/net/sunrpc/auth_gss/svcauth_gss.c
index 73a90ad873fb9da659ba76184b2e2a0e5324ce0d..e82212f6b5620b7d9981702aca5f1044f8a79804 100644
--- a/net/sunrpc/auth_gss/svcauth_gss.c
+++ b/net/sunrpc/auth_gss/svcauth_gss.c
@@ -1628,7 +1628,7 @@ svcauth_gss_accept(struct svc_rqst *rqstp)
 	int		ret;
 	struct sunrpc_net *sn = net_generic(SVC_NET(rqstp), sunrpc_net_id);
 
-	rqstp->rq_auth_stat = rpc_autherr_badcred;
+	rqstp->rq_auth_stat = rpc_autherr_failed;
 	if (!svcdata)
 		svcdata = kmalloc(sizeof(*svcdata), GFP_KERNEL);
 	if (!svcdata)
@@ -1638,6 +1638,7 @@ svcauth_gss_accept(struct svc_rqst *rqstp)
 	svcdata->rsci = NULL;
 	gc = &svcdata->clcred;
 
+	rqstp->rq_auth_stat = rpc_autherr_badcred;
 	if (!svcauth_gss_decode_credbody(&rqstp->rq_arg_stream, gc, &rpcstart))
 		goto auth_err;
 	if (gc->gc_v != RPC_GSS_VERSION)

-- 
2.49.0


