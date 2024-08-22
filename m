Return-Path: <linux-nfs+bounces-5575-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E6AE95B6CA
	for <lists+linux-nfs@lfdr.de>; Thu, 22 Aug 2024 15:33:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F3439B24FC3
	for <lists+linux-nfs@lfdr.de>; Thu, 22 Aug 2024 13:32:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 948111CBE95;
	Thu, 22 Aug 2024 13:31:41 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D9121CBEB1;
	Thu, 22 Aug 2024 13:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724333501; cv=none; b=gEOF4TzrcibuBEkY8VQvvbN34sAR9XX6+z9LUmQ6k+iqSGs2nwRGQxRcvMpkg9AjNmIMqLCYu4ObCC+SEWLETRBaZ42R/CbnsGL07r4/Z6uMeY47NbKT9rFmPo0/cUc/PJH1xmXLIIB5G0Y6VnYnACmhuhk6IEv+H5JM2OW9m8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724333501; c=relaxed/simple;
	bh=pfQnEsmFpxURztmKAKTGTjicEIdByeH+xqzYCEcJRGA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P14u2MUGQnP/O+vG//P5ULUtMVbU1C448CpGEOvlsqQGCJor9lMcxfLJr7UzetdoOvEB6MkvVBHz8qyxDuqjbIdZYwCVjnBQUZJiRQ6rw9uudtWU4DkYxQjCdKKs2Z7VO2OUkkckEqb2SgqiqEKlmRRIXj1Ko0qVibCDYKe+gjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4WqPH55FWfzyRG0;
	Thu, 22 Aug 2024 21:31:13 +0800 (CST)
Received: from kwepemd500012.china.huawei.com (unknown [7.221.188.25])
	by mail.maildlp.com (Postfix) with ESMTPS id 8DF19180087;
	Thu, 22 Aug 2024 21:31:37 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemd500012.china.huawei.com
 (7.221.188.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Thu, 22 Aug
 2024 21:31:36 +0800
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
Subject: [PATCH net-next 6/8] ipv6: mcast: use min() to simplify the code
Date: Thu, 22 Aug 2024 21:39:06 +0800
Message-ID: <20240822133908.1042240-7-lizetao1@huawei.com>
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

When coping sockaddr in ip6_mc_msfget(), the time of copies
depends on the minimum value between sl_count and gf_numsrc.
Using min() here is very semantic.

Signed-off-by: Li Zetao <lizetao1@huawei.com>
---
 net/ipv6/mcast.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/ipv6/mcast.c b/net/ipv6/mcast.c
index 7ba01d8cfbae..b244dbf61d5f 100644
--- a/net/ipv6/mcast.c
+++ b/net/ipv6/mcast.c
@@ -586,7 +586,8 @@ int ip6_mc_msfget(struct sock *sk, struct group_filter *gsf,
 	const struct in6_addr *group;
 	struct ipv6_mc_socklist *pmc;
 	struct ip6_sf_socklist *psl;
-	int i, count, copycount;
+	unsigned int count;
+	int i, copycount;
 
 	group = &((struct sockaddr_in6 *)&gsf->gf_group)->sin6_addr;
 
@@ -610,7 +611,7 @@ int ip6_mc_msfget(struct sock *sk, struct group_filter *gsf,
 	psl = sock_dereference(pmc->sflist, sk);
 	count = psl ? psl->sl_count : 0;
 
-	copycount = count < gsf->gf_numsrc ? count : gsf->gf_numsrc;
+	copycount = min(count, gsf->gf_numsrc);
 	gsf->gf_numsrc = count;
 	for (i = 0; i < copycount; i++) {
 		struct sockaddr_in6 *psin6;
-- 
2.34.1


