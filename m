Return-Path: <linux-nfs+bounces-15409-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 84579BF268A
	for <lists+linux-nfs@lfdr.de>; Mon, 20 Oct 2025 18:27:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13B8A18A807C
	for <lists+linux-nfs@lfdr.de>; Mon, 20 Oct 2025 16:26:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BD48286422;
	Mon, 20 Oct 2025 16:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CnSMlkaI"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBD1928504F
	for <linux-nfs@vger.kernel.org>; Mon, 20 Oct 2025 16:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760977550; cv=none; b=AW6RKow+Gsl9cVB2yYfkJAbYGZDAQApVqXsA4ZnFzaQ17+zSDcOOYnYLTd4KOl2k9zKop7pmcivtked42DamaHxeECRSQfUTwmjT8YQc4Yh/rZwJzpVN13UF+7LzNEqHHS9S2FKjimLchIhvvmJp+gKw2Xd+OWKGFLlKjS58o/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760977550; c=relaxed/simple;
	bh=eCCCw02MfuHoH+LsVDr7VOq1zJ4jlVxEYfPD09HPAqE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JIClqHtDGYauNtdKyrHjEgVSzBSys8S9Mq2C3kYQvsxKlDFfwIHj8+NZNQVDki9OiqOD+I5JoMlfhLEfezbACPmWa61QalWan6fUnC9wjMGNCOE7VuPsw6hIIPDD5JgXKyZlDPmk9RWjmNgdRihWhXSHVy63++YcAy97dFl+sDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CnSMlkaI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2A72C4CEF9;
	Mon, 20 Oct 2025 16:25:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760977550;
	bh=eCCCw02MfuHoH+LsVDr7VOq1zJ4jlVxEYfPD09HPAqE=;
	h=From:To:Cc:Subject:Date:From;
	b=CnSMlkaIvzOmbbw9NhyS1ZByte8GNry442VW6qZx8H0MSllx2wuEgKoEoPR3Cz6HL
	 xC9cGuOl3A5RiJnV6zyFos1TNmZtYOUcs7B2VymZZOoWsE6+fhVzYksYFOxel7ehEI
	 wX8KmgwSSFG6s205msnZPQUehBsLyzxxnuiU2G5jCRntpiESUzxqMB70nGx5nb51yS
	 MWr1arqmxBlS/MC9RvULnl8Bl9uKtd7V75smZoqCHadU4k7O80vG9xCQQKck/AUdJc
	 m0llbVppPdQjgkb/6YL37hX3+2nQ7DWYUPRblHa08DypKVAARLgpnagpulK0GOYuu9
	 2AgRCjOFz082g==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v5 0/4] NFSD: Implement NFSD_IO_DIRECT for NFS WRITE
Date: Mon, 20 Oct 2025 12:25:42 -0400
Message-ID: <20251020162546.5066-1-cel@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

Following on https://lore.kernel.org/linux-nfs/aPAci7O_XK1ljaum@kernel.org/
this series includes all patches needed to make NFSD Direct WRITE
work, plus an experimental follow-on patch.

Mike, just send along any responses to review comments as patch
snippets and I will apply them as needed.

Changes since v4:
* Split out refactoring nfsd_buffered_write() into a separate patch
* Expand patch description of 1/4
* Don't set IOCB_SYNC flag

Changes since v3:
* Address checkpatch.pl nits in 2/3
* Add an untested patch to mark ingress RDMA Read chunks

Chuck Lever (3):
  NFSD: Enable return of an updated stable_how to NFS clients
  NFSD: Refactor nfsd_vfs_write()
  svcrdma: Mark Read chunks

Mike Snitzer (1):
  NFSD: Implement NFSD_IO_DIRECT for NFS WRITE

 fs/nfsd/debugfs.c                       |   1 +
 fs/nfsd/nfs3proc.c                      |   2 +-
 fs/nfsd/nfs4proc.c                      |   2 +-
 fs/nfsd/nfsproc.c                       |   3 +-
 fs/nfsd/trace.h                         |   1 +
 fs/nfsd/vfs.c                           | 231 +++++++++++++++++++++++-
 fs/nfsd/vfs.h                           |   6 +-
 fs/nfsd/xdr3.h                          |   2 +-
 net/sunrpc/xprtrdma/svc_rdma_recvfrom.c |   5 +
 9 files changed, 237 insertions(+), 16 deletions(-)

-- 
2.51.0


