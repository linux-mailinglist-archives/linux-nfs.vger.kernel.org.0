Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 898D13F3CD7
	for <lists+linux-nfs@lfdr.de>; Sun, 22 Aug 2021 02:18:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230333AbhHVASw (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 21 Aug 2021 20:18:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbhHVASv (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 21 Aug 2021 20:18:51 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8499DC061575
        for <linux-nfs@vger.kernel.org>; Sat, 21 Aug 2021 17:18:11 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id n18so13051297pgm.12
        for <linux-nfs@vger.kernel.org>; Sat, 21 Aug 2021 17:18:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1Zhv9/yujeM0OHGEc5tActRw2ng9ZBtg3h79PoKRmMg=;
        b=LRlKufOenOSEXpvdOBQA7rlIr1Jd2Cz6sMHETj5vT91u0CSCQKCyyTWXK2AEmdQCF+
         6Egx64Zb0MUYgk3Q4+ticTHW7ZzkN7zWHoSDO9El/Az1lMCCooyySIa8/4ghwhLZKs2z
         WmxE+UjlJAMjWv3z7iSEbpzlCyI5gnppxh92NBQbAeECE/drGWzYgYdjzh+iaLtlme1j
         tAth+xV9Kq6tPEzxODbfDZgZ3WUVrFKOzS3JuC2CmpM9zl802BHuO+rbtN6GGkVtiK/E
         5g5jvloL1BsAknTp+n//NgrziLPt1Xf1DZ8b/lIfmOKHlaKqfH+jbGSh27TUIlIuz+ds
         yTTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1Zhv9/yujeM0OHGEc5tActRw2ng9ZBtg3h79PoKRmMg=;
        b=kqwMp8LpSAnvjX8P62Y0RllWRyuZVjooTRNvDtWQ2VanublPXxNXTqhztkYDSoqse+
         7XQxFlA05zxRQg53TiERL9JSOY8MPGTkKGcC79dXU/FE4V0YXT2ukA5vJDvOHQx8N3f0
         xhO88NXAb+SvbxM9PjF12uGmDaYFK/tVbKioR3sgRgWHU/BVLnjowXGsuS+IWHVkixrb
         +Jz9IvrRrGg7WytqrGfFDHVoai3OZOOSuRq1qQn/amiHv7O+pcxQ/re54DO5hMUSgcoM
         SHaslYhO/4Nf7I4IDv7EAu8EUWqEi8/bzzf44exD5qHYh9O2WA1jQ3R3iKIabtxwdhAS
         TfNQ==
X-Gm-Message-State: AOAM530f5U9faH+KXm17ngPC4i0HiIdI8q/6Mo5Mp9WAITHXOzoP3VJN
        LEscIHynIKnwOa/DHOIm1KbbLNe3lU/HSAbmJdo=
X-Google-Smtp-Source: ABdhPJzvZvdk3IXfj8xHxQoHTXtHxYJP3TUVUuLqu8z18EI1w3YCNSjXZsLVk0GdLytREH9TUugxoMk7eNg/eywVlPY=
X-Received: by 2002:a62:5ec6:0:b0:3e1:d20:957b with SMTP id
 s189-20020a625ec6000000b003e10d20957bmr26321833pfb.24.1629591490780; Sat, 21
 Aug 2021 17:18:10 -0700 (PDT)
MIME-Version: 1.0
References: <CAOv1SKCmdtchm5Z2NU80o49tkrHpAkPFaHKj4-vLDN5bZNCz-Q@mail.gmail.com>
 <162846730406.22632.14734595494457390936@noble.neil.brown.name>
 <CAOv1SKBZ7sGBnvG9-M+De+s=CfU=H_GBs4hJah1E4ks+NSMyPw@mail.gmail.com>
 <CAOv1SKCUM5cGuXWAc7dsXtbmPMATqd245juC+S9gVXHWiZsvmQ@mail.gmail.com>
 <162855893202.12431.3423894387218130632@noble.neil.brown.name>
 <CAOv1SKAaSbfw53LWCCrvGCHESgdtCf5h275Zkzi9_uHkqnCrdg@mail.gmail.com>
 <162882238416.1695.4958036322575947783@noble.neil.brown.name>
 <CAOv1SKB_dsam7P9pzzh_SKCtA8uE9cyFdJ=qquEfhLT42-szPA@mail.gmail.com>
 <CAOv1SKDDOj5UeUwztrMSNJnLgSoEgD8OU55hqtLHffHvaCQzzA@mail.gmail.com>
 <162907681945.1695.10796003189432247877@noble.neil.brown.name>
 <87777C39-BDDA-4E1E-83FA-5B46918A66D3@oracle.com> <CAOv1SKA5ByO7PYQwvd6iBcPieWxEp=BfUZuigJ=7Hm4HAmTuMA@mail.gmail.com>
 <162915491276.9892.7049267765583701172@noble.neil.brown.name>
 <162941948235.9892.6790956894845282568@noble.neil.brown.name> <CAOv1SKAyr0Cixc8eQf8-Fdnf=9Db_xZGsweq9K2E5AkALFqavQ@mail.gmail.com>
In-Reply-To: <CAOv1SKAyr0Cixc8eQf8-Fdnf=9Db_xZGsweq9K2E5AkALFqavQ@mail.gmail.com>
From:   Mike Javorski <mike.javorski@gmail.com>
Date:   Sat, 21 Aug 2021 17:17:59 -0700
Message-ID: <CAOv1SKDDUFpgexZ_xYCe6c2-UCBK0+vicoG+LAtG2Zhispd_jg@mail.gmail.com>
Subject: Re: NFS server regression in kernel 5.13 (tested w/ 5.13.9)
To:     NeilBrown <neilb@suse.de>
Cc:     Chuck Lever III <chuck.lever@oracle.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

OK, so new/fresh captures, reading the same set of files via NFS in
roughly the same timing/sequence (client unchanged between runs)

5.12.15-arch1:
===============
0.042320 124082
0.042594 45837
0.043176 19598
0.044092 63667
0.044613 28192
0.045045 131268
0.045982 116572
0.058507 162444
0.369620 153520
0.825167 164682

5.13.12-arch1: (no freezes)
===============
0.040766 12679
0.041565 64532
0.041799 55440
0.042091 159640
0.042105 75075
0.042134 177776
0.042706 40
0.043334 35322
0.045480 183618
0.204246 83997

Since I didn't get any freezes, I waited a bit, tried again and got a
capture with several freezes...

5.13.12-arch1: (with freezes)
===============
0.042143 55425
0.042252 64787
0.042411 57362
0.042441 34461
0.042503 67041
0.042553 64812
0.042592 55179
0.042715 67002
0.042835 66977
0.043308 64849

Not sure what to make of this, but to my (admittedly untrainted) eye,
the two 5.13.12 sets are very similar to each other as well as to the
5.12.15 sample, I am not sure if this is giving any indication to what
is causing the freezes.

- mike




On Thu, Aug 19, 2021 at 5:52 PM Mike Javorski <mike.javorski@gmail.com> wrote:
>
> Neil:
>
> I did still have the original/source cap for that 5.13 file. I ran the
> command you gave and got the 10 last entries:
> 0.013086 31352
> 0.013318 28399
> 0.013339 3521
> 0.013783 32423
> 0.014519 32481
> 0.014773 6145
> 0.015063 19034
> 0.015829 25892
> 0.042356 29089
> 0.042581 5779
>
> I did have another test cap which was from an early 5.13 dev compile
> prior to the nfs patches (what the Archlinux devs asked me to try). In
> that file (which is 1.8G vs the 400M of the above file), the 10 last
> entries are:
> 0.042038 575
> 0.042190 87093
> 0.042313 30183
> 0.042377 34941
> 0.042521 53593
> 0.042801 113067
> 0.042930 1174
> 0.043285 87326
> 0.043851 61066
> 0.107649 115114
>
> As that seems even worse than the above, I think I need to get a clean
> 5.12 capture to see if it actually was "better" beforehand.
> Unfortunately I am stuck on a work issue tonight, but I will test it
> either tomorrow or at the latest, this weekend.
>
> Thanks for following up on this.
>
> - mike
>
> On Thu, Aug 19, 2021 at 5:31 PM NeilBrown <neilb@suse.de> wrote:
> >
> > On Tue, 17 Aug 2021, NeilBrown wrote:
> > > On Tue, 17 Aug 2021, Mike Javorski wrote:
> > > > Thanks for the pointer Chuck
> > > >
> > > > I ran the trace capture and was able to trigger two freezes in
> > > > relatively short order. Here is that trace file:
> > > > https://drive.google.com/file/d/1qk_VIMkj8aTeQIg5O0W3AvWyeDSWL3vW/view?usp=sharing
> > > >
> > >
> > > There are gaps of 5.3sec, 4sec, 1sec and 1sec between adjacent trace
> > > points.
> > > The longest gap between 'start' and 'done' for any given xid is 354msec.
> > > So it doesn't look like the filesystem read causing the problem.
> > >
> > > The long gaps between adjacent records are:
> > > 0.354581 xid=0x4c6ac2b6
> > > 0.418340 xid=0x6a71c2b6
> > > 1.013260 xid=0x6f71c2b6
> > > 1.020742 xid=0x0f71c2b6
> > > 4.064527 xid=0x6171c2b6
> > > 5.396559 xid=0xd66dc2b6
> > >
> > > The fact 1, 1, and 4 are so close to a precise number of seconds seems
> > > unlikely to be a co-incidence.  It isn't clear what it might mean
> > > though.
> > >
> > > I don't have any immediae ideas where to look next.  I'll let you know
> > > if I come up with something.
> >
> > I had separate bug report
> >   https://bugzilla.suse.com/show_bug.cgi?id=1189508
> > with broadly similar symptoms which strongly points to network-layer
> > problem.  So I'm digging back into that tcpdump.
> >
> > The TCP ACK for READ requests usually goes out in 100 or 200
> > microseconds.  Sometimes longer - by a factor of about 100.
> >
> > % tshark -r /tmp/javmorin-nfsfreeze-5.13.10-cap1\ .test.pcap  -d tcp.port==2049,rpc -Y 'tcp.port==2049 && rpc.msgtyp==0 && nfs.opcode==25' -T fields -e tcp.seq -e frame.time_epoch -e frame.number | sed 's/$/ READ/' > /tmp/read-times
> > % tshark -r /tmp/javmorin-nfsfreeze-5.13.10-cap1\ .test.pcap  -d tcp.port==2049,rpc -Y 'tcp.srcport==2049' -T fields -e tcp.ack -e frame.time_epoch -e frame.number | sed 's/$/ ACK/' > /tmp/ack-times
> > % sort -n /tmp/read-times /tmp/ack-times  | awk '$4 == "ACK" && readtime {printf "%f %d\n", ($2 - readtime), $3; readtime=0} $4 == "READ" {readtime=$2}' | sort -n | tail -4
> > 0.000360 441
> > 0.012777 982
> > 0.013318 1086
> > 0.042356 1776
> >
> > Three times (out of 245) the TCP ACK was 12 milliseconds or longer.  The
> > first and last were times when the reply was delayed by a couple of
> > seconds at least.  The other (1086) was the reply to 1085 - no obvious
> > delay to the READ reply.
> >
> > These unusual delays (short though they are) suggest something odd in
> > the network layer - particularly as they are sometimes followed by a
> > much larger delay in a READ reply.
> >
> > It might be as simple as a memory allocation delay.  It might be
> > something deep in the networking layer.
> >
> > If you still have (or could generate) some larger tcp dumps, you could
> > try that code and see if 5.12 shows any ACK delays, and if 5.13 shows
> > more delays than turn into READ delays.  IF 5.13 easily shows a few ACK
> > delays thats 5.12 doesn't, then they might make a git-bisect more
> > reliable.  Having thousands of READs in the trace rather than just 245
> > should produce more reliable data.
> >
> >
> > As I suggested in the bug report I linked above, I am suspicious of TCP
> > offload when I see symptoms like this.  You can use "ethtool" to turn
> > off that various offload features.  Doing that and trying to reproduce
> > without offload might also provide useful information.
> >
> > NeilBrown
