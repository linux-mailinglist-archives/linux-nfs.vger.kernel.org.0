Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8999057388A
	for <lists+linux-nfs@lfdr.de>; Wed, 13 Jul 2022 16:16:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230281AbiGMOQM (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 13 Jul 2022 10:16:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229978AbiGMOQM (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 13 Jul 2022 10:16:12 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E344B255BB
        for <linux-nfs@vger.kernel.org>; Wed, 13 Jul 2022 07:16:10 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26DDDrYe011695;
        Wed, 13 Jul 2022 14:16:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=oeeZIMGAvrlDVvwirRNtm+dS4pvMVYcUhyAi5zEzBjY=;
 b=fXhm7Pxr88wCrqEAyiIGm9M0G3RRLKn4H8zbLtZ1zUROSDumUGNTscrToR7GYBfdJF0J
 VKSuCn0z7CKP7kqSykhyOgl5fScIyh91HOVfpyVhK/bpTcAc62Vf2hQM7iZzQzl/Xyds
 bnmJ9i2lPMAMyeiBhwzw8q3Zwgy3fmUj2D9wKYJD53R+bnUowluVOKZV6NRuqy0D7pbQ
 QhAruNpFT5XLuplifbedUAJOrpC0wELZ4mdtJkQ1bVfeK7O0KO9zQWk7iMH/x7LeBH+7
 HdCmDdVeMjPqpofneoAS5pDymplwTaeNv9kJgMWtKJOII6UkmdgwpWSkhU03sT/AECPq 0g== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3h71r1a0by-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Jul 2022 14:16:02 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 26DEBcXo017586;
        Wed, 13 Jul 2022 14:16:01 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2102.outbound.protection.outlook.com [104.47.55.102])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3h70452tag-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Jul 2022 14:16:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LpGqOevVh07YbxDjhCe3S1fAxO1yqrQu4pRaKDYZSNtN0lONNKuircv3tKW+h5EYc0loTmu7HPBPHWUpS0KpDVWMmpccfJPInnWgtQ6jmwiK6UMo4ua4hdHtNPq2NwoEXZn4AuOw5jrTgX5sJuLou4CLpUg8okyKtn/SjR3sKyNVnRoZV0wavlFasilADblnjE0ZMHo5mfBFF5rzNmYY9iZb6h/W3W/96Yd6lpd63tvzH2qgV+2WuovMcFWRG+aESyDnTh6Fq2/r1iywdTNK/rZrtlGSvIgQ94POkwA7M8JPkvPpJ4w65BohTsBLHB/tWIsQKKueeWrOj/M6YYymYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oeeZIMGAvrlDVvwirRNtm+dS4pvMVYcUhyAi5zEzBjY=;
 b=QzIpI60POivvkSZptT8rkppwmC71ICJUmNDZ8AKTQB6c6EzXShN6+NbVJGr2R3yGxsVFOO1oIXavzD8noQmDkJq7BeGMUHrIjJiZj8cXSlu+RiVvUY04W3hBxHcEp2PfoYcNGnxPZR0vp04yetwn2CUZay/lpyVg8IbWR9DqjGP7B5TuelEQ3zkmlJnCachceATdO/TANys9KrGFPUB+kg+O/nX0yAaA0hawSh/34m3i5GQoR5vk7hsw4Qt69VGokn0AoIZAOO8N39qBM0zAy7LPSTi6AQ9c+TXL0Tl5uBeWGNHcFmvUOc/DScunzscKGTumFH5DurB9rcxeqoPcfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oeeZIMGAvrlDVvwirRNtm+dS4pvMVYcUhyAi5zEzBjY=;
 b=igBgJVtKteCG7qlpOD9OT9MjYL1EdcFthBBKvTQ1cHd5K58bHiVm3Qu1kST0dQ7qwEjGT23uXeeebhNznpq8gEdkOzF3Au6B652xvbC4FuzBNSjWWR7OLrrGjdoDD3MmCV17w0UsvQOygA1YqEEojNDurFttSwviak3BbWjKmjI=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH0PR10MB5628.namprd10.prod.outlook.com (2603:10b6:510:fb::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.12; Wed, 13 Jul
 2022 14:15:59 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::9920:1ac4:2d14:e703]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::9920:1ac4:2d14:e703%7]) with mapi id 15.20.5417.026; Wed, 13 Jul 2022
 14:15:58 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Neil Brown <neilb@suse.de>
