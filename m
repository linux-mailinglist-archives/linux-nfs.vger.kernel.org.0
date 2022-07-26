Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1539258133C
	for <lists+linux-nfs@lfdr.de>; Tue, 26 Jul 2022 14:40:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233594AbiGZMk2 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 26 Jul 2022 08:40:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232310AbiGZMk1 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 26 Jul 2022 08:40:27 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59C215F5F
        for <linux-nfs@vger.kernel.org>; Tue, 26 Jul 2022 05:40:26 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26QC3vR9007541;
        Tue, 26 Jul 2022 12:40:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=kWMSW47zfHAoH/kg77TXg+70MZYQdeOlw1gPrKizAqo=;
 b=XeImW6tX8zBft0/HqWQQodStdk2890O2ONKJV/B0uLORusohNG5EJ7k5V0g0tO8PSwYJ
 Ad37/CV5GJWWaXBqmYKMhxp937yF8AexzP4mWKFx+su2aRdqJt8cXjJHYBr/TC27AMKr
 yqgyZ3m1YjQfeFakfWQ2GLvofwgOJ4qW9kCdd1EDcvlE2wvJK096W37pG91Se8CcBhc5
 XVRd69mCaY9YZ9ZC/pYPSTUv2Bts7CHBRoYD3Ip7f3aE+zbZ175aHxR+O2R3aZSrntJU
 /DppnUMH8RWw7YWe2HuK7zUUAJhyIbAtd8xMhJKQ5nczV52gEdeT0dSTTjxI7qRM8Mmc cQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hg9a9ebv2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Jul 2022 12:40:14 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26QCUGJC006239;
        Tue, 26 Jul 2022 12:40:13 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2049.outbound.protection.outlook.com [104.47.66.49])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hh65behvv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Jul 2022 12:40:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A1HXrYLXlAu+hU+aIo+LqbATqSGxVjBpIT2KNtCGuXhHkq+0xbaWAJsj0OHMUwx1mEWRi1FKdV4mDazf1jcOo+Fy/F2JouB09YCPX1Dm3Uex0OjrkQPZXpe2hxTAXXDmOI4Qm8r2RvTwegSoMZAEWUFj3EXzKe7f0MrVXkP0khto+MohWKFRNKSkZd347v9llHHbE88DKGm+gauwN6khqVT20bWDHWlroMkJ9aOiyeBfLDAUxWHhbzlBDUcNBIE3upGTbh1H0E9ISMQJPck/QgX/HYiSRxPPJKIsvAbT8qNCYA/SyDi+/OzDG9V11Icu7wzKTxKoP3RAyXjve5xWQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kWMSW47zfHAoH/kg77TXg+70MZYQdeOlw1gPrKizAqo=;
 b=AttNSPi0WkMqPOG7KMvfpLP9FO39x9tH+/VmLCxX5h4ZPouXDoZx+6Zptoni2LGBs/3viz1TzlQwLNE738SqTvz6vyN5LqtxMhoIxzei2B5IP78ymP2Peg5Q8GiC609Ox61d6ZuhD0C4CLhXFWwRg8HKnp43X7/CbfKz8qtxoQ2k6zzaKClU6QUDZQdIlku8D6kK8ZG5OJnK2cGPEko6CnBoXo7VtqTadt1MLOGYXAktX2EEm1bKW8TFqlXJpUakB0qu8okDAjIG1gGB8hxz4lFYcj8tL0nNVmbEaR2O/a1fBtgFKJFLFvyC6viidokAokEYHm5ZWyKYYmaq1X7E1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kWMSW47zfHAoH/kg77TXg+70MZYQdeOlw1gPrKizAqo=;
 b=jPAecWZ7kOwIHPExOuZaKxodKH44x/dd4slII5VvOunb7t/l7JUQ6/PcQDzqkj+oAFHBdmLK5bTm+IQytPv+/UvIYpSzJCbSB6oSXL7G/nuZKhcLzg+ipkzElX92W+bkhUWH98SGPI3ylrTLQ4Pjq1FPHusOlsroFqR/Jqnalyw=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MWHPR10MB1325.namprd10.prod.outlook.com (2603:10b6:300:1e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.20; Tue, 26 Jul
 2022 12:40:11 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::8cc6:21c7:b3e7:5da6]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::8cc6:21c7:b3e7:5da6%8]) with mapi id 15.20.5458.025; Tue, 26 Jul 2022
 12:40:11 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Neil Brown <neilb@suse.de>
