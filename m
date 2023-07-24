Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4120375FAA4
	for <lists+linux-nfs@lfdr.de>; Mon, 24 Jul 2023 17:21:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229506AbjGXPVS (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 24 Jul 2023 11:21:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjGXPVR (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 24 Jul 2023 11:21:17 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A85CC12F;
        Mon, 24 Jul 2023 08:21:16 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36OFIsHp007246;
        Mon, 24 Jul 2023 15:21:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=sUHOBhENiHNlfWvgG2tUAVQxXlQaatPhohs5+7u3mBg=;
 b=xmjidM4k13zyob1Bzn/XR/9Iv+fIA/SZGXJ+8kLgbEB4c8y4ViJvXIaUqV/tS0P9/LEp
 rvw1wWm7TCuUMbMiGfJkWvOPoCS0CJJrzvZjAIRztpdHhuZe6Fla88gcuSdU9JIbq17X
 i73v66eRQpvMA9wlA3R8/AlEEUCud+UCwscs9pqmuOHaIILFs/9ey7vaCW/5mdTiRzWO
 DDVsnmBeTaHaqlwg7FqBMUZ1cDNzMdGhDlSFL2m/Y8J1i14dZzyo5RM7w09r8jU5g7SN
 KbQ8rfYi7ef0OcYpW6+x5VM9H5ihWUeAbXOpuD1Si60qdiJ/gZgwo4V2PO5g9HuA7Sjb gA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s07nujxud-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Jul 2023 15:21:07 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36ODpp5a029023;
        Mon, 24 Jul 2023 15:21:05 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2176.outbound.protection.outlook.com [104.47.56.176])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3s05j9u676-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Jul 2023 15:21:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ful2ncJwBpb2KEWDprmUR6pJRdAPH/EXXnvM3yiUPxJvMljLcJ11hzt5Syt1NzV1pwEeJ5sYrqHqcX0PGP6WIdgVTHWzDW5Y2kyHp0iiGScOXUxG5igGFkscU7PnaCBvnwHEDswz4LoYisGOESeQlCjfXhRPk0cX8oRqoFRdaZxtUX7otQLNnnhYhYu4AcvZ1EjbApdVxIMuD2Y4jp0JHnyT4OjJ1hrNI2msKFfrCsi6J+y80XJeMTI2oiLx9UdC5dprhPsZnfjwPe1WeNesUHC82nJ4U6aUyI22aW9598DknOePlY4ff5aw1r4z7gZ8tDahhw7JdjsVpw7LWoXQEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sUHOBhENiHNlfWvgG2tUAVQxXlQaatPhohs5+7u3mBg=;
 b=fazg8xJ9Gcb/p2GMgb325XCMPWjYEUMMxP5I1lUel3uLkp5Rnfl48JSuT1056nHuz3Vy53BEstNxfLPOyjY9yiOvTWbeVcyj8thhLQ9p3PV1oRFH69nAfltorm8TSORoe/+4GdyG86nzixIGqPn9aw5LsvvSySVnphUZl02DvQw/LoNhm84fmPvsOOFDP0TDGvOkYeR6rMbua2wel+uTXgnT9QKtGHESTVjhKJJAmqjMF6wKA8+ss2VjEPlqdo1BYo/9RrGJXbppAfGe7gK3K8wurqwNYjYl5DphreAQv13NAXnPGptAFLceRK6Xho8eT6Wqrc/zNLNSz31PgU3QCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sUHOBhENiHNlfWvgG2tUAVQxXlQaatPhohs5+7u3mBg=;
 b=ySRscCb65PVX3MHS0KjomCPKt5BHyrfUS3W9pIHS9zLHRxzZNVsULXHmQTb63NCMS6JFBa6HmdEutF1fczR0hPNZPEKI2VHX++RnGUBWshsoq8nn99oPt4nLlExQUmGE9D4lhWWQw5kWmgzriRE4QjrivgUgk4H0L+Ew9n3hIUI=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by IA1PR10MB6098.namprd10.prod.outlook.com (2603:10b6:208:3ad::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.28; Mon, 24 Jul
 2023 15:21:02 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e%6]) with mapi id 15.20.6609.032; Mon, 24 Jul 2023
 15:21:02 +0000