CC:     Jeff Layton <jlayton@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 0/8] NFSD: clean up locking.
Thread-Topic: [PATCH 0/8] NFSD: clean up locking.
Thread-Index: AQHYkO+nUhzdndZueEy9RTo7pT1nKa1xiSYAgAiEbACAAMTsgIAA7tMAgACi9AA=
Date:   Wed, 13 Jul 2022 14:15:58 +0000
Message-ID: <13CEFBB0-45FB-4051-8F69-B41DC40CBD52@oracle.com>
References: <165708033167.1940.3364591321728458949.stgit@noble.brown>
 <3FF88D5A-9DBF-4115-A31C-6C6A888F272F@oracle.com>
 <165759318889.25184.8939985512802350340@noble.neil.brown.name>
 <3C945625-ED72-4CC1-9CC0-F354FEF0C2E4@oracle.com>
 <165768676476.25184.1334928545636067316@noble.neil.brown.name>
In-Reply-To: <165768676476.25184.1334928545636067316@noble.neil.brown.name>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.100.31)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 09783d1f-9146-480a-c746-08da64da3569
x-ms-traffictypediagnostic: PH0PR10MB5628:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XI23ZpcYvZdathudZmXGRqc4V/OvNUTjqO9ZW5/6Up30b7L1cRqPIdU9W1iCO91jnttTsp4lNkcmEVUTMHCrOTrAowwvvguKAn5q6jqty4yW3OBUj0R6h5kkVP64gwfjqzd2ZJZDbRQTKfsCTMjlL3UCuDCraVwbMeBuVrJDJV/mgjvLbHTzAIMY8xPpZVLmLF03DCPxkvZDCQHHHeCCcBrPeFqDADhiDQeiuqmwyUvnwIAgBfuxSkANSOPLeh0JGY1Ec1Gvqxo7cJIuIpct+u3C2wQT1GkPJJBmT0/0ZZuT/wD+2im3LEaqP/DuyfIiLCtDvuq4pczvFaVqNO5kgJ396hUUv/LXep+PfzmU9MFG/dSd8u558TlBdnZUD/j//o1/JrcMv9OshubxhfDPh+dtsijCqvpk/9itQ2OQv/08y5XE3dzlhs6StM2IUwrohBdIjLnrA/hjT/YAWTntUFcVI6dOwcsnsEhJqXrhLjxD6z6zGQW3MTNDwTkWn+Nu5n9nnxj8DwKGdTkU3DaXL8kJO72l9zy2yCO+sn8wg4rutrrqwamu2WhG1eOM2jfUaGbyES3VY7uDMN1YgayFTykQ1fZEFOQ7TkOFNrKallb2LEIMsk8cAAWiJ+yG97pjTa8CTH5/7HxLyueS4rBXJdbGa2JTe2NMfHZ6NlArXiVNHctlsAZ8FuJhYip+mHJoUqIAllqj2TcGQcMN2l22L8hePlGgrJskgmR/eYlH0DYEHYG8dmRfx7jDJHQl94MAcGlQ+coUNn/DTPLYUIR08vOHAfUhylWMNeC7ra/GbQTu8AsXwhSxVay/BnoNL6WxmIHFZ0C3y88hy5DB/Rm+ioOmSEH6ecE//8g9WJS5MLM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(366004)(396003)(376002)(136003)(346002)(33656002)(41300700001)(71200400001)(4326008)(38100700002)(2616005)(6486002)(36756003)(2906002)(26005)(86362001)(53546011)(6506007)(316002)(478600001)(8936002)(54906003)(38070700005)(5660300002)(6916009)(6512007)(186003)(91956017)(66946007)(66476007)(66556008)(66446008)(8676002)(122000001)(64756008)(76116006)(83380400001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?6hCmJboKbcIwLYt2/0ciiY8x+i+PybpsWOrc1EYXkG3XSiSF+2dKCo2X5iBu?=
 =?us-ascii?Q?rSkJg9lLw4dI03Bvwr8XGzLo2/Lu+AOiok86qH7Lrl1G8qPX/hpPo3k9aoSk?=
 =?us-ascii?Q?IN/7yVFQTMgZGwg2HcjxMbIsjXtyMPTXMDrWwq5B0xtN2fdqLhJps7Rrd7yH?=
 =?us-ascii?Q?+FMreCr0ZoeLk7Faq7pLYtVhWVjLktybTR6G8wRoNkocZI0we9SeyNoPYTme?=
 =?us-ascii?Q?aLk+mxNbcSjDovot9X+g5zyEBR+ccD02FB/aJ9E5UlWxR+TwYYzHixZgeyrX?=
 =?us-ascii?Q?ZYVqI+qpm6y22WxRCRdKrl5vnjgEW7xccj4t5Wn+RsThc5FKRmqLI8bDc654?=
 =?us-ascii?Q?Qd//raB72fJU7iqUf3oYV+hOAzGHXw5kFDEW+NyyDJTxqgl0OPh3q1Cv2kRw?=
 =?us-ascii?Q?NFMoYTzROA2ehv8H/qHrlC94hnOS6BwdgN8U2EGDEHJYUqGDcBc/xdxx7g1P?=
 =?us-ascii?Q?J9LXilfpl1czn4/ipVtEcNG1t6mS1o/mRHajLrXaQ94q1HqABB3mZ9RoKNM+?=
 =?us-ascii?Q?tINY6jtdUFf8Tj1Rzu9h4K1HPoqz16YC7J9IYFfmPoZY5bqWcSdO+0NF3BJw?=
 =?us-ascii?Q?joDrvFCxbmuURDjO8rFIkqYtqWzS0a7zUNuetISn2gMmixTJKlMOYHceK6Cu?=
 =?us-ascii?Q?6IEZF3qbSZG8dKnhm6eTAdDYeuao0QNJ4fxuOjTOYUnN4cVqH6dZAFDIJGr9?=
 =?us-ascii?Q?k5kisPN27hJdKTxaIcen0AIwPf3uhLLJrMQqzHXD4BSpE7yrwUYR3lJO0K+M?=
 =?us-ascii?Q?eYrr15WAUnDNXOZuYvgVzOGUYnV23I223DwgiyTLY5EPJdpRoA7AzNig7q6R?=
 =?us-ascii?Q?3RsUQ6+089YqiJIYp0XB0ChvUoQNLPIjC28Juau+ge2XJKWFrlbR0YRg+nFm?=
 =?us-ascii?Q?Mn6p7Dse/t9+WVVogjKpJsMCngV3dKXy65wkAb14MPrdo/UPn4sYg/DGtBGj?=
 =?us-ascii?Q?qibuvOnX7uMV5GNZFOqKYqW6EpgxtXhPQ+xRw1x59ttGAD9+2iF9Qy6AcOFE?=
 =?us-ascii?Q?ZBJPl4Sdpdu64swLk+p3ONjbVaB0ZLlU0oVerdHhejgVBla/G1eZUJ8Gh/Js?=
 =?us-ascii?Q?qC6JHDZ6W8dk2w0/e8ddIGYU/DLNnSUKD8E/rPNErjIQ+6mVwqJCwnO0MZpX?=
 =?us-ascii?Q?MMf/b1aj9p8JZOccz5XDngnMmAETE/pSf3FIMZcvBq8ndJMuK34JDoka+1Bz?=
 =?us-ascii?Q?mT8c9xIKFkcJmJj8t9XrUD4DmriXtxmY4ETxwhOboJ6DqjVW7LLM/KD7ttRa?=
 =?us-ascii?Q?kD1EBWmkvaF4mq4ea+8JvkiKn7j20xABSQhPMnKwotshgFcJCIsH0k9WLzO6?=
 =?us-ascii?Q?Kt8oUB2CA2zfVBhMI+1KcNkDCHD8P6Nc73zDeXZTYBGEr7dI+kdZPpN7hnyP?=
 =?us-ascii?Q?VcS65SXcuRxLIMoeOXBHvUeLpMEOqe2kEZRxSMHADcN4mXlWS+Rby6GggPUD?=
 =?us-ascii?Q?0MvSXzy4O6daLl9stsIiBSQJts//LROvThpiG8VRLjgfSwiLC/J1qNyo2pin?=
 =?us-ascii?Q?AgUj4KNTGiLmWKW5pX1yIKjw8hr2O43KZzj+evBI42+OS474O5Rt1+nZIFsr?=
 =?us-ascii?Q?uwOAC+rpGY2OxfJ1JgMgS5zheNCCjK7RGuPluTcsNI8Ow4GCZrG4pnoTFgWq?=
 =?us-ascii?Q?tQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E3BC673632B01441A184917FBA0B3314@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09783d1f-9146-480a-c746-08da64da3569
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2022 14:15:58.7650
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sr5qXXaVKy6i2zEpz4DyX0aDQ5SGVPDXRJg43jQfcs1zEy5jQnj+GcfdQbpMBPemOVQLvNf7QssSMj6pzMhDEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5628
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-07-13_03:2022-07-13,2022-07-13 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0 spamscore=0
 adultscore=0 suspectscore=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207130058
