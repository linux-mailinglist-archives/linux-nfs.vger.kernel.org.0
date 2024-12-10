Return-Path: <linux-nfs+bounces-8489-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6167F9EA40A
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Dec 2024 02:03:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB52D166E48
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Dec 2024 01:03:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D072170806;
	Tue, 10 Dec 2024 01:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="OxgbSu8o"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 224C04C81;
	Tue, 10 Dec 2024 01:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733792571; cv=none; b=ckNyRexM0TO5EmOJYkLXOLNlZsXd/hNICV1VGrMThXKtD+McuIsJJAKd7UMXw/eKaFnt2M0F33QhAxulsr5M0/H9YbLCptuPFmsv+i+0LxBIw0lUpWPENn5tlRc+wowhvFhGVp2pGhg18aWNGcP0ybk6DDcq2dszGnaFdh4g+gM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733792571; c=relaxed/simple;
	bh=FikacwOceV8WTYv3qRskTLQxlm2UT7s3KO/UmEIEY6U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qbBAGCtYumhVoh/YrXhLvs/b4qi3U6CX3jrAoU98oosPgKYd4LNnhwSDjATgqKEEBFChP0RhSnGf9lXLH6MTnlCYH+4YBDxAowocgMlQWs1mEVJjLLPpcrdvwWdU+Cn8aLb6ye6Lipnzolm1A/E6mSyCugXiJZ3v9O3Mq1zFwiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=OxgbSu8o; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=pqiXYTA41lhuBLarW6/wfqenQXsfc6O8HWAF6tBuSSc=; b=OxgbSu8oLeRcPc6b
	OCi98mkXrbknrfoxV4W5s6TD/HBxj/eXzdKiLgPRPYVgy7HmyGiY1DhMPVijdS1Wu4UGMXcdMtazH
	67xTjoV2PVuo3cN5Liail7sfqrrgQxoZlQ3a2+91dRL2c+PPZkUYccyRMVvzVtyrnfwLRMYL6ZZ3I
	HXYHW3o6S1PnkdLBnJk1dmyd6udhGFJt+9r1tYH0w6GgROsAW6f7hjyYi2qBRV8ss8jrFrjXhisR/
	GTi6WXU0JGyTTGTG5POu5/pA5AgFJ8dd7Q82GgQIuJK3cTPd2V+qAtFdhtW3aD/evyl8SPdFNd6Aj
	5EWhrkFcxOOHoGkNOg==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1tKodx-004Oea-2N;
	Tue, 10 Dec 2024 01:02:29 +0000
From: linux@treblig.org
To: trondmy@kernel.org,
	anna@kernel.org,
	chuck.lever@oracle.com,
	jlayton@kernel.org,
	neilb@suse.de,
	okorniev@redhat.com,
	Dai.Ngo@oracle.com,
	tom@talpey.com
Cc: linux-nfs@vger.kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH 1/3] sunrpc: Remove unused xprt_iter_get_xprt
Date: Tue, 10 Dec 2024 01:02:23 +0000
Message-ID: <20241210010225.343017-2-linux@treblig.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241210010225.343017-1-linux@treblig.org>
References: <20241210010225.343017-1-linux@treblig.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

xprt_iter_get_xprt() was added by
commit 80b14d5e61ca ("SUNRPC: Add a structure to track multiple
transports") but is unused.

Remove it.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 include/linux/sunrpc/xprtmultipath.h |  1 -
 net/sunrpc/xprtmultipath.c           | 17 -----------------
 2 files changed, 18 deletions(-)

diff --git a/include/linux/sunrpc/xprtmultipath.h b/include/linux/sunrpc/xprtmultipath.h
index c0514c684b2c..e411368cdacf 100644
--- a/include/linux/sunrpc/xprtmultipath.h
+++ b/include/linux/sunrpc/xprtmultipath.h
@@ -75,7 +75,6 @@ extern struct rpc_xprt_switch *xprt_iter_xchg_switch(
 		struct rpc_xprt_switch *newswitch);
 
 extern struct rpc_xprt *xprt_iter_xprt(struct rpc_xprt_iter *xpi);
-extern struct rpc_xprt *xprt_iter_get_xprt(struct rpc_xprt_iter *xpi);
 extern struct rpc_xprt *xprt_iter_get_next(struct rpc_xprt_iter *xpi);
 
 extern bool rpc_xprt_switch_has_addr(struct rpc_xprt_switch *xps,
diff --git a/net/sunrpc/xprtmultipath.c b/net/sunrpc/xprtmultipath.c
index 720d3ba742ec..7e98d4dd9f10 100644
--- a/net/sunrpc/xprtmultipath.c
+++ b/net/sunrpc/xprtmultipath.c
@@ -602,23 +602,6 @@ struct rpc_xprt *xprt_iter_get_helper(struct rpc_xprt_iter *xpi,
 	return ret;
 }
 
-/**
- * xprt_iter_get_xprt - Returns the rpc_xprt pointed to by the cursor
- * @xpi: pointer to rpc_xprt_iter
- *
- * Returns a reference to the struct rpc_xprt that is currently
- * pointed to by the cursor.
- */
-struct rpc_xprt *xprt_iter_get_xprt(struct rpc_xprt_iter *xpi)
-{
-	struct rpc_xprt *xprt;
-
-	rcu_read_lock();
-	xprt = xprt_iter_get_helper(xpi, xprt_iter_ops(xpi)->xpi_xprt);
-	rcu_read_unlock();
-	return xprt;
-}
-
 /**
  * xprt_iter_get_next - Returns the next rpc_xprt following the cursor
  * @xpi: pointer to rpc_xprt_iter
-- 
2.47.1


