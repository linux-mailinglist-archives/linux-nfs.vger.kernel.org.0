Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A42147999B6
	for <lists+linux-nfs@lfdr.de>; Sat,  9 Sep 2023 18:25:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234119AbjIIQZg (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 9 Sep 2023 12:25:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236884AbjIIPUH (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 9 Sep 2023 11:20:07 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE75F1AA;
        Sat,  9 Sep 2023 08:20:01 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 389FF43X016010;
        Sat, 9 Sep 2023 15:19:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=Jth4Bdz7m9EA2uCkSf0PZB5zKKFnsJ+busH1eYlAYIo=;
 b=jUYRfXx4pT9tA8m6i2bW6DSi8NrkIXwqMRbb6vdW4u3BSgz5J5vSCBlTARq/vwSK2G2X
 Qhf774gEFrqQwYvt6o81J+Dxz31o+hKo0SNUgyX//7vGUtPLfUqgU5+h0wfPah+tGghK
 9z3ejqN/ps32A3YswG/bZOtb7S+HJqRevfjC8tSxtkSYm0GKbDvmLBh4O+NgXyOMRm/F
 QWuGJ8D7MIq4/L8/g4Cqt1rzb6ID2ZFw5yJeN9WkW3OQ8H/YZgGZLQA1vn2tY+1B1h1k
 /GGYqtM8aJDmP0opJHPXFyO3MzBkqiD/IRhDvf+pbczPAVQevkuym2HqVx3L4Bzjk+dN qA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t0u68r02b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 09 Sep 2023 15:19:48 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 389EosEX002305;
        Sat, 9 Sep 2023 15:19:47 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2172.outbound.protection.outlook.com [104.47.55.172])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3t0f58wjgb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 09 Sep 2023 15:19:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TefvRTh/f0UsJI/VshWAwQBN5Tl6xTGmWz5nJBukF2Dm5kr/h37bFKYq0ih3avfXMZqPFRC7mla98F+exXBBJ8PpBSgVzKe1eOzud3+pUBOIRCw6pA0Xxf2aTGcy/qzQtNxPBCBDV5G9BNsJS5bKfx3SkdpsCMqn12vsbzJev3GvdWbmUdoKfHdgSkRxbqkVgTV+nlBCxDyyyDOVVNgrE/iW3BaXpUG6R1rc9F8kupK5TkPaRFN08m7XKoJdaRE6Tb+SqYbP20rEbTh9YieBffORAJji6Wj9pv+QFCtI/xljV8IW+pwlgnJdgXoh3NBp/q4wCmNX3+AbYSIH5voEOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jth4Bdz7m9EA2uCkSf0PZB5zKKFnsJ+busH1eYlAYIo=;
 b=DLYMAqtWeev5MEr/GcKrENkvxEfRVxVxUBvG8EjEs5dyZcISE1nYf2BRDXwwGtKbC5kANI9Z7vMuuaEY0NnxFwX5x85YFGYiAgHxx6v95nm+Besn9k6g7kv78QB+TsACSt7XP3RIo7CoCO0EZJboexOZwueYcwWD9mgDZLwKmEsf18pNH8AgwyM1FYKYhR6xcJTKqvlkubmmIpCnjZI2uStGHHeMjq7EvWdMVGmZZX6v2xQ4FgHTOscdSj34k3Yt51zYlQWBgpA8DzPRjnuPlulfw7QHvOTx7wtT6ZPHmb9JOQH4ze4htWtLoT5DP6vgUCVm5x42Li3EIkpHkJgMPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jth4Bdz7m9EA2uCkSf0PZB5zKKFnsJ+busH1eYlAYIo=;
 b=ZibKc4XlgjDuuyQGMioqBrzYe4NKdJPLJlF5K2btJLREtQldmxWU3VxAm8ymvB+k2+sLHSiHz/7TbNVCaLpLhhuj+j/iXMhaaQGpSw1YA/MPcRAymgk6aLAB6sfl9o4yD51kLVIIsyTZn16JC77HFpA1c52tqhQfepIhUCk4RHM=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH3PR10MB7308.namprd10.prod.outlook.com (2603:10b6:610:131::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.36; Sat, 9 Sep
 2023 15:19:45 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e%6]) with mapi id 15.20.6768.029; Sat, 9 Sep 2023
 15:19:44 +0000
