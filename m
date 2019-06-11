Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F5323CF76
	for <lists+linux-nfs@lfdr.de>; Tue, 11 Jun 2019 16:52:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388362AbfFKOwC (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 11 Jun 2019 10:52:02 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:56686 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388097AbfFKOwC (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 11 Jun 2019 10:52:02 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5BEhUDd096395;
        Tue, 11 Jun 2019 14:51:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2018-07-02; bh=5Ue8RznSQyRqCo4hCQ32PNUvk8mkbqOGBg1MkAWtISk=;
 b=UM31aFNo78VYHK9soPSCLXx+lImjOJnX2AoBQdMcxGr+f90R0K3VU/GPX3lO+g8GYNbz
 Nd7z7FCTEM9Nh4zsA6exdhrEli2AigwO1CTaNaqaHZJH7VlGtLBQFQFSds/jn7oLPT2p
 24TSqA+GtlHPw4WS6wvXGQ/16VDam0lqyXNbr0qz7Vbg5HBMq1rcYIS8I5YVAJ5FV8fv
 EROPbVjfbUE92/25vhyhSsWY28gDz3eqtabZ3y2g2dXgw5TqX3YAhPt+5IpvCSi6RgqW
 7lXeBE8/5M5PD/zoR5JsmWYjev/oGfRmdxSHS+mzFmw308MfcbMww9L8fZxHH1wvFMqZ 5g== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2130.oracle.com with ESMTP id 2t02henuw3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Jun 2019 14:51:49 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5BEonTD071313;
        Tue, 11 Jun 2019 14:51:48 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 2t1jphg4ae-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Jun 2019 14:51:48 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x5BEphNJ027334;
        Tue, 11 Jun 2019 14:51:46 GMT
Received: from anon-dhcp-171.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 11 Jun 2019 07:51:42 -0700
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH 0/9] Multiple network connections for a single NFS mount.
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <87lfy9vsgf.fsf@notabene.neil.brown.name>
Date:   Tue, 11 Jun 2019 10:51:41 -0400
Cc:     Olga Kornievskaia <aglo@umich.edu>,
        Anna Schumaker <Anna.Schumaker@netapp.com>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <3B887552-91FB-493A-8FDF-411562811B36@oracle.com>
References: <155917564898.3988.6096672032831115016.stgit@noble.brown>
 <001DED71-0E0D-46B1-BA34-84E6ACCBB79F@oracle.com>
 <87muj3tuuk.fsf@notabene.neil.brown.name>
 <4316E30B-1BD7-4F0E-8375-03E9F85FFD2B@oracle.com>
 <87lfy9vsgf.fsf@notabene.neil.brown.name>
To:     NeilBrown <neilb@suse.com>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9284 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906110098
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9284 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906110098
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Neil-


> On Jun 10, 2019, at 9:09 PM, NeilBrown <neilb@suse.com> wrote:
>=20
> On Fri, May 31 2019, Chuck Lever wrote:
>=20
>>> On May 30, 2019, at 6:56 PM, NeilBrown <neilb@suse.com> wrote:
>>>=20
>>> On Thu, May 30 2019, Chuck Lever wrote:
>>>=20
>>>> Hi Neil-
>>>>=20
>>>> Thanks for chasing this a little further.
>>>>=20
>>>>=20
>>>>> On May 29, 2019, at 8:41 PM, NeilBrown <neilb@suse.com> wrote:
>>>>>=20
>>>>> This patch set is based on the patches in the multipath_tcp branch =
of
>>>>> git://git.linux-nfs.org/projects/trondmy/nfs-2.6.git
>>>>>=20
>>>>> I'd like to add my voice to those supporting this work and wanting =
to
>>>>> see it land.
>>>>> We have had customers/partners wanting this sort of functionality =
for
>>>>> years.  In SLES releases prior to SLE15, we've provide a
>>>>> "nosharetransport" mount option, so that several filesystem could =
be
>>>>> mounted from the same server and each would get its own TCP
>>>>> connection.
>>>>=20
>>>> Is it well understood why splitting up the TCP connections result
>>>> in better performance?
>>>>=20
>>>>=20
>>>>> In SLE15 we are using this 'nconnect' feature, which is much =
nicer.
>>>>>=20
>>>>> Partners have assured us that it improves total throughput,
>>>>> particularly with bonded networks, but we haven't had any concrete
>>>>> data until Olga Kornievskaia provided some concrete test data - =
thanks
>>>>> Olga!
>>>>>=20
>>>>> My understanding, as I explain in one of the patches, is that =
parallel
>>>>> hardware is normally utilized by distributing flows, rather than
>>>>> packets.  This avoid out-of-order deliver of packets in a flow.
>>>>> So multiple flows are needed to utilizes parallel hardware.
>>>>=20
>>>> Indeed.
>>>>=20
>>>> However I think one of the problems is what happens in simpler =
scenarios.
>>>> We had reports that using nconnect > 1 on virtual clients made =
things
>>>> go slower. It's not always wise to establish multiple connections
>>>> between the same two IP addresses. It depends on the hardware on =
each
>>>> end, and the network conditions.
>>>=20
>>> This is a good argument for leaving the default at '1'.  When
>>> documentation is added to nfs(5), we can make it clear that the =
optimal
>>> number is dependant on hardware.
>>=20
>> Is there any visibility into the NIC hardware that can guide this =
setting?
>>=20
>=20
> I doubt it, partly because there is more than just the NIC hardware at =
issue.
> There is also the server-side hardware and possibly hardware in the =
middle.

So the best guidance is YMMV. :-)


