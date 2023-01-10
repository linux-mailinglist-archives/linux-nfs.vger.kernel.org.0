Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 013E2664BA6
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Jan 2023 19:53:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235191AbjAJSw7 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 10 Jan 2023 13:52:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239766AbjAJSwV (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 10 Jan 2023 13:52:21 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DCC955849
        for <linux-nfs@vger.kernel.org>; Tue, 10 Jan 2023 10:47:04 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30AIhkes031976;
        Tue, 10 Jan 2023 18:46:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=Xscj67xXSlPeQarWfEg5pN2Lz9W4jBi2hZF1Nl09lvI=;
 b=I8w5vTzCqJa0ahXr39o7ggwlmukHrGWXWBFM29nFr+1bmPCcENTcaIiYQrsZrmAdFDaP
 C5eJqLRJhs8WmSiMctKKtBJb8I06RC89HSiEcNtIuHjpU22UDvHV712T0L/lQmgNNro4
 e/m4wRjs+l7sFSxxUO5EMnu9BjZFZiX1Qk447T4W/yn36S84yOr14MtZ9r7fLciYkYWW
 FQLDqaVcixTp+gRuTOdG3KMV0+1yQXwGuCuNfedzAf65VyKNtUZCZOAUCZ+YfFk4FpCE
 O1MX8D+gsaaGiEshJehciIpqwHEDdJgv2tj60Hk+sLEPGOFfpOCFiBrXS9qlozRbvQ4f Bg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n1cbq86jn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Jan 2023 18:46:58 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30AIVs9N004112;
        Tue, 10 Jan 2023 18:46:58 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3n1b081gen-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Jan 2023 18:46:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aRI5CvBatQVDKv3P7j1nPHSQTgqqtSnAGmmmx+EijzjuBsmAUKRL+hwTvemqJwi+wQNEb0Sp/IIZFd1M0Ep+GX1t+A37bbelOXWflbTNGvQxdnskVs5DhpIG15d+n623VPpbn++F38yAk0qLUAzeYzALmRtYWYtNawmuc5nOVwV2ndQd4Ssf0Vn3bHyevO3FDMnFUsyYPNUVc/ldKUsMmINEyXLhLe4IljEk7oirVdu59UM6OtWH36/VaGZh/QLVTkVFG6VBbpfIqBP/5RdpzicToXMs6jULYjc8/okw2m67NVi4EKMAkXbRmg9ug/yZx8DJr5S5OpdY/7r8eEKktQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xscj67xXSlPeQarWfEg5pN2Lz9W4jBi2hZF1Nl09lvI=;
 b=hzVAbjIuxiPOHdAlrXyp4cTx66PEeI2GgB1zgtBLzAR6uWcHESWnZdi2fFPrx50I7IK+7VXDvq34rgE1J3AoSabvg3k4my//1cExyBr20tNWuAR+usvsLX/KIqwInArzxDXOiHy24Vjva5gIkHYZsEhuebU9pOHwiEEo7eU1FwYlBR9hDTRHrKehyy5VZZxOVlDVffMb6DsQyy6BbO7Tu5eyJbmi1lSDZtDNbOfXmoRcN3AN5zCQjVqKo0a7iwnT0gLMnMYxRLa54zNsDu4X0cb7Itj39kfnwtUpAA1jnKzWwD6wCcTqrhpLbfm0SmPiP73QBQiujYBbUyuJI1EpQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xscj67xXSlPeQarWfEg5pN2Lz9W4jBi2hZF1Nl09lvI=;
 b=iAKqJUnPdLTZvNegsKIH7uILRX83LKxKHWJtSJhBhMpxbbxFRzIOrrPpCIK6dsP1zWQG8AslpquWdGHCgB1pk/4sOOeqxv820CZW54J0Ml7VfgU1wfBVM5TgDRtPRk9FEoPXlRJHJ01aJuvkGckvolFK7Tl7jgTkfA/oDfZi8Gw=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by BN0PR10MB5383.namprd10.prod.outlook.com (2603:10b6:408:124::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.10; Tue, 10 Jan
 2023 18:46:56 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::940c:19a:12c5:e152]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::940c:19a:12c5:e152%7]) with mapi id 15.20.6002.012; Tue, 10 Jan 2023
 18:46:55 +0000
