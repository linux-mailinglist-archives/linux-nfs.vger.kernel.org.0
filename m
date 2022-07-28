Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CE11584267
	for <lists+linux-nfs@lfdr.de>; Thu, 28 Jul 2022 16:57:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbiG1O54 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 28 Jul 2022 10:57:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231491AbiG1O5h (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 28 Jul 2022 10:57:37 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05BBE69F30
        for <linux-nfs@vger.kernel.org>; Thu, 28 Jul 2022 07:56:09 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26SD3KWi011006;
        Thu, 28 Jul 2022 14:56:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=8xN2FCMUczTCf1HOBdtoMYILXM7YQHQxQqiHVOzTG4E=;
 b=tq1TAmpFgG9aAGmChESzFjyUdZ35kZfKXdno/DPetpLd3O6+QjCtxgeW+rOTMjiArZOO
 aD/7LqQ9Fnu83sYjqBh39rjf8aLSZZHwts7eRKZH4CC9gBtVD5X0cVPVGSKecjzqqLqu
 gmOJesOJkTR+jsrpd2eWc69tzkZW74wKHibxm04lwidGdJaRTsK6kpaHDsgLQ8f/a9NC
 UpeXFMwCUk/ao459AoG2YP9ycriz5G3YM4zV3AGmirS+sX+3w4YggCscjuU6W1L1BNk8
 ciHjAoTpNHvGEd9GRL5Q9xU+NLB0yWNZ5lOmNTm8CldljqTcL4ZuFs7KQFHU/0ztTvJp Mg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hg9ap4cf0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Jul 2022 14:56:02 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26SCp9Un006240;
        Thu, 28 Jul 2022 14:56:02 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hh65ebs19-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Jul 2022 14:56:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N3MtPJIUU0CQnF8sI87P1xdHkZOEiJYE7kUaZG5006gezl5TfIvtyf5x3LEUhipgOOXjG2NwRsqMYHcOfqWRsDzEjjcjlyKg0sTIO8ToThCLTtNx2OQ1Sw+OrHAbip4ZZVeDOoB6Kbl1On8PapVdIKrQlOfTCDVATTNAs7PfgvtiVijLmM5FyV6ALVibElem6oZODTpDtqZK83zqTLcDj+nFrCB8aIJ5pbx/gYeYe5K6AMKuXnrmkBKchOxzRBTAJQMTA1rE/3yqXkX4lAZdkzx4JfQ6It/20kPx0jQhWg8srNdb4UsBVndKxasOsrT/G++5cw3gT6SiYj9qxfKcBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8xN2FCMUczTCf1HOBdtoMYILXM7YQHQxQqiHVOzTG4E=;
 b=NBk3soA2iHY6pLJWRjSDn/rlVOuO7/PA6CltaxHRHsXfYjKRzDi+mIAdAReHkY/9ksvMGYhoeIBgPpmlVVr6EZQfL1G9AzD4oga48d5YC1KEtn0n1nYHqNR8NYj/xcrJwj5iFusqNJyz9FwLeRn0c0+FZ3wP2w4fDHcxYU+wfZquJwwMqgSxknwYdwNy7KoRt6ojetxeUItfGaxckvvYFmOFwkkHkwvuwj8P9Q4H9F9huc3OZ2rRVMcRinTlydCufW+nyLmNncm7hAQbB9/erCF3UMrvQx4IHa0QGV5eCwE6mlh8zShZGKKA543yIT0wbMuiE21B1Db1Bz+Ye02x6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8xN2FCMUczTCf1HOBdtoMYILXM7YQHQxQqiHVOzTG4E=;
 b=FGkWZlpWnk9RtbycnjCkxxNaBhQY16CSVnaN+l+JVLKhs9EXsOZo8MdJpTGC9swSQae3OSv8k6qChMAm08h9RZXi8NS5jCRss2rHu7JzCIJt8nDkKBjV+1Ddol8AXSfXep+JNLN2ypMFBhOMvkYk9dYI6vJwCek0AGko9mIeeSs=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BYAPR10MB2885.namprd10.prod.outlook.com (2603:10b6:a03:82::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.21; Thu, 28 Jul
 2022 14:55:59 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::8cc6:21c7:b3e7:5da6]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::8cc6:21c7:b3e7:5da6%9]) with mapi id 15.20.5482.011; Thu, 28 Jul 2022
 14:55:59 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Neil Brown <neilb@suse.de>
