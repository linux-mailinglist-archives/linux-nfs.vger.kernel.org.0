Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADEBC6869B0
	for <lists+linux-nfs@lfdr.de>; Wed,  1 Feb 2023 16:13:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232192AbjBAPN4 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 1 Feb 2023 10:13:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231712AbjBAPNd (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 1 Feb 2023 10:13:33 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAF966DFD1
        for <linux-nfs@vger.kernel.org>; Wed,  1 Feb 2023 07:12:52 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 311EO3sC012765;
        Wed, 1 Feb 2023 15:11:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=YkHv/VNkWBoRHZOpMY11MJnGeD+gGi8njV+SVrH/suo=;
 b=xXnPUugZRpYgZezNPrQSejH0D/KbBEnNwwiiAPJq+L5k4Te5b0BWXHF47Ciwi1xy6loH
 2HGztGmlXfg7LHYC2ELJQRSg6eeUUIyx/Sfucp0Y18Sep+mpmdeODRdgbDgMsWMszaiE
 6eDiKr9w7zTZ1aaHank+1P3o86CfmrpwotnavFFt8iryc8I3iXfEX8b2BAxMxpkce/lN
 HXkKG8VGHaiuaC4IvN4XB2kdeDGK6SkP0Llj20G+wJODD0JPh4IOYiutPQsHJ8xD+vkC
 hUnk+PEqvdKT3HkVnlo4OSLMDjfVXOw0IVwVoLVHQsN1TyM81QnrwYcFBQVDhtMRuSJ6 Hw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nfkfe0x4v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Feb 2023 15:11:41 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 311Dg6mR035900;
        Wed, 1 Feb 2023 15:11:41 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2043.outbound.protection.outlook.com [104.47.74.43])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3nct57mv1s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Feb 2023 15:11:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GRQXWYX+ZoB2XVNbBXFI9KAmWG3F2RlrxaU1RcdANHsWsgklSlVXUHplUYLX24C5LpkUsuJne0gVO/uTQ5ulRt/e4wMAJMxEX03T4Jw6nboIQwfEPSUYIjjnNQJArXdq7MqeZmwZ1tJuJ87v8+xMOCsExaPKB0lqc3jCus+dk4edlZeIP1v8D63v1ufyTtVD7KG9H4cpmH29oKwhruvVRZpFS2jZpKmXgL4jqyyTdk9Rd7DHuR1FACqcElTnSWSDSqRYhZlEPRzzynTGmRfWp3QDzW6tu/7pTtoBW7EGo1IFVdZc0LD9FXEFg7gN1/dHGC6/MsBZPLeWXKYSOm5qCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YkHv/VNkWBoRHZOpMY11MJnGeD+gGi8njV+SVrH/suo=;
 b=VkDAV5XBiZtyvIOEbyiPTjx5QBy1LchLQu0KxFzCyfwPEVOEzqA0RLVHkAhDw56Rb2BkB95uqkWlBIw6Y8csPrZtzh7ZSGi7moEGy1MIe287ogpxtwoQlbzWZ1W7LoR52rE+VQRnaw7FUI54xxW4quMlxzslTq5XSLMm3UGzYOjixSq444MrC4xVHloDk42OZdrsHzVwvJXOmwdWUyCQqIO1dPruz8sDOtwDzk/179jga6b4KqmTGnX1cGdkh7PLaJ7e+QUQSODkJbNDOMyp44EZCvE4kWyPSLUEOcLSH/v7hmowM6+7JxnU6kftxxZqq+TApaypJnjrFA/cXqzX8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YkHv/VNkWBoRHZOpMY11MJnGeD+gGi8njV+SVrH/suo=;
 b=VxdpMJ8XX/3Y7RYk6eYnXQEzWqpBn+iyVNCWIwwQNjupOORnx9heO7kciybppc8wQ/EQiLILkxFqMoN3MJc7zLDqflXRAlUG4ulr4Xis+xkLBxsgAq+7iUWro/A6cb0fn8OCtBxgRCGCVCuJyLQxTylytgrM2U7U7qVLEGlNHAY=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS7PR10MB5088.namprd10.prod.outlook.com (2603:10b6:5:3a2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.25; Wed, 1 Feb
 2023 15:11:38 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::96a2:2d53:eb8c:b5ed]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::96a2:2d53:eb8c:b5ed%4]) with mapi id 15.20.6064.025; Wed, 1 Feb 2023
 15:11:38 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Benjamin Coddington <bcodding@redhat.com>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: git regression failures with v6.2-rc NFS client
