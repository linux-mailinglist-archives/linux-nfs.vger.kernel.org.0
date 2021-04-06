Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E1353558A5
	for <lists+linux-nfs@lfdr.de>; Tue,  6 Apr 2021 17:59:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231734AbhDFP7S (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 6 Apr 2021 11:59:18 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:52498 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346176AbhDFP7N (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 6 Apr 2021 11:59:13 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 136Fj4aa181639;
        Tue, 6 Apr 2021 15:58:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=/QZ3puQoiEzFGkg2+U/5Vru6/B2gW2f/O8ihIJL2D50=;
 b=Xxp0x3DNcJPLKwwzi82ykkOsStkOZH1urGF5eefKGmCh/2tDky5kmcXWiJ5n2mGaAvlP
 3wNHb8+KWoZh+33emHA7xq/u3wIOwwiebY6mLUaOO7TiWA49JzyygbJ/MzsPJj2DoJq7
 hknS4NvkwkO5NCuButnIXcCkjbFJBWvS6sc6u0vVRyksHsdvsRLUOd/wyYxXaDW9GoUg
 lDjhB2D0bd6tlfgedp1iy4K9oU+qMZfK2eRot9dPyAPfyLQP+mA8QqeBtUdcH1WBAp1v
 8cVwXr6vY4smkKtbOCRiI4NW912xZR7yNcarvZD54xdyd4xDEUKq+Q7TV0QdzMORSHDW 1Q== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2130.oracle.com with ESMTP id 37q38mp1px-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Apr 2021 15:58:55 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 136Fk2Wg065319;
        Tue, 6 Apr 2021 15:58:55 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2044.outbound.protection.outlook.com [104.47.66.44])
        by aserp3030.oracle.com with ESMTP id 37q2pcpp53-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Apr 2021 15:58:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gg2h3lhhokiRemXoa8d51xUOIlXsfCXZ8HH5/Qr3wxQSivWm12PEuYJAgTy1jXldPH64J5tIpe52d2f65Richi5bKJ/z1feHt6Pf4IXFnBI9uXh083HuysOTb6p+TSikz9dNuZbWOcH64JaSsGQIYJTZ+7CbaBxZO7fWudP2K6CNhwS2dbu/pHMXAiL9qrsC9YtfYtQ84OGj6+cEW7+YFcZQSaklO+fPnuG1piZb22zk6vOqIru7zt43hXj7q2TotDMO6QedbzDdB8qvP3HY0/pCL15kSOL0nAcOPYNfE65AXKk0enwvJWFd3cEJEOx1NupO6u+66xkioCfz0ikIpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/QZ3puQoiEzFGkg2+U/5Vru6/B2gW2f/O8ihIJL2D50=;
 b=oPcP0oGdXBEu1H1px7mq+XCA1qA8vDK4OLvmoGWjdoUynsaONJ7e4fxgNj6klDmxAgx5i42OjW4ED/jvEnpRcZn4jn0ZDeJ986tNBu++ZwoVWDx+P2unPuqZxMDhI/tdHCkIyR8SRH9Y1Vu6t47Go9UF9FUrX9jmPBxd93nj6DfFrMWRKck8aWeRkOvn/eDS/PFVEN86HTVrARGmSlzLi7K9xcOI9kRReU5it7NsKwfZW+aL/nN3oaw4S7UzXtfBAU3CTjL9Ibtg9FEM3vt81BFlbNHO0kiCLyvbQsHl5eAfZeGpF57c185OYhGCy5qkRAUSx+ChRNpbe1NJ8JAZIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/QZ3puQoiEzFGkg2+U/5Vru6/B2gW2f/O8ihIJL2D50=;
 b=BQ3rb7VNuPUQiT5E85HndybGBEaitupkjE0B9OiOjXQXwyds0c0zqMR1XG8ZVzPTlktfw7jLt5pqPCdvkqpFh8l3//GyMNQnJAhgVOGVOgWG2PEtJJoKHIrIkB90IBD1ejvcvjfsPDuts2l4SgnHEirx36VkpKUcxKs84R1CBfA=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BY5PR10MB4387.namprd10.prod.outlook.com (2603:10b6:a03:211::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.29; Tue, 6 Apr
 2021 15:58:53 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::50bf:7319:321c:96c9]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::50bf:7319:321c:96c9%4]) with mapi id 15.20.3999.032; Tue, 6 Apr 2021
 15:58:53 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Huang Guobin <huangguobin4@huawei.com>
CC:     Bruce Fields <bfields@fieldses.org>,
        Jeff Layton <jlayton@poochiereds.net>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -next] NFSD: Use DEFINE_SPINLOCK() for spinlock
