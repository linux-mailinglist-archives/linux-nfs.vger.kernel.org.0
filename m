Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBB5175DD3B
	for <lists+linux-nfs@lfdr.de>; Sat, 22 Jul 2023 17:35:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbjGVPfR (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 22 Jul 2023 11:35:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229914AbjGVPfR (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 22 Jul 2023 11:35:17 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20C0D1A1;
        Sat, 22 Jul 2023 08:35:16 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36MAFI3D010976;
        Sat, 22 Jul 2023 15:34:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=M6HQXXoU7pfzEH86SQqLlMPwypR/9jYGVaOGieicFZM=;
 b=uA04y8ElxJ0W7BAomjI7MOukyYcpkZvCDN29QS7QtLajxRwOvDbexhPHsP2jBCTRe3gf
 GYGzDTQn0h/ttuYogwjTxI+SJEwu9J7gy8gfgt0tahEm52Se+mOL6DNvkEcVbvzbNeyP
 cnOUNCqIkg0aXWid6xtnUAbXYdHV/4kNFIZ/32T57qOF5TLEtnPpf8rGXAJRi9P5JPYf
 po9aGSUHcU6L4b/BTFUhotJr0Z3BapdMFNYWzVWcA6BcY1uurvvl+O4zlZjbBnDLi5rZ
 Saq4cNlYk3d7wc3DDVvhMpTTQwqHIuJq1VerHP6JxxZ6fLc1KaVvTX2CgXVrKOq49VD5 xQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s05hdrj71-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 22 Jul 2023 15:34:50 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36MEAGi8027548;
        Sat, 22 Jul 2023 15:34:49 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2170.outbound.protection.outlook.com [104.47.57.170])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3s05j861jm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 22 Jul 2023 15:34:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iWGB1ZWTQ7CNVpZwiZdXs4l2F4u9nCEpy6LrtBRgINZGG7bft+0/bK5QN98YYnWFSHpn4C3u0WE/qNDUtISnLqWEaafnlUiWh6zrDjcXDR4srA/l6JRGmEBQ1fPrkHpJPatTrZZYBl/9D9jZlA8jmSdPfQFBpwY7keDjy0ziyEd/f138ESjy/DcVVZx7Bw3H+cfnAhVHPjeGIvhvDWp2Vhf2qWEmnL4KGEvNKdddzgsyLZMQJX+vWLyxHE8lRZxP4MSM9AllPbgb8VJGtZcv2f4iNpM5tB2uCdqrEujf1TmGmnfRlqSktfT3SnPrVWo2wCB0H5M2pmnGBeN9kbvilw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M6HQXXoU7pfzEH86SQqLlMPwypR/9jYGVaOGieicFZM=;
 b=BUfrTz9SkJBQaLA9mbBwYou2Y8qpwiORVovJrlvM8h+orhDLYvuvzT88qINKQ34onHApNET/aeia9TU8u6fFB1HU4tt/TR/N6BHbJ3khIf30Z6mwyOmlRhvK6Uwe7Lcldx7Lcxp3+2ulAQnBhHshlcXtZBvTiSZCX+yL1eL1YNYVmzl3x2wJgB2ItJcsUnrog9GFCPwNHqWeJwEzC1s2WWwnJ2AeQ/Pz6yRjgyukJRD0YwbytMK4oHKGHc+kvHq/RKjXUF1xx9DkxD3MfZSM5qJwN/kFmp/mYbnSGuENjXOu5bn79hW3AFl2Uqi/xINIHun6txP4EokpDMY1DQ+ZTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M6HQXXoU7pfzEH86SQqLlMPwypR/9jYGVaOGieicFZM=;
 b=nRfqrqZvLZahE571dvsCxL+JHeS6ZmjZIt02Tndf74BviN0Nyq/k9s9/+uvCciLUMtUdy2kHEaBaeiD46WIVBgwiSTJFaUxB2ZbU/WmiKymJr2/1pY8J4mbbTdb+UnxI3adYZfq2UIxbZ02VPTTVjTzUTmV26xzajUnoFnsC6PQ=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MW5PR10MB5825.namprd10.prod.outlook.com (2603:10b6:303:19a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.28; Sat, 22 Jul
 2023 15:34:47 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e%6]) with mapi id 15.20.6609.031; Sat, 22 Jul 2023
 15:34:47 +0000
