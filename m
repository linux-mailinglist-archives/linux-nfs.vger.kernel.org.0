Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73122587F85
	for <lists+linux-nfs@lfdr.de>; Tue,  2 Aug 2022 17:54:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237526AbiHBPyd (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 2 Aug 2022 11:54:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237463AbiHBPyK (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 2 Aug 2022 11:54:10 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF7AC4BD1D
        for <linux-nfs@vger.kernel.org>; Tue,  2 Aug 2022 08:53:08 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 272FEJM8007538;
        Tue, 2 Aug 2022 15:53:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=QC40J8kj1VXjBXIkiniiHywXw8C90L/ImcGnP5IKWCY=;
 b=x9dsZaPJ6ENXV2kIbbRpiPdZSUqeysOrsV7EciI2tfAENbPasS1plNjiDInRU7rJA+ta
 qa8hclfH9SaDVQUiFlg0sBsDOhKDPLIf4FaITHsZFpRqL8R6k/ggYAmBcF2HbNCfeo53
 E3EKe4ahZ5tyQejW54Gqk8vYAoy3iNQ1DmMIfsoAsA4U5j66rjzsjzgVkfAl2MDGuKUN
 1NWf1gZw15/uczb1dkzNt1ooTcYflfb0Z9YqVjKcJEbrpW8n4Uo+ZszUVVQwA53HFsUX
 5oyofHppJims+Ab5P2CU4bW10k4d2tgNdubqYujnQMy9mHZBLQ6WttDQbVkK7nQL/rzd Hg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hmv8s7a00-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 02 Aug 2022 15:53:02 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 272F9Wws014257;
        Tue, 2 Aug 2022 15:53:02 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2047.outbound.protection.outlook.com [104.47.51.47])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3hmu32f74g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 02 Aug 2022 15:53:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WDGRAVqC66ureZKqzd9c3iyUq/fWcuFTv/9kUlODwIeKISN0KJ/PhAdCSdUjvRa6vIQwvF/0ihEGRvRVTYrQ4Qw9bsrE/rdEQJbXJKH5j0q8U9IjRPLO8Vdz33Qs4yfNSof2lIWUiNsFBXKmuQfW3F9BrsDxI3L/lime5r2zNL6QCBLV0lneeLjBqbnfSCaJOyAn7XgA3UvcsO4AHGqYUhB+SJQV/qF0krILziFlQ+a55Gy+eK63ibHYSPdHOQj5WM488rAIsFqshBmaQW/YW5PblQL35P8Fcd3dd1CttKWvuYgh/33exzIh3ebpDzwrB2N3jLs0qBX6EmsWtfeasg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QC40J8kj1VXjBXIkiniiHywXw8C90L/ImcGnP5IKWCY=;
 b=C4lcJEXl1riUg96tl3KR5LQlHqIlAIyb/PrOdU/1T+ZFy9vfMVBgRArSNW9HPDH35j7So6IwWdYtfanPivafhW9Gpzt9zvTS9sxZotGITA5fEF6U2N22SdviRfet79Ts5l0PvMUf/jj348Qi7hHx53DrJOnIxz9TMoPenAHSlXLQXA7ExUhokYghakmhgoMGb6p6PE0VYFDX8c2Ys6AWnqGG4pMze2Flo+fFkn0k7miAhcDuVcFiorArmIWD6wb86tq+erjXS86xEPFiIR0I3L4nneFV7jywcsEsqPTNPgvQbv+BiuucDK/aZsfvfSoGLcQv0/FGZHWvxwUfwOj9Bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QC40J8kj1VXjBXIkiniiHywXw8C90L/ImcGnP5IKWCY=;
 b=uwzDl6P99TN8CtQ6UEXfNxwPJFHwYoj6Cz5lJIk5ID6jP5aYxVQQcA4ReJUKEEIDWWv0+uRAZG3Cy/xMx+o50AWk10WzWD1GwNSwUa+iGwjHdLeBZYjzzLNjmvN8ZN5TXrMbJJUrwYRzP5rGsNZG7L6kZAYo7Ht/j/CZO5Firwg=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SN6PR10MB2782.namprd10.prod.outlook.com (2603:10b6:805:dc::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.11; Tue, 2 Aug
 2022 15:52:54 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::8cc6:21c7:b3e7:5da6]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::8cc6:21c7:b3e7:5da6%9]) with mapi id 15.20.5482.016; Tue, 2 Aug 2022
 15:52:54 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>
