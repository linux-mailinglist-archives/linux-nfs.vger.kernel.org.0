Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 61C6AE395A
	for <lists+linux-nfs@lfdr.de>; Thu, 24 Oct 2019 19:08:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408019AbfJXRIn (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 24 Oct 2019 13:08:43 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:57164 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405931AbfJXRIn (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 24 Oct 2019 13:08:43 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9OH8dCo124298;
        Thu, 24 Oct 2019 17:08:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2019-08-05; bh=1QKeMGoyoTuBj8tHhw5bGCQuRbWDa5EVDvd+kGQd+vo=;
 b=eGPRQgl1vFC+sRlCBZvXsGmsZXdedb6QtIfiGL1SEsJSYZv0IUb0wqcL/EWySFd4Z+DO
 FAjwE0HavZp9/eqvd04fOkeFEg0lun8SB6hxIqyB+fHR2xnGgLsMP4Z4hxIeHo8im73J
 a3ybZbKS5ZH6HyhOrlR7P6bCG5xXj3G7eSdojyAJvZDmUirtf0oVyKS2gYzfmGtEzLgo
 G7939U0gESYRgwWd97fWxuuYSCx5PjQ6428D7YrsPVoA5NXat1oO+ccMHKQzJgI4YI8s
 5k3J/Mi8pYUVPlRapc6yKJjaJfJvr1D44FwUVHFDyobLvYZiuQGKGMpv2t8vuKPwztqm iQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2vqu4r4uay-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 24 Oct 2019 17:08:39 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9OH8ZZm163099;
        Thu, 24 Oct 2019 17:08:38 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 2vtm24wqe9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 24 Oct 2019 17:08:37 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x9OH8Lcj013024;
        Thu, 24 Oct 2019 17:08:23 GMT
Received: from anon-dhcp-153.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 24 Oct 2019 10:08:21 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH v1 1/2] SUNRPC: Trace gssproxy upcall results
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20191024153805.GA29859@fieldses.org>
Date:   Thu, 24 Oct 2019 13:08:20 -0400
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <CBBEAFFB-584C-4196-B24B-6664EABE5E39@oracle.com>
References: <20191024133410.2148.3456.stgit@klimt.1015granger.net>
 <20191024153805.GA29859@fieldses.org>
To:     Bruce Fields <bfields@fieldses.org>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9420 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910240161
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9420 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910240161
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Oct 24, 2019, at 11:38 AM, J. Bruce Fields <bfields@fieldses.org> =
wrote:
>=20
> On Thu, Oct 24, 2019 at 09:34:10AM -0400, Chuck Lever wrote:
>> Record results of a GSS proxy ACCEPT_SEC_CONTEXT upcall and the
>> svc_authenticate() function to make field debugging of NFS server
>> Kerberos issues easier.
>=20
> Inclined to apply.
>=20
> The only thing that bugs me a bit is that this is just summarizing
> information that's passing between the kernel and userspace--so it =
seems
> like a job for strace or wireshark or something.

You could use those tools. However:

- strace probably isn't going to provide symbolic values for the GSS =
major status

- wireshark is unwieldy for initial debugging on servers with no =
graphics capability

The upcall trace point is built into the kernel. Flip it on and it will =
tell a
system administrator immediately what the upcall result was.


> --b.
>=20
>>=20
>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>> Reviewed-by: Bill Baker <bill.baker@oracle.com>
>> ---
>> include/trace/events/rpcgss.h         |   45 =
+++++++++++++++++++++++++++
>> include/trace/events/sunrpc.h         |   55 =
+++++++++++++++++++++++++++++++++
>> net/sunrpc/auth_gss/gss_mech_switch.c |    4 ++
>> net/sunrpc/auth_gss/svcauth_gss.c     |    8 +++--
>> net/sunrpc/svc.c                      |    2 +
>> net/sunrpc/svcauth.c                  |    2 +
>> 6 files changed, 112 insertions(+), 4 deletions(-)
>>=20
>> diff --git a/include/trace/events/rpcgss.h =
b/include/trace/events/rpcgss.h
>> index d1f7fe1..9827f53 100644
>> --- a/include/trace/events/rpcgss.h
>> +++ b/include/trace/events/rpcgss.h
>> @@ -126,6 +126,34 @@
>> DEFINE_GSSAPI_EVENT(wrap);
>> DEFINE_GSSAPI_EVENT(unwrap);
>>=20
>> +TRACE_EVENT(rpcgss_accept_upcall,
>> +	TP_PROTO(
>> +		__be32 xid,
>> +		u32 major_status,
>> +		u32 minor_status
>> +	),
>> +
>> +	TP_ARGS(xid, major_status, minor_status),
>> +
>> +	TP_STRUCT__entry(
>> +		__field(u32, xid)
>> +		__field(u32, minor_status)
>> +		__field(unsigned long, major_status)
>> +	),
>> +
>> +	TP_fast_assign(
>> +		__entry->xid =3D be32_to_cpu(xid);
>> +		__entry->minor_status =3D minor_status;
>> +		__entry->major_status =3D major_status;
>> +	),
>> +
>> +	TP_printk("xid=3D0x%08x major_status=3D%s (0x%08lx) =
minor_status=3D%u",
>> +		__entry->xid, __entry->major_status =3D=3D 0 ? =
"GSS_S_COMPLETE" :
>> +				show_gss_status(__entry->major_status),
>> +		__entry->major_status, __entry->minor_status
>> +	)
>> +);
>> +
>>=20
>> /**
>>  ** GSS auth unwrap failures
>> @@ -355,6 +383,23 @@
>> 		show_pseudoflavor(__entry->flavor), __entry->error)
>> );
>>=20
>> +TRACE_EVENT(rpcgss_oid_to_mech,
>> +	TP_PROTO(
>> +		const char *oid
>> +	),
>> +
>> +	TP_ARGS(oid),
>> +
>> +	TP_STRUCT__entry(
>> +		__string(oid, oid)
>> +	),
>> +
>> +	TP_fast_assign(
>> +		__assign_str(oid, oid);
>> +	),
>> +
>> +	TP_printk("mech for oid %s was not found", __get_str(oid))
>> +);
>>=20
>> #endif	/* _TRACE_RPCGSS_H */
>>=20
>> diff --git a/include/trace/events/sunrpc.h =
b/include/trace/events/sunrpc.h
>> index ffa3c51..c358a0a 100644
>> --- a/include/trace/events/sunrpc.h
>> +++ b/include/trace/events/sunrpc.h
>> @@ -14,6 +14,26 @@
>> #include <linux/net.h>
>> #include <linux/tracepoint.h>
>>=20
>> +TRACE_DEFINE_ENUM(RPC_AUTH_OK);
>> +TRACE_DEFINE_ENUM(RPC_AUTH_BADCRED);
>> +TRACE_DEFINE_ENUM(RPC_AUTH_REJECTEDCRED);
>> +TRACE_DEFINE_ENUM(RPC_AUTH_BADVERF);
>> +TRACE_DEFINE_ENUM(RPC_AUTH_REJECTEDVERF);
>> +TRACE_DEFINE_ENUM(RPC_AUTH_TOOWEAK);
>> +TRACE_DEFINE_ENUM(RPCSEC_GSS_CREDPROBLEM);
>> +TRACE_DEFINE_ENUM(RPCSEC_GSS_CTXPROBLEM);
>> +
>> +#define rpc_show_auth_stat(status)					=
\
>> +	__print_symbolic(status,					=
\
>> +		{ RPC_AUTH_OK,			"AUTH_OK" },		=
\
>> +		{ RPC_AUTH_BADCRED,		"BADCRED" },		=
\
>> +		{ RPC_AUTH_REJECTEDCRED,	"REJECTEDCRED" },	=
\
>> +		{ RPC_AUTH_BADVERF,		"BADVERF" },		=
\
>> +		{ RPC_AUTH_REJECTEDVERF,	"REJECTEDVERF" },	=
\
>> +		{ RPC_AUTH_TOOWEAK,		"TOOWEAK" },		=
\
>> +		{ RPCSEC_GSS_CREDPROBLEM,	"GSS_CREDPROBLEM" },	=
\
>> +		{ RPCSEC_GSS_CTXPROBLEM,	"GSS_CTXPROBLEM" })	=
\
>> +
>> DECLARE_EVENT_CLASS(rpc_task_status,
>>=20
>> 	TP_PROTO(const struct rpc_task *task),
>> @@ -866,6 +886,41 @@
>> 			show_rqstp_flags(__entry->flags))
>> );
>>=20
>> +#define svc_show_status(status)				\
>> +	__print_symbolic(status,			\
>> +		{ SVC_GARBAGE,	"SVC_GARBAGE" },	\
>> +		{ SVC_SYSERR,	"SVC_SYSERR" },		\
>> +		{ SVC_VALID,	"SVC_VALID" },		\
>> +		{ SVC_NEGATIVE,	"SVC_NEGATIVE" },	\
>> +		{ SVC_OK,	"SVC_OK" },		\
>> +		{ SVC_DROP,	"SVC_DROP" },		\
>> +		{ SVC_CLOSE,	"SVC_CLOSE" },		\
>> +		{ SVC_DENIED,	"SVC_DENIED" },		\
>> +		{ SVC_PENDING,	"SVC_PENDING" },	\
>> +		{ SVC_COMPLETE,	"SVC_COMPLETE" })
>> +
>> +TRACE_EVENT(svc_authenticate,
>> +	TP_PROTO(const struct svc_rqst *rqst, int auth_res, __be32 =
auth_stat),
>> +
>> +	TP_ARGS(rqst, auth_res, auth_stat),
>> +
>> +	TP_STRUCT__entry(
>> +		__field(u32, xid)
>> +		__field(unsigned long, svc_status)
>> +		__field(unsigned long, auth_stat)
>> +	),
>> +
>> +	TP_fast_assign(
>> +		__entry->xid =3D be32_to_cpu(rqst->rq_xid);
>> +		__entry->svc_status =3D auth_res;
>> +		__entry->auth_stat =3D be32_to_cpu(auth_stat);
>> +	),
>> +
>> +	TP_printk("xid=3D0x%08x auth_res=3D%s auth_stat=3D%s",
>> +			__entry->xid, =
svc_show_status(__entry->svc_status),
>> +			rpc_show_auth_stat(__entry->auth_stat))
>> +);
>> +
>> TRACE_EVENT(svc_process,
>> 	TP_PROTO(const struct svc_rqst *rqst, const char *name),
>>=20
>> diff --git a/net/sunrpc/auth_gss/gss_mech_switch.c =
b/net/sunrpc/auth_gss/gss_mech_switch.c
>> index 8206009..30b7de6 100644
>> --- a/net/sunrpc/auth_gss/gss_mech_switch.c
>> +++ b/net/sunrpc/auth_gss/gss_mech_switch.c
>> @@ -20,6 +20,7 @@
>> #include <linux/sunrpc/sched.h>
>> #include <linux/sunrpc/gss_api.h>
>> #include <linux/sunrpc/clnt.h>
>> +#include <trace/events/rpcgss.h>
>>=20
>> #if IS_ENABLED(CONFIG_SUNRPC_DEBUG)
>> # define RPCDBG_FACILITY        RPCDBG_AUTH
>> @@ -158,7 +159,6 @@ struct gss_api_mech *gss_mech_get_by_OID(struct =
rpcsec_gss_oid *obj)
>>=20
>> 	if (sprint_oid(obj->data, obj->len, buf, sizeof(buf)) < 0)
>> 		return NULL;
>> -	dprintk("RPC:       %s(%s)\n", __func__, buf);
>> 	request_module("rpc-auth-gss-%s", buf);
>>=20
>> 	rcu_read_lock();
>> @@ -172,6 +172,8 @@ struct gss_api_mech *gss_mech_get_by_OID(struct =
rpcsec_gss_oid *obj)
>> 		}
>> 	}
>> 	rcu_read_unlock();
>> +	if (!gm)
>> +		trace_rpcgss_oid_to_mech(buf);
>> 	return gm;
>> }
>>=20
>> diff --git a/net/sunrpc/auth_gss/svcauth_gss.c =
b/net/sunrpc/auth_gss/svcauth_gss.c
>> index 8be2f20..f130990 100644
>> --- a/net/sunrpc/auth_gss/svcauth_gss.c
>> +++ b/net/sunrpc/auth_gss/svcauth_gss.c
>> @@ -49,6 +49,9 @@
>> #include <linux/sunrpc/svcauth.h>
>> #include <linux/sunrpc/svcauth_gss.h>
>> #include <linux/sunrpc/cache.h>
>> +
>> +#include <trace/events/rpcgss.h>
>> +
>> #include "gss_rpc_upcall.h"
>>=20
>>=20
>> @@ -1270,9 +1273,8 @@ static int svcauth_gss_proxy_init(struct =
svc_rqst *rqstp,
>> 	if (status)
>> 		goto out;
>>=20
>> -	dprintk("RPC:       svcauth_gss: gss major status =3D %d "
>> -			"minor status =3D %d\n",
>> -			ud.major_status, ud.minor_status);
>> +	trace_rpcgss_accept_upcall(rqstp->rq_xid, ud.major_status,
>> +				   ud.minor_status);
>>=20
>> 	switch (ud.major_status) {
>> 	case GSS_S_CONTINUE_NEEDED:
>> diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
>> index d11b705..187dd4e 100644
>> --- a/net/sunrpc/svc.c
>> +++ b/net/sunrpc/svc.c
>> @@ -1337,6 +1337,8 @@ static __printf(2,3) void svc_printk(struct =
svc_rqst *rqstp, const char *fmt, ..
>> 		auth_stat =3D rpc_autherr_badcred;
>> 		auth_res =3D progp->pg_authenticate(rqstp);
>> 	}
>> +	if (auth_res !=3D SVC_OK)
>> +		trace_svc_authenticate(rqstp, auth_res, auth_stat);
>> 	switch (auth_res) {
>> 	case SVC_OK:
>> 		break;
>> diff --git a/net/sunrpc/svcauth.c b/net/sunrpc/svcauth.c
>> index 550b214..552617e 100644
>> --- a/net/sunrpc/svcauth.c
>> +++ b/net/sunrpc/svcauth.c
>> @@ -19,6 +19,8 @@
>> #include <linux/err.h>
>> #include <linux/hash.h>
>>=20
>> +#include <trace/events/sunrpc.h>
>> +
>> #define RPCDBG_FACILITY	RPCDBG_AUTH
>>=20
>>=20

--
Chuck Lever



