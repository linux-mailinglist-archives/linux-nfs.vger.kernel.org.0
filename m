Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD4764257CE
	for <lists+linux-nfs@lfdr.de>; Thu,  7 Oct 2021 18:22:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241221AbhJGQYZ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 7 Oct 2021 12:24:25 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:2602 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233590AbhJGQYY (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 7 Oct 2021 12:24:24 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 197FNbdu032353;
        Thu, 7 Oct 2021 16:22:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=g667/2R3FDiO0UtA9yeCoY57X5PzDa7mxv81YaMc3WQ=;
 b=Bm6W7ZEKg8lnt+g3xLYTPi5MYRhZPXmnDtMdt6Ohywmgq4OkZ6/CxVA22Xcl8DnGyWUB
 HK5mpeySFm+IUIgZzglXuuZ0ql+0joEKIDvwb0XXux90VrYOJKhQfnI1uuRasz04RS1L
 a0cPku1bvDOmvNXxEOHqENvhp7iUfObK16EKbLZaNtbwCU9Sscb2bl5Y+5KjpAAiY5M9
 BuE6Nx4ttMShwh5tcVuoBG9x7o9IieBsGTl759opAjpZ1TKDqcd2VTnaDpJ88rs4Tby4
 pTMoPEPr20zl49uu+MOERI85NdGMImuQW0oyVMD+nn36pXhiVus9H6/olgLRcCHRVVJ4 DQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bhy2da9s1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 Oct 2021 16:22:22 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 197GG6uv053985;
        Thu, 7 Oct 2021 16:22:17 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2046.outbound.protection.outlook.com [104.47.51.46])
        by aserp3030.oracle.com with ESMTP id 3bev7wqn3b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 Oct 2021 16:22:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gu4OfQn15v0rY0dGWSIvw2UIICnznOeCkLEpWP6KZNU3T18iPPrfSJFXRIVC/u1HigtHTb4LKGJ5fFL03mN5eT2rPuEd+pKor5qZSYTtBxOg3+C7bk3rFDwYSR1FfFldrsDfqCS9VfSPkLVpiGiHU5K0kgXFjeCq4GJRE3R5Is8Lxxn5r3T0U1eDjVchkidMVhd7Egm9Btollp5mzO47QJvYsJc+Q3rleFXBfZkDR6POqUz4ZXmW7C8Si4P1G8NSl7Ed8Ow6rJHaIdR71zjLfnxgrB2fichV4XNKJOd2nxpMsJwAxQJcCDi+ixQGjVDI35j1cxZ60spsfdfOoydx8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g667/2R3FDiO0UtA9yeCoY57X5PzDa7mxv81YaMc3WQ=;
 b=PDz6+NPRDFogkvGtsIxUmF5U7z9GKvl31u5X1Nf/9lLN+G8X/CBR7ejmf9ITplcm4Z9cl5qwim56WWQsRpevdd9lnp/17g9XirI24q+C4SvmMExkm6yy0pm61EkbyrYmlrBnZndYqZeAAbOjZA78xZeKoQFBeGEKmr5BQkHn+Ed1PYH5q9S61JK39MKam6kS6vwPU/szfbFXw13IGYZTBsTs3trgiJFVw7Yqga+xt/Xyhi5ML5JGWtcatwYkwDWrPzx+NO7Jk1AcT1ZH4VvnGD8E+mHRvJcQdW5zUrX7zOwnTPCGSusssbrEUyGbTwRNiAKPthEEqafVcsOYKv3kmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g667/2R3FDiO0UtA9yeCoY57X5PzDa7mxv81YaMc3WQ=;
 b=bP3XaMKw5TyYteQG/IEntjc8BXfpZDZ5QtTSGbERJ0JrHkSwtC1B0AsB3lJFLI01Jep4Yadte/sxyvP1FL5PHDHDDAVwBjUls8fSAsJIrTMW4YA8gI6kajbyVZT3t1vW4NMu5tkg+pTgzEiF1RY+Cw3GvxbH+7kRZZXc/PvTPvA=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BYAPR10MB3112.namprd10.prod.outlook.com (2603:10b6:a03:157::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.19; Thu, 7 Oct
 2021 16:22:16 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::f4fe:5b4:6bd9:4c5b]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::f4fe:5b4:6bd9:4c5b%6]) with mapi id 15.20.4587.020; Thu, 7 Oct 2021
 16:22:15 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     David Wysochanski <dwysocha@redhat.com>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v2] NFS: Replace dprintk callsites in nfs_readpage(s)