CC:     Bruce Fields <bfields@fieldses.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Jan Kasiak <j.kasiak@gmail.com>
Subject: Re: [PATCH v2] lockd: detect and reject lock arguments that overflow
Thread-Topic: [PATCH v2] lockd: detect and reject lock arguments that overflow
Thread-Index: AQHYpeDywRmd2Ah7M0OUhDyIIRvMH62bp2IAgAAbKgCAAAGMAA==
Date:   Tue, 2 Aug 2022 15:52:54 +0000
Message-ID: <07E1B05E-B611-4831-95BD-962C7C378675@oracle.com>
References: <20220801195726.154229-1-jlayton@kernel.org>
 <D34C84D6-B1BA-4200-9879-B0AD6CE8AB00@oracle.com>
 <643b9dc1976a24a65cb6160ce3e16c57afa59b84.camel@kernel.org>
In-Reply-To: <643b9dc1976a24a65cb6160ce3e16c57afa59b84.camel@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 99c2533c-d071-4c77-5c0f-08da749f1031
x-ms-traffictypediagnostic: SN6PR10MB2782:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: W28JEaT5tGx0rV5DzM0Z+qNfyCI9suvfyfPapLjubddc5qOc6gg3HaRaVDhGboNs89wjynZi81UCKihs2LUavD0/HglItT/PjFLnQvKepJxJ2B6dLI91DxyIjh5qZDPfnjfAyPXzKc2HC4V6JFJxvfToB1lXaB3fpLAQlrB9LGj98p5+FtAbXQIGusRM7FIFkbUB3JUyh5kQsLMcwZhI1+cdlzafJ1d3dImtN3ZZ0CVW/VZuG1gJ6UFLN6txJ2zuIGBQUrPv7k7KbX4n3PbCS4yoKb01S8t23/6Z2a/7CJnBK70OC9fqIWdm10mpIssGuyJyWq0ADD1yMmIfeIhdiE6jV/xa/pJceY/zC1O9Zz5muWuPpzvbY7tWTQQSm5Xraij/w61iCR5adHkRfWSlTBqXZ50AFu1jDd4h/g8blbAf9jVWsHSFMV6V3xBYBUYetjxOWVIwvAaitY7rCyq1kiab+xm/W1xtXrlStuFGC/MaZ4j6Tmo+agAkzmTt2y2dvmVaPOE47gRGyz9vnKvzVuAe6C/QN+F32J5yxIWJ85ZVLwS7YpNIVfRjQvQZaz/FsPdSyADHMFFp3gXiQI2QP4Oo7l8CLo2sppGsFc5ECF0H+VIDaE7WTdK1ZiQtPsMVgNPQCX5lDvAq9xvUYR/w1eJ4wo3pWKi5aEXaNkcoObaQ6WUK7w2oA2lr1gufDFWBQvcf6NKaf9VW4GhDwUv2rgd0dZhxOvdgWbmnBT7qk0NqJiFXntQGynw5cp2ztF3nOLt/4baLUc7LwsedX1nNEnBFpwfjsHLjqLR1aF1KVZsTroGNXLhH1bo7NP+Ue5dKdy3RvjO1q7jooCm8zpsK5VbToFFeWyjImM0hSpPquXwdvx6uM3jh9l0ycRS3Fjei
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(396003)(39860400002)(136003)(376002)(346002)(6506007)(6512007)(53546011)(41300700001)(26005)(316002)(478600001)(54906003)(6916009)(86362001)(71200400001)(966005)(6486002)(38070700005)(122000001)(38100700002)(2616005)(186003)(83380400001)(91956017)(36756003)(2906002)(8936002)(66446008)(76116006)(66556008)(66946007)(66476007)(33656002)(64756008)(5660300002)(8676002)(4326008)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?QvKSSLsDRL4qCGrlHazyCe7DnI6iqRfBsgb4hCrVeFV0N5PqBklKumC1SQMW?=
 =?us-ascii?Q?veGEUNQh6mHml1watfnGXU9Ke2UYeRIBlXYmOJeTJBi2tenFKSmexWWdxvju?=
 =?us-ascii?Q?sjmGTIWAKyqzYDfjk3YKi66munOTKf223PRiOpUvIuUr3JGygj3BLj2LT6ZM?=
 =?us-ascii?Q?qE0GFwoxAMklP7ZRJIJfqX7FozxY+Xo38uluJOQ3jFgAW/XfZvdAOUy465/k?=
 =?us-ascii?Q?hWAGcHeY6oP4vYwnjc6WLKK0Dy/mgawBoXX08sT85nkDRmBKbnnw+Vv/dyX1?=
 =?us-ascii?Q?w3PLg4Z/klmGHirsba8BFbDTBMHjsk/YK1hgq0NloQ+Dl3MKOnJEUKlBqtHE?=
 =?us-ascii?Q?WJN94MVdZ0Nnt2GioRnRZvkwGnphfoWPHMdChhvftWVCo7ZaJUK4H/VavQY+?=
 =?us-ascii?Q?J8SoqRpi/X1C59w8S2NfCtawASE8obZGWT2c2h1nfUrZCkiijVblqak3NfJx?=
 =?us-ascii?Q?6mdcfBKMHVikarOkVVGvovOz6OnyHYHzUyBDsXxMasYRl7XqjFqmAYLhmuRF?=
 =?us-ascii?Q?2lg4BAys1gnSZMMpPZ24HcFbDWbTRlU0KQLZ6qSSMv8C4SYqMQ1+3sHja7MO?=
 =?us-ascii?Q?9gRws1T0lnBnqKPZT7qC/UtRmjdhvjrXNJGOXvumUNzs0Kn8omon352UqCfN?=
 =?us-ascii?Q?fiZv905faXjafO56ZILIMYchv/mrasV12b4scAl0c7SUsYYfNgYy+qnZbJty?=
 =?us-ascii?Q?w+M4Y1o0V3/I/aeuwmBpzXRcojjUTtFtAgwyGKhS9oDn3k/7i9rdFDDmeRVW?=
 =?us-ascii?Q?cQGUOFmc8sZzYTq99ZgD/JNbBetVJQOmf6xWeyNCQoTy8pYvg79C9OYsacUt?=
 =?us-ascii?Q?MLYzut3/Swi1WioloQXZATKKvSIZ+prHgL5H61dwrGr9MnIq8CrQyYzyOiOR?=
 =?us-ascii?Q?Qo9sIgcyKJIFm5ERuAmxVGEdAt14x+nR/UYV81qflC293yfEjLpz7gmU3CYH?=
 =?us-ascii?Q?c6NTkYU+tpPeewqwRGovJRhmsh5RBPhhizOble9quvoFZfRGAZbyv+/JQqzk?=
 =?us-ascii?Q?PBYXTRLULHb6xYYhHohT4V8wrFoKuvqlWzaqaPfZNkCGha5B+l4laopAZ4yq?=
 =?us-ascii?Q?5kLT78rrNSYtBn/SJHtwDHLsQPdCrRIjD97VcRcFGcfCQqZuqIiFfGkIBaqe?=
 =?us-ascii?Q?98rBgK1WOZZ9MyAlpl7NfDqg39r56ejE3BI732NGIA+a/ziCQBVGxQRub0wK?=
 =?us-ascii?Q?KE5pVNy4Xs/w+79rTzHhovEbHRoAUk8Y3KaGNInyUpcoayHZam+m5JAyDWux?=
 =?us-ascii?Q?D29fi5A0OJDI3/p05be2VwufvtlxDy/eD59VBnZmYXQfQm0Pf6OiAJ/OLLz5?=
 =?us-ascii?Q?D2iO0Rt753xBpqGK1DBlCMhOmMn0C7JY7E28OHBc5zk+QfmWF8YeuL4Eknf0?=
 =?us-ascii?Q?uO8o079/JywCCJxM1nogGkWwGSru7JWfD4DXmTAqyDjDOAV8X3SvKi875uvC?=
 =?us-ascii?Q?2UsCqP3kA3yc+Q8BnD9lVqGPc/jIs7BVHPhG4hOPI3bFdAirnFlbDlL6Hxw4?=
 =?us-ascii?Q?EKAkrhcgo+W4VKKKI9ns8btOxjopHmem5YFdZOsFvJjHYyrXnmwe8iiVYLbs?=
 =?us-ascii?Q?aEnBohWEXr3eqOfYfvuYpY08A7gFUC+MRl6TKU7vZs8mHliRRu/KBHU2bJSs?=
 =?us-ascii?Q?yA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <6193D47264C42B40AFCD5553779CAC76@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99c2533c-d071-4c77-5c0f-08da749f1031
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Aug 2022 15:52:54.6482
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lMv9Xbsd8G3ZPk+kTSAjzKtVK3LWnBK3+PrtoIbHbqCr8Et8KtjLM9Bghfuqs6pP8sQd0RMP9dE9h+aDGiCuOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB2782
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-02_11,2022-08-02_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 phishscore=0
 malwarescore=0 suspectscore=0 spamscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2208020074
