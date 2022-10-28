Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70298611463
	for <lists+linux-nfs@lfdr.de>; Fri, 28 Oct 2022 16:23:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbiJ1OXs (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 28 Oct 2022 10:23:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229955AbiJ1OXr (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 28 Oct 2022 10:23:47 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B2BD7F095
        for <linux-nfs@vger.kernel.org>; Fri, 28 Oct 2022 07:23:41 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29SBNn0f018947;
        Fri, 28 Oct 2022 14:23:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=IjiGkXNtkCPvz7ySQPPRVFcrpexBlVkWT0iks6alzYA=;
 b=AG//1s5F3BEQ/nij3Vs4ShxCx8PrSKorHxky5Jwh1K1XDYUJbSxxtbBBrnWpYd6kxcxZ
 Yb0AavOKBoRjWG80wx2bhUkuwXnWke1EAW73SuW7GOw1RsW2tqUrvoPJPynUI83MTm1G
 7KsTD+Gk60/vE4cW3Ta9Av/BbDCczu6aTLZacZijHKNYORf9NPO/yTjvMYW7zlAhiuIm
 4k6W3+7X3CVs+tyX4h70NiKmF847+r4bQ0FiqgwU2/s0+5i9i/gdI6zmARsOScfnT3Kv
 VDASpPqO5J5VgCgs8foUp6G6fwgPHuUuaWCX6ctm5HY6tqZkR9n+8jF2vXRxWrJCoWPO xQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kfax7vx3e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Oct 2022 14:23:36 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29SDWcwx012342;
        Fri, 28 Oct 2022 14:23:35 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kfags4un1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Oct 2022 14:23:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mCRdz0pxWV3IPvCgTXilg+yPUidfWS+meUk5/R1hziBjiCTixbwvEmzd2ltGULDCnWarpR95PDlO766U9WalqT989O1nufUu2zzMHVknGy/UA89smGCHZL8VSbxopMsxN3iyEF6E7TqObF//3fkdWNnCYq4cKLOOLzAbjBQaV8Czgr8LhjiKkh1euHOJPAMCa8QCCIhVo6rMNkROeD8SNoj4rYiQZ4hzUTstLHewj8je2zL/hopYgmHmsBuTeAiwgBke6KCOg2pAXf9xCpt6SHNAWXTprvrUebnIKOKC2B1UhxiJDewERvWxwprPD0hEtzGR2SQkUfHcRau26bxlYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IjiGkXNtkCPvz7ySQPPRVFcrpexBlVkWT0iks6alzYA=;
 b=btF/Jp1Jcq7wBBqQFHbVt78e5PDoAHUEmhY5pQqyIXXNa7/kKnruUD5uSRlnxDxGN562U6xl7fp1pnNnekWI1sJVIzDlruF0MOOYr4a5BRJ5BTYk8S6NzaKAH12LesloUboQWp7sDl2WppEiom28sIM44G1WjveM472l5f6yQEboOzdIfgusErQRDbKefHuVQaSJ63HcEwqpWMS6TwVp0M6IcnkK5Abvmeq+D8v1BaXOCvJU3y/n90qv+LP6/NWkEjN6wmbjTMTudgKwwBqGpFfM2nN8UWgMjfSazshfgWBQ6JDBvWoPG5DZz9ad3ca4yGz63AEJ0KqCiOPlEXlAWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IjiGkXNtkCPvz7ySQPPRVFcrpexBlVkWT0iks6alzYA=;
 b=DRl7hEiK6qbYNP4keDY6pR6t7am8mlfxhs342Z5TGqwaPPA9Pqdde2bikWTTHWSFvyc8TGbYGMsonjBeugnVD44SG1ew/VpwWaue6y43/zlGN93lZV3F/P0wQwS54NDsHjIZtKfKFsaK2RzgDaV1FOg33vphXtwPme/Zl3o8Fao=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DM4PR10MB6014.namprd10.prod.outlook.com (2603:10b6:8:ad::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28; Fri, 28 Oct
 2022 14:23:33 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5403:3164:f6c3:d48a]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5403:3164:f6c3:d48a%3]) with mapi id 15.20.5746.021; Fri, 28 Oct 2022
 14:23:33 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Zhi Li <yieli@redhat.com>
Subject: Re: [PATCH] nfsd: don't call nfsd_file_put from client states seqfile
 display
Thread-Topic: [PATCH] nfsd: don't call nfsd_file_put from client states
 seqfile display
