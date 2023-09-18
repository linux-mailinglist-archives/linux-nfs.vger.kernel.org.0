Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 572FB7A51EE
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Sep 2023 20:22:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229501AbjIRSXA (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 18 Sep 2023 14:23:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjIRSW7 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 18 Sep 2023 14:22:59 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09A7DFB
        for <linux-nfs@vger.kernel.org>; Mon, 18 Sep 2023 11:22:54 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38IHxMMd013048;
        Mon, 18 Sep 2023 18:22:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=0gdL5SlnNE2H60KQvezU1quny/uSGG1JdINlpRMf57Q=;
 b=v0Za5sxND2/ik6w6GBao84KDRcQbfpnCUQrvTt0isMVPfUrN49gsHomnveSFzH3xg/RT
 RDZoD+wGSWpzP9ZDMAilb33QBLuKZFUYwCzGq3JOhvGy+4jiReIKkOTHyax1rJJK4k8k
 evsruyyxhJzk5FnouPyGuc48SwHG3Un94mI7ojOkudwyMuNFRc414PDdQxhdAXEs51SX
 uGTKPkdpqBm5zPSNNsxyUZRpOeYf6/lfQ97uD3mP3c9/Rri1moBssZ80bU/AQ9HbRADC
 hN/s6fh51+TeJIyoj6qWMNz8KR6Uj3gga4Vqg4JDpFWN41YCDmcyUkconFa5MuNtuhK1 Ww== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t539ck964-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 18 Sep 2023 18:22:50 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38IHZtoT012033;
        Mon, 18 Sep 2023 18:22:48 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2106.outbound.protection.outlook.com [104.47.55.106])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3t52t4vj47-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 18 Sep 2023 18:22:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UtuwYZ2NJuZ/cnl08hZWd9qv52OYnzbq8pGKcr5cPzPCb07+266iHcFF2QQ9fPUzHKuKp6QXcLrp7PjYAowA6cDq1SKZDs6jpowhlAjf6vz2GeegaSGA/LdeMU/2/4AAp2DUs1vyB/SU/srXflKewR64LSvd31t70ABtUt5XqySKvLbChZ3Ue9pcROau9tk8hYHzuOrF88NScbT0Jjpuuz7Ctw/89k2i3ftGH1Pz+2Bv4g8+AM3C0lKJn+1VtGtnAOAFx+pQft4UZmhHQRCWiT1lSsCNsD3ecltlVGTkcefYD8HsFHPNPdUvoE+V2/lZkjLFEGtpuoagUpo/GJ0ftw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0gdL5SlnNE2H60KQvezU1quny/uSGG1JdINlpRMf57Q=;
 b=gkyYtZmpRGHfb8prjkfmVw5xWky2P2kTnWawmLMaNwHO6Y6+B7+PHyTou6sEIDH6MIrZGeg46msqkdqqVsRuWvPTH8J8alcjFwlF13NnIW8quNy+t6INPOFeOsfxfmYOVH8g9HrA7hBfBTxlcH8oOT2RfsjX4dY/2RGmz1ih/uf+6Kf10RT4BwLYKwiakuBx1noP/wxoGwdW+Ct0a1X/LIdBqUfF38wFrbP9lUjqOt8aLN1P3Jkd/FAKOx3HDxJhUqK9YI9D+AiMBF+oysqlbuuvuQ+Iqhs9FIXdCqG4S7bUv3By9hCnQI9mGHFCR05rwECIeDovcW32gz5zYkLFGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0gdL5SlnNE2H60KQvezU1quny/uSGG1JdINlpRMf57Q=;
 b=riw4olBE9cxFdNuwAkeczABQHIfSadxMc6RZgtGVr7B9opllSQG2YHUcsjO4zTJ2GmMfMZptobH6o4+9NL5Z6Gxp1yy0W6H7ntIYGX1dS98e9NbsRIEIMG0yvRHZEFt7bWxCK03w8og/MpMsAe6uN6I+Qv9gykyOmubfAMw8wpc=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH3PR10MB7610.namprd10.prod.outlook.com (2603:10b6:610:171::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.26; Mon, 18 Sep
 2023 18:22:46 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::bffc:4f39:2aa8:6144]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::bffc:4f39:2aa8:6144%4]) with mapi id 15.20.6792.026; Mon, 18 Sep 2023
 18:22:46 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Anna Schumaker <anna.schumaker@netapp.com>
CC:     Trond Myklebust <trondmy@hammerspace.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v2] SUNRPC: Fail quickly when server does not recognize
 TLS
Thread-Topic: [PATCH v2] SUNRPC: Fail quickly when server does not recognize
 TLS
