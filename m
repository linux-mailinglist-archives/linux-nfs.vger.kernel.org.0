Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5997A3682F0
	for <lists+linux-nfs@lfdr.de>; Thu, 22 Apr 2021 17:06:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237379AbhDVPGs (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 22 Apr 2021 11:06:48 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:47270 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237164AbhDVPGr (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 22 Apr 2021 11:06:47 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13MF4vZR025765;
        Thu, 22 Apr 2021 15:06:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=fOh3sgYgPGLR36mtaV1UQOmTeuEVcWY6+Cyf8jancSI=;
 b=koG2vlvPkFkAGPgEwI7xEB6oIIiqPzBDRJUtd8/QbkaP6okcqS3qows/IzKEkWkBDf+e
 3V4mdqxlIsIGoV8UKpcKbv7GxKpMGHdOE/J+P23iw+Ov5TyR4cQWcOAaVMRgZonKKKJR
 VXj+8gnZpMT9qu9ZhYUY+Af+YLUdSP2YASEO+3qheQ5+YEs9q1G2OxS7yWKmfuXqApz7
 4EGS3875d0Gdyd/RwdOnWZxl5IXhopGsRkmFWnvdV03ETNeExWAozmyjf/Z9uIwI0vOo
 IgZsAJwJMl/46yHYx5V+TxCQFiqnRqb91fUdoQsdLpLycciJXfmvvUV77vLYSOFM2vs5 jQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 37yqmnnr5j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 22 Apr 2021 15:06:04 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13MF0KN4082063;
        Thu, 22 Apr 2021 15:06:04 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by aserp3020.oracle.com with ESMTP id 3809k3nt6b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 22 Apr 2021 15:06:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iDixERt4NeD0AMaRaLkieqrTY5GBK9+AODppuo3ZJMV0WJXoXBrcDO+8gIUL5KI8jnK7GJE6gaDG7/I0VWnZNYCiMgBR+GY1goYeImPdpwiPhTXahHuzEfmZbkGW5CLfSuTD/MuUR9bcXPIK0mtPmLDZ7dK2+ZK/wMrtnEYTybAnae6vq3wN/ey7qNC6Z8CwyFy938pHOZxiQ+KAgHSbqdZXUFfVgQZsr27drBhHGydKN1aRa6kSlMVYzMqG5cT/07wENt3m6yESVegnC1Jq6kpnowBU+PCAtQlq70fWjj2d3LAUPuLXpTwzGqco5VpqCacrn4+uEqAYF/j7g0KIgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fOh3sgYgPGLR36mtaV1UQOmTeuEVcWY6+Cyf8jancSI=;
 b=DmoH0DmjgcXIqRoXtupmm1PkxJX4UD7nTMYF377xkj+Zu+OdFXd4SAVQys4hcgkVo55wWEZLSY4dIiQGvXvNETnX7QP1nG1rLaF7OjTM5SDAZweLXiW0LVKgrKFdZTA8QE+bP1GTfPYJ6X01x3bmBundvWswoq8BcwZI0vZUdy3mxoWoNcD+PqpZ25+JOd2jz9W1XSgbTh9IxMUyhv0RBkS2iG2r56cfmMWapVzwHAM3+7eGQYaG8Na9dbMJe8KZQBm28vV6w/2Z5HMT6OMJcghT4f3lVYvFMdI4ocbEptAJU6VLDB91zdWr7m4+8nt7Ta0syafnPTz12n3J8ZjWTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fOh3sgYgPGLR36mtaV1UQOmTeuEVcWY6+Cyf8jancSI=;
 b=H1z61DFe+NyljwyrMtZZHvV69si1XYj/KZVc1k16rCp48ALNvFzNMFU9Rc8tToTPEZXbkvXNxhiWGcyvYV0UhTHIkIPTviXc7VQijT4pvyUbo29zYmmxoObHmsLzE4k165tnRtHhLKC0xG4D6+z8A6Og7pDAM0dDc31GSkXAtH0=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BYAPR10MB3382.namprd10.prod.outlook.com (2603:10b6:a03:156::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.20; Thu, 22 Apr
 2021 15:06:01 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::50bf:7319:321c:96c9]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::50bf:7319:321c:96c9%4]) with mapi id 15.20.4065.022; Thu, 22 Apr 2021
 15:06:01 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
