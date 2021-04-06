Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F3FE354A0B
	for <lists+linux-nfs@lfdr.de>; Tue,  6 Apr 2021 03:31:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235662AbhDFBbc (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 5 Apr 2021 21:31:32 -0400
Received: from mail-bn8nam12on2081.outbound.protection.outlook.com ([40.107.237.81]:33920
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230476AbhDFBbb (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 5 Apr 2021 21:31:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dtBsl+rrmb6pXGfextme55N9J8dv/uQzvbY4uHc8DwVrNd8zhQ56IcmITj7JT8D4QwF1wtepGqNpE5UPYvuGvuL7i4vtVP4vFIh6RmL4Zh6HK0V+Eljwzcw2K82hhncTs6TjaLhh+SQetPb7myrDj7Prs75kz/kVYx98EfF86kFtMsOVyxKmHdKjjyc1xgYjkvlZCMksqeQCwn7w+y+tVX7FVCBBzAhMar6XVwuPft1oYipNOmSZQ8HNWcm9PxPM4gMYCO8jrZFGbb9aWuNf1bAFGaiJDfO7AFxLBgcKoGP7i/ip5l7U844kgAyagmzlkNDOxpRzQTnKo1KHHzU4AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fF98DsbFFCotMAL1517pOnptELXyy/BwHcPUG1Lrs6A=;
 b=DPHn56qWgrLdKK/6J9ztN0EwTGbqkg2y12MFclUQ8tg2WKJxYbI530pc2qI+/I+ni/0BjPuXqvCW7sl9ikc35DmJnbjYxdwxipVHt15PNj1wmB6D1YDwa/zH4/7pD/9YJMUmRsqJaomNw2+vsZ2xK7AEXlhvGlLk1UGQJ+yDC9PbwhMfb9JsBtKr2cANr9RrTCmDEdGQ78PS+RsCPpNAZYQ2aZBKe19gbHZ3idniRFwZKAr4p02skB20ErM+N2Ds9mGSIYzP854JWS+fjv32iahReLRAen56FEMBNFM3HZ2Yjnevwytxwq1VaXTJWsYQCqhbaX1NtQ2ZWJ+MoOWxEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fF98DsbFFCotMAL1517pOnptELXyy/BwHcPUG1Lrs6A=;
 b=OE/ROA+XocIs+zJWl3FXOUbdEhqy5/gtQK18+9h79CepHAWyENu0eCk+c7DVPN82Aiz4gR53GUw//gMeN0GNkTRbW41DFgV0ouoBc04SVmj14Gq+63BzqkP6n6J4G/VjIPOVHZqmJfAKNEbJH0crcQSQodTs0v+5rh5kza2ygQE=
Authentication-Results: hammerspace.com; dkim=none (message not signed)
 header.d=none;hammerspace.com; dmarc=none action=none
 header.from=windriver.com;
Received: from SN6PR11MB2592.namprd11.prod.outlook.com (2603:10b6:805:57::25)
 by SA2PR11MB4796.namprd11.prod.outlook.com (2603:10b6:806:117::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.29; Tue, 6 Apr
 2021 01:31:21 +0000
Received: from SN6PR11MB2592.namprd11.prod.outlook.com
 ([fe80::a135:6ae7:1d9f:b4db]) by SN6PR11MB2592.namprd11.prod.outlook.com
 ([fe80::a135:6ae7:1d9f:b4db%7]) with mapi id 15.20.3999.032; Tue, 6 Apr 2021
 01:31:21 +0000
Subject: excuse-lockdep help
To:     linux-nfs@vger.kernel.org
Cc:     anna.schumaker@netapp.com, trond.myklebust@hammerspace.com
References: <4dd50256-9b7b-73b2-29c7-1ca16cde73fc@windriver.com>
 <a071d82f-d15f-e0f5-e483-9b7d1120f338@windriver.com>
 <16905BAB-7AB6-4170-98CC-292F0C01F30F@oracle.com>
From:   "jun.miao" <jun.miao@windriver.com>
Message-ID: <02bfe58e-d8e1-4553-5060-45f2196267ea@windriver.com>
Date:   Tue, 6 Apr 2021 09:31:12 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <16905BAB-7AB6-4170-98CC-292F0C01F30F@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [60.247.85.82]
X-ClientProxiedBy: HKAPR03CA0030.apcprd03.prod.outlook.com
 (2603:1096:203:c9::17) To SN6PR11MB2592.namprd11.prod.outlook.com
 (2603:10b6:805:57::25)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [128.224.162.214] (60.247.85.82) by HKAPR03CA0030.apcprd03.prod.outlook.com (2603:1096:203:c9::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.8 via Frontend Transport; Tue, 6 Apr 2021 01:31:20 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f244696b-590c-4981-2801-08d8f89baefc
X-MS-TrafficTypeDiagnostic: SA2PR11MB4796:
X-Microsoft-Antispam-PRVS: <SA2PR11MB479671F629A7115E389077B78E769@SA2PR11MB4796.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:383;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zr9aatZAQCxFh47GkkaEEn4pagHpz1hvqsmmRcPBgXWiWE0B7FIQdJFR5wnHvL3L0nf0GWbC9o3k979LJzrCKgkeGbl/+OoV9cCXszpY0Reeh1vXhaBvPhAndQr1pDQgNqJlF5s6gYEIlPeL1+zZlsHMeS47/VHnYE15VwisfjRT3RA/JF6aVRPPGO1sv5IYo1iZvqIwb345JwtvspAdboaOtV42g73u7x7weivSBNU/+zcatWGahoVapPs6qYWo3zRUNC4zJvGLhnkqgm+xAbUSiN7zHNiCdCxA3kDqI08wsYiPtc9fYNpSqkl12ZJNqX5QVyF15fyNvuBCEq1PcCVl9L3isQ+Eua4LtnvYADnC3KBgvbHbI2/R8O1kNkpi04oMzXZswQAoihabekneXqjIzxtlBr+U6RC+SR3vkix5EP4E9lv6dxW3GvCPMHqFfnTG4YK07mMpOPVVX6AZIiNZIOorQt7XJ8dHEvAIC5Q/ZJTOnOfNXpPxi0dlNU1wYaPSvjBvVBOQiW/VT6wjkRaVeZRki/PJp5JPpkZ2mFLEYk7LT4jZI8K3C08BlJ02XuNsaAgo4mw3nArrHXj1/fcPDTtaR5kDIhf8khjLtD3N8LuxkP+mxInnpknH/fhWsZ1SPnc7Hqj+Liciut7KdrBzRl1lZmuadRE1AFWku8Ty3SyMWB6lvPFE0liLXb1XcMNHDNtff3wf6jHo6MQeZtqdZVLwLjpD1gK1exGXuq1uEyvgdqR5XHbvl5DDBu2B95+m/mQr91CtlA8HEZmPdQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR11MB2592.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(136003)(396003)(39850400004)(346002)(478600001)(26005)(86362001)(2616005)(31696002)(6666004)(956004)(53546011)(16576012)(5660300002)(38350700001)(38100700001)(316002)(2906002)(16526019)(36756003)(6706004)(6916009)(3480700007)(31686004)(66556008)(186003)(66946007)(66476007)(8676002)(8936002)(52116002)(6486002)(83380400001)(4326008)(78286007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?c2hKcWdGQ1MwMUZwNzM5VmlZcmJ3NHAvenM0bEh2aXByY0pScjUxVjVrNit0?=
 =?utf-8?B?NVFlT2hyck5ZU09lNkJLeXFJYWtsN2piN1l5eUhraFRTenNSMDY2cEhRWjBa?=
 =?utf-8?B?d1ZTZVpCQzdUTkNHNmQvWDJqR3FyMXloU3laakFOZGllazFLTFhZTFhSL1ZV?=
 =?utf-8?B?a2hJdE94bm05UjJWZnZOWjZRQS91MlJ4dXQ5d2xyaXAvQTRia0VNb0Z3eUpF?=
 =?utf-8?B?OXI1ZjVGdmttWGQ1RWxVc1BZRENnamtxMDE0bDl5bVZWbDlCRXFaVUNCdnd6?=
 =?utf-8?B?RkVGV1Vtay92bjVJcGlPTlNuUjlKM3E4dW9Xa25MeE5KUkVyQjJ2UkRQaWZi?=
 =?utf-8?B?Z3RCN055bVJxTFJpLzFhVGVEK3hyNzRWRzFoRWxnUjQxeStxSkpDMGx6aitt?=
 =?utf-8?B?eFBrc09tZGJYM2I4aVU3VkdFb2dHUUZPOEgreitoZERpTWxoTUNuTG0zV2E2?=
 =?utf-8?B?cklGWFRpTnFqc3hHV1c1NEpNOFo3Y1V2aTM3UFRQNVpnVjFvYlFLakVXQTBM?=
 =?utf-8?B?c0tkOVdUWjU1bkZFby8xdnpOellHOXRhTGV4RGhIMk9zUmI4dm9KdjY1UEYr?=
 =?utf-8?B?T2RhYnFYbFBTaWF6MVFGU0hRQisxd3ptTGdqcmJwSWpmY2RyYjIyd0x3Yi85?=
 =?utf-8?B?dGpvTXQxb2dnTzQyZ3VyRUFZRmFOU0hYdE9xV2Rvekhha084ODE5dGRXZjdN?=
 =?utf-8?B?aGpUS1JzVVBuY1N1cnNQT3ZTbWdWc0ZzYm5aOHVjYjBYQTYyNEY1NjRzVkly?=
 =?utf-8?B?ZzBFNlBiaHdaaUdEV2NPdnhSMVJLUGdNUGNCczE3S1daRnFISGRyUjVyQUox?=
 =?utf-8?B?TkJscU45czhrSEw5ZGlUTnBVdHlYUkpnd1FNUkJXdGIrN1lxZk80MGdZMjZq?=
 =?utf-8?B?ZVZBWkdraUZZM2pDeERhdnN4WDlHYzV2M3ZNYjFmYlR4RkZQSnNvOHh0bnEz?=
 =?utf-8?B?NjRRRFQzakVtZXB1cnNxVjA0a1phU002R3V4YTR4YTdrZHp2YittOU1TUXNH?=
 =?utf-8?B?b1ZZL283K3JHLytpZC9rR0lBVGk4cGZJME5lOFpNRm9GeGUzRGkyM2RpVlRT?=
 =?utf-8?B?czg1RnY1YTZzNi9ILzFWMmR6RFR2VEt3WmZwS2N4RVZFcUxvakxQNFRoNHpW?=
 =?utf-8?B?QjV1dUJqTmhneU5EU21BUFJydXRCQ0g5QXI0SjJLbkRCRDdMaDIrdVJVOWlY?=
 =?utf-8?B?SWFiM1ZMazNLdzdReG5rbFBFMGtTSDdHYWRWS2ZnYTZSa2lpUGswZ2RncnRB?=
 =?utf-8?B?ZnZ0eU5lSVZQMUt1VnJxREhjWVcrRDNNMklBd09naUk0eHJpSWpuUkMyWlAz?=
 =?utf-8?B?NmYxbktqdnIzWmhsam54a3dFSzJzNWNFRC9OY2JzNWJSaStKYVhmUTBkRVZu?=
 =?utf-8?B?dEhtdnRUS0gydjg0TEV4YjNyVzQ2RXJNTGpDN1V4bk51WlM1anMxTnM1VWgy?=
 =?utf-8?B?K1R2TTlLUWwwcDMvTjhpQjZOMzhHUm5wb3Yrd2hpcGYyWDd1S2tZL3VuQzRP?=
 =?utf-8?B?Tmx1Mk9ORFAzeUJvUHd6MlZnS2pDQyt4WER4Uk02SithcW5JL0N2bjI2VWZR?=
 =?utf-8?B?Ky95bVRqaThhQm00VnI3WGhZakFTRlkwalRhVm9GRFVjNWdINmNnc1AzeW4y?=
 =?utf-8?B?U3pyd2hrSVlDclhUSVh3c0FQbElCb25JeVVFUUtsK1dhSGk3Q1dhNE9EaXdZ?=
 =?utf-8?B?ZGp6ejR6eU9XZXRHc01VV0N6V1pGV214YldDTHl4NG5XWVZDdWE3Z0hKbHpo?=
 =?utf-8?Q?vQE9qKX00gTd6AsFUGwFfmvrdSalqOnP7rolXQ+?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f244696b-590c-4981-2801-08d8f89baefc
X-MS-Exchange-CrossTenant-AuthSource: SN6PR11MB2592.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2021 01:31:21.5023
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +oTHbdBiji78UAY7jv3N0FGp+iitcdStTaMMIZCVmUKvfH19zWoSGSKp7bA2rO8rfuhQcDhYBZM+yM9f7uLeZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4796
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi maintainer,and stranger  v5.4-rt kernel, there some BUGs error:

[   29.286213] BUG: workqueue leaked lock or atomic: kworker/u8:0/0x00000000/7
                     last function: rpc_async_schedule
[   29.286215] 9 locks held by kworker/u8:0/7:
[   29.286217]  #0: ffff953b5745c2f0 (&dev->qdisc_running_key){+.+.}, at: __dev_queue_xmit+0x32e/0x610
[   29.286222]  #1: ffff953b5745c2f0 (&dev->qdisc_running_key){+.+.}, at: __dev_queue_xmit+0x32e/0x610
[   29.286226]  #2: ffff953b5745c2f0 (&dev->qdisc_running_key){+.+.}, at: __dev_queue_xmit+0x32e/0x610
[   29.286230]  #3: ffff953b5745c2f0 (&dev->qdisc_running_key){+.+.}, at: __dev_queue_xmit+0x32e/0x610
[   29.286241]  #4: ffff953b5745c2f0 (&dev->qdisc_running_key){+.+.}, at: __dev_queue_xmit+0x32e/0x610
[   29.286245]  #5: ffff953b5745c2f0 (&dev->qdisc_running_key){+.+.}, at: __dev_queue_xmit+0x32e/0x610
[   29.286249]  #6: ffff953b5745c2f0 (&dev->qdisc_running_key){+.+.}, at: __dev_queue_xmit+0x32e/0x610
[   29.286253]  #7: ffff953b5745c2f0 (&dev->qdisc_running_key){+.+.}, at: __dev_queue_xmit+0x32e/0x610
[   29.286258]  #8: ffff953b5745c2f0 (&dev->qdisc_running_key){+.+.}, at: __dev_queue_xmit+0x32e/0x610
[   29.286262] CPU: 2 PID: 7 Comm: kworker/u8:0 Tainted: G W         5.4.107-rt44-yocto-preempt-rt #1
[   29.286263] Hardware name: Intel Corporation NUC7i5DNKE/NUC7i5DNB, BIOS DNKBLi5v.86A.0026.2017.0915.2016 09/15/2017
[   29.286266] Workqueue: rpciod rpc_async_schedule
[   29.286266] Call Trace:
[   29.286268]  show_stack+0x4e/0x52
[   29.286272]  dump_stack+0x7a/0xa4
[   29.286276]  process_one_work.cold+0x43/0x48
[   29.286292]  worker_thread+0x217/0x330
[   29.286300]  kthread+0x177/0x190
[   29.286302]  ? process_one_work+0x410/0x410
[   29.286303]  ? __kthread_parkme+0xc0/0xc0
[   29.286310]  ret_from_fork+0x3a/0x50



On 4/6/21 1:57 AM, Chuck Lever III wrote:
> [Please note: This e-mail is from an EXTERNAL e-mail address]
>
>> On Mar 28, 2021, at 10:31 PM, jun.miao <jun.miao@windriver.com> wrote:
>>
>> Hi  maintainers
>>
>> I find a BUG calltrace in v5.4-rt:
>>
>> [   29.286213] BUG: workqueue leaked lock or atomic: kworker/u8:0/0x00000000/7
>>                      last function: rpc_async_schedule
>> [   29.286215] 9 locks held by kworker/u8:0/7:
>> [   29.286217]  #0: ffff953b5745c2f0 (&dev->qdisc_running_key){+.+.}, at: __dev_queue_xmit+0x32e/0x610
>> [   29.286222]  #1: ffff953b5745c2f0 (&dev->qdisc_running_key){+.+.}, at: __dev_queue_xmit+0x32e/0x610
>> [   29.286226]  #2: ffff953b5745c2f0 (&dev->qdisc_running_key){+.+.}, at: __dev_queue_xmit+0x32e/0x610
>> [   29.286230]  #3: ffff953b5745c2f0 (&dev->qdisc_running_key){+.+.}, at: __dev_queue_xmit+0x32e/0x610
>> [   29.286241]  #4: ffff953b5745c2f0 (&dev->qdisc_running_key){+.+.}, at: __dev_queue_xmit+0x32e/0x610
>> [   29.286245]  #5: ffff953b5745c2f0 (&dev->qdisc_running_key){+.+.}, at: __dev_queue_xmit+0x32e/0x610
>> [   29.286249]  #6: ffff953b5745c2f0 (&dev->qdisc_running_key){+.+.}, at: __dev_queue_xmit+0x32e/0x610
>> [   29.286253]  #7: ffff953b5745c2f0 (&dev->qdisc_running_key){+.+.}, at: __dev_queue_xmit+0x32e/0x610
>> [   29.286258]  #8: ffff953b5745c2f0 (&dev->qdisc_running_key){+.+.}, at: __dev_queue_xmit+0x32e/0x610
>> [   29.286262] CPU: 2 PID: 7 Comm: kworker/u8:0 Tainted: G W         5.4.107-rt44-yocto-preempt-rt #1
>> [   29.286263] Hardware name: Intel Corporation NUC7i5DNKE/NUC7i5DNB, BIOS DNKBLi5v.86A.0026.2017.0915.2016 09/15/2017
>> [   29.286266] Workqueue: rpciod rpc_async_schedule
>> [   29.286266] Call Trace:
>> [   29.286268]  show_stack+0x4e/0x52
>> [   29.286272]  dump_stack+0x7a/0xa4
>> [   29.286276]  process_one_work.cold+0x43/0x48
>> [   29.286292]  worker_thread+0x217/0x330
>> [   29.286300]  kthread+0x177/0x190
>> [   29.286302]  ? process_one_work+0x410/0x410
>> [   29.286303]  ? __kthread_parkme+0xc0/0xc0
>> [   29.286310]  ret_from_fork+0x3a/0x50
>>
>>
>> When i git am this patch:
>>
>>      commit 1a33e10e4a95cb109ff1145098175df3113313ef
>> Author: Cong Wang <xiyou.wangcong@gmail.com>
>> Date:   Sat May 2 22:22:19 2020 -0700
>>
>>      net: partially revert dynamic lockdep key changes
>>
>> The BUG also print:
>>
>>   BUG: workqueue leaked lock or atomic: kworker/u8:0/0x00000000/7
>> [   28.869159] 000:      last function: rpc_async_release
>> [   28.869161] 000: 13 locks held by kworker/u8:0/7:
>> [   28.869162] 000:  #0: ffff90b817de42f0 (&(&sch->running)->seqcount){+.+.}, at: __dev_queue_xmit+0x32e/0x610
>> [   28.869167] 000:  #1: ffff90b817de42f0 (&(&sch->running)->seqcount){+.+.}, at: __dev_queue_xmit+0x32e/0x610
>> [   28.869172] 000:  #2: ffff90b817de42f0 (&(&sch->running)->seqcount){+.+.}, at: __dev_queue_xmit+0x32e/0x610
>> [   28.869177] 000:  #3: ffff90b817de42f0 (&(&sch->running)->seqcount){+.+.}, at: __dev_queue_xmit+0x32e/0x610
>> [   28.869189] 000:  #4: ffff90b817de42f0 (&(&sch->running)->seqcount){+.+.}, at: __dev_queue_xmit+0x32e/0x610
>> [   28.869193] 000:  #5: ffff90b817de42f0 (&(&sch->running)->seqcount){+.+.}, at: __dev_queue_xmit+0x32e/0x610
>> [   28.869198] 000:  #6: ffff90b817de42f0 (&(&sch->running)->seqcount){+.+.}, at: __dev_queue_xmit+0x32e/0x610
>> [   28.869203] 000:  #7: ffff90b817de42f0 (&(&sch->running)->seqcount){+.+.}, at: __dev_queue_xmit+0x32e/0x610
>> [   28.869208] 000:  #8: ffff90b817de42f0 (&(&sch->running)->seqcount){+.+.}, at: __dev_queue_xmit+0x32e/0x610
>> [   28.869213] 000:  #9: ffff90b817de42f0 (&(&sch->running)->seqcount){+.+.}, at: __dev_queue_xmit+0x32e/0x610
>> [   28.869218] 000:  #10: ffff90b817de42f0 (&(&sch->running)->seqcount){+.+.}, at: __dev_queue_xmit+0x32e/0x610
>> [   28.869223] 000:  #11: ffff90b817de42f0 (&(&sch->running)->seqcount){+.+.}, at: __dev_queue_xmit+0x32e/0x610
>> [   28.869228] 000:  #12: ffff90b817de42f0 (&(&sch->running)->seqcount){+.+.}, at: __dev_queue_xmit+0x32e/0x610
>> [   28.869233] 000: CPU: 0 PID: 7 Comm: kworker/u8:0 Tainted: G        W         5.4.107-rt44-yocto-preempt-rt #1
>> [   28.869234] 000: Hardware name: Intel Corporation NUC7i5DNKE/NUC7i5DNB, BIOS DNKBLi5v.86A.0026.2017.0915.2016 09/15/2017
>> [   28.869236] 000: Workqueue: nfsiod rpc_async_release
>> [   28.869236] 000: Call Trace:
>> [   28.869238] 000:  show_stack+0x4e/0x52
>> [   28.869242] 000:  dump_stack+0x7a/0xa4
>> [   28.869247] 000:  process_one_work.cold+0x43/0x48
>> [   28.869266] 000:  worker_thread+0x53/0x330
>> [   28.869275] 000:  kthread+0x177/0x190
>> [   28.869278] 000:  ? process_one_work+0x410/0x410
>> [   28.869279] 000:  ? __kthread_parkme+0xc0/0xc0
>> [   28.869286] 000:  ret_from_fork+0x3a/0x50
>>
>>
>>
>> Could you give me some advice about rpc_async_schedule() in sunrpc File ?
>>
>> Thanks very much
> Hello-
>
> rpc_async_schedule() is part of the RPC client, whose maintainers
> are Trond Myklebust and Anna Schumaker. Please post this WQ splat
> to linux-nfs@vger.kernel.org and Cc: Trond and Anna. Thanks!
>
>
> --
> Chuck Lever
>
>
>
