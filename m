Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C31583F1A29
	for <lists+linux-nfs@lfdr.de>; Thu, 19 Aug 2021 15:16:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234695AbhHSNRC (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 19 Aug 2021 09:17:02 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:5916 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239864AbhHSNQx (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 19 Aug 2021 09:16:53 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17JDB9an004849;
        Thu, 19 Aug 2021 13:16:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=z1IsUd1me/Y7QpBQ9SCcrWfD+5NJIiMtIFFHAS8gtB8=;
 b=0ODHTUqDS553aljqXvFd2Mh3d2SX1DafEaZpiuGgfObVX1LsN3YvQixxVGnEN/id/s1w
 J8r6v+hfnXD4NSB6UHvy1Ea1wCAYMY6Mj8kxBEyHtnJMExyF/CXsxZF6XmMk6zkIridP
 uJ1leSOVjyW5+MQCYMTWN1AUXGq4OPKswEv+2klYllSYz5PGLaOnJAP629/FKmoUvO+r
 r8g2OhKB3jr3vU9KLkRiGAJe9svJOc3X12HEw0g5EL8D7itp/fvnJBXsKQqVcbTj0uVa
 h5u6N4hRpIFVCqVezVAK+eu1FFuwcp/eTVnbK1mvgIDUJn+Gh/W/KJZ37kqep9+avM+S vw== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=z1IsUd1me/Y7QpBQ9SCcrWfD+5NJIiMtIFFHAS8gtB8=;
 b=r/wy6NZKimhYtVqYm9tqGhonNgYyj3RC+rZ1+6bj0kHq9BXo7dITJc6cRlal7kuBUuQn
 T1O/NgBsSiQP6TdYkI9Tbi8FECb4nqHwe0VLiZnmcndxr/a83zRSeBBK1lRYdO8WAUWZ
 sO4AsimsuQu+TsGwwd3cs3ArOH9e69ZCpwm7X2p0jGrLIrAcE38zCDyrZu/AH/F08M4i
 cI1kCPzLm52+Jg3gfb7oE/cj13803yJ5ZA0VcbuaFie0NAMHr8DvEGOqXBt8DeH980O/
 aW1HvhpWv9xlXc6a3XWCddEM/5kubS4CoZ9lSDz5mzjmli7wtuWryp5y9bT1oEsUGclF UQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3agdnf5r2d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Aug 2021 13:16:14 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17JDBBaV057575;
        Thu, 19 Aug 2021 13:16:12 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2109.outbound.protection.outlook.com [104.47.70.109])
        by userp3030.oracle.com with ESMTP id 3ae2y4c7j5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Aug 2021 13:16:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c1VlhvST4I8UJWMvp7u+gPnbLqwoL97/xb/rzpTCtW6bXgYuiGPLZ9tEKH32uTymiXZcenWNiqycdxpH2aLwFajXLTWt1eEu8v00ONjDNkNSpKu3EyeDJmN37QRpNRc9xqD0f4pphLhSxWDF2W3H1UbCXW44h6Xp7WcC1LrRfd7K/oxq2wAIfAYPh1tW3y+zBsEEaCSjd+FoGQrS0fpWeABQFJaWAi51NOIpBpsV/bwYrMo3vTRVtbaewoKurWvqACQ9if5NUJXYw6RSyexLJsJTpcN0hnkYbiSC/MtNCaVXSd9z03CwBNfO/Q0XUZvDfH6WgpTD50FxW6QsUO8dqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z1IsUd1me/Y7QpBQ9SCcrWfD+5NJIiMtIFFHAS8gtB8=;
 b=BfqZjJFiSsUMjz6Gn1OolvcTi6/qkUTKmJzVGOwO8pHfxEnKXH7M0SnTb9aQwGFhLSwioi+qKYJERIyfHd4XCzCB5dZOzY7cr4MYziyYOmWZKsyXlRkDKZSq45uUmhQ7g56L93GPzohq/TzDRwKqOp8wJxTTAV3Qcp4YaBK3qZiUlO01UCG9VssPzcTH4S25lrW6ThzqAJsgQibE1Rhe0L5rLJX/jyPExzpCTJUqdCOr1/CIEq093c9QpKJYUZVbPCb45YA5g1AJrO0EAuluuMmSn/pZSi8tId8bP3G7FfVYCY6Q3ccxT7m114OlN4Kqj6jppq+wcSC6YoteeSPlNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z1IsUd1me/Y7QpBQ9SCcrWfD+5NJIiMtIFFHAS8gtB8=;
 b=lsitkb33Ih6IGxF9/aHvKLDejdU0DaJH+HuZ8yVQBR1k5TpCRY8C+GKBnQzhGtE4+Ssl5AmJ4kkCVCm/BqKQhSAnDAQW5dD8Ya6LWJ+vn2GRKA5p45FdY6A5bTpou+QXoXmys/lmm0l1xhjDS0DdJOVfWscFaQX+KC7B3mSv7+M=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by SJ0PR10MB4447.namprd10.prod.outlook.com (2603:10b6:a03:2dc::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Thu, 19 Aug
 2021 13:16:09 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::a8db:4fc8:ded5:e64]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::a8db:4fc8:ded5:e64%7]) with mapi id 15.20.4436.019; Thu, 19 Aug 2021
 13:16:09 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Trond Myklebust <trondmy@hammerspace.com>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v1] SUNRPC: Ensure backchannel transports are marked
 connected
