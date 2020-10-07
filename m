Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0F11286102
	for <lists+linux-nfs@lfdr.de>; Wed,  7 Oct 2020 16:15:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728560AbgJGOPf (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 7 Oct 2020 10:15:35 -0400
Received: from p3plsmtpa06-01.prod.phx3.secureserver.net ([173.201.192.102]:34530
        "EHLO p3plsmtpa06-01.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728230AbgJGOPe (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 7 Oct 2020 10:15:34 -0400
X-Greylist: delayed 438 seconds by postgrey-1.27 at vger.kernel.org; Wed, 07 Oct 2020 10:15:34 EDT
Received: from [10.64.176.159] ([192.138.178.211])
        by :SMTPAUTH: with ESMTPSA
        id QA74kI5mYXReoQA75kKVa8; Wed, 07 Oct 2020 07:08:15 -0700
X-CMAE-Analysis: v=2.3 cv=DKHxHBFb c=1 sm=1 tr=0
 a=5HL3Asy66/FZFZAtvjrEgQ==:117 a=5HL3Asy66/FZFZAtvjrEgQ==:17
 a=IkcTkHD0fZMA:10 a=mJjC6ScEAAAA:8 a=yVUtY6i4JWGfK-NmFg0A:9 a=QEXdDO2ut3YA:10
 a=ijnPKfduoCotzip5AuI1:22
X-SECURESERVER-ACCT: tom@talpey.com
Subject: Re: unsharing tcp connections from different NFS mounts
To:     Igor Ostrovsky <igor@purestorage.com>,
        Bruce Fields <bfields@fieldses.org>
Cc:     Chuck Lever <chuck.lever@oracle.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
References: <20201006151335.GB28306@fieldses.org>
 <43CA4047-F058-4339-AD64-29453AE215D6@oracle.com>
 <20201006152223.GD28306@fieldses.org>
 <bb58e43a-f23d-d5f5-ac53-9230267f7faa@talpey.com>
 <20201006193044.GC32640@fieldses.org>
 <CAGrwUG5_KeRVR8chcA8=3FSeii2+4c8FbuE=CSGAtYVYqV4kLg@mail.gmail.com>
From:   Tom Talpey <tom@talpey.com>
Message-ID: <5064e851-5fa3-ee37-a5c7-a6e9f02e2b8d@talpey.com>
Date:   Wed, 7 Oct 2020 10:08:15 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <CAGrwUG5_KeRVR8chcA8=3FSeii2+4c8FbuE=CSGAtYVYqV4kLg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfMODCJXF9AGAOLq5jBSVJ8SdvcUBKjX6Ysr7QqeYbfvAjSD6QEwE1kDe5ZG37AwPQrmd2GCvrR2/pIYddUjy1n+APO5yLOwrbXDuBgajSjCQGLh0A4Hl
 IPaAgF2Z5SPNv9YVGlXELDBy2c2JefztbbsTKUB/I4p5rIKaSQaD/6Uhv6LM/BbPqdlgjV4YkGm3xLaxhh1repOxAP8rTJzWldHXDtwjoCVhb7eE0V0U17+E
 8+beV0190844LGnIgJZFzFouskiRNJla5+vn0MF0G6Q=
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 10/6/2020 5:26 PM, Igor Ostrovsky wrote:
> 
> 
> On Tue, Oct 6, 2020 at 12:30 PM Bruce Fields <bfields@fieldses.org 
> <mailto:bfields@fieldses.org>> wrote:
> 
>     On Tue, Oct 06, 2020 at 01:07:11PM -0400, Tom Talpey wrote:
>      > On 10/6/2020 11:22 AM, Bruce Fields wrote:
>      > >On Tue, Oct 06, 2020 at 11:20:41AM -0400, Chuck Lever wrote:
>      > >>
>      > >>
>      > >>>On Oct 6, 2020, at 11:13 AM, bfields@fieldses.org
>     <mailto:bfields@fieldses.org> wrote:
>      > >>>
>      > >>>NFSv4.1+ differs from earlier versions in that it always performs
>      > >>>trunking discovery that results in mounts to the same server
>     sharing a
>      > >>>TCP connection.
>      > >>>
>      > >>>It turns out this results in performance regressions for some
>     users;
>      > >>>apparently the workload on one mount interferes with
>     performance of
>      > >>>another mount, and they were previously able to work around
>     the problem
>      > >>>by using different server IP addresses for the different mounts.
>      > >>>
>      > >>>Am I overlooking some hack that would reenable the previous
>     behavior?
>      > >>>Or would people be averse to an "-o noshareconn" option?
>      > >>
>      > >>I thought this was what the nconnect mount option was for.
>      > >
>      > >I've suggested that.  It doesn't isolate the two mounts from
>     each other
>      > >in the same way, but I can imagine it might make it less likely
>     that a
>      > >user on one mount will block a user on another?  I don't know,
>     it might
>      > >depend on the details of their workload and a certain amount of
>     luck.
>      >
>      > Wouldn't it be better to fully understand the reason for the
>      > performance difference, before changing the mount API? If it's
>      > a guess, it'll come back to haunt the code for years.
>      >
>      > For example, maybe it's lock contention in the xprt transport code,
>      > or in the socket stack.
> 
>     Yeah, I wonder too, and I don't have the details.
> 
> 
> I've seen cases like this:
> 
>      dd if=/dev/zero of=/mnt/mount1/zeros &
>      ls /mnt/mount2/
> 
> If /mnt/mount1 and /mnt/mount2 are NFS v3 mounts to the same server IP, 
> the access to /mnt/mount2 can take a long time because the RPCs from "ls 
> /mnt/mount2/" get stuck behind a bunch of the writes to /mnt/mount1. If 
> /mnt/mount1 and /mnt/mount2 are different IPs to the same server, the 
> accesses to /mnt/mount2 aren't impacted by the write workload on 
> /mnt/mount1 (unless there is a saturation on the  server side, obviously).

This is plausible, and if so, I believe it indicates a credit/slot
shortage.

Does the client request more slots when it begins to share another
mount point on the connection? Does the server grant them, if so?

Tom.

> 
> It sounds like with NFS v4.1 trunking discovery, using separate IPs for 
> the two mounts is no longer a sufficient workaround.
> Igor
