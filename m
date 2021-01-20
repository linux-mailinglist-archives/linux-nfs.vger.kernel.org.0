Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DD0A2FD66D
	for <lists+linux-nfs@lfdr.de>; Wed, 20 Jan 2021 18:05:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391078AbhATRFS (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 20 Jan 2021 12:05:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42002 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2391250AbhATRBf (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 20 Jan 2021 12:01:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611161997;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=B/r1ya0nLqX9lahB9LJGeLPRvtBxybq1MYxgaBVoSeA=;
        b=VVrwwPktvfm4DGJexf6hnEbjcctMZWouIYdqCjlagQcmv0v60dX0CEgGXD7Q8N1gdkb+RX
        n+sIhX7DhMqvwuydUlbz5pE6fL20xUvFOzJx1wIcgm1Ru+/3qPc452OWlJ0vBp/V5YDvEh
        GbDvVPG2B+JNNmo31li57+msdD3xOxQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-343-GjU1eZXgPJe-tKxATCdhqQ-1; Wed, 20 Jan 2021 11:59:55 -0500
X-MC-Unique: GjU1eZXgPJe-tKxATCdhqQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EF019612A8
        for <linux-nfs@vger.kernel.org>; Wed, 20 Jan 2021 16:59:54 +0000 (UTC)
Received: from bcodding.csb (ovpn-64-66.rdu2.redhat.com [10.10.64.66])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C6AD56BF6B
        for <linux-nfs@vger.kernel.org>; Wed, 20 Jan 2021 16:59:54 +0000 (UTC)
Received: by bcodding.csb (Postfix, from userid 24008)
        id 6503910D4111; Wed, 20 Jan 2021 11:59:54 -0500 (EST)
From:   Benjamin Coddington <bcodding@redhat.com>
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v1 00/10] NFS client readdir per-page validation
Date:   Wed, 20 Jan 2021 11:59:44 -0500
Message-Id: <cover.1611160120.git.bcodding@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Due to the constraint that the NFS readdir page cache must contain every
entry in cookie order from zero up to the entry of interest, the time or
operations required to complete a directory listing increase exponentially
with the size of the directory if the client is unable to keep the pagecache
stable.  The pagecache can be invalidated by a changing directory, or by
memory pressure on the client.  This can cause some trouble for the NFS
client reading large directories over slow connections.

We have a hueristic that allows eventual completion, but it only works as
long as there are no other readers simultaneously filling the pagecache.

I think we can resolve this problem by implementing per-page validation.  By
storing the directory's change version on the page, and checking for changes
to the directory on every READDIR, we can validate pages against each
reader's version of entry aligment.  Rather than attempting to assemble the
entire directory in a consistent manner in the pagecache, we can just
retrieve the section we're interested in emitting.

This set is a first pass at implementing this idea.  Please help me pound it
into acceptable shape or point out problems!  Thanks for any feedback.

Here's a small program that does a great job of demonstraing the client's
current readdir pagecache performance problem by dropping the directory's
pagecache at an interval while trying to emit every entry:

#define _GNU_SOURCE
#include <stdio.h>
#include <unistd.h>
#include <fcntl.h>
#include <sched.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <sys/syscall.h>
#include <signal.h>

#define BUF_SIZE 1024
#define EVICT_INTERVAL 5

int evict_pagecache(int fd) {
                return posix_fadvise(fd, 0, 0, POSIX_FADV_DONTNEED);
}

int main(int argc, char **argv)
{
        int dir_fd;
        pid_t pid;
        cpu_set_t *cpusetp = CPU_ALLOC(2);
        off_t off;

        char buf[BUF_SIZE];

        if (argc < 2) { printf("%s <dir>\n", argv[0]); return 1; }

        dir_fd = open(argv[1], O_RDONLY|O_DIRECTORY|O_CLOEXEC);
        if (dir_fd < 0) { printf("cannot open dir\n"); return 1; }

        pid = fork();
        if (pid == 0) {
                CPU_SET(1, cpusetp);
                sched_setaffinity(0, sizeof(cpu_set_t), cpusetp);
                do {
                        evict_pagecache(dir_fd);
                        off = lseek(dir_fd, 0, SEEK_CUR);
                        printf("currently at %llu\n", off);
                        usleep(EVICT_INTERVAL * 1000000);
                } while (1);
        } else {
                CPU_SET(0, cpusetp);
                sched_setaffinity(0, sizeof(cpu_set_t), cpusetp);
                while (syscall(SYS_getdents, dir_fd, buf, BUF_SIZE)) {}
                kill(pid, SIGINT);
        }

        close(dir_fd);
        return 0;
}


Benjamin Coddington (10):
  NFS: save the directory's change attribute on pagecache pages
  NFSv4: Send GETATTR with READDIR
  NFS: Add a struct to track readdir pagecache location
  NFS: Keep the readdir pagecache cursor updated
  NFS: readdir per-page cache validation
  NFS: stash the readdir pagecache cursor on the open directory context
  NFS: Support headless readdir pagecache pages
  NFS: Reset pagecache cursor on llseek
  NFS: Remove nfs_readdir_dont_search_cache()
  NFS: Revalidate the directory pagecache on every nfs_readdir()

 fs/nfs/dir.c              | 210 +++++++++++++++++++++++++++-----------
 fs/nfs/nfs42proc.c        |   2 +-
 fs/nfs/nfs4proc.c         |  27 +++--
 fs/nfs/nfs4xdr.c          |   6 ++
 include/linux/nfs_fs.h    |   8 +-
 include/linux/nfs_fs_sb.h |   5 +
 include/linux/nfs_xdr.h   |   2 +
 7 files changed, 188 insertions(+), 72 deletions(-)

-- 
2.25.4

