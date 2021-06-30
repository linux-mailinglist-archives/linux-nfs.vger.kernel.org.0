Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB4A33B880D
	for <lists+linux-nfs@lfdr.de>; Wed, 30 Jun 2021 19:51:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232420AbhF3RyD (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 30 Jun 2021 13:54:03 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:38766 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232409AbhF3RyC (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 30 Jun 2021 13:54:02 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15UHQReK010467;
        Wed, 30 Jun 2021 17:51:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 cc : references : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=O38KWrLFGmZ4S12k3F7Xc+qkkzXNMTCkGthcuOSLklw=;
 b=LoJ75wLg6lX0Rto1LkZ1GRhnoY4lzBtvnMZvK/zFZSNJ+fR4HZdeVPNzbvkeY3V6ruAG
 lhE1nueYp0Crw9Gr81C1zPUexwpw8GwZezYoS23Q0oserUP/uMovCgZbqMXVpfziYURq
 +qVSooJgdcmkQBA/bUpVW7ApihM03aNm5JDb7EtqzMe3hodXHYTcd69+TKzXpAA96cRS
 eqQTQBBmtweJQQwyFCKoaC35D8HdlkH9GcgvsfCG73euJhKjU7gP8vxhIoM1O4bCK/Fg
 UlhIQ/mSWSBQHu4doH8M5LtKC4VIi2/zOjyF9AQSfNVmMzSXiew3eU5ufdMM8notcStE dg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 39gb2t22t5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Jun 2021 17:51:32 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 15UHQ7uO167043;
        Wed, 30 Jun 2021 17:51:31 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2177.outbound.protection.outlook.com [104.47.55.177])
        by aserp3030.oracle.com with ESMTP id 39dt9hkefq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Jun 2021 17:51:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YYQ4ZEcNN1kNFmzMMfcaUPsRSL7WlpKCER5VzJB+lkcFtEgtkJ2dNqtCYB6i22f4prn7aeD7qItwp1kT5XfyPlGpi5va8S8xEuLIUsqK6baICao7iMrDhSqMH+2CLS35qDXFze5gGQufUSwbBDtUSll2X1ukOovI5QwjHsKGCtE33OtMOuM6XDSRWMbVM2swjAxCWs9mPwpiGd81S0E+7b2n5PdM+p+irK9jZyVIZ0XfAMVdPPweBLYw500aP1N5ez0uNVX62cR5RVDAQ9xErgqbxXKzQXmcBWjnLOwKX+QVMoo2WKB1RU3RsvtIs9t2Yyp+UWgm96LQFOUhJ8U6Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O38KWrLFGmZ4S12k3F7Xc+qkkzXNMTCkGthcuOSLklw=;
 b=VY/yz9kvVvxCprKjZOilhe5pVKBODQHi9ezHgVeRZ4R4HCVsO9pa4z5M27AAnabOTP9mQigsmeQi/Q6XQbm/KVvRy5c+gb7gv6abP3ioawWt/GtZUfF2c/nydcEIBTzVaU4b46U4mT76L5lU8vop6C+2ogSobZBU8coAuzHRYd3VDlhQZhWr5JjASJFRRc3DahRxBEoSX/CqqH7VApRCasDzT+CoU+yogTzJMvEtOUJC6Nc3jjRT1t6EeXFQOxyWGIpWze8UQWS3o2DPFm3cplbAllwmorlM2A8lOUZsy0pK+mHA7nqFtFutgA7GaTWYqlr5aDApvjHBbka03SF9dA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O38KWrLFGmZ4S12k3F7Xc+qkkzXNMTCkGthcuOSLklw=;
 b=Sn5tIRyMf9y1o5AC/eiqLL3ExS8XP+LsP8cvE5iW5EHC44WqUGxZ7wwpaZGKNhtLDyuhJs8hX7gEKno9qqP4KU6N2AS3GwWagnGiJ5efCWkfvuSM25C+rKX4DkS43VjZjnEAaeej8NRMWchs6crtoatEG2GgYGpgsXeyWadxmK0=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by BYAPR10MB2920.namprd10.prod.outlook.com (2603:10b6:a03:8f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.21; Wed, 30 Jun
 2021 17:51:29 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::ec57:cc81:ad54:10be]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::ec57:cc81:ad54:10be%5]) with mapi id 15.20.4264.027; Wed, 30 Jun 2021
 17:51:29 +0000
Subject: Re: [PATCH RFC 1/1] nfsd: Initial implementation of NFSv4 Courteous
 Server
From:   dai.ngo@oracle.com
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     chuck.lever@oracle.com, linux-nfs@vger.kernel.org
References: <20210603181438.109851-1-dai.ngo@oracle.com>
 <20210628202331.GC6776@fieldses.org>
 <dc71d572-d108-bcfc-e264-d96ef0de1b36@oracle.com>
