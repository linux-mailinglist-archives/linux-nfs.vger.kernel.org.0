Return-Path: <linux-nfs+bounces-6404-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E3B259769DC
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Sep 2024 15:02:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 74A00B21006
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Sep 2024 13:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44E6C19EEA1;
	Thu, 12 Sep 2024 13:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NolcgDpl"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D75A1E4AF;
	Thu, 12 Sep 2024 13:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726146161; cv=none; b=mDYnpatgwjQglIEA8siaLaXNEPSf2vqyCnrtGrMb+lkUDEkL04Y/cAkRsGFeILk27/wGbfXOkVlxm5Aiy5Mh1lkCieBIF21c6hmbx6a/c+cyzE+Hg39WcgHWkRsHq5YoZK3DxQXHJPefPbN85Z/sshW8vCMA7jF7BxZ7+XHh0Vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726146161; c=relaxed/simple;
	bh=eJXI6jnCMPp6vz+/hYERZQHNlMmq2KALs+jT51lwMmw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=NTTekCRCChdE0ccPcc/DMAyvTWFibXDcoZ6K6X3jGScfUwuxN7P45L1zp1kjvQ3prKOTELx9F7zEZNh8DvSBYJwmlCg5YQCerLK0fxMnJhK/1nGPOs9A+HrnqlyDPkQ/JjUhK2KQmBgon+RmPWMkvqQJRcKBX0Y5XWi1LrZLLTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NolcgDpl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98A0DC4CEC4;
	Thu, 12 Sep 2024 13:02:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726146160;
	bh=eJXI6jnCMPp6vz+/hYERZQHNlMmq2KALs+jT51lwMmw=;
	h=From:To:Cc:Subject:Date:From;
	b=NolcgDplMxVxIbnG5lqDPiRbmh0v/Y91ofL9A48OnyqfWIfGaCoZSdRTQ1gvGeHf/
	 E+Iv0wus2fhsHM0HlBqFHebXjs32D0ce/iRMkWKTebHql5GsBv8i3yy0jMOGhrUf8N
	 ZiXfOZz5W0m0cCOA2FT7p5YDcWdwl0rybXMOJ1VT1yYyapyuPYy2daQixgJHXv+c/r
	 WWTkxD+qMVgbmZvSzA4iRCT+2x9dXYy7A4hEfiiQfRUBnp3Pkveky5egrd29OAImvV
	 ON1nNqc8RTGga2ky2cbkhUxe4lxqks4bKcZLdPNQivE6BmjAOja4zCujcqAmcy7aX4
	 +cBk0DUqFVB+Q==
Received: by pali.im (Postfix)
	id 69A405E9; Thu, 12 Sep 2024 15:02:35 +0200 (CEST)
From: =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/5] nfs: Fix mounting NFS3 AUTH_NULL exports
Date: Thu, 12 Sep 2024 15:02:15 +0200
Message-Id: <20240912130220.17032-1-pali@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Linux NFS3 kernel client currently has broken support for NFS3
AUTH_NULL-only exports and also broken mount option -o sec=none
(which explicitly specifies that mount should use AUTH_NULL).

For AUTH_NULL-only server exports, Linux NFS3 kernel client mounts such
export with AUTH_UNIX authentication which results in unusable mount
point (any operation on it fails with error because server rejects
AUTH_UNIX authentication).

Half of the problem is with MNTv3 servers, as some of them (e.g. Linux
one) never announce AUTH_NULL authentication for any export. Linux MNTv3
server does not announce it even when the export has the only AUTH_NULL
auth method allowed, instead it announce AUTH_UNIX (even when AUTH_UNIX
is disabled for that export in Linux NFS3 knfsd server). So MNTv3 server
for AUTH_NONE-only exports instruct Linux NFS3 kernel client to use
AUTH_UNIX and then NFS3 server refuse access to files with AUTH_UNIX.

Main problem on the client side is that mount option -o sec=none for
NFS3 client is not processed and Linux NFS kernel client always skips
AUTH_NULL (even when server announce it, and also even when user
specifies -o sec=none on mount command line).

This patch series address these issues in NFS3 client code.

Add a workaround for buggy MNTv3 servers which do not announce AUTH_NULL,
by trying AUTH_NULL authentication as an absolutely last chance when
everything else fails. And honors user choice of AUTH_NULL if user
explicitly specified -o sec=none as mount option.

AUTH_NULL authentication is useful for read-only exports, including
public exports. As authentication for these types of exports do not have
to be required.

Patch series was tested with AUTH_NULL-only, AUTH_UNIX-only and combined
AUTH_NULL+AUTH_UNIX exports from Linux knfsd NFS3 server + default Linux
MNTv3 userspace server. And also tested with exports from modified MNTv3
server to properly return AUTH_NULL support in response list.

Patch series is based on the latest upstream tag v6.11-rc7.

Pali Rohár (5):
  nfs: Fix support for NFS3 mount with -o sec=none from Linux MNTv3
    server
  nfs: Propagate AUTH_NULL/AUTH_UNIX PATHCONF NFS3ERR_ACCESS failures
  nfs: Try to use AUTH_NULL for NFS3 mount when no -o sec was given
  nfs: Fix -o sec=none output in /proc/mounts
  nfs: Remove duplicate debug message 'using auth flavor'

 fs/nfs/client.c | 14 ++++++++++-
 fs/nfs/super.c  | 64 +++++++++++++++++++++++++++++++++++++++----------
 2 files changed, 65 insertions(+), 13 deletions(-)

-- 
2.20.1


