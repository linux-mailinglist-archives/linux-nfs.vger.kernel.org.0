Return-Path: <linux-nfs+bounces-5322-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 74FD794F204
	for <lists+linux-nfs@lfdr.de>; Mon, 12 Aug 2024 17:48:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20B2F1F223C0
	for <lists+linux-nfs@lfdr.de>; Mon, 12 Aug 2024 15:48:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A82B184541;
	Mon, 12 Aug 2024 15:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q9AsJPqH"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 258461474C3
	for <linux-nfs@vger.kernel.org>; Mon, 12 Aug 2024 15:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723477689; cv=none; b=iZ5akZsP74NmWvbzJKIcxC7cGVJ07MJ8zYlQXBDZB8VE8k+FUtp78pNIlJTxNW7EhED6/YMandI8YiUGDZ30vYk1IdAQa30DeENwHtI8yJKLw+ds3BxJzJOF17HLDExOugXJjDLOl5kNgGaNlilGyFitOyKtyEoKx97rg/sHi1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723477689; c=relaxed/simple;
	bh=k0m32zStcWiR9oAdVE1hhSQ7NggAdOm/k9S8q9Ko1B0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T2tf7zuO6C5TVmb5elearROIEmPESJQ58dWQcqvYIarySblp28PuWz7JmZ2XMKip1NcIYQREZjGSaS2styjANKlx0o8lyKF90+xNZqC2T4QV5gO1pdkNX1bU1BJcSdPlgQEgj0zmB8agiu84uiyPX9Zr4wlVqjPLj6mxcnLXrJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q9AsJPqH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ACABC4AF09;
	Mon, 12 Aug 2024 15:48:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723477688;
	bh=k0m32zStcWiR9oAdVE1hhSQ7NggAdOm/k9S8q9Ko1B0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Q9AsJPqHjUMfu3xar6CM7m2/NwliXDhFMzGeg9cHSsmJ3+D+LwfpY3ydrMWjtsCr0
	 XVXmgh1rQTa/4b2iYV5SgE21lVMj7AkFNDlhkMYvEDhrY8XfnmRSqezgzhswuBQPFF
	 0LH8zHJbU4pUFDxtChL1Zfq9yHd0VrE7KOE57waobCrL2zMckIGiWxWXVGmqArdZKj
	 6rCgvVFWvxiITPcaeJVVUAOkRk/mq9+r5VAvT6LOlMBHyjBLLyCncSKrFtS6x7m8if
	 Ap9DGAu9WYPd64bJw0PA9UrgxgSJTXgUw8wdG4zTmzHEcRa8eWaomCibFHBS6oe3If
	 /DaSRV8x9WLNA==
From: cel@kernel.org
To: Anna Schumaker <anna@kernel.org>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	<linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH 1/3] rpcrdma: Device kref is over-incremented on error from xa_alloc
Date: Mon, 12 Aug 2024 11:47:57 -0400
Message-ID: <20240812154759.29870-2-cel@kernel.org>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240812154759.29870-1-cel@kernel.org>
References: <20240812154759.29870-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

If the device's reference count is too high, the device completion
callback never fires.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/ib_client.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sunrpc/xprtrdma/ib_client.c b/net/sunrpc/xprtrdma/ib_client.c
index a938c19c3490..4d1e9fa89573 100644
--- a/net/sunrpc/xprtrdma/ib_client.c
+++ b/net/sunrpc/xprtrdma/ib_client.c
@@ -62,9 +62,9 @@ int rpcrdma_rn_register(struct ib_device *device,
 	if (!rd || test_bit(RPCRDMA_RD_F_REMOVING, &rd->rd_flags))
 		return -ENETUNREACH;
 
-	kref_get(&rd->rd_kref);
 	if (xa_alloc(&rd->rd_xa, &rn->rn_index, rn, xa_limit_32b, GFP_KERNEL) < 0)
 		return -ENOMEM;
+	kref_get(&rd->rd_kref);
 	rn->rn_done = done;
 	return 0;
 }
-- 
2.45.1


