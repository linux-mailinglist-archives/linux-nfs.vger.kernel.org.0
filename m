Return-Path: <linux-nfs+bounces-16726-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55ACDC882CA
	for <lists+linux-nfs@lfdr.de>; Wed, 26 Nov 2025 06:41:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13C943B321C
	for <lists+linux-nfs@lfdr.de>; Wed, 26 Nov 2025 05:41:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44FDD347DD;
	Wed, 26 Nov 2025 05:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TahFNRri"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 187D04C9D;
	Wed, 26 Nov 2025 05:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764135693; cv=none; b=RjSWrNC/ymukB0mtql/fGnvfSwPqNn3F/llq0sIx09wUTwQhKzfMjlH6U7CcAjmfQIFvznQY3Tq7929e/QErpbr6904eYDLNfbIU5s3hr5YUfUZU4ArO2+dsyB1p/FvCeAsLtlEH1pmORH0XnVoTo9yodFCGO2wMv+D031jCkBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764135693; c=relaxed/simple;
	bh=GMXu/4I7zzQgm+L6w7tz8iBYxeVA2h+/HGxG6IsCMB4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TqqD6SHknyP8UPItUKUKGBykKS3EtBTAKEvgweBZZvTJmSdwPdnPmwEh/+S/AwlfECFzlijq3con0N8FdE9rrZD+eM3jNVu28a3gCASFZcjWWA4co4ArXP9XORorEBZ0O3b6UVYZN7f6QhG7E+6cQISflHgFJ6IV4T9Rhfdq+hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TahFNRri; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53D02C113D0;
	Wed, 26 Nov 2025 05:41:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764135692;
	bh=GMXu/4I7zzQgm+L6w7tz8iBYxeVA2h+/HGxG6IsCMB4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TahFNRrixa1ahnAx5yvZIRY6cqyUo0Sj/jW1lxpYn7a1SpZtu9ygTQ4juSRuMrQQv
	 jhQjSmpJZIi40yjGVFQcK6r5gD7Tw7zYH9XIy9gopBZ5hgGrVXTWZPkzAsskus6h4I
	 jP4s/8L/kvP/nsJlPtPBTnNW5D8UgvEUm6kJwtmTZQAdAtetF9o83phjNr2R4c8qF7
	 ri1uy57Kl9TiFmLqCdbq0aYSMDhiQDVMWyfJeOLHvCiC8D+rK1RJ68oYxqlxMS/nKD
	 BOLC/LKbAtKcRtIHRDuBsSw6s546ZNQJkPOOnxb1y2LhofIlVYKTIxcap/cUczFO7V
	 vm4GrzCUVC7Yw==
Date: Wed, 26 Nov 2025 00:41:31 -0500
From: Mike Snitzer <snitzer@kernel.org>
To: Zorro Lang <zlang@redhat.com>, anna@kernel.org
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] nfs/localio: fix regression due to out-of-order __put_cred
 [was: Re: [Bug][xfstests crash on nfs] kernel BUG at kernel/cred.c:104!]
Message-ID: <aSaTC51DkxEqQkrZ@kernel.org>
References: <20251125144508.rxepvtwrubbuhzxs@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251125144508.rxepvtwrubbuhzxs@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>

Commit 86855311c117 ("nfs/localio: add refcounting for each iocb IO
associated with NFS pgio header") inadvertantly reintroduced the same
potential for __put_cred() triggering BUG_ON(cred == current->cred)
that commit 992203a1fba5 ("nfs/localio: restore creds before releasing
pageio data") fixed.

Fix this by saving and restoring the cred around each {read,write}_iter 
call within the respective for loop of nfs_local_call_{read,write}.

Reported-by: Zorro Lang <zlang@redhat.com>
Fixes: 86855311c117 ("nfs/localio: add refcounting for each iocb IO associated with NFS pgio header")
Signed-off-by: Mike Snitzer <snitzer@kernel.org>

diff --git a/fs/nfs/localio.c b/fs/nfs/localio.c
index 6461ce3ba9a4..eeb05a0d8d26 100644
--- a/fs/nfs/localio.c
+++ b/fs/nfs/localio.c
@@ -623,8 +623,6 @@ static void nfs_local_call_read(struct work_struct *work)
 	ssize_t status;
 	int n_iters;
 
-	save_cred = override_creds(filp->f_cred);
-
 	n_iters = atomic_read(&iocb->n_iters);
 	for (int i = 0; i < n_iters ; i++) {
 		if (iocb->iter_is_dio_aligned[i]) {
@@ -637,7 +635,10 @@ static void nfs_local_call_read(struct work_struct *work)
 		} else
 			iocb->kiocb.ki_flags &= ~IOCB_DIRECT;
 
+		save_cred = override_creds(filp->f_cred);
 		status = filp->f_op->read_iter(&iocb->kiocb, &iocb->iters[i]);
+		revert_creds(save_cred);
+
 		if (status != -EIOCBQUEUED) {
 			if (unlikely(status >= 0 && status < iocb->iters[i].count))
 				force_done = true; /* Partial read */
@@ -647,8 +648,6 @@ static void nfs_local_call_read(struct work_struct *work)
 			}
 		}
 	}
-
-	revert_creds(save_cred);
 }
 
 static int
@@ -830,7 +829,6 @@ static void nfs_local_call_write(struct work_struct *work)
 	int n_iters;
 
 	current->flags |= PF_LOCAL_THROTTLE | PF_MEMALLOC_NOIO;
-	save_cred = override_creds(filp->f_cred);
 
 	file_start_write(filp);
 	n_iters = atomic_read(&iocb->n_iters);
@@ -845,7 +843,10 @@ static void nfs_local_call_write(struct work_struct *work)
 		} else
 			iocb->kiocb.ki_flags &= ~IOCB_DIRECT;
 
+		save_cred = override_creds(filp->f_cred);
 		status = filp->f_op->write_iter(&iocb->kiocb, &iocb->iters[i]);
+		revert_creds(save_cred);
+
 		if (status != -EIOCBQUEUED) {
 			if (unlikely(status >= 0 && status < iocb->iters[i].count))
 				force_done = true; /* Partial write */
@@ -857,7 +858,6 @@ static void nfs_local_call_write(struct work_struct *work)
 	}
 	file_end_write(filp);
 
-	revert_creds(save_cred);
 	current->flags = old_flags;
 }
 

