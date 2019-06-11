Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 58E6B416B3
	for <lists+linux-nfs@lfdr.de>; Tue, 11 Jun 2019 23:10:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406800AbfFKVKn (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 11 Jun 2019 17:10:43 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:35469 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406681AbfFKVKn (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 11 Jun 2019 17:10:43 -0400
Received: by mail-ua1-f68.google.com with SMTP id r7so5106308ual.2
        for <linux-nfs@vger.kernel.org>; Tue, 11 Jun 2019 14:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Wv3wDqeFiVLspxRsuUlp1owtnq3Yo1Z1IcDT6AQYgqM=;
        b=JSOLICXC53bQoR4mT04DxVD3PlNg3UoqtwboWLm3hERekq7APfFHZNif0rNrBDtyUr
         xRzsNfPEOEZj/abhf8Ezrwg3xpGDzh7H8QSP/IP5uWQhV3CVBZswd5ZFNH1dZaHmjlwY
         eHe/Az/MTq4aLLQP+61Rj77EcJkxvsSP+wLUvf0zEGt9fkBK89BgXWATiyx38+FV9Cef
         c0qfeuWLU0geRbQV/j835AcPxaSAfDamLrgZ7gEKeRyhqxd9eMVdsYfssDG+hP3SlXM7
         5JETCaIRBFFGu9NGDZ82JeRcXSKQx72M6SvquZBddwAuKdPSNEw27ED9hGzgWDb4maX3
         6Kjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Wv3wDqeFiVLspxRsuUlp1owtnq3Yo1Z1IcDT6AQYgqM=;
        b=iXmzXD64xeBod1jW1YzIuED0mWgrrLfHQ6kNF9QjxwF6BqvO3gd9WYX5NOwrEXIwrx
         rrur+ghNJBZ9PsYh5Iz1+DnjQo0LUeSqgO7MR4Ue28b8uOdVTyPbuX+Wme+X0K8YjlnO
         KUyPy91ttygsnEcI37xnrGTkRPm5nW1J5n7uT+Y9BgMOvVBC49H/O+vw04txSvivErL5
         HUW+xtx9PH71iAiCEGbEZWVvqVgMcP2Gf9ZQtc/HjSpR8LMUCplrCWd+pXaq0MMNVi2H
         ++tk7nz+Ay6g0VscTdD8vc3Os8GZ+50vuqGhC+5gcPFcPJ7WPSao3yrSdbp6Ba8odM6t
         rq+w==
X-Gm-Message-State: APjAAAXhxQ28WUfrLq3gd/sP6Jc4M0SFjZMUKH3AcxRJOFkhk1njcztR
        cs3MpKSE/e2N2EjI5Kt+ZKF7KUgfODi3YI0K/vsBpkiS
X-Google-Smtp-Source: APXvYqwyhcwyeCSvl63ulENegwQpEoEYx6acr9W/oZGrjMEaU9tq4NWOifO0ttqWoMP9aoPxJ4u0Wm8ZmEavb6mrPj8=
X-Received: by 2002:a9f:3045:: with SMTP id i5mr40700253uab.81.1560287441319;
 Tue, 11 Jun 2019 14:10:41 -0700 (PDT)
MIME-Version: 1.0
References: <155917564898.3988.6096672032831115016.stgit@noble.brown>
 <001DED71-0E0D-46B1-BA34-84E6ACCBB79F@oracle.com> <87muj3tuuk.fsf@notabene.neil.brown.name>
 <4316E30B-1BD7-4F0E-8375-03E9F85FFD2B@oracle.com> <87lfy9vsgf.fsf@notabene.neil.brown.name>
 <3B887552-91FB-493A-8FDF-411562811B36@oracle.com> <CAN-5tyEdu7poNWrKtOyic6GgQcjAPZhB5BJeQ7JMSfmgMx8b+g@mail.gmail.com>
 <16D30334-67BE-4BD2-BE69-1453F738B259@oracle.com> <CAN-5tyHQz4kyGqAea3hTW0GKRBtkkB5UeE6THz-7uMmadJygyg@mail.gmail.com>
 <ac631f3c-af1a-6877-08b6-21ddf71edff2@talpey.com> <A74B7E29-CAC7-428B-8B29-606F4B174D1A@oracle.com>
In-Reply-To: <A74B7E29-CAC7-428B-8B29-606F4B174D1A@oracle.com>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Tue, 11 Jun 2019 17:10:30 -0400
Message-ID: <CAN-5tyFP9qK9Tjv-FCeZJGMnhhnsZh0+VCguuRaDOG2kB9A-OQ@mail.gmail.com>
Subject: Re: [PATCH 0/9] Multiple network connections for a single NFS mount.
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     Tom Talpey <tom@talpey.com>, NeilBrown <neilb@suse.com>,
        Anna Schumaker <Anna.Schumaker@netapp.com>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Jun 11, 2019 at 4:09 PM Chuck Lever <chuck.lever@oracle.com> wrote:
>
>
>
> > On Jun 11, 2019, at 4:02 PM, Tom Talpey <tom@talpey.com> wrote:
> >
> > On 6/11/2019 3:13 PM, Olga Kornievskaia wrote:
> >> On Tue, Jun 11, 2019 at 1:47 PM Chuck Lever <chuck.lever@oracle.com> w=
rote:
> >>>
> >>>
> >>>
> >>>> On Jun 11, 2019, at 11:34 AM, Olga Kornievskaia <aglo@umich.edu> wro=
te:
> >>>>
> >>>> On Tue, Jun 11, 2019 at 10:52 AM Chuck Lever <chuck.lever@oracle.com=
> wrote:
> >>>>>
> >>>>> Hi Neil-
> >>>>>
> >>>>>
> >>>>>> On Jun 10, 2019, at 9:09 PM, NeilBrown <neilb@suse.com> wrote:
> >>>>>>
> >>>>>> On Fri, May 31 2019, Chuck Lever wrote:
> >>>>>>
> >>>>>>>> On May 30, 2019, at 6:56 PM, NeilBrown <neilb@suse.com> wrote:
> >>>>>>>>
> >>>>>>>> On Thu, May 30 2019, Chuck Lever wrote:
> >>>>>>>>
> >>>>>>>>> Hi Neil-
> >>>>>>>>>
> >>>>>>>>> Thanks for chasing this a little further.
> >>>>>>>>>
> >>>>>>>>>
> >>>>>>>>>> On May 29, 2019, at 8:41 PM, NeilBrown <neilb@suse.com> wrote:
> >>>>>>>>>>
> >>>>>>>>>> This patch set is based on the patches in the multipath_tcp br=
anch of
> >>>>>>>>>> git://git.linux-nfs.org/projects/trondmy/nfs-2.6.git
> >>>>>>>>>>
> >>>>>>>>>> I'd like to add my voice to those supporting this work and wan=
ting to
> >>>>>>>>>> see it land.
> >>>>>>>>>> We have had customers/partners wanting this sort of functional=
ity for
> >>>>>>>>>> years.  In SLES releases prior to SLE15, we've provide a
> >>>>>>>>>> "nosharetransport" mount option, so that several filesystem co=
uld be
> >>>>>>>>>> mounted from the same server and each would get its own TCP
> >>>>>>>>>> connection.
> >>>>>>>>>
> >>>>>>>>> Is it well understood why splitting up the TCP connections resu=
lt
> >>>>>>>>> in better performance?
> >>>>>>>>>
> >>>>>>>>>
> >>>>>>>>>> In SLE15 we are using this 'nconnect' feature, which is much n=
icer.
> >>>>>>>>>>
> >>>>>>>>>> Partners have assured us that it improves total throughput,
> >>>>>>>>>> particularly with bonded networks, but we haven't had any conc=
rete
> >>>>>>>>>> data until Olga Kornievskaia provided some concrete test data =
- thanks
> >>>>>>>>>> Olga!
> >>>>>>>>>>
> >>>>>>>>>> My understanding, as I explain in one of the patches, is that =
parallel
> >>>>>>>>>> hardware is normally utilized by distributing flows, rather th=
an
> >>>>>>>>>> packets.  This avoid out-of-order deliver of packets in a flow=
.
> >>>>>>>>>> So multiple flows are needed to utilizes parallel hardware.
> >>>>>>>>>
> >>>>>>>>> Indeed.
> >>>>>>>>>
> >>>>>>>>> However I think one of the problems is what happens in simpler =
scenarios.
> >>>>>>>>> We had reports that using nconnect > 1 on virtual clients made =
things
> >>>>>>>>> go slower. It's not always wise to establish multiple connectio=
ns
> >>>>>>>>> between the same two IP addresses. It depends on the hardware o=
n each
> >>>>>>>>> end, and the network conditions.
> >>>>>>>>
> >>>>>>>> This is a good argument for leaving the default at '1'.  When
> >>>>>>>> documentation is added to nfs(5), we can make it clear that the =
optimal
> >>>>>>>> number is dependant on hardware.
> >>>>>>>
> >>>>>>> Is there any visibility into the NIC hardware that can guide this=
 setting?
> >>>>>>>
> >>>>>>
> >>>>>> I doubt it, partly because there is more than just the NIC hardwar=
e at issue.
> >>>>>> There is also the server-side hardware and possibly hardware in th=
e middle.
> >>>>>
> >>>>> So the best guidance is YMMV. :-)
> >>>>>
> >>>>>
> >>>>>>>>> What about situations where the network capabilities between se=
rver and
> >>>>>>>>> client change? Problem is that neither endpoint can detect that=
; TCP
> >>>>>>>>> usually just deals with it.
> >>>>>>>>
> >>>>>>>> Being able to manually change (-o remount) the number of connect=
ions
> >>>>>>>> might be useful...
> >>>>>>>
> >>>>>>> Ugh. I have problems with the administrative interface for this f=
eature,
> >>>>>>> and this is one of them.
> >>>>>>>
> >>>>>>> Another is what prevents your client from using a different nconn=
ect=3D
> >>>>>>> setting on concurrent mounts of the same server? It's another cas=
e of a
> >>>>>>> per-mount setting being used to control a resource that is shared=
 across
> >>>>>>> mounts.
> >>>>>>
> >>>>>> I think that horse has well and truly bolted.
> >>>>>> It would be nice to have a "server" abstraction visible to user-sp=
ace
> >>>>>> where we could adjust settings that make sense server-wide, and th=
en a way
> >>>>>> to mount individual filesystems from that "server" - but we don't.
> >>>>>
> >>>>> Even worse, there will be some resource sharing between containers =
that
> >>>>> might be undesirable. The host should have ultimate control over th=
ose
> >>>>> resources.
> >>>>>
> >>>>> But that is neither here nor there.
> >>>>>
> >>>>>
> >>>>>> Probably the best we can do is to document (in nfs(5)) which optio=
ns are
> >>>>>> per-server and which are per-mount.
> >>>>>
> >>>>> Alternately, the behavior of this option could be documented this w=
ay:
> >>>>>
> >>>>> The default value is one. To resolve conflicts between nconnect set=
tings on
> >>>>> different mount points to the same server, the value set on the fir=
st mount
> >>>>> applies until there are no more mounts of that server, unless nosha=
recache
> >>>>> is specified. When following a referral to another server, the ncon=
nect
> >>>>> setting is inherited, but the effective value is determined by othe=
r mounts
> >>>>> of that server that are already in place.
> >>>>>
> >>>>> I hate to say it, but the way to make this work deterministically i=
s to
> >>>>> ask administrators to ensure that the setting is the same on all mo=
unts
> >>>>> of the same server. Again I'd rather this take care of itself, but =
it
> >>>>> appears that is not going to be possible.
> >>>>>
> >>>>>
> >>>>>>> Adding user tunables has never been known to increase the aggrega=
te
> >>>>>>> amount of happiness in the universe. I really hope we can come up=
 with
> >>>>>>> a better administrative interface... ideally, none would be best.
> >>>>>>
> >>>>>> I agree that none would be best.  It isn't clear to me that that i=
s
> >>>>>> possible.
> >>>>>> At present, we really don't have enough experience with this
> >>>>>> functionality to be able to say what the trade-offs are.
> >>>>>> If we delay the functionality until we have the perfect interface,
> >>>>>> we may never get that experience.
> >>>>>>
> >>>>>> We can document "nconnect=3D" as a hint, and possibly add that
> >>>>>> "nconnect=3D1" is a firm guarantee that more will not be used.
> >>>>>
> >>>>> Agree that 1 should be the default. If we make this setting a
> >>>>> hint, then perhaps it should be renamed; nconnect makes it sound
> >>>>> like the client will always open N connections. How about "maxconn"=
 ?
> >>>>
> >>>> "maxconn" sounds to me like it's possible that the code would choose=
 a
> >>>> number that's less than that which I think would be misleading given
> >>>> that the implementation (as is now) will open the specified number o=
f
> >>>> connection (bounded by the hard coded default we currently have set =
at
> >>>> some value X which I'm in favor is increasing from 16 to 32).
> >>>
> >>> Earlier in this thread, Neil proposed to make nconnect a hint. Sounds
> >>> like the long term plan is to allow "up to N" connections with some
> >>> mechanism to create new connections on-demand." maxconn fits that ide=
a
> >>> better, though I'd prefer no new mount options... the point being tha=
t
> >>> eventually, this setting is likely to be an upper bound rather than a
> >>> fixed value.
> >> Fair enough. If the dynamic connection management is in the cards,
> >> then "maxconn" would be an appropriate name but I also agree with you
> >> that if we are doing dynamic management then we shouldn't need a mount
> >> option at all. I, for one, am skeptical that we'll gain benefits from
> >> dynamic connection management given that cost of tearing and starting
> >> the new connection.
> >> I would argue that since now no dynamic management is implemented then
> >> we stay with the "nconnect" mount option and if and when such feature
> >> is found desirable then we get rid of the mount option all together.
> >>>>> Then, to better define the behavior:
> >>>>>
> >>>>> The range of valid maxconn values is 1 to 3? to 8? to NCPUS? to the
> >>>>> count of the client=E2=80=99s NUMA nodes? I=E2=80=99d be in favor o=
f a small number
> >>>>> to start with. Solaris' experience with multiple connections is tha=
t
> >>>>> there is very little benefit past 8.
> >>>>
> >>>> My linux to linux experience has been that there is benefit of havin=
g
> >>>> more than 8 connections. I have previously posted results that went
> >>>> upto 10 connection (it's on my list of thing to test uptown 16). Wit=
h
> >>>> the Netapp performance lab they have maxed out 25G connection setup
> >>>> they were using with so they didn't experiment with nconnect=3D8 but=
 no
> >>>> evidence that with a larger network pipe performance would stop
> >>>> improving.
> >>>>
> >>>> Given the existing performance studies, I would like to argue that
> >>>> having such low values are not warranted.
> >>>
> >>> They are warranted until we have a better handle on the risks of a
> >>> performance regression occurring with large nconnect settings. The
> >>> maximum number can always be raised once we are confident the
> >>> behaviors are well understood.
> >>>
> >>> Also, I'd like to see some careful studies that demonstrate why
> >>> you don't see excellent results with just two or three connections.
> >>> Nearly full link bandwidth has been achieved with MP-TCP and two or
> >>> three subflows on one NIC. Why is it not possible with NFS/TCP ?
> >> Performance tests that do simple buffer to buffer measurements are one
> >> thing but doing a complicated system that involves a filesystem is
> >> another thing. The closest we can get to this network performance
> >> tests is NFSoRDMA which saves various copies and as you know with that
> >> we can get close to network link capacity.
>
> Yes, in certain circumstances, but there are still areas that can
> benefit or need substantial improvement (NFS WRITE performance is
> one such area).
>
>
> > I really hope nconnect is not just a workaround for some undiscovered
> > performance issue. All that does is kick the can down the road.
> >
> > But a word of experience from SMB3 multichannel - more connections also
> > bring more issues for customers. Inevitably, with many connections
> > active under load, one or more will experience disconnects or slowdowns=
.
> > When this happens, some very unpredictable and hard to diagnose
> > behaviors start to occur. For example, all that careful load balancing
> > immediately goes out the window, and retries start to take over the
> > latencies. Some IOs sail through (the ones on the good connections) and
> > others delay for many seconds (while the connection is reestablished).
> > I don't recommend starting this effort with such a lofty goal as 8, 10
> > or 16 connections, especially with a protocol such as NFSv3.
>
> +1
>
> Learn to crawl then walk then run.

Neil,

What's your experience with providing "nosharedtransport" option to
the SLE customers? Were you are having customers coming back and
complain about the multiple connections issues?

When the connection is having issues, because we have to retransmit
from the same port, there isn't anything to be done but wait for the
new connection to be established and add to the latency of the
operation over the bad connection. There could be smarts added to the
(new) scheduler to grade the connections and if connection is having
issues not assign tasks to it until it recovers but all that are
additional improvement and I don't think we should restrict
connections right of the bet. This is an option that allows for 8, 10,
16 (32) connections but it doesn't mean customer have to set such high
value and we can recommend for low values.

Solaris has it, Microsoft has it and linux has been deprived of it,
let's join the party.


>
>
> > JMHO.
> >
> > Tom.
> >
> >
> >>>>> If maxconn is specified with a datagram transport, does the mount
> >>>>> operation fail, or is the setting is ignored?
> >>>>
> >>>> Perhaps we can add a warning on the mount command saying that option
> >>>> is ignored but succeed the mount.
> >>>>
> >>>>> If maxconn is a hint, when does the client open additional
> >>>>> connections?
> >>>>>
> >>>>> IMO documentation should be clear that this setting is not for the
> >>>>> purpose of multipathing/trunking (using multiple NICs on the client
> >>>>> or server). The client has to do trunking detection/discovery in th=
at
> >>>>> case, and nconnect doesn't add that logic. This is strictly for
> >>>>> enabling multiple connections between one client-server IP address
> >>>>> pair.
> >>>>
> >>>> I agree this should be as that last statement says multiple connecti=
on
> >>>> to the same IP and in my option this shouldn't be a hint.
> >>>>
> >>>>> Do we need to state explicitly that all transport connections for a
> >>>>> mount (or client-server pair) are the same connection type (i.e., a=
ll
> >>>>> TCP or all RDMA, never a mix)?
> >>>>
> >>>> That might be an interesting future option but I think for now, we c=
an
> >>>> clearly say it's a TCP only option in documentation which can always
> >>>> be changed if extension to that functionality will be implemented.
> >>>
> >>> Is there a reason you feel RDMA shouldn't be included? I've tried
> >>> nconnect with my RDMA rig, and didn't see any problem with it.
> >> No reason, I should have said "a single type of a connection only
> >> option" not a mix. Of course with RDMA even with a single connection
> >> we can achieve almost max bandwidth so having using nconnect seems
> >> unnecessary.
> >>>>>> Then further down the track, we might change the actual number of
> >>>>>> connections automatically if a way can be found to do that without=
 cost.
> >>>>>
> >>>>> Fair enough.
> >>>>>
> >>>>>
> >>>>>> Do you have any objections apart from the nconnect=3D mount option=
?
> >>>>>
> >>>>> Well I realize my last e-mail sounded a little negative, but I'm
> >>>>> actually in favor of adding the ability to open multiple connection=
s
> >>>>> per client-server pair. I just want to be careful about making this
> >>>>> a feature that has as few downsides as possible right from the star=
t.
> >>>>> I'll try to be more helpful in my responses.
> >>>>>
> >>>>> Remaining implementation issues that IMO need to be sorted:
> >>>>
> >>>> I'm curious are you saying all this need to be resolved before we
> >>>> consider including this functionality? These are excellent questions
> >>>> but I think they imply some complex enhancements (like ability to do
> >>>> different schedulers and not only round robin) that are "enhancement=
"
> >>>> and not requirements.
> >>>>
> >>>>> =E2=80=A2 We want to take care that the client can recover network =
resources
> >>>>> that have gone idle. Can we reuse the auto-close logic to close ext=
ra
> >>>>> connections?
> >>>> Since we are using round-robin scheduler then can we consider any
> >>>> resources going idle?
> >>>
> >>> Again, I was thinking of nconnect as a hint here, not as a fixed
> >>> number of connections.
> >>>
> >>>
> >>>> It's hard to know the future, we might set a
> >>>> timer after which we can say that a connection has been idle for lon=
g
> >>>> enough time and we close it and as soon as that happens the traffic =
is
> >>>> going to be generated again and we'll have to pay the penalty of
> >>>> establishing a new connection before sending traffic.
> >>>>
> >>>>> =E2=80=A2 How will the client schedule requests on multiple connect=
ions?
> >>>>> Should we enable the use of different schedulers?
> >>>> That's an interesting idea but I don't think it shouldn't stop the
> >>>> round robin solution from going thru.
> >>>>
> >>>>> =E2=80=A2 How will retransmits be handled?
> >>>>> =E2=80=A2 How will the client recover from broken connections? Toda=
y's clients
> >>>>> use disconnect to determine when to retransmit, thus there might be
> >>>>> some unwanted interactions here that result in mount hangs.
> >>>>> =E2=80=A2 Assume NFSv4.1 session ID rather than client ID trunking:=
 is Linux
> >>>>> client support in place for this already?
> >>>>> =E2=80=A2 Are there any concerns about how the Linux server DRC wil=
l behave in
> >>>>> multi-connection scenarios?
> >>>>
> >>>> I think we've talked about retransmission question. Retransmission a=
re
> >>>> handled by existing logic and are done by the same transport (ie
> >>>> connection).
> >>>
> >>> Given the proposition that nconnect will be a hint (eventually) in
> >>> the form of a dynamically managed set of connections, I think we need
> >>> to answer some of these questions again. The answers could be "not
> >>> yet implemented" or "no way jose".
> >>>
> >>> It would be helpful if the answers were all in one place (eg a design
> >>> document or FAQ).
> >>>
> >>>
> >>>>> None of these seem like a deal breaker. And possibly several of the=
se
> >>>>> are already decided, but just need to be published/documented.
> >>>>>
> >>>>>
> >>>>> --
> >>>>> Chuck Lever
> >>>
> >>> --
> >>> Chuck Lever
>
> --
> Chuck Lever
>
>
>
