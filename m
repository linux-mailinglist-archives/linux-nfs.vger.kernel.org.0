Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B8C2D19DEF4
	for <lists+linux-nfs@lfdr.de>; Fri,  3 Apr 2020 22:05:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727593AbgDCUFV (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 3 Apr 2020 16:05:21 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:49018 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726368AbgDCUFV (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 3 Apr 2020 16:05:21 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 033JrcPB017850;
        Fri, 3 Apr 2020 20:05:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=cQNLhY+bhpvlGUR/P57ojFlAPbV7uozEb2AXzVrc3wQ=;
 b=XuFY2d9HBDN7OzuP/YE4auC7uOLfXiAhqg8clMS1l8THggDiY96bWdhYtTQNe+fT5E/K
 +kVjQbRpeOA8s+ifUWWw7S0AuHTqc95Uo17gVuDab3DgPu15gTO4eG3cR3RMD4yQZ3dE
 +31jC67hOMLqyC9yVe6YgB1pf76EiQN530KgBWIraxZx8xDfcqWLOhtn30HqYnfjbTs+
 yvJjsqNRyR84MKARtqlsO//2grPsTjIglBkyw3g3LtgSv1uzeUJRyJQkeS2L1RmrvAvX
 J3e2jLdZxiXn7Ec/cXjBbXH/K8Hfs9yRNFhJoIiPRp1nt8mc3aaSAMmvUVQA5Edz8FVS 1g== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 303cevk00y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 03 Apr 2020 20:05:18 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 033JrDZa132581;
        Fri, 3 Apr 2020 20:05:17 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 304sjttkbc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 03 Apr 2020 20:05:16 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 033K5E9T016265;
        Fri, 3 Apr 2020 20:05:15 GMT
Received: from anon-dhcp-153.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 03 Apr 2020 13:05:14 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH RFC] SUNRPC: Backchannel RPCs don't fail when the
 transport disconnects
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <1fe55c49410ee8d97c5247644a4678b665fd41e7.camel@hammerspace.com>
Date:   Fri, 3 Apr 2020 16:05:13 -0400
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <E472C4D7-313C-48F2-8D4E-8D1F81357979@oracle.com>
References: <20200403193802.2887.41182.stgit@klimt.1015granger.net>
 <1fe55c49410ee8d97c5247644a4678b665fd41e7.camel@hammerspace.com>
To:     Trond Myklebust <trondmy@hammerspace.com>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9580 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 mlxscore=0
 malwarescore=0 phishscore=0 suspectscore=2 mlxlogscore=999 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004030159
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9580 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 adultscore=0
 clxscore=1015 phishscore=0 lowpriorityscore=0 spamscore=0 malwarescore=0
 suspectscore=2 mlxscore=0 impostorscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004030159
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Trond, thanks for the look!

> On Apr 3, 2020, at 4:00 PM, Trond Myklebust <trondmy@hammerspace.com> =
wrote:
>=20
> On Fri, 2020-04-03 at 15:42 -0400, Chuck Lever wrote:
>> Commit 3832591e6fa5 ("SUNRPC: Handle connection issues correctly on
>> the back channel") intended to make backchannel RPCs fail
>> immediately when there is no forward channel connection. What's
>> currently happening is, when the forward channel conneciton goes
>> away, backchannel operations are causing hard loops because
>> call_transmit_status's SOFTCONN logic ignores ENOTCONN.
>=20
> Won't RPC_TASK_NOCONNECT do the right thing? It should cause the
> request to exit with an ENOTCONN error when it hits call_connect().

OK, so does that mean SOFTCONN is entirely the wrong semantic here?

Was RPC_TASK_NOCONNECT available when 3832591e6fa5 was merged?


>> To avoid changing the behavior of call_transmit_status in the
>> forward direction, make backchannel RPCs return with a different
>> error than ENOTCONN when they fail.
>>=20
>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>> ---
>> net/sunrpc/xprtrdma/svc_rdma_backchannel.c |   15 ++++++++++-----
>> net/sunrpc/xprtsock.c                      |    6 ++++--
>> 2 files changed, 14 insertions(+), 7 deletions(-)
>>=20
>> I'm playing with this fix. It seems to be required in order to get
>> Kerberos mounts to work under load with NFSv4.1 and later on RDMA.
>>=20
>> If there are no objections, I can carry this for v5.7-rc ...
>>=20
>>=20
>> diff --git a/net/sunrpc/xprtrdma/svc_rdma_backchannel.c
>> b/net/sunrpc/xprtrdma/svc_rdma_backchannel.c
>> index d510a3a15d4b..b8a72d7fbcc2 100644
>> --- a/net/sunrpc/xprtrdma/svc_rdma_backchannel.c
>> +++ b/net/sunrpc/xprtrdma/svc_rdma_backchannel.c
>> @@ -207,11 +207,16 @@ rpcrdma_bc_send_request(struct svcxprt_rdma
>> *rdma, struct rpc_rqst *rqst)
>>=20
>> drop_connection:
>> 	dprintk("svcrdma: failed to send bc call\n");
>> -	return -ENOTCONN;
>> +	return -EHOSTUNREACH;
>> }
>>=20
>> -/* Send an RPC call on the passive end of a transport
>> - * connection.
>> +/**
>> + * xprt_rdma_bc_send_request - send an RPC backchannel Call
>> + * @rqst: RPC Call in rq_snd_buf
>> + *
>> + * Returns:
>> + *	%0 if the RPC message has been sent
>> + *	%-EHOSTUNREACH if the Call could not be sent
>>  */
>> static int
>> xprt_rdma_bc_send_request(struct rpc_rqst *rqst)
>> @@ -225,11 +230,11 @@ xprt_rdma_bc_send_request(struct rpc_rqst
>> *rqst)
>>=20
>> 	mutex_lock(&sxprt->xpt_mutex);
>>=20
>> -	ret =3D -ENOTCONN;
>> +	ret =3D -EHOSTUNREACH;
>> 	rdma =3D container_of(sxprt, struct svcxprt_rdma, sc_xprt);
>> 	if (!test_bit(XPT_DEAD, &sxprt->xpt_flags)) {
>> 		ret =3D rpcrdma_bc_send_request(rdma, rqst);
>> -		if (ret =3D=3D -ENOTCONN)
>> +		if (ret < 0)
>> 			svc_close_xprt(sxprt);
>> 	}
>>=20
>> diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
>> index 17cb902e5153..92a358fd2ff0 100644
>> --- a/net/sunrpc/xprtsock.c
>> +++ b/net/sunrpc/xprtsock.c
>> @@ -2543,7 +2543,9 @@ static int bc_sendto(struct rpc_rqst *req)
>> 	req->rq_xtime =3D ktime_get();
>> 	err =3D xprt_sock_sendmsg(transport->sock, &msg, xdr, 0, marker,
>> &sent);
>> 	xdr_free_bvec(xdr);
>> -	if (err < 0 || sent !=3D (xdr->len + sizeof(marker)))
>> +	if (err < 0)
>> +		return -EHOSTUNREACH;
>> +	if (sent !=3D (xdr->len + sizeof(marker)))
>> 		return -EAGAIN;
>> 	return sent;
>> }
>> @@ -2567,7 +2569,7 @@ static int bc_send_request(struct rpc_rqst
>> *req)
>> 	 */
>> 	mutex_lock(&xprt->xpt_mutex);
>> 	if (test_bit(XPT_DEAD, &xprt->xpt_flags))
>> -		len =3D -ENOTCONN;
>> +		len =3D -EHOSTUNREACH;
>> 	else
>> 		len =3D bc_sendto(req);
>> 	mutex_unlock(&xprt->xpt_mutex);
>>=20
> --=20
> Trond Myklebust
> Linux NFS client maintainer, Hammerspace
> trond.myklebust@hammerspace.com

--
Chuck Lever



