Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 838EE350755
	for <lists+linux-nfs@lfdr.de>; Wed, 31 Mar 2021 21:23:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235919AbhCaTWp (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 31 Mar 2021 15:22:45 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:42372 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236243AbhCaTWQ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 31 Mar 2021 15:22:16 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12VJKMZ7065877;
        Wed, 31 Mar 2021 19:22:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=udqhHThNT2uGpmxgH0XAlX781lflQYYSjhEF6ji89Dw=;
 b=heh/iMfodSW6sIUba9a4rL7YUuajlGqbRbw/rAMOz180v/Eq5TXpgKVporQj4L57Af5T
 03ZRTDgYYy+vAdouL4qJq29Bh6aIsPq2bfQNfXOB71bujnXAcKM2ct6yFqPj9/0Z85Wj
 EFRANESH3d6uWRRBQJBWml1Y40Wo5/1mNSzHkNK+YLQhIDG0pbTQITWkkymbAYs1MpXV
 W/Lvb2T1ilzmLMDvwMuJV8CH6HICdIUiONag7/fIYL3g66Um4yxXUYlW94L2Vj8evTs/
 zDCbPjF4/85derWAFJ0sy3yw3pkodQxva0AojjPwn/NqKiWogDxlGw3tHqtn9sC86s3O dA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 37mabqud3w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 31 Mar 2021 19:22:08 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12VJLewC033674;
        Wed, 31 Mar 2021 19:22:08 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2174.outbound.protection.outlook.com [104.47.57.174])
        by aserp3030.oracle.com with ESMTP id 37mabpsw0a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 31 Mar 2021 19:22:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W4XCOHntGsg6x1StoqR+d+duxrS0JS4w0jTS777VEVsdRLqt+lRelzZAmZ8wPOfLC/8tJEyjAb8tBrIoQRPTdFYsFWxSP1R7LQG/+/5wnapoBXFzsGE5hfTa/14ZCu5A4gbO2SSdKHlaP36WXLbxWkROAl6++FVkgUKorpZVNyKLIWZCVYEqj9A4gsxJS0ZNHHJNHe1iztWjFcNPAK4fR+UN9H/3SR/W/xWBFRqVK5QPkDeIjsOAhZtleJQN7UtG2eHg0/RimJRrck4yJbqwceYjX776uLDA9/aYrjo6/r4hQkQLH3qREpsC5JJ4CASioC5IHgUo8Z7rPfb/hjWqCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=udqhHThNT2uGpmxgH0XAlX781lflQYYSjhEF6ji89Dw=;
 b=ZN1tIBd4xzjqWWDA1mLHDp4sVceix0aU/BYNbr4YUg4GMRN2DP3Th27/GGohFFaC2TNa4r3yPDwpj7BKjxn6xi2CpxQ/ZeWA2AOKSM2N06uTwnOIemh5nHEjdwvjZ8I69qfeRiTgarY9xAfkZB2l4GpvRCgtzE1uP2A2eWtO/V51oU8Wy8zEoHCZRip51sPJ7H0NkX2qQqdnsYUIh9a4GttdmPhs19jlCxejC2XC8NFOfo7nwgRQ2Q5AemIMgXuIpSxUfsQoraOK84pfSbOdYyeCNMybNwCI8LLrJTUWvdpEeX+9wNfoejc4MUiQ9d05W6sn9QidrEM8tJU9DC+GWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=udqhHThNT2uGpmxgH0XAlX781lflQYYSjhEF6ji89Dw=;
 b=eSZxwNhTLrURActpDhCfwYSe8JwX7y/lcZeeErbGElBSWFGITh/Op+82Zgn+3eSbG9DiSSn2AdOFh5XQ0ZIIPvKuxKoAvymHrwvUXBT1isCN3vYnnGZIyk3gDQtC+BxO8Qhx10mGFK1UerB1BpgXTM/vdYAU53Z0znsyhxdeJ/I=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by SJ0PR10MB4637.namprd10.prod.outlook.com (2603:10b6:a03:2d6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.25; Wed, 31 Mar
 2021 19:22:06 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::50bf:7319:321c:96c9]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::50bf:7319:321c:96c9%4]) with mapi id 15.20.3977.033; Wed, 31 Mar 2021
 19:22:06 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Trond Myklebust <trondmy@hammerspace.com>
