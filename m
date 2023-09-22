Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0F077AB724
	for <lists+linux-nfs@lfdr.de>; Fri, 22 Sep 2023 19:23:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231589AbjIVRXa (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 22 Sep 2023 13:23:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231976AbjIVRX3 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 22 Sep 2023 13:23:29 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2FDF1A1;
        Fri, 22 Sep 2023 10:23:22 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38MGOCf9004678;
        Fri, 22 Sep 2023 17:23:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=cxa/yOy07tIMi2Ppbx99jVQps1mUKbE8QK9Na7G49Io=;
 b=LTKOK2EdfMmodUW1Ew9LX9s0Tt/4E/C7dPQLVg+CpzYLf71BK0WSUXU3FgbdCnaHXqOD
 cB3SEAUxFCK4Wi4Q3GvCmm8OdtQnyAH7cXRkj8wNDB4WyMLuR0fTFMJIiM5YgbplXKEz
 83eh7hZNTyQUXk/gnOFrR/5b0lQYj/h1mYnFi6XlVXeDUgXgk6pMiOT/xcRP/4WnzxSS
 HFhpL9um181MKPstR27gi4WGDgCNd5P3ezI5WKbvDa0tixGm06Y+XiNKbaMVRhU2Cem8
 K37byHzWCwBFSMTaeILKAno0q0BEIhpSASKJW90PX98YCRw5REuZfNt0VjZxhTXK4173 tA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t8tsxtaxe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Sep 2023 17:23:12 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38MH0RW8021318;
        Fri, 22 Sep 2023 17:23:12 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3t92vxnpvj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Sep 2023 17:23:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WHWKniEMm+XF9UuybbIRxRk8L34WmMiG6wNQG+sXc2lPFzIEKy+YqZYw3P7Ybm8dw7Uw6ZOHiHACb+WUEsF0sgXpEK118Qc44r/RpyjOBHCfVuHayx6+7Gsf6wZA7JWw/dhdVUHnhDnTA4s0pxWVAr9UsIp6imo83aAT8vHdOxwSw5OvevqdS1Vmprpj9dZ/NpAQxz+jo+av1blT1zgUtq2qM7g9/pzH0ZI5hyWoWXypUez4i65N2N/g/vLchcRAAr+W9rnJVPkpg4mdQQe4KlCHar1CHOdrKOTXxJ5/yxkVMmX096rECz4lGi/kT4WHhL+Eq5ieKKlnq1kHDWJBUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cxa/yOy07tIMi2Ppbx99jVQps1mUKbE8QK9Na7G49Io=;
 b=NsRII4GkgumINz3QyJnRFS+j0naFM2s04cTt4+0oDQh6RV31EzcTUKO0zU8bnJK4d//AQhyzDDSXjyQ9FLPnUx8mWZWFuXU3YhEp47MxM2tg0WTCBMYcuU4+/Hl4hBqkG21YTtHYAYpj1Wda+NeAvOytpmqOUktF9U3kCsxT5wmQsfReESk2VTenhZjGKDAajngEQ3X5shDb3VgUuaFT63QuiJq8dK/ZGOi9Zjr6WVM7vKsZIwTdPnXyZlT21NkVXPPiRX93XpLPOepGY0XwA520tdP2PoJhxNaWt1bNFXqhDBb2scN963PoygQVN7urTesNfYFJ1ZIPoDfZB35oKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cxa/yOy07tIMi2Ppbx99jVQps1mUKbE8QK9Na7G49Io=;
 b=yJIk3YdJ3BlLtc+dSF9qc5yok8SwvGst+U3J7yp4etw527gK+Vzz0sZZF1besuXB9cZsxFbamnJ/mp/y8lVZxEkZ8Pcx0yESToaAhWbhNEgt1WR+d3l9InvVZfRzyhsYJQevlrjDVbBk62N9yO3A2huSZqiKiCiwHBGTdf6HbBQ=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MW4PR10MB6510.namprd10.prod.outlook.com (2603:10b6:303:224::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.34; Fri, 22 Sep
 2023 17:23:03 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::bffc:4f39:2aa8:6144]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::bffc:4f39:2aa8:6144%5]) with mapi id 15.20.6813.017; Fri, 22 Sep 2023
 17:23:02 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
