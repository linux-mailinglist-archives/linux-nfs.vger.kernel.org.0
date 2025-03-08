Return-Path: <linux-nfs+bounces-10533-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 53864A57E03
	for <lists+linux-nfs@lfdr.de>; Sat,  8 Mar 2025 21:14:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8102F16C16F
	for <lists+linux-nfs@lfdr.de>; Sat,  8 Mar 2025 20:14:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90D3318FC84;
	Sat,  8 Mar 2025 20:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oo2SQgiK"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 609982A8C1
	for <linux-nfs@vger.kernel.org>; Sat,  8 Mar 2025 20:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741464882; cv=none; b=VvtM7Yvx9SPGFrqC/gqXfaqTZ8I1brLP67CfmvQQp6K4ECQXiOKEN4pNZK2xzRSfLCDfU0EuFTkNFz8cauqov62K74SaOXCL0o3Q2Ovl8KCnYrmrQvAoLIsai6Gx6PUOpsjSizh6CvdsZ5P2Vi+mznpa+Rml03Nw8eF6Qbd4b8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741464882; c=relaxed/simple;
	bh=FwI4KAWaRS0+KBvi0bX7HqFPwK2KuodN15E/0I+ZfLM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mYYW0K94Mk/u6McSfvKXRWdBlJ9nGrBumf6TXmYVzOKjbndzKFQ/wCg594PFuJuYI5umc2mf3i+rRb02h6yyD29RN7dHpzCGGys12LWACTxCN0YK33mMTSb8Hx2Uwn5TnB2k8FrMDPBh2Dc/CsIkMskpB0I9WtsyI9HNlb2MHTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oo2SQgiK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 007E7C4CEE0;
	Sat,  8 Mar 2025 20:14:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741464881;
	bh=FwI4KAWaRS0+KBvi0bX7HqFPwK2KuodN15E/0I+ZfLM=;
	h=From:To:Cc:Subject:Date:From;
	b=oo2SQgiKjb7X1djjpjWdxqpI6Nkk0L3gip0a+R1naDnb7094BlHZhSv2336kC2Ztl
	 dS6DizJd/8hcFr70DswRnyV5p7SY6enmtTIZYTVQdsavtZbpH62RiFw1PnYFStvwQq
	 QrVVPgyFMmfjLHM/7rz/rj2kzCmsxvkJX1VDpMrd3Zueg9S4SQ8kz5zIjG8AQApFi3
	 Vx5nwPohRf63CiAcNuA8DrWwABH4BL8pUu/W2T1lwts6PeeNSfgQGcGl4J0MuGZhTP
	 itGW/uG6mQU5V92L17Ndm3L0C/RntjqjrJa0AqMPF9efDmIFRb5oImCFqfSVMmzU3f
	 VRkbs5pWGki3Q==
From: cel@kernel.org
To: Neil Brown <neilb@suse.de>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [RFC PATCH 0/2] NFSD: add a setting to disable splice reads
Date: Sat,  8 Mar 2025 15:14:36 -0500
Message-ID: <20250308201438.2217-1-cel@kernel.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

The usual policy for kernel-user space APIs is that once a public
API appears, it is difficult to change or remove, in order to
maintain backwards compatibility with user space software.

This series introduces /sys/kernel/debug/nfsd/ where we can
hopefully place ephemeral and undocumented settings for testing NFSD
features that are to be added or deprecated without the worry of
having to support an administrative API forever without change,
amen.

As a first consumer of this user-kernel API, the series adds a
simple disable-splice-read setting, which can force all NFS READ
operations to use vfs_iter_read() rather than page splicing to fill
data content for an NFS reply.

The splice read path is the default on most file systems, so it gets
most of the test experience. The purpose of this new setting is to
enable test runners to force the use of the iov iter path. We are
also interested in comparing the performance of the splice and iter
paths, as a prelude to potentially removing page splicing. This new
setting makes it easy to benchmark either read mode without having
to rebuild the kernel.

We have an eye on a few other consumers, such as uncached I/O and
increasing the maximum r/wsize, for which /sys/kernel/debug/nfsd
might be suitable while their performance impact is studied before
a concrete administrative interface is agreed upon.

Opinions and code review are welcome, as always.

Chuck Lever (2):
  NFSD: Add /sys/kernel/debug/nfsd
  NFSD: Add experimental setting to disable the use of splice read

 fs/nfsd/Makefile  |  1 +
 fs/nfsd/debugfs.c | 47 +++++++++++++++++++++++++++++++++++++++++++++++
 fs/nfsd/nfsctl.c  |  4 ++++
 fs/nfsd/nfsd.h    | 10 ++++++++++
 fs/nfsd/vfs.c     |  4 ++++
 5 files changed, 66 insertions(+)
 create mode 100644 fs/nfsd/debugfs.c

-- 
2.48.1