Message-ID: <a6a0b2cc-1bc0-3884-8675-f90051454f94@oracle.com>
Date:   Tue, 10 Jan 2023 10:46:52 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH 1/1] NFSD: fix WARN_ON_ONCE in __queue_delayed_work
Content-Language: en-US
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Jeff Layton <jlayton@kernel.org>, Mike Galbraith <efault@gmx.de>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
References: <1673333310-24837-1-git-send-email-dai.ngo@oracle.com>
 <57dc06d57b4b643b4bf04daf28acca202c9f7a85.camel@kernel.org>
 <71672c07-5e53-31e6-14b1-e067fd56df57@oracle.com>
 <8C3345FB-6EDF-411A-B942-5AFA03A89BA2@oracle.com>
From:   dai.ngo@oracle.com
In-Reply-To: <8C3345FB-6EDF-411A-B942-5AFA03A89BA2@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1PR03CA0023.namprd03.prod.outlook.com
 (2603:10b6:806:2d3::28) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4257:EE_|BN0PR10MB5383:EE_
X-MS-Office365-Filtering-Correlation-Id: 93825a95-16fa-4b85-32ce-08daf33b0c01
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cN4q7jZC+i9nI4v9LPIHqlGdnEu9UedOmfVsUpF8EcP/EwWOzVYWIySC1gWy3VM2XoYK6C/iP+FXppL/GVxz8ZX88zYWbUNYwaMLk9PmhU9WcmO4Rtap+wCXNhgo4XJcJ/oaiGL3yIc0Gl3RDwDzNBdBJrjSxOo9O8tRCcBQcL4kKMuFHR/mUgHuZJu7RKg7/bZ1vbceR+Jivq9fCPcTHMM8xxHrxNSZUtn9echkegOJmyktuYM2npqwQg3+MvXlWtbj+zBR8J2E8pHaZco6Yo0CCn2q92g3P2nl/69bONOl2dHPGiEY/d5YgVgk+bPkSXOIUGBPbCSYLzaulqcnuXRxfixDYpbaO4X3V75/Xon0SPU1+pksGJT8ZVYV+cEfFWf45upHe4+Ri3ZpK1kKcEHn5fQ80fV3vDrpuPUFS4an/e/8l6eVFWtTqKSacmXdagnkS+9njpd4IpyzeYw+wlwIEA5wkWWpU0mt/dYEqWA6QqFmqF/Fle00VpEoX7T3jSwl0MFtQTF+JvHhO2lnldNKLGH6VKLXiHoaSifhh5JfBbXQsntCCsM+yUaZ+w9ot2MFsnFCzX0a5I322IWpZxYChBoi4/asXnK/UtGxs82rXaEgDU3kB87dQaEwuMd3mR6mAORqnacveJJFkcsm29U+nQH9cx/VS+czMU3OoANWDl0G6iIn9ly801ylX9i4
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(39860400002)(366004)(346002)(396003)(376002)(451199015)(36756003)(31686004)(86362001)(83380400001)(8676002)(31696002)(54906003)(41300700001)(66946007)(4326008)(66556008)(66476007)(38100700002)(53546011)(478600001)(6486002)(186003)(6506007)(26005)(6666004)(2906002)(8936002)(5660300002)(316002)(6862004)(37006003)(2616005)(6512007)(9686003)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bUMydnd3b21VMkJlNTRiOGxvb2NPN1hGYzh0OEZXdCtYQTdTdGFLdS9EL3NV?=
 =?utf-8?B?Y0x6VDRQYnc2bUlxMU5IcTkrTjhEenJRdnZFMjQxaXhUd3lpZ2FsTmpVQkxJ?=
 =?utf-8?B?T0pmWHY2WkV5QUcyMVNyYnErdVhRemdEamVPcUdsbkxZazFTQzB4d0VZSE5R?=
 =?utf-8?B?R0dIdytYOW5RSnRaQWtYU2ZpVlY1b2VtWVBzNWg0WkJ1RUZhSnRleXF3TGUw?=
 =?utf-8?B?cEN0UFNDc1ZCS29iR3paem8zMWVoKzhLeXo3a1RoeXE1UVQ0WHFSVDV4eldN?=
 =?utf-8?B?QTlJQmU2SkpRek1tVWRWTTdMK3dheUV6TjBqSFIxTXJSMy85SHBTM3ZUWmd2?=
 =?utf-8?B?emdkVXhrM2FOeVpIVTYvR2xoOHNvWFhSMTJFL3E0YzNkeHVDY2NxYXREUVVP?=
 =?utf-8?B?dHhrMjkyOEJRdzBtMHZkZGEvVkM4L2krZXhRdHRBa0JTeDJ2QTZGd1F2bHcw?=
 =?utf-8?B?TXNxckxncEg0Z3B6TUdaUXFrRVR6emF4VWdDVmxJaEwwbGp2eFRwdGdSUnlP?=
 =?utf-8?B?VThpT2RjdWpkRFBDeXdZUkVHTXg2S0VONlhKc2xlRk52emtkTEl2Z21HeEQr?=
 =?utf-8?B?cHZrZVBjWW1VUE8wUlBZVnhmQkpsbmVFamNOc1hvVHB5YUcrdS9XTU1UaGlt?=
 =?utf-8?B?b0Z3OC9JVmc3ZkY4VFJWY1RjODhCMUFkL2lTcjlRWGFZZjBuZ21TdlRwMTdX?=
 =?utf-8?B?bzg1cGhpNkprWk9GVUw3Y0VzR05kWnY4N1JmVHBlanh0cEY0Y3dlWVh2KytU?=
 =?utf-8?B?aUV3NmJUaGpMcStWNFJpSFgrdm1FWjJVcHczdFlaSnByeVIzQ3VPak4wcWlt?=
 =?utf-8?B?ZjYyWkRVQ1pneXRkWUtWZW91WVZCR2M1RDBiUUt5dG0vVmt2MDRzTHJ4Vk1r?=
 =?utf-8?B?Z0FIT2JjN0JKZTljMjZwN2RORmdBMDgwMHllSWp6YXNkS0NnSDNMNVl5Um1X?=
 =?utf-8?B?bHF3RjREa1IvRnJIS3ZXbE9qZDBsOEVEWDFtcEhEVm9KL09KU01oR2dZWlpX?=
 =?utf-8?B?YnI3WHZKTjZEYjd4bXB2WFRGNjlhMjdUWW1BRzZjb3ZvT0lkL2tHZVdCWmhn?=
 =?utf-8?B?YUJxbEIvSGVKRVdldWNJdzUwUTRPYkZPWjZQR0NjcncxOWw0WnlTb1JVRlBC?=
 =?utf-8?B?UjVaMGI4L2xlWlZ6Q1dWcUlVOVFkOU9YeDViR1BsN3NrZjQ1UkU4a2R6ZmFt?=
 =?utf-8?B?UGptR0NnbCtTbVFNK3JYbFZlL01nQW9rWWNoMWgxcmFUV3BJSTNJUGdsRFBF?=
 =?utf-8?B?WHBUMFdTV0pVMzJ4SkpCYlhJNFFSVmQvMXRIT0c3WW9RT2FjUVRNRlZZZEFK?=
 =?utf-8?B?MzFTUk1JUGtCeE9xWEJMN284YS9nd0luUGdqUGVZU1J3eGtXWVJQNEIwS3R4?=
 =?utf-8?B?MENGZXRWbW1OY2UvT0ZMVFc5NzRrZ0hpb2tnazVaZUx0dCtGTCt5ck5TTUU2?=
 =?utf-8?B?L0g5WDhDR3hYQWJJS1VGaFhVdlRwbnFLZkpKSS9EcjZaNjJFck9KSWRHTjB1?=
 =?utf-8?B?NUp5UXlxK0pjdVh1eWdxQUtGdnRQVWVBZUpnbHZQbGQvMG1DYVZqTnVEb0Fv?=
 =?utf-8?B?TmUxV0VyWmtsNENjcUUwRkkrb0JKbCsrTVdRTnBNYTRObm1IdmdMSDdydUhL?=
 =?utf-8?B?K2ZLWUZXTFBwYXhOeW1uNlJWZ2dEamRtR29sUkhLamxoTTh2NFErQXA4OHlO?=
 =?utf-8?B?SnRaeEtGTG1yTk8vVHYvZVpnTG41T2Jlcmt4QjFxaHBsVlpHbUdobWhkbnlo?=
 =?utf-8?B?NlZLcXJXYUNWYjRBdndLZGhjWWh5L2JzcUsvSm04aEJKd0Q0NjBIazd3NVo1?=
 =?utf-8?B?OUo4MDg2YU5DMms2RGpTaUtwd1hYcWVYa3BzSlVabnRld0tudklYdk1rVVdz?=
 =?utf-8?B?MnkvS0w2Nk9sY0dpSCtBSlBRR3Brc2RrQjdTSFNhSmNDWHFhbGpuUUdKK28v?=
 =?utf-8?B?Yzk4bkNKNVArQW1aODhZTThBZlFRVHVRblZyRVpnQnpuSXJpdVdTUWc4WEVL?=
 =?utf-8?B?UGdzZFlQWEpVNU1sbmlIZHFrSW53Nk5xNGs2WEE3MHdqYXhnQlBoNCsxSDJa?=
 =?utf-8?B?VFBuSnFoejVGcnM2aXFjTnp0TUV3dUJydGZ6dDJQb3luUjN5bDA4ZmM1b1hw?=
 =?utf-8?Q?FtHkEu9HuraGeBM428IlSQUHh?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: UE4SYgwI0/VFcu6birloDIfeT7+JJilTeTMf3gsuZBKBVF3gXtKyUI3G84zAf78PQO3wf8hCSunVFBkPDbzpGEOYMfTQRcGK6JyhKFe3lFuzFRWFPUz/MaOhSlUX2UrWu/iNzXC9jGYFHaKYKBO9MnFuhFOU3XNYNN5XbUbEkSkcT67zEfc9un5SEzaPZxqoOQPTLbe28eQttnyq84OKEQzkDjUZ6pHWe0j8XDARRAHe9m078TtFthU7ycxSebHretcpj/pp0Lk2mPDwvBkmJXuNC7Ooos/xHo/LKlYoCm/Vg1WZ+y7JzgqVch82+TnR0voSKKVT/W82KkwW0X6ZmdHlmJF4hDkzIKA2279V4ivumOWv7wlpvHweSKOHcZZBsqr4QMf3ZmlHwrZmTMjIZblmJKWeAW+xfrW37rtDFfF2p/wEhEl3CHbitX0Zs3nAdTM7iA1fHHzuI+Kzj3/FmktgoEB3JpjGnrflJ925Szv2UfYdGCuSMDar1yF6Es0BOlT70eyM9CdwJ44/KdDcuRv5HW7MpFolk4I+J9CihH8Bb2S854cxV8xve8B6FgdiiK370TwhBdBRVrENmu8qNd+7EbXTldS8r9h7ZnY2CriX7L8nO3+T5hrYhHOR5nusm2atZ1HkY5dIoz+x5v6vXMhVNwWwp6NikZ1HhlcCOXkcpUqCfFPHMO+JVOfpOs4uBPXq/W5+yy6n8NhSa1CiF4LGnGvenerPRE1aYNc0nQmNMSJiR2S3Z3hKlubYUV9puZmJqBkWbNu89T28JC3mFHOfxo43G8v1zFDFWx6PedfA8XgI+oF/aSO53wfjhfk1
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93825a95-16fa-4b85-32ce-08daf33b0c01
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2023 18:46:55.8558
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1fFQa0XDX6JB73wXQx/LRoJoxoXIhevyfMd9IM/ytxF9QAYLCLSs3NPRaTTDrfncgjpQs/fwh+g3UpKBajxw1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5383
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-10_07,2023-01-10_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 mlxscore=0
 mlxlogscore=999 suspectscore=0 bulkscore=0 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301100122
