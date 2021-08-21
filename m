Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 763413F3B70
	for <lists+linux-nfs@lfdr.de>; Sat, 21 Aug 2021 18:30:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229644AbhHUQbU (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 21 Aug 2021 12:31:20 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:26762 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229571AbhHUQbT (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 21 Aug 2021 12:31:19 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 17L5TmTN008067;
        Sat, 21 Aug 2021 16:30:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=f8vA0aJju7Y0QRB4izHFoZ+rPT6YEz+rbd0g1pP+Wqw=;
 b=ppiEBAd7DMnHYCYqmfqox8HyvQMmJ+fqUrihT21n2pk43z1bk4mL3es/SuKTMttJSw5x
 sFA/l5VmLKxPTvD44CVgwwZ8gxL9xVQJ5F4cQJCDiSIZlcQIzY+BSqokneT5JlmJf6o8
 aKF7/drpczygGvlAwKFd901x4ScUFQNVRyK9Y2jImJjBM/B0KLR/9KiZWKBJQogq0ckr
 I2X9Tu0oUkeKLRTtfd728SWuLyCTFz1Gn4nDK1sRGiD47tmgIVE7NI7ADXfoIx1wrN7O
 SiNBNeZxvwRp/I7VJ5mf2LrPntPpz972G9GOgCg8F4e/U/cRDD/jL+gw7/TF0zOgDXpe yw== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=f8vA0aJju7Y0QRB4izHFoZ+rPT6YEz+rbd0g1pP+Wqw=;
 b=z/rUXI4+H+l0NvRW0/tUqsAxecpEbWTwp1vqAmHOtKv/HrPWRI4kkf3VDE7jtyTyALGm
 ROB0YOMZW6BHHiopddLYP8pg9FzqqHbLhy69Rp0m8/CuiZmGMAE46M3ahStTFh4vb+3C
 h9066e5bnptJZe7WNq9PuRtaq8jgWUUWAAHSshC/AzmY+qzA2fFtnduPh4W9fZUxWmRo
 i5qPrvqUIE2E+8U36hE5ETHbRnTa0fFg7qNTaEGxmWhx9tDblF6FG4lRhVrnWy7aWng+
 sIk9ulahRFLkFIKCuzxmEmOZuwGCW5D8yuQCySO9PKU+7hSOLAWpaqolr6bWvw4aLOl5 WQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ajtwfrhkp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 21 Aug 2021 16:30:36 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17LGFAKA058275;
        Sat, 21 Aug 2021 16:30:35 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2045.outbound.protection.outlook.com [104.47.66.45])
        by aserp3030.oracle.com with ESMTP id 3ajqh9wvhj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 21 Aug 2021 16:30:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M9LMqdfhhICLkCXOKfAa/3YdthFYDxOuxuTl/U9vLtOXwJLlCdQZBtaJKOKP7II6gDry0kUgNZkU2Rv4y+gINEILk4wpHZNy6TuGn4JoyqFzIAvHN7GhO4I0k3CEEz0IKPJQ1ab3ky87GVQVTtFRyB0ffvB+pu9JHNhdSBKawmR1sZ+VgxQeVQreLuhOeaBVi4NEv8z9CVBXjMvK+8p+wrAXDKROjxMDOpZ84kIH16dZLuDsoI3K7bnCQx+OTmbxiB8PoTvSEdl924Vpoa1ynZ5hKe3kYn/cd+h5p9/W0O79wE6Au3U7YjqqtFf4J3WWaHF4cA1t8p6hh3DoM8eDPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f8vA0aJju7Y0QRB4izHFoZ+rPT6YEz+rbd0g1pP+Wqw=;
 b=hR7YzZL8baZhpaVn4jXHyvrel0IRF5ytgW+0yjzODfcw5winDGK0s2WH2TTYRJAFo6p8W1PYWCsW+ZHgOlGbjpSslH/KmUAqA0PsaSYNUjMCTGVjC8VdrSn6eqdbpZdDB4ih+hXCQqQQh0z/KUCKY6YAAKCb6DFG8eEFTeAnqsqa7EWuOT6l4Hyqw7WCWvyCvzLI2WTigK8BD8nJu8BJ33plTPrVDXBLKGmgEJ74CVAR+7FwN7qI3BIi2uuBALkl7gP3Xv827+ZgOkP7T+GfO64Q3XeMBfm3/9znV9fIdchNW8gSrs0gzxlpU9crvnxBKac6P3DU+1+KsrtDJcLydQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f8vA0aJju7Y0QRB4izHFoZ+rPT6YEz+rbd0g1pP+Wqw=;
 b=HeodD+ekaNmrmbSSMG1RuxK8eYZnio+LlJXbYWYhpsSeJV+GCW26kScEaJW0D5F5qwUt61/9zLkO24h8P2POju5X5gNUP+zPwQyl8SvDJrui9ZOBHSHttr54/KcztcSVRAJ7bHE83F3tNmoOv2ghcyHwaos/LQtR/c4UDkyU+Lw=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by SJ0PR10MB4591.namprd10.prod.outlook.com (2603:10b6:a03:2af::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.21; Sat, 21 Aug
 2021 16:30:32 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::a8db:4fc8:ded5:e64]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::a8db:4fc8:ded5:e64%7]) with mapi id 15.20.4436.019; Sat, 21 Aug 2021
 16:30:32 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Bruce Fields <bfields@redhat.com>
