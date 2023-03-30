Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D88226D09E6
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Mar 2023 17:40:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233207AbjC3Pj7 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 30 Mar 2023 11:39:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233272AbjC3Pjr (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 30 Mar 2023 11:39:47 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE857CDF6
        for <linux-nfs@vger.kernel.org>; Thu, 30 Mar 2023 08:39:36 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32UEDt1r014180;
        Thu, 30 Mar 2023 15:39:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 cc : to : references : from : subject : in-reply-to : content-type :
 mime-version; s=corp-2022-7-12;
 bh=O9Ue6CYF2cuxcyh53twFNMh0rnGjbnYv2WBjGDgU0Ho=;
 b=VZvGG9Ghnn7Mqvd87Um1ZkSiNEIYyr9BkE8eG67xNutdLyc5X2NGKF9a8XBuLG1Gj/8H
 MQ4OHn7GbYah4OdopJyQy6rchCzOJ5MhzVXYb4TF4iiv7v+sCbIAwpggU/9iu32KBjGo
 htW8lyJmWy4lumFwZ0lw97oKrWNoPyK9+lF4h5sOf7xVxaH8awirJhc6R+aScnO62LtI
 mI9MDz+N+/PzmYxm6GRCkNmrgp36LAsEc3TDdq0JW03XgltNh7+MTL1dAjY/fw5tcstv
 Z81MvLm3wGa/wEcaawCq5dhWPZx5BIl1yZHL0nRWuuKUe6CqR5Expw9Sr+GxiaV/iVbH 1A== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pmqbyu0eb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 Mar 2023 15:39:33 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32UEkFqv036411;
        Thu, 30 Mar 2023 15:39:33 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3phqdhda4p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 Mar 2023 15:39:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ktM1FJw1rhj2tyPKFe5c0WiWJ6ymm9ySZjAv3nPaYRni5eDaC9cKd1kvYD+/XLfPa/v1gz9me8DeXyW6gOuYzXt0tnnTuOm/106DnXULEisVu/kY1QFSAKdPE8NbSbAaKsuDkMS5mn/6mutqHLEiIXQ5zDNAS7LcWGncVV+siVXFo6ksOFHcoHr63bx0dAlVtHMz/eM5jg0I8YeSEPeQxrfbxXVVjZut1fko6uIlEu/o+doigow5jEDOqDsABXOysz9ZcKUhP14mcF8TE0OgkeWK0L9GaBetfYgkYceDK/Reezc6mkrtD3esbiaEsHdDfJSmpSGSR+MuzC1GsUOPDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O9Ue6CYF2cuxcyh53twFNMh0rnGjbnYv2WBjGDgU0Ho=;
 b=QxOLy8LhX2QLDQVj32lllOLos+puYSsi1k3lmnNgJ3RWVMuPrwWok60jclVn5/38mFLkKVNbkmGc8jT8PQ6Ev33O7dAXFT3KDGq/95BFKgE4PWvxaL6PZ7WrzjdzV2Rulm1Cd29MpcG2ePYITpWtgZIgv6IPwK3MRMuY0PJ0OrkpXKU44oK+kej5lXYI1fXwL6mSPQSqGh6WncLuAszYpSWxydQwDiyjgXWBca/e36que0bPCk5KilAI3/cmODsaRLXa+/wq7igIzJxRhLEYX6PYxnMw+CBd/C35xqpUz+U49Q5W6vLczCdUQRXwCzNiG6HWjQ7Hyz5IWi114Y1iXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O9Ue6CYF2cuxcyh53twFNMh0rnGjbnYv2WBjGDgU0Ho=;
 b=sTCUIu/Miga3Gp29fTwB8RpzlydceHLeVabfodniQByaOZlju8idBGZMcRl7PooQ4ME2M/wxUDWtWBZ+jyBeaC0DGXM8Ny0qBYobpuyTVnGFta77L5sz/pJZpXDsUse2lNWrN9K4b2iqDkyMV0/rwwrz3C05Vpi7D6fbRmgWRT4=
Received: from BN0PR10MB5143.namprd10.prod.outlook.com (2603:10b6:408:12c::7)
 by CH3PR10MB7610.namprd10.prod.outlook.com (2603:10b6:610:171::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.22; Thu, 30 Mar
 2023 15:39:30 +0000
Received: from BN0PR10MB5143.namprd10.prod.outlook.com
 ([fe80::effd:a3fc:9fdc:a534]) by BN0PR10MB5143.namprd10.prod.outlook.com
 ([fe80::effd:a3fc:9fdc:a534%8]) with mapi id 15.20.6178.041; Thu, 30 Mar 2023
 15:39:30 +0000
Message-ID: <39687886-4503-3934-7c96-f0cf05c8da7f@oracle.com>
Date:   Thu, 30 Mar 2023 16:39:25 +0100
User-Agent: Thunderbird Daily
Cc:     Calum Mackay <calum.mackay@oracle.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Content-Language: en-GB
To:     "zhoujie2011@fujitsu.com" <zhoujie2011@fujitsu.com>,
        "bfields@fieldses.org" <bfields@fieldses.org>
References: <20230320015856.381132-1-zhoujie2011@fujitsu.com>
 <eaa53625-6870-cc38-fd40-4e938a833558@fujitsu.com>
From:   Calum Mackay <calum.mackay@oracle.com>
Autocrypt: addr=calum.mackay@oracle.com; keydata=
 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
 gx3r8uLHNg==
Organization: Oracle
Subject: Re: [PATCH] Add testBlock and testChar test request information
In-Reply-To: <eaa53625-6870-cc38-fd40-4e938a833558@fujitsu.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------0tlJMSw8q0k07ad7aBMgVZ2D"
X-ClientProxiedBy: LO4P123CA0026.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:151::13) To BN0PR10MB5143.namprd10.prod.outlook.com
 (2603:10b6:408:12c::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5143:EE_|CH3PR10MB7610:EE_
X-MS-Office365-Filtering-Correlation-Id: da68464d-aa98-4aba-4c76-08db3134f358
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yOpZH4CoWQGLE4HfgNUjN4t54oau70aYuGl3sVYFMeI0Bgb2y2uBZQBOiQRPL+240AoCC4DcVCXL/pqqyx2Ho9lz13/MFcWpTpbDClbKD1q/a46Z7ssp3w9+wpC20gIVFzhRf7u7YtnSdoRQwcjyLSzTQ/TBcBxHXfgjHkINhV64J2j22KdK6ZR6QlraosZJF5pIoah57RJO7Cm33zLjDQtcb3Zkx26lDVrgEfBP6JUXUH13xkvLbYW25P5rp3VHN1BUdWdxYMwmj0MUeneINvdWd1OjaFlrpXCl1ro2TWFIOfl10qC4nX6jfRvPOMnV6jN3+ES7PIx8gq39t9MDNcPPRxQ4pAceg8Y1TyehQFalNbtRI6nbu1Wk1y6T+tcrhq6I2sLvjxoRn4fth0wn16muaAwlkFkV6BHGX2QC1rN6/DZlKM/0hz6VN0GZPJwtIlAlczxW89+JfspY6aJCkLs8C/VZ4VzKPjFHuwfHKC7td4L0S/XQU9mTXGouzUwmO6K/ozuMMVItDK9G0nfbGfZC3MPMglTvsPzMDOyro7iH/OqmPTze7QmHKpvxKiV/bCQGyMW66AB9JPne4USwQ9QTb+P7PWtX7Jle3jQ+TNqPlE9vPzSiJKR2sa+uHSlrusdkm/Q+JviqB+IVUsmH+A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5143.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(346002)(136003)(376002)(366004)(396003)(451199021)(36756003)(31696002)(86362001)(2906002)(31686004)(6486002)(6506007)(21480400003)(2616005)(478600001)(36916002)(33964004)(53546011)(6666004)(6512007)(83380400001)(26005)(4326008)(66556008)(54906003)(66946007)(316002)(66476007)(8676002)(186003)(8936002)(41300700001)(110136005)(38100700002)(5660300002)(44832011)(235185007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MGRTYllyUDJzN3liSFRkM2FZaGsyTkhVcThIdHRBeDBmeHN2OGJhMXVLdTN0?=
 =?utf-8?B?Z0tyVHpsWkJaa2kvUE1KOURaejcwSVBVUjArb1ZaR0xBdTcralNhSWVOV1Az?=
 =?utf-8?B?RyswV2VaNkVqY0N1cXNseGR3WDhFcGNjeStGQU91UGpsblpUQWhrNWk0OHYw?=
 =?utf-8?B?aCtoejUyZXhaYm1zM1llSHNTTXZCWnlSeGFUc29xVFFpLzRuSm9lV0tsVVVB?=
 =?utf-8?B?UHNCMTdva2NFcUZUdm84TERLQmR0azRiK3U3OWl2TXM5ZTNmV1d5MEZCUkRW?=
 =?utf-8?B?Wk1UaFIyK3ZCdTBUOGRRM2E4NzlRODk2dHJVY2MyNWl1aCsvWGFrVFZrYWxo?=
 =?utf-8?B?TTdPMTlscmtEWmxjOEVUMGZVbEVEN2x4ekloYkZIN1hjV25QY3B3cDdQVkE1?=
 =?utf-8?B?VTN2SWRweTRjL05Rb3pBWEU3VzV3eTlJaUtvUktVbGZObDVITWltY1NZWWhI?=
 =?utf-8?B?M2FKQTFTS1NkUUU5Vnl2YWV0U21Xa205UmNYS1pmUzV5QXI4OEZEODQ2NE0z?=
 =?utf-8?B?ZEc2YmZ0REdUVVZHamxyblF1RzZOallrZ0gzVm5JWjR4TGkwc0I4alVZU3BG?=
 =?utf-8?B?MXpGSWYzbFZKU1hPaUxBbXM4bndOYVk5eXdQMmptbytsZjRPK1MxYUZFU3RY?=
 =?utf-8?B?YnhNeG1ZNC9lTUkxS0U0TTZuSENDQTJ1THhheFcvNUZya3JhaDdIakduK2hU?=
 =?utf-8?B?aUh0a3djUSs5TnlyNEE3YUZScFMxQjFBaHdLVmZXS2ZjaCtINkhWTWV1N0FB?=
 =?utf-8?B?Y2lQUFVEZW5pcnlHNTl5K1VaUjZNSEpVYW9IK0ZCMGVNUlVMdWFNaE5GQjVm?=
 =?utf-8?B?bHNKY0ZGRy8rZkMzUEt0aWxzY1RNbmF1Q3FwVWJaQWJPcm9sT2RlSlRxN0wz?=
 =?utf-8?B?a2R1czMzUEJsUW5iVzc0NG93NTJhSU1tU3h6Ly9IaHR0S2FCTVgxeUs4cG1P?=
 =?utf-8?B?V0VpcDJ0SmVpM043RnBRcGlxMm12WGMxNVk5YTlWNlJxRUxXL3RMTWY1aG4x?=
 =?utf-8?B?YWkvT2hqZURJRVlKQ05KY3ZoQW1BUy9FSjJxRWwvMGJtTkdJeDY0anVTcmVy?=
 =?utf-8?B?Nk5FMDJxQ040WGZpS29VeE1tN01heXdrMCtvOE5DNHNZOWozT2c5c09jNHhL?=
 =?utf-8?B?N09haDQrNkRlVW9ZeDREdEFRZ0JsU2xrQ1VpcXdFTFFsS0ZOTno0Zm1nM2ZE?=
 =?utf-8?B?bmxHajJOMngxcFd1Z1JVa1FhQ3laWUF0SzlGNHFLSWxvalhrN3FKZy9DUXkx?=
 =?utf-8?B?Z20vWERhdHYyRzBzeWFCU1dkNVAyWVdxdW1CR3RtTkl0QitqbmlQU1dpTGRP?=
 =?utf-8?B?a05rWnhRcTZ4d3lUVU11dEZnaTB4ZXlWeGlGQlJKblR4aE1vaE0zUjA3eHhX?=
 =?utf-8?B?MHhNTW9ya1ZrbmpDSzZuT0VJbHRDVTQ5Tm4yNWVCV1hZOVJSL2Z0ZjFjYk9K?=
 =?utf-8?B?OG5VQkNCcmZHV3VWbTl1MHZLSy9LYkpsVldNbHUyWExXSGFTMTFnSmx3YlZQ?=
 =?utf-8?B?VnUxcDdrYlhUMDZuZnRWN0RkcVFPSnRIdjhTL21DQytUcWxsS1J1c01SNld2?=
 =?utf-8?B?Q2grbnM0UUE0TDNQWTdaVS9rK3FMZXN5MUkwNUl0NVA2YlNNQVpNQ2xsV2x2?=
 =?utf-8?B?REFaaXJsRkp3Z3E3b3lzMTFuN1FJU2QwYk9EK2hrVWJ6QWRXUDd5YzZieFNF?=
 =?utf-8?B?U25yeWRnRi9Hd2tZV1czUzNITVZrSVFNeDF3aGcvN1p4UHU0OGxWT3pVV295?=
 =?utf-8?B?UzVHRkp4ZmNzMlVFMS84R01GVGloeUQ2YkJCMnBMcEhRV0tNWG9Fb2pUSVZ5?=
 =?utf-8?B?N1hWQVhtR1o0ejJXKzdWdUNUamhpZmh4SEp2NEFNN2JpRDJPODd0RXoweFBj?=
 =?utf-8?B?MUZYYmtVVFlNcFZKeE1neDdLeXpDVElEamVCdzZWYmRlQTF4SmJLYk1qMkc1?=
 =?utf-8?B?WnpFUC92SEVKTHRHSHQwS0htVzQvemI1NU9XTHRtckJDZUM3T3hEc2Q1WXhN?=
 =?utf-8?B?UGZXUFh0a3QybjZ1RDBza3V3YnhNMERtSDBvdHBFYkw3d1ZiK3V6Q1VkYUpu?=
 =?utf-8?B?MFVqVzdmb21XNzNja293SHkvUXFYWWhwa0E2Z3VYaEhUMlRucHRzb25ndmxU?=
 =?utf-8?B?cDNhQnpNaVVVK0JaVy95Rk9tOW9aQzZLeWVvb0FCMmhUS05sejNsbWxxTDFG?=
 =?utf-8?B?d0E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: XTCAGBQIJRK6GL8hUdUwMgcmAA0Fn+HseHWGdLNS6ShNggkeyhFJUj9E/iKnIKbzNDb6RmWwMKyOT6JKpWoSW62S5SN9c2Yuyj4uLcESH1VUFpC+FAUy1g9IcZwnDdpQZbaFRQmL2giLEnnrk87hc5Z0xKTJpQfKBLux6/GB5g1iZ+FHyFCGc9V87STJ11KEQ5mru+Cs3C+sQLTdjkz7ROmf4BjEReRyqqyqNZlKaCjQc+ZU9979AXn7Unke/bZ5DeRaElTQ1c/ncQc2wmVKdBlFQbyA/08AEuH7flSFZwYvmOBy9uMQLAYnWelhFVXq5oE0uKh+3gx9d+YBGXv8gX4GADRMWHJiVrmV1iWwYDQJBsRtq1dfOOvyznyOPn7p5qQh8yrUrtwopBPdtZtiMmkZuvIRC1Xu7HyJkjKJEQ91b+knCBTEAn767TiYDeM+syJF5cXyOn8rtbwpG2GcVYirzVVPxdO/ziIA29Z8FRa3Od+ZQs565XX1leAxP8Oj/Po2CGbkhKqs/dTQQP8+k67kOxfqT0PnLiELKXdNvMAcbDCGOW1lKx2+GR9hut68RRJa5sSiRnmlZtETkz4FhXh62piA6Xka6Y8eyP10fUToJlNZsnCytqYhK5NfKbH94wqXDKmzPGixmnlq8IfSc7AU0VbXh3qsNIFmdqo5pkGZwciz0+aGtjCj8CsfpbgDoBsNXLSGzOLEbyYnWqRBZ/gBW5eswyqL84Ov8VqUEsL5RYWlM2TK4SBS35OXESKaNdpKynJdHS0SfPheWNhj7aiukoVXBwJL9mci3Hu2NY3Q03R+8wFPd1F1AccHGgABACsyZ1wG3evXXXcc/P9bXA==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da68464d-aa98-4aba-4c76-08db3134f358
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5143.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 15:39:30.1125
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 04U3fEP0bd3iob+qq9QtN1qCaf1idbLmkHjZthqX27Mj68wpMvz408haVHTYGntSlb/eqiGetPbuJvSZIDg03w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7610
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-30_09,2023-03-30_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 spamscore=0
 phishscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2303300124
X-Proofpoint-GUID: f5KJ532WjcPhGc2G_t1kXSZxyX4OnLvH
X-Proofpoint-ORIG-GUID: f5KJ532WjcPhGc2G_t1kXSZxyX4OnLvH
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

--------------0tlJMSw8q0k07ad7aBMgVZ2D
Content-Type: multipart/mixed; boundary="------------pKGYINemTWQA8NzVGurj257Q";
 protected-headers="v1"
From: Calum Mackay <calum.mackay@oracle.com>
To: "zhoujie2011@fujitsu.com" <zhoujie2011@fujitsu.com>,
 "bfields@fieldses.org" <bfields@fieldses.org>
Cc: Calum Mackay <calum.mackay@oracle.com>,
 "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Message-ID: <39687886-4503-3934-7c96-f0cf05c8da7f@oracle.com>
Subject: Re: [PATCH] Add testBlock and testChar test request information
References: <20230320015856.381132-1-zhoujie2011@fujitsu.com>
 <eaa53625-6870-cc38-fd40-4e938a833558@fujitsu.com>
In-Reply-To: <eaa53625-6870-cc38-fd40-4e938a833558@fujitsu.com>

--------------pKGYINemTWQA8NzVGurj257Q
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMjkvMDMvMjAyMyAxOjE1IGFtLCB6aG91amllMjAxMUBmdWppdHN1LmNvbSB3cm90ZToN
Cj4gcGluZw0KDQpoaSBKaWUsIHRoYW5rcyBmb3IgeW91ciBwYXRjaC4NCg0KW0luIGZ1dHVy
ZSwgd291bGQgeW91IG1pbmQgcGxlYXNlIGFkZGluZyAicHluZnMiIChvciBvdGhlciBhcmVh
KSB0byB0aGUgDQpbUEFUQ0hdIHBhcnQgb2YgdGhlIGVtYWlsIHN1YmplY3Q/XQ0KDQpBcG9s
b2dpZXMgZm9yIHRoZSBkZWxheTsgSSdtIGluIHRoZSBwcm9jZXNzIG9mIHRha2luZyBvdmVy
IG1haW50YWluaW5nIA0KcHluZnMgZnJvbSBCcnVjZSwgYnV0IGRvbid0IHlldCBoYXZlIGEg
cmVwbyByZWFkeS4NCg0KQXMgc29vbiBhcyBJIGRvLCBJIHdpbGwgbG9vayBhdCB5b3VyIHBh
dGNoLg0KDQp0aGFua3MgYWdhaW4sDQpjYWx1bS4NCg0KPiANCj4gT24gMy8yMC8yMyAxMDow
MCwgWmhvdSwgSmllL+WRqCDmtIEgd3JvdGU6DQo+PiBTaWduZWQtb2ZmLWJ5OiBKaWUgWmhv
dSA8emhvdWppZTIwMTFAZnVqaXRzdS5jb20+DQo+PiAtLS0NCj4+ICAgIFJFQURNRSB8IDUg
KysrKysNCj4+ICAgIDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKykNCj4+DQo+PiBk
aWZmIC0tZ2l0IGEvUkVBRE1FIGIvUkVBRE1FDQo+PiBpbmRleCBiOGI0ZTc3Li5lNDcyNzA2
IDEwMDY0NA0KPj4gLS0tIGEvUkVBRE1FDQo+PiArKysgYi9SRUFETUUNCj4+IEBAIC0yNyw2
ICsyNywxMSBAQCBOb3RlIHRoYXQgYW55IHNlcnZlciB1bmRlciB0ZXN0IG11c3QgcGVybWl0
IGNvbm5lY3Rpb25zIGZyb20gaGlnaCBwb3J0DQo+PiAgICBudW1iZXJzLiAgKEluIHRoZSBj
YXNlIG9mIHRoZSBMaW51eCBORlMgc2VydmVyLCB5b3UgY2FuIGRvIHRoaXMgYnkNCj4+ICAg
IGFkZGluZyAiaW5zZWN1cmUiIHRvIHRoZSBleHBvcnQgb3B0aW9ucy4pDQo+PiAgICANCj4+
ICtOb3RlIHRoYXQgdGVzdEJsb2NrIGFuZCB0ZXN0Q2hhciByZWxhdGVkIHRlc3QgbmVlZCBy
b290IHBlcm1pc3Npb24gaW4NCj4+ICtORlMgc2VydmVyLCBiZWNhdXNlIHRob3NlIHRlc3Rz
IG5lZWQgY3JlYXRlIGJsb2NrIGRldmljZSBvciBjaGFyIGRldmljZS4NCj4+ICsoSW4gdGhl
IGNhc2Ugb2YgdGhlIExpbnV4IE5GUyBzZXJ2ZXIsIHlvdSBjYW4gZG8gdGhpcyBieSBhZGRp
bmcgIm5vX3Jvb3Rfc3F1YXNoIg0KPj4gK3RvIHRoZSBleHBvcnQgb3B0aW9ucy4pDQo+PiAr
DQo+PiAgICBOb3RlIHRoYXQgdGVzdCByZXN1bHRzIHNob3VsZCAqbm90KiBiZSBjb25zaWRl
cmVkIGF1dGhvcml0YXRpdmUNCj4+ICAgIHN0YXRlbWVudHMgYWJvdXQgdGhlIHByb3RvY29s
LS1pZiB5b3UgZmluZCB0aGF0IGEgc2VydmVyIGZhaWxzIGEgdGVzdCwNCj4+ICAgIHlvdSBz
aG91bGQgY29uc3VsdCB0aGUgcmZjJ3MgYW5kIHRoaW5rIGNhcmVmdWxseSBiZWZvcmUgYXNz
dW1pbmcgdGhhdA0KPiANCg0K

--------------pKGYINemTWQA8NzVGurj257Q--

--------------0tlJMSw8q0k07ad7aBMgVZ2D
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEE1GBbrQYgx8o9Vdw+hSPvAG3BU+IFAmQlrS0FAwAAAAAACgkQhSPvAG3BU+J4
NQ/+Ml9G3nbQj/n0xIUFJoS5iSHRj37+pXPvgn+1ajvAUn1fXoLhGNgZb8Fwxyl42rYv5NfvWXvB
kmfgH7xbPDXnaenkEieVZkPX9yXVFbje1n0Hs5zmrqSmLkbq3sZBYjtsySbETWF0NGV3TGJ75fA0
SMXigbhln5tcE3IcDW6nTLjCrFCClUaOdp1IM8uh3quBxON/qqFPOD77RjDATFkgDLZW5Ngdiyim
xbY7R5Dv7TlajMGG8OeC1kVa0R14rWnqtoRz6d11m1YfQ31/M3EiGw+X6ef9gFqKrim0OfWydQ9O
fEyLpTQ1mmfjZ4gxBhLVihmpUWYLlc+LzbygS5AXhsYczqXn4pm8YgawRz6LBL3LwxwRDmHqOv2E
llJ3ITYsUgexXz82oF71TfJo3muSyxxVF9XpmFwBPJHpvF7l2lQZPeVbnZ9NkRtIM/K9EIlyUXZ4
fPUg/lfBlT+LgYGZ7bD8xO0bBEPU32N2t/wYrCkwn7FQkRTftekuk6Adp2STV6qIlRzaNJixPSPP
zl8FwqSUrVDEIK+O3D0xp9FzQdl4mxcHqmbOfInMeAeiwLDuVKL9Ss/Azj5ycaOjTJbqelptdBqb
hO2xvPO3B5YGBe8yOll80cg5rPK0/J/hxKNPs0eH7Vrt+SQsNT4v0XxQ0diKwc4YoW5MzkIEm0Tt
6l4=
=ncQ2
-----END PGP SIGNATURE-----

--------------0tlJMSw8q0k07ad7aBMgVZ2D--
