Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93F77782CDB
	for <lists+linux-nfs@lfdr.de>; Mon, 21 Aug 2023 17:03:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231497AbjHUPDL (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 21 Aug 2023 11:03:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235853AbjHUPDK (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 21 Aug 2023 11:03:10 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1FD6E2
        for <linux-nfs@vger.kernel.org>; Mon, 21 Aug 2023 08:03:08 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37LDxpxj003158;
        Mon, 21 Aug 2023 15:02:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=EVnVBxWnICxeWKR0P+twGRGG85FA+qVrrYR0lZ9/+2Q=;
 b=Tr2vbLxFB5CnMivHuxiRUWtaRhbTNdbzhBR2rj4QSF1mjsLvX1MocfZYzVTf7nIX4l4j
 bZtGORPpeljhGwNUnaFo80hsvwmKVZaX3flWNMdzpaYnlWCyPh0K/go6RiZW2UxajxqC
 jL/W/PTbfQ9vwVEZPpSsGyANEeUhFSqBbIzhijW0xKSX+jCKSh8+5HouL66mfou6WXMK
 fmp1pkOUbQyKffKxepMR7TBFoilgAymYHU9yV3cTLoz+FwmHKLXFQJSE9XGaSudniQVt
 lgTgcOBV8pq9u2c/V/c3mPRdsOwA7dgB7nLBoEUidA7uE1sZzQ6Aj0kBQUtgPhiz/lNq 5A== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sjmnc341g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Aug 2023 15:02:50 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37LF1KW1029780;
        Mon, 21 Aug 2023 15:02:49 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2173.outbound.protection.outlook.com [104.47.57.173])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3sjm6a2cp1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Aug 2023 15:02:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W0w4gDaaAA1pC7tPtItuphDiRAoGAzwA9ZeC7YliAV4ZgqT5QIIGMODOPE5jGQr6+Iuev/wtqF9rTWbER96kjQjhg+Uv31m9k1cYT2sc95m7VV/IAT37CmvI0qSg+JpAr5wV7i6NlgX+or8qk4sEpSa4rmisr3tnxwlYUySDxw9T2iGrGEI0CPsVNoefAUCHj5034BAyY2p4v//rcxchNTxA6hyk16x0ZGP9iMKa3+I31liuEGmWNPX7wPiWULDwJHmNgjjJCRb9Lu7oF+4WI0eXuysZTeuTaDVEwexucGAiPrmpjmSlE37cj3/wC4eo1uUZknSDfdJsMKzqUyUE+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EVnVBxWnICxeWKR0P+twGRGG85FA+qVrrYR0lZ9/+2Q=;
 b=hKiDA4Mp89Y6IQzux2NmAwBQWbKfvhKMSy+EML7k/VXmUoRrKLSU+ML9kgS+R7EH+xqcP0sZZrn2tqZKCnjC+xcYid8uG6r8HpGFUT8PXiRFVeCKc78jPw0wq29wE0L20oTh96wzUFJWvduRWxBwBTNwu5SBliqOgwd2vfEpr1l5BfVCTy0w2xrE6L+IGc52pzDgxjSF0E3ct+K3KxGU9Qp5eS0Yw5uaZ5eqs2mKcBpfDgSSURjYuhi1mswgliWEfLjJJJK42MPzEZA+75NN5SSQ+ZshEP4s2VENsHs6An8QlFHNF6WucU5UrBLjFIN8Y4szL4O24NxP4Byp/C3EDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EVnVBxWnICxeWKR0P+twGRGG85FA+qVrrYR0lZ9/+2Q=;
 b=pMN2JQP1TEcKXYrtfvkPb3rm7wAZXR3FlFskAhM3VaO4+ViWim7th5pbySXi605hty+oSnrAMPOrQOVbz72+Fnxa4W8Ubr0gHm7lR3oQD/x6WxGMwaNsh3GqF7dbE3iolkHcUOquMriu+XcwUgdr35uZ8nQicBm5j2JMnomTmRE=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CYYPR10MB7675.namprd10.prod.outlook.com (2603:10b6:930:b8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Mon, 21 Aug
 2023 15:02:47 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e%6]) with mapi id 15.20.6699.020; Mon, 21 Aug 2023
 15:02:46 +0000
