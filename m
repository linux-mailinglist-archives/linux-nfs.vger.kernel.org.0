Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 756A057E6CF
	for <lists+linux-nfs@lfdr.de>; Fri, 22 Jul 2022 20:45:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236095AbiGVSpk (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 22 Jul 2022 14:45:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235789AbiGVSpj (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 22 Jul 2022 14:45:39 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61708126
        for <linux-nfs@vger.kernel.org>; Fri, 22 Jul 2022 11:45:38 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26MIYMqG030540;
        Fri, 22 Jul 2022 18:45:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=hZgTRHnIc4oMNc8koQ823sgPbXKZHGnfT3egNYX7h7k=;
 b=WWXtqZf7ZbYL+3SmRJRJyKcHjQJKI1f7AKZBLymRrRWNXgaY2Un6EjBmOZrCgyakyyjI
 Q/xSulGgyY9yueIU+vWYOT6/MAswfVIr8XhSVrlth2nVmAGrVRSuA6tGxzHA5UMid7X8
 OSyM3TcJt14f458fsrBkcbV6eWZym/vGH95dr5El4/F7Q94SC+s4p0ToAa4DaFaDRZ/M
 r07VVl2PTHnKHvCidvH6A07KhCi2bcPhtE63XmhuG6Zde9dk+LZZz/zsmdoVL/8P2NCn
 ojJx7nCtOlWWTh+X0mr6kgFQ0qYc3F4oTLv3Qmsq/JlYE9vUjeQeUXKykI0urxzicAJw Vw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbm42rb90-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Jul 2022 18:45:33 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26MG0ghB022216;
        Fri, 22 Jul 2022 18:45:33 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2177.outbound.protection.outlook.com [104.47.55.177])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1hveu0f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Jul 2022 18:45:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KdYlSCE1dLFFw1QPaZSVPcQ2v53Yi5LigFecjiZhhoUkWx6P5XII1JiHbfVk6FIuCQIcM3lMEfwo3ZwieDXhxF/KW1+NAYvQZ1zNvBoPI6q0BiBW2KF7s24LBKmfwu7uRGE0vmI3JwglOnlbJyes4u99GW3jf2H/cVMZxZlBHpu7ZD8cAXBXiqOBheu5u0PmQPgbPoI3dA+GTPgyERmpq24cE5msmNYuJhEsV3onAVbF2OSTULiIMx22ohg+9nDc3KpviPlbWgMj/HEIbDfWOn5pi7eKBFcfFGSXz1kDkn73X5zFluiWoTVc+psSReqfS7XJkqBzm6KkYd7JvjqdPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hZgTRHnIc4oMNc8koQ823sgPbXKZHGnfT3egNYX7h7k=;
 b=LLr9L+HlwK1nj/ezTgHr70jbdJuEjNIZpXQr5/UkOpXr26XTocnZOQ0LOJ249MwnvWUX6tTMIAQhBJ1hCNoO3dlgT9/fNAXBRI++ywODzMpTJ4KMWNMEhxvayvBU/4uB/4e+C6fUiOpZPSCRzYDMOzYACizutfvUA7t7JWrVueRr1+tfWQVhw+9D6ZRnvTkYDApg5roP/yMxagqdlylMSGVIH+GrfH18Ie3rssF5FcmWwV4xsB2qnErP3yK+MfKuOFO1rPJ79GSUJAqNa7ok11USWO2bfS4IHPwglXMcxUGp1817lPft0I7bv/PqetMD6dOSArqd9x06r8/nICz6Bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hZgTRHnIc4oMNc8koQ823sgPbXKZHGnfT3egNYX7h7k=;
 b=D5jGzWqw4fstm1K7v+3iiyDRRTDByLN24rHQl2KlKxX2SumQPReh/nETxIMdedSY1JaTL2JyG89f9XkvNxo93RXfxNgzOpt2tbLUy3Ho3cwZ7gjo2MPfXwzJYg7cdKVNzAQB5f7vTUlVnnmaBiqzr3TyK6skUK/JMjbCca1BtFk=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SN6PR10MB3085.namprd10.prod.outlook.com (2603:10b6:805:da::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19; Fri, 22 Jul
 2022 18:45:31 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::8cc6:21c7:b3e7:5da6]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::8cc6:21c7:b3e7:5da6%8]) with mapi id 15.20.5458.019; Fri, 22 Jul 2022
 18:45:31 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Trond Myklebust <trondmy@hammerspace.com>,
        Steven Rostedt <rostedt@goodmis.org>
