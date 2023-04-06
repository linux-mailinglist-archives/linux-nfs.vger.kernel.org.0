Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8163B6DA435
	for <lists+linux-nfs@lfdr.de>; Thu,  6 Apr 2023 22:58:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240076AbjDFU6y (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 6 Apr 2023 16:58:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240250AbjDFU6o (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 6 Apr 2023 16:58:44 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F8F09039
        for <linux-nfs@vger.kernel.org>; Thu,  6 Apr 2023 13:58:37 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 336F3nRA004175;
        Thu, 6 Apr 2023 20:58:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=K7/O1oHBP7g9iHNpFw1rXC7v315QABDUeWmlpKdKopI=;
 b=NrD9x013E6m345jTEiqH0h7zyWsB7Don1T0TFhSXQUqzOpvptCWTIxy57o65SwiGo3It
 c8oMxBA2uQbpVrNLMs+a1ivbkx5O5wsf6zlio2E6lFtgFRX2gd2hghsAwFizR44rHsfZ
 nhTDRoehX43DUia429ZyINti5sO0gmn1M6HEFBXJ6/KxBTB0kJ6EZm16JyIm4/AufB6o
 30ePFKQxPzivSDxmE5q7tUZ643OdwtFuPLgujN0GMrV/CCm51rmWiRSfNK25hDW3b9Xm
 JJw8z1ohe1yUf5o/716qEreR7ulKGl1PLAc2U2aEE0s7Y/bCph7lyb+xL8a2CzwR/SpE 5w== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ppb71uyp7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Apr 2023 20:58:30 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 336KteMM036583;
        Thu, 6 Apr 2023 20:58:29 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2103.outbound.protection.outlook.com [104.47.55.103])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ppt3mu0fp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Apr 2023 20:58:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VHdY1IxrSDxYe9KBBKUuCO0SOhj+HTeGTxdkYWopqqG2hECNDPyCs01cnfGcP2QeIwmA535/kqCoJudhiuy5EFxuTTyV/0VcCXDWGil+pr631ykRRI3Ub4bA1HyM1yORlJjZkaGpcNdcVd6jakCQpfO80DUbOCgdJn5Za5x4YlisCkglqG7/od/WJPDHFL+xMux5x/ws8Wm+Gs0yIkIgAQbL6TskB73F8iwOIKTYbD7WWT9iA9H7Og1tM/23HUlXY7XQgJux+dux1vtQFPfqfj6SHEA5awfOJ7yH1FEwjK8vD4ORJuSKCT/HSm6y2Jtty22f4+QoPDk1G+EgzhMO7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K7/O1oHBP7g9iHNpFw1rXC7v315QABDUeWmlpKdKopI=;
 b=P+mYIVz0rFFZ7sgdjlmAw9s9vS3cJ7PNVxGukv1qJbPX303tU48RckoosY6fk6i3Waz37EnTxaexTaIccKzdB+dpqyVtG13akD4ODPR4jut9rmn/q6JDpa8BEe5Pp20LUPvTE2BXsA1Rf0nB1Lgnj+mmZkOPaYHCJmn+nzfgIrApRF6t04iMjIOFgj9kp/nSzyu3BT1YcvH8GqveNyrAS57nMdU/uwm36lAf0sp2SPqGSf2d+enL0AES3dUsHJbhq5He5nFTacJOF+HuDjPAZCHsGRAQj0v10bx+gOf6JHHeklr/0Icdq0XKJ61UnMLW0scaCMNPMuQwEXs5o7I0fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K7/O1oHBP7g9iHNpFw1rXC7v315QABDUeWmlpKdKopI=;
 b=KwyHuh9b82GUYZDtN13go0rhhUnsBm6ibs4O4SvzFT1kwfDDPKDBGXR4kolJhGovjPHCNFCLb6L4VLPWZmKoYo8NE6b1Enc+onJprBdS9RbRd9EotRXpQM3CLQ63JUwOPf1npDBLduQVyHD9pHlNu3ySavFuT90sutXLA92Iyao=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by SN7PR10MB6569.namprd10.prod.outlook.com (2603:10b6:806:2a8::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.33; Thu, 6 Apr
 2023 20:58:12 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::30dd:f82e:6058:a841]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::30dd:f82e:6058:a841%5]) with mapi id 15.20.6254.037; Thu, 6 Apr 2023
 20:58:12 +0000
Message-ID: <4b60c364-2086-c07d-2ed0-f296af90bd30@oracle.com>
Date:   Thu, 6 Apr 2023 13:58:09 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.1
Subject: Re: [PATCH] SUNRPC: remove the maximum number of retries in
 call_bind_status
