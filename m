Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02B7032038F
	for <lists+linux-nfs@lfdr.de>; Sat, 20 Feb 2021 04:43:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbhBTDmw (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 19 Feb 2021 22:42:52 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:38966 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229903AbhBTDmv (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 19 Feb 2021 22:42:51 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11K3PahD088913;
        Sat, 20 Feb 2021 03:42:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=tnPWAOB4GAFlBtoHLo9NBtkh/jvWyLyjDtpu+eOaR74=;
 b=Of6G/XiD22f7yZZckwDhakZ3DDmHtksQ9ZzkujfOQFLaDOzZFQnix5s4OvkiQdfMuyXj
 pl0dxnDFUMb6yuwEGAhRtwT307Ortt7aXYSO2hmfY41iMGHY7qFJaUEIBeoXKaB7xKgq
 OQUzkm+8gv6aVyknWfgVZ0nJxJNIGXtZyFE93zlgapWB2zP4Vz/OUMuw96k9Xw5VNbd8
 GS0u7KR6dqofjMTKNOYSI34NOaY4/nVDzzh/GWxuy4Qn7wStBJZKRPnS4+XrrzvyfBRz
 7Bie5fuYq8LCKl42Tgml9Pbq3S60n2uz8GAFJ8Pm4TR/BaM3IeR7jFQTgizt5k6MhYCR tg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2130.oracle.com with ESMTP id 36tqxb84ru-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 20 Feb 2021 03:42:05 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11K3eWCx015814;
        Sat, 20 Feb 2021 03:42:04 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
        by aserp3030.oracle.com with ESMTP id 36trf9agq7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 20 Feb 2021 03:42:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dgmmGhPphvB44/D8aZGJRRcNjMPb/0tphQtLnXr8BaOobeXO99GoHy1xyurNNvcagcPYBBCBnAovu6lYI7mMxp1q3rkzICQ1SUFOk3hwfngIypY5SSvrXRUujXBJ+vOxC8KCcaKtGj7pkF3ETPnPoodRcdbvtKAOKZ8S+xctbE0jERDyWtDOBgAbC/HD9SoA5rj0stycCGz8g43G/9B1Oen+KGgsqc+CAI8SjGfMxYD38GL0xd8j98eojoHdQwJzmT9VTKYJsTmlPMcTXQzLOanQuf8lluBNjbuRiQVOpZal2dKnU7huP8N961lswRLk4WwjtxYS9sBeytMTEw/Qcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tnPWAOB4GAFlBtoHLo9NBtkh/jvWyLyjDtpu+eOaR74=;
 b=Mh7+f+ROankIsVP1BnBMmfo1Xa7btdsTsLcB31qkaXTOY2/3dbX9c1AZ5sA+dOAEM8dvP01EcdwxA6SYV/7G6nkPu0eJUBQfwNTaXodIuWbkOf71fGB5ufiMXHzYPp0U+Jo9dmPrTKRoU0aPUYozVHmSasvccSli5q3u0DsVK7Uv5boMKU5R9BbWD5Xm/RFuur1XQtgRhVWA1wKo39ckJTt+ZIZ5gHqz3h7toomFK/QYgejdday/WgFUDJyD1s/sBHQfFRPxVZ/QYHsP78USc0bJPv8peMBjwRIDoUeQ0nxpkxY7Lzoi4gOVg1/NGOgUstMCoaowztIhhYAeZrqGRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tnPWAOB4GAFlBtoHLo9NBtkh/jvWyLyjDtpu+eOaR74=;
 b=K0tzU4R0supzVGeJ1lG7gNSjKk65/r3Y7R8jLaYfzMxoFTkfFCh6PnG1HAK2c7B93s31pyecrDpK5JJiE1gfy7lNkJoPKbI69hFMUCVGHR+7RGkspq7vInycl60bHOV+ElKz3Go4NBkv8//EtI1DD3WCeyhI9CPbC9Czst49GMI=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from BN7PR10MB2434.namprd10.prod.outlook.com (2603:10b6:406:c8::25)
 by BN6PR1001MB2132.namprd10.prod.outlook.com (2603:10b6:405:32::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.29; Sat, 20 Feb
 2021 03:42:01 +0000
Received: from BN7PR10MB2434.namprd10.prod.outlook.com
 ([fe80::20d8:7ca1:a6d5:be6b]) by BN7PR10MB2434.namprd10.prod.outlook.com
 ([fe80::20d8:7ca1:a6d5:be6b%3]) with mapi id 15.20.3846.041; Sat, 20 Feb 2021
 03:42:01 +0000
Subject: Re: [PATCH 1/2] NFSD: Fix use-after-free warning when doing
 inter-server copy
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     Olga Kornievskaia <aglo@umich.edu>,
        linux-nfs <linux-nfs@vger.kernel.org>
References: <20201029190716.70481-1-dai.ngo@oracle.com>
 <20201029190716.70481-2-dai.ngo@oracle.com>
 <CAN-5tyFnTSuMivnBPD9Aur+KDxX8fCOuSaF7qGKe6bFB7roK6Q@mail.gmail.com>
 <20210220010903.GE5357@fieldses.org>
 <69ea46ff-80d1-acfa-22a5-3d1b6230728f@oracle.com>
 <20210220032057.GA25183@fieldses.org>
From:   dai.ngo@oracle.com
Message-ID: <f152c5b7-d2ae-e0d3-5bea-7cc7a249d51c@oracle.com>
Date:   Fri, 19 Feb 2021 19:41:58 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.1
In-Reply-To: <20210220032057.GA25183@fieldses.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [72.219.112.78]
X-ClientProxiedBy: SJ0PR03CA0358.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::33) To BN7PR10MB2434.namprd10.prod.outlook.com
 (2603:10b6:406:c8::25)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Macbooks-MacBook-Pro.local (72.219.112.78) by SJ0PR03CA0358.namprd03.prod.outlook.com (2603:10b6:a03:39c::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.27 via Frontend Transport; Sat, 20 Feb 2021 03:42:01 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5fe46590-6184-48aa-a0d8-08d8d5517b95
X-MS-TrafficTypeDiagnostic: BN6PR1001MB2132:
X-Microsoft-Antispam-PRVS: <BN6PR1001MB21322E2576C7322C3797A20E87839@BN6PR1001MB2132.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X/cpiY2xx7+0PNwB9n36DNN7YmNUZgQI8a5dWrwWcKYyQu1WGBmcPCDd1QdN/8izyr0aNOGyEDGRby4U6cW9rWKdDm590dmWSuESayUfagoL3UZN7N/dYVynukjTKV8H0kBD0dwFclVJT6Qu/Ztx7uDHJtNHPPo8jVXMZgbBsan0qt5W93uTjqbNR+oVjzSSkAyTiaaCIwzjIAsrnPYZHvW/ZVSSlvHrVZFZvxgzXFfOzB+c0TVchMUPjkvjZRTLowkesLY1iYDaiI3W9VXbp1XJf79vpTVxNPZ1qhiDGVxD3c2GZtRdAi1bzlWC5VP3zoe//sIXKYRo+dtM242NlWTuBVoylcLtFRt8ZqzMASH6OqrwyRgiFZwopTaSwZF+MRl5qYj0PDWNrggGoZfBmTaXhtoJoVu4cxKGZnexCSeJN4F8EnIbY6ud4w1Wwk67ImbREmu21L6xyFG5/2HE+YRi9S0M4svjtpKP5EDn5uvFFtAAHHYJCzjQStJvL+8ySB9JYwNAny0qE/4JNpcbpbHVSawQmk+ex2wsOaWSzKP07nkiXGFPFKln9X5Wo6Z1HNktMsuxfK5ixP1d5CnD9w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN7PR10MB2434.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(136003)(346002)(396003)(376002)(366004)(6916009)(2616005)(6486002)(31696002)(5660300002)(8676002)(4326008)(956004)(6506007)(54906003)(31686004)(53546011)(2906002)(8936002)(316002)(86362001)(6512007)(26005)(16526019)(36756003)(66556008)(66476007)(6666004)(83380400001)(9686003)(66946007)(478600001)(186003)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?Z2h4ZmtsdGRSOUhERnJpZktkYkx3NVQvNWhjdFFhb2Q5bGYxZCtCQzU1ZE52?=
 =?utf-8?B?eCtTeEY5VW9HQVJ6RjRkN0ZGVlcyWm5JamVTR3VWZHcwdnJmUm82UDlYdXdM?=
 =?utf-8?B?cCtJK2hiNUgvbitrN2psYmRrR3BWUnpUOW42czdGZE5KZDRNYnF1S3EvdWpV?=
 =?utf-8?B?SG4xZldLU3JDOU1KSndHUjVVWkdVSHc1ZlMxenVSTDY3UjErZTZCbkFiZWlr?=
 =?utf-8?B?RE5kNGVxK3hKUTdybHFoWVVVTXVPUkJCcUpMRUJHL2V1R3lsYmZVZkx3MXJh?=
 =?utf-8?B?V3E0SjU0UGhpQ2dEK0xRd2dzai9ZQlVhSVZLcFY5dkZxY1dpY0dXMFhrRnEr?=
 =?utf-8?B?RkJsNlVwOTlEVnUrOWJlSVp3d0dhcXl3UENJbWNHdWVRV0RCMjU4c1lONDlG?=
 =?utf-8?B?TVBXMkpNbExRV254SmR2SlRLSVZrUWxDTDR6QU1TQTExTUNrYU1WZ0NJZDR5?=
 =?utf-8?B?OUU4US8rb0JoUEVuTnljWHNORFpmRkhpWFpETUlwb0lzS0lpVUxaN0gwTDNJ?=
 =?utf-8?B?aGNIMWIzelkzekpuamZUbnJlMGJSK05Va1dOTHBRZjdXdldnNjd5SE5pVlpj?=
 =?utf-8?B?WEdWM0t0UzNpWUE3QjVqR0dBMGRSOGdpWHRvcmNINGcwb1kyK3VDVGhaTGdO?=
 =?utf-8?B?dy85TUMwTVNlSDJaSUp3K09BWDFrVUc2MVRNeDVEK3c5Y2JJZGprWmJCTFZo?=
 =?utf-8?B?RlFuejF6bGFhazhuNmViWDZjdnRuVFJFVkRHQ29ubU9QZ0ZhVkVHSms0cXBz?=
 =?utf-8?B?MjZaQ3AxdXNUTTF3Y0JIS1ZydDNIeEcwaUw5Sk05MGdqVE5vdi96eGVtZ0RT?=
 =?utf-8?B?UWhvWFQ3MUZhWCtDa1Q5d0REeVJPUzVNOGNPdDZSR1VkRFRjcjBKWEdHWUZE?=
 =?utf-8?B?bkJ3QTB3NjlSUHErb2xIWkZSeHE1UTNKUGJWOXBBWFdLNWtaVkprQS93cWIx?=
 =?utf-8?B?dk1zQ05OeEs3NS95cmg0QXNOeFVLZUdHV0J3aHA1RUptZ25XeTBNZFNPTmxh?=
 =?utf-8?B?MENEYWJsZ2VLa2RMVjQ0dmR1NzUwSnlEVy9OT2w2bUQ0dC8yWFlrUTJiWVNx?=
 =?utf-8?B?cFUvcWRRRHBIWlVnV1ViQUFRNlhFeGp6SmladGxSK00ydzZWWEYwS1FtelRx?=
 =?utf-8?B?T1N5bHJpNHpaZVI4ZUUxcnpTR3MyZVNsVWlXeU1FSlNIODhFOGtibTNFa1cy?=
 =?utf-8?B?YjQySWlLbFEvNFBTUm9Ia21tYW5HV2pGZG5ZY3p1c1ZRUVdHNmt6TU5EdTAw?=
 =?utf-8?B?ODV3T2ZXVWJjWnBIWGFtVGVuZTN6L2h2b21CMHo3VjVkOWIyTldIRjl3VjRU?=
 =?utf-8?B?UlBvT3ZRcHJWT2RBd1BhMXc5Wm11cnFxVmxkSXdkWlI1OWZwbnpwYkhWQm85?=
 =?utf-8?B?RmpMYU9LKzUrQ0o2cS9Yc2EyRkpVQkpBMk9UdWVoZXkwZkduZVVRMTRRaXMx?=
 =?utf-8?B?YS84MEpzSVRkaGJXTHFhRUFvMEQ2UUpaNlg1L3Z6OWVTS0pFVWV6N2l4TlVK?=
 =?utf-8?B?ZFNzZEcyclU2WE90cVhvdXFVNkl0UWdQZzUraVdXMXhHSXhIdmN6Tm95Q0xT?=
 =?utf-8?B?SXdSbE9UUWpXNkMvcDR2b2Zscm9Mc0pkVzlJb3kzSmp4ckZZM1duQWNNOGtM?=
 =?utf-8?B?L2h0MnJwbFJWc3hZY2h1R0llbDhUUnVIRHRKMVBVVUVTbFhPZkRCOVAzVFdq?=
 =?utf-8?B?dTllWmRBNXBFSjRVUWsxNkNaeENBOVZSSk5qc0pCNFVGWlBtZ2pUMDlxSHM0?=
 =?utf-8?Q?UY03G63sMLAYISOhmVENV5iWQ1Cl5e8oGMiyMqC?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fe46590-6184-48aa-a0d8-08d8d5517b95
X-MS-Exchange-CrossTenant-AuthSource: BN7PR10MB2434.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2021 03:42:01.8044
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vtRuAr3Fal7ArcKdp60GaQKEr3qpTHjxadObCp+qsuAmcHMMGtX+WojMR7pVC7LgdTQPjB59KUPSLHouob/Dpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1001MB2132
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9900 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 phishscore=0
 mlxlogscore=999 adultscore=0 suspectscore=0 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102200029
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9900 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 phishscore=0
 mlxlogscore=999 malwarescore=0 clxscore=1015 suspectscore=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 priorityscore=1501 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102200028
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


On 2/19/21 7:20 PM, J. Bruce Fields wrote:
> On Fri, Feb 19, 2021 at 05:31:58PM -0800, dai.ngo@oracle.com wrote:
>> If this is the cause why we don't drop the mount after the copy
>> then I can restore the patch and look into this problem. Unfortunately,
>> all my test machines are down for maintenance until Sunday/Monday.
> I think we can take some time to figure out what's actually going on
> here before reverting anything.

Thanks Bruce, I will look into this.

-Dai

>
> --b.
>
>> -Dai
>>
>> On 2/19/21 5:09 PM, J. Bruce Fields wrote:
>>> Dai, do you have a copy of the original use-after-free warning?
>>>
>>> --b.
>>>
>>> On Fri, Feb 19, 2021 at 07:18:53PM -0500, Olga Kornievskaia wrote:
>>>> Hi Dai (Bruce),
>>>>
>>>> This patch is what broke the mount that's now left behind between the
>>>> source server and the destination server. We are no longer dropping
>>>> the necessary reference on the mount to go away. I haven't been paying
>>>> as much attention as I should have been to the changes. The original
>>>> code called fput(src) so a simple refcount of the file. Then things
>>>> got complicated and moved to nfsd_file_put(). So I don't understand
>>>> complexity. But we need to do some kind of put to decrement the needed
>>>> reference on the superblock. Bruce any ideas? Can we go back to
>>>> fput()?
>>>>
>>>> On Thu, Oct 29, 2020 at 3:08 PM Dai Ngo <dai.ngo@oracle.com> wrote:
>>>>> The source file nfsd_file is not constructed the same as other
>>>>> nfsd_file's via nfsd_file_alloc. nfsd_file_put should not be
>>>>> called to free the object; nfsd_file_put is not the inverse of
>>>>> kzalloc, instead kfree is called by nfsd4_do_async_copy when done.
>>>>>
>>>>> Fixes: ce0887ac96d3 ("NFSD add nfs4 inter ssc to nfsd4_copy")
>>>>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>>>>> ---
>>>>>   fs/nfsd/nfs4proc.c | 2 +-
>>>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
>>>>> index ad2fa1a8e7ad..9c43cad7e408 100644
>>>>> --- a/fs/nfsd/nfs4proc.c
>>>>> +++ b/fs/nfsd/nfs4proc.c
>>>>> @@ -1299,7 +1299,7 @@ nfsd4_cleanup_inter_ssc(struct vfsmount *ss_mnt, struct nfsd_file *src,
>>>>>                          struct nfsd_file *dst)
>>>>>   {
>>>>>          nfs42_ssc_close(src->nf_file);
>>>>> -       nfsd_file_put(src);
>>>>> +       /* 'src' is freed by nfsd4_do_async_copy */
>>>>>          nfsd_file_put(dst);
>>>>>          mntput(ss_mnt);
>>>>>   }
>>>>> --
>>>>> 2.20.1.1226.g1595ea5.dirty
>>>>>
