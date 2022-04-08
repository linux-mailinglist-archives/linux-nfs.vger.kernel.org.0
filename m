Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD6B84F9FCC
	for <lists+linux-nfs@lfdr.de>; Sat,  9 Apr 2022 00:56:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235844AbiDHW6X (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 8 Apr 2022 18:58:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235826AbiDHW6W (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 8 Apr 2022 18:58:22 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9A1B286C9
        for <linux-nfs@vger.kernel.org>; Fri,  8 Apr 2022 15:56:16 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 238LtbtS000752;
        Fri, 8 Apr 2022 22:56:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=438DkwcT+JtsaJODyyv+ZhmFkUdnZM+r5EfW1oEuGRs=;
 b=UpvTqLkPs+GDSVNVmnaAwtpFZQbHsGnXZAmTEODJOJaH9fiOTElQ/OTZ/Juo2QIfdAtD
 zeBiL7YPzKd50hOIaTT5o+aO7y9qWSDXVDyuUxeS3CerHb0ahC8jaQQge2ZvR8YKsShx
 gPCvxSPzxeJvAmAR7sFqBcP2Jcr5KppCmPb2D0knLX6y9Md7ZXpBoa7WCkNBTMlmcamq
 7RYebl9UTA/pxChocK7EMrKCWuKaecPefERv+5zPXpzD4ORvV7ObZ0nExqXUlDMkZdwX
 VhNMwuagr6FTdiDDGFC/w5zQOTuJQRVfBPOZuL1MrrRfK1RRCWLAW8RByV+Q+KcovFeL /g== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f6e3t0ahy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 08 Apr 2022 22:56:14 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 238Mkuwe029255;
        Fri, 8 Apr 2022 22:56:13 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2173.outbound.protection.outlook.com [104.47.56.173])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3f97y9e2wk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 08 Apr 2022 22:56:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RVHBGdVdi8VnuaLAEeB/QM1k1MFpNlSXuFySeJV0UQiBvHR8lgYzXNmrlKbJD7yC5+67K4LvS/Lo3d3eUcitXPjGi0YuQsGfudVKJHCKDecpvMRHjjGP8v77bGKXmD0WMdMbi1Ae+aRIOfLGuE9KNaTgMIt9oAV71QXqTLOLCsYJ1IUorAnmIIb2/+oEj6d1C0+RlWGFvswYeTXvEIKGIy+1kUg+vDesKI51nTaCBu/u9lClnqCMx/0+ZIUV9ObtfB4A9CbR9GbpBkq5FXFyS7JBuknemdtMDO0YSrz+FXNWIHxHankCXpl+3iM4NuUFT6osNz8O/2SffVEQ3doTHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=438DkwcT+JtsaJODyyv+ZhmFkUdnZM+r5EfW1oEuGRs=;
 b=gbO4IDcKcR2RMmS7B+TpBZo7VY1BGjwW4OeNpM70R/v63fwOeJap7Up0uydBA8f5/Q1BuE6GhmC0B7wWIbC/SWapKMdLPEmkPJ/EmtFgzfc73Psl3xmQb23ekRwZQhleRIKV1rYGbuY4vIzBvGp/QJvuDdjalBtWNE3hQOmZQgJGpsChP3lFiVmeax9UK0MtAAD6hODAjaDijsYtanfqhyVO1MON2hKhdDyoxPKZKkcQPQM4QrpZ35CU8a58Gzs8FNY7+gqoJE92tMgB5dXpH+S1hmAG9XpRra2K86WNzVgIAZc1tAYwCqoaMo1VQ50UQSYgH2qjf1vBHk3c8eoOtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=438DkwcT+JtsaJODyyv+ZhmFkUdnZM+r5EfW1oEuGRs=;
 b=zUlHCgS9AU2y1XfJDG0HLEkObJV5++g3Zq2cWymDN8WAvA4SRyhplNX0usTAz5gSom2hIn4GLuoaoUbRMKdMLIvY32jc0b5T+mBkNRhzAmZYg88qAV1FaPM8mnOEmg8JhzUVKcsvCzaFKK9UXY2tXnSqd5YfA5P9Z3LOeC1eg80=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by MWHPR1001MB2367.namprd10.prod.outlook.com (2603:10b6:301:30::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.22; Fri, 8 Apr
 2022 22:56:11 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::856b:6a4a:7f60:df74]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::856b:6a4a:7f60:df74%7]) with mapi id 15.20.5144.022; Fri, 8 Apr 2022
 22:56:11 +0000