Content-Language: en-US
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Jeff Layton <jlayton@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Helen Chao <helen.chao@oracle.com>,
        Anna Schumaker <anna@kernel.org>,
        Trond Myklebust <trondmy@hammerspace.com>
References: <1678301132-24496-1-git-send-email-dai.ngo@oracle.com>
 <9D5A190A-333A-4470-8572-CF85EE9A8086@oracle.com>
 <182842b2-3de4-d64b-d729-f4f6c9c576d6@oracle.com>
 <ed870a33-0809-3cfd-2d5a-b97409568b97@oracle.com>
 <64c4e5c4e61962fd828bcbef79db1df6466a875d.camel@kernel.org>
 <f6c0553c49efd9e2f643240aacdea8dd1f728443.camel@kernel.org>
 <07d8f93d-c8f3-5ede-66a3-219eea0fdfe6@oracle.com>
 <F925BB7E-4E1C-48CD-A0C0-A058058E55BD@oracle.com>
From:   dai.ngo@oracle.com
In-Reply-To: <F925BB7E-4E1C-48CD-A0C0-A058058E55BD@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0114.namprd04.prod.outlook.com
 (2603:10b6:806:122::29) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4257:EE_|SN7PR10MB6569:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e405f9d-0777-4c19-1995-08db36e1a27c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u/9bspKAbt+KG2k8Pvvy09/MnPUxCqMV+IygORBWKgSASXc3Uc1lofunlzpU8nArMsZuZcOwOAuyV8aDTCkUf5iaT4VLWXoFIsBDbshhamK4KflMx8ZF5ps27Vi4yOwVB97gpiXs+rJZ/WStH9ijEF9SzoIJt8g3286i7sGjnLzGk7pxWZ+Nh6VfFHyA47uXSHohNC5JPAREdCQK2uNQqKlubal83KCXvvt+wh37VjPJPv22eZQPjTel+ayfX1TXjCcgQVnNNU+QvwfYF5LrU5cPvCxMfP/uhtbLrKzPKX8S4JYm+YpvgOKCL92mn66RJXi8Mop7tOjn4mx6B569+Kr339UAzpbtD0aLujXjNWMN4rCSFkf1KE7dhE/doLlgVnCJQ2Lcxhwppq8xd/7p7/5ijK0naUZ5Aj3WbZXHsCLCPQGBb1kHFzuDKeVrk1VDliIyq43ohz2xysA7kmLVT2OPPRPwBQULBbZd+FhaPes1Fa6l7CzYsmzVzn9Zhs2RxVicZzyxPegZhIzh60qKx3S9CMacyx+WWtVH00tRV/si0UJVuzN3Qm00EyHsBQ7hKMoyRLx6xOHVlJwX70iNLKnmngrv9+u0Axq5XydR2ZgR/tsNLUOHFczwwFsVhU04
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(136003)(376002)(396003)(346002)(39860400002)(451199021)(2906002)(478600001)(186003)(6512007)(2616005)(53546011)(6506007)(36756003)(9686003)(26005)(6666004)(6486002)(83380400001)(38100700002)(6862004)(86362001)(5660300002)(316002)(31696002)(41300700001)(4326008)(8936002)(31686004)(66556008)(66476007)(37006003)(8676002)(66946007)(54906003)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TXpMYkVYa0ZUVlpHd0NJeTRUSzNXTDhjSitUQzlUVWNyVWoyQWU0Rm1pejBv?=
 =?utf-8?B?M1A4WDFzSDd3eGozQkJ4OGhZaFIwcWZnOWtwVjVRZkdad0hqcE5ta0prbU9l?=
 =?utf-8?B?c2RqVm1YMmhjWTQxR1B6cDlGQ1VLWjlNWkFxUFpVNVJTd21EUDJDWXJSaFkv?=
 =?utf-8?B?U3liQ0hwUElqZmUrY1NhcXN6Y1BtTGFmRHdOblgrZDN0NUk0V2dWWnR5aEdW?=
 =?utf-8?B?Q1NIVTc4VlZzeFVKQ09aUG5qU2xidzBxZGtoSnlIQ0FSTjU2Q0hJK0VOdXQr?=
 =?utf-8?B?VE55R3N0SkFvbGNNbDBUbHZqMmNrK252NXY5WDNWc2FEK242bkNQbGEvd3c5?=
 =?utf-8?B?c0QxR010QzJXQ1VuTC9SOVE5UU9oVmFEWktaUy9xd21hcDBZU0krUHRkN1hO?=
 =?utf-8?B?bVhGd2ozRWRxN1IzRmF2b0d2bGovUFI4YWhubDFtZUR6NkVCRm9TK0hQVk1V?=
 =?utf-8?B?T2FzeVp3Q0xjL0pQTVRBWUZVbWdGT3dIMTEzZXJad3Ezb2lXNStEbXZZRGVl?=
 =?utf-8?B?T3hlam5iTFRGcVl5TmtMMmlnL0JGWjVWbkZqODJMeWVIcFIxZUhOYk9BdE5l?=
 =?utf-8?B?aktRZDVUbGs1WU9XbU15UWJNNVgzOElMdXdUd0RuK045QnhJUVU3TzZGREVM?=
 =?utf-8?B?d2txd004OS82bXA5OCtCdTJ5VlQ2aWF1NC9CcGN6KzQwMnVwelBac2ZUY1JB?=
 =?utf-8?B?elVERGZkcWUxZFYvK214N1NqemZiRE9tSS84dTF5eXBCeTBHK0N4eFlOOWJo?=
 =?utf-8?B?YjdDL0lnQXROSG9YSlY0blJwWFhYZGlMNTQ5YU5Ic29sdUlNTDBrN01hcVVW?=
 =?utf-8?B?cExIWXBXaS9Wb1RjTjh1NGZ0aXR1bERoSWliVjNKU3BaZlRjSGl0TUJXaE5w?=
 =?utf-8?B?VWdVeUxrYkQyRjZGNmFoTi9paDZSK2svVmxsRlBueUN1YXhFWlpFMGRVaDhR?=
 =?utf-8?B?emZlSUh6bFB0RHk2VWYvQ1MvYTRHWmh5T0YvZk1LRnRTYTR6S0pjZ1pxYW1M?=
 =?utf-8?B?T2tnUHEvTUxjeWhHVlo3ZTB0VkFnYy92eVBxM0RGNlVneDRVaG5mZEZBVHFo?=
 =?utf-8?B?RHVlWFZWZkVlaUFaWXYrNWxpbmEwZ1NVMXJNMnk4Wk0vS1BxQXQ4dXRVbUFK?=
 =?utf-8?B?SElidTV6M0lDMVdNSnFhTFNLMGJNWlI4cklGSkNpNUp4QjdlL3V6Y3kwOHgr?=
 =?utf-8?B?Um9xLzhHZkw4RHRPdVJVd3JiS2kxWUVENFZKU0ZGZVUzS2F0ekZYczkxM0lV?=
 =?utf-8?B?dzFUVDliQTA3UC95OUE4SmhEeXZCVVF4TVZMQWVVUHpCVkduNGo1VlQrK3o4?=
 =?utf-8?B?cElVQ0UyRGgxODU0Wi9ZemlXbmUvc1l4WUxEWkRVK2M5eUQyeTVRUXg2UkVy?=
 =?utf-8?B?cXBqVHNpelMzSkJKVmhuU1ZIRlJMMHBicXpnNjZEc0hpdVlKUjBQMkpOMXNr?=
 =?utf-8?B?a0pFeDNFTWV5dnlyQlJidFlvbWpaZm1HNTNsUWppSGw4SUZISnAzTXNoUXJY?=
 =?utf-8?B?L09peVNnSXhpWHN3dnFYdVNyUWdkWXZ5bTZtV1AvNHJVM0JpcUh2U1VQVkl3?=
 =?utf-8?B?SUdkY0N4dnVOUFFudkJjUnpDTzJQNmJPMFhWZk1VMHNwWkFYWDNuU0pIaFRi?=
 =?utf-8?B?QUsycWtLWEdReVZsd3JzR2V6ZGk4aVhtWEdCdUhMUVEvVWt4eGxFRlVFVll0?=
 =?utf-8?B?eklvcTFoKzFKeDFtcDFrSWlXenI3TWZvT3pHOWVuNHlSbE5oa2NMbG5ub3d0?=
 =?utf-8?B?Q2w4UFJ6bU81dFRsMmdoS0ZmN1QwVEUxQUUwdjJib2FiRkdBS2ZNU3ozZWkr?=
 =?utf-8?B?b3MwRkszR1hrUVZiZDlRbHhJRks5c1BKTktyRmlLd2ZjZUtaZHRYa1gvdHB6?=
 =?utf-8?B?eEY3UERJY1E3cjkvUGFFT205aHN1R1RxbUpCQ3FhN1VlazFaeGk2L2Z6aytz?=
 =?utf-8?B?enlCRUlWSEx0aU94cUVMSXZMczgxR1Ntc3lLNjZoeFlOOUVrRW5EMzYxQ0dR?=
 =?utf-8?B?cXY3TktSbEhGTE1SZ0RySE93L24zTnhlRkUrSkd2VmpaYi94NWtuR0FacVhC?=
 =?utf-8?B?dGEvSm1ORkhxMWppSnU0Q2dwYnlQdWNKaU44bDFmRVlFQ0ttY25YbkZrM0dL?=
 =?utf-8?Q?rdfdU6EZ0XXuxVkBjkrJAQSqg?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: aOq3SIqaUjhiFiTjJ4tSMoep6Z9HH83QvwrMw3ZdyDBMgggC53r4Ze6MjnUDPse+mSRSTBLi1pXqs0K/Pxj/rMd4eEBt7PKMv4/TFup+8p3+ls3/yBMSGOv+JljczUzRT1uVTaqgFHZYTczKb4ljpYHZlE80XSNy5AeYtzL95hLLscziwYT9po4IXEpwkUNRTNi75osK2jwhqiY4IVemc0iYatj2l9rVXWa6gtZ7svzyTW+feH7FYfVZ0MGNEAfemjNWfRxUzUSouDu/QqxG84fEWUeGbmhXzTETPcVYrKTBT2EVW5dhLXKEhAjSKaT08J/1vICXE4aLHzv6KwoNunSUabmd1CSLZwFd1V9lzkKsC1WWI6R5wFe3T7u0oYmGCKXc6olnZVZHPGCqI0cEkwzNCx/ImPXEkYHjtM+3SEft4VVL2PbYKf8vndNQ0isMH/kMvjib5GBpqRLHCRFs2kLM9ZcZi+qnzyfnr57FaAPXQ/0CzGwNMOBSoQbeejfC47xV1D2KMEOHR6tzujCQ+UYjUal/xbcWimXXOj6bM4NKhtsM0vVtp+1nx9gPq1l8Vz2g9vJEAsOi31Au7Zfx3jsdw27pQdGGdqn7VgWPiW9iz4l8vLDxB2MWgYC6hixvX5jSkS66NvM5CJX+gC2hysjI1nnEiPETV3QfgKeY66i2racL8EEDeiuOAoco/LD3KywzF+nOsKuCzZCdDvj+LmRFdD4r4pB0XE8j37zWleWAlVdNTENk0YLpz6+bgw14uA1wjtTtFSEmOnpCqS72bXC8U72J4HDMUDwW/e9/g70H0DwteXpBhBr2dE9/19DeQM+4UdLHF6VEGHk6twlDJQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e405f9d-0777-4c19-1995-08db36e1a27c
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2023 20:58:12.6969
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0cgaDPYLEhOQgL4mvmxFNZnq0ewqhVm5TdcKstyTalp6qvFmbyAXMU7YSvVS8jvdTBcXcAKP3iG6AaUc01tI3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6569
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-06_12,2023-04-06_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 phishscore=0 bulkscore=0 mlxscore=0 malwarescore=0 mlxlogscore=999
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304060186
X-Proofpoint-ORIG-GUID: gXSt_sexaOXuQ_Nysc7VWLa39nldePQa
X-Proofpoint-GUID: gXSt_sexaOXuQ_Nysc7VWLa39nldePQa
X-Spam-Status: No, score=-3.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


