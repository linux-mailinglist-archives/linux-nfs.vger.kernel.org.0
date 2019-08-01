Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E8F017DF41
	for <lists+linux-nfs@lfdr.de>; Thu,  1 Aug 2019 17:41:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729355AbfHAPlw (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 1 Aug 2019 11:41:52 -0400
Received: from mail-vs1-f42.google.com ([209.85.217.42]:46125 "EHLO
        mail-vs1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729198AbfHAPlw (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 1 Aug 2019 11:41:52 -0400
Received: by mail-vs1-f42.google.com with SMTP id r3so49160177vsr.13
        for <linux-nfs@vger.kernel.org>; Thu, 01 Aug 2019 08:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BgYo49Gv0ryh8E7lWrFEAwAfJZXjg7hOGIV7X/rwKW8=;
        b=aqQ4JiqFeTIuoiocjfV9PYDZyILSdnunJZXHS2QNPX4AqDpLhQzHQfhLRT2ZpwHx4e
         eI3uH7nz0fxws/hb6nmyB5s2uYMKoKdZRF95IQO82zS40I8EFzsjCR05n4/oMhxmVLTo
         J5m3wtJlVB2RKXfVLKOAaDXvFeXR1STWBpc2PxnsUrxnMeuEByGczBzBA9845gH77Vmo
         g1L01qU2/dFnLsoVdmYK+OrG6RPfJj2rqXi9fwyg2f2TiWV/GT8R88ZWVZKnVjRK2OoY
         KZhU6HZ303dl40q6p/vQixY29YFjWIHOkA1VzkT/K9mahKoqBt/sM0P4kHcY+A+eSjOI
         JH+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BgYo49Gv0ryh8E7lWrFEAwAfJZXjg7hOGIV7X/rwKW8=;
        b=PV+WDfX0t78TiFqZKyn75bCeQ+UIfz0YmILL7szg6ylSEACk+pJipqAIVLI+E3Gw8F
         0BJWNecj6xPVDWSkIwmyTe51lkfJpHDNUEiWEICDevAVAwIiexqgGgjwZ35yAvD3rhv3
         uMOGZ7VIt8bWftFdauJyFNT5tbI3gjCZe5JiANiCv2O4OVxmWuTlOj1SgC9KossdRb+5
         FsXrV2JoCNe51fuwIiDVpVT4Og9kWDpZd2SyWmg8QHbccEK3g7QG5s6WAL4Mbfaz0L3l
         rc2I4iv0uf7o7Ns/dNEV2ps6lK8TkBiyK7QWgYbR1MbBVhzcGTdX69wInMDeD5xJRwAv
         dvtQ==
X-Gm-Message-State: APjAAAXzWtd/mOIAMbC8ZtgL/mwopKkyF3bWAU4z07HGaqgoWrtqwOgn
        KkKfit66ABgzbBsNUJ2gcTqg4avKupwTRUU93Zc8Vw==
X-Google-Smtp-Source: APXvYqw5VeqGWYS9rvbAoFQ7+Kmf+b0b1gqMthWkfIfBt5M8pIM77n+zvKLbrsVfUSFlJz8/yufed0+7nQvHjjlE/nE=
X-Received: by 2002:a67:8e0a:: with SMTP id q10mr59275591vsd.215.1564674110623;
 Thu, 01 Aug 2019 08:41:50 -0700 (PDT)
MIME-Version: 1.0
References: <20190708192352.12614-1-olga.kornievskaia@gmail.com>
 <20190708192352.12614-6-olga.kornievskaia@gmail.com> <20190719220116.GA24373@fieldses.org>
 <CAN-5tyHdxBcEH0xPV2814nUMEHPCsQ9iD_A7K=W3ZeE6b4OJxg@mail.gmail.com>
 <20190723205846.GB19559@fieldses.org> <CAN-5tyFTRr9KPYAzq-EaOMqDeJU31-qHGsLyCmEtd18OMxCFNQ@mail.gmail.com>
 <CAN-5tyEbwjPNbXKWXv+3=geisjH-i=xKWRqgyXa3v9Xk=OvdEw@mail.gmail.com>
 <20190731215118.GA13311@parsley.fieldses.org> <CAN-5tyGz5M1eMFC=CJUEdTB7cAq-PRis8SJMEnrcr4Svmmy03w@mail.gmail.com>
 <20190801151239.GC17654@fieldses.org>
In-Reply-To: <20190801151239.GC17654@fieldses.org>
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
Date:   Thu, 1 Aug 2019 11:41:39 -0400
Message-ID: <CAN-5tyE8xdJhs5C_bOo0a9yLRUAvkKi7OLOq47He5P0OR8PGyQ@mail.gmail.com>
Subject: Re: [PATCH v4 5/8] NFSD check stateids against copy stateids
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     "J. Bruce Fields" <bfields@redhat.com>,
        linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Aug 1, 2019 at 11:13 AM J. Bruce Fields <bfields@fieldses.org> wrote:
>
> On Thu, Aug 01, 2019 at 10:12:11AM -0400, Olga Kornievskaia wrote:
> > On Wed, Jul 31, 2019 at 5:51 PM J. Bruce Fields <bfields@redhat.com> wrote:
> > >
> > > On Wed, Jul 31, 2019 at 05:10:01PM -0400, Olga Kornievskaia wrote:
> > > > I'm having difficulty with this patch because there is no good way to
> > > > know when the copy_notify stateid can be freed. What I can propose is
> > > > to have the linux client send a FREE_STATEID with the copy_notify
> > > > stateid and use that as the trigger to free the state. In that case,
> > > > I'll keep a reference on the parent until the FREE_STATEID is
> > > > received.
> > > >
> > > > This is not in the spec (though seems like a good idea to tell the
> > > > source server it's ok to clean up) so other implementations might not
> > > > choose this approach so we'll have problems with stateids sticking
> > > > around.
> > >
> > > https://tools.ietf.org/html/rfc7862#page-71
> > >
> > >         "If the cnr_lease_time expires while the destination server is
> > >         still reading the source file, the destination server is allowed
> > >         to finish reading the file.  If the cnr_lease_time expires
> > >         before the destination server uses READ or READ_PLUS to begin
> > >         the transfer, the source server can use NFS4ERR_PARTNER_NO_AUTH
> > >         to inform the destination server that the cnr_lease_time has
> > >         expired."
> > >
> > > The spec doesn't really define what "is allowed to finish reading the
> > > file" means, but I think the source server should decide somehow whether
> > > the target's done.  And "hasn't sent a read in cnr_lease_time" seems
> > > like a pretty good conservative definition that would be easy to
> > > enforce.
> >
> > "hasn't send a read in cnr_lease_time" is already enforced.
> >
> > The problem is when the copy did start in normal time, it might take
> > unknown time to complete. If we limit copies to all be done with in a
> > cnr_lease_time or even some number of that, we'll get into problems
> > when files are large enough or network is slow enough that it will
> > make this method unusable.
>
> No, I'm just suggesting that if it's been more than cnr_lease_time since
> the target server last sent a read using this stateid, then we could
> free the stateid.

That's reasonable. Let me do that.

> > > Worst case, if the network goes down for a couple minutes and
> > > the target tries to pick up a copy where it left off, it'll get
> > > PARTNER_NO_AUTH.  I assume that results in the same error being returned
> > > the client, at which point the client knows that the copy_notify stateid
> > > may have installed and can do what it chooses to recover (like send a
> > > new copy_notify).
> >
> > Yes the client recovers but the cost of setting up the source server
> > to destination is huge so any retries would kill the performance.
>
> In the rare case when the server goes an entire cnr_lease_time between
> reads, the performance hit of recovery won't be an issue.
>
> > > The FREE_STATEID might also be a good idea, but I guess we can't count
> > > on it.
> > >
> > > Maybe the spec could use some errata to clarify that FREE_STATEID is
> > > allowed on copy_notify stateids, that clients should send it when
> > > they're done, and that servers are allowed to expire copy_notify
> > > stateid's even after their first use.
> >
> > FREE_STATEID is for a stateid
>
> The discussion of FREE_STATEID in 4.1 says "The FREE_STATEID operation
> is used to free a stateid that no longer has any associated locks
> (including opens, byte-range locks, delegations, and layouts)."  A
> clarification that it can be used for any stateid would be nice.  (Is
> that true?  Do we want it for COPY stateid's too?)

We don't need it for the COPY stateids as there is a OFFLOAD_CANCEL if
the client wants to stop, otherwise, the destination server has no
problems with knowing when to free the copy stateid.

>
> --b.
>
> > which a copy_notify (or copy) stateid is so I don't see anything that
> > really needs any extra stating.
> >
> > I think what's needed is specifying that for COPY_NOTIFY a client must
> > do a FREE_STATEID when its done with a stateid.