Thread-Topic: [PATCH -next] NFSD: Use DEFINE_SPINLOCK() for spinlock
Thread-Index: AQHXKt2V1gcSxm7bVkeOdiAjqSPoqaqnpb8A
Date:   Tue, 6 Apr 2021 15:58:53 +0000
Message-ID: <B66CFC6F-5BB6-467D-8F01-A92060E0C8E2@oracle.com>
References: <1617710898-49064-1-git-send-email-huangguobin4@huawei.com>
In-Reply-To: <1617710898-49064-1-git-send-email-huangguobin4@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [68.61.232.219]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4d1beac3-c7e2-47ec-7a13-08d8f914e088
x-ms-traffictypediagnostic: BY5PR10MB4387:
x-microsoft-antispam-prvs: <BY5PR10MB438783A07143D0F906F1549993769@BY5PR10MB4387.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3968;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 14BIJh06t0wvXIHyGu4KbJyrvgu2Q/d+/Sqs0jorj2xHOtRyW4iyYy2wWwRcJABljRYiRGqSRS8R83sYdGEHXvivpnc37u1KEy0AELOwTyOMKD8T1NL7WM1O04XqPX/kk3LwxXJgeR9B/yHKfzGcZrKUCtdEd3ZnL2hMUW01AGmcnhheKFqFLdP50h9PDWZv338XPESeI746k8cOw2kUVsQgpym/6iQcU+brToFZ76mlS/2g5epR9q8qE26vtab2SQjF99ZsuEU7VPkhnZelucygedbCPN76h8+iloDzyAZJcl+qkoR5Y2EnZY7XSivW3g1hJqoV/Md42wsffoyKlHxzCorIGO9PIxeqMaSTQjT7/Lbsas0pHO+0P4FXVet7E+4pwDoh+ZX04oL5VRtmEKeYHhQ+7Pt0gEyGRxo3Tjt1JNV267HNr8VUtKlmN4ycOcpmZ9SFzG9F4ufh9vbXZwTGufHgeNl6Hm9C1NPD/Wqrgbik+OJKIPbKOmw16i9YHFnAKJVGQrhIA/V6KgcvDf1KK+9A2pwm0pH9rOn3MU5wFpEz+ER0Kg5/fYWml2DqpQM+DdzXeAw6PABvQ67E+AES4LSUE4ca1hZz/X1ujho2iuy1NtFdsqY23W2pGtFNcm/7fzzsM4z4KW7PmjL+W+QNVquC7VKg9V1GnJjM1l2WQoeH/pIze6qrj5hLyhdF
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(376002)(396003)(366004)(39860400002)(346002)(33656002)(478600001)(316002)(64756008)(66446008)(91956017)(4326008)(36756003)(2616005)(71200400001)(76116006)(66946007)(5660300002)(6512007)(54906003)(38100700001)(6506007)(8676002)(66556008)(83380400001)(26005)(86362001)(186003)(8936002)(2906002)(6916009)(6486002)(66476007)(53546011)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?LXyS4C3UzjmOZ74vR7mOX4Rm78sOy6qXFC1UePpeJscnZ9Jhe/fP+rp/uhwX?=
 =?us-ascii?Q?r+kCWjlm4PKcf7Mu+K6goGEij7YqfXOR6HyaQobHyJRdf9+R078sDvnsSyMy?=
 =?us-ascii?Q?5dgiibuGP5OUIFIiLehb/4bI2bWWVE+kV6jt+J4pdNMz36qywdBXZsG1JwTa?=
 =?us-ascii?Q?M2/q8bqTwZt3F65y4vxozxt9ogohCshyI8To27Ttd/RlqQ0hmTCNc9jtXShQ?=
 =?us-ascii?Q?qSadsc0dch4OgKVNy+2RocY3ezQdzQxgYNBUTIEfoy5dZTixkzjrgGDAiE2i?=
 =?us-ascii?Q?/Ada5nu2bHXVGPSUoOvkH7b7CvzI0zHTRBON6+ZCQ5ZEfAiFeY/90RlQvj+e?=
 =?us-ascii?Q?OOcq/8Dz+tysGZS8oLKnYh7b84CTd7CDZAQTzLI8A905t3biEapcZjhMa2+H?=
 =?us-ascii?Q?Mj+EHFUYpTxw/cDtVgckTGdEQSW5q7KG+3fuUHtAXD7n5XcbgGLM3G++D4D7?=
 =?us-ascii?Q?+dqOHsjLFRghFmuy9sc0t/dW4uw0CGK8zCGrZZm4/uoyutlKerg5nldZPJJS?=
 =?us-ascii?Q?J/4coCn2/f8pwFYkXWO8V8G6fybTUJDZZhDwUtal4wkhlTPpX1AVjKq4zFpT?=
 =?us-ascii?Q?ni8qqJTttlJxg6CqIpOBH2q+55A2VqM5Zwkk0utKduWkt7ZpwAwWQTtLgpCc?=
 =?us-ascii?Q?pkIG2c1VQ4OP0MEWLJtEJ/RG5Dxd1q8jH/naj+1eBunX6B0KdZG/5nfLKHtv?=
 =?us-ascii?Q?MnXN174b1bgHHyZpJ1Am+JS2kjkPrkCy/2yydBZhtO9yowwBj39txJsmFtrH?=
 =?us-ascii?Q?5/DK+lWq9UeaiATRhYdgTlOealNgO48/o7DP5q/PE+noa5gEpriOoLJs5d7X?=
 =?us-ascii?Q?PMkIOzApv+oa/yLcA5Xo5/EBumYyzZGZAeANazvNq36m5nMB6J0SKAUE+Yo5?=
 =?us-ascii?Q?sXhq8mOsJ6fCJDVP6kRe5kbSqbLJ7Dtfg9icCqa6RAD5P+Num8CvMqo+Vcpw?=
 =?us-ascii?Q?aWZaeopYk7mKSQsOScf/x2V0YU4DoI5dm/hRsj7HJyuNiH07m7omgrryGEFT?=
 =?us-ascii?Q?jxOVsLHZ2fm1snhznchA+Tjug1CbqLyDzpbcCSb9kQh+ueEFAo/UYVXhu4sT?=
 =?us-ascii?Q?NjHi25TPzs/G79sO2RPuaJuQxhbvHUwSkNMiq+KM+tJlwBMejW7Suxp6Re0o?=
 =?us-ascii?Q?u48Le+sgYoLmAsUb/QAKd7pyV2EfximPuD4mD/6Kfhld+1o5fKcAPuNYntg6?=
 =?us-ascii?Q?3JcFsMEqja51XjpAyg+ZC6RSry0NSz9jSJLFdQNNi/dz+VtwW5xIoZwnrJmB?=
 =?us-ascii?Q?/3tqlmmHxV64G0P7H0amjUh+phKRuqhiPUMdviEkBP0MfR9ZvUkGrCu29u+K?=
 =?us-ascii?Q?ch+lGvHMAhgtnU2uoJpUUv5o?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A9BC65B28F86E34EB3218F5F54EA8E83@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d1beac3-c7e2-47ec-7a13-08d8f914e088
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Apr 2021 15:58:53.3691
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ds6KiNG3H+9I904WTJhS7dDgNb9RchQ7LdtbbTVBGheveL3hPgExRKIk2+eDB4H/sJx0j93cx7JDuj7QukzJDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4387
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9946 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 mlxscore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104030000
 definitions=main-2104060106
