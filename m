Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADC0F68A103
	for <lists+linux-nfs@lfdr.de>; Fri,  3 Feb 2023 18:57:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231766AbjBCR5t (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 3 Feb 2023 12:57:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231261AbjBCR5s (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 3 Feb 2023 12:57:48 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34FF41F5EB;
        Fri,  3 Feb 2023 09:57:46 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 313HnHZO004706;
        Fri, 3 Feb 2023 17:57:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=ccjDNvtxDPOEDp32Y0PiLiUDN6exBd4LLkMz4R6KnOg=;
 b=MMlIg1UK7nnZefbjDJpXM7fiEl54C+bThBWO6dY2qGp+49WvX21OB/rGW5036J/3tGVm
 uGbwe3/hNl+xYzDwW7MJEE680HHZROrMMIIdpu/Qkv/vVHi3K5uaMXssLit2vjiqfE9w
 +ItSbiUjyturzXfkAGTciWY3QtZCkiK0yushYl7LbMXm+PyMzl+ybWwU9VPD7dbuvp2t
 e7Rk3PhFwZ2m6RDvXKFK/q7chhVBqK5B7RpHxzzhs+dNFPBKT0vOoBI7vjeAjzi11wln
 XM+WTJasUCjaIg0wP++WWa82HN3NrHB28BS/r+kUNT6VhVLwCSoCF/VDpU+V7stshYFg 8A== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nfk64eg9n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 03 Feb 2023 17:57:41 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 313HT8M6004952;
        Fri, 3 Feb 2023 17:57:39 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2108.outbound.protection.outlook.com [104.47.70.108])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3nct5hyncw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 03 Feb 2023 17:57:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ItMXSJa7z7EyHOa1oxOLRS6rWvtrSY30oKe37CMHy6vX/JjcDG/nuM7tu93mj2HN8s9uOEGibUItbeF0XLeiWYpSMQx3x4dU+PaQOIROGrcfiSa9oiM00cRlaW6+LsYKZBJ0MYq/2UUgHSel0sb86IKVzxLlDrWqVxvPJXkH2oaf1gyEg10DI9DJeZIrFKgLuLAgukgbLTdAXRoUP39RuzEIREyv6TF9KxbBE3dZ1p/IddYzdTmzndwCL+V1+nlDYGbpoReP1bXpffAUR+3gJtVJvHBC8OPbRPdrA3/c4vCIde1cvURLBvTli7DIdgpsDp0hw8vL4hm3QZb1V3Un7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ccjDNvtxDPOEDp32Y0PiLiUDN6exBd4LLkMz4R6KnOg=;
 b=YTULqN8p1BBAtlgJJB2kiMJ0CKdgETEJsfpDzxEmL4ZFLBjkb4VvyU7Jfq1d+azft3UvBRB7q4HKYoBOJfr5+6DzpXZM4Fv86rEJfKuGycLkKkcqIitatMcuFiqMv5u+7l5fLClM5B4ZAGRIisLo+zbHMaraF7qRKuiEn0CYcznPcfTEaQsK6pz+K75Yv0Dxcdna/IKTH+UVFb9dFGCaRKoKSSbFCmKqVTx7RSTCkZCEaZ0J+E6mPrs1rKYbeg5wnJQgJTtSsGzFBkuOT6e+U45LVXHA4wVtcWIbn9BLBRBx2Reolc9WKkGsLbsCWPTKOrRSzF2f1wxH7PV5yOJ2Rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ccjDNvtxDPOEDp32Y0PiLiUDN6exBd4LLkMz4R6KnOg=;
 b=pOOfIjmk+9H1+C41zyHdV5CfzrvxfytCDG+2HrS6ozZASL4Kl/5Xg4aZP5QAdSYtrtwh6oymFkNTmcdcVn6ATsnvYluP8dvAAcSqtMj0B7AqV5Zdd4V79ww/NYT41eJBGXn4AIkkSWO7ccl8tJ+MtUnC4jokDtlZ+qx2IzVpMbg=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by IA1PR10MB6051.namprd10.prod.outlook.com (2603:10b6:208:388::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.17; Fri, 3 Feb
 2023 17:57:38 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::2280:b9da:9056:c68b]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::2280:b9da:9056:c68b%4]) with mapi id 15.20.6086.009; Fri, 3 Feb 2023
 17:57:38 +0000