CC:     Anna Schumaker <anna.schumaker@netapp.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 3/4] SUNRPC: Replace dprintk() call site in xs_data_ready
Thread-Topic: [PATCH 3/4] SUNRPC: Replace dprintk() call site in xs_data_ready
Thread-Index: AQHYnfAc0ThJHE6uP0y4xqAY38e1va2KrciAgAAMxgA=
Date:   Fri, 22 Jul 2022 18:45:30 +0000
Message-ID: <9FDA46D8-4D6E-49B0-A583-D0FF739111BF@oracle.com>
References: <165851065336.361126.17865870911497306083.stgit@morisot.1015granger.net>
 <165851074247.361126.17205394769981595871.stgit@morisot.1015granger.net>
 <66371b9db4210fe853e98a8ec68b0f780ba886af.camel@hammerspace.com>
In-Reply-To: <66371b9db4210fe853e98a8ec68b0f780ba886af.camel@hammerspace.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.100.31)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d1f28525-4e67-47e4-1469-08da6c125a7a
x-ms-traffictypediagnostic: SN6PR10MB3085:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: i4AjQD1KTZIUygSUMXKyrvFdtQSE7lulBjODW7J0pqNbwqT6mkGmJXQwJCzuHhXG4qhCdiii4IS31zIRiLynqNKFoGhcxNG5bYNWCkLUdf0G4aFilP/5pw/F2+F5aJHrItR5fAeAQfxZoEcMpIT9I0/JcH6SatS6UWfMQEoIRim13Ny7arLSm2mDnMiPV+Bnq0D+grTslTgNIOAXiOvOV9g6k/5zMoBYmVs+yzgvQVCtHBx0tST9h1KxDDC2p170+evz4YAkqTaNvLBayd7gvS1awxr+MMme6OPjBRZYcxHsceW37+Sxa95v0v8AqukoTucb03NAYtRG5LiLMxzaTUVm2dM5elaMHhXlbMaO6ivXJtj54HC+DCZVsGgL6w1QC84Ya4gW4OOe5lb8O7+269kW791CrC9YxjIXrY3DKsnjJ7OLnWRiPSWRlwHbiBpi9Nme7+CZskDGB3UqrJTSHq3BQ4khcUs4qKGTtzfra6hW2psufscb9BliY72mDYm52ipz2SuvOQdqp/mR38hGIUZxWGDJuTVj9x+KD4sYHofTdgEyTZ71BLx6DkcNxyBp8y535TRDPZRvMwe1bh1C6D4am4hMu7nWYbYL6MM/oYuUq+q3v4VjCPsfGAq/pJyCZgYbmrdjvoNLC5TcPo9jFSO0Yy9AhIe8DH1gtIxHeBgRubcgCSq5tSdjRwPaeVe0czykjddaR99r7nGpqqi45O1uWMPP4WU4e+NjElJsUCBogAo2UPqmO5JWnZlYv6M35RUol0nMxZaLwO407gXcAnGkMvyK45EdqMQ3IvP/7hy6B1MNIiWOdrqFSrWqhbgFTWylagIDlvY/eyZi96Yy8Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(366004)(136003)(39860400002)(376002)(346002)(6512007)(41300700001)(71200400001)(36756003)(6486002)(478600001)(26005)(2616005)(83380400001)(53546011)(6506007)(316002)(38070700005)(8936002)(86362001)(5660300002)(2906002)(110136005)(54906003)(33656002)(76116006)(186003)(91956017)(66476007)(66556008)(4326008)(66446008)(66946007)(64756008)(122000001)(8676002)(38100700002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?gJmHpZ3jk088JMof3DcfOh3rQAhIBHsFzh2u4Fgxb+oKkOuudjX7pkhHiGfC?=
 =?us-ascii?Q?+UtHrYuBrY5kLhtfE5/GWz8QdPqAE2VVZUNHDrpyKksZeqd1CaLYN3wh3rIa?=
 =?us-ascii?Q?ZP6/Vxq1Bef12rS/2+PiXueO+kWRS3Gc+SwxOoNFEorLn+HtK768l5IIxbRb?=
 =?us-ascii?Q?yGGObq+lyKaiEnnDt7Ir1x5Dl2t02+oK7MAfKetaMX3xHuiGlWIoLfx3ui2s?=
 =?us-ascii?Q?DA+ZNa2UqDNG2E1IJWi5NUKXNb1UCujKAPlMNjbf+eGuLBC7rOTmwpItP/gA?=
 =?us-ascii?Q?u5x5v/RRDCK6dILHsGZvqYlYgph4noi/kJ2SqeFjyYCyBU4OaCb+Z/3LZ3HW?=
 =?us-ascii?Q?8jL4CT+WPeeE4F1h1UeQiCgfJm4Qzlv8BQ+qYXHQetJ2U9mnwpAj6HvCzxOe?=
 =?us-ascii?Q?KVMYxbCYbQnDUZvqnx8NFB2hLJGjk8L+P+J8PTOVltbwp9obQp4z5kOXhQ0t?=
 =?us-ascii?Q?yj13p7o6LzdLca8K9bBwaFWYQhy1hWwIap5hI5F3EOQDPev7sKRbrZ7e0CEu?=
 =?us-ascii?Q?qFC5sy/+QcuDqdD9iwMjp4VyvL2wPdErZyZlNsg+p/w6FCeuJklCYEImEX7b?=
 =?us-ascii?Q?Fb2xUlJPwpVFWy14f3al3zY829oKjqQk64WoY7venuCMIIngnNWRSBVLwsAF?=
 =?us-ascii?Q?WAgFdcQL4mguCHgPD5C+jRI++zPIWhWOaQKyfs/k/S4zeR8bnrEv5wrck/LE?=
 =?us-ascii?Q?mMK0FsHpIRACQkLnFipm33ni1YEvVtWnz/BADi42Q7PnRbkDftLhuHA1U+/z?=
 =?us-ascii?Q?G6Bvn3ws/UiuZQvARlIvB4a+fRoYRmliuoyhlwbM9cpeMLNlU83cpdXzaA9S?=
 =?us-ascii?Q?Nce9x7kZuec3XoIFPuKUULVDcPYQYkHJfQ+Non2jkIEhFfDq4IQio16en+9z?=
 =?us-ascii?Q?hnaus48rBTZrYeGRu8PDpToGiQY4NI3kNtagqsZIeAOlCMWDyNsl8HfR8ixH?=
 =?us-ascii?Q?9Lu9oFKC/YdYpFuq0Q/EGuy9ULING1/5lt7re17AlSdcYUGul+XZK+rYM2EK?=
 =?us-ascii?Q?T/k5jnYybsYUb+xHyW/Uaa4oTZ4iNcuEJ59vnUqK3nFpC9cjxBPB9EclneEe?=
 =?us-ascii?Q?Kn2aK/vjW33xZmlneo6tE1fkmF1l4fiaoeDHN+LdNL84h9ohSt4pDv1V6wBH?=
 =?us-ascii?Q?v/+Di8h3ULNiZbrbkv7vH302fUgMviGoIzz2KmCKTHqG8FZTOqsCadBKf+EJ?=
 =?us-ascii?Q?6AJAuvhptVrA6U2RhtDntoaSotSphpmKg7ndasCmeXOkYMCvSCXhwO41F6MW?=
 =?us-ascii?Q?fiLuIRWvIiskdkUgecpbg5OLAXxIaipuWIeFx1U8td+EXpTiwdRc6mOfeuUT?=
 =?us-ascii?Q?5ux2WHyRuHfem44yCdluLCKikw2BTPo6cGrp/M28uYjP0s0E1KXIBN5/+Foe?=
 =?us-ascii?Q?1jdcDX8e679liaanfSDNKCr9wgPDqR39h0AW8cl5zK+DrXpzDcJSsFVwKm6j?=
 =?us-ascii?Q?CBDqX3oZQ5mpF6oouN3e5ox72cR0Uo8nDyVgUPCCdl1E8/6cj3YcCCnJqWMz?=
 =?us-ascii?Q?SW60UF0ijbL82vtl7K4lEFBhDKrByEt4hctsU1HuH3DD6dmP/kDllzsD/mKG?=
 =?us-ascii?Q?YMUJ25uS5TkveNDh2Jjz8f6rhFDlktnSzV8Z/vMrLmCKhUU3OtGTQmokDVhJ?=
 =?us-ascii?Q?0Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <20D9EA7F31DEAF4E803E53CB848B4686@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1f28525-4e67-47e4-1469-08da6c125a7a
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2022 18:45:30.9195
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: stZPWibvSByaLsKD1xmg3UJLsC0ypzbggtQG6IgHHZXu06wWc/wXmkNi3tVXl9KCD96OXv5CoTrQscPsydzsIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB3085
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-22_06,2022-07-21_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 phishscore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207220077
X-Proofpoint-ORIG-GUID: mlYHFUMpxWt8HhYmaM4xo99SLxUL8kCT
X-Proofpoint-GUID: mlYHFUMpxWt8HhYmaM4xo99SLxUL8kCT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jul 22, 2022, at 1:59 PM, Trond Myklebust <trondmy@hammerspace.com> wr=
ote:
>=20
> On Fri, 2022-07-22 at 13:25 -0400, Chuck Lever wrote:
>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>> ---
>> include/trace/events/sunrpc.h |  18 ++++++++++++++++++
>> net/sunrpc/xprtsock.c  |  6 ++++--
>> 2 files changed, 22 insertions(+), 2 deletions(-)
>>=20
>> diff --git a/include/trace/events/sunrpc.h
>> b/include/trace/events/sunrpc.h
>> index b61d9c90fa26..04b6903b6c0c 100644
>> --- a/include/trace/events/sunrpc.h
>> +++ b/include/trace/events/sunrpc.h
>> @@ -1266,6 +1266,24 @@ TRACE_EVENT(xprt_reserve,
>> )
>> );
>>=20
>> +TRACE_EVENT(xs_data_ready,
>> +  TP_PROTO(
>> +  const struct rpc_xprt *xprt
>> +  ),
>> +
>> +  TP_ARGS(xprt),
>> +
>> +  TP_STRUCT__entry(
>> +  __sockaddr(addr, xprt->addrlen)
>> +  ),
>> +
>> +  TP_fast_assign(
>> +  __assign_sockaddr(addr, &xprt->addr, xprt->addrlen);
>> +  ),
>> +
>> +  TP_printk("peer=3D%pISpc", __get_sockaddr(addr))
>=20
> NACK. Please resolve and store the string up front instead of storing
> the sockaddr. Most versions of perf can't resolve those kernel-specific
> %p printks and just end up barfing on them.

Interesting. We added get_sockaddr() to avoid this issue in
trace-cmd. Sounds like perf needs to be fixed up too, or
maybe this is another case of having an old libtraceevent?

Meanwhile, I can revert this back to the old way of handling
presentation addresses.


>> +);
>> +
>> TRACE_EVENT(xs_stream_read_data,
>> TP_PROTO(struct rpc_xprt *xprt, ssize_t err, size_t total),
>>=20
>> diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
>> index fcdd0fca408e..eba1be9984f8 100644
>> --- a/net/sunrpc/xprtsock.c
>> +++ b/net/sunrpc/xprtsock.c
>> @@ -1378,7 +1378,7 @@ static void xs_udp_data_receive_workfn(struct
>> work_struct *work)
>> }
>>=20
>> /**
>> - * xs_data_ready - "data ready" callback for UDP sockets
>> + * xs_data_ready - "data ready" callback for sockets
>> * @sk: socket with data to read
>> *
>> */
>> @@ -1386,11 +1386,13 @@ static void xs_data_ready(struct sock *sk)
>> {
>> struct rpc_xprt *xprt;
>>=20
>> -  dprintk("RPC:  xs_data_ready...\n");
>> xprt =3D xprt_from_sock(sk);
>> if (xprt !=3D NULL) {
>> struct sock_xprt *transport =3D container_of(xprt,
>> struct sock_xprt, xprt);
>> +
>> +  trace_xs_data_ready(xprt);
>> +
>> transport->old_data_ready(sk);
>> /* Any data means we had a useful conversation, so
>> * then we don't need to delay the next reconnect
>>=20
>>=20
>=20
> --=20
> Trond Myklebust
> Linux NFS client maintainer, Hammerspace
> trond.myklebust@hammerspace.com

--
Chuck Lever



