Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B2AA5F139A
	for <lists+linux-nfs@lfdr.de>; Fri, 30 Sep 2022 22:24:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbiI3UY3 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 30 Sep 2022 16:24:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232636AbiI3UXt (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 30 Sep 2022 16:23:49 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B5711A3AF5
        for <linux-nfs@vger.kernel.org>; Fri, 30 Sep 2022 13:23:29 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28UJx5Mm012746;
        Fri, 30 Sep 2022 20:23:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=qXixpXeSJgLnrodEgP3rEl0GVffqJAHHS1Vx/Nc2hSk=;
 b=Zut2Ll4M/OeP2XHnVZvkhP9ay9dB9vRtATzJbux4CrnZr473XP0wz69Wr1JqQVsmTVOL
 evvaW5pA/xIKcOs7Pkg1IiQC1HoGM5uDT/YkJkWujae9X1mBFMLvN4DRaSg46IOUr3ka
 Z/BjetWZcqR+XKTwjp0UpOnwJqOzBTM65lnWpTpIYSF0hdIE3w4LDtx5AN9489sKVOh0
 GAtg/f6A4FGgn+0Q9lno/fnwROCLPjO+0xWMA7FX5lYmbJhaSQkcqEsZfxCMVjvkWz+m
 QuuEugtU/zMEe7O2IoEGOzebTuEitHUOCawsxPAvPg1J98TH9HA5LQ3nu+ixssUJTj2Y YQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jst13rr01-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 30 Sep 2022 20:23:15 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 28UJRWWq022199;
        Fri, 30 Sep 2022 20:23:15 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3jtpvjc38t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 30 Sep 2022 20:23:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jDJS6EaNxHxUx5tbGQvRNpuqyiQC+AItvyVcU3Nisobzy8RL53eU/ok59bLtCzpgfw8CIT5NUfiIb+Fw5Tp6yPnQ1yiZ4S4dX0zfGxT0EMK3mkXw86/rSfCgOT4UTAqZ2lxF16exZK4HuWdkly3sEVBjnD/mc1V9o84ZzwbMvQreJY1Fj4wvQhBmZkJ/CeZvRwqTDF8XWmoNBS+a5OyzjjoDVQQPtEXtAXJfkZ6NpuAOyb1ySu2KUv+cisQEXQ7aMmqsikf6a3zwvP1DfPF6F96avY4FaOMx7hlnSMa3DzUMT5EKb20JhjoMAOmARemDOMebT5+/J4h4PZYcp8hygQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qXixpXeSJgLnrodEgP3rEl0GVffqJAHHS1Vx/Nc2hSk=;
 b=KX12WPTjpf3TcTolj8GDTUvzfGUPYvRb90NeUz5orqkYdEd/KH/dIwwyqtCg+VQ2ZlzGCmQXTAlTWET4YRxDNHvaVArpIWp5DDzmCr5zMDPr+bxekjsWWv2tJ5E3JRUzdxDi2eRBHpCU2wAKCCs5PhXtf4xz7lVS6uW0u+qqVOujEUmibSkXcO0LR/5Kd9b2Dyzjx0pU1bATBqeUvFmAW9aaaR7Q0KcwaScHB+eOI/J04sl95MmoF2zntmC+gHjdAIVVQCYDTJXWICdKC2q5zd+dV3t5rH1gkuOtn8dpTmBcDS9lbEXt56mzQU26jGGQ9Vihx3EQK4YrJzrTHs4ALg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qXixpXeSJgLnrodEgP3rEl0GVffqJAHHS1Vx/Nc2hSk=;
 b=r4FRlYFA0xFQ/NhPF9SC2QFDfKXvaWMpjklSqLjxcJtCIJ+3548MN6/ftYEVkLzGi+1MpU8b55V6AAPsytXkN9VrwNNAwvOxRnPcDs7FuXsQUFgd16k8Tq6KM3XztfdPfnaNSRP3LvKrV3M+ZOxjWfXadLdeHESWXP7x9QfbQEU=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BN0PR10MB5318.namprd10.prod.outlook.com (2603:10b6:408:126::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.23; Fri, 30 Sep
 2022 20:23:12 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5403:3164:f6c3:d48a]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5403:3164:f6c3:d48a%3]) with mapi id 15.20.5676.020; Fri, 30 Sep 2022
 20:23:12 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 3/3] nfsd: fix nfsd_file_unhash_and_dispose
