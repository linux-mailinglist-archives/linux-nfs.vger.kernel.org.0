Return-Path: <linux-nfs+bounces-5301-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B610794E110
	for <lists+linux-nfs@lfdr.de>; Sun, 11 Aug 2024 14:19:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 707962812ED
	for <lists+linux-nfs@lfdr.de>; Sun, 11 Aug 2024 12:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C7364C618;
	Sun, 11 Aug 2024 12:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="SVB/G7x9"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07AC84D8A1
	for <linux-nfs@vger.kernel.org>; Sun, 11 Aug 2024 12:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723378761; cv=none; b=IfWijW3DZKUKNwAXaJkmm7W/IFdUSz+1R3n6cYFrbzzuVK+8H0ViFOnJBpOD5yneS6EjI1vMq8HgH/DH51xXFmK7x0/awQZ1txFgV83lHpOHxecU0jwfBDi+ucd9AToL8fFGWzoQyFSEaMFJKq1ITFg4P2RjrKpqdc5jgGeF5wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723378761; c=relaxed/simple;
	bh=3THWZrnCdxgnYfH8MMSmKFUk7cd+A+Ovt5MCn7efbvw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=l3uRKRAV6mp9fF5gO7evUdB+7t5ntaizotL8DL4NpFsm9CDXuXjKjrU9dyed4E2jLOOGqreGQH9aMDMH1bocIXhS+LhPtIL0+MYk7TNWDWZ8vvax1T4+GrrLNb3QjhgZjxJ8cXSqM/VQDXe4yIeN8maW7vm+wZ+z9aoTPVrFfsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=SVB/G7x9; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-52f01ec08d6so4779760e87.2
        for <linux-nfs@vger.kernel.org>; Sun, 11 Aug 2024 05:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1723378757; x=1723983557; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yP70h5sOAav0dcTN2sWxjb2tAt3WMCTYkQx1cJFN3BA=;
        b=SVB/G7x9xrqyaiugcAw8YnRjd4EJSIYD3LECHCbdDcyntQ16KzinEyOMjqA/bNgRZ+
         hDYOmy5OtsUg41y5IN5PAuzUgsU/48XGy4e54KRFNGjsXpPhlBnpxNURichQMTscATi7
         3KF4Oq5PWAukJdDI19sqMCND07Tzr8oDca/23rteEL3d6ZmdXmo8C0UCThiDzgZHUd7g
         0M7R3W1jGh2HwutO3EkRdNqr2HrF/b/DfOr6z3sbpdHoMYyjy8bG1xrNb5ZD7mFK3Zim
         zMLHW0UShdA3gCZimkdgjGaUpNF18vNBOpIgqeHgBEWn9soUhkSr7ikeoq4vyX06r1bu
         fJxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723378757; x=1723983557;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yP70h5sOAav0dcTN2sWxjb2tAt3WMCTYkQx1cJFN3BA=;
        b=eBsnDXiZQRPYTwjhr8uYrcfJfbZhyyckGa7bWH/PQYErV0R1IKncpHRejWbASLwI7Y
         CVR4HqtpEUInVty0WofYjNvsOGiCWqSI3NagPrcdXB1iFG9XvejMUPcKcb7YG9kVJsGg
         L56oxU+wQ8QQQEVJ2Zb8sn+X2bejEZipZVhn5mcJRoe0WoRD3B9KXxlz/Q2tHVT4sezg
         Us36rxlz/ISpvljY3czeaVKQ/RS3cFVz4K/zpEoIOIGajnPaUVox+0seu0OJnKrNqMQd
         aHwc14ZawPcr0C4IVF63T8RATc+lWpY5a2agpz0mLjxeDCHCaV/M7ho+QxtpubJuoBaD
         Y2GQ==
X-Gm-Message-State: AOJu0YxkTTgsZA34wHYS2ozqgwj4+wzzDpn2GmQd/aSUTj4kKTQPgH0C
	Twd3ffxkbkOloRLQkZbYjrRjbYf5IbYbfTxMHvx2GfTO7O5oivjwmROikqjzas4=
X-Google-Smtp-Source: AGHT+IEXj75gYbZxGPL3C+2QgkpuQN10QPxBcziNY/qe5bJnu2lhrqOwXI6sj69mDovW8m9xxYPsbw==
X-Received: by 2002:a05:6512:1094:b0:52e:9670:e40b with SMTP id 2adb3069b0e04-530eea25075mr4956639e87.39.1723378756786;
        Sun, 11 Aug 2024 05:19:16 -0700 (PDT)
Received: from fedora.fritz.box (aftr-62-216-208-163.dynamic.mnet-online.de. [62.216.208.163])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a80bb0e1235sm144196566b.55.2024.08.11.05.19.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Aug 2024 05:19:16 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: trondmy@kernel.org,
	anna@kernel.org
Cc: linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thorsten Blum <thorsten.blum@toblux.com>
Subject: [PATCH] nfs: Remove unnecessary NULL check before kfree()
Date: Sun, 11 Aug 2024 14:18:10 +0200
Message-ID: <20240811121809.127561-2-thorsten.blum@toblux.com>
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


