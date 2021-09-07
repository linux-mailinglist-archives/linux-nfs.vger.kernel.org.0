Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E51B402CC9
	for <lists+linux-nfs@lfdr.de>; Tue,  7 Sep 2021 18:22:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233616AbhIGQXe (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 7 Sep 2021 12:23:34 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:6488 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231961AbhIGQXd (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 7 Sep 2021 12:23:33 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 187EkYFv017713;
        Tue, 7 Sep 2021 16:22:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=nh2zeVhQpWT6O7Bdpn0udWcvPSLJT7nFya0UyM4FHdg=;
 b=COKboi2FbZ2rxDSSEsHVia3oeETq5yQ1iufN19Kq/QNXL4Hlttevb6hk0k0Ip8LUJejm
 PrZob2sCcUSl5piIK2a232RL9uab/MPW92QYM8ANxaAnoKHRsa5nnF5+5NT1FMdzs+ha
 xhpd3VqUFSDzHcVZRRwuNhHvwzdkqeG2g5Egerbq7gfW7a/fyiaaBSkiUEPfQq8RCdmM
 vbexvgLnMHE611pqawOoZSugd3RyFjURwcarBOzwRa1NLe67WjbCTaOjPGBe/iT2KEQH
 h523z6IFrCutmwVZNDPQyzLyYKAeKC6DHKS7W4exbQhgpMK0GVJBuSUvjh/BlhDTsQdw Mg== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=nh2zeVhQpWT6O7Bdpn0udWcvPSLJT7nFya0UyM4FHdg=;
 b=mxz4bqbzgl8XrUOQvoahx98CKIP/Cq4CJx3trWvMvQeJiHDiSg9UhcXrBD86BfIdChNw
 Pb9pHm0XfpjMtHqdrcBW4mTOkqfKE6zRZ06wBxbD4DoMPWQ/Iwe/0a2wtKKEdL8fNcv6
 tdDbyCPpPkb87hWT1PXCixXGrZhGWfIlTMOjQyoq1ECnDUz0Djwfi1yyFLPuOwjtB2TR
 bEHBwzS8hPoE3yU878yOiaYFGpmM9Ahg5Ysksqf7vM2kK7DbxwJQBEMcqtgyGXvpQ+1m
 FL+n/MTPyxYqiq7TjfajdNreoLohfkbsR0XA1Ui2aKwiITLTA5JOY1rTzwaSQpoT5ENg xQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ax0vf2622-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Sep 2021 16:22:09 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 187GGF7e094906;
        Tue, 7 Sep 2021 16:22:02 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2170.outbound.protection.outlook.com [104.47.58.170])
        by userp3020.oracle.com with ESMTP id 3avqte59tc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Sep 2021 16:22:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mx43J7RID9/oMow/GfWTTQZDkxl8UPF4pMTR+VbNkSU8jmpEhBx35yrvlSCF+la82CYBSVpzLtgMvhdCCWLpWDbwCzMA0aM8yOwL4XizvYNuRtdqPqtb3n7Hmanlou8IK8m+312RNcQitfW8PdjVvSYcjklb2bYiuKdqaogqCS+YgDWFx4l0U13zcYIKc+pXQFjyM0KhWeF+eAhZpKA5/phxLUzavf686/2ptpxeC3fOCgSS5rt/3+JUr3NQg7piw+bPKrBeD/lx3MVADLFpOlzDOU+Lqv2Yp7vJsCXq6EZfTb/f9wo9SBuNI2PrzlBiSitMkRSWIUq+gvgBK8yoJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=nh2zeVhQpWT6O7Bdpn0udWcvPSLJT7nFya0UyM4FHdg=;
 b=nIxB1uftBDl5Da49iOLkWanw8X0ecmKOmQLRP9JLdHYjT1yupiAOJDGx/9qHAbfBaMM+EahkaBZwPsR5cQDZ0RWkCQKtSMghS2SyCZOHOr6mVrphcpjuEhqKYFC2sZBVRuu2q5QvpaKbeMr3ztOV8iifKP9NzEJW+DIDVtxDiinOK0k3Ze8vLQ9IUMOgdrejhjpo/SICvxE9muwchktCgY2dnTXLwZraWtaJL3b/x9chF7Bp01AJCS5YMAx9AXO+NQ+BBQwlN/BDZpv/DAD7Prgm0yRFxnY1HnA0TQFjIrP6JEwtaDr2ihgbh0GyZVq7UH647FUN5/1B0P7eaDc4UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nh2zeVhQpWT6O7Bdpn0udWcvPSLJT7nFya0UyM4FHdg=;
 b=JQBEH2bn265kt1mQb0AthRG8mRZkxV1gNIwp6kN75ZM8MWIku5VqTB4jF5qoJ+BoXtF/Pe2KjU66y4m4j4GxpeRnGi3zN24VD2WLzEpec3pmr0yFuCKoyyrIk0glPnEzpciKn1+QRyBp01pCQPCpzEnw9lMY1Edpe7yjcUI2SqM=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BYAPR10MB3511.namprd10.prod.outlook.com (2603:10b6:a03:129::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.21; Tue, 7 Sep
 2021 16:21:59 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::f4fe:5b4:6bd9:4c5b]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::f4fe:5b4:6bd9:4c5b%6]) with mapi id 15.20.4500.014; Tue, 7 Sep 2021
 16:21:59 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Mel Gorman <mgorman@suse.com>
