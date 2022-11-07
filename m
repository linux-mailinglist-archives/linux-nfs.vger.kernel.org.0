Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B0CB61F80F
	for <lists+linux-nfs@lfdr.de>; Mon,  7 Nov 2022 16:57:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231419AbiKGP5P (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 7 Nov 2022 10:57:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231355AbiKGP5N (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 7 Nov 2022 10:57:13 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE1A41A3BA
        for <linux-nfs@vger.kernel.org>; Mon,  7 Nov 2022 07:57:09 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A7FXdCc026803;
        Mon, 7 Nov 2022 15:57:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=KEeoxlhNSLZa9tg+ZUHL6Didl8x553liPGCafKjDUKo=;
 b=AWk9/sLW3pDjZcAwzZjpKJ7ENOP60CzH85ezX6EaD5WRuNLW86l7qPgBdBSBUzrvz+Aj
 amyIc3Gw6ZpJmA5WsyOwJevqQ+wpr85uXW+C0GIFpcwxhiXXe+gIPXRfr6azEgZPwf77
 Yz1BXO40OKDLTlT2cJLh5+HRgsjzRK+4sddo5y1zXVcjmDmX19a+n5k05EEvXWN6DDfA
 hCEmrc/gfuEdxnlXxMay4SX56PPP3eqZE/B1Ccj1KU95m9ibR9xAtKEgljgt3TpeWm4E
 Ju0ahbPZ4oaZWqv7MtuMk86fTJdFTXbRBElMk9MP8uurb8UFRAPaLuNOPd7EDcVIl3+a aw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kngkfve46-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 07 Nov 2022 15:57:05 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2A7Eho0m034401;
        Mon, 7 Nov 2022 15:57:00 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kpcscegyd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 07 Nov 2022 15:57:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NhdUW6wiQqNZlXk/VTvl0B63Tr7R9WRdR2DW4fcS6vvKQn5V9J30lqYF7ssNSu+hWX3ugb03oG/XeEoB5OZf93WZ/ovARTY/6VkR0fceoNkUu1uWdgnf18+7juejpwjueHgQcIjzNV2zVBMasFAIUgFLIyfGJ0FlihdoZuTKj8KpOEib8TPZt9UmIa6pzgMvvIjrILFY4pWH3zZwzshLVqXPGJnIOgB0KJZTMznD6zMOOCTT6zMHZLnT6q50Nd33FpZ6Zdd5r72KfgtT9ZYCVskoC7Jb53icigPvswsGMtZr7pm6yimuTw6Akz0mNNLoyWZYcL9dQf10wZ1kcDJUGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KEeoxlhNSLZa9tg+ZUHL6Didl8x553liPGCafKjDUKo=;
 b=BcMA5EY4oGCdwNfoNMLRh9DyK/2lvMvBueVeavuC8MHw0BtRK7RppRVPdQiMwcr68c9L9cSs9AxgEsLvEBKTR62xIYQ+rhSJAnBmRKyCbuVhfv4WGHnxYNZ1pIykXvvuDu3ZOpZHsuCya+I+Cm1ZlcQiPbm4FJI+RwT1e92XNujNVJUPFM1uxiGcZg9QYA1ZO2Y/VCXzX5R5t01qYf6kwuKRkKthH2nP1cMPs2nConCm2bfXe7Q2m3MZZkarNw5tPcAT9Qa8rCZ1hS2H757ZbUADdNNNwfd4cHBsuZWmmyWtpKPVMMsv55h2auVl5Qlo02V3rFu05U88y8OV4onStA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KEeoxlhNSLZa9tg+ZUHL6Didl8x553liPGCafKjDUKo=;
 b=PN5erGrp7RJehJKWSWdAQUKN97j6+bWfHpgE7RvFiSHjMWIJI2ppSam0Ob67uqYJcJCwfoq4bjll8g4mIeiW/F6iUq1ayW9XKFzSC5/nIgbbdZEkEsnRqM2BqH57rbfHHiC2RNlsfXdgrtEBMp1efNcVWDvC+o0X1BfWrkyKsvI=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH2PR10MB4166.namprd10.prod.outlook.com (2603:10b6:610:78::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.26; Mon, 7 Nov
 2022 15:56:58 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::b500:ee42:3ca6:8a9e]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::b500:ee42:3ca6:8a9e%5]) with mapi id 15.20.5791.026; Mon, 7 Nov 2022
 15:56:58 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] nfsd: queue laundrette to filecache_wq instead of
 system_wq
