Return-Path: <linux-nfs+bounces-3349-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D68C58CCE97
	for <lists+linux-nfs@lfdr.de>; Thu, 23 May 2024 10:49:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13AFE1C223D4
	for <lists+linux-nfs@lfdr.de>; Thu, 23 May 2024 08:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CB0813C918;
	Thu, 23 May 2024 08:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="swTOEFYm"
X-Original-To: linux-nfs@vger.kernel.org
Received: from esa5.hc1455-7.c3s2.iphmx.com (esa5.hc1455-7.c3s2.iphmx.com [68.232.139.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30C3913D240
	for <linux-nfs@vger.kernel.org>; Thu, 23 May 2024 08:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.139.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716454126; cv=none; b=HD3EK84uJa1mgrsDS96x+sm0PLJnrwIQPbl+LUXPaOhtvEO0eq1Zx5ADdGqUdPFYpLM27l0JajkSbYTluxpNnFoYfabFU0iyiZq/6ClQrgNiVt/G3gQ0lnnOYx7ChO+XcNOKbPSZ+n9Fz7EPV2tY1masFxNRymVhimtcJaN/r5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716454126; c=relaxed/simple;
	bh=bMrOVwMSoV+XLYH5d782F8E7Si+Ryq6udCGhYw6vprE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RIP8GbGSeqPdiRNW8v8aYZy8P8ZErECRnnISeevJWN1950QMnAm3PuQgIktSepvN/h7tcKbMMB7Wz+5BxHcbplC+zO93x6bOiTDF5W8It/hb+wzc0i+eivDhwMV79jR6a6raWSXCab8sqIwNJfvKWs6MF7Bu27WWhvOQZV7BXfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=swTOEFYm; arc=none smtp.client-ip=68.232.139.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1716454124; x=1747990124;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=bMrOVwMSoV+XLYH5d782F8E7Si+Ryq6udCGhYw6vprE=;
  b=swTOEFYmZ2dNBf2P2o0DxOJjYWNQ9BBqSL+NxwuS606AnJ7OhqcLjaxI
   KLjStTUDAewA5bBS8XXSniWPB/rERN69WCl3N3qxbhdO8Z50N0yUUQRPy
   pEuqYUHJYuQaNUVMGzEI3OEYc8r7LGTfHbHv4e8Zue7GjaKM0mHNvXsNn
   PoJL04lD/ip5CdAzp3/IGNbzK0Y53i/c1YiuWXGQ8wviROb0jZuedPDDd
   5P454kuXzu1N0qAqjbBfrHteh1p+UyE6NlsXrzBAkkjPMiHld7KM4AgEs
   qWeKv6IwNJM+mr69tlIBIBWzkqYlAsnWWaqHKpETwuumFNAtbgOW+h810
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11080"; a="158716518"
X-IronPort-AV: E=Sophos;i="6.08,182,1712588400"; 
   d="scan'208";a="158716518"
Received: from unknown (HELO yto-r2.gw.nic.fujitsu.com) ([218.44.52.218])
  by esa5.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2024 17:47:32 +0900
Received: from yto-m1.gw.nic.fujitsu.com (yto-nat-yto-m1.gw.nic.fujitsu.com [192.168.83.64])
	by yto-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id AC568C68E9
	for <linux-nfs@vger.kernel.org>; Thu, 23 May 2024 17:47:27 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com [192.51.206.22])
	by yto-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id DAFF2D17CF
	for <linux-nfs@vger.kernel.org>; Thu, 23 May 2024 17:47:26 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id 58B85266471
	for <linux-nfs@vger.kernel.org>; Thu, 23 May 2024 17:47:26 +0900 (JST)
Received: from G08FNSTD200033.g08.fujitsu.local (unknown [10.167.225.189])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id 4B4CC1A000A;
	Thu, 23 May 2024 16:47:25 +0800 (CST)
From: Chen Hanxiao <chenhx.fnst@fujitsu.com>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Neil Brown <neilb@suse.de>,
	Olga Kornievskaia <kolga@netapp.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH] SUNRPC: return proper error from gss_wrap_req_priv
Date: Thu, 23 May 2024 16:47:16 +0800
Message-Id: <20240523084716.524-1-chenhx.fnst@fujitsu.com>
X-Mailer: git-send-email 2.37.1.windows.1
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28404.006
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28404.006
X-TMASE-Result: 10--10.451900-10.000000
X-TMASE-MatchedRID: Aj5qVJnJzyTgUbgLLPhW5hF4zyLyne+ATJDl9FKHbrmqA3rusLu26n9G
	iwIIx1yA5cdiVam5C5/9G1S5LKabNq8FCKdxpBvsHWRJEfGP5nkIRGdp3SjqDUty8cifGH0UF8x
	yJ3Sgyn7i8zVgXoAltr8hWd4lAsFlC24oEZ6SpSkj80Za3RRg8HAlAihi+p0zEYmT9RCPd3Tqi1
	d/S4pToP9/M/zvbp30w1qwjxYea6Q=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0

don't return 0 if snd_buf->len really greater than snd_buf->buflen

Signed-off-by: Chen Hanxiao <chenhx.fnst@fujitsu.com>
---
 net/sunrpc/auth_gss/auth_gss.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/sunrpc/auth_gss/auth_gss.c b/net/sunrpc/auth_gss/auth_gss.c
index c7af0220f82f..369310909fc9 100644
--- a/net/sunrpc/auth_gss/auth_gss.c
+++ b/net/sunrpc/auth_gss/auth_gss.c
@@ -1875,8 +1875,10 @@ gss_wrap_req_priv(struct rpc_cred *cred, struct gss_cl_ctx *ctx,
 	offset = (u8 *)p - (u8 *)snd_buf->head[0].iov_base;
 	maj_stat = gss_wrap(ctx->gc_gss_ctx, offset, snd_buf, inpages);
 	/* slack space should prevent this ever happening: */
-	if (unlikely(snd_buf->len > snd_buf->buflen))
+	if (unlikely(snd_buf->len > snd_buf->buflen)) {
+		status = -EIO;
 		goto wrap_failed;
+	}
 	/* We're assuming that when GSS_S_CONTEXT_EXPIRED, the encryption was
 	 * done anyway, so it's safe to put the request on the wire: */
 	if (maj_stat == GSS_S_CONTEXT_EXPIRED)
-- 
2.39.1


