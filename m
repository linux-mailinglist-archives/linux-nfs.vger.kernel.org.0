Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC2B660D814
	for <lists+linux-nfs@lfdr.de>; Wed, 26 Oct 2022 01:40:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232966AbiJYXky (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 25 Oct 2022 19:40:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232971AbiJYXkP (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 25 Oct 2022 19:40:15 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 724325A825
        for <linux-nfs@vger.kernel.org>; Tue, 25 Oct 2022 16:39:48 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29PLnAFr017091;
        Tue, 25 Oct 2022 23:39:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=C5UJGrElnDzIOQt9F1pCF7yYUZo/fLx3mH+HkfTkSd0=;
 b=gpYOpBoBgNyKxwKMRflccbbq92KZPjpbzObvjd99DR8uQ9cLkyBT/3awVqFopM1qfjqn
 QL2wojYcR0kTQVa8b/wsBo/dvPgJQ1u3AU8WICjqGxK4cqfa2yAR0of5dbYUTAnT1Aau
 xVB6TIuo/+aARssXB5nFiI3nvFvrlX/bjzBMnPiCBa32MffT8YMCHNggKT8lWbdhTw/X
 L5WAM9TPep02SPrQKcw5g1IsPar7y5cw3iFyKwUaCxvzE87NAHEisgNxJAtJLWMyoFQN
 wYTJIplHDsYpc4tULQUnGQXliiUmbdorBjjor8efJqg6dp7WX/Hvz4TOG7fPrL2QLrAH +w== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kc741wh4s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Oct 2022 23:39:45 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29PLrZPT011080;
        Tue, 25 Oct 2022 23:39:44 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2174.outbound.protection.outlook.com [104.47.57.174])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kc6y54nta-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Oct 2022 23:39:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f8+WBk+BzA5yiQQXbZyJ2WQ46gH/IXspnp73+YXpVBDh/32QdAsn0xgUpb8JxK3dbELmR3GskfAZ6Vz7sbeTEwrAOHM6VLIx3x3pXmqFE5AAy7Z9VjEtZhl0enUrEZgvyNcaTxQgzgJ7DAKWeJKqaJ6BbcutV5yFuFEy/Jeip+wqUlQDjwHkjtSi33InJlRz2Tz7p7FG/aoq5epYnIB6qtetbXNMgnjZNc26eJrAcO69FuHlclzGOHS1kfs+dMYqbwwnQVoo6u62Fu8ibVISHtjH/oWBdAf/nv/fHbqCW37XtChHpIxjUMQtzEqKyi8qm8lLMoszZ1WK6vb20GOL1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C5UJGrElnDzIOQt9F1pCF7yYUZo/fLx3mH+HkfTkSd0=;
 b=FLWRXwrdkFrowU9iSV+znZ2HJuAzXfIFDr+spKk6sbseKAxIm/r6aQYJCIUT506JMtQdt5PsUSVB+7n6XKQiCEPPf//+caogiLoj6QwPB21aSQAOgpxKJIxIw/Ezl3xcHC5X6xqnesKjZI9Ms8Osf0LC/EPxDgTlz3jumZCcqGOMwbUHAZ9gl46pmomOJAPxFPlblwiy4UtObF7e141V1S9Vv/iX6QV91woElbnY9VGVNdAPpybpzMQG0VoSJJG3jru6UIg+i7hHcjykLmmMTyWxl22gYQFLZW0U/atNzSQDZVmWOs4UlQB/aeOhKvUc7cesMHWhN2Jmso4VPCjhOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C5UJGrElnDzIOQt9F1pCF7yYUZo/fLx3mH+HkfTkSd0=;
 b=KwCUQqMLM3zDfnRW8dVhrZNKhiCVYP2zfnU5WtrSX8e3ijKuTKm47wxQQ6ZaJjgmc/YujdlKoCHNp0SblXZJ65Fb/3B3OXEFU1volGonME+A0AWtcNHY7dD45qVrdhEqk3OwOHrAVoI7RKfsQiy+y6NHbZyoDBjEfEdeYeaLbVE=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by PH0PR10MB5794.namprd10.prod.outlook.com (2603:10b6:510:f4::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28; Tue, 25 Oct
 2022 23:39:42 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::21ec:d1ee:2a59:a1d0]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::21ec:d1ee:2a59:a1d0%6]) with mapi id 15.20.5746.023; Tue, 25 Oct 2022
 23:39:41 +0000
