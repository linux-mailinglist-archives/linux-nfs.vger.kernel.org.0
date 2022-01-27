Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28E3349E83B
	for <lists+linux-nfs@lfdr.de>; Thu, 27 Jan 2022 18:00:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235052AbiA0RAT (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 27 Jan 2022 12:00:19 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:12222 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229861AbiA0RAS (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 27 Jan 2022 12:00:18 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20RFuFNk005848;
        Thu, 27 Jan 2022 17:00:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=Ni0maSW0Y508UH/tmfvOZb6ft56DJr1eNwoMAA7JEeM=;
 b=zZkH/M8HLhLK0GfBBK1zbFz7GwhSu6Mf1ktn4eBnG/kiIOlWdaXDcPjDTU7Zjma/R/3q
 XlbkOq09WZr7iasbgOapkGuLn5hx0MLhHa32uxikrE1ErL5/fBUXz2B6jCLMFQvIqEgS
 9ED19w0I/Q9Cq/DAUke7kGuZ0gE5MxFQeeTyizvYFh3Kx/sAcZNImSsI7EhvY5ItDpqo
 +nD2Fw2NHxMZbidqXsDb4vrE7+iFIuzeDhNjGTjTbnaFAHgGgckR2IembNvVcvqSMR2B
 srItp2qJxm9FoF9hsAgqQxYyYjsJlWun2mXk8rmHaQpQSSk8ySORrTgQyDNw8Dlqyw9I Nw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3duvsj0mks-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Jan 2022 17:00:15 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20RGtdlC151438;
        Thu, 27 Jan 2022 17:00:15 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2174.outbound.protection.outlook.com [104.47.58.174])
        by aserp3030.oracle.com with ESMTP id 3dr7ym7gpk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Jan 2022 17:00:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aG9lvi/c0XfW19O27SreoNDj3mm+4z+l7pLUlOn1CHFlh924OOq0I8qexZMXgvY1cFc7WjpL+Z5tauUdzlFsUUJCmSOVSbVNJuxsgo5gIjwU9wzbRrGKRNSuPKn4JMIAjGbHZJGrJcHXk/6S2xZ2bHtz/mYzO2Cw9476XuJT0ZdFWJeeZiQ5CUdG4e0l8yrc/b0oZobk2dbXNGiNWQQleN1y+gZfIpQSfAi6cRYHJZlSmgHFsPPWW6OWth1l638JsVCutWweIdl8M4+xIH7OVA7/e1VhiPS51m2MLVyPUUk+kbyK/lE373+dxrzYWPySYGMEmun3alHYaYgtas/GIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ni0maSW0Y508UH/tmfvOZb6ft56DJr1eNwoMAA7JEeM=;
 b=YZ01GNKjXIhYDZE7Dv5HLiBJBfMDxN1M4fQxCVvYLuYQuCaS8+3DdisL5ipUB38dmFSQ+jHpkn/i8mGOG9szty4IbxLLsZxV6lgC1Uv/Ik04FqEeEAjRhc3XNtdWCgtwsIZymCGzZ7U5w6g6o31AsuvXoQth3ewmJhY4fi/E/rbWNF/F7VcgB2rBz5NHDIFKkrlxY8rEU2sRVjPk6rPPJPsM18QWYT6+QYPd7ZZxMHgfbRnZpamXnR/wPmVr29s72rht3S/EnvmPPdtAOKfvJLuK2u5Uh9AAYruiRzDQlsxWq/LQ0RMmLMcH+BW0kMFSDc9y+jaA+ZyeHHxe+8DRRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ni0maSW0Y508UH/tmfvOZb6ft56DJr1eNwoMAA7JEeM=;
 b=VQBS4mqBnGiSTSzmKf16vprkYhey65l3kskjOGUAPAd9BAxTa3cIUiSBZVJIVNOXvNmSpMRo86pZbiQ8MxrQmdAj+ryMf6CyAXdno8c2Ohi5kS1pnRjSvLE98QMkcx/75PWsZmBdlwjQvPTZEjSM2MiYl1/J5Aod+IKHQsCFHSo=
Received: from DS7PR10MB4864.namprd10.prod.outlook.com (2603:10b6:5:3a2::5) by
 SJ0PR10MB5833.namprd10.prod.outlook.com (2603:10b6:a03:3ed::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.12; Thu, 27 Jan
 2022 17:00:12 +0000
Received: from DS7PR10MB4864.namprd10.prod.outlook.com
 ([fe80::16d:ecf0:1ab6:7401]) by DS7PR10MB4864.namprd10.prod.outlook.com
 ([fe80::16d:ecf0:1ab6:7401%2]) with mapi id 15.20.4930.017; Thu, 27 Jan 2022
 17:00:12 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Neil Brown <neilb@suse.de>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [RFC PATCH 0/4] nfsd: allow NFSv4 state to be revoked.
Thread-Topic: [RFC PATCH 0/4] nfsd: allow NFSv4 state to be revoked.
Thread-Index: AQHYEzqzINafEUb13kObHCDc0cTYeKx3GDuA
Date:   Thu, 27 Jan 2022 17:00:12 +0000
Message-ID: <7B388FE8-1109-4EDD-B716-661870B446C7@oracle.com>
References: <164325908579.23133.4781039121536248752.stgit@noble.brown>
In-Reply-To: <164325908579.23133.4781039121536248752.stgit@noble.brown>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e624970b-5647-4657-f864-08d9e1b67bb3
x-ms-traffictypediagnostic: SJ0PR10MB5833:EE_
x-microsoft-antispam-prvs: <SJ0PR10MB583388C4C3F387079E1CDE1493219@SJ0PR10MB5833.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RwLXLFmUChXsStWiErbaAqsNFb3ELu1qsCSIguYkt4rBU4BfvNGr1eMS7ZcJAn8MbOJI7yoTvflD0oLIGE2q70BJf7lK7yKGE22I8nORSboBmwUl8Sgn6eVyWcYbxnSnnGBNS7DUQBKo+DrmRo8mdBOBEZFAaCWJNVVEPJMsZ+UqvA4fvWnjS8pgZt0duOyHYMVFtYDE/erLogJ2SYIPg0Jm2UB11AK4WwjQNIIJruUrvLeLi4fClCZWWwVrfscoarotODHDjvwSJFVXFfsLlSg/UMCMj3WF421dKXgwEltw8MnJCwRd9PTF1CgIrOAHiGdqM69tBcuLqrbizHd6KwaVnBOVi/pHHkfP7HGsBF2+ZBSoUe5b0G9PdT7p1yrRIZPc6R4UNMPZs+7TNERaTz5m3o51sXJhn+NXf2DYBdlGUDXo8+CN1dTh3kU+swZTK4NhhdiO8/VG2UTN0A7SsGJyUU/68qx1LcLwj0Ng29ELPBQTZxhBkrHlkAt2G3R2O7IRCLELbQDBQFhX6Wz1cebzMfqGd7/ht7duuLhb1K5rqrjfsQf+COyxBHmpxow+db7SxjN8UPeqbQ14X8d1sbFIoIM/BZljV6SAvNk9oTegR2IkYIhuIuN0K+nR2Hw0c9U6a9+YuguG3vqV+/wopV1X7mRL2AqRJBRa3bhymsIuqwUp8sgvb1TDayngNv6VMrB2AAUFYhU9L9jBj3EpywcLdOJ9XdN/HTpsU/Gh6ugmxm1s6VjhFIQwq1G2Jqvn
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB4864.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6916009)(91956017)(53546011)(4326008)(71200400001)(66946007)(186003)(508600001)(86362001)(6506007)(83380400001)(36756003)(2906002)(8676002)(8936002)(316002)(5660300002)(26005)(38070700005)(6512007)(38100700002)(122000001)(6486002)(64756008)(66446008)(33656002)(2616005)(66556008)(66476007)(76116006)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?MSEv61IUD8d1gHlIVay2Q/tSY3ECxsXp8TiIgRRgp/G+zOx/HkEKnyFhngB9?=
 =?us-ascii?Q?j4Z+e6R7b+bIcGYN6XgFa2C0RONWZTVgWGY8HeG6O8T1bJD5y4VwUepN7j4u?=
 =?us-ascii?Q?XsKLgW5S0nWY+gOpF8OqRBXcwevXJBsUqo7MKZ/AF9235NzX5fLs3hNmThYM?=
 =?us-ascii?Q?KNSUYDubRVoShfjNsAm/lO+Se6hvk4YAQVDwGtb2bYO+UB1zD9ktGS3flriQ?=
 =?us-ascii?Q?lmOmQFMo7yvao6k2FlFJl/J7A1HfiqKsjys++TOOtMoR9kVb6nTuBatYV36B?=
 =?us-ascii?Q?M1MUW2POCBJuBBLOEF5Xy8Ee9vcTsl9xfwwjllI4I2lh/p878OjuVICRlvWU?=
 =?us-ascii?Q?Ipb7w7R6mauGPXRyS5CcFEbzZgIcJElbvxSLPeIJ+1nxkg9Jkms0505LSFh1?=
 =?us-ascii?Q?1rBWwoNXTSjX+0fcNYaVbXtXCvXxHPPmEZl3A/Fo+ahhTwR5Lj3Bq1kXYJ6J?=
 =?us-ascii?Q?CUgyvwBFZnwZ4rzNWhr8WFnjJb8fquzws6TQGjD4mIOg0HlmQlngEZZbKw9M?=
 =?us-ascii?Q?MvoZF26S2ffZ3N0UrSAPibEHPPOU+D2KyTf9yhUCV/WxzwxUdlnaSDrFrxd8?=
 =?us-ascii?Q?5O0zI5T9M4Whs15Gv8vZBJ3da6kMiJrGELQW86EHRZAnRWJKDsjudS9ie/OP?=
 =?us-ascii?Q?Q64K+Yc40EYjjlqjeMQx/Zo7QBFLrKbH2wPpVZFw/L2rJxb2Yw7EEx4efbr9?=
 =?us-ascii?Q?JTaJklkDG0IJ8yqwRq16DMNkhTXFqqxjwgZqFWTT3vYtd3fe1IJaMg24eleJ?=
 =?us-ascii?Q?t+dDcNUC57FzS2YSwKDbo5mmYRRQysx4HiWJi31IjIfog7otbYGgtY+9B9My?=
 =?us-ascii?Q?W735Zs9JdCRc+wS317d0HopaRLbpBT5ZZT1Nhum9rNXFDWSPZmt6gSzwHaTM?=
 =?us-ascii?Q?IP00upZiEqrt3DV8prv11CCeyqMchKRhRGbks6fHwGR74YACl4XQSDPnXzoD?=
 =?us-ascii?Q?V8BmaR6pbMpfEf8AiKGdNb3g/IzQcSb6uicFjSnJYSGP9h2xUpYak2nskTWW?=
 =?us-ascii?Q?rEfXGWWZ6fuQ1DIBRmRZoaMUrzZiU2GSpFesavqskspp4s21XMpk3Bg8mps+?=
 =?us-ascii?Q?0kR5/pUAf+GYLPpCy/gHtQjQSA1eXfchAZhrglkUd7xvnUiSFwMEJZLjYXd/?=
 =?us-ascii?Q?YkqN+77HZbJPyVzqsQFkSM+udvTXhMNfN16MmGTW4kkif0E4UNM7W2Dt6AcR?=
 =?us-ascii?Q?p4iLuTQI0MEH8tjmXxXmHjw0WB5qtIrx4SGBrzTho06t4nBXQ6LehSuHQ283?=
 =?us-ascii?Q?dUc3wlXJJI58M1iurhsdF8P++lcXCXhxoX2GzYMvfEKKtGlhMm6ECpMER+Hc?=
 =?us-ascii?Q?zU9t2ZdMsZx6y8icHTEbMoqW1rIfiHzx8fAkMM0ytNEcJ/qAqIH1pxbRqKA5?=
 =?us-ascii?Q?/coRs1klKK4ciulabkhhInh6uaxC4R7dbQAovKNlzBE1GwFunnfWF8kA/uNn?=
 =?us-ascii?Q?6kTENss5LeZQ/evmELB8hL3ML3Q1YhGfsB6Xj0cV2KZoRwZjFHd4oZSrZDfH?=
 =?us-ascii?Q?8b/0KbmMl8ogAeCy4+5ujxS2EVcCkZ94kTuIA8wiBM5r0vNC6ssZ0X2wdVTF?=
 =?us-ascii?Q?7YWa2pEOeK4aHT4OVG/Y7ip6JpH9COecyq3t+xyT5fcHDjerxJdvguB9KNu0?=
 =?us-ascii?Q?tlpdq0WXH9IHKDZI73A47WQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F43AF24234D6DA4F8AEF2DC254718DF2@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB4864.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e624970b-5647-4657-f864-08d9e1b67bb3
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jan 2022 17:00:12.4700
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vXOqIHBT9V5dBpLQXlhWyzEdtmYCFNuzH+bXMoYCbpYqAo0CMLYGJ4L0AJh+lpGIdcKoSowNOLb2JplRb8mfoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5833
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10239 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 adultscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2201270101
X-Proofpoint-ORIG-GUID: IeSdtlc81KJ-gzGfWV8ZclRN1rE2GXl5
X-Proofpoint-GUID: IeSdtlc81KJ-gzGfWV8ZclRN1rE2GXl5
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Neil-

> On Jan 26, 2022, at 11:58 PM, NeilBrown <neilb@suse.de> wrote:
>=20
> If a filesystem is exported to a client with NFSv4 and that client holds
> a file open, the filesystem cannot be unmounted without either stopping t=
he
> NFS server completely, or blocking all access from that client
> (unexporting all filesystems) and waiting for the lease timeout.
>=20
> For NFSv3 - and particularly NLM - it is possible to revoke all state by
> writing the path to the filesystem into /proc/fs/nfsd/unlock_filesystem.
>=20
> This series extends this functionality to NFSv4.  With this, to unmount
> an exported filesystem is it sufficient to disable export of that
> filesystem, and then write the path to unlock_filesystem.
>=20
> I've cursed mainly on NFSv4.1 and later for this.  I haven't tested
> yet with NFSv4.0 which has different mechanisms for state management.
>=20
> If this series is seen as a general acceptable approach, I'll look into
> the NFSv4.0 aspects properly and make sure it works there.

I've browsed this series and need to think about:
- whether we want to enable administrative state revocation and
- whether NFSv4.0 can support that reasonably

In particular, are there security consequences for revoking
state? What would applications see, and would that depend on
which minor version is in use? Are there data corruption risks
if this facility were to be misused?

Also, Dai's courteous server work is something that potentially
conflicts with some of this, and I'd like to see that go in
first.

Do you have specific user requests for this feature, and if so,
what are the particular usage scenarios?


> Thanks,
> NeilBrown
>=20
>=20
> ---
>=20
> NeilBrown (4):
>      nfsd: prepare for supporting admin-revocation of state
>      nfsd: allow open state ids to be revoked and then freed
>      nfsd: allow lock state ids to be revoked and then freed
>      nfsd: allow delegation state ids to be revoked and then freed
>=20
>=20
> fs/nfsd/nfs4state.c | 105 ++++++++++++++++++++++++++++++++++++++++----
> 1 file changed, 96 insertions(+), 9 deletions(-)
>=20
> --
> Signature

You should fill this in. :-)

--
Chuck Lever



