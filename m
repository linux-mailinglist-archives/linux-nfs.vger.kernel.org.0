Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BA187A5259
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Sep 2023 20:50:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbjIRSuI (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 18 Sep 2023 14:50:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbjIRSuH (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 18 Sep 2023 14:50:07 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1908F7
        for <linux-nfs@vger.kernel.org>; Mon, 18 Sep 2023 11:50:01 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38II0ArO022054;
        Mon, 18 Sep 2023 18:49:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : references : to : cc : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=lukqR4XXYGh4WFdFTmD4dAoDo8XXDKnnZZqxqvXyQ6s=;
 b=Y+11K/4csdlKeqgpUCKWuGJAI1eNl3nQ7Ssbdy3pgfirLM2DsSQ0/0ts5R6KrHTWZvMe
 7ItNCBVg8umvKO3HrX+mTUvnL9SX6wqcr8/XFKuPRn8AzG8xmSn+T8Ml4bRvGMKxBsJ1
 6w2J+ZlxbmzCSskroaLhtesFt9k5ZhyB7KE6tm1+C6xMG3on6CVE6Qsm7TiOSsFwxKNO
 esugBqP1t7dWUh6raeWBYvsKQaE9wZMPSaY46TjJgiRMc/fhx1nYqRbWBrOmPo61zI0p
 TsZaV7WqwrycH9sf8Px4Go3fPge2Tmh8riSXHs/EsPy/Tyyd/EMQQtY7i8G1wM2ICVqI bg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t54dd38k6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 18 Sep 2023 18:49:56 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38II6RCe002153;
        Mon, 18 Sep 2023 18:49:55 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2168.outbound.protection.outlook.com [104.47.73.168])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3t52t4e2cs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 18 Sep 2023 18:49:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VvlXYJSik4AmqYkYMIMgj2mXdM56bcHxSl41bbdKqdqxd6v57dGr+Sa4X8z1jXDdK5FDEhaJC1nLsHq6NY6NN/Is1rhJThSURz/V47dlIaP7KEz2Hxu3Yk+340VZiHq97Bg+eZf9v3BWg4vrwWlfkRtT+K0p1o/h6Uw6E/EKD8M+Fznk+jklFqAT58TAFgzBTmvp9c+YnIgp9ZjIB07gXl0tyogH9h6kUZNWpRfBpbTB3sD7WCL3+cL95hDvB/7+E3+ZzDxq4bVOpn/OTq5ZXHBXp5PWcUDpYcZ75t3qkzaKSPolifJQC9xQ2ILMlzD0sSfWfcatP6S9iyhfsYETAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lukqR4XXYGh4WFdFTmD4dAoDo8XXDKnnZZqxqvXyQ6s=;
 b=QE3ltPT8vFNryl444Qb/qUTgKzTYQPwkE+O/aBFz7VjuiW9MkTn/tjeqnv4dEwg8UTCz8Zf9LeI/L0LvQfdQ9gSRYvn6VNuRmrVWQDIZ0TJSjN8o8pa6dSDYjo6uWTxfxjFgKUa7iiMy05QjjvdweFx8ptSe81LIzhPsClnHvpbDXLEMvnwO7n/gGZrUIY6Adu+No2/O8ZMzVrXTB2xRyvQlilYWAg/cT5c/X4+5YtdxKNZ4mrz3E0ShKbjQo6yOaOjRBn8HXYBayw2BtjxISyNEULDVUq8zU0g6HAwe3blRg5zqlDfC/XoEbwu1aXjfsHrQGRtxEpwqGoIrsFIB6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lukqR4XXYGh4WFdFTmD4dAoDo8XXDKnnZZqxqvXyQ6s=;
 b=oOK/C4eCPN/vzMrTlAYF8e+zta4Ci9LmTtTWZ8g2W8KaT4wkZ8NXcqfIv2jq94aNWj+0BHyYh/PpOdUctYmpyzQ51V+PoIfGM0/HMXJ/r2MxFMNO5tWl/kCZtjBwSrtZLDKqQWs+r+dskRIhQvmhekdpLmz9o04ASWBk6AwViIU=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by MN2PR10MB4254.namprd10.prod.outlook.com (2603:10b6:208:199::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.24; Mon, 18 Sep
 2023 18:49:52 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::fe75:575d:5963:93d7]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::fe75:575d:5963:93d7%5]) with mapi id 15.20.6792.026; Mon, 18 Sep 2023
 18:49:52 +0000
