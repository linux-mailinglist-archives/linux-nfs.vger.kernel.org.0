Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB8D4318FD3
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Feb 2021 17:25:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229912AbhBKQXn (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 11 Feb 2021 11:23:43 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:52544 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231691AbhBKQVa (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 11 Feb 2021 11:21:30 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11BGK69Z106939;
        Thu, 11 Feb 2021 16:20:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=tWPD13FFGBlNDy0odGkxkL6jztz+GTYvyC3IcsW4uBk=;
 b=FYv0sbdxeyF7/kCiken/hJfpFIVEVAvN6oVtIc7p5XWbhouvyEQQ+4vt26fjnl8NMmPn
 vnkt7UVJpfkxoREaxQqgUdnsDUdD7Xi4YNaa89rNa0KghTk5nSZBS4Q4y6ISiIaLpu2N
 UkJJMhKaf29c2X/Iuxm8XssIDYn2mq8TAkftX8yONKL5qx1842/HLLJyVjw+DBJHgRYE
 HIQymqeMf2X4xPaEKJ/rK4iFHewVdNSm/of4gmkgdJRhdM5d+m91dgXEVAyzGnaAUZUj
 5NsE3cE1IeVfKsDTRR/y6La8EeXwaKa2jfKmopd2TZ6F8AHhWPEcWFU1a7yz8o75lPAM /g== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2130.oracle.com with ESMTP id 36hgmar8ku-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 Feb 2021 16:20:35 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11BGKA94011527;
        Thu, 11 Feb 2021 16:20:34 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2172.outbound.protection.outlook.com [104.47.58.172])
        by aserp3030.oracle.com with ESMTP id 36j4prrkjn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 Feb 2021 16:20:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U8EOzEZ4u/sUpsAXmpHz5cNjFDvQTGxS/72hkladfz+DaCUZzu+mJD1/vTuPqh+mNedsnszoeb5yNPQj10GhlUuzXcYqbbMqLqNijjCb2KsyWhGonqfNVNEOAfTsBMdjKdtoi3sgvaS/z3eGaX2wNC2oZceMVK4amI9iGsRIGoGoz9qftlI2JZYhCy+0sDWUIyhvdRw8N8P0Z27cnAhkGEUgMgPv+oczE+m8dbImTYOOhaSUCZp6ThTVdPpYopWZu7kkRuhn0oo/2DLr2hX2efcsGR3t3RxwpXFRIC5mzNeWR9PMd+wIyMNhNHUkN7RlyURslLxj8ECBDtmscIGt/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tWPD13FFGBlNDy0odGkxkL6jztz+GTYvyC3IcsW4uBk=;
 b=gtkF6R4zBE70WIM4dDLmTOfLfZxnrwaK1q5R/BCldA/w0stfmqHDiUDAErsjAyUr4uEzSgqbkarW2yOa7seVRrC1W/0dOmF4Mka8bQftjPkHdlbz0KKiN4V4+ROVakdZMUsqxDowUmRYldXtIDqN5MNGA0a/tf28GF7DNjzmdnphug3p9HopiF2WbypSO7wBJj8jOuVPE8h4nS7DrmfePyjmITpH/RYaMSYtTQXwm1VBFtvHkf+fBVbjJYXIebNNNv5NEOueaBggmAT7Lrvn329SH5gYootBaKuuJimJREVHdY9pzYAk0U77GbAU4N9zk9KqfZdkkwoOjGWjKQnS4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tWPD13FFGBlNDy0odGkxkL6jztz+GTYvyC3IcsW4uBk=;
 b=lGcHhyi+PpHmIotlHCxC+Mg1yGCjoe1NjOsd60EJXQy7tBniDrfZxe3ktgI16962R0BjwVVyE6q4p+tTRSu45t+Oxq81Q6jVl+9C1LT1kpPG8RjftBtINxqtGaAkXA5ldtgLX6Xl38JrnfRuef0NtX1z2KIP2dEg2NusGzbduR0=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BY5PR10MB4131.namprd10.prod.outlook.com (2603:10b6:a03:206::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.26; Thu, 11 Feb
 2021 16:20:32 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::6da8:6d28:b83:702b]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::6da8:6d28:b83:702b%4]) with mapi id 15.20.3846.026; Thu, 11 Feb 2021
 16:20:32 +0000