Thread-Topic: [PATCH] nfsd: queue laundrette to filecache_wq instead of
 system_wq
Thread-Index: AQHY8rndf59pLVGVO065DXdRZAFKja4zkPUAgAAMMQCAAACGgA==
Date:   Mon, 7 Nov 2022 15:56:58 +0000
Message-ID: <627E2119-1270-46FD-8DAA-1EFF3181E21B@oracle.com>
References: <20221107150128.46951-1-jlayton@kernel.org>
 <2FC9BEB2-189B-4EF6-AC61-40263BC47737@oracle.com>
 <561afeb91cee368db445ac74561bc6189a24fdef.camel@kernel.org>
In-Reply-To: <561afeb91cee368db445ac74561bc6189a24fdef.camel@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|CH2PR10MB4166:EE_
x-ms-office365-filtering-correlation-id: 400bf903-642a-42db-5ca8-08dac0d8b357
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: R0iFu0h8n/t/1M8tVv3o9INCI2uUosFjWCtS8v/JHKZs8/83gv20d+sB9rul1luB0jVqIZwBR/wqDhv/fFFdZA8H9wQtT/YtPxegLBY5socrPYc7ijV+muci/5RI53vypW7Zv4FvxkrGUa8p63wzi9oB56fG9U5qtqTYZ7QksKvL5icTBeA9cHLNKc3x8S2lLT2VZFmq7nol5hRotPKvU2gylGEBA02nFkVWVDBd2vTY56tC5vJogInazHAfGj+FptVtQqsTXGF5SQF1ImmL2ArMMsHk075FHece7kisaBXDZMJUdD/cdBau9rY5BgfkB+7F7+uFQoh9Yp0tXS2J5r0Yno1vTtZJq2ZlfvxiUfCepKPDqEB95n4kKsGYA1MavHAZzHZlX5+U1UXtbd44jdKVv584n5RGAgeawxhyyk8CWGn1bDZl17CzOy6mmL18unG1xdFeHsGqqJCq+ytJ2lcD2KU/PA0p7LLxnXN99da9rwOjLhKSOa+kQorDFLv8991KPLWjhX19BNEjpmvPQbq48UTq18A/lEy8u0hKZ5OVJ9Ih9Ma3xMYj63iXggy3STkHO4fHgLWHo991o+LPyyZj5s3L1N+KYNbuIvuY/K+mLKJ1aRw9O3xLYpXkEtH2M0wEO343uZS1EYlUS5aG6VXFXHxtvze51jsFeDeed+f4hnLXqQ268iYYH6I2UZVWzSoFMJFqTEv0fWY9Mhvbe3rE6CNK0+D8WaPW1G+giAkoedQP3ny0ALcv0yS/qQNdJS09a2F40csJq3zQDZqIF5EzTfjvdM23qg6eJQdVYak=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(376002)(366004)(346002)(396003)(136003)(451199015)(478600001)(71200400001)(6486002)(8936002)(36756003)(91956017)(2906002)(33656002)(5660300002)(316002)(6916009)(64756008)(41300700001)(66556008)(66946007)(4326008)(66446008)(8676002)(66476007)(83380400001)(38070700005)(6506007)(38100700002)(86362001)(6512007)(26005)(2616005)(122000001)(53546011)(76116006)(186003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?PU13knwYCJNSqHUKlfd4ri31fkfE6eFT8PFPETsRMRWY04nW2aSNiofJF1i+?=
 =?us-ascii?Q?/78kwUSuaZTSApgHdwAzgWdPQ2S0cfmgk5YdVdqiYPi3I8JhtZo2qrsSIFWF?=
 =?us-ascii?Q?oMA0esC7cJCQlLcDXCNwMyiVE2P8mERvUSVMpUQC6ugl2+HwfeXEvigQyv6T?=
 =?us-ascii?Q?lnrzOxbhasKGVprQ5rLVGVKWN7GFAOi0LY1JIVGB8fMlCU6IVYFD/3W7p93e?=
 =?us-ascii?Q?qjECvICSdqtGPKcpPKE0N2TxN8qbsq59VUyMPgpfZnxvBL0EFKaob3/pVLbL?=
 =?us-ascii?Q?1t1Js8O9PNYM63Np+jr6s9bZsZaLWAFkU3GFdlfpNowsGinAYSTDysnTGppd?=
 =?us-ascii?Q?8HVXnk5gOuOtHXYV16HCQsjToSvmczExbGaKDOtkQtp9XVAHQ/I9qxDyXx1R?=
 =?us-ascii?Q?/ZvEIUZKqPtbcGODtE+21Z1izimgTr8invqk8Bir1XLAZClXP3QVHMZO4dcj?=
 =?us-ascii?Q?CtvmJrsjx56OugZsxaR4tVMhmisR2h0D2rlytjkTUxb/4uqMHaRvRub8TIn9?=
 =?us-ascii?Q?ZuaPkikeNPbfCsJBiTMIIxcbh6ajPkMrh/HiiuJ80bQUKu9BRaRaD2evTYHk?=
 =?us-ascii?Q?bysKMkeMIXg1y0jyRBLUPBGnWg7LobOiR66Phcq6MFMRg3j8Zm0lseVH3gMU?=
 =?us-ascii?Q?T5eI0Cp+wja79Kq9pxOzIIBEc/fZ5esHpwfeJ02VL/Fzak0xvo7InQ8akDi5?=
 =?us-ascii?Q?CofUHqLgNGebN0vouloYogxt0V74zW9TLbNPOZrjA0ZRu8Iaeb8Ag40+icBA?=
 =?us-ascii?Q?5MG+/PNPJCP4qRMYAz7sI/Ia5re9r4tMZYvo9cGPeuk2bv068QC2bGA6JuCf?=
 =?us-ascii?Q?Gqe8JyH8PAo1vkZq1+pcI22ZKc1GZCZvlmSRhj3OZyh36SaKmZmk8YteohtY?=
 =?us-ascii?Q?NYXMM4+iWw6/+qG5T+uwPT3clp4GY10lEBshMXaflPGHNADm18izbTIfK5Xl?=
 =?us-ascii?Q?RZQ/ObT5WkjSmm/CLFB0VuriDAAhFlfLqwdp1ml0z5qxzYrkjrYou92TcIdI?=
 =?us-ascii?Q?rRMN8DmnqIn5iwTtMG/1b+UWc05+aoAOH3vcyDdlx2iAjQziEcGgMJMuf5VN?=
 =?us-ascii?Q?/J9IUKq5xjd4VDrlIe+SeIqziD8GiVE5HyuKrFfH7BCA63nYHrr7eJRhc9kG?=
 =?us-ascii?Q?locVhIVOoQbtFQnV6wUSVXy9Nd18zFPpvHF2N6yUARMxeAFYCAh5hZQAMzFW?=
 =?us-ascii?Q?B7J4pUJnmLF7ZNUjICHEopCNHAOF0QsaT7fnxc+NoZSFmzeOCEwsNxyh73Xx?=
 =?us-ascii?Q?ksI1eZ1dELJCQwd92kfnKwfnfhnBd8CUnSNET00wDUzbQCANXg0ZBPAbO436?=
 =?us-ascii?Q?IdTsr3k+EwnllSLYxu9DeeF6fF4m9JwmI6KoXC5lj0E/h5D6jkr5pqo2KNFg?=
 =?us-ascii?Q?Ror7nwpOYN2d9gp5dxx1k2yLRlkY8tp5txiBeDbT9lwy4YJkYJwxRucpouKz?=
 =?us-ascii?Q?AtqmhthEYFH64hEgwSNjc9eCgbcin/8Go48A+ssX9m3CxNFNtJIS8cqvdGiC?=
 =?us-ascii?Q?TMa8VwR6tIfsvNCyiPtXqpKN+HPmY6w7ltqlHulRaBStE88TAYodXFncMMFF?=
 =?us-ascii?Q?F2iaSebxPepZO1OvudTzqS4RIBWmoHNBEaqVvbmQO31xe1xxzTRIHU0FPzh4?=
 =?us-ascii?Q?CA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <BEFA530864F68A40913CD4159FCF1B63@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 400bf903-642a-42db-5ca8-08dac0d8b357
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2022 15:56:58.0193
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /dzW9C7O8PkD0petXUp4bSuaN0A8iiPbE+Z4wGkO6/zIh0Lq2JbWT43lAqLuVPMTDKGWA6owf1pKRUbgsuixOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4166
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-07_08,2022-11-07_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 spamscore=0
 adultscore=0 malwarescore=0 mlxlogscore=999 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211070128
X-Proofpoint-ORIG-GUID: m97s4P9LTiZ4OqWVTLmK5gqwPXPpsCYv
X-Proofpoint-GUID: m97s4P9LTiZ4OqWVTLmK5gqwPXPpsCYv
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Nov 7, 2022, at 10:55 AM, Jeff Layton <jlayton@kernel.org> wrote:
>=20
> On Mon, 2022-11-07 at 15:11 +0000, Chuck Lever III wrote:
>> Hi Jeff -
>>=20
>>> On Nov 7, 2022, at 10:01 AM, Jeff Layton <jlayton@kernel.org> wrote:
>>>=20
>>> nfsd has grown a dedicated workqueue for the filecache, but this job is
>>> still queued to the system_wq. Change it to use the filecache_wq.
>>=20
>> Actually... there doesn't seem to be anything special about
>> nfsd_filecache_wq. 9542e6a643fc ("nfsd: Containerise filecache
>> laundrette") does not make clear why it was added.
>>=20
>> Playing devil's advocate: why not make the converse change and
>> replace it with system_wq?
>>=20
>=20
> Good question.
>=20
> At one time, allocating a workqueue gave you a dedicated pool of
> threads, but that's no longer the case.
>=20
> Documentation/core-api/workqueue.rst says: "A wq no longer manages
> execution resources but serves as a domain for forward progress
> guarantee, flush and work item attributes."
>=20
> Given that we're allocating this workqueue exactly the same way we
> allocate the system_wq, I don't think we need our own workqueue at all.
> I'd be fine with changing this to be the reverse if you prefer.

One less thing to fail on module initialization. Go for it.


>>> Signed-off-by: Jeff Layton <jlayton@kernel.org>
>>> ---
>>> fs/nfsd/filecache.c | 2 +-
>>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>>=20
>>> diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
>>> index 1e76b0d3b83a..018fd1565193 100644
>>> --- a/fs/nfsd/filecache.c
>>> +++ b/fs/nfsd/filecache.c
>>> @@ -212,7 +212,7 @@ static void
>>> nfsd_file_schedule_laundrette(void)
>>> {
>>> 	if (test_bit(NFSD_FILE_CACHE_UP, &nfsd_file_flags))
>>> -		queue_delayed_work(system_wq, &nfsd_filecache_laundrette,
>>> +		queue_delayed_work(nfsd_filecache_wq, &nfsd_filecache_laundrette,
>>> 				   NFSD_LAUNDRETTE_DELAY);
>>> }
>>>=20
>>> --=20
>>> 2.38.1
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