CC:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: Re: [PATCH] SUNRPC: fix ternary sign expansion bug in tracing
Thread-Topic: [PATCH] SUNRPC: fix ternary sign expansion bug in tracing
Thread-Index: AQHXN1fzhpVCHIyMU0O+ZfmPUZCAqarAo1IA
Date:   Thu, 22 Apr 2021 15:06:01 +0000
Message-ID: <468517FF-2C98-4A15-8B9D-16C2212AED13@oracle.com>
References: <YIE+fTOOnC9PLXbg@mwanda>
In-Reply-To: <YIE+fTOOnC9PLXbg@mwanda>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [68.61.232.219]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 39c24e3c-2057-46df-6291-08d905a024ae
x-ms-traffictypediagnostic: BYAPR10MB3382:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR10MB3382F27B54E8648E6A4B88E193469@BYAPR10MB3382.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HjUIMkt/p9+/xxCqWYiJ57d89zEFgzDBtA1naR5/Dys+iGjcgHFktvicfuwqGUkW2Sq00rqPveeFTBjJiVsktAqw0DOl2KqqJaBwx7BlhVqBqFsEpVddGZeDfSub2/2o3pSZtMCfF2INXMxaLklDcnkWMxroV4e7dyU+3rEEZtjPwBspoFjmFxKw3IIx5BIjPIYonEPty9ctnpIce1kIad/khQifGxMY5MywJ7SlfF9Y4mzihaF1kXgAw1DcSEVvriURx1MIWBuB52L/sjjl3Cziy+wFCmMhnG2tD9cNDFRSFhsp0rwqOZ6U1bYPvapg2ytoRit8gpWBKfQYLd67YzRaiwST4AivoSr1fd8un4bOILBXVNuHpIZLNJ90cXuUIfH3pDXPgvhJiflIxgJqeheOWFWP2arBW2jw2DXWIUhsv5qj48DZAPytID2SzlyAgSoX9KG8qyxM7vrKEcWh9DUFgIfzDIN47ocTxVvc8pKoTPVEjs/xLyK0pE99X5YGRIEb0sdSxM+8GwlU4MjdNRwatw4sKzI34RXCvv9RMXINGJD8SWqG9mqk6Y2bOu3kCcysqPh7gg6YFK5+8q9JgTftgI1Dlt2qfYx/sdR+jR+e7n/IR+oNk4FUB0EZrg7+x4epBRYZsLWgfTr3+a8IeMwCLSfUqiunG141bdN6Keg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(396003)(346002)(376002)(136003)(366004)(71200400001)(86362001)(33656002)(53546011)(6636002)(2616005)(36756003)(8676002)(83380400001)(26005)(6486002)(478600001)(316002)(2906002)(37006003)(54906003)(91956017)(8936002)(66476007)(6512007)(64756008)(66946007)(66446008)(4326008)(38100700002)(66556008)(186003)(5660300002)(122000001)(6862004)(76116006)(6506007)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?j6rpf9hWn9Iw5TKdOZ1MeyiQnmzz/39sP0x/Un9efD3sVVvK3SQHjQxAFbLH?=
 =?us-ascii?Q?muzHkBTeKynCXCj0VjwctGhiyk/lrDX4p3AbR6FKYigdLA+VhF+wF812a7AX?=
 =?us-ascii?Q?EL+CDebEtSSRAlMyTNyCP3kvZlwcK1rqdev5+7DxyF6kdp9DkyrnzaG7W/2T?=
 =?us-ascii?Q?0vEzmPDv1+lZVBgbY0nVQxHbwDecaRe8C24+9Tob1nTor+XLvA2GhK8P/TX4?=
 =?us-ascii?Q?JoJWyT1Q4JuxZWJ75rmHjJ5HCz8lfnLfKAvuYbY7koDvJmrhJ6NyYyFBt+xI?=
 =?us-ascii?Q?G3RcoeqLVqfaarYqbTxRwmGy/Ws08Q6sIVGk+vvX7Ne3kWSC3pv8VkE1bgGD?=
 =?us-ascii?Q?Wd7Xs48ehRVZc50EByWPfWji6IY/QRNcCujdTGeGk0t/CBE1EMUm6I5jfB/Q?=
 =?us-ascii?Q?AyLXDMxku/ZsPolhIcF54Cx/bgB0/eSErpxIB0twm/i3Z4h+YnRucX3BNLMb?=
 =?us-ascii?Q?rVRIyk+fhxHuBBlT8+9InRMTq3jRq47fMgZrOY89sGphXdJpsI3EuqYZWfc+?=
 =?us-ascii?Q?nlr2jrHSo3a4G+WqI6qXaXjilBABwXxiNh7RsrabZ3JojIOtCzHhRR0g+aS7?=
 =?us-ascii?Q?JTICTEiuLKUcnRfk9cdEPyt22exmHVvU2QSaDb6EOJT9o21kHlag13EG914w?=
 =?us-ascii?Q?1X3eOWEQyP59EDoJsTWxK2k+TbuSiUVhTAkzMNAUBZJDjvM1FRIY1cQVrPcI?=
 =?us-ascii?Q?vYhLEVDkskKh9lj0CsSxloMkCMyCytq8eP2HJm7dM/bseF6A10vIQMWMgfGN?=
 =?us-ascii?Q?tVHexZPKAuzW3w47O3To6FdQ/IznmGO9ec1fcGtEhlCtkfKMoIpmqBI+Emb0?=
 =?us-ascii?Q?o00ckQzCknoTLu4zz1zStGyKh+mit4WdxhuD++Y9b+FGzIOWy+aUOeL/aos+?=
 =?us-ascii?Q?u1tO0K9b6Yx5Vn1VkZC6Hb2hw9rzdNWCHjb16oPpNaVJvIEXPAExdJaVEJSC?=
 =?us-ascii?Q?uqIyXO0RCpXfpHZtnQlDTZlfysYRiMpOFZzhlFxehEuSODA+scS9tUoGb8NV?=
 =?us-ascii?Q?QAD+r2TYvvnJ+HbzzDKArunK+HnO89UwUstfPAFVzJKbiqkG4zPl9cZCNUJF?=
 =?us-ascii?Q?lyyffmEhQENfCK5V/8KAUnBE1v6aUL77QVavCOaUa/BSSsjSkaBec40MIVZ/?=
 =?us-ascii?Q?C+t8EPsxi6H09CPe6EYIF4afsmHmN5WV5qi1wr4ogV0ZVap7rB6t2DC+Mq0G?=
 =?us-ascii?Q?rhrp3GTnhB3JrLEB5w6uvCu1ix9TW8k361NiL2Wh4lV5ko7b7IHA4ZVs3y/m?=
 =?us-ascii?Q?M0eYZ4OSt0vqULmWJBJRKkFsH1BFiz/w1gkl8W1XBtJGiHZCfwldRNP/08Ix?=
 =?us-ascii?Q?FmsHDrZ8sh2dD8hT+ZWgUNT4?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7D480E5435A7174E84669F1CC174E303@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39c24e3c-2057-46df-6291-08d905a024ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2021 15:06:01.7173
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Nt7CAtRDsXJq8WUr7V1ADcAQ2zyJvIpkfonrhUWi1h/vxbXM2HBKTA2RJmrAhsGwnk/qYhiYd6iyMp3JzP18Tg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3382
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9962 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 malwarescore=0
 suspectscore=0 phishscore=0 spamscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104220120
