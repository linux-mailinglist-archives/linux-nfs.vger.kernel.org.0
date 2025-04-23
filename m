Return-Path: <linux-nfs+bounces-11235-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86CECA99203
	for <lists+linux-nfs@lfdr.de>; Wed, 23 Apr 2025 17:38:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8552B1652CB
	for <lists+linux-nfs@lfdr.de>; Wed, 23 Apr 2025 15:31:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6E562BE0F3;
	Wed, 23 Apr 2025 15:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PYbOz/ih"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B24E92BE0EC
	for <linux-nfs@vger.kernel.org>; Wed, 23 Apr 2025 15:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745421681; cv=none; b=GqL7ox+nD+1/Ea6nVQZ2npOJ9abEyLlD0zFXHB8vzXwticpgGDX92t+FnDHkxNN928bKMci3yhT7z1x24SYrXkXZI4vz2K8TTw/0arDiyJeS/zSl2bpt//Oinbt657B2lIiieXDBLFbxdRzoEA1cmqX8xGjhL9ojsEqnlXpqjrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745421681; c=relaxed/simple;
	bh=RUov9i3rg/YxtsCBEgo4/49hlYjwLri3S4E7lCp8I5A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GhL0FO4A9XR1dzVahOcDwNi+uB84HNu7u3RHwobrDwnJDLy+cPKf97CFBBTid9NhBQzvXjvpAaMIBvhaefYj33uMUTxUu7TLYCQ1fTdi+65Lj7jJKsBIXfEL8zCwBOfsZjcHbGXcQe6ZFuzMZVaOfs4xVkY0zhJKEhz72pgbO48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PYbOz/ih; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9AF3C4CEE3;
	Wed, 23 Apr 2025 15:21:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745421681;
	bh=RUov9i3rg/YxtsCBEgo4/49hlYjwLri3S4E7lCp8I5A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PYbOz/ihA9LF2q9fidXRVQetHyNCuIATXspiIZmvLyEEJgXgRjAlm97bqi4qIPP4D
	 eZkoyPMDLvV/i/n5bvkOEizhg8NZQQQzgYTMxxB0RhnMOcwy6sXrCMNmYqHtxyXZ7i
	 jkcO0argZiFvlrGKNQmIJrZwx+uiY49sN4y7nDbC8nYlrMT/BL/pGkp6ojpvGdlsil
	 sqSObnWokQ8nY9L58vz0H1BYQUvCrV5MnUHIbbpOfFn1XMkp/IbLP/801RUgt4ngeN
	 JJCYt76yAplVUlGT9M3W5FDUcVllYWobrA94eQ6cjNtMToVfbKZ1xjCEyu7DgNXwyj
	 wpF90R7QVWBMw==
From: cel@kernel.org
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v3 01/11] sunrpc: Remove backchannel check in svc_init_buffer()
Date: Wed, 23 Apr 2025 11:21:07 -0400
Message-ID: <20250423152117.5418-2-cel@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250423152117.5418-1-cel@kernel.org>
References: <20250423152117.5418-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

The server's backchannel uses struct svc_rqst, but does not use the
pages in svc_rqst::rq_pages. It's rq_arg::pages and rq_res::pages
comes from the RPC client's page allocator. Currently,
svc_init_buffer() skips allocating pages in rq_pages for that
reason.

Except that, svc_rqst::rq_pages is filled anyway when a backchannel
svc_rqst is passed to svc_recv() -> and then to svc_alloc_arg().

This isn't really a problem at the moment, except that these pages
are allocated but then never used, as far as I can tell.

The problem is that later in this series, in addition to populating
the entries of rq_pages[], svc_init_buffer() will also allocate the
memory underlying the rq_pages[] array itself. If that allocation is
skipped, then svc_alloc_args() chases a NULL pointer for ingress
backchannel requests.

I'm not sure the way proposed here is best, but it does avoid
introducing extra conditional logic in svc_alloc_args(), which is a
hot path.

Acked-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/svc.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index e7f9c295d13c..8ce3e6b3df6a 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -640,10 +640,6 @@ svc_init_buffer(struct svc_rqst *rqstp, unsigned int size, int node)
 {
 	unsigned long pages, ret;
 
-	/* bc_xprt uses fore channel allocated buffers */
-	if (svc_is_backchannel(rqstp))
-		return true;
-
 	pages = size / PAGE_SIZE + 1; /* extra page as we hold both request and reply.
 				       * We assume one is at most one page
 				       */
-- 
2.49.0


