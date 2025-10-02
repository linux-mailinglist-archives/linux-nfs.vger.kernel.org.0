Return-Path: <linux-nfs+bounces-14917-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AE1A7BB5201
	for <lists+linux-nfs@lfdr.de>; Thu, 02 Oct 2025 22:31:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C4D764E6AF7
	for <lists+linux-nfs@lfdr.de>; Thu,  2 Oct 2025 20:31:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11123274FF1;
	Thu,  2 Oct 2025 20:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HfaWl1J/"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D1D7246BD8
	for <linux-nfs@vger.kernel.org>; Thu,  2 Oct 2025 20:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759437093; cv=none; b=PvCAFHSeAtSAtP3CMbbTn8XySxbHfPvrfV71SIYnvhAK5ASEsj9/S7TZzQRv5TbgxkU8gO7kt8nGMccPmb+PptE8eMf2ypgJ7/JDBjCyFhBYr1p/NNmWJFOQKGvsDQDQCdQmXinQTxrd3GOqw5Gp9zqu4VlwFMv97pC0LMvBqfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759437093; c=relaxed/simple;
	bh=FAGQoyCRso2DpNbErMRrpyTp/YXHTvsHFqKt1MWxd0o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dV7+eE19752yrFo/ZCurAaelqZ60D9LsEZyUsdDT8Kqg6ffhVgkrqJHlvwWYnQ4MkMtdhVLuee80xEvgl6EQhF2lLoDJuOraDXvGXWObNdi/9Hi1j3TPNin2b9tE3J0XmCqHUcfpF8Tt3vDjur0huTDTyFI6W8FhG7uJlQMHUW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HfaWl1J/; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-57f1b88354eso1387282e87.1
        for <linux-nfs@vger.kernel.org>; Thu, 02 Oct 2025 13:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759437089; x=1760041889; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q+Kz42OrzHLhFdDtoqoAsqRj8EeTAJG1g9F7w1OSmto=;
        b=HfaWl1J/3LHl3n21iBkO39j821AbCpxIAyIAcxgA3dW49C0+VJgRPXEP36NNrm3Fu7
         hCkGJJ6QI3GzNFgL2rcb1c3YQS9FC98QDiOZos19D4LJd3WeAFdj/uyQJa2CEXMOC0ot
         sV2SEU5YTxZhAHWmvku8K2R+aKdbKxZKvtvaoncDbxjuJShDYP1QpynL4jOkOpAGklG2
         ak0V3E4WTYgOmqDFbiau1wmY8JXkoFfgEa7vKFBglhKRj5Z20WNHdqarbuWgqgNgZI5i
         lihPZus5R4/NmYS/a1Awz4QgFiD35ZUdMXeSRSXWVBz+RDiA3xrfTMLLj/S2m0Ra4/Fa
         VQcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759437089; x=1760041889;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q+Kz42OrzHLhFdDtoqoAsqRj8EeTAJG1g9F7w1OSmto=;
        b=merR+xVfmCv/jsJrFmZ8/by0cLvG19Sv+/13rf+eAAe14XZQhC+PHJ5hdwX+WngEpJ
         ddXH/xIKXNYJ+WC4YdrJ+DXnfwsztvdW/5ajYe4b9hKY279ZUyuZjpHXZv3Nz6iog84Y
         RJDmZ6tZnU/nrzTs72yNScIdYWsM/drbUwJMZQU3X+092nSinHG4gknLSpzbybqju1Qu
         fNlbA49SKhyJypMn8b1SslmQijnsDHH9uCOKqKuFHTNvnfBW63yz6EB75t0ySNo6TOnq
         /xvU9OKm3c8zXM7dRxMiwKV54IXwGMfKcN5J6/kh0o6MjPyGSAQ5FxBhNbEoe33YyLoi
         ZcPA==
X-Gm-Message-State: AOJu0YyQaQ9n4gd2P4GkDllnEN6e2HbS5GM8Vqxnr9lr412PUspBZAQW
	mCaFOmdIk+sWwS1zdFVO3cmjccYf2I9TgkFbGLm736mILHx3kVg6dWj/