Thread-Topic: [PATCH v1] SUNRPC: Ensure backchannel transports are marked
 connected
Thread-Index: AQHXlPXcGICcXaW3sESgYQmy74r7pat6ysSAgAAEDgA=
Date:   Thu, 19 Aug 2021 13:16:09 +0000
Message-ID: <6D4FFB37-B5CB-410B-A3C9-AAC92F611520@oracle.com>
References: <162937592206.2298.13447589794033256951.stgit@klimt.1015granger.net>
 <ed3fbd005a9a2e3a6217085ebe05e80cd78766ba.camel@hammerspace.com>
In-Reply-To: <ed3fbd005a9a2e3a6217085ebe05e80cd78766ba.camel@hammerspace.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: hammerspace.com; dkim=none (message not signed)
 header.d=none;hammerspace.com; dmarc=none action=none header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 511a52c8-5536-4856-a3b1-08d963138291
x-ms-traffictypediagnostic: SJ0PR10MB4447:
x-microsoft-antispam-prvs: <SJ0PR10MB4447E8987F962592D63C951993C09@SJ0PR10MB4447.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7GKknyBjsS6MHYePSOv0ubXQSxrmnwk/mJvjeCNPKn17jOK/FbtCW2RwdBMojGD0lbH8q+QPYZU7paoITH53moaPf21wEfZamUnrtVzOy/YZeTPc683TH7Wj8c2ay9Y88l1G9r43sPglZxgglLKqcwNhr7zY8pHCRNgWu49ZeL35c06+6TmplH+lMY3uQuM91pFu09JBJenzKvRBYKsYe0FhMh2yNOrHI2ssdU3QG7ru5vgDh4pN1toudcGbyU7jW7xKuvNAhK+9srd+2Pr+vIcZghiTnUP3z8a97IndvHOG7URTn9oHvji3I7dB7i2uDZ4Joohc1rAHk61xoi7pwnT/cv82613CJJUorGgb5WCi/UhszxqGrIkl9/BJJULqs/bphUMLJBEG0lDH3BivxvGP0S/kiIEiRM0Jr8BCazlxmZJxHCJrlv/2EWaakaECgblDPKmJX4lwNLCRjK8OCZFwGEIIDvTCCnfOhup7ZHtP7hF8yRi/huSnAvBVN+JRbC0OHn50zKc8quPm3RjfzU7tDV3rZkOI2YrJlLexIBGmjt3wWl7ZyyMwHDiYn1nQ2vmjC4Mp2lcOHirvtmqR+jeys3+iX7IV/jQpQPRe8Csuj3s/WBBzwFbEUMgMuc/kgSgVF+tjav8F3HZERkjG12gdO0/hI+FoSmXKTNkukr6vqMNTUlHQO3HpaHNwZ3kKocOn93DinS8Ibnj5QjkiWC5CSaATAZcAZiFDOgxdXeFAmtj1RSvzkL2XBmaW04Kwr5JYp7pzneNYYBkg9WM4/A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(366004)(396003)(376002)(39860400002)(136003)(76116006)(36756003)(91956017)(66946007)(2906002)(122000001)(38070700005)(71200400001)(86362001)(38100700002)(6916009)(5660300002)(316002)(33656002)(2616005)(8936002)(478600001)(4326008)(6486002)(53546011)(186003)(66446008)(66476007)(66556008)(64756008)(6506007)(26005)(8676002)(6512007)(21314003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Miu1BEVFLh7VfDEgZMcHYqZhyuSNKMADkRSvvvMwqwkhwh/nHM8ci7YEPQiG?=
 =?us-ascii?Q?YAnGerunag0RFTy3M6mD7SwwbJNPt2mz3Sc/xELolWIE2QPVYXE6LuqGWZ//?=
 =?us-ascii?Q?YGGwKrB4PZlysgFJXbubTQXv96EO3B2Q0CujptbXlNW7orBrwD+WKIgidjO3?=
 =?us-ascii?Q?6OQ7unmj1vbpCr//lAOuJ5Jt0lgYMF3GPZmVsQPWx3ZAUxnUUEDLg2F88ZxN?=
 =?us-ascii?Q?NU99flVfHVG6NYLu+gemOw5ZmVxzI/biDffvYPCXNurkiyo6g15SB4TEfKX2?=
 =?us-ascii?Q?AR7RAQOkJWyfJnS6wlyldC5ww6dfUIVnqy73NUhbbo6Tq98X4dvA/HfySMOt?=
 =?us-ascii?Q?SZkaWvpgyu4/zYDvcnyOoZgaYLyODMcExatOek07PV48nJ5Q2BG6mRORTAI0?=
 =?us-ascii?Q?6/ZeQa4Vpcb4T8dFFHKnYQMnCtgY7Ffc0qUfcQRltxAvmLDCo49/2NVsoRJA?=
 =?us-ascii?Q?+El5a7LXuC0t9qnv8zMmUilBff8VrPKJ7WmwHHQ4vjL0hs4gNKDOQ+N1O2Pb?=
 =?us-ascii?Q?SGNp9wsbVqSgLTx/VqXEg8TUCNzStOvOP33Y6BJfEkgLEhz6/G5rv4VkUMm8?=
 =?us-ascii?Q?KPyCJnwf4pu/psHraG/lQ0taaTpynk9JmR95rGXATy1YJAEzmrXdMshsepWs?=
 =?us-ascii?Q?dZrnGvZYV8sHM3J8vNnJNcjQcUSS8u4nReKyfLYYOW1QsgAVz4QKxaue8yHT?=
 =?us-ascii?Q?ZrAvZti3htz8eB5PWRw2jA9tqrc4XX9DgwQkLQCtcCn2lag9dOGxdTD8B3L8?=
 =?us-ascii?Q?YWEWdogR8HBjm4H3fbPrKYgg1NDz7xS0gU3g1mBCleHzAI7TZclLuRpaAQHA?=
 =?us-ascii?Q?aKr7MEvpzO+d3gczJIb/Lo2A2kz/Y0fAfC5vWky5kQqvpwx3IxpGUFlsFMKs?=
 =?us-ascii?Q?NmJ8N8bEaXUL4G2L+t6LMMay2kOcb6Lw0TpLpBQQ0gXQgxG5JgFWqcAsG93D?=
 =?us-ascii?Q?w97EIXxNP7C5G/8da9llIDZVLiuyO/7h/DXo3IYO5ZkDFfx0DEMukcolZOzt?=
 =?us-ascii?Q?mx76yJ/EFXOgReKZbtWZ0+NSIjKXqkgFNXzEpRneqbxRglzXmMFTAJFIuHnQ?=
 =?us-ascii?Q?Dzxl1K7Uy0+r3ef/Q1EKdz3efvR6MFSae4XZm7wIENQ8fhUIgxtHQHMiEkWw?=
 =?us-ascii?Q?Og8mqYOTHcH8i5dcxrwH2PXdQuLZTeDGW3MbrrI2ZuZ2RqabAiMkc3+qFWW8?=
 =?us-ascii?Q?7UUj2zbhWI/C2uaVdr7FYnjUC27uFi+/4UrBrJCjBCbAMNyiQFRKNsYfLBh6?=
 =?us-ascii?Q?VkmMYLKYmxp9LgXnjtTskXKJE+EcHmT53wwmoRBO3B82w1SAkm1/6Ot4PFK2?=
 =?us-ascii?Q?+YYb8moRznVjc2xYMep6msGh?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <6D4BDEF97FFE3E4783D4110614F8D4AE@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 511a52c8-5536-4856-a3b1-08d963138291
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2021 13:16:09.4651
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AumACF6xFf0hPVTCsTYBxwNgNi2ECT0oQh0lnwompQBN1XEqr44cqLJhJkboo3mOEKlydecgeMDcjIcOH4eWRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4447
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10080 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 adultscore=0
 suspectscore=0 phishscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108190077
X-Proofpoint-GUID: hW-LWU2SYns77UQ1igbYHwcwyrBODXVz
X-Proofpoint-ORIG-GUID: hW-LWU2SYns77UQ1igbYHwcwyrBODXVz
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Aug 19, 2021, at 9:01 AM, Trond Myklebust <trondmy@hammerspace.com> wr=
ote:
>=20
> On Thu, 2021-08-19 at 08:29 -0400, Chuck Lever wrote:
>> With NFSv4.1+ on RDMA, backchannel recovery appears not to work.
>>=20
>> xprt_setup_xxx_bc() is invoked by the client's first CREATE_SESSION
>> operation, and it always marks the rpc_clnt's transport as
>> connected.
>>=20
>> On a subsequent CREATE_SESSION, if rpc_create() is called and
>> xpt_bc_xprt is populated, it might not be connected (for instance,
>> if a backchannel fault has occurred). Ensure that code path returns
>> a connected xprt also.
>>=20
>> Reported-by: Timo Rothenpieler <timo@rothenpieler.org>
>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>> ---
>>  net/sunrpc/clnt.c |    1 +
>>  1 file changed, 1 insertion(+)
>>=20
>> diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
>> index 8b4de70e8ead..570480a649a3 100644
>> --- a/net/sunrpc/clnt.c
>> +++ b/net/sunrpc/clnt.c
>> @@ -535,6 +535,7 @@ struct rpc_clnt *rpc_create(struct
>> rpc_create_args *args)
>>                 xprt =3D args->bc_xprt->xpt_bc_xprt;
>>                 if (xprt) {
>>                         xprt_get(xprt);
>> +                       xprt_set_connected(xprt);
>>                         return rpc_create_xprt(args, xprt);
>>                 }
>>         }
>>=20
>>=20
>=20
> No. This is wrong. If the connection got disconnected, then the client
> needs to reconnect and build a new connection altogether. We can't just
> make pretend that the old connection still exists.

The patch description is not clear: the client has not disconnected.
The forward channel is functioning properly, and the server has set
SEQ4_STATUS_BACKCHANNEL_FAULT.

To recover, the client sends a DESTROY_SESSION / CREATE_SESSION pair
on the existing connection. On the server, setup_callback_client()
invokes rpc_create() again -- it's this step that is failing during
the second CREATE_SESSION on a connection because the old xprt
is returned but it's still marked disconnected.

An alternative would be to ensure that setup_callback_client()
always puts xpt_bc_xprt before it invokes rpc_create(). But it
looked to me like rpc_create() already has a bunch of logic to
deal with an existing xpt_bc_xprt.


--
Chuck Lever



