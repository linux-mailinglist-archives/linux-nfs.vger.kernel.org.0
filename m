Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 218C3661735
	for <lists+linux-nfs@lfdr.de>; Sun,  8 Jan 2023 18:10:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233319AbjAHRKO (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 8 Jan 2023 12:10:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234377AbjAHRJ4 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 8 Jan 2023 12:09:56 -0500
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2109.outbound.protection.outlook.com [40.107.212.109])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3413BBC82;
        Sun,  8 Jan 2023 09:09:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X+SHv5OJul2td/TSXxdpgcs86TcjLLoOwj46bLA8SSs8EcFMHHEA0fmjZ0WRn0+tPqYGPQooMXiTrRiocXZuGXcqPYQo1Y+W3KBUJIm+Q8NFxjzru7NsVWyw38eAf0IADXMV5rNCg9RrqXM1Sew/5iVUNUNpucjToZM5OhoMaqCgfFpNDxkg6sY4kHDSS5Apa0kRCNkPdwrMpleD93jswpOitsR5PNsUh/EByM1BsX7uPZrPHZM4wd9U5667nhcuRjMrN2Px6yv4Gt51xg73bEkW3WCIUy6aWXnSfjWtpF2/ptpMlxmIL/pvmPCZTz1jfooFngg8C6ujTRsRA0bamg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G2jrbAh8T5n7CSNPNCelxX3GkXggrJ3GOnbo4VtaH74=;
 b=V8S5yh4AgylnFYmeVFBSmh/kFDSGQD9jRbVOoOO8goBQzhto8Z3UHIDZKBQ3CWUAF4qw9M5O1cLXFKlZZYq5g05ngoszY7K9RQyCWn1aepuCCWbIEApE/pH4bIgBXWQTSkD2fAfWWB19XdRZwI3q/lc0y7yGJBWQcsG30dhhxYErqZX4N2ng6tWMH5iXsib1bYhQ2FEfx578h5ArkW2/DemQGijS6fazCC/wjT6h5SfQxgHNrLOKfab8t6gzG5flstD3TT9xZCTgiF/J/uQLsdd+yABvHEjSLhz9QbKLA5AH4bGY/L3j+U9fzIuzw7qCko8MItoV8lnLPSSBQOD03g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G2jrbAh8T5n7CSNPNCelxX3GkXggrJ3GOnbo4VtaH74=;
 b=BJPqNw1UViHe6e9zlB2gjHP6JxooGUAJHZE1STbJaNqfP/dhXKa1zT+Y4wBwkL/8UItAXFRWLc8g2qhkIG0r4k9peDe9Pv1brypZ2GPbmrbEUh31ijkNAaIaloBxmbsjHEwn2Km2glyzYh03pidrdSDyBq83+7n8LMYFW7M9IGA=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by CO3PR13MB5765.namprd13.prod.outlook.com (2603:10b6:303:175::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Sun, 8 Jan
 2023 17:09:44 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::34dd:cd15:8325:3af0]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::34dd:cd15:8325:3af0%8]) with mapi id 15.20.5986.018; Sun, 8 Jan 2023
 17:09:43 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC:     Anna Schumaker <Anna.Schumaker@Netapp.com>,
        linux-nfs <linux-nfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>
Subject: Re: Regression: NULL pointer dereference after NFS_V4_2_READ_PLUS
 (commit 7fd461c47)
Thread-Topic: Regression: NULL pointer dereference after NFS_V4_2_READ_PLUS
 (commit 7fd461c47)
Thread-Index: AQHZIq8B7z8v0ucKO06SfuzpI9LIG66UhAWAgAA+kYA=
Date:   Sun, 8 Jan 2023 17:09:43 +0000
Message-ID: <2C5E9725-F152-4D2E-882E-CF92A35481BF@hammerspace.com>
References: <f591b13c-4600-e2a4-8efa-aac6ad828dd1@linaro.org>
 <82526863-d07a-0a5d-2990-1555b1387f26@linaro.org>
