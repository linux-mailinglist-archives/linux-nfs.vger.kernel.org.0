Return-Path: <linux-nfs+bounces-11094-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 270D8A84E53
	for <lists+linux-nfs@lfdr.de>; Thu, 10 Apr 2025 22:42:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 342E37AE071
	for <lists+linux-nfs@lfdr.de>; Thu, 10 Apr 2025 20:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4A4320469E;
	Thu, 10 Apr 2025 20:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n0k4rsbm"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF3691FAC4A
	for <linux-nfs@vger.kernel.org>; Thu, 10 Apr 2025 20:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744317733; cv=none; b=RKctllNDyrPuHYZBEBs7DiEBPgc/x87rqCll3QxzIyU95zidJUupqC24cFy9aSzYvgSPt63CICtGg/MRhxkyki1YpzFGWRsfmwgR+XJUbMcDLpP2HFwi+8WBodotsgkKH4oFv11Von28s3yeYz/5SuHFuswkU7RbDRi8vMs77Qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744317733; c=relaxed/simple;
	bh=rG8HLP+2S/uXHI+MnPOKFixlqAaspSKUWWKjjGwvmqQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=j+1z/l+3b0un0ldwBrvuX11QJME5007Hekkc1uE7RRLmTgo+uQF7UVo+CaoeT//mx89z/V7diwzOQdna/SIeApaNcCT4MlZMvSV4ZTT5A3nIlUXi8i1DbibYp/nInWA4tPN1M6dc6Ql9JmzSwv/jdxHfscPivB70dJuJ0iryJfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n0k4rsbm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFFDBC4CEDD;
	Thu, 10 Apr 2025 20:42:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744317733;
	bh=rG8HLP+2S/uXHI+MnPOKFixlqAaspSKUWWKjjGwvmqQ=;
	h=From:Subject:Date:To:Cc:From;
	b=n0k4rsbmVciW8Js9qUQTxkROJtpgWHeALoaN8Lbw22ggh51U/xs8RjUV+WMqZX1lN
	 ipu+CHPk+3U+YfLPEywmRd5ftZxbT5zLGWPpoZ8/1nlhSt4xTy80WslZGeSgAV57xp
	 p/lSWLztoNRrxOx8yrtaULu2Ekg+i12Xq2IhIGcIJIwBZZmePISNldUIMo6D79Bb7T
	 G6bK8Frd15U4lW3LXLZZR5Roiytylj5yPu5mye2aJVypWO/spowE2DoWE91MOrA4ki
	 gOi7Wv+PCK3xp9C7Wh8HB9CHGFbfelO19uKibxmByCif/cdwSU72DTRpc5uuOsQ/Pu
	 6S6e9SZ8eVsDw==
From: Jeff Layton <jlayton@kernel.org>
Subject: [PATCH v2 0/2] nfs: don't share pNFS DS connections between net
 namespaces
Date: Thu, 10 Apr 2025 16:42:02 -0400
Message-Id: <20250410-nfs-ds-netns-v2-0-f80b7979ba80@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABst+GcC/3XMQQ6CMBCF4auQWTumU7CAK+9hWJAyQKNpTYc0G
 tK7W9m7/F/yvh2Eo2OBa7VD5OTEBV9Cnyqw6+gXRjeVBq30RTWk0M+Ck6DnzQvWmmzbWTJj20O
 5vCLP7n1w96H06mQL8XPoiX7rHygRKrTW6Npw11Cvbg+Onp/nEBcYcs5fSmkwOKkAAAA=
X-Change-ID: 20250410-nfs-ds-netns-321c78c16a79
To: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>
Cc: Omar Sandoval <osandov@osandov.com>, Sargun Dillon <sargun@sargun.me>, 
 linux-nfs@vger.kernel.org, linux-kernel@vger.keornel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1671; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=rG8HLP+2S/uXHI+MnPOKFixlqAaspSKUWWKjjGwvmqQ=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBn+C0fj9ahpQUoQ66lAjmLzTzbaiub6T7FIHlUQ
 WLH94j8QPiJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZ/gtHwAKCRAADmhBGVaC
 FfzBEACSI867eaDVWTj807ZnA8NY9DcoapzAUqguqdV8QXYXwi8P8XNc0Ok1wrcEYo0su9KdRy7
 g8A+9fJoVCObux9hZ7/YjRzf7m3ru9dER8lWFr247I49vq3zafzhs6cNSPVArqjQNYLGKp9Kuz1
 yI46pHJ3SckliNZHQjhNwIPTd/jDhwgkYS1kBLFLW4LeGEyVimZHhw5LSw25d3ek0E5kFCQKs+l
 cwXpsWDbS1dBPTFhFri8FutYp+jV0dgpAYI4WEey23bT3awXdfEg6QIgdTxGwyoWCCsbQF84BG2
 Hm2R43/pLzCLd2g7sCDny1bQ7NYW1Z5dYmL3cbLA///VFwfCA8zTryC23auDxxPP0St4RBw7QVS
 pPlWvH+LodOEgHidVLPZA61taQkXP0WcjqdTgzS18kbjvDpwu/4W8KySOIE/AQS48BPaWGITkV3
 CUy+m5New/gPSlJ85ZO1uFMkVqEpj4FmZ53DH5IAMwhvwYLPCaR74Sdnx4WhfYBtiDVuFg+utwh
 6pjSZJj5uZ2YR5HHgGN1hhMuL9W440FLRgcPI72O0wdyCC5tJnEeX3lR6875+w9itcJ/6BY1BYX
 BkT4qvoyw1oa86RR3J0D2eFuQxRPujDNzQt+t1BsTN4Ai/moq49VlhvdtXn7P3UEZIiC324hLvn
 YM3ONOBDzfCbhLQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Sargun noted that he had seen some cases where a dead netns with a stuck
NFS mount in it would affect other containers. Omar took a look last
week and noted that there was a global list of DS connections and there
was no segregation by namespace.

The first patch in the series fixes this in a minimal way by tracking
struct net in the nfs4_pnfs_ds structure and not matching it when the
caller's net is different. The second patch goes the rest of the way,
and makes the nfs4_data_server_cache and lock be per-net.

My thought was that the first patch should be suitable for stable
kernels, and both could go to mainline. If you think the risk is low
though, we could just squash the two together.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
Changes in v2:
- fix build break when IS_ENABLED(CONFIG_NFS_V4_1) is false
- Link to v1: https://lore.kernel.org/r/20250410-nfs-ds-netns-v1-0-cc6236e84190@kernel.org

---
Jeff Layton (2):
      nfs: don't share pNFS DS connections between net namespaces
      nfs: move the nfs4_data_server_cache into struct nfs_net

 fs/nfs/client.c                           |  7 +++++++
 fs/nfs/filelayout/filelayoutdev.c         |  6 +++---
 fs/nfs/flexfilelayout/flexfilelayoutdev.c |  6 +++---
 fs/nfs/netns.h                            |  6 +++++-
 fs/nfs/pnfs.h                             |  4 +++-
 fs/nfs/pnfs_nfs.c                         | 32 +++++++++++++++++--------------
 6 files changed, 39 insertions(+), 22 deletions(-)
---
base-commit: cf03f570936ac96ed4775eb2e4f1a6ab6a13f143
change-id: 20250410-nfs-ds-netns-321c78c16a79

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


