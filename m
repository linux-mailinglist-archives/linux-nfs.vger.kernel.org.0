Return-Path: <linux-nfs+bounces-8081-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A077E9D1A84
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Nov 2024 22:23:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49F171F225E7
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Nov 2024 21:23:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 880EB1C07DE;
	Mon, 18 Nov 2024 21:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oXLDtgCg"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F7DA155C94;
	Mon, 18 Nov 2024 21:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731965026; cv=none; b=VHCfVH1E+JvZActolODwCeR50i8GSP/ffhJVoR81ZXLdLi8zcQpUpLLltE6myx5Ab9n94gTbxsl+JOCbTIvr2LrUKZkjlsFjPSObad5Yw7a06Y3rsm4/AlvGlTAhK24q+B2P98UszWF8a/GMVnpX7XmOwS9kMz3Ok04+urbBTdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731965026; c=relaxed/simple;
	bh=GFdywPDt/DV4WcBGDX/bMizY3+b0W7G7827H3STBdUw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UrLM27Lo5AJZe0VIEGlPfgLaUlkBaHFzWRz/togFFS2ouoPDdWkol1bJXUfAUr3EpNpek+kE35pQvdRJ4L2Al4gGT/TE5U9Vnwwdgv2uazsO66pKwLBo2Xbp0N086wO4Q/V4MP0sPonY0odUgNHkWDnoJrNWexMnXeGusqWyuzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oXLDtgCg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6401C4CECF;
	Mon, 18 Nov 2024 21:23:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731965026;
	bh=GFdywPDt/DV4WcBGDX/bMizY3+b0W7G7827H3STBdUw=;
	h=From:To:Cc:Subject:Date:From;
	b=oXLDtgCgcRL+g3BUaD24OpGDsGZjqPQ3vnenbGWHzbHpfbq3X+eup1+o2Smm+mJaG
	 p6MPIeGmdOUMgSxLsmSwigGQKl0HqfWe7b1uO9lnj/qKfC2+1tKouUEte4B5KgP/0C
	 l1aWDP+LgytE+JFDMsx1Ned/izE6G+ilL+UKbBrMBzhkf6N0tPJNjdf1MD+qpuKM2X
	 11gwCgvNVcrmDEXQdzehV8WWkrO7zMtzFAayCG+Vj56IiFj13XnJuaRbi4ObkUiZSJ
	 Vy+BvztYn9wdu5nAEfPAV0EsG1+1PVTvBON5uJwXNeYkzRKE9B7BQTkJe29fCHVb1u
	 dGRuNmfApO42A==
From: cel@kernel.org
To: <stable@vger.kernel.org>
Cc: <linux-nfs@vger.kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH 5.15 0/5] Address CVE-2024-49974
Date: Mon, 18 Nov 2024 16:23:38 -0500
Message-ID: <20241118212343.3935-1-cel@kernel.org>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

Backport the set of upstream patches that cap the number of
concurrent background NFSv4.2 COPY operations.

Chuck Lever (4):
  NFSD: Async COPY result needs to return a write verifier
  NFSD: Limit the number of concurrent async COPY operations
  NFSD: Initialize struct nfsd4_copy earlier
  NFSD: Never decrement pending_async_copies on error

Dai Ngo (1):
  NFSD: initialize copy->cp_clp early in nfsd4_copy for use by trace
    point

 fs/nfsd/netns.h     |  1 +
 fs/nfsd/nfs4proc.c  | 36 +++++++++++++++++-------------------
 fs/nfsd/nfs4state.c |  1 +
 fs/nfsd/xdr4.h      |  1 +
 4 files changed, 20 insertions(+), 19 deletions(-)

-- 
2.47.0


