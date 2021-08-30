Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B59D3FBB18
	for <lists+linux-nfs@lfdr.de>; Mon, 30 Aug 2021 19:36:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238169AbhH3Rgz (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 30 Aug 2021 13:36:55 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:5174 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238123AbhH3Rgx (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 30 Aug 2021 13:36:53 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 17UGkmuS032698;
        Mon, 30 Aug 2021 17:35:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=YsqlS+F9Yk2Fd7uv1lVjKQFRqTVenguGG4P+DePVC9w=;
 b=j7xKCtql5y5N8rtOnmTwoDsbc79+q8wkTlWb/4vk+kW7pFs0oj50IpjddLhvO0Uc/lRx
 kKp75/ea57195QSZ8rrf1mHie4tZaQSzSHTxfK2UQ8adeC15KV/P5pzxMlsX99Uz0MFW
 QUfA5mxCsz9cNDO4jILS7Au6a46+vkIwJcYuzAhQhfLwHlCVHfzVzI9XZ+wVvVSXbRWM
 cqh1UfNHrKO9YVA1UpMfOwRHZTzZkKcFxvd7cZ5fXIOQjpWsylcdPnUO2sIP7z6PDX+8
 cRsw5+54xIzHXIXLPx/Wfbg0SKxyHUuLr4Alif6LxouopsxWuNm+V+orM0kFxRifkawv 2g== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=YsqlS+F9Yk2Fd7uv1lVjKQFRqTVenguGG4P+DePVC9w=;
 b=gesyGYaBbd111/b8h+Y/8tKY6GWeaBcFtfBAc36nX1B9hg2dNZIik9vbrP6JcKOIKDxT
 O8UMpFaXJRRtPBxkepxe1ucDfHfGB4VASRbPgGFzh0cMzSWSqmRIpyerQ4zIu6w7v/XY
 sOxy02kVj2iG49ci9QEJg6kvY/T+7BpZFenn6LzpjSV9Tsyvb7a5Pmd/IVxQIr4dOavy
 SsD4PwF4/xincsV+yW0AJi1Mbw/yLxGjTy/48ODsivNk+VMZ3V3oxv4inbE6QgCV0TdX
 FJLkCbcnU9ucKtG3FS7O81vO5koKCnwwc28cMrIeuBLcLw6QNhduYhtpKtuoazcPJwjH 3w== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3arbxsj7fa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 Aug 2021 17:35:56 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17UHPsEd113040;
        Mon, 30 Aug 2021 17:35:55 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2176.outbound.protection.outlook.com [104.47.59.176])
        by aserp3020.oracle.com with ESMTP id 3aqcy36m6x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 Aug 2021 17:35:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XQJpQZxLLBmJXiUif2ZCJsoK84aQTnexffwhRtpulo6XP7hnCNSC+sjGk8lmZMyL8X0gO1+EWBfbJnmTfGCZ3FIif8evtzLTwiCGLryADtdS1RhdyRDKbtSnESCviIonYP+UU3qFZ6n3HtCBX8dQ8G1w16zXoNi5gkZ28dKgR4nDZj+p26pp9hB/I53w1SikeYP8jUV+TciyyOwusMl70WgpA88Z7eKU94/IlaRXt8FGV+ND3sI/q7JV7vc2CRYXJ3GnSKsp5i/8AHR7of0cFnNu3adnWpnmVblUwwJF8/AwzKa6Aw19kAdcT1dCydTVFbsARwbYWtaJ/boirucEnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YsqlS+F9Yk2Fd7uv1lVjKQFRqTVenguGG4P+DePVC9w=;
 b=oSGNqVC5HPNcIf72iSl6XKq8zF9CJOvxWfaENDdC0t6v1jZWr1+w/yQWHK40MlpjyBQugxis8qm9iN+3H5GDYcnYR4rtHIbH+LWqM5jSuES1kHOYeQIRWEnj2sqT3irPwM2YqKQQREED9nUrZ/eT2QzwBa561jamYA41TipxttYPP5OuxRJErwx2GE0YoPYmT2SvTbkzfbv7XQuEyMSKHB9swGbkv7iIp8lFhhPtN3kjccgB7LfCMWj6QTSXaa2tjBhJ2PzvUjySKCb0h5c26a4T034zzLPsSAiLhV+ivvpy5nBv3dn4sLbsr7IBt588plJWvBW+Jz5HGjC/s4OVLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YsqlS+F9Yk2Fd7uv1lVjKQFRqTVenguGG4P+DePVC9w=;
 b=LY8RJFBI6hHEL+p3NIuZBHPddlAQrrDkhjbZFHW69EGnMeb947RvHmpneHQ1/aDq4zCz5Ul+MB+YHLQLA55+WGajzdRLj+2T+U7SDC6jWK2AgvaH9jYomvmkNM+xIlRIy8FeVoMo8e+dStFh5mN9rZRjqT7QwQNiIr+RzMKW69s=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BY5PR10MB3777.namprd10.prod.outlook.com (2603:10b6:a03:1b5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.23; Mon, 30 Aug
 2021 17:35:53 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::f4fe:5b4:6bd9:4c5b]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::f4fe:5b4:6bd9:4c5b%5]) with mapi id 15.20.4457.024; Mon, 30 Aug 2021
 17:35:53 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Olga Kornievskaia <olga.kornievskaia@gmail.com>