Thread-Topic: [PATCH 3/3] nfsd: fix nfsd_file_unhash_and_dispose
Thread-Index: AQHY1QEStfw/wemJJEuDuuhGYIHZOa34W9WAgAAD1QCAAAs/gA==
Date:   Fri, 30 Sep 2022 20:23:12 +0000
Message-ID: <E06BAB8A-42DA-484E-96C7-EE7A9254476C@oracle.com>
References: <20220930191550.172087-1-jlayton@kernel.org>
 <20220930191550.172087-4-jlayton@kernel.org>
 <71D7277C-4E90-476F-A381-BD13E264BA63@oracle.com>
 <649ea8a13435734a54fc6755bd6599c2cacc3a53.camel@kernel.org>
In-Reply-To: <649ea8a13435734a54fc6755bd6599c2cacc3a53.camel@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|BN0PR10MB5318:EE_
x-ms-office365-filtering-correlation-id: af17db79-8481-4819-9e85-08daa321993d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: i1x5Z2RWjiTU5Og0L/19EiHczS2bxauLeJF4BnRIT5RiW3+lVUQyCw4WEovIrOTDv+7yzj71b+Dp45Ck5P4ZqKkwvz4M/zE6zM9CehDb4cesEy8somVVJS0hwfLgctMv8m9nzRkvaWdmCIw0U5LH1XXd/5t56g1ut/BAn6iHAbJCSQaRQ9zHNGc1gRLiX9TKGoXPhCqBBjN9zUk1UErim9PimNzPT8OWM9wyw/WnjlLnxoRxyXcVt2FM4ul7nZ+x8wQ8ueYuk70m0AyQGaSolPLnnGxkEYvK7UageKtqH6aYI4UYAnkkh/vjIi0qzRmZjpKmCUdHRsM+KIE5+E/s6qAZCk7BdaH0he2a40rw8roLfpCeBzu8U4u4ogr4CUpO/4XtSHatrcI4CsoSVIKWZ77Iuw14xNyg6CgpD7kHspFf/+8To+3X2hqfXEXjmT78/DoIFgwtg8DvvPDGmr3dE7J8+FedT1iN2O1sgSoZxZI63FN9QGu3ZAlxxbCheeQorrNqlzKJD9vyIaLAcQNC1xmv1bQW7UmbuTRp+S+xhaKQRMlQtTj6e+52qVwIedYMHomB/q8vtC4EMpbeQUphHgDJHBuIuz45GZ5QUtOI1yC0SdBhG1xC3S0q6nZ5yAPsqMt3amrmwJqY2YN4mVKWl2VW49Nk1AAdR3H2li8zWPXoJ5HAbutVm2NZxCP116WqfsMq8MqA48b1eGheqyACW5ugZmmQwEd6KtojwlkH25Fgiaohvo9xClJ7yo3uhnPly6LV8fdDzi7FAlbJ1W4OIlcLW8XARn45UQackt0nZAs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(136003)(346002)(39860400002)(366004)(396003)(451199015)(6486002)(6916009)(86362001)(478600001)(316002)(71200400001)(53546011)(8936002)(26005)(41300700001)(6512007)(91956017)(66556008)(66476007)(66946007)(76116006)(4326008)(8676002)(64756008)(66446008)(2616005)(36756003)(2906002)(6506007)(186003)(5660300002)(83380400001)(33656002)(122000001)(38100700002)(38070700005)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?JNDqRxROsy+HYaEgGxjryKnL3zJ8n4Gq1Y7ginoI6Q+UzJoAqJznjhB9Y1Bb?=
 =?us-ascii?Q?Ht08eagh20GG8X3bFgHIUwU4pdnAn6mo4w5FyJdOIt3TdziWPwJS/z5tvk07?=
 =?us-ascii?Q?HwDZNyv67kQ5uMR5LDcNfZ/MfVAlz87rTHeNBjaJTW1rlPMJB6/aq9W5EKln?=
 =?us-ascii?Q?4qsFue8XBWaklgEMvdOD8IV9KAbq+GNWI3rG0EnaoxOTDm3wdd1QN6UbAXQK?=
 =?us-ascii?Q?+m4s+X2fEqsId6Ns6jyhU9wcNCiTThWp5htI/6HF3kAAvcCdp6ZsPGBCgHEA?=
 =?us-ascii?Q?kcsoBcMYSd3Gi1f9i7d8k2xJBCJRJm7yF7OJlM6qEnoE3CYf8CRLUovw31an?=
 =?us-ascii?Q?oQ3oz6fdvxjFWYz0Sy9gZfbLQvfgJ5YhRJ9WkE5h7PfnO4ik4BbTxMiDUIdD?=
 =?us-ascii?Q?FW5s+GW4seqlfhf9Y7zTOtcyQ/uAnfTktl+SwvqTaZtNGQ4ryhF5+Yq4u2Qw?=
 =?us-ascii?Q?SjVdJoneJd5LjVKI4LolMMqq47S04CAqoRnUh5IBNDL2czALJDAE63ZDNF7m?=
 =?us-ascii?Q?goVyHmFtWQS0017rURl47XRa7v9kvSiYJUugVJ42jw/t9L/dMdHaPmgC8DjL?=
 =?us-ascii?Q?u76Vl4h4rTX/gspqO5E8U9pacGwOlJwZ2wTqIPtBobnbqQQxEuxMLsv065fj?=
 =?us-ascii?Q?I3sCcwScZFMj4aE/kJqvuEXHyKclKkFZQdYNG8r2LszR0tCifeJkscCt+SaX?=
 =?us-ascii?Q?nWRgU8otWqcXFe+7D6LWPTIeyKZ3GixZ+cRXw1cl8WU4RvgSGrPP2BoWWYO+?=
 =?us-ascii?Q?wt1NqqnR8Jm/v8jpi4wVldtTtcRGVauE+NV8NR7+OLcDKSSVm53kDEYqwJLI?=
 =?us-ascii?Q?eeuT6/xjHGYFoeXAaYNKwHKpii0t1BYAPo4xH1lvce/sdAnlhSuWghk1yICA?=
 =?us-ascii?Q?apCtonyS/iHhDlQWRzXqWhKN4XscDN6TeE9mGOyjJFgmf52srRwG2UCZ9MFS?=
 =?us-ascii?Q?ZpIdv8b6rWXbsKJfiT4hI3fgMw6cCLw1piEQ9zdH1HwqqXyUusmt+Txg4EeB?=
 =?us-ascii?Q?gye9gcQW7xhT1gZv5NCGfbvgB+6tWUQKDaEUGu/cIyqCOGiyhsg/x7GulDxv?=
 =?us-ascii?Q?QeOtXss97sCPFGpsLlKeUIHW4I6WgsBLXGb/zNKImjsX6Qxa/WWXYOdSIoV/?=
 =?us-ascii?Q?i2GqGcpfNs8BkHWNy6zoG+Uq/rw49kRGfCRsq4dDkvPZa0rqC8Adx1NntvrG?=
 =?us-ascii?Q?rWJrT8JyQqurN7Kj5nt3YwuIo1KuhuMTMg/mjzZLsZQjL1tovDgUEtr7MqCl?=
 =?us-ascii?Q?hGcwh7jPDzqrICPR5OVwgGVxaJleihh3siQteRf7iHJvwH/h2PgnVNAjsF0k?=
 =?us-ascii?Q?6/dPRhBtDvA3SzOQqUe37vgD+6/PO0NIT7pOsbDYr5x2rqvWQ2dqO/nsHfOq?=
 =?us-ascii?Q?yw8kkp8mnQz70qAwNsdVL/zHi1LLUc60vDtyo8HOu/v+XiNPL2W+S6VJip60?=
 =?us-ascii?Q?pftjW8Z93Qz+UCinB6SQ9tKwfBmggqgNmx1FSGHpEeLFp04y7W4I8B69TIAy?=
 =?us-ascii?Q?CfVlInCt1mTksWdMGK9SqjMuZwR/NBoQOxNRf3jkJYcIefqnJBctk8q247AW?=
 =?us-ascii?Q?89kOMzVN7C0KI91qv6Zyk+3ba+Cy2eMLIDVByTomaJDYhGfoCgZO1W9GZGKW?=
 =?us-ascii?Q?YQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <8E0F4365F77DDC49B63AB352E4DD6020@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af17db79-8481-4819-9e85-08daa321993d
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2022 20:23:12.5922
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ij8U5S/oriNexg4+/4EO6ecDCQIk9YfRmT9ZpLJ6mqQORHRgldIANA+AywGeR0nQ4hRZSIaQKK7z4U1d5OQmRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5318
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-30_04,2022-09-29_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 suspectscore=0 adultscore=0 mlxscore=0 spamscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209300128
X-Proofpoint-ORIG-GUID: rUNXnRX8GQyq858AW0mFFGBICzCZsvF6
X-Proofpoint-GUID: rUNXnRX8GQyq858AW0mFFGBICzCZsvF6
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Sep 30, 2022, at 3:42 PM, Jeff Layton <jlayton@kernel.org> wrote:
>=20
> On Fri, 2022-09-30 at 19:29 +0000, Chuck Lever III wrote:
>>=20
>>> On Sep 30, 2022, at 3:15 PM, Jeff Layton <jlayton@kernel.org> wrote:
>>>=20
>>> This function is called two reasons:
>>>=20
>>> We're either shutting down and purging the filecache, or we've gotten a
>>> notification about a file delete, so we want to go ahead and unhash it
>>> so that it'll get cleaned up when we close.
>>>=20
>>> We're either walking the hashtable or doing a lookup in it and we
>>> don't take a reference in either case. What we want to do in both cases
>>> is to try and unhash the object and put it on the dispose list if that
>>> was successful. If it's no longer hashed, then we don't want to touch
>>> it, with the assumption being that something else is already cleaning
>>> up the sentinel reference.
>>>=20
>>> Instead of trying to selectively decrement the refcount in this
>>> function, just unhash it, and if that was successful, move it to the
>>> dispose list. Then, the disposal routine will just clean that up as
>>> usual.
>>>=20
>>> Also, just make this a void function, drop the WARN_ON_ONCE, and the
>>> comments about deadlocking since the nature of the purported deadlock
>>> is no longer clear.
>>>=20
>>> Signed-off-by: Jeff Layton <jlayton@kernel.org>
>>> ---
>>> fs/nfsd/filecache.c | 32 ++++++--------------------------
>>> 1 file changed, 6 insertions(+), 26 deletions(-)
>>>=20
>>> diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
>>> index 58f4d9267f4a..16bd71a3894e 100644
>>> --- a/fs/nfsd/filecache.c
>>> +++ b/fs/nfsd/filecache.c
>>> @@ -408,19 +408,14 @@ nfsd_file_unhash(struct nfsd_file *nf)
>>> /*
>>> * Return true if the file was unhashed.
>>> */
>>=20
>> If you're changing the function to return void, the above
>> comment is now stale.
>>=20
>>> -static bool
>>> +static void
>>> nfsd_file_unhash_and_dispose(struct nfsd_file *nf, struct list_head *di=
spose)
>>> {
>>> 	trace_nfsd_file_unhash_and_dispose(nf);
>>> -	if (!nfsd_file_unhash(nf))
>>> -		return false;
>>> -	/* keep final reference for nfsd_file_lru_dispose */
>>=20
>> This comment has been stale since nfsd_file_lru_dispose() was
>> renamed or removed. The only trouble I have is there isn't a
>> comment left that explains why we're not decrementing the hash
>> table reference here. ("don't have to" is enough to say about
>> it, but there should be something).
>>=20
>>=20
>=20
> How about this?
>=20
> +       if (nfsd_file_unhash(nf)) {
> +               /*
> +                * Unhashing was successful. Transfer it to the dispose l=
ist
> +                * so that we can put the sentinel reference for it later=
.
> +                */

Right idea, but I would say nothing more than "nfsd_file_dispose_list()
will put the sentinel reference later."


> +               nfsd_file_lru_remove(nf);
> +               list_add(&nf->nf_lru, dispose);
> +       }

I was staring at this earlier today and thinking it needed clean
up. This looks right to me.


> In this case, we're basically transferring the sentinel reference to the
> "dispose" list. Later, we'll call nfsd_file_dispose_list and drop it.
>=20
> Now that we don't have such onerous spinlocking in this code, we might
> be able to just put each reference as we go instead of deferring it to a
> list and putting them all at the end. That's probably best done later in
> a separate patch however.
>=20
>=20
>>> -	if (refcount_dec_not_one(&nf->nf_ref))
>>> -		return true;
>>> -
>>> -	nfsd_file_lru_remove(nf);
>>> -	list_add(&nf->nf_lru, dispose);
>>> -	return true;
>>> +	if (nfsd_file_unhash(nf)) {
>>> +		nfsd_file_lru_remove(nf);
>>> +		list_add(&nf->nf_lru, dispose);
>>> +	}
>>> }
>>>=20
>>> static void
>>> @@ -564,8 +559,6 @@ nfsd_file_dispose_list_delayed(struct list_head *di=
spose)
>>> * @lock: LRU list lock (unused)
>>> * @arg: dispose list
>>> *
>>> - * Note this can deadlock with nfsd_file_cache_purge.
>>> - *
>>> * Return values:
>>> *   %LRU_REMOVED: @item was removed from the LRU
>>> *   %LRU_ROTATE: @item is to be moved to the LRU tail
>>> @@ -750,8 +743,6 @@ nfsd_file_close_inode(struct inode *inode)
>>> *
>>> * Walk the LRU list and close any entries that have not been used since
>>> * the last scan.
>>> - *
>>> - * Note this can deadlock with nfsd_file_cache_purge.
>>> */
>>> static void
>>> nfsd_file_delayed_close(struct work_struct *work)
>>> @@ -893,16 +884,12 @@ nfsd_file_cache_init(void)
>>> 	goto out;
>>> }
>>>=20
>>> -/*
>>> - * Note this can deadlock with nfsd_file_lru_cb.
>>> - */
>>> static void
>>> __nfsd_file_cache_purge(struct net *net)
>>> {
>>> 	struct rhashtable_iter iter;
>>> 	struct nfsd_file *nf;
>>> 	LIST_HEAD(dispose);
>>> -	bool del;
>>>=20
>>> 	rhashtable_walk_enter(&nfsd_file_rhash_tbl, &iter);
>>> 	do {
>>> @@ -912,14 +899,7 @@ __nfsd_file_cache_purge(struct net *net)
>>> 		while (!IS_ERR_OR_NULL(nf)) {
>>> 			if (net && nf->nf_net !=3D net)
>>> 				continue;
>>> -			del =3D nfsd_file_unhash_and_dispose(nf, &dispose);
>>> -
>>> -			/*
>>> -			 * Deadlock detected! Something marked this entry as
>>> -			 * unhased, but hasn't removed it from the hash list.
>>> -			 */
>>> -			WARN_ON_ONCE(!del);
>>> -
>>> +			nfsd_file_unhash_and_dispose(nf, &dispose);
>>> 			nf =3D rhashtable_walk_next(&iter);
>>> 		}
>>>=20
>>> --=20
>>> 2.37.3
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



