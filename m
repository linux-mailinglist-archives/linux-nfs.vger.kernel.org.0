Return-Path: <linux-nfs+bounces-3738-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E1698906349
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Jun 2024 07:07:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E58C1F235FA
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Jun 2024 05:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E631013440E;
	Thu, 13 Jun 2024 05:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YCQ1ldwu"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B3E1133406
	for <linux-nfs@vger.kernel.org>; Thu, 13 Jun 2024 05:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718255233; cv=none; b=NF1zHZBXjX7APjxyb7YuEwWEdsidhrhMYdbqrTvLFfJhL62QE/fzYD3fDbkq/2fDBtt6fKXxlYjZVQkb7raZeUi/Ui74EY6qCppUSsSzsjr9vAV6oFBHPzASIz6bEseHSya3mHYynh4xpXBbwS1g8n38YoV4wz1BeuCteNZRaeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718255233; c=relaxed/simple;
	bh=kRGIw9Uo9z620W/i9ejpmqh8kfzjQtYpREdpQFJpWrE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FS17HvY3hJd58vZmpoSfCNRFHStCv1x86l9J0u21YxAm/USN+lKos5jEyPInJ7uuG3wEbLwYmD4bkDnQ0L3uUiM7Sgeg5fHuMH9trNpuP7V83zXlACthgUnGOCtAKdBEZa5ujVAnZnCQtfbqQuPAsR71fiuWk3dyhRkA95xqahQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YCQ1ldwu; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-6312f1f83d9so1611067b3.2
        for <linux-nfs@vger.kernel.org>; Wed, 12 Jun 2024 22:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718255231; x=1718860031; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e0plCIfkUm6ngCoLGe2L1FwABR/YpxSwIuegH/uFftM=;
        b=YCQ1ldwud+kjpyluVjYl6W/7fRG40+wHM3UV4nvF90MUw1/WNIdBlE8GqtPdVYgd5q
         /gZHdJwM65OTraCMKnuPRln3sz91qSFWK6kjQ4AoADBcRQfN3BdXwkCKtPg2txGe+PrV
         fFfrIOipjLg5gkyl+yrBPSZaD/6KPdK9yfqAx/CADrxJBOpV7GgIvSZBnIsxNO5ahTqE
         oRKKV4ZoA+OV8DxcfAQQxRVMe3BJM26moGdYYlGy4SZ1y5moJ99lI8dL0U8bmbx/cVIl
         mXsep0Md20xPisJwPhKjmucvNcqhIC4BOgR8DV8OIisjtRVzgvVQwYXaquP773Wnwb7Q
         SAsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718255231; x=1718860031;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e0plCIfkUm6ngCoLGe2L1FwABR/YpxSwIuegH/uFftM=;
        b=Hf/n9IylGn1Aj/wcwhOhCCSjO7LENUmxfCone/gPhjSBgOuBY3TlTlNK+k6vWpKgsm
         OLESQpp2lDlQAJZHnbmnjmZkf6+kvWEITK9qodBdXyX24CVE2LZ6sJ/1K5CP+WnbMtko
         04DQybsjnGA/myYmbPyhmAUccjrhfNhEgux5LMZtHXzTBEtnfAQAbm9qKstcTMrVVNEz
         Mh6w7XSduPCMVSGhbAE4Buq1FvLmMwiA6/AgOa2c2tx1uIovlxrl820aXVRDDuw5qfUL
         0+UV74IGSvud6uILLP/DpcG2nAQsIiSMgGFzjPHC+u7nGTteCT2L0OEOoxZuWOlcHiCn
         8e/g==
X-Gm-Message-State: AOJu0YwKWe5ZQnm1eW+svyXcsAYou0MLbvBJmx11sK4ru8ByUtzh3EdY
	M27qbPSLkrJ1yE5gMC1pyNdNmyenz7trTKuiOsvfp4bKGvly+nVBY9xI
X-Google-Smtp-Source: AGHT+IErbKUmcw4BDgxvZKRFL+rUk8UcpvN5asY+zqEaRI2FJrjyZibTUoLr3YBXqSQdGI+IQB47WQ==
X-Received: by 2002:a0d:eac8:0:b0:630:8c74:eab8 with SMTP id 00721157ae682-6308c74eb4cmr22736627b3.42.1718255230543;
        Wed, 12 Jun 2024 22:07:10 -0700 (PDT)
