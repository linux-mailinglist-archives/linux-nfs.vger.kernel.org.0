Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E4C852A3A4
	for <lists+linux-nfs@lfdr.de>; Tue, 17 May 2022 15:40:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346696AbiEQNkR (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 17 May 2022 09:40:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242699AbiEQNkQ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 17 May 2022 09:40:16 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on2106.outbound.protection.outlook.com [40.107.212.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2357A4CD68
        for <linux-nfs@vger.kernel.org>; Tue, 17 May 2022 06:40:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lzqNk+6HRtup6S2gufpM4tJQXdPQpe0yynkfRkRm5FOAVE/4Fc6aKJCzmB+Oq4C5THIr/r3KyUAFlrVQUU7+CKhgqiIbCCvIjaJoxwPxRMSefrGyeXymXphxDIrKBHh/PgjIcT1P9zDmjtHWLco5Ges8L5jzAxvlX+Q1R2CexJcDPLYyYnZYyocT6tZWnhgLPsF2VFUxj+qR3Go0y26yev9RCpK3Ou0ZfrQPppY5/qehwGp/1ABhx8mFpXWeiWtnEjRA5+L8OABcR642sxtTlRF68uejjb1zlFmuifZcyExnJYjJMvbUzatJX1MjDZIcmWFF31A039Az8PkT+GNmLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/5gSkQBrDrEYrVdu5c7aYDd8fEuzEQkwmULn6MnNZ3s=;
 b=drfj0k2rR8EfpBVhaX+NQJo7PJRsXgQnHRAYCFai6CAIGhW+tv/7I7pkgPn2Aj+7v2mV/gJnyvNozyUu419YPuJ8Wj2p4Ta0ULb6V2hgkFjsSrXbeXfLxcCraflU36+RDQpDbuABXFN8i33IzD1RUVuI8uNGjzoUziBUJZCpVmwkdw1mrTXPKuS1pPeBvemcQcbqkFMc/hJ+SYMs3X6NZ3e0OKtzhedwK3WrpjmsBxtaq2cNC/b+tlFvtjLxy4OZDcZDgSIIxeYrUT2cJpaDvBPKYNXLGshNtnM/5tsbX7WBinW7156GcPdZNv+qOXLabcv1xy9r/sKv1pIKxCKyZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass action=none
 header.from=cornelisnetworks.com; dkim=pass header.d=cornelisnetworks.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/5gSkQBrDrEYrVdu5c7aYDd8fEuzEQkwmULn6MnNZ3s=;
 b=MrAnEoMauVzUBaQFh0BEE2wAgkAgZhhpkz731t+HM0mgMIQ4tOJ3kpxgvzIJhMLitA6QYd3pYowmBMJPj4qYYYJ2tdZwJ/zjRyMoM39X060U9Xl1ThtfxaSgW3w8Ad3CyrIzEyv1jvnoHaP+VJo8UyjbqjNVDrgoem1IumLLVZKvp+DroxvcE6DGNK7q5n95VQPuiZ+KBbn9UtnOTdy9fYyI8XTJH/O4GsR2UkMRxi+CV1OPkoEzkT56SsQrVgqnHPnAmzUnUng0dIDwh1CD1kNXdJgbSybbgYKjWGqdSxpfF0vCklgjT8WedoPu3A/opxkaTob4Ky86Lg4rgYEJaQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cornelisnetworks.com;
Received: from PH0PR01MB6439.prod.exchangelabs.com (2603:10b6:510:d::22) by
 BL0PR01MB4804.prod.exchangelabs.com (2603:10b6:208:79::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5250.18; Tue, 17 May 2022 13:40:10 +0000
Received: from PH0PR01MB6439.prod.exchangelabs.com
 ([fe80::bd41:9ade:6b17:e6d]) by PH0PR01MB6439.prod.exchangelabs.com
 ([fe80::bd41:9ade:6b17:e6d%5]) with mapi id 15.20.5250.018; Tue, 17 May 2022
 13:40:10 +0000
Message-ID: <1573dd90-2031-c9e9-8d62-b3055b053cd1@cornelisnetworks.com>
Date:   Tue, 17 May 2022 09:40:06 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.0
Subject: Re: NFS regression between 5.17 and 5.18
Content-Language: en-US
To:     Chuck Lever III <chuck.lever@oracle.com>,
        Trond Myklebust <trondmy@hammerspace.com>
Cc:     Olga Kornievskaia <aglo@umich.edu>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
References: <979544aa-a7b1-ab22-678f-5ac19f03e17a@cornelisnetworks.com>
 <8E8485F8-F56F-4A93-85AC-44BD8436DF6A@oracle.com>
 <9d814666-6e95-e331-62a7-ec36fe1ca062@cornelisnetworks.com>
 <04edca2f-d54f-4c52-9877-978bf48208fb@cornelisnetworks.com>
 <ca84dc10f073284c9219808bb521201f246cf558.camel@hammerspace.com>
 <bb2c7dec-dc34-6a14-044d-b6487c9e1018@cornelisnetworks.com>
 <A04B2E88-9F29-4CF7-8ACB-1308100F1478@oracle.com>
 <46beb079-fb43-a9c1-d9a0-9b66d5a36163@cornelisnetworks.com>
 <9d3055f2-f751-71f4-1fc0-927817a07d99@cornelisnetworks.com>
 <b2691e39ec13cd2b0d4f5e844f4474c8b82a13c8.camel@hammerspace.com>
 <9D98FE64-80FB-43B7-9B1C-D177F32D2814@oracle.com>
From:   Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
In-Reply-To: <9D98FE64-80FB-43B7-9B1C-D177F32D2814@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL0PR02CA0019.namprd02.prod.outlook.com
 (2603:10b6:207:3c::32) To PH0PR01MB6439.prod.exchangelabs.com
 (2603:10b6:510:d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 30335feb-b82c-4acd-f226-08da380ac30c
X-MS-TrafficTypeDiagnostic: BL0PR01MB4804:EE_
X-Microsoft-Antispam-PRVS: <BL0PR01MB480422EA768BA205654CDAF5F4CE9@BL0PR01MB4804.prod.exchangelabs.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tozTrSfl+kYPWtogzwUwjHb/Cp3RxeD80V6zxGxdwHX7Djpbi9iMMTlFkauGvD22V5jkRuhW1/BrPAWEwIPvEh7Z8ZMDYZK2/OalkFVWyWHimybx0UhMoaNflq3Jia6yRqSCoxA8N4y/C8AmaefTPwk1Te4Wy0/JLeApkiJ5d3eRQfGgkfXbnrpcGCSgvDdLEGOnI0x378KtbzPTUu2uXSGZqEotWP8jNLWaOvWueP+H5yXVST5Kk8+oggEA8WxgrVyXi3sMylbY8UhjRVkoT1gEsv3ZB8OEkiW8zwDZ7Ii8eJTw48ItUy4zXvt8FZz32dtIkpQUo+rhQ2anBH7ltyaPmNSfMYA37vu2CYb/TGYkhv04oL1Z9EJ4kr79PAoGcfXPm9vFU4pNA5HI98iZ9wMBMgiWfOgxLRZOCkwgQtm/n8+dIYDae8rdfraSk+sEBhcPedDarjQx/WQhQZMCYAEZe5dGchTvU5Rfw3Zm5U645TccRVL5RIMegS+4R4FxSR5o2gosGo8gr5u2L+N3+RIb+paKLuxBXVQOlhXRwfYx1IuqnLxhBo7wTR0KcLZzkAknQB2ZjWAMhIYvaSVuo7ierWp88eLfVVPa8g/1L1WcjEnOjUpPpUrSq8EIQ6kACMHy8EXFo/SS07eXMEiYKurgixXW0hoKy5gC2c5Usm/yd3XltMN61PfumBkRtWzDuj8Bwk/qwNlndSU9bO7yg00h9MX4UoDahKqBH8PYuitGIC6q7vCgGQPV/UzeQ8UY
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR01MB6439.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(376002)(346002)(136003)(396003)(366004)(39840400004)(8676002)(66476007)(66946007)(66556008)(2616005)(4326008)(53546011)(26005)(31696002)(44832011)(86362001)(508600001)(8936002)(52116002)(6506007)(38350700002)(6486002)(5660300002)(83380400001)(186003)(36756003)(31686004)(54906003)(41300700001)(2906002)(6666004)(6512007)(316002)(38100700002)(110136005)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VWpEcGxhcjRoYWlUT1hOQmM2d0F5VzhlcUVuTEIrUHArL3pVYTU0MVVOeEdJ?=
 =?utf-8?B?QjNwVG4yWnlXL21NVHhKZjF3WkdDWVVqYS9menAxSXVkS1pKVThia3NLbm9D?=
 =?utf-8?B?VkV5ZDUvM1F3ZU9kUEdVT2FPWmJ3YldwTU5oa3BkSlpkVHdzVzZWWk1RZC81?=
 =?utf-8?B?WnVvbEJlL044S3p6RElQU3RZOFM0VnRHZEFVMnkza2FsL1JHRVRXK1BGa3NV?=
 =?utf-8?B?bnJIYnBTNEJvY1JFKzZickhDYXI5OFlpbHd5cVFiZS9pYnRsRlhqSStWSkd6?=
 =?utf-8?B?QUJRaFhRZzdKOU85YUdHcGZJTXR6Si85cTdXQTIxd1F0YWZIVWZLaUJQZkVk?=
 =?utf-8?B?UTB4K2M5SU45T2tpbWE3OTJCc3ljRjZyaGlrUmZYV01lTklRbjg0UENKYUxk?=
 =?utf-8?B?U1BUb3lQRS9DcFR0a2dLZjFKWUtoUkJVVmh4ZVN4RlRlSTB4bnVFRktZN1dz?=
 =?utf-8?B?N011UUtHQ05nQlVJdGVMaE9qNDEwV2JBaVpzQW9JWm9XZ3kwTGt6RGRuV2hQ?=
 =?utf-8?B?VU1KV2tBN2I3RzNLbWhqdDhSUU9WOUIzQnpxcjZKQ01za1B4YmdtZmFlTGIw?=
 =?utf-8?B?Z3NKM1VEVVdqeGNtYy9IbDNuMG5lcUk0ZkNYNjU2NUcxZWV2WEZkS0ZSTHkz?=
 =?utf-8?B?bVVhekxWU0VUbFhVbTdsR0VkVmtOeXJkY0hsbkFVMy9IZUc4TlBNTUIxTnJr?=
 =?utf-8?B?c1F5Y1lDb2kyZ2tFdkRwUlh1SnlRM2NHOXQrVHFLQWIydnk4b0RaRDFrbDZX?=
 =?utf-8?B?Q0NsTDhZaER3eFU4eFhENlVDK3VxZXZhcUZZWmNqSDVNZHl0RG14bmwzWHBY?=
 =?utf-8?B?QStMT2hINU9teWJ2NFdoaXRtNEVXaHZNR2JFdUtLL3gyWFpKZXc0c3hicjhN?=
 =?utf-8?B?c05zNEJrNWRKb09ZR3BEUEZDK3RqSUxQdUgvRFJSU0g3N2R0N2lRaWNhQkt2?=
 =?utf-8?B?ZVhPWHNwendYUXBQREt5d0RYOWdqM0VoMDRkM0p0VEVRNmQ3Sk5jUklKRWVO?=
 =?utf-8?B?NjZpNDJpczFWTU1pK0Uwc1luMXpPdDQxSTB0UWRNNUtJNXF6Q3FBMUE0ODF2?=
 =?utf-8?B?WFB3OHpMRllZUlQ2NENzLzNUMzhHUmYvKzdzeURNdTVHeUh5QzdrV0dZK3Jl?=
 =?utf-8?B?R2toZStwSkFSQk1DYmtSUm9ybkhoT2U0UHp4MDJsUEhDcWYyMGdCTXFQd2pY?=
 =?utf-8?B?YnJiOGE5NEdGV2FTLzcrYzZOc2NrTkJNWVJMdmNJUi8yb3ZxMm5aT0d3WlRU?=
 =?utf-8?B?QUNzZkZqVStiU0JoaHY4VWNodDQwL2tlNWhpVzMrNWpFYTVuQWF3R2xPVXNN?=
 =?utf-8?B?Rms2TUViODF0dlV3UjlBaVk0Q0k2eFRHVUJrOVNPNXpUWGJSeDRaWTl3OUdZ?=
 =?utf-8?B?bUJ0cHIra2ZnNnlBREVJcXJXU01USnFacmJkc3BtMDBWbVFCMm4xUnloazdu?=
 =?utf-8?B?SnRHUk91Vi94anF4cXdydVhwSnZ1L1J5ZENWWlRWNVp5OUhhVmpJSnM1T1hK?=
 =?utf-8?B?TGE1TXYrMDczYVhSb1oydy9JelNtUDlSQ1RpUHNhNmE1c3RoZGV4OTZrMmlH?=
 =?utf-8?B?eVR1eU1HYndHeGhzeEhNVTB4Q2VpdUhOdWpLNCsrdHZKdU95NVJLeG1ITWNS?=
 =?utf-8?B?V2NZM0toMzQ4YmdQdm5lQzFRUC91aEYzN2hSOWl1L3lVenhyVEQ5SmsvUWNK?=
 =?utf-8?B?YktIRml0SzZOSms4eVh3OVIzdEFzKzZaNURCU2JMSG9UZ1FKeUYxZXJUeGtw?=
 =?utf-8?B?QWFMTGJQK241NTFTSW84UURQQkNtay9FcGZYYTdFbDZ0M1FWVU5BZnh2TU5O?=
 =?utf-8?B?Q05mbC9iK0dSWmZUTEZSVit6ekhGcHJXSVBjdUQyRnNyOUtaNFUwUEdlWEt5?=
 =?utf-8?B?cGNaVTlPVXg5UG1XRDl1SWRuWWtLemdFODNmeGhkQWZIWTFWaUdjbUJMQWxS?=
 =?utf-8?B?MzkzQ0w5eWVEUENnUlc1QlBDS1V6Z1ZTSVlJamVOcEZBcVpoc2NlNFhTU3Nq?=
 =?utf-8?B?RUNjTVdPdVhqN01OYlM3UllMQkE1NDJHNERPcDQ1MWhyUnorenN2cnFUSkFm?=
 =?utf-8?B?d3VycUR0UWluWDlKTk1DM3l2Ui9nNTRtSWpmVnVRTytzamhpTXZTT3V1dE1S?=
 =?utf-8?B?Ni81NHdSYkZGbkhKY2QrbHNsOHhoM3BJU2l6b2w2V1dxSDcwN201ZXk3R2gr?=
 =?utf-8?B?Yll1Rjc0Ty9ZVTZYNXJZNFU3cXpiSE5iKzRHS3RZYWlJTXF4VkxhTWI0cUdO?=
 =?utf-8?B?VmZPWTAzK1JkTUUrQ1A5eWs1b21qOU1TKzZyWFAyRUlxTW12VVVqeERuRGNW?=
 =?utf-8?B?S1dPRGVHSGNXMXJNSGp4M3MxYjVEa3NGWmJtNXVtVE1TWTd0M0RsYkNGVWxw?=
 =?utf-8?Q?N0awM5gYtbIVc0E2gLtmEzb7YEdve53tUufF9?=
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30335feb-b82c-4acd-f226-08da380ac30c
X-MS-Exchange-CrossTenant-AuthSource: PH0PR01MB6439.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2022 13:40:10.0986
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xf7y53VEl/PTtBHkBPEWavTi96LR3HzcNOBinIE797w5xuFDHuxzucfxYs4l0nKZ36kTHbQO501zMgZlChe8IJyXutcyaprn1+/WJJeCNt82V5XBUZs+0OYurZAjcGGa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR01MB4804
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 5/13/22 10:59 AM, Chuck Lever III wrote:
>>>
>>> Ran a test with -rc6 and this time see a hung task trace on the
>>> console as well
>>> as an NFS RPC error.
>>>
>>> [32719.991175] nfs: RPC call returned error 512
>>> .
>>> .
>>> .
>>> [32933.285126] INFO: task kworker/u145:23:886141 blocked for more
>>> than 122 seconds.
>>> [32933.293543]       Tainted: G S                5.18.0-rc6 #1
>>> [32933.299869] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
>>> disables this
>>> message.
>>> [32933.308740] task:kworker/u145:23 state:D stack:    0 pid:886141
>>> ppid:     2
>>> flags:0x00004000
>>> [32933.318321] Workqueue: rpciod rpc_async_schedule [sunrpc]
>>> [32933.324524] Call Trace:
>>> [32933.327347]  <TASK>
>>> [32933.329785]  __schedule+0x3dd/0x970
>>> [32933.333783]  schedule+0x41/0xa0
>>> [32933.337388]  xprt_request_dequeue_xprt+0xd1/0x140 [sunrpc]
>>> [32933.343639]  ? prepare_to_wait+0xd0/0xd0
>>> [32933.348123]  ? rpc_destroy_wait_queue+0x10/0x10 [sunrpc]
>>> [32933.354183]  xprt_release+0x26/0x140 [sunrpc]
>>> [32933.359168]  ? rpc_destroy_wait_queue+0x10/0x10 [sunrpc]
>>> [32933.365225]  rpc_release_resources_task+0xe/0x50 [sunrpc]
>>> [32933.371381]  __rpc_execute+0x2c5/0x4e0 [sunrpc]
>>> [32933.376564]  ? __switch_to_asm+0x42/0x70
>>> [32933.381046]  ? finish_task_switch+0xb2/0x2c0
>>> [32933.385918]  rpc_async_schedule+0x29/0x40 [sunrpc]
>>> [32933.391391]  process_one_work+0x1c8/0x390
>>> [32933.395975]  worker_thread+0x30/0x360
>>> [32933.400162]  ? process_one_work+0x390/0x390
>>> [32933.404931]  kthread+0xd9/0x100
>>> [32933.408536]  ? kthread_complete_and_exit+0x20/0x20
>>> [32933.413984]  ret_from_fork+0x22/0x30
>>> [32933.418074]  </TASK>
>>>
>>> The call trace shows up again at 245, 368, and 491 seconds. Same
>>> task, same trace.
>>>
>>>
>>>
>>>
>>
>> That's very helpful. The above trace suggests that the RDMA code is
>> leaking a call to xprt_unpin_rqst().
> 
> IMHO this is unlikely to be related to the performance
> regression -- none of this code has changed in the past 5
> kernel releases. Could be a different issue, though.
> 
> As is often the case in these situations, the INFO trace
> above happens long after the issue that caused the missing
> unpin. So... unless Dennis has a reproducer that can trigger
> the issue frequently, I don't think there's much that can
> be extracted from that.

To be fair, I've only seen this one time and have had the performance regression
since -rc1.

> Also "nfs: RPC call returned error 512" suggests someone
> hit ^C at some point. It's always possible that the
> xprt_rdma_free() path is missing an unpin. But again,
> that's not likely to be related to performance.

I've checked our test code and after 10 minutes it does give up trying to do the
NFS copies and aborts (SIG_INT) the test.

So in all my tests and bisect attempts it seems the possibility to hit a slow
NFS operation that hangs for minutes has been possible for quite some time.
However in 5.18 it gets much worse.

Any likely places I should add traces to try and find out what's stuck or taking
time?

-Denny