X-Proofpoint-ORIG-GUID: b-d7UnLq4WFoZPubTUJUd64mVG_k51YM
X-Proofpoint-GUID: b-d7UnLq4WFoZPubTUJUd64mVG_k51YM
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


On 1/10/23 10:17 AM, Chuck Lever III wrote:
>
>> On Jan 10, 2023, at 12:33 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
>>
>>
>> On 1/10/23 2:30 AM, Jeff Layton wrote:
>>> On Mon, 2023-01-09 at 22:48 -0800, Dai Ngo wrote:
>>>> Currently nfsd4_state_shrinker_worker can be schduled multiple times
>>>> from nfsd4_state_shrinker_count when memory is low. This causes
>>>> the WARN_ON_ONCE in __queue_delayed_work to trigger.
>>>>
>>>> This patch allows only one instance of nfsd4_state_shrinker_worker
>>>> at a time using the nfsd_shrinker_active flag, protected by the
>>>> client_lock.
>>>>
>>>> Replace mod_delayed_work with queue_delayed_work since we
>>>> don't expect to modify the delay of any pending work.
>>>>
>>>> Fixes: 44df6f439a17 ("NFSD: add delegation reaper to react to low memory condition")
>>>> Reported-by: Mike Galbraith <efault@gmx.de>
>>>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>>>> ---
>>>>   fs/nfsd/netns.h     |  1 +
>>>>   fs/nfsd/nfs4state.c | 16 ++++++++++++++--
>>>>   2 files changed, 15 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
>>>> index 8c854ba3285b..801d70926442 100644
>>>> --- a/fs/nfsd/netns.h
>>>> +++ b/fs/nfsd/netns.h
>>>> @@ -196,6 +196,7 @@ struct nfsd_net {
>>>>   	atomic_t		nfsd_courtesy_clients;
>>>>   	struct shrinker		nfsd_client_shrinker;
>>>>   	struct delayed_work	nfsd_shrinker_work;
>>>> +	bool			nfsd_shrinker_active;
>>>>   };
>>>>     /* Simple check to find out if a given net was properly initialized */
>>>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>>>> index ee56c9466304..e00551af6a11 100644
>>>> --- a/fs/nfsd/nfs4state.c
>>>> +++ b/fs/nfsd/nfs4state.c
>>>> @@ -4407,11 +4407,20 @@ nfsd4_state_shrinker_count(struct shrinker *shrink, struct shrink_control *sc)
>>>>   	struct nfsd_net *nn = container_of(shrink,
>>>>   			struct nfsd_net, nfsd_client_shrinker);
>>>>   +	spin_lock(&nn->client_lock);
>>>> +	if (nn->nfsd_shrinker_active) {
>>>> +		spin_unlock(&nn->client_lock);
>>>> +		return 0;
>>>> +	}
>>> Is this extra machinery really necessary? The bool and spinlock don't
>>> seem to be needed. Typically there is no issue with calling
>>> queued_delayed_work when the work is already queued. It just returns
>>> false in that case without doing anything.
>> When there are multiple calls to mod_delayed_work/queue_delayed_work
>> we hit the WARN_ON_ONCE's in __queue_delayed_work and __queue_work if
>> the work is queued but not execute yet.
> The delay argument of zero is interesting. If it's set to a value
> greater than zero, do you still see a problem?

