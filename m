Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B7EB3F3B72
	for <lists+linux-nfs@lfdr.de>; Sat, 21 Aug 2021 18:30:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbhHUQbc (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 21 Aug 2021 12:31:32 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:41106 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229669AbhHUQbb (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 21 Aug 2021 12:31:31 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 17L5SqV3004900;
        Sat, 21 Aug 2021 16:30:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=Z2mBnIT9DB2hsDlgit7IQltwof3iv8r7Dt+zQhGj4qQ=;
 b=eHpI7B9R8u1iDuSyGKVuZ4neBQZ1LapjeeU3qYOh4HwK0KDS+vmMLlmJQXPsGq2GzEmZ
 fhqpg/j73J8u0ebYiDey3wHYPOhIDAwjDxtmCf8njEZ+Mw6qOPOsdLqTulTMzzGPg3hg
 aT4wuhUBF8XfLjLK7FRSauTZUdS/ZroVgMir8NewjJeDJLtqWbtVsBsAckkehLeI6I+P
 dFQc8JXGCDIkBMPKVKcxEbA8jiTtYv5Tk/hd9RpI1NIpa673865ps+5ATojfqcZLjOvq
 6RFIcFaWHy/sBC5HiLc9dKbXbk4kbDQ2IxnfnSV/vnw/0f7W1qCA/q+jPrRd0XtaIKpl gw== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=Z2mBnIT9DB2hsDlgit7IQltwof3iv8r7Dt+zQhGj4qQ=;
 b=WhBND66uNwQAs0IbBc7001y6VJdElIDPIQhaRdxjCpWjVRPKEzrLmJEHP8XAZscRN+fr
 j3Djxl084ErzRlBjmxDqrCLNfTo/5MudHKo/uEo30mQKINevWlm77zdndM6uMtXZ8LJ9
 U7nVPtntJh9QKPdaJXA7Ny0Z5oFqoF0hR+wuikjxS9pSiu38xNU/3EwZRrnmEGdYfOKw
 m2IGxsvkveSVoQyvuiQPrqoXl0pL0S9wqzg+ChJ4ZsT/PglDumxLnTZIab1c6uxcti7r
 HqjNac20QrifIbLRe6Q8sHse6NmwMCVeHZMKeZjxY6q2lmyCXD5ZaV0iMmXkmJHF4Dsq 8g== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ajtx6ghm7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 21 Aug 2021 16:30:47 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17LGFFFp101936;
        Sat, 21 Aug 2021 16:30:46 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
        by userp3020.oracle.com with ESMTP id 3ajrtm6vvs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 21 Aug 2021 16:30:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V2nuWSgq0icvwgr8TWhN6U0WW4xS9DapP9VLE0VR7I8ZW3KHtYRb+eDMnZ/n3mRZsq38KsCNLQnvhb9SDnLmn0+KJOv4kSj+W04fIbB/AwNVH4Je0OOUh3S+g5ICunThbYE8WMpyU9V5/MBdrmqoLIEYtCI2oNKbTv5ZxLiQ8NFnTb6R/pPGiqYbDRR/e/62P2dHnorzACiVdz+G4PgEuKGLzUk33uKmxSeeyc5+PBvSVu+O6E82j2uWLMnQZtK2ptIfhJnm+13uWma+a04uj/VGswJf6NxrrRXwYB34CXRlh9A+MAR5VrVTxSFEy8+/IR6o0OExdHFtQc1V1ozc4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z2mBnIT9DB2hsDlgit7IQltwof3iv8r7Dt+zQhGj4qQ=;
 b=Oy8r/V23D3/4HCxiHkPYNIrIKDakOaLh3t79XR53ggujruZD1Wj//qsOwiJootTPQG8nA+NfvEv1R9uy/yh4QPq0meUwKfq87Q+QXp8bnn15AL+oO7dEvf+dJdYifKt7hCRUZFyRO8HkrPbVWwS3zoeJ+/iqNhgiCOgxg5IbuY9Z4VfVObEP+YnSiLMnzvrZfqBJ0uUXVdDwR01LVaYf23yYafxc6tZn+6jyEHQnIAkXQLKJXe6vX/2zkAt5ajSSdK7ePLIB+7mdok8iy6rbQPxU/y5eGcmf1bTZMZxi+u6MUPSa+XbQnnW7nTghAK9q9vMe0viz1W4KJdmeW8IlZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z2mBnIT9DB2hsDlgit7IQltwof3iv8r7Dt+zQhGj4qQ=;
 b=R/WafH1Bs9bee6Tb97PzWOBPBd1PZBdQc1UqaEY7raGV5xOdzTZ4l+IJUhDWLEhrWu8w0KHQgmVv9KVCoxJbUkOa8PBPzFxnkQrrJvLFVbvX+eUA3wU06aknJjKlNmJ2ddCHDwoyukAAv5rV1ZOpDcJ9bk0pYGAIiRYUQE5vbck=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by SJ0PR10MB4591.namprd10.prod.outlook.com (2603:10b6:a03:2af::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.21; Sat, 21 Aug
 2021 16:30:43 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::a8db:4fc8:ded5:e64]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::a8db:4fc8:ded5:e64%7]) with mapi id 15.20.4436.019; Sat, 21 Aug 2021
 16:30:43 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Bruce Fields <bfields@redhat.com>
