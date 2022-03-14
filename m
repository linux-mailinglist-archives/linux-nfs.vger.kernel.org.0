Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9773D4D867B
	for <lists+linux-nfs@lfdr.de>; Mon, 14 Mar 2022 15:10:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242173AbiCNOL3 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 14 Mar 2022 10:11:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231273AbiCNOL2 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 14 Mar 2022 10:11:28 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB25113E16;
        Mon, 14 Mar 2022 07:10:17 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22ECkWxt006207;
        Mon, 14 Mar 2022 14:10:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=CCuKgf5V5CumlKdQbRWZbZQghSOBX6wKw7HK3MQeCuk=;
 b=v7+y22CH05O4iuPZxxeQaJRPgc7KNT9kMSbbgKfuMUWWOTzSl0HB0jUizBYSvjdNZF76
 l/Lp3kdn4/cHuIpt5anaCXxvCz8ewR8rGIS0WSlHcLOQPPwZSq3d9JCFWL3XsM+ip+Z5
 9VFLsBazeBzjXcdl6JyfPeTDgxTEiWabt0X65TypBb9zRIsbZ49KxAG4zjpuGvfJLk+8
 kJlAAGcdNpF7qKkqTjGiosAzirFo0qdOqPZxL6wSxGnIq/8bX1L2GntkJREAQbolGsmi
 EyF5W8LuBXNCuh5ddjUrXEju/eOLvJrYEQv45gjYUpd6herQFkgD2868Hp+YinRmPoTF 9w== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3et60r891v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Mar 2022 14:10:12 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22EE1Eh1060517;
        Mon, 14 Mar 2022 14:10:11 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2105.outbound.protection.outlook.com [104.47.70.105])
        by userp3020.oracle.com with ESMTP id 3et656sfmd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Mar 2022 14:10:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NydCjiaSUqYq7fNsVtbJH2NhvQwK9X5iFVb3F8pOqAiC/YfRTz/6WiUfoiCDxnkLkTzM1tJ89jmV9jEkxPVDXei7PAacf9YAFpiEbpLltYF5zrZ6mLMkioaT3B+w1fF0HsQKZ7vs/RdQSBIvqKZ369//c8QfbRXj9h2zDfegrd+52iJ6bwpRkQV85eBZ74GDnOE6Byg858s86N/Rilic9LUN56R/WhbUhkkWWnIlErRmQVuwTaBPFxosq9MmNJ5Wkd+auBbVrMjESxcGy2HMPR9CXgg/KeK9aOfWBl3hVfTJImJgmPn+mvfZR3sozfrCmSN7cLGZJu0YFZc1deAm9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CCuKgf5V5CumlKdQbRWZbZQghSOBX6wKw7HK3MQeCuk=;
 b=U/J+uE8P2+SEGPV99mKh+HjqB0QuuuWqTL/aJ3fQTbCSKGJjEZc2O03GohN3xbc1ONfZKBhcqmu+B0YKRNCFTtevGqu3UnFdKVrKZlUYfeUthiL3VAQcST+J4HnmNa5hkLdcenbaeJF+Y8/1uVgaQlD0KSPpEB+vzubgeXNm148AVcAlfc3nIh+1/hqvsCFu71gkKDqWxSIX10D2a8vc5KGR6+L4U2jyhFKWUFZCOw2QQ74/hd9kfJd3sYBqBsElEGqVYHfX9Bo7lj0j+rN2yPOuulJf0/+TyqnwmKdc+a2fehROwivJu0xY1SQ1mJE9ZBexjGp2NrUtqBkL04Yaww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CCuKgf5V5CumlKdQbRWZbZQghSOBX6wKw7HK3MQeCuk=;
 b=r/zw/ZU0cGDxPKsJAYOsfM/AM+0CRGryAxqxEIrC6cBGp6ZPOtJaaAoOa7UQ7Fsw4BjUHsjj1eFOP4Yffg9DEsZmOxs5Wev/EdYy2ubP2t5lXpjmjdpFhihGIkTmiWgS3okVi70oceyZN7PK552cPajT2R2oHBHgl28qFM7UlUo=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by BN6PR10MB1633.namprd10.prod.outlook.com
 (2603:10b6:405:4::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.21; Mon, 14 Mar
 2022 14:10:09 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5%4]) with mapi id 15.20.5061.022; Mon, 14 Mar 2022
 14:10:09 +0000
