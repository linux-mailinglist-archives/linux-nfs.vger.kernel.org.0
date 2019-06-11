Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DEC9F3DBAC
	for <lists+linux-nfs@lfdr.de>; Tue, 11 Jun 2019 22:09:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406022AbfFKUJo (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 11 Jun 2019 16:09:44 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:56186 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405799AbfFKUJn (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 11 Jun 2019 16:09:43 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5BK9NFR179598;
        Tue, 11 Jun 2019 20:09:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2018-07-02; bh=rYDdcZJtmLKwTlC/rHgtoq2N2c9WOrGPqv4/dnMTMoM=;
 b=u+ZSnGiZhPtNbBfN/2nS1l//n0XeFKq/CUS3YullPs9M0iNNcnPkdkDQp8W+NA/ZVUQz
 jrbIet1TQj0Cu0m3SNb59nfuxur2oWqJMDOl2DLlntH8YQ4TzLg6icUGv2/gtY3wdt30
 z+HXVl7GLV9E0jJL3CemLVuJp5YtnYica95f/AuIj59PR5DxlEndnpWC6RPRPfX/GEr4
 zuV96iiAgaz7zDzxiDREdTHwpm4osNP7Dh5/t6u+gsLhD/fym+XrnsdyjCP1e0ijlRmJ
 dneGa3f6Du+FOigBuKGYkkwatJ7witIl5YS8EIuETcXCN1FpoMIvhhqdoi4TAKljN5q+ hQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 2t04etqg57-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Jun 2019 20:09:28 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5BK8Fk0010146;
        Tue, 11 Jun 2019 20:09:28 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 2t0p9rg6wd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Jun 2019 20:09:27 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x5BK9O2Z003399;
        Tue, 11 Jun 2019 20:09:26 GMT
Received: from anon-dhcp-171.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 11 Jun 2019 13:09:23 -0700
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH 0/9] Multiple network connections for a single NFS mount.
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <ac631f3c-af1a-6877-08b6-21ddf71edff2@talpey.com>
Date:   Tue, 11 Jun 2019 16:09:16 -0400
Cc:     Olga Kornievskaia <aglo@umich.edu>, NeilBrown <neilb@suse.com>,
        Anna Schumaker <Anna.Schumaker@netapp.com>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <A74B7E29-CAC7-428B-8B29-606F4B174D1A@oracle.com>
References: <155917564898.3988.6096672032831115016.stgit@noble.brown>
 <001DED71-0E0D-46B1-BA34-84E6ACCBB79F@oracle.com>
 <87muj3tuuk.fsf@notabene.neil.brown.name>
 <4316E30B-1BD7-4F0E-8375-03E9F85FFD2B@oracle.com>
 <87lfy9vsgf.fsf@notabene.neil.brown.name>
 <3B887552-91FB-493A-8FDF-411562811B36@oracle.com>
 <CAN-5tyEdu7poNWrKtOyic6GgQcjAPZhB5BJeQ7JMSfmgMx8b+g@mail.gmail.com>
 <16D30334-67BE-4BD2-BE69-1453F738B259@oracle.com>
 <CAN-5tyHQz4kyGqAea3hTW0GKRBtkkB5UeE6THz-7uMmadJygyg@mail.gmail.com>
 <ac631f3c-af1a-6877-08b6-21ddf71edff2@talpey.com>
To:     Tom Talpey <tom@talpey.com>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9284 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906110129
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9284 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906110130
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jun 11, 2019, at 4:02 PM, Tom Talpey <tom@talpey.com> wrote:
>=20
> On 6/11/2019 3:13 PM, Olga Kornievskaia wrote:
>> On Tue, Jun 11, 2019 at 1:47 PM Chuck Lever <chuck.lever@oracle.com> =
wrote:
>>>=20
>>>=20
>>>=20
>>>> On Jun 11, 2019, at 11:34 AM, Olga Kornievskaia <aglo@umich.edu> =
wrote:
>>>>=20
>>>> On Tue, Jun 11, 2019 at 10:52 AM Chuck Lever =
<chuck.lever@oracle.com> wrote:
>>>>>=20
>>>>> Hi Neil-
>>>>>=20
>>>>>=20
>>>>>> On Jun 10, 2019, at 9:09 PM, NeilBrown <neilb@suse.com> wrote:
>>>>>>=20
>>>>>> On Fri, May 31 2019, Chuck Lever wrote:
>>>>>>=20
>>>>>>>> On May 30, 2019, at 6:56 PM, NeilBrown <neilb@suse.com> wrote:
>>>>>>>>=20
>>>>>>>> On Thu, May 30 2019, Chuck Lever wrote:
>>>>>>>>=20
>>>>>>>>> Hi Neil-
>>>>>>>>>=20
>>>>>>>>> Thanks for chasing this a little further.
>>>>>>>>>=20
>>>>>>>>>=20
>>>>>>>>>> On May 29, 2019, at 8:41 PM, NeilBrown <neilb@suse.com> =
wrote:
>>>>>>>>>>=20
>>>>>>>>>> This patch set is based on the patches in the multipath_tcp =
branch of
>>>>>>>>>> git://git.linux-nfs.org/projects/trondmy/nfs-2.6.git
>>>>>>>>>>=20
>>>>>>>>>> I'd like to add my voice to those supporting this work and =
wanting to
>>>>>>>>>> see it land.
>>>>>>>>>> We have had customers/partners wanting this sort of =
functionality for
>>>>>>>>>> years.  In SLES releases prior to SLE15, we've provide a
>>>>>>>>>> "nosharetransport" mount option, so that several filesystem =
could be
>>>>>>>>>> mounted from the same server and each would get its own TCP
>>>>>>>>>> connection.
>>>>>>>>>=20
>>>>>>>>> Is it well understood why splitting up the TCP connections =
result
>>>>>>>>> in better performance?
>>>>>>>>>=20
>>>>>>>>>=20
>>>>>>>>>> In SLE15 we are using this 'nconnect' feature, which is much =
nicer.
>>>>>>>>>>=20
>>>>>>>>>> Partners have assured us that it improves total throughput,
>>>>>>>>>> particularly with bonded networks, but we haven't had any =
concrete
>>>>>>>>>> data until Olga Kornievskaia provided some concrete test data =
- thanks
>>>>>>>>>> Olga!
>>>>>>>>>>=20
>>>>>>>>>> My understanding, as I explain in one of the patches, is that =
parallel
>>>>>>>>>> hardware is normally utilized by distributing flows, rather =
than
>>>>>>>>>> packets.  This avoid out-of-order deliver of packets in a =
flow.
>>>>>>>>>> So multiple flows are needed to utilizes parallel hardware.
>>>>>>>>>=20
>>>>>>>>> Indeed.
>>>>>>>>>=20
>>>>>>>>> However I think one of the problems is what happens in simpler =
scenarios.
>>>>>>>>> We had reports that using nconnect > 1 on virtual clients made =
things
>>>>>>>>> go slower. It's not always wise to establish multiple =
connections
>>>>>>>>> between the same two IP addresses. It depends on the hardware =
on each
>>>>>>>>> end, and the network conditions.
>>>>>>>>=20
>>>>>>>> This is a good argument for leaving the default at '1'.  When
>>>>>>>> documentation is added to nfs(5), we can make it clear that the =
optimal
>>>>>>>> number is dependant on hardware.
>>>>>>>=20
>>>>>>> Is there any visibility into the NIC hardware that can guide =
this setting?
>>>>>>>=20
>>>>>>=20
>>>>>> I doubt it, partly because there is more than just the NIC =
hardware at issue.
>>>>>> There is also the server-side hardware and possibly hardware in =
the middle.
>>>>>=20
>>>>> So the best guidance is YMMV. :-)
>>>>>=20
>>>>>=20
>>>>>>>>> What about situations where the network capabilities between =
server and
>>>>>>>>> client change? Problem is that neither endpoint can detect =
that; TCP
>>>>>>>>> usually just deals with it.
>>>>>>>>=20
>>>>>>>> Being able to manually change (-o remount) the number of =
connections
>>>>>>>> might be useful...
>>>>>>>=20
>>>>>>> Ugh. I have problems with the administrative interface for this =
feature,
>>>>>>> and this is one of them.
>>>>>>>=20
>>>>>>> Another is what prevents your client from using a different =
nconnect=3D
>>>>>>> setting on concurrent mounts of the same server? It's another =
case of a
>>>>>>> per-mount setting being used to control a resource that is =
shared across
>>>>>>> mounts.
>>>>>>=20
>>>>>> I think that horse has well and truly bolted.
>>>>>> It would be nice to have a "server" abstraction visible to =
user-space
>>>>>> where we could adjust settings that make sense server-wide, and =
then a way
>>>>>> to mount individual filesystems from that "server" - but we =
don't.
>>>>>=20
>>>>> Even worse, there will be some resource sharing between containers =
that
>>>>> might be undesirable. The host should have ultimate control over =
those
>>>>> resources.
>>>>>=20
>>>>> But that is neither here nor there.
>>>>>=20
>>>>>=20
>>>>>> Probably the best we can do is to document (in nfs(5)) which =
options are
>>>>>> per-server and which are per-mount.
>>>>>=20
>>>>> Alternately, the behavior of this option could be documented this =
way:
>>>>>=20
>>>>> The default value is one. To resolve conflicts between nconnect =
settings on
>>>>> different mount points to the same server, the value set on the =
first mount
>>>>> applies until there are no more mounts of that server, unless =
nosharecache
>>>>> is specified. When following a referral to another server, the =
nconnect
>>>>> setting is inherited, but the effective value is determined by =
other mounts
>>>>> of that server that are already in place.
>>>>>=20
>>>>> I hate to say it, but the way to make this work deterministically =
is to
>>>>> ask administrators to ensure that the setting is the same on all =
mounts
>>>>> of the same server. Again I'd rather this take care of itself, but =
it
>>>>> appears that is not going to be possible.
>>>>>=20
>>>>>=20
>>>>>>> Adding user tunables has never been known to increase the =
aggregate
>>>>>>> amount of happiness in the universe. I really hope we can come =
up with
>>>>>>> a better administrative interface... ideally, none would be =
best.
>>>>>>=20
>>>>>> I agree that none would be best.  It isn't clear to me that that =
is
>>>>>> possible.
>>>>>> At present, we really don't have enough experience with this
>>>>>> functionality to be able to say what the trade-offs are.
>>>>>> If we delay the functionality until we have the perfect =
interface,
>>>>>> we may never get that experience.
>>>>>>=20
>>>>>> We can document "nconnect=3D" as a hint, and possibly add that
>>>>>> "nconnect=3D1" is a firm guarantee that more will not be used.
>>>>>=20
>>>>> Agree that 1 should be the default. If we make this setting a
>>>>> hint, then perhaps it should be renamed; nconnect makes it sound
>>>>> like the client will always open N connections. How about =
"maxconn" ?
>>>>=20
>>>> "maxconn" sounds to me like it's possible that the code would =
choose a
>>>> number that's less than that which I think would be misleading =
given
>>>> that the implementation (as is now) will open the specified number =
of
>>>> connection (bounded by the hard coded default we currently have set =
at
>>>> some value X which I'm in favor is increasing from 16 to 32).
>>>=20
>>> Earlier in this thread, Neil proposed to make nconnect a hint. =
Sounds
>>> like the long term plan is to allow "up to N" connections with some
>>> mechanism to create new connections on-demand." maxconn fits that =
idea
>>> better, though I'd prefer no new mount options... the point being =
that
>>> eventually, this setting is likely to be an upper bound rather than =
a
>>> fixed value.
>> Fair enough. If the dynamic connection management is in the cards,
>> then "maxconn" would be an appropriate name but I also agree with you
>> that if we are doing dynamic management then we shouldn't need a =
mount
>> option at all. I, for one, am skeptical that we'll gain benefits from
>> dynamic connection management given that cost of tearing and starting
>> the new connection.
>> I would argue that since now no dynamic management is implemented =
then
>> we stay with the "nconnect" mount option and if and when such feature
>> is found desirable then we get rid of the mount option all together.
>>>>> Then, to better define the behavior:
>>>>>=20
>>>>> The range of valid maxconn values is 1 to 3? to 8? to NCPUS? to =
the
>>>>> count of the client=E2=80=99s NUMA nodes? I=E2=80=99d be in favor =
of a small number
>>>>> to start with. Solaris' experience with multiple connections is =
that
>>>>> there is very little benefit past 8.
>>>>=20
>>>> My linux to linux experience has been that there is benefit of =
having
>>>> more than 8 connections. I have previously posted results that went
>>>> upto 10 connection (it's on my list of thing to test uptown 16). =
With
>>>> the Netapp performance lab they have maxed out 25G connection setup
>>>> they were using with so they didn't experiment with nconnect=3D8 =
but no
>>>> evidence that with a larger network pipe performance would stop
>>>> improving.
>>>>=20
>>>> Given the existing performance studies, I would like to argue that
>>>> having such low values are not warranted.
>>>=20
>>> They are warranted until we have a better handle on the risks of a
>>> performance regression occurring with large nconnect settings. The
>>> maximum number can always be raised once we are confident the
>>> behaviors are well understood.
>>>=20
>>> Also, I'd like to see some careful studies that demonstrate why
>>> you don't see excellent results with just two or three connections.
>>> Nearly full link bandwidth has been achieved with MP-TCP and two or
>>> three subflows on one NIC. Why is it not possible with NFS/TCP ?
>> Performance tests that do simple buffer to buffer measurements are =
one
>> thing but doing a complicated system that involves a filesystem is
>> another thing. The closest we can get to this network performance
>> tests is NFSoRDMA which saves various copies and as you know with =
that
>> we can get close to network link capacity.

Yes, in certain circumstances, but there are still areas that can
benefit or need substantial improvement (NFS WRITE performance is
one such area).


> I really hope nconnect is not just a workaround for some undiscovered
> performance issue. All that does is kick the can down the road.
>=20
> But a word of experience from SMB3 multichannel - more connections =
also
> bring more issues for customers. Inevitably, with many connections
> active under load, one or more will experience disconnects or =
slowdowns.
> When this happens, some very unpredictable and hard to diagnose
> behaviors start to occur. For example, all that careful load balancing
> immediately goes out the window, and retries start to take over the
> latencies. Some IOs sail through (the ones on the good connections) =
and
> others delay for many seconds (while the connection is reestablished).
> I don't recommend starting this effort with such a lofty goal as 8, 10
> or 16 connections, especially with a protocol such as NFSv3.

+1

Learn to crawl then walk then run.


> JMHO.
>=20
> Tom.
>=20
>=20
>>>>> If maxconn is specified with a datagram transport, does the mount
>>>>> operation fail, or is the setting is ignored?
>>>>=20
>>>> Perhaps we can add a warning on the mount command saying that =
option
>>>> is ignored but succeed the mount.
>>>>=20
>>>>> If maxconn is a hint, when does the client open additional
>>>>> connections?
>>>>>=20
>>>>> IMO documentation should be clear that this setting is not for the
>>>>> purpose of multipathing/trunking (using multiple NICs on the =
client
>>>>> or server). The client has to do trunking detection/discovery in =
that
>>>>> case, and nconnect doesn't add that logic. This is strictly for
>>>>> enabling multiple connections between one client-server IP address
>>>>> pair.
>>>>=20
>>>> I agree this should be as that last statement says multiple =
connection
>>>> to the same IP and in my option this shouldn't be a hint.
>>>>=20
>>>>> Do we need to state explicitly that all transport connections for =
a
>>>>> mount (or client-server pair) are the same connection type (i.e., =
all
>>>>> TCP or all RDMA, never a mix)?
>>>>=20
>>>> That might be an interesting future option but I think for now, we =
can
>>>> clearly say it's a TCP only option in documentation which can =
always
>>>> be changed if extension to that functionality will be implemented.
>>>=20
>>> Is there a reason you feel RDMA shouldn't be included? I've tried
>>> nconnect with my RDMA rig, and didn't see any problem with it.
>> No reason, I should have said "a single type of a connection only
>> option" not a mix. Of course with RDMA even with a single connection
>> we can achieve almost max bandwidth so having using nconnect seems
>> unnecessary.
>>>>>> Then further down the track, we might change the actual number of
>>>>>> connections automatically if a way can be found to do that =
without cost.
>>>>>=20
>>>>> Fair enough.
>>>>>=20
>>>>>=20
>>>>>> Do you have any objections apart from the nconnect=3D mount =
option?
>>>>>=20
>>>>> Well I realize my last e-mail sounded a little negative, but I'm
>>>>> actually in favor of adding the ability to open multiple =
connections
>>>>> per client-server pair. I just want to be careful about making =
this
>>>>> a feature that has as few downsides as possible right from the =
start.
>>>>> I'll try to be more helpful in my responses.
>>>>>=20
>>>>> Remaining implementation issues that IMO need to be sorted:
>>>>=20
>>>> I'm curious are you saying all this need to be resolved before we
>>>> consider including this functionality? These are excellent =
questions
>>>> but I think they imply some complex enhancements (like ability to =
do
>>>> different schedulers and not only round robin) that are =
"enhancement"
>>>> and not requirements.
>>>>=20
>>>>> =E2=80=A2 We want to take care that the client can recover network =
resources
>>>>> that have gone idle. Can we reuse the auto-close logic to close =
extra
>>>>> connections?
>>>> Since we are using round-robin scheduler then can we consider any
>>>> resources going idle?
>>>=20
>>> Again, I was thinking of nconnect as a hint here, not as a fixed
>>> number of connections.
>>>=20
>>>=20
>>>> It's hard to know the future, we might set a
>>>> timer after which we can say that a connection has been idle for =
long
>>>> enough time and we close it and as soon as that happens the traffic =
is
>>>> going to be generated again and we'll have to pay the penalty of
>>>> establishing a new connection before sending traffic.
>>>>=20
>>>>> =E2=80=A2 How will the client schedule requests on multiple =
connections?
>>>>> Should we enable the use of different schedulers?
>>>> That's an interesting idea but I don't think it shouldn't stop the
>>>> round robin solution from going thru.
>>>>=20
>>>>> =E2=80=A2 How will retransmits be handled?
>>>>> =E2=80=A2 How will the client recover from broken connections? =
Today's clients
>>>>> use disconnect to determine when to retransmit, thus there might =
be
>>>>> some unwanted interactions here that result in mount hangs.
>>>>> =E2=80=A2 Assume NFSv4.1 session ID rather than client ID =
trunking: is Linux
>>>>> client support in place for this already?
>>>>> =E2=80=A2 Are there any concerns about how the Linux server DRC =
will behave in
>>>>> multi-connection scenarios?
>>>>=20
>>>> I think we've talked about retransmission question. Retransmission =
are
>>>> handled by existing logic and are done by the same transport (ie
>>>> connection).
>>>=20
>>> Given the proposition that nconnect will be a hint (eventually) in
>>> the form of a dynamically managed set of connections, I think we =
need
>>> to answer some of these questions again. The answers could be "not
>>> yet implemented" or "no way jose".
>>>=20
>>> It would be helpful if the answers were all in one place (eg a =
design
>>> document or FAQ).
>>>=20
>>>=20
>>>>> None of these seem like a deal breaker. And possibly several of =
these
>>>>> are already decided, but just need to be published/documented.
>>>>>=20
>>>>>=20
>>>>> --
>>>>> Chuck Lever
>>>=20
>>> --
>>> Chuck Lever

--
Chuck Lever



