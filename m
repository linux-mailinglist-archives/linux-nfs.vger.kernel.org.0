Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79E452602EA
	for <lists+linux-nfs@lfdr.de>; Mon,  7 Sep 2020 19:38:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729437AbgIGRir convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-nfs@lfdr.de>); Mon, 7 Sep 2020 13:38:47 -0400
Received: from natter.dneg.com ([193.203.89.68]:34474 "EHLO natter.dneg.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729466AbgIGRih (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 7 Sep 2020 13:38:37 -0400
X-Greylist: delayed 452 seconds by postgrey-1.27 at vger.kernel.org; Mon, 07 Sep 2020 13:38:36 EDT
Received: from localhost (localhost [127.0.0.1])
        by natter.dneg.com (Postfix) with ESMTP id 20FCE2848C90;
        Mon,  7 Sep 2020 18:31:01 +0100 (BST)
X-Virus-Scanned: amavisd-new at mx-dneg
Received: from natter.dneg.com ([127.0.0.1])
        by localhost (natter.dneg.com [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id dV6jUbHGbBsO; Mon,  7 Sep 2020 18:31:01 +0100 (BST)
Received: from zrozimbrai.dneg.com (zrozimbrai.dneg.com [10.11.20.12])
        by natter.dneg.com (Postfix) with ESMTPS id 002DD2848C89;
        Mon,  7 Sep 2020 18:31:00 +0100 (BST)
Received: from localhost (localhost [127.0.0.1])
        by zrozimbrai.dneg.com (Postfix) with ESMTP id 58C1881476B4;
        Mon,  7 Sep 2020 18:31:00 +0100 (BST)
Received: from zrozimbrai.dneg.com ([127.0.0.1])
        by localhost (zrozimbrai.dneg.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id BWVtRn1HPtxC; Mon,  7 Sep 2020 18:31:00 +0100 (BST)
Received: from localhost (localhost [127.0.0.1])
        by zrozimbrai.dneg.com (Postfix) with ESMTP id 3D9BB81476B7;
        Mon,  7 Sep 2020 18:31:00 +0100 (BST)
X-Virus-Scanned: amavisd-new at zimbra-dneg
Received: from zrozimbrai.dneg.com ([127.0.0.1])
        by localhost (zrozimbrai.dneg.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 1EglrZDnGaXS; Mon,  7 Sep 2020 18:31:00 +0100 (BST)
Received: from zrozimbra1.dneg.com (zrozimbra1.dneg.com [10.11.16.16])
        by zrozimbrai.dneg.com (Postfix) with ESMTP id 26DB381476B5;
        Mon,  7 Sep 2020 18:31:00 +0100 (BST)
Date:   Mon, 7 Sep 2020 18:31:00 +0100 (BST)
From:   Daire Byrne <daire@dneg.com>
To:     linux-nfs@vger.kernel.org
Cc:     linux-cachefs@redhat.com
Message-ID: <943482310.31162206.1599499860595.JavaMail.zimbra@dneg.com>
Subject: Adventures in NFS re-exporting
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Mailer: Zimbra 8.7.11_GA_1854 (ZimbraWebClient - GC78 (Linux)/8.7.11_GA_1854)
Thread-Index: fNDm/l4o9cYx5Rz5g0S1EO4zMAtIRw==
Thread-Topic: Adventures in NFS re-exporting
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi,

Apologies for this rather long email, but I thought there may be some interest out there in the community in how and why we've been doing something unsupported and barely documented - NFS re-exporting! And I'm not sure I can tell our story well in just a few short sentences so please bear with me (or stop now!).

Full disclosure - I am also rather hoping that this story piques some interest amongst developers to help make our rather niche setup even better and perhaps a little better documented. I also totally understand if this is something people wouldn't want to touch with a very long barge pole....

First a quick bit of history (I hope I have this right). Late in 2015, Jeff Layton proposed a patch series allowing knfsd to re-export a NFS client mount. The rationale then was to provide a "proxy" server that could mount an NFSv4 only server and re-export it to older clients that only supported NFSv3. One of the main sticking points then (as now), was around the 63 byte limit of filehandles for NFSv3 and how it couldn't be guaranteed that all re-exported filehandles would fit within that (in my experience it mostly works with "no_subtree_check"). There are also the usual locking and coherence concerns with NFSv3 too but I'll get to that in a bit.

Then almost two years later, v4.13 was released including parts of the patch series that actually allowed the re-export and since then other relevant bits (such as the open file cache) have also been merged. I soon became interested in using this new functionality to both accelerate our on-premises NFS storage and use it as a "WAN cache" to provide cloud compute instances locally cached proxy access to our on-premises storage.

Cut to a brief introduction to us and what we do... DNEG is an award winning VFX company which uses large compute farms to generate complex final frame renders for movies and TV. This workload mostly consists of reads of common data shared between many render clients (e.g textures, geometry) and a little unique data per frame. All file writes are to unique files per process (frames) and there is very little if any writing over existing files. Hence it's not very demanding on locking and coherence guarantees.

When our on-premises NFS storage is being overloaded or the server's network is maxed out, we can place multiple re-export servers in between them and our farm to improve performance. When our on-premises render farm is not quite big enough to meet a deadline, we spin up compute instances with a (reasonably local) cloud provider. Some of these cloud instances are Linux NFS servers which mount our on-premises NFS storage servers (~10ms away) and re-export these to the other cloud (render) instances. Since we know that the data we are reading doesn't change often, we can increase the actimeo and even use nocto to reduce the network chatter back to the on-prem servers. These re-export servers also use fscache/cachefiles to cache data to disk so that we can retain TBs of previously read data locally in the cloud over long periods of time. We also use NFSv4 (less network chatter) all the way from our on-prem storage to the re-export server and then on to the clients.

The re-export server(s) quickly builds up both a memory cache and disk backed fscache/cachefiles storage cache of our working data set so the data being pulled from on-prem lessens over time. Data is only ever read once over the WAN network from on-prem storage and then read multiple times by the many render client instances in the cloud. Recent NFS features such as "nconnect" help to speed up the initial reading of data from on-prem by using multiple connections to offset TCP latency. At the end of the render, we write the files back through the re-export server to our on-prem storage. Our average read bandwidth is many times higher than our write bandwidth.

Rather surprisingly, this mostly works for our particular workloads. We've completed movies using this setup and saved money on commercial caching systems (e.g Avere, GPFS, etc). But there are still some remaining issues with doing something that is very much not widely supported (or recommended). In most cases we have worked around them, but it would be great if we didn't have to so others could also benefit. I will list the main problems quickly now and provide more information and reproducers later if anyone is interested.

1) The kernel can drop entries out of the NFS client inode cache (under memory cache churn) when those filehandles are still being used by the knfsd's remote clients resulting in sporadic and random stale filehandles. This seems to be mostly for directories from what I've seen. Does the NFS client not know that knfsd is still using those files/dirs? The workaround is to never drop inode & dentry caches on the re-export servers (vfs_cache_pressure=1). This also helps to ensure that we actually make the most of our actimeo=3600,nocto mount options for the full specified time.

2) If we cache metadata on the re-export server using actimeo=3600,nocto we can cut the network packets back to the origin server to zero for repeated lookups. However, if a client of the re-export server walks paths and memory maps those files (i.e. loading an application), the re-export server starts issuing unexpected calls back to the origin server again, ignoring/invalidating the re-export server's NFS client cache. We worked around this this by patching an inode/iversion validity check in inode.c so that the NFS client cache on the re-export server is used. I'm not sure about the correctness of this patch but it works for our corner case.

3) If we saturate an NFS client's network with reads from the server, all client metadata lookups become unbearably slow even if it's all cached in the NFS client's memory and no network RPCs should be required. This is the case for any NFS client regardless of re-exporting but it affects this case more because when we can't serve cached metadata we also can't serve the cached data. It feels like some sort of bottleneck in the client's ability to parallelise requests? We work around this by not maxing out our network.

4) With an NFSv4 re-export, lots of open/close requests (hundreds per second) quickly eat up the CPU on the re-export server and perf top shows we are mostly in native_queued_spin_lock_slowpath. Does NFSv4 also need an open file cache like that added to NFSv3? Our workaround is to either fix the thing doing lots of repeated open/closes or use NFSv3 instead.

If you made it this far, I've probably taken up way too much of your valuable time already. If nobody is interested in this rather niche application of the Linux client & knfsd, then I totally understand and I will not mention it here again. If your interest is piqued however, I'm happy to go into more detail about any of this with the hope that this could become a better documented and understood type of setup that others with similar workloads could reference.

Also, many thanks to all the Linux NFS developers for the amazing work you do which, in turn, helps us to make great movies. :)

Daire (Head of Systems DNEG)
