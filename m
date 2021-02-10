Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 618833173D6
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Feb 2021 00:00:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232500AbhBJW7n (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 10 Feb 2021 17:59:43 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:35122 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231897AbhBJW7l (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 10 Feb 2021 17:59:41 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11AMweGV152701;
        Wed, 10 Feb 2021 22:58:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=YVpSiKOT4tpvaBhNIUEus3s/fAuCfrXqkqDVXS3bPQw=;
 b=j/Jeym25SMtkkwT+5z8vi+SxRMAk7uhH2tFoGZKqb3MlNFI3K2mF5AZm1cyEe0fjXYpQ
 xAB4dGCQt4KkZ71IimhBNaCGK6JnhtHpUKPLJH+QAt/a6A+CHnMbfEG0BikbG8EjLppP
 JhdA/8VRvYIDawgDjhGh9tkfwjl+1yCUX7rFdsJOosTf0BmAEHcox/Ox3raMJOITaNEP
 0sKIoLO6S+F1OtqvpnNpuIhASCkATFojFQoI42MjZwkvpY5bXWpQWHzyl5GIP0kcixSI
 HpOP8d2yivcy/SkeIHJwZJz59fJD+k4wW0F8zr0uFvl3G5o+Podh4jkYyNfmb9E55U5w iw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 36hjhqwdwt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 Feb 2021 22:58:40 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11AMt5Mb006941;
        Wed, 10 Feb 2021 22:58:40 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2177.outbound.protection.outlook.com [104.47.58.177])
        by userp3030.oracle.com with ESMTP id 36j51y6x4r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 Feb 2021 22:58:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=URVacB3DN7+i2Ftex5Dqcx5ydGwMXL3YN3ODiWl2q+nCU7XHkqzBGqE2wDb04XAvIAnyr4rLpmiOXwhE04jbWeRZOEkW7IyeRhF8gyIvaMFq067wXYx7cQNp5W3dhH+6R6PlhL3cKbq06TH1OSufhJM1B4g2tMDiJ9rcYhSjpdO/IOkQSQwLdSqWJ8zUeNCVc+OlLuSzavpNP7zA4NAScC4HQYpJKk2RmyQ06gP9l8HDVOjCtKOWOQW4XkfnziwNWwKJinuJ1O5gfW+hSlYgwOWmjepgWvya7i5h8V9EpVWpDoPIrcQQfp5qjtkgp0JGE7HHniMvjiJzGe5W7v0TXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YVpSiKOT4tpvaBhNIUEus3s/fAuCfrXqkqDVXS3bPQw=;
 b=h8wK4WciwExDlffbsStOy+rKabS/pmQw2ljLNo31ajhvuOQm8IjFIh47Dw1M5TwAHZIieh6xdtLZS2qUrDRs9ycXScq85r4DVVIksZmlkmbqOaYVl/xvQ+KI4ps6XJya/TXgKHBFY/mcqgVGUBPMP+agXwjQhR/+Guwi5pOVwuN2cjwmDozCK9tfU/iD7x7uodDzqboMVW4uPUb1eG84DOwnZ5WkxhvpzOrNzlR4Cjhq0lyePitla10cncN3SgkmFqPuP4uczCZ5c4mGrGXlP/CfxVXN42ucsHfyD2HC1aLh3NzFvc7Y2pL3F4WE6MrRnSuGpsFPCOG5c3SfxzKKNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YVpSiKOT4tpvaBhNIUEus3s/fAuCfrXqkqDVXS3bPQw=;
 b=Pwip35YqNc9ZhMD002lJg8X80+ewGG4BIPDcun5ZWkeZbzynTB3gXPYk2F2s4mrhTqx8ajLodNnj+fr6eeI24+CzALxrelX8VyHRVKPOhaSrivOmcXlr/ynrc42ztze4/5gHkC/Sq0r3P2Z8+kyoJhoCRZfm6bkbcLrFrVvyvbY=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BY5PR10MB4130.namprd10.prod.outlook.com (2603:10b6:a03:201::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.26; Wed, 10 Feb
 2021 22:58:37 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::6da8:6d28:b83:702b]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::6da8:6d28:b83:702b%4]) with mapi id 15.20.3846.026; Wed, 10 Feb 2021
 22:58:37 +0000
