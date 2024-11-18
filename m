Return-Path: <linux-nfs+bounces-8061-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 301B59D1A57
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Nov 2024 22:20:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D300B1F217EB
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Nov 2024 21:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE29D155C94;
	Mon, 18 Nov 2024 21:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Od5Vp/+d"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5B04155312;
	Mon, 18 Nov 2024 21:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731964838; cv=none; b=cS7IR1fc7548lDvrzFgUccI+eTfTcpD8flm8Xrv9nJBT2cyZLI+tv2OeNNE7OXw07S0RTr5kFw3/OkloYtG+BkKWIMvIozcI76TXwigYIADWhKcungiVo1qME1xHafTZtH/hqbaqCKANWxJ2Al4ruGrJFNyD2dK/zpyjeJF5Uck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731964838; c=relaxed/simple;
	bh=GFdywPDt/DV4WcBGDX/bMizY3+b0W7G7827H3STBdUw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oMCOJRRLCrAQJsNRvi1Yb6UKDFz/0Y44wCsMv3xQlKxqMZ8+ClL2Dtn8o7rd/XK2plZ+xqqvEdPIKPHfHeHWxql/W2KbX72FtxxRtjX4rQEkH0vktyC7+FY5L5p0HZcBO/6eIiKyo+TQoqpw34qzuni10qukdp3bSSVdnMRCHt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Od5Vp/+d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0B8CC4CECC;
	Mon, 18 Nov 2024 21:20:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731964838;
	bh=GFdywPDt/DV4WcBGDX/bMizY3+b0W7G7827H3STBdUw=;
	h=From:To:Cc:Subject:Date:From;
	b=Od5Vp/+dMUgKDiDaKf2OW00v+sxInH7U48JO68+BNKqFn6aHF+2PmSKOCPbn+LEPl
	 aEtGt1bYwLThuCOVRPnl9IunaKmZZjfVtgXCrxIdZNUXyN29K09Pn9CckVJnD5MVk9
	 npq2LDartT/Vfu1UaSTLcwV11JspAyn/up8wTombfDdQNxSu4Bk5wQ/VO0wFC1R56G
	 gkvSnaIugGMjhdJvIidQKamQo4bbewfBNr4KtRh8CCRFSCEI6My39HhpEU/C3cdGBW
	 72PiNuYJwF7WEpRIOmtUQUHKpmXvA3oFjcO/BefaTECl4Bep06Xu6TS+rJYQDTD97Y
	 1Yf4xrlvL8pmg==
From: cel@kernel.org
To: <stable@vger.kernel.org>
Cc: <linux-nfs@vger.kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH 5.15 0/5] Address CVE-2024-49974
Date: Mon, 18 Nov 2024 16:20:12 -0500
Message-ID: <20241118212035.3848-1-cel@kernel.org>
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