X-Proofpoint-GUID: fJ6XPNXovtYxxGEHFlyp-0nzELIxAu1x
X-Proofpoint-ORIG-GUID: fJ6XPNXovtYxxGEHFlyp-0nzELIxAu1x
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Aug 2, 2022, at 11:47 AM, Jeff Layton <jlayton@kernel.org> wrote:
>=20
> On Tue, 2022-08-02 at 14:10 +0000, Chuck Lever III wrote:
>>=20
>>> On Aug 1, 2022, at 3:57 PM, Jeff Layton <jlayton@kernel.org> wrote:
>>>=20
>>> lockd doesn't currently vet the start and length in nlm4 requests like
>>> it should, and can end up generating lock requests with arguments that
>>> overflow when passed to the filesystem.
>>>=20
>>> The NLM4 protocol uses unsigned 64-bit arguments for both start and
>>> length, whereas struct file_lock tracks the start and end as loff_t
>>> values. By the time we get around to calling nlm4svc_retrieve_args,
>>> we've lost the information that would allow us to determine if there wa=
s
>>> an overflow.
>>>=20
>>> Start tracking the actual start and len for NLM4 requests in the
>>> nlm_lock. In nlm4svc_retrieve_args, vet these values to ensure they
>>> won't cause an overflow, and return NLM4_FBIG if they do.
>>>=20
>>> Link: https://bugzilla.linux-nfs.org/show_bug.cgi?id=3D392
>>> Reported-by: Jan Kasiak <j.kasiak@gmail.com>
>>> Signed-off-by: Jeff Layton <jlayton@kernel.org>
>>=20
>> I've applied this one to my private tree for testing.
>> Thanks Jeff!
>>=20
>>=20
>=20
> Thank you. We should probably also consider sending this to stable
> kernels too. It's at least a DoS vector.

