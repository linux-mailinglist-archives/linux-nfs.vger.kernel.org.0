Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BFF976C087
	for <lists+linux-nfs@lfdr.de>; Wed,  2 Aug 2023 00:46:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231559AbjHAWqf (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 1 Aug 2023 18:46:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230398AbjHAWqf (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 1 Aug 2023 18:46:35 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8D8C12B
        for <linux-nfs@vger.kernel.org>; Tue,  1 Aug 2023 15:46:33 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 371KxsKG017004;
        Tue, 1 Aug 2023 22:46:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=jUWJkWHcHIsPxsAwNBDABpqb4Swc29u/ZUIgGUKInNw=;
 b=zcn068c4CgvkDgLoTyS2ubqQ/Dv9/US/djNv2uN7xz7TxXevwbRezrOeHQOdUmsd8Ojf
 BR/WBo7ETD+QhOQj8FTFlsFsTTMttLrcFgoz32BDAwfhJALbJL1yf0cIM5nXR5WyDJ2H
 mdb96hXPr953plXiSlw6U6PlYNnVbODmmVYDoP8VTiy9EBsJ4QhRMw9T5rSLBC7tdMkv
 4aJmnQgp9WjoGq7ymO0oraoe3EArESsk6snFLpP3FSQXbWnSA4/cMIESaQnAu8gNZPv7
 4jLhVDMNyAG1XkmcL0AA6/2IusLnNSy1C0BHCbaYP4ElvvmdTDcY1+MUD8mjgtxLBZHF hA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s4uaux17v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Aug 2023 22:46:27 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 371L2pUW000666;
        Tue, 1 Aug 2023 22:46:26 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2108.outbound.protection.outlook.com [104.47.70.108])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3s4s7d4r2t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Aug 2023 22:46:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n6ybIhlo7QrXdV56c2Zglv2c8Nqm6UhIM78tK364fHwtooeANgZfgF2VLCSHeKVLJYDAb/TCVtUZTngl6AgqTR4/n6KV14HEw2zpubfNGZodjH+Ic99v4F8VqCNRrY77jz2jTNs/TsDps8K2oGb6gEnZ4iVaxYkfzLHJY21qA/yQuwmghpU9NGWudfGiN+KMzYVUBGAdXauJc6nADpekCmjZHjOI1c5tjguoGF0puN4XTcgFPtribd5sELNQpRrblEI1g4Nyej8v7NPmnZj5TOx/taZzCWMEC6PbwL2dMQO79aZ2t0jDD7T2eNAE3KjfCYOCXD9WxeXsFA6/nZC0UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jUWJkWHcHIsPxsAwNBDABpqb4Swc29u/ZUIgGUKInNw=;
 b=m3CHFSvDCrNfrGMIYrMnnhtEJW4xUETdC2b6JobQaf47FAVOyg7EIt7PqvPkqS68oAZcjXda609WEzHglpyMssf5WrCLPqLJziMOSpJkK+DmGRQFiNvrdCLRI1cbN8aVCjUZjMGwVkY2/hQtyZ1F8hBko2KcwLgxxd/m6Apj4N0fkQzyko7YpFfAZ3jCVGthmywnLY/maRQ/Ke/WkBSjqIm+7oetGiBMimnNba3ZUP0OoaEoALwk2BYvv8y/xYRmQNfcr1x2Zeg8HFQF0msQBT0iy6ZFG7tclQdhu6XDR3i/WKJBpsBP/ZJL9q6PKSkQJgrbeAXzzuybyHmiFe6ARQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jUWJkWHcHIsPxsAwNBDABpqb4Swc29u/ZUIgGUKInNw=;
 b=TYfd3sZWNiLzna2kzhtXWkrGBtJ1E33xS5Lq2lDQdAwM9X5Esc5coX/C3ZlFnfS0nUd6838LS4qYfmsw/2ibknucBb84bU91iV3BGy7L0Q6BtVb9S7S6r0F873MUXkxSfUpY9d/N3gui57ujpqo8gzb2flLZQBkbP/vWS31kN/c=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by IA1PR10MB7144.namprd10.prod.outlook.com (2603:10b6:208:3f0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.44; Tue, 1 Aug
 2023 22:46:24 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e%6]) with mapi id 15.20.6631.045; Tue, 1 Aug 2023
 22:46:24 +0000
