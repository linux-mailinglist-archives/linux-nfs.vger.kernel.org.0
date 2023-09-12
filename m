Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A13779D309
	for <lists+linux-nfs@lfdr.de>; Tue, 12 Sep 2023 15:59:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235566AbjILN7P (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 12 Sep 2023 09:59:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234939AbjILN7O (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 12 Sep 2023 09:59:14 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA11610CE
        for <linux-nfs@vger.kernel.org>; Tue, 12 Sep 2023 06:59:10 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38C9nEWx000620;
        Tue, 12 Sep 2023 13:59:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=WpSOKlJwl/55hTObHlqxcAx51V1HZXzGgkdy1unlx9Y=;
 b=oL75PK84E0cyTXCX4j09+pGe+uESNoV1y+qwVYq6q7gsxih5rvov1BE6LrYh3qZReyqS
 eEfc3I7MdvllPWPBZKMUKG8f6dcDD4bPgZiYwPdOUn39Km7yvsx8Ez2RGjeA/9EUR4hG
 okT8tqWy8/hkNbsj1cv8OAnkTdRQHa/ZE32yEkQCPDULfUwrJLmTPq1KyCMhuWnIZixQ
 LYe0IkMJAJPCQs/JKpjq1NvTgSCf8xsPf783+27H3+cRR6dXIEMga/q+RFxDT2tNMMGx
 gnTDehEGX2NIUrbIjr5ZPKA6yBJMM+vedsydLk9HbpWRepmGa1ZtHKI8lw2bQSoe76+y tQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t1k4cc0jy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Sep 2023 13:59:04 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38CD2A2A007718;
        Tue, 12 Sep 2023 13:59:00 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3t0f55svbe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Sep 2023 13:59:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E/Uvb1OnbG5qh3BlGINJ5sRFkTdPrJlKCPEKl1OrSna0gBvno8ONaMwiredJwVG3V15poeWIUcp5I+qMzukD/w8uafp6juYvVn3b5L8nW6ugQrp+etqX/eoRuO21XcOCNGLhzrdchrPcIE3jJmK5KmYGJAlGO8sIOkRxOiOFipdRcnLje3A5hy5VmGIqlz9dyaRqgGtOW9kE4WMWEWDilt5AHLIAKkZ8br8ts3nkdizljgYlVO8GwxtB0EYXomLZ7/FU5nf4rzrlEnAmiLGPwZCwNVXjC6LVX1o9u733Fp/bsGdr8yiYFMoWRxh1/Om15mPU+uHCKbrMGyXLKZzA8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WpSOKlJwl/55hTObHlqxcAx51V1HZXzGgkdy1unlx9Y=;
 b=kCqSqfTC+4MVXj17TRZP+SCtD+cV1O0SZ61r/s8cwflb66LHaxyAbjSosORsHMGXj2ET+CsVDshvS0YLJUIugFxkL0woLsj0/bjXWimgv7vSxnENapc+4UNy4W6ph3bhb2PziV82QX9JzGMsU40N126H4wn0NY9blly1Ar82LexKi7Wd6q1ZNc44x8/Gtsg/IBWuiVCgQWNmHbJYyOHdJJoTmy8ZOwYMIBHVXCQuMfBANTjj1h7OzmNorSuOSS6NDUS5DMVl8uE+jUQslLGl6lzsU/KkRH05sW8aMucZ87A8vfblSyvx86XKGQNf4uy6ZR9wgIh+U4xn6Gpx7lIH4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WpSOKlJwl/55hTObHlqxcAx51V1HZXzGgkdy1unlx9Y=;
 b=vN2pZJdn7ci2WyB3n1YIt6Uho4ggoXc+d/GfATA+h788BAgjQcGNcCCftCx7HlTkhbBR+YIxzqUFwpzko5mSXf2XCgV4eOtpaQGAiW2Ez5dU7YrtA1OevUFw7Vsp5EYjgaia3UcyU7tZEyLaPYpQDVscF2PKSCtyFvfeh7Ri8go=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by BN0PR10MB5208.namprd10.prod.outlook.com (2603:10b6:408:125::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.38; Tue, 12 Sep
 2023 13:58:57 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::fe75:575d:5963:93d7]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::fe75:575d:5963:93d7%5]) with mapi id 15.20.6792.019; Tue, 12 Sep 2023
 13:58:57 +0000
