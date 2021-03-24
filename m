Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69FA7346F05
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Mar 2021 02:47:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231818AbhCXBrZ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 23 Mar 2021 21:47:25 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:54842 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231819AbhCXBq4 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 23 Mar 2021 21:46:56 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12O1eTYo032800;
        Wed, 24 Mar 2021 01:46:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2020-01-29;
 bh=o1M/O6HO9DrmvTfG0RzEr8W2uYRZXMrjnLhz7ivuJOU=;
 b=YlbOJyHiPRJ54yjlkCBIF1+P4u1GEELulVx6zlDr1pqOUImKGc+AIWZIkGDULkPHihHI
 ZEVP9q+0vrfeMAcKTNUE2QCgq53Fnyus4ExqZTe2zVhxhl1GubhfgE6esxyEhKbwXLqs
 z5qabCUIfup3jtwj9F7QG0ArYrRlfGcV8/jdsGvPbCnYQNZbLcK5i5/FupO0zLYvACIJ
 MCdToX2cOrL0GZtiMHUdamsiqGxVqlO6RQlhBmOf6ZnQFYTimu/bbT+0MtxnUA+Rkku7
 hqDykoQ7dk+KrjPC/9TbKCPSDLHOFriCcdLdNAG8gw13aBMQP0e6ea3Exa/nqzbi4wjA NA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 37d9pn13ye-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Mar 2021 01:46:54 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12O1il3b093711;
        Wed, 24 Mar 2021 01:46:53 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2055.outbound.protection.outlook.com [104.47.36.55])
        by userp3030.oracle.com with ESMTP id 37dtyy7mxr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Mar 2021 01:46:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WuElO96GSaSW7pMisrKZaB+FJkupFtv0/YYDkG/EiXYmFZ8JwPfe+oyererJ5mwHe5I6D/nTy0WFS5BA3s9kYX9niAAYLhr99V+v6PevI6UtCEb71zCYK7bSB0x0vG836F/7ukvjV1sO2/J9wwbw31areO90odOwmVeNxnmEKqtU4iVOHymvcbWNizdglpD5NzH9ltb2o+4qerNXHmsimjq8llcb0y7y1P7Pp6TwNwYRA0KXWlzFss/98jKtxR3PHAy1SPVUE+ds4yRc/Ge01lFpk7J7jhtMR4zMkmC0LSRqmYCkUfUYohDfe0hTyi5DBeIs/plThXAK+DtGfM+JEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o1M/O6HO9DrmvTfG0RzEr8W2uYRZXMrjnLhz7ivuJOU=;
 b=nSNmULPLO4ECu43sB9hOQHIE8FIuxa2rCG1DFY+xi7DOQ4ba15dJmxiOwEIyVYg+0AIdHmEod4yUoMVtZJwwQM2E7u6K1WKrwAr9/ydx+9bjlxoDGQZNDvcOoF71ulYJtxK3vClNUDYGKLijLKyLtAi+26wqErBmp8Xx11SBnkFaeKcoqmH5WhaQH2wYOPYCp+MzBTG7rtZffNMYaTDb87lqmo2we/zkfrihtWAP3hoaDp94HoBXrhzbQvokSljIkbbo17RxWQLmV3nFa/NkhcStLpKGSlD/FZ9u8NX1FrWczBY83V8wrCgayiYXrUQlMtS5CzKTeyfszhTDS/NXKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o1M/O6HO9DrmvTfG0RzEr8W2uYRZXMrjnLhz7ivuJOU=;
 b=zGLO+2zxpP2xjZHrhhfOeQIXUaUhzBKoeoiOfPHfD29KBEdl/KhmspO6VLVxWUcRLW6+xEveUAZ74nUnN14ApZz0sp3gLtYeqU37C3DJw62ot4rZiZMIJ0GWjnxvgUDvQs2nWl9Kht/DZi7evizBNPOdP2MzeOUYlwGabTCtyoE=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=oracle.com;
