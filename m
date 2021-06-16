Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99F4D3AA445
	for <lists+linux-nfs@lfdr.de>; Wed, 16 Jun 2021 21:25:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232670AbhFPT1o (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 16 Jun 2021 15:27:44 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:44830 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231354AbhFPT1n (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 16 Jun 2021 15:27:43 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15GJKeto027789;
        Wed, 16 Jun 2021 19:25:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=zEqId1YhL4jDOJZTEE3uHlYKqQxttqcSPgdaQQo9poo=;
 b=z7HvTmbLdS0yY+oSwozHHF7EN42B5Lc/45iD1aFeK3yRBMJgN8DZWtbk6GVa4Oh7Ddt4
 L113lPbfgNB+RlInsWFzjzcZc6u4DCHohA7gKXE+obEgyXcDit+4SR48PWlNn9jI+fwK
 gQp+PmqDRTXBm0Agk6Fb/2+sZ3KnKgO6gM/a+nU+PeZm+uv3yZI4u7eL93G5nJH/Sb+k
 vMnTKisocVxmCmIC511IOSJU0K4fxZjGh62xrJ9fKmy2iYgHlULkjOhSBujiSaSyHkXw
 z9oJZz+aaP+Tcde/Gx8qwuwLul/x98O/vPReyjj0+wC7FNSYCq0mN3sN9pgVuJdS384L wA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 397mptgau1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Jun 2021 19:25:36 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 15GJLLEg025131;
        Wed, 16 Jun 2021 19:25:35 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
        by aserp3020.oracle.com with ESMTP id 396watws13-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Jun 2021 19:25:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NluaTuAv+3JF/P3t24plKR/3fFONvQCde4lmTk9PYWA8SXZcte5eUiqsZLumWCLZPrzRdrC6X32hpsy1ZWbNqkkaXF1eXwqbtDB1qiJ40/danhXQvagFroHy+y8o2FHS9AUQxOjD3CT+oBXQydDXhzBOpDCTbDpujZwhqezwTXLIMlVl2qa3VyU9tgDcMi45aLeeeVF5Qt/FmT6yg+qWre3CwJ8gtAyxti3ghrgLDf6V5fRSJmXkqNHMGmz+mWiWMkA4+yEXWctUTr0xtHcmsEdSrTA4TLtXYPTey5+PGXnZKyIxMXTizO75bEcND3dd1oR2yH9MmDumnPaiz45ebA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zEqId1YhL4jDOJZTEE3uHlYKqQxttqcSPgdaQQo9poo=;
 b=SvP+ENevhf9hp6l/YMjlTseee2Tx5TBF3RYbjZwWx5rxo/jFnQWP2yqC1AM4EKIUs7ZpqZ3juwqSb0mJwXiFh56lkLIRaTDmoUhjI8eaZpW7VtCYs4sPrZTgFM3WhDLRdLfGaBUgCHZ6exD2PXWzRFGOOoHr4HHUHm622MGwJ+BjfpwM60jATx9r9c2WC0jzfHou6qlIEoCx0Rdu4/x5DrXxedqlkF4xTF/foIWkCltVRTRnIvSRM9hgLywWITgmHfYURP8MTYmczreYqXCZHVo8vilNBzjwwlILGoMcaoXvqyJZ7z08UfRYh8E+xKi2BuVdQuB8uZkDWQ7OnOv17w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zEqId1YhL4jDOJZTEE3uHlYKqQxttqcSPgdaQQo9poo=;
 b=BF1D1dSvGEuW/Tn4wdOIuLaJaSSSW0KzxGKBHcGmwDijC4wfAGdg6dT5jRIwVSt7bVoCjHS2Gxs3Tv5AuvlSQK3h+E2JXh0rsgwrwuGLBa4f4f5cbb57ozp6LG7o9PcH8oO4KlotF1/2OLFhFcdR2sK7DgAVU/gLe4SwHI38xYQ=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by SJ0PR10MB4814.namprd10.prod.outlook.com (2603:10b6:a03:2d5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19; Wed, 16 Jun
 2021 19:25:30 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::ec57:cc81:ad54:10be]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::ec57:cc81:ad54:10be%6]) with mapi id 15.20.4242.019; Wed, 16 Jun 2021
 19:25:30 +0000
Subject: Re: [PATCH RFC 1/1] nfsd: Initial implementation of NFSv4 Courteous
 Server
To:     Chuck Lever III <chuck.lever@oracle.com>,
        Bruce Fields <bfields@fieldses.org>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
References: <20210603181438.109851-1-dai.ngo@oracle.com>
 <20210616160239.GC4943@fieldses.org>
 <8A44DFA1-683C-4D5F-BE71-0B94865AFA28@oracle.com>
