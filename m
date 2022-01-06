Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3442948680A
	for <lists+linux-nfs@lfdr.de>; Thu,  6 Jan 2022 17:59:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241479AbiAFQ7X (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 6 Jan 2022 11:59:23 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:22940 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241426AbiAFQ7W (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 6 Jan 2022 11:59:22 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 206GidcQ028035;
        Thu, 6 Jan 2022 16:59:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=dXHr8yWYbxsn2MwvhYcbEh1t0YZcoaDrh5kxh/z+PIM=;
 b=0DsTMlOH/IWR/foa3T0f6nU1706B/lvxUh39tgEm2UckmL1BfV63njNM3X/p15ceVo91
 hZFQBn6HOIow/Uw+kPN1OXalBnkYmqwLXPBLjGwE4jp2NEsRhRPBZImHM/q89ljCSlrA
 /ZmgaFnbqF+ZPjmK/AONjjO7/saLPjwZyn9KTbAsv/rDj0n9/ZfOObL+QuosuT9pLZxv
 VRFz97dIqt4eG+8+GS040GqDxlsoNmSNcb2GSRsbkW80vQcYKMgLZKfasf2H3w/qt/Rw
 EzRQhGOrRGBeKMDthk4sWxbqK0FYai7lrzcT5sc1Gh+L9voE+R7gVaSO6sj3RBqHE2Td 8Q== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ddmpdj6q4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Jan 2022 16:59:15 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 206GfLih179475;
        Thu, 6 Jan 2022 16:59:14 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2043.outbound.protection.outlook.com [104.47.57.43])
        by userp3020.oracle.com with ESMTP id 3ddmq73874-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Jan 2022 16:59:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AlSvpvo6E9x3gEG0u7MBDRxu3gPfeFEH4hG5M4Hjr3n0RZNKldI7LIZGfc7fnyurv6htYIKm3QjhlnDd6GvKhwwI8oYgezcw2LVt4C1l/wC7ASx/war3pemmDf0lUHPCZLiCZ0GGFxaLoV815/jZmF4cojF+tRxXSftLm0kwuLASiwYuZNNOkMfoq0otfNggEkcdh/5ZbmC6J+TDUDv0iuW7+NH5DZ8FsBucEwlwLRH2Kbr64I3UGuIvVKCrkv4ac6nJ98j29wvtsVRXMfzjUWreIoDT+/Z88pCw7Wl7UXK93eWspOv9fdb66hSwvAK2YQe7utMR5SVBbp8RqG9Oew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dXHr8yWYbxsn2MwvhYcbEh1t0YZcoaDrh5kxh/z+PIM=;
 b=V6RDNnHdHVg0fp5d+o3xgPmF2LKhu4zQeYmcM4qlVMKSBlBquBVJhohSEMNbZXLpWbUrDIE8PJPsGwSCvITjPAnPRaF+YalfXC8yhmgpn0X5vkchEdI7AqQmBtVrfwXNwlM4/tbVnm7TjkOeurtr+8ONOq/8XxJLEeWu8qgI2LvoeSG3X6yEW09LqI9ailUcm/35uIL7yjTNckI+NdbeKKcE5l1fKETWUNK42+6Wbs69YFvYpT3AZwfqWqCcKFPoabaAnyKvQf4sBK79Uojwnzi7QXFYXAxhUMvfTFW87nnZBV1L0KD6u+V8XZqFQzdmSO9uwDEof9wFO631IdbsJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dXHr8yWYbxsn2MwvhYcbEh1t0YZcoaDrh5kxh/z+PIM=;
 b=EPtvPvVMXwOn4/Viz+0aC43Xyt3wurudNCrFyiB8jVmpFCqjlHerpmwErOuEBunA7gWSSSoTsNdqcICJ6LsMBbcVRM53uUh0+6MZPuBOtDiWBPmtRCXNwxG73mf9VUeTltxmKpi96hsG535Wue6YPtlGh6QdXYdKbV17hYmHbwQ=
Received: from CH0PR10MB4858.namprd10.prod.outlook.com (2603:10b6:610:cb::17)
 by CH0PR10MB5290.namprd10.prod.outlook.com (2603:10b6:610:dc::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7; Thu, 6 Jan
 2022 16:59:12 +0000
Received: from CH0PR10MB4858.namprd10.prod.outlook.com
 ([fe80::241e:15fa:e7d8:dea7]) by CH0PR10MB4858.namprd10.prod.outlook.com
 ([fe80::241e:15fa:e7d8:dea7%8]) with mapi id 15.20.4867.009; Thu, 6 Jan 2022
 16:59:12 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Ondrej Valousek <ondrej.valousek.xm@renesas.com>
CC:     Bruce Fields <bfields@fieldses.org>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        "trondmy@kernel.org" <trondmy@kernel.org>
Subject: Re: [PATCH 0/8] Support btime and other NFSv4 specific attributes
Thread-Topic: [PATCH 0/8] Support btime and other NFSv4 specific attributes
Thread-Index: AQHX84hiLhmSszkEakGgj1Py+73p0qxR4CyAgAAALoCAAsPhgIAAAVsAgAAIb4CAAAQPgIABJyiAgABPWACAAAEoAIAAAncAgAACNICAAASeAIAAAOIAgAAVswCAAAzKAA==
Date:   Thu, 6 Jan 2022 16:59:12 +0000
Message-ID: <669919C2-79B9-46C8-B48A-4735CBD99C63@oracle.com>
References: <DU2PR10MB5096010E9570E2718198EDD5E14B9@DU2PR10MB5096.EURPRD10.PROD.OUTLOOK.COM>
 <20220105151008.GB24685@fieldses.org>
 <DU2PR10MB5096501FB8A162D18CF1F1F2E14B9@DU2PR10MB5096.EURPRD10.PROD.OUTLOOK.COM>
 <20220105155451.GA25384@fieldses.org>
 <DU2PR10MB5096923D24D76EC264A51EBFE14C9@DU2PR10MB5096.EURPRD10.PROD.OUTLOOK.COM>
 <a12cfed3e997507ec837aefbd63aa4ff7b34fd4d.camel@hammerspace.com>
 <DU2PR10MB50969D4D096DB99EEC6D1C45E14C9@DU2PR10MB5096.EURPRD10.PROD.OUTLOOK.COM>
 <20220106142812.GC7105@fieldses.org> <20220106143605.GD7105@fieldses.org>
 <DU2PR10MB509689410AAC9E0B9D629558E14C9@DU2PR10MB5096.EURPRD10.PROD.OUTLOOK.COM>
 <20220106145546.GE7105@fieldses.org>
 <DU2PR10MB5096140C8DC5493271E8A8ADE14C9@DU2PR10MB5096.EURPRD10.PROD.OUTLOOK.COM>
In-Reply-To: <DU2PR10MB5096140C8DC5493271E8A8ADE14C9@DU2PR10MB5096.EURPRD10.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9c69e59f-5412-4164-b296-08d9d135dd72
x-ms-traffictypediagnostic: CH0PR10MB5290:EE_
x-microsoft-antispam-prvs: <CH0PR10MB5290F693C39FA95B0D995BBE934C9@CH0PR10MB5290.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: r5ATkWLrWiQaPFGU0AhMwFPfbs8UyNDKLVKvJLR3Xq7fIsZseWmA/lbtmki3U1WQotNxZYAQclGy+SzrsI/Q2O1fYagzSzkmoM7lLK2pZ/O6j7nHR4INo16JLPMKxhyL0uAI+j/64B+KTd4zihIqbxqlNLMlU76RMYX3+Y6FImHl6mvf9JEXj9MN+si7rh8eAcJ1Z7fDcRdP0vWwERPE28B1HWPwW3WQdj4jq01J42junEXB7VET3GcL8iulL1bpb/FuemCyaj2VSq3W6+Xh2E7JV/Rf5zTiPPpgAjspmef8TdCJQsx2ivck9OPrhj4iqhM3YVW9XY8qcE6ItB7tn72ownOdnlVH4zgtEqkljYdKxwFf3YcXIdVe5FBGBtF4fbLERrkweBc65Xc3S9NT0OxJ0iF0WJEFQK79nODBocbigVuEiZNqgcgMlwnh5d/lPdrg6fioeIJISp6zMMUipNh4Bcgnt3Lqd4wGArgkmGdGDXJGcJhtN2cK8MKF2Ey53sCC5vHXocQhKLGv+uS+OqmQA8y0+CEwtYOPD2hav/ixIKbeDuOMsTimQL9WGwSk7Y4HlMKiWKYRHRP6lp0qVLa/f8sxX/J1tEW6HXVtUuRYDMU3IDkHWSGnjBfdni0nFF/lq0r5j0b8rqarW2seb/Odyo5Jdj/i7NYalcPA0ER5bLb7v1HZ9Z/LAfv9sfN+rZkP2zRLN2CjGYS+qnios/sTtbgCyb084JhZMwRYsOG9UuBkRoF1D3Hml8eqGEPo
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB4858.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66556008)(66476007)(66946007)(66446008)(64756008)(76116006)(122000001)(6916009)(38100700002)(316002)(2616005)(6512007)(6486002)(83380400001)(4326008)(508600001)(71200400001)(8936002)(8676002)(6506007)(53546011)(36756003)(26005)(186003)(33656002)(5660300002)(38070700005)(54906003)(86362001)(2906002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?JF/N0bcUHXDPvWr+XOPChKGsJCy8QeqsENo4djy/zw47hQWO4+EvFV2H3EV+?=
 =?us-ascii?Q?l+h8WjiKCD2lRhs+qqEWMa+6ei4ybckAfOGEF97LjvCV610elEDgbltQcaj2?=
 =?us-ascii?Q?b5UlZ3FWKgtrCxABXnOknnbDpFgjHKsCJ9a/NBBhFCnnE/D6iCvypaJ/gixE?=
 =?us-ascii?Q?lerIaOUwnt+VOHE6j48sFyH3RB8eyfC5crGCIFGCkkDQCRpwGcMN6NSt5jCH?=
 =?us-ascii?Q?a/AOIw3zcXpjO+gcDJkXdqvyem+mVVJ/mVQ1M6P2y+WJCFxBcERgb1PXGfUp?=
 =?us-ascii?Q?WFd4lJQjBgEen3Qr704zcpxZTeUMdliy1vGYsL/aO1Q+p/7guPOYAbftSTml?=
 =?us-ascii?Q?tBhR09+eS6q9y+eoojEQQZIZwFW/DbOdRH8kmXEHMUIaHJGeaOJNSKNon7KA?=
 =?us-ascii?Q?o4/+7hUnN+KfvcGhEuCfJMVpprHZeUL0xjnRXSslYKahn09hfwe0n1oboY+y?=
 =?us-ascii?Q?WqLMYAYKVRNr3r7UmKwkjJ1LiFl9ijbj4/+hMtYdQRF5Crd6mnQIz0oErLdU?=
 =?us-ascii?Q?PYxGjT0FBdtWsQKK2mNSdriIeuHPaU8UPQFPvHWWXT80FN0EIwbuiWui3FRr?=
 =?us-ascii?Q?dGQ1YPE3finCT/s0MC923zWiYNlNBwWskB98I4QtsXnOrjMGoCoxgJgWFR2w?=
 =?us-ascii?Q?2fp7aZcRvwL1xSrqB2Jt3oqpaJDxNw63Jp2BiKlpUkTKPBU7jxHGXUn744UM?=
 =?us-ascii?Q?iJJ+kl+iX5bfmMydJeWTruMwaKJ5Z1/r/gRZuJ2G0aR1B5Q2PSjMM130hgqi?=
 =?us-ascii?Q?yi3bNl5qr1SJT8PMvaMKkqcCLr7YA3FvBGZ1ys9EiINn9USCSpRI7a6kOsIC?=
 =?us-ascii?Q?nSmsCVcihTDotOCPbylFl1mt1pH2e78uJlL17vFvgR02GsCyO4SYBirIGp6s?=
 =?us-ascii?Q?kDDk6ZK2HGMbwJyukCSR+EamUBROs8Amuj18ZJPdNohbEEbmaqzWmvU7RJyZ?=
 =?us-ascii?Q?74i3Gsx6stnL1ccKUWhFt1l2ZKef7nUuUgvxXR7lSzxKVhZbpKRozCxn8Xgz?=
 =?us-ascii?Q?CsE9WnStiRueUGGMEZetEAFwDt/kxyk+9iaWUymdafqU/o/KEIS9T1wQ8p0f?=
 =?us-ascii?Q?fjuESXSB5vZaqEE4ceCaUcFpJ2Sdo5eHFNA0eNjFiLEQXkep1urJBts8NTFd?=
 =?us-ascii?Q?PqKH49i0KL308yH3XZK4fnIC29K3Fdz60+6TyesfMX6dscsu3lSkaNHduA2d?=
 =?us-ascii?Q?SXOue40mJtdDDo3zZqXuok0EVa5vIH51Tar2zXUVM6L8NrdsObRgyqkliHXy?=
 =?us-ascii?Q?5le6493cCyMghnQSdoPRphRg7aPVkRAOCF1e9BduDiN184IIhuaEhkIlBY2h?=
 =?us-ascii?Q?OFypb/LEd8TTd7Wk8+XNoCFAZTlbz35MxVq1OmZon3lWwZWYCMdADPjW4RX3?=
 =?us-ascii?Q?KwqxfByyrXDPD8iHCrsytlLDVMV6RtdnoOPNvlSgR9Aklk/3Qvvy5Su7DeDc?=
 =?us-ascii?Q?EbMSiHPalvEjj1gIoLc/9iaymOg16i4Ek18dzdt7s52feebJDCpi4RiCz27R?=
 =?us-ascii?Q?XYKkl5uUAxX4OlYqNeLez1VbsvIvjKXIkpz9otetS/6VQtArC2i080Q3aQ/2?=
 =?us-ascii?Q?JJbHI+K4fdCHs459UbfXK/akABH4FABQFPX5WMg9+dTC8gdmdnbYdz+IGDMa?=
 =?us-ascii?Q?ymbddbvT5eqKSQC0lASlaLY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <0977D940FEDF974BAED800EA910F3CEB@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB4858.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c69e59f-5412-4164-b296-08d9d135dd72
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jan 2022 16:59:12.7608
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xWQYSbcUPdWjaFOX+XRptuO5LF15Z/AEFHp11P1OztXJgPDAgP/RsxCkLBTfhg6ZfS9AEBcjyMGx8lbSx3jJfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5290
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10219 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 spamscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 bulkscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2112160000
 definitions=main-2201060116
X-Proofpoint-ORIG-GUID: EutTfPfTSweCFzHnUW1hd37e_PEIYBvp
X-Proofpoint-GUID: EutTfPfTSweCFzHnUW1hd37e_PEIYBvp
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jan 6, 2022, at 11:13 AM, Ondrej Valousek <ondrej.valousek.xm@renesas.=
com> wrote:
>=20
> So I think this is what we eventually need (thanks for the pointers you g=
ave me!):
>=20
> diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
> index 5a93a5db4fb0..e88ae4ce5263 100644
> --- a/fs/nfsd/nfs4xdr.c
> +++ b/fs/nfsd/nfs4xdr.c
> @@ -2865,6 +2865,9 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct s=
vc_fh *fhp,
>        err =3D vfs_getattr(&path, &stat, STATX_BASIC_STATS, AT_STATX_SYNC=
_AS_STAT);
>        if (err)
>                goto out_nfserr;
> +       if (! stat.result_mask & STATX_BTIME)
> +               /* underlying FS does not offer btime so we can't share i=
t */
> +               bmval1 &=3D ~FATTR4_WORD1_TIME_CREATE;
>        if ((bmval0 & (FATTR4_WORD0_FILES_AVAIL | FATTR4_WORD0_FILES_FREE =
|
>                        FATTR4_WORD0_FILES_TOTAL | FATTR4_WORD0_MAXNAME)) =
||
>            (bmval1 & (FATTR4_WORD1_SPACE_AVAIL | FATTR4_WORD1_SPACE_FREE =
|
> @@ -3265,6 +3268,14 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct =
svc_fh *fhp,
>                p =3D xdr_encode_hyper(p, (s64)stat.mtime.tv_sec);
>                *p++ =3D cpu_to_be32(stat.mtime.tv_nsec);
>        }
> +       /* support for btime here */
> +        if (bmval1 & FATTR4_WORD1_TIME_CREATE) {
> +                p =3D xdr_reserve_space(xdr, 12);
> +                if (!p)
> +                        goto out_resource;
> +                p =3D xdr_encode_hyper(p, (s64)stat.btime.tv_sec);
> +                *p++ =3D cpu_to_be32(stat.btime.tv_nsec);
> +        }
>        if (bmval1 & FATTR4_WORD1_MOUNTED_ON_FILEID) {
>                struct kstat parent_stat;
>                u64 ino =3D stat.ino;
>=20
> diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
> index 498e5a489826..5ef056ce7591 100644
> --- a/fs/nfsd/nfsd.h
> +++ b/fs/nfsd/nfsd.h
> @@ -364,7 +364,7 @@ void                nfsd_lockd_shutdown(void);
>  | FATTR4_WORD1_OWNER          | FATTR4_WORD1_OWNER_GROUP  | FATTR4_WORD1=
_RAWDEV           \
>  | FATTR4_WORD1_SPACE_AVAIL     | FATTR4_WORD1_SPACE_FREE   | FATTR4_WORD=
1_SPACE_TOTAL      \
>  | FATTR4_WORD1_SPACE_USED      | FATTR4_WORD1_TIME_ACCESS  | FATTR4_WORD=
1_TIME_ACCESS_SET  \
> - | FATTR4_WORD1_TIME_DELTA   | FATTR4_WORD1_TIME_METADATA    \
> + | FATTR4_WORD1_TIME_DELTA   | FATTR4_WORD1_TIME_METADATA   | FATTR4_WOR=
D1_TIME_CREATE      \
>  | FATTR4_WORD1_TIME_MODIFY     | FATTR4_WORD1_TIME_MODIFY_SET | FATTR4_W=
ORD1_MOUNTED_ON_FILEID)
>=20
> #define NFSD4_SUPPORTED_ATTRS_WORD2 0
>=20
> Legal Disclaimer: This e-mail communication (and any attachment/s) is con=
fidential and contains proprietary information, some or all of which may be=
 legally privileged. It is intended solely for the use of the individual or=
 entity to which it is addressed. Access to this email by anyone else is un=
authorized. If you are not the intended recipient, any disclosure, copying,=
 distribution or any action taken or omitted to be taken in reliance on it,=
 is prohibited and may be unlawful.

Thanks, Ondrej.

This looks like an interesting new feature, however it's a little
late for the v5.17 merge window, IMO. (On the plus side, that gives
us a month or two for further review and deeper testing).

Also, the change needs to be submitted as a real patch. See the

   Documentation/process/submitting-patches.rst=20

file in the Linux kernel tree for information on the p's and q's.
In particular:

 -- you need a short and full patch description. The "Describe
    your changes" section explains the details.

 -- you need to ensure your employer permits you to contribute
    to the Linux kernel under GPLv2. The "Sign your work - the
    Developer's Certificate of Origin" section explains this.

I'm a little concerned about your Legal Disclaimer which suggests
that anything you have sent in e-mail is already owned by Renesas
and is therefore constrained for submission to the kernel. Before
submitting again, can you ask your legal team for clarification?

--
Chuck Lever