Thread-Topic: [PATCH v2] NFS: Replace dprintk callsites in nfs_readpage(s)
Thread-Index: AQHXu5bQymWcB92tXEKQGjb5V/zVIKvHt8wA
Date:   Thu, 7 Oct 2021 16:22:15 +0000
Message-ID: <350A3F30-43E1-488E-9742-2FAA9F2567C2@oracle.com>
References: <163362342678.1680.15890862221793282300.stgit@morisot.1015granger.net>
In-Reply-To: <163362342678.1680.15890862221793282300.stgit@morisot.1015granger.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cf25bafc-9573-4808-4379-08d989aea07f
x-ms-traffictypediagnostic: BYAPR10MB3112:
x-microsoft-antispam-prvs: <BYAPR10MB311297946CCC1E7AB3F096BA93B19@BYAPR10MB3112.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:334;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: G4Kb0RZAZbmOD3zc73VUornq9JV5ptAkMFapmheYpFi6ilE/3Xtctj85IgdIG8kwspzTN/4F1SNIUKazFMfNh5APRs2UBYwdfsAgiD8v9YFQsVQbY3LKL7iELclckCXHCre5o6tM6h6+ZUX5fRTKdus1CUfJ0IwfqKdiyQ/q84eO9spv/bmGYhtbsANiB/Y0rlW1bJ1jbGPwDZ/o9sfwLJru3UvGzNhs1pztop3tQV6PlxpEuDv1Q1xuwTlfqosfT+ooXdzUzBK1S5Uw/G0T1HZxX46ugDBkHKymJgUscsg0dWxTsJs7aOLeeiRI4ZaNvjvPv8D2ggG31vY2EcTivewvRbo2c2A8RCr8IC1WPnxShdzvSRUJdVw+TR7nTPBn7iEu13kDh4ovymwPk/7fv29Xb9i2l8qpJBFRwae59tyzbRI/lwMWONCNLAg0WiHHFK8uvFWTefmQuLDByoMBeBI352Imy+yC0XM2IZWwzzPI6Ax/iZ60zC3Ey1xA2bvOKiQD6AYk7LHrgVLV2p3KGjrNGmA6mGVUOhBn80ZU11lPj3bV24lagGUEWprN/IPTYfrKDSUlWBHHXCEoJNOkHMIZLFiyVUG1KFTlRXtc0VA/y9dr00Tfi68JK61eKh7SlOx2aEULvi9Tlbwd9/XisZAqAb/OdR5HcvH1ckr6zh2IgMcXzlIkf/vk1SBSVBQ1s5ZQC3v+JGc27yE8lIdZFP/PcUb0juXAuMFJMDnS+kM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(26005)(38100700002)(5660300002)(66446008)(8676002)(66556008)(122000001)(6486002)(36756003)(6512007)(86362001)(2616005)(2906002)(316002)(186003)(508600001)(4326008)(66946007)(53546011)(64756008)(76116006)(8936002)(71200400001)(66476007)(91956017)(6506007)(83380400001)(38070700005)(33656002)(6916009)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?d+ocit0kDKAzoWhsci59jRM8uLLw7ZcExU9G22xCKqVvCraV162r64XAqpRC?=
 =?us-ascii?Q?4/GzUCL//epdJsClTJPkiBm8hHnX4/ED3HofYx9fRwXTjSzLJ7gZ0Y+fRPcN?=
 =?us-ascii?Q?Vh6+J36J+8ykCU9QfDM5EJfKHUBzv6W8uoQLRljsR7gLV/x9YHDrRiGmw79u?=
 =?us-ascii?Q?3P3TBZM1XgWei8CN6eXxulKHqqgwkQpRhnb0j8b37KkclDnDsX80I+1oYUHv?=
 =?us-ascii?Q?6rULxv8pBJ05sfkWB0t1ureQznwo5Z3apwCAI5kk4HmITnWTs5ngqK12xggq?=
 =?us-ascii?Q?ik/eTeQkBZ2pSh/U4HlZBwnbV0taZ3ht0+JGlX//dswt2VunUG/cV8Z3rABO?=
 =?us-ascii?Q?uBcQdPNouLte0Ozea1rIVfAdO5QVv62mAt+B/eJq7eQg0Xo5DyX0i7Xs2S6a?=
 =?us-ascii?Q?KA4C9T320YTVnE4XlB+09n24QKj156OVPmSltmhTjjFudEJL7yihscI4LB1y?=
 =?us-ascii?Q?pjzruhcRF6MJK9q872EbPrvyPtDXCaNT9Aw5Geg6TeM7f39+JJ8TwdkeLvxJ?=
 =?us-ascii?Q?fP5WDDIHn5qKaTk6WICUm/KroAk20mRJQicgjxZXPUmUb0KkofSm3pGSghOl?=
 =?us-ascii?Q?rkEktYWQW/IT1D7hNlIcEtKQ9C3QVXGYXfOPPyOwF/76ei0quTOWEL2fiawR?=
 =?us-ascii?Q?vkCUkpGtQyUB6l2NXhcGDDXGRbmGAkQy460Xe+Cv9jp/sW+nfgNWOua0hrbN?=
 =?us-ascii?Q?wP81Ht0in4gXogEKhmN/2/mlNSlt8zRV89o006Pm6JDuhw87YSqb0A39Te2F?=
 =?us-ascii?Q?jQu9+fPwnml5yoA8jluw5kXHZoSo363mLhH401kFNZJWPNq8ew/2VUC2ueF4?=
 =?us-ascii?Q?oiUZHon61R+FjONhHIwWc+TLVwpG737UCThpqD+jhvIOODKXAwrj26y1dF/l?=
 =?us-ascii?Q?m1x1z/Dyy3VbTsgpIRjf/Hsp/0zOU/x9iDgAmXKuQz3BE9wXsw5zvjnijKGD?=
 =?us-ascii?Q?SNFMjgb92qANc36TMsoAxJgLc/uCMJF3O2j6W3G7BqDknvSI0qo8f8q0cGbf?=
 =?us-ascii?Q?rbaaYKRphIGeF3a0piL68+yg4n7rh1/GMoqxBbPt33Cc2TabKFFZ8slAYGRz?=
 =?us-ascii?Q?bOzrm/NXDwcY90VOtyon6Na19+36ZnLW5md5rc0aXjWs6bK3bSir3BkuseUC?=
 =?us-ascii?Q?LmQNSTHDl8jHZx00dAsunhCEnptfrgCBvv9pdKzneCZ0BSE3D++SvQQBU28X?=
 =?us-ascii?Q?qKPI7/GRZoojV51T+KJyI5QWsabuBGKTDbG0ugIA9V8SbvfXUsVaezHuGfeI?=
 =?us-ascii?Q?n+RccLBI+6+UwekNNySCcCPqdqD1SqRZo/4CN+MY2VJ6a4Mq6GnHF6pLn9Vn?=
 =?us-ascii?Q?/BzLTGr2fOPCYLuTZlFncpyG?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <EFAE2B1B4E222C4EBE04C47BE7E5C605@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf25bafc-9573-4808-4379-08d989aea07f
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2021 16:22:15.8022
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xG93veU/YoqwFilfOaotqHAKPbAhje+h+ARl+I68wCFqxY8r26FHBL1mZiVb9oVV4XSUrEtBO93slUMGfBq5GQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3112
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10130 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 adultscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110070106
X-Proofpoint-ORIG-GUID: WqZ3NUMwe1fSa1U9lpUx1qE5rTIVnF9d
X-Proofpoint-GUID: WqZ3NUMwe1fSa1U9lpUx1qE5rTIVnF9d
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Oct 7, 2021, at 12:17 PM, Chuck Lever <chuck.lever@oracle.com> wrote:
>=20
> There are two new events that report slightly different information
> for readpage and readpages.
>=20
> For readpage:
>             fsx-1387  [006]   380.761896: nfs_aops_readpage:    fileid=3D=
00:28:2 fhandle=3D0x36fbbe51 version=3D1752899355910932437 page_index=3D32
>=20
> The index of a synchronous single-page read is reported.
>=20
> For readpages:
>=20
>             fsx-1387  [006]   380.760847: nfs_aops_readpages:   fileid=3D=
00:28:2 fhandle=3D0x36fbbe51 version=3D1752899355909932456 nr_pages=3D3
>=20
> The count of pages requested is reported. readpages does not wait
> for the READ requests to complete.
>=20
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>

