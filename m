Return-Path: <linux-nfs+bounces-14431-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 72516B57CEE
	for <lists+linux-nfs@lfdr.de>; Mon, 15 Sep 2025 15:27:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 127421AA094C
	for <lists+linux-nfs@lfdr.de>; Mon, 15 Sep 2025 13:28:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2F15315D23;
	Mon, 15 Sep 2025 13:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="nI8+/yiF"
X-Original-To: linux-nfs@vger.kernel.org
Received: from out162-62-57-64.mail.qq.com (out162-62-57-64.mail.qq.com [162.62.57.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9557313283
	for <linux-nfs@vger.kernel.org>; Mon, 15 Sep 2025 13:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757942832; cv=none; b=ufeZsaAvAAyUbOz/fBLG2SySMfWjrfB/udk4jLBkZnbYlEWxOzvWc2yn3BAeg5HKuIcjguOg+StmkTYa4aVYNeeY/ovtIN0C8Ls0bA1e4PaF0pQKziDyasXLkZRUIELvv/GErylxKofaQyDUuz7hVANAjRDjaFwIdd8WTcKchg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757942832; c=relaxed/simple;
	bh=BwK6smIWY8UxaoR0F/gPy8p2dUTxAcFk9K5CxGQyCDc=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=RwoxEOWdpngPNBYzBKI96FoXWqjcbH5Whr+BmdSLd4edOR4vRh76+EVm3Lky+a+yIKLRft45QA7BxDoIKyFnaqJynoo47JqAItrHcJpQTx6Rd6TEcwJ1gkD7LD2L7kAYvAj4LqeKh7Nf9XVTSwmzbKk74zIVOQOZJSrwQfcSeWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=nI8+/yiF; arc=none smtp.client-ip=162.62.57.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1757942517; bh=uckOZk/nJoZWWehA5rrqTsGGnE1WONqJczjs0xYA7fE=;
	h=From:To:Cc:Subject:Date;
	b=nI8+/yiFF3O5SWKB4sSbOsZr5C/tHzmLaELzFOPcRiUYYIHw39EUCrXGDtS/7fXnE
	 dr4J2hrFhuvo0ELrhH0zSzBIS5Wb7pVaiPOmzN3k+pPoHbX49I2pzXJKfsT1kU3/0a
	 z2FQT5k5pJEEeE9Qzz1E4/JHloPq0KTDllBTKN2o=
Received: from localhost.localdomain ([115.60.178.104])
	by newxmesmtplogicsvrszb42-0.qq.com (NewEsmtp) with SMTP
	id 5779AA04; Mon, 15 Sep 2025 21:21:55 +0800
X-QQ-mid: xmsmtpt1757942515twp57q9sy
Message-ID: <tencent_AD6578717AD07FA01AED37FCC2D8C966F509@qq.com>
X-QQ-XMAILINFO: NDgMZBR9sMmaUT6LyLw8W3HEM5cA52MqBJCkrUFDnyVRuhu9Jit3wCFflwJ+qL
	 F7C6V5wE6k9uOmgZqHsbg5MOoJObyDMbz1hYHHxRR8zLN3Gg5P0UQyRiWBeY8EUGxQQ5hdidzhtx
	 f8ud1eUfclpNC4qSua83FLulQJgw+ZyYrOiCtGjDoP51JPgLhIKNvr+kqRESSLwBSfXwyHAovLsx
	 8/sla+cjn5gO13waWJoXjUooJ+b70bYvJ7X2p9blVH9xLEVuSyLZsAxwHmcNm77Q0AiEP9CaEcVQ
	 WrDDJQh8IFm/fg99++rWnAl8J5VhY4WYZiNtcR5a/3FMkNj9KMFcAuHDIv6whAnHpmELFrcC3BS5
	 rEm0shYjfMTS3ingd4PRBBDUxGZN419SKqDWf5aFsYUKh/PmuXCO3Bf7Qa+TFqoZHXU5+5YGwCMN
	 9vyVvf5D2BViCv00714TGai2Y3ESmtjqqYC2GMFLFSQYpjOBJIyJX63WvtqxtcRjeukzAQG3WEin
	 Fgeq+UrkqPzq0yipZu3NByU6764f8LpJAzZaY3oqsDPR1sinZKVBanIfr4qTj3E9P7NfUXpwb0TR
	 nPQcZHs0CRWYRnPfzTywQsdairOP75ku7gSWfOxNgAXv40ZFdr2dsxL+K2KtMEdNTFa+Pt2rnjsF
	 acpRV05155T3QpJ+T3QlByO9YnkUlcWS6ySBTnGwRMx5LerPB1+JulRwO6A5AHJMxPR/y+e6NL1N
	 7vH/GP+JnzwMqUnVqU0Rt0/40uYFeJAvxmGPNI/Mosk7cvy7KheBQ89EM6L7lT60c0CJsUJbuEK8
	 oR1MO5/WHGrwitfzg2UVUvtDSWtsxkL0uc8BBNvp73uxCR+FFkO9fcVi3O+zK900SmVc2HER0L8a
	 OG9dXMxg6NjkJAmvNYMn4DofBEYAmpuWnRfqiHTrz1Kzoq6miOsi+jLVhnw2iLy9J5zUXQouZT4W
	 lHzk+TnsE=
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
From: 597607025@qq.com
To: linux-nfs@vger.kernel.org
Cc: zhangyaqi@kylinos.cn,
	steved@redhat.com
Subject: [PATCH] nfsdcld:fix potential PATH_MAX overflows in recovery dir handling
Date: Thu, 12 Jun 2025 01:07:41 +0800
X-OQ-MSGID: <20250611170741.8562-1-597607025@qq.com>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: zhangyaqi <zhangyaqi@kylinos.cn>

Signed-off-by: zhangyaqi <zhangyaqi@kylinos.cn>
---
 utils/nfsdcld/legacy.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/utils/nfsdcld/legacy.c b/utils/nfsdcld/legacy.c
index b89374c9..c6f6925c 100644
--- a/utils/nfsdcld/legacy.c
+++ b/utils/nfsdcld/legacy.c
@@ -65,7 +65,7 @@ legacy_load_clients_from_recdir(int *num_records)
 		return;
 	}
 	/* the output from the proc file isn't null-terminated */
-	recdirname[PATH_MAX] = '\0';
+	recdirname[(n < PATH_MAX) ? n : PATH_MAX] = '\0';
 	nl = strchr(recdirname, '\n');
 	if (!nl)
 		return;
@@ -133,7 +133,7 @@ legacy_clear_recdir(void)
 		return;
 	}
 	/* the output from the proc file isn't null-terminated */
-	recdirname[PATH_MAX] = '\0';
+	recdirname[(n < PATH_MAX) ? n : PATH_MAX] = '\0';
 	nl = strchr(recdirname, '\n');
 	if (!nl)
 		return;
-- 
2.27.0


