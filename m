Return-Path: <linux-nfs+bounces-11675-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A9BF8AB4EA7
	for <lists+linux-nfs@lfdr.de>; Tue, 13 May 2025 10:58:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39F15460CDD
	for <lists+linux-nfs@lfdr.de>; Tue, 13 May 2025 08:58:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C87191EB19F;
	Tue, 13 May 2025 08:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nRJ3kA/R"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5175220F082
	for <linux-nfs@vger.kernel.org>; Tue, 13 May 2025 08:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747126678; cv=none; b=N0GHOH02HFq1lfMIj/fmcnjbhHCvYeNWf8v6TqRgkklC/m91BcJdANDgIY/9pVag0WR9S0lZNBVB5ZNw07exNAQBcO307WbBcGKe2TRkpYP0joP9bEXFIYQXmaHHFjykKjHKii/+v9uQGd7roKpZXpSJRX65aTrQbX0vxHufkBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747126678; c=relaxed/simple;
	bh=PngoMLn1TDlhxfpmK4la1nYG7WweV+C7kfoOIxeN7CI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WavPU0jR8rmH52FRXIDIRnswmmqt5Rfc4+J/NU7IlkCbOSA4u4ciNw7GEo7hXcKVdCQkkV8el7EVHH9+qUlXCodsebKKnmptkMRWZrsmeeC3ry6KEcpXcHBwwz8AhmsgK2gVmY+JvxobmhMEve4xGDVI8Mnm0k8HrjLx1a7MPR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=nRJ3kA/R; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=KicBUj3m+zTwrS3FPMjD/dojgiN0J1Lbv0uMf4925tE=; b=nRJ3kA/Rofmkw927bNUFxLAumA
	bvCQp8FEZNgDlcRoN0vv/JRiQQgn2ub8oCLmeYXQEgd3zAUjs0BlKqq73BgHs3asIc3HIpVfcJmif
	fdhlYZe7WA3wMew/0Rp4wzPDTvLvvkAR5pWXaOJsircAN7fxBRDqttqxnF2gIgY5rO/s3c37TFEoK
	V6kNpts4Q9xMUvpZHiP+ikV2VV9Fzl4WOjIFiql9vYqr62Xuov6mpWp1ac6cHjIQ7w953ePF5sZdb
	m6DmfDQd9sQbTuiOrHD98fjOccvsn61YcTj/PuMISYzSQAPRuqZ5EshgUZqgPcykJ++u05qmZ9m9i
	N3UrM3nA==;
Received: from 2a02-8389-2341-5b80-3c00-8f88-6e38-56f1.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:3c00:8f88:6e38:56f1] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uElSU-0000000BpCf-1afk;
	Tue, 13 May 2025 08:57:54 +0000
From: Christoph Hellwig <hch@lst.de>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org
Subject: [PATCH 3/3] sunrpc: unexport csum_partial_copy_to_xdr
Date: Tue, 13 May 2025 10:57:26 +0200
Message-ID: <20250513085739.894150-4-hch@lst.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250513085739.894150-1-hch@lst.de>
References: <20250513085739.894150-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

csum_partial_copy_to_xdr is only used inside the sunrpc module, so
remove the export.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 net/sunrpc/socklib.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/sunrpc/socklib.c b/net/sunrpc/socklib.c
index 7196e7042e0f..68b16f2ba686 100644
--- a/net/sunrpc/socklib.c
+++ b/net/sunrpc/socklib.c
@@ -158,7 +158,6 @@ int csum_partial_copy_to_xdr(struct xdr_buf *xdr, struct sk_buff *skb)
 		return -1;
 	return 0;
 }
-EXPORT_SYMBOL_GPL(csum_partial_copy_to_xdr);
 
 static inline int xprt_sendmsg(struct socket *sock, struct msghdr *msg,
 			       size_t seek)
-- 
2.47.2