Date:   Tue, 1 Aug 2023 18:46:21 -0400
From:   Chuck Lever <chuck.lever@oracle.com>
To:     NeilBrown <neilb@suse.de>
Cc:     Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 06/12] SUNRPC: rename and refactor svc_get_next_xprt().
Message-ID: <ZMmLPfP/3uqff2s1@tissot.1015granger.net>
References: <20230731064839.7729-1-neilb@suse.de>
 <20230731064839.7729-7-neilb@suse.de>
 <ZMhAsTSHy4lcEdnE@tissot.1015granger.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZMhAsTSHy4lcEdnE@tissot.1015granger.net>
X-ClientProxiedBy: CH2PR17CA0024.namprd17.prod.outlook.com
 (2603:10b6:610:53::34) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|IA1PR10MB7144:EE_
X-MS-Office365-Filtering-Correlation-Id: df382c23-b0ff-443a-0c26-08db92e12250
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aOh9qtmx3HNLpaq4c3caTNHPnizfkz9APrtELmoQd5owdbxav5kFuROr6a6JOSB+izjfghjgYJIFv2rCyeUjp8r+TZuWKKNBK/mGmEbeIftfJEwtLsFmpPoGls1h8TwcNUQDvZBuRil2tluevGVmWc2OZUAqN/nR8DKyaLteAshv68R3Okn+Y0EmLQzrF8baAcfkGcjidTcBakCw6MKsKq/Z3xI20YFngz5hCv6Iljtrt00yeXzi7TKx5Ik7Umj3KmP9nnKJsl91gc56srh4955hswEY1ui0d6DtwxxvCSNTmiH7CedEAZGsSoiC8bKlcTF0YcFrPgIIwaCxWUZnA5Y6ym6Lq8aaX5vmQcfIQ4mdeOBbFFBZpW28MDQ+4/WZrlgWYPBYh8wYp1QJThHgM5wbdmDhYCpLGTMJ2E2796tfn0WdZuWVIJldXpUGbSSfm6+a1Mib0bvguO4rJUUhcbQgEqqZBJG2ag1GIrGNaSfgzc1LGdf1wxVljkpDZV/UQbv+HCs0EwhTZPRDnPrih+sTHNvSYGlPdHqbWdEaeComJe1yAUjNuEwTArq984CK
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(39860400002)(346002)(136003)(366004)(376002)(451199021)(478600001)(6512007)(9686003)(6486002)(38100700002)(6666004)(41300700001)(316002)(5660300002)(66946007)(66476007)(66556008)(4326008)(6916009)(8676002)(8936002)(83380400001)(186003)(26005)(6506007)(86362001)(44832011)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uBbsGwxxfncY9nYMLomtHrcbljOiiR68KmDiR6BIDTEsQlEAkskAkDRSZUVR?=
 =?us-ascii?Q?7ThdFDcne2pM98V5nOCS6WNbYXDq+5fYOciuqXq8NNDruiEwS44Bq427DrNb?=
 =?us-ascii?Q?3QE5cZszOY1oeO88/I1TIeZhtbcDuoFdLxTSvSWb3XqNCGXicw5rgx+j/6S1?=
 =?us-ascii?Q?Ovt6PWLQAklBD4zI8mANWfFK4X6Oa6H25E+Nc+kCh5EHFstS/1o7RS6OUxy3?=
 =?us-ascii?Q?lB9hQz3lY91lYIu+NNMq1gNMQ4QyOkt/GeqJK9ARF3iL0wb8xAlr10Ftcjan?=
 =?us-ascii?Q?U7aCbYXkshvfhKlQYDvcBtMejnKB8rA08MLfY8kNBRCuEt/l8u7wIbPVcuZb?=
 =?us-ascii?Q?FOtx0k625YTeOX784Frkl3r78ZFHPVmT1iqZ6LYs/TgXAfxkg98e+Mm5cmWp?=
 =?us-ascii?Q?lZmtvQ3OOL2hKqUUlzLJsNZr59usiagubmC/2joWYqsRWGYbyv8kwL4YPWa5?=
 =?us-ascii?Q?0isk23lh4keyOtS3LIRjxwJmFpUZNsGgn9RJ5v2scCAN4jAymiwYi8XzvOOV?=
 =?us-ascii?Q?iHRMdsMoLrxJj53BNlNj+h1XSraBeL7HtBwEPPK2S0CsHVRqQbgi8utvoLG4?=
 =?us-ascii?Q?pSc2MERWqxVuJCsWTYAyaxg9Mf+b9Ollg4rq0EucXPt8gE2yeF2fEr3/wGWM?=
 =?us-ascii?Q?i8OMEg20cm80cZ61hzrucSKdvglM5pn480E6xxWmcsBQpEMsXvhVRdASQtGu?=
 =?us-ascii?Q?iNAPOpaay/i2B8g2HJ45vrnvyinO8VOPnXZfGWLKmru2Ko2l3SipAiux96lg?=
 =?us-ascii?Q?XWortRKY5T7qWdwWDAqBILAwQiOqHzQM78UA9t7OdLkqq+ZHUA0yZ09uIYas?=
 =?us-ascii?Q?EHVRt35Q+ZJQzKYN9XeCLFhl3QcVLdaYN74/xbWVrHUTAFdo4LT7ZRAOYMJZ?=
 =?us-ascii?Q?Jfxwio9zjCwZseW2paeVgFeLNzgCEqUVeAcsIuzl00u6daunoWBMOEbVKLEM?=
 =?us-ascii?Q?i5pYKSO2qsq3Rq714gGAq1BUxt/rcTbOTOny8P+wthQIOGWPMYtQHWWZn6WE?=
 =?us-ascii?Q?EqpVvVRWdWM5h5IMsMvdOc4JXLtQMUlkGHWObtdVEGj1rXYDh2nPnxu5BXiH?=
 =?us-ascii?Q?O9kE4Uz1JepOFjJlBajymNqG1xajE6xCbN9MDLczgqMMs1eaECNOtzg1QDFF?=
 =?us-ascii?Q?qQf+MsuL7rZlbMpkltYsKZLd5rjR7NKHVdIfv3fdIuSQeqH61jMw4TL0D/Gz?=
 =?us-ascii?Q?8niSzQVOje5hCyp5lSgqTtSiU2NEk+xrtGQoQmjCgLxS+qPMNXjaFV/O6YXn?=
 =?us-ascii?Q?hZZrSJ6tIvOqeTQoz0uul48Nkd/zzGpqhkNgK+DubyytjRP5Nsv/HWQJDJGk?=
 =?us-ascii?Q?tlId7pfjkLZIIgeyJr7nDGFWqQ/NURw+mi05QnEaJ6nQ0QolX9UpwWPMTcdN?=
 =?us-ascii?Q?MfCBZqBbeyqYqaT+OeJT1KR/OQYHHXjCgu6Iq4hzBUTID5FMF1fOhuEIubb2?=
 =?us-ascii?Q?aJFDfZVTbUFMkZ9nvbtlBKeCzsf+CWzgF5dDTggx9TwB91vpu2TJIulpol53?=
 =?us-ascii?Q?fi+5dr/bq7g9GSTpkiyVkuaNBZh36FPel9lg57z7SMDudMTS+Evv7yfy5Ktt?=
 =?us-ascii?Q?d+9oBQZA9Y0VgbsQM0N08JMQXKnlXLq6Ns5unArWXrmMB3XJKK2fN6WPYjO0?=
 =?us-ascii?Q?Yw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: tc90QRJbbo70NtkrhSgJ5ZO+tWraupXsYIm3nLnUL7EpHhq1yihw1Vj2CgmyeI0pnhVCkKKUCqNnIsUXocccBCb5J73NEuQjhpyOxAfiaqPjXc/X9DwwMaWtWQitls+fwZZnpLZoMnmeJfH/CPLwriWdCMfKEc+vPrPrm5Y+uqO+lLc5KjMP/DuSDOjvyJgBv1oiVvxfqcF57QizsAorQvE+u16abTuHV7iLX4B1t96uO2ojLu5rB3fBy0cqh5iBrRNq1kLlgd1LxRvyKoFF81AgV/0Yry0nB0XPr60jwzwiJ+9oQi4PVpvazQuLBiqhnCIjz5BHc3fk6LNT5gbfX3jBmnMrk5vw6sVi6WdtkM5vvpJo2X2A4JlTfVm6ImQT0MM5w5YGMYEcPCs797wibnKNi8FgZP6FEItG7DlWTsHhtWAnt5dytObHaqlbpsQ5mpZw+aBVmAK/XmKL26UIB5cGTxurQAdHMkp7cESIlG8L55sm0fxj8udhL+igSNXq+o5UG6IivIsThPVnuwgb9Na9lEOjYKEYC6vFrbolOpIK0oqQStE9NA76cYJfWj+CBganLGz5hGc7/FrSEYm4R9lkEIHdzTi6A09Fo+uWkN3Bi/SRfeXYVBL2vBMdHon6ll+X/+GINzaRqq3vxE1n5P94IAZNCy3OqFWBRy+NdrfMatxFaofvJVfSXwuWiC5tvMws4yQ0WvcPTF0vlGAuUElSghduV7k5XKQ9pHnENd3mHSVdqNKNzN5MOkUkTFK1+ZVnKHzUJTpRqCMwghW5hGJZZi9v8shbzOUkC1hH/QDxr7Xnbg1WujvICH4tkXRI
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df382c23-b0ff-443a-0c26-08db92e12250
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2023 22:46:24.5877
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vpuy0y/bEWKoSmcgB/lw7zUQfYlm8IwhjoZtTqmXGmDy+ugE1ZbQSjn7ldqb1BQhCVFGZuANoHCleeicuMDTaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7144
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-01_19,2023-08-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 suspectscore=0
 adultscore=0 mlxlogscore=999 spamscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308010204
