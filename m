Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F336C7EF4E2
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Nov 2023 16:08:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230513AbjKQPIn (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 17 Nov 2023 10:08:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjKQPIm (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 17 Nov 2023 10:08:42 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DC14D56
        for <linux-nfs@vger.kernel.org>; Fri, 17 Nov 2023 07:08:38 -0800 (PST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AHEwuVs011670;
        Fri, 17 Nov 2023 15:08:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=YSM+wQRpOiAELm+klfcgwgB9c4lkKqak+TYaikpx6dE=;
 b=L3cLoL89LwgSAv36NYZ4mIx/NqWgFgocvKa6wI6USJfkc94av8WXuHHonIO1LkcSJcXA
 8iDsjyoY6UMN5a4CkYOReB9Tp/EEimcaC79utzRqi+k+Tyuntvf2nVfa5eVK4VOR22ng
 WmtkLlq2FYxrv3bXKGhQNDmzR5NNTYlnxn22Zf9C6V5sDdqU/WXS9rnavMgB3ihveCd7
 +WIJ47QAfgH2rYom7tmSF1atT7PkyisvSSyIA+9ccWaISCOXDVgxNaHUUxUGd0llgXr1
 jgp1zb0VYhI9zrYRqUpB1f29GTpeNb+BBE782cz91AW0bL2IpoRsXo5+JfbFYeZrQ+i/ 4Q== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ua2mdwsyy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Nov 2023 15:08:34 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3AHDn2Ev028269;
        Fri, 17 Nov 2023 15:08:33 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2041.outbound.protection.outlook.com [104.47.73.41])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3uaxq4mrkk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Nov 2023 15:08:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NAUZU0MipE8sbYgse8ySVtPOj/i41QX721zTlug0rTdvZycP+B44IhmOhGTdjW1jYD6BBbrgP/8Ph0xB8dqAV2bh26+r2Jlxz6bI+p8e380TfR5V8r0z6806EzcSPu0bRuognjHDcqKEWxEhPqV6DNB1va6NrT+Vnk4p79Uc7/tET3ChofrXqEDQiCIi1e5TofrKAdsTfZdHbMI9nM5zSnmPoUgwPp+VHEbLbMt7LgR+V1Ix+v+ucmNwt23runRzIFhVycStJJLi4RSKXWInNgjL06EYuXEk2wZCrV9jI+DbFRGwmKMN6u+uSGwxSDaloapQGGH1DLhNI6MutbVH+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YSM+wQRpOiAELm+klfcgwgB9c4lkKqak+TYaikpx6dE=;
 b=Z5WEMIjOGC7hS6S7pk2weZx+36ayWDSf5rGF5IDjft2SFk9MHBIT2AmbcJq+tQCOYTxEXenP6eQzcwGq/m1kWWBqqa6Q1Wd2siOIcVUML9OHUfHg8qbk7NJ0iy0ghYub+1TBksXP5dEl2AdShlLAhHQulmKXM0boCQLjZrHMwR3z9Smyam06EOGxB3tCOawKZipL97LyW7PFZ3wBMK6b++3pWMQ6AFIgiqF8ZJIQy2xwYWVX7mvmeHAKZ3PKSHkxG44ouoK9mFWKqVvaU8VRYRblwsixFFGJ1BUh7/Ae0lrtg0I5F6MOsel40eMOVK5QuIlmm7PSgNoBgZ28kcxwww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YSM+wQRpOiAELm+klfcgwgB9c4lkKqak+TYaikpx6dE=;
 b=HDrvsSMDZQdWxRjrYofrELuKD7C2QnZYiwJv+9ZV3Ffqk7xytbeJo6m0XTqJAN5P+CYy2OmLlCKyng7jSIGYv1D8VWWg0hsSpxCS/Sb6Q+wh6pUQU96ait3Uuqo28qYcQ0oIpwPIXLL2gYPGaXC+XEgyc6+uKPfmRdnM+VexNS0=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BL3PR10MB6042.namprd10.prod.outlook.com (2603:10b6:208:3b2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.31; Fri, 17 Nov
 2023 15:08:25 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c%4]) with mapi id 15.20.7002.021; Fri, 17 Nov 2023
 15:08:25 +0000
Date:   Fri, 17 Nov 2023 10:08:22 -0500
From:   Chuck Lever <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Chuck Lever <cel@kernel.org>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH v2 1/3] NFSD: Fix "start of NFS reply" pointer passed to
 nfsd_cache_update()
