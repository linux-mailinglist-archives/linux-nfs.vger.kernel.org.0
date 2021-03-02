Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77E2932B74C
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Mar 2021 12:06:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245111AbhCCKzf (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 3 Mar 2021 05:55:35 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:45052 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346146AbhCBU6u (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 2 Mar 2021 15:58:50 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 122KsK6P060018;
        Tue, 2 Mar 2021 20:57:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=/GA/KbisipD928Q28193UwtuSOFbKFbNk+Hp640nOsg=;
 b=YyBpaVBkww/+5F9r+gdXL1Z27FFBBcHKBNXtcrIDXl35ExL2u0lx40d3hQnAkMC71wZA
 fuy+orNaHnJUSj0dxEc7TsPlaP3y4HC04rqYxQ4qxR7kjzB/p1aPgrz/UNEKngmOAzsE
 aLO8IEScr5hzqwSGuI8ixaO/35TSJuMelkkvNQybEH0rrQPs6s5RwKc+/smAim+jpGpA
 V+4S/vSrkgGXj6b9LMZ3s1w3r1mxB1NtlhSim7zWabJ85TSUIUcMwMg57D33kmdjiViS
 8H6QmKhuClCrclJcifTDz3+KdO8Ews7PJ8+nLS9B0M+m71y9F72gFl/jUSlBEIgwoWm0 8g== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 371hhc2jsa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 02 Mar 2021 20:57:54 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 122Kt1X3173767;
        Tue, 2 Mar 2021 20:57:54 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2172.outbound.protection.outlook.com [104.47.57.172])
        by aserp3020.oracle.com with ESMTP id 370000duew-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 02 Mar 2021 20:57:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QFnKQo1f2TakGG+AGhDCRdcSJJh5eWDkWbBpHx0ilQO41kggAWA5/9SFQKz0LyVkpGNigEpK8uQ57Pmhw4loz25e6ixBpzkvI3U8GsvmBeuioaHN4l3nqpVnUt+5ZYo4dxO+wRiXX4CTZQ3ILprxkHnA5fnyX5OHNSxyEhHW1nPWqVZsbqzDVakFQvuV3u9TpjXELF+Q+vUUySjK3styv2ek3+X/XAmLogi6HQyS9ZIIbGssiYK7Cy9jGBjZpeSjQ6XZV3R8mWECc5wa89TYVdZcoCiNbCJSo50O4ytoyRWzP+lyo2UVgPks88EeW0irplgvbIfAiiQlvBu3mYR19A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/GA/KbisipD928Q28193UwtuSOFbKFbNk+Hp640nOsg=;
 b=UGFYCqvPdWNrsCRd/J5tSwghIhHnLGRvUYkYm6Em0LQVU2LJVV6yUole2Q/YkN/k9dPZEEyQ4It4YY16y5F7MXdeVMab6G30AKYJLhqGLUs36ntoN+CjCahi9KW8aPMQTAYdxHWI9fu2pHi2JvJON+A7vvEUqrIxlM33NsAwr1XP7jdaGwC00badXbgQFUc5E5jIQ2wkYpN6pRFDMUn0dIA1oFdgR+/kmrPVfdJ0v/2ZjKIailW+HR7u9/502ExH/FBSXGKBUrmb/9AyStPHBy7J5+kzVn2qv0J8nJ0zx0kPQ6J82g0iVJqT022+NJEjdBKaCvaXvX2ujD0wmSghGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/GA/KbisipD928Q28193UwtuSOFbKFbNk+Hp640nOsg=;
 b=uGESRIupL2aSwcKo/0AJ6nuKqyCopkbZIFSND7OPCEDSTmivpmF5KF/Vu2ynbeC58b4dxMCzb81diLo74YTNRt4DnS851SLznKHmRYFyErJ6xcYl1Pz4QEAkOoyxSqdIISJTZ/sQRqds8pNZBdWOMq2PJXd1YdLzkMtMN85cRQo=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BYAPR10MB3143.namprd10.prod.outlook.com (2603:10b6:a03:158::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.23; Tue, 2 Mar
 2021 20:57:52 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::6da8:6d28:b83:702b]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::6da8:6d28:b83:702b%4]) with mapi id 15.20.3890.030; Tue, 2 Mar 2021
 20:57:52 +0000
From:   Chuck Lever <chuck.lever@oracle.com>
To:     Bruce Fields <bfields@fieldses.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v1 12/42] NFSD: Update the NFSv3 FSSTAT3res encoder to use
 struct xdr_stream