Message-ID: <f00542ac-ba4b-a7b5-a2d2-62f229451ded@oracle.com>
Date:   Fri, 8 Apr 2022 15:56:09 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.7.0
Subject: Re: [PATCH RFC v20 0/10] NFSD: Initial implementation of NFSv4
 Courteous Server
Content-Language: en-US
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     chuck.lever@oracle.com, linux-nfs@vger.kernel.org
References: <1649285133-16765-1-git-send-email-dai.ngo@oracle.com>
 <20220408163956.GB6423@fieldses.org>
From:   dai.ngo@oracle.com
In-Reply-To: <20220408163956.GB6423@fieldses.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR04CA0014.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::24) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 70bb016f-e486-490b-5b63-08da19b2f9cd
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2367:EE_
X-Microsoft-Antispam-PRVS: <MWHPR1001MB236727E680090771E8B8294187E99@MWHPR1001MB2367.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X/oOgyXF4NJclaAppoMY33DUh/7mYEUjraYJ44pPcKwHlAwaNinkHdAjsmEsv6Bu2I/fch4AWkDWwzpVpqlU+tUL/6Sc8yyy5UBBE+PFWPykniwOLIXT8s2eew0ZayKvmVuTPAFogM47YiVRgwTT66LRsnF//aeJvaqKM67fA4X0wJiAhtOGFtTTRZJDjFAlnV65kbYDVvGAAuBhaPwmjqeyixCyf+/4r/6yYxpaYBLJcIB6X+Hz3VSe4DgtGRbE4+Pinw3x/KuM32jIS9I8vNMxGYP+gM071bWT4hlyKnSzag8Y+lRn0j7cayOuNwMhLGBASYncBi4ZvKrKUfJWeABluSPc5xIQspB1dJW7y65QTUsd+DlE28iZ9dTB4AJ46KEWRcceDopt4+W8AgwNggwW/PsIh1JTl6PxAgvqkhn37DiAUVketWz7LobZahd/0aGo5Nt0W2YKLvB2POKOHllz58ngvO7SrBZBwdHcbGKAFkruqAw5LrapEIMelJOk8I0lO4l/uaxGqKo6Vv83LZiwl+WPuw0l+ls0BQ1AGD1Y+OfSvWD++uteYQnAvpwRLx0ryDuKmqDX7kbbyTkzMDUuXJa7FWL/IYu6cCM7AQ8AS2iSlCtF+YFg3d70GKPOKE4jeLGY5oO+fGPlrwNL9rKnt56ARw83oBaibqIWHhAZsGvzzgW6aYQYlqbfvbIvXb+m5F9C3xBNE191Ob+2SA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2906002)(31696002)(6486002)(86362001)(53546011)(36756003)(508600001)(83380400001)(9686003)(6512007)(38100700002)(2616005)(4326008)(8676002)(66946007)(66556008)(66476007)(5660300002)(6916009)(186003)(8936002)(316002)(6506007)(31686004)(30864003)(26005)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VUc3b2JGSHJZc04wSzJnSThoa1J0YVhRa1pEWm5pNTlwd1EzeGVNbFNzT1Qw?=
 =?utf-8?B?WUNBb3dMS0hrK2FTcjUweGxFNFRpeU0zRTJwUEU0ZmRPdUluc2hIeDlFa0xE?=
 =?utf-8?B?MFNibENkQkIvd2pxZDM0QjBobkN5c0g3S2VUYXZ0dHNpdTl5Smx6clh1dTV6?=
 =?utf-8?B?U3YvV3pBNzVZSlVXckMwQ0ZsYTk1NWVWWExDRnJGVllJbThPMU5mRklOSWpY?=
 =?utf-8?B?K0ZmMWdYUW1TbnlmSEc5NlhKWk9LTXgvVUcvZG9LT20rTFh0OE1ZRGIwbUFC?=
 =?utf-8?B?Nm9XVi83dDVJVDV5VzhTcXpnRnZ6VlpNM2QxY0lBc0dROWs5WVloRnR5R3Jm?=
 =?utf-8?B?dlVsM2loMDFxS3hBWGNRb0VmY0VaUGtUQ3ZkbXlnMGE4LzBTZ0YvVEF6RU52?=
 =?utf-8?B?SEJRMUVCSU8waHYzaDZpRjc5WHgzK2t3RjR5OFY4ZklpaWpHbXdGVzBtY29s?=
 =?utf-8?B?c1loQ0tmaFZKRXZwK05PbFY0VVlGYitvRC9GcmN0QXV2c0tiOVVsdkJnQjMw?=
 =?utf-8?B?RWk4ck5DMmw1QVRrVi81d2ZnNWxORGVwdFNraS92V3hMaDlXT2lnSUYzTWRU?=
 =?utf-8?B?eXRGMmIxd2o1U0R0R3J6UHVxdWx4ZVNMLzFsSTdLajZ6QUtpMEQ5V21Ucksr?=
 =?utf-8?B?cW40dW9JQy9lZ0NlaUttNldjWDZBM0NjbVNRQ3hOZm1HbDZETUxIdWtFc29D?=
 =?utf-8?B?SzZISVBNN1hpeDY1WldLVGhWWXFpSk5Ib1BOVWRRNjZyWnprK2FHbFJsc1du?=
 =?utf-8?B?bVRCbSs2c2FGQ0VBazhZTitRTlVPb2l5dEt6c0cyRWQ3YnZVTFFjS0RtRkw3?=
 =?utf-8?B?ZVd3czdrSHhsbVprUFBIVFlqcnA2dlkrM0ZWMmxtRXdlRkdaTDc2SUlrQVlD?=
 =?utf-8?B?SWNqYlgxR3JvVjJrVnZQKzhYTVpwRFF3RVpXR21pUThXazVzOTFmWG9jN0J0?=
 =?utf-8?B?QjlhRkdkcmtHNlVFUFhjWld3TG9HbmlvOFZIeUFzUlZsWGJydWpPVlZpMlMw?=
 =?utf-8?B?R3B0SU1MNlNqd1Frbm1Tb1k2QWFueHRSYU5vRFNYQmRVYnB1RFhYblhoeWQx?=
 =?utf-8?B?eFVrSzJqdVl1dUZyOHEvT1NMeGJoSmpKcDk2S200WHgrQmNYenNrQTIweXl6?=
 =?utf-8?B?WERRUUpQU1hyM2NDaDZzTGw0QmFyT0tkbkdSc3pybnVDdzErdTg0YmF2bFZG?=
 =?utf-8?B?OG1QTENFdGhVTXloSEZvTlprMkUrcVhCRkFqaUpqaHgycnhobHZQK3JRK1Q3?=
 =?utf-8?B?WnNqNVNPN1ZacUUxZUlZT3lOTDAzbTFBK21IaEpvTmdsL1BLMDdJY1NpQ0pY?=
 =?utf-8?B?TW4rOE90OUlsOUdJaURxdHVCbHJWN1NydkhiSTRuMnhzeGhSbGZmYk9Ua1pJ?=
 =?utf-8?B?VGl0bVZYSkZVRTRVcVJmNEhicjJxK21CTTVxRUVLVGpKdjBHVGUydStHbTBL?=
 =?utf-8?B?c3JPVmJVR29CRFJIVlBMazA4cEYrQXFtYksrTExlK2tGRGZqNEJkMmdTL0Fy?=
 =?utf-8?B?TzB2MWJEbzB1SEkvZXdYRi96OXpDR3pxejB3MFBNTlQvRXlYQVdLTWtjeHp0?=
 =?utf-8?B?ZmVzOXZVN2x4NlEzYWN6bHY0NnA0SmRkL1NvT2hCZjhRVm9ESi92TlVLeXY1?=
 =?utf-8?B?eGIrQnpockZ3Z2YxVHNSSDZRRk5ZZEdqWWt0K1Q5SjN3KzBFbTM3cDdnQnBv?=
 =?utf-8?B?RXMybUp1ZjlzeDY1NzF6R3dkM0Zxb3JZN05vOS9lSnVzY2xtSHI3R0w4TFZ2?=
 =?utf-8?B?YUdoUE1raERMTXRVZ0RxbE9EQnhreDlKdE5XQnFqZ0NXbnFISWcwNUtuVzQx?=
 =?utf-8?B?MnQ2S3hOQUh0ajFSV1RtTU9kN3R5VkIrdFgwK0xtRW5LTDVINmVGRU9CVmt1?=
 =?utf-8?B?V0JOdFkrWnRFU3RzUjg1ZFpLd1RYNHZsU2l0TFJEa2dvOGpwNHQ0dkRXNmFm?=
 =?utf-8?B?UkVtd1kvOUFLZm4rdk9vM0pCTWxHbW82cGZ0cC80QkFiRWt4cmpFOWhWTHls?=
 =?utf-8?B?VW0zQ2Q0QW9ORmZXbGI3ZlNVM1ZlbDhKeU85VWZ1c2JISFRTVzFNYWF6YjZK?=
 =?utf-8?B?QjRUOWFQS0lsT2pIMjNENGRzWDhMMmhVZXNNYUZjRll2Z2E2cTFBOFc5VWJZ?=
 =?utf-8?B?b3EyQjlWMnlhWUpDUy9oRUNiNXE1dkVtSU44M1ZiYnkzNG9MZ0dtSWdGelpG?=
 =?utf-8?B?emZ4a1djWFZNZCt0aXlVbjhhYVk2ZE5kVWtpK3NKTGd4WEV2VUxXMVY1TXR4?=
 =?utf-8?B?WVN0eHFTK3J6Z3hFMTAzbDNPWVRucmtOM2U5Q0VxMDRxZDFCWWlsbW8rMXl0?=
 =?utf-8?B?VUV2c1NyOHVmaEUwdFM1RmhrNC9MckdobU01ZXBibEx2S0RDT3Bodz09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70bb016f-e486-490b-5b63-08da19b2f9cd
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2022 22:56:11.4548
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w3vhOIT1TpHsiZY02G0Cncmze973jiqPE8NrTYKtTgmm3ubUZuJxftgcH2JZCoLbvD5xpvXiLprHYcBWCIWLZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2367
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.858
 definitions=2022-04-08_08:2022-04-08,2022-04-08 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999 spamscore=0
 suspectscore=0 malwarescore=0 phishscore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204080117