From:   Chuck Lever <chuck.lever@oracle.com>
To:     Mel Gorman <mgorman@suse.de>
CC:     Jesper Dangaard Brouer <brouer@redhat.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Jakub Kicinski <kuba@kernel.org>
Subject: Re: alloc_pages_bulk()
Thread-Topic: alloc_pages_bulk()
Thread-Index: AQHW/jD1lENfvnr+s0+/RnBes7PyXKpPoPgAgAFz0YCAADINgIAAGAqAgAClRAA=
Date:   Wed, 10 Feb 2021 22:58:37 +0000
Message-ID: <B123FB11-661F-45A6-8235-2982BF3C4B83@oracle.com>
References: <2A0C36E7-8CB0-486F-A8DB-463CA28C5C5D@oracle.com>
 <EEB0B974-6E63-41A0-9C01-F0DEA39FC4BF@oracle.com>
 <20210209113108.1ca16cfa@carbon> <20210210084155.GA3697@techsingularity.net>
 <20210210124103.56ed1e95@carbon> <20210210130705.GC3629@suse.de>
In-Reply-To: <20210210130705.GC3629@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.de; dkim=none (message not signed)
 header.d=none;suse.de; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [68.61.232.219]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 090608f5-714d-4407-2216-08d8ce1766de
x-ms-traffictypediagnostic: BY5PR10MB4130:
x-microsoft-antispam-prvs: <BY5PR10MB41306D5D41F6C9DCF790DD75938D9@BY5PR10MB4130.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MS4qS6Sm/4g92nhsg/I7EMpvFM/uhH09sfLYz3z7o1TTEXeNSaeXP1avg25bljzpEQPKM9TUC9har6eGWP6Ubbn5ibrveECB/sSKHGTJpzmtivi+SD7wHfSvmT05kjFU0JldltmUW/UaoKwlJbgb/Zc//sa24o+HwvI+9lR4BmU0Ck6yQC7JUfm5qXV9xqz/4FyN5tXeAnWMCJU6gcshI1FE/rx+hL3DHEsg0sQhrqm6cfXlc+jJeSLlx2WAGeCzHDHryr7PNExX3E51WdEVoTEFq0knNuEiPsO1/lQ7BOWT6wnxGS18RIE7AjVyIdiyrUXCYVqGXqVjFAH6kESE32M7PYI/xTPPJ01eysR/ubiiThI6jLE7rtjr8Y6ya72toJMsIB3+wzeauE5S6qq8KNaPRTPo5VQsKDfFYyT03U7mu94asiviXz11LtePGSSy3CyxnUcJSRfOemaaNNCD1nQwD9OYcdlpFjTdbfIWjwgM5ytb6VxFwZu4iA9EETw4wfZxYOgQijgLJ2x5PqMRjdGchh1QIbBpNGO5ZiHSAcAlr5AX5jIX8nJcODXW51aZiRiG890e4sVCb0rssLhZqUbvp8uS67M1ZcyAgCNwao2ppuper2vS8D6/KEJiG+WlJTbffQZRn7eRvG8SpVjuj308ngVhIa4aQEGzJHWYB2M=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(396003)(376002)(366004)(136003)(346002)(86362001)(36756003)(76116006)(478600001)(66476007)(66556008)(64756008)(66946007)(66446008)(83380400001)(2616005)(53546011)(6506007)(8936002)(186003)(8676002)(44832011)(26005)(7116003)(71200400001)(6512007)(316002)(2906002)(6916009)(5660300002)(4326008)(91956017)(33656002)(966005)(54906003)(6486002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?G+wnq4HAx2WPRzYbPogfgwuYdeaxCtooeOOZZqM0ahuSAq+Kvx+iPEaohNc2?=
 =?us-ascii?Q?OyIMO7Zbnpw6gP/jqyw44gC6zrSXQLv370gmRon8utMVy02aZ/+E8ceXXP/r?=
 =?us-ascii?Q?fewwJ1QtrUrIJ2lxdjsRy0NamgdAfJR0SmhVoK3nUC45rJT7jUqPbxkFORf9?=
 =?us-ascii?Q?MAwDfHiLt3zo3uxHQ9E8GY/ELBNi2afE88wS6z01RboIaOZImANBCRKLdxS0?=
 =?us-ascii?Q?X9b6y7GAxpRpPGfjS6Bg/f69L51DS4SCtZUyIlvEX85hs7jjsZHjAYRw4Tpa?=
 =?us-ascii?Q?+WK3guWadfTKqvX1MxIYJy9Q+zXS4wUQwOGGJbQTAmGu5pOjYrfahaIZuwE6?=
 =?us-ascii?Q?ObSxvZfQZZigG5wY9I6+v6jN5mEFCJMLiqtvKsuVUaKLf8eAQ/jqEj79PYCA?=
 =?us-ascii?Q?tM9rZDXzSrov4+fC4lsC2uB2FxZkJYu1BKqNFEBBHKB1o9KqqF2Kj4mUHMtV?=
 =?us-ascii?Q?fGHHMznIhDdWu+46HLybsdfWOHsowIIoUANzGS8WE7CljV7jMquugaQ2VY25?=
 =?us-ascii?Q?DwXT4eiDbUlNt6NXPjGKrfoPx4EtsghjbXfxcNhlfZIXiQnkDA+APhBCvPk+?=
 =?us-ascii?Q?6F3PUsi8Bont/Tn9GzmkwU1C6UyX6nOITqMkBBm4UGtf4A51e6ciSie/fvp4?=
 =?us-ascii?Q?scNBqENad3zdybZsI8PZhocZGJhI4IO+4yQ2ZgrKOHJJL2LogJzhml/hhgXK?=
 =?us-ascii?Q?Fitxo0spVs7lgX90OAYZ2by10bgcwoftETj1GyYWxtB6fqJOcDLy/dJqY8AN?=
 =?us-ascii?Q?DTuQQD6y1oxTJROvzUgf9WAhSCXtM50CsOROOoB5ecWf++Qoj7LY8b34siLr?=
 =?us-ascii?Q?ezGxdLtz0vCJqzr/lD7Os+AtUCdhg9Bl6J+wWYWYXULyawumnh8aGihi2t26?=
 =?us-ascii?Q?XFNUbVeJl7IDU6OSJLKVrqPGsWziLp5lJuZkK1cgpGNopta3pn8fBW4SOxQ7?=
 =?us-ascii?Q?6JyqXo+n3O1QjxSpQ0e6ozKR5Ji5ZZ6eaYGac5uqrqbDSuAKGYIFx1jTFb9P?=
 =?us-ascii?Q?ED4VwPd7JLZa354MliEEFVUQOxVlUm1lGI54RADwTXa/CfI97Z2V9VYBqnKB?=
 =?us-ascii?Q?cfzVmdrxhlcsmGnJGVowy8svHHOa+jTLts5NNX9YSD6Sw4q0IwIyS+DkKFZJ?=
 =?us-ascii?Q?rZroThpGf4E64kLKBSabVoPPwTWzdYOqVXxiMTZMzsUm3eqL4WGXdsecU7fl?=
 =?us-ascii?Q?ela5cTquNhiuEgNfCRgNm1VMFMQaQ5S+7qock8tSYOQRg8kPBc89Z0bWhIb/?=
 =?us-ascii?Q?//6FPpL3a0SqyZU4D0hX/p5X0Wy2LCuHujs/ZuUmf7+7oFtuhwddLuWJpRNQ?=
 =?us-ascii?Q?aIplDGzPKmWa7l5hSjpg+ypc?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <BECCC59B05D2EE4C9804E37C1C0683E2@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 090608f5-714d-4407-2216-08d8ce1766de
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2021 22:58:37.7024
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EC8Bkb/MOfCvhPgS8l201+esD7MSRub+uf3xEvChc9LBeXJmowUAhAV/MLzrvNKwsYcZJjjtPmgU+1ZpSEm/tw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4130
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9891 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 phishscore=0
 mlxscore=0 malwarescore=0 mlxlogscore=999 bulkscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102100199
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9891 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 impostorscore=0
 priorityscore=1501 bulkscore=0 suspectscore=0 mlxscore=0 phishscore=0
 lowpriorityscore=0 mlxlogscore=999 clxscore=1015 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102100200
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Feb 10, 2021, at 8:07 AM, Mel Gorman <mgorman@suse.de> wrote:
>=20
> On Wed, Feb 10, 2021 at 12:41:03PM +0100, Jesper Dangaard Brouer wrote:
>> On Wed, 10 Feb 2021 08:41:55 +0000
>> Mel Gorman <mgorman@techsingularity.net> wrote:
>>=20
>>> On Tue, Feb 09, 2021 at 11:31:08AM +0100, Jesper Dangaard Brouer wrote:
>>>>>> Neil Brown pointed me to this old thread:
>>>>>>=20
>>>>>> https://lore.kernel.org/lkml/20170109163518.6001-1-mgorman@techsingu=
larity.net/
>>>>>>=20
>>>>>> We see that many of the prerequisites are in v5.11-rc, but
>>>>>> alloc_page_bulk() is not. I tried forward-porting 4/4 in that
>>>>>> series, but enough internal APIs have changed since 2017 that
>>>>>> the patch does not come close to applying and compiling. =20
>>>>=20
>>>> I forgot that this was never merged.  It is sad as Mel showed huge
>>>> improvement with his work.
>>>>=20
>>>>>> I'm wondering:
>>>>>>=20
>>>>>> a) is there a newer version of that work?
>>>>>>=20
>>>>=20
>>>> Mel, why was this work never merged upstream?
>>>>=20
>>>=20
>>> Lack of realistic consumers to drive it forward, finalise the API and
>>> confirm it was working as expected. It eventually died as a result. If =
it
>>> was reintroduced, it would need to be forward ported and then implement
>>> at least one user on top.
>>=20
>> I guess I misunderstood you back in 2017. I though that I had presented
>> a clear use-case/consumer in page_pool[1].=20
>=20
> You did but it was never integrated and/or tested AFAIK. I see page_pool
> accepts orders so even by the original prototype, it would only have seen
> a benefit for order-0 pages. It would also have needed some supporting
> data that it actually helped with drivers using the page_pool interface
> which I was not in the position to properly test at the time.
>=20
>> But you wanted the code as
>> part of the patchset I guess.  I though, I could add it later via the
>> net-next tree.
>>=20
>=20
> Yes, a consumer of the code should go in at the same time with supporting
> data showing it actually helps because otherwise it's dead code.
>=20
>> It seems that Chuck now have a NFS use-case, and Hellwig also have a
>> use-case for DMA-iommu in __iommu_dma_alloc_pages.
>>=20
>> The performance improvement (in above link) were really impressive!
>>=20
>> Quote:
>> "It's roughly a 50-70% reduction of allocation costs and roughly a halvi=
ng of the
>> overall cost of allocating/freeing batches of pages."
>>=20
>> Who have time to revive this patchset?
>>=20
>=20
> Not in the short term due to bug load and other obligations.
>=20
> The original series had "mm, page_allocator: Only use per-cpu allocator
> for irq-safe requests" but that was ultimately rejected because softirqs
> were affected so it would have to be done without that patch.
>=20
> The last patch can be rebased easily enough but it only batch allocates
> order-0 pages. It's also only build tested and could be completely
> miserable in practice and as I didn't even try boot test let, let alone
> actually test it, it could be a giant pile of crap. To make high orders
> work, it would need significant reworking but if the API showed even
> partial benefit, it might motiviate someone to reimplement the bulk
> interfaces to perform better.
>=20
> Rebased diff, build tested only, might not even work

