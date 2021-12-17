Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD2B7479103
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Dec 2021 17:11:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238874AbhLQQLZ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 17 Dec 2021 11:11:25 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:17346 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238858AbhLQQLZ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 17 Dec 2021 11:11:25 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BHFxBGr005679;
        Fri, 17 Dec 2021 16:11:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=3cyNAabdWB2G9uN74r+xvrkmQ5pTJZZD9jemhFd1/Jk=;
 b=nTUBTenN6lIUF9Vh/OenmG/R41I8QzpUjC5GpNde3MmiHeczb7mZHnkxr5JF8yJbDzwq
 30P3nXnucYpF6Qz3msw94z6l0DLiRWVku8R+Buc+xF+h+7dXlSNSYcH827D5dE6ZRazX
 XbFJf777KoXh7C8xb7Oy5OuiKx3AilQnz/MUyr9mrMIOewt1cMLgWdbN/3A3b7RaXoVI
 LNSyxLvOSehK+PRhINgT18f/OEsu4McOu4HSbSaTyUGzBBaPwCQlb8aLs5ttYDalYD48
 Z1jEDOYV+SXsOe8ICa38kFBePzRBldfc5ATdCpZQSkoYuppO7xMpX31yIzr+tyLGVWk/ ZA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cyknp65nx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Dec 2021 16:11:21 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1BHG6HxB047510;
        Fri, 17 Dec 2021 16:11:13 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2042.outbound.protection.outlook.com [104.47.57.42])
        by aserp3030.oracle.com with ESMTP id 3cyjubka7c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Dec 2021 16:11:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=buju4ztZuk3kTc5CmfrrmLExu1wwra8aie5B4aZZfcOuTa0FM+gPVTJOnOCglHQyHieWJobCPP/LMlMKRRw46105wCwH/6NiZO8uUn2KuvCgXbeQSNL/fOTDEdk0sHbn79VzGcoLd20xlz7Z7GHhs+7SmsttBq367VSu3IYkcJVBfL8KWzZe0BhfxvY1nXXzrV5pEpNzJhuFBYRN8OlAyOgSTGvDGV0XYdrtJ3KUUNv2oxLK3dOOU4y3l5Ys6Ht0MxWx0ZYmd/mVgu/fDEc5PRQr6XAL86/yjh/Pg3C2XLIUiumWFYynvWQaqiCJt5aosco4D5+cvlsCgUnwgU7WEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3cyNAabdWB2G9uN74r+xvrkmQ5pTJZZD9jemhFd1/Jk=;
 b=NK8ITQ65MB3gl+50CenTer5EpogNH5UWh+gUHgYocQ66bCJtO/5Q27WvjM+hxWYKEPM8rms9b7pXyXS0QdtTawma/lYAhCWo5fRQXCX36LmYjvcfUTQ4fR5Q6jqXSO2TOOJRV0DZTAuskeKCIE9QTadNX3vHmEWx5tqcZqkYvdEJR6zQhWSwBa0M/PbE4rVn74kUWGBPSWuCM7FAH2lKonsO5qj46htdLVoLj7EjdFe/wUJR+4aqdeg9+K5/Re2sJowtMsAajN7stEQ3dEr2rzKZX0cW30ywL9SczisOCuOe0X+3JqW4s4nMbnAWchaNfb8QRjwKS6f2umlcBvTGsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3cyNAabdWB2G9uN74r+xvrkmQ5pTJZZD9jemhFd1/Jk=;
 b=Q+uvxmMLqlUQqkbqkMsyjHd4WraIdrELaHrhStqbd25b5Megd/CwjHHNJbRI8jNDcjg4A4Uxav5I3YUPZJ1XGpn7qkwpcJNzoihVerPSBfeNa2ZFy4zndLNNj6ODL1WXiZlS3H0xBCogz1tRAKtYjux2XSC2rh7ciECk9l3mYVM=