CC:     Jeff Layton <jlayton@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 04/13] NFSD: set attributes when creating symlinks
Thread-Topic: [PATCH 04/13] NFSD: set attributes when creating symlinks
Thread-Index: AQHYoLujfmoC23Q2SEegG+eOkJm9Ja2QmDgA
Date:   Tue, 26 Jul 2022 12:40:10 +0000
Message-ID: <A4671B71-ECAD-42BF-8B67-5C098FF36172@oracle.com>
References: <165881740958.21666.5904057696047278505.stgit@noble.brown>
 <165881793056.21666.12904500892707412393.stgit@noble.brown>
In-Reply-To: <165881793056.21666.12904500892707412393.stgit@noble.brown>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8f6dfd66-1426-4a8d-c852-08da6f03facc
x-ms-traffictypediagnostic: MWHPR10MB1325:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: j22AO796mweVDl5W1bGyLPj6aqRM2SP4nWnhsiS6ClpeEWRUQkckPTUWkgIhf/oSEf00a7LLzCLVKmyNn/BL3JKZbHapbnwEcCfBtoOaIH8ir5srhu3L4ykelFbKd4VhrgR2K+9unvIi3pKE18KClO6QrGomabADHpRyJp4NYvMLswlqZwNx08wQbaFlcxxT5OhuGY41J7zckaPaUGUx7GfG2G62kI6hvXt2/QPhF1XeCWIBQZu5cQ12lhrsctDxDT6KX8T/gXc4nBErpiXgBGv1mc6XALo1XbewO6VZnM+DgjOEIZzepnNDM5kslWXAEn3VJ8IEu2bfjhXXX4KxSaFCZX+L+jsV0pCRp1g1JBGiIIspUtFFQggZSHMUNwKs0V6hFNmVb1HtT9sSf+XL7Yh22vMn2vkYZ+UJKxZ6AnFi+oWVOjPec5sfuuFC4Hm5mu5kurj2pGSrie/k72MdHiSdgPBSr0NP28fdnALRc6PJeK5C68cOUAEAj62dDw0b++IKz1WYBWr6LK6HH5NKiXP0deENBf+kc1ZtXT+4NwCkbBp/8R3XQt+j4SqvMmyitpxZZVnsHqlKsMMCoWUY6U0iDuRMTkZpe6EIXcAe4l2hczuC6/5E7PNaiobkwnAFgEQ8TRllv7sm9j9VD4nIU/7fmLcVZsi2lYCJp0TBw1C66R57MY9TkO/rORoIPsTdzokf7bkoDpsByj0oi0fOsMx/eiG9BmyVy/hDW4Tf4wwyAnil55nNL+TP80qLaXYuzh+XQalOapyykLOLcpZ+znVKHIo2GdNy7VsnEBRZxv+Ya3ankzX6/fFvEl/669LN3Yddy+DyR8R/DMaMVRxTdQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(396003)(39860400002)(346002)(366004)(376002)(8676002)(66476007)(64756008)(91956017)(4326008)(76116006)(66446008)(66946007)(66556008)(5660300002)(122000001)(36756003)(38070700005)(2906002)(33656002)(8936002)(38100700002)(6486002)(2616005)(186003)(71200400001)(41300700001)(53546011)(6512007)(6506007)(86362001)(478600001)(6916009)(54906003)(83380400001)(316002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?K40aXwRgWjXSoInn2MvBVlPIrxbGr6tnoT3IB143IAf130WyAN7YZISDSyuR?=
 =?us-ascii?Q?0k1jLjYD1vEY/ZtVETmWBBfPID8Ui6oasxziz2sjOI8gc37Dpff4obXq+5L0?=
 =?us-ascii?Q?nYhibhVWFOChyFFDAbAkLgwlLPVM72W8o4j7NOQ7yPUgihSfqe3BA0JudIBj?=
 =?us-ascii?Q?5nsFK0vpAVtkkesMkoNu64IfH8ndD5w8urAMdgI/S++ds044+ssN24gfaw4A?=
 =?us-ascii?Q?gKqI+cE8Pg6gyHiU8imsjYPF1zSKm1arRb/W/3FjfOOMatvt9fCYy5Hx79KJ?=
 =?us-ascii?Q?K8OaAyetJbWSSZaQKfuF6mSf/mvVrhoraW/PVrCsEqIfnWmzL/VAl/RrVLzR?=
 =?us-ascii?Q?Xt9BK6djoh6W2v4J8++BQRVDedAbUpj9thwFoE62aEDz/rhp/vMjuqVC3BKF?=
 =?us-ascii?Q?EuPNse2cS2esEV9oUP/ovg/uSTwY3jtpQxWWwzl9opqh5c+XOb0Is75wQwu2?=
 =?us-ascii?Q?PVuz8eVXt/YTVHV2ihoDXJcGgm/TMbS7m9BKMSwLxOUOXjPFakanJX2l98Lq?=
 =?us-ascii?Q?hyh19VeBzp0qIre3iZGHTW6cTxMkyUUJuaRwh0LfLXmajsjeU5fxVIdsQlmj?=
 =?us-ascii?Q?mU3u0QXmSrSmGcHu4vk66u9T+x91pI0b2yYCZh4D9W6UfE/r369cj7hZcKdg?=
 =?us-ascii?Q?kLOn9GZdD7N5D/5dG6qN3ozVfkwlMZQ7csPFYATlDtxnUt1bUIAHwVjssChM?=
 =?us-ascii?Q?AlgQeAMSn81oYx5n37vAbuEIOa6iG7n4QaU2NDNNT1qFiaa0b83NOvDc8nyh?=
 =?us-ascii?Q?scLmPRWgMLoaObkTwPryAakiJed+JjUC7L382WoE7I0qKmuqehyZhnErv24D?=
 =?us-ascii?Q?6MWJMfzyFLrbEZwVhNcKW9pG7tH3HU05Txhj5n1bRAtVnAde8gTE0Cqxgvf7?=
 =?us-ascii?Q?FuVJXV6A7yeUzcmWdjQ40STRGvyBcqSbGZ1WcrztR9KJ+v0If5DfU/y8yDfa?=
 =?us-ascii?Q?Kj+J/+dHqLYM+fUeH9AjJ3Sy/Sck1Q1QuwBmUZyCsA0O2Dbz5jdr7HU1ubZQ?=
 =?us-ascii?Q?dPvUjcvgfBIl8MGy2P2YxaANvxT+5DvKYYSq3Vqfb4lZSACwhqYoY5lvWCQj?=
 =?us-ascii?Q?vCHIVzHT2YItLmp5f31dBSlVLsy9tR+ZyeCmzSp2m2HQwCDvpu6IYf00/nhO?=
 =?us-ascii?Q?7Y7YSJaujWpor3S4H7ktPHM7hlXvPSTrKw26lOZVf0DtMItmby+o8/0DliDc?=
 =?us-ascii?Q?69/GhojQJ/g4vqCK4kY5+BJ20RnS5DxsVaP2P0NXBqvKNNqG+KJfDteAGpdm?=
 =?us-ascii?Q?yUxGwW4ZdMIGiL8ynXC5kU3a8yufl3oaOGdIQ4l/un5ZvMFdlD346ONcKeoK?=
 =?us-ascii?Q?pLbu02KiSNPekD5LwwrDfxAfOIS2l/7cw+3ExTX313cvjXVDSazJP7kqXBJE?=
 =?us-ascii?Q?ZvKP2KWUtIgUc7fxRi9wDWDhRwjD6kb4AIIiiMdjZv6Vxmfj5RDsMBsd0blD?=
 =?us-ascii?Q?BqibpENf1HEQcEKRfa7bP2tXa+VY4ZUwDjx+G3Zd3FcalPLayyo/gnypSHJU?=
 =?us-ascii?Q?08kE+xrFhgFTxg/aDNLGCABouoQjjkXhMmzVlBYVhIGyJiJg8d1F8GAzSXmT?=
 =?us-ascii?Q?ZhtjLIBUHHHYICMO/I/cbFbZn92qFc5baWwxrmvGWqbE2/olDWJRuGLLIaTY?=
 =?us-ascii?Q?Exq4NQf/L4+h2SiPM4G5YK3TvuBrHi1No/dT+Vsjv2W7vd/WlCwqr5lnOf1v?=
 =?us-ascii?Q?B/PJMA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <EFD275BF2A6D7A49AA86028AD1E50330@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f6dfd66-1426-4a8d-c852-08da6f03facc
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jul 2022 12:40:10.9343
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IWXWZxqVVUaPEhXDpgs/+awsrjfpxbxrMfc4H/AJULw1rosZC8KrUTCvyDWtdqx2T2j7U42K0zzvtwrezbayxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1325
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-26_04,2022-07-26_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 phishscore=0
 spamscore=0 mlxlogscore=999 suspectscore=0 bulkscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207260048
X-Proofpoint-GUID: vqdlImbWxE8695Gnx6jB7oDM51IL_1jO
X-Proofpoint-ORIG-GUID: vqdlImbWxE8695Gnx6jB7oDM51IL_1jO
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
> The NFS protocol includes attributes when creating symlinks.
> Linux does store attributes for symlinks and allows them to be set,
> though they are not used for permission checking.
>=20
> NFSD currently doesn't set standard (struct iattr) attributes when
> creating symlinks, but for NFSv4 it does set ACLs and security labels.
> This is inconsistent.
>=20
> To improve consistency, pass the provided attributes into nfsd_symlink()
> and call nfsd_create_setattr() to set them.
>=20
> We ignore any error from nfsd_create_setattr().  It isn't really clear
> what should be done if a file is successfully created, but the
> attributes cannot be set.  NFS doesn't allow partial success to be
> reported.  Reporting failure is probably more misleading than reporting
> success, so the status is ignored.
>=20
> Signed-off-by: NeilBrown <neilb@suse.de>

While I was trying to get more information about how
security labels are supposed to be applied to symlinks,
Jeff, Bruce, and I had a brief private discussion about
it. Jeff has the impression that NFSD should not apply
ACLs/security labels to symlinks, and we believe that
would be somewhat of a change in behavior.

Now is a good time to hoist that private discussion to
the list, so I'm mentioning it here. I'm thinking it
would be appropriate to introduce that change in this
series, and probably right here in this patch, if we
agree that is the right thing to do going forward.

Otherwise, after a brief glance at the series, it looks
better to me than the previous approach. I will try to
dig in later this week so we can get this work merged at
the end of the upcoming merge window.


> ---
> fs/nfsd/nfs3proc.c |    3 ++-
> fs/nfsd/nfs4proc.c |    2 +-
> fs/nfsd/nfsproc.c  |    3 ++-
> fs/nfsd/vfs.c      |   11 ++++++-----
> fs/nfsd/vfs.h      |    5 +++--
> 5 files changed, 14 insertions(+), 10 deletions(-)
>=20
> diff --git a/fs/nfsd/nfs3proc.c b/fs/nfsd/nfs3proc.c
> index 289eb844d086..5e369096e42f 100644
> --- a/fs/nfsd/nfs3proc.c
> +++ b/fs/nfsd/nfs3proc.c
> @@ -391,6 +391,7 @@ nfsd3_proc_symlink(struct svc_rqst *rqstp)
> {
> 	struct nfsd3_symlinkargs *argp =3D rqstp->rq_argp;
> 	struct nfsd3_diropres *resp =3D rqstp->rq_resp;
> +	struct nfsd_attrs attrs =3D { .iattr =3D &argp->attrs };
>=20
> 	if (argp->tlen =3D=3D 0) {
> 		resp->status =3D nfserr_inval;
> @@ -417,7 +418,7 @@ nfsd3_proc_symlink(struct svc_rqst *rqstp)
> 	fh_copy(&resp->dirfh, &argp->ffh);
> 	fh_init(&resp->fh, NFS3_FHSIZE);
> 	resp->status =3D nfsd_symlink(rqstp, &resp->dirfh, argp->fname,
> -				    argp->flen, argp->tname, &resp->fh);
> +				    argp->flen, argp->tname, &attrs, &resp->fh);
> 	kfree(argp->tname);
> out:
> 	return rpc_success;
> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> index ba750d76f515..ee72c94732f0 100644
> --- a/fs/nfsd/nfs4proc.c
> +++ b/fs/nfsd/nfs4proc.c
> @@ -809,7 +809,7 @@ nfsd4_create(struct svc_rqst *rqstp, struct nfsd4_com=
pound_state *cstate,
> 	case NF4LNK:
> 		status =3D nfsd_symlink(rqstp, &cstate->current_fh,
> 				      create->cr_name, create->cr_namelen,
> -				      create->cr_data, &resfh);
> +				      create->cr_data, &attrs, &resfh);
> 		break;
>=20
> 	case NF4BLK:
> diff --git a/fs/nfsd/nfsproc.c b/fs/nfsd/nfsproc.c
> index 594d6f85c89f..d09d516188d2 100644
> --- a/fs/nfsd/nfsproc.c
> +++ b/fs/nfsd/nfsproc.c
> @@ -474,6 +474,7 @@ nfsd_proc_symlink(struct svc_rqst *rqstp)
> {
> 	struct nfsd_symlinkargs *argp =3D rqstp->rq_argp;
> 	struct nfsd_stat *resp =3D rqstp->rq_resp;
> +	struct nfsd_attrs attrs =3D { .iattr =3D &argp->attrs };
> 	struct svc_fh	newfh;
>=20
> 	if (argp->tlen > NFS_MAXPATHLEN) {
> @@ -495,7 +496,7 @@ nfsd_proc_symlink(struct svc_rqst *rqstp)
>=20
> 	fh_init(&newfh, NFS_FHSIZE);
> 	resp->status =3D nfsd_symlink(rqstp, &argp->ffh, argp->fname, argp->flen=
,
> -				    argp->tname, &newfh);
> +				    argp->tname, &attrs, &newfh);
>=20
> 	kfree(argp->tname);
> 	fh_put(&argp->ffh);
> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index a85dc4dd4f3a..91c9ea09f921 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -1451,9 +1451,9 @@ nfsd_readlink(struct svc_rqst *rqstp, struct svc_fh=
 *fhp, char *buf, int *lenp)
>  */
> __be32
> nfsd_symlink(struct svc_rqst *rqstp, struct svc_fh *fhp,
> -				char *fname, int flen,
> -				char *path,
> -				struct svc_fh *resfhp)
> +	     char *fname, int flen,
> +	     char *path, struct nfsd_attrs *attrs,
> +	     struct svc_fh *resfhp)
> {
> 	struct dentry	*dentry, *dnew;
> 	__be32		err, cerr;
> @@ -1483,13 +1483,14 @@ nfsd_symlink(struct svc_rqst *rqstp, struct svc_f=
h *fhp,
>=20
> 	host_err =3D vfs_symlink(&init_user_ns, d_inode(dentry), dnew, path);
> 	err =3D nfserrno(host_err);
> +	cerr =3D fh_compose(resfhp, fhp->fh_export, dnew, fhp);
> +	if (!err)
> +		nfsd_create_setattr(rqstp, fhp, resfhp, attrs);
> 	fh_unlock(fhp);
> 	if (!err)
> 		err =3D nfserrno(commit_metadata(fhp));
> -
> 	fh_drop_write(fhp);
>=20
> -	cerr =3D fh_compose(resfhp, fhp->fh_export, dnew, fhp);
> 	dput(dnew);
> 	if (err=3D=3D0) err =3D cerr;
> out:
> diff --git a/fs/nfsd/vfs.h b/fs/nfsd/vfs.h
> index 9bb0e3957982..f3f43ca3ac6b 100644
> --- a/fs/nfsd/vfs.h
> +++ b/fs/nfsd/vfs.h
> @@ -114,8 +114,9 @@ __be32		nfsd_vfs_write(struct svc_rqst *rqstp, struct=
 svc_fh *fhp,
> __be32		nfsd_readlink(struct svc_rqst *, struct svc_fh *,
> 				char *, int *);
> __be32		nfsd_symlink(struct svc_rqst *, struct svc_fh *,
> -				char *name, int len, char *path,
> -				struct svc_fh *res);
> +			     char *name, int len, char *path,
> +			     struct nfsd_attrs *attrs,
> +			     struct svc_fh *res);
> __be32		nfsd_link(struct svc_rqst *, struct svc_fh *,
> 				char *, int, struct svc_fh *);
> ssize_t		nfsd_copy_file_range(struct file *, u64,
>=20
>=20

--
Chuck Lever



