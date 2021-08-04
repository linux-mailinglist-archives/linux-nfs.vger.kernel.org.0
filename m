Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B36183E0789
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Aug 2021 20:24:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238955AbhHDSZA (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 4 Aug 2021 14:25:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240200AbhHDSY7 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 4 Aug 2021 14:24:59 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 606F2C061799
        for <linux-nfs@vger.kernel.org>; Wed,  4 Aug 2021 11:24:46 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id qk33so5039953ejc.12
        for <linux-nfs@vger.kernel.org>; Wed, 04 Aug 2021 11:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qVWo/4fclFLwXB3UjwdEW0lISO0cTHeXU7JBcF8WCEQ=;
        b=HCbmb4Xg3A/N9kNPnQIGZxNESfCIeQ8wJ/NE4UrwhaNSisglCyO44tfbe0ZpUWhMML
         zDWrSCy3KwujdtSqRDmHlJLqNtKJtyq3TeTDuOe2R/FlFjA/PFezzKSTbxPU9T/CUJAb
         wQOzrwS12tEBXo+tck0SMbPAVlCAv8QBQtPcOi70gHXCMUQvnz9QDEXZaS8x9+Xu8x2g
         0/lDsd3zCsfUcL8PiDdgbWGGosIj4s/KEjIH5u/+cFcVUV8lqxsc847Ho4+QQPL7sSQr
         eslOVpBk/E8EW6P6CIMPXvjYhKRSAwdjFKSQIzWckBRH8mxbY6DlV+goNJnzbViy/xBs
         2New==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qVWo/4fclFLwXB3UjwdEW0lISO0cTHeXU7JBcF8WCEQ=;
        b=oZ5T3VHtToeJs/c7TGfp0zjAvM7aj5UJoCIm1dEivP7qtuWr3o5fjwiIAJqNJTpBhJ
         FdhkykCSUkTsYiykWx+tAAad8Pq4AV7Q2sYMbR5c/9WtyPD1fLCDLycTWqpRW1EdTZm1
         C5BC7r2SPY3pf4oGmZB/QCcc/Uxgq6IxA1iOoWijY1r41d6HW6TQE+992RO5KtQiUQeJ
         2zLnr9VTDnCiSBvS8JVtor6iJmYfqXw26GWA8P2hyYmd1sH8TmvczM8JSl7TOyAJx7Ri
         mbk5YoNTvl5pyAcDR3uHRYC3xNaxXOGr/IhC8bUhsj43ix85IImKvNOGSCiEJEUdCXgA
         rxQQ==
X-Gm-Message-State: AOAM533qEFDa6ILQ4Bak6fq/6jeIbNGpLrP4qiF9nm5KzX+mQ+jV2arH
        y80brPVvo/NPnsNJMO4gEcWDFO62gg5gQsdBU6Y=
X-Google-Smtp-Source: ABdhPJywL8B8eA07eoEhQHwvS3B6sodA7KfNUf9sNMR2+95sYbw6DDicepwNKMkRlepLe4SxoLT37CVYuU5cR2kPO1E=
X-Received: by 2002:a17:906:2bc9:: with SMTP id n9mr506884ejg.23.1628101484877;
 Wed, 04 Aug 2021 11:24:44 -0700 (PDT)
MIME-Version: 1.0
References: <DF3F94B7-F322-4054-952F-90CE02B442FE@redhat.com>
 <ef395e52f3bb8d07dd7a39bb0a6dd6fb64a87a1c.camel@hammerspace.com>
 <20210803203051.GA3043@fieldses.org> <3feb71ab232b26df6d63111ee8226f6bb7e8dc36.camel@hammerspace.com>
 <20210803213642.GA4042@fieldses.org> <CAKOnarkuUpd6waieqvWxJDRpLojwXqbNtAFz_bz6Q2k9Xrskgw@mail.gmail.com>
 <CAKOnarmdHgEBTUc87abMqBM_+3QP4JfdT8M9536WDZg-MGEKzA@mail.gmail.com>
 <61dc5d9363a42ed1a875f68a57c912c1745424d3.camel@hammerspace.com> <423b3a31-c41f-09dd-835d-9e66c4a88d7e@math.utexas.edu>
In-Reply-To: <423b3a31-c41f-09dd-835d-9e66c4a88d7e@math.utexas.edu>
From:   Anna Schumaker <schumaker.anna@gmail.com>
Date:   Wed, 4 Aug 2021 14:24:28 -0400
Message-ID: <CAFX2JfkhqJK6MRFDCzE4VryBJvk1ttYQvrASugncY-_wcEb=+Q@mail.gmail.com>
Subject: Re: cto changes for v4 atomic open
To:     Patrick Goetz <pgoetz@math.utexas.edu>
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        "bfields@fieldses.org" <bfields@fieldses.org>,
        "mbenjami@redhat.com" <mbenjami@redhat.com>,
        "plambri@redhat.com" <plambri@redhat.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "bcodding@redhat.com" <bcodding@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Patrick,

On Wed, Aug 4, 2021 at 2:17 PM Patrick Goetz <pgoetz@math.utexas.edu> wrote:
>
>
>
> On 8/3/21 9:10 PM, Trond Myklebust wrote:
> >
> >
> > On Tue, 2021-08-03 at 21:51 -0400, Matt Benjamin wrote:
> >> (who have performed an open)
> >>
> >> On Tue, Aug 3, 2021 at 9:43 PM Matt Benjamin <mbenjami@redhat.com>
> >> wrote:
> >>>
> >>> I think it is how close-to-open has been traditionally understood.
> >>> I
> >>> do not believe that close-to-open in any way implies a single
> >>> writer,
> >>> rather it sets the consistency expectation for all readers.
> >>>
> >
> > OK. I'll bite, despite the obvious troll-bait...
> >
> >
> > close-to-open implies a single writer because it is impossible to
> > guarantee ordering semantics in RPC. You could, in theory, do so by
> > serialising on the client, but none of us do that because we care about
> > performance.
> >
> > If you don't serialise between clients, then it is trivial (and I'm
> > seriously tired of people who whine about this) to reproduce reads to
> > file areas that have not been fully synced to the server, despite
> > having data on the client that is writing. i.e. the reader sees holes
> > that never existed on the client that wrote the data.
> > The reason is that the writes got re-ordered en route to the server,
> > and so reads to the areas that have not yet been filled are showing up
> > as holes.
> >
> > So, no, the close-to-open semantics definitely apply to both readers
> > and writers.
> >
>
> So, I have a naive question. When a client is writing to cache, why
> wouldn't it be possible to send an alert to the server indicating that
> the file is being changed. The server would keep track of such files
> (client cached, updated) and act accordingly; i.e. sending a request to
> the client to flush the cache for that file if another client is asking
> to open the file? The process could be bookended by the client alerting
> the server when the cached version has been fully synchronized with the
> copy on the server so that the server wouldn't serve that file until the
> synchronization is complete. The only problem I can see with this is the
> client crashing or disconnecting before the file is fully written to the
> server, but then some timeout condition could be set.

