Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50CAB40408E
	for <lists+linux-nfs@lfdr.de>; Wed,  8 Sep 2021 23:32:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232875AbhIHVdd (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 8 Sep 2021 17:33:33 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:3508 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1348062AbhIHVda (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 8 Sep 2021 17:33:30 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 188HxOrd028121;
        Wed, 8 Sep 2021 21:32:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=WlwjsP8d6jJkAa/CBIYetrycAggJAQsXOsNbGOa3S24=;
 b=oR8CrsAZOORComaJHEsRbURkiOZtE4JFf4mw9ZTECF+oGWatqQiyi5xPnBvfIPPXCqoQ
 BA9CQvc4JTwYT4VrTqdbGyI1ddA4A72sHevrTyu1LqNn4dfR/o83ZWzDJ9H+/77qejZl
 ovg3ddMXrIrCt3lohguASs5sIT/qlMPLt3tpt97zaLL7Bu12pxIJfoTr2XDj1dYNVafO
 XF+tZc+NnVYDwYIc3FfZa5VkprSzZPQ5AoEkdk0QNwmcuzXglza9xaWjGMs0j3fkoUbH
 eevzMvjSRrOdeRZ2+xocW1Ybzt9CWQDnSAKVkFk101pvwcOKGgFzGQb5guU2G3PO6Wff bw== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=WlwjsP8d6jJkAa/CBIYetrycAggJAQsXOsNbGOa3S24=;
 b=DdzxIL5g9WTtcwvo5cC/JFphtIX6VL82BKrnX1SH+CYtlE8nQeL5/FfgM8FxyoViNz1p
 TKxbCP9wJPniJ/O4wwbQ7z3bl21rr/TLQvpdl+L4gBtNBrDkA8JIGrG2pepy/uWQ4b5j
 2C16VEnnqCOjqX3BamTo23x4bfDYVHLrI3fYdWdD4A+OYFkBR7FEb8/x2GYSBlLcKNlz
 LldvXhNa3GDlKaVXd3UKO/ay960dwdJkBUoPVigmjd9QoOfj2H4UY+wNXvNm3cYPRxK3
 WK4pt9nqsjJZ6+hQCJ+bwvLWNh+be3mH5576QbKbq3S66RUPW4fSXRNNl6Im+8khEWOS zg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3axd8q47mj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Sep 2021 21:32:18 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 188LQJ9v077543;
        Wed, 8 Sep 2021 21:32:17 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
        by aserp3020.oracle.com with ESMTP id 3axcpmu366-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Sep 2021 21:32:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PTw/0KxjCscKJAl433waiCTSphRUUF4y1EG35afJjpZYe5C3G+wEKtZY00kMGP8e123Ntw7KxZ80hV0P9k5z4I3AUryMmraUoDCkd9GlfvYE4/f74TgSnrzLwrT49UAx0k9vzJeBzGe9ABjVrTkR45H0CCvkQVVQkjpAcwjRli0qJ7LcJiHcpaDCNzwxlLu2GZJESrffe46PqPl8VbwAO+CAajBINl9KYc3hCQvVBKFq+ZJuQKwxsym3q0rs1mnYGlOxgwGQuCgypR+uS7f431oW5valr0eiuJxS9u6vif8jG6J4CLW9XOB48UhCh1yk6AUQEjnoRa3tHXLFXl19EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=WlwjsP8d6jJkAa/CBIYetrycAggJAQsXOsNbGOa3S24=;
 b=VCtMoTsxxWdWWN7M8aM3ZwrQBIs9BZ6eqlLryRjwCZP5L/vxUs/vTR1hmV4kTXte0Y8ROMA/Id3RBP/PyVspd1pACYzjOAEzrbUsGQcJ60lkbXBnUBq0UZfQle6zKCwdg5wjpu0P7LRWFgdvL8o2GheHVxKyD24Z9SX8TRMeSaBM8D/e9IuNj8FLybhbD1S5nEjj178+jzVwQ+YdaGdGsEcDEiL62uqkrZnedAV2glQQtw736Bs6e5mgql3r5rlAyt1SW27u0YR1XjTvxOpu9rFKhzWmMu0/iSb0nUAKK5Bxz/q4N01sakG0Bv180KjU0GFUfy1FMgF0KdfIUcZ9nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WlwjsP8d6jJkAa/CBIYetrycAggJAQsXOsNbGOa3S24=;
 b=m//YeSaU35rjFUSRfeAI1uScXv5Kcp93Bz+1tdrJ7Igb+/xTISbCpu54Fe7DCPWbr+j9AexDh4q6Pf75Ml1WMNgeGLSBFYD7wT6rURGCrzzMixXgC7PDlXaiPVWUCuQcXOA2oP1S6Y2wToO7CAS3cfIJ3lL75XtVnlYwq+ZBI1o=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by SJ0PR10MB4527.namprd10.prod.outlook.com (2603:10b6:a03:2d5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14; Wed, 8 Sep
 2021 21:32:16 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::f4fe:5b4:6bd9:4c5b]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::f4fe:5b4:6bd9:4c5b%6]) with mapi id 15.20.4500.016; Wed, 8 Sep 2021
 21:32:16 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Bruce Fields <bfields@fieldses.org>,
        Jeff Layton <jlayton@kernel.org>