Received: from CH0PR10MB4858.namprd10.prod.outlook.com (2603:10b6:610:cb::17)
 by CH0PR10MB4937.namprd10.prod.outlook.com (2603:10b6:610:c5::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.15; Fri, 17 Dec
 2021 16:11:11 +0000
Received: from CH0PR10MB4858.namprd10.prod.outlook.com
 ([fe80::ed9e:450f:88c8:853]) by CH0PR10MB4858.namprd10.prod.outlook.com
 ([fe80::ed9e:450f:88c8:853%8]) with mapi id 15.20.4778.016; Fri, 17 Dec 2021
 16:11:11 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Vasily Averin <vvs@virtuozzo.com>,
        Bruce Fields <bfields@fieldses.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Jeff Layton <jlayton@kernel.org>,
        "Denis V. Lunev" <den@virtuozzo.com>,
        Cyrill Gorcunov <gorcunov@virtuozzo.com>,
        Konstantin Khorenko <khorenko@virtuozzo.com>
Subject: Re: [PATCH] nfs: block notification on fs with its own ->lock
Thread-Topic: [PATCH] nfs: block notification on fs with its own ->lock
Thread-Index: AQHX8qE3BtED6z/nR0SluAIrWY7pQaw2PNyAgACfSgA=
Date:   Fri, 17 Dec 2021 16:11:11 +0000
Message-ID: <0C441CAE-06B6-4CC0-8A52-88957DCF76EF@oracle.com>
References: <20211216172013.GA13418@fieldses.org>
 <bb7b5a71-6ddf-5e22-e555-8ae22e5930fe@virtuozzo.com>
In-Reply-To: <bb7b5a71-6ddf-5e22-e555-8ae22e5930fe@virtuozzo.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9a069ec9-2e60-4b13-4285-08d9c177d7a9
x-ms-traffictypediagnostic: CH0PR10MB4937:EE_
x-microsoft-antispam-prvs: <CH0PR10MB493703BBA9A03F4092BCDD3193789@CH0PR10MB4937.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QBBrJf/gSzm1UM7F9n560LFJNWFSDMNM9DVA8Hbzm48f9GGrgF4u/A4/+AwCFSga/06V5IViSZA8srpBP2cJQ6bW9WEsG08izhupd/leNggVYUAbTvOwcQElKBCa43/siTD9l4J1NMbTnnJMaIagLg8mqz2C1TiQXXSYxX0Mwij/azTBYg+orTVbJoux2JdzMEULIdm2m35F4yy/Y7agpq7eeDlSaZXZKN8zZfiFp01Ebunf8TE51zvykIlVu8s5LmoifOWvpq8nk+dCHREsFS8paWNF6Nc7GGunfCHcI+oBPzAaY5fBSXl4WjXF8buan0SEKMWTfjDaIefFmKlK6IyYGtcSf3t5S0SZoa4t7g/AaC4KMxj8B5cVk0uWkZrIFeLS7F4Rm1NNfuZ+oYVLFKR5zl2XexHYoQgbUxIV9raR5RaDeDbjehWPqwRgWQrrtuC0r1gypR16TFUJoZG2SXxDHH4NN0l4CjL56uHubYSZumBmZa0uhkJJ/EF9xM1j0zg5rCXW0SPOnYl/SkaL+eyY99gX/b5k3IV1jTI4UCRlOSs6kAfy89ibAB+pFBEHj+eAYNbTB7RcIQPgFmOtOcTPfYy9SJkjDB4PWR8gj7oVyjmqhtCaGGovono32TjSHzMnWd82qfpvZUHPsDZswQw/Z7DX0frHx4oN4H2F5oKtsBgzdLnSDMnWll/ONJhUlmVVi9CbX/wjiaZ0M9nMDsELC+cHBLNOKD9F6QyQT099oRwqmg6H0v1AJoS7R+/h
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB4858.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6506007)(6512007)(186003)(53546011)(2616005)(5660300002)(76116006)(15650500001)(8676002)(2906002)(122000001)(33656002)(26005)(36756003)(66946007)(508600001)(66476007)(6486002)(83380400001)(38100700002)(110136005)(86362001)(4326008)(71200400001)(66446008)(66556008)(38070700005)(8936002)(64756008)(316002)(54906003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?f0+eIxnp+2BwpwwIObUhP3Q6E1zxN9po2xQS3AMY/wS3umqC8D0P9YAfw0uJ?=
 =?us-ascii?Q?aPpbAi2LgSvXJqb4AwB0vR6VHzXgNcyVDxwedrZg2U21FjmVkCqX5J3Ljovs?=
 =?us-ascii?Q?lFwFO5QuA+5E3XGM7A9hhBRHHtwkR7fVNAJxeBxP9Kf3V2k8ICMcEz84Zufp?=
 =?us-ascii?Q?9kl5yA2qEOdIlBLDbsfgT3DAHvR94R46wH8E2ePrM5dMBhfWkUhYHgl8Ocx3?=
 =?us-ascii?Q?T522AS9O+SpZMbqIy/LvzQxgkXH/HnSQvBuL2r7OfOFZfhkZDUjwcxdAcPk5?=
 =?us-ascii?Q?0FVhcao9nGfARwVLm3C8C6y6fTbVwg9t6gE0kgaBySYymT8Jt+Z38Q/1Mxzo?=
 =?us-ascii?Q?Jjm0cyuJ9vFnkIC24W1xJcvVq7W4FctS/1N7H1apqpgQD7E8nV7aULuQtb6T?=
 =?us-ascii?Q?ek64vnCLvOv7sQAwVrxx5JtRYibTdkECd1hrcTVPJZozMuT3cGhBMektj7b+?=
 =?us-ascii?Q?w3N/rWiUvuiD2qFWF9iTS1AboJXARB5g4kV0gZLZ7R2nXMPXCn/W7Ztxnw8g?=
 =?us-ascii?Q?fo76ZqwG+PPMPtSH/INIiZOyBNvzHt4hqnRD1PxoBB0dNyzHWHrDYSrRu/e6?=
 =?us-ascii?Q?kmTNgKm5kXf8BcPBl3r+UDOKYrvv3/hetJ/XMayWMwy32aCWumdvIH132LYs?=
 =?us-ascii?Q?GCs/OVyRookIMLcVmB+tGs21QP76tpurKiEXOgMYvoMpeVZWr8Bpq+zz4rJ2?=
 =?us-ascii?Q?/ZIwst7yZ54wA+kChgilM4WNjndxH4bid6BvQdJDkdSQ+fvlxi0Q26lSx4TL?=
 =?us-ascii?Q?/7zVApXkWbJH/RIEdfz4VwFI685FWiVHE0uFby+rd2IiMKdttjw1A7TE31U+?=
 =?us-ascii?Q?4v+25mFWBQotiUDlwRsDvo8Ki3gyTena+TcB4mb+iHe4p3Y2ZRivNSpSOwBh?=
 =?us-ascii?Q?aGnEJCK9qFvCzNImObgBJZpbQrbrBhU0Dc8/gWsA1OTc+8YU1YV6brCoSAIB?=
 =?us-ascii?Q?c148a+0Euq0OImyMvrHanm0/uUdjFPA0R3wAvaTb+CD9Rh2HT90I4vvXEZqj?=
 =?us-ascii?Q?dd1gabYv1pUJA6XRbl3hPsohGO+oOF1hU+tqPEgc7Udf/HGVTv3dItQjH3KC?=
 =?us-ascii?Q?aiQveWLwOuT1XjSTd527Qgqj3ASMLM1gATiz8HVht/1ZwWP0xC3scgNCaII4?=
 =?us-ascii?Q?opY5vV7kHvfaR8ZUYRuVxzlQv0e8LepLtH7PLQ4c0f9cckRaKjUIRkzwPFiO?=
 =?us-ascii?Q?mZLc3Vk1qmFtksM7CwZcdf+Q7UcjCw/2ZwfhIPspQULhLtO2DhpGXl4+zaNp?=
 =?us-ascii?Q?sT/chwdZlUfy6UMsrHMwvaVQkKaPLKMr84Oc6U2UB6IogSqnBTojtKvH/Kol?=
 =?us-ascii?Q?f+hdNAbjSKN6823NdNTnltCo2Q5DbUJOb7yB0HZ7+9yiMZ/k5d7GL+L9dZex?=
 =?us-ascii?Q?y4+xPVt6tCiUKHYXPW5nBoOLp/hrYyhhRAUdQklkQvlAAB6VuI45hktJUG3a?=
 =?us-ascii?Q?a5K5WtIJivkywkxHmTUK6kAMmvA9YpEch0gtpMFmhPMHAPYhfpr/wJ57Bvgh?=
 =?us-ascii?Q?3kXBxzW/V4Ix+Cx7xjvoO6ryYfPUx5ej/2A12YxInIqsi3K5SV9NZU47NN4x?=
 =?us-ascii?Q?ND4MBDOkPqp0PxjUTB3Y6kbD7dLIXIRlQ1y9Hqxpq0422dAsOXh4AMuSHL73?=
 =?us-ascii?Q?/sf9ABe7fiV/GR4ldshPukU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A554BABF268BB141AC31C4CB25BE5F24@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB4858.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a069ec9-2e60-4b13-4285-08d9c177d7a9
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2021 16:11:11.2630
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CnlSs2S48vZw20W7/S9NwAs36DS9a4tAZZW4xy4uBW1+BciVBO/E90yafGSrZKkAVAT5XDOHOhvvu0MUCl8FrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4937
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10201 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=978 phishscore=0
 spamscore=0 mlxscore=0 adultscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112170093
X-Proofpoint-ORIG-GUID: OefK69Sn4_cqpeiZjAOh-sJPjhwrfpGK
X-Proofpoint-GUID: OefK69Sn4_cqpeiZjAOh-sJPjhwrfpGK
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


> On Dec 17, 2021, at 1:41 AM, Vasily Averin <vvs@virtuozzo.com> wrote:
>=20
> On 16.12.2021 20:20, J. Bruce Fields wrote:
>> From: "J. Bruce Fields" <bfields@redhat.com>
>>=20
>> NFSv4.1 supports an optional lock notification feature which notifies
>> the client when a lock comes available.  (Normally NFSv4 clients just
>> poll for locks if necessary.)  To make that work, we need to request a
>> blocking lock from the filesystem.
>>=20
>> We turned that off for NFS in f657f8eef3ff "nfs: don't atempt blocking
>> locks on nfs reexports" because it actually blocks the nfsd thread while
>> waiting for the lock.
>>=20
>> Thanks to Vasily Averin for pointing out that NFS isn't the only
>> filesystem with that problem.
>>=20
>> Any filesystem that leaves ->lock NULL will use posix_lock_file(), which
>> does the right thing.  Simplest is just to assume that any filesystem
>> that defines its own ->lock is not safe to request a blocking lock from.
>>=20
>> So, this patch mostly reverts f657f8eef3ff and b840be2f00c0, and instead
>> uses a check of ->lock (Vasily's suggestion) to decide whether to
>> support blocking lock notifications on a given filesystem.  Also add a
>> little documentation.
>>=20
>> Perhaps someday we could add back an export flag later to allow
>> filesystems with "good" ->lock methods to support blocking lock
>> notifications.
>>=20
>> Reported-by: Vasily Averin <vvs@virtuozzo.com>
>> Signed-off-by: J. Bruce Fields <bfields@redhat.com>
>=20
> Reviewed-by: Vasily  Averin <vvs@virtuozzo.com>

I've applied this with Vasily's R-b to for-next at

git://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git

I also cleaned up some checkpatch nits in the patch description.

It might be good for subsequent work in this area to be based
on the for-next branch so we can track what is done and what
is left to do.


--
Chuck Lever



