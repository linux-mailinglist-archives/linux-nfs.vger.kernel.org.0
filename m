Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B34BD60E216
	for <lists+linux-nfs@lfdr.de>; Wed, 26 Oct 2022 15:23:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233512AbiJZNXc (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 26 Oct 2022 09:23:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233915AbiJZNWy (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 26 Oct 2022 09:22:54 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F20B361D83
        for <linux-nfs@vger.kernel.org>; Wed, 26 Oct 2022 06:22:52 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29QBEOEE002059;
        Wed, 26 Oct 2022 13:22:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=AeA4Mv5Uo7bd8DfGqmeuqty90heDq/U+NawqvQSOIqE=;
 b=ukTvXsyqyi+VlX9kJQrVxF+k+FHI/MOXpwt5G33ibXfAe/FcBumrk5lChYfpacX8Yln5
 BUg1b3g+KhgzX5RVhv8sMGyOUKM1beIyXyZJN+ahSa5cRpnTHiG3CcC9yK/Rp80YCfkP
 LVNxNbQvKF/hKKgTguu89XO728k3Rb8wNtC6zEN4ITNt+LAK+brIuptgzjFJ0UuaW0vu
 cKqYMVN4danTLQku21joaFzpQuB0ksyMV2Wvmq1jG3UpNNIcWHWQMI+5cnSqoYjIpZ+J
 Avs5+alG5qJFg1PmlGYZgcmdhf+efLoOjDEijyOUNgYk+MN5uHcSu6KT2RwsEQbRLbKl 1w== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kc8dbp9pb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Oct 2022 13:22:46 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29QD1OjU018021;
        Wed, 26 Oct 2022 13:22:45 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2177.outbound.protection.outlook.com [104.47.59.177])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kc6y5yw7d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Oct 2022 13:22:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=niNg/O4exY1+aZnNZbHK3PHhrswDFWlDPApfcOYNr/HQ8Ud2L6v9zoCLiS+2Pqcychbk5e5wF86ZldiFPk6WRQUSetkKYlNaw/637Lq3/MCJ5SBjXFOXIQiYXTPZ814TeXOlK7/5J51/SaftdXDUIhec2nX58falAbjR1vrt1d5QO7DfIpjuQY+N02QKUTfASEdOmv63/4QErBZdlJPAVeeVuYxQx5zIdZ7mVEykF8uWY2jvjfxkhQQZkcDNNpvVEhCtU0aW4qWqnoJ+hjr3CffYw9u8CoLKZvaV4EIm0Vqig6BHALlx7KvU47qyXIpL45ZT3sWw5/LoVRNHn2KHIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AeA4Mv5Uo7bd8DfGqmeuqty90heDq/U+NawqvQSOIqE=;
 b=cLMmSlHgZYNc6mkaWpfw93z4A0Ma6CCfkPhSVRVzwUSPg+thJ8SUV/XGPKYpW3uo5AkNOa9yRWp/2+ztuxKriMU3mw54+8vWeEyT51FCsJ+KnX6nYXXv2gZ/PvvtTMd3x1Mk4cYrwkuBSc72DNarmGVBuXY4nXDz3UWOCa7ObIWth8hFPaazZh34MkHrh5MhSDkUevGPKOTgCXchvfmLfy791KCoed8D/+guvjk5LugYDIUDu8skyhXTPEKWbNj+ERFMrvMLBf0BB96itbHnTlqBN+TjUzqwelC1OPLK76RIGGOfTKNwjw1+zBtySgERNoRaICJJUdhEVQLviq3JPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AeA4Mv5Uo7bd8DfGqmeuqty90heDq/U+NawqvQSOIqE=;
 b=Azl7RTTLbKp5ZVYRq6CAMFeDf02OWgvLvCfA/rxZrJ9j4GwAtGEsyMBXSCF5mis2RjNWVGgolRiz37cNf7QeD9SqWZNyWcvGEWUKl5Kze6bTpcmKcmslE1dYARwF5ljLviFKnqIyR/ByaWg9OiRfZt8HhxmORdQ6jZa9NU9oW0o=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DM6PR10MB4172.namprd10.prod.outlook.com (2603:10b6:5:220::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.27; Wed, 26 Oct
 2022 13:22:43 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5403:3164:f6c3:d48a]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5403:3164:f6c3:d48a%3]) with mapi id 15.20.5746.021; Wed, 26 Oct 2022
 13:22:43 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>
