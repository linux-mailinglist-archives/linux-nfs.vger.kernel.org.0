Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE8067D9ED0
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Oct 2023 19:24:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232233AbjJ0RYT (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 27 Oct 2023 13:24:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231649AbjJ0RYS (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 27 Oct 2023 13:24:18 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 414FBB8;
        Fri, 27 Oct 2023 10:24:15 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39RDUm2O031044;
        Fri, 27 Oct 2023 17:24:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=z5XM29QoxbKjwnwpbsyBz9F99wQF1Hi//DIBxm5xT9Y=;
 b=eoobMf+iYzQctzpIKdl9erM9pgSxa5HQbCpPCuqCyCLhWc3eZwEM0r8y9Ut461A7CjYz
 FuphMPFm499h+bdUYjPRnvUb6PRocLucie9ZJFCDb5cJ8+lmyWHVox/qe6GGGcIyyciq
 KjakPEwmEXOgzqydHtbdNFKbJhWqonEUf/RnAN8cbxDhCzqVpgB6mEhTAuX4lJqxEEWH
 KeKMp8IwNQsUn7+RRQB+c7+gZ3EGwdvODODN8rhkGFMPPnCHH/NvJemN8fzcVrN7sgiN
 uaENTkpEZxBaSsc0keiLB2iVdX2vQW5JAOTuMAn/zmjMiaDbDrUmkofnDbsfdBKBRYbA nA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tyxge1xw9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 Oct 2023 17:24:04 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39RH19og025787;
        Fri, 27 Oct 2023 17:24:03 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3tywqmgysm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 Oct 2023 17:24:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AeYj2wHppHHSBC3peCEinsxc6WfZX4hbPwSN3v384EzrDBwTM8IcPc9H21FM1Yzm/4cB7MX0WZnNuOYGQirSdkXEKBMdnCdONxmMi+Pdy+UoDkwuU1+s/WjIzYmp2eokDj9AAsrJcDUb5ImgVwSP8kmoHupptIOvEm3806ztQBAdO855xP4bLlbfaQ4UHkCSZklh29OrozB58LfdO11KO48SEVw39QvCSePuacFDlZNnXxrFDRBOApTM5Wc6Nne40lcyWKNHwQEnKxBKcUt2HYw3xBenlChBCKEe27pXHiTKR8IS6DRgToTIJSpaFO+OCGA1GYdDXC9q5itm9Rspsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z5XM29QoxbKjwnwpbsyBz9F99wQF1Hi//DIBxm5xT9Y=;
 b=gq6alvIo15bMkATWzDQu86FhoHoklkVY9VO/LfOhkvj0p81EfpbcY+Cj6DWzO8os1m1eZMS7TMd6bY7Ubqwi5XaSYfWTjgCmaf9OgWNdqEAzuUY6EOLKOE39VVGL50lGsnZDk6YZ861w7YIaxq9kcYa4sO5bkkPVEUvaNbZXUGHzjy/HnHlIGhVGos4WCB24nevNhLusm9OSpcgS6m8AmVMDVSm+XeKiCQ93RiAlzbTDjxQ4+4jqnKFuJgKdEdD2z721YOWwAC0Qu5JBmCz5lvi7zbfsDUYO5npKWLfQnlmFWER7hzzvFUlA5RUFLR9D6sDI8jpd/Q78wOixUY5Q2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z5XM29QoxbKjwnwpbsyBz9F99wQF1Hi//DIBxm5xT9Y=;
 b=Fnk/x6RaXBFGSJGbLYBqrUo+skTh8/A60qmjVc4cSCfWZEpwS3zBSu2vdZMV24bvQZ5TE2RxtLDR8IU/Jy69CCAKEHMUaeO5Fd4MgsGr0QwTQCQfozkFRrsn/oDrRkxmn1uUkgR9lvQKdgY6oGtZvJLGnVG5M+5BDi677s/XGpw=
Received: from DS7PR10MB5134.namprd10.prod.outlook.com (2603:10b6:5:3a1::23)
 by DM8PR10MB5400.namprd10.prod.outlook.com (2603:10b6:8:27::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.19; Fri, 27 Oct
 2023 17:24:01 +0000
Received: from DS7PR10MB5134.namprd10.prod.outlook.com
 ([fe80::3a93:ba27:cbea:c6d4]) by DS7PR10MB5134.namprd10.prod.outlook.com
 ([fe80::3a93:ba27:cbea:c6d4%4]) with mapi id 15.20.6933.019; Fri, 27 Oct 2023
 17:24:01 +0000
Date:   Fri, 27 Oct 2023 13:23:57 -0400
From:   Chuck Lever <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Neil Brown <neilb@suse.de>, Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zhi Li <yieli@redhat.com>
Subject: Re: [PATCH] nfsd: ensure the nfsd_serv pointer is cleared when svc
 is torn down
Message-ID: <ZTvyLWIJHCdWscRj@tissot.1015granger.net>
References: <20231027-kdevops-v1-1-73711c16186c@kernel.org>
 <ZTvh0tyY0pNUlboH@tissot.1015granger.net>
 <3164f1a893197381cd3b5edc2271f2c67713c93a.camel@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3164f1a893197381cd3b5edc2271f2c67713c93a.camel@kernel.org>
X-ClientProxiedBy: SJ0PR03CA0025.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::30) To DS7PR10MB5134.namprd10.prod.outlook.com
 (2603:10b6:5:3a1::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5134:EE_|DM8PR10MB5400:EE_
X-MS-Office365-Filtering-Correlation-Id: 66c7c597-331a-4331-2ca2-08dbd71182d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YX9ZTnco0zKjjpMyWHD+gDfjrLYACzZkbQuEk8ZCsnUYkH0ixLrOuvyuaV1eoM3Xb7IdLbpY77wFlrTaLhembV+hL5ZVPfpjWZ8sEpNzfsf/0C60jR9oiQLXsCZ1vLb/Kj3zISYaB7D8vYN9LtSe8scBRF/e1T4gkpwEg1gTZMQS1E5R9wvLJ7c44qV6UI3kxuteBn96jh0UQE2rw4Ql+bRHMktnYvJ1lbuvFHZdaaPIPF9wtG4DWzwRs96tS5/g/hrmHNhKBasfWbBiX3Ijft7BelzL9H/mGF4BmWGzYOlQPNy9uJ6PBHAC+w90QEun/Xgy2gnKPGLXyyOjMZFWKNpbM6k1QsCRDQ4S7OgdtNWt45tukBvzjOT07Bedx3T51KQgp/zsqmBVrNmEsTseHKYsWDXdprSGYHrMCprScS+VBwCN0s9i8iR5aGwRpclV+/2ewbL7lGahcDhvNo5tdJRfZ5Jphb+GXYvua8IV0D34RDFHhNozSQQGm5xBaOPIWwS9+jJZUUTLqWtV/sxAPlIr1GXayy4B4S7C0dwo5Z7oxjyHaTzLmimOnBYtub5R
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5134.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(366004)(376002)(346002)(136003)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(66899024)(44832011)(478600001)(6506007)(66476007)(9686003)(66946007)(6512007)(6666004)(6486002)(86362001)(54906003)(26005)(66556008)(8936002)(83380400001)(8676002)(38100700002)(4326008)(41300700001)(5660300002)(316002)(6916009)(2906002)(4001150100001)(30864003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SPIRmQowFIO/j25eNSlJ2FaiC0ytG2GLbx8kpVH1klRRWmzQ3nMOnLAZ/LoY?=
 =?us-ascii?Q?xOY43peYgFU+OBmclMqnvmUXIqpgKGnq1bILZjmhV70L1HzVVR1sNzASvoAG?=
 =?us-ascii?Q?2qz/OeYQg6B26n88BSFSZDkAZukxkNb4MRcbhW2qk/icqrg9W/p3HAS7eMoO?=
 =?us-ascii?Q?EfqI8yutgK2zNGYOTCbIOr8jkesoXs/F4KoqEoDCWB0HVNZ8cBbxmJ6dAGlt?=
 =?us-ascii?Q?p/4koQkyV1qcaKPaGV/kciEFX3bOyAk2jnsD9emiPtdxRz74Nh4WlIgb6FLk?=
 =?us-ascii?Q?zWVb3hoq4K4emrPKZjWvg2rtK/gme0yOfqmIzitLG4VbQbReY2ruoptUm2bS?=
 =?us-ascii?Q?nz8EKUhUPYn7Jcv47b2XzuW02wcmsIxcB945HUmNmuRJbpdTFp/aLgpjOinG?=
 =?us-ascii?Q?HgdK7K2BoGiP68ZyXTQOsAczDeLU30rhQS/C+0d8Bs86fSXwVrviJEPt3M0e?=
 =?us-ascii?Q?WG+tn5oHaPjFJSlE75heSjnGKwmSURZWw6x9QseK8WFqKYKipIhElrEPm1j9?=
 =?us-ascii?Q?4xJQjBB6JQwvtO1zz1RAVnpwli5rhQLiirsywXjfxJecqhGYiROHuKfqSFJY?=
 =?us-ascii?Q?M9bJ9ZQAEmxGqbCbWhYcRVKTFhrrZHEB3Z15pO+ylbbo34erlvDpM5mzNJth?=
 =?us-ascii?Q?nQJqE853VX93otXIX8yEZ2uhHCVXd6NtXi1TJZx+j3KNlnjq/n8v0qpfBh+U?=
 =?us-ascii?Q?FTmdpOyGF11EFf1DkhbaekTqSivYoq2gCMY+2JI+/9K75Gt4ShQ+f2r5TWv2?=
 =?us-ascii?Q?BsETieqrbJiJf4Saq7DeE0LF9wjVCnyf6C3h9u/8Tt5yJCIhUyJ0PBmqhpi1?=
 =?us-ascii?Q?8yWmoNkqJJ/bIX5WYNvIvATB1GOZLiFFNWOywdXhD4nsL9aZNTkawXZnUuHM?=
 =?us-ascii?Q?zNtUFCtO5k/Xs1U+xW1loEsT+4hnMat7EB/yR4QyeO4mikrSpLzj9H1PfeQl?=
 =?us-ascii?Q?0NZrt+roRS3iOkmf8eqrYKP2uz8ctqDA/BuNXkObtwZJjwbcep8+a34txZ5O?=
 =?us-ascii?Q?vV3ffCfjji7mva9h8W6OsEKC1l9Lz59W4e0Vw6UU0vDNMz0IgkEpgu6ePB8b?=
 =?us-ascii?Q?6enC+aR0vXiXdYZaj6TwifddVvtT1FBLBYdmo1gP0C5VoDskoWKvKlZgOpZ0?=
 =?us-ascii?Q?NqCrgEWqrJqesptch8XUbJIWii6GianlRpthgf0d8D6rBbm/zmraWN58wg3M?=
 =?us-ascii?Q?sziBnKTHRb839pY+Rdmow9sBFmz/kDn9clJwD9SiLBU1jOf3lccEeceekHh4?=
 =?us-ascii?Q?iJpFQsP3x0pdnDrP19kjrSCCU3uWqrsDuPIQETn3rt/HbMKnYE7uHQYou2Y6?=
 =?us-ascii?Q?p/bCbbMj315fW6HrntCR4hy/hAWe3QsLt0sbptn2nOPdXjiINKPxnvchIFe8?=
 =?us-ascii?Q?ca3jHEgjtriIwsqDtc3/F3b+UiIY7aqAUx4mUMF/uBqBbEF72wYFjT7Y7bfV?=
 =?us-ascii?Q?qvjQ46KEp3BaUmOkgoRlJy0nrNOPFNtEUGCIbwh76V9VoLZUy5QdIdk5RtTO?=
 =?us-ascii?Q?9HpkTRrTQPI+jkhkYW2Pv5wgsE8qMGTDZcYf9N13HKaoqY9JiD1N72MUBapX?=
 =?us-ascii?Q?Ey4mnzY5Z0GQJFkZsGUaUM3yk7Fb6GHwtyXmcwSm?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: rHPibK0eINwnglsxsTq5xEDhw4hFbzwhoN/ydT3UOWOeSUiiOOhsJcSI/208wcwi1mbYUDJFRYdAJq4RqT1pFwlm11zr3yDXNwCqv12M6UoQieKWSlnxmFjOjkZVHkSRRvXzbzksmod0GnLTzoWD7FkUWWlWAKb7RFch8XCnsvjHqWLMHZfhoLGPi2zzIL7UxFSPp2PAqQNlYFUQW9vt5UNSjYkRjx/O+zbuFEVLSnL4zgHujHqXAcMb5WCNgfnyr1xMfHW4IZiPVM+XM7CNsgbxsN8AY6yrtAg1ZJ4MtLcb/6uXLjuF5+eI/SZvsPHsKWLZc/JUyV8GY5LyfI+2CQ3Lu97IKXnoGeUwWotECzs28SMQD4xpY50gz9J56AZGYI6SRTAU+kIZIafit1LYVS2/NTyy3Of+b40qjty50Ex5FFLmZPmwnc5r859ApZ8XBtR4ac5Rrf0izDg2ABGgcUKYuaRikrXrz/5XQvREvvcHo/yjgA3eyyDaHlj9HsSik2qKgW7E1XBvE6LmCiREkwb4zIYV7IfKs9yHL+FuYPQi9isWEp2ubBrMOG2hKBM/ezJ2IJPVWV0rpBJNkNjNyKcIXSohOHGCpdtm0ulcboUxHy3ZhRoE0KrncQz2LDD7maorJP8KHu/YRQonJOZRkJBN6Kz+0k21HF9Z5VRGQFenD3pec/BSLbNrx6SehiUZOkNUoGb7RxIw4wkoYuS8X3VQ8JtUn3tvGcgMXI4HScJj2vOSUidf8CkB3ORcyAbMC+RZm5vVwiWw+qWzo9uiGlCoH5JxC5pzhwD+PzMzeMA8uU6MLdgmVORWTdAH5Bo8p88Srq3Bi1z4Fp3tCsZiQn66tdOqdqEXAFNlObXu/KkVb0Kpeca7akN5OctOleNCviyK9+UiXJjSRmmoc4SjOg==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66c7c597-331a-4331-2ca2-08dbd71182d2
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5134.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2023 17:24:01.5977
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KF6ZJCuTlCyJYriGncrx3r6RxwfT/+qHWIfgCcQzoJD8DKzl0mEK4E7MXpTg/rTIuJGh81U4hKG8BvyAdX56Fw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR10MB5400
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-27_16,2023-10-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 spamscore=0
 malwarescore=0 phishscore=0 bulkscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310240000
 definitions=main-2310270150
X-Proofpoint-GUID: p0GrMzfJfVzoGBVgOGc9fvG6h02PnYx1
X-Proofpoint-ORIG-GUID: p0GrMzfJfVzoGBVgOGc9fvG6h02PnYx1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Oct 27, 2023 at 12:50:12PM -0400, Jeff Layton wrote:
> On Fri, 2023-10-27 at 12:14 -0400, Chuck Lever wrote:
> > On Fri, Oct 27, 2023 at 07:53:44AM -0400, Jeff Layton wrote:
> > > Zhi Li reported a refcount_t use-after-free when bringing up nfsd.
> > 
> > Aw, Jeff. You promised you wouldn't post a bug fix during the last
> > weekend of -rc again. ;-)
> > 
> 
> I never promised anything!
> 
> > 
> > > We set the nn->nfsd_serv pointer in nfsd_create_serv, but it's only ever
> > > cleared in nfsd_last_thread. When setting up a new socket, if there is
> > > an error, this can leave nfsd_serv pointer set after it has been freed.
> > 
> > Maybe missing a call to nfsd_last_thread in this case?
> > 
> 
> Yeah, that might be the better fix here.
> 
> > 
> > > We need to better couple the existence of the object with the value of
> > > the nfsd_serv pointer.
> > > 
> > > Since we always increment and decrement the svc_serv references under
> > > mutex, just test for whether the next put will destroy it in nfsd_put,
> > > and clear the pointer beforehand if so. Add a new nfsd_get function for
> > 
> > My memory isn't 100% reliable, but I seem to recall that Neil spent
> > some effort getting rid of the nfsd_get() helper in recent kernels.
> > So, nfsd_get() isn't especially new. I will wait for Neil's review.
> > 
> > Let's target the fix (when we've agreed upon one) for v6.7-rc.
> > 
> > 
> > > better clarity and so that we can enforce that the mutex is held via
> > > lockdep. Remove the clearing of the pointer from nfsd_last_thread.
> > > Finally, change all of the svc_get and svc_put calls to use the updated
> > > wrappers.
> > 
> > This seems like a good clean-up. If we need to deal with the set up
> > and tear down of per-net namespace metadata, I don't see a nicer
> > way to do it than nfsd_get/put.
> > 
> 
> Zhi reported a second panic where we hit the BUG_ON because sv_permsocks
> is still populated. Those sockets also get cleaned out in
> nfsd_last_thread, but some of the error paths in nfsd_svc don't call
> into there.

There is supposed to be a patch in v6.7 that changes that BUG_ON to
a WARN_ON... because Christian reported a similar issue just a few
weeks ago. We didn't find a convenient reproducer for that.


> So, I think this patch is not a complete fix. We need to ensure that we
> clean up everything if writing to "threads" fails for any reason, and it
> wasn't already started before.
> 
> What I'm not sure of at this point is whether this is a recent
> regression. We don't have a reliable reproducer just yet, unfortunately.

Given the churn in this area in v6.6 and v6.7, I'm betting it will
be a recent regression.


> Maybe consider this patch an RFC that illustrates at least part of the
> problem. ;)

Understood.


> > > Reported-by: Zhi Li <yieli@redhat.com>
> > 
> > Closes: ?
> > 
> 
> I don't have a separate bug for that just yet. This was found in a
> backport from upstream of a large swath of sunrpc/nfsd/nfs patches. I'll
> plan to open a linux-nfs.org bug before I re-post though.
> 
> > 
> > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > > ---
> > > When using their test harness, the RHQA folks would sometimes see the
> > > nfsv3 portmapper registration fail with -ERESTARTSYS, and that would
> > > trigger this bug. I could never reproduce that easily on my own, but I
> > > was able to validate this by hacking some fault injection into
> > > svc_register.
> > > ---
> > >  fs/nfsd/nfsctl.c |  4 ++--
> > >  fs/nfsd/nfsd.h   |  8 ++-----
> > >  fs/nfsd/nfssvc.c | 72 ++++++++++++++++++++++++++++++++++++--------------------
> > >  3 files changed, 51 insertions(+), 33 deletions(-)
> > > 
> > > diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> > > index 7ed02fb88a36..f8c0fed99c7f 100644
> > > --- a/fs/nfsd/nfsctl.c
> > > +++ b/fs/nfsd/nfsctl.c
> > > @@ -706,7 +706,7 @@ static ssize_t __write_ports_addfd(char *buf, struct net *net, const struct cred
> > >  
> > >  	if (err >= 0 &&
> > >  	    !nn->nfsd_serv->sv_nrthreads && !xchg(&nn->keep_active, 1))
> > > -		svc_get(nn->nfsd_serv);
> > > +		nfsd_get(net);
> > >  
> > >  	nfsd_put(net);
> > >  	return err;
> > > @@ -745,7 +745,7 @@ static ssize_t __write_ports_addxprt(char *buf, struct net *net, const struct cr
> > >  		goto out_close;
> > >  
> > >  	if (!nn->nfsd_serv->sv_nrthreads && !xchg(&nn->keep_active, 1))
> > > -		svc_get(nn->nfsd_serv);
> > > +		nfsd_get(net);
> > >  
> > >  	nfsd_put(net);
> > >  	return 0;
> > > diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
> > > index 11c14faa6c67..c9cb70bf2a6d 100644
> > > --- a/fs/nfsd/nfsd.h
> > > +++ b/fs/nfsd/nfsd.h
> > > @@ -96,12 +96,8 @@ int		nfsd_pool_stats_open(struct inode *, struct file *);
> > >  int		nfsd_pool_stats_release(struct inode *, struct file *);
> > >  void		nfsd_shutdown_threads(struct net *net);
> > >  
> > > -static inline void nfsd_put(struct net *net)
> > > -{
> > > -	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
> > > -
> > > -	svc_put(nn->nfsd_serv);
> > > -}
> > > +struct svc_serv	*nfsd_get(struct net *net);
> > > +void		nfsd_put(struct net *net);
> > >  
> > >  bool		i_am_nfsd(void);
> > >  
> > > diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
> > > index c7af1095f6b5..4c00478c28dd 100644
> > > --- a/fs/nfsd/nfssvc.c
> > > +++ b/fs/nfsd/nfssvc.c
> > > @@ -66,7 +66,7 @@ static __be32			nfsd_init_request(struct svc_rqst *,
> > >   * ->sv_pools[].
> > >   *
> > >   * Each active thread holds a counted reference on nn->nfsd_serv, as does
> > > - * the nn->keep_active flag and various transient calls to svc_get().
> > > + * the nn->keep_active flag and various transient calls to nfsd_get().
> > >   *
> > >   * Finally, the nfsd_mutex also protects some of the global variables that are
> > >   * accessed when nfsd starts and that are settable via the write_* routines in
> > > @@ -477,6 +477,39 @@ static void nfsd_shutdown_net(struct net *net)
> > >  }
> > >  
> > >  static DEFINE_SPINLOCK(nfsd_notifier_lock);
> > > +
> > > +struct svc_serv *nfsd_get(struct net *net)
> > > +{
> > > +	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
> > > +	struct svc_serv *serv = nn->nfsd_serv;
> > > +
> > > +	lockdep_assert_held(&nfsd_mutex);
> > > +	if (serv)
> > > +		svc_get(serv);
> > > +	return serv;
> > > +}
> > > +
> > > +void nfsd_put(struct net *net)
> > > +{
> > > +	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
> > > +	struct svc_serv *serv = nn->nfsd_serv;
> > > +
> > > +	/*
> > > +	 * The notifiers expect that if the nfsd_serv pointer is
> > > +	 * set that it's safe to access, so we must clear that
> > > +	 * pointer first before putting the last reference. Because
> > > +	 * we always increment and decrement the refcount under the
> > > +	 * mutex, it's safe to determine this via kref_read.
> > > +	 */
> > 
> > These two need kdoc comments. You could move this big block into
> > the kdoc comment for nfsd_put.
> > 
> > 
> > > +	lockdep_assert_held(&nfsd_mutex);
> > > +	if (kref_read(&serv->sv_refcnt) == 1) {
> > > +		spin_lock(&nfsd_notifier_lock);
> > > +		nn->nfsd_serv = NULL;
> > > +		spin_unlock(&nfsd_notifier_lock);
> > > +	}
> > > +	svc_put(serv);
> > > +}
> > > +
> > >  static int nfsd_inetaddr_event(struct notifier_block *this, unsigned long event,
> > >  	void *ptr)
> > >  {
> > > @@ -547,10 +580,6 @@ static void nfsd_last_thread(struct net *net)
> > >  	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
> > >  	struct svc_serv *serv = nn->nfsd_serv;
> > >  
> > > -	spin_lock(&nfsd_notifier_lock);
> > > -	nn->nfsd_serv = NULL;
> > > -	spin_unlock(&nfsd_notifier_lock);
> > > -
> > >  	/* check if the notifier still has clients */
> > >  	if (atomic_dec_return(&nfsd_notifier_refcount) == 0) {
> > >  		unregister_inetaddr_notifier(&nfsd_inetaddr_notifier);
> > > @@ -638,21 +667,19 @@ static int nfsd_get_default_max_blksize(void)
> > >  
> > >  void nfsd_shutdown_threads(struct net *net)
> > >  {
> > > -	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
> > >  	struct svc_serv *serv;
> > >  
> > >  	mutex_lock(&nfsd_mutex);
> > > -	serv = nn->nfsd_serv;
> > > +	serv = nfsd_get(net);
> > >  	if (serv == NULL) {
> > >  		mutex_unlock(&nfsd_mutex);
> > >  		return;
> > >  	}
> > >  
> > > -	svc_get(serv);
> > >  	/* Kill outstanding nfsd threads */
> > >  	svc_set_num_threads(serv, NULL, 0);
> > >  	nfsd_last_thread(net);
> > > -	svc_put(serv);
> > > +	nfsd_put(net);
> > >  	mutex_unlock(&nfsd_mutex);
> > >  }
> > >  
> > > @@ -663,15 +690,13 @@ bool i_am_nfsd(void)
> > >  
> > >  int nfsd_create_serv(struct net *net)
> > >  {
> > > -	int error;
> > >  	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
> > >  	struct svc_serv *serv;
> > > +	int error;
> > >  
> > > -	WARN_ON(!mutex_is_locked(&nfsd_mutex));
> > > -	if (nn->nfsd_serv) {
> > > -		svc_get(nn->nfsd_serv);
> > > +	serv = nfsd_get(net);
> > > +	if (serv)
> > >  		return 0;
> > > -	}
> > >  	if (nfsd_max_blksize == 0)
> > >  		nfsd_max_blksize = nfsd_get_default_max_blksize();
> > >  	nfsd_reset_versions(nn);
> > > @@ -731,8 +756,6 @@ int nfsd_set_nrthreads(int n, int *nthreads, struct net *net)
> > >  	int err = 0;
> > >  	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
> > >  
> > > -	WARN_ON(!mutex_is_locked(&nfsd_mutex));
> > > -
> > >  	if (nn->nfsd_serv == NULL || n <= 0)
> > >  		return 0;
> > >  
> > > @@ -766,7 +789,7 @@ int nfsd_set_nrthreads(int n, int *nthreads, struct net *net)
> > >  		nthreads[0] = 1;
> > >  
> > >  	/* apply the new numbers */
> > > -	svc_get(nn->nfsd_serv);
> > > +	nfsd_get(net);
> > >  	for (i = 0; i < n; i++) {
> > >  		err = svc_set_num_threads(nn->nfsd_serv,
> > >  					  &nn->nfsd_serv->sv_pools[i],
> > > @@ -774,7 +797,7 @@ int nfsd_set_nrthreads(int n, int *nthreads, struct net *net)
> > >  		if (err)
> > >  			break;
> > >  	}
> > > -	svc_put(nn->nfsd_serv);
> > > +	nfsd_put(net);
> > >  	return err;
> > >  }
> > >  
> > > @@ -826,8 +849,8 @@ nfsd_svc(int nrservs, struct net *net, const struct cred *cred)
> > >  out_put:
> > >  	/* Threads now hold service active */
> > >  	if (xchg(&nn->keep_active, 0))
> > > -		svc_put(serv);
> > > -	svc_put(serv);
> > > +		nfsd_put(net);
> > > +	nfsd_put(net);
> > >  out:
> > >  	mutex_unlock(&nfsd_mutex);
> > >  	return error;
> > > @@ -1067,14 +1090,14 @@ bool nfssvc_encode_voidres(struct svc_rqst *rqstp, struct xdr_stream *xdr)
> > >  int nfsd_pool_stats_open(struct inode *inode, struct file *file)
> > >  {
> > >  	int ret;
> > > +	struct net *net = inode->i_sb->s_fs_info;
> > >  	struct nfsd_net *nn = net_generic(inode->i_sb->s_fs_info, nfsd_net_id);
> > >  
> > >  	mutex_lock(&nfsd_mutex);
> > > -	if (nn->nfsd_serv == NULL) {
> > > +	if (nfsd_get(net) == NULL) {
> > >  		mutex_unlock(&nfsd_mutex);
> > >  		return -ENODEV;
> > >  	}
> > > -	svc_get(nn->nfsd_serv);
> > >  	ret = svc_pool_stats_open(nn->nfsd_serv, file);
> > >  	mutex_unlock(&nfsd_mutex);
> > >  	return ret;
> > > @@ -1082,12 +1105,11 @@ int nfsd_pool_stats_open(struct inode *inode, struct file *file)
> > >  
> > >  int nfsd_pool_stats_release(struct inode *inode, struct file *file)
> > >  {
> > > -	struct seq_file *seq = file->private_data;
> > > -	struct svc_serv *serv = seq->private;
> > > +	struct net *net = inode->i_sb->s_fs_info;
> > >  	int ret = seq_release(inode, file);
> > >  
> > >  	mutex_lock(&nfsd_mutex);
> > > -	svc_put(serv);
> > > +	nfsd_put(net);
> > >  	mutex_unlock(&nfsd_mutex);
> > >  	return ret;
> > >  }
> > > 
> > > ---
> > > base-commit: 80eea12811ab8b32e3eac355adff695df5b4ba8e
> > > change-id: 20231026-kdevops-3c18d260bf7c
> > > 
> > > Best regards,
> > > -- 
> > > Jeff Layton <jlayton@kernel.org>
> > > 
> > 
> 
> -- 
> Jeff Layton <jlayton@kernel.org>

-- 
Chuck Lever
