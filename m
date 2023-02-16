Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20924698DB8
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Feb 2023 08:24:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229454AbjBPHYV (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 16 Feb 2023 02:24:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjBPHYT (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 16 Feb 2023 02:24:19 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 559821165E
        for <linux-nfs@vger.kernel.org>; Wed, 15 Feb 2023 23:24:18 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31G2Io4H031817;
        Thu, 16 Feb 2023 07:24:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : from : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=ta/DshMPs825edSdZdnkPPUz+ibj8wi78z+ZX7yEmeg=;
 b=FZKrknCrMRdNq9yzSYxdSKX2eflXq7R7mu7sibWsIXHRo54w+fxioEBO5GuqFqfidV1N
 CWf0FpeUkNbhg9FQjnZf/nNPar+oLvD27cGHDz1RCxxsOtEGepPWSD0UEKzc9p1Gq3sh
 +L8bSSPOqmVsZL+ANaaadewNoLZfcV9okfeONc7EkDmnoTSlIwAQ61S2fJBwjhh+6t+K
 pD4H5jY5cMkejHp6mmKp0OTkp3ptrM4+b7ZTWZu2zWyGdywOrqXylZx7qgl94fxS4Hqa
 PZEYz+6Pj+R9sD1JS9ZRHmFwoq4BqPqN7414Kci1QXFLov/T0Cci7CobhmTGbdHz8ubO Kw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3np2mtjd47-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Feb 2023 07:24:13 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31G5KKhP024624;
        Thu, 16 Feb 2023 07:24:13 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2045.outbound.protection.outlook.com [104.47.56.45])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3np1f8ruws-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Feb 2023 07:24:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gfMJNLxh2/WWGI7fiiIm9uilT4Fs3NzhHQegJXK8cdPsf8oVfNgQBZaXGGgFnFitoL1EgydLt6CIFW2zlKr701S7+LOhxVrah2qDz/E2RNVZNS911ZVPVrSZelgShlkjYVfFexwGttrzpzVGs3X9up6kM+jDO8s5e0i0zeYeBhS0eoFtmnKQ4KkqN39hwdKKSnKlL0wiBgzAa+2PH9sib1p5iO7wNR/9CGLQtzXvevmXOKt05DYwu/+2Z2gWvRRyFgIII9esrWL6IfWjSgPJJ84izpiwh014qMCeJQ+c0B/bQHCBCI1EWALxZGMjv6ogBbg1JFxsPP+OfBD6QdVklQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ta/DshMPs825edSdZdnkPPUz+ibj8wi78z+ZX7yEmeg=;
 b=GK9aLqzd3iAk3CNBJgfmmtGzBpKjUm+VT3PFmH1euSkXbotYoVlXlmJtJThE4/K1w1zkCUZ3wvxAFdZ5brXqZztrdyBHbg5tqxw3wpnzgmqKub4C/letU9ipEevoWXPMqrPzOKBvidJMvOzYONxOu0zoQOjEfnNi96Cu/wPejnTVK1YoRVPwUC03C8bbLtRtDbY6PhJWEwrkGPaeRMLgTjPdr+W/hP5duzpsKNtVUOThxV/YEaxkY/+EbCEv8qdaL+VOz4+4QU/fwSyfBo+y4yIVjoft81N9/czknYxyw6AHgMgP8xGHnNp1iD0sQibY3iOiAs69YERj9Uq5f+pOtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ta/DshMPs825edSdZdnkPPUz+ibj8wi78z+ZX7yEmeg=;
 b=iJyi3NIdEZZE27R/4r5QybW9mhjUhHdlU2dbPGcpD6m/CR4cS1tY0YW3DSg09Wja46uubbN8tyrlaTOyND3XZaj/CWWyDgKnvnB6rfBX+qDMpvTbql0HbHaOf7MJWsepRv6G+WcsLJWvbhADtaPCYbyufZb93rv0PAv4GZMGW0w=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by PH7PR10MB6250.namprd10.prod.outlook.com (2603:10b6:510:212::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.6; Thu, 16 Feb
 2023 07:24:11 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::2280:b9da:9056:c68b]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::2280:b9da:9056:c68b%4]) with mapi id 15.20.6111.012; Thu, 16 Feb 2023
 07:24:10 +0000