Thanks, Mel, for kicking off a forward port.

It compiles. I've added a patch to replace the page allocation loop
in svc_alloc_arg() with a call to alloc_pages_bulk().

The server system deadlocks pretty quickly with any NFS traffic. Based
on some initial debugging, it appears that a pcplist is getting corrupted
and this causes the list_del() in __rmqueue_pcplist() to fail during a
a call to alloc_pages_bulk().


> diff --git a/include/linux/gfp.h b/include/linux/gfp.h
> index 6e479e9c48ce..d1b586e5b4b8 100644
> --- a/include/linux/gfp.h
> +++ b/include/linux/gfp.h
> @@ -511,6 +511,29 @@ __alloc_pages(gfp_t gfp_mask, unsigned int order, in=
t preferred_nid)
> 	return __alloc_pages_nodemask(gfp_mask, order, preferred_nid, NULL);
> }
>=20
> +unsigned long
> +__alloc_pages_bulk_nodemask(gfp_t gfp_mask, unsigned int order,
> +			struct zonelist *zonelist, nodemask_t *nodemask,
> +			unsigned long nr_pages, struct list_head *alloc_list);
> +
> +static inline unsigned long
> +__alloc_pages_bulk(gfp_t gfp_mask, unsigned int order,
> +		struct zonelist *zonelist, unsigned long nr_pages,
> +		struct list_head *list)
> +{
> +	return __alloc_pages_bulk_nodemask(gfp_mask, order, zonelist, NULL,
> +						nr_pages, list);
> +}
> +
> +static inline unsigned long
> +alloc_pages_bulk(gfp_t gfp_mask, unsigned int order,
> +		unsigned long nr_pages, struct list_head *list)
> +{
> +	int nid =3D numa_mem_id();
> +	return __alloc_pages_bulk(gfp_mask, order,
> +			node_zonelist(nid, gfp_mask), nr_pages, list);
> +}
> +
> /*
>  * Allocate pages, preferring the node given as nid. The node must be val=
id and
>  * online. For more general interface, see alloc_pages_node().
> @@ -580,6 +603,7 @@ void * __meminit alloc_pages_exact_nid(int nid, size_=
t size, gfp_t gfp_mask);
>=20
> extern void __free_pages(struct page *page, unsigned int order);
> extern void free_pages(unsigned long addr, unsigned int order);
> +extern void free_pages_bulk(struct list_head *list);
>=20
> struct page_frag_cache;
> extern void __page_frag_cache_drain(struct page *page, unsigned int count=
);
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 519a60d5b6f7..f8353ea7b977 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -3254,7 +3254,7 @@ void free_unref_page(struct page *page)
> }
>=20
> /*
> - * Free a list of 0-order pages
> + * Free a list of 0-order pages whose reference count is already zero.
>  */
> void free_unref_page_list(struct list_head *list)
> {
> @@ -4435,6 +4435,21 @@ static void wake_all_kswapds(unsigned int order, g=
fp_t gfp_mask,
> 	}
> }
>=20
> +/* Drop reference counts and free pages from a list */
> +void free_pages_bulk(struct list_head *list)
> +{
> +	struct page *page, *next;
> +
> +	list_for_each_entry_safe(page, next, list, lru) {
> +		trace_mm_page_free_batched(page);
> +		if (put_page_testzero(page)) {
> +			list_del(&page->lru);
> +			__free_pages_ok(page, 0, FPI_NONE);
> +		}
> +	}
> +}
> +EXPORT_SYMBOL_GPL(free_pages_bulk);
> +
> static inline unsigned int
> gfp_to_alloc_flags(gfp_t gfp_mask)
> {
> @@ -5818,6 +5833,99 @@ static int find_next_best_node(int node, nodemask_=
t *used_node_mask)
> }
>=20
>=20
> +/*
> + * This is a batched version of the page allocator that attempts to
> + * allocate nr_pages quickly from the preferred zone and add them to lis=
t.
> + * Note that there is no guarantee that nr_pages will be allocated altho=
ugh
> + * every effort will be made to allocate at least one. Unlike the core
> + * allocator, no special effort is made to recover from transient
> + * failures caused by changes in cpusets. It should only be used from !I=
RQ
> + * context. An attempt to allocate a batch of patches from an interrupt
> + * will allocate a single page.
> + */
> +unsigned long
> +__alloc_pages_bulk_nodemask(gfp_t gfp_mask, unsigned int order,
> +			struct zonelist *zonelist, nodemask_t *nodemask,
> +			unsigned long nr_pages, struct list_head *alloc_list)
> +{
> +	struct page *page;
> +	unsigned long alloced =3D 0;
> +	unsigned int alloc_flags =3D ALLOC_WMARK_LOW;
> +	unsigned long flags;
> +	struct zone *zone;
> +	struct per_cpu_pages *pcp;
> +	struct list_head *pcp_list;
> +	int migratetype;
> +	gfp_t alloc_mask =3D gfp_mask; /* The gfp_t that was actually used for =
allocation */
> +	struct alloc_context ac =3D { };
> +
> +	/* If there are already pages on the list, don't bother */
> +	if (!list_empty(alloc_list))
> +		return 0;
> +
> +	/* Order-0 cannot go through per-cpu lists */
> +	if (order)
> +		goto failed;
> +
> +	gfp_mask &=3D gfp_allowed_mask;
> +
> +	if (!prepare_alloc_pages(gfp_mask, order, numa_mem_id(), nodemask, &ac,=
 &alloc_mask, &alloc_flags))
> +		return 0;
> +
> +	if (!ac.preferred_zoneref)
> +		return 0;
> +
> +	/*
> +	 * Only attempt a batch allocation if watermarks on the preferred zone
> +	 * are safe.
> +	 */
> +	zone =3D ac.preferred_zoneref->zone;
> +	if (!zone_watermark_fast(zone, order, high_wmark_pages(zone) + nr_pages=
,
> +				 zonelist_zone_idx(ac.preferred_zoneref), alloc_flags, gfp_mask))
> +		goto failed;
> +
> +	/* Attempt the batch allocation */
> +	migratetype =3D ac.migratetype;
> +
> +	local_irq_save(flags);
> +	pcp =3D &this_cpu_ptr(zone->pageset)->pcp;
> +	pcp_list =3D &pcp->lists[migratetype];
> +
> +	while (nr_pages) {
> +		page =3D __rmqueue_pcplist(zone, gfp_mask, migratetype,
> +								pcp, pcp_list);
> +		if (!page)
> +			break;
> +
> +		prep_new_page(page, order, gfp_mask, 0);
> +		nr_pages--;
> +		alloced++;
> +		list_add(&page->lru, alloc_list);
> +	}
> +
> +	if (!alloced) {
> +		preempt_enable_no_resched();
> +		goto failed;
> +	}
> +
> +	__count_zid_vm_events(PGALLOC, zone_idx(zone), alloced);
> +	zone_statistics(zone, zone);
> +
> +	local_irq_restore(flags);
> +
> +	return alloced;
> +
> +failed:
> +	page =3D __alloc_pages_nodemask(gfp_mask, order, numa_node_id(), nodema=
sk);
> +	if (page) {
> +		alloced++;
> +		list_add(&page->lru, alloc_list);
> +	}
> +
> +	return alloced;
> +}
> +EXPORT_SYMBOL(__alloc_pages_bulk_nodemask);
> +
> /*
>  * Build zonelists ordered by node and zones within node.
>  * This results in maximum locality--normal zone overflows into local
>=20
> --=20
> Mel Gorman
> SUSE Labs

--
Chuck Lever