Date:   Mon, 14 Mar 2022 17:09:58 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Chuck Lever <chuck.lever@oracle.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>
Cc:     Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Subject: [PATCH] NFSD: prevent integer overflow on 32 bit systems
Message-ID: <20220314140958.GE30883@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: ZR0P278CA0152.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:41::10) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4bda70b0-3ab0-4d0a-f2f7-08da05c458f9
X-MS-TrafficTypeDiagnostic: BN6PR10MB1633:EE_
X-Microsoft-Antispam-PRVS: <BN6PR10MB16330A84D5C32862A96DC2CB8E0F9@BN6PR10MB1633.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nC/uoRYsW9uIwdxt8HZt1neQbUEsYskB7UprjpWbpD8DTYaQnueyX3JMF+PODho1K6rLNZamJWG3tXIeajjAIF8kf0f0hJ70ytNRbPUhAJKRqBywXbTkpwTBAVhjp5L9NuorlqsGKUwVw55sgm/j7oAQ9VFwmOR2EDsMmtu+Va/uSjSSgdEfsFT0yATGR4eIYnY70z5vo4nAR8VNabYST+/qrlMQOVeN9UwI/m211a7MDCjMLAV3M9N9s24S1KV8U8ies9UwNE20c9UV5TeU1CR7BZKnwOpyNNSSMzcdcycrPD+cupnkwU5/oSabaM9wdS20d1pu2IFjcdUVv7CjQR3PtDmahSx1iDMARDAgY8DnNB89uPQ1RfNBYrCSdv4qI6UwwqR247dLg8j8edjLJkkRxMnUJJXAPB43zKRxzi/a0E7f9Rmvi239ZGq+IrYgyPvXeWjRrlCssFl43hr0+rTuOtPmPp62E56ZjrH3AzAKvO+zAtKhrFeNbVfD1G4JL94HiWIAoefvUFtfQ77M1aPiWn1c0mKv9U8cAFrbctt5GtO05hmxcGq4O/WKW6CnYbBCvExI+HXwowj6D3zw9ZmkOgZ+lJPeqHVm6U/yBUqbzI80S/V+r/pomn52D3l9QMNiJ3u/iiSPB1V5fTl3Gq00r/OcFuZgalGtWk5BYFnZUzjhWnD42pXkCNhEs9MCOQhlGRLKVPxMsZVh/4YcVw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(54906003)(33656002)(8676002)(38100700002)(33716001)(38350700002)(110136005)(66946007)(4326008)(86362001)(9686003)(6512007)(508600001)(66556008)(66476007)(316002)(6486002)(107886003)(6666004)(8936002)(5660300002)(44832011)(4744005)(52116002)(2906002)(6506007)(26005)(186003)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?thot+54fUZ7eeRSKXMaI0cpd8zlAqmQd3XbC/6GIMvqdHz6cA2gnDbaz6OQt?=
 =?us-ascii?Q?1CFSUVZU+5HdehI7w/FX84JlkpbM94aKCKV82oUiRU1IdOMyqj5d03kQYEV4?=
 =?us-ascii?Q?3eFw2dLxmX5Ro3LmZnAu1lNAwOFpy4hDRFaLixyus43gdZhO8/AgsaavVCCX?=
 =?us-ascii?Q?zwvn212+shZ7a8LIEX1dUuAflFCKyv/wC1zhLi1kaOK7RV26xlx93boLwhiW?=
 =?us-ascii?Q?NeN9mObXIeZPQZ2K1nOFDgiZ/tqyDo2/K8nVMCziyGhlz1NgAT0mUl9Ty71z?=
 =?us-ascii?Q?tOGvegKYdqHwljZGl95vj0Ez5HockL1rlPfjFp3Y3VVDMcFOAE1k+xaVBOO7?=
 =?us-ascii?Q?WAuYdyXa3EmHYi2LIWFkKIZSi3/8I8DHTwEP6ueoTAGpB/4ttImB1cv8TZzR?=
 =?us-ascii?Q?+9PX3lOfCfIizirXaz75/SnBqyjNj2znDRxAfdNuZLNJTT5FSWdKz8xXnhZ1?=
 =?us-ascii?Q?UndzVWcZLcZHYCsXRoXswIy+Qgy9HsZZTFbnGRXlHMNxrPXAGUW4k03wa/+n?=
 =?us-ascii?Q?jYbsfjnKRsL6ZPhPWmuFim8zaODXDOnYYMBtdzcNajYAXrJz3+eRIn9M4FJA?=
 =?us-ascii?Q?RWXK6gydFX2gIjzfUxfdmIIngOKgA/Qe1J5qk/Ubgkl1C6QZ7j3hLKUJlp1c?=
 =?us-ascii?Q?B+03i4n3FOo/PEH/1S7cpu0qwEfdgz2wbHN19IntMBQndw/B1Lx4U+v7MR7m?=
 =?us-ascii?Q?+y1A8YQUttIZcGsaMublJHGhwXtRBi1Y0YEosmsft0ShVAfnPOdHmaqhYzuX?=
 =?us-ascii?Q?TuMbw7d+6DVrG4uEt7H9edSZ5L6WXfsLeihetizjrhQoKyRmmP32Vvkyzk3k?=
 =?us-ascii?Q?6vaZ5i2MuhGJ+8/9tlT3dXYVTzSOiFccJijinxapHSFgzNDAZdM9T97+78zZ?=
 =?us-ascii?Q?zKWiF4zCRUG5Eolq5a7gSqakpbyIKA5k+eUvEejaIaSoF8drXm6kdlCbb4e+?=
 =?us-ascii?Q?Vf1iRRiDJMWvL3IfuiSo6JBymJeXfdKmDpkaMNRp3iEQmqIi7LigjIPM4qoA?=
 =?us-ascii?Q?Q1vs1Fm18VC8lnOhGizI5Mtse+wWm0GwT46ph9xh3jUhZ74rmPysaYMJsniw?=
 =?us-ascii?Q?TTfAMSZGwIAc0Hxoxe612/m18wBf89yB9elEef7gNUnpOlHPoAXPbippy/7B?=
 =?us-ascii?Q?8fjPWqxXKO5ayH4SZdxJiHEpZUG06emxOFe+pKPn/u9w8yegXzvtfkfZxGsN?=
 =?us-ascii?Q?46hkYMMmiAvikdrmcw1/T9pcUd48Xr7VVQniqaWgkilzIkN2umDop/a1cXpI?=
 =?us-ascii?Q?xTILpHUZNYEiveDKjKmq3inQKBEZE6J8hr5vnr7xI0/lClMy4B5S1WCBk3r4?=
 =?us-ascii?Q?boNcKRewogr5MsAw8S4M2rdy6yclhXsLVDP3Zh3Kk+9qPuusOfmPeHZ7Yu/6?=
 =?us-ascii?Q?Pe6x86xCizXiXw1MqaB41er0++Az0XMY27j2Ip6blOhTt8uBH21hp8ICyt6H?=
 =?us-ascii?Q?/i2cMhGs/FYQUFR0UQRgAbiHH7yM1k4ZpqR6DZ2Q1M1faWHLlUrm1A=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bda70b0-3ab0-4d0a-f2f7-08da05c458f9
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2022 14:10:09.2257
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vGVUI4mdrBSvzFi7HSDFPk6oP84IUftR17/ESIWbEpaTjh6TnsRJfep3wVYl+ZpB/4Spz30vC7X2msaWsDFb7vMVC/fU4kpi9BA5g1ooixg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR10MB1633
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10285 signatures=693139
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 malwarescore=0 adultscore=0 bulkscore=0 mlxscore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203140089
X-Proofpoint-GUID: DsTq3SEE1-1iFG7tJGLl01_k1nPuse6j
X-Proofpoint-ORIG-GUID: DsTq3SEE1-1iFG7tJGLl01_k1nPuse6j
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On a 32 bit system, the "len * sizeof(*p)" operation can have an
integer overflow.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
It's hard to pick a Fixes tag for this...  The temptation is to say:
Fixes: 37c88763def8 ("NFSv4; Clean up XDR encoding of type bitmap4")
But there were integer overflows in the code before that as well.

 include/linux/sunrpc/xdr.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/sunrpc/xdr.h b/include/linux/sunrpc/xdr.h
index b519609af1d0..61b92e6b9813 100644
--- a/include/linux/sunrpc/xdr.h
+++ b/include/linux/sunrpc/xdr.h
@@ -731,6 +731,8 @@ xdr_stream_decode_uint32_array(struct xdr_stream *xdr,
 
 	if (unlikely(xdr_stream_decode_u32(xdr, &len) < 0))
 		return -EBADMSG;
+	if (len > ULONG_MAX / sizeof(*p))
+		return -EBADMSG;
 	p = xdr_inline_decode(xdr, len * sizeof(*p));
 	if (unlikely(!p))
 		return -EBADMSG;
-- 
2.20.1

