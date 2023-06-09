Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A77C72A4BE
	for <lists+linux-nfs@lfdr.de>; Fri,  9 Jun 2023 22:31:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbjFIUb3 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 9 Jun 2023 16:31:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjFIUb3 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 9 Jun 2023 16:31:29 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2048.outbound.protection.outlook.com [40.107.102.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7FE983;
        Fri,  9 Jun 2023 13:31:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EVwPJR9FO2VqCfm7o9FWkZemj8COTMaEIZB17Itxaywl973QoNlkPSjI3yk7+lRdHwM6DPom5kGqszs7h52MmA7aMAjWVvJ6m/ywSY3RiB77LyIbrKhqfgvpDrPU8mnVN4We1+IDFIudO0V5P1xd9i8GL6B996lVjuIEXeVaH/QOI2hMqDNX4u10wInQkd07lEbhT8teSFnWs7Dq76xxT48k0TRv7b7ONpV+cLOXWH8mr2sdXZCs1ujuFIXkp4gORSVoovi4hQEXkTh+h+3cjeISFAttGywDsbe4DuvMKqcCkQpPA61jw16JLZP5z7rH953GNjiTOsm1tZY3QSmf4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+1MbnaSeI0y1myuVQJTpJYiiwId3ZksKvznOVRe/w40=;
 b=RDbvD+KefRHwzhCuz50nMW6IYHWbTOJHI19clkqEQHrUAJLKc3NQmKPEje6h2qwAyi0X/PjYNEYO4vr3ZTWWCdYyc21QsIBdt+mCrF38kQGanyuxMXigMY2Ws2LaU1nH6GsGM7dGRd0qEOlA6YKibi5vV90RWJ8NCTiWLaPLCg/cFM71E6rsgczTyXzNBOM6nvR6IucoSqw5iKMAd+BM7aoPwIAyaQECrH1hPfDH0+MhTchbUgENGugnZUuc96a5NhvTkMj9CuJSP1Z0qVm4rCOuwN/RzQ5KRIeDAOGa/RLjWrimY0QKcfwAn67M2hDBCBNhS1a5YYaUr4IkpLK+4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=talpey.com; dmarc=pass action=none header.from=talpey.com;
 dkim=pass header.d=talpey.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=talpey.com;
Received: from SN6PR01MB4445.prod.exchangelabs.com (2603:10b6:805:e2::33) by
 PH7PR01MB8025.prod.exchangelabs.com (2603:10b6:510:270::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.36; Fri, 9 Jun 2023 20:31:21 +0000
Received: from SN6PR01MB4445.prod.exchangelabs.com
 ([fe80::17e9:7e30:6603:23bc]) by SN6PR01MB4445.prod.exchangelabs.com
 ([fe80::17e9:7e30:6603:23bc%5]) with mapi id 15.20.6455.039; Fri, 9 Jun 2023
 20:31:20 +0000
Message-ID: <7ae922eb-511b-f5af-04fe-f68cd5b19237@talpey.com>
Date:   Fri, 9 Jun 2023 16:31:18 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v1 4/4] SUNRPC: Optimize page release in svc_rdma_sendto()
Content-Language: en-US
To:     Chuck Lever <cel@kernel.org>, linux-nfs@vger.kernel.org
Cc:     Chuck Lever <chuck.lever@oracle.com>, linux-rdma@vger.kernel.org
References: <168607259937.2076.15447551371235387735.stgit@manet.1015granger.net>
 <168607282316.2076.15999420482159168604.stgit@manet.1015granger.net>
From:   Tom Talpey <tom@talpey.com>
In-Reply-To: <168607282316.2076.15999420482159168604.stgit@manet.1015granger.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BLAPR03CA0021.namprd03.prod.outlook.com
 (2603:10b6:208:32b::26) To SN6PR01MB4445.prod.exchangelabs.com
 (2603:10b6:805:e2::33)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR01MB4445:EE_|PH7PR01MB8025:EE_
X-MS-Office365-Filtering-Correlation-Id: 5940748a-47a1-499d-5edc-08db69287c11
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VGzTgI89IgECFK9baIhGZ9/26rg8dbsdgFgS/grQV9JSMySK960NdLNJRNsUjLW/IUmDKwI2Q3JnoN+muHs1PRMX5p+Soqo95NMNcUXvL8HsBcbhZQEDzoRmbEQuX012hkHvYXfUDUKchgSnwcwgcGFCVKSg2kVX9UH/uOzINxkoKUleaqKsXOKNGz4urOGSOvWTa3P7k/ESO+EWxuVw47der8ghF3njsj6jZ2y9hsG59N/pxq4zE4ezvCOp0BAhrZqM/wLdQiOMMVUCE2L0nhqtVTsyOt6OwdnE7F2iT0BN2yz74I7czDOaeIk16UAdIPSs6U4Pugy80z0S82GmA3hBFXIEaUPlE0zivRophyKImFhMxWq8uxhspOHJ2TWzgDJs0eCYsfXCOT/qjhwDXGQRuBOXgS8V3shR/2wGOadw8xNoW7cQxpKuPKyp6cYFYDe/pgmDeoSt5Q1yn+y11GfLFzh8IahHWn49vo7jlRx6mYvQsM2uH8xKxeOzcYdiXKBPq4xUIJXtsbyjLmaMCv13HFpa9KufW+bnqyOX7OlFmHQPE0IglgxTS/4Dyd8QQRXrBmaBKeHBhyZznuvnRVHZOPszgaoJs97N5mM1A5th0xhkJv1kY1AyhZfPGUACVkNIrdxWryQsomolvljNVQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR01MB4445.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(376002)(366004)(396003)(136003)(39840400004)(451199021)(66946007)(31686004)(5660300002)(8676002)(8936002)(36756003)(66476007)(4326008)(66556008)(478600001)(52116002)(316002)(41300700001)(6486002)(38350700002)(38100700002)(6512007)(6506007)(26005)(186003)(86362001)(2616005)(83380400001)(31696002)(2906002)(53546011)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RjNCclNCTzlTU1VBZ0ZvSWVaNGJtK2g3VTA2aXlVbUVWZVdOYW02Wk92OEtG?=
 =?utf-8?B?ekpWbUpQOHZIWkM0S3B1cFNGcVR4WjEzTExDMGNJWk4vMGp2OGVzWTc5QmJZ?=
 =?utf-8?B?R1lHaVNKSWVucXViK2s0eWpVZlZLekp5NzQvaW1tY0JIYlhWYUpKaW1JdjdM?=
 =?utf-8?B?NWJGVzRVbHZvQ3JIcnFmajE0UlRZcHhPTDY3eUxUZ0NLRisxYkp4NmRkUmF5?=
 =?utf-8?B?NWlCY2FiZmp2ZktpczRFWTVKYmtzZy8vbkJUNWlseTh3U3pMaUpNRU51cURm?=
 =?utf-8?B?cWZBNnoxM09HSHhiMnFUSlBJNGZlQUJPQ0cyaVJmcSs3dVg2N29YdFpFSUI5?=
 =?utf-8?B?em5uNGVmZUNkWUdiM1QxL2FYa2dNaEw3QjNpZmVFcW9DMTAweUxJUTVWM05X?=
 =?utf-8?B?VkU2ckU1NWpIQ2UvSmhnWDlySEFCcDFQTURUQndEQ0lIaVJQM1ZSSXBBZ2dC?=
 =?utf-8?B?ZEl4ODU2T1JwNGhPTzZ1Nm1lbmRyOE52UkhZUUpYN1JQdHNwTlk5S0EyTFpR?=
 =?utf-8?B?RGd1Rk9sajZPUlh3RTZSRmJlVm91MTFNbDdiZ082dGJBeTVrcjJYTERwaWRR?=
 =?utf-8?B?bStoVzlXOUVBaGRuOXRyUVBrYnZhWithZHZjWkIzZEhQREZYM2ZmQVVmNHRF?=
 =?utf-8?B?aWhuZkI0VG1iVlpMTU5PbzlVWFZheTRBaVZ0bmZEa2dZN1FvNFJGZFVPVjg4?=
 =?utf-8?B?blZobEV1WUtacFFRYmZtVWQ0YUVkUlFMek5JWS9QblF2M1VSRytRUXYvQzBm?=
 =?utf-8?B?S1BOMWhkdVBTQk0rS0lJZjdsNzlnUkZOQkRwdFhFTFArbFpCaUViV1laN3VN?=
 =?utf-8?B?QTE3UXN1bjZUTUp6aUlyUFh2dEpCblR0OHU1ZGxnWEFwc1EzUlZoZmI2V0xH?=
 =?utf-8?B?T1UvUlhPeTRxU3U2eURDbkVmOWNZejFicG9OdEZ2RW1NcmlrVnBBYTVCQ1Z4?=
 =?utf-8?B?Y1Z5T1pnNHV4ZkppYTNFSGZrWG1oRDhaLzg2STdFUm5FbUg1anZhUXk0VXhQ?=
 =?utf-8?B?RXpMcVlUNXlNa0t3S2czWUdCbmFVL003R3hnSk1zOFdNdXhhL293QlVnRzBL?=
 =?utf-8?B?dXJwQjhtSjZqWnExSTk4ZVRWaW1ZQmlVclo0aUs5WVZNVk03dTZTbFFMY2JM?=
 =?utf-8?B?SHR0K3p5bDUyU09uelpSaFB3T1FZYjVvTVkyRXJsKy9YTnRDQThqTHYvWWhS?=
 =?utf-8?B?MmM2dFNNbXFxam1JQ2VvaHRhTmU1aWRnTDVLaUlVNUNtdzN5S0lXMERESWwr?=
 =?utf-8?B?V3JsdlJqWWRsSUI5bWtYaFpqRUZjT3Z1QTEyVUVvN05Ham0wZmkyY0V0MFhT?=
 =?utf-8?B?U3dJTi9kc3dCamlkSTZmRkd3Ky9PWXNGUVJpQlhnUXRuWkpkRnkrZG56NU14?=
 =?utf-8?B?SCtGdFdBOEZkL2ZGUEp6d3ZEN1dKYnhHVlZrc1lrZDBTNXJiWTd2Q0JwN0hV?=
 =?utf-8?B?Q2M1czdDY0NLeUdUTWRaK2VoU2lzWHZzQzJhYUYyL21ZZlBBWkpjMXQvbFZB?=
 =?utf-8?B?Nmtvdk9XVy9yWWE1a3J6b0pNNk01YzRMb3hJMHpjZ0RERzV6SGxld2JtQXhC?=
 =?utf-8?B?Ky9kbmF0c0RYWXdPckh1U3NhVFk4MWVrVXpHZWRUNXJJQytFYXEyKys5MVRq?=
 =?utf-8?B?Q2FkR3RPcDhNNFdMUHliMG0wVklIOHRrSUV1b04vcjFOWDhLczh2S1dYMHZv?=
 =?utf-8?B?Z2hvMmNPV2gzdWFzYWdld3c1Tm9ESWJlMHNkN2o5c2IrcDNtOXI1MWpHZWtT?=
 =?utf-8?B?UGJxZ0YvaE5PYlVLRnBUZnFPV040ZnhnUHZxblRoa0VHZkVuT3pWeFNBU29k?=
 =?utf-8?B?L1U4N3kyYnJlSHVSeW51VkplNnpjZWE1d3FSWVdPYlBtSUsvdEtMdkJ0K0NZ?=
 =?utf-8?B?eitYVkZaaE43Z0lZL0gzYnRlcmpoMWFscGpsbi9oV09EWUZxVk9PQW1uYWIz?=
 =?utf-8?B?ajdWaE96dUo2aExQejh6Z2ZmUXA2b2EvQksvQk5MUXd4WXVvaVNzNFlwejBJ?=
 =?utf-8?B?UnJUSkFoNGFmVERDNncweE9ZanQyMGRsanQrdkUwakhZb1lpWWNOYWswK08w?=
 =?utf-8?B?MFg5ZkNYTmt2YXlZeW4rWU9DR0E0UGZRUEloQmtzSHJSTGwra0l5K0hmYWQ2?=
 =?utf-8?Q?wMZiJMq7bgye/lbbLb73DyCpx?=
X-OriginatorOrg: talpey.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5940748a-47a1-499d-5edc-08db69287c11
X-MS-Exchange-CrossTenant-AuthSource: SN6PR01MB4445.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2023 20:31:20.7481
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2b2dcae7-2555-4add-bc80-48756da031d5
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WYgJnfPejKKWYw4WH1W6GilGn04I+Xtk8Ywe+I6kh61Pp4KsL/6AL82qbe6SmVGp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR01MB8025
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 6/6/2023 1:33 PM, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
> 
> Now that we have bulk page allocation and release APIs, it's more
> efficient to use those than it is for nfsd threads to wait for send
> completions. Previous patches have eliminated the calls to
> wait_for_completion() and complete(), in order to avoid scheduler
> overhead.

Makes sense to me. Have you considered changing the send cq arming
to avoid completion notifications and simply poll them from the cq
at future convenient/efficient times?

Reviewed-by: Tom Talpey <tom@talpey.com>

Tom.

> Now release pages-under-I/O in the send completion handler using
> the efficient bulk release API.
> 
> I've measured a 7% reduction in cumulative CPU utilization in
> svc_rdma_sendto(), svc_rdma_wc_send(), and svc_xprt_release(). In
> particular, using release_pages() instead of complete() cuts the
> time per svc_rdma_wc_send() call by two-thirds. This helps improve
> scalability because svc_rdma_wc_send() is single-threaded per
> connection.
> 
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>   net/sunrpc/xprtrdma/svc_rdma_sendto.c |    4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/net/sunrpc/xprtrdma/svc_rdma_sendto.c b/net/sunrpc/xprtrdma/svc_rdma_sendto.c
> index 1ae4236d04a3..24228f3611e8 100644
> --- a/net/sunrpc/xprtrdma/svc_rdma_sendto.c
> +++ b/net/sunrpc/xprtrdma/svc_rdma_sendto.c
> @@ -236,8 +236,8 @@ void svc_rdma_send_ctxt_put(struct svcxprt_rdma *rdma,
>   	struct ib_device *device = rdma->sc_cm_id->device;
>   	unsigned int i;
>   
> -	for (i = 0; i < ctxt->sc_page_count; ++i)
> -		put_page(ctxt->sc_pages[i]);
> +	if (ctxt->sc_page_count)
> +		release_pages(ctxt->sc_pages, ctxt->sc_page_count);
>   
>   	/* The first SGE contains the transport header, which
>   	 * remains mapped until @ctxt is destroyed.
> 
> 
> 