CC:     Neil Brown <neilb@suse.de>, Matthew Wilcox <willy@infradead.org>,
        Bruce Fields <bfields@fieldses.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Subject: Re: [PATCH] SUNRPC: use congestion_wait() in svc_alloc_args()
Thread-Topic: [PATCH] SUNRPC: use congestion_wait() in svc_alloc_args()
Thread-Index: AQHXotncpaMymYUO4UWd0a8FIk5gVauXJwiAgABMkICAACIbgIAAJs+AgADuHICAAA1PgIAAC1UA
Date:   Tue, 7 Sep 2021 16:21:59 +0000
Message-ID: <389707DA-96C4-4E99-9487-0603A0FB6FF6@oracle.com>
References: <163090344807.19339.10071205771966144716@noble.neil.brown.name>
 <848A6498-CFF3-4C66-AE83-959F8221E930@oracle.com>
 <YTZ4E0Zh6F/WSpy0@casper.infradead.org>
 <163096695999.2518.10383290668057550257@noble.neil.brown.name>
 <163097529362.2518.16697605173806213577@noble.neil.brown.name>
 <8ED6E493-21A6-46BC-810A-D9DA42996979@oracle.com>
 <20210907153116.GJ3828@suse.com>
In-Reply-To: <20210907153116.GJ3828@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d5d506a3-986a-485d-5e74-08d9721b9e45
x-ms-traffictypediagnostic: BYAPR10MB3511:
x-microsoft-antispam-prvs: <BYAPR10MB35111102E85E5B795B6B1FEC93D39@BYAPR10MB3511.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dV+jZTdYwomCr7Wyf2ft8zuwOmx8mateW10ohm683QYfE+L7eLvAX8rOcI+eKGLANifg9pQ6/39xUoPp9HDb1Rw2LJLUtZ17uYGpkxLdfdtK+skOJoX2UZgggYZYYmHpuv6eYHQGAkVXX5ksB5yAgjCFS7nJrnIfpwNmZQ6/bxNhRcl92U5vy+Et+VF6oTLP7jXaLzziyIwr4rxth7S8s2g8gKXE3YCjmzWsQmdAlxFhF+78eNSPsj4omxiN7OjlBGx8H7IX8zVp+uncokZumJK0auQsaaTY7LAbGxlisHRO/HjUFvMZmcH5luPp01jVEDXwOO+0UA+Samvy7ZhxyFMW6r4Tggx64sPZb0wRBLVNKzgDzWdQbRRp4JzEPcPTDFmCV5Uv/jIFKxSLzv0xTqqSXXe21tF+yH1Cn+I6PzmR+TJ48AA0n6VHSJFEcsaOVp3EDBxhtBHTgdXaIuZKz8duRRfkHyJwiAMqXs3x0LXiqp9zNiRhXWg+Vb7YZE+r09zouyQEd9UR5vguZ89X4MguslOlPJs8Z9se2ttD65XpHYmh99BSIKSTDXwOFxBEgDR9eft5lBKMrC6Mb/z8FHJTssjXFuJNAGTuwYsHJLmV9H+yK06yKbMmwLhvUDEcLNWRX/JcnyulbpJq58xkvlU1XJWHlPijq+nrTsTVw49VGfJGOjihtNw0hlbKX3/UPq3m20T1GimKtJZSAD86nDEll+Ct4R/GlaiJ7BfdiHF5YEY4eF6lSP3kw9UsptOp
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(376002)(39860400002)(396003)(136003)(366004)(5660300002)(86362001)(71200400001)(4326008)(316002)(54906003)(91956017)(76116006)(66946007)(36756003)(6916009)(6512007)(2616005)(8676002)(122000001)(66446008)(64756008)(6506007)(66476007)(478600001)(38100700002)(53546011)(66556008)(33656002)(186003)(26005)(6486002)(38070700005)(8936002)(2906002)(83380400001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?PNd503OSw5sL+NbQTsyRgI1cCnshLVTQcopoEjxTIlLoZz1RRXWma3enJpti?=
 =?us-ascii?Q?av1nmlwdKwHFuE8BLk1iK6y86ddwKZXRSq7xVdjWt0os2TBjlm0ADlNL7OVn?=
 =?us-ascii?Q?EnsJXkbnWPaV6L+o81rDLWXo4onJMfmX2u5ZEWW0t4R93iNx4K9JEk0vpdSw?=
 =?us-ascii?Q?+SLo5JHxbXhk5rlKm/+lRzFv8k6kZJfqxqQGdkQxmlA4cDQzo6YN/MY7ebI3?=
 =?us-ascii?Q?WjvS/1vs9ne7i5LaKK5cslCKdIcq1dPH6hmcOmS5QceC2Mwckkq5JHLkwsi8?=
 =?us-ascii?Q?EP8ps2v+rT+NEWA2fW7rnEB4UEFdO2AN3VGKuACDmUHZqf7j69SRcgVO4PqN?=
 =?us-ascii?Q?7RjS+H8rtF5+42Ph2ano3o2luzTxlFdLZwGFf2qw82DuIhUAGXrN2z0oWhpM?=
 =?us-ascii?Q?ySayXb4fcrnus87DXZAbMjGNhExTJmbendObRPHOUcC/BEeCPfQ7+o9YfoSQ?=
 =?us-ascii?Q?w1rRTg62X+a8UOq+RsDCx4i27c3Uklf86kJ8sn2qH/lR4j6KI+8pOusLEDLP?=
 =?us-ascii?Q?Z16Sbc+e5VGEOM1AUZG6G5I5oT3u1wr3Oj0UAAQnS3umQm605TG26ugfrrlW?=
 =?us-ascii?Q?3C+jtA5cBmaHvEpzk1+TN7bJwbfj/AB3O6FY/sLqu3GtjmAaeCRGF++F3saq?=
 =?us-ascii?Q?CCSIgq/nI2N5vDGXf439y8usQLf/B+fcYK5YTNBmf+xx9DbVIWkrY93zbsKc?=
 =?us-ascii?Q?r4ZZwjjl1fjdN5ajN1PWMk8X9p3+yH+0WjcPrslOpeZ0viCgbeUTqzR1gFbp?=
 =?us-ascii?Q?eMMPKcj2trosZMUqLul9rLqAjQig3sMSpf+46wEssAFDR1BNRNPEOeMuuexY?=
 =?us-ascii?Q?iwwIkgc3oL7L8VJsNuqYLyi8VznYckjgcgbA/hiBy8aoh8o0dmnnNdMOuyPv?=
 =?us-ascii?Q?7buwN6e2DqYCaC1cXiq7wMwJL6XSitU8SyX8DwgtblZ4n/m5T52s295T1Oka?=
 =?us-ascii?Q?yxeEKeKkPSPRLXF6FgEt26YUk3Mtiml2sQutU2WOCD/yx1XJEAKd1o++R/W3?=
 =?us-ascii?Q?tQRoeWV0R1IBhUxrkyBL+yc2yJDTuKmvIOf7wZPCDUqJJolmrtXm2Pi36wYu?=
 =?us-ascii?Q?1nle7VWhiyIlfMseLY71WaruZlnUd27z2Cq/2UHtU0X1tede3hiYIpyUOeEw?=
 =?us-ascii?Q?jepbZaGpaT2U2rVRQ67QWPJUX/Ln3gY5dsYdAcV3CId/BucqMa8y+R4YdxoK?=
 =?us-ascii?Q?BRT+fmBf3Z79Rq8Vd6bhkFJtQ2+qcAU7JGp+KQ3/5H+TAGsJEvO10qrF9i/Q?=
 =?us-ascii?Q?Cr3MWLBA5+Rmr4iSTK8YEVFzZklOccru1nujoELwZFB+B7gaXC4G/KSnR3Hi?=
 =?us-ascii?Q?fvQHUO8cV8CkpwIIZt0kXJb9?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <0DCA6A5825BF01418E7CE68CC7A96EC0@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5d506a3-986a-485d-5e74-08d9721b9e45
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2021 16:21:59.3908
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Yk1314TxKkv+frrZGqyBHUhwBWq+KhfHB6xMm3E+zHpmUjncH0ZOcCxTAmjhaylfD7aQKaEbjUXxovIi0qzL8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3511
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10099 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 bulkscore=0 suspectscore=0 spamscore=0 malwarescore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2108310000 definitions=main-2109070107
X-Proofpoint-GUID: 5maG2Zho244qZbP9itzOvp-zVxph4zLi
X-Proofpoint-ORIG-GUID: 5maG2Zho244qZbP9itzOvp-zVxph4zLi
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Sep 7, 2021, at 11:41 AM, Mel Gorman <mgorman@suse.com> wrote:
>=20
> On Tue, Sep 07, 2021 at 02:53:48PM +0000, Chuck Lever III wrote:
>>> So maybe we really don't want reclaim_progress_wait(), and all current
>>> callers of congestion_wait() which are just waiting for allocation to
>>> succeed should be either change to use __GFP_NOFAIL, or to handle
>>> failure.
>>=20
>> I had completely forgotten about GFP_NOFAIL. That seems like the
>> preferred answer, as it avoids an arbitrary time-based wait for
>> a memory resource. (And maybe svc_rqst_alloc() should also get
>> the NOFAIL treatment?).
>>=20
>=20
> Don't use NOFAIL. It's intended for allocation requests that if they fail=
,
> there is no sane way for the kernel to recover. Amoung other things,
> it can access emergency memory reserves and if not returned quickly may
> cause premature OOM or even a livelock.
>=20
>> The question in my mind is how the new alloc_pages_bulk() will
>> behave when passed NOFAIL. I would expect that NOFAIL would simply
>> guarantee that at least one page is allocated on every call.
>>=20
>=20
> alloc_pages_bulk ignores GFP_NOFAIL. If called repeatedly, it might pass
> the GFP_NOFAIL flag to allocate at least one page but you'll be depleting
> reserves to do it from a call site that has other options for recovery.

True, an allocation failure in svc_alloc_arg() won't cause kernel
instability.

But AFAICS svc_alloc_arg() can't do anything but call again if an
allocation request fails to make forward progress. There really
aren't other options for recovery.

On it's face, svc_alloc_arg() seems to match the "use the flag rather
than opencode [an] endless loop around [the] allocator" comment below.


> The docs say it better
>=20
> * %__GFP_NOFAIL: The VM implementation _must_ retry infinitely: the calle=
r
> * cannot handle allocation failures. The allocation could block
> * indefinitely but will never return with failure. Testing for
> * failure is pointless.
> * New users should be evaluated carefully (and the flag should be
> * used only when there is no reasonable failure policy) but it is
> * definitely preferable to use the flag rather than opencode endless
> * loop around allocator.

As an aside, there's nothing here that suggests that using NOFAIL would
be risky. And the "no reasonable failure policy" phrasing is a
parenthetical, but it seems to be most pertinent.

IMHO the comment should be updated to match the current implementation
of NOFAIL.


> * Using this flag for costly allocations is _highly_ discouraged

I don't have a preference about using NOFAIL. I think it's a good
idea to base the wait for resources on the availability of those
resources rather than an arbitrary time interval, so I'd like to
see the schedule_timeout() in svc_alloc_arg() replaced with
something smarter.


--
Chuck Lever



