Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44E3379C0E9
	for <lists+linux-nfs@lfdr.de>; Tue, 12 Sep 2023 02:21:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231705AbjIKXSQ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 11 Sep 2023 19:18:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240472AbjIKVR1 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 11 Sep 2023 17:17:27 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F4AD8A44
        for <linux-nfs@vger.kernel.org>; Mon, 11 Sep 2023 14:01:19 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38BJYkgS022357;
        Mon, 11 Sep 2023 20:59:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=beQLJZ5T+Q1N/Lg1lr6t+yov378eLsqRfW2OFEMBfjA=;
 b=enpt75mIaey5MxO/8gyv3cTouy21dSpFkDDyPUGzSVbSpChooBiPnuV7ekh3792hUcz9
 PHs2gesl3xMzJb1Qf32ELGh0r71mIMvMiQgWN2ERT5en2dxv5mKISv+b/aINctIfzYyk
 kCV5rzIYs8MNWe1EvBwfxR7eyJctM3AezGu4/tWt7emfSv7GWXJdXb/DwxgMCGyam+kb
 GNPudA+U4ljKgI27N8PLjJE/ncpqbl7YUYNwU2Ky9oA5VxYRns9PME/5YbpB7rjQu9JF
 FqryfpiccbCVvLWgdNe/232KbBs/sVRSdkpKzgFGD8VuYcEzhdxpDu2g1rGA9+pRG6Uy 4Q== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t1k4cae4m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Sep 2023 20:59:22 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38BKUA4s007582;
        Mon, 11 Sep 2023 20:59:21 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2109.outbound.protection.outlook.com [104.47.58.109])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3t0f54t1dw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Sep 2023 20:59:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R/l/pM253cpzrswSuS9+v2ee6MdahC9ehNgqbQ8US9miWsTMLFEmBijVmW/mok7pcrm8a5yAcgymrOdiWMlR7NXYqSqdW6lw10PE3dtEkgJMFSC/zS5mB2KopwHounWoqSHJ5ZI+PNkv23PCKQtQMWLn4jZJDbwxf9EW+9xNyFgcHex8Z28koAJt6VoF3mLATqzDjoAJf9mQiExyEuLZNB2iUizKgusewC40nG3+swObIPNBMlbqPkxIP6PojSw043PeiJV+XDBGoDOCl2nzN8XNXjFGVi70bGTiSioVkuLvzQ4/To52uu+dZ5X0XOydC3jn7vq0CaeZHzmZqeCT4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=beQLJZ5T+Q1N/Lg1lr6t+yov378eLsqRfW2OFEMBfjA=;
 b=S9s63VECmj+I8rgjpGoCKGlaHPUIjo+Q9/85Sq1DCrIaA17UJc5Om0NaWlR9cC5x2r2/wxctBdXfi86shV6CNek3koP2BD0jzOIjM+nTPARaeL9ZNojyeocVDZwL8qNUZxchsZ2ZB9euWUBJXOaCbhUl+pMu/HE7FwDtR5+1c3W4Ol4Fdes+LzYs4Knam7E1h4bgKzDQndneWJNkH5sfff9Y2rfa7SAH1ajXOnQrvh8bBY7OcOTMaKPMcz+L+Mpqx5n+zAFY8eLGofnSdcJJT7RRxKFu1S6WdWuJxfooRCH205xTVQFAz/LDfbwCVdG+MTOzWHirBTvm8Gufm3gyuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=beQLJZ5T+Q1N/Lg1lr6t+yov378eLsqRfW2OFEMBfjA=;
 b=D6gMAPMu7ljEsZe7E5J+v+/ISx7T32tvuHSXZIaw+ZcH3o0Bxd4UAYzO0RsSf6b4IZvC9TMR1Vk98CExoF3x5NnIce9qjSAUeg86P5WxrOFBjCFl3Li7j4eusJw8FRCt/aXEkNm1J+tpR/l09jDAerL/i/gTxbI3USWau6XcGho=