From:   Chuck Lever <chuck.lever@oracle.com>
To:     Mel Gorman <mgorman@techsingularity.net>
CC:     Mel Gorman <mgorman@suse.de>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Jakub Kicinski <kuba@kernel.org>
Subject: Re: alloc_pages_bulk()
Thread-Topic: alloc_pages_bulk()
Thread-Index: AQHW/jD1lENfvnr+s0+/RnBes7PyXKpPoPgAgAFz0YCAADINgIAAGAqAgAClRACAAKuMgIAAd5CA
Date:   Thu, 11 Feb 2021 16:20:31 +0000
Message-ID: <F3CD435E-905F-4262-B4DA-0C721A4235E1@oracle.com>
References: <2A0C36E7-8CB0-486F-A8DB-463CA28C5C5D@oracle.com>
 <EEB0B974-6E63-41A0-9C01-F0DEA39FC4BF@oracle.com>
 <20210209113108.1ca16cfa@carbon> <20210210084155.GA3697@techsingularity.net>
 <20210210124103.56ed1e95@carbon> <20210210130705.GC3629@suse.de>
 <B123FB11-661F-45A6-8235-2982BF3C4B83@oracle.com>
 <20210211091235.GC3697@techsingularity.net>
In-Reply-To: <20210211091235.GC3697@techsingularity.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: techsingularity.net; dkim=none (message not signed)
 header.d=none;techsingularity.net; dmarc=none action=none
 header.from=oracle.com;
