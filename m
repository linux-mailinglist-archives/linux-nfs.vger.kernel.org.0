Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFE8D58545A
	for <lists+linux-nfs@lfdr.de>; Fri, 29 Jul 2022 19:21:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238328AbiG2RVO (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 29 Jul 2022 13:21:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232488AbiG2RVN (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 29 Jul 2022 13:21:13 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 209007F51E
        for <linux-nfs@vger.kernel.org>; Fri, 29 Jul 2022 10:21:12 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26TESnLk022859;
        Fri, 29 Jul 2022 17:21:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=l4Y0xO2EHmM5vPSAynGap8yr7k+vzRrzE69Klu324K0=;
 b=vm5GMl2YgcULiNZ/HSEb32E4TCA4OZ5GtQU3ohfyQv8D7zTVfJaQJMPYVkmzByAVqGQx
 rJnVY12dm1W064FRc01SYTLdPgWnaqIQSDPQt7sjebz+LbRNeG74BRQTRhjCohCSLUKI
 L02k8Z/0Tx5WsN58Yno6wy7UtrISm6J3LbIUFTwEEU8VhOw+NGjhJqHmCkyAZ54pzyIr
 42tw95yFEykyWGV95/ISEW4hZeu0CSvXVvMtRJbuPJqFuprN2n/CNarfEBK+TaVmh27/
 wurMIbifz0YKEX33k2kidrCtT5EiJ8RL1w0vLesgojoyuB+65B1G2TwTCUScI26ah2nM ug== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hg9a5019k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Jul 2022 17:21:03 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26TGeXt7034423;
        Fri, 29 Jul 2022 17:21:03 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2044.outbound.protection.outlook.com [104.47.56.44])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3hh636tr62-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Jul 2022 17:21:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WSHarGN4vYYsaSNJMJ4D/TRTqBGXa9ZWEEa6hWUctBnywqQk1GupkcXpA9YikQoM4yLY6H1IF/YcKpKvgR/Jtbtqg35qTBvq4luItd+/6xZZNSp4j33s3JisnpD4v3nHqCCJeBz3K7/Ha9u69SmMaoVoKDoWdBooyPhDPo922I6zMs5wUu50qMz2fGMUIwQhM2peZt5Ub0Z5GPrElCsVPiAQQ2tbp1BD+caXK1gin37MSGlhdWAJAdh5cY9etGxVoMx34xRpBltqtmAczzg7qXL6pRfWQMDXN6ZorJvBwkN9Vq7GZ+5ER1hv4RBmZTYdPZswVwpJVQY5q4xSaJPkjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l4Y0xO2EHmM5vPSAynGap8yr7k+vzRrzE69Klu324K0=;
 b=RmScnPSib24rL/TjszFfO8XZMIwq6WWc9xAO3AC1qkBbImWmV1iYqMuwud8vt/k1IcjoPwyvTmRGcDpFeoiRcy4pv392bVLaKoIjMRNmF46jxlbT758NQpJYO0QkErMpzUpvR8XoEX4hVtGvU3a2hjDcLCqAKfpKO2pO/oUd8pD08bH0CrAv6Z9X6V5hlmjX7tjLVbldTShb4XCJqB+w6NVz0iMogFyoiotK59iX3fBKy/KyRfW8M2/9ephHPGUydUfZiw8Rfd9WF7ZwdoE5ccwtzpOkFXCYuqNnn+paJ17xyER+GAGY5c7VAGLZImEPKUV/RYCbLjB7ynM1QXdvcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l4Y0xO2EHmM5vPSAynGap8yr7k+vzRrzE69Klu324K0=;
 b=psrKnVz9ky+9Rf6GeG8rx6Mri1x6PUoMkqpFWGC9HsRYfdlTY5b6hCRqxTBAhBSMWG80PweFB4FdnH0a8FDaTigKFW8NbDd1E1ZHPSKumw7PKV5W+Q0kzj2SpRmOR89Pgz7tooDfsl42+1XERv8sUUoAYjArizB86Ribi/9jNUM=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BN6PR10MB1313.namprd10.prod.outlook.com (2603:10b6:404:43::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.11; Fri, 29 Jul
 2022 17:21:01 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::8cc6:21c7:b3e7:5da6]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::8cc6:21c7:b3e7:5da6%9]) with mapi id 15.20.5482.011; Fri, 29 Jul 2022
 17:21:01 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Olga Kornievskaia <kolga@netapp.com>
