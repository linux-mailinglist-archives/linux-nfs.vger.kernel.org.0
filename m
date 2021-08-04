Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 919513E07AC
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Aug 2021 20:33:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240304AbhHDSeK (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 4 Aug 2021 14:34:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21868 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240294AbhHDSeJ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 4 Aug 2021 14:34:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628102036;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QEBLsbKgSrjJ/YTMpuvuE6JQd+M98HJUIad4eASsJvU=;
        b=D9BT3riZhSyP6TvrV4rJXkQp7RbxVrs7DKiYoAM4IL/wLNazIpGe8Zne9XJ+TCnjlkluIY
        8ZRB+siHXyr02azxrbB+snX+S8jyrqmmToxtRhSDmgW+EoF66dWgKp6i2fdQOSJtSyzIkP
        gCrHS8xrtq1QkiilLqsrTXSgKMY7uZU=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-517-g8dlXhODONiFW71eYGFTPA-1; Wed, 04 Aug 2021 14:33:55 -0400
X-MC-Unique: g8dlXhODONiFW71eYGFTPA-1
Received: by mail-ed1-f70.google.com with SMTP id c1-20020aa7df010000b02903bb5c6f746eso1881708edy.10
        for <linux-nfs@vger.kernel.org>; Wed, 04 Aug 2021 11:33:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QEBLsbKgSrjJ/YTMpuvuE6JQd+M98HJUIad4eASsJvU=;
        b=W5m0/5KDzmcVX8YTsv/tywO+3jIx7IqZuEBqj8GhXGuxpJuQgAQsw+cDmv67RpChsf
         3MOFT6wFAbINJKF+hwZc0olJHZ0l/KF/lVcukHaP1GPSrcHbrwDhZkFJI7KuVU8aoCTV
         OMd6rigwlDL6TVrRXw78jahsb1Hiz8IqOQzwYmZuGvSjMikBehraLufzXz6qQC8A2WaN
         zjt6PEctn6OeET4Ibdfwcc0Sc4VcfkzSgxGLr7dm37Gxk6/PhSKjTStau23Z9BQKVkVp
         zyj+w22ZsTJbXUq3CUN3X1mMpGqHQ0POcYIEHV4HpIqhN3AIKiCcDb/wJWOrPIs6KsoV
         sE/A==
X-Gm-Message-State: AOAM532CLzteAsrcxlEjsNsmExCoNfo5Su9AthgXXCNNksOX4IS1LEAx
        Dnjce+L9nLqQqxki9bkURYpVw6wwZVlZ+2rLSxDxPbv0MFrsTHCiq7GWZAi9/bQDtBMS8StCuC8
        rGxFjCsvAftwQE5MlpyrL+YJty7CEpvCazT6n
X-Received: by 2002:a05:6402:1a35:: with SMTP id be21mr1293723edb.332.1628102032856;
        Wed, 04 Aug 2021 11:33:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxceqItohmv/6ZlLDcFgBHATRl0bdYL/LLjiJwVX7qGrHvT0uDwktAqRITlgYZy4ZBTpIbB/EQ/GwVn1cp++ww=
X-Received: by 2002:a05:6402:1a35:: with SMTP id be21mr1293705edb.332.1628102032644;
 Wed, 04 Aug 2021 11:33:52 -0700 (PDT)
MIME-Version: 1.0
References: <DF3F94B7-F322-4054-952F-90CE02B442FE@redhat.com>
 <ef395e52f3bb8d07dd7a39bb0a6dd6fb64a87a1c.camel@hammerspace.com>
 <20210803203051.GA3043@fieldses.org> <3feb71ab232b26df6d63111ee8226f6bb7e8dc36.camel@hammerspace.com>
 <20210803213642.GA4042@fieldses.org> <CAKOnarkuUpd6waieqvWxJDRpLojwXqbNtAFz_bz6Q2k9Xrskgw@mail.gmail.com>
 <CAKOnarmdHgEBTUc87abMqBM_+3QP4JfdT8M9536WDZg-MGEKzA@mail.gmail.com> <61dc5d9363a42ed1a875f68a57c912c1745424d3.camel@hammerspace.com>
In-Reply-To: <61dc5d9363a42ed1a875f68a57c912c1745424d3.camel@hammerspace.com>
From:   Matt Benjamin <mbenjami@redhat.com>
Date:   Wed, 4 Aug 2021 14:33:43 -0400
Message-ID: <CAKOnarmTiLaVA9ExOJ3q-96o9pg_Z-6tzyFkoBzY2WKvFAWu-g@mail.gmail.com>
Subject: Re: cto changes for v4 atomic open
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "bfields@fieldses.org" <bfields@fieldses.org>,
        "plambri@redhat.com" <plambri@redhat.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "bcodding@redhat.com" <bcodding@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

That was not intended as a troll, and I don't see why you would assume that.

Of course, what you're saying is correct, multiple writers are not
effectively synchronized by close-to-open, and I wasn't implying they
should be.  Another 3rd (...) writer operating on the file is still
relevant to the consumers, regardless of whether they can achieve a
uniform view of the data.

Matt

On Tue, Aug 3, 2021 at 10:11 PM Trond Myklebust <trondmy@hammerspace.com> wrote:
>
>
>
> On Tue, 2021-08-03 at 21:51 -0400, Matt Benjamin wrote:
> > (who have performed an open)
> >
> > On Tue, Aug 3, 2021 at 9:43 PM Matt Benjamin <mbenjami@redhat.com>
> > wrote:
> > >
> > > I think it is how close-to-open has been traditionally understood.
> > > I
> > > do not believe that close-to-open in any way implies a single
> > > writer,
> > > rather it sets the consistency expectation for all readers.
> > >
>
> OK. I'll bite, despite the obvious troll-bait...
>
>
> close-to-open implies a single writer because it is impossible to
> guarantee ordering semantics in RPC. You could, in theory, do so by
> serialising on the client, but none of us do that because we care about
> performance.
>
> If you don't serialise between clients, then it is trivial (and I'm
> seriously tired of people who whine about this) to reproduce reads to
> file areas that have not been fully synced to the server, despite
> having data on the client that is writing. i.e. the reader sees holes
> that never existed on the client that wrote the data.
> The reason is that the writes got re-ordered en route to the server,
> and so reads to the areas that have not yet been filled are showing up
> as holes.
>
> So, no, the close-to-open semantics definitely apply to both readers
> and writers.
>
> > > Matt
> > >
> > > On Tue, Aug 3, 2021 at 5:36 PM bfields@fieldses.org
> > > <bfields@fieldses.org> wrote:
> > > >
> > > > On Tue, Aug 03, 2021 at 09:07:11PM +0000, Trond Myklebust wrote:
> > > > > On Tue, 2021-08-03 at 16:30 -0400, J. Bruce Fields wrote:
> > > > > > On Fri, Jul 30, 2021 at 02:48:41PM +0000, Trond Myklebust
> > > > > > wrote:
> > > > > > > On Fri, 2021-07-30 at 09:25 -0400, Benjamin Coddington
> > > > > > > wrote:
> > > > > > > > I have some folks unhappy about behavior changes after:
> > > > > > > > 479219218fbe
> > > > > > > > NFS:
> > > > > > > > Optimise away the close-to-open GETATTR when we have
> > > > > > > > NFSv4 OPEN
> > > > > > > >
> > > > > > > > Before this change, a client holding a RO open would
> > > > > > > > invalidate
> > > > > > > > the
> > > > > > > > pagecache when doing a second RW open.
> > > > > > > >
> > > > > > > > Now the client doesn't invalidate the pagecache, though
> > > > > > > > technically
> > > > > > > > it could
> > > > > > > > because we see a changeattr update on the RW OPEN
> > > > > > > > response.
> > > > > > > >
> > > > > > > > I feel this is a grey area in CTO if we're already
> > > > > > > > holding an
> > > > > > > > open.
> > > > > > > > Do we
> > > > > > > > know how the client ought to behave in this case?  Should
> > > > > > > > the
> > > > > > > > client's open
> > > > > > > > upgrade to RW invalidate the pagecache?
> > > > > > > >
> > > > > > >
> > > > > > > It's not a "grey area in close-to-open" at all. It is very
> > > > > > > cut and
> > > > > > > dried.
> > > > > > >
> > > > > > > If you need to invalidate your page cache while the file is
> > > > > > > open,
> > > > > > > then
> > > > > > > by definition you are in a situation where there is a write
> > > > > > > by
> > > > > > > another
> > > > > > > client going on while you are reading. You're clearly not
> > > > > > > doing
> > > > > > > close-
> > > > > > > to-open.
> > > > > >
> > > > > > Documentation is really unclear about this case.  Every
> > > > > > definition of
> > > > > > close-to-open that I've seen says that it requires a cache
> > > > > > consistency
> > > > > > check on every application open.  I've never seen one that
> > > > > > says "on
> > > > > > every open that doesn't overlap with an already-existing open
> > > > > > on that
> > > > > > client".
> > > > > >
> > > > > > They *usually* also preface that by saying that this is
> > > > > > motivated by
> > > > > > the
> > > > > > use case where opens don't overlap.  But it's never made
> > > > > > clear that
> > > > > > that's part of the definition.
> > > > > >
> > > > >
> > > > > I'm not following your logic.
> > > >
> > > > It's just a question of what every source I can find says close-
> > > > to-open
> > > > means.  E.g., NFS Illustrated, p. 248, "Close-to-open consistency
> > > > provides a guarantee of cache consistency at the level of file
> > > > opens and
> > > > closes.  When a file is closed by an application, the client
> > > > flushes any
> > > > cached changs to the server.  When a file is opened, the client
> > > > ignores
> > > > any cache time remaining (if the file data are cached) and makes
> > > > an
> > > > explicit GETATTR call to the server to check the file
> > > > modification
> > > > time."
> > > >
> > > > > The close-to-open model assumes that the file is only being
> > > > > modified by
> > > > > one client at a time and it assumes that file contents may be
> > > > > cached
> > > > > while an application is holding it open.
> > > > > The point checks exist in order to detect if the file is being
> > > > > changed
> > > > > when the file is not open.
> > > > >
> > > > > Linux does not have a per-application cache. It has a page
> > > > > cache that
> > > > > is shared among all applications. It is impossible for two
> > > > > applications
> > > > > to open the same file using buffered I/O, and yet see different
> > > > > contents.
> > > >
> > > > Right, so based on the descriptions like the one above, I would
> > > > have
> > > > expected both applications to see new data at that point.
> > > >
> > > > Maybe that's not practical to implement.  It'd be nice at least
> > > > if that
> > > > was explicit in the documentation.
> > > >
> > > > --b.
> > > >
> > >
> > >
> > > --
> > >
> > > Matt Benjamin
> > > Red Hat, Inc.
> > > 315 West Huron Street, Suite 140A
> > > Ann Arbor, Michigan 48103
> > >
> > > http://www.redhat.com/en/technologies/storage
> > >
> > > tel.  734-821-5101
> > > fax.  734-769-8938
> > > cel.  734-216-5309
> >
> >
> >
>
> --
> Trond Myklebust
> Linux NFS client maintainer, Hammerspace
> trond.myklebust@hammerspace.com
>
>


-- 

Matt Benjamin
Red Hat, Inc.
315 West Huron Street, Suite 140A
Ann Arbor, Michigan 48103

http://www.redhat.com/en/technologies/storage

tel.  734-821-5101
fax.  734-769-8938
cel.  734-216-5309

