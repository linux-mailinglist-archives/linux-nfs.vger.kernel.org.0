Return-Path: <linux-nfs+bounces-5577-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5979D95B6D2
	for <lists+linux-nfs@lfdr.de>; Thu, 22 Aug 2024 15:33:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12FE428630D
	for <lists+linux-nfs@lfdr.de>; Thu, 22 Aug 2024 13:33:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 779DB1CCB37;
	Thu, 22 Aug 2024 13:31:43 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D11721CC8B8;
	Thu, 22 Aug 2024 13:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724333503; cv=none; b=PxKHHJtOVmdAcCD4TOQdQ2R2j9j3BZQFMe9A9YFSat/AsnBv2h6LiRwIC3UUfXGxOWpQqLnztR7guOQQxIyM4Dk5G1+RULeZ8M4xOIZ7iC98Kw1xWpdg4bgGu0EatuzI6Oc+V3f/KDpTaWnEkMwj3SP8Snat+UVrsx72Dz1hh+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724333503; c=relaxed/simple;
	bh=MsepUvgicJgEAXMFRoMiH1n5u/4ICpNE6DF8goEDdWE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n02eHzQhyqGz+Nca+2DCv7By9lJwD0cyz6Bkn/JeAfsqdr6jee2GNBSInEYoe0fDyCezhlLWF73mBts6ilo8yNEZHh7Q4bZ6aZhhCeiadfqiu3XgqUQLk64jyB+fHm1u3JCR4jl5VrEK5y5DCuz7mQanLJNLUTPhDul3xCDArTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4WqPGp71xmzyQPx;
	Thu, 22 Aug 2024 21:30:58 +0800 (CST)
Received: from kwepemd500012.china.huawei.com (unknown [7.221.188.25])
	by mail.maildlp.com (Postfix) with ESMTPS id A6F98180087;
	Thu, 22 Aug 2024 21:31:39 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemd500012.china.huawei.com
 (7.221.188.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Thu, 22 Aug
 2024 21:31:38 +0800
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
Subject: [PATCH net-next 8/8] SUNRPC: use min() to simplify the code
Date: Thu, 22 Aug 2024 21:39:08 +0800
Message-ID: <20240822133908.1042240-9-lizetao1@huawei.com>
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

When reading pages in xdr_read_pages, the number of XDR encoded bytes
should be less than the len of aligned pages, so using min() here is
very semantic.

Signed-off-by: Li Zetao <lizetao1@huawei.com>
---
 net/sunrpc/xdr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sunrpc/xdr.c b/net/sunrpc/xdr.c
index 62e07c330a66..6746e920dbbb 100644
--- a/net/sunrpc/xdr.c
+++ b/net/sunrpc/xdr.c
@@ -1602,7 +1602,7 @@ unsigned int xdr_read_pages(struct xdr_stream *xdr, unsigned int len)
 	end = xdr_stream_remaining(xdr) - pglen;
 
 	xdr_set_tail_base(xdr, base, end);
-	return len <= pglen ? len : pglen;
+	return min(len, pglen);
 }
 EXPORT_SYMBOL_GPL(xdr_read_pages);
 
-- 
2.34.1


