Return-Path: <linux-nfs+bounces-7223-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 734AD9A240A
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Oct 2024 15:36:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02241B22A00
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Oct 2024 13:36:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A0511DE2D0;
	Thu, 17 Oct 2024 13:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HSm/dCM4"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ED611DD864
	for <linux-nfs@vger.kernel.org>; Thu, 17 Oct 2024 13:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729172197; cv=none; b=ono6KqAnhzDzD5uQ/1sYFyPxzI+0HRFHwVWpAVVjO4nN6GNYQF6x+gPbhCQs/2vq0OLxDYXdFkJzo4Uoq5M/OcCzcVsVIp4Oy9WUABUzwxVK8BAAcXXTSsCoKlZkoe+VKXcUOyT9dLILQArTOYXGh3k52F4npljT/X+4e5lDsok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729172197; c=relaxed/simple;
	bh=RTvaA6mVHCQ3e4OVh4XlhyJqNDw+iEL9yucTXe1xmaA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Q/nai8OPafxjJ8SnzcSAjkN9qy8td87Zt3fQugiIP0tfRxd8TE8NHqkrIrUqnCYpxXu69vJHladlb8W2nPFrIjSSSEyFyMhxlshIpG1NBV4Np0pSSNYffpL9/wU5CUzzDeYPuGYzq9hq9dDlsSpA0JrJuYWrq8X4RTj8S5JHPUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HSm/dCM4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFFFAC4CEC3;
	Thu, 17 Oct 2024 13:36:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729172196;
	bh=RTvaA6mVHCQ3e4OVh4XlhyJqNDw+iEL9yucTXe1xmaA=;
	h=From:To:Cc:Subject:Date:From;
	b=HSm/dCM4ommrjM0kBjDRmn9hM5Yl0RaV29eG1sLR1e7BUZ1gi4FFHDahvTGcwVCNc
	 PSYwNdERRIjMN8cCagExW8NWpMKvKHTolzSYlkwc5d7jw/Hnaa6W0+/xK11bAs708U
	 2TsAHRjtE7vFL8xS3KLAbYrHUUBsy+FSOf81fJZ04YlEBTjpYtL+oJiDyhbDdmfMrE
	 lTc+5BBBQXNYrxlBVqnXCUAfe+YYBxultzwxqd+GKdB6TPliTEdTYsOVJbQbMIyV6L
	 QJqnCiKje1JXh+WRMf9RE9PtqNDQzmVRSEUziKmu8usvcgvLuo7A/aMhbHgNDjEyM0
	 rBwWCcFSDEH1A==
From: cel@kernel.org
To: Neil Brown <neilb@suse.de>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH 0/5] Simple lockd clean-ups
Date: Thu, 17 Oct 2024 09:36:26 -0400
Message-ID: <20241017133631.213274-1-cel@kernel.org>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

Clean up a few nits I noticed while working on converting lockd to
use xdrgen-generated XDR functions.

Chuck Lever (5):
  lockd: Remove unused typedef
  lockd: Remove unnecessary memset()
  lockd: Remove some snippets of unfinished code
  lockd: Remove unused parameter to nlmsvc_testlock()
  lockd: Remove unneeded initialization of file_lock::c.flc_flags

 fs/lockd/svc4proc.c         | 20 +++++---------------
 fs/lockd/svclock.c          |  2 +-
 fs/lockd/svcproc.c          | 15 ++-------------
 fs/lockd/xdr4.c             |  2 --
 include/linux/lockd/lockd.h |  6 +++---
 include/linux/lockd/xdr.h   |  2 --
 6 files changed, 11 insertions(+), 36 deletions(-)

-- 
2.46.2