X-Proofpoint-ORIG-GUID: C9pzQecsVyBV-gTQQPqHoeeWuiFRhShA
X-Proofpoint-GUID: C9pzQecsVyBV-gTQQPqHoeeWuiFRhShA
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jul 13, 2022, at 12:32 AM, NeilBrown <neilb@suse.de> wrote:
>=20
> On Wed, 13 Jul 2022, Chuck Lever III wrote:
>>=20
>>> On Jul 11, 2022, at 10:33 PM, NeilBrown <neilb@suse.de> wrote:
>>>=20
>>> On Thu, 07 Jul 2022, Chuck Lever III wrote:
>>>>=20
>>>>> On Jul 6, 2022, at 12:18 AM, NeilBrown <neilb@suse.de> wrote:
>>>>>=20
>>>>> This series prepares NFSD to be able to adjust to work with a propose=
d
>>>>> patch which allows updates to directories to happen in parallel.
>>>>> This patch set changes the way directories are locked, so the present
>>>>> series cleans up some locking in nfsd.
>>>>>=20
>>>>> Specifically we remove fh_lock() and fh_unlock().
>>>>> These functions are problematic for a few reasons.
>>>>> - they are deliberately idempotent - setting or clearing a flag
>>>>> so that a second call does nothing. This makes locking errors harder,
>>>>> but it results in code that looks wrong ... and maybe sometimes is a
>>>>> little bit wrong.
>>>>> Early patches clean up several places where this idempotent nature of
>>>>> the functions is depended on, and so makes the code clearer.
>>>>>=20
>>>>> - they transparently call fh_fill_pre/post_attrs(), including at time=
s
>>>>> when this is not necessary. Having the calls only when necessary is
>>>>> marginally more efficient, and arguably makes the code clearer.
>>>>>=20
>>>>> nfsd_lookup() currently always locks the directory, though often no l=
ock
>>>>> is needed. So a patch in this series reduces this locking.
>>>>>=20
>>>>> There is an awkward case that could still be further improved.
>>>>> NFSv4 open needs to ensure the file is not renamed (or unlinked etc)
>>>>> between the moment when the open succeeds, and a later moment when a
>>>>> "lease" is attached to support a delegation. The handling of this loc=
k
>>>>> is currently untidy, particularly when creating a file.
>>>>> It would probably be better to take a lease immediately after
>>>>> opening the file, and then discarding if after deciding not to provid=
e a
>>>>> delegation.
>>>>>=20
>>>>> I have run fstests and cthon tests on this, but I wouldn't be surpris=
ed
>>>>> if there is a corner case that I've missed.
>>>>=20
>>>> Hi Neil, thanks for (re)posting.
>>>>=20
>>>> Let me make a few general comments here before I send out specific
>>>> review nits.
>>>>=20
>>>> I'm concerned mostly with how this series can be adequately tested.
>>>> The two particular areas I'm worried about:
>>>>=20
>>>> - There are some changes to NFSv2 code, which is effectively
>>>> fallow. I think I can run v2 tests, once we decide what tests
>>>> should be run.
>>>=20
>>> I hope we can still test v2... I know it is disabled by default..
>>> If we can't test it, we should consider removing it.
>>=20
>> The work of deprecating and removing NFSv2 is already under way.
>> I think what I'm asking is if /you/ have tested the NFSv2 changes.
>=20
> That's a question I can answer. I haven't. I will.

