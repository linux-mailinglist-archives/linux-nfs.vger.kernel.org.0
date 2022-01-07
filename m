Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4438E487CE1
	for <lists+linux-nfs@lfdr.de>; Fri,  7 Jan 2022 20:15:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230159AbiAGTPu (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 7 Jan 2022 14:15:50 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:6514 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230056AbiAGTPt (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 7 Jan 2022 14:15:49 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 207Haw4c027170;
        Fri, 7 Jan 2022 19:15:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=Xo4tuD8UN9/Q4GczxPIGJXgNdk0wnLPYnLttQRCQYp0=;
 b=YMc+yaGANaCvbevadb178dYKFjfAkqT6Dj6tLGcTIkkBlyEclLuJ4u60v7h5bLu68lfO
 w3wGaIVPtS9hcahry6eod01NS/bMB8mv9eIrMO05GR6l+Ik6PLqkgNiHWZngYHknQvBe
 CNAR6PZDZQFVPswRzpcHfgxvznqX+GZDRO4jdVTiuBMB4yRdD/wt9A1TJUYD3RP9KyqX
 FjJKCwB4WQl9lxEjTrWSKIXSG5M5fc7El+fNt5HGu8FNRC0iRP8oUBbFPp1fgzyI1Hf6
 LzQ7lJNFbQIwS9/aH5NN9n39jXCvfHKaUTf6RUV51fGwAIoeOBPyoMytfZFch99GSdnu 4w== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3de4vhanm5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 07 Jan 2022 19:15:47 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 207JAEPj002969;
        Fri, 7 Jan 2022 19:15:46 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2048.outbound.protection.outlook.com [104.47.51.48])
        by aserp3030.oracle.com with ESMTP id 3de4w3fccc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 07 Jan 2022 19:15:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C2iS/SYlDT0RmlRfTAKCWpAtnuuOeuVxKJCCn9pNmcMFp2rjZRhNad5cXy2Sw0pQaKtrQlgiSTjAuDUoPiAsKMavsWUI0wV8RS+HVTC/vHzQ71LTnIno0nSDqoBSnyYmo+Oqdc51elUb6Pu7k+69hvs6OanbTUM8UbrXUsTW14vhrAmIdTiX8nsEz1z/0oYqb5gC0AFp/pxdOzbuJLAXGeqff/soBG4IZx2S+uovGKLNcT+2PlL4g7ey0FSDQmpTNF/UGqwLrUNE6fFakaAmaK6n4quSRhN7mw1bfR67VEmeQvin4Oou+Qxh2HMC2W5U4QTQKXxN6peYE1XUSw6uGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xo4tuD8UN9/Q4GczxPIGJXgNdk0wnLPYnLttQRCQYp0=;
 b=MWnxrvYL4lBl8EubPAL2bxEI1brm1+ZjzoL4KbPfCiJJYGt8ZRxRg0NTyrVNaSJTjHUpP5SjIWioBA3QX3A+t3y2VvkBIVwohQiZO/LGQguJQlqU9E7edGX3V6gg/L9SG/52OCpAwyOPPmEtm/KO0pmx5+MKbMaWjmG+IE+weSJWnVzu5AfuIp99iOgF6jne8KgOwDtDvFQwJmicCFApymwOFdy92PGJi5/xQUvRr5zaLqgSjwOz+j/HeESBKuP1ykYNYuTy5CT3zEzq0uQFOUg+37NK2BpIUYROFymsgHXKbyRKxJVpiEwBwNWc2dHfcKO5BgCeUTPSCMltTaseYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xo4tuD8UN9/Q4GczxPIGJXgNdk0wnLPYnLttQRCQYp0=;
 b=RVlmG89lZRmjt6UQZkHRZgrIhC8Ao4Z2jLWKYwprgWHm7N8iOMk7HSJ5nApz1AaLDxVtUhs1+3CB5Xx7pMPoiIRyPg0qW2m1xG1Ap0PjOdV4F9eCqs5WAtES/l8qXHSrd8kNmW8oVbP3m1RdxXza8Iczfg63YUHnouOPXbpJhSY=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by BY5PR10MB4386.namprd10.prod.outlook.com (2603:10b6:a03:20d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7; Fri, 7 Jan
 2022 19:15:45 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::2531:1146:ae58:da29]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::2531:1146:ae58:da29%7]) with mapi id 15.20.4867.011; Fri, 7 Jan 2022
 19:15:45 +0000
Message-ID: <46407a8e-8011-9cdc-4db5-5679e2b59957@oracle.com>
Date:   Fri, 7 Jan 2022 11:15:43 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.1
Subject: pynfs regression with nfs4.1 RNM18, RNM19 and RNM20 with ext4
Content-Language: en-US
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     linux-nfs <linux-nfs@vger.kernel.org>
References: <CAPt2mGNF=iZkXGa93yjKQG5EsvUucun1TMhN5zM-6Gp07Bni2g@mail.gmail.com>
 <20220107171755.GD26961@fieldses.org>
