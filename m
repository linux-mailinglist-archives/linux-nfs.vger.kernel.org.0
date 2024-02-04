Return-Path: <linux-nfs+bounces-1750-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3558E849170
	for <lists+linux-nfs@lfdr.de>; Mon,  5 Feb 2024 00:06:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E8392827CF
	for <lists+linux-nfs@lfdr.de>; Sun,  4 Feb 2024 23:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEA90BE4C;
	Sun,  4 Feb 2024 23:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="L6ntViam";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="CHt+fdqm"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93C3CBE49
	for <linux-nfs@vger.kernel.org>; Sun,  4 Feb 2024 23:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707087985; cv=fail; b=NlvPGR8UQ0TrdfGm/mVqY/ieRYhzLVesIs1f91DiVtZkqxPx2kYbmGs8w++7J/MTTKpwhxNAIqXHW2GhHLgtk9aeCtLWqagl4R/N7KlEUqg94JkRx91Ll9/7oXVXyp7XXGzEAqgE01pa+zWjSxmvfwxXsmh3JlTBkvqze6fxNrg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707087985; c=relaxed/simple;
	bh=wKfedsrc6He45nSizSCYMIZ0Uyh/QUOS2FMxrAypbEw=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=INQ6rg1Voeig+WaijtDaCljeASZ1b78GZbefx0c+/AcCo43LJ5FI8/dC0kaVkT49oe8F+pALI52i/+w+et4+WQZqq+fwryqucAebS+lyAufbzCrUSPuUFbzJrTX/p7ti3ZJUshvTIhWbMXfU+j0EGVhtMtaKA9Sxs3AwNF+hZZA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=L6ntViam; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=CHt+fdqm; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 414KiiCp030788;
	Sun, 4 Feb 2024 23:06:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : content-id :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=Mt+q9/ipwBV8g2OTuO7IOUrjU9oOOxXpQnb8gEyDwLo=;
 b=L6ntViamn72MMwlqSLPqPi0di+jI6aFahlF98U1kiJgPdQl+bxmZ+GtwJNGXW7TQKhdr
 1U4sSFHkO9UnhC0M7cJEvi5IVqP9an63BEV9K3+Z9vFZIzrcD8hXHoHzuDQng8ZsO8gB
 i3+Vw5ADj+q+HdEg8mh6tDi62xbdV5+9N3XUppKM71FLcDDL0ZnigvqnQXLXTcsI2IIJ
 7NFi+Letxx2wHEVbPFY5h9L1GJm8s1095vbjYExoamGEyTgOgYn6Z8Iye4zo0P3ZjDZ9
 O7bOcg99alYxZFXZZnyzvln254EFS38ru0xERzGQzOmCubyfbOALF+EvaBmOpg4lGiUc Eg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w1c32jfpg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 04 Feb 2024 23:06:13 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 414LOxwL007040;
	Sun, 4 Feb 2024 23:06:13 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2041.outbound.protection.outlook.com [104.47.51.41])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3w1bx50s5g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 04 Feb 2024 23:06:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e8T//Savn5uAvBSvEdPtWDW9VKpnf+uFvVEgDCquHB+Us+Z3d1sesgVggq4aX/mHAXqu4QyugTBj518/WxmJYCvY2BnKKSJDWH/ZC2dPFFItOzzYaq/eDdgN1ghQHmk4GTwjZILHvtCb6fuw0IsDVeO47EP4zWyewmGJ2xAXjH2InnW4q7W7zDhbZ3yGjyH3y3eG7VGtyqop41sUtaPLrKyVKSLwgNRa5iXg3FNa4T4cMEbb3i66LrlNCBS7zUe8K1uaWhhhRKQoctfPPelVqqroLAYNARXsSkmMvG568sQxvyw24QYGus++6EzpBC0y37mVd+QZs8wGipfHRi8JCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mt+q9/ipwBV8g2OTuO7IOUrjU9oOOxXpQnb8gEyDwLo=;
 b=fnJNZuMEk9mGFcK0JLAglMCwX7ev2W9EsMjUzykUp+pj+JT1IHUQbl3NUl7qzpUwhoFW87LH8eJDBHOoQtYXaPQcMvUWZe5rbDWG15NttlAibslBp+x/gtJGzh8thQk3zlvKZevtfKOTCET2LjCpy4x51k/12mLpWesFcBuy1gTwP5/+6z7AEQIIBE8ImTwykHtgK3VEmRbjqAQjT1tZD2WGDxxqJwKLpXNYyp5tb2udn5WruUk1uojK8+InNemNleo3F2qJl1ruS9/PrqjI6MZ4FipgUjiUmqrxxktWxCGhslU8KJ8M/DejhI4K94F4GHriOma9Am0k0Lu/5y/P8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mt+q9/ipwBV8g2OTuO7IOUrjU9oOOxXpQnb8gEyDwLo=;
 b=CHt+fdqmBEGXI6hb+2oUQ4jbq3+t3A5tj9BnJkkd1p1qcLImf6E5SWM0Hl/mYdPy4vxV7x44+s1mfksT3wBWuBNX0Jy+tvAZvzsemdkXgVZxvmIY9fZ10xTw/McE5VtssPBlud8kC6b4kBPN5teT1sCyGv6Wt4oVWMVJ8roG8OM=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by IA1PR10MB6050.namprd10.prod.outlook.com (2603:10b6:208:38a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.34; Sun, 4 Feb
 2024 23:06:11 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ed:9f6b:7944:a2fa]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ed:9f6b:7944:a2fa%7]) with mapi id 15.20.7249.032; Sun, 4 Feb 2024
 23:06:10 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Neil Brown <neilb@suse.de>
