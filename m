Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5DD24BAA4C
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Feb 2022 20:51:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245541AbiBQTvJ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 17 Feb 2022 14:51:09 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245540AbiBQTvI (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 17 Feb 2022 14:51:08 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 339C612E173
        for <linux-nfs@vger.kernel.org>; Thu, 17 Feb 2022 11:50:53 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id z22so11600002edd.1
        for <linux-nfs@vger.kernel.org>; Thu, 17 Feb 2022 11:50:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dneg.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ALHKgzBDEPr1OKbY+T4VmtKuZn5Su16TIHsYg5/TJxE=;
        b=BHD61sAQbmgAQw5C6aAZ13wI695OTiWthvZ6/28nRx73p7IAiFSttFBpQwOZORb7+c
         XXjmJG6PE+oyA7CFY+aEo9rN7MaKo7xYmdInFo/6MgHwRWKrzUqVVEqElPIywiPxfEn1
         M5gR4j5zOMlG0jFfhmcjBHYduicRmQUNxKRvPKBrl7LkzepdEoeF9TH1WmucLPZht0nA
         fAkbDH4RGmpzFEIyN0DsoR5lEOAnZntZCRG1jQ5IThXZ0u2Z/LYAhiLuIei7XlfAeRgA
         9Q1LJQN07HlI14wZOmcQT31MGEtZQ7bdEZvUOYmMJPpOPCY1AHNisozrW7qE5jJNGyDC
         XRNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ALHKgzBDEPr1OKbY+T4VmtKuZn5Su16TIHsYg5/TJxE=;
        b=UVSHDGRetqbYUWM2CXHduSVPjKLCRoZ+iUZxlc2Rgv8ovSsGFvZ+1BuK3g/AGE1kbL
         Z7y4DHeCh9ua6cETMQ2TecmoFnm9kwJMuujxPijV/VMlzxenjnEcYME7xVlUKe3biuR8
         FYZVX0LqfB6ktr4CILgGtXgxTmCbsHoOpb/ndG6hGsqMjS/B0GCRIFMpUP5HJzBhOgxL
         8ELuZqWclobEvkNaND1RhovLDZspYwWKLqhuXe+IMKwbNFMMNHGA3ZOQ9zBjuxG5UNbd
         zSLeg/4EsrhIKFbMOG3l52Lg04NUQyoWH3cq1woKd5FH39c/+G+IKYT2U3SW4HVGG1nr
         KSNw==
X-Gm-Message-State: AOAM5301vqrCgZ9KlVQrmUzS9yr5/xWH6ZgDspuuFwISiyqet+utUsA0
        JhMQ7++nytApuyotOSli6uSMKFCltDKjm/TyjkHRrfrcWXmzj8c8
X-Google-Smtp-Source: ABdhPJwyewXkGgcR5jVmWCN5Arow0JjWwD0vh/zPB5Up/2AJFiqBTwEOjM7JmaMUbpEMFQPIFO4OBDU9GM5if+ULK00=
X-Received: by 2002:a50:d80a:0:b0:410:f1be:208b with SMTP id
 o10-20020a50d80a000000b00410f1be208bmr4512940edj.386.1645127451734; Thu, 17
 Feb 2022 11:50:51 -0800 (PST)
MIME-Version: 1.0
References: <CAPt2mGOaRsKOiL_wuSK_D5oYYnn0R-pvVsZc5HYGdEbT2FngtQ@mail.gmail.com>
 <20220124193759.GA4975@fieldses.org> <adce2b72-ed5c-3056-313c-caea9bad4e15@math.utexas.edu>
 <20220125212055.GB17638@fieldses.org> <164315533676.5493.13243313269022942124@noble.neil.brown.name>
 <20220126025722.GD17638@fieldses.org> <CAPt2mGP2guMMf1C9VoQ0AvZ819jPuz0vDoEzJJhtL8q5DJ300A@mail.gmail.com>
 <CAPt2mGNXq==1KUskF3U6-CDeoX57=d7NW4Qn_esDqarf9bTBaw@mail.gmail.com> <20220211155949.GA4941@fieldses.org>
In-Reply-To: <20220211155949.GA4941@fieldses.org>
From:   Daire Byrne <daire@dneg.com>
Date:   Thu, 17 Feb 2022 19:50:16 +0000
Message-ID: <CAPt2mGOx0qNTWoY9vmyVBtZ3gxdbv5qQ-2qVbtqWW9FiZFRhEg@mail.gmail.com>
Subject: Re: parallel file create rates (+high latency)
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     NeilBrown <neilb@suse.de>, Patrick Goetz <pgoetz@math.utexas.edu>,
        linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, 11 Feb 2022 at 15:59, J. Bruce Fields <bfields@fieldses.org> wrote:
>
> On Thu, Feb 10, 2022 at 06:19:09PM +0000, Daire Byrne wrote:
> > I had a quick attempt at updating Neil's patch for mainline but I
> > quickly got stuck and confused. It looks like fs/namei.c in particular
> > underwent major changes and refactoring from v5.7+.
> >
> > If there is ever any interest in updating this and getting it into
> > mainline, I'm more than willing to test it with production loads. I
> > just lack the skills to update it myself.
> >
> > It definitely solves a big problem for us, but I also suspect we may
> > be the only ones with this problem.
>
> It benefits anyone trying to do a lot of creates in a on an NFS
> filesystem where the network round trip time is significant.  That
> doesn't seem so weird.  And even if the case is a little weird, just
> having a case and clear numbers to show the improvement is a big help.
>
> I haven't had the chance to read Neil's patch or work out what the issue
> with the namei changes.

As far as I can see, there was a flurry of changes in v5.7 from Al
Viro that changed lots of stuff in namei.c

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/log/fs/namei.c
https://lkml.org/lkml/2020/3/13/1057

> Al Viro is the expert on VFS locking.  I was sure I'd seen him speculate
> about what would be needed to make parallel directory modifications
> possible, but I spent some time mining old mail and didn't find that.

I do recall reading about the work he did for parallel lookups some years back:

https://lwn.net/Articles/685108

> I think the path forward would be to update Neil's patch, add your
> performance data, send it to Al and linux-fsdevel, and see if we can get
> some idea what remains to be done to get this right.

If Neil or anyone else is able to do that work, I'm happy to test and
provide the numbers.

If I could update the patch myself, I would have happily contributed
but I lack the experience or knowledge. I'm great at identifying
problems, but not so hot at solving them :)

