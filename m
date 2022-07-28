Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E78F584261
	for <lists+linux-nfs@lfdr.de>; Thu, 28 Jul 2022 16:56:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233327AbiG1O4A (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 28 Jul 2022 10:56:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233560AbiG1Ozk (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 28 Jul 2022 10:55:40 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7CAC6A9EF
        for <linux-nfs@vger.kernel.org>; Thu, 28 Jul 2022 07:54:17 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26SD38jh008461;
        Thu, 28 Jul 2022 14:54:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=oS+/RegW7Pe4Moqv+dFCFpAGxKiQfFaKV/ZL37oLp60=;
 b=RPDg/RdtOeV17BF/YQIyldXe7Xe0A6KV7W5psLiupTw2T6SpASMSe3gCxK3FQg4mWwM0
 qEUhxgFHAdk08h1wCBJG/khOwDVP2zS0ShjyHZzNPTbn9N6BMcDaomNAxrW05uH3lDjH
 Hc6SaPBOu6oFmbG2A3JnOxNQzBD0yKmTODSiGR5WNCwZqmFrWFVN31sHxQThg/SyLw/R
 x67KH3YU20nnuCdWm2OGWoLhSoOLKEWn9jiH+gtst2LOySPSQ9janUJHFzCGesL/rRKG
 61ouKJY+8ZmbeHIOo6y3yMhCOph/GRk5XND2aBd5LIKjJm8drRtXOb8rq3HochVym5G3 tA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hg9a9mvwy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Jul 2022 14:54:05 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26SC9UuF029634;
        Thu, 28 Jul 2022 14:54:04 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2175.outbound.protection.outlook.com [104.47.57.175])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3hkt7bxewg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Jul 2022 14:54:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P2oJqTdgkfTirsKN5zrgq74zgcYMQhkIDisZM8OHqpVgvkPSdVzXpX+kfYF1awevktfP+i/oincgu9JabxS1icMdFbVzv0KgL3CE0Il5P1sdB/lXRngyKQ8GoB1CaCnMF4Ol/+qyTZF1X9+Guma2cJTMG60mlRmoSijf7miBrqJ8r/SQhBLSM7uWc+5SiSA6smS85SFaNa4kRhi1DJ66DsxLO4+D9UIvTnsMl/FLI2A5g84E1pqyUl2vwpT7tDMdhSe+3XNc/IJZa9byZq3bZRUmTOIw4Kg2tgJ4ez4wZjx0qsnREkogIjir/LlKKIE656aqKueP8YKQnkvXfR4bmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oS+/RegW7Pe4Moqv+dFCFpAGxKiQfFaKV/ZL37oLp60=;
 b=ioy2MVwvWBB9JadqEDDKNNI/mkVRI9bJMxrhlM5FKFSV78y3myL2fKHyyWQTPf9csGCvUjeG8shnMmii2Vreb/icngsPxTJPfdWw7/DetPWyjUMWGs1sd1E6w2PFs+uaMu8tF/aYgMexfVqSzG5hEhh0lLsKhZfLpGgiKXWebszcpxL0jX4YMzPK3hj3zaOsvLfDlPvSqOzIfyNYg8o2ibHXQjkuWGslyJSi8bW87LsS3vbU61aIsDnkyJruV9un4lKshCi3P0t8yvnsconzwlDX7nFUHqG3AYa5VoqP62lhGwYeZ0gsOirQMmXqg3jOGdCRDobPCvfxoDhVIxVS+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oS+/RegW7Pe4Moqv+dFCFpAGxKiQfFaKV/ZL37oLp60=;
 b=RLKWNr/gftUERWEYNgEbiFqQq//uvwh4F82UAACGCKP8f/TZaNDtmgs7iwGHt7dJlEaq5frmTzxRf4q8hAjiZ4aYc1XN0HOaWw1wY0+JiFT6RVecOxEg4Sl83STYBF9ZDlK0O0bg55hQWss/j0yVU1oaMezuDp9PB5ikfVjPuDo=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH2PR10MB3752.namprd10.prod.outlook.com (2603:10b6:610:d::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19; Thu, 28 Jul
 2022 14:54:02 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::8cc6:21c7:b3e7:5da6]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::8cc6:21c7:b3e7:5da6%9]) with mapi id 15.20.5482.011; Thu, 28 Jul 2022
 14:54:02 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Neil Brown <neilb@suse.de>
