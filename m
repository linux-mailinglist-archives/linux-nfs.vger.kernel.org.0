Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB1CF7B1EBF
	for <lists+linux-nfs@lfdr.de>; Thu, 28 Sep 2023 15:42:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232088AbjI1Nmo (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 28 Sep 2023 09:42:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231966AbjI1Nmo (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 28 Sep 2023 09:42:44 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFE8411F;
        Thu, 28 Sep 2023 06:42:42 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38S8qLWj027309;
        Thu, 28 Sep 2023 13:42:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=uRSzKCx2SlHhsenzkLdA3rsSRAHc8sgK5vHVUVNPCTI=;
 b=VFJw3G/EoyqNLHS3zdEHHk4T+2Wfc7nyqRryDtLqd2UNYi9Jes8ZUpTx5Y91eReJP/H7
 cBtgBmAkHB1rmL71kqmF8mNNEWiQy8K5aWvw9EAKeZ3JlElCEW6Rmo/cjQYZqYMqf35o
 hTXblUNToQ6DbA/7MHpwqPIdbGcE890ln3xuDfKmHqw4Hld0ud6LkRhlw7RjATNZBLka
 +GMTUu3zMHJgnq/94hzA9stYlhoIANgsmFBbMjelxZCxCq93WrRsV81mEW2i1z866LRt
 deWQujShyJsYsxwCZW/dvkPDQ02xbZ/Cv4PhcLxOJnpgFus/lrzwHh4+wN2CYUj194oU KQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t9pxc4m7k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Sep 2023 13:42:35 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38SCNhX7002129;
        Thu, 28 Sep 2023 13:42:35 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2174.outbound.protection.outlook.com [104.47.57.174])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3t9pf9scy4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Sep 2023 13:42:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gt3+YuN4OnHriDg1YvzFLkBVqOQnKDnArzOsZ0zmpJN0UjyT9rF16hptpSfHhl3c9jkcvdAqbeL2bRbem3OUpUQI3oFrUyRMzAxIXuhnAKHXNOnr/hNtr0bwO6UWT4oR/wnVKzFh7NgHxOMIkO5J+e4x4GAL3KStNsivNjumQ0Y07aNB4tR9AahYLYFbA/YxQzyb+7vz+gzUjO09YRb6vy3CpLxt6TnauLcBdp/KTdmPXgH6m1hUr0HJXpjS8MNHJFnvF4P6krUnmzhKtHChlJx/4n6TNSQVmCZCKRsq0UE4YLqrXkQEDrsg2tTaKqpL4E80TAumePh8zOquJMkwvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uRSzKCx2SlHhsenzkLdA3rsSRAHc8sgK5vHVUVNPCTI=;
 b=gx4OidhqfYjQTTpXpMQcrE1F2s+nipgttuOaQLuNJ9mQawME/EFDoWM1iNs7cvlixTt2nu7/zFLVe2qfHAba9MSj5GtrHkcKCk34db6E+qHfXJ//ww6HHggMuzPYcTndeFIU6P5MxfxfyiWoSbq+asVR1/VvYEm+8wTNpAC8txpwOY7jd5m5hBm5yC2FxR/qJS51VobZnqWiVuGBBlnrWekWBK29QL3FwBhmL3E2D11ojiPCHxn9tPFCCcfcKmrnXw3HILoHBRUaYJBQoXPcQK4/ltTL0Yfd9ti9bsGl3zmqpxSUyIvuZxo/pYxYF2DKl3f8YCky6ePL8asJHUuOfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uRSzKCx2SlHhsenzkLdA3rsSRAHc8sgK5vHVUVNPCTI=;
 b=gqtETWF7tOSp2IHhARlVz2EGnGLu4aIshalYs7UaK9CWpxnVcTBK40Ie4LJnTO2fFyFzMBtQ2rOZual41y9HM4P5cc5j9h+x9afbNvxsVlJ0wxe6ZMflySpfrrjEf8KPivLI0dCZfrwSWfdnYwTTKOz/HhdosMevpayu8Daa3gE=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CY8PR10MB7220.namprd10.prod.outlook.com (2603:10b6:930:78::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.34; Thu, 28 Sep
 2023 13:42:33 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::bffc:4f39:2aa8:6144]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::bffc:4f39:2aa8:6144%5]) with mapi id 15.20.6813.027; Thu, 28 Sep 2023
 13:42:33 +0000
