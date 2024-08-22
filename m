Return-Path: <linux-nfs+bounces-5574-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33BBA95B6C7
	for <lists+linux-nfs@lfdr.de>; Thu, 22 Aug 2024 15:32:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 87600B24A06
	for <lists+linux-nfs@lfdr.de>; Thu, 22 Aug 2024 13:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D839C1CC884;
	Thu, 22 Aug 2024 13:31:40 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB29E1C9449;
	Thu, 22 Aug 2024 13:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724333500; cv=none; b=rhKgypF7EBCD37G99OqXy1GfXSQx78al5KUkoF5eniqaDqtSiUfK6FOmkazyEwKbfYEq7KbjVeVGgIU2xH20Xv39mzV1de+xAaJy1SY0xbcuXyr5DWaWlws5QwEvXhon9RdLa0hY6glvzDlw0X1PqSCe62n8XteenPlrJiZrUlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724333500; c=relaxed/simple;
	bh=d1a/3Sd+36deN85pJ5KQ8bi8G8VN5Djen+1eXVXVhXM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jFoGdzyTXB5kXGOYPEo0byTnQmkP/pMygL/kkyzbgzOIpSjhg2+rX66dzwvAVlepkKUkg3Sw2+Rvo5xYuabGVByQH6k4ZvW+PWPIPopcDKfQhaR4vyhT1IwpxRp6XB+oLyB25EvU6j4uhfotkuglR93PeJr6Bm9NfBSLY6uHoyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4WqPB51XmNz69NR;
	Thu, 22 Aug 2024 21:26:53 +0800 (CST)
Received: from kwepemd500012.china.huawei.com (unknown [7.221.188.25])
	by mail.maildlp.com (Postfix) with ESMTPS id 7E48A140553;
	Thu, 22 Aug 2024 21:31:36 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemd500012.china.huawei.com
 (7.221.188.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Thu, 22 Aug
 2024 21:31:35 +0800
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
Subject: [PATCH net-next 5/8] net: remove redundant judgments to simplify the code
Date: Thu, 22 Aug 2024 21:39:05 +0800
Message-ID: <20240822133908.1042240-6-lizetao1@huawei.com>
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

The res variable has been initialized to 0, and the number of prots
being used will not exceed MAX_INT, so there is no need to judge
whether it is greater than 0 before returning.

Refer to the implementation of sock_inuse_get.

Signed-off-by: Li Zetao <lizetao1@huawei.com>
---
 net/core/sock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/sock.c b/net/core/sock.c
index bbe4c58470c3..52bfc86a2f37 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -3800,7 +3800,7 @@ int sock_prot_inuse_get(struct net *net, struct proto *prot)
 	for_each_possible_cpu(cpu)
 		res += per_cpu_ptr(net->core.prot_inuse, cpu)->val[idx];
 
-	return res >= 0 ? res : 0;
+	return res;
 }
 EXPORT_SYMBOL_GPL(sock_prot_inuse_get);
 
-- 
2.34.1


