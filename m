Return-Path: <linux-nfs+bounces-5570-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3751E95B6B6
	for <lists+linux-nfs@lfdr.de>; Thu, 22 Aug 2024 15:31:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9596DB24D08
	for <lists+linux-nfs@lfdr.de>; Thu, 22 Aug 2024 13:31:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5F571CB31F;
	Thu, 22 Aug 2024 13:31:37 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 335091C9449;
	Thu, 22 Aug 2024 13:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724333497; cv=none; b=AacUDuRgN3Lej+XCW4+BRdsazbOUS8CX6f72hIyj/wXfDb51UO+guhn3gX+cWvarPzO3ARxBRd6icACqiaHb5T2wc3IrCNFiXDMAPUvvZpWV0r0hn5jyuP9D3BICO1CZK7sn6Acj3+4pDeTAtOw6oGkrwyeD9hMZ/D5ta6Qv3sY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724333497; c=relaxed/simple;
	bh=dOiaHvnaJZLdD5pe9zasHOzpCN3wlvpWVlFHVL2FAoI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YEro0aHcmt2MVs+JKywoM7jHMP4o6th1Ap3B9Q2vTUm+IeEKkz1M/ZcTg6KGtydF2h6x7/mdu+zxgcF1fcvgpi+/T1iS+lHhmnV2DUnb5tzbFEfvs/HH3u3wB7ljrOWcF7aHxB3Henc9is7YJU5cn09KO10mSMNi2DRltn0Y72E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4WqPB06mn8z69Mv;
	Thu, 22 Aug 2024 21:26:48 +0800 (CST)
Received: from kwepemd500012.china.huawei.com (unknown [7.221.188.25])
	by mail.maildlp.com (Postfix) with ESMTPS id 3F3B3140109;
	Thu, 22 Aug 2024 21:31:32 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemd500012.china.huawei.com
 (7.221.188.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Thu, 22 Aug
 2024 21:31:31 +0800
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
Subject: [PATCH net-next 1/8] atm: use min() to simplify the code
Date: Thu, 22 Aug 2024 21:39:01 +0800
Message-ID: <20240822133908.1042240-2-lizetao1@huawei.com>
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

When copying data to user, it needs to determine the copy length.
It is easier to understand using min() here.

Signed-off-by: Li Zetao <lizetao1@huawei.com>
---
 net/atm/addr.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/atm/addr.c b/net/atm/addr.c
index 0530b63f509a..6c4c942b2cb9 100644
--- a/net/atm/addr.c
+++ b/net/atm/addr.c
@@ -136,7 +136,7 @@ int atm_get_addr(struct atm_dev *dev, struct sockaddr_atmsvc __user * buf,
 	unsigned long flags;
 	struct atm_dev_addr *this;
 	struct list_head *head;
-	int total = 0, error;
+	size_t total = 0, error;
 	struct sockaddr_atmsvc *tmp_buf, *tmp_bufp;
 
 	spin_lock_irqsave(&dev->lock, flags);
@@ -155,7 +155,7 @@ int atm_get_addr(struct atm_dev *dev, struct sockaddr_atmsvc __user * buf,
 	    memcpy(tmp_bufp++, &this->addr, sizeof(struct sockaddr_atmsvc));
 	spin_unlock_irqrestore(&dev->lock, flags);
 	error = total > size ? -E2BIG : total;
-	if (copy_to_user(buf, tmp_buf, total < size ? total : size))
+	if (copy_to_user(buf, tmp_buf, min(total, size)))
 		error = -EFAULT;
 	kfree(tmp_buf);
 	return error;
-- 
2.34.1