CC:     Neil Brown <neilb@suse.de>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 2/2] nfsd: rework refcounting in filecache
Thread-Topic: [PATCH 2/2] nfsd: rework refcounting in filecache
Thread-Index: AQHY6RMoebLy9AJn9E6tMGJIzuoLaK4gqecA
Date:   Wed, 26 Oct 2022 13:22:43 +0000
Message-ID: <CEB59108-911B-439A-AC0A-8AC21C6A584F@oracle.com>
References: <20221026081539.219755-1-jlayton@kernel.org>
 <20221026081539.219755-2-jlayton@kernel.org>
In-Reply-To: <20221026081539.219755-2-jlayton@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|DM6PR10MB4172:EE_
x-ms-office365-filtering-correlation-id: bdf62d8d-3b0a-4c7e-6624-08dab7552a26
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HVNJLfhmP0IK4V2Mn5p42Sf+TGhPqLcSpa+2ld5yOhuNm1WuGxfPmeFfoU9AftT8SxE/v94Q6a1xPlqtrSxV3HVVkjF2qI6G35yUNIr/ga5rzAO/I2/TPU34fnN0VEHjz5/GLgH7fkxIGRJ8VTxUqXUC7IH0feYhMcb7/3VkffsypS+4bZFtzPCCnoAh4fnDYVM6lnb+QcwhwHCm3cQMxL/2AgSNoUfmfyzkJEMV+E33o4JCTXd+fi4ArkjaqGkU0GDRgnFFHKFqBo47+6qRb7UV7ubDjfNBeF19C0/hvlfir5gJFUAqzq5f5YLMJ3dU+Gh/YG/QUBDXm4aG2rpJp09Og1rEv7JpzJ8DMp2fwB1M+bmdYgcZtdlx9NlxVHL3jBvDgZm5N4GJcZh4KGqB30dnRt1GAM2ijYmqA5tgrHI4ZZgxtf6mat9ymgxW+sphj/TMLZb3YHgoIQaX1r3TR7sIClusCN3AYthJZdV0NIRGF8BZZ48JlA462TLW5b69A5He2HZcZrdae96ll4mbJrN842wHASoQ4iXmDD8eADSmpPSkmE0qHiDMozWygIIpmxrahaCBjJEJzQtR3g6rGuAAOJbTDrUVFx6EI0SBwDGDxPMjwh0AcgiN6B7R58xmg717Of2vxLrctk62dwYNeJZcCsmB0SXt/WZwEhrHqdxdNDRisJcXwKBQYq1ZLgASCageT76MFI0OGWNCbIV/DT2HcMe6LcsJqiaVX5HRBejeDkOkQnBG6VwC1pRZRZTHPOPk0G1XuI0EW2o0XXriRNU4NXBCwa8Cqxr1B8q7O0c=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(366004)(396003)(376002)(346002)(136003)(451199015)(66899015)(6486002)(30864003)(76116006)(66476007)(122000001)(5660300002)(86362001)(8936002)(66946007)(38070700005)(66556008)(38100700002)(83380400001)(33656002)(54906003)(36756003)(71200400001)(26005)(66446008)(6512007)(2616005)(316002)(8676002)(478600001)(91956017)(6916009)(41300700001)(64756008)(4326008)(2906002)(186003)(53546011)(6506007)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?2gpd1/64lz09Sgn8VN7GlTR1m6cXeFVHDyvhFqieW4A+0OD5tV4lQJyU5Rns?=
 =?us-ascii?Q?po1VII481kaXutsNbbkDOnd4otwQlDwuz/FqtvEwCWZ/hnHHqeXA8bC5Bheu?=
 =?us-ascii?Q?AMi+hmZp7c468DVtKZf76+na9NOLAriucCS8im184NryI9iL6NJUWW5Kb44X?=
 =?us-ascii?Q?FUqs7siXY43EIqtFneK2iNqztwgd62jmEUR5F1Z1TGiT7RKa7MFxIlBhpi6m?=
 =?us-ascii?Q?+tq73m1hiar8ELZPRbnVxQ3kO9ZI/zib1UXR41lYwq2i1fk2W58nPOhDMJZ0?=
 =?us-ascii?Q?s8D9ldM229Mx5EeBJRaBVxze4Y3MUAyPHRYjXUomVz0zgx9kgi3WzZqU8VFo?=
 =?us-ascii?Q?SeOL5+HG8u0r0UL6g8l4p47CCIdw1pw9yN1EcrHx/PEVEm8XUUGsbJbXAZiN?=
 =?us-ascii?Q?JaHexhxlyhZuvFC0fFnA0ojGcFEjlwQ65cgsM8BOImwHrkgLdhE7JZI8m3Z2?=
 =?us-ascii?Q?KGMk6fUiQB6b29DbxPrcLYS8yIzJxJFmpGwrs/REasNZeXUyLAaDGpeTZ0Xc?=
 =?us-ascii?Q?KG6LwL6lA0IfqemJfYelEn9gIKFNqv12itq+juHxsREUClYTAhIVU7b/GIKk?=
 =?us-ascii?Q?scrbpxgSu7MVYPKL/9YnkyjAR1VSq9l+pxnrBtD95jdv8MbP6om8ZSJwxX+i?=
 =?us-ascii?Q?K1FIlx6sZRMhIBMU51WA3nG+2yY3p/g8UrwXezIHFswv1pumKYbKBqTZbbBO?=
 =?us-ascii?Q?Cim4wuZnGq/fIeiX3lxfp4XVjh2/wOvK7Q887xMQ/JTKCk22UrAPuw+AHLfb?=
 =?us-ascii?Q?6IPsqJj3mH8KRslZG5yNsbeNumo0pKpCKJZoRc+D9rTEwWsCVrzrr8wR7nPm?=
 =?us-ascii?Q?FSrokaJvfoXv8MXK3K+Tm5yIxjNrRr/0K6QBCm23aV4OhP2L7uuHA6ZR8PRW?=
 =?us-ascii?Q?Jlqu8DcliwrwiQp7qu67DvqBKRTO7PpdW94ybgAV8hhKQog7kaeBfzxe+rtr?=
 =?us-ascii?Q?B5q9iCxZyzjeV7eL62sS0rRaxz0NQINb6vi7VlT74E01k4A7rji003yRjh0b?=
 =?us-ascii?Q?o9DeLeXBZaTf9CQ1j/ercezt1bZhCCio1rNoC64ROlE7wONves5Vwz0aTCsI?=
 =?us-ascii?Q?jg5hWO3ldBcu3sv5sI7lHwcczpGCLA6m9LrW5lHAl7uDO9JBc83iZS2z/DKW?=
 =?us-ascii?Q?ztdm1V5s8sUA1XuzzP2pC9glpmw1t+SnRO2juxJ5HRYb2yfdsoT2uVPYIJB4?=
 =?us-ascii?Q?5q1I0wkz7os3IHOWmQ5lcBbaFEcFVBzV6zgX/wdK6MHliVr17cORVH7byr0h?=
 =?us-ascii?Q?FZCCQIyuEYs54extXY/xpcJv72LAP+9H/g3jkbKOWbC344x8A1Hz3zdD5iGa?=
 =?us-ascii?Q?Ns7bdeO/ToUw+GCC4WF+3miKAoaRKuLmvCuCJYs4XPl2GezbfQV2lkMGFHxV?=
 =?us-ascii?Q?+UAAy2XxmP559EgQZwJWBdt9ajCAcRAjz2nZrLBILPP4dpyvV7Kt8TsQ9K6d?=
 =?us-ascii?Q?yibUj4jmdiq1RBOkYlzHxCKlfsu+20CQVbhE/M22mdYR/1rz8T9vAFceFeG3?=
 =?us-ascii?Q?zsruQEMSjuZXS77ZuCWZDI2sJCakZIEG2q46bT1uxw1Vv7IL3pPQtvrJB6bj?=
 =?us-ascii?Q?aByjAL/1k6gLrdLnscPClu/hWVmvJIIJNXTUSeCUQW/5VrXF9m8rqHFERKnL?=
 =?us-ascii?Q?Dg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <12989F8147572B47BFAEB4262B0780AE@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bdf62d8d-3b0a-4c7e-6624-08dab7552a26
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2022 13:22:43.3140
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QQqlSCMfBmV+t+MOFkiHg7qGYo4TGTPVCk+tv9QF1NaaQ525U+TFQPnhbPwgacTKkmGe3IZ0O/zXKSvtBRT6YQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4172
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-26_06,2022-10-26_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 phishscore=0
 mlxlogscore=999 adultscore=0 malwarescore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2210260075
