Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19E6B7703D0
	for <lists+linux-nfs@lfdr.de>; Fri,  4 Aug 2023 17:03:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbjHDPDL (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 4 Aug 2023 11:03:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230370AbjHDPDK (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 4 Aug 2023 11:03:10 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B816749F2
        for <linux-nfs@vger.kernel.org>; Fri,  4 Aug 2023 08:03:01 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 374EiRBB000340;
        Fri, 4 Aug 2023 15:02:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=1rygELEZjoIgyabkFgr6hOdXJWB/DiQcgTqP8bBuyKY=;
 b=YfR5zu+tuqUzi31Q0PUiRIuiHWMaxabWdMBThP650h6jawIbRpd6UYpMPd6VRtosxSel
 f4tjqXcFkPce474ESrRSG6Ra1MhNbdXansm9I2DeQML6UGHttjYj0BwY6BVi1xMXcPBI
 zdli7qD8bzc1jyx/DeFKhkUf6Y354LeVlNU+UxCj3JrGaLakxeqwuR4JA5qQKVN2jPBb
 4GRtSxZf2E+jgh7tKEdFRkDZa9o/FQyDPI5Qs96uILeE1ztG/tqotXevcMDtu7hRzwZE
 JtVv1fjjQ63XicsI5EQkzeadfBOR6vQkAOGE5wVfwXuzHDGEuvTY1KT0buvWRcT34kfl 5A== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s4tcu3wvk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 04 Aug 2023 15:02:53 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 374DLm2o011623;
        Fri, 4 Aug 2023 15:02:53 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2104.outbound.protection.outlook.com [104.47.55.104])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3s8m2rx79h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 04 Aug 2023 15:02:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VcDXqkFqrsWHgvgsSlBvtRqg7z6OXI5ufQacrxxMxROJ6c7DsDDX5Zs+Xf8da4w2HLIhSCMM1Z3awny2CRjmuDBgc6rhvcFXxGG4ybzArMrxxEHKa3D60kuSoimf/uJKosWI0RmyILXpz7xMBsSymOcMiki0d5Jtr6yOa/PdJaRUiWrCwQEyqZgx50JuJqpfN3iwKExlvy8NHuNFNyp8sUNW+wcKuiGwDEiDF8WqkbswrHQipL4o7/bh2epVn2BcJCZFuKmgAUDgRwitLvmMz6h4Vbxemfx4i9BessBf/7v6LULOd40MiDTukouJ1mET31zyGQezBQFrz054xlgb9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1rygELEZjoIgyabkFgr6hOdXJWB/DiQcgTqP8bBuyKY=;
 b=bwHmZkGidPGeAzBBRTowWRQg+/7TTQNVrLhCAle7rY8bHBPf3PQihockVGlh08BSeq62gurERP5NWjY5Tx0eCyejyY8j87KDoKMXI7synhOkHDtNG5GpFMaVs6lCKhgycvnl2L0HAfhlnYoJwk8cQyKoUoLqCb5LJUWHOtlnTlyF5v7E/6v+CHndndBJLQJ5ohKC0zCRApJSEqekZedo+SPwEJKlni1pan6S+0uJbtY1u9BauUzhFAdAKngYQSRqEsx9k4jZx9vywpfaanQj+JwX0VfZSP3wafJ6P+GuOuX+LPKX3BooCZ0Mnz0Hx/0s4mPBE0icpueDRY8ogNzy0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1rygELEZjoIgyabkFgr6hOdXJWB/DiQcgTqP8bBuyKY=;
 b=dhTeISThQADt7fl4YStfz9psY8K1VhPk8qyIH7NX/D5CtkCIFHosANvm0agpAYshpXMBHWdzHKNq8oxpZ57/c0t99uVtsLRfs2PmLLM9+2OUFCh8FAkF3KZ/QPKkwHaqf0M4kEJZ6AxPyq/Ef8qHUBueQFTQJDV/zTfMlv60Oeo=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SA1PR10MB7555.namprd10.prod.outlook.com (2603:10b6:806:378::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.20; Fri, 4 Aug
 2023 15:02:50 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e%6]) with mapi id 15.20.6652.021; Fri, 4 Aug 2023
 15:02:50 +0000
