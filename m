Return-Path: <linux-nfs+bounces-3304-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 342588CAEC0
	for <lists+linux-nfs@lfdr.de>; Tue, 21 May 2024 14:58:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E09771F218CA
	for <lists+linux-nfs@lfdr.de>; Tue, 21 May 2024 12:58:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BA4E770E2;
	Tue, 21 May 2024 12:58:47 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3FF71E48B
	for <linux-nfs@vger.kernel.org>; Tue, 21 May 2024 12:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716296327; cv=none; b=UrDu+R7Ba6DT0vXh9DHuoOHtCEERKBhdkj3E26OinmnIJjL87sQ/Yxg2a30M6G7ENwfLJrSZN9BoApdN2svQN2DgfMV+t94wICymnkakqimn9GUbPWByYoG4kxSYMv5fcw6v5BGalAQl7L61eJc5FlC7vCHWk7tHUOYakIJAevA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716296327; c=relaxed/simple;
	bh=O3EbuI5x378NaBPU7VSJRQxY4SvMcKAx8CpS5SJ5RTA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PMX71gndChswZX8Hzg2NRcfpYx6BIIgjXcHFkm0lK7gn2hJCfR0xGfT9L/UMLXShfSknI8kknxCs+xXh/HCoDQugFONLGPeQHhbnYLvcoYnTSRk73IddTEWFgEpG1rIbJAlpmeCv096x4uWuntWPDxT6url7sO96DUaEnYmNHf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-354c84d4604so529184f8f.0
        for <linux-nfs@vger.kernel.org>; Tue, 21 May 2024 05:58:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716296324; x=1716901124;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=olHB2X467EZQCAkdKYsZzPMump8xN9lfA38O0J4pCT0=;
        b=rrF8A7BH4+unJKCBvBiUJiU2eL8B33/pTr2UwlgDoPQQJ/dOI10CT8ABsCC6Ppdl5/
         yFgzXLtZ6RDmr0PWyIzGM7ROWujPwRTYOsUm0RaykWQrl7dr9HscCbdf5Rm5Hbm4oMgo
         l8GpFPXZ3camjl5RpByIrJLoyBncekLniYToSQi6xVj348baxGTxYmxxyggY4pxkmIZb
         ql8l7ptv7aD+KOht8BpI4sPmf9QsR2yQFvdfJlF9TaHYFHZbNHr2BvX554VTzIK+lomq
         Qg5xncgO8uwqEhIugEzRhInI6XVx/o4N3hqZhA4m5HFpI66So9WjShF7FYS50YUSSYwv
         Z47A==
X-Gm-Message-State: AOJu0YzT4p6bciJcP22BOE4CP6mFhpy7Y35F83qMMcg2H1Fgc901CFY0
	XuxNUUD0/L3okbyJ/1xhTw7zg98dFOlMa3mvOYNHlbM7wVOuSywQVGvOoQ==
X-Google-Smtp-Source: AGHT+IFC3VcoC7777GOJ+40XzCHcB9DaBMNN5J1bS5SjtFIiWSPTcfTj5gMfbF5ZqXYTCap6x344GQ==
X-Received: by 2002:a05:600c:3b0a:b0:418:2719:6b14 with SMTP id 5b1f17b1804b1-41feac5a400mr241744395e9.3.1716296323471;
        Tue, 21 May 2024 05:58:43 -0700 (PDT)
Received: from vastdata-ubuntu2.vstd.int (85.65.193.189.dynamic.barak-online.net. [85.65.193.189])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42011bd013asm372743685e9.21.2024.05.21.05.58.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 May 2024 05:58:43 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nfs@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Dan Aloni <dan.aloni@vastdata.com>,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH rfc] nfs: propagate readlink errors in nfs_symlink_filler
Date: Tue, 21 May 2024 15:58:40 +0300
Message-Id: <20240521125840.186618-1-sagi@grimberg.me>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is an inherent race where a symlink file may have been overriden
(by a different client) between lookup and readlink, resulting in a
spurious EIO error returned to userspace. Fix this by propagating back
ESTALE errors such that the vfs will retry the lookup/get_link (similar
to nfs4_file_open) at least once.

Cc: Dan Aloni <dan.aloni@vastdata.com>
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
Note that with this change the vfs should retry once for
ESTALE errors. However with an artificial reproducer of high
frequency symlink overrides, nothing prevents the retry to
also encounter ESTALE, propagating the error back to userspace.
The man pages for openat/readlinkat do not list an ESTALE errno.

An alternative attempt (implemented by Dan) was a local retry loop
in nfs_get_link(), if this is an applicable approach, Dan can
share his patch instead.

 fs/nfs/symlink.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfs/symlink.c b/fs/nfs/symlink.c
index 0e27a2e4e68b..13818129d268 100644
--- a/fs/nfs/symlink.c
+++ b/fs/nfs/symlink.c
@@ -41,7 +41,7 @@ static int nfs_symlink_filler(struct file *file, struct folio *folio)
 error:
 	folio_set_error(folio);
 	folio_unlock(folio);
-	return -EIO;
+	return error;
 }
 
 static const char *nfs_get_link(struct dentry *dentry,
-- 
2.40.1