Message-ID: <dfb14af8-7789-64a8-7c95-23256b657ef0@oracle.com>
Date:   Tue, 25 Oct 2022 16:39:38 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.0
Subject: Re: [PATCH v2 1/2] NFSD: add support for sending CB_RECALL_ANY
Content-Language: en-US
To:     Jeff Layton <jlayton@kernel.org>, chuck.lever@oracle.com
Cc:     linux-nfs@vger.kernel.org
References: <1666462150-11736-1-git-send-email-dai.ngo@oracle.com>
 <1666462150-11736-2-git-send-email-dai.ngo@oracle.com>
 <d43a3dac01f8c4211ec7634a0d78dae70468f39b.camel@kernel.org>
 <efbea8dd-1998-fe2a-1a94-6becc5ea691f@oracle.com>
 <342dd03eea9a1eccf1848c1e2f5f92791c4c42f2.camel@kernel.org>
 <ffcf7b71-8afd-bea1-9757-e7e0dc36f187@oracle.com>
 <df4ee39e5cda843416e7a88addabcba25594d618.camel@kernel.org>
 <fdfb20c4217f235d1754d3bf792e32811a760f32.camel@kernel.org>
From:   dai.ngo@oracle.com
In-Reply-To: <fdfb20c4217f235d1754d3bf792e32811a760f32.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0102.namprd04.prod.outlook.com
 (2603:10b6:806:122::17) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4257:EE_|PH0PR10MB5794:EE_
