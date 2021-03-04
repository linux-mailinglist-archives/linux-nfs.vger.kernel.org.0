Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D038132D43D
	for <lists+linux-nfs@lfdr.de>; Thu,  4 Mar 2021 14:35:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241241AbhCDNen (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 4 Mar 2021 08:34:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:23991 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235378AbhCDNeh (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 4 Mar 2021 08:34:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614864791;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eZErnePlm4eZ0JArI/9slO6CMFQikmZuPkqEeFx4K34=;
        b=fxUGXUWZ7neCCz54P3W0DznnOCYjGjuWHv3Fj6njaq5Q5fE/zI0jBLD2hyuq6C0Y+fjVJ0
        wv3dcVGgbXwCDcHu66JCMFpzFZbyf06ld3e0MKE6oJ7HtL2sI8C9uPI7aBIaHqrZa3O42d
        ipY7zEaeorrUvW1puQYeM0BRM3JBuLo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-439-tZIcLe1uNJCcEM1E8JOMDw-1; Thu, 04 Mar 2021 08:32:58 -0500
X-MC-Unique: tZIcLe1uNJCcEM1E8JOMDw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 270A81054FAF;
        Thu,  4 Mar 2021 13:32:57 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (ovpn-112-45.phx2.redhat.com [10.3.112.45])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7B1F116920;
        Thu,  4 Mar 2021 13:32:56 +0000 (UTC)
Subject: Re: [PATCH 0/7 V4] The NFSv4 only mounting daemon.
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
References: <20210219200815.792667-1-steved@redhat.com>
 <20210224203053.GF11591@fieldses.org>
 <1553fb2d-9b8e-f8eb-8c72-edcd14a2ad08@RedHat.com>
 <20210303152342.GA1282@fieldses.org>
From:   Steve Dickson <SteveD@RedHat.com>
Message-ID: <fce1f95d-a4a5-88a8-3768-c81f7c09f193@RedHat.com>
Date:   Thu, 4 Mar 2021 08:34:45 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210303152342.GA1282@fieldses.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 3/3/21 10:23 AM, J. Bruce Fields wrote:
> On Tue, Mar 02, 2021 at 05:33:23PM -0500, Steve Dickson wrote:
>>
>>
>> On 2/24/21 3:30 PM, J. Bruce Fields wrote:
>>> On Fri, Feb 19, 2021 at 03:08:08PM -0500, Steve Dickson wrote:
>>>> nfsv4.exportd is a daemon that will listen for only v4 mount upcalls.
>>>> The idea is to allow distros to build a v4 only package
>>>> which will have a much smaller footprint than the
>>>> entire nfs-utils package.
>>>>
>>>> exportd uses no RPC code, which means none of the 
>>>> code or arguments that deal with v3 was ported, 
>>>> this again, makes the footprint much smaller. 
>>>
>>> How much smaller?
>> Will a bit smaller... but a number of daemons like nfsd[cld,clddb,cldnts]
>> need to also come a long. 
> 
> Could we get some numbers?
> 
> Looks like nfs-utils in F33 is about 1.2M:
> 
> $ rpm -qi nfs-utils|grep ^Size
> Size        : 1243512
Here are the numbers. Remember things are still in development so
these may not be the final numbers

For the v4 only client
rpm -qi nfsv4-client-utils-2* | grep ^Size
Size        : 374573

for the v4only server:
rpm -qi nfsv4-utils-2* | grep ^Size
Size        : 942088
> 
> $ strip utils/mountd/mountd
> $ ls -lh utils/mountd/mountd
> -rwxrwxr-x. 1 bfields bfields 128K Mar  3 10:12 utils/mountd/mountd
> $ strip utils/exportd/exportd
> $ ls -lh utils/exportd/exportd
> -rwxrwxr-x. 1 bfields bfields 106K Mar  3 10:12 utils/exportd/exportd
> 
> So replacing mountd by exportd saves us about 20K out of 1.2M.  Is it
> worth it?
Looking at the numbers above... I think it is.

steved. 

> 
>>>> The following options were ported:
>>>>     * multiple threads
>>>>     * state-directory-path option
>>>>     * junction support (not tested)
>>>>
>>>> The rest of the mountd options were v3 only options.
>>>
>>> There's also --manage-gids.
>> Right... a patch was posted... 
>>
>>>
>>> If you want nfsv4-only at runtime, you can always run rpc.mountd with
>>> -N2 -N3 to turn off the MOUNT protocol support.
>> The end game is not to run mountd at all... 
>>
>>>
>>> If you don't even want v2/f3 code on your system, then you may have to
>>> do something like this, but why is that important?
>> Container friendly... Not bring in all the extra daemons v3
>> needs is a good thing... esp rpcbind. 
> 
> Looking at the output of
> $ for f in $(rpm -ql nfs-utils); do if [ -f $f ]; then ls -ls $f; fi; done|sort -n
> 
> It looks like removing statd, sm-notify, showount and their man pages
> would free about another 170K.
> 
> I think that's about how much we'd save by seperating out a separate
> documentation package.
> 
> I don't know, what sort of gains are container folks asking for?
> 
> --b.
> 
>>
>> steved.
>>
>>>
>>> --b.
>>>
>>>>
>>>> V2:
>>>>   * Added two systemd services: nfsv4-exportd and nfsv4-server
>>>>   * nfsv4-server starts rpc.nfsd -N 3, so nfs.conf mod not needed.
>>>>
>>>> V3: Changed the name from exportd to nfsv4.exportd
>>>>
>>>> V4: Added compile flag that will compile in the NFSv4 only server
>>>>
>>>> Steve Dickson (7):
>>>>   exportd: the initial shell of the v4 export support
>>>>   exportd: Moved cache upcalls routines into libexport.a
>>>>   exportd: multiple threads
>>>>   exportd/exportfs: Add the state-directory-path option
>>>>   exportd: Enabled junction support
>>>>   exportd: systemd unit files
>>>>   exportd: Added config variable to compile in the NFSv4 only server.
>>>>
>>>>  .gitignore                                |   1 +
>>>>  configure.ac                              |  14 ++
>>>>  nfs.conf                                  |   4 +
>>>>  support/export/Makefile.am                |   3 +-
>>>>  {utils/mountd => support/export}/auth.c   |   4 +-
>>>>  {utils/mountd => support/export}/cache.c  |  46 +++-
>>>>  support/export/export.h                   |  34 +++
>>>>  {utils/mountd => support/export}/fsloc.c  |   0
>>>>  {utils/mountd => support/export}/v4root.c |   0
>>>>  {utils/mountd => support/include}/fsloc.h |   0
>>>>  systemd/Makefile.am                       |   6 +
>>>>  systemd/nfs.conf.man                      |  10 +
>>>>  systemd/nfsv4-exportd.service             |  12 +
>>>>  systemd/nfsv4-server.service              |  31 +++
>>>>  utils/Makefile.am                         |   4 +
>>>>  utils/exportd/Makefile.am                 |  65 +++++
>>>>  utils/exportd/exportd.c                   | 276 ++++++++++++++++++++++
>>>>  utils/exportd/exportd.man                 |  81 +++++++
>>>>  utils/exportfs/exportfs.c                 |  21 +-
>>>>  utils/exportfs/exportfs.man               |   7 +-
>>>>  utils/mountd/Makefile.am                  |   5 +-
>>>>  21 files changed, 606 insertions(+), 18 deletions(-)
>>>>  rename {utils/mountd => support/export}/auth.c (99%)
>>>>  rename {utils/mountd => support/export}/cache.c (98%)
>>>>  create mode 100644 support/export/export.h
>>>>  rename {utils/mountd => support/export}/fsloc.c (100%)
>>>>  rename {utils/mountd => support/export}/v4root.c (100%)
>>>>  rename {utils/mountd => support/include}/fsloc.h (100%)
>>>>  create mode 100644 systemd/nfsv4-exportd.service
>>>>  create mode 100644 systemd/nfsv4-server.service
>>>>  create mode 100644 utils/exportd/Makefile.am
>>>>  create mode 100644 utils/exportd/exportd.c
>>>>  create mode 100644 utils/exportd/exportd.man
>>>>
>>>> -- 
>>>> 2.29.2
>>>
> 

