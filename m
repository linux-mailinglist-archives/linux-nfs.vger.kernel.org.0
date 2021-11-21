Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADF1D458624
	for <lists+linux-nfs@lfdr.de>; Sun, 21 Nov 2021 20:34:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230114AbhKUThS (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 21 Nov 2021 14:37:18 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:52794 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229640AbhKUThR (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 21 Nov 2021 14:37:17 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1ALH0Y1g020876;
        Sun, 21 Nov 2021 19:33:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=uhPbLQVdps1mqo/Jf/jZrahxuw5f/O+wrsfvlPJms70=;
 b=MJ3o6GMzxGzl33DupI8T3y9QBVjJmScthVaTjgRvqDAzzm1q1PHCdOu3BYirqBZBk+aU
 cDgbgsAws6aqG4UqwqjHYFf+P0u1zoHhSngNyev3IR7ATfMpg1+tVmBHQ6xjYP8wiGte
 2O56U/LQ9TvexkNIKBRYt1K7nz1gy3pTjeM1PrF8KyLm+xX2Aq7J6i1zJMazMv0Bs39v
 t7lOXvH9xK0c8IcgWNYKTKMzd9hyGa25QekZoinPM6lX5/9b51C3WblunIqgl/GMBhMH
 GHsTOMw49kumDSzR1Cu7C5zg99FYgYqAzdftE9CJtxgUq8Q1MwlkcXOUv1hCtlC2oPrg wg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cerwamhnj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 21 Nov 2021 19:33:49 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1ALJUfJw112446;
        Sun, 21 Nov 2021 19:33:48 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2177.outbound.protection.outlook.com [104.47.57.177])
        by aserp3030.oracle.com with ESMTP id 3ceq2bqp12-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 21 Nov 2021 19:33:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YRX6SG1iuYGLaO1e+eh18G6RH2tDrrqP2WuZbVDlcBieOB5Vpp8+Of88Cqc4UsFRfvOjNVBpn/Satmfm2cKREIC19CbhvXSknDOZrm+iaMmGMKv74NNxHO/7RKXNVwGorLCiLUyAHJSYAs3krOwDYrSu9hohwt7P6gNGkogmpHMPRewXU2DxSPaZgl8Gnx+B4C8qS57nhMuH61ANDpubilhPHzklkTJ84AGaxnDWpKstePe4EO4v6VYgsuND7ox5AJQW7ptsQQo994I4l/LJ38FHxJhjcK300Z3bxtzQFAZ2j3hUu9eNebLYDCAMPdZSyp+sisC3snCPxPr4ylna1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uhPbLQVdps1mqo/Jf/jZrahxuw5f/O+wrsfvlPJms70=;
 b=A+ClWMDeiYO/i22wViDTyJrSy5xCgfJL0eVBaGmJTYzfAQ+oHq26RYbUVXjphFYgeUBzbFo/nEfmhuEDfUJ4thc4G+rcZYBDvSG5i/RDimWebsivRDEbIjpIzxPDTOT3pD8K1HfaayofNDFnDeZ1ppq0juBUWivUfOs1fZ7uu/THY0iB8SAnY3QW9c5oT5HQryH4A9UE+KyBUGJvZ+ig6zT6a6bVKMP64ZyRA6pKd9arrRClpYfSbpMI6xRsyKosPjDkPOoS/r5APVX7/RtB21hMD92LFJfVR1wr/fwEciZLGr+3RzeHDUBkHNe5yxXSjOPuBeyFJnEbq/Tfni8zmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uhPbLQVdps1mqo/Jf/jZrahxuw5f/O+wrsfvlPJms70=;
 b=vdKlATnT3sMIHRLZf73yOH8XXU6sH7+tT1PV8cL1nFyQXycXP/o0X11up6RKQJnjY7B0fUpPZd4cOluen22jp+MjShhwpJ75QdR+56w3NfPvcRcb6L+0y47HCsFYgt55Z4kQgzphy0QSmlWPRg34sx4Zwx6zIkAy87/nnJ+UADI=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BY5PR10MB4306.namprd10.prod.outlook.com (2603:10b6:a03:211::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19; Sun, 21 Nov
 2021 19:33:46 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::48f2:bb64:cb4b:372f]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::48f2:bb64:cb4b:372f%7]) with mapi id 15.20.4713.024; Sun, 21 Nov 2021
 19:33:46 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Thiago Rafael Becker <trbecker@gmail.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH] sunrpc: fix header include guard in trace header
