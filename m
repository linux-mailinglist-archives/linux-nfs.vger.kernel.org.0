Return-Path: <linux-nfs+bounces-11457-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 80ABEAAAF63
	for <lists+linux-nfs@lfdr.de>; Tue,  6 May 2025 05:16:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A2AB3ACF10
	for <lists+linux-nfs@lfdr.de>; Tue,  6 May 2025 03:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 300B93B11D6;
	Mon,  5 May 2025 23:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q6S3gNis"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70964397A66;
	Mon,  5 May 2025 23:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486421; cv=none; b=U8JpkpOYoYkYA0ufXEXR4/eor2lHO61pqNMoJAujsu72mW3LUCxDvmjrRfaGFkdOGfYosPalmm354UKeWGWzqzC949Sv/ErwthpGAU4+bNQlw6Unhdnwm/KxASBf/OD9KbRkKdfzjEUoofdaQQLgKgTekdT1yLy8Clx7veFVTas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486421; c=relaxed/simple;
	bh=5THHuus3fgTQAgvQ3+PYY+FACHau1WzENPOs6L9Xu+0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AE0DuyqKSL06yq+si5T9aIC9eErqXyoQ8sikXhwCLzN9uwuVcjUdTUOurxEiPkviQami37knB77WS+iVuqbQTyJSaKEVfX9Ya7TWm5INnn6hkDkjm9npxl4rQVhFRNO7+/jrDtwPf3ig5sfbHRizOEv+kCLPZFrzUu1kKDsnHyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q6S3gNis; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EBBBC4AF5F;
	Mon,  5 May 2025 23:06:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486420;
	bh=5THHuus3fgTQAgvQ3+PYY+FACHau1WzENPOs6L9Xu+0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Q6S3gNis+0JrsvRFMEOKbhJ00fjLRNVXuMFcJESMWS+kgRxzApLLq38IdZl/b/NFY
	 nv+47mxXVdX6vpB9w1yzduewckZD+6d4gDL99WPZ7t08WVV8tVjk/SEv9Khl4NTTqs
	 IgzyNCQWIVMrTzaT6bQA2m5iG4hJ1zkclvz2kyxNxtICbwSCgjL5rgWxYYap/UdLMi
	 6UJWwCf+/7S90QVeRPzFUND4EdGdd/OoVUGRt/HUIApinGTK8deeFF+2sl8hBI7oad
	 E1cES6O4Oc3TLTtWL4ronRKJjnUoPBZMJ8X9lBJHt7/EAykLoG3Sjk0eMP+ie/hD7F
	 2J7baPHBNufYQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Trond Myklebust <trond.myklebust@hammerspace.com>,
	Jeff Layton <jlayton@kernel.org>,
	Benjamin Coddington <bcodding@redhat.com>,
	Sasha Levin <sashal@kernel.org>,
	trondmy@kernel.org,
	anna@kernel.org,
	linux-nfs@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 017/212] NFSv4: Treat ENETUNREACH errors as fatal for state recovery
Date: Mon,  5 May 2025 19:03:09 -0400
Message-Id: <20250505230624.2692522-17-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505230624.2692522-1-sashal@kernel.org>
References: <20250505230624.2692522-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.136
Content-Transfer-Encoding: 8bit

From: Trond Myklebust <trond.myklebust@hammerspace.com>

[ Upstream commit 0af5fb5ed3d2fd9e110c6112271f022b744a849a ]

If a containerised process is killed and causes an ENETUNREACH or
ENETDOWN error to be propagated to the state manager, then mark the
nfs_client as being dead so that we don't loop in functions that are
expecting recovery to succeed.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Reviewed-by: Benjamin Coddington <bcodding@redhat.com>
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfs/nfs4state.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/nfs4state.c b/fs/nfs/nfs4state.c
index 48ea406604229..80a7c5bd7a476 100644
--- a/fs/nfs/nfs4state.c
+++ b/fs/nfs/nfs4state.c
@@ -2737,7 +2737,15 @@ static void nfs4_state_manager(struct nfs_client *clp)
 	pr_warn_ratelimited("NFS: state manager%s%s failed on NFSv4 server %s"
 			" with error %d\n", section_sep, section,
 			clp->cl_hostname, -status);
-	ssleep(1);
+	switch (status) {
+	case -ENETDOWN:
+	case -ENETUNREACH:
+		nfs_mark_client_ready(clp, -EIO);
+		break;
+	default:
+		ssleep(1);
+		break;
+	}
 out_drain:
 	memalloc_nofs_restore(memflags);
 	nfs4_end_drain_session(clp);
-- 
2.39.5


