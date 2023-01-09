Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBA2E6628E8
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Jan 2023 15:45:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234120AbjAIOpV (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 9 Jan 2023 09:45:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234146AbjAIOoa (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 9 Jan 2023 09:44:30 -0500
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2117.outbound.protection.outlook.com [40.107.212.117])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 142A83055E;
        Mon,  9 Jan 2023 06:44:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qe9aPx5ozWfua29/Bhg3Yvue5fVn3koXUMDHX6yfiTM6Hvw2ElkfmtQjAIWaXEmst/dDL2dnkHUjGtllBKAzEXMPm5QCi014zrbmEzOIB4dU3eQeEpoLr54cdM1aV1HdKL15nB90iQhB+mL9nm5ra99G3u9WfL16IflqUFJAYdiLI6jCe2Q9UPTJaxm38kSaMYJEw7GJKbEwBi2Ndyb+yhnrvEomNxmf2cf+GTMD5tCePKwyUqQn/m0v7zV9CjzhL3PmdmckNnfSfJhPkiBdoS18KHLhHfHuZpWSVFYn0OgOjOLm2ox0r/x1hBjznD+yua8jUTyEgrQSnW+oh0ihFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Df5a71CcLETaDSaDqfr+sP0fljNYbNYFbMBXcCoclxc=;
 b=gmvlUldb/rKxpG8N2Dfkv2uimuIbkHjxWS3Sp+DlUBDuFqkTdEHuk1PIBzt5KNywJi4ewMSe1x3td40mrKuu/xkgU3avVs2hZR5D7TTqcab2017Rq9X5ZpFwEEHJhU+JIjzLbm1iGCntfAXHqYMXrANXJ5nNkuii4BaR218TnA/EwIklMb0l+nvrWo41mzLxr8nWiwsSAPqtMldzhUJ/mwgemAfqv1J2lZS6oXLz3OpiNLD4UKT+GnbZcWDiSRGC+D+fbA5/rjGIs+qD257LdFXQttoHzO7y1CCXSjrx1v9Mow7pzjuaCtzwupbf7EgVU4N9C85y4acm0nxwi/YLgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Df5a71CcLETaDSaDqfr+sP0fljNYbNYFbMBXcCoclxc=;
 b=eicKTfF4q6/DzCRKRNWKjNMkqD2lrDyHUK4RnoW+7EjQ4MQK9XQvUtyJj9uwIu4szP7dl9wZH3h13+o+tdGZzubPEy/Ln6TgZ8J+jd4WnYyCGTAcSe4jbXzwmaWxqGsjBe7cvItkZJEJSEtYFXQj4mz4RiAb7Bu+fBfKJkWh+t0=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by BY5PR13MB4422.namprd13.prod.outlook.com (2603:10b6:a03:1d7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Mon, 9 Jan
 2023 14:44:19 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::34dd:cd15:8325:3af0]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::34dd:cd15:8325:3af0%8]) with mapi id 15.20.5986.018; Mon, 9 Jan 2023
 14:44:18 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Charles Edward Lever <Chuck.Lever@oracle.com>
CC:     Anna Schumaker <Anna.Schumaker@Netapp.com>,
        linux-nfs <linux-nfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>
Subject: Re: Regression: NULL pointer dereference after NFS_V4_2_READ_PLUS
 (commit 7fd461c47)
Thread-Topic: Regression: NULL pointer dereference after NFS_V4_2_READ_PLUS
 (commit 7fd461c47)
Thread-Index: AQHZIq8B7z8v0ucKO06SfuzpI9LIG66UhAWAgAA+kYCAAPzGAIAAB+QAgABlCYA=
Date:   Mon, 9 Jan 2023 14:44:18 +0000
Message-ID: <6F61B478-A0FF-4E28-A7DE-8DAA6E11B128@hammerspace.com>
References: <f591b13c-4600-e2a4-8efa-aac6ad828dd1@linaro.org>
 <82526863-d07a-0a5d-2990-1555b1387f26@linaro.org>
 <2C5E9725-F152-4D2E-882E-CF92A35481BF@hammerspace.com>
 <7ba38377-7992-7f0f-d905-cceb42510f39@linaro.org>
 <51430925-8046-7066-84ed-2ff0db835347@linaro.org>
