Return-Path: <linux-nfs+bounces-10170-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 28FE0A3A186
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Feb 2025 16:41:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3C423ACA38
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Feb 2025 15:39:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9C0326D5B2;
	Tue, 18 Feb 2025 15:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GJbC0T6+"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C613526D5CC
	for <linux-nfs@vger.kernel.org>; Tue, 18 Feb 2025 15:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739893182; cv=none; b=CkdoGs5aYpkC91N07DlTeml6YA0/4Z/9fP5H6cWRi/HaG04nLRTTHGzRVpPJVBLodSAsu4RnzfAoprC3OenicirrEdvbJopSgL6Vx8HgUqrVjcN5CeXrf3UR9EUnAS9utKLi4CVl0aQZu5rugw33t6ZZJ6OHahXRFRt2jVLgpXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739893182; c=relaxed/simple;
	bh=alovUlh+/Om5eQ5X07Twhxxns929XhQ8+5BWBHA5UqA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FGqs5f2k0hWwTUwNmmrWJ9/P+W9tQ6FzJBOi0QoRvVkuJPYJw6uTk8G5abRI5seB8wL7DP7ilemBtA454I6VvhdpDSFFL35Xo8gJFQInctTglDsa3bkvovEf2RlSJ1RFjKTvFW0+rrLMWpc6bWJFXY3YsEWf2OD99EgYJjoOsyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GJbC0T6+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7709C4CEEB;
	Tue, 18 Feb 2025 15:39:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739893182;
	bh=alovUlh+/Om5eQ5X07Twhxxns929XhQ8+5BWBHA5UqA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GJbC0T6+UGYPLj4MTCrfHFnuYFhqlXg/6Cw80KBjQsuOZiClOklmVHFOsDhwE7fa+
	 BCsIUK+Gunk57sR5WaejMfZX0DllIbUSO7auXjEaFyYGslNzlPQO5XbCu4//ZgEIw4
	 bo4eSErOvCbM/dti/k6nEtumt2Su9L/Qp0+0Uoc/WAlPw9iI6XBNHoW8Oz13Y/L/QI
	 ByVAFKGGUTc6gI6gOzHj3aeJcsSUJD9SXlP6PZsY9Q8qdojpzZFlXukw/c5DAqpJMU
	 GKhkTTbO1QWEUPLwIyvCf9OcVMMUvFXAVMcEVnXZ26UhLKjg0Qkt5s+SEttJEdxSba
	 plWh707eiDBcw==
From: cel@kernel.org
To: Neil Brown <neilb@suse.de>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Dave Chinner <david@fromorbit.com>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v2 2/7] NFSD: Re-organize nfsd_file_gc_worker()
Date: Tue, 18 Feb 2025 10:39:32 -0500
Message-ID: <20250218153937.6125-3-cel@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250218153937.6125-1-cel@kernel.org>
References: <20250218153937.6125-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

Dave opines:

IMO, there is no need to do this unnecessary work on every object
that is added to the LRU.  Changing the gc worker to always run
every 2s and check if it has work to do like so:

 static void
 nfsd_file_gc_worker(struct work_struct *work)
 {
-	nfsd_file_gc();
-	if (list_lru_count(&nfsd_file_lru))
-		nfsd_file_schedule_laundrette();
+	if (list_lru_count(&nfsd_file_lru))
+		nfsd_file_gc();
+	nfsd_file_schedule_laundrette();
 }

means that nfsd_file_gc() will be run the same way and have the same
behaviour as the current code. When the system it idle, it does a
list_lru_count() check every 2 seconds and goes back to sleep.
That's going to be pretty much unnoticable on most machines that run
NFS servers.

Suggested-by: Dave Chinner <david@fromorbit.com>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/filecache.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index 909b5bc72bd3..2933cba1e5f4 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -549,9 +549,9 @@ nfsd_file_gc(void)
 static void
 nfsd_file_gc_worker(struct work_struct *work)
 {
-	nfsd_file_gc();
+	nfsd_file_schedule_laundrette();
 	if (list_lru_count(&nfsd_file_lru))
-		nfsd_file_schedule_laundrette();
+		nfsd_file_gc();
 }
 
 static unsigned long
-- 
2.47.0


