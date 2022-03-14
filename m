Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C99F4D866F
	for <lists+linux-nfs@lfdr.de>; Mon, 14 Mar 2022 15:06:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232054AbiCNOID (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 14 Mar 2022 10:08:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232002AbiCNOIC (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 14 Mar 2022 10:08:02 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43062641B;
        Mon, 14 Mar 2022 07:06:52 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22ECSgN9010718;
        Mon, 14 Mar 2022 14:06:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=hJEIg43ISQ7j/637+3v3JmSpnj4BVXLLP0kOyScCJL4=;
 b=crSpGqprVn2e73PBz/F8J9viWcpx9qa1nVa5yNuHg1mUxOwL/i5mlGxDGPs9jpJRp8R+
 aof/CmtbqZ7G106G7ZJGkAv7iUCfACSeqG9jfGOh9tXqFEq94zBfFPi2ivYDlEUAj6O2
 qNesGpFNW5bcGRhuXmurPLr5OaB3X/pVzCbHzD9TdkR5NaIZ7S9Qv+JIL5Zyl0SxwsbP
 G0kfEo7++KbNQ97LTLUQIXEfITaGav98UaOBNTfXpgpafOV/gMozTD/XYAjyxm7O7az5
 WIbAwCmN6usRz6yb5JlzOgCVhmMUzOhEYiLnnBP+1n1V97mk7APpEZGVhZ86VtizRx1C sw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3et5fu0bbr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Mar 2022 14:06:51 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22EE1XQE132459;
        Mon, 14 Mar 2022 14:06:50 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
        by aserp3020.oracle.com with ESMTP id 3et64j96w0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Mar 2022 14:06:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fewFky9qrDTTk12je0CsGGw2vXEONBqDJzuaWotGb9jOzfRGazy/XgpFo1hyQo8Ype0X7xM4xzVVdLVzd3NbP5FOSklZWDlVRdQ2Doy0+rz+5OZFfMOgWFoPmAc3lA6d+cQITzKTB1+mVa9Z886iZLdYCpLF5F6B+Udh5wIC1utBbTohh3b2cg7p5y1TD8Lc+OsWX3bKoSVd7+5o/qYjxstmQcLMCrSHvY2xTw79BL72PW+e1I+BikuXWSJ7LLn5I8vFlTEBtnyhppsPMXQ0Cm7aWIWYnphY6dI7uwK53vQipwqR2o65H5LdZ/6M26IgqVRzbTprDLjk1M9M6m8BKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hJEIg43ISQ7j/637+3v3JmSpnj4BVXLLP0kOyScCJL4=;
 b=TJHsFABiSnYGKdLq5RWzqcwLMi9RmBxiRZQguNrgk8Z9o9oMW2SmrSvPBOBma5JdesA1osH9lmdXpJIX00AOFuj4oAnAMkU00VNt4MrM7NgagT+o5xwfvoQ/srFw0ChViZrO2tc5L4j6m6V6Nx6VsuYQqwUN3+HeN80Ee/+pZoUeGfAo4o4aZwen6XD3/y0aJjSi4B4UJVC9Dfg7Mk2czIR6s39FdPfdqGSiysB7IzqoFEOPAqjdjyNfxMQYabOgKZF9ibS5j90CclqnEikDrkxI/X+N3yIyPX/v1FyRwr/5DVoj7i3o5lM8WZabdB7Z9P0/2wXUR3GKEdCvEgn/wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hJEIg43ISQ7j/637+3v3JmSpnj4BVXLLP0kOyScCJL4=;
 b=GJK+225mufQPn14czJBamytQ5KIzcluUcCpAMhxK3Y+1Qhzpb1eXtr/DS3tZGYSYSDDfI/o1QFLwAnqPdtI/7KHGRxy0u1UfLbtJ7lgZ2HVALPfUG0v7U4PAC5bJPVZWJ/X9NgUjkrcPIoAVPEJz0EAoYudoXPXV0glfoNN9024=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by DM5PR1001MB2234.namprd10.prod.outlook.com
 (2603:10b6:4:2c::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.22; Mon, 14 Mar
 2022 14:06:49 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5%4]) with mapi id 15.20.5061.022; Mon, 14 Mar 2022
 14:06:49 +0000
Date:   Mon, 14 Mar 2022 17:06:35 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Subject: [PATCH] NFSD: check for negative "len" values in
 nfssvc_decode_writeargs()
Message-ID: <20220314140635.GD30883@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: ZR0P278CA0082.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:22::15) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 15e605d6-f542-4652-5adb-08da05c3e1b1
X-MS-TrafficTypeDiagnostic: DM5PR1001MB2234:EE_
X-Microsoft-Antispam-PRVS: <DM5PR1001MB2234EE23EA4EC2A9168621328E0F9@DM5PR1001MB2234.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5McV9A/FqXAzXkiFX2QZrZYby1DxEttw1qhbRyJbY8toWqpRBCmFHFdWJ+e5NXBxzBRRCdEg+HDpBQ4ICTE2tW8pFJNifkZSlE7d1sIjaZPY7DbkQcNrQMQuLO00o7PIr5G6qrru7t+qpv/2MaOsZUOMRtt3XIzp0MZjgD2EgEWBzyJW+/c2AjEujmIVaHrj4MHJkcpChlFAMxgZLCxY59DR+6cbCjSgYMDAzxL4I68I79q6MA2v4UC/h3P9sHvJ0cNm5FHXnbPYBJsNoVzGSx4zietGJzfg1O4oytJ2GkxuewwMpX94kPN8Q+DQWpPI5mPHaG6spy2ndhjIecQzl7xyUyqGnozpL4dXvWj3uYLY9blPwzIUtxvW0t+T4sXFac4z6vXDBsRaEBGJSG+AqHB7V7lH1R5jea3DkETIdHQ9fMYsTOkYfv/0OGS4+0D/8YcbRiPee6vdfd9hcq11Cxl3e7cTsHwGb0IlEAIunRrrPH1IpoGbSxvi1g0KGb6zI7fApB4OspQvO+dAT0PvCevirfsdhIe7H2cTQcpZ/q3wU4hPCO9l9m2oY8cgjRv+mW4I1jIzX7ZXuONDMX/m+C75ZK4gIYiJgUsJ3b+gzSyk9dOpBQTGhn4Yo6y5NX3GHwZ3tqMSbUHrus/H6aHTxSwIjaqWmvVxwrhuwF9x6fRSTBtfmqSMM18jwvMeXRskaNLZJh0mouqQ7hvMO9i9dA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(508600001)(33716001)(2906002)(66946007)(107886003)(38350700002)(38100700002)(6486002)(186003)(5660300002)(8936002)(4744005)(33656002)(44832011)(26005)(1076003)(66556008)(316002)(6636002)(450100002)(6862004)(4326008)(52116002)(86362001)(83380400001)(6512007)(6506007)(6666004)(9686003)(8676002)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WQjejq2WgxnhU1jnTJ5TK8IVSjDb8WKSx7qOINplb+jUMnX9j6Wk6gvh8VXW?=
 =?us-ascii?Q?X7tRr0jTUrrUWuXEwvvXzHD0k1Mk1oI5tVtsiOssmTQSeoWA+uXoR7IqLqQ1?=
 =?us-ascii?Q?3dje+lfkgrIjITU8dW+OmXwocY0kOmgm1qarKePBqj8IOf63syIt/r/Mt86P?=
 =?us-ascii?Q?ksJatLWqUFKQ3u3CKQPStsCyxiEmYzY5xdDdBa9gY3IMVA9ekYmstYGLgYoa?=
 =?us-ascii?Q?Ktv6w3dYuK1nQXfP1jOb3jQYm9AeOMzSO7xAnVBZYsdFYP98G6bXv5LzE9um?=
 =?us-ascii?Q?zRAxfAcftHHjxDKXFc0gMRsMIpF5Q5QICvAkbEICuirvnuI76DLlhuDfxXZv?=
 =?us-ascii?Q?lbVKYEYoqfIUCRlvhufN4285Mi1+4sKiYAF+SfkzZT+38Do7z3xNMarNm8Yz?=
 =?us-ascii?Q?Rb4vRcAmIk7ii5/tqWp/SztMT9y9aXhucZNnm8575I9CF5B2fvapOwo2jIXO?=
 =?us-ascii?Q?Io2CFeSKnx5XOnAeILEVSG7KWUj9dztOwL9vAosSZ1dPFSTvVQEg96yUtXoK?=
 =?us-ascii?Q?+JmaXXjd3VSfs5TkS+X94uKTd+9JlDlF/gBVkEMhenIbDVh/yQoD7oXEAzyA?=
 =?us-ascii?Q?shLT2CBxL/+e+E25MvpTykcE+iBprZQpCgg3MbBu1rktNQ+W25SvgyasK0eq?=
 =?us-ascii?Q?HAdyM19zL9SOSVIccT84lxvRKONjP4jXYHZLp/IPRPgYDAI6/21/vn+Iw1i4?=
 =?us-ascii?Q?yB0rC+VnPLRc6+zwsP4kG+gXe5GuE0XUpNKb9vOG3n4I2+oimqpb3HPDYj+5?=
 =?us-ascii?Q?RJYvTQkbTvwBZOpHj3QccDg0W6mT8nIopnPzqAOVFst5dITGOpzE8b6MV6hj?=
 =?us-ascii?Q?rhSbZ0e0OgiQ7e7W9zTwJN2p3igmtVH4nrtbbiHRV8SJgak16RyFGuG+AOyg?=
 =?us-ascii?Q?uScpoMrpz9HDpOzCXkVf2XZlYavBYTiD/okDB5tQtdACZO4j54wku3AJssgc?=
 =?us-ascii?Q?oc9w2kJp7ggr61qxwZlrRb97k6r998vbNp/lBShFSwtq6v7mpEb28Bqb1olW?=
 =?us-ascii?Q?wXBsBPGdICF2dKlkUnr2eeYoFNVLFU/b2SxNh4SXoToWi+E4JkvjH5PNiG8w?=
 =?us-ascii?Q?37EYBOeCDMI4Lp02h9+D8LUO4/qnP8B4MEJUYn6z7OTCnwT43FgIrmSQoJvK?=
 =?us-ascii?Q?FeF4cOlrzuNALp0ju0WhHqjeGLiZZOtCI5r3ZGR9bQvEKS8IvxgyF7ljpQiq?=
 =?us-ascii?Q?MUkMUAT3qq9cdPaielShv0em5UGPdTC3Gi2rJy1XhoRDGjrFu+C3BjyaQkRT?=
 =?us-ascii?Q?gNpYf8uQHd53luxstYLpS0MWcCdlcIl4sqyVW72Yokj667gHmkI8SrNt7aEL?=
 =?us-ascii?Q?URW2rWbHsSKlHwWRu39bTvF1RnX/cPJAWUrgOG0NwR1cyTZqLJC1LOu8MzyR?=
 =?us-ascii?Q?JYaTHGBspadQAc87oqEAehjTPwejw7xNDYbeFy53P0LF9hhW2iNmQsjuEtWd?=
 =?us-ascii?Q?IOSW0C9+J0+gAQ2cm/IVVdxTva8N5ORI66XND+yC5H/pQaqM9ZM8VQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15e605d6-f542-4652-5adb-08da05c3e1b1
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2022 14:06:49.1011
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: esCl4b1UFoFq5882v2ZWFzfmmucKLks72+3+8HYt0pC4GQpOgnTxWoYm5itZHk/aIxWPKyc1nFIvAH1Hk6Fbc59Mi5HffnbJ6/xPQ/nXxGk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1001MB2234
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10285 signatures=693139
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 malwarescore=0 mlxscore=0 suspectscore=0 spamscore=0 bulkscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203140089
X-Proofpoint-GUID: xH7tTEf3TPGbL5HPQav-jRtRy2T9TB4i
X-Proofpoint-ORIG-GUID: xH7tTEf3TPGbL5HPQav-jRtRy2T9TB4i
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

This code checks the upper bound of "len" but it needs to check for
negative values as well.

Fixes: a51b5b737a0b ("NFSD: Update the NFSv2 WRITE argument decoder to use struct xdr_stream")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
From static analysis and I am not sure of the implications of this bug.

 fs/nfsd/nfsxdr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfsd/nfsxdr.c b/fs/nfsd/nfsxdr.c
index aba8520b4b8b..a9f80e30320e 100644
--- a/fs/nfsd/nfsxdr.c
+++ b/fs/nfsd/nfsxdr.c
@@ -336,7 +336,7 @@ nfssvc_decode_writeargs(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 	/* opaque data */
 	if (xdr_stream_decode_u32(xdr, &args->len) < 0)
 		return false;
-	if (args->len > NFSSVC_MAXBLKSIZE_V2)
+	if (args->len < 0 || args->len > NFSSVC_MAXBLKSIZE_V2)
 		return false;
 	if (!xdr_stream_subsegment(xdr, &args->payload, args->len))
 		return false;
-- 
2.20.1

