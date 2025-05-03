Return-Path: <linux-nfs+bounces-11422-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA192AA8289
	for <lists+linux-nfs@lfdr.de>; Sat,  3 May 2025 22:02:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3552D189F83F
	for <lists+linux-nfs@lfdr.de>; Sat,  3 May 2025 20:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB4322820BE;
	Sat,  3 May 2025 19:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qakcm/7a"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2AF32820B8;
	Sat,  3 May 2025 19:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746302394; cv=none; b=fyr7tcgqRnr5XQ/NOHQkNgt8/AWenK/bH8bck1HSXeekGMfGrzZb8I9SMtIo+jZiu+Zr+8wiQluReYuqFaBilUpZ7VpJKvvXJHS3bu7T7sVrkPcPLyYO0f3aBqnoJL6OxzF4EIBYxUuLhDpu9K8a1wmX7gBq9iUDi0Hs39jUt2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746302394; c=relaxed/simple;
	bh=hXJpa8SOENSd84UvNO/LlV+Wj+S1H3eee9wa5eQWBmM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q5qKG6l6r/nU9xpY1/F+CfVKT86DLiUc2WOz71+ZofGVseCydKXwJF7lXaCHb1Lczzv9G2+pY4wR7ITdQU1G249qjpqdFMvJn3BY8PVTyhxBbtQV70aSSmp0ezRE8NPgyyq160/gY6Eaev/HBnEWMtcbZzxqwBbumfV/ffPLiig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qakcm/7a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C291FC4CEEF;
	Sat,  3 May 2025 19:59:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746302394;
	bh=hXJpa8SOENSd84UvNO/LlV+Wj+S1H3eee9wa5eQWBmM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Qakcm/7ap110weZv79I9oAWDD2FfDBoIJdGyACJEvXwM5a3ZdQH1rhSVN8t5Oq4yH
	 XIZu4ceL3c729QGDBpp+0an/ZcLyvM1Dwht2oIhkr7VM6zBAs2bkOlyvHWxhUeEkbr
	 2SV/wl7u8YTgb1KhrE/h73A912CkU4Ss0sNqrn4qMLBByOySF2v+OcD3Wp7ouhmBT9
	 0u+45wfzQ++sFRPZM3AWFG+YSfVDGDtxWrbC6ekcOw3fqZhqD6kQ4AFgXlISQm/fq+
	 mGPWLb/FcR+dI1ry6/WjmL/er/eEEq/IGuVqtH75QjJGn7P5ZM1p9jTRHBHjiCv2GD
	 ea6MwS3W/hDsA==
From: cel@kernel.org
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Anna Schumaker <anna@kernel.org>
Cc: sargun@sargun.me,
	<linux-nfs@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v4 14/18] nfsd: remove old LINK dprintks
Date: Sat,  3 May 2025 15:59:32 -0400
Message-ID: <20250503195936.5083-15-cel@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250503195936.5083-1-cel@kernel.org>
References: <20250503195936.5083-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jeff Layton <jlayton@kernel.org>

Observability here is now covered by static tracepoints.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs3proc.c | 7 -------
 fs/nfsd/nfsproc.c  | 7 -------
 2 files changed, 14 deletions(-)

diff --git a/fs/nfsd/nfs3proc.c b/fs/nfsd/nfs3proc.c
index f207fba722eb..ebf9bcac9e7f 100644
--- a/fs/nfsd/nfs3proc.c
+++ b/fs/nfsd/nfs3proc.c
@@ -559,13 +559,6 @@ nfsd3_proc_link(struct svc_rqst *rqstp)
 	struct nfsd3_linkargs *argp = rqstp->rq_argp;
 	struct nfsd3_linkres  *resp = rqstp->rq_resp;
 
-	dprintk("nfsd: LINK(3)     %s ->\n",
-				SVCFH_fmt(&argp->ffh));
-	dprintk("nfsd:   -> %s %.*s\n",
-				SVCFH_fmt(&argp->tfh),
-				argp->tlen,
-				argp->tname);
-
 	fh_copy(&resp->fh,  &argp->ffh);
 	fh_copy(&resp->tfh, &argp->tfh);
 	resp->status = nfsd_link(rqstp, &resp->tfh, argp->tname, argp->tlen,
diff --git a/fs/nfsd/nfsproc.c b/fs/nfsd/nfsproc.c
index a12ad08b000a..6636fd075ca8 100644
--- a/fs/nfsd/nfsproc.c
+++ b/fs/nfsd/nfsproc.c
@@ -481,13 +481,6 @@ nfsd_proc_link(struct svc_rqst *rqstp)
 	struct nfsd_linkargs *argp = rqstp->rq_argp;
 	struct nfsd_stat *resp = rqstp->rq_resp;
 
-	dprintk("nfsd: LINK     %s ->\n",
-		SVCFH_fmt(&argp->ffh));
-	dprintk("nfsd:    %s %.*s\n",
-		SVCFH_fmt(&argp->tfh),
-		argp->tlen,
-		argp->tname);
-
 	resp->status = nfsd_link(rqstp, &argp->tfh, argp->tname, argp->tlen,
 				 &argp->ffh);
 	fh_put(&argp->ffh);
-- 
2.49.0


