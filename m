Return-Path: <linux-nfs+bounces-2948-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C057A8AE80E
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Apr 2024 15:26:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CFFD286E85
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Apr 2024 13:26:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78592135A72;
	Tue, 23 Apr 2024 13:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mpubW2hW"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EDEE135A61;
	Tue, 23 Apr 2024 13:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713878762; cv=none; b=idVutmWyejwtCxtwlsAn16GsSQQ4tGPs99rLcMv2mHH6creId7NzfAXtNIZovAynSoh9TKWd1MF8njj6Y1bf3l8eWXSHQLz84rE1o8GGvMx6+9NLTNv4cN0mC9emSbRnfX/M7UUghaiJnP0MiJXGDiPPeCb7U8+4Nu8rUozpkZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713878762; c=relaxed/simple;
	bh=iUOGaXIug4vVksYxq6UGEyNm1YHFXKBHVAIoC3dovGs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l2BW3bZJ6f+rM5V+BQAUBZxSsxpl5hTckL7ad00M26eLfDvwbpdRkiKZ5fpZGMo774RVtiZyJsoMjJEVQ/dsdHD7g42xft5LjH+8/JMLS7PuCzr++kQncrweYeZwluwtp4TWuMMNVX4gPDw+6qUIgIWJMi6nvHYxnW4YBpiNHWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mpubW2hW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CE5FC116B1;
	Tue, 23 Apr 2024 13:26:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713878761;
	bh=iUOGaXIug4vVksYxq6UGEyNm1YHFXKBHVAIoC3dovGs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mpubW2hWMUv4A15ebPz2+bRWpD6pUqsHyNthHJ2Qrqk3gxmCq8OIf3B3gE+AFe7Zq
	 Euc5jcPB+925yk3wJlGL+IC+ftvvczO38mRNROtuoM3a6kEDWwFbxOe0AW8od3rUt7
	 QxktaJNcX/PgNHThNGKNvhRaNssusoKh6xC6B25yGvX93FiwvcNCE37PimrZLLXrcy
	 4qPYpjrfYlztRwwMYluQ7CROgeFsBZZncq6TEamH2abZDq0GoQA50cjtzVl7q/C42H
	 kRYltj45KJFyNgh+G+VH6Gc/h7CWEIf7QKQJXuiJOs69nXXlQBR9TyzlQhjzOAUo/P
	 OR5HG5J+lcgAA==
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: neilb@suse.de,
	lorenzo.bianconi@redhat.com,
	chuck.lever@oracle.com,
	netdev@vger.kernel.org,
	kuba@kernel.org,
	jlayton@kernel.org
Subject: [PATCH v9 1/7] NFSD: move nfsd_mutex handling into nfsd_svc callers
Date: Tue, 23 Apr 2024 15:25:38 +0200
Message-ID: <d0a814458af3d4f628db8ab305abc8ee2475ba38.1713878413.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1713878413.git.lorenzo@kernel.org>
References: <cover.1713878413.git.lorenzo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jeff Layton <jlayton@kernel.org>

Currently nfsd_svc holds the nfsd_mutex over the whole function. For
some of the later netlink patches though, we want to do some other
things to the server before starting it. Move the mutex handling into
the callers.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 fs/nfsd/nfsctl.c | 2 ++
 fs/nfsd/nfssvc.c | 4 ++--
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index 340c5d61f199..2fe78b802f98 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -404,7 +404,9 @@ static ssize_t write_threads(struct file *file, char *buf, size_t size)
 		if (newthreads < 0)
 			return -EINVAL;
 		trace_nfsd_ctl_threads(net, newthreads);
+		mutex_lock(&nfsd_mutex);
 		rv = nfsd_svc(newthreads, net, file->f_cred);
+		mutex_unlock(&nfsd_mutex);
 		if (rv < 0)
 			return rv;
 	} else
diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index c0d17b92b249..ca193f7ff0e1 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -775,7 +775,8 @@ nfsd_svc(int nrservs, struct net *net, const struct cred *cred)
 	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
 	struct svc_serv *serv;
 
-	mutex_lock(&nfsd_mutex);
+	lockdep_assert_held(&nfsd_mutex);
+
 	dprintk("nfsd: creating service\n");
 
 	nrservs = max(nrservs, 0);
@@ -804,7 +805,6 @@ nfsd_svc(int nrservs, struct net *net, const struct cred *cred)
 	if (serv->sv_nrthreads == 0)
 		nfsd_destroy_serv(net);
 out:
-	mutex_unlock(&nfsd_mutex);
 	return error;
 }
 
-- 
2.44.0


