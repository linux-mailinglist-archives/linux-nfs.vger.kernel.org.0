Return-Path: <linux-nfs+bounces-8890-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45F24A00230
	for <lists+linux-nfs@lfdr.de>; Fri,  3 Jan 2025 02:00:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 702B87A1AD8
	for <lists+linux-nfs@lfdr.de>; Fri,  3 Jan 2025 01:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F69D155322;
	Fri,  3 Jan 2025 01:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V3PvtClL"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8411154BF0
	for <linux-nfs@vger.kernel.org>; Fri,  3 Jan 2025 01:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735866006; cv=none; b=lwCWqMA7BFaNBVcCJD8jWIy1EVQE8n7VJ7I3KA1zVHo3/OpF63YY4beXVXVn5txevVvCj8LpIBYH4C7K7My+jAIwrvxOwWoXdzZSreePOV3cuvbXNl+lGpLLNJNm6SW5NKxa06uGNM2QaxOP7R7WSw/oCqSA3SvGVj4EVg6wg4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735866006; c=relaxed/simple;
	bh=7corJfirsBEpEr7KZsy2vGiur1pNPia2m+YxI+yeYNc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uURTdmKDyoLBsuyotPzt9FXLGQtuRcEumrIIJoF7Z3GKvv/M8f3wOMuAyEX2CQyBekr9/O4vabOyAEhkGomM//Qwpa3WVvu04NKjYvgWUL3zlH2W17Bo1ekc0IlfjRbbmNTCf2uH+jd1uDVvNiLw4srv83HoLLDhxwx1KMR2Ul4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V3PvtClL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2D00C4CEDE;
	Fri,  3 Jan 2025 01:00:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735866006;
	bh=7corJfirsBEpEr7KZsy2vGiur1pNPia2m+YxI+yeYNc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=V3PvtClLWjkGSoaUaffuNJ8buRP4oBcTabzwTQZPH3IGMKahJxSiRGtk+sGwhA4eJ
	 3G7Jjfhwf8se8aPe8KBED7QNqiGHeVqNDxmaKhSNu2s8Ml4iXacjuLUwWH9AcKEw0q
	 aTczvkkX95hsQ/ksfTVu98fxFAiCcwXsDZgqaMc1EAIImnNO7cYJ50s/2MVwitBDE1
	 0BM877J/7JaG5vQXmwFpf9rHU0Njjv46vHykgiOk484CA9o82pciMPvhOysBiOfyec
	 8ZIFtBf9wbnIP2VUNXzE4zWvrRHU1UHTqb2RzoNFOzdfa4CvadNw8PCARbJJpiu9AJ
	 uZjN/xnNV+vuQ==
From: cel@kernel.org
To: Neil Brown <neilb@suse.de>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH v1 2/2] NFSD: Change the filecache laundrette workqueue again
Date: Thu,  2 Jan 2025 20:00:02 -0500
Message-ID: <20250103010002.619062-2-cel@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250103010002.619062-1-cel@kernel.org>
References: <20250103010002.619062-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

Youzhong Yang <youzhong@gmail.com> noticed the workqueue subsystem
complaining about how long the filecache laundrette was running.
This resulted in switching from using the system_wq for the
laundrette to system_unbound_wq (see commit 4b84551a35e3 ("nfsd: use
system_unbound_wq for nfsd_file_gc_worker()").

However, I've seen the laundrette running for multiple milliseconds
on some workloads, delaying other work. For the purpose of
scheduling fairness, perhaps a better choice would be to process
filecache disposal queues on the system_long_wq instead.

Cc: Tejun Heo <tj@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/filecache.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index a1cdba42c4fa..91a535c2dede 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -112,7 +112,7 @@ static void
 nfsd_file_schedule_laundrette(void)
 {
 	if (test_bit(NFSD_FILE_CACHE_UP, &nfsd_file_flags))
-		queue_delayed_work(system_unbound_wq, &nfsd_filecache_laundrette,
+		queue_delayed_work(system_long_wq, &nfsd_filecache_laundrette,
 				   NFSD_LAUNDRETTE_DELAY);
 }
 
-- 
2.47.0


