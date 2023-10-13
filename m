Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8963F7C7ACF
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Oct 2023 02:23:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234205AbjJMAXl (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 12 Oct 2023 20:23:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229840AbjJMAXl (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 12 Oct 2023 20:23:41 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2058.outbound.protection.outlook.com [40.107.244.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69005B7;
        Thu, 12 Oct 2023 17:23:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OwwU7MFYN105X6zkuJRMW3l74FH86Dz0PCrJnqLXvH10Y+QQr/BA7Sgme+EtDXbZFy77awbwHhn0jhST8RjNbiXpRgxJJBCM2KGAF8Fc7SVtQ6jy4BG5egxYNrEm7bcXfybQTZWMtPviUWJcqjdf1aHuX46ut333906GOo5KMA5wTkGLaLv80o1F7XDSUQLe8zi2AxyVKouyENBkBCg794Fe9ncCadNnlhW9eFSysjUzwUCJ+GTeo3IkmQySWbZH4cKc4iwmHX1UOzArpDKU8H5+lkFthqW10ojvYe40WoFj29Dk+NUNP9ULqfdNCO49nfowzO0+HrPQRkjqKwnwIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tS0cv5gb1MJ2b54oclGWQaautNSCuGBqoWIxVNl8rNY=;
 b=bebYS8YLpG2peSwIOH00shFQi+EURDZWV8rleZnSJ1XMR+pRR7JqwsIRaqKjbNxOPnfVAyitWT2H8GhDSiCwyXjo50hVkOcwEJehhrwezRHHQrIx1ob5JiLQvcfthY3ZShI3ehjeRZo6LilSteMLRM0OJmMWIk6tNNPQfX/eNGelT8ThCXL5oi015ruB3HCUFGCr87j6+TNewaHU4xR5r437twOxxPJaiDHggQxAXG+i+aPJk0S3jjg/A1cAsTOSidQqvxKkgo8arMNR8kkfprlHq24kaJiexH+OlJt9QlNhqxWXQECwFZvuPNpzLXhdgzrgvs54QkyN2y8lmekgvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=talpey.com; dmarc=pass action=none header.from=talpey.com;
 dkim=pass header.d=talpey.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=talpey.com;
Received: from SN6PR01MB4445.prod.exchangelabs.com (2603:10b6:805:e2::33) by
 SA1PR01MB7325.prod.exchangelabs.com (2603:10b6:806:1f4::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6863.44; Fri, 13 Oct 2023 00:23:34 +0000
Received: from SN6PR01MB4445.prod.exchangelabs.com
 ([fe80::28cd:b4e1:d64b:7160]) by SN6PR01MB4445.prod.exchangelabs.com
 ([fe80::28cd:b4e1:d64b:7160%4]) with mapi id 15.20.6863.040; Fri, 13 Oct 2023
 00:23:33 +0000
Message-ID: <d2ecff1e-1404-4f9a-8550-b211ff5f7410@talpey.com>
Date:   Thu, 12 Oct 2023 20:23:29 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] svcrdma: Drop connection after an RDMA Read error
Content-Language: en-US
To:     Chuck Lever <cel@kernel.org>, linux-nfs@vger.kernel.org
Cc:     stable@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
References: <169695862158.5083.6004887085023503434.stgit@oracle-102.nfsv4bat.org>
From:   Tom Talpey <tom@talpey.com>
In-Reply-To: <169695862158.5083.6004887085023503434.stgit@oracle-102.nfsv4bat.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL0PR0102CA0062.prod.exchangelabs.com
 (2603:10b6:208:25::39) To SN6PR01MB4445.prod.exchangelabs.com
 (2603:10b6:805:e2::33)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR01MB4445:EE_|SA1PR01MB7325:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e81196a-62ba-4142-98c0-08dbcb82a238
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sEeu2BaRoglkufk6QLnOAvd5OOvkwK2kbJqI6gbfwJSgORxwo2jdTGh2MP1OT/d4J0KCc6tR9uIdERN74S7s+KG9IvQ5M/wSRaNxHn2s8PBX147sLrsMgmsFipsZfrTe0+wfBMKR3CCReBDSxZTQshFam0DvaudFjTKXvm7/MgFtRgVkJty9OsAWsEBDWJrKlpisenmxXxD5QqeH2yPUFF949WeZIPNk54nwCi5iPPPrFiqX9Xq93BkpmitPP8hxwDKYZdyf2dogrr3soAZuOxfOJMdsrTH35yFUcdPjjgPZPjQd8zZbm/K9Fh7W5AzhWWXB0aP/XYE8DQM22a2rXnaHIOX/jszn/zovmlQ/ZdSFWV6Q8eBjHFjJu2n7fFGZgWBcf515m+lPcCKEt66EOaMW65MXtqQ9wohzYwztMmouwfCWYFVYHtqJtQyHdi14G7riSb9r9POej2pbUUjrZb5GnBt1/b8LUhP5+90KhGMYbEk6LiqguS5H1vKHUVyVtAFpS1Hjjpj7lB7F9WnizRP66bAZTXhgvxJW8eMSZh5As2oG933PlzdNb9runNaFu+nbOgrA86kO2zbgdeW4JmyjLGtvCwAGSMZcCSCoBLc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR01MB4445.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39830400003)(366004)(136003)(346002)(396003)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(6512007)(26005)(316002)(8676002)(53546011)(6506007)(83380400001)(31696002)(86362001)(2906002)(2616005)(31686004)(478600001)(6486002)(38100700002)(5660300002)(36756003)(8936002)(41300700001)(4326008)(6666004)(66476007)(66556008)(66946007)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NG1MOFhGUWFGVWV3ZGJwVmRDbXdFQ3VPb2pVVkNseUFaN2o2RTQrRUNpRmQw?=
 =?utf-8?B?dE9CY2xVcjFyM2E2eFNMTUozc1hNY3VBVS9kRlcxSi9JdndNYkRHalkzVjIz?=
 =?utf-8?B?YkVUWk9ycjZlTUdZa3lwNk1UaG9wc0tGcWd0c20zaEV5WkoxNFhrNWJwRFZl?=
 =?utf-8?B?M1RISUQ1dWdQZEpROC95UVcvY1FVVWhXY2VHUGNwWGxVcHpsMWJsdHl6ZUYr?=
 =?utf-8?B?UE9lZ2s0dVVlaTI0U0M0NGZnUjRlZ3RHQWhYTENhdkJERkoxdXM2TjUrTUZV?=
 =?utf-8?B?VHN1QzJsWWlFcHVmTVR2WnJTSzhQNmI2OXFTZkNtZlpzcWxCcnE2S3YydlFN?=
 =?utf-8?B?TGRqc1FVdGxkcjMwUjlKUmo4MVRvZVNTSkJPUEpJVUU2b1habUUzYmlUMzBl?=
 =?utf-8?B?TU8rYzR3QkJNUlVaRkJjc3ZEMDlPeklsWENidk1vc1FWZG8vaGJvaTZJNmNm?=
 =?utf-8?B?Tjlibm5YdVVDT3QzZXBQWDl1dlRjUjcramZXWkZpNVg3WDRWRmlpcDRpZnFi?=
 =?utf-8?B?QlRuRHYxU3B6bURnKzFJeHhLTVg5TWYyM3lCSlkwNmEzaUVkSUNPRjFVKy9G?=
 =?utf-8?B?YW0xTGxIYTZsSjhuRys2S0dvTkk5TkVrNzBRSXNQTmNGNHpRSWd4SnJTTzda?=
 =?utf-8?B?WkFNWTI3LzFlSVBTMCtVbFg4Mk5PVkpta09DZjFmZklMdXB5Wi9Vc1RkQ2Vi?=
 =?utf-8?B?N1NqZ0hoZmJmSmZPMUFlU2JjcFlab1BCTjdpWi9jVk1zdnV2QW5kWkxCOXll?=
 =?utf-8?B?SHoyVDBLQW02T1lYVGlrMHlWdVlnNDN3WGZKZzlZVjU2d2lLcGhEK3FYT3BT?=
 =?utf-8?B?ZWJ5LzY3WXV4d3o5UUxFejUrdXdmSXpPbU9QM0t0L2plcG5SVTc5QU5qZmQ5?=
 =?utf-8?B?OWxRcHdoYWdUTTlKdkxQTTlyTVp5N21PcHZ1bzNRVktNYkQvcWwrNDZXZ0NB?=
 =?utf-8?B?eHBBbGdjUVlGMHpxZm5jOWRyQmx0OUxabTNHZ1pOUkdJSWx0cW8zd2lhUUtM?=
 =?utf-8?B?Rm0xS0RFZjY1c3Y3ZkkzZFZFWGFiOGRrbHVXQS8zRjJFMlFZYlJyK0lKMjBW?=
 =?utf-8?B?QnlIbW11ZGNkMks4azduT0NkK2pkSnNCNjBac1JOK2JJYTBldHZzNzlzQXZR?=
 =?utf-8?B?KzVwWTFhRVVXVXI2elM3amVtMCtQU2hVcmN6TFJTTXVDU3BNRTZDNzJEL3Zp?=
 =?utf-8?B?R29zbVlHVWt1NS82TndpUnIvMjVXR1YwdXhtMXQzYXlBRW0rZUZjdnVVeUZh?=
 =?utf-8?B?WUl6VWZGRE9PeW1KZ28yZGloT3c2NDVIb2owOGE4MWlxTjZoa1RuYTN0R1dN?=
 =?utf-8?B?SGRMUlNNcDlISWFnYUpSSmRHRklGKzZwb2czNmgvTkYwMnNEQWJ1VzFuOUlE?=
 =?utf-8?B?YlRFamxxMWZpZElab2QzM2xoUjN3MmNveHcrT2ZWR0trWml3Lzgra2hlaDJC?=
 =?utf-8?B?T2JZSkNBZjFBMzhMTmVhNTFHOHZQZlRlRnUvUXlJTGJmakQzR0dvcU1tN254?=
 =?utf-8?B?VXVEVVd6ZHlhU0QvcVlkL0I1eG9tSFhIQURoL2tDRzc3ZmZ5cnF5UGpjb0Ja?=
 =?utf-8?B?Mm13ckwvZDRsWlhOVWRMeitzTlJuSVNxcGZWdVpWOFQyaFNBd3JITXNvek1q?=
 =?utf-8?B?NEN4YTk0dFFoY3pEa0lkQWN5K1ZOeGRvUW14dmZ5UEI2TGgvSkhxZHVmQUtG?=
 =?utf-8?B?RXU4dlJOWnZoTVRrdUc4ejM4WHRDQk1pMGZWakVkWjhaQ2dJMVNKZnR5VmFv?=
 =?utf-8?B?MWhzTTVWZHN6Z0g2S3Q1QUdqOUI0VnhNUFM2NVFrMUY5bUxCV2NpbUJVaTBY?=
 =?utf-8?B?TU9MNFRnT3lvOWk0UUEwRkNnWHdnbkVUbWdQZDNWOEludDJzemFRUXZud2Jl?=
 =?utf-8?B?Ly8vRk0ycDFoVkhwTVlaMVBjdENGZ0NzUXVVS2ZGZzFIWXNiTkZNQ0V6dWM4?=
 =?utf-8?B?bTNuUkpROFhJcFJtNm9JbC9Ga3RKQzBmejZhWnAvRkpVSnROREJVQlJWMU5j?=
 =?utf-8?B?bVQrL296Qk9lRmJKc2c1aCtGMUQ1YUFGK1ByL3dDNFg1VWRyWHppUWs0T1kv?=
 =?utf-8?B?ZzA5QXQ4V1g5ZFAvNDgrUDcyQndIWThGN3VkYmNGNXR5MVdnREV5bmZGcWI4?=
 =?utf-8?Q?hXvk4d0yxYHX/6oCWODsGX9yx?=
X-OriginatorOrg: talpey.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e81196a-62ba-4142-98c0-08dbcb82a238
X-MS-Exchange-CrossTenant-AuthSource: SN6PR01MB4445.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2023 00:23:33.3027
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2b2dcae7-2555-4add-bc80-48756da031d5
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x/kS/2z9owFkSlKlWeiR0x/Z/mlt2NIoE+RyXtf6bKcYlApVMA5cOQR3WaHmEdSl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR01MB7325
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 10/10/2023 1:23 PM, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
> 
> When an RPC Call message cannot be pulled from the client, that
> is a message loss, by definition. Close the connection to trigger
> the client to resend.

This looks correct, but it seems there are actually two changes here,
it's initiating the close but it's also unconditionally returning
-ENOTCONN. Other similar code paths do this so it's ok but the
altered return value is a bit mysterious.

Reviewed-by: Tom Talpey <tom@talpey.com>

> 
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>   net/sunrpc/xprtrdma/svc_rdma_recvfrom.c |    3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
> index 85c8bcaebb80..3b05f90a3e50 100644
> --- a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
> +++ b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
> @@ -852,7 +852,8 @@ int svc_rdma_recvfrom(struct svc_rqst *rqstp)
>   	if (ret == -EINVAL)
>   		svc_rdma_send_error(rdma_xprt, ctxt, ret);
>   	svc_rdma_recv_ctxt_put(rdma_xprt, ctxt);
> -	return ret;
> +	svc_xprt_deferred_close(xprt);
> +	return -ENOTCONN;
>   
>   out_backchannel:
>   	svc_rdma_handle_bc_reply(rqstp, ctxt);
> 
> 
> 
