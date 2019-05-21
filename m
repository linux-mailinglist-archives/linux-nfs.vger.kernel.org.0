Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F113256DB
	for <lists+linux-nfs@lfdr.de>; Tue, 21 May 2019 19:40:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727969AbfEURkI (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 21 May 2019 13:40:08 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:37522 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727898AbfEURkH (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 21 May 2019 13:40:07 -0400
Received: by mail-it1-f195.google.com with SMTP id m140so6017940itg.2
        for <linux-nfs@vger.kernel.org>; Tue, 21 May 2019 10:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=MVDHcIeTOBz9+KKT3fkHbQXdYXwwICZ1ibsxLuirPkM=;
        b=fKOOmW/ILepzJFn50LlOZaRRGKaUbLSvdWVJ9VUcu5/H56qOExYtqAIrNEB69DDP+V
         D9Fc8W0hqR777qj+De/izRGTE6rqR58ILnbmj/A0GIty78+B4UPaHebmA+htVDGhTAC2
         b+qOCzQa+BJ7wKK3aYY6H/tAJF24DH2ASAT0dRu+1spNt4fsdSPENyrDc7vwK4iocMnP
         vZ0ZeCGqwcSSPcCCiRcAhGwybs0DD8m6auIvTWzdd+ZH230RCBY56JsFoX3AmuOn5rwZ
         2IETLpmZPBu95vUAmKsWm+Lz6x7G6/63sm9oprjD7qNSVK8DTwOP9+MjPNP41iA+p6JS
         9AtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=MVDHcIeTOBz9+KKT3fkHbQXdYXwwICZ1ibsxLuirPkM=;
        b=X3EhPenVDhD9cdId2hVsVTWz90ybw3vdP754/7qVPcOpW48cvkdzo8Y9iVcSZsXtvg
         51ggeooNEJicJaFOFbIMAv4IDt65GRRW3GsR22lJ5lIu08i3hbvkhryNZe4d93R9agHh
         K/U1sb4SeukmTYmr4cZ2aS557civMYw0NB2F00SiegCFbHBI7MKSTD6U6AE7Px1spW5s
         UxzVJgsAqyyOL5IA3hVhICjkjV5gMMZIcsUWSaQn3p6uayna+F7K0ZrbJf0RKrMTeOID
         JA5isG6/z3zw6lpYdRPm9MIpHdE7YoLpiQ7T8sDq0KcVwzmUdO2PBuqSo8b0KOTLB9yz
         IsuA==
X-Gm-Message-State: APjAAAUqJXrVZJQq32L5BbTOIOAKozQQ4Xa5Tvhic8wb1luzbo7Jum4J
        IowLMgxSMhG+UEHUkbBwWcI=
X-Google-Smtp-Source: APXvYqwlR6pYCC3HiWf60QFUabZU39zWrvHbiTzRaJDSWOgRki4U9ypzdwiC01JKPGaunwnjtSW1iQ==
X-Received: by 2002:a24:2249:: with SMTP id o70mr4699549ito.101.1558460406992;
        Tue, 21 May 2019 10:40:06 -0700 (PDT)
Received: from anon-dhcp-171.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id 7sm7820257iob.73.2019.05.21.10.40.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 May 2019 10:40:06 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [RFC PATCH v2 0/7] Add a root_dir option to nfs.conf
From:   Chuck Lever <chucklever@gmail.com>
In-Reply-To: <20190521124701.61849-1-trond.myklebust@hammerspace.com>
Date:   Tue, 21 May 2019 13:40:04 -0400
Cc:     Steve Dickson <SteveD@redhat.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: 7bit
Message-Id: <708D03B6-AEE1-42D6-ABDF-FB1AA5FC9A94@gmail.com>
References: <20190521124701.61849-1-trond.myklebust@hammerspace.com>
To:     Trond Myklebust <trondmy@gmail.com>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Trond -

> On May 21, 2019, at 8:46 AM, Trond Myklebust <trondmy@gmail.com> wrote:
> 
> The following patchset adds support for the 'root_dir' configuration
> option for nfsd in nfs.conf. If a user sets this option to a valid
> directory path, then nfsd will act as if it is confined to a chroot
> jail based on that directory. All paths in /etc/exporfs and from
> exportfs are then resolved relative to that directory.

What about files under /proc that mountd might access? I assume these
pathnames are not affected.

Aren't there also one or two other files that maintain export state
like /var/lib/nfs/rmtab? Are those affected?

IMHO it could be less confusing to administrators to make root_dir an
[exportfs] option instead of a [mountd] option, if this is not a true
chroot of mountd.


> Trond Myklebust (7):
>  mountd: Ensure we don't share cache file descriptors among processes.
>  Add a simple workqueue mechanism
>  Add utilities for resolving nfsd paths and stat()ing them
>  Add a helper to return the real path given an export entry
>  Add helpers to read/write to a file through the chrooted thread
>  Add support for the nfsd rootdir configuration option to rpc.mountd
>  Add support for the nfsd root directory to exportfs
> 
> aclocal/libpthread.m4       |  13 +-
> configure.ac                |   6 +-
> nfs.conf                    |   1 +
> support/export/export.c     |  24 +++
> support/include/Makefile.am |   2 +
> support/include/exportfs.h  |   1 +
> support/include/nfsd_path.h |  17 ++
> support/include/nfslib.h    |   1 +
> support/include/workqueue.h |  22 +++
> support/misc/Makefile.am    |   3 +-
> support/misc/mountpoint.c   |   5 +-
> support/misc/nfsd_path.c    | 175 +++++++++++++++++++++
> support/misc/workqueue.c    | 306 ++++++++++++++++++++++++++++++++++++
> support/nfs/exports.c       |   4 +
> systemd/nfs.conf.man        |   3 +-
> utils/exportfs/Makefile.am  |   2 +-
> utils/exportfs/exportfs.c   |  32 +++-
> utils/mountd/Makefile.am    |   3 +-
> utils/mountd/cache.c        |  79 +++++++---
> utils/mountd/mountd.c       |  13 +-
> utils/nfsd/nfsd.man         |   6 +
> 21 files changed, 676 insertions(+), 42 deletions(-)
> create mode 100644 support/include/nfsd_path.h
> create mode 100644 support/include/workqueue.h
> create mode 100644 support/misc/nfsd_path.c
> create mode 100644 support/misc/workqueue.c
> 
> -- 
> 2.21.0
> 

--
Chuck Lever
chucklever@gmail.com



