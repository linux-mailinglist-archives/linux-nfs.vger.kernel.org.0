Return-Path: <linux-nfs+bounces-964-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EA6E825B2D
	for <lists+linux-nfs@lfdr.de>; Fri,  5 Jan 2024 20:40:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29F752857F9
	for <lists+linux-nfs@lfdr.de>; Fri,  5 Jan 2024 19:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A710835F12;
	Fri,  5 Jan 2024 19:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WC9CLaqH";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="rCYCAIbS"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBFE11DFC6;
	Fri,  5 Jan 2024 19:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 405JTSKl030283;
	Fri, 5 Jan 2024 19:40:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : content-id :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=j4tqLWNT0E4hjkV+GBuFR+SE6MMcWfCPGv5SPjSa12o=;
 b=WC9CLaqHPaY9Agn0TFCZ5ySmCkSe66bDZXGp3z2qu3hBrQpG3FAhK1tysw9fOKrSyk+w
 bVxX01Ve1byv+tJidEap/AuGURhCHM1u9kERX6iCqH6FJOow0Bb6VjwMpuouPY2o8zCd
 U7Zmsl0EYzx1zFTK52wrnfTvjxJd8fHnYdaYZRv9zUINJp+FVAkjJ5qu2rnLrBYc1eC+
 Lr9I18xyZgNrzxQY5ILanu29JltotVXVp0d23mYczO2XNStTVfNKNjcsOz/dSSn23GVf
 Si6vz6sPYFE/pu2PW018unngkBaE+uDiHucAFGabuwYuPuYE17UzOouAOij2LFVVxcAn mA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3veqyk01k6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 05 Jan 2024 19:40:15 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 405J3Rto023349;
	Fri, 5 Jan 2024 19:40:14 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ve1n7t6pe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 05 Jan 2024 19:40:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XUV+33mDfs4IrS+LVaPBWQsIXlcVL3OWXIFW9834DX8QrgtcgYg8dib/yXLmhUrJ/PpH8Uf/NWXXNoAHra5s+q1dX4SSUZnRHPcuJYApXghAVz0Mre7++NLtjpWYdHS2jn9AIRXxVJKCdghqQ/UBJ89fVDZCA82/4WkOEvkPNYFB1uD3tXWt3SzPixoeb2ajUwIVj3R+2LaPOeFl81MK42aj0k1ONEwsgB2dDX/gTD9yAKR7lypC9CESqvrS+HPtES3006ZzueZcxCG3HGFdMPDxauBWezl+tTkOrEhhWgsJtM8f0kX9YWcRLI3b3yoHKXipbNQ7QTFtCOMRs8n4rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j4tqLWNT0E4hjkV+GBuFR+SE6MMcWfCPGv5SPjSa12o=;
 b=SVMWQf+etVSOIJx6hPZ0M28JXEpCbdbpAn/zHwlsOqnGVAOp6cBhb/R5k+pIbBleqKu424k5FREAxD1EN4Vr7Gzu7LIzlIk0M4xG9L0wwgvYOHB/PhiKOTWfDtccDoXrYnbxfzDjM7lYEqBX6ayyFcSfRPBlqjF3fJwXXj6hlf0Q8fZ4R+sYIaKe7rCw9SGC+rehRKN82M9EXBeRsxkE3qGkROlD+MeyOuUUVi70BSMU8ilk5Qx3Hnsv2cWU+VuD/FSkUzAaP9g+eb/J/Sk25C6I3+bM4ySpcLY+vLCD5nRS2D0fb71vT4oVIm7q7uNgWylBk9onjrBLa7dr/Pzy0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j4tqLWNT0E4hjkV+GBuFR+SE6MMcWfCPGv5SPjSa12o=;
 b=rCYCAIbSIhgMGVrmFTzimj1hYWZAlXoRzqnfIm1gR+hXuf/v4tdStQm8Rh+i0Jf6mQECdKOUQfDWxpGfVX4y4w7sKwhjCZfBF6NNsWZD0t+y3YqM+zhIQlEeJIe684XOE4J/nzKnvn13BrYLP9RJCXoxKwq5tVhnkSEnYA8pAL4=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH3PR10MB7929.namprd10.prod.outlook.com (2603:10b6:610:1ca::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.17; Fri, 5 Jan
 2024 19:40:12 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c%4]) with mapi id 15.20.7159.015; Fri, 5 Jan 2024
 19:40:12 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
CC: Jeff Layton <jlayton@kernel.org>,
        Linux NFS Mailing List
	<linux-nfs@vger.kernel.org>,
        Linux Kernel Mailing List
	<linux-kernel@vger.kernel.org>