X-Proofpoint-ORIG-GUID: Xb8-kwj7ryFrPqaRmdALd-vYa7nP4g3X
X-Proofpoint-GUID: Xb8-kwj7ryFrPqaRmdALd-vYa7nP4g3X
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


On 4/8/22 9:39 AM, J. Bruce Fields wrote:
> I've got a process complaint here.  Not a big deal, but I think we can
> fix it and do a little better:
>
> So, I appreciate that a big patch got split up.  But we're not getting
> all of the advantages of that, because what most of the patches do is
> add new functions that don't actually have callers yet, or code that's
> effectively dead until one of the last patches that actually tells the
> laundromat to start transitioning clients to the courtesy state.
>
> That means when reviewing these, I often have to look forward through
> the patches to understand how the new code that's being added works.
>
> Sometimes that's the best you can do.  But I think we can order these so
> that most of the patches actually make testable changes.  That means
> that if we introduce a bug, a bisect will land on the actual patch that
> introduced the bug instead of a later patch that activated that code.
> It also makes the patches easier to read in isolation.
>
> I'll try to write up a suggestion.

Thank you Bruce, I'm looking forward to your suggestion.

-Dai

>
> --b.
>
> On Wed, Apr 06, 2022 at 03:45:23PM -0700, Dai Ngo wrote:
>> Hi Chuck, Bruce
>>
>> This series of patches implement the NFSv4 Courteous Server.
>>
>> A server which does not immediately expunge the state on lease expiration
>> is known as a Courteous Server.  A Courteous Server continues to recognize
>> previously generated state tokens as valid until conflict arises between
>> the expired state and the requests from another client, or the server
>> reboots.
>>
>> v2:
>>
>> . add new callback, lm_expire_lock, to lock_manager_operations to
>>    allow the lock manager to take appropriate action with conflict lock.
>>
>> . handle conflicts of NFSv4 locks with NFSv3/NLM and local locks.
>>
>> . expire courtesy client after 24hr if client has not reconnected.
>>
>> . do not allow expired client to become courtesy client if there are
>>    waiters for client's locks.
>>
>> . modify client_info_show to show courtesy client and seconds from
>>    last renew.
>>
>> . fix a problem with NFSv4.1 server where the it keeps returning
>>    SEQ4_STATUS_CB_PATH_DOWN in the successful SEQUENCE reply, after
>>    the courtesy client reconnects, causing the client to keep sending
>>    BCTS requests to server.
>>
>> v3:
>>
>> . modified posix_test_lock to check and resolve conflict locks
>>    to handle NLM TEST and NFSv4 LOCKT requests.
>>
>> . separate out fix for back channel stuck in SEQ4_STATUS_CB_PATH_DOWN.
>>
>> v4:
>>
>> . rework nfsd_check_courtesy to avoid dead lock of fl_lock and client_lock
>>    by asking the laudromat thread to destroy the courtesy client.
>>
>> . handle NFSv4 share reservation conflicts with courtesy client. This
>>    includes conflicts between access mode and deny mode and vice versa.
>>
>> . drop the patch for back channel stuck in SEQ4_STATUS_CB_PATH_DOWN.
>>
>> v5:
>>
>> . fix recursive locking of file_rwsem from posix_lock_file.
>>
>> . retest with LOCKDEP enabled.
>>
>> v6:
>>
>> . merge witn 5.15-rc7
>>
>> . fix a bug in nfs4_check_deny_bmap that did not check for matched
>>    nfs4_file before checking for access/deny conflict. This bug causes
>>    pynfs OPEN18 to fail since the server taking too long to release
>>    lots of un-conflict clients' state.
>>
>> . enhance share reservation conflict handler to handle case where
>>    a large number of conflict courtesy clients need to be expired.
>>    The 1st 100 clients are expired synchronously and the rest are
>>    expired in the background by the laundromat and NFS4ERR_DELAY
>>    is returned to the NFS client. This is needed to prevent the
>>    NFS client from timing out waiting got the reply.
>>
>> v7:
>>
>> . Fix race condition in posix_test_lock and posix_lock_inode after
>>    dropping spinlock.
>>
>> . Enhance nfsd4_fl_expire_lock to work with with new lm_expire_lock
>>    callback
>>
>> . Always resolve share reservation conflicts asynchrously.
>>
>> . Fix bug in nfs4_laundromat where spinlock is not used when
>>    scanning cl_ownerstr_hashtbl.
>>
>> . Fix bug in nfs4_laundromat where idr_get_next was called
>>    with incorrect 'id'.
>>
>> . Merge nfs4_destroy_courtesy_client into nfsd4_fl_expire_lock.
>>
>> v8:
>>
>> . Fix warning in nfsd4_fl_expire_lock reported by test robot.
>>
>> v9:
>>
>> . Simplify lm_expire_lock API by (1) remove the 'testonly' flag
>>    and (2) specifying return value as true/false to indicate
>>    whether conflict was succesfully resolved.
>>
>> . Rework nfsd4_fl_expire_lock to mark client with
>>    NFSD4_DESTROY_COURTESY_CLIENT then tell the laundromat to expire
>>    the client in the background.
>>
>> . Add a spinlock in nfs4_client to synchronize access to the
>>    NFSD4_COURTESY_CLIENT and NFSD4_DESTROY_COURTESY_CLIENT flag to
>>    handle race conditions when resolving lock and share reservation
>>    conflict.
>>
>> . Courtesy client that was marked as NFSD4_DESTROY_COURTESY_CLIENT
>>    are now consisdered 'dead', waiting for the laundromat to expire
>>    it. This client is no longer allowed to use its states if it
>>    reconnects before the laundromat finishes expiring the client.
>>
>>    For v4.1 client, the detection is done in the processing of the
>>    SEQUENCE op and returns NFS4ERR_BAD_SESSION to force the client
>>    to re-establish new clientid and session.
>>    For v4.0 client, the detection is done in the processing of the
>>    RENEW and state-related ops and return NFS4ERR_EXPIRE to force
>>    the client to re-establish new clientid.
>>
>> v10:
>>
>>    Resolve deadlock in v9 by avoiding getting cl_client and
>>    cl_cs_lock together. The laundromat needs to determine whether
>>    the expired client has any state and also has no blockers on
>>    its locks. Both of these conditions are allowed to change after
>>    the laundromat transits an expired client to courtesy client.
>>    When this happens, the laundromat will detect it on the next
>>    run and and expire the courtesy client.
>>
>>    Remove client persistent record before marking it as COURTESY_CLIENT
>>    and add client persistent record before clearing the COURTESY_CLIENT
>>    flag to allow the courtesy client to transist to normal client to
>>    continue to use its state.
>>
>>    Lock/delegation/share reversation conflict with courtesy client is
>>    resolved by marking the courtesy client as DESTROY_COURTESY_CLIENT,
>>    effectively disable it, then allow the current request to proceed
>>    immediately.
>>    
>>    Courtesy client marked as DESTROY_COURTESY_CLIENT is not allowed
>>    to reconnect to reuse itsstate. It is expired by the laundromat
>>    asynchronously in the background.
>>
>>    Move processing of expired clients from nfs4_laudromat to a
>>    separate function, nfs4_get_client_reaplist, that creates the
>>    reaplist and also to process courtesy clients.
>>
>>    Update Documentation/filesystems/locking.rst to include new
>>    lm_lock_conflict call.
>>
>>    Modify leases_conflict to call lm_breaker_owns_lease only if
>>    there is real conflict.  This is to allow the lock manager to
>>    resolve the delegation conflict if possible.
>>
>> v11:
>>
>>    Add comment for lm_lock_conflict callback.
>>
>>    Replace static const courtesy_client_expiry with macro.
>>
>>    Remove courtesy_clnt argument from find_in_sessionid_hashtbl.
>>    Callers use nfs4_client->cl_cs_client boolean to determined if
>>    it's the courtesy client and take appropriate actions.
>>
>>    Rename NFSD4_COURTESY_CLIENT and NFSD4_DESTROY_COURTESY_CLIENT
>>    with NFSD4_CLIENT_COURTESY and NFSD4_CLIENT_DESTROY_COURTESY.
>>
>> v12:
>>
>>    Remove unnecessary comment in nfs4_get_client_reaplist.
>>
>>    Replace nfs4_client->cl_cs_client boolean with
>>    NFSD4_CLIENT_COURTESY_CLNT flag.
>>
>>    Remove courtesy_clnt argument from find_client_in_id_table and
>>    find_clp_in_name_tree. Callers use NFSD4_CLIENT_COURTESY_CLNT to
>>    determined if it's the courtesy client and take appropriate actions.
>>
>> v13:
>>
>>    Merge with 5.17-rc3.
>>
>>    Cleanup Documentation/filesystems/locking.rst: replace i_lock
>>    with flc_lock, update API's that use flc_lock.
>>
>>    Rename lm_lock_conflict to lm_lock_expired().
>>
>>    Remove comment of lm_lock_expired API in lock_manager_operations.
>>    Same information is in patch description.
>>
>>    Update commit messages of 4/4.
>>
>>    Add some comment for NFSD4_CLIENT_COURTESY_CLNT.
>>
>>    Add nfsd4_discard_courtesy_clnt() to eliminate duplicate code of
>>    discarding courtesy client; setting NFSD4_DESTROY_COURTESY_CLIENT.
>>
>> v14:
>>
>> . merge with Chuck's public for-next branch.
>>
>> . remove courtesy_client_expiry, use client's last renew time.
>>
>> . simplify comment of nfs4_check_access_deny_bmap.
>>
>> . add comment about race condition in nfs4_get_client_reaplist.
>>
>> . add list_del when walking cslist in nfs4_get_client_reaplist.
>>
>> . remove duplicate INIT_LIST_HEAD(&reaplist) from nfs4_laundromat
>>
>> . Modify find_confirmed_client and find_confirmed_client_by_name
>>    to detect courtesy client and destroy it.
>>
>> . refactor lookup_clientid to use find_client_in_id_table
>>    directly instead of find_confirmed_client.
>>
>> . refactor nfsd4_setclientid to call find_clp_in_name_tree
>>    directly instead of find_confirmed_client_by_name.
>>
>> . remove comment of NFSD4_CLIENT_COURTESY.
>>
>> . replace NFSD4_CLIENT_DESTROY_COURTESY with NFSD4_CLIENT_EXPIRED.
>>
>> . replace NFSD4_CLIENT_COURTESY_CLNT with NFSD4_CLIENT_RECONNECTED.
>>
>> v15:
>>
>> . add helper locks_has_blockers_locked in fs.h to check for
>>    lock blockers
>>
>> . rename nfs4_conflict_clients to nfs4_resolve_deny_conflicts_locked
>>
>> . update nfs4_upgrade_open() to handle courtesy clients.
>>
>> . add helper nfs4_check_and_expire_courtesy_client and
>>    nfs4_is_courtesy_client_expired to deduplicate some code.
>>
>> . update nfs4_anylock_blocker:
>>     . replace list_for_each_entry_safe with list_for_each_entry
>>     . break nfs4_anylock_blocker into 2 smaller functions.
>>
>> . update nfs4_get_client_reaplist:
>>     . remove unnecessary commets
>>     . acquire cl_cs_lock before setting NFSD4_CLIENT_COURTESY flag
>>
>> . update client_info_show to show 'time since last renew: 00:00:38'
>>    instead of 'seconds from last renew: 38'.
>>
>> v16:
>>
>> . update client_info_show to display 'status' as
>>    'confirmed/unconfirmed/courtesy'
>>
>> . replace helper locks_has_blockers_locked in fs.h in v15 with new
>>    locks_owner_has_blockers call in fs/locks.c
>>
>> . update nfs4_lockowner_has_blockers to use locks_owner_has_blockers
>>
>> . move nfs4_check_and_expire_courtesy_client from 5/11 to 4/11
>>
>> . remove unnecessary check for NULL clp in find_in_sessionid_hashtb
>>
>> . fix typo in commit messages
>>
>> v17:
>>
>> . replace flags used for courtesy client with enum courtesy_client_state
>>
>> . add state table in nfsd/state.h
>>
>> . make nfsd4_expire_courtesy_clnt, nfsd4_discard_courtesy_clnt and
>>    nfsd4_courtesy_clnt_expired as static inline.
>>
>> . update nfsd_breaker_owns_lease to use dl->dl_stid.sc_client directly
>>
>> . fix kernel test robot warning when CONFIG_FILE_LOCKING not defined.
>>
>> v18:
>>
>> . modify 0005-NFSD-Update-nfs4_get_vfs_file-to-handle-courtesy-cli.patch to:
>>
>>      . remove nfs4_check_access_deny_bmap, fold this functionality
>>        into nfs4_resolve_deny_conflicts_locked by making use of
>>        bmap_to_share_mode.
>>
>>      . move nfs4_resolve_deny_conflicts_locked into nfs4_file_get_access
>>        and nfs4_file_check_deny.
>>
>> v19:
>>
>> . modify 0002-NFSD-Add-courtesy-client-state-macro-and-spinlock-to.patch to
>>
>>      . add NFSD4_CLIENT_ACTIVE
>>
>>      . redo Courtesy client state table
>>
>> . modify 0007-NFSD-Update-find_in_sessionid_hashtbl-to-handle-cour.patch and
>>    0008-NFSD-Update-find_client_in_id_table-to-handle-courte.patch to:
>>
>>      . set cl_cs_client_stare to NFSD4_CLIENT_ACTIVE when reactive
>>        courtesy client
>>
>> v20:
>>
>> . modify 0006-NFSD-Update-find_clp_in_name_tree-to-handle-courtesy.patch to:
>> 	. add nfsd4_discard_reconnect_clnt
>> 	. replace call to nfsd4_discard_courtesy_clnt with
>> 	  nfsd4_discard_reconnect_clnt
>>
>> . modify 0007-NFSD-Update-find_in_sessionid_hashtbl-to-handle-cour.patch to:
>> 	. replace call to nfsd4_discard_courtesy_clnt with
>> 	  nfsd4_discard_reconnect_clnt
>>            
>> . modify 0008-NFSD-Update-find_client_in_id_table-to-handle-courte.patch
>> 	. replace call to nfsd4_discard_courtesy_clnt with
>> 	  nfsd4_discard_reconnect_clnt
