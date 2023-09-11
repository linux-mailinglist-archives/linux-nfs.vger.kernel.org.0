Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E3AC79B7C5
	for <lists+linux-nfs@lfdr.de>; Tue, 12 Sep 2023 02:07:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236065AbjIKV7t (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 11 Sep 2023 17:59:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244374AbjIKUO0 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 11 Sep 2023 16:14:26 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30902185
        for <linux-nfs@vger.kernel.org>; Mon, 11 Sep 2023 13:14:22 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38BJf38k015114;
        Mon, 11 Sep 2023 20:14:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=PmAPP2JgbpGFhVScBPkjEaZFfEMgrC3YIiNz1WsDPvY=;
 b=eKyovlQg7BV+fAodsDzuwtzAeTBp0idtrn1cbZlO1GTzRgz7jdSRdV18DB2FWsJ5bY6q
 6VX6qyG43H2NdEkX4OrKB0OMrCtt7zvvmell7dOhJrKiMqxJAtGFF2JfLyZgQEbd6QbL
 XTnsdzCw+5UC2YUKtcXp684OpRIFhkp93TvVqaMYVaxYA4yYJaKCi53alG08ERskNHEz
 s/1je13GusDM3bWlgGb3yR3pcUsVdytLvBhGfcmZLGb9DjqE56frmIFYRsjmJWMhqWRT
 FM2EtD63tsh//P+5ofwSydaeQa7AQ0TO78ZEW+35alpG9xoXyrtYY/KRH2GaBEpNg/uJ ew== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t1hy8aebh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Sep 2023 20:14:18 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38BIqARY002296;
        Mon, 11 Sep 2023 20:14:16 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3t0f5b05tn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Sep 2023 20:14:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J6Ig9A31wHv2LpQa2p6ZMuo4/YRgx88kEuYjaZkPi9hq4OEEgYkX2L7mATe9F1wQ9BYninsq6QkD03mdKt7EL0BUcG8KRrHi6ARdYQ+/ETkpAcUx0c2Yk0xkxBNkPofoV1PIXMqLHmlFiSAsyiVGFe46UGyn6VwoBDtXmKBIp6qrHG1HlbpPdOeZkElK9ftiL1VY6ZNxc/x7rwrEq4JgPYcEh0dX5OC/jZwEemZn079YGYY4wH4IQF0UT6/qZjMlrZugovpYavgcvnHebrnrgrkxjsgXYZQr2qjxfr54VSA+9VRnojMAKhAgZB2MkWQQSnWahackcw1Q/AczJENemw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PmAPP2JgbpGFhVScBPkjEaZFfEMgrC3YIiNz1WsDPvY=;
 b=m8tgaOZ7hlNxNvPfjGqU/zyexrZ/0qa0HDjh0/WwUSwzRESzjoHbVixMsgLumhDQDF4XA+oKUstNU+mP4LEzNcvusaGhq/Xyr395VpBmmeLATcdlnghd1VD60xMmhuuHqHSL+C49C4L+r4DhwYku7EwuU+y9E3luHIvzS4WosSysRb5SJSArxOJig5xXhQiZtnRE6JjOK2S/SmFwSDqIGJmBjCF3uV4MwZIUiUS+WCKpqRkypBgZilkUfNA5dIqvmlgec76e8jxRrB3vYsXGRvXt1eNbNuBzQruLSjtOVNTPzE6vWeShZLGi1ZpBMROIq0EBUPfRhffesR1RSq+hlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PmAPP2JgbpGFhVScBPkjEaZFfEMgrC3YIiNz1WsDPvY=;
 b=mDOnncgkE5ry1Z8Tpk9YsJIYCAhhH4R1ULhhAH3fpQtuTw0rfTypAsljIX216BDPURYRYW//TFybMh8cTGUpRBHBLiRg3HySvvx7+khQkmcnqwjFOtzscWSq+vELJUDE0wXQ0S+F8uF/mBsi1xUgLoXZAKW/+kNVQmfujCvilLQ=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CY5PR10MB5962.namprd10.prod.outlook.com (2603:10b6:930:2d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30; Mon, 11 Sep
 2023 20:14:14 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e%6]) with mapi id 15.20.6768.029; Mon, 11 Sep 2023
 20:14:14 +0000
