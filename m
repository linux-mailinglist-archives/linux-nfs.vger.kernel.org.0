Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D3927E9172
	for <lists+linux-nfs@lfdr.de>; Sun, 12 Nov 2023 16:33:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231543AbjKLPdm (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 12 Nov 2023 10:33:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231429AbjKLPdl (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 12 Nov 2023 10:33:41 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9D9D26A4;
        Sun, 12 Nov 2023 07:33:37 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3ACFH5QH005182;
        Sun, 12 Nov 2023 15:33:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=oJhgR6Swh4iVCZnpMH4Yr5fPwotWmwhx5WmN3gPXBgY=;
 b=UqwajYstv7mkuaAHeW9H+O9/OAoPefzXCS/6FLxRwL0TUfo00DbJdd3cdbbvBRUS+ifQ
 G0vVkNm/P0aatjCJBvz4HuAvqKKfntDLAUJ4llvt84bT4wmbFf9sKqkLPa5zU7ohbfql
 8UzaGv4+kB64lsGQI1pahkzOY4eLBMZ+OvmWS9mP3v/LoqsglisAWGYHEGCzB8mBb/1y
 52owl+P6J4tTu+X0PYvq9JPPSK005Vcdrt3f5DHnfrgpuWopgjdQH7H7j/tkEI5TXO7E
 BwVlZalaWEKQca5WSSVzJ/8Xg5zanaFcOjS/CTEzK7Ad14LHLnTdE2AvMnNGTGJt9sxo 9Q== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ua2n9shya-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 12 Nov 2023 15:33:26 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3ACCRtam029807;
        Sun, 12 Nov 2023 15:33:26 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2169.outbound.protection.outlook.com [104.47.73.169])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3uaxqp2us6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 12 Nov 2023 15:33:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YN1mQP9jrIJLNQ+pSkSLWGmRf/nR60f16ZUICR/E1fWgNlaOV0tBi9lfQvomyanHzrrdjqG0J4EHMDpre2jRUPCOy1pbYJTa7nMSuX1OV6/ikjzxJOmeU50rTWFaplUJyTu1lz3xT625DdBwSy+CDYQaSIF+HCRlpwXY3Cq+hlujcb4pI/Gn9PdikdiDgzdeIAzAQ/tMpggeh6BvW/c6i5yXUSwFqGf2x0GoYAsTlH2V8ivrXlVJDmCOelKpCFVzEfGZT7Ugg1WwhrjlR5ZyaUumztCRpqsSOYjzwAzGr2isIB6U80SDq9eJtFjKPlw0QLwoGrTQRqth6j5y17Q3dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oJhgR6Swh4iVCZnpMH4Yr5fPwotWmwhx5WmN3gPXBgY=;
 b=bs9CwGe+NrDpJ7juyHvDzxyLvA6hEi9kxXHDyFlghbXD8ItMokZYcofBb/R92/D6UHIskw6vUe0cIH/eYX2GSNWV4ExubXz0VNIYVkkKr7G53ZMtf3YqMIjf+nfOD89p12g0vEkCik+APGJktwOm9deY2dXlc+HXw8hTWM/TCXHd9Go/FVOQ2RpiH6eGqZvJ5BAVr0xts57olQsOUqNvnqyEVOavYbwkDNmO1WVzMrOVXyuPwl8AHsmDNzDRxhxyF7EezKenWkeZyCB7ZaBZWEzx0tt84XWEFbj+Dr0DTNvgs6fa+albX3XouR1xUbFVxFJL38PJz9Y+soqOw2kijg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oJhgR6Swh4iVCZnpMH4Yr5fPwotWmwhx5WmN3gPXBgY=;
 b=ArrTadjKvHb537Zvy3UuVHS/6d6cG8mTGV2VblIEpoaqZwrEMPwFI5vgKN1KawnQ5sRO8SlAL5DMwjugiFzWvRDfgi9/pFdZvU4Ztj4SM32mQ0XgeUqlBBe8g+5QWZmMpF79UbkQ7QGns6bub8l/ZBaQJJjMwd82d9KbZaw9uPE=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SA2PR10MB4538.namprd10.prod.outlook.com (2603:10b6:806:115::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.28; Sun, 12 Nov
 2023 15:33:23 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c%4]) with mapi id 15.20.6977.029; Sun, 12 Nov 2023
 15:33:23 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>
