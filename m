Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 248CB555353
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Jun 2022 20:35:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357692AbiFVSfl (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 22 Jun 2022 14:35:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235505AbiFVSfk (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 22 Jun 2022 14:35:40 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 719C01EAD7
        for <linux-nfs@vger.kernel.org>; Wed, 22 Jun 2022 11:35:39 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25MFOZCe003411
        for <linux-nfs@vger.kernel.org>; Wed, 22 Jun 2022 18:35:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=1pHC5KSPeDI6AXiUBhqL8eg8FaK7HZ8W/EftBy333yw=;
 b=JydQ1UXrc6UhCdUdFmDOaszmdf8aUBPrfFqR8CVe0uVY+MDWnpcoshCp+X3Ru6pvppVI
 X2fo/ME5H7ZQReynI9KXPukipi4SyG/xISvR3Sw0HUtWvzIEuF54bFfuO1tafOdX98h2
 nj7JP53ve2Y0vUTPonX8inCgoUXaKSRPR7zp22U0zCgOFiJTE8IpYVG18j4Ak7NaloF3
 bQm4b3oiaBvTqiUQRyG8FIn0uGqVB+5ehCYOlG0RC83wHODMBkjh5QcGXQXlvLA1Pk12
 +OuiPkO1msu86HqCB/gVDfg7RfyF8Xqn34kMcZ6x/gnFMtkbwSBuxDAdyqX7UPKXd26G kA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gs78u1899-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-nfs@vger.kernel.org>; Wed, 22 Jun 2022 18:35:39 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25MIUpEW019168
        for <linux-nfs@vger.kernel.org>; Wed, 22 Jun 2022 18:35:38 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2176.outbound.protection.outlook.com [104.47.59.176])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gtf5dvv3f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-nfs@vger.kernel.org>; Wed, 22 Jun 2022 18:35:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=liuBByav07jhnCQl20yMrTzF+RlYTItgNFNNzARsO6Dq+Xeb92qra8fLBB6ycGtnug1gSyYfbQdWLoxOxNsU0soSYyIgP1bM2b6KwoKFCkQrCtL8sooAQbWArKD8UQWTfTm1T/08UPiB2X27JrmO4hZ70IyVpRuu2b/oKf61z6aZg3Eh1uaqOW4b3o9JrflaWO3eAQj/yOxnQ/DdwcCKo2EV7S+btP4FGgoO1MZhrvN6bO86o1ipbgCA0+l6VZs+1ROuLQdUaQy0opdiEYP30+94jrc1ROi7HzQ5H/S2vkLe9TpKVdrHiEMuruyZvhKJ2xST4vH00SRoulFWy/Z1vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1pHC5KSPeDI6AXiUBhqL8eg8FaK7HZ8W/EftBy333yw=;
 b=Ts16kzyaNl2T9Evb7n1Sy3Xe2Z5lcBzbVMk24NfJ1PlpR5jpTGJr4gZnm0dvjjFQ7OkWAV8S0g9HTNs3MsccLLavFdsOiiL2Ih7d01vVlxL3Qeay0QLHGEIrKzrGA4jxtA2zfi2pTJf1mfDz7DjH7gbnimaTzzhKuMSzs1EibP5dFu6eYxw1y413sByhg89ufJp7BaFGb/TY9PUERNJgoqdPHYDh1vBnKlcYdO5bgQl8uk/Yok7WJH60W+Ez0+gor4G+alX5f9ICd6IywsbQVdPpvsMc4JdfXMMcSF2f4Mny+jqwXRjh/TGxAtlWrHzBdYjRe1P9uyk84tva2A92Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1pHC5KSPeDI6AXiUBhqL8eg8FaK7HZ8W/EftBy333yw=;
 b=zOHRKBvM7Bw177emgUZ5xZq2qtNwhH+FVmnWCn9oGQzQJ55lF5G8YNAOJyoCI+PG2e/tdAHHW5ZrzdbiJ7JLWfKtEqFaIIXIrL4Docfo5asaZiGUKccetqaJxxzgb2L4JHgHrsfpbI/YJ8snDGaX8bU0Enb6sUObeuQ9qkfYjjE=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by SJ0PR10MB5615.namprd10.prod.outlook.com (2603:10b6:a03:3d8::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.15; Wed, 22 Jun
 2022 18:35:36 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::a44a:1596:2b77:2199]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::a44a:1596:2b77:2199%5]) with mapi id 15.20.5373.015; Wed, 22 Jun 2022
 18:35:36 +0000
