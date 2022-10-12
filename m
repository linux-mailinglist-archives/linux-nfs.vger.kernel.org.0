Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC2625FC7E7
	for <lists+linux-nfs@lfdr.de>; Wed, 12 Oct 2022 17:02:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbiJLPCJ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 12 Oct 2022 11:02:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbiJLPCH (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 12 Oct 2022 11:02:07 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 030888BB85
        for <linux-nfs@vger.kernel.org>; Wed, 12 Oct 2022 08:02:02 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29CE3s4P020012;
        Wed, 12 Oct 2022 15:01:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=8UXMXO3HSHNoj2J/cdOtvLhAGpqBGkKwCIASszVBmsc=;
 b=QGeb8MAvPWy9Q8U1WSD+I/3tguGNbzZrWNwpd6DQCEJzO8qlyn6y0KLufITE6YJIkTB/
 Zj4wK4Lq2TUfODY497x62UwB12NI+h10pmnWtRKSxtbemTL+c0VPqNsbu4fZ/GlQfuPl
 fwH0lushmGfHK9IeG8Nn0V0dkqscnJEwwZKDp6nU69vCPQGu4r5sLpph/6SrhHZdwiao
 XFfvhKREXbDtaQIiHVrj0iGrI6xwBHWfkZa0ppEPySl6laZwemN0oLohe6hcFhWA+xrl
 wGfKD9fExb4pXPAFx0bsqZodYXKDhBpdkqSzz17qqS3t0KsYyFlgEGc5JKvZ+lBzE8ok ag== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3k2ymd1xjj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Oct 2022 15:01:56 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29CDqJFu039776;
        Wed, 12 Oct 2022 15:01:55 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2171.outbound.protection.outlook.com [104.47.55.171])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3k2ynbgrpn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Oct 2022 15:01:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AEfUW+VtEoEzWXVELgpqPniepJAGDDF+va9bXk1xa1eeBrLmnS+HtN4dcHMAp2aF2A/XpBj9SmXg0gWO6NBhCnjCAIftAa6VK8OfcWdBQm3JgtQbC4gVJtiovFIMerYXEQPuuAhcwLJJDgGgis5JJoG+NbI3zZxdspxtuvaebrK8g8Y64CMNACMzp1JV2wsCUQYOk9yQIn3gI2s8y6m7VBtYnD2dJyLY1ogR77Yd4c17s8h92bibdTWWvPf/A4ajDinXrZg7kCcTovaLUXBR2EFV4D3CW7Vc6kPBn+1ENtv7cypi5kleQny2RhQp9dMTwLBiQrk6f7xSvbq/fVyE7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8UXMXO3HSHNoj2J/cdOtvLhAGpqBGkKwCIASszVBmsc=;
 b=b53b7MCH2NhHWVctx5KDUUArNZPO2rzVb0TGMovcZV3sZgIxNyUa1LIgqTV/E8K75oaQrTxs/nWF/20HYupXvjvmCvZTp9cfETbPm0MRZQXeSctXx2r5AJKsN9/OfMU5sbjMhe3VotLZJp7M4Jpuo7CGn3cwxHOLjT39Khs1/I+MQXF6RV2wxbggTb2AYZJX1dEF/9ZfnuldkID18jnrJpe1bovEp9luHC9aJho+xmke6KPoED7K842hXITfU+Rl0OEojjyhigdRrn0AEa4XeQfz4QBCuMqBqlbMVT5nk4gS7wsYIwRSJqaDZJ/M728E7+kqx1Ht+Kt9t+SipUYu/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8UXMXO3HSHNoj2J/cdOtvLhAGpqBGkKwCIASszVBmsc=;
 b=qJJKENL689Nks8wOSAq5mpMjgZEfk9bOD0iHgrwKBNLIqqjSPdqsPcdyo/A7g+ceszozSJKKwUQndyqSj4deBUGVPb0fsQlFWdkCnsf2oW7lRmKE3xZgrkyopK5/eo+Du3W5xvW1tPYVj8twYBghSQvJnlMxyylvY+Ze3dR/pCs=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BLAPR10MB5041.namprd10.prod.outlook.com (2603:10b6:208:30e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.22; Wed, 12 Oct
 2022 15:01:54 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5403:3164:f6c3:d48a]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5403:3164:f6c3:d48a%3]) with mapi id 15.20.5709.022; Wed, 12 Oct 2022
 15:01:53 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Neil Brown <neilb@suse.de>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v2 7/9] NFSD: Use rhashtable for managing nfs4_file
 objects
Thread-Topic: [PATCH v2 7/9] NFSD: Use rhashtable for managing nfs4_file
 objects
