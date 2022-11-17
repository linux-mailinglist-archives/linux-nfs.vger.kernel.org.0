Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4C8362E234
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Nov 2022 17:46:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234551AbiKQQqe (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 17 Nov 2022 11:46:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231377AbiKQQqc (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 17 Nov 2022 11:46:32 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E516B2AE26
        for <linux-nfs@vger.kernel.org>; Thu, 17 Nov 2022 08:46:31 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AHG0DV1028265;
        Thu, 17 Nov 2022 16:46:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=IsHn29D+98GJ8QKhp7YLH1W6exbLktC7E3eOgZxMjT8=;
 b=K33c3E+PSAQGXAE6o1y9fjMDrKc+mpPW1O9LgMcW2kHGM8zeigmOGjs/EpyWbPh2Y4eb
 V+6pkZEqKwiKwDEVNyucX5dCpLQD+wNttxEUer1RjpSTFM8f2bDKQbkg6bdrj4iLZ3OA
 f/xJ1fhZ7jmAppjOM3S8bK/kmMcH19/oVV4swt3LqWkPuPBaQpp0Y9qSyqEcjj2nW7ZU
 ryeIkdnNdLZx+2s27YU++j6nc2noqtNjCvBuhvM46QaV8I8nZDfzfr4+dtwn72ahg/AY
 hEG9k+VTZ+l5WTOsq78UCePeQxwGwJXFBFIyXE0Y7KrSOKyUh/18QnqlDOh7kjlhve8Q tg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kv8yksm2h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Nov 2022 16:46:28 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2AHFtCGk008687;
        Thu, 17 Nov 2022 16:46:26 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2176.outbound.protection.outlook.com [104.47.73.176])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kt1xfncda-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Nov 2022 16:46:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YNcjjqBsA82LxZVbE1AtjC9vUBycLHA1+1z16/LYylIBUZ499dUcYA8mJVeHvtp1HM2GkkgwEIo+kH7/8rLqtWt+iqYPADtKPYdbZ+tImYMDlt2ABtrGM18q7eWq+2nS7SUbvEQkes+oxWS/TBYig0yN38e7UGE17HUw3rD87TlADf/tq7+SkyRIF2NWfGyP+HzHphRV5AB4+IGTbYsR/rRXz4DWtV1PsmQPA0smI3HYSjn203/vtKvlcHXphWyoDwhzZk0X9Ajf4DOz6Z7BGeFA+ob5/U0mCa9+DiBjscMU6YphFtzas8mhCCo/KFTVctHuhJvIimPEcJ/sLsVZRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IsHn29D+98GJ8QKhp7YLH1W6exbLktC7E3eOgZxMjT8=;
 b=ZEjpH7IQ2LaLljwRhHw5bpS2EOZbUTek1/vtDgakK1tCdIscEqtiPK07aQ8cMjhtEV1X1sPcznSb7vwbadGKazEoV+nrqvDin3GJdUN6vJP9K1kuzu37vVd2bVzEaVcdutqTS/6klAQ3t+xBoA240cYklo5d26oJKARbJZq6OxfuN1mSM24mad9GlgBKi/cERQnQxeDc9IDIG4i1uF1UGGy9eaAllFmT3/ZeDU7SANgyiCWh6BWpgfxfsCN48+yO0DtvY1j4gA7U6TqDxEI+o4gpF7pY1KwaT/vwKY8zqb3SS9l3IQGRwm/GmwJPa95RKNt2UfzDh/dVsn1w2rzokQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IsHn29D+98GJ8QKhp7YLH1W6exbLktC7E3eOgZxMjT8=;
 b=HCD/3SXA5cNtGGdFSbvSBXNd0Y/Mb5fmleg6o6r8csD0lu9qdErXbX4cXDyEyrh+XXWUXq9ljU5Jrz38QCV3peQ70AotOzH1g54tp+034fu1vHlAMJSrzd3yX5YNl7eq394ZTQcbOyVPKcRXWnY+feCCbKkxNCuy8u4v8Wp7TvM=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by CY5PR10MB5913.namprd10.prod.outlook.com (2603:10b6:930:2f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.20; Thu, 17 Nov
 2022 16:46:23 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::2d62:ce4b:356d:e242]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::2d62:ce4b:356d:e242%8]) with mapi id 15.20.5813.020; Thu, 17 Nov 2022
 16:46:23 +0000
