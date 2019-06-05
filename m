Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6140D36284
	for <lists+linux-nfs@lfdr.de>; Wed,  5 Jun 2019 19:28:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726593AbfFER2R (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 5 Jun 2019 13:28:17 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:42378 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725950AbfFER2Q (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 5 Jun 2019 13:28:16 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x55HOOBE139957;
        Wed, 5 Jun 2019 17:28:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2018-07-02; bh=0h7hcCehA5izF5y4GviJcvdTgeD80ZQfkmfVRYdAg78=;
 b=WQvA97ASRPqMegfn4rbKkuX4jXjfd9dN/6wIY0uP67E/P9V0BANR/zfE6ty0o9QbjPyt
 fEAroII7i2fj0kMJnaxo3on6lPbLu1LraED2VQdSuQLeJU9hId8jOrOX/IuxnNuFXraL
 j9hwoLgDC73GElw6R0U0028aNPjhe4EDu5edgXeBQ+E/YjJaRFRDb25+3rFZmYvwfD1W
 jMxY4lWElWANUK+SBVbSsL6o9jRbYqPMD/mC5/YVGdTuaqQe8yo9wpDFqVfpfQ8AbCcx
 eZvVglTxTtv4GFwiOI7Q3ITScqyIvXGE7nzY9Dvpv0Sfrck1xmbgVCsIqutsavlrofGd aA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 2sugstm44r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 05 Jun 2019 17:28:11 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x55HRr5e068712;
        Wed, 5 Jun 2019 17:28:10 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 2swngj0pp6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 05 Jun 2019 17:28:10 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x55HS90A028373;
        Wed, 5 Jun 2019 17:28:09 GMT
Received: from anon-dhcp-171.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 05 Jun 2019 10:28:08 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH RFC] svcrdma: Ignore source port when computing DRC hash
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <CAN-5tyH5r_cq9qYF3E2BaNK1Xr0RLsxQFCOGQqXhGb8Rk2xMXw@mail.gmail.com>
Date:   Wed, 5 Jun 2019 13:28:07 -0400
Cc:     linux-rdma <linux-rdma@vger.kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <DD7B8184-4124-4307-BD7F-98F6231361DF@oracle.com>
References: <20190605121518.2150.26479.stgit@klimt.1015granger.net>
 <CAN-5tyH5r_cq9qYF3E2BaNK1Xr0RLsxQFCOGQqXhGb8Rk2xMXw@mail.gmail.com>
To:     Olga Kornievskaia <aglo@umich.edu>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9279 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906050109
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



> On Jun 5, 2019, at 11:57 AM, Olga Kornievskaia <aglo@umich.edu> wrote:
>=20
> On Wed, Jun 5, 2019 at 8:15 AM Chuck Lever <chuck.lever@oracle.com> =
wrote:
>>=20
>> The DRC is not working at all after an RPC/RDMA transport reconnect.
>> The problem is that the new connection uses a different source port,
>> which defeats DRC hash.
>>=20
>> An NFS/RDMA client's source port is meaningless for RDMA transports.
>> The transport layer typically sets the source port value on the
>> connection to a random ephemeral port. The server already ignores it
>> for the "secure port" check. See commit 16e4d93f6de7 ("NFSD: Ignore
>> client's source port on RDMA transports").
>>=20
>> I'm not sure why I never noticed this before.
>=20
> Hi Chuck,
>=20
> I have a question: is the reason for choosing this fix as oppose to
> fixing the client because it's server's responsibility to design a DRC
> differently for the NFSoRDMA?

The server DRC implementation is not specified in any standard.
The server implementation can use whatever works the best. The
current Linux DRC implementation is useless for NFS/RDMA, because
the clients have to disconnect before they send retransmissions.

If someone knows a way that a client side RDMA consumer can specify
the source port that is presented to a server, then we can make
that change too.


>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>> Cc: stable@vger.kernel.org
>> ---
>> net/sunrpc/xprtrdma/svc_rdma_transport.c |    7 ++++++-
>> 1 file changed, 6 insertions(+), 1 deletion(-)
>>=20
>> diff --git a/net/sunrpc/xprtrdma/svc_rdma_transport.c =
b/net/sunrpc/xprtrdma/svc_rdma_transport.c
>> index 027a3b0..1b3700b 100644
>> --- a/net/sunrpc/xprtrdma/svc_rdma_transport.c
>> +++ b/net/sunrpc/xprtrdma/svc_rdma_transport.c
>> @@ -211,9 +211,14 @@ static void handle_connect_req(struct rdma_cm_id =
*new_cma_id,
>>        /* Save client advertised inbound read limit for use later in =
accept. */
>>        newxprt->sc_ord =3D param->initiator_depth;
>>=20
>> -       /* Set the local and remote addresses in the transport */
>>        sa =3D (struct sockaddr =
*)&newxprt->sc_cm_id->route.addr.dst_addr;
>>        svc_xprt_set_remote(&newxprt->sc_xprt, sa, svc_addr_len(sa));
>> +       /* The remote port is arbitrary and not under the control of =
the
>> +        * ULP. Set it to a fixed value so that the DRC continues to =
work
>> +        * after a reconnect.
>> +        */
>> +       rpc_set_port((struct sockaddr *)&newxprt->sc_xprt.xpt_remote, =
0);
>> +
>>        sa =3D (struct sockaddr =
*)&newxprt->sc_cm_id->route.addr.src_addr;
>>        svc_xprt_set_local(&newxprt->sc_xprt, sa, svc_addr_len(sa));
>>=20
>>=20

--
Chuck Lever



