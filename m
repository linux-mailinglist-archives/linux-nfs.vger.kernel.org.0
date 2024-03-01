Return-Path: <linux-nfs+bounces-2142-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28C4786E66F
	for <lists+linux-nfs@lfdr.de>; Fri,  1 Mar 2024 17:57:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 433121C25060
	for <lists+linux-nfs@lfdr.de>; Fri,  1 Mar 2024 16:57:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B88818813;
	Fri,  1 Mar 2024 16:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="jZEj3y2b"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 056A22A8D3
	for <linux-nfs@vger.kernel.org>; Fri,  1 Mar 2024 16:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709311833; cv=none; b=kes+tqyTEkyEi2CKFCzNhogM6sSAwds6QdnHpAHerhbis6nm69z/zG2uHAO6bBtQJWtPrxHgzhN05ldWY1p3/cic/B8dQkzCRxFGTPG/CEj6tFFHjbWRsAn39wN4HXG0jgj0S4LR2dhCXzF8GUEEa4MlKZgEV6fd6a5cCc/H0fU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709311833; c=relaxed/simple;
	bh=yftcKyL/oz6uIZDolKLRuLuoQYJm+aoeyxP8V1aESI0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iIocKVyCXKRCiA5gl0qRxR5wA/yxSgElQyfLOp/WcT20l9LsOGnUOXRYqeS1LSrwQ5AJV7BRmuxYLJShwX5hi+1uJ6qwna69n6+BAGIBvScut0FR0sxtU+PcHyOzBbv123VyC+xny40wJ53sT8XsbSHgIeB4/XWW3Kh4sd9N32A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=jZEj3y2b; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-787b4d1393aso132806285a.0
        for <linux-nfs@vger.kernel.org>; Fri, 01 Mar 2024 08:50:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1709311831; x=1709916631; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Sa6AgOZeK5IUkzPVQobze3jQHHSoiKW4C9wu8k4rjYA=;
        b=jZEj3y2bZgqi8Y+HwGQ4xpJxhev9D1vGqmvlrPDQ2JcP54Ak+qkPUvRQSDuB7Y3gB6
         UeIXDNLa288RrnwEeEdpEbWza++5L1BfWF1RFnh0nLMJl4Si5SiixxnogPBzWXvOSVcT
         edvr27qzmqTok803Zppw3cYCK5qBCGLRf9/SwgXbrdylqH3ac9t0B5Xm/K1NgyCskY3T
         C0k7tD+UnDR/+z2q0E6chjRTIXmVWcwD+yoY0F0VUFFfqPrQ6ZOy3s47I7XuJHFp8UZ5
         pavuBXaiXFtxsvqZmCulsFKZohapjtMkFF4hRenEueTiA+5O5JXXVyKCCSknZUaE4DuR
         FAXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709311831; x=1709916631;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sa6AgOZeK5IUkzPVQobze3jQHHSoiKW4C9wu8k4rjYA=;
        b=aTiJKCIwc2WMbqdYTjOBT/nJ/1Kz6NizJ+a4SoUxznWWw93rxofpChaVZOWHpGg9wB
         KuvHcCfOZC3/k0o9DIdEbBX3wkzMtAiUuwTb8lugA9jaQ+aTrjVy41IZStO32hjOpCzV
         c/CUQh1TCKBMKzS76ywqx2fCoQscek+/9kTIWewnPPu/kyRo2FS5rkt4JmpZ3xlROq1B
         9vD8eaHXdIHXgPhcp+1g0G/MHzdl1szVnVTXMZZ901HLJkY53j8xgwq6OPbKuN7tSTrc
         j6JxKUB/wf6SwKZs8BM2lYFpedI4EI4Z1kC4ZKIaOjy6XT+RYPEz7NEn8z/+YXiTsNoC
         EcvA==
X-Forwarded-Encrypted: i=1; AJvYcCVgCgQWQx9q6XUkk1pBH0NfF1Za8cYeQqfrKpyeBAIQd5etA48+BHbpgbvhVi2xbJJP447k83PbLalFoeBqS8rQCpnvUFRe5qWt
X-Gm-Message-State: AOJu0YxIhfqjlGFLoAz82M7ObncDUu5nZQbqjZtq2L96kzdirDx/4JzZ
	1oPN5lVjSNUh2bZT9Ozh0zuguV4EkCbmt15vphgV5jnDq5arb3PvPeEXOKUVUvoHHlbSwQnJs/q
	3
X-Google-Smtp-Source: AGHT+IHp94w9Ixzi420JrFZaq6O9FPqd2F78mS0E/b/8hWB7mm+QAh0z5iVj22q+g9WdohtZrsJJhw==
X-Received: by 2002:a05:620a:2a06:b0:788:f9c:9e79 with SMTP id o6-20020a05620a2a0600b007880f9c9e79mr1585106qkp.12.1709311830841;
        Fri, 01 Mar 2024 08:50:30 -0800 (PST)