Message-ID: <9628be9d-2bfd-d036-2308-847cb4f1a14d@oracle.com>
Date:   Wed, 30 Jun 2021 10:51:27 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
In-Reply-To: <dc71d572-d108-bcfc-e264-d96ef0de1b36@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [72.219.112.78]
X-ClientProxiedBy: SA0PR11CA0066.namprd11.prod.outlook.com
 (2603:10b6:806:d2::11) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from dhcp-10-159-232-63.vpn.oracle.com (72.219.112.78) by SA0PR11CA0066.namprd11.prod.outlook.com (2603:10b6:806:d2::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.22 via Frontend Transport; Wed, 30 Jun 2021 17:51:28 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 34691ae9-ed6e-45fb-3e3f-08d93befb03a
X-MS-TrafficTypeDiagnostic: BYAPR10MB2920:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR10MB292017F0A3D679A3133BB5A987019@BYAPR10MB2920.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IYzjJn1KNPSf9l28kH4FLlszQA2lD+JXQbrWWEnSB0r9sQ7DzjPwU4kueVq7FWTFzSHpZ0OpsZO+B4bui9ZphsZxLFyPkR6vdx7BrbbUXyN/ZBxOAGyOyLAC2ZJISc4TTnNXHy89wb5bwrVZIxYxZs1qRF2OIoW/DPTFhe24KNs40x/W/tyrVNPvelRXdbQ+aztJF/YPJFc9B4H4LRnNIewM85/R7uMPCN8u5Wd295wmyUvhlfwqS7RV7iheif/IW15jNEvJ6SV9jKqduL9YYCGzU6PilGo7MjzH2iHl2jG4upNrgM9ALd/lFNGl6yRttazRLHw1QefuUb84xxCCkxAIgIO6orW2raEsJcPGKK7nh3NL78aE27mV3fLij4gKurzA0amH2m6XhjH/fVRJQdelhGHJMT34MrucSIdoeZxvSX7gvZ96o9FHV9sOhPYPQEE0TRopwp4LJF7VeHlvfliNkZB+KcTT7kPDYeddPfFBshhVqW5eW99gtuFnwOtg6PCQvczb0xMkq5w62umaQpTbNGUxwERFyvkRpZT70/YZ9uYRwaryCglWMARw0buTC7VvT90kQhLext8LF+TjxKXjYR1KhWdapYTsW0SR8apMwCyYFfDF3JFgcMRjGt/j9MCJa/6jgCdTQwHmE07jvrZvkTFhYbXxzWUgb8vBNoeyjfCkhpVwOYwYHalTRCQRROLPMb0+9V4ON0EqWT/BlA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(136003)(376002)(366004)(396003)(39860400002)(31696002)(956004)(4744005)(2616005)(316002)(7696005)(9686003)(5660300002)(53546011)(31686004)(66556008)(6916009)(66476007)(4326008)(6486002)(2906002)(66946007)(36756003)(26005)(8676002)(86362001)(478600001)(16526019)(38100700002)(83380400001)(8936002)(186003)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Ukp4b2Jab3loTWV4S2pnaFVMOG5XbWIxY3JXNHBKY3RPRTN6RXYvd09MWUc1?=
 =?utf-8?B?NFVaU1ZVWkd5ZVNOVmxnaU0wcVNkaTk2SmpVanNoTHpCUUxxeUp6Yzg3RE8w?=
 =?utf-8?B?L2xVeDdlcmRrWjRCbjN0UUwvLzg5N2VtaDFKN0hQenZZZU95RTlmbEpEQyt2?=
 =?utf-8?B?ZTlHSjJpKzhUdUQvUVdMSXRPS1FjUlpxeHRWUXY2bW9mUEFJUDU2eGhQRS8w?=
 =?utf-8?B?a1AwMXJEczhLUTUzenRMcXI4aDFqYlpPUkorYTVxclRIYkljZjNVaFA0Qzla?=
 =?utf-8?B?Yy9uWXJNMVRSenRxbXlRa1ZOUE1QWUYyUVlCQjNmREVPOHkxNXdCVFd5a1hW?=
 =?utf-8?B?SGJtQ1IwcnRLMTF3RUZ5ZmpUeDF2bDloTmIrdGJMK3I1WlU3RWFPdzBPQlVo?=
 =?utf-8?B?ZWtxdDhxTVhWS0RGdmhLdTg5QnJpb2pPSTlHdzlNY3owbnVxNUE1SzhlVkRK?=
 =?utf-8?B?U25yNGQ1OVBhNlg5bUhvUENkSmNxV3ltR05SZTlLemZHQ0l0YUZIaVc4Tzdx?=
 =?utf-8?B?ZlM3bnRrRU9tcFpXelJ6N1R0Mkh5OVZ0VWFsbGRzc1VhdXl2UDQra2xqaGFa?=
 =?utf-8?B?dnNteXl1VHpuTU5LZ3VyNmFQakJIWkJqTm5xcFlhRWEyZUJiZU1IWUI4SFcz?=
 =?utf-8?B?WUFaWEw5cS9JRERhYUVtQUFIL2NycEJ0c1VzSUNGYXhhTTg3dlpENzZ3RUFy?=
 =?utf-8?B?NytlTm5NWDRSRG9jU25IdUhLWWxDVGMwZ2d4UzZSaG5FdlFLY1ZtNmRLVmVy?=
 =?utf-8?B?V1JBTEQ0WElad0MyUDZ2b3k4QjhKVzNTTEpnQUFnZExVYU9XTVFkWll4RFcw?=
 =?utf-8?B?T3R1WXlKTzQzb01iRU5vMGlYSHFuUFJvWXVaVHBicVpLUi9Mejh2SGVUcWxX?=
 =?utf-8?B?aWEvNjF1S2wxZStLMGcweCtXMThiRm1rUWtjN2lHalhxK2ppS2lZNWY4azJ0?=
 =?utf-8?B?WmJ0aXNBaFVOckRkKytHWkx3Z0xrN3FmMURob2dBTFh6SDg1enVreHJhcnFX?=
 =?utf-8?B?T0k0S0FPZUZDYkRURDVWN0dCUmVNdERQdkxSZi91TGVBb2NRTlRJcHJuU2tU?=
 =?utf-8?B?SXNnRUxYQkliL1hoR2h5ajJacWVzWitLNUpnbUN0cktYREpPN1RlWFNPR1Yy?=
 =?utf-8?B?bTIvS2Riay8zT2F5dU9raVZxQy9jcGVHTnRTdWFxMW5IVEdMMnN0UVozUU1j?=
 =?utf-8?B?SU43K3lhQjRnVWxlUC93d0N6ZEQvQTZtQkxjNlBJYlU5V0QzYmVPcWxWT3k1?=
 =?utf-8?B?YWpCSXNFTjVpU3lpYng3ZVVqMExjNDhzZCtXZUYrU2V1RUEvVnFFQjlpN1VL?=
 =?utf-8?B?YWlyZW5KbmdrOEZUTGpSdktMTTBGa3JzVVY5eTh2bVVpVkRxZ2cyOHlnajVJ?=
 =?utf-8?B?V3cwbCtuKzl3eUh3K05jVnJKSlo1c3NjK3JzWDNOVWlPUCtwRDNHZ2EyaVoz?=
 =?utf-8?B?UlBZQnViSU9qT2Q0UnBaSXJkTG13NmcrRlJSK3BQbW9uUWRzY3B6ZURmRUZP?=
 =?utf-8?B?TDJiNnlISkR0ZVFMWXFQV0lnLytIZk80UExadDU3RDdHUGRNSERUWkJobFJZ?=
 =?utf-8?B?TW1PbE9yRGRjeW5LdDNXbkgrY3Z0eGJRQ2RUREhHTytGOWUrdEdaeGdUNE1N?=
 =?utf-8?B?aXhwQTAvOEp5aHZ2RWY0QXNDZlRrUjVQTGFQank5S0E5YkNwcUQwRmFWWlVp?=
 =?utf-8?B?NFVvbzJ6TEt1ZDJzS283RWFBY0RBT0g2cllJUytaTmY4RHdUOTRBRlFGdDdO?=
 =?utf-8?Q?fRiRjpCUvrla88kpd7YtHGbgUBx+uvdpJ8qbZF1?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34691ae9-ed6e-45fb-3e3f-08d93befb03a
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2021 17:51:29.3218
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IjuikB1AsFbUQWGkI5TDnJBXfbq1jTASA6BMSxogS5yA4OV84eOxgNcfYd5D8/vCcncN05lCKL+UHw5sF8JayQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2920
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10031 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0
 mlxlogscore=999 phishscore=0 spamscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106300097
X-Proofpoint-GUID: HkMOmOW_DgtpcHYkoCuHvItQjTXQYFho
X-Proofpoint-ORIG-GUID: HkMOmOW_DgtpcHYkoCuHvItQjTXQYFho
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

> On 6/28/21 1:23 PM, J. Bruce Fields wrote:
>>
>> where ->fl_expire_lock is a new lock callback with second argument 
>> "check"
>> where:
>>
>>     check = 1 means: just check whether this lock could be freed

Why do we need this, is there a use case for it? can we just always try
to expire the lock and return success/fail?

-Dai

>>     check = 0 means: go ahead and free this lock if you can
