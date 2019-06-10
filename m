Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 48FFA3B67E
	for <lists+linux-nfs@lfdr.de>; Mon, 10 Jun 2019 15:53:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390324AbfFJNxD (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 10 Jun 2019 09:53:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43524 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390306AbfFJNxD (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 10 Jun 2019 09:53:03 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B0994308622E;
        Mon, 10 Jun 2019 13:53:02 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (ovpn-116-83.phx2.redhat.com [10.3.116.83])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5990B600CD;
        Mon, 10 Jun 2019 13:53:02 +0000 (UTC)
Subject: Re: [PATCH v3 00/11] Add the "[exports] rootdir" option to nfs.conf
To:     Trond Myklebust <trondmy@gmail.com>
Cc:     linux-nfs@vger.kernel.org
References: <20190528203122.11401-1-trond.myklebust@hammerspace.com>
From:   Steve Dickson <SteveD@RedHat.com>
Message-ID: <7fbb9de3-8da4-5475-d425-ecc68c9ef709@RedHat.com>
Date:   Mon, 10 Jun 2019 09:53:01 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190528203122.11401-1-trond.myklebust@hammerspace.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Mon, 10 Jun 2019 13:53:02 +0000 (UTC)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 5/28/19 4:31 PM, Trond Myklebust wrote:
> The following patchset adds support for the "rootdir" configuration
> option for nfsd in the "[exports]" section in /etc/nfs.conf.
> 
> If a user sets this option to a valid directory path, then nfsd will
> act as if it is confined to a chroot jail based on that directory.
> All paths in /etc/exports and the exportfs utility are then resolved
> relative to that directory.
> 
> Trond Myklebust (11):
>   mountd: Ensure we don't share cache file descriptors among processes.
>   Add a simple workqueue mechanism
>   Allow callers to check mountpoint status using a custom lstat function
>   Add utilities for resolving nfsd paths and stat()ing them
>   Use xstat() with no synchronisation if available
>   Add helpers to read/write to a file through the chrooted thread
>   Add a helper to return the real path given an export entry
>   Add support for the "[exports] rootdir" nfs.conf option to rpc.mountd
>   Add support for the "[exports] rootdir" nfs.conf option to exportfs
>   Add a helper for resolving symlinked nfsd paths via realpath()
>   Fix up symlinked mount path resolution when "[exports] rootdir" is set
> 
>  aclocal/libpthread.m4       |  13 +-
>  configure.ac                |   6 +-
>  nfs.conf                    |   3 +
>  support/export/export.c     |  24 +++
>  support/include/Makefile.am |   3 +
>  support/include/exportfs.h  |   1 +
>  support/include/misc.h      |   7 +-
>  support/include/nfsd_path.h |  21 +++
>  support/include/nfslib.h    |   1 +
>  support/include/workqueue.h |  18 +++
>  support/include/xstat.h     |  11 ++
>  support/misc/Makefile.am    |   3 +-
>  support/misc/mountpoint.c   |   8 +-
>  support/misc/nfsd_path.c    | 289 ++++++++++++++++++++++++++++++++++++
>  support/misc/workqueue.c    | 228 ++++++++++++++++++++++++++++
>  support/misc/xstat.c        | 105 +++++++++++++
>  support/nfs/exports.c       |   4 +
>  systemd/nfs.conf.man        |  20 ++-
>  utils/exportfs/Makefile.am  |   2 +-
>  utils/exportfs/exportfs.c   |  11 +-
>  utils/mountd/Makefile.am    |   3 +-
>  utils/mountd/cache.c        |  63 +++++---
>  utils/mountd/mountd.c       |  24 +--
>  23 files changed, 819 insertions(+), 49 deletions(-)
>  create mode 100644 support/include/nfsd_path.h
>  create mode 100644 support/include/workqueue.h
>  create mode 100644 support/include/xstat.h
>  create mode 100644 support/misc/nfsd_path.c
>  create mode 100644 support/misc/workqueue.c
>  create mode 100644 support/misc/xstat.c
> 
Committed!

steved.
