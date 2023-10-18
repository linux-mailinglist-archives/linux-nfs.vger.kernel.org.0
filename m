Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE6B37CDFFD
	for <lists+linux-nfs@lfdr.de>; Wed, 18 Oct 2023 16:35:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345830AbjJROf1 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 18 Oct 2023 10:35:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235249AbjJROfJ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 18 Oct 2023 10:35:09 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 434D3D59
        for <linux-nfs@vger.kernel.org>; Wed, 18 Oct 2023 07:33:38 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39IEIrOn017928;
        Wed, 18 Oct 2023 14:33:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=nGW86R6gP0472+kLKh0s+Ad8VXR2NGXbivFKMxxp9fU=;
 b=H90kL4WHLjghSawf99EvhCWJ4UdyjReH3vYdy7pGmUf5sh/v/7pdPWfpMw0ezy3vgGaN
 0xnsFYJUSMstAn0NMQqK6T/17u38aCDkXVqOZP2wFb6xZJrwNb9uQ61puQ1pK1tAa+cK
 bbvUuwXLT/TnpNoR3sPzUJV5wK1plRtzbAm3r1GQCrdg0rrYg2ZnvwOJhJHs5IZkur2t
 iq+bWXfYCOATB/JifYXD9n1FWBL2KiehagEDeF3NvsJCicI8lmZHB01ESD2gPePVB8m5
 /6tvFcUpGgRj+ekiGVVN3d1EKcbB61WanBAvgvbXZ3rQUBgu7st+WhdbQFaLDmxnhrLR Hg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tqkhu7qbk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Oct 2023 14:33:13 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39IDiNYr009770;
        Wed, 18 Oct 2023 14:33:11 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3trg0pb91c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Oct 2023 14:33:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dXETvaYwdGGt4h8CjvznTfs1hEJuryxyKV/2GSv6+sdNUlPLRIEwm15/hybrT9lNWf8ATpITlPlDUHIoHK2BioNLXtxEsx95wm0NqiDy+oUlThtMGmMnfoNJPUK9I4jHU+qrPZUVSVzvHB+6OirRYp0uDXbQy8gD2Zw7p/oxqaoPsv8yL0mOr8qZq3tw9MSIhVuY0skWHgFDJtJs+VA+Ps2fBHiF/FbTuRBCEeTi6pixdXuxfXHIKtoN/cLWnSiXAy4ELIM3UsESzia9t44ajZv2mBPCbxhmE1TJdk+yxFlkNDL4Cq+utzCnlsTMPz99T0muuQmscOGOwkLgV3gcuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nGW86R6gP0472+kLKh0s+Ad8VXR2NGXbivFKMxxp9fU=;
 b=Q/pCBoGxNt4bSo+TnO3R7b2MRpLcmavPznOe0tzLuBSFp/D/nE90NbADdV2Beeyu/DkHCxh/41j9Z3emi+cUrold7LFLBWKJvoCp9tsbyRq2qOZZl3uUNwepmaxAx/uXgAMaHqINFJOuKR6fR4w8aCrPLRmOurUPPMiGEG38N4RSqAcTt/eqTib+4qyEw+fQ04Y7xPPjlkhBJi0FDvWPjiMae6XTx25T/Vjo8N79J8PegbE/pydYvOceS+Q3yJ001aHZiGnbxdzNdmTatWWx72MSUigY5Q5aAOWGmpEmljXjns25xvvieJXj2Q0q6hFtbx0JdanZBX32WDJ/14McdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nGW86R6gP0472+kLKh0s+Ad8VXR2NGXbivFKMxxp9fU=;
 b=ZpscmPjjwtnOuEbRhdPoCOfrafIRZjRavhbmmvNjYnpZXBqeFx98FEHiXWyYS/4vqFS8FYsyFlKj3RD096wemw+aA8UGBCkBTOjXvo2sOl/2/vOmC25kpffJeKF/aSg+J8fqKm6MVyN2uLUf9eGBYxR59V6SI9wsKxMJYoTJFuM=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CO6PR10MB5635.namprd10.prod.outlook.com (2603:10b6:303:14a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.36; Wed, 18 Oct
 2023 14:33:09 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::215d:3058:19a6:ed3]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::215d:3058:19a6:ed3%3]) with mapi id 15.20.6907.021; Wed, 18 Oct 2023
 14:33:09 +0000