Thread-Index: AQHY2Z+f4KLIvxFyZE+pJJ7lJKAPUq4IWjWAgADUNACAALMrAIABAksA
Date:   Wed, 12 Oct 2022 15:01:53 +0000
Message-ID: <4004BFE1-C887-4A53-9512-8A264E0361FF@oracle.com>
References: <166507275951.1802.13184584115155050247.stgit@manet.1015granger.net>
 <166507324882.1802.884870684212914640.stgit@manet.1015granger.net>
 <166544739751.14457.9018300177489236723@noble.neil.brown.name>
 <EB08B095-BF02-4B5E-8CD2-12B0201328D2@oracle.com>
 <166553144435.32740.14940127200777208215@noble.neil.brown.name>
In-Reply-To: <166553144435.32740.14940127200777208215@noble.neil.brown.name>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|BLAPR10MB5041:EE_
x-ms-office365-filtering-correlation-id: c64a270a-3e69-4a1e-1758-08daac62b31a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 54+/xMh4mUXIiFPrljtRVG5HMMkdVc0b9jC/80ASFiX3FA6KymmrxDhfuP3wvcG8lnkgTeqssO4V6bCUOlnvaF/JYYmcOostPXCkJx/wV+KXqawh09GFVKAjTuYonGBzTHOE7sG9VPFpZVsCEQJbQDV17aAQuRIWtdhSFLnuce9BnvL/TxQBYj2greEDvPRI5W6HtMvCha2Ca25DzOK6dIGpidAzghSzxD+LieO2p+n0e7L8UEyZEcPUv6fM+IitIHg8I9n6sKG4iNLQzeKPK7AwUk0yH/fjpxIKhswCxUpng6mMJo3fBahg1OBsCqCgodmkRN0NjW9Cjaq10BK//TC4jVTtaD8Kww50swNyFAOod0vUtixEjG6rfKBojnHz+lamHqEUiO9PZlvQTSDq7PfynjscntMlCG6glb7hHd7aULmhU5/3hHyPq3gWiRQrioFBMI5/RYjX0GHBWfyGldKX4tRzXE1UVJHTuBkTFS8ejmniMcb3bOeKprD7lB3e/4ojrKslFI68d4xYK25WbODuUW8CZwFVRzkqom/e+oKLVIoItcbh14cW9vjJTFgnAmcgGR4VjUyorMue6lL+BxRZXtSo4k39oFDcn1vy7o4W8Pg5T8iCzpr+gFglK/6Y3B0R7ypIwt3QkLf0nJpsFrsMjGFxGYVHpag6WQZmEBwBc7RKLbSpluIiULoVh5c7yyTmjn0A+55UsCJZKgqQlLEW/hQkncoTOZhd5EGqc+Bntv4A8RVKff3Xdem+0BzILaGowPC17JzDb4KOpjW+iENXaltLseXeTCuLtrQfSoQPc3OcQMcL5NC1SQgEAy8hrfJWjlRk9ic37eSdJ2653Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(136003)(376002)(39860400002)(346002)(396003)(451199015)(91956017)(6506007)(41300700001)(83380400001)(8936002)(66476007)(66556008)(6512007)(26005)(53546011)(71200400001)(8676002)(4326008)(66446008)(64756008)(38070700005)(186003)(2616005)(86362001)(76116006)(33656002)(36756003)(66946007)(122000001)(5660300002)(478600001)(66899015)(966005)(316002)(38100700002)(2906002)(6916009)(6486002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?85EGY5ilJZ6fjfbvqYHSyAYCgYud7EGaSUNtyNVYLu8mEPKZnyfnUJQrID55?=
 =?us-ascii?Q?mXBh/crXJnQckb9eo0Pthfg7k35CuiTI/fErnhY1YzYVfvGG3O7++1MHL/Ka?=
 =?us-ascii?Q?1oKQDi5HHAiAO/6h0dc1fvod8VMi8gdHjwhjmxxGUe/3BNJJC2gDOxK+/BrW?=
 =?us-ascii?Q?8ibQ1RulVHLLLC9my/nHcNloRmnklnUTCRyUwyNBbycw5fpjbsMe4TULcD1Y?=
 =?us-ascii?Q?Q37X5u+4IXC1Y9gSxNsoBKO4STxuh7/UYzgBdnXB2MFnd6FtJXKUkfRaKNLE?=
 =?us-ascii?Q?UHo8YnvcydLu/Ioe72w0UlCELAlWwvKhx2UaGnMgnmdP/RiA2J9ZFYxKnFD5?=
 =?us-ascii?Q?T9rmogG2smMnbO/Ulkz02yxgFsTiGyhxNF5oRzcdTFa4SOcYCkMtDA7ms9G9?=
 =?us-ascii?Q?wMEuf0bJVCZ3udFbqVeinDfYfL6gXnnakS5B8kDTmLABGmqZnkj1OqMNkEka?=
 =?us-ascii?Q?/3UPYnAP/zuZJ3yr3EeFy4naBnuRrqcCar3QV5bLDMgPLxLlen8dp3W9zOxg?=
 =?us-ascii?Q?uvKdMn6z+u+qzdloKBaZc+P90+//AZSNQS7bHea+fRYrZRnvcLXMgS2e5gfE?=
 =?us-ascii?Q?k9acGGQkKF/mzTI+CZ9hv7iQghM6teGRu7FSKi3xRSZuaCF1YUf5aSgR1Djp?=
 =?us-ascii?Q?5OHqrdwi2hPt7KLal79H1rdDrp8o+Gipyt4CROOeubdMxDxIkH20x9qk84e2?=
 =?us-ascii?Q?QWYKnhLrXiQ6vMkv2fVTNJY7cqjpoORK0imkUTbWGuvtJ9gg3YG1OQ9Zk4af?=
 =?us-ascii?Q?WlvX82iva7CNbMWQ6o5LlUemFdgtcUqSMkIqkn2QBDMl50xPvOPyfbydVTJy?=
 =?us-ascii?Q?8913eySWPEsv9TwCqv8KbZ3Shl9b6RYNOaL8Qmk0pL1xfr97Zzt6gLBzCYYu?=
 =?us-ascii?Q?CcZkBdltYFtpVu7ut/m/NUc6DUJbrJtOdveuo9znlybBFE1+Hhg4vD/oa67d?=
 =?us-ascii?Q?5PI8/1fB2vTsN9NA2+dmT75saqkmss9+ktAT+8AywoUSvKJwFaOORSD9W4YP?=
 =?us-ascii?Q?Q+qhitqXikCNdWZ/KWcnM6y+auo4bwWZAs5quEeP1CuOSYND7voBHaG8EVWv?=
 =?us-ascii?Q?pgFU6yrP4Z34OZnyMubOsNtPCPAt3mL/tBTfaZhh88gc6KykngFY7YVxF3yi?=
 =?us-ascii?Q?dzvFMHfX18VFYdvwJ8mdnkPpm0fuBjwcniS0nfgdfuVYrMBJ7dtJxtTnQp4S?=
 =?us-ascii?Q?hs9iPypjThp2zHZkdRoFTBXRqLKLrAS7G/x5R4vLqONHy4GRj2msPuMTTE6K?=
 =?us-ascii?Q?40pHWdSCMhwdMjxySNj7E3KZGRHUtZxhlmVsjqOXqF4oP26ghBWogX15NhoC?=
 =?us-ascii?Q?7TnSg6RCEcqWUntf9UKeOVAIygtQgoVtcibyvjehMgPafR7PSf4sFN1ctfE0?=
 =?us-ascii?Q?M7zIPxG0MSKxywo15CUPdVtxcCXXh4FTGXQhR/oU/XiVOFmkH0dL56zK/s+0?=
 =?us-ascii?Q?jJoKLuIn2DG6OX4ic4joVoFy8UgXE0PxWMVRckv7txZadTdkerjUGkFTdEWI?=
 =?us-ascii?Q?ptfq87ivIoQxV5+n7BEgBI1C00qHKSF3d8KsjPkY4L11Lwcpx9j4HpvSSJyU?=
 =?us-ascii?Q?ty0BQ2nclLs31XTZ01tMrdaj++IXmcDdThV02ZP0kPISaQCy861pakARZfHP?=
 =?us-ascii?Q?eQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9BC23CE408D49B4E9513AC610FB77A17@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c64a270a-3e69-4a1e-1758-08daac62b31a
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2022 15:01:53.7638
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: v7EEOYmJRgvyi+N93m0hZTsQUIgZ7GXSiJJV4qKkFLjjZbX2ubjvxkNVyFCNxVCXBuHQQwFjQ84zJ6XxFXsVmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5041
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-12_07,2022-10-12_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 malwarescore=0 mlxscore=0 spamscore=0 bulkscore=0 mlxlogscore=999
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210120099
X-Proofpoint-GUID: cYekvWnVjMUiAw4AKy2AFkYBt3jYugUA
X-Proofpoint-ORIG-GUID: cYekvWnVjMUiAw4AKy2AFkYBt3jYugUA
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Oct 11, 2022, at 7:37 PM, NeilBrown <neilb@suse.de> wrote:
>=20
> On Tue, 11 Oct 2022, Chuck Lever III wrote:
>>> On Oct 10, 2022, at 8:16 PM, NeilBrown <neilb@suse.de> wrote:
>>>=20
>>> On Fri, 07 Oct 2022, Chuck Lever wrote:
>>>>=20
>>>> -static unsigned int file_hashval(struct svc_fh *fh)
>>>> +/*
>>>> + * The returned hash value is based solely on the address of an in-co=
de
>>>> + * inode, a pointer to a slab-allocated object. The entropy in such a
>>>> + * pointer is concentrated in its middle bits.
>>>=20
>>> I think you need more justification than that for throwing away some of
>>> the entropy, even if you don't think it is much.
>>=20
>> We might have that justification:
>>=20
>> https://lore.kernel.org/linux-nfs/YrUFbLJ5uVbWtZbf@ZenIV/
>>=20
>> Actually I believe we are not discarding /any/ entropy in
>> this function. The bits we discard are invariant.
>>=20
>=20
> Ok, I can accept that this:
>=20
> +	k =3D ptr >> L1_CACHE_SHIFT;

> I searched for ">> *L1_CACHE_SHIFT".  Apart from the nfsd
> filecache you mentioned I find two.  One in quota and one in reiserfs.
> Both work with traditional hash tables which are more forgiving of
> longer chains.
> Do you have other evidence of this being a common trope?


This approach is based on the hash function in fs/inode.c,
which uses integer division instead of a shift.

 509 static unsigned long hash(struct super_block *sb, unsigned long hashva=
l)
 510 {
 511         unsigned long tmp;
 512=20
 513         tmp =3D (hashval * (unsigned long)sb) ^ (GOLDEN_RATIO_PRIME + =
hashval) /
 514                         L1_CACHE_BYTES;
 515         tmp =3D tmp ^ ((tmp ^ GOLDEN_RATIO_PRIME) >> i_hash_shift);
 516         return tmp & i_hash_mask;
 517 }


> only discards invariant bits, but how can you justify this:
>=20
> +	k &=3D 0x00ffffff;
>=20
> ??

After shifting an address, the top byte generally contains
invariant bits as well.


> And given that you pass it all to jhash anyway, why not just pass all of
> it?

I don't think this is a big deal, but these functions are
basically the same as what was recently merged without
complaint. It's not a high priority to revisit those.

It might be worth a clean-up to share this hash function
between the two hash tables... at that point we might
consider removing the extra mask.


>> And, note that this is exactly the same situation we just merged
>> in the filecache overhaul, and is a common trope amongst other
>> hash tables that base their function on the inode's address.
>>=20
>>=20
>>> Presumably you think hashing 32 bits is faster than hashing 64 bits.
>>> Maybe it is, but is it worth it?
>>>=20
>>> rhashtable depends heavily on having a strong hash function.  In
>>> particular if any bucket ends up with more than 16 elements it will
>>> choose a new seed and rehash.  If you deliberately remove some bits tha=
t
>>> it might have been used to spread those 16 out, then you are asking for
>>> trouble.
>>>=20
>>> We know that two different file handles can refer to the same inode
>>> ("rarely"), and you deliberately place them in the same hash bucket.
>>> So if an attacker arranges to access 17 files with the same inode but
>>> different file handles, then the hashtable will be continuously
>>> rehashed.
>>>=20
>>> The preferred approach when you require things to share a hash chain is
>>> to use an rhl table.
>>=20
>> Again, this is the same situation for the filecache. Do you
>> believe it is worth reworking that? I'm guessing "yes".
>=20
> As a matter of principle: yes.
> rhashtable is designed to assume that hash collisions are bad and can be
> changed by choosing a different seed.
> rhl_tables was explicitly added for cases when people wanted multiple
> elements to hash to the same value.
>=20
> The chance of it causing a problem without an attack are admittedly
> tiny.  Attacks are only possible with subtree_check enabled, or if the
> underlying filesystem does something "clever" with file handles, so
> there wouldn't be many situations where an attack would even be
> possible.  But if it were possible, it would likely be easy.
> The cost of the attack would be a minor-to-modest performance impact.
>=20
> So it is hard to argue "this code is dangerous and must be changed", but
> we have different tools for a reason, and I believe that rhl-tables is
> the right tool for this job.

Agreed. I wasn't suggesting it's an emergency situation, but it's
something that should get fixed at some point if there's a problem
with it, even a minor one.

I think I stopped at the non-list variant of rhashtable because
using rhl was more complex, and the non-list variant seemed to
work fine. There's no architectural reason either file_hashtbl
or the filecache must use the non-list variant.

In any event, it's worth taking the trouble now to change the
nfs4_file implementation proposed here as you suggest.


--
Chuck Lever