X-Gm-Gg: ASbGncuP9gP55SfJd1pn2cyasx/bkQ4ZiLlGxCk1CpF2egOC4KXr0r6OOgODJOumRUP
	C5noHlLA0x5K3iI3Viv5zBuNeHswfmDxe7KQDkJ+fppweS0zf7iT9TZjpgImX2lYOFLr07CZhhO
	VOX1mytQvGk70HkLMdZ079kqILBJAcY//a8nTBzMyulGnXhET/MLOa1oD6un5/deLbXDxBiqobN
	JfQ2NtIpRrhsnB4ZZ2KYXrAnrFA5K5RjmwEwgFUWrnmhpjVZ9wvDdntqQ9RliBVjzrDj67tQ4fp
	6kPFdhIq152YVvJWWt2KlJ0LTQ79iMYukLJlYPhgoczXmCpOwcxcgUVpTx7KEDhBwxhqTPifwuo
	R7eDAGpJLWboV1xEN8unKr9X49nqsonK4+EmOXUOpHre5RHm7kMe0GTHBYOJSxLHSiN3LwtzLzD
	c8
X-Google-Smtp-Source: AGHT+IFsWi8xckIBDYjvJqMEjC+9e2bI4bSFpyTa6nMpxw3Xh7pt1ip35GMgbuqSHivjUBFyez5+Dw==
X-Received: by 2002:a05:6512:2391:b0:577:3ccf:cdee with SMTP id 2adb3069b0e04-58cbc2a512cmr147438e87.41.1759437089052;
        Thu, 02 Oct 2025 13:31:29 -0700 (PDT)
Received: from SC-WS-02452.corp.sbercloud.ru ([46.159.163.120])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-58b0113f3ddsm1127316e87.52.2025.10.02.13.31.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 13:31:28 -0700 (PDT)
From: Sergey Bashirov <sergeybashirov@gmail.com>
To: Chuck Lever <chuck.lever@oracle.com>,
	Christoph Hellwig <hch@infradead.org>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sergey Bashirov <sergeybashirov@gmail.com>
Subject: [PATCH v2 1/4] NFSD/blocklayout: Fix minlength check in proc_layoutget
Date: Thu,  2 Oct 2025 23:31:11 +0300
Message-ID: <20251002203121.182395-2-sergeybashirov@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251002203121.182395-1-sergeybashirov@gmail.com>
References: <20251002203121.182395-1-sergeybashirov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Minor fix as part of the functional changes. The extent returned by
the file system may have a smaller offset than the segment offset
requested by the client. In this case, the minimum segment length
must be checked against the requested range. Otherwise, the client
may not be able to continue the read/write operation.

Signed-off-by: Sergey Bashirov <sergeybashirov@gmail.com>
---
 fs/nfsd/blocklayout.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/blocklayout.c b/fs/nfsd/blocklayout.c
index fde5539cf6a6..425648565ab2 100644
--- a/fs/nfsd/blocklayout.c
+++ b/fs/nfsd/blocklayout.c
@@ -23,6 +23,7 @@ nfsd4_block_proc_layoutget(struct svc_rqst *rqstp, struct inode *inode,
 {
 	struct nfsd4_layout_seg *seg = &args->lg_seg;
 	struct super_block *sb = inode->i_sb;
+	u64 length;
 	u32 block_size = i_blocksize(inode);
 	struct pnfs_block_extent *bex;
 	struct iomap iomap;
@@ -56,7 +57,8 @@ nfsd4_block_proc_layoutget(struct svc_rqst *rqstp, struct inode *inode,
 		goto out_error;
 	}
 
-	if (iomap.length < args->lg_minlength) {
+	length = iomap.offset + iomap.length - seg->offset;
+	if (length < args->lg_minlength) {
 		dprintk("pnfsd: extent smaller than minlength\n");
 		goto out_layoutunavailable;
 	}
-- 
2.43.0


