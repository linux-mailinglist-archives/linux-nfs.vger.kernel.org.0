Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9929A40B329
	for <lists+linux-nfs@lfdr.de>; Tue, 14 Sep 2021 17:31:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234824AbhINPcb (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 14 Sep 2021 11:32:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44316 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234810AbhINPcb (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 14 Sep 2021 11:32:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631633473;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=28uHVFlIgd259Tk0Onl6nVW85p5Wip9eeWyZFWWQ7Gw=;
        b=F+muRHYbjDEvXBBSyifqI2CQExBHUhd/4e52y8NnkeIUe/KZSfw6N2rPGrLhYvVFjCP2ZQ
        Woy1+xhn3pmBeUQsbNB3GHdgmLvHlMnG9Jkc9rLHcM68ykEYSRAdcEeT7Q/eZC7/9gtsMT
        pCvR3jWJCJWCF8RII1ommZovuK5FBSE=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-533-WGL_Hak3OcmGi-Za4JNpyg-1; Tue, 14 Sep 2021 11:31:12 -0400
X-MC-Unique: WGL_Hak3OcmGi-Za4JNpyg-1
Received: by mail-ed1-f70.google.com with SMTP id n5-20020a05640206c500b003cf53f7cef2so6986050edy.12
        for <linux-nfs@vger.kernel.org>; Tue, 14 Sep 2021 08:31:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=28uHVFlIgd259Tk0Onl6nVW85p5Wip9eeWyZFWWQ7Gw=;
        b=R/CCXruBv9NNZ8ITXNtkWXoHlVXPPZ0z+KhQjBMpv7No0THoiJEuqgMOYuG7vklKL0
         3F1L8K7SRK8GOWP8LJVdrn2ogdvQvKdtjkt8p5/qDOMWe47Uw/zh5XUbDmORBDJCZBVF
         353r8ZD6yhLc4rxaNxmro4E3SlXhWw30jk2GVvJAwLQuPlwgiLBQgNh41KW7k5JTVgkX
         0Ga+wAtA9MkpoE62cyHlPdNiGQxNirg5fzfmtybgQc5kObmkK9Q4ohpMu8gW0yhqgZQX
         S63v/GIr4vBVUUrLpJsFgoKv8otlc64El6cu1iSlHay0U14ZkddjS9YQUzxZFB5LicF3
         4t3Q==
X-Gm-Message-State: AOAM533+/NseOTVezPcLtVeFuvgpxPxFyf3g8q50rmNKSgJjc05uZ/W4
        TA6cMHg2X0rLVIaKiN1Sf5dLAYOpUC/Acf4TgO0Xj3a4A/jbA5WX5yEF/aICHWJjSMC8K7cWdz8
        YliD022No9qCS8H/6wDOBVYkvewBf78yQZH/y
X-Received: by 2002:a17:907:9602:: with SMTP id gb2mr19741337ejc.119.1631633467790;
        Tue, 14 Sep 2021 08:31:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwBCsPMH/stPuTNHWIjWdIDFCeRDqb2JZpOnn0wdJ4EAfdOma5ARu4H6YXdUtlU3P33pyF7rZaoQLtYtlKQ92E=
X-Received: by 2002:a17:907:9602:: with SMTP id gb2mr19741147ejc.119.1631633465397;
 Tue, 14 Sep 2021 08:31:05 -0700 (PDT)
MIME-Version: 1.0
References: <163162767601.438332.9017034724960075707.stgit@warthog.procyon.org.uk>
In-Reply-To: <163162767601.438332.9017034724960075707.stgit@warthog.procyon.org.uk>
From:   David Wysochanski <dwysocha@redhat.com>
Date:   Tue, 14 Sep 2021 11:30:29 -0400
Message-ID: <CALF+zO=VHPzcp0A0KxpYW-0WnyxvM5gW5HmorzrMJ_arxxBchA@mail.gmail.com>
Subject: Re: [RFC PATCH 0/8] fscache: Replace and remove old I/O API
To:     David Howells <dhowells@redhat.com>
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        linux-nfs <linux-nfs@vger.kernel.org>,
        v9fs-developer@lists.sourceforge.net,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        linux-cachefs <linux-cachefs@redhat.com>,
        linux-cifs <linux-cifs@vger.kernel.org>,
        Shyam Prasad N <nspmangalore@gmail.com>,
        Jeff Layton <jlayton@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-afs@lists.infradead.org, ceph-devel@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Sep 14, 2021 at 9:55 AM David Howells <dhowells@redhat.com> wrote:
>
>
> Here's a set of patches that removes the old fscache I/O API by the following
> means:
>
>  (1) A simple fallback API is added that can read or write a single page
>      synchronously.  The functions for this have "deprecated" in their names
>      as they have to be removed at some point.
>
>  (2) An implementation of this is provided in cachefiles.  It creates a kiocb
>      to use DIO to the backing file rather than calling readpage on the
>      backing filesystem page and then snooping the page wait queue.
>
>  (3) NFS is switched to use the fallback API.
>
>  (4) CIFS is switched to use the fallback API also for the moment.
>
>  (5) 9P is switched to using netfslib.
>
>  (6) The old I/O API is removed from fscache and the page snooping
>      implementation is removed from cachefiles.
>
> The reasons for doing this are:
>
>  (A) Using a kiocb to do asynchronous DIO from/to the pages of the backing
>      file is now a possibility that didn't exist when cachefiles was created.
>      This is much simpler than the snooping mechanism with a proper callback
>      path and it also requires fewer copies and less memory.
>
>  (B) We have to stop using bmap() or SEEK_DATA/SEEK_HOLE to work out what
>      blocks are present in the backing file is dangerous and can lead to data
>      corruption if the backing filesystem can insert or remove blocks of zeros
>      arbitrarily in order to optimise its extent list[1].
>
>      Whilst this patchset doesn't fix that yet, it does simplify the code and
>      the fix for that can be made in a subsequent patchset.
>
>  (C) In order to fix (B), the cache will need to keep track itself of what
>      data is present.  To make this easier to manage, the intention is to
>      increase the cache block granularity to, say, 256KiB - importantly, a
>      size that will span multiple pages - which means the single-page
>      interface will have to go away.  netfslib is designed to deal with
>      that on behalf of a filesystem, though a filesystem could use raw
>      cache calls instead and manage things itself.
>
> These patches can be found also on:
>
>         https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/?h=fscache-iter-3
>
> David
>
> Link: https://lore.kernel.org/r/YO17ZNOcq+9PajfQ@mit.edu [1]
> ---
> David Howells (8):
>       fscache: Generalise the ->begin_read_operation method
>       fscache: Implement an alternate I/O interface to replace the old API
>       nfs: Move to using the alternate (deprecated) fscache I/O API
>       9p: (untested) Convert to using the netfs helper lib to do reads and caching
>       cifs: (untested) Move to using the alternate (deprecated) fscache I/O API
>       fscache: Remove the old I/O API
>       fscache: Remove stats that are no longer used
>       fscache: Update the documentation to reflect I/O API changes
>
>
>  .../filesystems/caching/backend-api.rst       |  138 +--
>  .../filesystems/caching/netfs-api.rst         |  386 +-----
>  fs/9p/Kconfig                                 |    1 +
>  fs/9p/cache.c                                 |  137 ---
>  fs/9p/cache.h                                 |   98 +-
>  fs/9p/v9fs.h                                  |    9 +
>  fs/9p/vfs_addr.c                              |  174 ++-
>  fs/9p/vfs_file.c                              |   21 +-
>  fs/cachefiles/Makefile                        |    1 -
>  fs/cachefiles/interface.c                     |   15 -
>  fs/cachefiles/internal.h                      |   38 -
>  fs/cachefiles/io.c                            |   28 +-
>  fs/cachefiles/main.c                          |    1 -
>  fs/cachefiles/rdwr.c                          |  972 ---------------
>  fs/cifs/file.c                                |   64 +-
>  fs/cifs/fscache.c                             |  105 +-
>  fs/cifs/fscache.h                             |   74 +-
>  fs/fscache/cache.c                            |    6 -
>  fs/fscache/cookie.c                           |   10 -
>  fs/fscache/internal.h                         |   58 +-
>  fs/fscache/io.c                               |  140 ++-
>  fs/fscache/object.c                           |    2 -
>  fs/fscache/page.c                             | 1066 -----------------
>  fs/fscache/stats.c                            |   73 +-
>  fs/nfs/file.c                                 |   14 +-
>  fs/nfs/fscache-index.c                        |   26 -
>  fs/nfs/fscache.c                              |  161 +--
>  fs/nfs/fscache.h                              |   84 +-
>  fs/nfs/read.c                                 |   25 +-
>  fs/nfs/write.c                                |    7 +-
>  include/linux/fscache-cache.h                 |  131 --
>  include/linux/fscache.h                       |  418 ++-----
>  include/linux/netfs.h                         |   17 +-
>  33 files changed, 508 insertions(+), 3992 deletions(-)
>  delete mode 100644 fs/cachefiles/rdwr.c
>
>

I tested an earlier version of these with NFS, which identified a
couple issues which you fixed.  Last I checked my unit tests and
xfstests were looking good. I'll do some testing on this latest branch
/ patches and report back.

