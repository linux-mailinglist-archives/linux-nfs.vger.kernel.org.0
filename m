Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81577612B92
	for <lists+linux-nfs@lfdr.de>; Sun, 30 Oct 2022 17:16:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbiJ3QQy (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 30 Oct 2022 12:16:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbiJ3QQw (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 30 Oct 2022 12:16:52 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D020165E4
        for <linux-nfs@vger.kernel.org>; Sun, 30 Oct 2022 09:16:50 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29U8MOl7020445;
        Sun, 30 Oct 2022 16:16:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=KTrwRqdVdmhfmDq8WZou6ItxXkGnMM5R+ZeKR4A1jPc=;
 b=HmECqkESIvp0696tPpuFcMVa0nbfm5Dhdb+S6zHEO4Eq1xT05/BbJWru49M2eIqLpBsx
 06FtmYRup8AEFdIJctxk5GKnTih0XjYXoLDkWwICVEDI281fnm1x2ZRYKo7szsJ+nsZ4
 0aDK2HMxm99bf2yuSYNTEgMAHoB9YT6jMKQTD07mwY5zA26YSITZ36kFKfZrlCQsD6X+
 kyDRm4/tMwntv86XmYhgHr90DIDbduoEbgAWwILUVKPx6T7uqJQ8hFCZ8atc1IYnNhTH
 gspYFkk0d836je4a3yT0bS9bAk+PAI7BpOwVjumzBJRhenS0djN9Em+Wb/imfIkgvlPN oQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kgv2a9rbq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 30 Oct 2022 16:16:44 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29UDi7xM010792;
        Sun, 30 Oct 2022 16:16:43 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2045.outbound.protection.outlook.com [104.47.57.45])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kgtm8gycr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 30 Oct 2022 16:16:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ICtiiFAyg6wkWfr8SOtrq6QSwKz82ieeZxkN/DcLyFcuhaubQAIz23iSWZ92EaXg1qA8C1nkQ31KDvy8JTNf3jSSGX1wSLWOhoWF8Ofr87V31srt56gEU55QnAiQQv14Rw/qjZUrLUk6I0XYuiqyIy1qhrxLxABaqAdS0MMyoK36fUPIbjB4WQPMt2m5/tpqu9G8YxVTWXPkKxOR+3PP9bal9qX2W2xUmM14Gognh7X+fJ+4HyaWNcBzEdufYQHAy0QmIofWFIQExHBLjMF6U0EeIwicH2UG5Wl6T2Rc8PZ2sAFQpzqj0Wx7Z9rvsr5/1LSNEHfvMfqckped1DsOkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KTrwRqdVdmhfmDq8WZou6ItxXkGnMM5R+ZeKR4A1jPc=;
 b=D1YyNVDkV2qxJmk/E2Z0vcBFHbKgFASYk1Yc4oU+78ycxjzCFjeyPmdBCtFdnlVrAX5Nr8M51id/1pAgMwP5UFTL0Lf1fKrD86PC/aOyUwQ2Qmpl5E2KWba6URczcZE83M+9nYil9YxGEOM0qRz4GdFm2pw77I7fl9N0KWtCDo5HJ6pXTUahTXjo8eQiyCr3q5HBHaAnDVVRuidCejK3wbj4/SiSL4/9yQRPRcyyvaFmtgt0Q6XNeymuf5eQZeU7GLoLPTrGdyZLjZFz8XiSDubu7e0k68C3tsmOlYzb+PoBGIYBH7tM2GXAwD/fSggOKFDgDmOyjKY6zaZhN0+5jA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KTrwRqdVdmhfmDq8WZou6ItxXkGnMM5R+ZeKR4A1jPc=;
 b=e4pw9YCyXzcZUiUmEDAHJy8ILDVqTXnqKJsWXoBCaNlPg6klTgPVaBiN3IT4Q2sivJWWE3/ZmN/6jOgZO1HTM0ywbCWfVFMIJwRzHC6BsFXo4vO9GhmgMgzioVe1f3aA1xr1Yzfxs/an0RF+UgiYWvkeRZ+4b5xFnDF1p/Uhd4c=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by PH7PR10MB5724.namprd10.prod.outlook.com (2603:10b6:510:125::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.16; Sun, 30 Oct
 2022 16:16:41 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::8bd:d43:8279:fa67]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::8bd:d43:8279:fa67%6]) with mapi id 15.20.5769.019; Sun, 30 Oct 2022
 16:16:40 +0000
