Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3049D13161
	for <lists+linux-nfs@lfdr.de>; Fri,  3 May 2019 17:43:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728020AbfECPnr (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 3 May 2019 11:43:47 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:53456 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727460AbfECPnr (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 3 May 2019 11:43:47 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x43FdRSO068474;
        Fri, 3 May 2019 15:43:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2018-07-02; bh=FAjZv/2fhSRLoM77X08c1cIJAeqX1vr4KH8gdmUbQ2Q=;
 b=Qy2UVnqsdRI0KToCS+x1WWknaV4BoKfrBWFSB64WrJiWWuWVHQuibngY370VJutS3Suv
 t8csr27UOKjIxp6BPnZmxam5P0q5UD/iZq1MiriQajLBky/28TyHSI9CIjiYQO1Ep++z
 0ke0jkG+SI2ajPPQmW76vP1PimHPaeZgInwocrkWXmizuWk6jaxcz3Q5ei2CNIYxoYBt
 Q0J+ZRIYb0gYkTtPR7afGNl6/IWy4fVwBsgRt+k0Om5sxIsFZ/vFGgGVnqEA0Xz8yFW6
 Z3EZwPY/4XQlHgCejrk60cXmd2hD2xLX6agu3Iexi44dMFbBqL68EuL+VIpa+H8q0s+g Bg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2s6xhyqm87-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 03 May 2019 15:43:44 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x43Fgs30166688;
        Fri, 3 May 2019 15:43:43 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 2s7rtcbvja-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 03 May 2019 15:43:43 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x43FhgCe005190;
        Fri, 3 May 2019 15:43:42 GMT
Received: from [172.20.28.166] (/173.228.226.134)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 03 May 2019 08:43:42 -0700
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [RFC PATCH 3/5] SUNRPC: Remove the bh-safe lock requirement on xprt->transport_lock
From:   Chuck Lever <chuck.lever@oracle.com>
X-Mailer: iPhone Mail (16E227)
In-Reply-To: <0fb44ee09e95964ab04c0b25470d871d43bf91b6.camel@gmail.com>
Date:   Fri, 3 May 2019 11:43:40 -0400
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <250A97DF-6803-40FD-A432-B4AFF23B1D30@oracle.com>
References: <20190503111841.4391-1-trond.myklebust@hammerspace.com> <20190503111841.4391-2-trond.myklebust@hammerspace.com> <20190503111841.4391-3-trond.myklebust@hammerspace.com> <20190503111841.4391-4-trond.myklebust@hammerspace.com> <EBFAF849-B5F1-4CFD-8DB4-7D66815353C8@oracle.com> <0fb44ee09e95964ab04c0b25470d871d43bf91b6.camel@gmail.com>
To:     Trond Myklebust <trondmy@gmail.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9245 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1905030100
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9245 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905030099
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


> On May 3, 2019, at 11:28 AM, Trond Myklebust <trondmy@gmail.com> wrote:
>=20
> On Fri, 2019-05-03 at 10:21 -0400, Chuck Lever wrote:
>>> On May 3, 2019, at 7:18 AM, Trond Myklebust <trondmy@gmail.com>
>>> wrote:
>>>=20
>>> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
>>> ---
>>> net/sunrpc/xprt.c                          | 61 ++++++++++---------
>>> ---
>>> net/sunrpc/xprtrdma/rpc_rdma.c             |  4 +-
>>> net/sunrpc/xprtrdma/svc_rdma_backchannel.c |  4 +-
>>> net/sunrpc/xprtrdma/svc_rdma_transport.c   |  8 +--
>>> net/sunrpc/xprtsock.c                      | 23 ++++----
>>> 5 files changed, 47 insertions(+), 53 deletions(-)
>>=20
>> For rpc_rdma.c and svc_rdma_backchannel.c:
>>=20
>>   Reviewed-by: Chuck Lever <chuck.lever@oracle.com>
>>=20
>> For svc_rdma_transport.c:
>>=20
>> These locks are server-side only. AFAICS it's not safe
>> to leave BH's enabled here. Can you drop these hunks?
>=20
> Oops... Yes, I don't know why I mistook that for the xprt-
>> transport_lock...
>=20
> You mean these 3 hunks, right?

S=C3=AD.

>=20
>>> diff --git a/net/sunrpc/xprtrdma/svc_rdma_transport.c
>>> b/net/sunrpc/xprtrdma/svc_rdma_transport.c
>>> index 027a3b07d329..18ffc6190ea9 100644
>>> --- a/net/sunrpc/xprtrdma/svc_rdma_transport.c
>>> +++ b/net/sunrpc/xprtrdma/svc_rdma_transport.c
>>> @@ -221,9 +221,9 @@ static void handle_connect_req(struct
>>> rdma_cm_id *new_cma_id,
>>>     * Enqueue the new transport on the accept queue of the
>>> listening
>>>     * transport
>>>     */
>>> -    spin_lock_bh(&listen_xprt->sc_lock);
>>> +    spin_lock(&listen_xprt->sc_lock);
>>>    list_add_tail(&newxprt->sc_accept_q, &listen_xprt-
>>>> sc_accept_q);
>>> -    spin_unlock_bh(&listen_xprt->sc_lock);
>>> +    spin_unlock(&listen_xprt->sc_lock);
>>>=20
>>>    set_bit(XPT_CONN, &listen_xprt->sc_xprt.xpt_flags);
>>>    svc_xprt_enqueue(&listen_xprt->sc_xprt);
>>> @@ -396,7 +396,7 @@ static struct svc_xprt *svc_rdma_accept(struct
>>> svc_xprt *xprt)
>>>    listen_rdma =3D container_of(xprt, struct svcxprt_rdma, sc_xprt);
>>>    clear_bit(XPT_CONN, &xprt->xpt_flags);
>>>    /* Get the next entry off the accept list */
>>> -    spin_lock_bh(&listen_rdma->sc_lock);
>>> +    spin_lock(&listen_rdma->sc_lock);
>>>    if (!list_empty(&listen_rdma->sc_accept_q)) {
>>>        newxprt =3D list_entry(listen_rdma->sc_accept_q.next,
>>>                     struct svcxprt_rdma, sc_accept_q);
>>> @@ -404,7 +404,7 @@ static struct svc_xprt *svc_rdma_accept(struct
>>> svc_xprt *xprt)
>>>    }
>>>    if (!list_empty(&listen_rdma->sc_accept_q))
>>>        set_bit(XPT_CONN, &listen_rdma->sc_xprt.xpt_flags);
>>> -    spin_unlock_bh(&listen_rdma->sc_lock);
>>> +    spin_unlock(&listen_rdma->sc_lock);
>>>    if (!newxprt)
>>>        return NULL;
>>>=20
>>>=20
>=20
> --=20
> Trond Myklebust
> Linux NFS client maintainer, Hammerspace
> trond.myklebust@hammerspace.com
>=20
>=20
>=20

