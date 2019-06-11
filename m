Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A5763D034
	for <lists+linux-nfs@lfdr.de>; Tue, 11 Jun 2019 17:05:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391528AbfFKPFi (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 11 Jun 2019 11:05:38 -0400
Received: from p3plsmtpa06-01.prod.phx3.secureserver.net ([173.201.192.102]:45149
        "EHLO p3plsmtpa06-01.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2391376AbfFKPFh (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 11 Jun 2019 11:05:37 -0400
Received: from [192.168.0.67] ([24.218.182.144])
        by :SMTPAUTH: with ESMTPSA
        id aiL9hTYdNAgxcaiL9hEUZu; Tue, 11 Jun 2019 08:05:36 -0700
Subject: Re: [PATCH 0/9] Multiple network connections for a single NFS mount.
To:     Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neilb@suse.com>
Cc:     Olga Kornievskaia <aglo@umich.edu>,
        Anna Schumaker <Anna.Schumaker@netapp.com>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
References: <155917564898.3988.6096672032831115016.stgit@noble.brown>
 <001DED71-0E0D-46B1-BA34-84E6ACCBB79F@oracle.com>
 <87muj3tuuk.fsf@notabene.neil.brown.name>
 <4316E30B-1BD7-4F0E-8375-03E9F85FFD2B@oracle.com>
 <87lfy9vsgf.fsf@notabene.neil.brown.name>
 <3B887552-91FB-493A-8FDF-411562811B36@oracle.com>
From:   Tom Talpey <tom@talpey.com>
Message-ID: <d1c0dd53-bf4d-46e9-110f-0c4cecf41991@talpey.com>
Date:   Tue, 11 Jun 2019 11:05:35 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <3B887552-91FB-493A-8FDF-411562811B36@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfI6ZLf/uiIDLgXWqBhzbwqciZ+HXMJXJEbsJLM33yVrLtChR6tvfpNCX8EgPVxc9xop9y7PO5RTe8co0zkb+nD1sGsPywVSEOIp7obRNM9cI9QWJB6Xu
 boSkkk0Vu/enMqGj3vCq4/q3jAmoQCGU5PoZkBxo/P97xSSDNYjyEs+Bg5cWZ8QNAGHepPqzWtVTfRh9HXlwr3utt6dwS/mjIb40e7oqNwUFMYgJCPAm+BBt
 MD/Fa3jsK0BANG8c5elucC+GuxKF5bGomZZ/9E0cHi0z2tzRHhzbwplpQPoWgMqF6NM7P9IdSf4IaxRMIfps5oYIRqYMN3ffaKWwLPaC7/U=
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 6/11/2019 10:51 AM, Chuck Lever wrote:
> Hi Neil-
> 
> 
>> On Jun 10, 2019, at 9:09 PM, NeilBrown <neilb@suse.com> wrote:
>>
>> On Fri, May 31 2019, Chuck Lever wrote:
>>
>>>> On May 30, 2019, at 6:56 PM, NeilBrown <neilb@suse.com> wrote:
>>>>
>>>> On Thu, May 30 2019, Chuck Lever wrote:
>>>>
>>>>> Hi Neil-
>>>>>
>>>>> Thanks for chasing this a little further.
>>>>>
>>>>>
>>>>>> On May 29, 2019, at 8:41 PM, NeilBrown <neilb@suse.com> wrote:
>>>>>>
>>>>>> This patch set is based on the patches in the multipath_tcp branch of
>>>>>> git://git.linux-nfs.org/projects/trondmy/nfs-2.6.git
>>>>>>
>>>>>> I'd like to add my voice to those supporting this work and wanting to
>>>>>> see it land.
>>>>>> We have had customers/partners wanting this sort of functionality for
>>>>>> years.  In SLES releases prior to SLE15, we've provide a
>>>>>> "nosharetransport" mount option, so that several filesystem could be
>>>>>> mounted from the same server and each would get its own TCP
>>>>>> connection.
>>>>>
>>>>> Is it well understood why splitting up the TCP connections result
>>>>> in better performance?
>>>>>
>>>>>
>>>>>> In SLE15 we are using this 'nconnect' feature, which is much nicer.
>>>>>>
>>>>>> Partners have assured us that it improves total throughput,
>>>>>> particularly with bonded networks, but we haven't had any concrete
>>>>>> data until Olga Kornievskaia provided some concrete test data - thanks
>>>>>> Olga!
>>>>>>
>>>>>> My understanding, as I explain in one of the patches, is that parallel
>>>>>> hardware is normally utilized by distributing flows, rather than
>>>>>> packets.  This avoid out-of-order deliver of packets in a flow.
>>>>>> So multiple flows are needed to utilizes parallel hardware.
>>>>>
>>>>> Indeed.
>>>>>
>>>>> However I think one of the problems is what happens in simpler scenarios.
>>>>> We had reports that using nconnect > 1 on virtual clients made things
>>>>> go slower. It's not always wise to establish multiple connections
>>>>> between the same two IP addresses. It depends on the hardware on each
>>>>> end, and the network conditions.
>>>>
>>>> This is a good argument for leaving the default at '1'.  When
>>>> documentation is added to nfs(5), we can make it clear that the optimal
>>>> number is dependant on hardware.
>>>
>>> Is there any visibility into the NIC hardware that can guide this setting?
>>>
>>
>> I doubt it, partly because there is more than just the NIC hardware at issue.
>> There is also the server-side hardware and possibly hardware in the middle.
> 
> So the best guidance is YMMV. :-)
> 
> 
>>>>> What about situations where the network capabilities between server and
>>>>> client change? Problem is that neither endpoint can detect that; TCP
>>>>> usually just deals with it.
>>>>
>>>> Being able to manually change (-o remount) the number of connections
>>>> might be useful...
>>>
>>> Ugh. I have problems with the administrative interface for this feature,
>>> and this is one of them.
>>>
>>> Another is what prevents your client from using a different nconnect=
>>> setting on concurrent mounts of the same server? It's another case of a
>>> per-mount setting being used to control a resource that is shared across
>>> mounts.
>>
>> I think that horse has well and truly bolted.
>> It would be nice to have a "server" abstraction visible to user-space
>> where we could adjust settings that make sense server-wide, and then a way
>> to mount individual filesystems from that "server" - but we don't.
> 
> Even worse, there will be some resource sharing between containers that
> might be undesirable. The host should have ultimate control over those
> resources.
> 
> But that is neither here nor there.
> 
> 
>> Probably the best we can do is to document (in nfs(5)) which options are
>> per-server and which are per-mount.
> 
> Alternately, the behavior of this option could be documented this way:
> 
> The default value is one. To resolve conflicts between nconnect settings on
> different mount points to the same server, the value set on the first mount
> applies until there are no more mounts of that server, unless nosharecache
> is specified. When following a referral to another server, the nconnect
> setting is inherited, but the effective value is determined by other mounts
> of that server that are already in place.
> 
> I hate to say it, but the way to make this work deterministically is to
> ask administrators to ensure that the setting is the same on all mounts
> of the same server. Again I'd rather this take care of itself, but it
> appears that is not going to be possible.
> 
> 
>>> Adding user tunables has never been known to increase the aggregate
>>> amount of happiness in the universe. I really hope we can come up with
>>> a better administrative interface... ideally, none would be best.
>>
>> I agree that none would be best.  It isn't clear to me that that is
>> possible.
>> At present, we really don't have enough experience with this
>> functionality to be able to say what the trade-offs are.
>> If we delay the functionality until we have the perfect interface,
>> we may never get that experience.
>>
>> We can document "nconnect=" as a hint, and possibly add that
>> "nconnect=1" is a firm guarantee that more will not be used.
> 
> Agree that 1 should be the default. If we make this setting a
> hint, then perhaps it should be renamed; nconnect makes it sound
> like the client will always open N connections. How about "maxconn" ?
> 
> Then, to better define the behavior:
> 
> The range of valid maxconn values is 1 to 3? to 8? to NCPUS? to the
> count of the client’s NUMA nodes? I’d be in favor of a small number
> to start with. Solaris' experience with multiple connections is that
> there is very little benefit past 8.

If it's of any help, the Windows SMB3 multichannel client limits itself
to 4. The benefit rises slowly at that point, and the unpredictability
heads for the roof, especially when multiple NICs and network paths
are in play. The setting can be increased, but we discourage it for
anything but testing.

Tom.


> If maxconn is specified with a datagram transport, does the mount
> operation fail, or is the setting is ignored?
> 
> If maxconn is a hint, when does the client open additional
> connections?
> 
> IMO documentation should be clear that this setting is not for the
> purpose of multipathing/trunking (using multiple NICs on the client
> or server). The client has to do trunking detection/discovery in that
> case, and nconnect doesn't add that logic. This is strictly for
> enabling multiple connections between one client-server IP address
> pair.
> 
> Do we need to state explicitly that all transport connections for a
> mount (or client-server pair) are the same connection type (i.e., all
> TCP or all RDMA, never a mix)?
> 
> 
>> Then further down the track, we might change the actual number of
>> connections automatically if a way can be found to do that without cost.
> 
> Fair enough.
> 
> 
>> Do you have any objections apart from the nconnect= mount option?
> 
> Well I realize my last e-mail sounded a little negative, but I'm
> actually in favor of adding the ability to open multiple connections
> per client-server pair. I just want to be careful about making this
> a feature that has as few downsides as possible right from the start.
> I'll try to be more helpful in my responses.
> 
> Remaining implementation issues that IMO need to be sorted:
> 
> • We want to take care that the client can recover network resources
> that have gone idle. Can we reuse the auto-close logic to close extra
> connections?
> • How will the client schedule requests on multiple connections?
> Should we enable the use of different schedulers?
> • How will retransmits be handled?
> • How will the client recover from broken connections? Today's clients
> use disconnect to determine when to retransmit, thus there might be
> some unwanted interactions here that result in mount hangs.
> • Assume NFSv4.1 session ID rather than client ID trunking: is Linux
> client support in place for this already?
> • Are there any concerns about how the Linux server DRC will behave in
> multi-connection scenarios?
> 
> None of these seem like a deal breaker. And possibly several of these
> are already decided, but just need to be published/documented.
> 
> 
> --
> Chuck Lever
> 
> 
> 
> 
> 
