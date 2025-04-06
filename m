Return-Path: <linux-nfs+bounces-11009-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 341AFA7CD67
	for <lists+linux-nfs@lfdr.de>; Sun,  6 Apr 2025 11:11:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDD00188F961
	for <lists+linux-nfs@lfdr.de>; Sun,  6 Apr 2025 09:11:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7762719E7FA;
	Sun,  6 Apr 2025 09:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LALxMtNy"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51517380
	for <linux-nfs@vger.kernel.org>; Sun,  6 Apr 2025 09:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743930686; cv=none; b=BgRNVw2sP9B/ao08RqRvtD1P+v7kzzzf8tUwJ7Fasv3vGvamzLoRjjf1YCj4vPeSHaCFc1den7MsCThUUS/vSuYxgbdukFQnW0RQdQavzVwUSTKnUWnTab4Z14w0K8K0A06klPYRij3hADWzVyMVYr1EKkr5zRX/F+JoUJEa7Ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743930686; c=relaxed/simple;
	bh=FGAT8Ri4QQIa5POSTdOMrQiuQ4X7csUusKYfwpiT15k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oeeEwt63AG8uMLwnFXMICZiGIUvLWav7BTGsBAfQpBCqzwEy0bzn/YlZ/F1lt1pCbl/QFwDD+iCr5nU2k/fW55euHKQN144tA3VfYMhww0QOIyP6GbJTSa79uSGSVDbs4v2pnUzfaT1m5OJUHEGdcmKi9dhaerEp2F6dAOlb61E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LALxMtNy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65A0BC4CEE3;
	Sun,  6 Apr 2025 09:11:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743930685;
	bh=FGAT8Ri4QQIa5POSTdOMrQiuQ4X7csUusKYfwpiT15k=;
	h=From:To:Cc:Subject:Date:From;
	b=LALxMtNyROVPO1Eo7YvyPQJXpkCzeHYfTvhAoXZUlCfIWg89O8wXLoGQF1Fy/j+/+
	 vU/OkL8SrmWZyJISipT7UNIbhkxJ2biFTpHWOLetEqG+/l6vcv1CQh9bCCIcolfnCd
	 4Xt/9Lr121vpTUDgsxs+pkGktNMH1qy3a4JTbRBJlEdyQIPvTafCd2FmDQg1hYfjSz
	 KKusRIHGTvBFSeVY9yaeOG+cOp+NZsDqWY34Uorl6Aq+e3bxNldoDZJRWjPDphDWe/
	 OB0liTRxPuUyTJmv9x+RK+PyjrrbjqEaHjMCQPpyJrbhIVzL8Uaq4OvOHQLSPGAjO9
	 MBcEefYfJbM/w==
From: trondmy@kernel.org
To: Omar Sandoval <osandov@osandov.com>
Cc: Jeff Layton <jlayton@kernel.org>,
	Chris Mason <clm@meta.com>,
	linux-nfs@vger.kernel.org
Subject: [PATCH 0/2] Two more places that need to handle ENETDOWN/ENETUNREACH
Date: Sun,  6 Apr 2025 11:11:19 +0200
Message-ID: <cover.1743930506.git.trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Trond Myklebust <trond.myklebust@hammerspace.com>

Omar Sandoval reports seeing layouts that are leaked when a container is
shut down uncleanly.

Trond Myklebust (2):
  NFSv4: Handle fatal ENETDOWN and ENETUNREACH errors
  NFSv4/pnfs: Layoutreturn on close must handle fatal networking errors

 fs/nfs/nfs4proc.c |  9 +++++++++
 fs/nfs/pnfs.c     | 10 +++++++++-
 2 files changed, 18 insertions(+), 1 deletion(-)

-- 
2.49.0


