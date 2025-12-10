Return-Path: <linux-nfs+bounces-17016-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CF895CB17C6
	for <lists+linux-nfs@lfdr.de>; Wed, 10 Dec 2025 01:29:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B4D5C30D64B5
	for <lists+linux-nfs@lfdr.de>; Wed, 10 Dec 2025 00:28:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FF0D199385;
	Wed, 10 Dec 2025 00:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S4hgsWw8"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C1AE7260F
	for <linux-nfs@vger.kernel.org>; Wed, 10 Dec 2025 00:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765326535; cv=none; b=k+709m0Ak5e2RTpOuqXEuTIR+SB7OjDyTPAQZQ1zgjwo3rIE55DHoPEDo2qF5jGTb3Qi6y57kt4ZQHaABG84Lx+4rZuk/p2DWSqBNZS+xfdxRti3+7Lj6s0kHdC68RbdfwT8JdOb2wGPIv7K7v6XiZ6d2qTBQuD7ojDMPV0jbr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765326535; c=relaxed/simple;
	bh=EjBxjIJw77f79PfQHtOS0E6qZnY/YNG1fGwLEbWF+E4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=thXHkVBQb8A6T6yYLF+GHONQ9uYOelmREQIQwXtSK7j7n76X3VAVW0Q859uWZr1r7i0Sd0QeC70iUTOINFKUY48dSjkDJLzErIYy1qhBdH0nT61DAd/vlCKQVNXAluXWUBcSY/fk/UICXP/EDRlyavPDzKgXMNlVFSrQozmbQ78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S4hgsWw8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06B29C4CEF5;
	Wed, 10 Dec 2025 00:28:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765326534;
	bh=EjBxjIJw77f79PfQHtOS0E6qZnY/YNG1fGwLEbWF+E4=;
	h=From:To:Cc:Subject:Date:From;
	b=S4hgsWw8tgOYMoeEPUh9VNXWS/Lr5FN9k/jqGB6ovBhLkMRs2vvSRWdML6s9VRlmq
	 yQny7sVQr+9F+2EddEELIK1o2Yj0g/EDO4NO7Rb8XaVOhBz0a5JMvq1IdUvvUFGMwL
	 hiQx6DyzebHUqEdOfos3/wp4b3ajXIjxF0CipbVmNCAa4WiUkts5j9sx1V82EJWK8Q
	 cExwHzhFeIe8xvtLcddkdihKP3at7w2R08adWLWip9imJdyGUfLPwJ1OEVmXyA/XDd
	 +a0+x7bnF7tc/5b2Tt9QuHYfZGhfFpS1QlX5qt4K4vyHkH2GqtWnecL8XScZyM9wot
	 gHxKB082/t/ig==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH 0/2] Address minor issues with status codes
Date: Tue,  9 Dec 2025 19:28:48 -0500
Message-ID: <20251210002850.318350-1-cel@kernel.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

Here are two examples of minor bugs I found when comparing NFSD's
human-generated status code definitions with equivalent xdrgen-
generated headers.

Chuck Lever (2):
  NFSD: Remove NFSERR_EAGAIN
  NFS: NFSERR_INVAL is not defined by NFSv2

 fs/nfs_common/common.c   | 1 -
 fs/nfsd/nfs4proc.c       | 2 +-
 fs/nfsd/nfsd.h           | 1 -
 fs/nfsd/nfsproc.c        | 2 +-
 include/trace/misc/nfs.h | 2 --
 include/uapi/linux/nfs.h | 3 +--
 6 files changed, 3 insertions(+), 8 deletions(-)

-- 
2.52.0


