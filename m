Return-Path: <linux-nfs+bounces-3728-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B4D1490630D
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Jun 2024 06:18:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66C2C1F2157F
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Jun 2024 04:18:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 847E913664B;
	Thu, 13 Jun 2024 04:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jp6XYYKZ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15B35132C3B
	for <linux-nfs@vger.kernel.org>; Thu, 13 Jun 2024 04:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718252278; cv=none; b=GOwfSTj5n/CHS66mGNjyyT7BzMjbM/Kiod9/tknR9iD0Wn4WuBuf0RVNwHqYNJ0x2um9jwZxeoJLsFxCIkTAaN9S0r7ZZgSdUn0I/FIwCwWmt6e8XlRDWc/uFU0KfvTBhFQZdMysncloC90a2h1Ut7oeqm2fiAVRrA9iUKwcRhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718252278; c=relaxed/simple;
	bh=l/JP3v9x70TAg/NEFnMLNCt9tijubDiHDpNYOyEMc7c=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PWV6QMmpmacH4hoJztgRjPrLvq2nrJSdKyhNBWbqbEZM3w7HQ6sruxmto36Ohui6TbROyOFZ9KBPwgvifwB6V/x+CqOcehV9zhm2qBqH8aPY57n8/nFDQ0KpJOjxIYvYv3oVXKjSC+Dn9575c5X7IxcWUOcKK53OB6xuo7vsQmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jp6XYYKZ; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6afc61f9a2eso5957126d6.0
        for <linux-nfs@vger.kernel.org>; Wed, 12 Jun 2024 21:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718252276; x=1718857076; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NpBIbWSgQHLAIBUajMrBNhcehFY7KD/Xz44sbnRKseI=;
        b=Jp6XYYKZRnxJpDpwa5OGonrL+/4zy3FEArWH76rY0zebLdx+7mD7xUDTnhOZzxsGid
         ePD0ZMGEBiCnKifkO1QxXz2WTBzwLaUl9etOJM5nGk1PR8moMZTr3im6fPbxyhw2nKP/
         JRmiBcUzzVE2tlwYl364maMOjCGL3CJFm6opmqAG8durJWXM4dJcetQtBK/Ex5HemMLM
         cxX5XzDlEEg5DkJokwdcpErzX3eMLBXTvqm5l7wEIieq3KlzERyyrPjNGGORVwgWU1sp
         M0I7vQOx4Nb2hgXQn+vus+vGB/3uHvLmsu9id4kgyAXQvN5/foYeStzg2T3W6t3K2pY1
         KzsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718252276; x=1718857076;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NpBIbWSgQHLAIBUajMrBNhcehFY7KD/Xz44sbnRKseI=;
        b=oPrlcqsGVG1iBK2nBE8C3znS+OemdxEjKl00TCeC49vC7UZmM2/PiPMqRoFAqtg/S7
         8tq/PV+o4CG/9k/rF17qy9oJ3R4alUGUwn4w45orcXaGBO78BWqUMSqS++UesXqOOR9w
         yImMT/FDCjsb4XDKKrLFDels6FlQ7bHNfMsJZcLdyJphvXQHuQntKy659QI48ExxDcG6
         WrrEWRcIxv8wC1kMSzcdB7qjUryzs+CgKZhKHalsT/B1cfMP8DIxhkki+N812Z9Kii5l
         w8MuJJeM3TgibsAlTHqvaZQohyOuIFVKUPpvDnDPkRja6o111+9jVyWMPBNZkB/N/029
         hZDA==
X-Gm-Message-State: AOJu0YxWRzVEWSsfilKI0XRq2lXsb6Tzw8lYdyDQv3D1zMChu7E/Z9Bc
	vfnYFG1ayFBDxuiEzUS6nOIpwWNo26clgdwO8WFXEcyOm16NgThJokIB
X-Google-Smtp-Source: AGHT+IEu40wiUCYPpvD0N2xT1OvrFasTuA6tXp5T5cqg0+VSkdjkn9LlVLScBB4WeeVzqgiMCuV7DQ==
X-Received: by 2002:a0c:df88:0:b0:6b2:a47d:8f2d with SMTP id 6a1803df08f44-6b2a47d915amr21796906d6.24.1718252275677;
        Wed, 12 Jun 2024 21:17:55 -0700 (PDT)
Received: from leira.trondhjem.org (c-68-40-188-158.hsd1.mi.comcast.net. [68.40.188.158])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b2a5c68ff3sm2851546d6.74.2024.06.12.21.17.55
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 21:17:55 -0700 (PDT)
From: trondmy@gmail.com
X-Google-Original-From: trond.myklebust@hammerspace.com
To: linux-nfs@vger.kernel.org
Subject: [PATCH 19/19] Return the delegation when deleting the sillyrenamed file
Date: Thu, 13 Jun 2024 00:11:36 -0400
Message-ID: <20240613041136.506908-20-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240613041136.506908-19-trond.myklebust@hammerspace.com>
References: <20240613041136.506908-1-trond.myklebust@hammerspace.com>
 <20240613041136.506908-2-trond.myklebust@hammerspace.com>
 <20240613041136.506908-3-trond.myklebust@hammerspace.com>
 <20240613041136.506908-4-trond.myklebust@hammerspace.com>
 <20240613041136.506908-5-trond.myklebust@hammerspace.com>
 <20240613041136.506908-6-trond.myklebust@hammerspace.com>
 <20240613041136.506908-7-trond.myklebust@hammerspace.com>
 <20240613041136.506908-8-trond.myklebust@hammerspace.com>
 <20240613041136.506908-9-trond.myklebust@hammerspace.com>
 <20240613041136.506908-10-trond.myklebust@hammerspace.com>
 <20240613041136.506908-11-trond.myklebust@hammerspace.com>
 <20240613041136.506908-12-trond.myklebust@hammerspace.com>
 <20240613041136.506908-13-trond.myklebust@hammerspace.com>
 <20240613041136.506908-14-trond.myklebust@hammerspace.com>
 <20240613041136.506908-15-trond.myklebust@hammerspace.com>
 <20240613041136.506908-16-trond.myklebust@hammerspace.com>
 <20240613041136.506908-17-trond.myklebust@hammerspace.com>
 <20240613041136.506908-18-trond.myklebust@hammerspace.com>
 <20240613041136.506908-19-trond.myklebust@hammerspace.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Trond Myklebust <trond.myklebust@primarydata.com>

Signed-off-by: Trond Myklebust <trond.myklebust@primarydata.com>
Signed-off-by: Lance Shelton <lance.shelton@hammerspace.com>
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/unlink.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/nfs/unlink.c b/fs/nfs/unlink.c
index 0110299643a2..bf77399696a7 100644
--- a/fs/nfs/unlink.c
+++ b/fs/nfs/unlink.c
@@ -232,6 +232,8 @@ nfs_complete_unlink(struct dentry *dentry, struct inode *inode)
 	dentry->d_fsdata = NULL;
 	spin_unlock(&dentry->d_lock);
 
+	NFS_PROTO(inode)->return_delegation(inode);
+
 	if (NFS_STALE(inode) || !nfs_call_unlink(dentry, inode, data))
 		nfs_free_unlinkdata(data);
 }
-- 
2.45.2


