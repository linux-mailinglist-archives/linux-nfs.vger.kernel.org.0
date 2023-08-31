Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD51378EF5B
	for <lists+linux-nfs@lfdr.de>; Thu, 31 Aug 2023 16:13:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbjHaONy (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 31 Aug 2023 10:13:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345898AbjHaONx (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 31 Aug 2023 10:13:53 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E8CFCF
        for <linux-nfs@vger.kernel.org>; Thu, 31 Aug 2023 07:13:48 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37VDbL01003379;
        Thu, 31 Aug 2023 14:13:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=KkPrlGzsOuu4kbCLoe/jyJGTHzfMFQ8BSmF490n9suY=;
 b=h6OYPmVXbhTIIPQLCZ1oT3pZzHdU/91MAmjl6JU08Hf2Xc7gDSbDwrB2NKQsl+PYkyW3
 YtC92gByln28Ck6XO6yQVm7abaX+jLYyGnp1wm/xT3zYTaxgLxQshMVv4dmA91tDNwB+
 N5ExFUawFEfn6loWBKQglnBtwZXW73UYL3qA14NbtCbNT3ptWVi2DW1dZBmW+97+eEmy
 V4WRCIxR8x9MxVDM19OwSSO1kM5CEfNAWuZkNhUb/QoaoerPCjt+LVS1rCYtSgL7nKcJ
 OVTfZz/oup5gOntqPZjrYmsqg5/X5WE7dEWjTqqumVfrSqsxmzbq3/eMAQyQJ0zaLJj7 Lw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sq9gcsttr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 31 Aug 2023 14:13:45 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37VDCRbb032738;
        Thu, 31 Aug 2023 14:13:44 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2105.outbound.protection.outlook.com [104.47.70.105])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3sr6drgy1t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 31 Aug 2023 14:13:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NvTeqnJpRRd/m6OCm5UdttrabrKteLPj8S5uuNgof41Abc+UMZJOmYEnvRqZhuZnuYlDy+G1ULpucS8BAY1ORcxgIEOETY7JcSOZCH6/OsPfaVXVbnq5MBPfH+bIrwLzc7oOh+sqJy70ZZt7vRHJyTVEjgz6QLYuNYdRrdNW35XTDhQWAi4uykhtsXWScpEJTMLk9oD5diVs+wAJnlYT4/pYUd1/4s7dWPKXeXj4wVnqotEHk3L+pIPMhosCFKNCg47YL+pZ09hS5oIIcMYd+LCNHwHPiJGo1nz0fvKqYToRHsj5rql/ZW/CayVCN6wm/pl6tnQ39lVIbjynluNFHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KkPrlGzsOuu4kbCLoe/jyJGTHzfMFQ8BSmF490n9suY=;
 b=iI0Z5aoNvEHBEEirqvXD76ydcIjODhuuCrqGbgj3sTO1EPWFUQFP37vbKcJQlDDjAvSgOOLJSfH/5/WpRAbzMoQ5L1csm7fNm3f192P+PdLLCM242uqxz4gUpCm3SGQHso/BcmDv4AP1dy8E+NAJL0okdmxKUueaLgvckn+Z5W8sGGkCcs0V+VhOz9syKiJGQh+L4BnN58QMeJfw0jsQi8TAg780UM8W4/EdnLoGg63+nLdAdbTNLd1MTXHcDf2KDypwbUjXth8G4tStRRM+z/NZ/yN+ZJvIbvvgxaFzJz1obPPDsVE5FfPWFvSlzbWj4M15LAxbEEqJbvleQtcJxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KkPrlGzsOuu4kbCLoe/jyJGTHzfMFQ8BSmF490n9suY=;
 b=woGmiYCbOgpt2sf6PWaWzoIq/CK8+yt4SnWWN5N7osrIoaYMJdELG9ogm00CDVHGpeh7LGpdoU9us8BLOxcFmRr/8rVB2eBnKuE4wtofYu1vUSxLtqrI1cio+IWI0kTYqPwHLrl6/aPAKjK7X+XivMp/1SFEmIV+/vAVAOmET0s=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SA0PR10MB6427.namprd10.prod.outlook.com (2603:10b6:806:2c0::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.35; Thu, 31 Aug
 2023 14:13:41 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e%6]) with mapi id 15.20.6745.022; Thu, 31 Aug 2023
 14:13:41 +0000
