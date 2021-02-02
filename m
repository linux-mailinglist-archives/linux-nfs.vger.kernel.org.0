Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9619830CC55
	for <lists+linux-nfs@lfdr.de>; Tue,  2 Feb 2021 20:54:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240120AbhBBTv6 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 2 Feb 2021 14:51:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:26561 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238380AbhBBTvJ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 2 Feb 2021 14:51:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612295383;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aUnhdkaKuEP01sEn9JmGzYG57/c4dp8AoxTPmLJFsr0=;
        b=FZ7NZ5arw09/QGYqnOpPFfUT877OPY02NXXbIjMteY86l0SFcZoFPK041jnf0BNci1rZiK
        8O4aT3soBSKvu30jMlStG/GunvgL50JB8YV2yNZAs/FOeT9YS251dGgpMlsbtUCnLu2kc2
        tfwDsz4/OC9IEJiweiCRpLAo9YOnLwo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-450-GBtUTkHFMWKmQ8b9Lmyyvw-1; Tue, 02 Feb 2021 14:49:41 -0500
X-MC-Unique: GBtUTkHFMWKmQ8b9Lmyyvw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2A4C41008556;
        Tue,  2 Feb 2021 19:49:40 +0000 (UTC)
Received: from [172.16.176.1] (ovpn-64-2.rdu2.redhat.com [10.10.64.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A1B586F139;
        Tue,  2 Feb 2021 19:49:39 +0000 (UTC)
From:   "Benjamin Coddington" <bcodding@redhat.com>
To:     "Dan Aloni" <dan@kernelim.com>
Cc:     "Anna Schumaker" <schumaker.anna@gmail.com>,
        "Chuck Lever" <chuck.lever@oracle.com>,
        "Linux NFS Mailing List" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v2 0/5] SUNRPC: Create sysfs files for changing IP
Date:   Tue, 02 Feb 2021 14:49:38 -0500
Message-ID: <8A686173-B3FF-4122-990C-6E8795D35161@redhat.com>
In-Reply-To: <20210202192417.ug32gmuc2uciik54@gmail.com>
References: <20210202184244.288898-1-Anna.Schumaker@Netapp.com>
 <75F3F315-84AA-41A0-A43A-C531042A9C47@oracle.com>
 <CAFX2JfktYGe4vDtXogFHurdyz4TJx5APj9pb-J5HmsDGC99kaA@mail.gmail.com>
 <20210202192417.ug32gmuc2uciik54@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 2 Feb 2021, at 14:24, Dan Aloni wrote:

> On Tue, Feb 02, 2021 at 01:52:10PM -0500, Anna Schumaker wrote:
>> You're welcome! I'll try to remember to CC him on future versions
>> On Tue, Feb 2, 2021 at 1:51 PM Chuck Lever <chuck.lever@oracle.com> wrote:
>>>
>>> I want to ensure Dan is aware of this work. Thanks for posting, Anna!
>
> Thanks Anna and Chuck. I'm accessing and monitoring the mailing list via
> NNTP and I'm also on #linux-nfs for chatting (da-x).
>
> I see srcaddr was already discussed, so the patches I'm planning to send
> next will be based on the latest version of your patchset and concern
> multipath.
>
> What I'm going for is the following:
>
> - Expose transports that are reachable from xprtmultipath. Each in its
>   own sub-directory, with an interface and status representation similar
>   to the top directory.
> - A way to add/remove transports.
> - Inspiration for coding this is various other things in the kernel that
>   use configfs, perhaps it can be used here too.
>
> Also, what do you think would be a straightforward way for a userspace
> program to find what sunrpc client id serves a mountpoint? If we add an
> ioctl for the mountdir AFAIK it would be the first one that the NFS
> client supports, so I wonder if there's a better interface that can work
> for that.

I'm a fan of adding an ioctl interface for userspace, but I think we'd
better avoid using NFS itself because it would be nice to someday implement
an NFS "shutdown" for non-responsive servers, but sending any ioctl to the
mountpoint could revalidate it, and we'd hang on the GETATTR.

Maybe we can figure out a way to expose the superblock via sysfs for each
mount.

Ben

