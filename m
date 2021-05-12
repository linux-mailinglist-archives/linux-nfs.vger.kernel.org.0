Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06D3D37D0D1
	for <lists+linux-nfs@lfdr.de>; Wed, 12 May 2021 19:43:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235712AbhELRm5 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 12 May 2021 13:42:57 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:19522 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238491AbhELQy3 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 12 May 2021 12:54:29 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14CGkx0C018942;
        Wed, 12 May 2021 16:53:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 cc : references : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=ijFXmvy17bXHqaNrpnHCiyUZCu10rW657LsdXd/iUiY=;
 b=IyQwRslxgYFNqPGnsR17DUgod58mJ3SwNF5dBvvlO15jnVR9HfREHCZYS1nZgbMUXiYl
 3Y+PW8oMTGoxlChzCq9mfOg+q1wUK4TQdnSaWU+qjChi0jDPrieFlcxSoviSdWHXREFM
 61/mg6dvpeAcK6yEbz+Obtr47E789Dnesz2kBoeY8LZC6dtgCRL0QSQFQT+prM/jI3eT
 uRwj4riwr97jOqXxXtQENzm0pT/aLxLF+Is6mmzovzAgHhHUKBB1pGryzNKHBTdLuR19
 QQ7MPW61VeuBR39BlOgZeLDnlI5pv1wbHVyerT5Ny1Wrt/ERqII7GwEIlPdjuZMfHs4z nA== 
Received: from oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 38g3af0a6p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 May 2021 16:53:13 +0000
Received: from userp3020.oracle.com (userp3020.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 14CGqvvO037431;
        Wed, 12 May 2021 16:53:12 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2041.outbound.protection.outlook.com [104.47.73.41])
        by userp3020.oracle.com with ESMTP id 38fh3yf01j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 May 2021 16:53:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KrMAuOWgVZKzlwFa6Pc1NGJZJ/MKgeOcEjSdPq2O0KntQRlgSzYhpnslIE3L4YarO49iza0SH3ve7xPzacgEWmcs7zf8zgYaflh+ZeH19BrIM1GzMFucNiWUvVqaxOU4V0pvBR7grQF15sLzTH7syWRFPtHT78TZ/UJQLfHJ8LZQvZKQxxKvssfaNB/WlTbGDHU9UmE5nCwrsI1NeDB7cILtdFMPwMuf8a82xEX99CtHHC5TVsZ35GD24iEwr5NFGTHIMB4U5D9h+9E72xM5oP04Aj9iaQX+0B/W1sn7yaGnRMUc239Yp5KgVhnlpuPeJ58jn0J8xXM2Mnn0EvxCtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ijFXmvy17bXHqaNrpnHCiyUZCu10rW657LsdXd/iUiY=;
 b=bxrJCvs5e85TChwB7eBZytbUGH85eDgUfd/gTeIP5ULgLQzbloGPHh+ePLvjzExNAJstlTM0tzG/5utzunqBcygLyIeP7XpDhe7HF7AyLK52OHOHx0T2EyKv4dp/l2TnbnPvLL7i/jNJdXKkNq9iElh8ddgWjZCcYe2EVX4YXdeSLSK8B5oFRQBIqo6OgvVB8fUVGK7oq52c5MUL5riwiCpZvWyoA+7t72J78SEbpitwRS7vkhARYEitmlU2ZNDG3ufdLra6HXks6eUwUrYEla/foCVdwQO1EzgjzUYaMOdPOIh3/tz3hYGkfLpZ4ZVHhxCX+/F7VjIC+pUvqXE/RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ijFXmvy17bXHqaNrpnHCiyUZCu10rW657LsdXd/iUiY=;
 b=ATPrKDlWrczhNawRgXUBsbacjcNCU9HnIUKtNHnOPu2a+pfybUOQOnQ76eZqS/ZEcvQ05hyib3VXGhXG4ryAxH2/e3x6TxfH5mrcKOT1nrgBN6c0IeLOlRklYhNvp3qUKVrBUFgBKz7jPCldrWVjpk0ohMCI+dz64oPSh6Ky45Y=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by SJ0PR10MB4429.namprd10.prod.outlook.com (2603:10b6:a03:2d1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25; Wed, 12 May
 2021 16:53:10 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::f58e:50cc:303e:879]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::f58e:50cc:303e:879%4]) with mapi id 15.20.4129.026; Wed, 12 May 2021
 16:53:10 +0000
Subject: Re: [PATCH v4 0/2] NFSD: delay unmount source's export after
 inter-server copy completed.
From:   dai.ngo@oracle.com
To:     olga.kornievskaia@gmail.com
Cc:     trondmy@hammerspace.com, bfields@fieldses.org,
        chuck.lever@oracle.com, linux-nfs@vger.kernel.org
References: <20210423205946.24407-1-dai.ngo@oracle.com>
 <e0ec16f9-9780-c2c5-8cd4-c1083a2227fb@oracle.com>