>>>> What about situations where the network capabilities between server =
and
>>>> client change? Problem is that neither endpoint can detect that; =
TCP
>>>> usually just deals with it.
>>>=20
>>> Being able to manually change (-o remount) the number of connections
>>> might be useful...
>>=20
>> Ugh. I have problems with the administrative interface for this =
feature,
>> and this is one of them.
>>=20
>> Another is what prevents your client from using a different nconnect=3D=

>> setting on concurrent mounts of the same server? It's another case of =
a
>> per-mount setting being used to control a resource that is shared =
across
>> mounts.
>=20
> I think that horse has well and truly bolted.
> It would be nice to have a "server" abstraction visible to user-space
> where we could adjust settings that make sense server-wide, and then a =
way
> to mount individual filesystems from that "server" - but we don't.

Even worse, there will be some resource sharing between containers that
might be undesirable. The host should have ultimate control over those
resources.

But that is neither here nor there.


> Probably the best we can do is to document (in nfs(5)) which options =
are
> per-server and which are per-mount.

Alternately, the behavior of this option could be documented this way:

The default value is one. To resolve conflicts between nconnect settings =
on
different mount points to the same server, the value set on the first =
mount
applies until there are no more mounts of that server, unless =
nosharecache
is specified. When following a referral to another server, the nconnect
setting is inherited, but the effective value is determined by other =
mounts
of that server that are already in place.

I hate to say it, but the way to make this work deterministically is to
ask administrators to ensure that the setting is the same on all mounts
of the same server. Again I'd rather this take care of itself, but it
appears that is not going to be possible.


>> Adding user tunables has never been known to increase the aggregate
>> amount of happiness in the universe. I really hope we can come up =
with
>> a better administrative interface... ideally, none would be best.
>=20
> I agree that none would be best.  It isn't clear to me that that is
> possible.
> At present, we really don't have enough experience with this
> functionality to be able to say what the trade-offs are.
> If we delay the functionality until we have the perfect interface,
> we may never get that experience.
>=20
> We can document "nconnect=3D" as a hint, and possibly add that
> "nconnect=3D1" is a firm guarantee that more will not be used.

Agree that 1 should be the default. If we make this setting a
hint, then perhaps it should be renamed; nconnect makes it sound
like the client will always open N connections. How about "maxconn" ?

Then, to better define the behavior:

The range of valid maxconn values is 1 to 3? to 8? to NCPUS? to the
count of the client=E2=80=99s NUMA nodes? I=E2=80=99d be in favor of a =
small number
to start with. Solaris' experience with multiple connections is that
there is very little benefit past 8.

If maxconn is specified with a datagram transport, does the mount
operation fail, or is the setting is ignored?

If maxconn is a hint, when does the client open additional
connections?

IMO documentation should be clear that this setting is not for the
purpose of multipathing/trunking (using multiple NICs on the client
or server). The client has to do trunking detection/discovery in that
case, and nconnect doesn't add that logic. This is strictly for
enabling multiple connections between one client-server IP address
pair.

Do we need to state explicitly that all transport connections for a
mount (or client-server pair) are the same connection type (i.e., all
TCP or all RDMA, never a mix)?


> Then further down the track, we might change the actual number of
> connections automatically if a way can be found to do that without =
cost.

Fair enough.


> Do you have any objections apart from the nconnect=3D mount option?

Well I realize my last e-mail sounded a little negative, but I'm
actually in favor of adding the ability to open multiple connections
per client-server pair. I just want to be careful about making this
a feature that has as few downsides as possible right from the start.
I'll try to be more helpful in my responses.

Remaining implementation issues that IMO need to be sorted:

=E2=80=A2 We want to take care that the client can recover network =
resources
that have gone idle. Can we reuse the auto-close logic to close extra
connections?
=E2=80=A2 How will the client schedule requests on multiple connections?
Should we enable the use of different schedulers?
=E2=80=A2 How will retransmits be handled?
=E2=80=A2 How will the client recover from broken connections? Today's =
clients
use disconnect to determine when to retransmit, thus there might be
some unwanted interactions here that result in mount hangs.
=E2=80=A2 Assume NFSv4.1 session ID rather than client ID trunking: is =
Linux
client support in place for this already?
=E2=80=A2 Are there any concerns about how the Linux server DRC will =
behave in
multi-connection scenarios?

None of these seem like a deal breaker. And possibly several of these
are already decided, but just need to be published/documented.


--
Chuck Lever



