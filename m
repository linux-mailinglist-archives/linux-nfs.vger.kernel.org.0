Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24D1A32C69D
	for <lists+linux-nfs@lfdr.de>; Thu,  4 Mar 2021 02:03:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232896AbhCDA3i (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 3 Mar 2021 19:29:38 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:46176 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1449436AbhCCPoO (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 3 Mar 2021 10:44:14 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 123FTZA8130518;
        Wed, 3 Mar 2021 15:43:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=GHMIdB2az8GcW2m6Io3T2djycE+m9wtVCwWPJcjU/BM=;
 b=mE+hDnGF0C5D7k077bVpsQf0WC+//lp3ueaBdBXTEj+BZzr1LkO56O9A/Ec9bVEa7+TN
 imWbUiQMA/3MUzHhFelvP7U3Dzt+vI+rMJLtwwRVcCaqHjARrAa3wYNAP50dm6BEwzY5
 vlVL0y48Lot25T6qQc9xEpnHgd67Dp6uERm8CMkm59k1IbpfIYOUcHQ1oduhwzaLZ9tW
 ffS2J9f19aQJsxLG5IgnlYk24XMMnwU26UNOC438wuSu64l8UtC8b4e855KOZHmq5wcZ
 HRHuh1Jt85LTrlfezbkyC8O/OD7fAulE6abCVfGXFRAT8WNKVvOAzzypSysSQ7Fei0U6 OQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 36yeqn3tkg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 Mar 2021 15:43:31 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 123FV3u1162810;
        Wed, 3 Mar 2021 15:43:31 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
        by aserp3030.oracle.com with ESMTP id 36yynqpwjs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 Mar 2021 15:43:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZhUA5XonOJIas302RpnbasKGQ8D6P4KR11CYS1yk9eGt+JCD8vVNmEBFGjb27RuMPbUOtZGCn4bzm+SO34rb1Ha2u4pSU/w22SpIdB6At7H1btogB/lx77JOAube7leVgPhXbZZhK3HUcSpzFiLqbreWwm07pD/hk7t36JM/j+htudcKmPC+Ny9ffhFba4dFYVAW5FlV0XvWwjWx+1ih5zE2o1BW3O7uCLodt6kJeG2/7piDS7qYqB/mc7NRoblZKrrANbv/sCScXfZWX7J3mKkv5u+8W5jJLG6CNySJv95V0iB/DlA5uWeqC4rKpHaaZG02u3bCH5o9uilgrx96Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GHMIdB2az8GcW2m6Io3T2djycE+m9wtVCwWPJcjU/BM=;
 b=JaV4WxEvnfFAkyqKRru0BQfq9lCIjTKqKP6bMOrG2qHOtCy7OvNVB26f2I2vjLiEr0hS1W8CV5+gaXc64kaDAmqu3la1fdoJqpy/fjov95woOb5zDWxmSQ5bVx3FVzjfcD209FQ0sj/XOpOn6iwVY+BnPjMlcZlOh4brWbcxLjUeBbyjIaQMyzzRIRgevTlQQ8AUKko9XkfXQBPy4QAZaUkyA72AaQk1a4pIFSFP58SNrhQU1s1kzN8T3jnYpH/taJKl5dLxz2xKAny8OmtlfGHLK2tnDjA7V+ZtOwp3lTJWKmfOWg7+QCTcYOWGVjYw20YCaJ1nVPf/FukNvgGq4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GHMIdB2az8GcW2m6Io3T2djycE+m9wtVCwWPJcjU/BM=;
 b=hhC5jKh1ywx0kpiADj84RW4MJCvXM2tUAEUURUmDr3aMk3WGg7wrT7h3dpH/kS9RNJ8zLCsOaOnC3SaaPMZzcNXNy8O9BztOsV65d1F0c6OHi318poSxZN57Ct2LcZt7PI+EYi79klsW8zv833F/oOLnZnHJzGaOEjgaqvCnD+w=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BYAPR10MB2872.namprd10.prod.outlook.com (2603:10b6:a03:89::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19; Wed, 3 Mar
 2021 15:43:28 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::6da8:6d28:b83:702b]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::6da8:6d28:b83:702b%4]) with mapi id 15.20.3912.017; Wed, 3 Mar 2021
 15:43:28 +0000
From:   Chuck Lever <chuck.lever@oracle.com>
To:     Bruce Fields <bfields@fieldses.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v1 19/42] SUNRPC: Fix xdr_get_next_encode_buffer() page
 boundary handling
Thread-Topic: [PATCH v1 19/42] SUNRPC: Fix xdr_get_next_encode_buffer() page
 boundary handling
Thread-Index: AQHXDq5E9L4cYzCeI0iQSySXwa3yeapxRKEAgAEl6oA=
Date:   Wed, 3 Mar 2021 15:43:28 +0000
Message-ID: <592A34CB-C178-4272-8905-F3BA95BCE299@oracle.com>
References: <161461145466.8508.13379815439337754427.stgit@klimt.1015granger.net>
 <161461183307.8508.17196295994390119297.stgit@klimt.1015granger.net>
 <20210302221130.GG3400@fieldses.org>
