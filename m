Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D1BD7B6BFB
	for <lists+linux-nfs@lfdr.de>; Tue,  3 Oct 2023 16:45:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240092AbjJCOpQ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 3 Oct 2023 10:45:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240129AbjJCOpO (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 3 Oct 2023 10:45:14 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1A76AB
        for <linux-nfs@vger.kernel.org>; Tue,  3 Oct 2023 07:45:08 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-32163c3ece5so176175f8f.1
        for <linux-nfs@vger.kernel.org>; Tue, 03 Oct 2023 07:45:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1696344307; x=1696949107; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UnbDTLoF2SjGCEwyku+6dkFLGWMO01nZmlFF/FTwxDc=;
        b=OxnconD1YRSsRStDu3raJlbi33vUcxE6QYLGa58s0H2WGhDmPIgghdGuiwv4BbTv2m
         aRnJawd6zA1H7VxHgKWgMmqo5sunHWpTpov0fmZL6Qo/GgxytekEuT90PlK8IyNS5e4W
         Ddmjf8KHg/svngmOWvBAGmXLI/6zEs6eXsstiH7yAycjF2qVlIhyOjUue4YgPfwIQ7Kz
         CksfHhg77zlZ2UwcPoQgLin+oOagdgbsNd7rouOquj+mHPZTleTP7H01cmJ7VkPmnM8c
         O6nmk0KHgSPsx6eD5xM5u/VARlDMhh44UPKXE5wt3uJt/YKrK/r9mTiEkDBOLuba2YaR
         9RTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696344307; x=1696949107;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UnbDTLoF2SjGCEwyku+6dkFLGWMO01nZmlFF/FTwxDc=;
        b=iY5ntMv0Xz7e2yMyXr5+ZfVA5ZJD5NRhgpWhyCaOli1QF97fX/JkFhB3y/ohPhzdJ5
         WqWZlT5pKNMHsZxOMLC3ALuAdxdi5Hmg3yBnDsdJ1AYCXtHB57io8EiWZ/GK7EgP1/gp
         dAspg/Rj7qj0l/Ai9fSKpUUOYqyCB8h9B3wupyUDyEzPzvj3kqz1qXxWYzDfwwagO64m
         oOKtvIlk+tXR6Kt4wI9mfXcNwoqBHC6Fe5nWumrnbaqj2zKeUVoTtLfxbG+O7uSYS7CZ
         w4yHo9MQBcBmvvjXjq1IipMLBG9WdQmwakmN8mFYpLgT5cjciyemrzYiQwJ+xm7cOvLH
         /MWw==
X-Gm-Message-State: AOJu0YzKHX9309+tr6XFWYIt/bpqNFAju9ytO9IBxgHCCMBVYmtobRLf
        Jryl1a2+R3o8jlGD8ftGbiJsdeDAToRUIRGqL/qRoypEbLY=
X-Google-Smtp-Source: AGHT+IGR9QVlkjTtf+tF3mbq83REnpLW5KmQweqdeJBbbACGvIdMlbQzSR4m4MwdZyDQwTPCvRY/rr8zGUyvOP39bB4=
X-Received: by 2002:adf:f549:0:b0:31f:edc3:c5fb with SMTP id
 j9-20020adff549000000b0031fedc3c5fbmr11513312wrp.5.1696344306683; Tue, 03 Oct
 2023 07:45:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230927192712.317799-1-trondmy@kernel.org> <CAN-5tyF9rKdu0D-7nUFQtq1BWQABb+mdY3sLrDY1-sU_Q2p8fA@mail.gmail.com>
 <c32aec7b2a8b226a1617ff9755b7b5ce64ad3114.camel@hammerspace.com>
 <CAN-5tyE2_myhnzuf28gmm9ztJxb+g=fHS4wDVNE5D43BSandUA@mail.gmail.com> <d3c1b8980a2942d79b9a5fe61586ebe42e75b7e6.camel@hammerspace.com>
In-Reply-To: <d3c1b8980a2942d79b9a5fe61586ebe42e75b7e6.camel@hammerspace.com>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Tue, 3 Oct 2023 10:44:55 -0400
Message-ID: <CAN-5tyF99D_HoGjjB2yuQpcQ_c39q7-xOawWuk4EUdaMZL=-jQ@mail.gmail.com>
Subject: Re: [PATCH] SUNRPC: Don't retry using the same source port if
 connection failed
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Sat, Sep 30, 2023 at 7:06=E2=80=AFPM Trond Myklebust <trondmy@hammerspac=
e.com> wrote:
>
> On Sat, 2023-09-30 at 18:36 -0400, Olga Kornievskaia wrote:
> > On Fri, Sep 29, 2023 at 10:57=E2=80=AFPM Trond Myklebust
> > <trondmy@hammerspace.com> wrote:
> > >
> > > On Thu, 2023-09-28 at 10:58 -0400, Olga Kornievskaia wrote:
> > > > On Wed, Sep 27, 2023 at 3:35=E2=80=AFPM <trondmy@kernel.org> wrote:
> > > > >
> > > > > From: Trond Myklebust <trond.myklebust@hammerspace.com>
> > > > >
> > > > > If the TCP connection attempt fails without ever establishing a
> > > > > connection, then assume the problem may be the server is
> > > > > rejecting
> > > > > us
> > > > > due to port reuse.
> > > >
> > > > Doesn't this break 4.0 replay cache? Seems too general to assume
> > > > that
> > > > any unsuccessful SYN was due to a server reboot and it's ok for
> > > > the
> > > > client to change the port.
> > >
> > > This is where things get interesting. Yes, if we change the port
> > > number, then it will almost certainly break NFSv3 and NFSv4.0
> > > replay
> > > caching on the server.
> > >
> > > However the problem is that once we get stuck in the situation
> > > where we
> > > cannot connect, then each new connection attempt is just causing
> > > the
> > > server's TCP layer to push back and recall that the connection from
> > > this port was closed.
> > > IOW: the problem is that once we're in this situation, we cannot
> > > easily
> > > exit without doing one of the following. Either we have to
> > >
> > >    1. Change the port number, so that the TCP layer allows us to
> > >       connect.
> > >    2. Or.. Wait for long enough that the TCP layer has forgotten
> > >       altogether about the previous connection.
> > >
> > > The problem is that option (2) is subject to livelock, and so has a
> > > potential infinite time out. I've seen this livelock in action, and
> > > I'm
> > > not seeing a solution that has predictable results.
> > >
> > > So unless there is a solution for the problems in (2), I don't see
> > > how
> > > we can avoid defaulting to option (1) at some point, in which case
> > > the
> > > only question is "when do we switch ports?".
> >
> > I'm not sure how one can justify that regression that will come out
> > of
> > #1 will be less of a problem then the problem in #2.
> >
> > I think I'm still not grasping why the NFS server would
> > (legitimately)
> > be closing a connection that is re-using the port. Can you present a
> > sequence of events that would lead to this?
> >
>
> Yes. It is essentially the problem described in this blog:
> https://blog.davidvassallo.me/2010/07/13/time_wait-and-port-reuse/
>
> ...and as you can see, it is nothing to do with NFS. This is the TCP
> protocol working as expected.

What I'm seeing are statements that RFC allows for/provides guidance
on how to transition out of TIME_WAIT state. I'm also hearing that the
reasons that the server can't allow for port reuse is due to broken
client implementation or use of (broken?) NAT implementation.

I don't see how any of this justifies allowing a regression in the
linux client code. I'm clearly missing something. How are you possibly
OK with breaking the reply cache?

> > But can't we at least arm ourselves in not unnecessarily breaking the
> > reply cache by at least imposing some timeout/number of retries
> > before
> > resetting? If the client was retrying to unsuccessfully re-establish
> > connection for a (fixed) while, then 4.0 client's lease would expire
> > and switching the port after the lease expires makes no difference.
> > There isn't a solution in v3 unfortunately. But a time-based approach
> > would at least separate these 'peculiar' servers vs normal servers.
> > And if this is a 4.1 client, we can reset the port without a timeout.
> >
>
> This is not a 'peculiar server' vs 'normal server' problem. The reuse
> of ports in this way violates the TCP protocol, and has been a problem

I disagree here. Even the RFC quoted by the blogger says that reuse of
port is allowed.

> for NFS/TCP since the beginning. However, it was never a problem for
> the older connectionless UDP protocol, which is where the practice of
> tying the replay cache to the source port began in the first place.
>
> NFSv4.1 does not have this problem because it deliberately does not
> reuse TCP ports, and the reason is precisely to avoid the TIME_WAIT
> state problems.
>
> NFSv3 tries to avoid it by doing an incremental back off, but we
> recently saw that does not suffice to avoid live lock, after a system
> got stuck for several hours in this state.
>
> > Am I correct that every unsuccessful SYN causes a new source point to
> > be taken? If so, then a server reboot where multiple SYNs are sent
> > prior to connection re-establishment (times number of mounts) might
> > cause source port exhaustion?
> >
>
> No. Not every unsuccessful SYN: It is every unsuccessful sequence of

I disagree. Here's a snippet of the network trace with the proposed
patch. The port is changed on EVERY unsuccessful SYN.

   76 2023-10-03 10:17:04.285731 192.168.1.134 =E2=86=92 192.168.1.106 NFS =
238
V3 WRITE Call, FH: 0x10bedd7c Offset: 0 Len: 4 FILE_SYNC
   77 2023-10-03 10:17:04.328371 192.168.1.106 =E2=86=92 192.168.1.134 TCP =
66
2049 =E2=86=92 909 [ACK] Seq=3D1113 Ack=3D1501 Win=3D31872 Len=3D0 TSval=3D=
3542359002
TSecr=3D3081600630
  256 2023-10-03 10:18:04.341041 192.168.1.134 =E2=86=92 192.168.1.106 TCP =
66
[TCP Keep-Alive] 909 =E2=86=92 2049 [ACK] Seq=3D1500 Ack=3D1113 Win=3D32000=
 Len=3D0
TSval=3D3081660681 TSecr=3D3542359002
  259 2023-10-03 10:18:04.341500 192.168.1.106 =E2=86=92 192.168.1.134 TCP =
54
2049 =E2=86=92 909 [RST] Seq=3D1113 Win=3D0 Len=3D0
  260 2023-10-03 10:18:04.341860 192.168.1.134 =E2=86=92 192.168.1.106 TCP =
74
[TCP Port numbers reused] 909 =E2=86=92 2049 [SYN] Seq=3D0 Win=3D32120 Len=
=3D0
MSS=3D1460 SACK_PERM TSval=3D3081660681 TSecr=3D0 WS=3D128
  261 2023-10-03 10:18:04.342031 192.168.1.106 =E2=86=92 192.168.1.134 TCP =
54
2049 =E2=86=92 909 [RST, ACK] Seq=3D1 Ack=3D1 Win=3D0 Len=3D0
  266 2023-10-03 10:18:07.380801 192.168.1.134 =E2=86=92 192.168.1.106 TCP =
74
954 =E2=86=92 2049 [SYN] Seq=3D0 Win=3D32120 Len=3D0 MSS=3D1460 SACK_PERM
TSval=3D3081663720 TSecr=3D0 WS=3D128
  267 2023-10-03 10:18:07.380971 192.168.1.106 =E2=86=92 192.168.1.134 TCP =
54
2049 =E2=86=92 954 [RST, ACK] Seq=3D1 Ack=3D1 Win=3D0 Len=3D0
  275 2023-10-03 10:18:10.423352 192.168.1.134 =E2=86=92 192.168.1.106 TCP =
74
856 =E2=86=92 2049 [SYN] Seq=3D0 Win=3D32120 Len=3D0 MSS=3D1460 SACK_PERM
TSval=3D3081666760 TSecr=3D0 WS=3D128
  276 2023-10-03 10:18:10.423621 192.168.1.106 =E2=86=92 192.168.1.134 TCP =
54
2049 =E2=86=92 856 [RST, ACK] Seq=3D1 Ack=3D1 Win=3D0 Len=3D0
  286 2023-10-03 10:18:13.466277 192.168.1.134 =E2=86=92 192.168.1.106 TCP =
74
957 =E2=86=92 2049 [SYN] Seq=3D0 Win=3D32120 Len=3D0 MSS=3D1460 SACK_PERM
TSval=3D3081669801 TSecr=3D0 WS=3D128
  287 2023-10-03 10:18:13.466812 192.168.1.106 =E2=86=92 192.168.1.134 TCP =
54
2049 =E2=86=92 957 [RST, ACK] Seq=3D1 Ack=3D1 Win=3D0 Len=3D0
  289 2023-10-03 10:18:16.509229 192.168.1.134 =E2=86=92 192.168.1.106 TCP =
74
695 =E2=86=92 2049 [SYN] Seq=3D0 Win=3D32120 Len=3D0 MSS=3D1460 SACK_PERM
TSval=3D3081672841 TSecr=3D0 WS=3D128
  290 2023-10-03 10:18:16.509845 192.168.1.106 =E2=86=92 192.168.1.134 TCP =
54
2049 =E2=86=92 695 [RST, ACK] Seq=3D1 Ack=3D1 Win=3D0 Len=3D0
  294 2023-10-03 10:18:19.551062 192.168.1.134 =E2=86=92 192.168.1.106 TCP =
74
940 =E2=86=92 2049 [SYN] Seq=3D0 Win=3D32120 Len=3D0 MSS=3D1460 SACK_PERM
TSval=3D3081675881 TSecr=3D0 WS=3D128
  295 2023-10-03 10:18:19.551434 192.168.1.106 =E2=86=92 192.168.1.134 TCP =
54
2049 =E2=86=92 940 [RST, ACK] Seq=3D1 Ack=3D1 Win=3D0 Len=3D0
  300 2023-10-03 10:18:22.590380 192.168.1.134 =E2=86=92 192.168.1.106 TCP =
74
810 =E2=86=92 2049 [SYN] Seq=3D0 Win=3D32120 Len=3D0 MSS=3D1460 SACK_PERM
TSval=3D3081678921 TSecr=3D0
WS=3D128
  301 2023-10-03 10:18:22.590726 192.168.1.106 =E2=86=92 192.168.1.134 TCP =
54
2049 =E2=86=92 810 [RST, ACK] Seq=3D1 Ack=3D1 Win=3D0 Len=3D0
  308 2023-10-03 10:18:25.628256 192.168.1.134 =E2=86=92 192.168.1.106 TCP =
74
877 =E2=86=92 2049 [SYN] Seq=3D0 Win=3D32120 Len=3D0 MSS=3D1460 SACK_PERM
TSval=3D3081681961 TSecr=3D0 WS=3D128
  309 2023-10-03 10:18:25.628724 192.168.1.106 =E2=86=92 192.168.1.134 TCP =
54
2049 =E2=86=92 877 [RST, ACK] Seq=3D1 Ack=3D1 Win=3D0 Len=3D0
  312 2023-10-03 10:18:28.665682 192.168.1.134 =E2=86=92 192.168.1.106 TCP =
74
934 =E2=86=92 2049 [SYN] Seq=3D0 Win=3D32120 Len=3D0 MSS=3D1460 SACK_PERM
TSval=3D3081685001 TSecr=3D0 WS=3D128
  313 2023-10-03 10:18:28.666374 192.168.1.106 =E2=86=92 192.168.1.134 TCP =
54
2049 =E2=86=92 934 [RST, ACK] Seq=3D1 Ack=3D1 Win=3D0 Len=3D0
  320 2023-10-03 10:18:31.702236 192.168.1.134 =E2=86=92 192.168.1.106 TCP =
74
803 =E2=86=92 2049 [SYN] Seq=3D0 Win=3D32120 Len=3D0 MSS=3D1460 SACK_PERM
TSval=3D3081688040 TSecr=3D0 WS=3D128
  321 2023-10-03 10:18:31.702490 192.168.1.106 =E2=86=92 192.168.1.134 TCP =
74
2049 =E2=86=92 803 [SYN, ACK] Seq=3D0 Ack=3D1 Win=3D31856 Len=3D0 MSS=3D146=
0 SACK_PERM
TSval=3D1993141756 TSecr=3D3081688040 WS=3D128
  322 2023-10-03 10:18:31.702729 192.168.1.134 =E2=86=92 192.168.1.106 TCP =
66
803 =E2=86=92 2049 [ACK] Seq=3D1 Ack=3D1 Win=3D32128 Len=3D0 TSval=3D308168=
8040
TSecr=3D1993141756
  323 2023-10-03 10:18:31.702737 192.168.1.134 =E2=86=92 192.168.1.106 NFS =
238
V3 WRITE Call, FH: 0x10bedd7c Offset: 0 Len: 4 FILE_SYNC
  324 2023-10-03 10:18:31.702893 192.168.1.106 =E2=86=92 192.168.1.134 TCP =
66
2049 =E2=86=92 803 [ACK] Seq=3D1 Ack=3D173 Win=3D31872 Len=3D0 TSval=3D1993=
141756
TSecr=3D3081688040
  749 2023-10-03 10:19:01.880214 192.168.1.106 =E2=86=92 192.168.1.134 NFS =
206
V3 WRITE Reply (Call In 323) Len: 4 FILE_SYNC

This is the same without the patch. Port is successfully reused.
Replay cache OK here not above.

   76 2023-10-03 10:17:04.285731 192.168.1.134 =E2=86=92 192.168.1.106 NFS =
238
V3 WRITE Call, FH: 0x10bedd7c Offset: 0 Len: 4 FILE_SYNC
   77 2023-10-03 10:17:04.328371 192.168.1.106 =E2=86=92 192.168.1.134 TCP =
66
2049 =E2=86=92 909 [ACK] Seq=3D1113 Ack=3D1501 Win=3D31872 Len=3D0 TSval=3D=
3542359002
TSecr=3D3081600630
  256 2023-10-03 10:18:04.341041 192.168.1.134 =E2=86=92 192.168.1.106 TCP =
66
[TCP Keep-Alive] 909 =E2=86=92 2049 [ACK] Seq=3D1500 Ack=3D1113 Win=3D32000=
 Len=3D0
TSval=3D3081660681 TSecr=3D3542359002
  259 2023-10-03 10:18:04.341500 192.168.1.106 =E2=86=92 192.168.1.134 TCP =
54
2049 =E2=86=92 909 [RST] Seq=3D1113 Win=3D0 Len=3D0
  260 2023-10-03 10:18:04.341860 192.168.1.134 =E2=86=92 192.168.1.106 TCP =
74
[TCP Port numbers reused] 909 =E2=86=92 2049 [SYN] Seq=3D0 Win=3D32120 Len=
=3D0
MSS=3D1460 SACK_PERM TSval=3D3081660681 TSecr=3D0 WS=3D128
  261 2023-10-03 10:18:04.342031 192.168.1.106 =E2=86=92 192.168.1.134 TCP =
54
2049 =E2=86=92 909 [RST, ACK] Seq=3D1 Ack=3D1 Win=3D0 Len=3D0
  266 2023-10-03 10:18:07.380801 192.168.1.134 =E2=86=92 192.168.1.106 TCP =
74
954 =E2=86=92 2049 [SYN] Seq=3D0 Win=3D32120 Len=3D0 MSS=3D1460 SACK_PERM
TSval=3D3081663720 TSecr=3D0 WS=3D128
  267 2023-10-03 10:18:07.380971 192.168.1.106 =E2=86=92 192.168.1.134 TCP =
54
2049 =E2=86=92 954 [RST, ACK] Seq=3D1 Ack=3D1 Win=3D0 Len=3D0
  275 2023-10-03 10:18:10.423352 192.168.1.134 =E2=86=92 192.168.1.106 TCP =
74
856 =E2=86=92 2049 [SYN] Seq=3D0 Win=3D32120 Len=3D0 MSS=3D1460 SACK_PERM
TSval=3D3081666760 TSecr=3D0 WS=3D128
  276 2023-10-03 10:18:10.423621 192.168.1.106 =E2=86=92 192.168.1.134 TCP =
54
2049 =E2=86=92 856 [RST, ACK] Seq=3D1 Ack=3D1 Win=3D0 Len=3D0
  286 2023-10-03 10:18:13.466277 192.168.1.134 =E2=86=92 192.168.1.106 TCP =
74
957 =E2=86=92 2049 [SYN] Seq=3D0 Win=3D32120 Len=3D0 MSS=3D1460 SACK_PERM
TSval=3D3081669801 TSecr=3D0 WS=3D128
  287 2023-10-03 10:18:13.466812 192.168.1.106 =E2=86=92 192.168.1.134 TCP =
54
2049 =E2=86=92 957 [RST, ACK] Seq=3D1 Ack=3D1 Win=3D0 Len=3D0
  289 2023-10-03 10:18:16.509229 192.168.1.134 =E2=86=92 192.168.1.106 TCP =
74
695 =E2=86=92 2049 [SYN] Seq=3D0 Win=3D32120 Len=3D0 MSS=3D1460 SACK_PERM
TSval=3D3081672841 TSecr=3D0 WS=3D128
  290 2023-10-03 10:18:16.509845 192.168.1.106 =E2=86=92 192.168.1.134 TCP =
54
2049 =E2=86=92 695 [RST, ACK] Seq=3D1 Ack=3D1 Win=3D0 Len=3D0
  294 2023-10-03 10:18:19.551062 192.168.1.134 =E2=86=92 192.168.1.106 TCP =
74
940 =E2=86=92 2049 [SYN] Seq=3D0 Win=3D32120 Len=3D0 MSS=3D1460 SACK_PERM
TSval=3D3081675881 TSecr=3D0 WS=3D128
  295 2023-10-03 10:18:19.551434 192.168.1.106 =E2=86=92 192.168.1.134 TCP =
54
2049 =E2=86=92 940 [RST, ACK] Seq=3D1 Ack=3D1 Win=3D0 Len=3D0
  300 2023-10-03 10:18:22.590380 192.168.1.134 =E2=86=92 192.168.1.106 TCP =
74
810 =E2=86=92 2049 [SYN] Seq=3D0 Win=3D32120 Len=3D0 MSS=3D1460 SACK_PERM
TSval=3D3081678921 TSecr=3D0 WS=3D128
  301 2023-10-03 10:18:22.590726 192.168.1.106 =E2=86=92 192.168.1.134 TCP =
54
2049 =E2=86=92 810 [RST, ACK] Seq=3D1 Ack=3D1 Win=3D0 Len=3D0
  308 2023-10-03 10:18:25.628256 192.168.1.134 =E2=86=92 192.168.1.106 TCP =
74
877 =E2=86=92 2049 [SYN] Seq=3D0 Win=3D32120 Len=3D0 MSS=3D1460 SACK_PERM
TSval=3D3081681961 TSecr=3D0 WS=3D128
  309 2023-10-03 10:18:25.628724 192.168.1.106 =E2=86=92 192.168.1.134 TCP =
54
2049 =E2=86=92 877 [RST, ACK] Seq=3D1 Ack=3D1 Win=3D0 Len=3D0
  312 2023-10-03 10:18:28.665682 192.168.1.134 =E2=86=92 192.168.1.106 TCP =
74
934 =E2=86=92 2049 [SYN] Seq=3D0 Win=3D32120 Len=3D0 MSS=3D1460 SACK_PERM
TSval=3D3081685001 TSecr=3D0 WS=3D128
  313 2023-10-03 10:18:28.666374 192.168.1.106 =E2=86=92 192.168.1.134 TCP =
54
2049 =E2=86=92 934 [RST, ACK] Seq=3D1 Ack=3D1 Win=3D0 Len=3D0
  320 2023-10-03 10:18:31.702236 192.168.1.134 =E2=86=92 192.168.1.106 TCP =
74
803 =E2=86=92 2049 [SYN] Seq=3D0 Win=3D32120 Len=3D0 MSS=3D1460 SACK_PERM
TSval=3D3081688040 TSecr=3D0 WS=3D128
  321 2023-10-03 10:18:31.702490 192.168.1.106 =E2=86=92 192.168.1.134 TCP =
74
2049 =E2=86=92 803 [SYN, ACK] Seq=3D0 Ack=3D1 Win=3D31856 Len=3D0 MSS=3D146=
0 SACK_PERM
TSval=3D1993141756 TSecr=3D3081688040 WS=3D128
  322 2023-10-03 10:18:31.702729 192.168.1.134 =E2=86=92 192.168.1.106 TCP =
66
803 =E2=86=92 2049 [ACK] Seq=3D1 Ack=3D1 Win=3D32128 Len=3D0 TSval=3D308168=
8040
TSecr=3D1993141756
  323 2023-10-03 10:18:31.702737 192.168.1.134 =E2=86=92 192.168.1.106 NFS =
238
V3 WRITE Call, FH: 0x10bedd7c Offset: 0 Len: 4 FILE_SYNC
  324 2023-10-03 10:18:31.702893 192.168.1.106 =E2=86=92 192.168.1.134 TCP =
66
2049 =E2=86=92 803 [ACK] Seq=3D1 Ack=3D173 Win=3D31872 Len=3D0 TSval=3D1993=
141756
TSecr=3D3081688040
  749 2023-10-03 10:19:01.880214 192.168.1.106 =E2=86=92 192.168.1.134 NFS =
206
V3 WRITE Reply (Call In 323) Len: 4 FILE_SYNC
  750 2023-10-03 10:19:01.880616 192.168.1.134 =E2=86=92 192.168.1.106 TCP =
66
803 =E2=86=92 2049 [ACK] Seq=3D173 Ack=3D141 Win=3D32000 Len=3D0 TSval=3D30=
81718241
TSecr=3D1993171927


> SYNs. If the server is not replying to our SYN packets, then the TCP
> layer will back off and retransmit. So there is already a backoff-retry
> happening at that level.
>
> >
> > >
> > > >
> > > > >
> > > > > Signed-off-by: Trond Myklebust
> > > > > <trond.myklebust@hammerspace.com>
> > > > > ---
> > > > >  net/sunrpc/xprtsock.c | 10 +++++++++-
> > > > >  1 file changed, 9 insertions(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
> > > > > index 71848ab90d13..1a96777f0ed5 100644
> > > > > --- a/net/sunrpc/xprtsock.c
> > > > > +++ b/net/sunrpc/xprtsock.c
> > > > > @@ -62,6 +62,7 @@
> > > > >  #include "sunrpc.h"
> > > > >
> > > > >  static void xs_close(struct rpc_xprt *xprt);
> > > > > +static void xs_reset_srcport(struct sock_xprt *transport);
> > > > >  static void xs_set_srcport(struct sock_xprt *transport, struct
> > > > > socket *sock);
> > > > >  static void xs_tcp_set_socket_timeouts(struct rpc_xprt *xprt,
> > > > >                 struct socket *sock);
> > > > > @@ -1565,8 +1566,10 @@ static void xs_tcp_state_change(struct
> > > > > sock
> > > > > *sk)
> > > > >                 break;
> > > > >         case TCP_CLOSE:
> > > > >                 if (test_and_clear_bit(XPRT_SOCK_CONNECTING,
> > > > > -                                       &transport-
> > > > > >sock_state))
> > > > > +                                      &transport->sock_state))
> > > > > {
> > > > > +                       xs_reset_srcport(transport);
> > > > >                         xprt_clear_connecting(xprt);
> > > > > +               }
> > > > >                 clear_bit(XPRT_CLOSING, &xprt->state);
> > > > >                 /* Trigger the socket release */
> > > > >                 xs_run_error_worker(transport,
> > > > > XPRT_SOCK_WAKE_DISCONNECT);
> > > > > @@ -1722,6 +1725,11 @@ static void xs_set_port(struct rpc_xprt
> > > > > *xprt, unsigned short port)
> > > > >         xs_update_peer_port(xprt);
> > > > >  }
> > > > >
> > > > > +static void xs_reset_srcport(struct sock_xprt *transport)
> > > > > +{
> > > > > +       transport->srcport =3D 0;
> > > > > +}
> > > > > +
> > > > >  static void xs_set_srcport(struct sock_xprt *transport, struct
> > > > > socket *sock)
> > > > >  {
> > > > >         if (transport->srcport =3D=3D 0 && transport-
> > > > > >xprt.reuseport)
> > > > > --
> > > > > 2.41.0
> > > > >
> > >
> > > --
> > > Trond Myklebust Linux NFS client maintainer, Hammerspace
> > > trond.myklebust@hammerspace.com
>
> --
> Trond Myklebust
> Linux NFS client maintainer, Hammerspace
> trond.myklebust@hammerspace.com
>
>