Thread-Topic: git regression failures with v6.2-rc NFS client
Thread-Index: AQHZNbksRLoeBCG00EyL+s5Kt9KD6665E+wAgAEfloA=
Date:   Wed, 1 Feb 2023 15:11:38 +0000
Message-ID: <B4F4936A-9E26-4226-9604-1030DA25F2C0@oracle.com>
References: <9A4A5673-691D-47EC-BC44-C43BE7E50A48@oracle.com>
 <D0404F55-2692-4DB6-8DD6-CAC004331AC1@redhat.com>
In-Reply-To: <D0404F55-2692-4DB6-8DD6-CAC004331AC1@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|DS7PR10MB5088:EE_
x-ms-office365-filtering-correlation-id: dbfec4a0-1b26-4712-4d27-08db04669dc8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4Sj/rGDBnqjb9kbEwnlJ+y8rJll8mWd2IYxWXFLZnV8CeOxRuWV0+snEPhimKZ44KMkCrBszUG+QslhDZ1M52bVLUWVtLVQZlHUhH2eX9BHMZtDPOakHhvmP+fMyALWcPoNQt/d30RslJQDyZjYU8pxxLO9KBczqZqSi+7jDU4NMJW+WuzUum19umVNZciAuRtNKevTJcLcHCEW75sr29QHeMvTAf0tTSeo0afWH4rmUV7z8p0bwR4a2kIZkfrtt+pkODCY+GygBm6STON2nQz5d7htGhBMBXorONNVSIXny/YcKUFM+AHnlwTUTvLchEj0eVtXVM/kUIhgvOe/22bYdUtd2LzEZDEC5+g4s1jV5BfxAj5ngS26JGczK1LsdYsTSRJ8AAt3W2LqA8HoSxQ9v9gjBqkznEGOVcjeF98RBVnkEk9MdBrYOo09zxmp5Xv9JemC/zJQpQn083ypP27YNGGw05y/cscyC5c7+GylWmoTK7Ydp5vuGNdT5ppmJU3daq9yKK6NALwBIJJAXXr/2mMpHDEKs5f5q5keo1zL9xIEb2//oP7ggIfLvauD7mE/uDqSMrLlqDi8i2FvKNXBf0UHiLEHlN8XCOGyCn3SZ+yVfStr2biqvZGhVcdhmkpj17+XTbDzwpBdzSJpsh1JpYLzIU78W8GyvXDVmedID+BPShA/wJZMKxlM74VIw0JQe0zLez9Md81EsAmWves4ZOGwW33mBYskaWVygxEdDAQuXlM/GlpCq53fBI0I+5cQIqHyTaQtWbso1Dv4H1A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(396003)(346002)(366004)(376002)(136003)(451199018)(2616005)(71200400001)(316002)(83380400001)(33656002)(2906002)(36756003)(38100700002)(122000001)(6506007)(53546011)(66446008)(64756008)(4326008)(6916009)(91956017)(66556008)(66946007)(76116006)(66476007)(966005)(6486002)(478600001)(186003)(26005)(6512007)(86362001)(41300700001)(8676002)(38070700005)(8936002)(5660300002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?EpF8WaOsryfVwiYqd4xu9Lr/S9WD/IRECbaGX/6msxaKZm0QR5AHY9Et/kwU?=
 =?us-ascii?Q?iZxsQDGNgo09tccOMz0Mjq/23vDAWeXk0AyJ/gYA5acdeCDCJ/+f9CZO5rec?=
 =?us-ascii?Q?3d8YTjBM7eYxwbEvUgD02J+8nVNbjUd5f146+cSKnTVl5JwCTev+/h5dBMA7?=
 =?us-ascii?Q?NwAF2HfWGjCax9wL/NSKM8FQBG3f5X+zHYh92ct4zDGcqW2v5pOYz+eIfxJD?=
 =?us-ascii?Q?zGFo0Ld3pQTAG0xwcmUGY7ULxaLe5WVZtaviOo8QiWHs3jKrzHFpyV+BaXeI?=
 =?us-ascii?Q?+Z4cMmyUepgUqyj3nqlEtcNXbqlsf7CWdIyIFS6fUuhFIjO7ZHtZNp1K92ls?=
 =?us-ascii?Q?h1QEfYcGxbsRGGRxfCmDJzAQcDacK0+PjpqOW7K2XuDdSuBjjaVSQNEwECKG?=
 =?us-ascii?Q?KKnF6SqpMFKzBgTZQxaVnk8lDeXmgfruO6KbSUk0uzqBx5oIMgubUxq4uZ56?=
 =?us-ascii?Q?xg0HzqigVL+clSYI2rtLB6eMz7yn/JJT8Frb2X6q2gq9MZIvNPjxhgjrITSV?=
 =?us-ascii?Q?KUkQId2B4JbrxuXdIbMgTIN9ZDUH1emuWo94PxHbyk5dDNIpj9iMmWWmx+un?=
 =?us-ascii?Q?DCge3od3jBC6+fpA71lP76ZnYS/tt5Hs+28/PC8pV+kDvmstodQqJGU7rUOo?=
 =?us-ascii?Q?Lz9i383qvOdOtDJ7NbJ07e5MoLGNbsqZznARbBKZJczzWefZbg/kAoHNZ+id?=
 =?us-ascii?Q?TwLo1OoRLKb6a/rz3Diy8RNj8FPKRS5VnYVRrnOfOsfgd0e6x/kPkinCxSNG?=
 =?us-ascii?Q?WtxjHfwqLz9JFZwL7sOPMFPvAsrEDmQj0AIPq0uBDN+1dikf5VjxMkIWuE7n?=
 =?us-ascii?Q?Sq3LN0YUDxHjc9nbpEB769nfyjBYaXLTe47i/wV5izG2jBcyTbGhSQTD/wco?=
 =?us-ascii?Q?XB77JmyN6vm0AyXahfjqlm6JYcTqa3U6TlK7Rxsdx1/2T1g/Y0DldWH5e9Co?=
 =?us-ascii?Q?ba18jlh6TZnPVQIo8hao7Lhj2ClTDf3w08eAfNGojzLuYxe0VsJZNDqUmt23?=
 =?us-ascii?Q?t582kF2ktfTIav5GgdEVYUJtNfJCagPpka3zKCU8JUODQTuqPqd8Aiw/0U6q?=
 =?us-ascii?Q?NNuwNwd9Fe7dp5ksML8sZNxaDCQRWKpM0kN96vmZ2pSUsJnUJ7Nr4VQ7JUDf?=
 =?us-ascii?Q?MnHgcak8Iu11oj5q6n7bQPodbGotXmkvcGK4c80BEutb6k7sGWkUCTgVnNe1?=
 =?us-ascii?Q?LMaLjbjE/CJLnimeO1ti612PEq8xiNSV0+y9PMmnl7IkhNgqLIOHlsLHOK82?=
 =?us-ascii?Q?Kqrc0AckfVqpXeNFvByn3hWDPHD0Rq/9qnM0XxCm9zzbhf2G3PxFO+jHjVig?=
 =?us-ascii?Q?2qiNWkUKyvOWvltOaTBa+isGJQKay6YkS2+ZR1m/aBQ2GHbU/qr1yZZw2UE0?=
 =?us-ascii?Q?+RXJ4/UWrXiy865/UEWAem06yr+dA47LcflDVkTv1JleI+inTxSR7V0HIRqz?=
 =?us-ascii?Q?ykh5sXx8qetG6YSR/lg8PpzImuFt5Jqji9PNBnZpW4OR7x6q4XcHMbRNraww?=
 =?us-ascii?Q?yL26eDcLRkryYoX/B9ij89CblfvvlGv/9kGYix6TrE+qG8BkNmuh7wqHR488?=
 =?us-ascii?Q?uUrwkOi8A6CoCuZK1jKQZjpTu0LrBhkeXCGx0QUqE4uJ7J/3MUoRjRWu3yom?=
 =?us-ascii?Q?oA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D5DFEF84279B5E4CB64EB458C2110834@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: uWstw08gx1j2enGeKKeynooY7jht+47FUV0VkEe4J14JQ9olSFUS+xLYMzsnOHCjemt/evsR43JXx9R4gGzl2CfrRmdCpPdEfWcxMsL4uGYce4zQaGfZp33lAECLmvYQe2xvvf7fdNZdj4Ga6YW3MwOETRHGKziaN4iVac8ckPhnAayUag4Mr6OoVzZmy4klJ24kRH3mz471htXJZjvFG6N7eBT2+Vuy9TKH3Uc8prQYTeHBFit4vekQcfL7gxPb4IiRAl9ofqYzPSBYOij8cViUUj9GMOAL9eKZk/mVbcanhQ132+5i6aUAoYP5T1P/o/Z8fKURtGDuy9SSA9IFzFyJAIUTPhZj01cjGar+O082YdJQMLjeghAcShHvKthg/FFVpDM1vZA/2wghVbo/cSxSgbIfsV7ZhgDQeQ5fyEpyqmpFUzO/muI2+xM4nAz5r4nnVPFcurQ7YvSo4NGnedcpNYYuWQv5SRVAzZJo6/n6DCJ68pXcYG3C2ObdzuzajJrLa+aVJ8sdeqpNoyXqXBkB39N6QW2834mGPjhUDVncQQ/+HWJZY5W2kc0iaSijRvN219rZKpZankjcCC+OHHruyMmYsxJiC7GfUlgL4OCGLADJyT0Lt20Krh/fQ/Tdujg0m+CjfEyO6Z3rfbwBce9MSGxt2bLiYo/XRD2Qf31EBJIzO1+mWrAyP7SzuzPs5oLG0VEDucO8AM27kc63ubTltsx6nhdV9Z3OM1dbouGerT/GZb42iNUt89fuRchIqNlJe/kEuPU3jT8BHwriC0FS/9v4L6bO31EiVmQWgPo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbfec4a0-1b26-4712-4d27-08db04669dc8
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Feb 2023 15:11:38.2757
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CxlEkvYLkBq92mP5LC5aaNzEXUaf+1PBoiZVrRgithSqnFzddmfofNEqSsCfohXy+rho3Ny26vzSS7SgGNwA5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5088
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-01_04,2023-01-31_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 bulkscore=0
 suspectscore=0 mlxlogscore=962 mlxscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302010130