Received: from leira.trondhjem.org (c-68-40-188-158.hsd1.mi.comcast.net. [68.40.188.158])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b2a5ed4527sm3079036d6.101.2024.06.12.22.07.09
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 22:07:09 -0700 (PDT)
From: trondmy@gmail.com
X-Google-Original-From: trond.myklebust@hammerspace.com
To: linux-nfs@vger.kernel.org
Subject: [PATCH 09/11] NFSv4/pnfs: Give nfs4_proc_layoutreturn() a flags argument
Date: Thu, 13 Jun 2024 01:00:53 -0400
Message-ID: <20240613050055.854323-10-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240613050055.854323-9-trond.myklebust@hammerspace.com>
References: <20240613050055.854323-1-trond.myklebust@hammerspace.com>
 <20240613050055.854323-2-trond.myklebust@hammerspace.com>
 <20240613050055.854323-3-trond.myklebust@hammerspace.com>
 <20240613050055.854323-4-trond.myklebust@hammerspace.com>
 <20240613050055.854323-5-trond.myklebust@hammerspace.com>
 <20240613050055.854323-6-trond.myklebust@hammerspace.com>
 <20240613050055.854323-7-trond.myklebust@hammerspace.com>
 <20240613050055.854323-8-trond.myklebust@hammerspace.com>
 <20240613050055.854323-9-trond.myklebust@hammerspace.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Trond Myklebust <trond.myklebust@hammerspace.com>

