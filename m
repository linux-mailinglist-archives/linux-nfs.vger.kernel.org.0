Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B75134470E
	for <lists+linux-nfs@lfdr.de>; Mon, 22 Mar 2021 15:24:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230181AbhCVOXk (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 22 Mar 2021 10:23:40 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:35052 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230331AbhCVOXY (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 22 Mar 2021 10:23:24 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12MEJtk2161157;
        Mon, 22 Mar 2021 14:23:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=DzDXefA4yYZuEL/9IicB6qIgH7i1tCsmFeQ1Sm9sRHY=;
 b=wChqLQy4gcrx58iqipp4afba66A36d2QGxJCl+g0ab96+4Jvs6Tv9spcp6ViF9qCMT4a
 ilO8bLDey3y4mCAKSE4/lkVIu5B/85PIlZ/GZmR3dJxbyVgOB9kDKhkB6Bwk3Hkdbkav
 gLDFao0c9ag0B3hVwj3jiiRMopqtjoTHyhJmiRPvTHyDOaRhHv/xle4pjJf0lGc9Ab/V
 U7KATratiiP9YmC2aumIEamBvO6oPG2xf9535QE0g9nhvUjqAP3phQXnnKkMffsmAJ2M
 l/x8s5beeOnQzXeV5ujA2ZfUsOGt/nw5+fu1VllamXouS1/J7AAa5sY1N9nSpljMgKJl /A== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 37d9pmukhf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Mar 2021 14:23:19 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12MEKJC8094614;
        Mon, 22 Mar 2021 14:23:19 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2171.outbound.protection.outlook.com [104.47.58.171])
        by aserp3020.oracle.com with ESMTP id 37dtxx0utu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Mar 2021 14:23:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XIgA6eVA8w0RusWYNwu2AVUqVQFi7mst/DU3EP1gyulpTIKMbnrIeXtyxbdcdfDaSyLhOWFF5N5lf0WxJw4qZzDQQXTdmIuL9csaGl7SWmgAmB+1KJBFF46bF67JXgk25xE/SVinT8+CShBjRC67Z6ei+m/nDI7jYOeIpfQNO2t1P08MxOjokLHqTK0pzs/+j7gwxunBirGkCeHeWhosQ3G/deX+f5ibgwvlyO8HBLI5TMVr/FyE+XyBR2DHapDOFT2QvN3bcCiZs0xDhyck6g+m2QjEzEtiXvrxi6mUT3s6Xe9DJ9bbExUuvrmnWQD55NaWqDXdAY49Y5JER+Apaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DzDXefA4yYZuEL/9IicB6qIgH7i1tCsmFeQ1Sm9sRHY=;
 b=BTHiE5SmSucICFS6kGQwgBMRtw276X0hiY8VrhVmey0WpJxgQy6H1xLQWs64EH5sfdRPujNFYp5IFRt5Tt/hBh/FbRyhBUk8IrwsZfomWxX5kQ+dRo8cOjjGAh0WhdTzpKT0HA+Uam7rp6kkhoMsKQO3nOIppx3VK/4QFRM5D4KysTo3/UA1lXM53p23tci5OW/M5WW9FrqIPd3OZbYU+II0eJPzDAQPQMnbXVKfEelrGZ2QyhDGlIYsPeGdN/OPVs+2oaI1saKZbC4oc2j/CUCv/WqZwSguMCnaqoSaWZ80B9W1ZcukVzALWD/bAM85Kgu6ACKT8TQZA8OAWHlkEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DzDXefA4yYZuEL/9IicB6qIgH7i1tCsmFeQ1Sm9sRHY=;
 b=jQfA0nSRLIF5nQJNqiRbgQbWl/ARiIVoYBwOryCOuo4NYUmc98RpQWaiO5mitbeiL+BL4hRS4udIJ0RhOBMs/oRyMPvqKSW7L0pfa/MOYop2u3UFsJKhi8d60WaIhri+ad7kEiWVVMGwO8NptPuUVgyTdrRjKDBI8fE08fAki6Q=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BYAPR10MB3048.namprd10.prod.outlook.com (2603:10b6:a03:91::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Mon, 22 Mar
 2021 14:23:17 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::50bf:7319:321c:96c9]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::50bf:7319:321c:96c9%4]) with mapi id 15.20.3955.027; Mon, 22 Mar 2021
 14:23:17 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Bruce Fields <bfields@redhat.com>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 2/2] nfsd: COPY with length 0 should copy to end of file
