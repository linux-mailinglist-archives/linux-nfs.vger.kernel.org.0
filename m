Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A7C73EDADE
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Aug 2021 18:25:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229571AbhHPQZ6 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 16 Aug 2021 12:25:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbhHPQZ5 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 16 Aug 2021 12:25:57 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02D82C061764
        for <linux-nfs@vger.kernel.org>; Mon, 16 Aug 2021 09:25:26 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id n13-20020a17090a4e0d00b0017946980d8dso14329733pjh.5
        for <linux-nfs@vger.kernel.org>; Mon, 16 Aug 2021 09:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=95+uaK83r4U6iSvnaYzjB0wHhHeovoB0gpUcK9r20+s=;
        b=rsIWHZhNUP9twdErGdEpM9uC39Nh5ODyeRukq51uB/bFNUCkCJB8ohAJyEPHOymekY
         kXEDLJyGR4nFwKO1kKies2DwDjhkW8Lq7XlMJ2Ylww8doQYbp9fO0y8XX4EJ7L5AE8KN
         vnoPGViNebmm7qtdqjLui7I2xO12s3xEaXL+xsGKj5ae585uPNoqQr2FbYus7Ya1gb3e
         VTlWVghVH0plsu1epj0l+3Ggq/bf/KouAU/CgzIeCVa34evJiGFejAJPuh5kNGC9j9by
         p2zuWLI3DVRc4D4dd9m8auoZLxSlSnozEn9FeTYVsM9tpr7A+acDTF33e8s2zOfmu3H2
         1ucQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=95+uaK83r4U6iSvnaYzjB0wHhHeovoB0gpUcK9r20+s=;
        b=RgUJZVy+3FhGrCnEKkMjgL0RGfA8quD0H+Qpw6BE8BOTsQoQUR8HIVv6syM+ec3stf
         KI2MDB2egFmybP4tBVpx77/ERVA8f+r1nwnRqPNRXx3WvIFapnCMtMKFs09hHo3rPU21
         OaxG27QIaYnpGAIWyqdB5eCA29P4KMbWLvAy6Ruw6XX2N8eW+0k2E0j6QRcu4zaTp2ai
         UpvMhfmvCS3NCeX8KxM8gJw3JyrtfE+GM+/D3vj7nO02tpJQoZSL0DqnPDG4bwOO85vx
         IINNBNHk6ACbbj5G3qISW+hJcLvf98KAuIlmOodbXf1+Oq5J+zZwp8iVwKOZONFK+LLk
         LBng==
X-Gm-Message-State: AOAM531JhE+7fZysnrJ6RYq8IXDU/lUJp+G0I49m0SN42n1FjlIGqQRZ
        U7wz7CftQKyohta5+P0ZuVz3aXS0bqgT08PgsJI=
X-Google-Smtp-Source: ABdhPJwGmX3h9jr209mRZvUuKuhRQFogq6VsUbAvtVy0uZ6e1uqwRZen+OD0CmUVz0DDwIgIt6k9gxgg618uJCArfgQ=
X-Received: by 2002:a17:90a:6407:: with SMTP id g7mr18534234pjj.230.1629131125512;
 Mon, 16 Aug 2021 09:25:25 -0700 (PDT)
MIME-Version: 1.0
References: <CAOv1SKCmdtchm5Z2NU80o49tkrHpAkPFaHKj4-vLDN5bZNCz-Q@mail.gmail.com>
 <162846730406.22632.14734595494457390936@noble.neil.brown.name>
 <CAOv1SKBZ7sGBnvG9-M+De+s=CfU=H_GBs4hJah1E4ks+NSMyPw@mail.gmail.com>
 <CAOv1SKCUM5cGuXWAc7dsXtbmPMATqd245juC+S9gVXHWiZsvmQ@mail.gmail.com>
 <162855893202.12431.3423894387218130632@noble.neil.brown.name>
 <CAOv1SKAaSbfw53LWCCrvGCHESgdtCf5h275Zkzi9_uHkqnCrdg@mail.gmail.com>
 <162882238416.1695.4958036322575947783@noble.neil.brown.name>
 <CAOv1SKB_dsam7P9pzzh_SKCtA8uE9cyFdJ=qquEfhLT42-szPA@mail.gmail.com>
 <CAOv1SKDDOj5UeUwztrMSNJnLgSoEgD8OU55hqtLHffHvaCQzzA@mail.gmail.com>
 <162907681945.1695.10796003189432247877@noble.neil.brown.name> <87777C39-BDDA-4E1E-83FA-5B46918A66D3@oracle.com>
In-Reply-To: <87777C39-BDDA-4E1E-83FA-5B46918A66D3@oracle.com>
From:   Mike Javorski <mike.javorski@gmail.com>
Date:   Mon, 16 Aug 2021 09:25:14 -0700
Message-ID: <CAOv1SKA5ByO7PYQwvd6iBcPieWxEp=BfUZuigJ=7Hm4HAmTuMA@mail.gmail.com>
Subject: Re: NFS server regression in kernel 5.13 (tested w/ 5.13.9)
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Neil Brown <neilb@suse.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Thanks for the pointer Chuck