CC: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: deadlock in RELEASE_LOCKOWNER path
Thread-Topic: deadlock in RELEASE_LOCKOWNER path
Thread-Index: AQHaV76+wVHeSw3IV06nDBIRcP0cug==
Date: Sun, 4 Feb 2024 23:06:10 +0000
Message-ID: <4270586C-9776-4DBF-BFB6-A36B79B1AFEA@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.400.31)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|IA1PR10MB6050:EE_
x-ms-office365-filtering-correlation-id: cb013b9f-a75f-47d1-5b1e-08dc25d5e0ce
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 cYHPxOCqczBovjjhreLycZrvRKTBgMe2hswerrxit5EY9Rz1vjWhSmrrcbnYjuPv0fgx802EyeKNEdw4Zux1IGikcYa0rcPKFx+u263x1/0av/sV7GGlsdxD5k/+qAc1zbXKYxylFis+5yFtv3TNTxJq9UsYRc02MrQVBojIuJHrK+Zu7c+sLJnj/+IolzNmhTv+LQDTuR5u0kT3Z3bw7ZoYMrZ0NMPqcwWl9NRCzxQoX45W7kGoznBjkjCGMhLGxU3io3jqXRvF3RzNcfDyrAjffDAA5cQDqkf4wxpbXAmKoNmgsQVdfht7/XCbJAyX/Y5sBxS5ZNWH4FLXw/CdZwETfmRHuVK6EeyDebSzGjSgNjZEySBKIbvqrdKNJm04tPot5XCoWV/qzVDJOebPPWyCSJ5N3bfEkbg8wB7VlS8T7f7MHJMA+fYv0W6ohvvPJSG4ljB4X3zA7Hjn/WpgWSo8se4JkITNErUYSO2hIt/hw2R+d5uofE+MNQwZxRZC1xaQ6IQHzQ5y7TRw6PbYzcOSExMiweqV79EXTDGCpISvc5UnBYdgK4TVpQv0fCfasR3RT+cMKD3ZY30lweS2mgB1UTjp1xaGxg5aaq/SvtBOQLb9J4fmZ5mwuf0tEgicphcAECwXIbJxFDaPboih4g==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(396003)(136003)(366004)(39860400002)(230922051799003)(230273577357003)(186009)(64100799003)(451199024)(1800799012)(86362001)(41300700001)(122000001)(38100700002)(38070700009)(8936002)(33656002)(4326008)(83380400001)(8676002)(5660300002)(6486002)(6506007)(478600001)(6512007)(26005)(316002)(76116006)(71200400001)(6916009)(66946007)(36756003)(64756008)(66446008)(66476007)(66556008)(2616005)(2906002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?yv8VjUblh2RRZwWh6ozgFQcqJ8jaA/4wilOH//dseUuGc2eMUQnLQgCQAaEm?=
 =?us-ascii?Q?3smGDN/VbkYcDkKqL6e5Mcd1pBktyHwkF+Ab1bSsQ9+/q3z90Fzsc8k66/C0?=
 =?us-ascii?Q?wPOy2WiyGaQrdjojO6V4q4sddEd1SzudFKuJ9zcbDFDiI2swmsenAReXvZu9?=
 =?us-ascii?Q?8UOn2D24qtPO2jX/8T5SFDxf82v/XWEJjyNJtVmZCm1ei9INSfhFCf9hBQHb?=
 =?us-ascii?Q?QR5RJcVMsvQ7hyEXTN/lkVzKVbqRU9puudq13bSOA8NxbQtQdsXPIV+1s2xo?=
 =?us-ascii?Q?cuqznUowmPJdADa/FAbxtUCVuj15mkGS4LFjea6AEceZ8OUHScyF+lUaPd98?=
 =?us-ascii?Q?j6h30FB/Yb5YFw16ZapOHOIQiov0RHJzyONzYG1/M6zCYT4ElrCFFJg3E6TA?=
 =?us-ascii?Q?T3p6E1Mo0Jni9rFMdUS41TSJCvQV95xImLfozBjFyD5nMkfXwTilS9Ayk0lg?=
 =?us-ascii?Q?GLGkObSaW8g4M/KR/y9qxav2cNikY60gvYKicJaAfTqwt0wVZneWaP/PrODq?=
 =?us-ascii?Q?1FC/1ML0OAiDmMZ63L8OxEfoifyXGqW36djfklSQBUapJ92RMWTOYD+wFaMA?=
 =?us-ascii?Q?AXIrHlHSiIn07JFDPxrFT3ZwNejgqfYVHApiHM2X53thRHM4x2RmhkV77+WU?=
 =?us-ascii?Q?kFr9rpw9tZheV2kWSPuEoS5g/TvBHZXJtYWqc5KOJB82gfPij73kvPqYB7nG?=
 =?us-ascii?Q?6blY1Cnc4iaquTISTS9jCqkAOD2vlYBJz4WI9VbruSzqJKzGJzn7OTPS0cSW?=
 =?us-ascii?Q?QgO1lotLA6Qgx4gOtlfCcV+MZHrf+O67rJ63raZJwOpmZJK8X7pkGbCbQNsK?=
 =?us-ascii?Q?p43HyRJ6G11dR3Xr5aGN8lmgrSiPaH4w8VCbTQmap9Tfi8DO2dW65Ja5Ldzu?=
 =?us-ascii?Q?1h91nIQyqQVLAzvzlfgzrZvkBw+eypFc/Xhy/ATjxIxcNogU+OWMyDvMcXwz?=
 =?us-ascii?Q?V2KAp8BydQEwxOTsvuF7ZURsuc3F7inq6rnzPBvmZOEzWfGA/ITxv9yqa/6j?=
 =?us-ascii?Q?kToEfG+cKw3Ha2KFsgz7io3QTRMjd/FqhfgSb2v4vJZ0jb1XVTI5dWOABk/+?=
 =?us-ascii?Q?zkkf9r2Qqfj9GC9aXNsSeZS2WO9QbaqGlQ8U1zTSLpnBlhuE4RMp9coQeAdd?=
 =?us-ascii?Q?s2b28wF+mIxUv9xFBuoX5iMCysuonCBws8LJZ1MoLnOeXTSR2sM9KSgxqdao?=
 =?us-ascii?Q?P86y5yYzg+K/6jF4s4q+8i07ifAw3iGj1pt9Fq0KJflqgWLdALKyd4zuiS2i?=
 =?us-ascii?Q?YIKQRFxtxi1THeu68865D9Cd9CYIPmYZ+2gk2FQ7sQS3D9w4HOn81NrZX1Ld?=
 =?us-ascii?Q?p9NYpXra2uqU09rsuPrAjIIE3wMj5xGYIIFcNRN4E2Weu7elk103np6bKYkz?=
 =?us-ascii?Q?BSz408TB5DWXBns/wtWx5X5vakw0tJlyZxr4FetbIfapFUrcNUiLi00a33Jf?=
 =?us-ascii?Q?RwfmWQszzgg840Yk34xojskJYr0fXsA1WJJilO8B+Ga/zsrugnv/pmBL2Stf?=
 =?us-ascii?Q?bj8mO/iiTumqQjSBpqjYM4TXTr95RH5rHfx7nLcOdcqZEzQhfnYKjCv32X1E?=
 =?us-ascii?Q?siHhDHOPYUMKVDqicsQF6U2PtX1EUkXNiM1U4mh2DLLMuZubyRONcQB0kfs9?=
 =?us-ascii?Q?hQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F0D236F92C878D4DB4DD27AF00DC3887@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	wDYgoxF49cUIwAW4+zKJer0x7zQpdXJCms+1ivqB6KGJ25/xxAnFVEi17gDYZuk8FOIpClEKOpHkZSIo3k5UfidNi8+T/wUfTLkjUbWWxmLYWLEFeIO7RkP9FPiH3hixOqvaa8vflSr81I/zmvYgp7JpAGF4q5FGA5RptJJ1v1H7cWfEj+lIg7pDEMIXN8yApFzYlsx3MhPVxLkQ03A40DzITRsV9WcKpdhMG2rKzwZyv6FNDXdjAwT6kvHWtgscXi5UwjZIeuzumzRCFNtSn+9Z5eMEb8Iuy1oxDLd2wJNGxAgmft03mDNOvk6g9kD/R3Tuh1SFkqoXFTzOpdmv9ux8U/zu5uUsfFl3tvQpte++BQz9g4beV46bFlKhQ0UNhOljfM3czKwsPsNN68woWGh9xsb1z81zSVm82Djw61gVvAqIjZ2R2ya4tQ2MYShfOGKy4Zsjn0EVbTFTPu6+2Mz06n27B6xoHreSAT7wgeMU4Uk8kfRbA8cyuDfjfhVlHpOQY3XYoB9tJ6UXa2MNp/gT9YLyEU41GIO0HH2G5krUVdNqD0w8lrHvJsCiE8GEczcXnWGarVvaDyqct+EIcJ2blN41Ns4a+w6dTsNZLls=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb013b9f-a75f-47d1-5b1e-08dc25d5e0ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2024 23:06:10.9214
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HPPEUTqPbWZgJHBIgUW0W35lWxY13rSfWdJvPGLsjg8oow/aeDyMmS2uSBEfPO5jmlYofF4Yo8KNtLX3MV0zGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6050
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-04_14,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 mlxlogscore=787 bulkscore=0 mlxscore=0 adultscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402040179
X-Proofpoint-GUID: GVNZC7JKvTraSHs1OYGfc3_kKar1tPiH
X-Proofpoint-ORIG-GUID: GVNZC7JKvTraSHs1OYGfc3_kKar1tPiH

Hi Neil-

I'm testing v6.8-rc3 + nfsd-next. This series includes:

   nfsd: fix RELEASE_LOCKOWNER

and

   nfsd: don't call locks_release_private() twice concurrently


=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
WARNING: possible circular locking dependency detected
6.8.0-rc3-00052-gc20ad5c2d60c #1 Not tainted
------------------------------------------------------
nfsd/1218 is trying to acquire lock:
ffff88814d754198 (&ctx->flc_lock){+.+.}-{2:2}, at: check_for_locks+0xf6/0x1=
d0 [nfsd]

but task is already holding lock:
ffff8881210e61f0 (&fp->fi_lock){+.+.}-{2:2}, at: check_for_locks+0x2d/0x1d0=
 [nfsd]

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (&fp->fi_lock){+.+.}-{2:2}:
       _raw_spin_lock+0x2f/0x42
       nfsd_break_deleg_cb+0x295/0x2f6 [nfsd]
       __break_lease+0x38b/0x864
       break_lease+0x87/0xc2
       do_dentry_open+0x5df/0xc8d
       vfs_open+0xbb/0xc4
       dentry_open+0x5a/0x7a
       __nfsd_open.isra.0+0x1ed/0x2a3 [nfsd]
       nfsd_open_verified+0x16/0x1c [nfsd]
       nfsd_file_do_acquire+0x149c/0x1650 [nfsd]
       nfsd_file_acquire+0x16/0x1c [nfsd]
       nfsd4_commit+0x72/0x10c [nfsd]
       nfsd4_proc_compound+0x12c5/0x17a8 [nfsd]
       nfsd_dispatch+0x32f/0x590 [nfsd]
       svc_process_common+0xb64/0x13b8 [sunrpc]
       svc_process+0x3b8/0x40c [sunrpc]
       svc_recv+0x1478/0x1803 [sunrpc]
       nfsd+0x2a1/0x2e3 [nfsd]
       kthread+0x2cb/0x2da
       ret_from_fork+0x2a/0x62
       ret_from_fork_asm+0x1b/0x30

-> #0 (&ctx->flc_lock){+.+.}-{2:2}:
       __lock_acquire+0x1e49/0x27f7
       lock_acquire+0x25c/0x3df
       _raw_spin_lock+0x2f/0x42
       check_for_locks+0xf6/0x1d0 [nfsd]
       nfsd4_release_lockowner+0x2b9/0x3a4 [nfsd]
       nfsd4_proc_compound+0x12c5/0x17a8 [nfsd]
       nfsd_dispatch+0x32f/0x590 [nfsd]
       svc_process_common+0xb64/0x13b8 [sunrpc]
       svc_process+0x3b8/0x40c [sunrpc]
       svc_recv+0x1478/0x1803 [sunrpc]
       nfsd+0x2a1/0x2e3 [nfsd]
       kthread+0x2cb/0x2da
       ret_from_fork+0x2a/0x62
       ret_from_fork_asm+0x1b/0x30

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&fp->fi_lock);
                               lock(&ctx->flc_lock);
                               lock(&fp->fi_lock);
  lock(&ctx->flc_lock);

 *** DEADLOCK ***

