Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB0B51B64DB
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Apr 2020 21:54:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726056AbgDWTyg (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 23 Apr 2020 15:54:36 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:60008 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbgDWTyf (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 23 Apr 2020 15:54:35 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03NJmfQg134365;
        Thu, 23 Apr 2020 19:54:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=e6hTr3LVbmtjnaz+KNR/9QIwxGmqNIRGQDnknxS71xs=;
 b=rCi0JXnbr/D3Du9JIguW3C9voScjAnRnMC0F0yGdkAB7+j6n6MrUKFuDzPhnftEqyHYm
 AMxYgr/fNHa/TlfqEgov3ql8wlYDW9P7wb4J2gRanhb5tpubGHUxniU3OFQWiiaErEoD
 RoTYusu3rLz57RgIfwtsEDbph5GjzSoaE8IyN1wcrtAGf5RppWoXJVOE17fWW+IkLl3a
 kEFsjfBuHkXqXBqTBeNooAdYom/9vKYmR8moEMcfN8zORpAnhRoshA7Qm06SG2OCDUnW
 7ABHkSvuX8pZ8a91Mc9povZ1BGfmqtx1CS+7gajHiTJ9peD5GxiD79SeafMUb6GYWOnt LA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 30jvq4wmb4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Apr 2020 19:54:32 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03NJgMpl169179;
        Thu, 23 Apr 2020 19:52:31 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 30gb1nb6sg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Apr 2020 19:52:31 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 03NJqUlu024480;
        Thu, 23 Apr 2020 19:52:30 GMT
Received: from anon-dhcp-153.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 23 Apr 2020 12:52:30 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH RFC2 1/2] SUNRPC: Set SOFTCONN when destroying GSS
 contexts
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <1420699d1256f1808e5790e172bb3abd99ec7259.camel@hammerspace.com>
Date:   Thu, 23 Apr 2020 15:52:29 -0400
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <F3E313AF-E44E-4337-8F4E-62BF5C4DD4EE@oracle.com>
References: <20200423194311.7849.36326.stgit@manet.1015granger.net>
 <1420699d1256f1808e5790e172bb3abd99ec7259.camel@hammerspace.com>
To:     Trond Myklebust <trondmy@hammerspace.com>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9600 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=2 spamscore=0
 mlxlogscore=999 mlxscore=0 malwarescore=0 bulkscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004230147
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9600 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 malwarescore=0
 mlxscore=0 adultscore=0 mlxlogscore=999 phishscore=0 impostorscore=0
 clxscore=1015 bulkscore=0 spamscore=0 priorityscore=1501 suspectscore=2
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004230147
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Apr 23, 2020, at 3:50 PM, Trond Myklebust <trondmy@hammerspace.com> =
wrote:
>=20
> On Thu, 2020-04-23 at 15:43 -0400, Chuck Lever wrote:
>> Prevent a (temporary) hang when shutting down an rpc_clnt that has
>> used one or more GSS creds.
>>=20
>> I noticed that callers of rpc_call_null_helper() use a common set of
>> flags, so I collected them all in that helper function.
>>=20
>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>> ---
>> net/sunrpc/auth_gss/auth_gss.c |    2 +-
>> net/sunrpc/clnt.c              |   10 ++++------
>> 2 files changed, 5 insertions(+), 7 deletions(-)
>>=20
>> diff --git a/net/sunrpc/auth_gss/auth_gss.c
>> b/net/sunrpc/auth_gss/auth_gss.c
>> index ac5cac0dd24b..16cec9755b86 100644
>> --- a/net/sunrpc/auth_gss/auth_gss.c
>> +++ b/net/sunrpc/auth_gss/auth_gss.c
>> @@ -1285,7 +1285,7 @@ static void gss_pipe_free(struct gss_pipe *p)
>> 		ctx->gc_proc =3D RPC_GSS_PROC_DESTROY;
>>=20
>> 		task =3D rpc_call_null(gss_auth->client, &new->gc_base,
>> -				RPC_TASK_ASYNC|RPC_TASK_SOFT);
>> +				     RPC_TASK_ASYNC);
>=20
> No. This means we can end with silently hanging clients that never go
> away. Besides, this function is destroying the creds, so there should
> be no problem with them timing out.

Agreed. RPC_TASK_SOFT is still set, but it's been moved to
rpc_call_null_helper() because every one of its callers is a soft
caller.


>> 		if (!IS_ERR(task))
>> 			rpc_put_task(task);
>>=20
>> diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
>> index 325a0858700f..ddc98b97c170 100644
>> --- a/net/sunrpc/clnt.c
>> +++ b/net/sunrpc/clnt.c
>> @@ -2742,7 +2742,8 @@ struct rpc_task *rpc_call_null_helper(struct
>> rpc_clnt *clnt,
>> 		.rpc_op_cred =3D cred,
>> 		.callback_ops =3D (ops !=3D NULL) ? ops : =
&rpc_default_ops,
>> 		.callback_data =3D data,
>> -		.flags =3D flags | RPC_TASK_NULLCREDS,
>> +		.flags =3D flags | RPC_TASK_SOFT | RPC_TASK_SOFTCONN |
>> +			 RPC_TASK_NULLCREDS,
>> 	};
>>=20
>> 	return rpc_run_task(&task_setup_data);
>> @@ -2805,8 +2806,7 @@ int rpc_clnt_test_and_add_xprt(struct rpc_clnt
>> *clnt,
>> 		goto success;
>> 	}
>>=20
>> -	task =3D rpc_call_null_helper(clnt, xprt, NULL,
>> -			RPC_TASK_SOFT|RPC_TASK_SOFTCONN|RPC_TASK_ASYNC|
>> RPC_TASK_NULLCREDS,
>> +	task =3D rpc_call_null_helper(clnt, xprt, NULL, RPC_TASK_ASYNC,
>> 			&rpc_cb_add_xprt_call_ops, data);
>> 	if (IS_ERR(task))
>> 		return PTR_ERR(task);
>> @@ -2850,9 +2850,7 @@ int rpc_clnt_setup_test_and_add_xprt(struct
>> rpc_clnt *clnt,
>> 		goto out_err;
>>=20
>> 	/* Test the connection */
>> -	task =3D rpc_call_null_helper(clnt, xprt, NULL,
>> -				    RPC_TASK_SOFT | RPC_TASK_SOFTCONN |
>> RPC_TASK_NULLCREDS,
>> -				    NULL, NULL);
>> +	task =3D rpc_call_null_helper(clnt, xprt, NULL, 0, NULL, NULL);
>> 	if (IS_ERR(task)) {
>> 		status =3D PTR_ERR(task);
>> 		goto out_err;
>>=20
> --=20
> Trond Myklebust
> Linux NFS client maintainer, Hammerspace
> trond.myklebust@hammerspace.com

--
Chuck Lever



