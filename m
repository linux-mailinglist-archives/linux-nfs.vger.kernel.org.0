Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 812EE422F26
	for <lists+linux-nfs@lfdr.de>; Tue,  5 Oct 2021 19:24:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235351AbhJER01 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 5 Oct 2021 13:26:27 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:36318 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234938AbhJER01 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 5 Oct 2021 13:26:27 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 195H8ZaL019258
        for <linux-nfs@vger.kernel.org>; Tue, 5 Oct 2021 17:24:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type : content-id :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=upj23OACPk/Iegqt8UMXcO6kN2OO1QD24do7/qP2/Qw=;
 b=Jevp9X4X55juFBmzUnx3jnOFUE6hLaqjYWS7R2QkXo35uN5ltQyNGAPJFgoLaEMNuoBt
 zbMYOnMuSdsMuWudEfehatL+69HZ2RC2Y//qbl971QHJmeJsORPxYp+WomS+BDwu+6eQ
 ffIS5IS1kjxZ9hIxD38v82KmdnXg36qNDOkvW45o/XHDa8airHDaaDZdKJg6KWuk5taQ
 NqRt+VfLBpa6bbL8Faxu7WtSl0Y86nZfoKijnhHNmRCgz36auoaocwPuKl1AF/8HvjRM
 JksM0oZALm+3fOLrUK4XH6o39vmvW2wH4P+gnwCK+OrDbgcA850Towp/9lbHW6sAoLD1 Eg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bg3p5hpjr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-nfs@vger.kernel.org>; Tue, 05 Oct 2021 17:24:33 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 195HGKi4046975
        for <linux-nfs@vger.kernel.org>; Tue, 5 Oct 2021 17:24:04 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by aserp3020.oracle.com with ESMTP id 3bev8x2eps-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-nfs@vger.kernel.org>; Tue, 05 Oct 2021 17:24:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jWClJ+MEUU7zlMprwcw6ETHAaM8lqEzqTtf29c9nzHpQAy25elg8D1RKIj+8EKel031hG1RyDT1pZLmb8YGDtD1ZvA4hPvq6ALwJDNjpGyC9jCIVSQC/TnX+MJzq09jFU1+3RNwijhpW7rtgnumo/zvOK099EDuXkY+Di0gpw985hu3wsrfHu9pEGFjyzRWSY4GqLH7rjSM0QO52W6Dr/O425Iq+0QhbPwtUQz5yb34rmqc/Lz8dlxcJNlc3CWjczn3GvcjzLaA9Obp+l1pXf206cluNbWopdlmT34w1MGlXeAE6F1ijgip5yWlonYBqaq/rszNC2rblrWyH1zko5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=upj23OACPk/Iegqt8UMXcO6kN2OO1QD24do7/qP2/Qw=;
 b=j9GEQi+WXYAitTWn1R8LkNAoSJjbWGB2MMJF4IfkYdXXV8yryNT5O8KqQmhDy4x28kNBermCQNxYTUUKOWzT5z+1hVHghU6FlFnEl95MhkoQQfIFXvUu5bSesahFciuSdlphIrqsvfyNeSDtYtbMhVD+wBp0LgkZQO/QeyOlzSq2lK9xWvPbhI85JcL0GRbF/4wMLUfQc3Tq6koI27Kl5b7FYorfuU9J8BhhbhlFIpUGQoLTjxwCfvGbajDXHyDBKHuQeb9wxrzvRjbgpbREf7C0yCZXeWsRalKp625w61fA1ESXO3PVybGqmbZ+025XEvK+qr2kTV9phWgmTRrL8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=upj23OACPk/Iegqt8UMXcO6kN2OO1QD24do7/qP2/Qw=;
 b=PNiSUBXjQaKqOnYLuxHjYfu+C88WVkuM3e1sIztV2JcrOS7lwbmmLwAjBjLbBVsNwrOONeSHlSuMv9r9E8wKQcZXBHXqye4yer73zENC+g+0KCdm5o65kkZywpu2lQCk4YTxLxDFeKbuyXPa+49cPIvMj6nzM176h8LWGt81dnI=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BYAPR10MB3032.namprd10.prod.outlook.com (2603:10b6:a03:82::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.22; Tue, 5 Oct
 2021 17:24:02 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::f4fe:5b4:6bd9:4c5b]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::f4fe:5b4:6bd9:4c5b%6]) with mapi id 15.20.4566.022; Tue, 5 Oct 2021
 17:24:02 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH RFC 5/5] NFS: Replace dprintk callsites in nfs_readpage(s)
Thread-Topic: [PATCH RFC 5/5] NFS: Replace dprintk callsites in
 nfs_readpage(s)
Thread-Index: AQHXugx45Ev+HCUtEEmdoiu/yqrAbKvEp3qA
Date:   Tue, 5 Oct 2021 17:24:02 +0000
Message-ID: <C7370215-1090-4273-811D-99F23ED2BCA1@oracle.com>
References: <163345354511.524558.1980332041837428746.stgit@morisot.1015granger.net>
 <163345406901.524558.6277128986656130592.stgit@morisot.1015granger.net>
