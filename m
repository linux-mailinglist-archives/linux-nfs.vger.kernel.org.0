Return-Path: <linux-nfs+bounces-3596-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 56E69900685
	for <lists+linux-nfs@lfdr.de>; Fri,  7 Jun 2024 16:27:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54DCB1C22DA6
	for <lists+linux-nfs@lfdr.de>; Fri,  7 Jun 2024 14:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E9D0197521;
	Fri,  7 Jun 2024 14:27:09 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DFFF197548
	for <linux-nfs@vger.kernel.org>; Fri,  7 Jun 2024 14:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717770429; cv=none; b=JhHrJEhCMTrk2rJ74ZUto53v61LK7LtQ3uNRZcMXwfDrGq94Cc2D+FC8uuqELKsR5kEan+iROCFYIYegf1sO6/WxxjEl9Bmdq+8APgEYZRZ4pTDXFJj7qLvbUVBoyhcs7cBAA939ZJ1qKhzvaegZhSVZR5WVnv1P+uSQ6JP65jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717770429; c=relaxed/simple;
	bh=a6zvs9e7qnjaqwLeRfDsRQX81N4Dwl9FIabubDCuzuE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fV4uByImq27YZ5fCSGIe05vIDl9hoLLW5SJPMgyQbDk0PqLlLvUauuAARkAG8E3vc7cojCThHMkfue0zGQPewKiXZ0q7WI5mZSnFaKUakoN1ual7jtXtOm2C+bmL/wpn3BiylA2zN5OYMMBuUtJz5Rsx3KVw6ibkubPhtAOoTa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=snitzer.net; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=snitzer.net
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4402066471cso18264671cf.0
        for <linux-nfs@vger.kernel.org>; Fri, 07 Jun 2024 07:27:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717770427; x=1718375227;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/Aq7tdWcYM5gnb5sx8vyvI27WmyADYKfh1wRJYWT1fc=;
        b=hV/TNTYtwj9SWr8A9ARVBda0NdccUuqzyH11ve0soEB96AzlpFPhUgi/tHxE1FHXsH
         14eq1Ny+ED8fg8wTnH455Gq7HceoBA33H5YD9bs7AIH6VYUQmPCf557bJjsAmbN4nJNZ
         cWf1GuZsWydOOjlBjCzSnUdFd5UexBQN/739OLRX7JA8twjxx12kqp7X7dzAgMuNX5vt
         zIjwY6F/+sD3S9MFg1d63PcrzZI2DOI+sEhSdpl0+z7zLAtv9VTeVRbaVqqgBXsyReDX
         fP4k2AWC7s2kW427H4X0UCNh2n6T/OGTl9zxx2Aid31ybQSORA07Yl+n+VZbufoLWCYf
         rAww==
X-Gm-Message-State: AOJu0YxZePQOezWEAMcz4hbanY3EpvY5nuhSd6VTtdqxBf8M0xxViahP
	AL+cU9Ie1xhqOiK+O3NlS/PyjLHkcyZs6yMIjrfvkiSvLC75utaZbM5fcMXJ6EwsRJ1cYIcO91I
	oiF4ulQ==
X-Google-Smtp-Source: AGHT+IG/8qUib6EF0PjJX+NoRkSXB8gbsqMcRdZ8AUUoQcnNgmIIpiwArIUlIzpqYFIxQig6GZ0gKA==
X-Received: by 2002:a05:622a:13cc:b0:440:2f78:37dd with SMTP id d75a77b69052e-440360f6dd5mr111523421cf.0.1717770426721;
        Fri, 07 Jun 2024 07:27:06 -0700 (PDT)
Received: from localhost (pool-68-160-141-91.bstnma.fios.verizon.net. [68.160.141.91])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7953286e1c1sm169556885a.53.2024.06.07.07.27.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 07:27:06 -0700 (PDT)
From: Mike Snitzer <snitzer@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Trond Myklebust <trondmy@hammerspace.com>,
	snitzer@hammerspace.com
Subject: [for-6.11 PATCH 12/29] nfs/flexfiles: check local DS when making DS connections
Date: Fri,  7 Jun 2024 10:26:29 -0400
Message-ID: <20240607142646.20924-13-snitzer@kernel.org>
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

From: Peng Tao <tao.peng@primarydata.com>

Do this by creating DS connection and check local IP address.
If it matches DS address (ignoring port), mark mirror_ds->local_ds
as true so that later we know if local DS IO is possible.

Signed-off-by: Peng Tao <tao.peng@primarydata.com>
Signed-off-by: Lance Shelton <lance.shelton@hammerspace.com>
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 fs/nfs/flexfilelayout/flexfilelayoutdev.c | 25 +++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/fs/nfs/flexfilelayout/flexfilelayoutdev.c b/fs/nfs/flexfilelayout/flexfilelayoutdev.c
index e028f5a0ef5f..af329d9b7d1e 100644
--- a/fs/nfs/flexfilelayout/flexfilelayoutdev.c
+++ b/fs/nfs/flexfilelayout/flexfilelayoutdev.c
@@ -348,6 +348,22 @@ ff_layout_init_mirror_ds(struct pnfs_layout_hdr *lo,
 	return false;
 }
 
+static bool ff_layout_ds_is_local(struct nfs4_pnfs_ds *ds)
+{
+	struct nfs_local_addr *addr;
+	struct sockaddr *sap;
+	struct nfs4_pnfs_ds_addr *da;
+
+	list_for_each_entry(da, &ds->ds_addrs, da_node) {
+		sap = (struct sockaddr *)&da->da_addr;
+		list_for_each_entry(addr, &ds->ds_clp->cl_local_addrs, cl_addrs)
+			if (rpc_cmp_addr((struct sockaddr *)&addr->address, sap))
+				return true;
+	}
+
+	return false;
+}
+
 /**
  * nfs4_ff_layout_prepare_ds - prepare a DS connection for an RPC call
  * @lseg: the layout segment we're operating on
@@ -395,6 +411,15 @@ nfs4_ff_layout_prepare_ds(struct pnfs_layout_segment *lseg,
 
 	/* connect success, check rsize/wsize limit */
 	if (!status) {
+		/*
+		 * ds_clp is put in destroy_ds().
+		 * keep ds_clp even if DS is local, so that if local IO cannot
+		 * proceed somehow, we can fall back to NFS whenever we want.
+		 */
+		if (ff_layout_ds_is_local(ds)) {
+			dprintk("%s: found local DS\n", __func__);
+			nfs_local_enable(ds->ds_clp);
+		}
 		max_payload =
 			nfs_block_size(rpc_max_payload(ds->ds_clp->cl_rpcclient),
 				       NULL);
-- 
2.44.0


