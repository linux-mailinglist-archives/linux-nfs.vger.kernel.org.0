Return-Path: <linux-nfs+bounces-13495-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 80F95B1E77D
	for <lists+linux-nfs@lfdr.de>; Fri,  8 Aug 2025 13:41:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76CF61AA06A5
	for <lists+linux-nfs@lfdr.de>; Fri,  8 Aug 2025 11:41:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79BF32749DB;
	Fri,  8 Aug 2025 11:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VB35/jLh"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F4AB2749C1;
	Fri,  8 Aug 2025 11:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754653270; cv=none; b=DnzVt5qaQ7pXJuu49gh552Pc7icNG3uqz6G1Js5bAIsV3dRzMAiyjxMV+/b+6kBfAOWfYsHPFO+QnWsvZhgzWxIqvLwkPtOhuKfwS84lOFkT7O0ZuH4cOXU0P9kWgus49tEyt+ly+lRLKC/1LnE+oVEqrhQI32zYxsB3flAXiHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754653270; c=relaxed/simple;
	bh=H26vMp3NxZr/WTH7qpPvEN1W4Ym6aDZBKWSTFBdj8Hk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CaIyDiOsBIvA0eA3c4GCFnmPqsM2N8TYSSEoUHLKlcKqhBbC/kHbKaTMSVqG8mxCph7D+IR6U7NapJsPyn/wb98gTHI7hx7WnAJpt1WTAgGl1YHrK59wOPKgqQC9OfENc+Qv0k2DxLDRbBXs3G3UJzdYGt1NxqT/AWBGNQDjhlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VB35/jLh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78788C4CEF1;
	Fri,  8 Aug 2025 11:41:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754653269;
	bh=H26vMp3NxZr/WTH7qpPvEN1W4Ym6aDZBKWSTFBdj8Hk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=VB35/jLhegesyURRoN7XncWo3/tg/naMw1Po60mgs0A5AE+f2I8qZzKjvqPN1Z7pR
	 txmbXYS5UVmuPf1cFsnF7k0m+JoATrr5jk8FvTybD8iHJ/ZRETxlzZ8RJAX+n7Pimh
	 CPwKQcGkqmu6AWo26rj52ng1GxBiYr1rJJ/ZF4AxLq+jEBqKqb2l8aP8BhCyoahKI2
	 vHUMgMd3NFQgrWxU+cCmthwNdc+hfCrtNds4KJR5kJEIV7pYwSvgXrNMeayUNwy0di
	 FExalXZ+rkdqpDQSx7YfQcMLStnhlM8OA/O3dqVNlacZVjHASo4+MTn3Fn43s8Xxuu
	 d05MejEar1bJw==
From: Jeff Layton <jlayton@kernel.org>
Date: Fri, 08 Aug 2025 07:40:30 -0400
Subject: [PATCH 1/5] nfs: remove trailing space from tracepoint
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250808-nfs-tracepoints-v1-1-f8fdebb195c9@kernel.org>
References: <20250808-nfs-tracepoints-v1-0-f8fdebb195c9@kernel.org>
In-Reply-To: <20250808-nfs-tracepoints-v1-0-f8fdebb195c9@kernel.org>
To: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=689; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=H26vMp3NxZr/WTH7qpPvEN1W4Ym6aDZBKWSTFBdj8Hk=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBoleJTTVr6I0Ieyv8iG/NsKgQNegRaQj/yeazIQ
 0rqzXUonkCJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaJXiUwAKCRAADmhBGVaC
 FctND/9DazMa5Df4M5UFKVsFYFnyothlcfySwxzCJmdjz90HiqPoASTf+wg4XR5pkgPgqkm4Owp
 Uykv6p9dsZXs3QGcmkaHubbCrozTf6LiVH1UegYfQTFpbf5ncWWuTmZVt4STi4bH5gvSDIgEA0O
 pEQaWlZEkUYo0uQsd7SEV4At8HRGtSD7L0gM3nKz7tNtxJpdrjsWp0bonm0CtXRMnMx1+s+Yiys
 QY+Xbb1r6/Xc3if5PoI6Ke9F3VjCaZPfUI9pDw/izMX7wYXcdHqoaHBCndicZDXftTc3z7yeMF5
 PTucmjmygOpa+qq2NjxUuQsy/WZo3iR4wgAORtzetvRP2MI+fwErBGn9Ec8Mz3vSV71kugsgZx9
 k+5/nK1XLF/xVq3CEGdhw/rF2RAHxp6mIyuZLISdXIJw7vK06ll3Xf4A6VMHKjHVHJCdXSwnMCB
 pF8318L373BpxtbP2gyQ70j3wutiKR+2OXsds+/mFQGKFkNyPBcCobLIxOlZwEvSmXKZ8df/r2p
 0PVgT5lqitRPV3lomx63maRTjv7I4SuuDHk9MpuxewV634ChAME9P8okwuj0RFwUKPO8EW2m5aV
 +gSW58aVh9qSsJHlHeXhfwSzeb845SmJYM+cJh3JBteNylVc8VA1MbeqV/m4rgS/frPWHzI0+HD
 UjYXn5+ejV/Q53A==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Cleanup for a minor annoyance.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfs/nfstrace.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfs/nfstrace.h b/fs/nfs/nfstrace.h
index 7a058bd8c566e2976e24136e2901fbaa7070daac..9ebfb220e94a5389e633210519a9a1f21a052d76 100644
--- a/fs/nfs/nfstrace.h
+++ b/fs/nfs/nfstrace.h
@@ -67,7 +67,7 @@ DECLARE_EVENT_CLASS(nfs_inode_event,
 		),
 
 		TP_printk(
-			"fileid=%02x:%02x:%llu fhandle=0x%08x version=%llu ",
+			"fileid=%02x:%02x:%llu fhandle=0x%08x version=%llu",
 			MAJOR(__entry->dev), MINOR(__entry->dev),
 			(unsigned long long)__entry->fileid,
 			__entry->fhandle,

-- 
2.50.1


