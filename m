Return-Path: <linux-nfs+bounces-12459-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41168AD95EC
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Jun 2025 22:08:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6731F189EC5D
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Jun 2025 20:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4A2023C4F8;
	Fri, 13 Jun 2025 20:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="esPCGFrD"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B097472608
	for <linux-nfs@vger.kernel.org>; Fri, 13 Jun 2025 20:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749845331; cv=none; b=dvYr8ns2wA52FtT27UzlrA//zMXp3K12zlcctYSlEVKh8m2/Q5zoKKwoJ28flggS+Dp6+Jf2pnzRZ+g4vhPZIe1MMvj0zVoJ4DP6y+6jLs0Cv5iasz2lwrajI0/yW03YHqufRe9PkVqCeMvY3Mk5fWT/uaALxGZCOspb7N/tnbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749845331; c=relaxed/simple;
	bh=trkxzmp2F1VUoztGTQKzxDBhtWVuuk+qX9sSNbY5nis=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P8ZtvRXFC6OoYradJbQlZ+EzGzZcyIe3oUfq96qlVxzrJ8yi6TUtbWC2jlIEG7W8tGDIMUlVagaSR16LlSGZeJpJvYZRGyAwpfiDDXdvMwVvwcuZAEV357sO7IlwpHXTlJ5f4aBhW0TajpUpJBE63euGJy7kYwECOKD+UbKphug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=esPCGFrD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEDE7C4CEF0;
	Fri, 13 Jun 2025 20:08:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749845331;
	bh=trkxzmp2F1VUoztGTQKzxDBhtWVuuk+qX9sSNbY5nis=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=esPCGFrD37rQql6tn1a0CNQKsnX6FSuybSrt2eUkQmFK7xQ6v9oAuFYrTTdNNK9jU
	 biTFgBG4uldZZULXMrrMB1oKo10rfMwSbXJLg4E/G4wIMbFxHCpuNvdpsfUwVrfihB
	 If1cUXCVkvz/odYmBFlFxWK0yhRXX3hB6NLmnWUYBQ+CgrM5LTwesdmQLzl0av1bBV
	 461nV5LHhpbUIEw9HpJAqErFkeQqj30aqMNAEsC/ORA0sVdjJ5ogML5qB32ya73ABn
	 2E7oIwnQXc8ZlMho7TQJ179lBSkO8WwNjNNA62WhOAIhtJ2qM1Waa7hoFTVJPgwoeQ
	 8Cdeb3FjgbATA==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Christoph Hellwig <hch@infradead.org>
Subject: [RFC PATCH v2 1/2] NFSD: Use vfs_iocb_iter_read()
Date: Fri, 13 Jun 2025 16:08:46 -0400
Message-ID: <20250613200847.7155-2-cel@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250613200847.7155-1-cel@kernel.org>
References: <20250613200847.7155-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

Refactor: Enable the use of IOCB flags to control NFSD's individual
read operations (when not using splice). This allows the eventual
use of atomic, uncached, direct, or asynchronous reads.

Suggested-by: Christoph Hellwig <hch@infradead.org>
Reviewed-by: NeilBrown <neil@brown.name>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/vfs.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index cd689df2ca5d..7b3bd141d54f 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1086,10 +1086,14 @@ __be32 nfsd_iter_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
 {
 	unsigned long v, total;
 	struct iov_iter iter;
-	loff_t ppos = offset;
+	struct kiocb kiocb;
 	ssize_t host_err;
 	size_t len;
 
+	init_sync_kiocb(&kiocb, file);
+	kiocb.ki_pos = offset;
+	kiocb.ki_flags = 0;
+
 	v = 0;
 	total = *count;
 	while (total) {
@@ -1104,7 +1108,7 @@ __be32 nfsd_iter_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
 
 	trace_nfsd_read_vector(rqstp, fhp, offset, *count);
 	iov_iter_bvec(&iter, ITER_DEST, rqstp->rq_bvec, v, *count);
-	host_err = vfs_iter_read(file, &iter, &ppos, 0);
+	host_err = vfs_iocb_iter_read(file, &kiocb, &iter);
 	return nfsd_finish_read(rqstp, fhp, file, offset, count, eof, host_err);
 }
 
-- 
2.49.0