CC:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [RFC 1/2] xprtrdma: xdr pad optimization revisted again
Thread-Topic: [RFC 1/2] xprtrdma: xdr pad optimization revisted again
Thread-Index: AQHXnb+EPQ6bfsCh/km34j6ENph6pKuMRqKAgAAFyYCAAAMKAA==
Date:   Mon, 30 Aug 2021 17:35:53 +0000
Message-ID: <3488EAB8-A0D5-46C8-879B-D867A8B6D5F8@oracle.com>
References: <20210830165302.60225-1-olga.kornievskaia@gmail.com>
 <20210830165302.60225-2-olga.kornievskaia@gmail.com>
 <F7F9A947-B282-416F-BC65-796BF325054F@oracle.com>
 <CAN-5tyEB9nv576uJijBtyhv2pqAHGNB4yeKo=F21btOkVQuaDQ@mail.gmail.com>
In-Reply-To: <CAN-5tyEB9nv576uJijBtyhv2pqAHGNB4yeKo=F21btOkVQuaDQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0256162d-3801-493b-59f4-08d96bdc9df4
x-ms-traffictypediagnostic: BY5PR10MB3777:
x-microsoft-antispam-prvs: <BY5PR10MB3777355590856EC936AFC66F93CB9@BY5PR10MB3777.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7dRNCHZlLbVMMVsbcGAgXWPZB2Es/W4acCLxKJs4XCMfVVQQnV+wN/aFkbtZsWPAde6cMjkvBRdb/YFLhkcQyB9VCDQkUhyecQQRO/9OD1GgmddHu9a3bWZAEYtRSaOKSt9WPEKw9FtrxGxv/8Bwz1/Xsx2QVJM7PcdGKW5Anh9L6zvR+hi3dnVHvvaQk/BwoJ3BAaajVdwCPV0leWVwrw8pD+oGBi7Woj8NyaI6iKeB+QkU55OwnUX4hkFQRFaefGHfiGCCybqxy2bL2Vs5x8C73TrEUCpRWihXQvoXt+5zBRrDEyZcwOG9vfhy+h5nBqWIxLFiE3xZ9YkQeX8h+fQMewq6/65n0EHgUfLk2XJ1J7/opjErm+H5osoRHhjQ8oml3IoGmTdU1xO+ZqfPzsT+5wNTX0sG19Q0szFUsJZBvY3v82b0xPQEWfzUVW9ylBi6OckBKn9jsWYkj+RhXuajrfAj/K2kr1VjfH3W/EN4/FY+pb9fdTI196NbcefSoK99bqAEWIP3esziMrOgmToz6vY7KQIOe5jmab3wd3LTIgVR2a2HQ8Ri2VXZYexBnWtyQJCnhrHoWJ1CKpB07Yzsy1c+vula6EHLfRK67+6JyRncZi47SQlx5YBgAYKRPDWWZyUtR7MFp5ZDW8c+oX7bpoCofUqd7/CHUs7bN+igW1IFrIE2FvlY+Euww8/+kamGht4+6QDkNMA6rPiqSl2/C2WOhU/ZcS6MkhccRfavHOeb+anZuChFYcF0TvCP
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(396003)(366004)(136003)(39860400002)(376002)(5660300002)(83380400001)(6486002)(36756003)(71200400001)(186003)(8676002)(38070700005)(4326008)(26005)(316002)(2616005)(66446008)(64756008)(122000001)(38100700002)(66946007)(33656002)(66476007)(66556008)(6512007)(86362001)(2906002)(54906003)(6506007)(76116006)(8936002)(91956017)(478600001)(6916009)(53546011)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?KrSXw//SNUyQohhIbmYen/9mbGPFOZ4WpUN42uxK4AsJ+ipqR2135HL0JgfD?=
 =?us-ascii?Q?HNxvUJIFLVkPcuVtPUNko0hEChWAL1P//aw2C998rqnKJ19DhMVJHo9kL+U0?=
 =?us-ascii?Q?UPDsMOHgzcjYss6w8yoRj1GUETs5uve962xAV9PmKavqVMJgFB9VbiVDtvrl?=
 =?us-ascii?Q?X7N+HsURQspERwAnmzzCMv4VE1mWAQHNt9e8RRmeG3MUcZ2WQJzSQQbS1u/H?=
 =?us-ascii?Q?9vUetBbRc2NH/SjHT75nYqJ8ZTet5UuDa7hj0x2fS6EiI4YiEONNFLTFCw0w?=
 =?us-ascii?Q?fv3WpEOJSk8YKf60fm9ShTZ9/aHPCx4FSEfJ8OK7fLmsdW2/p/IbHaYJ5HTp?=
 =?us-ascii?Q?A+tad6FshgyJnawVCvdg8rfa2u4Ndbro3qN9IRgSTU2Qmx92bg/JBEl5Y7Ts?=
 =?us-ascii?Q?SvGhIdmZDVzD4rfKYWdTvxr7wybKV4eSYGhHlJ6SnwZZdROHV9P6juWBpvn7?=
 =?us-ascii?Q?61zpqS3ZSBDLFOhxqHgqn3JUKBncNEx0FZMVx9pqPOZAjbFrKsGXlc1zX2aB?=
 =?us-ascii?Q?JeJyAEARtlV+WKORF/X0v+NWzd8jWyJVnPN6EnaaCpLhcpkh6/LdtDibANSv?=
 =?us-ascii?Q?ltlkMmDMFug8hTAKo38Qzo1WgUIU58h6HLjE3IOoTMPbbqOjYVo7yFfUKK6e?=
 =?us-ascii?Q?+rnnEqw+mmbdBKvNF91L/+jThErCoeU5UHcNxiznqQxawk6sSIER4uwTW9TJ?=
 =?us-ascii?Q?W6QL1ixPMx6hKLO4FgPWoILyDgwVsiZWbpNnmAlJ7ErAqYmuW16L8m+IEjtO?=
 =?us-ascii?Q?GBpkqRksxnFrY8hbAbHr2iwK9W3WZSp9I7bVvRHheTbEyBR5JENMdor16z+/?=
 =?us-ascii?Q?cGtbWZyj6Eqhsffr8ohsXuEo77NIzsIycPh27uQ9yB03UplneQX3ujEj9Yg2?=
 =?us-ascii?Q?zP1nuke/VB/aL0u2JzFrtFFzrKWQP9rQAnIebVtEnE9HnDmHRoC7954vvcQz?=
 =?us-ascii?Q?/p1P/Wg+Z4jgkTxCl70TohwGRv77c6swLf8/Mxux11D/BNXFCEdf+stJ9pHK?=
 =?us-ascii?Q?vXuNcD1jNvX6/UPp0RPKBJYeLbekeOO/umQaoseO3dBEfytwoXY47xrF5IkA?=
 =?us-ascii?Q?5A5MtsmhUuJPF843J6tDdoNpv6GYYFSKTbv+s934ni1Whqu+esP96hV5m9iM?=
 =?us-ascii?Q?XTJGmtOyHdNXKqsPOVZ918Egxclo/GWd9elhxUVWGALkX30ptbXuCy2zcEmc?=
 =?us-ascii?Q?j9BCQsWhlU/zKn0Yn+R7jPNrbTfbtHkSu1bugLngRkIkKJGRxqA87DjRYz6g?=
 =?us-ascii?Q?mmHEz2X9TYxcfUpXFJymY2b4vqpji7vFyHlczF1Z0E6ZM6n+jl8Ok/G6TPUF?=
 =?us-ascii?Q?kzNa85IdApNGl8fSC/RTTsbG?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7E0E89E8187B3A4BAB4CB42313C704A0@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0256162d-3801-493b-59f4-08d96bdc9df4
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2021 17:35:53.5245
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6Ky0eYXGhW0eCDCdRLMpx/oNu98eILfQgjWszLOiKDdosiXkyn+fmH8OkVp4Yzik6U3Kcv7L7wYEfios0WPqdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB3777
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10092 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 phishscore=0 mlxscore=0 malwarescore=0 mlxlogscore=999 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108300118
X-Proofpoint-GUID: ZSRGIcKXc8CdSpe-_SU4q9bW2bWd4s4r
X-Proofpoint-ORIG-GUID: ZSRGIcKXc8CdSpe-_SU4q9bW2bWd4s4r
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Aug 30, 2021, at 1:24 PM, Olga Kornievskaia <olga.kornievskaia@gmail.c=
om> wrote:
>=20
> On Mon, Aug 30, 2021 at 1:04 PM Chuck Lever III <chuck.lever@oracle.com> =
wrote:
>>=20
>> Hi Olga-
>>=20
>>> On Aug 30, 2021, at 12:53 PM, Olga Kornievskaia <olga.kornievskaia@gmai=
l.com> wrote:
>>>=20
>>> From: Olga Kornievskaia <kolga@netapp.com>
>>>=20
>>> Given the patch "Always provide aligned buffers to the RPC read layers"=
,
>>> RPC over RDMA doesn't need to look at the tail page and add that space
>>> to the write chunk.
>>>=20
>>> For the RFC 8166 compliant server, it must not write an XDR padding
>>> into the write chunk (even if space was provided). Historically
>>> (before RFC 8166) Solaris RDMA server has been requiring the client
>>> to provide space for the XDR padding and thus this client code has
>>> existed.
>>=20
>> I don't understand this change.
>>=20
>> So, the upper layer doesn't provide XDR padding any more. That doesn't
>> mean Solaris servers still aren't going to want to write into it. The
>> client still has to provide this padding from somewhere.
>>=20
>> This suggests that "Always provide aligned buffers to the RPC read
>> layers" breaks our interop with Solaris servers. Does it?
>=20
> No, I don't believe "Always provide aligned buffers to the RPC read
> layers" breaks the interoperability. THIS patch would break the
> interop.
>=20
> If we are not willing to break the interoperability and support only
> servers that comply with RFC 8166, this patch is not needed.
>=20
>>> Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
>>> ---
>>> net/sunrpc/xprtrdma/rpc_rdma.c | 15 ---------------
>>> 1 file changed, 15 deletions(-)
>>>=20
>>> diff --git a/net/sunrpc/xprtrdma/rpc_rdma.c b/net/sunrpc/xprtrdma/rpc_r=
dma.c
>>> index c335c1361564..2c4146bcf2a8 100644
>>> --- a/net/sunrpc/xprtrdma/rpc_rdma.c
>>> +++ b/net/sunrpc/xprtrdma/rpc_rdma.c
>>> @@ -255,21 +255,6 @@ rpcrdma_convert_iovs(struct rpcrdma_xprt *r_xprt, =
struct xdr_buf *xdrbuf,
>>>              page_base =3D 0;
>>>      }
>>>=20
>>> -     if (type =3D=3D rpcrdma_readch)
>>> -             goto out;
>>> -
>>> -     /* When encoding a Write chunk, some servers need to see an
>>> -      * extra segment for non-XDR-aligned Write chunks. The upper
>>> -      * layer provides space in the tail iovec that may be used
>>> -      * for this purpose.
>>> -      */
>>> -     if (type =3D=3D rpcrdma_writech && r_xprt->rx_ep->re_implicit_rou=
ndup)
>>> -             goto out;
>>> -
>>> -     if (xdrbuf->tail[0].iov_len)
>>=20
>> Instead of checking for a tail, we could check
>>=20
>>        if (xdr_pad_size(xdrbuf->page_len))
>>=20
>> and provide some tail space in that case.
>=20
> I don't believe this is any different than what we have now. If the
> page size is non-4byte aligned then, we would still allocate size for
> the padding which "SHOULD NOT" be there. But yes it is allowed to be
> there.
>=20
> The problem, as you know from our offline discussion, is allocating
> the tail page and including it in the write chunk for the Nvidia
> environment where Nvidia doesn't support use of data (user) pages and
> nfs kernel allocated pages in the same segment.
>=20
> Alternatively, my ask is then to change rpcrdma_convert_iovs() to
> return 2 segs instead of one: one for the pages and another for the
> tail.

At this point, it's clear that the Nvidia proof-of-concept is using
features that are not available in the stock upstream RDMA stack.
I'm not sympathetic to making code changes to accommodate them unless
or until the upstream RDMA ecosystem can deal properly with their use
case. (they are of course free to modify the code themselves, it's
just not likely to get merged).

We'd have to poll the set of deployed Solaris servers to understand
whether it is safe to remove this logic.


>>> -             rpcrdma_convert_kvec(&xdrbuf->tail[0], seg, &n);
>>> -
>>> -out:
>>>      if (unlikely(n > RPCRDMA_MAX_SEGS))
>>>              return -EIO;
>>>      return n;
>>> --
>>> 2.27.0
>>>=20
>>=20
>> --
>> Chuck Lever

--
Chuck Lever