Date:   Sat, 22 Jul 2023 11:34:43 -0400
From:   Chuck Lever <chuck.lever@oracle.com>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     "jlayton@kernel.org" <jlayton@kernel.org>,
        "neilb@suse.de" <neilb@suse.de>,
        "kolga@netapp.com" <kolga@netapp.com>,
        Dai Ngo <dai.ngo@oracle.com>,
        "tom@talpey.com" <tom@talpey.com>,
        "trond.myklebust@hammerspace.com" <trond.myklebust@hammerspace.com>,
        "anna@kernel.org" <anna@kernel.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -next] sunrpc: Remove unused extern declarations
Message-ID: <ZLv3E8IYUaX9rpXR@tissot.1015granger.net>
References: <20230722033116.17988-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230722033116.17988-1-yuehaibing@huawei.com>
X-ClientProxiedBy: SN7PR04CA0106.namprd04.prod.outlook.com
 (2603:10b6:806:122::21) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|MW5PR10MB5825:EE_
X-MS-Office365-Filtering-Correlation-Id: 91e6b4f6-d360-4baa-3535-08db8ac92e1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wxpEwMAi6WxWzd4kAu4e9Gm+rylQTN1NvcPzM9oC9PceLnyiZn3Xja8qtc5lAQpPVvuZ4nWlrB8ywHa1SZYSfMfXLDxSArYjvmUahy1NyNNTmIowYU+GUl9hlofaqgFOZBI3sMQExoTc6VGLJq9Y5fUeawGw5+P520h048scfw6VBZUJtZG8n15pam0MFRVVAHWDiFW5k6CwXjdOQV7uI/fz8TRxTK5pSbB1mwfNbttDrvsaKUXHiSvzSJkCtXa2/NrF7vBPvRWd43HkVM9DBpS00Fn9bEAYOObMvVZCUjcR3VKO8q+iGtnWOIn6vkTT1InmQ1n/1Y2G7W3Jmpqg7WbaGKwRVmUTMMhx5k2hAZUqJUwm0Q47RZY2WrJWu4fQNmpEKdTzGbclSrqIhOCgSlcL6lfR5YiWs+TLYyUEa/VhVGMeUbw1dc+0uwd7u/grCbXX6h9/Z8r8zxtYVmXFNQ+hwLFqlyqPDnNaM+okyBn4vS+NH3uaL8tZVzYOn4I+CjH7msld4DR+uA1qORwJrv/STPWEo1rHvRwISwbGhMWilQ2rde1rmF1P8BMCOcmQ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(366004)(376002)(346002)(396003)(39860400002)(451199021)(44832011)(38100700002)(478600001)(6666004)(6486002)(9686003)(26005)(6512007)(86362001)(186003)(6506007)(2906002)(54906003)(83380400001)(41300700001)(4326008)(316002)(6916009)(8676002)(8936002)(5660300002)(66946007)(66476007)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YjSXAYfsqaiHS5djiUrKZFEsN/79BzkMrj3DG3hRh0nqBqKPqYK+6aOYU7wy?=
 =?us-ascii?Q?qVk3LoDJ6h40GGBlT17Qa4vvS57erHRiRBgfzrUVby0vU0SEyInw2t44KnpK?=
 =?us-ascii?Q?+dltPkJX59uTakZCIc74q/yRO6OHi5XPJV9XMzDr5Za5+JvrnP5xfK83yYG+?=
 =?us-ascii?Q?cX8sJyN24YE1oKKvIUQHhaqy45jqL2WLM7STfzsiCVafMR6bb+AD2ryJEEIL?=
 =?us-ascii?Q?U954vnXhn/RAwML2DhvYnffIlCyHGzJMlVf7KbAwa0xsG1J5LVNyGlSJOKXj?=
 =?us-ascii?Q?TtgVPPHRpW6PoT4JR9igobWLmzoKJoXCZp+m4GXu1usAsWrty8+3A0U+eNot?=
 =?us-ascii?Q?6tOjvGfANf6aSAmql7glWLEi9SmLdWeUUJZDeDFVfRziUVezuW4Wi/usFSbl?=
 =?us-ascii?Q?t30E3gBfThfKWJkTmyOSMK+oAl19ORZJek6C5yafxJWBjAu05kMRCFjo2u1B?=
 =?us-ascii?Q?tj1+wmzFI7Y6twcalOGOx1hzkVevaYprAg/lyVC+kkkUBO1Y1kcN/GvymYS6?=
 =?us-ascii?Q?ROcPUPf+cq0kgb0Z66n5+Zb5bKo+GbT1UpDBSuobn4AUzt5g3QGBgEttJMln?=
 =?us-ascii?Q?tVnzpl98EHtlpnk7nadV+9zvZ85Ls6tYHNKGatUIiGSWLmhhtwMVKXbWnjq8?=
 =?us-ascii?Q?yr5yInZhm0RuoWS21ofun50vY+Yu3HTVT1GEDxL07lD7ChCanISPa6aNkrcp?=
 =?us-ascii?Q?ajiGH9DmhqjFTb1l2BvZxHcekO63BMvnA44R5JtPVVWYThVhpaBXNZEfOa0u?=
 =?us-ascii?Q?K1pOYilOakwZKibFNqTW8bZ9GwnaLWx9Slf0UO4YxAUmRjtx17n9ShFPO8v+?=
 =?us-ascii?Q?Yxw9b97SO31Ib6l+ms80Ihrq8NfBSyUDviWfOsZPajfZXvdIQjWY0NGroFy3?=
 =?us-ascii?Q?7Y2Rj+ulc0B2NK2keze06WVihWktxN2n8Yl4N+1WjoPEDLDeVpL/FQvFoHWS?=
 =?us-ascii?Q?mnR2wuujrmdxy6wbVP8aiipi/y9jAMd0ruL3VoLQ5/th1YJp0lUJrrxmrQlj?=
 =?us-ascii?Q?H3lQ6valDllZ6EIfU2XgS1QLS0wJmbz/F4uv5KMo70yz8aqlTIPTIdKS5Yf2?=
 =?us-ascii?Q?ISGDiXtVGvdgqF+Y3ORnCecs/U2bw+SETlS3S2P0n3gU++8LEqZjm/1zX2MH?=
 =?us-ascii?Q?D/agpz0v/msgXaBhZI9MvZsitVbo5+yJteQVzqQB2lgR+JbSRaFyYzcbF1U/?=
 =?us-ascii?Q?r1yglbtxlDdB0+9zmE99qKM+8M75fj2YMPXPFnezCD3hDDrZnRuxZcXcDE9q?=
 =?us-ascii?Q?eLeWvyXIh55QptUxDGnNwzbfT+gqS+DvnNWh7+9jATAAhzAoDRlgS+ZXEGsf?=
 =?us-ascii?Q?XKL2uo68SF6MOI6NMVvULubdIWF1sG14vgT0rdPnm5fUUwud/t2GUtBixkEj?=
 =?us-ascii?Q?O8xICIM9MO7od+X6DbCwmc7uyv+LM1jOzX7kJueiDL4uP8Q4SGGgcyz8m7M6?=
 =?us-ascii?Q?oWHb0PfP6FPMArjGVFUlDWh0IAoxxsTKVqdAHdDnHLXtqdkr90V5A3TMEV0h?=
 =?us-ascii?Q?eQGRuA2qEzC2TCiZpSKRNdpjHv9zzZMGd/LAnXK/XwFAx4LjjS6d8lJnk43j?=
 =?us-ascii?Q?hjNzmfrQcwocT8FYsW4LQ6ONd8BPDy+Cd9ftmWuc?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?Kry0J8kpj+uxLlRk2gmHy7bIETL8ia79ys8/kbukOeAwFpHJXCRPmOnQbr8X?=
 =?us-ascii?Q?l/04yWgFMSodqhhD+HfDp2qJRqw3Yy/+lxujpk/rO4G2luaU4JBcotCGv2A7?=
 =?us-ascii?Q?ofL2X/NFEerom+OHxpq9gPHDdCMuJYT4yFLFAlcE/UyFGQU3dmKdNPgb4w5N?=
 =?us-ascii?Q?dFLjsEHhbEBW4bFOPSm0RoQZMUErK0gPrZQIPLE76fGKVj0jDg+KNo3bXWaW?=
 =?us-ascii?Q?fRE1VaB2Z9pPHIfsq0aGCZ+L/b3L1eMVSv1p7Jm2eGIzclanLeAqrKK6z8nh?=
 =?us-ascii?Q?dJzEok73tjsazVM2p8TipJrCGoZfLaWeei2sESAPxXeXBWcZim+IUFitzkX3?=
 =?us-ascii?Q?I0qZ/K0R+UQh4z9KtlT5n10hAH/BYk7xKxyxYWhlK+tcfbn9yRxmvLLHUrLQ?=
 =?us-ascii?Q?QgwLJZo5gb756rzH8KaGSa8IxXvaotXVWfQN+EgSEXUlhDXUozJP2ybdW/yz?=
 =?us-ascii?Q?yD2n9Bgx+YkDCa/rlrSrPvd9CITfXXjMuWX9QdIZFJjO4VPCCrOCSC6NMVFy?=
 =?us-ascii?Q?eVvBQqQdJMGQklJvUnVbUCgXr86FW4ggGjSxV7IDBszYMDaTZHQ+BgK6xEyP?=
 =?us-ascii?Q?eqjO2gwCNxA4Pc3PiDRU2KBAfP4D6onUMX+ZTdlXBFsh0uuyFZnGr+B6vUmJ?=
 =?us-ascii?Q?ERX9PbeUc0G0VoOk/4LdMMNtrvG1Vrn+ofyBuZvQVToruZ2qWr1CtRKJ2yK3?=
 =?us-ascii?Q?VI6Ur8HeeXJzKrIsqPxhrbHoYjHdcs0Y6BzgQZNOrL8gGWcNvpocuN8ul4Iu?=
 =?us-ascii?Q?9lkXl9FLzbGY21V8bQXLLuHWhj+JLRx/DYarmuYm1/6yNNVr8xXVRZ1PdxYV?=
 =?us-ascii?Q?oT354wxtRI6rK5jvs2X/bYTLeCv+LBRfES/qnuYH7gg4YnKb7lNb8X3jNOAG?=
 =?us-ascii?Q?/Kg1lWodgBmcEFniMsWmY+/0GvYBPjIEIc25o3opXNai1JmIFCZZoMaQoYPB?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91e6b4f6-d360-4baa-3535-08db8ac92e1e
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2023 15:34:47.0917
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lITlXEm6ySdXtcwgVYZwTEVJ82wVzyVMvfA9sZZY2gBwsuLvAVGQM1So/d9tRAKTOokOGPmQnZzRLTbV47zm6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5825
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-22_06,2023-07-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 bulkscore=0
 mlxlogscore=828 suspectscore=0 phishscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307220141
