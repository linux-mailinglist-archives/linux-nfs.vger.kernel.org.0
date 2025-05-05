Return-Path: <linux-nfs+bounces-11452-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 71FA2AAA8BC
	for <lists+linux-nfs@lfdr.de>; Tue,  6 May 2025 03:00:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E48D1883FEE
	for <lists+linux-nfs@lfdr.de>; Tue,  6 May 2025 01:00:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 969BF353132;
	Mon,  5 May 2025 22:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EYTFarP0"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B07035312D;
	Mon,  5 May 2025 22:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484853; cv=none; b=koNmCHtH3pYCD0tSK+oeYdRpEU8XCbMEdW2pXtTpsNr6A4e2GeIJg2Xm5Al29mL/xBUckkqksW2rfSskWJlxinF0LyZ1c1LtAx0hOQ3xG0MqKAkgYvfevpDlX5nk6CrYbLxYXK3O7jdPFWypmtnyWep2EshUkJWjLpXF8naPpL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484853; c=relaxed/simple;
	bh=XrGO8P+YffZSIpEoneWQXS+9pqXqUkXKkqJSg7MUOYc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=V4tsSvER2lgerq1G7tTXtwEEs0tW5z66oLz09JlpImDXA61qX8PdpRLCcrK81bGQLiL0k1jhDP3finY25cPnQoddmCMGSIfTvCy5mZ3uhG2zibYVeGbhA4N6sxo9nrHfjED5rDbPXnV2xLWfFiEM4bsGfODGaRc8uSKgXWQM4ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EYTFarP0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D5B2C4CEE4;
	Mon,  5 May 2025 22:40:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746484853;
	bh=XrGO8P+YffZSIpEoneWQXS+9pqXqUkXKkqJSg7MUOYc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EYTFarP0wefoNM8YSbntav3iCHTgqSjbVL7zuWcYkQ9UzvzCjxUwItVYPdbM2AZfm
	 jPEz2YM+Bt4nfeP+1eIG7RX1jG5/Ci2aYlGPozmZ+KrBtddCRnnqg6PpRODoPmwffR
	 QXeAtcrRWtgDEoB0vlLF5WZEPaz6EVfDVtp+QY323/h2sRSnpz84UGH8SThhaMc5hk
	 +zcdKtTZ1OfnhhmtU8EgaJ9BnZKGfoEqHdfCzJxVxOrHx6Eu1yuEQRcgQrrO6qUOTA
	 0JmNVQT0ZUvXJNHtB861WhKLDqn1Rz4Dm/rWojS1yFLh8DPwmpO61z1SKK99pcL+ha
	 PdIi1HzupZtAg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Trond Myklebust <trond.myklebust@hammerspace.com>,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>,
	trondmy@kernel.org,
	anna@kernel.org,
	snitzer@kernel.org,
	neilb@suse.de,
	kolga@netapp.com,
	linux-nfs@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 048/486] pNFS/flexfiles: Report ENETDOWN as a connection error
Date: Mon,  5 May 2025 18:32:04 -0400
Message-Id: <20250505223922.2682012-48-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505223922.2682012-1-sashal@kernel.org>
References: <20250505223922.2682012-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.26
Content-Transfer-Encoding: 8bit

From: Trond Myklebust <trond.myklebust@hammerspace.com>

[ Upstream commit aa42add73ce9b9e3714723d385c254b75814e335 ]

If the client should see an ENETDOWN when trying to connect to the data
server, it might still be able to talk to the metadata server through
another NIC. If so, report the error.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Tested-by: Jeff Layton <jlayton@kernel.org>
Acked-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfs/flexfilelayout/flexfilelayout.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/nfs/flexfilelayout/flexfilelayout.c b/fs/nfs/flexfilelayout/flexfilelayout.c
index a1cfe4cc60c4b..8f7ea4076653d 100644
--- a/fs/nfs/flexfilelayout/flexfilelayout.c
+++ b/fs/nfs/flexfilelayout/flexfilelayout.c
@@ -1263,6 +1263,7 @@ static void ff_layout_io_track_ds_error(struct pnfs_layout_segment *lseg,
 		case -ECONNRESET:
 		case -EHOSTDOWN:
 		case -EHOSTUNREACH:
+		case -ENETDOWN:
 		case -ENETUNREACH:
 		case -EADDRINUSE:
 		case -ENOBUFS:
-- 
2.39.5


