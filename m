Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C403549347E
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Jan 2022 06:27:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351525AbiASF00 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 19 Jan 2022 00:26:26 -0500
Received: from mail-eopbgr80098.outbound.protection.outlook.com ([40.107.8.98]:42685
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1351085AbiASF0X (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 19 Jan 2022 00:26:23 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U0g3sBQzJdW4wc2e22dbwu94aZr6J2ZFXFvcloncuetXJVFt8OCqN2Y1p72EI7CnstCSgfI1DYlFr8yji81XSxA/G28k4mCCI6eDvepzp/xBisWieiqXCRg2ifxn7WTp9FzElG2PAKNhHr6i7Tpnyjv5VqnHSmw1a9elhN9ubsstbLMhUdaYtpreRGi0InHlA4WI+rs4SlPtegSBghJ60vZdNSvmSEqYxfm5d3tlVpCdXkpgG9uXKV0JZHzP+/CNL5cAXDMqz5Aa0+HZGAvGwFiX/cPgBtI3o6CWFBRIl/rigWNgJg/cyKDymu1MGpDnDPwXnuEK1PZ9ohf+utQY8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EQm0jeVZDX4NhIhH/cw/fVyDzICpR/CpddmLtK+QgDg=;
 b=ed3j7cPvSWwMngsie1vceCWsfl3HAvZnT/kzLA1SeFP9Q+1VD72Kej3EhOvYDna5aP8w9Sq+v0990umAa7RpIWRrNzs3zJHGE12RxobhBsAt5VmzhtoeVLnNIqAKb+r8Gq9iHzXuNzeMPCZpc0I5+7NcmZ9TPIlIChlgJnXFubccczSrj+KLMyRu0fMsFhpnFX7qmvEjYg9a0MisCD1hXxA//yc8dsyP4r1EY19zn/l+xp9wd/Aih9jw0+ZBs2A64M+THMxhzw4C9nrvVcMl1cyXxhTdOaTKXVXYBLMg+fzFdTZ19FW9ktn3oyb5YDUQ50Yh4Vlp1So83vU30Dn8zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EQm0jeVZDX4NhIhH/cw/fVyDzICpR/CpddmLtK+QgDg=;
 b=gdIbwEafaASaT5ZngugWEZE8aPnsFSIiSS+6Tp46Cwzb5WNcnjRv9myVDTBaEs1M+hbAdFxKoMZ+ubP6PXb+F6/fe59C1Rmt2pvG13bBHlb+OBX8kJdaS4JpG2p5394Gf4aCsPMIt4rXQfeEDDC3Z1YYE1a/6JsFhlGVQ4qmTeQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VE1PR08MB5630.eurprd08.prod.outlook.com (2603:10a6:800:1ae::7)
 by VI1PR08MB3597.eurprd08.prod.outlook.com (2603:10a6:803:84::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.11; Wed, 19 Jan
 2022 05:26:19 +0000
Received: from VE1PR08MB5630.eurprd08.prod.outlook.com
 ([fe80::3c60:bb4b:b0eb:669d]) by VE1PR08MB5630.eurprd08.prod.outlook.com
 ([fe80::3c60:bb4b:b0eb:669d%3]) with mapi id 15.20.4888.014; Wed, 19 Jan 2022
 05:26:19 +0000
Message-ID: <28b078ad-d69a-4ad7-f2a9-334150a97d18@virtuozzo.com>
Date:   Wed, 19 Jan 2022 08:26:16 +0300
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
In-Reply-To: <3cb5de6e-6f8f-e46a-96bd-a3d88a871f3a@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM6P195CA0022.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:209:81::35) To VE1PR08MB5630.eurprd08.prod.outlook.com
 (2603:10a6:800:1ae::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: acaf4962-2ffc-4a05-95c7-08d9db0c3915
X-MS-TrafficTypeDiagnostic: VI1PR08MB3597:EE_
X-Microsoft-Antispam-PRVS: <VI1PR08MB35974940A7083A6CD3FA4BE1F4599@VI1PR08MB3597.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OZ1FHGhG9pAYLQj9sUKz6Lc6Tl+Nt2WLY824M5UzdI/P5isXXW601rTLg7DCVjiQhgyM6UjIZlEfIxixiFyjDdykLohdrmELi0cb+jSHzpS4pLza1rqSxU86r2N4qdXeVpDGmsPCu1A/xjxl5UAlfvXw5jR+w7Penpqu9nBirX2LY9At0sYjG+/vg/Ya9RpHaFCvs2RsLHlCcyCpgXzn4xpB+jSkD8J9jzJUQEZBe2BwEk508ppNAON8ZzTidYUCYjHzX9k4zmmWxH81UgjRckQ9LfuRj7dUO2BxYjGV/CkJKQ450e6iFPxALOElSPBf5lQ58tKVR43pXFjPihOZFEVZ+6iUWjlgReC760WphuZQ8yK2jGMI5QroI4+ptXR0HaTnjbFT7FW7GP2zkrUIJawDMvdKQPmt5yWobRvU4csvHQjG1UuCzCqdVgLKwsmM/YYEGjXQjCnFESATpcO5EAcIN+UzYS6Gd9E61lcuZjro8uH+9/tBnNkW0rsDpGIfCdzNl/ONDDXm6mMRWWgZ6zzKSbZ4TQYfntKPm5r4W8jQwUm6mb2Jde7gd88vUHR+z0VZQczEVlzlgdlYf5geyi/+xV/xofE/h8GrObg8z/Nh2lvBtJr9PTbn8Rb9wHTywDvt9T058hNpU64iH/224LwFoEdM2oN/C7KUswui3cMyE2vmRJuV5HR+229BH2I6pIDO0RLEPntsArXty/cbeACBp5+kU+26jR6JeNbD04OOk4l1Zl8marD4WIMnFg7Z
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB5630.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(110136005)(8676002)(31696002)(54906003)(508600001)(6486002)(86362001)(186003)(44832011)(6506007)(2906002)(316002)(36756003)(66476007)(8936002)(66946007)(83380400001)(107886003)(4326008)(38100700002)(6666004)(31686004)(2616005)(5660300002)(26005)(66556008)(6512007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bmEwWk5RSHdqVldrbVdLZnNjM3NWaFVtK3c1K0lUUkhUWngzR013eE5BQnpV?=
 =?utf-8?B?VDdYNkpiTi9VcFQzUUJZSC8vMzJLazIxTVJWTkM1S0xUQlFpVUNkMVlPSGc4?=
 =?utf-8?B?RHBBdkg4eFBZUGFTZ1RaRXNBT1J5Y21kNWdFdUJjeTJwQUl1N1F6akhvczJu?=
 =?utf-8?B?R20yYnp1ZmRrSzRVZ25pclFuVi9YQkE3ZndhK3ZpUjhyTHNhbHpPWGpHRVhD?=
 =?utf-8?B?Y1dHQzNzSndLeFJIQ2k2ak1mSmVLd1IraGt2akwyek8vbUtTNm1TWXQ0Vk1S?=
 =?utf-8?B?alN0UHVrcCtxWmd1UGNEVVVnZkpvS2NqUjdXVVJ5N2N4dmZEazFnRFVNS1pF?=
 =?utf-8?B?RHZjWERCSGR0K3hWdFB2RVVRcjRLYXZZcXZHUWdyZnd1c3RZd3dKLzUxaUk2?=
 =?utf-8?B?d1g0T1JLMEx2QkpSSG5NZHhhWUM2VW03MmozVFUvT1VMOUFrRzZKWW01SFdn?=
 =?utf-8?B?N2pxaXE1MjdkcFljdmhLby9VaWRHcm1kTE0wQllkak1Bd2E5ODBIdVRRTW1x?=
 =?utf-8?B?bk5mb2FmQUtZS2ptaXhQcnRwV3ByWGx3TU4wTmFFU0traDBQcm52NDNOMCt4?=
 =?utf-8?B?YnFWczNSWEhtWmt3V1dLNWhqeG5FdkdWaEpnRjFBamRtVHpmeTh1SGEzL2JE?=
 =?utf-8?B?Q2JPdEhOWjlkcUcxSVljOVBWTWtySlZEZk5Ubm9KQ3AzeURjeDVPUEw5YnJt?=
 =?utf-8?B?WDhHN3NkOElRUUZJcW40ZVo2eC8rcVZncEJ3VzBlbm5lZjBVUWFFVnVJWFhS?=
 =?utf-8?B?QjF1OFVEcnA1c0tiTFpJMkY5OTFpNGxveFQwUkt6d01GRHl4ZlJHc0FFRWFh?=
 =?utf-8?B?STd6YTZZZ09RdFhaZWF1NnNGWEFYRmNKbzQxUDVlb0pLTEtNcCthT2d2ZjM4?=
 =?utf-8?B?dFRlUVRJcXlGdVFpRFQ5a09aaFRPZkkzdzVJUk8xZzdiWkI2TXdSL1F3cGlJ?=
 =?utf-8?B?RFdkb3Q2MVczVkhtUnJvZDExSnY4a3BwdHpHY0YwRmk5YzRyd1EzSThOcFRn?=
 =?utf-8?B?eU5hZW9IRVRGU0pNZ2pRSlVDZmQxNUV3NFp4aUIyQkdIYk0xNWUzNGo3aU43?=
 =?utf-8?B?VEdHeTNpTGpXbnpBQnAxV1czM2k1ZGgyTCtlWFIwdjlEdThRNUJBYWxkcy9w?=
 =?utf-8?B?cXF6ZlFud0xjOTZ2UWRidUJCVllZR2lVVE8wZjVzRmRJTWxLM0VTemxST1hj?=
 =?utf-8?B?OS9XMG1IK05hcklUYzZTRVBxRU8xUWhrYkxrZENpV01vOWJLMEVVYlExQzFo?=
 =?utf-8?B?aG80b2tQY1ZSQVQxTWphZDAwVkRxeXhERjA0YWQ3MFdOM1RqZjF1SjVtaUlP?=
 =?utf-8?B?cloxeHA4Mnl2eTA1Z2RuU1M5VFRHU1RibzBnQWpKNDB3ekU4M05NYzNKL1ZT?=
 =?utf-8?B?Y2NiQlFEYTdGUVhyNjQ1WHB3Zjkyc01zR2RqMGZuVGs1eGhoa2dMMWpxY1Nx?=
 =?utf-8?B?NFVEWkQxcklYL0hwS2pvRnFGdFc0UFlONmF1MUJVQ29TWFcxZE0xNnJmVXJv?=
 =?utf-8?B?WEZHK3c5N2ZoN01YNjJqNVlOUEQ4OGF2UnIwbCtkSGF5RXp6YzNKdDhySUQ2?=
 =?utf-8?B?Z0FWeVM5NWpvdDArTTBiUmhhV3Q1ZjRwcm9nWmNPcmRISGFFVXRJRWVaQTR4?=
 =?utf-8?B?dStNdXBDODRLVDdSN3J5MFM5Y1lzQXRKQlpwYWV0RFl6K3l3L2ZpMXpnMS9a?=
 =?utf-8?B?NTNNbURjMW95eXEyUDhhSmRJVkFPWlZXU0NSZUZoMHNJSTA4ZEo1Z3dXdEk4?=
 =?utf-8?B?VUI4TXMyVTU0aWMyWG1XdGlBWkV3Q0dpZ3ZvSXZLMllsazZLUHVod1I2Q21E?=
 =?utf-8?B?UlFxMWNSZVFrVTQ0Rm81bzlockpjclFLRHVqZGNTOGtRYWlrMXZFa05idEox?=
 =?utf-8?B?STIrWjlaV0RPZXl5VnQrWm9yWUVvekE4eGoxNytKZEg5K2xIV2lIVGYxUXQ1?=
 =?utf-8?B?N29ncGZ1U2NHNGVrWTdtWlJxRUpOclFwT3dqZGJCUVdJRUwxSVRXOHlaT1pK?=
 =?utf-8?B?TFhlVjdDWDJQQXdFTUNYcVZTdUpJV1lDTGJENnNqR1I4ekFDbzJEZytVWldv?=
 =?utf-8?B?ZVM5V012VHo3VGV2SGlYUXdaSURlRmRXSGQ4VllFZjNiR2FsR0NXcUNzclpE?=
 =?utf-8?B?Wk1hZGtsTFN4SU5CblJCZHl5eER0T0FsZTNva3dqRjVNampEU3c0OHhsRk8z?=
 =?utf-8?B?UlgvZDNTdDRTbnhHR1VtclJrT0pEcjVDd0NCSHFzeEFaMS9INGx6YTJDVWJt?=
 =?utf-8?Q?3wRB9GeFO8/TPXQhL79lyF+/2kFk9ahj9RO05eY/9U=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: acaf4962-2ffc-4a05-95c7-08d9db0c3915
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB5630.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2022 05:26:19.4379
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w+zBbjsE/yHwFY5lTXyo40ca4CGW1xr3Pu/s+vkGrZz9f0LD4dTSaJ1vrTLrljn9AGFkNZWZ7UNbcD/sZUg2bvozux0WDZ98grQEL3w76TM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3597
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

> Big picture is - lockd tries to be per-netns, but lockd isn't standalone, it depends on rpcbind, and 
> rpcbind isn't guaranteed to be per-netns.
> 
> One can argue that it is not kernel's job to provide per-netns rpcbind.
> 
> Still, the current situation is - by default, doing an nfs mount from within netns B immediately breaks 
> lockd serving nfs mounts exported from different netns A. "By default" = "as long as nfsmount process 
> executed in netns B is also in a different mount namespace that has RPCBIND_SOCK_PATHNAME not pointing 
> to AF_UNIX socket instance owned by rpcbind serving netns A.
> 
> Although in LTP's 'nfslock01' test the "non working locking" is reproduced on the same mount that 
> triggered the breakage, the breakage is not limited to that mount. Since that mount operation in netns 
> B, any client of nfs exports from netns A will get locking broken - including clients running on 
> different physical hosts.
> 
> I'd say that using AF_UNIX connection from lockd to rpcbind does not play well with per-netns lockd.
> 
> Solution to use AF_UNIX connection to rpcbind only for lockd serving root netns, and using AF_INET 
> otherwise - looks more sane.

Btw, not sure (did not test) what will happen if nfs server will be similarly started in netns B.  Will 
it hijack requests addressed to nfs server running in netns A?

Nikita
