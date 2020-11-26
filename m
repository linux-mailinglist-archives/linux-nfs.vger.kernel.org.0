Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A7BC2C4BC2
	for <lists+linux-nfs@lfdr.de>; Thu, 26 Nov 2020 01:05:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727281AbgKZAEy (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 25 Nov 2020 19:04:54 -0500
Received: from elasmtp-curtail.atl.sa.earthlink.net ([209.86.89.64]:37730 "EHLO
        elasmtp-curtail.atl.sa.earthlink.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726908AbgKZAEy (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 25 Nov 2020 19:04:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mindspring.com;
        s=dk12062016; t=1606349094; bh=kt1pgGwhmWN6g7RTzok9XNvm6uE22lgyYyUA
        Hkzl9r8=; h=Received:From:To:Cc:References:In-Reply-To:Subject:Date:
         Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:
         X-Mailer:Thread-Index:Content-Language:X-ELNK-Trace:
         X-Originating-IP; b=PojZKnhAAyiofIWXPXmateD9cmcyy6Mi8qSgNMd7TUIWTj
        HvpEVcB59BJ1WLP/h8oFKdb5gNstj85aukpXoGk1INQyIdmJRa3QZsJ7sbjP4Pm5Vhx
        q4+dCmPzIFSxnFpG81EkXU1NNLwpOm2civs4CpNQ47yZ/DRlAArZggmVFqnr7wvbBKg
        PLcX1JHj9FkYGPInEY2w+SvAR+wQQKQVtdgTABPEuwAQudImis29IvjJqj10tXk/7KD
        Wkb3L++dAr2f9cE2uJQHUeMs5gRhN5XSLZgNXkGKRSrXlSwbMPow6uQWDsAsZQPvxWj
        5o6ThdzGW89liz8wV/InZTyGfNJA==
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=dk12062016; d=mindspring.com;
  b=I2a+6DjG0npKYda/Am8eiHCLQZvxGGcp1CfEudE83zBkIXQ6jQ/1HHSI074U394kQG4uU83xnHYP/DpFMIjB7BZS7hIK00MTPbLdlDZDA+oVH8Z5yuQ/UOEYXGIQJj1Ga+aE9V1efO4qBzBpCBKy/KVAE6W9IHDYm8ZJL8RkL/uEmGOSeWaZL21el4Q9pSnZIx+z8+5PnUrnDoKasZpKTAE1X2Ftk9pZ/Fl/qXSsTcv6gebSHUq3TrVRjm+luGO8RO3vmXtl9FXG49Udg3aOjtWeDGDnUlzXskF9PfVr8C5VnD6TJG8gTksoFNhtzpz1gIbhSoD1rAyWaxUNlL5wiQ==;
  h=Received:From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:X-Mailer:Thread-Index:Content-Language:X-ELNK-Trace:X-Originating-IP;
Received: from [76.105.143.216] (helo=FRANKSTHINKPAD)
        by elasmtp-curtail.atl.sa.earthlink.net with esmtpa (Exim 4)
        (envelope-from <ffilzlnx@mindspring.com>)
        id 1ki4mJ-0001AK-KG; Wed, 25 Nov 2020 19:04:51 -0500
From:   "Frank Filz" <ffilzlnx@mindspring.com>
To:     "'bfields'" <bfields@fieldses.org>
Cc:     "'Daire Byrne'" <daire@dneg.com>,
        "'Trond Myklebust'" <trondmy@hammerspace.com>,
        "'linux-cachefs'" <linux-cachefs@redhat.com>,
        "'linux-nfs'" <linux-nfs@vger.kernel.org>
References: <1188023047.38703514.1600272094778.JavaMail.zimbra@dneg.com> <279389889.68934777.1603124383614.JavaMail.zimbra@dneg.com> <635679406.70384074.1603272832846.JavaMail.zimbra@dneg.com> <20201109160256.GB11144@fieldses.org> <1744768451.86186596.1605186084252.JavaMail.zimbra@dneg.com> <1055884313.92996091.1606250106656.JavaMail.zimbra@dneg.com> <20201124211522.GC7173@fieldses.org> <0fc201d6c2af$62b039f0$2810add0$@mindspring.com> <20201125144753.GC2811@fieldses.org> <100101d6c347$917ed0f0$b47c72d0$@mindspring.com> <20201125190315.GB7049@fieldses.org>
In-Reply-To: <20201125190315.GB7049@fieldses.org>
Subject: RE: Adventures in NFS re-exporting
Date:   Wed, 25 Nov 2020 16:04:51 -0800
Message-ID: <103e01d6c387$c3d7f640$4b87e2c0$@mindspring.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQLbRzS9yZr5C5vAyHWnu9xOS+RZ+gH6EgB+ATmqgtcBmvnx5gFd2itFAYsKXvUCY0qgxgKfDMlvApwox1gCn5pjiwGJmGGRpzSF2/A=
Content-Language: en-us
X-ELNK-Trace: 136157f01908a8929c7f779228e2f6aeda0071232e20db4dbf9d46175fc33655b0564f0bda0d754b350badd9bab72f9c350badd9bab72f9c350badd9bab72f9c
X-Originating-IP: 76.105.143.216
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> -----Original Message-----
> From: 'bfields' [mailto:bfields@fieldses.org]
> Sent: Wednesday, November 25, 2020 11:03 AM
> To: Frank Filz <ffilzlnx@mindspring.com>
> Cc: 'Daire Byrne' <daire@dneg.com>; 'Trond Myklebust'
> <trondmy@hammerspace.com>; 'linux-cachefs' <linux-cachefs@redhat.com>;
> 'linux-nfs' <linux-nfs@vger.kernel.org>
> Subject: Re: Adventures in NFS re-exporting
> 
> On Wed, Nov 25, 2020 at 08:25:19AM -0800, Frank Filz wrote:
> > On the other
> > hand, re-export with state has a pitfall. If the re-export server
> > crashes, the state is lost on the original server unless we make a
> > protocol change to allow state re-export such that a re-export server
> > crashing doesn't cause state loss.
> 
> Oh, yes, reboot recovery's an interesting problem that I'd forgotten
about;
> added to that wiki page.
>
> By "state re-export" you mean you'd take the stateids the original server
> returned to you, and return them to your own clients?  So then I guess you
> wouldn't need much state at all.

By state re-export I meant reflecting locks the end client takes on the
re-export server to the original server. Not necessarily by reflecting the
stateid (probably something to trip on there...) (Can we nail down a good
name for it? Proxy server or re-export server work well for the man in the
middle, but what about the back end server?)

Frank

> > For this reason, I haven't rushed to implement lock state re-export in
> > Ganesha, rather allowing the re-export server to just manage lock
> > state locally.
> >
> > > Cooperating servers could have an agreement on filehandles.  And I
> > > guess
> > we
> > > could standardize that somehow.  Are we ready for that?  I'm not
> > > sure what other re-exporting problems there are that I haven't thought
of.
> >
> > I'm not sure how far we want to go there, but potentially specific
> > server implementations could choose to be interoperable in a way that
> > allows the handle encapsulation to either be smaller or no extra
> > overhead. For example, if we implemented what I've thought about for
> > Ganesha-Ganesha re-export, Ganesha COULD also be "taught" which
> > portion of the knfsd handle is the filesystem/export identifier, and
> > maintain a database of Ganesha export/filesystem <-> knfsd
> > export/filesystem and have Ganesha re-encapsulate the
> > exportfs/name_to_handle_at portion of the handle. Of course in this
> > case, trivial migration isn't possible since Ganesha will have a
different
> encapsulation than knfsd.
> >
> > Incidentally, I also purposefully made Ganesha's encapsulation
> > different so it never collides with either version of knfsd handles
> > (now if over the course of the past 10 years another handle version has
come
> along...).
> 
> I don't think anything's changed there.
> 
> --b.

