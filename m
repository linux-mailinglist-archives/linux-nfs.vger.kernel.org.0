Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6CEF584265
	for <lists+linux-nfs@lfdr.de>; Thu, 28 Jul 2022 16:57:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbiG1O5M (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 28 Jul 2022 10:57:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233387AbiG1O4x (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 28 Jul 2022 10:56:53 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E37871EC7A
        for <linux-nfs@vger.kernel.org>; Thu, 28 Jul 2022 07:55:15 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26SD3KW5011006;
        Thu, 28 Jul 2022 14:54:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=KQ90CZuj69Y9EblebSbQmsv+YTZB7vQ/bOULe037XFw=;
 b=IZpR/MlRnYKxAZrAqT4Gp7cE/khr4MMVMDA4IEJok3u27DLnn5p2jhEhz8mQdXgY8FXU
 Yub/VRDH+LMgzmoj/UPQpbBB6zfMlrxTSstSpSg26xgC3uSNajZeDepAR02KyApPc920
 VgdAAIcfQcNH6gyXjz5vgXAKUYocH9Ym1GFhcJ6CO9cfEw97zwluIiOPAUQ+ddBC26cz
 atm49nLoa5PdaHQfKIvkgaL9tG1AzJb7ievdp5E7rYVYjHH6nhZV/A5648iYxXas5apR
 fnvDxa/Ftkwz3repxZK4RDobIYbI6TMoEeBpWifUqwXzr8nHWfkmXAelPOLYXS+0ey0M uQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hg9ap4cap-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Jul 2022 14:54:48 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26SCuJXo019772;
        Thu, 28 Jul 2022 14:54:47 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2108.outbound.protection.outlook.com [104.47.58.108])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3hh63ap9ju-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Jul 2022 14:54:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dAlnHBW4xvRgZGCzPg1GmE0j6luT78Txv+AlscSRsZj/U16LsO/ZOwM/bkTskDMWX38K9qaqspQ+muObGLF7IyrPVD+wympaaUoPmfRoQl4+E+4U9Oy5gT+UGmBbFhaHXE+VVJp2iced3SvkqWK6O4PHQOrCsOgAxQe4LPA1bL1fSAfFEszE/QY5chg3FGrTk2c5vn8RBTFBdoF/4MP5xFpuZWW1+WgsNdBFakLntdLmYItNLc0L3dpM3JGIrx0+tAdzeR4ECQGgDPW7oFV/cIR6EKbEEuiFfD2qFJzrrCQr+nCmKmbz+kqS/yngdrAdgzOvVtOVe9h40LD9KQqk1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KQ90CZuj69Y9EblebSbQmsv+YTZB7vQ/bOULe037XFw=;
 b=P+haP/DGc+N63xKcQb2vLnecxepnF9xDZ1KR1DcnH9N9YQ1jTinqmmKDYyx1xBeDZVNA9RwtuWaEXAqsggqA4VBMm0YUBqUShQSvkrVMPJZSuhN0hwdlseP5oGTStEPH+f/u7H1levDBhghsaQ3WaN48UA7wVoTL6GoMClBqRJENa+u6u2NhI0J2wIU7k3K396ei8Iy/41kYuMpG2yen5fQMSro96Nxs2Y+iBUf3PqrbwduJ+37VmC+m1D57CtEa2QpAEDYlIbAOKKrVZ0vJ5AkBpBqqvrF5m6ltQWyoI3MO8UF+TCPYAEmDYCWBqiFmo2PSNm2RjChIofapoGyohw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KQ90CZuj69Y9EblebSbQmsv+YTZB7vQ/bOULe037XFw=;
 b=ics4/H9Yj8gFDvvBERZ1fQmfmAvnWP8Iei0xh2e2qSGYYnx6PvaETXPlwjmnt/O0QrHxN0I3HruNhkC+eGl2ULYFJrpIlfnwmiJOEPwmc9q+XAdL0UWggQH2oepelVLG3NVBv+GwQj16+j/to5ywg8a9zDnXhw6yTJSBHeSn6Aw=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MN2PR10MB4304.namprd10.prod.outlook.com (2603:10b6:208:1d0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.11; Thu, 28 Jul
 2022 14:54:45 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::8cc6:21c7:b3e7:5da6]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::8cc6:21c7:b3e7:5da6%9]) with mapi id 15.20.5482.011; Thu, 28 Jul 2022
 14:54:45 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Neil Brown <neilb@suse.de>
