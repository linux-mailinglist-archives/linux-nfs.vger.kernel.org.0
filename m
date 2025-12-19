Return-Path: <linux-nfs+bounces-17230-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 70366CD039F
	for <lists+linux-nfs@lfdr.de>; Fri, 19 Dec 2025 15:17:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8F7D83074741
	for <lists+linux-nfs@lfdr.de>; Fri, 19 Dec 2025 14:16:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B20D329E77;
	Fri, 19 Dec 2025 14:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F4Zw7R9a"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA96D328B75
	for <linux-nfs@vger.kernel.org>; Fri, 19 Dec 2025 14:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766153469; cv=none; b=sH+3PXr7CamcxPS3BP/3kEsI9POdqL5Wc8Pt40KgkDEwgFTJV+ckyhEzrRHNO4icoGvNd6w44Arv7wZ2wWiC1HYhxdPVTGeSY0aC8UAVwKvtqjqgM9A07wlh1b4R0bTeFXvFYmIXmRjBK4wnYU44TAOkTUvAWrGAdZcKYnalyvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766153469; c=relaxed/simple;
	bh=JsB6nSx5z3yH70avBNwzT7Aa/rPtnfHDtX4rDqA68k8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CUOaJ+O83Ws05kiUKP5Tzr7wfsZgpTsJReJE/vYgthIaUPDjCA4IYvnIb+a1ZKrecWK3KrZ06Vn2KGTirBPG545DS55vu4T9cr0scCvTYEXoSLt63EQ52Y+4EdOEezoDfoz3LCtBWjx+Df4EH6L9ZIfKvNseKyq45Gn9+HgcFZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F4Zw7R9a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0161AC113D0;
	Fri, 19 Dec 2025 14:11:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766153469;
	bh=JsB6nSx5z3yH70avBNwzT7Aa/rPtnfHDtX4rDqA68k8=;
	h=From:To:Cc:Subject:Date:From;
	b=F4Zw7R9aZ/e6H396Coh/wNsPxiXM+EZwO2iWUGbN1uCjFyPerwlyHCbnfgsGu4NsD
	 /ebxRhJEUvG7jxKYwoxz8fFO9peKEfcKU/G1ZkEXlNoUHIXEApToy7O8udp/TN32Dw
	 3RNM74HMIMDtRO07fRmppByVgu584Z4DMU3ukyFgWbr5DgOmF2i9JGRLp8saHMaPG+
	 rvbBm/VCQVkXmVsEnAN/cQg1JIwf1nzNTJpJqDm8JfpcDS9f7WhYJQj2IrFjvwdsZD
	 a1aytwyyr+DtfdTdyru2amuB88HzPov8ksDfCmyG1Y6Dk7eFjhx5sIdE2KG1+caQ/1
	 RcSPCCxtUEzgg==
From: Chuck Lever <cel@kernel.org>
To: Christoph Hellwig <hch@lst.de>,
	Mike Snitzer <snitzer@kernel.org>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [RFC PATCH 0/2] NFSD: Rate-limiting unstable WRITEs
Date: Fri, 19 Dec 2025 09:11:03 -0500
Message-ID: <20251219141105.1247093-1-cel@kernel.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

Following up on

  https://lore.kernel.org/linux-nfs/99dd427d-a16e-4494-a4b1-ff65488181ee@oracle.com/

Client workloads that are write-intensive can sometimes trigger an
NFSD meltdown (thrashing, livelocking, or becoming unresponsive).
This can happen when clients present NFSD with more UNSTABLE WRITEs
than can fit in the server's physical memory, and the system simply
can't get those dirty pages onto persistent storage fast enough.

In those cases, it makes sense to slow those clients down until the
backlog can be cleared out. NFSD might do this by delaying the
responses to UNSTABLE WRITEs, which in turn leaves unprocessed
ingress WRITEs on the transport queue longer, and thus closes down
the ingress congestion window on the network connection. This
applies direct backpressure on the noisy clients.

NFSD might already be doing this to some extent, but it can be
argued that it is not going far enough.

These two patches fall squarely in the "crazy ideas" category, but
I hope they serve as conversation starters.

Chuck Lever (2):
  NFSD: Add aggressive write throttling control
  NFSD: Add asynchronous write throttling support

 fs/nfsd/debugfs.c | 67 +++++++++++++++++++++++++++++++++++++++++++++++
 fs/nfsd/nfsd.h    | 10 +++++++
 fs/nfsd/vfs.c     | 34 ++++++++++++++++++++++++
 3 files changed, 111 insertions(+)

-- 
2.52.0


