Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A9F7344704
	for <lists+linux-nfs@lfdr.de>; Mon, 22 Mar 2021 15:22:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230259AbhCVOWG (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 22 Mar 2021 10:22:06 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:45466 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230016AbhCVOVs (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 22 Mar 2021 10:21:48 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12MEKG0R031625;
        Mon, 22 Mar 2021 14:21:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=2M59X+1Kq+GtW8UXUh71DVqJFsg5B2nKLsGig3hUt2Q=;
 b=GEvRbVz/3HPSICs9vr6ffedjN743a5kLa0iU76MJ5sCRTvAur19ZxP5Sgwx2/XiVJQeV
 rTi3aP3DOyFW2wIxFvY6n0iLMumuqpLvS/j16SmsQy9GwQrtJIgAhnryBrLUpWWQ7GB9
 c6gdl9SGUmrolVGRvXSEsojZm3a7JA0AqGaoQWN4lBeeuva9JABxGiWP5tDMxO4A2oP1
 T79ARd6ZcLOHPMd5hk4XS7+ni3IMXMJ6uPtO5fTsc0oUCcVvBN4SJ2A7Gd9Nw8HgNNU+
 Wn+jd/tk/dz0ro8q4X8mDzLRAZclMG0r2lU+gcuRbMwwATsO2CM1png4qfZ/kuNDKK1Q 4A== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2130.oracle.com with ESMTP id 37d6jbbrqh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Mar 2021 14:21:45 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12MEKLVj094799;
        Mon, 22 Mar 2021 14:21:44 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2108.outbound.protection.outlook.com [104.47.70.108])
        by aserp3020.oracle.com with ESMTP id 37dtxx0t28-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Mar 2021 14:21:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bbr+poEos8HMq6tJvBAr1n5rSvr33cbUJf/p6fqT7sNT2Seosd9pJGa7BrjfSbT/JTqn22Egi9up3K9l2qsJr1JPGFfsj6A0FHITdmMB1GRHD1IrqXI7D6VuL0x/X+gr5N/a7HFzzcUodbDlxM8GanThPGv3f342VHXeHPj2h5fwyypziAiQZNm85m0u4646J0GgutQ6YyrmyQ296WVAZF+cLmzTaOMhKFzaQVkRYmOCbgt8E5/LkyIC+Weerhx/AkSjF+h6h7M7KG6xnoiR1TlmcZpiRjduw2lVVBXC4e9IhQNnfy+i61wJIAhLyXFuX8V1W8t640jzEdHY2Twr9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2M59X+1Kq+GtW8UXUh71DVqJFsg5B2nKLsGig3hUt2Q=;
 b=XZeLLtZVfKmOWAlAIaqENSHvIrHYzZxlqrJVJSnoyYE4ii0RYZFj+5BBBoB1Z2XGB+bNg+/C7WD1nl71pnSHd5g33cuJ0saMjSm3XTWO2+u3+vlApfs8ZfslWBOK32ZaPrb0GpM7w4kP8F9Uv+MptHIjZF2lWUQDUgy7WHEZtL/NeIGABnSvButW8VNXjxjZr4J5XMY65t57ChTF8SBEdzZgDGt/1guwXm7NqOIE2ujxkuKSb8WjPukHtxkGq4of3AI4zBUCcak9XgYn0+HJqpcJ9dCL6xgwLdJcA9muQxrhSmXOfJWSPQ/XH+nKC7KsaHQQM4XNCcDFLsuD444BAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2M59X+1Kq+GtW8UXUh71DVqJFsg5B2nKLsGig3hUt2Q=;
 b=AIqx/zQpgqkz741/7ZC2qteyrqy9Wr5cL6a2Jrdg/w2mVv0qbfjBDmqJw+HDCjX+087/LjuUylyVPoEVWYmlnCGW8YmvqUpF7bc71d9Nctbk+n3PQL/OGiP/ChDA0PkbC9Awb5we24v5L3BtAdILswSlbSIDyHjhxX7PBA86zdk=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BYAPR10MB3048.namprd10.prod.outlook.com (2603:10b6:a03:91::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Mon, 22 Mar
 2021 14:21:42 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::50bf:7319:321c:96c9]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::50bf:7319:321c:96c9%4]) with mapi id 15.20.3955.027; Mon, 22 Mar 2021
 14:21:42 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Ricardo Ribalda <ribalda@chromium.org>
CC:     "trivial@kernel.org" <trivial@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 7/9] nfsd: Fix typo "accesible"
Thread-Topic: [PATCH 7/9] nfsd: Fix typo "accesible"
Thread-Index: AQHXHDSXcbgrryRs4UKHZBbbTCyhU6qQFPGA
Date:   Mon, 22 Mar 2021 14:21:42 +0000
Message-ID: <2AD159BF-64C2-4DA8-A339-8189C7BD8467@oracle.com>
References: <20210318202223.164873-1-ribalda@chromium.org>
 <20210318202223.164873-7-ribalda@chromium.org>