CC:     Jeff Layton <jlayton@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 05/13] NFSD: add security label to struct nfsd_attrs
Thread-Topic: [PATCH 05/13] NFSD: add security label to struct nfsd_attrs
Thread-Index: AQHYoLumGwxG6ESC10WfyfT4/4EBlq2T4kgA
Date:   Thu, 28 Jul 2022 14:54:02 +0000
Message-ID: <58E8A202-C73C-49F6-9C3C-C145F6C6731B@oracle.com>
References: <165881740958.21666.5904057696047278505.stgit@noble.brown>
 <165881793056.21666.14726745370568724977.stgit@noble.brown>
In-Reply-To: <165881793056.21666.14726745370568724977.stgit@noble.brown>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5764e16d-576f-442e-c094-08da70a902dd
x-ms-traffictypediagnostic: CH2PR10MB3752:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TcCbHmCyIf+x/KtjayAy+wwCthtTSRn10nOWPfcZKdpYOfkwogQqlwIZrqA03Kuh61uKlsrHw7DHN+3JAfccGKzpKYJYaYWwQnMQpSqir66M6Ty5mbUWwJbmGxL3c1qCF1lE6IlbCDzkKlTkRrhqIStXGzjWItF+ruhm8AXOyx6ulvvxtDve3CI+2kU8eW07skCuirW2z6C9O2ZAoSPUv9cU77FyKC75dlPb3C6YNzpHUs+kQqTTYwTBREASDnRRcjW9mP/dxvZr3elet+CXTFQ8GuKzRlgbYrHaEJqAzsLQcEuqIxliapvk3aO7B7btaYyMFlmvf28xPSdJrjhdyNJXI+plK5Crt1BTDzX18VoLaW8yx/HSi+K1gEGc43CiB849DsnGoCtun+Q0MF6I4nswoYCH5oIOo1wvUc0Rnd5o7DWZosFu6Qy/VchIb/zCXUljI1+uW2+io0FNUYztpy9f8ZdK+6J4RBxQPYUpTVEGuFhzahKw0vAW8yI1ebTgeIkIhjxK9QY2FrsU6sjJ1vr29nOlbGd+Dw7hobXiGcvNj0a4KVNrOUhrxtbLwHIeDHCQtxj39Gbf9LWWxa3jOsccShXd6EpGGIuM2xlIofFm1xsB2r1Atg4k+nw1xTRyDQbtwoIvaFBEHTfI0N+KFudOtdjYgQSeIablBwz7wCG5+XBwIHAyB4Ire5HWTijQFzxx8sG+mHZrHeW5urmqff2hkdEa/KknbyuniTBL7UL+ZIGS1ApIDzCssdH/uPyUDvrjwU4oLLymlOYC1R+imb1TWbz3UTmxLWlNdTbKBkpBDvY5S/BWzQl8MC3Z9ks69wOguXNgAKm8l3wj8DVqo67e+8iQMRbh+WsltViV4RE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(39860400002)(136003)(346002)(396003)(376002)(6916009)(2906002)(36756003)(15650500001)(54906003)(2616005)(41300700001)(64756008)(86362001)(316002)(33656002)(122000001)(66476007)(6486002)(91956017)(5660300002)(6506007)(66946007)(38100700002)(8676002)(6512007)(76116006)(4326008)(8936002)(26005)(83380400001)(186003)(478600001)(38070700005)(53546011)(66446008)(71200400001)(66556008)(21314003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?L/7rZi3sbF6ZyjCDZS9sxY38IVtxehyJysAQq//g2Ftsm6/+U8224qbQYtHF?=
 =?us-ascii?Q?xh5KdXp1tDbuilY3GWMYMMn8BDu4xq4HO0T1znCbUxkXqPK86zSJHZvH8190?=
 =?us-ascii?Q?6g8j30f+p3gnPiOWHFyS+gzYp6Rmeeqs2Nn0LdZLQQWml88rmVn/TPCg9rx7?=
 =?us-ascii?Q?0kYOYRH4Rc9Y46iEwXNn8kOSFUsBPoI1vACBnvj4e04LkZIaSNYT1RqK09t9?=
 =?us-ascii?Q?+zjCkL9rQ+x7KS0q5swY1NYWOm4bf+cmEqaR52ltrIfLXiyFOMhUEmi74WXd?=
 =?us-ascii?Q?vdKodCLny4J7nlUbUp8iHMaJwIGEpFxGEV3PRAApHvYedih22vpdQStxtbsN?=
 =?us-ascii?Q?wHAVrVLPggIko/PxdxDSfkeGFKrA3n7Dibw92UxCJP2FFMhyIYmGySfqi7NB?=
 =?us-ascii?Q?tqzRfyzwFIjn8aVNonZItW/QFRQr7Nf2rhzQacMus3MIz+YBH+e6/LCeZXSU?=
 =?us-ascii?Q?EDPHanQXvO2QpsmY1ap/ZvG8Q8t6C8is22t2NMZqVUjuYTMStZVebdkfMdMP?=
 =?us-ascii?Q?0QJLMfDgj6iotHHH02sCOFD32WK1nikcUrTEyHLipPje8P3JBlbPTBnBsS0T?=
 =?us-ascii?Q?oSLC54USSSmVp1PuO0ZBFvaV1wVDiP5oSuS8FjqVlku85kqxFSZsMggnLU3V?=
 =?us-ascii?Q?cbRljTb260lsV0H06VAe5v7MewdHRVmKQTkfREWeww+558NoBmnaG/oBYWBL?=
 =?us-ascii?Q?ijsAb2g1cWDxBNpEjrIPoPGb8xkPzcrp/tXLE11WvgRcYZjAKsLjbm9wzILD?=
 =?us-ascii?Q?wQd2C85nZEY0WL/7gIRATawb6gGHvBKcBgs38N7Mt7z/nBV+J7+FcC8v+WZY?=
 =?us-ascii?Q?LGd19RAtx0PdlpSda1E/OdSBu6J2uu3HZQBWCky02YOKKAUT8uSm149UPk1i?=
 =?us-ascii?Q?TyokZF0VYccyI+GuKCEaKQBh1LkgnRYTqloXh15v6PMVYAV3lDDQ38UcWZ1U?=
 =?us-ascii?Q?TU/tiShZfEDoOHoKP4A5Cl0fmzQyVPyXMIWk574WBXImA66Vevh59ZQzJeZX?=
 =?us-ascii?Q?v04CYrXPeH1mNUHzUuFY60ML6y7zlP/SyS7bc8TmBJqmgtcV+d/dCSk4y1n/?=
 =?us-ascii?Q?VUrGWloQoj9X3gE9+JzAYKUKt12oUAQ7LxsFbJEDhjtSploJ6FqlzYRQ6taq?=
 =?us-ascii?Q?mLWnWwuv7OT99s+QBCAgmSltvkvDddCe2jmlf8G+xSnEB0ym8i83rdctEu/q?=
 =?us-ascii?Q?Z8HsdrNVaoe7FImpzisO3f/jTFXK7NJkevmIh9BcwKP8Vxjl9vtbNChD1yJR?=
 =?us-ascii?Q?sqUxZKwO4EP4f37hnkLCrBF92Njeu3tQjIZ+r2A8C3j0HSBHeXzqTM8+xJDy?=
 =?us-ascii?Q?17dLrJ9GIF5ubphL/n0IG3lwqqljKr7TOaMIuXLGqfP0rW/R2u3Yq5EV7Okn?=
 =?us-ascii?Q?r7mNyQBkKomM1ckVsjraIU92M+MRfXpSAD/NHs6kPWgG4vPRfMLp3HCiEKKh?=
 =?us-ascii?Q?cfNBHl2QvwgF4gMglYflRz7bTTlbPbIzy7WvhKymZ3bjS8qcpftJs72c8DPE?=
 =?us-ascii?Q?pSRI/dcNKvMJS+aSDudDI8tVaK44RtFiD9Qwtd6qLu/5yrBNDhk4UOFrkPmp?=
 =?us-ascii?Q?iGiq7WWJHiMYdhTl8wYzPaDgMBoVcBjgfXscDMoES82bB5HkfxOCD461vdTe?=
 =?us-ascii?Q?Dg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <62AA994FEAE4F04CB4B7297E42CFC010@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5764e16d-576f-442e-c094-08da70a902dd
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2022 14:54:02.5904
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X56bj6edtEqXNXRCK5GTScQToo5rdZsBXPPAuSAIpPRusJlGDyik0r+r5pV9TAsRWoCnVIQk2uMhuQDGpnE6ew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB3752
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-28_06,2022-07-28_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 phishscore=0 spamscore=0 adultscore=0 suspectscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207280068
X-Proofpoint-GUID: LpeYMYZsX6pf9rywgSyAh5c3dhBCix72
X-Proofpoint-ORIG-GUID: LpeYMYZsX6pf9rywgSyAh5c3dhBCix72
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
> nfsd_setattr() now sets a security label if provided, and nfsv4 provides
> it in the 'open' and 'create' paths and the 'setattr' path.
> If setting the label failed (including because the kernel doesn't
> support labels), an error field in 'struct nfsd_attrs' is set, and the
> caller can respond.  The open/create callers clear
> FATTR4_WORD2_SECURITY_LABEL in the returned attr set in this case.
> The setattr caller returns the error.
>=20
> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
> fs/nfsd/nfs4proc.c |   61 +++++++++++++++--------------------------------=
-----
> fs/nfsd/vfs.c      |   29 +++----------------------
> fs/nfsd/vfs.h      |    4 ++-
> 3 files changed, 23 insertions(+), 71 deletions(-)
>=20
> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> index ee72c94732f0..83d2b645b0d6 100644
> --- a/fs/nfsd/nfs4proc.c
> +++ b/fs/nfsd/nfs4proc.c
> @@ -64,36 +64,6 @@ MODULE_PARM_DESC(nfsd4_ssc_umount_timeout,
> 		"idle msecs before unmount export from source server");
> #endif
>=20
> -#ifdef CONFIG_NFSD_V4_SECURITY_LABEL
> -#include <linux/security.h>
> -
> -static inline void
> -nfsd4_security_inode_setsecctx(struct svc_fh *resfh, struct xdr_netobj *=
label, u32 *bmval)
> -{
> -	struct inode *inode =3D d_inode(resfh->fh_dentry);
> -	int status;
> -
> -	inode_lock(inode);
> -	status =3D security_inode_setsecctx(resfh->fh_dentry,
> -		label->data, label->len);
> -	inode_unlock(inode);
> -
> -	if (status)
> -		/*
> -		 * XXX: We should really fail the whole open, but we may
> -		 * already have created a new file, so it may be too
> -		 * late.  For now this seems the least of evils:
> -		 */
> -		bmval[2] &=3D ~FATTR4_WORD2_SECURITY_LABEL;
> -
> -	return;
> -}
> -#else
> -static inline void
> -nfsd4_security_inode_setsecctx(struct svc_fh *resfh, struct xdr_netobj *=
label, u32 *bmval)
> -{ }
> -#endif
> -
> #define NFSDDBG_FACILITY		NFSDDBG_PROC
>=20
> static u32 nfsd_attrmask[] =3D {
> @@ -286,7 +256,10 @@ nfsd4_create_file(struct svc_rqst *rqstp, struct svc=
_fh *fhp,
> 		  struct svc_fh *resfhp, struct nfsd4_open *open)
> {
> 	struct iattr *iap =3D &open->op_iattr;
> -	struct nfsd_attrs attrs =3D { .iattr =3D iap };
> +	struct nfsd_attrs attrs =3D {
> +		.iattr =3D iap,
> +		.label =3D &open->op_label,
> +	};
> 	struct dentry *parent, *child;
> 	__u32 v_mtime, v_atime;
> 	struct inode *inode;
> @@ -407,6 +380,8 @@ nfsd4_create_file(struct svc_rqst *rqstp, struct svc_=
fh *fhp,
> set_attr:
> 	status =3D nfsd_create_setattr(rqstp, fhp, resfhp, &attrs);
>=20
> +	if (attrs.label_failed)
> +		open->op_bmval[2] &=3D ~FATTR4_WORD2_SECURITY_LABEL;
> out:
> 	fh_unlock(fhp);
> 	if (child && !IS_ERR(child))
> @@ -448,9 +423,6 @@ do_open_lookup(struct svc_rqst *rqstp, struct nfsd4_c=
ompound_state *cstate, stru
> 		status =3D nfsd4_create_file(rqstp, current_fh, *resfh, open);
> 		current->fs->umask =3D 0;
>=20
> -		if (!status && open->op_label.len)
> -			nfsd4_security_inode_setsecctx(*resfh, &open->op_label, open->op_bmva=
l);
> -
> 		/*
> 		 * Following rfc 3530 14.2.16, and rfc 5661 18.16.4
> 		 * use the returned bitmask to indicate which attributes
> @@ -788,7 +760,10 @@ nfsd4_create(struct svc_rqst *rqstp, struct nfsd4_co=
mpound_state *cstate,
> 	     union nfsd4_op_u *u)
> {
> 	struct nfsd4_create *create =3D &u->create;
> -	struct nfsd_attrs attrs =3D { .iattr =3D &create->cr_iattr };
> +	struct nfsd_attrs attrs =3D {
> +		.iattr =3D &create->cr_iattr,
> +		.label =3D &create->cr_label,
> +	};
> 	struct svc_fh resfh;
> 	__be32 status;
> 	dev_t rdev;
> @@ -860,8 +835,8 @@ nfsd4_create(struct svc_rqst *rqstp, struct nfsd4_com=
pound_state *cstate,
> 	if (status)
> 		goto out;
>=20
> -	if (create->cr_label.len)
> -		nfsd4_security_inode_setsecctx(&resfh, &create->cr_label, create->cr_b=
mval);
> +	if (attrs.label_failed)
> +		create->cr_bmval[2] &=3D ~FATTR4_WORD2_SECURITY_LABEL;
>=20
> 	if (create->cr_acl !=3D NULL)
> 		do_set_nfs4_acl(rqstp, &resfh, create->cr_acl,
> @@ -1144,7 +1119,10 @@ nfsd4_setattr(struct svc_rqst *rqstp, struct nfsd4=
_compound_state *cstate,
> 	      union nfsd4_op_u *u)
> {
> 	struct nfsd4_setattr *setattr =3D &u->setattr;
> -	struct nfsd_attrs attrs =3D { .iattr =3D &setattr->sa_iattr };
> +	struct nfsd_attrs attrs =3D {
> +		.iattr =3D &setattr->sa_iattr,
> +		.label =3D &setattr->sa_label,
> +	};
> 	__be32 status =3D nfs_ok;
> 	int err;
>=20
> @@ -1172,13 +1150,10 @@ nfsd4_setattr(struct svc_rqst *rqstp, struct nfsd=
4_compound_state *cstate,
> 					    setattr->sa_acl);
> 	if (status)
> 		goto out;
> -	if (setattr->sa_label.len)
> -		status =3D nfsd4_set_nfs4_label(rqstp, &cstate->current_fh,
> -				&setattr->sa_label);
> -	if (status)
> -		goto out;
> 	status =3D nfsd_setattr(rqstp, &cstate->current_fh, &attrs,
> 				0, (time64_t)0);
> +	if (!status)
> +		status =3D attrs.label_failed;

/home/cel/src/linux/klimt/fs/nfsd/nfs4proc.c:1156:24: warning: incorrect ty=
pe in assignment (different base types)
/home/cel/src/linux/klimt/fs/nfsd/nfs4proc.c:1156:24:    expected restricte=
d __be32 [assigned] [usertype] status
/home/cel/src/linux/klimt/fs/nfsd/nfs4proc.c:1156:24:    got int [addressab=
le] label_failed

Let's make these a __be32 nfserr status code instead.


> out:
> 	fh_drop_write(&cstate->current_fh);
> 	return status;
> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index 91c9ea09f921..e7a18bedf499 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -458,6 +458,9 @@ nfsd_setattr(struct svc_rqst *rqstp, struct svc_fh *f=
hp,
> 	host_err =3D notify_change(&init_user_ns, dentry, iap, NULL);
>=20
> out_unlock:
> +	if (attr->label && attr->label->len)
> +		attr->label_failed =3D security_inode_setsecctx(
> +			dentry, attr->label->data, attr->label->len);
> 	fh_unlock(fhp);
> 	if (size_change)
> 		put_write_access(inode);
> @@ -496,32 +499,6 @@ int nfsd4_is_junction(struct dentry *dentry)
> 		return 0;
> 	return 1;
> }
> -#ifdef CONFIG_NFSD_V4_SECURITY_LABEL
> -__be32 nfsd4_set_nfs4_label(struct svc_rqst *rqstp, struct svc_fh *fhp,
> -		struct xdr_netobj *label)
> -{
> -	__be32 error;
> -	int host_error;
> -	struct dentry *dentry;
> -
> -	error =3D fh_verify(rqstp, fhp, 0 /* S_IFREG */, NFSD_MAY_SATTR);
> -	if (error)
> -		return error;
> -
> -	dentry =3D fhp->fh_dentry;
> -
> -	inode_lock(d_inode(dentry));
> -	host_error =3D security_inode_setsecctx(dentry, label->data, label->len=
);
> -	inode_unlock(d_inode(dentry));
> -	return nfserrno(host_error);
> -}
> -#else
> -__be32 nfsd4_set_nfs4_label(struct svc_rqst *rqstp, struct svc_fh *fhp,
> -		struct xdr_netobj *label)
> -{
> -	return nfserr_notsupp;
> -}
> -#endif
>=20
> static struct nfsd4_compound_state *nfsd4_get_cstate(struct svc_rqst *rqs=
tp)
> {
> diff --git a/fs/nfsd/vfs.h b/fs/nfsd/vfs.h
> index f3f43ca3ac6b..8464e04af1ea 100644
> --- a/fs/nfsd/vfs.h
> +++ b/fs/nfsd/vfs.h
> @@ -44,6 +44,8 @@ typedef int (*nfsd_filldir_t)(void *, const char *, int=
, loff_t, u64, unsigned);
> /* nfsd/vfs.c */
> struct nfsd_attrs {
> 	struct iattr *iattr;
> +	struct xdr_netobj *label;
> +	int label_failed;
> };
>=20
> int		nfsd_cross_mnt(struct svc_rqst *rqstp, struct dentry **dpp,
> @@ -57,8 +59,6 @@ __be32		nfsd_setattr(struct svc_rqst *, struct svc_fh *=
,
> 				struct nfsd_attrs *, int, time64_t);
> int nfsd_mountpoint(struct dentry *, struct svc_export *);
> #ifdef CONFIG_NFSD_V4
> -__be32          nfsd4_set_nfs4_label(struct svc_rqst *, struct svc_fh *,
> -		    struct xdr_netobj *);
> __be32		nfsd4_vfs_fallocate(struct svc_rqst *, struct svc_fh *,
> 				    struct file *, loff_t, loff_t, int);
> __be32		nfsd4_clone_file_range(struct svc_rqst *rqstp,
>=20
>=20

--
Chuck Lever



