Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 882565F3667
	for <lists+linux-nfs@lfdr.de>; Mon,  3 Oct 2022 21:36:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbiJCTge (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 3 Oct 2022 15:36:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbiJCTg0 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 3 Oct 2022 15:36:26 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E814621E0E
        for <linux-nfs@vger.kernel.org>; Mon,  3 Oct 2022 12:36:24 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id 3so10524455pga.1
        for <linux-nfs@vger.kernel.org>; Mon, 03 Oct 2022 12:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=xcIpCNncWCzIROwwdDp4tqgDkjaJVOTPJ10ZCPsrQ34=;
        b=QvkSHcIwJs4l6cxo4H5reaKCv5n8V907hbD31x3ifuKv5i00CHyAUBshQg3pMX8H40
         5xG9LuVJsGwxhcFzqlIZ0UHlsVppBLjW8T1iU6QcHYESq7+KI3eW1CIrflNyWjFdFaYW
         jvLuhcOITIYYtHQpm4ajQNcTjXbZlWfSAgRSIVAN/J60dAUDy/uE+upAB2t/gTvnq6uZ
         dMOGgqAUprN4xcQDOR+t5H4STvA78dd3C9Pbu+IzCOSPo8bIyG2iNE6LCEmb/8wnUaWZ
         CG2AypeQInDUImyMqgxzGhy+wFT0VyKDfr99enB5+aRarwUoXGhrO3AnnIah2x6n74jX
         TRhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=xcIpCNncWCzIROwwdDp4tqgDkjaJVOTPJ10ZCPsrQ34=;
        b=rJq478e+vj/TM3OviGeTuM6yKsNT1DL64CJzawAWf0bteyRTLfe/V0/2FJy0nX/qwn
         eIt5lXHUnRVs+riiGTCxQzBxzHSEJter1xkPcwnn6OZnwJsXxVtKg2c5k+4OQBU/V9OA
         V3ALCwDPHrZUwZm2pak5Ys5Flvt+KI4V5yVpR1569nXDep3vQyahhUU/pYxK8AFRs15a
         GOmH0Klu9HOzoA2GGyKdcEGOMlJekvVGwgPTW4h+VqEjpjlbF+fQmKDJGqyWr5BHKFWE
         bTwJvVQgvuA1In5AaHQIQaHIF8cjeAOnhE+nlxRr/uNV1L45ACA6pnNF4JqVjZs3E74W
         ZrWA==
X-Gm-Message-State: ACrzQf3JvCvl1ivbpCPPY1Nb6MS6+GDNA4ktrTzZJZl5SaqMYpeWWVDl
        W4/XIoewpADxW+U9zJ1sSHlIr2ETTUESsgziF/81Vuq3
X-Google-Smtp-Source: AMsMyM41k1C9ltsAWmAcObEd02w0TpIT6CxcniLvPKViO84IWC2BnnXWMXapBsLx4fdS81I115ghb3phf+YiNvzj+G0=
X-Received: by 2002:a62:4e8e:0:b0:54a:ee65:cde6 with SMTP id
 c136-20020a624e8e000000b0054aee65cde6mr24012384pfb.42.1664825784312; Mon, 03
 Oct 2022 12:36:24 -0700 (PDT)
MIME-Version: 1.0
References: <39bf58c7-47d9-744b-6d26-d672aa713024@gmx.ch> <8cd63730f7b5f3e2aa3bde98587de0c6a42b384b.camel@kernel.org>
 <8550c032-2ef8-4ddb-19a0-307777bd9645@gmx.ch> <c163b299164cd9abe21325a947c9efe908a04331.camel@kernel.org>
 <e3842fe7-da95-98e2-b0e8-fa3aede673cc@gmx.ch> <CAN-5tyEj97UO-K=ZcgkhzNr2H3wTd5tq8u+TdPj19-syc81=rw@mail.gmail.com>
 <7133e21b-0fcf-bfa5-3639-056f23b6d55f@gmx.ch>
In-Reply-To: <7133e21b-0fcf-bfa5-3639-056f23b6d55f@gmx.ch>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Mon, 3 Oct 2022 15:36:11 -0400
Message-ID: <CAN-5tyG50VcVmQhaRxB1CzjLtVcMruToE6XxG+NGbq+8mg9JSQ@mail.gmail.com>
Subject: Re: nfs4.1+: workaround for defunct clientaddr?
To:     Manfred Schwarb <manfred99@gmx.ch>
Cc:     Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Oct 3, 2022 at 12:14 PM Manfred Schwarb <manfred99@gmx.ch> wrote:
>
> Am 03.10.22 um 16:18 schrieb Olga Kornievskaia:
> >  Hi Manfred,
> >
> > What's the purpose of segregating your connections? You don't want
> > your backup traffic "interfering" with your regular operation.
> > However, the assumption is that between 2 NICs the backup traffic and
> > regular traffic could co-exists, correct? In that case why not use
> > session trunking?  What you are correctly experiencing is that with
> > 4.1+ the 2nd mount discovers that in the 2nd mount it's the same
> > server the client is talking to (even if it's thru a different IPs)
> > and the client will drop the new connection.
> >
>
> I did not know that I'm supposed to want this ;-)  Sounds interesting.
> I searched for "replica" and "discovertrunking" but did not find anything.
> I'm on Linux 5.14 / nfs-kernel-server-2.1.1. Did you mean "nconnect"
> or is my Linux installation simply too old? Probably. 2.1.1 is 5 years old.
> I'm on openSUSE Leap 15.4, on idea why they ship such old userspace components.

Trunking support is rather new on the client, so you'd need something
that's 5.18+ (that's where "trunkdiscovery" (apologizes for
mislabeling it) option went in but main code support went into 5.17).
"replica=" option on the server I'm not sure how old but not "new".

> > For session trunking, you can configure your linux server (I'm
> > assuming it is, if not that might be a problem) to support session
> > trunking (by using replica=<> option). Then you can also add
> > "discovertrunking" option to your mount command and then the client
> > will discover the 2 available paths to the server. You wouldn't need 2
> > mounts and you'd have both NICs available to serve your combined
> > regular and backup traffic. This would be the solution to utilize both
> > of the NICs (network paths) you have available between the client and
> > the server.
> >
> >
> > On Mon, Oct 3, 2022 at 9:27 AM Manfred Schwarb <manfred99@gmx.ch> wrote:
> >>
> >> Am 03.10.22 um 14:26 schrieb Jeff Layton:
> >>> On Mon, 2022-10-03 at 13:55 +0200, Manfred Schwarb wrote:
> >>>> Am 03.10.22 um 13:39 schrieb Jeff Layton:
> >>>>> On Sun, 2022-10-02 at 14:35 +0200, Manfred Schwarb wrote:
> >>>>>> Hi,
> >>>>>>
> >>>>>> I have 2 boxes connected with 2 network cards each, one
> >>>>>> crossover connection and one connection via LAN.
> >>>>>> I want to use the crossover connection for backup,
> >>>>>> so I want to be able to select exactly this wire when
> >>>>>> doing my NFS backup transfers. Everything interconnected via NFS4.1
> >>>>>> and automount.
> >>>>>>
> >>>>>> Now the thing is, if there is an already existing connection
> >>>>>> via LAN, I am not able to select the crossover connection,
> >>>>>> there is some session reuse against my will.
> >>>>>>
> >>>>>> automount config:
> >>>>>> /net/192.168.99.1  -fstype=nfs4,nfsvers=4,minorversion=1,clientaddr=192.168.99.100   /  192.168.99.1:/
> >>>>>> /net2/192.168.98.1 -fstype=nfs4,nfsvers=4,minorversion=1,clientaddr=192.168.98.100   /  192.168.98.1:/
> >>>>>>
> >>>>>> mount -l:
> >>>>>> 192.168.99.1:/data on /net/192.168.99.1/data type nfs4 (...,clientaddr=192.168.99.100,addr=192.168.99.1)
> >>>>>> 192.168.99.1:/data on /net2/192.168.98.1/data type nfs4 (...,clientaddr=192.168.99.100,addr=192.168.99.1)
> >>>>>>
> >>>>>> As you see, both connections are on "192.168.99.1:/data", and the backup runs
> >>>>>> over the same wire as all user communication, which is not desired.
> >>>>>> This even happens if I explicitly set some clientaddr= option.
> >>>>>>
> >>>>>> Now I found two workarounds:
> >>>>>> - downgrade to NFS 4.0, clientaddr seems to work with it
> >>>>>> - choose different NFS versions, i.e. one connection with
> >>>>>>   minorversion=1 and the other with minorversion=2
> >>>>>>
> >>>>>> Both possibilities seem a bit lame to me.
> >>>>>> Are there some other (recommended) variants which do what I want?
> >>>>>>
> >>>>>> It seems different minor versions result in different "nfs4_unique_id" values,
> >>>>>> and therefore no session sharing occurs. But why do different network
> >>>>>> interfaces (via explicitly set clientaddr= by user) not result in different
> >>>>>> "nfs4_unique_id" values?
> >>>>>>
> >>>>>> Thanks for any comments and advice,
> >>>>>> Manfred
> >>>>>
> >>>>> That sounds like a bug. We probably need to compare the clientaddr
> >>>>> values in nfs_compare_super or nfs_compare_mount_options so that it
> >>>>> doesn't match if the clientaddrs are different.
> >>>>>
> >>>
> >>>
> >>> Actually, I take it back, clientaddr is specifically advertised as being
> >>> for NFSv4.0 only. The workaround for you is "nosharecache", which will
> >>> force the mount under /net2 to get a new superblock altogether.
> >>
> >> But clientaddr is silently accepted on NFS4.1+, and seemingly silently does nothing.
> >>
> >> The point is, RFC5661 explicitely tells
> >> "NFS minor version 1 is deemed superior to NFS minor version 0 with no loss of functionality".
> >>
> >> So this behavior comes as a surprise.
> >>
> >>>
> >>>>> As a workaround, you can probably mount the second mount with
> >>>>> -o nosharecache and get what you want.
> >>>>
> >>>> Indeed, nosharecache works. But the man page has some scary words for it:
> >>>>   "This is considered a data risk".
> >>>>
> >>>
> >>> Yeah, it does sound scary but it's not a huge issue unless you're doing
> >>> I/O to the same files at the same time via both mounts. With
> >>> "sharecache" (the default) you get better cache coherency in that
> >>> situation since the inode and its pagecache are the same.
> >>>
> >>
> >> So I guess this is equivalent to the minorversion=1/minorversion=2 trick
> >> cache coherency wise then?
> >>
> >>
> >>> With "nosharecache" you need to be more careful to flush caches, etc. if
> >>> you are doing reads and writes to the same files via different paths. If
> >>> you need careful coordination there, then you probably want to use file
> >>> locking.
> >>
> >> Thanks for these explanations, it is appreciated!
> >> Manfred
> >>
> >>> --
> >>> Jeff Layton <jlayton@kernel.org>
> >>
>