On 4/6/23 12:43 PM, Chuck Lever III wrote:
>
>> On Apr 6, 2023, at 3:36 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
>>
>> Hi Jeff,
>>
>> Thank you for taking a look at the patch.
>>
>> On 4/6/23 11:10 AM, Jeff Layton wrote:
>>> On Thu, 2023-04-06 at 13:33 -0400, Jeff Layton wrote:
>>>> On Tue, 2023-03-14 at 09:19 -0700, dai.ngo@oracle.com wrote:
>>>>> On 3/8/23 11:03 AM, dai.ngo@oracle.com wrote:
>>>>>> On 3/8/23 10:50 AM, Chuck Lever III wrote:
>>>>>>>> On Mar 8, 2023, at 1:45 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
>>>>>>>>
>>>>>>>> Currently call_bind_status places a hard limit of 3 to the number of
>>>>>>>> retries on EACCES error. This limit was done to accommodate the
>>>>>>>> behavior
>>>>>>>> of a buggy server that keeps returning garbage when the NLM daemon is
>>>>>>>> killed on the NFS server. However this change causes problem for other
>>>>>>>> servers that take a little longer than 9 seconds for the port mapper to
>>>>>>>>
>>>>>>>>
>>> Actually, the EACCES error means that the host doesn't have the port
>>> registered.
>> Yes, our SQA team runs stress lock test and restart the NFS server.
>> Sometimes the NFS server starts up and register to the port mapper in
>> time and there is no problem but occasionally it's late coming up causing
>> this EACCES error.
>>
>>>   That could happen if (e.g.) the host had a NFSv3 mount up
>>> with an NLM connection and then crashed and rebooted and didn't remount
>>> it.
>> can you please explain this scenario I don't quite follow it. If the v3
>> client crashed and did not remount the export then how can the client try
>> to access/lock anything on the server? I must have missing something here.
>>
>>>   
>>>>>>>> become ready when the NFS server is restarted.
>>>>>>>>
>>>>>>>> This patch removes this hard coded limit and let the RPC handles
>>>>>>>> the retry according to whether the export is soft or hard mounted.
>>>>>>>>
>>>>>>>> To avoid the hang with buggy server, the client can use soft mount for
>>>>>>>> the export.
>>>>>>>>
>>>>>>>> Fixes: 0b760113a3a1 ("NLM: Don't hang forever on NLM unlock requests")
>>>>>>>> Reported-by: Helen Chao <helen.chao@oracle.com>
>>>>>>>> Tested-by: Helen Chao <helen.chao@oracle.com>
>>>>>>>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>>>>>>> Helen is the royal queen of ^C  ;-)
>>>>>>>
>>>>>>> Did you try ^C on a mount while it waits for a rebind?
>>>>>> She uses a test script that restarts the NFS server while NLM lock test
>>>>>> is running. The failure is random, sometimes it fails and sometimes it
>>>>>> passes depending on when the LOCK/UNLOCK requests come in so I think
>>>>>> it's hard to time it to do the ^C, but I will ask.
>>>>> We did the test with ^C and here is what we found.
>>>>>
>>>>> For synchronous RPC task the signal was delivered to the RPC task and
>>>>> the task exit with -ERESTARTSYS from __rpc_execute as expected.
>>>>>
>>>>> For asynchronous RPC task the process that invokes the RPC task to send
>>>>> the request detected the signal in rpc_wait_for_completion_task and exits
>>>>> with -ERESTARTSYS. However the async RPC was allowed to continue to run
>>>>> to completion. So if the async RPC task was retrying an operation and
>>>>> the NFS server was down, it will retry forever if this is a hard mount
>>>>> or until the NFS server comes back up.
>>>>>
>>>>> The question for the list is should we propagate the signal to the async
>>>>> task via rpc_signal_task to stop its execution or just leave it alone as is.
>>>>>
>>>>>
>>>> That is a good question.
>> Maybe we should defer the propagation of the signal for later. Chuck has
>> some concern since this can change the existing behavior of async task
>> for other v4 operations.
>>
>>>> I like the patch overall, as it gets rid of a special one-off retry
>>>> counter, but I too share some concerns about retrying indefinitely when
>>>> an server goes missing.
>>>>
>>>> Propagating a signal seems like the right thing to do. Looks like
>>>> rpcb_getport_done would also need to grow a check for RPC_SIGNALLED ?
>>>>
>>>> It sounds pretty straightforward otherwise.
>>> Erm, except that some of these xprts are in the context of the server.
>>>
>>> For instance: server-side lockd sometimes has to send messages to the
>>> clients (e.g. GRANTED callbacks). Suppose we're trying to send a message
>>> to the client, but it has crashed and rebooted...or maybe the client's
>>> address got handed to another host that isn't doing NFS at all so the
>>> NLM service will never come back.
>>>
>>> This will mean that those RPCs will retry forever now in this situation.
>>> I'm not sure that's what we want. Maybe we need some way to distinguish
>>> between "user-driven" RPCs and those that aren't?
>>>
>>> As a simpler workaround, would it work to just increase the number of
>>> retries here? There's nothing magical about 3 tries. ISTM that having it
>>> retry enough times to cover at least a minute or two would be
>>> acceptable.
>> I'm happy with the simple workaround by just increasing the number of
>> retries. This would fix the immediate problem that we're facing without
>> potential of breaking things in other areas. If you agree then I will
>> prepare the simpler patch for this.
> A longer retry period is a short-term solution. I can get behind
> that as long as the patch description makes clear some of the
> concerns that have been brought up in this email thread.

Thank you Chuck, will do.

-Dai

>
>
> --
> Chuck Lever
>
>