Received: from localhost (076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id b6-20020a05620a04e600b00787f6064a9fsm1779317qkh.108.2024.03.01.08.50.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 08:50:30 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: trond.myklebust@hammerspace.com,
	anna@kernel.org,
	linux-nfs@vger.kernel.org
Subject: [PATCH 2/2] nfs: fix UAF in direct writes
Date: Fri,  1 Mar 2024 11:49:57 -0500
Message-ID: <d4a26214294fb967a6d828b8d750215f7a6e4897.1709311699.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1709311699.git.josef@toxicpanda.com>
References: <cover.1709311699.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In production we have been hitting the following warning consistently

------------[ cut here ]------------
refcount_t: underflow; use-after-free.
WARNING: CPU: 17 PID: 1800359 at lib/refcount.c:28 refcount_warn_saturate+0x9c/0xe0
Workqueue: nfsiod nfs_direct_write_schedule_work [nfs]
RIP: 0010:refcount_warn_saturate+0x9c/0xe0
PKRU: 55555554
Call Trace:
 <TASK>
 ? __warn+0x9f/0x130
 ? refcount_warn_saturate+0x9c/0xe0
 ? report_bug+0xcc/0x150
 ? handle_bug+0x3d/0x70
 ? exc_invalid_op+0x16/0x40
 ? asm_exc_invalid_op+0x16/0x20
 ? refcount_warn_saturate+0x9c/0xe0
 nfs_direct_write_schedule_work+0x237/0x250 [nfs]
 process_one_work+0x12f/0x4a0
 worker_thread+0x14e/0x3b0
 ? ZSTD_getCParams_internal+0x220/0x220
 kthread+0xdc/0x120
 ? __btf_name_valid+0xa0/0xa0
 ret_from_fork+0x1f/0x30

This is because we're completing the nfs_direct_request twice in a row.

The source of this is when we have our commit requests to submit, we
process them and send them off, and then in the completion path for the
commit requests we have

if (nfs_commit_end(cinfo.mds))
	nfs_direct_write_complete(dreq);

However since we're submitting asynchronous requests we sometimes have
one that completes before we submit the next one, so we end up calling
complete on the nfs_direct_request twice.

The only other place we use nfs_generic_commit_list() is in
__nfs_commit_inode, which wraps this call in a

nfs_commit_begin();
nfs_commit_end();

Which is a common pattern for this style of completion handling, one
that is also repeated in the direct code with get_dreq()/put_dreq()
calls around where we process events as well as in the completion paths.

Fix this by using the same pattern for the commit requests.

Before with my 200 node rocksdb stress running this warning would pop
every 10ish minutes.  With my patch the stress test has been running for
several hours without popping.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/nfs/direct.c        | 11 +++++++++--
 fs/nfs/write.c         |  2 +-
 include/linux/nfs_fs.h |  1 +
 3 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/fs/nfs/direct.c b/fs/nfs/direct.c
index befcc167e25f..6b8798d01e3a 100644
--- a/fs/nfs/direct.c
+++ b/fs/nfs/direct.c
@@ -672,10 +672,17 @@ static void nfs_direct_commit_schedule(struct nfs_direct_req *dreq)
 	LIST_HEAD(mds_list);
 
 	nfs_init_cinfo_from_dreq(&cinfo, dreq);
+	nfs_commit_begin(cinfo.mds);
 	nfs_scan_commit(dreq->inode, &mds_list, &cinfo);
 	res = nfs_generic_commit_list(dreq->inode, &mds_list, 0, &cinfo);
-	if (res < 0) /* res == -ENOMEM */
-		nfs_direct_write_reschedule(dreq);
+	if (res < 0) { /* res == -ENOMEM */
+		spin_lock(&dreq->lock);
+		if (dreq->flags == 0)
+			dreq->flags = NFS_ODIRECT_RESCHED_WRITES;
+		spin_unlock(&dreq->lock);
+	}
+	if (nfs_commit_end(cinfo.mds))
+		nfs_direct_write_complete(dreq);
 }
 
 static void nfs_direct_write_clear_reqs(struct nfs_direct_req *dreq)
diff --git a/fs/nfs/write.c b/fs/nfs/write.c
index bb79d3a886ae..5d9dc6c05325 100644
--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -1650,7 +1650,7 @@ static int wait_on_commit(struct nfs_mds_commit_info *cinfo)
 				       !atomic_read(&cinfo->rpcs_out));
 }
 
-static void nfs_commit_begin(struct nfs_mds_commit_info *cinfo)
+void nfs_commit_begin(struct nfs_mds_commit_info *cinfo)
 {
 	atomic_inc(&cinfo->rpcs_out);
 }
diff --git a/include/linux/nfs_fs.h b/include/linux/nfs_fs.h
index f5ce7b101146..d59116ac8209 100644
--- a/include/linux/nfs_fs.h
+++ b/include/linux/nfs_fs.h
@@ -611,6 +611,7 @@ int nfs_wb_folio_cancel(struct inode *inode, struct folio *folio);
 extern int  nfs_commit_inode(struct inode *, int);
 extern struct nfs_commit_data *nfs_commitdata_alloc(void);
 extern void nfs_commit_free(struct nfs_commit_data *data);
+void nfs_commit_begin(struct nfs_mds_commit_info *cinfo);
 bool nfs_commit_end(struct nfs_mds_commit_info *cinfo);
 
 static inline bool nfs_have_writebacks(const struct inode *inode)
-- 
2.43.0