Replace the boolean in nfs4_proc_layoutreturn() with a set of flags that
will allow us to craft a version that is appropriate for reboot
recovery.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/nfs4proc.c |  8 +++++---
 fs/nfs/pnfs.c     | 18 +++++++++++-------
 fs/nfs/pnfs.h     |  6 +++++-
 3 files changed, 21 insertions(+), 11 deletions(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 952d1e930185..8d237cf15a03 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -10019,7 +10019,7 @@ static const struct rpc_call_ops nfs4_layoutreturn_call_ops = {
 	.rpc_release = nfs4_layoutreturn_release,
 };
 
-int nfs4_proc_layoutreturn(struct nfs4_layoutreturn *lrp, bool sync)
+int nfs4_proc_layoutreturn(struct nfs4_layoutreturn *lrp, unsigned int flags)
 {
 	struct rpc_task *task;
 	struct rpc_message msg = {
@@ -10042,7 +10042,7 @@ int nfs4_proc_layoutreturn(struct nfs4_layoutreturn *lrp, bool sync)
 			&task_setup_data.rpc_client, &msg);
 
 	lrp->inode = nfs_igrab_and_active(lrp->args.inode);
-	if (!sync) {
+	if (flags & PNFS_FL_LAYOUTRETURN_ASYNC) {
 		if (!lrp->inode) {
 			nfs4_layoutreturn_release(lrp);
 			return -EAGAIN;
@@ -10050,6 +10050,8 @@ int nfs4_proc_layoutreturn(struct nfs4_layoutreturn *lrp, bool sync)
 		task_setup_data.flags |= RPC_TASK_ASYNC;
 	}
 	if (!lrp->inode)
+		flags |= PNFS_FL_LAYOUTRETURN_PRIVILEGED;
+	if (flags & PNFS_FL_LAYOUTRETURN_PRIVILEGED)
 		nfs4_init_sequence(&lrp->args.seq_args, &lrp->res.seq_res, 1,
 				   1);
 	else
@@ -10058,7 +10060,7 @@ int nfs4_proc_layoutreturn(struct nfs4_layoutreturn *lrp, bool sync)
 	task = rpc_run_task(&task_setup_data);
 	if (IS_ERR(task))
 		return PTR_ERR(task);
-	if (sync)
+	if (!(flags & PNFS_FL_LAYOUTRETURN_ASYNC))
 		status = task->tk_status;
 	trace_nfs4_layoutreturn(lrp->args.inode, &lrp->args.stateid, status);
 	dprintk("<-- %s status=%d\n", __func__, status);
diff --git a/fs/nfs/pnfs.c b/fs/nfs/pnfs.c
index 04a52fa3d28c..c482088cb485 100644
--- a/fs/nfs/pnfs.c
+++ b/fs/nfs/pnfs.c
@@ -1279,7 +1279,7 @@ pnfs_send_layoutreturn(struct pnfs_layout_hdr *lo,
 		       const nfs4_stateid *stateid,
 		       const struct cred **pcred,
 		       enum pnfs_iomode iomode,
-		       bool sync)
+		       unsigned int flags)
 {
 	struct inode *ino = lo->plh_inode;
 	struct pnfs_layoutdriver_type *ld = NFS_SERVER(ino)->pnfs_curr_ld;
@@ -1306,7 +1306,7 @@ pnfs_send_layoutreturn(struct pnfs_layout_hdr *lo,
 	if (ld->prepare_layoutreturn)
 		ld->prepare_layoutreturn(&lrp->args);
 
-	status = nfs4_proc_layoutreturn(lrp, sync);
+	status = nfs4_proc_layoutreturn(lrp, flags);
 out:
 	dprintk("<-- %s status: %d\n", __func__, status);
 	return status;
@@ -1340,7 +1340,8 @@ static void pnfs_layoutreturn_before_put_layout_hdr(struct pnfs_layout_hdr *lo)
 		spin_unlock(&inode->i_lock);
 		if (send) {
 			/* Send an async layoutreturn so we dont deadlock */
-			pnfs_send_layoutreturn(lo, &stateid, &cred, iomode, false);
+			pnfs_send_layoutreturn(lo, &stateid, &cred, iomode,
+					       PNFS_FL_LAYOUTRETURN_ASYNC);
 		}
 	} else
 		spin_unlock(&inode->i_lock);
@@ -1407,7 +1408,8 @@ _pnfs_return_layout(struct inode *ino)
 	send = pnfs_prepare_layoutreturn(lo, &stateid, &cred, NULL);
 	spin_unlock(&ino->i_lock);
 	if (send)
-		status = pnfs_send_layoutreturn(lo, &stateid, &cred, IOMODE_ANY, true);
+		status = pnfs_send_layoutreturn(lo, &stateid, &cred, IOMODE_ANY,
+						0);
 out_wait_layoutreturn:
 	wait_on_bit(&lo->plh_flags, NFS_LAYOUT_RETURN, TASK_UNINTERRUPTIBLE);
 out_put_layout_hdr:
@@ -1548,7 +1550,7 @@ bool pnfs_roc(struct inode *ino,
 		return true;
 	}
 	if (layoutreturn)
-		pnfs_send_layoutreturn(lo, &stateid, &lc_cred, iomode, true);
+		pnfs_send_layoutreturn(lo, &stateid, &lc_cred, iomode, 0);
 	pnfs_put_layout_hdr(lo);
 	return false;
 }
@@ -2595,7 +2597,8 @@ pnfs_mark_layout_for_return(struct inode *inode,
 		return_now = pnfs_prepare_layoutreturn(lo, &stateid, &cred, &iomode);
 		spin_unlock(&inode->i_lock);
 		if (return_now)
-			pnfs_send_layoutreturn(lo, &stateid, &cred, iomode, false);
+			pnfs_send_layoutreturn(lo, &stateid, &cred, iomode,
+					       PNFS_FL_LAYOUTRETURN_ASYNC);
 	} else {
 		spin_unlock(&inode->i_lock);
 		nfs_commit_inode(inode, 0);
@@ -2711,7 +2714,8 @@ static int pnfs_layout_return_unused_byserver(struct nfs_server *server,
 		}
 		spin_unlock(&inode->i_lock);
 		rcu_read_unlock();
-		pnfs_send_layoutreturn(lo, &stateid, &cred, iomode, false);
+		pnfs_send_layoutreturn(lo, &stateid, &cred, iomode,
+				       PNFS_FL_LAYOUTRETURN_ASYNC);
 		pnfs_put_layout_hdr(lo);
 		cond_resched();
 		goto restart;
diff --git a/fs/nfs/pnfs.h b/fs/nfs/pnfs.h
index cd23a38eac75..d192feb346b4 100644
--- a/fs/nfs/pnfs.h
+++ b/fs/nfs/pnfs.h
@@ -248,6 +248,9 @@ extern const struct pnfs_layoutdriver_type *pnfs_find_layoutdriver(u32 id);
 extern void pnfs_put_layoutdriver(const struct pnfs_layoutdriver_type *ld);
 
 /* nfs4proc.c */
+#define PNFS_FL_LAYOUTRETURN_ASYNC (1U << 0)
+#define PNFS_FL_LAYOUTRETURN_PRIVILEGED (1U << 1)
+
 extern size_t max_response_pages(struct nfs_server *server);
 extern int nfs4_proc_getdeviceinfo(struct nfs_server *server,
 				   struct pnfs_device *dev,
@@ -255,7 +258,8 @@ extern int nfs4_proc_getdeviceinfo(struct nfs_server *server,
 extern struct pnfs_layout_segment *
 nfs4_proc_layoutget(struct nfs4_layoutget *lgp,
 		    struct nfs4_exception *exception);
-extern int nfs4_proc_layoutreturn(struct nfs4_layoutreturn *lrp, bool sync);
+extern int nfs4_proc_layoutreturn(struct nfs4_layoutreturn *lrp,
+				  unsigned int flags);
 
 /* pnfs.c */
 void pnfs_get_layout_hdr(struct pnfs_layout_hdr *lo);
-- 
2.45.2


