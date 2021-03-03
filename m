Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48C5732C699
	for <lists+linux-nfs@lfdr.de>; Thu,  4 Mar 2021 02:03:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380497AbhCDA3b (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 3 Mar 2021 19:29:31 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:54034 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383954AbhCCPfy (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 3 Mar 2021 10:35:54 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 123FUL2j089454;
        Wed, 3 Mar 2021 15:34:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=CIxIhZC1p5kyU2MML8tLevACDkebcT8/BScm2OZJgL4=;
 b=a5YPS8qnSClZuFMQ1qBY3XySFv9/fVZ22QXI+BV/3WIojzvMonD+Kb8qS+dGQOsrOpgh
 MPpzR1Tx++417RR2KTonEOnghtK3cmGcXW+uiXhUAmTf8Q+YkEPrvupXowHiN6yU0Ioy
 h1fsPCgWfV/PbAVDuvqMKi/4EvUthA/xsMrm7Yv5OYiLz3kK3G7464NORFtyqgy/xJ3L
 mn4D76bAEpzQzgLtHc2GqxOwK397+gxNyTZyuY20y9BT/QXuNn6wqejHZhPalLKmjtkJ
 09uqlzA8PFenNY6j9cp+HWWwAt8Ory1VMX79vz5HcKHRefRdp0/kyOlVkktLXtvFVUQm 7A== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 3726v79by7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 Mar 2021 15:34:24 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 123FV5Ci127807;
        Wed, 3 Mar 2021 15:34:24 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2103.outbound.protection.outlook.com [104.47.70.103])
        by aserp3020.oracle.com with ESMTP id 370001eabq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 Mar 2021 15:34:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=brtPzi4DyUNCD1VxEIC0Cdae45+oHUNY7ZZ4MalBsdCboOaiaDhKO1ASM/AFIaQztHzvt4c8b1itMqm3jBkJ0wcU6VvSEGK7o437Q0Dd4mIH2LODYoulRJHYkNhl5emwkMD4smnHoBblRf6gPGLyZ/PGxW++silKpU5uNv7fEfx7kmaDuJqlPADI5pExFw1BrGha63FW1vNpbSs8ujS0ixE2G+k+y8Bgisbo9Xz4vWsHAS4TkbyWeTxJH+5VQq/GsTgJgUtdNVaKi/OVgoGhqIQ4i5rKShYJBHMBk7qer/Xv6gqJ2zyAWCIXvhivy7YYMGccUPGdmHrFmawheXLfKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CIxIhZC1p5kyU2MML8tLevACDkebcT8/BScm2OZJgL4=;
 b=ZUIzsq8p3GDkIxf8vyDzViHzKLyy18tuTKidgq88tyF9wl/gF0onOkNMbT6N9cZnjKZLpaErF8XEP9rgjWl+lR3GxFGEaYrwfRPn+CWDpDt0XhNmGuFBng7IsmKU86uSnj3pj5p5wa1DNbfG8P+lYJUlqzPUflQfxzINTes1/sI8jjSCM6uTV5jlMGb1d6WgrJD5qn4Tiw6nIlojwfZtMNjFep/E7f+/AnEgl1ZKpoCIukEhVPC6LamP1gVi3Djr0LhhrwLRvYViqvr8dDdr20aZZwiU0t+SaIKMdpS4glS/h3Tho9km+4mddHvFoP+qrd16nlWNRD1ABlDxqMT4BA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CIxIhZC1p5kyU2MML8tLevACDkebcT8/BScm2OZJgL4=;
 b=fUGw4Q0tPIa4SIRTUhiEEPShAL6Tb2XTF9CgNBvXFazJUrCUBGfKVmpjtGj2h3JEhUl61jsQ8F3Y2HFVGBhrYTGBXt3g3F3oYlGKzA2HaT6Z1mKiYFka3KFk51te4qqyXbMcmyPlNMmWN5FCy/kggVR2dc6mJvuFwzf7+WGnqoA=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BY5PR10MB4321.namprd10.prod.outlook.com (2603:10b6:a03:202::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Wed, 3 Mar
 2021 15:34:21 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::6da8:6d28:b83:702b]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::6da8:6d28:b83:702b%4]) with mapi id 15.20.3912.017; Wed, 3 Mar 2021
 15:34:21 +0000
From:   Chuck Lever <chuck.lever@oracle.com>
To:     Christoph Hellwig <hch@infradead.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v1 14/42] NFSD: Update the NFSv3 PATHCONF3res encoder to
 use struct xdr_stream