Thread-Topic: [PATCH v1 12/42] NFSD: Update the NFSv3 FSSTAT3res encoder to
 use struct xdr_stream
Thread-Index: AQHXDq5LtiyQpyHVN0Gs9zjPv8p1s6pxLI4AgAADfgA=
Date:   Tue, 2 Mar 2021 20:57:52 +0000
Message-ID: <FBB0E09F-BD89-4B6B-98A2-757F75387411@oracle.com>
References: <161461145466.8508.13379815439337754427.stgit@klimt.1015granger.net>
 <161461179102.8508.11890812651210896607.stgit@klimt.1015granger.net>
 <20210302204520.GF3400@fieldses.org>
In-Reply-To: <20210302204520.GF3400@fieldses.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: fieldses.org; dkim=none (message not signed)
 header.d=none;fieldses.org; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [68.61.232.219]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: be109d15-9ec8-4e7d-ac9c-08d8ddbdd863
x-ms-traffictypediagnostic: BYAPR10MB3143:
x-microsoft-antispam-prvs: <BYAPR10MB314386F8BD42C6B6D6D4786B93999@BYAPR10MB3143.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:229;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zr9FFcQc9AGjwoR5nPb3x8KNUn0u+H20d1YJw7LOYoz6b7PSh3jELhNWRfRzlUmC20xOI93zg/h4A9cxA8XzX7EHL9L0Mvnt+UrDYFAqo+y8nohAMW88D9P8fHJBgpFhy6uBo9I1bkYlKxD0gxO72D6VvDPPltON/g9K9srhJdXx/iTAopq814OnWYQj9jEtiXNMBwcagCcjaG5yqFs8yqFVqgWE2JBVpRj2k0wQDyL2qmMNR6A/DuYmLMFd6iTem9HUomU6cAjjX/vK0Rp6NqHSZoob4KVucrDrOeKR0IxNMvseWBptlXyEPrKzbH0DcfwWyVT+KPnFYFhi/VGCpoIklOcE0GzUW/Col1kBbsEKtt46S7B59evTssIrYXm1TbMJ1GqbRLd1kNtwH1LUh7C9ezh4bCqflimbzDAiS64B3MjQtEc7X/BvxM2hQEAgHCVtjtS0rNgkAXXRZfCWBJ1nrgPQ0NXCazEQhYN5nqiR4jD9nvTU1qweb3YjtjlbGgDiXkrbvuCCUUBh5AVLE3PJ35vVRDGkGBE3ZPIlbjWCNAGwPZQwY5bebj0nVrVdWO3FprOx6dA/4agdacIggg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(376002)(346002)(136003)(366004)(39860400002)(316002)(6916009)(86362001)(66476007)(64756008)(66446008)(36756003)(2616005)(66556008)(83380400001)(91956017)(8936002)(4326008)(33656002)(478600001)(71200400001)(186003)(76116006)(44832011)(66946007)(2906002)(6506007)(8676002)(6486002)(5660300002)(6512007)(26005)(53546011)(32563001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?HQFUIRqKOhmUCd34CZ5vLoNCxgo6WNUEnU0gAT1/zeeL6O9squ+GcYvEPPrC?=
 =?us-ascii?Q?s9LhF98wRAk8CLTafo5AqIxEdflaV4JVP80Hp84220bCuLAJwRnARbSL+S1B?=
 =?us-ascii?Q?2oq9UTcMk5QTVZjGDSXCmIviNdtnRuaon2V0iBDBDMFZtJNikLue10FYJ+Qd?=
 =?us-ascii?Q?ZERkXvJk1yb0TwL0wohJNAlhTu8SaqeBR0QzteEQdxX084+0z0vFHMNkBFuA?=
 =?us-ascii?Q?blPMmW5NdbZhdQ4GLDzS4k+U3oGkyQxD+x/ysM45nv4T+iAQZG9uC7qvesEC?=
 =?us-ascii?Q?tIbnO9/UvNXg8uEaYKSSYh7y5z9QyX12SzQhxofrV5vdljiQNH+o657F3l4I?=
 =?us-ascii?Q?1fJUP8AO1y6DF2OVkPJNEpR7zRDjwdeqYAXdjSlVdAU/rTBh3qwHXHPbKvZ3?=
 =?us-ascii?Q?cfrST7DgRPq0Q0FxCt2ftwAqQV80qKNxbl4ZwJLT2mEntlQISIW2k17u2Vhf?=
 =?us-ascii?Q?h07o4xL26m4TlASIO5r3VoMlCIDnHdwE0TWpI/JQtA2nyFMMoKM9QTqeJrRX?=
 =?us-ascii?Q?mTnL9O8v5CJ7zcBkpZpEA25QSxwK8h4mbU+g5hYc1mEmxcDw8V9eUzRviimj?=
 =?us-ascii?Q?vh9dR7/fK7YwmBrXRJgqKmeZIVInKy+708KppiR+0p+aPD+xQhT59x4NjjzT?=
 =?us-ascii?Q?IhSTz1AJSmDcnREHoXGYaGe6K+ouVAl6NAnmZ+9g8hZkLyE9yeuVLmVIU+6M?=
 =?us-ascii?Q?g+s6ibsZQvpzfwO1kCBy4QUOFyZcA87KlWnYh6ZXsRdgFXaB8DGpVL2wdTpg?=
 =?us-ascii?Q?UlJm8U3vwXuZqGOfWqFGWqwUkrYVpQEd+m253TqSI+iLOBi1tkGhLngw+G9v?=
 =?us-ascii?Q?pHJ16qcuitoYEFaFsrv2WTgRkJezqJ3HlJo72gkP2HlQCATX6kdgyABMgyCA?=
 =?us-ascii?Q?G7D793a74nT75KgWva2ZZJbuEp5yrqDkXkxJEVL7EknyKHCdm20h2ddXNMyq?=
 =?us-ascii?Q?onRHqiHGjrfdXb4KtVUkILUOowGbikO1viO3TxLKZXOszjeoTt9EvwmaCV/U?=
 =?us-ascii?Q?bw/r8KJzF0zrQovs+kgYWrUn1gpl3RCjm9tmv9WX4Ukep1UXM9ta7CkHsuNS?=
 =?us-ascii?Q?qogra0SUl4Awt8wKSJv2UrmPIrpO1KicuKx8EmGeFoIgV8jf78gbAWWWoNvn?=
 =?us-ascii?Q?AQ9zzJ6tI/7NEvKELg3hlwnhqIGwLsXpQfWaJTMLS0NZULrCRwrzx6XiH9eA?=
 =?us-ascii?Q?aUv4DYBvEeTaA28xZe6ycH/6/+kIg6By6gBWVL506Frr1HnSipMfC5Hi2V54?=
 =?us-ascii?Q?rxWUG0MNAqHIFlbRGAlb8MKCJrdudiAvnAQTTtsax8ge49l2IuI3A1wESkHW?=
 =?us-ascii?Q?XxgowkWwjFK60MTI5bLQXHr9pFcKB7ySutuE8X6ZNJrUPA=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <6F5851F1FF26684DA31FBA003C701242@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be109d15-9ec8-4e7d-ac9c-08d8ddbdd863
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2021 20:57:52.0469
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Tx/gcKDgW6y1IRc+vIV2ZPh1lqLQ5JrFoCBRnID9oBYjPwtu3vZ1qf/XQiTdvtGY4ovkaf+TxCJaaTTnSz3/CA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3143
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9911 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 mlxscore=0 spamscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103020159
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9911 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 malwarescore=0
 mlxlogscore=999 spamscore=0 phishscore=0 lowpriorityscore=0
 impostorscore=0 mlxscore=0 suspectscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103020159
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


> On Mar 2, 2021, at 3:45 PM, J. Bruce Fields <bfields@fieldses.org> wrote:
>=20
> On Mon, Mar 01, 2021 at 10:16:31AM -0500, Chuck Lever wrote:
>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>> ---
>> fs/nfsd/nfs3xdr.c |   58 ++++++++++++++++++++++++++++++++++++++++-------=
------
>> 1 file changed, 44 insertions(+), 14 deletions(-)
>>=20
>> diff --git a/fs/nfsd/nfs3xdr.c b/fs/nfsd/nfs3xdr.c
>> index e159e4557428..e4a569e7216d 100644
>> --- a/fs/nfsd/nfs3xdr.c
>> +++ b/fs/nfsd/nfs3xdr.c
>> @@ -17,6 +17,13 @@
>> #define NFSDDBG_FACILITY		NFSDDBG_XDR
>>=20
>>=20
>> +/*
>> + * Force construction of an empty post-op attr
>> + */
>> +static const struct svc_fh nfs3svc_null_fh =3D {
>> +	.fh_no_wcc	=3D true,
>> +};
>> +
>> /*
>>  * Mapping of S_IF* types to NFS file types
>>  */
>> @@ -1392,27 +1399,50 @@ nfs3svc_encode_entry_plus(void *cd, const char *=
name,
>> 	return encode_entry(cd, name, namlen, offset, ino, d_type, 1);
>> }
>>=20
>> +static bool
>> +svcxdr_encode_fsstat3resok(struct xdr_stream *xdr,
>> +			   const struct nfsd3_fsstatres *resp)
>> +{
>> +	const struct kstatfs *s =3D &resp->stats;
>> +	u64 bs =3D s->f_bsize;
>> +	__be32 *p;
>> +
>> +	p =3D xdr_reserve_space(xdr, XDR_UNIT * 13);
>> +	if (!p)
>> +		return false;
>> +	p =3D xdr_encode_hyper(p, bs * s->f_blocks);	/* total bytes */
>> +	p =3D xdr_encode_hyper(p, bs * s->f_bfree);	/* free bytes */
>> +	p =3D xdr_encode_hyper(p, bs * s->f_bavail);	/* user available bytes *=
/
>> +	p =3D xdr_encode_hyper(p, s->f_files);		/* total inodes */
>> +	p =3D xdr_encode_hyper(p, s->f_ffree);		/* free inodes */
>> +	p =3D xdr_encode_hyper(p, s->f_ffree);		/* user available inodes */
>> +	*p =3D cpu_to_be32(resp->invarsec);		/* mean unchanged time */
>> +
>> +	return true;
>> +}
>> +
>> /* FSSTAT */
>> int
>> nfs3svc_encode_fsstatres(struct svc_rqst *rqstp, __be32 *p)
>> {
>> +	struct xdr_stream *xdr =3D &rqstp->rq_res_stream;
>> 	struct nfsd3_fsstatres *resp =3D rqstp->rq_resp;
>> -	struct kstatfs	*s =3D &resp->stats;
>> -	u64		bs =3D s->f_bsize;
>>=20
>> -	*p++ =3D resp->status;
>> -	*p++ =3D xdr_zero;	/* no post_op_attr */
>> -
>> -	if (resp->status =3D=3D 0) {
>> -		p =3D xdr_encode_hyper(p, bs * s->f_blocks);	/* total bytes */
>> -		p =3D xdr_encode_hyper(p, bs * s->f_bfree);	/* free bytes */
>> -		p =3D xdr_encode_hyper(p, bs * s->f_bavail);	/* user available bytes =
*/
>> -		p =3D xdr_encode_hyper(p, s->f_files);	/* total inodes */
>> -		p =3D xdr_encode_hyper(p, s->f_ffree);	/* free inodes */
>> -		p =3D xdr_encode_hyper(p, s->f_ffree);	/* user available inodes */
>> -		*p++ =3D htonl(resp->invarsec);	/* mean unchanged time */
>> +	if (!svcxdr_encode_nfsstat3(xdr, resp->status))
>> +		return 0;
>> +	switch (resp->status) {
>> +	case nfs_ok:
>> +		if (!svcxdr_encode_post_op_attr(rqstp, xdr, &nfs3svc_null_fh))
>> +			return 0;
>> +		if (!svcxdr_encode_fsstat3resok(xdr, resp))
>> +			return 0;
>> +		break;
>> +	default:
>> +		if (!svcxdr_encode_post_op_attr(rqstp, xdr, &nfs3svc_null_fh))
>> +			return 0;
>=20
> Dumb question: will this result in the same xdr on the wire as the above
> that just hard-coded xdr_zero?

It should result in an xdr_zero. The point here is to document what that
xdr_zero means: basically that it is an absent post_op_attr.

The simpler form would be

     if (xdr_stream_encode_item_absent(xdr) < 0)
           return 0;

Which has the same amount of boilerplatiness but is less explanatory.


> I feel like there's a lot of biolerplate error handling.  In the v4 case
> I centralized some of it after a fuzzer found an oops in some of that
> copy-pasted boilerplate:
>=20
> 	b7571e4cd39a nfsd4: skip encoder in trivial error cases
> 	bac966d60652 nfsd4: individual encoders no longer see error cases
>=20
> I dunno, maybe that was overkill.

True, errors will be extremely rare and usually the result of a coding
error. The problem is that an encoder error can result in:

- A general protection fault that makes the server unusable, resulting
  in a temporary denial of service or at worst corruption of recently
  written data, or
- The server returning garbage or corrupted data along with an NFS_OK
  result.

So I think we need to take a little extra care here. If there's a more
efficient and easier way to do that checking, I'm all ears.


> --b.
>=20
>> 	}
>> -	return xdr_ressize_check(rqstp, p);
>> +
>> +	return 1;
>> }
>>=20
>> /* FSINFO */

--
Chuck Lever



