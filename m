Return-Path: <linux-nfs+bounces-5573-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0A8695B6C0
	for <lists+linux-nfs@lfdr.de>; Thu, 22 Aug 2024 15:32:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A50DB21B23
	for <lists+linux-nfs@lfdr.de>; Thu, 22 Aug 2024 13:32:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E4F41CC149;
	Thu, 22 Aug 2024 13:31:40 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FF171CBE97;
	Thu, 22 Aug 2024 13:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724333500; cv=none; b=daQaW5MAR3JdW8Izu21Zp3zv/Qur1/SbjnVEt+uXM4qBbGTlJAhAD5Agjx12X7M+3PfIB/Ck1iBmfmu/OhPo9SX1C6PDA5CWFm45erAOBVmk43GcuzR2pO2b5tsFgDyROi97Qu4S6wI3ZwjxXSBvuslvmfFhygvIF4c/giMtsqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724333500; c=relaxed/simple;
	bh=t7BKP1fJyf+XGyVjS1hmdmpmT50V/P9F1DFki6pafgo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H9s4eO7U1UmnRDIz5jShGI+wxWmYLVvT9fU7KKYXEo+RQLp26qLpr6iGU2/6DCHSVi9muZy5jwcUKZkL7WTLihiXg8keNxwvifE4iBYQSU5P2vVfHagk1xHIXPki+WF7NGHd7Iv2cSiGDIORA8mr1HSfAnuPMbYG9V5DfJWFQZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4WqPFB2klbzhY9H;
	Thu, 22 Aug 2024 21:29:34 +0800 (CST)
Received: from kwepemd500012.china.huawei.com (unknown [7.221.188.25])
	by mail.maildlp.com (Postfix) with ESMTPS id 716121800FF;
	Thu, 22 Aug 2024 21:31:35 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemd500012.china.huawei.com
 (7.221.188.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Thu, 22 Aug
 2024 21:31:34 +0800
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
Subject: [PATCH net-next 4/8] libceph: use min() to simplify the code
Date: Thu, 22 Aug 2024 21:39:04 +0800
Message-ID: <20240822133908.1042240-5-lizetao1@huawei.com>
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

When resolving name in ceph_dns_resolve_name(), the end address of name
is determined by the minimum value of delim_p and colon_p. So using min()
here is more in line with the context.

Signed-off-by: Li Zetao <lizetao1@huawei.com>
---
 net/ceph/messenger.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index 3c8b78d9c4d1..d1b5705dc0c6 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -1254,7 +1254,7 @@ static int ceph_dns_resolve_name(const char *name, size_t namelen,
 	colon_p = memchr(name, ':', namelen);
 
 	if (delim_p && colon_p)
-		end = delim_p < colon_p ? delim_p : colon_p;
+		end = min(delim_p, colon_p);
 	else if (!delim_p && colon_p)
 		end = colon_p;
 	else {
-- 
2.34.1


