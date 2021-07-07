Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B30493BF2A3
	for <lists+linux-nfs@lfdr.de>; Thu,  8 Jul 2021 01:57:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbhGGX7z (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 7 Jul 2021 19:59:55 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:46108 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229519AbhGGX7y (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 7 Jul 2021 19:59:54 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 167NvCtU032310;
        Wed, 7 Jul 2021 23:57:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 cc : subject : to : references : from : in-reply-to : content-type :
 mime-version; s=corp-2020-01-29;
 bh=KMEIY1Q9c2//WkQ+9mdAAXaIANjmHWFnskUiuy3RyWQ=;
 b=HpA67fKxelk6V8QUULnCoF+XnYgIX5QctJVQ2jIz4yQBwCatdrtZ2J2AorZr0GNVeXiT
 6GlF0zOmzps2yLDyGZf6KMlCfhnZ9g4VoQbTg22pPMtCMdxUgMcXSOuSPdlgIHPNyWk2
 AsJog2ttNyJ0VmGQpGMwgTpJbDJtkaj2UZSMA2z91zW0e+Ctq0KEXAa6+bqZq+6v7tlU
 rlD70kEX8n3MkhIXEUCFCaYusBgPIb9AJlV+yFULGOk8B3BFbk5gXJZR6qvY76+il1ty
 jZUPgadht8knYeSjxTh4MvMTxny0D3C1ysG1rE0s+W5r203kyN9MQdItiO+m+Sw6lP8n Pw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 39m3mhd7ck-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 07 Jul 2021 23:57:11 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 167Nugpw156603;
        Wed, 7 Jul 2021 23:57:10 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
        by userp3020.oracle.com with ESMTP id 39k1ny4exq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 07 Jul 2021 23:57:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R3wL9oGNfrhway4XryJzX4XTQR7uXA+ihOlcj7NQnAlqBkMmR6UF00VV49OteEjWMI0+SihDvUcYXKl1KWcsnTUrWv4fq0E4jNBDH56KibnoWNBbwMQaIFfmtKJBKOPcemeILfRm3DSzj0oFTVgDO/g+IlCB85jFYOkS3AtXN8BTqGobNRFelcVNxNh+jiNoBW1tjlIyo5qoAd6VMtLKWjwyuRLDHb867mU2dz4DwuN69yb4Tp+ky+pjCJ9pPIyFX/ay4il3o/b7w1IiBIev+l+CfZCnVl6+7UZtTBcx9abd+hpfKsZg4Qz9Wjr/rqzV+EBhWpKq127WSMXx49/uOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KMEIY1Q9c2//WkQ+9mdAAXaIANjmHWFnskUiuy3RyWQ=;
 b=EQXSqjzYBWeQcGWGr8BsB3VOWNLPpwDp8w5Shjdi0TIN8e7S3EdYEaBImR6sl7Vh/tR1vBO47mSskTvTGDRbEubmwgcPs52wYh/8DI3KHFMhk+uSDQcRkDpklwzQZJLW1j7JrJ+URXGjgkyICNqHIy5mHLE/hreMhSVynFYtGMby+mQDT5vkiN5ufx3y4kkIjqDq29UKMDtnnZq4B9B3ezVW2ZDH7rWybFwp78s5/PQfGdT1hBqEyoswPBZ/x8bRF2H4eVQB6URYP5okfmTADTiGYuST/rSBtHQCOIODgoL7gv16wY8cDs/6K3Lbcv6ndtxVShZclsCw/H896OsBkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KMEIY1Q9c2//WkQ+9mdAAXaIANjmHWFnskUiuy3RyWQ=;
 b=Lu55Ttv5fnwwp3tALnFhi1eozbPz7j7ytrpeBcIdNk0oQPEmSah/uPlPAECIFKhonGRVgOw2dYtvNJ1ML7tDZfIwNUN/PkCcZR0FF8ZJAqCAJfqQ2RODQdiRSeg619yvIlnihhp0yjmEnRADtzzb6LsS0a/7zoTm2Irs6SGW8Gg=
Authentication-Results: hammerspace.com; dkim=none (message not signed)
 header.d=none;hammerspace.com; dmarc=none action=none header.from=oracle.com;
Received: from BN0PR10MB5143.namprd10.prod.outlook.com (2603:10b6:408:12c::7)
 by BN6PR10MB1441.namprd10.prod.outlook.com (2603:10b6:404:43::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.20; Wed, 7 Jul
 2021 23:57:07 +0000
Received: from BN0PR10MB5143.namprd10.prod.outlook.com
 ([fe80::e9de:7386:9785:8f69]) by BN0PR10MB5143.namprd10.prod.outlook.com
 ([fe80::e9de:7386:9785:8f69%9]) with mapi id 15.20.4308.020; Wed, 7 Jul 2021
 23:57:07 +0000
Message-ID: <d806f1b6-30ff-812e-e37b-090e11a650f0@oracle.com>
Date:   Thu, 8 Jul 2021 00:57:03 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.0a1
Cc:     Calum Mackay <calum.mackay@oracle.com>
Subject: Re: nfs_page_async_flush returning 0 for fatal errors on writeback
Content-Language: en-GB
To:     Trond Myklebust <trondmy@hammerspace.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
References: <6cbd9cf8-49e9-868e-6452-1da2498c1358@oracle.com>
 <65fbd42ba59e539b1a15f9ea61cfd5664729ebec.camel@hammerspace.com>
 <f270f45b-b5f9-5241-83c8-97c5f5482c56@oracle.com>
 <421b63750c5d80bdda1184c854d7ab3489c7ff01.camel@hammerspace.com>
From:   Calum Mackay <calum.mackay@oracle.com>
Organization: Oracle
In-Reply-To: <421b63750c5d80bdda1184c854d7ab3489c7ff01.camel@hammerspace.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------AeGv4vwf0fpFyNxucFoQw2Ij"
X-ClientProxiedBy: LO4P123CA0389.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18f::16) To BN0PR10MB5143.namprd10.prod.outlook.com
 (2603:10b6:408:12c::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.254.15] (90.247.82.180) by LO4P123CA0389.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:18f::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.20 via Frontend Transport; Wed, 7 Jul 2021 23:57:07 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b804b835-4289-4b5e-d053-08d941a2eda1
X-MS-TrafficTypeDiagnostic: BN6PR10MB1441:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN6PR10MB14419E8EFB5F9BDB45994CC7E71A9@BN6PR10MB1441.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M2ucxDewc4Y969XYviiYFW3pMQuMDe3ONLDZHBmRRt/bKY0MEUMvNKTFIJL5Nbrw/Qvoo0kIoUYwuhGRIIcdIh7btkXN3zM+es9GU5KYkzqV/ptidOCZgPIo0G4xV30ZZBmm/JC2iY6MfuwwgB1OPCiUkrAGU+zSNZa0WZCi8p2ChxCwLiBArfclhXSFUiGhHAe5euEiMHwGHoLIXL2NsZJmsSKeO/ayoKnWRnphh20FzqNSCz2CzhSnPvjyYMSonuvo/L5j+IK6YUw895KGGqhtzQMRaaNpUB1XYGHGl+x9AVD6Nrb9Du3Hkle1Ibe6Nymrg/MMOTxBlwjVh7gbXraY7b9VXRYYttAvnW9uYk98fKzEXxHlYbqeqmGRA8F5nhekdRsMS4Mi/4fPhKNZagcPRIt1H4Z3esrSIPF9Ta67YCv2/cKJrbbXEdTeTwXkLHzhUTpV+JYNCOiVm1OohBJSGDOsLfEoiuIbEerWRNP/mP05OH/wT+ttm8RO3B8sdUGMqin6X3viPvZEmJltxUusQeE9YqM6b5LFQq1QGvng7JK0ELG9GlfIlus5gJRwfH3GfkFslDDywPheYgzMzq9H/WiqejlwrTRXS300GUS60zxxcekCMe7l6g8Oq2zImZqAel8EdHqdCqGHQOGuAO31wQEOJ2rLp123G/bwRZtXyK3X3WNZPbEZu7W5xTaupVcULSCKgN4m+j85IQh2OMbgwY96yDj8LtZcmZCJ58/jaijQsQkDv0uGUT+EIU4m
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5143.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(346002)(376002)(396003)(39860400002)(136003)(235185007)(66476007)(186003)(31686004)(31696002)(33964004)(83380400001)(956004)(8936002)(86362001)(66556008)(26005)(8676002)(478600001)(2616005)(38100700002)(21480400003)(5660300002)(44832011)(2906002)(53546011)(316002)(4326008)(66946007)(110136005)(36916002)(6666004)(6486002)(16576012)(36756003)(107886003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UEZseFkyRkJ5QmhOaXZUNnQ3UzN0bStGZW81Tjd5R2ZhVWNoTzhBOVN0VEdK?=
 =?utf-8?B?SzYxZ3E2S3BUY3dJNzRZMzJqUlllR2h2Q01aRm1KQ21ZWTMzN3l4VFpEb1dR?=
 =?utf-8?B?WjhUZ0ZDK3lCcTdZS3QrZDdSaWxRSEtmWUFCSWdzdDNGQ2xxdTVYcHpJVlFH?=
 =?utf-8?B?bnNPV3RuRk5oVVRsQWhqdk5qR3MrYlYvSUlsSkwxZ21SYWd5dk16bW9qc2tO?=
 =?utf-8?B?U0Y1MEc4dVIzUThJTkExaVlBT2FCaGtROEdDNDRHRjk2MTVRTFA5NmcrVHJF?=
 =?utf-8?B?di96OUFwelRlbkZYYkpZTjQ2enR0c1dEUW5JaXhXbzgySWRMUjI4MllIVldl?=
 =?utf-8?B?Yk5Gd0wwZytPVmVwam1CdURndzR4bFRSVGFyOG1jRGgyemd5OTBuU2JBelRT?=
 =?utf-8?B?TUZscklIWGRncTJaZ2hiZHBXSi9wWjdiTWh1ekNrMFNQaXk1cXB0L3V3cTNG?=
 =?utf-8?B?dC9MaU95NEpHN0pYK0VqVzB1RFlsR29rRVJzcEJJUHV2ZTZEVFVPWWlVOTBa?=
 =?utf-8?B?U1MvVEN6ekV4cGpVMmo5cVkrcWwyVzlCWU02Z2RTeXdCTGNUSjhTR201YVND?=
 =?utf-8?B?Zy93aWc5OGdLV3BkeEpOT0l6N1kybk92WTkzTG1BeTVXaWZncjFMOUxXYjgy?=
 =?utf-8?B?VFhZaDh3cEVIYy9TYzYvcWl4U2tETGlFQzBjbW9ZN0wvRHNsK3hDcTVPTy9R?=
 =?utf-8?B?VzhzaGZyQmRnU056TjRqWW0wZXdnYnlmWUlaWGphd2VVYkVYV2lwVmRLNDVm?=
 =?utf-8?B?VkRTTGtFYXBuRHdQby9WNWpqUWZEck9IU3JYeDJreE4rWkpnY2hDWVJVM3h1?=
 =?utf-8?B?VExCaEFUaXN0VGhZd3J3M2kvdGlIV2VOMnpMRjB6NW1qT3JleUxTVEgxMEVa?=
 =?utf-8?B?WFhnblFEZW5jU1N0WjdoNVJOSE5XSURzemw4aEJ3UlVIQWhVVkYzcy8yZjBY?=
 =?utf-8?B?SDd5ZzU3M3ZNRUdxcHFZUUhIMkJnUWpOUEgwTjJidGtPV3Qwd0h5VkRUMG5L?=
 =?utf-8?B?eXR5ZFZRWU14QmVoTHc1MDNHMExLU1FEQVM0TUNJc2NlYjdiTEE0Nk1qdzlz?=
 =?utf-8?B?QXJEVFhHSEZsZURjZFYxSmYyalNZNFdwT21HQWlaQml1ZXo0ek56M2NYWDJS?=
 =?utf-8?B?eEpsRFNXeVcyazNqVzVDTlN1UnFhNmJvRGlHdGI5clJxVUlqcUhsbWtCTFdF?=
 =?utf-8?B?TW9UU25FU1dNb0pxK0ZvYnJjenJFTXVJa2tSblVnelF6MFIxK0V1SW1yNTN5?=
 =?utf-8?B?a1dXNndjL0pTVWFCYXZmeTFVMy93TXI5S0hrV08xR2t6c2RESkRjUGZrZ0hQ?=
 =?utf-8?B?YnIzQ1ltZDlmUDVmR3VHMXBqdVFZc3V3enRGemZUM1NDaUdzYWw5elNESlhw?=
 =?utf-8?B?UG5tcGEvelhnKzloQTBJWHJKZ2w0T3J5SzA1eEJBY1Vsazk3NGdwbnZQWFlS?=
 =?utf-8?B?ajdoa1VGcXJJeUJlbXVrOHNldWRRak9WOS9Gb0F1Y1JyNXd4V3VjUDN0Qms5?=
 =?utf-8?B?SE1BdUZ4bzdra0VvTDkrN2J3ZUlKV1Vqbmt2OGg1aWNZUWZ2OVlLdklZNXhz?=
 =?utf-8?B?dkdjbHpoUkhxZDhhRlY2a2QyRVFGaFozaWxELyt2SExrVDR4L3M0RXQvSzVV?=
 =?utf-8?B?alpCbGxsbVp3SlRxN3ZUUm95dUhMQ2tYZ1FVMUkzdEllUDVJRXhZYlVQYkdI?=
 =?utf-8?B?Ly8wV3F0TjJDNWVreDBmbkV4enpUWTFGeG51WkFRZjIwU29HaGZyMGNjZFJI?=
 =?utf-8?Q?81yYModXzpFiWHMQQ7HbkN3WVoxS+g9GT5UYC2I?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b804b835-4289-4b5e-d053-08d941a2eda1
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5143.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2021 23:57:07.8346
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gXZbEhGx7o1qz0hSKG+7gPhT75SVOxG0qBAMjcbpTNRmHYHZKpuoISLqTDrWYLBTZUVwFDOHzl+0+PtNk3pmzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR10MB1441
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10037 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 phishscore=0
 adultscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2107070136
X-Proofpoint-GUID: OoCbg95hR9-5c4TWmEf7GaoHGkBl_g8d
X-Proofpoint-ORIG-GUID: OoCbg95hR9-5c4TWmEf7GaoHGkBl_g8d
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

--------------AeGv4vwf0fpFyNxucFoQw2Ij
Content-Type: multipart/mixed; boundary="------------cov8tvrprKHuqiYdd2nHwAHM";
 protected-headers="v1"
From: Calum Mackay <calum.mackay@oracle.com>
To: Trond Myklebust <trondmy@hammerspace.com>,
 "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Cc: Calum Mackay <calum.mackay@oracle.com>
Message-ID: <d806f1b6-30ff-812e-e37b-090e11a650f0@oracle.com>
Subject: Re: nfs_page_async_flush returning 0 for fatal errors on writeback
References: <6cbd9cf8-49e9-868e-6452-1da2498c1358@oracle.com>
 <65fbd42ba59e539b1a15f9ea61cfd5664729ebec.camel@hammerspace.com>
 <f270f45b-b5f9-5241-83c8-97c5f5482c56@oracle.com>
 <421b63750c5d80bdda1184c854d7ab3489c7ff01.camel@hammerspace.com>
In-Reply-To: <421b63750c5d80bdda1184c854d7ab3489c7ff01.camel@hammerspace.com>

--------------cov8tvrprKHuqiYdd2nHwAHM
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMDgvMDcvMjAyMSAxMjo1MCBhbSwgVHJvbmQgTXlrbGVidXN0IHdyb3RlOg0KPiBPbiBU
aHUsIDIwMjEtMDctMDggYXQgMDA6MTMgKzAxMDAsIENhbHVtIE1hY2theSB3cm90ZToNCj4+
IE9uIDA3LzA3LzIwMjEgMTE6MDEgcG0sIFRyb25kIE15a2xlYnVzdCB3cm90ZToNCj4+PiBP
biBXZWQsIDIwMjEtMDctMDcgYXQgMTk6NTEgKzAxMDAsIENhbHVtIE1hY2theSB3cm90ZToN
Cj4+Pj4gaGkgVHJvbmQsDQo+Pj4+DQo+Pj4+IEkgaGFkIGEgcXVlc3Rpb24gYWJvdXQgdGhl
c2UgdHdvIG9sZCBjb21taXRzIG9mIHlvdXJzLCBmcm9tIHY1LjANCj4+Pj4gJg0KPj4+PiB2
NS4yOg0KPj4+Pg0KPj4+PiAxNGJlYmUzYzkwYjMgTkZTOiBEb24ndCBpbnRlcnJ1cHQgZmls
ZSB3cml0ZW91dCBkdWUgdG8gZmF0YWwNCj4+Pj4gZXJyb3JzDQo+Pj4+ICgyDQo+Pj4+IHll
YXJzLCAyIG1vbnRocyBhZ28pDQo+Pj4+DQo+Pj4+IDhmYzc1YmVkOTZiYiBORlM6IEZpeCB1
cCByZXR1cm4gdmFsdWUgb24gZmF0YWwgZXJyb3JzIGluDQo+Pj4+IG5mc19wYWdlX2FzeW5j
X2ZsdXNoKCkgKDIgeWVhcnMsIDUgbW9udGhzIGFnbykNCj4+Pj4NCj4+Pj4NCj4+Pj4gSSBh
bSBsb29raW5nIGF0IGEgY3Jhc2ggZHVtcCwgd2l0aCBhIGtlcm5lbCBiYXNlZCBvbiBhbiBv
bGRlci0NCj4+Pj4gc3RpbGwNCj4+Pj4gdjQuMTQgc3RhYmxlIHdoaWNoIGRpZCBub3QgaGF2
ZSBlaXRoZXIgb2YgdGhlIGFib3ZlIGNvbW1pdHMuDQo+Pj4+DQo+Pj4+ICDCoMKgwqDCoMKg
wqDCoMKgIFBBTklDOiAiQlVHOiB1bmFibGUgdG8gaGFuZGxlIGtlcm5lbCBOVUxMIHBvaW50
ZXINCj4+Pj4gZGVyZWZlcmVuY2UNCj4+Pj4gYXQNCj4+Pj4gMDAwMDAwMDAwMDAwMDA4MCIN
Cj4+Pj4NCj4+Pj4gIMKgwqDCoMKgwqAgW2V4Y2VwdGlvbiBSSVA6IF9yYXdfc3Bpbl9sb2Nr
KzIwXQ0KPj4+Pg0KPj4+PiAjMTAgW2ZmZmZiMTQ5M2Q3OGZjYjhdIG5mc191cGRhdGVwYWdl
IGF0IGZmZmZmZmZmYzA4ZjE3OTEgW25mc10NCj4+Pj4gIzExIFtmZmZmYjE0OTNkNzhmZDEw
XSBuZnNfd3JpdGVfZW5kIGF0IGZmZmZmZmZmYzA4ZTA5NGUgW25mc10NCj4+Pj4gIzEyIFtm
ZmZmYjE0OTNkNzhmZDU4XSBnZW5lcmljX3BlcmZvcm1fd3JpdGUgYXQgZmZmZmZmZmZhNzFk
NDU4Yg0KPj4+PiAjMTMgW2ZmZmZiMTQ5M2Q3OGZkZTBdIG5mc19maWxlX3dyaXRlIGF0IGZm
ZmZmZmZmYzA4ZGZkYjQgW25mc10NCj4+Pj4gIzE0IFtmZmZmYjE0OTNkNzhmZTE4XSBfX3Zm
c193cml0ZSBhdCBmZmZmZmZmZmE3Mjg0OGJjDQo+Pj4+ICMxNSBbZmZmZmIxNDkzZDc4ZmVh
MF0gdmZzX3dyaXRlIGF0IGZmZmZmZmZmYTcyODRhZDINCj4+Pj4gIzE2IFtmZmZmYjE0OTNk
NzhmZWUwXSBzeXNfd3JpdGUgYXQgZmZmZmZmZmZhNzI4NGQzNQ0KPj4+PiAjMTcgW2ZmZmZi
MTQ5M2Q3OGZmMjhdIGRvX3N5c2NhbGxfNjQgYXQgZmZmZmZmZmZhNzAwMzk0OQ0KPj4+Pg0K
Pj4+PiB0aGUgcmVhbCBzZXF1ZW5jZSwgb2JzY3VyZWQgYnkgY29tcGlsZXIgaW5saW5pbmcs
IGlzOg0KPj4+Pg0KPj4+PiAgwqDCoMKgwqAgbmZzX3VwZGF0ZXBhZ2UNCj4+Pj4gIMKgwqDC
oMKgwqDCoMKgIG5mc193cml0ZXBhZ2Vfc2V0dXANCj4+Pj4gIMKgwqDCoMKgwqDCoMKgwqDC
oMKgIG5mc19zZXR1cF93cml0ZV9yZXF1ZXN0DQo+Pj4+ICDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCBuZnNfaW5vZGVfYWRkX3JlcXVlc3QNCj4+Pj4gIMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIHNwaW5fbG9jaygmbWFwcGluZy0+cHJpdmF0ZV9sb2NrKTsNCj4+
Pj4NCj4+Pj4gYW5kIHdlIGNyYXNoIHNpbmNlIHRoZSBhcyBtYXBwaW5nIHBvaW50ZXIgaXMg
TlVMTC4NCj4+Pj4NCj4+Pj4NCj4+Pj4gSSB0aG91Z2h0IEkgd2FzIGFibGUgdG8gY29uc3Ry
dWN0IGEgcG9zc2libGUgc2VxdWVuY2UgdGhhdCB3b3VsZA0KPj4+PiBleHBsYWluDQo+Pj4+
IHRoZSBhYm92ZSwgaWYgd2UgYXJlIGluIChmcm9tIGFib3ZlKToNCj4+Pj4NCj4+Pj4gIMKg
wqDCoMKgIG5mc19zZXR1cF93cml0ZV9yZXF1ZXN0DQo+Pj4+ICDCoMKgwqDCoMKgIG5mc190
cnlfdG9fdXBkYXRlX3JlcXVlc3QNCj4+Pj4gIMKgwqDCoMKgwqDCoCBuZnNfd2JfcGFnZQ0K
Pj4+PiAgwqDCoMKgwqDCoMKgwqAgbmZzX3dyaXRlcGFnZV9sb2NrZWQNCj4+Pj4gIMKgwqDC
oMKgwqDCoMKgwqAgbmZzX2RvX3dyaXRlcGFnZQ0KPj4+Pg0KPj4+PiBhbmQgbmZzX3BhZ2Vf
YXN5bmNfZmx1c2ggZGV0ZWN0cyBhIGZhdGFsIHNlcnZlciBlcnJvciwgYW5kIGNhbGxzDQo+
Pj4+IG5mc193cml0ZV9lcnJvcl9yZW1vdmVfcGFnZSwgd2hpY2ggcmVzdWx0cyBpbiB0aGUg
cGFnZS0+bWFwcGluZw0KPj4+PiBzZXQNCj4+Pj4gdG8gTlVMTC4NCj4+Pj4NCj4+Pj4gSW4g
dGhhdCB2ZXJzaW9uIG9mIHRoZSBjb2RlLCB3aXRob3V0IHlvdXIgY29tbWl0cyBhYm92ZSwN
Cj4+Pj4gbmZzX3BhZ2VfYXN5bmNfZmx1c2ggcmV0dXJucyAwIGluIHRoaXMgY2FzZSwgd2hp
Y2ggSSB0aG91Z2h0DQo+Pj4+IG1pZ2h0DQo+Pj4+IHJlc3VsdCBpbiBuZnNfc2V0dXBfd3Jp
dGVfcmVxdWVzdCBnb2luZyBhaGVhZCBhbmQgY2FsbGluZw0KPj4+PiBuZnNfaW5vZGVfYWRk
X3JlcXVlc3Qgd2l0aCB0aGF0IHBhZ2UsIHJlc3VsdGluZyBpbiB0aGUgY3Jhc2gNCj4+Pj4g
c2Vlbi4NCj4+Pj4NCj4+Pj4NCj4+Pj4gSSB0aGVuIGRpc2NvdmVyZWQgeW91ciB2NS4wIGNv
bW1pdDoNCj4+Pj4NCj4+Pj4gOGZjNzViZWQ5NmJiIE5GUzogRml4IHVwIHJldHVybiB2YWx1
ZSBvbiBmYXRhbCBlcnJvcnMgaW4NCj4+Pj4gbmZzX3BhZ2VfYXN5bmNfZmx1c2goKSAoMiB5
ZWFycywgNSBtb250aHMgYWdvKQ0KPj4+Pg0KPj4+PiB3aGljaCBhcHBlYXJlZCB0byBjb3Jy
ZWN0IHRoYXQsIGhhdmluZyBuZnNfcGFnZV9hc3luY19mbHVzaA0KPj4+PiByZXR1cm4NCj4+
Pj4gdGhlDQo+Pj4+IGVycm9yIGluIHRoaXMgY2FzZSwgc28gd2Ugd291bGQgbm90IGVuZCB1
cCBpbg0KPj4+PiBuZnNfaW5vZGVfYWRkX3JlcXVlc3QuDQo+Pj4+DQo+Pj4+DQo+Pj4+IEJ1
dCBJIHRoZW4gc3BvdHRlZCB5b3VyIGxhdGVyIHY1LjIgY29tbWl0Og0KPj4+Pg0KPj4+PiAx
NGJlYmUzYzkwYjMgTkZTOiBEb24ndCBpbnRlcnJ1cHQgZmlsZSB3cml0ZW91dCBkdWUgdG8g
ZmF0YWwNCj4+Pj4gZXJyb3JzDQo+Pj4+ICgyDQo+Pj4+IHllYXJzLCAyIG1vbnRocyBhZ28p
DQo+Pj4+DQo+Pj4+IHdoaWNoIGNoYW5nZXMgdGhpbmdzIGJhY2ssIHNvIHRoYXQgbmZzX3Bh
Z2VfYXN5bmNfZmx1c2ggbm93IGFnYWluDQo+Pj4+IHJldHVybnMgMCwgaW4gdGhlICJsYXVu
ZGVyIiBjYXNlLCBhbmQgdGhhdCdzIGhvdyB0aGF0IGNvZGUNCj4+Pj4gcmVtYWlucw0KPj4+
PiB0b2RheS4NCj4+Pj4NCj4+Pj4NCj4+Pj4gSWYgc28sIGlzIHRoZXJlIGFueXRoaW5nIHRv
IHN0b3AgdGhlIHBvc3NpYmxlIGNyYXNoIHBhdGggdGhhdCBJDQo+Pj4+IGRlc2NyaWJlDQo+
Pj4+IGFib3ZlPw0KPj4+Pg0KPj4+Pg0KPj4+PiBwYXRoIEkgc3VnZ2VzdCBhYm92ZT8gT3Ig
cGVyaGFwcyBJJ20gbWlzc2luZyBhbm90aGVyIGNvbW1pdCB0aGF0DQo+Pj4+IHN0b3BzDQo+
Pj4+IGl0IGhhcHBlbmluZywgZXZlbiBhZnRlciB5b3VyIHNlY29uZCBjb21taXQgYWJvdmU/
DQo+Pj4+DQo+Pj4NCj4+PiBJbiBvcmRlciBmb3IgcGFnZS0+bWFwcGluZyB0byBnZXQgc2V0
IHRvIE5VTEwsIHdlJ2QgaGF2ZSB0byBiZQ0KPj4+IHJlbW92aW5nDQo+Pj4gdGhlIHBhZ2Ug
ZnJvbSB0aGUgcGFnZSBjYWNoZSBhbHRvZ2V0aGVyLiBJJ20gbm90IHNlZWluZyB3aGVyZSB3
ZSdkDQo+Pj4gYmUNCj4+PiBkb2luZyB0aGF0IGhlcmUuIEl0IGNlcnRhaW5seSBpc24ndCBw
b3NzaWJsZSBmb3Igc29tZSB0aGlyZCBwYXJ0eQ0KPj4+IHRvIGRvDQo+Pj4gc28sIHNpbmNl
IG91ciB0aHJlYWQgaXMgaG9sZGluZyB0aGUgcGFnZSBsb2NrIGFuZCBJJ20gbm90IHNlZWlu
Zw0KPj4+IHdoZXJlDQo+Pj4gdGhlIGNhbGwgdG8gbmZzX3dyaXRlX2Vycm9yKCkgbWlnaHQg
YmUgZG9pbmcgc28uDQo+Pj4NCj4+PiBXZSBkbyBjYWxsIG5mc19pbm9kZV9yZW1vdmVfcmVx
dWVzdCgpLCB3aGljaCByZW1vdmVzIHRoZSBzdHJ1Y3QNCj4+PiBuZnNfcGFnZSB0aGF0IGlz
IHRyYWNraW5nIHRoZSBwYWdlIGRpcnRpbmVzcywgaG93ZXZlciBpdCBzaG91bGRuJ3QNCj4+
PiBldmVyDQo+Pj4gcmVzdWx0IGluIHRoZSByZW1vdmFsIG9mIHRoZSBwYWdlY2FjaGUgcGFn
ZSBpdHNlbGYuDQo+Pj4NCj4+PiBBbSBJIG1pc3JlYWRpbmcgeW91ciBlbWFpbD8NCj4+DQo+
PiB0aGFua3MgdmVyeSBtdWNoIFRyb25kOyBtdWNoIG1vcmUgbGlrZWx5IEkgYW0gbWlzcmVh
ZGluZyB0aGUgY29kZSA6KQ0KPj4NCj4+DQo+PiBNeSB0aGVvcnkgd2FzIHRoYXQgd2UgaGF2
ZSBuZnNfcGFnZV9hc3luY19mbHVzaCBkZXRlY3RpbmcNCj4+IG5mc19lcnJvcl9pc19mYXRh
bF9vbl9zZXJ2ZXIsIHNvIGNhbGxpbmcgbmZzX3dyaXRlX2Vycm9yX3JlbW92ZV9wYWdlDQo+
PiAodGhpcyBpcyBhbiBvbGRlciB2NC4xNC43Mi1pc2gga2VybmVsKS4NCj4+DQo+PiBUaGF0
IHdvdWxkIHRoZW4gZ2VuZXJpY19lcnJvcl9yZW1vdmVfcGFnZSAtPiB0cnVuY2F0ZV9pbm9k
ZV9wYWdlIC0+DQo+PiB0cnVuY2F0ZV9jb21wbGV0ZV9wYWdlIC0+IGRlbGV0ZV9mcm9tX3Bh
Z2VfY2FjaGUNCj4+DQo+PiB0aHVzLCBhcyB5b3Ugc2F5LCByZW1vdmluZyB0aGUgcGFnZSBm
cm9tIHRoZSBwYWdlIGNhY2hlLCB3aXRoDQo+PiBfX2RlbGV0ZV9mcm9tX3BhZ2VfY2FjaGUg
Y2xlYXJpbmcgcGFnZS0+bWFwcGluZy4NCj4+DQo+Pg0KPj4gV2l0aG91dCB5b3VyIHY1LjAg
Y29tbWl0LCBuZnNfcGFnZV9hc3luY19mbHVzaCB3aWxsIHRoZW4gcmV0dXJuIDAsDQo+PiB2
aWENCj4+IG5mc19kb193cml0ZXBhZ2UsIG5mc193cml0ZXBhZ2VfbG9ja2VkLCBuZnNfd2Jf
cGFnZSB0bw0KPj4gbmZzX3RyeV90b191cGRhdGVfcmVxdWVzdCwgd2hpY2ggdGhlbiByZXR1
cm5zIE5VTEwgdG8NCj4+IG5mc19zZXR1cF93cml0ZV9yZXF1ZXN0Lg0KPj4NCj4+IG5mc19p
bm9kZV9hZGRfcmVxdWVzdCwgd2hpY2ggaXRzZWxmIHRoZW4gZGVyZWZlcmVuY2VzIHRoZSBt
YXBwaW5nOg0KPj4NCj4+ICDCoMKgwqDCoMKgwqDCoMKgc3Bpbl9sb2NrKCZtYXBwaW5nLT5w
cml2YXRlX2xvY2spOw0KPj4NCj4+IHdoaWNoIGlzIHdoZXJlIHdlIGNyYXNoLg0KPj4NCj4+
DQo+PiBPYnZpb3VzbHksIHRoZXJlIGFyZSBhIG51bWJlciBvZiBhc3N1bXB0aW9ucyBpbiB0
aGUgYWJvdmUsIHNvIEkNCj4+IHRob3VnaHQNCj4+IGl0IG11c3QganVzdCBiZSBhIHBvc3Np
YmxlIHBhdGggdGhlIGNvZGUgY291bGQgdGFrZT8NCj4+DQo+PiBEb2VzIHRoYXQgc291bmQg
cGxhdXNpYmxlIChnaXZlbiB0aGF0IHY0LjE0LjcyLWlzaCBjb2RlKT8NCj4+DQo+Pg0KPj4N
Cj4+IEhvd2V2ZXIsIEkgbm90ZSB0aGF0IGluIGEgc3Vic2VxdWVudCB2NS4yIGNvbW1pdDoN
Cj4+DQo+PiAyMjg3NmY1NDBiZGYgTkZTOiBEb24ndCBjYWxsIGdlbmVyaWNfZXJyb3JfcmVt
b3ZlX3BhZ2UoKSB3aGlsZQ0KPj4gaG9sZGluZyBsb2Nrcw0KPj4NCj4+IHlvdSByZW1vdmUg
dGhlIGNhbGwgdG8gZ2VuZXJpY19lcnJvcl9yZW1vdmVfcGFnZSBmcm9tDQo+PiBuZnNfd3Jp
dGVfZXJyb3JfcmVtb3ZlX3BhZ2UoKSwgYW5kIHRoYXQgaXMgaXRzZWxmIHRoZW4gcmVuYW1l
ZA0KPj4gbmZzX3dyaXRlX2Vycm9yKCksIGFzIHBhcnQgb2YgYSBsYXRlciB2NS4yIGNvbW1p
dDoNCj4+DQo+PiA2ZmJkYTg5YjI1N2YgTkZTOiBSZXBsYWNlIGN1c3RvbSBlcnJvciByZXBv
cnRpbmcgbWVjaGFuaXNtIHdpdGgNCj4+IGdlbmVyaWMgb25lDQo+Pg0KPj4NCj4+IFdpdGhv
dXQgdGhvc2UgY29tbWl0cywgYW5kIGFsc28gd2l0aG91dCB5b3VyIGFkanVzdG1lbnRzIHRv
DQo+PiBuZnNfcGFnZV9hc3luY19mbHVzaCBJIG1lbnRpb25lZCBlYXJsaWVyLCBpcyBpdCBw
b3NzaWJsZSB0aGF0IHRoZQ0KPj4gY29kZQ0KPj4gcGF0aCBJIHByZXNlbnQgYWJvdmUsIHdo
ZXJlIHRoZSBwYWdlIC9pcy8gcmVtb3ZlZCBmcm9tIHRoZSBwYWdlDQo+PiBjYWNoZSwNCj4+
IGNvdWxkIHJlc3VsdCBpbiB0aGUgY3Jhc2ggd2Ugc2F3Pw0KPj4NCj4+DQo+IA0KPiBPSywg
eWVzIHRoYXQgaXMgcGxhdXNpYmxlLiBUaGUgY2FsbCB0byBnZW5lcmljX2Vycm9yX3JlbW92
ZV9wYWdlKCkNCj4gd291bGQsIGFzIHlvdSBzYWlkLCByZW1vdmUgdGhlIHBhZ2UgZnJvbSB0
aGUgcGFnZSBjYWNoZSwgYW5kIHRodXMgY291bGQNCj4gcmVzdWx0IGluIHRoZSBjcmFzaCB5
b3UgZGVzY3JpYmUuDQo+IA0KDQp0aGF0J3MgZ3JlYXQsIHRoYW5rcyB2ZXJ5IG11Y2ggaW5k
ZWVkIGZvciB0aGUgY29uZmlybWF0aW9uLCBUcm9uZC4NCg0Kc29ycnkgdG8gd2FzdGUgeW91
ciB0aW1lIHdpdGggb2xkZXIgY29kZeKApg0KDQpjaGVlcnMsDQpjYWx1bS4NCg==

--------------cov8tvrprKHuqiYdd2nHwAHM--

--------------AeGv4vwf0fpFyNxucFoQw2Ij
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEE1GBbrQYgx8o9Vdw+hSPvAG3BU+IFAmDmP08FAwAAAAAACgkQhSPvAG3BU+IR
+A//RXwmjMWHElGMSZz1MPb3To6iE1fjoaIaengllNFjdQy6d2hciJSCj8J8rnVDcJ0xj5MqQrn1
nVGMCf49f9nlj5NsBXjl/QtiNPTYZUPXJaU+GVyz++nK/RnbvqVKfS6wJZfSGncc7JAghb2yfgKW
h5RtEWxg0UwhAhkIRwespLpBhW71KdkxzG9Rqj7pUn+hpmmyA1ltFVMou1E6/wdFQWWSre9BRWeu
7uGZlzPPuyKD/n4YGYW29ncBdsnIa46uyQSCX39r1Y9Ku0Ty4SRSmFdoSEEbXtcNaDGFZSrYVKO3
nO9hQPPiKdeNy2LpfXzzt4qbKihVC9KzAdJ5iEesCoU6ySspwde1RrvrXJ9kwcQh4htBLx+bJVhW
gw3IjPNodu5trvw/XtkRKk/8Iq6ZEG2cBkxitbu9/rbNWqbNhx+85pErqk2PlDjPz4IBVQtjZyhJ
UesZDKEm3S9iFQN0rPia9xD1FH9ihHElhdl1lahDvnT6nX7lY3D7JRUGh+TE59MTSmxv+B5vQpay
OItPk9QJb8uVkqtdR1Npcuqyx0X+FXwQWuDAiB9plFRSieUcCsqREB4UC2n1CfgOWm3C7oH6bWGW
hF1Oq2FM/msLIJ9DUBGC83RUfYTVZ3fgAUyEkuyEZ7/LK0K0Gzh/42zeLXHDKFOOYZhnX4fDkp3T
PmM=
=id1j
-----END PGP SIGNATURE-----

--------------AeGv4vwf0fpFyNxucFoQw2Ij--