Daire


> --b.
>
> >
> > Cheers,
> >
> > Daire
> >
> >
> > On Tue, 8 Feb 2022 at 18:48, Daire Byrne <daire@dneg.com> wrote:
> > >
> > > On Wed, 26 Jan 2022 at 02:57, J. Bruce Fields <bfields@fieldses.org> wrote:
> > > >
> > > > On Wed, Jan 26, 2022 at 11:02:16AM +1100, NeilBrown wrote:
> > > > > On Wed, 26 Jan 2022, J. Bruce Fields wrote:
> > > > > > On Tue, Jan 25, 2022 at 03:15:42PM -0600, Patrick Goetz wrote:
> > > > > > > So the directory is locked while the inode is created, or something
> > > > > > > like this, which makes sense.
> > > > > >
> > > > > > It accomplishes a number of things, details in
> > > > > > https://www.kernel.org/doc/html/latest/filesystems/directory-locking.html
> > > > >
> > > > > Just in case anyone is interested, I wrote this a while back:
> > > > >
> > > > > http://lists.lustre.org/pipermail/lustre-devel-lustre.org/2018-November/008177.html
> > > > >
> > > > > it includes a patch to allow parallel creates/deletes over NFS (and any
> > > > > other filesystem which adds support).
> > > > > I doubt it still applies, but it wouldn't be hard to make it work if
> > > > > anyone was willing to make a strong case that we would benefit from
> > > > > this.
> > >
> > > Well, I couldn't resist quickly testing Neil's patch. I found it
> > > applied okay to v5.6.19 with minimal edits.
> > >
> > > As before, without the patch, parallel file creates in a single
> > > directory with 1000 threads topped out at an aggregate of 3 creates/s
> > > over a 200ms link. With the patch it jumps up to 1,200 creates/s.
> > >
> > > So a pretty dramatic difference. I can't say if there are any other
> > > side effects or regressions as I only did this simple test.
> > >
> > > It's great for our super niche workloads and use case anyway.
> > >
> > > Daire
> > >
> > >
> > > > Neato.
> > > >
> > > > Removing the need to hold an exclusive lock on the directory across
> > > > server round trips seems compelling to me....
> > > >
> > > > I also wonder: why couldn't you fire off the RPC without any locks, then
> > > > wait till you get a reply to take locks and update your local cache?
> > > >
> > > > OK, for one thing, calls and replies and server processing could all get
> > > > reordered.  We'd need to know what order the server processed operations
> > > > in, so we could process replies in the same order.
> > > >
> > > > --b.