X-Proofpoint-ORIG-GUID: M1jhTwGjEpQ7otBzForcuOc1p-1JJIdm
X-Proofpoint-GUID: M1jhTwGjEpQ7otBzForcuOc1p-1JJIdm
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9962 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 adultscore=0
 impostorscore=0 spamscore=0 malwarescore=0 clxscore=1011
 lowpriorityscore=0 priorityscore=1501 suspectscore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104220120
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Apr 22, 2021, at 5:14 AM, Dan Carpenter <dan.carpenter@oracle.com> wro=
te:
>=20
> This code is supposed to pass negative "err" values for tracing but it
> passes positive values instead.  The problem is that the
> trace_svcsock_tcp_send() function takes a long but "err" is an int and
> "sent" is a u32.  The negative is first type promoted to u32 so it
> becomes a high positive then it is promoted to long and it stays
> positive.
>=20
> Fix this by casting "err" directly to long.
>=20
> Fixes: 998024dee197 ("SUNRPC: Add more svcsock tracepoints")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

I had a patch somewhere that simplified this logic and got rid
of the ternary, but I think it got postponed when Trond recently
changed the use of MSG_MORE.

Let's go with this for now. I've pushed it to the for-next
branch at:

git://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git


> ---
> net/sunrpc/svcsock.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/net/sunrpc/svcsock.c b/net/sunrpc/svcsock.c
> index 9eb5b6b89077..478f857cdaed 100644
> --- a/net/sunrpc/svcsock.c
> +++ b/net/sunrpc/svcsock.c
> @@ -1174,7 +1174,7 @@ static int svc_tcp_sendto(struct svc_rqst *rqstp)
> 	tcp_sock_set_cork(svsk->sk_sk, true);
> 	err =3D svc_tcp_sendmsg(svsk->sk_sock, xdr, marker, &sent);
> 	xdr_free_bvec(xdr);
> -	trace_svcsock_tcp_send(xprt, err < 0 ? err : sent);
> +	trace_svcsock_tcp_send(xprt, err < 0 ? (long)err : sent);
> 	if (err < 0 || sent !=3D (xdr->len + sizeof(marker)))
> 		goto out_close;
> 	if (atomic_dec_and_test(&svsk->sk_sendqlen))
> --=20
> 2.30.2
>=20

--
Chuck Lever