Date:   Mon, 11 Sep 2023 16:14:11 -0400
From:   Chuck Lever <chuck.lever@oracle.com>
To:     trondmy@gmail.com
Cc:     linux-nfs@vger.kernel.org
Subject: Re: [PATCH] nfsd: Don't reset the write verifier on a commit EAGAIN
Message-ID: <ZP91EwHCt0/c0jvJ@tissot.1015granger.net>
References: <20230911184357.11739-1-trond.myklebust@hammerspace.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230911184357.11739-1-trond.myklebust@hammerspace.com>
X-ClientProxiedBy: CH0PR03CA0412.namprd03.prod.outlook.com
 (2603:10b6:610:11b::24) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CY5PR10MB5962:EE_
X-MS-Office365-Filtering-Correlation-Id: 655d86c1-8e5e-4a1e-aa35-08dbb303ab6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Otkj++eDPPPCi93TwKsDhkuWu7v4egNEAzACIJ1gdHY6JrEtZ8M1HZZ6IVX6s7s09KeRWMNsvITW9HI5NcseEbQ2EX2zHum8TlP0ip1YadIAxleuHynu6KKNLLkk4K6PO6IQBMW74bcsvB3V4aqeAeOBPHDmh9HWujNy/0LMIcH6kNQIfX+LtyVFCOfYmSqGJk0RvpIZTDOQ0tG/NKGMtbxJweNVyQZeoUahijqB1dbCt6HgVbZA9B2zkojcnTWga/plSqZ0+iiaGcgUMouc8m3MLMxfdBx/pPBsAdvWwlNdGKs0jRr2YK2prXsStBFz3dXvMxjAcH75x10tA4b1mU53EOZlM7edUm+erTawSaKH5dmZXVBvlpDmLH41I7r7IpdF6JKucT0TiAm7P1A7OJSKjKVaZH8ILfnsLAZ3Ha7eZ6eOrsYcY1rU2+rAJkG0MPyBxMURlqUJoJxc0/BJqqa7EeZdLy3qZDRaH8KfpQVmpmak+im1PHAuwFl2SAFB8C7h55hpfD7/fFmk+d7AB9vrd5D7OFahNBwtjLBD74rBtK5iC97hGyW0eQ3eHu9y
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(39860400002)(366004)(396003)(376002)(186009)(451199024)(1800799009)(9686003)(6506007)(6486002)(6666004)(83380400001)(6512007)(66946007)(478600001)(41300700001)(66556008)(2906002)(6916009)(66476007)(44832011)(8676002)(316002)(5660300002)(26005)(8936002)(86362001)(4326008)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Q5yOVINe+9wIRlSR1ScMRDPxPT4ivEsDmQHO2gwRsWTWEI/azzlV1aWpseco?=
 =?us-ascii?Q?A/PMHG+U6uF2Px6fTPf8r+G7tRvWFtfL5gbkZVsWlLMmkC/f0eyeFN5/FRUH?=
 =?us-ascii?Q?WmH9ke6YxZ+Daf7ax7nO6GCpdXuqhAyns9y5pjxpLvP2V4WOtHM9JTkjipzS?=
 =?us-ascii?Q?PLSrei+Q39VyiHGathgzwT56uJ47bGwycJqIkZmXZfk8GhuFKfObZo340Nbb?=
 =?us-ascii?Q?KUdCTnvjjQjS6CEXjgnPxLxpfIB4FQw60LWKecnt3wyPmGcNwcR4Yb3wICdE?=
 =?us-ascii?Q?cKoJDuTxIWNxkhEciNw81M4EALCaPTC6WxWQuPEm394wNN2G17RyCErw8fsU?=
 =?us-ascii?Q?5iiI39/UQpNpURBatWnrGHmPOaAbK0mr+b8+aKn2FA7mzyn5xyo19CeaprVe?=
 =?us-ascii?Q?BtmXMxDFA69BNT9USY3SEPbYtNA1IIaQNGgMKF7t/k6kl8M9Aw3NH3EFGE8b?=
 =?us-ascii?Q?qAzXWuvGVSwCjo4UyEa1yMr++4KR7riiFPrtldul3VUQrDsGcX/SH7osG+sE?=
 =?us-ascii?Q?ut7JsWRZhQP4OMFqkJ692ioRdm1ksB5mEHw6YlZyKNhgAX+SCS30E1FloHUl?=
 =?us-ascii?Q?5MZKveLhZ9GF+Sowahr6CEJx6x7QONV+BNckao0YFdE946Aq1uTKYZiRgzkX?=
 =?us-ascii?Q?TNfimMH0T6PDuUiORBUMn2NtsJqY21fO3w49t1wLq5FgBiGysvJIh5KPrYjO?=
 =?us-ascii?Q?loxntjuTZfDXbuapeeduv9oIJ+s7UU/96ynHOJJTbF3BtbtoQvlL1dZ1eOCS?=
 =?us-ascii?Q?NyRBSgqlPBfZ3Nr4QhbVyefXuJRG9qoLuD1+yGLxSam+dGLFjpGgisHupB27?=
 =?us-ascii?Q?QOK/KcumE47w2rJ5bRiVxZOoi75B3PF3YWdQIUO2rUJSFHyAyfvMKQtp+3mq?=
 =?us-ascii?Q?j8sZdHFbWROnYFcK9aNrfmCJEm1n3HQGmS/AlcmlAOZZ5NxHbRhrC8E6zR/V?=
 =?us-ascii?Q?MpseI/gkKCrPJ7e4QtxR0q1po5K2c4DxQnZiGZp4sU4Ml9HEV+LyOi2jgmn3?=
 =?us-ascii?Q?yIgA0e7yXBP00t4eNTKS7JKBR1DjyIOtQw/DO8DWUYF77CrZoUiwI0p6lwgp?=
 =?us-ascii?Q?GFzVAps7ZRLrArsoH8Wxl9akIww5ejJMX4bcHnTTH+DdpHTeIfewOkaF8MkA?=
 =?us-ascii?Q?4guUp0UgUwwi3+YEs4m7j70n+Lb9k5YnYQLChDat+XBcCbaTk8uNcwEueWDU?=
 =?us-ascii?Q?7Y6Y/jnLaFEsCPraEUGu//S9qyCZ0tl9ap6Jg+dLSeSDnCxLqaOlHNqfUZE2?=
 =?us-ascii?Q?NQXKDUnX3FuorzgX2LUqcUEQEh3sQUsF8QxrDLq/AkaH7XdAihLP4PPVldnm?=
 =?us-ascii?Q?56Duv+06OzbtYFLyexDvfP7aH2X52IrsdmvuLdf8Gdzl7SOUQolwGie0jQs6?=
 =?us-ascii?Q?HHCzTu2zlTwhcNIoLk5+ITqgLlEZjTS62R1yO3CIuE2WSvfFwY8cCNDMPVdZ?=
 =?us-ascii?Q?ZB7cYnOE1tN00EO/fpH0ZT1tw9RQIXGuedqOeMAKpeS1YUSIqYJS0AblkYlv?=
 =?us-ascii?Q?I4yPB83Dc2KiUkEib94r+8IyKUv+hOpuQ3JUeVcnV7bStR9CCKhzrdP51POr?=
 =?us-ascii?Q?zHC6foZFAbxFd07Mj3YDTwecI+FoGU+nk7Gpc4DoTf1/CQ3cuMFa1K3YdvC1?=
 =?us-ascii?Q?yQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: +EWdYKzsLfYOp0o41nes4th6kQTwtu1emdks0lClamYBVvkqiQ1XjmdfhfNw68p+3AkK/Ghjs50Fh1uZMOiGYmZKmUeOc4IBhBRlhj4wWE/tsnRJoYg7tLt8w8hr8oaL9KMIxvnRIwlfNRHTCO0ogWIpVUFAR2G/YpgXlgYL1mJDaHob1Thz1OBidZtU14XqCL9D26ffwkyeQt+ZOzpa4RiRk9gWgiXP57CxY2XWhVBjEi5H7DAJxC555YsshCD/XTcRyMAxLSXjTlB6D78Pwgr8IZpECCZVdY+h97asDpv/GqR6gKtrdFGs8Xd1trugSJ/0FG3dlXtcdfnjpyS3i+hR3O1tKz4+UPBH+/c/cC8TpbLqO7T3B/ULGmRaPEGsESfOT2jCPDFC6xmMDFJViSN843eEwohR6kB+kObXo62ZnbHyzMcslaNVLDqMVBXz66mag6sTPxbtf+CNEd6zdTEHT6io3rS16V48RGl8huEXuA9a3U0MiB/FvIo5Znso4Dm9HdaYVnGAFoaImTi3hwLdM50v44dl3FZYOUP24pzmxO/hBBVK/IX7WK/LyCF0vKk7tU5HgDh2xpDw1lOh4nKUpPzGetGIUmOZYVgMAFYZZyv+lNi/00VuaI4KXkM+x+5TTCEZUtbl921pglvUD85TZZ6pD7ydUVC11rR3PBKIWkfx9GcuVambIdI+wDuLuHYP1ALnvWtQcKUQqiA8Kyg4Tg36R+iYsbQgpN3QTs9M8e6kVlVkwFcnZIOCGPmxKmFKG/rN3DrNppFHzmRJN2JX5pdBc4jwbT93vvdymic=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 655d86c1-8e5e-4a1e-aa35-08dbb303ab6a
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2023 20:14:14.6498
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4IplOL81e/RLOHqkVM4IBlrT2NLLZtYQaDkgD0tAAGHWU6JseRZmyuw+MJNwP6dImfuRM5MKTsmtGz5tmPxeEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB5962
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-11_16,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 bulkscore=0
 adultscore=0 phishscore=0 spamscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309110186
