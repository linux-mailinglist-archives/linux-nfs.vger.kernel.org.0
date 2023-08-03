Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3039776ECFB
	for <lists+linux-nfs@lfdr.de>; Thu,  3 Aug 2023 16:44:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236540AbjHCOop (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 3 Aug 2023 10:44:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235273AbjHCOod (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 3 Aug 2023 10:44:33 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21D832D43;
        Thu,  3 Aug 2023 07:44:15 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 373Cg0KH000827;
        Thu, 3 Aug 2023 14:44:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=LvKHazbtyxH/WXky1T44ts3mXQ7vO6pMKFNZw3VCFww=;
 b=RThPO7IttU9q8T5ye2XjBPWdmANdZVJp7+Pdi/+9MfFm1uVNFfnSKCJVXA151GH/41lW
 9rZwqgsiXO7A/bf84uqeMxIxKGnLvFcT8qzYhfUnIrJq1JP8BwZ4plRDvM1sWt7s7dXj
 eOVURx/Hh38CwlYdiqkCYs82TNcPSa7JQ709qNP9uV1uiDHyQSrhYOwvW6wMPFnhxBq9
 uxUs4HMv7t0wP45YXwXjRB5kJKqUj4dBb6EZ2mFe4F07ztvWVFdmbqUkDMfICZeW8Z0+
 krXvtPZbQFLH/4qqU0imhbLdhsITK/fPNJgWuj0B/POwjyo4JTZCaReMZSXxotwi1is+ rg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s4spc9u37-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 03 Aug 2023 14:44:04 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 373E2oN4006606;
        Thu, 3 Aug 2023 14:44:02 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2048.outbound.protection.outlook.com [104.47.51.48])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3s4s7g0mf3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 03 Aug 2023 14:44:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D5piZWTdlxILNCrg9u/++mPb8GaS705G/DohST75Yar/XAUUYnBvVWHbo77RlLaC0c/0NOQXtDB8CTRENEAjLH831GW12WZJQruRz67ZdjgQ+5Pc2ELdIFe+PgYF++BLShcWMdb3ZPfTRaoXX+AG61UowBtyYoep5uEzTp+dCh2vrfIciAaEYY9/0qK96lFxIFFXcygl9HSR9krTHLKmcPnFdTFpKKqjvkt1TTbAHFS/H/xXhJfYxZwkMNvmsX9KLj8N+2vEAsfEwJyqEwmOJtMhVBBZQm5aaKVMeWrq/NkwxQ2qV7SatwWrmqShoAcyuVjAhZs25iXiz67bn/aO0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LvKHazbtyxH/WXky1T44ts3mXQ7vO6pMKFNZw3VCFww=;
 b=exMrqwSZXs0lFCKScFmPQ8UzBoKM2CdAS/QyDId7nchBMOJqNBohuQ7g+/KrTy5Nd6F7nrmitOzfSXWFh2dKC5SrSwXi8b5fW1qTcDf5q8Jit/5SWfkVuAGZK2gGmthna9E2U3Q9FKK0owG3DvFrXis8H/RaNwiMQQ0M6e/uxl5z6OWpO8naQ7DSO1uDOb00Slgj7RtXlVFaGTKkdkVJWIlkbIxX022BpMd6g/6dFBXqURE3hH1skQCy1MUkwyJb4BDeijKdXR0N67cdWB/qAW0rF4W+X2LyL3km32NmAdzixuKWNnFtR6okxe5aJZ6f/ERIxqvWlZ/R9Flu25X/zQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LvKHazbtyxH/WXky1T44ts3mXQ7vO6pMKFNZw3VCFww=;
 b=y0Wf4BDhg1abgpF/g5Wz0YwyoSlwx3h9HfAMg9VpbEagNjzuQ27bvUPaFzrNCS7tKwIgrhLROhWHl8pGK8LRivyrsJlQ9LRmTqv8dnWMYAf9PL09u79LdWKstuHOz31TvHir9CxadXakfHsstkURoL9Zd0Y2HD1IFc7YnG6X544=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DM4PR10MB6792.namprd10.prod.outlook.com (2603:10b6:8:108::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.47; Thu, 3 Aug
 2023 14:43:41 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e%6]) with mapi id 15.20.6652.020; Thu, 3 Aug 2023
 14:43:41 +0000
