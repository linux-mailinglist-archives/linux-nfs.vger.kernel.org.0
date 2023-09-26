Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E623F7AF706
	for <lists+linux-nfs@lfdr.de>; Wed, 27 Sep 2023 02:03:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230494AbjI0ADF (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 26 Sep 2023 20:03:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232617AbjI0ABF (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 26 Sep 2023 20:01:05 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A1B62310B
        for <linux-nfs@vger.kernel.org>; Tue, 26 Sep 2023 15:05:25 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38QKEsLL010401;
        Tue, 26 Sep 2023 21:16:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=6RMoLMyTQv+w76IcbpH1DPtzeuyM0tWGAod8SychJh8=;
 b=b2/CoUSXpXTwEWub9EHfdHTwUkqXLj0TTNAnO2Ads5D43d0+rVR1CAgW2nT//8iswUv6
 8K0S0ZcQgdRwwtXLTQ2hug+K7N72s3CgcuYDDFLAgREQyOqg/wLRSToM3iI1iNsiREby
 crDnggzK6InNV12i4bIlDQHyNDxiAzBv5PuA6uytWYhVH0Mmea0CRLDgb9zUnCjB00ep
 ZEQrbww2FYhgGTPU15cJq8Hot4nG4/Xic2KzpAHr86YHqKCcxHqcXFWlYzSZVlfA9vK3
 sHprrz5T0elRD9wB/fwtEfbtfj5u3PUhEOD/XiysP5xsvhzNji7Bmw5d6kMut/ybR31c PQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t9qwbfw0g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Sep 2023 21:16:51 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38QLAl87039396;
        Tue, 26 Sep 2023 21:16:49 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2042.outbound.protection.outlook.com [104.47.51.42])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3t9pfcw0qw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Sep 2023 21:16:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dc/de7a0TDEDWPfogf2YlASgugUZVXM4CaV3C9G+Dsfu4sg/kiFTvYgkY84izqkX3ZgcJuGu3zENYnsxvD3XbK2PEsGxgT/Z3vCIikHBsF37Wy/B1MCFYIPEgpgbVCL869nItdPnrDYiyRAfdlfreuP4wamu6tGJgNqD8bycdSEGrzVdOPc7XlQKfYVJ3Gixd0+vx+mdqNzA7uXa6SbsVv4n+XtSkqlEGgcM23N5PjpiKn4m07vsK/C2nWAkjDdj6Cna9i1iScxJvW3dc+SJ8/dcsj5kbm9ALtH4Iq8QaKveINvxaq019xotjgLtEWeYqKftdmJ3TxsE60OTKkqttQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6RMoLMyTQv+w76IcbpH1DPtzeuyM0tWGAod8SychJh8=;
 b=JBk0KDZVEX6lKAUvrhmfNdgFpfqyZhe0v371ddYsk8O9fJAJ0JtyxiS5P/K93tXX9m0+EWe7s9sA3el9ilhWB1RaLQujaU1lbJ8flfSVq5Zi8H+o+fx7kDcIDxsngNGLXueqVVvvfxfDIKtwvB6uNO4Y6EeEhyLhAmOGZjWCZRISHpzQJkTCgppw+lb/7nqi0NIrXqi6CDc0AU5euJfbRqCb+LVeEGPeTGNVxe3CmGkoikYijM2pLqmY8tD1m+irbogqwMDbA8ULN8yhXlMRmmhkqCD5qAnh+L3VFBaesIwnJZE4nkqTHOly/Z/HeozA7A4KhQW7fct+7Fus1WJlug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6RMoLMyTQv+w76IcbpH1DPtzeuyM0tWGAod8SychJh8=;
 b=jFXFNZ4EOfPMf5GcsnxWoPco9scwvOxBHduNhN1gp2Ud+7m5EnGbatUdgQPgda+NTcUz1dOUimbWNHKeyJTQ6Aey5Tn9idLTHRbC4DL/F2TRBINNPO+zKKKctUz+ncFjFDrQVAUe1w5i8QKWG6eXSVceJ/+KBeTjDSk5vUO6VlE=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SA1PR10MB5887.namprd10.prod.outlook.com (2603:10b6:806:23e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.21; Tue, 26 Sep
 2023 21:16:48 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::bffc:4f39:2aa8:6144]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::bffc:4f39:2aa8:6144%5]) with mapi id 15.20.6813.027; Tue, 26 Sep 2023
 21:16:47 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Anna Schumaker <anna@kernel.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] SUNRPC/TLS: Lock the lower_xprt during the tls handshake