Message-ID: <08aebfbb-549e-b797-471d-acd8b5c05454@oracle.com>
Date:   Tue, 12 Sep 2023 06:58:52 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: =?UTF-8?B?UmU6IOWbnuWkjTogW1BBVENIIHYyIDEvMV0gTkZTRDogYWRkIHRyYWNl?=
 =?UTF-8?Q?_points_to_track_server_copy_progress?=
To:     "Hanxiao Chen (Fujitsu)" <chenhx.fnst@fujitsu.com>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>,
        "jlayton@kernel.org" <jlayton@kernel.org>
Cc:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
References: <1693510547-29288-1-git-send-email-dai.ngo@oracle.com>
 <OS3PR01MB564053F04D4B2BDE86B5051BE6F1A@OS3PR01MB5640.jpnprd01.prod.outlook.com>
Content-Language: en-US
From:   dai.ngo@oracle.com
In-Reply-To: <OS3PR01MB564053F04D4B2BDE86B5051BE6F1A@OS3PR01MB5640.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA0PR11CA0005.namprd11.prod.outlook.com
 (2603:10b6:806:d3::10) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4257:EE_|BN0PR10MB5208:EE_
X-MS-Office365-Filtering-Correlation-Id: a2de0053-6c59-43b5-113c-08dbb3986887
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pDyKImdI05Muz+PrclkG5ggYMaoP0eJ7RBxdb9CECen0YiuQ/XOgK0zW82jL27nAr3Ed80QjL1VqNU+3aj0medNCapcYJaV/yaMOek8wmen//7fILuM2klokcHRpJqYsxKWBpPCKiDr0sNORUh2mxvtXv3vHGteKjEVGRx+f5u1UMJfJ33B57i5BXizbXPFWC5XJw5bPK+RKR/q/v7QFdun2Qh83vf0kxv3D/6JHaC1Thug4JaTLlyRssdQZQ16sFzTJUy9d+baT1687M+DmTzivNLNfWV/awc8jjdUsuvgIBi9P/p1U4uPCKm42goMPCxn5v6Ew7lcLHAQN3eDiDo/LOWc6HgmVL2px0In6wqIcWiGx/qxjWtK0RDDSVwtaNQ02uhgsr93mQyXxnsy9WFaG0c2Tpj/AoMfCbFb6IVEQMBT8SkUt7EICplySs3XAQ/74fEdzXzvkrg2109VIEYFlUgEIuAEFB4cH9DH5H9vB3Yvkr4JKNazSiHFYhIVZisMU0JcKB8kSdXwM7yYzqx474+DZLgUIoC42jfbZgr3aJOOkkp/FtVASi7DCfSm4T4g/IFvLCWhR0XzpEZZVWv1TVruG/R5UvHeY59og//nVwT3mlqoJDgrF7SJVvDcx
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(136003)(366004)(376002)(346002)(186009)(451199024)(1800799009)(66556008)(8936002)(41300700001)(83380400001)(4326008)(478600001)(45080400002)(110136005)(66946007)(6666004)(26005)(2616005)(6486002)(316002)(53546011)(6506007)(6512007)(9686003)(30864003)(2906002)(66476007)(38100700002)(31696002)(86362001)(5660300002)(36756003)(224303003)(31686004)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UmtQS2tqL1Rxa1p1RC9CNDM4VEtuR3I0blFZZkdMdnhpeUtLWGVIUXFibXdp?=
 =?utf-8?B?ZEVrNFRLTHJSNGxHckMzcHFSemJwYTVtZjkvYUdxZlFNSEl1aHBZc1BQVDFy?=
 =?utf-8?B?cjlEQnBlWTlEbXJXVHJud3B1Y094WmVteTBwSy9RbWNYK1MzcExFMW1zOWNK?=
 =?utf-8?B?SzlJOTdRajlldHRFZmNHTUFVWE5KOXpUaFR6YUR5V0xtUEd5V1ZYM1N2R0pu?=
 =?utf-8?B?RElMM2RmZG56bmJHOXAwVVlJaG5ZS1B1bXpUNjFpSTlrbTBnaU0vcTN5aDgv?=
 =?utf-8?B?UG9JZGpOcUxkYnVEVlcxOHVjWmM0U20vbWZPL2VQcmdDZ3Y0bzRYZ2pKbXpP?=
 =?utf-8?B?R2lyNVV3ZnBHU1lJZzk4c1doQXRtYTA4MXZNR2x2cFBBQUdIeDRPTGFORkxQ?=
 =?utf-8?B?eUJGcFdLcDNsaWUwOGYvdU80clVtajZSSEZQSis4SGZKbzZxTWR1QmRjUzhM?=
 =?utf-8?B?OGxHdnpGc1FqZDBLS2NGMGVZZXBXdldKdC9zTEVBOXF0NXBYV2F2Mmhpc3Rw?=
 =?utf-8?B?VXZQVkxLNnlMclAya3FUUWRPRm5oaWhWT3BJR1ZQeVcrT0Iva0pxVTllTjNz?=
 =?utf-8?B?SDFwcXY1VktaUnFNYVNSY0pmL25kNFRFTXA2ekwzdE5tamdoRWlObmdiWXlU?=
 =?utf-8?B?UlNRTlVza2drOGVFeTZId215OXJsUGM4QlNKWkdib3Q1a0U5Z3RyNjlkWllG?=
 =?utf-8?B?d3FkMS9PZi9EbXhVUmYwSXFGQVIvZDRWdzYyRGZJSm5abXdzSjFPdk5qVSs2?=
 =?utf-8?B?amtMK1NFZWpFdS96UGQvZnNoYUFwdUFNYlNqdkpFMXVEdk5nbHlKK0I2amlS?=
 =?utf-8?B?QUlzejFpMXJqM0txZWZNb2pqeW9mQmMxN3lRb2l1OEE3dGpWdkxpK3M4MTY3?=
 =?utf-8?B?TDRRRld2MFl4cUI0N1cxZmViWW85WXhObEpvRVVSRkt3eVRUN0xTYWM1Ymhx?=
 =?utf-8?B?bHhpb3dSS2F0cndpRDJlQ3FuVWJRWUNoNXpQaHJMYzVDd2YxUWRBWXpKMnZB?=
 =?utf-8?B?YnBXSjFKeU5sUTB6OFhqUjI0NEhvMVRvTkpwQ1pMdThveVlzeENaUVBNcHZt?=
 =?utf-8?B?R2c1RGh5SWhuSUozaEZqMTV4cG1zQ0t1UnJYQUpXZ29IcXBSSFZtZEozWWFw?=
 =?utf-8?B?QWwyd0d1Q2ZodjlpRXJOdjVFK0w2TU8vK2oxL3dmQTcvY2tqcCtiM2I4Sllq?=
 =?utf-8?B?bm10M0RxYWRUaEhGenJTY3BhM3Bjb1ZIYm9obmxmdUV2Q1h1K0xhem5GQkJF?=
 =?utf-8?B?VXYxa2lYUGRqeVpwVWlheEZ3RGgvUEpXUGdLcDRXTnlFVHZpU0ZWYlVwYkts?=
 =?utf-8?B?MnA1NGlxdndlNytXM1l4QXdYdU9pTG1hQjRkbGRlU3ZXUTBwL3I1MmwwcThh?=
 =?utf-8?B?SS9yU1NYUFc0MDcrSWQrc1Z5dGo1UTc1Vk1FN1dEaFQxNDhMT0grbEFkTEhs?=
 =?utf-8?B?aWR4OCtNTHJQQ0tJY2E5QWR6ZzVua1lXa0NyYVdnUkU2ZkRXc3RUOG1MdHBK?=
 =?utf-8?B?UitkS1l2WDZ1UEFIODYzbWNWejNERVVhZWNnV0ZQcW9jUmlTUkdDRjU5MDV0?=
 =?utf-8?B?YXJoR1NnUmw1U3I1QlQyeHhsM1ZISDRwQUZkOHo2eVR0QTZqZzlOQVg4TVZE?=
 =?utf-8?B?V0Fyc1F1TTNaN1VrZXh3SG5xNS9zeEZRL216SkFZUFAwMDNuSlNUaDJrQzlY?=
 =?utf-8?B?ZUx3ak5yL1VJdWdubHh5RDJveHVTOXN2V2hGeG5XaFAzT083dkF6WVlNQmNl?=
 =?utf-8?B?dWNQYk5EQ2RuSXh5S3kzWkRiUmtqNW1yYVNnalpQSVlqdFN6aDdqTW1kZXBT?=
 =?utf-8?B?TzJSRmhWTW1qV0F4cDVMeDVITHJnOEExZ1oxVE96cGVIYU1FcVI5d1BBeDF3?=
 =?utf-8?B?cDhuRnZ2b1U2dUZUZHk1cjNkeXR6VXE0VmZzaVRUVk9MMi9RK0JsSHUzLzN3?=
 =?utf-8?B?VjJLeEQ0VGRGSDlBUW1YRUlkbVpicmVUeEVFS0kzbnNnckM5eEVKeXJQa0xF?=
 =?utf-8?B?ajh3cHRnNlpPdS92WVBibG9FbUxqYkZHUlVDUnR1M0JybVJEenJJR0taUVpx?=
 =?utf-8?B?UkU2ZnlSa3RnRDhTbit4MGFIWjNlR25udmI4RU9aQUpDVTRITWdlOHREaGR3?=
 =?utf-8?Q?ERHxwFw7pkhbMBEX6dTMM9ibC?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: XNqdF/3UsFXrLaFlKL7ukv3+DR9/mJHK3dIqOFcJnK3vWuPfT/3qP8NH9UaGJgEwFLczlX5mnuGmnIwEtEZhfztb7JmRDxUARo2wkvmZrqfE1KzT8V3w/eALL1MHxfed68qAabrSpAySP+NslOIzmDfyCd+B5ttKuc7be2augVjP/wGR2wH9rPLm6KI6XVrY+qdE3oHOzOmZsnCkDdTEq1uK61X57vicjyFSPoqX2jLsqPOi2/NsANzCIGyweNpliOkX3wPwuJPtoAB8hNOHE3SXY5aIf3YXq+TuY5hbuLHOe2UtIu6njUOtCbOsoydJK9ttfs87D3NQZa/xglo2HGMh9jfYbmmRs6aSIFVJA8J+ehJi4ufuvfVflpB3jGr11bf25s6G1KfylO6wfs3S4isUKWMCFz8Xl+XQdqh6tVm/olLvos38R9iy3DqG0/LI2l0aegushyewwnFDQ1hmoBpUsxbHTvm4dYGJqwMeWj9+/jzH9kOuSGsKtkvPqI9jsEKL5dRe05Y2W65HBgtTxIGsOcnPNORliuYZCvfZUNXUdpf3oymBJG84WEdk/5QnTpvdCaXj4iv68jEdq6Ewgp8kHGU+Gctf88sF7DCzNqlAcN92EWXAcD0zuD6P0aXm5+QI/AjtNFyABVmEBmMCSc6DSuL0+A2yw/I81Dfgqwaq1RfDYZqvZJX34QU6XT9dsKyoZgnckgOqrCnrhwcS201OCIRcyUoDwmY7FmPeCtP6GUhyDmEs49P7O/P+8ToEaD3MyKA1cRpeXhN2FT84cL9MMK+MPOvLgz1EykNaqpiuwY1akvZdcuCynR0as19Z
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2de0053-6c59-43b5-113c-08dbb3986887
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2023 13:58:57.4873
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qRhAvj2wAmzmwOGUwuB+JnQa0Twu7zOR7xm5EwOcr6+mB5vJ+U6lmY2ZFk0TJhQdR3FVOz5Ou/wB2ZcXz/tcqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5208
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-12_12,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 spamscore=0 mlxscore=0 mlxlogscore=999 adultscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309120117
X-Proofpoint-GUID: XeQd0AnGg02llAli7LMvl8dUlhkt_apg
X-Proofpoint-ORIG-GUID: XeQd0AnGg02llAli7LMvl8dUlhkt_apg
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Chen,