Message-ID: <036ba970-a302-097a-1155-881f4ec3f8b8@oracle.com>
Date:   Mon, 18 Sep 2023 11:49:48 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Fwd: [PATCH v3 1/1] nfs42: client needs to strip file mode's
 suid/sgid bit after ALLOCATE op
References: <1692918707-30648-1-git-send-email-dai.ngo@oracle.com>
Content-Language: en-US
To:     Anna Schumaker <anna@kernel.org>
Cc:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
From:   dai.ngo@oracle.com
In-Reply-To: <1692918707-30648-1-git-send-email-dai.ngo@oracle.com>
X-Forwarded-Message-Id: <1692918707-30648-1-git-send-email-dai.ngo@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR11CA0090.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::31) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4257:EE_|MN2PR10MB4254:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c160fad-d29d-4de3-5f07-08dbb8780aff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JSiwbJ71WAWi27M7vyfmGP9XTesLI2gbQrjk681V8ot5Yw5+ylLKeVv1xQDB1chQtvnP0UnpLY6iq2in+QGkZj+Hqsh2HCnvK/k6rYSvhpEcOsig0XJc3KdAwY91LYip/S2Ery0GqJiUv2u+/Nq37Pu0GbtYbbZgmqBDL9Gvbs67iMqvcnXIvFSMWzxg0zuMyTSbzMmdrv5y0iONyRwn2os92fy0S8MTRZVZp9D7pQr2WwX6p7jDbd6uNU/4DLM47qVpaxANbQvyliL0mV2xVRsr3Gk1BnDPEg6hyrAUMCGDskvTfzifcigTbLQ1KG4EayWspL6N4Spt7st2kFWkIHekj+iWeZSMCagI15JsQ83JR98SZdplqnoY/wU7Il1P7KACDXwzDbMbFwtZqfmaXVWmjnVtiWurnYfsRqhQS1lrswEMlyto1K1iziOdibvFKh396zR+8J7wu0JP7MW9TCVExM2lxuoCmlxJ3eDOFcFTxxRSHWMi2dOOuLuMZ1I4dkWRIejP8WDR4PeRXPn/VfAbH5r1p3r1+hTnhCsXhuWiEzrt+lBooPosxrzV/9Ik9gezCuhtNv96v8BMH6EeM+Wxgetc589ek9lmhRG7ib8z3lQ0jOc0Jy7zJnIU5Jbl
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(346002)(376002)(39860400002)(396003)(186009)(1800799009)(451199024)(26005)(8936002)(2616005)(8676002)(4326008)(83380400001)(2906002)(36756003)(31696002)(5660300002)(86362001)(6506007)(6486002)(478600001)(6666004)(31686004)(6916009)(316002)(54906003)(9686003)(6512007)(66946007)(66476007)(66556008)(38100700002)(41300700001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SCtYdFEzL3Qwei81YnliVmRXUFRrbXN2WXNZb3hkdXdYbi9WaUxYOEwvRnBT?=
 =?utf-8?B?VFdvY1pMWDl1S0pSMmxmTFk4VFN4OFJyRlZ2MDh0ZG54ZmR6ZEZJeEtHZXdU?=
 =?utf-8?B?T1F6SG9HKzNwN0ZZT1NxVm9CcUwwM1crVVVzU1JuVElXYjR3cTdBSjRGZnFo?=
 =?utf-8?B?ZE1qeFludFZZZE54ZFk5VjJGWDdiNUlYZUZpaEFZeEZkYi9mKzI3Ym1vN0tt?=
 =?utf-8?B?d3Y0d2hRRUtZT3JDWXFXenNIUG0vR1dtNEEyZHVSNlNBcnJQM20yVWp6RC9B?=
 =?utf-8?B?SENBLzlIZHNyWjFEWkdIWllLc3RyREtDbGd0QlFCTlBLNjJIcTdmdUU3R2cv?=
 =?utf-8?B?djRpRnJZSkxHKzkxZnd1SSs3VEd6YTBXMFlEdDBoRmE5Z3l2dGxJQ2NLWVJQ?=
 =?utf-8?B?UEdwVGpwQldkbUJEUnBGT3lVOEFjclZqZ1l2TkxMWkw5eXE2ekRhUWwyaHhz?=
 =?utf-8?B?OEF0bUp3NTJiV2RQZExIcXk2UGJJOUZ5UXdtZFJ0dUR2Y1BINDFJekxqaXFn?=
 =?utf-8?B?dHNZUUhodGphN1diTGUvUjhkbFV6V2ljT2EzMTFCVEl6SU9PNExOdUJBS0xi?=
 =?utf-8?B?aEpkVEsvdWdvR2RHV3pJWU1NQ0lqcGlKcXUvZDA0YnBFUHJPaGw3UWJOQTVB?=
 =?utf-8?B?YTFyUk52VlhhejRXeWFXNTRuY2hnZFczTGdLaG81dDZPMXF0a0VIRTJHQ2Y0?=
 =?utf-8?B?QjU3Q3FPazFEQi9YQTFUZG02a1NRVEJRT2JOVk5YcFovUkx3c2Z3ZEVZL3NC?=
 =?utf-8?B?WHRYbytQSm5oUEZUb1hxWVdRSlV5SWtOcDRwU2Y1YUlnZFhLWWVSWStyNW8y?=
 =?utf-8?B?RFFSelo4b2RpNUtIcjhXdkp2S2tCRFZQVjl4TDc3ZFMxOEM4R1VtNklPM3Zy?=
 =?utf-8?B?bFJQUlVoZVhkOHEwSk9jVWN0ZGNFdHgxdDNVSGg0dFUvcCtweFE5YVZJR1gv?=
 =?utf-8?B?VjZDL0xFZEtSZW1tdU1aYXRRZVJHNHd3QkZGMUpLVTVOeTRXY3AvK3ZONWxi?=
 =?utf-8?B?LzMzN0xxaWxhQ0w1S1BteEx0R0lNWlNBWG9RL3RROWNQSXp2aFZ1aVJHVXph?=
 =?utf-8?B?UFhZcnVJbE94VWc5SkR1TkRDTWxyMU9yNXkvT2RmSTdrZHZxa3pUY1NqdzFU?=
 =?utf-8?B?SW0ybVBUR3pacXdzTkR6a1RvNWMrbXU3bVk5WmNEWVFmODhBbzA2cXdnQ1dz?=
 =?utf-8?B?bUJ3OTFTRVQ4WE45VG90R2l0b0xZZHVsbzA5aHlMU2dQWWRKdUlDa2x3bTRz?=
 =?utf-8?B?Y3RFem5qb3BOdjlYU0JGaHMwMU41eFAwZE9SMFdEZTVtUmhYRHFLRnE1blZQ?=
 =?utf-8?B?Mkh4Nm40OHVJK2JDTXlUcnoxVXgrVXE4OXRJNCtUbnNNMzB2SStERUZWY21r?=
 =?utf-8?B?Y3M3OXRNZ2YzN3pLbWFiVk5PVSs4MC90MTNQYkorbEEyaHI0RDNnNzlQa1Np?=
 =?utf-8?B?RTFES3JIaDBoTXNQQWU3bjVjRGY0UWtpbVR5UkNqL21jWE1uUE95cVY0dWRG?=
 =?utf-8?B?ZUM5aVNFRXN4WEU5SXZhRmtJUVpTaGJ4T3NMNkhlb0l4cURGWGpUNm9WRG43?=
 =?utf-8?B?cWxVZDI0KzR0OHJqc1lYRlZiUGY5eUU1UnZWSzNLNVI3VFQ4UTFJWmlOb1Vj?=
 =?utf-8?B?SFQ0N3Q4d0kyM3Y1cVhENnR6a3Q1VHRXOUU5WVdpc3pLcm05UzFjVWNqeHFz?=
 =?utf-8?B?bG9xSS9LTmhLZEwyNzNQdCtkOVlGNW9pOEZtY1ZqU1Q2d00wT1JhTHU4Rksv?=
 =?utf-8?B?RzRSajI5ZmNTb0lTNjRMelViV29YSU9lWnozdGt0bHd1NGtma0gvd2Z5KzZz?=
 =?utf-8?B?Uk9FMjBTZldmNHJFbUlOQWowbGw3dDVTQlE3aWI0WGswWkxvZzl2enk4eVNX?=
 =?utf-8?B?U3JsaHlVUk9jVmRYaHIyOTd3bUZTOHh3ajBrMjA5QlU1Q1ExTDAyT2FPbHpM?=
 =?utf-8?B?R0Q1SWhPRmdxYlFJdUhyM01nbzg2aHBPN1hZWElEQWlqRXVXSmtQU3RDRG94?=
 =?utf-8?B?Z1NOMEdQYVh5aUwrbkFGa3hRWGdYYXRobUllUm1BSHRNYXdXUGhqZExHL1lZ?=
 =?utf-8?B?ZHFXRHUyRzdVOWNLY3pxTUcxWjJ4THFoTnoyczVUTHN1WkhVS1EzVzA2L2Mw?=
 =?utf-8?Q?noiZwYAhw2ZRJgErIafhKwTe6?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: g1KUH0aPwN7Is3RCMXTOZFScju982jgm76xbxUUmRAu9ziD159cw4/4ttIZFfUlOoSWIOjCKLZFHS91bHpZKB2M6Q0lEpJDdcFDbTQHa79LOMeVEHqB+QbeeznlpdanmzCtCzrkP/h+RUr60/xNRv0LWHGgB0AxGDlEOiPy0G2vKxBz7Ift6h6CX42uJ4BMCe+dxThbZFv4aEh/Rs4klQxagfP+ndMcjiGxyG1wM4pIGwjk6LO5yDMHNvILqOPguKcIBM2Q0v8mrCz/pTNcdZ7bzO6mV2XTuMHu1YCoQ4WYGWn3MqXBquU06rWeezOcCTzeerP3hkD7P3FzE2T/O4Ppven/oLfWRNu4wYnyVUCdJKVZfGknQGXQnJMc5FDNFQcQN/Ov20JIveONC5khVseHpb3EYVP9eNapwx9orJYiXNsVremwVJX5A1U1fF6gZarzraNTpN9BuKul3tViE8wBp0MbQNG3GRMS5ZAcocyWS3yOQFucThPgZAH+xcdeZYNcOC4iCi1WEpoqhTBfz+GcRTEHbRvjMVr34Ecy3aHyBf9jrJJiMC4jqxDdDm3qEoKLgxkkjTv2m0lNnTaC/5bV2xMRDf/5GVMq3jIpbPim6YiSUJb1w8IxpLSzX+MMsOxo+enUEWmPAvyMq9+zGLwCJzeEcfCd+m+eOD49mmZcnZlJ5KKzTK/rk+eItOVotRUK47fnvFAP+TQFalyS1qxRhJ+BnQ6RAiMznScofHu725WWO4YdkjBRPk/MC56H4vUoccf92+AqrVf1TLAUNWWSzz4UXC3MNEJjdoZHORBxhFIaLWTqqfdUEQN6RVAVeQuF9GIJzncrPOys/SaEUig==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c160fad-d29d-4de3-5f07-08dbb8780aff
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2023 18:49:52.6823
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mKBhCkxh1g7ZLW+8Kk8yo2aPYDLFmnVQ1pRZ/X/Ja5FFTkavRWTGjgjNO3tmROWytj7/VZPRCk9vgl9NtxJTbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4254
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-18_08,2023-09-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 bulkscore=0
 suspectscore=0 phishscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309180165
X-Proofpoint-GUID: rgFpMMa6mGMtg2rUTNPZgPQg01avKp81
X-Proofpoint-ORIG-GUID: rgFpMMa6mGMtg2rUTNPZgPQg01avKp81
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Anna,

Was this patch rejected? The fix was suggested by Trond.
I should have the 'Suggested-by: Trond Myklebust<trondmy@hammerspace.com>' tag.

Thanks,
-Dai



-------- Forwarded Message --------
Subject: 	[PATCH v3 1/1] nfs42: client needs to strip file mode's 
suid/sgid bit after ALLOCATE op
Date: 	Thu, 24 Aug 2023 16:11:47 -0700
From: 	Dai Ngo <dai.ngo@oracle.com>
To: 	trondmy@hammerspace.com, anna@kernel.org
CC: 	linux-nfs@vger.kernel.org



The Linux NFS server strips the SUID and SGID from the file mode
on ALLOCATE op.

Modify _nfs42_proc_fallocate to add NFS_INO_REVAL_FORCED to
nfs_set_cache_invalid's argument to force update of the
file mode suid/sgid bit.

Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
---
fs/nfs/nfs42proc.c | 3 ++-
1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/nfs42proc.c b/fs/nfs/nfs42proc.c
index 63802d195556..9d2f07feeb29 100644
--- a/fs/nfs/nfs42proc.c
+++ b/fs/nfs/nfs42proc.c
@@ -81,7 +81,8 @@ static int _nfs42_proc_fallocate(struct rpc_message 
*msg, struct file *filep,
if (status == 0) {
if (nfs_should_remove_suid(inode)) {
spin_lock(&inode->i_lock);
- nfs_set_cache_invalid(inode, NFS_INO_INVALID_MODE);
+ nfs_set_cache_invalid(inode,
+ NFS_INO_REVAL_FORCED | NFS_INO_INVALID_MODE);
spin_unlock(&inode->i_lock);
}
status = nfs_post_op_update_inode_force_wcc(inode,

-- 
2.9.5

