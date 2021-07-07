Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12A2B3BF254
	for <lists+linux-nfs@lfdr.de>; Thu,  8 Jul 2021 01:13:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230492AbhGGXP6 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 7 Jul 2021 19:15:58 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:25128 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230288AbhGGXP5 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 7 Jul 2021 19:15:57 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 167NB9RA017144;
        Wed, 7 Jul 2021 23:13:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 cc : to : references : from : subject : in-reply-to : content-type :
 mime-version; s=corp-2020-01-29;
 bh=wdIXqUG+jvKE6WJXVmhcwsIqQZv0h1fvKg9SVJvqQgM=;
 b=VHZ3bYuXP1RYfLdliR4rSULkrhEpKU7ul81j92CaBkJjxdeqdML4Ssb6U+tGXyUvFD49
 ZnxfXCzU0o9U69qdH+z7LIICfmCCZOepIGrgpGcVNaMZc/fkoOHmsjX5DX4zfWiB3EpI
 r00sLSIfRXi6mrZOLGmYZTgHM5MfR9ub5MK4I4dAutgoQmIbq0gB579rcNEp16Hzrmn2
 W9Q97BVFvpaPHfJ9mYiCb49ZusjhVM9aHejGtgclBQgk5C7f8cdDgcL6sfiI1m7aACB0
 oxakDaKphZO8M5G+TCZSQIODVdOY/LxXihoxXVNu5Gdo8lPt095+szDH4rZBTyzLXCKe Qg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 39n7wrssb4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 07 Jul 2021 23:13:15 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 167NAWbQ127899;
        Wed, 7 Jul 2021 23:13:14 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2170.outbound.protection.outlook.com [104.47.55.170])
        by aserp3030.oracle.com with ESMTP id 39nbg31gkh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 07 Jul 2021 23:13:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tui/CHitQYu5q8Xgz1e331almx2/rbnEwvtAr1xtcB/emcEFdGtnbojNZNpeLYIScLaKjku33w73W3wvXbNrA8mv6UuPShLnFrERIJmNZgkahqBnuV1iOmEHzSumyCPzmLYoDGW2SYJVJxzfw2cc84rjJUD8i8o6Y1swP+lbO+Qn74GWL85tUIQPTpS+v9hxG2AwmXWJGho+QJHQrdgqurl4r4nje90tyiDC5XCpj2nxW4eQmuFKkXfCs5/AQXDE09q0r5FReTT1JQyfm69W3FhaQZ9yjQEpjcG67deP5VA7ND8ulkMfsyrLX5yl2nSiXbK3vBujf+g8bGBsg0ndlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wdIXqUG+jvKE6WJXVmhcwsIqQZv0h1fvKg9SVJvqQgM=;
 b=M2ug1T2mjHcsbIAl3HLXU/i5qdBnVD6eX1ZR6+rcKkzeOAxSfOmkgqDbyloXOadFIOiOw3D7/m+vUftqCejwOeUoaMtu1qVQ1SxHL6huIa/MCNzRQ8BxNOe9hmQCjFor6Yzj5WQL4Lznt6xKD9bHui/b69/jm0unXooly6EWYOa/56lLE7J9SR8ZSowHO8Z0J+KGNpHALpHaxBrPFHO70x9WLFp+H7o7hwN/BvvenyUbwZkTVpb0HFahk25mqBnTsiIA9UWXhqfIUUbt3uFTCLO+8CofFdeTBu4F6y32Y5XfRCFNpVbQNIWTQl7ziwhn/bavJLtpQLTsQ9rBKrn1uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wdIXqUG+jvKE6WJXVmhcwsIqQZv0h1fvKg9SVJvqQgM=;
 b=O7xNyeEG+1Vs+OEV0JNlUUUMIBrlWZ1+h3LD7MuS2mb70IyyBJ5nfVLu1ZgDA8bc593u8p8WnQ7ojXSjlkLtQy52T8iqXQWPxz/FtmegCj53jPsQxJVoBb1jq7uapN6Q+knD31byyslWwX3S360XLLABTCc5y5qBFwDxnRquK2s=
Authentication-Results: hammerspace.com; dkim=none (message not signed)
 header.d=none;hammerspace.com; dmarc=none action=none header.from=oracle.com;
Received: from BN0PR10MB5143.namprd10.prod.outlook.com (2603:10b6:408:12c::7)
 by BN6PR1001MB2129.namprd10.prod.outlook.com (2603:10b6:405:2d::34) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.27; Wed, 7 Jul
 2021 23:13:12 +0000
