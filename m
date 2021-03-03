Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8C3532C6A0
	for <lists+linux-nfs@lfdr.de>; Thu,  4 Mar 2021 02:03:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387822AbhCDA3l (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 3 Mar 2021 19:29:41 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:56654 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233959AbhCCSUa (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 3 Mar 2021 13:20:30 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 123I97Rl183097;
        Wed, 3 Mar 2021 18:19:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=rXDehglskqFXksoM8k7qYcYaqaIZfI24o8x8Qs1rzIY=;
 b=dZqrwqS59WPHN2ROEfMqxVU7AkZ5OnO6oncGsWOj3ewU7U+INY56OAMveW5cw+ICXkOZ
 NQ5z7E4wDAn/DCAEirTI/bAZmA2YPt+1c9Rb66DaPaZs1ZgvDzZU/U0u1Mm8yiYL7MJt
 2/BK8u1lEWzOMtJ3fHlvyXeFKenCXU8TFHiQ9DDIr2lGQ35WAd3UOQCWmh+IKl7AVm1P
 qPZ4JmdgX3FMIJWy2ZIYJ+QpYm8YQ2YgZB8mfoffqSwk9vp0z9dNAOhDw9imcsQo6esZ
 290wK8hF1f+3tFunrNvgQaWmYx28k5Fj/4iqYIGNvm526NiMYKtweKW7NOjDgFPBWjEE VA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 36yeqn4da1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 Mar 2021 18:19:36 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 123IAe6d045196;
        Wed, 3 Mar 2021 18:19:35 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2103.outbound.protection.outlook.com [104.47.70.103])
        by userp3020.oracle.com with ESMTP id 36yyutt5er-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 Mar 2021 18:19:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nlz//nlXEO+L6qTmawOSRVRBXPIej9X5DHjpvOg+4Mkw6BqtNs7/AePYkkIRbMPV5sVZLuLhPCho1K59qnSCgGdMZW5uGPIoweC7pFuE6lWG89QZpY31/H6jF/cciUmwLpQAdkLgysSgOMzkccstQsscRFgVVFnOBgXWLXQPwiPwwJD8t1WYQ8gyaCjvLcsQXrd/3YTSGhyABDEcLXBHEdSGqVBOkDJpK6dXjuqmcstDzl+qfOg22QIsy1sv1o5oyD3jll7/1CGKug2YoDYgeCApTxruWErTmr81e8myzIWpWnbZrZNkuhBO0xTAyBQYCPED6ns3gnF9lH45S1L9VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rXDehglskqFXksoM8k7qYcYaqaIZfI24o8x8Qs1rzIY=;
 b=Zj+pTH2sFMswjxzHjHSSY3xV82MzoNvoHEQGh04+UGmx+9NCLAnmvt6SVpUNP9I8OLrN89vJ0rH6LoC27Y/zU0n8xNpFeIwQNtKZN+NC3IsIJHIGZdYKrJ8GeXHe71Kv324lX/xpUsjjG58TFkXbJUk7z/F7lShjVqTmwr6YMB2eWfkbbY64oSIsLtkT9ktbm6HqQQGAr1HxOmCtr5HQNVMKDNawBkLUp24twz1zNnPNdY8HK+mzYVU/YQktpMgJz6LP/jBSG7pfwBzmZBwXQ/SRBlaAFRx9Zo5d4CoSYT2FudaAVeDXIdZvHCZMzQs1WSoyJXKHsOM+vRmXuONwiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rXDehglskqFXksoM8k7qYcYaqaIZfI24o8x8Qs1rzIY=;
 b=SSHtiNnJE2MbW+a9PGec95/3wprGl1uVqPgoHfwVedCyQD3m28CYtlmvFEI8WoVsciQwyMTrej4+l6j/9AVQamE5vKEqgnpbs9spYnWd6waOIcHoR0KiNbK2+XWxk2M35P7uP0MM7lDvmM6BDpg14nuxWJJP8iVCc5DzB5orX9Q=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BYAPR10MB3333.namprd10.prod.outlook.com (2603:10b6:a03:14e::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Wed, 3 Mar
 2021 18:19:33 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::6da8:6d28:b83:702b]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::6da8:6d28:b83:702b%4]) with mapi id 15.20.3912.017; Wed, 3 Mar 2021
 18:19:33 +0000