Subject: Re: [PATCH 3/3] nfsd: eliminate the NFSD_FILE_BREAK_* flags
Thread-Topic: [PATCH 3/3] nfsd: eliminate the NFSD_FILE_BREAK_* flags
Thread-Index: AQHYo2rgY8a6WWViM0iW0L8RSDO/l62VmE8A
Date:   Fri, 29 Jul 2022 17:21:01 +0000
Message-ID: <5B5182C2-2B5D-4863-A6A4-8F3A6098A9AC@oracle.com>
References: <20220729164715.75702-1-jlayton@kernel.org>
 <20220729164715.75702-3-jlayton@kernel.org>
In-Reply-To: <20220729164715.75702-3-jlayton@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a2c43f78-f585-4094-cfd2-08da7186b5a8
x-ms-traffictypediagnostic: BN6PR10MB1313:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JzRstdXXdjI3n6kr4eFXWv3JjON2xpl+coUPqW1XCUUlxQ525HsV0lMowBDJx+x49GLpRJLoyxFmeRkZE5rGrt7Yw8XhM9+TVLREZzqVQIEYFCuqiQtyW9QQ2Xc+oj5kSZcKTPzQyUdZAFsmkiYeKjerDP418kUAUf9A56wDAsOs9beGs876uxeXWBVtyo6sBBd0V1cL3/y97eoFe1Tm5NucF8Z6dBG/fwTO7cQ+O7dhnGwnbG3iQ+4ynIatWDDJKWOzp88gxzKSGgHmJBwgup9gRJbDcga9DQYu+b3e6DYdOy/6JI80vGoR/0zid3AbwatzC6FT9727bIY2Rm2MW2P1TBdBC/tAE7z4AV6DljLqc6G5J2aSqoZrir6SYnpexJWp7ul7oiqiiYvr53owuNOM1R92ZpXaa7LbbOGMfTWEEGBYoGUMcSWJdSwHk6ihnzGrbcfs7082NuBqZ/bsssUJ/HeVV/4t2BUBq8Tlqym8GZOYEiM5mkRlQlbstnWPPQf4RPmF2Cwo1I1YoAh+obXxfWuJv5jc9Ph1+7eylfwlNWlCl1PVc6T+RpoShcA/YsTINvnVYB4AeALuAUbkKIF+b/ofOFt8gjRGUS22a1UQ8Bg3Sd+MU7zJMPkukpBhz8Qxc/jk4L/ywkWXge+cVMWM6NP0dWM/9u/JBOPqFiqyWgx28lDv6VXlgI21xQUQGjFbwqcS5rZRDq2ouH3GYg+UI3O8wajpnjPVvmfaDPnJAiW/PoksQ3h+b+ZzT4tWAJsXSD+0JC5fLdFbA+DSCBwRfbEWQXzWjglegHgkgq3qmSeGuOROhnqinz5MH6k6hmUVU0UkUv8pImo9P/57MDIZmsKQqK9Fls5kEV2UstR/6QJUPSWfJLJbV7x6KvLn
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(346002)(136003)(376002)(396003)(39860400002)(33656002)(38070700005)(5660300002)(122000001)(86362001)(91956017)(4326008)(38100700002)(66946007)(76116006)(66476007)(71200400001)(66556008)(64756008)(66446008)(8936002)(6486002)(966005)(478600001)(8676002)(316002)(54906003)(6916009)(186003)(2616005)(83380400001)(41300700001)(2906002)(6512007)(53546011)(6506007)(26005)(36756003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?n4Y9vwep3KbNpSlrKz9Mz8m2gbBJSJsUX3vXIgnugcrj38G4X5/AiaKrB3xn?=
 =?us-ascii?Q?CtU2G3LDRG85eW37bLkTmSB6/rGI1uweSAJYGkX6/xGcuWw1HdgLn0Fvvk/Y?=
 =?us-ascii?Q?h9i8TFafmzL/FO6z3kBBMUq2go/CSa22Plnr8fJEIlGGQ2GHSBrJFS6Lpgm4?=
 =?us-ascii?Q?HkPwYjdhWAVlClKF1Uzd/ZE5m5pjTyeEWGK43r6ifhQh8bzGv7k8QtrAI1f4?=
 =?us-ascii?Q?LCmM3gEytTgBaHjD4FeBe9FwftFvLD6NaDxp8VKkyvutQ/esw2BrCVGHznbK?=
 =?us-ascii?Q?Sfpz+ieVlSO7D3obpBgQGylh6nVolqQsdEX0EwVzntGUuwVfkuLBQ77+XnDR?=
 =?us-ascii?Q?ac8Qe67ga9HhPZHRv9S74qCG39ql0laRc6TZA7ER5YMPyy6/gZv9K5wjOtCJ?=
 =?us-ascii?Q?pODY4BrG6jx/Q/pvADIhvmuEA8WxQsknqHIsyZe0SJysNIGG2ur9fWfRlseL?=
 =?us-ascii?Q?sJayuYXL3cjEZXzyQj0tuJaOKHcohDGTIYrIrOfOq/enaBfgK9JdtajO1zPz?=
 =?us-ascii?Q?E7gBHtpW6zEFLvA5cSmQnQ72jHKPnQlUVEgzvZLn0QCYQMpsH3f/pfd9qsk4?=
 =?us-ascii?Q?ss88SSDhEd7km6CeWvdeKHf84vS+sXyQfWNb5w/iT6Bh3m7folQI+3O8lqND?=
 =?us-ascii?Q?TY3sV5fh7G/4YkpPvAHaX3yxRlO0869RlNhn5W7doAKhQXhfM+Y1PSWom6dP?=
 =?us-ascii?Q?6NFlmtkXssHYideqioQ28G7HXMq3SSBtjsaimA7Ly4eK+PD1ZBeICSSOBTb+?=
 =?us-ascii?Q?Fj9TND+ozrDr9Izw4dk0r8weExgkpXGyhzZjWEndB3RamUc8pQsERABQb9pd?=
 =?us-ascii?Q?ELuZfbL4PPyA6jjv7Rz0uoY7/Nmwvly+PGU1aTJT0KBQ9qR9FQYa0zL/EI1v?=
 =?us-ascii?Q?b1L9qZhRQhliq5MJzUfQOxYOt6MA34ztRMU489FHk9FRHVnAutfrBHJg5KkW?=
 =?us-ascii?Q?T9nIs0gAsfNRwXv3HsB//OeOub5PNmTCGA5czf9U16ISCYTqKPQY5mn3uJQv?=
 =?us-ascii?Q?GBymHvylSzdjAE2ItjGYWnu/MxMSFo7q0bVTSPAZ7uqPFjic1VwwO9oARr+H?=
 =?us-ascii?Q?uqZjG8IT3tDiNCr7/8PZExLWZcUwrRALMBBQyoP/SmJGqDHJl9eFqN7KK8bp?=
 =?us-ascii?Q?L1OIAcPNBA75mRV/zser8Js7LKsixMzgJH26XiujuUva4/DGk5qP1Emh2jrB?=
 =?us-ascii?Q?BfAaRWesC6EVWTR90kczi+InKXoMljn2yuYlWNxI9aEu4yJseyhiUuXbXOH/?=
 =?us-ascii?Q?npV5rr7PtejzFVLx0IGtPOiA9L2BgfF02pi1OKopG9FKtRuK4Ny7XEs5Q7i9?=
 =?us-ascii?Q?i8GvUojzfoFiA4vYULMX+qifd2AQwrH09+WqDBGLiPH+zGc2/DZLS5SSqcoN?=
 =?us-ascii?Q?B77vvGg3ntOp/G0cQxgiyweyOsHJGXctyyTh5IEmBc/Bdchrox40Uc+Ku/cB?=
 =?us-ascii?Q?J6TLnGkICD0ngDpZufYYG58u0l5BczIXkILAa6Uj2p2AEL6T5jkWbQiiIzgA?=
 =?us-ascii?Q?XZeNgTAbliR4ozagsjxV0G8+7IWVfIy3nhDxY7ZA23+w3EMpVyOapFH6Axbn?=
 =?us-ascii?Q?WbxT0mce/lYy8mbqns+6hE/GhrbgEq7T7a72XIOh9AqFoy57gh/DhdLp5fJz?=
 =?us-ascii?Q?CQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4B3F58EC8C50D0439D4852610D56085B@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2c43f78-f585-4094-cfd2-08da7186b5a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jul 2022 17:21:01.3017
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2D02T4xhxVuTpUz5dFCaxoze0TEsok5i98eZFVJHhHE2X3AdmzkXQGIXAQwwsG8Mx25J+SA0WaWN+AIwzpKakg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR10MB1313
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-29_18,2022-07-28_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 malwarescore=0
 adultscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207290075
X-Proofpoint-ORIG-GUID: m5HcEIlHtBCrRwbCSo30bhOZv14V6iNj
X-Proofpoint-GUID: m5HcEIlHtBCrRwbCSo30bhOZv14V6iNj
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jul 29, 2022, at 12:47 PM, Jeff Layton <jlayton@kernel.org> wrote:
>=20
> We had a report from the spring Bake-a-thon of data corruption in some
> nfstest_interop tests. Looking at the traces showed the NFS server
> allowing a v3 WRITE to proceed while a read delegation was still
> outstanding.
>=20
> Currently, we only set NFSD_FILE_BREAK_* flags if
> NFSD_MAY_NOT_BREAK_LEASE was set when we call nfsd_file_alloc.
> NFSD_MAY_NOT_BREAK_LEASE was intended to be set when finding files for
> COMMIT ops, where we need a writeable filehandle but don't need to
> break read leases.
>=20
> It doesn't make any sense to consult that flag when allocating a file
> since the file may be used on subsequent calls where we do want to break
> the lease (and the usage of it here seems to be reverse from what it
> should be anyway).
>=20
> Also, after calling nfsd_open_break_lease, we don't want to clear the
> BREAK_* bits. A lease could end up being set on it later (more than
> once) and we need to be able to break those leases as well.
>=20
> This means that the NFSD_FILE_BREAK_* flags now just mirror
> NFSD_MAY_{READ,WRITE} flags, so there's no need for them at all. Just
> drop those flags and unconditionally call nfsd_open_break_lease every
> time.
>=20
> Link: https://bugzilla.redhat.com/show_bug.cgi?id=3D2107360
> Fixes: 65294c1f2c5e (nfsd: add a new struct file caching facility to nfsd=
)
> Reported-by: Olga Kornieskaia <kolga@netapp.com>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

I'm going to go out on a limb and predict this will conflict
heavily with the filecache overhaul patches I have queued for
next. :-)

