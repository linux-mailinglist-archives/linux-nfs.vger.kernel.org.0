Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 168D658BABF
	for <lists+linux-nfs@lfdr.de>; Sun,  7 Aug 2022 14:01:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232153AbiHGMBD (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 7 Aug 2022 08:01:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231860AbiHGMBC (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 7 Aug 2022 08:01:02 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2041.outbound.protection.outlook.com [40.107.100.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFA3D2BD2
        for <linux-nfs@vger.kernel.org>; Sun,  7 Aug 2022 05:00:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SPZIcLzehwaWiLlJ43ZCpKNpyiYvU1yIDPgyroSo0e27mDCubaADk2/VmQU9YgkYS62SGBqfVP+GUEQQMiOPpAMBtiItddg6aeK1OYpl59W5+Kgg3yirwUNrqCWrTnOWFgqqWs9Dl924cIeSabMRxBHC43efOa/y5HYYhU85ZSYRtWzGv/STGO+6duyMQWqMWf0y+a8Naso/ukETPPlWoTYvWdYywfMk2Cp9YAVEitb1O68zpsmyeSfTbPTjJFqbU6/0MgQDzmeb8Po0pZU/qKSh92ABGM+tv7kHk+GIhcGaqRVDcwsAl2Ure4O3W4M9WnnHN/sQFGstxD90F0TbfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cKIHfvX8Uzbfu4jqu2yke2tmspbkLg92HtjZFe29bT8=;
 b=JSYyD6JPtc9B+/8QoQA6C/ZY0VIGXktySSpHG2XpuDYEAUXJVOb0VNMcDltkYGnUJE6dfAtid/r2qOTa+jUYaIoBFL4RbXggA3rzsR11tCWrUmWn+Ptc6gw3tGPS6bm4UWClbzfl7nGj8k5cbUjpBkm0bfsL+XM8HMF2HvoDlh8GTEQ5nSJutnP367pLgt3gMcfumxnIyKVMYHy1GBULloAeWhlpyHIhHgZelPVy06EzAfZxvufT4b0IsbPhyliJ+/pVp4P1iMWg1Ux+nJWp7nbEYzF7yq7FF/n0TJUBankZ5cGHzhmE0i8n2TVejQXU7MsLOIdZOnp7EgdeOmeLIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=talpey.com; dmarc=pass action=none header.from=talpey.com;
 dkim=pass header.d=talpey.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=talpey.com;
Received: from SN6PR01MB4445.prod.exchangelabs.com (2603:10b6:805:e2::33) by
 BL0PR01MB5249.prod.exchangelabs.com (2603:10b6:208:7f::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5504.14; Sun, 7 Aug 2022 12:00:56 +0000
Received: from SN6PR01MB4445.prod.exchangelabs.com
 ([fe80::21e9:8dbb:6e40:5073]) by SN6PR01MB4445.prod.exchangelabs.com
 ([fe80::21e9:8dbb:6e40:5073%2]) with mapi id 15.20.5504.015; Sun, 7 Aug 2022
 12:00:56 +0000
Message-ID: <ec225634-44cd-aeeb-4919-956e68b249f0@talpey.com>
Date:   Sun, 7 Aug 2022 08:00:55 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0.3
Subject: Re: Question about nlmclnt_lock
To:     Trond Myklebust <trondmy@hammerspace.com>,
        "j.kasiak@gmail.com" <j.kasiak@gmail.com>
Cc:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
References: <CAD15GZf0FtU81hwQ+brhnt+sv895=TpAuz-YrMtjfx__FJ28Gg@mail.gmail.com>
 <8ae13798a15c69cf16272579f49768ec92484584.camel@hammerspace.com>
 <CAD15GZfmpdzMhXquciebs5M4e2kewu+yTUcTx9c-jeSXgZS+XQ@mail.gmail.com>
 <668b5de2f3951f0d64aa10e910a8aa3d626bec91.camel@hammerspace.com>
Content-Language: en-US
From:   Tom Talpey <tom@talpey.com>
In-Reply-To: <668b5de2f3951f0d64aa10e910a8aa3d626bec91.camel@hammerspace.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR15CA0037.namprd15.prod.outlook.com
 (2603:10b6:208:237::6) To SN6PR01MB4445.prod.exchangelabs.com
 (2603:10b6:805:e2::33)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b208d457-cec6-41c6-a257-08da786c7c23
X-MS-TrafficTypeDiagnostic: BL0PR01MB5249:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZnFJzfqTGiSS16UKpcgZZ5jp0KSORQjk6xUdeTuPCBxEO9YCzbNCjWotfgBJea8wZEUQ8nShc4PF3gs3kP7Q0Lcyd6HYpr1DZ4gIKF2Q+CeCvOIavWXXilo+Ioq50j/9cX2ymYkNAHfeK+Rwq2qJMPD51ro+lK+cqGbpRIlVlNsH2qf45zp49UQlZ/lPp8zc7EG5bZXAsJGScIONFUxCNj5OAYlB1qX+JbIN7p40cg4ZceAvCC+fYloEE8sJVCiff7mgtFbtgz1J/jvWv/LbSaQPzwLRPHBxO3MHtT64RqOUNbz2suuOEk7dreIXFLAoH3ntx1FLB9UdylkLJND67Gngtqf994hqkU9SjImaUraxS9rpAjsBp8VZ/YV1o8HOxNGmymwwkCtXymmBrtxrG852aYkwV33TKQsRHZzo2UhU5WlxuAVXDGzsQTMFALaIXnGd2+y8p3tWjZdP3HAKz/EhIBhg8ajgjiPL+2+wykKPZsGZvP2ehOoyoFMnC/k2QBFnNhcE0vyS9F4DGQTqzpzjcI9PuPY2xoy6GIHWkVv1k1pH4QHzyDG3zYBvFlwSCJY/UXVPkuTWrMdygrJdnk1OvST9xQruGDQuPWKIrxVh7U7pUQhf9qQEGw8Pbe4eBwFc3y0TO2gntCDSm5O98jWvgGo7K5vwDIpjBFzKfWbKF8q/XioZR0bhDQTiZ5lFLVgMjWnEeZd50tsUCC9GZIkKcBjpneHr/vFEFNev9GewFJyxK7ntw/7hbzl0ZP57x+mm+Z8TtMJ3mTm4k7HirgSLuNnNMU2/IJtSkXDKuLzLTCcrXy7KScWMakxybDNDrDelQL2iuVDHYVqfJeBLDE7v5Kw40Yemf151RgnPtsM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR01MB4445.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230016)(39830400003)(366004)(136003)(376002)(346002)(396003)(2616005)(86362001)(26005)(6512007)(31696002)(52116002)(53546011)(38100700002)(6506007)(38350700002)(83380400001)(186003)(41300700001)(4326008)(36756003)(7116003)(8676002)(8936002)(66476007)(66556008)(2906002)(31686004)(5660300002)(110136005)(478600001)(966005)(6486002)(66946007)(316002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cHlHU1J1T2VodmYvT0VDWExucWk4TEpyblFqQmpublkrTWZQSENZWHlodUd4?=
 =?utf-8?B?TzV4Rlk5Z09Mcnk0b1hLQUVnQVFzRjlWVlhLL1RYZG4xOE51Sk5odmU1RnZs?=
 =?utf-8?B?WVRXaG9abHd6T0hUM1RuWXpTZ1Rsc3NDaGRDQkJFZjZDclBKWllydkM2Tjdk?=
 =?utf-8?B?M1YzSVdORmVDZmV2dDhNcFhTSlBBa1EyMmNSK2RNeVhsS2dGUTN5SXJ5bTBn?=
 =?utf-8?B?UW9lNjhtazIzakxyOVcyQWgvWlBpOHZoVG05MUlSRE1uV0gxYTdaK0lDRzkx?=
 =?utf-8?B?OFp2ZlRSWk9nODdvSmF6WXVaNWFTeFQ2ZXN5ZXljNnRLTWhheEQ5WCthVE42?=
 =?utf-8?B?WGVQOGhieGE1bisycDYwR3RUMXhjOUpmaldLWHdnTlNUejJ1WDZzOFFSbGtu?=
 =?utf-8?B?Z2djV0hHUWRvTVJBQlZ0dDVEOWFuY1BxWHBLVHBHeEI0MkJqUENxaVd4dHMr?=
 =?utf-8?B?cXZVV0R6c1hJRkNEMjJJcUp1dTRqSlY1OEZnYWVOOTVPRU90SmFNTkxnZHhk?=
 =?utf-8?B?NzJ0anQwb0lheHY1U201RFRNeTJmSWNuRUw4alRXb0QrU3VSY1BGSmFaU1RX?=
 =?utf-8?B?eFJTckcySDZCd2RTdjNKbktJV1Z5YWJSY3IyUklxWnptb3hNbVZwTFN1MEdQ?=
 =?utf-8?B?bENsanozbDh4azBOcFo5SWdVRE5ZTGNEOTlYUjdndTRRbDZPcjZwWUhGNEpi?=
 =?utf-8?B?NEJPb1Y4Mnphd0FERVF3eEZVNGpPaTAzaGd0OGxnVUNGVUUxM0FpaUtsU2hq?=
 =?utf-8?B?OXp1WEErT0NWNmNRT1drMDNYWmpYU2FGdDdZbllsZHJFbjRCWUxtdERTN08z?=
 =?utf-8?B?QkJqelJJdzZuQTJvTGRiTGk2cHJLSndMYVRpV3VPQWZCRDIvbUNkakRzRFpW?=
 =?utf-8?B?b2QwL3VXRE5NMXVMTVZUWU1SYTQwazIweTMvVTUxbHgwMmcvNVBtUnhSdit0?=
 =?utf-8?B?Y1E0Ri96ZnRuNnl1MmJtZmJIUTVUbDFNbVRNS3dNOHl4SHdZb0czQnNmMGVW?=
 =?utf-8?B?eTZtWWFrWWR0aGw1N2NaRm04OGFFYW5uYXpFVEp1SWlVZFFoZXlhME93RkRZ?=
 =?utf-8?B?Nyt6UUpNNUk2ZG5vdUJtdW5mOXJRR3lrRVNrOVdlSXcySm9PRUNTek51UmxV?=
 =?utf-8?B?REVGNzVVbEZCYUc3Ulk4Tm9tZncvcS93UW5ZeHVROU9UWVFMcHh6Vkhvblk3?=
 =?utf-8?B?VDFyb1BQVldaQllLSzc0L0hVMzE1Q0tYMDBJbElzbzIxenVtNlJDeTJzVlpF?=
 =?utf-8?B?MmMwMXE3SGZnUkxIL01pajNMWnlmWnlQb3U3a2ZmelhKUTdtemk2eXJRcllK?=
 =?utf-8?B?Y0t0bjlUMENRWUxvYUtETE9lSzhlTlBLNVB2RWdLTWNEbzIxejh5cC9LODdm?=
 =?utf-8?B?YVNIcWl1VW80YXA0OUFoZnZmU1B4L1JGQnMzQVVTaWdUTHZNbjN6a0NIRVBj?=
 =?utf-8?B?akFESlk0OUlzS2ZjWEVGMkYyb1o1c0RZRWFaSHE1dDlXaHNmSk5TUnp3K1ZM?=
 =?utf-8?B?cHpaWVZvV3JQNlhOeWlkWldhVnJpUzJIaURxOXpUaVhVcnAzb0VCdE9tVXd3?=
 =?utf-8?B?NTE5MmVOMVordVBuZnk2MUh2VElvbWgwNCtCc1FrR0VOMXdUdk0vQ0RlMFBU?=
 =?utf-8?B?M042NDFrZDlQakQrMEx6VllUK2haTjVJbU1ZaFV3blphOTl0cWRuZXRlZXFm?=
 =?utf-8?B?WXR4dEZrL0gzallPWnFDWmdENEpheTRnc2dtb3Y2ckROc09JZksvNStmbmdz?=
 =?utf-8?B?N1RYOFFsNEh2NjRmalIxV2RiZG8vMDJtano1MmYxRFZTUUJjZStNNWUzY3hY?=
 =?utf-8?B?NGxXZ1RCRGJVM3Y0NkNyY2xZQ3ZmT3MvcHFJaHNmVWZLTWxNMEhqeVE1Qis3?=
 =?utf-8?B?R01wN2NxcVFkUDFneU41WnhRK1ZhODJTczRrekFqSDhBSWY4TU02bUNwRVND?=
 =?utf-8?B?TUNIc2lIQWY4eHZ2SlZrZWpFY081UCtzejVzTG5JV09WUlg5T3hiemhNQTl0?=
 =?utf-8?B?R3U3UmJ0UnNlUVVJNUN1Wkc3d3lyY0pEUUF1MDJQTGxlZ1hEYXdBck12ZE9D?=
 =?utf-8?B?QkZoVnY1bXRpOG1NcFVsSGVLanBwTDJNckxUK0VSUHlQQUdJbXVGSm9wZWpi?=
 =?utf-8?Q?H5Cs=3D?=
X-OriginatorOrg: talpey.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b208d457-cec6-41c6-a257-08da786c7c23
X-MS-Exchange-CrossTenant-AuthSource: SN6PR01MB4445.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2022 12:00:56.6013
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2b2dcae7-2555-4add-bc80-48756da031d5
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nCxxDUhtkQYwWyWCGeC7MxIQi3hOlEGBSLma0XTsrQSg1bb7fdT6S3p8fPH34HuF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR01MB5249
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 8/6/2022 3:49 PM, Trond Myklebust wrote:
> On Sat, 2022-08-06 at 11:03 -0400, Jan Kasiak wrote:
>> Hi Trond,
>>
>> The v4 RFCs do mention protocol design flaws, but don't go into more
>> detail.
>>
>> I was trying to understand those flaws in order to understand how and
>> why v3 was problematic.
>>
>>
> 
> The main issues derive from the fact that NLM is a side band protocol,
> meaning that it has no ability to influence the NFS protocol
> operations. In particular, there is no way to ensure safe ordering of
> locks and I/O. e.g. if your readahead code kicks in while you are
> unlocking the file, then there is nothing that guarantees the page
> reads happened while the lock was in place on the server.
> The same weakness also causes problems for reboots: if your client
> doesn't notice that the server rebooted (and lost your locks) because
> the statd callback mechanism failed, then you're SOL. Your I/O may
> succeed, but can end up causing problems for another client that has
> since grabbed the lock and assumes it now has exclusive access to the
> file.
> 
> NLM also suffers from intrinsic problems of its own such as lack of
> only-once semantics. If you send a blocking LOCK request, and
> subsequently send a CANCEL operation, then who knows whether or not the
> lock or the cancel get processed first by the server? Many servers will
> reply LCK_GRANTED to the CANCEL even if they did not find the lock
> request. Sending an UNLOCK can also cause issues if the lock was
> granted via a blocking lock callback (NLM_GRANTED) since there is no
> ordering between the reply to the NLM_GRANTED and the UNLOCK.
> 
> Finally, as already mentioned, there are multiple issues associated
> with client or server reboot. The NLM mechanism is pretty dependent on
> yet another side band mechanism (STATD) to tell you when this occurs,
> but that mechanism does not work to release the locks held by a client
> if it fails to come back after reboot. Even if the client does come
> back, it might forget to invoke the statd process, or it might use a
> different identifier than it did during the last boot instance (e.g.
> because DHCP allocated a different IP address, or the IP address it not
> unique due to use of NAT, or a hostname was used that is non-unique,
> ...).
> If the server reboots, then it may fail to notify the client of that
> reboot through the callback mechanism. Reasons may include the
> existence of a NAT, failure of the rpcbind/portmapper process on the
> client, firewalls,...

That brought back memories.

http://www.nfsv4bat.org/Documents/ConnectAThon/2006/talpey-cthon06-nsm.pdf

Here's an even older issues list for nlm on Solaris circa 1996.
The portrait-mode slides are in reverse order. :)

http://www.nfsv4bat.org/Documents/ConnectAThon/1996/lockmgr.pdf

The NLM protocol is an antique and hasn't been looked at in well
over a decade (or two!). NLMv4 (circa 1995) widened offsets to
64-bit, which was the last innovation it got. None of the RPC
sideband protocols were ever standardized, btw.

Jan, what are you planning to use it for? Personally I'd advise
against pretty much anything.

Tom.

> 
>> -Jan
>>
>>
>> On Fri, Aug 5, 2022 at 10:27 PM Trond Myklebust
>> <trondmy@hammerspace.com> wrote:
>>>
>>> On Fri, 2022-08-05 at 19:17 -0400, Jan Kasiak wrote:
>>>> Hi,
>>>>
>>>> I was looking at the code for nlmclnt_lock and wanted to ask a
>>>> question about how the Linux kernel client and the NLM 4 protocol
>>>> handle some errors around certain edge cases.
>>>>
>>>> Specifically, I think there is a race condition around two
>>>> threads of
>>>> the same program acquiring a lock, one of the threads being
>>>> interrupted, and the NFS client sending an unlock when none of
>>>> the
>>>> program threads called unlock.
>>>>
>>>> On NFS server machine S:
>>>> there exists an unlocked file F
>>>>
>>>> On NFS client machine C:
>>>> in program P:
>>>> thread 1 tries to lock(F) with fd A
>>>> thread 2 tries to lock(F) with fd B
>>>>
>>>> The Linux client will issue two NLM_LOCK calls with the same svid
>>>> and
>>>> same range, because it uses the program id to map to an svid.
>>>>
>>>> For whatever reason, assume the connection is broken (cable gets
>>>> pulled etc...)
>>>> and `status = nlmclnt_call(cred, req, NLMPROC_LOCK);` fails.
>>>>
>>>> The Linux client will retry the request, but at some point thread
>>>> 1
>>>> receives a signal and nlmclnt_lock breaks out of its loop.
>>>> Because
>>>> the
>>>> Linux client request failed, it will fall through and go to the
>>>> out_unlock label, where it will want to send an unlock request.
>>>>
>>>> Assume that at some point the connection is reestablished.
>>>>
>>>> The Linux kernel client now has two outstanding lock requests to
>>>> send
>>>> to the remote server: one for a lock that thread 2 is still
>>>> trying to
>>>> acquire, and one for an unlock of thread 1 that failed and was
>>>> interrupted.
>>>>
>>>> I'm worried that the Linux client may first send the lock
>>>> request,
>>>> and
>>>> tell thread 2 that it acquired the lock, and then send an unlock
>>>> request from the cancelled thread 1 request.
>>>>
>>>> The server will successfully process both requests, because the
>>>> svid
>>>> is the same for both, and the true server side state will be that
>>>> the
>>>> file is unlocked.
>>>>
>>>> One can talk about the wisdom of using multiple threads to
>>>> acquire
>>>> the
>>>> same file lock, but this behavior is weird, because none of the
>>>> threads called unlock.
>>>>
>>>> I have experimented with reproducing this, but have not been
>>>> successful in triggering this ordering of events.
>>>>
>>>> I've also looked at the code of in clntproc.c and I don't see a
>>>> spot
>>>> where outstanding failed lock/unlock requests are checked while
>>>> processing lock requests?
>>>>
>>>> Thanks,
>>>> -Jan
>>>
>>> Nobody here is likely to want to waste much time trying to 'fix'
>>> the
>>> NLM locking protocol. The protocol itself is known to be extremely
>>> fragile, and the endemic problems constitute some of the main
>>> motivations for the development of the NFSv4 protocol
>>> (See https://datatracker.ietf.org/doc/html/rfc2624#section-8
>>> and https://datatracker.ietf.org/doc/html/rfc7530#section-9).
>>>
>>> If you need more reliable support for POSIX locks beyond what
>>> exists
>>> today for NLM, then please consider NFSv4.
>>>
>>> --
>>> Trond Myklebust
>>> Linux NFS client maintainer, Hammerspace
>>> trond.myklebust@hammerspace.com
>>>
>>>
> 
