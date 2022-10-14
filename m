Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 109AD5FEE1A
	for <lists+linux-nfs@lfdr.de>; Fri, 14 Oct 2022 14:48:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbiJNMsg (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 14 Oct 2022 08:48:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbiJNMsf (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 14 Oct 2022 08:48:35 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DA78185427
        for <linux-nfs@vger.kernel.org>; Fri, 14 Oct 2022 05:48:33 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29EBfnUW003275;
        Fri, 14 Oct 2022 12:48:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=jPZMIU0Q9zzQA+kA6C51QgEZy9GXu974+HR6UxwGHFQ=;
 b=retZfW2iBy9hr5qNm3PjwxMe3AnjHUNtWTxqrHBYGQW1pktPRdmga4sZc/dU7hQoCQhc
 U3Yqs2vFqgACggAHmFwh3znkgkCO8c+HJcgprZwhe0+UI2YKZ9Sti3jYWLmxNDjzBvmz
 CgSNJsGqGPDt6fu/2kvASPJ3xcv74bw8T5JbVPsYMJ+M0//CnnDptK0oMQQXbezqeBZm
 ddOt73uX6Oxilw6YcT1YK+E0s3uf1giMivc5i6aqWJhrEI/yuhpa8YLRvebbNXuxsPQL
 0CmLeyAilvLvUkd+LsnmTyvvaFeyPZydgikqKjmTUrREVovnKoKVgEGBfS49+bWwTeCY rA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3k6mswjn0j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 Oct 2022 12:48:30 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29ECgvt8003942;
        Fri, 14 Oct 2022 12:48:30 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2172.outbound.protection.outlook.com [104.47.56.172])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3k2yndmaux-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 Oct 2022 12:48:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nHLm6pwE1cVSCI1mMoP9c5XY+OQhhkDJcBKO+h7AF2nwmxo1klzGVLNVD2OmOyO2j5OlWkU5FOprH6y4dqC0kvV76SBPgRsR87wBxyld30wnU1Mr82uNB00LGzGq12C9d22UYyirt4fn05lhaB+r9lday/WiZitfQZYkTSDTvgTqZv4xPSTUi5NAYBdB6XEWV///l8S2HsxhxRyh5n0cwVxBOXU8zLif5KhFXrLKf6ISMO4P1ffIi9yNpzYgxUtP8G8+2UNIV4uFji9/4FK1LpG1US7okgj3k7mF64ERMX/qu5y7KCEwDtaLyFAv1g/QNLDyRZz3+zN8RSdcVOMqhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jPZMIU0Q9zzQA+kA6C51QgEZy9GXu974+HR6UxwGHFQ=;
 b=e8ATOnDWh62yW3eUYiFC6DZQN1XltCWxCIra0X6gyoZpmNa6TQAEAKt4vtbTt2AP/RX7IK7C7/gm54zB2oOw32YmdMx6WiiV+xetA5br3GwhEmhWJFwVzofuF1xYlfJqS52sKChU7g4c1b1dTwktO/NTSXP83YgWDz5psPogphK4tcJi7HWZVPqfXBNSv8OtxtDE0YsynoCtdLh5pQ2AUQOiLuhS43Ea9/wjOtfq0EetP8wDpk/9naPNJBd7HMMr5Q+L4qKVOFl6W58prubMRGhlUC++8XdBjh/h/hOHlR743OvoMdOfDbt2rwfTSGKFL0OFPILS7w/+MYlv4g+6cQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jPZMIU0Q9zzQA+kA6C51QgEZy9GXu974+HR6UxwGHFQ=;
 b=dWdHN51ShzFDaQmDKiIPbKvNvAzwflaweLFeKvnM1abfq8/1pVpm3kjUg28noyk74G8b028w8Ym74gBKq8B/s4FEZfY9eb+XNGPYBRalezktUfXmOORjCbo1CyrFHWIQvPMJIrkB6eFSMUqleCgKyNqOhPFf58hborekcmnvtXU=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH2PR10MB4182.namprd10.prod.outlook.com (2603:10b6:610:7a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29; Fri, 14 Oct
 2022 12:48:12 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5403:3164:f6c3:d48a]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5403:3164:f6c3:d48a%3]) with mapi id 15.20.5709.022; Fri, 14 Oct 2022
 12:48:12 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Neil Brown <neilb@suse.de>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v2 7/9] NFSD: Use rhashtable for managing nfs4_file
 objects