I ran the trace capture and was able to trigger two freezes in
relatively short order. Here is that trace file:
https://drive.google.com/file/d/1qk_VIMkj8aTeQIg5O0W3AvWyeDSWL3vW/view?usp=sharing

- mike


On Mon, Aug 16, 2021 at 6:21 AM Chuck Lever III <chuck.lever@oracle.com> wrote:
>
>
>
> > On Aug 15, 2021, at 9:20 PM, NeilBrown <neilb@suse.de> wrote:
> >
> > On Sun, 15 Aug 2021, Mike Javorski wrote:
> >> I managed to get a cap with several discreet freezes in it, and I
> >> included a chunk with 5 of them in the span of ~3000 frames. I added
> >> packet comments at each frame that the tshark command reported as > 1
> >> sec RPC wait. Just search for "Freeze" in (wire|t)shark in packet
> >> details. This is with kernel 5.13.10 provided by Arch (See
> >> https://github.com/archlinux/linux/compare/a37da2be8e6c85...v5.13.10-arch1
> >> for diff vs mainline, nothing NFS/RPC related I can identify).
> >>
> >> I tried unsuccessfully to get any failures with the 5.12.15 kernel.
> >>
> >> https://drive.google.com/file/d/1T42iX9xCdF9Oe4f7JXsnWqD8oJPrpMqV/view?usp=sharing
> >>
> >> File should be downloadable anonymously.
> >
> > Got it, thanks.
> >
> > There are 3 RPC replies that are more than 1 second after the request.
> > The replies are in frames 983, 1005, 1777 These roughly correspond to
> > where you added the "Freeze" annotation (I didn't know you could do that!).
> >
> > 983:
> >  This is the (Start of the) reply to a READ Request in frame 980.
> >  It is a 128K read.  The whole reply has arrived by frame 1004, 2ms
> >  later.
> >  The request (Frame 980) is followed 13ms later by a TCP retransmit
> >  of the request and the (20usec later) a TCP ACK from the server.
> >
> >  The fact that the client needed to retransmit seems a little odd
> >  but as it is the only retransmit in the whole capture, I don't think
> >  we can read much into it.
> >
> > 1005:
> >  This is the reply to a 128K READ request in frame 793 - earlier than
> >  previous one.
> >  So there were two READ requests, then a 2 second delay then both
> >  replies in reverse order.
> >
> > 1777:
> >  This is a similar READ reply - to 1761.
> >  There were READs in 1760, 1761, and 1775
> >  1760 is replied to almost immediately
> >  1761 gets a reply in 4 seconds (1777)
> >  1775 never gets a reply (in the available packet capture).
> >
> > Looking at other delays ... most READs get a reply in under a millisec.
> > There are about 20 where the reply is more than 1ms - the longest delay
> > not already mentioned is 90ms with reply 1857.
> > The pattern here is
> >   READ req (1)
> >   GETATTR req
> >   GETATTR reply
> >   READ req (2)
> >   READ reply (1)
> >  pause
> >   READ reply (2)
> >
> > I suspect this is the same problem occurring, but it isn't so
> > noticeable.
> >
> > My first thought was that the reply might be getting stuck in the TCP
> > transmit queue on the server, but checking the TSval in the TCP
> > timestamp option shows that - for frame 983 which shows a 2second delay
> > - the TSval is also 2seconds later than the previous packet.  So the
> > delay happens before the TCP-level decision to create the packet.
> >
> > So I cannot see any real evidence to suggest a TCP-level problem.
> > The time of 2 or 4 seconds - and maybe even 90ms - seem unlikely to be
> > caused by an NFSd problem.
> >
> > So my guess is that the delay comes from the filesystem.  Maybe.
> > What filesystem are you exporting?
> >
> > How can we check this? Probably by turning on nfsd tracing.
> > There are a bunch of tracepoints that related to reading:
> >
> >       trace_nfsd_read_start
> >       trace_nfsd_read_done
> >       trace_nfsd_read_io_done
> >       trace_nfsd_read_err
> >       trace_nfsd_read_splice
> >       trace_nfsd_read_vector
> >       trace_nfsd_read_start
> >       trace_nfsd_read_done
> >
> > Maybe enabling them might be useful as you should be able to see if the
> > delay was within one read request, or between two read requests.
> > But I don't have much (if any) experience in enabling trace points.  I
> > really should try that some day.  Maybe you can find guidance on using
> > these tracepoint somewhere ... or maybe you already know how :-)
>
> Try something like:
>
> # trace-cmd record -e nfsd:nfsd_read_\*
>
> When the test is done, ^C the trace-cmd program. The trace records
> are stored in a file called trace.dat. You can view them with:
>
> # trace-cmd report | less
>
> The trace.dat file is portable. It carries the format specifiers
> for all records events, so the trace records can be viewed on
> other systems.
>
>
> --
> Chuck Lever
>
>
>