Thread-Topic: [PATCH v1 14/42] NFSD: Update the NFSv3 PATHCONF3res encoder to
 use struct xdr_stream
Thread-Index: AQHXDq4/0X84eSq3BkC2qT4W0/Xi36px3CKAgACL3oA=
Date:   Wed, 3 Mar 2021 15:34:21 +0000
Message-ID: <DC29E9AB-B152-46F4-87EE-FD329F1DCF6F@oracle.com>
References: <161461145466.8508.13379815439337754427.stgit@klimt.1015granger.net>
 <161461180307.8508.9954286154242416300.stgit@klimt.1015granger.net>
 <20210303071345.GA388507@infradead.org>
In-Reply-To: <20210303071345.GA388507@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [68.61.232.219]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ecb4dbf8-70af-4a83-29c1-08d8de59d144
x-ms-traffictypediagnostic: BY5PR10MB4321:
x-microsoft-antispam-prvs: <BY5PR10MB432102D4671BCCBD48E8B01993989@BY5PR10MB4321.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KiTIdJ/O6CuMAMzagIWKhDHCw88HMc6eUsnG4+V1Ga3IPL0+MHMgYWP9kJJJrLyHD9TM9Qj3JVhX7ibi1URAvrz2B6+/wizBHvNtk1zZdepb4KoA7Lg3Mr/vyjBrsNgp28DKoUxlpyRcqRKAg5aNrLaGme49zDMguB84ulU0XPCtgcXQ9yjiEBQlZXim8hUllO3hh0FtTFnL5jEoFMwgvlw0HFg8fYADbWbvqYYTPg/346Ja+uthf9YlqHbP8E1zSX/z6D5u4jIwAOpCMJz1iFqyVjGmZtPq5WD3xSzcJweX5aNQLM7RM4cebIVa0js55qZ80+scdaeGtE8DN28axhMXZazAe44mtqRaHMyPql/Hy7ZCT8/WyzU/CjcWFKnngx+AIhUaEXWUji8itqPJUrWoVxr/342fo0eUIt8B1AvEzCbICFORtlxiA2zwlxWxEqtduACwagbOtAsFeuC67RO2t9R0072pTrnxxc3rcsdvGy9TNkvT1JThPFqCrkMKqy+ycSwz0WoQbyX+8RIC7u4THl/Z8pJ6LD/Ekgvoclv56g91D1nqJPQDVLyGUtrhwfVpvmziYykz2Bc4xM8uUQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(346002)(39860400002)(396003)(366004)(136003)(478600001)(33656002)(53546011)(2616005)(64756008)(4326008)(4744005)(5660300002)(186003)(36756003)(6916009)(26005)(6506007)(8676002)(316002)(6486002)(8936002)(2906002)(66476007)(91956017)(66946007)(6512007)(71200400001)(76116006)(44832011)(66446008)(66556008)(86362001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?83juU7/TsPd/vm/q84zFXx/u3CUEEyN7Kuo7sZaGhuOZWVAWF3GT4lJCYGIh?=
 =?us-ascii?Q?8QVKg5ewMAlehsVnIyIL96kHbW36ZGoOrvSabwvXyUm/d36uw7MeUj4eIIsn?=
 =?us-ascii?Q?Z/KFmezlAYknvyfNQ3HWhd83qRAnspEr16lSroO/tt+69Hyi1SVyq8uYoEnW?=
 =?us-ascii?Q?lxTTZDyb1P50oBXsXfMJyHrouJaiG8LcEJ4xcFeGTEIaI3Qd2reM5TBVBiFv?=
 =?us-ascii?Q?JlCUHzHJenBc+B2GWeT3pGPaaEH7At/KoanQ6YHWj4iF9RwBw201siPI3SeM?=
 =?us-ascii?Q?m2ggWK9948wH38pOnDNjX3Q1iLuT1e6rYCMw/OEsBIeBysX06Wg7eQmXTdlr?=
 =?us-ascii?Q?3fMZtrHQzcOyxNEGuEFk4rsRG8l8fP0TfR9kdV1JFauv0PG20FV2RlgNDeSS?=
 =?us-ascii?Q?tuQ3mG5aT918WypBZKHt9ocVhtU2TVSK1pc0pb53UzxLFolIgyojJXYdREBi?=
 =?us-ascii?Q?eDbY3vskWqDHeoPQvKs7SKxXul6U6KJK9JGTxQWtPNaKqH4/aOaT6KpzJraN?=
 =?us-ascii?Q?5lBasz2vjXHE7q0TFpdpQgUzEM7x/bV6s9jhcyEhf34q6kwT8j5DeuN3T7gH?=
 =?us-ascii?Q?8doSkGW6nH5KfNuYWYHQPLgaqkhVD/Dnzz9Ijc2ad++oLmn5Ji9OIAzNesG/?=
 =?us-ascii?Q?iJj/MxfuH7heZT1WFxe1bLCAmo5SBA7QLtu8wQfB26fdJaqiV2xWCVE+tHJ/?=
 =?us-ascii?Q?LHs+xtju1QJICVDQlqJ/L7eHGNgv3W9aVMqm2q2ChMzDSBDDyP9891a79IzX?=
 =?us-ascii?Q?t6uNXRQF7W0SCBxS0n6/19CtE4TtBgb+yeUnXGxVQR/m8SYQgGY40pK/ZLmu?=
 =?us-ascii?Q?l10m82ktHAeEe8XL6HPDa0ZB3rTIVRt8TpfgnP4nYZ4UVz8jxKuzkgkTj9lL?=
 =?us-ascii?Q?gK15DeejjkHuLnsgjM4j0GSuLBFJRWU8vdWjT9ox9q98QNY/5GS59KqL3YDV?=
 =?us-ascii?Q?u18xze1e+awnVNg7Pmkny3RVoIvslMJiAKlscDBdJeiepGF4t1zz9kaHFtUY?=
 =?us-ascii?Q?dFMMULEb5VePGTocrXdzATYJRyMQNq6HhDJ937tGEdOatVyB2EXtX8HNb/Rw?=
 =?us-ascii?Q?JkbAVDFSz41V3O8v4qAXtIiVqOS0fnWEH27PDuMyoP0Lm6FuowH/OfcUZmvs?=
 =?us-ascii?Q?FdUBJq+pDP63MpOB96BRqUM18rcyF1hbv+dLrdvjFouHByP3a61FOodmbDkw?=
 =?us-ascii?Q?UoHLjNPwVfuzB2VNcAlpTY66yFz7xVP+r7Nut9AlZZO7nYBDve98SQfuaIG2?=
 =?us-ascii?Q?QlQqR+brMhIV1GwIdJXwf+cVYKZDvwbgdMOwEj0mQTgn4WKSc4pGHzCctAjI?=
 =?us-ascii?Q?noIt364gRNIF6VqNG66xh9s2VEpl+Wayw1Ifen9NSXDoBw=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B641531C79135F43AFBAEEB2E9A737EB@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ecb4dbf8-70af-4a83-29c1-08d8de59d144
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2021 15:34:21.6668
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FanHisVDQI6SmxTQ7EDtuCgG1i7dnf9bHP4xmehXYbhRXZgAakAWvi5WoMrFG3N7YCzcbVkj62UXcY06gyWBYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4321
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9912 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 mlxscore=0 spamscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103030119
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9912 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 phishscore=0 mlxscore=0
 suspectscore=0 adultscore=0 malwarescore=0 priorityscore=1501 bulkscore=0
 lowpriorityscore=0 spamscore=0 mlxlogscore=999 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103030119
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Mar 3, 2021, at 2:13 AM, Christoph Hellwig <hch@infradead.org> wrote:
>=20
> On Mon, Mar 01, 2021 at 10:16:43AM -0500, Chuck Lever wrote:
>> +	*p++ =3D resp->p_no_trunc ? xdr_one : xdr_zero;
>> +	*p++ =3D resp->p_chown_restricted ? xdr_one : xdr_zero;
>> +	*p++ =3D resp->p_case_insensitive ? xdr_one : xdr_zero;
>> +	*p =3D resp->p_case_preserving ? xdr_one : xdr_zero;
>=20
> Wouldn't a little xdr_encode_bool helper for this common pattern be
> nice?

Sure. In include/linux/sunrpc/xdr.h, I've now added:

/**
 * xdr_encode_bool - Encode a boolean item
 * @p: address in a buffer into which to encode
 * @n: boolean value to encode
 *
 * Return value:
 *   Address of item following the encoded boolean
 */
static inline __be32 *xdr_encode_bool(__be32 *p, u32 n)
{
       *p =3D n ? xdr_one : xdr_zero;
       return p++;
}

and xdr_stream_encode_bool() has been changed to use this helper.

In fs/nfsd/nfs3xdr.c, the PATHCONF result encoder now uses
xdr_encode_bool() to encode the four boolean fields in struct
PATHCONF3resok.

--
Chuck Lever