From:   dai.ngo@oracle.com
In-Reply-To: <20220107171755.GD26961@fieldses.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0058.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::33) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 247c8868-3e8d-481d-dcd2-08d9d2121ab3
X-MS-TrafficTypeDiagnostic: BY5PR10MB4386:EE_
X-Microsoft-Antispam-PRVS: <BY5PR10MB43860BA6CEBBD09994D8A5E2874D9@BY5PR10MB4386.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nQHr5FYjTGLdS0ySHPoEkiv4X7/PSHkH8IGoR2O0dYqZTk56o2hJz7EHnGKOPmQMqRsuRfE6Oq1nWpPEmSEl4NEKkl/pc8lfmy1sX1ZrTy6kkBvAnqQDGyKYqahtUmLiHVQz7TuEk7hiV9ls1Ya6lm0YXe0dcobj+7ORdHVeZtZLc+P6mqYGU6CQ2OdUI6VjRS4p9ecBQ1wFoJMMjFeRjsoOXtDiyfRJYt2Ev3vrbm/uuidbd8EqoyLTCW0QXThT/I6+wC7G+EAmXy2TMKiZC/dW2etW30EoAOvs+Tsu9QOWEdvnljjL5F7s+xX61P+059Lr7tEjVQXvZ/NLlDFdznGBW/gEAxnk19tco0lb07PeYStWGAaVb9dksrEJDo7640VL82O0KT4Hg/dJTQoxAv+gYaEEMr2Sv+uKLg9guYcwutR89w0zqPbVXKC01DhlneSRxHISJYq2Cs02eBbpkOiQqH10CLYGs/Dkw/46EfTJXreqQnfCxOhRq76MJViewwWMGlKHWbLxQP00OZbn316Z+MaZkz+2BhECmTgAKRUD/gYW43px9SefYw8yHCNhdlVAQ6X/oP+ZjziJWIKDFrtYxmarn16g3/2BhqrF6kD8GoDXALMR7XmRlqmzhlGlChe+KW9RjkUsZhr4kX29aZEOs+jFClN5h9X+TnESZv76BMhdSMBL1J5dcfz5f4oqMenUPqrExZH0WkrU+9R2WQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(5660300002)(83380400001)(4744005)(66946007)(36756003)(66556008)(66476007)(31686004)(38100700002)(31696002)(6486002)(6916009)(8676002)(8936002)(316002)(2906002)(2616005)(4326008)(86362001)(508600001)(6506007)(9686003)(6512007)(186003)(26005)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dFpjNUtKK0lKUjMwTjI2YlFSeldCWWIrcGVaeHFQclViQmdCUjJFcHljRTFp?=
 =?utf-8?B?NnJqZUhCdEQ4NEt0Qkc2Zm5oK0xkQ1BPSW9OY09Za0dCNEJJL2Q4bjRTcFVp?=
 =?utf-8?B?RGdLRXo2aVRadTFnbTBRYjIvVXVjK0s4SmRVWDVsakRZcmJiZkRWdkVJTGhR?=
 =?utf-8?B?cmV3dlRjbXlUTHprdGFONE5CaERkWXNmWUo1YUs1cVBXUmdoWVR2VldDVmpW?=
 =?utf-8?B?SHRNYkpVTlpPeFg5Mk50aWFCc1NacnN2bkVFSW5qbDl5TmsrTTRaMVc2WVNX?=
 =?utf-8?B?bFBJSlNBNEthT25XKzhzcjJDWWtVMHNMZmJwUnVvMzIxdGtaaFovRk5LcElF?=
 =?utf-8?B?aUR4R0lPNzJhYU1DUVNoZk94NCtlNU94M2thUW1lWU43cHpwZjRUbFpsTWJh?=
 =?utf-8?B?cWp5ekNaTkp5K0FkRXZXaWhPZUVMSEZCRStTMGpjV1phRm5lb2NvQzF1ZWdq?=
 =?utf-8?B?ak5MQlplNXRyTytWTHk0YWVibE5tL2QwaldvbUhmNUUvQVl6QTQ2em85cUZk?=
 =?utf-8?B?WnVGTDgwSmQyUVpVMUpyZzhYTUd0RkFyTHpVcDF6c003M2lVM2dHT3VyVHJh?=
 =?utf-8?B?dG9yRFErMTAyaXFqL1BvQXduMzFFVERrSTR6QWdYMWRJUVpzL1JYQ1AvSDkr?=
 =?utf-8?B?bWpOME5PRkpiTmFGL095NWQ3dmd6N1hZdEE4SUVDMHptRUlmOEg4ekhMY1BQ?=
 =?utf-8?B?WnV5ay9aM2d5Znl4T3N3UVZWczhCRGlYTzFtMU9FR2d1QXNjbXlMcndrWlZT?=
 =?utf-8?B?M3BxV3E1ZC8rUVBXdDhHOFU5VFJoUERJR1IxelRSaU9HSGZibU1pNXFBYTVT?=
 =?utf-8?B?VjQ5aHE1aGpJZlpFcUlCL2J5d1RVcDZ0ckgvU3Z3RkxBdnBKMXFWdlFTSXM2?=
 =?utf-8?B?L2Q3cGN4Y2FUM2htOFhHaVV0UWVwOFMxVk1xOFRUc21qN0ZBS041c3FFSlNs?=
 =?utf-8?B?eVlEdmp1N1I3VUlZcDV0Q0FRUk4zdDByMFNuaFg1ZGhmYUtqQWFxWGtsYmJo?=
 =?utf-8?B?dkdpU1hPWmhRaGFZaFdOYjE0aUNKYUlLMGo0V3ZEVnhYNTYwY0E2bUNybkxr?=
 =?utf-8?B?RHoxRnErQWZuKzN3Y0luejZBQVdjZWJ4dVFrVFhGd3JhNGd6NVdKTzh3YzFR?=
 =?utf-8?B?Q3drUDZwbW1PakRLSmdVNU11b3k1VUtVZjVMcnozZExBc2R3VUswU2Jnb2RS?=
 =?utf-8?B?ekpMbHlhRWVoMmNZWHhiN01mWXBJOW9NeTQxbC84bjlKK2F5R1V6WFVIMTgz?=
 =?utf-8?B?SHJsdUZSSERVYUZqVmU3bEhUZE9CTzhkRUdXeVdrTW0rc29GaklTY1N2S09t?=
 =?utf-8?B?M09HZlNuRnR3cHRYRWhlZXVkek5WSUtiSWx2amdQc3JiRmFpRElUWXRCUXo4?=
 =?utf-8?B?M3NJM0dpeDhIRE5XM2tRSTRrazI1b3E2bUR5RjUrNUdqanZFd0ZwUjhOc1Ux?=
 =?utf-8?B?aVJteVQ5SGFTOUhuSWJRdC9NTG5UeENSYzZPdWc4ZG9xalFmZXJaUk5MUmJs?=
 =?utf-8?B?Z2JSbW5NQ3FxRkpmbnZzZWI0T3V2ZGMrRmlZUyt2b29HNFJzemRIYXZsOHBn?=
 =?utf-8?B?NmttcDJXbUV2Y2k1UmRhQy9UcWw0YnNkU25oK0tuMklRY2VrVkpsNVM0ci9x?=
 =?utf-8?B?K3dOaWNqa0RhT0RiRUppZEFMZUw0YWZrcE95QzlnUjN0cm1RVFgxSFB5SHBG?=
 =?utf-8?B?SzV4K0haL2YxWGRtM3Z0TTF0NGNrTVFkR1E0OFhCeFQwSnRqTDd2MkgrQy9P?=
 =?utf-8?B?UWtRRGdlR3ZuLzRydFRVdlFxSE85Z3hpZ013eUtmejdDdmpnc0FWRmtrTnhY?=
 =?utf-8?B?SGxibk9TU3hDTkduYjhwZ3Bqa3B3SGJ2TGh0eGlpQnB2VGI4LzNTSktxb2dt?=
 =?utf-8?B?V3QwZ0ZIaDFKZzZxdHZjaElpNEdPZGsyeTJFNiszNkk2VXJSYjlTUmNmR1Bv?=
 =?utf-8?B?TXU1Tmo2T0M5TDEwalFsaURZeUMvNmtyR3Z0SFQzMURHdXVKelBvZTRxUXVq?=
 =?utf-8?B?ZUg4WUZzelRqZVF0ZVdQMzUxK2p0eGxFby94VjZuWFIwLzFXUnRUWU9jeTl6?=
 =?utf-8?B?UVpCT3pwcHNXc1JFbytnWDg0TS9nSUZYT2daT1R6QUM5SUNWWGlvc25HSjJZ?=
 =?utf-8?B?VUpSQTdDZVNnNjJiZklqOGdFeHlmYmpOSDJnV003NHNDWThEendWQWg3OXFt?=
 =?utf-8?Q?K0vz+RyIeHHLf2hdjlgRIGA=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 247c8868-3e8d-481d-dcd2-08d9d2121ab3
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2022 19:15:45.1218
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nDrlnM99ZTkc336LQjb33+iI8bd6HrhZ0CTJtGGk0xxtVfAoKzpJTtx9xMCREBVgcJXqrVMIZzx05obehMnYvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4386
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10220 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 suspectscore=0 phishscore=0 spamscore=0 bulkscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201070120
X-Proofpoint-ORIG-GUID: 0dLlMAMGXztUttCJzGIW2SCJ_XBSP6a1
X-Proofpoint-GUID: 0dLlMAMGXztUttCJzGIW2SCJ_XBSP6a1
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Bruce,

Commit428a23d2bf0ca 'nfsd: skip some unnecessary stats in the v4 case' causes 
these tests to fail when the filesystem is ext4. It works fine with 
btrfs and xfs. The reason it fails with EXT4 is because ext4 does not 
have i_version-supporting. The SB_I_VERSION is not set in the super 
block so we skip the fh_getattr and just use fh_post_attr which is 0 to 
fill fh_post_change. I'm not quite sure what's the fix for this. If we skip the fs_getattr
for v4 thenfh_post_attr is 0 which causes the returned change attribute to be 0. -Dai

