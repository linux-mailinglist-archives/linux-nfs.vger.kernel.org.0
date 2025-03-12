Return-Path: <linux-nfs+bounces-10558-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C3BEA5D49D
	for <lists+linux-nfs@lfdr.de>; Wed, 12 Mar 2025 04:06:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBB1F178AA7
	for <lists+linux-nfs@lfdr.de>; Wed, 12 Mar 2025 03:06:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F64018DF6E;
	Wed, 12 Mar 2025 03:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ajmvnD03"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0944214A62B
	for <linux-nfs@vger.kernel.org>; Wed, 12 Mar 2025 03:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741748803; cv=none; b=W7Qn4VBDpcsM5NGz1TkqIQGDzM2XGexRFt/SwRQ54gPWq6lk+i7h14Z+z6b55txHBuXMdaLgUEzu3hTF2g2gtRZKJVxCNW+YCCGhBUQ3RjZSej7gY6XpJiHRs3FeIPcMg0F2wd8AOaBJtu2yAXI+SJR39nbUqHgXOiYQQ1kSy5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741748803; c=relaxed/simple;
	bh=Sez8AsfMQhAjEhrPguhSYm6Qe8GbYyAVOTAtsD5aIak=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gFAtVHsSSw84ueUJiQrk6brPQ5bGDDkiG6/learmdff7vw/f7i4rw6E/bIjFn0MQipkpEqhpLeBKdqP5l98K+lbrKWL7to/MdUNm54HjMXkCGqaoVSSAbIcUtF05F0TOckuLCc3riLqP5LZdXed2ZeWjoEgEeuxaa9U0PmyPBOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ajmvnD03; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2BCAC4CEE9;
	Wed, 12 Mar 2025 03:06:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741748801;
	bh=Sez8AsfMQhAjEhrPguhSYm6Qe8GbYyAVOTAtsD5aIak=;
	h=From:To:Cc:Subject:Date:From;
	b=ajmvnD03XgyMCxyLLsnr+MDPjU+JOMn4wN5SncBW3Scv6r1yfD9gh0s+XHO/XTdQm
	 fRTAonknjI0rRdG/c141vYHzj58D5n+RLbvki7J1hSSo1DET/3AOoXrqBcjyXGo/2Y
	 tQlWpVG4aN1x3hARW20hWwLEtpIvAPa+f/69shgp8EEzUl2hUgbG0bDjAvFFMTh8y7
	 2/RM0lS7UGC69GmhhTDjGu55iFLB6h8zg94irdxNuLOY38EVOqfc2ylJxSRFLOTZss
	 fdpCz4AaDU9CwxOjnMLL4aZdXxgutUExZ7a2K0BWujgjPgzd8BoNocO6RGNiGOhBuj
	 e+5rsqinRGbDg==
From: cel@kernel.org
To: Neil Brown <neilb@suse.de>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [RFC PATCH] NFSD: Add a Kconfig setting to enable delegated timestamps
Date: Tue, 11 Mar 2025 23:06:38 -0400
Message-ID: <20250312030638.960830-1-cel@kernel.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

After three tries, we still see test failures with delegated
timestamps. Disable them by default, but leave the implementation
intact so that development can continue.

X-Cc: stable@vger.kernel.org # v6.14
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/Kconfig     | 12 +++++++++++-
 fs/nfsd/nfs4state.c | 16 ++++++++++++++--
 2 files changed, 25 insertions(+), 3 deletions(-)

This compiles. Initial testing shows that tests that were previously
failing are now passing. I would like to include this in v6.15, but
I will give it a little more time in nfsd-testing.

diff --git a/fs/nfsd/Kconfig b/fs/nfsd/Kconfig
index c0bd1509ccd4..792d3fed1b45 100644
--- a/fs/nfsd/Kconfig
+++ b/fs/nfsd/Kconfig
@@ -172,6 +172,16 @@ config NFSD_LEGACY_CLIENT_TRACKING
 	  recoverydir, or spawn a process directly using a usermodehelper
 	  upcall.
 
-	  These legacy client tracking methods have proven to be probelmatic
+	  These legacy client tracking methods have proven to be problematic
 	  and will be removed in the future. Say Y here if you need support
 	  for them in the interim.
+
+config NFSD_V4_DELEG_TIMESTAMPS
+	bool "Support delegated timestamps"
+	depends on NFSD_V4
+	default n
+	help
+	  NFSD implements delegated timestamps according to
+	  draft-ietf-nfsv4-delstid-08 "Extending the Opening of Files". This
+	  is currently an experimental feature and is therefore left disabled
+	  by default.
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 2da700635955..2bd63594d8da 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -5948,11 +5948,23 @@ nfsd4_verify_setuid_write(struct nfsd4_open *open, struct nfsd_file *nf)
 	return 0;
 }
 
+#ifdef CONFIG_NFSD_V4_DELEG_TIMESTAMPS
+static bool nfsd4_want_deleg_timestamps(const struct nfsd4_open *open)
+{
+	return open->op_deleg_want & OPEN4_SHARE_ACCESS_WANT_DELEG_TIMESTAMPS;
+}
+#else /* CONFIG_NFSD_V4_DELEG_TIMESTAMPS */
+static bool nfsd4_want_deleg_timestamps(const struct nfsd4_open *open)
+{
+	return false;
+}
+#endif /* CONFIG NFSD_V4_DELEG_TIMESTAMPS */
+
 static struct nfs4_delegation *
 nfs4_set_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
 		    struct svc_fh *parent)
 {
-	bool deleg_ts = open->op_deleg_want & OPEN4_SHARE_ACCESS_WANT_DELEG_TIMESTAMPS;
+	bool deleg_ts = nfsd4_want_deleg_timestamps(open);
 	struct nfs4_client *clp = stp->st_stid.sc_client;
 	struct nfs4_file *fp = stp->st_stid.sc_file;
 	struct nfs4_clnt_odstate *odstate = stp->st_clnt_odstate;
@@ -6193,8 +6205,8 @@ nfs4_open_delegation(struct svc_rqst *rqstp, struct nfsd4_open *open,
 		     struct nfs4_ol_stateid *stp, struct svc_fh *currentfh,
 		     struct svc_fh *fh)
 {
-	bool deleg_ts = open->op_deleg_want & OPEN4_SHARE_ACCESS_WANT_DELEG_TIMESTAMPS;
 	struct nfs4_openowner *oo = openowner(stp->st_stateowner);
+	bool deleg_ts = nfsd4_want_deleg_timestamps(open);
 	struct nfs4_client *clp = stp->st_stid.sc_client;
 	struct svc_fh *parent = NULL;
 	struct nfs4_delegation *dp;
-- 
2.48.1


