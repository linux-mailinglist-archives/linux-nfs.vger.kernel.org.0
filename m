Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D3C9D19E14B
	for <lists+linux-nfs@lfdr.de>; Sat,  4 Apr 2020 01:11:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728060AbgDCXL1 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 3 Apr 2020 19:11:27 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:33392 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727829AbgDCXL1 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 3 Apr 2020 19:11:27 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 033N8vAT092107;
        Fri, 3 Apr 2020 23:11:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=7Nqjn2ulBnbTkYR+o5kksI1EzIYuawWtIIpQcCZnc30=;
 b=DHCNAiE140OBw+eYgyniGWeL++KOCWAQt8eItFD+z1CuTq09y3wB+QTqk9K6idHFDdNT
 alQiZxEhZ30gbFbMC30yGMXzA0a9N7A3CcVnM5xnTXHQNoDSav8xCdkBHM9U9tpkYJTa
 z0zn7bilW3ZeNLWrwzANmBYxH5wTbKNnLV/vckEdeCnHPL+/TKE7Nr3rHkgWTtqc7QOY
 72x9BwKyKICafwM4QmiWGTnKcC1WxVJhcjREf2XV/ZVzw4kQGbuWsBpXwR9kH5pCVnRB
 K2SlTvw1NT6WtYD6W0u7nkqLWVmyYZJ1yEmBoZp51l5VfbvzSfiePyLyyimoE4YLFM7P iQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 303aqj41ku-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 03 Apr 2020 23:11:19 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 033N7S26081100;
        Fri, 3 Apr 2020 23:11:18 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 304sju947k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 03 Apr 2020 23:11:18 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 033NBEKZ008566;
        Fri, 3 Apr 2020 23:11:17 GMT
Received: from anon-dhcp-153.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 03 Apr 2020 16:11:13 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH RFC] SUNRPC: Backchannel RPCs don't fail when the
 transport disconnects
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <063db847f7f2129504463919978dede3d328d0b6.camel@hammerspace.com>
Date:   Fri, 3 Apr 2020 19:11:12 -0400
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <15F1952A-07B1-40E0-BB24-0A7354BD6CB7@oracle.com>
References: <20200403193802.2887.41182.stgit@klimt.1015granger.net>
 <1fe55c49410ee8d97c5247644a4678b665fd41e7.camel@hammerspace.com>
 <E472C4D7-313C-48F2-8D4E-8D1F81357979@oracle.com>
 <B385D770-D511-4E72-B0D7-90ED66892C2D@oracle.com>
 <063db847f7f2129504463919978dede3d328d0b6.camel@hammerspace.com>