Received: from BN0PR10MB5143.namprd10.prod.outlook.com
 ([fe80::e9de:7386:9785:8f69]) by BN0PR10MB5143.namprd10.prod.outlook.com
 ([fe80::e9de:7386:9785:8f69%9]) with mapi id 15.20.4308.020; Wed, 7 Jul 2021
 23:13:12 +0000
Message-ID: <f270f45b-b5f9-5241-83c8-97c5f5482c56@oracle.com>
Date:   Thu, 8 Jul 2021 00:13:08 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.0a1
Cc:     Calum Mackay <calum.mackay@oracle.com>
Content-Language: en-GB
To:     Trond Myklebust <trondmy@hammerspace.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
References: <6cbd9cf8-49e9-868e-6452-1da2498c1358@oracle.com>
 <65fbd42ba59e539b1a15f9ea61cfd5664729ebec.camel@hammerspace.com>
From:   Calum Mackay <calum.mackay@oracle.com>
Organization: Oracle
Subject: Re: nfs_page_async_flush returning 0 for fatal errors on writeback
In-Reply-To: <65fbd42ba59e539b1a15f9ea61cfd5664729ebec.camel@hammerspace.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------MfHq3OsBRZlSAuKwTdN7c0CV"
X-ClientProxiedBy: LO3P265CA0015.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:bb::20) To BN0PR10MB5143.namprd10.prod.outlook.com
 (2603:10b6:408:12c::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.254.15] (90.247.82.180) by LO3P265CA0015.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:bb::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.21 via Frontend Transport; Wed, 7 Jul 2021 23:13:11 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3de4edcb-c95d-4813-a80c-08d9419ccacf
