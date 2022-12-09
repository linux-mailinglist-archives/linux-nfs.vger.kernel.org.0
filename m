Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69A2064842A
	for <lists+linux-nfs@lfdr.de>; Fri,  9 Dec 2022 15:53:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbiLIOxO (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 9 Dec 2022 09:53:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbiLIOxM (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 9 Dec 2022 09:53:12 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2100.outbound.protection.outlook.com [40.107.236.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7B965F6F8;
        Fri,  9 Dec 2022 06:53:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DQ70jn/I3CXoNBzz/LIRRwT7OT625shiI0Tj7hUJY/UbANKbeFXcmv4qLoJhzJwvp38p4cPTWlfRs774Hnja8n7IKUazZ/bLY62L2QipXG/QHRHIkrZVbhI7l/Jsd0oWudyVV3Fo5MN562vKsKlWSQgeVFwqs3GPDFzTUX4KP720GC9GM+5vgyF0dOWJa056lQaEvihCge4vB9zbtxT3z742trs5qfh8UUG/qjfq72VhnxA8WlyYepKzxF5eaIwXFgZgL5OPNJZD8IKXse+UzfugbG88D3UP2GE3v1zFdeejuupMJbShEqHpkBu3hlhcmh+ndnqagZrxaWGzn8xazQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e27ee0l9eLPm6UMrQR+4DanGDd/HuVlduAw5mETuXp8=;
 b=Akjq5XU4XE2diOQniiMtgm7i56iPmHuD5KY6AL1wzHcUnmkW+uv0heYeOmwzxEEl2NdkNh9cQnNkXokd4upKIOROhO6kQy6VZAh7heOfraaKZcndo9T2qxK3EohfkSnSZHBaxt6vJB1ljD5VE7JrLOeHiSAm3fSm0c+YfufVsRCKAW6EtNT6aYwx3BW4HwfWx4B0MZZ+44y2kA9DCLu4egwKUpa/L6Tcz9I4PnikKkklvVFjnqmHQ03Mgx/UBouMAlxuXeHUT2xa5qC42pUmfF5pyBijx3KeOqzfasJMZgi0dgyAl+31LTYXn9I+E14Smdgtt2vfhFcgPQqM6kO8Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e27ee0l9eLPm6UMrQR+4DanGDd/HuVlduAw5mETuXp8=;
 b=gKXI7SiasBwQXuDhTWCTe+BJvBHJOibmo8WKhZGzgfB777zKyOHYnRJpeK0MsUptw4jjEiVYQoO2vDDrAjw/fD34gZys0+S31Jcvb72qZGbms4fYPwZ7DCGqM4llFNNCWystidvfmhv1AMaoIJOCOefWQmJa+Rf8ozx927IW/3E=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by SJ0PR13MB5692.namprd13.prod.outlook.com (2603:10b6:a03:407::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Fri, 9 Dec
 2022 14:53:05 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::34dd:cd15:8325:3af0]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::34dd:cd15:8325:3af0%8]) with mapi id 15.20.5880.014; Fri, 9 Dec 2022
 14:53:05 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     Benjamin Coddington <bcodding@redhat.com>
CC:     Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
        Trond Myklebust <trondmy@hammerspace.com>,
        "anna@kernel.org" <anna@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "yusongping@huawei.com" <yusongping@huawei.com>,
        "hukeping@huawei.com" <hukeping@huawei.com>,
        "artem.kuzin@huawei.com" <artem.kuzin@huawei.com>
Subject: Re: [PATCH] NFSv4.1: Fix memory leakage
Thread-Topic: [PATCH] NFSv4.1: Fix memory leakage
Thread-Index: AQHZC8nZC2iXpfIn9E+pr8pqvDIwIa5lpEIA
Date:   Fri, 9 Dec 2022 14:53:05 +0000
Message-ID: <1B4CB75E-5227-4B07-A390-175024B3219E@hammerspace.com>
References: <20221209021823.1232874-1-konstantin.meskhidze@huawei.com>
 <5EDDEEF3-59C6-4297-9E55-3528E6E015FE@redhat.com>
In-Reply-To: <5EDDEEF3-59C6-4297-9E55-3528E6E015FE@redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.200.110.1.12)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|SJ0PR13MB5692:EE_
x-ms-office365-filtering-correlation-id: 9cb5d698-1b54-4dfe-bee8-08dad9f51434
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vGJdkvqfK6h7GwUjrSySYtcP2W8CiOUhnXuZx47bZ2jiPUISW6Ii8mfqWckEGurvd0mwPtz3oCMP/ow+rJdLKdFr7wGW8QeZI9G3p+dUr5LH9D3jCMpQOVNlHM4pJiLNVsdRfY25wLMlO9klMi8LTMJXR4+5PrBV0dPj127XvaJV+hTBdpxVZQOKN8G3Ekq67bgKTAoLr6xqSAvTAfDZNhXD9W6vYIu35UQakOHexvayTqBZ+jS2orkTiBTJi8VQG1rHCHEEOlahz0HcbC4xeYUNroN4Eno1UGoMZz/SfeyW2fRDGyez5bhIKVW5a8SZ5M4rYePGpUoD4L/CPElY+VhbGuta7DLTAmVpkUh5qcc4tnOmr2BLd0VSe5WGYiZenyoK8Tmh8FTqWm6ky9WylxerY3eijJmaMGXJrYWXvvYWLgxl9V2y708UfSG2fRelVywsUIK/OA2J9BVCXRrh6/ppVTPt80YFuNSbWTte8rmsS3J7Hx6TwB/31lI/OHHiAZ+wU0BlVyPqN1VtPfJFILM3GjpUf9u4OJBF5EbUhVQLHwvWUoWDtzj5B0ygZ1XxUExyxdSWpdrgmCc9PKXmuxdg7M3hgxj5u/fDaBOnFqpQ07LtjD4+Kf6HGba5i1n4a/xQpn7h1YarO3cD91raHiPs+bllpMxLHcJmwhargDIEIn+cCoKGYwqIirV8d7th3Ia9xd0FG5xIUxOQOdMQRQadyCDey/m08Uiu65Z6IJM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(366004)(346002)(376002)(39840400004)(136003)(451199015)(38100700002)(36756003)(5660300002)(2906002)(4326008)(41300700001)(38070700005)(8936002)(66556008)(122000001)(83380400001)(33656002)(66946007)(76116006)(66476007)(316002)(66446008)(6486002)(71200400001)(6916009)(2616005)(54906003)(86362001)(478600001)(64756008)(186003)(8676002)(6512007)(6506007)(53546011)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?2Kq3zEyjYc+vSerIYdeGeQsqFMnepDOimWma/twJPlUqL/DchFjoItqLPi1G?=
 =?us-ascii?Q?5qZJshMuI0evDTxrkJyMYTtrrr90nBP6C0nv2ee59lI/tzEupvF+iw//SId6?=
 =?us-ascii?Q?JbkyLUiXM5tzSTHMocUw3wj7+mIglySxt5XLctKXJVDzyd5I+oe+fwhu6mib?=
 =?us-ascii?Q?ENXZlqAm5v69VRDShmPOqh8qnmFmuGX3eVv4dKYDcBSQo5Fx9+bduMwM4gN7?=
 =?us-ascii?Q?aoeS8H5u1CxlVtO6DtsiFwsoI5SXIpVcEGBr3eSK/47hoWG/gD+xmDD9ooqu?=
 =?us-ascii?Q?GwhIUg9e4Z5DAtVjlYLFnf2q6sZqUrwLE1qTrfZoG2QMu8LbilCX4kmLQxch?=
 =?us-ascii?Q?RtGZBnFHwoNpRkNizpQuijbfuZM/FoJSRTirkHYhOsdlTeBE2x0zDfTK+qYg?=
 =?us-ascii?Q?DYLHqvWU3LFfV6PYMc3ythpogMofuU6YJJGa8nyh6Du0Nvh6OnFKgLBCRXBe?=
 =?us-ascii?Q?5Uyb0vAr4JT3w3QqFwyC85hCiS9XtNbFKod6QtXBJUTEjUzLuWBKagNV4WRk?=
 =?us-ascii?Q?FqS8c5HUlHRgoXJFp8yBQTUw07VFhu1QKaRkdPzHwZJAETFKh76PnCv+bDMd?=
 =?us-ascii?Q?wijW9jUpH4RaA+tt41KqbxmitRQ0Tft/ztj7RbZ4lrOSsBDqpJx+50Rdbodr?=
 =?us-ascii?Q?4y/kVNPAEv7or2E0O6OcfsODzNKashqmDiuXlHH8eJe6CVNes96otHcfyEyf?=
 =?us-ascii?Q?jcRL2rpZAC097CYbG9om7/TiNfdBNwrY0QvFpL20zikgFyBjxoOOnfzKaUk2?=
 =?us-ascii?Q?Dn1BJyyhxs6XPQuCu9dLKXnHK2giR7YI9FD1G9TjOCpBoKJxscTNMOqKdeb/?=
 =?us-ascii?Q?AULlpmsF06H/JIkKC3s+KIM3fvteJHCQT8lvp5zEmqqnBkixosr8J7x/nW7A?=
 =?us-ascii?Q?e/KA5dSqlCCTo2gxERrHZmu/mTBcSvWmu1y9D1udiWw3UwHa7v+2qH6XuBSq?=
 =?us-ascii?Q?R3K/ZiLsXGlByyCHGTn7MNP+5h4kbr0AP4xN/cN0JHkLzHPVe7WaaGIoIpBe?=
 =?us-ascii?Q?WwdneK0mFIM2P13NwoSC1jDLn4hHz9Baiom/6Dg2y6A8U5raR9VbQ+TRUn8T?=
 =?us-ascii?Q?0lnRyzfehfZkNkC5Y/WsQiD0Sm/w1WwJt7ZMAL/yGAZa8ZfhIAg5IP5rOuCH?=
 =?us-ascii?Q?JS5tiTYuiHIRTbk6WUNv2URP27foMWYqqeLOa10kQ9+WVtznoWaJgnZOl2+P?=
 =?us-ascii?Q?btvi6ynMk3oAikeWCST3QAwAkWdgQb56Ztm/zwVJX8iF2W/mPOYkopg4fP6U?=
 =?us-ascii?Q?aqy39/UnhpBCB6piJouNntCmEPgeYXj+akhV2utHIel2jKQa9udxDXN/WN5q?=
 =?us-ascii?Q?0vBIvmsOHl+u+nNW97DNrZ7reaybJLuK6sddQpiVrXoSvHxPDUGxjZpF/hr3?=
 =?us-ascii?Q?OyT3hxn2pePEZFtK69+cfl/9eHSEWM4sJVKNgwAQ0sYVS+ZOAFrjKFDmE6E8?=
 =?us-ascii?Q?yzdHMVw5E6xik1Z8CQ8P26t9F9pL4HUOo27Aj7hpJphDODGa+rRxFvDhH47G?=
 =?us-ascii?Q?nbIt5FubVKzXU+lfcUU6l2KFbT7Q+uBu8r6Hyd+9ZMqHsuhxY2jic5wztH5M?=
 =?us-ascii?Q?PhIZMqdXD0EN98rAtMRK0oq63Z8HT7v9X9AWS50y4ghTSHDMV+b8bLZKguAd?=
 =?us-ascii?Q?LN6rbEdhrVUTIjfZBd9Gl41rou7uvQM36e82lY/TnfZjLCQfOs2kXHWbU2PJ?=
 =?us-ascii?Q?eQAh9Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <09EAB2B315960C4A89B5E0954B5E329E@namprd13.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cb5d698-1b54-4dfe-bee8-08dad9f51434
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Dec 2022 14:53:05.5250
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BP67V/4me3OFZCq5h+jAfXgbumsKXzPNbOEpjQmDZkc+3V8YPrNTxAJEwhMi0+cmnxAf5DNic5zehrR0bZ5Okw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR13MB5692
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Dec 9, 2022, at 07:29, Benjamin Coddington <bcodding@redhat.com> wrote=
:
>=20
> On 8 Dec 2022, at 21:18, Konstantin Meskhidze wrote:
>=20
>> This commit fixes potential memory leakage of 'calldata' memory chunk
>> in _nfs41_proc_sequence() function.
>>=20
>> Signed-off-by: Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
>> ---
>> fs/nfs/nfs4proc.c | 4 +++-
>> 1 file changed, 3 insertions(+), 1 deletion(-)
>>=20
>> diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
>> index 86ed5c0142c3..b7aa66167341 100644
>> --- a/fs/nfs/nfs4proc.c
>> +++ b/fs/nfs/nfs4proc.c
>> @@ -9416,8 +9416,10 @@ static struct rpc_task *_nfs41_proc_sequence(stru=
ct nfs_client *clp,
>> task_setup_data.callback_data =3D calldata;
>>=20
>> ret =3D rpc_run_task(&task_setup_data);
>> - if (IS_ERR(ret))
>> + if (IS_ERR(ret)) {
>> + kfree(calldata);
>> goto out_err;
>> + }
>> return ret;
>> out_put_clp:
>> nfs_put_client(clp);
>> --=20
>> 2.25.1
>=20
> Did you observe this leak, or find it by code inspecton?
>=20
> I don't think there's a leak here because there's no way rpc_run_task() c=
an
> return an error withouth also doing rpc_call_ops->rpc_release, which shou=
ld
> free the calldata.

Correct. We will not be applying this patch.
_________________________________
Trond Myklebust
Linux NFS client maintainer, Hammerspace
trond.myklebust@hammerspace.com