Date:   Wed, 18 Oct 2023 10:33:06 -0400
From:   Chuck Lever <chuck.lever@oracle.com>
To:     Benjamin Coddington <bcodding@redhat.com>
Cc:     Jeff Layton <jlayton@kernel.org>, trond.myklebust@hammerspace.com,
        anna@kernel.org, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 2/2] NFSv4: Allow per-mount tuning of READDIR attrs
Message-ID: <ZS/sogNrJZVi7RJP@tissot.1015granger.net>
References: <cover.1697577945.git.bcodding@redhat.com>
 <bd900de1d19bc56e6df5b44379f373617acc894e.1697577945.git.bcodding@redhat.com>
 <ZS/V+4Cuzox7erqz@tissot.1015granger.net>
 <6157b73e380e5b625cd8ed0133ef392d0dd4bd8b.camel@kernel.org>
 <27DF51B5-0794-497B-A3F5-99F16B14D787@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <27DF51B5-0794-497B-A3F5-99F16B14D787@redhat.com>
X-ClientProxiedBy: CH0PR03CA0112.namprd03.prod.outlook.com
 (2603:10b6:610:cd::27) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CO6PR10MB5635:EE_
X-MS-Office365-Filtering-Correlation-Id: 799a225f-13ff-47cf-2505-08dbcfe7268d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bupIs8p6L2lIyV/Uh2k6YlfxYsb4nND+0lfm0l7G8qotPlu6yhDr1QOUEubw4dEBdhEihoJHWSR9W7Pze/HaYnftAC7bTtYzSexz3r5B1ReOP8KIb7VfnyZzbV5RhSXVuztDQ0uV9l0UyfHdyjeVyCJdVER8OuZkEf3k7cAcj5ZeBCfnVBEZR0wj5ezaSL+A+PiaEOQBjmwHBQ//amtD3jyyOlrywLmLpK12SVtVZhQlZD8CVpP+sy2pwX6nK8ZoLy0gJdtRvoNK+ppex2WoqbTSgMt8Wnn0KCZFpBpPYkF3xa/ZFUgDHsne5bc+q4e4VvvMbQOMcELIdOouLbsqnE5dJfd0QhCUMjFvfciHjKAqOGVZEs2M30enm6BeeQ0DcTvXm6A5MEIccwWyYwhHah3DzxYE8wM9RSOFDtWm5xdsRQ7MUGar5VeD/TOnUDONgu1BT7cQ+iGY3SD6HB/xB8glm47FKIepvTEjvDm+zlwlRZblXc4jQzG78HtG4EpmdS0aACKOKza5AMXlV5eV6FEwFq22HJ9r59gLJ7iI9aHggMKYeqOSEO+9mKYdd1Hp
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(136003)(376002)(366004)(396003)(230922051799003)(64100799003)(1800799009)(451199024)(186009)(8936002)(6666004)(9686003)(53546011)(26005)(44832011)(66476007)(478600001)(38100700002)(86362001)(41300700001)(4001150100001)(4326008)(6486002)(6506007)(6512007)(2906002)(6916009)(8676002)(66556008)(5660300002)(66946007)(83380400001)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Mi7Ur1AFDIueJPfzg5Q2bUu4eLJCf87HKVydt55rrDdeRjRTbQMt+T9fDJjP?=
 =?us-ascii?Q?JfaqPPjHq6dziMN9hjCxNi/pSvVfJ8Wt71ruZRYVuin/XlF4ZhVdy0Wkv4CA?=
 =?us-ascii?Q?CiT3Fx5WxWMghQp9xKcNP851QV83gQb7pktKXbqIxPSlbuKTNTVNi7k2orwU?=
 =?us-ascii?Q?KzqYLJvWih1fhJ6SWtP0n75c3qM6nKyN8nuP0b1vP7TFoxDsjeGIsu0YFvuB?=
 =?us-ascii?Q?tfAlYw4PwBrFTCRW/OJu8Bby0Q0DL6bw61bjj7z3dteTqLFeRPclHongDoCT?=
 =?us-ascii?Q?fHil1g+V+NtwowpGo2laFwW+AAboPYvisadQF0WO1uN3EOG74Z0CS62cKK3Y?=
 =?us-ascii?Q?vBL2Q0et89M9Sy8OCNX1C4DjBM4a/zNAQTfdWrCje0o3OPIjM/8GEwXm3et7?=
 =?us-ascii?Q?eiiSAz3+z4kizVrlbk7VyBCuhwD8MPGKEsMPLscgjq8OoTUHgF6BdGGS09AP?=
 =?us-ascii?Q?xAMObQJ+bDRq0aovuliyYDF7XhFizQPcoUmC7CoEpi/xpkeJqacergM8RYPk?=
 =?us-ascii?Q?d8MXcX6wV3prFaOyCkQGo4ry1UsRbO1LidBbS7z+CfCSik/YVqzrv9fPUDZR?=
 =?us-ascii?Q?VOGoaNXANwSDgIOh3RZ8Y88YwgKGuVoKW+zP86DhCBYFiQOat+bkLNUpazWW?=
 =?us-ascii?Q?hSTS2EacAVHMCaRGqQo52+IWO3SBJoEp9CM5v5axv4xy5i9MLvkDjMcpzb9w?=
 =?us-ascii?Q?z2o8wZbOYUkoDwsp+K5db0D+2qWnOEPuDuqkcXHP/bC2IA9A884JNTaeg3gz?=
 =?us-ascii?Q?KoylfIS5Ql+2U+jSwn4wKOcMKmllYu+6jpCwDHrphfC9qvTmU6obiWTOHmYv?=
 =?us-ascii?Q?0q488LBVY1ko8IM3jirNlUZPfJjVLay1Xxfw9/mQA6qi3YsfPl9FrWP1KL+s?=
 =?us-ascii?Q?9KMQeTxxm/vYjTFm4PL3b8o9o5Z9JPlh2+Jpdlo6gsRxXxmKhzEohVkjV+y0?=
 =?us-ascii?Q?HqQzUFQXigXTA6VHIgQwbiqjbW3NhNMhSuKCgBNk1m9pDjUxny9JTMEOPsF8?=
 =?us-ascii?Q?85gvp9rcwTFhkQzVEjcqWGoUAwLS13w7OQ6ekigpfaref1TvLsyhoXZ0gJ2+?=
 =?us-ascii?Q?p86z+uu/Vr3q3taBfCqQZ2qskvvqxG7tbEQTkx1LyoLX3AiGMTL+kyNSwvoj?=
 =?us-ascii?Q?6dYYg/JbWaUjSDDktrCOPDnaGPyOpH+8YZiYQ9IqxGs+LKawympn7Ep1kaA0?=
 =?us-ascii?Q?pKfXOn6iW0h3PvamHTC4piztVEp92ATSFrHDUUAbJXIFDuhc9wArCYS0f1TV?=
 =?us-ascii?Q?vXufnlHInOR5ZfURPP0sQFODGhVSbTBuwBhe2T3tTxdR/TFJh4uwKNjtBBCL?=
 =?us-ascii?Q?wRmLUxCy8sT+oexI5RkQ1aLOpRa3RiW9lnpLevxpn98FyKW8cTG+YEeqjQuQ?=
 =?us-ascii?Q?LPkIjIBdQul0GC3MDNqzk4gwgHs7OutaBbPyKBB7+Nsz84I8cjzs+zar8Cs0?=
 =?us-ascii?Q?leg2b3zgBt0HIKuKmT/QPmIHJMc6aAkVkHLlCjtke7vhKhq6iXKU0hvCdnnD?=
 =?us-ascii?Q?9Bk8ICmxbKB7GcLKwiSBRmaIVUMuQtgQPHv6GNZBGAT9vKV+rksMt+waxAvi?=
 =?us-ascii?Q?BSSnpW6z9EuKnpt48oQ23SXdjS0Y+nrd+h6KDkZBSFiLTS6RtH2CepWir9Ie?=
 =?us-ascii?Q?uA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: jfeEeMxdDhiLKmQpodjyYYR4IguwTexE4cTMk3gBh8jp+jQhUpYtOlPBoHO5czAJ/MEKEpL3aozj48hrEu6FPkPwc6kncC2QXoolbHtxWZTmgrnRM1tbH5IdmlXm0nnnmJAlyUVRj0wMcqHwWsUHj1SnsWwZPFBt0oW4OorGOwvp8RAglWZCOjMLP87hRX/LnXx0mny/JL5O0k81MYGeTCBiEamrG1GrNDsqCvGdd+vYxwH4uOHvqfGHXxVHrPmbRgeNDaRAwuTEHioAEjbMXPIPxA2I8HbBNmDyG+X7miO69M+6nQXfckTyLdvweMWmz4R+0A3+wijezEQZGJqr0IMqcQyCI2TsQh6utoB8O9dPW8gni8kHXEL7pYNHHJ2kqbPi7F2x1GKnTUi5JrVPKqbfWBNG/6yu4tLksLfotQTECVQhUBu2CpPYf1HW1eWmbEO2i+lRk/va8xu8wiKYyCVbAF5TVwtEoo9+0NlaTT6ZSXOuYOF8MrJrp330dU7WcFv94Z92EtEIWDIKDX3IPU7visS1cZAabE1hfL2/zdg4M4a+kpXXcU+5HO4cvo+BH74IlwfcGHYX8w4CtW6elvWaRiZED5aPPXJsqTb/8TsahWkz5NOx1on7Hb/IujbSkWNgAg7pdWP3G3hlVlLhVVAjHxikB7wBbBA+MGEecYo4c/JrAtZktzZpRxnUiVgIe2w3HJPpgXSmhSrkoLlT/pVkhDrYVtNTFvzz2yukTGend2ID9KO+lwP0aZu8Oap1UElAwUab7mma2TzYjA8ZyhrxzN3w1jqTEprp3fAm1QsLHgFuBuzzHQCqn5jXhDiwq7Om2iK+r6M1PMq9F5+z9JhcUN8qLwUBTcRAnGx1LWs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 799a225f-13ff-47cf-2505-08dbcfe7268d
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 14:33:09.5374
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K6fB4A9b9gmBuhd9WwYTQsSrOBn5araQvTPfy8t3wVFh/nj96qQzTl7jOAf1OvKb29Ts1xEPzMaVxphrei4S8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5635
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-18_12,2023-10-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 malwarescore=0
 adultscore=0 suspectscore=0 mlxscore=0 mlxlogscore=871 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310180119
