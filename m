Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D7B7742A6F
	for <lists+linux-nfs@lfdr.de>; Thu, 29 Jun 2023 18:16:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232244AbjF2QQZ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 29 Jun 2023 12:16:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232138AbjF2QQY (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 29 Jun 2023 12:16:24 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA78310E5
        for <linux-nfs@vger.kernel.org>; Thu, 29 Jun 2023 09:16:23 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35TE7bV1023768;
        Thu, 29 Jun 2023 16:16:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=rtun0vvwaU2Hz+kYBvhrjhnLZOyvx4/40k3cGTNOMW8=;
 b=bUXE90wiWrJdf+3iXFMP8P3dh89raPoHr3+nwbY+w4vrtI2qCNhEFSXIGRNSH4M9nCNA
 8t9y2yiUMJ4eZ8ZzxCaLr+fCECrBRe1fvcw/BOnbnOPE0kowVgV2K7Bnv9I8K2/IiH/y
 CHeEVaR4Y9BNumv+e7ZHmLdaihQBwMfcqD1fNHRpsEhi08bjpzYz718QGRxCyW3O8Tql
 JY1sZr5a09U26SV5Oc9tfhuO6F1GIAumjP+w5AOCXhFMw19n+19LnZjqHls4SZt8ze++
 AOIB2LWqGirj7Q0vi+AMQiPLr+Uvku4ep7OLnAw4fF3QqAFZ77VM53sINguL/ZljFgcA +g== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rdrcackfq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Jun 2023 16:16:21 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35TG1M1G029633;
        Thu, 29 Jun 2023 16:16:20 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2049.outbound.protection.outlook.com [104.47.66.49])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3rdpx7kwue-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Jun 2023 16:16:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RR0NZalPe+AclqMFSUb1Dme1UtZExK1manbNrPlUtC4lRrNJIj6FNwYHVwaH/GZClOKd5imKv2vPfkX0er8hXxIq+MPNzwZAXna7rOJwj6mPu0ly42tM8idSjNHgz+Bqx2JwhCXBNCONIadXV0O3kJ9u+OX4MgujcQrzI2JWnPHpg9A1VLNsB8tqFIbVHwOof4WudPwpcg8NklYNF+8D/vNRsItuPK1kbAJfp5sv7s5GTzJEDTFE8BKkvZJA+A19OzJzbP0bXtJymD1sQuT5Cl1d64QqYZBZiN5HWhHVJb2NEZ36HnbjncX51C5UdfLCxhG5ziVqejq1ldl2YaDI7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rtun0vvwaU2Hz+kYBvhrjhnLZOyvx4/40k3cGTNOMW8=;
 b=c1BAb4LanKnTXCZL4GyTaHGKW0Z2i0ZQm4EbZD/atqlwv9L7J/m+GYvSaJKd6JVsEv8SZlOgfrZVzK5YNw5RsAyJ5aMHbk+SAAUucqrUKT6vpD2ZWIuVaGv5G2TdoJInNMfHkjHzAR6HjIW/meeBoh0M/O1y4TpGUqt5hVruHTuXjPZk+dufkqLMeAj2LL4Ct7vgE15avsOkzPNeMGf5biO+JnzbZr+dxJ5O0BJTG88fcRPhdIhmb5MrGSIPn5NIlSGxP4kJwNiCZB6y8ymzK/Q/C1KLD4UAZOtfpLgtxiiJSrIa0yMKNIywmGdXINrLx1KwiTGDof2w9oIqNzr0sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rtun0vvwaU2Hz+kYBvhrjhnLZOyvx4/40k3cGTNOMW8=;
 b=fqflKQJZyxZ8/MMglhX80q4WQTXzMOlkK2Dbs65kxNMMqd60DOaPsNxboMjjcGP1lvVK3TCbEDoHS0DHvYGqJd8dIdqq5km65ScRDHGSJr4IzqJ2yW5lKAkYsOnQnKsjYbHCfNGckH82xr4AfBMJsZnk+0oZu9LpwcjUaItcO+w=
