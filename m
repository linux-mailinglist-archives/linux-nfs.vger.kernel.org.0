Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BC93495909
	for <lists+linux-nfs@lfdr.de>; Fri, 21 Jan 2022 05:57:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233808AbiAUE5y (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 20 Jan 2022 23:57:54 -0500
Received: from mail-eopbgr00135.outbound.protection.outlook.com ([40.107.0.135]:12915
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232128AbiAUE5y (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 20 Jan 2022 23:57:54 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=em3bT4frASvFOONcCXBYP6eQpepJgy8YLU6wfxpo2h1eNmdJw3eVwx0lKEVwtafJOH/g/nZI1f2PEtt5YZIpBmDdAGH/LZSw1D2pQJTSrTGJtPZ0b8Oqw1462F1/ZSjnmVdYo4yc1dfA0tuyJNci/qIUO7wgur87m52vEw4UGww72PeMiO5UNudnbcXYTjmLnnuLCeuQ+sHib1eNYWYxByOA5T7fAcNWrpDEKMilY8XXfSuKC33DpAKZyXcbiKQFkb9Ue96sBhj3nFYgD9Tf9usSPoPuqr7EYwmZseV+bve7b20L3xf4PwRojX9mC4haI5grAZnKTEGMRPDAgxb85w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qSXjt2c76PnmwvW2xGnPO0T8rCGEgyJRC+1qeaCHLZE=;
 b=I4gQMU9vjHVwk3KtxN7ZW4UiJLm03hYCm9U3cYUcfCkEpTnc262FE06w9B5BgrKUV/ZdaXmtnq6Sr/HWZRvmPKI9mxiormK30z0IHUfoVJQ3Wy0zHkGclCW8TaaMl8PxADMgE/fB1dd2g28IaT3U7u1aN0bzdr9EIBfRgtkNqip4WonPLzcrssAPROvlzrmFnqoh0No0+B96HE0k9eiZAX8aQJbn0cNzRomqY5xKlSn/BXy/nfk/dmheZgQs332nydZfLbAW/3XhJyz6HfCE3iB/O+FS5nt4R2k6YMt3PusivyIyOEWS1ARPM467zAqUtxVt6da1IiHV0JZLxuDi5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qSXjt2c76PnmwvW2xGnPO0T8rCGEgyJRC+1qeaCHLZE=;
 b=hTkF6544yongzHnyUx83s/VDJSRMx9t8Sx64fk4InzacRMGT9/4zA3B4jumk3njv7xcwHGLjCYTgZTx+j6ztXS+Ms0SqfgclEGjSHNfeiEGn1kEEfqUbXy0w8JTjDZIhbG+nqHUQ1LXX51T8L4M169UfpOtg3X9U63VUx7BNN1o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VE1PR08MB5630.eurprd08.prod.outlook.com (2603:10a6:800:1ae::7)
 by AM9PR08MB6785.eurprd08.prod.outlook.com (2603:10a6:20b:309::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.7; Fri, 21 Jan
 2022 04:57:51 +0000
Received: from VE1PR08MB5630.eurprd08.prod.outlook.com
 ([fe80::4456:3e05:28ee:51e4]) by VE1PR08MB5630.eurprd08.prod.outlook.com
 ([fe80::4456:3e05:28ee:51e4%5]) with mapi id 15.20.4909.012; Fri, 21 Jan 2022
 04:57:51 +0000
Message-ID: <da777e8f-ca8a-e1c6-d005-792114b78f84@virtuozzo.com>
Date:   Fri, 21 Jan 2022 07:57:49 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] rpc_lib.sh: fix portmapper detection in case of socket
 activation
Content-Language: en-US
To:     Petr Vorel <pvorel@suse.cz>
Cc:     ltp@lists.linux.it, kernel@openvz.org, linux-nfs@vger.kernel.org,
        Steve Dickson <SteveD@redhat.com>, NeilBrown <neilb@suse.de>
References: <20220120143727.27057-1-nikita.yushchenko@virtuozzo.com>
 <YenNsuS1gcA9tDe3@pevik>
From:   Nikita Yushchenko <nikita.yushchenko@virtuozzo.com>
In-Reply-To: <YenNsuS1gcA9tDe3@pevik>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM6P195CA0065.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:209:87::42) To VE1PR08MB5630.eurprd08.prod.outlook.com
 (2603:10a6:800:1ae::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dd19f776-f973-4695-41c6-08d9dc9a93f4
X-MS-TrafficTypeDiagnostic: AM9PR08MB6785:EE_
X-Microsoft-Antispam-PRVS: <AM9PR08MB678512475F39E1EB43C8353DF45B9@AM9PR08MB6785.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KS8LJxYrSP4G2RO1x6N3rg+33OSiry50f7VA537yJxqJPJq+YsOdVVQLnlAI2w/6F1PooUaM8gKdYhNPRY72+2e8046Wg72EwRKiaZnaV1uxQHj9GWr81B7QupqUgZsfNKiaB/d4UcWbc+cuPyYgQaZrXR/QFgcAceUeltcd3+wilqDfIa1n0HnHV+7HpLSDaiUt05lgwdWIwndoZDM6xbxVVL9UAL5nJn9BKGLL9BMQKOvfrf2qiGF5jxX5ZOpm0AL/pTeVuxmxDLAOB7H4ggLa33FnEmbnF5Z6v2o1UdKXjqGx8dKMarKh4QB9LLuCnO1bqA7oGLACdIK+JckUoQM3DFseo0BuB3snnGRTmJeSsZT5Ney1j9qMH5nX44n6n/+42ELmwkXAMrXpfs+n7zmovvIR01KJGgLgTW1AaQ7mOGg1CAiPVYHIzWK0k3emO1iFDa5a4TmbXqA0Ed622pLvyIlMGM9NIyey6OmvrE8DGf+b5NnVIohbQiPOHtH8mB9a45C2SEBJ8q76584PuQGIBCgYB6oCgkDW+aQ3+pkYjAs+52So2eoZKU6hpLVdmBoNhACOJUIwMRWzsIS1kPGCErN5P0cYPS01dXcshanSL0UO7//uzmWxh41xpAfrfgnuKrw1s/W1xqBUlCDGvyjgVD9mQLjCgtqsQVimqgmGhV49QRX6l3Q9XoVz65FVWqe0DMnCyL89kT15XYD4Q4/tDGlLM3f+fbidSUMtxn8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB5630.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8676002)(6506007)(2616005)(54906003)(31686004)(6512007)(38100700002)(316002)(66556008)(8936002)(66476007)(2906002)(31696002)(186003)(6486002)(83380400001)(5660300002)(86362001)(26005)(4744005)(44832011)(36756003)(6916009)(4326008)(508600001)(66946007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aFdWM055Mjk5ME5JVlUrWVpCNHlZL0VNQW5aL0JoMGVlYkdoa0JUMThDQTRn?=
 =?utf-8?B?Y2U4Zk9tYy90L3Z5TGtnUk52aVFGeGRFT1VHNm41UW5lSWxKV1JadkRRQ1gy?=
 =?utf-8?B?TG5QRHRVcERsVUpKdkxqZ1pEZTdLR1lvckdqV0ZSNC9UMjlPQ2hjbm02OWFo?=
 =?utf-8?B?RStZOGlCeGVvaXliZ0o1bEkxL3o5SGJpM3JjS295WFJLeS9OUUUrTlJOd1F3?=
 =?utf-8?B?SlhqWmlUeHE4cm9raWxOYTJmTFQ3dHRTcUZtUzRkbTNCa1Fub1FjVUIvOWVk?=
 =?utf-8?B?TEtWdXR5UllobFUrOWxWbWpZWjdKcVFqWUpmUkNNMG9jVjNFcUl1N0VXeklo?=
 =?utf-8?B?Q2IzN3JDam96TTFHQ3J4MU5VUTIySjJLNjBHajJqMnliQ2ltUVRNZWQ4bXlu?=
 =?utf-8?B?dnZ1c0RpQWVBUkZJMk1EbHJxbnFiK0RCNUMzUjBaTFppSGVnaGtQSUpQNnF5?=
 =?utf-8?B?T2lId3ZSMTBXb2NheHF6NTducUFPbnJpNTB2N3JBRXFicTdLZW5JTTFMeXBr?=
 =?utf-8?B?dmNTQ1VFMkprUFExK1VPMk9XVWMvbVUwcnN0aUxicGp3Z0I0MXBNT2daN2dt?=
 =?utf-8?B?VzQrUGpSRXUvMUlMdTFidktYWWF5RFZaMUtBbVZCZmRKcHM5VlZzUyt5YWJI?=
 =?utf-8?B?dnQ3QnNZNG9BVW9ENTY2S0tpZ2tCZ0hialFpc2pDTmRiNGdVenlIekpkc0h6?=
 =?utf-8?B?QmRyTUVPUWxJRWF2ZHhsaUVmSE95UlFpNVJ6cENQSjdNaFA1NWZJbEtJVVlX?=
 =?utf-8?B?RE9OSWhibDdJZEFaYjk2R1ZsRVdaOHg4c3FOTXc3cXYrUk5sS1QwNVJOTGtH?=
 =?utf-8?B?VjdZM3ZMTlM2ajBuMHFtMi9JMmp6S0FZTXVNV0wzOFYyME55cHNPVFh4aGxL?=
 =?utf-8?B?bnlUZnFveENPRG9ubXBXSVhVMVpqTi9MN0pJR1JuQ3NaVTE0L1c1cWk2VWUr?=
 =?utf-8?B?YVd2MTdhSzZMdnZMRCtHZ0JuQ0QzVWNIam9ZNnY1bTJzRElEWk9EZzQxWG9S?=
 =?utf-8?B?UytUaWFzMWhDZjNyYVVZN0s5RWc1TTNiSzd2VzBZMmsvVjlBdTY4RXJjQis2?=
 =?utf-8?B?NnJJemNWZmhXeXU4ZXNEd1gyTTBpcmNDekJ2akowemZwemtzQ3hPRkYwZUhz?=
 =?utf-8?B?R0NnWHpwQ0RSdHVsSzhvclY1WERnYW1WRVhKTjZ3MmtWZVVZTGlaVGoxdHRZ?=
 =?utf-8?B?K3hRNi8vK1lmcHRkUnRhcDF1cTE1RjJiVkxqWko5MFJDbktnOHZVN1dTeDhI?=
 =?utf-8?B?OXNweDRvMXZyeU1Mc3gzdXY0VHJROWhUTGJYRzh0Q1FTZnRrM0V1eUYyL1BH?=
 =?utf-8?B?ZUtmd1VkT2diM2hwUDNHdTdxKysrMHlGNUkyRU5tUllFcnczamV1VSsrQTMy?=
 =?utf-8?B?YW1tNnVRK0p0SC9CMjM0U1p5MnBtZUNpNFpDZUxiTU1QM2YxQVpBamZhRjhL?=
 =?utf-8?B?QkIzVW05YVY3aW1lYmZSbWQzMmk0VmkrcXN4Nk8wRjJEbGw1UGNxcmt5UVg0?=
 =?utf-8?B?NndyVU9tRVY4MGprV1hQL3VyTWxxSmpsejAxNW1JWUVDTTlnT3NwMFhId0kz?=
 =?utf-8?B?VlRUS2I4aXYzajJaM1pjUnJyaHpqYVBwYjhKTE1hQXNQVU54bVp3S2phVk1m?=
 =?utf-8?B?ZVZjV1lKbWNCK0ZlSm14a3FRamh4TlY5eG9TUXlTQWpRNURiVWF5czZobkVE?=
 =?utf-8?B?YUpHekc3U0JpbUNQNXU5RUZicDNxeTVjanFPMnNzWUdtLzNPeXh5VlVkVWRr?=
 =?utf-8?B?LzVWRlkxUzhmdlpwY1dabVZ1a0JXUlVRamNXa3pRMGplRDl3bG5IT1F1TE9T?=
 =?utf-8?B?NXVrVDdXMDBIakJmSnNZY093QldmaCtDOFVMWHFqUndmL0dVT3Y0d1RoZGh2?=
 =?utf-8?B?VzFHWWpjcm1PT3JSQXBrZHlCNDFPR21mYzN2clBndEZNZlZsQ2FlQjdzMmJZ?=
 =?utf-8?B?cDZ0T3VlUjMxaVlrZFdOOFNPZm9tcVVqK2tGVkczOGpBMEFoZGJQUVV0eGRq?=
 =?utf-8?B?M0RuVGp2Y1EzVzByaERCTlczeGg2M0hENU1lajNIcWxna0hpaXBlQUJrQlR0?=
 =?utf-8?B?TGoyMThkK2txY2RpU1gwWG5DVG51SUtRdU9xTGZqT3ZvMjZEeVQ2bUJMSERk?=
 =?utf-8?B?NVNoa2tzNjFIYzFMS3I3MWptMkZUTzZjaVIyQUJNMXJGM3krcWlsZXM5Q3Ja?=
 =?utf-8?B?YkdvcVZ4cEU1YVZocGJnMEhMaERtbW5qc0pQbG42c1VKNXZRVWNteTNrQ2I4?=
 =?utf-8?B?VWRkdTU2Z3M3d2xXN3hsMFJZL0hRPT0=?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd19f776-f973-4695-41c6-08d9dc9a93f4
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB5630.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2022 04:57:51.7624
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AdEsQhFiOsruSU643j1YARAzPg5uAgETGAH3mp+mqdxQkGR290zVqaydcGdoJm+6qxpa19wBTP+bNBXEquptqxWVDjSocojFbqLOBV+NHIA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR08MB6785
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

21.01.2022 00:01, Petr Vorel wrote:
> Hi Nikita,
> 
> [ Cc: Steve as user-space maintainer, also Neil and whole linux-nfs ]
> 
>> On systemd-based linux hosts, rpcbind service is typically started via
>> socket activation, when the first client connects. If no client has
>> connected before LTP rpc test starts, rpcbind process will not be
>> running at the time of check_portmap_rpcbind() execution, causing
>> check_portmap_rpcbind() to report TCONF error.
> 
>> Fix that by adding a quiet invocation of 'rpcinfo' before checking for
>> rpcbind.
> 
> Looks reasonable, but I'd prefer to have confirmation from NFS experts.

NFS is not involved here, this is about sunrpc tests.

I had to add this patch to make 'runltp -f net.rpc' pass just after container is started - that happens 
in container autotests here.

Nikita
