Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE5CF48DD81
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Jan 2022 19:13:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237504AbiAMSNm (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 13 Jan 2022 13:13:42 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:56148 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230329AbiAMSNl (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 13 Jan 2022 13:13:41 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20DHoFI7012589;
        Thu, 13 Jan 2022 18:13:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=E/fAhjB2l2gDXuFJAUFhSUj9zr296BOt+LlhtDyK8uI=;
 b=NU8l//zAnqNwdnCSjGGElrU3rLsGQXn/ALnqBjtTSzG+3aKm01d2Ply+E0VYk/aF8Iey
 +0YFpHrLeLkDD7uqlpbZVjQPnuxGKjTEPBc2TGQh5DzpqFuWhicOtUl26INn3x8PsybT
 hK5k57yAPCANGikFFcJdA+7uWcKTZgI4a4hE/H5pOGpldPxOuhxbFcatwZIvXk9l0RzU
 Do0eOME6KHfqW/GHpbX2uLjbWIkDIh2p0jlYqKzrRGrwddCDR94HrBc18tMz7FSfti/X
 SpzGWTgcsBEVreVYKJEGaC6HfJdjHqhsywYqsQ57mZ68p/bB4JMVuBZ/Uk9qYZh7RkxT 0w== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3djmhw11vs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 Jan 2022 18:13:24 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20DIAaKF058042;
        Thu, 13 Jan 2022 18:13:23 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2173.outbound.protection.outlook.com [104.47.58.173])
        by aserp3030.oracle.com with ESMTP id 3df0nhe3jt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 Jan 2022 18:13:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WzyRAYhDT8jMhz0igbbTn2U/+ODkIQ358y0Dn+hSBeFXcHiN2RpTvIh+WYpHoVWjptz7tK5TQtMZZv3B7kL3XDAB9A2J0UOL5/oQoQG3DxEdnWt1pf1MP9Ru782y9Yf1n5OMtwUJbXH718c5aE/hRPBSXey/7eQQ8f/0KaH/6Jy5DSHBYiUMIwtVFWUvYLI4AQVLe3hAuJak8lfx/9xmCJO1fOU/5OGPKzzL2gPCgAOrSkdXPkTj2rkgvfLdBlR5mzU7McAdmoMIpdIJjogeNXCD+Bzr0uYH4YUv84Lj9gYJcPmwvS1gi/PWr/h9C1eMLbfyqpvHTlSRdhI9SOP4wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E/fAhjB2l2gDXuFJAUFhSUj9zr296BOt+LlhtDyK8uI=;
 b=ITSEQOKkUuWtgqJOYv6Y1x+ke5slhjYx+X0rJVdJc0MiLCXYCh30imtRNo8pyk0IiEqaS4Zlkd8G9QXl1IN1gd1j21Bh3b95ugUZMD6+i0GmC9ZQ30abFIKOnAYKsUnqZPXleEusA1RPzDZ/zP4sOHA8IJ8ddLQHUEzFG3dnxdGykg1ycU7o8GMrKGrmQZu2Qcr/h1IsxKNxAs8CLHyQFKq0SKDRpV/C+vrJstanrUnjNHALeHRIrCwUVwk3HJiMihRFEjwE6vE+3t0n8AKGrVf0nKKzDGTdrv5ba1Z+S0ueZx42eccXPUZb5lMJ4KT94YhORvKZexNW6ixhmKml/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E/fAhjB2l2gDXuFJAUFhSUj9zr296BOt+LlhtDyK8uI=;
 b=kMSw4GmBRQq7MXa95bdnRZGu124yhg5M39X3NP7GMLlHnJdTGlXwsz5Iev5c+d3Qix2BMLNSYBSaTU14Ygco0jHPhMhnYXf1Y8AEtFc/TN+2EcwyaugzL+BQXixbpkMqX5ABsqEw3AgIINbgwASGoE7TlD86FmS1qFfv3SydTj4=
Received: from DS7PR10MB4864.namprd10.prod.outlook.com (2603:10b6:5:3a2::5) by
 MN2PR10MB3471.namprd10.prod.outlook.com (2603:10b6:208:117::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.10; Thu, 13 Jan
 2022 18:13:21 +0000
Received: from DS7PR10MB4864.namprd10.prod.outlook.com
 ([fe80::16d:ecf0:1ab6:7401]) by DS7PR10MB4864.namprd10.prod.outlook.com
 ([fe80::16d:ecf0:1ab6:7401%2]) with mapi id 15.20.4888.010; Thu, 13 Jan 2022
 18:13:21 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Steven Rostedt <rostedt@goodmis.org>
CC:     "linux-trace-devel@vger.kernel.org" 
        <linux-trace-devel@vger.kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH RFC 1/2] trace: Introduce helpers to safely handle
 dynamic-sized sockaddrs
Thread-Topic: [PATCH RFC 1/2] trace: Introduce helpers to safely handle
 dynamic-sized sockaddrs
Thread-Index: AQHYBx1g7+LR+5J9j0a+/twlIKZeRaxhNnwAgAANx4A=
Date:   Thu, 13 Jan 2022 18:13:21 +0000
Message-ID: <81019357-9BCA-4EB9-9B8B-F637C98AAEB9@oracle.com>
References: <164192738510.1149.7614903005271825552.stgit@klimt.1015granger.net>
 <164192756765.1149.13872546013201834510.stgit@klimt.1015granger.net>
 <20220113122402.74f73553@gandalf.local.home>
In-Reply-To: <20220113122402.74f73553@gandalf.local.home>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ad2939d9-7292-42d1-4801-08d9d6c061f4
x-ms-traffictypediagnostic: MN2PR10MB3471:EE_
x-microsoft-antispam-prvs: <MN2PR10MB347144E15F4655770569B87F93539@MN2PR10MB3471.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jHGIiA5d8bKbfqvB3JPXfGXubsI+gz002OhiF2e9yt9mpGJ8jvcPNIP6ISbstzSWgcyXDSuLpyejY4MLwaEOR0c/+gk3BGTcjYJ1nGSqwQCiY9bS7Re5YVha4dXZySbEAMktbqsY0KQqG2GVNw3gMtJ4+qRBITEHPs8kEN2/pFt3CFQSaFRTag9wIWE8A+7JWdyuO9ddmeodx4WTf25zo9vIUCorSBJ7QqwW4IFxk0p1YnsFQYSTTbsSvvb4dM24tNWTcNY9ifvr8KivjoGqB77wD/lrV1axzokXz30XRDoXV4jxS1Q/8vRVQxv/VCi024lByctrCNxYIt7n2Fn0uP96xMDgWO96M+jOFOd9j8929o39pPr00aYZi3mW5kJd6nfQ1BXatCDtlxHOQP8k5AIdCfIdxpg2sunWNQszjoQ1CMxkgpGOp1wjIcqR5L3UwmF6tnbZesL40sqaAnUYbqfWnd8QLPRo79m+pcf26zDnHLyokFPoAhuIV16/7pc0iYijxN6KBhfWgslORJ6mPzdqbd0GBHlSzY+K1CQFGjGzh3WjCcQz5sRh/m448CCHkTtVquQ1H3br6JOFCp6sn7YfEDaORbkdrl7Z4JN8dCaDfjp4xOxbX+3H7G2UBbpd9rH3A/jQsTW/NbfS0F6mxQVTZtWdiJe1XWREw5jG+Jfr4in1HT5yppSB5tZBTaQk75iPgfTp/i6GSOEuK298uS5ET0ECdS/i3KS+NfiV5KYgl4mNMIr1kHHmEe7M0JTDke86/m2D7gNMbkio2FOZbCiaK6QHher657jxKERJ5egh3xpEAkjrkDEDBrpOPyOcA+CIthiqJot/OPilb7Bljw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB4864.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(38100700002)(6506007)(33656002)(36756003)(54906003)(4744005)(66446008)(53546011)(66556008)(71200400001)(6512007)(122000001)(316002)(66476007)(26005)(66946007)(508600001)(6916009)(64756008)(2906002)(186003)(76116006)(966005)(91956017)(8676002)(8936002)(6486002)(5660300002)(86362001)(4326008)(38070700005)(2616005)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?GVaNVBwWuWaxeNj/RpY/o/NZzAM4ZUN2+dT3nrWSBhvGYzQeBM+Fmh7smBOX?=
 =?us-ascii?Q?kv6AOLDXEJ35EyrJ00oFtU9pAqXtzJ1NlOdjuBZAmC6jGtgVvqNCTovazitm?=
 =?us-ascii?Q?n9x6vUqw/pOknqrOBV2JOCuoKMmR1yB/qMdKf3dasmf5AKcWrgdqvsnFerdG?=
 =?us-ascii?Q?/DlFs21DDNJ9BR2tPfinkkEVGUidjR+rnvivWhnQyskhl1DLvsIaR+4Zyi35?=
 =?us-ascii?Q?4EMA/or/HZ3hKgyEDVhdKQKZ52cRZp2/U5GUQ0xunuzn0FNOw9Lbvzm05hVE?=
 =?us-ascii?Q?Z64raBZCxO9Z8XGoZx0skdzbrNfBoJ0VEwCrcRo4lCRB2NwUZPLg7PkRu2l0?=
 =?us-ascii?Q?dq5bbSwTzeGHs8CjwXhXcvl8f0K0EdZSZh96svPFjY6ekBiox8uG6YBxOZU+?=
 =?us-ascii?Q?ijKmhY+QReMPnxXpoD+H8uzfhzvXCxzftB+86i5km+LY2pUO8hPk0s8pQPs+?=
 =?us-ascii?Q?eBlbFf3Ir0MmutfZ827Vzk9yEYQs2JgkHwTtcUHTCJcCDEWJHJr8gj+zK766?=
 =?us-ascii?Q?TveJKgxn+nVLZKUnHyexy8LH3AmEFMNE4LIDjqYoSFjVlG1urFJt+hxdkkFg?=
 =?us-ascii?Q?c5mvFIV+sx8UkSCZ17bTE+z3PDQyn6wi1Q7+6zvDi1mq/K08zNPZjdOIb3/o?=
 =?us-ascii?Q?hLVEYV2iTx6uaJEHGAfsWt3KlXj7cYbMijzGmcRSYD3wzma3zYXpuQPOomD5?=
 =?us-ascii?Q?yPzsjb16NRmMnZZgp3+D9cmemOz1vhdV+8NUvIEao1PL6nufd8JpFkxvwV1j?=
 =?us-ascii?Q?u7XmbcTKsRTHpTbW6occEEWfiF8JWyvCarjGHvZ1Uv6SRUQHIQSA24gNN5uN?=
 =?us-ascii?Q?hmU3tl378zU/rtPnm0J70hT+lbPVNdQgMard0KYMstbZnMaMBqLdmfz1xXgp?=
 =?us-ascii?Q?Vg/KJTfiA124rLoZjRs4eEYYzmo4czhC76VBrnqkjseuh4EC9KaoQiMWENJG?=
 =?us-ascii?Q?xyrEqbrLKTCY09fDGb8zsO/AiAimS+3Gx7GS+QlAu0zTOEdqt+G9aId5I7Rh?=
 =?us-ascii?Q?40qqh48Gz25Agmy84fU4L6HUQB3Dyy/vrufPtZFCDR87tSwetqIL42wS0T/w?=
 =?us-ascii?Q?VK+Wje0zvFA1hdHIl6jjybVfjVfxW4LxQuD4uDdukalSBGMzB+VmV0Wwb0Vf?=
 =?us-ascii?Q?ybqEWzN47vzE96LN4ls6WYGbYSXypHTUG0/wgvRtJEbmrmfnWqAFwIRaJsEz?=
 =?us-ascii?Q?TYQLpQlqV0kRoWFqOlBAPeYJJIH6i3NyY2hg5oZdSrsmkHd8u68yy6Yc9g4L?=
 =?us-ascii?Q?/yvvrmgAOmUqR+/LAUMwhzKHZk+EpI5BdNUBPKFd2HtLOyIcNSCwm1ECSpXr?=
 =?us-ascii?Q?H2ax0Z0/dwtWV/of2qBiu6wI4s8QzUe+go9VbHKhP5fnjQ+7r/98MUCKGt+r?=
 =?us-ascii?Q?2sPVaJn73R1Y8AezFHcYgzlTMNwr3CAzUIKAXFkbgh2NTLLlUGRWhFGQ3kk/?=
 =?us-ascii?Q?U9b/bcK1lkXEo6smXqTeE2mNtZN4nd3kXGIjPpjVg+6cybHjJVcdMXZEIoe6?=
 =?us-ascii?Q?UjrX58dcH7ZL2STzHuCXVqsvJmP5QPu2Z8175CPPzDUVSm49rDK3DwEaW0uY?=
 =?us-ascii?Q?HOBo7KflsEaqaf1aUL8Q2erbWP2W1pZwFq+Sk8KJ2k3MJqr27vKYMVoVTN1W?=
 =?us-ascii?Q?eqiEHdxvAJrtMHt2CANPDHk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <69B22C596402DA448C6030016D18838D@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB4864.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad2939d9-7292-42d1-4801-08d9d6c061f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jan 2022 18:13:21.4163
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lKXsEUrllC5FDmL6OI5PS2imaWgLgKAIELrhe0/BSLPDN0oqLKVE+XnCLihDqZ+CWRRwYuPapEAjjYsQ2wNWaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3471
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10226 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 spamscore=0
 phishscore=0 adultscore=0 suspectscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201130113
X-Proofpoint-ORIG-GUID: zkaEAnR5blq2yGSsU9aEVR76zvYKQlN-
X-Proofpoint-GUID: zkaEAnR5blq2yGSsU9aEVR76zvYKQlN-
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


> On Jan 13, 2022, at 12:24 PM, Steven Rostedt <rostedt@goodmis.org> wrote:
>=20
> On Tue, 11 Jan 2022 13:59:27 -0500
> Chuck Lever <chuck.lever@oracle.com> wrote:
>=20
>> Enable a struct sockaddr to be stored in a trace record as a
>> dynamically-sized field. The common cases are AF_INET and AF_INET6
>> which are different sizes, and are vastly smaller than a struct
>> sockaddr_storage.
>>=20
>> These are safer because, when used properly, the size of the
>> sockaddr destination field in each trace record is now guaranteed
>> to be the same as the source address that is being copied into it.
>>=20
>> Link: https://lore.kernel.org/all/164182978641.8391.8277203495236105391.=
stgit@bazille.1015granger.net/
>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>> ---
>=20
> This looks fine to me. The only comment I have is that the subject should
> be "tracing: ..." not "trace: ..." as "tracing" is what we use for the
> tracing subsystem.

Will fix.


> I'll test this out if I get time.

No hurry on my part.


--
Chuck Lever