CC:     Lorenzo Bianconi <lorenzo@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Neil Brown <neilb@suse.de>,
        "open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>,
        "kuba@kernel.org" <kuba@kernel.org>
Subject: Re: [PATCH v4 0/3] convert write_threads, write_version and
 write_ports to netlink commands
Thread-Topic: [PATCH v4 0/3] convert write_threads, write_version and
 write_ports to netlink commands
Thread-Index: AQHaDxAOgGm9oQY2Q0u75SE8Twdz07B1kySAgADtgwCAABKUAIAASbwA
Date:   Sun, 12 Nov 2023 15:33:23 +0000
Message-ID: <BB9DF012-0E69-46CA-B7FF-6B963AA22C02@oracle.com>
References: <cover.1699095665.git.lorenzo@kernel.org>
 <7fdd6dd0d8ab75181eb350f78a4822a039cacaa5.camel@kernel.org>
 <ZVCiyNQtkumDheU4@lore-desk>
 <0f0467f396777722022403727824104b4f0a8d85.camel@kernel.org>
In-Reply-To: <0f0467f396777722022403727824104b4f0a8d85.camel@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.700.6)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|SA2PR10MB4538:EE_
x-ms-office365-filtering-correlation-id: d6e72b38-bcd8-4ee7-b0ca-08dbe394b4ea
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: B3Te+niVXJ/RoVwUFTKH6eiATIuf3hpi0l/Sc2oiMlcXXfmrYO7R7v4IuEgjL6o453Yeb9qr701BkHF0oZzAoc+SSzyaLxLj1ysHX6XY98Jirt+WqgzGTITFGWHUdrwelq5mcnq03HvjZXHXqx3qw5xH/cawJE4ewFPcYn+DGeIrrkUNfUB6+pkzHDKvvCYoLU8GLNNtKHQ4wtkmrNyJjH6s70XKvwzl/9uSRwJ8EfwTO8nRpL3udsjlq0UnJmj1CtEKeXKi2n1hHQq5xjLzDCAmkQlyQzKeHV6jEhOV6lKhZDTVQbQtNTI8EAm67QNqronTOgnE7iOLQbeBb+D7HmQnFukrwTxQ3a0xysTgJYUuk6hGmr3qEygJ3gpdXepscNUuBl7GWRI0pYOMgf7mB9hQd7eHw+kKGGB7SgHSaIMBOQ4WE3XrduJb6T3FpzZGhSnUgBXZnmusKMMEAnPdjPfjhrIZYkmHBI4z2iw5wyjXtglmDATROLEWqf86mm1SPzDbO7zIdVdz1m2mA7lmrnTDrfWjW6hFWOw5YaCXdnPqbsdcUuKBsYxo+Qj/D3S05CLUstFZDr3du83SVn/qqdAiF34z+tJUF/DA4ubDYrrVMhWdeLqvzYbsP5n4wlBynygDlzneX9olUJwM7106cQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(136003)(39860400002)(366004)(396003)(230922051799003)(1800799009)(64100799003)(186009)(451199024)(26005)(2616005)(6506007)(53546011)(71200400001)(6512007)(83380400001)(5660300002)(4326008)(8676002)(8936002)(41300700001)(2906002)(4001150100001)(966005)(6486002)(478600001)(316002)(91956017)(76116006)(6916009)(54906003)(64756008)(66446008)(66476007)(66556008)(66946007)(36756003)(33656002)(86362001)(38100700002)(122000001)(38070700009)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?HuxSqXJupm0kkr/DILDFkpMIVjTDb0y57l+JBG7/IZy6gaMe5Ax9naDabMa3?=
 =?us-ascii?Q?1T82xKWMJBCsub7LwzTJPgMXUBRCvJ0Y3JwrmKAU1Woi/11B4IvncF6IkvFw?=
 =?us-ascii?Q?yYEG9eUmjvk3xOzy2N7m/AHQRtohgdIE6lrbL5eWT2LouSFVudft6+Yl+3oV?=
 =?us-ascii?Q?jRRr/eB5OnUNjfbyzvFpDnx9KhiMTfWPDifaAfu0fysR9Vb+diQjVaTomhja?=
 =?us-ascii?Q?AR8PYfWOq5M4rzMSthNFAoYFTnkkaBFcD39rZsSKblt1MN045rNhXvO13386?=
 =?us-ascii?Q?Bp6hz0vGGMvtEGHLZ5W6rbuJ2IzpaVSRsv+iGQQiHJzl8bDWdPnHj2gKyTqY?=
 =?us-ascii?Q?LJdZB+CQzb7Zd3S5Zo/+9CF+ebe9Y7ZlDm2akR1eXjepGD/9BZ6vwBjbxYY0?=
 =?us-ascii?Q?7QSdlIsJa87XC9Dh+gwPbdeKyoEoSbYdZH392X9DPr+N9JEb6PKldW1+Jt+q?=
 =?us-ascii?Q?pGpia9/J7GiURPyMbUGR5F0YA3XSypwFMDs+cuksyVbejMZq0hWQWw0NY4k+?=
 =?us-ascii?Q?jLp2fs0HmdmrIJYez5UGtuxO3r8YvNt3ucFWrKJ8C+P7ehxROApPNyS/vhC6?=
 =?us-ascii?Q?wlCrWy3IxpRp/wcpPsFV4hnjr37sGyQcHHhWGjMeLU8qdz786Gsuetega+su?=
 =?us-ascii?Q?BJczXGHnGJqcKheOyyKrTWZlwKLe6lpjMBx+ulT5A+YLCsJKgy987nU1okqE?=
 =?us-ascii?Q?CVZCdMobQL87+r3prVP+3EQEI6k4Tjtde0RICNMvyGxjZsOrjOnlABb+1LQk?=
 =?us-ascii?Q?78e+VzBla8mllcbUEBIqgVe7jbHjTHDg2ZSWXNqs+2Ob8gWcFm+Nhe7UhTSW?=
 =?us-ascii?Q?6WgCR6iv22WOazP+WK9xxsgbQe6V/7WHuTwunIPwsgpC2/mt5jmulk+94WTH?=
 =?us-ascii?Q?8jcVvQoHi6/y9j/vAihOwV/aoOpIXqE6Y91GL20LhaUtGO44VYm9aK6DJFDY?=
 =?us-ascii?Q?m6ZyXwt6FLquT9y7mW8ro4ToPsDdH3QVyNOQRdFUwg02+Q4C8UFPnH0EGO8X?=
 =?us-ascii?Q?k41QYoYLJRyOz5bxbgAeLF4ng7Vj/XDX0TJKny/WZB0ea1WrrbztlVctq4UN?=
 =?us-ascii?Q?4Bc3wGdps6zc/hY/oX47w+0WFZJlRc0+1uJh7LtI+VJg8bvCzwTPa+1TCe/G?=
 =?us-ascii?Q?KiKrE122A4DsrAe51+A7hNBk31YEhOoodpKsCu0agcV1LuPG3IkLcKRkIJYz?=
 =?us-ascii?Q?j3la0uAoh10iaM7G9LTZY1FpcoHdTEHcgebWyKYrdH3hwxJPIHvm+rREN44S?=
 =?us-ascii?Q?qBCVmE0b68eNFjZdYsSbdtaNUBnXNAo/AogUNLDMiEM9lGdMFLqYENoCcRjb?=
 =?us-ascii?Q?ymrB/Z4PGl57/frtPvaYZkXV2dSbpnMTgcl0xPeS1nYKnqHhqrYMklFhHkRA?=
 =?us-ascii?Q?TAfEpyWgGuB0jowtjh5/YC50u1U4APrODZc9Sql0oVuIIsM/cvRhbJTvNivY?=
 =?us-ascii?Q?d93AN2VOXZmz9uGJIVsGqv0BD36bnMJ31dVdsH/UuvN9hO7M0Ph82RTAIriN?=
 =?us-ascii?Q?AzCXzzpPWsrG95SJsVw7TbFcDE0W2PUROM226LeffylmHa4h83YnAeisSRW7?=
 =?us-ascii?Q?tdp0qATovXFliZrw/8U3RuVLWdIHeRDGm7kLNv/7S4jORNEBRHqVLKsef0uD?=
 =?us-ascii?Q?Cw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <8B2D48E4D9BB1F43A02AFAB0C27EDD3B@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: mx1E3fwORUlGDo66TiU8w1Pw3+clteSMv899U2UMWBJiFe/+jqlLWCbngOpfDL+HMXorKXrRUYq/2zo4YPJ5/PbY17lCAAO0k5uE8EJFbaNHsui2pio/K4fk3C7No2zlfd77CUh2c9b+H2FBv/2ilxrhtdDyKpYFWfeJ1/UojRu3Xfjh7Ihujr/PfWt/HXXdpfLEgkyAHdc6d2CwGHFe3iljDPJ7TbHqOlXo0gdWVCm8oBEwf1MlWTKiy3R3y3YhBljoFToyci8/5mCUMObE64+JWMa0GsHhNjJlpbWuG8fvUNL2vDa1qKYFbs4bhcbTR4qRw06X1TjyJJXBDUYd5wXawDC+obVoWbENWFfcYz4YbQYU+UBcXYoM3cfYAtCyrwS4PQWNtGngEGntlHN0zRcRlz6mCkYgTRcMixfG/bZqx4MbCjlXiyc6cidmojHvU8FJAKTuY+h9AGMn1S4d42+H6breFZcPng+fGQpLTqYSF7wM0eKq/QsJEfKvTjmJMz0JgoEIC4HCqx0qRyYiuK/1uAyDBGDmLurwBHizV0xIx5Kw54WfQOTxhxjqxRl8Npg7p1IO55nMVNe/YEABcuBLlGZi31f0590FBgodzrTWW5d1vjD/naZVKPiGkxXlUxPMVc10KCqzTVDYs27NDEMbve2Z8pA3E0xHyKbrlkSRU/S9i+RkJsg8IGztz8jvpqHsgODBLcn5P0gYbbtYYzUXY0V+sSCCibUQKpjQrCIoSb1V+iDxgbQXV/t7i8jG+Xp2ApKhOaG7S/GJ6CLs3dZBFwnnu75l12gvmenoyGR5oey1QRXKTqJ5MOsbKDjhRaqcqui4Uv7AB3WS9zb+zQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6e72b38-bcd8-4ee7-b0ca-08dbe394b4ea
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2023 15:33:23.2792
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2RnP8XJg2i2d9YjcC9o7moY4BGwZrNFkuHc9psLNRzUCNViHb2t+/DgUEhBDcTCwCh5y0vWxe2IGp5tNsZDymg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4538
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-12_14,2023-11-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311120137
X-Proofpoint-GUID: e3XUmD4Cb_w_6PfXkjTnXRb2hBSSa7ok
X-Proofpoint-ORIG-GUID: e3XUmD4Cb_w_6PfXkjTnXRb2hBSSa7ok
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Nov 12, 2023, at 6:09 AM, Jeff Layton <jlayton@kernel.org> wrote:
>=20
> On Sun, 2023-11-12 at 11:02 +0100, Lorenzo Bianconi wrote:
>>> On Sat, 2023-11-04 at 12:13 +0100, Lorenzo Bianconi wrote:
>>>> Introduce write_threads, write_version and write_ports netlink
>>>> commands similar to the ones available through the procfs.
>>>>=20
>>>> Changes since v3:
>>>> - drop write_maxconn and write_maxblksize for the moment
>>>> - add write_version and write_ports commands
>>>> Changes since v2:
>>>> - use u32 to store nthreads in nfsd_nl_threads_set_doit
>>>> - rename server-attr in control-plane in nfsd.yaml specs
>>>> Changes since v1:
>>>> - remove write_v4_end_grace command
>>>> - add write_maxblksize and write_maxconn netlink commands
>>>>=20
>>>> This patch can be tested with user-space tool reported below:
>>>> https://github.com/LorenzoBianconi/nfsd-netlink.git
>>>> This series is based on the commit below available in net-next tree
>>>>=20
>>>> commit e0fadcffdd172d3a762cb3d0e2e185b8198532d9
>>>> Author: Jakub Kicinski <kuba@kernel.org>
>>>> Date:   Fri Oct 6 06:50:32 2023 -0700
>>>>=20
>>>>     tools: ynl-gen: handle do ops with no input attrs
>>>>=20
>>>>     The code supports dumps with no input attributes currently
>>>>     thru a combination of special-casing and luck.
>>>>     Clean up the handling of ops with no inputs. Create empty
>>>>     Structs, and skip printing of empty types.
>>>>     This makes dos with no inputs work.
>>>>=20
>>>> Lorenzo Bianconi (3):
>>>>   NFSD: convert write_threads to netlink commands
>>>>   NFSD: convert write_version to netlink commands
>>>>   NFSD: convert write_ports to netlink commands
>>>>=20
>>>>  Documentation/netlink/specs/nfsd.yaml |  83 ++++++++
>>>>  fs/nfsd/netlink.c                     |  54 ++++++
>>>>  fs/nfsd/netlink.h                     |   8 +
>>>>  fs/nfsd/nfsctl.c                      | 267 +++++++++++++++++++++++++=
-
>>>>  include/uapi/linux/nfsd_netlink.h     |  30 +++
>>>>  tools/net/ynl/generated/nfsd-user.c   | 254 ++++++++++++++++++++++++
>>>>  tools/net/ynl/generated/nfsd-user.h   | 156 +++++++++++++++
>>>>  7 files changed, 845 insertions(+), 7 deletions(-)
>>>>=20
>>>=20
>>> Nice work, Lorenzo! Now comes the bikeshedding...
>>=20
>> Hi Jeff,
>>=20
>>>=20
>>> With the nfsdfs interface, we sort of had to split things up into
>>> multiple files like this, but it has some drawbacks, in particular with
>>> weird behavior when people do things out of order.
>>=20
>> what do you mean with 'weird behavior'? Something not expected?
>>=20
>=20
> Yeah.
>=20
> For instance, if you set up sockets but never write anything to the
> "threads" file, those sockets will sit around in perpetuity. Granted
> most people use rpc.nfsd to start the server, so this generally doesn't
> happen often, but it's always been a klunky interface regardless.
>=20
>>>=20
>>> Would it make more sense to instead have a single netlink command that
>>> sets up ports and versions, and then spawns the requisite amount of
>>> threads, all in one fell swoop?
>>=20
>> I do not have a strong opinion about it but I would say having a dedicat=
ed
>> set/get for each paramater allow us to have more granularity (e.g. if yo=
u want
>> to change just a parameter we do not need to send all of them to the ker=
nel).
>> What do you think?
>>=20
>=20
> It's pretty rare to need to twiddle settings on the server while it's up
> and running. Restarting the server in the face of even minor changes is
> not generally a huge problem, so I don't see this as necessary.

I don't have a problem creating a single "set" netlink command
that takes a number of optional arguments to adjust nfsd's
configuration in a single operation.

And a matching "get" command to query all of the server settings
at one time.


> Also, it's always been a bit hit and miss as to which settings take
> immediate effect. For instance, if I (e.g.) turn off NFSv4 serving
> altogether on a running server, it doesn't purge the existing NFSv4
> state, but v4 RPCs would be immediately rejected. Eventually it would
> time out, but it is odd.
>=20
> Personally, I think this is amenable to a declarative interface:
>=20
> Have userland always send down a complete description of what the server
> should look like, and then the kernel can do what it needs to make that
> happen (starting/stopping threads, opening/closing sockets, changing
> versions served, etc.).
>=20
>>>=20
>>> That does presuppose we can send down a variable-length frame though,
>>> but I assume that is possible with netlink.
>>=20
>> sure, we can do it.
> --=20
> Jeff Layton <jlayton@kernel.org>


--
Chuck Lever


