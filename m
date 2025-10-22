Return-Path: <linux-nfs+bounces-15536-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6062EBFE03E
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Oct 2025 21:22:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C06AE4EC9E3
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Oct 2025 19:22:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AC523469EE;
	Wed, 22 Oct 2025 19:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j0DVAXSi"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26DBB3491EC
	for <linux-nfs@vger.kernel.org>; Wed, 22 Oct 2025 19:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761160941; cv=none; b=ckwDHClHKc6nukikmvQ/avjySE9sQLLtty7vFcbWiRdMF5QYQZCE7oQsL51hFgR9XQGjHqunH7BGLVtPqAHTZzXOp1Hb1pcjB6/J9QKCoONLfY3BkIhqsF6yT7JwPsvuvWblx5QbIUTr6CccjNEyk5CYQudLMJoVEoGmfruUPeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761160941; c=relaxed/simple;
	bh=rC5kmlC3xdrqYUqrlsvtkETW5UnmF9CJm77qp7Uw874=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dcqjJ8ovep/29z+KLoYql/4Z43+xjDbidU8wkhwJKVFpuQOpc+SH06lU0VmKB8oCBTvqLAnvhIdkH1tqVdrrgQsCuxJpdYd2/b0OEln1ZCTxd0X1K2L9D9ChiSMgRtUPFnZdBvIy9l1jg0ixnF2g4oi7tvbPkCG0MP2ETU+T8tE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j0DVAXSi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C707C4CEE7;
	Wed, 22 Oct 2025 19:22:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761160940;
	bh=rC5kmlC3xdrqYUqrlsvtkETW5UnmF9CJm77qp7Uw874=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=j0DVAXSiZVMJDck6KXsfJ2JGzt6Ed9I8vfLHsf4mKbulQUqRt3LQeSs6mG9wQL5Wy
	 /zs5G+UGstzrzFFGfWKVXUvJiqM+WIQWg/wc/8xNtrjrP5tIKTPJ9YvRR2r6MAdQr9
	 PqjqPWtXBnLtmNlfQVfUsCmqW++VscBTTX7lTEx9SOKKWS3G25a62ipkhvizUODNVE
	 t01yA/24zy72u87UZEx4ieXdzawegWU4QNBNfP5PnfNJeHciQM3UP56Q4Wp2sG8/Ku
	 J5sFjGFjw1yF6Ec0/3a1TiyXuqzD9L8ts1FIKQYvpDM2bnu/QdaR8JqWsMz9IobI1K
	 qHEpzIDW0a5aw==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v6 5/5] svcrdma: Mark Read chunks
Date: Wed, 22 Oct 2025 15:22:08 -0400
Message-ID: <20251022192208.1682-6-cel@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251022192208.1682-1-cel@kernel.org>
References: <20251022192208.1682-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

The upper layer may want to know when the receive buffer's .pages
array is guaranteed to contain only an opaque payload. This permits
the upper layer to optimize its buffer handling.

NB: Since svc_rdma_recvfrom.c is under net/, we use the comment
style that is preferred in the networking layer.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/svc_rdma_recvfrom.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
index e7e4a39ca6c6..b1a0c72f73de 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
@@ -815,6 +815,11 @@ static void svc_rdma_read_complete_one(struct svc_rqst *rqstp,
 	buf->page_len = length;
 	buf->len += length;
 	buf->buflen += length;
+
+	/* Transport guarantees that only the chunk payload
+	 * appears in buf->pages.
+	 */
+	buf->flags |= XDRBUF_READ;
 }
 
 /* Finish constructing the RPC Call message in rqstp::rq_arg.
-- 
2.51.0


