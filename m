Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F4AA442123
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Nov 2021 20:55:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229725AbhKAT6c (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 1 Nov 2021 15:58:32 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:35812 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229596AbhKAT6b (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 1 Nov 2021 15:58:31 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1A1Iu9ho026217;
        Mon, 1 Nov 2021 19:55:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=CG9v2SG7qpqVFcNUSEgBVbim4kKtb+ohD0rUhD95k94=;
 b=vU38KjYdgYXdwsvF7zrbooDLumU+/I0/A6M+nA6tibX18/2TDVxRwx0vQNM3lKQrE/RV
 Ty3KRyOfEoTeySLfKD6/2I+qn4O9cp94D99y3TvgMt2+yn5Svk1R3HHQPeVz5YgBqAS+
 DFanIUwzs73O5GYSKyj7vKD/DZfkwQqDj5HUjasUWTzxu4iFub8JwzNLB2EpFb1FhUhE
 xq2XAmT5X8RxV0IZ9d2v20RjJgRp53dn08ufVDESNOmlVilYWaclpFNFsTee6xOBoGHG
 Eu0Lbz9H7fQSYDv8YeWoHORjwqfT5vKQ6DQHCZyRnGJuyDT1APhApMqu0sodcGq+QL5q Xg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3c26e8c8tr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 01 Nov 2021 19:55:54 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1A1JkReW049024;
        Mon, 1 Nov 2021 19:55:53 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
        by userp3030.oracle.com with ESMTP id 3c27k3ygqh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 01 Nov 2021 19:55:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kgBmTQ/LQ/5m5XuERsKGkn8If7YCGe55uZMjL9sE7FNesUN8UhtPDoAmydGfDeaZxBVC6HphtkBQyiTpdKgp61SWzAD5rgoVSd11KAtuxoKwzq8zZCYNt7tLfdppbKLVw1FpngOcBvWmlzfkPzmRsDMibeLWLtCf9ul7NmBU9jpvwAgEb9DrP40pdCsXPJg/6pVR6aide0P9PW9IllvJ65wfdWj/V3M6qoU74WCoVwRGN1I/OJu3TkovbmTyx09+zrEObdGp5MnMTAUiEgmcJtrHzjwp3aNDxo+1U+SvLMM8QEmpNrL8D9A/Kqc4ToFHwrWOSH1nGjzbhJG1AOkU5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CG9v2SG7qpqVFcNUSEgBVbim4kKtb+ohD0rUhD95k94=;
 b=CB6PDCoQmFsV7GK/ydPqwLZvFsXFMobNFSWNc2BMLvRO2Hd9NV3FoYAkgM7S0BoRGdfa0cLJ4gm16UHseGfClVz5wfAy7AVLIWZ5+ANQgyyQr3G5DfQN1rUzuYIqSHlYxSnuvd1MJOfsamIPBQq5tnhZsMlsIlNIg0XuEZbCvF2E/1ovP9mJGH/nDdXGIE//INvCOJ6rf61cGjW0Vu4nZBltQ2kkD5jXSJS3x1rULbYs85BeWpDxHND2PUTzNOwh18mnMia4i7ZW/2k6KaxUiEcTvtm4NS8jv0eXSffHLliAd4c4vK5AlgD1Rz8hUJhpQKx6FiBXvRN85T0dwmeHkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CG9v2SG7qpqVFcNUSEgBVbim4kKtb+ohD0rUhD95k94=;
 b=LjeEsp6If/bFFPxGIzbyoa2Q6D3+0F4UfZlD/UDP5KtP0s6cTBD/oywNYTMNnEXumSfBC1CXUOllj9EVHIx+wiTEdti2BVXMe9L39++DKWLwokHEyfIoU76JX67MlBRXs/PTKtzf0FWsXSVQtrpvfqKZLg7ko3i5d+pKPOU7hJ8=
Authentication-Results: fieldses.org; dkim=none (message not signed)
 header.d=none;fieldses.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by BYAPR10MB3032.namprd10.prod.outlook.com (2603:10b6:a03:82::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15; Mon, 1 Nov
 2021 19:55:51 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::486b:6917:1bf6:c00e]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::486b:6917:1bf6:c00e%7]) with mapi id 15.20.4649.019; Mon, 1 Nov 2021
 19:55:51 +0000
