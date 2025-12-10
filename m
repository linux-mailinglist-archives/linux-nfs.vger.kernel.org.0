Return-Path: <linux-nfs+bounces-17018-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B06CACB17CC
	for <lists+linux-nfs@lfdr.de>; Wed, 10 Dec 2025 01:29:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9658230EA627
	for <lists+linux-nfs@lfdr.de>; Wed, 10 Dec 2025 00:28:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FF371A2C11;
	Wed, 10 Dec 2025 00:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cOZ5mWzk"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4336C1A2630
	for <linux-nfs@vger.kernel.org>; Wed, 10 Dec 2025 00:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765326536; cv=none; b=KnExrOfISUY0mJRNPM6Ad/zdhM7Kcq5ykyk/EXx8YAUJVIsPF3b0yOZpORJgqx0vSDPQaaR+tJ4VVf3qiKo+0UPE9jsOspAnoUvwD2J0vd2afzm8gkLE3PKXl1ClRspxxmbXzAKczUEoUBgKmdPpyt6OpO7JHNH0gYH+jFP6yrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765326536; c=relaxed/simple;
	bh=rTJTM2pppP2mpJpF2dXTiszNl5q8Yos+8XV8RK5WFdI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iVRo0rpqp4IgQ6YVx6c/5I5TXl3tBvVWCQt91DylZkf+RPGj8Z4/d79YMA4+yqXZZqwT76wBQTGm+PBu4xzsMDfYskgEQ16rIjzj/nmbY4JmS/jFdWRRXZY3/kTRTmFd2IwVp1a9+uN9W4S5mcIXYfsD4xZAznQ8UXmyL1F6tk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cOZ5mWzk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BB6BC4CEF5;
	Wed, 10 Dec 2025 00:28:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765326536;
	bh=rTJTM2pppP2mpJpF2dXTiszNl5q8Yos+8XV8RK5WFdI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cOZ5mWzkKzN+Mxca9Su/+0sOI4PDs4uYJ4ROpzSozx0hyhHlQBR26fLyCkeGUKnvZ
	 gYzGl+ixR0VOH2CwxtKDkBHpECFyRacZaYX+2uTRVBddY14RxUTSfzL/SBC+HOLtqB
	 5D4iTYZhkSpzWEeBeL/cIbXqo+r73xBiG1ljhXngfdu5OUPox/cQPzIgGyoaEdeqDP
	 +YRBh5+HzW71ttUVW6/6Z1eQR39lTZ5hUKXjxoUEgGUzNZQBH7iBCInS2zdVy1d0VE
	 6JWoEpzwxsOQY0sdfuLPoORfYP7hhVvFPCKxSS8xpcavinxCm8d1nXobmz5qgSerhO
	 nnyDtUdIv2cSQ==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH 2/2] NFS: NFSERR_INVAL is not defined by NFSv2
Date: Tue,  9 Dec 2025 19:28:50 -0500
Message-ID: <20251210002850.318350-3-cel@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251210002850.318350-1-cel@kernel.org>
References: <20251210002850.318350-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

A documenting comment in include/uapi/linux/nfs.h claims incorrectly
that NFSv2 defines NFSERR_INVAL. There is no such definition in either
RFC 1094 or https://pubs.opengroup.org/onlinepubs/9629799/chap7.htm

NFS3ERR_INVAL is introduced in RFC 1813.

NFSD returns NFSERR_INVAL for PROC_GETACL, which has no
specification (yet).

However, nfsd_map_status() maps nfserr_symlink and nfserr_wrong_type
to nfserr_inval, which does not align with RFC 1094. This logic was
introduced only recently by commit 438f81e0e92a ("nfsd: move error
choice for incorrect object types to version-specific code."). Given
that we have no INVAL or SERVERFAULT status in NFSv2, probably the
only choice is NFSERR_IO.

Fixes: 438f81e0e92a ("nfsd: move error choice for incorrect object types to version-specific code.")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfsproc.c        | 2 +-
 include/uapi/linux/nfs.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/nfsd/nfsproc.c b/fs/nfsd/nfsproc.c
index 481e789a7697..8873033d1e82 100644
--- a/fs/nfsd/nfsproc.c
+++ b/fs/nfsd/nfsproc.c
@@ -33,7 +33,7 @@ static __be32 nfsd_map_status(__be32 status)
 		break;
 	case nfserr_symlink:
 	case nfserr_wrong_type:
-		status = nfserr_inval;
+		status = nfserr_io;
 		break;
 	}
 	return status;
diff --git a/include/uapi/linux/nfs.h b/include/uapi/linux/nfs.h
index 71c7196d3281..e629c4953534 100644
--- a/include/uapi/linux/nfs.h
+++ b/include/uapi/linux/nfs.h
@@ -55,7 +55,7 @@
 	NFSERR_NODEV = 19,		/* v2 v3 v4 */
 	NFSERR_NOTDIR = 20,		/* v2 v3 v4 */
 	NFSERR_ISDIR = 21,		/* v2 v3 v4 */
-	NFSERR_INVAL = 22,		/* v2 v3 v4 */
+	NFSERR_INVAL = 22,		/*    v3 v4 */
 	NFSERR_FBIG = 27,		/* v2 v3 v4 */
 	NFSERR_NOSPC = 28,		/* v2 v3 v4 */
 	NFSERR_ROFS = 30,		/* v2 v3 v4 */
-- 
2.52.0