In-Reply-To: <20210302221130.GG3400@fieldses.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: fieldses.org; dkim=none (message not signed)
 header.d=none;fieldses.org; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [68.61.232.219]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f0ec52a4-7613-479a-f70e-08d8de5b1710
x-ms-traffictypediagnostic: BYAPR10MB2872:
x-microsoft-antispam-prvs: <BYAPR10MB2872EEDC8DF112EDF346693893989@BYAPR10MB2872.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UM/k/ec0DYsFf4eDG0K9hZtbGLZLwavXJ20pF3pydwE01tHZPbkDNHnNsDlxmDz6uojaEaT2kqqSigppltafl1HOhCmi/MgUeZfR/e0beQ+1yfljzv3twnEZiw5fTITKzKXrQKtgILXzXZj+v7bbip3091d6rt1r7y9xKWwsXn+nFblnEslIWe/AXt0t/ZWPUomBAxMbDxTcXI06fmhFEHnvIFaakxGsPNM15RJsaCZ2gO7vsoDdpf1laiecMj95dnmQ6xk89Y+ELA806ZWLiV6uA2aAfNL/W65tPJcy3CIuUbODNA8P+3TdJDXORjpAVgjsgfJtYVHqYyllrXkZKmsEcfKNigPAH4YgBp+3yIEaBZ/efjunUcNE8Ahy9sBnRfkSElfxv6h/dt8MevhN4Zk8+MZnMQFgMjp3lJCM9PSgzC8T1YLGVTuyDa2/iGEkRJkLHnKxfaMssQafLfvfmkV7pMQFf9x/dxzMDGVzSJrgkemllLYABcZXA0lAITKpa26X9aExALPM/zlsTg4bTrlTtKTtF6Y98yLBbeHAase1QuIYA1NWld/9I+y3TxTw8M/uQV9iFRnXE7Fm+VUgfNiQNyUDRJL+Hmfo/5fxzWQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(376002)(396003)(366004)(39860400002)(346002)(8936002)(83380400001)(71200400001)(316002)(8676002)(186003)(2906002)(26005)(53546011)(66946007)(5660300002)(4326008)(6506007)(6512007)(86362001)(66446008)(2616005)(6916009)(66556008)(36756003)(33656002)(6486002)(478600001)(66476007)(44832011)(76116006)(91956017)(64756008)(45980500001)(473944003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?wQSRD8K7XEf7TscHMxSCLs5iyiWcvxpAHuFppXnIVvFJJZQ4jhILaDdgE+Rv?=
 =?us-ascii?Q?CRUU79OohtzSXSwCYBhIS05hZ+DUIroBrHijv6MC8MsIzc3eBkIKaweUBsxl?=
 =?us-ascii?Q?mHBeX6TQdKVD/6EM/eqV1QP2WncYBvemtWic0IjuqTbJacXLM5fUNc6WmGPG?=
 =?us-ascii?Q?+RK4JjDDx+jqD/pHq/bZ79gV/mw/o3tO3WrmGzMZ/ln/db02L5TZNzmu2GEK?=
 =?us-ascii?Q?kuqXsIVZdbC1xyrOHr2vYjdATig9zGnuvpi6gBs2fFAd+Z12Cv1DMYBwp/2j?=
 =?us-ascii?Q?KOnpeItkjLsciMByjmD5Wq/tISx5l0gnVLxNFJkd53A0IvZ1YruNCguM+pkZ?=
 =?us-ascii?Q?euW7HxxSYrTtdIpCbOkWN5kLzccKqHrqZ5bsfTkX/tuz74M+eq9r5mkKlBi0?=
 =?us-ascii?Q?3u8NZ06/U6TZgzI4h6EDs4VcABMuZ3y/Ta+54tngVrl7XztMgs9UShTB30LV?=
 =?us-ascii?Q?dIH1E2txF+28uzn8/6Fgyd/Oq5IoWWYc6M/sOWucLMN7p6/o9bG95BWROs+v?=
 =?us-ascii?Q?UVaBqGjF9kj20HoSZ6mo/gPCRCW++fqdfpIfP2DDR5N8gaaoc5sh1ehjpb04?=
 =?us-ascii?Q?GZ/+maEUF3m/UnARU/DcaNQHz2RElgrlXqsT7pf5FvLU3i0DP6XKaDa03teY?=
 =?us-ascii?Q?Pl/71lgzCbNChiJqYGUnl+NUnsokOAslawR5tJ5+Ne1VOW/s9rSfw/mKU80z?=
 =?us-ascii?Q?XzB+E7kP2jUfISHAgR/Z+uT4s83RHkqpByK31QySWk7gKJizMyPY33duoIkv?=
 =?us-ascii?Q?jdktWUcwEJ/uZWuv5k23qSAyqXYEKgqdmSYLQjTRWarygRYnU6XsE5vpvvMD?=
 =?us-ascii?Q?YMtq6pwSNA/tHna1W6l9qoAACK9DNfcgbLyqyh924VEGa7rNKfdHbkgl2xfH?=
 =?us-ascii?Q?RX61waTQR1Kvu+hP2EgYGQtE0YGYatz+IU3idCyapsPrf1W+Nu19xcCVicAr?=
 =?us-ascii?Q?Jkmf5HS3Eza6KPuktrsKZ5K1hcjxlx8eQ+zLN9Yg4oHCxdOu52TZ4w/qwPlJ?=
 =?us-ascii?Q?jYGFe6vse/4s0yWCVHx4u4GZEMyEPaiqnkLeUp3A+w6g/S/vbl2bFsmWRcmc?=
 =?us-ascii?Q?FksEGYym2L5e2TA59G6Dicx3+X8wF+AEgE8xuleLj0iZPKleVfafT6qeTuwB?=
 =?us-ascii?Q?Y3H87pZg55CziPnp1NBzWcf03udaUtxNyDC8q6L+CXP0LFQqh5ylutisZj/8?=
 =?us-ascii?Q?q5Ec3bkpp+Fbe3yQ0h/MmSRh+BqMW26tHhLNMBDwNErsZlMqmJFJ/+UXeuFJ?=
 =?us-ascii?Q?QiDopOFk3zJgHDkqrL78JPIeZV3yTlHZ84KOJvVXT6FzZ2j5H6PzvBWXu4Ih?=
 =?us-ascii?Q?SaR6D43G1fws/7iSDSfrzjMF0E+a+y+NbSfPwwFgxKbCVg=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <6107BDEE2F91D14DBF75E5C1D56C75B7@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0ec52a4-7613-479a-f70e-08d8de5b1710
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2021 15:43:28.2626
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UiBKIJlRf46a/RpGZIzoruH5RaOXH6u6ABuJ1GHMeFn7x7KIZy+k8nfqM2SFsDk3HAOsfQu+J57l1SOW/CZAJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2872
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9912 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 spamscore=0
 bulkscore=0 suspectscore=0 mlxlogscore=999 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103030119
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9912 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 mlxlogscore=999 suspectscore=0 malwarescore=0
 impostorscore=0 bulkscore=0 adultscore=0 mlxscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103030119
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Bruce-

Thanks for your careful review of this series!


> On Mar 2, 2021, at 5:11 PM, J. Bruce Fields <bfields@fieldses.org> wrote:
>=20
> On Mon, Mar 01, 2021 at 10:17:13AM -0500, Chuck Lever wrote:
>> The description of commit 2825a7f90753 ("nfsd4: allow encoding
>> across page boundaries") states:
>>=20
>>> Also we can't handle a new operation starting close to the end of
>>> a page.
>>=20
>> But does not detail why this is the case.
>=20
> That wasn't every helpful of me, sorry.
>=20
>> Subtracting the scratch buffer's "shift" value from the remaining
>> stream space seems to make reserving space close to the end of the
>> buf->pages array reliable.
>=20
> So, why is that?
>=20
> Thinking this through:
>=20
> When somebody asks for a buffer that would straddle a page boundary,
> with frag1bytes at the end of this page and frag2bytes at the start of
> the next page, we instead give them a buffer starting at start of the
> next page.  That gives them a nice contiguous buffer to write into.
> When they're done using it, we fix things up by copying what they wrote
> back to where it should be.
>=20
> That means we're temporarily wasting frag1bytes of space.  So, I don't
> know, maybe that's the logic behind subtracing frag1bytes from
> space_left.
>=20
> It means you may end up with xdr->end frag1bytes short of the next page.
> I'm not sure that's right.

Why would that not be OK? the next call to xdr_get_next_encode_buffer()
should do the right thing and bounce the new encoded data from the
next page into this one again.

So far I have not encountered any problems. Would such a problem show
up with some frequency under normal use, or would it be especially
subtle?


> --b.
>=20
>=20
>>=20
>> This change is needed to make entry encoding with struct xdr_stream,
>> introduced in a subsequent patch, work correctly when it approaches
>> the end of the dirlist buffer.
>>=20
>> Fixes: 2825a7f90753 ("nfsd4: allow encoding across page boundaries")
>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>> ---
>> net/sunrpc/xdr.c |    2 +-
>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>=20
>> diff --git a/net/sunrpc/xdr.c b/net/sunrpc/xdr.c
>> index 3964ff74ee51..043b67229792 100644
>> --- a/net/sunrpc/xdr.c
>> +++ b/net/sunrpc/xdr.c
>> @@ -978,7 +978,7 @@ static __be32 *xdr_get_next_encode_buffer(struct xdr=
_stream *xdr,
>> 	 * shifted this one back:
>> 	 */
>> 	xdr->p =3D (void *)p + frag2bytes;
>> -	space_left =3D xdr->buf->buflen - xdr->buf->len;
>> +	space_left =3D xdr->buf->buflen - xdr->buf->len - frag1bytes;
>> 	xdr->end =3D (void *)p + min_t(int, space_left, PAGE_SIZE);
>> 	xdr->buf->page_len +=3D frag2bytes;
>> 	xdr->buf->len +=3D nbytes;
>>=20

--
Chuck Lever