Thread-Topic: [PATCH] sunrpc: fix header include guard in trace header
Thread-Index: AQHX27bL5lmeex1EeUSEkS6ieDKULKwOZfeA
Date:   Sun, 21 Nov 2021 19:33:46 +0000
Message-ID: <3209AFD1-006E-48E6-A3BF-59C76ED6A17E@oracle.com>
References: <20211117132630.2837733-1-trbecker@gmail.com>
In-Reply-To: <20211117132630.2837733-1-trbecker@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f137e103-a3f1-4c15-8a36-08d9ad25d5c1
x-ms-traffictypediagnostic: BY5PR10MB4306:
x-microsoft-antispam-prvs: <BY5PR10MB4306A9DF4F15670F432201C4939E9@BY5PR10MB4306.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2803;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1nXn9db6q+RUTTfx08ILQiSqAEfJYWwhmqyoDKiPG4AnyUvL5ftVINlcbC89aAFM223i2DXuksTwKtPSQQbjcb+ZDpNenowvbEEUqYHQYoI4SNnGYqej9x8qhbB7EpZoMDPPTB2AwHO0dFFGKInq2i2GebUPgTcFZXVu8Cw2BP4exO8tBQAOJjlL4lp0VG9A4Zzp9OkUbef0YEZzzcjAbMUZ6gnDI92HIQWBmzoHU+7oKXtAWOpE8gUzAKl0p6MgvioHqYqRds66X1rnuDqtr0QozIy+DnDxpl7Ihe06GAt5/BLMtsSew9lLyoGcOCr+km10VNpIapkS0AsIcEM0obeofHZNO+mRdah5k3luHbX9hZD8ujTCteokdWwO3QR1KqYrm6jBQ0vb84D2napjbP1NZdhpyJrnR0RSxxiL7IU1J8Nwb+DuzLPx7cy6KkS0PEC0WNwbVeG0CvhBCl7am8yKlyJ1Z9XO37CszYzp7UFoqtN3VgYFjG5YBkTW2hYWPIUCt5xugEP+RK4LPLeQg2k4KU7ahQFOKsmDtZyX0EbjrAbF4YPVcjJPnm6u1H/NEBIfXBtLSecGhztPkskSrqajJXGaUJoHgFdkpiKkg/ykKcA+tH3d4coQny40u1jBir4OFZQy7hDpPLxG/fABkI+1Qldgm038XCO8Lk8V2DPF184a//7azPHXlDs0oVGvIvfoyCa3vhlzcSTeTb6WwWuexX+33pUmkgvBqKYZ+1Cx5VmltZ1ZdHOG9fSlNOgF
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66946007)(66556008)(6486002)(36756003)(38100700002)(64756008)(110136005)(71200400001)(4744005)(66476007)(53546011)(6506007)(122000001)(8676002)(5660300002)(186003)(76116006)(86362001)(91956017)(8936002)(66446008)(4326008)(26005)(6512007)(508600001)(316002)(54906003)(2616005)(83380400001)(38070700005)(2906002)(33656002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?xlCny6JX7Mbn/FsqCWGa3xpnaslLXmV/vGv2c8a/xg2Kr8YV+c7Y3NDhnYBU?=
 =?us-ascii?Q?FFdHA9NIJ5THEkFtoGboU47LtM2d+wjAVhDkriAVOaObSA1IIjshBIuWZGEh?=
 =?us-ascii?Q?zk5F6cbmZesKil0BFEpdiBLfKYVMaskLwLyhr6qd+UGwddczSpRrm9qDi6ME?=
 =?us-ascii?Q?RTu45hrIvTP6OpktJufI66sMmUePB17vKZDEXJIaa8lSYSfXeh0z7rF4OhWt?=
 =?us-ascii?Q?1pI5HgvO9XODM6KCyN5eR0H2J9watGib24Y2i69O1/7l4T6S7FnnnOW/bE0n?=
 =?us-ascii?Q?E9vqeC7fdOI7L0KlGJC73qPj92Lh0rAR/mbYOAJf2Upl6gUQeQ+jPC8h/Svm?=
 =?us-ascii?Q?PFXzA+EQOhDOFCUYWp2VfWB2aUhV+CojpqX7sgtbpj9Mfxkah0pRfUCMxZEn?=
 =?us-ascii?Q?YP+f1GGdSC86HE155E8eHTSIoHyONAzNLi5gZ2RchcLTLEzwsbM3UKdPzAZE?=
 =?us-ascii?Q?SCMD0LwTVxGKsb+hubql2/PSf7c+E2FCn6/HBox0KVp0ZMiaCyasuBkLuuVT?=
 =?us-ascii?Q?AoFIzT+Q12yleiJr/mhnoJOG1yRCsLpjTmHPQePqi/toPM7HojKff2z5d4W3?=
 =?us-ascii?Q?TrDhzlWykD1R1k0RD2oiiaNVEBNFZujey2R42htoaZsZnb4nN3hfIlkw3Z5f?=
 =?us-ascii?Q?+2YTGDs2SMwLKAbcN7+2n2TUizKYZMt7KjLrkYvSJ0eSqrVHw0JcqkTZhcf2?=
 =?us-ascii?Q?ImMkrRXbNn8cI/GSKw67uXPsdZ4Ohk2/IJKfZVu8R6W1KP0I/RaFQU+sR76r?=
 =?us-ascii?Q?SRdNxnw5oryMxumdVOlra34SvzGeEMfcGLAu+xMVhm9cnVP50Qu8RuH1wifg?=
 =?us-ascii?Q?ZU87cBwlG9SIljBaKfwMjfkgq9GZ+HACvu81ip9QxWUMxoUKVkR+lN5Y640i?=
 =?us-ascii?Q?bvZ8FUeXuqABChdixyhjkjyxp4fGw9cSMlQhz1ZcXlObH9ruuomSiRdRIS46?=
 =?us-ascii?Q?SA04srIVaUqveV632bGeRo6/JRS5grVkF6LJT2BoJ8R1Bve9nDEmumZrvFsb?=
 =?us-ascii?Q?WPjphqHqEFrkHCZDSgQzbLXaXwJGJ6Yg6YA+XzImH2VaMldJzN6r9Y+CgVml?=
 =?us-ascii?Q?kibY17Won/kfOoBzzlKYau3BLIXratsSeAjDZW24Xn1I47/xPBs13hcSPbSO?=
 =?us-ascii?Q?VJcQiZ/6Jnz4qNS/fA7BXuEfchrJaZE35/B8A4XJhp2Qe0FN0LCCHWasoMB0?=
 =?us-ascii?Q?Ng56gL7C0ipCx7Cnn17JXrc9MAd5MzHTwS5fTzCPNnjpi5SvWkZLo6E0xrS4?=
 =?us-ascii?Q?TqTbaIybiRyB/RMIPvvphnP7TNhbfw6N607QmXtwmmhgt4ITvigCMhsFXGUr?=
 =?us-ascii?Q?cYW2fCRtDuV5aFuWjauAvu2vKk7kKUz3ByMtk12MF/VeDOBy+MwoQtBkQ/ew?=
 =?us-ascii?Q?UQZ2VdeC2UHdYfOTZXjnaJ3exhPliQpXGqzdhMS7NwRpcKFWShPnIpdwXniZ?=
 =?us-ascii?Q?lOZSTwdCK32JrWdPji5JMYhE74HFTGayYiGQaH8HaWXs8/glvgXvleqws5B3?=
 =?us-ascii?Q?RZ2os1fJwbBTWBPJkbw07F/Shla+UefIyHmznXm5SqnmzqYzeAbVwgmG2z+A?=
 =?us-ascii?Q?yT7cGwgnYHLoHljqrt9mknFVVlICSeTMSmAk+JdPG/rMNPfMNLeh5WhFy7C8?=
 =?us-ascii?Q?LweMs/wpdfdO29dazFJw2EQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1881E8F4E47268429AC3BC916A91918B@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f137e103-a3f1-4c15-8a36-08d9ad25d5c1
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2021 19:33:46.0276
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KMxpoAkwhLrR8QNMK3nDEw1J7QqamArMjztLUR4+GCmXsvoiMy+WCUtGrCJiSijTijf64frNsklXVed+QSnP1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4306
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10175 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0 spamscore=0
 bulkscore=0 suspectscore=0 mlxscore=0 mlxlogscore=987 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111210121
X-Proofpoint-ORIG-GUID: xENOC9oMMAkJ69OfnczeyqlMMAmp9mps
X-Proofpoint-GUID: xENOC9oMMAkJ69OfnczeyqlMMAmp9mps
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Nov 17, 2021, at 8:26 AM, Thiago Rafael Becker <trbecker@gmail.com> wr=
ote:
>=20
> rpcgss.h include protection was protecting against the define for
> rpcrdma.h.
>=20
> Signed-off-by: Thiago Rafael Becker <trbecker@gmail.com>
> ---
> include/trace/events/rpcgss.h | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/include/trace/events/rpcgss.h b/include/trace/events/rpcgss.=
h
> index 3ba63319af3c..c9048f3e471b 100644
> --- a/include/trace/events/rpcgss.h
> +++ b/include/trace/events/rpcgss.h
> @@ -8,7 +8,7 @@
> #undef TRACE_SYSTEM
> #define TRACE_SYSTEM rpcgss
>=20
> -#if !defined(_TRACE_RPCRDMA_H) || defined(TRACE_HEADER_MULTI_READ)
> +#if !defined(_TRACE_RPCGSS_H) || defined(TRACE_HEADER_MULTI_READ)
> #define _TRACE_RPCGSS_H
>=20
> #include <linux/tracepoint.h>
> --=20
> 2.31.1
>=20

I can take this patch for v5.17 if no-one else has already grabbed it.


--
Chuck Lever