Date:   Mon, 24 Jul 2023 11:20:48 -0400
From:   Chuck Lever <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Neil Brown <neilb@suse.de>, Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] nfsd: set missing after_change as before_change + 1
Message-ID: <ZL6W0GqBSdlvVL2Y@tissot.1015granger.net>
References: <20230724-bz2223560-v1-1-b6da868c0fc6@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230724-bz2223560-v1-1-b6da868c0fc6@kernel.org>
X-ClientProxiedBy: LO6P265CA0005.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:339::13) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|IA1PR10MB6098:EE_
X-MS-Office365-Filtering-Correlation-Id: a4be1846-4d34-4eaa-5a88-08db8c59974b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XOHBZLYGZUBu/rUJ46F4mWdD4iP0s8HoUka+yXePpSYtiM1f7/29VeaVnUZT3MwijT+39B+6wZO80vnQz7w8cWEjB/N4o1x3V0z4PmKwCbdhASwURqL7tnCiCNdpqRH1SfiVqragJc9wp8r3RpyzpCklDz4c1xWl69hzlEoWsebjc/bEPsEuTAnY2qHv/1MqHqT8YMODwCAJRRqIgowrlmZMD3Uyt71zJUlAH2IAPR6kahKlHnItH3qSh0bp4an1GGiMVHu9LhQ5gizyqInm0TeEfbiLUnqRnv7Nqfv7RZ3Xs2FBjhIyx3Fm/oMfzQNgpV7VwerPKCIUUxju1AhnWXhyPsF7Q6CPFkg2BOGyujbpaJlBS6SpfW2qjXhIKGaTTXwQsnEicr7CYotG0EAvQL6nx5DDphAxRDbn6rkZIHxugDL/ee4/9yZ1tsitYjWNh2G1+60NXQoiO5A3eCYfpEDZr/F+j2Ax1zmEZaBq5bQmxw0azYe/3vuPvbR3H3kBmNWMKx4qw20Qx5y4IMkHl0HTR534hvf2SEmw1o56PtWTwaPPDOpfNM1dvWNl6GZo
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(346002)(39860400002)(396003)(136003)(366004)(451199021)(8676002)(5660300002)(6506007)(26005)(41300700001)(186003)(8936002)(44832011)(86362001)(38100700002)(54906003)(83380400001)(9686003)(6666004)(6512007)(6486002)(66476007)(6916009)(66946007)(2906002)(316002)(66556008)(478600001)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FEg8IfRmPWkBwkg/oIXFipMhdHJOfhp/7oDicE3aDXIosEd2+dV5rj5kboZr?=
 =?us-ascii?Q?BjgabC4WKvjvkQ1mwuMFNsDh2V9E5ZUmxjGzp+88Pe7We0cFR6CRX6rwSF0b?=
 =?us-ascii?Q?x3fi5ChpKlWLbW+YduAWS16AomMUcVABMtt3ga+m1uAwMs8spQCRxxmD6/re?=
 =?us-ascii?Q?/+sdN05yy23ABlZdMiTi8dGOMv9WO8eKW9VwDqOGNSdoj1xQNG1n0gXu4j1g?=
 =?us-ascii?Q?2v8AkN4j/l/i2AFfP3Zr53UmomW0bZSiqnsIu1wweHrJigvsn2/cCtnBeUvx?=
 =?us-ascii?Q?hEIyhqR/G4wdeIMIDGkWabcFl07LVt4KfkX/nmSVqVQSMOEU20pHW6WpLnLE?=
 =?us-ascii?Q?nv/r8BjY+tPj5TyvzHzDr1Q4ugRpD5DHYQvaIPwK9bOvAmFcIcLX86uyEt8Z?=
 =?us-ascii?Q?u5KOTKgjnLxKidDRld7YVro1/hmh4Oc2+XZUdpVoY9TVaE5q+iBMyLFsOZOU?=
 =?us-ascii?Q?KZTvspTeCeR76ZAYvguZbTCpUVFaDjHyV3YjkOMKasyy46TCSGt1QiXWtEV6?=
 =?us-ascii?Q?Da1H+acJjZHULPz2cckNCrgBv4HMCtLBBx8gEkhIi6Gknc3M62pFTPv+Mztl?=
 =?us-ascii?Q?haUflqx6zuKt+fDu6GM/XXl2SEit/uymIZVFLyAGBZtUhGN+raTSpuqgRp5i?=
 =?us-ascii?Q?NSV20Hdj9t+MnBff1YpgxUXIypncd1nb+KDpDAu+RzXOdHySLk2FIMt9p4LS?=
 =?us-ascii?Q?cP+kG7elJVAhMrDBYJ7iep5FmHC+OfdZaUcJ1DqWQtrm5sIQeMnFkIm/Ar8v?=
 =?us-ascii?Q?sq/6APaNbC+0OdubhBBS83guASN+Mh0l/A+HhXnZsN8T1VamaRAEM7eYY/nS?=
 =?us-ascii?Q?f4rySQNw0TCx8eiCF5zklquftV/HL1J3Vb8r0gCogMqHChDBbFuehJi2Czp2?=
 =?us-ascii?Q?ORTxI5jxr6KGmrvg5TL8QLltF5UsKvzekVKY6zI8x2u7FCY1cnN9OxwC4tAN?=
 =?us-ascii?Q?9KLrGk+wGQ+Wui64p1xRLSVS9LXI8+mSM8779tpoqaJLAXABaxV0FfGq35ZK?=
 =?us-ascii?Q?t18mHo+xTxlPZj1f0Lzgwkr542j7r/lJyJxrSYMyzBxburqyAtzs9VSMbzTN?=
 =?us-ascii?Q?OPM5WQ7GWLOAZCH87orWx75zp+Fn49GQo9qRX3itgYIQ/OKhk6ytPwVBt9dd?=
 =?us-ascii?Q?8xiQMOQ6Xx5Y0LmofHTUeDpasxJ+kZWmst323ozPPHFwNynY2wQKy9rVu60s?=
 =?us-ascii?Q?QYTuyi4psITCmJIUeo2kO6G0l44CKqpQK/KZjuqqMWhdkIjXmxA1YRg7JyUi?=
 =?us-ascii?Q?1DBAm2b0GEG59RRWgmf+b92oySVk/DhTSnQcetvmJM5ZCUyRgJZTm8vv99di?=
 =?us-ascii?Q?qHUxM5n1gMDgjyajaGthT6Jc2h8FDRt9cglSUMobq/pYPeymCYtN1f/f+cmg?=
 =?us-ascii?Q?H/VBhPA23PtZ8cCw9DYmdadna2yX3RkPdVnpjXBGjRa44cCqMPaSfsIdQ096?=
 =?us-ascii?Q?fWFivU7h8xPK6tXB9/jhqZFQY0oie6fpubeafZQLL/z3AHk8VA2sxLd0nSwr?=
 =?us-ascii?Q?Qbt+rqMUEJhY+iYXAoiYL8coWpX2I+Hka0iZBWKX52HAxrMoeIYO3iKaCzAw?=
 =?us-ascii?Q?9D4LRJL1UG8xSQ4Bx0/V4Z/VwBgiaH6E+x5Y6Fb0?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: R3976IWYFwq9ATniolW7R/pJrKsw6MZ0mDsqjxZEpWu+uTEGWQBelGmdXJ4EzZM8VSj4Drb7IVF+gNADMxdyagADIMQMPH1NNcHLqt7j7r8kyoAyPotSt56Po5+adCM9DFQ9bEqEKjj8enTejFYbaxuBdVsJhnOt/NgtQxW3E1XG9EmzORpuAl78Mn40n2zVHUPryKH5yCHOHD5UPALT1i3RyTk8L+QsYqqwVoqbO4UGt5dCeNnxK86xFP6PHq9PcAgALtBAXg98rZSTE5zxJILSGW+A/UsC3vVVFfxgmJPx9UCVtHIfQM6GuXq13mAN7JyznJEdUJr9PmOJvsxiOCQTuvl7eGYVIRXhITUGogbpOILYDj+83+SqfaqHficDPgbAw6Hd+YVxYxEAOpwOlxYch0LBI+VMukWd8OvFYmcOlQr/5T8Wa3l0GPVjCj+zVjCQfTksBDSzeS8v39RGjF3pIvk0WOmXU4xdTO/oh4y7fzVC9EylglqAULJp0PoBokkLy/kTd3apgFMzP9q42U7IL30MvnjfXhza37MMDmvNtSlC8C/Q5rEbIg9WV5a8qguKlSyyO6UwROfeweRYbS89//ZWdg53UFxSmIEH/8PIsIc426GRZCuuVSZC2tiHplfo7db/Cq8IY3qW5L7Y4MWg9DdOZRIt5dAZrCHD1cZOf6y/ie5uA9v9F10+YBuEfevGN0nss1fXFNXBa8G+074BW76Vaj/3Yr8QKofqPvDtJ01b0Yxq8T8u7t+6hrzzWoRRz74FnsglLWe2L3M+zDRMh+G/mHOPnUJiOD9gjWcLaWsDdrSrUP+TNvT9Sy5UhjbQiq9m2aQpIZfjQVTDni1L2rYF3yOqm89o7nLlkkPTTCtBN1cEPgQfYQMxoEEh
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4be1846-4d34-4eaa-5a88-08db8c59974b
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2023 15:21:02.3986
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g96o2tE/OqZSGdocEEtKRpD6FV4YlIpzWIHTXer2Ps/RmD0I8uoJb8rHDtTDyHbmDWmR+eGzRR1q0dLsWdElRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6098
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-24_12,2023-07-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 adultscore=0 suspectscore=0 phishscore=0 malwarescore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307240136
X-Proofpoint-ORIG-GUID: ERC5ebe0aF82GVilH-PmyZprcVqsOrrY
X-Proofpoint-GUID: ERC5ebe0aF82GVilH-PmyZprcVqsOrrY
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Jul 24, 2023 at 10:53:39AM -0400, Jeff Layton wrote:
> In the event that we can't fetch post_op_attr attributes, we still need
> to set a value for the after_change. The operation has already happened,
> so we're not able to return an error at that point, but we do want to
> ensure that the client knows that its cache should be invalidated.
> 
> If we weren't able to fetch post-op attrs, then just set the
> after_change to before_change + 1. The atomic flag should already be
> clear in this case.
> 
> Suggested-by: Neil Brown <neilb@suse.de>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/nfsd/nfs4proc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

I'm not sure this change makes any difference. The client would
possibly see the change value move forward then back. I'd think a
false "atomic" field and using the /same/ pre- and post-change would
be safer...?

But I'm intrigued enough to apply this to nfsd-next provisionally,
at least for testing and further review. It will appear a little
later today.


> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> index 3f6710c9c5c9..f0f318e78630 100644
> --- a/fs/nfsd/nfs4proc.c
> +++ b/fs/nfsd/nfs4proc.c
> @@ -411,7 +411,7 @@ set_change_info(struct nfsd4_change_info *cinfo, struct svc_fh *fhp)
>  	if (WARN_ON_ONCE(!fhp->fh_pre_saved))
>  		cinfo->before_change = 0;
>  	if (!fhp->fh_post_saved)
> -		cinfo->after_change = 0;
> +		cinfo->after_change = cinfo->before_change + 1;
>  }
>  
>  static __be32
> 
> ---
> base-commit: 97a5d0146ef443df148805a4e9c3c44111f14ab1
> change-id: 20230724-bz2223560-5ed6bc3a5db7
> 
> Best regards,
> -- 
> Jeff Layton <jlayton@kernel.org>
> 

-- 
Chuck Lever
