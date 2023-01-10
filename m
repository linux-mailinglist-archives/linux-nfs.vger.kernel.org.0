Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5AE366475F
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Jan 2023 18:26:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233353AbjAJR0N (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 10 Jan 2023 12:26:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233222AbjAJR0L (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 10 Jan 2023 12:26:11 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89B3318B09
        for <linux-nfs@vger.kernel.org>; Tue, 10 Jan 2023 09:26:09 -0800 (PST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30AHNwo3001004;
        Tue, 10 Jan 2023 17:25:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=GS9Y65y5kUU9HP1cDjSLIzkfi4jirblxuRf/Brcw3FQ=;
 b=H8r/AQ+aBKfSouTH+7oT2hrE9a9gAogbkLwxHbbvXmclgbCxEV7IDCViAJhNSjZg9QKs
 EZKeAVAZTAXP4NWJQMquYNIYyYpJ2sBkcDhWMnKYe/WF+VFJ62wOvAs88qrdKRGAVZP4
 zlTbk59e0lB26bzdqSVkQXvTH650O6YKy/NDoEInJRZ5yZ49dtiaJzJjVuKPZ4xs6rJe
 4wlQ30wswVYzOYBKxwum07+cYKdl9POeGBSM76aMgBIVxryzOEm16azBK6Ps5rTdZWDu
 dWg0rliXSbJcxN6Ul/kKX4ot0tqYthc2nkaS7zBCq+eJRskNlcIHsOwr6QvqTdd8a96R Vg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3my0scdw0p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Jan 2023 17:25:56 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30AHFWUX015133;
        Tue, 10 Jan 2023 17:25:55 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3n1b79mmck-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Jan 2023 17:25:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RxWZTakRs++/QoFKoccX33vf9OtG418FPDZOWVIz+svXpzlmv/xd6+tfEpQF8BIxIeB+IGQMKXgaSr5P3Vj+woEwehWmUOHV6kQNQLsXiciCJERaqyra0yIWHBZXbZ+qft2uo5H6QABJmpd6T0fh/VEbBBJdlllQ0f8feQ+DZULe8Aiy0nG+4OnjpXItuDoCmPROdrcHgipVJaxq7zgUq81x/TDDG/syH4N4RseeFZmr1DKaQwLidD46TY+ARp9+GtE6lA7xsSwbWuhbz942+t8ph3bFavu47Ptw3mDtazps2U95XAx35nuy0mJAurVVvt3v50Ic07JKbJRVLMDx+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GS9Y65y5kUU9HP1cDjSLIzkfi4jirblxuRf/Brcw3FQ=;
 b=GTrwjIFUCsoM9ld8Z9UxuMbcWgeR+TCKvC3WDEgNUntR2dmoSqcPn1JxY1uTx4O1LGtkNReSUBVgPtWlWs7C2f2GAJxOafB5Yi/dOmXPUWtIFHvM7MXLdXyTpkCOdyqgoWXnGhHxKpKk7PPzfQdlykI+h407V0cQyMCtjElYhWIJc4BmNMHxsN7Hz33lwxjdZRPd7pyzpIc6okiT22RPvGOv1sAbn9DWBveDg7ko9WBLzHmZPE223QXvNK0EvngMlvEbtVdbV3FOAQDug7wJVfm8v+0kkoEBm1mU8pk6onozXVpzUDvcEdY8zylIVauLMZuRoLwIQFKsdwg0AS7T4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GS9Y65y5kUU9HP1cDjSLIzkfi4jirblxuRf/Brcw3FQ=;
 b=yL5fttz+QGrlQg4yapAFhXdMxzhmVi/PRCLNmSWaqm9w/MsLjjywRSpkqmPaFDHgGd9owlHn4m81QXTFDh/TRhFk1yYZP5Tl/1pjQbDGxcsZVX8WtyYHMxDdEmh4Ld4/fU3rpKVUfYGqhzc7LVUudKeCQJB0h7w4QIbEGhm5/z4=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by SA1PR10MB6661.namprd10.prod.outlook.com (2603:10b6:806:2b8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.11; Tue, 10 Jan
 2023 17:25:53 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::940c:19a:12c5:e152]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::940c:19a:12c5:e152%7]) with mapi id 15.20.6002.012; Tue, 10 Jan 2023
 17:25:52 +0000
Message-ID: <72b4e7e9-93c9-6f49-9e08-3fab14f8ca67@oracle.com>
Date:   Tue, 10 Jan 2023 09:25:49 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH 1/1] NFSD: register/unregister of nfsd-client shrinker at
 nfsd startup/shutdown time
