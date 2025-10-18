Return-Path: <linux-nfs+bounces-15359-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 96FA8BEC320
	for <lists+linux-nfs@lfdr.de>; Sat, 18 Oct 2025 02:54:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7D6914E0FF4
	for <lists+linux-nfs@lfdr.de>; Sat, 18 Oct 2025 00:54:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C514413AD26;
	Sat, 18 Oct 2025 00:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nUdXrNFO"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E7E172602
	for <linux-nfs@vger.kernel.org>; Sat, 18 Oct 2025 00:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760748874; cv=none; b=H87WxNdkIyZmLodjB1EwAN9BzEKYxf3PBHq4vJ+DGzzeZtIU195G3LQnI2ddmgwLvtJOxdY0hc53efK4YIkPSUew/JgMNn1H5JJawTRl4DnpZOH2j4EqPfTB0PDoBAJqBtp3kIA1Lx5JzT81AnLfsatfeeIaAkTNqCUCY+6Hiig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760748874; c=relaxed/simple;
	bh=tKsnFikgokSwQ6gz83wWFHIYN4HmEMZBsbBQLD9B+H4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=thoSiOE+/SKgZE9A5Y/hkRSn3UY4fO3xFe41Gwc5NRl4FvWf4E53BR7+oUJuT7jjHTi46YaRIqnR1EHgL9If73/ld/mTj1Cb/5YIy58iaYrnnR3eEz9RUGDwxG/KAQmKJ3mxN5ndUuapZD7MWnfWclOj4AAokN+AhDUSwajrobM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nUdXrNFO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4E71C4CEE7;
	Sat, 18 Oct 2025 00:54:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760748874;
	bh=tKsnFikgokSwQ6gz83wWFHIYN4HmEMZBsbBQLD9B+H4=;
	h=From:To:Cc:Subject:Date:From;
	b=nUdXrNFOKuBk7Tjbj/z7xigdSUDjEB3aP9YEKMoNHyctzEwczhw769QaqI5qSJ+UO
	 nyMRe25VgySkZLJqrb+4e/KQCg3Gag+qf2KgX1MrekRX+9G9bTIbZ116RWPdGUq0cO
	 9YV2ZttwSOHeI7bMOg5YEPFqsm7nGOkSZQBqGvkZQwCfBinjVKuq/2Mc1JiomfLNbq
	 7TWCRRu4RFJ2yQqBORMSP+e+lNelJFL6BSZOLowfOOyzaZmPiIP1/1OXG2xRSfdfQ3
	 xU8aKKc71vJ0vMfv2WJTCznSum4gzc2CeQAWPiANrYBSYfM8BZLA59qKf30xjNfdn3
	 jdJvpIFbmuJGw==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v4 0/3] NFSD: Implement NFSD_IO_DIRECT for NFS WRITE
Date: Fri, 17 Oct 2025 20:54:28 -0400
Message-ID: <20251018005431.3403-1-cel@kernel.org>
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
this series applies on the nfsd-testing testing branch and includes
both patches needed to make NFSD Direct WRITE work.

Changes since v3:
* Address checkpatch.pl nits in 2/3
* Add an untested patch to mark ingress RDMA Read chunks

Chuck Lever (2):
  NFSD: Enable return of an updated stable_how to NFS clients
  svcrdma: Mark Read chunks

Mike Snitzer (1):
  NFSD: Implement NFSD_IO_DIRECT for NFS WRITE

 fs/nfsd/debugfs.c                       |   1 +
 fs/nfsd/nfs3proc.c                      |   2 +-
 fs/nfsd/nfs4proc.c                      |   2 +-
 fs/nfsd/nfsproc.c                       |   3 +-
 fs/nfsd/trace.h                         |   1 +
 fs/nfsd/vfs.c                           | 233 +++++++++++++++++++++++-
 fs/nfsd/vfs.h                           |   6 +-
 fs/nfsd/xdr3.h                          |   2 +-
 net/sunrpc/xprtrdma/svc_rdma_recvfrom.c |   5 +
 9 files changed, 239 insertions(+), 16 deletions(-)

-- 
2.51.0


