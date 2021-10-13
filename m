Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACA9A42C4FD
	for <lists+linux-nfs@lfdr.de>; Wed, 13 Oct 2021 17:42:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229903AbhJMPoC (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 13 Oct 2021 11:44:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:53525 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229711AbhJMPoC (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 13 Oct 2021 11:44:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634139718;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YTsyQy90Y8vr99gRcn4sruIL3K1xPoiLMle2l3qSL3o=;
        b=AzXqxVhcZv6tqOGnMXDFIQzAZ58NZcl5RBxvjWbqZ0KxPjyraxV9LPCj0qGWSgZJY8vv0n
        r+CzYLn1nKLZPqxfCWtKoZwvJOvD+J5uECsNN417JSrXc8wYNuhqb8TGZ/s1b3ril83rwu
        cE1H2iRmNRv6wPkslkWBxHzUYn5+73M=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-387-TGla3GRvOsWY8MUuhut3Iw-1; Wed, 13 Oct 2021 11:41:57 -0400
X-MC-Unique: TGla3GRvOsWY8MUuhut3Iw-1
Received: by mail-ed1-f72.google.com with SMTP id z23-20020aa7cf97000000b003db7be405e1so2618004edx.13
        for <linux-nfs@vger.kernel.org>; Wed, 13 Oct 2021 08:41:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YTsyQy90Y8vr99gRcn4sruIL3K1xPoiLMle2l3qSL3o=;
        b=NnjkEGmQrrihN6Qu8YuejEW/H+o+9U05EkpWStrbB7JxATkW72oSvFbOcGyBwSycQt
         Hxo0fU8z50HCUzX8Q7Fq8dUdd1eGCk+tsgPeGKNKY5iAQNHU5OV+g2eHJoYjoN5rZLmG
         w//lujTimPQfjxT9rtgwr84oyO8FRWhmyBg5WqDbdAxkKgBLAyQZLJ5iW71tGnXZHekK
         8CHWonjoRtSarW7UB6lZFnCRhc17fsqU7IbsEyk1av9Uq3emhRvofHev7doE1mH9w/oK
         DS/z/IAf8XLTZSXVEYH6V3BGJo2GidlNEuhTQAO6rj4iMQXNZUKART5EHfs0PkKep3ez
         UzSg==
X-Gm-Message-State: AOAM530e8aa74FqhorqpcNmEnYD2mdqKFS3WH0WRpYbX6L7ECuqNF9Lz
        OeDvP2u1kzCoywLt9ERPki40Q9PZsQryoxJS84rGogxYct9iKwlgNnsK7QhvZFIMFpv76IwErAa
        HVAMVWxTTeWS37b04RQraMf+c197kBCUJdu7c
X-Received: by 2002:a17:906:5e17:: with SMTP id n23mr286524eju.258.1634139716210;
        Wed, 13 Oct 2021 08:41:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxS4cVAWJkR7CbLvPFTXBfnS1sSmTtIpe5zZADoFU1ojmR6bmvi0WKIMzEMMmw+1gYr2qY6GVDMz+QhDc7rPLw=
X-Received: by 2002:a17:906:5e17:: with SMTP id n23mr286493eju.258.1634139715963;
 Wed, 13 Oct 2021 08:41:55 -0700 (PDT)
MIME-Version: 1.0
References: <1633645823-31235-1-git-send-email-dwysocha@redhat.com>
In-Reply-To: <1633645823-31235-1-git-send-email-dwysocha@redhat.com>
From:   David Wysochanski <dwysocha@redhat.com>
Date:   Wed, 13 Oct 2021 11:41:19 -0400
Message-ID: <CALF+zOnyGNG=wUHu2j04RWF0nQaAoQfse5e81a=U3pvdNXL26w@mail.gmail.com>
Subject: Re: [PATCH v2 0/7] Various NFS fscache cleanups
To:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        David Howells <dhowells@redhat.com>
Cc:     linux-cachefs <linux-cachefs@redhat.com>,
        linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Oct 7, 2021 at 6:31 PM Dave Wysochanski <dwysocha@redhat.com> wrote:
>
> This patchset is on top of David Howells patchset he just posted as
> v3 of "fscache: Replace and remove old I/O API" and is based on his
> fscache-remove-old-io branch at
> https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/?h=fscache-remove-old-io
> NOTE: fscache-remove-old-io was previously "fscache-iter-3" but it's been
> renamed to better reflect the purpose.
>
> The series is also at:
> https://github.com/DaveWysochanskiRH/kernel.git
> https://github.com/DaveWysochanskiRH/kernel/tree/fscache-remove-old-io-nfs-fixes
>
> Testing is looking ok so far and is still ongoing at BakeAThon and in
> my local testbed with tracepoints enabled via:
> trace-cmd start -e fscache:* -e nfs:* -e nfs4:* -e cachefiles:*
>
> Changes in v2 of this series
> - Dropped first patch of v1 series (dhowells updated his patch)
> - Don't rename or change the value of NFSDBG_FSCACHE (Trond)
> - Rename nfs_readpage_from_fscache and nfs_readpage_to_fscache
> - Rename enable/disable tracepoints to start with "nfs_fscache"
> - Rename fscache IO tracepoints to better reflect the new function names
> - Place the fscache IO tracepoints at begin and end of the functions
>
> Dave Wysochanski (7):
>   NFS: Use nfs_i_fscache() consistently within NFS fscache code
>   NFS: Cleanup usage of nfs_inode in fscache interface and handle i_size
>     properly
>   NFS: Convert NFS fscache enable/disable dfprintks to tracepoints
>   NFS: Rename fscache read and write pages functions
>   NFS: Replace dfprintks with tracepoints in read and write page
>     functions
>   NFS: Remove remaining dfprintks related to fscache cookies
>   NFS: Remove remaining usages of NFSDBG_FSCACHE
>
>  fs/nfs/fscache-index.c      |  2 -
>  fs/nfs/fscache.c            | 76 +++++++++++++----------------------
>  fs/nfs/fscache.h            | 25 ++++++------
>  fs/nfs/nfstrace.h           | 98 +++++++++++++++++++++++++++++++++++++++++++++
>  fs/nfs/read.c               |  4 +-
>  include/uapi/linux/nfs_fs.h |  2 +-
>  6 files changed, 140 insertions(+), 67 deletions(-)
>
> --
> 1.8.3.1
>

Just a report on the testing of this patchset, which also tested
dhowells fscache-remove-old-io branch.  Overall this looks very
stable.

I ran some custom unit tests as well as many xfstest runs.  I saw
no oops or other significant problems during any of the runs.
I saw no differences in Failures on xfstest runs between 5.15.0-rc4
and this set.
I ran the following configurations of servers and NFS options for the
runs (5.15.0-rc4, then 5.15.0-rc4 + this patchset).
1. hammerspace (pnfs flexfiles): vers=4.1,fsc; vers=4.1,nofsc;
vers=4.2,fsc; vers=4.2,nofsc
2. ontap9.x (pnfs filelayout): vers=4.1,fsc; vers=4.1,nofsc
3. rhel7u8 (3.10.0-1127.8.2.el7): vers=3,nofsc; vers=4.0,nofsc;
vers=4.0,fsc; vers=4.2,fsc; vers=4.2,nofsc
4. rhel8 (4.18.0-193.28.1.el8): vers=4.2,fsc

