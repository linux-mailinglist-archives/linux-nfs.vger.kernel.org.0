Return-Path: <linux-nfs+bounces-5572-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 632AB95B6BE
	for <lists+linux-nfs@lfdr.de>; Thu, 22 Aug 2024 15:32:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB331B20B8A
	for <lists+linux-nfs@lfdr.de>; Thu, 22 Aug 2024 13:32:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26C281CC142;
	Thu, 22 Aug 2024 13:31:40 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3071F1C944B;
	Thu, 22 Aug 2024 13:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724333500; cv=none; b=WWldeq+s5f65M1wlO+6zKJ7hRQ7U2nv3HyBNqKCr5mo42KQGALLuvTpcvOgNS/NI2VqQAI3KfEf6pbl+UpD1nVVmDtHxBjloDRmvFj6hxIkuBf9XHL7a2ST6ZW3G5imtUxWxsuRBSZhr9o7Nl9YaRUo7axh/x7icP3W4r6mdTjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724333500; c=relaxed/simple;
	bh=NFgLzZeCnwGzYZjN2AnH5yOVdhYopM0nyGVaWiOVNe4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Cf+1NIVwZxZ6Y2iKBYRlnkjreNqUXDTrWS2++6tBC9OFESj94/kwagJCELfmrWR089eQAgJuHrgH/kEhwUDeIW7snHqD+hVednEDXoIoC/YqpmfjgWSgHlXNe+2EZc0n+/+ZxVSUknewBQFTqgKTJCpT2L8nFA/OFPgYfi8KU98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4WqPHQ4kstz2Cn9w;
	Thu, 22 Aug 2024 21:31:30 +0800 (CST)
Received: from kwepemd500012.china.huawei.com (unknown [7.221.188.25])
	by mail.maildlp.com (Postfix) with ESMTPS id 601B41400CA;
	Thu, 22 Aug 2024 21:31:34 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemd500012.china.huawei.com
 (7.221.188.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Thu, 22 Aug
 2024 21:31:33 +0800
From: Li Zetao <lizetao1@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <marcel@holtmann.org>, <johan.hedberg@gmail.com>,
	<luiz.dentz@gmail.com>, <idryomov@gmail.com>, <xiubli@redhat.com>,
	<dsahern@kernel.org>, <trondmy@kernel.org>, <anna@kernel.org>,
	<chuck.lever@oracle.com>, <jlayton@kernel.org>, <neilb@suse.de>,
	<okorniev@redhat.com>, <Dai.Ngo@oracle.com>, <tom@talpey.com>,
	<jmaloy@redhat.com>, <ying.xue@windriver.com>, <lizetao1@huawei.com>,
	<linux@treblig.org>, <jacob.e.keller@intel.com>, <willemb@google.com>,
	<kuniyu@amazon.com>, <wuyun.abel@bytedance.com>, <quic_abchauha@quicinc.com>,
	<gouhao@uniontech.com>
CC: <netdev@vger.kernel.org>, <linux-bluetooth@vger.kernel.org>,
	<ceph-devel@vger.kernel.org>, <linux-nfs@vger.kernel.org>,
	<tipc-discussion@lists.sourceforge.net>
Subject: [PATCH net-next 3/8] net: caif: use max() to simplify the code
Date: Thu, 22 Aug 2024 21:39:03 +0800
Message-ID: <20240822133908.1042240-4-lizetao1@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240822133908.1042240-1-lizetao1@huawei.com>
References: <20240822133908.1042240-1-lizetao1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemd500012.china.huawei.com (7.221.188.25)

When processing the tail append of sk buffer, the final length needs
to be determined based on expectlen and addlen. Using max() here can
increase the readability of the code.

Signed-off-by: Li Zetao <lizetao1@huawei.com>
---
 net/caif/cfpkt_skbuff.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/net/caif/cfpkt_skbuff.c b/net/caif/cfpkt_skbuff.c
index 2ae8cfa3df88..96236d21b18e 100644
--- a/net/caif/cfpkt_skbuff.c
+++ b/net/caif/cfpkt_skbuff.c
@@ -298,10 +298,8 @@ struct cfpkt *cfpkt_append(struct cfpkt *dstpkt,
 	if (unlikely(is_erronous(dstpkt) || is_erronous(addpkt))) {
 		return dstpkt;
 	}
-	if (expectlen > addlen)
-		neededtailspace = expectlen;
-	else
-		neededtailspace = addlen;
+
+	neededtailspace = max(expectlen, addlen);
 
 	if (dst->tail + neededtailspace > dst->end) {
 		/* Create a dumplicate of 'dst' with more tail space */
-- 
2.34.1


