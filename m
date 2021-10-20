Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C1174353F0
	for <lists+linux-nfs@lfdr.de>; Wed, 20 Oct 2021 21:40:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231592AbhJTTmT (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 20 Oct 2021 15:42:19 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:31736 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231485AbhJTTmT (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 20 Oct 2021 15:42:19 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19KIUswR020887;
        Wed, 20 Oct 2021 19:40:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=k+43JqDhAzOnGX9OIgALZ8YlltcLrGweqyhPYDMTZDI=;
 b=vEuWIMVvZvODHZ7ULc8BafRRNmpWgKC8Q2BRKGZS0o1+bhSAjD0g4pvmvqlBrgR/r1sL
 0OdoHKZZ8IK9PAcF2M9xiLrhMlr1Oplsc6DAoXuR/y4600V/3R1rLQiwxP0fgUKHY7R4
 4bBwG5FKzKsNUTtlU4HYoGlivn8coBEEKffIlbPCFnx40GQjgsWfzbil5oNrA6BpyjGS
 nsuCp5h1p+pge1pzDafwbg0RYzJqoKGRR8qye6/FUCVjPpi9lZHHWGmTfQ56jJg/oO6w
 WxaYnN5rQ6IEUCdSmGDfYWxrUlYDTjQdu/LphX5qiAjv+Fb9WXEy+ObC0ukx8k04ug5I +Q== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3btkx9te9u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Oct 2021 19:40:02 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 19KJLCMB194035;
        Wed, 20 Oct 2021 19:40:01 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2107.outbound.protection.outlook.com [104.47.55.107])
        by aserp3020.oracle.com with ESMTP id 3bqpj7kmw3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Oct 2021 19:40:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gl+zALRIZ7/vPe3h24cawmRx3/NVUetvjK5AHv+qEkdO32LtpSE4TZktnZvNL2Y7/YgG5WrCjsAiw7oeMKUWIhB6BOnRkgIoWU1VSJkuDK6NhdrdryaIw3vCG5rBSv6Yh5G5H7KD2brf4VXavQtoJh1teQRshNkcP7qZi8yA48E6THXT5C8bANnBp1x0CbvOoQFLdFZDmdaonFFeFvosFzZhi3YtFsowt0tqfQhTtzSGVlYEXPBg/E8NsssiKiOv8dacfhCpSIsp1EvTxfGKAttngnIol462+7cwq6XTZvX13BRMuN6l+/YaBuXwm0yzr1iFtgP87+aT24qWasrnUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k+43JqDhAzOnGX9OIgALZ8YlltcLrGweqyhPYDMTZDI=;
 b=YkflKf/ATKqXvi7RSMsUWpzvJA5+ERaLcnfsoKU6d9UJruSutciklngUNEJNoYUKIseZzt90XLFbAEj0qwv481Zy0tRKPtimDE0Ngm7jkERZUr2oZjjU2cVGN3s7Hg7Fk+QFb/TkFLwCVcCEHhRTCfNRhjLQJb93nTGx1Dj4goCRwDdIp/ZetIUohXFTl7Q6zhO69kB6CZjbDbuBZO54v9wVCJiuJq8EVMd8m579i75gBRK38pZMryGKeC4apbZX2wQUqFWY8o4apbvoFtFCng4eM6dxbMVOdJAVI1qcpDRKAAWAcsiahWWSKB6CIh3aNAk9XaX3yK9DujydUAUyJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k+43JqDhAzOnGX9OIgALZ8YlltcLrGweqyhPYDMTZDI=;
 b=AJT5qnrXv9TV/nd74HoClC88H2jo3MTfBtxuHdpuik9mopMxCSlEXdT4RoId2i1i0VyQfQZPaiB6KwjSnkbe3OGGYbMJAfFYZgikohCxM6UA+N4jhrw/2C69tVlY8lOoD9MtvyDmUUAqqOv/VGwf0O2In8g1qrN5vzlSLBkfi4w=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by SJ0PR10MB4637.namprd10.prod.outlook.com (2603:10b6:a03:2d6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16; Wed, 20 Oct
 2021 19:39:58 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::f4fe:5b4:6bd9:4c5b]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::f4fe:5b4:6bd9:4c5b%6]) with mapi id 15.20.4608.019; Wed, 20 Oct 2021
 19:39:58 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Trond Myklebust <trondmy@hammerspace.com>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v4 2/7] SUNRPC: Avoid NULL pointer dereferences in
 tracepoints
Thread-Topic: [PATCH v4 2/7] SUNRPC: Avoid NULL pointer dereferences in
 tracepoints
Thread-Index: AQHXwtmKRj3EaCPKkkGJmM5iCWe6yKvcPyuAgAAPqIA=
Date:   Wed, 20 Oct 2021 19:39:58 +0000
Message-ID: <E4131978-F5B3-418B-B402-098FF6E51E42@oracle.com>
References: <163442096873.1585.8967342784030733636.stgit@morisot.1015granger.net>
 <163442175137.1585.5220370195383350175.stgit@morisot.1015granger.net>
 <7cf900a259aba1ef9e7b4e081945fe63779f2db9.camel@hammerspace.com>
In-Reply-To: <7cf900a259aba1ef9e7b4e081945fe63779f2db9.camel@hammerspace.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
authentication-results: hammerspace.com; dkim=none (message not signed)
 header.d=none;hammerspace.com; dmarc=none action=none header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5c23c4f7-84e8-445a-0906-08d99401667c