Date:   Sat, 9 Sep 2023 11:18:34 -0400
From:   Chuck Lever <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Neil Brown <neilb@suse.de>, Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zhi Li <yieli@redhat.com>,
        Benjamin Coddington <bcodding@redhat.com>
Subject: Re: [PATCH] nfsd: fix change_info in NFSv4 RENAME replies
Message-ID: <ZPyMyv1nNFV2whKP@tissot.1015granger.net>
References: <20230909-nfsd-fixes-v1-1-2ebc659c0cf4@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230909-nfsd-fixes-v1-1-2ebc659c0cf4@kernel.org>
X-ClientProxiedBy: CP5P284CA0008.BRAP284.PROD.OUTLOOK.COM
 (2603:10d6:103:95::13) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CH3PR10MB7308:EE_
X-MS-Office365-Filtering-Correlation-Id: 8314977a-8499-4496-ba95-08dbb148327a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ghbjcz4cOBpR89euWo3PrRhf6ZTR/4QCZILuR4AC4BMf3AZoYCXQuImhsjUzxmrSU9tqi8eoncvMPyfPL2PzvF9C05aJDrQYJKFoMVk2WU8fBVfb7kbR19wrzl6YUi41x89Sx47T+iCYXPH9vfXoo+yz86HBpkg4ILsXxK4sqWTW4hvJ9plis12tRxJaG5aLp6+smVYuq7lGRgmguam9BFyeX8d5Is3PD4UMkxz2ZNn5c3VfX3nNSDeVA/2lmcB3ekUcqzQN9+Qil3ozspeL9Jo2fjX1yX9e5sIPt1dGXLYk9SOrHJ/G+NhJUWN2juVFZcR077wORIUF1IIdcSXm3cI7Ahd3y7edyWmoYOQ8clUAd4hdPcIF+AZg6YT+r+yVQ7lEVUwY2HqjYykzGT8jVBvmqJglS8D1nV/KKm1voQwAaR3OhCTYyvMUi7DgAPgzuMmxj1fxbVHBmPAbkYlvF2dJcj1622gLkxts0ZzCClhGDIIWP2i+1magUsoP2sTeuSiBTmPmhrEFANB7saHZGuc1X3w9SRs6Ns2bl+fRLsD06j/aQohO+SkZhS5Md+7R
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(366004)(396003)(39860400002)(136003)(1800799009)(451199024)(186009)(86362001)(38100700002)(8936002)(9686003)(6512007)(6666004)(2906002)(478600001)(4326008)(5660300002)(44832011)(41300700001)(8676002)(6486002)(83380400001)(6506007)(66556008)(6916009)(66476007)(66946007)(316002)(54906003)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fI+5VrhBENIz0wC08yCFBEE+dGDD+R66Cr1lryxQ0+CQBI/xbLsFwFB6pLNQ?=
 =?us-ascii?Q?DFhRsBX1oOM4MzmIRD2YJ8n6O87vAMY+JtKe+yjFlcsMyvMgT3r5JhAeokMd?=
 =?us-ascii?Q?MsSDUydOwrLm5AirbNYtlvyHwS6Cy4ecXTHywWJ4Dju7oro2EXJbF7vXOU8v?=
 =?us-ascii?Q?edn8jUvRpkaiHTBFgQss7cvcL395FRVEYTB6bPwNXeYBlmTsxVft1ewiB/2z?=
 =?us-ascii?Q?mfUHzVUJwGyC7YkQv+NS5VQSPokliX8b0ZmiVHLm2n+zUQwWy0g4jHBfnprs?=
 =?us-ascii?Q?MxwTyjUV8MXj+V/Yx33CRrhSOwcem+lbsZPqeTjt+f+p4cVbFWWk1t8S/m0e?=
 =?us-ascii?Q?DNkqn9HGDbNr1oXuKG94mQpa1oE7ocPCdJjRuoHGag4Mz8WUN5ykZ2EPK/em?=
 =?us-ascii?Q?tYvkQ57D639xJBBd47AqOb511ttn+B39JBtVdq5bVy435WMEbVcZ3Tz9/OAH?=
 =?us-ascii?Q?SAs3JcZrxTHX7RNcChFLdISTTPQgY6NhL48V03ifos3XrspRru4GDANb+QxS?=
 =?us-ascii?Q?jI8x/RpXb0EvblD+HYUlFNUaAIEdlIQAwhqAdC0YiY/q3JWlnqNQbLRoA9+X?=
 =?us-ascii?Q?s8Urgryo1BWAcnrEF3HLhHsdmXLXXBP/UoeO116bzQEfoQIJ8cOmRvE75kLJ?=
 =?us-ascii?Q?3PaouygWoTMn5KZNst4nsCKTfxjE32ogHCyr3FiW8+j9R3MeoDpWP2+qU/iz?=
 =?us-ascii?Q?jYUOIil8qul2JTXfS58E/Ezbshw+BuHeSh7ySerWw5VBwd1kFgPJaX1UQCY6?=
 =?us-ascii?Q?JleYhw5ubjglJWIGlawMYQg8TPeFKgXDPcqamr+Tp13ewskUyh25TUPkEz8Q?=
 =?us-ascii?Q?bRUU8c7br4ym2R7/zT2zzWyyyvRyC4UInMP4DjN6SNX3iIcuvEp8zU1iMeOJ?=
 =?us-ascii?Q?DoL3Kyv2GUkouIX3VKgGPnUbvAGYx3xR8bjp2aYd+Be8xSu9IiAoXTZHoW7F?=
 =?us-ascii?Q?SdwnbJfnCv2jmAo/ECJBBy9ZscVJ/lUnsgPFIaWB62fO+nT36OtbDZIsc0Ln?=
 =?us-ascii?Q?GPg9uo0X0ye/6w6ZYCHTn2rKqonraYoDGPT0Nvn4zptHWjiW0NeLadlWZRjU?=
 =?us-ascii?Q?N/Uz8LQg+hg5FhHRTRtjn59XsazttVaqSwk8ESlpc3zeTRi7HqRrFYkbNJNp?=
 =?us-ascii?Q?EO/WxAT2G3oZvQHhuMDO6uwuEqs5JHElvaQrse/4+3aOpjp9VwA4qCkv/8r4?=
 =?us-ascii?Q?9VOtLuH8A8UsRmKNfwZ6Czbn0MRiZB1BgTqj66YFq/+g4btkBO7DyO9VgPqD?=
 =?us-ascii?Q?CNk32MUZ476Cbn8LeWgd3jME3P/hJmENSszyrBzfNruq7KBsFky/5C6s03yk?=
 =?us-ascii?Q?Bb8cMpDl7cUgFkudawH4ZeCk9lpVURqQvG5RH64Uw4Zi6zajLhVXuXUHkk6W?=
 =?us-ascii?Q?SaAUKePht+KA+l7fp2kz+QX7ZSbKWzqN0i2g4TSdbFjuwxgS4Te9fkuuXH5W?=
 =?us-ascii?Q?jsY3Pj9jTwZXUeIA7DZ/X2unE/qK8BksIZ5XFg2VG/gLgakYaaupdNJXaixR?=
 =?us-ascii?Q?6KB56JYtbKEYZd5V7PujFLb4SoATry3bYx0oPdGRPJ2ERJ4AOEyEAGI3JuMU?=
 =?us-ascii?Q?YJSSfzabZu2E/a3afGIaVobODbDrR2PZRS7DBXE4Rgo51In/B/+0JPisZ6dG?=
 =?us-ascii?Q?Tg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: mzyVCkg9heFETTH0vwXrk92PbMzkVBr3HCjdmCk5mmOuL8+stL79y2KpBKRlxgshPRt2tmxYRpY5uW5sPt2fj0cXzZcm4P11cv6A3PTg1ycm+eeojdXYESRgk9pqwLBpRgpog+Ie+//R4wjmi5XhYfy9VEukXHvGg0NTHRGVkNezj8k5vrWKe1dg92rc+xxvPVgFqPhDK+O3foKK7xS5uVaqyNKoD8Ja1Heedc4B5Nly95gPpmUWJVI4QdvYLkEqClUpgHGbYOsIutILSXhz7ynVdnekrowEtpTktUTp1eYls7G5d37+h8i6qtNPRl+0NAiCM9mM1n/jcnZPWJDIb+bcufIZKlckT4BR5Z2BBCaTSfh42X5fIggBJZCshBVVG5L7mDGI9d3DftzaAt7JZ3qmZgaRdYOjxp9MbBR/kh9ZetdvHEuBbgOpVmvRaWgdUboai5tUfP5g0IgPMWLrDs0hEXFCtYrHwHrV5Qkv/0SARJzt1IPMgw9kz61JY7FG/9iebRvAwb8L6GGNmaJ5QAsbT8EfIEVw0gpqdF7YAnQf1mu5p1LdJR3pn8+al5Qc1IB6PlZoeqcmVf8Sx7c6fld/kUNe/060TgAFgHapxjdKqAzT83Nhx1LysbaBwGTanX+S4Y9GDVGmxLpjsGzbJpK2BzuU1pxr/3etTD3rHA+m592SIV6L2svfqK+izrgXB2irx1o4MgjtqmA66CqTN+I4JYg3H/GiR7i3Lk5gtve8cnzMW0akYV4VnH2oPzfm7BsAt1PxszutLoVWCJKWDumKj80jCaoHrXMEyOMX2tD/PSbpLagKxIJ5Q1tVNF2VwTRaO9g66cS1WoNhGJxGmOYNF4hk4bkk/f398wdj9rCfQWwQlK/VBf+684sPFj0R+U2b7wUU3YndLLznlpgEFw==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8314977a-8499-4496-ba95-08dbb148327a
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2023 15:19:44.7204
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zYbrq3njP0HmGLiRF6FBrMi9hy64UdkXlB9pt0HGJzFbkp6IdZubEmVR5CgrS2Q8KnOxTbXevHyWQnnH+2CHKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7308
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-09_13,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 bulkscore=0
 adultscore=0 phishscore=0 spamscore=0 mlxlogscore=832 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309090139