CC:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <schumakeranna@gmail.com>,
        "daire@dneg.com" <daire@dneg.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 5/8] Keep read and write fds with each nlm_file
Thread-Topic: [PATCH 5/8] Keep read and write fds with each nlm_file
Thread-Index: AQHXlgaoDTPabXQqaUuaOjS+9zbjC6t+J7cA
Date:   Sat, 21 Aug 2021 16:30:43 +0000
Message-ID: <FD16AB43-CC95-44FC-AB08-159AF5C3CAB7@oracle.com>
References: <1629493326-28336-1-git-send-email-bfields@redhat.com>
 <1629493326-28336-6-git-send-email-bfields@redhat.com>
In-Reply-To: <1629493326-28336-6-git-send-email-bfields@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c8258b28-2562-4e84-434a-08d964c10594
x-ms-traffictypediagnostic: SJ0PR10MB4591:
x-microsoft-antispam-prvs: <SJ0PR10MB4591B8452DCD806481DAD81A93C29@SJ0PR10MB4591.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0h8nnJfaKP9vMGd+k5R3wYkSdabDYVP2TdVH7hkchUrkliks+8PHfpFbEiKf+xPDyHzg5MrVgPDjsU1meMabL8gfus7v6UCAb7fQ/VNxliq2XbXtYKHO0v5z+72XGfNjKjJviEMUcBwo1IMKTGepnbBaP/Y4mMtJVErWGEOzVoM3DwscQgz3hZ8spcNHQDXtVOEN+pzuhMyMq1DLhjyamxi91ge9rLODsJ2Nn7Zd793TSM/3v6CQVMTjKGi5HuVLeloJPPxXpaa7wWLUfAWhaa7O6HxkqPxFZsuDhnTu2IIy94RD4XNRF/NwiJL5SVeGYv0MNTGkjFq3xmgaugeS8tmdCOcEgaSb2x6fy2bUN2A5z2dooAviDzbToBKWZ9Yc862pK4ok9oETH7UHu4wLWeywEcPfNPXySYGrq3C5Tns0AUXHEaP8CXx5dHcxd8PnruKrH77Pi+KN+7lAsRY/+iUJTTnmRm+LvE+KGNYCYPoOUB2st1aVx5IHUqrq93/A7rcypgAbMNrSAMSijevmOuDkkNzF6WugqZbENYZdZpFDfwNCtFgTscqOK4ecKDZBr8J7PXARVttgvhIA53UZQaygOM2VsH38QS8z92IP+wBlGajxfjsER8ub4GQpIkXS5G02+uXVk815YLAufNDpazuxkskz1CHOgvSOdrVYQzr+Sf4pJWzHhsXIZiATFsTuvf/hxRt/72i1hLazFQixvylk+1z9Hu6IUXsim37EYnwHa+m+PyQNOWB6E1XuFnG6XMcPN71zJIDZ/a+3lIXOPQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66556008)(66446008)(66946007)(66476007)(6512007)(122000001)(316002)(64756008)(54906003)(6486002)(38100700002)(8676002)(4326008)(2616005)(33656002)(8936002)(71200400001)(53546011)(86362001)(186003)(76116006)(5660300002)(6506007)(6916009)(83380400001)(38070700005)(508600001)(30864003)(91956017)(26005)(2906002)(36756003)(21314003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?QNbbkbsqUQATwl76ACrxMyr8K1oNhDkyVEpeZKhcIBIZ+p7afuV/xr8p7Kq2?=
 =?us-ascii?Q?zTJ89HwjDkk0usd0KanYT8QictqW76Crg6cAiRLvvoabXCnoPWDH7jJDowlh?=
 =?us-ascii?Q?ctWSl3BZSg0lunDFDXGGP8R02HjFGc1CMJOX3YajG7H8I3TRcU/Ty1bGbmjQ?=
 =?us-ascii?Q?ZWwvHlQej/ht+REnx6j1alXeOHQ7eAIMhznj1GSoIlLZDlI+9F2DUCJbA19s?=
 =?us-ascii?Q?Q9BTLwuSviJThO8H0PAh//zvuHbNa/S01YxrtWoa0kar558cVpR2mUU4TDdN?=
 =?us-ascii?Q?bHoeqqw6YZgd/kBZfDtCFGByFp3tFL7rv/ekZayCyjFZQt6MG4kPnSvLtb1l?=
 =?us-ascii?Q?UJTbqZHbRu5klrpF3W/4Yn8+CoIKLNhnGPiV/4JRFhIPdezhdrXD3F4Ew092?=
 =?us-ascii?Q?Z2DE8JtYd/8CPEno0W6eNBQQpbkjepRCsDXmf0dZUq5Rgw3AYIC7JdlduoW/?=
 =?us-ascii?Q?qzL1nI98AqsPNUn3E8SEQiLAoDNfTS7YPEglivcmD7RaCwGT8XFeyW1ACyjG?=
 =?us-ascii?Q?X82bCpASa1Xr+bbIxlNsL5cmzmiF/H6eQbomOJinI8r6eZiHZz5dPyLHinrT?=
 =?us-ascii?Q?efoTVMctnl1HlhtwoCe8dhKw5rPWEf5uy+aBUT4yYnBktbDL96gYqF4nH0UN?=
 =?us-ascii?Q?PNS8gpFp06hlprkr+vXBeLhI8mYELkZaGhZVrz81t5cfD5nualxutrUibVNc?=
 =?us-ascii?Q?6CvLm8+pA/x1pSy2XiSpiPyxxwS5c9WttdBcVT67FK4mBolbz0yPsWfys7JB?=
 =?us-ascii?Q?eiJCmFcCnQRuwUOQcD6IiXMlJBCgGqgevYgfWPwc7DT3ZudAnixJ11MDhRrr?=
 =?us-ascii?Q?c3OircKaJTQJFSCYn0cbOcYL9wTlnQfEaZD1hoVKFCApCjUb3R8IBy/QtvUi?=
 =?us-ascii?Q?XuD8V9rd/UM3NvY/JFUMFk2rDJhtPC2lFXJvLd5B8UmR/s+tJDjIvnKVNhPQ?=
 =?us-ascii?Q?EtyHIEh3crN+68EewDcCCI4S6Y5aMLjWweI7U8AdGcZ4NKloLzkuo8AHS10A?=
 =?us-ascii?Q?wFY4tLPp2xCKNcrAsftoGMW426o7n0EgJeQk+u7OOA6n/O/1eZbqGRklb5up?=
 =?us-ascii?Q?xU/1cfw6SCPC1Xp5Iz/Vzlk2WUIeEYopOLYvpKC1G1EUf1B3GF5QnHmY4WlS?=
 =?us-ascii?Q?hvB+ncMEkXKvFvtOiUTCoQxtol8xcia+UdyIi4XwHDWNfBEp1glnMDEiC7Cs?=
 =?us-ascii?Q?XxAvBq57MmmlNvmuLedW/TEb7e4qRaUXPtHeXB0Yh7QIrqz/2UISsTDGhAET?=
 =?us-ascii?Q?bNbbvfIwhbwCZ9Mo/OQLTMRbWmoeHplgnZLHjKFGf3JlTP7+du88lbALJFeI?=
 =?us-ascii?Q?jb2cno/UNAMcYf0Cgw1+ypGX?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A43EC103E3221A4FBF0855BBB4F36CF5@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8258b28-2562-4e84-434a-08d964c10594
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2021 16:30:43.3838
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /COw+93Opd0H2z283efLhn8nL8bL1PotnzMPyKBAivLrbK93M65USig0FZMoLDWLCOiV8LK1yf8D/BQVNX7uZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4591
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10083 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 bulkscore=0 adultscore=0 suspectscore=0 mlxscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108210101
X-Proofpoint-ORIG-GUID: Xn-Lp_gXlc0z9Oz0oU7y7TqpkSdEHvvu
X-Proofpoint-GUID: Xn-Lp_gXlc0z9Oz0oU7y7TqpkSdEHvvu
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Nit: short description should start with "nlm:"


> On Aug 20, 2021, at 5:02 PM, J. Bruce Fields <bfields@redhat.com> wrote:
>=20
> From: "J. Bruce Fields" <bfields@redhat.com>
>=20
> We shouldn't really be using a read-only file descriptor to take a write
> lock.
>=20
> Most filesystems will put up with it.  But NFS, for example, won't.

Two overall concerns:

1. Would it be easy/possible to split this patch further?

2. What kind of testing would provide a level of confidence
   that no regressions have been introduced by this change?


> Signed-off-by: J. Bruce Fields <bfields@redhat.com>
> ---
> fs/lockd/svc4proc.c         |   4 +-
> fs/lockd/svclock.c          |  25 ++++++---
> fs/lockd/svcproc.c          |   4 +-
> fs/lockd/svcsubs.c          | 104 +++++++++++++++++++++++++-----------
> fs/nfsd/lockd.c             |   8 ++-
> include/linux/lockd/bind.h  |   3 +-
> include/linux/lockd/lockd.h |   9 +++-
> 7 files changed, 114 insertions(+), 43 deletions(-)
>=20
> diff --git a/fs/lockd/svc4proc.c b/fs/lockd/svc4proc.c
> index aa8eca7c38a1..c7587de948e4 100644
> --- a/fs/lockd/svc4proc.c
> +++ b/fs/lockd/svc4proc.c
> @@ -40,12 +40,14 @@ nlm4svc_retrieve_args(struct svc_rqst *rqstp, struct =
nlm_args *argp,
>=20
> 	/* Obtain file pointer. Not used by FREE_ALL call. */
> 	if (filp !=3D NULL) {
> +		int mode =3D lock_to_openmode(&lock->fl);
> +
> 		if ((error =3D nlm_lookup_file(rqstp, &file, lock)) !=3D 0)
> 			goto no_locks;
> 		*filp =3D file;
>=20
> 		/* Set up the missing parts of the file_lock structure */
> -		lock->fl.fl_file  =3D file->f_file;
> +		lock->fl.fl_file  =3D file->f_file[mode];
> 		lock->fl.fl_pid =3D current->tgid;
> 		lock->fl.fl_lmops =3D &nlmsvc_lock_operations;
> 		nlmsvc_locks_init_private(&lock->fl, host, (pid_t)lock->svid);
> diff --git a/fs/lockd/svclock.c b/fs/lockd/svclock.c
> index bc1cf31f3cce..d60e6eea2d57 100644
> --- a/fs/lockd/svclock.c
> +++ b/fs/lockd/svclock.c
> @@ -471,6 +471,7 @@ nlmsvc_lock(struct svc_rqst *rqstp, struct nlm_file *=
file,
> {
> 	struct nlm_block	*block =3D NULL;
> 	int			error;
> +	int			mode;
> 	__be32			ret;
>=20
> 	dprintk("lockd: nlmsvc_lock(%s/%ld, ty=3D%d, pi=3D%d, %Ld-%Ld, bl=3D%d)\=
n",
> @@ -524,7 +525,8 @@ nlmsvc_lock(struct svc_rqst *rqstp, struct nlm_file *=
file,
>=20
> 	if (!wait)
> 		lock->fl.fl_flags &=3D ~FL_SLEEP;
> -	error =3D vfs_lock_file(file->f_file, F_SETLK, &lock->fl, NULL);
> +	mode =3D lock_to_openmode(&lock->fl);
> +	error =3D vfs_lock_file(file->f_file[mode], F_SETLK, &lock->fl, NULL);
> 	lock->fl.fl_flags &=3D ~FL_SLEEP;
>=20
> 	dprintk("lockd: vfs_lock_file returned %d\n", error);
> @@ -577,6 +579,7 @@ nlmsvc_testlock(struct svc_rqst *rqstp, struct nlm_fi=
le *file,
> 		struct nlm_lock *conflock, struct nlm_cookie *cookie)
> {
> 	int			error;
> +	int			mode;
> 	__be32			ret;
> 	struct nlm_lockowner	*test_owner;
>=20
> @@ -595,7 +598,8 @@ nlmsvc_testlock(struct svc_rqst *rqstp, struct nlm_fi=
le *file,
> 	/* If there's a conflicting lock, remember to clean up the test lock */
> 	test_owner =3D (struct nlm_lockowner *)lock->fl.fl_owner;
>=20
> -	error =3D vfs_test_lock(file->f_file, &lock->fl);
> +	mode =3D lock_to_openmode(&lock->fl);
> +	error =3D vfs_test_lock(file->f_file[mode], &lock->fl);
> 	if (error) {
> 		/* We can't currently deal with deferred test requests */
> 		if (error =3D=3D FILE_LOCK_DEFERRED)
> @@ -641,7 +645,7 @@ nlmsvc_testlock(struct svc_rqst *rqstp, struct nlm_fi=
le *file,
> __be32
> nlmsvc_unlock(struct net *net, struct nlm_file *file, struct nlm_lock *lo=
ck)
> {
> -	int	error;
> +	int	error =3D 0;
>=20
> 	dprintk("lockd: nlmsvc_unlock(%s/%ld, pi=3D%d, %Ld-%Ld)\n",
> 				nlmsvc_file_inode(file)->i_sb->s_id,
> @@ -654,7 +658,12 @@ nlmsvc_unlock(struct net *net, struct nlm_file *file=
, struct nlm_lock *lock)
> 	nlmsvc_cancel_blocked(net, file, lock);
>=20
> 	lock->fl.fl_type =3D F_UNLCK;
> -	error =3D vfs_lock_file(file->f_file, F_SETLK, &lock->fl, NULL);
> +	if (file->f_file[0])
> +		error =3D vfs_lock_file(file->f_file[0], F_SETLK,
> +					&lock->fl, NULL);
> +	if (file->f_file[1])
> +		error =3D vfs_lock_file(file->f_file[1], F_SETLK,
> +					&lock->fl, NULL);

Eschew raw integers :-) Should the f_file array be indexed
using O_ flags as the comment below suggests?


> 	return (error < 0)? nlm_lck_denied_nolocks : nlm_granted;
> }
> @@ -671,6 +680,7 @@ nlmsvc_cancel_blocked(struct net *net, struct nlm_fil=
e *file, struct nlm_lock *l
> {
> 	struct nlm_block	*block;
> 	int status =3D 0;
> +	int mode;
>=20
> 	dprintk("lockd: nlmsvc_cancel(%s/%ld, pi=3D%d, %Ld-%Ld)\n",
> 				nlmsvc_file_inode(file)->i_sb->s_id,
> @@ -686,7 +696,8 @@ nlmsvc_cancel_blocked(struct net *net, struct nlm_fil=
e *file, struct nlm_lock *l
> 	block =3D nlmsvc_lookup_block(file, lock);
> 	mutex_unlock(&file->f_mutex);
> 	if (block !=3D NULL) {
> -		vfs_cancel_lock(block->b_file->f_file,
> +		mode =3D lock_to_openmode(&lock->fl);
> +		vfs_cancel_lock(block->b_file->f_file[mode],
> 				&block->b_call->a_args.lock.fl);
> 		status =3D nlmsvc_unlink_block(block);
> 		nlmsvc_release_block(block);
> @@ -803,6 +814,7 @@ nlmsvc_grant_blocked(struct nlm_block *block)
> {
> 	struct nlm_file		*file =3D block->b_file;
> 	struct nlm_lock		*lock =3D &block->b_call->a_args.lock;
> +	int			mode;
> 	int			error;
> 	loff_t			fl_start, fl_end;
>=20
> @@ -828,7 +840,8 @@ nlmsvc_grant_blocked(struct nlm_block *block)
> 	lock->fl.fl_flags |=3D FL_SLEEP;
> 	fl_start =3D lock->fl.fl_start;
> 	fl_end =3D lock->fl.fl_end;
> -	error =3D vfs_lock_file(file->f_file, F_SETLK, &lock->fl, NULL);
> +	mode =3D lock_to_openmode(&lock->fl);
> +	error =3D vfs_lock_file(file->f_file[mode], F_SETLK, &lock->fl, NULL);
> 	lock->fl.fl_flags &=3D ~FL_SLEEP;
> 	lock->fl.fl_start =3D fl_start;
> 	lock->fl.fl_end =3D fl_end;
> diff --git a/fs/lockd/svcproc.c b/fs/lockd/svcproc.c
> index f4e5e0eb30fd..99696d3f6dd6 100644
> --- a/fs/lockd/svcproc.c
> +++ b/fs/lockd/svcproc.c
> @@ -55,6 +55,7 @@ nlmsvc_retrieve_args(struct svc_rqst *rqstp, struct nlm=
_args *argp,
> 	struct nlm_host		*host =3D NULL;
> 	struct nlm_file		*file =3D NULL;
> 	struct nlm_lock		*lock =3D &argp->lock;
> +	int			mode;
> 	__be32			error =3D 0;
>=20
> 	/* nfsd callbacks must have been installed for this procedure */
> @@ -75,7 +76,8 @@ nlmsvc_retrieve_args(struct svc_rqst *rqstp, struct nlm=
_args *argp,
> 		*filp =3D file;
>=20
> 		/* Set up the missing parts of the file_lock structure */
> -		lock->fl.fl_file  =3D file->f_file;
> +		mode =3D lock_to_openmode(&lock->fl);
> +		lock->fl.fl_file  =3D file->f_file[mode];
> 		lock->fl.fl_pid =3D current->tgid;
> 		lock->fl.fl_lmops =3D &nlmsvc_lock_operations;
> 		nlmsvc_locks_init_private(&lock->fl, host, (pid_t)lock->svid);
> diff --git a/fs/lockd/svcsubs.c b/fs/lockd/svcsubs.c
> index f43d89e89c45..a0adaee245ae 100644
> --- a/fs/lockd/svcsubs.c
> +++ b/fs/lockd/svcsubs.c
> @@ -71,14 +71,38 @@ static inline unsigned int file_hash(struct nfs_fh *f=
)
> 	return tmp & (FILE_NRHASH - 1);
> }
>=20
> +int lock_to_openmode(struct file_lock *lock)
> +{
> +	if (lock->fl_type =3D=3D F_WRLCK)
> +		return O_WRONLY;
> +	else
> +		return O_RDONLY;

Style: a ternary would be more consistent with other areas
of the code you change in this patch.


> +}
> +
> +/*
> + * Open the file. Note that if we're reexporting, for example,
> + * this could block the lockd thread for a while.
> + *
> + * We have to make sure we have the right credential to open
> + * the file.
> + */
> +static __be32 nlm_do_fopen(struct svc_rqst *rqstp,
> +			   struct nlm_file *file, int mode)
> +{
> +	struct file **fp =3D &file->f_file[mode];
> +	__be32	nfserr;
> +
> +	if (*fp)
> +		return 0;
> +	nfserr =3D nlmsvc_ops->fopen(rqstp, &file->f_handle, fp, mode);
> +	if (nfserr)
> +		dprintk("lockd: open failed (error %d)\n", nfserr);
> +	return nfserr;
> +}
> +
> /*
>  * Lookup file info. If it doesn't exist, create a file info struct
>  * and open a (VFS) file for the given inode.
> - *
> - * FIXME:
> - * Note that we open the file O_RDONLY even when creating write locks.
> - * This is not quite right, but for now, we assume the client performs
> - * the proper R/W checking.
>  */
> __be32
> nlm_lookup_file(struct svc_rqst *rqstp, struct nlm_file **result,
> @@ -87,41 +111,38 @@ nlm_lookup_file(struct svc_rqst *rqstp, struct nlm_f=
ile **result,
> 	struct nlm_file	*file;
> 	unsigned int	hash;
> 	__be32		nfserr;
> +	int		mode;
>=20
> 	nlm_debug_print_fh("nlm_lookup_file", &lock->fh);
>=20
> 	hash =3D file_hash(&lock->fh);
> +	mode =3D lock_to_openmode(&lock->fl);
>=20
> 	/* Lock file table */
> 	mutex_lock(&nlm_file_mutex);
>=20
> 	hlist_for_each_entry(file, &nlm_files[hash], f_list)
> -		if (!nfs_compare_fh(&file->f_handle, &lock->fh))
> +		if (!nfs_compare_fh(&file->f_handle, &lock->fh)) {
> +			mutex_lock(&file->f_mutex);
> +			nfserr =3D nlm_do_fopen(rqstp, file, mode);
> +			mutex_unlock(&file->f_mutex);
> 			goto found;
> -
> +		}
> 	nlm_debug_print_fh("creating file for", &lock->fh);
>=20
> 	nfserr =3D nlm_lck_denied_nolocks;
> 	file =3D kzalloc(sizeof(*file), GFP_KERNEL);
> 	if (!file)
> -		goto out_unlock;
> +		goto out_free;
>=20
> 	memcpy(&file->f_handle, &lock->fh, sizeof(struct nfs_fh));
> 	mutex_init(&file->f_mutex);
> 	INIT_HLIST_NODE(&file->f_list);
> 	INIT_LIST_HEAD(&file->f_blocks);
>=20
> -	/*
> -	 * Open the file. Note that if we're reexporting, for example,
> -	 * this could block the lockd thread for a while.
> -	 *
> -	 * We have to make sure we have the right credential to open
> -	 * the file.
> -	 */
> -	if ((nfserr =3D nlmsvc_ops->fopen(rqstp, &lock->fh, &file->f_file)) !=
=3D 0) {
> -		dprintk("lockd: open failed (error %d)\n", nfserr);
> -		goto out_free;
> -	}
> +	nfserr =3D nlm_do_fopen(rqstp, file, mode);
> +	if (nfserr)
> +		goto out_unlock;
>=20
> 	hlist_add_head(&file->f_list, &nlm_files[hash]);
>=20
> @@ -129,7 +150,6 @@ nlm_lookup_file(struct svc_rqst *rqstp, struct nlm_fi=
le **result,
> 	dprintk("lockd: found file %p (count %d)\n", file, file->f_count);
> 	*result =3D file;
> 	file->f_count++;
> -	nfserr =3D 0;
>=20
> out_unlock:
> 	mutex_unlock(&nlm_file_mutex);
> @@ -149,13 +169,34 @@ nlm_delete_file(struct nlm_file *file)
> 	nlm_debug_print_file("closing file", file);
> 	if (!hlist_unhashed(&file->f_list)) {
> 		hlist_del(&file->f_list);
> -		nlmsvc_ops->fclose(file->f_file);
> +		if (file->f_file[O_RDONLY])
> +			nlmsvc_ops->fclose(file->f_file[O_RDONLY]);
> +		if (file->f_file[O_WRONLY])
> +			nlmsvc_ops->fclose(file->f_file[O_WRONLY]);
> 		kfree(file);
> 	} else {
> 		printk(KERN_WARNING "lockd: attempt to release unknown file!\n");
> 	}
> }
>=20
> +static int nlm_unlock_files(struct nlm_file *file)
> +{
> +	struct file_lock lock;
> +	struct file *f;
> +
> +	lock.fl_type  =3D F_UNLCK;
> +	lock.fl_start =3D 0;
> +	lock.fl_end   =3D OFFSET_MAX;
> +	for (f =3D file->f_file[0]; f <=3D file->f_file[1]; f++) {
> +		if (f && vfs_lock_file(f, F_SETLK, &lock, NULL) < 0) {
> +			printk("lockd: unlock failure in %s:%d\n",
> +				__FILE__, __LINE__);

This needs a KERN_LEVEL and maybe a _once.


> +			return 1;
> +		}
> +	}
> +	return 0;
> +}
> +
> /*
>  * Loop over all locks on the given file and perform the specified
>  * action.
> @@ -183,17 +224,10 @@ nlm_traverse_locks(struct nlm_host *host, struct nl=
m_file *file,
>=20
> 		lockhost =3D ((struct nlm_lockowner *)fl->fl_owner)->host;
> 		if (match(lockhost, host)) {
> -			struct file_lock lock =3D *fl;
>=20
> 			spin_unlock(&flctx->flc_lock);
> -			lock.fl_type  =3D F_UNLCK;
> -			lock.fl_start =3D 0;
> -			lock.fl_end   =3D OFFSET_MAX;
> -			if (vfs_lock_file(file->f_file, F_SETLK, &lock, NULL) < 0) {
> -				printk("lockd: unlock failure in %s:%d\n",
> -						__FILE__, __LINE__);
> +			if (nlm_unlock_files(file))
> 				return 1;
> -			}
> 			goto again;
> 		}
> 	}
> @@ -247,6 +281,15 @@ nlm_file_inuse(struct nlm_file *file)
> 	return 0;
> }
>=20
> +static void nlm_close_files(struct nlm_file *file)
> +{
> +	struct file *f;
> +
> +	for (f =3D file->f_file[0]; f <=3D file->f_file[1]; f++)
> +		if (f)
> +			nlmsvc_ops->fclose(f);
> +}
> +
> /*
>  * Loop over all files in the file table.
>  */
> @@ -277,7 +320,7 @@ nlm_traverse_files(void *data, nlm_host_match_fn_t ma=
tch,
> 			if (list_empty(&file->f_blocks) && !file->f_locks
> 			 && !file->f_shares && !file->f_count) {
> 				hlist_del(&file->f_list);
> -				nlmsvc_ops->fclose(file->f_file);
> +				nlm_close_files(file);
> 				kfree(file);
> 			}
> 		}
> @@ -411,6 +454,7 @@ nlmsvc_invalidate_all(void)
> 	nlm_traverse_files(NULL, nlmsvc_is_client, NULL);
> }
>=20
> +
> static int
> nlmsvc_match_sb(void *datap, struct nlm_file *file)
> {
> diff --git a/fs/nfsd/lockd.c b/fs/nfsd/lockd.c
> index 3f5b3d7b62b7..606fa155c28a 100644
> --- a/fs/nfsd/lockd.c
> +++ b/fs/nfsd/lockd.c
> @@ -25,9 +25,11 @@
>  * Note: we hold the dentry use count while the file is open.
>  */
> static __be32
> -nlm_fopen(struct svc_rqst *rqstp, struct nfs_fh *f, struct file **filp)
> +nlm_fopen(struct svc_rqst *rqstp, struct nfs_fh *f, struct file **filp,
> +		int mode)
> {
> 	__be32		nfserr;
> +	int		access;
> 	struct svc_fh	fh;
>=20
> 	/* must initialize before using! but maxsize doesn't matter */
> @@ -36,7 +38,9 @@ nlm_fopen(struct svc_rqst *rqstp, struct nfs_fh *f, str=
uct file **filp)
> 	memcpy((char*)&fh.fh_handle.fh_base, f->data, f->size);
> 	fh.fh_export =3D NULL;
>=20
> -	nfserr =3D nfsd_open(rqstp, &fh, S_IFREG, NFSD_MAY_LOCK, filp);
> +	access =3D (mode =3D=3D O_WRONLY) ? NFSD_MAY_WRITE : NFSD_MAY_READ;
> +	access |=3D NFSD_MAY_LOCK;
> +	nfserr =3D nfsd_open(rqstp, &fh, S_IFREG, access, filp);
> 	fh_put(&fh);
>  	/* We return nlm error codes as nlm doesn't know
> 	 * about nfsd, but nfsd does know about nlm..
> diff --git a/include/linux/lockd/bind.h b/include/linux/lockd/bind.h
> index 0520c0cd73f4..3bc9f7410e21 100644
> --- a/include/linux/lockd/bind.h
> +++ b/include/linux/lockd/bind.h
> @@ -27,7 +27,8 @@ struct rpc_task;
> struct nlmsvc_binding {
> 	__be32			(*fopen)(struct svc_rqst *,
> 						struct nfs_fh *,
> -						struct file **);
> +						struct file **,
> +						int mode);

Style: "mode_t mode" might be better internal documentation.


> 	void			(*fclose)(struct file *);
> };
>=20
> diff --git a/include/linux/lockd/lockd.h b/include/linux/lockd/lockd.h
> index 81b71ad2040a..da319de7e557 100644
> --- a/include/linux/lockd/lockd.h
> +++ b/include/linux/lockd/lockd.h
> @@ -10,6 +10,8 @@
> #ifndef LINUX_LOCKD_LOCKD_H
> #define LINUX_LOCKD_LOCKD_H
>=20
> +/* XXX: a lot of this should really be under fs/lockd. */
> +
> #include <linux/in.h>
> #include <linux/in6.h>
> #include <net/ipv6.h>
> @@ -154,7 +156,8 @@ struct nlm_rqst {
> struct nlm_file {
> 	struct hlist_node	f_list;		/* linked list */
> 	struct nfs_fh		f_handle;	/* NFS file handle */
> -	struct file *		f_file;		/* VFS file pointer */
> +	struct file *		f_file[2];	/* VFS file pointers,
> +						   indexed by O_ flags */

Right, except that the new code in this patch always indexes
f_file with raw integers, making the comment misleading. My
preference is to keep the comment and change the new code to
index f_file symbolically.


> 	struct nlm_share *	f_shares;	/* DOS shares */
> 	struct list_head	f_blocks;	/* blocked locks */
> 	unsigned int		f_locks;	/* guesstimate # of locks */
> @@ -267,6 +270,7 @@ typedef int	  (*nlm_host_match_fn_t)(void *cur, struc=
t nlm_host *ref);
> /*
>  * Server-side lock handling
>  */
> +int		  lock_to_openmode(struct file_lock *);
> __be32		  nlmsvc_lock(struct svc_rqst *, struct nlm_file *,
> 			      struct nlm_host *, struct nlm_lock *, int,
> 			      struct nlm_cookie *, int);
> @@ -301,7 +305,8 @@ int           nlmsvc_unlock_all_by_ip(struct sockaddr=
 *server_addr);
>=20
> static inline struct inode *nlmsvc_file_inode(struct nlm_file *file)
> {
> -	return locks_inode(file->f_file);
> +	return locks_inode(file->f_file[0] ?
> +				file->f_file[0] : file->f_file[1]);
> }
>=20
> static inline int __nlm_privileged_request4(const struct sockaddr *sap)
> --=20
> 2.31.1
>=20

--
Chuck Lever