In-Reply-To: <82526863-d07a-0a5d-2990-1555b1387f26@linaro.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.300.101.1.3)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|CO3PR13MB5765:EE_
x-ms-office365-filtering-correlation-id: 2c8510bf-00b4-4386-99ea-08daf19b2302
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HBV6DLLw9XEfbJYhqqa7BrBO8P6e8IKGQ6wenEaLxC/IEQgKobq2a5omyWIsHbNvckg1Nz2Ba3gj9yC7z1xzN9LN4YRU9yLhfVeNNMimFvK/2ZjtnDvcvftzTB3nGpnwm8d+XkfBXOnT2Y1fjd54ipyqvTHG207qwbdCpfDnO//i30qFbh/6rLMOcoZpv4swJBCC2M+14TcLEG5uXpIE99feFW6B/izXItEtRVZMetEwM9OhU5MvWyTLhsWUC/QMyK4p3a/qACQl6hdahzm1q6Rugp05ybM2wzbnhUywX6g8/Y+W3aNNF757Yd41YfDCAlLkpdNAbTm0cJn7vBIpZH774uqdDVWxbO/KTdexXRqR5LTSyTYHACf3tsvOyvEUI4IZb+mXoo1ptLNlRCHB/UQxn3zq1yFkXwSYq57sd2s8iTJz77E4SlPiDKa6NKpsGTGzELlkRwQufLbZy6pQlXajTk9QAPVBFbGbUEIxHc25UXDLMt3ndb1CdloURBk7zs9644r6UXOAH/k8A78PEtJodV3+GkL1NtG7UCoq1zRgYVzSxt698mZneZtzNWavEw5Gjzvvbb3iYpWMZv9m+EBPbWCi890mEZD4h+mkb81bFY/NPVaAABGOlakIeKflJN8Mf69G6Q40r9l2RF287VOViuGRGukbcHqiJ+TJmF2j1vBk/GOM6OFDcTCfi2Dh
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39830400003)(376002)(366004)(136003)(346002)(396003)(451199015)(8676002)(6916009)(76116006)(4326008)(66556008)(64756008)(66476007)(316002)(66946007)(66446008)(71200400001)(54906003)(38070700005)(2906002)(5660300002)(8936002)(41300700001)(86362001)(83380400001)(53546011)(6506007)(966005)(6486002)(478600001)(33656002)(36756003)(122000001)(38100700002)(2616005)(186003)(6512007)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?tYMzTJuzgaMEx8zaSKeCZfZCOa3cIWzsSnas/Nq/0RMk2YmXl2Awgt4rD5ZV?=
 =?us-ascii?Q?b+U6oTj/x/hBVxKAbQimdXRSHYbxzht/ZkKIZ1LmQLPGtzuJaCKA1jPH8Iu1?=
 =?us-ascii?Q?BHhCupsty+oKFsC2tlHmQdG+A9TYMnF+f6vMOvb2iK4n6SOksqmmSm3hZaaD?=
 =?us-ascii?Q?COn3ByH07fQSoMkXLD8WXu/QIinGzsp32V3SEwq0HRpBXo0jNipHmdmXa46N?=
 =?us-ascii?Q?SLWETNKsM1EhFwKunfM4ISVkqZuN3ID3oY1ps0YcP3rDy2OnJuQAsD+K40Bw?=
 =?us-ascii?Q?g+lPDW1fc4KNfSWTLbBFxaxjh5ksqUsvqWOzNM0yPIKBpYn3jeVfAGmqJ0qd?=
 =?us-ascii?Q?V1O7pS2vewooiM3e8W1W6EJrE+xNow9gQaHCYN9BsQk5gXGQj2aI4dTEXYdO?=
 =?us-ascii?Q?qyka6XknZRhTcdE3bPj6pdAO5pWnpt4x3+68gnTlqphKzaxsOHTx08PX6Ige?=
 =?us-ascii?Q?eYH4UZQokItS9B3+44BxN444t74aJ9Dc1yWK05NYzZExMfgJioEo10gcBW1T?=
 =?us-ascii?Q?X1zFHL1tC4cuodTW1OI2dNmkbR6qPzR9Ej9cLgtffFESm08/33kmohYgPJKB?=
 =?us-ascii?Q?+Otz5y/H7VTKBk3SxI09khHuYUDHHjT1vc7nnEk2y6spg/I3C2DMegLubbTE?=
 =?us-ascii?Q?SMGj/5rQbujDjFGetMJC48ySP3d2MWZrVLgywJMHHMUuJnjxjY3ifFamUcmL?=
 =?us-ascii?Q?Ink9OnaknnsimfliNHFRcxlOgiMlQLavdE4s+RnT1PuHZn0ClRG+YFwmiMJx?=
 =?us-ascii?Q?kyyPhLq19opwKEy1zu6YTd7hw9lVGN+U6FQ0FngP9YFMM4RWen3T0WAGEPCv?=
 =?us-ascii?Q?mreqmM1+xx5qFFI7SFPwLRJvM6F06L9wxLyKZRJox3fFbesU7xqwz15fK38s?=
 =?us-ascii?Q?qo8XkCtaQ8g75SnB9cPvEjEQR9uNH4mrxWueR16JDqo4t7yKQ+r5Ote+7SET?=
 =?us-ascii?Q?YcsL11J2U4ifveyWI/iTnzyR8SmV5zH6F3P2OInHhSqQzKm6cOlLEDH1EnG0?=
 =?us-ascii?Q?pmdZ2jlGtWKu1U86SvndWFRDElVhzf9Ub3u/N/+umJNlzrx/xWUKQ+7O7vEK?=
 =?us-ascii?Q?mrqi/8qWTLiG5BrfHaPARcduP8RkVfVr1XLFXRGCTFGeg5QI4LBk8txb++f3?=
 =?us-ascii?Q?xsi12R7CorYBE7ALENlo0OjjGfJu4ALV0OSEGeS/cAVWm4Q2ZfjcnezzQVoh?=
 =?us-ascii?Q?08+5lZ2yed0yaNdfEKylnD4+0H+P8JJuRgUZkohElPvthnQffVxUEO2zaS+o?=
 =?us-ascii?Q?0ZgaQRBu038JVFW+i17QFdc3sXvk3JV49G0N0CYIcdqlC93YtxX2DCuEv9lA?=
 =?us-ascii?Q?Uwjj7odRF2KIwI4bTB21balT9Up7mym0HLWo6y+sHgfBPEC8h6A1EtiAqxzW?=
 =?us-ascii?Q?ed1kbfV0OTXpWSbErA36kjdXfbxztWQSqICsQi3gqhoGvZPVglXC7ORLJaG1?=
 =?us-ascii?Q?DCffYtH0D4DW511ARkIgcqbLAVz2CFmT9GnHW5MCh4wxCR9ELOiIRfPk+7Wa?=
 =?us-ascii?Q?wGYNlAwfeWX3qMidifFvmBSsWJHyPvN1mgxyhxNJy04QvgPsqFQljQciwHOI?=
 =?us-ascii?Q?i7Ge+TBGgYfKqrAJB+DQl02pFD/cuVGWAy8QMFxkOUfJXOg+1r5pDqSfSZAM?=
 =?us-ascii?Q?9WAKT4ifkXkixnlVx7PO4Qqtg5FsiKUsIuX7SUIQk7kHK8coWAYr/sKg3/SJ?=
 =?us-ascii?Q?ZnZxaw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D1C964EF0867A5469A2297124A195D78@namprd13.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c8510bf-00b4-4386-99ea-08daf19b2302
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2023 17:09:43.5788
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wumfwe2L4YOnH5f3+FlyYMy5fbcYJxHtownCKlvGCN4iHUmwwY6/NQa2BqgglLHAPDJ6+nmZ1aAT60+kqfEE+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO3PR13MB5765
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Krzysztof,

