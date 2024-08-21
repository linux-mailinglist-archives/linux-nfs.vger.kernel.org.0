Return-Path: <linux-nfs+bounces-5496-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 34BA1959F3A
	for <lists+linux-nfs@lfdr.de>; Wed, 21 Aug 2024 16:03:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E36C12852F8
	for <lists+linux-nfs@lfdr.de>; Wed, 21 Aug 2024 14:03:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 010E2189908;
	Wed, 21 Aug 2024 14:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="nhv8HRQq"
X-Original-To: linux-nfs@vger.kernel.org
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4748B1AF4DB
	for <linux-nfs@vger.kernel.org>; Wed, 21 Aug 2024 14:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724249013; cv=none; b=aEtFnZcYPd3u9n6o8HvayNEkm8Gg+F3JoSfGVxp6/vWW211MkJ4WcRID2X6a3qXbNZz54exsuUu0309JDDNfkHIisN43PCpfcfZQt3KcfcBDZPJXvEa8P+MK4cL77xirLM2EBa8IXqyk1LX8JbKBTTME393EIs8EPWzBhvmFI+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724249013; c=relaxed/simple;
	bh=8rOwKhl9KMquVN225PnkjFYORAGWdRIoYaZja99D+v8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XlzxXpQbAN+7YxnZsMFlIV5zn6tmiv5Bfcqt3DlMEcjnWPvz3rce4ZB7SjbuDh0mdearNMfiLnafyqtOj5SuDc5eJofBtiFVOfj+2UuSRX6HiF/pF/da2Gxo92im3X9wTSOog00cZAYXyI9V3NuSx+CdukQ4fhB8tHcfU1b1pok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=nhv8HRQq; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724249009;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=qoDDC1frOHVwUBURkP39F8ENL0j3Ofq9kCUsajO4oYc=;
	b=nhv8HRQqeL7OrlskqlVHt7P3njst5snUS7GU7jxqAjVyrWTt3Gq1Kq1BoEgYZM8bj+kCVx
	TBxfgfoHZweGmXX+4daY5jY0HsElrzlMOZ8MiZiKkfugJrS35a8wCeE+KjHkMsx9aHmwQn
	RgXshpjKpBLCTg4pLimKXA93XXzuoDk=
From: Guoqing Jiang <guoqing.jiang@linux.dev>
To: chuck.lever@oracle.com,
	jlayton@kernel.org
Cc: neilb@suse.de,
	okorniev@redhat.com,
	Dai.Ngo@oracle.com,
	tom@talpey.com,
	linux-nfs@vger.kernel.org
Subject: [PATCH] nfsd: call cache_put if xdr_reserve_space returns NULL
Date: Wed, 21 Aug 2024 22:03:18 +0800
Message-Id: <20240821140318.7757-1-guoqing.jiang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

If no enough buffer space available, but idmap_lookup have triggered
lookup_fn which calls cache_get and returns successfully. Then we
missed to call cache_put here which pairs with cache_get.

Signed-off-by: Guoqing Jiang <guoqing.jiang@linux.dev>
---
 fs/nfsd/nfs4idmap.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/nfs4idmap.c b/fs/nfsd/nfs4idmap.c
index 7a806ac13e31..7abddf7d8f6d 100644
--- a/fs/nfsd/nfs4idmap.c
+++ b/fs/nfsd/nfs4idmap.c
@@ -594,8 +594,10 @@ static __be32 idmap_id_to_name(struct xdr_stream *xdr,
 	ret = strlen(item->name);
 	WARN_ON_ONCE(ret > IDMAP_NAMESZ);
 	p = xdr_reserve_space(xdr, ret + 4);
-	if (!p)
+	if (!p) {
+		cache_put(&item->h, nn->idtoname_cache);
 		return nfserr_resource;
+	}
 	p = xdr_encode_opaque(p, item->name, ret);
 	cache_put(&item->h, nn->idtoname_cache);
 	return 0;
-- 
2.35.3


