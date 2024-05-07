Return-Path: <linux-nfs+bounces-3195-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3607D8BEDC7
	for <lists+linux-nfs@lfdr.de>; Tue,  7 May 2024 22:06:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE56C1F227FD
	for <lists+linux-nfs@lfdr.de>; Tue,  7 May 2024 20:06:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05A6516DEAE;
	Tue,  7 May 2024 19:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IbEve2Cn"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B17316DECF
	for <linux-nfs@vger.kernel.org>; Tue,  7 May 2024 19:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715111976; cv=none; b=L4Xq6vqT58DEys52Xm5O9BuU79mz3zSFDMPwKAv6k+S4/NRdP4lgTvDU9XNNe+YMFgC4NsPXlvpHXMzaBP6TraTwYAzopIkS0YtDczRodDoPOkmUhoBbHOZL21uHZWMSbS3YffjaMZvzAho8KOPp8b1EUPlh7Mu2oZsVOr1/Rk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715111976; c=relaxed/simple;
	bh=nO56AGtRUysJC/OnBTNYe8YO07Cfd+oulHIC9Y9Y0QA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HwiBDDz3IQVg4Btbfwjru/r/Epp6ciwWjzqFde1/Y7vENg5JbOBrJCN1w8ZFwxpF2tT8Qz4YX4FPzR6PVuXK6pgxVvkNG44jaCjPjMcJfyGxyHvDIzyBtwRwQHenzQvqtRpGhdjPXJu/ZHgq2HVr3zFOjio5XPpIBS3zJqtwxaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IbEve2Cn; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-7d6b362115eso30715539f.0
        for <linux-nfs@vger.kernel.org>; Tue, 07 May 2024 12:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715111974; x=1715716774; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=w5YF7Z7AF7jQyYwLzjFO0f1fwv/YKhS0zUP8WVGUoWg=;
        b=IbEve2CnG6lNOciv3xeSnZ38juLlwLIUlLDlSTWEXWCzSm3oFZPVmmqIyNvdkILCPa
         0X7EK7tP7VzLL2Lo7dU1yJh1UfoQcJPNzfQA5DvyXiVOheiuP+CSgE/ATfXK7JVdcmsx
         tcVsaK1bvYdNF6loC9Acy3PqEhwI0wJ6Y3Jw6TSLwUjjbWQ0aM2szZxlrhW1MdwG6RJD
         aCV7u7saCbOyUwPdmpQJ/8Bh3XH2bQm7mnsSqa120PnZyCJA3n5xV7uIe9ALHmlJjlA4
         3vwPITUwxPnaY4VI1x9VlO6fxL6Dsh9bv9ZYtAI9jWUn//RgSmpCZtssv95e9KTa22RS
         qMZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715111974; x=1715716774;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w5YF7Z7AF7jQyYwLzjFO0f1fwv/YKhS0zUP8WVGUoWg=;
        b=nq+oy1JwIv/tL9lodrdRsvxJUel1eUt3lXvCNxqjnCNez6BbVsJct2NR9IC7BlSb0p
         jMMA92oz8qDAJTLklgcoaoulTWZ+yq7Zf/Sk3V0JaRXgEwWFi603N08krFBsaXN0xNCE
         saYg+h5SBDTYI+IsQv/LCNNZoTea+Q1inrZegb4JNdNa4qR6zSsp9dL4DOrS/81XxLu+
         hQuDxvpMhtyAGPZzZe05q0j9rBOB0simbWT3Pa9N9ghZxHzpOypEW9bjy+IakhbkB6pF
         JpIpfywVirEy2TkeNrJ8XwJdVDJVq+Jc6Cn4FJj7z4qe5JJ8N8qODzQ/fe8xrftB7zIA
         21Wg==
X-Gm-Message-State: AOJu0YxJBJOdRDOj50NhMFeuWqaKFrqbd7Cvtc2dS4u1XpNpS7THv2Fz
	XfP6oNTpS36xuMNAOf5QhwRFZD9zbkFK0q/4nFTBtk6VOgi0C+OV
X-Google-Smtp-Source: AGHT+IEijfiPttlG3z666FVAVlb4dcDkN3RncImL4iOxwMP2U+jMwXQGHv03X9UrXlWNviHcGCGNAw==
X-Received: by 2002:a05:6e02:1fef:b0:36b:15e0:de18 with SMTP id e9e14a558f8ab-36caeb45952mr6238825ab.0.1715111974537;
        Tue, 07 May 2024 12:59:34 -0700 (PDT)
Received: from kolga-mac-1.attlocal.net ([2600:1700:6a10:2e90:d0a5:c6e3:4e72:2c07])
        by smtp.gmail.com with ESMTPSA id x3-20020a056e021ca300b0036b3735d22dsm2836296ill.82.2024.05.07.12.59.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 12:59:34 -0700 (PDT)
From: Olga Kornievskaia <olga.kornievskaia@gmail.com>
To: trond.myklebust@hammerspace.com,
	anna.schumaker@netapp.com
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH 1/1] pNFS/filelayout: check layout segment range
Date: Tue,  7 May 2024 15:59:33 -0400
Message-Id: <20240507195933.45683-1-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Olga Kornievskaia <kolga@netapp.com>

Before doing the IO, check that we have the layout covering the range of
IO.

Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
---
 fs/nfs/filelayout/filelayout.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/nfs/filelayout/filelayout.c b/fs/nfs/filelayout/filelayout.c
index 85d2dc9bc212..bf3ba2e98f33 100644
--- a/fs/nfs/filelayout/filelayout.c
+++ b/fs/nfs/filelayout/filelayout.c
@@ -868,6 +868,7 @@ filelayout_pg_init_read(struct nfs_pageio_descriptor *pgio,
 			struct nfs_page *req)
 {
 	pnfs_generic_pg_check_layout(pgio);
+	pnfs_generic_pg_check_range(pgio, req);
 	if (!pgio->pg_lseg) {
 		pgio->pg_lseg = fl_pnfs_update_layout(pgio->pg_inode,
 						      nfs_req_openctx(req),
@@ -892,6 +893,7 @@ filelayout_pg_init_write(struct nfs_pageio_descriptor *pgio,
 			 struct nfs_page *req)
 {
 	pnfs_generic_pg_check_layout(pgio);
+	pnfs_generic_pg_check_range(pgio, req);
 	if (!pgio->pg_lseg) {
 		pgio->pg_lseg = fl_pnfs_update_layout(pgio->pg_inode,
 						      nfs_req_openctx(req),
-- 
2.39.1


