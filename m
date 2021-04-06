Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38B98355C7D
	for <lists+linux-nfs@lfdr.de>; Tue,  6 Apr 2021 21:43:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238002AbhDFTnO (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 6 Apr 2021 15:43:14 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:55148 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244990AbhDFTnM (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 6 Apr 2021 15:43:12 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 136JcjDd146726;
        Tue, 6 Apr 2021 19:42:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=DwGHZt6li7Ca+uO7GZkcV/bW5EgQn52IKdwOZxnCMrA=;
 b=zXmqxZiLYrHl8bGlK6Nwmnv5eUALnZq+Lj/vTq9M3HVbpB/YKW6Qv8tpfDn2HgABo6qB
 EElg/zoE7G6ZpeP2kJVzTkpIFQPNla3p7uZdwfGm/VLPCenJ1TGnuQ376VdwUY5hqFF6
 NEugpCQ3T+PK53NgmlziP9Z5VwoSVxtZ3Hwv3507BIipCRN6RMjrRt0VBYv84W6SoV7e
 97idQ8tpUEPBRXVPMmRH0e1ODAHUpwuX9PheJVY2UfY0wm7Kp/jDhwluZa3iMpnFX320
 SxvGSR83w26XSXb55kzjsOew9kCGtoZZLqq113vmtNNcmU9wskp/QxrXUtCWbNid0yNi MA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 37rvas0ava-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Apr 2021 19:42:53 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 136JZtls090781;
        Tue, 6 Apr 2021 19:42:53 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
        by userp3030.oracle.com with ESMTP id 37rvbd4dcr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Apr 2021 19:42:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ITVBXgUm3xgj7pb+sBl7TeUtoS4GisMB5sSxiqiTU2ieSvT//8eeTaIm9CWjZEpgnuim8D1Kwws8/vUjquC4AokyxYteVu9xad70w9vTeViTtDM+jlMjqRKnJymI3XVZjYmu1URaPmI3N+2jzzhcaqF1h3bipd4evn6cz4mg9HvqWmqNaKoJtgjt79pdZWc32mNFioqF7B+mwMzvjvArtrIiahEQUpuCBIR2bL6aUucmLoxQYivUQL76cLJeu7A1T4PBaJNCAqBqPyf7+BTegYJk9LrAL4ISLz7L3MS7vhlTySiNj6E/2YQKJNwZHXiF7VfvLucb+in+TpcRa2ReGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DwGHZt6li7Ca+uO7GZkcV/bW5EgQn52IKdwOZxnCMrA=;
 b=byZxJOm8T9AhJxTkD7suAUr9h4KYN+Hs+1HveWdObQt88X9dHdoXHjyNMm4oMgtGLboddPbVyGFSoMJ1b1ngFGWz46YQyrBcmxhgOZmhbrZ3/X31P/F/bwMeWX0FC2LMxs86Nlp+dDlgGZoki328emISZ4P/3vCP/HTq7RKTJ3/gRwzTSoTlaH8R4NmfryFfdsiXZGCAN986jq+f8EiYkEVuiQS6jK3brOHylqxE/YrfsVvNn9/sVr5cEWnWgOAwS5DSu6xZtK1lM8mDOLA9OppEDVcCgYc3f9Gj5BSfb+9Tox8kAugmFtLr8RN+jNIaS8QhsxKLRfIU6s8fC5Kfdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DwGHZt6li7Ca+uO7GZkcV/bW5EgQn52IKdwOZxnCMrA=;
 b=HxI3eExsgAJTUJYx0sju/CgJ4XMttFbRbE4wt8b8CyaT2Vo2DultQDGCX/HhXm/x7JW442YZSuKAm9mp/OTYo/86+31OwomcrYzj4y7xJjWz+DqjGWKOj6XPb6zcwZyzt4RrN5TRxOrr7EyChyS44RZNfsRSvD5vfppTGfghxj4=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BY5PR10MB4290.namprd10.prod.outlook.com (2603:10b6:a03:203::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.29; Tue, 6 Apr
 2021 19:42:50 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::50bf:7319:321c:96c9]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::50bf:7319:321c:96c9%4]) with mapi id 15.20.3999.032; Tue, 6 Apr 2021
 19:42:50 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Olga Kornievskaia <olga.kornievskaia@gmail.com>
CC:     Dai Ngo <dai.ngo@oracle.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Bruce Fields <bfields@fieldses.org>
Subject: Re: [PATCH v2 0/2] enhance NFSv4.2 SSC to delay unmount source's
 export.
Thread-Topic: [PATCH v2 0/2] enhance NFSv4.2 SSC to delay unmount source's
 export.
