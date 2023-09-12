Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A389E79D1EF
	for <lists+linux-nfs@lfdr.de>; Tue, 12 Sep 2023 15:19:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235454AbjILNTx (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 12 Sep 2023 09:19:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235320AbjILNTx (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 12 Sep 2023 09:19:53 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77D1010CE
        for <linux-nfs@vger.kernel.org>; Tue, 12 Sep 2023 06:19:49 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38C9naaR006460;
        Tue, 12 Sep 2023 13:19:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2023-03-30;
 bh=AA4Dmcuxc4pLH/iYrROgybhE6B7RV25JBcWZszv5Gg4=;
 b=Ejw4P5WrvLel61vf75NoXvXLBGpXpAfIvyDSTCjYbbBP4NXDQyR6Q4kooe4ZNaVkwwDp
 KYnbsuhwx/nwoC762n23fVOTgWkh6IVvjqhJ+jM56kcilQJoGfKq/EXqzSv7Q24kROVC
 HSGmwCHGRtQcntNxlxIc4+iN3os9j0Mu6jfoSX8t5Obu5LewHmuiYvnImS7Ewfne51tP
 MSu/oxDzwzXk/4iKswXl/gnvVeSJbI40wOchu70BbHPhvarg4Dpl6j8zV277a8CS1WuY
 ET8P3oo79lVY3pAWhfYX33Jgmupfm6hpTj/CbBxZUYwbqOg+FkIZGsWgH0oaLCTzkbOf zQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t1jwquwj5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Sep 2023 13:19:46 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38CC2Tgm032969;
        Tue, 12 Sep 2023 13:19:45 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3t0wkf0afb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Sep 2023 13:19:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jdSbJnyi3nVaEbiBX8emvIomAnDXhBGU9nVujHxubq0Euj96V2zlt8cLIMCcGXXnE0a1Kg2gYo7zqHJnz1KF/6NxKbFtNoyWocZDhFTD7Vy5AvDhX6C6L7w98bwK/7sWiY4U39mUDHOJ1fJ/PtFPdBDG2ysLbh8b83Ty31CXKy8VkDGy74D8REuBLx9E3s2UeSgG2shNIpv/I9UOoGmQYUj7GEkhk5rWSAgNluHL/FJF0a3YBMAxeznQzhSzrb9oxSdUSDTOXeHi5Tkh2GE5omNdnR9asWso0JlYtRZDHqP9JH07Bm6cv0aIHreH+ogDoQ/gFjChDeTueK4TfquctQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nTo29m18EM2dIs7dz6sY/HMCu9tCO0FCpLJyjJVuqUI=;
 b=k/tsIUXabKcr8NK4m31USE601dlmXYQ0iXaZyKSsHbgb7l3VKWi3JL6FNbyHezMlJgZzPkiHcY2nwXlpblDGNPVC7tav6MFZ+at+CYm+Rwz6M/iFdolrJpnaWsz4UDJfVtQ7akN+zt3MZoCUsk9vc/7lmV4B5IQnptTJcUKWE0krk95oVeuFsydIPOQLvQHxIo0e8nlIgNJHaB0AHUmGy92Kp/MU0RMe3SUG0OiA0VE8wEpz5vWHmW0z+vBfBjIB49eMmJ6J0v853xVXojZ5vgasrJsoqRs242FPR/urslmSBVw4n7J2x0+QnCpkwO+bk91lQWJ6eGnKyDgf8TmiHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nTo29m18EM2dIs7dz6sY/HMCu9tCO0FCpLJyjJVuqUI=;
 b=fUc/Cy5JEsfdxxtgZqYknbB40Fc2ODXzc199nF69MGqLqUpk4NrAheCtqf++brLaOHm+SB9AzxZ6GlIxlUCYls9xP8gMXCI19DBGr4mYHXaJpzyUyGk9WKQn67afwbCot+jIeRFvDA8ZNarIz6dHRmgzhSEsSuh4D9s3gqZtIZI=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DM4PR10MB6016.namprd10.prod.outlook.com (2603:10b6:8:ab::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6768.35; Tue, 12 Sep 2023 13:19:43 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e%6]) with mapi id 15.20.6768.036; Tue, 12 Sep 2023
 13:19:43 +0000
Date:   Tue, 12 Sep 2023 09:19:40 -0400
From:   Chuck Lever <chuck.lever@oracle.com>
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] nfsd: Don't reset the write verifier on a commit EAGAIN
Message-ID: <ZQBlbGTLi78giJQd@tissot.1015granger.net>
References: <20230911184357.11739-1-trond.myklebust@hammerspace.com>
 <ZP91EwHCt0/c0jvJ@tissot.1015granger.net>
 <f754d8a170b967d1523d103837eaeeb5e9a6c85b.camel@hammerspace.com>
 <684AB86D-ADC7-44B0-BA54-FC23DB0B4670@oracle.com>
 <dfc7823c29b2157290828c360e9dc7c64536904b.camel@hammerspace.com>
 <0B4074FC-C08A-4233-AD9D-FF7C405ADCF2@oracle.com>
 <c25690739d06d614b68882e6f07e20f08c7f5982.camel@hammerspace.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c25690739d06d614b68882e6f07e20f08c7f5982.camel@hammerspace.com>
