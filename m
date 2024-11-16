Return-Path: <linux-nfs+bounces-8019-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 21D359CFC3B
	for <lists+linux-nfs@lfdr.de>; Sat, 16 Nov 2024 02:41:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CEB831F24D9E
	for <lists+linux-nfs@lfdr.de>; Sat, 16 Nov 2024 01:41:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A7D218FDDF;
	Sat, 16 Nov 2024 01:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VWAevZ1x"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 353E14C8F
	for <linux-nfs@vger.kernel.org>; Sat, 16 Nov 2024 01:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731721271; cv=none; b=de3sEqkt2Gipp4F9W/5IyRHxGS8kISgganekFMwTYEFwOgGBjzsMEkREtBJqUj1Zsvh7dUW9ZBV/4LeAcmrHsy4GTMAbSjnOKcv/IOGDGNpK8KCdjEQJ++Cj72Jg70W0dXFw4rk3vJytqCrNIrs7CAzN8Wo+4A4lCwveaNNmdEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731721271; c=relaxed/simple;
	bh=ZBYnj3Ea/NZBkZws315uRVwroPK4UE+L8kyLv7DOk9I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e+WTnSxDkGvns7CvZR9sJVEAC3OieVbUia38jRZtPmapyaAH9NKpwy/jpXK+Cc12VE6ZQzSzNCtx6xIIiuQBtqCCAc2Gky0EfAresbgO4YgxTjwbEpaypTDo/dIXD4kmXuQeGF9zTIRj/R8qUgsZqzuUpdfpeqaSik6GkP+OZeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VWAevZ1x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8705BC4CECF;
	Sat, 16 Nov 2024 01:41:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731721270;
	bh=ZBYnj3Ea/NZBkZws315uRVwroPK4UE+L8kyLv7DOk9I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VWAevZ1xs3BdDUKZ6LMTViMJonxlO7i91PPR747TJAzUVx490MI22bcqTEeliWqrD
	 bkBtmdN07MA/aSrVMiqMYnwm9jLvByT//OXfKoibTIELT4nSujkqUegO5fZUMDxo1t
	 6RmrK3tLVFpC2Gip9jD13usQlkpeSNKjixiCXYfO41qRHZchRt6ttGntW+Ga+oB/nK
	 4Rl3kHLWgGUQOxGPiuoyFJyyj0n+JXqFB2rd2cEjqtcI/s056CHxWIm5C4Por08HE+
	 PZqg/HWF8+j18d2gM9h6cm2cnPBcUP3ohy5cypJQCVXPZFfwh9SxnYHuCIm1VbQcIK
	 m1FJtE2xXkp3g==
From: Mike Snitzer <snitzer@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	NeilBrown <neilb@suse.de>
Subject: [for-6.13 PATCH v3 02/14] nfsd: add nfsd_file_{get,put} to 'nfs_to' nfsd_localio_operations
Date: Fri, 15 Nov 2024 20:40:54 -0500
Message-ID: <20241116014106.25456-3-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20241116014106.25456-1-snitzer@kernel.org>
References: <20241116014106.25456-1-snitzer@kernel.org>
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
index f441cb9f74d56..8beda4c851119 100644
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
index 9202f4b24343d..ab6a2a53f505f 100644
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