X-MS-TrafficTypeDiagnostic: BN6PR1001MB2129:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN6PR1001MB2129EA97AB6303980F68CCCBE71A9@BN6PR1001MB2129.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i1zRTe9CQUJ4etuHZLl61dDyuJ1goPDKX1buUgw2FRt+a9YvjW9Gb8Ix53I7VRaNDAP+8uS9Mkpg9kzPA72Um8wlwwSHrKxiIPJWQd2dlF1ZnVwzrMsXT1qfYJj7TqAQYgQPDoZC4RMBLq8Dl6d2HwH6T1g5KVp2+Yf1jMP4BxXhSONQUEY8+wPlhvg9/rlRNAQd4lUw8sUn0ezEV+1wYbT0vlOxhgIbz2JIch8ETwT5dRPDYcDGKEDd39qjdmwV4JpB4wvMy0TDAU45UMoXkpkgSrbtQD1KQmbnl5+d+44r0EfKw5cE+KIjK3sE6fGTiyxFPf5ywaT11abmbAzUu9DYuLE86tyNb+NL2XQz5i3XLt4M0Uu0Pn0fuInmZxfuZMgvbd6zpiGxI4H6/aYhxz1O5NTcaKSbWExURPiMQuRJ7R1+IZeXgRvz+U2ARvYaUeALXzC09cqfN5YnwuyYvYLgfrsDoP3WodNIkbaPhHm9fnJxREzCHSnnaC2cl/6PT1puugBFnRADoy7fpLWsSHVLcdkod+SaUi6ciDRO+/qWxrCSNAQU5mzFwe1jGvWt3G8WLX6Mv3H9O3fOuCmf6dvl7mNXz4kEZmmAQLGyHZpRPIZVsWfk7TVENbDePip7XyZqdlbZcR0MAVN9ZLzdI8jsCf/02Ad42Ys4PFZ9s7ez7dgCyqwePxen7pVCTmjKrUGQqtAWUxH9ZX57Ibi0mu697XT5AP6yqmVwmirHYDs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5143.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(396003)(366004)(346002)(376002)(39860400002)(38100700002)(2616005)(31686004)(6666004)(86362001)(186003)(5660300002)(316002)(33964004)(956004)(44832011)(36916002)(235185007)(83380400001)(6486002)(31696002)(8936002)(110136005)(53546011)(66476007)(66556008)(478600001)(4326008)(2906002)(66946007)(21480400003)(26005)(36756003)(8676002)(107886003)(16576012)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TThKR2VqR1R1YThmRTYwc0hVclpISUtSN25LMTd2NFNRNkd0cC9KZUJaZjRq?=
 =?utf-8?B?Z1ErbjhNR1BhR0wzWlY0NGV3c3NTVmhZSndWV3hCRm83OFFMNW4xVTJrTDBU?=
 =?utf-8?B?UnJKaVlyUnF2NWdqdUY2Vy8xd0UrRDFTa2ExeVBUcmo4VUpnbk84MUFLZGZP?=
 =?utf-8?B?WldaVWcyQmJrL1V1cVZBdGZpa3NlejFackhxWGEwMFhFaDNSbnlCTVB2U0x2?=
 =?utf-8?B?cjMxK0VPd0w2dTEzOWxqclZUMk1RUjg1bFBmRUMxd3dKb2NWVlVod3cwUkcx?=
 =?utf-8?B?Nndydk9VZGV4MWNZbURSZ3hhWnZ3UnZRQ293RDZhd08xU0p5WjR5WDZRd1dU?=
 =?utf-8?B?M1c3dGJsekNmeWRQdkMvdTRtL0owdHBiWWVoOTliODNoU3pxb2pOeVc0RGYx?=
 =?utf-8?B?UHc2Sk1tOUgyczhwYnB2aklVS2xSZTgvdFZzL3ptOGdXbzZKbittUDR2UXcw?=
 =?utf-8?B?YUp1a1lmd0lkTmw4T3RZUTZaaXhNTVVqZVpVT1ZjZ2puZnpHYVRZYStjeUpq?=
 =?utf-8?B?bm9CRkgzckt4eThuUnRLSVhiamtiYkgybC8xRHNGb0hYR2IxaFcyMm9ndm52?=
 =?utf-8?B?RHpxdENxcGRNSWRwREt6UWZRV3g5eGpncGNHWFNQRVF5bGJ5bXdWV3loVnUw?=
 =?utf-8?B?NWN6SW9iNzZjSlZ2dndxQklRc2FGbEt1Y2VMTEkwM1BybjJCTmMxWlNEaUpt?=
 =?utf-8?B?VHlWMGVIQkdvc2I2b2NPNjVWTlZ2aUl4V0ZpU3Z3ZzdWdldmRVBDM2hTeG1G?=
 =?utf-8?B?SUNldzM1K2FWT3ZRMUdWdXJleFJUYXFaeUNDNEM0YlM5U0xVM2xZWGdvYkc5?=
 =?utf-8?B?WmlMZUU3aW1ucHo4TnpRUmMvOUg2aW1SQVZmVTRQVkdsTjBWdDdBNFFhblIw?=
 =?utf-8?B?NDBRK1pBTi9SMUVqZ2o0eEIzdm5zcXd4Kzc5a3BkcVVZaFhRY216VDlHQnRo?=
 =?utf-8?B?WDBKOGpjdXhHNXdHMEFYQnFmakZGekcxZ1NULzJ3TTRBOFRZd0dRL1JoVGRu?=
 =?utf-8?B?dXJuT0pPT2swdSt0TnlCOG13SnFNdk85SlFTbzBiemhISkhWQ2FaNUtIcHgr?=
 =?utf-8?B?VERoODdyUDdxRGowMVl1ZnRRWEJIM1JERU0yQjAzRUJaZnBWK1Y4NW9TUHpr?=
 =?utf-8?B?ZnR0MFVVMEdFSWVZc2JyMWMyck95SzRVVFZKRkEwZTVoQmFDS3Z4WHo2QnVh?=
 =?utf-8?B?cFVjTk9PdS9mdVo1R2FoL0YyM2dhY2paUW54NWxVV09jTW5TVjNxL05jQk03?=
 =?utf-8?B?TStEZis0Y3dKczcrSXZGYkcyQ1VrNWd2SkcrRis3OEdFL2JJKzhSZit2UHlh?=
 =?utf-8?B?ZU9POFRKdGFlT3NweURNZXVZR1FjR0NtUUVwM2ZDSWd0RFlCdUl3eGJPTHJ0?=
 =?utf-8?B?ZUtiQ0VnUjM4bVRLRFI5ZGRqRjNWQXFPL3V3Zmpmc2VSMWYwRG5rbm1tMGVB?=
 =?utf-8?B?a1lKZ0dsMEt4bXptSVZQT2VkRmplZUVPU3NldjJ5UUJUdDhkWTVNWkRkUHRD?=
 =?utf-8?B?NWE2UVBOaktDdVZnKzZsdzVPNVZXZEgwK0QvMVMzK1pYL0ZUaXk3R0FOMWh3?=
 =?utf-8?B?RmtGdDRBMU4rdzJ5V3FJVHErZlYyNnlsbFhiWEVGWWtXclB3MHF6SnN5bnMr?=
 =?utf-8?B?MHBMVjdYTDZ2S0VGVGxaN0ROeXdveEs4aFEvMFVRdE9HZlFUbENaNGtQdFFi?=
 =?utf-8?B?OTZGTE5CYUN1c2RrN2RpczBvSVF3YkgyQ1AxbjJMLzBaK2NQY2VUS2JGQnB1?=
 =?utf-8?Q?sC7byNdVVT01JVeD4HU8iUhNSPlO2JXhzU3xUmY?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3de4edcb-c95d-4813-a80c-08d9419ccacf
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5143.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2021 23:13:12.4578
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OPu3wJ6r7LGUfuTIhDAUEoP5i3crkluLkmAq8CfzvTltiRQtoJHfVLb9XPoS1IgtnLDhfTQ9me376VYmUAXUIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1001MB2129
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10037 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 phishscore=0 adultscore=0 suspectscore=0 spamscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107070132
X-Proofpoint-ORIG-GUID: TsDiZ_He-XFnfrIBBjUwpRxVnK88w1t8
X-Proofpoint-GUID: TsDiZ_He-XFnfrIBBjUwpRxVnK88w1t8
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

