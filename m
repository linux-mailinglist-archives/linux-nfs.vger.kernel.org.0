Return-Path: <linux-nfs+bounces-15585-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BD44BC06BF0
	for <lists+linux-nfs@lfdr.de>; Fri, 24 Oct 2025 16:43:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B388C4E400B
	for <lists+linux-nfs@lfdr.de>; Fri, 24 Oct 2025 14:43:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FBE9319866;
	Fri, 24 Oct 2025 14:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="POQlOCvx"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B7D23191D6
	for <linux-nfs@vger.kernel.org>; Fri, 24 Oct 2025 14:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761316990; cv=none; b=XbGaWza0c0RR2VyWp0JcrfZI5sF+PwOzfPIH3v/azLo51aXhl1imrlSVw9BBpZ3JElvPa4OG8IBhuc0ntsL8hhcpMheOhxp4DPa/n0e6EusQ5lSbm2LhxRCgXLXzh5U6fLLEU3ZErlfWk8aGhikWzBvupmT02l8f8bXXapzcmPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761316990; c=relaxed/simple;
	bh=9a4r+Rr4YcU+2k+jIWH7h+ru53AlMXiF0pl40KA8AbM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GCOwkn+XandZTPyUQO2dnIdjHLxKg6gE07CVGGnzTzXnjGXTwvUTh9Gwz655RRf0FxTQPC3OgtjtjW55DAN+ieFvIlwpkSLFbzTWbiaF5qk3ttP0C1CHsXlKPBgiGv5ALlTVHu9VIlN0MHBvooJyBQ8eV+AQ/U5nx4twYICDYZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=POQlOCvx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38223C113D0;
	Fri, 24 Oct 2025 14:43:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761316989;
	bh=9a4r+Rr4YcU+2k+jIWH7h+ru53AlMXiF0pl40KA8AbM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=POQlOCvxQIEO1UWRtzftS5QLXA0OJOR7JB49rZdSOMTO5k1ESpCcKGdmKxGwEqP6o
	 Owh6krojiiDlbk18YtwJYUh0OSySIBxkvaqsT2XJuZ4Gufq5k/hxTr/7VdvCPVV9jL
	 FqjwKtZOxSxDROv0+m0XcqDnkYsGesy2FeIhHA1ltH5PMNuNHM48w6JKzxS7MiDf/Y
	 TlCXdNfXL1bRIknSorejpP17mZ6isEWzrS9mtmdg1uzsil4qLaczpCX8zBWEI1mA3w
	 fmLwtLF06kc2CjJHbu2tvFtcps1FXQ+u2o/zY2AonRpZzRuEO2vR4CfOTDA5EJU3E0
	 Lzi+VKzC+NQpA==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Mike Snitzer <snitzer@kernel.org>
Subject: [PATCH v7 01/14] NFSD: Make FILE_SYNC WRITEs comply with spec
Date: Fri, 24 Oct 2025 10:42:53 -0400
Message-ID: <20251024144306.35652-2-cel@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251024144306.35652-1-cel@kernel.org>
References: <20251024144306.35652-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

Mike noted that when NFSD responds to an NFS_FILE_SYNC WRITE, it
does not also persist file time stamps. To wit, Section 18.32.3
of RFC 8881 mandates:

> The client specifies with the stable parameter the method of how
> the data is to be processed by the server. If stable is
> FILE_SYNC4, the server MUST commit the data written plus all file
> system metadata to stable storage before returning results. This
> corresponds to the NFSv2 protocol semantics. Any other behavior
> constitutes a protocol violation. If stable is DATA_SYNC4, then
> the server MUST commit all of the data to stable storage and
> enough of the metadata to retrieve the data before returning.

For many years, NFSD has used a "data sync only" optimization for
FILE_SYNC WRITEs, in violation of the above text (and previous
incarnations of the NFS standard). File time stamps haven't been
persisted as the mandate above requires.

The purpose of this behavior is that, back in the day, file systems
on rotational media were too slow to handle writes with time stamp
updates. With the advent of UNSTABLE WRITE, the time stamp update is
done by the COMMIT, which amortizes the cost of one time stamp
update over possibly many WRITE requests.

The impact of this change will be felt only when a client explicitly
requests a FILE_SYNC WRITE on a shared file system backed by slow
storage. UNSTABLE and DATA_SYNC WRITEs should not be affected.

Reported-by: Mike Snitzer <snitzer@kernel.org>
Closes: https://lore.kernel.org/linux-nfs/20251018005431.3403-1-cel@kernel.org/T/#t
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/vfs.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index f537a7b4ee01..5a9a2a69bc08 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1314,8 +1314,14 @@ nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh *fhp,
 		stable = NFS_UNSTABLE;
 	init_sync_kiocb(&kiocb, file);
 	kiocb.ki_pos = offset;
-	if (stable && !fhp->fh_use_wgather)
-		kiocb.ki_flags |= IOCB_DSYNC;
+	if (stable && !fhp->fh_use_wgather) {
+		if (stable == NFS_FILE_SYNC)
+			/* persist data and timestamps */
+			kiocb.ki_flags |= IOCB_DSYNC | IOCB_SYNC;
+		else
+			/* persist data only */
+			kiocb.ki_flags |= IOCB_DSYNC;
+	}
 
 	nvecs = xdr_buf_to_bvec(rqstp->rq_bvec, rqstp->rq_maxpages, payload);
 	iov_iter_bvec(&iter, ITER_SOURCE, rqstp->rq_bvec, nvecs, *cnt);
-- 
2.51.0


