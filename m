Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE25B6E7B59
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Apr 2023 15:55:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231496AbjDSNzg (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 19 Apr 2023 09:55:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231506AbjDSNzb (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 19 Apr 2023 09:55:31 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 936B61BC1
        for <linux-nfs@vger.kernel.org>; Wed, 19 Apr 2023 06:55:21 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33JBcMvK025475;
        Wed, 19 Apr 2023 13:55:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=+raqHiiUlnXz2rZeh14sWV78sV3N4TAf/97YZNOQIjM=;
 b=Hd5yv21KO2Lj5SYh3OuuXDv5t1kl2i4K6fgUO2oUe1uGipJYVgDxrdJdd5yLGxhvmkPv
 aBka50anQ+mUiKEhdLoHiATbXJ7PFBCE+Kyw4OGob9kjUaFPRzGDISEs/85k3+fpim8d
 TLm9zMMaW+KZheSmmJxXSrU1tzChSQNTgzzGysPR2N9O9cOteQ1UNlASb2K/gSTNVw66
 Ar2F7kjYQltCMhtnCbsHizQCiq7FjwYf/n7meuIRSiOvMBwuUVXDmOKvh2la+OEFUgsO
 04jlXM8N5m91PQKJpvntIxehBHx5SZcYEqpk2teCWeus/Mci1k6CULIJoxw2n0F4xASB cw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pykyd0d5a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Apr 2023 13:55:18 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33JC5lHO037785;
        Wed, 19 Apr 2023 13:55:17 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3pyjc6yayg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Apr 2023 13:55:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LrnUEh/I1ADLZFIFsQZN4BHYbKyK68fXYNeZg/qCKTKz7cLs/v1u48P0grIqMOZBwlrbH/yPYDXXxjZJsmOr13rKXU+onthwkIlPU9zKY877zTXVrZW5Rhmz++0069bMF9tmma0naxtu5mQcKU5wZGUANjiV639Dvf53qX+lNquqmals3bfqH/Z+kP+gHrj0V2TOh72Lx7MfNeof2BVeAdo4o7O2SvgWmgnu5cxvWK7Iq2FVHAWeyhmA6sqg51o5E6Lye1R4nVCbk50/qmKnDizxElukWc/kikdhgZCC4r7/i2XQdtlOEcCgSEFfAKNFn4pPhW5Pf+r61P0c2dZz+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+raqHiiUlnXz2rZeh14sWV78sV3N4TAf/97YZNOQIjM=;
 b=TSYAjK3KnjTxLXd3wV30McocxT6smxzTaaf4107xK/tBOEThLsmGiUuYhzUgZ8VwWFnQak9AynHlHalP1O6kk60lPjmc5KMbsee4ER7ltgQQRuHGdLhkoVIHwKQ8weuNR+E0XVXDLGyetZmAhVotSd23xO5AKpRWG/2GjAnAuUdrlSA1nGQcBWYdQJwDoeh48TyVZVsr4hHlt+//EHCBBrHXXImHNQj6V501N2FLVYlNU4yeDpbEwlx95SgzqEzdk0oM68cL8c81QNorx/6d1cFnTHmnrUMYLUeoovdYFKmbZez0ncYTCYPARXoZ9x4050MzODOzt2F8u0mKEgJayQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+raqHiiUlnXz2rZeh14sWV78sV3N4TAf/97YZNOQIjM=;
 b=kz4HG0A82lWM3sEcZ+WCVawapWXq6/kkoMU96Gu3E+PVNTya6phxonSdYagqwKf5d7O+IZqcg2WEkGWcylYbLfFjf9NAheQEMdv8wTzAreCEYi5knlOgPaiFUwbdSdtqZ+SNnUAoOVZdVYFkxzdXL23DbBertgwnTGRX1tN7tWU=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BN0PR10MB5352.namprd10.prod.outlook.com (2603:10b6:408:114::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.22; Wed, 19 Apr
 2023 13:55:15 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ecbd:fc46:2528:36db]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ecbd:fc46:2528:36db%6]) with mapi id 15.20.6319.022; Wed, 19 Apr 2023
 13:55:15 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Dai Ngo <dai.ngo@oracle.com>