X-Proofpoint-ORIG-GUID: qQ3MjVhCwXm1aaM63sb3uqgWC2VhPd6y
X-Proofpoint-GUID: qQ3MjVhCwXm1aaM63sb3uqgWC2VhPd6y
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Jul 21, 2023 at 11:31:16PM -0400, YueHaibing wrote:
> Since commit 49b28684fdba ("nfsd: Remove deprecated nfsctl system call and related code.")
> these declarations are unused, so can remove it.
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

LGTM, applied to nfsd-next. Thank you!


> ---
>  include/linux/sunrpc/svcauth.h | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/include/linux/sunrpc/svcauth.h b/include/linux/sunrpc/svcauth.h
> index 6d9cc9080aca..2402b7ca5d1a 100644
> --- a/include/linux/sunrpc/svcauth.h
> +++ b/include/linux/sunrpc/svcauth.h
> @@ -157,11 +157,9 @@ extern void	svc_auth_unregister(rpc_authflavor_t flavor);
>  
>  extern struct auth_domain *unix_domain_find(char *name);
>  extern void auth_domain_put(struct auth_domain *item);
> -extern int auth_unix_add_addr(struct net *net, struct in6_addr *addr, struct auth_domain *dom);
>  extern struct auth_domain *auth_domain_lookup(char *name, struct auth_domain *new);
>  extern struct auth_domain *auth_domain_find(char *name);
>  extern struct auth_domain *auth_unix_lookup(struct net *net, struct in6_addr *addr);
> -extern int auth_unix_forget_old(struct auth_domain *dom);
>  extern void svcauth_unix_purge(struct net *net);
>  extern void svcauth_unix_info_release(struct svc_xprt *xpt);
>  extern int svcauth_unix_set_client(struct svc_rqst *rqstp);
> -- 
> 2.34.1
> 

-- 
Chuck Lever
