Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70452769967
	for <lists+linux-nfs@lfdr.de>; Mon, 31 Jul 2023 16:22:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232688AbjGaOWr (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 31 Jul 2023 10:22:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232785AbjGaOW2 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 31 Jul 2023 10:22:28 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D470E65
        for <linux-nfs@vger.kernel.org>; Mon, 31 Jul 2023 07:22:18 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36VDTGAj014514;
        Mon, 31 Jul 2023 14:22:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=3ZvfYriqZmfZZ2Owvtvu+j3AeDQ8sFFgYIlpPd0PXc4=;
 b=JzsGSqTp6S+b/XA3oj+Plsh9EH25IEaqbY6kL8NOzkok0rvAdVUw/WwNPetkmXHiYBFs
 5SNICRZ3OIfk7Hnzj01nTt0cUgyySKIn16oRSI4C0L2Mr4QB3cLJlooG3zA5zegXKj+6
 I/bZqjKAhKFx4FubHpczjNZzXiRDgXzOiW21LTTIGhE1CS6hNYMmV7Jep+iyO66p6Da7
 BkW9G030xoQ2PdJiL8Bvtz7fLIxWpBE9+qgIc83HZ8wcCMAzM+ErB+NQGTh6neYXigJn
 DeL0UUIu/mWZ/5AGTlB+MnP7FmUKJEWEorr+flsU8lWavzN1AsUaKzncU79UPnGiACNZ VA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s4s6e2q7f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 31 Jul 2023 14:22:12 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36VDUGM9000930;
        Mon, 31 Jul 2023 14:22:12 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2108.outbound.protection.outlook.com [104.47.55.108])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3s4s74ntut-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 31 Jul 2023 14:22:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kUr7XH47xFkX6FZx7qSCwIvJZ5FBmP7SomrpwbVhMv/TNwqI3tjVkAACfsy2xqY4oXcYUcpsNW+kB2qILphmGlTzKtIWjDKyMciqXb9LkvWs/g2bjk+ukMf6dd8UQJjVejact6PG1XM6gbHE+cimzkN144qAPVpie858317ucRdbSsI3scGBv2/VOCIrZXQnDdy4L8J7ekjZ5n6fmF9uLcN+R3vdG8VZR9JBs19gKjGUfHwMyLVnnv5tJo6bDhi9KOadYYkTCu1pIxMf1n9+Zb89DfIdUxOFdsJlvshOS4F43sq2zYFK7X5YwOTa2jEavHuiiyGVUto12B+R43tdCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3ZvfYriqZmfZZ2Owvtvu+j3AeDQ8sFFgYIlpPd0PXc4=;
 b=LvvXcxeepMjhFTIU1kpILiIUPxrH9qx+ZK1oOkIiQwCZ2VoZXRsP+XnV/RE+1ym74KSJcn2PpQNiaMaBL8VqlgZqHrSun3yIC7zQLGtWDdeKC0EwO997NLvj32+/qEJ7YNLdsFrod66O27s3UfaeMfeoXGBP9x+wW9vLt31bGzJt65vbLrbInjYL2KoWcyqtJZiy5lDitLzpBv5k9PWDaXg4+It4NGqNzI8pEMuNNliyiCz0Ct1lXnSykHPN6CVXWnAd87O10zKvWMlf1wNfpMhqaqmiEqcCdqdpKyMViUIBgRODdymmFf0B3choKuNbEGBKqHWjdJRBjwBLjlRW0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3ZvfYriqZmfZZ2Owvtvu+j3AeDQ8sFFgYIlpPd0PXc4=;
 b=IfmB96wDrBm0cuG7aOQBKzJnWVw9fnj3rbyOy33ivhYh2hMIgumm/oKmSWrOm7CAxzAHpkmxwGV3az7NdZLL1ivGx/ogQf0t29tOPMx4/aHAIMX8sNjKomQBR6cxR0iXZ0r2ngbUS5oddpzSL9ko6fRCZs7rb7qz9AFuy3StxQE=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BY5PR10MB4161.namprd10.prod.outlook.com (2603:10b6:a03:213::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.43; Mon, 31 Jul
 2023 14:22:09 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e%6]) with mapi id 15.20.6631.043; Mon, 31 Jul 2023
 14:22:09 +0000
Date:   Mon, 31 Jul 2023 10:22:06 -0400
From:   Chuck Lever <chuck.lever@oracle.com>
To:     NeilBrown <neilb@suse.de>
Cc:     Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 03/12] FIXUP: SUNRPC: call svc_process() from svc_recv()
Message-ID: <ZMfDjrJKa29az2ba@tissot.1015granger.net>
References: <20230731064839.7729-1-neilb@suse.de>
 <20230731064839.7729-4-neilb@suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230731064839.7729-4-neilb@suse.de>
X-ClientProxiedBy: CH2PR18CA0040.namprd18.prod.outlook.com
 (2603:10b6:610:55::20) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|BY5PR10MB4161:EE_