Date:   Fri, 4 Aug 2023 11:02:47 -0400
From:   Chuck Lever <chuck.lever@oracle.com>
To:     Benjamin Coddington <bcodding@redhat.com>
Cc:     Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH] nfsd: Fix race to FREE_STATEID and cl_revoked
Message-ID: <ZM0TF/rOFOxlaA+p@tissot.1015granger.net>
References: <c0fe2b35900938943048340ef70fc12282fe1af8.1691160604.git.bcodding@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c0fe2b35900938943048340ef70fc12282fe1af8.1691160604.git.bcodding@redhat.com>
X-ClientProxiedBy: CH0PR03CA0354.namprd03.prod.outlook.com
 (2603:10b6:610:11a::17) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SA1PR10MB7555:EE_
X-MS-Office365-Filtering-Correlation-Id: 590a187a-2f96-41b8-a946-08db94fbdee6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OCQfS8Xup/mSeBbGyVdXZ3pVWSLR8GzeUN2fU73yg4VrCI9+J7k7as9PqcMm7lMAvgJoJovn+SIx7bAK4P7s1b1qlCTpA1pIg4ca48K7cn/Cl9jKDQTmEQDmRPYgFh66gF19rrRMPaIHilyBxy8oH37XzfzaQfCnrimoHpGmyaLw9SGnkTTvfk2BZU4LlbV0aQsMi+RAthNIE/2+NftSevNBX4Mz2R+spj4YKPJgUbjozeh2Maltc7fwutn/LDYjadrTC96eQW6pQpnccn9m7dh/nV67UwCZNhSUr3Bp1NBjEjAP/5+o0PaLMjX020ol4KWGbIIWc18DLKHvQfaT3G5bh5ng3plbk+ksdyPzrxjryzhbgYFaSAMDKPK+/WgIXy8Z2qBK68wR8LzWIGzKYfDpGAq1wn/9AcoUopt/7gcR71TYFtNTjaeAA6pN4hfnGLgr9SDuIasljN8CCvD5rCuEMsv/h5sS+oNUuBskiLs5AsvadE/rP7b0vEsqThN+7mUjJr9QDXi8yB0UbU2RWeYKPwXDnovrIuC0OBx9G43AmwyOiMXy1kIgQz56vsUBDTTCjugphmXLfxfiEe6yKA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(376002)(396003)(366004)(136003)(39860400002)(451199021)(1800799003)(186006)(66556008)(6916009)(41300700001)(316002)(2906002)(66946007)(4326008)(66476007)(44832011)(8936002)(8676002)(5660300002)(26005)(6506007)(83380400001)(86362001)(38100700002)(478600001)(6512007)(9686003)(6486002)(966005)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/y0oLYGJo30n0wM8jJ3GVbU3RD7p4pHVf2SLpGKqFp2y3lVksCmlzTsVCaWL?=
 =?us-ascii?Q?qjAUopa2hSugnfR5/bZUAWgs2sWx/jawEIOcaqkbA7XT3XWYj13dOqkQNsyx?=
 =?us-ascii?Q?4DxlHNCosLw6qekzwRrM/2XBXJMWcRYAM4D6QzMAWLQ7Qvu7z7b1fVqkARTP?=
 =?us-ascii?Q?O88to+q43ijVB2dppgHc7yoBMxppLOTMvwCqujD+32psKW1zxv+uqo1Yuwdt?=
 =?us-ascii?Q?xk2VAY9ic31b+g3KXrUpIo0U8X7GC3NJZ93aREPCdmVB2PCNolXE0JwUKtQV?=
 =?us-ascii?Q?gGYAjazk+WbVsVP5qs0RbgbYoYfF6PCT9wBuYjxDNoL2WNXY+xT96nu+n8v3?=
 =?us-ascii?Q?FZQxsc2yFl53GCWD6kUcJyMREWkgDhqQV3VYK3VmF+koouyH72YhH829RWEW?=
 =?us-ascii?Q?jOc2mxnMZ/HFhq7pa9z8Qm6Zwfke0YXeK59EuY4Kuo60ZW0xGV8MTrdiJ6yI?=
 =?us-ascii?Q?+vOFxYKYysxPjZ62bv4nCwM9W5UJZki379my9RZRK3yk8zip5WqHr85b4r1y?=
 =?us-ascii?Q?l9TCAY805eZx6bm3g4qkCysJdtCVgOo0a6pEbS9jLfNs/aGxOzOO2bTVsOtj?=
 =?us-ascii?Q?B6C8NvtBdNKtOpHdNc2olweXmj1TEhPCSmyrQcmvH1Ibov8zrtqwq5h2E7w9?=
 =?us-ascii?Q?MThqz1GpKTHXQX6JH8yOxF3QEiNNIFYVmcwUEeRwH5EhMxmhvD8NxIUkGSoe?=
 =?us-ascii?Q?QvzDhtooYhI56Sr1an6q7UYDItMklga2F5YMV35on9RnChtvelhcNwnGFVos?=
 =?us-ascii?Q?CKbqulI+gajg905/2DhkvtxP+YPl+j5IKycsobxFjInVzLbS0T+iH4yfhoz0?=
 =?us-ascii?Q?YGblp7OatiOlDVUD+oNCGCbSZVn/T+OtVmWGK8S1HqKlqM9/47YoScFHcoRz?=
 =?us-ascii?Q?8GekDotZkAN6ILx+AnvyWgYTQ7ohKZcpoDi5coxA2Cy3jRte4LuOoO3gtX31?=
 =?us-ascii?Q?R4NeniqvdcmUUgbIOPnNfi2GAzlN1uUsQ3qoLiKV1ZG3lGCAGsv1tvk3suca?=
 =?us-ascii?Q?pNLE+QugPVXgffppjfzoBU3Z/GevIO5EzHTmZEIplkMcbFhUsIi/3bktkwJc?=
 =?us-ascii?Q?Rd71hD6PQ4KIzXdOdRAi6Lx2wn8DhcoEnMzSQ7M1PX+WwBhavhZ1rFVolXvx?=
 =?us-ascii?Q?XuA5tZWJtr3B4a5w0ptCWfZpPNGJfqIoWnX69smYtls6ow8fFXBO3uWZTrGJ?=
 =?us-ascii?Q?ZlCVls7GGRbGtryUJ8K0eGW/5jpUy+UKAYFNcxj449doo6FH2+7dWEk39BYo?=
 =?us-ascii?Q?sl0FMG14jbBxxRMGxD0eA3d+IQiHHkbN8AXridV2Ps30H4Q7LU/0KzhUEwYT?=
 =?us-ascii?Q?6MEVpOwPddfAK+0VEDHpvnRY9ZGVQopYoE4JLgA1Jggy1gBbcHCPPAInxifQ?=
 =?us-ascii?Q?PE3mkkFyRvkAYhbexrxhI8HADi71WzQLuEYrVPbY3rC9YXKbT3LoTJEBVke1?=
 =?us-ascii?Q?qeMiE8xeQNEojIwk2GcBh/E/og8gHHOvGRzDdIIPQP7LWa/nvf5q3FHhjpN1?=
 =?us-ascii?Q?nmZv6VT1JGuorexDuiFpmnGlHaLxayIiEE1TQ5ic8wYqrGaKcy70Ou0uyhLp?=
 =?us-ascii?Q?WQv19QYvPNW7J15nNGA8ORBIix33+pKCpyp8QokvKJpsNpbRMv6Y7Hv76gE4?=
 =?us-ascii?Q?YQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: AuQYvWcYOBpz1FqpRjKEB6/5VMs3EuTkfL0dMpCmzIRrnlaIhO0aqMVAesf/+pPs2ZxFmoJANhphSldqjinLRxTJM26WVVc4EIzTgzNijwkmQSZaQQzaRSjeEeSxmZm8JYWByDDjNcReAVU/AOzyxusccqmupNbwdc8PoqL3JfxHm7CfV7vJMH8kUj7eqoGLGT8nWUP3VzmnidZe6XBKpDlVmytolMAak0LDVtVZlgpR04pTKN8wfqxRmUQXeLGxEQDJo6kVY8DFIbCjI3S25Ai619agpXd64vsfdncK/CXqNmuulENEznwC6xxgC5GTbNOJfOtWJMOnpXMkuoshVzxGTl4E2ORN7k8hjEa5QD2jVYZN6mb/OWCmLqkILiH8G9mXF7pkXd9LaZRcz7mXPOTVe67QipHu1cXDm6+RvtVbDMWT6Hj6cPiGQj/shLVJHQLGsjiLMx5tHdxx6lhxFUukY3Lt6LI70W30NRXVet2Obqxl8s3WxCq+cWbZYbqgrXUQJD9g+1vu3PgZWx0D/aVVDlg5WQXpZErhG5T2sNLQIiDL7sdgCu+glSEin7yu8Jq8Cg6I9/GJBdEHwB+2nlEebfY+qzmzYBx/73SMa2sWpg/7s+Hx1XyY9LXVv23UiCq45gpj8CIzBgN/1j5xhRacdbwbcJ04+VMKztloMvWA7y+CgqBbsYMi2zSC99KCtDiOJQkG4P1aJCOrxpSpkpmXWve7+0s1YcfoCQFO1APTTNMZoJLE+RpBOYlFRc/9EBLtE7UkbIA0KUh9JikzcpbmtQ8Je44l7TS90kKdB66WVxp5IgkA80QRdtS8fjwB
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 590a187a-2f96-41b8-a946-08db94fbdee6
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2023 15:02:50.1845
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wzojFwAGZbJtKcSJ8S570U/WY8uhZLbf0haGCHznWKEBzLtjXdpCDBRFiiRB0VgC60OkH1I/VUNXoGBnzBjocQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB7555
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-04_14,2023-08-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 phishscore=0
 mlxscore=0 spamscore=0 adultscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308040134