To:     Trond Myklebust <trondmy@hammerspace.com>,
        Bruce Fields <bfields@fieldses.org>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9580 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 mlxscore=0
 malwarescore=0 phishscore=0 suspectscore=2 mlxlogscore=999 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004030175
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9580 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 clxscore=1015
 malwarescore=0 impostorscore=0 mlxlogscore=999 spamscore=0 mlxscore=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 suspectscore=2
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004030175
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Apr 3, 2020, at 6:43 PM, Trond Myklebust <trondmy@hammerspace.com> =
wrote:
>=20
> On Fri, 2020-04-03 at 17:46 -0400, Chuck Lever wrote:
>>> On Apr 3, 2020, at 4:05 PM, Chuck Lever <chuck.lever@oracle.com>
>>> wrote:
>>>=20
>>> Hi Trond, thanks for the look!
>>>=20
>>>> On Apr 3, 2020, at 4:00 PM, Trond Myklebust <
>>>> trondmy@hammerspace.com> wrote:
>>>>=20
>>>> On Fri, 2020-04-03 at 15:42 -0400, Chuck Lever wrote:
>>>>> Commit 3832591e6fa5 ("SUNRPC: Handle connection issues
>>>>> correctly on
>>>>> the back channel") intended to make backchannel RPCs fail
>>>>> immediately when there is no forward channel connection. What's
>>>>> currently happening is, when the forward channel conneciton
>>>>> goes
>>>>> away, backchannel operations are causing hard loops because
>>>>> call_transmit_status's SOFTCONN logic ignores ENOTCONN.
>>>>=20
>>>> Won't RPC_TASK_NOCONNECT do the right thing? It should cause the
>>>> request to exit with an ENOTCONN error when it hits
>>>> call_connect().
>>>=20
>>> OK, so does that mean SOFTCONN is entirely the wrong semantic here?
>>>=20
>>> Was RPC_TASK_NOCONNECT available when 3832591e6fa5 was merged?
>>=20
>> It turns out 3832591e6fa5 is not related. It's 58255a4e3ce5 that
>> added
>> RPC_TASK_SOFTCONN on NFSv4 callback Calls.
>>=20
>> However, the server uses nfsd4_run_cb_work() for both NFSv4.0 and
>> NFSv4.1 callbacks. IMO a fix for this will have to take care that
>> RPC_TASK_NOCONNECT is not set on NFSv4.0 callback tasks.
>=20
> Possibly, but don't we really want to let such a NFSv4.0 request fail
> and send another CB_NULL? There is already version-specific code in
> nfsd4_process_cb_update() to set up the callback client.

A not unreasonable conclusion. But it's hard to test the NFSv4.0 case,
since it's instability on the forward channel that is tickling this
problem. The NFSv4.0 callback connection is not affected by that.

Maybe Bruce has a thought? Otherwise we can try an unconditional
NOCONNECT for now. RPC_TASK_NOCONNECT was added three years after
58255a4e3ce5, fwiw...


>> Unfortunately the looping behavior appears also related to the
>> RPC_IS_SIGNALLED bug I reported earlier this week. The CB request is
>> signalled as it is firing up, and then drops into a hard loop.
>>=20
>=20
> Hmm... Is there any reason why xprt_rdma_alloc_slot() should not be
> checking if the transport is being shut down? After all, if the
> transport is being destroyed here, then there is no point in =
allocating
> a slot for that specific RDMA transport (it's not as if it can be
> reused elsewhere).

The trace for the NULL rqst I posted a couple days ago shows the
signal occurring after xprt_enq_xmit, which is well past the
call_reserve step.

I don't see any special SOFTCONN related logic in call_reserveresult,
I suspect call_reserve is not currently set up to handle this case.


>>            nfsd-1986  [001]   123.028240:
>> svc_drop:             addr=3D192.168.2.51:52077 xid=3D0x489a88f6
>> flags=3DRQ_SECURE|RQ_USEDEFERRAL|RQ_SPLICE_OK|RQ_BUSY
>>   kworker/u8:12-442   [003]   123.028242:
>> rpc_task_signalled:   task:47@3 flags=3DASYNC|DYNAMIC|SOFT|NOCONNECT
>> runstate=3DRUNNING|ACTIVE status=3D0 action=3Drpc_prepare_task
>>   kworker/u8:10-440   [000]   123.028289:
>> rpc_task_run_action:  task:47@3 flags=3DASYNC|DYNAMIC|SOFT|NOCONNECT
>> runstate=3DRUNNING|ACTIVE|SIGNALLED status=3D0 =
action=3Drpc_prepare_task
>>   kworker/u8:10-440   [000]   123.028289:
>> rpc_task_run_action:  task:47@3 flags=3DASYNC|DYNAMIC|SOFT|NOCONNECT
>> runstate=3DRUNNING|ACTIVE|SIGNALLED status=3D0 action=3Dcall_start
>>   kworker/u8:10-440   [000]   123.028291:
>> rpc_request:          task:47@3 nfs4_cbv1 CB_RECALL (async)
>>   kworker/u8:10-440   [000]   123.028291:
>> rpc_task_run_action:  task:47@3 flags=3DASYNC|DYNAMIC|SOFT|NOCONNECT
>> runstate=3DRUNNING|ACTIVE|SIGNALLED status=3D0 action=3Dcall_reserve
>>   kworker/u8:10-440   [000]   123.028298:
>> rpc_task_run_action:  task:47@3 flags=3DASYNC|DYNAMIC|SOFT|NOCONNECT
>> runstate=3DRUNNING|ACTIVE|SIGNALLED status=3D0 =
action=3Dcall_reserveresult
>>   kworker/u8:10-440   [000]   123.028299:
>> rpc_task_run_action:  task:47@3 flags=3DASYNC|DYNAMIC|SOFT|NOCONNECT
>> runstate=3DRUNNING|ACTIVE|SIGNALLED status=3D0 action=3Dcall_refresh
>>   kworker/u8:10-440   [000]   123.028324:
>> rpc_task_run_action:  task:47@3 flags=3DASYNC|DYNAMIC|SOFT|NOCONNECT
>> runstate=3DRUNNING|ACTIVE|SIGNALLED status=3D0 =
action=3Dcall_refreshresult
>>   kworker/u8:10-440   [000]   123.028324:
>> rpc_task_run_action:  task:47@3 flags=3DASYNC|DYNAMIC|SOFT|NOCONNECT
>> runstate=3DRUNNING|ACTIVE|SIGNALLED status=3D0 action=3Dcall_allocate
>>   kworker/u8:10-440   [000]   123.028340:
>> rpc_task_run_action:  task:47@3 flags=3DASYNC|DYNAMIC|SOFT|NOCONNECT
>> runstate=3DRUNNING|ACTIVE|SIGNALLED status=3D0 action=3Dcall_encode
>>   kworker/u8:10-440   [000]   123.028356:
>> xprt_enq_xmit:        task:47@3 xid=3D0x8b95e935 seqno=3D0 stage=3D4
>>   kworker/u8:10-440   [000]   123.028357:
>> rpc_task_run_action:  task:47@3 flags=3DASYNC|DYNAMIC|SOFT|NOCONNECT
>> runstate=3DRUNNING|ACTIVE|NEED_XMIT|NEED_RECV|SIGNALLED status=3D0
>> action=3Dcall_transmit
>>   kworker/u8:10-440   [000]   123.028363:
>> xprt_reserve_cong:    task:47@3 snd_task:47 cong=3D0 cwnd=3D256
>>   kworker/u8:10-440   [000]   123.028365:
>> xprt_transmit:        task:47@3 xid=3D0x8b95e935 seqno=3D0 =
status=3D-512
>>   kworker/u8:10-440   [000]   123.028368:
>> xprt_release_cong:    task:47@3 snd_task:4294967295 cong=3D0 cwnd=3D256=

>>   kworker/u8:10-440   [000]   123.028368:
>> rpc_task_run_action:  task:47@3 flags=3DASYNC|DYNAMIC|SOFT|NOCONNECT
>> runstate=3DRUNNING|ACTIVE|NEED_RECV|SIGNALLED status=3D0
>> action=3Dcall_transmit_status
>>   kworker/u8:10-440   [000]   123.028371:
>> rpc_task_sleep:       task:47@3 flags=3DASYNC|DYNAMIC|SOFT|NOCONNECT
>> runstate=3DRUNNING|ACTIVE|NEED_RECV|SIGNALLED status=3D0 timeout=3D0
>> queue=3Dxprt_pending
>>   kworker/u8:10-440   [000]   123.028376:
>> rpc_task_wakeup:      task:47@3 flags=3DASYNC|DYNAMIC|SOFT|NOCONNECT
>> runstate=3DRUNNING|QUEUED|ACTIVE|NEED_RECV|SIGNALLED status=3D-107
>> timeout=3D9000 queue=3Dxprt_pending
>>   kworker/u8:10-440   [000]   123.028377:
>> rpc_task_run_action:  task:47@3 flags=3DASYNC|DYNAMIC|SOFT|NOCONNECT
>> runstate=3DRUNNING|ACTIVE|NEED_RECV|SIGNALLED status=3D-107
>> action=3Dxprt_timer
>>   kworker/u8:10-440   [000]   123.028377:
>> rpc_task_run_action:  task:47@3 flags=3DASYNC|DYNAMIC|SOFT|NOCONNECT
>> runstate=3DRUNNING|ACTIVE|NEED_RECV|SIGNALLED status=3D-107
>> action=3Dcall_status
>>   kworker/u8:10-440   [000]   123.028378:
>> rpc_call_status:      task:47@3 status=3D-107
>>   kworker/u8:10-440   [000]   123.028378:
>> rpc_task_run_action:  task:47@3 flags=3DASYNC|DYNAMIC|SOFT|NOCONNECT
>> runstate=3DRUNNING|ACTIVE|NEED_RECV|SIGNALLED status=3D0
>> action=3Dcall_encode
>>   kworker/u8:10-440   [000]   123.028380:
>> xprt_enq_xmit:        task:47@3 xid=3D0x8b95e935 seqno=3D0 stage=3D4
>>   kworker/u8:10-440   [000]   123.028380:
>> rpc_task_run_action:  task:47@3 flags=3DASYNC|DYNAMIC|SOFT|NOCONNECT
>> runstate=3DRUNNING|ACTIVE|NEED_XMIT|NEED_RECV|SIGNALLED status=3D0
>> action=3Dcall_transmit
>>   kworker/u8:10-440   [000]   123.028381:
>> xprt_reserve_cong:    task:47@3 snd_task:47 cong=3D0 cwnd=3D256
>>   kworker/u8:10-440   [000]   123.028381:
>> xprt_transmit:        task:47@3 xid=3D0x8b95e935 seqno=3D0 =
status=3D-512
>>   kworker/u8:10-440   [000]   123.028382:
>> xprt_release_cong:    task:47@3 snd_task:4294967295 cong=3D0 cwnd=3D256=

>>   kworker/u8:10-440   [000]   123.028382:
>> rpc_task_run_action:  task:47@3 flags=3DASYNC|DYNAMIC|SOFT|NOCONNECT
>> runstate=3DRUNNING|ACTIVE|NEED_RECV|SIGNALLED status=3D0
>> action=3Dcall_transmit_status
>>=20
>> If we want to avoid the early RPC_IS_SIGNALLED check in the
>> scheduler,
>> I guess an alternative would be to have call_transmit_status() check
>> for
>> RPC_TASK_SIGNALLED. That's not as broad a fix, but it would address
>> both the NULL and the CB looping cases, IIUC.
>>=20
>>=20
>>>>> To avoid changing the behavior of call_transmit_status in the
>>>>> forward direction, make backchannel RPCs return with a
>>>>> different
>>>>> error than ENOTCONN when they fail.
>>>>>=20
>>>>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>>>>> ---
>>>>> net/sunrpc/xprtrdma/svc_rdma_backchannel.c |   15 ++++++++++---
>>>>> --
>>>>> net/sunrpc/xprtsock.c                      |    6 ++++--
>>>>> 2 files changed, 14 insertions(+), 7 deletions(-)
>>>>>=20
>>>>> I'm playing with this fix. It seems to be required in order to
>>>>> get
>>>>> Kerberos mounts to work under load with NFSv4.1 and later on
>>>>> RDMA.
>>>>>=20
>>>>> If there are no objections, I can carry this for v5.7-rc ...
>>>>>=20
>>>>>=20
>>>>> diff --git a/net/sunrpc/xprtrdma/svc_rdma_backchannel.c
>>>>> b/net/sunrpc/xprtrdma/svc_rdma_backchannel.c
>>>>> index d510a3a15d4b..b8a72d7fbcc2 100644
>>>>> --- a/net/sunrpc/xprtrdma/svc_rdma_backchannel.c
>>>>> +++ b/net/sunrpc/xprtrdma/svc_rdma_backchannel.c
>>>>> @@ -207,11 +207,16 @@ rpcrdma_bc_send_request(struct
>>>>> svcxprt_rdma
>>>>> *rdma, struct rpc_rqst *rqst)
>>>>>=20
>>>>> drop_connection:
>>>>> 	dprintk("svcrdma: failed to send bc call\n");
>>>>> -	return -ENOTCONN;
>>>>> +	return -EHOSTUNREACH;
>>>>> }
>>>>>=20
>>>>> -/* Send an RPC call on the passive end of a transport
>>>>> - * connection.
>>>>> +/**
>>>>> + * xprt_rdma_bc_send_request - send an RPC backchannel Call
>>>>> + * @rqst: RPC Call in rq_snd_buf
>>>>> + *
>>>>> + * Returns:
>>>>> + *	%0 if the RPC message has been sent
>>>>> + *	%-EHOSTUNREACH if the Call could not be sent
>>>>> */
>>>>> static int
>>>>> xprt_rdma_bc_send_request(struct rpc_rqst *rqst)
>>>>> @@ -225,11 +230,11 @@ xprt_rdma_bc_send_request(struct rpc_rqst
>>>>> *rqst)
>>>>>=20
>>>>> 	mutex_lock(&sxprt->xpt_mutex);
>>>>>=20
>>>>> -	ret =3D -ENOTCONN;
>>>>> +	ret =3D -EHOSTUNREACH;
>>>>> 	rdma =3D container_of(sxprt, struct svcxprt_rdma,
>>>>> sc_xprt);
>>>>> 	if (!test_bit(XPT_DEAD, &sxprt->xpt_flags)) {
>>>>> 		ret =3D rpcrdma_bc_send_request(rdma, rqst);
>>>>> -		if (ret =3D=3D -ENOTCONN)
>>>>> +		if (ret < 0)
>>>>> 			svc_close_xprt(sxprt);
>>>>> 	}
>>>>>=20
>>>>> diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
>>>>> index 17cb902e5153..92a358fd2ff0 100644
>>>>> --- a/net/sunrpc/xprtsock.c
>>>>> +++ b/net/sunrpc/xprtsock.c
>>>>> @@ -2543,7 +2543,9 @@ static int bc_sendto(struct rpc_rqst
>>>>> *req)
>>>>> 	req->rq_xtime =3D ktime_get();
>>>>> 	err =3D xprt_sock_sendmsg(transport->sock, &msg, xdr, 0,
>>>>> marker,
>>>>> &sent);
>>>>> 	xdr_free_bvec(xdr);
>>>>> -	if (err < 0 || sent !=3D (xdr->len + sizeof(marker)))
>>>>> +	if (err < 0)
>>>>> +		return -EHOSTUNREACH;
>>>>> +	if (sent !=3D (xdr->len + sizeof(marker)))
>>>>> 		return -EAGAIN;
>>>>> 	return sent;
>>>>> }
>>>>> @@ -2567,7 +2569,7 @@ static int bc_send_request(struct
>>>>> rpc_rqst
>>>>> *req)
>>>>> 	 */
>>>>> 	mutex_lock(&xprt->xpt_mutex);
>>>>> 	if (test_bit(XPT_DEAD, &xprt->xpt_flags))
>>>>> -		len =3D -ENOTCONN;
>>>>> +		len =3D -EHOSTUNREACH;
>>>>> 	else
>>>>> 		len =3D bc_sendto(req);
>>>>> 	mutex_unlock(&xprt->xpt_mutex);
>>>>>=20
>>>> --=20
>>>> Trond Myklebust
>>>> Linux NFS client maintainer, Hammerspace
>>>> trond.myklebust@hammerspace.com
>>>=20
>>> --
>>> Chuck Lever
>>=20
>> --
>> Chuck Lever
>>=20
>>=20
>>=20
> --=20
> Trond Myklebust
> CTO, Hammerspace Inc
> 4300 El Camino Real, Suite 105
> Los Altos, CA 94022
> www.hammer.space

--
Chuck Lever



