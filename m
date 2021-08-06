Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1939C3E2F8F
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Aug 2021 20:58:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233809AbhHFS6q (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 6 Aug 2021 14:58:46 -0400
Received: from esa12.utexas.iphmx.com ([216.71.154.221]:58568 "EHLO
        esa12.utexas.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233266AbhHFS6q (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 6 Aug 2021 14:58:46 -0400
IronPort-SDR: 04lCTf6ZSuoNCNGCLtMGqHrC8wkSROjEHmjjZj7SnfxWHhvKqSeIqXQB6GhvX+vGlQQcvjvwX6
 c2nnVcgJk3AQnCN8VWU7Tm8AjaqtA6zEfPkQLEAAcB48RmEX8F0fpKxUMDUyaXsSSq3RxTUUC3
 /kG4m32/RmqIDdopwSkHhyBWq6sXGxraglA1VcBBQ7BbLRFBs+eM/7ElSTabn65VZRkIA+Wctv
 QZxAYIC9x+5qOhqRubqb6zBWUeHZG/gQv7qKKQE+MyUQyazWdFJlvSAxjOZRVN2aUgGBsVxXdO
 WSo=
X-Utexas-Sender-Group: RELAYLIST-O365
X-IronPort-MID: 294802338
X-IPAS-Result: =?us-ascii?q?A2FrBAAkhQ1hh2g6L2haHgEBCxIMQIMsUYFXaYRIg0kBA?=
 =?us-ascii?q?YU5iGkDmjSCUwMYPAIJAQEBAQEBAQEBBwJBBAEBAwSEUQI1glEmOBMBAgQBA?=
 =?us-ascii?q?QEBAwIDAQEBAQEEAQEGAQEBAQEBBQQCAhABAQEBgQyFLzkNg1NNOwEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQUCgQg+AQEBAxIRFQgBA?=
 =?us-ascii?q?TcBDwsYAgImAgIyJQYNCAEBHoJPglYDLwGiEgGBEgEWPgIjAUABAQuBCIoGg?=
 =?us-ascii?q?TGBAYIHAQEGBASCUYJlGEQJDYFaCQkBgQYqgnyKc0OBSUSBPAwDgm8+hCyDL?=
 =?us-ascii?q?4JkgkRYFhtdAYE8NAgRVAFEnyhdnRiDMp42Bg8FJpVZinOGI7YrDwmEZwIEA?=
 =?us-ascii?q?gQFAg4BAQaBd4F+MxoIHRODJFAZDo4fGYNYinwlMDgCBgsBAQMJiAkHgkABA?=
 =?us-ascii?q?Q?=
IronPort-PHdr: A9a23:TKA7fhDrFkmanhMG/ltfUyQVhhdPi9zP1kY9950olr9KaqTl9J2xd
 EDc5PA4iljPUM2b7v9fkOPZvujmXnBI+peOtn0OMfkuHx8IgMkbhUosVciCD0CoMfnlciE+B
 MQEX1Y2t32+OFJeTcD5YVCaq3au7DkUTxP4MwcQRKz1F4fegt7x2fq1/sjWahlIwiehbKN7N
 1O7oRiC3vQ=
IronPort-HdrOrdr: A9a23:SS9D06CQGpHkqE7lHemw55DYdb4zR+YMi2TDsHoQdfU1SK2lfq
 +V88jzuSWYtN9zYhsdcLK7Scq9qBrnnPYf3WB7B9mftWfd1FdBZ+lZnOnf/wE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.84,301,1620709200"; 
   d="scan'208";a="294802338"
X-Utexas-Seen-Outbound: true
Received: from mail-dm6nam10lp2104.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.104])
  by esa12.utexas.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2021 13:58:29 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XEhCfg8dGJFO8QoKMB7kqta2NikDLcN2jXm6XNULGx3VbfQg48Bqto04czP7ssWV0Yma9uOijMM2h8NOjmhnUAOBQY+Bl/CbGx2pS12+qm6R600EVIjehqL3Il8UcGf9v1rCAvA1349FUWaeIGuaVSA3x/yBDeMp6e7AltZgMRhSCe96d3U7LvKFiY3uz/WK1LFDeLm9F0HFINW4z5Ncz1+Cf6F9ljDT0UzA2bd/iGOkcN/xg2jRukoO5fLk1RGw80kF5g2dMB0Ebw9v/0sSKfulgZfD2zV6mXl2hDxS7wTPFS840TRYOm1AIRRVh4Hcbf1uDghcpJnHFAqBFGgjHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rlpePz9qH0eXi6gVPjsz4mWMJLwT10U8GlhjzZIJMyA=;
 b=DIEuv1+YaYWV6+HDsSt6DXwSghfjBnZKqkftK150Ju7M5ZaMyMieJM7DqCaQm413NpyUXlTZjJQH0oBZczSqJad9BaNZZ4nbC3HENGdv/OWermQ7WYq5vV2pwvmP5L72h/MX5/OCzMoAeHe5mb3L+bW+JmIFRWjB/KGeWEvTDsewt0Y24ULONCkpXz2foA7ARG9bH/iAxDea9x8p2zPYTRilgBYFDMrBJ6GtqHmZh6T/Eh/DzE4x3jZ+2s6KLl+qq09MP95mXP6Z2cauKwTCtEY64UId+CDiLvJBRKWOd++/VQ9U0+zx4lMUQzCDIEbxXBRlw5nvzU3eVB5e68WF2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=math.utexas.edu; dmarc=pass action=none
 header.from=math.utexas.edu; dkim=pass header.d=math.utexas.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=utexas.onmicrosoft.com; s=selector1-utexas-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rlpePz9qH0eXi6gVPjsz4mWMJLwT10U8GlhjzZIJMyA=;
 b=gqyb/l4dcJekxGiiGDmmNmLZZRm5JPK/JqO2hDpMOiN74A420BtMSD5ZPffaSg8lb+b8MnQCa1fMnNDjhO+joGQgwwkLE/Lidm5G5m3HJj7xfjBZ3XY9Hajf8GnSBc9RNQN1JS0EaVcunD1tbiOexe0roEONC1xB2w+Zqdo7An0=
Authentication-Results: uoguelph.ca; dkim=none (message not signed)
 header.d=none;uoguelph.ca; dmarc=none action=none
 header.from=math.utexas.edu;
Received: from BYAPR06MB3848.namprd06.prod.outlook.com (2603:10b6:a02:8c::15)
 by BYAPR06MB4631.namprd06.prod.outlook.com (2603:10b6:a03:44::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.25; Fri, 6 Aug
 2021 18:58:26 +0000
Received: from BYAPR06MB3848.namprd06.prod.outlook.com
 ([fe80::f1bb:8be5:b452:5e1f]) by BYAPR06MB3848.namprd06.prod.outlook.com
 ([fe80::f1bb:8be5:b452:5e1f%7]) with mapi id 15.20.4394.017; Fri, 6 Aug 2021
 18:58:26 +0000
Subject: Re: cto changes for v4 atomic open
To:     Anna Schumaker <schumaker.anna@gmail.com>
Cc:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        Rick Macklem <rmacklem@uoguelph.ca>
References: <DF3F94B7-F322-4054-952F-90CE02B442FE@redhat.com>
 <ef395e52f3bb8d07dd7a39bb0a6dd6fb64a87a1c.camel@hammerspace.com>
 <20210803203051.GA3043@fieldses.org>
 <3feb71ab232b26df6d63111ee8226f6bb7e8dc36.camel@hammerspace.com>
 <20210803213642.GA4042@fieldses.org>
 <CAKOnarkuUpd6waieqvWxJDRpLojwXqbNtAFz_bz6Q2k9Xrskgw@mail.gmail.com>
 <CAKOnarmdHgEBTUc87abMqBM_+3QP4JfdT8M9536WDZg-MGEKzA@mail.gmail.com>
 <61dc5d9363a42ed1a875f68a57c912c1745424d3.camel@hammerspace.com>
 <423b3a31-c41f-09dd-835d-9e66c4a88d7e@math.utexas.edu>
 <CAFX2JfkhqJK6MRFDCzE4VryBJvk1ttYQvrASugncY-_wcEb=+Q@mail.gmail.com>
From:   Patrick Goetz <pgoetz@math.utexas.edu>
Message-ID: <5882ecc4-c582-e7a4-4638-3c8bbb21c597@math.utexas.edu>
Date:   Fri, 6 Aug 2021 13:58:24 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
In-Reply-To: <CAFX2JfkhqJK6MRFDCzE4VryBJvk1ttYQvrASugncY-_wcEb=+Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0021.namprd04.prod.outlook.com
 (2603:10b6:806:f2::26) To BYAPR06MB3848.namprd06.prod.outlook.com
 (2603:10b6:a02:8c::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.4] (67.198.113.142) by SN7PR04CA0021.namprd04.prod.outlook.com (2603:10b6:806:f2::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.16 via Frontend Transport; Fri, 6 Aug 2021 18:58:26 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bfa13d24-366e-4a88-b200-08d9590c2c2e
X-MS-TrafficTypeDiagnostic: BYAPR06MB4631:
X-Microsoft-Antispam-PRVS: <BYAPR06MB46313828DE036DE27CF29D9683F39@BYAPR06MB4631.namprd06.prod.outlook.com>
X-Utexas-From-ExO: true
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hhNGfTyNFPs+v+7NHEp+4ikIBt1Xpz+/4HVPgeeSTsWVFFx38tc+wyxQxtjQFmzpHMzSaH+YxnL4/3tjrUlt5v9SfAI7OA9bVzB3+4t62uRQvuk2XLHQx0s4D/bZN+zEzderH38tvTvQIBUlNuI6mB5l8ZeHNG+p/8AX/ilAT78+STXqmRgQ4CHNLpR+Z4hw0NP8DLo129RYhGtLy6FYzhT+0Z9koiV0jFlnWSIMGeS3pJRnDJWgOSM8RGnreR4t3zQKkdmTsCltPY/7XU1QF+hceryLJOWSvTTpeQ1pkCsWHCneIUNm8VNR+KkPPN6N7VE4/PaDlhoRNJ34ihPng4zmzdFOsX9XB4bwjwZRcR76GdcPZBjOlsu0kAkGCEp/Ts1/JZaEW0iPgY2TaF+ImdKUky/mWGKYemXA5JgL6IxSzklXQJRRUDfIZISz2MZKU3QzOFTW2aCSxDBUZoHH9pxnBj7Ho1aN0S3uhlknM0GACWXXwNnNFVcQhIgDNE3KKNCX6iVoakgjlDOguqf/IZbHpCWT/JXzpzXceJvdoDGi0iK+FJPfNo8Ezt0XfBZ1hM8T6+qG47V9GLiUiPJTCgATayWcdbByVS7cpKKiNR65Ie+M28dhP33XcRsoYzcYpGbfX7SXrdbWnTbbfLEvOINzyzS3T42WuHPPllSZdj7RSvOdB64Os7ADZBFKmXNb6M09gx0Cr0vSPh5pIxOxCHp0lJyC65NtND1/fRCnDf0i2UP01JJ/fkJELRu5m4nJ9696+X+mOLNm3YAcm+SCRw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR06MB3848.namprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(346002)(376002)(39860400002)(366004)(8676002)(16576012)(4326008)(53546011)(31686004)(83380400001)(75432002)(26005)(8936002)(2906002)(52116002)(186003)(956004)(2616005)(478600001)(86362001)(296002)(31696002)(316002)(6486002)(38100700002)(6916009)(5660300002)(66556008)(66476007)(66946007)(786003)(38350700002)(54906003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K2tUR0g5VjlVY1NRbFhEdWlGQ0xlWWh4Uk55V25IWDdnOUFGVlZZTXFQTVVi?=
 =?utf-8?B?M1BzSDJUQ2tmY2pQdjRkb3VGcjNWR2Y2aXdMekJPQUhiMkJiNXlOb0w4U3pF?=
 =?utf-8?B?ZDB2VzkwSzYwNjJqNmYydWhIcmFiK3IyTnRFZlJJTkxaYXkxVWQ5eUhJSWxX?=
 =?utf-8?B?YUtzTFFLM1VxQXVVek96YkFKTkR5MU1CWnBVNlJ2QzZNRDRxSEpxSDFacWRK?=
 =?utf-8?B?aVRKN25UcXhDR2JoYzI2QkRVek1GdUlNajUvOTRid2JhVHBzMWlQYXBVZzQ1?=
 =?utf-8?B?VndrbmhNbXFxQTh2VkNrRjBBbUVsaWpTellxQ1dwRmE5RjVORDd2UnRwdjlu?=
 =?utf-8?B?VldXcndXeWY2VGlRUktvVHdpUG1YZUowcUs5TkRiOXNkZW5sWFFJSXBnaSsx?=
 =?utf-8?B?Wis1d1M2ZHl5dVlRN2FveWswTG96Wlg0M2ZvVE56MG02K05lSjB3RzJ2RzR2?=
 =?utf-8?B?Mm5ab3VZRW1RRnAvMHk3TkdNRUkxR3l3ODROV3ZFTnEzWmZIdFBTZ3MyazNM?=
 =?utf-8?B?NzNzRDRqNzB5bVlqZThWWE1ueHViVnNrUWpFNVhwTG5YVUNDb2dLeVJFSXU3?=
 =?utf-8?B?a2lqMlRrVm56UkNrRmxMbmxnaFUxUUVuR2xYelZvL25Gc3JNQ1MrRm5zT05Y?=
 =?utf-8?B?eWlKdWRTR0I3WWJXNVQ2cFZFbFNsVVg2d2pvRTVBZEl2VE5jRGRHSVhGRm1P?=
 =?utf-8?B?VTBxZmdDODhVSENwbEJiK3cxbFpSbkF3Y0hLNG13NTZ5M2lLVFE4aXBNcUFq?=
 =?utf-8?B?ZlQ3VmxaY3lMTWpyNG9oQ1RldFVkMkRUVkUwNzB0RU4zWWpBQXF1OTQ4Q1BW?=
 =?utf-8?B?QXZzajRyQ3l2THdlbVhnOWptK2F4VzZDdEFkZ0QrdVQxR1lOSnlpTFlOVTNV?=
 =?utf-8?B?VVZZT0IrVGFST21HaGJCOGZJVGVJYVVFSitKYUg5MGhTT0ZpVy92Rk1yUlEx?=
 =?utf-8?B?NGdnRWRNQk5VdmR2Wi92bUh3KzVOZEpiSUJqc21tLzlHcTZWZkQyUEVPRTVu?=
 =?utf-8?B?SjFsSFZFNUs3ZjRyQkVWaWhYSDhuS1ZicDg2U0w4QTI1blNIc3hDSzl2SFRx?=
 =?utf-8?B?QXFsNnQ1ZDRhc2Z6U1o0QVBmbTV4V3hDTzJHQnNubUlScnNWOEMrUmhMa1ZK?=
 =?utf-8?B?S1U3QU1pNCs0ckdReEhNZVRNandPM0N0OE5pZmZzMXI1Z0pvK05NdFFnMlZD?=
 =?utf-8?B?T3ppYjlzeGZ0UUNCQ2ZqUlVlWURSLzhCS003clZaUzBuWW13dHRBQnhKYlJ0?=
 =?utf-8?B?Q2pnNjh0VVZqTDF2WVVGQWdOWncvQU1BMW12VWpEemR4YVNXWHNQd0NxTjAw?=
 =?utf-8?B?MXZoNFlZM1dkekRrejFBWmtvZTV0YjdRaXJ6S2Y4SGRGMUpLVnY0d0NhUWpJ?=
 =?utf-8?B?bHh5SmcreTF1aTQ5ZUNvdDZRa1JVSW5iY0kzckIwZkk1Z3NUVVFjaEFmY1hm?=
 =?utf-8?B?YXRuM0hqaGxJQXFGcGkvT0RESkNMZXV6RTRjTUdxTzBCN29vS0xKRG4xNHlQ?=
 =?utf-8?B?WGFWTFM2RERYM0tGQTAwTE1IZnZKZFRDL3plM3Q0QTA4N3lzdjF0a0hCakcw?=
 =?utf-8?B?UUw3Yno4Zm9EQmpsYUtSaXpRcE4rb1phNkpNa0FXTkpXRTQ4VFFFVnZGTDJj?=
 =?utf-8?B?NXRpMkVDRW1neVhQaE00UjRtWFNWaGRUbmU2ek91bnJTMVRPVEpxaU5BUllx?=
 =?utf-8?B?bm83UENmSDBxSHRNQjlhUEtHMlBzZVZsTDRlNW9hZ0pYNS9EOXhTME0zUmFQ?=
 =?utf-8?Q?Ke78hgaUlov16LpkFgCZ+T/EcogrG/R5Srzo6fF?=
X-OriginatorOrg: math.utexas.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: bfa13d24-366e-4a88-b200-08d9590c2c2e
X-MS-Exchange-CrossTenant-AuthSource: BYAPR06MB3848.namprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2021 18:58:26.6992
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 31d7e2a5-bdd8-414e-9e97-bea998ebdfe1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SPGvHShlryf+cCJV5kXMYV22WqmCamDA6rRbHHlTBWYMkHDSmTlUjnjBA5so0NbhYNjj5TIPusU2dfyWkCKPdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR06MB4631
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi -

I'm having trouble reconciling this comment:

On 8/4/21 1:24 PM, Anna Schumaker wrote:
>>
>> So, I have a naive question. When a client is writing to cache, why
>> wouldn't it be possible to send an alert to the server indicating that
>> the file is being changed. The server would keep track of such files
>> (client cached, updated) and act accordingly; i.e. sending a request to
>> the client to flush the cache for that file if another client is asking
>> to open the file? The process could be bookended by the client alerting
>> the server when the cached version has been fully synchronized with the
>> copy on the server so that the server wouldn't serve that file until the
>> synchronization is complete. The only problem I can see with this is the
>> client crashing or disconnecting before the file is fully written to the
>> server, but then some timeout condition could be set.
> 
> We already have this! What you're describing is almost exactly how
> delegations work :)
> 


with this one:

On 8/4/21 10:42 AM, Rick Macklem wrote:
 >
 > There is no notification mechanism defined for any version of NFS.


How can you do delegations if there's no notification system?


