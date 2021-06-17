Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 722E13ABF46
	for <lists+linux-nfs@lfdr.de>; Fri, 18 Jun 2021 01:17:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231523AbhFQXUE (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 17 Jun 2021 19:20:04 -0400
Received: from esa10.utexas.iphmx.com ([216.71.150.156]:21974 "EHLO
        esa10.utexas.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231438AbhFQXUD (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 17 Jun 2021 19:20:03 -0400
IronPort-SDR: idDTcXo44mmJ9gRMZOC9HR+qEMrc4dmLkslTEA/JImcBnaDiB3lGyMW6Wsj+gMSuYuvQLRXBmi
 0avuszdZRDvFnvQg/ci5dh5xHLB7h7Lu2Im5AVNhavic5gYOKQueLkdE6c8rFyGzpjjvtV2XjV
 X1URcegv98DJKD100I7FGRm0iuhDzuJxlHxjk+fC6K9wGmZP8hGbMFtsj4eduH1cQhHAdScPlf
 9H8OtMOQ4xnyJDoVGmWrjDyUAFMPZmrJ3ZVfTXHQoDH3YUqVKcAGqhcOgYZioD8X0uXyCj8eA/
 Nko=
X-Utexas-Sender-Group: RELAYLIST-O365
X-IronPort-MID: 279942314
X-IPAS-Result: =?us-ascii?q?A2F4BwCM18tgh6o5L2haHQEBAQEJARIBBQUBQIFXgVNRf?=
 =?us-ascii?q?oFCC4Q9gwJHAQGFOYhXLQOPWYpBgUKBEQMYPAIJAQEBAQEBAQEBBwI1CgIEA?=
 =?us-ascii?q?QEDBIRJAjWCOSY4EwIEAQEBAQMCAwEBAQEBBAEBBgEBAQEBAQUEAgIQAQEBA?=
 =?us-ascii?q?WyFLzkNg1ZNOwEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QUCDVIpPQEBAQECARIRFQgBATcBBAsLGAICEQ4HAgIyJQYNCAEBFwMEgk8Bg?=
 =?us-ascii?q?lUDDiEBDplIAYESARY+AiMBQAEBC4EIiQx6gTKBAYIHAQEGBASBNAGBGYJuG?=
 =?us-ascii?q?EIJDYFZAwYJAYEGKoJ7im9DgUlEgRUnD4JtPoN9LzEmgliCZII/YgF6EwErg?=
 =?us-ascii?q?S8VFShEkSYni3OBK1yBJJtCgymKEpNWBg4FJpUEkGqhc5J9LQ+EaAIEAgQFA?=
 =?us-ascii?q?g4BAQaBa4F+MxoIHRM7gmlQFwIOjh8MDQkVgzmKfFU4AgYKAQEDCXyHUAGBE?=
 =?us-ascii?q?AEB?=
IronPort-PHdr: A9a23:9D/P3xQonk3xDeFDn5qWWX3MYdpso03LVj580XJvo6xBf77l/Jn4O
 kHbo/J3gwyBUYba7qdCjOzb++DlVHcb6JmM+HYFbNRXVhADhMlX+m5oAMOMBUDhavK/aSs8E
 ZdcW1J/uXK2K05YHID5fVKB6nG35CQZTxP4Mwc9L+/pG4nU2sKw0e3XmdXTbgxEiSD7b6l1K
 UCzpBnR8NQKjJtrMeA8xgaaykY=
IronPort-HdrOrdr: A9a23:ms+2batW3yL3/F/JbPyke2bs7skC64Mji2hC6mlwRA09TyXGra
 2TdaUgvyMc1gx7ZJhBo7+90We7MBHhHO1OkPMs1NCZLXTbUQqTXfpfBO7ZrwEIdBeOkNK1uZ
 0QF5SWTeeAdWSS7vyKkTVQcexQp+VvmZrA7Ym+vgRQpENRGsRdBm9Ce3im+yZNJDWua6BJd6
 Z0qvA33gZJLh8sH7uG7zQ+LqX+juyOsKijTQ8NBhYh5gXLpTS06ITiGxzd+hsFSTtAzZor7G
 CAymXCl+qemsD+7iWZ+37Y7pxQltek4txfBPaUgsxQDjn3kA6naKloRrXHljEop+OE7kosjb
 D30lsdFvU2z0mUUnC+oBPr1QWl+i0p8WXexViRhmamidDlRRohYvAxxr5xQ1/80Q4Nrdt82K
 VE0yayrJxMFy7Nmyz7+pzhSwxqrEypunAv+NRjz0C3abFuLYO5kLZvuH+8SPw7bWXHAcEcYa
 hT5fjnlbRrmQjwVQGegoEHq+bcLkjaHX+9MwA/U4KuomFrdUtCvj4lLfok7z49HaIGOut5Dt
 v/Q9BVfZF1P4QrhPFGda08qfXeMB27ffuaChPvHb2gLtBIB1v976Lr7KQ8/qWEY5oNiLcivv
 36ISVliVI=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.83,281,1616475600"; 
   d="scan'208";a="279942314"
X-Utexas-Seen-Outbound: true
Received: from mail-dm6nam11lp2170.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.170])
  by esa10.utexas.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2021 18:17:52 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dqUwqJmMYDXZympAfz5/CU6lQtFuSgAtxBuRo7KvSN44HJWqqaef0TWVTG9+0MmAijYo9Vjw7saT7fm59+ZpV4jKGLmoSgC0K+E30sqx8NIM7FVcSHAETv2vyW3c4ink6VamezmYcmV/26wky35c2PBVHygaoKg5FLVjQtwDAoC9SKXuL/i6SQ5QeRbr2gR39vMjo2gJWrfSMKnB7zgPpapo/iT25NchzfaOMc4jylOTUKqC+Pgz6+2V+gCYwYubiOyJqvXUJ7deyt3dY4e8715Xs6pbpJyEyG93QpxIPIcTmNkpZYskYtTLTjNa78sOx/W0gd7TmgmMbYwUqLLGcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4j6m2w+oVfLwa4rPDHL714S1kH5WG/4LiD4s/YZaAoc=;
 b=B3fTZ2cEvtYaeVxz35NROvMRvplom0t1zJSZy/yFxg8fd02sgxLNPp5Hs6tuYAv/QLC4LaNf/zK5dSvZPzOX/0OG4NCzgr4ruolVIIm1jO85OFSb8QATmhEnTy7Zn6gkE52e/M2Tmj1lIfz8wirrCFtGP9JU59+zaZOAOS85jjy1ydmXkTYI15kSg0dOrrQ6W+TqnLLEsnCNlH0TEQRLbEkQx/Ej/sXZuMEUpfUMxLRIcFCtK2jTzX7P0Gg4eziz012E4mNcjlSKvi2+jogeDQD+iFOk+vSwViAzNQM6ZgqPDyhpqYSLRWzKkAkGVAzTnDGuNzauueD9jsrf/yk5kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=math.utexas.edu; dmarc=pass action=none
 header.from=math.utexas.edu; dkim=pass header.d=math.utexas.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=utexas.onmicrosoft.com; s=selector1-utexas-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4j6m2w+oVfLwa4rPDHL714S1kH5WG/4LiD4s/YZaAoc=;
 b=OrQTbu364FoUg43UdyRhuc8/2IZ0EkjfCP7VlRDMCFJGtB0hXvJC45YcCI9bcZ7/az8qHCpotZR2CeFRUxTrjGQEoVrGy3itfvjtCjAWocmzy9mAdlVAf/m1nYHV5yZdNiMawP3VP9OT5vRR0wJafyWoiYrQtPZC5PyWkOKSlPg=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=math.utexas.edu;
Received: from BYAPR06MB3848.namprd06.prod.outlook.com (2603:10b6:a02:8c::15)
 by BYAPR06MB6373.namprd06.prod.outlook.com (2603:10b6:a03:ce::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.21; Thu, 17 Jun
 2021 23:17:49 +0000
Received: from BYAPR06MB3848.namprd06.prod.outlook.com
 ([fe80::b5b8:98c7:3e33:3a22]) by BYAPR06MB3848.namprd06.prod.outlook.com
 ([fe80::b5b8:98c7:3e33:3a22%3]) with mapi id 15.20.4219.026; Thu, 17 Jun 2021
 23:17:49 +0000
Subject: Re: Use of /etc/netgroup appears to be broken in the NFS server
 version which ships with Ubuntu 20.04
To:     NeilBrown <neilb@suse.de>
Cc:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
References: <2539b705-b72a-d9de-965e-7836dfd2e362@math.utexas.edu>
 <162389949987.29912.5411348355154532470@noble.neil.brown.name>
 <44f13e43-2f29-f442-a68f-2dcbef8145f1@math.utexas.edu>
 <162396505317.29912.2567278880935137712@noble.neil.brown.name>
From:   Patrick Goetz <pgoetz@math.utexas.edu>
Message-ID: <34cfd109-f80a-26cb-be5f-9229fa884fac@math.utexas.edu>
Date:   Thu, 17 Jun 2021 18:17:47 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <162396505317.29912.2567278880935137712@noble.neil.brown.name>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [67.198.113.142]
X-ClientProxiedBy: SN6PR08CA0004.namprd08.prod.outlook.com
 (2603:10b6:805:66::17) To BYAPR06MB3848.namprd06.prod.outlook.com
 (2603:10b6:a02:8c::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.4] (67.198.113.142) by SN6PR08CA0004.namprd08.prod.outlook.com (2603:10b6:805:66::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.15 via Frontend Transport; Thu, 17 Jun 2021 23:17:48 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3097a292-c660-49a4-fe24-08d931e61f4c
X-MS-TrafficTypeDiagnostic: BYAPR06MB6373:
X-Microsoft-Antispam-PRVS: <BYAPR06MB6373DBFCC2EF96162282DA46830E9@BYAPR06MB6373.namprd06.prod.outlook.com>
X-Utexas-From-ExO: true
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NvlFz5IICGqO8J5kFD1LdHVWP6YTChftByIX3KDGjTUyVYnR9UC36idJV4tbRTNuV8D+947DQoE1Y2RDcMZgdDiwYkm23Ztj4/sQOxITGGsHn4IOMQS6r1U2wmdItlwUzePVG7yt0Jd2FXEMWeSjoSeG/5ONsz1rHupcqyGdIjGVa5UikzfPdhjWcFfM+JsSn+63of9jKhlrMG/ex6h4UuFEunPlpH3hWJQ0Wlt03162p0tq2MI6f1F7tRIZVbpfGqY/dTk0PAjXdh9E0BYdZzJxmL8ZatlyDvZFgYTMau3y7ZD7VxXnVHdBscGXeS18UWqwHDQqmdgCqUSc7zD8/fW9JWnpAH6GuPnLjvjX+RhAxCYukfk6XVzeEqVQtHWSUR+eQGheGg4VsJqC+7AkeuHgFnxkXZWkDDC/0e3re4Qzqp2SIwwj6qpfnf3YTMPgBaUq/bYeyETvnrDnRrQ0cGkiIqev+csoGAgwq4etFC1opYoEUyaFDL0PDvHEjIAtc3ejOXHJ/9Ac602cr2bhHgi78DrICxXJlVrAS1JPme50F/ddJDbBMzEjTA8/AuOK6YxKIEXqM8aZn2Njmujhhl9pBgZnuzGpRtDOm7WtgDQ078yRScK75mu3hoSnhRD3I0lnRVYHOcazI8mLIKLleL2pwzdtFDuoKCP4+OlOusYaXBsXCbB1GEpzLF4eNL7f0XtCtdibi93egGjN5VwVxMbtHTUN0tQgoa6NIIk60K2IP4v6sfFwwe9zqkHzSf7zDPfEb2kyS/bkrJrkMRl/KB6NytE0wuQu6jQg0i5Dslkn6czKRlfqdzLrMACBybLpGQkhdQEfVsrq4wEgqc5cyTVlf7yoEqSqAtUZ5e28jZo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR06MB3848.namprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39860400002)(376002)(136003)(396003)(346002)(2616005)(5660300002)(16576012)(86362001)(8676002)(31696002)(8936002)(316002)(786003)(956004)(66556008)(66946007)(31686004)(75432002)(2906002)(16526019)(478600001)(38100700002)(53546011)(38350700002)(966005)(52116002)(6486002)(4326008)(26005)(66476007)(186003)(6916009)(83380400001)(21314003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y1VGZmZmSllCQitMcjRhQ0hOQkhDSzRDZjd3M3Q5c0pUaGYzSVN2YklUZEJX?=
 =?utf-8?B?Wm5FRWhyNzZwRDFHSnFmVFdndHUxZ1NqblBlWk9peWVUMWZFakVEKzZWNGxZ?=
 =?utf-8?B?YkFiN1Bpa2FBT3lyd1JacnlhSER5MEtrMGxUdnJ2YnRsbWJLMEdtM3V0NEFV?=
 =?utf-8?B?Z2FuZXh5clowT2VFNGx4MVNOTUkxamg5RlJaalRSVm9UL1FpUHJxUUJBYnR4?=
 =?utf-8?B?ekpIM1hJOGlqZ296eVBGRlpCVnFjaVZvN2M1Z3BIWTlNQ3ppRFRFNHR3Y1VC?=
 =?utf-8?B?aUcwWDNmYnZ2ZlpjRlhLbUxXWjJrblVtK01FaUhyZjA5cHlhZjd0SmFzK3JS?=
 =?utf-8?B?YVpFcmIvZlhZc2hVbUQ0M2E4RXMrdG5GNCsycE53RHRmL25NUGpGN2hLLy85?=
 =?utf-8?B?cll4czNob3J3THV2dkVYbWNqbU0xSkg1elZrK1FkSHVtMW4rdXllVDJoZmI0?=
 =?utf-8?B?WjRlZVJobDZ6UnZWc3Y3TzZtVFpOQzczOEtZWDk1RzlvWXNFRXdxZVBTemFx?=
 =?utf-8?B?ZzNXcmkzNmM4c1dnQlJncW4vL003T1llOFZlc1hJb0oxRmV5T3ZFci81TmJw?=
 =?utf-8?B?azQzWTNsV2JBRUNSdGIxV1FEcjJzSWtYL3JLc1Iyb2pNSDk0RDAyYStJMXlJ?=
 =?utf-8?B?RXhXN1E2Yk1wN25LQUg0c3VGK2tnakp4N2o2dDVqU2lkVThpb0hyVUExaGZm?=
 =?utf-8?B?ai9SK2hCWTFSazZvYVlmT3FiOG4wWm5UZVdaUmI5SWkxMWhUdWVwVElrRm1k?=
 =?utf-8?B?aHlGMER0N1ZLZ1dlNlduR1hwMS9RSjZzQVd0d1g4YThjMG1EQlMrS0pyTXJW?=
 =?utf-8?B?YkdReUVTZ0x5YUMwUjRCNW5GZ0VuYlpsM052YmRseDFoeWRYaEhrQ0dEZC9a?=
 =?utf-8?B?QnNQd00rSXYxOC93Y0JyUmVieVJjZGdaZGVPUXNqdisrdW1aRFZTOWo0K3BX?=
 =?utf-8?B?U0l0M1d5R2srTGFyMExEM0ljS1V2Q0ljZFJjeUR2MGEyTlJISVFNem1GcFUr?=
 =?utf-8?B?SytxU2JKc2FtV2huL2crbTc0anh0UEVhc0ZzcGYreGlXcHhvL2RITktGY1p2?=
 =?utf-8?B?TDE4UTR0T213RlVXK1F1Nkp2OXI5ZldnbEFkVmhuR0Z2SmhJcEZQMTl0Vnhk?=
 =?utf-8?B?L24waVZmNnQrL0sxR3NWK1cvS0R0eWhGRFEwaE9lYUhOSTNoVjYzTVByK1Vn?=
 =?utf-8?B?T2RXaFBsRWlacnNqWDBZR0xJNW9LMHpXT05TU3pQV0hOL3JBVmY4U0xoNU05?=
 =?utf-8?B?d1cyaFdjQ0YwTGpkUVRtSkZLVmF2QUJGdU90OEpXWXBlL3IwSWRWTXFKNmtQ?=
 =?utf-8?B?ZS84b0hheG9GbDVMWmFJU1N1K0pPQ29iTm1HU3FzWDB1MnA2eWRRMEFOeWpD?=
 =?utf-8?B?SHQweituUDZiSUZabXd2d0ZQVU5iTVVjcU1mandJZVVqQnkwYkhUdUgwSXV5?=
 =?utf-8?B?ZHo0NC9ZVFg4SFNSVzFpNUpoM3dUQjBnWnljR0lYaFlUWXRPWGx3bXd0NlZn?=
 =?utf-8?B?cDJWcW5wdXczc05SM1Q5VDQrb3hlR3VSaWR2MEFqbGhyY2xsN05SMXFUWUt0?=
 =?utf-8?B?RVIwaWFubFRhdmJEWXZtYkptbjVuME1iVHNieENSR0xtVVpOQ1ZuOEx6cWtj?=
 =?utf-8?B?VW0rekFyenBtZ3JFeE9LK05VREw5L3VpMmgrRW9yYmxzT01LV2RUbitDTEg4?=
 =?utf-8?B?eHJUbVFkM1dpMzFJZ0FuU3d5VXYzZXBSOHRLTnYwNm5BRmRvTjRQaklGMnl5?=
 =?utf-8?Q?vQ04oVRL4j3r9ZyLtvOxLGaa8FdeAkkNAT+8EQt?=
X-OriginatorOrg: math.utexas.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 3097a292-c660-49a4-fe24-08d931e61f4c
X-MS-Exchange-CrossTenant-AuthSource: BYAPR06MB3848.namprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 23:17:48.8333
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 31d7e2a5-bdd8-414e-9e97-bea998ebdfe1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KAYaJmA3IYWmFLWuaxYmj0xTZ3dpoMt8UovUxxDmNMiX1RNV/1s93I0NI3v/tsuXRxMb0OlFPa0afkmLfZiE4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR06MB6373
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 6/17/21 4:24 PM, NeilBrown wrote:
> On Fri, 18 Jun 2021, Patrick Goetz wrote:
>> Hi Neil -
>>
>> This is extremely embarrassing, but chalk this one up to user error
>> (technically, PEBKAC).  I'm used to /etc/nsswitch.conf always including
>> the files option, so didn't think to check this when in fact on Ubuntu
>> 20.04 they ship the nsswitch.conf with this netgroup entry.
>>
>>     netgroup:       nis
>>
>> Who still uses NIS?  Beats me; but once I added files to the option list
>> it starting working as advertised. Very sorry to dump random noise onto
>> the list.
> 
> :-)
> NIS has a certain elegant simplicity.  LDAP is probably objective better
> in every way ... except the elegant simplicity.
> 

I agree.  I hate LDAP (so inelegant) and I find ASN.1 to be especially 
inelegant. (I've never seen anything to indicate this is anything other 
than an anachronism.)


> Glad to know I wasn't missing anything important, and that there was an
> easy solution.
> 
> NeilBrown
> 
> 
>>
>>
>> On 6/16/21 10:11 PM, NeilBrown wrote:
>>> On Wed, 16 Jun 2021, Patrick Goetz wrote:
>>>> Sadly, it took me a couple of days to track this down. The /etc/netgroup
>>>> file I'm using works perfectly on another NFS server (Ubuntu 18.04) in
>>>> production, so this wasn't an immediate suspicion.  However, if I use
>>>> this /etc/exports:
>>>>
>>>>      /srv/nfs @cryo_em(rw,sync,fsid=0,crossmnt,no_subtree_check)
>>>>      /srv/nfs/cryosparc @cryo_em(rw,sync,fsid=2,crossmnt,no_subtree_check)
>>>>
>>>> Client mounts fail:
>>>>
>>>>
>>>> root@javelina:~# mount -vvvt nfs4 cerebro:/cryosparc /cryosparc
>>>> mount.nfs4: timeout set for Tue Jun 15 11:53:22 2021
>>>> mount.nfs4: trying text-based options
>>>> 'vers=4.2,addr=128.xx.xx.xxx,clientaddr=129.xxx.xxx.xx'
>>>> mount.nfs4: mount(2): Permission denied
>>>> mount.nfs4: access denied by server while mounting cerebro:/cryosparc
>>>>
>>>> and if I switch to specifying the host explicitly:
>>>>
>>>>      /srv/nfs javelina.my.domain(rw,sync,fsid=0,crossmnt,no_subtree_check)
>>>>
>>>>      /srv/nfs/cryosparc
>>>> javelina.mydomain(rw,sync,fsid=2,crossmnt,no_subtree_check)
>>>>
>>>> the mount just works.  The tcpdump error message isn't terribly helpful
>>>> here:
>>>>
>>>> 11:14:02.856094 IP cerebro.my.domain.nfs > javelina.my.domain.741: Flags
>>>> [.], ack 281, win 507, options [nop,nop,TS val 791638255 ecr
>>>> 2576087678], length 0
>>>> 11:14:02.856178 IP cerebro.my.domain.nfs > javelina.my.domain.741: Flags
>>>> [P.], seq 1:25, ack 281, win 507, options [nop,nop,TS val 791638255 ecr
>>>> 2576087678], length 24: NFS reply xid 2752089303 reply ERR 20: Auth
>>>> Bogus Credentials (seal broken)
>>>>
>>>> but after figuring out the cause of the problem, I did find a
>>>> corroborating RHEL error report (which you'll need a RHEL account to
>>>> access):
>>>>
>>>>      https://access.redhat.com/solutions/3563601
>>>>
>>>> I couldn't figure out how to determine the exact version of the NFS
>>>> server that ships with Ubuntu 20.04.  Maybe someone could explain how to
>>>> do this.  Running
>>>>       /usr/sbin/rpc.nfsd --version
>>>> doesn't do it.
>>>>
>>>>
>>>
>>> The problem is unlikely to be the implementation of netgroups - that
>>> hasn't changed in a long time.  It is more likely to be some subtle
>>> configuration difference.
>>>
>>> Can you provide the verbatim /etc/netgroups file, and the extact host
>>> name that a DNS lookup of the client IP adress results in?
>>>
>>> NeilBrown
>>>
>>
>>