X-MS-Office365-Filtering-Correlation-Id: 76de1222-81c4-43cd-cfe6-08db91d186a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +7Cm5r7/vaPMdjg+0g5R9DiiPTk8b/ZkX35JjHMZpnenGtrVGcwvkXr2F9oLZi1ddCC6avNqlVdBYeo9uZLeN1XX7FD/SLZ/q07VDeigExo2Rdd7jRbYsQcudTOurATKhRgi/4C2efDaSAiiI6Mf2gNE3hcIu2NfSOl2+J5TKccZQ7zEPRdjnXbT8KGXIt6BFJ93OzFz8lTwsYf2waJ5KugvMVLXhgP1tZQPKlSVO7pyr0jcqBD6qfWMndpNRmveS7cugt/174atUqEkkNsMGZEQV1VlnY4ueE2yCl04+mdglrdFRjDqYIKv+1+qn5fyKxJnBujMNh8olFMRqKoDr9DjC7QESmddkd2MHzbYwlOdpIEKCDQ12nTEHJiVsRj85n5WWYQ/QFYpMqYnVZK6CtMdr//Mnf1bFLJ++daIe0GJy1k5FTR+XBR/qOTmjlhz5Nf145LolLq7NYIUv5S43ijWStt/yrcr444J+VoQ+b4BAcebfSJwONAboan27psZKqXed7+5N5YXP1UfQsXHaom0VUehUuGVNb/MnhRM4ZXniQ6RnjLobeMWRC9yL6Sx
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(136003)(346002)(376002)(39860400002)(396003)(451199021)(38100700002)(86362001)(6512007)(9686003)(478600001)(6666004)(6486002)(186003)(26005)(6506007)(8936002)(8676002)(44832011)(5660300002)(4326008)(6916009)(66556008)(66946007)(66476007)(2906002)(41300700001)(4744005)(316002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0cSqGoOFtPwMh5aUYxFsmUOpKhRE53eQjsmSyzIfKF9AsbNHIN7hjPg/rzUE?=
 =?us-ascii?Q?I/Z2uC5uTMWp2XNS+Ocz+9TZ1noa2FRWw7M1d1GUGDcjKnnJoR0l5o0orK+E?=
 =?us-ascii?Q?eC8mo6tocguW/SV/0KeWZ1A00WNhfn1x69h5O6dUns591i08/KJfTE3Hx64d?=
 =?us-ascii?Q?t57Ph3gzGV7ATsz72IWDL3eEFTCngslazmRuTTXE1z2/Nqj6ES04XYVfQ+nm?=
 =?us-ascii?Q?wy9gBM0ZeMD41aPNXFpyEM8sD1z84Y44Ihm+mxPK8T/SaQAf0WrQ3XixCd2/?=
 =?us-ascii?Q?Pn2OgR8UfeFd+vzWEeSGDMj/Hca4rgEx4EsPN0nBogR1SyKg5/+4XtoEjGKJ?=
 =?us-ascii?Q?I9VRRZKpG3BQeK/MzD1aWYzICUpUgaICWC8smGmBswMadyCmW4luclO2IpEG?=
 =?us-ascii?Q?DlFfCygArw9E/UvXRVTCCQejR/mGOLnvfVIexr/qFK9X1wpBuT7E2nDpE7al?=
 =?us-ascii?Q?xAYzXgC6UM71h+Ed0joS9eF2TuKooKPvwIJ0TG7wxVA0ZmO1wJkgNNDSKTJo?=
 =?us-ascii?Q?Qr5rvwRW8BZnjV8yHwLuINXEmsoWJ0B0AMeX8KZvuvAJ/hTR36WhNlFYh+t4?=
 =?us-ascii?Q?ffDTsxOJsY9cZ7/CAlyRCdYrzUOujAntCrAJAJEqq1gt3ozBwqfciyOmZ61E?=
 =?us-ascii?Q?VKx2AIgzk3cWZsUg4YUtIx+D1xobR3yuaXuOr6dfrzPfJW2QDuGuDSMfHCmh?=
 =?us-ascii?Q?97a57Fqj3ExEhg86tzg5xdKPzy3OIa3yL1i3+Y/PaqApjFDcsv50fXAwc3B1?=
 =?us-ascii?Q?TyYDUWsj3e0tr4cid7eQC7cBWDkwxj0w22qnl4S8+Elo8ajU5i1DkiChUPlT?=
 =?us-ascii?Q?AR8g6MhtRB/dRFHyh7SJ5Nt0vnhgrAD/NvWRLyfvDo7b/NdE7EADFDwxPAfl?=
 =?us-ascii?Q?FnEukH6YZXQDGebNDHvV/W2n1yyKFcwerCeSLMb1JXJXahJ4BzIbRenly7Ud?=
 =?us-ascii?Q?vpHb8MOaEjPchaaLjbaP+/ss5nsvIoK+iaiIZ8Xwq/hWGjLXtCvgX3ZGvREB?=
 =?us-ascii?Q?GkcVw+gf1wwXeQlqgxjs2z8zH2tCJSfxnJYD7XOSODPrTJZOspaDAuCiCNCD?=
 =?us-ascii?Q?aOLe8/+Fa3qmKQAfb7enzh2Jcw85mWvriAXp4FQ4TjH9YPg1ptzCshFSNwO5?=
 =?us-ascii?Q?VZugMnREXUubElhUJ7FYStwQH5I97JYuNWh9Ua2TG2ed8lK/bPKSKwSky5+F?=
 =?us-ascii?Q?VE8DtSDZ+9rWa/l3GchnQw4z5T1RmsBOrRHNg/Ju8aTDBVi9IqvPf6qFGXIP?=
 =?us-ascii?Q?clZqs0F+K4KK4FCzdJbrSZnv2ivHFT3uY3J5nLaDdyHTj6qOz3179DFnHOr+?=
 =?us-ascii?Q?Yi8Wg+CjHvREFh6xNKFqgUDk5624jkI9v/Wh0ZVcWGFW/Oypt23igQl4/8d9?=
 =?us-ascii?Q?Oxfg3z4JQEC4hwUDQcosuhrSku5lDe1r1+r/NVZCWn0T6B+XqBfrN1Mstyjz?=
 =?us-ascii?Q?fVcFb1lSi3FmuAkKh+YdBPAlKUTVBOh/zL/o7kUVrCygr2L/xytdJBUEHU6n?=
 =?us-ascii?Q?ysuzqer9II9lotC5q6PC/T0WW3C4eAwQJ132rru77PVPtWmGbGI62PX10p81?=
 =?us-ascii?Q?F4yo6k3gK7DYR7FFeg7WGLiy6GzLxOIshGVoQLumeex98BtfKvDrHLFhMaUu?=
 =?us-ascii?Q?aw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 5zRw+hK7q/q2GgnOMk61EjjiT1I24mi1OE+3lLjhuJ5fXvFMLSUxAZFLJOcbWXfB3zO+JeHIZFRYroF2fMs9a0O84Bd4eRY8j1Kam8GQMlMyhqMvRDE7TdMshhu6pdQIM3ZCcpsnNrqS4tEe9/taTSa2mgdtrtoPS3Gnp14I30c2ra1khHAQfUyVRH6HKEioHT7Dub4dP1Nv3Rc6mHlohAyaHjmzkkNJGg8CT3BEAK8p1nPBfwQ/mRTBLPpMr263M0I7gTiQzcmt1iufteivczIJ/0h+WOJQn/T5Ll0Vg+hHmGPLwHv8m0zCYRSC6JJoI82N8WiEbwFhC+gL5SJrdw3rUCfc3uCaDiwYQL01LijRremS+tTxIuLjMmh9+LISyHTNJDv7g+IE3esiQK1zp99zHgM1sue3fXTz4fclZYdX6qysdqPj1cYIdU6UEV7eE++IkORqGJAevxHR4XW8YeBEG0CWo7NoDELuPPOkW0yOucnCrxG2AJZWNitkpAlmkGBoV80XHH2QIhvDaPoa/k5hfd5Ke/ygKRoeDwbe0ta6tHZkzEX6Re00ZXduE1A6HloWhVshc0zzKFhnDwy51/Y0p6NayUtzIyHcYjygTZT5o+8Y6BG8nfAVi7W3HIYzBw1ag72O4FsLO+1ZS0bHoMPGAknOGdEvWn63y8PY96Yu/6XQXldeSdDM9+k17QZgE6HD0YE2HCX3foo47JIziGShFng8AUvqt24QOM4dS1BDOqfYp6o5J6oEVp/OJ6sRCebOJjzBrZ+C5/FWVYmJcyKefH1s2FCxp/ZzNpHFbjgIvOdgQcmzhoZ6C5x/RNhe
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76de1222-81c4-43cd-cfe6-08db91d186a8
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2023 14:22:09.7231
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M4bIqL4isoSTLAzzsnG6GH2p/A+/M7HxdE9OxlcREpYZVJhLCkn+QHpDNZlFA4bHiI40cKegp+bwO3kFIeNOTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4161
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-31_07,2023-07-31_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 suspectscore=0
 mlxlogscore=878 malwarescore=0 mlxscore=0 adultscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307310128
X-Proofpoint-GUID: xqe31hDZGnrSNPEerD7H64nNJMlwpOwp
X-Proofpoint-ORIG-GUID: xqe31hDZGnrSNPEerD7H64nNJMlwpOwp
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Jul 31, 2023 at 04:48:30PM +1000, NeilBrown wrote:
> Now that svc_process() is called only by svc_recv(), it doesn't need to
> be exported.
> 
> Signed-off-by: NeilBrown <neilb@suse.de>

Squashed.


> ---
>  net/sunrpc/svc.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
> index cbfd4ac02a4d..f2971d94b4aa 100644
> --- a/net/sunrpc/svc.c
> +++ b/net/sunrpc/svc.c
> @@ -1546,7 +1546,6 @@ void svc_process(struct svc_rqst *rqstp)
>  out_drop:
>  	svc_drop(rqstp);
>  }
> -EXPORT_SYMBOL_GPL(svc_process);
>  
>  #if defined(CONFIG_SUNRPC_BACKCHANNEL)
>  /*
> -- 
> 2.40.1
> 

-- 
Chuck Lever
