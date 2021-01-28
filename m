Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C112930791B
	for <lists+linux-nfs@lfdr.de>; Thu, 28 Jan 2021 16:09:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231649AbhA1PGY (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 28 Jan 2021 10:06:24 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:48034 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232454AbhA1PFy (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 28 Jan 2021 10:05:54 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10SF4jIf132909;
        Thu, 28 Jan 2021 15:05:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=ybFBCebPTNNK4jU2wyuUl88EsWtCfanHyqxinEL8QrA=;
 b=p04sCoukSgSUifntrkWbJlefCsyh50a5xfw15Ekz3IxbWNIMKEntoXCIW/RAV23ant4q
 Y3wsNjYauwEk5iAiMYt5fdRxz9GitINU2/oXPWQIn9zobYpXU1Uv4vEC7L9eYzKKJwT5
 QFV6FnEFXWViXdvSWlknPVE4cC+BYaNYjwVHg5WMECtphqhFE1L7rzKk5MRZnoRuZ3bc
 1RlO+54YQht+cI7uHPsatAbzE6zwpr017RUvNa6/uuptvYs9qXVlrdrWgT6OM+cALTif
 Mb09DH5HBCi1dUd7DzMrfn/jk3RwiPT3zy/ggnRbsQTbQz5jsRFPoPIAkMid2tahvdr4 0w== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 368brkvg73-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Jan 2021 15:05:09 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10SF1Cju008897;
        Thu, 28 Jan 2021 15:05:08 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2171.outbound.protection.outlook.com [104.47.55.171])
        by aserp3030.oracle.com with ESMTP id 368wcqsyff-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Jan 2021 15:05:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=geFhNchZsuAk45krI7G9IgyN9ubFciqrWue/pTrP8JxsP3kvf8d7C9I94aG+YKO7YbfsHH1dH4gOMMm3ejPCGnoQtkIz4ulnadyGHdSdOzja6uYwsLvROSTch8m4bmT6/Jv8pPuZphP+cMv7cFbtP/BriKKkYpFy1BjtRbkz2alLplqKTT/pYcYD8c3v9nHiNjK3OiPa+qtI/pGkbujOeJSEdGbPvI7oF6JhzjOEUvb0qICKH0duLMdNcc0KZy16h10vPjvt6LjU3mDWy1x3LX6WTSg5tyH7gqv8Z8bmeNU/grQYZ2T/YFgI9WFyVFY6MhQGPKZZF1inVx5gBZFSwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ybFBCebPTNNK4jU2wyuUl88EsWtCfanHyqxinEL8QrA=;
 b=KAtQs6Gxm2/6qjelTuiSI8amceukYa2Zcc4Dfik7D5FKfvNs57rtR1659IY1gP5kV+CdnvzVeykgiVxufzuu7AjRAIEJR6LCoUbcSY/RBuJCYgu3t36mIulp10FlOxUMoXa7pWxHLIXZCZE5Wefa2eEmygkbj4ps8Myc6QA06owC6q2FM0+A1G0qWh+UIVP2L2D41tGpdaxObOFmyXduYTPKjj+k/LHuigNb9UGeGDMaa1IKx35cRadjZxXQSWs2+JRLnXUZ4N5p4+WwHlH0Jfo1L1Hvxox3JNGQRFAtxy2uqyuDH5tlUPJmWy6GBV67Q4x/QaRFz2UnSQXuT4FhiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ybFBCebPTNNK4jU2wyuUl88EsWtCfanHyqxinEL8QrA=;
 b=EnitQwkHqaMAifx1KcW5tp+DZwcJoLLkPZ8R7jwwH1MPmqljWc/8gLwy9J+rfVopU7z4MS0OoKdZVcFSCMxE3z4W26620f/4xi0hocr5+8wtQn+VrDOMNeQsyrvmdAsl+ZD6fMv9coHDxD0HRZWg/ZsuiH9Tbt1p6PN5Gc1aXuc=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BYAPR10MB2517.namprd10.prod.outlook.com (2603:10b6:a02:b4::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.17; Thu, 28 Jan
 2021 15:05:06 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::6da8:6d28:b83:702b]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::6da8:6d28:b83:702b%4]) with mapi id 15.20.3805.017; Thu, 28 Jan 2021
 15:05:06 +0000