X-Proofpoint-GUID: FRSzlqDUzLpXf3yZ7A7yBdJvAgopTF0r
X-Proofpoint-ORIG-GUID: FRSzlqDUzLpXf3yZ7A7yBdJvAgopTF0r
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Aug 04, 2023 at 10:52:20AM -0400, Benjamin Coddington wrote:
> We have some reports of linux NFS clients that cannot satisfy a linux knfsd
> server that always sets SEQ4_STATUS_RECALLABLE_STATE_REVOKED even though
> those clients repeatedly walk all their known state using TEST_STATEID and
> receive NFS4_OK for all.
> 
> Its possible for revoke_delegation() to set NFS4_REVOKED_DELEG_STID, then
> nfsd4_free_stateid() finds the delegation and returns NFS4_OK to
> FREE_STATEID.  Afterward, revoke_delegation() moves the same delegation to
> cl_revoked.  This would produce the observed client/server effect.
> 
> Fix this by ensuring that the setting of sc_type to NFS4_REVOKED_DELEG_STID
> and move to cl_revoked happens within the same cl_lock.  This will allow
> nfsd4_free_stateid() to properly remove the delegation from cl_revoked.
> 
> Link: https://bugzilla.redhat.com/show_bug.cgi?id=2217103
> Link: https://bugzilla.redhat.com/show_bug.cgi?id=2176575
> Signed-off-by: Benjamin Coddington <bcodding@redhat.com>

Hi Ben, does this fix deserve:

Cc: stable@vger.kernel.org # v4.17+

??

> ---
>  fs/nfsd/nfs4state.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index 3aefbad4cc09..daf305daa751 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -1354,9 +1354,9 @@ static void revoke_delegation(struct nfs4_delegation *dp)
>  	trace_nfsd_stid_revoke(&dp->dl_stid);
>  
>  	if (clp->cl_minorversion) {
> +		spin_lock(&clp->cl_lock);
>  		dp->dl_stid.sc_type = NFS4_REVOKED_DELEG_STID;
>  		refcount_inc(&dp->dl_stid.sc_count);
> -		spin_lock(&clp->cl_lock);
>  		list_add(&dp->dl_recall_lru, &clp->cl_revoked);
>  		spin_unlock(&clp->cl_lock);
>  	}
> -- 
> 2.40.1
> 

-- 
Chuck Lever
