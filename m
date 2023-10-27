Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C5817D9C4F
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Oct 2023 16:56:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346139AbjJ0O4M (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 27 Oct 2023 10:56:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345845AbjJ0O4I (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 27 Oct 2023 10:56:08 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 581FE196
        for <linux-nfs@vger.kernel.org>; Fri, 27 Oct 2023 07:56:03 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2c52289e900so5829131fa.0
        for <linux-nfs@vger.kernel.org>; Fri, 27 Oct 2023 07:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1698418561; x=1699023361; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g5q0HKX913hycNFNiXd7nZuwMCJAm+YvrOZ3LGGTdhM=;
        b=nGf6FtkaC5fGnMorEeTto+CJv6IAcQTTguupatAxU8Jo5bue2mjscl0RLU27baVQWM
         nNE3ZjgclxRQh4fnUwSuPfc/BWzphasASNKgZtAv7NLm5i81wZP2td2hcjjiAbzb8vMp
         pibhyty380zpIqzOtC8Os4SFB5Oo9z1Ci//voQ9H9uIHF2nayBD3JqeQXlApHLCV4Tfe
         4Ys3AzYUt1/d/nsvDjQKnU9WaczDg51SiF9V5y5YhL5tKP7GFbQ/QCnneP6RBhyrRkfo
         q9OGhJ+F1QhWQJRDgNR9GaNwGNYgAUYb4rWXysb0uLbD/O6iAb3nxq1iiV3FAtAxjF5Q
         fqtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698418561; x=1699023361;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g5q0HKX913hycNFNiXd7nZuwMCJAm+YvrOZ3LGGTdhM=;
        b=DEHQxk1tpu+rMhwQnibMYcvhLfoDuJN3q4v9SZAZXnnliz1a98TzWr5X6If3ubzVRb
         Q23jpuMMjjH65VpIXgNaaNddREkqqP7gojPEdq7ZChCnwE44WLljoXauf4DwxhS68bIj
         Q5CxiYUr12Qqyzn0/YDgf00QglAVaw7vbCUvTh0VvFtOhVJq2rHopRhzMxnSlxKOLAbX
         EcEBWoFuXwiRaqnSG22PewrbizmqJLaX0c0K0AOWMYvhoX7WE7pZO7OeExEZM8nxsKOU
         jzMQiOe4Ti4WkOGyL6u6++wAXEr+V5dloZ0Qd4e0+p6tDrdh31QOBSrpzEOxbKRvpWGW
         R9gw==
X-Gm-Message-State: AOJu0YwiIPvwdAIZ9eoiDL1eXi5posccRClKq2FdGobVVaq6SkqcrGms
        CWBGxF49cMHRZ0glRTqTtgGZaRZfCiS79lDkmJ0qvM7z
X-Google-Smtp-Source: AGHT+IGHglnZXZWyVH/Ok+muRbN00NUNNpy3C0UUvnJ7/37C/V0nQJDVBM0nhYvhUPkWhjVUNyaWeDrA46A03xaxc3I=
X-Received: by 2002:a2e:a0d3:0:b0:2c5:509:c080 with SMTP id
 f19-20020a2ea0d3000000b002c50509c080mr2052909ljm.3.1698418560520; Fri, 27 Oct
 2023 07:56:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230927192712.317799-1-trondmy@kernel.org> <CAN-5tyF9rKdu0D-7nUFQtq1BWQABb+mdY3sLrDY1-sU_Q2p8fA@mail.gmail.com>
 <c32aec7b2a8b226a1617ff9755b7b5ce64ad3114.camel@hammerspace.com>
 <CAN-5tyE2_myhnzuf28gmm9ztJxb+g=fHS4wDVNE5D43BSandUA@mail.gmail.com>
 <d3c1b8980a2942d79b9a5fe61586ebe42e75b7e6.camel@hammerspace.com>
 <CAN-5tyF99D_HoGjjB2yuQpcQ_c39q7-xOawWuk4EUdaMZL=-jQ@mail.gmail.com>
 <77a198c49efa23976c1c787bb51366af705608c3.camel@kernel.org>
 <CAN-5tyE3VuSSqmQyUvi9mxhV0-PVfJUK50P9mdJ+x36YFP9wYQ@mail.gmail.com>
 <688C5594-9744-43D7-ACE3-69A7167E0AE5@oracle.com> <a70aea770dc59ac3ff1d4f7206dec34e8f201ed8.camel@kernel.org>
In-Reply-To: <a70aea770dc59ac3ff1d4f7206dec34e8f201ed8.camel@kernel.org>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Fri, 27 Oct 2023 10:55:48 -0400
Message-ID: <CAN-5tyFQ_xdGYKMkM7nKvGX11Est5nkP+FXSAQKTg3EK3iVVXA@mail.gmail.com>
Subject: Re: [PATCH] SUNRPC: Don't retry using the same source port if
 connection failed
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Trond,

Can we at least make this a mount option? It's fine if you want the
default to be 'dont reuse' but there should be an option for customers
to have their reply cache working.

I still disagree with the statement that TCP RFC prohibits port
re-use. It might discourage it but RFC9293 does talk about how a
connection can be re-used directly from TIME_WAIT state.







On Tue, Oct 3, 2023 at 11:58=E2=80=AFAM Jeff Layton <jlayton@kernel.org> wr=
ote:
>
> On Tue, 2023-10-03 at 15:32 +0000, Chuck Lever III wrote:
> >
> > > On Oct 3, 2023, at 11:28 AM, Olga Kornievskaia <aglo@umich.edu> wrote=
:
> > >
> > > On Tue, Oct 3, 2023 at 11:12=E2=80=AFAM Jeff Layton <jlayton@kernel.o=
rg> wrote:
> > > >
> > > > On Tue, 2023-10-03 at 10:44 -0400, Olga Kornievskaia wrote:
> > > > > On Sat, Sep 30, 2023 at 7:06=E2=80=AFPM Trond Myklebust <trondmy@=
hammerspace.com> wrote:
> > > > > >
> > > > > > On Sat, 2023-09-30 at 18:36 -0400, Olga Kornievskaia wrote:
> > > > > > > On Fri, Sep 29, 2023 at 10:57=E2=80=AFPM Trond Myklebust
> > > > > > > <trondmy@hammerspace.com> wrote:
> > > > > > > >
> > > > > > > > On Thu, 2023-09-28 at 10:58 -0400, Olga Kornievskaia wrote:
> > > > > > > > > On Wed, Sep 27, 2023 at 3:35=E2=80=AFPM <trondmy@kernel.o=
rg> wrote:
> > > > > > > > > >
> > > > > > > > > > From: Trond Myklebust <trond.myklebust@hammerspace.com>
> > > > > > > > > >
> > > > > > > > > > If the TCP connection attempt fails without ever establ=
ishing a
> > > > > > > > > > connection, then assume the problem may be the server i=
s
> > > > > > > > > > rejecting
> > > > > > > > > > us
> > > > > > > > > > due to port reuse.
> > > > > > > > >
> > > > > > > > > Doesn't this break 4.0 replay cache? Seems too general to=
 assume
> > > > > > > > > that
> > > > > > > > > any unsuccessful SYN was due to a server reboot and it's =
ok for
> > > > > > > > > the
> > > > > > > > > client to change the port.
> > > > > > > >
> > > > > > > > This is where things get interesting. Yes, if we change the=
 port
> > > > > > > > number, then it will almost certainly break NFSv3 and NFSv4=
.0
> > > > > > > > replay
> > > > > > > > caching on the server.
> > > > > > > >
> > > > > > > > However the problem is that once we get stuck in the situat=
ion
> > > > > > > > where we
> > > > > > > > cannot connect, then each new connection attempt is just ca=
using
> > > > > > > > the
> > > > > > > > server's TCP layer to push back and recall that the connect=
ion from
> > > > > > > > this port was closed.
> > > > > > > > IOW: the problem is that once we're in this situation, we c=
annot
> > > > > > > > easily
> > > > > > > > exit without doing one of the following. Either we have to
> > > > > > > >
> > > > > > > >   1. Change the port number, so that the TCP layer allows u=
s to
> > > > > > > >      connect.
> > > > > > > >   2. Or.. Wait for long enough that the TCP layer has forgo=
tten
> > > > > > > >      altogether about the previous connection.
> > > > > > > >
> > > > > > > > The problem is that option (2) is subject to livelock, and =
so has a
> > > > > > > > potential infinite time out. I've seen this livelock in act=
ion, and
> > > > > > > > I'm
> > > > > > > > not seeing a solution that has predictable results.
> > > > > > > >
> > > > > > > > So unless there is a solution for the problems in (2), I do=
n't see
> > > > > > > > how
> > > > > > > > we can avoid defaulting to option (1) at some point, in whi=
ch case
> > > > > > > > the
> > > > > > > > only question is "when do we switch ports?".
> > > > > > >
> > > > > > > I'm not sure how one can justify that regression that will co=
me out
> > > > > > > of
> > > > > > > #1 will be less of a problem then the problem in #2.
> > > > > > >
> > > > > > > I think I'm still not grasping why the NFS server would
> > > > > > > (legitimately)
> > > > > > > be closing a connection that is re-using the port. Can you pr=
esent a
> > > > > > > sequence of events that would lead to this?
> > > > > > >
> > > > > >
> > > > > > Yes. It is essentially the problem described in this blog:
> > > > > > https://blog.davidvassallo.me/2010/07/13/time_wait-and-port-reu=
se/
> > > > > >
> > > > > > ...and as you can see, it is nothing to do with NFS. This is th=
e TCP
> > > > > > protocol working as expected.
> > > > >
> > > > > What I'm seeing are statements that RFC allows for/provides guida=
nce
> > > > > on how to transition out of TIME_WAIT state. I'm also hearing tha=
t the
> > > > > reasons that the server can't allow for port reuse is due to brok=
en
> > > > > client implementation or use of (broken?) NAT implementation.
> > > > >
> > > > > I don't see how any of this justifies allowing a regression in th=
e
> > > > > linux client code. I'm clearly missing something. How are you pos=
sibly
> > > > > OK with breaking the reply cache?
> > > > >
> > > >
> > > > Is it really breaking things though if you can't connect otherwise?=
 Bear
> > > > in mind that if you're dealing with NAT'ed setup, and you wait unti=
l the
> > > > connection is completely forgotten, then the NAT'ing firewall is li=
kely
> > > > to change your source port anyway.
> > > >
> > > > Chuck brought up an interesting question privately: should knfsd's
> > > > v3/v4.0 DRC start ignoring the source port? We already check this
> > > > otherwise:
> > > >
> > > > - IP addr
> > > > - XID
> > > > - hash of first 256 bytes of the payload
> > >
> > > Calculating a hash of every packet has a great performance impact.
> >
> > NFSD has done this for years. On modern CPUs, it's less of a
> > performance hit than walking the DRC hash chain.
> >
> >
>
> Yes, and calling it a hash is probably overstating it a bit...
>
> It's doing a CRC over those bytes, which is fine for our purposes and
> quite fast on modern hw.
>
> > > But
> > > perhaps if we require v3 traffic to do that then we can get v3 and
> > > v4.1 performance on the same level and folks would finally switch to
> > > v4.1.
> > >
> > > I also forgot to write that while we don't care about port (not being
> > > reused) for 4.1. If we switch the port on every connection
> > > establishment we will same way run into port exhaustion. Use of
> > > nconnect is becoming common so something like a server reboot on a
> > > client machine with about only 10 mounts using nconnect=3D16 and aver=
age
> > > of 7 SYNs (as per example here) before the server starts again, the
> > > client would use 1K source ports?
> > >
> > > > That seems like enough discriminators that we could stop comparing =
the
> > > > source port without breaking things.
> > > >
> > > > > > > But can't we at least arm ourselves in not unnecessarily brea=
king the
> > > > > > > reply cache by at least imposing some timeout/number of retri=
es
> > > > > > > before
> > > > > > > resetting? If the client was retrying to unsuccessfully re-es=
tablish
> > > > > > > connection for a (fixed) while, then 4.0 client's lease would=
 expire
> > > > > > > and switching the port after the lease expires makes no diffe=
rence.
> > > > > > > There isn't a solution in v3 unfortunately. But a time-based =
approach
> > > > > > > would at least separate these 'peculiar' servers vs normal se=
rvers.
> > > > > > > And if this is a 4.1 client, we can reset the port without a =
timeout.
> > > > > > >
> > > > > >
> > > > > > This is not a 'peculiar server' vs 'normal server' problem. The=
 reuse
> > > > > > of ports in this way violates the TCP protocol, and has been a =
problem
> > > > >
> > > > > I disagree here. Even the RFC quoted by the blogger says that reu=
se of
> > > > > port is allowed.
> > > > >
> > > > > > for NFS/TCP since the beginning. However, it was never a proble=
m for
> > > > > > the older connectionless UDP protocol, which is where the pract=
ice of
> > > > > > tying the replay cache to the source port began in the first pl=
ace.
> > > > > >
> > > > > > NFSv4.1 does not have this problem because it deliberately does=
 not
> > > > > > reuse TCP ports, and the reason is precisely to avoid the TIME_=
WAIT
> > > > > > state problems.
> > > > > >
> > > > > > NFSv3 tries to avoid it by doing an incremental back off, but w=
e
> > > > > > recently saw that does not suffice to avoid live lock, after a =
system
> > > > > > got stuck for several hours in this state.
> > > > > >
> > > > > > > Am I correct that every unsuccessful SYN causes a new source =
point to
> > > > > > > be taken? If so, then a server reboot where multiple SYNs are=
 sent
> > > > > > > prior to connection re-establishment (times number of mounts)=
 might
> > > > > > > cause source port exhaustion?
> > > > > > >
> > > > > >
> > > > > > No. Not every unsuccessful SYN: It is every unsuccessful sequen=
ce of
> > > > >
> > > > > I disagree. Here's a snippet of the network trace with the propos=
ed
> > > > > patch. The port is changed on EVERY unsuccessful SYN.
> > > > >
> > > > >   76 2023-10-03 10:17:04.285731 192.168.1.134 =E2=86=92 192.168.1=
.106 NFS 238
> > > > > V3 WRITE Call, FH: 0x10bedd7c Offset: 0 Len: 4 FILE_SYNC
> > > > >   77 2023-10-03 10:17:04.328371 192.168.1.106 =E2=86=92 192.168.1=
.134 TCP 66
> > > > > 2049 =E2=86=92 909 [ACK] Seq=3D1113 Ack=3D1501 Win=3D31872 Len=3D=
0 TSval=3D3542359002
> > > > > TSecr=3D3081600630
> > > > >  256 2023-10-03 10:18:04.341041 192.168.1.134 =E2=86=92 192.168.1=
.106 TCP 66
> > > > > [TCP Keep-Alive] 909 =E2=86=92 2049 [ACK] Seq=3D1500 Ack=3D1113 W=
in=3D32000 Len=3D0
> > > > > TSval=3D3081660681 TSecr=3D3542359002
> > > > >  259 2023-10-03 10:18:04.341500 192.168.1.106 =E2=86=92 192.168.1=
.134 TCP 54
> > > > > 2049 =E2=86=92 909 [RST] Seq=3D1113 Win=3D0 Len=3D0
> > > > >  260 2023-10-03 10:18:04.341860 192.168.1.134 =E2=86=92 192.168.1=
.106 TCP 74
> > > > > [TCP Port numbers reused] 909 =E2=86=92 2049 [SYN] Seq=3D0 Win=3D=
32120 Len=3D0
> > > > > MSS=3D1460 SACK_PERM TSval=3D3081660681 TSecr=3D0 WS=3D128
> > > > >  261 2023-10-03 10:18:04.342031 192.168.1.106 =E2=86=92 192.168.1=
.134 TCP 54
> > > > > 2049 =E2=86=92 909 [RST, ACK] Seq=3D1 Ack=3D1 Win=3D0 Len=3D0
> > > > >  266 2023-10-03 10:18:07.380801 192.168.1.134 =E2=86=92 192.168.1=
.106 TCP 74
> > > > > 954 =E2=86=92 2049 [SYN] Seq=3D0 Win=3D32120 Len=3D0 MSS=3D1460 S=
ACK_PERM
> > > > > TSval=3D3081663720 TSecr=3D0 WS=3D128
> > > > >  267 2023-10-03 10:18:07.380971 192.168.1.106 =E2=86=92 192.168.1=
.134 TCP 54
> > > > > 2049 =E2=86=92 954 [RST, ACK] Seq=3D1 Ack=3D1 Win=3D0 Len=3D0
> > > > >  275 2023-10-03 10:18:10.423352 192.168.1.134 =E2=86=92 192.168.1=
.106 TCP 74
> > > > > 856 =E2=86=92 2049 [SYN] Seq=3D0 Win=3D32120 Len=3D0 MSS=3D1460 S=
ACK_PERM
> > > > > TSval=3D3081666760 TSecr=3D0 WS=3D128
> > > > >  276 2023-10-03 10:18:10.423621 192.168.1.106 =E2=86=92 192.168.1=
.134 TCP 54
> > > > > 2049 =E2=86=92 856 [RST, ACK] Seq=3D1 Ack=3D1 Win=3D0 Len=3D0
> > > > >  286 2023-10-03 10:18:13.466277 192.168.1.134 =E2=86=92 192.168.1=
.106 TCP 74
> > > > > 957 =E2=86=92 2049 [SYN] Seq=3D0 Win=3D32120 Len=3D0 MSS=3D1460 S=
ACK_PERM
> > > > > TSval=3D3081669801 TSecr=3D0 WS=3D128
> > > > >  287 2023-10-03 10:18:13.466812 192.168.1.106 =E2=86=92 192.168.1=
.134 TCP 54
> > > > > 2049 =E2=86=92 957 [RST, ACK] Seq=3D1 Ack=3D1 Win=3D0 Len=3D0
> > > > >  289 2023-10-03 10:18:16.509229 192.168.1.134 =E2=86=92 192.168.1=
.106 TCP 74
> > > > > 695 =E2=86=92 2049 [SYN] Seq=3D0 Win=3D32120 Len=3D0 MSS=3D1460 S=
ACK_PERM
> > > > > TSval=3D3081672841 TSecr=3D0 WS=3D128
> > > > >  290 2023-10-03 10:18:16.509845 192.168.1.106 =E2=86=92 192.168.1=
.134 TCP 54
> > > > > 2049 =E2=86=92 695 [RST, ACK] Seq=3D1 Ack=3D1 Win=3D0 Len=3D0
> > > > >  294 2023-10-03 10:18:19.551062 192.168.1.134 =E2=86=92 192.168.1=
.106 TCP 74
> > > > > 940 =E2=86=92 2049 [SYN] Seq=3D0 Win=3D32120 Len=3D0 MSS=3D1460 S=
ACK_PERM
> > > > > TSval=3D3081675881 TSecr=3D0 WS=3D128
> > > > >  295 2023-10-03 10:18:19.551434 192.168.1.106 =E2=86=92 192.168.1=
.134 TCP 54
> > > > > 2049 =E2=86=92 940 [RST, ACK] Seq=3D1 Ack=3D1 Win=3D0 Len=3D0
> > > > >  300 2023-10-03 10:18:22.590380 192.168.1.134 =E2=86=92 192.168.1=
.106 TCP 74
> > > > > 810 =E2=86=92 2049 [SYN] Seq=3D0 Win=3D32120 Len=3D0 MSS=3D1460 S=
ACK_PERM
> > > > > TSval=3D3081678921 TSecr=3D0
> > > > > WS=3D128
> > > > >  301 2023-10-03 10:18:22.590726 192.168.1.106 =E2=86=92 192.168.1=
.134 TCP 54
> > > > > 2049 =E2=86=92 810 [RST, ACK] Seq=3D1 Ack=3D1 Win=3D0 Len=3D0
> > > > >  308 2023-10-03 10:18:25.628256 192.168.1.134 =E2=86=92 192.168.1=
.106 TCP 74
> > > > > 877 =E2=86=92 2049 [SYN] Seq=3D0 Win=3D32120 Len=3D0 MSS=3D1460 S=
ACK_PERM
> > > > > TSval=3D3081681961 TSecr=3D0 WS=3D128
> > > > >  309 2023-10-03 10:18:25.628724 192.168.1.106 =E2=86=92 192.168.1=
.134 TCP 54
> > > > > 2049 =E2=86=92 877 [RST, ACK] Seq=3D1 Ack=3D1 Win=3D0 Len=3D0
> > > > >  312 2023-10-03 10:18:28.665682 192.168.1.134 =E2=86=92 192.168.1=
.106 TCP 74
> > > > > 934 =E2=86=92 2049 [SYN] Seq=3D0 Win=3D32120 Len=3D0 MSS=3D1460 S=
ACK_PERM
> > > > > TSval=3D3081685001 TSecr=3D0 WS=3D128
> > > > >  313 2023-10-03 10:18:28.666374 192.168.1.106 =E2=86=92 192.168.1=
.134 TCP 54
> > > > > 2049 =E2=86=92 934 [RST, ACK] Seq=3D1 Ack=3D1 Win=3D0 Len=3D0
> > > > >  320 2023-10-03 10:18:31.702236 192.168.1.134 =E2=86=92 192.168.1=
.106 TCP 74
> > > > > 803 =E2=86=92 2049 [SYN] Seq=3D0 Win=3D32120 Len=3D0 MSS=3D1460 S=
ACK_PERM
> > > > > TSval=3D3081688040 TSecr=3D0 WS=3D128
> > > > >  321 2023-10-03 10:18:31.702490 192.168.1.106 =E2=86=92 192.168.1=
.134 TCP 74
> > > > > 2049 =E2=86=92 803 [SYN, ACK] Seq=3D0 Ack=3D1 Win=3D31856 Len=3D0=
 MSS=3D1460 SACK_PERM
> > > > > TSval=3D1993141756 TSecr=3D3081688040 WS=3D128
> > > > >  322 2023-10-03 10:18:31.702729 192.168.1.134 =E2=86=92 192.168.1=
.106 TCP 66
> > > > > 803 =E2=86=92 2049 [ACK] Seq=3D1 Ack=3D1 Win=3D32128 Len=3D0 TSva=
l=3D3081688040
> > > > > TSecr=3D1993141756
> > > > >  323 2023-10-03 10:18:31.702737 192.168.1.134 =E2=86=92 192.168.1=
.106 NFS 238
> > > > > V3 WRITE Call, FH: 0x10bedd7c Offset: 0 Len: 4 FILE_SYNC
> > > > >  324 2023-10-03 10:18:31.702893 192.168.1.106 =E2=86=92 192.168.1=
.134 TCP 66
> > > > > 2049 =E2=86=92 803 [ACK] Seq=3D1 Ack=3D173 Win=3D31872 Len=3D0 TS=
val=3D1993141756
> > > > > TSecr=3D3081688040
> > > > >  749 2023-10-03 10:19:01.880214 192.168.1.106 =E2=86=92 192.168.1=
.134 NFS 206
> > > > > V3 WRITE Reply (Call In 323) Len: 4 FILE_SYNC
> > > > >
> > > > > This is the same without the patch. Port is successfully reused.
> > > > > Replay cache OK here not above.
> > > > >
> > > > >   76 2023-10-03 10:17:04.285731 192.168.1.134 =E2=86=92 192.168.1=
.106 NFS 238
> > > > > V3 WRITE Call, FH: 0x10bedd7c Offset: 0 Len: 4 FILE_SYNC
> > > > >   77 2023-10-03 10:17:04.328371 192.168.1.106 =E2=86=92 192.168.1=
.134 TCP 66
> > > > > 2049 =E2=86=92 909 [ACK] Seq=3D1113 Ack=3D1501 Win=3D31872 Len=3D=
0 TSval=3D3542359002
> > > > > TSecr=3D3081600630
> > > > >  256 2023-10-03 10:18:04.341041 192.168.1.134 =E2=86=92 192.168.1=
.106 TCP 66
> > > > > [TCP Keep-Alive] 909 =E2=86=92 2049 [ACK] Seq=3D1500 Ack=3D1113 W=
in=3D32000 Len=3D0
> > > > > TSval=3D3081660681 TSecr=3D3542359002
> > > > >  259 2023-10-03 10:18:04.341500 192.168.1.106 =E2=86=92 192.168.1=
.134 TCP 54
> > > > > 2049 =E2=86=92 909 [RST] Seq=3D1113 Win=3D0 Len=3D0
> > > > >  260 2023-10-03 10:18:04.341860 192.168.1.134 =E2=86=92 192.168.1=
.106 TCP 74
> > > > > [TCP Port numbers reused] 909 =E2=86=92 2049 [SYN] Seq=3D0 Win=3D=
32120 Len=3D0
> > > > > MSS=3D1460 SACK_PERM TSval=3D3081660681 TSecr=3D0 WS=3D128
> > > > >  261 2023-10-03 10:18:04.342031 192.168.1.106 =E2=86=92 192.168.1=
.134 TCP 54
> > > > > 2049 =E2=86=92 909 [RST, ACK] Seq=3D1 Ack=3D1 Win=3D0 Len=3D0
> > > > >  266 2023-10-03 10:18:07.380801 192.168.1.134 =E2=86=92 192.168.1=
.106 TCP 74
> > > > > 954 =E2=86=92 2049 [SYN] Seq=3D0 Win=3D32120 Len=3D0 MSS=3D1460 S=
ACK_PERM
> > > > > TSval=3D3081663720 TSecr=3D0 WS=3D128
> > > > >  267 2023-10-03 10:18:07.380971 192.168.1.106 =E2=86=92 192.168.1=
.134 TCP 54
> > > > > 2049 =E2=86=92 954 [RST, ACK] Seq=3D1 Ack=3D1 Win=3D0 Len=3D0
> > > > >  275 2023-10-03 10:18:10.423352 192.168.1.134 =E2=86=92 192.168.1=
.106 TCP 74
> > > > > 856 =E2=86=92 2049 [SYN] Seq=3D0 Win=3D32120 Len=3D0 MSS=3D1460 S=
ACK_PERM
> > > > > TSval=3D3081666760 TSecr=3D0 WS=3D128
> > > > >  276 2023-10-03 10:18:10.423621 192.168.1.106 =E2=86=92 192.168.1=
.134 TCP 54
> > > > > 2049 =E2=86=92 856 [RST, ACK] Seq=3D1 Ack=3D1 Win=3D0 Len=3D0
> > > > >  286 2023-10-03 10:18:13.466277 192.168.1.134 =E2=86=92 192.168.1=
.106 TCP 74
> > > > > 957 =E2=86=92 2049 [SYN] Seq=3D0 Win=3D32120 Len=3D0 MSS=3D1460 S=
ACK_PERM
> > > > > TSval=3D3081669801 TSecr=3D0 WS=3D128
> > > > >  287 2023-10-03 10:18:13.466812 192.168.1.106 =E2=86=92 192.168.1=
.134 TCP 54
> > > > > 2049 =E2=86=92 957 [RST, ACK] Seq=3D1 Ack=3D1 Win=3D0 Len=3D0
> > > > >  289 2023-10-03 10:18:16.509229 192.168.1.134 =E2=86=92 192.168.1=
.106 TCP 74
> > > > > 695 =E2=86=92 2049 [SYN] Seq=3D0 Win=3D32120 Len=3D0 MSS=3D1460 S=
ACK_PERM
> > > > > TSval=3D3081672841 TSecr=3D0 WS=3D128
> > > > >  290 2023-10-03 10:18:16.509845 192.168.1.106 =E2=86=92 192.168.1=
.134 TCP 54
> > > > > 2049 =E2=86=92 695 [RST, ACK] Seq=3D1 Ack=3D1 Win=3D0 Len=3D0
> > > > >  294 2023-10-03 10:18:19.551062 192.168.1.134 =E2=86=92 192.168.1=
.106 TCP 74
> > > > > 940 =E2=86=92 2049 [SYN] Seq=3D0 Win=3D32120 Len=3D0 MSS=3D1460 S=
ACK_PERM
> > > > > TSval=3D3081675881 TSecr=3D0 WS=3D128
> > > > >  295 2023-10-03 10:18:19.551434 192.168.1.106 =E2=86=92 192.168.1=
.134 TCP 54
> > > > > 2049 =E2=86=92 940 [RST, ACK] Seq=3D1 Ack=3D1 Win=3D0 Len=3D0
> > > > >  300 2023-10-03 10:18:22.590380 192.168.1.134 =E2=86=92 192.168.1=
.106 TCP 74
> > > > > 810 =E2=86=92 2049 [SYN] Seq=3D0 Win=3D32120 Len=3D0 MSS=3D1460 S=
ACK_PERM
> > > > > TSval=3D3081678921 TSecr=3D0 WS=3D128
> > > > >  301 2023-10-03 10:18:22.590726 192.168.1.106 =E2=86=92 192.168.1=
.134 TCP 54
> > > > > 2049 =E2=86=92 810 [RST, ACK] Seq=3D1 Ack=3D1 Win=3D0 Len=3D0
> > > > >  308 2023-10-03 10:18:25.628256 192.168.1.134 =E2=86=92 192.168.1=
.106 TCP 74
> > > > > 877 =E2=86=92 2049 [SYN] Seq=3D0 Win=3D32120 Len=3D0 MSS=3D1460 S=
ACK_PERM
> > > > > TSval=3D3081681961 TSecr=3D0 WS=3D128
> > > > >  309 2023-10-03 10:18:25.628724 192.168.1.106 =E2=86=92 192.168.1=
.134 TCP 54
> > > > > 2049 =E2=86=92 877 [RST, ACK] Seq=3D1 Ack=3D1 Win=3D0 Len=3D0
> > > > >  312 2023-10-03 10:18:28.665682 192.168.1.134 =E2=86=92 192.168.1=
.106 TCP 74
> > > > > 934 =E2=86=92 2049 [SYN] Seq=3D0 Win=3D32120 Len=3D0 MSS=3D1460 S=
ACK_PERM
> > > > > TSval=3D3081685001 TSecr=3D0 WS=3D128
> > > > >  313 2023-10-03 10:18:28.666374 192.168.1.106 =E2=86=92 192.168.1=
.134 TCP 54
> > > > > 2049 =E2=86=92 934 [RST, ACK] Seq=3D1 Ack=3D1 Win=3D0 Len=3D0
> > > > >  320 2023-10-03 10:18:31.702236 192.168.1.134 =E2=86=92 192.168.1=
.106 TCP 74
> > > > > 803 =E2=86=92 2049 [SYN] Seq=3D0 Win=3D32120 Len=3D0 MSS=3D1460 S=
ACK_PERM
> > > > > TSval=3D3081688040 TSecr=3D0 WS=3D128
> > > > >  321 2023-10-03 10:18:31.702490 192.168.1.106 =E2=86=92 192.168.1=
.134 TCP 74
> > > > > 2049 =E2=86=92 803 [SYN, ACK] Seq=3D0 Ack=3D1 Win=3D31856 Len=3D0=
 MSS=3D1460 SACK_PERM
> > > > > TSval=3D1993141756 TSecr=3D3081688040 WS=3D128
> > > > >  322 2023-10-03 10:18:31.702729 192.168.1.134 =E2=86=92 192.168.1=
.106 TCP 66
> > > > > 803 =E2=86=92 2049 [ACK] Seq=3D1 Ack=3D1 Win=3D32128 Len=3D0 TSva=
l=3D3081688040
> > > > > TSecr=3D1993141756
> > > > >  323 2023-10-03 10:18:31.702737 192.168.1.134 =E2=86=92 192.168.1=
.106 NFS 238
> > > > > V3 WRITE Call, FH: 0x10bedd7c Offset: 0 Len: 4 FILE_SYNC
> > > > >  324 2023-10-03 10:18:31.702893 192.168.1.106 =E2=86=92 192.168.1=
.134 TCP 66
> > > > > 2049 =E2=86=92 803 [ACK] Seq=3D1 Ack=3D173 Win=3D31872 Len=3D0 TS=
val=3D1993141756
> > > > > TSecr=3D3081688040
> > > > >  749 2023-10-03 10:19:01.880214 192.168.1.106 =E2=86=92 192.168.1=
.134 NFS 206
> > > > > V3 WRITE Reply (Call In 323) Len: 4 FILE_SYNC
> > > > >  750 2023-10-03 10:19:01.880616 192.168.1.134 =E2=86=92 192.168.1=
.106 TCP 66
> > > > > 803 =E2=86=92 2049 [ACK] Seq=3D173 Ack=3D141 Win=3D32000 Len=3D0 =
TSval=3D3081718241
> > > > > TSecr=3D1993171927
> > > > >
> > > > >
> > > > > > SYNs. If the server is not replying to our SYN packets, then th=
e TCP
> > > > > > layer will back off and retransmit. So there is already a backo=
ff-retry
> > > > > > happening at that level.
> > > > > >
> > > > > > >
> > > > > > > >
> > > > > > > > >
> > > > > > > > > >
> > > > > > > > > > Signed-off-by: Trond Myklebust
> > > > > > > > > > <trond.myklebust@hammerspace.com>
> > > > > > > > > > ---
> > > > > > > > > > net/sunrpc/xprtsock.c | 10 +++++++++-
> > > > > > > > > > 1 file changed, 9 insertions(+), 1 deletion(-)
> > > > > > > > > >
> > > > > > > > > > diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsoc=
k.c
> > > > > > > > > > index 71848ab90d13..1a96777f0ed5 100644
> > > > > > > > > > --- a/net/sunrpc/xprtsock.c
> > > > > > > > > > +++ b/net/sunrpc/xprtsock.c
> > > > > > > > > > @@ -62,6 +62,7 @@
> > > > > > > > > > #include "sunrpc.h"
> > > > > > > > > >
> > > > > > > > > > static void xs_close(struct rpc_xprt *xprt);
> > > > > > > > > > +static void xs_reset_srcport(struct sock_xprt *transpo=
rt);
> > > > > > > > > > static void xs_set_srcport(struct sock_xprt *transport,=
 struct
> > > > > > > > > > socket *sock);
> > > > > > > > > > static void xs_tcp_set_socket_timeouts(struct rpc_xprt =
*xprt,
> > > > > > > > > >                struct socket *sock);
> > > > > > > > > > @@ -1565,8 +1566,10 @@ static void xs_tcp_state_change(=
struct
> > > > > > > > > > sock
> > > > > > > > > > *sk)
> > > > > > > > > >                break;
> > > > > > > > > >        case TCP_CLOSE:
> > > > > > > > > >                if (test_and_clear_bit(XPRT_SOCK_CONNECT=
ING,
> > > > > > > > > > -                                       &transport-
> > > > > > > > > > > sock_state))
> > > > > > > > > > +                                      &transport->sock=
_state))
> > > > > > > > > > {
> > > > > > > > > > +                       xs_reset_srcport(transport);
> > > > > > > > > >                        xprt_clear_connecting(xprt);
> > > > > > > > > > +               }
> > > > > > > > > >                clear_bit(XPRT_CLOSING, &xprt->state);
> > > > > > > > > >                /* Trigger the socket release */
> > > > > > > > > >                xs_run_error_worker(transport,
> > > > > > > > > > XPRT_SOCK_WAKE_DISCONNECT);
> > > > > > > > > > @@ -1722,6 +1725,11 @@ static void xs_set_port(struct r=
pc_xprt
> > > > > > > > > > *xprt, unsigned short port)
> > > > > > > > > >        xs_update_peer_port(xprt);
> > > > > > > > > > }
> > > > > > > > > >
> > > > > > > > > > +static void xs_reset_srcport(struct sock_xprt *transpo=
rt)
> > > > > > > > > > +{
> > > > > > > > > > +       transport->srcport =3D 0;
> > > > > > > > > > +}
> > > > > > > > > > +
> > > > > > > > > > static void xs_set_srcport(struct sock_xprt *transport,=
 struct
> > > > > > > > > > socket *sock)
> > > > > > > > > > {
> > > > > > > > > >        if (transport->srcport =3D=3D 0 && transport-
> > > > > > > > > > > xprt.reuseport)
> > > > > > > > > > --
> > > > > > > > > > 2.41.0
> > > > > > > > > >
> > > > > > > >
> > > > > > > > --
> > > > > > > > Trond Myklebust Linux NFS client maintainer, Hammerspace
> > > > > > > > trond.myklebust@hammerspace.com
> > > > > >
> > > > > > --
> > > > > > Trond Myklebust
> > > > > > Linux NFS client maintainer, Hammerspace
> > > > > > trond.myklebust@hammerspace.com
> > > > > >
> > > > > >
> > > >
> > > > --
> > > > Jeff Layton <jlayton@kernel.org>
> >
> >
> > --
> > Chuck Lever
> >
> >
>
> --
> Jeff Layton <jlayton@kernel.org>
