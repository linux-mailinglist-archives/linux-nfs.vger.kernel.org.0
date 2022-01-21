Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7123495A20
	for <lists+linux-nfs@lfdr.de>; Fri, 21 Jan 2022 07:50:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234416AbiAUGuW (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 21 Jan 2022 01:50:22 -0500
Received: from mail-eopbgr150104.outbound.protection.outlook.com ([40.107.15.104]:57728
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232349AbiAUGuW (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 21 Jan 2022 01:50:22 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DZkzdoQzensrdCGoY6QBZZTjqHAYpkbJ1tmfWvRxxc3j6p4P9kyiOhfQ9iATOsETt5IkuBksPdnuEdQ1PpGANriZnjkIYSR0ZA0eEn1khV7vZUSNUXRICV7Hv7mpAkr0maCL8nIEtasjouFINBBZsLgrSNbYQqSu+N55q5ZErskOxETWtc3Ibi4Ad31j25FKkWONWxRa8qeaHV9f/ppJr2qW3Ky5iNuiR/gSym9+3iihND09g7UhMzbVGzNdbtZgtFViIJiregBW2hyzRdvXikOlP4mgm7UGIURahs15q3WjlC/pYcTCEr9kfTEsztExwt4sZ4zR9nYC1noZDreHdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F2gM7nOnLDXQmxMXKde3/S1ThpGvphQ5aCWJTOIqSUo=;
 b=bpp7cHjrNtZEuCQLCEJxpTwbvRFLAuq45JNjv6omC81cAdPmCQ0slYsDjAsS7+KkztKytrSSfpBht+z7y9rJgeRWTJQtlk2zq7RfxV6aTL3nY9v+FHYZr3e2wF81yU91NH0AuZrJGRJAObBGulpwwRe1xjMzBCLtcv/j47JT24rA+Gaioe/7QFUu/iFz3hebhQZSpBefTTOzT4xNVoBubug6aciRc04zUNzxbS52kFaA49NwhV745CS7Lsq3r0gfF7UqzjFqlEfCGaKNsZ6RzjvR1vfIi8bIV4P+DqUTA0TbwcWojUIrWE6YMRAt46Fc2PE5mpCjKNXtU66VpzUWtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F2gM7nOnLDXQmxMXKde3/S1ThpGvphQ5aCWJTOIqSUo=;
 b=gdSGDnEawgW8XFI53A3ml8FLlYbtdWjW3UaLinkP4a84rmWfravoNTVTwzKTQ6kZKpZwFwoa3J6oEiaUb2XeFyi/zUG3dlNCmKKjgGGotkAIyNtf9XcUrEtejoR+duaiNN/gDOBRlUJB6T6U02SOCyFKiUaVd5riroVWut4kc1I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VE1PR08MB5630.eurprd08.prod.outlook.com (2603:10a6:800:1ae::7)
 by AM9PR08MB6753.eurprd08.prod.outlook.com (2603:10a6:20b:309::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.7; Fri, 21 Jan
 2022 06:50:20 +0000
Received: from VE1PR08MB5630.eurprd08.prod.outlook.com
 ([fe80::4456:3e05:28ee:51e4]) by VE1PR08MB5630.eurprd08.prod.outlook.com
 ([fe80::4456:3e05:28ee:51e4%5]) with mapi id 15.20.4909.012; Fri, 21 Jan 2022
 06:50:20 +0000
Message-ID: <8eef9722-a2ef-54c9-2f16-85a89b25679a@virtuozzo.com>
Date:   Fri, 21 Jan 2022 09:50:17 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] rpc_lib.sh: fix portmapper detection in case of socket
 activation
Content-Language: en-US
To:     Petr Vorel <pvorel@suse.cz>
Cc:     ltp@lists.linux.it, kernel@openvz.org, linux-nfs@vger.kernel.org,
        Steve Dickson <SteveD@redhat.com>, NeilBrown <neilb@suse.de>
References: <20220120143727.27057-1-nikita.yushchenko@virtuozzo.com>
 <YenNsuS1gcA9tDe3@pevik> <da777e8f-ca8a-e1c6-d005-792114b78f84@virtuozzo.com>
 <YepE066MwWSf7wAK@pevik> <31a29913-11f4-8dfd-6c5c-735673dcd1a2@virtuozzo.com>
 <YepS+Y760GoylOum@pevik>
From:   Nikita Yushchenko <nikita.yushchenko@virtuozzo.com>
In-Reply-To: <YepS+Y760GoylOum@pevik>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM5PR0502CA0002.eurprd05.prod.outlook.com
 (2603:10a6:203:91::12) To VE1PR08MB5630.eurprd08.prod.outlook.com
 (2603:10a6:800:1ae::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9147c62d-e0ac-4219-12a2-08d9dcaa4a54
X-MS-TrafficTypeDiagnostic: AM9PR08MB6753:EE_
X-Microsoft-Antispam-PRVS: <AM9PR08MB6753D8A9942922AB147D8029F45B9@AM9PR08MB6753.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DBTq1D45PtH6TZk/OeNOs+oTO9gOOCzetWMf0fjOXa9JxveFkYnmy7Z+Cdlxl5mTFhHmPQzBnppoygWIR8th69aDMq2sCMx3wyypKDD0kep40dkSXXZtpZf6ETslJ+BBek6OmEYF2O/jhDXUi3k+nYk7MZaEnTHX3VQtXD6Rds2v695eZdj7gGXhNeosnluD2Y9+FjcX6wGN/pDoQBLSgQBpsH3tIsZPfVTDMkLd1Koy9TzSmSd8daHdhJi7LV4LALnWCQ5uDOhPRwsyh8qZW+pOREQr++GA4I1VUzd+x6e31F81DnG4iAgLj6K+Sd894RUuxjxhbVIqq9YznZclBkoBFhW/oQar/V+6sqsv9wbsmPgK6DnCRwRPACzn3bU5x+m4T11Rgbk76maGg0CoszHc5AelKH5YlCOidF8rRnuJqoVQg0sY/g62oQTUSddVCDjCwK35PhXw1wMst1x0mseC7hmtNbPvChWLFPJtdphsJGSamKYtJNBlTSb/qI889BATL9cQy2d0xWPIWH0pcxbUdxcW/dX3I6BZBU5Snv20vZ9thv5rmGQmG/UThlXKJ2j+KkyIi16yL9PxkkJnG61M9Pa6MgAeLAb0umHQFghYu7JFnX3Qcw+Gs6HEUWtycZYfuATuEzfYXgWGwKXiRwUr3msR9/FXdO1veDE0Q+3ypXFuo7smzFjsLnEHTlo7x0T7juHPjtPDJ65T9l4xx6g8VMECN3sD5wSPlA+g3jM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB5630.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(54906003)(8676002)(4744005)(4326008)(8936002)(2616005)(44832011)(316002)(83380400001)(5660300002)(6666004)(2906002)(86362001)(31686004)(66476007)(66556008)(186003)(36756003)(66946007)(6506007)(26005)(6486002)(6512007)(508600001)(31696002)(6916009)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TzZJWmRxWnRYQm94QXdhZUpoZGY3ZDlzR05YZEpQbEg0RzB4SCtEc0JlTG5w?=
 =?utf-8?B?VnpNQWMwS0ErTlJOaWVJTlJWOTlBajNpSkpXTFJKZEwyTmhEbSs4c1VLVlkz?=
 =?utf-8?B?cjMyLytxeFhSNEMxYmtLcDFZdFRqV01SSVFjSEpPb3FtYllYQXh0UlRFQyt6?=
 =?utf-8?B?cTEya1FtcUxQV1F2cUFnWlpMc1ZPRHVQSzlCSisxMGpoN1NRUTVISDh6VTJE?=
 =?utf-8?B?OUZ3akthS3lWNE1ISVJmdjVPV3dCNXZzM1lkUGxOaGhxRDI5dTAwU0FiRGEx?=
 =?utf-8?B?VHFsMGZheVlpT0JEaFdGMzJjUkoxblhkeDNQVlJoVTFNYU14ZkVuSkJvN0JW?=
 =?utf-8?B?VGlpWWZFVVBnb0NGSCs4eFBnbHY1YTZsemVhTndteGo5NVUzVEYvREszQVZq?=
 =?utf-8?B?cGptTWdHOFRpVTFPb1dFYXY2dGhhclQwbkhiOGM5K3Z3VVROQTJKbTZkdkJ6?=
 =?utf-8?B?RktET2s2Q000REpudFM5NWptU2VWeEZLRHJCSzlnb1RXcWQ3czNrOHZuUTdm?=
 =?utf-8?B?UWwwRG1FdUpad0w5WnVIVUNMbERabUpveWJuMlNUY1J1c25NZURoMkNRQU43?=
 =?utf-8?B?QzJhTmFDdGVaZHhIOWRqU3l1cU9SYjgyaEFjYkM2VHd3dllNTVVoMDZIRzVu?=
 =?utf-8?B?MWQ2RDM2Wm1CYzNJakNrOFozRGNUdjRMVGxOWXo5OEZrc3I4dStZbldWbjFv?=
 =?utf-8?B?RWl0TTlXSnh4bU9nZHBxWmJYYzJZQXBRdzN0aTZQUzhkcmRBSVFTbWpHajZU?=
 =?utf-8?B?Uy9tRjZkcGFJZWllb3RHWUdJeGtoT0ZyaFEycHFKN2hoR1REUVpUV0lmeGtq?=
 =?utf-8?B?S0k2N2NxS2ppUXRONE9reGVzOEVlOC9XMXFxOE42Qy82bnJKU0YyZWNYditi?=
 =?utf-8?B?NVhqSjVhSkFEclVsbGZYTk1UeE9xUXUweUFOcGZsSlc2WGplaHg1K1VjVVFo?=
 =?utf-8?B?OER0TzJ1L2QyN0t5SUNTNmY0T3Nva0E1NGhVUFVKRGs0NElzOWxZdVUwZnBF?=
 =?utf-8?B?c2JiUmpGc3pwRHNFVysybytGNXJpK1JNZ1lvMm5MOFZ3cEp2OW44VUZRUXFs?=
 =?utf-8?B?dFZ0N2lxRDdBaEJMNm9lL2ZuUzlaSzM2RTQ0OXpDcUFOTFh1aE1ESDdXVHBZ?=
 =?utf-8?B?T3ljeU52VUcrZFFsblk4cjYxUkprQlJuWk1xdlExbUhyQWREdngyRGNON1oz?=
 =?utf-8?B?aDFrUE9tTVkzOWZ3aS9PckNzYlVVOTlXMlcyUkl6S0gyeVdQV3lXK2E3amNi?=
 =?utf-8?B?ZmMycmNzRVpvaDlhb2dtTi9mdlh4VnhPcEswUnhVN1M1NmRwenNvczd5WDRo?=
 =?utf-8?B?eEs3N2lwRkFOUkpKRnFsdEJRNWZvRTNkbi9Tdzg5UHBuR0ZUVGxFS21QQ1NN?=
 =?utf-8?B?bCtXWG9XOTR0cFJZRUtsaVNhUzVvSWU1cHFoaDQ2OEd2MFlzVVNWdWVqYXdJ?=
 =?utf-8?B?RnAvR294dGlxY011Uzlkd2xreUFhK1N6Q0xMRjdaYjRiMUZaOUllV1Z0RE5o?=
 =?utf-8?B?SnZvREIwci84eFVlaXJvYmVjd1MzTFZZb3B4UDZTL2U5LzB2QWFBVWhLb3N0?=
 =?utf-8?B?U1l4WnZTbnA4b3BnYjlYR2t4SkVmd3FjTzEzeFU3WXhKWWI1UUpGd1JpQWRY?=
 =?utf-8?B?WWxrVVBkS200Q2dXM1lvNjRmVzh1N05tZklKNXV6TEhpL2JaSmFRQnhOeTcx?=
 =?utf-8?B?MVFYRWR0R1o3S0hwUXIyVGt0TDE0bTd6aWJkbGpaMTFlZExiekNxai9UOUpk?=
 =?utf-8?B?Z2pvcDZuV1hVSGs3dERhbzZlRHZKaDQza3lJNktFeTZBa05kT1czTm9GV2gw?=
 =?utf-8?B?ZUVaYlFuSTB0NEVMai84Zko1dFF2d0xTaWdHTEtZQ2EwUXphcHRacVpYcnZs?=
 =?utf-8?B?bklrendhV1o3U1ZJd2ZoMGxpbGN6U1phcXBwcW82Sy9DRDg1a0Q0U1MrV3lH?=
 =?utf-8?B?enFyN1Fwak8rZjUvVWMvTVF5SnNKeXgyaTdNWGYyZnErQXFYZG5qUmFJbE5L?=
 =?utf-8?B?Qy9KVncyN0FacnBodFpvVHdzdHViMUkwYkZUQlJGMGxBWFU0a3RPNXRWWlZo?=
 =?utf-8?B?SGhqNHphL2VkQXd4NUtDSlg2Ky9BMVREcjFSZkpUSEw2NE9uTU1ZY2NDRk9O?=
 =?utf-8?B?b0F6S0tWSHJOYTlFVmxCaE9CdWxaUXJWa3BvSTAwQzhnMzlYRDNsWk5NTGxN?=
 =?utf-8?B?RUkxRlQ5ZzFrNXYzTU4wTk9EWHVob2lvN1pBWDdaa2tzak1XdGFMaUpoNlky?=
 =?utf-8?B?UnpQaTYyY2xlQm0rTlAyc0VvWGFRPT0=?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9147c62d-e0ac-4219-12a2-08d9dcaa4a54
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB5630.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2022 06:50:20.1710
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tJwWrH8zBIOvTODdJ4X9Xkm5TGPpbP0LIb71xX6GmYOKFWIrKrK3eiKAq/XhexwAYKTSywhyx49Fak0uqRXwIq84CoEYZbrqZmx647E07qU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR08MB6753
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

>> Just reproduced manually:
> 
>> [root@vz8 ~]# vzctl start 1000
>> Starting Container ...
>> ...
>> [root@vz8 ~]# vzctl enter 1000
>> entered into CT 1000
>> CT-1000 /# pidof rpcbind
>> CT-1000 /# rpcinfo > /dev/null 2>&1
>> CT-1000 /# pidof rpcbind
>> 678
>> CT-1000 /#
> 
> Thanks for info. I'm asking because if it's a setup bug it should not be hidden
> by workaround but reported. I suppose normal Centos8 VM works.

I's say this is starting service on demand and this is exactly what socket activation is designed for.