I tried and tried but could not reproduce the problem that Mike
reported. I guess my VMs don't have fast enough cpus to make it
happen.

As Jeff mentioned, delay 0 should be safe and we want to run
the shrinker as soon as possible when memory is low.

-Dai

>
>
>> This problem was reported by Mike. I initially tried with only the
>> bool but that was not enough that was why the spinlock was added.
>> Mike verified that the patch fixed the problem.
>>
>> -Dai
>>
>>>>   	count = atomic_read(&nn->nfsd_courtesy_clients);
>>>>   	if (!count)
>>>>   		count = atomic_long_read(&num_delegations);
>>>> -	if (count)
>>>> -		mod_delayed_work(laundry_wq, &nn->nfsd_shrinker_work, 0);
>>>> +	if (count) {
>>>> +		nn->nfsd_shrinker_active = true;
>>>> +		spin_unlock(&nn->client_lock);
>>>> +		queue_delayed_work(laundry_wq, &nn->nfsd_shrinker_work, 0);
>>>> +	} else
>>>> +		spin_unlock(&nn->client_lock);
>>>>   	return (unsigned long)count;
>>>>   }
>>>>   @@ -6239,6 +6248,9 @@ nfsd4_state_shrinker_worker(struct work_struct *work)
>>>>     	courtesy_client_reaper(nn);
>>>>   	deleg_reaper(nn);
>>>> +	spin_lock(&nn->client_lock);
>>>> +	nn->nfsd_shrinker_active = 0;
>>>> +	spin_unlock(&nn->client_lock);
>>>>   }
>>>>     static inline __be32 nfs4_check_fh(struct svc_fh *fhp, struct nfs4_stid *stp)
> --
> Chuck Lever
>
>
>
