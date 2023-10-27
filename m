Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 385C57D9DD6
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Oct 2023 18:15:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231674AbjJ0QPD (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 27 Oct 2023 12:15:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230451AbjJ0QPC (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 27 Oct 2023 12:15:02 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDF511A5;
        Fri, 27 Oct 2023 09:14:58 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39RDUueS013039;
        Fri, 27 Oct 2023 16:14:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=pVQaA77EA5nO+96MIqTKi7wnMkT26ZKarHCmHO61itA=;
 b=M4PHg9qf+IU3lLuGiAnalBXdT4heaQWD4Cq7TxLkAREFJPIlHEqthk73SN4EEqc/J++X
 w0viah5NrGnmINaUu5G+EQEglDVaixjXobNNFqXD4WBhPkr/4USPsdtumbrP2hX2jJMs
 NMihONJhKBzuQKsYP66vVjIXVG/sef1CUOTa6YpbQ5G5U1nGtboEK4uMsUNOVoqc7eiJ
 2eQVyaEYZmszNW+QaN3jTSe36359pn3zBycPVJcVG81DewKvwgvi9TNCd7Dvf38/ZGhE
 BGT7Pboxkmc22Q040HE8lz6Fzz0sPHvDspESMeeA2/hs98cHs6idj/0CoIyWLffon+Fa 7A== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tywuc9y56-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 Oct 2023 16:14:19 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39RFefZp023015;
        Fri, 27 Oct 2023 16:14:18 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3tywqjp20u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 Oct 2023 16:14:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JiqE5MjVZCip03A+EuxhrSFeUjy0gB6VP07clV6DTTxCUxic8sof04YCCewofru2eHrtK0+KG8s+CLGi2NepiG510yPyfVlCFwKsjiUtN8bv+RN9YH1/O6bOFir5euoJ2DL9lZSE6dy1/ljclU9RzYOfwnPLeoMPOeBFnoiJ0PWWFN26eaa8nds7CHUe2GU0JuizSnNx9CrLg68RSUOV0jFf9HynFDlJ/lVASs/UQbznhcVea2242gE2CtXgCd4CnyjgjZGbKq9A3EBq2WO5SlAJq3HArOjeXes+uhbGjetV0nV2n2ifJsBwEeTF/lF7ocrUPrCoOW/7bJOR+3TIXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pVQaA77EA5nO+96MIqTKi7wnMkT26ZKarHCmHO61itA=;
 b=cHorL5exeiIbeVvNq32Cwt8WP+b93DNL9ixmWEk6czM17noLRtUWHvZXgO9uiklRgUO4Zl4YOVEKVFHq5uR+55i4h1hHS3f+EDcIgg8NaZ4TmxqzzvxW/OUb2/YV4ksVPibGMihnSI6dnrAuYsgdElXD3sHJLAnxFW97tHfsuaR6pP0CVVQ58VDU19S2ZzWzvhZ4ciDwBsbL/zKKU3Li0zVF4jsmSdtb0EYSVTC2G17KiZhGtvFeyxMORLhlCfTNZmuCqFxL+wCYG28WfiLMwoDjs8+HRpd+tbmooHni+zdOGSG/x8MOec/IChWNZ721Z9LQ/YpeNhBg6SXhbVJ67g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pVQaA77EA5nO+96MIqTKi7wnMkT26ZKarHCmHO61itA=;
 b=ZJoJ79RmrzLPQkPugEaVwgZjxTYZqto+3kNGpYqLy+Z6jnVvIECx37gzFRYQnvutMDYSKF8W2Jx6ekClEWE2fIWylmmi8bT91JODhORQdUxNx0QVhaZiE73m9+CC0jhw63iztGPC6XbUSfb1oE8uJWI4EZiB/fKakczbvmKdvBg=
Received: from DS7PR10MB5134.namprd10.prod.outlook.com (2603:10b6:5:3a1::23)
 by SJ0PR10MB4462.namprd10.prod.outlook.com (2603:10b6:a03:2d7::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.19; Fri, 27 Oct
 2023 16:14:15 +0000
Received: from DS7PR10MB5134.namprd10.prod.outlook.com
 ([fe80::3a93:ba27:cbea:c6d4]) by DS7PR10MB5134.namprd10.prod.outlook.com
 ([fe80::3a93:ba27:cbea:c6d4%4]) with mapi id 15.20.6933.019; Fri, 27 Oct 2023
 16:14:15 +0000
Date:   Fri, 27 Oct 2023 12:14:10 -0400
From:   Chuck Lever <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Neil Brown <neilb@suse.de>, Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zhi Li <yieli@redhat.com>
Subject: Re: [PATCH] nfsd: ensure the nfsd_serv pointer is cleared when svc
 is torn down
Message-ID: <ZTvh0tyY0pNUlboH@tissot.1015granger.net>
References: <20231027-kdevops-v1-1-73711c16186c@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231027-kdevops-v1-1-73711c16186c@kernel.org>
X-ClientProxiedBy: MW4PR03CA0238.namprd03.prod.outlook.com
 (2603:10b6:303:b9::33) To DS7PR10MB5134.namprd10.prod.outlook.com
 (2603:10b6:5:3a1::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5134:EE_|SJ0PR10MB4462:EE_
X-MS-Office365-Filtering-Correlation-Id: 8dbdb4f4-d09c-4b00-778e-08dbd707c35d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NksgSjfBOizfuw7oqJIKt5Ta4onzZNFvWvgtHW0vamyfYh78+OmPVfsQdHXVp4OMAcC+DO1VzMF8lLHl7anUIl9TcpPjilt8TZXZI778WxZ4POWOT09TetDFPiPJBK7XONB7aXI6EgZbe/UIVOgTrH2TUXk9a1jrP88J0OPYC+35uGTrvPW1/vkiW0UFS/IurETCdVhR7QTVE8opTWt3sjFlRJ4PBVgcZNOAd242Yi0Y7kZWeDx+eU7cHVI9MRwubmbAtR26EC4x7fzaYf6w2lhLO6AmWXJ4Z310MtJYCqbBPASaG3glXrnzQY7yOeBCFZHd9FzxyJEljjNDAfgMaOaO4SvmOhtul7WWxE/eyOfhOHYVrjHMPNpNdUh8rFWDZYIL+9Lhrq5aFVw+n6rtBWKCcx0JoXTdM6RNMVObHVcFL8PPzgEf9AEfSKyWN43yT+oJ5E7q1kAWKqqjW1STGrYIqriN/sIJfDL62Dd7xqfIKLv6CjjvS+vEW8h+8XXbjtN60AiGAJqWqehmIrG5pXT4r2pD67Ks/1N24h+xg9asGLBihc7AbO72dwpHkoh+
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5134.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(376002)(346002)(136003)(39860400002)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(66899024)(38100700002)(6512007)(26005)(9686003)(6506007)(83380400001)(8936002)(6486002)(8676002)(478600001)(4326008)(41300700001)(86362001)(2906002)(44832011)(316002)(6916009)(5660300002)(54906003)(6666004)(66556008)(66476007)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UTOemckNWWhVRp+wXofd8HPGUgiSj3uQQpNOep6bjc8m1pDKKb7sn8PC6iaW?=
 =?us-ascii?Q?ypU1w8aJZXNpVPwKu+e6Ajr6QIyv22On4s7jDc+6154pTuO+eV4SQsqcPwbN?=
 =?us-ascii?Q?daH4GEfYOPPqcIW7KmJhCJnTIUHdwGLfCUYJRJhpYN0D/cO5bHgw/aq+CjcM?=
 =?us-ascii?Q?04QfFh1bMg6ONpA8SkpHUCsenPaVQpz+/3eoaozDtydtqUYmfHkaxOGfkS0u?=
 =?us-ascii?Q?EB486k+pRrHUn1T9SNZievamBHiB7BbQwdIyh4ew85EyBs4v3sDfxPFUY0xx?=
 =?us-ascii?Q?crrfVphU1hi+UK0MbiSSJmO3tS6r4syq5VkB4w2GWxddHSMq7v042rvYyUVQ?=
 =?us-ascii?Q?fVLJWiNw/0TOIPMFwP6564B0BLvtNxCI1vx2n7ICbiraUHXQjWaEed8pTYDE?=
 =?us-ascii?Q?UMiA3WzAczixxn/9ueChCUndcslbnRdkvl5swD+qilmtMh+0Pm2qo/caUbD0?=
 =?us-ascii?Q?gVgPKhC4XrKGmSSRn+2r458GiSVWYbazwPQNvC7mEdvirurLKUgudBzs0zkl?=
 =?us-ascii?Q?7pHXfh7hYVV9RyLorMK6DxurEUaY65KQ2sf+Rwf3yxuqKyCXyK+d0iKHVZ1L?=
 =?us-ascii?Q?tYrP1ojgzU6g01pLo9HuWR1HXUDKE+5jLe22quB7Y6llGZg3IdO2B3fr1++z?=
 =?us-ascii?Q?x+P4CzYvFDwQA+wYdJu5ytRPq6C+BJx8d86SAZP7/DD/p1paRBCl9/zQn7d+?=
 =?us-ascii?Q?Tfsl3PCvUNFZqWTODvnBjufJV1DWH2/SwNrGhho8FiQD/9K9Qxj7oO9a9hBH?=
 =?us-ascii?Q?vt5kmCGMgSbHQbun7ce4CRVC61+ZjXVtXgbpdLWWUYu3gYPL2OLIzipHcKLw?=
 =?us-ascii?Q?STk2SNpBY1wTiKHPBUcbOsRnx9NksUgK7XNJbWtXShbU3E/Dnla8592RLK6Y?=
 =?us-ascii?Q?gSyoEnpvb9tR2CKzL/u7g1EapXEzPTTMS4/dVerjWYBF+HE4lpuGx3d51osV?=
 =?us-ascii?Q?ARTH+UY6nuGzL50aDaIEO74PKsOkdrVNVyvmw20dKuQQm/G/PRmcbBGxRmVJ?=
 =?us-ascii?Q?98K5PYWWrv0Q9emRTlhj5o1DC3rSnOKtt49tpvrLYrdIhrG9+IiF2+h04zEr?=
 =?us-ascii?Q?hj5DdCQqRWmqlgYzmBu1lXfKrHVslLQ1Z5k1EZK+QGr7GTCLWHezdvxqHY2q?=
 =?us-ascii?Q?jpjPdsFySDZRI+KgO3U4vsoR8mDMneagunTZ6o8rHWpgBjsfyztaW4sMoT31?=
 =?us-ascii?Q?QvJbpLuigBBlPeNQvnLCYiu/04nVAWKHvhqP4jKrSWGx6XYkyGImyIBDwVCF?=
 =?us-ascii?Q?V0Ajw78r6/YgLRWqMYe8VhAgSI/cAitCfvNMvWIVa3GILTAmD0y44eq6tE1w?=
 =?us-ascii?Q?r/CjvLJ2CNPqiz/UFmfb3/Ozd1xx/l9//pgTLDjknxyGjLya++KN3S3f5Ptr?=
 =?us-ascii?Q?MlS8Z4/pZBU9hpH1rSztZiADWKQmN05qq3H8NkkuR6izHB0KvJw5cEpZxZqa?=
 =?us-ascii?Q?XGS8Tjq+LI0R3O3DP+OLMnjCcByXgI2ZB8iytq4HMqEtcjLYfFraX9u0eiEc?=
 =?us-ascii?Q?cHvgoiWvHcxfqofT8QabU5pa6P0Zdy88M4ir9UvBExGpJLsSMetVx7M0v0Y/?=
 =?us-ascii?Q?miJO8RSsbAGZaQH8GMWpuDNiKVRNa76FQ+JD2VFa?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: KDL3AQzPn+mK5or39bioEawLxMqI+TQoQ7+TzxK/DwqR7dKEHS0LSbH32dks3xeGbk+9cXMIR4gjRbxgHbEPh3OxkFR3ETfRFHIjQcWTFzhQQkRR4n7IEFn6CFhwjGqGEGOjDZzZy6suu32zrS6kQnJB4DT50c/CT27L7wId/lMmFY80zTzjs1iNu7vL0a+JZ9/Ghv+FlUNv1wWEs+SHw/xkh/iBAj1Y9HyQoSREZv5Iu7Mx4s4IzpDaCS9BV901DYWE3jNP5vKipy/OaCn+r4p2gHdradU3JYORGAN5s69GDhmsgJwnHEoiCNw/rMSL2EFB954acc1nvMuZ8pGSZGNwEed614Dq2/T2BEFkiwrS3XWEMjfK94nq9e2nsZwXI7m/0MAcvVXmTnNR910GXH07W0YIVZ4g2Ddh9IwvuAp9OYha1tjIDcP2PFqNkDOm3iQJUfhyALGX7WJ3EgTLLdwl+P6Pnrxvk36cuiUlDl6+4y7GlNYooHeFOlmHgvYNrMfk76dApcX8kgcXePLDokdNLg7Afc+UoGPueek1+0QMYp0X2KRuO3Gw+dO0HhBHHvCWuuLloBfs0Iz43bkMhHReyCVhTq4Qp6O/OtoRKKHJoDg30LOw5kwPNniAwJPNlngzLrOXSOLgKZtyGaIjcY6tXmOT0umvFM9ypqvvKrCQcCzyXd5BLAhmPjdA9ZtMn12J8rE74VAf/CjyOqGRlyhhmg6+B8gqWSEc23ezg8Ac3g6Gj9cl6wDq6Pb7qrY0bvH6BEC4jr/8oGNp6iJji594mQb+dkExbCX8ObSFNWVT1C7lnsMb/SDu/acN2b2Iar7RdDPR2qViXdLnfjMEHXLUS3yQGrwA2Abcwnzdxjjt8GhbkdmNRlLINibWPCoMdkLxxH7EHqJoC//dq1CAQw==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dbdb4f4-d09c-4b00-778e-08dbd707c35d
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5134.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2023 16:14:15.1200
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K800w22OTZbD2xLwxTXiA/f2ygStfrY+bMa4wFAq8UglTQ8unqWbb9xIMnhqwpgMEwzGerNV22EUscVRArw0RQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4462
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-27_15,2023-10-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0 spamscore=0
 malwarescore=0 mlxscore=0 adultscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310240000
 definitions=main-2310270140
X-Proofpoint-ORIG-GUID: pvOalTTOadxb7o0-riMDW3QUVeC_lBAi
X-Proofpoint-GUID: pvOalTTOadxb7o0-riMDW3QUVeC_lBAi
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Oct 27, 2023 at 07:53:44AM -0400, Jeff Layton wrote:
> Zhi Li reported a refcount_t use-after-free when bringing up nfsd.

Aw, Jeff. You promised you wouldn't post a bug fix during the last
weekend of -rc again. ;-)


> We set the nn->nfsd_serv pointer in nfsd_create_serv, but it's only ever
> cleared in nfsd_last_thread. When setting up a new socket, if there is
> an error, this can leave nfsd_serv pointer set after it has been freed.

Maybe missing a call to nfsd_last_thread in this case?


> We need to better couple the existence of the object with the value of
> the nfsd_serv pointer.
> 
> Since we always increment and decrement the svc_serv references under
> mutex, just test for whether the next put will destroy it in nfsd_put,
> and clear the pointer beforehand if so. Add a new nfsd_get function for

My memory isn't 100% reliable, but I seem to recall that Neil spent
some effort getting rid of the nfsd_get() helper in recent kernels.
So, nfsd_get() isn't especially new. I will wait for Neil's review.

Let's target the fix (when we've agreed upon one) for v6.7-rc.


> better clarity and so that we can enforce that the mutex is held via
> lockdep. Remove the clearing of the pointer from nfsd_last_thread.
> Finally, change all of the svc_get and svc_put calls to use the updated
> wrappers.

This seems like a good clean-up. If we need to deal with the set up
and tear down of per-net namespace metadata, I don't see a nicer
way to do it than nfsd_get/put.


> Reported-by: Zhi Li <yieli@redhat.com>

Closes: ?


> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
> When using their test harness, the RHQA folks would sometimes see the
> nfsv3 portmapper registration fail with -ERESTARTSYS, and that would
> trigger this bug. I could never reproduce that easily on my own, but I
> was able to validate this by hacking some fault injection into
> svc_register.
> ---
>  fs/nfsd/nfsctl.c |  4 ++--
>  fs/nfsd/nfsd.h   |  8 ++-----
>  fs/nfsd/nfssvc.c | 72 ++++++++++++++++++++++++++++++++++++--------------------
>  3 files changed, 51 insertions(+), 33 deletions(-)
> 
> diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> index 7ed02fb88a36..f8c0fed99c7f 100644
> --- a/fs/nfsd/nfsctl.c
> +++ b/fs/nfsd/nfsctl.c
> @@ -706,7 +706,7 @@ static ssize_t __write_ports_addfd(char *buf, struct net *net, const struct cred
>  
>  	if (err >= 0 &&
>  	    !nn->nfsd_serv->sv_nrthreads && !xchg(&nn->keep_active, 1))
> -		svc_get(nn->nfsd_serv);
> +		nfsd_get(net);
>  
>  	nfsd_put(net);
>  	return err;
> @@ -745,7 +745,7 @@ static ssize_t __write_ports_addxprt(char *buf, struct net *net, const struct cr
>  		goto out_close;
>  
>  	if (!nn->nfsd_serv->sv_nrthreads && !xchg(&nn->keep_active, 1))
> -		svc_get(nn->nfsd_serv);
> +		nfsd_get(net);
>  
>  	nfsd_put(net);
>  	return 0;
> diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
> index 11c14faa6c67..c9cb70bf2a6d 100644
> --- a/fs/nfsd/nfsd.h
> +++ b/fs/nfsd/nfsd.h
> @@ -96,12 +96,8 @@ int		nfsd_pool_stats_open(struct inode *, struct file *);
>  int		nfsd_pool_stats_release(struct inode *, struct file *);
>  void		nfsd_shutdown_threads(struct net *net);
>  
> -static inline void nfsd_put(struct net *net)
> -{
> -	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
> -
> -	svc_put(nn->nfsd_serv);
> -}
> +struct svc_serv	*nfsd_get(struct net *net);
> +void		nfsd_put(struct net *net);
>  
>  bool		i_am_nfsd(void);
>  
> diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
> index c7af1095f6b5..4c00478c28dd 100644
> --- a/fs/nfsd/nfssvc.c
> +++ b/fs/nfsd/nfssvc.c
> @@ -66,7 +66,7 @@ static __be32			nfsd_init_request(struct svc_rqst *,
>   * ->sv_pools[].
>   *
>   * Each active thread holds a counted reference on nn->nfsd_serv, as does
> - * the nn->keep_active flag and various transient calls to svc_get().
> + * the nn->keep_active flag and various transient calls to nfsd_get().
>   *
>   * Finally, the nfsd_mutex also protects some of the global variables that are
>   * accessed when nfsd starts and that are settable via the write_* routines in
> @@ -477,6 +477,39 @@ static void nfsd_shutdown_net(struct net *net)
>  }
>  
>  static DEFINE_SPINLOCK(nfsd_notifier_lock);
> +
> +struct svc_serv *nfsd_get(struct net *net)
> +{
> +	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
> +	struct svc_serv *serv = nn->nfsd_serv;
> +
> +	lockdep_assert_held(&nfsd_mutex);
> +	if (serv)
> +		svc_get(serv);
> +	return serv;
> +}
> +
> +void nfsd_put(struct net *net)
> +{
> +	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
> +	struct svc_serv *serv = nn->nfsd_serv;
> +
> +	/*
> +	 * The notifiers expect that if the nfsd_serv pointer is
> +	 * set that it's safe to access, so we must clear that
> +	 * pointer first before putting the last reference. Because
> +	 * we always increment and decrement the refcount under the
> +	 * mutex, it's safe to determine this via kref_read.
> +	 */

These two need kdoc comments. You could move this big block into
the kdoc comment for nfsd_put.


> +	lockdep_assert_held(&nfsd_mutex);
> +	if (kref_read(&serv->sv_refcnt) == 1) {
> +		spin_lock(&nfsd_notifier_lock);
> +		nn->nfsd_serv = NULL;
> +		spin_unlock(&nfsd_notifier_lock);
> +	}
> +	svc_put(serv);
> +}
> +
>  static int nfsd_inetaddr_event(struct notifier_block *this, unsigned long event,
>  	void *ptr)
>  {
> @@ -547,10 +580,6 @@ static void nfsd_last_thread(struct net *net)
>  	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
>  	struct svc_serv *serv = nn->nfsd_serv;
>  
> -	spin_lock(&nfsd_notifier_lock);
> -	nn->nfsd_serv = NULL;
> -	spin_unlock(&nfsd_notifier_lock);
> -
>  	/* check if the notifier still has clients */
>  	if (atomic_dec_return(&nfsd_notifier_refcount) == 0) {
>  		unregister_inetaddr_notifier(&nfsd_inetaddr_notifier);
> @@ -638,21 +667,19 @@ static int nfsd_get_default_max_blksize(void)
>  
>  void nfsd_shutdown_threads(struct net *net)
>  {
> -	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
>  	struct svc_serv *serv;
>  
>  	mutex_lock(&nfsd_mutex);
> -	serv = nn->nfsd_serv;
> +	serv = nfsd_get(net);
>  	if (serv == NULL) {
>  		mutex_unlock(&nfsd_mutex);
>  		return;
>  	}
>  
> -	svc_get(serv);
>  	/* Kill outstanding nfsd threads */
>  	svc_set_num_threads(serv, NULL, 0);
>  	nfsd_last_thread(net);
> -	svc_put(serv);
> +	nfsd_put(net);
>  	mutex_unlock(&nfsd_mutex);
>  }
>  
> @@ -663,15 +690,13 @@ bool i_am_nfsd(void)
>  
>  int nfsd_create_serv(struct net *net)
>  {
> -	int error;
>  	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
>  	struct svc_serv *serv;
> +	int error;
>  
> -	WARN_ON(!mutex_is_locked(&nfsd_mutex));
> -	if (nn->nfsd_serv) {
> -		svc_get(nn->nfsd_serv);
> +	serv = nfsd_get(net);
> +	if (serv)
>  		return 0;
> -	}
>  	if (nfsd_max_blksize == 0)
>  		nfsd_max_blksize = nfsd_get_default_max_blksize();
>  	nfsd_reset_versions(nn);
> @@ -731,8 +756,6 @@ int nfsd_set_nrthreads(int n, int *nthreads, struct net *net)
>  	int err = 0;
>  	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
>  
> -	WARN_ON(!mutex_is_locked(&nfsd_mutex));
> -
>  	if (nn->nfsd_serv == NULL || n <= 0)
>  		return 0;
>  
> @@ -766,7 +789,7 @@ int nfsd_set_nrthreads(int n, int *nthreads, struct net *net)
>  		nthreads[0] = 1;
>  
>  	/* apply the new numbers */
> -	svc_get(nn->nfsd_serv);
> +	nfsd_get(net);
>  	for (i = 0; i < n; i++) {
>  		err = svc_set_num_threads(nn->nfsd_serv,
>  					  &nn->nfsd_serv->sv_pools[i],
> @@ -774,7 +797,7 @@ int nfsd_set_nrthreads(int n, int *nthreads, struct net *net)
>  		if (err)
>  			break;
>  	}
> -	svc_put(nn->nfsd_serv);
> +	nfsd_put(net);
>  	return err;
>  }
>  
> @@ -826,8 +849,8 @@ nfsd_svc(int nrservs, struct net *net, const struct cred *cred)
>  out_put:
>  	/* Threads now hold service active */
>  	if (xchg(&nn->keep_active, 0))
> -		svc_put(serv);
> -	svc_put(serv);
> +		nfsd_put(net);
> +	nfsd_put(net);
>  out:
>  	mutex_unlock(&nfsd_mutex);
>  	return error;
> @@ -1067,14 +1090,14 @@ bool nfssvc_encode_voidres(struct svc_rqst *rqstp, struct xdr_stream *xdr)
>  int nfsd_pool_stats_open(struct inode *inode, struct file *file)
>  {
>  	int ret;
> +	struct net *net = inode->i_sb->s_fs_info;
>  	struct nfsd_net *nn = net_generic(inode->i_sb->s_fs_info, nfsd_net_id);
>  
>  	mutex_lock(&nfsd_mutex);
> -	if (nn->nfsd_serv == NULL) {
> +	if (nfsd_get(net) == NULL) {
>  		mutex_unlock(&nfsd_mutex);
>  		return -ENODEV;
>  	}
> -	svc_get(nn->nfsd_serv);
>  	ret = svc_pool_stats_open(nn->nfsd_serv, file);
>  	mutex_unlock(&nfsd_mutex);
>  	return ret;
> @@ -1082,12 +1105,11 @@ int nfsd_pool_stats_open(struct inode *inode, struct file *file)
>  
>  int nfsd_pool_stats_release(struct inode *inode, struct file *file)
>  {
> -	struct seq_file *seq = file->private_data;
> -	struct svc_serv *serv = seq->private;
> +	struct net *net = inode->i_sb->s_fs_info;
>  	int ret = seq_release(inode, file);
>  
>  	mutex_lock(&nfsd_mutex);
> -	svc_put(serv);
> +	nfsd_put(net);
>  	mutex_unlock(&nfsd_mutex);
>  	return ret;
>  }
> 
> ---
> base-commit: 80eea12811ab8b32e3eac355adff695df5b4ba8e
> change-id: 20231026-kdevops-3c18d260bf7c
> 
> Best regards,
> -- 
> Jeff Layton <jlayton@kernel.org>
> 

-- 
Chuck Lever