X-Proofpoint-ORIG-GUID: EjsixkvR4C_QH_YCsqXOIV61xosPT-ah
X-Proofpoint-GUID: EjsixkvR4C_QH_YCsqXOIV61xosPT-ah
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Oct 26, 2022, at 4:15 AM, Jeff Layton <jlayton@kernel.org> wrote:
>=20
> The filecache refcounting is a bit non-standard for something searchable
> by RCU, in that we maintain a sentinel reference while it's hashed.
> This in turn requires that we have to do things differently in the "put"
> depending on whether its hashed, etc.
>=20
> Another issue: nfsd_file_close_inode_sync can end up freeing an
> nfsd_file while there are still outstanding references to it.
>=20
> Rework the code so that the refcount is what drives the lifecycle. When
> the refcount goes to zero, then unhash and rcu free the object.
>=20
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
> fs/nfsd/filecache.c | 202 ++++++++++++++++++++------------------------
> 1 file changed, 92 insertions(+), 110 deletions(-)
>=20
> This passes some basic smoke testing and I think closes a number of
> races in this code. I also think the result is a bit simpler and easier
> to follow now.
>=20
> I looked for some ways to break this up into multiple patches, but I
> didn't find any. This changes the underlying rules of how the
> refcounting works, and I didn't see a way to split that up and still
> have it remain bisectable.
>=20
> diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> index 918d67cec1ad..6c2f4f2c56a6 100644
> --- a/fs/nfsd/filecache.c
> +++ b/fs/nfsd/filecache.c
> @@ -1,7 +1,6 @@
> +// SPDX-License-Identifier: GPL-2.0
> /*
> - * Open file cache.
> - *
> - * (c) 2015 - Jeff Layton <jeff.layton@primarydata.com>
> + * The NFSD open file cache.
>  */
>=20
> #include <linux/hash.h>