--------------MfHq3OsBRZlSAuKwTdN7c0CV
Content-Type: multipart/mixed; boundary="------------s0EeLlly4JXzP4Zp40m1buX9";
 protected-headers="v1"
From: Calum Mackay <calum.mackay@oracle.com>
To: Trond Myklebust <trondmy@hammerspace.com>,
 "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Cc: Calum Mackay <calum.mackay@oracle.com>
Message-ID: <f270f45b-b5f9-5241-83c8-97c5f5482c56@oracle.com>
Subject: Re: nfs_page_async_flush returning 0 for fatal errors on writeback
References: <6cbd9cf8-49e9-868e-6452-1da2498c1358@oracle.com>
 <65fbd42ba59e539b1a15f9ea61cfd5664729ebec.camel@hammerspace.com>
In-Reply-To: <65fbd42ba59e539b1a15f9ea61cfd5664729ebec.camel@hammerspace.com>

--------------s0EeLlly4JXzP4Zp40m1buX9
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMDcvMDcvMjAyMSAxMTowMSBwbSwgVHJvbmQgTXlrbGVidXN0IHdyb3RlOg0KPiBPbiBX
ZWQsIDIwMjEtMDctMDcgYXQgMTk6NTEgKzAxMDAsIENhbHVtIE1hY2theSB3cm90ZToNCj4+
IGhpIFRyb25kLA0KPj4NCj4+IEkgaGFkIGEgcXVlc3Rpb24gYWJvdXQgdGhlc2UgdHdvIG9s
ZCBjb21taXRzIG9mIHlvdXJzLCBmcm9tIHY1LjAgJg0KPj4gdjUuMjoNCj4+DQo+PiAxNGJl
YmUzYzkwYjMgTkZTOiBEb24ndCBpbnRlcnJ1cHQgZmlsZSB3cml0ZW91dCBkdWUgdG8gZmF0
YWwgZXJyb3JzDQo+PiAoMg0KPj4geWVhcnMsIDIgbW9udGhzIGFnbykNCj4+DQo+PiA4ZmM3
NWJlZDk2YmIgTkZTOiBGaXggdXAgcmV0dXJuIHZhbHVlIG9uIGZhdGFsIGVycm9ycyBpbg0K
Pj4gbmZzX3BhZ2VfYXN5bmNfZmx1c2goKSAoMiB5ZWFycywgNSBtb250aHMgYWdvKQ0KPj4N
Cj4+DQo+PiBJIGFtIGxvb2tpbmcgYXQgYSBjcmFzaCBkdW1wLCB3aXRoIGEga2VybmVsIGJh
c2VkIG9uIGFuIG9sZGVyLXN0aWxsDQo+PiB2NC4xNCBzdGFibGUgd2hpY2ggZGlkIG5vdCBo
YXZlIGVpdGhlciBvZiB0aGUgYWJvdmUgY29tbWl0cy4NCj4+DQo+PiAgwqDCoMKgwqDCoMKg
wqAgUEFOSUM6ICJCVUc6IHVuYWJsZSB0byBoYW5kbGUga2VybmVsIE5VTEwgcG9pbnRlciBk
ZXJlZmVyZW5jZQ0KPj4gYXQNCj4+IDAwMDAwMDAwMDAwMDAwODAiDQo+Pg0KPj4gIMKgwqDC
oMKgIFtleGNlcHRpb24gUklQOiBfcmF3X3NwaW5fbG9jaysyMF0NCj4+DQo+PiAjMTAgW2Zm
ZmZiMTQ5M2Q3OGZjYjhdIG5mc191cGRhdGVwYWdlIGF0IGZmZmZmZmZmYzA4ZjE3OTEgW25m
c10NCj4+ICMxMSBbZmZmZmIxNDkzZDc4ZmQxMF0gbmZzX3dyaXRlX2VuZCBhdCBmZmZmZmZm
ZmMwOGUwOTRlIFtuZnNdDQo+PiAjMTIgW2ZmZmZiMTQ5M2Q3OGZkNThdIGdlbmVyaWNfcGVy
Zm9ybV93cml0ZSBhdCBmZmZmZmZmZmE3MWQ0NThiDQo+PiAjMTMgW2ZmZmZiMTQ5M2Q3OGZk
ZTBdIG5mc19maWxlX3dyaXRlIGF0IGZmZmZmZmZmYzA4ZGZkYjQgW25mc10NCj4+ICMxNCBb
ZmZmZmIxNDkzZDc4ZmUxOF0gX192ZnNfd3JpdGUgYXQgZmZmZmZmZmZhNzI4NDhiYw0KPj4g
IzE1IFtmZmZmYjE0OTNkNzhmZWEwXSB2ZnNfd3JpdGUgYXQgZmZmZmZmZmZhNzI4NGFkMg0K
Pj4gIzE2IFtmZmZmYjE0OTNkNzhmZWUwXSBzeXNfd3JpdGUgYXQgZmZmZmZmZmZhNzI4NGQz
NQ0KPj4gIzE3IFtmZmZmYjE0OTNkNzhmZjI4XSBkb19zeXNjYWxsXzY0IGF0IGZmZmZmZmZm
YTcwMDM5NDkNCj4+DQo+PiB0aGUgcmVhbCBzZXF1ZW5jZSwgb2JzY3VyZWQgYnkgY29tcGls
ZXIgaW5saW5pbmcsIGlzOg0KPj4NCj4+ICDCoMKgwqAgbmZzX3VwZGF0ZXBhZ2UNCj4+ICDC
oMKgwqDCoMKgwqAgbmZzX3dyaXRlcGFnZV9zZXR1cA0KPj4gIMKgwqDCoMKgwqDCoMKgwqDC
oCBuZnNfc2V0dXBfd3JpdGVfcmVxdWVzdA0KPj4gIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBuZnNfaW5vZGVfYWRkX3JlcXVlc3QNCj4+ICDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgc3Bpbl9sb2NrKCZtYXBwaW5nLT5wcml2YXRlX2xvY2spOw0KPj4NCj4+IGFuZCB3
ZSBjcmFzaCBzaW5jZSB0aGUgYXMgbWFwcGluZyBwb2ludGVyIGlzIE5VTEwuDQo+Pg0KPj4N
Cj4+IEkgdGhvdWdodCBJIHdhcyBhYmxlIHRvIGNvbnN0cnVjdCBhIHBvc3NpYmxlIHNlcXVl
bmNlIHRoYXQgd291bGQNCj4+IGV4cGxhaW4NCj4+IHRoZSBhYm92ZSwgaWYgd2UgYXJlIGlu
IChmcm9tIGFib3ZlKToNCj4+DQo+PiAgwqDCoMKgIG5mc19zZXR1cF93cml0ZV9yZXF1ZXN0
DQo+PiAgwqDCoMKgwqAgbmZzX3RyeV90b191cGRhdGVfcmVxdWVzdA0KPj4gIMKgwqDCoMKg
wqAgbmZzX3diX3BhZ2UNCj4+ICDCoMKgwqDCoMKgwqAgbmZzX3dyaXRlcGFnZV9sb2NrZWQN
Cj4+ICDCoMKgwqDCoMKgwqDCoCBuZnNfZG9fd3JpdGVwYWdlDQo+Pg0KPj4gYW5kIG5mc19w
YWdlX2FzeW5jX2ZsdXNoIGRldGVjdHMgYSBmYXRhbCBzZXJ2ZXIgZXJyb3IsIGFuZCBjYWxs
cw0KPj4gbmZzX3dyaXRlX2Vycm9yX3JlbW92ZV9wYWdlLCB3aGljaCByZXN1bHRzIGluIHRo
ZSBwYWdlLT5tYXBwaW5nIHNldA0KPj4gdG8gTlVMTC4NCj4+DQo+PiBJbiB0aGF0IHZlcnNp
b24gb2YgdGhlIGNvZGUsIHdpdGhvdXQgeW91ciBjb21taXRzIGFib3ZlLA0KPj4gbmZzX3Bh
Z2VfYXN5bmNfZmx1c2ggcmV0dXJucyAwIGluIHRoaXMgY2FzZSwgd2hpY2ggSSB0aG91Z2h0
IG1pZ2h0DQo+PiByZXN1bHQgaW4gbmZzX3NldHVwX3dyaXRlX3JlcXVlc3QgZ29pbmcgYWhl
YWQgYW5kIGNhbGxpbmcNCj4+IG5mc19pbm9kZV9hZGRfcmVxdWVzdCB3aXRoIHRoYXQgcGFn
ZSwgcmVzdWx0aW5nIGluIHRoZSBjcmFzaCBzZWVuLg0KPj4NCj4+DQo+PiBJIHRoZW4gZGlz
Y292ZXJlZCB5b3VyIHY1LjAgY29tbWl0Og0KPj4NCj4+IDhmYzc1YmVkOTZiYiBORlM6IEZp
eCB1cCByZXR1cm4gdmFsdWUgb24gZmF0YWwgZXJyb3JzIGluDQo+PiBuZnNfcGFnZV9hc3lu
Y19mbHVzaCgpICgyIHllYXJzLCA1IG1vbnRocyBhZ28pDQo+Pg0KPj4gd2hpY2ggYXBwZWFy
ZWQgdG8gY29ycmVjdCB0aGF0LCBoYXZpbmcgbmZzX3BhZ2VfYXN5bmNfZmx1c2ggcmV0dXJu
DQo+PiB0aGUNCj4+IGVycm9yIGluIHRoaXMgY2FzZSwgc28gd2Ugd291bGQgbm90IGVuZCB1
cCBpbiBuZnNfaW5vZGVfYWRkX3JlcXVlc3QuDQo+Pg0KPj4NCj4+IEJ1dCBJIHRoZW4gc3Bv
dHRlZCB5b3VyIGxhdGVyIHY1LjIgY29tbWl0Og0KPj4NCj4+IDE0YmViZTNjOTBiMyBORlM6
IERvbid0IGludGVycnVwdCBmaWxlIHdyaXRlb3V0IGR1ZSB0byBmYXRhbCBlcnJvcnMNCj4+
ICgyDQo+PiB5ZWFycywgMiBtb250aHMgYWdvKQ0KPj4NCj4+IHdoaWNoIGNoYW5nZXMgdGhp
bmdzIGJhY2ssIHNvIHRoYXQgbmZzX3BhZ2VfYXN5bmNfZmx1c2ggbm93IGFnYWluDQo+PiBy
ZXR1cm5zIDAsIGluIHRoZSAibGF1bmRlciIgY2FzZSwgYW5kIHRoYXQncyBob3cgdGhhdCBj
b2RlIHJlbWFpbnMNCj4+IHRvZGF5Lg0KPj4NCj4+DQo+PiBJZiBzbywgaXMgdGhlcmUgYW55
dGhpbmcgdG8gc3RvcCB0aGUgcG9zc2libGUgY3Jhc2ggcGF0aCB0aGF0IEkNCj4+IGRlc2Ny
aWJlDQo+PiBhYm92ZT8NCj4+DQo+Pg0KPj4gcGF0aCBJIHN1Z2dlc3QgYWJvdmU/IE9yIHBl
cmhhcHMgSSdtIG1pc3NpbmcgYW5vdGhlciBjb21taXQgdGhhdA0KPj4gc3RvcHMNCj4+IGl0
IGhhcHBlbmluZywgZXZlbiBhZnRlciB5b3VyIHNlY29uZCBjb21taXQgYWJvdmU/DQo+Pg0K
PiANCj4gSW4gb3JkZXIgZm9yIHBhZ2UtPm1hcHBpbmcgdG8gZ2V0IHNldCB0byBOVUxMLCB3
ZSdkIGhhdmUgdG8gYmUgcmVtb3ZpbmcNCj4gdGhlIHBhZ2UgZnJvbSB0aGUgcGFnZSBjYWNo
ZSBhbHRvZ2V0aGVyLiBJJ20gbm90IHNlZWluZyB3aGVyZSB3ZSdkIGJlDQo+IGRvaW5nIHRo
YXQgaGVyZS4gSXQgY2VydGFpbmx5IGlzbid0IHBvc3NpYmxlIGZvciBzb21lIHRoaXJkIHBh
cnR5IHRvIGRvDQo+IHNvLCBzaW5jZSBvdXIgdGhyZWFkIGlzIGhvbGRpbmcgdGhlIHBhZ2Ug
bG9jayBhbmQgSSdtIG5vdCBzZWVpbmcgd2hlcmUNCj4gdGhlIGNhbGwgdG8gbmZzX3dyaXRl
X2Vycm9yKCkgbWlnaHQgYmUgZG9pbmcgc28uDQo+IA0KPiBXZSBkbyBjYWxsIG5mc19pbm9k
ZV9yZW1vdmVfcmVxdWVzdCgpLCB3aGljaCByZW1vdmVzIHRoZSBzdHJ1Y3QNCj4gbmZzX3Bh
Z2UgdGhhdCBpcyB0cmFja2luZyB0aGUgcGFnZSBkaXJ0aW5lc3MsIGhvd2V2ZXIgaXQgc2hv
dWxkbid0IGV2ZXINCj4gcmVzdWx0IGluIHRoZSByZW1vdmFsIG9mIHRoZSBwYWdlY2FjaGUg
cGFnZSBpdHNlbGYuDQo+IA0KPiBBbSBJIG1pc3JlYWRpbmcgeW91ciBlbWFpbD8NCg0KdGhh
bmtzIHZlcnkgbXVjaCBUcm9uZDsgbXVjaCBtb3JlIGxpa2VseSBJIGFtIG1pc3JlYWRpbmcg
dGhlIGNvZGUgOikNCg0KDQpNeSB0aGVvcnkgd2FzIHRoYXQgd2UgaGF2ZSBuZnNfcGFnZV9h
c3luY19mbHVzaCBkZXRlY3RpbmcgDQpuZnNfZXJyb3JfaXNfZmF0YWxfb25fc2VydmVyLCBz
byBjYWxsaW5nIG5mc193cml0ZV9lcnJvcl9yZW1vdmVfcGFnZSANCih0aGlzIGlzIGFuIG9s
ZGVyIHY0LjE0LjcyLWlzaCBrZXJuZWwpLg0KDQpUaGF0IHdvdWxkIHRoZW4gZ2VuZXJpY19l
cnJvcl9yZW1vdmVfcGFnZSAtPiB0cnVuY2F0ZV9pbm9kZV9wYWdlIC0+IA0KdHJ1bmNhdGVf
Y29tcGxldGVfcGFnZSAtPiBkZWxldGVfZnJvbV9wYWdlX2NhY2hlDQoNCnRodXMsIGFzIHlv
dSBzYXksIHJlbW92aW5nIHRoZSBwYWdlIGZyb20gdGhlIHBhZ2UgY2FjaGUsIHdpdGggDQpf
X2RlbGV0ZV9mcm9tX3BhZ2VfY2FjaGUgY2xlYXJpbmcgcGFnZS0+bWFwcGluZy4NCg0KDQpX
aXRob3V0IHlvdXIgdjUuMCBjb21taXQsIG5mc19wYWdlX2FzeW5jX2ZsdXNoIHdpbGwgdGhl
biByZXR1cm4gMCwgdmlhIA0KbmZzX2RvX3dyaXRlcGFnZSwgbmZzX3dyaXRlcGFnZV9sb2Nr
ZWQsIG5mc193Yl9wYWdlIHRvIA0KbmZzX3RyeV90b191cGRhdGVfcmVxdWVzdCwgd2hpY2gg
dGhlbiByZXR1cm5zIE5VTEwgdG8gDQpuZnNfc2V0dXBfd3JpdGVfcmVxdWVzdC4NCg0KU2lu
Y2UgaXQgZGlkIG5vdCBzZWUgYW4gZXJyb3IsIG5mc19zZXR1cF93cml0ZV9yZXF1ZXN0IHdp
bGwgdGhlbiBjYWxsIA0KbmZzX2lub2RlX2FkZF9yZXF1ZXN0LCB3aGljaCBpdHNlbGYgdGhl
biBkZXJlZmVyZW5jZXMgdGhlIG1hcHBpbmc6DQoNCglzcGluX2xvY2soJm1hcHBpbmctPnBy
aXZhdGVfbG9jayk7DQoNCndoaWNoIGlzIHdoZXJlIHdlIGNyYXNoLg0KDQoNCk9idmlvdXNs
eSwgdGhlcmUgYXJlIGEgbnVtYmVyIG9mIGFzc3VtcHRpb25zIGluIHRoZSBhYm92ZSwgc28g
SSB0aG91Z2h0IA0KaXQgbXVzdCBqdXN0IGJlIGEgcG9zc2libGUgcGF0aCB0aGUgY29kZSBj
b3VsZCB0YWtlPw0KDQpEb2VzIHRoYXQgc291bmQgcGxhdXNpYmxlIChnaXZlbiB0aGF0IHY0
LjE0LjcyLWlzaCBjb2RlKT8NCg0KDQoNCkhvd2V2ZXIsIEkgbm90ZSB0aGF0IGluIGEgc3Vi
c2VxdWVudCB2NS4yIGNvbW1pdDoNCg0KMjI4NzZmNTQwYmRmIE5GUzogRG9uJ3QgY2FsbCBn
ZW5lcmljX2Vycm9yX3JlbW92ZV9wYWdlKCkgd2hpbGUgaG9sZGluZyBsb2Nrcw0KDQp5b3Ug
cmVtb3ZlIHRoZSBjYWxsIHRvIGdlbmVyaWNfZXJyb3JfcmVtb3ZlX3BhZ2UgZnJvbSANCm5m
c193cml0ZV9lcnJvcl9yZW1vdmVfcGFnZSgpLCBhbmQgdGhhdCBpcyBpdHNlbGYgdGhlbiBy
ZW5hbWVkIA0KbmZzX3dyaXRlX2Vycm9yKCksIGFzIHBhcnQgb2YgYSBsYXRlciB2NS4yIGNv
bW1pdDoNCg0KNmZiZGE4OWIyNTdmIE5GUzogUmVwbGFjZSBjdXN0b20gZXJyb3IgcmVwb3J0
aW5nIG1lY2hhbmlzbSB3aXRoIGdlbmVyaWMgb25lDQoNCg0KV2l0aG91dCB0aG9zZSBjb21t
aXRzLCBhbmQgYWxzbyB3aXRob3V0IHlvdXIgYWRqdXN0bWVudHMgdG8gDQpuZnNfcGFnZV9h
c3luY19mbHVzaCBJIG1lbnRpb25lZCBlYXJsaWVyLCBpcyBpdCBwb3NzaWJsZSB0aGF0IHRo
ZSBjb2RlIA0KcGF0aCBJIHByZXNlbnQgYWJvdmUsIHdoZXJlIHRoZSBwYWdlIC9pcy8gcmVt
b3ZlZCBmcm9tIHRoZSBwYWdlIGNhY2hlLCANCmNvdWxkIHJlc3VsdCBpbiB0aGUgY3Jhc2gg
d2Ugc2F3Pw0KDQoNCnRoYW5rcyBhZ2FpbiwNCmNhbHVtLg0K

