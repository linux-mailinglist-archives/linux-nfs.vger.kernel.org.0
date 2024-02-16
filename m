Return-Path: <linux-nfs+bounces-1985-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D58FF85736D
	for <lists+linux-nfs@lfdr.de>; Fri, 16 Feb 2024 02:31:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A76641F24F4B
	for <lists+linux-nfs@lfdr.de>; Fri, 16 Feb 2024 01:31:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C054DDA8;
	Fri, 16 Feb 2024 01:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sCxV5k1e"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B86D27A
	for <linux-nfs@vger.kernel.org>; Fri, 16 Feb 2024 01:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708047058; cv=none; b=AM+o+zohfNCFKmiM16fl2v/G9gYDc/AIezAb4n5x42NqPNfp5/BuhGVMFYUHrVrvzCX2xlksAg6cBTDUuVGkxB5RGyhU89HDqhKhdIof/FxXnRmV9v4OWSsDml3p+/hKc7LKjJmxTmMQXlHWcRF+Vrcj0eEez75T2h06LNNhXGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708047058; c=relaxed/simple;
	bh=cSf5dTlAbulVL5j/8QsSjCuJ/4HSH3nGfwMfKiKdEqM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PU6tZps6wN8knwkLyh/3+BV+ov0QRylWMhpFih123mkPFQxcRleSGfePcc4BKJ4/+fpUN8tx8891vJMXBT6gOqeonzeaLitZ64azuCNK85T9k7ST7KDI9oBegcoi/WHN2QWx01rfX632mdmu2mmKMqNMjhQohVt//eSsVLvVBME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sCxV5k1e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9958DC433F1;
	Fri, 16 Feb 2024 01:30:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708047058;
	bh=cSf5dTlAbulVL5j/8QsSjCuJ/4HSH3nGfwMfKiKdEqM=;
	h=From:To:Cc:Subject:Date:From;
	b=sCxV5k1ehaJqdn0lZ1YjmpiH5cCr5HDUwmWJCkJ0QJJwqaHg/oS7D7ZYdN3NHukJb
	 6EfDR2qLz6iKP8QjOrb/5lMAJ9w1I2NCxE9WP04fHpkdRhtAqgB5BgxLf0ITjhFySs
	 fNviwWB1XXqhqrVxNncNGpoMPm6EzST6I5VEQkBx4O2wMLfe8rhG5YyrifcF2zFmC+
	 t0uB27gila2+MoOKKCuoD1qU9ubkMysb+j9Hn0FZlSOeDPtCCMhQbsVphnncOugXt1
	 DcM6QTtW9nHWmZZTN8PVLpdBiLstMb0pGSgYKxhF1ks/1NYDLr9nA/pPaUqYC3g8P8
	 P3tHn8X4J9HeA==
From: trondmy@kernel.org
To: Chuck Lever <chuck.lever@oracle.com>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH v2 0/2] Fix NFSv3 SETATTR behaviours
Date: Thu, 15 Feb 2024 20:24:49 -0500
Message-ID: <20240216012451.22725-1-trondmy@kernel.org>
X-Mailer: git-send-email 2.43.1
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Trond Myklebust <trond.myklebust@hammerspace.com>

Fix recent regressions in nfsd_setattr(), and fix the "guarded SETATTR"
behaviour for NFSv3.

Trond Myklebust (2):
  nfsd: Fix a regression in nfsd_setattr()
  nfsd: Fix NFSv3 atomicity bugs in nfsd_setattr()

 fs/nfsd/nfs3proc.c  |  6 ++++--
 fs/nfsd/nfs3xdr.c   |  5 +----
 fs/nfsd/nfs4proc.c  |  7 +++++--
 fs/nfsd/nfs4state.c |  2 +-
 fs/nfsd/nfsproc.c   |  6 +++---
 fs/nfsd/vfs.c       | 29 ++++++++++++++++++++---------
 fs/nfsd/vfs.h       |  2 +-
 fs/nfsd/xdr3.h      |  2 +-
 8 files changed, 36 insertions(+), 23 deletions(-)

-- 
2.43.1


