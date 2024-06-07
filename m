Return-Path: <linux-nfs+bounces-3595-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AA8F900684
	for <lists+linux-nfs@lfdr.de>; Fri,  7 Jun 2024 16:27:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 614561C22D07
	for <lists+linux-nfs@lfdr.de>; Fri,  7 Jun 2024 14:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68795196DA5;
	Fri,  7 Jun 2024 14:27:08 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B29015D5D2
	for <linux-nfs@vger.kernel.org>; Fri,  7 Jun 2024 14:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717770428; cv=none; b=PjWfTHA9JGMPR1hj0GosNxpdTPsGUz9d2xP94jQhoxnl82X4IY9gsSsFiYFoNvKMwdf9UtfrsRYYXTYzFVzLUoI1jI/9Dq3dobcKhg+M6kwy9MFfSa8DqwMngPe6jnA9JuQ349sZTIkyx34PlDQ56xoGv9frF9d1aguWItYW50g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717770428; c=relaxed/simple;
	bh=OZ1/KIho29dGUdUEE6G7CWa7k7tgrQWchBn20rQ2H+M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g7ueRqAPT4qHwsNHNzNr5s78FqokAY+OgCirBJhm/BGIjn+oMY1FWKwnWcM5G2GxnlwPv1EVIvglYU8Fx3j/IMsJdzhNkW7gEUeU1VHK0LXH8J6s2zHqzNFmFVf249IxhGKuTqys1kDGnocV4CpkvGLhoGTmgbZBfCGONYBMJ7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=snitzer.net; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=snitzer.net
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4402602a116so11084561cf.0
        for <linux-nfs@vger.kernel.org>; Fri, 07 Jun 2024 07:27:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717770425; x=1718375225;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d6cF2mg24tlpOxDpu+TJ7Xxlze6Cn1GpW1T7FR/ACXc=;
        b=sGMhXNkU2S8kaYpZa2bbsmaPhKN0RCuqC7f8V3dsmAQ4mllC/u0/WrX2X/Sx3zELME
         HPpQKX6qGmxGymB6vDWGKxO0f1S6rT7eFiPBSLTcQen0uxm08sGcjTTRs2DcAtB8Pc5+
         r/a7E7A3ZCN+/S9UyMP02LHHDVNf+23woVYyNTXqM83Kk/ivWgV0Hyr9D+dyr3W/ZWzN
         QrXqFsnPjBNwKu+J3YLXZI3Uc/Vqj4lOhW3/1Il1/uFhVv6TYGx/C5xSXS81KXeJXhUj
         Hx1K+coJVdPxh1tFoci9rEo6dW6Bwlhj2L/sOzCZZDkAQWnzyXtmZncXh3W4zzWdk7Ss
         namw==
X-Gm-Message-State: AOJu0Yyes0sMbGW8SRmytKbF65lqSXXUajAnBVAqv4LmfgGA7nlH9SMe
	idYNY2pqEOsWhCCImG7HH0N0ZS15R0ghbft55wDCgmM6plE0lnZxJUMlfrl3KbnuYjXPEBHsNFr
	kGaEf3g==
X-Google-Smtp-Source: AGHT+IH+DgdkmB7+t5BXMadrrh23L2KWvC3eCvfpycHkP5+VIfIOuLcSVFzhcfpRBj3gUFJqswbEqA==
X-Received: by 2002:a05:622a:d:b0:43f:f018:6a7c with SMTP id d75a77b69052e-44041c68b74mr28448681cf.33.1717770425153;
        Fri, 07 Jun 2024 07:27:05 -0700 (PDT)
Received: from localhost (pool-68-160-141-91.bstnma.fios.verizon.net. [68.160.141.91])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-44038b5e617sm12492921cf.93.2024.06.07.07.27.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 07:27:04 -0700 (PDT)
From: Mike Snitzer <snitzer@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Trond Myklebust <trondmy@hammerspace.com>,
	snitzer@hammerspace.com
