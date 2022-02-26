Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B2034C57E3
	for <lists+linux-nfs@lfdr.de>; Sat, 26 Feb 2022 21:01:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229493AbiBZUBg (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 26 Feb 2022 15:01:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiBZUBf (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 26 Feb 2022 15:01:35 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1652B1FEDA4
        for <linux-nfs@vger.kernel.org>; Sat, 26 Feb 2022 12:00:57 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21QHX4cP021527;
        Sat, 26 Feb 2022 20:00:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=Je7NQEaY0EFu70OKHjiL+yctjECo/q4T8WQYMzJr7ew=;
 b=RyA2wkeNj5WO2Yvp50WlRPKFYxQthDs2xeHOsqqSv79Vo4cYCcy6ZQMGyaAuUE9Ko3kM
 fBiPfwwGFcrM9Xwr0AqpC1f2ft3q27AQHP9N4SfjuHorRszcz1jaz6/Iumyvz9Sasksh
 PvVT0jJJVzJpTIV3eohvA+2/RXd/SoOTozEt+iMqneC7n67j3qYDhcTEbgw6nR4Zu1f3
 Gynfs5hsSvcCztJhhQoj/BgyJVVaxXiVubbxg23pR1bcxZqaEHDiVIq7dLLi11kLaRaj
 qnEPWMbm+CKwqrx17OWOQGEDbn/dQUeWDYE4X0YQ+nCvPJKZNuHBpG5ym0faoj0Iv9RW 7A== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3efat1s8h5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 26 Feb 2022 20:00:46 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21QJtWrQ045421;
        Sat, 26 Feb 2022 20:00:45 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
        by userp3020.oracle.com with ESMTP id 3efdngvuw2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 26 Feb 2022 20:00:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K0b4nkvD0/UxsQIwuMYlB+PRebXzQUQwvQmVUSgDL2irs+CnBxxKCSDZL+YCyU2K8cdK8voETY6QbIRHTVUZuf7tWtjs81EKKdTo8B7GXI0hFDBjVfcMxD1IL2qAOxWOyHM76rsK7QXOMFHARidlfwL3LrpQS0mrqEdsYHze5qM8Burt1whdbk4i7O46Q7iIZvVwt2sT/X8/7JG1alJHp8Kyaloh77TkrrLgSDSRX8WkINwyVAxGKD8XNrKJ/kgY4uIP91t31PD8Ov9YvqRcOzXgaOaUZg/ZWzqUhK/N0stNU8bfToNbiwBwU7T7jg5YjXPWC2FZ/Faqwj66aJqSfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Je7NQEaY0EFu70OKHjiL+yctjECo/q4T8WQYMzJr7ew=;
 b=bXVCqj1XqFuuTHWgIA+DkUvP9WZwRNjWGBzbaagg4Dlu3PNeGp96/EX23U1eMZ8YuPV1y+Y292jra3UB48Ti2mGv2wafzE0sUnrS27j7Eb09icr3y5yVJbBIm+v8pPKC1fXSkr680M6NUTCewC7bxcnJGWH2uQfzQwRMh1L+XORkIHla8twBFquRknE16Cy95Patqsbw7xzMmGrzRk6uLUEf1koig7a98WcrpY5JoHdEJCcaYt3eWhADtGeuNuyKvAVJCn2uyorLFP0mhwwXFY2iNP4X8M1nKfwobr5haWS+lgCqkBIdr58VJcHkxnd7PqdSbXIcEQlmjBnr44aizg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Je7NQEaY0EFu70OKHjiL+yctjECo/q4T8WQYMzJr7ew=;
 b=cgNHYuXef7uLHJL3kKsNmFWMhhi3gHeKHV1Vllsr75ObOm/hWv2nmakjBzYsbwCjNluHJUf8bmPEGsjozSi0WbPFsFNv2/oN4F6ZS9IRkVCRkfWbGTEdod1vbWRj5cRy6Xe0xhPWNvXN1qYyC6kSZTOMOig+pgVtkJ3qDR/PZsc=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SN6PR10MB2509.namprd10.prod.outlook.com (2603:10b6:805:4c::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.25; Sat, 26 Feb
 2022 20:00:43 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::29c0:c62f:cba3:510e]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::29c0:c62f:cba3:510e%9]) with mapi id 15.20.5017.026; Sat, 26 Feb 2022
 20:00:43 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Amir Goldstein <amir73il@gmail.com>
