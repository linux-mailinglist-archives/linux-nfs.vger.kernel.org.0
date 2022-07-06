Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52A0C568F2B
	for <lists+linux-nfs@lfdr.de>; Wed,  6 Jul 2022 18:29:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233546AbiGFQ33 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 6 Jul 2022 12:29:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233324AbiGFQ31 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 6 Jul 2022 12:29:27 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82CC522BCB
        for <linux-nfs@vger.kernel.org>; Wed,  6 Jul 2022 09:29:26 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 266GDKjl009659;
        Wed, 6 Jul 2022 16:29:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=PP38Q1RLluAchp1Hy+NP5DvB0oRG127Yfn5GwVZ10/o=;
 b=SGoDnNpWNdbfO5mYvd7FoSI48xFUaOUUPrXRShnumkmJ7S+XxxqdZjnnUS3qLASDSB3G
 w1n4DHUjSRG1G4IACwgSxtixF+PuLCO6oCtdsqAJPuRxIHpG9ip+Jjhr47/FuH0EVOtk
 R5ef0QHL1ZtDmlxUdZalPPerIOpmItQ4XS/nJzwtrO1cRAXaPX0F/2xajnJhpGIL/C71
 wFb4IgGDW+ug4LeOWKSklp1NlroSNQ2lFn9/jTGme6PDw4iEw/7rIpJ0Au4pJtoZjzAN
 K2GvWW5R1p+Jn9Iict7cAyOQtx58Rd3Wv+zDtWBQWIgMpa0HtpCMBJs8GeIahAV1BBH4 ZQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3h4ubyam5r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Jul 2022 16:29:20 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 266GBvDG004856;
        Wed, 6 Jul 2022 16:29:19 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2044.outbound.protection.outlook.com [104.47.66.44])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3h4udeq1tn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Jul 2022 16:29:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NnkJDgpTm+IZM8aZE3Jg45e41NK5EvXW8Qky8C7+IJdMainR1008ME6HpPK8tkwsYTrjCRJ/11Duhtn9FpMTlO5Eqb732huq6/nrLRv4kJLIot+FfSDE4BgnzUJGsaVoJ0kKgvLhvx8WOORYZcGy24sNC3pRIxv5DAM5AqZyYVSVYV8VSzynKzOms6yEx7nFqK8NZRgVEhwCmeH5kwdlpMrpxfn2I+rpLMRzvSjRY804pojXpeFvExd2Zqr2lf5S/d0nz9hLHxqE8NOpdzXGozkG+Q66jWXN7GPWz81CfIrGizP4PvcvNnjnlER95rrLfhYxjQ3MplqaOWyRMbqGWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PP38Q1RLluAchp1Hy+NP5DvB0oRG127Yfn5GwVZ10/o=;
 b=fFfGUIoTGezDi+Ku39MS8gwKXCsVnAIl9dE2HyaqHCL09Mnll+bq163H415Rx7Hsc16f2j3PdZ0PrjNNFJaFH8fnU9PBgOFPYyAEdqTKPI/nKtWMz1CAEDYFFDbMOO7eAugH9dpoUt+K5+WnJqz5hVS5aPnrZ562Trxfykak8ZFJ4Dvwsq/n2EAkHoqhj7oqYpgfO55VnZuo/giZsxovMuRHILzdGqeC2raiG53I76Lx5oFoFNt2skPucSOisofBPUobuRrcQosd44gRjNsUlYc7UIKBwWUAPBh6Uq8kfErszUH2/DJj2chcHSfXk+n0bVIryEtOvOh7Tz48WS/a7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PP38Q1RLluAchp1Hy+NP5DvB0oRG127Yfn5GwVZ10/o=;
 b=ambjgtihe4y0sHXr52Lfdi2z6WldRq35/DJ++hIoTAkENXGHjd3l6kpeWQX541Z8LdJExTVzQqy4jyweuo2+yEsv9dSeZhktzUH4AT6mQznjlRU8z1H3KTUZHH+Y5qaHoMd7fr8vKjGM8DX0bj3olGmNA2VZeJroXqPc2UXzoOI=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DM8PR10MB5478.namprd10.prod.outlook.com (2603:10b6:8:33::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5395.15; Wed, 6 Jul 2022 16:29:17 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::9920:1ac4:2d14:e703]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::9920:1ac4:2d14:e703%5]) with mapi id 15.20.5395.021; Wed, 6 Jul 2022
 16:29:17 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Neil Brown <neilb@suse.de>
