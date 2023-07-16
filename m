Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BEAF75500F
	for <lists+linux-nfs@lfdr.de>; Sun, 16 Jul 2023 19:11:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbjGPRLn (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 16 Jul 2023 13:11:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbjGPRLm (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 16 Jul 2023 13:11:42 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4AC7184;
        Sun, 16 Jul 2023 10:11:40 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36GH091b029834;
        Sun, 16 Jul 2023 17:11:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=sAi/r+9P38L247cdJib3B9EXoC8Clin6pdnclGVNXuE=;
 b=zdkYYL2MMbvWltIATWEM9Ld33i7BWaynELbYW44K/6/D56BZtD2IyeD8PQA572YTrcEk
 qS6JBS+wQ/uwgztfN9TOqKjmZMz1FAL8YmsFoqHO9vEGhCy0WBNJdPMNhxjkuUlZ8haA
 GFI7VVpKKa7Fud5Lt/2ps12Ni6LVhOehvZOatwAirDmgBVitUnp8QOiflcIo7FRh026M
 53f+W+RJKkYfQy9WBEdT795r/PAEnmS2kcCp15B8EPhtP65OolIuf9tBgubR4ecYWwWZ
 tIsZHDVw1QQm94a5U0oIKQ0gdvkTMEv4ruSqhsLvlZ9Dhh/cz8PrPHTk4jxwl+bvY5MI LA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3run781drr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 16 Jul 2023 17:11:33 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36GGVeP7038163;
        Sun, 16 Jul 2023 17:11:32 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2103.outbound.protection.outlook.com [104.47.55.103])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ruhw2nh84-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 16 Jul 2023 17:11:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OkKbrg8T7XSDniBAuXadbMFHSk4s5MagEtuzZ3cDC6T1aLU2dV2ZyDcFzJvmWYVeLLayEBPfTVeEtacouRboi9Q89ezqz6u22NFJE6H+druBIKwJvxZrrJlqdwq+HRcBQPS+afN1u+9S9W4ZwFaUA+QhNt1qNKkSMNwREGODREhbw3r+FYtF7ypuZo8f1g4rVSGFxsrXBWj55yuiPHzXBMHP/n4j72iWJ4TvWKHXQ3P/28UurbhYvU/S+KTmyTbnPKeWwXGAFeVKmauLISxMciqjtOgBiFK2AEQH4Qeoj3zgco6gtYmg+iDhVjGIkTaWUGHmeAz55w1cn6rGDA+LXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sAi/r+9P38L247cdJib3B9EXoC8Clin6pdnclGVNXuE=;
 b=N/19klKRq585T2Chx7g3PKy/h1oX4/ljzN1DMN1oKRrA8X3Xid3+mUHmiuLPJ7nSJGxOZHXfi/I242e1CBhDGXeBiaESBBvoYlLXxWkGywUg0/MWWP5Ny26uan/lQi3OdVsubWQGEl6s+1dpHQgDmj9WLW8oaSzDyHthHhKs1bDLqcgg25BDLBs+TY/yf6FJaOrnDR9lznIgBBrk2ZmTksqgND8ql/jeDAHywsY9NwY/Yju3SKkQjErTvaeKcS1UsgllNyKWQ/foUrCHtOBRW/827/9O6j9ABttutqbMrja0qDkOjh6pQON6GRCWFALjEHFH25T+Fg+IhnxvMN/uVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sAi/r+9P38L247cdJib3B9EXoC8Clin6pdnclGVNXuE=;
 b=w3S8qST+FxgrmiaeHmrjQW5LNFCZE0LHaAZn1gL8w9RK0uiyKjz5/p1YstocCi1+VGX3nSQgudxGdp9KRg2iWGsC22hcjbTyEob4MWKTDn0hsP5T5aId4LjXndTHcH0Fa5mcGu7oMFzWCIhzysyncWoNEzIWoVhoH0ZtX5SHWnU=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH0PR10MB4726.namprd10.prod.outlook.com (2603:10b6:510:3d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.31; Sun, 16 Jul
 2023 17:11:30 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2107:f712:a7c5:9ac7]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2107:f712:a7c5:9ac7%3]) with mapi id 15.20.6588.031; Sun, 16 Jul 2023
 17:11:30 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Anna Schumaker <anna.schumaker@netapp.com>
CC:     Chuck Lever <cel@kernel.org>, Tom Talpey <tom@talpey.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        Olga Kornievskaia <kolga@netapp.com>
Subject: Re: [PATCH] xprtrdma: Remap Receive buffers after a reconnect
Thread-Topic: [PATCH] xprtrdma: Remap Receive buffers after a reconnect
Thread-Index: AQHZtmXW1KhFMZKe0k63dgGlYrfiG6+7DzkAgAAgMYCAAXTdgA==
Date:   Sun, 16 Jul 2023 17:11:29 +0000
Message-ID: <1678F63C-DBBB-48FE-B2B9-0C2A5CD5217C@oracle.com>
References: <168934757954.2781502.4228890662497418497.stgit@morisot.1015granger.net>
 <a9f18064-45d4-4346-0156-dcd74e001b82@talpey.com>
 <FF1F6B85-A97D-41A0-B28F-AF7A568EEC68@oracle.com>