Message-ID: <23ea252d-5f77-e9a1-4f9d-a8a22b0abd41@oracle.com>
Date:   Wed, 22 Jun 2022 11:35:32 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.10.0
Subject: Re: [PATCH 1/1] NFSD: Fix memory shortage problem with Courteous
 server.
Content-Language: en-US
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
References: <1655921718-28842-1-git-send-email-dai.ngo@oracle.com>
 <27586B46-7926-46A7-AFF0-4E0F322B4225@oracle.com>
 <52820d99-48f6-f56a-fc00-3cbb7fa07f8e@oracle.com>
 <725CC37D-020B-4CBF-8A04-473326DFBA30@oracle.com>
From:   dai.ngo@oracle.com
In-Reply-To: <725CC37D-020B-4CBF-8A04-473326DFBA30@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR06CA0080.namprd06.prod.outlook.com
 (2603:10b6:5:336::13) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 77f73c07-5c86-46db-f5dc-08da547dff64
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5615:EE_
X-Microsoft-Antispam-PRVS: <SJ0PR10MB56152E97BD2FC154927FD93387B29@SJ0PR10MB5615.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V73gjTUTaEJS1+iJtnG4J3JHZnxptnyXtBz5eW7QO0+txmuXuhGLty9u5bKgjms7IeM8GPzASvSLaAg/nNKup3QwSkeFa0t6ZkyHqL2NYcIrO5rJ7kObPr6vcFXzjBzl5f7wEvzR/fjWicqFndgkgVDcjyFZYSchQ67elTQNVA0nqZfqEAM/ujYpoLKrpneZ8Si8hxXOQJjLqaZgS5KoldB9+koMC/OFo2xHSRsB0pkXHyU9S0IcRjlAFOq0yqqNOCmFinUeZ2ZNg5QZy9ZdlmAgQ6EKKuBYrJ99Fa0mnLX26oos/RE/Wo+zUXu1i98parSK6y2brxg7t2RJvvHrZQe8/RzsjcnvFCFAH2ylJtW3nDDe5mEdhIY6UPekMosqUhHxDY1wkqsnljSve/JB5Xu4GjBqCtdG6tM2jaXfljCQpwf1UArGDgFEAtB2X3utvEQa8OyVztb2IMs04t+SqLM14sLkgg3ASgd27LtqKzaXFkktX/3Nc4H0S1Iq2nrrcy04gcUat8lF2zb9JROWHZra8UG1/XYZsJHRtGNFdzc2rjWa66WLRLsaqPC1Y2h6yWD6d45bC5re02Q1zLpQlSkr20e7B5+9qWGlSYm/9S89sGeYBM+8AKxFBO9pOHjQvWRc/GboqkZJwb2pT4Xl89S1jou9CxGQStTJ90uHhQPTb0OD78Npz4vjQWgOLS5It2cHyMGb9vo+Bj9kp48Ojpl7uNB6j3s4NeQzDmnGKvURwk5jKrDYVYVQok7rYknT
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(39860400002)(376002)(366004)(136003)(346002)(5660300002)(83380400001)(9686003)(66476007)(2906002)(66946007)(53546011)(6862004)(6506007)(8936002)(66556008)(6666004)(4326008)(31696002)(86362001)(26005)(6486002)(41300700001)(36756003)(37006003)(6512007)(2616005)(8676002)(316002)(31686004)(478600001)(186003)(38100700002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U0dNclZCQXltTFZSV2Z2dG5paVFiV0h1cERlYTNSMTIyOVBCQS94amphOWdY?=
 =?utf-8?B?NG10R2FNNytmb3Ridlh3aGJYZTRjbTA2R29zR082aTBTQlA1L2NsVjhQdUhK?=
 =?utf-8?B?MXBtREc1VjNTN2xjZVRFcVdxN25vTHFoemF2OTRoTjVRY2pMY0p5WE91U1NC?=
 =?utf-8?B?eVpXbGpLNlNzLzhFZEdTQjNxdWs3UWN0N3FvRWZuZFBLZVJNakh3L3BmdmFD?=
 =?utf-8?B?NXBjYVNiemhORWZrNVRKRkF0VnkvYXA0UEowM0dNcW1VZCtYYnhUZU1wTlYx?=
 =?utf-8?B?VXNCVnRqclNreWV6WEFkODRJK3o2Y1V2WDBkZFR4SG1rUHJ3aWwwdU1LSU1k?=
 =?utf-8?B?Q1FJdjl6d0JNZk5pTWdTRldvUFdtUTVDZzdHT1JibWJMSHA5aXlVUUNURitG?=
 =?utf-8?B?UjNGN0FTTEJ3SEN1WldHamdybGhUVVpFdytiZVFJQlVWdmRjdmo2QWZMWG5Z?=
 =?utf-8?B?bkVGeTFuWWVjRHhod0JvSzRuSGVIY0oxcERpT1VEK215aXBrQTY2WGVlK3RU?=
 =?utf-8?B?Nm0wRHAzODVxNFBMdEJsRmlaajBIMXkrcGR3elQ0N1lUT1VneFZRTVh3MHdi?=
 =?utf-8?B?T3hnYzA5Zmx1SlhIWkdna3labnlKVkJMU1dYUzBiKyt0MnQ5WE1vd3dnbWJv?=
 =?utf-8?B?MEJRNTRqOURkMVJYWEVndGV2TTVHdWxvcXlyNzZZNi9ISUU2SnN4Zjdadytw?=
 =?utf-8?B?eGhrZ0Z1UUY4NHhWbGpLL3FkWFE2bnc1ZEhocStNYStWTUF2ODcrODU0N3hl?=
 =?utf-8?B?RE1CNFZtbTRGZ2R0SzhHcFp1NWJEZW5TK2IrWHkrNTA0RE5UVUZ4RlNIcGx3?=
 =?utf-8?B?OVNKR3J6R3g4Rm14UUx3TkF2czltYjJtaVh1OHozZUZackx3b3hIRllZVDZT?=
 =?utf-8?B?RTNBNlpmVm84dHhNR2FRNWYvdERDMXN1alZzVXprTFhHSndGWjBvNzNQVXEw?=
 =?utf-8?B?S0F2M0J2QXFBSU1OWGdqWTJnRlJ1dlVJRWhqTGVoY0s4ZDAyYUhTVUQ2RmUz?=
 =?utf-8?B?K0laSkkyTWdOZTI5aFZkNmFrT3pIMmtOUG5GTkxKQTBBSjdZeHNZWVI5MHZa?=
 =?utf-8?B?S2VxTzhCVWVGTnlsK1JWUkZTV2k1VUZMR0QzV2ZJeXc4OFFTTXBMTjNsTWNN?=
 =?utf-8?B?MmtINko4OENLWjdNMjBsK0VyNTdWVEVYMm1EQmRIZDdtTDlwTi91TnIvZ2Ry?=
 =?utf-8?B?S1ZXZ2gyQUhzTWw1aldTakh1OWtheTV2ZEZpd0NhVlpCMkc2V1lEU0U3THo3?=
 =?utf-8?B?R2dXUG4rNFlmQWZTZXVpV1htamtKTTNRaGRWUkVFSEpKMmJlVGZOSmtjOWpL?=
 =?utf-8?B?TWFuQUpwU3VRSGJnUnVWMjQ2QkR2bTE4M0gzeWNIUkRTR3J4TDJQWDlSSHBE?=
 =?utf-8?B?VlAvUEkwZ3puTUdxOW5QZXBIS3loVUYvblZqN0l1MmZmWXU0M0xEeG9SMlR1?=
 =?utf-8?B?Wnp5NlJqZDhYZVVRZC9CTU80MVhkblFGQTRGSktaRmEyN1grVEFsTSs4SFpG?=
 =?utf-8?B?UndHU2JvYk0vK0cwRnQwWTdER0Q4MnVwT2ZJd0srQUVZMmRLTGlNV1oxN2J4?=
 =?utf-8?B?MEMyVkxPR0ZJb0grVG9XRlZuc0hEbEpxVXJHM1djM3F3VFBpcE4xVkxRMlpW?=
 =?utf-8?B?YVk3bE02a3RXdUlnL2tOYy9XZEVva0hCV2ljMjlMZlRscjRvc0dabFRhWkE4?=
 =?utf-8?B?SnI1T3ZFTTJLa2p6cyt1NEtrL1BqZ1Azem96bktldHhscUdWdXRyMVR6QTAr?=
 =?utf-8?B?K3RlS2gvM2ZjUlQrNzNrNkVoSzM3cFkxSzRvM2c1ZjdGem12UlJtWTdIdzNV?=
 =?utf-8?B?ZklzdFZieWowKzRyTVhNNWltN3lJNGowMEthdFNEdjFMZnZyVzZUVVA0cTQx?=
 =?utf-8?B?ZG9xNVNNK1N6ZHUySFF3ZlZtWmFDNWUvOG9abnZxemFybzd0SS9OdDRXZlNm?=
 =?utf-8?B?N1hxQmNKUUNNQmYxWFVhdXprUGZ1blhLdGtQWEtXWVd3QU9JRFdwNUE2Wkl3?=
 =?utf-8?B?REpZdzhiemVzWWxpOVFVK1Y5U0hRVzNUUFZiZFhkZm10SXNrdjc4Q0Y4TzVR?=
 =?utf-8?B?ck5MaEFXNStROGxsRWp0QVM1NktCM3phbFRuREFjNWloR0VhRlZwZmM0VjAv?=
 =?utf-8?B?WEFYT3RiZm1WS0pMNldRbUNraXNyQWxIZWtJL1BUeXJtOGk4dDVDb0RsUGpY?=
 =?utf-8?B?R1B5WlYyTjJBYWJGK2pKMG1VYnVLTTJsMFJTUjB1QnhRakptQzk0YUFwNWcw?=
 =?utf-8?B?NjNvc2VOQWdhaG5nb3IxTThFeEhJYWVBZnpiR2M5d215dmlVRU12V0JEMkV3?=
 =?utf-8?B?SmsyeG9HdEtsbXVlb01pY2FqUnBPd1U0YS94WlFEQlRSeUM1SmxaQT09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77f73c07-5c86-46db-f5dc-08da547dff64
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2022 18:35:36.0687
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AwD26uPb43tlVFWlqUSNDEnhY5j3eRE3D+57vFDpQKHOEeAIAUrooXRQZK8Dk8aCNKS/sXORkOwZYgbf0FqkaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5615
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-06-22_05:2022-06-22,2022-06-22 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 phishscore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206220087
X-Proofpoint-GUID: QfmeY3kuJrRbCOzqkPi5fmX0wiqe-hrB
X-Proofpoint-ORIG-GUID: QfmeY3kuJrRbCOzqkPi5fmX0wiqe-hrB
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


On 6/22/22 11:32 AM, Chuck Lever III wrote:
>
>> On Jun 22, 2022, at 2:28 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
>>
>>
>> On 6/22/22 11:16 AM, Chuck Lever III wrote:
>>>> On Jun 22, 2022, at 2:15 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
>>>>
>>>> Currently the idle timeout for courtesy client is fixed at 1 day.
>>>> If there are lots of courtesy clients remain in the system it can
>>>> cause memory resource shortage that effects the operations of other
>>>> modules in the kernel. This problem can be observed by running pynfs
>>>> nfs4.0 CID5 test in a loop. Eventually system runs out of memory
>>>> and rpc.gssd fails to add new watch:
>>>>
>>>> rpc.gssd[3851]: ERROR: inotify_add_watch failed for nfsd4_cb/clnt6c2e:
>>>> 		No space left on device
>>>>
>>>> and also alloc_inode fails with out of memory:
>>>>
>>>> Call Trace:
>>>> <TASK>
>>>> dump_stack_lvl+0x33/0x42
>>>> dump_header+0x4a/0x1ed
>>>> oom_kill_process+0x80/0x10d
>>>> out_of_memory+0x237/0x25f
>>>> __alloc_pages_slowpath.constprop.0+0x617/0x7b6
>>>> __alloc_pages+0x132/0x1e3
>>>> alloc_slab_page+0x15/0x33
>>>> allocate_slab+0x78/0x1ab
>>>> ? alloc_inode+0x38/0x8d
>>>> ___slab_alloc+0x2af/0x373
>>>> ? alloc_inode+0x38/0x8d
>>>> ? slab_pre_alloc_hook.constprop.0+0x9f/0x158
>>>> ? alloc_inode+0x38/0x8d
>>>> __slab_alloc.constprop.0+0x1c/0x24
>>>> kmem_cache_alloc_lru+0x8c/0x142
>>>> alloc_inode+0x38/0x8d
>>>> iget_locked+0x60/0x126
>>>> kernfs_get_inode+0x18/0x105
>>>> kernfs_iop_lookup+0x6d/0xbc
>>>> __lookup_slow+0xb7/0xf9
>>>> lookup_slow+0x3a/0x52
>>>> walk_component+0x90/0x100
>>>> ? inode_permission+0x87/0x128
>>>> link_path_walk.part.0.constprop.0+0x266/0x2ea
>>>> ? path_init+0x101/0x2f2
>>>> path_lookupat+0x4c/0xfa
>>>> filename_lookup+0x63/0xd7
>>>> ? getname_flags+0x32/0x17a
>>>> ? kmem_cache_alloc+0x11f/0x144
>>>> ? getname_flags+0x16c/0x17a
>>>> user_path_at_empty+0x37/0x4b
>>>> do_readlinkat+0x61/0x102
>>>> __x64_sys_readlinkat+0x18/0x1b
>>>> do_syscall_64+0x57/0x72
>>>> entry_SYSCALL_64_after_hwframe+0x46/0xb0
>>>> RIP: 0033:0x7fce5410340e
>>>>
>>>> This patch adds a simple policy to dynamically adjust the idle
>>>> timeout based on the percentage of available memory in the system
>>>> as follow:
>>>>
>>>> . > 70% : unlimited. Courtesy clients are allowed to remain valid
>>>> as long as memory availability is above 70%
>>>> . 60% - 70%: 1 day.
>>>> . 50% - 60%: 1hr
>>>> . 40% - 50%: 30mins
>>>> . 30% - 40%: 15mins
>>>> . < 30%: disable. Expire all existing courtesy clients and donot
>>>> allow new courtesey client
>>> I thought our plan was to add a shrinker to do this.
>> I'm not familiar with kernel's memory allocation and don't want to muck
>> with it so I start with this simple approach but I'm open for any suggestion
>> on how to add a shrinker for this task. Is there any existing model that I
>> can use as reference?
> Fortunately there's nothing complicated about using a shrinker.
> Look for register_shrinker() calls to see code examples. There
> are two already in NFSD itself.

Thanks Chuck, I'll take a look.

-Dai

>
>
> --
> Chuck Lever
>
>
>
