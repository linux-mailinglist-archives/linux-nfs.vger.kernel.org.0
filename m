Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 777F037C55
	for <lists+linux-nfs@lfdr.de>; Thu,  6 Jun 2019 20:33:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728223AbfFFSdo (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 6 Jun 2019 14:33:44 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:35442 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726837AbfFFSdi (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 6 Jun 2019 14:33:38 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x56ISr1D110235;
        Thu, 6 Jun 2019 18:33:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2018-07-02; bh=/4qI0pF6nyiwAnWSVs/s/VMqczMTvFbdOpCK9GVIR0A=;
 b=l2hA1WK1UjXycYzvFUbMXipUuZWuCnItvJhkHr1Tza7gFlZqhWTvfOYaf+HaD8s9eOo/
 T1QyulkZdUKF7dQysBJxc6LNasgtYyjK4e0XJUGkz9W8v8vCReULiHsi5ZCebZS6txxX
 cFyW5OU44Xz2LjiMDcDK7Fg+KCwoslb99eN9oUd7hOmHviAiWz+askiXeifxxUUU0p+U
 V6rpgGAGxS/i1LW+cZpbkyKrnpT1UxZ7u2dkpYtgO5WLK77ObEvz15xqocq6Jj1+Rmuu
 RwHOHlKBFxRMYa++GGh1NHILHhZxfC/2OMghINm+wRJBGXnjXnWXhVKay+XehoKfmrmd qA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2sugstt7yj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Jun 2019 18:33:32 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x56IX8tq070550;
        Thu, 6 Jun 2019 18:33:32 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 2swngmnv9s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Jun 2019 18:33:32 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x56IXVl3001830;
        Thu, 6 Jun 2019 18:33:31 GMT
Received: from anon-dhcp-171.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 06 Jun 2019 11:33:31 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH RFC] svcrdma: Ignore source port when computing DRC hash
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <CAN-5tyEUHrDkj7MKfYeN5LsFwZEtaLsHYMX20UQMShHtQa-QsA@mail.gmail.com>
Date:   Thu, 6 Jun 2019 14:33:30 -0400
Cc:     linux-rdma <linux-rdma@vger.kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <52A2AF4C-1858-486E-8A9B-94392E7E18BD@oracle.com>
References: <20190605121518.2150.26479.stgit@klimt.1015granger.net>
 <CAN-5tyH5r_cq9qYF3E2BaNK1Xr0RLsxQFCOGQqXhGb8Rk2xMXw@mail.gmail.com>
 <DD7B8184-4124-4307-BD7F-98F6231361DF@oracle.com>
 <CAN-5tyEUHrDkj7MKfYeN5LsFwZEtaLsHYMX20UQMShHtQa-QsA@mail.gmail.com>
To:     Olga Kornievskaia <aglo@umich.edu>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9280 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906060125
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9280 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906060124
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jun 6, 2019, at 2:13 PM, Olga Kornievskaia <aglo@umich.edu> wrote:
>=20
> On Wed, Jun 5, 2019 at 1:28 PM Chuck Lever <chuck.lever@oracle.com> =
wrote:
>>=20
>>=20
>>=20
>>> On Jun 5, 2019, at 11:57 AM, Olga Kornievskaia <aglo@umich.edu> =
wrote:
>>>=20
>>> On Wed, Jun 5, 2019 at 8:15 AM Chuck Lever <chuck.lever@oracle.com> =
wrote:
>>>>=20
>>>> The DRC is not working at all after an RPC/RDMA transport =
reconnect.
>>>> The problem is that the new connection uses a different source =
port,
>>>> which defeats DRC hash.
>>>>=20
>>>> An NFS/RDMA client's source port is meaningless for RDMA =
transports.
>>>> The transport layer typically sets the source port value on the
>>>> connection to a random ephemeral port. The server already ignores =
it
>>>> for the "secure port" check. See commit 16e4d93f6de7 ("NFSD: Ignore
>>>> client's source port on RDMA transports").
>>>>=20
>>>> I'm not sure why I never noticed this before.
>>>=20
>>> Hi Chuck,
>>>=20
>>> I have a question: is the reason for choosing this fix as oppose to
>>> fixing the client because it's server's responsibility to design a =
DRC
>>> differently for the NFSoRDMA?
>>=20
>> The server DRC implementation is not specified in any standard.
>> The server implementation can use whatever works the best. The
>> current Linux DRC implementation is useless for NFS/RDMA, because
>> the clients have to disconnect before they send retransmissions.
>>=20
>> If someone knows a way that a client side RDMA consumer can specify
>> the source port that is presented to a server, then we can make
>> that change too.
>=20
> Ok I see you point about this being difficult on the client. Various
> implementations take different approaches even on RoCE itself:
> 1. software RoCE does
>        /* pick a source UDP port number for this QP based on
>         * the source QPN. this spreads traffic for different QPs
>         * across different NIC RX queues (while using a single
>         * flow for a given QP to maintain packet order).
>         * the port number must be in the Dynamic Ports range
>         * (0xc000 - 0xffff).
>         */
>        qp->src_port =3D RXE_ROCE_V2_SPORT +
>                (hash_32_generic(qp_num(qp), 14) & 0x3fff);
>=20
> When I allow the connection to be re-established I can confirm that a
> new UDP source port is gotten).
>=20
> 2. bnxt_re (broadband net extreme) seems to always use the same source =
port:
> qp->qp1_hdr.udp.sport =3D htons(0x8CD1);
>=20
> 3. mlx4 seems to always use the same source port:
> sqp->ud_header.udp.sport =3D htons(MLX4_ROCEV2_QP1_SPORT);
>=20
> 4. mlx5 also seems to be pick the same port:
> return cpu_to_be16(MLX5_CAP_ROCE(dev->mdev, r_roce_min_src_udp_port));
>=20
> I have a CX5 card and I see that the source port is always 49513. So
> if you use Mellanox cards or this other card, DNC implementations are
> safe?

Thanks for looking into this.

Not sure that's the same source port that is visible to the
NFS server's transport accept logic. That's the one that
matters to the DRC. Certainly IB fabrics wouldn't have an IP
source port like this.

For RoCE (and perhaps iWARP) that port number would be the
same for all transports from the client. Still not useful
for adding entropy to a DRC entry hash.

@@ -211,9 +211,14 @@ static void handle_connect_req(struct rdma_cm_id =
*new_cma_id,
        /* Save client advertised inbound read limit for use later in =
accept. */
        newxprt->sc_ord =3D param->initiator_depth;
=20
        /* Set the local and remote addresses in the transport */
        sa =3D (struct sockaddr =
*)&newxprt->sc_cm_id->route.addr.dst_addr;

Can you add a printk to your server to show the port value
in cm_id->route.addr.dst_addr?


> I also see that there is nothing in the verbs API thru which we
> interact with the RDMA drivers will allow us to set the port.

I suspect this would be part of the RDMA Connection Manager
interface, not part of the RDMA driver code.


> Unless
> we can ask the linux implementation to augment some structures to
> allow us to set and query that port or is that unreasonable because
> it's not in the standard API.
>=20
>>=20
>>=20
>>>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>>>> Cc: stable@vger.kernel.org
>>>> ---
>>>> net/sunrpc/xprtrdma/svc_rdma_transport.c |    7 ++++++-
>>>> 1 file changed, 6 insertions(+), 1 deletion(-)
>>>>=20
>>>> diff --git a/net/sunrpc/xprtrdma/svc_rdma_transport.c =
b/net/sunrpc/xprtrdma/svc_rdma_transport.c
>>>> index 027a3b0..1b3700b 100644
>>>> --- a/net/sunrpc/xprtrdma/svc_rdma_transport.c
>>>> +++ b/net/sunrpc/xprtrdma/svc_rdma_transport.c
>>>> @@ -211,9 +211,14 @@ static void handle_connect_req(struct =
rdma_cm_id *new_cma_id,
>>>>       /* Save client advertised inbound read limit for use later in =
accept. */
>>>>       newxprt->sc_ord =3D param->initiator_depth;
>>>>=20
>>>> -       /* Set the local and remote addresses in the transport */
>>>>       sa =3D (struct sockaddr =
*)&newxprt->sc_cm_id->route.addr.dst_addr;
>>>>       svc_xprt_set_remote(&newxprt->sc_xprt, sa, svc_addr_len(sa));
>>>> +       /* The remote port is arbitrary and not under the control =
of the
>>>> +        * ULP. Set it to a fixed value so that the DRC continues =
to work
>>>> +        * after a reconnect.
>>>> +        */
>>>> +       rpc_set_port((struct sockaddr =
*)&newxprt->sc_xprt.xpt_remote, 0);
>>>> +
>>>>       sa =3D (struct sockaddr =
*)&newxprt->sc_cm_id->route.addr.src_addr;
>>>>       svc_xprt_set_local(&newxprt->sc_xprt, sa, svc_addr_len(sa));
>>>>=20
>>>>=20
>>=20
>> --
>> Chuck Lever

--
Chuck Lever