CC:     Jeff Layton <jlayton@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 2/8] NFSD: change nfsd_create() to unlock directory before
 returning.
Thread-Topic: [PATCH 2/8] NFSD: change nfsd_create() to unlock directory
 before returning.
Thread-Index: AQHYkO+tYjl2n4algkWhJP7bk+7F+K1xiTOA
Date:   Wed, 6 Jul 2022 16:29:17 +0000
Message-ID: <2B1F489F-BBF1-47E0-A370-6D91D8E8CF4C@oracle.com>
References: <165708033167.1940.3364591321728458949.stgit@noble.brown>
 <165708109257.1940.11051756818329976731.stgit@noble.brown>
In-Reply-To: <165708109257.1940.11051756818329976731.stgit@noble.brown>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.100.31)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fe1ac435-3bfe-44fc-727f-08da5f6cac25
x-ms-traffictypediagnostic: DM8PR10MB5478:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: G87FV9cwljc95kEwTpdphe2MicXgFPowYzjpHYYny4hxTGYgi9/UuSis0P9+wpn0733F4YC8svIOho18/IhLBF6KLRWU3TOZPnpwZaatM3+1ouQ/Td7uUgfI5NFWbVUby0rvVcGWErFoACCgeJNOLEQ958ZWoeI6L9Od6+VIUnWjgowla+/44u1QVgiewLMg3S7j/cvpdA2bavssKmnz4gnf+OXK8kwwjiNwOpzbSOwYP39wuMo32sEISxLHdNp/AF0Mz+PRMhxeceRg6MCeYi8/QzHLh7x5RYK77inEbBt/UCyUVNrEcxMYTs7F1LlCTwtaUN0MUIUAcNH0qwBOJGM1MFUpsfWpZ5pHqI+aL5upZX+SrYqFZQD8xNQBGWiuwM4G9W9rMJlpQizV8/ItG6vJ2Ni5MP3x8HOaLacw9w5C2j6qPbR2Z3sIxGq8DWONi460VjDMir1eH9rQ67i3pUe+Ofaij0DqHkEDFHVEeDjnFQYxre+Mj2icvStCX5QUNMEjpm0jdv4qybOvekRj8WvLhPW9uO1Du6V5bXxV0SoDge1J3LSM06Rcc2N/pK88J710kUjiVC25xg1jFAliI4R3hibLWiaLBsmKE+7COs/lwokuHB2fyxhuI1fmeCzVDVBq8wLyTVVMV0diriTudpvFZtZ5fuFy0QcIbvibjCODX1PLqjjG9VUfCm/WyltIxgDATh7nYvteD4D9bO7zK5xfNc3aj4k1/2KOw0LDmY2ONjOyUIo+iYM98S8Vg8dW0Zj6Gb+u9YoNttdtRkdnz+ZuauhyitJ9UH8S1EN6YmlBMDKRMUggCcZq4oc4IKee+5vSdrNhtADOwmBJjtfLcI165CTEb1z/V7ruHsI2IDw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(366004)(376002)(396003)(136003)(346002)(6916009)(54906003)(38070700005)(122000001)(316002)(86362001)(8936002)(30864003)(5660300002)(64756008)(83380400001)(4326008)(8676002)(66556008)(66946007)(76116006)(91956017)(26005)(6512007)(36756003)(2616005)(66446008)(6486002)(38100700002)(478600001)(2906002)(71200400001)(53546011)(41300700001)(33656002)(66476007)(6506007)(186003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?fEwWQ8oAPGMPRv7qWNomZi1dAlXr6JB+YN/KwyT4vAXw3GBhnUzDxqrBRkaG?=
 =?us-ascii?Q?uCVqg2kkXiZm1ala1dWVf1z5xUy9wKs1HMFI7QGbiULP6KFnw84XKp61rEf7?=
 =?us-ascii?Q?sPwy/j2b9vVuU1BOoHu0LdOvw1tB787TpQMeSzebZzIsJMGAr1pD7G8o+jEm?=
 =?us-ascii?Q?3YZYe2v0d9peAOdjR/13KLn03d6xSpRoYq6hBXFO2Uau53qz2IeDSHy2lBHb?=
 =?us-ascii?Q?kD6XZc0eBb00JIlwAUNhn1CR/7+SZevo1YKCA3c7hFMyxecI5JIuD6jqk7uW?=
 =?us-ascii?Q?+sjBHH5gXdAh/aqhTZb1G0MCNQ5yw+kE1wvRjJBlpwetaTW1L5mzXPZ0h9b3?=
 =?us-ascii?Q?qUKYOqVOQq7aupnsDt7IwEZt+uk61NlZozUrZ58GqG7C7QYZyFvjsJzqvq+D?=
 =?us-ascii?Q?YhRRKQjLDtZ70tLLZ31NfH2LJEET0OCFGpzrQ5jHZaMIPVbBmDzTp+WvAjsS?=
 =?us-ascii?Q?rnnFztDzDg6UrolM9I03ww3Ncbhpn3EWhhCyreWlta9DG5Hig43MiQ8ARVOh?=
 =?us-ascii?Q?VA0wL1m+z8IhiRigFjLU/mUq8ktsdXbKnOKTf8Ogz0FYBTZ6g1PDXegEhgA9?=
 =?us-ascii?Q?kv0hOLq6JYO6TDqia0G5y0ZttlcWh9UARcmGJbx3P+AuhEz0FVezkLXFEq7u?=
 =?us-ascii?Q?+wbf3n/GwyocrNrPIfaGvxbujSc7fOEIl3GxFHs4GTHuuuEgTu0e8/x2btrX?=
 =?us-ascii?Q?ZTwHn0fQdiVo98pftSaf+xKjWZyr1T/wSjFiaeU8+6qW40C1foJsJn8eMMRZ?=
 =?us-ascii?Q?4fi6Zn6+Ilwsad/xPk0PSNGFCXyjqP/MSbD2v5blH6SPAxid4BRD691YUuuI?=
 =?us-ascii?Q?CL4dMsBlztRXq4Uoz3qZicUYoKCf+9Uen/lp8SAmZL4c6zdf36bhxX0lUPCQ?=
 =?us-ascii?Q?wkUaD3JpdBYehq8N6SjRJagsgdxuQnIVjNMC2St5uR3jzfx3hpmfxLOmW9Sc?=
 =?us-ascii?Q?Y1BsMfCABcFynT3H5gI2EEOQKhvfw9PDZQf0c0pmv//ssM/UxRPPJXRPCQsI?=
 =?us-ascii?Q?TKWwGihm3U6PsARvRVRChAE37K2urqnm5Bq63f9DHM8XCTQXaX0MCe7e3buM?=
 =?us-ascii?Q?yhZ9wU6pbgMD3E61yfHZy8A3+BWXLrhJBfQ2gQENg+lFvVtaaVl+DHmXVg5d?=
 =?us-ascii?Q?mEFdHAUvrFyPctzZMXe+9j/oc9sfEXa92pJ2h8yERDPzsGcD8maz5dWi/jyo?=
 =?us-ascii?Q?j2oLOsciv+w1/ap3goAxj6Qi99s/vWy9md8wTBQttLTzwNP3YFyFnVSUTIQp?=
 =?us-ascii?Q?uBsYbdZwVQ8L+dQnEk00Tlos3P0dDgrQ0BvxymFl4wxnz/5SaMx0qS+YzSdf?=
 =?us-ascii?Q?sRyaXcVY6J3S1CCBEZHf+6lXQs1YQHkE7kJwqtV2qptZli8s1dChStLqeHqA?=
 =?us-ascii?Q?AW3KtKyOkK7EQTR/cjRYAbtgtzrAj+oKtW49HOxpwCY2ris2tQA+azE1yTPv?=
 =?us-ascii?Q?0WMcLBH+MgAIBjtriIgiOf1p+NAfUoja+vJ0/uVxmI1wOo43lKa/JXCz+tM3?=
 =?us-ascii?Q?WmqW/YaVB+DbkGfe6+QTd4RXeUwxBTz4/b/uW4hsJsaWA+xFR+Jqp89rB7Hw?=
 =?us-ascii?Q?48/an41HCr16KioFBRmgGcykekXgk/c1t4f+RcNrWJIbn86t2EPiEJGnKpGC?=
 =?us-ascii?Q?+w=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4322094953E244409EBA35E258CB55D5@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe1ac435-3bfe-44fc-727f-08da5f6cac25
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2022 16:29:17.5432
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Eur1lSynoY64QFryZilS1iGPF++IySB4Opmyj7DmMzD6kSLUo4VAEqpkCFq4M94xGB2bAYz3NYrt1Nxagh84kA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR10MB5478
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-07-06_09:2022-06-28,2022-07-06 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0 spamscore=0
 malwarescore=0 mlxlogscore=999 phishscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207060065
X-Proofpoint-ORIG-GUID: XPIGa_hcPaVr3UTJYhyXowLABbSzeGNG
X-Proofpoint-GUID: XPIGa_hcPaVr3UTJYhyXowLABbSzeGNG
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
> nfsd_create() usually exits with the directory still locked.  This
> relies on other code to unlock the directory.  Planned future patches
> will change how directory locking works so the unlock step may be less
> trivial.  It is cleaner to have lock and unlock in the same function.
>=20
> nfsd4_create() performs some extra changes after the creation and before
> the unlock - setting security label and an ACL.  To allow for these to
> still be done while locked, we create a function nfsd4_post_create() and
> pass it to nfsd_create() when needed.
>=20
> nfsd_symlink() DOES usually unlock the directory, but nfsd4_create() may
> add a label or ACL - with the directory unlocked.  I don't think symlinks
> have ACLs and don't know if they can have labels, so I don't know if
> this is of any practical consequence.  For consistency nfsd_symlink() is
> changed to accept the same callback and call it if given.
>=20
> nfsd_symlink() didn't unlock the directory if lookup_one_len() gave an
> error.  This is untidy and potentially confusing, and has now been
> fixed.  It isn't a practical problem as an eventual fh_put() will unlock
> if needed.

I would like confirmation that NFSv4 symlinks cannot have ACLs
or security labels before committing to changing nfsd_symlink()
too. I can have a look at specifications and ask around.


> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
> fs/nfsd/nfs3proc.c |   11 ++++++-----
> fs/nfsd/nfs4proc.c |   38 ++++++++++++++++++++++++--------------
> fs/nfsd/nfsproc.c  |    5 +++--
> fs/nfsd/vfs.c      |   40 +++++++++++++++++++++++++++-------------
> fs/nfsd/vfs.h      |   11 ++++++++---
> 5 files changed, 68 insertions(+), 37 deletions(-)
>=20
> diff --git a/fs/nfsd/nfs3proc.c b/fs/nfsd/nfs3proc.c
> index 981a3a7a6e16..38255365ef71 100644
> --- a/fs/nfsd/nfs3proc.c
> +++ b/fs/nfsd/nfs3proc.c
> @@ -378,8 +378,8 @@ nfsd3_proc_mkdir(struct svc_rqst *rqstp)
> 	fh_copy(&resp->dirfh, &argp->fh);
> 	fh_init(&resp->fh, NFS3_FHSIZE);
> 	resp->status =3D nfsd_create(rqstp, &resp->dirfh, argp->name, argp->len,
> -				   &argp->attrs, S_IFDIR, 0, &resp->fh);
> -	fh_unlock(&resp->dirfh);
> +				   &argp->attrs, S_IFDIR, 0, &resp->fh,
> +				   NULL, NULL);
> 	return rpc_success;
> }
>=20
> @@ -414,7 +414,8 @@ nfsd3_proc_symlink(struct svc_rqst *rqstp)
> 	fh_copy(&resp->dirfh, &argp->ffh);
> 	fh_init(&resp->fh, NFS3_FHSIZE);
> 	resp->status =3D nfsd_symlink(rqstp, &resp->dirfh, argp->fname,
> -				    argp->flen, argp->tname, &resp->fh);
> +				    argp->flen, argp->tname, &resp->fh,
> +				    NULL, NULL);
> 	kfree(argp->tname);
> out:
> 	return rpc_success;
> @@ -453,8 +454,8 @@ nfsd3_proc_mknod(struct svc_rqst *rqstp)
>=20
> 	type =3D nfs3_ftypes[argp->ftype];
> 	resp->status =3D nfsd_create(rqstp, &resp->dirfh, argp->name, argp->len,
> -				   &argp->attrs, type, rdev, &resp->fh);
> -	fh_unlock(&resp->dirfh);
> +				   &argp->attrs, type, rdev, &resp->fh,
> +				   NULL, NULL);
> out:
> 	return rpc_success;
> }
> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> index 60591ceb4985..3279daab909d 100644
> --- a/fs/nfsd/nfs4proc.c
> +++ b/fs/nfsd/nfs4proc.c
> @@ -780,6 +780,18 @@ nfsd4_commit(struct svc_rqst *rqstp, struct nfsd4_co=
mpound_state *cstate,
> 			     (__be32 *)commit->co_verf.data);
> }
>=20
> +static void nfsd4_post_create(struct svc_fh *fh, void *vcreate)
> +{
> +	struct nfsd4_create *create =3D vcreate;
> +
> +	if (create->cr_label.len)
> +		nfsd4_security_inode_setsecctx(fh, &create->cr_label,
> +					       create->cr_bmval);
> +
> +	if (create->cr_acl !=3D NULL)
> +		do_set_nfs4_acl(fh, create->cr_acl, create->cr_bmval);
> +}
> +
> static __be32
> nfsd4_create(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
> 	     union nfsd4_op_u *u)
> @@ -805,7 +817,8 @@ nfsd4_create(struct svc_rqst *rqstp, struct nfsd4_com=
pound_state *cstate,
> 	case NF4LNK:
> 		status =3D nfsd_symlink(rqstp, &cstate->current_fh,
> 				      create->cr_name, create->cr_namelen,
> -				      create->cr_data, &resfh);
> +				      create->cr_data, &resfh,
> +				      nfsd4_post_create, create);
> 		break;
>=20
> 	case NF4BLK:
> @@ -816,7 +829,8 @@ nfsd4_create(struct svc_rqst *rqstp, struct nfsd4_com=
pound_state *cstate,
> 			goto out_umask;
> 		status =3D nfsd_create(rqstp, &cstate->current_fh,
> 				     create->cr_name, create->cr_namelen,
> -				     &create->cr_iattr, S_IFBLK, rdev, &resfh);
> +				     &create->cr_iattr, S_IFBLK, rdev, &resfh,
> +				     nfsd4_post_create, create);
> 		break;
>=20
> 	case NF4CHR:
> @@ -827,26 +841,30 @@ nfsd4_create(struct svc_rqst *rqstp, struct nfsd4_c=
ompound_state *cstate,
> 			goto out_umask;
> 		status =3D nfsd_create(rqstp, &cstate->current_fh,
> 				     create->cr_name, create->cr_namelen,
> -				     &create->cr_iattr, S_IFCHR, rdev, &resfh);
> +				     &create->cr_iattr, S_IFCHR, rdev, &resfh,
> +				     nfsd4_post_create, create);
> 		break;
>=20
> 	case NF4SOCK:
> 		status =3D nfsd_create(rqstp, &cstate->current_fh,
> 				     create->cr_name, create->cr_namelen,
> -				     &create->cr_iattr, S_IFSOCK, 0, &resfh);
> +				     &create->cr_iattr, S_IFSOCK, 0, &resfh,
> +				     nfsd4_post_create, create);
> 		break;
>=20
> 	case NF4FIFO:
> 		status =3D nfsd_create(rqstp, &cstate->current_fh,
> 				     create->cr_name, create->cr_namelen,
> -				     &create->cr_iattr, S_IFIFO, 0, &resfh);
> +				     &create->cr_iattr, S_IFIFO, 0, &resfh,
> +				     nfsd4_post_create, create);
> 		break;
>=20
> 	case NF4DIR:
> 		create->cr_iattr.ia_valid &=3D ~ATTR_SIZE;
> 		status =3D nfsd_create(rqstp, &cstate->current_fh,
> 				     create->cr_name, create->cr_namelen,
> -				     &create->cr_iattr, S_IFDIR, 0, &resfh);
> +				     &create->cr_iattr, S_IFDIR, 0, &resfh,
> +				     nfsd4_post_create, create);
> 		break;
>=20
> 	default:
> @@ -856,14 +874,6 @@ nfsd4_create(struct svc_rqst *rqstp, struct nfsd4_co=
mpound_state *cstate,
> 	if (status)
> 		goto out;
>=20
> -	if (create->cr_label.len)
> -		nfsd4_security_inode_setsecctx(&resfh, &create->cr_label, create->cr_b=
mval);
> -
> -	if (create->cr_acl !=3D NULL)
> -		do_set_nfs4_acl(&resfh, create->cr_acl,
> -				create->cr_bmval);
> -
> -	fh_unlock(&cstate->current_fh);
> 	set_change_info(&create->cr_cinfo, &cstate->current_fh);
> 	fh_dup2(&cstate->current_fh, &resfh);
> out:
> diff --git a/fs/nfsd/nfsproc.c b/fs/nfsd/nfsproc.c
> index fcdab8a8a41f..a25b8e321662 100644
> --- a/fs/nfsd/nfsproc.c
> +++ b/fs/nfsd/nfsproc.c
> @@ -493,7 +493,7 @@ nfsd_proc_symlink(struct svc_rqst *rqstp)
>=20
> 	fh_init(&newfh, NFS_FHSIZE);
> 	resp->status =3D nfsd_symlink(rqstp, &argp->ffh, argp->fname, argp->flen=
,
> -				    argp->tname, &newfh);
> +				    argp->tname, &newfh, NULL, NULL);
>=20
> 	kfree(argp->tname);
> 	fh_put(&argp->ffh);
> @@ -522,7 +522,8 @@ nfsd_proc_mkdir(struct svc_rqst *rqstp)
> 	argp->attrs.ia_valid &=3D ~ATTR_SIZE;
> 	fh_init(&resp->fh, NFS_FHSIZE);
> 	resp->status =3D nfsd_create(rqstp, &argp->fh, argp->name, argp->len,
> -				   &argp->attrs, S_IFDIR, 0, &resp->fh);
> +				   &argp->attrs, S_IFDIR, 0, &resp->fh,
> +				   NULL, NULL);
> 	fh_put(&argp->fh);
> 	if (resp->status !=3D nfs_ok)
> 		goto out;
> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index d79db56475d4..1e7ca39e8a49 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -1366,8 +1366,10 @@ nfsd_create_locked(struct svc_rqst *rqstp, struct =
svc_fh *fhp,
>  */
> __be32
> nfsd_create(struct svc_rqst *rqstp, struct svc_fh *fhp,
> -		char *fname, int flen, struct iattr *iap,
> -		int type, dev_t rdev, struct svc_fh *resfhp)
> +	    char *fname, int flen, struct iattr *iap,
> +	    int type, dev_t rdev, struct svc_fh *resfhp,
> +	    void (*post_create)(struct svc_fh *fh, void *data),
> +	    void *data)
> {
> 	struct dentry	*dentry, *dchild =3D NULL;
> 	__be32		err;
> @@ -1389,8 +1391,10 @@ nfsd_create(struct svc_rqst *rqstp, struct svc_fh =
*fhp,
> 	fh_lock_nested(fhp, I_MUTEX_PARENT);
> 	dchild =3D lookup_one_len(fname, dentry, flen);
> 	host_err =3D PTR_ERR(dchild);
> -	if (IS_ERR(dchild))
> -		return nfserrno(host_err);
> +	if (IS_ERR(dchild)) {
> +		err =3D nfserrno(host_err);
> +		goto out_unlock;
> +	}
> 	err =3D fh_compose(resfhp, fhp->fh_export, dchild, fhp);
> 	/*
> 	 * We unconditionally drop our ref to dchild as fh_compose will have
> @@ -1398,9 +1402,14 @@ nfsd_create(struct svc_rqst *rqstp, struct svc_fh =
*fhp,
> 	 */
> 	dput(dchild);
> 	if (err)
> -		return err;
> -	return nfsd_create_locked(rqstp, fhp, fname, flen, iap, type,
> -					rdev, resfhp);
> +		goto out_unlock;
> +	err =3D nfsd_create_locked(rqstp, fhp, fname, flen, iap, type,
> +				 rdev, resfhp);
> +	if (!err && post_create)
> +		post_create(resfhp, data);
> +out_unlock:
> +	fh_unlock(fhp);
> +	return err;
> }
>=20
> /*
> @@ -1447,9 +1456,11 @@ nfsd_readlink(struct svc_rqst *rqstp, struct svc_f=
h *fhp, char *buf, int *lenp)
>  */
> __be32
> nfsd_symlink(struct svc_rqst *rqstp, struct svc_fh *fhp,
> -				char *fname, int flen,
> -				char *path,
> -				struct svc_fh *resfhp)
> +	     char *fname, int flen,
> +	     char *path,
> +	     struct svc_fh *resfhp,
> +	     void (*post_create)(struct svc_fh *fh, void *data),
> +	     void *data)
> {
> 	struct dentry	*dentry, *dnew;
> 	__be32		err, cerr;
> @@ -1474,12 +1485,12 @@ nfsd_symlink(struct svc_rqst *rqstp, struct svc_f=
h *fhp,
> 	dentry =3D fhp->fh_dentry;
> 	dnew =3D lookup_one_len(fname, dentry, flen);
> 	host_err =3D PTR_ERR(dnew);
> -	if (IS_ERR(dnew))
> +	if (IS_ERR(dnew)) {
> +		fh_unlock(fhp);
> 		goto out_nfserr;
> -
> +	}
> 	host_err =3D vfs_symlink(&init_user_ns, d_inode(dentry), dnew, path);
> 	err =3D nfserrno(host_err);
> -	fh_unlock(fhp);
> 	if (!err)
> 		err =3D nfserrno(commit_metadata(fhp));
>=20
> @@ -1488,6 +1499,9 @@ nfsd_symlink(struct svc_rqst *rqstp, struct svc_fh =
*fhp,
> 	cerr =3D fh_compose(resfhp, fhp->fh_export, dnew, fhp);
> 	dput(dnew);
> 	if (err=3D=3D0) err =3D cerr;
> +	if (!err && post_create)
> +		post_create(resfhp, data);
> +	fh_unlock(fhp);
> out:
> 	return err;
>=20
> diff --git a/fs/nfsd/vfs.h b/fs/nfsd/vfs.h
> index 26347d76f44a..9f4fd3060200 100644
> --- a/fs/nfsd/vfs.h
> +++ b/fs/nfsd/vfs.h
> @@ -66,8 +66,10 @@ __be32		nfsd_create_locked(struct svc_rqst *, struct s=
vc_fh *,
> 				char *name, int len, struct iattr *attrs,
> 				int type, dev_t rdev, struct svc_fh *res);
> __be32		nfsd_create(struct svc_rqst *, struct svc_fh *,
> -				char *name, int len, struct iattr *attrs,
> -				int type, dev_t rdev, struct svc_fh *res);
> +			    char *name, int len, struct iattr *attrs,
> +			    int type, dev_t rdev, struct svc_fh *res,
> +			    void (*post_create)(struct svc_fh *fh, void *data),
> +			    void *data);
> __be32		nfsd_access(struct svc_rqst *, struct svc_fh *, u32 *, u32 *);
> __be32		nfsd_create_setattr(struct svc_rqst *rqstp, struct svc_fh *fhp,
> 				struct svc_fh *resfhp, struct iattr *iap);
> @@ -111,7 +113,10 @@ __be32		nfsd_readlink(struct svc_rqst *, struct svc_=
fh *,
> 				char *, int *);
> __be32		nfsd_symlink(struct svc_rqst *, struct svc_fh *,
> 				char *name, int len, char *path,
> -				struct svc_fh *res);
> +				struct svc_fh *res,
> +				void (*post_create)(struct svc_fh *fh,
> +						    void *data),
> +				void *data);
> __be32		nfsd_link(struct svc_rqst *, struct svc_fh *,
> 				char *, int, struct svc_fh *);
> ssize_t		nfsd_copy_file_range(struct file *, u64,
>=20
>=20

--
Chuck Lever