Thread-Topic: [PATCH v2 7/9] NFSD: Use rhashtable for managing nfs4_file
 objects
Thread-Index: AQHY2Z+f4KLIvxFyZE+pJJ7lJKAPUq4IWjWAgADUNACAALMrAIABAksAgABpQgCAAR1KgIAAhLgAgAD0DIA=
Date:   Fri, 14 Oct 2022 12:48:12 +0000
Message-ID: <BB91F1B4-1E5A-4E13-BEF8-83455BA4F60B@oracle.com>
References: <166507275951.1802.13184584115155050247.stgit@manet.1015granger.net>
 <166507324882.1802.884870684212914640.stgit@manet.1015granger.net>
 <166544739751.14457.9018300177489236723@noble.neil.brown.name>
 <EB08B095-BF02-4B5E-8CD2-12B0201328D2@oracle.com>
 <166553144435.32740.14940127200777208215@noble.neil.brown.name>
 <4004BFE1-C887-4A53-9512-8A264E0361FF@oracle.com>
 <166560951668.32740.3528791072339550207@noble.neil.brown.name>
 <E69F66C3-C17E-4397-8329-8B6C2D2E2F0F@oracle.com>
 <166569928288.32740.15383309396957908665@noble.neil.brown.name>
In-Reply-To: <166569928288.32740.15383309396957908665@noble.neil.brown.name>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|CH2PR10MB4182:EE_
x-ms-office365-filtering-correlation-id: ed4bbfa6-87e4-4155-17db-08daade25aae
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dmNF/2NZ0mVVS5Rql0fvLfhjxKV4B1ggKLSjAeDpsF5zVMMZlt2IHZivXz/apEvNyafpSmTVDXIYAGziPefYdpqFDuMfH3hEHr0r5qJHB+XJRS6HIxv0aNTlzeaJVbPS1gQGBUsY895SYa92t6hkvGk/aGy7tVNIXQ1Ez5qE8aUE9wlJz4mziyx7LStlQAR+hXoSC0Y77mpusRK8WfgVTTlJwoHdV2rtOqA89fcpfgDx88LuA05bxch/FynEByDaKVotAVXM3OWZWHDYaO6oLBmjeLdk3Jc2K1uCxaluHeuLmjJK85lifP8XzNp4vEdaCF1zoAGNxQgtNF7fdgRXx1og1DY8KjhOkBnLrESFICeM3Ij4VzFCmeZ83JgAEErcyyr2xTobbT5spK+aR4VsC/0uYMk8mTHW6YMvLppBxDYAXxz5qppxhjluTruPmiWY5S5c+SK1e766dzrm6a0v9ox3IvQ4qZC1XMBG+KwuTPcWq20v+8wn0aWQysC7YD52iuoBrvJibbaW/KGq1EIs4MABjq3u5fRhCfLrtoYJ3BZoU2NCfpa0ys7UevLajLmKFN1su/Ad7VS5I3gc2pfNxt/I3SgW5nHIvKF1VQMZgf+mKSGP55iBLQkP9xH3KJS6tEAbNLa4zoh1vOKY7ooncZT7Y+uz1FlCPgDZQuaPW4OY5/mzMxBj8kcCDbqlXuHKSCaINP8KnyJWFZIBJY9tUsiyLe9Xz+3mGIBrbqSeApb89uo3+uJwqGv6nDFjdkXXYaNSwge705TkR2BJQ00kCuxSEpO+fCXfdIQb1hVHR/4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(136003)(346002)(366004)(39860400002)(376002)(451199015)(36756003)(38070700005)(76116006)(66946007)(91956017)(83380400001)(71200400001)(2906002)(8676002)(8936002)(66556008)(66476007)(66446008)(4326008)(53546011)(64756008)(33656002)(26005)(6512007)(41300700001)(5660300002)(38100700002)(6506007)(2616005)(86362001)(6916009)(122000001)(186003)(316002)(66899015)(478600001)(6486002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?hxNoDEONtWmwCrUczKhgV0SVXxgwakmoSLbhN8APWm+Z1OdhYGQ28RDpo/h3?=
 =?us-ascii?Q?vTHzy/pO8LLdNBqCo8V71UKdaRSLcOn3+3U5fbWWqZo/B1PXrTEvNI81hA4Z?=
 =?us-ascii?Q?DQAWvrOTFUE+zB15wsGCHQzZpQLxEOHDpNeqXRW4CXTPyuZBsBxzkU41vKK1?=
 =?us-ascii?Q?hWh/I2tblE2DFZgn/6W6MWi7QwtPbAiP4T+ACylrJDmSxflQ47fQjTvrjoae?=
 =?us-ascii?Q?dmHoynXvpwEEK/S047GFBmHsRCQAp8l2xq0poe2uVe3QqHSCTi6wTUZeyJGo?=
 =?us-ascii?Q?ujIKpk79sow4MnLusGxCAauQz0az0Zb14dp0OKWMivp6PHLKjHyOfhWTx4C7?=
 =?us-ascii?Q?XWuKoNSqOam5/FBjiZ2Dx6VMaW8tTaBNv+JYl65TLF9Oaq9FM54oK+w/Bu/R?=
 =?us-ascii?Q?oNfOuJXaTODUUPUoChiE9+0vxmGE2lLyZj1JxwY8mKg5YsnGpSRMyh2wAmbK?=
 =?us-ascii?Q?ViBF82PnKhKOQ2NyAKd2UJenolk3Qq1uS1fg82BK8PXG9ErXAGmr6VfcZXKx?=
 =?us-ascii?Q?CMQj/xLKxk/w+QJR0qeBJfaef6yRIJyJSFTIVnnul7cvioCaRvKiBOqJ6uVC?=
 =?us-ascii?Q?T2yDsS+9HCOTY36DAFfUMXOI3ZK3scc0BGwlX4Ojith9WmM6o54kdqglH8Ou?=
 =?us-ascii?Q?VpaZ+Ed4qmBdlIzjOWXsA42CoMZ4dlaJwK98HifuvqaKGKyXCTBc/86J5F6O?=
 =?us-ascii?Q?sNmYd61zlUVeqgxTzXt7+Uy/IvXpVuZNZRr4x5nI0f3Jp3VpXbacxcV/qdBT?=
 =?us-ascii?Q?I4pJ96UIJG3OlUvVoWj3ppmSaODz4QtnK2QLoYpm2a/1u2siTUuEJLhSngrv?=
 =?us-ascii?Q?dKRGt7np0o0BLdQDj6ZpJoF3Y+LNTPzReG14mtBlUzDlFuVOjMJG1eaf03/5?=
 =?us-ascii?Q?gK1O5cgPtVcScLcY7He3CcDip+2yV8Pd2qN2ORvzEzehMQ+Koym2PU2suXoF?=
 =?us-ascii?Q?dO7hNKm/ZraAL+SQyXJwmXkWi2P6zKM8dVP4EzUup/XVf31noRF9NRn7S9W1?=
 =?us-ascii?Q?mH0zkB5rhHsNrsKIJWnSd+JiafHqOaGkjIYXwrHDAfu/q8GoqJ2KoCJd5N84?=
 =?us-ascii?Q?00hMGiCx387fGEYoAg79Skt6wsM8UelPPWQpQJPCo+J4fPvP/fXQLxJyNCY8?=
 =?us-ascii?Q?DQwUkit30JXzFN+ctXe2qeDkZV996gMzIGgtbvqrndGl51zkA7LiADndQDTw?=
 =?us-ascii?Q?dcJKBCcYNU98CInohxsg6Ak2ncneFydoaYKqKS5LE/cmnnmqKRgtBBzESe69?=
 =?us-ascii?Q?SuHwnJy0AV9upsIURVEo5Q1/MdQ3iUp8hF93MqEakSbs1wxBBogBptG6c4ka?=
 =?us-ascii?Q?HpFTN3e+ftsYTZX1FF+wskVRTSlDmGZUmsYHwJa/lCcDz1U6xEBt2dSu3YJZ?=
 =?us-ascii?Q?X4ulet1ftNkr5NZAOSlacQQiKJN+1S7ymn1PUv77nx44RxNqWK/hrMYTi/Pa?=
 =?us-ascii?Q?3+mdBrHkhSXLvpWLh29xYB8JbjSyQvuL6/L6JzdNX7rs7/TuURkulnIOzvOO?=
 =?us-ascii?Q?mYTKplYpgiKamX7fBFbp2hL5vSebjSiGZJP6iMJ/QAIGBfH7FGbxKAX6y3eQ?=
 =?us-ascii?Q?rhQmUo17OJHmRu8LPa84lwNkX2r9vMTH5DN3vvfsPuODpWBinVqyD9DC8jLL?=
 =?us-ascii?Q?DQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <8ACD9B2190EB8A41B15C47EFADE9D6A5@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed4bbfa6-87e4-4155-17db-08daade25aae
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2022 12:48:12.1294
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kv8GB1+jnYtKWcyDEuP3X0fVnuSkWAZGxETxL0HNxvkrqgOQLXBCH0wfGxAUlDxFOqJEUcm8fRlgh8tGMQ0Wtg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4182
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-14_06,2022-10-14_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 adultscore=0 mlxscore=0 bulkscore=0 malwarescore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210140074
X-Proofpoint-ORIG-GUID: zRwGQgxPJkXYX_wlkV0ORjdOPWkLRwgP
X-Proofpoint-GUID: zRwGQgxPJkXYX_wlkV0ORjdOPWkLRwgP
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Oct 13, 2022, at 6:14 PM, NeilBrown <neilb@suse.de> wrote:
>=20
> On Fri, 14 Oct 2022, Chuck Lever III wrote:
>>=20
>>> On Oct 12, 2022, at 5:18 PM, NeilBrown <neilb@suse.de> wrote:
>>>=20
>>> On Thu, 13 Oct 2022, Chuck Lever III wrote:
>>>>=20
>>>> I think I stopped at the non-list variant of rhashtable because
>>>> using rhl was more complex, and the non-list variant seemed to
>>>> work fine. There's no architectural reason either file_hashtbl
>>>> or the filecache must use the non-list variant.
>>>>=20
>>>> In any event, it's worth taking the trouble now to change the
>>>> nfs4_file implementation proposed here as you suggest.
>>>=20
>>> If you like you could leave it as-is for now and I can provide a patch
>>> to convert to rhl-tables later (won't be until late October).
>>> There is one thing I would need to understand though: why are the
>>> nfsd_files per-filehandle instead of per-inode?  There is probably a
>>> good reason, but I cannot think of one.
>>=20
>> I'm not clear on your offer: do you mean converting the nfsd_file
>> cache from rhashtable to rhl, or converting the proposed nfs4_file
>> rework? I had planned to do the latter myself and post a refresh.
>=20
> Either/both.  Of course if you do the refresh, then I'll just review it.

Yep, I plan to repost, as part of addressing (your) review comments.


>> The nfsd_file_acquire API is the only place that seems to want a
>> filehandle, and it's just to lookup the underlying inode. Perhaps
>> I don't understand your question?
>=20
> Sorry, I meant nfs4_files, not nfsd_file: find_file() and find_or_add_fil=
e().
> Why is there one nfs4_file per filehandle

I can't answer that (yet), but I suspect there is some semantic
association between the [current] filehandle and a particular
state ID that makes this a sensible arrangement.


> I see that there can be several nfsd_file per inode - in different
> network namespaces, or with different credentials or different access
> modes.

My impression is that is by design. Each namespace and unique
credential needs a distinct nfsd_file. Each nfsd_file acts like
an open file descriptor in user space.


> That really needs to be fixed.

I'm not sure I agree, but maybe "that" and "fixed" are doing some
heavy lifting. Jeff might be able to add some insight on design
purpose, and we can write a patch that adds that as a documenting
comment somewhere.

--
Chuck Lever