Do you believe this is something that urgently needs to be
backported to stable kernels, or can it be rebased on top of
the filecache overhaul work?


> ---
> fs/nfsd/filecache.c | 26 +++-----------------------
> fs/nfsd/filecache.h |  4 +---
> fs/nfsd/trace.h     |  2 --
> 3 files changed, 4 insertions(+), 28 deletions(-)
>=20
> diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> index 4758c2a3fcf8..7e566ddca388 100644
> --- a/fs/nfsd/filecache.c
> +++ b/fs/nfsd/filecache.c
> @@ -283,7 +283,7 @@ nfsd_file_mark_find_or_create(struct nfsd_file *nf, s=
truct inode *inode)
> }
>=20
> static struct nfsd_file *
> -nfsd_file_alloc(struct nfsd_file_lookup_key *key, unsigned int may)
> +nfsd_file_alloc(struct nfsd_file_lookup_key *key)
> {
> 	struct nfsd_file *nf;
>=20
> @@ -301,12 +301,6 @@ nfsd_file_alloc(struct nfsd_file_lookup_key *key, un=
signed int may)
> 		/* nf_ref is pre-incremented for hash table */
> 		refcount_set(&nf->nf_ref, 2);
> 		nf->nf_may =3D key->need;
> -		if (may & NFSD_MAY_NOT_BREAK_LEASE) {
> -			if (may & NFSD_MAY_WRITE)
> -				__set_bit(NFSD_FILE_BREAK_WRITE, &nf->nf_flags);
> -			if (may & NFSD_MAY_READ)
> -				__set_bit(NFSD_FILE_BREAK_READ, &nf->nf_flags);
> -		}
> 		nf->nf_mark =3D NULL;
> 	}
> 	return nf;
> @@ -1090,7 +1084,7 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, struct=
 svc_fh *fhp,