CC:     Jeff Layton <jlayton@kernel.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Neil Brown <neilb@suse.de>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH] NFSD: convert write_threads and write_v4_end_grace to
 netlink commands
Thread-Topic: [PATCH] NFSD: convert write_threads and write_v4_end_grace to
 netlink commands
Thread-Index: AQHZ7VKfQ7YihRKqAEKLYXScgapUUbAnAk0AgAAAkQCAAAQSAIAAAL8AgAAQgQA=
Date:   Fri, 22 Sep 2023 17:23:02 +0000
Message-ID: <E8ACAD24-BA69-4112-AB75-4AC99461DE6D@oracle.com>
References: <b7985d6f0708d4a2836e1b488d641cdc11ace61b.1695386483.git.lorenzo@kernel.org>
 <cc6341a7c5f09b731298236b260c9dfd94a811d8.camel@kernel.org>
 <ADA8068B-B289-4210-9E28-E69F4EBB9355@oracle.com>
 <c81b598c24df25cc1f797b8c18340d610fb58f00.camel@kernel.org>
 <ZQ2/lGSbiNv5zn+Y@lore-desk>
In-Reply-To: <ZQ2/lGSbiNv5zn+Y@lore-desk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.700.6)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|MW4PR10MB6510:EE_
x-ms-office365-filtering-correlation-id: 8e37f709-a05c-4961-a0c9-08dbbb909388
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aIFoIFrf25rNUxUHnp35SKUKOOwl90W11PkHNqVkKn8ethuiZ0PW2IXtGvp2IPq6/JCTpDOxbGCsei6IkbfJSQxidKEJh1utzNSMv6S4r2MpjfGRkQXew0t0gjX1B28zhKh/I9Wz6OApsFgbAkWcRRC/iLi1utRxqmoVeEfoY7xnHfU5zlt+QEgPFUpv/74hn+lQ5baLFWPmOdv3uNoUPm1jS/Mbj4NABCvHSTKAhon1TyWkVOSgm7dc1RikZgdSxf7Twcj/DGNgkosQ8c4ZmkoXIdn3xAAZoQXtcWwGGr/tst55Q7gNDepASUjwX541PaqIc6zkUeEskjHdrlXdpyUSTvPAEFQMMGzbU65GaykVqSPjurXBDAEFP2MsFNDhblswugC47oaBkZ/SRR/yuVWBVrK/uBqBRkCGvPDADGMVJCuVj9HM/gvdz5tAYxiM69Pl+vRmhFhtU8wWVP5mcX6GDRLKfTwMiH1zS4fZu81UL3I+nv9sZTJW3w2/ZrHQpEBve29ftPkGlFUM8gvMZSqPuo3umy/pYLHQL1kTasr2JIGFN6lKHlRMoTStXE7MoU2aOY+RT64gZ38F/+hZvHS9g43J/r9EPRshuSeG5YQKqVXR+yAHVXPLGLQkndB8sQOkFVBgLeGEkdb7cep7qg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(39860400002)(366004)(346002)(136003)(186009)(1800799009)(451199024)(6486002)(966005)(71200400001)(478600001)(76116006)(91956017)(6506007)(2616005)(53546011)(6512007)(83380400001)(26005)(30864003)(33656002)(4326008)(8936002)(8676002)(66556008)(316002)(66446008)(54906003)(64756008)(5660300002)(6916009)(66476007)(41300700001)(2906002)(36756003)(66946007)(86362001)(38070700005)(122000001)(38100700002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?a/vUSP51txzawOvuZdDHfHYggdyBKzp5/u760lYzuFvAji2+k94HdmJ5oQMr?=
 =?us-ascii?Q?RKkfImXaa5oQH2Iiqk02hKKHLYYQUHsBqiLO4DlQ7ZuO58hvMIm9ZPtmyH7a?=
 =?us-ascii?Q?ReejHP6pi0sRStwQrD5w7QnGTzPcojrpJGOuq3Z3E+CXjjXh2ZLaxAwU/Hc1?=
 =?us-ascii?Q?Ptqs9WF5ExKh1H3VLB8tP1RMNHodoUFgCTn5mvGTgRFy0kpBO6DPcKaBGNK0?=
 =?us-ascii?Q?Xo0s2Mw8G61dGtkurgRK1Mt+6yxUwoaOrQcLZmHmc+f9GxFKzyeIl/aQfzOg?=
 =?us-ascii?Q?7yBn7H6rnr1SV5l3DOozGVYoBkEH7CYs9xeGUHcpTpNhXBYoNmkCfQYD7Xs9?=
 =?us-ascii?Q?RiKKN62yemwK6+jW/UIZcVFnNPUZjXEHA7AkOzbzxgr0QH4fTjwyQ5wUYerJ?=
 =?us-ascii?Q?ZrlBcLjwPzCOePnW8SzbG9Clm6goRzw9MHtxIkD9dwcH9doD4NB4sD39D7OJ?=
 =?us-ascii?Q?DWGg4YS3foK4c6Ptw+6WmovO90a6Uv4puNQhFUmAwBsHllZQDlmX6ORi1yAc?=
 =?us-ascii?Q?RUCpshRc88oRHOh02Yd27HA41i0Hih9rLl3Kl5+agLwC0oriTS0HREvvz6ex?=
 =?us-ascii?Q?tZcMkotPMebTseTZ27VffkSRRzJanIRWFVbv0FPXjXSbUD5CC4TKgWjJxch2?=
 =?us-ascii?Q?NQiTrb/AjgJ4n9rlMCNuHftpDKZUo0dgliQscKN3XPtKAuZw5m7ZXJkjOZEX?=
 =?us-ascii?Q?wwegZk+QkwcH9yzIy+jEnTIZkuVUSVZEUIfY65/j1O6TTKwzXd2Ixo2OTuey?=
 =?us-ascii?Q?uowWUDxtZ9lCvr5SCZdiJnENfdVWKSzgvJ82EjEW5pYJLQJoDWrwYh7GHN2i?=
 =?us-ascii?Q?qMR1MBPWB/70e22Vmh987BZWn3HOyyxoipOQyw/6QOorJqWNy//UTkPywoiE?=
 =?us-ascii?Q?pkHoFioQlRwQ2z6xv2uYtBxuwitBd/0GtQVixjCC8mw2z3jHmqJrzkNecTqn?=
 =?us-ascii?Q?Bltd2ikAqhFTAk3tSgAvzPxuG9gLKTLDDUTgxuq1jFVUiL7CQaQ7nXWn6AdH?=
 =?us-ascii?Q?D8I2nhUhhI3/7xIVBjcdxH5L9xdwn8cSU3Um7Mcbb0PECCMyw9OLer8X3xvZ?=
 =?us-ascii?Q?AW0kmisAEAzJS8mj8EmIvNG0IFtqoc1Sfw4nEti4wGijvUwovQ2vBAIOLV2u?=
 =?us-ascii?Q?MVY2DnVYexGgbavR7yzcKanFkwEGItE/aXQdaXCYDXNty8HOHH0zXFkQkL2t?=
 =?us-ascii?Q?ilTiKXYOMLPmc+U+aEpCQnCbdYtZqrlvM2lXRKwvg7IFXf4XpqP9cyVdxSc6?=
 =?us-ascii?Q?AyiTabQpGEOz8I5umJEY1AvKCIHxEudGkTcc0Oo6HFUlLspnjK3o9p8SJ2E5?=
 =?us-ascii?Q?hYKKznEveG23ZsJiP9m605vJTFWxhq4hPh8aOauW7lUHtuNITYq/84K2nm8h?=
 =?us-ascii?Q?Bn3KUhWaBKVjHt2lcLA6rD8CuSype07Nxjw0lwioioEzKNdqR98jP0f2b3Qk?=
 =?us-ascii?Q?caMEiFe2rMm+U36Xw/ArNcP8zOPU24vStogyliIRSREyHg4Y7bqgJGGcyJ4w?=
 =?us-ascii?Q?sAGF2nQ/6S5oVb1Wmf663JZIq5VIIxOPSkfRx/sZgeclXF3SLl6IBPY/IF4h?=
 =?us-ascii?Q?iV8Psvy1QMrFlh2ZyVVu4NxptI7bCcqwuOKVhcHg7VLZFPY2WGJP6trM+vzx?=
 =?us-ascii?Q?HA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <FE2F9827D0A42D498A9899DD3B16A14B@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Tw5PPhLtcFyA1tPLcJEdL2bopJHTI34PCrm42qSbtgtx9EYYyTXvyT3Ra512kvhXEKhb7Aon8B5Jkp2WXf29VglWLycU/QduPgEffaJPuKEh9ZXYQPHQ651pQtNo57i/6fFgx2NYmb9WCMODdo4y8DOTie8+ymzZoGpMr35UyIg4YxhpI5q40VgB4LKrGZAexRawbbJcEYdwYi6hMZkI5lpNuVkDILRWmKDyPc5kTK5enPehpGGPvvIC/4LUeUviPqAJvWLgUbL3EI3+cUXGb8UHF+6vLBwOkR5qom/H6q2BWz4KfGm2L4+kM4Iger76btq1eSbxIjcSdKc0UrpH192MmppkOZQ5pAzrMHTJOcn3hhXrDScObVvjMGHuLiGLFqHWIkeMv+M+a9Kor8Xakx+Tf8zF7ntpruJbMTzD2D1kONH/henl1jGtEWk2c2KiksCU6fQjY081A99JEIkKMvV2DZzRKC8f/WDQJk8wcWHndZrOpYf/r/+SCN19IKY862hfP0F+Z6kVfc01qymuaV5kLapGlJ4z7wGP64Ohmq3G9GCEeOAmXoODpc7M2Yi9Wqa2QO/tDGebddM1z46RmGvzt9fU44BnK/5nIApTDpCfJpS9aG3O2eLATOBKJSIoJFj67AWGtRXVIX0s88SQkdD42HN8+R4kbNKjOr/eMU3smk9YTLbfUpZVf7lxK8Y29ZhuRA9f1FgMSpcFJHeooNoM2LE/QUVM+Cfz8Zwj3SmjVS96Awkgq0xN9IypMHICXHsKxMygFjjYxvY52A/qPJTFDxFs1VV/Wrbt+/QTgz2e0ZkwVhdfrk7cSxNr78/uwSsca0itvxSrIgmXqQppQQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e37f709-a05c-4961-a0c9-08dbbb909388
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2023 17:23:02.7551
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: izj7JwT7hjBrqDL9/tjtkpNtTFB0YgfU7wBDMOMO3uKr/qcAEd/7vQ1Ild36iLkhRLFAsJCS0CpBzYuVg0Casg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6510
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-22_16,2023-09-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 mlxscore=0 suspectscore=0 adultscore=0 phishscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2309220149
X-Proofpoint-ORIG-GUID: lIhB_5-nEZf0p1ZN9LxLnH-mk8ERt0pz
X-Proofpoint-GUID: lIhB_5-nEZf0p1ZN9LxLnH-mk8ERt0pz
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Sep 22, 2023, at 12:23 PM, Lorenzo Bianconi <lorenzo.bianconi@redhat.c=
om> wrote:
>=20
>> On Fri, 2023-09-22 at 16:06 +0000, Chuck Lever III wrote:
>>>=20
>>>> On Sep 22, 2023, at 12:04 PM, Jeff Layton <jlayton@kernel.org> wrote:
>>>>=20
>>>> On Fri, 2023-09-22 at 14:44 +0200, Lorenzo Bianconi wrote:
>>>>> Introduce write_threads and write_v4_end_grace netlink commands simil=
ar
>>>>> to the ones available through the procfs.
>>>>> Introduce nfsd_nl_server_status_get_dumpit netlink command in order t=
o
>>>>> report global server metadata.
>>>>>=20
>>>>> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
>>>>> ---
>>>>> This patch can be tested with user-space tool reported below:
>>>>> https://github.com/LorenzoBianconi/nfsd-netlink.git
>>>>> ---
>>>>> Documentation/netlink/specs/nfsd.yaml | 33 +++++++++
>>>>> fs/nfsd/netlink.c                     | 30 ++++++++
>>>>> fs/nfsd/netlink.h                     |  5 ++
>>>>> fs/nfsd/nfsctl.c                      | 98 ++++++++++++++++++++++++++=
+
>>>>> include/uapi/linux/nfsd_netlink.h     | 11 +++
>>>>> 5 files changed, 177 insertions(+)
>>>>>=20
>>>>> diff --git a/Documentation/netlink/specs/nfsd.yaml b/Documentation/ne=
tlink/specs/nfsd.yaml
>>>>> index 403d3e3a04f3..fa1204892703 100644
>>>>> --- a/Documentation/netlink/specs/nfsd.yaml
>>>>> +++ b/Documentation/netlink/specs/nfsd.yaml
>>>>> @@ -62,6 +62,15 @@ attribute-sets:
>>>>>        name: compound-ops
>>>>>        type: u32
>>>>>        multi-attr: true
>>>>> +  -
>>>>> +    name: server-attr
>>>>> +    attributes:
>>>>> +      -
>>>>> +        name: threads
>>>>> +        type: u16
>>>>=20
>>>> 65k threads ought to be enough for anybody!
>>>=20
>>> No argument.
>>>=20
>>> But I thought you could echo a negative number of threads in /proc/fs/n=
fsd/threads
>>> to reduce the thread count. Maybe this field should be an s32?
>>>=20
>>=20
>> Yuck! I think I'd rather see this implemented as a declarative field.
>>=20
>> Let's have this specify an explicit number of threads with 0 meaning
>> shutdown. If someone wants to reduce the number, they can do the math in
>> userland. That also jives better with the SERVICE_STATUS_GET...
>=20
> ack, I agree.

The positive / negative value is actually nailed into some of the
thread infrastructure. Changing that might be more of schlep.

I'm curious how Neil feels about this.


> Regards,
> Lorenzo
>=20
>>=20
>>>=20
>>>>> +      -
>>>>> +        name: v4-grace
>>>>> +        type: u8
>>>>>=20
>>>>> operations:
>>>>>  list:
>>>>> @@ -72,3 +81,27 @@ operations:
>>>>>      dump:
>>>>>        pre: nfsd-nl-rpc-status-get-start
>>>>>        post: nfsd-nl-rpc-status-get-done
>>>>> +    -
>>>>> +      name: threads-set
>>>>> +      doc: set the number of running threads
>>>>> +      attribute-set: server-attr
>>>>> +      flags: [ admin-perm ]
>>>>> +      do:
>>>>> +        request:
>>>>> +          attributes:
>>>>> +            - threads
>>>>> +    -
>>>>> +      name: v4-grace-release
>>>>> +      doc: release the grace period for nfsd's v4 lock manager
>>>>> +      attribute-set: server-attr
>>>>> +      flags: [ admin-perm ]
>>>>> +      do:
>>>>> +        request:
>>>>> +          attributes:
>>>>> +            - v4-grace
>>>>> +    -
>>>>> +      name: server-status-get
>>>>> +      doc: dump server status info
>>>>> +      attribute-set: server-attr
>>>>> +      dump:
>>>>> +        pre: nfsd-nl-server-status-get-start
>>>>> diff --git a/fs/nfsd/netlink.c b/fs/nfsd/netlink.c
>>>>> index 0e1d635ec5f9..783a34e69354 100644
>>>>> --- a/fs/nfsd/netlink.c
>>>>> +++ b/fs/nfsd/netlink.c
>>>>> @@ -10,6 +10,16 @@
>>>>>=20
>>>>> #include <uapi/linux/nfsd_netlink.h>
>>>>>=20
>>>>> +/* NFSD_CMD_THREADS_SET - do */
>>>>> +static const struct nla_policy nfsd_threads_set_nl_policy[NFSD_A_SER=
VER_ATTR_THREADS + 1] =3D {
>>>>> + [NFSD_A_SERVER_ATTR_THREADS] =3D { .type =3D NLA_U16, },
>>>>> +};
>>>>> +
>>>>> +/* NFSD_CMD_V4_GRACE_RELEASE - do */
>>>>> +static const struct nla_policy nfsd_v4_grace_release_nl_policy[NFSD_=
A_SERVER_ATTR_V4_GRACE + 1] =3D {
>>>>> + [NFSD_A_SERVER_ATTR_V4_GRACE] =3D { .type =3D NLA_U8, },
>>>>> +};
>>>>> +
>>>>> /* Ops table for nfsd */
>>>>> static const struct genl_split_ops nfsd_nl_ops[] =3D {
>>>>> {
>>>>> @@ -19,6 +29,26 @@ static const struct genl_split_ops nfsd_nl_ops[] =
=3D {
>>>>> .done =3D nfsd_nl_rpc_status_get_done,
>>>>> .flags =3D GENL_CMD_CAP_DUMP,
>>>>> },
>>>>> + {
>>>>> + .cmd =3D NFSD_CMD_THREADS_SET,
>>>>> + .doit =3D nfsd_nl_threads_set_doit,
>>>>> + .policy =3D nfsd_threads_set_nl_policy,
>>>>> + .maxattr =3D NFSD_A_SERVER_ATTR_THREADS,
>>>>> + .flags =3D GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
>>>>> + },
>>>>> + {
>>>>> + .cmd =3D NFSD_CMD_V4_GRACE_RELEASE,
>>>>> + .doit =3D nfsd_nl_v4_grace_release_doit,
>>>>> + .policy =3D nfsd_v4_grace_release_nl_policy,
>>>>> + .maxattr =3D NFSD_A_SERVER_ATTR_V4_GRACE,
>>>>> + .flags =3D GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
>>>>> + },
>>>>> + {
>>>>> + .cmd =3D NFSD_CMD_SERVER_STATUS_GET,
>>>>> + .start =3D nfsd_nl_server_status_get_start,
>>>>> + .dumpit =3D nfsd_nl_server_status_get_dumpit,
>>>>> + .flags =3D GENL_CMD_CAP_DUMP,
>>>>> + },
>>>>> };
>>>>>=20
>>>>> struct genl_family nfsd_nl_family __ro_after_init =3D {
>>>>> diff --git a/fs/nfsd/netlink.h b/fs/nfsd/netlink.h
>>>>> index d83dd6bdee92..2e98061fbb0a 100644
>>>>> --- a/fs/nfsd/netlink.h
>>>>> +++ b/fs/nfsd/netlink.h
>>>>> @@ -12,10 +12,15 @@
>>>>> #include <uapi/linux/nfsd_netlink.h>
>>>>>=20
>>>>> int nfsd_nl_rpc_status_get_start(struct netlink_callback *cb);
>>>>> +int nfsd_nl_server_status_get_start(struct netlink_callback *cb);
>>>>> int nfsd_nl_rpc_status_get_done(struct netlink_callback *cb);
>>>>>=20
>>>>> int nfsd_nl_rpc_status_get_dumpit(struct sk_buff *skb,
>>>>>  struct netlink_callback *cb);
>>>>> +int nfsd_nl_threads_set_doit(struct sk_buff *skb, struct genl_info *=
info);
>>>>> +int nfsd_nl_v4_grace_release_doit(struct sk_buff *skb, struct genl_i=
nfo *info);
>>>>> +int nfsd_nl_server_status_get_dumpit(struct sk_buff *skb,
>>>>> +      struct netlink_callback *cb);
>>>>>=20
>>>>> extern struct genl_family nfsd_nl_family;
>>>>>=20
>>>>> diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
>>>>> index b71744e355a8..c631b59b7a4f 100644
>>>>> --- a/fs/nfsd/nfsctl.c
>>>>> +++ b/fs/nfsd/nfsctl.c
>>>>> @@ -1694,6 +1694,104 @@ int nfsd_nl_rpc_status_get_done(struct netlin=
k_callback *cb)
>>>>> return 0;
>>>>> }
>>>>>=20
>>>>> +/**
>>>>> + * nfsd_nl_threads_set_doit - set the number of running threads
>>>>> + * @skb: reply buffer
>>>>> + * @info: netlink metadata and command arguments
>>>>> + *
>>>>> + * Return 0 on success or a negative errno.
>>>>> + */
>>>>> +int nfsd_nl_threads_set_doit(struct sk_buff *skb, struct genl_info *=
info)
>>>>> +{
>>>>> + u16 nthreads;
>>>>> + int ret;
>>>>> +
>>>>> + if (!info->attrs[NFSD_A_SERVER_ATTR_THREADS])
>>>>> + return -EINVAL;
>>>>> +
>>>>> + nthreads =3D nla_get_u16(info->attrs[NFSD_A_SERVER_ATTR_THREADS]);
>>>>> +
>>>>> + ret =3D nfsd_svc(nthreads, genl_info_net(info), get_current_cred())=
;
>>>>> + return ret =3D=3D nthreads ? 0 : ret;
>>>>> +}
>>>>> +
>>>>> +/**
>>>>> + * nfsd_nl_v4_grace_release_doit - release the nfs4 grace period
>>>>> + * @skb: reply buffer
>>>>> + * @info: netlink metadata and command arguments
>>>>> + *
>>>>> + * Return 0 on success or a negative errno.
>>>>> + */
>>>>> +int nfsd_nl_v4_grace_release_doit(struct sk_buff *skb, struct genl_i=
nfo *info)
>>>>> +{
>>>>> +#ifdef CONFIG_NFSD_V4
>>>>> + struct nfsd_net *nn =3D net_generic(genl_info_net(info), nfsd_net_i=
d);
>>>>> +
>>>>> + if (!info->attrs[NFSD_A_SERVER_ATTR_V4_GRACE])
>>>>> + return -EINVAL;
>>>>> +
>>>>> + if (nla_get_u8(info->attrs[NFSD_A_SERVER_ATTR_V4_GRACE]))
>>>>> + nfsd4_end_grace(nn);
>>>>> +
>>>>=20
>>>> To be clear here. Issuing this with anything but 0 will end the grace
>>>> period. A value of 0 is ignored. It might be best to make the value no=
t
>>>> matter at all. Do we have to send down a value at all?
>>>>=20
>>>>> + return 0;
>>>>> +#else
>>>>> + return -EOPNOTSUPP;
>>>>> +#endif /* CONFIG_NFSD_V4 */
>>>>> +}
>>>>> +
>>>>> +/**
>>>>> + * nfsd_nl_server_status_get_start - Prepare server_status_get dumpi=
t
>>>>> + * @cb: netlink metadata and command arguments
>>>>> + *
>>>>> + * Return values:
>>>>> + *   %0: The server_status_get command may proceed
>>>>> + *   %-ENODEV: There is no NFSD running in this namespace
>>>>> + */
>>>>> +int nfsd_nl_server_status_get_start(struct netlink_callback *cb)
>>>>> +{
>>>>> + struct nfsd_net *nn =3D net_generic(sock_net(cb->skb->sk), nfsd_net=
_id);
>>>>> +
>>>>> + return nn->nfsd_serv ? 0 : -ENODEV;
>>>>> +}
>>>>> +
>>>>> +/**
>>>>> + * nfsd_nl_server_status_get_dumpit - dump server status info
>>>>> + * @skb: reply buffer
>>>>> + * @cb: netlink metadata and command arguments
>>>>> + *
>>>>> + * Returns the size of the reply or a negative errno.
>>>>> + */
>>>>> +int nfsd_nl_server_status_get_dumpit(struct sk_buff *skb,
>>>>> +      struct netlink_callback *cb)
>>>>> +{
>>>>> + struct net *net =3D sock_net(skb->sk);
>>>>> +#ifdef CONFIG_NFSD_V4
>>>>> + struct nfsd_net *nn =3D net_generic(net, nfsd_net_id);
>>>>> +#endif /* CONFIG_NFSD_V4 */
>>>>> + void *hdr;
>>>>> +
>>>>> + if (cb->args[0]) /* already consumed */
>>>>> + return 0;
>>>>> +
>>>>> + hdr =3D genlmsg_put(skb, NETLINK_CB(cb->skb).portid, cb->nlh->nlmsg=
_seq,
>>>>> +   &nfsd_nl_family, NLM_F_MULTI,
>>>>> +   NFSD_CMD_SERVER_STATUS_GET);
>>>>> + if (!hdr)
>>>>> + return -ENOBUFS;
>>>>> +
>>>>> + if (nla_put_u16(skb, NFSD_A_SERVER_ATTR_THREADS, nfsd_nrthreads(net=
)))
>>>>> + return -ENOBUFS;
>>>>> +#ifdef CONFIG_NFSD_V4
>>>>> + if (nla_put_u8(skb, NFSD_A_SERVER_ATTR_V4_GRACE, !nn->grace_ended))
>>>>> + return -ENOBUFS;
>>>>> +#endif /* CONFIG_NFSD_V4 */
>>>>> +
>>>>> + genlmsg_end(skb, hdr);
>>>>> + cb->args[0] =3D 1;
>>>>> +
>>>>> + return skb->len;
>>>>> +}
>>>>> +
>>>>> /**
>>>>> * nfsd_net_init - Prepare the nfsd_net portion of a new net namespace
>>>>> * @net: a freshly-created network namespace
>>>>> diff --git a/include/uapi/linux/nfsd_netlink.h b/include/uapi/linux/n=
fsd_netlink.h
>>>>> index c8ae72466ee6..b82fbc53d336 100644
>>>>> --- a/include/uapi/linux/nfsd_netlink.h
>>>>> +++ b/include/uapi/linux/nfsd_netlink.h
>>>>> @@ -29,8 +29,19 @@ enum {
>>>>> NFSD_A_RPC_STATUS_MAX =3D (__NFSD_A_RPC_STATUS_MAX - 1)
>>>>> };
>>>>>=20
>>>>> +enum {
>>>>> + NFSD_A_SERVER_ATTR_THREADS =3D 1,
>>>>> + NFSD_A_SERVER_ATTR_V4_GRACE,
>>>>> +
>>>>> + __NFSD_A_SERVER_ATTR_MAX,
>>>>> + NFSD_A_SERVER_ATTR_MAX =3D (__NFSD_A_SERVER_ATTR_MAX - 1)
>>>>> +};
>>>>> +
>>>>> enum {
>>>>> NFSD_CMD_RPC_STATUS_GET =3D 1,
>>>>> + NFSD_CMD_THREADS_SET,
>>>>> + NFSD_CMD_V4_GRACE_RELEASE,
>>>>> + NFSD_CMD_SERVER_STATUS_GET,
>>>>>=20
>>>>> __NFSD_CMD_MAX,
>>>>> NFSD_CMD_MAX =3D (__NFSD_CMD_MAX - 1)
>>>>=20
>>>> --=20
>>>> Jeff Layton <jlayton@kernel.org>
>>>=20
>>>=20
>>> --
>>> Chuck Lever
>>>=20
>>>=20
>>=20
>> --=20
>> Jeff Layton <jlayton@kernel.org>
>>=20

--
Chuck Lever