CC:     Anna Schumaker <anna.schumaker@netapp.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 2/3] SUNRPC: Fix trace_xprt_transmit_queued()
Thread-Topic: [PATCH 2/3] SUNRPC: Fix trace_xprt_transmit_queued()
Thread-Index: AQHXJlKTbuswqbxABU2Pk6VPhCi4j6qeYJoAgAAZBgA=
Date:   Wed, 31 Mar 2021 19:22:06 +0000
Message-ID: <DA345B72-D2B5-44E0-83A8-CD641274BE9B@oracle.com>
References: <161721133412.515091.3634995666026759187.stgit@manet.1015granger.net>
 <161721134086.515091.16531400209127881709.stgit@manet.1015granger.net>
 <0901650f31a528a21eb6962bdc13698bfff7bd50.camel@hammerspace.com>
In-Reply-To: <0901650f31a528a21eb6962bdc13698bfff7bd50.camel@hammerspace.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: hammerspace.com; dkim=none (message not signed)
 header.d=none;hammerspace.com; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [68.61.232.219]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 96621241-b9ad-49b5-a63d-08d8f47a45e1
x-ms-traffictypediagnostic: SJ0PR10MB4637:
x-microsoft-antispam-prvs: <SJ0PR10MB4637BB8AF878DF64CA2FD6FD937C9@SJ0PR10MB4637.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:241;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lsw96j/PZHGKheu7mLLPpTUmpoVBa8meGYkLn+BBTwjGUQsMXvpUSlRt+LpRUKfc6LtbMxGFDYYwnCbQSifz06ZhrIUjwO56Y+I6L/zEZ9/qGepv7Q5bU1KGBXFjcJT0TkoBlrbYl+3Zfx28u7rSulo880CNcCTSYYxkOUl1ht5N0DF0d5V3Esq79iL6wiCKncEXLcw0qzTuAahlQW8VM5FqBiRmE6JhPCZJxWJ0pV9ukXkWpi6Dzw6WmM7yhnDxeDmjUxkB3/fQfFwDpC/ntdpraFZ28Z3uolzOufaHBeVsm0FhrL2st1BUEhgAv7dHAtqyG1jQCTTx9RKBpkswVMHTYZZfc6jhqmpBT/8Od1ZdNunyFfa6BMnM5pkKGt2NJT8pM6dU2P227MJ7CGC/wYdPshXcsjyWDS1T9GNQYC/HDK5at/L0PZJWK3wNWHjHQ+KcA5P0JmzpSS17kycgw1dnG82okxBYqrfoCSr2l7lAwtzOtmZq+Ued3qGe4V7QlqUj994o79Ompy0etbFx+YBELOyUiasibTAyTjy54tFfuiAQPIx0KJD9ZCCvOMhpfjwzT6TMGZkxzydLyvZUgEIGjKPJPWSieoQSIZQnvVqK1ePEWF5SY5A9awze17pKgeEWpnb2bvwtJh4ry5szUkv/lROMz2JEAmVVm6uVcdSs5o/TnbtDX46C10RaQ8Oy
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(346002)(376002)(39860400002)(366004)(396003)(36756003)(316002)(53546011)(6506007)(66446008)(6512007)(26005)(66476007)(66556008)(2616005)(6916009)(6486002)(8676002)(54906003)(2906002)(8936002)(33656002)(5660300002)(478600001)(76116006)(38100700001)(86362001)(66946007)(83380400001)(71200400001)(186003)(91956017)(64756008)(4326008)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?no6r1SrjcpiRXCNYof7VkWBtttSDaBvFiucAyxjghL+81ZzJNb325WbxoUVa?=
 =?us-ascii?Q?OpcsnkE2Qjh5qsIKrNYOw0KpGY4bsksNeNCFzRZk/j1xtzKmGQmmy/uASAi7?=
 =?us-ascii?Q?SropSz7SYQaWr2Jc5SrUEmk/4e6I9tDbbVa49hDKSBTI4tNqtc53qp39bNza?=
 =?us-ascii?Q?LeN+K09DDcFDbS6uSFBGvCUG0X8TZ4bRohPmgQgrhQ2uqQJTGJbyKk7bgA7L?=
 =?us-ascii?Q?axTed63DyRBa5IHXH8pEzGEwHblcI9Kc4wgqecm6FDIvi7SclrtiOHffDBUO?=
 =?us-ascii?Q?HqnPngncwz6FoSPXH0SRV3JhHi2b3bpB6WbKlTFItSmqs2RP+cQvWgfPbnkW?=
 =?us-ascii?Q?slUGnatmM9UkVFBzBxtXJJ3mqAYMW02VkcVmgNRpyNEmstfhmqU+U74acpOw?=
 =?us-ascii?Q?YOQB6830NaE8BiCVSWZrpVhpC7rpGh9fKZ3E8m8jld11L0cLifXOkVNp9LXM?=
 =?us-ascii?Q?TrFgH7uYCtF9BYcrCFfmDNKBLgjEoRijnghyHMHdqxaud1gSyIrMeVuGd+FF?=
 =?us-ascii?Q?OkpMyEKfcALjZgN3y4AfaXiAYN52sjvInchpcjE/y0d8YGr54Bek1uVyQyN9?=
 =?us-ascii?Q?EXj5wJ2Rkq+sxEJr1jy8ezAtl9f825Yzii7QcEbfy3w4MLpBenSOguCYN+yi?=
 =?us-ascii?Q?ObFmiNv5IeBWMp4D+L+EDlcobTSWqrSQCOZzttKaysQce2alAxNj/LidbKeu?=
 =?us-ascii?Q?Yh1j0uwUMkXezzXO2jYN70kjUPiEo1A0oN0TzU+lZiEDb47l1Q09pxVG/TR0?=
 =?us-ascii?Q?4xnCyS+zU0rFvfczyr5nyxz1naFr1gBz4GxUmNTwTSWkg/PVoG45XD+C03/s?=
 =?us-ascii?Q?zuAh0RfHVCnbtbpKxP4JkA8KEehYVKfYRaKrtP3QR3Jtif8NHnBZAbpoTlps?=
 =?us-ascii?Q?PdB+TYBiCjJJ9WbL2eJT+LIHOwkZfQgX4Kdk6s2yHUIQ93sNXuCchIJp5/7G?=
 =?us-ascii?Q?cjBpcwsY0K77w5cBwAVlRUq93s9Lnso7lD+NbjDXQKkFeTpsGV+mJze1wzYa?=
 =?us-ascii?Q?USOATigEVFax8yv3G3lGshjw3aFkhFVQbFkv43Y0SawGbGQJiWrhCL3+vlbr?=
 =?us-ascii?Q?7grMiA78FVrXp87gC1LNPQCOrz1vZ+xTVUNNFfDQ/8G/scSEItr9pVvKGcLo?=
 =?us-ascii?Q?16BjEWGCw/X9esqrbWVEOU6vyXQ0DknB9Ys4kR+/mKAVecI3jq9tc/AYbpA+?=
 =?us-ascii?Q?KB4Yamw6iCUnFR9KBtpfiErKaE4PEMvGgQL+upoetpDNwk5wpeB/QlGCSrpO?=
 =?us-ascii?Q?Jyr0Siyv9mUelTJgaOlmbFLlwK7Va/Z/EeEIrFD+EkRTOzjH+4k+780K7yqh?=
 =?us-ascii?Q?kSvc4lNZMn208tAjdSxY9fNk?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <62C7C016EE1B424690DF6E0541BD216B@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96621241-b9ad-49b5-a63d-08d8f47a45e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2021 19:22:06.7214
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DIx30PBe/qIBSQovCyQbK8C+2E8RhHgU9s+oAZI5cwG85MZwSa1EsTDEuDoVzF+ld4rukgkVlM4rA6CExhoioQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4637
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9940 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 malwarescore=0 mlxlogscore=999 adultscore=0 spamscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2103300000 definitions=main-2103310132
X-Proofpoint-ORIG-GUID: ZZtVj1MMeuvI_HqcrYvEtiD2bXL8-dVH
X-Proofpoint-GUID: ZZtVj1MMeuvI_HqcrYvEtiD2bXL8-dVH
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9940 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 suspectscore=0 adultscore=0 mlxscore=0
 bulkscore=0 spamscore=0 clxscore=1015 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103300000
 definitions=main-2103310132
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Mar 31, 2021, at 1:52 PM, Trond Myklebust <trondmy@hammerspace.com> wr=
ote:
>=20
> On Wed, 2021-03-31 at 13:22 -0400, Chuck Lever wrote:
>> This tracepoint can crash when dereferencing snd_task because
>> when some transports connect, they put a cookie in that field
>> instead of a pointer to an rpc_task.
>>=20
>> BUG: KASAN: use-after-free in
>> trace_event_raw_event_xprt_writelock_event+0x141/0x18e [sunrpc]
>> Read of size 2 at addr ffff8881a83bd3a0 by task git/331872
>>=20
>> CPU: 11 PID: 331872 Comm: git Tainted: G S                5.12.0-rc2-
>> 00007-g3ab6e585a7f9 #1453
>> Hardware name: Supermicro SYS-6028R-T/X10DRi, BIOS 1.1a 10/16/2015
>> Call Trace:
>>  dump_stack+0x9c/0xcf
>>  print_address_description.constprop.0+0x18/0x239
>>  kasan_report+0x174/0x1b0
>>  trace_event_raw_event_xprt_writelock_event+0x141/0x18e [sunrpc]
>>  xprt_prepare_transmit+0x8e/0xc1 [sunrpc]
>>  call_transmit+0x4d/0xc6 [sunrpc]
>>=20
>> Fixes: 9ce07ae5eb1d ("SUNRPC: Replace dprintk() call site in
>> xprt_prepare_transmit")
>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>> ---
>>  include/trace/events/sunrpc.h |   35
>> ++++++++++++++++++++++++++++++++++-
>>  net/sunrpc/xprt.c             |    2 +-
>>  2 files changed, 35 insertions(+), 2 deletions(-)
>>=20
>> diff --git a/include/trace/events/sunrpc.h
>> b/include/trace/events/sunrpc.h
>> index 036eb1f5c133..690988530d60 100644
>> --- a/include/trace/events/sunrpc.h
>> +++ b/include/trace/events/sunrpc.h
>> @@ -1141,7 +1141,40 @@ DECLARE_EVENT_CLASS(xprt_writelock_event,
>> =20
>>  DEFINE_WRITELOCK_EVENT(reserve_xprt);
>>  DEFINE_WRITELOCK_EVENT(release_xprt);
>> -DEFINE_WRITELOCK_EVENT(transmit_queued);
>> +
>> +TRACE_EVENT(xprt_transmit_queued,
>> +       TP_PROTO(
>> +               const struct rpc_task *task
>> +       ),
>> +
>> +       TP_ARGS(task),
>> +
>> +       TP_STRUCT__entry(
>> +               __field(unsigned int, task_id)
>> +               __field(unsigned int, client_id)
>> +               __field(unsigned long, runstate)
>> +               __field(u32, xid)
>> +               __field(int, status)
>> +               __field(unsigned short, flags)
>> +       ),
>> +
>> +       TP_fast_assign(
>> +               __entry->task_id =3D task->tk_pid;
>> +               __entry->client_id =3D
>> +                       task->tk_client ? task->tk_client->cl_clid :
>> -1;
>> +               __entry->runstate =3D task->tk_runstate;
>> +               __entry->xid =3D be32_to_cpu(task->tk_rqstp->rq_xid);
>> +               __entry->status =3D task->tk_status;
>> +               __entry->flags =3D task->tk_flags;
>> +       ),
>> +
>> +       TP_printk("task:%u@%u xid=3D0x%08x flags=3D%s runstate=3D%s
>> status=3D%d",
>> +               __entry->task_id, __entry->client_id, __entry->xid,
>> +               rpc_show_task_flags(__entry->flags),
>> +               rpc_show_runstate(__entry->runstate),
>> +               __entry->status
>> +       )
>> +);
>> =20
>>  DECLARE_EVENT_CLASS(xprt_cong_event,
>>         TP_PROTO(
>> diff --git a/net/sunrpc/xprt.c b/net/sunrpc/xprt.c
>> index d616b93751d8..b694af4504c4 100644
>> --- a/net/sunrpc/xprt.c
>> +++ b/net/sunrpc/xprt.c
>> @@ -1469,7 +1469,7 @@ bool xprt_prepare_transmit(struct rpc_task
>> *task)
>>         struct rpc_xprt *xprt =3D req->rq_xprt;
>> =20
>>         if (!xprt_lock_write(xprt, task)) {
>> -               trace_xprt_transmit_queued(xprt, task);
>> +               trace_xprt_transmit_queued(task);
>=20
> Why do we need this tracepoint? The event we're logging is just
> "grabbing the transport write lock failed due to external
> circumstances".

This tracepoint records the decision to queue rather than send immediately.

You can count the number of these to get an idea whether the transport
is backed up.

You can trigger on this event if you want to capture the events that
lead up to queuing a request.

You can see whether the client logic is making the right choice when
congestion control is in play.


>>                 /* Race breaker: someone may have transmitted us */
>>                 if (!test_bit(RPC_TASK_NEED_XMIT, &task-
>>> tk_runstate))
>>=20
>>=20
>=20
> --=20
> Trond Myklebust
> Linux NFS client maintainer, Hammerspace
> trond.myklebust@hammerspace.com

--
Chuck Lever