Thread-Topic: [PATCH 2/2] nfsd: COPY with length 0 should copy to end of file
Thread-Index: AQHXHFNU830eg5Y6X0WV8w4eduDkKKqQFSUA
Date:   Mon, 22 Mar 2021 14:23:17 +0000
Message-ID: <A06DEECA-E34A-4E9C-B7E1-8ABBED01545D@oracle.com>
References: <1616112203-14672-1-git-send-email-bfields@redhat.com>
 <1616112203-14672-2-git-send-email-bfields@redhat.com>
In-Reply-To: <1616112203-14672-2-git-send-email-bfields@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [68.61.232.219]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5fe4be49-1ceb-4abf-0bae-08d8ed3e0939
x-ms-traffictypediagnostic: BYAPR10MB3048:
x-microsoft-antispam-prvs: <BYAPR10MB304848B21C9F6E4F2FD8F46E93659@BYAPR10MB3048.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vPBszxOM+P6/8oKZ9TmKUme0e/LZTIjRmPxrY5CQdRQW40iJwN2F08ckvoTMKpJZj+9MgmjuJbMVh5hZ3XQRpH3i1uvReSKF3cN3Xpy0qu2QEIHdWampcFF/A4ZxV+yTUPVPWjLSweXQFF0A6BY7djXW5nnGfrbaISESki0UQXaRbst09z1BvKfpCB6bxLwg8ZZeZxrzqsIA+27kWZzBKlUWwtxLEgWb1reW7O2plqV7/2uPiVJni1i/YMeZ3mADwZJ6OLt7U7OsHRC8Z7/c/kM8RKgK1LqMI15369I8V9ol1fUfe0H3EdaXUmkcWJFjC7/Y2GZeEZC3khtzabsIYP/L3xqTUzTJnztQmp6txfopodYD9wxlQVK7WmAnm3/YcIqxwWmePuFMNqOCM17dbZWCRFUqvpc1OasP4OIf73QDKb6j+4VEMeNk1tcWRX1tM5T87u7a9fE54HBGrfMjVmFv/TUEK8UPmqFkszVtdPXrwuYj18iT2QKA9ZIjGgp1PxUTea/YjbF3c6RDhJg0L99xV3fJbDllUZTm+ddKyBYJaIG0OwN+wul3DxvrjUD2xB8aTVm4Szfqu+EDe8QqxM/R7dq8yRWcsNFIMaFY2RvyGXY/w83CU6rEJwqg+CR0i702GeBbGRYhEGzNMfX9PFthzIzZnhAi8WBm9NQp4CiWmBtBLWE+IIdrq94oLBFjj0PeZNkzlM5tPN6CJZN9kq99iedSsrAqVYooFGlPc1oWims1b53FNgY0C1yzjms2G9Def0m7Ja1XqwLcJQRJ6A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(346002)(396003)(39860400002)(366004)(136003)(66556008)(66446008)(76116006)(91956017)(64756008)(66946007)(316002)(86362001)(66476007)(4744005)(8936002)(83380400001)(33656002)(2906002)(8676002)(2616005)(26005)(36756003)(186003)(4326008)(53546011)(478600001)(6486002)(5660300002)(71200400001)(966005)(6506007)(6512007)(6916009)(38100700001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?7XyOQBCGQHhCog9/UH1uOk0CyA+SBWs2/tmkke2jZeU6PLa228fRID7H2VNN?=
 =?us-ascii?Q?3IjVg5uB7FiJ7zO24cILBEKnTPfQ/7Xa8Y/beQu/0Qdnv+A96HG1nFf/Z3ua?=
 =?us-ascii?Q?Pr6MlX+WkLKLACAGwIXoPG2A0MbvFQVKr+26nPNaw4pdy0dvHCtLyS/I8D8P?=
 =?us-ascii?Q?ISESdoaIhbYAvYEqu1fZjHV76tiMi35dS3yybFlandU+fAbecf8EvIRkSzVe?=
 =?us-ascii?Q?ot1HYfjFOthmU7D70LGX9U7SHEOb4NmE5uqEhhxprRGUz7R1U6bxGKBM8mN+?=
 =?us-ascii?Q?Rayn5XqCvqebUb65qWmwo9oziqOsu6bfBjEGwKH8U3qGhwCmIRRum4lkR8UW?=
 =?us-ascii?Q?IRIiHjnlvCZbQq/qlLG1yt7mfVgokbYAqyIgsiZTJ9Rad+IC0XMTgLUi88LX?=
 =?us-ascii?Q?dxW1VANc61bixB0Ic+NMch9lo0y1cB5Fx7mw57i5bfm4Q+YKc33ygIohqaQh?=
 =?us-ascii?Q?EVGIqmyntCKZmNsMOwGRARhKGiFw25LSfsVFRXZsFp/zxxfDabfqbDnkHrQO?=
 =?us-ascii?Q?XpH9mYs4gYYhUdpiqw44auMWAZzFVk1dqwgmP1mx1JfxAEK1Al0xBXP71h5v?=
 =?us-ascii?Q?3iyTXVrhVXIQzcecNFPdvjEan2MvaJDzFD04CJzxCMT7phOITlesW59mlfpv?=
 =?us-ascii?Q?YD2dnQZ6phYo9FgatMraVBWFfrCSC0Umxa+SInoi2WJl5WecWXLsS8znPbKv?=
 =?us-ascii?Q?TxK37Pr1YyHPdAkju4YK1bm3sadwThSfTnLwczlu3xV499nBzuoKIXnLcfxD?=
 =?us-ascii?Q?aIpl2qVoIQlfuddxZtQutelAdo/20GiNLRIEn1VP4yPdh7LsxW6sV6qtwleU?=
 =?us-ascii?Q?5ZCmFqxgwKP5htL1Ia7pspEeh5K//iPMMmJiBXTDnyzMb8aV470W+a1xxGU8?=
 =?us-ascii?Q?osnZTOg8aMQcO4EKZaNPFdo9uUOSaJjyS92QNec4n+0ALBNT6W2sU22x8Srm?=
 =?us-ascii?Q?M6HhnmTpbnIoIp+uFWCfsNU6j91+7JFcGmVw7TWrthUGO1ChdmE+ASfPJTH0?=
 =?us-ascii?Q?s0/6VKFMYVI+ST/GawjXGBPZZAfl9JL8ci1yr9uFMlGxCC+CzTQwbFNQB9X7?=
 =?us-ascii?Q?13ZQu46VKFAcLDSWfTJg+rN6WtSHYMUpYWqXKnowOpSdpEGVDcLjeCiXR3uB?=
 =?us-ascii?Q?GYs5+zaPlkD3nze5Y/bSGcjWRNY/kCGhl+X1FsqsMFvt3b3pbgEXIm1vqTKe?=
 =?us-ascii?Q?JbNK9qdPDaRrNyINBKQDwXH/tIG1EoJPSFb2pkSDrUD0WG7reYzHjrErYCT0?=
 =?us-ascii?Q?rVzLEj9BKLPrPHGtiC84xX/jH2ZYRSOkJLj/q/56HpvPdDwrzCUeOKvc4zWj?=
 =?us-ascii?Q?1dfNNQtu3l9NRQ+svJP7YbXw?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <8F9358E3476C0548A9B822C70140B760@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fe4be49-1ceb-4abf-0bae-08d8ed3e0939
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2021 14:23:17.0318
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ngp1/LF5589OLjXY/zZXJl6DwqXQ01JBU52TVXAGPkGysOoeYHPrsQeAGngXPioEzGxGt2ZcOwCx6WSm6c4pQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3048
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9931 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 malwarescore=0 phishscore=0 bulkscore=0 mlxscore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103220105
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9931 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 phishscore=0
 mlxlogscore=999 priorityscore=1501 impostorscore=0 bulkscore=0 spamscore=0
 adultscore=0 clxscore=1015 malwarescore=0 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103220105
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Mar 18, 2021, at 8:03 PM, J. Bruce Fields <bfields@redhat.com> wrote:
>=20
> From: "J. Bruce Fields" <bfields@redhat.com>
>=20
> From https://tools.ietf.org/html/rfc7862#page-65
>=20
> 	A count of 0 (zero) requests that all bytes from ca_src_offset
> 	through EOF be copied to the destination.
>=20
> Reported-by: <radchenkoy@gmail.com>
> Signed-off-by: J. Bruce Fields <bfields@redhat.com>

Hi Bruce -

These two have been committed to the for-next topic branch at

git://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git


> ---
> fs/nfsd/nfs4proc.c | 3 +++
> 1 file changed, 3 insertions(+)
>=20
> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> index 5419342df360..62354229f0b0 100644
> --- a/fs/nfsd/nfs4proc.c
> +++ b/fs/nfsd/nfs4proc.c
> @@ -1387,6 +1387,9 @@ static ssize_t _nfsd_copy_file_range(struct nfsd4_c=
opy *copy)
> 	u64 src_pos =3D copy->cp_src_pos;
> 	u64 dst_pos =3D copy->cp_dst_pos;
>=20
> +	/* See RFC 7862 p.67: */
> +	if (bytes_total =3D=3D 0)
> +		bytes_total =3D ULLONG_MAX;
> 	do {
> 		if (kthread_should_stop())
> 			break;
> --=20
> 2.30.2
>=20

--
Chuck Lever



