Return-Path: <linux-nfs+bounces-3059-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 44C4D8B5DA2
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Apr 2024 17:28:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D48361F240D5
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Apr 2024 15:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CD6F1272D9;
	Mon, 29 Apr 2024 15:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hott+y2r"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3395D82C67;
	Mon, 29 Apr 2024 15:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714404343; cv=none; b=M5OdSee4Tg0yMqTcGfGNLDPOi5EZzD4TgzgU4BYT3qJOy7pIOkN9YCmH9GWIT42FH/nQakQ8liw1DsY0jJLcuFu3HDcYPJMVk7mImZL7t39AV9m1hwuu5V/vBR5gvQGZTobtroUNIcErNRDY2je909V1iWYBmAYl7tjYVd6OiEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714404343; c=relaxed/simple;
	bh=Nvcwqi/JSP4Fhbo71YyXgtxpeisMm8rSgs1Dbp4oljk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XbaB9ynAD8yCbMaUnA4EbjSXhwg75VFq9QGilonoNNoM+lxGeyvQmmZSS20i5iCtAzR+bGBJJIDaCUmFCfBrSqEi/FqlDkswsZveoLw0GsLCbuSioiLWZAifFyLmG4+yaSjSIIAJ9bfW8Sc5W6PODKNKFuTs2lVUAdQ61Zqs59Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hott+y2r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64727C113CD;
	Mon, 29 Apr 2024 15:25:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714404342;
	bh=Nvcwqi/JSP4Fhbo71YyXgtxpeisMm8rSgs1Dbp4oljk=;
	h=From:To:Cc:Subject:Date:From;
	b=hott+y2rcc6x3kgf/AXA2UupGfnPCcFjiagPRb6gkYB5QuT0c44wrQdtW8E++2EfD
	 6JN95CC9VyeywQ5Bdg+3MxAGv4EgaA5LAGUuU9+47mwgf3sQ4e3eyIdDt991lhoP4A
	 297w5S4JnCTsXf1Y1tBheC6xx97Rz8aL1nyjBmdcy0x11WFN/uzCm4z2M5Hb2ZQR1m
	 4mA1qK+LvI+QtvJjeaxV3eVDfrP8+Q+DQlLRPtaT62BT1hk0QHQJrAhMwdQoANHi5m
	 eM39QW49dt2AGRe7JT2guzfxygkriw3p5rWaxdCQIVcCnFSX7XYTno1gMQFdokGyph
	 UHBNSig6h4EeA==
From: cel@kernel.org
To: <linux-nfs@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>
Subject: [RFC PATCH 0/4] NFS: Fix another 'check_flush_dependency' splat
Date: Mon, 29 Apr 2024 11:25:38 -0400
Message-ID: <20240429152537.212958-6-cel@kernel.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=820; i=chuck.lever@oracle.com; h=from:subject; bh=ehbD3/S7mhS+jgygwtCjQVF0/71HIC906v3+Bs5am9w=; b=owEBbQKS/ZANAwAIATNqszNvZn+XAcsmYgBmL7vxjkHAUWkbCWUqHXLedTgQCYXeSADDnD370 bvB9qKt+6uJAjMEAAEIAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCZi+78QAKCRAzarMzb2Z/ l8sZEACKnp4W1TfbQzLSrGTnoydNRgVCPSqDF3CwNtOiMrxWhjzxZlYSXq7vMiS12t2t3AP0UM1 GQIXH8KWhN6/TEPQbanWj0mstCp1Kid56uTb4xZjMnQk461GKxi1uEyCV3AOIR5rVLRPdyqIMoL Ryn6FuSLqjIYNMc1vl3+wb1izfeu9exDHY0MRMMgdsBmY+adbY5Xq8bbwtIvxWhUOinqot35sVf +cfbl7cfzRHIexqMxyY8354P7Zx9Ysvgw34qOQeR+Nr8cYMowNPNN9dggEFBiyVTnVpCXuItOel SASnwXMcrxfVdNQRcZrxVhbboaaPP03X10n9CDmmFqOJmGYw/sDSnFIHIy0wI9+4fIQpljEN7IL daE8oVA7fgPcVsMkDMlw5nYGGHlVjmfnk0wRifYuOJfJ8hAy7s3IkFOMQQDYPoyeZSTB4LeGg4S f3cw8+Vdlwh6SKwL53amC9dCSap5/768Omphw3X2zqmVarXM/sPBwfFjUJzlpZs7YZXcqXBv4Mh zV3C4C8qRmd0zcZDv4dvi8iiAHywp365eRW4g4jkZVtOJLq+u2V/2TvHiirdtX3iCSVJm3ja0VN 6ppeOTF2yJgOY18M6jpKQcb4RCTD7NnskhiBiTnAGskEAmBf7w+UKuOannxGRSoqk2bIE2n6I0c ua4q8jYLitZbTGA==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp; fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

Avoid getting work queue splats in the system journal by moving
client-side RPC/RDMA transport tear-down into a background process.

I've done some testing of this series, now looking for review
comments.

Chuck Lever (4):
  xprtrdma: Remove temp allocation of rpcrdma_rep objects
  xprtrdma: Clean up synopsis of frwr_mr_unmap()
  xprtrdma: Delay releasing connection hardware resources
  xprtrdma: Move MRs to struct rpcrdma_ep

 net/sunrpc/xprtrdma/frwr_ops.c  |  13 ++-
 net/sunrpc/xprtrdma/rpc_rdma.c  |   3 +-
 net/sunrpc/xprtrdma/transport.c |  20 +++-
 net/sunrpc/xprtrdma/verbs.c     | 173 ++++++++++++++++----------------
 net/sunrpc/xprtrdma/xprt_rdma.h |  21 ++--
 5 files changed, 125 insertions(+), 105 deletions(-)


base-commit: e67572cd2204894179d89bd7b984072f19313b03
-- 
2.44.0