CC:     "jlayton@kernel.org" <jlayton@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] NFSD: Fix problem of COMMIT and NFS4ERR_DELAY in infinite
 loop
Thread-Topic: [PATCH] NFSD: Fix problem of COMMIT and NFS4ERR_DELAY in
 infinite loop
Thread-Index: AQHZcjTL+lC/NtMgQEeKxrnLESBF9a8yqKsA
Date:   Wed, 19 Apr 2023 13:55:15 +0000
Message-ID: <C6D9F61C-796D-4CF5-AA70-367EF411E173@oracle.com>
References: <1681849891-29377-1-git-send-email-dai.ngo@oracle.com>
In-Reply-To: <1681849891-29377-1-git-send-email-dai.ngo@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.500.231)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|BN0PR10MB5352:EE_
x-ms-office365-filtering-correlation-id: 6648e1c9-87c6-4ef8-a50d-08db40ddb3fc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: d+Atddp24BFqZhnPNa0agpYIGTUPQp1kNzYFLOfrCukZQlvzDENv2LUB9o8RT9mJodcRQC2bkihw5vmq48O4mTZjqnSqyhkreGlIiucazJIprxNyDtsY/M+5HZZMPGJC2GYY9x/9ltOm4wXCzZ/iJKVcCyvxhdf3J3S7hWz4vsR5b0RNhrA/IjRSB5zmgfmQKhYVF1leu2FbI+GgMMeMs9rC55xQu6tgrkT6Xyr2y9jIbmB9URK6r/CglkaN81abGLQh1Hs+swMCgtr3NmHMAmEoaz9Rg01tvO1IUWiAZ77ExsV0tc3Wd8SA1JtlWdk/M6v9bAXUgXi7zHA0AniUwqLl5KJMJ0SrTER1I9OIiA+DYNZ1z1T4sVY4Ffpis2ZqLHJ0CFmCXe+Yn0UyJqJFaaCfau+mZq5IK/nQ8vq39Ynm56AONecP0hnayNObyHAcV7SbPHQY3SKx9FFGMI7LB6kCzJcj/AP4qO6XC9a6egdEmiPk8rzXChfmELwXfN1L3LDBwAhYm5xJDfUjL0ObGr9Mcc09utR991TqvVZnYQNpcd87QRjNpfoL05Cy14A/TqEd3DyTIvTID0XEJRy7Yo3h/73gmsj0JWgP1HkzwRyKZQa/zWE31PoAbfXBtRqjUISPqDcdX013U47dKRXUsA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(396003)(376002)(366004)(136003)(39860400002)(451199021)(38070700005)(83380400001)(2616005)(2906002)(186003)(36756003)(5660300002)(53546011)(8676002)(6862004)(8936002)(6512007)(6506007)(26005)(38100700002)(122000001)(6486002)(33656002)(41300700001)(71200400001)(316002)(66556008)(66946007)(76116006)(478600001)(66446008)(66476007)(64756008)(91956017)(86362001)(4326008)(6636002)(37006003)(54906003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?4zWY+D3LXIwF8NN0fby6arTv4BA0DufGQn4tsLP+lyih/1tBUmAOr5z8RIjm?=
 =?us-ascii?Q?G1HLYvuT+Z+u7oSgy7qB3zxsUF0Nd8FpucjJ8TsRR37ZishHM0scqvAPcVUV?=
 =?us-ascii?Q?UmJbHswtJSC0YiPToz+GMPYKAzOCG0Uwty8ZIYG1gv0XNEqjwOCG/49CAdAO?=
 =?us-ascii?Q?Xra23P7UHgYoy2CrqMnbeXwEt827ubQfbscENU4tJMFR3JWSOkMNCJagORGq?=
 =?us-ascii?Q?i4NdsDonVwxReKZ/U9qTc3Wkfk+xJZ69PGu0OZfVQN9KmjGg/QdudiyyeVbS?=
 =?us-ascii?Q?PBvcqfZwGwsWMhMwRJB1/9yqEbF1E0f4w+zyFNsIxUr55AlDGSnV12rosEPp?=
 =?us-ascii?Q?p6RuXCIiSNs4MAnu6JbcV1zirBS4oG0MwU6tWVkW1Gqj6pYPIM4vaJBDD/5X?=
 =?us-ascii?Q?br3+4Ed0FyW4evE7+2WhxMeWGqlQjHMB71oecGsvpNR7i4DfRZxMKmeb3aBT?=
 =?us-ascii?Q?BpG2cdpHDg/elF2Onvz8RkeKAD+9W+6pA7qnkldoJAe1rSx5rilDQhk/nxOG?=
 =?us-ascii?Q?86pxJdCcy7sqG6r4CkFt5x/A2Bg/hqGItLiwUvL4N6HWYWoCe8S7X0xpxlOK?=
 =?us-ascii?Q?jNstdKLlp48Y5PD+z18C4DJoP6QjBe11C/MyXFJRFnk2+ffEc5SY1MUpAfl+?=
 =?us-ascii?Q?Zwg1SoXAJhjGWobkhmqkkcM9oFsYpbYgLM6eeCadJewRUavPO2Xg836DJ62B?=
 =?us-ascii?Q?jCyVMFYIVoXuOwEnbWZtMCCyUsUIXhGk0BfJmjmmByCrbmAxLua/7BkgFKX6?=
 =?us-ascii?Q?pqc6JrIcGQ8EJsd/uxWEk8DKvvSY5a6IMKfa5tSd9KuktAmCrPOnr4tGnUse?=
 =?us-ascii?Q?fvwjp+zSGEhiBCiUMwCeEHYNEcl9GvX2SKWxBQNHCVx7x/hZjZksJIwVqGRe?=
 =?us-ascii?Q?3agY4FsxVKjjH/0LOGA/m7qJVesciK7yKxHZlZAo0HSNt9jpbqylLQD9kHhy?=
 =?us-ascii?Q?2HhP+tHGc8ISo3vRb7GvoJqKoo80XByHoYOyUOmw+05+eMFPZABZEMIpA/pN?=
 =?us-ascii?Q?ws1Ubu9xDOB0C1Ds3sz/cm5hHTPxDCykc5S1sO+Mczv/LeR8LGb5mMmQChdV?=
 =?us-ascii?Q?TjtlIPPjLW86eiXHy0DVL1+DXkpz+jKPBmxBxR4CHM9t1QUHJHTOFfnaS1EM?=
 =?us-ascii?Q?PgexjsME3GJZxWmRBFwBSaqeXTcYzfbA2yNYK3a18zSqGvMZTxHJ7fMYK4Dv?=
 =?us-ascii?Q?8JAIa/404nzLXNkq8rRNgLFnzdngSiCg0KuEqfkoL51ewgZF+gHNMxW2DSD+?=
 =?us-ascii?Q?1AcHskYDDi0oPMIhIOIuoBXI0MDVyEk+UCb23wqjvpSguD2qHkHNuhxkqdNa?=
 =?us-ascii?Q?bvVQRFZnup3XQEV8sMBELUmeoJ0fw8dJtKZ9waLvzFP95muPF1QaZayJujRr?=
 =?us-ascii?Q?AeCLS2PUVKpukEscnW8bvpqQmla3ZlT16/MywlNRdJCVAuxrRpANgvcjxrT0?=
 =?us-ascii?Q?P3ncQEpZZMRXaTex9mJdcS061ZP7s3EOzhXxZX+Wl1cVF69lq0YNPuHcHJYp?=
 =?us-ascii?Q?kamYfa37JkH8BKgGKsyoV4PbS7Nt12NjT+WOXyYeCJl54uHiSKhXWd1ty/5U?=
 =?us-ascii?Q?oQFzMoA34fs1y88RzIleBo/DB5+poWPiulDqKbrCYIPTRPySbrCDV6KYR1et?=
 =?us-ascii?Q?4w=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <0E31B35E49E5214DADEA2BD8C9DEAE8B@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: MtSJaZMRG/+OAL3v4LfWcALd2qtpBKGdU4dsv4fNogXji+5nKFGjxJi5ouPFTa6ffwX2l6tTSV3EA/LTc2WEDZVabaJxRqhs6sIYsDM9ezYsxFlZglLbqLPZZxGBHKc0/Q/lETAOQ3etuKnTkn9rw3mcnCllMQhIwhCFelQkCmp4K7EKbaLc/idrGLADP/HQdKBx8PSYeh42oQUi+3dxgoLo+FBK+/cLF2EHdFyi17InyLZYA1mTXVabGCl2acLRmvXanqF1L2njT+U9rgdM8jPh9H0GP29VPH3nLGzOESGcLFffz4FWDnWXAnsdvyg1CivLD53ReWq+S67+deDZerJwEv9JGJEPoVvSVJ0n4vLxVE5gSsiJnYWeblItm71AkhEIZv50WCmvUZvcWrWf+vZu32WsQgsIH9loUKovVsRyXdhobODLvtcY10anKrnfqIGv/LK3FZ04Yl3gD0UYKD77a2mZPkQWpZHo0Zcpg12rhTcwJwYjPfCa4y6fW0DCvleQ8WZsydfGTRASd3TLz9fcurSxZ84hPLZ1V3yTixQeOvW0kbvmlF/1KOX6k6t/qIfJGPbQNV6IGTupzy2wA3Np4IVZfUuD8BPjcOUsRMb8txY3PXtmq/qexf7HVaKlfLk2ZPDTfVe6xpJ53KI3u5qDTOajaAiQonagMJODwryYYyaAMQfoDqo30AFlldlhtWDhys+BUNfUWLz6xd7/Ia6WiwTVA9ocCr7qV6yZaDU0vyXZldfpfOWkJBZFqxkBbQpDcgNIiwmI9KhYLEnBwmGyxjpkv+yykYzzFR9RqfY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6648e1c9-87c6-4ef8-a50d-08db40ddb3fc
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2023 13:55:15.4145
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M46OY2ShTwzwPaa9zbbcriGdr29rlP61Q5uvtUpcNiWYNEV+MvvSqpLePJeqlHVNUvVs75VKFw/rdiiE4pWTgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5352
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-19_09,2023-04-18_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 spamscore=0 malwarescore=0 suspectscore=0 mlxscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304190125
X-Proofpoint-GUID: a3AzN6TzkgM17TZ5yHeGruJm9f_ZIx_p
X-Proofpoint-ORIG-GUID: a3AzN6TzkgM17TZ5yHeGruJm9f_ZIx_p
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Apr 18, 2023, at 4:31 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
>=20
> The following request sequence to the same file causes the NFS client and
> server to get into an infinite loop with COMMIT and NFS4ERR_DELAY:
>=20
> OPEN
> REMOVE
> WRITE
> COMMIT
>=20
> Problem reported test recall11, recall12, recall14, recall20, recall22,
> recall40, recall42, recall48, recall50 of nfstest suite.
>=20
> This patch restores the handling of race condition in nfsd_file_do_acquir=
e
> with unlink to that prior of the regression.
>=20
> Fixes: ac3a2585f018 ("nfsd: rework refcounting in filecache")
> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>

Since we are very late in the -rc cycle, I'd like to apply this
to nfsd-next. The Fixes tag will ensure it gets backported
appropriately.

However, this patch fails to apply to nfsd-next. Can you rebase?


> ---
> fs/nfsd/filecache.c | 4 +---
> 1 file changed, 1 insertion(+), 3 deletions(-)
>=20
> diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> index 6e8712bd7c99..63f7d9f4ea99 100644
> --- a/fs/nfsd/filecache.c
> +++ b/fs/nfsd/filecache.c
> @@ -1170,9 +1170,7 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, struct=
 svc_fh *fhp,
> * If construction failed, or we raced with a call to unlink()
> * then unhash.
> */
> - if (status =3D=3D nfs_ok && key.inode->i_nlink =3D=3D 0)
> - status =3D nfserr_jukebox;
> - if (status !=3D nfs_ok)
> + if (status !=3D nfs_ok || key.inode->i_nlink =3D=3D 0)
> nfsd_file_unhash(nf);
> clear_bit_unlock(NFSD_FILE_PENDING, &nf->nf_flags);
> smp_mb__after_atomic();
> --=20
> 2.9.5
>=20

--
Chuck Lever


