Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DEF549B466
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Jan 2022 13:56:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573990AbiAYMz5 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 25 Jan 2022 07:55:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1572886AbiAYMxY (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 25 Jan 2022 07:53:24 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 555EAC06173B
        for <linux-nfs@vger.kernel.org>; Tue, 25 Jan 2022 04:53:23 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id p15so30645021ejc.7
        for <linux-nfs@vger.kernel.org>; Tue, 25 Jan 2022 04:53:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dneg.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kTSX2hxobaHpNlwVI1LvJAXu5tPTWRXyQli2T5iOAZ8=;
        b=UALi4SBIOF7d6ijMg/gqg1z9RaMVqcbKu/uEmAw1+pDCIGhUSNynIUUgNpqj0rT6Qt
         sSyYgw9CrV0sUt64GXvljviqWwpeA7PzqReSnw+kwAnXgSXoqfGAjQQFmmRzP9YEJMKh
         D8boTEMh5iFkyL30nDP3inAtDmd5rr8o0cMNy6s1+7c/e4YWyBRMoYeu0x8aNArISkNS
         EbcV0fq1I3mVIePnTWJIv0vLRl49X6UACoH9znnemx2R1BzeGwe6b90Zh0D8Lh/ZQAjF
         NJtRQvsoArzqd0mlXeu/JCD0H9Fv4WppJ3G5D1BJtf4AflDP1BlzAdree4F8hB6Uh/1e
         wSrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kTSX2hxobaHpNlwVI1LvJAXu5tPTWRXyQli2T5iOAZ8=;
        b=3jgSgVXnGl6XpwCNJ9AXlstvt/HQr4eqyRJ4J52kAi/2mp/oAs4YoKA/zuJ6bvr5k/
         EO0rvN8h3BUAyVLQlrtOl9sMNO3zvKHn6o4JAUDlI22J6tZ9PFqCK1XcS/p4OKPRsIs6
         +VzaRd6OTN+gTP82MtusPtuflanNfCrE2hoFpe5/++vSRXejgUjmIZ06CkGIzPkC3doA
         Z6iJY/Q6bACA6BbP8hgvfR2vK1s0rVmmkmDKHSLOi/KacERbTsiv8M2sd5d8rI4ULAME
         BPqPvS1aOZMufHAqqGFPFHpQ/O6nrbsvSQJxXRIjc8piI0gO1NvDJFa2x7LB6qKCSSyQ
         gqHQ==
X-Gm-Message-State: AOAM532yKh0qOsUL7wm5QOn7cN2BmW5DHuqoY45HWuC31jMPaHGp9hND
        if+/hXtdZtg1TrlZYLPRnRMic6/nTU4mIiCbJJA1Uciz+Ec9Xw==
X-Google-Smtp-Source: ABdhPJyfEjlH/I6exg8itdfpy/1Hza0HFNczoWA9SxQPhOdguD4n7dLd8VY9Pbgi9VNuNkibgKok6NeoMDifnSGIUv8=
X-Received: by 2002:a17:906:1dc6:: with SMTP id v6mr16165668ejh.142.1643115201839;
 Tue, 25 Jan 2022 04:53:21 -0800 (PST)
MIME-Version: 1.0
References: <CAPt2mGOaRsKOiL_wuSK_D5oYYnn0R-pvVsZc5HYGdEbT2FngtQ@mail.gmail.com>
 <20220124193759.GA4975@fieldses.org> <CAPt2mGOCn5OaeZm24+zh92qRcWTF8h-H2WXqScz9RMfo4r_-Qw@mail.gmail.com>
 <20220124205045.GB4975@fieldses.org>
In-Reply-To: <20220124205045.GB4975@fieldses.org>
From:   Daire Byrne <daire@dneg.com>
Date:   Tue, 25 Jan 2022 12:52:46 +0000
Message-ID: <CAPt2mGPTGgXztawDJfAKsiYqnm6P_mn1rtquSDKjpnSgvJH1YA@mail.gmail.com>
Subject: Re: parallel file create rates (+high latency)
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, 24 Jan 2022 at 20:50, J. Bruce Fields <bfields@fieldses.org> wrote:
>
> On Mon, Jan 24, 2022 at 08:10:07PM +0000, Daire Byrne wrote:
> > On Mon, 24 Jan 2022 at 19:38, J. Bruce Fields <bfields@fieldses.org> wrote:
> > >
> > > On Sun, Jan 23, 2022 at 11:53:08PM +0000, Daire Byrne wrote:
> > > > I've been experimenting a bit more with high latency NFSv4.2 (200ms).
> > > > I've noticed a difference between the file creation rates when you
> > > > have parallel processes running against a single client mount creating
> > > > files in multiple directories compared to in one shared directory.
> > >
> > > The Linux VFS requires an exclusive lock on the directory while you're
> > > creating a file.
> >
> > Right. So when I mounted the same server/dir multiple times using
> > namespaces, all I was really doing was making the VFS *think* I wanted
> > locks on different directories even though the remote server directory
> > was actually the same?
>
> In that scenario the client-side locks are probably all different, but
> they'd all have to wait for the same lock on the server side, yes.

Yea, I was totally overthinking the problem. Thanks for setting me straight.

> > > So, if L is the time in seconds required to create a single file, you're
> > > never going to be able to create more than 1/L files per second, because
> > > there's no parallelism.
> >
> > And things like directory delegations can't help with this kind of
> > workload? You can't batch directories locks or file creates I guess.
>
> Alas, there are directory delegations specified in RFC 8881, but they
> are read-only, and nobody's implemented them.
>
> Directory write delegations could help a lot, if they existed.

Shame. And tackling that problem is way past my ability.

> > > So, it's not surprising you'd get a higher rate when creating in
> > > multiple directories.
> > >
> > > Also, that lock's taken on both client and server.  So it makes sense
> > > that you might get a little more parallelism from multiple clients.
> > >
> > > So the usual advice is just to try to get that latency number as low as
> > > possible, by using a low-latency network and storage that can commit
> > > very quickly.  (An NFS server isn't permitted to reply to the RPC
> > > creating the new file until the new file actually hits stable storage.)
> > >
> > > Are you really seeing 200ms in production?
> >
> > Yea, it's just a (crazy) test for now. This is the latency between two
> > of our offices. Running batch jobs over this kind of latency with a
> > NFS re-export server doing all the caching works surprisingly well.
> >
> > It's just these file creations that's the deal breaker. A batch job
> > might create 100,000+ files in a single directory across many clients.
> >
> > Maybe many containerised re-export servers in round-robin with a
> > common cache is the only way to get more directory locks and file
> > creates in flight at the same time.
>
> ssh into the original server and crate the files there?

That might work. Perhaps we can figure out the expected file outputs
and make that a local LAN task that runs first.

Actually, I can probably make it better by having each batch process
(client's of the re-export server) create their output files in a
unique directories rather than have all the files in one big shared
directory. There is still the slow creation of all those subdirs but
it's an order of magnitude less creates in one directory. Then the
files created across the subdirs can be paralellised on the wire.

> I've got no help, sorry.
>
> The client-side locking does seem redundant to some degree, but I don't
> know what to do about it.

Yea, it does seem like the server is the ultimate arbitrar and the
fact that multiple clients can achieve much higher rates of
parallelism does suggest that the VFS locking per client is somewhat
redundant and limiting (in this super niche case).

I can have multiple round-robin re-export servers but then they all
have to fetch the same data multiple times.

I'll read up on containerised NFS but it's not clear that you could
ever have a shared pagecache or fscache across multiple instances of
re-exports on the same server. Similar for Neil's "namespaces" patch I
think.

Thanks again for your help (and patience).

Daire
