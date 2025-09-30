Return-Path: <linux-nfs+bounces-14810-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7D79BAD241
	for <lists+linux-nfs@lfdr.de>; Tue, 30 Sep 2025 16:05:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CC8F17EE61
	for <lists+linux-nfs@lfdr.de>; Tue, 30 Sep 2025 14:05:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC27223D7D2;
	Tue, 30 Sep 2025 14:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RaPHDO0m"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 867EC1F03C5
	for <linux-nfs@vger.kernel.org>; Tue, 30 Sep 2025 14:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759241123; cv=none; b=eMQlmLzlMa9EsLKNG58FheuGStQrqFqsE8Kauw6SSHuU+R6d//75OXEQJmoQoPTRzf1T2x10VK69GjLcltWNt7dmtIbEOY73SVu6g7dezshXCVwkyc33cgveIVSlzINd1wXggnyJ9QlpL1ANEdQ6Nwyfoq7cI45F1wwMLIIKBeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759241123; c=relaxed/simple;
	bh=l3LW9LRbbhbg0J2OyI+NerY6Ej54MoiYDpYiid1gbz4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TiGLB8gx5eMz7ScB+BpJPS0MH2fj4RJngKNz9mq8dL1PxY2XQQoSegtyQHfoo8v+4/jM9ur8T0czCKKjf8EFQAjT76r1glW4mjMVAOSC+riT0mdZgpOuLYi58Kc7xO3IOWPpV//qqRi5yKTjb5etIH7VLll91ln4bF0wXiy5L64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RaPHDO0m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73832C4CEF0;
	Tue, 30 Sep 2025 14:05:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759241123;
	bh=l3LW9LRbbhbg0J2OyI+NerY6Ej54MoiYDpYiid1gbz4=;
	h=From:To:Cc:Subject:Date:From;
	b=RaPHDO0mPc8428CATXcGllSayvzSS0yD0PSr/OgRZFSyUWomTbc6hAK3U14U4tHBg
	 EPckHBKoJrUqqvZrvQYzaZn7fhUn0k4dy+gnZ2m4uLlMMEdFq78V21XeUFoSrcqde2
	 7u+qCF08mewCDl/y3gciTPhbjwJ96o+5FXB5I2vSFE6/6jWxIS34gi+AGHVJ1LzQ0S
	 tTh/PfFYURhjz08dqLycIpDd4J1SQA57U262dYUFvDAjGvoSN3i+R3xavc+ZlJDfuN
	 MUcqgl40BK5sE7Ludhp4WdE99RWTY3WI6KxNjkoRrxAa3eKwMpB3xsPlRkalw+WbY6
	 iEay4b7hmyv1Q==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v1] NFSD: Fix crash in nfsd4_read_release()
Date: Tue, 30 Sep 2025 10:05:20 -0400
Message-ID: <20250930140520.2947-1-cel@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

When tracing is enabled, the trace_nfsd_read_done trace point
crashes during the pynfs read.testNoFh test.

Fixes: 87c5942e8fae ("nfsd: Add I/O trace points in the NFSv4 read proc")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4proc.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index e466cf52d7d7..f9aeefc0da73 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -988,10 +988,11 @@ nfsd4_read(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 static void
 nfsd4_read_release(union nfsd4_op_u *u)
 {
-	if (u->read.rd_nf)
+	if (u->read.rd_nf) {
+		trace_nfsd_read_done(u->read.rd_rqstp, u->read.rd_fhp,
+				     u->read.rd_offset, u->read.rd_length);
 		nfsd_file_put(u->read.rd_nf);
-	trace_nfsd_read_done(u->read.rd_rqstp, u->read.rd_fhp,
-			     u->read.rd_offset, u->read.rd_length);
+	}
 }
 
 static __be32
-- 
2.51.0


