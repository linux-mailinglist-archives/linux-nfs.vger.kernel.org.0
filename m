Return-Path: <linux-nfs+bounces-16666-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B232EC7C113
	for <lists+linux-nfs@lfdr.de>; Sat, 22 Nov 2025 02:03:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 38D85346466
	for <lists+linux-nfs@lfdr.de>; Sat, 22 Nov 2025 01:03:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42ED82BAF4;
	Sat, 22 Nov 2025 01:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="HboFs5cb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IbiOPC9d"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C866286417
	for <linux-nfs@vger.kernel.org>; Sat, 22 Nov 2025 01:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763773399; cv=none; b=XcHIbmWxchELSCAqiRVofrgmb2DCqMFXeDXiRjF1YPTn4tTbDv5Ac6nAqDVgLv1OKI5vjQvqVMb8iTFS0wLlV8WZntQyxtukcO0NgKdu7Sy8qaDEUzcEYVPk+kHbG1LrFdcy8cBccbVK88z3Ifumv+eW/FhOV8CLaIS4ycRzTtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763773399; c=relaxed/simple;
	bh=eRL4wMUrTpW/bYCs/NEIOCymAl5xGrAF5TUvKJdQzH8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g3fgd5/9/hqfygiBVlVHrNE+92JT682qd9iHFdNTNOuiK31n+JUu3z9vbkj41+P7tlNMbyDiJ/VRO9YdqcxIQJilqbKiLDjgqo4KV7RXrZfHw4LqTbUZEOlh2HIbrCJ0Hgb5ngcgv5iyJ3k+tUmZgPeMOiVpvp3ws7LCjwyaz1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=HboFs5cb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IbiOPC9d; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B3FC414001E8;
	Fri, 21 Nov 2025 20:03:16 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Fri, 21 Nov 2025 20:03:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm3; t=1763773396;
	 x=1763859796; bh=Vmy33QIVVOfnfJOF8i6e5HhGbksUwut2VOyC4mKMH9A=; b=
	HboFs5cbe6vb5oFqI7M0zg3392wGb30ukYcm1ANCFo/R9SwjyXBJIB5MqI62zj5p
	pShoeQL9PXgbnFxsxQyKeVyqCHxprnrukZiSwQNJzSotuULD5C6nD3m8NNKpm7ee
	Z0PTlYSYFjXNWGsUMxbVHBlGZX/6vnNJMN6YMbSHsnaf+M1KxGD85Ey2HS05xiD3
	IyUR/C398AIxhqBdAtlZ0/P6u3jAxn/m5qOK/LRmTvq9f5qKdwF3cUYyRB8Oy66P
	kCdRCBVVv/fe/qjyImAMdWJvFY+mPxShNHzJqEYJuX6q/x7xX5v70TFFXbvmgWC5
	RSPuc25hLoikNI48fp7UiQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1763773396; x=1763859796; bh=V
	my33QIVVOfnfJOF8i6e5HhGbksUwut2VOyC4mKMH9A=; b=IbiOPC9dAGFXacDds
	ITFdvIcMxjlc3V43EE3JPvnlUWoRxldG7ECiFllEzJj5TcCcr59eoZPpROTww1UP
	qgYk/Kf+jhPrzNvXLUi5ogvCXmpYU46E7nwb7J3QPFrQuk97y80gedHdbpDaiINg
	0lpqB1E3JPKwBAe1+IgdYHnsNM64HTGLqV7pDElBs29ncWfo3Idw2sYq+kb/qDU0
	zwOXFzlHTpwI9v5IEcRrXeyoAHy8yU44/v4/pOs5pXYzgHpzM2H5zf26bABSt29V
	mW874OcypFcJX5a+re7+Nha5I/eEqaXzTYX8ROe4OjsvbsDtlifylKeNZuMRzneu
	IlT3g==
X-ME-Sender: <xms:1AshaZIeFMPWC4KB6f1TQqNiJ40mSU1sZfX3K3n8rSqQxoRHov02wg>
    <xme:1AshaY1xEeVEY0liLTs56__kRqrmn9FjuByaRkZKs74PKaz0VMdlx6QaQRtEnYP8-
    QpRqsgn24vP9JJsk5jRIuSF03dSOos-gBRtSnm2wE_i2MlpkA>