Message-ID: <27c323cc-dff4-61b0-fc37-cfc121b66505@oracle.com>
Date:   Wed, 15 Feb 2023 23:24:08 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.7.2
Subject: Re: [PATCH] nfsd: fix courtesy client with deny mode handling in
 nfs4_upgrade_open
Content-Language: en-US
From:   dai.ngo@oracle.com
To:     Jeff Layton <jlayton@kernel.org>, chuck.lever@oracle.com
Cc:     linux-nfs@vger.kernel.org,
        =?UTF-8?B?5by15pm66Ku6?= <cc85nod@gmail.com>
References: <20230203181834.58634-1-jlayton@kernel.org>
 <dab0d056-d2c8-a594-2a8f-c8dc2cefaa14@oracle.com>
In-Reply-To: <dab0d056-d2c8-a594-2a8f-c8dc2cefaa14@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DM6PR11CA0024.namprd11.prod.outlook.com
 (2603:10b6:5:190::37) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4257:EE_|PH7PR10MB6250:EE_
X-MS-Office365-Filtering-Correlation-Id: f1a7b39d-f47b-4872-a555-08db0feecc3a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NCboCrh8Ce0bbh+BWSJIxivuIKxo4SYX8df9y/UK9ABDb75DhNsvA1oQY+UeuYCVjGldS36HuGPzOBfOy/ONEsxjZDhU7rcHepqD6APKJXj8iX3QD2mZX0MPZXdIlUFGGDjoNGrFeNRHLTg+6p9jwt0oGAF0oQ4JEcrRn776xqQwx30HPJSWGTUcgCrZyk5JdxbbMPQdMe/4hgy8mT1iwi4Z4l91bpQ48xEjwWC1usFcaITEeJ3v0Z55fq+mAd3LVH8hHQVkFgwHMrpmvpdjgwLCEZbM4A45e2RvR1VtG44ADGu06owELNwKGieN1wuRhuBPuymutSTMpFqbcYleNNToOED3aWikg1Mkwm9bId9sP2z7PzqBwbku6pz5iS3sT2kk6jYw1l3GEd5LygxIU6wrFuTutjXsHZYvo2ELVBjjdI7c47rTgJsnggUbOZHYP2AfYQGrLI8wDCoWqVEFZ/ZJnGu8YKEZwVFu+U8Sr5kFcm2K8fbCbV4uuL4jq4iRLQ7CzFWLk4PG6pwpq6maVGP8Mth701okyqnd8ZHruE85oLMLOdhxfUfMDefHf5t7Q7EAaO0iI8dU4VJGHLXc66oSTiYcqSaXq0fwk0nqOek/KoNMSMlL8r5xxJp9AJkwz/oK3g9T/c/BOZAFPplT7G7TnvNK10pHicA8Gw/CMkvkkwnQNZMdE4L2eryHfHDbl5+nkPwye4L7DfIDv+QdlQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(366004)(376002)(136003)(346002)(39860400002)(451199018)(66946007)(66556008)(4326008)(66476007)(8676002)(316002)(6486002)(478600001)(2906002)(36756003)(41300700001)(5660300002)(8936002)(38100700002)(83380400001)(86362001)(31696002)(31686004)(6512007)(53546011)(186003)(26005)(6506007)(9686003)(2616005)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M0hoc0VtZEo1S0dULzcrdS9NYndOVG1jS21OOEJJTlhhUU50YzdCdUY5cklQ?=
 =?utf-8?B?bXNsdjVsdWxXc2JsdU1vVEFob01CWUR0UWFaZ05lLythNXkzNjg1WTJVcjhS?=
 =?utf-8?B?OXJTeThhMWg0L1duWVI1T0RFTEFubEVWbVBOZWhBdGx4emxLZm9BSkFkTGFS?=
 =?utf-8?B?c2dwR0NiUTJnUnFyUVZPWGZBdVhrWWt1S3ZwWVRPdVdRM0plbUprT2tyY1lN?=
 =?utf-8?B?UkxheEtyRWNkcG5vWW5qaFMrVG01WHNTVEFVS3RHQlM3OWhld3ZRZ1d6OXBt?=
 =?utf-8?B?eU9CdGZSMFNjclJiV1NZZlVQYVpIL28xd3kwS0xIeHprc2FHT2NoUVNQVzBT?=
 =?utf-8?B?c2N3andBSUxHSlpTNlFQM2JrbkdsQ2Y0bUd6MVU0em45K29jTmpDU0psVzZj?=
 =?utf-8?B?OEFjZFUwTkNZcVU1UXdwNUhGdzN6SHA4UXpFcUh5Z2VkSWYrMXlBRWo3WUxp?=
 =?utf-8?B?SlhLYWRGQ3htQ1NkTWRJWDZIUzQwRDZ4REF1MWhUam83Mnd0a1k0cC8rbGZR?=
 =?utf-8?B?VVZJRjMxaUczZk9acmdWVTFod2Y0NWxjNXJLUVdScGtiSEE4eHhLRjBWU2dX?=
 =?utf-8?B?cUlmeVp5eXFQNWJQVmd1SEllcWN6bjlOc0l0Yi9sTUphU0k2YmZjOGFJSlpZ?=
 =?utf-8?B?YSt1ZE1sdzEwbUo4ZDYydjU4N2p4cjhTTTJ0bnJMS2NqNVlWUjRjbmE0bU1t?=
 =?utf-8?B?dkRQS3psYjY4WVZUMGl3bGl4S3dySDFpRFlXc2F0ZlZadVlUNTlBcndGb3du?=
 =?utf-8?B?SzZCd0EzdnRBMGRCRFdGZ1NWZnQ2YWlHTE9XSGp3ZVhDd2tIMkZVL3ZHQnpP?=
 =?utf-8?B?VGFPODc0MzU1cEtOaXN2eTdvalJvcTMrSkFqU3hDVjZ2OHlCNnl5T3ZlRTFX?=
 =?utf-8?B?ZE1UTmRINndsQjRjcDVGZzg4RGVPMWt1RW5tWHE1eU5FSXV2RFpqdkZid2lh?=
 =?utf-8?B?MkF4eVdQUDZaMCt5TnpacllnRWk5dS9tUXQrdlJiYkNuT2R1UUUxVDByZS83?=
 =?utf-8?B?VTB1Z3ZXVTdWVEFtUVNMb0JqRTFZZ1V3TzRJMzBqMTIvRDA2aFdIbjc1WUFh?=
 =?utf-8?B?NmlyL3lTOXB6bGU1RlZtTDlPaXJpL003VFpPWXpaN2lZSWtTK3ZhazhPRDJv?=
 =?utf-8?B?WkF6MUJtcFhqUjNGMVZQUkdjSzVUNzQvUzdrYmxZVjNwMGZ2SjJzdElXUnVO?=
 =?utf-8?B?dGVnam1vNUE1RHk0UFh6akZ0MHltOHFHOUt6Z29uTDBQRjFVczZkVWtMSkJo?=
 =?utf-8?B?c3RHTkF1a3ZvcTNGeS9ndlVOUlYvNFNnWmtjaWJtR0x3N0dCZ1Vobm1MWnBu?=
 =?utf-8?B?bU03cWUvU1JJK2NzQ0RueWxIa1JPWFhweDlqbFNRQ2hjOTFDUDEvVmxSbVdR?=
 =?utf-8?B?TXBVZTd0ajk2dEVsQzUzTDRuMXM1c2tvTFE2NjFoQ25LamxYdEV3QVRzOURT?=
 =?utf-8?B?cnZYUWZCMCtYS0RHV2FtWTczY0w3TXhLVnowcUZPZzd4NzN2cGU3L2dXQUlE?=
 =?utf-8?B?R2dlSmRQZkZoazVJOE54eU84cmNFMmNhRVpac1E1dzhTdXBEc1pQWEI5MURa?=
 =?utf-8?B?d0xjT0QzQ21uNlBJclcxYUpNZ3hKcitrYXJGdEpZZjZIWDJnUGtiM0c1SHJT?=
 =?utf-8?B?YW1Ta3M0SGxkMHZiNHJhQ0hQMTUwUVhJSlhmV2VmMzg3UnA4cUZ3Y2lxZzRN?=
 =?utf-8?B?bzFTUjZEN0MyZVh6NHNtRktoNVpiVUdPeFJER0wvNkxOV0VOVWNvNFlRNWFO?=
 =?utf-8?B?ZHdkalFDcnhVWHZGZ3NaRUYwVU5zQy9COGFHNGtKU3UyQ2JMcmFkNHJCZStu?=
 =?utf-8?B?d09FM1lBbDZ0d0RwdGo3WU5oS0dqOXYzamMyWVduRTMwMjZKc05USjVtTW10?=
 =?utf-8?B?ZkdiaHVMWmp4OHBTVE9DSnVGWWl2QW9Fc1NmSmxMRUxnOG0zcXI4Y3hSTDJM?=
 =?utf-8?B?R01HemVsWjJ2dHZrS1VjMThQbHlhMHV3WlVoLzIvVjMyMGhtT1FSbXR0VGhH?=
 =?utf-8?B?V0xNTDl4cWNVUlFZVFNRa2dMM1c3blUvcTFMREFianN5MzRKeWs4eCtYTUNK?=
 =?utf-8?B?SEt6Q1ZrMDhmWXY5SUp2SFhhdkFEZDlyNjFyTWdtMi9IUFJJdGFPSTR5OFV5?=
 =?utf-8?Q?XKxWGnONfJVurhnxqBC9Jb5C2?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: LjgMqsgBJ/LDZJfAck/CZVUZ0Dml2D8Uutt5A2fwf8DSXxqRb+WlsuTE+HKNFhWK22CDgrbM6w5Xbg2YngnSye55sOnSpmSGJWSaRWpXOeiZ/EZ43Q3f6RsV6puxOzyYrLnJT/RUmfn3KPJvdHn7qnaPbyLqxEzKhsN3oL47dGc/054mR4OicUHLf/oC6W81nneOsv9/OjrLjMpO6VIHn3+H3AKo4oG6fTRSo2l3i2RUY5N2mvdpfMN9iw3byX0avkmfMn8MgTLLr3j4WBxwwLj3SSXQhryzhXwUXJ5o1p1//mlSfBxLh0hsKw5BidqXZoygtAZA3RQUGeK28b0kMRJZXUO/+hQ970bNY8OyEzw3mwKRpEVyjF9qOMnzat5xYnyC7LFR+/61WbWKuCfGaTMuNDePU5ZrFO6n0Z1vM/RWI7K+Jql08pAAH5SNK+bSez7NdYZ4qoeLAPdwvlkyetda4deonsYMh8/ODIEizmiPycEVuwe2eggkMJlj2LRt9cnnIMfO7hgZZNff40GUMTtjONUMT1LdtypK2oBbG/AlHTIk0j8SmdCJ+RBrW0GkJ/Ha2AXLUl7JI0zdrCfgkkkBv3BYE/L/5243fRZrET8yPlZU+gtyKHK/fZzPS6tQ6XMqRyGc0tW6q39m2xd9LG42agU2yC/LpvVdtKkRh1UznxZs5LgBZiwqKwSZ/A6h1wTTxXJSZFQ3xavXW0uqDVKLjdeKicaS7fXCzJx+G99rBgvYzGUyMgulFHwym8joLup+8gHYq31pWl4yOaUvf809/qgyaR6DWKIdVhr37jJtb3+JmrLZKxA6uq72I1m3
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1a7b39d-f47b-4872-a555-08db0feecc3a
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2023 07:24:10.7804
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4e+PhTSFxkcezuKyKWo0nL0TWkFyf5o0iCi86n055DM1WFL6OC2QQmILB3kQLsLnR0Ywr3Rul9qu9D9BFLUrAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6250
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-16_05,2023-02-15_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 adultscore=0
 malwarescore=0 phishscore=0 bulkscore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302160061