Thread-Index: AQHXKBgu9IXq70YdMUCq9qUqUB+L96qntQoAgAA0ZoCAAABtAA==
Date:   Tue, 6 Apr 2021 19:42:50 +0000
Message-ID: <7BED2160-1052-49EE-BB62-6ACF6F84C91C@oracle.com>
References: <20210402233031.36731-1-dai.ngo@oracle.com>
 <D85FBDD3-5397-4D47-932D-159AFE2A5E0F@oracle.com>
 <CAN-5tyHVOEr7zZM92PVS0GYJQ2M6rSs6_zqZwuioumQQm7zzUQ@mail.gmail.com>
In-Reply-To: <CAN-5tyHVOEr7zZM92PVS0GYJQ2M6rSs6_zqZwuioumQQm7zzUQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [68.61.232.219]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f4096572-a955-43a8-7cb5-08d8f93429e0
x-ms-traffictypediagnostic: BY5PR10MB4290:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR10MB42901DBD3BC1945285FA7DF793769@BY5PR10MB4290.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JcRYFd9rPxpmbdwp3FIrHIljzOpqEWREHctHQb7wd+u04QIrntAoytT/4UCa2yyedyVlfTD7B48eb/L9bdQEhA7yVx6DYPE8SIa8Ud1RW7k8m7APJlTRdebMd2TJm3hyptHNFPkP17poX5+hgZeBWM6jk+RAhQvZdBq23FpBtxTHDBtM8L9+xv0fqPXz9cd66+Mr4v9biyWQZH/YsPXlsQch8KuGsSYBBxW8VcC021PyIIvRul8ZJIOzQwQu8oxQv9tLgyW/cOOc2I/JBMoVNQ4HF4HM7hAgYsNeUx88SZHXiVYrxXt8adguzYkPyyPhh4elln09SJ9AYnELltD/S46syDhLMIBnusZGKD32srABwc3jpHGg3MS2nf581m0Ssgx0IydINfI5da4i2Nqgjw2a6B/0UV1tn1hLK+6+gyprpCouWMg20Wsm/af0RB9Dp69OvLeEdtNByjn1hMAWkVRFKXv1eEIp6a590S6IT6glDln9Ii2ZU3Ig6YW2c6fuiq0zUvtrxsJ49TA4O0bJie/NPh2M9wkrm2M6eNmxbVM/hTtRH4baSSj9E0ugTCE+4joD3eNknyQaHrJsPyRJuyp5XK9LL9yLbNnkYfOyMgqrJpLwuPd+tb+zzyYd3otzrynADsZDOxNbu+LakvmFd3ZGAS63914sBlp9AARdmVNvKFC3ntjKCtAZk54E4jyk
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(346002)(376002)(366004)(396003)(136003)(76116006)(66446008)(66946007)(66476007)(64756008)(66556008)(83380400001)(91956017)(6512007)(2906002)(4326008)(6506007)(53546011)(6916009)(26005)(186003)(38100700001)(5660300002)(33656002)(36756003)(2616005)(54906003)(6486002)(8936002)(86362001)(71200400001)(8676002)(478600001)(316002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?Wxo5QEDOuV1GL8ram3SKMSRQ9q5mOelrGZhsFUAU8alPhyfs3jBbYab+LoMj?=
 =?us-ascii?Q?lhIEBUicTx2abtP16thVajoLuE8pZvpzoQ5QB1KK7J3rDKMcWVxSp6Akz1ru?=
 =?us-ascii?Q?rxmLVGGqCCA9mt8MJiGXAwjSiN0bIaoWesWeZ5+k2pcv4ZoRwMVsxPvys8xh?=
 =?us-ascii?Q?iCBqfegKtxrQaAUHy8BxRjF78t8IWKZ082F82TcKWMm2ByLXnWhJwpYIUogo?=
 =?us-ascii?Q?QvvkZZpwcsPeNiBX8TXo0nhLeC2BozyuKRkTGa02rBZj2FtUIjdFOauIJzy1?=
 =?us-ascii?Q?uw3e2iKu54lPW4wwdkcjIbr21GHTgaBvkWobuT4UPKq5l/X1zjPaioUrJ91N?=
 =?us-ascii?Q?sHjl8ijhoy+Gr6OiJuspekbrAW63Key/M954jwB+bGhLI+RgcyL62WOvbxpC?=
 =?us-ascii?Q?CbBaMIb8/aZdywOp3PiS4W2lET/3iMX17Tm6oRORAYhjooBe9a3nH/YURB8+?=
 =?us-ascii?Q?DppmI+r6dhVNkHYV/qJTgV18CHowfIQclTj/qcF7GKqbrhtLexpeTbuU24D8?=
 =?us-ascii?Q?bBQj3oPtB7+V5DH9w1MctJhFJHVpV6JHkWHe3zOv3dCHR22GNGhZ/3vbuDMG?=
 =?us-ascii?Q?b732HKJ+U8+79sa6GnKWllnnBBsrt/1UCu9+ZEJom6G+huF7pxrKm2Gk0CTF?=
 =?us-ascii?Q?nKL6yfirqv/4z50beP7zXgt3wT9epHSHjNvHPkUju7DQ6CajVr5PtrgzCXtG?=
 =?us-ascii?Q?GDl3lm9ynjggkx5Nm9Uy7rzzQaiiz2K9GZvoQdURwFybqbPhn2wph3lf9ckp?=
 =?us-ascii?Q?M1pT3K/uPQlsUq5fwq2zhinAKezhTFooTKyQ3iHvsnaoHIH0a2urECHeBLXd?=
 =?us-ascii?Q?WlKr3GntokiABLxZvPUAwfYkkhtovHBJWESJvk23t/uj1us85FuZegp64VPi?=
 =?us-ascii?Q?zYyCEuJ8/aB+PFsrgZFVR6Q6oi/3ZzR9fKryuGdM9cqFoVIXeAj7D9wVdBGk?=
 =?us-ascii?Q?hyft4iSBULkPFcAnEQ5OAcq0jnbk0MWh7DWREJ19Xfxh2aLia1gS5cwzD1zZ?=
 =?us-ascii?Q?gJ14vHFETDKxWUL0EtuXhgNeJt0+dow92vY7BZZ9McGHzwmJfWkeZvgNl8po?=
 =?us-ascii?Q?SOH5uk1ygNW/x7/kVREA5WQMThgkVylhoQPyaC+fOh8BaRXZx5yXb4xHLdcL?=
 =?us-ascii?Q?9uQle7FkecWR43PioULIB2+KDW/PharAq4nEqFDyG6Nz9/PGb5JrQbtq9Q1z?=
 =?us-ascii?Q?fDfziCVxiUF0zMKVX/wwFNbTOhuU0hubALHZeEnC1j1LWkPmlGl3lUwzhPKc?=
 =?us-ascii?Q?U6SJjniye3V6w89iV4XvdmxHhXUiQ0acsB99oh7uf/1TefN3ZXotR3E0/LZD?=
 =?us-ascii?Q?O9M0HE97lZAWzNkI9yxudWuuimo584CHvtmbW9b53RU2CA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4E7D0888BD634740B75EEFEE28E0F197@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4096572-a955-43a8-7cb5-08d8f93429e0
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Apr 2021 19:42:50.7376
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bkmpQ/R0ddZ876XeA0t4buF7L/sAXF85K8wkB9KNI7icALpcA4anPuKZ9ssWSDgwJ7Z4bDzFwbVvvuvnapcuPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4290
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9946 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 suspectscore=0 phishscore=0 malwarescore=0 mlxscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104060132
X-Proofpoint-GUID: MokvOMmZi3UYjsfdSaSCRmR63OVg_Kxu
X-Proofpoint-ORIG-GUID: MokvOMmZi3UYjsfdSaSCRmR63OVg_Kxu
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9946 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 mlxlogscore=999 clxscore=1015
 bulkscore=0 mlxscore=0 phishscore=0 spamscore=0 suspectscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104060132
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Apr 6, 2021, at 3:41 PM, Olga Kornievskaia <olga.kornievskaia@gmail.co=
m> wrote:
>=20
> On Tue, Apr 6, 2021 at 12:33 PM Chuck Lever III <chuck.lever@oracle.com> =
wrote:
>>=20
>>=20
>>=20
>>> On Apr 2, 2021, at 7:30 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
>>>=20
>>> Hi,
>>>=20
>>> Currently the source's export is mounted and unmounted on every
>>> inter-server copy operation. This causes unnecessary overhead
>>> for each copy.
>>>=20
>>> This patch series is an enhancement to allow the export to remain
>>> mounted for a configurable period (default to 15 minutes). If the
>>> export is not being used for the configured time it will be unmounted
>>> by a delayed task. If it's used again then its expiration time is
>>> extended for another period.
>>>=20
>>> Since mount and unmount are no longer done on each copy request,
>>> this overhead is no longer used to decide whether the copy should
>>> be done with inter-server copy or generic copy. The threshold used
>>> to determine sync or async copy is now used for this decision.
>>>=20
>>> -Dai
>>>=20
>>> v2: fix compiler warning of missing prototype.
>>=20
>> Hi Olga-
>>=20
>> I'm getting ready to shrink-wrap the initial NFSD v5.13 pull request.
>> Have you had a chance to review Dai's patches?
>=20
> Hi Chuck,
>=20
> I apologize I haven't had the chance to review/test it yet. Can I have
> until tomorrow evening to do so?

Next couple of days will be fine. Thanks!


--
Chuck Lever



