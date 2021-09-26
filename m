Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CB19418AC0
	for <lists+linux-nfs@lfdr.de>; Sun, 26 Sep 2021 21:23:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229892AbhIZTZd (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 26 Sep 2021 15:25:33 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:41554 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229761AbhIZTZc (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 26 Sep 2021 15:25:32 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18QHIwkj015461;
        Sun, 26 Sep 2021 19:23:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=QkRnaWk+zedMPQcZ1J5YDOpi9zSmQ6ap9KOYO8qXSQo=;
 b=Yjs6iJSciKxu9Z3KjxoMGuiWZ74hsccBLgaNn/aQCAnLkMnZ09M0Uu5q8wY6XJFJG5Kv
 dBCwreF1TMvJ9MCv7pINhEJJj19lJHcDzIWLT81u7rriWeg4RlFvQ2VugfsQJHcqegS7
 7Z4203UotuC1BXbpKVFwLMUR2ENsoR0SSxfUajfN3DuFwLRxPgUD/JAUiOE/wnz0jUFp
 SXgPWpPB0KfouMN87A1eJdq4xhk3ufqw1C9CEYypU78HbzgyPxzn7VRvXlo4i1xTkq8k
 iYgD+wzNJGTBNreOidxOHdFalLtEsboiQnYDFOaFJs+ZBlQI4IsUbsSWeMT49UugEZqF Gw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bar0n8phf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 26 Sep 2021 19:23:55 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18QJF3wE137086;
        Sun, 26 Sep 2021 19:23:54 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2173.outbound.protection.outlook.com [104.47.55.173])
        by aserp3020.oracle.com with ESMTP id 3b9x4yjvp7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 26 Sep 2021 19:23:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I//TrjURThOiqb6VHx7Jp/9tT0wyfnRbE5z4W0/CcP1HvtoWG3iGUqP011udqbGf/JNveExeqnQPNWLLRK9/kYp7eGTVIlWt6tHeivEFOyGyKAsaPFsIK8yieIWa5teDwsu3vH2An3UT/3kfbc8Jo33kMomcxgYmf0O4w6i3Bs4hfMCABPz+xPJaPoiEMXsc10JDaD8vYh4p0J7Q8FjQc3qGL+VGU2lHDy1RpTWaGLK5cPTCgBYr1wa/qQjlapg+Nh6FfBCPniVo+19AoY74Gj+WaCMZyn8bDYUcyQTdzFUPHIJcgwCoYA4MxLs/CH+TrkzjwyX5FfYB5HKw9tx2zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=QkRnaWk+zedMPQcZ1J5YDOpi9zSmQ6ap9KOYO8qXSQo=;
 b=Auk5Bj1wyf/u2Fk/Wfvp7ZEU/VvA/irKGhFNjn/8PQUG/ugPY2QOK1P4wIouK5Dgkk/8ur8zVkCDbjPlBzEQQxEO/RFUcsNHD8mvieSVIPUePBTN31zvmw/CuumHzfa4+G1jLaFwa7T4sMVrQSYwzkzkyYQ87yPxokOh0SWma9nkyqEXWF4bo25IeCNWDzd4nHMSpnLgnFDTRIPMZ5qEUBJcqKMCpLT9qm8PkzIFdAERXXTfsTQArqmOKXoTjQSjJhg40BGYjQTUZAi89qbKNumtYtdJ3b2GeFugV5NGXQPpHvzzzx1diod8VWjkDMthjbmem0wRt1Ea7RfwX7LHXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QkRnaWk+zedMPQcZ1J5YDOpi9zSmQ6ap9KOYO8qXSQo=;
 b=Y7AAcWTk1+/nJmbmyMx6r7vTPxzNJjf++HkUm9okCpQMmR5JjXRPvQDRp6XpKjboDqs2CQ+ikUctCMPQ/FW0KPrNRhee2jBWvJyjaz9/eygnEs2RBu4ElkE77WPr9xTbDdChjKhYoRdqo56DujdZAPSkVfxoaiol9o5yH7NmOOY=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by SJ0PR10MB4687.namprd10.prod.outlook.com (2603:10b6:a03:2d8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13; Sun, 26 Sep
 2021 19:23:52 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::f4fe:5b4:6bd9:4c5b]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::f4fe:5b4:6bd9:4c5b%5]) with mapi id 15.20.4544.021; Sun, 26 Sep 2021
 19:23:51 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     "trondmy@kernel.org" <trondmy@kernel.org>