Let's put the license change in a separate commit. The description
might want to point out that you are the same Jeff Layton as the
one who was at PD, but that's up to you.

Otherwise, I agree: one patch for the rest is probably best.

Browsing this, it looks like a good direction.


> @@ -303,8 +302,7 @@ nfsd_file_alloc(struct nfsd_file_lookup_key *key, uns=
igned int may)
> 		if (key->gc)
> 			__set_bit(NFSD_FILE_GC, &nf->nf_flags);
> 		nf->nf_inode =3D key->inode;
> -		/* nf_ref is pre-incremented for hash table */
> -		refcount_set(&nf->nf_ref, 2);
> +		refcount_set(&nf->nf_ref, 1);
> 		nf->nf_may =3D key->need;
> 		nf->nf_mark =3D NULL;
> 	}
> @@ -376,11 +374,15 @@ nfsd_file_flush(struct nfsd_file *nf)
> 		nfsd_reset_write_verifier(net_generic(nf->nf_net, nfsd_net_id));
> }
>=20
> -static void nfsd_file_lru_add(struct nfsd_file *nf)
> +static bool nfsd_file_lru_add(struct nfsd_file *nf)
> {
> 	set_bit(NFSD_FILE_REFERENCED, &nf->nf_flags);
> -	if (list_lru_add(&nfsd_file_lru, &nf->nf_lru))
> +	if (!test_bit(NFSD_FILE_HASHED, &nf->nf_flags) &&
> +	    list_lru_add(&nfsd_file_lru, &nf->nf_lru)) {
> 		trace_nfsd_file_lru_add(nf);
> +		return true;
> +	}
> +	return false;
> }
>=20
> static void nfsd_file_lru_remove(struct nfsd_file *nf)
> @@ -410,7 +412,7 @@ nfsd_file_unhash(struct nfsd_file *nf)
> 	return false;
> }
>=20
> -static void
> +static bool
> nfsd_file_unhash_and_dispose(struct nfsd_file *nf, struct list_head *disp=
ose)
> {
> 	trace_nfsd_file_unhash_and_dispose(nf);
> @@ -418,46 +420,48 @@ nfsd_file_unhash_and_dispose(struct nfsd_file *nf, =
struct list_head *dispose)
> 		/* caller must call nfsd_file_dispose_list() later */
> 		nfsd_file_lru_remove(nf);
> 		list_add(&nf->nf_lru, dispose);
> +		return true;
> 	}
> +	return false;
> }
>=20
> -static void
> -nfsd_file_put_noref(struct nfsd_file *nf)
> +static bool
> +__nfsd_file_put(struct nfsd_file *nf)
> {
> -	trace_nfsd_file_put(nf);
> -
> +	/* v4 case: don't wait for GC */
> 	if (refcount_dec_and_test(&nf->nf_ref)) {
> -		WARN_ON(test_bit(NFSD_FILE_HASHED, &nf->nf_flags));
> +		nfsd_file_unhash(nf);
> 		nfsd_file_lru_remove(nf);
> 		nfsd_file_free(nf);
> +		return true;
> 	}
> +	return false;
> }
>=20
> -static void
> -nfsd_file_unhash_and_put(struct nfsd_file *nf)
> -{
> -	if (nfsd_file_unhash(nf))
> -		nfsd_file_put_noref(nf);
> -}
> -
> +/**
> + * nfsd_file_put - put the reference to a nfsd_file
> + * @nf: nfsd_file of which to put the reference
> + *
> + * Put a reference to a nfsd_file. In the v4 case, we just put the
> + * reference immediately. In the v2/3 case, if the reference would be
> + * the last one, the put it on the LRU instead to be cleaned up later.
> + */
> void
> nfsd_file_put(struct nfsd_file *nf)
> {
> -	might_sleep();
> -
> -	if (test_bit(NFSD_FILE_GC, &nf->nf_flags) =3D=3D 1)
> -		nfsd_file_lru_add(nf);
> -	else if (refcount_read(&nf->nf_ref) =3D=3D 2)
> -		nfsd_file_unhash_and_put(nf);
> +	trace_nfsd_file_put(nf);
>=20
> -	if (test_bit(NFSD_FILE_HASHED, &nf->nf_flags) =3D=3D 0) {
> -		nfsd_file_flush(nf);
> -		nfsd_file_put_noref(nf);
> -	} else if (nf->nf_file && test_bit(NFSD_FILE_GC, &nf->nf_flags) =3D=3D =
1) {
> -		nfsd_file_put_noref(nf);
> -		nfsd_file_schedule_laundrette();
> -	} else
> -		nfsd_file_put_noref(nf);
> +	/* NFSv2/3 case */
> +	if (test_bit(NFSD_FILE_GC, &nf->nf_flags)) {
> +		/*
> +		 * If this is the last reference (nf_ref =3D=3D 1), then transfer
> +		 * it to the LRU. If the add to the LRU fails, just put it as
> +		 * usual.
> +		 */
> +		if (refcount_dec_not_one(&nf->nf_ref) || nfsd_file_lru_add(nf))
> +			return;
> +	}
> +	__nfsd_file_put(nf);
> }
>=20
> struct nfsd_file *
> @@ -477,27 +481,8 @@ nfsd_file_dispose_list(struct list_head *dispose)
> 		nf =3D list_first_entry(dispose, struct nfsd_file, nf_lru);
> 		list_del_init(&nf->nf_lru);
> 		nfsd_file_flush(nf);
> -		nfsd_file_put_noref(nf);
> -	}
> -}
> -
> -static void
> -nfsd_file_dispose_list_sync(struct list_head *dispose)
> -{
> -	bool flush =3D false;
> -	struct nfsd_file *nf;
> -
> -	while(!list_empty(dispose)) {
> -		nf =3D list_first_entry(dispose, struct nfsd_file, nf_lru);
> -		list_del_init(&nf->nf_lru);
> -		nfsd_file_flush(nf);
> -		if (!refcount_dec_and_test(&nf->nf_ref))
> -			continue;
> -		if (nfsd_file_free(nf))
> -			flush =3D true;
> +		nfsd_file_free(nf);
> 	}
> -	if (flush)
> -		flush_delayed_fput();
> }
>=20
> static void
> @@ -567,21 +552,8 @@ nfsd_file_lru_cb(struct list_head *item, struct list=
_lru_one *lru,
> 	struct list_head *head =3D arg;
> 	struct nfsd_file *nf =3D list_entry(item, struct nfsd_file, nf_lru);
>=20
> -	/*
> -	 * Do a lockless refcount check. The hashtable holds one reference, so
> -	 * we look to see if anything else has a reference, or if any have
> -	 * been put since the shrinker last ran. Those don't get unhashed and
> -	 * released.
> -	 *
> -	 * Note that in the put path, we set the flag and then decrement the
> -	 * counter. Here we check the counter and then test and clear the flag.
> -	 * That order is deliberate to ensure that we can do this locklessly.
> -	 */
> -	if (refcount_read(&nf->nf_ref) > 1) {
> -		list_lru_isolate(lru, &nf->nf_lru);
> -		trace_nfsd_file_gc_in_use(nf);
> -		return LRU_REMOVED;
> -	}
> +	/* We should only be dealing with v2/3 entries here */
> +	WARN_ON_ONCE(!test_bit(NFSD_FILE_GC, &nf->nf_flags));
>=20
> 	/*
> 	 * Don't throw out files that are still undergoing I/O or
> @@ -592,40 +564,30 @@ nfsd_file_lru_cb(struct list_head *item, struct lis=
t_lru_one *lru,
> 		return LRU_SKIP;
> 	}
>=20
> +	/* If it was recently referenced, then skip it */
> 	if (test_and_clear_bit(NFSD_FILE_REFERENCED, &nf->nf_flags)) {
> 		trace_nfsd_file_gc_referenced(nf);
> 		return LRU_ROTATE;
> 	}
>=20
> -	if (!test_and_clear_bit(NFSD_FILE_HASHED, &nf->nf_flags)) {
> -		trace_nfsd_file_gc_hashed(nf);
> -		return LRU_SKIP;
> +	/*
> +	 * Put the LRU reference. If it wasn't the last one, then something
> +	 * took a reference to it recently (or REFERENCED would have
> +	 * been set). Just remove it from the LRU and ignore it.
> +	 */
> +	if (!refcount_dec_and_test(&nf->nf_ref)) {
> +		trace_nfsd_file_gc_in_use(nf);
> +		list_lru_isolate(lru, &nf->nf_lru);
> +		return LRU_REMOVED;
> 	}
>=20
> +	/* Refcount went to zero. Queue it to the dispose list */
> 	list_lru_isolate_move(lru, &nf->nf_lru, head);
> 	this_cpu_inc(nfsd_file_evictions);
> 	trace_nfsd_file_gc_disposed(nf);
> 	return LRU_REMOVED;
> }
>=20
> -/*
> - * Unhash items on @dispose immediately, then queue them on the
> - * disposal workqueue to finish releasing them in the background.
> - *
> - * cel: Note that between the time list_lru_shrink_walk runs and
> - * now, these items are in the hash table but marked unhashed.
> - * Why release these outside of lru_cb ? There's no lock ordering
> - * problem since lru_cb currently takes no lock.
> - */
> -static void nfsd_file_gc_dispose_list(struct list_head *dispose)
> -{
> -	struct nfsd_file *nf;
> -
> -	list_for_each_entry(nf, dispose, nf_lru)
> -		nfsd_file_hash_remove(nf);
> -	nfsd_file_dispose_list_delayed(dispose);
> -}
> -
> static void
> nfsd_file_gc(void)
> {
> @@ -635,7 +597,7 @@ nfsd_file_gc(void)
> 	ret =3D list_lru_walk(&nfsd_file_lru, nfsd_file_lru_cb,
> 			    &dispose, list_lru_count(&nfsd_file_lru));
> 	trace_nfsd_file_gc_removed(ret, list_lru_count(&nfsd_file_lru));
> -	nfsd_file_gc_dispose_list(&dispose);
> +	nfsd_file_dispose_list_delayed(&dispose);
> }
>=20
> static void
> @@ -660,7 +622,7 @@ nfsd_file_lru_scan(struct shrinker *s, struct shrink_=
control *sc)
> 	ret =3D list_lru_shrink_walk(&nfsd_file_lru, sc,
> 				   nfsd_file_lru_cb, &dispose);
> 	trace_nfsd_file_shrinker_removed(ret, list_lru_count(&nfsd_file_lru));
> -	nfsd_file_gc_dispose_list(&dispose);
> +	nfsd_file_dispose_list_delayed(&dispose);
> 	return ret;
> }
>=20
> @@ -671,8 +633,11 @@ static struct shrinker	nfsd_file_shrinker =3D {
> };
>=20
> /*
> - * Find all cache items across all net namespaces that match @inode and
> - * move them to @dispose. The lookup is atomic wrt nfsd_file_acquire().
> + * Find all cache items across all net namespaces that match @inode, unh=
ash
> + * them, take references and then put them on @dispose if that was succe=
ssful.
> + *
> + * The nfsd_file objects on the list will be unhashed but holding a refe=
rence
> + * to them. The caller must ensure that the references clean things up.
>  */
> static unsigned int
> __nfsd_file_close_inode(struct inode *inode, struct list_head *dispose)
> @@ -690,45 +655,62 @@ __nfsd_file_close_inode(struct inode *inode, struct=
 list_head *dispose)
