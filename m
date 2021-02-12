Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60F8B31A715
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Feb 2021 22:50:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229918AbhBLVug (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 12 Feb 2021 16:50:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:36306 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229497AbhBLVue (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 12 Feb 2021 16:50:34 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D477064DC3;
        Fri, 12 Feb 2021 21:49:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613166594;
        bh=m+fwjh51Us2Om+mXfTMMSZ2vuJ+HGOAS0/aM8AE0OwY=;
        h=From:To:Cc:Subject:Date:From;
        b=fgvTonH5UJBEnTaPwaboO3oGWQpfY22CuBZsybasXVmPLk1wS7k6dp5K+t4JlbsND
         YxQFa5D1RhDpp80xk3CEvV07TI8p2wXBk4exPiQHYTz7gxVmBgVGQqfREPS29OIJsF
         V+IQAQKXf1KavzkRDL9+FbVpsnxbTPxG669l5h/q5wb5iTGqjxpoXVsCblxYp0hakf
         6O+OWWtH0hj+71UuCmUQ1xuD+L0dcAB0CosgL4/+nwFpuDIFD6WAgmDZZMWLWQR5S7
         7bpG120eDSUSO+qTcqewf9pjlz3OiEO7rcG4nTLRmj3s8j4PgeujJVn9Uc1tqZ/43C
         v3SICxyeXVccQ==
From:   trondmy@kernel.org
To:     Anna Schumaker <anna.schumaker@netapp.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 0/3] Add a mount option to support eager writes
Date:   Fri, 12 Feb 2021 16:49:46 -0500
Message-Id: <20210212214949.4408-1-trondmy@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

The following patch series sets up a new mount option
'writes=lazy/eager/wait'. The mount option basically controls how the
write() system call works.
- writes=lazy is the default, and keeps the current behaviour
- writes=eager means we send off the write immediately as an unstable
  write to the server.
- writes=wait means we send off the write as an unstable write, and then
  wait for the reply.

The main motivator for this behaviour is that some applications expect
write() to return ENOSPC. Setting writes=wait should satisfy those
applications without taking the full overhead of a synchronous write.

writes=eager, on the other hand, can be useful for applications such as
re-exporting NFS, since it would allow knfsd on the proxying server to
immediately forward the writes to the original server.

Trond Myklebust (3):
  NFS: 'flags' field should be unsigned in struct nfs_server
  NFS: Add support for eager writes
  NFS: Add mount options supporting eager writes

 fs/nfs/file.c             | 19 +++++++++++++++++--
 fs/nfs/fs_context.c       | 33 +++++++++++++++++++++++++++++++++
 fs/nfs/write.c            | 17 ++++++++++++-----
 include/linux/nfs_fs_sb.h |  4 +++-
 4 files changed, 65 insertions(+), 8 deletions(-)

-- 
2.29.2

