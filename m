Return-Path: <linux-nfs+bounces-7745-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF7B89C16BB
	for <lists+linux-nfs@lfdr.de>; Fri,  8 Nov 2024 08:04:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0B461C21F42
	for <lists+linux-nfs@lfdr.de>; Fri,  8 Nov 2024 07:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25B8A1CF7CE;
	Fri,  8 Nov 2024 07:04:10 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from cmccmta2.chinamobile.com (cmccmta6.chinamobile.com [111.22.67.139])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66AD4E567;
	Fri,  8 Nov 2024 07:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731049450; cv=none; b=D0X2x5Q3+DSPGIComgFEauVnY8qLEpz7GRlYWvTjLVATz189+NPFQppT3B/LutX2mH65E6WGO+P30Sq4fbp8HJwv5xpeSRGM9qaZrdVRDlaFZy5/H8fFP3uN/w6i47rsEL8SdJjKFcDAfTD3zYj7aKWimeHfH6FxbMU+nmNPhZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731049450; c=relaxed/simple;
	bh=peSOGyeku45gCExt/EdaEM4utZZ4vfU/YR5z9P4uZ48=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cdEvd0XeHqwunfktqKqgj0KO5m0/RYMTcGNfNs9D5UkLFkLjm2uSlF3MaDAeFJZp1ycq4IWx58DibT91ReQNS3pu7bhcOmvEVc3yaQio5NWNR96Wt/RcQL9bVTnZUB8UrQcMjxRtQZcmPJhe2Q0AW3MxGU1WPU/+04vSxuzZAx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app05-12005 (RichMail) with SMTP id 2ee5672db7e0759-ef76b;
	Fri, 08 Nov 2024 15:04:02 +0800 (CST)
X-RM-TRANSID:2ee5672db7e0759-ef76b
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[10.55.1.71])
	by rmsmtp-syy-appsvr09-12009 (RichMail) with SMTP id 2ee9672db7dfeba-8c721;
	Fri, 08 Nov 2024 15:04:02 +0800 (CST)
X-RM-TRANSID:2ee9672db7dfeba-8c721
From: liujing <liujing@cmss.chinamobile.com>
To: trondmy@kernel.org
Cc: anna@kernel.org,
	chuck.lever@oracle.com,
	jlayton@kernel.org,
	neilb@suse.de,
	okorniev@redhat.com,
	Dai.Ngo@oracle.com,
	tom@talpey.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	sagi@grimberg.me,
	linux-nfs@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	liujing <liujing@cmss.chinamobile.com>
Subject: [PATCH] xprtrdma: Fix spelling errors of asynchronously
Date: Fri,  8 Nov 2024 15:03:58 +0800
Message-Id: <20241108070358.10257-1-liujing@cmss.chinamobile.com>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: liujing <liujing@cmss.chinamobile.com>

diff --git a/net/sunrpc/xprtrdma/xprt_rdma.h b/net/sunrpc/xprtrdma/xprt_rdma.h
index 8147d2b41494..99086a9f3900 100644
--- a/net/sunrpc/xprtrdma/xprt_rdma.h
+++ b/net/sunrpc/xprtrdma/xprt_rdma.h
@@ -179,7 +179,7 @@ enum {
 
 /*
  * struct rpcrdma_rep -- this structure encapsulates state required
- * to receive and complete an RPC Reply, asychronously. It needs
+ * to receive and complete an RPC Reply, asynchronously. It needs
  * several pieces of state:
  *
  *   o receive buffer and ib_sge (donated to provider)
-- 
2.27.0




