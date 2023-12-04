Return-Path: <linux-nfs+bounces-278-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E0EC08037B8
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Dec 2023 15:56:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 970471F21288
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Dec 2023 14:56:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 964B328DB9;
	Mon,  4 Dec 2023 14:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GEgQYWmb"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7576D28E1E;
	Mon,  4 Dec 2023 14:56:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2DE8C433C7;
	Mon,  4 Dec 2023 14:56:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701701799;
	bh=ORI2rDzap4AvStiDS5EL3R0Hmgqwk0FJu+y2QYZuGPE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=GEgQYWmbWz1hi8CMlxvOqVEBflppFRK25ucxVo9B/9TyyzykamxuatdTjd4tChB9h
	 nfWj54xj6d4sLFNcTqgO5gqwTnyrnZsC6puDnGh3T8nolG7KHLDs2esArruOWAXpQO
	 BOJWQrHETPkBzZ60S7tmUaHWia2r4JTyCCPWc9CCbe24Me0oJ7ubba8h6zLlnFDPNG
	 +y1gc3eLR9o3VV3cOgL569noCapO2sKd4Mr07Wcy7tx3054HBj0PFPy0rTb+5lCIz2
	 c4iKQr29YcPLbVIM2uZrCEZonbrxpAAjy/OCxB7uyAUQkQlaMr4L5KjC7FfXk5SR05
	 DyU3V9rg0C7Ag==
Subject: [PATCH v1 03/21] svcrdma: Explicitly pass the transport into Write
 chunk I/O paths
From: Chuck Lever <cel@kernel.org>
To: linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Cc: tom@talpey.com
Date: Mon, 04 Dec 2023 09:56:37 -0500
Message-ID: 
 <170170179780.54779.8055264676661542778.stgit@bazille.1015granger.net>
In-Reply-To: 
 <170170144201.54779.9877683240030806819.stgit@bazille.1015granger.net>
References: 
 <170170144201.54779.9877683240030806819.stgit@bazille.1015granger.net>
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

Enable the eventual removal of the svc_rdma_chunk_ctxt::cc_rdma
field.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/svc_rdma_rw.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/sunrpc/xprtrdma/svc_rdma_rw.c b/net/sunrpc/xprtrdma/svc_rdma_rw.c
index 6fa818dc5b11..ef2579141c33 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_rw.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_rw.c
@@ -220,6 +220,8 @@ static void svc_rdma_cc_release(struct svc_rdma_chunk_ctxt *cc,
  *  - Stores arguments for the SGL constructor functions
  */
 struct svc_rdma_write_info {
+	struct svcxprt_rdma	*wi_rdma;
+
 	const struct svc_rdma_chunk	*wi_chunk;
 
 	/* write state of this chunk */
@@ -246,6 +248,7 @@ svc_rdma_write_info_alloc(struct svcxprt_rdma *rdma,
 	if (!info)
 		return info;
 
+	info->wi_rdma = rdma;
 	info->wi_chunk = chunk;
 	info->wi_seg_off = 0;
 	info->wi_seg_no = 0;
@@ -489,7 +492,7 @@ svc_rdma_build_writes(struct svc_rdma_write_info *info,
 		      unsigned int remaining)
 {
 	struct svc_rdma_chunk_ctxt *cc = &info->wi_cc;
-	struct svcxprt_rdma *rdma = cc->cc_rdma;
+	struct svcxprt_rdma *rdma = info->wi_rdma;
 	const struct svc_rdma_segment *seg;
 	struct svc_rdma_rw_ctxt *ctxt;
 	int ret;



