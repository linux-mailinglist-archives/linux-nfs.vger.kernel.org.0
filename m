Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ADEF7AF6F4
	for <lists+linux-nfs@lfdr.de>; Wed, 27 Sep 2023 01:50:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230494AbjIZXuF (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 26 Sep 2023 19:50:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233468AbjIZXsE (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 26 Sep 2023 19:48:04 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D05C41F3D;
        Tue, 26 Sep 2023 16:09:57 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38QLTI9r025045;
        Tue, 26 Sep 2023 23:09:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=tiEA5VYZ/omMGyehsc2Inz8I7JYOqb3cT6N7W8eNZus=;
 b=tdWFSzSIB4mFXSsvojv07K+pBoaXUgxCcguu9y76/aFLJ6QUb7kHzXvyHQ4fAKodo135
 4ZWOqmB/2zxKHAIngnyfFzMWsEtJtoK5QCij67HbH4C8sE0vj60z7uSX/+sEBU5gFzu1
 wyP4sa/zlINR3sW8e5WsSj/PQ7NN0ijKmWQ6EYU9z2R/Pe3lY0Jc3f0QSg2gbqnzFVb7
 nG/hV6ulRwJkSBUdq9MU86LAe/Jf5ShfmtOpwkIaSlFLEbPbv96RgLoQ9ZW6HnJRQRQE
 AWIMiT4izxn8xsiGMubmTKkIoKtwZiAVkV1JPof3z6ktkTNvWI0vAHZOGgtb1LpD9VUN 8Q== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t9r2dg6d5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Sep 2023 23:09:40 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38QMmpjR039474;
        Tue, 26 Sep 2023 23:09:40 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2176.outbound.protection.outlook.com [104.47.57.176])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3t9pfd0hwq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Sep 2023 23:09:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J9wdOOiCbTTTPjnjuIM5BIo1L/47DwTKXx1qAuRXNn3LWPsTLJo89TjLEcCJOG0ZtUC5hgoBDjBFBET2v0kNO3CxJ3LUmrkuwLTZeUnhou+iYujxCR6WbjTCM164WItItfW5SZoxZedQZzO3L9fk+eegmhdc+AqNrLCprw6BqG14bcenpSLF6VWY+7k1GOrY2/L5ba/Nxl6rGHvop90mNDPhxOb/NMZHcgCEM4yYCR8qOJnSVc4WRCXUDAHELxkk2DeUNdApcvaL/Av3hf+60dc2UQx5MKT/YKXh2sCmjYWebkN7Da0RtgChi0w07Yit64sp8YiGGXhKXqu79l0svw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tiEA5VYZ/omMGyehsc2Inz8I7JYOqb3cT6N7W8eNZus=;
 b=ebB74f22I7Ih0bdZOyV+U/3v6nACUU/rJsPXKmX7lu22QfdsyGfMY5KMcgsR9VXb+LSac2+KSplPV2MadTdNldbfDjnl4oFy4TdGKboonx0i6msyRpXjUy6+F/VqIXnW3DvnvahzIoQMLAP3g15S7OyXn6BHvQo7f1hsVarGDxMzJLc7JBpqaq/ZWw084F3J5F0tAYlIXeT6XwvpZYyNVV0d1JuG6CzO2/qNtVvEroMuANKWkm7FX7FpQEMGgVXiz7yvEZMJh/O+RRwHBmCxAuaYHbXWF5ElS9GtBEzsgKj61cvrI6w1C1/vz8dPWhStwiDrMpr7y7rn/oYWeul08w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tiEA5VYZ/omMGyehsc2Inz8I7JYOqb3cT6N7W8eNZus=;
 b=jcBm0yMGysRWsuZFsShjDALIgV+kqriLY6FWQdtbYcymgFry6z0QOLgRrIAfW0E9iz50l50uFwsf7yDDWB8NXVgzA0Nch9dpiwqzuBV7w4jUItwmNAWDq9gacHeYd87mJwpwStZu0EoFQ32G1Uy/BaH7x879segMrIzyqIfE5Kw=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SA2PR10MB4571.namprd10.prod.outlook.com (2603:10b6:806:11d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20; Tue, 26 Sep
 2023 23:09:15 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::bffc:4f39:2aa8:6144]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::bffc:4f39:2aa8:6144%5]) with mapi id 15.20.6813.027; Tue, 26 Sep 2023
 23:09:15 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Neil Brown <neilb@suse.de>
