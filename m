Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B74CDB31D
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Oct 2019 19:15:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731791AbfJQRPv (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 17 Oct 2019 13:15:51 -0400
Received: from mail-ua1-f67.google.com ([209.85.222.67]:41439 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728639AbfJQRPv (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 17 Oct 2019 13:15:51 -0400
Received: by mail-ua1-f67.google.com with SMTP id l13so900354uap.8
        for <linux-nfs@vger.kernel.org>; Thu, 17 Oct 2019 10:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/aAlKcpqnLPShu+fN6LwWs6qFlJfzrRCNAdEqnFykI4=;
        b=YWZMG5NZiUUssREGlx78ibupknX9AA8YRV/JZnBP2j3qerUnnuUQDuZj/Pa/oIo+l7
         Cfdvgz9fNrb5aKHaXJR0rBUoiJ1sDmCagNN2Glv+cY81qBRR8Pn/w/b2fuFy9Qn96QBI
         k+bQZJJsbILS8zVpS07vNmIkzSfo+krk7RfKyLmf43dvSVjgBxbUpKia5ecGI55BZV8V
         f3RMndsIwuEXiljZxMJ7HQPGn2Q7eXE10Ub5sqvuNheqP/ZLjbZ5PdhjKEKEEjG9KYWc
         e5Q7cOAozgRzBHmG+im2opCxAD9JfE8bfxeC4ufcArW9hc/vc5IHVKgYVrZr9WcTYjlj
         IUJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/aAlKcpqnLPShu+fN6LwWs6qFlJfzrRCNAdEqnFykI4=;
        b=PaOYarCA/BYFLY6R6BSiITJ4XT8RuRa8nTu0vX5TZH4Poq5pXc5pHU2EWVubTN3Zre
         rSy9Z1AIWD7oi44PM9c/eeo1BxwE/eu0uRXKWHjVPW53iYDYZP9/68X/Uub1hNalq3q9
         MWr3f7hzIYndbZOI2d/0CMIWoYhqxhNH3yBHMh20KOo93HKJQVUeqY9Kq7sQEx68YA4Y
         ZSooNKGHEKmrVNZZAbuq69rnil7SRQ6ePH58CSPeR+bz68bQakulYG17G31BWwU4oiif
         BMwW/nbJSCZ8Aou+HA04Wi3GSV8AahO/89hbNWBQabEoJGbz5pj/34Fz7lRS1Aw+iFno
         ilcw==
X-Gm-Message-State: APjAAAXGfgxkyUdSmP5fPIPLsXQyGnV2gGna2pxBxSDqS+3zSpa1C+Ej
        6OxuyouGte0hGE0eszRnVRCcncRQH8xTR0YudNw=
X-Google-Smtp-Source: APXvYqznkHjeG5Y8ZOgKjIorXioFkPtrCFZUW6weLJ/HR/UvulYlmk9FA1mr93o1YRJZjSUQp8THlOJm+rNUjCIeY88=
X-Received: by 2002:ab0:5949:: with SMTP id o9mr2880903uad.65.1571332549924;
 Thu, 17 Oct 2019 10:15:49 -0700 (PDT)
MIME-Version: 1.0
References: <YQBPR0101MB1652856488503987CEB17738DD920@YQBPR0101MB1652.CANPRD01.PROD.OUTLOOK.COM>
 <YQBPR0101MB1652DEF8AD7A6169D44D47C6DD920@YQBPR0101MB1652.CANPRD01.PROD.OUTLOOK.COM>
 <20191016155838.GA17543@fieldses.org> <31E6043B-090D-4E37-B66F-A45AC0CFC970@netapp.com>
 <20191016203150.GC17543@fieldses.org> <YQBPR0101MB16524CABD71AACBD2D9DC651DD6D0@YQBPR0101MB1652.CANPRD01.PROD.OUTLOOK.COM>
 <20191017152253.GG32141@fieldses.org> <6f98f9ab-bf81-3a4a-64e7-2abef60e20d4@talpey.com>
 <YQBPR0101MB16525B93EA77EC9F6937FFFADD6D0@YQBPR0101MB1652.CANPRD01.PROD.OUTLOOK.COM>
In-Reply-To: <YQBPR0101MB16525B93EA77EC9F6937FFFADD6D0@YQBPR0101MB1652.CANPRD01.PROD.OUTLOOK.COM>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Thu, 17 Oct 2019 13:15:37 -0400
Message-ID: <CAN-5tyET7boQ5hTkA7caPS5aWfXq6QaLnsDFx3taWPH_WFL6qQ@mail.gmail.com>
Subject: Re: [nfsv4] NFSv4.2 server replies to Copy with length == 0
To:     Rick Macklem <rmacklem@uoguelph.ca>
Cc:     Tom Talpey <tom@talpey.com>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        "Kornievskaia, Olga" <Olga.Kornievskaia@netapp.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "nfsv4@ietf.org" <nfsv4@ietf.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Oct 17, 2019 at 12:20 PM Rick Macklem <rmacklem@uoguelph.ca> wrote:
>
> Tom Talpey wrote:
> >On 10/17/2019 11:22 AM, J. Bruce Fields wrote:
> >> On Thu, Oct 17, 2019 at 02:16:36AM +0000, Rick Macklem wrote:
> >>> I have now found two cases where the Linux NFSv4.2 server does not
> >>> conform to RFC-7862. One is as above and the other is a reply to Seek
> >>> of NFS4ERR_NXIO when the sa_offset argument == file_size (instead of
> >>> replying NFS_OK along with sr_eof == true).
> >>
> >> Huh.  Looks like that's documented behavior of Linux's seek.  (See the
> >> ERRORS section of the lseek(2) man page.)  Looks like Solaris also
> >> returns -ENXIO in this case:
> >>
> >>       https://docs.oracle.com/cd/E26502_01/html/E29032/lseek-2.html
> >>
> >> And freebsd too:
> >>
> >>       https://www.freebsd.org/cgi/man.cgi?query=lseek&sektion=2
> >>
> >> I wonder where that spec language came from?
> >
> >Those manpages look like ENXIO comes back only on sparse files. Perhaps
> >this is boilerplate from v4.0 before this kind of thing was common.
> As far as I know, a non-sparse file (no holes) behaves the same as a file with
> holes in it. (I'm not sure if the POSIX draft is clear for the case where the
> file system does not support holes, but I think most implementations handle
> that the same way as a file with no holes on a file system that supports holes.)
>
> >This should at least be discussed on nfsv4@ietf.org...
> I think there needs to be a discussion on how to best deal with cases where
> implementations have shipped to users with these glitches in them.
>
> I think it might be better to document them, so that client coders can
> implement work arounds (I am doing so for the three cases I've found)
> instead of the server being patched to change its behaviour, causing
> potentially more interoperability issues.
> (That's why I re-posted this to nfsv4@ietf.org.)
>
> >> Our NFS server could translate an -ENXIO return into 0 and sr_eof ==
> >> true easily enough, assuming -ENXIO is really only ever returned in that
> >> case.
> >>
> >> I haven't tested, but from a quick check of the Linux client code I
> >> think that would require a matching fix on the client side to translate
> >> sr_eof == 0 *back* to ENXIO.
> >>
> >> I don't know if it's worth it.
> >
> >What Bad Thing would happen for the difference?
> Well, for a POSIX draft style client, the only effect is that a client may be
> broken (not handle the sr_eof == true reply correctly) without the
> implementors knowing that, since they tested against the Linux server.
> (I believe this is the current status of the Linux client.)
>
> For a server implementor (I get to wear both hats;-), the server can only
> generate one reply or the other. I've implemented both with a tunable
> that can be used to flip between them. I default to the NFS4ERR_NXIO
> reply, since that is what the Linux client expects.
>
> As for the Copy issues, the client can easily handle them, but the client
> coder needs to know about them.
> At this time the FreeBSD server code only implements what is in the RFC.
> This seems sufficient for the testing I've done sofar.
> The case that I think will break would be Linux code that does a
> copy_file_range(infd, NULL, outfd, NULL, INT_MAX, 0) to copy an entire
> file. I'll test this case to-day, but I'm think it will just get a NFS4ERR_INVAL
> reply from the FreeBSD server.

this might be problematic for the linux client because though there
isn't an official use of it but the libc cp might implement this doing
exactly what you say here copy_file_range(infd, NULL, outfd, NULL,
INT_MAX, 0). It doesn't try to determine the size of the file before
the copy and
just copy max bytes assuming that it'll get a short read at some point.

> (I can make this work for the Linux client, but it will take another "cheat"
>  enabled via a tunable.)
> --> Part of the confusion here comes from the fact that the Linux syscall
>        semantics for copy_file_range() has changed. (I also where the
>        copy_file_range(2) hat for FreeBSD, so I've got some work to do there, too.)
>
> In summary, I think that, since Linux has been shipping this for some time,
> documenting workarounds is a practical approach.
>
> rick
>
> _______________________________________________
> nfsv4 mailing list
> nfsv4@ietf.org
> https://www.ietf.org/mailman/listinfo/nfsv4
