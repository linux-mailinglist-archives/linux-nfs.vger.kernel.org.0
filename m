Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D9F23F3B71
	for <lists+linux-nfs@lfdr.de>; Sat, 21 Aug 2021 18:30:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbhHUQb2 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 21 Aug 2021 12:31:28 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:48424 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229669AbhHUQb2 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 21 Aug 2021 12:31:28 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 17LG05lc020780;
        Sat, 21 Aug 2021 16:30:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=M5yJ+SrkX/2J6qzHDhuasOdNm+rx006IiWKwBj7m1GY=;
 b=zpuyZICq/nbu5YvfWlawlKuLuYDzii06X0/HLqUt3bWRULikS0nlVWS7z/wvXojxOVGM
 qROYb+bsS1oSKEf23tnvMXLVYXqD7NjpM6ztk9SmlTZt/wePyjGerhfNMKhREOgS0c7r
 Kc200GtSwaHL70ytJ+hzSGT5ZRd6CJC19e3vja/+0k3hLFmUGJNf3ql5u9mXzVJqp66U
 J1MPWD5am50CBWwhvsorfKolWPS3fMMbuw+iEwunI1nNBEWloFOP2sKkMe1Yakvu3qAy
 AOrrlOamIuPn10wrEJHbL7JWHNppgBnEIhlV3lsyaSYrrtJ9v1WeFPGUCSY94dGbU5hZ 0Q== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=M5yJ+SrkX/2J6qzHDhuasOdNm+rx006IiWKwBj7m1GY=;
 b=a+PvNsOJR1dGR0FVNOT2ZaBf+w3l+htZh/k7j5C8VNrPOLWpaePAbsQW71WDBCbayk08
 ZMLynn+JqRgYBLd/MEmjhozAKVbDJiBRhvpEAQBFh3oCnIdtCsbOdZBPi6oXlVlgR7Lg
 DbwpyhLaIUKKk8PgnHW7XWvChJWslNOwsDAxUvcjKjuo8JTJ156XI4blbPULiJLfKhNa
 FLeBqbQunXCWF91GkwWywCvfFBMbykYGXJK3fBQWvWGzjWDnnXPwS54mftINxFw06VfT
 EptebIjNiH2Bk6+lGVYKDseK+mqL6dqlxjJJSk7wtn93pEMsCDtyrBlylWtconPdLKye Rg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ajub60hgp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 21 Aug 2021 16:30:41 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17LGF3CC107104;
        Sat, 21 Aug 2021 16:30:40 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
        by aserp3020.oracle.com with ESMTP id 3ajsa0jdms-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 21 Aug 2021 16:30:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dl5jJFac3NP7Q3scXYAzKjlWjzG4YzefoCyS8u0NBDbk7wB5TeDEoSA3bloelpaL2JFpvjx34Sd3dQlO1isVe+2iNBwZv7Nacsrpwa+Z46QgNG/xPtrmCx6nK1G4blpMMznrDG8z/kWsr6mV9QgGTk9BOCXlcwJ50ACPl0sqGoQTIa2qsxws2sOT3QORkbi7lMRoCJGCGM6VsSX/5i/E23pytzyJw3bf7gqWS1YlX9Oe6fVnpkwfpHlsagAj/NpeX3TZk3bCsJ0pFJXCyA/7qIjYkIqgL/QfhJK2a9bnd4oImd7UvPQnncOP+41tlVCAe6LTtlhmDa8DcE2sgYjJyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M5yJ+SrkX/2J6qzHDhuasOdNm+rx006IiWKwBj7m1GY=;
 b=Ui1ilVbExWB5Pk/TJMLQyXg/4z8wbGFEcclNeDVgFf/X+Ui0qBnaBxInEXLqsaGrBDYveqbRfOw7bLaZlwF4Wd1zfhxsKna8/kLF6oT/VcN9VuDIzH5OnGRnK7hiXuEyTlPQSLZYoaKrhN9Q0J7/H8EOZaj7ZIICp65MOqWwjp4X+OVUcMCn3dqyY1f1f1lzEFCKMg4mmHnEqDhd8tXrhkGsHWEkQuXNEaDcmk5ceTcfLOhWTSEn0S2j/VM8R3tHUPvTfBAqI7FCZWnmPBu8gB92rqzbos6bnHn9pE7EFlWtQCxYdaNoW4hGdbbPrmB7BYP9Y5L3iy81ikihW2yppQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M5yJ+SrkX/2J6qzHDhuasOdNm+rx006IiWKwBj7m1GY=;
 b=P6x4Wnxt59P2KisawHYTeWFjyUuQH1y40wm/mAxbpXQSeI5izAeAmFTZQJNwExLfnWNjR96xl8XeY1tOuHBupbNwYiLZJVsQDn+Q/Ha/XJG7rQ7x2QcDd7TQUlFug4oss23wUiKy0GeeynCcoIli4cSiXagu2ORkMN8lRxOUdDQ=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by SJ0PR10MB4591.namprd10.prod.outlook.com (2603:10b6:a03:2af::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.21; Sat, 21 Aug
 2021 16:30:38 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::a8db:4fc8:ded5:e64]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::a8db:4fc8:ded5:e64%7]) with mapi id 15.20.4436.019; Sat, 21 Aug 2021
 16:30:38 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Bruce Fields <bfields@redhat.com>