CC:     Jeff Layton <jlayton@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v2] nfsd: more robust allocation failure handling in
 nfsd_file_cache_init
Thread-Topic: [PATCH v2] nfsd: more robust allocation failure handling in
 nfsd_file_cache_init
Thread-Index: AQHYKZoEe5El1hMKYEiEq+uh3pv5TKyjI9OAgAAW+wCAAvG6AIAAF1QA
Date:   Sat, 26 Feb 2022 20:00:43 +0000
Message-ID: <FDA50FCC-FBC9-4B5E-89E3-804C8FD32763@oracle.com>
References: <20220224161705.1041788-1-amir73il@gmail.com>
 <BB7DEB92-1E3D-4BF5-A723-650C2B95877D@oracle.com>
 <CAOQ4uxgUEn0MpBYH8YU3paeJ5r0n545FuWmzb_yLEyoa1VkVtw@mail.gmail.com>
 <CAOQ4uxiPYpVcL2_YpRFU58kfjPFvTY+Hwz6Z1FNvFGDaupv-cA@mail.gmail.com>
In-Reply-To: <CAOQ4uxiPYpVcL2_YpRFU58kfjPFvTY+Hwz6Z1FNvFGDaupv-cA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ff5d65c9-4a62-4780-522e-08d9f962abd9
x-ms-traffictypediagnostic: SN6PR10MB2509:EE_
x-microsoft-antispam-prvs: <SN6PR10MB25094A85D1F8C39C112CB763933F9@SN6PR10MB2509.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7YeTAoyHdXoTwe+MxJZXArj8ESGLdXakVdMJ5UCezZUmBiBvQtGjSM1f2CclCnL8XK46wrCuQtoZRUFTwAwi7yxy1GeCBCtMpSb4Y+oGThccWI6u4YOcivd32h9ebgT6bFnEnDCugRnB0RmIDmas3fxiOocOC5MZ+jB0cTjb5+QZGVQWRR0uINa9IGQKDKUNoKSAdrVsba/As1q6SqO1c0mbq+hbYtKbCrOKlwdHMWrrrKHcEk4z01QYVIgQ59KlbaM9J4/FekAxBJ0MPnkN1hQO0cCrgmKbBPdVliU+vQVAg7mexJiZ+NI/FCgxcoymbUo5ChbArSnYlfStX3/nfMYc5522yjcUsEC+Hx3plaFVwA6AiAsoYFUZTv3Jr5APbEfwv0SUEkd/u6uaJo3LGRxhnKoutUUvprJc54BFsr1U4SZnKhQgCIe58IQExv0SLmQl3/ug5k1l3srybVw+5jEBN6Qp65yXJDqYUd59FLffrEgYeM8wqeNPgrWWXhMGqHD5MVIMtsckPBW5DsjeLu6YdbHvxbDnWPfJrACthhZz5LNK2OuRJnuq1idMU4xHA+Pwey4mSxhMuJELfsA9qL5XtU5IzmnL0ewVMK8TTi4gTULCdirlUbMvslUvEEud1pcPcDfoKq2wF7lX7Y73wHsPRDjqtztS2JPnga6tBYLMK8yZj8BRPeYHK6Y2NLNKem+NhqAfxFHQnFe8dWpagsUq1dXEQRLkNvz3PbJOHzYMhNYJMl6Wgf16yXHt5CJ7pzoaS9FFOgNBOZ0or9Iq0PA4XFF29lBtokAIN9UInTkAZUKy6qA9uh0Vv+Y7/1kSmr9tT5pdwy1BtJDOKMImMQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66446008)(66556008)(8676002)(76116006)(36756003)(33656002)(83380400001)(8936002)(508600001)(4326008)(66476007)(64756008)(66946007)(6486002)(966005)(91956017)(5660300002)(86362001)(2906002)(6916009)(54906003)(316002)(26005)(38070700005)(71200400001)(53546011)(122000001)(38100700002)(2616005)(6506007)(186003)(6512007)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?OUcKIntCalC8BBodfUQOftoOvEY5QTfSNtea6YIQjYUpFwdAAMHy8ZnXFPSq?=
 =?us-ascii?Q?jMd7hbu9Ws5su97bx8yUf48mOq1HouIVfbF4At8pyXFH8cEmXSlhxlDJCYxj?=
 =?us-ascii?Q?6Msj1VPekH+Nod7EtCBG0LBDmLWKaqSjjfHhd0oaJZFqElJi58MZsowlLYuX?=
 =?us-ascii?Q?eIxGrq1I8Tr5aXwBNFEvpDRcw9NUzSglq6qiPRM/qJJRPrFXvuS4isT8ce8S?=
 =?us-ascii?Q?9O6eg1kGvFkgRXLu0/wxS6z2uArV+D/uu7u8PvkJGlgfGHixGYUWdCbN9sbh?=
 =?us-ascii?Q?fcICQLEJOFyhtmIzWP6sVxB05/rRukUVHrPK078OytfmW0Ha4Oul/+9sGdlv?=
 =?us-ascii?Q?UuqWDInXuGwxiR7DqJhp6r7Izcq6KfZGxW6YnigHaAXKRp4UF0NGVHsHKnbT?=
 =?us-ascii?Q?5ODULr1DMeeHZ/bwfhIpOfnSZTjICaKJWgjY10ZnWaepM5ka8AYkG5MIokc7?=
 =?us-ascii?Q?fTnnIqLejIUyJrRrLYhxKPZgNWHh+DZIdNUPW7TT0EAkm8hGmjUVezzuBoNE?=
 =?us-ascii?Q?eN7VIpU1WNiw4xPnxUgBqM3vHF/Dm+fh6MqLx3q+H3TUWmVdTMbx9eTDvCV1?=
 =?us-ascii?Q?nSY1U1bZxyImqHvOBg/+pEpsyKDNXu8+HNwiA+oICquQ5INelius5cF2eLZE?=
 =?us-ascii?Q?9fh/8qm1vOm46da3yhWy5LG52XO1GkiFYug+KFUwoLVyAwCcE5n1EONJzqR7?=
 =?us-ascii?Q?2yDn3rSrqtDgB0CU+AK7QbK+rOx5gf60GsP1n3hPusLwz8AmVHXxxXRzORUI?=
 =?us-ascii?Q?2RGssUbgbB+RQz/gPcrLLtTku87fKnoFjLDDMQ079h/UhAnWSt/JqNs/MvWP?=
 =?us-ascii?Q?IeE7rFBb66yS+rWVv6qlVDIta6/mhPkmZXz9vU1DfO8LAle7EnJvKWAa9WOg?=
 =?us-ascii?Q?BQyObOBrERt9iAroCur+PLX/UL4sGVunF+hn/x/rbrnValreoDfnO5WDuBKp?=
 =?us-ascii?Q?gkL/9MyzjWpXNXCgkriwXeyU/qs5wgeOWkFOl2s3o2sMR+PxMtmGu4M6siC5?=
 =?us-ascii?Q?FVquZZVx3QTy/NmAmw/pz5XnIsBFJV09pOZtrQnsCkMJdHyqh/w5+i0EwjdH?=
 =?us-ascii?Q?66kJhvsg3OdR+Hdy8LRyUU05DDxNgYPI7+lOlLZ7wNTss2Enir3HoQIoIyZD?=
 =?us-ascii?Q?w22IO2rH/RSUsVVke8LnfrOqvyiD8tQ8alWMfyPnkUyr+5Idlppv8ZcJuK9a?=
 =?us-ascii?Q?HihVkS2wsw2Zi/eHXY9jqsYQ5wvvTGVEEaybKB8l2phYbEEQj3/BF3vnQhNl?=
 =?us-ascii?Q?yN6W16vxy444xCwkKY75SVaKK58Gdz7Sz7QSM5CpjrlIuoNolvJMIvuUZkis?=
 =?us-ascii?Q?20znoyE/3YEm+RVgFlAXqFJWJbpK0gaLdaon8wV6NkiRxM2bX9fkJfwemrdn?=
 =?us-ascii?Q?mtNwpca35ny5iMq3YUjBUj0nA51PhCPRNKDgK+P7Bg+F+ovJp1eQjeW2f6AQ?=
 =?us-ascii?Q?0PeaDO7Kz8O/exewAra4IpP173MGZrfzQB7yT5ohkYGU5GJMF3U79HtwKvbU?=
 =?us-ascii?Q?UCRz+aeOYNp0TpZN7YyvojCfvA2ySnhEwT8/gKOJnmkbNALVbh11pAGZqGH4?=
 =?us-ascii?Q?xpvJigdMgdbkFfPglOFMmpGxwlWCTYFjll0SYv9Sd35u85NRCDKzGx0R0UzD?=
 =?us-ascii?Q?nEMzBzlJy19GCR6YEb8Eam0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <73BEF9F6963995489A1185DB3EE7F4F2@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff5d65c9-4a62-4780-522e-08d9f962abd9
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2022 20:00:43.4580
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: O9Y0nPfHnzybJUh+y3GlbzXcMVfZPPTKNGLSUp1Dj+15D+NEQf5lJ3mPb3BRHV1bv48pTgfRjHkFKo20LdY6HA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB2509
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10270 signatures=684655
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 adultscore=0 phishscore=0 spamscore=0 suspectscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202260142
X-Proofpoint-GUID: 655mxhb_Xcm6oY-CnmbnTsGFNXv3Kag4
X-Proofpoint-ORIG-GUID: 655mxhb_Xcm6oY-CnmbnTsGFNXv3Kag4
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Feb 26, 2022, at 1:37 PM, Amir Goldstein <amir73il@gmail.com> wrote:
>=20
> On Thu, Feb 24, 2022 at 11:39 PM Amir Goldstein <amir73il@gmail.com> wrot=
e:
>>=20
>> On Thu, Feb 24, 2022 at 10:41 PM Chuck Lever III <chuck.lever@oracle.com=
> wrote:
>>>=20
>>> Hi Amir-
>>>=20
>>>> On Feb 24, 2022, at 11:17 AM, Amir Goldstein <amir73il@gmail.com> wrot=
e:
>>>>=20
>>>> The nfsd file cache table can be pretty large and its allocation
>>>> may require as many as 80 contigious pages.
>>>>=20
>>>> Employ the same fix that was employed for similar issue that was
>>>> reported for the reply cache hash table allocation several years ago
>>>> by commit 8f97514b423a ("nfsd: more robust allocation failure handling
>>>> in nfsd_reply_cache_init").
>>>>=20
>>>> Fixes: 65294c1f2c5e ("nfsd: add a new struct file caching facility to =
nfsd")
>>>> Link: https://lore.kernel.org/linux-nfs/e3cdaeec85a6cfec980e87fc294327=
c0381c1778.camel@kernel.org/
>>>> Suggested-by: Jeff Layton <jlayton@kernel.org>
>>>> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
>>>> ---
>>>>=20
>>>> Since v1:
>>>> - Use kvcalloc()
>>>> - Use kvfree()
>>>>=20
>>>> fs/nfsd/filecache.c | 6 +++---
>>>> 1 file changed, 3 insertions(+), 3 deletions(-)
>>>=20
>>> v2 passes some simple testing, so I've applied it to NFSD for-next.
>>> It should get 0-day and merge testing and is available for others
>>> to try out.
>>>=20
>>> I don't have anything that exercises low memory scenarios, though.
>>> Do you have anything like this to try?
>>=20
>> Well, it is not low memory really it's fragmented memory.
>> I would try setting:
>>=20
>> CONFIG_FAIL_PAGE_ALLOC=3Dy
>>=20
>> echo 5 > /sys/kernel/debug/fail_page_alloc/min-order
>> echo 100 > /sys/kernel/debug/fail_page_alloc/probability
>>=20
>> and starting (or restarting) nfsd.
>> hoping that other large page allocations won't get in the way.
>>=20
>> I gave it a shot, but couldn't figure out why nfsd4_files slab
>> is still there after stopping nfs-server service, meaning that
>> nfsd_file_cache_shutdown() was not called - I must be missing
>> something. I may play with this some more tomorrow.
>>=20
>=20
> Ok, I was missing some parameters.
> This configuration reproduces and failure and verified that the
> kvcalloc() fix solves the issue:
>=20
> $ systemctl stop nfs-server
> $ echo 5 > /sys/kernel/debug/fail_page_alloc/min-order
> $ echo 100 > /sys/kernel/debug/fail_page_alloc/probability
> $ echo 1 > /sys/kernel/debug/fail_page_alloc/times
> $ echo N > /sys/kernel/debug/fail_page_alloc/ignore-gfp-wait
> $ systemctl start nfs-server
>=20
> [   24.410560] FAULT_INJECTION: forcing a failure.
> [   24.410560] name fail_page_alloc, interval 1, probability 100,
> space 0, times 1
> [   24.413887] CPU: 1 PID: 1218 Comm: rpc.nfsd Not tainted
> 5.17.0-rc2-xfstests #5927
> [   24.415625] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
> BIOS 1.13.0-1ubuntu1.1 04/01/2014
> [   24.417098] Call Trace:
> [   24.417098]  <TASK>
> [   24.417098]  dump_stack_lvl+0x45/0x59
> [   24.418999]  should_fail+0x11a/0x13d
> [   24.418999]  prepare_alloc_pages.isra.0+0x97/0xc5
> [   24.418999]  __alloc_pages+0x76/0x1c7
> [   24.418999]  kmalloc_order+0x35/0xa7
> [   24.418999]  kmalloc_order_trace+0x1b/0xf3
> [   24.418999]  nfsd_file_cache_init+0x5b/0x2d8
> [   24.418999]  nfsd_svc+0xcd/0x2b2
> [   24.427086]  write_threads+0x6d/0xb5
> [   24.427086]  ? get_int+0x70/0x70
> [   24.429020]  nfsctl_transaction_write+0x4f/0x67
> [   24.429020]  vfs_write+0xe3/0x14b
> [   24.429020]  ksys_write+0x7f/0xcb
> [   24.429020]  do_syscall_64+0x6d/0x80
> [   24.429020]  entry_SYSCALL_64_after_hwframe+0x44/0xae
> [   24.429020] RIP: 0033:0x7f29d80d6504
> [   24.429020] Code: 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b3 0f
> 1f 80 00 00 00 00 48 8d 05 f9 61 0d 00 8b 00 85 c0 75 13 b8 01 00 00
> 00 0f 05 <48> 3d 00 f0 ff ff 77 54 c3 0f 1f 00 41 54 49 89 d4 55 48 89
> f5 53
> [   24.439028] RSP: 002b:00007ffe867a47f8 EFLAGS: 00000246 ORIG_RAX:
> 0000000000000001
> [   24.439028] RAX: ffffffffffffffda RBX: 00007f29d8219560 RCX: 00007f29d=
80d6504
> [   24.442325] RDX: 0000000000000002 RSI: 00007f29d8219560 RDI: 000000000=
0000003
> [   24.442325] RBP: 0000000000000003 R08: 0000000000000000 R09: 00007ffe8=
67a4557
> [   24.445644] R10: 0000000000000000 R11: 0000000000000246 R12: 000000000=
0000000
> [   24.445644] R13: 0000000000000008 R14: 0000000000000000 R15: 00007f29d=
83572a0
> [   24.449026]  </TASK>
> [   24.450496] nfsd: unable to allocate nfsd_file_hashtbl
> Job for nfs-server.service canceled.
>=20
> With the fix patch, nfsd starts despite the injected failure.

Thanks. I will add your Tested-by: .


--
Chuck Lever



