Return-Path: <linux-nfs+bounces-13796-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C792B2DF6A
	for <lists+linux-nfs@lfdr.de>; Wed, 20 Aug 2025 16:33:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41CF61C81C2A
	for <lists+linux-nfs@lfdr.de>; Wed, 20 Aug 2025 14:28:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01A0D276056;
	Wed, 20 Aug 2025 14:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AvKmyF/l"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D20D5276050
	for <linux-nfs@vger.kernel.org>; Wed, 20 Aug 2025 14:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755699935; cv=none; b=ppCTuO8tDWBz0goyvakX8M7cqtTmBE17ymKQkNPdFG/XeF4tazApiTs71l3ReHygky6cMey49wK37VsObPSgzcCsNISjxajw7ua3CHKsQ7VnZXtXTsBQ776ylMqq75542PyreTXEGgnEf//CbMnGHUpHTKdSw54agJ4yZ1YTRtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755699935; c=relaxed/simple;
	bh=yblCosbI4Ae0bCx42Vv0eFL4utB3V7sLQiwWW1d7J1E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CFlEtA5XFV54V/+DhPvjmRUhqVvWzGLuzPzu6fgvYQlmbxiZWThjxlgW9TWwvUpQ1ouWDOkpqJDfhNVA/I8uIpY1GiZnyjVpWvWgQxe0PTqEc0FnIyFZHpOaRT5fzvMUo3B+b7cdkqTu0kFzx08qasL1mi4KclMrMtVLMj2/6Q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AvKmyF/l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C71E2C4CEEB;
	Wed, 20 Aug 2025 14:25:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755699935;
	bh=yblCosbI4Ae0bCx42Vv0eFL4utB3V7sLQiwWW1d7J1E=;
	h=From:To:Cc:Subject:Date:From;
	b=AvKmyF/l6K54CTgrYd9LbzDUlr9BXhvTuf4UMkB5OQcv4jj7Fw55MixJNPy3lXipz
	 FdCNQyF0ndA5rxc5nwNPVYkvJ3V8TLKFj4reoGEqnLdIleUd3QT0SktxKtX6up/7Ox
	 EfUGP2fAf7Kqk7+ZiffGEFFX/vKQRChG2+LD13Y3Xtg+uBaE1Uqw6gBaqIsPL9YI8y
	 Ed/kvMGCikqHOmSnZgYWrWEjiac/GNxGsIayhU5a8PyaR60YPy4CZL3FEpXkC2ESb7
	 AMf51VAdTQ4P+3d7KmtQSfrUAa1OqRWhsUf2xoCiYRvASrTVSryJf6TwVAjQlhQfp2
	 jwWA0HI28KP2g==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v1 0/2] NFSD duplicate reply cache optimizations
Date: Wed, 20 Aug 2025 10:25:30 -0400
Message-ID: <20250820142532.89623-1-cel@kernel.org>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

Two minor optimizations for the NFSD duplicate reply cache. These
showed slight improvement in WRITE throughput on exported fast
file systems.

Chuck Lever (2):
  NFSD: Delay adding new entries to LRU
  NFSD: Reduce DRC bucket size

 fs/nfsd/nfscache.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

-- 
2.50.0