In-Reply-To: <51430925-8046-7066-84ed-2ff0db835347@linaro.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.300.101.1.3)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|BY5PR13MB4422:EE_
x-ms-office365-filtering-correlation-id: 7a5d26b9-abbe-4559-85c0-08daf24ffcce
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hMUgc7yJRHdfEDCeiuTuFnQl6CTIuw5AmoO2+EJQESbwGK6sTGBPlNRZNcgMx43Rm0VrotFubzRhejl2xx2BPGrVODP+ari/zMYbBeDW0DLqjmJJl4QnexCg167V+dB4eslTlxjlZc+68Y3ARkgRX0pMaiV6u8SyHRKESwhjco/ijuXSERv94TKElJWvfEWmuEGGR9rGkbS5cPK+qjnVDhC78ZJeigWoFC4MYCgVFHQWm8W0HrLu9pRRvV5Oj8XMZEAjLzUHNCl1ksXJOns6s+7733prUvECrDYT+uM/dLNS72iBz5043xW0a4E9jTySYSnjGoSfUHyM1GpHoHoNNQCs/b/m19umgl6zUu+2wR4811PzMT6OhHcMYMowSaYYRO4Ftw4cRLpcmfGg3IuO/UtbpuDOPzB3eEIm3uAi+cfGBntcjpN1mumB76zCmiQlCfqCJsbF2LkTbmiKJU2XgVqkQZ/DoO2r/fMemW9rMO9T2iPz5ZcL+q+8q0wupY1SpW1LyzGzQmYKuchFp+AL0T+QzyKAyyHiOgEVv+JI5/diFblxo8pZbUq+zdC365gAG73u6Bwtd9C1DHVFkGzgSkOH8gRLcQo0ikn1CC1y3WMIehWciI9G7YLuOB3g2m3TYVvBsOuOobBuX/nr72lHi0wp6v5VzJT56gHlqpNkJRcFa65OJ9xAhySoUXNspDdjrl7sTQnvTOtEkodeioaHDtXnlIvkombhoGMpc7F7bY7yK/w0+5/+KaQT/+FWeeKx9xi+NjhikPz5dZBjywQaVQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(346002)(39830400003)(136003)(366004)(376002)(451199015)(5660300002)(6512007)(8936002)(26005)(186003)(38100700002)(6486002)(478600001)(83380400001)(966005)(38070700005)(2616005)(2906002)(110136005)(54906003)(66556008)(66476007)(64756008)(316002)(66946007)(66446008)(8676002)(71200400001)(76116006)(4326008)(33656002)(6506007)(41300700001)(36756003)(86362001)(53546011)(122000001)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3O7B9KAaxOciMXeIJjaZRilqymleXWoJ+L6ggIDfD3k8f/spi2gANZP//zo2?=
 =?us-ascii?Q?8sDLFscKubsg2s/Eu4kl/5MwncsaRW1Uh5tiP/P1OIsBOLomEVtGUR/HYiJQ?=
 =?us-ascii?Q?wJTRxKaqIVsSNayZPTvkIFh2cTzRu47YeQ5G3WvMIZTDxQ3SLarbrRygbtkG?=
 =?us-ascii?Q?7rWkVN/GZbvM0szzqejGjguEiYMSUDSlaMgvPCC9IS7kWSkZpszZxgXfTcNm?=
 =?us-ascii?Q?kff4zMWIw4BizYWi7L0+yDMr0+3FrNfW2Eb/v43pbgmdmrSCxUDJfuW/IKl4?=
 =?us-ascii?Q?ohvUGdQZ/SriJ8MR153MrDj1iLlK7Lurync+Ujs/mR+/9okpBxOO0MDpKe8Q?=
 =?us-ascii?Q?jHa78ionW+OB2nZQY7/s8/FDbXsKl/peSWP5uQQfc2aqAtapxWF2RGMi2DJT?=
 =?us-ascii?Q?KDYdUxvAf29+3+iMsBL5t6qLuj3yYhocSUhEGMZFb8J1Zvo03Y52CXL7AdWu?=
 =?us-ascii?Q?bUxCpowKMYHrLAhPK9fO0t2c61Xh9M4EMPDmTDeFMuj/bWFEBklxDhVtRC5Z?=
 =?us-ascii?Q?BORhHCEBrGq/D4QF+TEQaBdM2G/bcXpwM0sNhEbK8E+8eH54OEDlhKPXM+fy?=
 =?us-ascii?Q?y3p54ihTgbYTVUfM4v8xEXnGlLDS6z5TAo0/c0wiy6hcdFdget7DzAx0cK4U?=
 =?us-ascii?Q?8avFQ988iLpoqlJo9i9sDS2NF0y5DlHw7Nx8jxXk8Q8pa0HLfLAYOm3VM4ba?=
 =?us-ascii?Q?RVEKK1jmfhLlRPcxY4dhvR20QOzM1fv9htCUeF3g+sGdh1hjnsuhyTJxcC14?=
 =?us-ascii?Q?I1XqGlbaaJK6TibyW8XglPcuOs7hwqqUAICaM91tTfVlBoEASby2mr+76g/d?=
 =?us-ascii?Q?TTHS50wdKVr29KtzRRO1IPWbGIevg9UjpoQl1c62Azu+c4KryqlFdbNdIvCg?=
 =?us-ascii?Q?MO4fznowr3MWDYprkk+r76QV//YSZ6PvOm9dpzodtutvj4oS8QUfosAqdBjv?=
 =?us-ascii?Q?KSb63XbeHU+WRpjexdH/vQJbM7p5NZwXoa+98DJ6Gs4NWdGvmN5D4iHs5XcC?=
 =?us-ascii?Q?vfbdA6ghaPiQs2rwFsCcjGTOBA/mvSqvbzJSTY903uIu4M+UPXH8mlWcd7tP?=
 =?us-ascii?Q?Xt+A9LicuWMmHayHNJ/dzdTK9US7cUSOVDqO5xmDkeQzXKrSr7qeXETUfaJ4?=
 =?us-ascii?Q?ho/rxY23ksPuFW7iwDUSmYp1Zp6oUHd5oLElfyZS7/L31ir8mXIV/6gGcxQo?=
 =?us-ascii?Q?EKjC7ZkF2jiAb13T5ZTCN+wO10ZYTT4vp/DBKXyUat1/Qhj8fuR4DhCD+An2?=
 =?us-ascii?Q?9eW4f/EpypeFAvrP0iOb8/V/fbSbkouFlB2nGhnsG45ii8+kMQcsoXH5INYZ?=
 =?us-ascii?Q?8xBlE5JuhsF0CE1v4/G3p2uJrsnOMFvGS8cSCLqt5NeTRz7bHpE6WnHg7WdR?=
 =?us-ascii?Q?1vpFaCtZHrH81L2s/9FOs3yoTYOmqgzUpuDn2Ft8bs0wAse40k1BszkaoMUI?=
 =?us-ascii?Q?q1Hx6q4O406OVV7bunXfeFezbUjxoaFbBmPkDC65SvbGZdqoFJD7WLrc53aU?=
 =?us-ascii?Q?9oRgHaUqx2QW6Wmv9hT7iIQ7GIfUXnL9Rudx3YYwLahPVIbtAw41ZJ/tyrLf?=
 =?us-ascii?Q?QRQUGslplmgCeke2h/aCQykFEWYeCcWjwJ33i2K8Qv447ATdxsNLACMreHoE?=
 =?us-ascii?Q?yg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B6B7DD8F6D114E48B4011C56481C65BB@namprd13.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a5d26b9-abbe-4559-85c0-08daf24ffcce
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2023 14:44:18.3608
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YW0XnEWPkx96qgZZ8hbrb6iU2SRaVlE/7DzK0llbZdmOSAMcUghphbnwvBzMro8nRmALLoA7CVK3ZHJa9FinhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR13MB4422
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jan 9, 2023, at 03:42, Krzysztof Kozlowski <krzysztof.kozlowski@linaro=
.org> wrote:
>=20
> On 09/01/2023 09:14, Krzysztof Kozlowski wrote:
>> On 08/01/2023 18:09, Trond Myklebust wrote:
>>> Hi Krzysztof,
>>>=20
>>>> On Jan 8, 2023, at 08:25, Krzysztof Kozlowski <krzysztof.kozlowski@lin=
aro.org> wrote:
>>>>=20
>>>> [You don't often get email from krzysztof.kozlowski@linaro.org. Learn =
why this is important at https://aka.ms/LearnAboutSenderIdentification]
>>>>=20
>>>> On 07/01/2023 16:44, Krzysztof Kozlowski wrote:
>>>>> Hi,
>>>>>=20
>>>>> Bisect identified commit 7fd461c47c6c ("NFSv4.2: Change the default
>>>>> KConfig value for READ_PLUS") as one leading to NULL pointer exceptio=
n
>>>>> when mounting NFS root on NFSv4 client:
>>>>>=20
>>>>> [   25.739003] systemd[1]: Set hostname to <odroidhc1>.
>>>>> [   25.771714] systemd[1]: Failed to bump fs.file-max, ignoring: Inva=
lid
>>>>> argument
>>>>> [   26.199478] 8<--- cut here ---
>>>>> [   26.201366] Unable to handle kernel NULL pointer dereference at
>>>>> virtual address 00000004
>>>>> ...
>>>>> [   26.555522]  mmiocpy from xdr_inline_decode+0xec/0x16c
>>>>> [   26.560628]  xdr_inline_decode from nfs4_xdr_dec_read_plus+0x178/0=
x358
>>>>> [   26.567130]  nfs4_xdr_dec_read_plus from call_decode+0x204/0x304
>>>>>=20
>>>>> Full OOPS attached. Full log available here:
>>>>> https://krzk.eu/#/builders/21/builds/3901/steps/15/logs/serial0
>>>>>=20
>>>>> Disabling NFS_V4_2_READ_PLUS fixes the issue, so obviously the commit=
 is
>>>>> not the cause, but rather making it default caused the regression.
>>>>>=20
>>>>> I did not make the bisect yet which commit introduced it, if every
>>>>> config includes NFS_V4_2_READ_PLUS.
>>>>=20
>>>> When every kernel is built with NFS_V4_2_READ_PLUS, bisect pointed to:
>>>> d3b00a802c84 ("NFS: Replace the READ_PLUS decoding code")
>>>>=20
>>>> commit d3b00a802c845a6021148ce2e669b5a0b5729959
>>>> Author: Anna Schumaker <Anna.Schumaker@Netapp.com>
>>>> Date:   Thu Jul 21 14:21:34 2022 -0400
>>>>=20
>>>>   NFS: Replace the READ_PLUS decoding code
>>>>=20
>>>>   We now take a 2-step process that allows us to place data and hole
>>>>   segments directly at their final position in the xdr_stream without
>>>>   needing to do a bunch of redundant copies to expand holes. Due to th=
e
>>>>   variable lengths of each segment, the xdr metadata might cross page
>>>>   boundaries which I account for by setting a small scratch buffer so
>>>>   xdr_inline_decode() won't fail.
>>>>=20
>>>>   Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
>>>>   Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
>>>>=20
>>>> With a trace:
>>>> [   25.898462] systemd[1]: Set hostname to <odroidhc1>.
>>>> [   25.933746] systemd[1]: Failed to bump fs.file-max, ignoring: Inval=
id
>>>> argument
>>>> [   25.986237] random: crng init done
>>>> [   26.264564] 8<--- cut here ---
>>>> [   26.266823] Unable to handle kernel NULL pointer dereference at
>>>> virtual address 00000fe8
>>>> ...
>>>> [   26.597263]  nfs4_xdr_dec_read_plus from call_decode+0x204/0x304
>>>> [   26.603222]  call_decode from __rpc_execute+0xd0/0x890
>>>> [   26.608328]  __rpc_execute from rpc_async_schedule+0x1c/0x34
>>>> [   26.613960]  rpc_async_schedule from process_one_work+0x294/0x790
>>>> [   26.620030]  process_one_work from worker_thread+0x54/0x518
>>>> [   26.625570]  worker_thread from kthread+0xf4/0x128
>>>> [   26.630336]  kthread from ret_from_fork+0x14/0x2c
>>>>=20
>>>=20
>>> Is this test being run against a 6.2-rc2 server, or is it an older serv=
er platform? We know there were bugs in older server implementations, so th=
e question is whether this might be a problem with handling a bad/corrupt R=
PC reply from the server, or whether it is happening against code that is s=
upposed to have been fixed?
>>=20
>> I would say that buggy server should not cause NULL pointer dereferences
>> on the client. Otherwise this is a perfect recipe for a rogue server in
>> the network to start crashing clients and running exploits... Imagine a
>> compromised machine (through some other means) in a local company
>> network running now a server with NFS share "HR salary data" or "HR
>> planned layoffs", where unsuspected people in that network access it
>> leading to exploit of NFS code on their side...
>>=20
>> Server is Raspberry Pi 3 kernel: 5.10.92-2-rpi-legacy-ARCH
>>=20
>> Which points that it is not latest stable, so anyway I need to update.
>=20
> I updated the kernel to 5.15.84-3-rpi-ARCH which is pretty close to
> latest stable and I can reproduce the issue. Therefore:
> 1. It is visible on two stable (one new, one old) kernels on the server,
> 2. Buggy or rogue server should not cause NULL pointer on remote devices.=
..
>=20

The nfsd READ_PLUS code is borked up and until 6.2-rc1. I thought we had a =
server option to disable that code, but it seems as if that is not the case=
.
Chuck + Anna, can we please send a stable patch to rip out that code altoge=
ther from all the older versions? If we want to enable READ_PLUS by default=
 on the client, then we cannot do so if the majority of NFSv4.2 servers out=
 there are running a borked implementation.

I do agree that we cannot allow buggy servers to cause memory corruption in=
 the client code, so I propose that we revert the Kconfig default setting c=
hange again until both the client code and the legacy servers have been fix=
ed. Anna?

Thanks
  Trond=
