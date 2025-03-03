Return-Path: <linux-nfs+bounces-10423-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FEAAA4C9EE
	for <lists+linux-nfs@lfdr.de>; Mon,  3 Mar 2025 18:41:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B683718848F4
	for <lists+linux-nfs@lfdr.de>; Mon,  3 Mar 2025 17:36:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89F1723F272;
	Mon,  3 Mar 2025 17:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OKxibQsr"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC5223ED75;
	Mon,  3 Mar 2025 17:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741022777; cv=none; b=NwW6JB7TLEGy1QPEGC+lDy8gzxrqRujlp6qIgm29w2gsQtRibKsPmMawvLrvPJHjoVfm/ORPd0m465O6NgcNb4Au3irTw++jeHfHjeFIsf6Pj7CDlZeo2tG9+D9VOEt+UN7stODxP9ozQupay0cGA3fmUdqu07L87S3xtXXSAuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741022777; c=relaxed/simple;
	bh=TLjwn8OvC2xRxNHgLGlT6YzixDeTdY+umrapqFPiZi0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qRo/a+r4KGmfa5nNe3MP8+BCsOIWEvnucPU+fmzQ2Lvnn5BhzBB/uNrsN6MZxE/g6Rw4qgdBVTVtaDDFX3FOhVSugHix8DlDcTRuv5wgyEdMhp4YHzZw+WMImp84ICaFWjPGHAH6I8jivcgBTLRZzyzkzcFSQBvqXXDPjiiLxV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OKxibQsr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B427C4CEEA;
	Mon,  3 Mar 2025 17:26:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741022776;
	bh=TLjwn8OvC2xRxNHgLGlT6YzixDeTdY+umrapqFPiZi0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=OKxibQsrqsSTlM968LNwlspsWF8Uy/fTD+rLkV7irdXi6/9OQ8qqhyZFKu3/P9xj5
	 y72faIAopJY9IC59BdkC9iWfKlT8/ZegSEZJqAWQqF1sQMrcWt2bMbeff4vjXjUkkU
	 kQWHrppB8ZCI0ErgE+VtucS2NEBNm3z3INO/RZfyX3KycdROBFie3ZV68bTEF4hpgq
	 fPWcmKWODgIZlLTmWUk4QgvoKmKewb6MKmTBsQ5LvqYLbq2Ss24rS3xBeAXrM+1imt
	 QK8EkU8Orqp2qoYSlJBVnVsU0ufpAXeFnhPtBRHQ62qJTw5ICV3Bk+/ViLjMfqiGKh
	 9//8kiqIlkplg==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 03 Mar 2025 12:25:59 -0500
Subject: [PATCH 1/5] nfsd: reorganize struct nfs4_delegation for better
 packing
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250303-nfsd-cleanup-v1-1-14068e8f59c5@kernel.org>
References: <20250303-nfsd-cleanup-v1-0-14068e8f59c5@kernel.org>
In-Reply-To: <20250303-nfsd-cleanup-v1-0-14068e8f59c5@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=731; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=TLjwn8OvC2xRxNHgLGlT6YzixDeTdY+umrapqFPiZi0=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBnxeY1vpggjGoEj3YtDf3e7GWM44RrbydQi9fQO
 Yfp6tgzRPKJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZ8XmNQAKCRAADmhBGVaC
 FRKJD/9CpXM4lbJxvqIwY2WxIDJQFCHSJopqNTHXtjxmm6NZwkGcXNHRM/czh7P5n1fuvXHUZJY
 uSFyzgpil3n1XHwFhisEfrzJJEGpPFQo7QrhykUM99K+M72bHjxXRw7idlxLD/m3cAHQa5fkXKN
 f43ucScxXTc2z5dDo+cKieHJIEiLGPQjoWIzysv3SE6xjlqG1tItF0mrScYW4jdx/3mEctl7JmM
 +H6a4JljVgNkDPoXQbg9pnNWCMaL2moQCGIxDRw6lf55ODJc1ToYV5d9TnoqusT0peul5DEShZd
 yND58EAqTXxeHsZIKXvKmiasViraVv9PEQIJwARzNNkJv2V4H3WXV9mU2DS1JSwo7QkdmbtG8yq
 kHUgVqOyin9S28NK8/43tSBA6W1p002EfxRsEhZMaO3YdI0AdU1TAkaq+/GK8xGF2KM2PolegP3
 WEMFJrXk0k7gGi4ph1lJoZ0vr0si/rYGIK7Gs4FjHsDM2+3Rmm7MtDdPtgpA1+7ZQ1gjvA5qYw/
 ApTkIETwtJVbnxTmsHwkb4G+buQpoMmYky9AL6D24dtfUs4YUpkVvjnE1+ns1kM6DqlLoWrJAUK
 jQbi9caFjaBYxgHS31PTfyMcnXledj0ComQeXeha/Vy9IyUHCcndGXEb3S1PBbsyNM3XSVvOupa
 QnlYCyTE4OyxW1g==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Move dl_type field above dl_time, which shaves 8 bytes off this struct.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/state.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
index 0537f5c001a4d581433ca5aca235188fe68b14e5..625a77107d29121d630d456183e01c9f903f758a 100644
--- a/fs/nfsd/state.h
+++ b/fs/nfsd/state.h
@@ -215,8 +215,8 @@ struct nfs4_delegation {
 	struct list_head	dl_perclnt;
 	struct list_head	dl_recall_lru;  /* delegation recalled */
 	struct nfs4_clnt_odstate *dl_clnt_odstate;
-	u32			dl_type;
 	time64_t		dl_time;
+	u32			dl_type;
 /* For recall: */
 	int			dl_retries;
 	struct nfsd4_callback	dl_recall;

-- 
2.48.1