Message-ID: <a29c1888-d260-1108-5365-8385192b4367@oracle.com>
Date:   Sun, 30 Oct 2022 09:16:38 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.1
Subject: Re: [PATCH v3 1/2] NFSD: add support for sending CB_RECALL_ANY
Content-Language: en-US
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     "jlayton@kernel.org" <jlayton@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
References: <1666923369-21235-1-git-send-email-dai.ngo@oracle.com>
 <1666923369-21235-2-git-send-email-dai.ngo@oracle.com>
 <D080D405-5567-4581-A347-417E859A568D@oracle.com>
From:   dai.ngo@oracle.com
In-Reply-To: <D080D405-5567-4581-A347-417E859A568D@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR17CA0049.namprd17.prod.outlook.com
 (2603:10b6:a03:167::26) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4257:EE_|PH7PR10MB5724:EE_
X-MS-Office365-Filtering-Correlation-Id: 97076e90-8866-450f-69d8-08daba9220b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I8Apx6OlWr3n7mtwwF63MZHzYpI8g6WN+72RtuxquU4TIDQbvdBWkJBD0jJ1gkkhD7rv5fTqDKlvUnyTeZsUfxcYDLb7A1dXYbe+nMAZJ1+2gxQJwPyG923QT6GgXdLahCg/UPwZoDED7DWdCDL1LhJs+gMZWo3/HG3kSAJZmusYVsgPBzu2r/fSoxlUxIu21H2mBsqaUZjc+x3KLf9M4U23KzopkTIJztJ2h0VaL+d7LCNLtE8Yg3EUdOHYQjGSmsyddWNzydSR9Eo9bl/RyiwqsfPvJ652IvBYR4zOocO+E/xrblJEBriEySi+Kk9weaRD0Mzld9+TgA3FDQMSr6N/Utt6rJi6YDQOMx2dE/0CAAIw/GlX8jJvkzyVqhqV8LXPq717ZpvgqXNHOATA4xjw3GbFGFASwavudRstCxA6ZDaBSGljKhEye4EovmVN2PUXbX/7uJCfjfYdMgEt3MM3ADNrd0Fc5UKJE2YMxrzqm91tmILFqeZHULAxQ0Kzan3d0MYLo051v9VCJhKczj/J/11Q1vZ6EFEaUvS6ey+QU7SbeiLwxTsSBEkpwKG/75ymTvtNipXCN9huccV1Q6vCQ19DJ5xGowULM8Y7LjJBFyGnwS/fCiyCIhd5NHAh3Vn6MKpmAhxYV0TM0PotX3gHC/PdD4Fj0Daf7zNkbQP40BSL5yxTsRj9QMfpQ475djGx02yskKk7BJTQ2fAKMlDnQp7Jy/esE9ISwtT9FUuX6V+uNKe6kDWy1LeUuM6I
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(346002)(39860400002)(136003)(376002)(366004)(451199015)(38100700002)(83380400001)(66899015)(31686004)(2906002)(6486002)(86362001)(31696002)(53546011)(66556008)(6512007)(26005)(2616005)(9686003)(186003)(316002)(36756003)(8676002)(478600001)(66476007)(4326008)(6506007)(37006003)(41300700001)(8936002)(6862004)(54906003)(66946007)(5660300002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZHZXTndFbHhOd0cvRk13UUhYMWVoTjJHZ2tQR0pnZXNKdDd1Q29YdWlOOW9o?=
 =?utf-8?B?bHNQMkFxYnRxekFMK1NpaHg2Ris1NTd0RUNiSU42VWp2MUdRL1l1UENiVDNu?=
 =?utf-8?B?V1l6eE4xV0EwWGxzbk5USDNFU2FzOTUzWkIrVFRyblh1UXJrazYxemxSamhH?=
 =?utf-8?B?cU16VEloc1N3bTVuZE9YdmVnYVU1eGF4b2NERUhTaWNueU5UL1N6UWo5VDk2?=
 =?utf-8?B?MDhvUFd3ZURnV1V2T2hmbDhFdm1nekUrWkRkQlFDUUtLUkFvR2ZyeHRaOExu?=
 =?utf-8?B?cE02QlIzbkpmWXNpeDVqVDNrMTRIOXJKN3hPL3NvcEtDREk2TmtIUG5PZC8x?=
 =?utf-8?B?R1dMVkVNK0JudVVxRTlNbnl2dkE3T0xxTEV0SC9UWGV6MTlLZkdZTWQxQ3FY?=
 =?utf-8?B?R1dLTDJHcTVDWHJXOTZSNktaRW1MaUl3dVhOaTlZOVphbWU2N0JoNklwbFEz?=
 =?utf-8?B?dWVXWFJsUkhCOXQ5aGxOakhjUmZwclJzTmdFR0VBSmdPam9qbmk5VXB1M25a?=
 =?utf-8?B?NExGOHFlOHBYR1lUOFBaOW1uQ3FBUkhCdTM3Y3VTaHJMUlIrTE9LYWkyenZS?=
 =?utf-8?B?cForYlB0dk1lUVhqb3IrRExlR1kzOUZUL3B5WUpKOWJjTjhJaEtkL3dIcHJr?=
 =?utf-8?B?eWorNU1JbzJBbVljTDMzV3g1cU91bk5OUFE0ZzFBdVYzUTRXYnhWYnFtR1VO?=
 =?utf-8?B?UG1BVERRK2QzOGZOWW11RHN2YkZ5UkxjZWhwU2tNMmUzMnJXY2RTclFGaVR4?=
 =?utf-8?B?R1RKd2VzK1V3NGFvMzUwMm5RbDdHYWpack8zTTk4b1JvdkVPRG9rZHVRejF2?=
 =?utf-8?B?Ykl0ckdwdnM4aWFzWkhtY283TEtXUk5oR3lQSFRJcitkT05JK2NZMjEwaTNo?=
 =?utf-8?B?YW5VVllKaXk1OU9XNW5aL1ZGS0ZyVXFNRmpuOVgycUpPNDIwRXh5a1J6Vkwz?=
 =?utf-8?B?QjBWYjZCODQ3VUpLZ3RUYXZsUUlUdzIyWVZRekdndklSdXBiNHVnYWhLWnZH?=
 =?utf-8?B?cklRRzB6VHZLS01Bd2R4Wk5CWExTZnA5MzczaGNZY002TURJU3FCTCsxbUdu?=
 =?utf-8?B?bzZCYkp4bFgrOUQ2a2UxNmlGdjFRd0UwNzF1QVdhUFRhRDNadlJ4VXNoUTkw?=
 =?utf-8?B?SFNZTTVHVFZIQzJSRS9OdWJiS0RpVG5MMWI1ZFhHMkNyR0JJVDUwUWNPMmZJ?=
 =?utf-8?B?cVpJeE01bUdwMDZPUzd1NlFoa1UydnFZRzEvaDNNY2UrdUN5ZWNtamZ6RU01?=
 =?utf-8?B?ZU9aL2R3YURQTWRwZWpEQS9oVkNvZXZETTEzSUhsSEJIWkdvcFVDaU51T1Ey?=
 =?utf-8?B?ejk1Ukg0K2IvWHUzZSs4T096aUEzZDlkMGFjWU16MjR2TGFtNEptSE5WdWhi?=
 =?utf-8?B?U2xDQjhydHlaTHk1UzZhcS80OCt0ZGpuUEZYRDE4OWFXaHFEalRzd0RkZnRT?=
 =?utf-8?B?Nzk1dHkxT1QzdkUvcDVmL3NXTXRIR0NWeW1YUXFwcjdTRlYwTkFpcTV5N0wr?=
 =?utf-8?B?dXcvQ0JwbjRtOERzd1lCd083b1JFc3M2TC92cEl4WkVoT1Y0L20vMWdtcng2?=
 =?utf-8?B?UTZiaUQrWlRZczJJb0VoZU9hTnU4L1M2UVVXYmk2K0VOZWM1bE5lcEd5NEJ1?=
 =?utf-8?B?Z09acEVGbjJicWhtMW4zSS9rUDRiVTNDanY1WktRTDBrUGJodWVUYTMzSlBp?=
 =?utf-8?B?TDZuRHNrSThoWmRqWkdZTmNmdTdYYVUyVzgyK3NsdjZTaWxkcmVNdmdLd0RQ?=
 =?utf-8?B?QS9hK1ZHeHVTek9JSG9nbjZwZTM2MFErMzNBcDBwOTdJTGQzZk9jZ3ZnSlRY?=
 =?utf-8?B?RU1KRUdrTlZUdXZiVVBhZXlmd2lyTEZpb1Q0T3BGa0FQQk4rZWM1K1VUUm1r?=
 =?utf-8?B?QVA0R2g0V1VtSnFPL0ZJUjBVYyt1QlNja25vVjdFd0FldHl3TlR2MEJJYXdv?=
 =?utf-8?B?bmZ3dE1kamtFQ1orWWI4MllaYXBkSWxyMXRSQytwL3lsaEZzNkhhYTV0MDV3?=
 =?utf-8?B?RytJeGJCKzQ1aFl0ckJDTGEwV2lnbXFVcXV1dW5BYmJZVW5IUkRzL093djdC?=
 =?utf-8?B?bHhma2NQblUwanJ4UWhUTU9kM2t4aFFET1M0U2N4aW1WTnoremxndng1R21K?=
 =?utf-8?Q?CDeYiuoGUq5EB82sMq/g0ojp9?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97076e90-8866-450f-69d8-08daba9220b1
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2022 16:16:40.4710
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jX1WY/rn4BsdaH8yABjOLJ46xwBaydEnY9fDkdAwiTI3I4YmkwcL+zD9I/Nf5Wjf5XamzVNFJknV02yLpcUmIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5724
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-30_10,2022-10-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 mlxscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 phishscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2210300108
X-Proofpoint-ORIG-GUID: Y9cEI15XUVL8mCvM2-v6GhogRqvPIq_p
X-Proofpoint-GUID: Y9cEI15XUVL8mCvM2-v6GhogRqvPIq_p
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 10/28/22 7:11 AM, Chuck Lever III wrote:
>
>> On Oct 27, 2022, at 10:16 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
>>
>> There is only one nfsd4_callback, cl_recall_any, added for each
>> nfs4_client.
> Is only one needed at a time, or might NFSD need to send more
> than one concurrently? So far it looks like the only reason to
> limit it to one at a time is the way the cb_recall_any arguments
> are passed to the XDR layer.

We only need to send one CB_RECALL_ANY for each client that hold
delegations so just one nfsd4_callback needed for this purpose.
Do you see a need to support multiple nfsd4_callback's per client
for cl_recall_any?

>
>
>> Access to it must be serialized. For now it's done
>> by the cl_recall_any_busy flag since it's used only by the
>> delegation shrinker. If there is another consumer of CB_RECALL_ANY
>> then a spinlock must be used.
> The usual arrangement is to add the XDR infrastructure for a new
> operation in one patch, and then add consumers in subsequent
> patches. Can you move the hunks that change fs/nfsd/nfs4state.c
> to 2/2 and update the above description accordingly?

fix in v4.

>
> In a separate patch you should add a trace_nfsd_cb_recall_any and
> a trace_nfsd_cb_recall_any_done tracepoint. There are already nice
> examples in fs/nfsd/trace.h for the other callback operations.

fix in v4.

>
>
> A little more below.
>
>
>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>> ---
>> fs/nfsd/nfs4callback.c | 64 ++++++++++++++++++++++++++++++++++++++++++++++++++
>> fs/nfsd/nfs4state.c    | 32 +++++++++++++++++++++++++
>> fs/nfsd/state.h        |  8 +++++++
>> fs/nfsd/xdr4cb.h       |  6 +++++
>> 4 files changed, 110 insertions(+)
>>
>> diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
>> index f0e69edf5f0f..03587e1397f4 100644
>> --- a/fs/nfsd/nfs4callback.c
>> +++ b/fs/nfsd/nfs4callback.c
>> @@ -329,6 +329,29 @@ static void encode_cb_recall4args(struct xdr_stream *xdr,
>> }
>>
>> /*
>> + * CB_RECALLANY4args
>> + *
>> + *	struct CB_RECALLANY4args {
>> + *		uint32_t	craa_objects_to_keep;
>> + *		bitmap4		craa_type_mask;
>> + *	};
>> + */
>> +static void
>> +encode_cb_recallany4args(struct xdr_stream *xdr,
>> +			struct nfs4_cb_compound_hdr *hdr, uint32_t bmval)
>> +{
>> +	__be32 *p;
>> +
>> +	encode_nfs_cb_opnum4(xdr, OP_CB_RECALL_ANY);
>> +	p = xdr_reserve_space(xdr, 4);
>> +	*p++ = xdr_zero;	/* craa_objects_to_keep */
> Let's use xdr_stream_encode_u32() here.

Yes, we can use xdr_stream_encode_u32() here. However xdr_stream_encode_u32
can return error and currently all the xdr encoding functions,
nfs4_xdr_enc_xxxx, are defined to return void so rpcauth_wrap_req_encode
just ignores encode errors always return 0. Note that gss_wrap_req_integ
and gss_wrap_req_priv actually return encoding errors.

>   Would it be reasonable
> for the upper layer to provide this value, or will NFSD always
> want it to be zero?

Ideally the XDR encode routine should not make any decision regarding
how many objects the client can keep, it's up to the consumer of the
CB_RECALL_ANY to decide. However in this case, NFSD always want to set
this to 0 so instead of passing this in as another argument to the
encoder, I just did the short cut here. Do you want to pass this in
as an argument?

>
>
>> +	p = xdr_reserve_space(xdr, 8);
> Let's use xdr_stream_encode_uint32_array() here. encode_cb_recallany4args's
> caller should pass a u32 * and a length, not just a simple u32.

fix in v4.

>
>
>> +	*p++ = cpu_to_be32(1);
>> +	*p++ = cpu_to_be32(bmval);
>> +	hdr->nops++;
>> +}
>> +
>> +/*
>>   * CB_SEQUENCE4args
>>   *
>>   *	struct CB_SEQUENCE4args {
>> @@ -482,6 +505,24 @@ static void nfs4_xdr_enc_cb_recall(struct rpc_rqst *req, struct xdr_stream *xdr,
>> 	encode_cb_nops(&hdr);
>> }
>>
>> +/*
>> + * 20.6. Operation 8: CB_RECALL_ANY - Keep Any N Recallable Objects
>> + */
>> +static void
>> +nfs4_xdr_enc_cb_recall_any(struct rpc_rqst *req,
>> +		struct xdr_stream *xdr, const void *data)
>> +{
>> +	const struct nfsd4_callback *cb = data;
>> +	struct nfs4_cb_compound_hdr hdr = {
>> +		.ident = cb->cb_clp->cl_cb_ident,
>> +		.minorversion = cb->cb_clp->cl_minorversion,
>> +	};
>> +
>> +	encode_cb_compound4args(xdr, &hdr);
>> +	encode_cb_sequence4args(xdr, cb, &hdr);
>> +	encode_cb_recallany4args(xdr, &hdr, cb->cb_clp->cl_recall_any_bm);
>> +	encode_cb_nops(&hdr);
>> +}
>>
>> /*
>>   * NFSv4.0 and NFSv4.1 XDR decode functions
>> @@ -520,6 +561,28 @@ static int nfs4_xdr_dec_cb_recall(struct rpc_rqst *rqstp,
>> 	return decode_cb_op_status(xdr, OP_CB_RECALL, &cb->cb_status);
>> }
>>
>> +/*
>> + * 20.6. Operation 8: CB_RECALL_ANY - Keep Any N Recallable Objects
>> + */
>> +static int
>> +nfs4_xdr_dec_cb_recall_any(struct rpc_rqst *rqstp,
>> +				  struct xdr_stream *xdr,
>> +				  void *data)
>> +{
>> +	struct nfsd4_callback *cb = data;
>> +	struct nfs4_cb_compound_hdr hdr;
>> +	int status;
>> +
>> +	status = decode_cb_compound4res(xdr, &hdr);
>> +	if (unlikely(status))
>> +		return status;
>> +	status = decode_cb_sequence4res(xdr, cb);
>> +	if (unlikely(status || cb->cb_seq_status))
>> +		return status;
>> +	status =  decode_cb_op_status(xdr, OP_CB_RECALL_ANY, &cb->cb_status);
>> +	return status;
>> +}
>> +
>> #ifdef CONFIG_NFSD_PNFS
>> /*
>>   * CB_LAYOUTRECALL4args
>> @@ -783,6 +846,7 @@ static const struct rpc_procinfo nfs4_cb_procedures[] = {
>> #endif
>> 	PROC(CB_NOTIFY_LOCK,	COMPOUND,	cb_notify_lock,	cb_notify_lock),
>> 	PROC(CB_OFFLOAD,	COMPOUND,	cb_offload,	cb_offload),
>> +	PROC(CB_RECALL_ANY,	COMPOUND,	cb_recall_any,	cb_recall_any),
>> };
>>
>> static unsigned int nfs4_cb_counts[ARRAY_SIZE(nfs4_cb_procedures)];
>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>> index 4e718500a00c..68d049973ce3 100644
>> --- a/fs/nfsd/nfs4state.c
>> +++ b/fs/nfsd/nfs4state.c
>> @@ -2854,6 +2854,36 @@ static const struct tree_descr client_files[] = {
>> 	[3] = {""},
>> };
>>
>> +static int
>> +nfsd4_cb_recall_any_done(struct nfsd4_callback *cb,
>> +			struct rpc_task *task)
>> +{
>> +	switch (task->tk_status) {
>> +	case -NFS4ERR_DELAY:
>> +		rpc_delay(task, 2 * HZ);
>> +		return 0;
>> +	default:
>> +		return 1;
>> +	}
>> +}
>> +
>> +static void
>> +nfsd4_cb_recall_any_release(struct nfsd4_callback *cb)
>> +{
>> +	struct nfs4_client *clp = cb->cb_clp;
>> +	struct nfsd_net *nn = net_generic(clp->net, nfsd_net_id);
>> +
>> +	spin_lock(&nn->client_lock);
>> +	clp->cl_recall_any_busy = false;
>> +	put_client_renew_locked(clp);
>> +	spin_unlock(&nn->client_lock);
>> +}
>> +
>> +static const struct nfsd4_callback_ops nfsd4_cb_recall_any_ops = {
>> +	.done		= nfsd4_cb_recall_any_done,
>> +	.release	= nfsd4_cb_recall_any_release,
>> +};
>> +
>> static struct nfs4_client *create_client(struct xdr_netobj name,
>> 		struct svc_rqst *rqstp, nfs4_verifier *verf)
>> {
>> @@ -2891,6 +2921,8 @@ static struct nfs4_client *create_client(struct xdr_netobj name,
>> 		free_client(clp);
>> 		return NULL;
>> 	}
>> +	nfsd4_init_cb(&clp->cl_recall_any, clp, &nfsd4_cb_recall_any_ops,
>> +			NFSPROC4_CLNT_CB_RECALL_ANY);
>> 	return clp;
>> }
>>
>> diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
>> index e2daef3cc003..49ca06169642 100644
>> --- a/fs/nfsd/state.h
>> +++ b/fs/nfsd/state.h
>> @@ -411,6 +411,10 @@ struct nfs4_client {
>>
>> 	unsigned int		cl_state;
>> 	atomic_t		cl_delegs_in_recall;
>> +
>> +	bool			cl_recall_any_busy;
> Rather than adding a boolean field, you could add a bit to
> cl_flags.

fix in v4.

>
> I'm not convinced you need to add the argument fields here...
> I think kmalloc'ing the arguments and then freeing them in
> nfsd4_cb_recall_any_release() would be sufficient.

Since cb_recall_any is sent when we're running low on system memory,
I'm trying not to use kmalloc'ing to avoid potential deadlock or adding
more stress to the system.

Thanks!
-Dai

>
>
>> +	uint32_t		cl_recall_any_bm;
>> +	struct nfsd4_callback	cl_recall_any;
>> };
>>
>> /* struct nfs4_client_reset
>> @@ -639,8 +643,12 @@ enum nfsd4_cb_op {
>> 	NFSPROC4_CLNT_CB_OFFLOAD,
>> 	NFSPROC4_CLNT_CB_SEQUENCE,
>> 	NFSPROC4_CLNT_CB_NOTIFY_LOCK,
>> +	NFSPROC4_CLNT_CB_RECALL_ANY,
>> };
>>
>> +#define RCA4_TYPE_MASK_RDATA_DLG	0
>> +#define RCA4_TYPE_MASK_WDATA_DLG	1
>> +
>> /* Returns true iff a is later than b: */
>> static inline bool nfsd4_stateid_generation_after(stateid_t *a, stateid_t *b)
>> {
>> diff --git a/fs/nfsd/xdr4cb.h b/fs/nfsd/xdr4cb.h
>> index 547cf07cf4e0..0d39af1b00a0 100644
>> --- a/fs/nfsd/xdr4cb.h
>> +++ b/fs/nfsd/xdr4cb.h
>> @@ -48,3 +48,9 @@
>> #define NFS4_dec_cb_offload_sz		(cb_compound_dec_hdr_sz  +      \
>> 					cb_sequence_dec_sz +            \
>> 					op_dec_sz)
>> +#define NFS4_enc_cb_recall_any_sz	(cb_compound_enc_hdr_sz +       \
>> +					cb_sequence_enc_sz +            \
>> +					1 + 1 + 1)
>> +#define NFS4_dec_cb_recall_any_sz	(cb_compound_dec_hdr_sz  +      \
>> +					cb_sequence_dec_sz +            \
>> +					op_dec_sz)
>> -- 
>> 2.9.5
>>
> --
> Chuck Lever
>
>
>