X-Proofpoint-GUID: oGN77LdFLlhBw66S0o5msa2Qg3j67SBo
X-Proofpoint-ORIG-GUID: oGN77LdFLlhBw66S0o5msa2Qg3j67SBo
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Sep 11, 2023 at 02:43:57PM -0400, trondmy@gmail.com wrote:
> From: Trond Myklebust <trond.myklebust@hammerspace.com>
> 
> If fsync() is returning EAGAIN, then we can assume that the filesystem
> being exported is something like NFS with the 'softerr' mount option
> enabled, and that it is just asking us to replay the fsync() operation
> at a later date.
> If we see an ESTALE, then ditto: the file is gone, so there is no danger
> of losing the error.
> For those cases, do not reset the write verifier.

Out of interest, what's the hazard in a write verifier change in
these cases? There could be a slight performance penalty, I imagine,
but how frequently does this happen?

One more below.


> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> ---
>  fs/nfsd/vfs.c | 29 +++++++++++++++++++----------
>  1 file changed, 19 insertions(+), 10 deletions(-)
> 
> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index 98fa4fd0556d..31daf9f63572 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -337,6 +337,20 @@ nfsd_lookup(struct svc_rqst *rqstp, struct svc_fh *fhp, const char *name,
>  	return err;
>  }
>  
> +static void
> +commit_reset_write_verifier(struct nfsd_net *nn, struct svc_rqst *rqstp,
> +			    int err)
> +{
> +	switch (err) {
> +	case -EAGAIN:
> +	case -ESTALE:
> +		break;
> +	default:
> +		nfsd_reset_write_verifier(nn);
> +		trace_nfsd_writeverf_reset(nn, rqstp, err);
> +	}
> +}
> +
>  /*
>   * Commit metadata changes to stable storage.
>   */
> @@ -647,8 +661,7 @@ __be32 nfsd4_clone_file_range(struct svc_rqst *rqstp,
>  					&nfsd4_get_cstate(rqstp)->current_fh,
>  					dst_pos,
>  					count, status);
> -			nfsd_reset_write_verifier(nn);
> -			trace_nfsd_writeverf_reset(nn, rqstp, status);
> +			commit_reset_write_verifier(nn, rqstp, status);
>  			ret = nfserrno(status);
>  		}
>  	}
> @@ -1170,8 +1183,7 @@ nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh *fhp, struct nfsd_file *nf,
>  	host_err = vfs_iter_write(file, &iter, &pos, flags);
>  	file_end_write(file);
>  	if (host_err < 0) {
> -		nfsd_reset_write_verifier(nn);
> -		trace_nfsd_writeverf_reset(nn, rqstp, host_err);
> +		commit_reset_write_verifier(nn, rqstp, host_err);

Can generic_file_write_iter() or its brethren return STALE or AGAIN
before they get to the generic_write_sync() call ?


>  		goto out_nfserr;
>  	}
>  	*cnt = host_err;
> @@ -1183,10 +1195,8 @@ nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh *fhp, struct nfsd_file *nf,
>  
>  	if (stable && use_wgather) {
>  		host_err = wait_for_concurrent_writes(file);
> -		if (host_err < 0) {
> -			nfsd_reset_write_verifier(nn);
> -			trace_nfsd_writeverf_reset(nn, rqstp, host_err);
> -		}
> +		if (host_err < 0)
> +			commit_reset_write_verifier(nn, rqstp, host_err);
>  	}
>  
>  out_nfserr:
> @@ -1329,8 +1339,7 @@ nfsd_commit(struct svc_rqst *rqstp, struct svc_fh *fhp, struct nfsd_file *nf,
>  			err = nfserr_notsupp;
>  			break;
>  		default:
> -			nfsd_reset_write_verifier(nn);
> -			trace_nfsd_writeverf_reset(nn, rqstp, err2);
> +			commit_reset_write_verifier(nn, rqstp, err2);
>  			err = nfserrno(err2);
>  		}
>  	} else
> -- 
> 2.41.0
> 

-- 
Chuck Lever