CC:     Jeff Layton <jlayton@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 11/13] NFSD: use explicit lock/unlock for directory ops
Thread-Topic: [PATCH 11/13] NFSD: use explicit lock/unlock for directory ops
Thread-Index: AQHYohNX7cvCckGh/kqPxDxsXdi4Iq2T38yA
Date:   Thu, 28 Jul 2022 14:54:45 +0000
Message-ID: <6221A20D-6623-41EB-AC9F-BEFB1F4ED925@oracle.com>
References: <165881740958.21666.5904057696047278505.stgit@noble.brown>
 <165881793059.21666.9611699223923887416.stgit@noble.brown>
In-Reply-To: <165881793059.21666.9611699223923887416.stgit@noble.brown>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 78289fbb-7e72-414a-0e1a-08da70a91c59
x-ms-traffictypediagnostic: MN2PR10MB4304:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UTffqY2qvmmPP7hPWvmJf86bk+MglYXICbOtJZ95XQJ45dTbjwEPRdOrU9M+4WztEgOcXjxSnboCxeX+kpMiCzeneXAlMwM5QN/E8J484tMOJ42Vz6Dm9eY7b0XA4ck+URee8bj4b4Vw7Q4XGlinR6hiiqTg1ILsJv5b6DbxG39DYM9RlRAzVVsjFW32RmMQMRnGT0IxplPgeqo2tml5GEsm7G+846ThNhFx8uIm/zlyMgM4S9bHo9hBtOQ5DOu69PQ1k2X+yIMhOesYAbpR4LQdVQPvWCQVK1UujX3MGaB6BXNTKYOwytwnHlV4NB4EDU9+0Slc1dGYt+iWvP7vqnVcyaxwJ/pUWJHKYqyjND0OjFtygnNcGOFnjKJT0o0IF5gOZwcqevUyWR8OyloDLVN4RCt6VrQwfhXyX1xJFMuXhBu8qIo1YBLhobwU8vBuaTuARLJGb7zXwtKFo5EwpHL0I+DugiJh1z3mFg1mrdjjxb+mSCuG6NcSIywrSDmLLeXq95UxldCk3C3x3dPlystTgQzQNnla/QIDCfk/eGalC7kJFKTVIHKFyBifVOXxmJ/XZdkqDD84cIGIhWEtJ2iiB9gNS7Xy+5aIckI0yppav5DXiwNe954obaBDl/Av+ajqvjXSnF+is6fvo4PwnJPpkqzIz1Ypc30L3mu6Q0sBrp/jTNtK14/GUAKEjMsatIc1qCjDyUpH1w/sxssY9nrcwDjYcgLi6PCr6ijcqaW3yjneLHn1VdxLZGJ5MWYJ/O3H/haxWCuq6lOQB1eB2RpzqWCmPiXm+aQSpXdnF7OYaL283qDtDwPCpSavStcGVdj8GqNlOf/hwSvNCgaXyg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(396003)(366004)(376002)(346002)(39860400002)(41300700001)(6486002)(478600001)(71200400001)(2616005)(83380400001)(122000001)(186003)(53546011)(26005)(6506007)(6512007)(86362001)(38100700002)(2906002)(5660300002)(8936002)(36756003)(316002)(54906003)(6916009)(38070700005)(33656002)(8676002)(91956017)(66946007)(4326008)(66446008)(66556008)(66476007)(64756008)(76116006)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?UZmudKK7HMPAtU+USam9ei4FSwz5VBnh3sn0Fg3ZPSzK1+M663v7TY8cI7cM?=
 =?us-ascii?Q?XRGkIWHeyhmE3+Ctrfp0BeDF6MinCoeXSZepLkfI+JuYRQ9pEDaPyZ0sK7bN?=
 =?us-ascii?Q?mfnP4y9hj63wHK+BriR6KBLb4+E3Avl9PnCalDJ8rSns/7WkRCR6y4TqaxAr?=
 =?us-ascii?Q?N19d4SjsTyvH9LjhC/vqR6OvllfxRLhFMYcWBdEaBNXLwM08mImguhiGYhZ7?=
 =?us-ascii?Q?hONl4G1XRnvKYs5TtzX6vz+gkqgZA3bwAVlQw7xyTG4n9icqd5Jhr5m8ejHJ?=
 =?us-ascii?Q?opvvb9yy9XOL04/oqnTepf2W2CAqrua6DR2Jpe5fytykKhJgSfonS7yRh7jO?=
 =?us-ascii?Q?J0YR6yVDn3POvou8bsw4PXfTDr1OYW3NB++heaoK3XwQ7h7sHiHDOpbkjChl?=
 =?us-ascii?Q?YEcnW/q0xy0fqmNv8uKw3O7c0ifPqS+2nEb6DjVN+0WA85odzO5xmum9kGwX?=
 =?us-ascii?Q?HltLuk4g2ZFQ9fg3aLH9mzMGByTTAgOkmHt1OhjczlfiZR5Zzp7mJ92YF2cb?=
 =?us-ascii?Q?JjGskDBGnaIkk6OzMxgaTsDjUSeian9pIiPfgYWwA/nkVp9yNkXF2uZPD+Om?=
 =?us-ascii?Q?YIdFD8S2xke5t4FeKFdB4rVAZHlacfQcwoqeUVAZ+60dorO8iS8uMhoqwDUD?=
 =?us-ascii?Q?X4GQNM9ljZgtXD09GulXJhsqUwOmwUvPi1SQDf+2qro5ScHiY9y3FqoVRg4o?=
 =?us-ascii?Q?fv+EoanF2k7xGIol9YCzjweD0BklYkeE08gE/mUEDKmWQZXqQbrxWxuCtfaY?=
 =?us-ascii?Q?oiZ884nxMfsqwfAofqXZMnCIbrcSzQt/OnQQGyB3lV7TYkacjBYdYkEEWmyn?=
 =?us-ascii?Q?ehDGJdJjC5uGxaSBEoYBndo/7EEZ3YCtVLIMWPQnamrSxhUQuj6RUvMgP+RB?=
 =?us-ascii?Q?fqk6D3xH0wCF1GtCHoIFgA9tX44SpQfA/yF0kCfyNjJsCXD9wWLtvB7ahiAJ?=
 =?us-ascii?Q?yscgwith71XvqjbLAaselecg+o22DaNON2i0pR37CT1Tu8cM5CisuMwQWKTz?=
 =?us-ascii?Q?Iplg2LA9OPsZVkbBrKaXbB6T0yqbl+mfJRUHvbfthTvsRD60SxpXAjGCU/c2?=
 =?us-ascii?Q?fTL1+85EvQ9JvpGE0psVORc2aIdidT2FBtH2eiqjnHPvdqa5ctREJPrpW/BI?=
 =?us-ascii?Q?/RTpeLvC/wp+82VRUMJvNZijsHnDaYfJouVaOfnfjwWNrkNCSE4SPBsmIBDj?=
 =?us-ascii?Q?EpKk9u3rltu7sWqtdsOTusYPfNyrhnkaJS62r27W/NnZ/Lsni0zmgRJdKfK9?=
 =?us-ascii?Q?FEMY2TYKDxFTjrczQOwLHZN7xrY+/diP5yiSsyotTSNtbdFEHB3bmbalC9/Z?=
 =?us-ascii?Q?YtpBap5Oa/HzSf4b/OkoiJnmTjMWuJDL8KwpjLcZThTlm3Pr/rCz1lpHyLgr?=
 =?us-ascii?Q?obHUYkFbS5U/qkWPq+azQE/a4/XK+bMLeUHWIWcUG90mAANk85khYoXGNJDx?=
 =?us-ascii?Q?z6MXQ4yIeZkid6IXt3fkv0P1ti7KIRgGfSlMRbGLazFUhbI20mDrFO4cnWkp?=
 =?us-ascii?Q?7T+7UwIdwVr4vfs3vac8GGilzaYq9ujaW1JFd8kTGU9ApYNY9bfUUHPKba0e?=
 =?us-ascii?Q?A5XWPDsKLkVMuI6TWiZt5jnAnw5ily14DdZhGJS8CSfs0qpPeK6WVrQVEwJ4?=
 =?us-ascii?Q?LQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <73C9BFE46A867D49800DEA76E10E6CB1@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78289fbb-7e72-414a-0e1a-08da70a91c59
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2022 14:54:45.3103
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Mw7P9nycCRqJWzn9nbxin808Q/YE2i4pxr9uJizCj0rnvHx+e53oT/jaJHvQd8igv3GeKZFiZq7+Wk6an21X4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4304
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-28_06,2022-07-28_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=527 malwarescore=0
 suspectscore=0 mlxscore=0 bulkscore=0 adultscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207280068