From:   Chuck Lever <chuck.lever@oracle.com>
To:     Bruce Fields <bfields@fieldses.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v1 19/42] SUNRPC: Fix xdr_get_next_encode_buffer() page
 boundary handling
Thread-Topic: [PATCH v1 19/42] SUNRPC: Fix xdr_get_next_encode_buffer() page
 boundary handling
Thread-Index: AQHXDq5E9L4cYzCeI0iQSySXwa3yeapxRKEAgAEl6oCAABNjgIAAGDkA
Date:   Wed, 3 Mar 2021 18:19:33 +0000
Message-ID: <D8625219-C758-44C0-A74E-272019E12C2E@oracle.com>
References: <161461145466.8508.13379815439337754427.stgit@klimt.1015granger.net>
 <161461183307.8508.17196295994390119297.stgit@klimt.1015granger.net>
 <20210302221130.GG3400@fieldses.org>
 <592A34CB-C178-4272-8905-F3BA95BCE299@oracle.com>
 <20210303165251.GB1282@fieldses.org>
In-Reply-To: <20210303165251.GB1282@fieldses.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: fieldses.org; dkim=none (message not signed)
 header.d=none;fieldses.org; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [68.61.232.219]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cf62f906-1d1e-4bf9-525c-08d8de70e521
x-ms-traffictypediagnostic: BYAPR10MB3333:
x-microsoft-antispam-prvs: <BYAPR10MB33334E58969D4CF64185319593989@BYAPR10MB3333.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: O09KO50UPo+iJ4PjhWCmIIpp6dJjyLbEtYuLzgeYPMZdZooCPMyQpFayhY7us6q85GIG+bTTKgU8jqWdXgSmaI6CjV60MEwJNcN13Y5reo9wNhRtbfQA3hFpNXt/brg+ZIbPetsV0fxXINlE6Sco1v7tYcBcUnotXy+MabDZBOzwYKpBfg36hQWRx9PYyJ/DeyCM5NqGYJS1cMxrM8u19B2ZHd8wEa009MVKhulIQ0jvAl9zkT1iYjD9I6q6cUA63aBQ6zWaPqX6WgxyX7LID41ufXtzhOsn8js4NaAsNi58PA9qoEXMQd2/oCJIRJfcm/YFLOvTKCT9gxpIS374xjRNEuuQBmDpDxJHRPT7IHnd35oo5tp2pBuE4Vj2Yzndr6ys8KKkJP+k/IGS7pFRguSIG9N7aecEx5Q6I+B+ocLvxbSNLuX5jMgDhk9vQLuWgxIcEJsqtSXs6XH+Pfj02teRLB4z4P1k56X1HmqdbZcqPZvLfwJS94cuITOQFsjOgItMmAdfnQr00HTu4emIMjGYWN9YAZJxKu1TQy9XBlwNs4E+AIVVP0ocmdL5E92Bt4dMlpUSJ+fxTPFANKPjGmTSjghh6+ZbJDigE9S5/vQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(396003)(136003)(376002)(346002)(366004)(33656002)(478600001)(64756008)(6916009)(66446008)(4326008)(5660300002)(36756003)(2616005)(6506007)(83380400001)(53546011)(8676002)(26005)(316002)(186003)(2906002)(8936002)(6512007)(91956017)(66946007)(44832011)(76116006)(71200400001)(66476007)(66556008)(6486002)(86362001)(45980500001)(473944003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?CEPc/w53mTb+6vvbdohDme/2nyF4IbqjO4JDcgmuZj4mrAiIirdYcgl+LyJo?=
 =?us-ascii?Q?bD7lmc3f4g4tPZFCrth6HlrHPBThkqJ/Gu8ChkZjG4AUHLXX3kYeQ2p1L5kG?=
 =?us-ascii?Q?AiZulO8C0PTBaOlApiAXm1mo8of17orf9cu18U/YTjg0DMp0/QzBiGJePeYd?=
 =?us-ascii?Q?5fBpR40BUMQ6HLl4SULEAW3oLEAqFcWv/4FvMSq2IMbXvvj+xzarRoGalp1A?=
 =?us-ascii?Q?NSw9Vmt2avuSIaDgrWF6UqG2nNVR60SEHTeiAdd+gH2AOhqfQZvE/paDMMIk?=
 =?us-ascii?Q?JzTtIgAGZ1DLyqNf8QrrFABXeaafk8SiElWuzTA4UM1Oepvqptp4GYVfEGRB?=
 =?us-ascii?Q?RRDlUoA+c9TuvJ6WkN/ERB48VGI24eFWA42mmPhFwRnrKPKXNN5Gi0Ob0G88?=
 =?us-ascii?Q?IoerdM5iXlhToU4AlwOarmfht8OH8XcFTj7YPlWUKNAIMzoYu8ZHyIjDT3K3?=
 =?us-ascii?Q?OpXvSYl4UxoKim1dKqtxJxjYWir7d7a70VYR3eb5xTXFrjfhtYjqiI+BBbfi?=
 =?us-ascii?Q?+d4CZQT3sL0DL5uEwerED8QbKRWh4jhkuwciCezIDtpSvCPNlK5hI7fgloa3?=
 =?us-ascii?Q?LX28uGZD5cFSfOxVjjuo80fzmbLjraqFHRbTzIOi+hofnZ04flQCaFh44AOx?=
 =?us-ascii?Q?s76JToRIigehlHdSqDislMoG2XvuueHOGQ6kkGMNP/a+4SBqLbKQIHDgzYlF?=
 =?us-ascii?Q?3FD7r+rjuovTaoxo8rVciiMjYYbOpBV/m97mBKToNI31+mrCOmU3X8Vbs2QY?=
 =?us-ascii?Q?T6blt5o4gFxs/NRNqVw1oUENvQ5e4hK3mxqOdu0eSQ9dnpvsa284lcr9j1OW?=
 =?us-ascii?Q?KXa97Uu9/JhBm5NcGh0rnL2FDcv3QQSFBd8tiQ071iNeESRBmeu3ZuiLJO0U?=
 =?us-ascii?Q?VrDTP2WDeDItDO6hC8COtfVxnINYArZvQmyL7wD7R1jBNx9IvbeC3EderUip?=
 =?us-ascii?Q?8rYrV99XkUNjqhlR4Oh4qVIZmGf88dnZMSC/77LzRcmowfm7voo7Xl015107?=
 =?us-ascii?Q?LRO9gBb1VXAcNWCGNTWrffdh7wb5ZriSTk5FZA2nHq7JWqAknmgafeP8d39X?=
 =?us-ascii?Q?zH27DkDomHkyghgq5U9UPUInJ7WTRXCRfOHgFhd93ucAhorjOUG9TC8RxtTd?=
 =?us-ascii?Q?Y1wiDhn9P1r1+2vu/Jv4A1Xq200tBYxuPUI6vFEKdleWaWMy4uX79mH0tXil?=
 =?us-ascii?Q?DbBSGFhVARRshtxfvpyPp4A+XtRwUgf2Pri2jHXjpyodNwfaGVNf8RaFYixQ?=
 =?us-ascii?Q?6DImdsPnWvD2GrNBzBngIvr8T3/7thJuQ3V1nX+wYElgXFDoIEq+ti5Y9kHx?=
 =?us-ascii?Q?5awaUnPa/HQ+sDSvzGV850OW?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <0F8661984914B94089180FA0854B9235@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf62f906-1d1e-4bf9-525c-08d8de70e521
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2021 18:19:33.4227
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ok4/d3EPIYHTEF1AWZypRo8zf0/fszJ7wNepsIqyrhU4nj4vHDKg7/FzoKkRxR9RpDM2rpR8aynlVgYI2JqS5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3333
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9912 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 suspectscore=0
 mlxlogscore=999 bulkscore=0 adultscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103030128
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9912 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 mlxlogscore=999 suspectscore=0 malwarescore=0
 impostorscore=0 bulkscore=0 adultscore=0 mlxscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103030128
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Mar 3, 2021, at 11:52 AM, Bruce Fields <bfields@fieldses.org> wrote:
>=20
> On Wed, Mar 03, 2021 at 03:43:28PM +0000, Chuck Lever wrote:
>> Hi Bruce-
>>=20
>> Thanks for your careful review of this series!
>>=20
>>=20
>>> On Mar 2, 2021, at 5:11 PM, J. Bruce Fields <bfields@fieldses.org> wrot=
e:
>>>=20
>>> On Mon, Mar 01, 2021 at 10:17:13AM -0500, Chuck Lever wrote:
>>>> The description of commit 2825a7f90753 ("nfsd4: allow encoding
>>>> across page boundaries") states:
>>>>=20
>>>>> Also we can't handle a new operation starting close to the end of
>>>>> a page.
>>>>=20
>>>> But does not detail why this is the case.
>>>=20
>>> That wasn't every helpful of me, sorry.
>>>=20
>>>> Subtracting the scratch buffer's "shift" value from the remaining
>>>> stream space seems to make reserving space close to the end of the
>>>> buf->pages array reliable.
>>>=20
>>> So, why is that?
>>>=20
>>> Thinking this through:
>>>=20
>>> When somebody asks for a buffer that would straddle a page boundary,
>>> with frag1bytes at the end of this page and frag2bytes at the start of
>>> the next page, we instead give them a buffer starting at start of the
>>> next page.  That gives them a nice contiguous buffer to write into.
>>> When they're done using it, we fix things up by copying what they wrote
>>> back to where it should be.
>>>=20
>>> That means we're temporarily wasting frag1bytes of space.  So, I don't
>>> know, maybe that's the logic behind subtracing frag1bytes from
>>> space_left.
>>>=20
>>> It means you may end up with xdr->end frag1bytes short of the next page=
.
>=20
> Wait, let me try that again:
>=20
> 	p =3D page_address(*xdr->page_ptr);
> 	xdr->p =3D (void *)p + frag2bytes;
> 	space_left =3D xdr->buf->buflen - xdr->buf->len - frag1bytes;
>        xdr->end =3D (void *)p + min_t(int, space_left, PAGE_SIZE);
>=20
> If you've still got a lot of buffer space left, then that'll put
> xdr->end frag2bytes past the end of a page, won't it?

So far I haven't heard any complaints from the kernel. I'll
instrument the code and see what comes up.


>>> I'm not sure that's right.
>>=20
>> Why would that not be OK? the next call to xdr_get_next_encode_buffer()
>> should do the right thing and bounce the new encoded data from the
>> next page into this one again.
>>=20
>> So far I have not encountered any problems. Would such a problem show
>> up with some frequency under normal use, or would it be especially
>> subtle?
>=20
> I mainly just want to make sure we've got a coherent idea what this code
> is doing....

Agreed, that's a good thing.


> For testing: large replies that aren't just read data are readdir and
> getacl.  So reading large directories with lots of variably-named files
> might be good. Also pynfs could easily send a single compound with lots
> of variable-sized reads, that might be interesting.

I've run the full git regression suite over NFSv3 many many times with
this patch applied. That includes unpacking via tar, a full build from
scratch, and then running thousands of individual tests.

So that doesn't exercise a particular corner case, but it does reflect
a broad variety of directory operations.


> Constructing a compound that will result in xdr_reserve_space calls that
> exactly hit the various corner cases may be hard.  But maybe if we just
> send a bunch of compounds that vary over some range we can still
> guarantee hitting those cases.
>=20
> --b.

--
Chuck Lever