X-Proofpoint-GUID: yO62I0pfBVUg2ep65JZ8c2TunqbQVamX
X-Proofpoint-ORIG-GUID: yO62I0pfBVUg2ep65JZ8c2TunqbQVamX
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 2/15/23 3:05 PM, dai.ngo@oracle.com wrote:
> Hi Jeff, Chuck,
>
> On 2/3/23 10:18 AM, Jeff Layton wrote:
>> The nested if statements here make no sense, as you can never reach
>> "else" branch in the nested statement. Fix the error handling for
>> when there is a courtesy client that holds a conflicting deny mode.
>>
>> Fixes: 3d69427151806 (NFSD: add support for share reservation 
>> conflict to courteous server)
>> Reported-by: 張智諺 <cc85nod@gmail.com>
>> Cc: Dai Ngo <dai.ngo@oracle.com>
>> Signed-off-by: Jeff Layton <jlayton@kernel.org>
>> ---
>>   fs/nfsd/nfs4state.c | 21 +++++++++++----------
>>   1 file changed, 11 insertions(+), 10 deletions(-)
>>
>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>> index c39e43742dd6..af22dfdc6fcc 100644
>> --- a/fs/nfsd/nfs4state.c
>> +++ b/fs/nfsd/nfs4state.c
>> @@ -5282,16 +5282,17 @@ nfs4_upgrade_open(struct svc_rqst *rqstp, 
>> struct nfs4_file *fp,
>>       /* test and set deny mode */
>>       spin_lock(&fp->fi_lock);
>>       status = nfs4_file_check_deny(fp, open->op_share_deny);
>> -    if (status == nfs_ok) {
>> -        if (status != nfserr_share_denied) {
>> -            set_deny(open->op_share_deny, stp);
>> -            fp->fi_share_deny |=
>> -                (open->op_share_deny & NFS4_SHARE_DENY_BOTH);
>> -        } else {
>> -            if (nfs4_resolve_deny_conflicts_locked(fp, false,
>> -                    stp, open->op_share_deny, false))
>> -                status = nfserr_jukebox;
>> -        }
>> +    switch (status) {
>> +    case nfs_ok:
>> +        set_deny(open->op_share_deny, stp);
>> +        fp->fi_share_deny |=
>> +            (open->op_share_deny & NFS4_SHARE_DENY_BOTH);
>> +        break;
>> +    case nfserr_share_denied:
>> +        if (nfs4_resolve_deny_conflicts_locked(fp, false,
>> +                stp, open->op_share_deny, false))
>
> While trying to write a pynfs test case to exercise this code path,
> I realize that we don't need to call nfs4_resolve_deny_conflicts_locked
> here since this is an open upgrade so it must comes from the same client
> hence there is no conflict to resolve. Same behavior as OPEN_DOWNGRADE.

never mind, I found the scenario where this code path is executed:

Client1 opens fileX with WRITE, DENY_NONE
Client2 opens fileX with READ, DENY_NONE
Client2 opens fileX with READ, DENY_WRITE

-Dai

>
> -Dai
>
>> +            status = nfserr_jukebox;
>> +        break;
>>       }
>>       spin_unlock(&fp->fi_lock);
