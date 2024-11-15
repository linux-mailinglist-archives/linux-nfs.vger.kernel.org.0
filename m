Return-Path: <linux-nfs+bounces-7999-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 98F549CDB73
	for <lists+linux-nfs@lfdr.de>; Fri, 15 Nov 2024 10:21:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B8FA2832B9
	for <lists+linux-nfs@lfdr.de>; Fri, 15 Nov 2024 09:21:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22BAC18DF93;
	Fri, 15 Nov 2024 09:21:44 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0990E18785D;
	Fri, 15 Nov 2024 09:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731662504; cv=none; b=fQBVw6toINyE0fq3kL1JQ+Ks2CZpyOdMfsGH0uM7inSSkjQiohxIBg1W/rON2IADR6CKgiE8IwYowSgyS16TN17tkJkgPwodumOXsJnLvI9jxgManwCaiyhz+HazBQxHUOR7iPpDXCm2ZPD6oX7Gu9BTXupS4yvtWHQMV3oGnLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731662504; c=relaxed/simple;
	bh=4mL2KcxRoDYVRV/FTNeMeIO34Rqn6F5VHmFisLPKuY4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=r4edjcHRBon5dEtQfEwPR7GVRWCeHHZhCmpN/l4NImKiuFtaDNw2//MN96aow+ils7R+Wzyv6DlbRfhh5puYUpWn0VI4ZaJVe0G9aXs1v9ZPgP4cH0Bs2GUfep4+LSfpZThfPJLFESV217al3mk+6uj/Oz7xVU0t+QqiES/Fl/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4XqWfg3LJYz926T;
	Fri, 15 Nov 2024 17:18:51 +0800 (CST)
Received: from kwepemg200003.china.huawei.com (unknown [7.202.181.30])
	by mail.maildlp.com (Postfix) with ESMTPS id 79087180102;
	Fri, 15 Nov 2024 17:21:32 +0800 (CST)
Received: from huawei.com (10.175.101.6) by kwepemg200003.china.huawei.com
 (7.202.181.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 15 Nov
 2024 17:21:31 +0800
From: Liu Jian <liujian56@huawei.com>
To: <trondmy@kernel.org>, <anna@kernel.org>, <chuck.lever@oracle.com>,
	<jlayton@kernel.org>, <neilb@suse.de>, <okorniev@redhat.com>,
	<Dai.Ngo@oracle.com>, <tom@talpey.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<horms@kernel.org>
CC: <linux-nfs@vger.kernel.org>, <netdev@vger.kernel.org>,
	<liujian56@huawei.com>
Subject: [PATCH] sunrpc: clear XPRT_SOCK_UPD_TIMEOUT when reset transport
Date: Fri, 15 Nov 2024 17:38:04 +0800
Message-ID: <20241115093804.1634328-1-liujian56@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemg200003.china.huawei.com (7.202.181.30)

Since transport->sock has been set to NULL during reset transport,
XPRT_SOCK_UPD_TIMEOUT also needs to be cleared. Otherwise, the
xs_tcp_set_socket_timeouts() may be triggered in xs_tcp_send_request()
to dereference the transport->sock that has been set to NULL.

Fixes: 7196dbb02ea0 ("SUNRPC: Allow changing of the TCP timeout parameters on the fly")
Signed-off-by: Li Lingfeng <lilingfeng3@huawei.com>
Signed-off-by: Liu Jian <liujian56@huawei.com>
---
 net/sunrpc/xprtsock.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
index 906a1b563aee..2a7e33abe151 100644
--- a/net/sunrpc/xprtsock.c
+++ b/net/sunrpc/xprtsock.c
@@ -1198,6 +1198,7 @@ static void xs_sock_reset_state_flags(struct rpc_xprt *xprt)
 	clear_bit(XPRT_SOCK_WAKE_WRITE, &transport->sock_state);
 	clear_bit(XPRT_SOCK_WAKE_DISCONNECT, &transport->sock_state);
 	clear_bit(XPRT_SOCK_NOSPACE, &transport->sock_state);
+	clear_bit(XPRT_SOCK_UPD_TIMEOUT, &transport->sock_state);
 }
 
 static void xs_run_error_worker(struct sock_xprt *transport, unsigned int nr)
-- 
2.34.1