Message-ID: <1cb23524-0fd0-13d4-a45b-5c038750c09a@oracle.com>
Date:   Wed, 12 May 2021 09:53:07 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.0
In-Reply-To: <e0ec16f9-9780-c2c5-8cd4-c1083a2227fb@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [174.78.11.62]
X-ClientProxiedBy: SA9PR13CA0146.namprd13.prod.outlook.com
 (2603:10b6:806:27::31) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from dhcp-10-154-166-218.vpn.oracle.com (174.78.11.62) by SA9PR13CA0146.namprd13.prod.outlook.com (2603:10b6:806:27::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.11 via Frontend Transport; Wed, 12 May 2021 16:53:09 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1bb62f65-b0bf-4952-9327-08d915666c6d
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4429:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SJ0PR10MB44290DC2925662F7BFACB82487529@SJ0PR10MB4429.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1XLylYjlGcmDThgibVDNrW65afrDVdNzmIPIbnPToR6F1uJPpHILugLl5EzeN+p32bKAz4VD7pdrmpunrEk86c2ybUBoXedcuE73UY9rk/4FNmFPM7QfQfWmURbrhsy8GjfK/GXN5XA1l8N8ssKYOJhp3lIaukaG4/0ZLdktiPJHCZlSWcnPGmqoTCEakiuG2XB0lOOFF23sqhSI8wkgrxaqbdCO6Vz9E8dnXwWk1RzIENRYBIvvdfQIY0FCPNqihqy/gx2Ds3KoHwiD0ZsbR/OC80E8VgRVCUXdeaNOcDXbFDzZj6/xoz4ZvhzEjqr1SdPUt5kMAA8A3VfOEDwARg3e/xEJAIQ+ZJxfkDUnWz9x5DM8gOMfKuJj69VbNp3lhaaaaOe9leNAYECFUn1yfrSeqhQGaL+g4tV6H+f/lTXG0WWZDux1xYqKq4eNCjdJmrWMbzTH4v5qL6mEvmY2GgWLjc9ohkfQV0GBeDe8+jgF6GfIV3pNitX63NprPjqqGUP95CMdqAtRi+0DkGcTUwhRW8uZShZjpQmICUZmXBZLldpY92A2MXZXtbYJ4Ue9P/YY8Zb7NpZUo4fwf3qGMqjV6YpBNcbaTdh7gd8Wm4xpJSTpt/Kj+veKqzHaS0YGHy+czj3WNcOCFcxgVpCN5g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(346002)(366004)(396003)(376002)(39860400002)(16526019)(31686004)(66946007)(31696002)(66556008)(66476007)(2906002)(83380400001)(478600001)(6916009)(36756003)(316002)(9686003)(2616005)(186003)(53546011)(26005)(38100700002)(4326008)(8676002)(6486002)(5660300002)(86362001)(8936002)(7696005)(956004)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?Nm9UZnJyZXZTM0FEamJNQ0dlWDVJZ1RQZXE3NGNFVkNrelk3aEQxZ1R5V1lk?=
 =?utf-8?B?aGYwSytwU0FLa1ptaElmczJPMUt3STFHaDNPU21vTkJQaXlvWFd5V1pmcVdh?=
 =?utf-8?B?SW9uTDFwWWMzeldRZXNkT1RQSTZBQjZUVlQvSkxiUVZaSHhBZWFLUlVES1FI?=
 =?utf-8?B?bFRnUWFGRkhnTmNNbWt5RmVhbmRhVGw5L0p4OENRT1hjTHM4ZGVJdEFkK0Vj?=
 =?utf-8?B?bWwrNHZ6WnBGa2gwTE4wRzNkMi9GV0loWm1SYVg2TkpaeEJmYlNiZWFLc2RZ?=
 =?utf-8?B?ZmxTMG50aG5WQWsvSU5wR2Vpckpram9aa2VwZFNHZW96c3RvdjBnYlptN3Jr?=
 =?utf-8?B?eEhkdUdDNTVCYlJqZ3Jqdnk1OC9hYXRLSnFQbStLVEN1VHk4dCtJU2swY1ZX?=
 =?utf-8?B?eng3bmRob2VGSlZrYVdaM3dGZ1FPcjZKZGUwNTBsTlhuZWNUdXBzV2tpMWxr?=
 =?utf-8?B?SmQwcVRZYjBQQW56Y1hmK1BBT3pKVFByOGsxTzlBWW1HLzJoKzF4TGJ2TllK?=
 =?utf-8?B?VW15eXZGUDNJUVRUSnZYYkNVQnlSRTVBbnNGYUNoempXNW13NnhCQ1dqRXJD?=
 =?utf-8?B?WXpNU09TK1lCUXZwTmRMSnlFbXpvMmJmTytUaUtOeUkwU3dTc1dvVElCaXlF?=
 =?utf-8?B?MVhJbk5hN0dEeFJPaFRBbUdDaHE4K3RsR3U2anROeGRuWUJjbHlSN2xybVY4?=
 =?utf-8?B?TWJkVXl6djF1a0dXaFF6Z1BBcllabHlLNGFEMlFjMU5BaU9uMWg4Mmd1aURu?=
 =?utf-8?B?cFpCdU5LaVBqUEp5QzRUaUU4Y0phMjNSWDNvcGZyS0ZkWG5wU2hJdjZPYVZu?=
 =?utf-8?B?U1FOcC9CWmUrSDlaRFBlajgrUFFIZ2pFRms0VTJBS1JjYlVNbzBUUFVrcmQw?=
 =?utf-8?B?ZkNiOGVFWDZGUjZQaUR0ZElXQlliZjEvakQ1bzJlYmFQUjYzZ09ONm9pdzMy?=
 =?utf-8?B?VmtQZXRHSUZLd1RsRDd5ekc3RE15QXFJVFFhSy9FZ05FTTJnaDVndzd0eHVD?=
 =?utf-8?B?WmdXNExQUllidkRPa1lmdTlkQkFhOFNZa1d1cU5ST0NSS1ZCc0twY25JLytE?=
 =?utf-8?B?Q1NYYitZdWRsTyt4WG80V3MyL1JGcWtPWGs4VWFOSmJwQ2hoMXJjWXQrZys5?=
 =?utf-8?B?b0VkTWllQzV4ZlNNcCtJWmUydnRuQXNHRHRJNnhVWmZPc2dwTVZubXNyMitY?=
 =?utf-8?B?bFhhUlRNMnhsSW1TZVJHVnhZakU1dkwxUTlaazRiY3luNStPL0kxQWlkVHVF?=
 =?utf-8?B?dEZYWW8xZ2daUUI2dVA5NFMzUU9JdzdLa29obGpMa28yNVB4enpaTTFueElm?=
 =?utf-8?B?bEpJRm1mNExINFVUNVVBdnFSYW1tWDVISEx2dm9sS1FucG5LbXErS0RNZ3lv?=
 =?utf-8?B?K29SUllYc253L0hMeFJWdlZEQmhJTHNrU21ndDgrVE9oTFhON1Zwd3ZsbW53?=
 =?utf-8?B?RHJPWk9YdFdhbW1WTnc4SnFCMnlqb2dvZVA2czhSRVJkR2VHM2F1dXZhUVJT?=
 =?utf-8?B?UUtqSlBCUkdVYnRic1BUdXA2bm5rUm5Qc2kzbUhaZjc5bU96UlFSQW9vc211?=
 =?utf-8?B?M2ptUW5YdUN5VDR3UWpEV2s4SDJHSkR4WXZGQ1pVZlZzb3ZzRmI5ODlFTUNZ?=
 =?utf-8?B?OWlBcWVkbkZEWXpyT3l0UjNHaDkwMTZmc21jdFg4d3pWNmpxT3JrYklrR1dp?=
 =?utf-8?B?TEZjSGY4dFN5UDVVaXN4Slc1cmhyRFRiVFBMeHprM1RyeW1CeUZkdllPNDA5?=
 =?utf-8?Q?FtnPyp7asMn1FmBH7MsTPtP12IA9EIvyrraSS2J?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bb62f65-b0bf-4952-9327-08d915666c6d
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2021 16:53:10.1943
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E3MYkGsWfLgUwT9gB47o/E0d5pj8ifEHynWTyG7pF5OtXAlQMXNMicvRxMqKjDMofdVBZCXlPyPwsM3sNxk4Ew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4429
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9982 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 suspectscore=0
 malwarescore=0 adultscore=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105120107
X-Proofpoint-ORIG-GUID: DGFcIR1baEHlOXFpqcan9tMur3ECtBmi
X-Proofpoint-GUID: DGFcIR1baEHlOXFpqcan9tMur3ECtBmi
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 5/3/21 9:37 AM, dai.ngo@oracle.com wrote:

> Hi Olga,
>
> Just a reminder that v4 patch is available for your review.

Ping again in case you did not get the last reminder.

-Dai

>
> Thanks,
>
> -Dai
>
> On 4/23/21 1:59 PM, Dai Ngo wrote:
>> Hi Olga,
>>
>> Currently the source's export is mounted and unmounted on every
>> inter-server copy operation. This causes unnecessary overhead
>> for each copy.
>>
>> This patch series is an enhancement to allow the export to remain
>> mounted for a configurable period (default to 15 minutes). If the
>> export is not being used for the configured time it will be unmounted
>> by a delayed task. If it's used again then its expiration time is
>> extended for another period.
>>
>> Since mount and unmount are no longer done on every copy request,
>> the restriction of copy size (14*rsize), in __nfs4_copy_file_range,
>> is removed.
>>
>> -Dai
>>
>> v2: fix compiler warning of missing prototype.
>> v3: remove the used of semaphore.
>>      eliminated all RPC calls for subsequence mount by allowing
>>         all exports from one server to share one vfsmount.
>>      make inter-server threshold a module configuration parameter.
>> v4: convert nsui_refcnt to use refcount_t.
>>      add note about 20secs wait in nfsd4_interssc_connect.
>>      removed (14*rsize) restriction from __nfs4_copy_file_range.
>>
>>
>>
