Return-Path: <linux-nfs+bounces-10975-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EBF65A77D5E
	for <lists+linux-nfs@lfdr.de>; Tue,  1 Apr 2025 16:11:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E598188ABB7
	for <lists+linux-nfs@lfdr.de>; Tue,  1 Apr 2025 14:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E445204596;
	Tue,  1 Apr 2025 14:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CDGt4lIc"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33E481C8639;
	Tue,  1 Apr 2025 14:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743516573; cv=none; b=mVtMStXmETGXQ1M34lpe5rotWCMWtWKZJIKdOk82K/qbpH3rGDnQgddL5/jOdp5Y708OfTSykhEslJbBOofkPv7WVevpzKwGZh5byONDYWl4Untq+FTVMzS6Gwf7l669Wr5NvjisdPvVrx5yJTerrR0hM156YiEsSxWhCxjeVYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743516573; c=relaxed/simple;
	bh=LtU/byWfDwBRxuwHRgvpJTAHu9Roo4hLiwc4mKqQ7mY=;
	h=From:Date:MIME-Version:Content-Type:To:Message-ID:In-Reply-To:
	 References:Subject; b=i+yUqdTp0t66iNyN8VnqGqoX2D2WQA8dYMeQsjX0t5OmJHFysQVKtqG8ttzwQMtFHvXubqioAjYpyomipavWrmxwvBXDn0wphQYuV4cU666WvgzlNp9H3s3O0/NotrQSXxYpiCkzPc57jZRggTninOl1dkWCxBqIy8601HZZ85k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CDGt4lIc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EB5DC4CEE4;
	Tue,  1 Apr 2025 14:09:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743516571;
	bh=LtU/byWfDwBRxuwHRgvpJTAHu9Roo4hLiwc4mKqQ7mY=;
	h=From:Date:To:In-Reply-To:References:Subject:From;
	b=CDGt4lIcXOQVGw8IwugclNNWiyJ9PnzIPN4p0Q8TmaNT5tda/IzaMg3IQsdtuo5wb
	 LeKeLi7zk04ZroL9vFU5ju3oVUOLzuM8wAg27X4TIoSjXoVctHkiSGvOWSGVMOG/TH
	 pO9G5ik2MexKz28y19trfyJTmc6eLiEtLjbpsQTwt7pmzj7vHHGsvx1fS6z9vvALCa
	 ZNKYsie7c1g4g4uP3+qz6i1ifZE5hS/Q2hdLBAoiWqZYV4KDJ+M8V5Avx0rLAHaXUw
	 3V75uK88o/t0Gc/V92eWKbFHPwB/J5asjJsHL3BwpcOEX/4akAbxRBAyXvJSylQXTF
	 Kky373Qw8JqPQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 76F43380AA7A;
	Tue,  1 Apr 2025 14:10:09 +0000 (UTC)
From: Chuck Lever via Bugspray Bot <bugbot@kernel.org>
Date: Tue, 01 Apr 2025 14:10:13 +0000
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: anna@kernel.org, cel@kernel.org, iommu@lists.linux.dev, 
 jlayton@kernel.org, trondmy@kernel.org, robin.murphy@arm.com, 
 linux-nfs@vger.kernel.org, chuck.lever@oracle.com
Message-ID: <20250401-b219865c8-f01953980930@bugzilla.kernel.org>
In-Reply-To: <20250313-b219865c0-2a34cbc6e249@bugzilla.kernel.org>
References: <20250313-b219865c0-2a34cbc6e249@bugzilla.kernel.org>
Subject: Re: NFS Server Issues with RDMA in Kernel 6.13.6
X-Bugzilla-Product: File System
X-Bugzilla-Component: NFSD
X-Mailer: bugspray 0.1-dev

Chuck Lever writes via Kernel.org Bugzilla:

Attachment 307898 shows something completely different than before:

[ 4478.512632]  xfs_blockgc_flush_all+0x99/0x140 [xfs]
[ 4478.512760]  xfs_trans_alloc+0x116/0x2b0 [xfs]
[ 4478.512890]  xfs_trans_alloc_inode+0x7d/0x190 [xfs]
[ 4478.513012]  xfs_alloc_file_space+0x1ad/0x340 [xfs]
[ 4478.513149]  xfs_file_fallocate+0x243/0x4b0 [xfs]
[ 4478.513276]  vfs_fallocate+0x18d/0x440
[ 4478.513294]  nfsd4_vfs_fallocate+0x50/0xa0 [nfsd]
[ 4478.513351]  nfsd4_allocate+0x69/0xb0 [nfsd]
[ 4478.513398]  nfsd4_proc_compound+0x484/0x930 [nfsd]
[ 4478.513432]  ? srso_return_thunk+0x5/0x5f
[ 4478.513447]  nfsd_dispatch+0xfe/0x2e0 [nfsd]
[ 4478.513493]  svc_process_common+0x352/0x7d0 [sunrpc]
[ 4478.513556]  ? __pfx_nfsd_dispatch+0x10/0x10 [nfsd]
[ 4478.513600]  svc_process+0x13e/0x260 [sunrpc]
[ 4478.513644]  svc_recv+0x9a8/0xc40 [sunrpc]
[ 4478.513694]  ? __pfx_nfsd+0x10/0x10 [nfsd]
[ 4478.513733]  nfsd+0xe0/0x150 [nfsd]
[ 4478.513769]  kthread+0xe7/0x120
[ 4478.513777]  ? __pfx_kthread+0x10/0x10
[ 4478.513787]  ret_from_fork+0x46/0x70
[ 4478.513794]  ? __pfx_kthread+0x10/0x10
[ 4478.513801]  ret_from_fork_asm+0x1a/0x30

Here your NFS server is waiting in the local file system for an NFSv4.2 ALLOCATE operation. Nothing to do with RDMA.

I'm at a loss to say that there is anything specific -- I think you are just at the limit that your server configuration can handle.

View: https://bugzilla.kernel.org/show_bug.cgi?id=219865#c8
You can reply to this message to join the discussion.
-- 
Deet-doot-dot, I am a bot.
Kernel.org Bugzilla (bugspray 0.1-dev)