Message-ID: <526a7ea9-f209-16ed-732b-6c105582c18a@oracle.com>
Date:   Fri, 3 Feb 2023 09:57:34 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH] NFSD: fix deny mode logic in nfs4_upgrade_open
Content-Language: en-US
To:     Chuck Lever III <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>
Cc:     Pumpkin <cc85nod@gmail.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20230202073611.13106-1-cc85nod@gmail.com>
 <CBAFB3E5-5737-47A7-8234-3A771E908C4F@oracle.com>
 <7b7edc8bacb863915d00673f9e03d38798341a69.camel@kernel.org>
 <CE064BB1-510B-4268-A92E-8DAC680AAA22@oracle.com>
From:   dai.ngo@oracle.com
In-Reply-To: <CE064BB1-510B-4268-A92E-8DAC680AAA22@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR05CA0037.namprd05.prod.outlook.com
 (2603:10b6:5:335::6) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4257:EE_|IA1PR10MB6051:EE_
X-MS-Office365-Filtering-Correlation-Id: 50360ee7-8e93-4789-aae6-08db061022dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gfsziiSd/sGkbV58llEH7NtlRq/2FDiCqmpxm1wSAZ38Me7BV+2ZkGKJ041i3cKBBWADViEkMWhaBUtfXwnckO8QgYciT57ZHznR/GMMhuS0JeLxkPPyxXFKl8yk7wmxsO9ZJqHO49gJyqEn6h2pNOko0oxc6Y3xTSaP3tRDmZAx6aJhs4KkHAzUoA4X53eR8V0o6/LYS44WabtgWhOb2f5ShYk+bR7f8OZK3bd4OJPdiQ8W9DOQ5VuVrdpE5H3OxYlJpDMUd6caXOTLIlQCRvr9oRlwMoyOvSZKBDbASOz2JBr8hqBPm0sMFeFKNubrgebOULL6WxqezmvDvBOZmPkvryzdkxJi8ZbE674pzLQ3LM6DlacoN9nxS9dRBHzizpYw0+Scj/numDykUKuyIyDr/Qe0G8PsnYHR5tSwx/mbrTDHpu2XCpHse24Ex1t2QmdH3KQjbMigADxyQN32RVshkqNrUiyl0mPDQHbX/ypONp/yXH5JJvsZbpypRcVIHnvDfkOJfvUkEGS06f4bSiNkflSyuASieDw0+TUMtUlMVfPip2VA8u6pShXok3rCw3BMDRHCNmdFHOpmHby3IdNin9Q4A2woCfeCYo2XLli31zlW9Ml0wvM5C8rCF/HGgdN05ZNmbqxXT8TACD67CP6fq1Cx3zynWvZovQ+yN1BpBBA0dvsnWNE30FgyD5idUhctD7FdTStF/KEuzh1ydg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(39860400002)(136003)(396003)(346002)(376002)(451199018)(6506007)(31696002)(86362001)(53546011)(54906003)(41300700001)(4326008)(6666004)(2906002)(66556008)(66476007)(66946007)(8676002)(38100700002)(8936002)(2616005)(316002)(5660300002)(6512007)(36756003)(478600001)(31686004)(186003)(9686003)(26005)(110136005)(6486002)(83380400001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?azI5ZGJhU09JYTNvckUvb2dlRTY5aFZDVjlaZVJxZmZQV1ZFVGlXL2RqT2s0?=
 =?utf-8?B?aEM4K2lyTEsxZWJLckkvKzJyZG1qU2dXcFNwZzRGbStjMjZIUFVJQ05venQx?=
 =?utf-8?B?bWQwWmE0dnE2N3dicTBKM3lqOWVXWU9oYVc3RDE3eXBiQlFiSlpaV3FNKzVx?=
 =?utf-8?B?SDdxRWN4K3FMTmhxa0JsQkNqOVFWQUg1UGYyMmE0OGpxcFJHaWt3U09PMFFn?=
 =?utf-8?B?M09sNGJEU3VUa2VRUmZWenhlTkF6YmxiNGlHNlppdm5lZjFhakhvaXlCTVNk?=
 =?utf-8?B?Qi9SN2habDVxWk91cXh0WVlKRVdwVmJ1QlhtVVZNOUl6ZW5IY2NpN3MvQ0Z3?=
 =?utf-8?B?YTdxdWhFWHJpMlgvYWEycHQ1cHQ1b3dISVJFOHpkOWk4czYyaFZtbUlqVTYz?=
 =?utf-8?B?SUpOWU4vZXh0ME4rcWpTUk1XUHNMNVU1QWg5UGNPenVpOFltckxsT0tHc3U4?=
 =?utf-8?B?MnZQbnN3ajVzV1poazAzeXB1cDdGc0RQcFYxZWZ4bU5DK09rVGRvUUFvdFJK?=
 =?utf-8?B?RnhyWGlsYjlIeC9wZWEyWXFsM01EeXNUcTlNK1EwaE9CZWpFQjM3dG9tMjFh?=
 =?utf-8?B?YTlvdGJvK2swY0NHQ0RUSHc2NytyRkZyKzJ3eGI1S1NkZ0JadzAvV3BoU20r?=
 =?utf-8?B?YVpGUjBLNUVJT2paWmlERXJXTlVvZDV5aHBiRUkzK2pKbUwzTGtnU0k3YnF2?=
 =?utf-8?B?amdZUmFwSGJILzFPL0hQYzZSQnhkei9qV3A4dVVGYXlaTTFXUURvaHE2TlZ0?=
 =?utf-8?B?amFEY0luVVBFYVVnVm9kaUEwMW1TVWRVNlZTcWFlb1F3S1NxaStFVFlkWjI0?=
 =?utf-8?B?VkxmQjRGVW9DZVMvNFdaVEg0aFlxb2RPaE9BcjJqWEdLTGhBOGwzc3E1U1Q0?=
 =?utf-8?B?Wm1Ia0VRUmk4OHpQY2pTNUc0WU5GRFkvUzJGZmYrUGVjc0ZNRk16WGhwSjZn?=
 =?utf-8?B?OXVIRFZJY0VxbmlQWGVFMXMydnQveWlScFhsTmpZWVU0Wi9wNWdLUzh6dXp2?=
 =?utf-8?B?K0tZQ1NDSE5qUTQ5WU1kM2RvdURyeEFPRDFLeFRxWWtxaHhBaWxTVTV6aU1j?=
 =?utf-8?B?OHN5dy94dS8wdWtud2RPcC9JdW9ycjc2cVliSzNXdVAvbGpiUjZqUEoyRnI5?=
 =?utf-8?B?N0ovVFF4bjJ0UlVZaFg2RWEyU0dZY3hyaEdyd3JLeFdsUUZKKzZzQUV2TEJJ?=
 =?utf-8?B?dlRWVWw5eXkyVkhjK3IxZkdLVFRlcEJzSUoxdm40UFhhNDZLN1MyZzdKQ0to?=
 =?utf-8?B?bjdyb0lYU1IvTlRMRkkrMVV1eGUvSnMxOWFrcmxENnROYmwvTXkzSlJVSzk5?=
 =?utf-8?B?bXNXQWtKUjEzdlN5WUhHUjlZY1ZzTnlkbGZVQlREemk3aDg0eS9nZkIyUitK?=
 =?utf-8?B?dVpBZW9VdWxab3dnYkFVTG54M21DV1R4emswNnJKeGV6Qld0Q1BlS2FmZEpD?=
 =?utf-8?B?VFp6Y0VoYmJ1TUhBb3I2YnpzQVdVYnZ0T3pMbzk4ZXRxc1I0b3N3cENJRUxY?=
 =?utf-8?B?aFJ4ZTc3a2NjL1F2N3p5eVcrNUZlMURibzZtdGhzWDdwQ1N6cW45V3VVbVdr?=
 =?utf-8?B?andPQ0w5bTRYRm9tOUdpUE9CTmFmM0ZXcjBzbUJhTmtxSXBPZFpsNmMvNWVF?=
 =?utf-8?B?dE1JUkQzVXV6VDhzZm5yTFNGVFZEZGJHWllobjVtNnpmYXpKT3l1ejhFWkEx?=
 =?utf-8?B?ZTR6NXZRS3QxRFpxelZoallrZ2dHNnRVTHpZRThER09vUi9zN09Uenl3RE1u?=
 =?utf-8?B?MWxHUnRLNlhCc1VqVWsyellDc0QyNGJ1aklFZmR5R2NFQ0RPbUNIbGFodi83?=
 =?utf-8?B?SkpYcUdqcEJCaUNvV05ITXVWZUxVOXUwQnJvREpOMFZrVVpFNloyMDYzdDJC?=
 =?utf-8?B?aEZSRU1XZ3Z0NTUvSjB5MUFackV1SG5ZeFk2WjZOQ2RXSUZ5bXRZMXhQT3h6?=
 =?utf-8?B?b0xJcWljbG83eTZoK1FhTjlqaWhwZFA4VDZJOGdWUTRDR1NLRStyOVRZckdh?=
 =?utf-8?B?SlZCYmlBVjI1MlpvSU95QUNxT3F1MTQzTDRKQ1RPaWpIdGNxZU92dG03TGxO?=
 =?utf-8?B?S1Vndis0VWFjMnhxTW9WRStaeEtYeWo0TWdXamRaSm1ZMFlLakNndWNaOTZn?=
 =?utf-8?Q?cr6V4pue4KAaCR4lR05ygzNLA?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: AGDz7GGNGNQ/c4FTMbaTGPPkFxX0OwqIuEWMqPbpq6uGPWu1gfCDImgUZSS3bfCkKrwJHfFlRLCdmsdhAB48Ptdr9mSRXwVbttxI1FmKOWZ3XmterDEaXN+wgkcgz1fJD6u3Uz4xl87branjl8H2BwMJV8nHV01pAtNcr5mbm2OqKZWfrzeims/8manwpjbau/cgW2g7idHho/h10+S0/SbRh6knuuK6vPFF0GtMnHJxgY9mokev7GMfOh/Y49I/JFNeJWAdxDu4N4X6dNGfaXGxoJ521c6JfR58WCFIHENOfAWTu6o9UFRRjos4OPwo8c7awVVwPU/b66UFT6Iim99cQt7eJv+OS5aVH75+MDF6y+TnUu689IF3942BbOwBvcAQeLayjI9cNVC5OX/HZwgaHFWTzNiD2gogLYCvE+WhvuFhfKtGZy5Fkm0lneeU2D36YgqPnmGDz30tRzmJWGmOMmfqekweO82ae6p7KeToniW4NfP3VjnaNfrsDyeKFt1dX6+ApebwEYGu3/81/vzwPZZ4FEoCyOKWAtqy0LuaSWazgAb9HNVfF8B6C0HrYqRD16wbEY2nZic2s8zrcE/zLOZtLuNvzDC7OclBk3jVO4vahsVRDmZhGhQw/pHmyWs2h+wrF0KEEOWdf28WjXuPn76RHgz94HpopnY6SdFxM/qMvx3M+dhR1l/cQdATvq7+Fj0Ccdr+dci4gxd1zzE8truVzthJgJJjU3nMFSaGf3+LkWalA32dudXuUJ1fq+DQmtFlDXiY2IpZkcmNveiZ659jWk3A6FbuVJXYEEPfVLLxrMMxkx4tNukP/zeL
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50360ee7-8e93-4789-aae6-08db061022dd
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2023 17:57:37.9596
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PAFuF1fYLxnIsIw490ViJUjswnal1NEk5EDaGsR/4Cq6NseW0bEY9MHTVr4mCTOsN2VXcL5IRYCAgzIHh0Q4eg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6051
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-03_17,2023-02-03_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=901 phishscore=0
 malwarescore=0 mlxscore=0 adultscore=0 suspectscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302030164
X-Proofpoint-ORIG-GUID: bdCjdjzO5L6HRZaF3TGdkqCNUTQIAR1j
X-Proofpoint-GUID: bdCjdjzO5L6HRZaF3TGdkqCNUTQIAR1j
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


On 2/3/23 6:50 AM, Chuck Lever III wrote:
>
>> On Feb 2, 2023, at 4:22 PM, Jeff Layton <jlayton@kernel.org> wrote:
>>
>> On Thu, 2023-02-02 at 19:41 +0000, Chuck Lever III wrote:
>>>> On Feb 2, 2023, at 2:36 AM, Pumpkin <cc85nod@gmail.com> wrote:
>>>>
>>>> If the upgrading deny mode is invalid or conflicts with other client, we
>>>> should try to resolve it, but the if-condition makes those error handling
>>>> cannot be executed.
>>>>
>>>> Signed-off-by: Pumpkin <cc85nod@gmail.com>
>>>> ---
>>>> fs/nfsd/nfs4state.c | 2 +-
>>>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>>>> index 4ef529379..ebdfaf0f9 100644
>>>> --- a/fs/nfsd/nfs4state.c
>>>> +++ b/fs/nfsd/nfs4state.c
>>>> @@ -5298,7 +5298,7 @@ nfs4_upgrade_open(struct svc_rqst *rqstp, struct nfs4_file *fp,
>>>> 	/* test and set deny mode */
>>>> 	spin_lock(&fp->fi_lock);
>>>> 	status = nfs4_file_check_deny(fp, open->op_share_deny);
>>>> -	if (status == nfs_ok) {
>>>> +	if (status != nfs_ok) {
>>>> 		if (status != nfserr_share_denied) {
>>> if status == nfs_ok then status will definitely not equal
>>> share_denied. So this check is a bit nonsensical as it stands.
>>>
>>> Usually I prefer "switch (status)" in situations like this
>>> because that avoids this kind of issue and I find it easier
>>> to read quickly.
>>>
>>> Jeff, you are the original author of this function, and
>>> Dai, your commit is the last one to touch this area. Can
>>> you guys have a look? The one-liner looks correct, but I
>>> might be missing something.
>>>
>> Yeah, that code is clearly broken and it looks like it was done in
>> 3d69427151806 (NFSD: add support for share reservation conflict to
>> courteous server).
>>
>> I don't believe that one-liner is correct though. If the result is
>> nfs_ok, then we want to set the deny mode here and that won't happen.
>>
>> Something like this maybe? (completely untested):
>>
>> ---------------8<-------------------
>>
>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>> index c39e43742dd6..af22dfdc6fcc 100644
>> --- a/fs/nfsd/nfs4state.c
>> +++ b/fs/nfsd/nfs4state.c
>> @@ -5282,16 +5282,17 @@ nfs4_upgrade_open(struct svc_rqst *rqstp, struct nfs4_file *fp,
>>         /* test and set deny mode */
>>         spin_lock(&fp->fi_lock);
>>         status = nfs4_file_check_deny(fp, open->op_share_deny);
>> -       if (status == nfs_ok) {
>> -               if (status != nfserr_share_denied) {
>> -                       set_deny(open->op_share_deny, stp);
>> -                       fp->fi_share_deny |=
>> -                               (open->op_share_deny & NFS4_SHARE_DENY_BOTH);
>> -               } else {
>> -                       if (nfs4_resolve_deny_conflicts_locked(fp, false,
>> -                                       stp, open->op_share_deny, false))
>> -                               status = nfserr_jukebox;
>> -               }
>> +       switch (status) {
>> +       case nfs_ok:
>> +               set_deny(open->op_share_deny, stp);
>> +               fp->fi_share_deny |=
>> +                       (open->op_share_deny & NFS4_SHARE_DENY_BOTH);
>> +               break;
>> +       case nfserr_share_denied:
>> +               if (nfs4_resolve_deny_conflicts_locked(fp, false,
>> +                               stp, open->op_share_deny, false))
>> +                       status = nfserr_jukebox;
>> +               break;
>>         }
>>         spin_unlock(&fp->fi_lock);
> Would pynfs have a case or two that could test this?

pynfs has tests for open upgrade and downgrade but it only
tests the upgrade/downgrade functionality without any deny mode
and only from 1 client.

We need a test that does open upgrade/downgrade with share
deny mode and with 2 clients, one is courtesy client. I will
look into creating one.

-Dai

>
> Can you post an official version of this patch with Reported-by
> and Fixes tags?
>
>
> --
> Chuck Lever
>
>
>
