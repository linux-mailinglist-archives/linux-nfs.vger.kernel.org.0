Return-Path: <linux-nfs+bounces-5506-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D869895A088
	for <lists+linux-nfs@lfdr.de>; Wed, 21 Aug 2024 16:56:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93F92286739
	for <lists+linux-nfs@lfdr.de>; Wed, 21 Aug 2024 14:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED8F41B1D76;
	Wed, 21 Aug 2024 14:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GzMfOPBy"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5D3F1B1D4E;
	Wed, 21 Aug 2024 14:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724252182; cv=none; b=jAAZX9rdfmvtqdsFV+xqwZmiY4yDOEKlv1+PPRTnTrYbQwxfjqRQVcF+N5H4JiRjxlAUbZXyyed32u2hZBCzo0uZxc7VHpTHK/5W7WyERrmXAb6e81KNkN2nbnfM2sxi/F7dv/hfrOrjdlQfklCtGXz7om3EtqOJ9roUZHNdvPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724252182; c=relaxed/simple;
	bh=nzbXYIlTHK/Zc//uO2pb/6uBnF1pj2Ff5bWI23JhP3g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LWsErXm8KHZGIq2KkWgz6mf+HlUsIxt47lIepsP1XVSTgbgDr0tgeTGPp1Nqrux2ib8HbBhUdi7se7RXv1A94pxbsXCXA5uM6vUoQhZXPe65VTq1x+ptTkV5l9H/aX+W7Fc8FYyJr+uePiZjRlUe0L7juIbqHB/lFU5P7s8Ubpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GzMfOPBy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2800C4AF0E;
	Wed, 21 Aug 2024 14:56:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724252182;
	bh=nzbXYIlTHK/Zc//uO2pb/6uBnF1pj2Ff5bWI23JhP3g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GzMfOPByl/oYCr9IbvTPpo6y3LGwcAx+/STDEjkoIfWY2gwcH3ViXDJeN1EdA5Nbd
	 Nr4LgYZmAOyAQOJu/q7WHKqBzkgBMhh8my3f7LoVlx7YfsDc4BpPYR8E2WYsnA25eH
	 Pl9NQ/Ehq2/H0xBquLbqLdP6GNQ747rE061xAccE3Zi1LI76WuazmyLY/sgtgrUKRf
	 BRBAvW9BsGGja1Og0AbCrc60SEUwa12YeiD8+eguWy9E+ia4lOEbR9O6IsKGWh2c1m
	 bLO3Z085Yav69+qKQUn7nfWnydBdfZZzV1J08lMwlBfGTmwF6LIdye9/uArIWARfKD
	 yg4OgRgEeoC4g==
From: cel@kernel.org
To: <stable@vger.kernel.org>
Cc: <linux-nfs@vger.kernel.org>,
	pvorel@suse.cz,
	sherry.yang@oracle.com,
	calum.mackay@oracle.com,
	kernel-team@fb.com,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Subject: [PATCH 5.15.y 04/18] NFSD: Rename nfsd_reply_cache_alloc()
Date: Wed, 21 Aug 2024 10:55:34 -0400
Message-ID: <20240821145548.25700-5-cel@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240821145548.25700-1-cel@kernel.org>
References: <20240821145548.25700-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

[ Upstream commit ff0d169329768c1102b7b07eebe5a9839aa1c143 ]

For readability, rename to match the other helpers.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Stable-dep-of: 4b14885411f7 ("nfsd: make all of the nfsd stats per-network namespace")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfscache.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/nfsd/nfscache.c b/fs/nfsd/nfscache.c
index d078366fd0f8..938b37dc1679 100644
--- a/fs/nfsd/nfscache.c
+++ b/fs/nfsd/nfscache.c
@@ -85,8 +85,8 @@ nfsd_hashsize(unsigned int limit)
 }
 
 static struct svc_cacherep *
-nfsd_reply_cache_alloc(struct svc_rqst *rqstp, __wsum csum,
-			struct nfsd_net *nn)
+nfsd_cacherep_alloc(struct svc_rqst *rqstp, __wsum csum,
+		    struct nfsd_net *nn)
 {
 	struct svc_cacherep	*rp;
 
@@ -457,7 +457,7 @@ int nfsd_cache_lookup(struct svc_rqst *rqstp)
 	 * preallocate an entry.
 	 */
 	nn = net_generic(SVC_NET(rqstp), nfsd_net_id);
-	rp = nfsd_reply_cache_alloc(rqstp, csum, nn);
+	rp = nfsd_cacherep_alloc(rqstp, csum, nn);
 	if (!rp)
 		goto out;
 
-- 
2.45.2