X-MS-Office365-Filtering-Correlation-Id: 30934e72-3109-4fce-7dc2-08dab6e2305f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7rnGuFT5pCYuA538x/Dhc3CJy/iMiM522b/R5IbQGhkhMCllzqCeQvTHR+u7nNdAvT1PH6MiLa/K+U8wPH57xUFICDk1GfnIhhcvXZGYUA108VRlFW7nYVrV457irfrRBIfmtmnM9k1mcgKjOPbytXRMz5PkwOb69wjKfLPT+bLSBkTflSnPbhcQY88pxpTCzjlEJOV4qB+J/RHjVQLyAL7n1lWTJVL9tvU2fK9NHZKsBhcsloEiOyaAsRDr6mUARvOxliutF8T9vhEBLik7ifzpWYGOo5Qv2shod0qzK1ybA97NfeWHE4VPLzJRLXF+hnvJx4Kxb27ocMoQwt6LAPZEytnKF00Vvvv0qPg2xMScJi6dvjly/985N6fVX8RAxB/wKS3YLL5Ngsz/YyOy4dB8OZVJQ19w/ok5PkC1cr+p5a9EOyAeoz1w10IzesyrftT6QrdqyojuaeKHauYJXkv4cLQB+BiOmi6161YTSwsfICZoOQ784QYnNo8jJSiXY8aUBM17RDZ/AGMcmny8PXg+imf6h39U6jsLqebMhCiQJtusWXamg84BsvMKU0S2yor5BP/xuXSoZf0z/Xz2oM7VfakrSTxg+S5l1tVgl6nguc7e8T/RsEsYM6N7cbh5UVIi7eJuQzOBZm4axXRJuZvucO1D23i0hN3P7X7Mz8VsgAaCH2L763ugqkgGl8omEaCLI3nFYFNOioJvTwfeV12h60J/Zs59Hhx1LvavISuVk0xg8HQmJ+SubJXrlr7V5fB1WoOsEGLGsrL1E5u9XQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(136003)(346002)(376002)(366004)(39860400002)(451199015)(26005)(6506007)(6666004)(53546011)(6512007)(9686003)(83380400001)(186003)(478600001)(4001150100001)(2906002)(2616005)(316002)(6486002)(8936002)(66946007)(30864003)(4326008)(8676002)(66476007)(66556008)(5660300002)(41300700001)(31696002)(86362001)(36756003)(38100700002)(31686004)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eGlKR3hsZzRTNW41L1Y3NXA0ZHdUQnI5WllTRndVRjB3eG5jV0l0cnBXRkxj?=
 =?utf-8?B?cDYwUE9seFBPR1hXbDBvS0V6MldNcjlqNXQ5MHJCcktBMkNGT0FTZTI0cTlJ?=
 =?utf-8?B?TUZkSVFLRFpTbEduZmwvTWpBVGZOOU13Zk5ISWxPMml4WUhGNkwyU2hob1U0?=
 =?utf-8?B?UDU5V3d6SFpHeDNzQkoyejBXaEdZVFpXVU9rcmVXNmh2Wi9rYnp3TDVtbU0y?=
 =?utf-8?B?NXhaelgyZHpUWElKOVI2cWxVVkZIczhDVUhpcmRKL0FwQXVwZUI1S2FoQnh2?=
 =?utf-8?B?UE12MS9rT1pZcmhsZGJrdjM2VTRJcHdvc2ZHeDJwWDZQeXRrdmhINW9nUWZJ?=
 =?utf-8?B?OHdrbk45MEh1YmhiQlE3bUNjNWVndWMrSTlnd0tDY0JCdS9aUldDOFBZVkxV?=
 =?utf-8?B?YUk5RCtlSE0xZ2FyWENCazZ6TCtlRlpjSWlidVpQM205Q1ZVK1hzQmZtTFlh?=
 =?utf-8?B?VWQ4bWJkR0NxSUJUYVoveWEvVG5sRlZKditHQnFWdmRMTTlzeUFLbUJmNjdD?=
 =?utf-8?B?V0xoUWRUdHVPTkwrR05pZDc5TWpja3VnMHJySGNFK3hoNXZlVlVtbFNQT3FH?=
 =?utf-8?B?VmxrejI4V2NyY0tOSGgvSnB3NUVzV0pyRjZTUzZPbXl2VU1pVjVHc3FDb09v?=
 =?utf-8?B?VzNsZWRtaGJlWElid1Z4VVB6c2pjaytYelM5MVhPQ1dSREdqSkpXKzNYdCtK?=
 =?utf-8?B?SktDV0ZGNU5COFM3WUlsd2tWV2VNQWRlVytoOFRMZVc3eWhCb3o3Zk1hQ1VL?=
 =?utf-8?B?dmJ5ZTVPV0k4cGJBN0NISXpUdTlHSmVnbnN4RnBTUGdlUXBmQ0plZGR1VVRr?=
 =?utf-8?B?TnVsM0NRbXAvV3p5bE5jNmdHS1Z2ejYzdG1Ta1p2SFR4ZnFQalhFWVNSWStG?=
 =?utf-8?B?bE1HVDVyQnVCd0Q2b1c1ZXlscFpwTEp6djhJWnl2bHVMMVlPZjQrSFNRRWl5?=
 =?utf-8?B?SWo2ejZqamUvbzhRK1dOdFRZUGw4N3dOWDZoaHAreHB4RXZzNWNScXJ6MHRx?=
 =?utf-8?B?SVFqTHpTbEFSVlgzeFJ4RnlOeGtETllMQi9taFN2NDV3KzBscEtaSUdxVHpY?=
 =?utf-8?B?WjFrb0hVZjF2dE5jN3EzdnVrOFMvUnhjUzNHeFNJaG41U3VkVEhxaElDTHJw?=
 =?utf-8?B?aCtoS05ZekIyNVFzQkU0Y3VRVkp2Z3hGWVVkd08zVDJocGVKdnpBR0FiL2Ir?=
 =?utf-8?B?eXNJVlFDZ2pHS2JuVUx4MXE3ZTJ0VVRrTm9KTkY2bER6YWJjTnNSZjFvQmFN?=
 =?utf-8?B?Y20xOXVmbmVhbWZZNGlsQ0w4dGhLcWlyMW1CaC9uTURHQml5TFJKbE9Bbjhl?=
 =?utf-8?B?TDhoc3hrR0xoWGdhRThOZjM1eEtUUTV4K1A1VW1RUTBwRWd0Wm1vbmIvVUc0?=
 =?utf-8?B?dUJuN3pOdk1BbC9oRzFYVTZJZEpRbHFsdE1neC95bk0rREg1WkhqSUhnam1L?=
 =?utf-8?B?b3FIeS9ZSUh0TC9peGFtaUdnb00rY09SbXRaQzNadXhRMHB4eDZJVUVma3lR?=
 =?utf-8?B?ZTh1amFVTUwzWENTUm95eEJ6RURPTEVLL0ZzRm5JVXVwenRIaHRsakhVeGlR?=
 =?utf-8?B?K1NvRHlEa2hiR3RUVXp2Q2E0NENYeDZQTDFnUSswTE5LeTNFdTlFNUNQTWll?=
 =?utf-8?B?YU1QQzlkK3RieWtjTExSZ1JiVVBndXVndWQweEVDcUd1NWV0eHUyeWRqQTFn?=
 =?utf-8?B?RHJBcUVMc3dzZm1VWVB0UUtmdTRVNENaUlJNTXdnRXA0YW53SDFKMWdnYzVN?=
 =?utf-8?B?RTExTWZLclpKSHpRa0NtTnFyOGU5L1VCT1pzNzZrdDVIT1RUbGNhWVlITDlP?=
 =?utf-8?B?c3BYZVVsM21UQXJxNnVXK05VaGZOTE5QS013Q3NsdWpzRlRHZ1ZydThSODJC?=
 =?utf-8?B?SzlXbU1hTmVPbWpoWk9qOERYbm5GYlhoRkowRGFMRjlwMVc1MHo1RkVZbEZD?=
 =?utf-8?B?NXIxRzV3SVNhK2VQK1BiM1pxalNFKzlaRkN0NW9uYTNNSWR0ZFFLRkNBbXFK?=
 =?utf-8?B?VDY3UEVxL0xjTHBpUjVwVG5OY3FDdVNtNFptUDZJS2tKS0tFR2lvb3Nzbi81?=
 =?utf-8?B?czgwdWRqaU5ra2tqRk9iemdWR3BRUWU5SzRQL3cvWDF6aUdQOGcyU3VtcnhF?=
 =?utf-8?Q?Nb84loQ4mVthT0SJIkkihv76P?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30934e72-3109-4fce-7dc2-08dab6e2305f
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2022 23:39:41.8350
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m1uKNJthObVFJ2oOJiBCPQwu6kQnozgnov+ntkkUEwB/Zfb+HVkEe0slZ1Ah/ec/isPkRPgKzsjlNdPzDDIElw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5794
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-25_13,2022-10-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 suspectscore=0 malwarescore=0 phishscore=0 mlxscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210250130
X-Proofpoint-GUID: gO48IZ-Y9mQXKf1Ln1ZoiEvbyn6NO4G_
X-Proofpoint-ORIG-GUID: gO48IZ-Y9mQXKf1Ln1ZoiEvbyn6NO4G_
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