CC:     Anna Schumaker <Anna.Schumaker@netapp.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] NFS: Default change_attr_type to
 NFS4_CHANGE_TYPE_IS_UNDEFINED
Thread-Topic: [PATCH] NFS: Default change_attr_type to
 NFS4_CHANGE_TYPE_IS_UNDEFINED
Thread-Index: AQHXswKfCqS5MT6WMU+2q1xCqHgFW6u2sg2A
Date:   Sun, 26 Sep 2021 19:23:51 +0000
Message-ID: <330227E6-352C-40DA-8264-F523E0ACDFFA@oracle.com>
References: <20210926181622.81474-1-trondmy@kernel.org>
In-Reply-To: <20210926181622.81474-1-trondmy@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: be36369d-2481-40d1-acf2-08d981232c79
x-ms-traffictypediagnostic: SJ0PR10MB4687:
x-microsoft-antispam-prvs: <SJ0PR10MB4687BB6978A315BCCAA2DA6E93A69@SJ0PR10MB4687.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: y8GRcRPJDnFsrgRNy7pbCYHev5aZHdrYzXlxyZujGaWMN8ShzXiSrAS88bMS2KdLVgkWrox3hP93dH9MLgY1Mt/V+EnF2wYk9OIsns4h5iyJmX6pe98o2iwxf5ztJClP35LIBlWSaHADUNL3iYij8jJCfpUKHK7PBnGjQlY45WhqdL5uBwJVBBJ2jf5i2OVki0vMefAe7/lCM2h4zYKUOYCDT69fjBNLRuYQTRiAvkXLD2nlnSXYRu5f5FrQOBGI7faBFsXLLQsh5wa+T43z6F5sKF64TGVT6y31zifoG5IGIMcTeiuD0DDC4uDk0dKKMqSRrrNGW3emGz3PwPtxgx6SAl7XNSGMnkHKKZItCxm23qiUNxrlhv620L4NwkqqhLClA8df2w1zuugn2JeSp556+1oj+p+7LDvU0xDLQvjTUjRTik/KhEpt8+dI2G3Xa5SKfPSU7QeY8VsAND2w282Cm5aLDMpR9Wo7Io+WeFh35e3YAJWJGrzPPosVeLj9A2qeEwjpL9ex96g2cHSKvFaTOai6RTfbRqWokL+NqoUlFxZsddGdFmkriiltW/wE+/2YdRXlpapPahkN9xGJLb3pGJ7DgtgXgyjSd4i7Cvhh+sHLYeS34mgFyUdoZpTUEe2zJINGeEfFjRMXqYJts6bwwQNxYY4gnUzUf6mP9/mkymtP7NsYbMnfOiLqLaIqWgdKhQ2JsoMJsW4svBFqLgQyHMZU1yyPe7bVfRJW0guXPipymlwRDNsh715L7DKj
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(83380400001)(66476007)(64756008)(66556008)(66446008)(8936002)(76116006)(6486002)(4326008)(5660300002)(66946007)(53546011)(316002)(38100700002)(6916009)(54906003)(71200400001)(8676002)(86362001)(122000001)(38070700005)(186003)(36756003)(6506007)(2906002)(2616005)(508600001)(6512007)(26005)(33656002)(91956017)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?tzkAk4Q1TrpQOvnLp9+lEQRFa5yNefVmMcNNUfnJlgm/7JoBsXrUedMSmJGS?=
 =?us-ascii?Q?3jARyFwty3WbE9TiHaxzaSHb9aQHZFciWCM3LP6eB2Z8oHk7j7femIY9mz1k?=
 =?us-ascii?Q?EKAki3bGugKwtZin50qd3DRNx18GD76pVxDOXkEr5+qQ/hQ8RhRgLeU6u0jf?=
 =?us-ascii?Q?5yEiMTqK4g2gnVdHsVPaB/ftnkR1DGNhiAAB/ptB2NhViu5NDwFwCumJg/Qo?=
 =?us-ascii?Q?PsUuxY8lXJkuXm6RoZr+XsP2SoNzRHGjWtp8+8kJ1cBi4NUTDkS2WbUWzKxY?=
 =?us-ascii?Q?bOA86m0bq/1dvNbTAIeocCw3GMIQa03K6uQgp+asRZhlVbwuYlo1nb4CbwZO?=
 =?us-ascii?Q?+waW+OlgfKGJfkdGwcUHb6vawTdaGOPjG8wuP4sH/gC1yPxfYExe0LfSjUWG?=
 =?us-ascii?Q?Kb/mAn++Yl5gAHAmRtypkzwqclM3t4mfNKDggXU8yXUdYh0lI9saAOle+wGf?=
 =?us-ascii?Q?OJqNsewjeJ2HMF89VDGn8A9vVwlpSp1R7OUnEgo2NRGjeKJCk6XkAzMiObgZ?=
 =?us-ascii?Q?t/ksyl8CLW3REGCyo7Mj+r7dVRO3bv/Dq94vKe7Yt0wXpwOmti59R2IQB7P1?=
 =?us-ascii?Q?D4fINhc3aE3i3KdJRWrMKE7ppzMTzY/aH25ZeDV+XFed73ruVkt8K8qy1oeG?=
 =?us-ascii?Q?Uy7vKBRpneIX6o0qg3Uz/pQd2zNEIz1N6Pah7F7AZvrpiepQ3kgoNaysuZwj?=
 =?us-ascii?Q?zPx0X01V+BQldV4kdhYDF2JptiB492peBPuTBPZcDOshih0AQrH2GwmzRg3w?=
 =?us-ascii?Q?/dDRARHkZkIFpV6UfAcRaAuq+8QFR8U3KobiaI3Vt5bCQB2utgVz3+UEiQp8?=
 =?us-ascii?Q?R2NnQpv0Euj0+UYlTzhiCd1ShOTtESDoXvnJEAvNAZ8mlFuFaMAQF0IW4Znj?=
 =?us-ascii?Q?o2MCoVvs/rNg4t9no4CbkxTRcMdPxJw35EeiTUDV/O04yAMxqp5DHJxf8dRM?=
 =?us-ascii?Q?NEaBRbAcVjMiVy8+pbInZNpz14fiu2gwSFYwZ2ELAgxUmmiR/k+BcEUE4Ex+?=
 =?us-ascii?Q?htjBHYfGNZpWuam+iEwbyiOgibtm84hk32LyCQLiujUd3oUzbdvRvU4xXa+g?=
 =?us-ascii?Q?4snRUyzqZyEghRx4vEabtez6ZekvQGlBHLgPpR2bkY5BK+EkUPjVY2LHnF/c?=
 =?us-ascii?Q?pajiYdWghp1SuwAiqWrA4d2oT78nunyFQYFtNg3Z+c7KwyeTK0eNhAkGDLXv?=
 =?us-ascii?Q?kARRV55EdhuIQgYt8iSLCpUfEckyDqwzzHUHiY5rxXxBPJG75NSaG8J9Bo8O?=
 =?us-ascii?Q?QrKwjbtLEwQ+lNdlJXEuPWawtHSr4YYmK8eRH2G6KoXhZ7D7hZynHmQLmHTY?=
 =?us-ascii?Q?eQItyHh6b0GuuTUyGzFdKYDG?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3A54828F598AA54383C54CF6AF57788F@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be36369d-2481-40d1-acf2-08d981232c79
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2021 19:23:51.9118
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DCIbyRFv9ujAfIr4SfA+zqYNFHhHV8OwgOnarCVS9Yx8IvQDugEse3nUp3yAaJhx7OCpMLDhnanwr2Ec9Qvgvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4687
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10119 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 adultscore=0
 mlxscore=0 malwarescore=0 suspectscore=0 bulkscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2109260136