X-ME-Received: <xmr:1AshabhhMXG03T4IMpr5dkRREJEkW8jIfseIL3GWpHkwaB7ht5i3U97Lx8L_HGNNiIvYLkezUdmweeCbnrXcCPbByWOXRrfcJquT6CLYVzd2>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvfedugeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgjfhhrggfgsedtkeertdertddtnecuhfhrohhmpefpvghilheu
    rhhofihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epveevkeffudeuvefhieeghffgudektdelkeejiedtjedugfeukedvkeffvdefvddunecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepnhgvihhlsg
    esohifnhhmrghilhdrnhgvthdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphho
    uhhtpdhrtghpthhtoheplhhinhhugidqnhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehtohhmsehtrghlphgvhidrtghomhdprhgtphhtthhopehokhhorhhn
    ihgvvhesrhgvughhrghtrdgtohhmpdhrtghpthhtoheptghhuhgtkhdrlhgvvhgvrhesoh
    hrrggtlhgvrdgtohhmpdhrtghpthhtohepuggrihdrnhhgohesohhrrggtlhgvrdgtohhm
    pdhrtghpthhtohepjhhlrgihthhonheskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:1AshaRVbXxn0AAGWDvMKZyQ1S8n-XDnuqk8zaM96Lm4iAvIURFlCNw>
    <xmx:1AshaSV1QA32Ad9SDXvLNaeHLW3PKXYTDmgULCzHDsn3bF9hwhkKvQ>
    <xmx:1AshaZg9_TDJG9pzoGsEskKjflJJy3T4cxox62Pb86ih7wLjZfu1rQ>
    <xmx:1AshaVZAUgdRVgefxS5GEBl1pgD90pakAqDFLHrKvV8dxRfly7WvUA>
    <xmx:1AshaSoaizti24glJaLFAF6tu2_d4JNU3BHrGoFrPBdG9kXgvpy3Dxz6>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 21 Nov 2025 20:03:14 -0500 (EST)
From: NeilBrown <neilb@ownmail.net>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org
Subject: [PATCH v2 2/2] locks: ensure vfs_test_lock() never returns FILE_LOCK_DEFERRED
Date: Sat, 22 Nov 2025 12:00:37 +1100
Message-ID: <20251122010253.3445570-3-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20251122010253.3445570-1-neilb@ownmail.net>
References: <20251122010253.3445570-1-neilb@ownmail.net>
Reply-To: NeilBrown <neil@brown.name>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: NeilBrown <neil@brown.name>

FILE_LOCK_DEFERRED can be returned when creating or removing a lock, but
not when testing for a lock.  This support was explicitly removed in
Commit 09802fd2a8ca ("lockd: rip out deferred lock handling from testlock codepath")

However the test in nlmsvc_testlock() suggests that it *can* be returned,
only nlm cannot handle it.

To aid clarity, remove the test and instead put a similar test and
warning in vfs_test_lock().  If the impossible happens, convert
FILE_LOCK_DEFERRED to -EIO.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/lockd/svclock.c |  4 ----
 fs/locks.c         | 17 ++++++++++++++---
 2 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/fs/lockd/svclock.c b/fs/lockd/svclock.c
index d66e82851599..dfd1a12b7887 100644
--- a/fs/lockd/svclock.c
+++ b/fs/lockd/svclock.c
@@ -635,10 +635,6 @@ nlmsvc_testlock(struct svc_rqst *rqstp, struct nlm_file *file,
 	conflock->fl.c.flc_owner = lock->fl.c.flc_owner;
 	error = vfs_test_lock(file->f_file[mode], &conflock->fl);
 	if (error) {
-		/* We can't currently deal with deferred test requests */
-		if (error == FILE_LOCK_DEFERRED)
-			WARN_ON_ONCE(1);
-
 		ret = nlm_lck_denied_nolocks;
 		goto out;
 	}
diff --git a/fs/locks.c b/fs/locks.c
index bf5e0d05a026..b5a3bb8790f3 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -2199,12 +2199,23 @@ SYSCALL_DEFINE2(flock, unsigned int, fd, unsigned int, cmd)
  */
 int vfs_test_lock(struct file *filp, struct file_lock *fl)
 {
+	int error = 0;
+
 	WARN_ON_ONCE(fl->fl_ops || fl->fl_lmops);
 	WARN_ON_ONCE(filp != fl->c.flc_file);
 	if (filp->f_op->lock)
-		return filp->f_op->lock(filp, F_GETLK, fl);
-	posix_test_lock(filp, fl);
-	return 0;
+		error = filp->f_op->lock(filp, F_GETLK, fl);
+	else
+		posix_test_lock(filp, fl);
+
+	/*
+	 * We don't expect FILE_LOCK_DEFERRED and callers cannot
+	 * handle it.
+	 */
+	if (WARN_ON_ONCE(error == FILE_LOCK_DEFERRED))
+		error = -EIO;
+
+	return error;
 }
 EXPORT_SYMBOL_GPL(vfs_test_lock);
 
-- 
2.50.0.107.gf914562f5916.dirty


