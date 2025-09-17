Return-Path: <linux-nfs+bounces-14510-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 57DA5B800B6
	for <lists+linux-nfs@lfdr.de>; Wed, 17 Sep 2025 16:35:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFCDE18841F5
	for <lists+linux-nfs@lfdr.de>; Wed, 17 Sep 2025 14:32:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14DC72D46A4;
	Wed, 17 Sep 2025 14:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HmW8r71j"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E54B12E228D
	for <linux-nfs@vger.kernel.org>; Wed, 17 Sep 2025 14:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758119496; cv=none; b=TX1+261EobCTcH3e5PVVzrclGvlVYGf5w7/QhYIzPU7VPUSe4rON7RlVi026RBuySyc52W07j8x8AS2RvLRohxJBZnNvNwwXZN5mrGpSNvP7ERPSt93m3T61ynZyum0+GTdz3PZTUJrFW2tNuGrtJRaPjBrjB4Crz17m2S9Ksrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758119496; c=relaxed/simple;
	bh=VA1HqZ4pcd10J+8wCVp4G5+Uz/Jec+eMYbL05fjrQ9A=;
	h=Subject:From:To:Cc:Date:Message-ID:MIME-Version:Content-Type; b=sPljeCHI/K9AlDmT99A22bNanuuSE/QxnqsHFkCJM3US0wgWfw7JgSTf8RME9HgRjEdAF0zUOIR2Mk1F1ncYlQsmgbp9idLrw+5ryl+QkB4gHfpdhosW1AVJUeBDwYayRXeIJXB4SiV709MDjV2jUFFJx8Y2f4rGU3L+Odq3K3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HmW8r71j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED800C4CEF0;
	Wed, 17 Sep 2025 14:31:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758119495;
	bh=VA1HqZ4pcd10J+8wCVp4G5+Uz/Jec+eMYbL05fjrQ9A=;
	h=Subject:From:To:Cc:Date:From;
	b=HmW8r71jks3/cec3JfjA8tyFBl6CvVnKgEnMG3ffLqa/e2vETKJ1sNE/+yciQ783i
	 DZqjtM1x2VLfhXeyiXbHj8kwPZPzBDAGT8Eg6pMcii6qoi3d6g9qcBq+dqfJ3RC4jk
	 MmGBEjbM3KXDHXf51RYQ0T7PvSzlmKR8NWbr/JHjTUAY1/X9KwGXeXonkJOJL8THzH
	 5sbbzECgi7JiXH9Q1LXlJh01TrCaHvaPPPv3/GbKFK+mH8km8DOI4yhbaiynsQRi/A
	 90KV6mKcsS+x0P+N6MisasALouvj6O2ibHOaknbDKkX6SJXTD2JEA6h22/TPFR1GUS
	 oHOzFXhFx+KSQ==
Subject: [PATCH v2 0/4] NFSD direct I/O read
From: Chuck Lever <cel@kernel.org>
To: neil@brown.name, jlayton@kernel.org, okorniev@redhat.com,
 dai.ngo@oracle.com, tom@talpey.com
Cc: linux-nfs@vger.kernel.org
Date: Wed, 17 Sep 2025 10:31:33 -0400
Message-ID: 
 <175811882632.19474.8126763744508709520.stgit@91.116.238.104.host.secureserver.net>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The goal is to get the experimental read-side direct I/O
implementation merged sooner. We are still thinking through the
implications of mixing direct and buffered I/O when handling an
NFS WRITE that does not meet the dio alignment requirements.

Changes since v1:
* Harden the loop that constructs the I/O bvec
* Address review comments

Changes from Mike's v9:
* The LOC introduced by the feature has been reduced considerably.
* A new trace point in nfsd_file_getattr reports each file's dio
  alignment parameters when it is opened.
* The direct I/O path has been taken out-of-line so that it may
  continue to be modified and optimized without perturbing the more
  commonly used I/O paths.
* When an exported file system does not implement direct I/O, more
  commonly used modes are employed instead to avoid returning
  EOPNOTSUPP unexpectedly.
* When NFSD_IO_DIRECT is selected, NFS READs of all sizes use direct
  I/O to provide better experimental data about small I/O workloads.

---

Chuck Lever (2):
      NFSD: Add array bounds-checking in nfsd_iter_read()
      NFSD: Implement NFSD_IO_DIRECT for NFS READ

Mike Snitzer (2):
      NFSD: filecache: add STATX_DIOALIGN and STATX_DIO_READ_ALIGN support
      NFSD: pass nfsd_file to nfsd_iter_read()


 fs/nfsd/debugfs.c       |   2 +
 fs/nfsd/filecache.c     |  34 ++++++++++++++
 fs/nfsd/filecache.h     |   4 ++
 fs/nfsd/nfs4xdr.c       |   8 ++--
 fs/nfsd/nfsd.h          |   1 +
 fs/nfsd/nfsfh.c         |   4 ++
 fs/nfsd/trace.h         |  28 +++++++++++
 fs/nfsd/vfs.c           | 100 ++++++++++++++++++++++++++++++++++++----
 fs/nfsd/vfs.h           |   2 +-
 include/trace/misc/fs.h |  22 +++++++++
 10 files changed, 192 insertions(+), 13 deletions(-)

--
Chuck Lever