Date:   Mon, 21 Aug 2023 11:02:43 -0400
From:   Chuck Lever <chuck.lever@oracle.com>
To:     Yue Haibing <yuehaibing@huawei.com>
Cc:     jlayton@kernel.org, neilb@suse.de, kolga@netapp.com,
        Dai.Ngo@oracle.com, tom@talpey.com,
        trond.myklebust@hammerspace.com, anna@kernel.org,
        linux-nfs@vger.kernel.org
Subject: Re: [PATCH v2 -next] SUNRPC: Remove unused declarations
Message-ID: <ZON8k6Q/tO+Ayhk4@tissot.1015granger.net>
References: <20230821123346.52056-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230821123346.52056-1-yuehaibing@huawei.com>
X-ClientProxiedBy: CH0PR03CA0373.namprd03.prod.outlook.com
 (2603:10b6:610:119::7) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CYYPR10MB7675:EE_
X-MS-Office365-Filtering-Correlation-Id: d50594c2-9b46-4771-c06b-08dba257adf9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qTnWjqSnZCN3pWcNOm6PfTvnpR8sgpAC8KcTfMB8R/z3A4IYatjRAryPTpiy28seWRpJLheIaSERZTXjOIJ5MZOoXEhzj8DCAEjndmKVx5Zfro1wjofAFi1jxQfgV7qEgHnDz/4vvFGeobMgJ8mYVlaUKEE5vPelH/03ESy27f+fYayZe9EhYTPabU+7ThKZm8lUTY0C6kMfhLsHUOHhMJG7gls6H83/AetHSgcfzxwvg89wRniWO2zBVsyt+MO6HnE5Why8nwaPbGRKMVd0KB3i4crwnBXylCDHigOxvDvwNBPisjLNRtlO/CrK1c1qRiOgREfNW04AYPxaanjlrd2+7zHBf5SLXw+90fad48QCJvIVZK7lDvbFw7fA3oLcYR0g7aZCzf+vwlxaV4UNtgDtDcUpH78JIUgGQCUG8VovcKWzh4nHIdW8llUCG+JoitJUcOuw5loq9O+W+L50nF9G85dDd+4ZeFUqaZlwISUQRcl1yRfqfAsTYYMTfyQZxrYpyi2Lro8+T83JQKkjS3X1esspozOatbxKVHJrsQE0nXBN9Px9QSvN/NvGQzYo
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(39860400002)(376002)(136003)(396003)(451199024)(186009)(1800799009)(2906002)(38100700002)(6506007)(6486002)(83380400001)(5660300002)(44832011)(26005)(86362001)(8676002)(8936002)(4326008)(316002)(9686003)(66946007)(6512007)(6916009)(66556008)(66476007)(478600001)(6666004)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?A7sahx7o1JPwVSnKaDFsta9+lEMgkNgkNCLV9g6NcPnEDNp0bAMAUaynrU1H?=
 =?us-ascii?Q?mdA5VgteYy791MZfeaTHa8hy8P5qSYgR0VZX5kWX6b2moydJKNdt1j/nGZQW?=
 =?us-ascii?Q?KZka7gZ4eEcSI8CkDGOwUJCp505iSH1Hie4GxZdnNVXK84+VpGSSxx77I+BL?=
 =?us-ascii?Q?Iiqsogq4l2gcj1EPGWmfAqAWv8g6qbfsHbRUXktcmYPxBbcwN/7Jcl9sSZaJ?=
 =?us-ascii?Q?rOlQMzTbkRF50iowSMKSMB0pb0qNCxy7zAKaxef1ZiucXfvGGeInSJdG4qIG?=
 =?us-ascii?Q?3CJYiClhSlwAw4I1q09QIyXEpj4Oy0qXp6atMSQy7F5J+K51kbAS1dEzz8FG?=
 =?us-ascii?Q?jaIvtqwWqLZwe8s0usWcLTIaxWW3akaEeUxXFWFOwPkYvp9HlOHd9bUKIp9A?=
 =?us-ascii?Q?8xWhcUwVIMXH6tES3h44in8h/Cq1jYkYLGZa5Dh2U8vMy+KaaIFJFW7YHMjg?=
 =?us-ascii?Q?iHyOVCUM9+pr/rdKzOB/PgR+kos6Ts5adie9L/BeX8WiX88K1CdcbwSoZ6DD?=
 =?us-ascii?Q?ti3xkozw40M35dCafPE4p/eT5i/VuKEb9fPVF7IpQw6QcJo0P4WAfmr24w3M?=
 =?us-ascii?Q?zaCv3nDEzbGa8G1BOn4YzXdjmKVziMOX/E7DyAmKizKX70SVFSi8/wLHFYNC?=
 =?us-ascii?Q?NKTqYoF+iUlVF85+200hYLalwAjZJX8D0u0sMOr9qFWhYpi07ca2bfZkoZPn?=
 =?us-ascii?Q?sY6eb1Q14mjldKN5jYFtemdYAL9ugM5i2ZOdoX3Ycm/iemosxbAZ1MgmLYjZ?=
 =?us-ascii?Q?bJaF/zKIDBUvD1IgUrd3ltrE+Ag02bPz3xRKxXfOVp4gQeqekOKxojI30T9h?=
 =?us-ascii?Q?GrfOVplGZ5QCCAMG6B8CQyUN7421+YnCq1cKceMuX3Qk/e1BAq2zrMHBf1BW?=
 =?us-ascii?Q?A3z5tP0mEip1cTS7rWgY+Iuiyi3XoqcntL5j6k3eHMbwkdiVyKkLVL20XQVv?=
 =?us-ascii?Q?zStPDVGw8eSf05OM6dPfljfoYL18XjRnTgu6MlU32YUIBPUFGrkfHMV+pYey?=
 =?us-ascii?Q?PZgb5qWhC9WpItIujWApQGXS/qTeIP0Ucmx9COVuUcJUce7Y+WregKBwxQ/y?=
 =?us-ascii?Q?0xxu1HqPCSncqXlB7TwfUB+aYZEgJhAHie64Ym3/0CLBsuxFHVMsZyw9+TZW?=
 =?us-ascii?Q?OT3+PAIrNEokh6IdQp4pW3GJPuCuq62w0u2HstFV5ll0lYmS+9nkX6BBBMXQ?=
 =?us-ascii?Q?DsfFVNTlnHPhv3k/Ws+52B4PWHau6FGVnMO7SJKksIQDRLeW8e9oUE1yjma2?=
 =?us-ascii?Q?P870kHfR2aDHlU/epfb5ToowarXuzSUch4ltpmESPfw+LXxotiGl13bBi2UP?=
 =?us-ascii?Q?zZK3VPDq56itXI7WsPNbtPUKxJAEGfSTHwL/3S1YagaJya7DM2AH2CjLpaYP?=
 =?us-ascii?Q?x+NdarwYJ0L+aWTJISJOteQdyq82skCNnL1vDMHURkJ4fpXw+2ZhzdXbJRFO?=
 =?us-ascii?Q?oYw5mYWLy7eCJjiW+JGOWn/ut3P8tbG8Fwur5kp6wgKZBN6xkuIwevOiT8AY?=
 =?us-ascii?Q?vpyHfonDQ6luCPhv0cjgpdTSuiCDFButMbuaArarIKZhZu1ztFQyZfCWZLJ6?=
 =?us-ascii?Q?nPxyUMYvdNEoMG7bnfKiPnMj2gVAp/3rLRHmMGs1xubO8c1LbcSr78ft2oRz?=
 =?us-ascii?Q?RQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?c/6WppOsPwGnUhQPNLQt/nOtUQ0QUffFar4gt6y0QqZi527lVChlOYRCJWKQ?=
 =?us-ascii?Q?FTxr+1osaHXGQWz1Do2HqC65/I6QiOw0J2FvHdIZIU5pxVbFCQa+6WmuMnzH?=
 =?us-ascii?Q?Q885h3rdLQu8e9DL1zutW5IKtu/OoPL30wKIrP+VNkbZB2gnlU//vMN87D9B?=
 =?us-ascii?Q?OJkRa8fv5geeYja9FoQCQHT0HwgyJEKwf4ux8YvxBDnJFwNRwcefQUmG6I2x?=
 =?us-ascii?Q?3nsA76c6qqsF9RPjMQKK/aczqZ2mMmPZQVVqyaIqUXTa+lk8mkl9jcy79He3?=
 =?us-ascii?Q?7I/axlOFzPq4UWeOxQI9O8gFmcBIu+WkUIPMg42gZb2opJVjlsFgHlIWtRKp?=
 =?us-ascii?Q?zU5GSt993y6vEVT0nVYBDGhFa9/GPNxCsMBQl/uoDYpcq7rA2oEDnr3ErWpH?=
 =?us-ascii?Q?uUWAHJtjWRqh511702i3bkRWZ2h6KwLhSAO+l3QRyIqHbfwt6lB3plWSrM5G?=
 =?us-ascii?Q?0Wwa6qm5ETwN2bHk4Lwe013GWHGyjnQoM4Xh+uotDOUPQfMIcFSCXKDsJhhs?=
 =?us-ascii?Q?p/hdr29qneypjiS/fWbnWXJyJEqCv8cL2eEAUbC95E7VWkWK3ZpMJFJOOHyK?=
 =?us-ascii?Q?1nxwWZHr7t6z3/53zELOvNr5IL04JuPSFXD2Y16CzX4KvgOVCvCH2OFnUQ1S?=
 =?us-ascii?Q?i/zPzYwHt/QzafBH5wk4+n/8ZCC7Shdh9O6GvlZLznqQXa13dJqxQRWBlwm7?=
 =?us-ascii?Q?s37ZRSJPLtF14RdlEn1xuCBbNS4OWkRk8IJPtb/AOPO+6nP4WEjF4pdOyf7f?=
 =?us-ascii?Q?G9K+N0VyWTOZVV+FGsTDucnesjjz06VkZD7ENTca7S45FSRqLuvSKEQZ0p2J?=
 =?us-ascii?Q?3BYXNRe1t4MI4iK3W42bK3laT+7+GkGnH6zkPI1qGfhOMgxJXhEMQHG5zQTt?=
 =?us-ascii?Q?hEalQgdDcA7VWzUtl1f0JEZke6M5Ctv9izVdJt8Bpx19v2xZerrvcu9LhQsJ?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d50594c2-9b46-4771-c06b-08dba257adf9
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2023 15:02:46.9077
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 82qBnz8esj1YNWljIyOcXkA8ndA9RTH0mJJVDk8CeJqNJrTzFHl1EecC83ze5ibsfO/uuPqscP8XpZToED+FDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR10MB7675
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-21_03,2023-08-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 suspectscore=0
 bulkscore=0 malwarescore=0 mlxscore=0 adultscore=0 mlxlogscore=929
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308210139
X-Proofpoint-GUID: T4VD8Z4yszoNVKoKmEfThSZhNPKrGOdW
X-Proofpoint-ORIG-GUID: T4VD8Z4yszoNVKoKmEfThSZhNPKrGOdW
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Aug 21, 2023 at 08:33:46PM +0800, Yue Haibing wrote:
> Commit c7d7ec8f043e ("SUNRPC: Remove svc_shutdown_net()") removed svc_close_net()
> implementation but left declaration in place. Remove it.
> Commit 1f11a034cdc4 ("SUNRPC new transport for the NFSv4.1 shared back channel")
> removed svc_sock_create()/svc_sock_destroy() but not the declarations.
> 
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
> ---
> v2: fix commit message
> ---
>  include/linux/sunrpc/svcsock.h | 3 ---
>  1 file changed, 3 deletions(-)

