Return-Path: <linux-nfs+bounces-7800-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 66DE39C282B
	for <lists+linux-nfs@lfdr.de>; Sat,  9 Nov 2024 00:40:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B2501C21C99
	for <lists+linux-nfs@lfdr.de>; Fri,  8 Nov 2024 23:40:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAC961F427F;
	Fri,  8 Nov 2024 23:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rZvHOBIu"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 869E61F26E0
	for <linux-nfs@vger.kernel.org>; Fri,  8 Nov 2024 23:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731109215; cv=none; b=G8Bu4/gFUkHgDa45epWQISUp4Py5GVgWLErOmbGKqPdep3m8iGA+zD4SjH95dLT7Tk4co/iE1ogqzdp4jLEopxE0RZDB4/I5vdd2Ov+jf/qeMbXZTEczFn6VqNEtW5Wy3jft5kTqvrHExQp/zzaHz6KZM3xPQDZXRiy0Lp36yQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731109215; c=relaxed/simple;
	bh=h0SS3CCZHoeqzEPK7IHmjOFtaoS+rIdOsWwUD7Uufg4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OnUnOrNqxrgz/4/Dd5ySVFCUSWKoHk2NXFTSDgAEqVJW09yhD6X3NUmAzbQHjIUs64MFoukJT/jxl1J21758sb5Fp5Mc+uMb12wSgMxZtTi7EkN1gwhYMpHEu+DYw1W91CTPV0qaSFl/jt62imdw5PKI9Hfls8dmVghn6VogcIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rZvHOBIu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB853C4CECE;
	Fri,  8 Nov 2024 23:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731109215;
	bh=h0SS3CCZHoeqzEPK7IHmjOFtaoS+rIdOsWwUD7Uufg4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rZvHOBIun7gLLes/t5kMLmTMPYHf0e1iytmspv3sntCFMrpdWsCTJrOSVhXvfcb7l
	 j7YHBAxgVuDA07yUlc844hTIqz4B0rcbXxCFAcOX0OHa2hg8gPom5BO9UyvvoXG7Wv
	 tKyWABfU5GdguEXBQ4a5JABy54RztlIhmzLLDLw0KpLZnQne7oVEn0WGCNpIuxcv5o
	 QpaSCB4e2GmdTppmLSGEqoWN05+gZaPynkN0RJw2Yy3hBeuCnOzn9xhyG1s8GqPEwZ
	 V0v+jy2gw5+Fq2/6z6QVD6GCC5ZeG9qC4FVJVl9P/+5tzWHp4kEI41mSKm22KLBexg
	 dh04Bur+9fDQA==
From: Mike Snitzer <snitzer@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	NeilBrown <neilb@suse.de>
Subject: [for-6.13 PATCH 08/19] nfsd: add nfsd_file_{get,put} to 'nfs_to' nfsd_localio_operations
Date: Fri,  8 Nov 2024 18:39:51 -0500
Message-ID: <20241108234002.16392-9-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20241108234002.16392-1-snitzer@kernel.org>
References: <20241108234002.16392-1-snitzer@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In later a commit LOCALIO must call both nfsd_file_get and
nfsd_file_put to manage extra nfsd_file references.

Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 fs/nfsd/localio.c          | 2 ++
 include/linux/nfslocalio.h | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/fs/nfsd/localio.c b/fs/nfsd/localio.c
index f441cb9f74d5..8beda4c85111 100644
--- a/fs/nfsd/localio.c
+++ b/fs/nfsd/localio.c
@@ -29,6 +29,8 @@ static const struct nfsd_localio_operations nfsd_localio_ops = {
 	.nfsd_serv_put  = nfsd_serv_put,
 	.nfsd_open_local_fh = nfsd_open_local_fh,
 	.nfsd_file_put_local = nfsd_file_put_local,
+	.nfsd_file_get = nfsd_file_get,
+	.nfsd_file_put = nfsd_file_put,
 	.nfsd_file_file = nfsd_file_file,
 };
 
diff --git a/include/linux/nfslocalio.h b/include/linux/nfslocalio.h
index 9202f4b24343..ab6a2a53f505 100644
--- a/include/linux/nfslocalio.h
+++ b/include/linux/nfslocalio.h
@@ -56,6 +56,8 @@ struct nfsd_localio_operations {
 						const struct nfs_fh *,
 						const fmode_t);
 	struct net *(*nfsd_file_put_local)(struct nfsd_file *);
+	struct nfsd_file *(*nfsd_file_get)(struct nfsd_file *);
+	void (*nfsd_file_put)(struct nfsd_file *);
 	struct file *(*nfsd_file_file)(struct nfsd_file *);
 } ____cacheline_aligned;
 
-- 
2.44.0