Message-ID: <e49873a0-634c-a954-14f6-af111b5d6adc@oracle.com>
Date:   Mon, 1 Nov 2021 12:55:46 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.2.1
Subject: Re: server-to-server copy by default
Content-Language: en-US
To:     Bruce Fields <bfields@fieldses.org>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Steve Dickson <steved@redhat.com>,
        Olga Kornievskaia <olga.kornievskaia@gmail.com>,
        Chuck Lever <chuck.lever@oracle.com>
References: <20211020155421.GC597@fieldses.org>
 <18E32DF5-3F1D-4C23-8C2F-A7963103CF8C@oracle.com>
 <CAN-5tyEL4L2GH=-MDGS4qNTcCLRPFCQzfDQjFAVbG7wMKvHxOg@mail.gmail.com>
 <8b1eb564-974d-00b6-397a-d92f301df7d8@oracle.com>
 <20211020202907.GF597@fieldses.org>
 <a009cbf3-cb83-b7c8-aa86-2eee06962b68@oracle.com>
 <20211021140243.GB25711@fieldses.org>
 <78839450-8095-01ae-53e8-f0ebf941b5a5@oracle.com>
 <1500403d-6aa1-3909-d44f-b33c1c1f3ce2@oracle.com>
 <20211101193346.GD14427@fieldses.org>
From:   dai.ngo@oracle.com
In-Reply-To: <20211101193346.GD14427@fieldses.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA0PR11CA0092.namprd11.prod.outlook.com
 (2603:10b6:806:d1::7) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
