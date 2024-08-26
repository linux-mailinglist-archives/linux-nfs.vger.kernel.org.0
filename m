Return-Path: <linux-nfs+bounces-5765-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 723DC95F48C
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Aug 2024 17:07:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 154BF282966
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Aug 2024 15:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70B0B13B286;
	Mon, 26 Aug 2024 15:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c+6Ba1iN"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 494A31E892;
	Mon, 26 Aug 2024 15:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724684836; cv=none; b=P42DdYZubNCaa89gJCv5/CM56/s09gJIf+UPz0bVRkLTvG4oanWcKQMlD5+Rim/kfCUf9k42ANcTrA9/yiZ8QM3y9XOEXrGEp1cf3uy9PJ8/goiOf+rtQx5MHO4iXlsUfZSR9Iihcmn0hVfVcocyesVxqqrCm6/GQIzBmR7krXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724684836; c=relaxed/simple;
	bh=AZj3YNOJX/H2yzVlv7P38vsSXbzbZ4ihmsnOm8GVBqk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D6N1zs9IQU2dTgBm/mJZ7lrRYJx0kS98fpvjoxMpG+89Pz7p/mXm0NhKwG+2CbcwaoET9ZFtTS1gc9UlDf/Ewx2u/jWUqK3Qjk/W9JYfyCYjgudFm6tW01PZNlO04C7ZrwqqjD2/SUJb2j2+G0JNuZTZUqFJgVNd+/vxl00sfag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c+6Ba1iN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D64BC4FF18;
	Mon, 26 Aug 2024 15:07:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724684835;
	bh=AZj3YNOJX/H2yzVlv7P38vsSXbzbZ4ihmsnOm8GVBqk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=c+6Ba1iNZNqdVNUbp0viIZ2sJUKeS4mgEv4bIYaQGjU3FBdZ9Pic3kBluQegskXqm
	 930myzFov3TGJycTZ+SMuSV83BtMV9FoMUBFayTgNKUcTVscEpoar1zBZE27svKovk
	 I5J4QEXfsLMqyglJ/rUQBDjFNJxeqau7K+qmgfYlKnZCMyCmFxgJdIW/hO5ps30+UQ
	 pwt89FhE5GTQOuFiBAWxRNJj8IwGQJb/hjePZ14amzSrLgZG722W4BlosX/L0WchRQ
	 Lm6eKcEtBFuasqhdcweT/G0Smw/oGdK93gJ4aqWdnrn+kWNBQK9uDsAJs5athGb8P2
	 EBLmXXkz0ykVA==
From: cel@kernel.org
To: <stable@vger.kernel.org>
Cc: <linux-nfs@vger.kernel.org>,
	lilingfeng3@huawei.com,
	NeilBrown <neilb@suse.de>
Subject: [PATCH 6.1.y 1/7] nfsd: Simplify code around svc_exit_thread() call in nfsd()
Date: Mon, 26 Aug 2024 11:06:57 -0400
Message-ID: <20240826150703.13987-2-cel@kernel.org>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240826150703.13987-1-cel@kernel.org>
References: <20240826150703.13987-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: NeilBrown <neilb@suse.de>

[ Upstream commit 18e4cf915543257eae2925671934937163f5639b ]

Previously a thread could exit asynchronously (due to a signal) so some
care was needed to hold nfsd_mutex over the last svc_put() call.  Now a
thread can only exit when svc_set_num_threads() is called, and this is
always called under nfsd_mutex.  So no care is needed.

Not only is the mutex held when a thread exits now, but the svc refcount
is elevated, so the svc_put() in svc_exit_thread() will never be a final
put, so the mutex isn't even needed at this point in the code.

Signed-off-by: NeilBrown <neilb@suse.de>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfssvc.c           | 23 -----------------------
 include/linux/sunrpc/svc.h | 13 -------------
 2 files changed, 36 deletions(-)

diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index 9eb529969b22..3e120633ec86 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -983,31 +983,8 @@ nfsd(void *vrqstp)
 	atomic_dec(&nfsd_th_cnt);
 
 out:
-	/* Take an extra ref so that the svc_put in svc_exit_thread()
-	 * doesn't call svc_destroy()
-	 */
-	svc_get(nn->nfsd_serv);
-
 	/* Release the thread */
 	svc_exit_thread(rqstp);
-
-	/* We need to drop a ref, but may not drop the last reference
-	 * without holding nfsd_mutex, and we cannot wait for nfsd_mutex as that
-	 * could deadlock with nfsd_shutdown_threads() waiting for us.
-	 * So three options are:
-	 * - drop a non-final reference,
-	 * - get the mutex without waiting
-	 * - sleep briefly andd try the above again
-	 */
-	while (!svc_put_not_last(nn->nfsd_serv)) {
-		if (mutex_trylock(&nfsd_mutex)) {
-			nfsd_put(net);
-			mutex_unlock(&nfsd_mutex);
-			break;
-		}
-		msleep(20);
-	}
-
 	return 0;
 }
 
diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
index 912da376ef9b..49621cc4e01b 100644
--- a/include/linux/sunrpc/svc.h
+++ b/include/linux/sunrpc/svc.h
@@ -123,19 +123,6 @@ static inline void svc_put(struct svc_serv *serv)
 	kref_put(&serv->sv_refcnt, svc_destroy);
 }
 
-/**
- * svc_put_not_last - decrement non-final reference count on SUNRPC serv
- * @serv:  the svc_serv to have count decremented
- *
- * Returns: %true is refcount was decremented.
- *
- * If the refcount is 1, it is not decremented and instead failure is reported.
- */
-static inline bool svc_put_not_last(struct svc_serv *serv)
-{
-	return refcount_dec_not_one(&serv->sv_refcnt.refcount);
-}
-
 /*
  * Maximum payload size supported by a kernel RPC server.
  * This is use to determine the max number of pages nfsd is
-- 
2.45.1


