Return-Path: <linux-nfs+bounces-16454-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E29BC65023
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Nov 2025 17:01:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5D37F4E207B
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Nov 2025 16:00:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23BE62BDC09;
	Mon, 17 Nov 2025 16:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LM9MnApg"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBC7429E117
	for <linux-nfs@vger.kernel.org>; Mon, 17 Nov 2025 16:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763395254; cv=none; b=JP6cEbHH9WWYW7VB1Ne9GWoT6qyKPYCzeaRX/6wEG5k6ZzRqmKJoIH3j31ddLn81LO2+pg7jocL+ej/EmhHP+ITwAP05iF9Mxcff4PAZxzE9YN2+ykhbwU6urqIU0ahY7NoCtDLxPNXhNdjgkawyS7n6OWoc5Xd7jOwpj9sWJWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763395254; c=relaxed/simple;
	bh=I8irii8FeyT6sKZmRm9SKBRyqUv98lBdfJwqxQCWLQI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mL1/GjTztzBJTJJJ1NThAWY80F5y80x5a0QNsh3Vocl3xGa32k2eju97/Ryrd+i9V20AbfFWrqYwoynn/UKnQ4cAFaK0SierMCNJU74MQVsBiD+z2s7ra8fBMsqRGbtmVU5eZB6O/NvCxLQ/sebUAXskiMiQ4jovE5du+Q6VQYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LM9MnApg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EDC6C19425;
	Mon, 17 Nov 2025 16:00:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763395253;
	bh=I8irii8FeyT6sKZmRm9SKBRyqUv98lBdfJwqxQCWLQI=;
	h=From:To:Cc:Subject:Date:From;
	b=LM9MnApgHGaPKxXr1QAAvwLWz2W8s2dp1c/lSImKMcYi+L0t5Wqa9eDimBm1L8+D1
	 uYxrZUfTu9lo7mrBFVsNA37vSvvTCSD9n6rHhOxfmhlrobWcYiueUDmj5U7Bj+yjgN
	 29LGy1+5FgJnV7D8QDaDNpiGiQVW97Ta1R0Pas6dG2dMu3t7mZlwhz08lEPatnxYev
	 VWmlLYdKp2piA7ilFtE4xfQnYzvEtiP+EegNmOd2sqVvB1uL5tD8urD3pNHu2XmyF+
	 dTvq15Uom4jLr3S48wQhhO0OL0fSznY9Qu3ztgyfCcfiwOaVbiZ9hJBDlvUplIhnjW
	 WNDXUYuX5BusA==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v2 0/3] Update suppattr_exclcreat bitmask
Date: Mon, 17 Nov 2025 11:00:48 -0500
Message-ID: <20251117160051.10213-1-cel@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

While working on some new pynfs tests to verify the behavior of
OPEN(create), I found a couple of bugs in NFSD's suppattr_exclcreat
bitmask.

I've split this into two "fix" patches, because the fixes have
different LTS blast radii. The third patch is a clean-up that
should not be backported.

The new pynfs tests were posted under separate cover.

Changes since v1:
* Address Jeff's review comment

Chuck Lever (3):
  NFSD: Clear SECLABEL in the suppattr_exclcreat bitmap
  NFSD: Clear TIME_DELEG in the suppattr_exclcreat bitmap
  NFSD: Clean up nfsd4_check_open_attributes()

 fs/nfsd/nfs4proc.c | 40 +++++++++++++++++++++-------------------
 fs/nfsd/nfs4xdr.c  |  5 +++++
 fs/nfsd/nfsd.h     |  8 +++++++-
 3 files changed, 33 insertions(+), 20 deletions(-)

-- 
2.51.0