From:   dai.ngo@oracle.com
Message-ID: <5bd3e11c-8749-b9ec-b1ae-5398fff5df4e@oracle.com>
Date:   Wed, 16 Jun 2021 12:25:27 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.1
In-Reply-To: <8A44DFA1-683C-4D5F-BE71-0B94865AFA28@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [72.219.112.78]
X-ClientProxiedBy: SA9PR13CA0025.namprd13.prod.outlook.com
 (2603:10b6:806:21::30) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from dhcp-10-159-134-236.vpn.oracle.com (72.219.112.78) by SA9PR13CA0025.namprd13.prod.outlook.com (2603:10b6:806:21::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.7 via Frontend Transport; Wed, 16 Jun 2021 19:25:30 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7e60e185-1f92-417c-c2dd-08d930fc812d
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4814:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SJ0PR10MB481440FCBA48DD0A3FD1BCC1870F9@SJ0PR10MB4814.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fiVuaPjS/xhpA2V+gsi2z4YHnuMHadfuEAGNJQxWes0o6Vup4Vwptnr4k8gI/A2LuzNh7W0irmDNBGY+AW5m66//lrMyA8wkMtwG8fe4aTBcVxriIsh8POTLGs4AuJgjOn/HLVksdp0Ntmj83jzJdWZc9NzPUQSHCmmMNNu/PaB+Ab5foFF/G2GDbi89tD7Wp8zCBfJ7RcwvAgX3J/dX2+Lidbyc8UZFuO+sGxf2qG2QYTZSpb8laIU78YxxViiG45gvGLLCV+6Hi1giV25wpfVkKEk2458c5Z1K12g0JHGwFfKs3+iHjFlSdxXbba3YqRuLJPDI1u6xdpi73h484nTTiG2JCMg9u/zpcKNX2RXX0EARXeTT3OJCPRs1AL9cMtTMlzVjxiL8EZEITYVqLt7h6tC/djlSzkFufvQYhC8D2Ngd9OGf9/zVBXfA4VAJ6wGSOF2QmGm2pxyJQK8CP0HGXK7a+MRdBQ5WkP6c4HvoYpoYyDNnwPi9amOALQ8bPZKZdG0NbIM9xci0rjCwLY3RM27Dxf28mESwLODSIYaIIIbimmXFiT846beyxPUhhyX2eIcgfsHTA0M5mlQ96M3QcLAWhkDz7Ha2nQ80B/2YPZZ+IMKcFOMcFcTqCaZ8/XsSAf8E0UReBOcC3DlWBkIk/WC+xxNDUprOoOVXC3s=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(39860400002)(376002)(366004)(346002)(136003)(8676002)(9686003)(16526019)(8936002)(26005)(6666004)(186003)(2906002)(316002)(31686004)(31696002)(4326008)(66556008)(6486002)(5660300002)(36756003)(66946007)(478600001)(86362001)(53546011)(7696005)(38100700002)(2616005)(110136005)(956004)(66476007)(83380400001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VDBLZmh0RkVtSGI3cEkzZ1V1Ymp2bVV4NEpXUjVRc0FvYkw0a3dBR2pEWDBt?=
 =?utf-8?B?Q1ZnWTFnTkxkZEJja2xPOGVVV2VpMUQxMEJWT2FETk9qOVAzNXorZVR4R0hm?=
 =?utf-8?B?RVhRZUhudGNsUm9tWXp0cW42bEJOM3IraTNBcDdiVTB3ZlBJRGxVNStQeERG?=
 =?utf-8?B?WGRIeEhIdFVhM1RYT1NkSXdFUjMwcWwwbzIzNWV4K2pSWTgwa0x3a0JEVStY?=
 =?utf-8?B?WHRBVThSajl6RjNtbXNIVVI2b0NIYjZIUjhXZWFmR3N1QUtoemgrNGV1eVhW?=
 =?utf-8?B?bmwzaEcvS0Z0OUJiNTVqWkdESjRUSlZOWGUyUXRWY1g3ald5WHozZEpSU0VD?=
 =?utf-8?B?UWNhUWJqRlp6dzU1TG92cmVHcmN6SnFtWjc1eU1YaG9Sc0w3QnRkeTVEUW9V?=
 =?utf-8?B?ZDc5MDZZWlA3QVFWMGVnMVF6YTNFUjNxRThoZVFXYWtBaWUyYWhUbi9CNjdn?=
 =?utf-8?B?TUViUU5ZeDVxU0JpQzlybGcxR0FPbk9jemNCM1UyUTFUUXZvTkZ5ZVpBQjNr?=
 =?utf-8?B?YkdmaGFmc2VmczZnUUdPWTBIeENqYlBJUFZjcVJpK3ZOV3JtbGtBejRIbE5o?=
 =?utf-8?B?cm1GMWtDdEVSN043M2JJczZsVURNUHNQSlZyUDdwaER5ZERCUW1hQVR6NnU1?=
 =?utf-8?B?eUo3V2NCVXIvTjd0VEZsdytaWEp2M095UnJUZmUvdWxnUDVVWE1LNWp5c2pY?=
 =?utf-8?B?MzNEZEk0SVlOMkVPRlpTb0szdm1zWm1qNk9ndXJ3bDBGWjcvMndaWTBLQVRn?=
 =?utf-8?B?c3NuM3RPOW1BRXBMTVprVWY4T3RzcmVQVHhjSjMwVjRkMVR2TUZjOFJIWEdk?=
 =?utf-8?B?YnFyYjcwa0dJU2lkZ3kwd0RsS2licklPcFlmdGszancrN2E3ZGZKN1kzcVBm?=
 =?utf-8?B?QTJEQUdTdHBGZmVlTjltb1dvWWptL3Z4eHNiNDF1US95SU1OUUdGdFh4MnNX?=
 =?utf-8?B?MlZxNUV0VG1ERVI5djlTSnQxQU13bjFuRW9ybXNzQjAyb3NXS3NMaGR2NVJT?=
 =?utf-8?B?ZWpNWTZEZ3BJZzh2a3FpWVdsb3NxdUI4V0x6d0Z1Y2VjU1FOaHVyYUIyZDFq?=
 =?utf-8?B?MlFXNjRFMmhCMEVvL3IvUG13QjVlZFJzOXQ4anBpbDhsR3lXbUdiektwZnd1?=
 =?utf-8?B?Z3NVdkxsb3psU3lCYTBYdVI1SkZ6aUt0eExmYmIyS1dJZzdzQU1rNkJ5eTB6?=
 =?utf-8?B?VHNCczJnbEVUK0NPK25JbGRjZk1ZYVZwMlloV2RaalZsMjBLQ1FPNDBTeUJB?=
 =?utf-8?B?ekNJSnhyclM3TVYxSE5nNmo3cCtHa0pmaHMwbjJ6UzRJVjRvNmlpRU1ZSi9G?=
 =?utf-8?B?OVl2TTA2bTFrdW4zZXhXckE0M2E0N0ZGYW1sV1hJOHF1NHRIdzdZV0wwZktY?=
 =?utf-8?B?cjIyOUpPakp0QWF2a05aUjFmR0hyc2w0dVRORmxUczV3c0Vybk96WXJLSkcx?=
 =?utf-8?B?Zk1KUVhKeWNacmFjcFJzRGxjTm1vaWQ2RDVsenNIbzZodko3UXl2Rk5YOGlB?=
 =?utf-8?B?VUJteEpBbzRBSVN1K0E0UCtLZmthSTFmcGRFTkdvNTVHb2ZUMjBuSzFRSVNQ?=
 =?utf-8?B?Z0FhWFVRaHd1cEdMNGtsNlIrSEJtT1crcXl0Sk03dXdGUEQ4WVlQQU5GT2xP?=
 =?utf-8?B?eFY5aWwxVEpoT0JhL2NQR2E1ZWhXSUJUbHUxZ0dXMlVxN1o1Z21TK0JYSUNE?=
 =?utf-8?B?Mnd5SFQrVVNJSG11YW9iTkgyWkcyYUV3Y0pBTEFRQlVxb2FpMTJ2N3VXbTE0?=
 =?utf-8?Q?iA9SOopobEi5KaiHpTi55banY9oHajoEtXZ7XRP?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e60e185-1f92-417c-c2dd-08d930fc812d
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2021 19:25:30.8042
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OD9C3gPTtiU1gV0jGHMAUFnZSP4w7g1EEsdmUTC2jsthk45kg2jsALRk7FfKFPi0yfw2mVQ+g7Lont1evpFDhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4814
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10016 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 malwarescore=0 phishscore=0 spamscore=0 bulkscore=0 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106160109
X-Proofpoint-GUID: yNs7xHG0hRwdaagb55zXaJSToHQp4pkn
X-Proofpoint-ORIG-GUID: yNs7xHG0hRwdaagb55zXaJSToHQp4pkn
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 6/16/21 9:32 AM, Chuck Lever III wrote:
>> On Jun 16, 2021, at 12:02 PM, J. Bruce Fields <bfields@fieldses.org> wrote:
>>
>> On Thu, Jun 03, 2021 at 02:14:38PM -0400, Dai Ngo wrote:
>>> . instead of destroy the client anf all its state on conflict, only destroy
>>> the state that is conflicted with the current request.
>> The other todos I think have to be done before we merge, but this one I
>> think can wait.
> I agree on both points: this one can wait, but the others
> should be done before merge.

yes, will do.

>
>
>>> . destroy the COURTESY_CLIENT either after a fixed period of time to release
>>> resources or as reacting to memory pressure.
>> I think we need something here, but it can be pretty simple.
> We should work out a policy now.
>
> A lower bound is good to have. Keep courtesy clients at least
> this long. Average network partition length times two as a shot
> in the dark. Or it could be N times the lease expiry time.
>
> An upper bound is harder to guess at. Obviously these things
> will go away when the server reboots. The laundromat could
> handle this sooner. However using a shrinker might be nicer and
> more Linux-y, keeping the clients as long as practical, without
> the need for adding another administrative setting.

Can we start out with a simple 12 or 24 hours to accommodate long
network outages for this phase?

Thanks,
-Dai

>
>
> --
> Chuck Lever
>
>
>