Just in case it's not clear by now, NFSv2 (and NFSv3)
stability is the reason I don't want to perturb the
NFSD VFS API code in any significant way unless it's
absolutely needed.


>>>> Secondarily, the series adds more bells and whistles to the generic
>>>> NFSD VFS APIs on behalf of NFSv4-specific requirements. In particular:
>>>>=20
>>>> - ("NFSD: change nfsd_create() to unlock directory before returning.")
>>>> makes some big changes to nfsd_create(). But that helper itself
>>>> is pretty small. Seems like cleaner code would result if NFSv4
>>>> had its own version of nfsd_create() to deal with the post-change
>>>> cases.
>>>=20
>>> I would not like that approach. Duplicating code is rarely a good idea.
>>=20
>> De-duplicating code /can/ be a good idea, but isn't always a good
>> idea. If the exceptional cases add a lot of logic, that can make the
>> de-duplicated code difficult to read and reason about, and it can
>> make it brittle, just as it does in this case. Modifications on
>> behalf of NFSv4 in this common piece of code is possibly hazardous
>> to NFSv3, and navigating around the exception logic makes it
>> difficult to understand and review.
>=20
> Are we looking at the same code?
> The sum total of extra code needed for v4 is:
> - two extra parameters:
> 	 void (*post_create)(struct svc_fh *fh, void *data),
> 	 void *data)
> - two lines of code:
> 	if (!err && post_create)
> 		post_create(resfhp, data);
>=20
> does that really make anything hard to follow?