From:   Chuck Lever <chuck.lever@oracle.com>
To:     Colin King <colin.king@canonical.com>
CC:     Bruce Fields <bfields@fieldses.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][next] nfsd: fix check of statid returned from call to
 find_stateid_by_type
Thread-Topic: [PATCH][next] nfsd: fix check of statid returned from call to
 find_stateid_by_type
Thread-Index: AQHW9YTPCLLIIxyNd0a0oDXS4LB/Gao9IuIA
Date:   Thu, 28 Jan 2021 15:05:06 +0000
Message-ID: <793C88A3-B117-4138-B74A-845E0BD383C9@oracle.com>
References: <20210128144935.640026-1-colin.king@canonical.com>
In-Reply-To: <20210128144935.640026-1-colin.king@canonical.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: canonical.com; dkim=none (message not signed)
 header.d=none;canonical.com; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [68.61.232.219]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 212166b5-d0ec-4401-5200-08d8c39e193a
x-ms-traffictypediagnostic: BYAPR10MB2517:
x-microsoft-antispam-prvs: <BYAPR10MB2517D63C78B14C94C53612F193BA9@BYAPR10MB2517.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:663;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5XR0ddYEwv6z6R6Kg49g8g2YIyMtbtt64VASQF+dHyezwKQZOyEvmHMQkxYSawjZdZ2PF3RFGYfPJ0HIgKmrgcFtrLdonwJZflkJ66uGRTcq+L+a6P7aMLPmbHk7+LpI30wdPUiwnxt8z74HiBDrw+bs2SolAX9j/fh5IlxPL1S2aL0RiTLPMSCjdr4SeFyzcDEQkF+OT5rHPzAaD7nfCWtj/bUfpzu+GMo2WGiShbk/PvStFZJIjOS58TG+hrjKZjHbjy5XLiKdiDzjX7vtBf8fiqul77k72vb/yAywxQf731kNDyKyJ0tPCaP2Lwej2qMbNa0h80INKb5IwaPq13OAVJl5Cbs18qtfiBTb2kZPFtG6rt9AWwWDc/WP9O7cVrPbt7PyWaWd3LqAAPzF1D4j9vKxThaULoEUPZKKv4qcxg+6aHz2S9iMECO0OqYH4bzmLsCTI57yYjjzACxbLvlwfpmLtvkD2PUY8Z5qaY2idKlUPUFep66YEOZR7yASJdZ/CuqxftVgthtBMclxD+Y9h9y/hhEPAPLK1BhyZSUDStER8MPRX89iS8TtiJ/SMyprNLu4yWwOW9SMA/h2lbAIAmX8WELWDa/8q1nhl4w=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(396003)(346002)(376002)(136003)(39860400002)(316002)(6512007)(86362001)(2906002)(5660300002)(4326008)(44832011)(66476007)(66556008)(36756003)(6486002)(76116006)(6506007)(66446008)(33656002)(53546011)(54906003)(71200400001)(6916009)(66946007)(26005)(8936002)(91956017)(186003)(83380400001)(64756008)(8676002)(478600001)(2616005)(37363001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?N5IAtfUEN1CGvmdyUrKTrWKQ+EOP9R6fH3ZoAoqATciSPuNB9AXGW1FC7oR3?=
 =?us-ascii?Q?ND4r48RI+2eKf2zyMlP4xHQSzIo33XZOWJGLCIIF67bQfez1dbQ3BpLlN2Rp?=
 =?us-ascii?Q?nInlrU5W791rE4RMpoaqpMxnuvF/8s9zfS7FYaCsQVouUdnP/bvJzR2RSLiZ?=
 =?us-ascii?Q?hzrSCVTYCGGwUhw+KcrHlcQ+TLGRrTgbdPiBvoKpj7xl67kXhZvnVVLzlHno?=
 =?us-ascii?Q?Yf5UxiJzxODxYo9ttuvgToFHEbpjwdF2wlpqJRXRE6YO54Udx4nkNjGX8hSi?=
 =?us-ascii?Q?MGoCZ8qkqA2Ytmih7EJ1mfqk5jonbgMEaC7nNyb0+VX/B9pI9NDqS5d1YU73?=
 =?us-ascii?Q?fw2kL3XoNFQMqTyXNYv5gfAGABo/4z+tkzN2f36MGassgTfdqpvu3LUpmLNz?=
 =?us-ascii?Q?VzFQqPfN30xpXB+A93CydGY2GFBta1siofUvpiBDAHzm2YScI1HqrIbLmIMg?=
 =?us-ascii?Q?GBxH0MHqwqK5vSvBgJkI3B62jInhvB3wSzsRJBbaYETQ/UyyoRIcatSjMaR3?=
 =?us-ascii?Q?vZfckr7z8U1ng5Qz9Cc/pVu424D1479opRnabGx/XwIzGdFkJDCFfwxSzDhw?=
 =?us-ascii?Q?2A4umEJklG1cONDfBmCsANfVEq3oUb6UkSjfYRHVl2W4k/AMBgd8Cw0Eruzs?=
 =?us-ascii?Q?LzahqE8LXG59+tl2BrEqVG1xw3gNJMx6W8u6LaRiajLukLRz+iYrWTZsJ+a6?=
 =?us-ascii?Q?dkkG6Zl36LWkBPXNvF824JzmH7mkty2Pr+f+kzhJIoiETtLG+lOnYMp63ibz?=
 =?us-ascii?Q?ZLYWwlepUM8OMbXBA2eBkoLZalTHVnjyOimdoqZD8bzJhVmivbyP1crPKMRJ?=
 =?us-ascii?Q?wrajm0uGjQQGjzcahaVEA0eMIAoCmWwNrRBCcVzcnJXp55/BFM5c4MdURNtQ?=
 =?us-ascii?Q?qM3PClINgnVWEbM5LA+4oXYpu4hDt9y2mDhPjNWXID3l8CBb3bdwZK/hc6pQ?=
 =?us-ascii?Q?RAEuLGYcxVP6J4j3yTks3egbSXx1PjybKk1/LDkQ5gGezQ8WwGZi5OlDtlaL?=
 =?us-ascii?Q?RbvYMLkvpWFXs3iYd5On6bxEnH/xp/v63Z26MxiDC4L7bDlGlAPPS9jQySp0?=
 =?us-ascii?Q?V3W+DA7G6XWe8f4riDt+h/jq9cn0jg=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <FD4CCB98771DBE43BFFAE0EB018E71C2@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 212166b5-d0ec-4401-5200-08d8c39e193a
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jan 2021 15:05:06.7361
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dqfcIRXJKbrQ2TYTFO9XthBfM7LgihuoT0BY9FElAwwkdRSGAShRozE4ijzbGdq5Q8ihGpEutEHm/oS5qk7l8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2517
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9877 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 suspectscore=0
 phishscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101280077
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9877 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 impostorscore=0
 phishscore=0 bulkscore=0 priorityscore=1501 mlxlogscore=999
 lowpriorityscore=0 spamscore=0 mlxscore=0 suspectscore=0 malwarescore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101280077
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Colin-

> On Jan 28, 2021, at 9:49 AM, Colin King <colin.king@canonical.com> wrote:
>=20
> From: Colin Ian King <colin.king@canonical.com>
>=20
> The call to find_stateid_by_type is setting the return value in *stid
> yet the NULL check of the return is checking stid instead of *stid.
> Fix this by adding in the missing pointer * operator.
>=20
> Addresses-Coverity: ("Dereference before null check")
> Fixes: 6cdaa72d4dde ("nfsd: find_cpntf_state cleanup")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Thanks for your patch. I've committed it to the for-next branch at

git://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git

in preparation for the v5.12 merge window, with the following changes:

- ^statid^stateid
- Fixes: tag removed, since no stable backport is necessary

The commit you are fixing has not been merged upstream yet.


> ---
> fs/nfsd/nfs4state.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index f554e3480bb1..423fd6683f3a 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -5824,7 +5824,7 @@ static __be32 find_cpntf_state(struct nfsd_net *nn,=
 stateid_t *st,
>=20
> 	*stid =3D find_stateid_by_type(found, &cps->cp_p_stateid,
> 			NFS4_DELEG_STID|NFS4_OPEN_STID|NFS4_LOCK_STID);
> -	if (stid)
> +	if (*stid)
> 		status =3D nfs_ok;
> 	else
> 		status =3D nfserr_bad_stateid;
> --=20
> 2.29.2
>=20

--
Chuck Lever