Message-ID: <a595f411-c6bc-5f6a-3647-800724e569a5@oracle.com>
Date:   Thu, 17 Nov 2022 08:46:21 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.2
Subject: Re: [PATCH v5 1/4] NFSD: refactoring courtesy_client_reaper to a
 generic low memory shrinker
Content-Language: en-US
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     "jlayton@kernel.org" <jlayton@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
References: <1668656688-22507-1-git-send-email-dai.ngo@oracle.com>
 <1668656688-22507-2-git-send-email-dai.ngo@oracle.com>
 <CB4F87D6-8B46-4D84-A7FB-B095AA1745DA@oracle.com>
From:   dai.ngo@oracle.com
In-Reply-To: <CB4F87D6-8B46-4D84-A7FB-B095AA1745DA@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1PR02CA0016.namprd02.prod.outlook.com
 (2603:10b6:806:2cf::22) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4257:EE_|CY5PR10MB5913:EE_
X-MS-Office365-Filtering-Correlation-Id: a218ebb9-013d-4fbe-8d39-08dac8bb431d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oouUX2bmq3XWmQTzEbyvJsf62Em1RqW6lgrCH0hQUHqekjPp+SiPAQHQy8p3jFdUA17L1PCducctGC1aGA0Ln+xOq4l/JG4IIhzZCK/k0o45LilWrFKNQomzEjHI4W6h3Rqsyrw0pX+wlvOAdOIzVucpr9vR0hpgSZQAkuFBcbNbbO5Hf5VNuuKhCIz3um7qor38ObEs/uSyM122dg5k5SNdDa0lOKXaqbb82lw5jK1KZ3moAMhGmPXUMYxPPzJdpFp5w8cwvloEK/MF8lAtFxd6vqTQYpg4yPiORcniItBmgilu2qo8s0K7aDk0u/cdDc6nZ+UOhBKBpvIsgVodcrwaKjdoDpvDqfaBZFze6yheDTtsow3bcx7j9O7qCIDrFdhV8Jccv0Yic3Lrkus1giZpAY0tP3WtJcX4wVNy7J1t9OJrT8bMz4sqILtK7Ze+jxiaB2TbiXkdMRck5rhc2XUdPn9iQPLtswnvgoVaWOmKS2AAF1iEXLEEbWHDlL5HgbXzOoc2dkzU1Ng8tMGX43D4Pa6R0nTDPDT1yzRkxdo6aDbE3lEUPay9lUwQfRMeLGq0JyjpO8CKzfzLMN+6b9RJfdsxm9TSHf9AQbW8AyqJVlJeWi5K4/F7orMOL8sAeL9BRkhbZ041XRKvnYwqwKSwNIZ7g9YOECp3lADumdNmy24OCRpiaKzZ7Gj9r7K9YbquyXxmaSsJn6ea1n9eLA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(39860400002)(396003)(366004)(136003)(376002)(451199015)(86362001)(31686004)(54906003)(66946007)(31696002)(5660300002)(316002)(8936002)(41300700001)(6862004)(478600001)(83380400001)(38100700002)(2906002)(6486002)(6506007)(53546011)(9686003)(186003)(36756003)(2616005)(4326008)(66556008)(66476007)(8676002)(6512007)(37006003)(26005)(41533002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dWkvSHdFMHZGNG1sREhKRmwxMmpGVURzYUJONkpHcEgxeWhlSlIrZkl3N2pF?=
 =?utf-8?B?M3dMUFppYVRFMWp1NENld256SVdwNkFxcDFYbHZicndIeW40TEZDZnB6ZnRm?=
 =?utf-8?B?czZuQ0lJSFZwNWh5cEhkcVQya0NqRFoxZHJKQXM5aWtyQis1QWxVOVFwRjdq?=
 =?utf-8?B?RHQ1R1liT24zOU44RTRwMWg3aXc5WGQvU0QraVh6YkFDRWl5cTZSS3RuTG9P?=
 =?utf-8?B?cDRMMjRTSHRaMEYvNVpTbzJJSGV0TUVVL0hpWWdaMkVzcjJGbXlCaXlrd1My?=
 =?utf-8?B?NmV2WUsvclZDWnZ6cHE1MFlVN0pTTXlHcGtmRFR3MUYzSDU3MnN6bm1RTVpv?=
 =?utf-8?B?KzBsUUZvN0RLNmRvdU1NZzJ2VHhITHpIZXc3OW1kdlk0akpmNzNyeUZTRGpp?=
 =?utf-8?B?VjVzWEM4RkdET3REUWJCU0swazRoWUszcjlhNVR4a2hCQ2Q3akFtcXNXdHhz?=
 =?utf-8?B?aDdPRGpLbzAyN21RT0NyTHQwTVp4UkY1enN3WHpBaDZUQ2ppalg0MmdiUVRZ?=
 =?utf-8?B?TkQvQm5UKzVxK2V4SnlkTzRoQjFPK0MxZFZkZGJPKzJ4c3FIbDg4bitxNXVh?=
 =?utf-8?B?VVJMSTBrS3gvRmgvcE9CWU0zQnlPckhEQ0ZOU1EwZklFNlp2UmxSd0hHbkI4?=
 =?utf-8?B?WTQ3TUI1UjZlbjlycGh2OENWa3hXZnhDMExSejNyNU5QZGdKdG5wM3pxczR1?=
 =?utf-8?B?MHRYZUliY3M1M2hKWXB5cEJtdWxUdjE0TmNlRUt6NmhSQVdYenJIK3M1Z2Qv?=
 =?utf-8?B?b1BVSHlBMmZSRS84aXRPUjhQQXZmTS82STY2WVo5Y1NQT0FiZjlMZmZkdGdX?=
 =?utf-8?B?NnoxZG9Qb0xwNk1jNW9lVEhxTUFHOWVkaitPajVCMHZyNjBrdVVLLy9YWlFx?=
 =?utf-8?B?Z21ocndtR2lmb2xFRWNUYWsvQnlzeTF5M09nb2tKaWdycEd4Nnd6b3dkL3NC?=
 =?utf-8?B?SHp3TGd0RnBwQ0o2N21IN3oySWFpN0lTa1JJMm5BNWRVYkIwM0N1K0NiaWo1?=
 =?utf-8?B?TmthN0Jub1FUMndBVVhzNThOOEZnd1IveWhxT1ErZE01ZXkwNXNQcXJpMGU1?=
 =?utf-8?B?Rm95ZFM4Q0VEamcvRnBESDhoc21zVENEVjU1L2ozR21OSzN2c2k0NjFldktX?=
 =?utf-8?B?V3RaNjN5Nk9LQnQwOUhQNUhDMEZRSlBZYlhqTThNREpRd0ZscC9sckhrdG85?=
 =?utf-8?B?QlVVbDY0dmFtUDk0Ym11NjBvdnFIUnR0L296V013ZFMrZnRvK1d2WFZwK1RG?=
 =?utf-8?B?UC9xNm1VaHpzTTJMTUpETThFdVQxM2F4NVFJZ3UzNW5OSjIzWkM5a2ZVaTlM?=
 =?utf-8?B?bStHMThUYkhLYWRKK1Z6VkNQa2YwdVUzVVFDdjRuKzd6aHliVERpQkxwSjhz?=
 =?utf-8?B?Q0hJalpkOUpDR0Z0SGZRMEJvTjd4NE1aUTI5UnkwaHFtSys0YzMrTU9mc0FO?=
 =?utf-8?B?b0E2LzZydFVPTndRYWxGY1FEN2ZpNmh4YzgzRW81cWhDcjBTajZOYjFHY0JH?=
 =?utf-8?B?S0thOXdzMWRmL2VKSGhYcXpsWWNXOVdROWV5Rk9lR0trT1l2cks2a2c0SUZP?=
 =?utf-8?B?UHVYWXpLV3AyM01ISy9Ja0wyaW03VlB0ZjgxMW1SNkpQVGZvSmRRR21rWmxE?=
 =?utf-8?B?T0RQQXdWenNnT1QrL2FIWW1ja1QrVFNMUkZmUGtGL1l6ampUUEtBckg4RWNP?=
 =?utf-8?B?a0FMZGNPUTR0dTloVWZPNGR2b1BYK05sMnFnVCszYTRNd3VWSDNYaVNYbmo3?=
 =?utf-8?B?YXZ6NGs4NjVTelNyZTd0UXlIL281emlDYVdmZEw4U3lXZzZlMFNza1lpYXVM?=
 =?utf-8?B?Sy9rODV4eUU1d092bEJkL0Zndnh5cDlhNFJOYnFKcUdOcmdhalI0MXljbTlS?=
 =?utf-8?B?NDN6M0xQdXBsc213WnA1T2ZFMUF3Mk9xa2t6TXhnWDk5dlNLckJEdU5NdEhq?=
 =?utf-8?B?Z3hWRUozOTVoWkpseTRzQWJreGxNQmV5Z3dqVnovWE1YRVVBclFocVlsajNM?=
 =?utf-8?B?VU5yWllwVXVXdnJvZW4relM0OEIwMFQxak9nTWI1TEJleXhHRTFzOUg1QXdK?=
 =?utf-8?B?TWlwekdpVXh6Z2NBTkU5NjY3dTN2VGkyRnRLMHk5Z0JJcDkvQi9nQVdkTW16?=
 =?utf-8?Q?sy9VjlqzV5HIRDe+eyttqTbi1?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: O7EXFYLyzsnIlsx2ajFMYn6R+e/ZlPV9VnGvR0wJoAz+lW24HZ2+Ot06ZD3JTL08T7qiYx2yfaIGTaKogoq0ApGsjf3amHmricRfeeKsFqLy3oH4ubLZZTt3T2sDw8RzN9RpsrS6cZvmdx0lBDxAq75r1KBsZoOWU8nHZ27NBgYeaG1qPOvaRyGatp6fEWV5uslCq5mFT9oZgY3Obj8s+zXmCbH9bRqTtD6gpjmyqXxC3TMVugA3fkUbfvoRfE96UolzjO/g4GO/M/QfPniE87SX3adDWjoKSx0RG7N1u+GXAmVbIHmZqc6cZUS8jc+9TdoUNX9zzFfsGWVTNSWknCYXvg/N3uoZVY5RfEz1vC/JUIWoA39MJ3Po7PKHF8jeURpSuQ7bWMs5nc8klaIfRxEArPkyToD6KS7+DM2rjKngLoeSjGFjtN/LHxKUUzAnyMJEhmrdZfReMBWMhewlQSq0iKij3vrSH5iEnCRm1snpLy/oMS85ijTzO2dpZ/0wEFS5rgSfXnUTUGujFhDwqlkwmjMNhMaY2ck39zqakXr5zbFXTW2lrwqtELAyR4TMHsuKjY8Qmpm221uMmOfZXFPdyvnUtBWkrsv1X2mWMNg8Jr0kWZRizE3XBEEAaSU78bzW2zwp/mxg+G385etQGhlCHuUB1eYtSXo7+ggtQxYUVbBhQREK41OOmn4Tl5i2f/1FVb/q8rp9mnuwAaSP6BUXS9CDkRdmHmd7RFBYeAgg/3RjjoMWixYd9ucMQOIgjo8DutnN/dFxKYdQLyQJal+LKcQRxEQX0/AM9ZlPSRk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a218ebb9-013d-4fbe-8d39-08dac8bb431d
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2022 16:46:23.8658
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vq0V8t/ysVHQwhktPaH1fh4knHtvj3dZtC2FDxL4eajJU8K4H2s8U3l391YYGMIwZ2jJ852yu0XZeVSpf1dSSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB5913
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-17_06,2022-11-17_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 mlxscore=0
 phishscore=0 suspectscore=0 spamscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211170124
X-Proofpoint-GUID: JmDx-P61aBxYAKIkztqi6UEeHJrcNfWO
X-Proofpoint-ORIG-GUID: JmDx-P61aBxYAKIkztqi6UEeHJrcNfWO
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


On 11/17/22 6:45 AM, Chuck Lever III wrote:
>
>> On Nov 16, 2022, at 10:44 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
>>
>> Refactoring courtesy_client_reaper to generic low memory
>> shrinker so it can be used for other purposes.
>>
>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>> ---
>> fs/nfsd/nfs4state.c | 25 ++++++++++++++++---------
>> 1 file changed, 16 insertions(+), 9 deletions(-)
>>
>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>> index 836bd825ca4a..142481bc96de 100644
>> --- a/fs/nfsd/nfs4state.c
>> +++ b/fs/nfsd/nfs4state.c
>> @@ -4347,7 +4347,7 @@ nfsd4_init_slabs(void)
>> }
>>
>> static unsigned long
>> -nfsd_courtesy_client_count(struct shrinker *shrink, struct shrink_control *sc)
>> +nfsd_lowmem_shrinker_count(struct shrinker *shrink, struct shrink_control *sc)
>> {
>> 	int cnt;
>> 	struct nfsd_net *nn = container_of(shrink,
>> @@ -4360,7 +4360,7 @@ nfsd_courtesy_client_count(struct shrinker *shrink, struct shrink_control *sc)
>> }
>>
>> static unsigned long
>> -nfsd_courtesy_client_scan(struct shrinker *shrink, struct shrink_control *sc)
>> +nfsd_lowmem_shrinker_scan(struct shrinker *shrink, struct shrink_control *sc)
>> {
>> 	return SHRINK_STOP;
>> }
>> @@ -4387,8 +4387,8 @@ nfsd4_init_leases_net(struct nfsd_net *nn)
>> 	nn->nfs4_max_clients = max_t(int, max_clients, NFS4_CLIENTS_PER_GB);
>>
>> 	atomic_set(&nn->nfsd_courtesy_clients, 0);
>> -	nn->nfsd_client_shrinker.scan_objects = nfsd_courtesy_client_scan;
>> -	nn->nfsd_client_shrinker.count_objects = nfsd_courtesy_client_count;
>> +	nn->nfsd_client_shrinker.scan_objects = nfsd_lowmem_shrinker_scan;
>> +	nn->nfsd_client_shrinker.count_objects = nfsd_lowmem_shrinker_count;
>> 	nn->nfsd_client_shrinker.seeks = DEFAULT_SEEKS;
>> 	return register_shrinker(&nn->nfsd_client_shrinker, "nfsd-client");
>> }
>> @@ -6125,17 +6125,24 @@ laundromat_main(struct work_struct *laundry)
>> }
>>
>> static void
>> -courtesy_client_reaper(struct work_struct *reaper)
>> +courtesy_client_reaper(struct nfsd_net *nn)
>> {
>> 	struct list_head reaplist;
>> -	struct delayed_work *dwork = to_delayed_work(reaper);
>> -	struct nfsd_net *nn = container_of(dwork, struct nfsd_net,
>> -					nfsd_shrinker_work);
>>
>> 	nfs4_get_courtesy_client_reaplist(nn, &reaplist);
>> 	nfs4_process_client_reaplist(&reaplist);
>> }
>>
>> +static void
>> +nfsd4_lowmem_shrinker(struct work_struct *work)
> All shrinkers run due to low memory, so I think this name
> is a bit redundant. How about nfsd4_state_shrinker?

ok, it makes sense.

Thanks,
-Dai

>
>
>> +{
>> +	struct delayed_work *dwork = to_delayed_work(work);
>> +	struct nfsd_net *nn = container_of(dwork, struct nfsd_net,
>> +				nfsd_shrinker_work);
>> +
>> +	courtesy_client_reaper(nn);
>> +}
>> +
>> static inline __be32 nfs4_check_fh(struct svc_fh *fhp, struct nfs4_stid *stp)
>> {
>> 	if (!fh_match(&fhp->fh_handle, &stp->sc_file->fi_fhandle))
>> @@ -7958,7 +7965,7 @@ static int nfs4_state_create_net(struct net *net)
>> 	INIT_LIST_HEAD(&nn->blocked_locks_lru);
>>
>> 	INIT_DELAYED_WORK(&nn->laundromat_work, laundromat_main);
>> -	INIT_DELAYED_WORK(&nn->nfsd_shrinker_work, courtesy_client_reaper);
>> +	INIT_DELAYED_WORK(&nn->nfsd_shrinker_work, nfsd4_lowmem_shrinker);
>> 	get_net(net);
>>
>> 	return 0;
>> -- 
>> 2.9.5
>>
> --
> Chuck Lever
>
>
>
