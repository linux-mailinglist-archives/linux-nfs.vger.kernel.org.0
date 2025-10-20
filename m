Return-Path: <linux-nfs+bounces-15413-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E8C91BF26A1
	for <lists+linux-nfs@lfdr.de>; Mon, 20 Oct 2025 18:27:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3FC234FA5D4
	for <lists+linux-nfs@lfdr.de>; Mon, 20 Oct 2025 16:26:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43FD1287257;
	Mon, 20 Oct 2025 16:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iGvp0J0O"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E3EA2877D0
	for <linux-nfs@vger.kernel.org>; Mon, 20 Oct 2025 16:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760977554; cv=none; b=q16OLvHpeEmGgxOH5jbCw8296jGDE/nWrLRU2vcUFpcr07Ru0imp53Rna+anFvsI2LAFQxhNOBnsurV26gWw23tO+/SaRvawKcIsIqUaablwFC1NEgC3owCzTfzDU/jlI2ZxLfyhlbzx2UxCkLoRg3JEAiKmGYYrjKE55FhXCds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760977554; c=relaxed/simple;
	bh=B15E/XvtU53JnQeCw/30oPwurIRfv/7XgeKvDwMLVYY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KWi1YoawJPmt3d+cd6oocCv7q9NWaybPItKJA7INe/ehKnmJ4swJhox+Pl0TVdZDIeLuxAwFALqeQOco8Dc3ArkxsVnrNgELNQ59bOZEDmeVjRAgJLbdHQ5Cq8BG68N0/HTwt/O0FbVMHEMYky4tDjl1yYXkig1nUcA/BQMHPDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iGvp0J0O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03C6CC4CEFE;
	Mon, 20 Oct 2025 16:25:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760977553;
	bh=B15E/XvtU53JnQeCw/30oPwurIRfv/7XgeKvDwMLVYY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iGvp0J0OLaQSm16sW0UuwZA95KVppzhwrMDmrSKOmij5deqLfABlb00l/QczV8PY3
	 mrdP9lzI5NYpKmYMBbAaiLKlXo2qlefCh70OUpGCWV2i7CmUu8jbfRcz9gzLTnelIH
	 U3VzMQja0jjCR0dDgTW90NH24JHG+2Oa9OeSw1wldxxc6qEA9c8E//IVBbsW4DvgiE
	 hw8uFaq9TaEn3CxHlKk7gqtvXUi2L+1TCUj2fpQQlsNwmNCUMS6O1pTljFDDyFwdb/
	 CDbWe5aqjwO+9xD14WjckvJON2VAzHQSmnSuMzyP3SD/sn9wuI18XxzFCmW8iXrRfl
	 iIdFju/XFT6uw==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v5 4/4] svcrdma: Mark Read chunks
Date: Mon, 20 Oct 2025 12:25:46 -0400
Message-ID: <20251020162546.5066-5-cel@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251020162546.5066-1-cel@kernel.org>
References: <20251020162546.5066-1-cel@kernel.org>
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


