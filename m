Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 41CDF30159
	for <lists+linux-nfs@lfdr.de>; Thu, 30 May 2019 19:57:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726330AbfE3R5E (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 30 May 2019 13:57:04 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:50756 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726171AbfE3R5E (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 30 May 2019 13:57:04 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4UHhogU152691;
        Thu, 30 May 2019 17:56:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2018-07-02; bh=u+VbjuXHmbuSH+7l3EuDhcWRyI8cw/U8uHNHpwacKAs=;
 b=4x04/lEHMybZTY55ycLZlqXwMI+QV/BsvQydFNU1xVbQDg4ls3Iq5bKFYNO3D21DmW9C
 AkX4IjGSZ198s94qbcMgZ6nonK7Gnony+5UfHEBfKxd2ZsuWJ0CHJLhbT2Nh+qVil/Gc
 q02/r8t+0SwkQTUST23aM5hcEs3oo0f98WFcZ2tfFSnpHafjCkmCIgHQ7AvA0lDoXRKQ
 q8xA5pjvtfk/z2UUavRRl4PB8n0xBGdvdj/J1xdo4KYezRpIC6Q3D2YmVE9FjfV9zqd8
 2QBBedoQ97Uo5RS04F5oJzlWBBscvH6hm2LLgYxw4gkjYdNHlymsoaLUlqIQu5D2Lpv9 Eg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 2spxbqhndu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 May 2019 17:56:31 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4UHuUSk087225;
        Thu, 30 May 2019 17:56:30 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 2sqh74f775-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 May 2019 17:56:30 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x4UHuS0M031532;
        Thu, 30 May 2019 17:56:30 GMT
Received: from anon-dhcp-171.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 30 May 2019 10:56:27 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH 0/9] Multiple network connections for a single NFS mount.
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <155917564898.3988.6096672032831115016.stgit@noble.brown>
Date:   Thu, 30 May 2019 13:56:26 -0400
Cc:     Olga Kornievskaia <aglo@umich.edu>,
        Anna Schumaker <Anna.Schumaker@netapp.com>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <001DED71-0E0D-46B1-BA34-84E6ACCBB79F@oracle.com>
References: <155917564898.3988.6096672032831115016.stgit@noble.brown>
To:     NeilBrown <neilb@suse.com>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9272 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1905300125
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9272 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905300125
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Neil-

Thanks for chasing this a little further.


> On May 29, 2019, at 8:41 PM, NeilBrown <neilb@suse.com> wrote:
>=20
> This patch set is based on the patches in the multipath_tcp branch of
> git://git.linux-nfs.org/projects/trondmy/nfs-2.6.git
>=20
> I'd like to add my voice to those supporting this work and wanting to
> see it land.
> We have had customers/partners wanting this sort of functionality for
> years.  In SLES releases prior to SLE15, we've provide a
> "nosharetransport" mount option, so that several filesystem could be
> mounted from the same server and each would get its own TCP
> connection.

Is it well understood why splitting up the TCP connections result
in better performance?


> In SLE15 we are using this 'nconnect' feature, which is much nicer.
>=20
> Partners have assured us that it improves total throughput,
> particularly with bonded networks, but we haven't had any concrete
> data until Olga Kornievskaia provided some concrete test data - thanks
> Olga!
>=20
> My understanding, as I explain in one of the patches, is that parallel
> hardware is normally utilized by distributing flows, rather than
> packets.  This avoid out-of-order deliver of packets in a flow.
> So multiple flows are needed to utilizes parallel hardware.

Indeed.

However I think one of the problems is what happens in simpler =
scenarios.
We had reports that using nconnect > 1 on virtual clients made things
go slower. It's not always wise to establish multiple connections
between the same two IP addresses. It depends on the hardware on each
end, and the network conditions.


> An earlier version of this patch set was posted in April 2017 and
> Chuck raised two issues:
> 1/ mountstats only reports on one xprt per mount
> 2/ session establishment needs to happen on a single xprt, as you
>    cannot bind other xprts to the session until the session is
>    established.
> I've added patches to address these, and also to add the extra xprts
> to the debugfs info.
>=20
> I've also re-arrange the patches a bit, merged two, and remove the
> restriction to TCP and NFSV4.x,x>=3D1.  Discussions seemed to suggest
> these restrictions were not needed, I can see no need.

RDMA could certainly benefit for exactly the reason you describe above.


> There is a bug with the load balancing code from Trond's tree.
> While an xprt is attached to a client, the queuelen is incremented.
> Some requests (particularly BIND_CONN_TO_SESSION) pass in an xprt,
> and the queuelen was not incremented in this case, but it was
> decremented.  This causes it to go 'negative' and havoc results.
>=20
> I wonder if the last three patches (*Allow multiple connection*) could
> be merged into a single patch.
>=20
> I haven't given much thought to automatically determining the optimal
> number of connections, but I doubt it can be done transparently with
> any reliability.

A Solaris client can open up to 8 connections to a server, but there
are always some scenarios where the heuristic creates too many
connections and becomes a performance issue.

We also have concerns about running the client out of privileged port
space.

The problem with nconnect is that it can work well, but it can also be
a very easy way to shoot yourself in the foot.

I also share the concerns about dealing properly with retransmission
and NFSv4 sessions.


> When adding a connection improves throughput, then
> it was almost certainly a good thing to do. When adding a connection
> doesn't improve throughput, the implications are less obvious.
> My feeling is that a protocol enhancement where the serve suggests an
> upper limit and the client increases toward that limit when it notices
> xmit backlog, would be about the best we could do.  But we would need
> a lot more experience with the functionality first.

What about situations where the network capabilities between server and
client change? Problem is that neither endpoint can detect that; TCP
usually just deals with it.

Related Work:

We now have protocol (more like conventions) for clients to discover
when a server has additional endpoints so that it can establish
connections to each of them.

https://datatracker.ietf.org/doc/rfc8587/

and

https://datatracker.ietf.org/doc/draft-ietf-nfsv4-rfc5661-msns-update/

Boiled down, the client uses fs_locations and trunking detection to
figure out when two IP addresses are the same server instance.

This facility can also be used to establish a connection over a
different path if network connectivity is lost.

There has also been some exploration of MP-TCP. The magic happens
under the transport socket in the network layer, and the RPC client
is not involved.


> Comments most welcome.  I'd love to see this, or something similar,
> merged.
>=20
> Thanks,
> NeilBrown
>=20
> ---
>=20
> NeilBrown (4):
>      NFS: send state management on a single connection.
>      SUNRPC: enhance rpc_clnt_show_stats() to report on all xprts.
>      SUNRPC: add links for all client xprts to debugfs
>=20
> Trond Myklebust (5):
>      SUNRPC: Add basic load balancing to the transport switch
>      SUNRPC: Allow creation of RPC clients with multiple connections
>      NFS: Add a mount option to specify number of TCP connections to =
use
>      NFSv4: Allow multiple connections to NFSv4.x servers
>      pNFS: Allow multiple connections to the DS
>      NFS: Allow multiple connections to a NFSv2 or NFSv3 server
>=20
>=20
> fs/nfs/client.c                      |    3 +
> fs/nfs/internal.h                    |    2 +
> fs/nfs/nfs3client.c                  |    1=20
> fs/nfs/nfs4client.c                  |   13 ++++-
> fs/nfs/nfs4proc.c                    |   22 +++++---
> fs/nfs/super.c                       |   12 ++++
> include/linux/nfs_fs_sb.h            |    1=20
> include/linux/sunrpc/clnt.h          |    1=20
> include/linux/sunrpc/sched.h         |    1=20
> include/linux/sunrpc/xprt.h          |    1=20
> include/linux/sunrpc/xprtmultipath.h |    2 +
> net/sunrpc/clnt.c                    |   98 =
++++++++++++++++++++++++++++++++--
> net/sunrpc/debugfs.c                 |   46 ++++++++++------
> net/sunrpc/sched.c                   |    3 +
> net/sunrpc/stats.c                   |   15 +++--
> net/sunrpc/sunrpc.h                  |    3 +
> net/sunrpc/xprtmultipath.c           |   23 +++++++-
> 17 files changed, 204 insertions(+), 43 deletions(-)
>=20
> --
> Signature
>=20

--
Chuck Lever



