Return-Path: <linux-nfs+bounces-5323-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8589C94F205
	for <lists+linux-nfs@lfdr.de>; Mon, 12 Aug 2024 17:48:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42BE6281AA5
	for <lists+linux-nfs@lfdr.de>; Mon, 12 Aug 2024 15:48:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E28F184559;
	Mon, 12 Aug 2024 15:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KY0YkykE"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEBAF1474C3
	for <linux-nfs@vger.kernel.org>; Mon, 12 Aug 2024 15:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723477691; cv=none; b=T0ZU6fFIz0ub2sMfUC8K57Wupxbi9ND9Ew40NSVB1aqBFUu6ugJA3pI2B94uASeef7x/iw3I3G1O88jqa3LW1+18kVwsZjGyaOlOf1r03nQugXnVhEwR4oQyrsWO0cUBdiHPQBn/wTSS0LZSwZcBNSXsYBjyDOx42zEDs3aMILk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723477691; c=relaxed/simple;
	bh=c2LidYo9gBGy1+JOSYGpE7X2oUTBq/HLdC73inBXOOg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gij6XgAg3vB/1z/7AOR7tfnL+2lZ4/UGITq+KiTL/cEtZtS5MPphkakJL7/CQdlHpOC4qHxLeY8pqG5ER2+M5IITjfTOaIDZE5fK5g5lT8nXuDdwpXeXm7a7eNtHOhxV98mxgWZAPRbrTe4YEINHwOqMylcXXM0egAd1yeQA7Us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KY0YkykE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 090E6C4AF10;
	Mon, 12 Aug 2024 15:48:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723477690;
	bh=c2LidYo9gBGy1+JOSYGpE7X2oUTBq/HLdC73inBXOOg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KY0YkykEcXbvUZyD+NSBkOtNnCtMmqChKaMcz2H3aJiBY9u+2yk/CXBiWfX9eZ88Z
	 NXSGEOCrUuVegf5m/ox34tkByiNcAX53L+Hh6QFDC+G9BtEzQKjp4wBw0c/97WIIOh
	 KK0mkeembxId73KxWJ6EfnBfOegcqXrkXO9T5CcnUangESzibeQPZ0dSb6Su28dujM
	 9SQr9cw6BSZ1zrKoUUx/+xCj7994nVr7f2DETWp1LFAlNFr9zrtvSPcAOdJXuw4pov
	 xy9bWdQRAQiRM2MQ1cSHShqlv/7mNbPHiWYeFU36PH8ON5vNdbjtE7DL99QV0DxyWG
	 ihzKsSFLmADGQ==
From: cel@kernel.org
To: Anna Schumaker <anna@kernel.org>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	<linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH 2/3] rpcrdma: Use XA_FLAGS_ALLOC instead of XA_FLAGS_ALLOC1
Date: Mon, 12 Aug 2024 11:47:58 -0400
Message-ID: <20240812154759.29870-3-cel@kernel.org>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240812154759.29870-1-cel@kernel.org>
References: <20240812154759.29870-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

Nit: The built-in xa_limit_32b range starts at 0, but
XA_FLAGS_ALLOC1 configures the xarray's allocator to start at 1.
Adopt the more conventional XA_FLAGS_ALLOC because there's no
mechanical reason to skip 0.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/ib_client.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sunrpc/xprtrdma/ib_client.c b/net/sunrpc/xprtrdma/ib_client.c
index 4d1e9fa89573..7913d7bad23d 100644
--- a/net/sunrpc/xprtrdma/ib_client.c
+++ b/net/sunrpc/xprtrdma/ib_client.c
@@ -111,7 +111,7 @@ static int rpcrdma_add_one(struct ib_device *device)
 		return -ENOMEM;
 
 	kref_init(&rd->rd_kref);
-	xa_init_flags(&rd->rd_xa, XA_FLAGS_ALLOC1);
+	xa_init_flags(&rd->rd_xa, XA_FLAGS_ALLOC);
 	rd->rd_device = device;
 	init_completion(&rd->rd_done);
 	ib_set_client_data(device, &rpcrdma_ib_client, rd);
-- 
2.45.1


