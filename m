Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B1ED568F32
	for <lists+linux-nfs@lfdr.de>; Wed,  6 Jul 2022 18:30:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232241AbiGFQaX (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 6 Jul 2022 12:30:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234008AbiGFQaW (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 6 Jul 2022 12:30:22 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9322822BCB
        for <linux-nfs@vger.kernel.org>; Wed,  6 Jul 2022 09:30:21 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 266GDYQk009655;
        Wed, 6 Jul 2022 16:30:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=ktjDxtX7BNIXpKF+KADPjq3GC/tEIOwiZad5vJLw88o=;
 b=T5SmeQ0rl/RxanlsIvQ/2Bkleq2/g2SSDU38qlgZdNXfX1Ob05Dxbwh57fd0L4BUSx9I
 WTYg2HWkrtkNsbmCFN8MxE66Ug+S/UW77LB2vtJ5POvWVV+b0CdbEZYalH6jMKm9klsF
 v9WVga+/9fECq4CgBLrpjY4oODbqWpF9Nw8gRiYZXjLUT6XtTDlerxk3bybGFOo1pcKZ
 TumqciegYg99QdL82bmtPVMWm9e0d8I7K03DpYGhjt6Rt5j7f8dNCQ1CvT+Vn2RoHbYf
 pPDO1GY9IG48ZRETUZxhbbsngvjWaEdoRkbSMAQr447QNDj6YsXabzxEYOJItZHwY21P zA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3h4ubyam9f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Jul 2022 16:30:16 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 266GBIxu014953;
        Wed, 6 Jul 2022 16:30:15 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2176.outbound.protection.outlook.com [104.47.56.176])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3h4ud67n88-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Jul 2022 16:30:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UWKgEUMh7hmpMoXHfrXZPaqkZevzbt8MiY3jnl3+ybiTEdibGkgTBnwCd+exE8+DkF41esNitR+L9UhFUfkhFMqffaZbOvHV75c5WVjQkAR0D9Rrz98gdAYuglz94hfv8D+uGADbAOxIi1VQ08BF8+PPU4Q4n8zJjM9YjQ85vmPqZOE20HRfTx1pfVjXmy9ll2WU5aLt5jU1PYiOz6AdfrC0sQAyQ0j0B6gE5jPaA5tmYnY4DMgHehLiyDzOZvAjk385I+uVrDcTuH1zpOm/RQzvZPWoof2YG0VY50YhWMg/85LClHraXAX4nr4L9VTiPw7ewPFTLhm3a7toN0l1uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ktjDxtX7BNIXpKF+KADPjq3GC/tEIOwiZad5vJLw88o=;
 b=XlIzI612P8u/XtLDaLlkBN94r4sLvjHbbJQs9/hA3n63mNkIdcCi4uzP1H0C/X8bMWcBG1VhDTu4oI5CrfivXcvi1GD+k9ipF/zH1w8QJ0H88eWxYOtS17n15jsRiesauC1wyv9E6wkvVqaTc4yF0Tysj7kH98VYzBQWmM8yLimrTfi7XShfZS8xuanJcUheLxUmeXPmjEAtLnGMluBr/13b49OX9ZlmidxTC+80nHFW2nk3TUUQ+48X7B9kwNw02/iPMInHxSteyvCSOd3dODgKi9f90eIH9laXdnFrB/2s8dDbA4sa8WhLbKs50HfDu3C3BtlZdMewQqqZ6spWOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ktjDxtX7BNIXpKF+KADPjq3GC/tEIOwiZad5vJLw88o=;
 b=uFn2VBfuB8Bvyn4KC7mClWtcL/cbK/JxTGSld1kqsBcOJbTAqF0q3+MsPQbMdCT0HPsDZcGsWqIQpp7uGcfy0Zsot+QiuPNmFXqtCrnc+iy03KtC63TagkGUVeaiyqQWJbKpj4scR1g+F6Z6ABHH17GarFNvBIeBte+XxeG1hs8=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CY4PR10MB1445.namprd10.prod.outlook.com (2603:10b6:903:26::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.18; Wed, 6 Jul
 2022 16:30:12 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::9920:1ac4:2d14:e703]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::9920:1ac4:2d14:e703%5]) with mapi id 15.20.5395.021; Wed, 6 Jul 2022
 16:30:12 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Neil Brown <neilb@suse.de>
