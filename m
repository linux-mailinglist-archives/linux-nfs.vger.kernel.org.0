Return-Path: <linux-nfs+bounces-16897-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0262ACA215F
	for <lists+linux-nfs@lfdr.de>; Thu, 04 Dec 2025 02:12:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C16AA301DBA9
	for <lists+linux-nfs@lfdr.de>; Thu,  4 Dec 2025 01:12:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 471781A317D;
	Thu,  4 Dec 2025 01:12:49 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86BDE182D0;
	Thu,  4 Dec 2025 01:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764810769; cv=none; b=OHeMTU2YEH2pc1A2/tN1goI3Qd+jr7FshnlMm9eLfYLhyqPzoUAV8YM10iLxlkisTiIoxu5KYH8d5BEHcCftg2CG87tVsSSQ5TWdkwnB57gtxMgVRIFsr6zZ4l4G3tJtYKwPYJEVFHMghNrYTRSL+/wsFZTyOx3rAZisQAjuQ4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764810769; c=relaxed/simple;
	bh=zPeVun2lXFp3lUxpiMBe+ba5hiR+qBkiq2MyrQzJhII=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ESpqzvt8hMqF4LPWtl66MqsmN00LJMY89BIWOKB8oBPuSCSNlbK2rrXQuCtzhuxuHz9Cl4xp1DrCFyfYLU2NwEQYHagi/hy4494w18HHeHGfs1hb5YlsSZz3mIxTKlkS+OJt5FlsqPL5w9r9R8SmpXaOcJAglVM2GaAW5m1L6x0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 5256496ad0ae11f0a38c85956e01ac42-20251204
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE
	HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NAME
	IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_TRUSTED, SA_EXISTED
	SN_TRUSTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS
	CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS, GTI_RG_INFO, GTI_C_BU
	AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:3a5e45e1-666d-4a4d-95e9-0818e75db6ec,IP:10,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:0
X-CID-INFO: VERSION:1.3.6,REQID:3a5e45e1-666d-4a4d-95e9-0818e75db6ec,IP:10,URL
	:0,TC:0,Content:-5,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:a9d874c,CLOUDID:1da5b09dffecb786ce1fede61200d24b,BulkI
	D:2512011054219RRSEZPR,BulkQuantity:1,Recheck:0,SF:17|19|38|66|78|102|127|
	850|898,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:41,
	QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
	,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 5256496ad0ae11f0a38c85956e01ac42-20251204
X-User: zhaochenguang@kylinos.cn
Received: from localhost.localdomain [(223.70.160.239)] by mailgw.kylinos.cn
	(envelope-from <zhaochenguang@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 831413987; Thu, 04 Dec 2025 09:12:37 +0800
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
Subject: [PATCH RESEND linux-next] SUNRPC: Optimize list definition method
Date: Thu,  4 Dec 2025 09:12:32 +0800
Message-Id: <20251204011232.41487-1-zhaochenguang@kylinos.cn>
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