x-originating-ip: [68.61.232.219]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bd5380c0-4831-4727-4058-08d8cea8f462
x-ms-traffictypediagnostic: BY5PR10MB4131:
x-microsoft-antispam-prvs: <BY5PR10MB4131DA5FB3409967F132FB66938C9@BY5PR10MB4131.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FnCKgyyyzuzUrOsyFYDmbI165V7YF9usHMLA0hXWXuu/onHVC/bv6jDKeekCDMntfEZRCqgO34/idSU/Pbp3n6fWS2EblNwAHLyJdeYq+aKwSNH+alVyWE+hq30hEOBN7eCuMU45LCmjsCauEbkMN6GiCk8Eh4ugDzk6LFMCWqyZc0e/KRB3eiS7FqMhW6r56ICGSPPV/s1sek6jMXjKfNqLcExXQ53pZFtdijfbeE4lfxmUA7rx+qYjKsXLCD32GkMFLbaPsR240XM+cWl4GSAN81iZKx3T2mt2mzOV3P6ZDiNqq6d+O+b+CSr27ylUNG/VQpDUqIMMXlA2A/XJhRhn6RC8JETMTc+WiwcCes4aaxSC792R0L3wJvlVaFAhUXs95xlmbQOynOiUHR4BdY95o1FcJedzkWucWjq3scg+Yb+Tew0o3FtBAnTkULZnyE10gmEa/+Xk8FR6A03AP9XL1+zcURIT7jDpm3WUhwaInglWmcAk5klAWCFqRtag9rvP8vcbdXrsueyLYUfQjqZCzQCQDIgXeFo9yXA8uqOcumkm93QC+W36FrvOatsxHJ/pVCDLy3Qv565KNQFcGA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(376002)(366004)(396003)(346002)(136003)(91956017)(66556008)(478600001)(36756003)(186003)(86362001)(66476007)(7116003)(5660300002)(64756008)(66446008)(8936002)(4326008)(71200400001)(76116006)(66946007)(44832011)(2906002)(33656002)(53546011)(316002)(8676002)(6506007)(26005)(54906003)(6486002)(6512007)(6916009)(83380400001)(2616005)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?kdvAK60MXNnS+jahfc+xpqfJ1HBz4ybs0yBzzbAocBMEK9rxMvRji/4XRxpb?=
 =?us-ascii?Q?XnXFAETngg+Aj45YYVPJA0n6oIOFCxMQ3+99QsWFNvxKNc7TpYaP3S6F/xwu?=
 =?us-ascii?Q?lilgG4htB0vegxzkDYDTedHrQ6o84k+6w+Q4LLzS8m+FA6Bi9Ih9ZcpsXibM?=
 =?us-ascii?Q?geKKzExdCsBFeDoD9FNQ/S8hHwAs+gSodIm7IUkJEr/yXcREHa/j1IbPVcxd?=
 =?us-ascii?Q?wbfXcsYUie+F9U7Yny5wX0HpM//xuNcvd+CvPtmqSE+OEhbJXIYmjc1VA/c2?=
 =?us-ascii?Q?x/55XheZhHt1I8afHiStteN/sCIfiwbLp/9xxB6cubwfZ6woCP2xpc5brP76?=
 =?us-ascii?Q?DI+C+BVdJWoR8tnY2xyhjqSbTTMH69ihtNmPsDRjG1tQ8IbTt1f8nPL4EMrm?=
 =?us-ascii?Q?4bLOXST6dHroyfu5P2fjda4l8LIcHYOdnZkBnYE85ZQ2dZTmviLTrZrvK0dU?=
 =?us-ascii?Q?ML3JX1w/rVssQyOCgXw9scJxqpsV8tUI2uYpifvP5s/yJRb2JvdsuZMeATOm?=
 =?us-ascii?Q?Rt7M2FhCIn8DpbttILIuCWlo0VdHwW8t0Wx0IUT7hpE91S3C0B2Cw1ttM5Pc?=
 =?us-ascii?Q?TEWpkwL5vWm/R3ahm+qVJdBygzrXT2/XZkPrntUnOHh/e2JgGZJ4LafAYMCH?=
 =?us-ascii?Q?Bfxwa50jzO3DlxywzNKbha+TPe/KSPAccMChDKoVBssxeS+mlG/w1GrLTYJL?=
 =?us-ascii?Q?31cXi7axYnJRKWEV6G9VFLBugKLhnBEhfATsun1cPX/cLI8WvyEY66xczy4V?=
 =?us-ascii?Q?mDIH2PNew/+vURvzgnsmxaG13RGNKHNHsRknkGgYP6fKBvFP5ov2dY0cEQjK?=
 =?us-ascii?Q?1y14dwgjPgf0rsIkoX8xC+ybUbCEKsowAB5KChihSk731X0JiLk9y9nUPn97?=
 =?us-ascii?Q?n2tkGDnB3HPz7RTP+6I7g54Lf/m2q419SsPTiC3TTQcVMGKOhNdmGgDTTmBo?=
 =?us-ascii?Q?W0frIuv8ejOKODCsciYbDbPe3ifq9vjaVmqljn8ApFgMBdh+l4ma87ZRoW6Z?=
 =?us-ascii?Q?Rw0csRQrdv/pKdSQHjTCXwDcjTU40CSb8DFssaw2Z6uNLwR09yoto/K82TUR?=
 =?us-ascii?Q?UAlKNKNjpEcw17HpqDkjeNj64Zl0Y8svfe2Yz9CUdar+X8Epm3f2dUsoySP9?=
 =?us-ascii?Q?XrJvj8GN9fEsHTFNH1Iooe7DJefG+EL+gks1mZkuwHtnnjfr54W7JbqmA1Zf?=
 =?us-ascii?Q?GveTrmGssRBVi45a1n7UK0plOOfNDphga2Nlu9IQKTA9z2XSDugmX/6eaL2e?=
 =?us-ascii?Q?Loeq2J2GkyBRWwrEm327sDsIFvHXjPx8SXgG65oMrYZ4fAqs4WuVYZKKWSQi?=
 =?us-ascii?Q?DDMuiksa/EXGZxrkADvci7vM?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <441ECF679B6B564EA443DDA909A09D4A@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd5380c0-4831-4727-4058-08d8cea8f462
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2021 16:20:32.1219
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QV2j7oOZQ+WepypBqrCZHYJBawZx3w61zsvAJNjaFXMwRcQiJLwWmGpeCSB6pd2eFJI1oaOXvf4wlAd9wqYA8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4131
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9892 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 phishscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102110136
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9892 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 spamscore=0 lowpriorityscore=0 phishscore=0 adultscore=0 impostorscore=0
 suspectscore=0 mlxscore=0 clxscore=1015 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102110136
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Feb 11, 2021, at 4:12 AM, Mel Gorman <mgorman@techsingularity.net> wro=
te:
>=20
> On Wed, Feb 10, 2021 at 10:58:37PM +0000, Chuck Lever wrote:
>>> Not in the short term due to bug load and other obligations.
>>>=20
>>> The original series had "mm, page_allocator: Only use per-cpu allocator
>>> for irq-safe requests" but that was ultimately rejected because softirq=
s
>>> were affected so it would have to be done without that patch.
>>>=20
>>> The last patch can be rebased easily enough but it only batch allocates
>>> order-0 pages. It's also only build tested and could be completely
>>> miserable in practice and as I didn't even try boot test let, let alone
>>> actually test it, it could be a giant pile of crap. To make high orders
>>> work, it would need significant reworking but if the API showed even
>>> partial benefit, it might motiviate someone to reimplement the bulk
>>> interfaces to perform better.
>>>=20
>>> Rebased diff, build tested only, might not even work
>>=20
>> Thanks, Mel, for kicking off a forward port.
>>=20
>> It compiles. I've added a patch to replace the page allocation loop
>> in svc_alloc_arg() with a call to alloc_pages_bulk().
>>=20
>> The server system deadlocks pretty quickly with any NFS traffic. Based
>> on some initial debugging, it appears that a pcplist is getting corrupte=
d
>> and this causes the list_del() in __rmqueue_pcplist() to fail during a
>> a call to alloc_pages_bulk().
>>=20
>=20
> Parameters to __rmqueue_pcplist are garbage as the parameter order change=
d.
> I'm surprised it didn't blow up in a spectacular fashion. Again, this
> hasn't been near any testing and passing a list with high orders to
> free_pages_bulk() will corrupt lists too. Mostly it's a curiousity to see
> if there is justification for reworking the allocator to fundamentally
> deal in batches and then feed batches to pcp lists and the bulk allocator
> while leaving the normal GFP API as single page "batches". While that
> would be ideal, it's relatively high risk for regressions. There is still
> some scope for adding a basic bulk allocator before considering a major
> refactoring effort.
>=20
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index f8353ea7b977..8f3fe7de2cf7 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -5892,7 +5892,7 @@ __alloc_pages_bulk_nodemask(gfp_t gfp_mask, unsigne=
d int order,
> 	pcp_list =3D &pcp->lists[migratetype];
>=20
> 	while (nr_pages) {
> -		page =3D __rmqueue_pcplist(zone, gfp_mask, migratetype,
> +		page =3D __rmqueue_pcplist(zone, migratetype, alloc_flags,
> 								pcp, pcp_list);
> 		if (!page)
> 			break;

The NFS server is considerably more stable now. Thank you!

I confirmed that my patch is requesting and getting multiple pages.
The new NFSD code and the API seem to be working as expected.

The results are stunning. Each svc_alloc_arg() call here allocates
65 pages to satisfy a 256KB NFS READ request.

Before:

            nfsd-972   [000]   584.513817: funcgraph_entry:      + 35.385 u=
s  |  svc_alloc_arg();
            nfsd-979   [002]   584.513870: funcgraph_entry:      + 29.051 u=
s  |  svc_alloc_arg();
            nfsd-980   [001]   584.513951: funcgraph_entry:      + 29.178 u=
s  |  svc_alloc_arg();
            nfsd-983   [000]   584.514014: funcgraph_entry:      + 29.211 u=
s  |  svc_alloc_arg();
            nfsd-976   [002]   584.514059: funcgraph_entry:      + 29.315 u=
s  |  svc_alloc_arg();
            nfsd-974   [001]   584.514127: funcgraph_entry:      + 29.237 u=
s  |  svc_alloc_arg();

After:

            nfsd-977   [002]    87.049425: funcgraph_entry:        4.293 us=
   |  svc_alloc_arg();
            nfsd-981   [000]    87.049478: funcgraph_entry:        4.059 us=
   |  svc_alloc_arg();
            nfsd-988   [001]    87.049549: funcgraph_entry:        4.474 us=
   |  svc_alloc_arg();
            nfsd-983   [003]    87.049612: funcgraph_entry:        3.819 us=
   |  svc_alloc_arg();
            nfsd-976   [000]    87.049619: funcgraph_entry:        3.869 us=
   |  svc_alloc_arg();
            nfsd-980   [002]    87.049738: funcgraph_entry:        4.124 us=
   |  svc_alloc_arg();
            nfsd-975   [000]    87.049769: funcgraph_entry:        3.734 us=
   |  svc_alloc_arg();


There appears to be little cost change for single-page allocations
using the bulk allocator (nr_pages=3D1):

Before:

            nfsd-985   [003]   572.324517: funcgraph_entry:        0.332 us=
   |  svc_alloc_arg();
            nfsd-986   [001]   572.324531: funcgraph_entry:        0.311 us=
   |  svc_alloc_arg();
            nfsd-985   [003]   572.324701: funcgraph_entry:        0.311 us=
   |  svc_alloc_arg();
            nfsd-986   [001]   572.324727: funcgraph_entry:        0.424 us=
   |  svc_alloc_arg();
            nfsd-985   [003]   572.324760: funcgraph_entry:        0.332 us=
   |  svc_alloc_arg();
            nfsd-986   [001]   572.324786: funcgraph_entry:        0.390 us=
   |  svc_alloc_arg();

After:

            nfsd-989   [002]    75.043226: funcgraph_entry:        0.322 us=
   |  svc_alloc_arg();
            nfsd-988   [001]    75.043436: funcgraph_entry:        0.368 us=
   |  svc_alloc_arg();
            nfsd-989   [002]    75.043464: funcgraph_entry:        0.424 us=
   |  svc_alloc_arg();
            nfsd-988   [001]    75.043490: funcgraph_entry:        0.317 us=
   |  svc_alloc_arg();
            nfsd-989   [002]    75.043517: funcgraph_entry:        0.425 us=
   |  svc_alloc_arg();
            nfsd-988   [001]    75.050025: funcgraph_entry:        0.407 us=
   |  svc_alloc_arg();


--
Chuck Lever