Date:   Thu, 3 Aug 2023 10:43:36 -0400
From:   Chuck Lever <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Neil Brown <neilb@suse.de>, Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] nfsd: don't hand out write delegations on O_WRONLY
 opens
Message-ID: <ZMu9GNzHD7nTOpZ3@tissot.1015granger.net>
References: <20230802-wdeleg-v3-1-d7cd1d696045@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230802-wdeleg-v3-1-d7cd1d696045@kernel.org>
X-ClientProxiedBy: CH2PR18CA0047.namprd18.prod.outlook.com
 (2603:10b6:610:55::27) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|DM4PR10MB6792:EE_
X-MS-Office365-Filtering-Correlation-Id: 51b3e29f-c1f7-4add-a51e-08db94300673
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XnwDs+0YWe0ZuTSeDlW3Nbpp2K/cyYBtAsAq2PV4vAZOjvTMFDPp9vKs94CGd2swr8TEpg0IBAUq3OyUXODbJrQGoqdpVAiHIMn+55huSThZZ+RTmwIg0tmuYSFVOkjVW38QGudj8KzAxK7wrpzcse5q2Fyi9ItsGoKQ1crz59G21HaOGrzuiuj4uyEEsBlJBuZHmrzeB/xoODC5xpokU6IdXVi7dHumi7IvZ1FvhMglGklidbBDCKeAxmE0EKU3Q1YpmaCZzETe/gyzQYqYJCM0yq9gEw9T9CBrJBU+yhqpljqxWjpt5SCIPugOs2/Hx4HHePqzbg7b234KM30lu9G42cr00YuNcckuVYJ9+UfvISrszVc6I5hUgwVKob0MqyaIoEzgHnRznjjLOwI9v6M4KxJ+uJoDV4Xb4iKQRYQ4rrca7kEiRjLAAoqzXp3j/MdJnflYBfBQXrEcW1SLHhM80n4tLrfkyN2Lp4UuwpxCCNT3S+BzRZYEokrq+YBYLmp+oag/cuG3F8j/3VSCOD6yAjkFX0gmWgnY+Y/Gyz0c4c0NHDZ3PI+EgjGDogKDiVFimAi5CAeKFFiv4jYXqA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(396003)(366004)(136003)(39860400002)(346002)(451199021)(6506007)(186003)(83380400001)(26005)(8676002)(66476007)(316002)(66556008)(2906002)(4326008)(66946007)(5660300002)(6916009)(44832011)(8936002)(41300700001)(6486002)(6666004)(966005)(6512007)(9686003)(54906003)(478600001)(38100700002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XpANoqzc0tMpwc2Zrcw0koiFXYOS2LgRi+SWTeeaAWHZHMSM+iw16WOGSp9n?=
 =?us-ascii?Q?dAJ2bfQFZgeGm8N8uExUnr2rsfahSUe9mgKpkPBRYPoqDyQNBEczdYUNgUb0?=
 =?us-ascii?Q?4y2ZjXrrYDnXhTjLx7OHyUii2gdSYyjGDxlY+SCa2WMCzvl6t9TnSiUPqIaZ?=
 =?us-ascii?Q?+czn+obsluJB2EgJaeYjwNqxZECoZsk85XFGDDMhIMpWJW1xcNTZ2f74DDcQ?=
 =?us-ascii?Q?4SttJz7T3H79Wn8h/Zx17eyOtPg389Hkqup4UnlEJPzZXi/ZGWWjWqW9s4Hv?=
 =?us-ascii?Q?OeS+d0tFxrGUH4sqQNKI5j/0ErZcerR2KYXX8InnQihOe1BDGYGH3qKQcw9C?=
 =?us-ascii?Q?GtzuyR5QC/UvD5fyvkhawXBSHu5zDkI40G0rybkXWjdyJA6EciQiaz6A3l21?=
 =?us-ascii?Q?SCuOlqBRKklqDCjTLFWK0GTybpo+mNhwOUS3oNTN9zLButGyHFLK0ZCTQO7x?=
 =?us-ascii?Q?CLKoF1r3rsORqKa6hxINonHlbBnIIUfCvq8Wwwq7KBYvdsQEy0KjnonIbHaG?=
 =?us-ascii?Q?Qw2jzXPZMu5ZPLKcy1QFBkSpbRQiHap/2Gb+6CU/o4geRKMYEu/9CbT2wQ7T?=
 =?us-ascii?Q?srlrEbUIikrgrhfJRuyET/5EM7heJXmL+lJEY495jiWMHaIU7omgS3KRJL46?=
 =?us-ascii?Q?uGKZEkLDcq1m09h4uis8bZhCKyQm/DTgjE35JGT4+TtPloYt0k4m8/4uqniM?=
 =?us-ascii?Q?o5WnxGovKJeCPqzmXilwiw13ZopM+zzyno3Jy1YEAohKsrUJr0lSWLCLcPzD?=
 =?us-ascii?Q?OfSBpGFbtJ8AhsOWldjArbPfXX+da9RB9GwPtMrJbnFUYqZdXeXtbMDwz0q6?=
 =?us-ascii?Q?gQ7WM3Fj6AWEbQ+wJvZ7V+Gvi3ePy69GllsTzuxgc3jxuFmKNvz9qwCs5oH6?=
 =?us-ascii?Q?gNFRX9AypH2HyGyXu6sKg/7dbBHRW4Ue7c0pkWCED8/uF0vGzHIzSEdXMUWy?=
 =?us-ascii?Q?eysMlUSH1qx0d8SXadDD1RHrdIVaAoRdTtiHMzT3StS1TLDQnepNRs3Fv6JQ?=
 =?us-ascii?Q?4NsKz3tgfkPWFnY1cfouotzIG57L5vy7ebaPXw3Wx7F8YPn3m0kxosMazC/P?=
 =?us-ascii?Q?R2pUPZFIHnHf+zFNRk0FQFF0W/zY4sYMzHHi5Y1iqU/SRA5Wny3QOieIZDne?=
 =?us-ascii?Q?z1rQO2D79I9sAGawDu4egyx1RM3lpGYCgYDz996NDIfmd2BC4w8Q+3v0DaGN?=
 =?us-ascii?Q?6eYgSkhVv97yiBpTvgb8K7AYCPdRyOMX2jDeus0o4jnPMdFiR719opB9BAtu?=
 =?us-ascii?Q?s+2FTmGTb4Y237gDP7k24RcJNS0e+iE4B2YlRa1IRw7iSeXCOGiiDw4+JoJw?=
 =?us-ascii?Q?fghE4E4Wa0/qMrP+MOWpcnpii9TF16zYpkVYSvhmozE8scRgI7D7vPXzoNvc?=
 =?us-ascii?Q?SgQNFAWiMOrac+VbLDOddAKmQMp9olykkZQksrodLFvmNfpSGEV9wakoszD3?=
 =?us-ascii?Q?9LCozhYSdokWfmbThUxxtEyI7Tq0h0vEH4qVTA0yTZBA1JMDO8Zdsu+JUwC9?=
 =?us-ascii?Q?CRpLpyLsj/6pMaHCH0IHeRZf6D4pIb8iI5QO111xU+pT+w22RHEcJ9tPI3d/?=
 =?us-ascii?Q?8HgJaPly82MzHh5JryXakBrcwuOBKEcBhsct1+tQu0edyEAcHIUwnF/UiVF3?=
 =?us-ascii?Q?AQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: SBKKhWdq1uYfiEgEnZpzzzmEpIQKj4nXWuUmBIrtXkkJvFsjXa8XKukj4iVYD/7UG6jV/5P0UTK8TyLhtPwAmPiuN5IMxu+vUXWFLPzA59LOE2/A6HM7OS17RanYbbxeGsVQLJZ8/WfkBYMT+872o/aw+qr+BsyinSIQRWaSnVdXyIlAWpDYtmk5FjTwYDWotnGjdu0E4NRxlBzwa6cU0HZlErTdYyg05x7uCjrUnZTBbfjJmTSisEB5IQAnEVSuCPXQsbEKnCZgj0ovpvUYSO5TKFkaSn+c3omsaQzO51SpHk3s0BAyBix9L0eONmGA7kKagZNLdrTMJ1qBCs7fEXiYU+KSXyYnoDInnKK4b6CU3Ggf/oVHTzIIeE8T04yR4mxKf7Mweay9K/kw1i5mklCrx6pO9ceoL9PAzywJQtHHgkUk7HdKl+XJpbnJxwuwiuDPjw1YSJPmj3+HKJnx2oxfhOi3pRUlKHtUSeoKAyUnwQnsPUAOoyfevbPsIS+/JrigVjzfm4Zw1umUyZieZA0d9Lg2fpS2NeIBsxDM2a+uKLMO6XpbVPUcLV8YGYKhZkah8EjZYci0Y5aOuAOagL7onKAirjKOGLaoB9eKBvxeQR4HX3LRCQWQZ9i52oDs2xVvuZ+o/5AQ3x9HFjxuHscojoUXMN6OWAUjgbE4u1oL/hKTbaMQ5PA+DH5NrD9k4DxCVHht9rR8K2YnEK/mpcbvgGE0B7rUZztBgBOrO8XNBKlJt3+64lp8Y5sThJK1M/DrmOU46jJAeFFRVK1KX4Tm3aweIQdY46tcw/qRLhTXd0s5tC3kS81Rr1aMsDZ8HkIF+Ma9lqXWi6N/a/DrYpxTe8MPRhGkpDViYSisGXRUSbVZYRaj7PQAw0mZFyYg
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51b3e29f-c1f7-4add-a51e-08db94300673
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2023 14:43:41.3322
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jv215dtBwOZuaWYbWposqgJq2GsORjdGYdCEIYSuK5oN/r5LCWOgClyEuOvWmJzM6ZzcLJM6A9bxuV65pwbxsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6792
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-03_14,2023-08-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=913
 phishscore=0 mlxscore=0 adultscore=0 malwarescore=0 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308030133
X-Proofpoint-ORIG-GUID: ZCuroCaF8PYjip0A8B_FF-xrK5-cOOZl
X-Proofpoint-GUID: ZCuroCaF8PYjip0A8B_FF-xrK5-cOOZl
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Aug 02, 2023 at 02:53:00PM -0400, Jeff Layton wrote:
> I noticed that xfstests generic/001 was failing against linux-next nfsd.
> 
> The client would request a OPEN4_SHARE_ACCESS_WRITE open, and the server
> would hand out a write delegation. The client would then try to use that
> write delegation as the source stateid in a COPY or CLONE operation, and
> the server would respond with NFS4ERR_STALE.
> 
> The problem is that the struct file associated with the delegation does
> not necessarily have read permissions. It's handing out a write
> delegation on what is effectively an O_WRONLY open. RFC 8881 states:
> 
>  "An OPEN_DELEGATE_WRITE delegation allows the client to handle, on its
>   own, all opens."
> 
> Given that the client didn't request any read permissions, and that nfsd
> didn't check for any, it seems wrong to give out a write delegation.
> 
> Only hand out a write delegation if we have a O_RDWR descriptor
> available. If it fails to find an appropriate write descriptor, go
> ahead and try for a read delegation if NFS4_SHARE_ACCESS_READ was
> requested.
> 
> This fixes xfstest generic/001.
> 
> Closes: https://bugzilla.linux-nfs.org/show_bug.cgi?id=412
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
> Changes in v3:
> - add find_rw_file helper to ensure spinlock is taken appropriately
> - refine comments over conditionals
> - Link to v2: https://lore.kernel.org/r/20230801-wdeleg-v2-1-20c14252bab4@kernel.org
> 
> Changes in v2:
> - Rework the logic when finding struct file for the delegation. The
>   earlier patch might still have attached a O_WRONLY file to the deleg
>   in some cases, and could still have handed out a write delegation on
>   an O_WRONLY OPEN request in some cases.
> ---
>  fs/nfsd/nfs4state.c | 48 +++++++++++++++++++++++++++++++++++++-----------
>  1 file changed, 37 insertions(+), 11 deletions(-)
> 
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index ef7118ebee00..c551784d108a 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -649,6 +649,18 @@ find_readable_file(struct nfs4_file *f)
>  	return ret;
>  }
>  
> +static struct nfsd_file *
> +find_rw_file(struct nfs4_file *f)
> +{
> +	struct nfsd_file *ret;
> +
> +	spin_lock(&f->fi_lock);
> +	ret = nfsd_file_get(f->fi_fds[O_RDWR]);
> +	spin_unlock(&f->fi_lock);
> +
> +	return ret;
> +}
> +
>  struct nfsd_file *
>  find_any_file(struct nfs4_file *f)
>  {
> @@ -5449,7 +5461,7 @@ nfs4_set_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
>  	struct nfs4_file *fp = stp->st_stid.sc_file;
>  	struct nfs4_clnt_odstate *odstate = stp->st_clnt_odstate;
>  	struct nfs4_delegation *dp;
> -	struct nfsd_file *nf;
> +	struct nfsd_file *nf = NULL;
>  	struct file_lock *fl;
>  	u32 dl_type;
>  
> @@ -5461,21 +5473,35 @@ nfs4_set_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
>  	if (fp->fi_had_conflict)
>  		return ERR_PTR(-EAGAIN);
>  
> -	if (open->op_share_access & NFS4_SHARE_ACCESS_WRITE) {
> -		nf = find_writeable_file(fp);
> +	/*
> +	 * Try for a write delegation first. RFC8881 section 10.4 says:
> +	 *
> +	 *  "An OPEN_DELEGATE_WRITE delegation allows the client to handle,
> +	 *   on its own, all opens."
> +	 *
> +	 * Furthermore the client can use a write delegationf or most read
> +	 * operations as well, so we require a O_RDWR file here.
> +	 *
> +	 * Only a write delegation in the case of a BOTH open, and ensure
> +	 * we get the O_RDWR descriptor.
> +	 */
> +	if ((open->op_share_access & NFS4_SHARE_ACCESS_BOTH) == NFS4_SHARE_ACCESS_BOTH) {
> +		nf = find_rw_file(fp);
>  		dl_type = NFS4_OPEN_DELEGATE_WRITE;
> -	} else {
> +	}
> +
> +	/*
> +	 * If the file is being opened O_RDONLY or we couldn't get a O_RDWR
> +	 * file for some reason, then try for a read deleg instead.
> +	 */
> +	if (!nf && (open->op_share_access & NFS4_SHARE_ACCESS_READ)) {
>  		nf = find_readable_file(fp);
>  		dl_type = NFS4_OPEN_DELEGATE_READ;
>  	}
> -	if (!nf) {
> -		/*
> -		 * We probably could attempt another open and get a read
> -		 * delegation, but for now, don't bother until the
> -		 * client actually sends us one.
> -		 */
> +
> +	if (!nf)
>  		return ERR_PTR(-EAGAIN);
> -	}
> +
>  	spin_lock(&state_lock);
>  	spin_lock(&fp->fi_lock);
>  	if (nfs4_delegation_exists(clp, fp))
> 
> ---
> base-commit: a734662572708cf062e974f659ae50c24fc1ad17
> change-id: 20230731-wdeleg-bbdb6b25a3c6
> 
> Best regards,
> -- 
> Jeff Layton <jlayton@kernel.org>
> 

Tested and applied to nfsd-next as a separate patch. I intend
to squash it into commit 68a593f24a35 ("NFSD: Enable write
delegation support") in a few days.


-- 
Chuck Lever
