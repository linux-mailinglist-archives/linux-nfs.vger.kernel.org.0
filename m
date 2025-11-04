Return-Path: <linux-nfs+bounces-16003-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 57E1EC31CAE
	for <lists+linux-nfs@lfdr.de>; Tue, 04 Nov 2025 16:16:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D6F7F4EA640
	for <lists+linux-nfs@lfdr.de>; Tue,  4 Nov 2025 15:06:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A889218AD4;
	Tue,  4 Nov 2025 15:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iYzHxkBl"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 447B67260A
	for <linux-nfs@vger.kernel.org>; Tue,  4 Nov 2025 15:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762268807; cv=none; b=dxcw6kDQjxcysdNJXNlGut1fiR3IxF5UXXMRdMEuP4ZxaLL8plRL/bksTZDCfN/dTBqU7vzTALgnbR58tY4uAdN5davoxtwErHrSJsUYc8yPbN8LpLu5PIvsB4H0ejkh25aYQf4BvGP2BVlv/zz8dUt0mzPQSFbCWCN0uuTTXOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762268807; c=relaxed/simple;
	bh=q9jHcrIwdfK0IwEfsVzpj/AG8cjBsQIFlmpCQFRO70o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZNow8UPIrdo0AMV/89qZXS7Tc1cBOux0NtXxqbt79lqKNxgOR9Kiya9Y8hVyvkCsDer+5ATNdkCBO6F2/SPNpMAo5tNeQuIYJb5xTdYN2yRIC1NyGAxRXB1rZQGax9a9w8C25Ni6N+dkBtYkCQSDVc/y3fVSMDdIbZVkYvBGC+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iYzHxkBl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75D4EC116B1;
	Tue,  4 Nov 2025 15:06:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762268806;
	bh=q9jHcrIwdfK0IwEfsVzpj/AG8cjBsQIFlmpCQFRO70o=;
	h=From:To:Cc:Subject:Date:From;
	b=iYzHxkBlAhLMMZNFkwhif/62gDtus4F7RZ/lEKAXnOhYiynJRsdvESe6QUezDBLjO
	 c+e/I9s9aNiYDFssYtk6e6+4r8I8Ihdtsw2TGtE+n16NRrAIp3xEhXP5MIIYYq/nRg
	 cIcrj98IXX/QeWIihtO+HCCzPBD8IzMie5e3NhSlGHqz1qT8DVycxR6rkTY2BE/z/k
	 rmUoaFkF0U4248IiD8N7FYBB9toASocClgGDTvesf4Q6Tmfn2W4+xEjcc5y3CBvpfk
	 I2K19qNnvo9riKDOcM31YZItSM1nyZGzeLG+1v9cvQU5xCjet63TK9utsNVPSxq6j5
	 9Whl3Q6lXPd7A==
From: Anna Schumaker <anna@kernel.org>
To: linux-nfs@vger.kernel.org,
	trond.myklebust@hammerspace.com
Cc: anna@kernel.org
Subject: [PATCH 0/5] NFS: Client Side Directory Delegations
Date: Tue,  4 Nov 2025 10:06:40 -0500
Message-ID: <20251104150645.719865-1-anna@kernel.org>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Anna Schumaker <anna.schumaker@oracle.com>

This patchset adds support for recallable directory delegations in the
NFS client, letting us shortcut some directory revalidation steps since
we know the directory hasn't changed from underneath us.

I tried to limit requesting a dir delegation to when we think the user
is doing work within a directory, so I look for ACCESS, CREATE, UNLINK,
and (same directory) RENAME calls. I'm open to suggestions for other
times I should be requesting a dir delegation too.

Finally, I add a new "directory_delegations" module parameter for
controlling the usage of directory delegations since they are still a
new feature. I (optimistically) have them enabled by default, and
setting this option to false will disable requesting delegations and
cause the client to return any existing delegations on the next use.

I'm happy to hear any suggestions for improvements!
Anna


Anna Schumaker (5):
  NFS: Add support for sending GDD_GETATTR
  NFS: Request a directory delegation on ACCESS, CREATE, and UNLINK
  NFS: Request a directory delegation during RENAME
  NFS: Shortcut lookup revalidations if we have a directory delegation
  NFS: Add a module option to disable directory delegations

 fs/nfs/delegation.c       |   8 +++
 fs/nfs/delegation.h       |  13 +++++
 fs/nfs/dir.c              |  19 +++++++
 fs/nfs/inode.c            |   3 ++
 fs/nfs/nfs3proc.c         |   3 +-
 fs/nfs/nfs4proc.c         |  62 ++++++++++++++++++++--
 fs/nfs/nfs4xdr.c          | 106 ++++++++++++++++++++++++++++++++++++++
 fs/nfs/proc.c             |   3 +-
 fs/nfs/unlink.c           |   3 +-
 include/linux/nfs_fs.h    |   1 +
 include/linux/nfs_fs_sb.h |   1 +
 include/linux/nfs_xdr.h   |  10 +++-
 12 files changed, 223 insertions(+), 9 deletions(-)

-- 
2.51.2