X-Proofpoint-GUID: 7Xn0HABZzQFyXB3UvXDOp16gJ0Muyqqx
X-Proofpoint-ORIG-GUID: 7Xn0HABZzQFyXB3UvXDOp16gJ0Muyqqx
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jan 31, 2023, at 5:02 PM, Benjamin Coddington <bcodding@redhat.com> wr=
ote:
>=20
> On 31 Jan 2023, at 16:15, Chuck Lever III wrote:
>=20
>> Hi-
>>=20
>> I upgraded my test client's kernel to v6.2-rc5 and now I get
>> failures during the git regression suite on all NFS versions.
>> I bisected to:
>>=20
>> 85aa8ddc3818 ("NFS: Trigger the "ls -l" readdir heuristic sooner")
>>=20
>> The failure looks like:
>>=20
>> not ok 6 - git am --skip succeeds despite D/F conflict
>> #
>> #               test_when_finished "git -C df_plus_edit_edit clean -f" &=
&
>> #               test_when_finished "git -C df_plus_edit_edit reset --har=
d" &&
>> #               (
>> #                       cd df_plus_edit_edit &&
>> #
>> #                       git checkout f-edit^0 &&
>> #                       git format-patch -1 d-edit &&
>> #                       test_must_fail git am -3 0001*.patch &&
>> #
>> #                       git am --skip &&
>> #                       test_path_is_missing .git/rebase-apply &&
>> #                       git ls-files -u >conflicts &&
>> #                       test_must_be_empty conflicts
>> #               )
>> #
>> # failed 1 among 6 test(s)
>> 1..6
>> make[2]: *** [Makefile:60: t1015-read-index-unmerged.sh] Error 1
>> make[2]: *** Waiting for unfinished jobs....
>>=20
>> The regression suite is run like this:
>>=20
>> RESULTS=3D some random directory under /tmp
>> RELEASE=3D"git-2.37.1"
>>=20
>> rm -f ${RELEASE}.tar.gz
>> curl --no-progress-meter -O https://mirrors.edge.kernel.org/pub/software=
/scm/git/${RELEASE}.tar.gz
>> /usr/bin/time tar zxf ${RELEASE}.tar.gz >> ${RESULTS}/git 2>&1
>>=20
>> cd ${RELEASE}
>> make clean >> ${RESULTS}/git 2>&1
>> /usr/bin/time make -j${THREADS} all doc >> ${RESULTS}/git 2>&1
>>=20
>> /usr/bin/time make -j${THREADS} test >> ${RESULTS}/git 2>&1
>>=20
>> On this client, THREADS=3D12. A single-thread run doesn't seem to
>> trigger a problem. So unfortunately the specific data I have is
>> going to be noisy.
>=20
> I'll attempt to reproduce this and see what's up.  This is an export of
> tmpfs?

Sorry for the delayed response... yes, it is a tmpfs export. I was
trying to recall whether this reproduced on other filesystem types,
and it was just far enough in the past that I couldn't be sure I
remembered correctly.


> If so, I suspect you might be running into tmpfs' unstable cookie
> problem when two processes race through nfs_do_filldir().. and if so, the
> cached listing of the directory on the client won't match a listing on th=
e
> server.

Thanks !

--
Chuck Lever