Received: from MN2PR10MB4270.namprd10.prod.outlook.com (2603:10b6:208:1d6::21)
 by BY5PR10MB4114.namprd10.prod.outlook.com (2603:10b6:a03:211::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.35; Mon, 11 Sep
 2023 20:59:17 +0000
Received: from MN2PR10MB4270.namprd10.prod.outlook.com
 ([fe80::c431:a107:b201:f9e]) by MN2PR10MB4270.namprd10.prod.outlook.com
 ([fe80::c431:a107:b201:f9e%6]) with mapi id 15.20.6768.029; Mon, 11 Sep 2023
 20:59:16 +0000
Message-ID: <f204d9bd-8b60-463d-5c59-9761ca25308e@oracle.com>
Date:   Mon, 11 Sep 2023 13:58:58 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: turning on s2s copy by default in knfsd
Content-Language: en-US
To:     Olga Kornievskaia <aglo@umich.edu>,
        Jeff Layton <jlayton@kernel.org>
Cc:     Chuck Lever <chuck.lever@oracle.com>,
        Dave Wysochanski <dwysocha@redhat.com>,
        Steve Dickson <steved@redhat.com>,
        Olga Kornieskaia <kolga@netapp.com>,
        linux-nfs <linux-nfs@vger.kernel.org>
References: <b1ae55f1c835ea6b30089a9377ae67c40d43a0fc.camel@kernel.org>
 <CAN-5tyHejgLNPrF-bybFqrkiEvvFb+SZ9NHne9RiQ0kVwESd5A@mail.gmail.com>
 <CAN-5tyFrNGFbb3Um_=SB0TYGcRoofn9vPqsbjQmNnBf3RkRpog@mail.gmail.com>
From:   dai.ngo@oracle.com
In-Reply-To: <CAN-5tyFrNGFbb3Um_=SB0TYGcRoofn9vPqsbjQmNnBf3RkRpog@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO6P123CA0022.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:313::15) To MN2PR10MB4270.namprd10.prod.outlook.com
 (2603:10b6:208:1d6::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4270:EE_|BY5PR10MB4114:EE_
X-MS-Office365-Filtering-Correlation-Id: 56379d60-d733-4fe4-efe8-08dbb309f60d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5L98R/l3wNahMb5Hn+XfbjfhRqFEMponDpmZfgewB17qI39aGARhA0D5sB05ouVOzMiE9BZWVpZdmAZzWiIjJcrg9I8raeBMYoJZktmUdRGNyMyLEaRCvK7x8FJJcHw3eVa6uyjC9937dCxurAGCX+/l3bygyPNarNDwRDNFTy65++Dei3eFBRF0vaTHH9Km4KY+vw+QwSEUUrGPIF0R1qJsRnopfzYf5GGSv/9ut00g0bl2qvlCYfG17GPSOfh0UYZv5kZBRNDZbe06MDKZP4URqPKf3SYWphZOsmLWfWbbGlwHXb1ueM8d0GPFV5Gyyr7LyQNwCvG+z1jqsotiKxibAMC6l+VW8M83X3QH8efUPBgEnhLgjcje+4lCmaR5MLWWeDqJVxxEmhBrpJcIZga8MDwz7+WkujJJYH4osg+MlR3qcZDwpSmuRoGoCn7sG2dCKzDYArHyr120/h7tK5de23Xjbv4WxyW4fBA6xMSwxTwhcQoT2DVW56iQctzh51i9OaoIbbv/ccR6FLXk30HvalW3uyNbCyw7AczKxaskpFVxJhQDt6hWlU3vBVf/vDbx6xF/n1DhaGFDGtVt1Z6yJFcg7F3dLOFXANu8dWXZrGGT1nHK0ltvEzJ2+gNYp66ex9USF2dydyUVEMu6Wg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4270.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(136003)(396003)(366004)(39860400002)(1800799009)(186009)(451199024)(66899024)(9686003)(6512007)(2906002)(83380400001)(26005)(2616005)(54906003)(66556008)(66946007)(8676002)(4326008)(110136005)(8936002)(316002)(41300700001)(5660300002)(66476007)(6666004)(53546011)(6486002)(6506007)(478600001)(38100700002)(31696002)(86362001)(36756003)(31686004)(17423001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RDRDRjltMml5WFRwdnNTS25FMGFaVW1wd3VKWnhMRjJXWDhSRW9VMmRkSHV6?=
 =?utf-8?B?L0hvYjVKbjk0cFphN1RNdzZNRWs2ZzBkZi9sQWlyc2l5aTQzbklIaE9UNUlt?=
 =?utf-8?B?T1ZVMzhkd1R6VDJrVmNCRlpjRVZCU2VWSWMyb2xYOTVVOStPZlFHOTFUMEZ2?=
 =?utf-8?B?S2dyYUs4SUtmU2FPWTNJNjgvY2JBSTJoTXFKUzdLQnRSQ1ZXZVVJM25sSXA1?=
 =?utf-8?B?NnV0b3RlVmJBYzZIbUFOOWluQ1ZjWUJCaS9NMldtRnp2eU5tTGdHL05rbGxV?=
 =?utf-8?B?V0QwYi9mTW5pSW1RSWlXRFR5bk5QVVJ4NlFOU2NGMEpQb1ZIWjFrZ09SZTdo?=
 =?utf-8?B?TG9tWTluZFVvYmR6eURGSHRML0NjK0REcnZmaEZ6NVMwdDhHNWZrN1kwRVNR?=
 =?utf-8?B?YTZUbW1CU0JQOE92WFpJZVJETWs0NHhIWTI2bzJiOEkzUWVNSkIySVlub01P?=
 =?utf-8?B?NDRVVHRsUGJZSlEzVjR4NjVQdmQ2M01YMU0xUzNRdnRReVFZeURlV1B4QWhP?=
 =?utf-8?B?eGdIblo4bzMwNExVQzRUeUgzYnh5TFMrRmEwR1lWSUVwaGx4aTZhNGZWRFdD?=
 =?utf-8?B?ZVVadXVyTXJ5c29NeGlINWx5My95UXRoSEREaEtpUkIyR2hpKzNWQWxidGlO?=
 =?utf-8?B?eHlNMnJXK0J2YWt5TGtIangzeTNSc2hVa2VuZy80R3hWLzh3dysydW9XZmxO?=
 =?utf-8?B?L1RVK1JIdFlhK3VscmI4WEZaVGRXT3R3emRZN1B0cXJidmpCUjdaUWh3RTR4?=
 =?utf-8?B?VXRKWDd3WjdrZGhlMjZERkdmWWl5ZGNHM2FWa2J3VG5lM25iMm5hd01QNGJD?=
 =?utf-8?B?eUt2d3RZUEZXbXd6VFRUQmViT1g2bmhJenBneFRsZGcwd0x5V3M2WVZxOEZL?=
 =?utf-8?B?V3RBdVVkeEVVcXJMcnNicmE1amVLdGpjZ2xYT2Znc0pvTWdva3JOZmcva1VT?=
 =?utf-8?B?SHhqMkRTM1Q4dnh0cFIvSVNlbXExUERlMmRpT1FoWldGVW9KUUpmYVdaK0p2?=
 =?utf-8?B?b3hNMENSYk5mUnVEMHJiSE5IR0JtK3NwTytGWUc4cFZDamFFRG5pKy8ralk2?=
 =?utf-8?B?RDNhMlJ0akJRa215QkFLQkNCVkRTZ3grTzRiRjR1SkQzRWhuajZFdjF4d24x?=
 =?utf-8?B?Ry9Ed0psOGhCc0xEMmI0TjZndXRiWVdUUlNXME5Sd1ZEYVVrYlJnQ25ndjR0?=
 =?utf-8?B?cWlXNzFtZGovemlrVEQvaWlWd3dnWnV3bVJINkhLMThUNHEzY1l6MlBxM3hh?=
 =?utf-8?B?dWNQakloSmVkcVNRUUZMNXhqRVJWa1Vvdk9IZXdVdTZYS1Z4c3loSktPM1Nr?=
 =?utf-8?B?UEJnRXZZNU9kaEpsN2ZtN0IwY0tuREMrdlM3WlBtWkpNeHU1N01wUGppWmRj?=
 =?utf-8?B?dHVEQU1McU5EdldYMFN0Yk4wYXZIT3ZPOTdhZ3c2Qk4vdU1VL1JVQWZTTGx2?=
 =?utf-8?B?NDBrSEoyMzlQZ0U2Z0h5cWJIWWVLbzhoSnlETmt5QzdCeWU3VXorUE1WZkFD?=
 =?utf-8?B?Y0oySGo5dFVGbjRmU2tmRkkvT0tic3BoR0kzS2tWcDk4S2VkWEZPYTVSa0NJ?=
 =?utf-8?B?dUN6bGlQSVNGbm1COXF3Tk5Iell2bi9UTjFuVnFWYjlZTy8vYlE4Q0NMZC9k?=
 =?utf-8?B?VEVKcTl0R3U5S1krTmJKTzJHTXcraUExZUtXdFVhanBuTVdpajgxaGlVZHZu?=
 =?utf-8?B?OHNmL1JiZmkvcHJ0b3BZK05rWi9SRUNZVDBTZEtzRkVSL3I5aDRoR3dCcHNs?=
 =?utf-8?B?NXk5eVl1TFd5eGgveGVxcVpsaWdPaytML3BvVCtZOFZzSnptZXQ1aWhBYWk0?=
 =?utf-8?B?UXZvSTl4cnFYNUlMVVNKbWVkRWJiSk5Ha040d0huZ2x1bXdsbmh1UFN0c21s?=
 =?utf-8?B?ekpJalk4K0x6WUltUkdpL0NhUUc5UlptZUFGOWtuK0RzVEVUbmpSSEhpVTM4?=
 =?utf-8?B?eUtmVXE2LzVxSzB4RkxNVDRhQ2hDQVBCcksrUXhndmNIMVBPeHRhbkdwZWFU?=
 =?utf-8?B?WEczUjJkR2FIaWx4VFdTL3E4d1hsbVN0WUJBeHVsdElta0lvZUlCUTZIWUhk?=
 =?utf-8?B?a3hUenhpa09HUi9FdEQrYURlM3RVTi9ORkFvOGd0K1VPQ2FUQnRISmxYa3dk?=
 =?utf-8?Q?89AVFHaHkWda/E8s3LG/hlq+L?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Ai1CWvOtEXVDIqW/YC33Tm5WlemdMpvezpmnbkVuNEPLEz+B9+U0jMoXagpS+HzASU3ccyrwHQN911FqZJt8iAeD5+GsihrWyiv63pycRKCTYqzg+Sq+zjZu3GKpjYW3qBChJF+TNQDAt8FJr9Zuo6xd8jueJl4WdDHbxwg7L7Ahu8h/w6vuNFJR8bwG8/bGdT275zWUxQUYMbCd8JOfZIxWkuZut4gi4c8EGGTZsko6N/E+iukbwL4V7sbTqO5wmn1leXvg5s5INGvpW9/8140pY5zG2D1eWZLeu1dSpGfZ8YU0CFwNAp3/UjSqOgAVWm7uEmbJ9wMN8kq/Folj+aop5SB7qL3IBhmif3JMsGy450XNv0fOTYwkf3wyNZDprJJsUjGeKUpRpx/GJgluEZJ+TpWMaZ4Jdnz3mQXbUgzL3P2MY6b2IORWQ1o5T78kIt9NJOm9RYpP0zhjzbeuHt0HYYuRQvuFvjPeadtS06PCLv3PW79mtvTDJy/jaQfdoxrfBmY0ILaHstdsTmmaNHH0Q/ZreyspLGQlOBrR+tKP2eNUUrNMx8F+XIceQqtQBX5LBmAbrkq2KYq5ZQdvzTIY5rgZ3SqChSdADN+iJlT3Hgf6a4HepBY0/thILTCV7LZHxPe2sbV4STWcMZqFmqE9P1jmBjHcpbNGw8EsvyvD1oinxHuCTLHz9j2lik6eroQis8rks698WMghD9WdZEhBSBOG5N31/UG8FsBlXYo0+vyG86C7jrO7oDxrjiswRTh7rzZSLrzBjqOoP1oU+UMve5ib6a9DlQLN2ZMt+I4oeBj5Jiw5aJWUlD7QoJDGxsep/fEPjml7SK0OFYqbO57rD9anHSKylWkCBVx54XOyh+4u7rSzE5BISEmKm1Gp
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56379d60-d733-4fe4-efe8-08dbb309f60d
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4270.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2023 20:59:16.8535
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6cW1+1TKt0t4eUI5mwYmFmBSMDDaFcxHmpEP4gEOqb0V77wfE3xBuOB7Qq+Q2WNCzi4kmGEL6ThMglABkQgYHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4114
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-11_16,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 spamscore=0 mlxscore=0 mlxlogscore=999 adultscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309110193
X-Proofpoint-GUID: ndrZD5OHC4OK5-UyiJheXMn00XlYpFR3
X-Proofpoint-ORIG-GUID: ndrZD5OHC4OK5-UyiJheXMn00XlYpFR3
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


On 8/18/23 11:14 AM, Olga Kornievskaia wrote:
> On Fri, Aug 11, 2023 at 10:28 AM Olga Kornievskaia <aglo@umich.edu> wrote:
>> On Fri, Aug 11, 2023 at 10:23 AM Jeff Layton <jlayton@kernel.org> wrote:
>>> Chuck and I were chatting yesterday about what it will take to make the
>>> inter_copy_offload_enable module option on by default, and I'd like to
>>> start working toward that end.
>>>
>>> I think what we want to aim for is to eventually deprecate the module
>>> option and have this "just work" when the conditions are right.
>>>
>>> It looks like main obstacle is this (from RFC7862 section 4.9):
>>>
>>>     NFSv4 clients and servers supporting the inter-server COPY operations
>>>     described in this section are REQUIRED to implement the mechanism
>>>     described in Section 4.9.1.1 and to support rejecting COPY_NOTIFY
>>>     requests that do not use the RPC security protocol (RPCSEC_GSS)
>>>     [RFC7861] with privacy.  If the server-to-server copy protocol is
>>>     based on ONC RPC, the servers are also REQUIRED to implement
>>>     [RFC7861], including the RPCSEC_GSSv3 "copy_to_auth",
>>>     "copy_from_auth", and "copy_confirm_auth" structured privileges.
>>>     This requirement to implement is not a requirement to use; for
>>>     example, a server may, depending on configuration, also allow
>>>     COPY_NOTIFY requests that use only AUTH_SYS.
> This spec wording that it's required to implement but not required to
> use makes me ask why is it a requirement at all. Anyway...

Yes, the wording is confusing. My impression is if an inter-server copy
implementation is to be secure it needs to implement the RPCSEC_GSSv3
with structured privileges. However the use of AUTH_SYS is also allowed
if security is not a concern for a given configuration.

In fact, from section 4.9.1.2 Inter-Server Copy via ONC RPC without
RPCSEC_GSS:

     ONC RPC security flavors other than RPCSEC_GSS MAY be used with the
     server-side copy offload operations described in this section. In
     particular, host-based ONC RPC security flavors such as AUTH_NONE and
     AUTH_SYS MAY be used. If a host-based security flavor is used, a
     minimal level of protection for the server-to-server copy protocol is
     possible.

     The biggest issue is that there is a lack of a strong security method
     to allow the source server and destination server to identify
     themselves to each other. A further complication is that in a
     multihomed environment the destination server might not contact the
     source server from the same network address specified by the client
     in the COPY_NOTIFY. The cnr_stateid returned from the COPY_NOTIFY
     can be used to uniquely identify the destination server to the source
     server. The use of the cnr_stateid provides initial authentication
     of the destination server but cannot defend against man-in-the-middle
     attacks after authentication or against an eavesdropper that observes
     the opaque stateid on the wire. Other secure communication
     techniques (e.g., IPsec) are necessary to block these attacks.

     Servers SHOULD reject COPY_NOTIFY requests that do not use RPCSEC_GSS
     with privacy, thus ensuring that the cnr_stateid in the COPY_NOTIFY
     reply is encrypted. For the same reason, clients SHOULD send COPY
     requests to the destination using RPCSEC_GSS with privacy.

It seems like if krb5p is used as the security service between the client
and the source (for COPY_NOTIFY) as well as the destination server (for COPY),
and some form of encryption is used between the destination and source server
then this would provide a minimal protection of man-in-the-middle attack.

Since the spec suggests IPsec is used between destination and source
server, I think RPC-with-TLS would accomplish the same purpose.

The use of krb5p between the client and the source and destination server
would not add much overhead to the overall copy operation. However the
encryption of read data between the destination and the source server
would add significant overhead and might defeat the performance benefit
of inter-server copy.

Also, is allowing the user to decide the security flavor between the
source and destination server the same as letting the user to decide
which security flavor to use for a regular copy between the client and
server?

-Dai

>
>>>     If a server requires the use of an RPCSEC_GSSv3 copy_to_auth,
>>>     copy_from_auth, or copy_confirm_auth privilege and it is not used,
>>>     the server will reject the request with NFS4ERR_PARTNER_NO_AUTH.
>>>
>>> We don't (yet) have GSSv3 support, so we'd need to implement that in
>>> order to make this work right with krb5. Has anyone started looking at
>>> GSSv3?
>> Andy Adamson way back when implemented a draft gssv3 implementation
>> and I believe we still have those patches. Anna periodically have been
>> rebasing them but no more than that. I believe there might have been
>> even some patches for the copy piece but I believe those might be
>> lost. I'd have to dig around in my oldest laptop.
>>
>> I'd like to address some other questions later as I'm out of the office today.
>>
>>> Incidentally, has anyone tried doing this with sec=krb5 in the current
>>> code?
> I'm not sure I fully understand your question but yes the COPY would
> work over a sec=krb5* mount. What is not there is fulfillment of the
> requirement to make sure that the client does COPY_NOTIFY over
> sec=krb5p gssv3 regardless what mount flavor was used originally.
>
>> Does it actually work? I don't see any place where we return
>>> nfserr_partner_no_auth,
> That's because initial implementation followed the spec wording that
> it is allowed to use auth_sys and not enforce gssv3.
>
>> so I wonder if we need to fix up the s2s COPY
>>> authentication and error handling?
> Yes the server would need to be change to enforce several things with
> regards to the COPY_NOTIFY and inter-server copy processing in
> general.
>
>>> Another question: The v4.2 spec was written before the RPC over TLS
>>> spec. Should we aim to allow this to work by default if the client and
>>> both servers are using xprtsec=mtls and are secured by the same CA?
> Yes and no. The fact that COPY_NOTIFY needs to be done over krb5p to
> insure privacy/integrity of passing the structured privilege. But then
> in order to use the structured privilege a new operation is used
> GSSv3_create which makes use of that. this operation must done with
> gss privacy. TLS is not a GSS protocol so underneath the only choice
> is krb5(p). You COULD layer gssv3 over TLS but I'm not sure what would
> be the point of that.
>
> So I think the real answer is:"no" we can't use TLS here. Or need to
> update the spec with a new way of doing "inter" copy security over
> TLS.
>
>>> 1/ the client and servers are all using GSSv3 with krb5p (or some other
>>> encryption)
>>>
>>> ...or...
>>>
>>> 2/ the client and servers are all using mtls with certificates signed by
>>> the same CA
>>>
>>>
>>> ...I expect we'll probably be able to accomodate #2 before #1.
>>>
>>> Beyond that, we could allow for module or export option that still
>>> allows s2s copy to work and relaxes the above restrictions (to allow
>>> people to use it over plaintext with AUTH_SYS on "secure" networks).
>>>
>>> Anything I've overlooked here, or other thoughts?
>>>
>>> Cheers,
>>> --
>>> Jeff Layton <jlayton@kernel.org>
