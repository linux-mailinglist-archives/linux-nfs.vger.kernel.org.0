Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 257783F243C
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Aug 2021 02:52:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234349AbhHTAxA (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 19 Aug 2021 20:53:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234172AbhHTAxA (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 19 Aug 2021 20:53:00 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F439C061575
        for <linux-nfs@vger.kernel.org>; Thu, 19 Aug 2021 17:52:23 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id hv22-20020a17090ae416b0290178c579e424so6090839pjb.3
        for <linux-nfs@vger.kernel.org>; Thu, 19 Aug 2021 17:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QWzWBLM4HbCAZPEjpEU0KrTE3NduBQQr7NcoL7Hf1Uk=;
        b=fS9FrwoWVPx4NZoFzzqySZTa1161+8ZZpdaN3DWqoYg4DHoYwDpSqjUGV31zG9ncEK
         cLXSUEZoBWXOrDslYC3z5K26fZfWs367EStVeoNETh0yEo3TIXAV8/9Gw+CFY5oLy304
         Wdv4b1QyiNHS1q0pWYZwCL2TwlgDYYgQGqoHmQee2sZsmbcz4SPHdHli7t9VMAtyqtPe
         i5bcR1bWyUiR1HRGz7R4kCrpRWv55mkJhEbcPpt8tfNaDOvLoroKYnByo0JBh50Axua1
         vGzBqb/1P4JAgMMBzmcplph4wdfdKt1A5/Lb0uiRgGHorHG6zFzQZDL6IHpjY0oH9lzp
         U05Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QWzWBLM4HbCAZPEjpEU0KrTE3NduBQQr7NcoL7Hf1Uk=;
        b=brDnZSeA9WYfmrHmxzEThPaB8QUFx1p7Un391kVZlDMyo6k6RTixHYBlHdvDULfUsn
         KEWXwBi/wREsBMntXhQ1uVJ9GNbZPGN7giCW+Tbvcan1y+sICcaygW0YmLnPFxmZh+W2
         7/pGF3TNVYgha4ooAWYDtI6UPdnl4TK5kutBRJTRwYdHANQ/eD2eAWIC8dG1bUN7+xkw
         euwXjJ89B5CvJYjyH3FDk0d7wk0/xE4a0bBalWvwkNHqG+3QHCevlGfBVsaJ3/zw0OHC
         ZIcAWrTBNwML1u+Ib3Dd+5uM3SdFNbAmdIzJ91u1za+zq7a9E1ii4JRKZGCy6kab4qjp
         RAmg==
X-Gm-Message-State: AOAM533f2z10KwiXBkTNjqqrPJ4cBbuGKpCJSiLJuSwXtCrUp1GShKQs
        y3Mosj29ElNu5TYsVH1AQr7oJH3vNCSztwe8s60=
X-Google-Smtp-Source: ABdhPJzaE0uX+NWPcXkxAMEufgpjf50+Atr35YP1+UbP+xOL4F9IjvrS3zf2FEXcm3bRvM5q5wPCmJENMvQdJbvx4TA=
X-Received: by 2002:a17:902:fe18:b0:12d:bd2c:897e with SMTP id
 g24-20020a170902fe1800b0012dbd2c897emr14065674plj.12.1629420742645; Thu, 19
 Aug 2021 17:52:22 -0700 (PDT)
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
 <162915491276.9892.7049267765583701172@noble.neil.brown.name> <162941948235.9892.6790956894845282568@noble.neil.brown.name>
In-Reply-To: <162941948235.9892.6790956894845282568@noble.neil.brown.name>
From:   Mike Javorski <mike.javorski@gmail.com>
Date:   Thu, 19 Aug 2021 17:52:11 -0700
Message-ID: <CAOv1SKAyr0Cixc8eQf8-Fdnf=9Db_xZGsweq9K2E5AkALFqavQ@mail.gmail.com>
Subject: Re: NFS server regression in kernel 5.13 (tested w/ 5.13.9)
To:     NeilBrown <neilb@suse.de>
Cc:     Chuck Lever III <chuck.lever@oracle.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Neil:

I did still have the original/source cap for that 5.13 file. I ran the
command you gave and got the 10 last entries:
0.013086 31352
0.013318 28399
0.013339 3521
0.013783 32423
0.014519 32481
0.014773 6145
0.015063 19034
0.015829 25892
0.042356 29089
0.042581 5779

I did have another test cap which was from an early 5.13 dev compile
prior to the nfs patches (what the Archlinux devs asked me to try). In
that file (which is 1.8G vs the 400M of the above file), the 10 last
entries are:
0.042038 575
0.042190 87093
0.042313 30183
0.042377 34941
0.042521 53593
0.042801 113067
0.042930 1174
0.043285 87326
0.043851 61066
0.107649 115114

As that seems even worse than the above, I think I need to get a clean
5.12 capture to see if it actually was "better" beforehand.
Unfortunately I am stuck on a work issue tonight, but I will test it
either tomorrow or at the latest, this weekend.

Thanks for following up on this.

- mike

On Thu, Aug 19, 2021 at 5:31 PM NeilBrown <neilb@suse.de> wrote:
>
> On Tue, 17 Aug 2021, NeilBrown wrote:
> > On Tue, 17 Aug 2021, Mike Javorski wrote:
> > > Thanks for the pointer Chuck
> > >
> > > I ran the trace capture and was able to trigger two freezes in
> > > relatively short order. Here is that trace file:
> > > https://drive.google.com/file/d/1qk_VIMkj8aTeQIg5O0W3AvWyeDSWL3vW/view?usp=sharing
> > >
> >
> > There are gaps of 5.3sec, 4sec, 1sec and 1sec between adjacent trace
> > points.
> > The longest gap between 'start' and 'done' for any given xid is 354msec.
> > So it doesn't look like the filesystem read causing the problem.
> >
> > The long gaps between adjacent records are:
> > 0.354581 xid=0x4c6ac2b6
> > 0.418340 xid=0x6a71c2b6
> > 1.013260 xid=0x6f71c2b6
> > 1.020742 xid=0x0f71c2b6
> > 4.064527 xid=0x6171c2b6
> > 5.396559 xid=0xd66dc2b6
> >
> > The fact 1, 1, and 4 are so close to a precise number of seconds seems
> > unlikely to be a co-incidence.  It isn't clear what it might mean
> > though.
> >
> > I don't have any immediae ideas where to look next.  I'll let you know
> > if I come up with something.
>
> I had separate bug report
>   https://bugzilla.suse.com/show_bug.cgi?id=1189508
> with broadly similar symptoms which strongly points to network-layer
> problem.  So I'm digging back into that tcpdump.
>
> The TCP ACK for READ requests usually goes out in 100 or 200
> microseconds.  Sometimes longer - by a factor of about 100.
>
> % tshark -r /tmp/javmorin-nfsfreeze-5.13.10-cap1\ .test.pcap  -d tcp.port==2049,rpc -Y 'tcp.port==2049 && rpc.msgtyp==0 && nfs.opcode==25' -T fields -e tcp.seq -e frame.time_epoch -e frame.number | sed 's/$/ READ/' > /tmp/read-times
> % tshark -r /tmp/javmorin-nfsfreeze-5.13.10-cap1\ .test.pcap  -d tcp.port==2049,rpc -Y 'tcp.srcport==2049' -T fields -e tcp.ack -e frame.time_epoch -e frame.number | sed 's/$/ ACK/' > /tmp/ack-times
> % sort -n /tmp/read-times /tmp/ack-times  | awk '$4 == "ACK" && readtime {printf "%f %d\n", ($2 - readtime), $3; readtime=0} $4 == "READ" {readtime=$2}' | sort -n | tail -4
> 0.000360 441
> 0.012777 982
> 0.013318 1086
> 0.042356 1776
>
> Three times (out of 245) the TCP ACK was 12 milliseconds or longer.  The
> first and last were times when the reply was delayed by a couple of
> seconds at least.  The other (1086) was the reply to 1085 - no obvious
> delay to the READ reply.
>
> These unusual delays (short though they are) suggest something odd in
> the network layer - particularly as they are sometimes followed by a
> much larger delay in a READ reply.
>
> It might be as simple as a memory allocation delay.  It might be
> something deep in the networking layer.
>
> If you still have (or could generate) some larger tcp dumps, you could
> try that code and see if 5.12 shows any ACK delays, and if 5.13 shows
> more delays than turn into READ delays.  IF 5.13 easily shows a few ACK
> delays thats 5.12 doesn't, then they might make a git-bisect more
> reliable.  Having thousands of READs in the trace rather than just 245
> should produce more reliable data.
>
>
> As I suggested in the bug report I linked above, I am suspicious of TCP
> offload when I see symptoms like this.  You can use "ethtool" to turn
> off that various offload features.  Doing that and trying to reproduce
> without offload might also provide useful information.
>
> NeilBrown