The synopsis of nfsd_create() is already pretty cluttered.

You're adding that extra code in nfsd_symlink() too IIRC? And,
this change adds a virtual function call (which has significant
overhead these days) for reasons of convenience rather than
necessity.


>> IMO code duplication is not an appropriate design pattern in this
>> specific instance.
>=20
> I'm guessing there is a missing negation in there.

Yes, thanks.


>>> Maybe, rather than passing a function and void* to nfsd_create(), we
>>> could pass an acl and a label and do the setting in vfs.c rather then
>>> nfs4proc.c. The difficult part of that approach is getting back the
>>> individual error statuses. That should be solvable though.
>>=20
>> The bulk of the work in nfsd_create() is done by lookup_one_len()
>> and nfsd_create_locked(), both of which are public APIs. The rest
>> of nfsd_create() is code that appears in several other places
>> already.
>=20
> "several" =3D=3D 1. The only other call site for nfsd_create_locked() is =
in
> nfsd_proc_create()

But there are 15 call sites under fs/nfsd/ for lookup_one_len().
It's a pretty common trope.


> I would say that the "bulk" of the work is the interplay between
> locking, error checking, and these two functions you mention.

You're looking at the details of your particular change, and
I'm concerned about how much technical debt is going to
continue to accrue in an area shared with legacy protocol
implementation.

I'm still asking myself if I can live with the extra parameters
and virtual function call. Maybe. IMO, there are three ways
forward:

1. I can merge your patch and move on.
2. I can merge your patch as it is and follow up with clean-up.
3. I can drop your patch and write it the way I prefer.


>>>> - ("NFSD: reduce locking in nfsd_lookup()") has a similar issue:
>>>> nfsd_lookup() is being changed such that its semantics are
>>>> substantially different for NFSv4 than for others. This is
>>>> possibly an indication that nfsd_lookup() should also be
>>>> duplicated into the NFSv4-specific code and the generic VFS
>>>> version should be left alone.
>>>=20
>>> Again, I don't like duplication. In this case, I think the longer term
>>> solution is to remove the NFSv4 specific locking differences and solve
>>> the problem differently. i.e. don't hold the inode locked, but check
>>> for any possible rename after getting a lease. Once that is done,
>>> nfsd_lookup() can have saner semantics.
>>=20
>> Then, perhaps we should bite that bullet and do that work now.
>=20
> While this does have an appeal, it also looks like the start of a rabbit
> hole where I find have to fix up a growing collection of problems before
> my patch can land.

That's kind of the nature of the beast.

You are requesting changes that add technical debt with the
promise that "sometime in the future" that debt will be
erased. Meanwhile, nfsd_lookup() will be made harder to
maintain, and it will continue to contain a real bug.

I'm saying if there's a real bug here, addressing that should
be the priority.


> I think balance is needed - certainly asking for some preliminary
> cleanup is appropriate. Expecting long standing and subtle issues that
> are tangential to the main goal to be resolved first is possibly asking
> too much.

Fixing the bug seems to me (perhaps naively) to be directly
related to the parallelism of directory operations. Why do
you think it is tangential?

Asking for bugs to be addressed before new features go in
seems sensible to me, and is a common practice to enable the
resulting fixes to be backported. If you don't want to address
the bug you mentioned, then someone else will need to, and
that's fine. I think the priority should be bug fixes first.

Just to be clear, I'm referring to this issue:

>> NOTE: when nfsd4_open() creates a file, the directory does *NOT* remain
>> locked and never has. So it is possible (though unlikely) for the
>> newly created file to be renamed before a delegation is handed out,
>> and that would be bad. This patch does *NOT* fix that, but *DOES*
>> take the directory lock immediately after creating the file, which
>> reduces the size of the window and ensure that the lock is held
>> consistently. More work is needed to guarantee no rename happens
>> before the delegation.
>=20
> Interesting. Maybe after taking the lock, we could re-vet the dentry vs.
> the info in the OPEN request? That way, we'd presumably know that the
> above race didn't occur.



--
Chuck Lever