Subject: [for-6.11 PATCH 11/29] NFS: Enable localio for non-pNFS I/O
Date: Fri,  7 Jun 2024 10:26:28 -0400
Message-ID: <20240607142646.20924-12-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240607142646.20924-1-snitzer@kernel.org>
References: <20240607142646.20924-1-snitzer@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Trond Myklebust <trond.myklebust@hammerspace.com>

Try a local open of the file we're writing to, and if it succeeds, then
do local I/O.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 fs/nfs/pagelist.c | 19 ++++++++++---------
 fs/nfs/write.c    |  7 ++++++-
 2 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/fs/nfs/pagelist.c b/fs/nfs/pagelist.c
index 9210a1821ec9..5890824f6200 100644
--- a/fs/nfs/pagelist.c
+++ b/fs/nfs/pagelist.c
@@ -1066,6 +1066,7 @@ EXPORT_SYMBOL_GPL(nfs_generic_pgio);
 static int nfs_generic_pg_pgios(struct nfs_pageio_descriptor *desc)
 {
 	struct nfs_pgio_header *hdr;
+	struct file *filp;
 	int ret;
 	unsigned short task_flags = 0;
 
@@ -1077,18 +1078,18 @@ static int nfs_generic_pg_pgios(struct nfs_pageio_descriptor *desc)
 	nfs_pgheader_init(desc, hdr, nfs_pgio_header_free);
 	ret = nfs_generic_pgio(desc, hdr);
 	if (ret == 0) {
+		struct nfs_client *clp = NFS_SERVER(hdr->inode)->nfs_client;
+
+		filp = nfs_local_file_open(clp, hdr->cred, hdr->args.fh,
+					   hdr->args.context);
+
 		if (NFS_SERVER(hdr->inode)->nfs_client->cl_minorversion)
 			task_flags = RPC_TASK_MOVEABLE;
-		ret = nfs_initiate_pgio(desc,
-					NFS_SERVER(hdr->inode)->nfs_client,
-					NFS_CLIENT(hdr->inode),
-					hdr,
-					hdr->cred,
-					NFS_PROTO(hdr->inode),
-					desc->pg_rpc_callops,
-					desc->pg_ioflags,
+		ret = nfs_initiate_pgio(desc, clp, NFS_CLIENT(hdr->inode),
+					hdr, hdr->cred, NFS_PROTO(hdr->inode),
+					desc->pg_rpc_callops, desc->pg_ioflags,
 					RPC_TASK_CRED_NOREF | task_flags,
-					NULL);
+					filp);
 	}
 	return ret;
 }
diff --git a/fs/nfs/write.c b/fs/nfs/write.c
index ba0b36b15bc1..79375af3f2a6 100644
--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -1808,6 +1808,8 @@ nfs_commit_list(struct inode *inode, struct list_head *head, int how,
 		struct nfs_commit_info *cinfo)
 {
 	struct nfs_commit_data	*data;
+	struct nfs_client *clp = NFS_SERVER(inode)->nfs_client;
+	struct file *filp;
 	unsigned short task_flags = 0;
 
 	/* another commit raced with us */
@@ -1824,10 +1826,13 @@ nfs_commit_list(struct inode *inode, struct list_head *head, int how,
 	nfs_init_commit(data, head, NULL, cinfo);
 	if (NFS_SERVER(inode)->nfs_client->cl_minorversion)
 		task_flags = RPC_TASK_MOVEABLE;
+
+	filp = nfs_local_file_open(clp, data->cred, data->args.fh,
+				   data->context);
 	return nfs_initiate_commit(NFS_SERVER(inode)->nfs_client,
 				   NFS_CLIENT(inode), data, NFS_PROTO(inode),
 				   data->mds_ops, how,
-				   RPC_TASK_CRED_NOREF | task_flags, NULL);
+				   RPC_TASK_CRED_NOREF | task_flags, filp);
 }
 
 /*
-- 
2.44.0