In-Reply-To: <FF1F6B85-A97D-41A0-B28F-AF7A568EEC68@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.600.7)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|PH0PR10MB4726:EE_
x-ms-office365-filtering-correlation-id: e155690f-cbf1-44ee-ba9a-08db861fb281
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NeMaE3QhKUMo/pmftrFgrETahIf+q8MSKz8hJI00m4PO9SJ0PM9oWHu7XdYu/gK61Ds/hdX65mCiE4neBENGAa5TrD8UIOYI6OJsL48B8YY7dPLOTZhWD8khyg21afNkXD2f1eYA8MUt2U3h1JHXkM2nVmsqrD6pKZb+dqVv8BCGdSgRbSjs7jnRitJGz5VyyUeYP0ywjbV6K7DB8kW2qWYOcj58XKK0lAxBa8amk9cStpN4PuOLOI/jPUlzomiUzFvTf2BdT9VB1srePedo3kE+LSBFSLAwG7o1C2jaBaQBEooyCWSC70a05LLfYbLhQmegZMzqL5O+WNARxuxhX/vCNUFXEU1ccFig2eFYFvRZqewrLQxX5wvEUfcvgJJ4sSrs5rs5dCq0WDxgc5B2G22zw9BHcxQ0LvgR3Xh2rMPFE5FMVJJTxKlu6lkPm70CsIfGr+11quE67b3AI/qlUDO/oaGMWelgiBCXbkJk5+dJ6JFb0C4ahCPC6AmzKuq4zo7GLtKvOqvPV3yUTLsAOjQhQvek6vbj0b20NdBTbhFjblE+J+lN1vaJRBQp0jwEIXBi87LJwlzvr8W55y2vvn5ZzHPh3qhw0I7gRIr5jYbXmSX7+3EWcxbPxvyPDdU4oU/bWmVhgVDNQftN8uuR9w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(136003)(396003)(346002)(366004)(376002)(451199021)(478600001)(6486002)(91956017)(76116006)(54906003)(71200400001)(36756003)(33656002)(38070700005)(86362001)(2616005)(2906002)(66946007)(5660300002)(53546011)(186003)(6506007)(6512007)(122000001)(316002)(64756008)(8676002)(66446008)(38100700002)(26005)(66476007)(66556008)(4326008)(83380400001)(41300700001)(8936002)(6916009)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?qtKS1FV3OJkTk/tOmT+TzYsRTywEGrAlwpVW6DAqXgs6//B1RUB3BqpV/l5z?=
 =?us-ascii?Q?a4hFBXP55NS/Bcedz+DxPZAciJ6yowGdwW4zu/WnYPsnjelbUfXP5mFj8lf5?=
 =?us-ascii?Q?URb54Q1rKqBS9xeY8Fc/gPelYeZtyXn7SNYvTO7jdaZxf6VcmDw2Xxe6S/GI?=
 =?us-ascii?Q?vHgx3RaCq4iB82anNfI4yJXLCpd3W85NkHceFCuAMvm0qLSIq4+d7CGq1B56?=
 =?us-ascii?Q?qMLjsfeeRDkQqFVGY2BOLEvCulvcsjKmSQc/2hdG2Mv3+IjcWQtWEAF010rx?=
 =?us-ascii?Q?TdEkODnWNgrQwBZk2WUMjJ9kz+cBB9qVw6CrPwuHf6/6CBf3fSr4thMjGWSd?=
 =?us-ascii?Q?RRgLlP9lh8rfeWjCj+FuemJqHM6D2t1WKyF52Y8kcFXQlaYktNwoTurtTJqh?=
 =?us-ascii?Q?XDnc41w0mrEfLlxLdVDxMmlyH68e5rdHmKKczHhWUcWN1kLMklGq2e+Yq0Jw?=
 =?us-ascii?Q?kh29oIxXnIyyVQKmV21yl4bGTRStAv1P1rPeTnFcLDjfHw7gyPFm9CHWBMBO?=
 =?us-ascii?Q?kUNFdZ4V01b45DXWzATN/Yml3maK8iX5j2pO5Jejri+W51NqrtxTrK+tnZXN?=
 =?us-ascii?Q?sf625j5qhMMcxr9yehVfGCepqg5U6wG+FZxWHI7L1em+1xoW9aKdVZTfk9Ie?=
 =?us-ascii?Q?m6E8EyoKQLh2QsVJtq7VKXgq3tWdIjhjr1KmsZsyiZYoWCwcHMNyezDG1yTw?=
 =?us-ascii?Q?pYM0Rmgep7ixATyzLwGu8T7/YEvjLC06lDi1JuuCXOLWINhUzXvV2xVcQj85?=
 =?us-ascii?Q?61084W0V/sA4nr15Xst1N+VxV0LzyfmZRXQ478WnAVpgT41spOGn5L1QfX7v?=
 =?us-ascii?Q?+FqQGg2dPr6Itlz9qP9v+fX6VA++guahxLNm6IRoVlgefOZ/0qRJF13pezNV?=
 =?us-ascii?Q?5OGNkNqYdpwfHIOz7azroga24IJErmh/jSLDeM7z6SiQpeuDG94Kizof9fWr?=
 =?us-ascii?Q?lTBB72Zlh+UTbTs1Q71Q9il6z6XOeNASwEWQR/OBTlZ3GJ7uaXvdWug3QEov?=
 =?us-ascii?Q?yJPSsP5+h4Qt8Ze8UR2AXvz06nD5wkHnKKMXsC12YDYCh3oXyaxJqRDwy6K3?=
 =?us-ascii?Q?5RGfDEpEcCH/qlAkjajcU4EAeE9GcOABkktc2ES87zNzyz11wFtEgXP5EXSm?=
 =?us-ascii?Q?CCpNghPmVv2T6Unw7s0+lizkUa/8tRupvxm/D3UGlY0Y7WiO+Sy2UKIeLdVw?=
 =?us-ascii?Q?/rpezovzewnbLlB067amS9mivt1boIDbyzVJge8AfE18jPkQAGfXCZSg2lXE?=
 =?us-ascii?Q?Aopdcvt4FJh4d+nzGQRr6oNzZajmMgN1T7fqlHdbvhYUDdteF9vJHvdo28Tf?=
 =?us-ascii?Q?BtibUibY5DynIggvyGHHOcLiemBwqyNlBSs4enAuZLmSqMJZPNaDdRSCKeZf?=
 =?us-ascii?Q?r4UIMT81qv8BSdhfIVP+2Dqbuw5aRjj2d5UcFq76veEPVeEuyWgaLbZyrRw7?=
 =?us-ascii?Q?3J8b/NI/sWRaSQ1BmiZk9T2w+SZmzeUirpD3Ruq19khyHGbCPHUn2uKURQmG?=
 =?us-ascii?Q?wzjvhGfxUttC4gugxG4oLKUFEkUxnST7MUZgdlMy98XRucUh2KqeB8Ty+xW+?=
 =?us-ascii?Q?PEWEuIcQJy2+QHA2py48RZsyX93Hhr+Gh/nxq9rInqNlIKg429rb8f76k7v5?=
 =?us-ascii?Q?8Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7EF2BFC827BB3B4CB295B152C4379700@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: WB7Ca4zuRSeSrcvhs/ZUUy5IJDaUZoSYjvlmxMvVrHbJ3QYbOzhP2YSaGNJRgT+OZ0goVA2Dm1svYZ7ZKOlBOtcg6pgwkHQsjJAYfyQj8x0q/la5aPWvbvlZqgv8oxAVmM2GR/KwkOUdlOX6UflDToxldByjTP0OwRx8lyB6rHQ08yIL/T3JvQVyxbv/hUdn42KdPYCcqkIFXMdBTajRw6L0GTbm4mlhYC5Xsv8WNQ4c0Os7PVnU/PrMWU7/u5blE/Jy5xrCPHryJfla1HdGAD73EHEnGUytFf2BuXMq4P04r5HT6K4VnwAH05EAfHzgGeeKFd5Z4jvHcHWRfmB+xIioHO/2QSvr+OV0R7AdL+vaLJ4L1eQ80vUu0BRFvPKvHSE80+x00MZMH4TAwydpffLYQObpn+cRkhvvIkI8xKSs5PAhpEQED3NAJtVb6/XZ9a3Qa0/k0SwtU6ylzC/RU4TEyF0C4/IxhkB2V3ztyCpkus+Oy98FJPlo3pNYQkDv2ONzgsgSTPgYl1itClWiP/ontjUuRhuQmNpRgGveQLfFbONzoHwMvbXawhTHIM60nXY/E5p0kCDCFndYAT9SOs4O9SsqniHcK5zRFklQm9EAqxcfZNys+JDAkViaI4YPcuFEivUru/2bkYVDYwMjZ0x6S9Ot+DvXTiAjXH3Op751Lx41oL4UgVdqMnmm181AAsvQA3IlOsavnry9+Volg9BAIJe5P1Z25ZbKiM3HvU32O8Fu9rH7Kok0GXukbjCUWz8Ek972wSgEGFO+BHnvR8JNJxgbwf6i4xsCMyMC9otg4FbiJrwnQZZpraoZExpi4U5qZOLG7nZWyjl8faiwNE3Vx8DVNfxbFFgqWv0iJrk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e155690f-cbf1-44ee-ba9a-08db861fb281
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jul 2023 17:11:29.9969
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8R0oqQzrjUntmZinqQVuMX2ErgLgR315/xTuFxIdN0BFAY/KPnddNiqrAF0k6uu1WofN+mkwFpX+3lisQmnRoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4726
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-16_04,2023-07-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 phishscore=0
 adultscore=0 spamscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307160163