Date:   Thu, 31 Aug 2023 10:13:38 -0400
From:   Chuck Lever <chuck.lever@oracle.com>
To:     Dai Ngo <dai.ngo@oracle.com>
Cc:     jlayton@kernel.org, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 2/2] NFSD: add trace points to track server copy progress
Message-ID: <ZPCgEuGnjo0VpGK4@tissot.1015granger.net>
References: <1693439219-19467-1-git-send-email-dai.ngo@oracle.com>
 <1693439219-19467-2-git-send-email-dai.ngo@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1693439219-19467-2-git-send-email-dai.ngo@oracle.com>
X-ClientProxiedBy: CH2PR12CA0006.namprd12.prod.outlook.com
 (2603:10b6:610:57::16) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SA0PR10MB6427:EE_
X-MS-Office365-Filtering-Correlation-Id: e912ee3e-4ae0-4553-7c5c-08dbaa2c7ab0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lYNpEQXDNe8YX+i66SWIUPFZkECHf1mKr1ngqHLK2vVjjFkJHn7ylfeLHGM2MxCIjfy66wCk3vHqbVEehcdkAWWhvIP2RQv3DD+KbX9dJZ9/7vHtcAg7EUjBZOxoGeKR+OorfoNaUAnBmqY2GktAiZWv9fh9PolfAsj6Wp14T98gDGhHgX3QKaTOVNqQJg8ZQFK1GX3T5t9fJtPP4aYnmVUsghbJmqzTZRjE9oIDrDPEl5jGquXz1HQ7lytTA736PqdBvm8vzoAqOBMIUSv7jFaXRwfvfktbL9NjYwHx/WUvDuzt/0ScyvKS8g/DkDZdfatD7fdJNOEzElL1nvlMeDQEZ+HCeI44jt9UVEv+ZqOV7fUoLQC5jIIWXFB8+IcwpuU18xNyKxOyHdG8HeXUSt27/AeQEK6BJhzO1SFpFwdJuxYeo0KkSMEYAIKt/JLE3yIQ75fSk9Cym0w/3pnhU0XwVIlnMjOju5TX0h07+2LhHS/EyBI3uLFe2AaCg0/e3nlLr/47EZiEOhIB1xwElVLSBZxvNoaF4V/RmOT6sxyPF8m05aUQab1OKb05WueH
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(376002)(136003)(346002)(366004)(451199024)(1800799009)(186009)(6512007)(9686003)(38100700002)(6636002)(41300700001)(316002)(5660300002)(4326008)(6862004)(83380400001)(44832011)(86362001)(26005)(8676002)(2906002)(8936002)(6666004)(66556008)(6506007)(6486002)(66476007)(478600001)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+mdwhFKY11Mh0qNJT8OJYaT+6Hk8Ql4zFLG/uHCJrAi40KCHvWjXt5WigWbf?=
 =?us-ascii?Q?KApNMftEdOvNmRlcfDzol9WT2ArgJgkxQI5p3V5SxIlcTG9/eBp2EYguRA1C?=
 =?us-ascii?Q?Y65gvaw0vHp1F3OnEx6DFWMpeHBCec2VSG+SmOT83cgp0p919RTYTnESGuCO?=
 =?us-ascii?Q?+sUSq0zMqxaTtxHofZcXJVjtL5pS+7lXthVRqQiNbsxOVNPtvg4JqMznj/7g?=
 =?us-ascii?Q?AWEOqjdmXfNMnvFhlS+2kjHaFW13T77kB1Snh9SSBhylfQeaxsRyAGVzEVvU?=
 =?us-ascii?Q?55iDha+8St5z9XCd/5EVxpSPnCGLJH1SC+X3mv4+Q3S1lwKIBvP9edRzAcRa?=
 =?us-ascii?Q?4ipBOzwmy6G9g7spaUtatx/p38pPTwBWzj7YdzeX1kecB0K/Z7roHeSZG16m?=
 =?us-ascii?Q?IpibnsWZUypgFIcJc23/n4crmNNG5Eqt4zfuEgp2vy1IP9RlefAINyFrAJuI?=
 =?us-ascii?Q?2GPNKESjVJsr2ucExNVF4ZRqCVD1rv3D1THMmcqsl2ordsbn9qMVxPjUybEx?=
 =?us-ascii?Q?P4buZ7RqtTPOlC1bB+rqvA+Ta/umOLOgLuHGa7xax4EcWE/oNrw3wnVz4I2Q?=
 =?us-ascii?Q?pj4uTRYrMfqsx+8ZozrGeSdzBwk4BtmZ1blEWSV2FY8JHpbp/M0JEYz9KZBR?=
 =?us-ascii?Q?yvAYcLK9tDUMmZ1CfZQ3blQGhEjnInEQBnXB/1MATo/40kE+fBBhdPfyIhhp?=
 =?us-ascii?Q?8dvWOQ3XXqd0G8kxw69tDfUTi6ofut0704S9ynO2wesq1Rz9uA/aN3ObQuyp?=
 =?us-ascii?Q?Xd47WPZO59leq11D9yWdiybM/90xZo5Jmh9CtMLxECn6qIauobBIyvK+YZYd?=
 =?us-ascii?Q?BnaCmRLpIVnE+U8TjnEE9czAtPjn7bhN/k6wsAHKpOb3jWje6XUQIVpqRQg+?=
 =?us-ascii?Q?PJpjn1YhiUCABz4du+CKnDL8V/DddPOinQsBslP+JbJZhnBtXX3WKgfefvHy?=
 =?us-ascii?Q?ySrZuUBnApjO9hPHs4BSYPnjiPm/KrN1NOm61yS/bKPyZw5J+fFt9xKhBtfP?=
 =?us-ascii?Q?Wm8HS6axKyH7A2yCkOnUe/ni8YHfEW+yMIlmO2RyU7p/jejQGwnZ+Xu80aKx?=
 =?us-ascii?Q?26WzaxxqgNH0g60cra/6AMb4AjMr2tAtsubCJoyQHhARVKjllROJypzO9PiK?=
 =?us-ascii?Q?fCH8bbtcSzuHb8aZ+d09afeJNs6JF63Nr4tFvyIgmjQHI6NaZh37GYbSnxsR?=
 =?us-ascii?Q?u6zqBhPiBxkwpfO7Kl2LJNrspbF1zf+7gniKqv0mwXSi+CBg5X5w4JYp/HDS?=
 =?us-ascii?Q?bf1h8z8G0MhJ/YgxnViqmQxl+e/vUx0E8MpbaFFKtAutkXqXrrgzMRC+3UTn?=
 =?us-ascii?Q?bz2kQ9VVdGrOUj9b5ijWJWueJbeZdmc7JOww24gMuk/IGJzPx1xqxGV24A9l?=
 =?us-ascii?Q?8UISLHTz8qqkZNiIGGzllEltP1nikg4y5s6RYzkFXwgRGHD2Q6XIxwmFdDVg?=
 =?us-ascii?Q?LmJZJ6WlFCCoyMHUhlwZmeL5tNBvnOkuWtxAs+9cSJzqhbVIU5A3lql8WwNm?=
 =?us-ascii?Q?bEhI5p3BJ0zSiWslzodBIAeKmts3jVkw61T2BYBSqQcFWwhHqv117fPacPSM?=
 =?us-ascii?Q?EgCeUzgv0+G6+FJ6coP68o8l/7XaVfJuasQDkBXOifGIdm+x9Q8NOHtBMeV6?=
 =?us-ascii?Q?MQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: VC3C9LzOVOWodHm0IAeWyI0Fv0BebX90iYoAT+1P8a2m694JSn9MaaR0Zwp1xxthWFkGKwAeUhNocVjzYjLRDfmCwacHPqSo/ZbQFNvXL8MJrJQLgeRcPXIZq3qujpvj4kCh68G61RjCDjHyR2vPCmr6F5YO8kFZAuDlcGH2R3pjxI+JJuBwcHjbs1zZciXaodlLqFiAPsiIDVI21/CHcrdKeS6qwfYRxSOQBTsmtXp6v7hjZOOPQYPCyXXvw3Lw+LqUWb1RUcsw46PDx5OmLJ/FYR7jf3idKNIisNsAEc+TwpjWUGpqc+e/eWhSBYvZ+QQkwsXim+X8skpjV8Q6cMeVgXMva+aoQ5iQZ7tEfzbOomJYGjySrA0gX0Gm5LR/5tTIHLoHtXiL5vM5nMPDebZtfko9fEhc7LHIx9iCUJPVE6dPH660zNcWnOagGbIdn7O+IQnjCW7hCRcwx/Od4mzUbDjM32nle43ntV9q5wj5n83NSwoNqgNpOfYyyJMKOiwBLyjnT78WiGyN12qdGECzIK1YPAarb7y44ZrL5dl3hQ3HYjXHTNHMdI9K6CKjHXgrowS7eDetC8S/ClpipqfxhMsb6d39GmItuWqP3GL4rGzcEjJeAHkbk19ae2MSqrNj3USJz87tXpouQx8mMEg+RIYnE0QNVrIGlDjGFWQ3PIFFQEsVH8UvOvxc6EgbLRTYKWBec6pUpA8cIB/FxnQWrcIL31NrX1AX9xS+S9iFp/uX7vorolkGDR/kspZMSAUwOvPocm1v43BtGN9bTzl9DgBGRF5yQiN6iA0LSo4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e912ee3e-4ae0-4553-7c5c-08dbaa2c7ab0
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2023 14:13:41.7774
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z927ig5Lr4EVemgIkHV8PU8AM+Sr5oWWmVK1dpSVtTR1LfKGTmSKlJzAnJKzNpXvM4X8zk+d/59OlYLHxsglEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR10MB6427
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-31_12,2023-08-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 adultscore=0 phishscore=0 spamscore=0 mlxlogscore=999 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308310127
X-Proofpoint-ORIG-GUID: skGfO8nw2SyvXR2KVomw8evBIENG9EQv
X-Proofpoint-GUID: skGfO8nw2SyvXR2KVomw8evBIENG9EQv
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Aug 30, 2023 at 04:46:59PM -0700, Dai Ngo wrote:
> Add trace points on destination server to track inter and intra
> server copy operations.
> 
> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
> ---
>  fs/nfsd/nfs4proc.c | 12 +++++--
>  fs/nfsd/trace.h    | 89 ++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 99 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> index 62f6aba6140b..9a780559073f 100644
> --- a/fs/nfsd/nfs4proc.c
> +++ b/fs/nfsd/nfs4proc.c
> @@ -1760,6 +1760,7 @@ static int nfsd4_do_async_copy(void *data)
>  	struct nfsd4_copy *copy = (struct nfsd4_copy *)data;
>  	__be32 nfserr;
>  
> +	trace_nfsd4_copy_do_async(copy);

