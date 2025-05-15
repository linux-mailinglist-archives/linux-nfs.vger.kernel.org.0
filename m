Return-Path: <linux-nfs+bounces-11737-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AD27AB8538
	for <lists+linux-nfs@lfdr.de>; Thu, 15 May 2025 13:49:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FD953ABF17
	for <lists+linux-nfs@lfdr.de>; Thu, 15 May 2025 11:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E905225414;
	Thu, 15 May 2025 11:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="u1c5BllV"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8C96298275
	for <linux-nfs@vger.kernel.org>; Thu, 15 May 2025 11:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747309768; cv=none; b=nhAIERg9o1IFpfTtQ9q2GPkAeHv+3M0x4QMZtt41VFr3DqTEYgjmpB35BD6ZuVOzS9pAkEPIhPe8C/lpAYboksfO1yaR7RQb9BUAxstxzgCFGUsFoxB+eLdZnbdoFIxsmST31TrMRUoLzAfxyc1OQwI4JI6zdPETvlLgsMOM/H0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747309768; c=relaxed/simple;
	bh=grP/ww5e56KBcLeGlSpCqM+NUE2PY8i1+VsvNidE02k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pLmWuEjDdOYrhYQ0cvRB3lrTbms9KbS+mLrVaWq6xW4TxZBBIXUaLby0jghZtUKOz31hLIycsiCnTe7AFZ7dT2MmoVR3SetCP4bx2dL9as0EvwLLIcrHt8k1dnErtRIFkwjSk/Tz3nMguhM6Oqka3EmMf3D1smhyqTTq7E6qYWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=u1c5BllV; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=l1tmyeIGLlMw4MHA651F26ityewTsDg/YNzOPySumu8=; b=u1c5BllVAFAB0Xj8A3jdWXNnAs
	/Xvb3m361gVz2wJRLTOAB/BdCrnvgkAY1FsWWB2qS28ljsjPX03567e41lISn8Rri+L/TLjrOFijn
	Cq+m9cz7DrkM1Dmde9fx9Cj29eIRqzhFwptfcDwIaFe+oLe5Nxf5T6OdDT/Pv8LhweyGZlBvsK+LB
	bOhoOWq1id+ax5T7OdxdAmJU7SoaSrwmx7l9WnhuB73+gOqCAdH+5cj8sg+N1nWjyxzP1p0rwn4vw
	xQl0x3mgxMx3acPA82RUTvR/7y2UtDJnzZZwhcqA8g0//725zveE8He6ZtbjU57sM0bq3SG1HgYiq
	D/fNimNg==;
Received: from 2a02-8389-2341-5b80-81b5-a24e-41ab-85a6.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:81b5:a24e:41ab:85a6] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uFX5Y-00000000S8J-28gR;
	Thu, 15 May 2025 11:49:24 +0000
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
Date: Thu, 15 May 2025 13:48:47 +0200
Message-ID: <20250515114906.32559-4-hch@lst.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250515114906.32559-1-hch@lst.de>
References: <20250515114906.32559-1-hch@lst.de>
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
Reviewed-by: Jeff Layton <jlayton@kernel.org>
---
 net/sunrpc/socklib.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/sunrpc/socklib.c b/net/sunrpc/socklib.c
index 75e31e3a3ced..3c7e8e677e91 100644
--- a/net/sunrpc/socklib.c
+++ b/net/sunrpc/socklib.c
@@ -156,7 +156,6 @@ int csum_partial_copy_to_xdr(struct xdr_buf *xdr, struct sk_buff *skb)
 		netdev_rx_csum_fault(skb->dev, skb);
 	return 0;
 }
-EXPORT_SYMBOL_GPL(csum_partial_copy_to_xdr);
 
 static inline int xprt_sendmsg(struct socket *sock, struct msghdr *msg,
 			       size_t seek)
-- 
2.47.2


