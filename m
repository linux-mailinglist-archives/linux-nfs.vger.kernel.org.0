Return-Path: <linux-nfs+bounces-4347-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB270918E72
	for <lists+linux-nfs@lfdr.de>; Wed, 26 Jun 2024 20:28:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84F5D2882C6
	for <lists+linux-nfs@lfdr.de>; Wed, 26 Jun 2024 18:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D453819067B;
	Wed, 26 Jun 2024 18:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SZfVzmkH"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACE6F190670;
	Wed, 26 Jun 2024 18:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719426486; cv=none; b=UBK7j2AYhyk6e7inUPFLsvGw46XsBDxXle3iciyR23nZLT6Z39y/EOryCbPflFytCAyqMQDbW1baQ11Heu9PQMN1hqCDIs2/ZdYHXGI6aL0GgGvAnbUldr0m37mGHsx9w1M6yy00bpGIaTq4xzKVmSPnWrxja5sCiPt8phh7Rz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719426486; c=relaxed/simple;
	bh=KMqAabxC7Hp5S72d6qc8ulWjEDy19zQgNFo25KslFQ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lYaUZaX9aQl5GfeEDLNljYlm+4PYw+Emoj2Jpzle7Y5FgbisRhLqQaKaqSLgYsEjd68emrdyAnAi0sAYVckpl+3r7H43NvVVZD/WNFZ8jBTMBdbh87WTaQ3i3lCklB6IxqS69jAr9LVSa4JWeJCFY9ZLemf1/ND4jxexfLJQj/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SZfVzmkH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C58DEC32782;
	Wed, 26 Jun 2024 18:28:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719426486;
	bh=KMqAabxC7Hp5S72d6qc8ulWjEDy19zQgNFo25KslFQ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SZfVzmkHJp6vPSI50RBx51T60A7CMqeUKR36bNuwo2zsOkFTQYFcxjGAbkBc3u6v1
	 J4mOcLLcg2ELcjVNBNOAMLcGAxFBEhLXDcZoIUhr8Rh18EWkPqhpJK8T2wzhIPsoYV
	 2kxCWVOnI8fBRkuOICDPZWBU5u1Zc1ov+uTciv4y8FcQZdETCHbodkhdU+w3OLb+XL
	 m0btvGaXHkV/W9/5Y6yVNP2f0+BBnFxSVrcBQx393b5oJZSW2wsohk8X1VfPEAtYjo
	 UgNta6fY2lVNwyhoTBmlmvNEobhOagi0FW/evDzz/hK/OIij5MmC0M2IQxAS6u072I
	 gmZa0T24Iethw==
From: cel@kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Cc: <linux-nfs@vger.kernel.org>,
	<stable@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Subject: [PATCH 5.10 3/5] SUNRPC: Fix svcxdr_init_decode's end-of-buffer calculation
Date: Wed, 26 Jun 2024 14:27:43 -0400
Message-ID: <20240626182745.288665-4-cel@kernel.org>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240626182745.288665-1-cel@kernel.org>
References: <20240626182745.288665-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

[ Upstream commit 90bfc37b5ab91c1a6165e3e5cfc49bf04571b762 ]

Ensure that stream-based argument decoding can't go past the actual
end of the receive buffer. xdr_init_decode's calculation of the
value of xdr->end over-estimates the end of the buffer because the
Linux kernel RPC server code does not remove the size of the RPC
header from rqstp->rq_arg before calling the upper layer's
dispatcher.

The server-side still uses the svc_getnl() macros to decode the
RPC call header. These macros reduce the length of the head iov
but do not update the total length of the message in the buffer
(buf->len).

A proper fix for this would be to replace the use of svc_getnl() and
friends in the RPC header decoder, but that would be a large and
invasive change that would be difficult to backport.

Fixes: 5191955d6fc6 ("SUNRPC: Prepare for xdr_stream-style decoding on the server-side")
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/sunrpc/svc.h | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
index 8583825c4aea..f0e09427070c 100644
--- a/include/linux/sunrpc/svc.h
+++ b/include/linux/sunrpc/svc.h
@@ -536,16 +536,27 @@ static inline void svc_reserve_auth(struct svc_rqst *rqstp, int space)
 }
 
 /**
- * svcxdr_init_decode - Prepare an xdr_stream for svc Call decoding
+ * svcxdr_init_decode - Prepare an xdr_stream for Call decoding
  * @rqstp: controlling server RPC transaction context
  *
+ * This function currently assumes the RPC header in rq_arg has
+ * already been decoded. Upon return, xdr->p points to the
+ * location of the upper layer header.
  */
 static inline void svcxdr_init_decode(struct svc_rqst *rqstp)
 {
 	struct xdr_stream *xdr = &rqstp->rq_arg_stream;
-	struct kvec *argv = rqstp->rq_arg.head;
+	struct xdr_buf *buf = &rqstp->rq_arg;
+	struct kvec *argv = buf->head;
 
-	xdr_init_decode(xdr, &rqstp->rq_arg, argv->iov_base, NULL);
+	/*
+	 * svc_getnl() and friends do not keep the xdr_buf's ::len
+	 * field up to date. Refresh that field before initializing
+	 * the argument decoding stream.
+	 */
+	buf->len = buf->head->iov_len + buf->page_len + buf->tail->iov_len;
+
+	xdr_init_decode(xdr, buf, argv->iov_base, NULL);
 	xdr_set_scratch_page(xdr, rqstp->rq_scratch_page);
 }
 
-- 
2.45.1