> 	if (nf)
> 		goto wait_for_construction;
>=20
> -	new =3D nfsd_file_alloc(&key, may_flags);
> +	new =3D nfsd_file_alloc(&key);
> 	if (!new) {
> 		status =3D nfserr_jukebox;
> 		goto out_status;
> @@ -1130,21 +1124,7 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, struc=
t svc_fh *fhp,
> 	nfsd_file_lru_remove(nf);
> 	this_cpu_inc(nfsd_file_cache_hits);
>=20
> -	if (!(may_flags & NFSD_MAY_NOT_BREAK_LEASE)) {
> -		bool write =3D (may_flags & NFSD_MAY_WRITE);
> -
> -		if (test_bit(NFSD_FILE_BREAK_READ, &nf->nf_flags) ||
> -		    (test_bit(NFSD_FILE_BREAK_WRITE, &nf->nf_flags) && write)) {
> -			status =3D nfserrno(nfsd_open_break_lease(
> -					file_inode(nf->nf_file), may_flags));
> -			if (status =3D=3D nfs_ok) {
> -				clear_bit(NFSD_FILE_BREAK_READ, &nf->nf_flags);
> -				if (write)
> -					clear_bit(NFSD_FILE_BREAK_WRITE,
> -						  &nf->nf_flags);
> -			}
> -		}
> -	}
> +	status =3D nfserrno(nfsd_open_break_lease(file_inode(nf->nf_file), may_=
flags));
> out:
> 	if (status =3D=3D nfs_ok) {
> 		if (open)
> diff --git a/fs/nfsd/filecache.h b/fs/nfsd/filecache.h
> index d534b76cb65b..8e8c0c47d67d 100644
> --- a/fs/nfsd/filecache.h
> +++ b/fs/nfsd/filecache.h
> @@ -37,9 +37,7 @@ struct nfsd_file {
> 	struct net		*nf_net;
> #define NFSD_FILE_HASHED	(0)
> #define NFSD_FILE_PENDING	(1)
> -#define NFSD_FILE_BREAK_READ	(2)
> -#define NFSD_FILE_BREAK_WRITE	(3)
> -#define NFSD_FILE_REFERENCED	(4)
> +#define NFSD_FILE_REFERENCED	(2)
> 	unsigned long		nf_flags;
> 	struct inode		*nf_inode;	/* don't deref */
> 	refcount_t		nf_ref;
> diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
> index e9c5d0f56977..2bd867a96eba 100644
> --- a/fs/nfsd/trace.h
> +++ b/fs/nfsd/trace.h
> @@ -758,8 +758,6 @@ DEFINE_CLID_EVENT(confirmed_r);
> 	__print_flags(val, "|",						\
> 		{ 1 << NFSD_FILE_HASHED,	"HASHED" },		\
> 		{ 1 << NFSD_FILE_PENDING,	"PENDING" },		\
> -		{ 1 << NFSD_FILE_BREAK_READ,	"BREAK_READ" },		\
> -		{ 1 << NFSD_FILE_BREAK_WRITE,	"BREAK_WRITE" },	\
> 		{ 1 << NFSD_FILE_REFERENCED,	"REFERENCED"})
>=20
> DECLARE_EVENT_CLASS(nfsd_file_class,
> --=20
> 2.37.1
>=20

--
Chuck Lever