CC:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <schumakeranna@gmail.com>,
        "daire@dneg.com" <daire@dneg.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 3/8] nlm: minor refactoring
Thread-Topic: [PATCH 3/8] nlm: minor refactoring
Thread-Index: AQHXlgas1jboMU24AUGzxBKiF0Vuyat+J7IA
Date:   Sat, 21 Aug 2021 16:30:38 +0000
Message-ID: <D3092E2E-2FE1-4518-BDDC-85CE6B070B81@oracle.com>
References: <1629493326-28336-1-git-send-email-bfields@redhat.com>
 <1629493326-28336-4-git-send-email-bfields@redhat.com>
In-Reply-To: <1629493326-28336-4-git-send-email-bfields@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 10b2f995-0ddc-4ca6-0e8b-08d964c102d8
x-ms-traffictypediagnostic: SJ0PR10MB4591:
x-microsoft-antispam-prvs: <SJ0PR10MB45919BA912940B5D5ACC439693C29@SJ0PR10MB4591.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:61;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ryGcG9txhDYdAL5CtN3q9hJfmkjF9C9CGk+tbN9ifBT5i1iOvKGvJqLjz+q8jFGaPSsaQqLekgKgrDpOO3Rkcb9L+Jozdz/5IIKCR0RaDSapV2VMkUY5pD1tQrl/C/mFVH5vxtu5jDOwRW89TSCqsWpXJDxibvjLjmDDJM6VjLJrfnK3D2Y1/HMCSoldSRjMbRiDTVpdEobsOX440HjsrBIIOxuFq9fl+8gG1pur6kH3C320pQe2BQkyL6k81LE8qXnLVwkjzSICziwyVwWggyosNY0JZeZ0zGSX8dG4QX996f1V/INkY7GHlb1O1qU737N4uaI67mFnX34H/HvKB1oRKV6yS5endBUf7zrnC63JzkzLaVll4lIZDGLIknofFK6AKaR+SfdGLdJpiUiEUSJYBqZmSVX05lVXgptI6s3+7NFxMYSHcgPqqTenH1AugdAzM+evVifg5eUxd+WDCmVYKv9FxVPi0U9n1N8Oe2HOSzwLC6EF9Hc+uUYgVAbJEtTAou9SV01XDePPyMfrj3x5IL7ew1bRuzhjPi6508CJxysruJYAFmwvSL2Ce/UUyhgyhK2nw454PQ53Gv1MME/YIKUoxucoS+LLDhN3+i2JolykTC2/AaTVq60jf4zvvKv1wpbsZntM9Mh4q8HId4rek9/SNVV2RWRH2vMEvTn2YPQ/MNQx3MyjbV0gVg6neF1T1Lghv1QScoq2S/6mnh3p+KUBxT7yt7brGkZlO2yGrLQymmsvCm8LB9uEEHpz
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66556008)(66446008)(66946007)(66476007)(6512007)(122000001)(316002)(64756008)(54906003)(6486002)(38100700002)(8676002)(4326008)(2616005)(33656002)(8936002)(71200400001)(53546011)(86362001)(186003)(76116006)(5660300002)(6506007)(6916009)(83380400001)(38070700005)(508600001)(91956017)(26005)(2906002)(36756003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?qJdWykktJNrzpQ2mZTMRYyDACVxBaFe0jEa+XDzaqu+Zg23IfFOvdJiVeSG7?=
 =?us-ascii?Q?MqgHGg0ccVmcJWKTfsxOc8qHpXZ4xTyHndkFXGs2Z+vweJGDxuPoCPeM4Dp5?=
 =?us-ascii?Q?54AjPJ/qNdzQBWN+ZvfLuJuAEAzOL+DC8PMJ7UBWuHOK6sZ5wPZuO3Gb43iM?=
 =?us-ascii?Q?JaejwmgfqgGDOgwYFNNoC1ybmaeOQwvqGe1Ynx829TZrW3sFqQ61rdwDjbiS?=
 =?us-ascii?Q?JMIdoOEVbIQFt7Jf5Lz5KS9czLdNmbG0zdbNx1Oo8c+9A6kMGq6KEW3oCWlr?=
 =?us-ascii?Q?k6DpnFS3HtCBwQUik7V7P3zL7rpR9FREey/fMIEp0UX6ppFTm/baatnCZGpE?=
 =?us-ascii?Q?Caok+STnBuOJdjbd7O5tlk/BKDNAYTw6W3dUhKyH2niIZ8DV30nc8Q1TNeY5?=
 =?us-ascii?Q?6a2UPtdHhfP/pswQB00QSMI85qafhFp5ieSnjRb2UNSjHXMLfHopqG8cuSuj?=
 =?us-ascii?Q?LromsQYHl/VxRyqPF7zq3FmoWjIUctv6kDDcPVqyuP2DfTk712Up6Vins/7/?=
 =?us-ascii?Q?L1CTRfijhCNT+3JYJVB2mnPFYgAFrV/3ED6NGFvjJzRkDylo2VMe3UcR9C1m?=
 =?us-ascii?Q?A/NuZXi6PvBhTwsNxqBXTdYpkUfhYiNWGsbFnZxA+m34n0v5rDcKQc2WOfH/?=
 =?us-ascii?Q?0zZgYvS5EKTwWNasOeyRnCZcNWz4vbQMrqXazgYtu219TaSBpJy9IUx/1wPk?=
 =?us-ascii?Q?fXnaNswMJzvyI8o1WnlyxK32H6VWymMibGS0GJpcZqbBELCMf94agjaH1P58?=
 =?us-ascii?Q?KlP9dQFDfOsGQp2PwQu8FjmLVnCJGJ0IOZUA/utRtCxlEwfgK3czXqTtVTsI?=
 =?us-ascii?Q?Hv5rjbCe+uJbsNWVEtzn7iD81+PaHyp+g1taC+nF+b2D/5b97kB/Q2NO8AGW?=
 =?us-ascii?Q?UO1fcNJTgcipIU+mtdVmjwGFGi9fMeK6R1LnPW+VerqBFJjeabj3v4RMBsyv?=
 =?us-ascii?Q?BVthTPWzDHl34JVJzzpF2ZrPNd5bjcWmEqgT0s+RyhMwYJhTBiy5AsX+RG82?=
 =?us-ascii?Q?6F337HSe39Uc4o+H6ELjTmS+HvJat8TbXPW2BtYxAUsELCAsi20hfH4Rg69k?=
 =?us-ascii?Q?3rplOwjxkUi/GFBTQ3qFY545W/FlKgDj3Q5A++3YFfPRgMIH5VSKwihMajck?=
 =?us-ascii?Q?1+3eGIdirlnw+WnwaMPoXyoT81GLFYEgLqTdPhngh1s56iJBksg2gkOCXImp?=
 =?us-ascii?Q?byrBPumLfpsqI7mfsKzVMMweL9EVPbgp/m8TCJG1KpKWk4xdraxSnKNSAM9g?=
 =?us-ascii?Q?psSX5jA/9Y4/0CFYaKivn0/8fltfog9WgpwBieOeu7QTTfl6jX74sZqDbuBG?=
 =?us-ascii?Q?wHDWXeRD2RYTqK/7tuAg3BkJ?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B831538ECC8AB642A1FA8C93FE97F00E@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10b2f995-0ddc-4ca6-0e8b-08d964c102d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2021 16:30:38.7949
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5FijWWUeVFSyFYgQrXcnevfccklRdXVU1foW8EcWVJ/YlF2p1p1/R7Zvaev1/AEVM07aA40rXpmqSHUCn3xDZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4591
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10083 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 mlxscore=0 adultscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108210101
X-Proofpoint-GUID: FihD-9Pen1Al0zcI1E6CYKp5_NXKEQ-g
X-Proofpoint-ORIG-GUID: FihD-9Pen1Al0zcI1E6CYKp5_NXKEQ-g
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Aug 20, 2021, at 5:02 PM, J. Bruce Fields <bfields@redhat.com> wrote:
>=20
> From: "J. Bruce Fields" <bfields@redhat.com>

Missing Signed-off-by?

And add just a little text that explains why this change is needed?


> ---
> fs/lockd/svclock.c | 16 ++++++++--------
> fs/lockd/svcsubs.c |  4 ++--
> 2 files changed, 10 insertions(+), 10 deletions(-)
>=20
> diff --git a/fs/lockd/svclock.c b/fs/lockd/svclock.c
> index 1781fc5e9091..bc1cf31f3cce 100644
> --- a/fs/lockd/svclock.c
> +++ b/fs/lockd/svclock.c
> @@ -474,8 +474,8 @@ nlmsvc_lock(struct svc_rqst *rqstp, struct nlm_file *=
file,
> 	__be32			ret;
>=20
> 	dprintk("lockd: nlmsvc_lock(%s/%ld, ty=3D%d, pi=3D%d, %Ld-%Ld, bl=3D%d)\=
n",
> -				locks_inode(file->f_file)->i_sb->s_id,
> -				locks_inode(file->f_file)->i_ino,
> +				nlmsvc_file_inode(file)->i_sb->s_id,
> +				nlmsvc_file_inode(file)->i_ino,
> 				lock->fl.fl_type, lock->fl.fl_pid,
> 				(long long)lock->fl.fl_start,
> 				(long long)lock->fl.fl_end,
> @@ -581,8 +581,8 @@ nlmsvc_testlock(struct svc_rqst *rqstp, struct nlm_fi=
le *file,
> 	struct nlm_lockowner	*test_owner;
>=20
> 	dprintk("lockd: nlmsvc_testlock(%s/%ld, ty=3D%d, %Ld-%Ld)\n",
> -				locks_inode(file->f_file)->i_sb->s_id,
> -				locks_inode(file->f_file)->i_ino,
> +				nlmsvc_file_inode(file)->i_sb->s_id,
> +				nlmsvc_file_inode(file)->i_ino,
> 				lock->fl.fl_type,
> 				(long long)lock->fl.fl_start,
> 				(long long)lock->fl.fl_end);
> @@ -644,8 +644,8 @@ nlmsvc_unlock(struct net *net, struct nlm_file *file,=
 struct nlm_lock *lock)
> 	int	error;
>=20
> 	dprintk("lockd: nlmsvc_unlock(%s/%ld, pi=3D%d, %Ld-%Ld)\n",
> -				locks_inode(file->f_file)->i_sb->s_id,
> -				locks_inode(file->f_file)->i_ino,
> +				nlmsvc_file_inode(file)->i_sb->s_id,
> +				nlmsvc_file_inode(file)->i_ino,
> 				lock->fl.fl_pid,
> 				(long long)lock->fl.fl_start,
> 				(long long)lock->fl.fl_end);
> @@ -673,8 +673,8 @@ nlmsvc_cancel_blocked(struct net *net, struct nlm_fil=
e *file, struct nlm_lock *l
> 	int status =3D 0;
>=20
> 	dprintk("lockd: nlmsvc_cancel(%s/%ld, pi=3D%d, %Ld-%Ld)\n",
> -				locks_inode(file->f_file)->i_sb->s_id,
> -				locks_inode(file->f_file)->i_ino,
> +				nlmsvc_file_inode(file)->i_sb->s_id,
> +				nlmsvc_file_inode(file)->i_ino,
> 				lock->fl.fl_pid,
> 				(long long)lock->fl.fl_start,
> 				(long long)lock->fl.fl_end);
> diff --git a/fs/lockd/svcsubs.c b/fs/lockd/svcsubs.c
> index bbd2bdde4bea..2558598610a9 100644
> --- a/fs/lockd/svcsubs.c
> +++ b/fs/lockd/svcsubs.c
> @@ -45,7 +45,7 @@ static inline void nlm_debug_print_fh(char *msg, struct=
 nfs_fh *f)
>=20
> static inline void nlm_debug_print_file(char *msg, struct nlm_file *file)
> {
> -	struct inode *inode =3D locks_inode(file->f_file);
> +	struct inode *inode =3D nlmsvc_file_inode(file);
>=20
> 	dprintk("lockd: %s %s/%ld\n",
> 		msg, inode->i_sb->s_id, inode->i_ino);
> @@ -415,7 +415,7 @@ nlmsvc_match_sb(void *datap, struct nlm_file *file)
> {
> 	struct super_block *sb =3D datap;
>=20
> -	return sb =3D=3D locks_inode(file->f_file)->i_sb;
> +	return sb =3D=3D nlmsvc_file_inode(file)->i_sb;
> }
>=20
> /**
> --=20
> 2.31.1
>=20

--
Chuck Lever



