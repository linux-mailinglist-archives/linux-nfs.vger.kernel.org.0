Return-Path: <linux-nfs+bounces-18806-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MOPDFLI8h2mTVQQAu9opvQ
	(envelope-from <linux-nfs+bounces-18806-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sat, 07 Feb 2026 14:22:58 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 873BF105F6A
	for <lists+linux-nfs@lfdr.de>; Sat, 07 Feb 2026 14:22:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1CF863019539
	for <lists+linux-nfs@lfdr.de>; Sat,  7 Feb 2026 13:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 963DF31195B;
	Sat,  7 Feb 2026 13:22:55 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 307EE1EFFB7
	for <linux-nfs@vger.kernel.org>; Sat,  7 Feb 2026 13:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770470575; cv=none; b=l2pEjffZFWepGFLnM5iUGYAvkAkSI4lSwjzCJ7rtyU2rVz0Ol+B2li4VP8oNNS6gCMBD9Bkvd+yXO7uuZYTGyY3+MW66NKIG4oPRvGgCRPEl0u3FWj+dXEoIJ8WR+sLWwhvZtb2P72ns2CPNMEf8wCkL9FBHqtH/jKJSKnVx9UE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770470575; c=relaxed/simple;
	bh=1RdEfCQsBBbZJTHLnVTBKEsKI51m9HDEiOZDwHZS3nk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uDF3K3H3loVtMMiykLAtEaC1pXJ9yh02bjIdc0bJtdn6AVY6YiRbGCUoxb0hhYLl9qxl3GEhaDvrCn/pnyWJPz+YbU8qILT+bm6n7yCDKx2KdloV2NVAWQUFbDiU7KXCL27I4Z1ogCJXwBU2Nh2Qc2dBjSRxO572V1Mwu+ie9G8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4832701b9b7so7727555e9.2
        for <linux-nfs@vger.kernel.org>; Sat, 07 Feb 2026 05:22:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770470573; x=1771075373;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zOTa0phnMlsLHnfgQJsochYV1FpMjR38iQmnoMePpyE=;
        b=WmZXFdx6PmVIMwaowiLmKPhjtN5eGYdxejEjrTV1odsPWF21vl/hN2L4vc+FgPWszj
         tFpOfOIkyblWgfuRmUrYloFiFHxJ7srUokCBfaMYY2anqyLHxaROZm2mAtAOd2cQdKRi
         6ijMax7CD7IPjH+0uHTtnuRSn9YYnQTgLkr2I9jjwsQUtjPO4IWr1KDjqLvEq2YqbTrH
         jDXQ/zNQf/eZBt8lKs4h/4zJTkHnTQiZUJ4tt7oglReyqQ5ZSYX6Sy7VezqXjqgiU3vv
         BoBrjWwMbLxNIrKN9Gk8lHeL75Jwk0MShV1Lz3kDvntuz4J5Hq7tX+pAd6zSFyJ1ySWu
         R3dw==
X-Gm-Message-State: AOJu0YyHqztuAGdFHJAAywdtfOiNAAlduqErFDM0B3tbp8qqxYo+InDO
	EdWLG5oxqnJaxbERFY+A8LfObkFhBf0/GTSw6eb6wMxYFB8GbaPVMEQoO591qQ==
X-Gm-Gg: AZuq6aLAnZBVzPR1keQMMfBmtPUF+SgbJvMF9M8jR95V/YckI4WBg414lZateItpEk5
	jBheUmE5abY4fkObz43PnkCeFUPlIycPn4BP2oUGw/BJ7oQNwD5T0NiHaPX9lFOd+UdRUdNkDnS
	WS1SlRVMx6GglhsGn+k2aBZ9FF6smkpmCXPUpzH4QKRMeu086QKVyioRcC6midHHfr6GGjCzFHa
	afClfPDVtHIDyImPAm91H1PMGqhTjWcnfaGX316u1f5wcjHuU4gcnjAOvJe/gEgFxrBwya43WyK
	cNk8Y94y/UxvBwV5WEyab3GLbOLnYmjnqs2+MzT8lacqp0FFzZMEUyVUNPuPTuKCQ3cqAzFdcIY
	D0zRaeybCFBPtS/bslQk8XkQJhsACFPbMzb1dK1mPbpNJjAfhv5pb7TcNCReSnABY8i9egh3Scv
	jbMwUdQMBQS/xAnDr2jrILBGqdAIzpKwniO6CA9T9vtg5gOntoZROkouZV
X-Received: by 2002:a05:600c:19c7:b0:45d:dc85:c009 with SMTP id 5b1f17b1804b1-483201e160dmr79177445e9.10.1770470573027;
        Sat, 07 Feb 2026 05:22:53 -0800 (PST)
Received: from vastdata-ubuntu2.vstd.int (89-138-75-89.bb.netvision.net.il. [89.138.75.89])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43637e31a01sm2619853f8f.27.2026.02.07.05.22.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Feb 2026 05:22:52 -0800 (PST)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nfs@vger.kernel.org
Cc: Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Trond Myklebust <trondmy@kernel.org>
Subject: [PATCH v2 RESEND] fs/nfs: Fix readdir slow-start regression
Date: Sat,  7 Feb 2026 15:22:50 +0200
Message-ID: <20260207132250.1543548-1-sagi@grimberg.me>
X-Mailer: git-send-email 2.43.0
Reply-To: sagi@grimberg.me
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18806-lists,linux-nfs=lfdr.de];
	DMARC_NA(0.00)[grimberg.me];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	HAS_REPLYTO(0.00)[sagi@grimberg.me];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sagi@grimberg.me,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.952];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	R_DKIM_NA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 873BF105F6A
X-Rspamd-Action: no action

Commit 580f236737d1 ("NFS: Adjust the amount of readahead
performed by NFS readdir") reduces the amount of readahead names
caching done by the client.

The downside of this approach is READDIR now may suffer from
a slow-start issue, where initially it will fetch names that fit
in a single page, then in 2, 4, 8 until the maximum supported
transfer size (usually 1M).

This patch tries to take a balanced approach between mitigating
the slow-start issue still maintaining some efficiency gains.

Fixes: 580f236737d1 ("NFS: Adjust the amount of readahead performed by NFS readdir")
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
Changes from v1:
- minor phrase
- added a Fixes tag

 fs/nfs/dir.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index ea9f6ca8f30f..514a2aadf612 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -72,7 +72,7 @@ const struct address_space_operations nfs_dir_aops = {
 	.free_folio = nfs_readdir_clear_array,
 };
 
-#define NFS_INIT_DTSIZE PAGE_SIZE
+#define NFS_INIT_DTSIZE SZ_64K
 
 static struct nfs_open_dir_context *
 alloc_nfs_open_dir_context(struct inode *dir)
@@ -83,7 +83,7 @@ alloc_nfs_open_dir_context(struct inode *dir)
 	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL_ACCOUNT);
 	if (ctx != NULL) {
 		ctx->attr_gencount = nfsi->attr_gencount;
-		ctx->dtsize = NFS_INIT_DTSIZE;
+		ctx->dtsize = min(NFS_SERVER(dir)->dtsize, NFS_INIT_DTSIZE);
 		spin_lock(&dir->i_lock);
 		if (list_empty(&nfsi->open_files) &&
 		    (nfsi->cache_validity & NFS_INO_DATA_INVAL_DEFER))
-- 
2.43.0


