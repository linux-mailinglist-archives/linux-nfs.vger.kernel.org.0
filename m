Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D632493480
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Jan 2022 06:28:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349597AbiASF2x (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 19 Jan 2022 00:28:53 -0500
Received: from mail-db8eur05on2094.outbound.protection.outlook.com ([40.107.20.94]:23137
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1349252AbiASF2w (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 19 Jan 2022 00:28:52 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D8e3hplr7O3y0ryZmXh26O9xbEyV/6RwMGPRsQWIk5jRboOtSxlmOWw6WDNlzEmNaMXs8UqEYMOsFTOYtru4W2D3CrZjRZFiIiYSXLosEc5pSNWmpjwA8yYVF5GAoRozxGZcv1owtDEW3A9wImELIqScNhMF1xeqT2fgqSHiwmdmkf5HR8AZF7/LisaUTmDUB6GNDP61ooFk+v/g6pH9iTXUYpFvSY0NAbaWfpO88A2LBfHLRUeo3jgDHm8b6EOX+p/THfSWuA/QF+7VzqZSoKRGaq8cSC2At5OQdXU6KkEZrrH6zsR1YToMawVpoebRwWUc7ORRlGyD0mOYPx97JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0xUP4iU58OVhGyo4dVNhbTVtD5PC9AD3jn13C6PpaWs=;
 b=meiUpWCtHHGFfRrmM/0CDlcfKiu5Em03qELc1uN1kD7TnX+DBFpaKnnHc5pgO/PUMZLwYMIwjdZjEZOOI0kgR0ikbmnHNyZM6VUdKW2hMNv3O4iYTwp7nuyIOrBGpFvCIYHWc1kDcFLRvnViPucasAlpZ3XFJcBn2ucrmg3PYhVbvXJyL4Uq7k+Tdq5IGCqOIT7cCFJ4uzbYQuFU5YQZquylBX9fxu9MpdNLZOlzov+nvahwR0y2LNPIFQCNn+tLOD6+DKTGBZRJj7gx70yAyVdIFgfzxRiCgwqGwGT/G3FMFQPn1cUcIyu4AtKL8tHauc7MSmAx5tTP9utXqvwM2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0xUP4iU58OVhGyo4dVNhbTVtD5PC9AD3jn13C6PpaWs=;
 b=ZNE+vwAJk41R9Klq4dgTrXL1pk8w4x90pCHd6WxyvnDslEdyb8HLHyOesnSTxTSNKXg1xVKeZKJk4fO+qRxFiSMi4tb5gIuILQnMDVbMU6RMuOZHhAc5vQXa2Z+1Fb/yOm0ekRjNZyWOfUvBc7Ss11mAyBTIGagVex8Qc5DKxfY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VE1PR08MB5630.eurprd08.prod.outlook.com (2603:10a6:800:1ae::7)
 by VI1PR08MB3934.eurprd08.prod.outlook.com (2603:10a6:803:df::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.11; Wed, 19 Jan
 2022 05:28:50 +0000
Received: from VE1PR08MB5630.eurprd08.prod.outlook.com
 ([fe80::3c60:bb4b:b0eb:669d]) by VE1PR08MB5630.eurprd08.prod.outlook.com
 ([fe80::3c60:bb4b:b0eb:669d%3]) with mapi id 15.20.4888.014; Wed, 19 Jan 2022
 05:28:50 +0000
Message-ID: <30d1626f-b2f3-b1f4-2e85-5ee5b78926f9@virtuozzo.com>
Date:   Wed, 19 Jan 2022 08:28:47 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: LTP nfslock01 test failing on NFS v3 (lockd: cannot monitor
 10.0.0.2)
Content-Language: en-US
From:   Nikita Yushchenko <nikita.yushchenko@virtuozzo.com>
To:     NeilBrown <neilb@suse.de>, Petr Vorel <pvorel@suse.cz>
Cc:     linux-nfs@vger.kernel.org,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve Dickson <SteveD@redhat.com>, ltp@lists.linux.it,
        kernel@openvz.org
References: <YebcNQg0u5cU1QyQ@pevik>
 <164254391708.24166.6930987548904227011@noble.neil.brown.name>
 <3cb5de6e-6f8f-e46a-96bd-a3d88a871f3a@virtuozzo.com>
 <28b078ad-d69a-4ad7-f2a9-334150a97d18@virtuozzo.com>
In-Reply-To: <28b078ad-d69a-4ad7-f2a9-334150a97d18@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM6PR01CA0048.eurprd01.prod.exchangelabs.com
 (2603:10a6:20b:e0::25) To VE1PR08MB5630.eurprd08.prod.outlook.com
 (2603:10a6:800:1ae::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 39bf705f-ad3d-488e-0d6a-08d9db0c92c8
X-MS-TrafficTypeDiagnostic: VI1PR08MB3934:EE_
X-Microsoft-Antispam-PRVS: <VI1PR08MB39348A7521D794E285607F8CF4599@VI1PR08MB3934.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UxHuHg+bXnDioFsGytaf8PD5dv6Nsag0rxMfH3n3JWYaHYrnKplGBz+AAV2i1r9oNvbegHttUMQIVrW+jglKNvE6LwLknMMovnZTyh0HGVkm9OUWz62BXkl6B2TJfsfCVvYlE/uzdS/4lBax57/J1BdZ8CpotM0vwQH2s9H5ib/Z4h0StAZPOp1LHfjmytZP7a1fhHaEiVJteC80jCxBqZ/B8cA4i8TZYIr5fGX2bC7XBSpMOAZgRtogcdGkcFkPwG0U7OmijwdT2TwNZGvXlSdpltCtPncvrRaCYRe+aTYg6HkHnSl1nDe689ODYIcLBGUgY1WXDexQNZ5CfmnQXm3S0ZJpfSKteYdUGpsO4GWHFyarvrxz1z19Kmudu4cRa/HHKAKL3FKfyFEergB1jzBikNGRklIV94gdXxtWYGam853sFm3Dmv7WTM0+vpl3TAhVJqAVCsb+t9zMw0VcOTSxkokA9RYyEx67M4a8PWHe/xL6p+FtYvgMjiynKRSomzMq0z0Zude2VkMBuE1w72Qdq89LJDXUb74kwJxN3dL6jqy1yHT+Le/vte1UmbmPfDbyRc29ZyoFUjmWkruQpo4vAxQIQBY2bDDewBHX7wjegUJy8Epy+WyAO1R+p0/9dvtGJJk2lQSq4Prlu0m/GARyFhHZqK0UX3kIQUCH8eqI0pfWjjOueP3lq0q1qe/wRkxNejOVxxZjBJUxU828uzzC3ZDRbGQUW/mFIVlKv2SxHuwO8mhtbgcb+D768vmz
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB5630.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(2616005)(44832011)(6506007)(4326008)(8936002)(107886003)(66556008)(31696002)(26005)(36756003)(86362001)(38100700002)(66946007)(508600001)(66476007)(316002)(186003)(6512007)(54906003)(110136005)(6666004)(6486002)(31686004)(8676002)(2906002)(5660300002)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eENiRXFTenFTeHNORXBsTGRCTVVBNHMvdTdHNkN5dUF5UEZBMERTSmJ5R1Zv?=
 =?utf-8?B?aEVxcUZQcHpaaFFzZGVWSjlHdmhVZGRnMXhaOVZJV1FDVVN6YW5sTjNlV1B1?=
 =?utf-8?B?Z1BnZVNVV1kzM3duK3JZU0FJSEd1cnd5VitZditzVnhlOTd3M3dJYlRpbXVU?=
 =?utf-8?B?U2c2SzUvMW9vdVR2TWgrbEkzc0Nqci84U0tPeUZ2MWN4aFdwR0M4bm9KY2Fn?=
 =?utf-8?B?cThrZHd3em50N2J0NHo1Q0szdVBUK3VUSk5TVlJ0aGROdUNCM1YzcXJIbU15?=
 =?utf-8?B?L2NyOFY5YW1CdittYXNtaGRSNDV3SFFsOVBGaFNpeUFRVlpFWmp4RVI5UTAr?=
 =?utf-8?B?Qjl1UkZCbTJ2eXh1TG4rRWRmajNlNitVNllSTzJ4VnZ0VnBvMDVTMVlVcGFO?=
 =?utf-8?B?azlhUmZqODVyamdDcXA5eWo3Y1pJYUxQS1ArTlR5czErNzQrVWpOSVhGZzZI?=
 =?utf-8?B?WE5zOEt3ekVDMDlzZG83ODRDQ1pEcnFicm41aEtlTTdwSW43cHJ4cTZyRUR5?=
 =?utf-8?B?Q3lqUURsTnRYU0ZhU1Q2bWdZR1hRdXY0SWQ0T2E0MXpRSCtBTDQ1WHBQWHJO?=
 =?utf-8?B?cldkd0EvZFBsRmI3VHdHSHlWdEc3TUdESGYvL1Q0M0ZwVC9DMkdGa0IybUFP?=
 =?utf-8?B?TGJhR0VYbnB3SGUxa1FIalVBbDU2bzA3RU9HSGkvSVk2NVZLcWV0M2RDNUhy?=
 =?utf-8?B?Q0g0V05YekJhWkY4QzFTR3ozY1BLbXpibWIwQkNGRWs5TkwyNTdrYSt3TGt3?=
 =?utf-8?B?TXRraCtENFdTUjBBTE8zMmYrNDVXZ1gzblo5TW81czRjSmJiWGlENDVhVUp0?=
 =?utf-8?B?YWhCRzRlOVY0alRoUVViYmIza215OFNobUZnd05JYVFuUDJDSEwraHRBemtj?=
 =?utf-8?B?OU5RNW9MdnZUN1VRaDZSd1l3M25ZWDJTUEdQTEdCRStyUmxSZENPN3lpZHh1?=
 =?utf-8?B?MW1mTXdIRnAwaVpLYlVOaE5CeUtWdExwY09YU1A3MkVBNXJBek1RNUpEMGxM?=
 =?utf-8?B?TkhDUXZBRXRkUFZ0R2FkcDRkZjI3RGVrb3c3MnhMdzhma25vYlQwQ2U2aGpF?=
 =?utf-8?B?d1crdE05bFRHUWs3Sks2UlI5RnhpVmVLV1d2NWVZNHFvK05nclBGcUlNWDY0?=
 =?utf-8?B?RnRDT1MzTVJMTEh5dm5HbTg0VmVWZ3gva3g3S3gwU3o0cVRaMkV4MDRaMXI0?=
 =?utf-8?B?NHdMMFRmeWhmZTB4OEJhS2RDVllIMDUyRlRyQ0tjdEJSUWN4VEVHMUo1ekds?=
 =?utf-8?B?bEtGN1V0aFp5eHk1R3J2S3RIek1DcXdjMmFYdWVxRzZYMnFWZmVuSGkweUxW?=
 =?utf-8?B?V0lNWVVWbnkveC9CK3BMMGtmb0Q3NSt3ZXBYK0VXSGJtNmNEL1dPS3JRYWJI?=
 =?utf-8?B?UUJFNG9mZzNEbzVhNnJPeEJyZENpZVRtQ2lxNVNrcitHWlZpMytIamVBL3hF?=
 =?utf-8?B?eXdnRUZnOG1IUm44WmJ2UXc4eW9FZ0U0eXRUNFdpejRxdnAxQjhuOWR6L085?=
 =?utf-8?B?Ukdxc2tmY3E1a1VidmxZSktoTVNweFFoUVBPSEtLRmtjRjBaWDk3OGtpRE9T?=
 =?utf-8?B?VkJUeFMyWGtMbmhyQ2tKckFPZmUydnpseVYxaEZtM3MrTzlHS21LTzd5cGVD?=
 =?utf-8?B?MWwzK2hMc0tmUlNSMXdDY0dpdTNSTHNwdGFuL1FJZjVQeCs4bzJDcjEvS3Ay?=
 =?utf-8?B?TzB4R0tBVzlrSE92b1hIK3NBR1pSdk9NRU9XdkdJUGE1OHNpZ2tDNng1NkQr?=
 =?utf-8?B?Z0xtbklEOTBpeWhiU0xjaERJSkU1Zy96VXRQazhsODF1TlB4ejFMNUpNR3RH?=
 =?utf-8?B?N3BJMU1VK3g4U252dk5KMUdnV2ZwNW0vV29ZK1RiSmNFeU9ZS2V2ZHQzVGpz?=
 =?utf-8?B?Q2NRSlZGSFhQQW5hd2hGN1BWenFaeUUwRHM5MXRVZVE1RFdwRFdMMmxZK1Zp?=
 =?utf-8?B?OVFQeDMwZHRuME9kckZoOFJ2d1lpc201bkJhUjFFblUxOU9TVXJnQWJnQkhV?=
 =?utf-8?B?TVZxUTJ5MWZORUJGTzZlVC9wdm9hbC9YbjM0SEJrZFBSVHBSMVljcDFsYVZz?=
 =?utf-8?B?WHRoMzR3eXdzS2dEQkYwN2NNMXNlcHlhbmhXQ0ZSZ3dRYzBuRmZROUhxajI1?=
 =?utf-8?B?OVh1Y081bW03emhmZXBxRGpKRHo4U3JXZ2VsWFNkUTNjZnVxL1VLNmtIT0hw?=
 =?utf-8?B?b3RpampFalVrVjgzdEpMeHBiMHVWSG9iYTFoTUovTEVwR3oycVBMQkg0Qktj?=
 =?utf-8?Q?r8mZYB/d4qayqq/7AIhR11ReroCkDI5TsAIs6mkQkQ=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39bf705f-ad3d-488e-0d6a-08d9db0c92c8
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB5630.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2022 05:28:49.9247
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ndJXOrmb49kpV6CUoIb8utEtO8QF3VCooOiiBSkwFjXQaSHgi6XiLG5lpCMizKUJtnaiHYruipPF9AONOmk2qCLRW3oy6ESNdda6+EiaNHA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3934
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

19.01.2022 08:26, Nikita Yushchenko wrote:
>> Big picture is - lockd tries to be per-netns, but lockd isn't standalone, it depends on rpcbind, and 
>> rpcbind isn't guaranteed to be per-netns.
>>
>> One can argue that it is not kernel's job to provide per-netns rpcbind.
>>
>> Still, the current situation is - by default, doing an nfs mount from within netns B immediately 
>> breaks lockd serving nfs mounts exported from different netns A. "By default" = "as long as nfsmount 
>> process executed in netns B is also in a different mount namespace that has RPCBIND_SOCK_PATHNAME not 
>> pointing to AF_UNIX socket instance owned by rpcbind serving netns A.
>>
>> Although in LTP's 'nfslock01' test the "non working locking" is reproduced on the same mount that 
>> triggered the breakage, the breakage is not limited to that mount. Since that mount operation in netns 
>> B, any client of nfs exports from netns A will get locking broken - including clients running on 
>> different physical hosts.
>>
>> I'd say that using AF_UNIX connection from lockd to rpcbind does not play well with per-netns lockd.
>>
>> Solution to use AF_UNIX connection to rpcbind only for lockd serving root netns, and using AF_INET 
>> otherwise - looks more sane.
> 
> Btw, not sure (did not test) what will happen if nfs server will be similarly started in netns B.  Will 
> it hijack requests addressed to nfs server running in netns A?

No it won't "hijack"...  because in will still listen inside netns B only.  But, if ports in rpcbind get 
overwritten in the similar manner, nfs server running in netns A will become no longer reachable.