CC:     Jeff Layton <jlayton@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 7/8] NFSD: use (un)lock_inode instead of fh_(un)lock for
 file operations
Thread-Topic: [PATCH 7/8] NFSD: use (un)lock_inode instead of fh_(un)lock for
 file operations
Thread-Index: AQHYkO/f20f1iOr230WKsjF9l1nuJa1xiXQA
Date:   Wed, 6 Jul 2022 16:30:12 +0000
Message-ID: <0B0BE802-9B4A-4732-B798-2F13A8A6B93C@oracle.com>
References: <165708033167.1940.3364591321728458949.stgit@noble.brown>
 <165708109260.1940.6599746560136720935.stgit@noble.brown>
In-Reply-To: <165708109260.1940.6599746560136720935.stgit@noble.brown>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.100.31)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 609f762a-4b02-4261-b310-08da5f6ccd1f
x-ms-traffictypediagnostic: CY4PR10MB1445:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HHZcbi8RspGvAAY+hiaZ4xivf+5IAkDSUUVar64U96WFbDw5d92jfViKpJxzjPj4zJ3auA9usJh21MoTyhXC7ZsTVHCvBCwyfKyjUOae8Xz3+G4+BlIRAMKplQBl2ewa1IGFgQmUARSn3h4P6Xt4nCHkWklDJaEaZq/3hIF509L1IFFdRG+YCJIBj6Etx1gfuDWyC5Dn3CjiIP2hGOpnr35U2BYihtByJtdWFlQucV7q7R65nqQYZ1xVzkg+WU6460+lSyFAv9mgOAOPQOXqET0YDjPzH1eVEeiBsZM/fYfyIOmyeZYeU38DNP8CpP8JrOhPJ9JqBf8r3fPY5nPVssCUs8Is/aTLGN/he/gCZpAPzFtwe6DH4w0GySnq7HkuNQ0LDHtPzOhIVvPl8b93tzJPr8qfb0n3rlH8JI09bD9Xh26+gii7YNIq00JBKe7LtEbr1T5/7O3HxB6FFsM8IUxMIdaBRHcLAO6NurNJCxORo+U5uzwo3aYQ3g+O4Ils3YkNn+tKD7Cfj6lq5JGB1PZhCszGI8p+FrH8fTi5+tUe5Uuf482L14g9K9HuX5bbIKwta4yYY2W4m9dEKzAvaqW5pJzjZG6vxgyb19yfomI0Rl3DFdDuJXoSrkIDZJ5AY/zWuDncNTm/Po2OVWzLNOZ3QPmAteexn/IfgziIXg77qVsFgeI9X4+D+ab5fPQ5eRmy1O6cbKCcipGXkSpecU4xFLMwjns30pX+axmiGrp8xNJU0CC2cuDpGJ/wcQctbM1OAZRiewswTjQ0yJ/jod9YuZoXa8lb9YwpRFto/YdsGiwn4Wn3HXYhDINItrSEUkrIJy2fhrks/1Iu3dT8BFV+mJHSbYf3A7trL2GImoY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(366004)(396003)(376002)(136003)(346002)(83380400001)(122000001)(33656002)(6486002)(2906002)(41300700001)(36756003)(186003)(478600001)(6512007)(76116006)(64756008)(66446008)(86362001)(316002)(66946007)(66556008)(66476007)(71200400001)(2616005)(91956017)(5660300002)(6916009)(8936002)(54906003)(38100700002)(53546011)(26005)(8676002)(6506007)(38070700005)(4326008)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Efj8SRKJ4F/Y8QZn/tB8atT+PIXdDmfCvEF16/Ay8zy+b0Z73VZs+L3LZq+y?=
 =?us-ascii?Q?F+hofnuxYuJfoxl8Qbj9nGO3Kbs4ntuPRAong57+k+r0KFUFJxkHZ84Ntx2F?=
 =?us-ascii?Q?kY1TfnMwkbJGZcMHB3yXaAF1RefirkhMrd9ddY3lr7/y/mw9ZOnC5gnIONQA?=
 =?us-ascii?Q?OAwcdvyhjpsSh13+NRNbHit2loGn8GM55nHmIaI6m5J+bnfYeTY3hzdjN4+7?=
 =?us-ascii?Q?pelL6YNtzC4thMDbWYIYIuqNeSV5zdznfQYngULgUIvMq96bl82+eNx4MRSm?=
 =?us-ascii?Q?se7+rU6kh/TbwpYYn5zAW8RnPlmYJF1zIz9TsmTuWqPtXOKbAPaLyG7q6Tlo?=
 =?us-ascii?Q?F2a9w9N+SBuPtOz9W6AG/uMIOhNa+vNI1aAtQDXqwzqtaSk6aTt1bh5lEMy+?=
 =?us-ascii?Q?mxMWQQY7M1GH92Y+n1x0Ew1PXHOduIXvbFEehvlq0pi9R3rus4DxyLiLKTCf?=
 =?us-ascii?Q?dfv6O9/AjuwbKdBDYUq8K2CkAB3aLZ1Mabi9e5stPMCgghixas9VRDPx+TDE?=
 =?us-ascii?Q?pe/T/vYPFZNGCwWQ7QOxNTruDsSAtjM0NnUt5Nl2Aq4Fe91AlCK3iKYB3c4i?=
 =?us-ascii?Q?COolY6TEi5nocn4V1mVqbSkfgsGYd+RChPDTVwW783xgyHmCcOyJCJ0ekKqs?=
 =?us-ascii?Q?2QdC8kkwnCqHOFZ5zjjpcabBBVVfRopqMuwB1ggfHlNXccSqJ+vxs+GJaGRJ?=
 =?us-ascii?Q?dLPUK+bCVUfgHM3mp6douHVSgXk7j+sbJ0sl1unIOsDmIDuVg9DqY+HhqqgS?=
 =?us-ascii?Q?fgJGVl7pSIp+LX4a1wIVYa/QZ2qfzVeR3RAMFgbCSLFtGqHn1DCvdsauDl6w?=
 =?us-ascii?Q?kuOq6dDQ6MEObrXEl0A/2Esw2kfRyU8mC7u9aeDHztnmB6KjJpi3gHwzi+V2?=
 =?us-ascii?Q?+V/+sO8z+nVbD6YMnTGg8A/mAvE2gmiMiM7ob3U7xGEgVis2CShfrzb0sv51?=
 =?us-ascii?Q?8Di7sEZrrdhdQxOt8GGB8NYFUhWWKEORn/zFL8lKIgGfvp6o4rR75yysT+Le?=
 =?us-ascii?Q?gwWk0OjQZ2ulzxfs4X3s9fJp9UQOcOsB6EfC/gARVysZtx5oRFlB1FvJ1jb1?=
 =?us-ascii?Q?2bYGT/FeTLXz4Qo7MRp0Ujy3fzWmlp9FJuwA47sh2+oGgxNIrllsxWvDEX7e?=
 =?us-ascii?Q?VVN+mE6AEyhXEGCsRTrhAbpQksG6ap43dUBg03mBR7HBMcVlXbe06R2sohV5?=
 =?us-ascii?Q?kZM4uxOXGVPKCNi+TUW9KTJAsjELKlzDyqljXegJPmTHe4EQoo1hFgYmjqBG?=
 =?us-ascii?Q?/nsVtRKyUuffmbrDkhvGbPtpDIVFbPA0CNqkwF8on2mnlp7dVCm67cZgJq6S?=
 =?us-ascii?Q?4hC5esx+3X7rNUq6eza+7o9OydqUyLaaKq5VBeUMAcniN8T4pkVB5qSjRdPv?=
 =?us-ascii?Q?thh2lUeZTCFp8zmTJ0ox5vJM5qJtEz925S10oGXHCAMAJOTFdGVnMJkFuS/s?=
 =?us-ascii?Q?SqNhfGZ5j9ngoSH3taATET2E9hw4rhZTe/rjT9TqEhIY/fFROg/xipgXaIM2?=
 =?us-ascii?Q?A0ireW9zxAGbGNCXiBfPVZK9ZTgXbr5BWpr+O2FjSOYgNo16aD66fEOHRLLw?=
 =?us-ascii?Q?aXK5g+D5mEYxHRuXx5iK+O4ax/CL4CzGzVtbcCnS9askpPlX83xEGoUaX5/O?=
 =?us-ascii?Q?bA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E0BBCA51940D6649AFF96EF4BA8FABF3@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 609f762a-4b02-4261-b310-08da5f6ccd1f
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2022 16:30:12.8235
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ATSJ4xqxGpCkLDhH5M0/bBnp2og/i7Ia/6V5YEcjvWgiGa/D0Gy1FU9UEmQQyBbhtaNxDE0rfYdSEhgybOfZPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1445
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-07-06_09:2022-06-28,2022-07-06 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 phishscore=0
 adultscore=0 malwarescore=0 mlxscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207060065