Subject: [GIT PULL] one final NFSD fix for 6.7-rc
Thread-Topic: [GIT PULL] one final NFSD fix for 6.7-rc
Thread-Index: AQHaQA7/y163oZ0LKUyrZRtr15rq5A==
Date: Fri, 5 Jan 2024 19:40:12 +0000
Message-ID: <E16FA05B-5516-4138-915F-C6338F2939BB@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.200.91.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|CH3PR10MB7929:EE_
x-ms-office365-filtering-correlation-id: 2c64c0e0-486a-41be-0694-08dc0e2621f0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 LQgAJinbjPzVjZDIvHaIq5ivqb0N+BaM3eJpmOIImq7Jd9Un22A+EqE2nt042oGLENZEvHN5fBd0yE+gEON/jKDDq55kE38KXLHGEMlptEqjSSWkSBuTf1QoMAvc+jGQSTFJ24iRib8lvD/pBe1Rl9O4BAOwpaUzhT2T+ggg7gxcb4ypWcB/vGusDFBg61izluBctj26+CTLojYRvuAIQJt13zW06/Uoi0L166TZvKOWBodfGZt7MhvMrjaVHMiI1+m6reSci2PujXalH4PfdNY3l3cRKIoqqMk9lEVFnOAjXo3kduG2Nn2sL0yTzgPFrlJuj3O43fyLgIr8oUUMjA2yAjT8+8iTH+yZgwNMEE0LI4E9Gd7w97WAyTFYctinrATvsHXnlqvlzfpBF9oMD74R4pc4bd3r88J3ghf/dQua2P4ruSFy9codrosc5n8rCN8NalKTgcQB8IC3P4ir8fZHD9osAgafrMZgn8D85tZah/dtmGCGfec/cvSUTjyf4M+KnIr3DCmnL8tK4kDOA6sg0vFpgSa6RBjdHLiS7sgvpJwnP8IG+5Yn6l666w8TE7fQVSsWJXN4GtRL5AohCu9KjovrNa6TdtiVn/GQbLaoLgHejGa0TKFrUupk1etMtz+hFeeqTg6tvHuFtuRs2Q==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(366004)(39860400002)(346002)(396003)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(83380400001)(6512007)(26005)(2616005)(122000001)(66946007)(316002)(5660300002)(8936002)(8676002)(4326008)(4744005)(64756008)(66556008)(4001150100001)(2906002)(6916009)(6486002)(966005)(66446008)(6506007)(71200400001)(66476007)(54906003)(478600001)(41300700001)(91956017)(76116006)(33656002)(38100700002)(38070700009)(86362001)(36756003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?C+QeWCGTC/VAWiAOyiG//0Ri5yWaV46Vey4DL1OFJI2lGkl/5my1/MHYEu3k?=
 =?us-ascii?Q?ul5ADumxHNp9L5+b1qKQocP6RldUsXMfuoYJEZjYvbMlt17OSeC91yNP4Y9r?=
 =?us-ascii?Q?aruNlWkIcvTSJ3eOPKAhc1x9HD5UXtCjgzKsyHCaxygqByEmmL7g5fiG2L5F?=
 =?us-ascii?Q?QrWA8dDUNCWzYpWjilNcEInexi0tI+0hV+v/qpWWRt6DWW3lVGQmRb+jPqI+?=
 =?us-ascii?Q?FsvDKAniQkKGLF/Apb6dXASflwDc1Asy0X0i2/+Xybf0sriFw3v9/Alx9ljx?=
 =?us-ascii?Q?BNXvpbkg6MUjeyDcVeNRtGtOD6Ntj4OOrd5EX9RvMgwaePxcWdlX0/LikmPh?=
 =?us-ascii?Q?9eW3HN3orXWXw1uvLrbYMvXet1yOdQsQ1zKwgJJbWZY3FT+rhHSdsMLaako2?=
 =?us-ascii?Q?oBnetJNoqpOg5zGc6/H3MwVGc4wlOvl0JtRVAi7/X/LKUds92p7XYgXej7uB?=
 =?us-ascii?Q?NbinZfskfVPpPJP/3QswHsp9IZcT/DCEEuBqWSqCEYd+7bv4zKPNABYE8dBh?=
 =?us-ascii?Q?NVg+5JFY+T3TxJevwq84oXeQppKp50XrGzMKFFR1nrp60Oz87tH4fMkVJSGb?=
 =?us-ascii?Q?+v+h/ec9W1T0Vl3FOQKywsjBIS7rqM6LBj+wQS1UTS3688V9VBXcTAp8CTVI?=
 =?us-ascii?Q?OPDLMSsbh/8ROy90HQ5b2auWF7PQ5Z6d3fVrJvWMLfruNRQDWtB92cdpDxRe?=
 =?us-ascii?Q?GqPryOBHrA4FO7a2lLwnIZzvcMh1AYTXAWxEPsam9lA5mXNwnxAlyyfttPzE?=
 =?us-ascii?Q?RT1PzzExlYk6/0QR010+S33iJFxIm5Wdf8PHTo/602zODjIn53LCGbSyrZaR?=
 =?us-ascii?Q?3JM+Wz2d1OejV5J5XAIxD+C91oIs9GiBWZphXKssb6oAfjcFYziLZ8+UvmOI?=
 =?us-ascii?Q?k75sXYLoZ/vEXpDR5YPDQx1teyZwwY/VSIad3iT3MRqobrDyVpvDVUEl8dJE?=
 =?us-ascii?Q?2P4JRyBLMBXoX3pdZDhxzCCcCRK062+ph5rXUbqaeVzhJaBuEopXG2zMR1IB?=
 =?us-ascii?Q?I8yCLVdU5szjK04E9A1V6EA0m3HSlPcbTNKWZcYRdfrjMEGhcnH0MVUc87Rp?=
 =?us-ascii?Q?IimOYuk81U4CGrt+rH2Nx6UmImTFghx4YiKUGE8PdJEKtHypjOgVuSv++fcj?=
 =?us-ascii?Q?YsK84LxjmZLf/Cy0zQyFye6loh8A4+B7XWwCEmtOw49eYXOFnwmiFFHWfrnG?=
 =?us-ascii?Q?qfn/Pt70Y20U4lYyjM+5hJvVD/9whaE1W2MVgWwuZojYBEanBdzX0OIh1obp?=
 =?us-ascii?Q?q+M+ASkG46WGyU0VA5SIAYSmpv1V5Z6pEY5zLYn8M5CIFCA4FZZVzb7f064W?=
 =?us-ascii?Q?3EMcknwljqCUd0M/zF5+2c5wMilTM8CPT0BXGvON0oerHq8Jk677Nfs/ZJpo?=
 =?us-ascii?Q?7f7qppxD3qIk0dREi8Y1xNn2bbo0vb2yz+ON66IK8cueatuO8FiEmDu8v7Hc?=
 =?us-ascii?Q?vhqtpBoY/6+c/LjnZUKCdP1KecmXectLFRraatPEVpYypAjGZnTQXCHg1DDf?=
 =?us-ascii?Q?OQu00GvuEoiSYcZ7FVc8DIl25HStmIFUANV94fAXYAY/FOKcWWt2aOdhyZ3G?=
 =?us-ascii?Q?/M63PGAD++npEKxU9yQjuFi4tjg1XwkiSMjwg1N7RhLq6VatVfozBgYVSqyE?=
 =?us-ascii?Q?UA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <CF18E68ECCC46241A70FCD35C20DBD33@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	ermMSEEbE8Xckbi7LwSyYYoI5vmjatB8EnAROprKnq/9Afd3IVtACLDC//uMbacDkRj51lYyRXXcit5jfC3UEtai5397fHtoyXRjb54qMvhZHWVc6Avjn6Kx7fbSSslfTSRLsTviDVozgZ6hBE5MOJ8dTVZM1PH48Yf96A1FUlXulhLDioq7dj6BDO+RQY9ErtgJFj1dTyhoOd1Dvf3Rjt8b1QIKfUHAKV9z5C68CGhyk3MtazIdMPLO5xhGahUcUKnYzV/9IEXFR1w/kE2uXn9LLfMmALrNtseCJ/u1ZHL9sceL53bj9crv0kGEEM2UEQ0R2uLNUV1pFknah9ZRnt8Yu0WqiKoolFubr3iiMx5o9cYgUP1hy3lNe+2Lp3gRweL7KkA8R70SYNDVYQkDgu2ApycyWiN87gz9bqAGKUpd/I1cixezgAREXSMlqqPz9K75FmhG79z283xdtx0zRIGAfCdObbs+Llc7wsUSaxdxqOykUNes8iH0OAwDnhbLkgC953ixEVzV47/PpJAG+AVAXeQhcCU+4O2MWR1zs4GFu+IImdh4ZqSp5y9XedA/GmjXeVAG3CDDJUQ1Z4pSWojko9PuvgXQOrY6fwzRVpc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c64c0e0-486a-41be-0694-08dc0e2621f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jan 2024 19:40:12.0667
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: shlW0gAdy/8xftdmaFytJ9fxAx3at9M4/jjMqUSUlmOnje1hNzL0HBeGb8q2Yx8QS1fuBrRhhxMx8fmQpLHRnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7929
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-05_08,2024-01-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 spamscore=0
 mlxlogscore=681 malwarescore=0 suspectscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401050159
X-Proofpoint-GUID: 2UVJeSVQCwif2E749CkL10LJY9wiX8jC
X-Proofpoint-ORIG-GUID: 2UVJeSVQCwif2E749CkL10LJY9wiX8jC

The following changes since commit bd018b98ba84ca0c80abac1ef23ce726a809e58c=
:

  SUNRPC: Revert 5f7fc5d69f6e92ec0b38774c387f5cf7812c5806 (2023-12-18 17:10=
:52 -0500)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-6=
.7-3

for you to fetch changes up to 64e6304169f1e1f078e7f0798033f80a7fb0ea46:

  nfsd: drop the nfsd_put helper (2024-01-04 22:52:27 -0500)

----------------------------------------------------------------
nfsd-6.7 fixes:
- Fix another regression in the NFSD administrative API

----------------------------------------------------------------
Jeff Layton (1):
      nfsd: drop the nfsd_put helper

 fs/nfsd/nfsctl.c | 31 +++++++++++++++++--------------
 fs/nfsd/nfsd.h   |  7 -------
 2 files changed, 17 insertions(+), 21 deletions(-)

--
Chuck Lever



