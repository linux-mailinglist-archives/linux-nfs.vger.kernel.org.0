Return-Path: <linux-nfs+bounces-6421-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EAA15977416
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Sep 2024 00:07:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BF5A1F251E3
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Sep 2024 22:07:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 590891C1AC8;
	Thu, 12 Sep 2024 22:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rkOQmnzU"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EB40192D89;
	Thu, 12 Sep 2024 22:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726178848; cv=none; b=UQ8d1xiURj2aAG4i57RMYLsJ1uV67rb0rWOzGmgbNO6VLN1YeX55wyzQT9pdtphe/Lf0KeRLMTzjQI4RB8ShK0SBxcBKp5TGTucfEjeQqa0aph3XAS3ha2/bskuD9AGNEqLlOd48y+qyb5V8ew4+pO92isdy4oXuMIqfGCJsJxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726178848; c=relaxed/simple;
	bh=GnDMqcTsTtZ+P4FfCR5hKRgnRo1g1o6vSBp86Dqdo80=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=lShhG8So07VrgF+4q7Y33p84MuLnkiD7kHCiMtiU6viKhlD7iKCml9JU63fm7N23vw+tVsrODjPRK39ZWCdsFK8DVb/ZsGWm+HchwutfdMdtCHo7etXByvc64AlTGYudWwy9onV6cqTnUQgW6NwESJ0LMC9zQZ6TYddr1Y+OTCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rkOQmnzU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95592C4CEC3;
	Thu, 12 Sep 2024 22:07:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726178847;
	bh=GnDMqcTsTtZ+P4FfCR5hKRgnRo1g1o6vSBp86Dqdo80=;
	h=From:To:Cc:Subject:Date:From;
	b=rkOQmnzUzBcAYhawpuIFLhFjb4PpBUEFTPqHni7dnw7AeNFNKxK6/6v4l9VPW64Ny
	 uH2YHRk6d+3wYGfZ7F5aK/Jn+QZy/Fd3HZllYrhZhOxpvx/KZMB1LGxg13YchNVewi
	 e7+JEkUWS1IUE0NFw3eET+N/ZF3zHkoxJJFgGuotogoSacv3nTQiOLRxJvyanV0xi6
	 WQatc/TEv51hybf+W9R+cLp8vr1Gu1aEeFF0LQmW3KQH1sQWxfyZj7oxhhpWUVBUPb
	 vZvm1PCoDK0NosvVJn7gIKyIwbROt6cE0CaOQ0BY0UQOUN8L9wVEJAz6glYBsTijhA
	 Mpf/010FERUqw==
Received: by pali.im (Postfix)
	id A9F035E9; Fri, 13 Sep 2024 00:07:22 +0200 (CEST)
From: =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Neil Brown <neilb@suse.de>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] nfsd: Fix nfs4_disable_idmapping option
Date: Fri, 13 Sep 2024 00:06:59 +0200
Message-Id: <20240912220659.23336-1-pali@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

NFSv4 server option nfs4_disable_idmapping says that it turn off server's
NFSv4 idmapping when using 'sec=sys'. But it also turns idmapping off also
for 'sec=none'.

NFSv4 client option nfs4_disable_idmapping says same thing and really it
turns the NFSv4 idmapping only for 'sec=sys'.

Fix the NFSv4 server option nfs4_disable_idmapping to turn off idmapping
only for 'sec=sys'. This aligns the server nfs4_disable_idmapping option
with its description and also aligns behavior with the client option.

Signed-off-by: Pali Rohár <pali@kernel.org>
Cc: stable@vger.kernel.org
---
 fs/nfsd/nfs4idmap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/nfsd/nfs4idmap.c b/fs/nfsd/nfs4idmap.c
index 7a806ac13e31..641293711f53 100644
--- a/fs/nfsd/nfs4idmap.c
+++ b/fs/nfsd/nfs4idmap.c
@@ -620,7 +620,7 @@ numeric_name_to_id(struct svc_rqst *rqstp, int type, const char *name, u32 namel
 static __be32
 do_name_to_id(struct svc_rqst *rqstp, int type, const char *name, u32 namelen, u32 *id)
 {
-	if (nfs4_disable_idmapping && rqstp->rq_cred.cr_flavor < RPC_AUTH_GSS)
+	if (nfs4_disable_idmapping && rqstp->rq_cred.cr_flavor == RPC_AUTH_UNIX)
 		if (numeric_name_to_id(rqstp, type, name, namelen, id))
 			return 0;
 		/*
@@ -633,7 +633,7 @@ do_name_to_id(struct svc_rqst *rqstp, int type, const char *name, u32 namelen, u
 static __be32 encode_name_from_id(struct xdr_stream *xdr,
 				  struct svc_rqst *rqstp, int type, u32 id)
 {
-	if (nfs4_disable_idmapping && rqstp->rq_cred.cr_flavor < RPC_AUTH_GSS)
+	if (nfs4_disable_idmapping && rqstp->rq_cred.cr_flavor == RPC_AUTH_UNIX)
 		return encode_ascii_id(xdr, id);
 	return idmap_id_to_name(xdr, rqstp, type, id);
 }
-- 
2.20.1


