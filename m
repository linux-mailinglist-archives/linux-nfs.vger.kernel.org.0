Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 61D813D0E4
	for <lists+linux-nfs@lfdr.de>; Tue, 11 Jun 2019 17:34:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404992AbfFKPeT (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 11 Jun 2019 11:34:19 -0400
Received: from mail-vk1-f196.google.com ([209.85.221.196]:35678 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404969AbfFKPeT (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 11 Jun 2019 11:34:19 -0400
Received: by mail-vk1-f196.google.com with SMTP id k1so439882vkb.2
        for <linux-nfs@vger.kernel.org>; Tue, 11 Jun 2019 08:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=42QYYI3JveTLEx0q7oqCroV0N4RohHnezXX8GYmUdpA=;
        b=eEi2QwN/awuepOAvWNNofYqNEV4Iz+72fhhPx6W0Vt5wp63C4Cjz/nTRBum0rp60a2
         gpbpw9ejj9FcTmNXHXNeDe+Y0tTI9juNoXEMyd1Hw6hqJbmvVpSwnioDeDVyWDlxlm1i
         z5ECKyCSLe3YUVSTy0lb+MTgXRAIzG3tzVfNgt+9sOhSYV/4p1tOFbdwnozbm9+gvpFI
         VniQFL2eNIJF83MtnK9OcFtzcw9JaZ4qL1Dd1SlcOgrEFYwL9T7ZeMjMCxPhgDYE5LxG
         sTqLALP1bhd8v4HdydkpatLHky5CpkA100jIU8s5Nz8qYlkpvRRBwrjP4TduIRK77+oC
         CRoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=42QYYI3JveTLEx0q7oqCroV0N4RohHnezXX8GYmUdpA=;
        b=IW4CyBRJToZF9lIYTVhAjkg9nTwJHVrpzD0qEnZo0jIQBD3r9yOjX4brWqmjPor23p
         y8EJipm69hfAjphJosVj48mUmLufBwbtbUe6iKNAUhkoqFjPvUZ1wbwKDJYzrLRoDQHD
         0CE8b+EmgtMgpKAYXr9+ey1a6omXp5bzeoUGaFb9HHGdb8s+k9CdpFigknTaC4VOXm1B
         F/Oqy2yKSDZ+w8flPMvCO/CGGQwXTxwRW8lynWIfmdEEWs1Iuz0ySy0sT4zl6LpHIWTw
         6J0Iaepp9PdvxrDkZjKLYlbV1hmIGk40+xLx5rMvLYYdk60EPfL+IeU8Ifbc5aM8FfVx
         uHCA==
X-Gm-Message-State: APjAAAWwKyxJUXBisx6YfxRBdO+QrfPK8vgqVLcgDcjS7X3wiu26mbnM
        Bx6s2sPFE6/TQ1MMPYeFsTLjOvt0Gr3TP45dS9g=
X-Google-Smtp-Source: APXvYqzqfkJbURRKYn5Je9HYDpYy2jWOqLHQtApVj1omFGyTMhKUczBGCq7lA+ccFU0tdnprmoTQISHmHcLVmXOBiYg=
X-Received: by 2002:a1f:a043:: with SMTP id j64mr7664865vke.87.1560267257562;
 Tue, 11 Jun 2019 08:34:17 -0700 (PDT)
MIME-Version: 1.0
References: <155917564898.3988.6096672032831115016.stgit@noble.brown>
 <001DED71-0E0D-46B1-BA34-84E6ACCBB79F@oracle.com> <87muj3tuuk.fsf@notabene.neil.brown.name>
 <4316E30B-1BD7-4F0E-8375-03E9F85FFD2B@oracle.com> <87lfy9vsgf.fsf@notabene.neil.brown.name>
 <3B887552-91FB-493A-8FDF-411562811B36@oracle.com>
In-Reply-To: <3B887552-91FB-493A-8FDF-411562811B36@oracle.com>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Tue, 11 Jun 2019 11:34:06 -0400
Message-ID: <CAN-5tyEdu7poNWrKtOyic6GgQcjAPZhB5BJeQ7JMSfmgMx8b+g@mail.gmail.com>
Subject: Re: [PATCH 0/9] Multiple network connections for a single NFS mount.
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     NeilBrown <neilb@suse.com>,
        Anna Schumaker <Anna.Schumaker@netapp.com>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Jun 11, 2019 at 10:52 AM Chuck Lever <chuck.lever@oracle.com> wrote=
:
>
> Hi Neil-
>
>
> > On Jun 10, 2019, at 9:09 PM, NeilBrown <neilb@suse.com> wrote:
> >
> > On Fri, May 31 2019, Chuck Lever wrote:
> >
> >>> On May 30, 2019, at 6:56 PM, NeilBrown <neilb@suse.com> wrote:
> >>>
> >>> On Thu, May 30 2019, Chuck Lever wrote:
> >>>
> >>>> Hi Neil-
> >>>>
> >>>> Thanks for chasing this a little further.
> >>>>
> >>>>
> >>>>> On May 29, 2019, at 8:41 PM, NeilBrown <neilb@suse.com> wrote:
> >>>>>
> >>>>> This patch set is based on the patches in the multipath_tcp branch =
of
> >>>>> git://git.linux-nfs.org/projects/trondmy/nfs-2.6.git
> >>>>>
> >>>>> I'd like to add my voice to those supporting this work and wanting =
to
> >>>>> see it land.
> >>>>> We have had customers/partners wanting this sort of functionality f=
or
> >>>>> years.  In SLES releases prior to SLE15, we've provide a
> >>>>> "nosharetransport" mount option, so that several filesystem could b=
e
> >>>>> mounted from the same server and each would get its own TCP
> >>>>> connection.
> >>>>
> >>>> Is it well understood why splitting up the TCP connections result
> >>>> in better performance?
> >>>>
> >>>>
> >>>>> In SLE15 we are using this 'nconnect' feature, which is much nicer.
> >>>>>
> >>>>> Partners have assured us that it improves total throughput,
> >>>>> particularly with bonded networks, but we haven't had any concrete
> >>>>> data until Olga Kornievskaia provided some concrete test data - tha=
nks
> >>>>> Olga!
> >>>>>
> >>>>> My understanding, as I explain in one of the patches, is that paral=
lel
> >>>>> hardware is normally utilized by distributing flows, rather than
> >>>>> packets.  This avoid out-of-order deliver of packets in a flow.
> >>>>> So multiple flows are needed to utilizes parallel hardware.
> >>>>
> >>>> Indeed.
> >>>>
> >>>> However I think one of the problems is what happens in simpler scena=
rios.
> >>>> We had reports that using nconnect > 1 on virtual clients made thing=
s
> >>>> go slower. It's not always wise to establish multiple connections
> >>>> between the same two IP addresses. It depends on the hardware on eac=
h
> >>>> end, and the network conditions.
> >>>
> >>> This is a good argument for leaving the default at '1'.  When
> >>> documentation is added to nfs(5), we can make it clear that the optim=
al
> >>> number is dependant on hardware.
> >>
> >> Is there any visibility into the NIC hardware that can guide this sett=
ing?
> >>
> >
> > I doubt it, partly because there is more than just the NIC hardware at =
issue.
> > There is also the server-side hardware and possibly hardware in the mid=
dle.
>
> So the best guidance is YMMV. :-)
>
>
> >>>> What about situations where the network capabilities between server =
and
> >>>> client change? Problem is that neither endpoint can detect that; TCP
> >>>> usually just deals with it.
> >>>
> >>> Being able to manually change (-o remount) the number of connections
> >>> might be useful...
> >>
> >> Ugh. I have problems with the administrative interface for this featur=
e,
> >> and this is one of them.
> >>
> >> Another is what prevents your client from using a different nconnect=
=3D
> >> setting on concurrent mounts of the same server? It's another case of =
a
> >> per-mount setting being used to control a resource that is shared acro=
ss
> >> mounts.
> >
> > I think that horse has well and truly bolted.
> > It would be nice to have a "server" abstraction visible to user-space
> > where we could adjust settings that make sense server-wide, and then a =
way
> > to mount individual filesystems from that "server" - but we don't.
>
> Even worse, there will be some resource sharing between containers that
> might be undesirable. The host should have ultimate control over those
> resources.
>
> But that is neither here nor there.
>
>
> > Probably the best we can do is to document (in nfs(5)) which options ar=
e
> > per-server and which are per-mount.
>
> Alternately, the behavior of this option could be documented this way:
>
> The default value is one. To resolve conflicts between nconnect settings =
on
> different mount points to the same server, the value set on the first mou=
nt
> applies until there are no more mounts of that server, unless nosharecach=
e
> is specified. When following a referral to another server, the nconnect
> setting is inherited, but the effective value is determined by other moun=
ts
> of that server that are already in place.
>
> I hate to say it, but the way to make this work deterministically is to
> ask administrators to ensure that the setting is the same on all mounts
> of the same server. Again I'd rather this take care of itself, but it
> appears that is not going to be possible.
>
>
> >> Adding user tunables has never been known to increase the aggregate
> >> amount of happiness in the universe. I really hope we can come up with
> >> a better administrative interface... ideally, none would be best.
> >
> > I agree that none would be best.  It isn't clear to me that that is
> > possible.
> > At present, we really don't have enough experience with this
> > functionality to be able to say what the trade-offs are.
> > If we delay the functionality until we have the perfect interface,
> > we may never get that experience.
> >
> > We can document "nconnect=3D" as a hint, and possibly add that
> > "nconnect=3D1" is a firm guarantee that more will not be used.
>
> Agree that 1 should be the default. If we make this setting a
> hint, then perhaps it should be renamed; nconnect makes it sound
> like the client will always open N connections. How about "maxconn" ?

"maxconn" sounds to me like it's possible that the code would choose a
number that's less than that which I think would be misleading given
that the implementation (as is now) will open the specified number of
connection (bounded by the hard coded default we currently have set at
some value X which I'm in favor is increasing from 16 to 32).

> Then, to better define the behavior:
>
> The range of valid maxconn values is 1 to 3? to 8? to NCPUS? to the
> count of the client=E2=80=99s NUMA nodes? I=E2=80=99d be in favor of a sm=
all number
> to start with. Solaris' experience with multiple connections is that
> there is very little benefit past 8.

My linux to linux experience has been that there is benefit of having
more than 8 connections. I have previously posted results that went
upto 10 connection (it's on my list of thing to test uptown 16). With
the Netapp performance lab they have maxed out 25G connection setup
they were using with so they didn't experiment with nconnect=3D8 but no
evidence that with a larger network pipe performance would stop
improving.

Given the existing performance studies, I would like to argue that
having such low values are not warranted.

> If maxconn is specified with a datagram transport, does the mount
> operation fail, or is the setting is ignored?

Perhaps we can add a warning on the mount command saying that option
is ignored but succeed the mount.

> If maxconn is a hint, when does the client open additional
> connections?
>
> IMO documentation should be clear that this setting is not for the
> purpose of multipathing/trunking (using multiple NICs on the client
> or server). The client has to do trunking detection/discovery in that
> case, and nconnect doesn't add that logic. This is strictly for
> enabling multiple connections between one client-server IP address
> pair.

I agree this should be as that last statement says multiple connection
to the same IP and in my option this shouldn't be a hint.

> Do we need to state explicitly that all transport connections for a
> mount (or client-server pair) are the same connection type (i.e., all
> TCP or all RDMA, never a mix)?

That might be an interesting future option but I think for now, we can
clearly say it's a TCP only option in documentation which can always
be changed if extension to that functionality will be implemented.

> > Then further down the track, we might change the actual number of
> > connections automatically if a way can be found to do that without cost=
.
>
> Fair enough.
>
>
> > Do you have any objections apart from the nconnect=3D mount option?
>
> Well I realize my last e-mail sounded a little negative, but I'm
> actually in favor of adding the ability to open multiple connections
> per client-server pair. I just want to be careful about making this
> a feature that has as few downsides as possible right from the start.
> I'll try to be more helpful in my responses.
>
> Remaining implementation issues that IMO need to be sorted:

I'm curious are you saying all this need to be resolved before we
consider including this functionality? These are excellent questions
but I think they imply some complex enhancements (like ability to do
different schedulers and not only round robin) that are "enhancement"
and not requirements.

> =E2=80=A2 We want to take care that the client can recover network resour=
ces
> that have gone idle. Can we reuse the auto-close logic to close extra
> connections?
Since we are using round-robin scheduler then can we consider any
resources going idle? It's hard to know the future, we might set a
timer after which we can say that a connection has been idle for long
enough time and we close it and as soon as that happens the traffic is
going to be generated again and we'll have to pay the penalty of
establishing a new connection before sending traffic.

> =E2=80=A2 How will the client schedule requests on multiple connections?
> Should we enable the use of different schedulers?
That's an interesting idea but I don't think it shouldn't stop the
round robin solution from going thru.

> =E2=80=A2 How will retransmits be handled?
> =E2=80=A2 How will the client recover from broken connections? Today's cl=
ients
> use disconnect to determine when to retransmit, thus there might be
> some unwanted interactions here that result in mount hangs.
> =E2=80=A2 Assume NFSv4.1 session ID rather than client ID trunking: is Li=
nux
> client support in place for this already?
> =E2=80=A2 Are there any concerns about how the Linux server DRC will beha=
ve in
> multi-connection scenarios?

I think we've talked about retransmission question. Retransmission are
handled by existing logic and are done by the same transport (ie
connection).

> None of these seem like a deal breaker. And possibly several of these
> are already decided, but just need to be published/documented.
>
>
> --
> Chuck Lever
>
>
>