Nice addition to our observability of COPY operations!

Only comment is we have no other tracepoints named "nfsd4_yada" so
I feel it would be better if these were all renamed "nfsd_yada".


>  	if (nfsd4_ssc_is_inter(copy)) {
>  		struct file *filp;
>  
> @@ -1800,17 +1801,23 @@ nfsd4_copy(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>  
>  	copy->cp_clp = cstate->clp;
>  	if (nfsd4_ssc_is_inter(copy)) {
> +		trace_nfsd4_copy_inter(copy);
>  		if (!inter_copy_offload_enable || nfsd4_copy_is_sync(copy)) {
>  			status = nfserr_notsupp;
>  			goto out;
>  		}
>  		status = nfsd4_setup_inter_ssc(rqstp, cstate, copy);
> -		if (status)
> +		if (status) {
> +			trace_nfsd4_copy_done(copy, status);
>  			return nfserr_offload_denied;
> +		}
>  	} else {
> +		trace_nfsd4_copy_intra(copy);
>  		status = nfsd4_setup_intra_ssc(rqstp, cstate, copy);
> -		if (status)
> +		if (status) {
> +			trace_nfsd4_copy_done(copy, status);
>  			return status;
> +		}
>  	}
>  
>  	memcpy(&copy->fh, &cstate->current_fh.fh_handle,
> @@ -1847,6 +1854,7 @@ nfsd4_copy(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>  				       copy->nf_dst->nf_file, true);
>  	}
>  out:
> +	trace_nfsd4_copy_done(copy, status);
>  	release_copy_files(copy);
>  	return status;
>  out_err:
> diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
> index 803904348871..6256a77c95c9 100644
> --- a/fs/nfsd/trace.h
> +++ b/fs/nfsd/trace.h
> @@ -1863,6 +1863,95 @@ TRACE_EVENT(nfsd_end_grace,
>  	)
>  );
>  
> +#ifdef CONFIG_NFS_V4_2
> +DECLARE_EVENT_CLASS(nfsd4_copy_class,
> +	TP_PROTO(
> +		const struct nfsd4_copy *copy
> +	),
> +	TP_ARGS(copy),
> +	TP_STRUCT__entry(
> +		__field(bool, intra)
> +		__field(bool, async)
> +		__field(u32, src_cl_boot)
> +		__field(u32, src_cl_id)
> +		__field(u32, src_so_id)
> +		__field(u32, src_si_generation)
> +		__field(u32, dst_cl_boot)
> +		__field(u32, dst_cl_id)
> +		__field(u32, dst_so_id)
> +		__field(u32, dst_si_generation)
> +		__field(u64, src_cp_pos)
> +		__field(u64, dst_cp_pos)
> +		__field(u64, cp_count)
> +		__sockaddr(addr, sizeof(struct sockaddr_in6))
> +	),
> +	TP_fast_assign(
> +		const stateid_t *src_stp = &copy->cp_src_stateid;
> +		const stateid_t *dst_stp = &copy->cp_dst_stateid;
> +
> +		__entry->intra = test_bit(NFSD4_COPY_F_INTRA, &copy->cp_flags);
> +		__entry->async = !test_bit(NFSD4_COPY_F_SYNCHRONOUS, &copy->cp_flags);
> +		__entry->src_cl_boot = src_stp->si_opaque.so_clid.cl_boot;
> +		__entry->src_cl_id = src_stp->si_opaque.so_clid.cl_id;
> +		__entry->src_so_id = src_stp->si_opaque.so_id;
> +		__entry->src_si_generation = src_stp->si_generation;
> +		__entry->dst_cl_boot = dst_stp->si_opaque.so_clid.cl_boot;
> +		__entry->dst_cl_id = dst_stp->si_opaque.so_clid.cl_id;
> +		__entry->dst_so_id = dst_stp->si_opaque.so_id;
> +		__entry->dst_si_generation = dst_stp->si_generation;
> +		__entry->src_cp_pos = copy->cp_src_pos;
> +		__entry->dst_cp_pos = copy->cp_dst_pos;
> +		__entry->cp_count = copy->cp_count;
> +		__assign_sockaddr(addr, &copy->cp_clp->cl_addr,
> +				sizeof(struct sockaddr_in6));
> +	),
> +	TP_printk("client=%pISpc intra=%d async=%d "
> +		"src_stateid[si_generation:0x%x cl_boot:0x%x cl_id:0x%x so_id:0x%x] "
> +		"dst_stateid[si_generation:0x%x cl_boot:0x%x cl_id:0x%x so_id:0x%x] "
> +		"cp_src_pos=%llu cp_dst_pos=%llu cp_count=%llu",
> +		__get_sockaddr(addr), __entry->intra, __entry->async,
> +		__entry->src_si_generation, __entry->src_cl_boot,
> +		__entry->src_cl_id, __entry->src_so_id,
> +		__entry->dst_si_generation, __entry->dst_cl_boot,
> +		__entry->dst_cl_id, __entry->dst_so_id,
> +		__entry->src_cp_pos, __entry->dst_cp_pos, __entry->cp_count
> +	)
> +);
> +
> +#define DEFINE_COPY_EVENT(name)				\
> +DEFINE_EVENT(nfsd4_copy_class, nfsd4_copy_##name,	\
> +	TP_PROTO(const struct nfsd4_copy *copy),	\
> +	TP_ARGS(copy))
> +
> +DEFINE_COPY_EVENT(inter);
> +DEFINE_COPY_EVENT(intra);
> +DEFINE_COPY_EVENT(do_async);
> +
> +TRACE_EVENT(nfsd4_copy_done,
> +	TP_PROTO(
> +		const struct nfsd4_copy *copy,
> +		__be32 status
> +	),
> +	TP_ARGS(copy, status),
> +	TP_STRUCT__entry(
> +		__field(int, status)
> +		__field(bool, intra)
> +		__field(bool, async)
> +		__sockaddr(addr, sizeof(struct sockaddr_in6))
> +	),
> +	TP_fast_assign(
> +		__entry->status = be32_to_cpu(status);
> +		__entry->intra = test_bit(NFSD4_COPY_F_INTRA, &copy->cp_flags);
> +		__entry->async = !test_bit(NFSD4_COPY_F_SYNCHRONOUS, &copy->cp_flags);
> +		__assign_sockaddr(addr, &copy->cp_clp->cl_addr,
> +				sizeof(struct sockaddr_in6));
> +	),
> +	TP_printk("addr=%pISpc status=%d intra=%d async=%d ",
> +		__get_sockaddr(addr), __entry->status, __entry->intra, __entry->async
> +	)
> +);
> +#endif	/* CONFIG_NFS_V4_2 */
> +
>  #endif /* _NFSD_TRACE_H */
>  
>  #undef TRACE_INCLUDE_PATH
> -- 
> 2.39.3
> 

-- 
Chuck Lever