In-Reply-To: <20210318202223.164873-7-ribalda@chromium.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: chromium.org; dkim=none (message not signed)
 header.d=none;chromium.org; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [68.61.232.219]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 66e72042-f158-4e76-d65c-08d8ed3dd0a8
x-ms-traffictypediagnostic: BYAPR10MB3048:
x-microsoft-antispam-prvs: <BYAPR10MB3048BED51539F82FC53694E893659@BYAPR10MB3048.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ls7jQQb/Lhai0d6BZkNPkXYVNH/ZJKEQSXWTFon+Pw7SyGWFNKowwwZa+bAAx0/kWLkAIaWRCLmNJdXm/6EBSCswEUU+n14/XNk6qW3MaXeskKXdzK4Feo3Ft+CMQPCUrbGPaeySToQHq1jwzhtzUWsiVtCt7E2k2zkmfPLaPTnkVOuk2Se5mInMSa+eB5SNpfsOBFTHDURSK0KcYoQOowFM9Tt/lXlE2qC+OlO5IyZmSykfY5MPnCEqXwu8K9/p697cr1acJGIGIIJI1W+Mxm3QJ8Ffe9D5P8YIDwcNTcY/enNLOUmXJa7u3cSrEgU1ome9VGHdtE6rvfKmKELaTU6eRSBoRhKqAr5sDrSrmiZAgGacO1B1L3VR8u3/BDobxPtbgr8aU4xEaQn3C71O1uScpdXR5OeKu/ipDdSyiBfAOzIUcLkCbu/WFBCyeHeQ7HVR3je/h3T3CO0jNaI/QtRCYknMZ9qQy1x2HAoBvny03pkO0n9x151DnQCz2hmcbuk9I+qOJvS1j2QMLNvjJGvimvIT0GjDQRmMQd0AS+S5/pMpbmfS5YlS2zKnx6VrdbjX88gBUSHqSXBG0tPAUo6uu0dD2oljcl/O0V9WKhmZL2gSUGjEBFBAorHsErBeGM47wcslU6i3bmVEQBZPCkbNtlxiG9NuRSDwD3hCS976jSTe9W2+sgZnkUoesYZO
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(39860400002)(136003)(376002)(346002)(396003)(53546011)(478600001)(6506007)(6486002)(71200400001)(5660300002)(36756003)(26005)(186003)(4326008)(38100700001)(6916009)(6512007)(66946007)(316002)(76116006)(91956017)(66556008)(66446008)(64756008)(86362001)(66476007)(33656002)(2906002)(2616005)(8676002)(83380400001)(54906003)(8936002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?hDlB7RQrgo061pf6FWzQCnXnL7QijUV/dFVKn6Z5lucDXyYiLqgeX7LOJHl7?=
 =?us-ascii?Q?DF5O6FoLeGmq8939Ks4qTiKMFg87z4hRhPBGNBb3HM2UWDokT5HK+rDcuhu7?=
 =?us-ascii?Q?4CjV7dzytsplbMWiDN49HfTQ0OIHNrszIN1M0WKkxD79oXDNNQoBFPQy6WCV?=
 =?us-ascii?Q?Qj8OYGXsALmu5s4J+fkskFszkSKKKJus7dUsn3GCQaGteTDnhYm70//nnGp0?=
 =?us-ascii?Q?q1UvpUHdn+YAD3lafQ+IvbTp0t7IGmX71Q3+iVYNe65Kg6QGHtFG7ZMd1orN?=
 =?us-ascii?Q?wCX5yCDtcqlt5if35/hhSsr2aQdq8CpM3C3okECeVF4TFzMv9Y68RdTTc5tO?=
 =?us-ascii?Q?1kDvOxtlahHCZtNkgMDueDMXwWnKyXGwq+b/GeztQMBt5lv0+y5R/qOeH9Wt?=
 =?us-ascii?Q?O/EG2F+BFht8bONBxzmOHCCPfr921fWZimcZRwSelvBrJM03FE/0VfBtLLkW?=
 =?us-ascii?Q?IeDLo57zVnuJWT9ayTpbRrj8kP3Nj6H4b/hEw8xlrSAT1aoCvYkr4KexSvxy?=
 =?us-ascii?Q?txnB6tuTSDlcAgV3OgTLMZSth6UIDG8KCsVrY+gOI0UsbKDfiQsKYneTNmnt?=
 =?us-ascii?Q?n3GSZ3hpoz/QOLk56yAaIwuiNxUr9nFnt7ZVVKR0L3Pfrm2lAqjE3cUxK10q?=
 =?us-ascii?Q?Xtxt3zlHtGZqCV9u43wxU383Rl7nkc95ljIAYgyOE5dQ7yP0nTYRgkd3DZ10?=
 =?us-ascii?Q?D6BHGHJa6FcjJfPxTfeaLox8soTnNLklSmtCEMbt/SwDglUclHKR+1sxADbA?=
 =?us-ascii?Q?BIMEwyKo0ysEvWfo9IDUw5m2SQYcMVfVIwinatywQdiFy4c4yMpbyKxOA/uV?=
 =?us-ascii?Q?AjlQ11UPWJyPt7KVigmDf01cDEbgQF96Q0z6qrbmbvMfhVb+W1cSbUbthk+h?=
 =?us-ascii?Q?GzXGo8C/YBdnII5bzoPF7RJJboJ6akvDGA8kgWp2+SfVTwRnZ4SLM5Qmukj+?=
 =?us-ascii?Q?nQ2WQRymBAH4DME1c4CWUsc4Dlaar4SoX7RWQVnlEcPVb/J+hkIKbxW6is/0?=
 =?us-ascii?Q?Lw6u5s9iVUWcpp3uZHjh9kjacr4mCdUGiNGhAo1eznNrjjP3CzZJ29ePwn0k?=
 =?us-ascii?Q?HFz4C8O1SupMmv5rWA7XBL8TXGYl1hCjisoIHP0szI1wdS9oA2eoV/Nnm1i2?=
 =?us-ascii?Q?l/513qj38QXiRRY/yYUu35r0oLaxxK2GBlzoU1ixOJTFo8jqLHWTG9hliq66?=
 =?us-ascii?Q?Za9JV9U05+Tagt//bKwpK0G2Ts8KKXJfq7b+ueSiRXXuqLy1ixBUDead03Lc?=
 =?us-ascii?Q?ID6hBOO8x/NbHXBw/v4L33fN61O8kyEyIRFdR4F2UFfUKjVIcJW3T4XOzYdX?=
 =?us-ascii?Q?0yzXbiCifzG0Crtm83A7KuSX?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <959054C8FD58D540ABF68612A7D7839A@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66e72042-f158-4e76-d65c-08d8ed3dd0a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2021 14:21:42.1124
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eqw1CeaREheUm6TbNqeeio7Bjv/1Jq1UJaWXodQ+agoQZANtqkhjlF56hQie/+RfK6V+o0BWYP9F4eSUFptvFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3048
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9931 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=820
 malwarescore=0 phishscore=0 bulkscore=0 mlxscore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103220105
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9931 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0
 lowpriorityscore=0 suspectscore=0 clxscore=1011 priorityscore=1501
 spamscore=0 adultscore=0 impostorscore=0 mlxlogscore=999 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103220105
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Mar 18, 2021, at 4:22 PM, Ricardo Ribalda <ribalda@chromium.org> wrote=
:
>=20
> Trivial fix.
>=20
> Cc: linux-nfs@vger.kernel.org
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>

Thanks for you patch. I've committed to the for-next topic branch at

git://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git


> ---
> fs/nfsd/Kconfig | 6 +++---
> 1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/fs/nfsd/Kconfig b/fs/nfsd/Kconfig
> index 821e5913faee..d160cd4c6f71 100644
> --- a/fs/nfsd/Kconfig
> +++ b/fs/nfsd/Kconfig
> @@ -98,7 +98,7 @@ config NFSD_BLOCKLAYOUT
> 	help
> 	  This option enables support for the exporting pNFS block layouts
> 	  in the kernel's NFS server. The pNFS block layout enables NFS
> -	  clients to directly perform I/O to block devices accesible to both
> +	  clients to directly perform I/O to block devices accessible to both
> 	  the server and the clients.  See RFC 5663 for more details.
>=20
> 	  If unsure, say N.
> @@ -112,7 +112,7 @@ config NFSD_SCSILAYOUT
> 	help
> 	  This option enables support for the exporting pNFS SCSI layouts
> 	  in the kernel's NFS server. The pNFS SCSI layout enables NFS
> -	  clients to directly perform I/O to SCSI devices accesible to both
> +	  clients to directly perform I/O to SCSI devices accessible to both
> 	  the server and the clients.  See draft-ietf-nfsv4-scsi-layout for
> 	  more details.
>=20
> @@ -126,7 +126,7 @@ config NFSD_FLEXFILELAYOUT
> 	  This option enables support for the exporting pNFS Flex File
> 	  layouts in the kernel's NFS server. The pNFS Flex File  layout
> 	  enables NFS clients to directly perform I/O to NFSv3 devices
> -	  accesible to both the server and the clients.  See
> +	  accessible to both the server and the clients.  See
> 	  draft-ietf-nfsv4-flex-files for more details.
>=20
> 	  Warning, this server implements the bare minimum functionality
> --=20
> 2.31.0.rc2.261.g7f71774620-goog
>=20

--
Chuck Lever