x-ms-traffictypediagnostic: SJ0PR10MB4637:
x-microsoft-antispam-prvs: <SJ0PR10MB4637489082793948F35FE65B93BE9@SJ0PR10MB4637.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1332;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tcHbktZmxOgUdeR0BsyisUA+jRSusAe9CH3kT3si3ZR8LJ/pM+FJJiVjXsxVFkoJT087e23MamO2Do2F1JEzxB3AazIBeDEzhBhoqodQ7MBxKlZIZMDcQHgEOxK7ZOp3Ind+zFfMjLHxlbwrfH8+bBCPxsWXukxznvXKyPyptZLf3spxbjK6nbexISqskodsBmHqOo+bskdFntgXWuEAiPSKaB65edn8/bfl6q0MWnIVQoCHyJXkNddWfzx4v12iISLRhxSYanI3UMj4RVddKyDZv93jcBRPbgHCbStGu5MqriOjo7lWthTfbFe+pPZmWlGx4Ch9Bac9PGK2snAgJvOd4lJ9razTd/xevFcZliNm/yYRzbIhdQ2+mxvWyCCFqJkpLTX4bDDwWWAwxFUfPvIHezJjxW/iNaHlp37chp6uNZRQwEj9OlXjUqN+ezRu3pLbgcRY+YL0WkvF9Ej2Sp4mCxdImalea2GYUfJ13plk0m/0EoslxzVnnNJZXQF1EoOtVwROWX37JdWrR8Fqf0NFFUx4qwvERqGIIB3rgcs6mCXe40gYGKrTNhsVVeM5Pj2clvDJfAKO4Wlm9s8uZ2AssyCqDRpqd8mwrDBqEGWzxDM9jdIZzVz8+km97orCagDu3VpSpDNynL4OJ5l8rOxs3LtrH2fsA6kqpqwiZ9EcsDzYX7HSfdP+XboaOYkj2sL1CQUR6uWp9gbwGIiMTF6r/2sQl7pNfjLCG0hBRAo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(91956017)(64756008)(66446008)(38100700002)(66556008)(66476007)(86362001)(76116006)(38070700005)(26005)(66946007)(6512007)(5660300002)(6506007)(36756003)(316002)(53546011)(6916009)(4326008)(186003)(30864003)(8676002)(83380400001)(8936002)(6486002)(71200400001)(33656002)(508600001)(122000001)(2616005)(2906002)(4001150100001)(45980500001)(559001)(579004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?QKvBHlKI/jXXPlv4EBC0mgvgcXF5MjD5JJ0+5bgyZKQT3dMl4ADxykjMNPRW?=
 =?us-ascii?Q?+Bi1rxSpn4JMYnSr/1LOOuxP1qAxw12gjbldXolq1h09AVO1f9VFsk9MugVr?=
 =?us-ascii?Q?MXBakxI2DR8z7ZqYiznoKKZ/MBrJBL4Nn5+bZGtYuKTHC9t4dBYSJd66SBU7?=
 =?us-ascii?Q?8w8wcxT1QfiCo4RgLakGXS4BAMAz3NcC1wzjDQG1dBvB9yn2EoYOArlxKyy+?=
 =?us-ascii?Q?KKLLBJS3E7+gZjXZNJN/3NLViaoEnGczgx7fBjP2coCzO5e7TVq4iIAfXTFr?=
 =?us-ascii?Q?UNXHLGJGORi+rB03gA5uS/cekW6yEg6sZh+JZuZUx/Ugu885EOvN7UocBAoR?=
 =?us-ascii?Q?lgjtU3kGPj+sMKVbhpKyfuhxFQo5wCGtWSx2iPzu4K3fsLWxz5tcR0E0QkeV?=
 =?us-ascii?Q?bQCCc3FTIYfJuxJZQietcnMu+qPI5EDMeTUnOzPMtGjFCCHCecETCIbCJUq9?=
 =?us-ascii?Q?7l6F2ZwCv63aIdv1WVWiueS79uhtR+9YmU7NQaY5luW6yrPO337aRp5jc8Ma?=
 =?us-ascii?Q?y7gKW2oYg0zaPQY0pIDVDVLutdSuD72oAPQAVdKz5FMewJp28POHPocNzBjH?=
 =?us-ascii?Q?HGxL4hW55OboA9/MFkBV6gWTRf5jtBQok9XIqE1MXY2brLyULYX3HRSbO5BM?=
 =?us-ascii?Q?VmBeaf3oINcDxLZigW94U9puVgxnwx3oGpAUam6Wo+kfX39jWCs0an70cTg7?=
 =?us-ascii?Q?Ld+Ti+ll4SmxT7bE2S5RADE2fo7UVONEz2Wq4DY0t7kXg0HoLHaAbuIGx11b?=
 =?us-ascii?Q?bSQUQiTUL3umNH/HeRFSIQS+MCVEEOtP4OxpP0Hp4uOuuBG0u3TT+8XEm7up?=
 =?us-ascii?Q?i2d4KgS11V7rLAgGlZ5dVaEpRfFT24Q6IicBCqdMHAAPlFvwxgWAkTodVFJi?=
 =?us-ascii?Q?bk9fDCHnp7IGYLTwuUq4JpgKb2nEkeyZmklLEcGFC7Qeue3JjpDrUD1Pramz?=
 =?us-ascii?Q?mZ2okNo12ZdocG1HXOD7bZMmO4evFfRsgXfishz+lx9oRAEK6WMHbfiiT7KM?=
 =?us-ascii?Q?ssr6facwWQUd1rQn+5FP1dnJElQpYJPS1VmRB4hfHsOn1lutKCG9OGhQczbT?=
 =?us-ascii?Q?/+hh73gJg0wnrWnYOmJgPtdBWggFpp5NC9ZPhqRfddp9jTa0Gl4WnMO2HgS3?=
 =?us-ascii?Q?AhiTbLNBSOeBT/IdhEcEljehnmZhjmmIJNy2w2G+5CsnVOInOUM4SwEs6qjo?=
 =?us-ascii?Q?Ez4cHHjDzj2yf82ML9n5Zf0rg+PRDyh3p3bS4/ey/ADHd/Cj2ezMOosBh2E6?=
 =?us-ascii?Q?3SjrAXjSjsCQmLyjU/r3aunrd5tZ9Sfv6pGYalypS4mlP11VVzRTwv/w04/e?=
 =?us-ascii?Q?/EYiB48kpczMDfvEWOnn3fF0?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <53A33CBC8F6E08459F371CFBBFE0D36D@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c23c4f7-84e8-445a-0906-08d99401667c
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2021 19:39:58.1653
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HIcInow1Fx/5hAojTiTG5pb7V1gjnY70F5/Pumi0rmZqbPivJuI20gdO/9iwZ8EhFyLwXtunO+xUQ6PWIIy/AA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4637
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10143 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 adultscore=0
 malwarescore=0 phishscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110200111
X-Proofpoint-ORIG-GUID: 2Dhg2XIj-UuwhlIvlJDWFoKEw9sNBKsV
X-Proofpoint-GUID: 2Dhg2XIj-UuwhlIvlJDWFoKEw9sNBKsV
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Oct 20, 2021, at 2:43 PM, Trond Myklebust <trondmy@hammerspace.com> wr=
ote:
>=20
> On Sat, 2021-10-16 at 18:02 -0400, Chuck Lever wrote:
>> On occasion, a NULL rpc_task pointer is passed into tracepoints.
>> We've open-coded a few places where this is expected, but let's
>> be defensive and protect every place that wants to dereference
>> a task to assign the tk_pid and cl_clid.
>>=20
>=20
> No, I won't apply this.
>=20
> This patch is going to lead to a bunch of static checkers complaining
> that we're checking 'task' for NULL after we've already dereferenced it
> in the same function, and/or complaining that we're dereferencing a
> value that might be null because we just had a check for it.

Interesting. I already run "make C=3D1 W=3D1" on every patch. I can update
my development workflow.  Which static checker complains?


> Even within the macros touched by this patch, we have instances of the
> latter occurring, where we read task->tk_client->cl_vers (and other
> fields) immediately after we just declared that we had to check both
> task and task->tk_client for NULL.

Very likely copy-pasta mistakes, but again, my tool chain hadn't
complained.


>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>> ---
>>  fs/nfs/nfs4trace.h                 |    8 +---
>>  fs/nfs/nfstrace.h                  |    3 -
>>  include/trace/events/rpcgss.h      |   18 +++-----
>>  include/trace/events/rpcrdma.h     |   62 ++++++++------------------
>> ---
>>  include/trace/events/sunrpc.h      |   77 +++++++++-----------------
>> ----------
>>  include/trace/events/sunrpc_base.h |   15 +++++++
>>  6 files changed, 61 insertions(+), 122 deletions(-)
>>=20
>> diff --git a/fs/nfs/nfs4trace.h b/fs/nfs/nfs4trace.h
>> index d4f061046c09..66fbd3c33c15 100644
>> --- a/fs/nfs/nfs4trace.h
>> +++ b/fs/nfs/nfs4trace.h
>> @@ -686,10 +686,8 @@ TRACE_EVENT(nfs4_xdr_bad_operation,
>> =20
>>                 TP_fast_assign(
>>                         const struct rpc_rqst *rqstp =3D xdr->rqst;
>> -                       const struct rpc_task *task =3D rqstp->rq_task;
>> =20
>> -                       __entry->task_id =3D task->tk_pid;
>> -                       __entry->client_id =3D task->tk_client-
>>> cl_clid;
>> +                       SUNRPC_TRACE_TASK_ASSIGN(rqstp->rq_task);
>>                         __entry->xid =3D be32_to_cpu(rqstp->rq_xid);
>>                         __entry->op =3D op;
>>                         __entry->expected =3D expected;
>> @@ -721,10 +719,8 @@ DECLARE_EVENT_CLASS(nfs4_xdr_event,
>> =20
>>                 TP_fast_assign(
>>                         const struct rpc_rqst *rqstp =3D xdr->rqst;
>> -                       const struct rpc_task *task =3D rqstp->rq_task;
>> =20
>> -                       __entry->task_id =3D task->tk_pid;
>> -                       __entry->client_id =3D task->tk_client-
>>> cl_clid;
>> +                       SUNRPC_TRACE_TASK_ASSIGN(rqstp->rq_task);
>>                         __entry->xid =3D be32_to_cpu(rqstp->rq_xid);
>>                         __entry->op =3D op;
>>                         __entry->error =3D error;
>> diff --git a/fs/nfs/nfstrace.h b/fs/nfs/nfstrace.h
>> index 82b51120450f..e9be65b52bfe 100644
>> --- a/fs/nfs/nfstrace.h
>> +++ b/fs/nfs/nfstrace.h
>> @@ -1401,8 +1401,7 @@ DECLARE_EVENT_CLASS(nfs_xdr_event,
>>                         const struct rpc_rqst *rqstp =3D xdr->rqst;
>>                         const struct rpc_task *task =3D rqstp->rq_task;
>> =20
>> -                       __entry->task_id =3D task->tk_pid;
>> -                       __entry->client_id =3D task->tk_client-
>>> cl_clid;
>> +                       SUNRPC_TRACE_TASK_ASSIGN(task);
>>                         __entry->xid =3D be32_to_cpu(rqstp->rq_xid);
>>                         __entry->version =3D task->tk_client->cl_vers;
>>                         __entry->error =3D error;
>> diff --git a/include/trace/events/rpcgss.h
>> b/include/trace/events/rpcgss.h
>> index 3ba63319af3c..87b17ebd09c3 100644
>> --- a/include/trace/events/rpcgss.h
>> +++ b/include/trace/events/rpcgss.h
>> @@ -96,8 +96,7 @@ DECLARE_EVENT_CLASS(rpcgss_gssapi_event,
>>         ),
>> =20
>>         TP_fast_assign(
>> -               __entry->task_id =3D task->tk_pid;
>> -               __entry->client_id =3D task->tk_client->cl_clid;
>> +               SUNRPC_TRACE_TASK_ASSIGN(task);
>>                 __entry->maj_stat =3D maj_stat;
>>         ),
>> =20
>> @@ -330,8 +329,7 @@ TRACE_EVENT(rpcgss_unwrap_failed,
>>         ),
>> =20
>>         TP_fast_assign(
>> -               __entry->task_id =3D task->tk_pid;
>> -               __entry->client_id =3D task->tk_client->cl_clid;
>> +               SUNRPC_TRACE_TASK_ASSIGN(task);
>>         ),
>> =20
>>         TP_printk(SUNRPC_TRACE_TASK_SPECIFIER,
>> @@ -355,8 +353,7 @@ TRACE_EVENT(rpcgss_bad_seqno,
>>         ),
>> =20
>>         TP_fast_assign(
>> -               __entry->task_id =3D task->tk_pid;
>> -               __entry->client_id =3D task->tk_client->cl_clid;
>> +               SUNRPC_TRACE_TASK_ASSIGN(task);
>>                 __entry->expected =3D expected;
>>                 __entry->received =3D received;
>>         ),
>> @@ -384,8 +381,7 @@ TRACE_EVENT(rpcgss_seqno,
>>         TP_fast_assign(
>>                 const struct rpc_rqst *rqst =3D task->tk_rqstp;
>> =20
>> -               __entry->task_id =3D task->tk_pid;
>> -               __entry->client_id =3D task->tk_client->cl_clid;
>> +               SUNRPC_TRACE_TASK_ASSIGN(task);
>>                 __entry->xid =3D be32_to_cpu(rqst->rq_xid);
>>                 __entry->seqno =3D rqst->rq_seqno;
>>         ),
>> @@ -414,8 +410,7 @@ TRACE_EVENT(rpcgss_need_reencode,
>>         ),
>> =20
>>         TP_fast_assign(
>> -               __entry->task_id =3D task->tk_pid;
>> -               __entry->client_id =3D task->tk_client->cl_clid;
>> +               SUNRPC_TRACE_TASK_ASSIGN(task);
>>                 __entry->xid =3D be32_to_cpu(task->tk_rqstp->rq_xid);
>>                 __entry->seq_xmit =3D seq_xmit;
>>                 __entry->seqno =3D task->tk_rqstp->rq_seqno;
>> @@ -448,8 +443,7 @@ TRACE_EVENT(rpcgss_update_slack,
>>         ),
>> =20
>>         TP_fast_assign(
>> -               __entry->task_id =3D task->tk_pid;
>> -               __entry->client_id =3D task->tk_client->cl_clid;
>> +               SUNRPC_TRACE_TASK_ASSIGN(task);
>>                 __entry->xid =3D be32_to_cpu(task->tk_rqstp->rq_xid);
>>                 __entry->auth =3D auth;
>>                 __entry->rslack =3D auth->au_rslack;
>> diff --git a/include/trace/events/rpcrdma.h
>> b/include/trace/events/rpcrdma.h
>> index 7f46ef621c95..c2ab9e5d775b 100644
>> --- a/include/trace/events/rpcrdma.h
>> +++ b/include/trace/events/rpcrdma.h
>> @@ -271,8 +271,7 @@ DECLARE_EVENT_CLASS(xprtrdma_rdch_event,
>>         ),
>> =20
>>         TP_fast_assign(
>> -               __entry->task_id =3D task->tk_pid;
>> -               __entry->client_id =3D task->tk_client->cl_clid;
>> +               SUNRPC_TRACE_TASK_ASSIGN(task);
>>                 __entry->pos =3D pos;
>>                 __entry->nents =3D mr->mr_nents;
>>                 __entry->handle =3D mr->mr_handle;
>> @@ -320,8 +319,7 @@ DECLARE_EVENT_CLASS(xprtrdma_wrch_event,
>>         ),
>> =20
>>         TP_fast_assign(
>> -               __entry->task_id =3D task->tk_pid;
>> -               __entry->client_id =3D task->tk_client->cl_clid;
>> +               SUNRPC_TRACE_TASK_ASSIGN(task);
>>                 __entry->nents =3D mr->mr_nents;
>>                 __entry->handle =3D mr->mr_handle;
>>                 __entry->length =3D mr->mr_length;
>> @@ -380,15 +378,8 @@ DECLARE_EVENT_CLASS(xprtrdma_mr_class,
>>         TP_fast_assign(
>>                 const struct rpcrdma_req *req =3D mr->mr_req;
>> =20
>> -               if (req) {
>> -                       const struct rpc_task *task =3D req-
>>> rl_slot.rq_task;
>> -
>> -                       __entry->task_id =3D task->tk_pid;
>> -                       __entry->client_id =3D task->tk_client-
>>> cl_clid;
>> -               } else {
>> -                       __entry->task_id =3D 0;
>> -                       __entry->client_id =3D -1;
>> -               }
>> +               if (req)
>> +                       SUNRPC_TRACE_TASK_ASSIGN(req-
>>> rl_slot.rq_task);
>>                 __entry->mr_id  =3D mr->mr_ibmr->res.id;
>>                 __entry->nents  =3D mr->mr_nents;
>>                 __entry->handle =3D mr->mr_handle;
>> @@ -633,10 +624,7 @@ TRACE_EVENT(xprtrdma_nomrs_err,
>>         ),
>> =20
>>         TP_fast_assign(
>> -               const struct rpc_rqst *rqst =3D &req->rl_slot;
>> -
>> -               __entry->task_id =3D rqst->rq_task->tk_pid;
>> -               __entry->client_id =3D rqst->rq_task->tk_client-
>>> cl_clid;
>> +               SUNRPC_TRACE_TASK_ASSIGN(req->rl_slot.rq_task);
>>                 __assign_str(addr, rpcrdma_addrstr(r_xprt));
>>                 __assign_str(port, rpcrdma_portstr(r_xprt));
>>         ),
>> @@ -694,8 +682,7 @@ TRACE_EVENT(xprtrdma_marshal,
>>         TP_fast_assign(
>>                 const struct rpc_rqst *rqst =3D &req->rl_slot;
>> =20
>> -               __entry->task_id =3D rqst->rq_task->tk_pid;
>> -               __entry->client_id =3D rqst->rq_task->tk_client-
>>> cl_clid;
>> +               SUNRPC_TRACE_TASK_ASSIGN(rqst->rq_task);
>>                 __entry->xid =3D be32_to_cpu(rqst->rq_xid);
>>                 __entry->hdrlen =3D req->rl_hdrbuf.len;
>>                 __entry->headlen =3D rqst->rq_snd_buf.head[0].iov_len;
>> @@ -730,8 +717,7 @@ TRACE_EVENT(xprtrdma_marshal_failed,
>>         ),
>> =20
>>         TP_fast_assign(
>> -               __entry->task_id =3D rqst->rq_task->tk_pid;
>> -               __entry->client_id =3D rqst->rq_task->tk_client-
>>> cl_clid;
>> +               SUNRPC_TRACE_TASK_ASSIGN(rqst->rq_task);
>>                 __entry->xid =3D be32_to_cpu(rqst->rq_xid);
>>                 __entry->ret =3D ret;
>>         ),
>> @@ -757,8 +743,7 @@ TRACE_EVENT(xprtrdma_prepsend_failed,
>>         ),
>> =20
>>         TP_fast_assign(
>> -               __entry->task_id =3D rqst->rq_task->tk_pid;
>> -               __entry->client_id =3D rqst->rq_task->tk_client-
>>> cl_clid;
>> +               SUNRPC_TRACE_TASK_ASSIGN(rqst->rq_task);
>>                 __entry->xid =3D be32_to_cpu(rqst->rq_xid);
>>                 __entry->ret =3D ret;
>>         ),
>> @@ -791,9 +776,7 @@ TRACE_EVENT(xprtrdma_post_send,
>> =20
>>                 __entry->cq_id =3D sc->sc_cid.ci_queue_id;
>>                 __entry->completion_id =3D sc->sc_cid.ci_completion_id;
>> -               __entry->task_id =3D rqst->rq_task->tk_pid;
>> -               __entry->client_id =3D rqst->rq_task->tk_client ?
>> -                                    rqst->rq_task->tk_client-
>>> cl_clid : -1;
>> +               SUNRPC_TRACE_TASK_ASSIGN(rqst->rq_task);
>>                 __entry->num_sge =3D req->rl_wr.num_sge;
>>                 __entry->signaled =3D req->rl_wr.send_flags &
>> IB_SEND_SIGNALED;
>>         ),
>> @@ -827,9 +810,7 @@ TRACE_EVENT(xprtrdma_post_send_err,
>>                 const struct rpcrdma_ep *ep =3D r_xprt->rx_ep;
>> =20
>>                 __entry->cq_id =3D ep ? ep->re_attr.recv_cq->res.id :
>> 0;
>> -               __entry->task_id =3D rqst->rq_task->tk_pid;
>> -               __entry->client_id =3D rqst->rq_task->tk_client ?
>> -                                    rqst->rq_task->tk_client-
>>> cl_clid : -1;
>> +               SUNRPC_TRACE_TASK_ASSIGN(rqst->rq_task);
>>                 __entry->rc =3D rc;
>>         ),
>> =20
>> @@ -938,10 +919,7 @@ TRACE_EVENT(xprtrdma_post_linv_err,
>>         ),
>> =20
>>         TP_fast_assign(
>> -               const struct rpc_task *task =3D req->rl_slot.rq_task;
>> -
>> -               __entry->task_id =3D task->tk_pid;
>> -               __entry->client_id =3D task->tk_client->cl_clid;
>> +               SUNRPC_TRACE_TASK_ASSIGN(req->rl_slot.rq_task);
>>                 __entry->status =3D status;
>>         ),
>> =20
>> @@ -1127,8 +1105,7 @@ TRACE_EVENT(xprtrdma_reply,
>>         ),
>> =20
>>         TP_fast_assign(
>> -               __entry->task_id =3D task->tk_pid;
>> -               __entry->client_id =3D task->tk_client->cl_clid;
>> +               SUNRPC_TRACE_TASK_ASSIGN(task);
>>                 __entry->xid =3D be32_to_cpu(rep->rr_xid);
>>                 __entry->credits =3D credits;
>>         ),
>> @@ -1162,8 +1139,7 @@ TRACE_EVENT(xprtrdma_err_vers,
>>         ),
>> =20
>>         TP_fast_assign(
>> -               __entry->task_id =3D rqst->rq_task->tk_pid;
>> -               __entry->client_id =3D rqst->rq_task->tk_client-
>>> cl_clid;
>> +               SUNRPC_TRACE_TASK_ASSIGN(rqst->rq_task);
>>                 __entry->xid =3D be32_to_cpu(rqst->rq_xid);
>>                 __entry->min =3D be32_to_cpup(min);
>>                 __entry->max =3D be32_to_cpup(max);
>> @@ -1189,8 +1165,7 @@ TRACE_EVENT(xprtrdma_err_chunk,
>>         ),
>> =20
>>         TP_fast_assign(
>> -               __entry->task_id =3D rqst->rq_task->tk_pid;
>> -               __entry->client_id =3D rqst->rq_task->tk_client-
>>> cl_clid;
>> +               SUNRPC_TRACE_TASK_ASSIGN(rqst->rq_task);
>>                 __entry->xid =3D be32_to_cpu(rqst->rq_xid);
>>         ),
>> =20
>> @@ -1215,8 +1190,7 @@ TRACE_EVENT(xprtrdma_err_unrecognized,
>>         ),
>> =20
>>         TP_fast_assign(
>> -               __entry->task_id =3D rqst->rq_task->tk_pid;
>> -               __entry->client_id =3D rqst->rq_task->tk_client-
>>> cl_clid;
>> +               SUNRPC_TRACE_TASK_ASSIGN(rqst->rq_task);
>>                 __entry->procedure =3D be32_to_cpup(procedure);
>>         ),
>> =20
>> @@ -1244,8 +1218,7 @@ TRACE_EVENT(xprtrdma_fixup,
>>         ),
>> =20
>>         TP_fast_assign(
>> -               __entry->task_id =3D rqst->rq_task->tk_pid;
>> -               __entry->client_id =3D rqst->rq_task->tk_client-
>>> cl_clid;
>> +               SUNRPC_TRACE_TASK_ASSIGN(rqst->rq_task);
>>                 __entry->fixup =3D fixup;
>>                 __entry->headlen =3D rqst->rq_rcv_buf.head[0].iov_len;
>>                 __entry->pagelen =3D rqst->rq_rcv_buf.page_len;
>> @@ -1298,8 +1271,7 @@ TRACE_EVENT(xprtrdma_mrs_zap,
>>         ),
>> =20
>>         TP_fast_assign(
>> -               __entry->task_id =3D task->tk_pid;
>> -               __entry->client_id =3D task->tk_client->cl_clid;
>> +               SUNRPC_TRACE_TASK_ASSIGN(task);
>>         ),
>> =20
>>         TP_printk(SUNRPC_TRACE_TASK_SPECIFIER,
>> diff --git a/include/trace/events/sunrpc.h
>> b/include/trace/events/sunrpc.h
>> index 92def7d6663e..4fd6299bc907 100644
>> --- a/include/trace/events/sunrpc.h
>> +++ b/include/trace/events/sunrpc.h
>> @@ -69,9 +69,7 @@ DECLARE_EVENT_CLASS(rpc_xdr_buf_class,
>>         ),
>> =20
>>         TP_fast_assign(
>> -               __entry->task_id =3D task->tk_pid;
>> -               __entry->client_id =3D task->tk_client ?
>> -                                    task->tk_client->cl_clid : -1;
>> +               SUNRPC_TRACE_TASK_ASSIGN(task);
>>                 __entry->head_base =3D xdr->head[0].iov_base;
>>                 __entry->head_len =3D xdr->head[0].iov_len;
>>                 __entry->tail_base =3D xdr->tail[0].iov_base;
>> @@ -248,8 +246,7 @@ DECLARE_EVENT_CLASS(rpc_task_status,
>>         ),
>> =20
>>         TP_fast_assign(
>> -               __entry->task_id =3D task->tk_pid;
>> -               __entry->client_id =3D task->tk_client->cl_clid;
>> +               SUNRPC_TRACE_TASK_ASSIGN(task);
>>                 __entry->status =3D task->tk_status;
>>         ),
>> =20
>> @@ -285,8 +282,7 @@ TRACE_EVENT(rpc_request,
>>         ),
>> =20
>>         TP_fast_assign(
>> -               __entry->task_id =3D task->tk_pid;
>> -               __entry->client_id =3D task->tk_client->cl_clid;
>> +               SUNRPC_TRACE_TASK_ASSIGN(task);
>>                 __entry->version =3D task->tk_client->cl_vers;
>>                 __entry->async =3D RPC_IS_ASYNC(task);
>>                 __assign_str(progname, task->tk_client->cl_program-
>>> name);
>> @@ -344,9 +340,7 @@ DECLARE_EVENT_CLASS(rpc_task_running,
>>                 ),
>> =20
>>         TP_fast_assign(
>> -               __entry->client_id =3D task->tk_client ?
>> -                                    task->tk_client->cl_clid : -1;
>> -               __entry->task_id =3D task->tk_pid;
>> +               SUNRPC_TRACE_TASK_ASSIGN(task);
>>                 __entry->action =3D action;
>>                 __entry->runstate =3D task->tk_runstate;
>>                 __entry->status =3D task->tk_status;
>> @@ -396,9 +390,7 @@ DECLARE_EVENT_CLASS(rpc_task_queued,
>>                 ),
>> =20
>>         TP_fast_assign(
>> -               __entry->client_id =3D task->tk_client ?
>> -                                    task->tk_client->cl_clid : -1;
>> -               __entry->task_id =3D task->tk_pid;
>> +               SUNRPC_TRACE_TASK_ASSIGN(task);
>>                 __entry->timeout =3D rpc_task_timeout(task);
>>                 __entry->runstate =3D task->tk_runstate;
>>                 __entry->status =3D task->tk_status;
>> @@ -439,8 +431,7 @@ DECLARE_EVENT_CLASS(rpc_failure,
>>         ),
>> =20
>>         TP_fast_assign(
>> -               __entry->task_id =3D task->tk_pid;
>> -               __entry->client_id =3D task->tk_client->cl_clid;
>> +               SUNRPC_TRACE_TASK_ASSIGN(task);
>>         ),
>> =20
>>         TP_printk(SUNRPC_TRACE_TASK_SPECIFIER,
>> @@ -476,8 +467,7 @@ DECLARE_EVENT_CLASS(rpc_reply_event,
>>         ),
>> =20
>>         TP_fast_assign(
>> -               __entry->task_id =3D task->tk_pid;
>> -               __entry->client_id =3D task->tk_client->cl_clid;
>> +               SUNRPC_TRACE_TASK_ASSIGN(task);
>>                 __entry->xid =3D be32_to_cpu(task->tk_rqstp->rq_xid);
>>                 __assign_str(progname, task->tk_client->cl_program-
>>> name);
>>                 __entry->version =3D task->tk_client->cl_vers;
>> @@ -539,8 +529,7 @@ TRACE_EVENT(rpc_buf_alloc,
>>         ),
>> =20
>>         TP_fast_assign(
>> -               __entry->task_id =3D task->tk_pid;
>> -               __entry->client_id =3D task->tk_client->cl_clid;
>> +               SUNRPC_TRACE_TASK_ASSIGN(task);
>>                 __entry->callsize =3D task->tk_rqstp->rq_callsize;
>>                 __entry->recvsize =3D task->tk_rqstp->rq_rcvsize;
>>                 __entry->status =3D status;
>> @@ -570,8 +559,7 @@ TRACE_EVENT(rpc_call_rpcerror,
>>         ),
>> =20
>>         TP_fast_assign(
>> -               __entry->client_id =3D task->tk_client->cl_clid;
>> -               __entry->task_id =3D task->tk_pid;
>> +               SUNRPC_TRACE_TASK_ASSIGN(task);
>>                 __entry->tk_status =3D tk_status;
>>                 __entry->rpc_status =3D rpc_status;
>>         ),
>> @@ -606,8 +594,7 @@ TRACE_EVENT(rpc_stats_latency,
>>         ),
>> =20
>>         TP_fast_assign(
>> -               __entry->client_id =3D task->tk_client->cl_clid;
>> -               __entry->task_id =3D task->tk_pid;
>> +               SUNRPC_TRACE_TASK_ASSIGN(task);
>>                 __entry->xid =3D be32_to_cpu(task->tk_rqstp->rq_xid);
>>                 __entry->version =3D task->tk_client->cl_vers;
>>                 __assign_str(progname, task->tk_client->cl_program-
>>> name);
>> @@ -655,8 +642,7 @@ TRACE_EVENT(rpc_xdr_overflow,
>>                 if (xdr->rqst) {
>>                         const struct rpc_task *task =3D xdr->rqst-
>>> rq_task;
>> =20
>> -                       __entry->task_id =3D task->tk_pid;
>> -                       __entry->client_id =3D task->tk_client-
>>> cl_clid;
>> +                       SUNRPC_TRACE_TASK_ASSIGN(task);
>>                         __assign_str(progname,
>>                                      task->tk_client->cl_program-
>>> name);
>>                         __entry->version =3D task->tk_client->cl_vers;
>> @@ -721,8 +707,7 @@ TRACE_EVENT(rpc_xdr_alignment,
>>         TP_fast_assign(
>>                 const struct rpc_task *task =3D xdr->rqst->rq_task;
>> =20
>> -               __entry->task_id =3D task->tk_pid;
>> -               __entry->client_id =3D task->tk_client->cl_clid;
>> +               SUNRPC_TRACE_TASK_ASSIGN(task);
>>                 __assign_str(progname,
>>                              task->tk_client->cl_program->name);
>>                 __entry->version =3D task->tk_client->cl_vers;
>> @@ -922,8 +907,7 @@ TRACE_EVENT(rpc_socket_nospace,
>>         ),
>> =20
>>         TP_fast_assign(
>> -               __entry->task_id =3D rqst->rq_task->tk_pid;
>> -               __entry->client_id =3D rqst->rq_task->tk_client-
>>> cl_clid;
>> +               SUNRPC_TRACE_TASK_ASSIGN(rqst->rq_task);
>>                 __entry->total =3D rqst->rq_slen;
>>                 __entry->remaining =3D rqst->rq_slen - transport-
>>> xmit.offset;
>>         ),
>> @@ -1046,9 +1030,7 @@ TRACE_EVENT(xprt_transmit,
>>         ),
>> =20
>>         TP_fast_assign(
>> -               __entry->task_id =3D rqst->rq_task->tk_pid;
>> -               __entry->client_id =3D rqst->rq_task->tk_client ?
>> -                       rqst->rq_task->tk_client->cl_clid : -1;
>> +               SUNRPC_TRACE_TASK_ASSIGN(rqst->rq_task);
>>                 __entry->xid =3D be32_to_cpu(rqst->rq_xid);
>>                 __entry->seqno =3D rqst->rq_seqno;
>>                 __entry->status =3D status;
>> @@ -1082,9 +1064,7 @@ TRACE_EVENT(xprt_retransmit,
>>         TP_fast_assign(
>>                 struct rpc_task *task =3D rqst->rq_task;
>> =20
>> -               __entry->task_id =3D task->tk_pid;
>> -               __entry->client_id =3D task->tk_client ?
>> -                       task->tk_client->cl_clid : -1;
>> +               SUNRPC_TRACE_TASK_ASSIGN(task);
>>                 __entry->xid =3D be32_to_cpu(rqst->rq_xid);
>>                 __entry->ntrans =3D rqst->rq_ntrans;
>>                 __entry->timeout =3D task->tk_timeout;
>> @@ -1137,14 +1117,7 @@ DECLARE_EVENT_CLASS(xprt_writelock_event,
>>         ),
>> =20
>>         TP_fast_assign(
>> -               if (task) {
>> -                       __entry->task_id =3D task->tk_pid;
>> -                       __entry->client_id =3D task->tk_client ?
>> -                                            task->tk_client->cl_clid
>> : -1;
>> -               } else {
>> -                       __entry->task_id =3D -1;
>> -                       __entry->client_id =3D -1;
>> -               }
>> +               SUNRPC_TRACE_TASK_ASSIGN(task);
>>                 __entry->snd_task_id =3D xprt->snd_task ?
>>                                         xprt->snd_task->tk_pid : -1;
>>         ),
>> @@ -1183,14 +1156,7 @@ DECLARE_EVENT_CLASS(xprt_cong_event,
>>         ),
>> =20
>>         TP_fast_assign(
>> -               if (task) {
>> -                       __entry->task_id =3D task->tk_pid;
>> -                       __entry->client_id =3D task->tk_client ?
>> -                                            task->tk_client->cl_clid
>> : -1;
>> -               } else {
>> -                       __entry->task_id =3D -1;
>> -                       __entry->client_id =3D -1;
>> -               }
>> +               SUNRPC_TRACE_TASK_ASSIGN(task);
>>                 __entry->snd_task_id =3D xprt->snd_task ?
>>                                         xprt->snd_task->tk_pid : -1;
>>                 __entry->cong =3D xprt->cong;
>> @@ -1233,8 +1199,7 @@ TRACE_EVENT(xprt_reserve,
>>         ),
>> =20
>>         TP_fast_assign(
>> -               __entry->task_id =3D rqst->rq_task->tk_pid;
>> -               __entry->client_id =3D rqst->rq_task->tk_client-
>>> cl_clid;
>> +               SUNRPC_TRACE_TASK_ASSIGN(rqst->rq_task);
>>                 __entry->xid =3D be32_to_cpu(rqst->rq_xid);
>>         ),
>> =20
>> @@ -1318,8 +1283,7 @@ TRACE_EVENT(rpcb_getport,
>>         ),
>> =20
>>         TP_fast_assign(
>> -               __entry->task_id =3D task->tk_pid;
>> -               __entry->client_id =3D clnt->cl_clid;
>> +               SUNRPC_TRACE_TASK_ASSIGN(task);
>>                 __entry->program =3D clnt->cl_prog;
>>                 __entry->version =3D clnt->cl_vers;
>>                 __entry->protocol =3D task->tk_xprt->prot;
>> @@ -1352,8 +1316,7 @@ TRACE_EVENT(rpcb_setport,
>>         ),
>> =20
>>         TP_fast_assign(
>> -               __entry->task_id =3D task->tk_pid;
>> -               __entry->client_id =3D task->tk_client->cl_clid;
>> +               SUNRPC_TRACE_TASK_ASSIGN(task);
>>                 __entry->status =3D status;
>>                 __entry->port =3D port;
>>         ),
>> diff --git a/include/trace/events/sunrpc_base.h
>> b/include/trace/events/sunrpc_base.h
>> index 588557d07ea8..2cbed4a9a63a 100644
>> --- a/include/trace/events/sunrpc_base.h
>> +++ b/include/trace/events/sunrpc_base.h
>> @@ -10,6 +10,21 @@
>> =20
>>  #include <linux/tracepoint.h>
>> =20
>> +#define SUNRPC_TRACE_PID_SPECIAL       (-1)
>> +
>> +#define SUNRPC_TRACE_TASK_ASSIGN(t) \
>> +       do { \
>> +               if ((t) !=3D NULL) { \
>> +                       __entry->task_id =3D (t)->tk_pid; \
>> +                       __entry->client_id =3D (t)->tk_client ? \
>> +                                            (t)->tk_client->cl_clid
>> : \
>> +                                          =20
>> SUNRPC_TRACE_PID_SPECIAL; \
>> +               } else { \
>> +                       __entry->task_id =3D SUNRPC_TRACE_PID_SPECIAL;
>> \
>> +                       __entry->client_id =3D
>> SUNRPC_TRACE_PID_SPECIAL; \
>> +               } \
>> +       } while (0);
>> +
>>  #define SUNRPC_TRACE_PID_SPECIFIER     "%08x"
>>  #define SUNRPC_TRACE_CLID_SPECIFIER    "%08x"
>>  #define SUNRPC_TRACE_TASK_SPECIFIER \
>>=20
>=20
> --=20
> Trond Myklebust
> Linux NFS client maintainer, Hammerspace
> trond.myklebust@hammerspace.com

--
Chuck Lever