Thread-Index: AQHY6sbEwHcYgr6RekGiqci+Z7OuE64j3CkA
Date:   Fri, 28 Oct 2022 14:23:33 +0000
Message-ID: <102A618E-29C3-497E-8D7D-771C9C160DE8@oracle.com>
References: <20221028121353.33567-1-jlayton@kernel.org>
In-Reply-To: <20221028121353.33567-1-jlayton@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|DM4PR10MB6014:EE_
x-ms-office365-filtering-correlation-id: 2da7a74d-6a20-4c9d-847f-08dab8effea5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: keYRa8Z65P28JpF1iXSIdV2+nZj5CUA78qkmSFc9s0I6PhccynXbbqo/rbB47jHB40IdfITWDCMcfQSClJbJe+yjmD3WAfH5WOGuRBNzmFgm6/EGztmPldb46HoGBUL0V9UhjuZQK1FcUtf9nWVU/CPLh3HsC+u8mgJHOwGOqXvLGcq3e4iha4C2CjRpfKUFTqBEvokd97VVDm7MveklEmHqiQ4yevgkdK40uqIz+/dc3HUGml3u0dUhpKCQRvVwm3hQny8ORUkQmolbN4aTIPHKQpnbE0xETcgBSsAmY7H7WNT4qGHYfKil4xJ6BXDinQ+mdnWtZC0DygcjNxozZNdA1X2WDyOVPzqfnwtIP1Cz9+OAYhSUk+3dDwQnfjlwNjQEH43t0ASdaPE/sfUUT4KfLWAXnZSVoLlJiRaXDu1zRAMqpwgdUlO2OWOpiKnnhVkHswQ8hgqpKQO+T1OMSzr7F3x15ZZqBXzpOAwtQLG5D0pQ3u+eBWrbAgWn1+DB6PvhrQiniGd/iGDgSHgW5144WJAbIh51zOSBNcS9Cf7SQQ5kKXu9OswPAxurXRgVauj/KksxCN1I5FMPIm5/O5W5W0YhHkzNw1HdmRpJj6F9zC6pxbKI5KrkthvyNWXKaf5qsLqzel+MZ/ssTB3wYc59LOKqJRxA84ZfFCPUK1EEalB0lh3jj9vx1ZGqdvPMh+opS423D9OJTF+PvHLTmTeIgm1wZCk3CKeZMVldnMymq4QOlg8tbJ6Bpg3ZcS8se/tlvDX5gkgRG9WGTdGm2ippywp/o7OLXqBjtx2amL3yc7pGKQZULy/d8o+CZQ9T4OMziwfmm/i+WSMbrRCTog==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(396003)(346002)(39860400002)(136003)(366004)(451199015)(6486002)(966005)(71200400001)(91956017)(38070700005)(122000001)(478600001)(2906002)(6916009)(2616005)(186003)(33656002)(76116006)(8676002)(66476007)(4326008)(64756008)(66946007)(66446008)(38100700002)(66556008)(316002)(54906003)(36756003)(8936002)(26005)(6506007)(41300700001)(5660300002)(53546011)(6512007)(86362001)(83380400001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Ojqa1ey2DjWazqYJHnj4007nRfY+s2jmx0/HO3LE0eAw04qIFnaAw6OL1LxM?=
 =?us-ascii?Q?sBAfD+uYBUYU6RqGjt1AVuNv4dehBx5igjstgtVk+/jEVQOd9wIzBX8jQc5o?=
 =?us-ascii?Q?lpZixsrbMDZxB4vcKc+SGVNOXP3aHJfSD7gIX86A9nkesUXnGVE+4jCTd0Kh?=
 =?us-ascii?Q?tTWtHZfva9g60WNW03JwvjCARwS3aQ0QG1QKgZiIVH1CSyZHg2h3QvuDD8JU?=
 =?us-ascii?Q?ftOThzrhqm4xWpwVL3XEAA5yPQkyNnOtPg+6a5mAUJlXKHAUaau3/C/N9Us4?=
 =?us-ascii?Q?FeXa1NRnRrOdeoiLWIcgyLmEgiFU3IRRLMGmIV297WkSUUSgwEUWuN30B7+w?=
 =?us-ascii?Q?Ld+TL4lJO3ohnw1OlwvZtR0bUyLEprCjJ3hG/weMYOezzlXECFiqBan3MwJu?=
 =?us-ascii?Q?GBBEA1IORFwDc8QRLQTwZJEtkJlYVWxgCoKohICafrcTfc4ASDVPDMdXsml+?=
 =?us-ascii?Q?w4uSJwr09leuhTmVF3EjYr2FjHkAUc4E1UDeJGTo4oJGgShIyBFGNqm7jumI?=
 =?us-ascii?Q?j/Ep4ofKMihYhi4fQDlwVwV1YJXljt7RjVWhd++DkOu1SJJwI8goOPSFPrF8?=
 =?us-ascii?Q?mgJwnTnKyhrjGOwPjml1QPvQil3gw+4xRzRTvBPlG7Y4J6Ax+0BaQxMpQnab?=
 =?us-ascii?Q?NnRiJLuAV13yqwfbHsNXXLM/ZY1DkBj+K7NebRUBh/PbWJc58xMVGf6Pijld?=
 =?us-ascii?Q?YfUUV2FlX5X4H+sYQZyyVcZwJw8rshOtLMADz/9mT2W1wPDrGdsNFEtCMw4q?=
 =?us-ascii?Q?M5wgQhNhohwsjdGgZFyhp53HpZnC6hyomqE52DIZuPBKGjul0qNaLYDP3orI?=
 =?us-ascii?Q?jgCE3Z/EsFHZ93vLTyGJUwV4D7cLkNfJIDFQEz8KBNRdq0zAA982TAFjokol?=
 =?us-ascii?Q?piakgPNx/OWFyDKqaeKLlwb+1yIza3RWFmGWyzQxqzYmk+xOJECyhc8+iZ8X?=
 =?us-ascii?Q?58D80bhuwh5/lYEvdCSxOuRaLVmfoziwrL7PgETcqPcbqR8bgjU2NbX6GpAK?=
 =?us-ascii?Q?+lIQ3SbgK1j18uEJbwOxnlvI/a4w3tISsGir4gUf/gNxyOBZXxAiSDW7ciMp?=
 =?us-ascii?Q?813i4at9ElYomCoubfivKAernoPuug4DnoXCAWoBBwUkqi7FVedNqaH9fKsG?=
 =?us-ascii?Q?zRoy/PbBcu+p+QiM/lpVTJq1VNAegTMq00NvMtThYtYFs1Wwt3Rx7toKfnOR?=
 =?us-ascii?Q?HNhJ1r4TgrhZcYiVl0rTk4Zz/bgwoPXVW9860YK5a/VI5dAJ555PYsmxHfnj?=
 =?us-ascii?Q?4fjXjlom9Tu/CIJoelKt2yNhjLIUiPReK6Aqo5q6YZ612+BRURBTvBsZaOdr?=
 =?us-ascii?Q?416dr8efcn5FLIHlVJez6yAWJU4a3X+SVI5x+nr7298jB5jIhgHGXdbRmmIf?=
 =?us-ascii?Q?KtyFHfBCHlc6AZhoNwPgUNRff4eZh32Qu3NZveInPfK8gG2SefOTVyXdH+fy?=
 =?us-ascii?Q?GIOiR3bDlronZEXMb2K30YA05eHD7i66oEAIrSJ6ZKdk7KIlafMa5UdwFQ/6?=
 =?us-ascii?Q?yP9EVFQEy11Tj82zzscLkLaAQtBlb4kKjXfus2g94tzIllidHqvgt/EYhgSr?=
 =?us-ascii?Q?fjwOl5E3+0kZ1vqLJX78aKfmXc0wr2SKrPx8UW3JOx8FtYFKCNmmebDQbvck?=
 =?us-ascii?Q?Bw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <96B0BF80FC643A448CC7B42E568ABD05@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2da7a74d-6a20-4c9d-847f-08dab8effea5
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2022 14:23:33.5145
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WjvJYWijOSopSRxMnv5F+V2nF5lZ7UgJqasx23wjTuYX0JBC9onk10OilYArRP08LTCeB6c8DB6gGhwSE9ZvSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6014
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-28_07,2022-10-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 adultscore=0 malwarescore=0 mlxscore=0 suspectscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2210280089
X-Proofpoint-GUID: zYTqZM4pSi8QfHKdi-3jqhIZEArvXfKy
X-Proofpoint-ORIG-GUID: zYTqZM4pSi8QfHKdi-3jqhIZEArvXfKy
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Oct 28, 2022, at 8:13 AM, Jeff Layton <jlayton@kernel.org> wrote:
>=20
> We had a report of this:
>=20
>    BUG: sleeping function called from invalid context at fs/nfsd/filecach=
e.c:440
>=20
> ...with a stack trace showing nfsd_file_put being called from
> nfs4_show_open. This code has always tried to call fput while holding a
> spinlock, but we recently changed this to use the filecache, and that
> started triggering the might_sleep() in nfsd_file_put.
>=20
> states_start takes and holds the cl_lock while iterating over the
> client's states, and we can't sleep with that held.
>=20
> Have the various nfs4_show_* functions instead hold the fi_lock instead
> of taking a nfsd_file reference.
>=20
> Fixes: 78599c42ae3c ("nfsd4: add file to display list of client's opens")
> Link: https://bugzilla.redhat.com/show_bug.cgi?id=3D2138357
> Reported-by: Zhi Li <yieli@redhat.com>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
> fs/nfsd/nfs4state.c | 51 +++++++++++++++++++++++++++++----------------
> 1 file changed, 33 insertions(+), 18 deletions(-)

Applied to nfsd's for-next (internally for now; will push later).


> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index 1ded89235111..dde621debeb2 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -675,15 +675,26 @@ find_any_file(struct nfs4_file *f)
> 	return ret;
> }
>=20
> -static struct nfsd_file *find_deleg_file(struct nfs4_file *f)
> +static struct nfsd_file *find_any_file_locked(struct nfs4_file *f)
> {
> -	struct nfsd_file *ret =3D NULL;
> +	lockdep_assert_held(&f->fi_lock);
> +
> +	if (f->fi_fds[O_RDWR])
> +		return f->fi_fds[O_RDWR];
> +	if (f->fi_fds[O_WRONLY])
> +		return f->fi_fds[O_WRONLY];
> +	if (f->fi_fds[O_RDONLY])
> +		return f->fi_fds[O_RDONLY];
> +	return NULL;
> +}
> +
> +static struct nfsd_file *find_deleg_file_locked(struct nfs4_file *f)
> +{
> +	lockdep_assert_held(&f->fi_lock);
>=20
> -	spin_lock(&f->fi_lock);
> 	if (f->fi_deleg_file)
> -		ret =3D nfsd_file_get(f->fi_deleg_file);
> -	spin_unlock(&f->fi_lock);
> -	return ret;
> +		return f->fi_deleg_file;
> +	return NULL;
> }
>=20
> static atomic_long_t num_delegations;
> @@ -2616,9 +2627,11 @@ static int nfs4_show_open(struct seq_file *s, stru=
ct nfs4_stid *st)
> 	ols =3D openlockstateid(st);
> 	oo =3D ols->st_stateowner;
> 	nf =3D st->sc_file;
> -	file =3D find_any_file(nf);
> +
> +	spin_lock(&nf->fi_lock);
> +	file =3D find_any_file_locked(nf);
> 	if (!file)
> -		return 0;
> +		goto out;
>=20
> 	seq_printf(s, "- ");
> 	nfs4_show_stateid(s, &st->sc_stateid);
> @@ -2640,8 +2653,8 @@ static int nfs4_show_open(struct seq_file *s, struc=
t nfs4_stid *st)
> 	seq_printf(s, ", ");
> 	nfs4_show_owner(s, oo);
> 	seq_printf(s, " }\n");
> -	nfsd_file_put(file);
> -
> +out:
> +	spin_unlock(&nf->fi_lock);
> 	return 0;
> }
>=20
> @@ -2655,9 +2668,10 @@ static int nfs4_show_lock(struct seq_file *s, stru=
ct nfs4_stid *st)
> 	ols =3D openlockstateid(st);
> 	oo =3D ols->st_stateowner;
> 	nf =3D st->sc_file;
> -	file =3D find_any_file(nf);
> +	spin_lock(&nf->fi_lock);
> +	file =3D find_any_file_locked(nf);
> 	if (!file)
> -		return 0;
> +		goto out;
>=20
> 	seq_printf(s, "- ");
> 	nfs4_show_stateid(s, &st->sc_stateid);
> @@ -2677,8 +2691,8 @@ static int nfs4_show_lock(struct seq_file *s, struc=
t nfs4_stid *st)
> 	seq_printf(s, ", ");
> 	nfs4_show_owner(s, oo);
> 	seq_printf(s, " }\n");
> -	nfsd_file_put(file);
> -
> +out:
> +	spin_unlock(&nf->fi_lock);
> 	return 0;
> }
>=20
> @@ -2690,9 +2704,10 @@ static int nfs4_show_deleg(struct seq_file *s, str=
uct nfs4_stid *st)
>=20
> 	ds =3D delegstateid(st);
> 	nf =3D st->sc_file;
> -	file =3D find_deleg_file(nf);
> +	spin_lock(&nf->fi_lock);
> +	file =3D find_deleg_file_locked(nf);
> 	if (!file)
> -		return 0;
> +		goto out;
>=20
> 	seq_printf(s, "- ");
> 	nfs4_show_stateid(s, &st->sc_stateid);
> @@ -2708,8 +2723,8 @@ static int nfs4_show_deleg(struct seq_file *s, stru=
ct nfs4_stid *st)
> 	seq_printf(s, ", ");
> 	nfs4_show_fname(s, file);
> 	seq_printf(s, " }\n");
> -	nfsd_file_put(file);
> -
> +out:
> +	spin_unlock(&nf->fi_lock);
> 	return 0;
> }
>=20
> --=20
> 2.37.3
>=20

--
Chuck Lever