X-Proofpoint-ORIG-GUID: ighcbo9fo8NYdfgrzAivIr-s7KqkFpuW
X-Proofpoint-GUID: ighcbo9fo8NYdfgrzAivIr-s7KqkFpuW
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jul 15, 2023, at 2:56 PM, Chuck Lever III <chuck.lever@oracle.com> wro=
te:
>=20
>=20
>=20
>> On Jul 15, 2023, at 1:01 PM, Tom Talpey <tom@talpey.com> wrote:
>>=20
>> On 7/14/2023 11:13 AM, Chuck Lever wrote:
>>> From: Chuck Lever <chuck.lever@oracle.com>
>>> On server-initiated disconnect, rpcrdma_xprt_disconnect() DMA-unmaps
>>> the transport's Receive buffers, but rpcrdma_post_recvs() neglected
>>> to remap them after a new connection had been established. The
>>> result is immediate failure of the new connection with the Receives
>>> flushing with LOCAL_PROT_ERR.
>>=20
>> The fix is correct, my only comment is that the failure occurs when the
>> first message is received, and only the first CQE is a LOCAL_PROT_ERR.
>> The remainder of the posted receives are simply flushed.
>>=20
>> Same result of course! The summary is ok as-is. Important fix.
>>=20
>> Reviewed-by: Tom Talpey <tom@talpey.com>
>=20
> Thanks for the look!
>=20
> Anna, when applying this patch, can you replace:
>=20
> "The result is immediate failure of the new connection with the Receives
> flushing with LOCAL_PROT_ERR."
>=20
> with
>=20
> "The result is immediate failure of the new connection with the first
> unmapped Receive completing with LOCAL_PROT_ERR."