X-Proofpoint-GUID: 9zyHtGVibqMVTNiZKsVnt1VBR8SAmd4j
X-Proofpoint-ORIG-GUID: 9zyHtGVibqMVTNiZKsVnt1VBR8SAmd4j
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Oct 18, 2023 at 10:24:18AM -0400, Benjamin Coddington wrote:
> On 18 Oct 2023, at 9:33, Jeff Layton wrote:
> 
> > On Wed, 2023-10-18 at 08:56 -0400, Chuck Lever wrote:
> >> On Tue, Oct 17, 2023 at 05:30:44PM -0400, Benjamin Coddington wrote:
> >>> Expose a per-mount knob in sysfs to set the READDIR requested attributes
> >>> for a non-plus READDIR request.
> >>>
> >>> For example:
> >>>
> >>>   echo 0x800 0x800000 0x0 > /sys/fs/nfs/0\:57/v4_readdir_attrs
> >>>
> >>> .. will revert the client to only request rdattr_error and
> >>> mounted_on_fileid for any non "plus" READDIR, as before the patch
> >>> preceeding this one in this series.  This provides existing installations
> >>> an option to fix a potential performance regression that may occur after
> >>> NFS clients update to request additional default READDIR attributes.
> >>>
> >>> Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
> >>> ---
> >>>  fs/nfs/client.c           |  2 +
> >>>  fs/nfs/nfs4client.c       |  4 ++
> >>>  fs/nfs/nfs4proc.c         |  1 +
> >>>  fs/nfs/nfs4xdr.c          |  7 ++--
> >>>  fs/nfs/sysfs.c            | 81 +++++++++++++++++++++++++++++++++++++++
> >>>  include/linux/nfs_fs_sb.h |  1 +
> >>>  include/linux/nfs_xdr.h   |  1 +
> >>>  7 files changed, 93 insertions(+), 4 deletions(-)
> >>
> >> Admittedly, it would be much easier for humans to use if the API was
> >> based on the symbolic names of the bits rather than a triplet of raw
> >> hexadecimal values.
> 
> This isn't aiming to be an ease-of-use interface.  This is tinkering with
> the innards of the client.  If you're doing this, you better know how to
> convert between bases, because you're going to need that and more.
> 
> If we want to make it nice, patches to nfsctl can follow.

I don't see a reason this shouldn't be easier to use, especially
since mistakes in setting these bits have consequences. There are
currently 82 of them, after all.

But, OK, the polish can be applied by a user space tool.


-- 
Chuck Lever