Well obviously I forgot to update the patch description.
I can send a v3 later to do that.


> ---
> fs/nfs/nfstrace.h |  146 ++++++++++++++++++++++++++++++++++++++++++++++++=
+++++
> fs/nfs/read.c     |   11 ++--
> 2 files changed, 151 insertions(+), 6 deletions(-)
>=20
> diff --git a/fs/nfs/nfstrace.h b/fs/nfs/nfstrace.h
> index e9be65b52bfe..85e67b326bcd 100644
> --- a/fs/nfs/nfstrace.h
> +++ b/fs/nfs/nfstrace.h
> @@ -862,6 +862,152 @@ TRACE_EVENT(nfs_sillyrename_unlink,
> 		)
> );
>=20
> +TRACE_EVENT(nfs_aop_readpage,
> +		TP_PROTO(
> +			const struct inode *inode,
> +			struct page *page
> +		),
> +
> +		TP_ARGS(inode, page),
> +
> +		TP_STRUCT__entry(
> +			__field(dev_t, dev)
> +			__field(u32, fhandle)
> +			__field(u64, fileid)
> +			__field(u64, version)
> +			__field(pgoff_t, index)
> +		),
> +
> +		TP_fast_assign(
> +			const struct nfs_inode *nfsi =3D NFS_I(inode);
> +
> +			__entry->dev =3D inode->i_sb->s_dev;
> +			__entry->fileid =3D nfsi->fileid;
> +			__entry->fhandle =3D nfs_fhandle_hash(&nfsi->fh);
> +			__entry->version =3D inode_peek_iversion_raw(inode);
> +			__entry->index =3D page_index(page);
> +		),
> +
> +		TP_printk(
> +			"fileid=3D%02x:%02x:%llu fhandle=3D0x%08x version=3D%llu page_index=
=3D%lu",
> +			MAJOR(__entry->dev), MINOR(__entry->dev),
> +			(unsigned long long)__entry->fileid,
> +			__entry->fhandle, __entry->version,
> +			__entry->index
> +		)
> +);
> +
> +TRACE_EVENT(nfs_aop_readpage_done,
> +		TP_PROTO(
> +			const struct inode *inode,
> +			struct page *page,
> +			int ret
> +		),
> +
> +		TP_ARGS(inode, page, ret),
> +
> +		TP_STRUCT__entry(
> +			__field(dev_t, dev)
> +			__field(u32, fhandle)
> +			__field(int, ret)
> +			__field(u64, fileid)
> +			__field(u64, version)
> +			__field(pgoff_t, index)
> +		),
> +
> +		TP_fast_assign(
> +			const struct nfs_inode *nfsi =3D NFS_I(inode);
> +
> +			__entry->dev =3D inode->i_sb->s_dev;
> +			__entry->fileid =3D nfsi->fileid;
> +			__entry->fhandle =3D nfs_fhandle_hash(&nfsi->fh);
> +			__entry->version =3D inode_peek_iversion_raw(inode);
> +			__entry->index =3D page_index(page);
> +			__entry->ret =3D ret;
> +		),
> +
> +		TP_printk(
> +			"fileid=3D%02x:%02x:%llu fhandle=3D0x%08x version=3D%llu page_index=
=3D%lu ret=3D%d",
> +			MAJOR(__entry->dev), MINOR(__entry->dev),
> +			(unsigned long long)__entry->fileid,
> +			__entry->fhandle, __entry->version,
> +			__entry->index, __entry->ret
> +		)
> +);
> +
> +TRACE_EVENT(nfs_aop_readahead,
> +		TP_PROTO(
> +			const struct inode *inode,
> +			unsigned int nr_pages
> +		),
> +
> +		TP_ARGS(inode, nr_pages),
> +
> +		TP_STRUCT__entry(
> +			__field(dev_t, dev)
> +			__field(u32, fhandle)
> +			__field(u64, fileid)
> +			__field(u64, version)
> +			__field(unsigned int, nr_pages)
> +		),
> +
> +		TP_fast_assign(
> +			const struct nfs_inode *nfsi =3D NFS_I(inode);
> +
> +			__entry->dev =3D inode->i_sb->s_dev;
> +			__entry->fileid =3D nfsi->fileid;
> +			__entry->fhandle =3D nfs_fhandle_hash(&nfsi->fh);
> +			__entry->version =3D inode_peek_iversion_raw(inode);
> +			__entry->nr_pages =3D nr_pages;
> +		),
> +
> +		TP_printk(
> +			"fileid=3D%02x:%02x:%llu fhandle=3D0x%08x version=3D%llu nr_pages=3D%=
u",
> +			MAJOR(__entry->dev), MINOR(__entry->dev),
> +			(unsigned long long)__entry->fileid,
> +			__entry->fhandle, __entry->version,
> +			__entry->nr_pages
> +		)
> +);
> +
> +TRACE_EVENT(nfs_aop_readahead_done,
> +		TP_PROTO(
> +			const struct inode *inode,
> +			unsigned int nr_pages,
> +			int ret
> +		),
> +
> +		TP_ARGS(inode, nr_pages, ret),
> +
> +		TP_STRUCT__entry(
> +			__field(dev_t, dev)
> +			__field(u32, fhandle)
> +			__field(int, ret)
> +			__field(u64, fileid)
> +			__field(u64, version)
> +			__field(unsigned int, nr_pages)
> +		),
> +
> +		TP_fast_assign(
> +			const struct nfs_inode *nfsi =3D NFS_I(inode);
> +
> +			__entry->dev =3D inode->i_sb->s_dev;
> +			__entry->fileid =3D nfsi->fileid;
> +			__entry->fhandle =3D nfs_fhandle_hash(&nfsi->fh);
> +			__entry->version =3D inode_peek_iversion_raw(inode);
> +			__entry->nr_pages =3D nr_pages;
> +			__entry->ret =3D ret;
> +		),
> +
> +		TP_printk(
> +			"fileid=3D%02x:%02x:%llu fhandle=3D0x%08x version=3D%llu nr_pages=3D%=
u ret=3D%d",
> +			MAJOR(__entry->dev), MINOR(__entry->dev),
> +			(unsigned long long)__entry->fileid,
> +			__entry->fhandle, __entry->version,
> +			__entry->nr_pages, __entry->ret
> +		)
> +);
> +
> TRACE_EVENT(nfs_initiate_read,
> 		TP_PROTO(
> 			const struct nfs_pgio_header *hdr
> diff --git a/fs/nfs/read.c b/fs/nfs/read.c
> index 08d6cc57cbc3..c8273d4b12ad 100644
> --- a/fs/nfs/read.c
> +++ b/fs/nfs/read.c
> @@ -337,8 +337,7 @@ int nfs_readpage(struct file *file, struct page *page=
)
> 	struct inode *inode =3D page_file_mapping(page)->host;
> 	int ret;
>=20
> -	dprintk("NFS: nfs_readpage (%p %ld@%lu)\n",
> -		page, PAGE_SIZE, page_index(page));
> +	trace_nfs_aop_readpage(inode, page);
> 	nfs_inc_stats(inode, NFSIOS_VFSREADPAGE);
>=20
> 	/*
> @@ -390,9 +389,11 @@ int nfs_readpage(struct file *file, struct page *pag=
e)
> 	}
> out:
> 	put_nfs_open_context(desc.ctx);
> +	trace_nfs_aop_readpage_done(inode, page, ret);
> 	return ret;
> out_unlock:
> 	unlock_page(page);
> +	trace_nfs_aop_readpage_done(inode, page, ret);
> 	return ret;
> }
>=20
> @@ -403,10 +404,7 @@ int nfs_readpages(struct file *file, struct address_=
space *mapping,
> 	struct inode *inode =3D mapping->host;
> 	int ret;
>=20
> -	dprintk("NFS: nfs_readpages (%s/%Lu %d)\n",
> -			inode->i_sb->s_id,
> -			(unsigned long long)NFS_FILEID(inode),
> -			nr_pages);
> +	trace_nfs_aop_readahead(inode, nr_pages);
> 	nfs_inc_stats(inode, NFSIOS_VFSREADPAGES);
>=20
> 	ret =3D -ESTALE;
> @@ -439,6 +437,7 @@ int nfs_readpages(struct file *file, struct address_s=
pace *mapping,
> read_complete:
> 	put_nfs_open_context(desc.ctx);
> out:
> +	trace_nfs_aop_readahead_done(inode, nr_pages, ret);
> 	return ret;
> }
>=20
>=20

--
Chuck Lever



