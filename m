Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE2E63DF958
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Aug 2021 03:43:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230060AbhHDBno (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 3 Aug 2021 21:43:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:55853 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229833AbhHDBnn (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 3 Aug 2021 21:43:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628041411;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HFpXDj+yApXL8l0Q/SB1ZP2Eb036P1qJIZ6Lo091bx0=;
        b=fvuhnegjMLzubLj0Dh94klh9wRH/4mWbtqWCVL3nxVrnPGzo5l7s6eman0Oj5v9QvESnlz
        F3c+6hPbru9WaZGEx/eOG/zcxnzTzX1N9JJkd2sgQx7qqWIwYshG3gwExkeDSM3MS4Xk4i
        H7AYCRCJM3k9TbgfejsRV0sePoXKWQE=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-585-GHR1HPNgOP-hfo0RNLRDwA-1; Tue, 03 Aug 2021 21:43:29 -0400
X-MC-Unique: GHR1HPNgOP-hfo0RNLRDwA-1
Received: by mail-ej1-f70.google.com with SMTP id q19-20020a170906b293b029058a1e75c819so287630ejz.16
        for <linux-nfs@vger.kernel.org>; Tue, 03 Aug 2021 18:43:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HFpXDj+yApXL8l0Q/SB1ZP2Eb036P1qJIZ6Lo091bx0=;
        b=Bi6p4JQYz3GUonTiFkOGmQX+hcJQtSccdQ1wcDah6jNscK8D0hJ5TKPLP8GSv0DC5U
         L/1t9Pc4OTqKsw2eGNbOlCLFRIL2IPEfKdXh39YzHPQe4TMgNH9pEzhphtASMyRzZC+6
         hjTr2odr6Sl8OHRghiQaiGLgLFGU2QhqOjp+zSVMs70TUC8SFRtO0hSpTcOwhvV9BupV
         aL/Qy6CrQ2qIPqij551oFxs2nCqGTmxraqkRNKn2q9+v4BukQBxL6JU0b93fKWf3iffW
         RzelHCW8xVnFPuk44wYna3W8SvBlmIjaSLqMIrr5xwBp/QZt7CH9hNkCnHogehTJzzTV
         JQ+w==
X-Gm-Message-State: AOAM532ZDK44sIweNa70gZiPC3CPEcJQAhpvQETZCA0PAom6oOGrC+B+
        W2hQOqvXMGyVw4OUhzWKZ9AuQSLrOrC2I8iBeqf3rx8QpkeB3mNvJuWcjQbJPzo9wWtr1Ib6Xfz
        ZBwrauY/ElMWap+g/ZcnupKACJLTBhCfyeBfU
X-Received: by 2002:a17:906:48c5:: with SMTP id d5mr23642989ejt.553.1628041407867;
        Tue, 03 Aug 2021 18:43:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxcBglQjj4AoR7v1I2/ZpD1vsUJxfuRBiz3BZWUTWlBL3PKag/edQtw2UquMkhJCCvCYqFULiUXMBZh6JnKxCU=
X-Received: by 2002:a17:906:48c5:: with SMTP id d5mr23642982ejt.553.1628041407665;
 Tue, 03 Aug 2021 18:43:27 -0700 (PDT)
MIME-Version: 1.0
References: <DF3F94B7-F322-4054-952F-90CE02B442FE@redhat.com>
 <ef395e52f3bb8d07dd7a39bb0a6dd6fb64a87a1c.camel@hammerspace.com>
 <20210803203051.GA3043@fieldses.org> <3feb71ab232b26df6d63111ee8226f6bb7e8dc36.camel@hammerspace.com>
 <20210803213642.GA4042@fieldses.org>
In-Reply-To: <20210803213642.GA4042@fieldses.org>
From:   Matt Benjamin <mbenjami@redhat.com>
Date:   Tue, 3 Aug 2021 21:43:17 -0400
Message-ID: <CAKOnarkuUpd6waieqvWxJDRpLojwXqbNtAFz_bz6Q2k9Xrskgw@mail.gmail.com>
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

I think it is how close-to-open has been traditionally understood.  I
do not believe that close-to-open in any way implies a single writer,
rather it sets the consistency expectation for all readers.

Matt

On Tue, Aug 3, 2021 at 5:36 PM bfields@fieldses.org
<bfields@fieldses.org> wrote:
>
> On Tue, Aug 03, 2021 at 09:07:11PM +0000, Trond Myklebust wrote:
> > On Tue, 2021-08-03 at 16:30 -0400, J. Bruce Fields wrote:
> > > On Fri, Jul 30, 2021 at 02:48:41PM +0000, Trond Myklebust wrote:
> > > > On Fri, 2021-07-30 at 09:25 -0400, Benjamin Coddington wrote:
> > > > > I have some folks unhappy about behavior changes after:
> > > > > 479219218fbe
> > > > > NFS:
> > > > > Optimise away the close-to-open GETATTR when we have NFSv4 OPEN
> > > > >
> > > > > Before this change, a client holding a RO open would invalidate
> > > > > the
> > > > > pagecache when doing a second RW open.
> > > > >
> > > > > Now the client doesn't invalidate the pagecache, though
> > > > > technically
> > > > > it could
> > > > > because we see a changeattr update on the RW OPEN response.
> > > > >
> > > > > I feel this is a grey area in CTO if we're already holding an
> > > > > open.
> > > > > Do we
> > > > > know how the client ought to behave in this case?  Should the
> > > > > client's open
> > > > > upgrade to RW invalidate the pagecache?
> > > > >
> > > >
> > > > It's not a "grey area in close-to-open" at all. It is very cut and
> > > > dried.
> > > >
> > > > If you need to invalidate your page cache while the file is open,
> > > > then
> > > > by definition you are in a situation where there is a write by
> > > > another
> > > > client going on while you are reading. You're clearly not doing
> > > > close-
> > > > to-open.
> > >
> > > Documentation is really unclear about this case.  Every definition of
> > > close-to-open that I've seen says that it requires a cache
> > > consistency
> > > check on every application open.  I've never seen one that says "on
> > > every open that doesn't overlap with an already-existing open on that
> > > client".
> > >
> > > They *usually* also preface that by saying that this is motivated by
> > > the
> > > use case where opens don't overlap.  But it's never made clear that
> > > that's part of the definition.
> > >
> >
> > I'm not following your logic.
>
> It's just a question of what every source I can find says close-to-open
> means.  E.g., NFS Illustrated, p. 248, "Close-to-open consistency
> provides a guarantee of cache consistency at the level of file opens and
> closes.  When a file is closed by an application, the client flushes any
> cached changs to the server.  When a file is opened, the client ignores
> any cache time remaining (if the file data are cached) and makes an
> explicit GETATTR call to the server to check the file modification
> time."
>
> > The close-to-open model assumes that the file is only being modified by
> > one client at a time and it assumes that file contents may be cached
> > while an application is holding it open.
> > The point checks exist in order to detect if the file is being changed
> > when the file is not open.
> >
> > Linux does not have a per-application cache. It has a page cache that
> > is shared among all applications. It is impossible for two applications
> > to open the same file using buffered I/O, and yet see different
> > contents.
>
> Right, so based on the descriptions like the one above, I would have
> expected both applications to see new data at that point.
>
> Maybe that's not practical to implement.  It'd be nice at least if that
> was explicit in the documentation.
>
> --b.
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