Received: from CY4PR1001MB2119.namprd10.prod.outlook.com
 (2603:10b6:910:3f::15) by CY4PR10MB1304.namprd10.prod.outlook.com
 (2603:10b6:903:26::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.24; Wed, 24 Mar
 2021 01:46:51 +0000
Received: from CY4PR1001MB2119.namprd10.prod.outlook.com
 ([fe80::848c:1057:dabd:55b2]) by CY4PR1001MB2119.namprd10.prod.outlook.com
 ([fe80::848c:1057:dabd:55b2%6]) with mapi id 15.20.3955.025; Wed, 24 Mar 2021
 01:46:50 +0000
From:   Calum Mackay <calum.mackay@oracle.com>
To:     bfields@redhat.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 0/2] add another courteous server test
Date:   Wed, 24 Mar 2021 01:46:28 +0000
Message-Id: <20210324014630.2454-1-calum.mackay@oracle.com>
X-Mailer: git-send-email 2.27.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [141.143.213.46]
X-ClientProxiedBy: AM3PR07CA0065.eurprd07.prod.outlook.com
 (2603:10a6:207:4::23) To CY4PR1001MB2119.namprd10.prod.outlook.com
 (2603:10b6:910:3f::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from cdmvmol7.uk.oracle.com (141.143.213.46) by AM3PR07CA0065.eurprd07.prod.outlook.com (2603:10a6:207:4::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.9 via Frontend Transport; Wed, 24 Mar 2021 01:46:49 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 94ec9893-1883-4c57-4c30-08d8ee66b169
X-MS-TrafficTypeDiagnostic: CY4PR10MB1304:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR10MB13049E684ABCF8FB3FBEBD4AE7639@CY4PR10MB1304.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AuZ6jZdLgyjkMWSZnyTOuCMRvU8+Pvd0zHEQzhlE7IR7SlAb5FC8310cb0Azu2VXQfXg6nzcDa8BIfhqxDBIcvc7qCBCO13EKobK7RzpCMe9czflYgS6lL+w+8eabFuKTCmZ6Q/iPuQPnHyeNJgUHsiQotujc/8peE8WVQq1nA6AORxJwy8apL6/+bX4J5fDL0EyuIkpNFkXAzo6eSC1LAbG4pD0D1AJsbEaegn1gl9qzf55SEnt6A4KhoGJtQ/tGXDlbATwDlNaZV5zPLL2hqv7iQJg0sfrv2efXC/ojKJjfJu5Fg+NHDyz/qUjf9pVYaAIO4cxJWRM7f//jLF48Y77eIjVxvjeV6LUA8R0sO343THZ2PXhgOxgXO0DOIrSpW6MNaeqbMzSLL5JxP7eZQNmqO0oDe797cs2nnp/SkUErxiVSATgs6+GJWFa3AdCK0ADJ8lBMgT2BtCxcuA6Lk1Oai0SxhZR/Y5mNgIRGXhB314+utzNm7dqmn8ZnT6CqfALT3IJvVuYW03NpYvxUX9Tygx/eIWFUbMght1+1vjQbGqqbM6lVwf4ObS1ujZ0Z5F8n1lFuiR/bSFqC5YlGw9TqPzOOqTyM6aKC+gVp4ijlvpyuEPPArETbvU/ax+WvtlQRnS1zTfErvvvjPWwow==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR1001MB2119.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(376002)(136003)(366004)(396003)(39860400002)(956004)(8936002)(6486002)(2616005)(7696005)(4744005)(66946007)(6916009)(478600001)(66476007)(66556008)(6666004)(4326008)(26005)(38100700001)(83380400001)(2906002)(5660300002)(186003)(86362001)(16526019)(316002)(44832011)(36756003)(1076003)(52116002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?dK+LR5QybAn5MozoY9cHG2gKFxytlJa3C1pwMKAxKtWxuo3iXHoc/tO/qJ+e?=
 =?us-ascii?Q?gxIfnF5YuGnZMPoHfDS3Uu296x6Xmtd9jg9rH1B43U8JYgBaZZcFfzdPiYTF?=
 =?us-ascii?Q?nTso/NKNSJ7cDHkYPZB004NOqQMWErwx/yy8h5q6ejP3kf732qv2prYpZudT?=
 =?us-ascii?Q?NJgp/03xDrZUzQyXGo87q+oqO30FMkOb8PBydKnQLKtFhLD6hB4ZemiAPxQs?=
 =?us-ascii?Q?pFQGVfd84yi2j3VTgGmF8g3efgMA73AT+mqEMcSSmT8z7YIpxGqjnMFV8pZ/?=
 =?us-ascii?Q?uqGX5XnrfKbSkvvM4NzNECCMvgAC20iky0I0nmHnsJcWiQOit91BREeTP/bq?=
 =?us-ascii?Q?RNRUBFBRUr5XwUJYYU1TzW9mRMYKUnWIZCkDXZWdqfOtSxT/IrN42gRsOcUb?=
 =?us-ascii?Q?PKP+yDGbmYlRgsO7YPIZ7AYik739TipfjZubIdcKjwnjIib8phJfnSoSo4mx?=
 =?us-ascii?Q?8nR+2Ngil2uwnWQmav+/se55mycPfKKwJ+zdRiGsGSidAZh9cDASEbJ+dpg3?=
 =?us-ascii?Q?KFhMse/NRbY1jUJb5pACdNAK/z49yphs4TMhOpz6H5N2KbbymQt1sQoD0NT3?=
 =?us-ascii?Q?cVx2d6jBc9X1aKqbNhG/OMM3yEepKe9fMwG+fR5p6JhsWeA8sizqBTKdoa1w?=
 =?us-ascii?Q?6mlmn0/YNxEY3YXAivNzN9lyCuD6mLLYOQVUYLY2GmkmCc0XEa2iTl9ibWV+?=
 =?us-ascii?Q?anGd8fAZUXW11fDrlx9NehRypgrEWh5a8vLuZKKOOA19ca0gWznykvDr+moE?=
 =?us-ascii?Q?ROLqtyyBzi7QX+lsnVaSWWK08DB27nh9kbAm/eEzyQXFHMCfCp981mJC8oFv?=
 =?us-ascii?Q?A1Ci7q5kLOKjwpO4Jtk4kG0JIJR5fQkDkEZTucCXmNVHjFOFkR6iTq2f+xHx?=
 =?us-ascii?Q?3ZKdKPRL3Jm7OqBLNfLPOXSqCkzV32qfA+lM/78vm4QXJCKF3FJB2jVXlP12?=
 =?us-ascii?Q?WdV7fKoVbJFVj6EyMJLmJiovEySxYKgekTWD8IT5cGfjz2Il0XXqeNCCCj95?=
 =?us-ascii?Q?GR4LopAcBmwNyG5VfgV6oVGr349oDye2eloFLhKEFDrECZzFSG2qVb0lwGG9?=
 =?us-ascii?Q?+K3GT59cjcAd+D72LKjyMDgRz0htObTQYWNn7gM8NPmtfnHy9tlXalkRr2Zq?=
 =?us-ascii?Q?thrICcT/91ZjSI8bkmjkqrdiDDDR8ibij3kfHfh08vP7F+ikx17fgx+kU7NT?=
 =?us-ascii?Q?aVKwsxj8qZOuDBwW0oi9H2n0QJdl1SHXzO5P/fz3Cj0Nx/ddnMG4U4B8wOQe?=
 =?us-ascii?Q?TOJx44gxqMGFR6zQV+boMmOkR0SZvVQjCXUNuiHySVbNtTjceX1UpZbZ9q8G?=
 =?us-ascii?Q?CYzJT/kB8nVxnk0OezZeSih5?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94ec9893-1883-4c57-4c30-08d8ee66b169
X-MS-Exchange-CrossTenant-AuthSource: CY4PR1001MB2119.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2021 01:46:50.7625
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8qQKDXV8gs57gCz2GEr6XAA/9m5rBYP3uTAmahfSiZEzh0J+j7xiRAWh3ZLuu8+mrbrDDh5p3HIl+1Oq+NQIVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1304
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9932 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 phishscore=0
 mlxlogscore=888 suspectscore=0 spamscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103240011
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9932 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 phishscore=0
 mlxlogscore=999 priorityscore=1501 impostorscore=0 bulkscore=0 spamscore=0
 adultscore=0 clxscore=1011 malwarescore=0 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103240010
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

This adds a second test of courteous server functionality.

 nfs4.1/server41tests/st_courtesy.py | 44 +++++++++++++++++++++++++++++---
 1 file changed, 40 insertions(+), 4 deletions(-)

Calum Mackay (2):
      pynfs: courtesy: use a helper function to prepare the lock op args
      pynfs: courtesy: add a test to ensure server releases state appropriately



