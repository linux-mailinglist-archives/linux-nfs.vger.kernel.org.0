Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 690154AF89B
	for <lists+linux-nfs@lfdr.de>; Wed,  9 Feb 2022 18:38:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234972AbiBIRiK (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 9 Feb 2022 12:38:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230289AbiBIRiJ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 9 Feb 2022 12:38:09 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2051.outbound.protection.outlook.com [40.107.223.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FDC7C0613C9
        for <linux-nfs@vger.kernel.org>; Wed,  9 Feb 2022 09:38:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kh7P5Rwfz4c23BTH8l9RXyvIOQ9D7txBtBLtluVL/uBH4RpMQv8am/p7hqKp1iKuGcAZiiXNYVVA1lcSKvYg1wLvl3m7zFXb6SQHnf7Nid5nVfdzNDqKEFb70vAsrNTLSpbLwLY3sRxPhN5oG3Lm+zUt5CV8rpVMzitgRyrl1lJ+82pGj5Ut+uH+Ytq7j6Gyq2VzQMeBbGhTFxAh1ZbixfzaPAahd6UGNmpW1bgcIFMY7sLOvlTf/LNGmINwZCclY3yfxQFz2qOwf/vqyk/Bfw6G69PIHVGaJOiVNKOjSEYAc5x5CDkDDJ9jci+B5y55+x86jORVb5H29ilftNGyFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6+zh1QZ4aj+gNqhcwq7J/ErbkV82vv5tKQ7Or2qM5dw=;
 b=JWSSlzPF4WT+4pFbwyJppLbT5cTivesFMIyg3RoNu1/kYsZj34LfZyOIDaIgFnMvTei6I420dhK92acXHDAmh2tzRHnXUIIqeJATjzFAO0FrqgSbRdjgJnuaspPHrj7swr3iqkdnL9iXOZEW/i8eDdRerOIy4YPgZqjIqqs/zhP7DLgpaOxFXdForNC58rxKVf8jxksBzfb/cd5ccpSUXoirVtg48qGrbYYhkt3aYX17E7LU5IMfjPSE0lQB/03DNJq7LdmjP6h0VjHlcZWoVQ5KRrdvW+5MA360GCmAwkOFwOkolexTxbGFCOpWr6oUnHkaeSuMgGt+TnjV6KKnDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=talpey.com;
Received: from SN6PR01MB4445.prod.exchangelabs.com (2603:10b6:805:e2::33) by
 BYAPR01MB5095.prod.exchangelabs.com (2603:10b6:a03:1e::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4951.18; Wed, 9 Feb 2022 17:38:10 +0000
Received: from SN6PR01MB4445.prod.exchangelabs.com
 ([fe80::f94e:e0e0:4d0f:ef81]) by SN6PR01MB4445.prod.exchangelabs.com
 ([fe80::f94e:e0e0:4d0f:ef81%4]) with mapi id 15.20.4951.019; Wed, 9 Feb 2022
 17:38:10 +0000
Message-ID: <6b528d29-1a9c-d16e-f649-5d994d6222b8@talpey.com>
Date:   Wed, 9 Feb 2022 12:38:08 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: NFSv4 versus NFSv3 parallel client op/s
Content-Language: en-US
To:     Daire Byrne <daire@dneg.com>, linux-nfs <linux-nfs@vger.kernel.org>
References: <CAPt2mGMZh9=Vwcqjh0J4XoTu3stOnKwswdzApL4wCA_usOFV_g@mail.gmail.com>
From:   Tom Talpey <tom@talpey.com>
In-Reply-To: <CAPt2mGMZh9=Vwcqjh0J4XoTu3stOnKwswdzApL4wCA_usOFV_g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL0PR02CA0144.namprd02.prod.outlook.com
 (2603:10b6:208:35::49) To SN6PR01MB4445.prod.exchangelabs.com
 (2603:10b6:805:e2::33)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5d0b684f-1f82-4139-73c3-08d9ebf2f074
X-MS-TrafficTypeDiagnostic: BYAPR01MB5095:EE_
X-Microsoft-Antispam-PRVS: <BYAPR01MB5095A1BBE4D6BFCF2A9C9AA7D62E9@BYAPR01MB5095.prod.exchangelabs.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YAwq7eJiIMOUsgoudf/2VPyeh+1yOhZ7E0TZmy8qNr8fyvgmSMphSJk+4KTL5UcuX6ZcceZRncfNnLoAQCsSudho+qfUDxTtnCRxugn7Oc8/RwMOm/gAzxJadb+vENl0TgHlQP4KCu21BG2n/9vtFls0xv6+0+kyd9hV1Q0QDkanZh+HSFOroA4ipbRQKmgteab7JExPpo5Q8GPzzE2aYwq3tdeZrUW/+1PDls+akKCjIycJel/nQ6tYCZpneVche1nWhiu4icjpEQuUzK4pFKy1fsWom0sTAFs5Pktd3GFtO8+5VWaXS40ALQwDim+QaNbuA6PXA2mFS8fN7oiqkr5SgONu/L3eZZUhlBjnrP3iBsULTk3o36BMMLx5DbF+krl0OKoHWnomhDVQlkUB3qnsa1ew91bE6pMvo+XYmcqsX6MFnHLx87ju6XFgLUfoO9j7rNWKWObw/or3OtvmOSy1Achp5MlikNnhHknO6fTo5D8/+fx441BDvWipmHkT9CVPb7i8hlYRjSUmQH9/oDqYyoSzPcgsifv+2DXTEA8cRBhel/jWYLpP1SPEDvRIztCJf3vi96NL3pVx/8vVWEQ4wKS5xhs/Dib5mJkhUvcRvMBoJUlNDJvOyM+NWpZcY94tAjVvMW4gMkQJNfOM/t2G/nDtcH0plFWrxFJYfGHu/DPfn56tjDOJWMaG/N1vbOqjnE95cptghcwA+XOYehpiOQnr48cGcvCjuO3BtPTqcX/A8kx88MKRZAI5RxfH
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR01MB4445.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230001)(346002)(39830400003)(366004)(136003)(376002)(396003)(83380400001)(110136005)(2616005)(5660300002)(86362001)(36756003)(31686004)(186003)(6486002)(316002)(26005)(38350700002)(38100700002)(52116002)(31696002)(53546011)(66476007)(6506007)(508600001)(8936002)(6512007)(2906002)(66946007)(8676002)(66556008)(486264002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Zjg4N0h1Mis1dW51TWlIRFgzTnN2VUwzUkFqMitJa2hRS3ovL3g2Ri9NM2Zr?=
 =?utf-8?B?bU4zYlM3U0MvUkZCTWpuNGxnYzVVNkVsNlhSQUpwKzFYMnFWWTd2RkU2RFpC?=
 =?utf-8?B?Z0swQlJhUjZhenFlMUV1dm5SdXA3eWl2RmdsaUpqVHAzQlUydkYrTWlIdmkv?=
 =?utf-8?B?dkg3elZNemE2ZytZQjZlcTJ4RWg5d3BZZk9xT3ZxSnovTXdDcmxCUFhmZVBE?=
 =?utf-8?B?RUdXKzZ5LzhXdFRrTEdWWFdZWVgza2Z3SUFjMlFiVkZGNk1jYTFldGdiNWwz?=
 =?utf-8?B?L3M3bE00Ulp5UWJwUEJ2Y2ZEY2llQW11bzVhWmRwQWdEUkhOS3FmZE1nbloz?=
 =?utf-8?B?ZWhpZDJISmw5dTFQSkppR3R0UlRnZk56RllneDVmajVRUFRBMktCeUU1QTZ0?=
 =?utf-8?B?UDhoUnl1NzBTVEp5V0h4L0paTUc1a05QYnBKNXl3WGozRU9kVGY0NVdIUG02?=
 =?utf-8?B?U2dnZkdWaG1mM2lwbjhlOFBUSEZQdzB4MHNFVVpkd3hlaCtDZEY0aVhIdTVl?=
 =?utf-8?B?NWQzNC9VSzdNNlNUVENUZXJIT0dWK09LQ1VFZGdHNWRzdHlNbWxPamx1V3pC?=
 =?utf-8?B?VVJxdzQzZ21nQ0s2c3RLbDJjdXl4bVJucUR4TnppOTFzWTRZdjl5TW90emNj?=
 =?utf-8?B?Q0NoRW9jRGUwTk42WU1vd0E5TGVVVXVDM0tCRFQrdG1wcXNvZlZwazVGUllE?=
 =?utf-8?B?dVNjUlNXQTNJZWZ2aG5rWU9FVUJhTTFuWUpNckRUNlJ1MWF0bG1XUnJLands?=
 =?utf-8?B?cVhHUmNqanF5eGl4UndVTWpjUHhOOFFpelM3Z2N3MXFtd3J1SVh4Mmo0djRr?=
 =?utf-8?B?ZnlWQ1lycVRUSit5bkU3aHZSNEI3V0duVWNlNVkwOHhhRzB5emdtejVIZURU?=
 =?utf-8?B?dmNua3Nmd1pKdnc4emtwWEd3K0Fva1M5R0hFdFNiaXpYTTZFbGhidWFlazRk?=
 =?utf-8?B?UzJSZStLSzhJcWduOUcrUGlCQnV4OStuZTEvSzdIWTVOKzZ2djlwSnIwRGp6?=
 =?utf-8?B?SmV2c3NPNHdIaFpLTnFiS0I0Ky8vMUdWTTNnQXJJZHNXT01QZ05TZUtUbnNh?=
 =?utf-8?B?UE1RcHlTeDA0VDRvOFZTeldMV2dWNElHMm9OWkRjbkw1Rys4eVFmVGRiaU1t?=
 =?utf-8?B?cVVFdEJwak1MWHFuZ1gwVFVzUUhQNHNKK2pHRWEybHpvWHpleVhGRmRkOEp6?=
 =?utf-8?B?VldzWElOTm5xNUJKWkFmTUhyOFR2Z210THhUY0NuK2lhbmM1QW1KdDRrS01O?=
 =?utf-8?B?M3E2RVUyQTBuOFhFWnJOazhkR1lWVGlZY21kQi8zQUhiUHJCamFJZjVSOFh0?=
 =?utf-8?B?S3pIL0dGU2NLdkl3YWpFc2FBOVNRYTFiTFlGclFKSFZiNkpESGE5MzNqV0hq?=
 =?utf-8?B?bDVLSk8zQUxsUjdGNzJ4MEVKTG1xQ0drMkpYUVhMTDFOUU5NOG9LblVIVU9V?=
 =?utf-8?B?R0Z3M3lPNGVQSmIwRDRJRUlaeXNKRGZLblhSNndVM2xuQjJmMFNEZE4xcCs3?=
 =?utf-8?B?WnRtNko4aDdYZ2JZc1Q1Y3NZM2ZVUDZTd3EzTEo1eUFFeUlLcGlhS2diVFE4?=
 =?utf-8?B?UVFsc0tEcUdqaVphaGpGaE1SdDhDZ2E2Z25paDJxZWdNMGUvdVR1ekljUENG?=
 =?utf-8?B?WTdtVHppNFFQZmFZZXBzZmlnQjlOYjY0OFhiQ3E1azY0WTc0bWdLaFBreTN0?=
 =?utf-8?B?UURLS2o2aUVlb1FoRHFjeHhqYkZwa2VwZGFDUVR1QkYxcyt0Z2ZPQUFSbHZR?=
 =?utf-8?B?dnlDeFRUT1A4U0F1SmFpbm9FSHJRTDV2cXpRenNBSFJJQTM4OW5FS1ZlWEdM?=
 =?utf-8?B?V1o2TjArMlBlb1BFenRBNVlCRHBKTUkyelNQQVlzOXdwRkJGVThtUnM5Qlpq?=
 =?utf-8?B?dUZlT1JQUVc3VitXK2hRdEdoWDhBazdCSUczbFo4c0FGbms4S24xb1dYYXZO?=
 =?utf-8?B?QU1QRm5rbFZnaStHME5ZSzRTNk91a2ZkSC9BOEFUWWhIeVZnMHc1NHJmZDR3?=
 =?utf-8?B?Q3hHZy9KSTFGdzlkREpGNDVqc2JoMk9sbnRncC9jcHQ2WUMrYThtb0lVc0p4?=
 =?utf-8?B?NXl1bnZqbXhXSS9XemJDRUVLZHZ5N0ZZNVp4L3lXMzZIeVhQdWpkK1FqVVpp?=
 =?utf-8?Q?SzYQ=3D?=
X-OriginatorOrg: talpey.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d0b684f-1f82-4139-73c3-08d9ebf2f074
X-MS-Exchange-CrossTenant-AuthSource: SN6PR01MB4445.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2022 17:38:10.0756
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2b2dcae7-2555-4add-bc80-48756da031d5
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uIC+sTHrBJfu6r41Nkp2EXDukyahQ0MUT9yR41bvTl2NkCUCspLpc8wRa83iYTiq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR01MB5095
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 2/7/2022 1:57 PM, Daire Byrne wrote:
> Hi,
> 
> As part of my ongoing investigations into high latency WAN NFS
> performance with only a single client (for the purposes of then
> re-exporting), I have been looking at the metadata performance
> differences between NFSv3 and NFSv4.2.
> 
> High latency seems to be a particularly good way of highlighting the
> parallel/concurrency performance limitations with a single NFS client.
> So I took a client 200ms away from the server and ran things like
> open() and stat() calls to many files & directories using simultaneous
> threads (200+) to see how many requests and operations we could keep
> in flight simultaneously.
> 
> The executive summary is that NFSv4 is around 10x worse than NFSv3 and
> an NFSv4 client clearly flatlines at around 180 ops/s with 200ms. By
> comparison, an NFSv3 client can do around 1,500 ops/s (access+lookup)
> with the same test.
> 
> On paper, NFSv4 is more compelling over the WAN as it should reduce
> round trips with things like compound operations and delegations, but
> that's only good if it can do lots of them simultaneously too.
> 
> Comparing the slot table/xport stats between the two protocols while
> running the benchmark highlights the difference:
> 
> NFSv3
> opts: rw,vers=3,rsize=1048576,wsize=1048576,namlen=255,acregmin=3600,acregmax=3600,acdirmin=3600,acdirmax=3600,hard,nocto,noresvport,proto=tcp,nconnect=4,timeo=600,retrans=10,sec=sys,mountaddr=10.25.22.17,mountvers=3,mountport=20048,mountproto=udp,fsc,local_lock=none
> xprt: tcp 0 1 2 0 0 85480 85380 0 6549783 0 102 166291 6296122
> xprt: tcp 0 1 2 0 0 85827 85727 0 6575842 0 102 149914 6322130
> xprt: tcp 0 1 2 0 0 85674 85574 0 6577487 0 102 131288 6320278
> xprt: tcp 0 1 2 0 0 84943 84843 0 6505613 0 102 182313 6251396
> 
> NFSv4.2
> opts: rw,vers=4.2,rsize=1048576,wsize=1048576,namlen=255,acregmin=3600,acregmax=3600,acdirmin=3600,acdirmax=3600,hard,nocto,noresvport,proto=tcp,nconnect=4,timeo=600,retrans=10,sec=sys,clientaddr=10.25.112.8,fsc,local_lock=none
> xprt: tcp 0 0 2 0 0 301 301 0 1439 0 9 80 1058
> xprt: tcp 0 0 2 0 0 294 294 0 1452 0 10 79 1085
> xprt: tcp 0 0 2 0 0 292 292 0 1443 0 10 102 1055
> xprt: tcp 0 0 2 0 0 287 286 0 1407 0 9 64 1067
> 
> So either we aren't putting things into the slot table quickly enough
> for it to scale up, or it just isn't scaling for some other reason.
> 
> The max slots of 101 for NFSv3 and 10 for NFSv4.2 probably accounts
> for the aggregate difference of 10x I see in benchmarking?
> 
> I tried increasing the /sys/module/nfs/parameters/max_session_slots
> from 64 to 128 on the client (modprobe.conf & reboot) but it didn't
> seem to make much difference. Maybe it's a server side limit then and
> the lowest is being used:
> 
> fs/nfsd/stat.h:
> #define NFSD_SLOT_CACHE_SIZE            2048
> /* Maximum number of NFSD_SLOT_CACHE_SIZE slots per session */
> #define NFSD_CACHE_SIZE_SLOTS_PER_SESSION       32
> 
> I'm sure there are probably good reasons for these values (like
> stopping a client from hogging the queue) but is this the reason I see
> such a big difference in the performance of concurrency for a single
> client over high latencies?

Daire, I'm interested in your results if you increase the server slot
limits. Remember that the "slot" is an NFSv4.1+ protocol element. In
NFSv3 and v4.0, there is no protocol-based flow control, so the max
outstanding RPC counts are effectively the smaller of the client's and
server's RPC task and/or thread limits, and of course the wire itself.

With a 200msec RTT and a single-threaded workload, you'll get 5 ops/sec,
times 32 slots that's pretty much the 180 you see. So I'd expect it to
rise linearly as you scale both ends' slot numbers.

> Why do I feel like in writing this all down, I have probably answered
> my own question...

:)

Tom.
