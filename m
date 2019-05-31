Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3EDD730F38
	for <lists+linux-nfs@lfdr.de>; Fri, 31 May 2019 15:46:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726609AbfEaNqu (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 31 May 2019 09:46:50 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:52140 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726330AbfEaNqt (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 31 May 2019 09:46:49 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4VDXZot070721;
        Fri, 31 May 2019 13:46:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2018-07-02; bh=YevcSStIQmeKY8dtK8z+elohGEvjs3g8yk9dQuyeUMs=;
 b=NUn+bBtSyo9YNim3kK8MgKGYLf4ROjg7M8inB7TsybMSguO95sZDFiXicUKYQhIU9V1H
 XNx6gc9akLnA2hfH12+VTTEc54YCqDTmoSjvSl3in7naG/EW0pyXYb3T9iIBPrRYvOHl
 latc3YzS6EjWGYsUXpLswZa/T7ByayT4YN3xH/fTMLYeVGZlaXd1cW3liJ1Qqby/UmbI
 ia0JwJNzGf5ywvCjHv7H5d8lOEpsgqtMyVgHvq4CjJQkbGHU6IVqHyPJuk3veINfZXIb
 XdHWLMlc9h2zIPaswYlzw0IhFCsFrHwtFN/lfKahG1x/CdpRxAt75pY3+oGMAo4bfihD TA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2130.oracle.com with ESMTP id 2spu7dxjrx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 31 May 2019 13:46:38 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4VDk68F168322;
        Fri, 31 May 2019 13:46:37 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 2sr31wecbm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 31 May 2019 13:46:37 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x4VDkY50022849;
        Fri, 31 May 2019 13:46:34 GMT
Received: from anon-dhcp-171.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 31 May 2019 06:46:33 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH 0/9] Multiple network connections for a single NFS mount.
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <87muj3tuuk.fsf@notabene.neil.brown.name>
Date:   Fri, 31 May 2019 09:46:32 -0400
Cc:     Olga Kornievskaia <aglo@umich.edu>,
        Anna Schumaker <Anna.Schumaker@netapp.com>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <4316E30B-1BD7-4F0E-8375-03E9F85FFD2B@oracle.com>
References: <155917564898.3988.6096672032831115016.stgit@noble.brown>
 <001DED71-0E0D-46B1-BA34-84E6ACCBB79F@oracle.com>
 <87muj3tuuk.fsf@notabene.neil.brown.name>
To:     NeilBrown <neilb@suse.com>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9273 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1905310087
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9273 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905310087
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On May 30, 2019, at 6:56 PM, NeilBrown <neilb@suse.com> wrote:
>=20
> On Thu, May 30 2019, Chuck Lever wrote:
>=20
>> Hi Neil-
>>=20
>> Thanks for chasing this a little further.
>>=20
>>=20
>>> On May 29, 2019, at 8:41 PM, NeilBrown <neilb@suse.com> wrote:
>>>=20
>>> This patch set is based on the patches in the multipath_tcp branch =
of
>>> git://git.linux-nfs.org/projects/trondmy/nfs-2.6.git
>>>=20
>>> I'd like to add my voice to those supporting this work and wanting =
to
>>> see it land.
>>> We have had customers/partners wanting this sort of functionality =
for
>>> years.  In SLES releases prior to SLE15, we've provide a
>>> "nosharetransport" mount option, so that several filesystem could be
>>> mounted from the same server and each would get its own TCP
>>> connection.
>>=20
>> Is it well understood why splitting up the TCP connections result
>> in better performance?
>>=20
>>=20
>>> In SLE15 we are using this 'nconnect' feature, which is much nicer.
>>>=20
>>> Partners have assured us that it improves total throughput,
>>> particularly with bonded networks, but we haven't had any concrete
>>> data until Olga Kornievskaia provided some concrete test data - =
thanks
>>> Olga!
>>>=20
>>> My understanding, as I explain in one of the patches, is that =
parallel
>>> hardware is normally utilized by distributing flows, rather than
>>> packets.  This avoid out-of-order deliver of packets in a flow.
>>> So multiple flows are needed to utilizes parallel hardware.
>>=20
>> Indeed.
>>=20
>> However I think one of the problems is what happens in simpler =
scenarios.
>> We had reports that using nconnect > 1 on virtual clients made things
>> go slower. It's not always wise to establish multiple connections
>> between the same two IP addresses. It depends on the hardware on each
>> end, and the network conditions.
>=20
> This is a good argument for leaving the default at '1'.  When
> documentation is added to nfs(5), we can make it clear that the =
optimal
> number is dependant on hardware.

Is there any visibility into the NIC hardware that can guide this =
setting?


>> What about situations where the network capabilities between server =
and
>> client change? Problem is that neither endpoint can detect that; TCP
>> usually just deals with it.
>=20
> Being able to manually change (-o remount) the number of connections
> might be useful...

Ugh. I have problems with the administrative interface for this feature,
and this is one of them.

Another is what prevents your client from using a different nconnect=3D
setting on concurrent mounts of the same server? It's another case of a
per-mount setting being used to control a resource that is shared across
mounts.

Adding user tunables has never been known to increase the aggregate
amount of happiness in the universe. I really hope we can come up with
a better administrative interface... ideally, none would be best.


>> Related Work:
>>=20
>> We now have protocol (more like conventions) for clients to discover
>> when a server has additional endpoints so that it can establish
>> connections to each of them.
>>=20
>> https://datatracker.ietf.org/doc/rfc8587/
>>=20
>> and
>>=20
>> =
https://datatracker.ietf.org/doc/draft-ietf-nfsv4-rfc5661-msns-update/
>>=20
>> Boiled down, the client uses fs_locations and trunking detection to
>> figure out when two IP addresses are the same server instance.
>>=20
>> This facility can also be used to establish a connection over a
>> different path if network connectivity is lost.
>>=20
>> There has also been some exploration of MP-TCP. The magic happens
>> under the transport socket in the network layer, and the RPC client
>> is not involved.
>=20
> I would think that SCTP would be the best protocol for NFS to use as =
it
> supports multi-streaming - several independent streams.  That would
> require that hardware understands it of course.
>=20
> Though I have examined MP-TCP closely, it looks like it is still fully
> sequenced, so it would be tricky for two RPC messages to be assembled
> into TCP frames completely independently - at least you would need
> synchronization on the sequence number.
>=20
> Thanks for your thoughts,
> NeilBrown
>=20
>=20
>>=20
>>=20
>>> Comments most welcome.  I'd love to see this, or something similar,
>>> merged.
>>>=20
>>> Thanks,
>>> NeilBrown
>>>=20
>>> ---
>>>=20
>>> NeilBrown (4):
>>>     NFS: send state management on a single connection.
>>>     SUNRPC: enhance rpc_clnt_show_stats() to report on all xprts.
>>>     SUNRPC: add links for all client xprts to debugfs
>>>=20
>>> Trond Myklebust (5):
>>>     SUNRPC: Add basic load balancing to the transport switch
>>>     SUNRPC: Allow creation of RPC clients with multiple connections
>>>     NFS: Add a mount option to specify number of TCP connections to =
use
>>>     NFSv4: Allow multiple connections to NFSv4.x servers
>>>     pNFS: Allow multiple connections to the DS
>>>     NFS: Allow multiple connections to a NFSv2 or NFSv3 server
>>>=20
>>>=20
>>> fs/nfs/client.c                      |    3 +
>>> fs/nfs/internal.h                    |    2 +
>>> fs/nfs/nfs3client.c                  |    1=20
>>> fs/nfs/nfs4client.c                  |   13 ++++-
>>> fs/nfs/nfs4proc.c                    |   22 +++++---
>>> fs/nfs/super.c                       |   12 ++++
>>> include/linux/nfs_fs_sb.h            |    1=20
>>> include/linux/sunrpc/clnt.h          |    1=20
>>> include/linux/sunrpc/sched.h         |    1=20
>>> include/linux/sunrpc/xprt.h          |    1=20
>>> include/linux/sunrpc/xprtmultipath.h |    2 +
>>> net/sunrpc/clnt.c                    |   98 =
++++++++++++++++++++++++++++++++--
>>> net/sunrpc/debugfs.c                 |   46 ++++++++++------
>>> net/sunrpc/sched.c                   |    3 +
>>> net/sunrpc/stats.c                   |   15 +++--
>>> net/sunrpc/sunrpc.h                  |    3 +
>>> net/sunrpc/xprtmultipath.c           |   23 +++++++-
>>> 17 files changed, 204 insertions(+), 43 deletions(-)
>>>=20
>>> --
>>> Signature
>>>=20
>>=20
>> --
>> Chuck Lever

--
Chuck Lever