> On Jan 8, 2023, at 08:25, Krzysztof Kozlowski <krzysztof.kozlowski@linaro=
.org> wrote:
>=20
> [You don't often get email from krzysztof.kozlowski@linaro.org. Learn why=
 this is important at https://aka.ms/LearnAboutSenderIdentification]
>=20
> On 07/01/2023 16:44, Krzysztof Kozlowski wrote:
>> Hi,
>>=20
>> Bisect identified commit 7fd461c47c6c ("NFSv4.2: Change the default
>> KConfig value for READ_PLUS") as one leading to NULL pointer exception
>> when mounting NFS root on NFSv4 client:
>>=20
>> [   25.739003] systemd[1]: Set hostname to <odroidhc1>.
>> [   25.771714] systemd[1]: Failed to bump fs.file-max, ignoring: Invalid
>> argument
>> [   26.199478] 8<--- cut here ---
>> [   26.201366] Unable to handle kernel NULL pointer dereference at
>> virtual address 00000004
>> ...
>> [   26.555522]  mmiocpy from xdr_inline_decode+0xec/0x16c
>> [   26.560628]  xdr_inline_decode from nfs4_xdr_dec_read_plus+0x178/0x35=
8
>> [   26.567130]  nfs4_xdr_dec_read_plus from call_decode+0x204/0x304
>>=20
>> Full OOPS attached. Full log available here:
>> https://krzk.eu/#/builders/21/builds/3901/steps/15/logs/serial0
>>=20
>> Disabling NFS_V4_2_READ_PLUS fixes the issue, so obviously the commit is
>> not the cause, but rather making it default caused the regression.
>>=20
>> I did not make the bisect yet which commit introduced it, if every
>> config includes NFS_V4_2_READ_PLUS.
>=20
> When every kernel is built with NFS_V4_2_READ_PLUS, bisect pointed to:
> d3b00a802c84 ("NFS: Replace the READ_PLUS decoding code")
>=20
> commit d3b00a802c845a6021148ce2e669b5a0b5729959
> Author: Anna Schumaker <Anna.Schumaker@Netapp.com>
> Date:   Thu Jul 21 14:21:34 2022 -0400
>=20
>    NFS: Replace the READ_PLUS decoding code
>=20
>    We now take a 2-step process that allows us to place data and hole
>    segments directly at their final position in the xdr_stream without
>    needing to do a bunch of redundant copies to expand holes. Due to the
>    variable lengths of each segment, the xdr metadata might cross page
>    boundaries which I account for by setting a small scratch buffer so
>    xdr_inline_decode() won't fail.
>=20
>    Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
>    Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
>=20
> With a trace:
> [   25.898462] systemd[1]: Set hostname to <odroidhc1>.
> [   25.933746] systemd[1]: Failed to bump fs.file-max, ignoring: Invalid
> argument
> [   25.986237] random: crng init done
> [   26.264564] 8<--- cut here ---
> [   26.266823] Unable to handle kernel NULL pointer dereference at
> virtual address 00000fe8
> ...
> [   26.597263]  nfs4_xdr_dec_read_plus from call_decode+0x204/0x304
> [   26.603222]  call_decode from __rpc_execute+0xd0/0x890
> [   26.608328]  __rpc_execute from rpc_async_schedule+0x1c/0x34
> [   26.613960]  rpc_async_schedule from process_one_work+0x294/0x790
> [   26.620030]  process_one_work from worker_thread+0x54/0x518
> [   26.625570]  worker_thread from kthread+0xf4/0x128
> [   26.630336]  kthread from ret_from_fork+0x14/0x2c
>=20

Is this test being run against a 6.2-rc2 server, or is it an older server p=
latform? We know there were bugs in older server implementations, so the qu=
estion is whether this might be a problem with handling a bad/corrupt RPC r=
eply from the server, or whether it is happening against code that is suppo=
sed to have been fixed?

Thanks
  Trond

_________________________________
Trond Myklebust
Linux NFS client maintainer, Hammerspace
trond.myklebust@hammerspace.com

