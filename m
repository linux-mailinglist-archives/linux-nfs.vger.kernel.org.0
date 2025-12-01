Return-Path: <linux-nfs+bounces-16804-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D151FC959F8
	for <lists+linux-nfs@lfdr.de>; Mon, 01 Dec 2025 03:54:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 906143A18DA
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Dec 2025 02:54:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1816619E97F;
	Mon,  1 Dec 2025 02:54:38 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AE5079F2;
	Mon,  1 Dec 2025 02:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764557678; cv=none; b=N4H2jGRIyo8P2NwldDQlgItJtrL0dtA63DEOQbqKZcUF2UFJWY0LfEydFRMe8JSTsAPSOXXdSbBGHjjz0JtcYCtLY9etj0UUskzMCKpchvxPZG9YTu4xiz7cjZ0XT0QPX+BR96ixTPXrdJf/Gg814U55vxGEB34nsOUUO5V8BG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764557678; c=relaxed/simple;
	bh=zPeVun2lXFp3lUxpiMBe+ba5hiR+qBkiq2MyrQzJhII=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GVRqv2k5Wc+KQTtfZ3tq6Ww7NVi8Lpq+2jy79SQY6nmiNRJCSVc5tVxE8doFfkbCGWAvNxrpTRXPPO1xYvqP7eQb+tnHJZQIjcgJADb9PCpo6l/TbCLmk6PRDh5ijlItuKJan34OSReusPE48dJodJKnj/tq/d6v1jpRWzUUKc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 086434cece6111f0a38c85956e01ac42-20251201
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE
	HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NAME
	IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_TRUSTED, SA_EXISTED
	SN_TRUSTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS
	CIE_BAD, CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS, GTI_RG_INFO
	GTI_C_BU, AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:ddb1dc57-30c1-436e-9238-ced6a748a4aa,IP:10,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:0
X-CID-INFO: VERSION:1.3.6,REQID:ddb1dc57-30c1-436e-9238-ced6a748a4aa,IP:10,URL
	:0,TC:0,Content:-5,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:a9d874c,CLOUDID:bebccebbb77851cf1f91f6494c5bc2fb,BulkI
	D:2512011054219RRSEZPR,BulkQuantity:0,Recheck:0,SF:17|19|38|66|78|102|127|
	850|898,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil
	,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:
	0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 086434cece6111f0a38c85956e01ac42-20251201
X-User: zhaochenguang@kylinos.cn
Received: from localhost.localdomain [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <zhaochenguang@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 241223005; Mon, 01 Dec 2025 10:54:19 +0800
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
Subject: [PATCH linux-next] SUNRPC: Optimize list definition method
Date: Mon,  1 Dec 2025 10:54:04 +0800
Message-Id: <20251201025404.113550-1-zhaochenguang@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Integrate list definition and initialization into LIST_HEAD macro

Signed-off-by: Chenguang Zhao <zhaochenguang@kylinos.cn>
---
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


