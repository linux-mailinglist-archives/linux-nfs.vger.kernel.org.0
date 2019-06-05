Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 458B936269
	for <lists+linux-nfs@lfdr.de>; Wed,  5 Jun 2019 19:25:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726568AbfFERZK (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 5 Jun 2019 13:25:10 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:51720 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726305AbfFERZK (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 5 Jun 2019 13:25:10 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x55HP7Fk161713;
        Wed, 5 Jun 2019 17:25:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2018-07-02; bh=chdmO/yiQe7wNcDFXtZCcdkpB/dAHSB56QwnX54bwlU=;
 b=G/foabcJ6HPAaM0Xw6OGXxjnfesz+nDnyJpIpO6/sKYzv1qghTS1m4zjXZg5oVajYK99
 3AdkueGyZUOWYC3fAOTCrgsqt3SLTsFJCJdKfuVctPKeArSl8RqvxQ8nk2b9MLl3zGxH
 zFlEaQ+GHAk3infCy5ltMZ2SsGnbXP+vMJnj+brinpgQQXJvn3KaAmjRLWv9BzGk0vtY
 wK/x/WXEDW5or93EiETI3SEpYbKz9II4vNRB7t3cANaCxD3NrZo0mMDleG7ra0gwnhYx
 Q/OUfrx3I/S5PIEEwmvMJh+QAQ0lg3wTPbRSr+f7TpH5RGGPQFIWPMhxgrYHbSfhK0xu fQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2130.oracle.com with ESMTP id 2suevdmayp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 05 Jun 2019 17:25:07 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x55HOcIa021752;
        Wed, 5 Jun 2019 17:25:07 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 2swnhc8hfa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 05 Jun 2019 17:25:07 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x55HP5eD026662;
        Wed, 5 Jun 2019 17:25:05 GMT
Received: from anon-dhcp-171.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 05 Jun 2019 10:25:05 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH RFC] svcrdma: Ignore source port when computing DRC hash
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <9E0019E1-1C1B-465C-B2BF-76372029ABD8@talpey.com>
Date:   Wed, 5 Jun 2019 13:25:03 -0400
Cc:     linux-rdma@vger.kernel.org,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <955993A4-0626-4819-BC6F-306A50E2E048@oracle.com>
References: <20190605121518.2150.26479.stgit@klimt.1015granger.net>
 <9E0019E1-1C1B-465C-B2BF-76372029ABD8@talpey.com>
To:     Tom Talpey <tom@talpey.com>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9279 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906050108
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9279 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906050109
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Tom-

> On Jun 5, 2019, at 12:43 PM, Tom Talpey <tom@talpey.com> wrote:
>=20
> On 6/5/2019 8:15 AM, Chuck Lever wrote:
>> The DRC is not working at all after an RPC/RDMA transport reconnect.
>> The problem is that the new connection uses a different source port,
>> which defeats DRC hash.
>>=20
>> An NFS/RDMA client's source port is meaningless for RDMA transports.
>> The transport layer typically sets the source port value on the
>> connection to a random ephemeral port. The server already ignores it
>> for the "secure port" check. See commit 16e4d93f6de7 ("NFSD: Ignore
>> client's source port on RDMA transports").
>=20
> Where does the entropy come from, then, for the server to not
> match other requests from other mount points on this same client?

The first ~200 bytes of each RPC Call message.

[ Note that this has some fun ramifications for calls with small
RPC headers that use Read chunks. ]


> Any time an XID happens to match on a second mount, it will trigger
> incorrect server processing, won't it?

Not a risk for clients that use only a single transport per
client-server pair.


> And since RDMA is capable of
> such high IOPS, the likelihood seems rather high.

Only when the server's durable storage is slow enough to cause
some RPC requests to have extremely high latency.

And, most clients use an atomic counter for their XIDs, so they
are also likely to wrap that counter over some long-pending RPC
request.

The only real answer here is NFSv4 sessions.


> Missing the cache
> might actually be safer than hitting, in this case.

Remember that _any_ retransmit on RPC/RDMA requires a fresh
connection, that includes NFSv3, to reset credit accounting
due to the lost half of the RPC Call/Reply pair.

I can very quickly reproduce bad (non-deterministic) behavior
by running a software build on an NFSv3 on RDMA mount point
with disconnect injection. If the DRC issue is addressed, the
software build runs to completion.

IMO we can't leave things the way they are.


> Tom.
>=20
>> I'm not sure why I never noticed this before.
>>=20
>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>> Cc: stable@vger.kernel.org
>> ---
>>  net/sunrpc/xprtrdma/svc_rdma_transport.c |    7 ++++++-
>>  1 file changed, 6 insertions(+), 1 deletion(-)
>>=20
>> diff --git a/net/sunrpc/xprtrdma/svc_rdma_transport.c =
b/net/sunrpc/xprtrdma/svc_rdma_transport.c
>> index 027a3b0..1b3700b 100644
>> --- a/net/sunrpc/xprtrdma/svc_rdma_transport.c
>> +++ b/net/sunrpc/xprtrdma/svc_rdma_transport.c
>> @@ -211,9 +211,14 @@ static void handle_connect_req(struct rdma_cm_id =
*new_cma_id,
>>  	/* Save client advertised inbound read limit for use later in =
accept. */
>>  	newxprt->sc_ord =3D param->initiator_depth;
>>=20
>> -	/* Set the local and remote addresses in the transport */
>>  	sa =3D (struct sockaddr =
*)&newxprt->sc_cm_id->route.addr.dst_addr;
>>  	svc_xprt_set_remote(&newxprt->sc_xprt, sa, svc_addr_len(sa));
>> +	/* The remote port is arbitrary and not under the control of the
>> +	 * ULP. Set it to a fixed value so that the DRC continues to =
work
>> +	 * after a reconnect.
>> +	 */
>> +	rpc_set_port((struct sockaddr *)&newxprt->sc_xprt.xpt_remote, =
0);
>> +
>>  	sa =3D (struct sockaddr =
*)&newxprt->sc_cm_id->route.addr.src_addr;
>>  	svc_xprt_set_local(&newxprt->sc_xprt, sa, svc_addr_len(sa));
>>=20
>>=20
>>=20
>>=20

--
Chuck Lever



