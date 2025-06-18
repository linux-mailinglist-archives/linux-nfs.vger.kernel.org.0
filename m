Return-Path: <linux-nfs+bounces-12556-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B2516ADED24
	for <lists+linux-nfs@lfdr.de>; Wed, 18 Jun 2025 14:58:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FCA11891FB1
	for <lists+linux-nfs@lfdr.de>; Wed, 18 Jun 2025 12:58:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0506A2E2676;
	Wed, 18 Jun 2025 12:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PsIFemUD"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D396C274FC2
	for <linux-nfs@vger.kernel.org>; Wed, 18 Jun 2025 12:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750251485; cv=none; b=SZee1mzQkVlZuho26oAlGopMP5jS9bTwqZuK+xkH/eqqgQnWqgxaq23BJVQPByny/Rw8QVYLl3kVq9DPiLniYikMSO7ywqH4yF+d7w13YWXft4MEq8VyuSlylJUdDXE/jVRFfElQIYSTDJ17/O0XbV9OP+4Q8qS31eUJN0sAw1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750251485; c=relaxed/simple;
	bh=ZTuOgtj5VFDDaUWLPhGH55Q98IlZHYfOFPzgTYBqsKs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Pbvs8bqf8zTZIU4+ZhrxhkCGTSIbvsPtHA5Y+lckARL7xdtqCNMzxw+XmL3bZd3Vqg7k/Nou+L5i/Do8hOpn2K1UbgemgprpDkAr6RqqDsrrlHzoxk9N/TQiaPDMVuN9VpG7gfhSV3+KQUVdkWmnbrK/SVFzzbqU0fVZ8QONIwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PsIFemUD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00DE9C4CEE7;
	Wed, 18 Jun 2025 12:58:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750251485;
	bh=ZTuOgtj5VFDDaUWLPhGH55Q98IlZHYfOFPzgTYBqsKs=;
	h=From:To:Cc:Subject:Date:From;
	b=PsIFemUDx2ON+khJ3Qjs3qKLPDCsGJNepFSo6cA8QJqUoC/8L1stNouoXmzi2o6Cs
	 xRjV3M6TQmZzFfltWWHB1gwJyka6YjnLZChWxO4q0HaW+7/mrR0mqpQQT8DwObUi6x
	 Y+GvjqrZ2M02Vbj9FoF+zg4gcIfBuylNdSlBrkOCnrKoGiHgvIvgGin97wXXiHBp6/
	 ytN1JruPvtAjLRKnNmskFzynNUhY306GBdmAOzbpArbtY8xJI8eyByNGDH/pWzwIg2
	 GfuOOsCf+aRwfpz7j5MZwElLuqHtU4yH99bmmfDgkcST4HO8FuLYhS73k3cHvfqccq
	 7zhj0PwW5ETFA==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [RFC PATCH] Revert "NFSD: Force all NFSv4.2 COPY requests to be synchronous"
Date: Wed, 18 Jun 2025 08:58:03 -0400
Message-ID: <20250618125803.1131150-1-cel@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

In the past several kernel releases, we've made NFSv4.2 async copy
reliable:
 - The Linux NFS client and server now both implement and use the
   NFSv4.2 OFFLOAD_STATUS operation
 - The Linux NFS server keeps copy stateids around longer
 - The Linux NFS client and server now both implement referring call
   lists

And resilient against DoS:
 - The Linux NFS server limits the number of concurrent async copy
   operations

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4proc.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index f13abbb13b38..2b76a8267a4b 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -1917,13 +1917,6 @@ nfsd4_copy(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	struct nfsd42_write_res *result;
 	__be32 status;
 
-	/*
-	 * Currently, async COPY is not reliable. Force all COPY
-	 * requests to be synchronous to avoid client application
-	 * hangs waiting for COPY completion.
-	 */
-	nfsd4_copy_set_sync(copy, true);
-
 	result = &copy->cp_res;
 	nfsd_copy_write_verifier((__be32 *)&result->wr_verifier.data, nn);
 
-- 
2.49.0