> 				       nfsd_file_rhash_params);
> 		if (!nf)
> 			break;
> -		nfsd_file_unhash_and_dispose(nf, dispose);
> -		count++;
> +
> +		/* Ignore it if it's already unhashed */
> +		if (!nfsd_file_unhash_and_dispose(nf, dispose))
> +			continue;
> +
> +		/* Ignore it if we can't get a reference */
> +		if (nfsd_file_get(nf))
> +			count++;
> +		else
> +			list_del_init(&nf->nf_lru);
> 	} while (1);
> 	rcu_read_unlock();
> 	return count;
> }
>=20
> /**
> - * nfsd_file_close_inode_sync - attempt to forcibly close a nfsd_file
> + * nfsd_file_close_inode - attempt a delayed close of a nfsd_file
>  * @inode: inode of the file to attempt to remove
>  *
> - * Unhash and put, then flush and fput all cache items associated with @=
inode.
> + * Unhash and put all cache item associated with @inode.
>  */
> -void
> -nfsd_file_close_inode_sync(struct inode *inode)
> +static void
> +nfsd_file_close_inode(struct inode *inode)
> {
> 	LIST_HEAD(dispose);
> 	unsigned int count;
>=20
> 	count =3D __nfsd_file_close_inode(inode, &dispose);
> -	trace_nfsd_file_close_inode_sync(inode, count);
> -	nfsd_file_dispose_list_sync(&dispose);
> +	trace_nfsd_file_close_inode(inode, count);
> +	nfsd_file_dispose_list_delayed(&dispose);
> }
>=20
> /**
> - * nfsd_file_close_inode - attempt a delayed close of a nfsd_file
> + * nfsd_file_close_inode_sync - attempt to forcibly close a nfsd_file
>  * @inode: inode of the file to attempt to remove
>  *
> - * Unhash and put all cache item associated with @inode.
> + * Unhash and put, then flush and fput all cache items associated with @=
inode.
>  */
> -static void
> -nfsd_file_close_inode(struct inode *inode)
> +void
> +nfsd_file_close_inode_sync(struct inode *inode)
> {
> +	struct nfsd_file *nf;
> 	LIST_HEAD(dispose);
> 	unsigned int count;
>=20
> 	count =3D __nfsd_file_close_inode(inode, &dispose);
> -	trace_nfsd_file_close_inode(inode, count);
> -	nfsd_file_dispose_list_delayed(&dispose);
> +	trace_nfsd_file_close_inode_sync(inode, count);
> +	if (!count)
> +		return;
> +	while(!list_empty(&dispose)) {
> +		nf =3D list_first_entry(&dispose, struct nfsd_file, nf_lru);
> +		list_del_init(&nf->nf_lru);
> +		if (refcount_dec_and_test(&nf->nf_ref))
> +			nfsd_file_free(nf);
> +	}
> +	flush_delayed_fput();
> }
>=20
> /**
> @@ -1094,7 +1076,7 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, struct=
 svc_fh *fhp,
> 			goto out;
> 		}
> 		open_retry =3D false;
> -		nfsd_file_put_noref(nf);
> +		nfsd_file_put(nf);
> 		goto retry;
> 	}
>=20
> @@ -1135,7 +1117,7 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, struct=
 svc_fh *fhp,
> 	 * then unhash.
> 	 */
> 	if (status !=3D nfs_ok || key.inode->i_nlink =3D=3D 0)
> -		nfsd_file_unhash_and_put(nf);
> +		nfsd_file_put(nf);
> 	clear_bit_unlock(NFSD_FILE_PENDING, &nf->nf_flags);
> 	smp_mb__after_atomic();
> 	wake_up_bit(&nf->nf_flags, NFSD_FILE_PENDING);
> --=20
> 2.37.3
>=20

--
Chuck Lever