CC:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <schumakeranna@gmail.com>,
        "daire@dneg.com" <daire@dneg.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 2/8] nlm: minor nlm_lookup_file argument change
Thread-Topic: [PATCH 2/8] nlm: minor nlm_lookup_file argument change
Thread-Index: AQHXlgarWedXlI5eD0ihs4522vEIVat+J6qA
Date:   Sat, 21 Aug 2021 16:30:32 +0000
Message-ID: <77E5AE14-04E1-4C54-BC3C-192FADAF7B96@oracle.com>
References: <1629493326-28336-1-git-send-email-bfields@redhat.com>
 <1629493326-28336-3-git-send-email-bfields@redhat.com>
In-Reply-To: <1629493326-28336-3-git-send-email-bfields@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4f6768fe-d3b5-4a58-32c1-08d964c0feef
x-ms-traffictypediagnostic: SJ0PR10MB4591:
x-microsoft-antispam-prvs: <SJ0PR10MB459108F8CBFF672F893D5BA293C29@SJ0PR10MB4591.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1cqaaZbcA6h6VFKsLlpLsFSkM11qyfMgpPcc6qRts7eerR1Gget2dHE10EtdauAQWV2DQTthECuX7hE5ycKK9y2FS+gBhyVFlqtOPGKK831CuIhOl8+dlbe21rBhMLep5cWnvAJrIeOMkDahco5AtGZCDTE1iawdtrYrbBADkyT2pmSw8y75aXLlKAshSHBVoxajIjPafs93/+ikp+gsFWzb2GngVJLMdb+IelfAIgzE1d3iH91JQinMESeJ3+ciextvv6d9zBaMhRmZho4tjCVE0cPnTw9HQqw7ARyPsB5LsJSSx4BFHdYbdbn/VQ02sOwMJyIw8+c7z2AQ8KXbKii3tgwYyHd5TIUinQSP42+Me49J7kCTrwSGwjp9wiZjySZI16VPafTBhF9DKQAlNnkh+2kFApBP2qXFQnEoZoJ4DtGqXkWs1jRMk9Sw9TLxxAq5gRys3A3KFl0Fw0gWv58PjE/tWJhWoy7saMf2U3Jo5ZHXvoZ6BH1BlOdKKsPNdSiqQ27FISVZ0OOS9oGiP261mxeFPOpVhgMY9M4R2DSIvNEIOOEE1gP6DUiAJ5MvK8ZEo7QZILdNvk512cs/0/m67PrNJzS/5YrbeXKnnAkFmmUoHbED6lROchiaytU2xuf6SqRnwpobjOjWHkiMb1kcnZIbtniSr1QHAvMuLGU2aduTXSLqZ3k/jZHJf6OfE12Sea778yT/tJvOqd93tanl5dXvE3ve6QFDHpNHzm5f4u74v2sSjLmwk56Dm8V4
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66556008)(66446008)(66946007)(66476007)(6512007)(122000001)(316002)(64756008)(54906003)(6486002)(38100700002)(8676002)(4326008)(2616005)(33656002)(8936002)(71200400001)(53546011)(86362001)(186003)(76116006)(5660300002)(6506007)(6916009)(83380400001)(38070700005)(508600001)(91956017)(26005)(2906002)(36756003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8nnUvYERlzwTkaZ7xqqMu8zP0Kx8tZGs8tMBwVkiSFI+R982j8QEtnnJqdoR?=
 =?us-ascii?Q?NwEQRiqg/Uq77G1v7BkWHJuTVAG+57T9cAMYo95Wyzst5+qUERHM8rGaJ0dY?=
 =?us-ascii?Q?phstDEmurp2ucg7ikJbzkYy9yQdUr1Ln9Z3L5M832znzymVxvciaD9NAP4Dr?=
 =?us-ascii?Q?lMAQH1zU9CYPmZp8EaJ5Y57EegDaFEwpf18Spzpn/k2n5pjoUyRtqGIKSfLP?=
 =?us-ascii?Q?zGAOtBm+UoY2Y/drC5mX9YywZnw9zuduSQV4xk61gKRc4DOCj7yPLset37Hf?=
 =?us-ascii?Q?gxeE+YyoKa3HVY6P/jZG9diSkYpc3iQ+EtRMxZAZd61R+AjwOK0L9XUj94SS?=
 =?us-ascii?Q?aN0zxv6COPYBxn3JYb14aJSNDZ1X7q4mzwYuw5CreDiF7IpIAKElWsdC/KEg?=
 =?us-ascii?Q?vlgnEi1mVfBEZFZqRopyDxb91KoBAJv0DDQwvkIIN53sYidst3faQzpdI4Fo?=
 =?us-ascii?Q?mOq66N1ynX9gJugZ0ifnv+Tees+bxTPWKpn2m2ZpwSxQuDzrIhkq0x2tex40?=
 =?us-ascii?Q?Ey6xWwfr+Cleb8RhXIQtm9iKGQQq2Rm1xeOFyfwLVNGQ/PHg5uu5ilZZfW6s?=
 =?us-ascii?Q?NMPQ7bQv0RBUShBPf5MHYSrxml77SvSiVdn1wzQxQVtzrFSAEGrQvuOTblfl?=
 =?us-ascii?Q?X7aC0mzYA5ih9469AuYPl2YPYPIVCivxjgI3PtxC7DFTPpM3UOfvz63Jo7Zj?=
 =?us-ascii?Q?pDq1Xq+eCvwtebtvYEfLIzZa81+3FOz3zNvCsAMPtVRj/Nk5vzpo1pkRZFSP?=
 =?us-ascii?Q?Y/HBwRY7vLhVG+A6CDWFV6utxst97c0TEF1qwy/4d7+cadYD9ytyZL4oVtBT?=
 =?us-ascii?Q?MzaXaPTvKwgYgwrgb86XCJ4zYUdvmMIECWlGY2glrXfp089QwwhwykaNOAQt?=
 =?us-ascii?Q?lx0/1jwnyGzw/mqe9j/CgcdpvGqQ5vDvHUyA93vb6X0+SDNDsYxp+u3DOkZL?=
 =?us-ascii?Q?tGtx2o2X3JNcwwAWBiBsJBptJveMhC9IzLcI3Rs8n/NHy3DCK5mPmVSj5V+h?=
 =?us-ascii?Q?gRHaL0zM/AC8ISwV9I3Q5mAckwJSl8cGZzx9ZPw/lnh4W4Lce3KtSd+LboS5?=
 =?us-ascii?Q?Rnz1nI4T2vEky3w07vn38hBwHH/K1g41M+n4yCtlC0bRCQUQ/Z/Vjt2OO49k?=
 =?us-ascii?Q?gZ6CUFseeLUPwRUgymkiviUgqY2EEr5e+OmBuhZAMKlGRFWpPUt18oKvJDa+?=
 =?us-ascii?Q?oFDCtMtBGhhVOB/HOoN5rUI1f4ppkVKta4RMvHzPiaFOKCh7sk7dWOiEj3xL?=
 =?us-ascii?Q?56Z/aoFbmQXxlT9DCcKOJQ2Nrgym5xwqEQCkfB3NfrToBnu8tU4cfMxOwY3H?=
 =?us-ascii?Q?POc42TdVQ4qIwDcoP32ZLPRg?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <756E3D8BCE56214A904C4FC4A3D9E8A5@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f6768fe-d3b5-4a58-32c1-08d964c0feef
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2021 16:30:32.2157
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: U1kTI3ufFp03jBw9grrEYYs0138noTzEcqr05ihHWla/YbeDtjI8s7PX6L8fY+bvh6JtlEfbyXS5cV75Kij6ig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4591
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10083 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 malwarescore=0
 spamscore=0 adultscore=0 mlxlogscore=999 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108210101
X-Proofpoint-ORIG-GUID: PziPOACuvmQGyES-IbhWAI0gbxwmss3z
X-Proofpoint-GUID: PziPOACuvmQGyES-IbhWAI0gbxwmss3z
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Aug 20, 2021, at 5:02 PM, J. Bruce Fields <bfields@redhat.com> wrote:
>=20
> From: "J. Bruce Fields" <bfields@redhat.com>
>=20
> It'll come in handy to get the whole nlm_lock.
>=20
> Signed-off-by: J. Bruce Fields <bfields@redhat.com>
> ---
> fs/lockd/svc4proc.c         |  2 +-
> fs/lockd/svcproc.c          |  2 +-
> fs/lockd/svcsubs.c          | 14 +++++++-------
> include/linux/lockd/lockd.h |  2 +-
> 4 files changed, 10 insertions(+), 10 deletions(-)
>=20
> diff --git a/fs/lockd/svc4proc.c b/fs/lockd/svc4proc.c
> index 4c10fb5138f1..aa8eca7c38a1 100644
> --- a/fs/lockd/svc4proc.c
> +++ b/fs/lockd/svc4proc.c
> @@ -40,7 +40,7 @@ nlm4svc_retrieve_args(struct svc_rqst *rqstp, struct nl=
m_args *argp,
>=20
> 	/* Obtain file pointer. Not used by FREE_ALL call. */
> 	if (filp !=3D NULL) {
> -		if ((error =3D nlm_lookup_file(rqstp, &file, &lock->fh)) !=3D 0)
> +		if ((error =3D nlm_lookup_file(rqstp, &file, lock)) !=3D 0)

Style: Replace the "assignment in if statement" in these spots,
bitte?

Since we're dealing with a __be32 result, a direct comparison
with "0" is misleading. It might be better documentation to
go with:

    error =3D nlm_lookup_file(rqstp, &file, lock);
    if (error)


> 			goto no_locks;
> 		*filp =3D file;
>=20
> diff --git a/fs/lockd/svcproc.c b/fs/lockd/svcproc.c
> index 4ae4b63b5392..f4e5e0eb30fd 100644
> --- a/fs/lockd/svcproc.c
> +++ b/fs/lockd/svcproc.c
> @@ -69,7 +69,7 @@ nlmsvc_retrieve_args(struct svc_rqst *rqstp, struct nlm=
_args *argp,
>=20
> 	/* Obtain file pointer. Not used by FREE_ALL call. */
> 	if (filp !=3D NULL) {
> -		error =3D cast_status(nlm_lookup_file(rqstp, &file, &lock->fh));
> +		error =3D cast_status(nlm_lookup_file(rqstp, &file, lock));
> 		if (error !=3D 0)
> 			goto no_locks;
> 		*filp =3D file;
> diff --git a/fs/lockd/svcsubs.c b/fs/lockd/svcsubs.c
> index 028fc152da22..bbd2bdde4bea 100644
> --- a/fs/lockd/svcsubs.c
> +++ b/fs/lockd/svcsubs.c
> @@ -82,31 +82,31 @@ static inline unsigned int file_hash(struct nfs_fh *f=
)
>  */
> __be32
> nlm_lookup_file(struct svc_rqst *rqstp, struct nlm_file **result,
> -					struct nfs_fh *f)
> +					struct nlm_lock *lock)
> {
> 	struct nlm_file	*file;
> 	unsigned int	hash;
> 	__be32		nfserr;
>=20
> -	nlm_debug_print_fh("nlm_lookup_file", f);
> +	nlm_debug_print_fh("nlm_lookup_file", &lock->fh);
>=20
> -	hash =3D file_hash(f);
> +	hash =3D file_hash(&lock->fh);
>=20
> 	/* Lock file table */
> 	mutex_lock(&nlm_file_mutex);
>=20
> 	hlist_for_each_entry(file, &nlm_files[hash], f_list)
> -		if (!nfs_compare_fh(&file->f_handle, f))
> +		if (!nfs_compare_fh(&file->f_handle, &lock->fh))
> 			goto found;
>=20
> -	nlm_debug_print_fh("creating file for", f);
> +	nlm_debug_print_fh("creating file for", &lock->fh);
>=20
> 	nfserr =3D nlm_lck_denied_nolocks;
> 	file =3D kzalloc(sizeof(*file), GFP_KERNEL);
> 	if (!file)
> 		goto out_unlock;
>=20
> -	memcpy(&file->f_handle, f, sizeof(struct nfs_fh));
> +	memcpy(&file->f_handle, &lock->fh, sizeof(struct nfs_fh));
> 	mutex_init(&file->f_mutex);
> 	INIT_HLIST_NODE(&file->f_list);
> 	INIT_LIST_HEAD(&file->f_blocks);
> @@ -117,7 +117,7 @@ nlm_lookup_file(struct svc_rqst *rqstp, struct nlm_fi=
le **result,
> 	 * We have to make sure we have the right credential to open
> 	 * the file.
> 	 */
> -	if ((nfserr =3D nlmsvc_ops->fopen(rqstp, f, &file->f_file)) !=3D 0) {
> +	if ((nfserr =3D nlmsvc_ops->fopen(rqstp, &lock->fh, &file->f_file)) !=
=3D 0) {

Ditto.


> 		dprintk("lockd: open failed (error %d)\n", nfserr);
> 		goto out_free;
> 	}
> diff --git a/include/linux/lockd/lockd.h b/include/linux/lockd/lockd.h
> index 666f5f310a04..81b71ad2040a 100644
> --- a/include/linux/lockd/lockd.h
> +++ b/include/linux/lockd/lockd.h
> @@ -286,7 +286,7 @@ void		  nlmsvc_locks_init_private(struct file_lock *,=
 struct nlm_host *, pid_t);
>  * File handling for the server personality
>  */
> __be32		  nlm_lookup_file(struct svc_rqst *, struct nlm_file **,
> -					struct nfs_fh *);
> +					struct nlm_lock *);
> void		  nlm_release_file(struct nlm_file *);
> void		  nlmsvc_release_lockowner(struct nlm_lock *);
> void		  nlmsvc_mark_resources(struct net *);
> --=20
> 2.31.1
>=20

--
Chuck Lever



