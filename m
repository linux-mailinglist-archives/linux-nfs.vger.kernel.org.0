Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F23EE4BC1F1
	for <lists+linux-nfs@lfdr.de>; Fri, 18 Feb 2022 22:27:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239022AbiBRV1Z (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 18 Feb 2022 16:27:25 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233158AbiBRV1Q (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 18 Feb 2022 16:27:16 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2069.outbound.protection.outlook.com [40.107.94.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0BCE26FA
        for <linux-nfs@vger.kernel.org>; Fri, 18 Feb 2022 13:26:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d5PoIyVVpXOLUrTV15zPkDNazTq3ePUsdTvpTd++6BKV17TibOSM39humE3vxdrWq84JKkqc3EdvWh+orTqzLP+UcM1ZaRkBhmVMHRUuKh08Yq1eO8NVCOFmUbu5ofYZQJQu6ybJG2cTSE540vMOyvDdRQCWissxhqLC9BF3mOgnzRwbF/4dh7Vs5eswpp6aAT7xCSocyhZnJIBq44MiJZDx1uXzY9aIiVE04w1jQMPN0dvjaE8GUAjXMJjaOKyZvH1LeTsg2BTzpfveuedivGl+Tj1xyOOom8WJNX7rAN6eWESd3vheepS6+fdtl1/E5wGsbqUJ9q/CNczKgrNbDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kH8zJIwGLiESRvAnVlNBLD00yWQDwMJbJSvpqlIIcuE=;
 b=euevbbmWW2C70o8HMen2VmIH+qT0kNUV2czfwbNQ0yqYh9BDst7MAC+/QoYcd6sOyG+Zz3KLOJg3tBc4POmXIFHxuaST69Ouf4rNwanI/Sep40ilLMUpGvmZGQSy1rSsRn26aiOiHjG3FNRTZgdUfo+Pq0jPH9SsGlSfk+Jr1/EOyRCGl0xkg5EEg1CGWM1cDeKAhtJYL9HeKUmwXHcdx7Ybafh7TF+JIRvVTOUBwMrRQqpKimysEAErN8sEf4fbkfrzrJtBAfu0/fbC3zZetp5ls+RuPGslKEeOxOGermW4ZcA0E1jsP1yY9yF/220zZahi8nXl3uPNkLAK8v66FQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=talpey.com; dmarc=pass action=none header.from=talpey.com;
 dkim=pass header.d=talpey.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=talpey.com;
Received: from SN6PR01MB4445.prod.exchangelabs.com (2603:10b6:805:e2::33) by
 DM6PR01MB4027.prod.exchangelabs.com (2603:10b6:5:21::15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4995.15; Fri, 18 Feb 2022 21:26:54 +0000
Received: from SN6PR01MB4445.prod.exchangelabs.com
 ([fe80::3452:1c0a:743a:602d]) by SN6PR01MB4445.prod.exchangelabs.com
 ([fe80::3452:1c0a:743a:602d%4]) with mapi id 15.20.4975.020; Fri, 18 Feb 2022
 21:26:53 +0000
Message-ID: <3849f322-94f7-fe73-4e08-1660be516384@talpey.com>
Date:   Fri, 18 Feb 2022 16:26:53 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: NFSv4 versus NFSv3 parallel client op/s
Content-Language: en-US
To:     Daire Byrne <daire@dneg.com>
Cc:     linux-nfs <linux-nfs@vger.kernel.org>
References: <CAPt2mGMZh9=Vwcqjh0J4XoTu3stOnKwswdzApL4wCA_usOFV_g@mail.gmail.com>
 <6b528d29-1a9c-d16e-f649-5d994d6222b8@talpey.com>
 <CAPt2mGOnbN=N5TqCWzVtX7CYoptpknCbnSXGfoX8X87DsvhoKw@mail.gmail.com>
From:   Tom Talpey <tom@talpey.com>
In-Reply-To: <CAPt2mGOnbN=N5TqCWzVtX7CYoptpknCbnSXGfoX8X87DsvhoKw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1P221CA0023.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:2c5::10) To SN6PR01MB4445.prod.exchangelabs.com
 (2603:10b6:805:e2::33)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 571e98c1-9139-48d3-eb8e-08d9f3256223
X-MS-TrafficTypeDiagnostic: DM6PR01MB4027:EE_
X-Microsoft-Antispam-PRVS: <DM6PR01MB4027ACF59211DDE291CBFDB0D6379@DM6PR01MB4027.prod.exchangelabs.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ypXtX/ak19wbrVTdIcUCa0eD6cFyUIhpHc8CEDC4BXnvcIjxJOYvGKFhKPKcizpLagIGjbPMJ/n+rarW5++wte+WTWQfX2OqYabFWsqmdWVGC1yhkP7msfuSFSqE66ASskZZc62Fq5ee5IkpvQRU/cOusNMeZwpMCtIqav/xznqS3DLJkMIcQ62uI9DBCCUJwYu6HjbH21/ifV4yTYrxoNMUsn5jaRjKO9aa7DJsmK/pj3xiLiqIpYbjvsjZp2zkcQ3txWQhh5yv5Ew+ebKXgMymTvN2LezJq+v5UJ6SZy7gAu+eYhyHAEQUV9rqv0u5yIsv4V6oTaOBJ4veekerPfYjyL9wqmAO+9ly5wcentYLsg5iobtoKeVUzGLJk/FU9n76pXSA/NpRabAIpuRYYrINm5zaakPaiK48NX0zhZk4VyukWvqu3Z0jE7odvKhC+f1WCWRGPaVJmTH5F1V2ZBSopL+PtigsrE4/XpOrS12Qe2UQAvw0RR3TMsh6qPasYTBO8M6BAvmBEhKyvB47YKSEonuPjuFV2kQFoy6IKACdxSmn/DTK95dQNG6Y0CoZh8IoHyorSlkdnUfQ5OSXt9XSv7xk7C2MxLpZbWqyL0p78PsGyWZvGgWljSDlUHT06Vzs4j8gqU6tQXj3BWr3lDyh6yZqNe0+CCXIe4zPAABw+fsVSFA5kQJb5h39rqlbzSdr+j+GeIioDcVFKypLgrg1JJWCWLNxb6hMZ/QH42/Ckk80ljC/wFukhFYdsuBA
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR01MB4445.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230001)(136003)(376002)(39830400003)(346002)(396003)(366004)(52116002)(186003)(83380400001)(6512007)(38350700002)(53546011)(8936002)(26005)(66946007)(31686004)(66556008)(2906002)(2616005)(6506007)(66476007)(5660300002)(38100700002)(8676002)(6916009)(36756003)(6486002)(508600001)(31696002)(86362001)(4326008)(316002)(486264002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Zm1HcndaekQ3YkZkUTlLOEN1YkhDYmZMdHcwQXB0QkM1SklIZk01MHBwOC9m?=
 =?utf-8?B?eXd2V0xaSnQvaFNwdmRJRVlzKy9aUWtsbHFsRVZXeS94cjQ1VFA3ZSt3MTh4?=
 =?utf-8?B?Vm02QTIxSk9rS2lJV3JORmZQeC9Dd3VSNDY0NEFla1BpSWgrOWFtYVBpcnJk?=
 =?utf-8?B?Slg3ZUEyajM2eWxNMGtaWFhWZlU4WWxxUXNFdTE1R2xXWG9KR05NUFlxNmhF?=
 =?utf-8?B?RkJSTytPVzUvS2UyWE03MXZsRWNpN3hBaXF2UmZERW9Vb1k1aU9EdEFEZ0d6?=
 =?utf-8?B?UXRIK3FXY3Y5cExXZ1hKMW5xbldiZGxNNS8ybXF1YUcxMzdlRXJaU1ZEWFJp?=
 =?utf-8?B?djF0Z2l2V0wvS3g1aFlwdUJNWXpiM0E2L0I1eUVBb0RwSVFpYmhhWXFvK1gw?=
 =?utf-8?B?Z2VsdU9zUnJvTDllUkxOa3IwRHNMM3N4Mm5LdUtpN1dNUVI2WDFwYk94MlJy?=
 =?utf-8?B?RFU5aitCd2kya1VVSXhvdWYxdVhTUENFRWFqWVB1N2doVXdEa1lFd2YyRkFJ?=
 =?utf-8?B?Q3RNeCtjcnZ4bm9ISG5FeHdpbGpTRjRPVnBVOGZjS0Fmc3QwTGlyZER3L0xr?=
 =?utf-8?B?YWtBdVIzUjNBMkdOM0dHcmVHUWRtWDlMUGk5RmhudzhVOVlPYngrcjJ0cXJl?=
 =?utf-8?B?aXZReTY0M1IwNFJhN204blB3UGxwRTVweFFxSy80WTVtL1Awa3liU0JYKzQ0?=
 =?utf-8?B?d0IvQ05EenFXZUFDZE8vbUpaVE9yVk16UGtxbXcvejk3WFRkamEzVnhML0J2?=
 =?utf-8?B?L1FNelBFLzFEK1cxdkdBZEZZWHFZTTVuZVNOMXJzL1lJMWxmVmhNdDJVNmNu?=
 =?utf-8?B?VFVvVzlrSkhqcTR6WUNpNFdFLzdkOTY0M0pWT0VnaEM0cXlCQlAvYzFpQVFS?=
 =?utf-8?B?TktpN01HaWJlcGhVdVJnRjczbFBsUE1JTHVRQ2crZ1l4M1J3RlJoZk5PU2li?=
 =?utf-8?B?YUlLNHBFWFVrSFpUWDJ0U0V3NEUvcmovTGpLWEVzU0ZwaUlXU1F2OUlENGpT?=
 =?utf-8?B?UUl3MnhwTk1JS1cwMjlJMkYxVFVXa3VxUWN3MkVwa2QrQkxpUFk1bytXRE1s?=
 =?utf-8?B?NXFkYkY3ZCs2bFpFdHRxM3dzUDFCYkd3aFVUc1gxcHBIOUFTYXI0THoyQnBa?=
 =?utf-8?B?ZUdtRmovcVRlVllQb0JrNGljcmREbS9mQXFVd3ZwQVQ4elRqdkhveTI3REgw?=
 =?utf-8?B?Z25scWpFazF6bEt0SDNYYll6d1AxUGdBaXFxaHpXNXozL2tFZzVORWxjZy9K?=
 =?utf-8?B?T05mSnhNVG84THVCNnROSGxLN1NVUFRBUmErSjlZSzkzQU44QThST01PeHBi?=
 =?utf-8?B?NGpkd3VZR0JZb2lVdXEyZ2xhNFRYNitPenpqc2pESE50RTlEM3o1SUJpa25a?=
 =?utf-8?B?TUhnWWRFWjR4UzJWSjR4YjRMdVBhd1QrWWsvakNTdWpYTDhNa3VDY05WeS91?=
 =?utf-8?B?UXBRZWpoK3B3SVFNNHhZano4UndjSHpoeFZObXYxOEd3eVo5NHVaRGlkejBS?=
 =?utf-8?B?c3laZVBXbGpaN3R1ZDJHd3V1OGFodUhSQVN2d3M2c2hhdzN5R0EwRHlNKy9N?=
 =?utf-8?B?aWwzcnpqcnpMdWxRYThQbjVCNTBRSHRYVEU4ZFhVNWRQYnBUaGc2c3B2M0xT?=
 =?utf-8?B?M0pIQ2p3Z2VFOEdYa2NGMXUweVVpbHNJSk5RcFUwbzQwNEl3V1Nyc2l1U3FP?=
 =?utf-8?B?UnpNRjNZOGJMVitDNHVpMkZpbE5BN0JzTHR2STZyd3BLa3A4b1N0QnQ1TnNs?=
 =?utf-8?B?UVlSQXpSYzJmQitvRDRJSXVuS2NWRmJtOTlkcUN0dFZRSUVFeGNuTGVNejRK?=
 =?utf-8?B?K3ZGSDcrSlFYWHVEaWxSL29jOWVqSmxOM1gzcmtZdGxtanErZ1lDS09Hb3d4?=
 =?utf-8?B?dUpMcUVXTHFQb0ttcitiQi90YlZUMkp4bTJHNW9LbjZPcEg5Q0pJMUU4elUy?=
 =?utf-8?B?VENGTlhmZU9FUG14d3RFc2U4UmQxeVZGcEZZRWU4c1c2THNNZTlEOTJsVW1Y?=
 =?utf-8?B?UXFDU1dnWFVJMWRzdzRJY0tOOU14anA0VURFNTBHdkVmRCtCaUk3ZjYveTEy?=
 =?utf-8?B?NXA4NGNQampJNzFFWHcxSm1IYS8xcXA3eG9FMWMzd3k2ck00Y2RNSEdpUHBy?=
 =?utf-8?Q?oTZs=3D?=
X-OriginatorOrg: talpey.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 571e98c1-9139-48d3-eb8e-08d9f3256223
X-MS-Exchange-CrossTenant-AuthSource: SN6PR01MB4445.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2022 21:26:53.9402
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2b2dcae7-2555-4add-bc80-48756da031d5
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hxQQUaX3O0pM4rBNhQ8CtRUdvMBck68SprpiBdvFkDeP5nouOur8OOMPfoKRVXTC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR01MB4027
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


On 2/18/2022 2:04 PM, Daire Byrne wrote:
> On Wed, 9 Feb 2022 at 17:38, Tom Talpey <tom@talpey.com> wrote:
>>
>> On 2/7/2022 1:57 PM, Daire Byrne wrote:
>>> Hi,
>>>
>>> As part of my ongoing investigations into high latency WAN NFS
>>> performance with only a single client (for the purposes of then
>>> re-exporting), I have been looking at the metadata performance
>>> differences between NFSv3 and NFSv4.2.
>>>
>>> High latency seems to be a particularly good way of highlighting the
>>> parallel/concurrency performance limitations with a single NFS client.
>>> So I took a client 200ms away from the server and ran things like
>>> open() and stat() calls to many files & directories using simultaneous
>>> threads (200+) to see how many requests and operations we could keep
>>> in flight simultaneously.
>>>
>>> The executive summary is that NFSv4 is around 10x worse than NFSv3 and
>>> an NFSv4 client clearly flatlines at around 180 ops/s with 200ms. By
>>> comparison, an NFSv3 client can do around 1,500 ops/s (access+lookup)
>>> with the same test.
>>>
>>> On paper, NFSv4 is more compelling over the WAN as it should reduce
>>> round trips with things like compound operations and delegations, but
>>> that's only good if it can do lots of them simultaneously too.
>>>
>>> Comparing the slot table/xport stats between the two protocols while
>>> running the benchmark highlights the difference:
>>>
>>> NFSv3
>>> opts: rw,vers=3,rsize=1048576,wsize=1048576,namlen=255,acregmin=3600,acregmax=3600,acdirmin=3600,acdirmax=3600,hard,nocto,noresvport,proto=tcp,nconnect=4,timeo=600,retrans=10,sec=sys,mountaddr=10.25.22.17,mountvers=3,mountport=20048,mountproto=udp,fsc,local_lock=none
>>> xprt: tcp 0 1 2 0 0 85480 85380 0 6549783 0 102 166291 6296122
>>> xprt: tcp 0 1 2 0 0 85827 85727 0 6575842 0 102 149914 6322130
>>> xprt: tcp 0 1 2 0 0 85674 85574 0 6577487 0 102 131288 6320278
>>> xprt: tcp 0 1 2 0 0 84943 84843 0 6505613 0 102 182313 6251396
>>>
>>> NFSv4.2
>>> opts: rw,vers=4.2,rsize=1048576,wsize=1048576,namlen=255,acregmin=3600,acregmax=3600,acdirmin=3600,acdirmax=3600,hard,nocto,noresvport,proto=tcp,nconnect=4,timeo=600,retrans=10,sec=sys,clientaddr=10.25.112.8,fsc,local_lock=none
>>> xprt: tcp 0 0 2 0 0 301 301 0 1439 0 9 80 1058
>>> xprt: tcp 0 0 2 0 0 294 294 0 1452 0 10 79 1085
>>> xprt: tcp 0 0 2 0 0 292 292 0 1443 0 10 102 1055
>>> xprt: tcp 0 0 2 0 0 287 286 0 1407 0 9 64 1067
>>>
>>> So either we aren't putting things into the slot table quickly enough
>>> for it to scale up, or it just isn't scaling for some other reason.
>>>
>>> The max slots of 101 for NFSv3 and 10 for NFSv4.2 probably accounts
>>> for the aggregate difference of 10x I see in benchmarking?
>>>
>>> I tried increasing the /sys/module/nfs/parameters/max_session_slots
>>> from 64 to 128 on the client (modprobe.conf & reboot) but it didn't
>>> seem to make much difference. Maybe it's a server side limit then and
>>> the lowest is being used:
>>>
>>> fs/nfsd/stat.h:
>>> #define NFSD_SLOT_CACHE_SIZE            2048
>>> /* Maximum number of NFSD_SLOT_CACHE_SIZE slots per session */
>>> #define NFSD_CACHE_SIZE_SLOTS_PER_SESSION       32
>>>
>>> I'm sure there are probably good reasons for these values (like
>>> stopping a client from hogging the queue) but is this the reason I see
>>> such a big difference in the performance of concurrency for a single
>>> client over high latencies?
>>
>> Daire, I'm interested in your results if you increase the server slot
>> limits. Remember that the "slot" is an NFSv4.1+ protocol element. In
>> NFSv3 and v4.0, there is no protocol-based flow control, so the max
>> outstanding RPC counts are effectively the smaller of the client's and
>> server's RPC task and/or thread limits, and of course the wire itself.
>>
>> With a 200msec RTT and a single-threaded workload, you'll get 5 ops/sec,
>> times 32 slots that's pretty much the 180 you see. So I'd expect it to
>> rise linearly as you scale both ends' slot numbers.
> 
> I finally got around to testing this again. I recompiled a server kernel with:
> 
> NFSD_CACHE_SIZE_SLOTS_PER_SESSION=256
> 
> I ran some more tests and as predicted this helps a lot. Because the
> client default for the client's max_sessions_slots=64 (where the
> server is 32), I saw double the concurrency straightaway.

Nice, thanks for the followup!

> And then as I increased the client's max_sessions_slots (up to 256) it
> kept on improving. I guess I would need to set the server and client
> slots to be around 512 to see the same concurrency performance as for
> NFSv3 with 200ms.
> 
> Which I guess leads on to some questions:
> 1) Why is NFSD_CACHE_SIZE_SLOTS_PER_SESSION not a tunable? We don't
> really want to maintain our own kernel compiles on our RHEL8 servers.

I totally agree that it's reasonable to allow tuning. And, 32 is a
woefully small maximum.

> 2) Why is the default linux client slot count 64 and the server's is
> 32? You can tune the linux client down and not up (if using a Linux
> server).

That's for Trond and Chuck I guess.

> 3) What would be the recommended and safest way to have a few high
> latency clients with increased slots and concurrency?

So, slot counts are negotiable, and dynamic, between client and
server in NVSv4.1+. But I don't believe that either the Linux client
or server allow them to change after starting a session.

IMO the best way is to write some code to manage slots both to increase
on demand and decrease on non-use. But dynamic credit management is a
devilishly hard thing to get right. It won't be trivial.

> I'm thinking it would be better to have the server default be higher
> and the linux client default be 32 instead to replicate the current
> situation. But no doubt there are other storage filers that already
> rely on the fact that the Linux client uses 64 (e.g. cloud Netapps and
> the like).

If that's true, it'd be a shame. The protocol allows any value. No
constant number will ever be "best", or even correct.

> It's probably just a lot less hassle to stick with NFSv3 for this kind
> of high latency multi process concurrency use case.

That, too, would be a shame. It's worth the effort to find a better
NFSv4.1 Linux solution.

Tom.