CC:     Jeff Layton <jlayton@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 12/13] NFSD: use (un)lock_inode instead of fh_(un)lock for
 file operations
Thread-Topic: [PATCH 12/13] NFSD: use (un)lock_inode instead of fh_(un)lock
 for file operations
Thread-Index: AQHYohNcse/mTU3rlU6XxzVp4ktM8a2T4CMA
Date:   Thu, 28 Jul 2022 14:55:59 +0000
Message-ID: <6FA491BD-135C-4AFB-9344-7D883F284310@oracle.com>
References: <165881740958.21666.5904057696047278505.stgit@noble.brown>
 <165881793060.21666.12014436943063405491.stgit@noble.brown>
In-Reply-To: <165881793060.21666.12014436943063405491.stgit@noble.brown>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 631f2521-1c36-4ef0-7339-08da70a9486a
x-ms-traffictypediagnostic: BYAPR10MB2885:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bSntDcODvzsJt11Rd1pwkFMnGezQIDeHTmDykXUvY8jqoO48aq5OTanwGQvVw0u+TTrUY975Ulc0oRaLGFgeI/MJhhezy/M5uO6GVpDmUoaUCrdi89HqXVXIruvAa6+k2bNZB5zJpfcjrt5JYAsPsm/i4l2M96BwWwtRtaZGWng85JpjcsUMvIABnt4WenSuyhOkL7PyMxpit8ATBlZesza9O5pvSQ+9/R1AUnc1ncikI/xqWIYDCMiY4axxpRYtqnW/VyPfp6Jthp/fr1cnY49xqpn07G8t/fJArFLG8WbaT8DSXaEOBF3dld2fA/8cTk1ECRp7nKDhAhvWG7LwUzNMCFZcGWsJcK7NVRU2npCWFBDQhOBJMFaazFEZhwki0iR7FQOMSwDsqG9iQWhtUV1X42Cks74F+vi/ZPzMm7TMP5ApMxzXjU/FEM4HXZIfkZ73OeQ4SU5bUKORqgIwzrHMjBYV7QCx2QnH++d4xkte+Vtz5gqAlz+B0A4Lf+x4uhIwUsjW2fXEk86+mPuW+nj/qJcWed3L/NutrTAq2rduCjMInw2xtbeQDE5YiWhzCloRMYVzllt6adThjJpqOJBwG1aOdaV5nEGP/lgd0SzJ/wSXNjep3PANuGBReNeftKicXYd5hLtKuhx1tx+6K4xLjPH4cV8zRqUw9vfn2sAYizD2VR2YIqltNpcyINtqbKJj7P+fQomwAmZ0vDovb2NyNAQGowBvczC9riRA0iuHR0ZHMJ8/RQCjPB3ntAKPtpQ1kZ8TvAQvZirVUZMdvM2lznKJCRlRN9XoJrz+aJOC9licTPqE10v1ii43ickiFHxvWzId8wpCFgxs2JqFOg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(366004)(39860400002)(346002)(376002)(396003)(66446008)(6506007)(2616005)(83380400001)(53546011)(5660300002)(6916009)(26005)(66556008)(33656002)(8936002)(6512007)(186003)(41300700001)(71200400001)(36756003)(86362001)(38100700002)(478600001)(54906003)(64756008)(122000001)(76116006)(66946007)(38070700005)(316002)(6486002)(91956017)(4326008)(66476007)(8676002)(2906002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?J6hJxPjYF/1a45M1k0HyOP2NntR0m6qoZ3zuBPNTwRZOTVvnVb4gjtG8R7pp?=
 =?us-ascii?Q?WdaAMtI3fGngrjUBkSG9HucKjKGyJJt7a088d7Pfw93vjesmTX72HQSs82a5?=
 =?us-ascii?Q?lWBJBIQry58O612lBKajg4HIwxQkUNPSoo6uB0gOeajq8EJXavvJ1Hf8LyET?=
 =?us-ascii?Q?YQXZz+ih+zaSdisdE8GWheRTwxESbVX89yyVa69xLyvAd7FaNpuUjLqlKmqZ?=
 =?us-ascii?Q?oqiEXnbkuizWWXUFPLsp0d2jxPOGIWBfzwLb7Ip1icwmqmhWpc45cA8p6b7u?=
 =?us-ascii?Q?C62HxKwWPpWA93c8GScky0gZfdSv8REeOX9ypcYAFjINKWeTo//a8J4id3hR?=
 =?us-ascii?Q?xE0a5fdItmkT3qVi/jJABMuXlz/p8BKKbSNB3c91tEy8bubZ9iDqqSh3ETAY?=
 =?us-ascii?Q?QaLi+9EdPl9/FNKYTbk/oQQV1BgiAdOI2mgOrfhxt5nLV4E9CZK472d8opBJ?=
 =?us-ascii?Q?egIf3q1Q/ovQwr6BowcKclAOhb1L75hpKi21GrdMvkHAuK/bXVvX47LmYCea?=
 =?us-ascii?Q?taK4OI+L6nhwn7nzjzbXFTdfcXA8sIxNlgS1b1TS+I4qdZciiIAgc+3jaghy?=
 =?us-ascii?Q?KGqTsWsmlO2QAkild5r1IdPu0FOLwR+897ycH0QPf9tXbvp1zBwmYKIpvW7F?=
 =?us-ascii?Q?hGoLAWz4wtR/Doveh2L3YlxUILQE4T9LngE1HBkTtTeJ3ONFoUU0yssIWotV?=
 =?us-ascii?Q?kRuckHRNQ1IkEwY/rKNe8utnDhFVL3xuyExwUXPueIHadCYOw7mhou9Nn7Md?=
 =?us-ascii?Q?w+WrqsJBAcFymi0U2soigLdMcSQmX4w/3K9uBGZe2YDb6sCnE6YAl0+TgBl5?=
 =?us-ascii?Q?83cy8eVxywTEhcg7mFSWIIa0St19wumpPoMUHIpazcsLWPG+aXDNl1vZjEZu?=
 =?us-ascii?Q?bmKD6cJgfTkSfzfuvakgCt91GMZ1PngAVs+cWvmwT14ytmptcFVrvWf7HpVU?=
 =?us-ascii?Q?7BlMpsFOvMjP7kWjlGxsyERu5mr7Vcy5j4HXcR4vXaplwME7cRbcAGj+KmBm?=
 =?us-ascii?Q?hRcZcjBuxwkWz5F6Pwmq+8RlkGO5vx1hjmtV5MvpTHuFiVo9jpzgUtGy1OxM?=
 =?us-ascii?Q?l1baZjXmdK3kzWjJdExhD3Djn/TLneJx/o2qzfByxTZDq6TI5pANmJH4o1YW?=
 =?us-ascii?Q?H0J3VFSDWGn7RWL4dZBaIpG8eDCOuuSG8OjDnkXwwjiGusenELtdX/tWO51m?=
 =?us-ascii?Q?nI3tyAvGao8nyXxEThtF/3RrebVZqvhcgMLYEk8a3FtaAU/wCYDxpy7IyF6k?=
 =?us-ascii?Q?4IPNhWpbqXv+CmC9J8K39tlwO5A+7GX645LB5Xhgz5XPsFfzVMx5FRYtAIDF?=
 =?us-ascii?Q?jhwU8Z8kuqOLLEtI2j80ZuPXnIK4CCp3vdSGDXWuI9U/SDKCCa44c5QxExrV?=
 =?us-ascii?Q?atGprguSNifJtP0ZtFDN47t+kx/EdoyMLGX1sQ9V/QIxG7pKF6wESffo4+oj?=
 =?us-ascii?Q?QC2tCR4pfmjbnUN/K3Wcvw7eIQRyBEXmfJYcImEY5Gov/lSMIvRhcZ1r63Av?=
 =?us-ascii?Q?3RVET2n/gUAonprj7swzbI3rUhdiU3V8guzOPZ01IFk4Aj4UfVSd+oOhinzE?=
 =?us-ascii?Q?JkkFJBCDNIqEPPTcB5pTcKv4EFix+weW+pxp5rrS4Ff5RlDXWfDxo7aGXy6o?=
 =?us-ascii?Q?9Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <0FD3C268E4E18F4A83B688D0FAA29D30@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 631f2521-1c36-4ef0-7339-08da70a9486a
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2022 14:55:59.2597
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XSaQhhCLi7uM/uv5XTAa371MnDJtkWDjYCtddldd6xakD/EeH4tG3pNOxt83oF0yyJIbYP6Cv6PmRt5WbFYt4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2885
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-28_06,2022-07-28_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 phishscore=0
 spamscore=0 mlxlogscore=999 suspectscore=0 bulkscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207280068
X-Proofpoint-ORIG-GUID: Lr4BcmDMVyG-kGdCsr556aBPrXj6lNr9
X-Proofpoint-GUID: Lr4BcmDMVyG-kGdCsr556aBPrXj6lNr9
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jul 26, 2022, at 2:45 AM, NeilBrown <neilb@suse.de> wrote:
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
> Reviewed-by: Jeff Layton <jlayton@kernel.org>
> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
> fs/nfsd/nfs2acl.c   |    6 +++---
> fs/nfsd/nfs3acl.c   |    4 ++--
> fs/nfsd/nfs4state.c |    9 +++++----
> fs/nfsd/vfs.c       |   25 ++++++++++++-------------
> 4 files changed, 22 insertions(+), 22 deletions(-)
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
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index 45df1e85ff32..b9be12b3cebd 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -7397,21 +7397,22 @@ nfsd4_lock(struct svc_rqst *rqstp, struct nfsd4_c=
ompound_state *cstate,
> static __be32 nfsd_test_lock(struct svc_rqst *rqstp, struct svc_fh *fhp, =
struct file_lock *lock)
> {
> 	struct nfsd_file *nf;
> +	struct inode *inode;
> 	__be32 err;
>=20
> 	err =3D nfsd_file_acquire(rqstp, fhp, NFSD_MAY_READ, &nf);
> 	if (err)
> 		return err;
> -	fh_lock(fhp); /* to block new leases till after test_lock: */
> -	err =3D nfserrno(nfsd_open_break_lease(fhp->fh_dentry->d_inode,
> -							NFSD_MAY_READ));
> +	inode =3D fhp->fh_dentry->d_inode;
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
> index f2cb9b047766..1d96d89a4801 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -416,7 +416,7 @@ nfsd_setattr(struct svc_rqst *rqstp, struct svc_fh *f=
hp,
> 			return err;
> 	}
>=20
> -	fh_lock(fhp);
> +	inode_lock(inode);
> 	if (size_change) {
> 		/*
> 		 * RFC5661, Section 18.30.4:
> @@ -463,7 +463,7 @@ nfsd_setattr(struct svc_rqst *rqstp, struct svc_fh *f=
hp,
> 		attr->acl_failed =3D set_posix_acl(&init_user_ns,
> 						 inode, ACL_TYPE_DEFAULT,
> 						 attr->dpacl);
> -	fh_unlock(fhp);
> +	inode_unlock(inode);
> 	if (size_change)
> 		put_write_access(inode);
> out:
> @@ -2145,12 +2145,8 @@ nfsd_listxattr(struct svc_rqst *rqstp, struct svc_=
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

A kerneldoc comment would be nicer.


> @@ -2166,12 +2162,14 @@ nfsd_removexattr(struct svc_rqst *rqstp, struct s=
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
> @@ -2191,12 +2189,13 @@ nfsd_setxattr(struct svc_rqst *rqstp, struct svc_=
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