Received: from [10.39.219.222] (138.3.201.30) by SA0PR11CA0092.namprd11.prod.outlook.com (2603:10b6:806:d1::7) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14 via Frontend Transport; Mon, 1 Nov 2021 19:55:49 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a50ba012-c134-4303-a8a5-08d99d719b4c
X-MS-TrafficTypeDiagnostic: BYAPR10MB3032:
X-Microsoft-Antispam-PRVS: <BYAPR10MB3032B2FA493A23617B74C763878A9@BYAPR10MB3032.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R59w5DIpOqKcsisVErUUog5wfBFbX0axXOvk8+n1qj/Dl/QrZo3zndtdF01jLQxAZPl6I3sWLO8TwthrQuSHQ0ZrARkjO+dAajwlE8sGogOzfL0cPhrvtakOT/JDmKj8oTe+bvOnzZKRomFNraKja0wxXUB/Or7NuNcNXCG7nBfhjswXpUljiOJ5kmNfAeyqyYi2eZkIA1y66dMbJ2Sok/hG0T3itgcfXRKJa3hsO2DCoEcmWA2WaXa1R+UMJINtsLYjvIzVdqTZT6mGR83vPB15qbvctDpebNC+gC+G6h7b7gfLdQL37ypExc6i/48CmXB9+MUEtnkV/V5MIXUyLmxdsyk7vSnsNa8X0NBZ1KqAq3Y/ihxQij/0u/009+Nbp5ab9nFTeXyDAsoM+eeeqOT/PbRTSQlf2uLEOD/wRnbCR56uvmm6XPb3G3/5Jx9atkRYwcxI2qmLeaYTA7oxEimxhMfxyw6r4Hx4SV3sN2jZXP414Gy7m1A9pfS6hRX4Fme6inY8oe+9JWGo/e1IpyJPumdneewH+x6XjCGqJcySKe2dVTVc4wAsfcFjFXTIpOng93QvqaYaok+zt7t1AxDLSaDPv/4AMtY7W1M7exv43HBOiAmusLO0Js7w5EaFKXp+1zPV45xvxx0gSisl0MzxL24DW9xWoyQJIpfTN+5wXa+5SroMKjMQNLmAVj8SF8WeHErVID6Yuncpagfudg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(31696002)(6666004)(16576012)(4326008)(66946007)(2906002)(6916009)(36756003)(86362001)(8936002)(316002)(54906003)(186003)(956004)(66476007)(66556008)(38100700002)(5660300002)(9686003)(2616005)(6486002)(107886003)(31686004)(26005)(8676002)(83380400001)(53546011)(508600001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Zk5lc2VhSk5JaDFqSmZzVmhxUnBmUmYwOThuN080YXNybjZOUFdOUGQ0ZnZv?=
 =?utf-8?B?aTVkckJDSmJzYWs2RTdTcGIxTklIQkVTVFRLOC82WDNDSEY1bHZjQjczek9N?=
 =?utf-8?B?RnlCZ1ZuK3dqZ3ltdDZrZ1NRbFZyRURzd081a25EeXArWDU4cXU1ak84U1Fj?=
 =?utf-8?B?ZS9ldjFrajM2eWFST0pKSGFmcmpKN3hmL1B3VUk4NUVqSU5yOW1KTFAyNVdM?=
 =?utf-8?B?emlzaHFMbVo0eXRwQ2VwbzI0KzJoSkp4TGE5U1dJSjBJQmlRNXhsNXJlNlVm?=
 =?utf-8?B?WnJNVmY4MUVzV3NOS2RsNlpVdkN2bFYycmNsQ2xVQ29OTU5lWEtXbmZnUFQv?=
 =?utf-8?B?eVdmQjFWeXE4enFmMXZXT08zbUJaVC8zbEVENkVzSEhoS3FsTWRIUEwxYUZY?=
 =?utf-8?B?Q2hKV21CbGQyZXZOb1FTRStSZ0pabW5jVVRjN01ITU96WGVKay9UR3VxQ2tq?=
 =?utf-8?B?Q3J4VGlaU1RBRFJZYUpRSW0yNnF1bUduZ08xL1FZdkxDcllHMHF2ZkxxcWZa?=
 =?utf-8?B?WTZMUm55dVJZbm9LeVN6QlJ0M0ZYOHBwdkJHeUh0cG9RNWphTEs5Sk1tYVVx?=
 =?utf-8?B?UkE4cnoxOTJ3b1VJcnZRN3I4V0JDTW5lZlVYc0hwMnozbElMTGJiR3ZiWTEw?=
 =?utf-8?B?T3haQWE1dnZOWVptZ3dJSUQ0T0VBUkVQcmQ4dzh3cE5BZE04Ynp3bW5DaUdQ?=
 =?utf-8?B?dDJDdkxTWVhRNG5RU21JV3JXR2FFTWlWOGRyclAyZUdJTnhnR2VXRFpYbmtj?=
 =?utf-8?B?aEJNUVZ5ekZxblUyK1laVndva0FaTWxDR0R1L0pmdGg2Yjh0OS84WjU5bzBK?=
 =?utf-8?B?RHEzcU1HTkJhS0djOUoyZmVMdnJhaW5jZHI5NUVvYUNwazg5WG5ETU1ERi9V?=
 =?utf-8?B?MHE1SkdCSm1VYjlNa2VRek5vT2VMcXJ5dEkvVmRSRzNtbHVaY3pmcFlPTFMz?=
 =?utf-8?B?ZHpVZEdjY1g2YzdaVjRNTWxGWEZZeDhXQ1Izc3YrbE5ack9HbHNqVlYvM0F6?=
 =?utf-8?B?MVBRZUZVa0h3TkNqMW9NK0hZUzBINHhEaWw1aGkwSjNtYllSL2ZXRGJtZEM2?=
 =?utf-8?B?aWJrU2JvOXZaaE4rUEExclJXd2J4d0t5WjU1NW0rVVdiR1E0RjJjenJ5THZZ?=
 =?utf-8?B?UjFSanVZVjdVRUllQjBYUGYybElOcTZvM0s0R09BV3g0dU4vNnVQOTNsQ2VX?=
 =?utf-8?B?a01OQjhyM2tRV2M2S21DdnV0ck9HdFdJeWgzdFZMNkJ4YlRYMi9mN3NhR2o4?=
 =?utf-8?B?K2xoYVVjQjRiR0JIdXFCbkNoNkhUMUhkNGF6Wm1PUkF0elFNZ0YvK3dtMHJj?=
 =?utf-8?B?dkxrVU1BZ3BPaE5adXNWaXRqa0NJQ1ljbG5kYnVuT204UzFYMGtBZHVZSGN0?=
 =?utf-8?B?bWVhVmJPc210VFhrMDNxN0diMGRLTmVSSnE5YUZxTUJ4WGtTT25pbHVhelYx?=
 =?utf-8?B?TXhHRTJDWTJTQjlzY2JYbkpBOGE0TEhkVnk4R1hZK0tjTElyYndjZWZHSUxC?=
 =?utf-8?B?cFAwVDlnRytrcHNuZEkxbTFGNWpWKzN6M1BrTjg3TDcrRUtiV1JCTHZlRHVj?=
 =?utf-8?B?ZHpVdUdoM2JUUkhjNEFOcGprcnBuVmprRno5WG90aVFQVkJkbDdJYU5CUWtE?=
 =?utf-8?B?VGgzVW1uNVNldWZZS0ZLbTFsYzlZOEdkeGVsME9pMG1sTmRINFQ0QmhmNDg2?=
 =?utf-8?B?M1hiNEFqUkdLKzNUcVU4Qm1mOXcyYUF4WVJKaWdlcXY4MWlhRVQzbnV1VzZu?=
 =?utf-8?B?R0FCK0t2Q3I4dGNlRE42U2ZybE1MQ3BSN3F6Tk9BekZCVjlRQ0JWcGtoejlN?=
 =?utf-8?B?NmxrVUowd1preWkzSkJiVHRRWFkrZTM1cUpUZEdjdithM3RLREtDSDNvaUxL?=
 =?utf-8?B?VW9NR3NIMXYxWkt1ZjVDTWhqT0pJTVJURGQ5SExyYVZ0YUZBbnJWQWF4TnlW?=
 =?utf-8?B?RGlQMGg0SnUrWWRxMjc5d0QrdjlPd20zVjdsNDNTL1BPZEMwT0pBQkZ1bm41?=
 =?utf-8?B?WVdybC92blVzMWpFbFZMRGMrbFlYcEVXcFFhYURKUE1SazVkTFJOd3ZySUwx?=
 =?utf-8?B?ZHQvblArb2xGK1hVNVc3dlh3UU5YV3IyZkJKMmF4NVRTdGpzLytkeTBFRGZK?=
 =?utf-8?B?SmZVT1ovQnY1U2pPaHJzYWdtYXh6NVNQVHdMaGk1TmtvQXRkdTRRN1VHVCt2?=
 =?utf-8?Q?n2HnGXab1CdGUWYTWN0xToA=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a50ba012-c134-4303-a8a5-08d99d719b4c
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2021 19:55:51.3297
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mqVQDmn/3a7pkRo1n1O5SR475kXsv/UP2PsHTSn4uhK/mAJmo/mUhlAiTb36TQkWhHsfXaZp1+6NRory0ZROVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3032
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10155 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 spamscore=0
 malwarescore=0 mlxlogscore=999 adultscore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111010105
X-Proofpoint-GUID: i-RrT-2SoR4_GXBqVxQ5mwRTArKe9lut
X-Proofpoint-ORIG-GUID: i-RrT-2SoR4_GXBqVxQ5mwRTArKe9lut
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


On 11/1/21 12:33 PM, Bruce Fields wrote:
> On Mon, Nov 01, 2021 at 10:37:11AM -0700, dai.ngo@oracle.com wrote:
>> On 10/21/21 11:34 PM, dai.ngo@oracle.com wrote:
>>> On 10/21/21 7:02 AM, Bruce Fields wrote:
>>>> On Wed, Oct 20, 2021 at 10:00:41PM -0700, dai.ngo@oracle.com wrote:
>>>>> The attack can come from the replies of the source server or requests
>>>> >from the source server to the destination server via the back channel.
>>>>> One of possible attack in the reply is BAD_STATEID which was handled
>>>>> by the client code as mentioned by Olga.
>>>>>
>>>>> Here is the list of NFS requests made from the destination to the
>>>>> source server:
>>>>>
>>>>>           EXCHANGE_ID
>>>>>           CREATE_SESSION
>>>>>           RECLAIM_COMLETE
>>>>>           SEQUENCE
>>>>>           PUTROOTFH
>>>>>           PUTHF
>>>>>           GETFH
>>>>>           GETATTR
>>>>>           READ/READ_PLUS
>>>>>           DESTROY_SESSION
>>>>>           DESTROY_CLIENTID
>>>>>
>>>>> Do you think we should review all replies from these requests to make
>>>>> sure error replies do not cause problems for the destination server?
>>>> That's the exactly the sort of analysis I was curious to see, yes.
>>> I will go through these requests to see if is there is anything that
>>> we need to do to ensure the destination does not react negatively
>>> on the replies.
>> still need to be done.
>>
>>>> (I doubt the PUTROOTFH, PUTFH, GETFH, and GETATTR are really necessary,
>>>> I wonder if there's any way we could just bypass them in our case.  I
>>>> don't know, maybe that's more trouble than it's worth.)
>>> I'll take a look but I think we should avoid modifying the client
>>> code if possible.
>>>
>>>>> same for the back channel ops:
>>>>>
>>>>>           OP_CB_GETATTR
>>>>>           OP_CB_RECALL
>>>>>           OP_CB_LAYOUTRECALL
>>>>>           OP_CB_NOTIFY
>>>>>           OP_CB_PUSH_DELEG
>>>>>           OP_CB_RECALL_ANY
>>>>>           OP_CB_RECALLABLE_OBJ_AVAIL
>>>>>           OP_CB_RECALL_SLOT
>>>>>           OP_CB_SEQUENCE
>>>>>           OP_CB_WANTS_CANCELLED
>>>>>           OP_CB_NOTIFY_LOCK
>>>>>           OP_CB_NOTIFY_DEVICEID
>>>>>           OP_CB_OFFLOAD
>>>> There shouldn't be any need for callbacks at all.  We might be able to
>>>> get away without even setting up a backchannel.  But, yes, if the server
>>>> tries to send one anyway, it'd be good to know we do something
>>>> reasonable.
>>> or do not specify the back channel when creating the session somehow.
>>> I will report back.
>> We can not disable the back channel of the SSC v4.2 mount since it might
>> share the same connection with a regular NFSv4.2 mount from the destination
>> to the source server.
> Hm.
>
> Well, now that I think of it, a backchannel is probably required for the
> SSC case anyway.  (I think CB_RECALL_SLOT is mandatory to support?)

I think the back channel is not required. From Sec 13 of RFC 7862:

    The REQUIRED or OPTIONAL designation for callback operations sent by
    the server is for both the client and server.  Generally, the client
    has the option of creating the backchannel and sending the operations
    on the forechannel that will be a catalyst for the server sending
    callback operations.  A partial exception is CB_RECALL_SLOT; the only
    way the client can avoid supporting this operation is by not creating
    a backchannel.

I have not found a clean/simple way to not creating the back channel
for the SSC mount. The reasons is that the SSC mount can be using an
existing connection of a regular mount to the source server, or a
regular mount can happen after the SSC mount.

It seems that we should support back channel for SSC mount but do a
due diligent check to make sure the requests come from a trusted source
and also limit the number of ops supported on the SSC back channel.

-Dai

>
> --b.