Content-Language: en-US
To:     Jeff Layton <jlayton@kernel.org>, chuck.lever@oracle.com
Cc:     linux-nfs@vger.kernel.org
References: <1673332991-24406-1-git-send-email-dai.ngo@oracle.com>
 <8b456fe7a351b861a29186a421afdee57bd10309.camel@kernel.org>
From:   dai.ngo@oracle.com
In-Reply-To: <8b456fe7a351b861a29186a421afdee57bd10309.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7P222CA0022.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:124::7) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4257:EE_|SA1PR10MB6661:EE_
X-MS-Office365-Filtering-Correlation-Id: 9daec111-a3ed-4144-3d81-08daf32fb961
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nXizEVSutW9hdlTH/gkF2nLfpCp12jnSmvHqRUuqItxux8IU9qmuz4USVgWka/N4Rhs2CW0wemqliifMqURskTBXljcvoeim3bhMP3Y2NJYFvvLO3U3KYPAUJL+aB9f/1f45GYXqSJWYPX1YV+l7Gp7gH/xLLTzneTgH/xh3D7B9isK5dxZhqlg4XF9l/q/OI/t7a02ERDM3m/KRO8O6yGm2+uW405ijneNOF/CiFbOBz1a97m1NXFFryxx/tv0nlVUmX3cOfgNe+NoPOe3dVJmRqI+5fYlNE6JhzR659wHyswPXT1zn5BdfAdrr4VhA5m+y+soQbdNXaMB8yDSi6WjF+1TDqwez3FmZYsBLyQTwkvh5VwtqTb5ge1VYzpAFtS3ktfZtH00OT4Us87NCVi6YVSKYKf3rlwHB3rK/O0vOBp0Kqpi6npqoj1jmN+JNlo29KGqGaluUkqIqCWc+Qekx81EdgRL8uixfp93wVtDx5NXt6DRHvpZOs4lcEyR8JG9VF0gA8YZcQPMDBB94sINR0ffhLsd+cqfLxl28EqnfagZki3PHzO9XcFJF/Y/VpilB2RP0WXiH573TFhiC9agHYV0sBulJFHHLtnD0eidssvg2qvjQzuOmtXnw0cUpAOuYTIhrTPor9MofIkbs5Od2r9k1fW+eNcC2NtWbsTibyziU1twO2v8LOyQtu3SQ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(136003)(39860400002)(376002)(396003)(346002)(451199015)(2906002)(31686004)(5660300002)(53546011)(186003)(8936002)(9686003)(6512007)(41300700001)(31696002)(36756003)(26005)(66946007)(8676002)(66476007)(86362001)(4326008)(66556008)(38100700002)(478600001)(6666004)(83380400001)(6506007)(6486002)(316002)(2616005)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TU5HRWpWWFA3dkMwMCtJbDBVSHZ3OFQvSkIwL2dMbVNZbGgvSVFERGRpS3ND?=
 =?utf-8?B?VnVhK0hQamRtYklPVFByRFJjd0F1eFlsTUp1UzQ3OWhSQmlHbldpb3NzVGRG?=
 =?utf-8?B?bEU0RmtvMkhvZzUvdHhLUnVPRHZjU29NZGMzVTl0cVE1NjlMUDhBZ1M1SlJQ?=
 =?utf-8?B?TVpuNUhDd2dnb1d2Qy9tKzFKQ0J1UytmbDFEc0Q3VWozZ0pSZWlxc0p0U0Fq?=
 =?utf-8?B?azJ0dktWNlFFVGtsYVc2NzJnNDhoeld1blhFYWdyY0RJN0xyZ1BJeDQ1M1p0?=
 =?utf-8?B?OW8vbG8zMmQyeUU3cDFwK01tUEo2VThLYk9CbU0xYU9lSlZ2RVcwWmpYbGg4?=
 =?utf-8?B?K2pBVVBkbVd6U3pnTFg4bFZGRTZRNVdQUURVK3Vod3E4amVWMFIyV0VQdDJR?=
 =?utf-8?B?RlhCcFlZNkt6Q2IzRXYydDBqSGt2a094K3VIeDZ1NVdNNmt4aVRLNVkrenBO?=
 =?utf-8?B?VGxDYXQ4SlJNOEpjdlAvZTFHeXlmWUlFUm1STThwMHFkaTg2U041NHV0ZzRC?=
 =?utf-8?B?OG8rQnczZEtjTEJIdDFzb0ViNXRQNUpjRjdrSHA5eWpSK2JyQXo5OW9VdGdr?=
 =?utf-8?B?ZC9EemhPdDdXdXdENDZ1WEloQnMzTENaM0xGVlpHVUNpRXBxOFl5THZqRjQ2?=
 =?utf-8?B?bEVKSzhFZXN2TzJyVTNPUGh1MVUxR3ZCWmZKKzR1TTl5aXJNdlkvbEZSUS94?=
 =?utf-8?B?QUdjWHZhU3hLZS9uOWtmWXB1V1pkVHRmMmZiczFZWUxvWFVjZjQ5VWpOVWxV?=
 =?utf-8?B?ZTJtZTVaRWNaZFBMMGxIZGNXdmFxOTFEL0E5Q2RZNmVaZk1LOHNzczBXRnRp?=
 =?utf-8?B?OW9sUGU3NG5KVnRzd1B3VEpUaC9WYUhrcWNOZjV1RWlIWXhtK2ZTS1dJNHQw?=
 =?utf-8?B?RjkyTmtNMG9BeVd4Q2ljYktFTnE2S1VZc1ZTWkZoQnhZRmVyWi9DSWhiOXFG?=
 =?utf-8?B?clV4ZGpvSTJMYW9XemNJcExWM3g1MExxSlJSZ0g4OVVJaUlaR1BMdStjNC9D?=
 =?utf-8?B?RVdNNUVCQ0dra3NDZmUrYUJXaWd6QWJRQjlUaW5HUGtMaW9pOGhieVlFR3J4?=
 =?utf-8?B?VlRnN3NmV2VsWTIyMUEzMVRpSk9oeVYzdlN1OGhId1ZlZHZ1dEJRa01NaTR4?=
 =?utf-8?B?T000RFUrd2t6RXNNdm9JY2o1Z0g1cS8wbHFSVTloL1Z3SjI4UUE1Sjk3SnZD?=
 =?utf-8?B?SUUySmNaT2NuLzlTNEhOSmE0K0R3RFZhL044VTRDb1ZoSGkwMWtRRTNvODU3?=
 =?utf-8?B?eHVWcjBIbGpPTHRYbm1EL3prSjZ1L2d0aFVSZ3ZKalFlb1RWbkVJNXBjZHkx?=
 =?utf-8?B?cjlyUVc1YU1qUWxLaXRWTzRIS3BCdjBNUEkzU3d0SVR4ZVgrY1g1MEdqZW1T?=
 =?utf-8?B?bUdJSjBkUmMyaG9GeXdpbXdCZ0hBUVhtTlRFMUhHZnVDdWZneURIWUFaS0dr?=
 =?utf-8?B?THh2T0lRbGp4V05GOTVuNVlicWFFdDJvamQweVR1TXgrRG5CTlhvektrTU1W?=
 =?utf-8?B?N2xtTGswK0FaRVgxTlBmSEdjUnh6bnFZaTJ6SURDYjV6RURLYnI0UFBKQW5Y?=
 =?utf-8?B?OEw5OXZtOVlmWFFrc3NMd0dhUHhxbm5EemdwN2cyVXI3VUM4RnVxdVliaTFz?=
 =?utf-8?B?enUrN0RYeVpicWZTTDM2WGxpdkhnSFlabmJVMmhqK3dJVDB2QUd2clAzSm1w?=
 =?utf-8?B?SjkwWnBNR1AybXdxQXRtdmNCSnFmNW9tbk52WGJZeE9TVnR2RkQ1SnI3d0t4?=
 =?utf-8?B?U1JIV2dSVVlDRTNnTGFFTUhrTlNSSHowT1Q1NnVXZDZxeVJEbTAzNVgyc2Yw?=
 =?utf-8?B?Mm9PS2NsMHNNcU1JN3A2WEp3d1NrT0R5WjNWdkNqZFNiMjE5cXFXenFrMmxR?=
 =?utf-8?B?SzI3UG1MSFd0UUhkd3hsUFdnY2llYUZxRk1BRmQvRWdjYVRybTZkQ21KOHFy?=
 =?utf-8?B?UVhNUXZLZUFrZU1LTFpGOW5LSjZkc051Z2s5S08xQ1lCZmRsT2lzMlZHcEhw?=
 =?utf-8?B?S0ovZE43R2JhaVc3Zm1yUU5PWHhUQWVra1F6clBEVUp0cWtOdm5yR3haZUlR?=
 =?utf-8?B?WHpsb05FVGQreFBMLytvblpWeGdrcG15VXVxS1FZdDdvSEZYMXpaZFZ2UXZW?=
 =?utf-8?Q?JVF8mYV/xB1eAOriUZRBdjKdI?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Mav1pAdKFe7qrgDM+fbSLs6MjIuiVsX+P3TdPLpvBC+697/virMdZFzJ/fVm56Ec997WxyEgIzDGGS4MJ1W7qyYGYILpDFRUZjsnRxmia8bl7SDe1ipcoojfH3crzpgk439qxsAgjZkB77US2DfcBvSxYv5XzKZvl6hCnwT6AiKtUSYZeia7HHFyng62GyaZdzzezAMstT9mXnSZQDj15OB73ksHgpYWy6UrSgstuy5BjuArbg7bR5imRYPiCb3xzte/i1PDTOesIoZV0tecwJ/CV6cyKRkZss0D0Rabc07bdMCDMVhTYfO2fb3/p2zs2rN1WdZl1e0iLDISMWqtKU5Os5oAJEBRj5yJaR1vJtiUOqEYw/Cs1jKocnDew0efKcZnA0dfbPflr830ZZc8iVpxhL/kRaXY4LqecnQSy37q8VK7foBZJxA4MMo8AlBCtO5dAYsysssq+19I7RnHgEVaNqXlIVTv3OJ1sVZCrCbTtXVcaO3ECXLJ39FWVbAPa3gNtgVm8VKO9deelgQK3H9RHWckqWy5zZot5YSvsAqczBB0E6cRFPhJerc9u29+yyapj3tu4tuFMZm+56z/4wOjKAFlvOHvGqeXRjJJlJ8MpHU2onoqOWhibHqDosrR6li3e1icElALfeh7hgecMevwxvIBbCv0ZfEdgvCOGXvqANxa0VcYUdwU5ZInv9xEsibGi5OmOHuO3PSZ7e8AOToy6pUQ4nyJWy9vcENo+XN2RJJ1z2yUp6/QURc1ZrIESMNnyRH9D4bT3OYU6wGRz/AFy/oaVFd3Vbbbw5e7g0U=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9daec111-a3ed-4144-3d81-08daf32fb961
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2023 17:25:52.8809
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sWf0NmhMYlHL/dIXIvqQi1MeKPuGYXu/uprguaoP51uwEVqTqXNDWO2JeG7haITz7mKnQ0C0z6QooBQaOBqAcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6661
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-10_07,2023-01-10_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 suspectscore=0 adultscore=0 spamscore=0 phishscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301100110
X-Proofpoint-GUID: A-ocHAy_AbBGgwdon3kcYXTiBMMtxqI-
X-Proofpoint-ORIG-GUID: A-ocHAy_AbBGgwdon3kcYXTiBMMtxqI-
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