X-ClientProxiedBy: CH0PR03CA0218.namprd03.prod.outlook.com
 (2603:10b6:610:e7::13) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|DM4PR10MB6016:EE_
X-MS-Office365-Filtering-Correlation-Id: 73983c1d-bc93-4ce4-97b9-08dbb392ed60
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z2XVrpsih9o9Vibd2VnfhsYaCxwVX8N1wl+dc42jdrBUwE/qcz8es1za6Vojtq5IQF6blWM2zcvayaNmYFTpe3ciGSJKMhEaeXbMIGMQQtwQnaI5WjrBx/9EojWq7x02LmZKTfsOdt5Pugs2PMEjjHj4T0eDMCbxYOA6E6I+f0Lvn24FS4EhtB4Mtol4ttMrygLbV65PMcSoWEWfrlARnp7wJ/LKys7k5yZLFSwOQos4tb+S1Tp29Zv9FXjvWdMD97GCYj2HK7RIkas4WsHL5V3FN3wmagxnrsuYi782la6nUCmxoMlbpTr9EPU/bjCv1sMKbZ7OESIQIYMvPJtLaTIrLRwOH34VnojdkKJbpne7JZvysn+y8OJ8BOIrgtEv8Tr9HtqLXluTL0Awf6+jpVV7c/DzglaPFJ3NHz9z2W1fNjxmRwXI+HEnbTO8GPmry1jjjwkbunoUq9b6ke09P7qesMIWIo15vAU+aiG9UTWfkXtyC9YJhNQeeQNdL8/EoP+Mkp6fP2NUnZ/UG/zdcTZGesXLe9dqIcclfHqE1hVhTb7isxXyYgIXRRPqhrAG
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(366004)(39860400002)(376002)(136003)(1800799009)(186009)(451199024)(41300700001)(6486002)(53546011)(6506007)(83380400001)(6512007)(478600001)(2906002)(44832011)(66946007)(5660300002)(66476007)(66556008)(6916009)(8936002)(8676002)(316002)(26005)(4326008)(86362001)(9686003)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?VulsjBI1hZpAqXBv+kG64VHBshbhnIdyrhp1Q24jr6hVV9OOAUEwlknVpB?=
 =?iso-8859-1?Q?CSuo72qmdk3fBvko2fh6NiTkMQapCyEFND2qx/JeNKN8C2S8sGD1q87xll?=
 =?iso-8859-1?Q?8fYb+/ZyWCftOq0I98/znTasMCNhJnxyyTh0riLfRVw15U/DZtCq8Lebe8?=
 =?iso-8859-1?Q?5fHeATIL2L3hTznQZqhQDjnjGQH6XzYjRo+DviMbDJEjSDFl8uDVC+mpip?=
 =?iso-8859-1?Q?Dj0mH/tDwgoNKZVYGFoQ9dfvqKM1HqlM3/E7Stx9q6KSQyyG2JG4xMzSSi?=
 =?iso-8859-1?Q?My09yjILTB/Lc7cNzL5D7Sseu/I9+2d2L2e4ikzCOzH2DaswdEb/PVRJ4S?=
 =?iso-8859-1?Q?gZ7ptIgCZuUKYya6gfHT0VkHcxQMxR9ZRr/4qFP0TjLaRpplShxzu+iy8Z?=
 =?iso-8859-1?Q?7buqqn8hdsjL45bWGo9hFcKmSPNdG9QNnPHgyztJC4+9THLW6zKk6isHs0?=
 =?iso-8859-1?Q?nu3pVmQ4x/n1P8mQ8PVeWsfMl0Nymmu5D0YD55W5tOTPt/iuyEBcUvQ6Z3?=
 =?iso-8859-1?Q?xarATAnTmrTeE6JBrCsxh5ECgNIWKrGZX8t50OaI9uU7Lryqev7iuNi3mz?=
 =?iso-8859-1?Q?U4mFxtclMaXQ2x3UkcvJT5HWpExx8YYZLhoFeX18GBTjX4LrExsq1OyPE1?=
 =?iso-8859-1?Q?et4lvPjVVbxzBlr/h0UN2tKNeaOd5Q33zrh7pLkZ5J45VteqDHFKi+WIwr?=
 =?iso-8859-1?Q?iYW/figTUeX7+uEV2hdSd9xfnj2VPBw0Uriq9D7pHiTnLyExNvBCRqrMus?=
 =?iso-8859-1?Q?vxE96hniJA7TN2XF9e//CSkE0xw/A0r/mqN1XLdD0VwCXmTGP2loaKqoTq?=
 =?iso-8859-1?Q?pbGMP8a0uYHgfptU/7CLkjxb6a5IgPXRFbo8ouTCOoOTjM22xsyNlnzXr/?=
 =?iso-8859-1?Q?8ulxUbuxd4WJmq5jqIlXWkh7edUm2E81mag38YncWVi1bmXQuau78zM/xD?=
 =?iso-8859-1?Q?2XFbKNu0zjjtS2RjEYLsbGCKNb4gYmoacu/i9gXiD2OHvo2mD3bj5xjllj?=
 =?iso-8859-1?Q?apvKlGmNMmdmXWh7wpSXsBGgTRcRQN1GvvCEfa6bhlclrlCaUafeOyMrNq?=
 =?iso-8859-1?Q?0tmRq7ZUPSztwi9LaMCk9ZtyWwOTgt4ryA9Q5jEzLPmJhoflUJ5rZgl2yY?=
 =?iso-8859-1?Q?v5lnVA0pGvW/Ig3TsgbTYJwwMetydbWH+I7/MafWnpVbTxZa3hPnPmKMYH?=
 =?iso-8859-1?Q?+7UW3kvc6sKg/clp5BS0YvLP5FApS5SGVYmZVwzSfaYCj0UbFT1g1KIEGR?=
 =?iso-8859-1?Q?FSoxJh3OsJg4RysGEya/9F1eW0yetUnJ1OWeY++sihi+WBS6DnCOPx9v8x?=
 =?iso-8859-1?Q?Up0Uyje/1oRrw0A3r9sfzztGsdZKhlzKj45+WcXow41dHH8KNhxtP6h35c?=
 =?iso-8859-1?Q?dYBf0A2+kDa4/ZZrTd0uxmmveAPcv0/ZDLytNxyQKpI4WA/+ui/2/86Gjw?=
 =?iso-8859-1?Q?7bz7cvTHvR8MW5BRCRR2LiycoTOJpbs4NfHfyjQl9YcWD+70j7SckMrEOn?=
 =?iso-8859-1?Q?RwailWpZTm3FNVdWv2Udq67VLjXgbT80+tnGqCPlVJlBCMZJvGbGkTgVBo?=
 =?iso-8859-1?Q?1sER96Y+fT3WpO27JFEicFWWwo0BwvTUS0TV/A3UsAWHHjduda4EqgPnCH?=
 =?iso-8859-1?Q?1Sx1JnMtSu90CCjhTcjYhSCC8maFISKLD18FCDSKj0Fp3dK8yINkD76Q?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: KXKYu11cUQVapziVMi77OPCryrVgUQsclPYdxQveok1UOIFiFssLitdbzJIimJ1CLGKU+dMVHt3Y2/O35P9zOy0wG4+6+QDHAz7T/asYqF06/wmCT35Q892bwXujgfSgQWg95sPSj8goLOQ823qMGWoM/dyJ2A613PtQb7F6qpzBYihmN5kxlJd6bfhDe5GIhxD0ljVM4WBHHtvyUMOfvc9Rn2hXeOy9auLNEQE0HEtl2uCb21F6vdQICXoe2zC39TAbQz8Wh9Iz1yrQfD8nedl7/58Xy+oUVQPodSGuZ6LuGgD4JWTz4/7wxsCbNaEh4CHIldPyOrXNnXjS/b8JXAJXLoDIjIz1SWdTgw51ffhKIJD1n7tMlfaCduEFfBWavLkICn0dg0phyQ2gqSouabzv6Ot352Xg+8E1rx4nrLtazr66/fIPntcID1TcgRT6tSFUtZDYTu4dMly3Yvnzmqm2Tk693UlsDbnAhyshV/i9U4buaJqI2I7jYMSWg+zqLBoR9CmZ2pueIWQzt8oHrQeiryptW1EzLtHrNkfwi9FpaEsX2YH3e+9b43L86Mlr2xr6E6pqaOJxMogR016jNVpOjh8ZEKndHpWKA3SSdCSj2J+BVD3AinyUcc0Bz3U3LUe28OXoB73JlaqKIu42p42vn7Md7wXX8bPPhlatn0afWiO4d3tNu7Jnkqj+7RL7dccI9mDH91U+g59dB2gCYES4Vv8avp5VyvMxx2tnZxQllMFHovKn2ngTBWuhTJ+ejCn8uaoEp48Blk42hGJCq4gNyUvkcu7JTD+gnoX6F+d3HCpTdMGkHyY/sXQ+ZcsI
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73983c1d-bc93-4ce4-97b9-08dbb392ed60
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2023 13:19:43.3206
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CN9DP2ZtF00wY2fAjgW1M5BZ3JeacCdxZvN/repspJYgKRd/oEai88Juk1OCobAfeSjSbvmghP0uACXuXbrREQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6016
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-12_11,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 phishscore=0
 spamscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309120110
