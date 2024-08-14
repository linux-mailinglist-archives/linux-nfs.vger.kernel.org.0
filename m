Return-Path: <linux-nfs+bounces-5349-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C1A99517D2
	for <lists+linux-nfs@lfdr.de>; Wed, 14 Aug 2024 11:39:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA7201F225EC
	for <lists+linux-nfs@lfdr.de>; Wed, 14 Aug 2024 09:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61838165EE6;
	Wed, 14 Aug 2024 09:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="v4Y2e37U"
X-Original-To: linux-nfs@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3964C15FD13
	for <linux-nfs@vger.kernel.org>; Wed, 14 Aug 2024 09:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723628367; cv=none; b=Vsc2nDCn57Im41rsiqpL1Z4sf08YpnnbGh0xN5T4zv5FkGUK7I/LfNGRFpq3PsC5Ncn6zkQ+r5x4UX/CHqGFOItT5oP8zDXAMpsxadYY1OFULn9KB8hOLN+Sgh+GrSSf1TQj++8BBIY9Y03Zk/FGTQMu2dVvaPU9MCgeM6ceTAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723628367; c=relaxed/simple;
	bh=IeVoT4yufyi68TEdosJy9nI6F36XVIhz0YvYLr4IBtg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=P/rsTkKRXy7gEzNj8eLkHOovLfh4ypnGTwK/E3HxlZ9LzY6Zp1IJ2QokApeo1lPLl9sZekgMt95RZ4pYoSyPGKrQquwi3Vj+sLnhMQzxhZoomRqbyyYs5wnfziHT40g/5iMqYL/zUgA0NRdi2G6a8Di0jE9owVnGqyEPMVAxgTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=v4Y2e37U; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1723628362;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=hoKMraIxGqJRJoyIgsLh26ViCmZSqFx8f5iMTWHsaVA=;
	b=v4Y2e37UaQtwY6/Q1oaRXC+wnuUESSf5FkHv3sDpYrYhh1/pKZqidItOKmJxgEIhp5EmXn
	QJQ7lR1nlN6SsjSRX1NvfOo5jAF3cYwOGRQX0EWA/EKBCRRHD4CT06EAba8BT3ziVO2mG7
	i0znJzkmjg9Okh/Gc3tvcNm0Cbe/+/8=
From: kunwu.chan@linux.dev
To: trondmy@kernel.org,
	anna@kernel.org,
	chuck.lever@oracle.com,
	jlayton@kernel.org,
	neilb@suse.de,
	kolga@netapp.com,
	Dai.Ngo@oracle.com,
	tom@talpey.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: linux-nfs@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kunwu Chan <chentao@kylinos.cn>
Subject: [PATCH] SUNRPC: Fix -Wformat-truncation warning
Date: Wed, 14 Aug 2024 17:38:53 +0800
Message-Id: <20240814093853.48657-1-kunwu.chan@linux.dev>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Kunwu Chan <chentao@kylinos.cn>

Increase size of the servername array to avoid truncated output warning.

net/sunrpc/clnt.c:582:75: error：‘%s’ directive output may be truncated
writing up to 107 bytes into a region of size 48
[-Werror=format-truncation=]
  582 |                   snprintf(servername, sizeof(servername), "%s",
      |                                                             ^~

net/sunrpc/clnt.c:582:33: note:‘snprintf’ output
between 1 and 108 bytes into a destination of size 48
  582 |                     snprintf(servername, sizeof(servername), "%s",
      |                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  583 |                                          sun->sun_path);

Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
---
 net/sunrpc/clnt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
index 09f29a95f2bc..874085f3ed50 100644
--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -546,7 +546,7 @@ struct rpc_clnt *rpc_create(struct rpc_create_args *args)
 		.connect_timeout = args->connect_timeout,
 		.reconnect_timeout = args->reconnect_timeout,
 	};
-	char servername[48];
+	char servername[108];
 	struct rpc_clnt *clnt;
 	int i;
 
-- 
2.40.1


