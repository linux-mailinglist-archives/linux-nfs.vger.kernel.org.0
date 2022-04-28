Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB981513C32
	for <lists+linux-nfs@lfdr.de>; Thu, 28 Apr 2022 21:47:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229531AbiD1Tud (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 28 Apr 2022 15:50:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiD1Tuc (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 28 Apr 2022 15:50:32 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2136.outbound.protection.outlook.com [40.107.244.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0616E4D25B
        for <linux-nfs@vger.kernel.org>; Thu, 28 Apr 2022 12:47:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zd9eIeitpsSRj5+Ub2DH7S32QJUzYiIj8F2GhueiCDAxaKpHUNO23alkiLBccnn421Dn5RSKjZhhv8vVoHvEqqKv/kgVgZtGxZvTLYWtvS8qGkQWvxoirmg2oCDoPaSM1mVD3yOq0UuOd8PoX3A9hPiXd3J/yOf1f+tVeRgkm4+GsVddcizyTIBkIW5M672S9cXmFsmmieFYtWgxT3sWyEQgGr/5n0EANciupEaNmANN+HmsxIiezwAGMwuejEbeW9K5UybyGDRE+WiwSlOmKrmbzD3tdk4bUdWCIz5PEuDPzCOB04tQB2pxCdInXqrv78fzdGE/uYHfMxH1oDM+Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w28QvYKl35wbiwZUSmUwxYjcsdXd+rRfVApRzbTG8Ts=;
 b=kvELiXSIhPZcy7UrCCtR4/+CoW1kc0V9lFFjBvsKBbKjbiAGJYXdeCXCbmoXAS+JefAGNk9InKvxxCVD44YcIL8QCMIzjkmPQNEJPxnikVLjWqEjf97ldFr2M6dRC/T6Hb+3Nb2YbyT4h9xk7auWTFBQvMoTUwdxpfZWaSnZWocOex2OdYooKPN1k75IugRZRyzvAdYjmb4wFAUFhiWJeE3wksI2FN5h4xqA0838Ce7OwEt3Ik9JZLjHwiFWSh6CP/xXvWqqVAe0uxtDAWgg7NX/xysIzt7ut33oatzfAwjMee7mphbk0Ny0x03tZm/CLR4ZqcJkPMk9uKfI3qlV5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass action=none
 header.from=cornelisnetworks.com; dkim=pass header.d=cornelisnetworks.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w28QvYKl35wbiwZUSmUwxYjcsdXd+rRfVApRzbTG8Ts=;
 b=XVt6wJX8gpVMoZOY/7YqphQ2SmC82hX4hUGu3jSa4eHgxTj1rsXmy11LRifdhjoq5SMeDK26C7PnC6NHpRz8POY753GvQxnENJefmAsvcCv348rQ+hmiZfqJmShebEtwKnQ7YE5nfBrw5gfWCkYBUBF6KR5vY0PjupcCLlqKV63C/OAWUx84zaIMI9KrkbpbEO9SesHl/6WSUEnKyMIpPndRPi0BR/07+SEyRJx74VH1194j81xgxIflwxZSkhsEg4t4+jhVj4k9iRLONeaVIOXv8T6k3BDkg/lVJ/5c90ygIKRTYeWBTylKcsneamOKgevIq3ir1sAZ+pwd8yXOVQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cornelisnetworks.com;
Received: from PH0PR01MB6439.prod.exchangelabs.com (2603:10b6:510:d::22) by
 BL0PR01MB4642.prod.exchangelabs.com (2603:10b6:208:74::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5186.18; Thu, 28 Apr 2022 19:47:11 +0000
Received: from PH0PR01MB6439.prod.exchangelabs.com
 ([fe80::7cf3:6dcb:9372:7379]) by PH0PR01MB6439.prod.exchangelabs.com
 ([fe80::7cf3:6dcb:9372:7379%5]) with mapi id 15.20.5186.021; Thu, 28 Apr 2022
 19:47:11 +0000
Message-ID: <04edca2f-d54f-4c52-9877-978bf48208fb@cornelisnetworks.com>
Date:   Thu, 28 Apr 2022 15:47:08 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.7.0
Subject: Re: NFS regression between 5.17 and 5.18
Content-Language: en-US
From:   Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
References: <979544aa-a7b1-ab22-678f-5ac19f03e17a@cornelisnetworks.com>
 <8E8485F8-F56F-4A93-85AC-44BD8436DF6A@oracle.com>
 <9d814666-6e95-e331-62a7-ec36fe1ca062@cornelisnetworks.com>
In-Reply-To: <9d814666-6e95-e331-62a7-ec36fe1ca062@cornelisnetworks.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0199.namprd13.prod.outlook.com
 (2603:10b6:208:2be::24) To PH0PR01MB6439.prod.exchangelabs.com
 (2603:10b6:510:d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bbb6b095-8dde-4c1e-10d8-08da294fe2de
X-MS-TrafficTypeDiagnostic: BL0PR01MB4642:EE_
X-Microsoft-Antispam-PRVS: <BL0PR01MB46426DD08CA34C4ADC83714FF4FD9@BL0PR01MB4642.prod.exchangelabs.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ArY8Sj5KWpk+NrotwXv+awUNIeI2d7YPS4ex1Q6Qrm0KwPrNMSuDBu2g0tKgCs756fSsYnN6vUZE9LLsQQwZKrArHGLU7IQr10DgJFRZGmHEKdXZAGt6bIXzhMQrF0MhBW3c37kOm8e5HKNU6D/RbAxsvdf5KOBswXgAZGCIPKCjuXJxz8sTf73v1wPSP0/G2gv7e8lrJi8OGbc1Zbpp1TXZWuIBpsuFI8Vi9Ux7KFjAGUc3kj5qTtaTpw8yunC+ahGi4SuNi4EdwdHXlkCrL7862jGe+yHym+jlyhYRseYpYx3Tjgn03PL7vml6kDWTaprZfRr9atwXBqFUO/8BJwcsqpc+Le7t85Q+M4mv5iMXwAGvLwt5F9XxwXmNG2KzGeU+RwzLNjvtWHh8UiutQvSsDeJFT279BntOHcUAzRMxBxN6uimHie9stokEvm4YjCVehReYVDvCPi2QFxGsGofclaa4JrLAUbNNtTARzHbWEKitNZSbJJbLWkGhoMDeDUogt8Max5UOBshfFEa/gLpoxlUqBGHUZn7CP9W4N7koPZ9oNiQMxFKKDF5gOFJk28tMMNPV1eG6X9+UBuWYVo+6j92bBWUUoK7t1e3dyDVSaO8FGYMtKHAwr+Q2ksTmbg/KyURG4LgVzIVOiqjelp2NVtrDv5ez4mGpEodWo5ULj4FmrGTsPpopR1QWvFY46xU19auGlHYaVl0yKNNdK6sEK77ilmni0tjade4+HR0LG9s0u1DNy7G8M5ovsPQY
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR01MB6439.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(136003)(346002)(39830400003)(366004)(376002)(396003)(36756003)(6666004)(31696002)(6916009)(53546011)(316002)(52116002)(83380400001)(6512007)(5660300002)(6506007)(508600001)(6486002)(186003)(2616005)(31686004)(44832011)(8936002)(86362001)(26005)(2906002)(66946007)(38350700002)(38100700002)(4326008)(66556008)(66476007)(8676002)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?djc4K1ZjL3UxOEFTU05OT24ycGdrMkJmRXVyUzBGZW5TVGZ5WlF0TVFoWWI2?=
 =?utf-8?B?Zm1weUVGYTNQR0RKSmlac2wvWTRxakhMTUYvNDU3bWxOd2lwcUExRktkYWVh?=
 =?utf-8?B?d3RUVUl5c243N1hQK0RCdDVJYkUrT1JDcmV5RHk5MHJmbldlRVIrQTBwSVE5?=
 =?utf-8?B?aXM1R0ZXNm42aUZUOW8wZGtYcHloNytQU1lrZGd6NERtVjJjSGdweHByVnlM?=
 =?utf-8?B?WFZlOWFQMW1yU1N4VzZXaGNZRkZuNWt2U3l2RnlBVXZHY3hESTlkbmtWc0tP?=
 =?utf-8?B?akxIb1M2Q3ByZm10bzB1czBRTkxaWnRsd2kxZjJiRzhxTWVrSDl2aW1wdWpN?=
 =?utf-8?B?Nnp6UXNJWUdUUU00WlRWemZLRzhWQ003b2F1YlptMEg0Yng3aERzNkc5ZmdN?=
 =?utf-8?B?WlRtRTN0T0hqT1duaDNmenVPblVSWWkxeGFDV0NHYkZ4MDhHcnc5Q0d4ZVVr?=
 =?utf-8?B?bURyVVhlbEtEa3hHdUJ1VzJRWE05QmZXQkVoM3ZiSTNhWnJ3bkZwSzFIOWhh?=
 =?utf-8?B?ZHhiWHBkek1Na1lWdDVuNkpwK2I0WmFHMzZOeGh6aFdxUUZucUF3c3hvaDFm?=
 =?utf-8?B?Y3NhclVBOWdNZVNtOTg3SGNVeHFja0E4S2Z2SXVjRFhJU3N3Vm1VWkUrNXd5?=
 =?utf-8?B?Rm50d0xJWUpGOFlLSkpRcmxaSDhHNFFhWE9pV2ljWGJvV2QvcEZCRjdUYVlL?=
 =?utf-8?B?TldCdENTUFFSc21DWVVjTGdCZkEwMlVKTGNtSFd3amo3ZGdwSGVDbG82VS9k?=
 =?utf-8?B?MWx3TDFjVFk0ZWxTN3VmREp1eE15OG14NlhKcTNuNXRoajlkNzBvOEJhL1FU?=
 =?utf-8?B?elBYWVNmNEhmOTl4V2xOREdoMmVnUjB6YUpVUmpLOVNLdWpqNVRHR2w4M1hU?=
 =?utf-8?B?ekJlbjMzNEFqRnhBWGk4Y3hPVWcwaDRiRXA5TjVpUnlUdkFINjJoOFdrKzZk?=
 =?utf-8?B?ZE9zUVdjbUpueHZKc3YvbCtoUkdJRWluSEZSd3lwYlFQc2lwUjEvTGRpUEZI?=
 =?utf-8?B?elVuSVcrVlR1cEZ1dSswWHhIZXl1Y21JV2xwTDk1UDFDKzlDQlZFeDk2Q0VQ?=
 =?utf-8?B?bEpPWlFLYnpqd0tzTWtGb3I1S0tmVnE3bGR2eWIySUtzdUZzSVYzY2ljak0y?=
 =?utf-8?B?L0Q1V3pzYkYzS290ZHJvWXN2ekpZSThoNE1oUGY5NDdYUk9TSFNvd0pVSzR4?=
 =?utf-8?B?T1JDY1U2OXdpeE1LaTJ2clBOZVZnMit5SnlCbmoxZmZGV0I3S0lVZkVlVHZv?=
 =?utf-8?B?dUd0T2p5U3pOWUN5SExMOWZockx1eXFDc3kvbkIxNzlYdldWS3h0LzdReGFZ?=
 =?utf-8?B?NGhLbmdXS1JYSDVuUXdNOXlyN05uMm1aZUFoSnRzVkIvbzdSeTJ6cHRuYmF5?=
 =?utf-8?B?a0M0UU5UQXgwK2IwNTFNM3VGallhWGlqeXRlaEQ0YXRxdWt2NWF1Q2JwV1BJ?=
 =?utf-8?B?ZitwblR1a096cFBpQ3NMRVhrTTVMemdzVmdzdHZyNUdlMU1UWHZQaVh6aEE2?=
 =?utf-8?B?TjhHL2dMemRmSzdWemFQa09uOHhvQ3FQbkFrdlI1Y09RWG8yeXpoUnFHQVFB?=
 =?utf-8?B?U1BEcUNxbTlicHZ1bHJIZTdJUEVkWXY4S2YzK3BjdGNsUkh4S3ZxNkwwb1Yw?=
 =?utf-8?B?M2NQWjQ3elRZakpZNC9MOUZDTXc4eU9JTTF4d3Njb01zSnd3YWFNV0g2NWcy?=
 =?utf-8?B?aXJFbXVLb3MrY1RYRk9vN3I3L1dxSWJZZXFBdGU0emJXYm5VY2dsVkF2cGNJ?=
 =?utf-8?B?UGtzR0dSK3ZhUXYveXV3Nk9ZWk5ZVzRZbENPbisvcmNEMGhBZUxENHFtdG1y?=
 =?utf-8?B?VFltd1lmbVZqemdwU281ZUVwU1RXWFRWUjA0T09IMzl2eEZ4Y0Jtei9pcUlR?=
 =?utf-8?B?NmljM3BzeW43YzZHSS9lMUY3a3lPRlpsc1h0U2dNOWJJM3ptTFZlTUt1TGhU?=
 =?utf-8?B?Q0tKbkJNTWNKRjUwMkduZlR0TzZkL2VweVdQb1ZBT3V0YzloWFI0NHJhYzdl?=
 =?utf-8?B?VGZWd0FoUURyazZheXBsL2tiaVl2RXdyOC8rOUh0YllVeFBPSkE2YXpoVmRl?=
 =?utf-8?B?MEsySmFkOVhnclVhWnhBNVc5Vk1NZHdCOGx2WGRQaGcrR3ZNOEhzdHMxWnE0?=
 =?utf-8?B?MUZBQldUeWVURGtpWUxRQ2ZBYnRjMWlZLzBJL3l4RHA2dnJvdmR1cmZrZkF6?=
 =?utf-8?B?L3o5ejRtSHhYaHBTRlEzTHpKbU1KbUdkdWdTbDcrT2hwMkl3QWtQZEplRDF3?=
 =?utf-8?B?dEdteEQ4eHkwVnhFTmpuNHYxeWhlSGxPMCtBS0FSZnB2Zi9hbXZnTFJEWFJl?=
 =?utf-8?B?djJvdkcyblZzanMyWXZicmw4bWd4MGJkYmpwUWMwZHFLL20rY1VlNitPYlUx?=
 =?utf-8?Q?MsrTexAxa3NgrVkSjnKY4/S/IlzOrgWg6/dTK?=
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbb6b095-8dde-4c1e-10d8-08da294fe2de
X-MS-Exchange-CrossTenant-AuthSource: PH0PR01MB6439.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2022 19:47:11.4673
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DoOzgcmCHH4GfBResv2UjS2G8ZnY6cqYd20/Iuy+I89aohbXGPwaslVJZU5SYR+WNwKB+S4ElT1ueUWkHz2areJVQG0qnwavtcNvclSh47A0Pg9BmKMDXq5bUzKuKxzL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR01MB4642
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 4/28/22 11:42 AM, Dennis Dalessandro wrote:
> On 4/28/22 10:57 AM, Chuck Lever III wrote:
>>> On Apr 28, 2022, at 9:05 AM, Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com> wrote:
>>>
>>> Hi NFS folks,
>>>
>>> I've noticed a pretty nasty regression in our NFS capability between 5.17 and
>>> 5.18-rc1. I've tried to bisect but not having any luck. The problem I'm seeing
>>> is it takes 3 minutes to copy a file from NFS to the local disk. When it should
>>> take less than half a second, which it did up through 5.17.
>>>
>>> It doesn't seem to be network related, but can't rule that out completely.
>>>
>>> I tried to bisect but the problem can be intermittent. Some runs I'll see a
>>> problem in 3 out of 100 cycles, sometimes 0 out of 100. Sometimes I'll see it
>>> 100 out of 100.
>>
>> It's not clear from your problem report whether the problem appears
>> when it's the server running v5.18-rc or the client.
> 
> That's because I don't know which it is. I'll do a quick test and find out. I
> was testing the same kernel across both nodes.

Looks like it is the client.

server  client  result
------  ------  ------
5.17    5.17    Pass
5.17    5.18    Fail
5.18    5.18    Fail
5.18    5.17    Pass

Is there a patch for the client issue you mentioned that I could try?

-Denny