Date:   Thu, 28 Sep 2023 09:42:30 -0400
From:   Chuck Lever <chuck.lever@oracle.com>
To:     NeilBrown <neilb@suse.de>
Cc:     Dan Carpenter <dan.carpenter@linaro.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH nfsd] SQUASH 8dc9e02aed76 lib: add light-weight queuing
 mechanism.
Message-ID: <ZRWCxiizvlcxJfz9@tissot.1015granger.net>
References: <8e9f5845-0d9c-4d50-b2e4-5c1cd622a71c@moroto.mountain>
 <169585271242.5939.14975098525477744646@noble.neil.brown.name>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <169585271242.5939.14975098525477744646@noble.neil.brown.name>
X-ClientProxiedBy: CH2PR11CA0015.namprd11.prod.outlook.com
 (2603:10b6:610:54::25) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CY8PR10MB7220:EE_
X-MS-Office365-Filtering-Correlation-Id: a6b7d957-2b2e-4171-fbc1-08dbc028c47b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OEynaILYQJBpBZaE3i161XpeYCI0cwWv9oKf2gF17BAgjPd7dC5Xn/l/l33q5dpAqmoTs9rei5GyTKzuYLnO3poP/fTB+RTwrwjJiYIV7Jps6S7p5BKwjsvluPI7mf9y8f9ThvcTAeb6DbM/H+yvSphik5YDbaItWmkFrhZdt10uCF+v8FQH0z3FECTZ38Q7b+0We62AsvBiX81+PvEYk1N3qq8K3ceBcoOijF6m+v5ELHmP1PaFakiEAco26sribbOvZG4QXhWZEIc+ZSlYCE2+VH4l3Os574Uc/x0J1CUznJg4tFaCDjY70HO/+OLZz8twlvRUcT11KMNzybGopDyQc5arkbw5CfOMZkmoVjwwdzjb48r8J18RpfnRB9UQfl91PU0OLeH5uEqUAcHGV9CL26tL/G0obRvwbXSRcAjkVUTB+O2QaQImDLi5t2pzY1jT3mcf1biIl19A1irzlp6VZ5LdY5WzVNitnBDkL3e1SB74/jHn0CeE6NBWXJHFxhtvtIh0Tym2jUckxqcBxqfNU+MX6DvU0rixVGOsoZqg1qbPTiqxGtTYNZKeYb14tMzul5w3re/8S78a37xz3Osn12FFrn1zBrkKeE5dtAbRpmrJwPDEsB+dbnMfKH/Q
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(136003)(376002)(346002)(396003)(230922051799003)(1800799009)(64100799003)(186009)(451199024)(83380400001)(66946007)(86362001)(26005)(6916009)(6512007)(44832011)(8936002)(41300700001)(5660300002)(316002)(38100700002)(8676002)(2906002)(66476007)(478600001)(54906003)(6486002)(66556008)(4326008)(9686003)(6506007)(16393002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ysDMAQx9CBRyFQLXoUCMRqYyt1GFdfWc9Xtd07QEwbN7o7AjDm/vvcvm2dYB?=
 =?us-ascii?Q?9jJ6mBXl56nylyEjUQp1GbMGBpi5N02pAQ6ieKciYn1HRlvqO63QYD7dnCez?=
 =?us-ascii?Q?FyvrT6lIdtMsozv+om/dOxIyOMYCftlsEQr6dtyYxvSwsrNPHQrIFzx1srZ5?=
 =?us-ascii?Q?oSVSPbe8F3EAQyU0bq/UgsjnfOWtkxnw4/T5ImtPgiudpa8Z8GMpdSIxGw9y?=
 =?us-ascii?Q?MSkgZoKzkTz2iU0CgBd4jUDHsxZCaCWP9gMUgn3AlkpydJZn/d4t8OvlqkPJ?=
 =?us-ascii?Q?PDusD6V3bty4Lir4F+bLWqLXlQHceByUdYLxY81UchMBRVQ56Fepw0I6UY46?=
 =?us-ascii?Q?XabcJMkO4/ZAcfWDGKiCiw/vo5k3JVeDNPa0p50hcDdqniV80ZseDEPkaIqn?=
 =?us-ascii?Q?D83lmW0ZgCB6E0RyQ+QY0UmX3xySwdJ18+3ihLuIDOvlXYHg8n67xAxzdqHb?=
 =?us-ascii?Q?EioyMWLIaO5K+Q3Mgaf9kOgh/f9ztVbzFOP4eOju2JHUf0l4FkvaudhDZFVV?=
 =?us-ascii?Q?LKVd47Xw7Xb85drpx+slvCnvNZwC3ri/cXLJcpttXD24DFb5RYcIrTf+Nly2?=
 =?us-ascii?Q?gnXee9sW/APqlkHalFvXcPV2nEUFs4PS/a6M3METy1Rke4glXhhyCylLNiyw?=
 =?us-ascii?Q?jc0s83mmkSPWRT/LbKtG5rFZOYUIXsN6OAnpLveOAeSXSL3SDZ4csqPJjzs2?=
 =?us-ascii?Q?yJ1Awv1LWgGrew2Jr/V+eB8nQhJuQxS8ZATwQaRpDsc9AfjmJwai6byhxjC2?=
 =?us-ascii?Q?B49Z8CKGQPr1TvnbXE27B2DE2uBinCwdLsKd1BDJRdZfjiZ94nFT5Un7HQ+a?=
 =?us-ascii?Q?z/yqZQlf9i+QOu2Vd4oKb/2FuZkdowSnECCcPnE1pGL4svrF6fcb6wqMzLip?=
 =?us-ascii?Q?RTrUb3smWWbZ+J+NKXC596tkuNxKI6Va38EcjUEST9F9e0g3Ah2chOtG5IhD?=
 =?us-ascii?Q?HKUxRpKKm5gxb7gte46sbf3WiM8q9/QReEtJ4SIkdXuuaghwLnTWsvwCZfui?=
 =?us-ascii?Q?g4r2DD6JzCQZO/GxvyjJ8b8uEFWwfrwupapWER71I9Q4HM1GmIeQAaAQ3rxM?=
 =?us-ascii?Q?3p54UGGY4IITirx9dg64ncCr5g2DNEUTPS3I5slPRg813mIN39iJ1qoSs8X9?=
 =?us-ascii?Q?HXOseGn1Xbd3zNOlwGR5J3b5LHXfqX8gfeMTmdZTNNsyRNJuP8l8xeqtpxpv?=
 =?us-ascii?Q?iehiYfOPkUkiyleiNOK6RFBx6VT/Uu+QFJbGiVi79AtxDSmHthA7IvqYXv/C?=
 =?us-ascii?Q?6x1QYrDxEAkyf1faw9jMakKWKMbp9VasdksqdZ1Ti6G4MKbR2hmklU/gnnEX?=
 =?us-ascii?Q?OxtGGBQeNgMDQ65yJ5H3DlSCpcEFh4a5TuXRkVBHu9Hzci1XyxzRazIg1hsc?=
 =?us-ascii?Q?yNDbfJmi1f2K04DqSOXuZbvpVVU/WMFD2HrtLcXl4FSR7FUY1BWIeUAQ0SHJ?=
 =?us-ascii?Q?fb1rs4Yp/22I32q2J8AdMo5wJv4nC+zepvqIFJMzpvAO3eh9HZd0Dd1KopH2?=
 =?us-ascii?Q?SkOYvdl/EfEWYkURr83mtyrLfWzVSt7Htmshk/JMXkWQB7XCdhtboSkLYx7L?=
 =?us-ascii?Q?IpK3gim22K6lphOfMZQYc7UD2/EkfIU77aGAf2ADnGygHx8Bo0D1f86iyOAE?=
 =?us-ascii?Q?SA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: IuCkUu7Qsgwss7uYAUFzJpa/HS/Mj/Ek156621JBS6O0TsYmF91gNUiLnO+vjQisSCJleE3zPR7cmwVinaaqDNCCCHfwFDDsgiCNfH7NGJarYEA5uSVKzbpRu2q93OvE3OoQQAT6MZJgozoDUEdLkH8Pmjb0JP0Np4jDEBi7+Bv2FVs3MpI8bCXfVODMMZIIAu+QzHX8Nk//R9h5lNPf3lT45guh3V1V+5tv9uwm42W07R5XVnXUoW7IGaxhjf4fgJ1hVL+1IPiMg0svPCDAb7WslRkXFO0lGoqUqsz2qkyjlql5RkDjQOev65bFuRmrT/ryG8iBDarniURkZ4UQPS2bvdDAv5vIGgfybPX+3+rlYbuodg+77Z8H0m8hJuj3gRiWPXKXZt2UKlp1uRtsacPILu8sEHpPKWyd4qMhe7VO4xWNLKrSW5UTEo2MgKlsDbaeIbr9zhEzowUyAwgRQr6iKFdP51Q7BowcWPvMMEzonO0u6/xRsgJk4BqDCzF4N/lJmfVwsqzMCaiBdW4i9DW28jla8qQJhhZT0MtVT1Pd4zvOmHzeEX9pMKv3YotndqYZ7wMgrEIlxPu/40uvr6gfl5vigoPmFALFs38l+KQXHBctMw7jtDcVKNHxmdxvqjJtuRy/fsbRhgsz1aQklMDzUYalcIpir88HQEXE5ai/56BWJq1Cj2MowdyWbe8HPrFYjKBvG8SlQuuzXD0m/pWryhhQhGUM0tq9QseW0hQngWPsTbV6yMvXtZTyV/6BuitO76h5fOzYT/1H/7D/6GP42ht6PvGiSg0N/FuYa9U+WWwaZ0PPxHpFbLbi8itv
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6b7d957-2b2e-4171-fbc1-08dbc028c47b
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2023 13:42:33.1749
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9TJSMZBERWrcH+JsPvEpdXPL4s+RB49jetS2Ye1WZzRJJyiRVagQunr7EccgohhpKvEbC02xKfjoMiTCArkFeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB7220
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-28_13,2023-09-28_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 phishscore=0
 mlxscore=0 malwarescore=0 mlxlogscore=911 bulkscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2309280117
X-Proofpoint-GUID: 9SQ39xpXpfvlgbehjcT7CLi6gGmJJZNy
X-Proofpoint-ORIG-GUID: 9SQ39xpXpfvlgbehjcT7CLi6gGmJJZNy
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Sep 27, 2023 at 06:11:52PM -0400, NeilBrown wrote:
> 
> Remove assumption that kmalloc never fails.
> 
> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
> 
> Hi Chuck,
>  please squash this into the relevant patch - thanks.

Done! Will update the public nfsd-next branch later today.


> Hi Dan,
>  thanks for the review!
> 
> NeilBrown
> 
>  lib/lwq.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/lib/lwq.c b/lib/lwq.c
> index 8a723b29b39e..57d080a4d53d 100644
> --- a/lib/lwq.c
> +++ b/lib/lwq.c
> @@ -111,6 +111,8 @@ static int lwq_test(void)
>  		threads[i] = kthread_run(lwq_exercise, &q, "lwq-test-%d", i);
>  	for (i = 0; i < 100; i++) {
>  		t = kmalloc(sizeof(*t), GFP_KERNEL);
> +		if (!t)
> +			break;
>  		t->i = i;
>  		t->c = 0;
>  		if (lwq_enqueue(&t->n, &q))
> @@ -127,7 +129,8 @@ static int lwq_test(void)
>  			printk(KERN_INFO " lwq: ... ");
>  		}
>  		t = lwq_dequeue(&q, struct tnode, n);
> -		printk(KERN_CONT " %d(%d)", t->i, t->c);
> +		if (t)
> +			printk(KERN_CONT " %d(%d)", t->i, t->c);
>  		kfree(t);
>  	}
>  	printk(KERN_CONT "\n");
> -- 
> 2.42.0
> 

-- 
Chuck Lever