We already have this! What you're describing is almost exactly how
delegations work :)

Anna
>
>
>
> >>> Matt
> >>>
> >>> On Tue, Aug 3, 2021 at 5:36 PM bfields@fieldses.org
> >>> <bfields@fieldses.org> wrote:
> >>>>
> >>>> On Tue, Aug 03, 2021 at 09:07:11PM +0000, Trond Myklebust wrote:
> >>>>> On Tue, 2021-08-03 at 16:30 -0400, J. Bruce Fields wrote:
> >>>>>> On Fri, Jul 30, 2021 at 02:48:41PM +0000, Trond Myklebust
> >>>>>> wrote:
> >>>>>>> On Fri, 2021-07-30 at 09:25 -0400, Benjamin Coddington
> >>>>>>> wrote:
> >>>>>>>> I have some folks unhappy about behavior changes after:
> >>>>>>>> 479219218fbe
> >>>>>>>> NFS:
> >>>>>>>> Optimise away the close-to-open GETATTR when we have
> >>>>>>>> NFSv4 OPEN
> >>>>>>>>
> >>>>>>>> Before this change, a client holding a RO open would
> >>>>>>>> invalidate
> >>>>>>>> the
> >>>>>>>> pagecache when doing a second RW open.
> >>>>>>>>
> >>>>>>>> Now the client doesn't invalidate the pagecache, though
> >>>>>>>> technically
> >>>>>>>> it could
> >>>>>>>> because we see a changeattr update on the RW OPEN
> >>>>>>>> response.
> >>>>>>>>
> >>>>>>>> I feel this is a grey area in CTO if we're already
> >>>>>>>> holding an
> >>>>>>>> open.
> >>>>>>>> Do we
> >>>>>>>> know how the client ought to behave in this case?  Should
> >>>>>>>> the
> >>>>>>>> client's open
> >>>>>>>> upgrade to RW invalidate the pagecache?
> >>>>>>>>
> >>>>>>>
> >>>>>>> It's not a "grey area in close-to-open" at all. It is very
> >>>>>>> cut and
> >>>>>>> dried.
> >>>>>>>
> >>>>>>> If you need to invalidate your page cache while the file is
> >>>>>>> open,
> >>>>>>> then
> >>>>>>> by definition you are in a situation where there is a write
> >>>>>>> by
> >>>>>>> another
> >>>>>>> client going on while you are reading. You're clearly not
> >>>>>>> doing
> >>>>>>> close-
> >>>>>>> to-open.
> >>>>>>
> >>>>>> Documentation is really unclear about this case.  Every
> >>>>>> definition of
> >>>>>> close-to-open that I've seen says that it requires a cache
> >>>>>> consistency
> >>>>>> check on every application open.  I've never seen one that
> >>>>>> says "on
> >>>>>> every open that doesn't overlap with an already-existing open
> >>>>>> on that
> >>>>>> client".
> >>>>>>
> >>>>>> They *usually* also preface that by saying that this is
> >>>>>> motivated by
> >>>>>> the
> >>>>>> use case where opens don't overlap.  But it's never made
> >>>>>> clear that
> >>>>>> that's part of the definition.
> >>>>>>
> >>>>>
> >>>>> I'm not following your logic.
> >>>>
> >>>> It's just a question of what every source I can find says close-
> >>>> to-open
> >>>> means.  E.g., NFS Illustrated, p. 248, "Close-to-open consistency
> >>>> provides a guarantee of cache consistency at the level of file
> >>>> opens and
> >>>> closes.  When a file is closed by an application, the client
> >>>> flushes any
> >>>> cached changs to the server.  When a file is opened, the client
> >>>> ignores
> >>>> any cache time remaining (if the file data are cached) and makes
> >>>> an
> >>>> explicit GETATTR call to the server to check the file
> >>>> modification
> >>>> time."
> >>>>
> >>>>> The close-to-open model assumes that the file is only being
> >>>>> modified by
> >>>>> one client at a time and it assumes that file contents may be
> >>>>> cached
> >>>>> while an application is holding it open.
> >>>>> The point checks exist in order to detect if the file is being
> >>>>> changed
> >>>>> when the file is not open.
> >>>>>
> >>>>> Linux does not have a per-application cache. It has a page
> >>>>> cache that
> >>>>> is shared among all applications. It is impossible for two
> >>>>> applications
> >>>>> to open the same file using buffered I/O, and yet see different
> >>>>> contents.
> >>>>
> >>>> Right, so based on the descriptions like the one above, I would
> >>>> have
> >>>> expected both applications to see new data at that point.
> >>>>
> >>>> Maybe that's not practical to implement.  It'd be nice at least
> >>>> if that
> >>>> was explicit in the documentation.
> >>>>
> >>>> --b.
> >>>>
> >>>
> >>>
> >>> --
> >>>
> >>> Matt Benjamin
> >>> Red Hat, Inc.
> >>> 315 West Huron Street, Suite 140A
> >>> Ann Arbor, Michigan 48103
> >>>
> >>> http://www.redhat.com/en/technologies/storage
> >>>
> >>> tel.  734-821-5101
> >>> fax.  734-769-8938
> >>> cel.  734-216-5309
> >>
> >>
> >>
> >
