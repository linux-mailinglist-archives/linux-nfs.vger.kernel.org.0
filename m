Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 14F26416F3
	for <lists+linux-nfs@lfdr.de>; Tue, 11 Jun 2019 23:35:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392019AbfFKVfZ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 11 Jun 2019 17:35:25 -0400
Received: from p3plsmtpa08-04.prod.phx3.secureserver.net ([173.201.193.105]:42173
        "EHLO p3plsmtpa08-04.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387764AbfFKVfY (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 11 Jun 2019 17:35:24 -0400
Received: from [192.168.0.56] ([24.218.182.144])
        by :SMTPAUTH: with ESMTPSA
        id aoQLh0K2xsbXdaoQLhUccy; Tue, 11 Jun 2019 14:35:22 -0700
Subject: Re: [PATCH 0/9] Multiple network connections for a single NFS mount.
To:     Olga Kornievskaia <aglo@umich.edu>,
        Chuck Lever <chuck.lever@oracle.com>
Cc:     NeilBrown <neilb@suse.com>,
        Anna Schumaker <Anna.Schumaker@netapp.com>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
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
 <A74B7E29-CAC7-428B-8B29-606F4B174D1A@oracle.com>
 <CAN-5tyFP9qK9Tjv-FCeZJGMnhhnsZh0+VCguuRaDOG2kB9A-OQ@mail.gmail.com>
From:   Tom Talpey <tom@talpey.com>
Message-ID: <e33a22ef-b335-36e1-ea7f-2d2b5b2ed390@talpey.com>
Date:   Tue, 11 Jun 2019 17:35:20 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CAN-5tyFP9qK9Tjv-FCeZJGMnhhnsZh0+VCguuRaDOG2kB9A-OQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfKB0VVGZ6lodOdJk7HCm2HjEwGLV83FYDdjiUsYiLtR2y4QHzZQlSoWJ2zek4PSytcFNj2oC9Tm4NXRRBUIGe9FwLchRqtM1SsOLRWvcVgul34wviHP+
 CjgxJU8vb6vHc4oON4AFgyhyZr80v7fbspN2Z1HJ5tqPEQoqgApXAOAmymm60NEnmpiY/D0mt+9iet8thmjtsHmW+p/0vDUp5RcHQZ+DCs7waB7PNFKdXUaz
 8O2acEQ1ToxMACxzZAMu8kkmPGiDx32YN5q+KgqahQBTlGrq9hx86J4AlkbXZS8f5GYqJEMUuSoIpoTIss6CERFT+iK3Vh3jqn6scyeZk3Y=
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 6/11/2019 5:10 PM, Olga Kornievskaia wrote:
> On Tue, Jun 11, 2019 at 4:09 PM Chuck Lever <chuck.lever@oracle.com> wrote:
>>
>>
>>
>>> On Jun 11, 2019, at 4:02 PM, Tom Talpey <tom@talpey.com> wrote:
>>>
>>> On 6/11/2019 3:13 PM, Olga Kornievskaia wrote:
>>>> On Tue, Jun 11, 2019 at 1:47 PM Chuck Lever <chuck.lever@oracle.com> wrote:
>>>>>
>>>>>
>>>>>
>>>>>> On Jun 11, 2019, at 11:34 AM, Olga Kornievskaia <aglo@umich.edu> wrote:
>>>>>>
>>>>>> On Tue, Jun 11, 2019 at 10:52 AM Chuck Lever <chuck.lever@oracle.com> wrote:
>>>>>>>
>>>>>>> Hi Neil-
>>>>>>>
>>>>>>>
>>>>>>>> On Jun 10, 2019, at 9:09 PM, NeilBrown <neilb@suse.com> wrote:
>>>>>>>>
>>>>>>>> On Fri, May 31 2019, Chuck Lever wrote:
>>>>>>>>
>>>>>>>>>> On May 30, 2019, at 6:56 PM, NeilBrown <neilb@suse.com> wrote:
>>>>>>>>>>
>>>>>>>>>> On Thu, May 30 2019, Chuck Lever wrote:
>>>>>>>>>>
>>>>>>>>>>> Hi Neil-
>>>>>>>>>>>
>>>>>>>>>>> Thanks for chasing this a little further.
>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>>> On May 29, 2019, at 8:41 PM, NeilBrown <neilb@suse.com> wrote:
>>>>>>>>>>>>
>>>>>>>>>>>> This patch set is based on the patches in the multipath_tcp branch of
>>>>>>>>>>>> git://git.linux-nfs.org/projects/trondmy/nfs-2.6.git
>>>>>>>>>>>>
>>>>>>>>>>>> I'd like to add my voice to those supporting this work and wanting to
>>>>>>>>>>>> see it land.
>>>>>>>>>>>> We have had customers/partners wanting this sort of functionality for
>>>>>>>>>>>> years.  In SLES releases prior to SLE15, we've provide a
>>>>>>>>>>>> "nosharetransport" mount option, so that several filesystem could be
>>>>>>>>>>>> mounted from the same server and each would get its own TCP
>>>>>>>>>>>> connection.
>>>>>>>>>>>
>>>>>>>>>>> Is it well understood why splitting up the TCP connections result
>>>>>>>>>>> in better performance?
>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>>> In SLE15 we are using this 'nconnect' feature, which is much nicer.
>>>>>>>>>>>>
>>>>>>>>>>>> Partners have assured us that it improves total throughput,
>>>>>>>>>>>> particularly with bonded networks, but we haven't had any concrete
>>>>>>>>>>>> data until Olga Kornievskaia provided some concrete test data - thanks
>>>>>>>>>>>> Olga!
>>>>>>>>>>>>
>>>>>>>>>>>> My understanding, as I explain in one of the patches, is that parallel
>>>>>>>>>>>> hardware is normally utilized by distributing flows, rather than
>>>>>>>>>>>> packets.  This avoid out-of-order deliver of packets in a flow.
>>>>>>>>>>>> So multiple flows are needed to utilizes parallel hardware.
>>>>>>>>>>>
>>>>>>>>>>> Indeed.
>>>>>>>>>>>
>>>>>>>>>>> However I think one of the problems is what happens in simpler scenarios.
>>>>>>>>>>> We had reports that using nconnect > 1 on virtual clients made things
>>>>>>>>>>> go slower. It's not always wise to establish multiple connections
>>>>>>>>>>> between the same two IP addresses. It depends on the hardware on each
>>>>>>>>>>> end, and the network conditions.
>>>>>>>>>>
>>>>>>>>>> This is a good argument for leaving the default at '1'.  When
>>>>>>>>>> documentation is added to nfs(5), we can make it clear that the optimal
>>>>>>>>>> number is dependant on hardware.
>>>>>>>>>
>>>>>>>>> Is there any visibility into the NIC hardware that can guide this setting?
>>>>>>>>>
>>>>>>>>
>>>>>>>> I doubt it, partly because there is more than just the NIC hardware at issue.
>>>>>>>> There is also the server-side hardware and possibly hardware in the middle.
>>>>>>>
>>>>>>> So the best guidance is YMMV. :-)
>>>>>>>
>>>>>>>
>>>>>>>>>>> What about situations where the network capabilities between server and
>>>>>>>>>>> client change? Problem is that neither endpoint can detect that; TCP
>>>>>>>>>>> usually just deals with it.
>>>>>>>>>>
>>>>>>>>>> Being able to manually change (-o remount) the number of connections
>>>>>>>>>> might be useful...
>>>>>>>>>
>>>>>>>>> Ugh. I have problems with the administrative interface for this feature,
>>>>>>>>> and this is one of them.
>>>>>>>>>
>>>>>>>>> Another is what prevents your client from using a different nconnect=
>>>>>>>>> setting on concurrent mounts of the same server? It's another case of a
>>>>>>>>> per-mount setting being used to control a resource that is shared across
>>>>>>>>> mounts.
>>>>>>>>
>>>>>>>> I think that horse has well and truly bolted.
>>>>>>>> It would be nice to have a "server" abstraction visible to user-space
>>>>>>>> where we could adjust settings that make sense server-wide, and then a way
>>>>>>>> to mount individual filesystems from that "server" - but we don't.
>>>>>>>
>>>>>>> Even worse, there will be some resource sharing between containers that
>>>>>>> might be undesirable. The host should have ultimate control over those
>>>>>>> resources.
>>>>>>>
>>>>>>> But that is neither here nor there.
>>>>>>>
>>>>>>>
>>>>>>>> Probably the best we can do is to document (in nfs(5)) which options are
>>>>>>>> per-server and which are per-mount.
>>>>>>>
>>>>>>> Alternately, the behavior of this option could be documented this way:
>>>>>>>
>>>>>>> The default value is one. To resolve conflicts between nconnect settings on
>>>>>>> different mount points to the same server, the value set on the first mount
>>>>>>> applies until there are no more mounts of that server, unless nosharecache
>>>>>>> is specified. When following a referral to another server, the nconnect
>>>>>>> setting is inherited, but the effective value is determined by other mounts
>>>>>>> of that server that are already in place.
>>>>>>>
>>>>>>> I hate to say it, but the way to make this work deterministically is to
>>>>>>> ask administrators to ensure that the setting is the same on all mounts
>>>>>>> of the same server. Again I'd rather this take care of itself, but it
>>>>>>> appears that is not going to be possible.
>>>>>>>
>>>>>>>
>>>>>>>>> Adding user tunables has never been known to increase the aggregate
>>>>>>>>> amount of happiness in the universe. I really hope we can come up with
>>>>>>>>> a better administrative interface... ideally, none would be best.
>>>>>>>>
>>>>>>>> I agree that none would be best.  It isn't clear to me that that is
>>>>>>>> possible.
>>>>>>>> At present, we really don't have enough experience with this
>>>>>>>> functionality to be able to say what the trade-offs are.
>>>>>>>> If we delay the functionality until we have the perfect interface,
>>>>>>>> we may never get that experience.
>>>>>>>>
>>>>>>>> We can document "nconnect=" as a hint, and possibly add that
>>>>>>>> "nconnect=1" is a firm guarantee that more will not be used.
>>>>>>>
>>>>>>> Agree that 1 should be the default. If we make this setting a
>>>>>>> hint, then perhaps it should be renamed; nconnect makes it sound
>>>>>>> like the client will always open N connections. How about "maxconn" ?
>>>>>>
>>>>>> "maxconn" sounds to me like it's possible that the code would choose a
>>>>>> number that's less than that which I think would be misleading given
>>>>>> that the implementation (as is now) will open the specified number of
>>>>>> connection (bounded by the hard coded default we currently have set at
>>>>>> some value X which I'm in favor is increasing from 16 to 32).
>>>>>
>>>>> Earlier in this thread, Neil proposed to make nconnect a hint. Sounds
>>>>> like the long term plan is to allow "up to N" connections with some
>>>>> mechanism to create new connections on-demand." maxconn fits that idea
>>>>> better, though I'd prefer no new mount options... the point being that
>>>>> eventually, this setting is likely to be an upper bound rather than a
>>>>> fixed value.
>>>> Fair enough. If the dynamic connection management is in the cards,
>>>> then "maxconn" would be an appropriate name but I also agree with you
>>>> that if we are doing dynamic management then we shouldn't need a mount
>>>> option at all. I, for one, am skeptical that we'll gain benefits from
>>>> dynamic connection management given that cost of tearing and starting
>>>> the new connection.
>>>> I would argue that since now no dynamic management is implemented then
>>>> we stay with the "nconnect" mount option and if and when such feature
>>>> is found desirable then we get rid of the mount option all together.
>>>>>>> Then, to better define the behavior:
>>>>>>>
>>>>>>> The range of valid maxconn values is 1 to 3? to 8? to NCPUS? to the
>>>>>>> count of the client’s NUMA nodes? I’d be in favor of a small number
>>>>>>> to start with. Solaris' experience with multiple connections is that
>>>>>>> there is very little benefit past 8.
>>>>>>
>>>>>> My linux to linux experience has been that there is benefit of having
>>>>>> more than 8 connections. I have previously posted results that went
>>>>>> upto 10 connection (it's on my list of thing to test uptown 16). With
>>>>>> the Netapp performance lab they have maxed out 25G connection setup
>>>>>> they were using with so they didn't experiment with nconnect=8 but no
>>>>>> evidence that with a larger network pipe performance would stop
>>>>>> improving.
>>>>>>
>>>>>> Given the existing performance studies, I would like to argue that
>>>>>> having such low values are not warranted.
>>>>>
>>>>> They are warranted until we have a better handle on the risks of a
>>>>> performance regression occurring with large nconnect settings. The
>>>>> maximum number can always be raised once we are confident the
>>>>> behaviors are well understood.
>>>>>
>>>>> Also, I'd like to see some careful studies that demonstrate why
>>>>> you don't see excellent results with just two or three connections.
>>>>> Nearly full link bandwidth has been achieved with MP-TCP and two or
>>>>> three subflows on one NIC. Why is it not possible with NFS/TCP ?
>>>> Performance tests that do simple buffer to buffer measurements are one
>>>> thing but doing a complicated system that involves a filesystem is
>>>> another thing. The closest we can get to this network performance
>>>> tests is NFSoRDMA which saves various copies and as you know with that
>>>> we can get close to network link capacity.
>>
>> Yes, in certain circumstances, but there are still areas that can
>> benefit or need substantial improvement (NFS WRITE performance is
>> one such area).
>>
>>
>>> I really hope nconnect is not just a workaround for some undiscovered
>>> performance issue. All that does is kick the can down the road.
>>>
>>> But a word of experience from SMB3 multichannel - more connections also
>>> bring more issues for customers. Inevitably, with many connections
>>> active under load, one or more will experience disconnects or slowdowns.
>>> When this happens, some very unpredictable and hard to diagnose
>>> behaviors start to occur. For example, all that careful load balancing
>>> immediately goes out the window, and retries start to take over the
>>> latencies. Some IOs sail through (the ones on the good connections) and
>>> others delay for many seconds (while the connection is reestablished).
>>> I don't recommend starting this effort with such a lofty goal as 8, 10
>>> or 16 connections, especially with a protocol such as NFSv3.
>>
>> +1
>>
>> Learn to crawl then walk then run.
> 
> Neil,
> 
> What's your experience with providing "nosharedtransport" option to
> the SLE customers? Were you are having customers coming back and
> complain about the multiple connections issues?
> 
> When the connection is having issues, because we have to retransmit
> from the same port, there isn't anything to be done but wait for the
> new connection to be established and add to the latency of the
> operation over the bad connection. There could be smarts added to the
> (new) scheduler to grade the connections and if connection is having
> issues not assign tasks to it until it recovers but all that are
> additional improvement and I don't think we should restrict
> connections right of the bet. This is an option that allows for 8, 10,
> 16 (32) connections but it doesn't mean customer have to set such high
> value and we can recommend for low values.
> 
> Solaris has it, Microsoft has it and linux has been deprived of it,
> let's join the party.

Let me be clear about one thing - SMB3 has it because the protocol
is designed for it. Multichannel leverages SMB2 sessions to allow
retransmit on any active bound connection. NFSv4.1 (and later) have
a similar capability.

NFSv2 and NFSv3, however, do not, and I've already stated my concerns
about pushing them too far. I agree with your sentiment, but for these
protocols, please bear in mind the risks.

Tom.

> 
> 
>>
>>
>>> JMHO.
>>>
>>> Tom.
>>>
>>>
>>>>>>> If maxconn is specified with a datagram transport, does the mount
>>>>>>> operation fail, or is the setting is ignored?
>>>>>>
>>>>>> Perhaps we can add a warning on the mount command saying that option
>>>>>> is ignored but succeed the mount.
>>>>>>
>>>>>>> If maxconn is a hint, when does the client open additional
>>>>>>> connections?
>>>>>>>
>>>>>>> IMO documentation should be clear that this setting is not for the
>>>>>>> purpose of multipathing/trunking (using multiple NICs on the client
>>>>>>> or server). The client has to do trunking detection/discovery in that
>>>>>>> case, and nconnect doesn't add that logic. This is strictly for
>>>>>>> enabling multiple connections between one client-server IP address
>>>>>>> pair.
>>>>>>
>>>>>> I agree this should be as that last statement says multiple connection
>>>>>> to the same IP and in my option this shouldn't be a hint.
>>>>>>
>>>>>>> Do we need to state explicitly that all transport connections for a
>>>>>>> mount (or client-server pair) are the same connection type (i.e., all
>>>>>>> TCP or all RDMA, never a mix)?
>>>>>>
>>>>>> That might be an interesting future option but I think for now, we can
>>>>>> clearly say it's a TCP only option in documentation which can always
>>>>>> be changed if extension to that functionality will be implemented.
>>>>>
>>>>> Is there a reason you feel RDMA shouldn't be included? I've tried
>>>>> nconnect with my RDMA rig, and didn't see any problem with it.
>>>> No reason, I should have said "a single type of a connection only
>>>> option" not a mix. Of course with RDMA even with a single connection
>>>> we can achieve almost max bandwidth so having using nconnect seems
>>>> unnecessary.
>>>>>>>> Then further down the track, we might change the actual number of
>>>>>>>> connections automatically if a way can be found to do that without cost.
>>>>>>>
>>>>>>> Fair enough.
>>>>>>>
>>>>>>>
>>>>>>>> Do you have any objections apart from the nconnect= mount option?
>>>>>>>
>>>>>>> Well I realize my last e-mail sounded a little negative, but I'm
>>>>>>> actually in favor of adding the ability to open multiple connections
>>>>>>> per client-server pair. I just want to be careful about making this
>>>>>>> a feature that has as few downsides as possible right from the start.
>>>>>>> I'll try to be more helpful in my responses.
>>>>>>>
>>>>>>> Remaining implementation issues that IMO need to be sorted:
>>>>>>
>>>>>> I'm curious are you saying all this need to be resolved before we
>>>>>> consider including this functionality? These are excellent questions
>>>>>> but I think they imply some complex enhancements (like ability to do
>>>>>> different schedulers and not only round robin) that are "enhancement"
>>>>>> and not requirements.
>>>>>>
>>>>>>> • We want to take care that the client can recover network resources
>>>>>>> that have gone idle. Can we reuse the auto-close logic to close extra
>>>>>>> connections?
>>>>>> Since we are using round-robin scheduler then can we consider any
>>>>>> resources going idle?
>>>>>
>>>>> Again, I was thinking of nconnect as a hint here, not as a fixed
>>>>> number of connections.
>>>>>
>>>>>
>>>>>> It's hard to know the future, we might set a
>>>>>> timer after which we can say that a connection has been idle for long
>>>>>> enough time and we close it and as soon as that happens the traffic is
>>>>>> going to be generated again and we'll have to pay the penalty of
>>>>>> establishing a new connection before sending traffic.
>>>>>>
>>>>>>> • How will the client schedule requests on multiple connections?
>>>>>>> Should we enable the use of different schedulers?
>>>>>> That's an interesting idea but I don't think it shouldn't stop the
>>>>>> round robin solution from going thru.
>>>>>>
>>>>>>> • How will retransmits be handled?
>>>>>>> • How will the client recover from broken connections? Today's clients
>>>>>>> use disconnect to determine when to retransmit, thus there might be
>>>>>>> some unwanted interactions here that result in mount hangs.
>>>>>>> • Assume NFSv4.1 session ID rather than client ID trunking: is Linux
>>>>>>> client support in place for this already?
>>>>>>> • Are there any concerns about how the Linux server DRC will behave in
>>>>>>> multi-connection scenarios?
>>>>>>
>>>>>> I think we've talked about retransmission question. Retransmission are
>>>>>> handled by existing logic and are done by the same transport (ie
>>>>>> connection).
>>>>>
>>>>> Given the proposition that nconnect will be a hint (eventually) in
>>>>> the form of a dynamically managed set of connections, I think we need
>>>>> to answer some of these questions again. The answers could be "not
>>>>> yet implemented" or "no way jose".
>>>>>
>>>>> It would be helpful if the answers were all in one place (eg a design
>>>>> document or FAQ).
>>>>>
>>>>>
>>>>>>> None of these seem like a deal breaker. And possibly several of these
>>>>>>> are already decided, but just need to be published/documented.
>>>>>>>
>>>>>>>
>>>>>>> --
>>>>>>> Chuck Lever
>>>>>
>>>>> --
>>>>> Chuck Lever
>>
>> --
>> Chuck Lever
>>
>>
>>
> 
> 