X-Proofpoint-ORIG-GUID: awKVykjO9HJ_z6lm_pXcK-3K7VfuOnoH
X-Proofpoint-GUID: awKVykjO9HJ_z6lm_pXcK-3K7VfuOnoH
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Jul 31, 2023 at 07:16:01PM -0400, Chuck Lever wrote:
> On Mon, Jul 31, 2023 at 04:48:33PM +1000, NeilBrown wrote:
> > svc_get_next_xprt() does a lot more than just get an xprt.  It also
> > decides if it needs to sleep, depending not only on the availability of
> > xprts, but also on the need to exit or handle external work
> > (SP_TASK_PENDING).
> > 
> > So rename it to svc_rqst_wait_and_dequeue_work(), don't return the xprt
> > (which can easily be found in rqstp->rq_xprt), and restructure to make a
> > clear separation between waiting and dequeueing.
> 
> For me, the most valuable part of this patch is the last part here:
> refactoring the dequeue and the wait, and deduplicating the dequeue.
> 
> 
> > All the scheduling-related code like try_to_freeze() and
> > kthread_should_stop() is moved into svc_rqst_wait_and_dequeue_work().
> > 
> > Rather than calling svc_xprt_dequeue() twice (before and after deciding
> > to wait), it now calls rqst_should_sleep() twice.  If the first fails,
> > we skip all the waiting code completely.  In the waiting code we call
> > again after setting the task state in case we missed a wake-up.
> > 
> > We now only have one call to try_to_freeze() and one call to
> > svc_xprt_dequeue().  We still have two calls to kthread_should_stop() -
> > one in rqst_should_sleep() to avoid sleeping, and one afterwards to
> > avoid dequeueing any work (it previously came after dequeueing which
> > doesn't seem right).
> > 
> > Signed-off-by: NeilBrown <neilb@suse.de>
> > ---
> >  net/sunrpc/svc_xprt.c | 62 +++++++++++++++++++++----------------------
> >  1 file changed, 31 insertions(+), 31 deletions(-)
> > 
> > diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
> > index 380fb3caea4c..67f2b34cb8e4 100644
> > --- a/net/sunrpc/svc_xprt.c
> > +++ b/net/sunrpc/svc_xprt.c
> > @@ -722,47 +722,51 @@ rqst_should_sleep(struct svc_rqst *rqstp)
> >  	return true;
> >  }
> >  
> > -static struct svc_xprt *svc_get_next_xprt(struct svc_rqst *rqstp)
> > +static void svc_rqst_wait_and_dequeue_work(struct svc_rqst *rqstp)
> 
> It would be simpler to follow if you renamed this function once
> (here), and changed directly from returning struct svc_xprt to
> returning bool.
> 
> 
> >  {
> >  	struct svc_pool		*pool = rqstp->rq_pool;
> > +	bool slept = false;
> >  
> >  	/* rq_xprt should be clear on entry */
> >  	WARN_ON_ONCE(rqstp->rq_xprt);
> >  
> > -	rqstp->rq_xprt = svc_xprt_dequeue(pool);
> > -	if (rqstp->rq_xprt) {
> > -		trace_svc_pool_polled(rqstp);
> > -		goto out_found;
> > +	if (rqst_should_sleep(rqstp)) {
> > +		set_current_state(TASK_IDLE);
> > +		smp_mb__before_atomic();
> > +		clear_bit(SP_CONGESTED, &pool->sp_flags);
> > +		clear_bit(RQ_BUSY, &rqstp->rq_flags);
> > +		smp_mb__after_atomic();
> > +
> > +		/* Need to test again after setting task state */
> 
> This comment isn't illuminating. It needs to explain the "need to
> test again".
> 
> 
> > +		if (likely(rqst_should_sleep(rqstp))) {
> 
> Is likely() still needed here?
> 
> 
> > +			schedule();
> > +			slept = true;
> > +		} else {
> > +			__set_current_state(TASK_RUNNING);
> > +			cond_resched();
> 
> This makes me happy. Only call cond_resched() if we didn't sleep.
> 
> 
> > +		}
> > +		set_bit(RQ_BUSY, &rqstp->rq_flags);
> > +		smp_mb__after_atomic();
> >  	}
> > -
> > -	set_current_state(TASK_IDLE);
> > -	smp_mb__before_atomic();
> > -	clear_bit(SP_CONGESTED, &pool->sp_flags);
> > -	clear_bit(RQ_BUSY, &rqstp->rq_flags);
> > -	smp_mb__after_atomic();
> > -
> > -	if (likely(rqst_should_sleep(rqstp)))
> > -		schedule();
> > -	else
> > -		__set_current_state(TASK_RUNNING);
> > -
> >  	try_to_freeze();
> >  
> > -	set_bit(RQ_BUSY, &rqstp->rq_flags);
> > -	smp_mb__after_atomic();
> > +	if (kthread_should_stop())
> > +		return;
> > +
> >  	clear_bit(SP_TASK_PENDING, &pool->sp_flags);
> >  	rqstp->rq_xprt = svc_xprt_dequeue(pool);
> >  	if (rqstp->rq_xprt) {
> > -		trace_svc_pool_awoken(rqstp);
> > +		if (slept)
> > +			trace_svc_pool_awoken(rqstp);
> > +		else
> > +			trace_svc_pool_polled(rqstp);
> 
> Again, it would perhaps be better if we rearranged this code first,
> and then added tracepoints. This is ... well, ugly.

I've dropped the three tracepoint patches and pushed out the changes
to topic-sunrpc-thread-scheduling . We can circle back to adding
tracepoints once this code has settled.


> >  		goto out_found;
> >  	}
> >  
> > -	if (kthread_should_stop())
> > -		return NULL;
> > -	percpu_counter_inc(&pool->sp_threads_no_work);
> > -	return NULL;
> > +	if (slept)
> > +		percpu_counter_inc(&pool->sp_threads_no_work);
> > +	return;
> >  out_found:
> > -	clear_bit(SP_TASK_PENDING, &pool->sp_flags);
> >  	/* Normally we will wait up to 5 seconds for any required
> >  	 * cache information to be provided.
> >  	 */
> > @@ -770,7 +774,6 @@ static struct svc_xprt *svc_get_next_xprt(struct svc_rqst *rqstp)
> >  		rqstp->rq_chandle.thread_wait = 5*HZ;
> >  	else
> >  		rqstp->rq_chandle.thread_wait = 1*HZ;
> > -	return rqstp->rq_xprt;
> >  }
> >  
> >  static void svc_add_new_temp_xprt(struct svc_serv *serv, struct svc_xprt *newxpt)
> > @@ -854,12 +857,9 @@ void svc_recv(struct svc_rqst *rqstp)
> >  	if (!svc_alloc_arg(rqstp))
> >  		goto out;
> >  
> > -	try_to_freeze();
> > -	cond_resched();
> > -	if (kthread_should_stop())
> > -		goto out;
> > +	svc_rqst_wait_and_dequeue_work(rqstp);
> >  
> > -	xprt = svc_get_next_xprt(rqstp);
> > +	xprt = rqstp->rq_xprt;
> >  	if (!xprt)
> >  		goto out;
> >  
> > -- 
> > 2.40.1
> > 
> 
> -- 
> Chuck Lever

-- 
Chuck Lever