Did you also apply this patch:

[PATCH 1/2] NFSD: initialize copy->cp_clp early in nfsd4_copy for use by trace point

This patch is a prerequisite for
[PATCH v2 1/1] NFSD: add trace points to track server copy progress

Sorry for the confusion.

-Dai

On 9/11/23 7:39 PM, Hanxiao Chen (Fujitsu) wrote:
>> -----邮件原件-----
>> 发件人: Dai Ngo <dai.ngo@oracle.com>
>> 发送时间: 2023年9月1日 3:36
>> 收件人: chuck.lever@oracle.com; jlayton@kernel.org
>> 抄送: linux-nfs@vger.kernel.org
>> 主题: [PATCH v2 1/1] NFSD: add trace points to track server copy progress
>>
>> Add trace points on destination server to track inter and intra server copy
>> operations.
>>
>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>> ---
>> v2: rename trace points from nfsd4_trace_... to nfsd_trace_...
>>      fix kernel test robot by removing ifdef CONFIG_NFS_V4_2 in trace.h
>>
> Hi, Dai
>
> 	I'm testing this patch base on 7ba2090ca64ea1aa435744884124387db1fac70f via Fedora 38.
>   	but got some oops message.
> 	Pls have a look.
>
> Regards,
> - Chen
>
> How to reproduce:
> server:
> trace-cmd record -e nfsd:nfsd_copy*
>
> client
> mount -o vers=4.2 192.168.122.212:/nfstest /mnt/test
> mount -o vers=4.2 192.168.122.212:/nfsscratch /mnt/scratch
>
>
> cp /mnt/test/some-file.tgz /mnt/scratch
>
>
> [  713.008623] CPU: 0 PID: 1562 Comm: nfsd Kdump: loaded Not tainted 6.5.0+ #14
> [  713.008660] Hardware name: Red Hat KVM/RHEL-AV, BIOS 1.13.0-2.module+el8.3.0+7353+9de0a3cc 04/01/2014
> [  713.008699] RIP: 0010:trace_event_raw_event_nfsd_copy_class+0xd6/0x140 [nfsd]
> [  713.008868] Code: 48 8b 53 20 48 89 50 30 48 8b 53 28 48 89 50 38 48 8b 53 30 48 89 50 40 48 8b b3 f8 00 00 00 48 8d 50 4c 48 8d 8e b8 00 00 00 <48> 8b b6 b8 00 00 00 48 89 70 4c 48 8b 41 08 48 89 42 08 48 8b 41
> [  713.008944] RSP: 0018:ff22381280edfd78 EFLAGS: 00010202
> [  713.008972] RAX: ff12ee8a8007701c RBX: ff12ee8a820988e0 RCX: 00000000000000b8
> [  713.009004] RDX: ff12ee8a80077068 RSI: 0000000000000000 RDI: ff22381280edfd78
> [  713.009036] RBP: ff12ee8a90afdf00 R08: 0000000000000001 R09: 0000000000000000
> [  713.009055] R10: 0000000000000000 R11: 0000000000038560 R12: ff22381280edfd78
> [  713.009064] R13: ff12ee8a959b4000 R14: 0000000000000000 R15: ff12ee8a820988c0
> [  713.009074] FS:  0000000000000000(0000) GS:ff12ee8afba00000(0000) knlGS:0000000000000000
> [  713.009084] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  713.009091] CR2: 00000000000000b8 CR3: 0000000110970004 CR4: 0000000000771ef0
> [  713.009104] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [  713.009113] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [  713.009123] PKRU: 55555554
> [  713.009127] Call Trace:
> [  713.009134]  <TASK>
> [  713.009139]  ? __die+0x1f/0x70
> [  713.009148]  ? page_fault_oops+0x171/0x4f0
> [  713.009157]  ? __kmem_cache_alloc_node+0x175/0x310
> [  713.009167]  ? security_prepare_creds+0xc5/0xe0
> [  713.009177]  ? exc_page_fault+0x7b/0x180
> [  713.009186]  ? asm_exc_page_fault+0x22/0x30
> [  713.009195]  ? trace_event_raw_event_nfsd_copy_class+0xd6/0x140 [nfsd]
> [  713.009237]  ? trace_event_raw_event_nfsd_copy_class+0x4b/0x140 [nfsd]
> [  713.009274]  nfsd4_copy+0x47d/0x6e0 [nfsd]
> [  713.009319]  nfsd4_proc_compound+0x399/0x6f0 [nfsd]
> [  713.009360]  ? __pfx_nfsd+0x10/0x10 [nfsd]
> [  713.009401]  nfsd_dispatch+0x80/0x1b0 [nfsd]
> [  713.009442]  svc_process_common+0x439/0x6e0 [sunrpc]
> [  713.009510]  ? __pfx_nfsd_dispatch+0x10/0x10 [nfsd]
> [  713.009551]  ? __pfx_nfsd+0x10/0x10 [nfsd]
> [  713.009599]  svc_process+0x12d/0x170 [sunrpc]
> [  713.009890]  nfsd+0x80/0xd0 [nfsd]
> [  713.010142]  kthread+0xf0/0x120
> [  713.010352]  ? __pfx_kthread+0x10/0x10
> [  713.010569]  ret_from_fork+0x2d/0x50
> [  713.010771]  ? __pfx_kthread+0x10/0x10
> [  713.010972]  ret_from_fork_asm+0x1b/0x30
> [  713.011176]  </TASK>
> [  713.011374] Modules linked in: rpcsec_gss_krb5 rpcrdma rdma_cm iw_cm ib_cm ib_core nfsd auth_rpcgss nfs_acl lockd grace nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 rfkill sunrpc ip_set nf_tables nfnetlink qrtr intel_rapl_msr intel_rapl_common nfit libnvdimm kvm_intel kvm snd_hda_codec_generic ledtrig_audio snd_hda_intel snd_intel_dspcfg snd_intel_sdw_acpi snd_hda_codec iTCO_wdt irqbypass intel_pmc_bxt snd_hda_core iTCO_vendor_support snd_hwdep snd_pcm snd_timer snd i2c_i801 i2c_smbus pcspkr lpc_ich soundcore virtio_balloon joydev fuse loop zram xfs crct10dif_pclmul crc32_pclmul crc32c_intel polyval_clmulni polyval_generic ghash_clmulni_intel qxl sha512_ssse3 drm_ttm_helper virtio_net ttm virtio_blk net_failover virtio_console failover serio_raw scsi_dh_rdac scsi_dh_emc scsi_dh_alua dm_multipath qemu_fw_cfg
> [  713.013232] CR2: 00000000000000b8
> [  713.013460] ---[ end trace 0000000000000000 ]---
> [  713.013688] RIP: 0010:trace_event_raw_event_nfsd_copy_class+0xd6/0x140 [nfsd]
> [  713.013944] Code: 48 8b 53 20 48 89 50 30 48 8b 53 28 48 89 50 38 48 8b 53 30 48 89 50 40 48 8b b3 f8 00 00 00 48 8d 50 4c 48 8d 8e b8 00 00 00 <48> 8b b6 b8 00 00 00 48 89 70 4c 48 8b 41 08 48 89 42 08 48 8b 41
> [  713.014406] RSP: 0018:ff22381280edfd78 EFLAGS: 00010202
> [  713.014644] RAX: ff12ee8a8007701c RBX: ff12ee8a820988e0 RCX: 00000000000000b8
> [  713.014880] RDX: ff12ee8a80077068 RSI: 0000000000000000 RDI: ff22381280edfd78
> [  713.015117] RBP: ff12ee8a90afdf00 R08: 0000000000000001 R09: 0000000000000000
> [  713.015351] R10: 0000000000000000 R11: 0000000000038560 R12: ff22381280edfd78
> [  713.015590] R13: ff12ee8a959b4000 R14: 0000000000000000 R15: ff12ee8a820988c0
> [  713.015821] FS:  0000000000000000(0000) GS:ff12ee8afba00000(0000) knlGS:0000000000000000
> [  713.016057] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  713.016296] CR2: 00000000000000b8 CR3: 0000000110970004 CR4: 0000000000771ef0
> [  713.016536] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [  713.016778] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [  713.017019] PKRU: 55555554
> [  713.017263] note: nfsd[1562] exited with irqs disabled
> [  713.017532] note: nfsd[1562] exited with preempt_count 2
> [  835.057703] ------------[ cut here ]------------
> [  835.058376] WARNING: CPU: 2 PID: 1712 at kernel/trace/ring_buffer.c:5304 reset_disabled_cpu_buffer+0x254/0x270
> [  835.058643] Modules linked in: rpcsec_gss_krb5 rpcrdma rdma_cm iw_cm ib_cm ib_core nfsd auth_rpcgss nfs_acl lockd grace nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 rfkill sunrpc ip_set nf_tables nfnetlink qrtr intel_rapl_msr intel_rapl_common nfit libnvdimm kvm_intel kvm snd_hda_codec_generic ledtrig_audio snd_hda_intel snd_intel_dspcfg snd_intel_sdw_acpi snd_hda_codec iTCO_wdt irqbypass intel_pmc_bxt snd_hda_core iTCO_vendor_support snd_hwdep snd_pcm snd_timer snd i2c_i801 i2c_smbus pcspkr lpc_ich soundcore virtio_balloon joydev fuse loop zram xfs crct10dif_pclmul crc32_pclmul crc32c_intel polyval_clmulni polyval_generic ghash_clmulni_intel qxl sha512_ssse3 drm_ttm_helper virtio_net ttm virtio_blk net_failover virtio_console failover serio_raw scsi_dh_rdac scsi_dh_emc scsi_dh_alua dm_multipath qemu_fw_cfg
> [  835.060996] CPU: 2 PID: 1712 Comm: trace-cmd Kdump: loaded Tainted: G      D            6.5.0+ #14
> [  835.061311] Hardware name: Red Hat KVM/RHEL-AV, BIOS 1.13.0-2.module+el8.3.0+7353+9de0a3cc 04/01/2014
> [  835.061633] RIP: 0010:reset_disabled_cpu_buffer+0x254/0x270
> [  835.061952] Code: 28 01 00 00 00 00 00 00 4c 89 e7 e8 56 13 d7 00 90 5b 48 89 ee 4c 89 ef 5d 41 5c 41 5d e9 c4 0a d7 00 48 8b 43 10 f0 ff 40 08 <0f> 0b eb e3 89 c6 4c 89 e7 e8 2e 16 d7 00 90 e9 d4 fd ff ff 0f 1f
> [  835.062611] RSP: 0018:ff2238128073bbd0 EFLAGS: 00010002
> [  835.062945] RAX: ff12ee8a8003e700 RBX: ff12ee8a80040c00 RCX: 0000000000000000
> [  835.063282] RDX: 0000000000000001 RSI: 0000000000000000 RDI: 0000000000000000
> [  835.063619] RBP: 0000000000000206 R08: 0000000000000000 R09: 0000000000000000
> [  835.063941] R10: 0000000000000001 R11: 0000000000000100 R12: ff12ee8a8003e700
> [  835.064260] R13: ff12ee8a80040c18 R14: ff12ee8a82d4ac98 R15: ff12ee8a82d4ac00
> [  835.064576] FS:  00007f433e809780(0000) GS:ff12ee8afbb00000(0000) knlGS:0000000000000000
> [  835.064884] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  835.065190] CR2: 00005635914ef0f8 CR3: 0000000110970006 CR4: 0000000000771ee0
> [  835.065495] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [  835.065788] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [  835.066082] PKRU: 55555554
> [  835.066374] Call Trace:
> [  835.066666]  <TASK>
> [  835.066943]  ? reset_disabled_cpu_buffer+0x254/0x270
> [  835.067216]  ? __warn+0x7d/0x130
> [  835.067488]  ? reset_disabled_cpu_buffer+0x254/0x270
> [  835.067761]  ? report_bug+0x18d/0x1c0
> [  835.068029]  ? handle_bug+0x3c/0x80
> [  835.068294]  ? exc_invalid_op+0x13/0x60
> [  835.068558]  ? asm_exc_invalid_op+0x16/0x20
> [  835.068827]  ? reset_disabled_cpu_buffer+0x254/0x270
> [  835.069087]  ring_buffer_reset_online_cpus+0x7e/0xc0
> [  835.069346]  tracing_reset_online_cpus+0x6e/0xc0
> [  835.069610]  tracing_open+0x143/0x160
> [  835.069864]  ? __pfx_tracing_open+0x10/0x10
> [  835.070120]  do_dentry_open+0x200/0x4f0
> [  835.070371]  path_openat+0xafe/0x1160
> [  835.070627]  do_filp_open+0xaf/0x160
> [  835.070880]  do_sys_openat2+0xab/0xe0
> [  835.071129]  ? kmem_cache_free+0x1e/0x3e0
> [  835.071380]  __x64_sys_openat+0x53/0xa0
> [  835.071636]  do_syscall_64+0x59/0x90
> [  835.071883]  ? syscall_exit_to_user_mode+0x27/0x40
> [  835.072128]  ? do_syscall_64+0x68/0x90
> [  835.072367]  ? syscall_exit_to_user_mode+0x27/0x40
> [  835.072604]  ? do_syscall_64+0x68/0x90
> [  835.072825]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
> [  835.073044] RIP: 0033:0x7f433e918015
> [  835.073254] Code: 83 e2 40 75 50 89 f0 f7 d0 a9 00 00 41 00 74 45 80 3d d6 c5 0d 00 00 74 60 89 da 4c 89 e6 bf 9c ff ff ff b8 01 01 00 00 0f 05 <48> 3d 00 f0 ff ff 0f 87 7f 00 00 00 48 8b 55 b8 64 48 2b 14 25 28
> [  835.073690] RSP: 002b:00007ffd20591490 EFLAGS: 00000202 ORIG_RAX: 0000000000000101
> [  835.073904] RAX: ffffffffffffffda RBX: 0000000000000241 RCX: 00007f433e918015
> [  835.074116] RDX: 0000000000000241 RSI: 00005635914db9c0 RDI: 00000000ffffff9c
> [  835.074325] RBP: 00007ffd20591500 R08: 0000000000000004 R09: 0000000000000001
> [  835.074532] R10: 00000000000001b6 R11: 0000000000000202 R12: 00005635914db9c0
> [  835.074736] R13: 000056359037a976 R14: 000056359037a976 R15: 0000000000000001
> [  835.074933]  </TASK>
> [  835.075121] ---[ end trace 0000000000000000 ]---
>
>
>
>
>
>
