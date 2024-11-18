Return-Path: <linux-nfs+bounces-8049-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84B6B9D1A33
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Nov 2024 22:14:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F15A9B213DB
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Nov 2024 21:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 181F51E5728;
	Mon, 18 Nov 2024 21:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h1OjtoTI"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E11CE1DED55;
	Mon, 18 Nov 2024 21:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731964457; cv=none; b=l7fNLmXowFyAyhYoVOEO6iXU9hbI3gdeAxscnIt41bJl0+wFhKs4EAJhLsV9fTNDsGKldlUDOu8YsJxHOqHYn4Ex8u8kuzba+crlqb8kkpluIMKuVLrcKArA9eryoeOo9WgbUeLQ/C6MWFqLvwZcQJRsP57PnUemz5tWWpsF1XE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731964457; c=relaxed/simple;
	bh=GFdywPDt/DV4WcBGDX/bMizY3+b0W7G7827H3STBdUw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=h+OWnHmnuwziHmtKNKEhQzFc56PrHXW07Ks55vxPpbdTvAj9rgMNu2mZW9C4OeNgBFyvM780XJ1tG7zrFy2jdfTIUEbQzTex527ka+h6GtRzs+q2NmuPw5lxqBbblOMcmf8CzFwp0BS0sn2RjNue8Gd9mBptH0jKiWHrONK1OZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h1OjtoTI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A169C4CECC;
	Mon, 18 Nov 2024 21:14:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731964456;
	bh=GFdywPDt/DV4WcBGDX/bMizY3+b0W7G7827H3STBdUw=;
	h=From:To:Cc:Subject:Date:From;
	b=h1OjtoTIHmgDMCtxXV5zN4rp2j02ORxaL/aSIV6zJ0iQ0QOwFxs2zpO6SzyEDnEPc
	 bQHRBRIbf8nV3u0qL6u1bDBLetEKe5+I3vC4Ry/4l6lRogTeAhcaAoJPQAi+MIJNTg
	 x5KhzeWeG8MXlGDjUWJ8uP2SVU4yTe/7rpuDhOpSJdUoUxXWrozGLmi6loP7SXAFZ2
	 Zm/WX+DeXAjImKBfD1BCAo2og7PTpka5GH4AW8icxieHShoo4Meee/IIMMQhDGK1y8
	 gbbny2wFEPTU+M2Y1YZJXldpuD2VCrCtP5m3hKf59m3pTaBv1ftkQCdZ+zbFQXEt3T
	 +uLEHFKe5+HBQ==
From: cel@kernel.org
To: <stable@vger.kernel.org>
Cc: <linux-nfs@vger.kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH 6.6 0/5] Address CVE-2024-49974
Date: Mon, 18 Nov 2024 16:14:08 -0500
Message-ID: <20241118211413.3756-1-cel@kernel.org>
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