CC:     Lorenzo Bianconi <lorenzo@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Jeff Layton <jlayton@kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH v3] NFSD: convert write_threads, write_maxblksize and
 write_maxconn to netlink commands
Thread-Topic: [PATCH v3] NFSD: convert write_threads, write_maxblksize and
 write_maxconn to netlink commands
Thread-Index: AQHZ8Ma6QVfM7SVFaUSgOHTmfVn4XbAtuj4AgAABFwA=
Date:   Tue, 26 Sep 2023 23:09:14 +0000
Message-ID: <F720612D-DFDE-4F42-AFA0-CC2F9E8C0D41@oracle.com>
References: <27646a34a3ddac3e0b0ad9b49aaf66b3cee5844f.1695766257.git.lorenzo@kernel.org>
 <169576951041.19404.9298873670065778737@noble.neil.brown.name>
In-Reply-To: <169576951041.19404.9298873670065778737@noble.neil.brown.name>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.700.6)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|SA2PR10MB4571:EE_
x-ms-office365-filtering-correlation-id: 9e912bd2-a969-4684-53c4-08dbbee59a62
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HjxOuGsG2eqhnkhb/TUUX08sMSZ/7M7tD3o4pQBPvTnxCajjd3J8mwnncYMQuxViYeJWiXYbmi96Ox2I53KJ6ct2ogWYk/LZfqRBIJKOjr7IfEkg23P4f3EMhmvQ7HZchsHG3lT4qh+njthUq78cxZNM9i8/3R6OzPc9IEKIFlPrD/CMMNlwUo6CisQyCIIl9YIj+7ZPNhnlELU0YwaCegA98CcUrbybAjeJJi/9AwzWo4jWJUJA0NoScynPjSTSTTnTn1bmu45DhhxRFbTGPsxAP8Krcmsrxg9TptZma9SRRMHYJ9lZ3Csm2Z9VvjLIQRiTzvaHdpeSkTk/18UUcQxFJ2/ZDLsHBspd6ydjOUzVj/M9F0cKSHcYyEK83yQb2p5rD5MOwOAIWPd1yARfuxMaOB4SohUSL1HMy3Op+N5BAsKS1DjWTaOnB1HBcMmcOvviaLDdT6KpBMRCCMMp2+KjIft2AcI0ORus50JGaCJaBUpLh/wwWrwTrHyc8RL2yIz7OgYLYAxEKV17DHke0I6yVNKFzfbSY9EjyrPeQO//Ug2zZ63/g0KZIM4SJWKX/iTC8g2INnWFspOeB6DAL9I12Esvz2hbQlmayJyKT86w2fBmQbxrpo6ek+37p9O6MpPwcJzq3Y6kFb84FIbWVg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(39860400002)(136003)(396003)(376002)(230922051799003)(186009)(1800799009)(451199024)(91956017)(5660300002)(2906002)(6506007)(53546011)(6512007)(38100700002)(66946007)(76116006)(66446008)(86362001)(122000001)(2616005)(71200400001)(478600001)(38070700005)(66476007)(66556008)(26005)(36756003)(6916009)(8676002)(54906003)(316002)(4326008)(33656002)(966005)(41300700001)(6486002)(64756008)(8936002)(30864003)(83380400001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?MOrhpLFGawONEPiHBjZ0NRB6yleLMvP3tJlLcff1URDjHd+vUOz9oHxjblUY?=
 =?us-ascii?Q?/uLxsgTuJas/Dbj4hmnhGWDmaGcxjP8KDks05RuU0F4PMxWbeGCwwNwqLg7l?=
 =?us-ascii?Q?pxTKNbmlMq6B/SASRu82p+2Z1Jt2RTPfQRDGaxCNzX9ZJRtlGlfVMfHpz5/a?=
 =?us-ascii?Q?5sjCxuqMKLu7EpeALJi+O9uMf9J96h77MJvyuBvAoVrIJjL0wiqyr3PtUXQc?=
 =?us-ascii?Q?r++lORRliqpEHxnYPr0RWfF6MilSQZZ7L/g8kkVzY+0zc2bqahy9cALpEwvQ?=
 =?us-ascii?Q?kL9eLxEgDM1Bp/zrGO5eF4PacZmYBUIJVT33VvTrJJPr9e89K0zanGyItDM1?=
 =?us-ascii?Q?qGEDlcfeq5du/FQ9841qpganckGVqqpjNO9kFtyd/02oYHt5/0ItWuXgB383?=
 =?us-ascii?Q?cyspY0emPm7AQfspNxBVm2x9EbOa9M+50ET7a7XLQnOiKJ5KPombPj3CA+5B?=
 =?us-ascii?Q?qF/xp8O5IVYqEEvNjKYMfr7pnucDldapnAsCKvXz/h0uN6JiNIPUMCaBRvWM?=
 =?us-ascii?Q?MH9fZHfVSZLD279ljM1nu3vzjnEXYBWvTTpz/cJCyemEJdqS2TFaZJ7muO09?=
 =?us-ascii?Q?I5Cv7tLtBrQBFPUqIfWzwyHsj0UIN5W5lTCJ0O8tDlsRQbIhui08xBW44/k3?=
 =?us-ascii?Q?8JIhHOFzWStNDroXta81DCObW8rJ0+TOL+h1pimc7zGaRArY94FgqFnT/Inv?=
 =?us-ascii?Q?jUYjCxNWHL3RfGarDlrziV3ahelkwGRjDBYkgX7bKLwrHtOA87LdXJBTq9tn?=
 =?us-ascii?Q?y1eLYJaiPwbA/QbZVA1kc2YjCTMHYSPYDVWi2hY+u7HZqUSd0RP0Fm9XOYuw?=
 =?us-ascii?Q?BSoCLEQj7hkgD0UJPeJFX6R/yUvWKOv5PNf2PePNyFxHrvWmQp9WXV1XHp8L?=
 =?us-ascii?Q?gxdoEM0xarNlAl90NF5gBvfQ7PjjxjZ/v3SkA85y8RumWCvRdGkPcuElrJ+t?=
 =?us-ascii?Q?2/tgOASNDArdyHN/9hT3gqwVEZGtYM57Shf/6d3sIyfsGBHeHbTr2usC1O3C?=
 =?us-ascii?Q?LtEbz2AChaKpBH+0ydId49Qajlz1u4AzKfhdKuMupb1zfALrM83aX4LwA2a+?=
 =?us-ascii?Q?sWsa+8dtmpbK9AygIOhd0SFHk4W+swUrm83HKBT198dIqljfBm9nxsZEFEdS?=
 =?us-ascii?Q?PIktLWpQS9DUXoWXQ5fnuhaFWuQq6/gFUXBorYW/J+JVIbFcWMI51XTzE5oG?=
 =?us-ascii?Q?EUF3xOUm4F1/xgjra/IM27oK474y/fr5edtp5o3YHxLenj7ioykL3h50KNYJ?=
 =?us-ascii?Q?jjtKKpz9yUlUOp6aEka4x8XRLokXO2ZT1fv+s3UWSjYbVwTXudXTg5g/sAWV?=
 =?us-ascii?Q?/niNqsZQsCIICXKvx0aAiHDF3/u76oovb/Wtvur2Z4E8IXyumo2Eg6mFyE44?=
 =?us-ascii?Q?a1oOVuZQk+xMskBEGm5mPT0NQu+5x4JBwjFtcrxuHlhFYPKJNaN60nxEcacW?=
 =?us-ascii?Q?AENWteoOE2IJmrGYVbWtbvC+JSMcCabmjaRxXW5rTF39mDReg1JpcQTibRcg?=
 =?us-ascii?Q?EhgajOPoKRHOcUeWihuy39Y0gd3wlQgn0nFtA7lzKBQyciSnkukilwFG2GGK?=
 =?us-ascii?Q?lkhqkG/uY4k/Z5fQkDUdI/7cz3FlJDHAk/96OXLdjHiM9gEoprFXHWYsJ+cv?=
 =?us-ascii?Q?Hw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4FD0F9C6E2527B46AD718C76A4B3064E@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: INQppIxS9Ag5fQo86kQnSmMuoRH3+9v5P5xHF6m3Cn+nDenwZul3tFwmv1kfhp684qFALr4CcZXkKwnJAIfdBzUPjHOE1o0vi7a0IpUVbgzknKkkG9wqEG9dWpN8+YUCvdg2pFn68b/AnzwkqssM1pr4tRMeyIjP4VOVuAr+LX1t2nE+nnClZKTuCv72s5G/OCLMFFpXIITR+iuqNM/HXQxeVJmul5d+hemF2OoXLwWtnNr1K1rV2ySUs7c6xB/s6d5AFIC6CoH5jOrR3DqomUJjNDYLy7tOFeRMkKxqcs4o8MiLWizu4uNjxginIiicivgvuMz1gzyUSKi2AyFLVQ59e5YrJorWpXYS0wWivLMzxNo71wGgnt0/CJgkqcctwmNY7fKj0DSSrsilFdkPXVBtWV9Avi33erhmwAcwEwYWZyinEOD2MD+5UZvLPIyy2v2YWZTtFuDgUyfHavCbxd5zqqC0X19nsSYwh5dl/RJMA7fbJ46cO/lmHRbVHR6ZeKaaR4tvC9TA8S9TdtBFXGC+eCpeKF3MqnNxuqBT5m16gXLunzIKLQTiG5cEb7jmimkyN3aQdkZZPWtPDCz/oE/3JPw60xeNnxqX6HzulRMnJTa+jZk11YPBZWi/KCsqg/oC7QhC+hatsrxZsnWi6wN+Xq8GMPHP8byEKQeK0gT0qhSY9lT1tDawip0PDIpX71w5m4S3BjlW8hzELtroRA3EBjF0+DF2ZQSuXbUf+pl/fSU2/4NKRGGQf77jDNbN7L7qolCJEINn8IEtmLnO3BjRpodPqONnOI6gOPfPOXLr3wTl2CO3OK7QnAOJB/rZJoxXeV4/VCBY4of/yxr4iw==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e912bd2-a969-4684-53c4-08dbbee59a62
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2023 23:09:14.9638
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ac8IkelpwYcI+hLnLm3f1V3zqVe4zFWyKCcEzNrz7XJ5bq3orhAqEq62VW9QUIHX4QtQyOGSGSM1jNRFemIpgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4571
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-26_15,2023-09-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 suspectscore=0 adultscore=0 phishscore=0 mlxscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2309260199
X-Proofpoint-GUID: HTmMecIH3y74UoQuzlQsGTWSM1VYHxBW
X-Proofpoint-ORIG-GUID: HTmMecIH3y74UoQuzlQsGTWSM1VYHxBW
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Sep 26, 2023, at 7:05 PM, NeilBrown <neilb@suse.de> wrote:
>=20
>=20
> Hi,
> thanks for doing this.  I had a hunt through the patch largely to help
> improve my own understanding of netlink.  A few things stood out.  Not
> necessarily problems with the patch, but things that seemed worth
> mentioning.=20
>=20
> Firstly, and rather trivially, the word "convert" in the subject lead
> me to think that the old approach was being converted to a new
> approach.  I see that isn't correct - you are just introducing a new
> option.
>=20
> On Wed, 27 Sep 2023, Lorenzo Bianconi wrote:
>> Introduce write_threads, write_maxblksize and write_maxconn netlink
>> commands similar to the ones available through the procfs.
>>=20
>> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
>> ---
>> Changes since v2:
>> - use u32 to store nthreads in nfsd_nl_threads_set_doit
>> - rename server-attr in control-plane in nfsd.yaml specs
>> Changes since v1:
>> - remove write_v4_end_grace command
>> - add write_maxblksize and write_maxconn netlink commands
>>=20
>> This patch can be tested with user-space tool reported below:
>> https://github.com/LorenzoBianconi/nfsd-netlink.git
>> ---
>> Documentation/netlink/specs/nfsd.yaml |  63 ++++++++++++
>> fs/nfsd/netlink.c                     |  51 ++++++++++
>> fs/nfsd/netlink.h                     |   9 ++
>> fs/nfsd/nfsctl.c                      | 141 ++++++++++++++++++++++++++
>> include/uapi/linux/nfsd_netlink.h     |  15 +++
>> 5 files changed, 279 insertions(+)
>>=20
>> diff --git a/Documentation/netlink/specs/nfsd.yaml b/Documentation/netli=
nk/specs/nfsd.yaml
>> index 403d3e3a04f3..c6af1653bc1d 100644
>> --- a/Documentation/netlink/specs/nfsd.yaml
>> +++ b/Documentation/netlink/specs/nfsd.yaml
>> @@ -62,6 +62,18 @@ attribute-sets:
>>         name: compound-ops
>>         type: u32
>>         multi-attr: true
>> +  -
>> +    name: control-plane
>> +    attributes:
>> +      -
>> +        name: threads
>> +        type: u32
>> +      -
>> +        name: max-blksize
>> +        type: u32
>> +      -
>> +        name: max-conn
>> +        type: u32
>>=20
>> operations:
>>   list:
>> @@ -72,3 +84,54 @@ operations:
>>       dump:
>>         pre: nfsd-nl-rpc-status-get-start
>>         post: nfsd-nl-rpc-status-get-done
>> +    -
>> +      name: threads-set
>> +      doc: set the number of running threads
>> +      attribute-set: control-plane
>> +      flags: [ admin-perm ]
>> +      do:
>> +        request:
>> +          attributes:
>> +            - threads
>> +    -
>> +      name: threads-get
>> +      doc: dump the number of running threads
>> +      attribute-set: control-plane
>> +      dump:
>> +        reply:
>> +          attributes:
>> +            - threads
>> +    -
>> +      name: max-blksize-set
>> +      doc: set the nfs block size
>> +      attribute-set: control-plane
>> +      flags: [ admin-perm ]
>> +      do:
>> +        request:
>> +          attributes:
>> +            - max-blksize
>> +    -
>> +      name: max-blksize-get
>> +      doc: dump the nfs block size
>> +      attribute-set: control-plane
>> +      dump:
>> +        reply:
>> +          attributes:
>> +            - max-blksize
>> +    -
>> +      name: max-conn-set
>> +      doc: set the max number of connections
>> +      attribute-set: control-plane
>> +      flags: [ admin-perm ]
>> +      do:
>> +        request:
>> +          attributes:
>> +            - max-conn
>> +    -
>> +      name: max-conn-get
>> +      doc: dump the max number of connections
>> +      attribute-set: control-plane
>> +      dump:
>> +        reply:
>> +          attributes:
>> +            - max-conn
>> diff --git a/fs/nfsd/netlink.c b/fs/nfsd/netlink.c
>> index 0e1d635ec5f9..8f7d72ae60d6 100644
>> --- a/fs/nfsd/netlink.c
>> +++ b/fs/nfsd/netlink.c
>> @@ -10,6 +10,21 @@
>>=20
>> #include <uapi/linux/nfsd_netlink.h>
>>=20
>> +/* NFSD_CMD_THREADS_SET - do */
>> +static const struct nla_policy nfsd_threads_set_nl_policy[NFSD_A_CONTRO=
L_PLANE_THREADS + 1] =3D {
>> + [NFSD_A_CONTROL_PLANE_THREADS] =3D { .type =3D NLA_U32, },
>> +};
>=20
> This array, and the following arrays, is sized exactly large enough to
> hold the last element.  In that case you don't need to explicitly set
> the size:
>=20
> +static const struct nla_policy nfsd_threads_set_nl_policy[] =3D {
> + [NFSD_A_CONTROL_PLANE_THREADS] =3D { .type =3D NLA_U32, },
> +};
>=20
> I at first assumed you were following a standard practice, but other
> places that declare nla_policy use a variety of different approaches.
> I prefer the [] approach, but it is up to you.

