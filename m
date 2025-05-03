Return-Path: <linux-nfs+bounces-11402-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A4198AA814A
	for <lists+linux-nfs@lfdr.de>; Sat,  3 May 2025 17:14:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C9EB1B62823
	for <lists+linux-nfs@lfdr.de>; Sat,  3 May 2025 15:14:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FC7227D76E;
	Sat,  3 May 2025 15:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uJaUBmal"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E969C27D763;
	Sat,  3 May 2025 15:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746285118; cv=none; b=MmJJhzEtLDMLoIgSpBfjO/NPt89tQmSnjHUv7Ntxnayp5jPtOleoxQjOM/jdcPK0gwrsPwNEnYJRF/ZxbN8ko9mOT673l+husVE7VF3OoUr4Y5/oA6ICJQANTXNpkDTrL8FHCVr3c/o79ND01QtdJdcGqOvE+bYJzdHZEWHOUCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746285118; c=relaxed/simple;
	bh=9luchfh6AMC5aL2zTK4oqgHlT+RnVvkuNrxdfqwhWP4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nMzoVj7nRO5Zoqo8OZqEcC42X/MSWEB4t0kMcn570ueUQlpQd8Ti8QI/S+Xa2IJIi5m16cztReTkNjpKLqmI2jRqP9xtXgRHuBfj4aMEIESF0XvAGATohZS06xv4X8LdzoqyVyZp9SMYuaDoX2FKhS7i2Vd/2gC178U9OQ85138=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uJaUBmal; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C7EBC4CEE9;
	Sat,  3 May 2025 15:11:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746285117;
	bh=9luchfh6AMC5aL2zTK4oqgHlT+RnVvkuNrxdfqwhWP4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=uJaUBmalFM2PKb+Kf0vey1PZLUxjORCbkjE23waINw7ml8BzGGp9xNBi1ca3vUc5i
	 /B8eQpD5v5xkvi7QbZM5rxNkaQyiQ/l8WxE7lsJf2aOYkhbgF/Dp0Ny1l/j5QGdfIn
	 /rqFDP8Rr3IEb9njvEyGLcHC+lHPCyvmDERE2KgPwF7oB2Jhd/9gAoLtGhWQAIbOUa
	 mxYOY9fk01MoAOdAJcLe2Ss/O+l5i7eQ8My4vuBHwbP+BBErQOqXdWf2VMRFX3cMV3
	 ow0/3Lp0bVECAQTge/pgLvsFCQ8OH0LMll5Tz6iicjuCJ+9mDD/7Soygjm4DmIIUoH
	 rlHrxsYAAizCQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Sat, 03 May 2025 11:11:28 -0400
Subject: [PATCH v3 12/17] nfsd: remove old v2/3 SYMLINK dprintks
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250503-nfsd-tracepoints-v3-12-d89f445969af@kernel.org>
References: <20250503-nfsd-tracepoints-v3-0-d89f445969af@kernel.org>
In-Reply-To: <20250503-nfsd-tracepoints-v3-0-d89f445969af@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>, NeilBrown <neil@brown.name>
Cc: Sargun Dillon <sargun@sargun.me>, linux-nfs@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1304; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=9luchfh6AMC5aL2zTK4oqgHlT+RnVvkuNrxdfqwhWP4=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBoFjIu0RpHqddncWGcrvfP0piHcAZuO5bKthk1L
 v0SIkTPCHOJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaBYyLgAKCRAADmhBGVaC
 Fc4lD/9TtEeo9cxD1CvZ6IPzR9jQrksJD7/2uoaalyEhQnS8YRCrbY00YDA0Oak7lZOG0/wfasF
 zMwWarn49vIfuyvWSyQVd5P6vRw9Fa+djtgI/PHuLNlB7q0pBPGnGl8OesVtILRIupoesfd4Ikz
 bdso/EC+9LAf8pSTmlSoWo7LN1X+7ztm/eSwVy27t2bHePxMynsKTQV7DJpMADxqR9uewHdMLv4
 8VxwUMS64FDvRt2lGLksL5CVnnCyFDpQX1YVL9evwKqhpTfQfZhf6xA45j9QKrul3buE8sJbQf8
 OsIYFCZvv5qhRWKZGPWv1/nGCbFwRuAUxl+Djw7QIm7fZtF0W9LWvz+sZoH31VMoVvR0RHNE1Dw
 OY+itX34wtq4YnPNVmoJs6G82frTXB/m8p+ehvHfN/HSVuDhKsAMKjLKu0CeQKQkBtF7JiytrA/
 nEd63tPfmplAOa+erkD4g3HieOA44Iip5UKzsTsZDg9Ya/S9ROcXq68JJnVraWOaiuOIpzKZ1Dq
 aRdgitYCftjaR/kR0YtxgDHMarqJB4a82yDysq/fxiBN20vklVEG/9thExwWfNWjOV8oxjOL8KK
 W0EHm6YHCzwBvutP69bv0I+kGyB5lu2SK4uG1M8tLKsM9RA0zz0Iqmw2eoLiAObB04xc7PGC2jA
 fNXfEPuC+wqO4JA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs3proc.c | 5 -----
 fs/nfsd/nfsproc.c  | 4 ----
 2 files changed, 9 deletions(-)

diff --git a/fs/nfsd/nfs3proc.c b/fs/nfsd/nfs3proc.c
index 215d60b5b5e0386942d28432e66069ee6f960e0d..237bd102e4ce13b0461d27dd6f72219ae3802082 100644
--- a/fs/nfsd/nfs3proc.c
+++ b/fs/nfsd/nfs3proc.c
@@ -440,11 +440,6 @@ nfsd3_proc_symlink(struct svc_rqst *rqstp)
 		goto out;
 	}
 
-	dprintk("nfsd: SYMLINK(3)  %s %.*s -> %.*s\n",
-				SVCFH_fmt(&argp->ffh),
-				argp->flen, argp->fname,
-				argp->tlen, argp->tname);
-
 	fh_copy(&resp->dirfh, &argp->ffh);
 	fh_init(&resp->fh, NFS3_FHSIZE);
 	resp->status = nfsd_symlink(rqstp, &resp->dirfh, argp->fname,
diff --git a/fs/nfsd/nfsproc.c b/fs/nfsd/nfsproc.c
index 5e93e17b94d4de0382f9038b4600938bb6a699c2..27c4022dd75c498cc46dc734d10d7da3736b5079 100644
--- a/fs/nfsd/nfsproc.c
+++ b/fs/nfsd/nfsproc.c
@@ -519,10 +519,6 @@ nfsd_proc_symlink(struct svc_rqst *rqstp)
 		goto out;
 	}
 
-	dprintk("nfsd: SYMLINK  %s %.*s -> %.*s\n",
-		SVCFH_fmt(&argp->ffh), argp->flen, argp->fname,
-		argp->tlen, argp->tname);
-
 	fh_init(&newfh, NFS_FHSIZE);
 	resp->status = nfsd_symlink(rqstp, &argp->ffh, argp->fname, argp->flen,
 				    argp->tname, &attrs, &newfh);

-- 
2.49.0