X-Proofpoint-ORIG-GUID: JJmLC9Ow1hK3ASmLo1bovawX8fCVmfg-
X-Proofpoint-GUID: JJmLC9Ow1hK3ASmLo1bovawX8fCVmfg-
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jul 6, 2022, at 12:18 AM, NeilBrown <neilb@suse.de> wrote:
>=20
> When locking a file to access ACLs and xattrs etc, use explicit locking
> with inode_lock() instead of fh_lock().  This means that the calls to
> fh_fill_pre/post_attr() are also explicit which improves readability and
> allows us to place them only where they are needed.  Only the xattr
> calls need pre/post information.
>=20
> When locking a file we don't need I_MUTEX_PARENT as the file is not a
> parent of anything, so we can use inode_lock() directly rather than the
> inode_lock_nested() call that fh_lock() uses.
>=20
> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
> fs/nfsd/nfs2acl.c   |    6 +++---
> fs/nfsd/nfs3acl.c   |    4 ++--
> fs/nfsd/nfs4acl.c   |    7 +++----
> fs/nfsd/nfs4state.c |    8 ++++----
> fs/nfsd/vfs.c       |   25 ++++++++++++-------------
> 5 files changed, 24 insertions(+), 26 deletions(-)
>=20
> diff --git a/fs/nfsd/nfs2acl.c b/fs/nfsd/nfs2acl.c
> index b5760801d377..9edd3c1a30fb 100644
> --- a/fs/nfsd/nfs2acl.c
> +++ b/fs/nfsd/nfs2acl.c
> @@ -111,7 +111,7 @@ static __be32 nfsacld_proc_setacl(struct svc_rqst *rq=
stp)
> 	if (error)
> 		goto out_errno;
>=20
> -	fh_lock(fh);
> +	inode_lock(inode);
>=20
> 	error =3D set_posix_acl(&init_user_ns, inode, ACL_TYPE_ACCESS,
> 			      argp->acl_access);
> @@ -122,7 +122,7 @@ static __be32 nfsacld_proc_setacl(struct svc_rqst *rq=
stp)
> 	if (error)
> 		goto out_drop_lock;
>=20
> -	fh_unlock(fh);
> +	inode_unlock(inode);
>=20
> 	fh_drop_write(fh);
>=20
> @@ -136,7 +136,7 @@ static __be32 nfsacld_proc_setacl(struct svc_rqst *rq=
stp)
> 	return rpc_success;
>=20
> out_drop_lock:
> -	fh_unlock(fh);
> +	inode_unlock(inode);
> 	fh_drop_write(fh);
> out_errno:
> 	resp->status =3D nfserrno(error);
> diff --git a/fs/nfsd/nfs3acl.c b/fs/nfsd/nfs3acl.c
> index 35b2ebda14da..9446c6743664 100644
> --- a/fs/nfsd/nfs3acl.c
> +++ b/fs/nfsd/nfs3acl.c
> @@ -101,7 +101,7 @@ static __be32 nfsd3_proc_setacl(struct svc_rqst *rqst=
p)
> 	if (error)
> 		goto out_errno;
>=20
> -	fh_lock(fh);
> +	inode_lock(inode);
>=20
> 	error =3D set_posix_acl(&init_user_ns, inode, ACL_TYPE_ACCESS,
> 			      argp->acl_access);
> @@ -111,7 +111,7 @@ static __be32 nfsd3_proc_setacl(struct svc_rqst *rqst=
p)
> 			      argp->acl_default);
>=20
> out_drop_lock:
> -	fh_unlock(fh);
> +	inode_unlock(inode);
> 	fh_drop_write(fh);
> out_errno:
> 	resp->status =3D nfserrno(error);
> diff --git a/fs/nfsd/nfs4acl.c b/fs/nfsd/nfs4acl.c
> index 5c9b7e01e8ca..a33cacf62ea0 100644
> --- a/fs/nfsd/nfs4acl.c
> +++ b/fs/nfsd/nfs4acl.c
> @@ -781,19 +781,18 @@ nfsd4_set_nfs4_acl(struct svc_rqst *rqstp, struct s=
vc_fh *fhp,
> 	if (host_error < 0)
> 		goto out_nfserr;
>=20
> -	fh_lock(fhp);
> +	inode_lock(inode);
>=20
> 	host_error =3D set_posix_acl(&init_user_ns, inode, ACL_TYPE_ACCESS, pacl=
);
> 	if (host_error < 0)
> 		goto out_drop_lock;
>=20
> -	if (S_ISDIR(inode->i_mode)) {
> +	if (S_ISDIR(inode->i_mode))
> 		host_error =3D set_posix_acl(&init_user_ns, inode,
> 					   ACL_TYPE_DEFAULT, dpacl);
> -	}
>=20
> out_drop_lock:
> -	fh_unlock(fhp);
> +	inode_unlock(inode);
>=20
> 	posix_acl_release(pacl);
> 	posix_acl_release(dpacl);
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index 9d1a3e131c49..307317ba9aff 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -7322,21 +7322,21 @@ nfsd4_lock(struct svc_rqst *rqstp, struct nfsd4_c=
ompound_state *cstate,
> static __be32 nfsd_test_lock(struct svc_rqst *rqstp, struct svc_fh *fhp, =
struct file_lock *lock)
> {
> 	struct nfsd_file *nf;
> +	struct inode *inode =3D fhp->fh_dentry->d_inode;

I don't think this is correct.

nfsd_file_acquire() calls fh_verify(), which can updated fhp->fh_dentry.
Anyway, is it guaranteed that fh_dentry is not NULL here?

It would be more defensive to set @inode /after/ the call to
nfsd_file_acquire().


> 	__be32 err;
>=20
> 	err =3D nfsd_file_acquire(rqstp, fhp, NFSD_MAY_READ, &nf);
> 	if (err)
> 		return err;
> -	fh_lock(fhp); /* to block new leases till after test_lock: */
> -	err =3D nfserrno(nfsd_open_break_lease(fhp->fh_dentry->d_inode,
> -							NFSD_MAY_READ));
> +	inode_lock(inode); /* to block new leases till after test_lock: */
> +	err =3D nfserrno(nfsd_open_break_lease(inode, NFSD_MAY_READ));
> 	if (err)
> 		goto out;
> 	lock->fl_file =3D nf->nf_file;
> 	err =3D nfserrno(vfs_test_lock(nf->nf_file, lock));
> 	lock->fl_file =3D NULL;
> out:
> -	fh_unlock(fhp);
> +	inode_unlock(inode);
> 	nfsd_file_put(nf);
> 	return err;
> }
> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index 2ca748aa83bb..2526615285ca 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -444,7 +444,7 @@ nfsd_setattr(struct svc_rqst *rqstp, struct svc_fh *f=
hp, struct iattr *iap,
> 			return err;
> 	}
>=20
> -	fh_lock(fhp);
> +	inode_lock(inode);
> 	if (size_change) {
> 		/*
> 		 * RFC5661, Section 18.30.4:
> @@ -480,7 +480,7 @@ nfsd_setattr(struct svc_rqst *rqstp, struct svc_fh *f=
hp, struct iattr *iap,
> 	host_err =3D notify_change(&init_user_ns, dentry, iap, NULL);
>=20
> out_unlock:
> -	fh_unlock(fhp);
> +	inode_unlock(inode);
> 	if (size_change)
> 		put_write_access(inode);
> out:
> @@ -2196,12 +2196,8 @@ nfsd_listxattr(struct svc_rqst *rqstp, struct svc_=
fh *fhp, char **bufp,
> }
>=20
> /*
> - * Removexattr and setxattr need to call fh_lock to both lock the inode
> - * and set the change attribute. Since the top-level vfs_removexattr
> - * and vfs_setxattr calls already do their own inode_lock calls, call
> - * the _locked variant. Pass in a NULL pointer for delegated_inode,
> - * and let the client deal with NFS4ERR_DELAY (same as with e.g.
> - * setattr and remove).
> + * Pass in a NULL pointer for delegated_inode, and let the client deal
> + * with NFS4ERR_DELAY (same as with e.g.  setattr and remove).
>  */
> __be32
> nfsd_removexattr(struct svc_rqst *rqstp, struct svc_fh *fhp, char *name)
> @@ -2217,12 +2213,14 @@ nfsd_removexattr(struct svc_rqst *rqstp, struct s=
vc_fh *fhp, char *name)
> 	if (ret)
> 		return nfserrno(ret);
>=20
> -	fh_lock(fhp);
> +	inode_lock(fhp->fh_dentry->d_inode);
> +	fh_fill_pre_attrs(fhp);
>=20
> 	ret =3D __vfs_removexattr_locked(&init_user_ns, fhp->fh_dentry,
> 				       name, NULL);
>=20
> -	fh_unlock(fhp);
> +	fh_fill_post_attrs(fhp);
> +	inode_unlock(fhp->fh_dentry->d_inode);
> 	fh_drop_write(fhp);
>=20
> 	return nfsd_xattr_errno(ret);
> @@ -2242,12 +2240,13 @@ nfsd_setxattr(struct svc_rqst *rqstp, struct svc_=
fh *fhp, char *name,
> 	ret =3D fh_want_write(fhp);
> 	if (ret)
> 		return nfserrno(ret);
> -	fh_lock(fhp);
> +	inode_lock(fhp->fh_dentry->d_inode);
> +	fh_fill_pre_attrs(fhp);
>=20
> 	ret =3D __vfs_setxattr_locked(&init_user_ns, fhp->fh_dentry, name, buf,
> 				    len, flags, NULL);
> -
> -	fh_unlock(fhp);
> +	fh_fill_post_attrs(fhp);
> +	inode_unlock(fhp->fh_dentry->d_inode);
> 	fh_drop_write(fhp);
>=20
> 	return nfsd_xattr_errno(ret);
>=20
>=20

--
Chuck Lever



