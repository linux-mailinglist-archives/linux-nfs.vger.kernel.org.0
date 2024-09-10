Return-Path: <linux-nfs+bounces-6363-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 079EB9734F4
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Sep 2024 12:44:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C01B6287FF6
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Sep 2024 10:44:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EAA2190499;
	Tue, 10 Sep 2024 10:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="c5fhk7If"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1829E184549
	for <linux-nfs@vger.kernel.org>; Tue, 10 Sep 2024 10:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725964957; cv=none; b=MxZrMaPwV8Q6MwAsrboy8IshVywrzyk/FntTO3FYJNuLUtpJkvH37mZ9CJIHDQpiJtJe/03sinLwi+CLv2VLs2tJu1COEjVUdzULwZGtOWfxYfPn92T7ccDClrcH7P5iKT2JsTauGZIwQeSPa9alwGKWAjWBiJe0pkZtbb3GvOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725964957; c=relaxed/simple;
	bh=lm9tjfZQgsoefmrIiw7t02owl3uvWdL/KtvHtx5V6L0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=f7WhaMCEYsN9T4nX/o7yIzyfgpG3YJqllwQWrzB5lqD6vyJ6DlJz1oh6QvWSibGkijV2TrRJ/vEVvF9UTQZi+Md0VfnREoBLQ8R2Bw7QWlr7myE84ZpxSU4Ry0S0Xc8uGXlCRzLrJSRu7Cw3xjYCFpjNo+S9SWMo8zC48letkZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=c5fhk7If; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-37308a2ea55so176596f8f.3
        for <linux-nfs@vger.kernel.org>; Tue, 10 Sep 2024 03:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1725964954; x=1726569754; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nI3i22KwgZnkUxlnZb1O9ZWeCUJAdA3POKLSePBt0ZQ=;
        b=c5fhk7IfUNl18/gkfY3zwGVC0HBS6u9yAQmy6CphoFkVRVOQXeLQDrT3NaihDgVqzp
         q+257Gmd8XPw2Hby10gNKten8bRpu6Hd8SloWCozO0rtLcc9Ew+mGwz8CZom0qEdzeAm
         Fd0uspPQL74AGFSQYVJvKDOKlawqRla2i7dVsTF3P5EfZj50GCHXe+llC9d61JYVrKta
         RvNBxGoBh3omJBsTVotnUUEYlkw6WzWuasQ+8plfcKqVB8+SQhhwUK8rCDrL2Js+9aIV
         nVtBE6prUn4HPYeIoLWYXC6ziLhHZhhAAuvpxThRCVADEdotB2qn7AYALd1jW954b2Ai
         pf0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725964954; x=1726569754;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nI3i22KwgZnkUxlnZb1O9ZWeCUJAdA3POKLSePBt0ZQ=;
        b=U8o/l4qNlmOVFigPglSoucCp9gvk4osT1dsrbea2w5urVUAxL8Ai8WJzbbmcQ0T1T0
         bPInc7hmQFzqDiNSdyBUtuz8AaXd1WjPNYIgZ8tEoobPycvd5toMxh2yfrX7NoAt2xs/
         F8aa8Boi/UD1o6POjTPE7OnaSWjjbyrdPRcy9u/NYXVCa1BFbvPspm9/rtXZTLU1RRYt
         +6PMQe2dg3DhaZVO+cugvl4f9talAbxffTodM7BOzRgh5MDhBptWqntm27+v3aiLCk4z
         KVjF3uqePlhw/RFP7P4ETyN9M/tR/21LhVwgdzHFxfUjZUEXS+l1G9Svu4DvxLlXrVUH
         HydQ==
X-Gm-Message-State: AOJu0YxT84W+pH1rXwjVXjToJfDtX7Y41kVG4RJPcax1ktYvlcoMemXz
	oQ3MUQPfyzKm4ISQX3/3AkuFhq20B6lQB9LxBQCtWqOeKcwWWpj0uUZmExliqnU=
X-Google-Smtp-Source: AGHT+IHXR1gwf3tvcw3upD6Bu+YihJH01jdCDM/lQXHFtWeNk9Z8uh021EAX9vPK9LXSM2psNHEXtw==
X-Received: by 2002:a5d:6d08:0:b0:378:955f:d243 with SMTP id ffacd0b85a97d-378955fd2damr3024674f8f.13.1725964954111;
        Tue, 10 Sep 2024 03:42:34 -0700 (PDT)
Received: from fedora.fritz.box (aftr-62-216-208-91.dynamic.mnet-online.de. [62.216.208.91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42caeb444b0sm107624335e9.21.2024.09.10.03.42.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2024 03:42:33 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: trondmy@kernel.org,
	anna@kernel.org
Cc: linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thorsten Blum <thorsten.blum@toblux.com>,
	Benjamin Coddington <bcodding@redhat.com>
Subject: [RESEND PATCH] nfs: Remove unnecessary NULL check before kfree()
Date: Tue, 10 Sep 2024 12:42:09 +0200
Message-ID: <20240910104208.4536-2-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since kfree() already checks if its argument is NULL, an additional
check before calling kfree() is unnecessary and can be removed.

Remove it and thus also the following Coccinelle/coccicheck warning
reported by ifnullfree.cocci:

  WARNING: NULL check before some freeing functions is not needed

Reviewed-by: Benjamin Coddington <bcodding@redhat.com>
Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
 fs/nfs/read.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/nfs/read.c b/fs/nfs/read.c
index a6103333b666..81bd1b9aba17 100644
--- a/fs/nfs/read.c
+++ b/fs/nfs/read.c
@@ -48,8 +48,7 @@ static struct nfs_pgio_header *nfs_readhdr_alloc(void)
 
 static void nfs_readhdr_free(struct nfs_pgio_header *rhdr)
 {
-	if (rhdr->res.scratch != NULL)
-		kfree(rhdr->res.scratch);
+	kfree(rhdr->res.scratch);
 	kmem_cache_free(nfs_rdata_cachep, rhdr);
 }
 
-- 
2.46.0


