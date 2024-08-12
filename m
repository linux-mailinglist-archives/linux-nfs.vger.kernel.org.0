Return-Path: <linux-nfs+bounces-5321-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 09C5794F203
	for <lists+linux-nfs@lfdr.de>; Mon, 12 Aug 2024 17:48:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 88FD4B23DCB
	for <lists+linux-nfs@lfdr.de>; Mon, 12 Aug 2024 15:48:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AADC4183CD9;
	Mon, 12 Aug 2024 15:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oanhKlVU"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 865F21474C3
	for <linux-nfs@vger.kernel.org>; Mon, 12 Aug 2024 15:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723477685; cv=none; b=JGz2IkrBb2P3oggllMGOLwqZs/UHWZeACcfAJ4+kuh21nLiwgciuULn0OECjjTfOrfD1pPIt0yPdssSFjsk7s3zAmXMSbZgFv00o40RBHtpAlfTekTdIqNCtzzZBpYLEdfwPM4HYhh+TUxJJlUpHGpjHA4hzWRKUGUe1RIh5Jok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723477685; c=relaxed/simple;
	bh=W475sTn0irtnas14KwAh2q9pZ9DBSjnO6TsuW1Gh2iQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aUUNefUUW9L9xQQn6D+Hwj0yVGXafJLMsiA71TitEUAJCn/4tLlBEs0FzCfg+N3um7cfqL+q40XyDUOQxtHAxgVaQhVyP0EaNaZMgHkZXsg2XR3DUMttjQEBAQTPS+XFQLrx77/LjEZPTVsfEk7ux9DEErT6+22RqqOUgjXbHj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oanhKlVU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A39E6C32782;
	Mon, 12 Aug 2024 15:48:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723477685;
	bh=W475sTn0irtnas14KwAh2q9pZ9DBSjnO6TsuW1Gh2iQ=;
	h=From:To:Cc:Subject:Date:From;
	b=oanhKlVUIcrxxslGZoWF5A1OlL1eVmms8EvnyjMuQJabCvQa568CEoNm89KNYdhsl
	 Wu2cPaDnFUTD+a2MVv5dIqKu5HBKPdsQs6ZUjBTRQGuXbVqosAAzRbHcCxEE9hkjX3
	 gVT/ZRW6iKpHIhSzsYY1cuP34+dWx1JmGlILgEYyThjMtFKmNaH7iortPIKR/HbeZz
	 XcEKyc3GCD7MaxMP+Y5QbXdO/CsrDbL6rbUxRMoeoL1rONLgD37l8TLo6ZKzh2dvKK
	 xjfIvxUb5fzdVh9o9L4ys9pDEVOhbJuJqvuQBi69aGWk/KJ6WHpZE2sS7bYY9KhyQz
	 CMDH+4BKrHdKw==
From: cel@kernel.org
To: Anna Schumaker <anna@kernel.org>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	<linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH 0/3] Fixes for NFS/RDMA device removal
Date: Mon, 12 Aug 2024 11:47:56 -0400
Message-ID: <20240812154759.29870-1-cel@kernel.org>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

Fix a handful of nits for the NFS/RDMA device removal code that
went into v6.11-rc.

Chuck Lever (3):
  rpcrdma: Device kref is over-incremented on error from xa_alloc
  rpcrdma: Use XA_FLAGS_ALLOC instead of XA_FLAGS_ALLOC1
  rpcrdma: Trace connection registration and unregistration

 include/trace/events/rpcrdma.h  | 36 +++++++++++++++++++++++++++++++++
 net/sunrpc/xprtrdma/ib_client.c |  6 ++++--
 2 files changed, 40 insertions(+), 2 deletions(-)

-- 
2.45.1


