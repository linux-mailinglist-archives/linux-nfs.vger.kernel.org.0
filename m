Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3C173DF966
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Aug 2021 03:51:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232614AbhHDBwH (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 3 Aug 2021 21:52:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:50313 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229820AbhHDBwG (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 3 Aug 2021 21:52:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628041914;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QMOyIm2/FnwNk3XWPIbzVDeXJuZl1E+7tGjjE8d/KBs=;
        b=EjdVU4CESWbRhgFv/RCDcyq0JXtP+Dc0S9zdm+PW4lnLNfZa95sJi5cmo+YeCL6rLTG8Dc
        bByyg5g4DzDiqIzqMu3X5IpgOhpeAYrUZbH57jTXkfwsOb+sVrCqh2M6r+sYr+9bzfguij
        kdC2zEcTmOYYebLpBKLtRNZXmmQJhm8=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-492-wmsxnXE8NJSi143SfW1ueA-1; Tue, 03 Aug 2021 21:51:53 -0400
X-MC-Unique: wmsxnXE8NJSi143SfW1ueA-1
Received: by mail-ed1-f72.google.com with SMTP id ay20-20020a0564022034b02903bc515b673dso642006edb.3
        for <linux-nfs@vger.kernel.org>; Tue, 03 Aug 2021 18:51:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QMOyIm2/FnwNk3XWPIbzVDeXJuZl1E+7tGjjE8d/KBs=;
        b=k+5EKWIk1py6mkL1HFrDCl4UxWvOAdZaj1k+zT5smmpo1fabnBAqKd1nQdTzmS9Idy
         ufMfWsGynHBCKBIu6C56tRHa55JgivcD7kV3eMurWVN1GUITS+8PF6W2DxiNKa6VsV4Z
         KdusUSNaFj7mJqB4iFWt78XrGtnaS5i2CGSiVb+sQxfcDG8EFQNZQgyBqdvZ06k4nw0i
         kZj95gfsnllfUoNiuMhoOoPyD4PdgqtGYYSRpP2Zn2SZ5SmRm2WIOBxgfbqUj2lpmgJK
         MCv9qHAkqHNHqcakhJpFn0Kkosq8abEgVaSXLIECMPTCbRQTMcv0tN9KE4gE1pIoL+j5
         6v/g==
X-Gm-Message-State: AOAM5337z2uJBwXlZH7jVXObA649kVMJ88PWfld1AFZi4Tw/Asj0BmjF
        rYTI8yu3HpUCQAko/o/J3855K5Naqx8om4Dmf6i9VhyZBARTzyS84frTRblSR/qUZCci9A6VBrq
        g3eQv29p1Z09qkbC5v6aywwa5ArCCGsi/S6Yw
X-Received: by 2002:a17:906:c252:: with SMTP id bl18mr23643103ejb.519.1628041910780;
        Tue, 03 Aug 2021 18:51:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyyqDNN9DORkbMbp6t1mLcU1KxTlVCO1UfLhk0/So8bLQzh3lyoEvmzk9YkNwlNTbU/iqbnUKU0SJUNJaOckDE=
X-Received: by 2002:a17:906:c252:: with SMTP id bl18mr23643089ejb.519.1628041910613;
 Tue, 03 Aug 2021 18:51:50 -0700 (PDT)
MIME-Version: 1.0
References: <DF3F94B7-F322-4054-952F-90CE02B442FE@redhat.com>
 <ef395e52f3bb8d07dd7a39bb0a6dd6fb64a87a1c.camel@hammerspace.com>
 <20210803203051.GA3043@fieldses.org> <3feb71ab232b26df6d63111ee8226f6bb7e8dc36.camel@hammerspace.com>
 <20210803213642.GA4042@fieldses.org> <CAKOnarkuUpd6waieqvWxJDRpLojwXqbNtAFz_bz6Q2k9Xrskgw@mail.gmail.com>
In-Reply-To: <CAKOnarkuUpd6waieqvWxJDRpLojwXqbNtAFz_bz6Q2k9Xrskgw@mail.gmail.com>
From:   Matt Benjamin <mbenjami@redhat.com>
Date:   Tue, 3 Aug 2021 21:51:39 -0400
Message-ID: <CAKOnarmdHgEBTUc87abMqBM_+3QP4JfdT8M9536WDZg-MGEKzA@mail.gmail.com>
Subject: Re: cto changes for v4 atomic open
To:     "bfields@fieldses.org" <bfields@fieldses.org>
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        "plambri@redhat.com" <plambri@redhat.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "bcodding@redhat.com" <bcodding@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

(who have performed an open)

On Tue, Aug 3, 2021 at 9:43 PM Matt Benjamin <mbenjami@redhat.com> wrote:
>
> I think it is how close-to-open has been traditionally understood.  I
> do not believe that close-to-open in any way implies a single writer,
> rather it sets the consistency expectation for all readers.
>
> Matt
>
> On Tue, Aug 3, 2021 at 5:36 PM bfields@fieldses.org
> <bfields@fieldses.org> wrote:
> >
> > On Tue, Aug 03, 2021 at 09:07:11PM +0000, Trond Myklebust wrote:
> > > On Tue, 2021-08-03 at 16:30 -0400, J. Bruce Fields wrote:
> > > > On Fri, Jul 30, 2021 at 02:48:41PM +0000, Trond Myklebust wrote:
> > > > > On Fri, 2021-07-30 at 09:25 -0400, Benjamin Coddington wrote:
> > > > > > I have some folks unhappy about behavior changes after:
> > > > > > 479219218fbe
> > > > > > NFS:
> > > > > > Optimise away the close-to-open GETATTR when we have NFSv4 OPEN
> > > > > >
> > > > > > Before this change, a client holding a RO open would invalidate
> > > > > > the
> > > > > > pagecache when doing a second RW open.
> > > > > >
> > > > > > Now the client doesn't invalidate the pagecache, though
> > > > > > technically
> > > > > > it could
> > > > > > because we see a changeattr update on the RW OPEN response.
> > > > > >
> > > > > > I feel this is a grey area in CTO if we're already holding an
> > > > > > open.
> > > > > > Do we
> > > > > > know how the client ought to behave in this case?  Should the
> > > > > > client's open
> > > > > > upgrade to RW invalidate the pagecache?
> > > > > >
> > > > >
> > > > > It's not a "grey area in close-to-open" at all. It is very cut and
> > > > > dried.
> > > > >
> > > > > If you need to invalidate your page cache while the file is open,
> > > > > then
> > > > > by definition you are in a situation where there is a write by
> > > > > another
> > > > > client going on while you are reading. You're clearly not doing
> > > > > close-
> > > > > to-open.
> > > >
> > > > Documentation is really unclear about this case.  Every definition of
> > > > close-to-open that I've seen says that it requires a cache
> > > > consistency
> > > > check on every application open.  I've never seen one that says "on
> > > > every open that doesn't overlap with an already-existing open on that
> > > > client".
> > > >
> > > > They *usually* also preface that by saying that this is motivated by
> > > > the
> > > > use case where opens don't overlap.  But it's never made clear that
> > > > that's part of the definition.
> > > >
> > >
> > > I'm not following your logic.
> >
> > It's just a question of what every source I can find says close-to-open
> > means.  E.g., NFS Illustrated, p. 248, "Close-to-open consistency
> > provides a guarantee of cache consistency at the level of file opens and
> > closes.  When a file is closed by an application, the client flushes any
> > cached changs to the server.  When a file is opened, the client ignores
> > any cache time remaining (if the file data are cached) and makes an
> > explicit GETATTR call to the server to check the file modification
> > time."
> >
> > > The close-to-open model assumes that the file is only being modified by
> > > one client at a time and it assumes that file contents may be cached
> > > while an application is holding it open.
> > > The point checks exist in order to detect if the file is being changed
> > > when the file is not open.
> > >
> > > Linux does not have a per-application cache. It has a page cache that
> > > is shared among all applications. It is impossible for two applications
> > > to open the same file using buffered I/O, and yet see different
> > > contents.
> >
> > Right, so based on the descriptions like the one above, I would have
> > expected both applications to see new data at that point.
> >
> > Maybe that's not practical to implement.  It'd be nice at least if that
> > was explicit in the documentation.
> >
> > --b.
> >
>
>
> --
>
> Matt Benjamin
> Red Hat, Inc.
> 315 West Huron Street, Suite 140A
> Ann Arbor, Michigan 48103
>
> http://www.redhat.com/en/technologies/storage
>
> tel.  734-821-5101
> fax.  734-769-8938
> cel.  734-216-5309



-- 

Matt Benjamin
Red Hat, Inc.
315 West Huron Street, Suite 140A
Ann Arbor, Michigan 48103

http://www.redhat.com/en/technologies/storage

tel.  734-821-5101
fax.  734-769-8938
cel.  734-216-5309