FYI, here and below, this code was generated by a Python
script from the nfsd netlink protocol specification in
Documentation/netlink/specs/nfsd.yaml.

We don't have control over its style or unused elements.


>> +
>> +/* NFSD_CMD_MAX_BLKSIZE_SET - do */
>> +static const struct nla_policy nfsd_max_blksize_set_nl_policy[NFSD_A_CO=
NTROL_PLANE_MAX_BLKSIZE + 1] =3D {
>> + [NFSD_A_CONTROL_PLANE_MAX_BLKSIZE] =3D { .type =3D NLA_U32, },
>> +};
>> +
>> +/* NFSD_CMD_MAX_CONN_SET - do */
>> +static const struct nla_policy nfsd_max_conn_set_nl_policy[NFSD_A_CONTR=
OL_PLANE_MAX_CONN + 1] =3D {
>> + [NFSD_A_CONTROL_PLANE_MAX_CONN] =3D { .type =3D NLA_U32, },
>> +};
>> +
>> /* Ops table for nfsd */
>> static const struct genl_split_ops nfsd_nl_ops[] =3D {
>> {
>> @@ -19,6 +34,42 @@ static const struct genl_split_ops nfsd_nl_ops[] =3D =
{
>> .done =3D nfsd_nl_rpc_status_get_done,
>> .flags =3D GENL_CMD_CAP_DUMP,
>> },
>> + {
>> + .cmd =3D NFSD_CMD_THREADS_SET,
>> + .doit =3D nfsd_nl_threads_set_doit,
>> + .policy =3D nfsd_threads_set_nl_policy,
>> + .maxattr =3D NFSD_A_CONTROL_PLANE_THREADS,
>=20
> maxattr is *always* the largest index for the policy array.
> I think it would aid reading to have something like
>=20
> #define NLA_POLICY(_pol) .policy =3D _pol, .maxattr =3D ARRAY_SIZE(_pol) =
- 1
>=20
> then you could have
> .doit  =3D nfsd_nl_thread_set_doit,
> NLA_POLICY(nfsd_thread_set_nl_policy),
>=20
> and be certain that all the maxattr values are correct.
>=20
>> + .flags =3D GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
>> + },
>> + {
>> + .cmd =3D NFSD_CMD_THREADS_GET,
>> + .dumpit =3D nfsd_nl_threads_get_dumpit,
>> + .flags =3D GENL_CMD_CAP_DUMP,
>> + },
>> + {
>> + .cmd =3D NFSD_CMD_MAX_BLKSIZE_SET,
>> + .doit =3D nfsd_nl_max_blksize_set_doit,
>> + .policy =3D nfsd_max_blksize_set_nl_policy,
>> + .maxattr =3D NFSD_A_CONTROL_PLANE_MAX_BLKSIZE,
>> + .flags =3D GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
>> + },
>=20
> it is a little weird that the dumpit sections are indented differently
> to the doit section.  But that is probably intentional and I might even
> grow to like it...
>=20
>> + {
>> + .cmd =3D NFSD_CMD_MAX_BLKSIZE_GET,
>> + .dumpit =3D nfsd_nl_max_blksize_get_dumpit,
>> + .flags =3D GENL_CMD_CAP_DUMP,
>> + },
>> + {
>> + .cmd =3D NFSD_CMD_MAX_CONN_SET,
>> + .doit =3D nfsd_nl_max_conn_set_doit,
>> + .policy =3D nfsd_max_conn_set_nl_policy,
>> + .maxattr =3D NFSD_A_CONTROL_PLANE_MAX_CONN,
>> + .flags =3D GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
>> + },
>> + {
>> + .cmd =3D NFSD_CMD_MAX_CONN_GET,
>> + .dumpit =3D nfsd_nl_max_conn_get_dumpit,
>> + .flags =3D GENL_CMD_CAP_DUMP,
>> + },
>> };
>>=20
>> struct genl_family nfsd_nl_family __ro_after_init =3D {
>> diff --git a/fs/nfsd/netlink.h b/fs/nfsd/netlink.h
>> index d83dd6bdee92..41b95651c638 100644
>> --- a/fs/nfsd/netlink.h
>> +++ b/fs/nfsd/netlink.h
>> @@ -16,6 +16,15 @@ int nfsd_nl_rpc_status_get_done(struct netlink_callba=
ck *cb);
>>=20
>> int nfsd_nl_rpc_status_get_dumpit(struct sk_buff *skb,
>>   struct netlink_callback *cb);
>> +int nfsd_nl_threads_set_doit(struct sk_buff *skb, struct genl_info *inf=
o);
>> +int nfsd_nl_threads_get_dumpit(struct sk_buff *skb,
>> +        struct netlink_callback *cb);
>> +int nfsd_nl_max_blksize_set_doit(struct sk_buff *skb, struct genl_info =
*info);
>> +int nfsd_nl_max_blksize_get_dumpit(struct sk_buff *skb,
>> +    struct netlink_callback *cb);
>> +int nfsd_nl_max_conn_set_doit(struct sk_buff *skb, struct genl_info *in=
fo);
>> +int nfsd_nl_max_conn_get_dumpit(struct sk_buff *skb,
>> + struct netlink_callback *cb);
>>=20
>> extern struct genl_family nfsd_nl_family;
>>=20
>> diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
>> index b71744e355a8..07e7a09e28e3 100644
>> --- a/fs/nfsd/nfsctl.c
>> +++ b/fs/nfsd/nfsctl.c
>> @@ -1694,6 +1694,147 @@ int nfsd_nl_rpc_status_get_done(struct netlink_c=
allback *cb)
>> return 0;
>> }
>>=20
>> +/**
>> + * nfsd_nl_threads_set_doit - set the number of running threads
>> + * @skb: reply buffer
>> + * @info: netlink metadata and command arguments
>> + *
>> + * Return 0 on success or a negative errno.
>> + */
>> +int nfsd_nl_threads_set_doit(struct sk_buff *skb, struct genl_info *inf=
o)
>> +{
>> + u32 nthreads;
>> + int ret;
>> +
>> + if (!info->attrs[NFSD_A_CONTROL_PLANE_THREADS])
>> + return -EINVAL;
>> +
>> + nthreads =3D nla_get_u32(info->attrs[NFSD_A_CONTROL_PLANE_THREADS]);
>> +
>> + ret =3D nfsd_svc(nthreads, genl_info_net(info), get_current_cred());
>> + return ret =3D=3D nthreads ? 0 : ret;
>> +}
>> +
>> +static int nfsd_nl_get_dump(struct sk_buff *skb, struct netlink_callbac=
k *cb,
>> +     int cmd, int attr, u32 val)
>> +{
>> + void *hdr;
>> +
>> + if (cb->args[0]) /* already consumed */
>> + return 0;
>> +
>> + hdr =3D genlmsg_put(skb, NETLINK_CB(cb->skb).portid, cb->nlh->nlmsg_se=
q,
>> +   &nfsd_nl_family, NLM_F_MULTI, cmd);
>> + if (!hdr)
>> + return -ENOBUFS;
>> +
>> + if (nla_put_u32(skb, attr, val))
>> + return -ENOBUFS;
>> +
>> + genlmsg_end(skb, hdr);
>> + cb->args[0] =3D 1;
>> +
>> + return skb->len;
>> +}
>> +
>> +/**
>> + * nfsd_nl_threads_get_dumpit - dump the number of running threads
>> + * @skb: reply buffer
>> + * @cb: netlink metadata and command arguments
>> + *
>> + * Returns the size of the reply or a negative errno.
>> + */
>> +int nfsd_nl_threads_get_dumpit(struct sk_buff *skb, struct netlink_call=
back *cb)
>> +{
>> + return nfsd_nl_get_dump(skb, cb, NFSD_CMD_THREADS_GET,
>> + NFSD_A_CONTROL_PLANE_THREADS,
>> + nfsd_nrthreads(sock_net(skb->sk)));
>> +}
>> +
>> +/**
>> + * nfsd_nl_max_blksize_set_doit - set the nfs block size
>> + * @skb: reply buffer
>> + * @info: netlink metadata and command arguments
>> + *
>> + * Return 0 on success or a negative errno.
>> + */
>> +int nfsd_nl_max_blksize_set_doit(struct sk_buff *skb, struct genl_info =
*info)
>> +{
>> + struct nfsd_net *nn =3D net_generic(genl_info_net(info), nfsd_net_id);
>> + struct nlattr *attr =3D info->attrs[NFSD_A_CONTROL_PLANE_MAX_BLKSIZE];
>> + int ret =3D 0;
>> +
>> + if (!attr)
>> + return -EINVAL;
>> +
>> + mutex_lock(&nfsd_mutex);
>> + if (nn->nfsd_serv) {
>> + ret =3D -EBUSY;
>> + goto out;
>> + }
>=20
> This code is wrong... but then the original in write_maxblksize is wrong
> to, so you can't be blamed.
> nfsd_max_blksize applies to nfsd in ALL network namespaces.  So if we
> need to check there are no active services in one namespace, we need to
> check the same for *all* namespaces.
>=20
> I think we should make nfsd_max_blksize a per-namespace value.
>=20
>> +
>> + nfsd_max_blksize =3D nla_get_u32(attr);
>> + nfsd_max_blksize =3D max_t(int, nfsd_max_blksize, 1024);
>> + nfsd_max_blksize =3D min_t(int, nfsd_max_blksize, NFSSVC_MAXBLKSIZE);
>> + nfsd_max_blksize &=3D ~1023;
>> +out:
>> + mutex_unlock(&nfsd_mutex);
>> +
>> + return ret;
>> +}
>> +
>> +/**
>> + * nfsd_nl_max_blksize_get_dumpit - dump the nfs block size
>> + * @skb: reply buffer
>> + * @cb: netlink metadata and command arguments
>> + *
>> + * Returns the size of the reply or a negative errno.
>> + */
>> +int nfsd_nl_max_blksize_get_dumpit(struct sk_buff *skb,
>> +    struct netlink_callback *cb)
>> +{
>> + return nfsd_nl_get_dump(skb, cb, NFSD_CMD_MAX_BLKSIZE_GET,
>> + NFSD_A_CONTROL_PLANE_MAX_BLKSIZE,
>> + nfsd_max_blksize);
>> +}
>> +
>> +/**
>> + * nfsd_nl_max_conn_set_doit - set the max number of connections
>> + * @skb: reply buffer
>> + * @info: netlink metadata and command arguments
>> + *
>> + * Return 0 on success or a negative errno.
>> + */
>> +int nfsd_nl_max_conn_set_doit(struct sk_buff *skb, struct genl_info *in=
fo)
>> +{
>> + struct nfsd_net *nn =3D net_generic(genl_info_net(info), nfsd_net_id);
>> + struct nlattr *attr =3D info->attrs[NFSD_A_CONTROL_PLANE_MAX_CONN];
>> +
>> + if (!attr)
>> + return -EINVAL;
>> +
>> + nn->max_connections =3D nla_get_u32(attr);
>> +
>> + return 0;
>> +}
>> +
>> +/**
>> + * nfsd_nl_max_conn_get_dumpit - dump the max number of connections
>> + * @skb: reply buffer
>> + * @cb: netlink metadata and command arguments
>> + *
>> + * Returns the size of the reply or a negative errno.
>> + */
>> +int nfsd_nl_max_conn_get_dumpit(struct sk_buff *skb,
>> + struct netlink_callback *cb)
>> +{
>> + struct nfsd_net *nn =3D net_generic(sock_net(cb->skb->sk), nfsd_net_id=
);
>> +
>> + return nfsd_nl_get_dump(skb, cb, NFSD_CMD_MAX_CONN_GET,
>> + NFSD_A_CONTROL_PLANE_MAX_CONN,
>> + nn->max_connections);
>> +}
>> +
>> /**
>>  * nfsd_net_init - Prepare the nfsd_net portion of a new net namespace
>>  * @net: a freshly-created network namespace
>> diff --git a/include/uapi/linux/nfsd_netlink.h b/include/uapi/linux/nfsd=
_netlink.h
>> index c8ae72466ee6..145f4811f3d9 100644
>> --- a/include/uapi/linux/nfsd_netlink.h
>> +++ b/include/uapi/linux/nfsd_netlink.h
>> @@ -29,8 +29,23 @@ enum {
>> NFSD_A_RPC_STATUS_MAX =3D (__NFSD_A_RPC_STATUS_MAX - 1)
>> };
>>=20
>> +enum {
>> + NFSD_A_CONTROL_PLANE_THREADS =3D 1,
>> + NFSD_A_CONTROL_PLANE_MAX_BLKSIZE,
>> + NFSD_A_CONTROL_PLANE_MAX_CONN,
>> +
>> + __NFSD_A_CONTROL_PLANE_MAX,
>> + NFSD_A_CONTROL_PLANE_MAX =3D (__NFSD_A_CONTROL_PLANE_MAX - 1)
>=20
> This last value is never used.  Is it needed?
>=20
>=20
> Thanks,
> NeilBrown
>=20
>> +};
>> +
>> enum {
>> NFSD_CMD_RPC_STATUS_GET =3D 1,
>> + NFSD_CMD_THREADS_SET,
>> + NFSD_CMD_THREADS_GET,
>> + NFSD_CMD_MAX_BLKSIZE_SET,
>> + NFSD_CMD_MAX_BLKSIZE_GET,
>> + NFSD_CMD_MAX_CONN_SET,
>> + NFSD_CMD_MAX_CONN_GET,
>>=20
>> __NFSD_CMD_MAX,
>> NFSD_CMD_MAX =3D (__NFSD_CMD_MAX - 1)
>> --=20
>> 2.41.0


--
Chuck Lever