Applied v2 to nfsd-next (for v6.6). Thanks!


> diff --git a/include/linux/sunrpc/svcsock.h b/include/linux/sunrpc/svcsock.h
> index d4a173c5b3be..7c78ec6356b9 100644
> --- a/include/linux/sunrpc/svcsock.h
> +++ b/include/linux/sunrpc/svcsock.h
> @@ -56,7 +56,6 @@ static inline u32 svc_sock_final_rec(struct svc_sock *svsk)
>  /*
>   * Function prototypes.
>   */
> -void		svc_close_net(struct svc_serv *, struct net *);
>  void		svc_recv(struct svc_rqst *rqstp);
>  void		svc_send(struct svc_rqst *rqstp);
>  void		svc_drop(struct svc_rqst *);
> @@ -66,8 +65,6 @@ int		svc_addsock(struct svc_serv *serv, struct net *net,
>  			    const struct cred *cred);
>  void		svc_init_xprt_sock(void);
>  void		svc_cleanup_xprt_sock(void);
> -struct svc_xprt *svc_sock_create(struct svc_serv *serv, int prot);
> -void		svc_sock_destroy(struct svc_xprt *);
>  
>  /*
>   * svc_makesock socket characteristics
> -- 
> 2.34.1
> 

-- 
Chuck Lever