Agreed, though it won't apply before 345b4159a075 ("lockd: Update
the NLMv4 TEST arguments decoder to use struct xdr_stream")

How about:

Cc: <stable@vger.kernel.org> # 5.14

?


>>> ---
>>> fs/lockd/svc4proc.c       |  8 ++++++++
>>> fs/lockd/xdr4.c           | 19 ++-----------------
>>> include/linux/lockd/xdr.h |  2 ++
>>> 3 files changed, 12 insertions(+), 17 deletions(-)
>>>=20
>>> v2: record args as u64s in nlm_lock and check them in
>>>   nlm4svc_retrieve_args
>>>=20
>>> diff --git a/fs/lockd/svc4proc.c b/fs/lockd/svc4proc.c
>>> index 176b468a61c7..e5adb524a445 100644
>>> --- a/fs/lockd/svc4proc.c
>>> +++ b/fs/lockd/svc4proc.c
>>> @@ -32,6 +32,10 @@ nlm4svc_retrieve_args(struct svc_rqst *rqstp, struct=
 nlm_args *argp,
>>> 	if (!nlmsvc_ops)
>>> 		return nlm_lck_denied_nolocks;
>>>=20
>>> +	if (lock->lock_start > OFFSET_MAX ||
>>> +	    (lock->lock_len && ((lock->lock_len - 1) > (OFFSET_MAX - lock->lo=
ck_start))))
>>> +		return nlm4_fbig;
>>> +
>>> 	/* Obtain host handle */
>>> 	if (!(host =3D nlmsvc_lookup_host(rqstp, lock->caller, lock->len))
>>> 	 || (argp->monitor && nsm_monitor(host) < 0))
>>> @@ -50,6 +54,10 @@ nlm4svc_retrieve_args(struct svc_rqst *rqstp, struct=
 nlm_args *argp,
>>> 		/* Set up the missing parts of the file_lock structure */
>>> 		lock->fl.fl_file  =3D file->f_file[mode];
>>> 		lock->fl.fl_pid =3D current->tgid;
>>> +		lock->fl.fl_start =3D (loff_t)lock->lock_start;
>>> +		lock->fl.fl_end =3D lock->lock_len ?
>>> +				   (loff_t)(lock->lock_start + lock->lock_len - 1) :
>>> +				   OFFSET_MAX;
>>> 		lock->fl.fl_lmops =3D &nlmsvc_lock_operations;
>>> 		nlmsvc_locks_init_private(&lock->fl, host, (pid_t)lock->svid);
>>> 		if (!lock->fl.fl_owner) {
>>> diff --git a/fs/lockd/xdr4.c b/fs/lockd/xdr4.c
>>> index 856267c0864b..712fdfeb8ef0 100644
>>> --- a/fs/lockd/xdr4.c
>>> +++ b/fs/lockd/xdr4.c
>>> @@ -20,13 +20,6 @@
>>>=20
>>> #include "svcxdr.h"
>>>=20
>>> -static inline loff_t
>>> -s64_to_loff_t(__s64 offset)
>>> -{
>>> -	return (loff_t)offset;
>>> -}
>>> -
>>> -
>>> static inline s64
>>> loff_t_to_s64(loff_t offset)
>>> {
>>> @@ -70,8 +63,6 @@ static bool
>>> svcxdr_decode_lock(struct xdr_stream *xdr, struct nlm_lock *lock)
>>> {
>>> 	struct file_lock *fl =3D &lock->fl;
>>> -	u64 len, start;
>>> -	s64 end;
>>>=20
>>> 	if (!svcxdr_decode_string(xdr, &lock->caller, &lock->len))
>>> 		return false;
>>> @@ -81,20 +72,14 @@ svcxdr_decode_lock(struct xdr_stream *xdr, struct n=
lm_lock *lock)
>>> 		return false;
>>> 	if (xdr_stream_decode_u32(xdr, &lock->svid) < 0)
>>> 		return false;
>>> -	if (xdr_stream_decode_u64(xdr, &start) < 0)
>>> +	if (xdr_stream_decode_u64(xdr, &lock->lock_start) < 0)
>>> 		return false;
>>> -	if (xdr_stream_decode_u64(xdr, &len) < 0)
>>> +	if (xdr_stream_decode_u64(xdr, &lock->lock_len) < 0)
>>> 		return false;
>>>=20
>>> 	locks_init_lock(fl);
>>> 	fl->fl_flags =3D FL_POSIX;
>>> 	fl->fl_type  =3D F_RDLCK;
>>> -	end =3D start + len - 1;
>>> -	fl->fl_start =3D s64_to_loff_t(start);
>>> -	if (len =3D=3D 0 || end < 0)
>>> -		fl->fl_end =3D OFFSET_MAX;
>>> -	else
>>> -		fl->fl_end =3D s64_to_loff_t(end);
>>>=20
>>> 	return true;
>>> }
>>> diff --git a/include/linux/lockd/xdr.h b/include/linux/lockd/xdr.h
>>> index 398f70093cd3..67e4a2c5500b 100644
>>> --- a/include/linux/lockd/xdr.h
>>> +++ b/include/linux/lockd/xdr.h
>>> @@ -41,6 +41,8 @@ struct nlm_lock {
>>> 	struct nfs_fh		fh;
>>> 	struct xdr_netobj	oh;
>>> 	u32			svid;
>>> +	u64			lock_start;
>>> +	u64			lock_len;
>>> 	struct file_lock	fl;
>>> };
>>>=20
>>> --=20
>>> 2.37.1
>>>=20
>>=20
>> --
>> Chuck Lever
>>=20
>>=20
>>=20
>=20
> --=20
> Jeff Layton <jlayton@kernel.org>

--
Chuck Lever



