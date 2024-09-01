Return-Path: <linux-nfs+bounces-6107-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8337967771
	for <lists+linux-nfs@lfdr.de>; Sun,  1 Sep 2024 18:19:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83C58281E02
	for <lists+linux-nfs@lfdr.de>; Sun,  1 Sep 2024 16:19:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C45E18132F;
	Sun,  1 Sep 2024 16:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="pNt2hVpf"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8515D155A24
	for <linux-nfs@vger.kernel.org>; Sun,  1 Sep 2024 16:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725207588; cv=none; b=IyIcHTvoRZXyxvFgfnBUpf8WwlHD7/Nb57CT/zU4t2ue4E+rhnIT6kWiCPJfdIGXqdtNMmOfeTSzMJeaVQiZ0fokO/1Ztu51tF3Yh0mVyYj7AqaZ105W342Ql79az9Zt7Rb79OyZkdrFFvjcp9WpZaKEtW5hXnS39u4E9abqdKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725207588; c=relaxed/simple;
	bh=lm9tjfZQgsoefmrIiw7t02owl3uvWdL/KtvHtx5V6L0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kJj0lYXODz7LD1lLMHc62oc8SS5fcTk1a2T5EV3R0bKzybRD38z7VeyhvpyQJ9j231yDao6/FXIELOxZl6uHI1vkLPGy+Cje8qrqMcOMGDm7qWnPatyI/HpDn6A+1/cvTtFNY7uWHKbU0yw4kIVru4tQVcNJbixRDfyrTRuZlR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=pNt2hVpf; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a86753ac89bso14872166b.0
        for <linux-nfs@vger.kernel.org>; Sun, 01 Sep 2024 09:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1725207585; x=1725812385; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nI3i22KwgZnkUxlnZb1O9ZWeCUJAdA3POKLSePBt0ZQ=;
        b=pNt2hVpfI9IIwwgyX3xdxQL6m3KuAhYZ2Q88kaR4DIsVkq0Zk2/lj4eppREUoiLaLf
         X+UDCHsXe1aPjaYHeyKdxrsw1NiMxow/zrP4vBeq2TkwEXQTHPMZfFgkpEW37g9CX0fk
         LhtSie3q2DhwRhSyUzAGSb9oX4kMOIMFHOo4c8ce4AiJLxHgIde4piDxtmLO/SYD0Y7w
         bmBC1Jhf4NI98JeKwrAJvQ8fwXoTnR2jiKG7L88Mj0oEkhQNS+faEFQ0r3EI2mahyNyA
         4GRTEYRI2GGKSZAWM6TSD2i9M1ZLzLZRs3kY0byi66DMylsxeD5ayTEjVWVESSzM9MlA
         f5RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725207585; x=1725812385;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nI3i22KwgZnkUxlnZb1O9ZWeCUJAdA3POKLSePBt0ZQ=;
        b=lbF21Iwr++C9Yv8YxKrnUMXPyBUGcFWV240SgbQu7CU7idMWQ8H+tV2ZTY3P2QCKKg
         rBHeVGyp16Z1QvnE0Li/g/mwqzAw98zsum3922NAl2iq6A69BJ6gOHUngEnPn3uUdECq
         T1wRzq0m5f2/q0eeBv+0FNhKn9MonhDOxN1fdL5O1yOuAaWyaICjD5fhC7ZbkiLKedzD
         lXnLH0Q6Se38BCFnsFwcdgD+W/MnDjiH7GI8se9yvWPocoWGZyjPUGnVjjjHKPGlzQac
         SQPKwao519UOtrPAk1WxTGW+lPq8cOf/3k7alkWCfbqqN2CizazuAaqO3ORSRJ8I89di
         2Zgg==
X-Gm-Message-State: AOJu0YzDupwP8+XSdA60PSHE8ekNSaiY8XgZVlpEsqCdY3+gYsrAJ9bt
	iDUELE1Y67m3q7QuQYE8AhIcM30yc7niGUR7zd4ex2TMlGYD0FRlUWzA+DBn9U/NYQJKQ2wlX4b
	P
X-Google-Smtp-Source: AGHT+IHZK+KvAvt2qU4ICz3naVrtnFtg1vdPvWBd8nYL3wdzd/2eDU2Z1MeJDIAdEOTr2tVvU9FRcQ==
X-Received: by 2002:a17:907:3f0b:b0:a80:f54c:ad68 with SMTP id a640c23a62f3a-a89a34743f5mr307002766b.2.1725207584554;
        Sun, 01 Sep 2024 09:19:44 -0700 (PDT)
Received: from fedora.fritz.box (aftr-82-135-80-228.dynamic.mnet-online.de. [82.135.80.228])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a89892164f5sm450365866b.192.2024.09.01.09.19.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Sep 2024 09:19:44 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: trondmy@kernel.org,
	anna@kernel.org
Cc: linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thorsten Blum <thorsten.blum@toblux.com>,
	Benjamin Coddington <bcodding@redhat.com>
Subject: [RESEND PATCH] nfs: Remove unnecessary NULL check before kfree()
Date: Sun,  1 Sep 2024 18:19:13 +0200
Message-ID: <20240901161912.117045-2-thorsten.blum@toblux.com>
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