Thread-Index: AQHZ4P2F9j++Z9A6/kC/pa1eWMwKZrAg+DaA
Date:   Mon, 18 Sep 2023 18:22:46 +0000
Message-ID: <AA691FE9-5183-4912-BB0A-32E86629D7B1@oracle.com>
References: <169403069468.5590.10798268439536368989.stgit@oracle-102.nfsv4bat.org>
In-Reply-To: <169403069468.5590.10798268439536368989.stgit@oracle-102.nfsv4bat.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.700.6)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|CH3PR10MB7610:EE_
x-ms-office365-filtering-correlation-id: 68e0840a-6b5a-46f0-a193-08dbb87441dc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: x3EpA3M1U6Ke2LfzWH0XkJA301QUkvgdGXZ80BgbPuC4pugbKtUMXKSQsZyMjWmco4cZsehdQ4SRJm7jJm9nfNGNyPA9+hkoTEb7ci6I378zLRS1U/XL4AbJgN9TgTiAtyFmxPUbHmP/+kf2lzaAv9wcIUXCdKyRr5DGLQHrh53N3lolg/dSvdDOyqX8V6jNX+ifJjMBGcyJ0h+zCOLs6wGVu/X6WuG2OP5UGkGal8W+8aN2qrF5SOj1kt9dC6KtO61IJ5EIt46YIXRnJ/thCKDSZRKN/V6ORWn+PUYQRvKCF8BjNheudpQhSdvtlZqEchFaLNwiXFbe2QjsIK+KtHCr4kLtabrjHL/4BAJyLyfWHhLiE36EvFEZ9hSrYPXda77mS0NhwydDEPCXjT5hyKrsram3qgSqoWYnnTSuyEMKjBJNX7B1VxlxKJD0+0aakR8Vz4k/bGuALomm4SntSxc3gF20/a1OJwCAXqhlOqqQkQShNWTQNWB/cl8aG8PWfydm3yObraPB2EubpiSkgVuiOvS/6O54dunGgte3pW2MZ17K7GR/M1T7WYDrltw9gXDLwFw7q8bkrVlSJ7Y4TVWkAAo5lNzaOIHvZTm3NaqC3gOtpEkvEmfr4MXFjPrv50t5hwGd++nBa4G3exemvg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(366004)(396003)(346002)(39860400002)(1800799009)(451199024)(186009)(2906002)(8676002)(4326008)(8936002)(41300700001)(5660300002)(6916009)(66446008)(54906003)(66556008)(66476007)(64756008)(76116006)(91956017)(316002)(66946007)(478600001)(6486002)(122000001)(36756003)(6506007)(6512007)(83380400001)(26005)(2616005)(71200400001)(53546011)(38070700005)(38100700002)(33656002)(86362001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?hj57WBek9e4SUxSwmrmhz1hb2pkj69MkauCy/1lgXROwCJ3Uj94Ot5eGMx/2?=
 =?us-ascii?Q?wroop9OUxvI7rwWrK/52C13SuXpRA0kZYOtvu2FIXWVucpl2ForAVKxbiyEy?=
 =?us-ascii?Q?ucMzwvZDIxKzexaJDYdG4vfgGCshZfzqpoANQiwrcvPzSiXnOVntvJMuTw5G?=
 =?us-ascii?Q?QV07E/HQD0lnl+MoVfe1SOhnrbGUoamA5zy9kgH6UMmlOeZvvur6pEuzcbZr?=
 =?us-ascii?Q?427xlWI2F5MrO+ECUvJKFbDGErAL2jkL3KQzYN14YkXdTyNhCZ1bAZC//xEn?=
 =?us-ascii?Q?5sZ3G+EqFMcz+obtsFZE5gCKS1lZ0jYL7nPU+TTZ8HdyOCbeYa66+2X9yiBe?=
 =?us-ascii?Q?vGh+ONqWrDSNLi3jzrBootqIZH72VwY0gUtYXJ8etcWs+C+t3ig5koJVne3v?=
 =?us-ascii?Q?vMewJHPDqTxVs31XhBsIysqatYlPa19tn5+YGCgPiC6XrPwN7bL7AHOslAgv?=
 =?us-ascii?Q?pL1+knD0XU9nB4K+lhDAWPEr/nDC5s9kh6XT9CauFJUyLMpysXrMFDfmfO+2?=
 =?us-ascii?Q?Q3SRl1h7bBFrexHC3O/SqcmST2v+Tbk4FSfyhI9Q0MRCtqEkLEGjXpeYV5ti?=
 =?us-ascii?Q?CBHASckDdQpPYw3Y89RKAxNGMOgdoE/zBmqiXZwXkkFdJINyVttouRNJKzRe?=
 =?us-ascii?Q?5plErZFeotrKMiqyrqpWQvXi6jH052lUfBI1rA0y9yAWGUy2AmG61y7c/VF5?=
 =?us-ascii?Q?ANEkcw7BMBcAFGCaxIpuzXQmtmGfgbsJhwhPk3Ge69v1R2Va7260jIVdr95U?=
 =?us-ascii?Q?KPHNGsJiP9vioCfEZcTf8/FTECN5Z6AglawZrfgO2WYr+m9fyBZln/OwP8yn?=
 =?us-ascii?Q?7ae2sY5d3D14zYIrn7uh5zur0Wm9lATuAIyT0RCU0LdgumwhSCkGOCFZIVT6?=
 =?us-ascii?Q?o/VjqX8MYJfy9r/6brZn5Yz1ELFI69sbhkBtZRrjVurluEdwSwe/xlFG5SJq?=
 =?us-ascii?Q?7jJaN1NVW1ePwRsuxeJRW9xzYllJ2lRlf1KGNQ2m7iWhSgfj4tJEuOxqfaH2?=
 =?us-ascii?Q?dkHBFKnqm2zFV/PlGcx7OLI+eZ4P3Fo9sQc0eaHSgNwBrhChnQdHB7yXB27k?=
 =?us-ascii?Q?dbQGhcj4VMVTiaKwUoRoF9jH0evZy3U7u1jDtxpne/SJ3sn4EBfQqZUY2c+W?=
 =?us-ascii?Q?1n1cj5/H+4iPO1X9tk4I+/OHFvYXXwV0Z/UiJun+JzUaEpT6w0i9FjOdkAXC?=
 =?us-ascii?Q?usgq2ECUDP1QdWHJSC3lyPPHsPKyUewdwhcfpCqOiX6kmnxRzUcQDL4/gE++?=
 =?us-ascii?Q?Juj5r2PHOz3sMbHMNwEbg6/Tu6UAmMcs/6nuexITOZvP0rwsbF5Cpr17+PzD?=
 =?us-ascii?Q?fQypwAOgMkdYo54EwAJqYm0O2icLpKLk9i1Yyf/UDG888Ut8EGCdd3JSmRK9?=
 =?us-ascii?Q?ngcvRTvKg08NxZgZM/cdi9TP5hSGhNCHrVUcr2UzIsSdIdzS5W3wh6696r9w?=
 =?us-ascii?Q?Jd23pnNkHSfUahNJgkmzA0Xo7TmT0bFKdKSzLZxItEX5/zK8lXlx+9gSU7C3?=
 =?us-ascii?Q?4bz9OKAwh6CN/IdcJi8r0aJLRfhtqbjZt5N3TYUcwggVjrdPo+DGoqNZL93+?=
 =?us-ascii?Q?qdbq9ST9nxgK/El9MtyX5q3RfaLygFvLTnf78YHOa2PhiSj8Jo7KWDKhtCTB?=
 =?us-ascii?Q?SQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9C1045AB778F9448990CA21EBD493ABD@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: khBP/DDnUbmrOWq8EbQ/zwyLS/qazujidV5swS9PILD3F1yADOqbBqYcheG10q/PyMTCe+Y4vtRoz1LgHqFw3ZaZVY6Skg6YUcoQp+W9QlT0QXNJOikDCirCJcnd0RfS7yVesREKPK7kWuyj0PlSFF24Iy8nhdcBMKNDDcmopC/YbyWAVOBGLrj6R7TVnlQRsifxTsDC5LUP/3HihPMDwoVmN2mpRo58/TmWIslJVeJ9lpITanCLB0z9mCKop9AtNQcOdZ1WFTs02fGt1f3RY5kousT52AOXUhjONed+XGFxEHTQnb+w4ardGaxPCYA/SkJdPUDyi3m4GQ/aW3nOk/kAzlw8BynsheCUF3UABsdCFchVJMKsQwrIlGwaafWa+FuWmoSLID3ld//FFMlVlVqfV0sjInUJqwQ84f9pMF1l3020KWW9UcaddWxo7CJ1of3ijXdD44DtyJTmC4XP2/YEVdETBcj8O8ZqmVHvK76ok5qpdL4i0B6lyhppXlU8OOCJag9OYsdu86KEnNOBj2sCxYoDtXi7joZFL6v4aFfFu+Lx1ay2++7jmYtMq1/47XEIkJMeNqDN0kMmvzruBp8aIEGL7aEqHM8dSWC18oBS+4int2ykaSF0amIIR/n27N1Bm9pQFGg4VSwrTcq/dtkaZABMGPkiHRf3wkabdNEqdpkNYCQmWkJxV7ZHoJJLIZ4A4GXSGL/++gJA10Y3Mi7FKzZS8Ei202m+9uid/9GRtJJarX7hVwFewvF/WMM42GRrqdcKxEHzLp3DWm5qLMI7VjF3nEenYAiYrG0aGVmCVhT/Xci+GVWoMBAdXivP/ySCUgnDKWS6YRNn8v7h8A==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68e0840a-6b5a-46f0-a193-08dbb87441dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2023 18:22:46.3567
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cWQ9TW2rNFhITUKL/y3P3y2vBv0L8CKt3Vgq/GwkdnAczEaWVjZ7xCczPe8tT+STQixHgiHD1u/A0Y5dV597PQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7610
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-18_08,2023-09-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 malwarescore=0
 adultscore=0 suspectscore=0 spamscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309180161
X-Proofpoint-ORIG-GUID: 7-KB0wRsNpIxJf9C44phcPP2FwxqqXsU
X-Proofpoint-GUID: 7-KB0wRsNpIxJf9C44phcPP2FwxqqXsU
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Sep 6, 2023, at 4:05 PM, Chuck Lever <cel@kernel.org> wrote:
>=20
> From: Chuck Lever <chuck.lever@oracle.com>
>=20
> rpcauth_checkverf() should return a distinct error code when a
> server recognizes the AUTH_TLS probe but does not support TLS so
> that the client's header decoder can respond appropriately and
> quickly. No retries are necessary is in this case, since the server
> has already affirmatively answered "TLS is unsupported".
>=20
> Suggested-by: Trond Myklebust <trondmy@hammerspace.com>
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
> net/sunrpc/auth.c     |   11 ++++++++---
> net/sunrpc/auth_tls.c |    4 ++--
> net/sunrpc/clnt.c     |   10 +++++++++-
> 3 files changed, 19 insertions(+), 6 deletions(-)
>=20
> This must be applied after 'Revert "SUNRPC: Fail faster on bad verifier"'
>=20
> Changes since RFC:
> - Basic testing has been done
> - Added an explicit check for a zero-length verifier string

Hi Anna, was this patch rejected?


> diff --git a/net/sunrpc/auth.c b/net/sunrpc/auth.c
> index 2f16f9d17966..814b0169f972 100644
> --- a/net/sunrpc/auth.c
> +++ b/net/sunrpc/auth.c
> @@ -769,9 +769,14 @@ int rpcauth_wrap_req(struct rpc_task *task, struct x=
dr_stream *xdr)
>  * @task: controlling RPC task
>  * @xdr: xdr_stream containing RPC Reply header
>  *
> - * On success, @xdr is updated to point past the verifier and
> - * zero is returned. Otherwise, @xdr is in an undefined state
> - * and a negative errno is returned.
> + * Return values:
> + *   %0: Verifier is valid. @xdr now points past the verifier.
> + *   %-EIO: Verifier is corrupted or message ended early.
> + *   %-EACCES: Verifier is intact but not valid.
> + *   %-EPROTONOSUPPORT: Server does not support the requested auth type.
> + *
> + * When a negative errno is returned, @xdr is left in an undefined
> + * state.
>  */
> int
> rpcauth_checkverf(struct rpc_task *task, struct xdr_stream *xdr)
> diff --git a/net/sunrpc/auth_tls.c b/net/sunrpc/auth_tls.c
> index de7678f8a23d..87f570fd3b00 100644
> --- a/net/sunrpc/auth_tls.c
> +++ b/net/sunrpc/auth_tls.c
> @@ -129,9 +129,9 @@ static int tls_validate(struct rpc_task *task, struct=
 xdr_stream *xdr)
> if (*p !=3D rpc_auth_null)
> return -EIO;
> if (xdr_stream_decode_opaque_inline(xdr, &str, starttls_len) !=3D starttl=
s_len)
> - return -EIO;
> + return -EPROTONOSUPPORT;
> if (memcmp(str, starttls_token, starttls_len))
> - return -EIO;
> + return -EPROTONOSUPPORT;
> return 0;
> }
>=20
> diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
> index 315bd59dea05..80ee97fb0bf2 100644
> --- a/net/sunrpc/clnt.c
> +++ b/net/sunrpc/clnt.c
> @@ -2722,7 +2722,15 @@ rpc_decode_header(struct rpc_task *task, struct xd=
r_stream *xdr)
>=20
> out_verifier:
> trace_rpc_bad_verifier(task);
> - goto out_garbage;
> + switch (error) {
> + case -EPROTONOSUPPORT:
> + goto out_err;
> + case -EACCES:
> + /* Re-encode with a fresh cred */
> + fallthrough;
> + default:
> + goto out_garbage;
> + }
>=20
> out_msg_denied:
> error =3D -EACCES;
>=20
>=20

--
Chuck Lever


