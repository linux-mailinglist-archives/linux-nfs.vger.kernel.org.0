Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 892F7301DF0
	for <lists+linux-nfs@lfdr.de>; Sun, 24 Jan 2021 18:38:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726007AbhAXRiJ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 24 Jan 2021 12:38:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725768AbhAXRiH (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 24 Jan 2021 12:38:07 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E56CCC061573
        for <linux-nfs@vger.kernel.org>; Sun, 24 Jan 2021 09:37:26 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id e15so8766039wme.0
        for <linux-nfs@vger.kernel.org>; Sun, 24 Jan 2021 09:37:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelim-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4ufeqGz0DcNtinbDqKb4c8WbsA32OLFbjcs/oZ5nelI=;
        b=mT/wJXFFxI9mEdHKEBNjoPQSUKHiJvVuN72Cdq0Tf+mv6JD88mEWRZ9GMB1sTi09Sg
         JUlewKnAXlIuzumfbGw4JgQ3jQhbnsYXCUM9KDNmVk4gI9TJQi6+5RpfO3ggqqJvxchM
         uirGmy/05pEvWWqUJ+9swaiPukCt6NN/3QtylCZIj/aQddrnc5aDO9ypSe0q6umPoZcO
         XWOW/8jGOqrWqQQKuG0syk6YHysmI4Y581NG9GeYqHoZ3SjuSIe+WeAKhARX+lmDrDwF
         VPLxFvZnwxnnU14l5IlGehWGfiY8uxhHmfhgbsLt2WYKG7H3lA1E3xep7W34l5xglome
         YK0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4ufeqGz0DcNtinbDqKb4c8WbsA32OLFbjcs/oZ5nelI=;
        b=qUiiSonltq/IqV7fPzcvNGqG7AvaUtp605LJfOXm0UXZHUhPzrFJ5e1yr8vVei1Vg5
         Dd7Fk/Z5oNf5yU4c9tZ2AW1ekYWpJe9YjSXnV3rqVldNhxGaS+AoDjX0fg69/yEup1/k
         sx7WQsgCe1sdIhC/TARmcXKlvS6I4oE3grsFdPoakGZjlcZDinPVvfMSh5CGzoX8gIDN
         Rb36mYHSL+GFb6fCpnNLFxAJc60Ik2lvQonM455NvpPoRn/H+cj4ZHVkxghnAMZzZCLD
         yZrniMxkzrnM442GNvbe2EDpcc6JJcnWbC0g7/CcrLVnbDK/box38DC6KRo+dmyNd9Ay
         KNDg==
X-Gm-Message-State: AOAM530P6LWM56zo6Bx7n+MS32ckcqTr0ATT9xq+6jDz5oVE9NM45CBo
        ZfXTfimm3+ovQj4kaHMW8zxaIG4H3mI2SMqo
X-Google-Smtp-Source: ABdhPJwZnki6v8keEIf0jrA7M4qrSibYynp9PUSV3HSKYIkx6H4Hu45DwW382NMfNf6H2z5u14qLKw==
X-Received: by 2002:a1c:11:: with SMTP id 17mr4282586wma.12.1611509845462;
        Sun, 24 Jan 2021 09:37:25 -0800 (PST)
Received: from gmail.com ([77.124.84.167])
        by smtp.gmail.com with ESMTPSA id b69sm18986009wmb.36.2021.01.24.09.37.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Jan 2021 09:37:24 -0800 (PST)
Date:   Sun, 24 Jan 2021 19:37:21 +0200
From:   Dan Aloni <dan@kernelim.com>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>
Subject: Re: [PATCH v1 0/5] NFSv3 client RDMA multipath enhancements
Message-ID: <20210124173721.lck7p4pf2i375bwl@gmail.com>
References: <20210121191020.3144948-1-dan@kernelim.com>
 <55B302B4-7202-45A7-84F3-8F33A79C138F@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55B302B4-7202-45A7-84F3-8F33A79C138F@oracle.com>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Jan 21, 2021 at 07:50:41PM +0000, Chuck Lever wrote:
> I worked with the IETF's nfsv4 WG a couple years ago to produce
> a document that describes how we want NFS servers to advertise
> their network configuration to clients.
> 
> https://datatracker.ietf.org/doc/rfc8587/
> 
> That gives a flavor for what we've done for NFSv4. IMO anything
> done for NFSv3 ought to leverage similar principles and tactics.
 
Thanks for the pointer - I'll read and take it into consideration.

> > we can achieve load
> > balancing and much greater throughput, especially on RDMA setups,
> > even with the older NFSv3 protocol.
> 
> I support the basic goal of increasing transport parallelism.
> 
> As you probably became aware as you worked on these patches, the
> Linux client shares one or a small set of connections across all
> mount points of the same server. So a mount option that adds this
> kind of control is going to be awkward.

I tend to agree, from a developer perspective, but just to give an
idea that from an admin POV it is often is not immediately apparent that
this is what happens behind the scenes (i.e. the `nfs_match_client`
function), so in our case the users have not reported back that our
addition to the mount parameters looked weird, considering it as
naturally extending nconnect, which I think falls under similar
considerations - giving deeper details regarding how transports should
behave during the mount command and not afterwards, regarding what
actual NFS sessions are established.

Surely there may be better ways to do this, following from what's
discussed next.

> Anna has proposed a /sys API that would enable this information to
> be programmed into the kernel for all mount points sharing the
> same set of connections. That would be a little nicer for building
> separate administrator tools against, or even for providing an
> automation mechanism (like an orchestrator) that would enable
> clients to automatically fail over to a different server interface.
>
> IMO I'd prefer to see a user space policy / tool that manages
> endpoint lists and passes them to the kernel client dynamically
> via Anna's API instead of adding one or more mount options, which
> would be fixed for the life of the mount and shared with other
> mount points that use the same transports to communicate with
> the NFS server.

I see now that these are fairly recent patches that I've unfortunately
missed while working on other things. If this is the intended API to
help manage active NFS sessions, I would very much like to help on
testing and extending this code.

So a good way to go with this would be to look into supporting an 'add
transport' op by extending on the new interface, and for optionally
specifying local address bind similarly to the work I've done for the
mount options.

I'll also be glad to contribute to nfs-utils so that we'd have the
anticipated userspace tool, maybe 'nfs' (like `/sbin/ip` from iproute),
that can executed for this purpose, e.g. 'nfs transport add <IP> mnt
<PATH>'.

Also, from a lower level API perspective, we would need a way to figure
out client ID from a mount point, so that ID can be used at the relevant
sysfs directory. Perhaps this can be done via a new ioctl on the
mount point itself?

> As far as the NUMA affinity issues go, in the past I've attempted
> to provide some degree of CPU affinity between RPC Call and Reply
> handling only to find that it reduced performance unacceptably.
> Perhaps something that is node-aware or LLC-aware would be better
> than CPU affinity, and I'm happy to discuss that and any other
> ways we think can improve NFS behavior on NUMA systems. It's quite
> true that RDMA transports are more sensitive to NUMA than
> traditional socket-based ones.

Also to consider that RDMA is special for this as CPU memory caching can
be skipped, and even main memory - for example a special case where the
NFS read/write payload memory is not the main system memory but mapped
from PCI, and the kernel's own PCI_P2PDMA distance matrix can be used
for better xprt selection.

-- 
Dan Aloni
