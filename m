Return-Path: <linux-nfs+bounces-6474-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C15D3979010
	for <lists+linux-nfs@lfdr.de>; Sat, 14 Sep 2024 12:50:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 21706B221DA
	for <lists+linux-nfs@lfdr.de>; Sat, 14 Sep 2024 10:50:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB0AC635;
	Sat, 14 Sep 2024 10:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DveLAHj5"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4DA738C
	for <linux-nfs@vger.kernel.org>; Sat, 14 Sep 2024 10:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726311009; cv=none; b=iNkLlT1gNzy3OsZe8oF41eRC9Wav7jbhBZjazf2rA07CrdHqyLKR1UgdEUWc++TeTHr+D0LRlFuzTk/2FmcjyCQlq/0ccgtjbS996Y7jW2NT/YyaNfSSHI8t6IhA89y46jSr5yX75x/3T37aEa7lrpVEixj5U/c6AZuxXHBA/Po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726311009; c=relaxed/simple;
	bh=2NEm8E9kufS8yB90QsBMA9eSksedRrmDlyxpFKRGFx0=;
	h=Date:MIME-Version:Content-Type:From:To:Message-ID:Subject; b=EVwbb1lLXi7L1LkeEv3ie4hhJZH2HgG5FeUvSTOe7l/quoYEydfNjO/s9SQmWsp5t8G3wHrwnK0Job8Eq/xh5EufCscp5BK1Bo6bSpY7chwUtmQBFbRLUYL4VvP6xZ0aUr7/ZTvqOexkUlK3dM3tB+c1C1kPgAK+I8PSZBCnuLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DveLAHj5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F6C1C4CEC0;
	Sat, 14 Sep 2024 10:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726311009;
	bh=2NEm8E9kufS8yB90QsBMA9eSksedRrmDlyxpFKRGFx0=;
	h=Date:From:To:Subject:From;
	b=DveLAHj5HUj58AbyAg1Lm+pd5MEWzOYCZ+uQ2etzPkehTcoNMlPVe9xJFM/bMDnH5
	 whZqoZPqels14pOv15RZk89/FHrkII7OH8lySKeVJ83ZhS38JIjmaoJVfqLUpIlnKz
	 6w/kbUojq2ZmnHBiTULgWqQAD5ouiQ/NdGgk7pFgwiA5hm8ZmzuOkeIN3bDXcPoKZj
	 SFd0tBiYU2PQ9jl9hwGcNmrrN9TZE9675/bFtHDIGhSRprXMq7H9M8TUnFhUneZll+
	 tsZHmgwnseBvhh8WeKNKZHXGOH5pB62YeuMqOYnyS8zf4Z4hALUIcZHSZ1gHpPv2EA
	 Ov2iZs2Zf/6NA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B58F83806655;
	Sat, 14 Sep 2024 10:50:11 +0000 (UTC)
Date: Sat, 14 Sep 2024 10:50:08 +0000
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
From: Bugspray Bot <bugbot@kernel.org>
To: trondmy@kernel.org, linux-nfs@vger.kernel.org, cel@kernel.org, 
 jlayton@kernel.org, anna@kernel.org
Message-ID: <20240914-b219278c0-d3a919d16eb1@bugzilla.kernel.org>
Subject: >=linux-6.6.0: Resource temporarily unavailable when reading file
 attributes the first time
X-Bugzilla-Product: File System
X-Bugzilla-Component: NFSD
X-Mailer: bugspray 0.1-dev

linux writes via Kernel.org Bugzilla:

Description
-----------
When a file is written via nfs, calling lsattr on it on the server side fails with:
Resource temporarily unavailable While reading flags from <filename>

This only happens the first time.
The error first appeared in kernel version 6.0.0.


I bisected the issue to this commit

commit 1d3dd1d56ce8322fb5b2a143ec9ff38c703bfeda
Author: Dai Ngo <dai.ngo@oracle.com>
Date:   Thu Jun 29 18:52:40 2023 -0700

    NFSD: Enable write delegation support
    
    This patch grants write delegations for OPEN with NFS4_SHARE_ACCESS_WRITE
    if there is no conflict with other OPENs.
    
    Write delegation conflicts with another OPEN, REMOVE, RENAME and SETATTR
    are handled the same as read delegation using notify_change,
    try_break_deleg.
    
    The NFSv4.0 protocol does not enable a server to determine that a
    conflicting GETATTR originated from the client holding the
    delegation versus coming from some other client. With NFSv4.1 and
    later, the SEQUENCE operation that begins each COMPOUND contains a
    client ID, so delegation recall can be safely squelched in this case.
    
    With NFSv4.0, however, the server must recall or send a CB_GETATTR
    (per RFC 7530 Section 16.7.5) even when the GETATTR originates from
    the client holding that delegation.
    
    An NFSv4.0 client can trigger a pathological situation if it always
    sends a DELEGRETURN preceded by a conflicting GETATTR in the same
    COMPOUND. COMPOUND execution will always stop at the GETATTR and the
    DELEGRETURN will never get executed. The server eventually revokes
    the delegation, which can result in loss of open or lock state.
    
    Tracepoint added to track whether read or write delegation is granted.
    
    Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
    Signed-off-by: Jeff Layton <jlayton@kernel.org>
    Signed-off-by: Chuck Lever <chuck.lever@oracle.com>

 fs/nfsd/nfs4state.c | 97 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--------------------
 fs/nfsd/trace.h     |  1 +
 2 files changed, 78 insertions(+), 20 deletions(-)


Steps to reproduce
------------------
# mkdir -p test/{shared,local}
# cd /mnt/test/local
# python test.py; lsattr -l testfile; lsattr -l testfile;

/etc/exports
----------------------------------------------------------------------
/mnt/test/local 127.0.0.1(rw,no_subtree_check,crossmnt,no_root_squash)
----------------------------------------------------------------------

/etc/fstab
---------------------------------------------------------------------
localhost:/mnt/test/local   /mnt/test/shared  nfs   rw,noatime   0 0
---------------------------------------------------------------------

/mnt/test/local/test.py
--------------------------------------------------------------------------
import os
fd = os.open("/mnt/test/shared/testfile", os.O_CREAT | os.O_EXCL | os.O_RDWR)
os.close(fd)
--------------------------------------------------------------------------


Actual result
-------------
lsattr: Resource temporarily unavailable While reading flags from testfile
testfile    Extents


Expected result
---------------
testfile    Extents
testfile    Extents


Background
----------
I am using certbot to receive letsencrypt certificates. The certbot service runs on a different host than the webserver that is used. Certbot uses nfs to write the challenge files to the webserver. The code is very similar to the one in the provided test.py. When letsencrypt tries to verify, the operation fails because the webserver receives 'Resource not available' when trying to read the file.

View: https://bugzilla.kernel.org/show_bug.cgi?id=219278#c0
You can reply to this message to join the discussion.
-- 
Deet-doot-dot, I am a bot.
Kernel.org Bugzilla (bugspray 0.1-dev)