On 10/25/22 2:37 AM, Jeff Layton wrote:
> On Tue, 2022-10-25 at 05:33 -0400, Jeff Layton wrote:
>> On Mon, 2022-10-24 at 18:30 -0700, dai.ngo@oracle.com wrote:
>>> On 10/24/22 2:09 PM, Jeff Layton wrote:
>>>> On Mon, 2022-10-24 at 12:44 -0700, dai.ngo@oracle.com wrote:
>>>>> On 10/24/22 5:16 AM, Jeff Layton wrote:
>>>>>> On Sat, 2022-10-22 at 11:09 -0700, Dai Ngo wrote:
>>>>>>> There is only one nfsd4_callback, cl_recall_any, added for each
>>>>>>> nfs4_client. Access to it must be serialized. For now it's done
>>>>>>> by the cl_recall_any_busy flag since it's used only by the
>>>>>>> delegation shrinker. If there is another consumer of CB_RECALL_ANY
>>>>>>> then a spinlock must be used.
>>>>>>>
>>>>>>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>>>>>>> ---
>>>>>>>     fs/nfsd/nfs4callback.c | 64 ++++++++++++++++++++++++++++++++++++++++++++++++++
>>>>>>>     fs/nfsd/nfs4state.c    | 27 +++++++++++++++++++++
>>>>>>>     fs/nfsd/state.h        |  8 +++++++
>>>>>>>     fs/nfsd/xdr4cb.h       |  6 +++++
>>>>>>>     4 files changed, 105 insertions(+)
>>>>>>>
>>>>>>> diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
>>>>>>> index f0e69edf5f0f..03587e1397f4 100644
>>>>>>> --- a/fs/nfsd/nfs4callback.c
>>>>>>> +++ b/fs/nfsd/nfs4callback.c
>>>>>>> @@ -329,6 +329,29 @@ static void encode_cb_recall4args(struct xdr_stream *xdr,
>>>>>>>     }
>>>>>>>     
>>>>>>>     /*
>>>>>>> + * CB_RECALLANY4args
>>>>>>> + *
>>>>>>> + *	struct CB_RECALLANY4args {
>>>>>>> + *		uint32_t	craa_objects_to_keep;
>>>>>>> + *		bitmap4		craa_type_mask;
>>>>>>> + *	};
>>>>>>> + */
>>>>>>> +static void
>>>>>>> +encode_cb_recallany4args(struct xdr_stream *xdr,
>>>>>>> +			struct nfs4_cb_compound_hdr *hdr, uint32_t bmval)
>>>>>>> +{
>>>>>>> +	__be32 *p;
>>>>>>> +
>>>>>>> +	encode_nfs_cb_opnum4(xdr, OP_CB_RECALL_ANY);
>>>>>>> +	p = xdr_reserve_space(xdr, 4);
>>>>>>> +	*p++ = xdr_zero;	/* craa_objects_to_keep */
>>>>>>> +	p = xdr_reserve_space(xdr, 8);
>>>>>>> +	*p++ = cpu_to_be32(1);
>>>>>>> +	*p++ = cpu_to_be32(bmval);
>>>>>>> +	hdr->nops++;
>>>>>>> +}
>>>>>>> +
>>>>>>> +/*
>>>>>>>      * CB_SEQUENCE4args
>>>>>>>      *
>>>>>>>      *	struct CB_SEQUENCE4args {
>>>>>>> @@ -482,6 +505,24 @@ static void nfs4_xdr_enc_cb_recall(struct rpc_rqst *req, struct xdr_stream *xdr,
>>>>>>>     	encode_cb_nops(&hdr);
>>>>>>>     }
>>>>>>>     
>>>>>>> +/*
>>>>>>> + * 20.6. Operation 8: CB_RECALL_ANY - Keep Any N Recallable Objects
>>>>>>> + */
>>>>>>> +static void
>>>>>>> +nfs4_xdr_enc_cb_recall_any(struct rpc_rqst *req,
>>>>>>> +		struct xdr_stream *xdr, const void *data)
>>>>>>> +{
>>>>>>> +	const struct nfsd4_callback *cb = data;
>>>>>>> +	struct nfs4_cb_compound_hdr hdr = {
>>>>>>> +		.ident = cb->cb_clp->cl_cb_ident,
>>>>>>> +		.minorversion = cb->cb_clp->cl_minorversion,
>>>>>>> +	};
>>>>>>> +
>>>>>>> +	encode_cb_compound4args(xdr, &hdr);
>>>>>>> +	encode_cb_sequence4args(xdr, cb, &hdr);
>>>>>>> +	encode_cb_recallany4args(xdr, &hdr, cb->cb_clp->cl_recall_any_bm);
>>>>>>> +	encode_cb_nops(&hdr);
>>>>>>> +}
>>>>>>>     
>>>>>>>     /*
>>>>>>>      * NFSv4.0 and NFSv4.1 XDR decode functions
>>>>>>> @@ -520,6 +561,28 @@ static int nfs4_xdr_dec_cb_recall(struct rpc_rqst *rqstp,
>>>>>>>     	return decode_cb_op_status(xdr, OP_CB_RECALL, &cb->cb_status);
>>>>>>>     }
>>>>>>>     
>>>>>>> +/*
>>>>>>> + * 20.6. Operation 8: CB_RECALL_ANY - Keep Any N Recallable Objects
>>>>>>> + */
>>>>>>> +static int
>>>>>>> +nfs4_xdr_dec_cb_recall_any(struct rpc_rqst *rqstp,
>>>>>>> +				  struct xdr_stream *xdr,
>>>>>>> +				  void *data)
>>>>>>> +{
>>>>>>> +	struct nfsd4_callback *cb = data;
>>>>>>> +	struct nfs4_cb_compound_hdr hdr;
>>>>>>> +	int status;
>>>>>>> +
>>>>>>> +	status = decode_cb_compound4res(xdr, &hdr);
>>>>>>> +	if (unlikely(status))
>>>>>>> +		return status;
>>>>>>> +	status = decode_cb_sequence4res(xdr, cb);
>>>>>>> +	if (unlikely(status || cb->cb_seq_status))
>>>>>>> +		return status;
>>>>>>> +	status =  decode_cb_op_status(xdr, OP_CB_RECALL_ANY, &cb->cb_status);
>>>>>>> +	return status;
>>>>>>> +}
>>>>>>> +
>>>>>>>     #ifdef CONFIG_NFSD_PNFS
>>>>>>>     /*
>>>>>>>      * CB_LAYOUTRECALL4args
>>>>>>> @@ -783,6 +846,7 @@ static const struct rpc_procinfo nfs4_cb_procedures[] = {
>>>>>>>     #endif
>>>>>>>     	PROC(CB_NOTIFY_LOCK,	COMPOUND,	cb_notify_lock,	cb_notify_lock),
>>>>>>>     	PROC(CB_OFFLOAD,	COMPOUND,	cb_offload,	cb_offload),
>>>>>>> +	PROC(CB_RECALL_ANY,	COMPOUND,	cb_recall_any,	cb_recall_any),
>>>>>>>     };
>>>>>>>     
>>>>>>>     static unsigned int nfs4_cb_counts[ARRAY_SIZE(nfs4_cb_procedures)];
>>>>>>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>>>>>>> index 4e718500a00c..c60c937dece6 100644
>>>>>>> --- a/fs/nfsd/nfs4state.c
>>>>>>> +++ b/fs/nfsd/nfs4state.c
>>>>>>> @@ -2854,6 +2854,31 @@ static const struct tree_descr client_files[] = {
>>>>>>>     	[3] = {""},
>>>>>>>     };
>>>>>>>     
>>>>>>> +static int
>>>>>>> +nfsd4_cb_recall_any_done(struct nfsd4_callback *cb,
>>>>>>> +			struct rpc_task *task)
>>>>>>> +{
>>>>>>> +	switch (task->tk_status) {
>>>>>>> +	case -NFS4ERR_DELAY:
>>>>>>> +		rpc_delay(task, 2 * HZ);
>>>>>>> +		return 0;
>>>>>>> +	default:
>>>>>>> +		return 1;
>>>>>>> +	}
>>>>>>> +}
>>>>>>> +
>>>>>>> +static void
>>>>>>> +nfsd4_cb_recall_any_release(struct nfsd4_callback *cb)
>>>>>>> +{
>>>>>>> +	cb->cb_clp->cl_recall_any_busy = false;
>>>>>>> +	atomic_dec(&cb->cb_clp->cl_rpc_users);
>>>>>>> +}
>>>>>> This series probably ought to be one big patch. The problem is that
>>>>>> you're adding a bunch of code to do CB_RECALL_ANY, but there is no way
>>>>>> to call it without patch #2.
>>>>> The reason I separated these patches is that the 1st patch, adding support
>>>>> CB_RECALL_ANY can be called for other purposes than just for delegation such
>>>>> as to recall pnfs layouts, or when the max number of delegation is reached.
>>>>> So that was why I did not combined this patches. However, I understand your
>>>>> concern about not being able to test individual patch. So as Chuck suggested,
>>>>> perhaps we can leave these as separate patches for easier review and when it's
>>>>> finalized we can decide to combine them in to one big patch.  BTW, I plan to
>>>>> add a third patch to this series to send CB_RECALL_ANY to clients when the
>>>>> max number of delegations is reached.
>>>>>
>>>> I think we should get this bit sorted out first,
>>> ok
>>>
>>>>    but that sounds
>>>> reasonable eventually.
>>>>
>>>>>> That makes it hard to judge whether there could be races and locking
>>>>>> issues around the handling of cb_recall_any_busy, in particular. From
>>>>>> patch #2, it looks like cb_recall_any_busy is protected by the
>>>>>> nn->client_lock, but I don't think ->release is called with that held.
>>>>> I don't intended to use the nn->client_lock, I think the scope of this
>>>>> lock is too big for what's needed to serialize access to struct nfsd4_callback.
>>>>> As I mentioned in the cover email, since the cb_recall_any_busy is only
>>>>> used by the deleg_reaper we do not need a lock to protect this flag.
>>>>> But if there is another of consumer, other than deleg_reaper, of this
>>>>> nfsd4_callback then we can add a simple spinlock for it.
>>>>>
>>>>> My question is do you think we need to add the spinlock now instead of
>>>>> delaying it until there is real need?
>>>>>
>>>> I don't see the need for a dedicated spinlock here. You said above that
>>>> there is only one of these per client, so you could use the
>>>> client->cl_lock.
>>>>
>>>> But...I don't see the problem with doing just using the nn->client_lock
>>>> here. It's not like we're likely to be calling this that often, and if
>>>> we do then the contention for the nn->client_lock is probably the least
>>>> of our worries.
>>> If the contention on nn->client_lock is not a concern then I just
>>> leave the patch to use the nn->client_lock as it current does.
>>>
>> Except you aren't taking the client_lock in ->release. That's what needs
>> to be added if you want to keep this boolean.
>>
>>>> Honestly, do we need this boolean at all? The only place it's checked is
>>>> in deleg_reaper. Why not just try to submit the work and if it's already
>>>> queued, let it fail?
>>> There is nothing in the existing code to prevent the nfs4_callback from
>>> being used again before the current CB_RECALL_ANY request completes. This
>>> resulted in se_cb_seq_nr becomes out of sync with the client and server
>>> starts getting NFS4ERR_SEQ_MISORDERED then eventually NFS4ERR_BADSESSION
>>> from the client.
>>>
>>> nfsd4_recall_file_layout has similar usage of nfs4_callback and it uses
>>> the ls_lock to make sure the current request is done before allowing new
>>> one to proceed.
>>>
>> That's a little different. The ls_lock protects ls_recalled, which is
>> set when a recall is issued. We only want to issue a recall for a
>> delegation once and that's what ensures that it's only issued once.
>>
>> CB_RECALL_ANY could be called more than once per client. We don't need
>> to ensure "exactly once" semantics there. All of the callbacks are run
>> out of workqueues.
>>
>> If a workqueue job is already scheduled then queue_work will return
>> false when called. Could you just do away with this boolean and rely on
>> the return code from queue_work to ensure that it doesn't get scheduled
>> too often?
>>
>>>>>> Also, cl_rpc_users is a refcount (though we don't necessarily free the
>>>>>> object when it goes to zero). I think you need to call
>>>>>> put_client_renew_locked here instead of just decrementing the counter.
>>>>> Since put_client_renew_locked() also renews the client lease, I don't
>>>>> think it's right nfsd4_cb_recall_any_release to renew the lease because
>>>>> because this is a callback so the client is not actually sending any
>>>>> request that causes the lease to renewed, and nfsd4_cb_recall_any_release
>>>>> is also alled even if the client is completely dead and did not reply, or
>>>>> reply with some errors.
>>>>>
>>>> What happens when this atomic_inc makes the cl_rpc_count go to zero?
>>> Do you mean atomic_dec of cl_rpc_users?
>>>
>> Yes, sorry.
>>
>>>> What actually triggers the cleanup activities in put_client_renew /
>>>> put_client_renew_locked in that situation?
>>> maybe I'm missing something, but I don't see any client cleanup
>>> in put_client_renew/put_client_renew_locked other than renewing
>>> the lease?
>>>
>>>
>>          if (!is_client_expired(clp))
>>                  renew_client_locked(clp);
>>          else
>>                  wake_up_all(&expiry_wq);
>>
>>
>> ...unless the client has already expired, in which case you need to wake
>> up the waitqueue. My guess is that if the atomic_dec you're calling here
>> goes to zero then any tasks on the expiry_wq will hang indefinitely.
>>
> I'm not sure you need to take a reference to the client here at all. Can
> the client go away while a callback job is still running? You may be
> able to assume that it will stick around for the life of the callback
> (though you should verify this before assuming it).

I think without increment cl_rpc_users, the client lease can be expired and
client being destroyed while CB_RECALL_ANY request has not completed yet.

-Dai

>
>>>>>>> +
>>>>>>> +static const struct nfsd4_callback_ops nfsd4_cb_recall_any_ops = {
>>>>>>> +	.done		= nfsd4_cb_recall_any_done,
>>>>>>> +	.release	= nfsd4_cb_recall_any_release,
>>>>>>> +};
>>>>>>> +
>>>>>>>     static struct nfs4_client *create_client(struct xdr_netobj name,
>>>>>>>     		struct svc_rqst *rqstp, nfs4_verifier *verf)
>>>>>>>     {
>>>>>>> @@ -2891,6 +2916,8 @@ static struct nfs4_client *create_client(struct xdr_netobj name,
>>>>>>>     		free_client(clp);
>>>>>>>     		return NULL;
>>>>>>>     	}
>>>>>>> +	nfsd4_init_cb(&clp->cl_recall_any, clp, &nfsd4_cb_recall_any_ops,
>>>>>>> +			NFSPROC4_CLNT_CB_RECALL_ANY);
>>>>>>>     	return clp;
>>>>>>>     }
>>>>>>>     
>>>>>>> diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
>>>>>>> index e2daef3cc003..49ca06169642 100644
>>>>>>> --- a/fs/nfsd/state.h
>>>>>>> +++ b/fs/nfsd/state.h
>>>>>>> @@ -411,6 +411,10 @@ struct nfs4_client {
>>>>>>>     
>>>>>>>     	unsigned int		cl_state;
>>>>>>>     	atomic_t		cl_delegs_in_recall;
>>>>>>> +
>>>>>>> +	bool			cl_recall_any_busy;
>>>>>>> +	uint32_t		cl_recall_any_bm;
>>>>>>> +	struct nfsd4_callback	cl_recall_any;
>>>>>>>     };
>>>>>>>     
>>>>>>>     /* struct nfs4_client_reset
>>>>>>> @@ -639,8 +643,12 @@ enum nfsd4_cb_op {
>>>>>>>     	NFSPROC4_CLNT_CB_OFFLOAD,
>>>>>>>     	NFSPROC4_CLNT_CB_SEQUENCE,
>>>>>>>     	NFSPROC4_CLNT_CB_NOTIFY_LOCK,
>>>>>>> +	NFSPROC4_CLNT_CB_RECALL_ANY,
>>>>>>>     };
>>>>>>>     
>>>>>>> +#define RCA4_TYPE_MASK_RDATA_DLG	0
>>>>>>> +#define RCA4_TYPE_MASK_WDATA_DLG	1
>>>>>>> +
>>>>>>>     /* Returns true iff a is later than b: */
>>>>>>>     static inline bool nfsd4_stateid_generation_after(stateid_t *a, stateid_t *b)
>>>>>>>     {
>>>>>>> diff --git a/fs/nfsd/xdr4cb.h b/fs/nfsd/xdr4cb.h
>>>>>>> index 547cf07cf4e0..0d39af1b00a0 100644
>>>>>>> --- a/fs/nfsd/xdr4cb.h
>>>>>>> +++ b/fs/nfsd/xdr4cb.h
>>>>>>> @@ -48,3 +48,9 @@
>>>>>>>     #define NFS4_dec_cb_offload_sz		(cb_compound_dec_hdr_sz  +      \
>>>>>>>     					cb_sequence_dec_sz +            \
>>>>>>>     					op_dec_sz)
>>>>>>> +#define NFS4_enc_cb_recall_any_sz	(cb_compound_enc_hdr_sz +       \
>>>>>>> +					cb_sequence_enc_sz +            \
>>>>>>> +					1 + 1 + 1)
>>>>>>> +#define NFS4_dec_cb_recall_any_sz	(cb_compound_dec_hdr_sz  +      \
>>>>>>> +					cb_sequence_dec_sz +            \
>>>>>>> +					op_dec_sz)