CC:     Dan Carpenter <dan.carpenter@oracle.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [bug report] nfsd: Protect session creation and client confirm
 using client_lock
Thread-Topic: [bug report] nfsd: Protect session creation and client confirm
 using client_lock
Thread-Index: AQHXo790A7Wd0tfa/0e3moKXgUhSZquYZ4qAgABDIACAAf4ZgIAAAbgA
Date:   Wed, 8 Sep 2021 21:32:15 +0000
Message-ID: <23A4CB30-F551-472F-9F2F-022C40AE1D70@oracle.com>
References: <20210907080732.GA20341@kili>
 <deba812574c9b898f99fc08f0c3fa23e85fc36ca.camel@kernel.org>
 <622EC724-ECBF-424D-A003-46A6B8E8C215@oracle.com>
 <20210908212605.GF23978@fieldses.org>
In-Reply-To: <20210908212605.GF23978@fieldses.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: fieldses.org; dkim=none (message not signed)
 header.d=none;fieldses.org; dmarc=none action=none header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f6f7f3e8-8a44-44aa-5a87-08d973102107
x-ms-traffictypediagnostic: SJ0PR10MB4527:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SJ0PR10MB4527736C93AA8DE7615A74A593D49@SJ0PR10MB4527.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NHk10C9fBqHKy66o4/bkbhJcLBZqHc/WaRvwM3tXa7MD9xCUrQdxNZa1A7OLybjcLgojKuk6Ij783ne5WxcbwZ2+Teh9BAT4imr7RMZRuoUedQwhxBbsLJHGfUJyC9bu+mwf1CLNCmbnVGlCqPm56nEmX0LIJ70bQul7vJuU4QOo7mdTrawg78jv5F+1S+kwUXl+iSdEzC/Nlp2QVgkTy90xfUpx2m81RxnypsRRWiTmvn+4HED+zscc6A3xKNn6xxSsyMbNGMH6EikdaBDISnopQE++mzi1W6Gbt3rKJ4STM2Sxb/C4G7B0onFXz0yr+dUSd/a01r00u5SsnR4jpjuZZAI9wmYKY7XgDjd+H7pIvrqZ9QUYksXrERsS5konlp3q2uNdYkxNho35aXCaB7goO98b0reBwERFPOjxez8EFMVM09RUmAQc5xvxe5OLYvuu6BkRHJB1NapDUtRXLr+MCYJrjO5gQ52l96m24BoMYaAIDhEcs1lpXTreIzf9g5fAzKu7Z7uKp88Twd5c6dpQA+ANNL9nBOOSEFUdIkt898N0ko64p2QvMw8cYpNDI1EUTXNb5uMegb+DImeh6nE/mE0xk78mLK+YfTDqLxHq3Oji8gZVix2MQuTQ7onVV1UiSkS/ukX/SgHqNnX0/W1fcal4B8Thzlm0OmJ55NK2DYyceaRc1NdfWDO9A3hVIEGjp0A79zGzAyIj2FCdHYEjH8vhQF0GgSKo1uh7qiYrdct+s+YunNq1tdCO9QQn
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(376002)(366004)(396003)(346002)(136003)(8936002)(53546011)(6506007)(316002)(54906003)(110136005)(5660300002)(33656002)(2906002)(2616005)(66446008)(6512007)(64756008)(66946007)(66556008)(91956017)(76116006)(66476007)(36756003)(186003)(4326008)(26005)(8676002)(478600001)(86362001)(38070700005)(38100700002)(6486002)(122000001)(71200400001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?9d0o1kQKqy+j1241+mx/E4PXjD0W1u/b+pOqvpne20+FKt9TAkfb1OE4GoZ6?=
 =?us-ascii?Q?e5OWbcQkJRsAsCVagV8K5Xu/2ZO21fAXf6i0uTVjtxaXr25ZtKm5ArsrTd51?=
 =?us-ascii?Q?DsHtIYvgyP68dQdxJCeDRrZbA0V+iF4OP7f+p4iny7z0km9Lu1vm4FhyhvGZ?=
 =?us-ascii?Q?LdWKKVgLbW6jbzSFZ8Km26o78Da5ALzRj+hW/oo/rpNy6D5pppf27gYiQlxE?=
 =?us-ascii?Q?m2W7nX+G2q8uGZmfXdEzrXOlBKZOoqV5WQZSqyZ1E2erLNomsyGuEJ0IXiFS?=
 =?us-ascii?Q?7i263gJN1wyR6rtIY8LVgRNkE0Md+CcrTHDEwlXAWNBE3X1D5GWjapZb8a7t?=
 =?us-ascii?Q?+lK08c87uTsBLq5St8QUBZ8HEEz108v7jBn/Iz4H12SaKX28PyRrVvPRstdH?=
 =?us-ascii?Q?XHifrzt4LhZDIaZqAvh0pX9C4sqW9FyUJWlG0dec2nx6XEWUSRnNJnXcBwh5?=
 =?us-ascii?Q?KEnU4nYSBAyZAwEG4AY6aXmlAG7wcYQWCYeVMzBw3j+kPt7hwRQZAdQM06aY?=
 =?us-ascii?Q?DCGYj+FAw1UKSoJoG0lDvW3RalYUhgqPYV4rUPzwJt24R5gA+hg8apiLMaAi?=
 =?us-ascii?Q?v7ZTnaXQb/wryD/IRK9FGvwz4+AXnh2NrE5zqjGx2vZ1vfufkU3ivGNfUiC+?=
 =?us-ascii?Q?MptGfAtg944HZgogW2jwDF90Kqbjp1hZ/TzbGNqerssfX5tVAUpG1aIq4DSe?=
 =?us-ascii?Q?6vk9PKZ3Ka1dDZaycRu6XmvwoaPrSN2P8aZ80TRhbvyX4rrX8RhZFRqQIgB+?=
 =?us-ascii?Q?8lm6DjtbqWQeqNEXvskwQ3OTfjzcZ3siBdTT7uQF/1SA4lqCPiDUvO1euqEe?=
 =?us-ascii?Q?eMjdZrmxVuMN46oh2smuIPG/DxoIx17DVEhEGoSu4BdYJDeshfwCc2deot4N?=
 =?us-ascii?Q?CDE6QQqCftavOp+cpnx439FSR8iTNnCjH8CaCGBs82faXlr60lVQgxHcNkMA?=
 =?us-ascii?Q?JgZ6UCogyaAlMbcPIEyGqmmeoJa2L3OeyKt/y7VpXGJPsikcwAqZljZouhth?=
 =?us-ascii?Q?jzdeq1G4Jy+r6effxDKE/cr6wPMOkydoGcn52Mo5dpQM7S8wocApkz9M6SJa?=
 =?us-ascii?Q?GxnLjGMP4gZ8G93lM4b9cbvDnJ46gI6in1sAwWqSDGNTXOcgSt04Y7c/2gOP?=
 =?us-ascii?Q?f0lX8Twm69vGnYX7jIsYocbj4wIV+o9myKOB1NSMHp6vrWpO/asc4KsM6pii?=
 =?us-ascii?Q?ydAqKfK4T54fjJoYXCbZYKo4JljbJqSH6RH0T6yzmF1qotqgKDHTSaUM97Nv?=
 =?us-ascii?Q?8dySngx3WsUhHy20c0+G3wlLGrHTg3dHkCOA+gL0jI/+krxIO5+H6f4oPGGv?=
 =?us-ascii?Q?0sLS3XDb+i97ajVCeIRgYeGR?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <94DF0B8BC45A3040A45B44DED186F115@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6f7f3e8-8a44-44aa-5a87-08d973102107
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2021 21:32:15.9749
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UloIwHzdYyF/rvqK9zqHgzWGwgYcQr7xDjU++KMXMs/i0wcmpdTnfNN+eV3vjhGr4WyH2RjLWZmasyolPeyg1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4527
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10101 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 malwarescore=0 spamscore=0 mlxscore=0 phishscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109080134
X-Proofpoint-GUID: OoXk6vNMV5kdyva6twK7ocSmgeZikZZT
X-Proofpoint-ORIG-GUID: OoXk6vNMV5kdyva6twK7ocSmgeZikZZT
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Sep 8, 2021, at 5:26 PM, Bruce Fields <bfields@fieldses.org> wrote:
>=20
> On Tue, Sep 07, 2021 at 03:00:23PM +0000, Chuck Lever III wrote:
>> We have IPV6_SCOPE_ID_LEN as a maximum size of the scope ID,
>> and it's not a big value. As long as boundary checking is made
>> to be sufficient, then a stack residency for the device name
>> should be safe.
>=20
> Something like this?  (Or are you making a patch?

I thought Jeff was going to handle it? More below.


> I'm not even sure how to test.)
>=20
> --b.
>=20
> diff --git a/net/sunrpc/addr.c b/net/sunrpc/addr.c
> index 6e4dbd577a39..d435bffc6199 100644
> --- a/net/sunrpc/addr.c
> +++ b/net/sunrpc/addr.c
> @@ -162,8 +162,10 @@ static int rpc_parse_scope_id(struct net *net, const=
 char *buf,
> 			      const size_t buflen, const char *delim,
> 			      struct sockaddr_in6 *sin6)
> {
> -	char *p;
> +	char p[IPV6_SCOPE_ID_LEN + 1];
> 	size_t len;
> +	u32 scope_id =3D 0;
> +	struct net_device *dev;
>=20
> 	if ((buf + buflen) =3D=3D delim)
> 		return 1;
> @@ -175,29 +177,23 @@ static int rpc_parse_scope_id(struct net *net, cons=
t char *buf,
> 		return 0;
>=20
> 	len =3D (buf + buflen) - delim - 1;
> -	p =3D kmemdup_nul(delim + 1, len, GFP_KERNEL);
> -	if (p) {
> -		u32 scope_id =3D 0;
> -		struct net_device *dev;
> -
> -		dev =3D dev_get_by_name(net, p);
> -		if (dev !=3D NULL) {
> -			scope_id =3D dev->ifindex;
> -			dev_put(dev);
> -		} else {
> -			if (kstrtou32(p, 10, &scope_id) !=3D 0) {
> -				kfree(p);
> -				return 0;
> -			}
> -		}
> -
> -		kfree(p);
> -
> -		sin6->sin6_scope_id =3D scope_id;
> -		return 1;
> +	if (len > IPV6_SCOPE_ID_LEN)
> +		return 0;
> +
> +	memcpy(p, delim + 1, len);
> +	p[len] =3D 0;

If I recall correctly, Linus prefers us to use the str*()
functions instead of raw memcpy() in cases like this.


> +
> +	dev =3D dev_get_by_name(net, p);
> +	if (dev !=3D NULL) {
> +		scope_id =3D dev->ifindex;
> +		dev_put(dev);
> +	} else {
> +		if (kstrtou32(p, 10, &scope_id) !=3D 0)
> +			return 0;
> 	}
>=20
> -	return 0;
> +	sin6->sin6_scope_id =3D scope_id;
> +	return 1;
> }
>=20
> static size_t rpc_pton6(struct net *net, const char *buf, const size_t bu=
flen,

--
Chuck Lever