Thread-Topic: [PATCH] SUNRPC/TLS: Lock the lower_xprt during the tls handshake
Thread-Index: AQHZ8LzoTVxYJWPEq0ycptr1zuk+LLAtm/2A
Date:   Tue, 26 Sep 2023 21:16:47 +0000
Message-ID: <188347CB-B870-4C6B-8E16-4D9C854A5CCC@oracle.com>
References: <20230926210322.184335-1-anna@kernel.org>
In-Reply-To: <20230926210322.184335-1-anna@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.700.6)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|SA1PR10MB5887:EE_
x-ms-office365-filtering-correlation-id: 0067bc6b-1149-421d-9dab-08dbbed5e4d6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dTzmxj0pGGmeLdX2ShJ6OW+uvmWJMRGzX1tK7hYLS6jN21v7OHOpKTAlPw7oAT1oPg1KLwuNCdP+Zo2r/A79rPMkh1ywxOa2pguiA4VQdTZ60NXDiS8NgI0bmyQsephjCerUsT7U/pOWJV+fpq74OZAdI++lWqvMs3jf1ln6pKDWTkUbI/F+0ZwF1KocnRyPPvM3CAGWsbHGCHLZ/R3/sLVh067oOaXtifQrP20RLnM8dwqhq7Pd8pCQegNm7t2BOq2B4DfPtauNB1WBHYmbTLVim4O9W9/oiL8onCdUM+d6bBDpnZMPdddovw4lJfLed9uOwVIRilNVDN6nZ+3DzVs/3YGVR4Bm7A7LZsC74u7EgWuVU7EdV9C0mcn9OhcQCqbXTWhWKIE+Sbzj4l8fPwTFf3suLIs4XHuZro5ztfFwVTqXnSFYrQFkcDIU/wcy2J1BbiJqHqkJEnsKWb9Gb9LzBfJ/lga2KNDEGhmvE6AguiqW0AHyFXZub59PqVW7nFqZf0uhfdag9JuVxdacAJeFSw4HVc8ccScHdQA0gOh+Ns2oy/v+VQnE2nTclthIRM1M9rUbkz/oWdV50ttEcPyNeg8qaifEHgSJrcNU1Sl4XvpVA51H+CzgmyJqnNMcd3zlXTa3my+KCJb2DguMOg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(136003)(376002)(39860400002)(366004)(230922051799003)(186009)(1800799009)(451199024)(36756003)(6916009)(6512007)(6506007)(71200400001)(6486002)(53546011)(2616005)(26005)(66446008)(64756008)(66556008)(478600001)(66946007)(41300700001)(66476007)(38100700002)(122000001)(38070700005)(316002)(5660300002)(83380400001)(91956017)(76116006)(33656002)(86362001)(4326008)(8676002)(8936002)(2906002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?03siqU5ECzxtkVODze0MZf06lqiQPuQf4xUTPFGv05Wo+55QboaN3sS77YX4?=
 =?us-ascii?Q?/9xirrW8m5p2Odl19rqh0UHSYUjm81Mx0QT3Ig5BnTfANfUWG5Jj21PZjEXX?=
 =?us-ascii?Q?Wu03ujtTyA1qz+rNeN6i/Mn9Pxm3oXjt2y0DAvbXTUKhdCDmrhS4UtPQYa/o?=
 =?us-ascii?Q?hNffcpiVs+UcJix5uCiH2K4+S2fA6NEeFXo7K3VZG9DWbuHf3w2IE0Fgstka?=
 =?us-ascii?Q?+peOZRdZVeCkx8U+KR39R6LABWmboSuv3Mqmgn69k8lHSIzu4u5XCaSM+Wza?=
 =?us-ascii?Q?BngdBMH4JNUV5bWUbi4a9/Npt1ngzU0MltqcOMlLVj3hpC85jsiD3areIE4e?=
 =?us-ascii?Q?Jty56fH8Emld4IfupnjXPLzbUn5NhF/poxnxh569AjIcLUB3NT0dCj0WXVbO?=
 =?us-ascii?Q?4EzDvC31xAp1RHN9FkrhPSIL9ICvMEC+57nIyeOrdkvT14FfwWMxWbYyXR0i?=
 =?us-ascii?Q?/EZQlJEDWPjFNb+16DXHsYVnPdXvxugNQNx4ZIkHz9CtxDtRPdyqjr6b0O1U?=
 =?us-ascii?Q?8kEoMNa7RoKdZdW95vlq00dFoVik1mWt5llEEw/9RZOrHe806nlz0Lo7rqMc?=
 =?us-ascii?Q?jCaM2Ew5N/Cpwx59MUlJHSgXBO0LXyRDj0Jba5aTKPdf1SCScjeXyBWyPLpR?=
 =?us-ascii?Q?BlKc2bKH36CT2qOwR/LqXE+660608OuJANryuOjAnSwEWf9LPGWTjr80sjo+?=
 =?us-ascii?Q?7851vJNxg/lQnqGhA2CyRpfkLnOnS+KvXHwJLy7O+k8gDvRnndgkniJtVUyx?=
 =?us-ascii?Q?JaORxvpe/v8/OlT849gHbOcczoZleCJslZ1GeXmZOH9/zYthIA3FvXuJ4sgj?=
 =?us-ascii?Q?4mv9jBFbQBNX0tQ8shfSqxIXovq/GUx5FZPjGZrPReGoxtFtEd0XgvrN9p0x?=
 =?us-ascii?Q?Wy/L3XtEhQQ1bLKzkD0yhOyhFiDCfQ+PEYMUzslcsq+tXZtAJ4IPqoZbjkKo?=
 =?us-ascii?Q?s39g7gwdjec8Q8o6CMhKVVEksF3/M5qHae7gnHQYWOrHtU8K/sAYsgSuWoJ0?=
 =?us-ascii?Q?JaekvAGEvhVkfV3M1aFEooeOrhCv84SFppZDn8x0iy0ux70aa5V3demKIXvT?=
 =?us-ascii?Q?cHTg/7ZctRX957+OVJWRfycwYTdU9U5qs/XMivkPt2e64h615cd6aiHvewPw?=
 =?us-ascii?Q?jyzQawYNcMGpVLqHb1CUsaF0hvltF6tRPqmTA5trhfcinlftYc2m9ll/7WWR?=
 =?us-ascii?Q?NtgDtoPbcyhyuU64pn8XZeyL3Rszo2UsgnwxjKvkLLz3foeSn/cpyWtB7xGX?=
 =?us-ascii?Q?g5WP+SyBYZIWnRpVOIwYNlS37J49n7qMQPI01UWrGVV27powyLEC/7JK/EJG?=
 =?us-ascii?Q?PQBjGsdbdtV+EuSdkh8PxOYLPjx0tl0C0oTpZnbyWvdMHAe+0IgLybIg9cRT?=
 =?us-ascii?Q?D3QCmBz1Xz8SVVW5j09qZ0JnytleGpAHOxJMxMwRXqgqJcG+8akIX8A1oHnU?=
 =?us-ascii?Q?oXJ8LDcJyfRz/Fbll6A3lg71KlGUSMsjtPopdd2ydCKMsbn586T0Tgw6eHw4?=
 =?us-ascii?Q?BNADNUg1NQltuLZTcmy8weMQYcwx6enrkHwKqc1BzUwEQcqx3X8dogP12Rqm?=
 =?us-ascii?Q?hXSsEzXr9vDXjvyrF6O7poj7ugioOatoGijC48lyIg2pxuuIMuW4gLJZoDeg?=
 =?us-ascii?Q?lA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <CDE12B5531BF8543BE3AA74A2CFD3339@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Ci7VfHLeeP9RAgGscmtMc7l+R3ELQXimqW6Uz/SJx+bxnx488p3fzFlXwVfUYlV1d9xqdpOiK7Kjfge8YyC77ef/8ZCxqDVugDAGS11qjAk9DvAKI4NBpy8pUlrT3swxoIqOiFbXUcP7BXzJ6qUqzi4Lo/XYF/9IgvGLB9QMKw3irh5jaq4qGXObPETLhNsPTkPlvB+7/2vz58zYscgiO+BIPn0WyPR7DrI3BqPxz6Var+YAHOoEnn/i7rQCpi9a8mIBZ5a+Hao1A32fdFo/dSlbL1DjVAoog0KNbBJLrajndgQ+ySW2p3Z0zCVc5oJowjVypJ1oqLuCgRgOd/mUZgKztK3J/fskWinJGyzIUhloFZqrlfnxxdrL9nVxLb7CTQwCn0g38EUChY+8eXiee4iF4KngGszHPA04roHbfeouBjVv7HHESD3nUnv8hQdEbIE9m3WzL17C/836yEonaLo3CIxiSJZz+9xgsonwz4eq8ydT1j4OdQpFULcRB3EHk87AS8P3PW+CvxVjXPSlEnOtJaBubHUP0aELMQJCZJmlkgYglpOiiv9v4FS/9tqT6yhaYbdO3MUHau1Sz4Pt4//wIJG2bwugSHTis/qKYfsXxGZm+0MFQ9LzUvkaqp6GvcaF4QTIrt2WsPiQaTHyYNG996RVH/DqawrbOVhlEqkNbdAQr6zMk/5RgznWLweFVp3RX0SUmz2sLk6vfqOZJkeCAH2gDKTPNcuqs4Ilm4L1wy1GK+XAj7t5no3PPAe7iowAIm4FWD3R2v7TmKVhjFG+UwI0HoBNBmw/eDOD+AQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0067bc6b-1149-421d-9dab-08dbbed5e4d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2023 21:16:47.9034
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rgIRPmJgK4E3UzQYo0qh1QMF55lKfB8Nh1ds42Ipb1YoSAX/LRKN9BDReyR4HNbJUknvCH0KryzMCngT8t/8Ig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB5887
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-26_15,2023-09-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 suspectscore=0 adultscore=0 phishscore=0 mlxscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2309260181
X-Proofpoint-GUID: UqnBd4zg8qbKoib1sgoX7F9Pw_h5749o
X-Proofpoint-ORIG-GUID: UqnBd4zg8qbKoib1sgoX7F9Pw_h5749o
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Sep 26, 2023, at 5:03 PM, Anna Schumaker <anna@kernel.org> wrote:
>=20
> From: Anna Schumaker <Anna.Schumaker@Netapp.com>
>=20
> Otherwise we run the risk of having the lower_xprt freed from underneath
> us, causing an oops that looks like this:
>=20
> [  224.150698] BUG: kernel NULL pointer dereference, address: 00000000000=
00018
> [  224.150951] #PF: supervisor read access in kernel mode
> [  224.151117] #PF: error_code(0x0000) - not-present page
> [  224.151278] PGD 0 P4D 0
> [  224.151361] Oops: 0000 [#1] PREEMPT SMP NOPTI
> [  224.151499] CPU: 2 PID: 99 Comm: kworker/u10:6 Not tainted 6.6.0-rc3-g=
6465e260f487 #41264 a00b0960990fb7bc6d6a330ee03588b67f08a47b
> [  224.151977] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS u=
nknown 2/2/2022
> [  224.152216] Workqueue: xprtiod xs_tcp_tls_setup_socket [sunrpc]
> [  224.152434] RIP: 0010:xs_tcp_tls_setup_socket+0x3cc/0x7e0 [sunrpc]
> [  224.152643] Code: 00 00 48 8b 7c 24 08 e9 f3 01 00 00 48 83 7b c0 00 0=
f 85 d2 01 00 00 49 8d 84 24 f8 05 00 00 48 89 44 24 10 48 8b 00 48 89 c5 <=
4c> 8b 68 18 66 41 83 3f 0a 75 71 45 31 ff 4c 89 ef 31 f6 e8 5c 76
> [  224.153246] RSP: 0018:ffffb00ec060fd18 EFLAGS: 00010246
> [  224.153427] RAX: 0000000000000000 RBX: ffff8c06c2e53e40 RCX: 000000000=
0000001
> [  224.153652] RDX: ffff8c073bca2408 RSI: 0000000000000282 RDI: ffff8c06c=
259ee00
> [  224.153868] RBP: 0000000000000000 R08: ffffffff9da55aa0 R09: 000000000=
0000001
> [  224.154084] R10: 00000034306c30f1 R11: 0000000000000002 R12: ffff8c06c=
2e51800
> [  224.154300] R13: ffff8c06c355d400 R14: 0000000004208160 R15: ffff8c06c=
2e53820
> [  224.154521] FS:  0000000000000000(0000) GS:ffff8c073bd00000(0000) knlG=
S:0000000000000000
> [  224.154763] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  224.154940] CR2: 0000000000000018 CR3: 0000000062c1e000 CR4: 000000000=
0750ee0
> [  224.155157] PKRU: 55555554
> [  224.155244] Call Trace:
> [  224.155325]  <TASK>
> [  224.155395]  ? __die_body+0x68/0xb0
> [  224.155507]  ? page_fault_oops+0x34c/0x3a0
> [  224.155635]  ? _raw_spin_unlock_irqrestore+0xe/0x40
> [  224.155793]  ? exc_page_fault+0x7a/0x1b0
> [  224.155916]  ? asm_exc_page_fault+0x26/0x30
> [  224.156047]  ? xs_tcp_tls_setup_socket+0x3cc/0x7e0 [sunrpc ae3a15912ae=
37fd51dafbdbc2dbd069117f8f5c8]
> [  224.156367]  ? xs_tcp_tls_setup_socket+0x2fe/0x7e0 [sunrpc ae3a15912ae=
37fd51dafbdbc2dbd069117f8f5c8]
> [  224.156697]  ? __pfx_xs_tls_handshake_done+0x10/0x10 [sunrpc ae3a15912=
ae37fd51dafbdbc2dbd069117f8f5c8]
> [  224.157013]  process_scheduled_works+0x24e/0x450
> [  224.157158]  worker_thread+0x21c/0x2d0
> [  224.157275]  ? __pfx_worker_thread+0x10/0x10
> [  224.157409]  kthread+0xe8/0x110
> [  224.157510]  ? __pfx_kthread+0x10/0x10
> [  224.157628]  ret_from_fork+0x37/0x50
> [  224.157741]  ? __pfx_kthread+0x10/0x10
> [  224.157859]  ret_from_fork_asm+0x1b/0x30
> [  224.157983]  </TASK>
>=20
> Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>

I don't have any quibbles with this. Thanks!

Reviewed-by: Chuck Lever <chuck.lever@oracle.com <mailto:chuck.lever@oracle=
.com>>


> ---
> net/sunrpc/xprtsock.c | 6 ++++++
> 1 file changed, 6 insertions(+)
>=20
> diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
> index 71cd916e384f..a15bf2ede89b 100644
> --- a/net/sunrpc/xprtsock.c
> +++ b/net/sunrpc/xprtsock.c
> @@ -2672,6 +2672,10 @@ static void xs_tcp_tls_setup_socket(struct work_st=
ruct *work)
> rcu_read_lock();
> lower_xprt =3D rcu_dereference(lower_clnt->cl_xprt);
> rcu_read_unlock();
> +
> + if (wait_on_bit_lock(&lower_xprt->state, XPRT_LOCKED, TASK_KILLABLE))
> + goto out_unlock;
> +
> status =3D xs_tls_handshake_sync(lower_xprt, &upper_xprt->xprtsec);
> if (status) {
> trace_rpc_tls_not_started(upper_clnt, upper_xprt);
> @@ -2681,6 +2685,7 @@ static void xs_tcp_tls_setup_socket(struct work_str=
uct *work)
> status =3D xs_tcp_tls_finish_connecting(lower_xprt, upper_transport);
> if (status)
> goto out_close;
> + xprt_release_write(lower_xprt, NULL);
>=20
> trace_rpc_socket_connect(upper_xprt, upper_transport->sock, 0);
> if (!xprt_test_and_set_connected(upper_xprt)) {
> @@ -2702,6 +2707,7 @@ static void xs_tcp_tls_setup_socket(struct work_str=
uct *work)
> return;
>=20
> out_close:
> + xprt_release_write(lower_xprt, NULL);
> rpc_shutdown_client(lower_clnt);
>=20
> /* xprt_force_disconnect() wakes tasks with a fixed tk_status code.
> --=20
> 2.42.0
>=20

--
Chuck Lever