2 locks held by nfsd/1218:
 #0: ffff88823a3ccf90 (&clp->cl_lock#2){+.+.}-{2:2}, at: nfsd4_release_lock=
owner+0x22d/0x3a4 [nfsd]
 #1: ffff8881210e61f0 (&fp->fi_lock){+.+.}-{2:2}, at: check_for_locks+0x2d/=
0x1d0 [nfsd]

stack backtrace:
CPU: 2 PID: 1218 Comm: nfsd Not tainted 6.8.0-rc3-00052-gc20ad5c2d60c #1
Hardware name: Supermicro Super Server/X10SRL-F, BIOS 3.3 10/28/2020
Call Trace:
 <TASK>
 dump_stack_lvl+0x70/0xa4
 dump_stack+0x10/0x16
 print_circular_bug+0x37c/0x38f
 check_noncircular+0x16d/0x19a
 ? __pfx_mark_lock+0x10/0x10
 ? __pfx_check_noncircular+0x10/0x10
 ? add_chain_block+0x142/0x19c
 __lock_acquire+0x1e49/0x27f7
 ? __pfx___lock_acquire+0x10/0x10
 ? check_for_locks+0xf6/0x1d0 [nfsd]
 lock_acquire+0x25c/0x3df
 ? check_for_locks+0xf6/0x1d0 [nfsd]
 ? __pfx_lock_acquire+0x10/0x10
 ? __kasan_check_write+0x14/0x1a
 ? do_raw_spin_lock+0x146/0x1ea
 _raw_spin_lock+0x2f/0x42
 ? check_for_locks+0xf6/0x1d0 [nfsd]
 check_for_locks+0xf6/0x1d0 [nfsd]
 nfsd4_release_lockowner+0x2b9/0x3a4 [nfsd]
 ? __pfx_nfsd4_release_lockowner+0x10/0x10 [nfsd]
 nfsd4_proc_compound+0x12c5/0x17a8 [nfsd]
 ? nfsd_read_splice_ok+0xe/0x1f [nfsd]
 nfsd_dispatch+0x32f/0x590 [nfsd]
 ? __pfx_nfsd_dispatch+0x10/0x10 [nfsd]
 ? svc_reserve+0xed/0xfc [sunrpc]
 svc_process_common+0xb64/0x13b8 [sunrpc]
 ? __pfx_svc_process_common+0x10/0x10 [sunrpc]
 ? __pfx_nfsd_dispatch+0x10/0x10 [nfsd]
 ? xdr_inline_decode+0x92/0x1cb [sunrpc]
 svc_process+0x3b8/0x40c [sunrpc]
 svc_recv+0x1478/0x1803 [sunrpc]
 nfsd+0x2a1/0x2e3 [nfsd]
 ? __kthread_parkme+0xcc/0x19c
 ? __pfx_nfsd+0x10/0x10 [nfsd]
 kthread+0x2cb/0x2da
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x2a/0x62
 ? __pfx_kthread+0x10/0x10
 ret_from_fork_asm+0x1b/0x30
 </TASK>

I get a very similar splat while testing v5.15.y and v5.10.y
with "nfsd: fix RELEASE_LOCKOWNER" applied. I'm circling back
to v6.1.y as well, but I expect I will see the same there.


--
Chuck Lever