Received: from MN2PR10MB4270.namprd10.prod.outlook.com (2603:10b6:208:1d6::21)
 by MW4PR10MB6632.namprd10.prod.outlook.com (2603:10b6:303:227::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Thu, 29 Jun
 2023 16:16:18 +0000
Received: from MN2PR10MB4270.namprd10.prod.outlook.com
 ([fe80::1b0f:fad9:3eb1:95e8]) by MN2PR10MB4270.namprd10.prod.outlook.com
 ([fe80::1b0f:fad9:3eb1:95e8%7]) with mapi id 15.20.6521.024; Thu, 29 Jun 2023
 16:16:18 +0000
Message-ID: <4da00a75-e291-17c5-ef35-e3d9771a83ce@oracle.com>
Date:   Thu, 29 Jun 2023 09:16:14 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.2
Subject: Re: [PATCH v6 5/5] NFSD: add counter for write delegation recall due
 to conflict GETATTR
Content-Language: en-US
To:     Chuck Lever <cel@kernel.org>
Cc:     chuck.lever@oracle.com, jlayton@kernel.org,
        linux-nfs@vger.kernel.org
References: <1688006176-32597-1-git-send-email-dai.ngo@oracle.com>
 <1688006176-32597-6-git-send-email-dai.ngo@oracle.com>
 <ZJ2eRbqyeFxTIamR@manet.1015granger.net>
From:   dai.ngo@oracle.com
In-Reply-To: <ZJ2eRbqyeFxTIamR@manet.1015granger.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0354.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::29) To MN2PR10MB4270.namprd10.prod.outlook.com
 (2603:10b6:208:1d6::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4270:EE_|MW4PR10MB6632:EE_
X-MS-Office365-Filtering-Correlation-Id: 40f57966-a183-4369-47a3-08db78bc2b82
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UyalSUycgJ3cHmZn+6K5mRRDUHLlh6mLJYfJXWnzE3bqotSm83yak3nRqV6hqDgxba1iGg7MthQ2/41Eam7jL40oaUXJ1rulri8njMVL7RyEWLBxDZSw21apWUZbpmKeEZodfxbo6pruPl+1S2r9tbt8unjnsRIgFyrL7p0MNRj+2penuPksHXtXklHKxAwnafgLdRdWSG3YxzjgfaFZXkYH5CcOz0BgbCd581zbqlP8CJfO+PMKSab9WzEZtS3yNzffWnGRMoULhnHCP6224FpFlQTVsJIl0vjIBwuDsM+HZ01ez+aPONMsl1NtdENoYI3wm6Gq7yglZ7f11V556ug3Bm+HMMbMrWFBdGi10N2est5E8lktOvwgkfCfQzJ9f1HFxJDWpxv7HBBJKhBqwzU7QTeFz5vkDF3tiTzlszMvZOnhhsV0OBmg69MT92ZaFyKiet26J+MfBJoI1SMujGJqk6LuQAuYkL414mydS/7LeFBUEPbwjEzLs9VnK5/L2JQQ1AokL3F2v5XBVOSJfH2gGNvGJjkGHN0xihY5xZfyRliYH0V1XCtlT9mYg8TkB8FQicO4ZUyLBIrvBqP+94IztOeoZ0+fzSa3PgCZDQVozSnW5tHUPiWjIgCAwSC4
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4270.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(366004)(136003)(376002)(39860400002)(346002)(451199021)(2906002)(8936002)(8676002)(6506007)(316002)(53546011)(66946007)(4326008)(66476007)(66556008)(6916009)(31686004)(41300700001)(6512007)(9686003)(186003)(26005)(6486002)(86362001)(38100700002)(31696002)(83380400001)(6666004)(2616005)(5660300002)(478600001)(36756003)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZkZmUndmOVA4MUxoQlR0NDdQQ0lTL1ZvTzBSVWNnNEc2blBibU5ZNUhEb0FK?=
 =?utf-8?B?RE44MkFQakNpRTFuL1A2b09RSlNHN0NNNlg1a0VFV29YeXQ3WEt5ZEFaNEZS?=
 =?utf-8?B?YmJPWjIzemllR1c2WG1IVlRESXlDa2IxNW0xQ0ZIaDF3NFB5UDl0c0xjSE0v?=
 =?utf-8?B?ZFhnODdNWVJjZXFiODJvSkpKWjVBcW91a2N2WlgwUjhqUjcyTGxsQWVaWHIz?=
 =?utf-8?B?QTJWL3BJeGNEUFdkaHNXdTJ2NEtkcXdHQzZOYU9ocEhBTnZwLzExa3dYUTZU?=
 =?utf-8?B?eEVoNGZYM05TbS9qb05YeHFCZHlYQjVTWVNqR2swR0MxNjBsSFpvSUNSay9s?=
 =?utf-8?B?bjQ2bVRia2RQbHB5Y2JYeDFoYlB4L0tvcDJLTUpmMzVWSGs1VHZpRlpiSkVQ?=
 =?utf-8?B?QWo3WXJlMk40RURVRVF6UzlVMVdvcjZWUW9nTXdlVEhwMCtBcG93TDM0QWNJ?=
 =?utf-8?B?WWpFaEx0TUVtNzNjMXhGQkJWMjdINHBkQTNZeVhFaG9IQXZFVW9ZSEIxNHdU?=
 =?utf-8?B?SzAvcHRVSmdQZ29pY3NYYlY2czRpWnd0b0MrZ1BScjQrUDRYS01ZdjhYSjVG?=
 =?utf-8?B?dDc3bGR4NFdmZ2hrcnl6MVVFSm9WODg2SDk5dzBKRkNDMUdKQko1YUQ2dmxx?=
 =?utf-8?B?Q2JyOW53WEo3U2xtUld0T0hWYWZVSWlhRjJuNWhyVnNBTEZlVGJ5TEEvVEhO?=
 =?utf-8?B?OVBYUTVEcTR2WEJlZ0YzR1ZjdTJKVUcrZ1Z6eU9CZjdkemp4ZnQ3OGZlNUJS?=
 =?utf-8?B?a1NJT0VVc3hqUjkzVVEvbmxxNmtSR2toS2Jubmx6NmFncjM5N2huTzFoWEky?=
 =?utf-8?B?d3hnVFA2bFpZb0t4RGZaYi9yYVM3Y3JmQnRHS3pKNjYvSTc4TWU1cnhZYmw5?=
 =?utf-8?B?NkxaNDFyRDk5WEJFejA4dmNXZVlMWWp4RDUwbnlrU0huQzV1c1NzUnBuZmUz?=
 =?utf-8?B?YXg5cENoSVEzamd3ZEhpWGR0WDhUWEIzMnZ1OWVPREZPZFh0S1ovMXcxVmJM?=
 =?utf-8?B?cEx3MTU1dWtBcmg0REEwbURPNTVnRDNQNzA2bDk2VFZQV1ZTRURTdm9razg0?=
 =?utf-8?B?M3YvczR0cy9QSGM3SGx1SnlOV3hsRzFhb1JhUHJtUjNyNHpNWm45bGJQNldn?=
 =?utf-8?B?cnJQNjdxSlF6RTRxb2N3OUE3Z1ptNFNhMHdDK09ucGR5R1RweE5zUnQrVytE?=
 =?utf-8?B?RFNYNWhSS3hJWjlwRzdlcjQzQ2RWMXFSNzRwSmYxUEZOSXB6T1ExM3FSeFBm?=
 =?utf-8?B?YUd2TG9ucngwblF1NUJKZjNFMEVpMzJFYSthNjNzUW45QXl6N2RpZDlmY0RT?=
 =?utf-8?B?Mnc2VEhtMHgxQXo5VTh6YnlIS2d6RGZnT1JnVVgzdUQ3b1JjNjk3ZmpwM2VX?=
 =?utf-8?B?TXBSSk1wU0pFZUNsbW03R2hkTmhYZjR6RzlNdkoxRlpjaWNRWmwzaENBc3Fq?=
 =?utf-8?B?ZktFNkF0cS9nUk9meVVqanlDTE56dXpWS2t1R0RtdFdHOStXcW5MdmtTVlVa?=
 =?utf-8?B?OHFjeTh6eXJoMFVyM20vTC9SdkhaaUhBQmdHRE85OGNBaTNQWTMvWGlCVHpH?=
 =?utf-8?B?OXJSYW5CTUdna0J3N1V1bllTUzY0SGhORXgwYUV5ZnFGVDg2d09MeS80dEIr?=
 =?utf-8?B?b1dZLy80QnM5OVRvSkt2Nm42RUNSbzVhUjdvbFJnVWVkbTN3QlRyNitWK2tM?=
 =?utf-8?B?aEJJU05RL3FFeE5vSjR1Y015YWpIbzdLaTN6QzZuTTFHY1d0SW8vSnFMUzdq?=
 =?utf-8?B?WDBlRm8yOU12TmJzRzZORktuOENLMHFqbGZQdUFnS2U3MUhoVjdPcG5Gd2Q2?=
 =?utf-8?B?QWtyN3ZiYzlDYUlUdFJBaTA1MW9qOXJMM2Y5SFFob2llQW92azNraVNWZ0xn?=
 =?utf-8?B?UWNocWRRWGVXZkRZM3dEekFyOUQzb0hEL1c0YkdQMVkyUENndk1NL1gyTHRR?=
 =?utf-8?B?QmNOSkI1UVZ6d1Q4VXI5N1loSW8wZGZzM0pqVkVnTWFodmpsc0VnaTF4UUVv?=
 =?utf-8?B?L3BVQ2M2a2NmLzN1WHBQMTlaNVNXWkRCeUd0TGtHcnBmWEZGdW9MbnZGL1pX?=
 =?utf-8?B?VStOdjk1ekZ3ZTlIdlBwODhVWWJ2K09hb3ZtU1NiTEw2anZIVGErSGQvWFV0?=
 =?utf-8?Q?yu/MPmDXwLYG/lm9222wbeuNQ?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ipL7jlLmeSYO0tC0Uncu2/h3gL8SHVs7MPABTEeLpebdEYi5EVs/QK755oxulmWfqddQUIHyCKE71rvivj8YO86RvcEdVUFKezwfJiKdr2XpiFzZ+BNcdaFItDPc/4GbVy5Tqn1Iqzl2zCQvfLrcV5Eh3qfYsL9aqjBjEgTrUYR6HubncHXd2qBMS7rbuVA6y5rJsx9vFOzeePV3rZvuKa5WikilFjgj+zxpk4K9t19yzwCDBtCdBcbr/mUHdzx+nvzHSoNanpWQjdttof9ayNMBntMTDNObqrZdWqqlIGyBp80Q0UyBsZ/YssEGXRNHaffWo37MU9FrUsSYWgBtxbJyyVbq7GsslCfi0frqudE99kg4BI5Y4uOWo+I5tHM+ApoAq1J2llqaub7NujGYcu0bSaa41FmZRrTAWzCDwt0kiZ63tXM9BzXOzY0ANawKiUxwhQue51pQsNathbeq81HsisSAmDiihcziK+YpeFhIFO4W94xjR9MZUE/eMU52tLOepS875pSKAqhhI/A0xlkC4t9hdB6QwwIBchugk+YmPK2bT0iOhYT13SOEOEyhJERGxorWUPRnpt3pDBvHaIDPcJCMz/R2D5BzHv4wXcyw/mWLOXlge0E258zIXko1Ps9idN9WXITx20jNn1MTLX8wzHpJ1ZKoCTP0pu2mg/JGKILis9bVIafKB4J7EkQuBytFkovyjzNi7Hr3U36kJjorKFlJVHQd3mta8iYMXhsTuAXm9Kc/aJLdlxdE+n6KycSYN7U35ZVZV/qzQVnXuy3Tw3oLLq4wjnI4bUQucM4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40f57966-a183-4369-47a3-08db78bc2b82
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4270.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2023 16:16:18.4798
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IKstPUsyou0vTWi9+r8ocPGanCOkC1C/JxUWYzEXFdz+MZZQeKXwtHh6l6iBsJjbljraFGCN/nbReC0Fe9f/LA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6632
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-29_03,2023-06-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 malwarescore=0 adultscore=0 mlxlogscore=999 phishscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306290147
X-Proofpoint-ORIG-GUID: muN0H7GR4XyszAgESTJ7Ej60l-c_0Cez
X-Proofpoint-GUID: muN0H7GR4XyszAgESTJ7Ej60l-c_0Cez
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


On 6/29/23 8:07 AM, Chuck Lever wrote:
> On Wed, Jun 28, 2023 at 07:36:16PM -0700, Dai Ngo wrote:
>> Add counter to keep track of how many times write delegations are
>> recalled due to conflict with GETATTR.
> Should this wee patch be squashed into 3/5 ?

Yes, will squash this into 3/5.

>
> The patch description ought to explain /why/ we want to track
> GETATTR conflicts. (even if you squash it into 3/5). Mostly I'm
> trying to get the important design choices written down so we
> can remember them in a year or two.

will do.

-Dai

>
>
>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>> ---
>>   fs/nfsd/nfs4state.c | 1 +
>>   fs/nfsd/stats.c     | 2 ++
>>   fs/nfsd/stats.h     | 7 +++++++
>>   3 files changed, 10 insertions(+)
>>
>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>> index 2d2656c41ffb..6ce95e738359 100644
>> --- a/fs/nfsd/nfs4state.c
>> +++ b/fs/nfsd/nfs4state.c
>> @@ -8410,6 +8410,7 @@ nfsd4_deleg_getattr_conflict(struct svc_rqst *rqstp, struct inode *inode)
>>   			}
>>   break_lease:
>>   			spin_unlock(&ctx->flc_lock);
>> +			nfsd_stats_wdeleg_getattr_inc();
>>   			status = nfserrno(nfsd_open_break_lease(inode, NFSD_MAY_READ));
>>   			if (status != nfserr_jukebox ||
>>   					!nfsd_wait_for_delegreturn(rqstp, inode))
>> diff --git a/fs/nfsd/stats.c b/fs/nfsd/stats.c
>> index 777e24e5da33..63797635e1c3 100644
>> --- a/fs/nfsd/stats.c
>> +++ b/fs/nfsd/stats.c
>> @@ -65,6 +65,8 @@ static int nfsd_show(struct seq_file *seq, void *v)
>>   		seq_printf(seq, " %lld",
>>   			   percpu_counter_sum_positive(&nfsdstats.counter[NFSD_STATS_NFS4_OP(i)]));
>>   	}
>> +	seq_printf(seq, "\nwdeleg_getattr %lld",
>> +		percpu_counter_sum_positive(&nfsdstats.counter[NFSD_STATS_WDELEG_GETATTR]));
>>   
>>   	seq_putc(seq, '\n');
>>   #endif
>> diff --git a/fs/nfsd/stats.h b/fs/nfsd/stats.h
>> index 9b43dc3d9991..cf5524e7ca06 100644
>> --- a/fs/nfsd/stats.h
>> +++ b/fs/nfsd/stats.h
>> @@ -22,6 +22,7 @@ enum {
>>   	NFSD_STATS_FIRST_NFS4_OP,	/* count of individual nfsv4 operations */
>>   	NFSD_STATS_LAST_NFS4_OP = NFSD_STATS_FIRST_NFS4_OP + LAST_NFS4_OP,
>>   #define NFSD_STATS_NFS4_OP(op)	(NFSD_STATS_FIRST_NFS4_OP + (op))
>> +	NFSD_STATS_WDELEG_GETATTR,	/* count of getattr conflict with wdeleg */
>>   #endif
>>   	NFSD_STATS_COUNTERS_NUM
>>   };
>> @@ -93,4 +94,10 @@ static inline void nfsd_stats_drc_mem_usage_sub(struct nfsd_net *nn, s64 amount)
>>   	percpu_counter_sub(&nn->counter[NFSD_NET_DRC_MEM_USAGE], amount);
>>   }
>>   
>> +#ifdef CONFIG_NFSD_V4
>> +static inline void nfsd_stats_wdeleg_getattr_inc(void)
>> +{
>> +	percpu_counter_inc(&nfsdstats.counter[NFSD_STATS_WDELEG_GETATTR]);
>> +}
>> +#endif
>>   #endif /* _NFSD_STATS_H */
>> -- 
>> 2.39.3
>>