X-Proofpoint-ORIG-GUID: OHRA6LG9t1nsO8xo1uwNxouncgCIw3ND
X-Proofpoint-GUID: OHRA6LG9t1nsO8xo1uwNxouncgCIw3ND
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Sep 12, 2023 at 01:11:28AM +0000, Trond Myklebust wrote:
> On Tue, 2023-09-12 at 00:45 +0000, Chuck Lever III wrote:
> > 
> > 
> > > On Sep 11, 2023, at 7:42 PM, Trond Myklebust
> > > <trondmy@hammerspace.com> wrote:
> > > 
> > > On Mon, 2023-09-11 at 22:10 +0000, Chuck Lever III wrote:
> > > > 
> > > > > On Sep 11, 2023, at 4:54 PM, Trond Myklebust
> > > > > <trondmy@hammerspace.com> wrote:
> > > > > 
> > > > > On Mon, 2023-09-11 at 16:14 -0400, Chuck Lever wrote:
> > > > > > On Mon, Sep 11, 2023 at 02:43:57PM -0400,
> > > > > > trondmy@gmail.com wrote:
> > > > > > > From: Trond Myklebust <trond.myklebust@hammerspace.com>
> > > > > > > 
> > > > > > > If fsync() is returning EAGAIN, then we can assume that the
> > > > > > > filesystem
> > > > > > > being exported is something like NFS with the 'softerr'
> > > > > > > mount
> > > > > > > option
> > > > > > > enabled, and that it is just asking us to replay the
> > > > > > > fsync()
> > > > > > > operation
> > > > > > > at a later date.
> > > > > > > If we see an ESTALE, then ditto: the file is gone, so there
> > > > > > > is
> > > > > > > no
> > > > > > > danger
> > > > > > > of losing the error.
> > > > > > > For those cases, do not reset the write verifier.
> > > > > > 
> > > > > > Out of interest, what's the hazard in a write verifier change
> > > > > > in
> > > > > > these cases? There could be a slight performance penalty, I
> > > > > > imagine,
> > > > > > but how frequently does this happen?
> > > > > 
> > > > > When re-exporting to NFSv4 clients, it should be less of a
> > > > > problem,
> > > > > since any REMOVE will result in a sillyrenamed file that only
> > > > > disappears once the file is closed. However with NFSv3 clients,
> > > > > that is
> > > > > circumvented by the fact that the filecache closes the files
> > > > > when
> > > > > they
> > > > > are inactive. We've seen this occur frequently with VMware
> > > > > vmdks:
> > > > > their
> > > > > lock files appear to generate a lot of these phantom ESTALE
> > > > > writes.
> > > > > 
> > > > > As for EAGAIN, I just pushed out a 2 patch client series that
> > > > > makes
> > > > > it
> > > > > a lot more frequent when re-exporting NFSv4 with 'softerr'.
> > > > > 
> > > > > Finally, it is worth noting that a write verifier change has a
> > > > > global
> > > > > effect, causing retransmission by all clients of all
> > > > > uncommitted
> > > > > unstable writes for all files, so is worth mitigating where
> > > > > possible.
> > > > 
> > > > Good info. I've added some of this to the patch description.
> > > > 
> > > > 
> > > > > > One more below.
> > > > > > 
> > > > > > 
> > > > > > > Signed-off-by: Trond Myklebust
> > > > > > > <trond.myklebust@hammerspace.com>
> > > > > > > ---
> > > > > > >  fs/nfsd/vfs.c | 29 +++++++++++++++++++----------
> > > > > > >  1 file changed, 19 insertions(+), 10 deletions(-)
> > > > > > > 
> > > > > > > diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> > > > > > > index 98fa4fd0556d..31daf9f63572 100644
> > > > > > > --- a/fs/nfsd/vfs.c
> > > > > > > +++ b/fs/nfsd/vfs.c
> > > > > > > @@ -337,6 +337,20 @@ nfsd_lookup(struct svc_rqst *rqstp,
> > > > > > > struct
> > > > > > > svc_fh *fhp, const char *name,
> > > > > > >         return err;
> > > > > > >  }
> > > > > > >  
> > > > > > > +static void
> > > > > > > +commit_reset_write_verifier(struct nfsd_net *nn, struct
> > > > > > > svc_rqst
> > > > > > > *rqstp,
> > > > > > > +                           int err)
> > > > > > > +{
> > > > > > > +       switch (err) {
> > > > > > > +       case -EAGAIN:
> > > > > > > +       case -ESTALE:
> > > > > > > +               break;
> > > > > > > +       default:
> > > > > > > +               nfsd_reset_write_verifier(nn);
> > > > > > > +               trace_nfsd_writeverf_reset(nn, rqstp, err);
> > > > > > > +       }
> > > > > > > +}
> > > > > > > +
> > > > > > >  /*
> > > > > > >   * Commit metadata changes to stable storage.
> > > > > > >   */
> > > > > > > @@ -647,8 +661,7 @@ __be32 nfsd4_clone_file_range(struct
> > > > > > > svc_rqst
> > > > > > > *rqstp,
> > > > > > >                                        
> > > > > > > &nfsd4_get_cstate(rqstp)-
> > > > > > > > current_fh,
> > > > > > >                                         dst_pos,
> > > > > > >                                         count, status);
> > > > > > > -                       nfsd_reset_write_verifier(nn);
> > > > > > > -                       trace_nfsd_writeverf_reset(nn,
> > > > > > > rqstp,
> > > > > > > status);
> > > > > > > +                       commit_reset_write_verifier(nn,
> > > > > > > rqstp,
> > > > > > > status);
> > > > > > >                         ret = nfserrno(status);
> > > > > > >                 }
> > > > > > >         }
> > > > > > > @@ -1170,8 +1183,7 @@ nfsd_vfs_write(struct svc_rqst
> > > > > > > *rqstp,
> > > > > > > struct
> > > > > > > svc_fh *fhp, struct nfsd_file *nf,
> > > > > > >         host_err = vfs_iter_write(file, &iter, &pos,
> > > > > > > flags);
> > > > > > >         file_end_write(file);
> > > > > > >         if (host_err < 0) {
> > > > > > > -               nfsd_reset_write_verifier(nn);
> > > > > > > -               trace_nfsd_writeverf_reset(nn, rqstp,
> > > > > > > host_err);
> > > > > > > +               commit_reset_write_verifier(nn, rqstp,
> > > > > > > host_err);
> > > > > > 
> > > > > > Can generic_file_write_iter() or its brethren return STALE or
> > > > > > AGAIN
> > > > > > before they get to the generic_write_sync() call ?
> > > > > 
> > > > > The call to nfs_revalidate_file_size(), which can occur when
> > > > > you
> > > > > are
> > > > > appending to the file (whether or not O_APPEND is set) could
> > > > > indeed
> > > > > return ESTALE.
> > > > > With the new patchset mentioned above, it could also return
> > > > > EAGAIN.
> > > > 
> > > > Sounds like I should drop this hunk when applying this fix.
> > > 
> > > I'm not understanding. Why would you not keep it?
> > 
> > generic_file_write_iter() and its brethren are two calls in
> > one, if I'm following this correctly:
> > 
> > 1. write
> > 2. sync
> > 
> > All the other places you change are "sync" only, so it's
> > fairly obvious that those callers get a return code that
> > reflects a failure of "sync".
> > 
> > I asked above if it's possible for the "write" part of
> > generic_file_write_iter() to fail with STALE/AGAIN before the
> > sync part is even called.
> > 
> > You seemed to be answering "yes, the 'write' part can fail
> > that way" but I may have misunderstood your response.
> > 
> > If the "write" step can fail, isn't that something that should
> > be reflected in a write verifier change? If yes, I don't see
> > how this particular call site can distinguish between a "write"
> > failure versus a "sync" failure.
> 
> The point of EAGAIN is that just like NFS4ERR_DELAY, it implies no
> stateful (read "non-idempotent") changes occurred during the operation
> that returned it.
> The call to nfs_revalidate_file_size() will happen before you've
> changed the page cache, so if it fails with EAGAIN, it won't leave the
> file in a state where unrecorded changes happened, nor will it cause
> existing page cache changes to be lost.
> 
> If, OTOH, the nfs_revalidate_file_size() returns ESTALE, then the page
> cache changes indeed will not be recorded, but we don't care because
> the point is that the file is no more.

Thanks. Applied to nfsd-next.


> > Or, if the vfs_iter_write() call here is guaranteed to never
> > be a sync write request, then again, I think we want to reflect
> > all failures here with a write verifier change.
> > 
> > However, if STALE and AGAIN have the exact same semantics
> > for "write" as they do for "sync", those failures can be
> > thrown away too, and I can keep this hunk. Are you saying
> > this is the case?
> > 
> > (this is /only/ for the vfs_iter_write() call site. The others
> > look OK to me).
> > 
> > 
> > > > > > >                 goto out_nfserr;
> > > > > > >         }
> > > > > > >         *cnt = host_err;
> > > > > > > @@ -1183,10 +1195,8 @@ nfsd_vfs_write(struct svc_rqst
> > > > > > > *rqstp,
> > > > > > > struct svc_fh *fhp, struct nfsd_file *nf,
> > > > > > >  
> > > > > > >         if (stable && use_wgather) {
> > > > > > >                 host_err =
> > > > > > > wait_for_concurrent_writes(file);
> > > > > > > -               if (host_err < 0) {
> > > > > > > -                       nfsd_reset_write_verifier(nn);
> > > > > > > -                       trace_nfsd_writeverf_reset(nn,
> > > > > > > rqstp,
> > > > > > > host_err);
> > > > > > > -               }
> > > > > > > +               if (host_err < 0)
> > > > > > > +                       commit_reset_write_verifier(nn,
> > > > > > > rqstp,
> > > > > > > host_err);
> > > > > > >         }
> > > > > > >  
> > > > > > >  out_nfserr:
> > > > > > > @@ -1329,8 +1339,7 @@ nfsd_commit(struct svc_rqst *rqstp,
> > > > > > > struct
> > > > > > > svc_fh *fhp, struct nfsd_file *nf,
> > > > > > >                         err = nfserr_notsupp;
> > > > > > >                         break;
> > > > > > >                 default:
> > > > > > > -                       nfsd_reset_write_verifier(nn);
> > > > > > > -                       trace_nfsd_writeverf_reset(nn,
> > > > > > > rqstp,
> > > > > > > err2);
> > > > > > > +                       commit_reset_write_verifier(nn,
> > > > > > > rqstp,
> > > > > > > err2);
> > > > > > >                         err = nfserrno(err2);
> > > > > > >                 }
> > > > > > >         } else
> > > > > > > -- 
> > > > > > > 2.41.0
> > > > > > > 
> > > > > > 
> > > > > 
> > > > > -- 
> > > > > Trond Myklebust
> > > > > Linux NFS client maintainer, Hammerspace
> > > > > trond.myklebust@hammerspace.com
> > > > 
> > > > 
> > > > --
> > > > Chuck Lever
> > > > 
> > > > 
> > > 
> > > -- 
> > > Trond Myklebust
> > > Linux NFS client maintainer, Hammerspace
> > > trond.myklebust@hammerspace.com
> > > 
> > > 
> > 
> > --
> > Chuck Lever
> > 
> > 
> 
> -- 
> Trond Myklebust
> Linux NFS client maintainer, Hammerspace
> trond.myklebust@hammerspace.com
> 
> 

-- 
Chuck Lever