Message-ID: <ZVeB5kfH6YAzgwd1@tissot.1015granger.net>
References: <169963305585.5404.9796036538735192053.stgit@bazille.1015granger.net>
 <169963371324.5404.3057239228897633466.stgit@bazille.1015granger.net>
 <ec54d81630f78c764c930a50b4ba75b26e4b8ff0.camel@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ec54d81630f78c764c930a50b4ba75b26e4b8ff0.camel@kernel.org>
X-ClientProxiedBy: CH0PR04CA0070.namprd04.prod.outlook.com
 (2603:10b6:610:74::15) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|BL3PR10MB6042:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e882e9e-8fbb-44d4-b027-08dbe77f0be5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KcgAOmvByNLSRZMhv4JtZi9SdYxRg0a4dB0VNY0z4ehjCZ275cay0qwjStmRNzjSwK4kS2dO4jbto/h1MP5QQwx+Xp5djnJtbu9zTWUamhS6+zlfN/5QSV1S+td9ZEmNEUThEF6GZZL2kAYJOFXMwkX4/qPWpo7RqmBiEmndF+8Sb58IWPQyd2OKeR19quX9nnd1NK8CEf6t961Ax3YeKXY2InikMRQwKLwy+NYFdMZZvbAaD7XZogRDrywu15EFZtO/OAT9vaDlRC+oOEQj8g5JQg47/n9w52nPmPqZY48sY6fNUQMivh4jOKtlMZXJVW9wOAZNVRkT332/Oxvx80GT9HL1d1g5kUj7oN+0EI7PDZPxUHcxeStLeieaO7Fb3K3tMpT6VZq9QbsxMkI6ppVzbJLxQPqesx4nqSL13OMtzmkCpM0lCJXcFF/VCsWSRrWqDT82AlI8EyJPX81WE02T4Y9SSm3SBM8gKREEN/rZH3LMKJ/NN82CWyFUXrgci2pb/vIDvAnvQF7bTyk2QH7sd1eTUmAuUpi7VhNqobnTsztqMaLeuoGijzK8tcF7
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(346002)(396003)(366004)(39860400002)(230922051799003)(1800799009)(64100799003)(186009)(451199024)(66476007)(4001150100001)(2906002)(41300700001)(66946007)(66556008)(86362001)(6512007)(6666004)(9686003)(478600001)(6506007)(26005)(6486002)(83380400001)(8676002)(4326008)(44832011)(5660300002)(316002)(6916009)(38100700002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rB7F1Q4sdp1KutGXFCiuN9ISokSMpX1V+bCP38FDou2Dz0+PFQm+JYqSgJpV?=
 =?us-ascii?Q?FNX5iLx22+evxZOQx/UfByqRJX8Qo0ln3/Fq5ctJKLchJbdLt1F4pxS/7OQV?=
 =?us-ascii?Q?kcdqDLy/p2PpEO/16UYsEuM2dZ4JY6wzItfhfYETidD4oZQ50BIGVbqAIoPK?=
 =?us-ascii?Q?W+3MIuj4gyowZffeUxQY0urn9jLkmyTiWjfmHljfo38+6xPhhpbwzYe+lIkJ?=
 =?us-ascii?Q?FX04PMpm57D6rhpT+74MA2pVWO6Ju1ZXO5/D/17JTpLNioyJjAAblq9wGuNX?=
 =?us-ascii?Q?lUhfdAVc0QGh26HI9Npoh79umeL6Mc7x18a+xl6m+U/rYP3PYCmp4xXLva5I?=
 =?us-ascii?Q?q+S0AwYVaBLiGOe0pqg3aCFSg6k/TGNW/HlzPzSU815KhuTPpVyPoA2maRHl?=
 =?us-ascii?Q?1s0UX1LDM3LIKQ4omHvkD9rhGXhkqtggLkgKE3HE6MPUcrEVBPDmDgzdss1I?=
 =?us-ascii?Q?aID0zMHAsyZ4XVSMqdNyGdf87a/qnanDPoV8I+13H1xpXJyTD/IAekkICKiX?=
 =?us-ascii?Q?GYhgsGbfdORexXMjnKgd/OUVWD/TtBh1Tkykpt+eZBgcOEVFy5Iy5F8l/qhh?=
 =?us-ascii?Q?aDTQfNlkXJ+Mk778sKERVTfb02ylMKOj9YnnKmorc8N8CAnoYROxHPBgw1W6?=
 =?us-ascii?Q?nWMiZrie8dBESu/Bo44oq4HcfnIa3HeyXUsc8ShOGZWwle5bsYxnqJdGqQB6?=
 =?us-ascii?Q?rODF1+dYY2Imc7uDZqCzJYhlOJWFFc5jc1SYe854rWWS2w/cIHpMH83sLxHd?=
 =?us-ascii?Q?ANRzp4apcHKC3dxnI5Yx7xG8ljjNJZXDqWELlux+L407m6cAxU+i78ONZXKX?=
 =?us-ascii?Q?TUi5rxqrmOvr/AwRXC0s7vrHFKWknmkTdyYisGcEmdK7wFLm7ygTpfrvDOBC?=
 =?us-ascii?Q?A4Ugwneq0+5qFpmPX6Gp1ycpzJp7A3NcCKAy4lbJBuM7LAtTL0YLnP2HWs/S?=
 =?us-ascii?Q?Yl1zAjL5G7BLAj6du8Vw8/OnYbjmIkaguZW5ZNh+8q1bxU3V8/dRlf5CIfQM?=
 =?us-ascii?Q?IbfOJGOJqapa08nywGwciXgH+HvZeFhllb9W/CkJpcYCUcOSEstFaW2moIQv?=
 =?us-ascii?Q?AxOoyRGruvMAa4PMRtjNAS/IGfpuO5Xj+7YWzEVTXJDhtpE6b8SvAu2JAq4c?=
 =?us-ascii?Q?TExWLH8Tbl/O5v3Mo8emkTz9Ni6KF696/uDvDyXw7WlDLM2JCs3A/FLo6OJm?=
 =?us-ascii?Q?3FDQDHOr114My6oEJCeVra2BuDmWWpmA3nOVERva5Ow2MOtzMMLn0iYT5JfD?=
 =?us-ascii?Q?m7QwVm/6m33N1bVUwWre/HWUDZSRvcQR6n1bJoUM5gV+Fk8+o++AZTMY3HCF?=
 =?us-ascii?Q?NgaWpk83DCzeRN1CDTw6sscpInaiPnbYiK7s/RiSUzqb3m+QbmxTFEw5JgOu?=
 =?us-ascii?Q?3iuvntZHXRNb0t1Rs8VSykLhG81wYNuXValSdGD/E4Cv/QiwrYSIOtFZYmHs?=
 =?us-ascii?Q?+k4Cs5BkobHeozh0655gU29NP7E+HCf1TH098oz9nZyiBwLYpgd80pThLQL+?=
 =?us-ascii?Q?3FUtu6V93Guf4VydY6/R3vzPiVNSI9kKnrJcV8NeOSDM0b7VvhKEOsUIVLAM?=
 =?us-ascii?Q?ACjCjujvfXRSYBife+ilb4gkf377Ck6RzZmDeStY7lktHhvY2NlEFT5nCPdh?=
 =?us-ascii?Q?5A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: AZXdktiXqCIYBIreBurs6+miSrwYMgh/nO+4yMpP0KMf/xZ0rU+wPfBrULV3R/i9GRCMeHpS0go9w1xJY6qwgrEjeIiiDLrp9U165ydmKmdvwSXgkptJx8vDPkDeuA8G56qU2HEE07T5Ow9LrTWqoj1bC08cVT4tLnwhqJNT1snsuaK4nk4c8ebXP58CHoPwk6EMYJ5lw767jb6bTn4lSeCBHkTRtwfwghWnXN9wP+gPlyDoFr1TFTmp0Klbfw5ybWsVuVVv7nf6smDevQ+CWDV0MlqGEEQKILzzNnhuF5upFT+VPuxPGvHrNPJiE/ujTTOgYY+GC4raCFoCuCwBcICh5KNqkLPmA7vhEbCjwJAuMA7+ldTJJUV+dE1GdwJNaVHq8VyhO6sDfLXYFy7XsSHDiEIl7srTjG+GCgRcj4ovLzdfC4NoESzcozEclKAXqGrbQlnM6pdTzSluufYffD7KjM2vMVbQQA3TpScN9QXHiTy1AE57ofyHhN8aZvRM7Mz/2D532TjwsgAHYgRK+RPhH4Ao85q08I+krVIpRtlT1Z2szK5mD4jYzxdPNik2J3UpGyxtwDVOoPI/Toztnnwyo+Dn1+JcF7lhgMYeTJTO0fMfqiA1U9oXbGywigth5Tdf0O94lqRQXlslzXuKD/JcD7VNINLyGn6tvC21fm7uMGrfXl2ZUrOsLzoNdNiGWdkfh7rxtiMHQGvq0y3yqCEOzrena3lgnlK0lhoVVKMd4BilrsIShs/bmdJtppln27faLFXWanZ7E5gQvdF3l+3hFkXjM26jcyTNUZznMow=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e882e9e-8fbb-44d4-b027-08dbe77f0be5
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2023 15:08:25.0724
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h5BCCDarDu0j4GvZ0stkfJlWZT2J49NUVy2FPR/GCWYrzW3UtFGTVAssFs430roy6j9vxbwFIodY7Hv9+aRHiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6042
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-17_14,2023-11-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 bulkscore=0
 phishscore=0 suspectscore=0 mlxlogscore=999 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311170113
X-Proofpoint-GUID: vqjFQ2SZHoG_zAduQUotdckizA-6ofcV
X-Proofpoint-ORIG-GUID: vqjFQ2SZHoG_zAduQUotdckizA-6ofcV
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Nov 17, 2023 at 09:57:49AM -0500, Jeff Layton wrote:
> On Fri, 2023-11-10 at 11:28 -0500, Chuck Lever wrote:
> > From: Chuck Lever <chuck.lever@oracle.com>
> > 
> > The "statp + 1" pointer that is passed to nfsd_cache_update() is
> > supposed to point to the start of the egress NFS Reply header. In
> > fact, it does point there for AUTH_SYS and RPCSEC_GSS_KRB5 requests.
> > 
> > But both krb5i and krb5p add fields between the RPC header's
> > accept_stat field and the start of the NFS Reply header. In those
> > cases, "statp + 1" points at the extra fields instead of the Reply.
> > The result is that nfsd_cache_update() caches what looks to the
> > client like garbage.
> > 
> > A connection break can occur for a number of reasons, but the most
> > common reason when using krb5i/p is a GSS sequence number window
> > underrun. When an underrun is detected, the server is obliged to
> > drop the RPC and the connection to force a retransmit with a fresh
> > GSS sequence number. The client presents the same XID, it hits in
> > the server's DRC, and the server returns the garbage cache entry.
> > 
> > The "statp + 1" argument has been used since the oldest changeset
> > in the kernel history repo, so it has been in nfsd_dispatch()
> > literally since before history began. The problem arose only when
> > the server-side GSS implementation was added twenty years ago.
> > 
> > This particular patch applies cleanly to v6.5 and later, but needs
> > some context adjustment to apply to earlier kernels. Before v5.16,
> > nfsd_dispatch() does not use xdr_stream, so saving the NFS header
> > pointer before calling ->pc_encode is still an appropriate fix
> > but it needs to be implemented differently.
> > 
> > Cc: <stable@vger.kernel.org> # v5.16+
> > Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> > ---
> >  fs/nfsd/nfssvc.c |    4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
> > index d6122bb2d167..60aacca2bca6 100644
> > --- a/fs/nfsd/nfssvc.c
> > +++ b/fs/nfsd/nfssvc.c
> > @@ -981,6 +981,7 @@ int nfsd_dispatch(struct svc_rqst *rqstp)
> >  	const struct svc_procedure *proc = rqstp->rq_procinfo;
> >  	__be32 *statp = rqstp->rq_accept_statp;
> >  	struct nfsd_cacherep *rp;
> > +	__be32 *nfs_reply;
> >  
> >  	/*
> >  	 * Give the xdr decoder a chance to change this if it wants
> > @@ -1014,6 +1015,7 @@ int nfsd_dispatch(struct svc_rqst *rqstp)
> >  	if (test_bit(RQ_DROPME, &rqstp->rq_flags))
> >  		goto out_update_drop;
> >  
> > +	nfs_reply = xdr_inline_decode(&rqstp->rq_res_stream, 0);
> >  	if (!proc->pc_encode(rqstp, &rqstp->rq_res_stream))
> >  		goto out_encode_err;
> >  
> > @@ -1023,7 +1025,7 @@ int nfsd_dispatch(struct svc_rqst *rqstp)
> >  	 */
> >  	smp_store_release(&rqstp->rq_status_counter, rqstp->rq_status_counter + 1);
> >  
> > -	nfsd_cache_update(rqstp, rp, rqstp->rq_cachetype, statp + 1);
> > +	nfsd_cache_update(rqstp, rp, rqstp->rq_cachetype, nfs_reply);
> >  out_cached_reply:
> >  	return 1;
> >  
> > 
> > 
> 
> With this patch, I'm seeing a regression in pynfs RPLY14. In the
> attached capture the client sends a replay of an earlier call, and the
> server responds (frame #97) with a reply that is truncated just after
> the RPC accept state.

I've reproduced it. Looking now.


-- 
Chuck Lever
