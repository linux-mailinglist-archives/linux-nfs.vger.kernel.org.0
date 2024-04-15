Return-Path: <linux-nfs+bounces-2821-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 923668A5B86
	for <lists+linux-nfs@lfdr.de>; Mon, 15 Apr 2024 21:51:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22DF9B242F2
	for <lists+linux-nfs@lfdr.de>; Mon, 15 Apr 2024 19:51:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D65415B551;
	Mon, 15 Apr 2024 19:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TUJc0mkx"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9E7415B54F;
	Mon, 15 Apr 2024 19:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713210311; cv=none; b=Ez2oXov68DUSqpZn/ePnMxZdVmmGBb3mJz6pQUnHccd6WJ2/DIdFFaprU31qmYnEWPYDiXdRJjo1hRybtjpqJ+769bJ0pptOr4Sg8xEimJ9J4H2ZUeRRowpEvDkJyAZHH9z8FVkfUR5XcIuR+Fkns3gwmvZwWeBZsHZ1EZUDiEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713210311; c=relaxed/simple;
	bh=VeCGfQJrB1Z6yM2TCJpvnNTk1N6tpO2H3HeUgSVZWC0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MwhFzNGPLxqCFKxRokdvC+he5klwJgL4+E1jEDy00YWey+oDc/AJHEH2OVGbyYBv8I9sUh71zB6QdyLc4ecRNeG7av7MUyyQuymfUGV1iUiv9ybLXdQv9gAuelSMHtGP5iJuusmqJEXW+xXQvXeHOiqqXtIvFYbjU0JMtTTRvYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TUJc0mkx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31D4BC113CC;
	Mon, 15 Apr 2024 19:45:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713210310;
	bh=VeCGfQJrB1Z6yM2TCJpvnNTk1N6tpO2H3HeUgSVZWC0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TUJc0mkx9p7TA7/66cMoNEmPKNdCVvb/Pa7SSHg6zZCtHWHtiNXH25ZlU63fsfB0Y
	 WRc3aE9X0ws/K7nD7h8kc1DOELWjdqypHpFJ6VrPkUrJJJl7JsW5IbJA09IVvZG04k
	 DcGz3gzIyAW7slmvDUmFgvNVZvwi9Edgg2dVHVrKyM9pRwiw4pDQbAxUfV1AdrFjYm
	 mxXAELYvNBdo45o5PsaXdd6+9oi/JH2ZNZ3n5dwgoCtvbSzDyxP7axYCjJXF/7xv1P
	 kwsbBrwXMaBF8Stxe3zMX+r3TENYY5+4APWL3oWTya0ANpd8N0hDB/zvryueShDxXi
	 3AJBCcZfrcieA==
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: lorenzo.bianconi@redhat.com,
	chuck.lever@oracle.com,
	neilb@suse.de,
	netdev@vger.kernel.org,
	kuba@kernel.org,
	jlayton@kernel.org
Subject: [PATCH v8 1/6] nfsd: move nfsd_mutex handling into nfsd_svc callers
Date: Mon, 15 Apr 2024 21:44:34 +0200
Message-ID: <2c5ff2829a27f29dd8a912fc9f62fbf214195e73.1713209938.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1713209938.git.lorenzo@kernel.org>
References: <cover.1713209938.git.lorenzo@kernel.org>
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
index 93c87587e646..f2e442d7fe16 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -406,7 +406,9 @@ static ssize_t write_threads(struct file *file, char *buf, size_t size)
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