On 1/10/23 2:24 AM, Jeff Layton wrote:
> On Mon, 2023-01-09 at 22:43 -0800, Dai Ngo wrote:
>> Currently the nfsd-client shrinker is registered and unregistered at
>> the time the nfsd module is loaded and unloaded. This means after the
>> nfsd service is shutdown, the nfsd-client shrinker is still registered
>> in the system. This causes the nfsd-client shrinker to be called when
>> memory is low even thought nfsd service is not running. This is also
>> true for the nfsd_reply_cache_shrinker.
>>
> But this patch doesn't move the reply cache shrinker. Do you intend to
> do that too?

yes, I plan to do that soon in a separate patch.

>
>> This patch moves the register/unregister of nfsd-client shrinker from
>> module load/unload time to nfsd startup/shutdown time.
>>
>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>> ---
>>   fs/nfsd/nfs4state.c | 18 ++++++------------
>>   fs/nfsd/nfsctl.c    |  7 +------
>>   fs/nfsd/nfsd.h      |  6 ++----
>>   3 files changed, 9 insertions(+), 22 deletions(-)
>>
>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>> index 7b2ee535ade8..ee56c9466304 100644
>> --- a/fs/nfsd/nfs4state.c
>> +++ b/fs/nfsd/nfs4state.c
>> @@ -4421,7 +4421,7 @@ nfsd4_state_shrinker_scan(struct shrinker *shrink, struct shrink_control *sc)
>>   	return SHRINK_STOP;
>>   }
>>   
>> -int
>> +void
>>   nfsd4_init_leases_net(struct nfsd_net *nn)
>>   {
>>   	struct sysinfo si;
>> @@ -4443,16 +4443,6 @@ nfsd4_init_leases_net(struct nfsd_net *nn)
>>   	nn->nfs4_max_clients = max_t(int, max_clients, NFS4_CLIENTS_PER_GB);
>>   
>>   	atomic_set(&nn->nfsd_courtesy_clients, 0);
>> -	nn->nfsd_client_shrinker.scan_objects = nfsd4_state_shrinker_scan;
>> -	nn->nfsd_client_shrinker.count_objects = nfsd4_state_shrinker_count;
>> -	nn->nfsd_client_shrinker.seeks = DEFAULT_SEEKS;
>> -	return register_shrinker(&nn->nfsd_client_shrinker, "nfsd-client");
>> -}
>> -
>> -void
>> -nfsd4_leases_net_shutdown(struct nfsd_net *nn)
>> -{
>> -	unregister_shrinker(&nn->nfsd_client_shrinker);
>>   }
>>   
>>   static void init_nfs4_replay(struct nfs4_replay *rp)
>> @@ -8077,7 +8067,10 @@ static int nfs4_state_create_net(struct net *net)
>>   	INIT_DELAYED_WORK(&nn->nfsd_shrinker_work, nfsd4_state_shrinker_worker);
>>   	get_net(net);
>>   
>> -	return 0;
>> +	nn->nfsd_client_shrinker.scan_objects = nfsd4_state_shrinker_scan;
>> +	nn->nfsd_client_shrinker.count_objects = nfsd4_state_shrinker_count;
>> +	nn->nfsd_client_shrinker.seeks = DEFAULT_SEEKS;
>> +	return register_shrinker(&nn->nfsd_client_shrinker, "nfsd-client");
>>   
>>   err_sessionid:
>>   	kfree(nn->unconf_id_hashtbl);
>> @@ -8171,6 +8164,7 @@ nfs4_state_shutdown_net(struct net *net)
>>   	struct list_head *pos, *next, reaplist;
>>   	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
>>   
>> +	unregister_shrinker(&nn->nfsd_client_shrinker);
>>   	cancel_delayed_work_sync(&nn->laundromat_work);
>>   	locks_end_grace(&nn->nfsd4_manager);
>>   
>> diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
>> index d1e581a60480..c2577ee7ffb2 100644
>> --- a/fs/nfsd/nfsctl.c
>> +++ b/fs/nfsd/nfsctl.c
>> @@ -1457,9 +1457,7 @@ static __net_init int nfsd_init_net(struct net *net)
>>   		goto out_idmap_error;
>>   	nn->nfsd_versions = NULL;
>>   	nn->nfsd4_minorversions = NULL;
>> -	retval = nfsd4_init_leases_net(nn);
>> -	if (retval)
>> -		goto out_drc_error;
>> +	nfsd4_init_leases_net(nn);
>>   	retval = nfsd_reply_cache_init(nn);
>>   	if (retval)
>>   		goto out_cache_error;
>> @@ -1469,8 +1467,6 @@ static __net_init int nfsd_init_net(struct net *net)
>>   	return 0;
>>   
>>   out_cache_error:
>> -	nfsd4_leases_net_shutdown(nn);
>> -out_drc_error:
>>   	nfsd_idmap_shutdown(net);
>>   out_idmap_error:
>>   	nfsd_export_shutdown(net);
>> @@ -1486,7 +1482,6 @@ static __net_exit void nfsd_exit_net(struct net *net)
>>   	nfsd_idmap_shutdown(net);
>>   	nfsd_export_shutdown(net);
>>   	nfsd_netns_free_versions(net_generic(net, nfsd_net_id));
>> -	nfsd4_leases_net_shutdown(nn);
>>   }
>>   
>>   static struct pernet_operations nfsd_net_ops = {
>> diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
>> index 93b42ef9ed91..fa0144a74267 100644
>> --- a/fs/nfsd/nfsd.h
>> +++ b/fs/nfsd/nfsd.h
>> @@ -504,8 +504,7 @@ extern void unregister_cld_notifier(void);
>>   extern void nfsd4_ssc_init_umount_work(struct nfsd_net *nn);
>>   #endif
>>   
>> -extern int nfsd4_init_leases_net(struct nfsd_net *nn);
>> -extern void nfsd4_leases_net_shutdown(struct nfsd_net *nn);
>> +extern void nfsd4_init_leases_net(struct nfsd_net *nn);
>>   
>>   #else /* CONFIG_NFSD_V4 */
>>   static inline int nfsd4_is_junction(struct dentry *dentry)
>> @@ -513,8 +512,7 @@ static inline int nfsd4_is_junction(struct dentry *dentry)
>>   	return 0;
>>   }
>>   
>> -static inline int nfsd4_init_leases_net(struct nfsd_net *nn) { return 0; };
>> -static inline void nfsd4_leases_net_shutdown(struct nfsd_net *nn) {};
>> +static inline void nfsd4_init_leases_net(struct nfsd_net *nn) { };
>>   
>>   #define register_cld_notifier() 0
>>   #define unregister_cld_notifier() do { } while(0)
>
>
> Patch looks reasonable. It might be good to also move the reply cache
> init in a similar way (as you pointed out in the patch description).

Thank you for reviewing.

-Dai

>
> Reviewed-by: Jeff Layton <jlayton@kernel.org>