X-Proofpoint-GUID: urRfQfY5b8G5WGvEkKaxiVPalhrwhon3
X-Proofpoint-ORIG-GUID: urRfQfY5b8G5WGvEkKaxiVPalhrwhon3
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9946 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 suspectscore=0
 impostorscore=0 malwarescore=0 priorityscore=1501 spamscore=0 mlxscore=0
 bulkscore=0 lowpriorityscore=0 adultscore=0 phishscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104030000
 definitions=main-2104060106
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hello-

> On Apr 6, 2021, at 8:08 AM, Huang Guobin <huangguobin4@huawei.com> wrote:
>=20
> From: Guobin Huang <huangguobin4@huawei.com>
>=20
> spinlock can be initialized automatically with DEFINE_SPINLOCK()
> rather than explicitly calling spin_lock_init().
>=20
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Guobin Huang <huangguobin4@huawei.com>

This change has been pushed to the for-next topic branch in

git://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git


> ---
> fs/nfsd/nfssvc.c | 3 +--
> 1 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
> index b2eef4112bc2..82ba034fa579 100644
> --- a/fs/nfsd/nfssvc.c
> +++ b/fs/nfsd/nfssvc.c
> @@ -84,7 +84,7 @@ DEFINE_MUTEX(nfsd_mutex);
>  * version 4.1 DRC caches.
>  * nfsd_drc_pages_used tracks the current version 4.1 DRC memory usage.
>  */
> -spinlock_t	nfsd_drc_lock;
> +DEFINE_SPINLOCK(nfsd_drc_lock);
> unsigned long	nfsd_drc_max_mem;
> unsigned long	nfsd_drc_mem_used;
>=20
> @@ -563,7 +563,6 @@ static void set_max_drc(void)
> 	nfsd_drc_max_mem =3D (nr_free_buffer_pages()
> 					>> NFSD_DRC_SIZE_SHIFT) * PAGE_SIZE;
> 	nfsd_drc_mem_used =3D 0;
> -	spin_lock_init(&nfsd_drc_lock);
> 	dprintk("%s nfsd_drc_max_mem %lu \n", __func__, nfsd_drc_max_mem);
> }
>=20
>=20

--
Chuck Lever



