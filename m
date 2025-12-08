Return-Path: <linux-nfs+bounces-16985-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 91193CAC8EF
	for <lists+linux-nfs@lfdr.de>; Mon, 08 Dec 2025 09:54:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 39DCA30443F9
	for <lists+linux-nfs@lfdr.de>; Mon,  8 Dec 2025 08:54:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EC2A2E2852;
	Mon,  8 Dec 2025 08:54:38 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABC222E370C;
	Mon,  8 Dec 2025 08:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765184077; cv=none; b=pn4Y5CnrAYv+rCSJNWRY1hmrHOV4TkguPeLWvc46iiBthrhv+ynFs4m1HEto0h2KU1wmgg6okziQHF6ZWHlYzRrx8QD9jWd/z4EM3AfaJQglJPE+jUc7PHb4Th2ae03FQhqOaKCt+FDB5le1dfNMHmBuFjcN/qayDSQgWScXjoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765184077; c=relaxed/simple;
	bh=bexDnJJ0fAWOkCihm/M+fbDlG6GRbO6mOEv4GGardhk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZtS+PlEsWaTbYgHPaH/91JsUK7F2YjSiIL3KVa5f1ERWp/ibZVFyY59I3lyoA845hpgoE+qv/foyotfXVexXtflIvQbF9dsFF9DszC/4FnmusslEHbpPiiTWtsSGWKShAUVYR9jm5SP6izZRIen1YXTU6PfKySG//L5v7BbREdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 73cf6df2d41311f0a38c85956e01ac42-20251208
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM
	HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NAME, IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_TRUSTED
	SA_EXISTED, SN_TRUSTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS
	DMARC_NOPASS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:1df2c952-a329-490b-9c90-791e05e9dac3,IP:10,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:0
X-CID-INFO: VERSION:1.3.6,REQID:1df2c952-a329-490b-9c90-791e05e9dac3,IP:10,URL
	:0,TC:0,Content:-5,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:a9d874c,CLOUDID:4f6c7c76675ade7b82e395cb09d3f94f,BulkI
	D:2512081654079VGX5QV1,BulkQuantity:0,Recheck:0,SF:17|19|38|66|78|102|127|
	850|898,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil
	,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:
	0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 73cf6df2d41311f0a38c85956e01ac42-20251208
X-User: zhaochenguang@kylinos.cn
Received: from localhost.localdomain [(223.70.160.239)] by mailgw.kylinos.cn
	(envelope-from <zhaochenguang@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1984275446; Mon, 08 Dec 2025 16:54:06 +0800
From: Chenguang Zhao <zhaochenguang@kylinos.cn>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: Chenguang Zhao <zhaochenguang@kylinos.cn>,
	linux-nfs@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH linux-next v2] SUNRPC: Change list definition method
Date: Mon,  8 Dec 2025 16:53:48 +0800
Message-Id: <20251208085348.467419-1-zhaochenguang@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The LIST_HEAD macro can both define a linked list and initialize
it in one step. To simplify code, we replace the separate operations
of linked list definition and manual initialization with the LIST_HEAD
macro.

Signed-off-by: Chenguang Zhao <zhaochenguang@kylinos.cn>
---
v2:
 - Modify the commit message according to Chuck's suggestion
 
 net/sunrpc/backchannel_rqst.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/sunrpc/backchannel_rqst.c b/net/sunrpc/backchannel_rqst.c
index caa94cf57123..949022c5574c 100644
--- a/net/sunrpc/backchannel_rqst.c
+++ b/net/sunrpc/backchannel_rqst.c
@@ -131,7 +131,7 @@ EXPORT_SYMBOL_GPL(xprt_setup_backchannel);
 int xprt_setup_bc(struct rpc_xprt *xprt, unsigned int min_reqs)
 {
 	struct rpc_rqst *req;
-	struct list_head tmp_list;
+	LIST_HEAD(tmp_list);
 	int i;
 
 	dprintk("RPC:       setup backchannel transport\n");
@@ -147,7 +147,6 @@ int xprt_setup_bc(struct rpc_xprt *xprt, unsigned int min_reqs)
 	 * lock is held on the rpc_xprt struct.  It also makes cleanup
 	 * easier in case of memory allocation errors.
 	 */
-	INIT_LIST_HEAD(&tmp_list);
 	for (i = 0; i < min_reqs; i++) {
 		/* Pre-allocate one backchannel rpc_rqst */
 		req = xprt_alloc_bc_req(xprt);
-- 
2.25.1