--------------s0EeLlly4JXzP4Zp40m1buX9--

--------------MfHq3OsBRZlSAuKwTdN7c0CV
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEE1GBbrQYgx8o9Vdw+hSPvAG3BU+IFAmDmNQQFAwAAAAAACgkQhSPvAG3BU+KL
cRAA1aGovNGtLSISgSQyfi1niSNpHZ41qo61kW7SwHjOHgaSId5ChFs1ogDOdnkESM683N3RaRYv
dWOTJ9Ak54d1I9kT6UVjvUibQf6kDBXLw9Pxo2ej/MqrsGeZEKvGy6GNXAtUOFMJhPlP1vbNhp+I
lXr1vchoD/22RNirgCGOgUe4ZTPCVhdnnmfOinCVPvMlHAVNr3dVcic9fe2rmYC3/G6xzDG2TU+9
NZc2XRhypqy5JF++CPCeVCwktfv0KVMRZM5MWIwH9o0yHcLWmwF/bzYmCiYqkW6QT3xjsbRQsOBV
unRIm9RZjyFGDDM+/0yf2ndRMFEEhbUhIlsa+529F/sxxbp2/bqq2mMVrt9Uo98MiCJjDT8UJluT
QRiVacrDIiD3/VrOeAMnuLoC/J7qThp+DfbgULXvAYCx46zwLv6HcC009GBis0d5pntFK0MJwZUR
w9biRo68G3BthOB6+6Er2KxZvcB5L4+tTfFXx+/CXJ/179HgLiUxoEYSDQtQq+Z6Ug0C3yOM4vgg
kERZYEpKjKr0G0l5dD4AzTJhjRgybo/01QsKAf2qGi9B2kkJ3XoyKLQRk5jfnCAo6p/uaEcURe0S
42MoJL/DjkSvcqAMd9mWiG7pw0uGB8/eEIbPZhCbv1UIib/x5duSfv4/+hI9SygWi2/Nr3LI8oep
6mA=
=g7Km
-----END PGP SIGNATURE-----

--------------MfHq3OsBRZlSAuKwTdN7c0CV--
