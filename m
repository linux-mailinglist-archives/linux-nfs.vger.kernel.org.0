Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94979260EF8
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Sep 2020 11:46:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728676AbgIHJqJ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 8 Sep 2020 05:46:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728591AbgIHJqJ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 8 Sep 2020 05:46:09 -0400
X-Greylist: delayed 314 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 08 Sep 2020 02:46:08 PDT
Received: from smtp-o-2.desy.de (smtp-o-2.desy.de [IPv6:2001:638:700:1038::1:9b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4A1BC061573
        for <linux-nfs@vger.kernel.org>; Tue,  8 Sep 2020 02:46:08 -0700 (PDT)
Received: from smtp-buf-2.desy.de (smtp-buf-2.desy.de [IPv6:2001:638:700:1038::1:a5])
        by smtp-o-2.desy.de (Postfix) with ESMTP id C2D041608B1
        for <linux-nfs@vger.kernel.org>; Tue,  8 Sep 2020 11:40:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp-o-2.desy.de C2D041608B1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=desy.de; s=default;
        t=1599558047; bh=pfH4K6wCmb0KF4mRphAndyY/C5sgD0c6bwd8YrTkM5o=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=LXhB2cMX8KZ3A07oMrvAyrbayz1DRnCEGapHNpijBugboOQNpzpI7d2D1KU2EvS2O
         QhbQ65t3ranpZ0niaDabvVC22jr7aJx+XuVcMtoWeb4KFeVHqw+lqzL4CyBw/oNmTs
         omvVq8Tkahoq4k1lrN1bohART65GP1kjsYe3O4dk=
Received: from smtp-m-2.desy.de (smtp-m-2.desy.de [131.169.56.130])
        by smtp-buf-2.desy.de (Postfix) with ESMTP id BDD911A0088;
        Tue,  8 Sep 2020 11:40:47 +0200 (CEST)
X-Virus-Scanned: amavisd-new at desy.de
Received: from z-mbx-2.desy.de (z-mbx-2.desy.de [131.169.55.140])
        by smtp-intra-3.desy.de (Postfix) with ESMTP id 92B9C80067;
        Tue,  8 Sep 2020 11:40:47 +0200 (CEST)
Date:   Tue, 8 Sep 2020 11:40:47 +0200 (CEST)
From:   "Mkrtchyan, Tigran" <tigran.mkrtchyan@desy.de>
To:     Daire Byrne <daire@dneg.com>
Cc:     linux-nfs <linux-nfs@vger.kernel.org>, linux-cachefs@redhat.com
Message-ID: <1642729052.4237865.1599558047149.JavaMail.zimbra@desy.de>
In-Reply-To: <943482310.31162206.1599499860595.JavaMail.zimbra@dneg.com>
References: <943482310.31162206.1599499860595.JavaMail.zimbra@dneg.com>
Subject: Re: Adventures in NFS re-exporting
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 8.8.15_GA_3959 (ZimbraWebClient - FF80 (Linux)/8.8.15_GA_3953)
Thread-Topic: Adventures in NFS re-exporting
Thread-Index: fNDm/l4o9cYx5Rz5g0S1EO4zMAtIR5PHKb0P
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


Just out of curiosity:

did you have tries instead of re-exporting nfs mount directly
re-export an overlayfs mount on top of the original nfs mount?
Such setup should cover most of your issues.

Regards,
   Tigran.

----- Original Message -----
> From: "Daire Byrne" <daire@dneg.com>
> To: "linux-nfs" <linux-nfs@vger.kernel.org>
> Cc: linux-cachefs@redhat.com
> Sent: Monday, September 7, 2020 7:31:00 PM
> Subject: Adventures in NFS re-exporting

> Hi,
> 
> Apologies for this rather long email, but I thought there may be some interest
> out there in the community in how and why we've been doing something
> unsupported and barely documented - NFS re-exporting! And I'm not sure I can
> tell our story well in just a few short sentences so please bear with me (or
> stop now!).
> 
> Full disclosure - I am also rather hoping that this story piques some interest
> amongst developers to help make our rather niche setup even better and perhaps
> a little better documented. I also totally understand if this is something
> people wouldn't want to touch with a very long barge pole....
> 
> First a quick bit of history (I hope I have this right). Late in 2015, Jeff
> Layton proposed a patch series allowing knfsd to re-export a NFS client mount.
> The rationale then was to provide a "proxy" server that could mount an NFSv4
> only server and re-export it to older clients that only supported NFSv3. One of
> the main sticking points then (as now), was around the 63 byte limit of
> filehandles for NFSv3 and how it couldn't be guaranteed that all re-exported
> filehandles would fit within that (in my experience it mostly works with
> "no_subtree_check"). There are also the usual locking and coherence concerns
> with NFSv3 too but I'll get to that in a bit.
> 
> Then almost two years later, v4.13 was released including parts of the patch
> series that actually allowed the re-export and since then other relevant bits
> (such as the open file cache) have also been merged. I soon became interested
> in using this new functionality to both accelerate our on-premises NFS storage
> and use it as a "WAN cache" to provide cloud compute instances locally cached
> proxy access to our on-premises storage.
> 
> Cut to a brief introduction to us and what we do... DNEG is an award winning VFX
> company which uses large compute farms to generate complex final frame renders
> for movies and TV. This workload mostly consists of reads of common data shared
> between many render clients (e.g textures, geometry) and a little unique data
> per frame. All file writes are to unique files per process (frames) and there
> is very little if any writing over existing files. Hence it's not very
> demanding on locking and coherence guarantees.
> 
> When our on-premises NFS storage is being overloaded or the server's network is
> maxed out, we can place multiple re-export servers in between them and our farm
> to improve performance. When our on-premises render farm is not quite big
> enough to meet a deadline, we spin up compute instances with a (reasonably
> local) cloud provider. Some of these cloud instances are Linux NFS servers
> which mount our on-premises NFS storage servers (~10ms away) and re-export
> these to the other cloud (render) instances. Since we know that the data we are
> reading doesn't change often, we can increase the actimeo and even use nocto to
> reduce the network chatter back to the on-prem servers. These re-export servers
> also use fscache/cachefiles to cache data to disk so that we can retain TBs of
> previously read data locally in the cloud over long periods of time. We also
> use NFSv4 (less network chatter) all the way from our on-prem storage to the
> re-export server and then on to the clients.
> 
> The re-export server(s) quickly builds up both a memory cache and disk backed
> fscache/cachefiles storage cache of our working data set so the data being
> pulled from on-prem lessens over time. Data is only ever read once over the WAN
> network from on-prem storage and then read multiple times by the many render
> client instances in the cloud. Recent NFS features such as "nconnect" help to
> speed up the initial reading of data from on-prem by using multiple connections
> to offset TCP latency. At the end of the render, we write the files back
> through the re-export server to our on-prem storage. Our average read bandwidth
> is many times higher than our write bandwidth.
> 
> Rather surprisingly, this mostly works for our particular workloads. We've
> completed movies using this setup and saved money on commercial caching systems
> (e.g Avere, GPFS, etc). But there are still some remaining issues with doing
> something that is very much not widely supported (or recommended). In most
> cases we have worked around them, but it would be great if we didn't have to so
> others could also benefit. I will list the main problems quickly now and
> provide more information and reproducers later if anyone is interested.
> 
> 1) The kernel can drop entries out of the NFS client inode cache (under memory
> cache churn) when those filehandles are still being used by the knfsd's remote
> clients resulting in sporadic and random stale filehandles. This seems to be
> mostly for directories from what I've seen. Does the NFS client not know that
> knfsd is still using those files/dirs? The workaround is to never drop inode &
> dentry caches on the re-export servers (vfs_cache_pressure=1). This also helps
> to ensure that we actually make the most of our actimeo=3600,nocto mount
> options for the full specified time.
> 
> 2) If we cache metadata on the re-export server using actimeo=3600,nocto we can
> cut the network packets back to the origin server to zero for repeated lookups.
> However, if a client of the re-export server walks paths and memory maps those
> files (i.e. loading an application), the re-export server starts issuing
> unexpected calls back to the origin server again, ignoring/invalidating the
> re-export server's NFS client cache. We worked around this this by patching an
> inode/iversion validity check in inode.c so that the NFS client cache on the
> re-export server is used. I'm not sure about the correctness of this patch but
> it works for our corner case.
> 
> 3) If we saturate an NFS client's network with reads from the server, all client
> metadata lookups become unbearably slow even if it's all cached in the NFS
> client's memory and no network RPCs should be required. This is the case for
> any NFS client regardless of re-exporting but it affects this case more because
> when we can't serve cached metadata we also can't serve the cached data. It
> feels like some sort of bottleneck in the client's ability to parallelise
> requests? We work around this by not maxing out our network.
> 
> 4) With an NFSv4 re-export, lots of open/close requests (hundreds per second)
> quickly eat up the CPU on the re-export server and perf top shows we are mostly
> in native_queued_spin_lock_slowpath. Does NFSv4 also need an open file cache
> like that added to NFSv3? Our workaround is to either fix the thing doing lots
> of repeated open/closes or use NFSv3 instead.
> 
> If you made it this far, I've probably taken up way too much of your valuable
> time already. If nobody is interested in this rather niche application of the
> Linux client & knfsd, then I totally understand and I will not mention it here
> again. If your interest is piqued however, I'm happy to go into more detail
> about any of this with the hope that this could become a better documented and
> understood type of setup that others with similar workloads could reference.
> 
> Also, many thanks to all the Linux NFS developers for the amazing work you do
> which, in turn, helps us to make great movies. :)
> 
> Daire (Head of Systems DNEG)