X-Proofpoint-ORIG-GUID: _U3lhlVsXB0qfCco3ZzUtF28e33npnj_
X-Proofpoint-GUID: _U3lhlVsXB0qfCco3ZzUtF28e33npnj_
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Thanks for the quick response! Comments inline.


> On Sep 26, 2021, at 2:16 PM, trondmy@kernel.org wrote:
>=20
> From: Trond Myklebust <trond.myklebust@hammerspace.com>
>=20
> Both NFSv3 and NFSv2 generate their change attribute from the ctime
> value that was supplied by the server. However the problem is that there
> are plenty of servers out there with ctime resolutions of 1ms or worse.
> In a modern performance system, this is insufficient when trying to
> decide which is the most recent set of attributes when, for instance, a
> READ or GETATTR call races with a WRITE or SETATTR.

I agree 100% that a legacy NFS client shouldn't rely on ctime
alone for tracking server-side changes, exactly because of
the timestamp resolution issue.


> For this reason, let's revert to labelling the NFSv2/v3 change
> attributes as NFS4_CHANGE_TYPE_IS_UNDEFINED. This will ensure we protect
> against such races.
>=20
> Fixes: 7b24dacf0840 ("NFS: Another inode revalidation improvement")

Perhaps this should be:

Fixes: 7f08a3359a3c ("NFSv4: Add support for the NFSv4.2 "change_attr_type"=
 attribute")


> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> ---
> fs/nfs/nfs3xdr.c | 2 +-
> fs/nfs/proc.c    | 2 +-
> 2 files changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/fs/nfs/nfs3xdr.c b/fs/nfs/nfs3xdr.c
> index e6eca1d7481b..9274c9c5efea 100644
> --- a/fs/nfs/nfs3xdr.c
> +++ b/fs/nfs/nfs3xdr.c
> @@ -2227,7 +2227,7 @@ static int decode_fsinfo3resok(struct xdr_stream *x=
dr,
>=20
> 	/* ignore properties */
> 	result->lease_time =3D 0;
> -	result->change_attr_type =3D NFS4_CHANGE_TYPE_IS_TIME_METADATA;
> +	result->change_attr_type =3D NFS4_CHANGE_TYPE_IS_UNDEFINED;
> 	return 0;
> }
>=20
> diff --git a/fs/nfs/proc.c b/fs/nfs/proc.c
> index ea19dbf12301..ecc4e717808c 100644
> --- a/fs/nfs/proc.c
> +++ b/fs/nfs/proc.c
> @@ -91,7 +91,7 @@ nfs_proc_get_root(struct nfs_server *server, struct nfs=
_fh *fhandle,
> 	info->dtpref =3D fsinfo.tsize;
> 	info->maxfilesize =3D 0x7FFFFFFF;
> 	info->lease_time =3D 0;
> -	info->change_attr_type =3D NFS4_CHANGE_TYPE_IS_TIME_METADATA;
> +	info->change_attr_type =3D NFS4_CHANGE_TYPE_IS_UNDEFINED;
> 	return 0;
> }
>=20

Unfortunately this patch did not change the behavior of fsx, and I
still observe readahead racing with truncation. That's not too
surprising since nfs_inode_attrs_cmp() is already returning zero
in the racing case (see previous e-mail).


             fsx-284916 [011]  1238.734038: nfs_aops_readpages:   fileid=3D=
00:28:2 fhandle=3D0x36fbbe51 version=3D1753079961650632466 nr_pages=3D8
             fsx-284916 [011]  1238.734047: nfs_initiate_read:    fileid=3D=
00:28:2 fhandle=3D0x36fbbe51 offset=3D102400 count=3D32768

             fsx-284916 [011]  1238.734055: nfs_setattr_enter:    fileid=3D=
00:28:2 fhandle=3D0x36fbbe51 version=3D1753079961650632466=20
             fsx-284916 [011]  1238.734055: nfs_writeback_inode_enter: file=
id=3D00:28:2 fhandle=3D0x36fbbe51 version=3D1753079961650632466=20
             fsx-284916 [011]  1238.734056: nfs_writeback_inode_exit: error=
=3D0 (OK) fileid=3D00:28:2 fhandle=3D0x36fbbe51 type=3D8 (REG) version=3D17=
53079961650632466 size=3D206226 cache_validity=3D0x2000 (DATA_INVAL_DEFER) =
nfs_
flags=3D0x4 (ACL_LRU_SET)
             fsx-284916 [011]  1238.734080: bprint:               nfs3_xdr_=
dec_setattr3res: task:53611@5 size=3D0x3ff5a
             fsx-284916 [011]  1238.734082: nfs_size_truncate:    fileid=3D=
00:28:2 fhandle=3D0x36fbbe51 version=3D1753079961650632466 cursize=3D206226=
 newsize=3D261978
             fsx-284916 [011]  1238.734082: nfs_inode_attrs_cmp:  fileid=3D=
00:28:2 fhandle=3D0x36fbbe51 version=3D1753079961650632466 res=3D0
             fsx-284916 [011]  1238.734083: nfs_refresh_inode_enter: fileid=
=3D00:28:2 fhandle=3D0x36fbbe51 version=3D1753079961650632466=20
             fsx-284916 [011]  1238.734083: nfs_partial_attr_update: fileid=
=3D00:28:2 fhandle=3D0x36fbbe51 version=3D1753079961650632466 cache_validit=
y=3DDATA_INVAL_DEFER fattr_validity=3DTYPE|MODE|NLINK|OWNER|GROUP|RDEV|SIZE
|PRE_SIZE|SPACE_USED|FSID|FILEID|ATIME|MTIME|CTIME|PRE_MTIME|PRE_CTIME|CHAN=
GE|PRE_CHANGE
             fsx-284916 [011]  1238.734083: nfs_check_attrs:      fileid=3D=
00:28:2 fhandle=3D0x36fbbe51 version=3D1753079961650632466 valid_flags=3D
             fsx-284916 [011]  1238.734083: nfs_refresh_inode_exit: error=
=3D0 (OK) fileid=3D00:28:2 fhandle=3D0x36fbbe51 type=3D8 (REG) version=3D17=
53079961650632466 size=3D261978 cache_validity=3D0x2000 (DATA_INVAL_DEFER) =
nfs_flags=3D0x4 (ACL_LRU_SET)
             fsx-284916 [011]  1238.734083: nfs_setattr_exit:     error=3D0=
 (OK) fileid=3D00:28:2 fhandle=3D0x36fbbe51 type=3D8 (REG) version=3D175307=
9961650632466 size=3D261978 cache_validity=3D0x2000 (DATA_INVAL_DEFER) nfs_=
flags=3D0x4 (ACL_LRU_SET)

  kworker/u24:13-17203 [002]  1238.734088: bprint:               nfs3_xdr_d=
ec_read3res: task:53610@5 size=3D0x32592
  kworker/u24:13-17203 [002]  1238.734088: nfs_inode_attrs_cmp:  fileid=3D0=
0:28:2 fhandle=3D0x36fbbe51 version=3D1753079961650632466 res=3D0
  kworker/u24:13-17203 [002]  1238.734089: nfs_refresh_inode_enter: fileid=
=3D00:28:2 fhandle=3D0x36fbbe51 version=3D1753079961650632466=20
  kworker/u24:13-17203 [002]  1238.734089: nfs_partial_attr_update: fileid=
=3D00:28:2 fhandle=3D0x36fbbe51 version=3D1753079961650632466 cache_validit=
y=3DINVALID_ATIME|DATA_INVAL_DEFER fattr_validity=3DTYPE|MODE|NLINK|OWNER|G=
ROUP|RDEV|SIZE|SPACE_USED|FSID|FILEID|ATIME|MTIME|CTIME|CHANGE
  kworker/u24:13-17203 [002]  1238.734089: nfs_size_update:      fileid=3D0=
0:28:2 fhandle=3D0x36fbbe51 version=3D1753079961650632466 cursize=3D261978 =
newsize=3D206226
  kworker/u24:13-17203 [002]  1238.734089: nfs_refresh_inode_exit: error=3D=
0 (OK) fileid=3D00:28:2 fhandle=3D0x36fbbe51 type=3D8 (REG) version=3D17530=
79961650632466 size=3D206226 cache_validity=3D0x2000 (DATA_INVAL_DEFER) nfs=
_flags=3D0x4 (ACL_LRU_SET)
  kworker/u24:13-17203 [002]  1238.734089: nfs_readpage_done:    fileid=3D0=
0:28:2 fhandle=3D0x36fbbe51 offset=3D102400 count=3D32768 res=3D32768 statu=
s=3D32768


--
Chuck Lever