X-Proofpoint-ORIG-GUID: Hngw6uXPeEuHmp5YxIIctHObvYlfJurA
X-Proofpoint-GUID: Hngw6uXPeEuHmp5YxIIctHObvYlfJurA
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
> When creating or unlinking a name in a directory use explicit
> inode_lock_nested() instead of fh_lock(), and explicit calls to
> fh_fill_pre_attrs() and fh_fill_post_attrs().  This is already done for
> renames.

IIUC, the antecedent of "This is already done" is only "explicit
calls to fh_fill_pre_attrs() and fh_fill_post_attrs()" ?

>=20
> Also move the 'fill' calls closer to the operation that might change the
> attributes.  This way they are avoided on some error paths.
>=20
> For the v2-only code in nfsproc.c, drop the fill calls as they aren't
> needed.

This feels like 3 independent changes to me. At least the v2 change
should be moved to a separate patch. Relocating the "fill attrs" calls
seems like it could cause noticeable behavior changes, so maybe it
belongs also in a separate patch?


> Having the locking explicit will simplify proposed future changes to

^Having^Making ?


> locking for directories.  It also makes it easily visible exactly where
> pre/post attributes are used - not all callers of fh_lock() actually
> need the pre/post attributes.
>=20
> Reviewed-by: Jeff Layton <jlayton@kernel.org>
> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
> fs/nfsd/nfs3proc.c |    6 ++++--
> fs/nfsd/nfs4proc.c |    6 ++++--
> fs/nfsd/nfsproc.c  |    5 ++---
> fs/nfsd/vfs.c      |   30 +++++++++++++++++++-----------
> 4 files changed, 29 insertions(+), 18 deletions(-)
>=20
> diff --git a/fs/nfsd/nfs3proc.c b/fs/nfsd/nfs3proc.c
> index 774e4a2ab9b1..c2f992b4387a 100644
> --- a/fs/nfsd/nfs3proc.c
> +++ b/fs/nfsd/nfs3proc.c
> @@ -256,7 +256,7 @@ nfsd3_create_file(struct svc_rqst *rqstp, struct svc_=
fh *fhp,
> 	if (host_err)
> 		return nfserrno(host_err);
>=20
> -	fh_lock_nested(fhp, I_MUTEX_PARENT);
> +	inode_lock_nested(inode, I_MUTEX_PARENT);
>=20
> 	child =3D lookup_one_len(argp->name, parent, argp->len);
> 	if (IS_ERR(child)) {
> @@ -314,11 +314,13 @@ nfsd3_create_file(struct svc_rqst *rqstp, struct sv=
c_fh *fhp,
> 	if (!IS_POSIXACL(inode))
> 		iap->ia_mode &=3D ~current_umask();
>=20
> +	fh_fill_pre_attrs(fhp);
> 	host_err =3D vfs_create(&init_user_ns, inode, child, iap->ia_mode, true)=
;
> 	if (host_err < 0) {
> 		status =3D nfserrno(host_err);
> 		goto out;
> 	}
> +	fh_fill_post_attrs(fhp);
>=20
> 	/* A newly created file already has a file size of zero. */
> 	if ((iap->ia_valid & ATTR_SIZE) && (iap->ia_size =3D=3D 0))
> @@ -336,7 +338,7 @@ nfsd3_create_file(struct svc_rqst *rqstp, struct svc_=
fh *fhp,
> 	status =3D nfsd_create_setattr(rqstp, fhp, resfhp, &attrs);
>=20
> out:
> -	fh_unlock(fhp);
> +	inode_unlock(inode);
> 	if (child && !IS_ERR(child))
> 		dput(child);
> 	fh_drop_write(fhp);
> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> index 48e4efb39a9c..90af82d49119 100644
> --- a/fs/nfsd/nfs4proc.c
> +++ b/fs/nfsd/nfs4proc.c
> @@ -264,7 +264,7 @@ nfsd4_create_file(struct svc_rqst *rqstp, struct svc_=
fh *fhp,
> 	if (is_create_with_attrs(open))
> 		nfsd4_acl_to_attr(NF4REG, open->op_acl, &attrs);
>=20
> -	fh_lock_nested(fhp, I_MUTEX_PARENT);
> +	inode_lock_nested(inode, I_MUTEX_PARENT);
>=20
> 	child =3D lookup_one_len(open->op_fname, parent, open->op_fnamelen);
> 	if (IS_ERR(child)) {
> @@ -348,10 +348,12 @@ nfsd4_create_file(struct svc_rqst *rqstp, struct sv=
c_fh *fhp,
> 	if (!IS_POSIXACL(inode))
> 		iap->ia_mode &=3D ~current_umask();
>=20
> +	fh_fill_pre_attrs(fhp);
> 	status =3D nfsd4_vfs_create(fhp, child, open);
> 	if (status !=3D nfs_ok)
> 		goto out;
> 	open->op_created =3D true;
> +	fh_fill_post_attrs(fhp);
>=20
> 	/* A newly created file already has a file size of zero. */
> 	if ((iap->ia_valid & ATTR_SIZE) && (iap->ia_size =3D=3D 0))
> @@ -373,7 +375,7 @@ nfsd4_create_file(struct svc_rqst *rqstp, struct svc_=
fh *fhp,
> 	if (attrs.acl_failed)
> 		open->op_bmval[0] &=3D ~FATTR4_WORD0_ACL;
> out:
> -	fh_unlock(fhp);
> +	inode_unlock(inode);
> 	nfsd_attrs_free(&attrs);
> 	if (child && !IS_ERR(child))
> 		dput(child);
> diff --git a/fs/nfsd/nfsproc.c b/fs/nfsd/nfsproc.c
> index d09d516188d2..4cff332f58bb 100644
> --- a/fs/nfsd/nfsproc.c
> +++ b/fs/nfsd/nfsproc.c
> @@ -287,7 +287,7 @@ nfsd_proc_create(struct svc_rqst *rqstp)
> 		goto done;
> 	}
>=20
> -	fh_lock_nested(dirfhp, I_MUTEX_PARENT);
> +	inode_lock_nested(dirfhp->fh_dentry->d_inode, I_MUTEX_PARENT);
> 	dchild =3D lookup_one_len(argp->name, dirfhp->fh_dentry, argp->len);
> 	if (IS_ERR(dchild)) {
> 		resp->status =3D nfserrno(PTR_ERR(dchild));
> @@ -403,8 +403,7 @@ nfsd_proc_create(struct svc_rqst *rqstp)
> 	}
>=20
> out_unlock:
> -	/* We don't really need to unlock, as fh_put does it. */
> -	fh_unlock(dirfhp);
> +	inode_unlock(dirfhp->fh_dentry->d_inode);
> 	fh_drop_write(dirfhp);
> done:
> 	fh_put(dirfhp);
> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index 8ebad4a99552..f2cb9b047766 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -1369,7 +1369,7 @@ nfsd_create(struct svc_rqst *rqstp, struct svc_fh *=
fhp,
> 	if (host_err)
> 		return nfserrno(host_err);
>=20
> -	fh_lock_nested(fhp, I_MUTEX_PARENT);
> +	inode_lock_nested(dentry->d_inode, I_MUTEX_PARENT);
> 	dchild =3D lookup_one_len(fname, dentry, flen);
> 	host_err =3D PTR_ERR(dchild);
> 	if (IS_ERR(dchild)) {
> @@ -1384,10 +1384,12 @@ nfsd_create(struct svc_rqst *rqstp, struct svc_fh=
 *fhp,
> 	dput(dchild);
> 	if (err)
> 		goto out_unlock;
> +	fh_fill_pre_attrs(fhp);
> 	err =3D nfsd_create_locked(rqstp, fhp, fname, flen, attrs, type,
> 				 rdev, resfhp);
> +	fh_fill_post_attrs(fhp);
> out_unlock:
> -	fh_unlock(fhp);
> +	inode_unlock(dentry->d_inode);
> 	return err;
> }
>=20
> @@ -1460,20 +1462,22 @@ nfsd_symlink(struct svc_rqst *rqstp, struct svc_f=
h *fhp,
> 		goto out;
> 	}
>=20
> -	fh_lock(fhp);
> 	dentry =3D fhp->fh_dentry;
> +	inode_lock_nested(dentry->d_inode, I_MUTEX_PARENT);
> 	dnew =3D lookup_one_len(fname, dentry, flen);
> 	if (IS_ERR(dnew)) {
> 		err =3D nfserrno(PTR_ERR(dnew));
> -		fh_unlock(fhp);
> +		inode_unlock(dentry->d_inode);
> 		goto out_drop_write;
> 	}
> +	fh_fill_pre_attrs(fhp);
> 	host_err =3D vfs_symlink(&init_user_ns, d_inode(dentry), dnew, path);
> 	err =3D nfserrno(host_err);
> 	cerr =3D fh_compose(resfhp, fhp->fh_export, dnew, fhp);
> 	if (!err)
> 		nfsd_create_setattr(rqstp, fhp, resfhp, attrs);
> -	fh_unlock(fhp);
> +	fh_fill_post_attrs(fhp);
> +	inode_unlock(dentry->d_inode);
> 	if (!err)
> 		err =3D nfserrno(commit_metadata(fhp));
> 	dput(dnew);
> @@ -1519,9 +1523,9 @@ nfsd_link(struct svc_rqst *rqstp, struct svc_fh *ff=
hp,
> 		goto out;
> 	}
>=20
> -	fh_lock_nested(ffhp, I_MUTEX_PARENT);
> 	ddir =3D ffhp->fh_dentry;
> 	dirp =3D d_inode(ddir);
> +	inode_lock_nested(dirp, I_MUTEX_PARENT);
>=20
> 	dnew =3D lookup_one_len(name, ddir, len);
> 	if (IS_ERR(dnew)) {
> @@ -1534,8 +1538,10 @@ nfsd_link(struct svc_rqst *rqstp, struct svc_fh *f=
fhp,
> 	err =3D nfserr_noent;
> 	if (d_really_is_negative(dold))
> 		goto out_dput;
> +	fh_fill_pre_attrs(ffhp);
> 	host_err =3D vfs_link(dold, &init_user_ns, dirp, dnew, NULL);
> -	fh_unlock(ffhp);
> +	fh_fill_post_attrs(ffhp);
> +	inode_unlock(dirp);
> 	if (!host_err) {
> 		err =3D nfserrno(commit_metadata(ffhp));
> 		if (!err)
> @@ -1555,7 +1561,7 @@ nfsd_link(struct svc_rqst *rqstp, struct svc_fh *ff=
hp,
> out_dput:
> 	dput(dnew);
> out_unlock:
> -	fh_unlock(ffhp);
> +	inode_unlock(dirp);
> 	goto out_drop_write;
> }
>=20
> @@ -1730,9 +1736,9 @@ nfsd_unlink(struct svc_rqst *rqstp, struct svc_fh *=
fhp, int type,
> 	if (host_err)
> 		goto out_nfserr;
>=20
> -	fh_lock_nested(fhp, I_MUTEX_PARENT);
> 	dentry =3D fhp->fh_dentry;
> 	dirp =3D d_inode(dentry);
> +	inode_lock_nested(dirp, I_MUTEX_PARENT);
>=20
> 	rdentry =3D lookup_one_len(fname, dentry, flen);
> 	host_err =3D PTR_ERR(rdentry);
> @@ -1750,6 +1756,7 @@ nfsd_unlink(struct svc_rqst *rqstp, struct svc_fh *=
fhp, int type,
> 	if (!type)
> 		type =3D d_inode(rdentry)->i_mode & S_IFMT;
>=20
> +	fh_fill_pre_attrs(fhp);
> 	if (type !=3D S_IFDIR) {
> 		if (rdentry->d_sb->s_export_op->flags & EXPORT_OP_CLOSE_BEFORE_UNLINK)
> 			nfsd_close_cached_files(rdentry);
> @@ -1757,8 +1764,9 @@ nfsd_unlink(struct svc_rqst *rqstp, struct svc_fh *=
fhp, int type,
> 	} else {
> 		host_err =3D vfs_rmdir(&init_user_ns, dirp, rdentry);
> 	}
> +	fh_fill_post_attrs(fhp);
>=20
> -	fh_unlock(fhp);
> +	inode_unlock(dirp);
> 	if (!host_err)
> 		host_err =3D commit_metadata(fhp);
> 	dput(rdentry);
> @@ -1781,7 +1789,7 @@ nfsd_unlink(struct svc_rqst *rqstp, struct svc_fh *=
fhp, int type,
> out:
> 	return err;
> out_unlock:
> -	fh_unlock(fhp);
> +	inode_unlock(dirp);
> 	goto out_drop_write;
> }
>=20
>=20
>=20

--
Chuck Lever