In-Reply-To: <163345406901.524558.6277128986656130592.stgit@morisot.1015granger.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 645dea10-e9e7-485d-635c-08d98824ed0a
x-ms-traffictypediagnostic: BYAPR10MB3032:
x-microsoft-antispam-prvs: <BYAPR10MB3032B3BEBF2D1801DD63B45C93AF9@BYAPR10MB3032.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:203;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Evm/MPQC+dMI94LK41H2+CZ8lJmRONRb/RK8IvNKQOiuwkwhaAdcNDBz/wMAXxarDyyhEXn815K6Z+GTlxQxAwURFsSEEcd5ge7QfinLgyME83rAzGvje4wuIILYyJ4WkKIfbnyFTQfSgvq49jSWXlmm+l8iea6LQod1lT/T6d/DPAo91DkTm9eRFFA8Dd2cveClFeHgMIETUpnlI5dOWwsOUFdnTs+D3hl6RIChNFy5nuMfE+Q+iViRwwKQR1U5TZlqIDEfzgzRnbIgXNn36TDdQgUHSZzEQc1RywatyrspvPJULwMxFcC5zzPv0g0Uk/Hu3cNbnU+ZNLhY29AXFakyDGhoAJzsY4vT+zK/4nqxKSED4fOGXsLIcC3xmP2PSw2iRAXQg62FsG2xLBxBiG5TZiYmWZ3nO00A3DYsCp8L0xqL78/Og9mdoSW5MX5xVo9bvF2os57VEiklOt+o00B1AYGE4swvJx6aoigUMzp9e4lBNq/nc3qTlBjgmatklb8NiYCWo3yyvJbEdwX5kC14Ha/ainxQgkwohmmgEDJrqJ5LqQI0uErejVmanTB6LtpXnaV+sXat0SJHCm6PffL6bJgWArrfQcdfy9UkQMDgqkt8lRlRen3e+fdQEHKfWe5f9HQwsWsOhWwVYwgpIC2CUJ8UVwiaIwr4DM4nEcEJvS0w4a567ejWsvdf2ZmMzyk6QeC+znH0z6s6n2PM1fXsRjQaCt8VlCy+KteXX8s=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6506007)(26005)(66946007)(76116006)(53546011)(38070700005)(66476007)(71200400001)(66556008)(64756008)(122000001)(38100700002)(66446008)(8936002)(186003)(33656002)(2616005)(6512007)(5660300002)(86362001)(316002)(2906002)(508600001)(6916009)(8676002)(36756003)(6486002)(83380400001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?tZX2rrqaGw4Fe8ekAQuPHgoSvFd1E7CpoKS+BxDX4l0yWKKLIQ6z+JuIiYWW?=
 =?us-ascii?Q?p65/w7A+Yx6HQoAKetsLV+69m6oFm8fPSMJsT2slMrzLk3FSSR/BNugz0I9W?=
 =?us-ascii?Q?3hcft+TKEt5samDpaoJgIVBVAXzorv4l2qcrU+k1yr/DH5SLdAFqeXsDseln?=
 =?us-ascii?Q?PUMUIfKuihGVttBTxV9OQkUhLS52ZRIAtoLrswR4kJ58jqYIcSaaIwYwdXHT?=
 =?us-ascii?Q?/tfuWi+3twqo4Dz+v2CYKYFhl9NS3onFTWNrMdibqfqBEy6iFTp9whSbDBAm?=
 =?us-ascii?Q?ZSkExgSpWt2G85slBhpRW0t4lRo50aegRBF8NsvaiRCJ+kSZOX1embMWBVCU?=
 =?us-ascii?Q?ONjoqTjI1kM6Ec+MmC7TgspI8DmpXJjJ3bTfJ9s5N60nRkaN2ChkqYg6jOkZ?=
 =?us-ascii?Q?EVkhwknEzdu2jn+JkkFdnpXsFCo+QoDu8C9MCIgF4tIaTaAdbSF0URdiWNQT?=
 =?us-ascii?Q?i33BgwkRNV7RfEL24bHLqy5naghZHaajKDleo6f0fBlKRW0qnEvpW0oPdlja?=
 =?us-ascii?Q?ANiBv5C1+D5CgFwCnjCgTEUyqAsrmNDD9jQi1Kc4k/YuAH6N4sntHI3BdJ7/?=
 =?us-ascii?Q?KdyEC5LF1L2MN+Ca0HnlyhISkDIQGXBuTl9BmD1eWD609R94Hljq+8JFfMVr?=
 =?us-ascii?Q?Za6HCwsFJuK1d50ls0a1UxlWH0JazK0TQAsupOvr8mUWhIndGR9TjvR0a/z2?=
 =?us-ascii?Q?8Hxx+d2en1FkCm+N6kFnJfjkdGUPbJxFpvMD0IJnMA1k0hyQuU6p6qb6CHAF?=
 =?us-ascii?Q?ngX0rFHKFH/JBZZCQPx8CTnLhh1d+hmy06T2m1UDLC0LCNBovawEoSTFPatz?=
 =?us-ascii?Q?K6RG3X5zsUZIunVE5QtvwPeB/d/gEs/EiVglJFKax1F1FSvmK3KW1RhYrGrd?=
 =?us-ascii?Q?x82MuL3bMtfNR7KKrddFqFAyEqMC8lcMKdiXZ5VUrwaAQEXfXoxNQGvSitZE?=
 =?us-ascii?Q?MAlwzFarNZZHLpT909oLf5w2vCcXUOe+X9JHAcVkSuFP4JC/2n1zBoljpXl3?=
 =?us-ascii?Q?9zM3BQFjcqWXCYKR3s2mU7NI7rDZ2ByR2eB4nKpstoSHiFY4laH1Wy0kZOGq?=
 =?us-ascii?Q?Sh+CVWm42CJbFhXUs4rKt/jhKVOBOlSmb8V0C3JMLLi8EfK+T3D7WlzR0dub?=
 =?us-ascii?Q?RExQSp1IRs3ZyoaV3Jm8mC9pr4lmc3oZFzVnypntI3ZRLTca6/CEm94QsaFf?=
 =?us-ascii?Q?O0opjlqFPNBf1zz/+kdrqfmen107Y3kbCOQH7UWd2lC78csN7oq2Dh3UHU+J?=
 =?us-ascii?Q?uyNNWTBAwwJ82FsWVJlsKH3HGO9IeZdesDrpu+7YhTrAyRKbfhG4TbJQ6egE?=
 =?us-ascii?Q?qJxJiwc5xqmUHoYCtCX37wEY?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <101262AAAC52FD4B9BA0A0B5D8ABCFF2@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 645dea10-e9e7-485d-635c-08d98824ed0a
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2021 17:24:02.5173
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sPoc2Vs0u7QgF2gFMBsMfZlSHnFEIrgbi7x/1yefS5oP7PAiqPXHys7z/XsBm1Gljz8lulGzZOuSFTHh9HKP9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3032
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10128 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 phishscore=0
 spamscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110050104
X-Proofpoint-ORIG-GUID: c-Bv-PDqOXz15SFYIrQR7idRlcCLhHaC
X-Proofpoint-GUID: c-Bv-PDqOXz15SFYIrQR7idRlcCLhHaC
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Oct 5, 2021, at 1:14 PM, Chuck Lever <chuck.lever@oracle.com> wrote:
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

Actually, %s/aops_/aop_/g might be a little nicer.


> ---
> fs/nfs/nfstrace.h |   70 ++++++++++++++++++++++++++++++++++++++++++++++++=
+++++
> fs/nfs/read.c     |    8 ++----
> 2 files changed, 72 insertions(+), 6 deletions(-)
>=20
> diff --git a/fs/nfs/nfstrace.h b/fs/nfs/nfstrace.h
> index e9be65b52bfe..0534d090ee55 100644
> --- a/fs/nfs/nfstrace.h
> +++ b/fs/nfs/nfstrace.h
> @@ -862,6 +862,76 @@ TRACE_EVENT(nfs_sillyrename_unlink,
> 		)
> );
>=20
> +TRACE_EVENT(nfs_aops_readpage,
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
> +TRACE_EVENT(nfs_aops_readpages,
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
> TRACE_EVENT(nfs_initiate_read,
> 		TP_PROTO(
> 			const struct nfs_pgio_header *hdr
> diff --git a/fs/nfs/read.c b/fs/nfs/read.c
> index 08d6cc57cbc3..94690eda2a88 100644
> --- a/fs/nfs/read.c
> +++ b/fs/nfs/read.c
> @@ -337,8 +337,7 @@ int nfs_readpage(struct file *file, struct page *page=
)
> 	struct inode *inode =3D page_file_mapping(page)->host;
> 	int ret;
>=20
> -	dprintk("NFS: nfs_readpage (%p %ld@%lu)\n",
> -		page, PAGE_SIZE, page_index(page));
> +	trace_nfs_aops_readpage(inode, page);
> 	nfs_inc_stats(inode, NFSIOS_VFSREADPAGE);
>=20
> 	/*
> @@ -403,10 +402,7 @@ int nfs_readpages(struct file *file, struct address_=
space *mapping,
> 	struct inode *inode =3D mapping->host;
> 	int ret;
>=20
> -	dprintk("NFS: nfs_readpages (%s/%Lu %d)\n",
> -			inode->i_sb->s_id,
> -			(unsigned long long)NFS_FILEID(inode),
> -			nr_pages);
> +	trace_nfs_aops_readpages(inode, nr_pages);
> 	nfs_inc_stats(inode, NFSIOS_VFSREADPAGES);
>=20
> 	ret =3D -ESTALE;
>=20
>=20

--
Chuck Lever