X-Proofpoint-GUID: 1PbABwPm3rJJvtaD78aNNvS1fdJAURX2
X-Proofpoint-ORIG-GUID: 1PbABwPm3rJJvtaD78aNNvS1fdJAURX2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Sat, Sep 09, 2023 at 07:12:30AM -0400, Jeff Layton wrote:
> nfsd sends the transposed directory change info in the RENAME reply. The
> source directory is in save_fh and the target is in current_fh.
> 
> Reported-by: Zhi Li <yieli@redhat.com>
> Reported-by: Benjamin Coddington <bcodding@redhat.com>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
> This bug predates git, so I can't add a proper Fixes tag. I think this
> is probably appropriate for stable series kernels though.
> 
> This bug was largely papered over by the fact that we factored in the
> ctime when generating a change attribute. Since this commit, however:
> 
>     638e3e7d9493 nfsd: use the getattr operation to fetch i_version
> 
> We stopped doing that for directory inodes and that caused this bug to
> pop up.

Applied to nfsd-fixes with a "Cc: stable" tag added.

Is there a publicly-accessible bug report link that can be included?


> ---
>  fs/nfsd/nfs4proc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> index 5ca748309c26..4199ede0583c 100644
> --- a/fs/nfsd/nfs4proc.c
> +++ b/fs/nfsd/nfs4proc.c
> @@ -1058,8 +1058,8 @@ nfsd4_rename(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>  			     rename->rn_tname, rename->rn_tnamelen);
>  	if (status)
>  		return status;
> -	set_change_info(&rename->rn_sinfo, &cstate->current_fh);
> -	set_change_info(&rename->rn_tinfo, &cstate->save_fh);
> +	set_change_info(&rename->rn_sinfo, &cstate->save_fh);
> +	set_change_info(&rename->rn_tinfo, &cstate->current_fh);
>  	return nfs_ok;
>  }
>  
> 
> ---
> base-commit: dd1386dd3c4f4bc55456c88180f9f39697bb95c0
> change-id: 20230908-nfsd-fixes-f5bdb87e6035
> 
> Best regards,
> -- 
> Jeff Layton <jlayton@kernel.org>
> 

-- 
Chuck Lever
