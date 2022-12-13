Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D31C864B6C5
	for <lists+linux-nfs@lfdr.de>; Tue, 13 Dec 2022 15:06:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235794AbiLMOGP (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 13 Dec 2022 09:06:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234987AbiLMOF4 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 13 Dec 2022 09:05:56 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D90AF587
        for <linux-nfs@vger.kernel.org>; Tue, 13 Dec 2022 06:05:48 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BDDtPbu013153;
        Tue, 13 Dec 2022 14:05:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=9NFHMPO66KqEip4miaDKruRBYPwVZYvfYRrrzn9fAVo=;
 b=W7Qbrh0+gQmEZqfpIN4Iv4YMyz1KizkB2Go0kxqCjCnbWrdhuE1P5tiTUuM0xaT0wu07
 rT5sD2CAsm1NEm3MZ7zQa2uxxVLlwhXFAmucMnOKJbqbNcrRQLrxGsnaTjQkeHQFDhTd
 9ZycXeqU26QhiuktxjUT9Y7DXUAd5bhDT3AZwXxDtHGEZtg7/ZQSIhS9iHSt8OTfAhxH
 aUk7thGGdKsMCVlwNNkfcagMgLU1SoxRarU0LfMRg8bQLv+ZFi1AWKzjUeBqg7uKEvV+
 AMXzh/YnLejokuQ0GCKFkR4EUfrcCwa4APKCwmjIRVMTjqBVtxhS6cFbA9kjEu0DLh01 LQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3mchqswcy2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Dec 2022 14:05:41 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2BDDY8p5034741;
        Tue, 13 Dec 2022 14:05:40 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3mcgj5r36g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Dec 2022 14:05:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cHt1w0vmcBz5/bBrXnrTv43UvLCzXhY86hpjw81Hf5Ef7feY4NkYgV1Nu4HRALiIpuqwBzCplrhO3LMdQgKCqp2ph5DFtMM8rbrQZr+wUNK3tGviomtfdJJU+WujW2SKfrrN0KtxV8JoBiq/BEXarrXa1Rye6AnVuHBuaLFXz7uiFkYEvNm6pCigXjcHCdjzrE049WIHvVXD65X68r+RMSf2OfwDGoMpFlRiSCPiAtMNHy6GT0UrUvzZzqDa5JrsCMHlRVFUbGc09+0efKefmZ0fF5Dcc7LWZL3dOeRXDyZXQWKyJMyG9H0LbwnM+Tvetli2RdVcjd9R+YAOUHkPqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9NFHMPO66KqEip4miaDKruRBYPwVZYvfYRrrzn9fAVo=;
 b=kDn59t4uWRJYVWLiU3DYkwMFgS08+VyY40JzJw/yn48JkfFF+K7NWhIh2DpE7oGDxue9+4DQcT7e8U8zN2cKX/RbhjA3a8bKCqV6/6L+F6KMUh6Yp/DYnPS+4ccbsEE8rGItQUHrAAo5htKG0afmk4k/A8iCDxUwBqC4WKSAGlzAfYWhklMv/iHcWCYrDiQkObubuH8v4D/3BR+8f1ZjTbpiYXyf3mQhlw1tIQxF2ov7ye5rnEbpXD51f3urbI6oT4pM2ICX164y4PleLgqwMUW4yCMfvyORXiHu4eMok0X9GJH4eDk0Cuh1QQ+gUj2M6Ui0qXdf3HSVnM94xcU4Gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9NFHMPO66KqEip4miaDKruRBYPwVZYvfYRrrzn9fAVo=;
 b=SMo2EI8O0nIEH7iHKtmVNXnunFi1S6gsdDOwKkO/3K1WNffmi19ncv7dqOmAcmq56BDjs31xNgrl4aqHiuqzufq+pS9VNZ2GBTqh52IPlR+ctlrN8KQCgSsbr8OvOkhLgrw1bTbuU06VjXStscX9Zrtcp8WBulH1Ppk02xS/FG8=
Received: from CH0PR10MB5131.namprd10.prod.outlook.com (2603:10b6:610:c6::24)
 by DS7PR10MB4942.namprd10.prod.outlook.com (2603:10b6:5:3ab::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Tue, 13 Dec
 2022 14:05:36 +0000
Received: from CH0PR10MB5131.namprd10.prod.outlook.com
 ([fe80::773f:eb65:8d20:f9c8]) by CH0PR10MB5131.namprd10.prod.outlook.com
 ([fe80::773f:eb65:8d20:f9c8%6]) with mapi id 15.20.5880.019; Tue, 13 Dec 2022
 14:05:36 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Neil Brown <neilb@suse.de>
Subject: Re: [PATCH v7] nfsd: rework refcounting in filecache
Thread-Topic: [PATCH v7] nfsd: rework refcounting in filecache
Thread-Index: AQHZDVJ2F52KN9cMgkmO1ZYFh7BHo65r3UoA
Date:   Tue, 13 Dec 2022 14:05:35 +0000
Message-ID: <18DD4225-E901-4C36-8DC1-6EDA0575A4FC@oracle.com>
References: <20221211111933.12785-1-jlayton@kernel.org>
In-Reply-To: <20221211111933.12785-1-jlayton@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR10MB5131:EE_|DS7PR10MB4942:EE_
x-ms-office365-filtering-correlation-id: c1e32bef-4364-476e-58be-08dadd131b51
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CDiOMQ4N7fUkk3Xwomj8xTbPy5eGfcM1DeEVNh2lBAmX6QYxLhQ7nW/kAXDArrq7Buy50/rIIhGeVZdstwj1eVfhXGectEIWLaYMqnDpT+h86yL33CbeytynIfcuZMrzsSMSEToZT0WjsDoiiO7LKwqodxPv7SxN/vEwhx/BTYUbp5fBQ+4dGO4KzCD7tGa2NTgddsZBOBHE/BgWkeDck2J2t4wpkE0C476vVGg+pRCX0JHt/vJXnUe6aEsHtgPk/KlTkm2B6lOE4jNVXKUSU9UzJ0uiLyW4opchrcUg2oOGe/x+sPJf0ADkB1yMV9puc4q4ktLfFsmyp9x+KAOWYB0KX1wKdZDeHKyawpaIzURSAIeKHs4+r7mHR1Low/ZIVmFYBH5R8uotiTOyCITMvPYxfA288kY2yNLDJ0ibXwg8j9Aq4Y1genDnxidsFt+bYeBGziXhERSsSFBQETHxJ0BGL1UktbbWqj1jqhM5qX5VRMIgFGDz2hczVBHElwQj5q3avLJ3j3KIK3bHscT5BB10W00QaXJJOYdGl0Om8aZp5Ag+Gf6lCrHI+mPm2725Ew6Yk3BiTnsfWNFn0oKkoFtpHitXJzlyxRLLl9ppNDAqDpAMfH9zA5Iw4vmUkNuyf57qSy7XVcQDrwhX6rdmvvJ3d2neaWDG4YEwO5A4/jFfuMKp16fPeqwR72BeRH+bhUG+hmy9hRkhj6NAAkd76SYm5PBqggNRRlYytnO0Og8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5131.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(39860400002)(366004)(376002)(136003)(346002)(451199015)(38100700002)(122000001)(41300700001)(86362001)(6486002)(8936002)(478600001)(71200400001)(4326008)(8676002)(186003)(66946007)(66556008)(6916009)(64756008)(76116006)(2906002)(83380400001)(54906003)(26005)(66476007)(316002)(6512007)(6506007)(2616005)(30864003)(53546011)(5660300002)(66899015)(66446008)(38070700005)(36756003)(33656002)(45980500001)(559001)(579004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?4IhwKsor0Xtv09AFacGlLj267RLWYZI2tFaeJcieYTbjUqS2maaB5zhjprCv?=
 =?us-ascii?Q?sSLbStqXLMj1RVdIxPMgxhq5ZWwyZNPHc/V1tXPvhqS308Fq/twPtdfXUyA7?=
 =?us-ascii?Q?gydKAd8T3RJQpbP14czM4/GLelnS3e0LUy9XiB+TEIT8zxnULztpl5C235EL?=
 =?us-ascii?Q?6VF7kU3RHYvmjJxPiUhAS7NnL/NF0G4snb3/uIGx2tngB2zrO0U2+rR+TqCY?=
 =?us-ascii?Q?dj+hg1IJrFoyCNJba1vjWqaEDMn6Gbw8ojTbDy6bPCL7v43Cau/ARVFcuSKF?=
 =?us-ascii?Q?MQS5y/aT1n0Wk/iNzMNkgL4Dwf7k4mDrwukFAsBE+aJiw3fst7wx3Ybbf26L?=
 =?us-ascii?Q?Bw/G8EkSpHak/vxzn99paGP/PlNeYuzgXlPbtDqjsnGQVzDKZiO16JW+yFvn?=
 =?us-ascii?Q?l2yumznhjnTM0MMAeqqnhv8Kkv+fzKc74S3p+SOcWEvfCt9eXcteu3uTglA+?=
 =?us-ascii?Q?Um1FNR2ti19QI6+taZrOCe+f6l+xFY1YrZsbJOMJOVtQ7NhgvWaPZfAwITvO?=
 =?us-ascii?Q?2QF7Dq9ezA5yRHx9+iqicLbXXqgMAowSF0WQZ44NRiY5EMxBRCuGbBCgLqLv?=
 =?us-ascii?Q?vavHYYhggLJQqyd6UlgxelCVbFhbV7PB1eK5MWY8czlvMavuu42TFqMP5Jkn?=
 =?us-ascii?Q?pbqlsuv7dYERWj8fbqGEBiO0YGgeX0bzZ+i/c1zrcbMmNG8qUvwl8qK4OUWr?=
 =?us-ascii?Q?QmuSTvOKp1ZItlT0Txui1lpPYzWy8GwG/763IlWU3y0Ux9miXevvmoW6XrKg?=
 =?us-ascii?Q?xzNVb0PDzYKFvhkOmSR4L/o+KI+s34zzSi0Xl0nISO42rNhySaiteKp1+RCV?=
 =?us-ascii?Q?wfnlR9d9sm38AJ0S5/zJC/P2B7SdSAfHB7kKt7LELJXKhMdzA4hdUu4bKzGb?=
 =?us-ascii?Q?GOI6xyyfB+yOUJ/m39Pd/jLXyifPjU1TbnhkhuaHaZ3bxqV+iL0kx+/9xM7A?=
 =?us-ascii?Q?BePqplkbkCoqdxrdnlUUuDrTvEYHbBCLz0RMLEF3gH99RCA8wBliX0Dxw1rA?=
 =?us-ascii?Q?11m98Mx/4cnT1TFqqogsfWftTMZl7kUQj0wH+/1sMjjs9JWcjKHjrof+S6PG?=
 =?us-ascii?Q?T2aNFF0ZbClV7cwbeGZ3UuFmv8nBDmtEkddekbw1E5WL4raIFxTuvZ1VTz2p?=
 =?us-ascii?Q?8XE9AzIrB1i3TUF0+HWgFrUqk/w8K8/W28nPG7ueDNzdUPnsVHfkHeLRBqi+?=
 =?us-ascii?Q?0GvjpZSLeoe1iM4zXYlwK0AOr8rUYXJ2b8h1a9LHUdt97aJ1/DT4niV8EcDj?=
 =?us-ascii?Q?ihQqxwJWmA29MR4uPpxMydly94x0x7lKPiJQ+X85z6snnlfxH0UE+4SCc6xS?=
 =?us-ascii?Q?pOgrojZLamHvc7Z+ZBpEwQ+RA3d5Mpzg5naZd29EKCOg11kfBFLUVgnXeMkG?=
 =?us-ascii?Q?PHXUJ8eJAF0vP5Od2ZYV2KDWYdGVdcDL3I7tRGpYJbTgGNQzD3x4n7aJgcm4?=
 =?us-ascii?Q?hpLUZlwiB6EAfNR/hOcOQzRiv2CZpv/v0be4wyRJKETxjIka2cziYgRTO4AI?=
 =?us-ascii?Q?q34eFlUlfuncXiSFszvxIdpSaIg1HTNZ56MDqcVX4VucPqP+4V9G3VJ2tqRG?=
 =?us-ascii?Q?tZgtl/E0TLT8I60vRReOl1X0KQtBLFShzj3477nPEPmtgI0q/vguMI7/goKL?=
 =?us-ascii?Q?ig=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <BF93F05CCC998847882FA311F8F04166@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5131.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1e32bef-4364-476e-58be-08dadd131b51
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2022 14:05:35.8154
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oQSreOv7ozQwERoTzOnhaicv9YUNjVjKhazWKWShfPP3MFhSqVC41IHryInZA7adiNqGEDq9Q4iBi6voYOrUEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4942
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-13_03,2022-12-13_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 adultscore=0 malwarescore=0 spamscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2212130125
X-Proofpoint-ORIG-GUID: lq6CLRjBVu4qWTmF1iPthg2Mvg8X39ek
X-Proofpoint-GUID: lq6CLRjBVu4qWTmF1iPthg2Mvg8X39ek
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Dec 11, 2022, at 6:19 AM, Jeff Layton <jlayton@kernel.org> wrote:
>=20
> The filecache refcounting is a bit non-standard for something searchable
> by RCU, in that we maintain a sentinel reference while it's hashed. This
> in turn requires that we have to do things differently in the "put"
> depending on whether its hashed, which we believe to have led to races.
>=20
> There are other problems in here too. nfsd_file_close_inode_sync can end
> up freeing an nfsd_file while there are still outstanding references to
> it, and there are a number of subtle ToC/ToU races.
>=20
> Rework the code so that the refcount is what drives the lifecycle. When
> the refcount goes to zero, then unhash and rcu free the object. A task
> searching for a nfsd_file is allowed to bump its refcount, but only if
> it's not already 0. Ensure that we don't make any other changes to it
> until a reference is held.
>=20
> With this change, the LRU carries a reference. Take special care to deal
> with it when removing an entry from the list, and ensure that we only
> repurpose the nf_lru list_head when the refcount is 0 to ensure
> exclusive access to it.
>=20
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
> fs/nfsd/filecache.c | 318 +++++++++++++++++++++++---------------------
> fs/nfsd/trace.h     |  51 +++----
> 2 files changed, 189 insertions(+), 180 deletions(-)
>=20
> I've sent some bugfixes recently for this, but some of them were
> dead-end changes that added unneeded churn. Chuck asked that I squash
> them down into the original patch so we can avoid the potential for
> regressions when bisecting.

Applied. Thanks, Jeff!


> diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> index 1998b4d5f692..45b2c9e3f636 100644
> --- a/fs/nfsd/filecache.c
> +++ b/fs/nfsd/filecache.c
> @@ -324,8 +324,7 @@ nfsd_file_alloc(struct nfsd_file_lookup_key *key, uns=
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
> @@ -377,24 +376,35 @@ nfsd_file_unhash(struct nfsd_file *nf)
> 	return false;
> }
>=20
> -static bool
> +static void
> nfsd_file_free(struct nfsd_file *nf)
> {
> 	s64 age =3D ktime_to_ms(ktime_sub(ktime_get(), nf->nf_birthtime));
> -	bool flush =3D false;
>=20
> 	trace_nfsd_file_free(nf);
>=20
> 	this_cpu_inc(nfsd_file_releases);
> 	this_cpu_add(nfsd_file_total_age, age);
>=20
> +	nfsd_file_unhash(nf);
> +
> +	/*
> +	 * We call fsync here in order to catch writeback errors. It's not
> +	 * strictly required by the protocol, but an nfsd_file could get
> +	 * evicted from the cache before a COMMIT comes in. If another
> +	 * task were to open that file in the interim and scrape the error,
> +	 * then the client may never see it. By calling fsync here, we ensure
> +	 * that writeback happens before the entry is freed, and that any
> +	 * errors reported result in the write verifier changing.
> +	 */
> +	nfsd_file_fsync(nf);
> +
> 	if (nf->nf_mark)
> 		nfsd_file_mark_put(nf->nf_mark);
> 	if (nf->nf_file) {
> 		get_file(nf->nf_file);
> 		filp_close(nf->nf_file, NULL);
> 		fput(nf->nf_file);
> -		flush =3D true;
> 	}
>=20
> 	/*
> @@ -402,10 +412,9 @@ nfsd_file_free(struct nfsd_file *nf)
> 	 * WARN and leak it to preserve system stability.
> 	 */
> 	if (WARN_ON_ONCE(!list_empty(&nf->nf_lru)))
> -		return flush;
> +		return;
>=20
> 	call_rcu(&nf->nf_rcu, nfsd_file_slab_free);
> -	return flush;
> }
>=20
> static bool
> @@ -421,17 +430,23 @@ nfsd_file_check_writeback(struct nfsd_file *nf)
> 		mapping_tagged(mapping, PAGECACHE_TAG_WRITEBACK);
> }
>=20
> -static void nfsd_file_lru_add(struct nfsd_file *nf)
> +static bool nfsd_file_lru_add(struct nfsd_file *nf)
> {
> 	set_bit(NFSD_FILE_REFERENCED, &nf->nf_flags);
> -	if (list_lru_add(&nfsd_file_lru, &nf->nf_lru))
> +	if (list_lru_add(&nfsd_file_lru, &nf->nf_lru)) {
> 		trace_nfsd_file_lru_add(nf);
> +		return true;
> +	}
> +	return false;
> }
>=20
> -static void nfsd_file_lru_remove(struct nfsd_file *nf)
> +static bool nfsd_file_lru_remove(struct nfsd_file *nf)
> {
> -	if (list_lru_del(&nfsd_file_lru, &nf->nf_lru))
> +	if (list_lru_del(&nfsd_file_lru, &nf->nf_lru)) {
> 		trace_nfsd_file_lru_del(nf);
> +		return true;
> +	}
> +	return false;
> }
>=20
> struct nfsd_file *
> @@ -442,86 +457,60 @@ nfsd_file_get(struct nfsd_file *nf)
> 	return NULL;
> }
>=20
> -static void
> -nfsd_file_unhash_and_queue(struct nfsd_file *nf, struct list_head *dispo=
se)
> -{
> -	trace_nfsd_file_unhash_and_queue(nf);
> -	if (nfsd_file_unhash(nf)) {
> -		/* caller must call nfsd_file_dispose_list() later */
> -		nfsd_file_lru_remove(nf);
> -		list_add(&nf->nf_lru, dispose);
> -	}
> -}
> -
> -static void
> -nfsd_file_put_noref(struct nfsd_file *nf)
> -{
> -	trace_nfsd_file_put(nf);
> -
> -	if (refcount_dec_and_test(&nf->nf_ref)) {
> -		WARN_ON(test_bit(NFSD_FILE_HASHED, &nf->nf_flags));
> -		nfsd_file_lru_remove(nf);
> -		nfsd_file_free(nf);
> -	}
> -}
> -
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
> + * Put a reference to a nfsd_file. In the non-GC case, we just put the
> + * reference immediately. In the GC case, if the reference would be
> + * the last one, the put it on the LRU instead to be cleaned up later.
> + */
> void
> nfsd_file_put(struct nfsd_file *nf)
> {
> 	might_sleep();
> +	trace_nfsd_file_put(nf);
>=20
> -	if (test_bit(NFSD_FILE_GC, &nf->nf_flags))
> -		nfsd_file_lru_add(nf);
> -	else if (refcount_read(&nf->nf_ref) =3D=3D 2)
> -		nfsd_file_unhash_and_put(nf);
> -
> -	if (!test_bit(NFSD_FILE_HASHED, &nf->nf_flags)) {
> -		nfsd_file_fsync(nf);
> -		nfsd_file_put_noref(nf);
> -	} else if (nf->nf_file && test_bit(NFSD_FILE_GC, &nf->nf_flags)) {
> -		nfsd_file_put_noref(nf);
> -		nfsd_file_schedule_laundrette();
> -	} else
> -		nfsd_file_put_noref(nf);
> -}
> -
> -static void
> -nfsd_file_dispose_list(struct list_head *dispose)
> -{
> -	struct nfsd_file *nf;
> +	if (test_bit(NFSD_FILE_GC, &nf->nf_flags) &&
> +	    test_bit(NFSD_FILE_HASHED, &nf->nf_flags)) {
> +		/*
> +		 * If this is the last reference (nf_ref =3D=3D 1), then try to
> +		 * transfer it to the LRU.
> +		 */
> +		if (refcount_dec_not_one(&nf->nf_ref))
> +			return;
> +
> +		/* Try to add it to the LRU.  If that fails, decrement. */
> +		if (nfsd_file_lru_add(nf)) {
> +			/* If it's still hashed, we're done */
> +			if (test_bit(NFSD_FILE_HASHED, &nf->nf_flags)) {
> +				nfsd_file_schedule_laundrette();
> +				return;
> +			}
>=20
> -	while(!list_empty(dispose)) {
> -		nf =3D list_first_entry(dispose, struct nfsd_file, nf_lru);
> -		list_del_init(&nf->nf_lru);
> -		nfsd_file_fsync(nf);
> -		nfsd_file_put_noref(nf);
> +			/*
> +			 * We're racing with unhashing, so try to remove it from
> +			 * the LRU. If removal fails, then someone else already
> +			 * has our reference.
> +			 */
> +			if (!nfsd_file_lru_remove(nf))
> +				return;
> +		}
> 	}
> +	if (refcount_dec_and_test(&nf->nf_ref))
> +		nfsd_file_free(nf);
> }
>=20
> static void
> -nfsd_file_dispose_list_sync(struct list_head *dispose)
> +nfsd_file_dispose_list(struct list_head *dispose)
> {
> -	bool flush =3D false;
> 	struct nfsd_file *nf;
>=20
> -	while(!list_empty(dispose)) {
> +	while (!list_empty(dispose)) {
> 		nf =3D list_first_entry(dispose, struct nfsd_file, nf_lru);
> 		list_del_init(&nf->nf_lru);
> -		nfsd_file_fsync(nf);
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
> @@ -591,21 +580,8 @@ nfsd_file_lru_cb(struct list_head *item, struct list=
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
> +	/* We should only be dealing with GC entries here */
> +	WARN_ON_ONCE(!test_bit(NFSD_FILE_GC, &nf->nf_flags));
>=20
> 	/*
> 	 * Don't throw out files that are still undergoing I/O or
> @@ -616,40 +592,30 @@ nfsd_file_lru_cb(struct list_head *item, struct lis=
t_lru_one *lru,
> 		return LRU_SKIP;
> 	}
>=20
> +	/* If it was recently added to the list, skip it */
> 	if (test_and_clear_bit(NFSD_FILE_REFERENCED, &nf->nf_flags)) {
> 		trace_nfsd_file_gc_referenced(nf);
> 		return LRU_ROTATE;
> 	}
>=20
> -	if (!test_and_clear_bit(NFSD_FILE_HASHED, &nf->nf_flags)) {
> -		trace_nfsd_file_gc_hashed(nf);
> -		return LRU_SKIP;
> +	/*
> +	 * Put the reference held on behalf of the LRU. If it wasn't the last
> +	 * one, then just remove it from the LRU and ignore it.
> +	 */
> +	if (!refcount_dec_and_test(&nf->nf_ref)) {
> +		trace_nfsd_file_gc_in_use(nf);
> +		list_lru_isolate(lru, &nf->nf_lru);
> +		return LRU_REMOVED;
> 	}
>=20
> +	/* Refcount went to zero. Unhash it and queue it to the dispose list */
> +	nfsd_file_unhash(nf);
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
> @@ -659,7 +625,7 @@ nfsd_file_gc(void)
> 	ret =3D list_lru_walk(&nfsd_file_lru, nfsd_file_lru_cb,
> 			    &dispose, list_lru_count(&nfsd_file_lru));
> 	trace_nfsd_file_gc_removed(ret, list_lru_count(&nfsd_file_lru));
> -	nfsd_file_gc_dispose_list(&dispose);
> +	nfsd_file_dispose_list_delayed(&dispose);
> }
>=20
> static void
> @@ -685,7 +651,7 @@ nfsd_file_lru_scan(struct shrinker *s, struct shrink_=
control *sc)
> 	ret =3D list_lru_shrink_walk(&nfsd_file_lru, sc,
> 				   nfsd_file_lru_cb, &dispose);
> 	trace_nfsd_file_shrinker_removed(ret, list_lru_count(&nfsd_file_lru));
> -	nfsd_file_gc_dispose_list(&dispose);
> +	nfsd_file_dispose_list_delayed(&dispose);
> 	return ret;
> }
>=20
> @@ -695,72 +661,111 @@ static struct shrinker	nfsd_file_shrinker =3D {
> 	.seeks =3D 1,
> };
>=20
> -/*
> - * Find all cache items across all net namespaces that match @inode and
> - * move them to @dispose. The lookup is atomic wrt nfsd_file_acquire().
> +/**
> + * nfsd_file_queue_for_close: try to close out any open nfsd_files for a=
n inode
> + * @inode:   inode on which to close out nfsd_files
> + * @dispose: list on which to gather nfsd_files to close out
> + *
> + * An nfsd_file represents a struct file being held open on behalf of nf=
sd. An
> + * open file however can block other activity (such as leases), or cause
> + * undesirable behavior (e.g. spurious silly-renames when reexporting NF=
S).
> + *
> + * This function is intended to find open nfsd_files when this sort of
> + * conflicting access occurs and then attempt to close those files out.
> + *
> + * Populates the dispose list with entries that have already had their
> + * refcounts go to zero. The actual free of an nfsd_file can be expensiv=
e,
> + * so we leave it up to the caller whether it wants to wait or not.
>  */
> -static unsigned int
> -__nfsd_file_close_inode(struct inode *inode, struct list_head *dispose)
> +static void
> +nfsd_file_queue_for_close(struct inode *inode, struct list_head *dispose=
)
> {
> 	struct nfsd_file_lookup_key key =3D {
> 		.type	=3D NFSD_FILE_KEY_INODE,
> 		.inode	=3D inode,
> 	};
> -	unsigned int count =3D 0;
> 	struct nfsd_file *nf;
>=20
> 	rcu_read_lock();
> 	do {
> +		int decrement =3D 1;
> +
> 		nf =3D rhashtable_lookup(&nfsd_file_rhash_tbl, &key,
> 				       nfsd_file_rhash_params);
> 		if (!nf)
> 			break;
> -		nfsd_file_unhash_and_queue(nf, dispose);
> -		count++;
> +
> +		/* If we raced with someone else unhashing, ignore it */
> +		if (!nfsd_file_unhash(nf))
> +			continue;
> +
> +		/* If we can't get a reference, ignore it */
> +		if (!nfsd_file_get(nf))
> +			continue;
> +
> +		/* Extra decrement if we remove from the LRU */
> +		if (nfsd_file_lru_remove(nf))
> +			++decrement;
> +
> +		/* If refcount goes to 0, then put on the dispose list */
> +		if (refcount_sub_and_test(decrement, &nf->nf_ref)) {
> +			list_add(&nf->nf_lru, dispose);
> +			trace_nfsd_file_closing(nf);
> +		}
> 	} while (1);
> 	rcu_read_unlock();
> -	return count;
> }
>=20
> /**
> - * nfsd_file_close_inode_sync - attempt to forcibly close a nfsd_file
> + * nfsd_file_close_inode - attempt a delayed close of a nfsd_file
>  * @inode: inode of the file to attempt to remove
>  *
> - * Unhash and put, then flush and fput all cache items associated with @=
inode.
> + * Close out any open nfsd_files that can be reaped for @inode. The
> + * actual freeing is deferred to the dispose_list_delayed infrastructure=
.
> + *
> + * This is used by the fsnotify callbacks and setlease notifier.
>  */
> -void
> -nfsd_file_close_inode_sync(struct inode *inode)
> +static void
> +nfsd_file_close_inode(struct inode *inode)
> {
> 	LIST_HEAD(dispose);
> -	unsigned int count;
>=20
> -	count =3D __nfsd_file_close_inode(inode, &dispose);
> -	trace_nfsd_file_close_inode_sync(inode, count);
> -	nfsd_file_dispose_list_sync(&dispose);
> +	nfsd_file_queue_for_close(inode, &dispose);
> +	nfsd_file_dispose_list_delayed(&dispose);
> }
>=20
> /**
> - * nfsd_file_close_inode - attempt a delayed close of a nfsd_file
> + * nfsd_file_close_inode_sync - attempt to forcibly close a nfsd_file
>  * @inode: inode of the file to attempt to remove
>  *
> - * Unhash and put all cache item associated with @inode.
> + * Close out any open nfsd_files that can be reaped for @inode. The
> + * nfsd_files are closed out synchronously.
> + *
> + * This is called from nfsd_rename and nfsd_unlink to avoid silly-rename=
s
> + * when reexporting NFS.
>  */
> -static void
> -nfsd_file_close_inode(struct inode *inode)
> +void
> +nfsd_file_close_inode_sync(struct inode *inode)
> {
> +	struct nfsd_file *nf;
> 	LIST_HEAD(dispose);
> -	unsigned int count;
>=20
> -	count =3D __nfsd_file_close_inode(inode, &dispose);
> -	trace_nfsd_file_close_inode(inode, count);
> -	nfsd_file_dispose_list_delayed(&dispose);
> +	trace_nfsd_file_close(inode);
> +
> +	nfsd_file_queue_for_close(inode, &dispose);
> +	while (!list_empty(&dispose)) {
> +		nf =3D list_first_entry(&dispose, struct nfsd_file, nf_lru);
> +		list_del_init(&nf->nf_lru);
> +		nfsd_file_free(nf);
> +	}
> +	flush_delayed_fput();
> }
>=20
> /**
>  * nfsd_file_delayed_close - close unused nfsd_files
>  * @work: dummy
>  *
> - * Walk the LRU list and close any entries that have not been used since
> + * Walk the LRU list and destroy any entries that have not been used sin=
ce
>  * the last scan.
>  */
> static void
> @@ -782,7 +787,7 @@ nfsd_file_lease_notifier_call(struct notifier_block *=
nb, unsigned long arg,
>=20
> 	/* Only close files for F_SETLEASE leases */
> 	if (fl->fl_flags & FL_LEASE)
> -		nfsd_file_close_inode_sync(file_inode(fl->fl_file));
> +		nfsd_file_close_inode(file_inode(fl->fl_file));
> 	return 0;
> }
>=20
> @@ -903,6 +908,13 @@ nfsd_file_cache_init(void)
> 	goto out;
> }
>=20
> +/**
> + * __nfsd_file_cache_purge: clean out the cache for shutdown
> + * @net: net-namespace to shut down the cache (may be NULL)
> + *
> + * Walk the nfsd_file cache and close out any that match @net. If @net i=
s NULL,
> + * then close out everything. Called when an nfsd instance is being shut=
 down.
> + */
> static void
> __nfsd_file_cache_purge(struct net *net)
> {
> @@ -916,8 +928,11 @@ __nfsd_file_cache_purge(struct net *net)
>=20
> 		nf =3D rhashtable_walk_next(&iter);
> 		while (!IS_ERR_OR_NULL(nf)) {
> -			if (!net || nf->nf_net =3D=3D net)
> -				nfsd_file_unhash_and_queue(nf, &dispose);
> +			if (!net || nf->nf_net =3D=3D net) {
> +				nfsd_file_unhash(nf);
> +				nfsd_file_lru_remove(nf);
> +				list_add(&nf->nf_lru, &dispose);
> +			}
> 			nf =3D rhashtable_walk_next(&iter);
> 		}
>=20
> @@ -1084,8 +1099,12 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, struc=
t svc_fh *fhp,
> 	if (nf)
> 		nf =3D nfsd_file_get(nf);
> 	rcu_read_unlock();
> -	if (nf)
> +
> +	if (nf) {
> +		if (nfsd_file_lru_remove(nf))
> +			WARN_ON_ONCE(refcount_dec_and_test(&nf->nf_ref));
> 		goto wait_for_construction;
> +	}
>=20
> 	nf =3D nfsd_file_alloc(&key, may_flags);
> 	if (!nf) {
> @@ -1118,11 +1137,11 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, stru=
ct svc_fh *fhp,
> 			goto out;
> 		}
> 		open_retry =3D false;
> -		nfsd_file_put_noref(nf);
> +		if (refcount_dec_and_test(&nf->nf_ref))
> +			nfsd_file_free(nf);
> 		goto retry;
> 	}
>=20
> -	nfsd_file_lru_remove(nf);
> 	this_cpu_inc(nfsd_file_cache_hits);
>=20
> 	status =3D nfserrno(nfsd_open_break_lease(file_inode(nf->nf_file), may_f=
lags));
> @@ -1132,7 +1151,8 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, struct=
 svc_fh *fhp,
> 			this_cpu_inc(nfsd_file_acquisitions);
> 		*pnf =3D nf;
> 	} else {
> -		nfsd_file_put(nf);
> +		if (refcount_dec_and_test(&nf->nf_ref))
> +			nfsd_file_free(nf);
> 		nf =3D NULL;
> 	}
>=20
> @@ -1158,8 +1178,10 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, struc=
t svc_fh *fhp,
> 	 * If construction failed, or we raced with a call to unlink()
> 	 * then unhash.
> 	 */
> -	if (status !=3D nfs_ok || key.inode->i_nlink =3D=3D 0)
> -		nfsd_file_unhash_and_put(nf);
> +	if (status =3D=3D nfs_ok && key.inode->i_nlink =3D=3D 0)
> +		status =3D nfserr_jukebox;
> +	if (status !=3D nfs_ok)
> +		nfsd_file_unhash(nf);
> 	clear_bit_unlock(NFSD_FILE_PENDING, &nf->nf_flags);
> 	smp_mb__after_atomic();
> 	wake_up_bit(&nf->nf_flags, NFSD_FILE_PENDING);
> diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
> index 46b8f68a2497..c852ae8eaf37 100644
> --- a/fs/nfsd/trace.h
> +++ b/fs/nfsd/trace.h
> @@ -876,8 +876,8 @@ DEFINE_CLID_EVENT(confirmed_r);
> 	__print_flags(val, "|",						\
> 		{ 1 << NFSD_FILE_HASHED,	"HASHED" },		\
> 		{ 1 << NFSD_FILE_PENDING,	"PENDING" },		\
> -		{ 1 << NFSD_FILE_REFERENCED,	"REFERENCED"},		\
> -		{ 1 << NFSD_FILE_GC,		"GC"})
> +		{ 1 << NFSD_FILE_REFERENCED,	"REFERENCED" },		\
> +		{ 1 << NFSD_FILE_GC,		"GC" })
>=20
> DECLARE_EVENT_CLASS(nfsd_file_class,
> 	TP_PROTO(struct nfsd_file *nf),
> @@ -912,6 +912,7 @@ DEFINE_EVENT(nfsd_file_class, name, \
> DEFINE_NFSD_FILE_EVENT(nfsd_file_free);
> DEFINE_NFSD_FILE_EVENT(nfsd_file_unhash);
> DEFINE_NFSD_FILE_EVENT(nfsd_file_put);
> +DEFINE_NFSD_FILE_EVENT(nfsd_file_closing);
> DEFINE_NFSD_FILE_EVENT(nfsd_file_unhash_and_queue);
>=20
> TRACE_EVENT(nfsd_file_alloc,
> @@ -1103,35 +1104,6 @@ TRACE_EVENT(nfsd_file_open,
> 		__entry->nf_file)
> )
>=20
> -DECLARE_EVENT_CLASS(nfsd_file_search_class,
> -	TP_PROTO(
> -		const struct inode *inode,
> -		unsigned int count
> -	),
> -	TP_ARGS(inode, count),
> -	TP_STRUCT__entry(
> -		__field(const struct inode *, inode)
> -		__field(unsigned int, count)
> -	),
> -	TP_fast_assign(
> -		__entry->inode =3D inode;
> -		__entry->count =3D count;
> -	),
> -	TP_printk("inode=3D%p count=3D%u",
> -		__entry->inode, __entry->count)
> -);
> -
> -#define DEFINE_NFSD_FILE_SEARCH_EVENT(name)				\
> -DEFINE_EVENT(nfsd_file_search_class, name,				\
> -	TP_PROTO(							\
> -		const struct inode *inode,				\
> -		unsigned int count					\
> -	),								\
> -	TP_ARGS(inode, count))
> -
> -DEFINE_NFSD_FILE_SEARCH_EVENT(nfsd_file_close_inode_sync);
> -DEFINE_NFSD_FILE_SEARCH_EVENT(nfsd_file_close_inode);
> -
> TRACE_EVENT(nfsd_file_is_cached,
> 	TP_PROTO(
> 		const struct inode *inode,
> @@ -1209,7 +1181,6 @@ DEFINE_NFSD_FILE_GC_EVENT(nfsd_file_lru_del_dispose=
d);
> DEFINE_NFSD_FILE_GC_EVENT(nfsd_file_gc_in_use);
> DEFINE_NFSD_FILE_GC_EVENT(nfsd_file_gc_writeback);
> DEFINE_NFSD_FILE_GC_EVENT(nfsd_file_gc_referenced);
> -DEFINE_NFSD_FILE_GC_EVENT(nfsd_file_gc_hashed);
> DEFINE_NFSD_FILE_GC_EVENT(nfsd_file_gc_disposed);
>=20
> DECLARE_EVENT_CLASS(nfsd_file_lruwalk_class,
> @@ -1241,6 +1212,22 @@ DEFINE_EVENT(nfsd_file_lruwalk_class, name,				\
> DEFINE_NFSD_FILE_LRUWALK_EVENT(nfsd_file_gc_removed);
> DEFINE_NFSD_FILE_LRUWALK_EVENT(nfsd_file_shrinker_removed);
>=20
> +TRACE_EVENT(nfsd_file_close,
> +	TP_PROTO(
> +		const struct inode *inode
> +	),
> +	TP_ARGS(inode),
> +	TP_STRUCT__entry(
> +		__field(const void *, inode)
> +	),
> +	TP_fast_assign(
> +		__entry->inode =3D inode;
> +	),
> +	TP_printk("inode=3D%p",
> +		__entry->inode
> +	)
> +);
> +
> TRACE_EVENT(nfsd_file_fsync,
> 	TP_PROTO(
> 		const struct nfsd_file *nf,
> --=20
> 2.38.1
>=20

--
Chuck Lever



