Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0A2A41FA06
	for <lists+linux-nfs@lfdr.de>; Sat,  2 Oct 2021 08:12:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232362AbhJBGOY (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 2 Oct 2021 02:14:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231952AbhJBGOY (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 2 Oct 2021 02:14:24 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3A43C061775
        for <linux-nfs@vger.kernel.org>; Fri,  1 Oct 2021 23:12:38 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id z24so47205461lfu.13
        for <linux-nfs@vger.kernel.org>; Fri, 01 Oct 2021 23:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vastdata.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4fL5w6Wqh9byUDa7f8JiI3gM4CUxjyJR13EaZ6OeDkk=;
        b=cEFdnq+PeeC1MMKJa7t1ebp2jTkHfM0mLvcWWwVJmBepJNTEEwFOBDV/G6zUEmYtfH
         /u91SWqxGVpxCHcu/3P7iv/sPxtPh3ad0yi3aSoihhHTW2VwALYsRDWfAH1Fi0DeZ0OO
         RSH8SQMurven3Dn9NYyrJdomWUdYmN0t37V4gD+vVih9VQLeDysEzpzA/arHcQfCsm2o
         mvsrHpT0yirqsyxeRcEjdx9TEZ9zNGMv6AxjIRF9ybm2ERNBDcw0Mbeoa+ms39oihoHJ
         s6NWsYYoffICY0nH8XtPAUwAqZ1e+es172AjP9JqSNk98f+T/8oBT4qhAGZF5LzEWd2d
         2mKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4fL5w6Wqh9byUDa7f8JiI3gM4CUxjyJR13EaZ6OeDkk=;
        b=VWKA8XA0u3CTfGAhcdMGORslUSV8E44x0msJ12kVxG7dEL6TsEs0AjGtUaRWNlDOSl
         XP1kvoXmT3jUVI/f6gzDcgQj8NAqWiS3z/L4k0gNIIcJljMNfAef5iporTPzzfl3lu1w
         6OJZvF7IJ1kO4JccBIdSEE67RkYVjx0SsWOry1u7qqyAb8AgnSOUgMmPoXoJaMeQ9XdC
         QHn8TIwx1MLXebOM7hHRygaiVLGMZ5tDRRiYPWHA6HI+mw7uLoxV3pLdYRER3GQOXzpF
         uwF2G4NnajZTGKW6xdNqQKT1ro5xTMYkelfIkEA9dIxZwuY9/1cdEmu3NpFSJ7Dc1kjL
         dbDQ==
X-Gm-Message-State: AOAM531Z9bE+s9egHktuMS2BYW0jGFrF8khYhvqKunYkLTiBCHlpr2cY
        whhDG97vcEj/gLtBwYSVKOLIQ4H5JpCoGW4C7PPF63wBkgc2PA==
X-Google-Smtp-Source: ABdhPJwrinravQTXxVe0G6wZHyDa2+yVacnbnui++mqsZ6ukiWb8b5fSvda0REWYLMMxDXKlHQXCrc5k2ymHxHXlpVM=
X-Received: by 2002:a05:6512:1399:: with SMTP id p25mr2248517lfa.277.1633155157079;
 Fri, 01 Oct 2021 23:12:37 -0700 (PDT)
MIME-Version: 1.0
References: <CANkgwetkTUjj-bMrM4XTvk0vhGiJt3wNKPpRvzgTk-u7ZfrdXg@mail.gmail.com>
 <20210930211123.GA16927@fieldses.org> <CANkgweuuo7VctNLNSGyVE2Unjv_RMdG7+zPYr6_QwSZAQTbPRQ@mail.gmail.com>
 <20211001141306.GD959@fieldses.org> <CANkgwevJURTVNcs8u3KS_jiZwxQZgGHX=YmU+kvbweQ0PLBHiA@mail.gmail.com>
 <20211001154821.GE959@fieldses.org>
In-Reply-To: <20211001154821.GE959@fieldses.org>
From:   Volodymyr Khomenko <volodymyr@vastdata.com>
Date:   Sat, 2 Oct 2021 09:12:25 +0300
Message-ID: <CANkgwetH1jzxYcUp5+7AnhE_S8iQBnrG76hrKsUsXUAsUqYNJA@mail.gmail.com>
Subject: Re: GSSAPI fix for pynfs nfs4.1 client code
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Ok, I see your point - yes, it's better that pynfs has "unusual but
still RFC-compliant" behaviour to catch the real bugs.
I will check how this behaviour (using seqid=0 or even something else
for EXCHANGE_ID) can be controlled from the caller side
if we want to override it.

P.S. Since the very 1st operation after NFS4 NULL is EXCHANGE_ID - it
should be only single operation
(client can't send few ECHANGE_ID because clientowner is only one per
mount) and next CREATE_SESSION can't be sent
until EXCHANGE_ID is replied from the server.
So the use-case of 'any of the first 128 rpcs were out of order' is
just a theoretical one and probably not possible in practice.

And thanks for handling the patch!

volodymyr.

On Fri, Oct 1, 2021 at 6:48 PM J. Bruce Fields <bfields@fieldses.org> wrote:
>
> On Fri, Oct 01, 2021 at 05:38:45PM +0300, Volodymyr Khomenko wrote:
> > > The seq_num field can start at any value below MAXSEQ
> > Yes, that's the statement I haven't found before in RFC...
> > Probably we also need to write a test starting the seq_num from a big
> > value (more than SEQUENCE_WINDOW)
> > to make sure that it is really implemented properly without
> > 'is_inited' flag (so what's the initial value?).
> >
> > However I still propose to keep the default behaviour of pynfs to be
> > the same as for linux NFS4 client.
> > I think the caller can change it when needed (to 0 or whatever
> > needed), but the default value should be good...
>
> That's what I'd choose if I were writing a "real" client.  Everybody
> already tests with the Linux client, so its behavior is a safe bet.
>
> But I'd usually prefer a test client do different things than the client
> everyone already tests with.
>
> Like I say, the seqid=0 already caught a bug in my server, so I'm a fan.
>
> (And it's a bug that would also trigger if any of the first 128 rpcs
> were out of order.  But that would probably manifest as some user
> reporting "once in a blue moon my krb5 mounts hang" and I think it would
> take a while to get from that report to this bug as the root cause.  So
> I'm glad pynfs hit it....)
>
> --b.
