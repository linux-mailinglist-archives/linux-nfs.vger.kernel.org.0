Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55D7D5F321A
	for <lists+linux-nfs@lfdr.de>; Mon,  3 Oct 2022 16:44:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbiJCOoK (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 3 Oct 2022 10:44:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbiJCOoJ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 3 Oct 2022 10:44:09 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2071.outbound.protection.outlook.com [40.107.223.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5A5627DF5
        for <linux-nfs@vger.kernel.org>; Mon,  3 Oct 2022 07:44:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ObARS36AV2rd86oycWEyMHj3T5UWp/YOZZYFjtfbfeeUdLPVTYyPgJBaYRBXdjS3NM1AdMfi+6DBJhYBbn6pBg5rqA9XcsSh/mcNG0+u6WuQcUgQoLvDi2XAxobhm6EzfK46dXxHazQsJCtf3oi7m3e5A1uma7/ry3MUv9kp3F7qB3zdNeA0FYA18QqpdZvxNMyAD0cbDdJAWo2L3UzUbebAL3kNgG67qOSfTkvZ2mzk9lYgI4FJChHJ0bGx0mz7NRQSrYQE8m4Bsnr8cmtNw2jmdb4N5bZY1AOUMmYCk9wryaZBTHCwX+40VXFOkZ5DdTfbPAc81xkhP2pkBYQ6Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yfwHGg89F9PkqcL8I4cFuQd6nuBtAk9F4iqQwarTePE=;
 b=OMwiE3J5CKiJd071++qYvRkwW1eVQSp6qouwi79hbEav5x1xHJrxgLM4nTgX+NP1ZruqqZU9esBlnoBZgXGDGMqqL98QoALTEhHeJxw95078P9/ak5hcA7Ri2dUFATyhrKWhZXW6Qx/YF2EPu/UGcnOQbeCCtYXx0IhVpoW0dXg7yJYfU9A5ZeSC+/MQONwpaVkN7TPeL0v2wUH/YVo7wG8lzqXopuYtlcQDHNHkXxuowxgaBJdlQoXvPVFEu9F2kRsqYEq4ntLt4ytlF5oniBmFB8kuhy2VuwIxc4/YH9pOC7odhWttYBcxT8DZefU3EQ7796BSjm90249bSxAT/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=talpey.com; dmarc=pass action=none header.from=talpey.com;
 dkim=pass header.d=talpey.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=talpey.com;
Received: from SN6PR01MB4445.prod.exchangelabs.com (2603:10b6:805:e2::33) by
 BL0PR01MB4980.prod.exchangelabs.com (2603:10b6:208:6c::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5676.23; Mon, 3 Oct 2022 14:44:05 +0000
Received: from SN6PR01MB4445.prod.exchangelabs.com
 ([fe80::454c:df56:b524:13ef]) by SN6PR01MB4445.prod.exchangelabs.com
 ([fe80::454c:df56:b524:13ef%5]) with mapi id 15.20.5676.028; Mon, 3 Oct 2022
 14:44:05 +0000
Message-ID: <4be6f388-9fa0-a54a-8c78-8f1761284e35@talpey.com>
Date:   Mon, 3 Oct 2022 10:44:03 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: nfs4.1+: workaround for defunct clientaddr?
Content-Language: en-US
To:     Manfred Schwarb <manfred99@gmx.ch>,
        Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org
References: <39bf58c7-47d9-744b-6d26-d672aa713024@gmx.ch>
 <8cd63730f7b5f3e2aa3bde98587de0c6a42b384b.camel@kernel.org>
 <8550c032-2ef8-4ddb-19a0-307777bd9645@gmx.ch>
 <c163b299164cd9abe21325a947c9efe908a04331.camel@kernel.org>
 <e3842fe7-da95-98e2-b0e8-fa3aede673cc@gmx.ch>
From:   Tom Talpey <tom@talpey.com>
In-Reply-To: <e3842fe7-da95-98e2-b0e8-fa3aede673cc@gmx.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR20CA0022.namprd20.prod.outlook.com
 (2603:10b6:208:e8::35) To SN6PR01MB4445.prod.exchangelabs.com
 (2603:10b6:805:e2::33)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR01MB4445:EE_|BL0PR01MB4980:EE_
X-MS-Office365-Filtering-Correlation-Id: b8472dcb-d3f6-4e69-a5cd-08daa54db87a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uEmkitSnk5JcVkj8C5XzNE0AAzxk88cMen4clPXRXcPXMTjvUyjlsbXenKaQ4Bmg7D8CtDWoFUXRSGLG8GwrL3BQeCSIYFxf9/2su0ZVXIkRAtpDs7LJLPCKJoIv7zW1F8CNBFv1t42J1X8eGvvCA5ToMAL2R+032mLy0upKRehjiH97JCgRw5kdOSYIg6cCWunbDVbsGvj3Ur36D1+Div90U0KgSr6eSPNADMFl5qElQ5BhQwdInVlQ0P8htokCJqN58DhAh5+046hhIquJLATvG+r5cdw2dilzQ//blOMnm/8FOUMKEv5EcluykI44m+OAB9yspSE1bvZU59A/6gap72jlCMOJW8PY0qR9e4zY3FNcL4CFXdk3r3XtZx20KzQz5DDcqiGxtH1Cg3D9GCLHOPfv+X/WtvKIAgcWDwhdwrfP06O+GjzT7F2pEPOUbg1vNKeuT3rayBzf64gA14+uYGRiILLJcV0lOfMX1h3HY4G1aeRa6ro1Dcpp91hscxL5K1vpZngEx6hCyrlcnz9TqKNwKZrTm40plqH9MO/lzx62bBVkyQ5tJed3IhdEzS70oQt+iBRtUfSrOKdRrT/L9/kXA2ea6Wl0sPNcJUmxZXXsU4aPhtpHoLbHq0lHuxqnDIgVZefITCQsPZHkEQ0LnS7LZvAXAxz3PLkxBRQy1Q7iBdRSVFayouN5fhjTWPpNTafXIl/69l/aN4Xedvp76hg5ThGHTqUwkDuDsiQ0LVMDJg2yZXqIdSgV0lqgpiYC84L7LZ/j0MUMv4Zxz2s/Cm/+b8vPjabC1KPVxYE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR01MB4445.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230022)(39830400003)(366004)(136003)(376002)(396003)(346002)(451199015)(41300700001)(8676002)(66476007)(316002)(53546011)(52116002)(26005)(6506007)(6512007)(110136005)(6486002)(478600001)(66946007)(66556008)(36756003)(83380400001)(86362001)(31696002)(186003)(2616005)(38100700002)(38350700002)(2906002)(31686004)(5660300002)(8936002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dGh3MExQQ3RKNDRGSkx5dHE1NDZzN1QweDZGV3ZOczJ1QzF6cXlXMkR6WWlm?=
 =?utf-8?B?TmZzTzJWZ29NRDBBMVB2bDBYYjhUQmtIN21wR3ZiaFowaTZxbEpkdlF0TkNC?=
 =?utf-8?B?M0NZTWc0bVdrRkVrRXBvN2JNaWk3TDNMYVlOdk92UWR0VFh2MFFrSEsvSTZI?=
 =?utf-8?B?alNYQTJMVWhnNURLeG84RGdOUDRXdC9yVml5VnJYZmFaVDJ0Mm84ZlRaRjR0?=
 =?utf-8?B?UllEUkFMQSs0NHUvQjE1RXJSSjZYSm54S2lXZzNYY2RVS2tudW9BUjlOUjBP?=
 =?utf-8?B?SW4reko2WU5kV3BwMWZTc2xWLzl3MDhYMGdaaUlRTkhSVURsb0xvS1JZd3N4?=
 =?utf-8?B?NTlTSisvYXFwR0puUCtVbit3bUdQWHNJbTRXOXBZRVdJc2tsaDRMVG5uSWov?=
 =?utf-8?B?eW1USVRmZmlaclVybEYvNzlLSzVqeDNvQnEyWTN2RC9rRURhZHB3eVQ0M29U?=
 =?utf-8?B?Rk14QVRxSVR0MWhGczFLcGpvVDliTXhTU3k4YVU5NHRMUVRuLyt4VngvcXl6?=
 =?utf-8?B?L2NZNDlvTVpqdHdTQTZwUUxBWmN6WTA4VUtQemtzRnVrNXlkNEt6Tk94dWND?=
 =?utf-8?B?Z0YrZjRIWXhUK2c5RWlXNUQraXAvVHZ3anVKa2dCNnFWZEYwTG9NOXRabXhK?=
 =?utf-8?B?aGlLdVg1R3c2dnlETGt3K3pVQTZDM3RJMlFWTElFMmc5anl0aDc2UER3OWd5?=
 =?utf-8?B?cCt3OG9uUHJrdFJpRXpVeFVyWGJQQ1ZBYUxwcVQ2Mlcyb2IwLzdMRE90T2kv?=
 =?utf-8?B?UXV5KytRZFVsMWVGNWJHaHN2Zk0xeThqK2E2RVM3WGZxYi9DL2ZoQ1d1SVdi?=
 =?utf-8?B?SjRpVCsxeGpvVnJacTBGbk1iQ0lGYUZuVFhteWVVMGxpYTBScnRzSWdyVmNU?=
 =?utf-8?B?RTJncTFSRGRnM0VGMStKK2JDek9Bd2VSM3dtOU5SL1E2NWtZZUpBNmhyc1Nn?=
 =?utf-8?B?NzlxOVFQK3Yxem9yYngzeG9JcFhzTTE0Wk1hb1ZCUUVOM3FUcGVkek56Y1NR?=
 =?utf-8?B?MzFzQXpPenZCSUhIcnZjTDVxb3VTYS9JNGxMVDVQMVdoRlBvamlySnViVDJM?=
 =?utf-8?B?NE1qWkgreW5jVkhBSTJrSVhOekQyRGZTYTcvUDN5eTR5aWlJaWY4RzZSeXp3?=
 =?utf-8?B?TEQ2bHpVVnJHNTJwQVNqcXkxVTV5ME9zdTZ1alJBRHhJNCsvaVhydFJLcXc2?=
 =?utf-8?B?S3ZqSzFna3dQMlhqV0dxQWhMOEp1L1RYOWdLVWN1eGFaaE15cm51QncyK0pk?=
 =?utf-8?B?TzB2b0tWbjhHOXczZ1duMzFzRlhwZ201RzFMbTltcW4ySHVVQ0tIWmZGUWdn?=
 =?utf-8?B?dTlGS1BwM2VaRHAveWM1cE42U0VQNDN2U0I4bnRjeHFYWG1NRkFSbFdrTTlu?=
 =?utf-8?B?d0lYTlR5YjA1OVVlYkhhSTFKeGozNTVGRytvL3FpZlloUGNsU2ZqYkVURU1K?=
 =?utf-8?B?dEZBVVVEbjBOcDFzQ2VDREhaMFlJeDdzeEVnU2pQT1JjZDJsY3NoMi9ObEdI?=
 =?utf-8?B?alRGejdrODk0eEo2RGRKOFhFaFgwTUdnTjgyb3VxUC9lelp5aDltc2g2bGkz?=
 =?utf-8?B?MEhwdUxFZDFSNmp3QmRIK1lTa3lRQW4wMlhhZitkb3Zra1o3dm5nRWlwMGE4?=
 =?utf-8?B?UDMvUy8vbjYraERDWDJBcTVydGkrVUUwcHc1RWUwZkF3ajVWekUvN3ZjYUxZ?=
 =?utf-8?B?b3djTTUveGJtM2QzT09WSlhmWlJ6ajBpVlhVdVJDMXRmaDdka0FXdlpoRU1C?=
 =?utf-8?B?Nm9XcW5KUnh5RmVOVEVTN29DRlo1TkdyTGtNUUdtc3hjYUVpNDlSRVFXUkU4?=
 =?utf-8?B?U0pqUmJ0Qy8xS3gvRUFVOFpFWktDWnpIWndkcG1mcTFoa1ZJUXRST0tvMmM1?=
 =?utf-8?B?eGRRZkNWMEI2aGRNWmhuSGdNUE1DRlRqVEtLa0hwa0s2am5KYkE2VnNWL3hq?=
 =?utf-8?B?VWRIbXQxL0lJSkNGaFp4YnBMQlI1YjgyZ01lMERDa0QzM0RnZVpSclVZaVBU?=
 =?utf-8?B?eU81VnZqaVpqNklQeVNQSk5HVjRtanhJSDhkbHJXMEx1eVptNEtuNkhySHd6?=
 =?utf-8?B?S2cxejBwS2NSZ21abmtQYWc4YThOTGpOdnBiU29jc0QwL0p1bGxqY3EwRU1W?=
 =?utf-8?Q?TAc93vgOA/IUS1Ohs+f61cfPu?=
X-OriginatorOrg: talpey.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8472dcb-d3f6-4e69-a5cd-08daa54db87a
X-MS-Exchange-CrossTenant-AuthSource: SN6PR01MB4445.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2022 14:44:05.3706
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2b2dcae7-2555-4add-bc80-48756da031d5
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cLGgzkxSO+rZcqLGWsT/p7wa1pc55+j7CGgBs7sw4NeLvx3T580+IUvt4RROcDWq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR01MB4980
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 10/3/2022 9:24 AM, Manfred Schwarb wrote:
> Am 03.10.22 um 14:26 schrieb Jeff Layton:
>> On Mon, 2022-10-03 at 13:55 +0200, Manfred Schwarb wrote:
>>> Am 03.10.22 um 13:39 schrieb Jeff Layton:
>>>> On Sun, 2022-10-02 at 14:35 +0200, Manfred Schwarb wrote:
>>>>> Hi,
>>>>>
>>>>> I have 2 boxes connected with 2 network cards each, one
>>>>> crossover connection and one connection via LAN.
>>>>> I want to use the crossover connection for backup,
>>>>> so I want to be able to select exactly this wire when
>>>>> doing my NFS backup transfers. Everything interconnected via NFS4.1
>>>>> and automount.
>>>>>
>>>>> Now the thing is, if there is an already existing connection
>>>>> via LAN, I am not able to select the crossover connection,
>>>>> there is some session reuse against my will.
>>>>>
>>>>> automount config:
>>>>> /net/192.168.99.1  -fstype=nfs4,nfsvers=4,minorversion=1,clientaddr=192.168.99.100   /  192.168.99.1:/
>>>>> /net2/192.168.98.1 -fstype=nfs4,nfsvers=4,minorversion=1,clientaddr=192.168.98.100   /  192.168.98.1:/
>>>>>
>>>>> mount -l:
>>>>> 192.168.99.1:/data on /net/192.168.99.1/data type nfs4 (...,clientaddr=192.168.99.100,addr=192.168.99.1)
>>>>> 192.168.99.1:/data on /net2/192.168.98.1/data type nfs4 (...,clientaddr=192.168.99.100,addr=192.168.99.1)
>>>>>
>>>>> As you see, both connections are on "192.168.99.1:/data", and the backup runs
>>>>> over the same wire as all user communication, which is not desired.
>>>>> This even happens if I explicitly set some clientaddr= option.
>>>>>
>>>>> Now I found two workarounds:
>>>>> - downgrade to NFS 4.0, clientaddr seems to work with it
>>>>> - choose different NFS versions, i.e. one connection with
>>>>>    minorversion=1 and the other with minorversion=2
>>>>>
>>>>> Both possibilities seem a bit lame to me.
>>>>> Are there some other (recommended) variants which do what I want?
>>>>>
>>>>> It seems different minor versions result in different "nfs4_unique_id" values,
>>>>> and therefore no session sharing occurs. But why do different network
>>>>> interfaces (via explicitly set clientaddr= by user) not result in different
>>>>> "nfs4_unique_id" values?
>>>>>
>>>>> Thanks for any comments and advice,
>>>>> Manfred
>>>>
>>>> That sounds like a bug. We probably need to compare the clientaddr
>>>> values in nfs_compare_super or nfs_compare_mount_options so that it
>>>> doesn't match if the clientaddrs are different.
>>>>
>>
>>
>> Actually, I take it back, clientaddr is specifically advertised as being
>> for NFSv4.0 only. The workaround for you is "nosharecache", which will
>> force the mount under /net2 to get a new superblock altogether.
> 
> But clientaddr is silently accepted on NFS4.1+, and seemingly silently does nothing.
> 
> The point is, RFC5661 explicitely tells
> "NFS minor version 1 is deemed superior to NFS minor version 0 with no loss of functionality".

NFSv4.1 doesn't have a clientaddr in the protocol, only 4.0.

I believe the reason that the clientaddr option is accepted by mount is
to handle multi-protocol negotiate. If the admin requests "any NFSv4"
and provides an explicit clientaddr, it is only needed when falling
all the way down to 4.0, but ignoring it would be incorrect. So perhaps
the mount command could use a tweak.

> So this behavior comes as a surprise.

Well, it wouldn't have been an issue if the missing comparison bug that
Jeff mentions was fixed... I think that's the real issue.

Tom.


>>>> As a workaround, you can probably mount the second mount with
>>>> -o nosharecache and get what you want.
>>>
>>> Indeed, nosharecache works. But the man page has some scary words for it:
>>>    "This is considered a data risk".
>>>
>>
>> Yeah, it does sound scary but it's not a huge issue unless you're doing
>> I/O to the same files at the same time via both mounts. With
>> "sharecache" (the default) you get better cache coherency in that
>> situation since the inode and its pagecache are the same.
>>
> 
> So I guess this is equivalent to the minorversion=1/minorversion=2 trick
> cache coherency wise then?
> 
> 
>> With "nosharecache" you need to be more careful to flush caches, etc. if
>> you are doing reads and writes to the same files via different paths. If
>> you need careful coordination there, then you probably want to use file
>> locking.
> 
> Thanks for these explanations, it is appreciated!
> Manfred
> 
>> --
>> Jeff Layton <jlayton@kernel.org>
> 
> 
