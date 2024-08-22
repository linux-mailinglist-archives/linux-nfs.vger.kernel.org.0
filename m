Return-Path: <linux-nfs+bounces-5576-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8294B95B6CF
	for <lists+linux-nfs@lfdr.de>; Thu, 22 Aug 2024 15:33:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5BFB7B252BB
	for <lists+linux-nfs@lfdr.de>; Thu, 22 Aug 2024 13:33:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C26C1CB121;
	Thu, 22 Aug 2024 13:31:43 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66DDE1CC89F;
	Thu, 22 Aug 2024 13:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724333502; cv=none; b=ZA+sEnrcO2BL0lcWkk7G2y2elMaKhU99ZTbMYdqJUxytvMK4IuSTvsX5JXMh0GV1EQAgAWo2NMSHPB3Hj/oNWkY4QWOTbbPNxSCxBbU78UHgMhak7Kt2QwACa83VG8KUWVIAMiheBJJ/FGCQxEwnxZOYV3nHo2z484zKp75dMFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724333502; c=relaxed/simple;
	bh=t4FIOjBlHFfm6xHxfdsoMnhaAA6dSAZlYtY+WOfRbkA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V0OnRaqE9JlxHcZblubuFSLD9AvprZuuEuhnEjGXNtyOEvhIyY6MMXKg/eBLYiZi11tPvD6IiJ7dWVOKejBUTwAT2DfHTyRLizBCjfaRc2rKZ3923nvlciMj2CnZtjGec4GiS7hMB7TKyFU/r5gIYh4yYU9FTKhHlomtD+9/ahU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4WqPFM4SpHz1xvn1;
	Thu, 22 Aug 2024 21:29:43 +0800 (CST)
Received: from kwepemd500012.china.huawei.com (unknown [7.221.188.25])
	by mail.maildlp.com (Postfix) with ESMTPS id 9A91C18001B;
	Thu, 22 Aug 2024 21:31:38 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemd500012.china.huawei.com
 (7.221.188.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Thu, 22 Aug
 2024 21:31:37 +0800
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
Subject: [PATCH net-next 7/8] tipc: use min() to simplify the code
Date: Thu, 22 Aug 2024 21:39:07 +0800
Message-ID: <20240822133908.1042240-8-lizetao1@huawei.com>
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

When calculating size of own domain based on number of peers, the result
should be less than MAX_MON_DOMAIN, so using min() here is very semantic.

Signed-off-by: Li Zetao <lizetao1@huawei.com>
---
 net/tipc/monitor.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/tipc/monitor.c b/net/tipc/monitor.c
index 77a3d016cade..e2f19627e43d 100644
--- a/net/tipc/monitor.c
+++ b/net/tipc/monitor.c
@@ -149,7 +149,7 @@ static int dom_size(int peers)
 
 	while ((i * i) < peers)
 		i++;
-	return i < MAX_MON_DOMAIN ? i : MAX_MON_DOMAIN;
+	return min(i, MAX_MON_DOMAIN);
 }
 
 static void map_set(u64 *up_map, int i, unsigned int v)
-- 
2.34.1


