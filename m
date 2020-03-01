Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E610C174EF4
	for <lists+linux-nfs@lfdr.de>; Sun,  1 Mar 2020 19:30:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726359AbgCASaC (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 1 Mar 2020 13:30:02 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:44882 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726146AbgCASaC (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 1 Mar 2020 13:30:02 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 021IOiuq047786;
        Sun, 1 Mar 2020 18:30:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=8aRIkRoWOpPeztTUZM7Y1gsAnvUbgjVQ0XdhwYNMgck=;
 b=to6H+/POc5/saPYK4EEmXYeyqppQcrNjjS5xZQ8+uNuV4wTi32xisIc9JVCG63zKzBcD
 d9+HxePonRgL/I8Pb/Xxv07QROojKBsLRxRhjJyp4C1pvFOMEC+uWad1pKesqDuV7CRv
 hjcRhebROhVr+UadScVTaAUfZ0ueB2gZg3vQ6sXLVHl2G8IA/IKEgi/sKl8zVjZoazpV
 BCULu6XU72ccMs60N3gMvKMPpTlRb4nk3FYlGkNTiHTHZ1cPMnjPbmBpbb+/iE1qRpMO
 XVhRoYJvOwkBAV/4PkGeuNVtq6ee0PjNq53IiWONoGUuHaDZjbRL45ix0J2dfWeeUJxT fQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2yffcu487b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 01 Mar 2020 18:30:00 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 021INFqq051764;
        Sun, 1 Mar 2020 18:30:00 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 2yg1gtdw58-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 01 Mar 2020 18:29:59 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 021ITxcE023803;
        Sun, 1 Mar 2020 18:29:59 GMT
Received: from anon-dhcp-153.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 01 Mar 2020 10:29:59 -0800
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH v1 05/11] xprtrdma: Allocate Protection Domain in
 rpcrdma_ep_create()
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <8a1b8d87-48a7-6cc2-66de-121a46d1b6a4@talpey.com>
Date:   Sun, 1 Mar 2020 13:29:58 -0500
Cc:     linux-rdma@vger.kernel.org,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <D9382354-0063-43C5-9940-6F376D16E083@oracle.com>
References: <20200221214906.2072.32572.stgit@manet.1015granger.net>
 <20200221220033.2072.22880.stgit@manet.1015granger.net>
 <8a1b8d87-48a7-6cc2-66de-121a46d1b6a4@talpey.com>
To:     Tom Talpey <tom@talpey.com>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9547 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 suspectscore=2 malwarescore=0 mlxlogscore=999 mlxscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003010144
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9547 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 bulkscore=0
 adultscore=0 suspectscore=2 spamscore=0 malwarescore=0 impostorscore=0
 priorityscore=1501 mlxlogscore=999 lowpriorityscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003010144
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Tom-

Thanks for your careful reading of the patch series!


> On Mar 1, 2020, at 1:11 PM, Tom Talpey <tom@talpey.com> wrote:
>=20
> On 2/21/2020 2:00 PM, Chuck Lever wrote:
>> Make a Protection Domain (PD) a per-connection resource rather than
>> a per-transport resource. In other words, when the connection
>> terminates, the PD is destroyed.
>> Thus there is one less HW resource that remains allocated to a
>> transport after a connection is closed.
>=20
> That's a good goal, but there are cases where the upper layer may
> want the PD to be shared. For example, in a multichannel =
configuration,
> where RDMA may not be constrained to use a single connection.

I see two reasons why PD sharing won't be needed for the Linux
client implementation of RPC/RDMA:

- The plan for Linux NFS/RDMA is to manage multiple connections
  in the NFS client layer, not at the RPC transport layer.

- We don't intend to retransmit an RPC that was registered via
  one connection on a different connection; a retransmitted RPC
  is re-marshaled from scratch before each transmit.

The purpose of destroying the PD at disconnect is to enable a
clean device removal model: basically, disconnect all connections
through that device, and we're guaranteed to have no more pinned
HW resources. AFAICT, that is the model also used in other kernel
ULPs.


> How would this approach support such a requirement?

As above, the Linux NFS client would create additional transports,
each with their own single connection (and PD).


> Can a PD be provided to a new connection?

The sequence of API events is that an ID and PD are created first,
then a QP is created with the ID and PD, then the connection is
established.

But I might not have understood your question.




> Tom.
>=20
>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>> ---
>>  net/sunrpc/xprtrdma/verbs.c |   26 ++++++++++----------------
>>  1 file changed, 10 insertions(+), 16 deletions(-)
>> diff --git a/net/sunrpc/xprtrdma/verbs.c =
b/net/sunrpc/xprtrdma/verbs.c
>> index f361213a8157..36fe7baea014 100644
>> --- a/net/sunrpc/xprtrdma/verbs.c
>> +++ b/net/sunrpc/xprtrdma/verbs.c
>> @@ -363,14 +363,6 @@ static void rpcrdma_update_cm_private(struct =
rpcrdma_xprt *r_xprt,
>>  		rc =3D PTR_ERR(ia->ri_id);
>>  		goto out_err;
>>  	}
>> -
>> -	ia->ri_pd =3D ib_alloc_pd(ia->ri_id->device, 0);
>> -	if (IS_ERR(ia->ri_pd)) {
>> -		rc =3D PTR_ERR(ia->ri_pd);
>> -		pr_err("rpcrdma: ib_alloc_pd() returned %d\n", rc);
>> -		goto out_err;
>> -	}
>> -
>>  	return 0;
>>    out_err:
>> @@ -403,9 +395,6 @@ static void rpcrdma_update_cm_private(struct =
rpcrdma_xprt *r_xprt,
>>    	rpcrdma_ep_destroy(r_xprt);
>>  -	ib_dealloc_pd(ia->ri_pd);
>> -	ia->ri_pd =3D NULL;
>> -
>>  	/* Allow waiters to continue */
>>  	complete(&ia->ri_remove_done);
>>  @@ -423,11 +412,6 @@ static void rpcrdma_update_cm_private(struct =
rpcrdma_xprt *r_xprt,
>>  	if (ia->ri_id && !IS_ERR(ia->ri_id))
>>  		rdma_destroy_id(ia->ri_id);
>>  	ia->ri_id =3D NULL;
>> -
>> -	/* If the pd is still busy, xprtrdma missed freeing a resource =
*/
>> -	if (ia->ri_pd && !IS_ERR(ia->ri_pd))
>> -		ib_dealloc_pd(ia->ri_pd);
>> -	ia->ri_pd =3D NULL;
>>  }
>>    static int rpcrdma_ep_create(struct rpcrdma_xprt *r_xprt,
>> @@ -514,6 +498,12 @@ static int rpcrdma_ep_create(struct rpcrdma_xprt =
*r_xprt,
>>  	ep->rep_remote_cma.flow_control =3D 0;
>>  	ep->rep_remote_cma.rnr_retry_count =3D 0;
>>  +	ia->ri_pd =3D ib_alloc_pd(id->device, 0);
>> +	if (IS_ERR(ia->ri_pd)) {
>> +		rc =3D PTR_ERR(ia->ri_pd);
>> +		goto out_destroy;
>> +	}
>> +
>>  	rc =3D rdma_create_qp(id, ia->ri_pd, &ep->rep_attr);
>>  	if (rc)
>>  		goto out_destroy;
>> @@ -540,6 +530,10 @@ static void rpcrdma_ep_destroy(struct =
rpcrdma_xprt *r_xprt)
>>  	if (ep->rep_attr.send_cq)
>>  		ib_free_cq(ep->rep_attr.send_cq);
>>  	ep->rep_attr.send_cq =3D NULL;
>> +
>> +	if (ia->ri_pd)
>> +		ib_dealloc_pd(ia->ri_pd);
>> +	ia->ri_pd =3D NULL;
>>  }
>>    /* Re-establish a connection after a device removal event.

--
Chuck Lever