Also, please add:

Reported-by: Olga Kornievskaia <kolga@netapp.com>


>>> Fixes: 671c450b6fe0 ("xprtrdma: Fix oops in Receive handler after devic=
e removal")
>>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>>> ---
>>> net/sunrpc/xprtrdma/verbs.c |    9 ++++-----
>>> 1 file changed, 4 insertions(+), 5 deletions(-)
>>> Hi Anna-
>>> Can you apply this for 6.5-rc ?
>>> diff --git a/net/sunrpc/xprtrdma/verbs.c b/net/sunrpc/xprtrdma/verbs.c
>>> index b098fde373ab..28c0771c4e8c 100644
>>> --- a/net/sunrpc/xprtrdma/verbs.c
>>> +++ b/net/sunrpc/xprtrdma/verbs.c
>>> @@ -935,9 +935,6 @@ struct rpcrdma_rep *rpcrdma_rep_create(struct rpcrd=
ma_xprt *r_xprt,
>>>  if (!rep->rr_rdmabuf)
>>>  goto out_free;
>>> - if (!rpcrdma_regbuf_dma_map(r_xprt, rep->rr_rdmabuf))
>>> - goto out_free_regbuf;
>>> -
>>>  rep->rr_cid.ci_completion_id =3D
>>>  atomic_inc_return(&r_xprt->rx_ep->re_completion_ids);
>>> @@ -956,8 +953,6 @@ struct rpcrdma_rep *rpcrdma_rep_create(struct rpcrd=
ma_xprt *r_xprt,
>>>  spin_unlock(&buf->rb_lock);
>>>  return rep;
>>> -out_free_regbuf:
>>> - rpcrdma_regbuf_free(rep->rr_rdmabuf);
>>> out_free:
>>>  kfree(rep);
>>> out:
>>> @@ -1363,6 +1358,10 @@ void rpcrdma_post_recvs(struct rpcrdma_xprt *r_x=
prt, int needed, bool temp)
>>>  rep =3D rpcrdma_rep_create(r_xprt, temp);
>>>  if (!rep)
>>>  break;
>>> + if (!rpcrdma_regbuf_dma_map(r_xprt, rep->rr_rdmabuf)) {
>>> + rpcrdma_rep_put(buf, rep);
>>> + break;
>>> + }
>>>    rep->rr_cid.ci_queue_id =3D ep->re_attr.recv_cq->res.id;
>>>  trace_xprtrdma_post_recv(rep);
>=20
> --
> Chuck Lever


--
Chuck Lever


