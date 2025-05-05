Return-Path: <linux-nfs+bounces-11479-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 653F3AAB5E9
	for <lists+linux-nfs@lfdr.de>; Tue,  6 May 2025 07:39:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D99603A2506
	for <lists+linux-nfs@lfdr.de>; Tue,  6 May 2025 05:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E354C4AA751;
	Tue,  6 May 2025 00:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rBpVxkF/"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C40137F947;
	Mon,  5 May 2025 23:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746487333; cv=none; b=sWl9NKPu8k7Lxl12y+ykof2OSAxn14DJzq/k6EckBkscFa6MCUBHlHJ81gHqBsZeu9K7Y4LtfeJITJ5q07rututhAAbhSIMmC1LWBZsQiNJ0aXICb2PywxnPPoLNqFX9i7vOEDdSXi8URkpOF5eIYuSI08JILfM9hzNQQpsC87A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746487333; c=relaxed/simple;
	bh=sPgo/UldMLcbvt6C1XwY2ohaBmrJBOqaeUI3P5ZcP5U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Mi25Hz16pBBqVvZuqoHWL4KGTqmk4pdtyy2REvFIqxhtyEUk2BSH3Q2N/aYrdpRNbqyupMiVFSb2kYS/eTqj5wGZ3seiLnNzUtUQqvU/xt9xThbtTLLC1M1Ub9BUhWnoE3FSachI3xyxqRheMaRhI8MnxCo9rhp1RjGQDnYoUko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rBpVxkF/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F9E4C4CEEE;
	Mon,  5 May 2025 23:22:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746487331;
	bh=sPgo/UldMLcbvt6C1XwY2ohaBmrJBOqaeUI3P5ZcP5U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rBpVxkF/0/s8NRRyS122AtBhf1UlmPYlRsEvgmL4hw/ZkGb8xtog8thF7GoX9qwD3
	 O2R9yhZnd+ykUzM2PpV9mNtib/SY5tNNkr5UmgPMravMseqltWKNpi00wWRCAReMle
	 cWXrc/A1OtJ2+c52S2nQvKkAaq2j+J9+W822l4r/JQxCBFXBMRJxWK2WEKpUCDu+2J
	 xIw4Bh1KDRp5JhNITnDAhNbphem7/pB40aDSDUr4TSBwtgItYLGESHHpRgrBKRfy7R
	 rolYVv1tByJSFyYPJtIyiqoovUg39+4l7dPBh1jNOkbzCjoomU7N6WVfwmS2l6kV/M
	 UMPQiqsfe19Jg==
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
Subject: [PATCH AUTOSEL 5.4 10/79] pNFS/flexfiles: Report ENETDOWN as a connection error
Date: Mon,  5 May 2025 19:20:42 -0400
Message-Id: <20250505232151.2698893-10-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505232151.2698893-1-sashal@kernel.org>
References: <20250505232151.2698893-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.293
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
index 1b88b78f40bea..3b4f93dcf3239 100644
--- a/fs/nfs/flexfilelayout/flexfilelayout.c
+++ b/fs/nfs/flexfilelayout/flexfilelayout.c
@@ -1285,6 +1285,7 @@ static void ff_layout_io_track_ds_error(struct pnfs_layout_segment *lseg,
 		case -ECONNRESET:
 		case -EHOSTDOWN:
 		case -EHOSTUNREACH:
+		case -ENETDOWN:
 		case -ENETUNREACH:
 		case -EADDRINUSE:
 		case -ENOBUFS:
-- 
2.39.5


