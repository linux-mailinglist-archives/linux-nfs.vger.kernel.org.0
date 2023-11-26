Return-Path: <linux-nfs+bounces-78-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 306A97F94A5
	for <lists+linux-nfs@lfdr.de>; Sun, 26 Nov 2023 18:41:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9AE4280FA5
	for <lists+linux-nfs@lfdr.de>; Sun, 26 Nov 2023 17:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73F1ADF60;
	Sun, 26 Nov 2023 17:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CyiX5WYn";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="cqLuDA5M"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA4E4D9
	for <linux-nfs@vger.kernel.org>; Sun, 26 Nov 2023 09:41:27 -0800 (PST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AQHa2wk002735;
	Sun, 26 Nov 2023 17:41:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=BpMwi2NLxGuxlLQ4zCULDpERF5I1pK7QzwboEpPz4EE=;
 b=CyiX5WYnrBtBJhmiOHvXW13REPSPWPyd5pBi8fs7IboGt3ve6txJ0cYr9ObEy6zghSzE
 beZO+v2SXLQKiZEylrGkXanR3qmV6xgyhcA5mRSZV8b6ZWbpteJrlZ5RYxAOFjBPg+T4
 TVKuScMhSNKffWjdMVRu0yXTIclsNIsk1Cxr5XqYlUWYdc8uVrTQgtth3EMAiNmiTcJJ
 QQesHl7CLevaevclQrOxrJzmb90nfxMOlfpqZY6hUViM53RbMBNYGU6j0rPb+BBDpNvy
 u1zvC/xZKC9k0dROZmIB+Gg2ki5i/yqDILzajt6i/W9dYSK1v7AJGbRjlEESjjLtKphF Fw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uk8yd1gdj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 26 Nov 2023 17:41:15 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3AQFRXJL009333;
	Sun, 26 Nov 2023 17:41:14 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2169.outbound.protection.outlook.com [104.47.73.169])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3uk7c462a1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 26 Nov 2023 17:41:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S678coX48gUlNUzeVSszr/7WX5ZophFJtPjBypkkG2iGxryMvQsBSHt3agGdypP2fzMnNnQzjW3zEWCO5sFPZ6bxFUzwrJNhdHdkegpOS0rmnCkDEvSQNvA52irtGFp8N2sTBgCNp3NlGEXAQae7vjO4T8y5RiYPU1tOJQpo2M80mqa0R3WoF18KDxRq5ArS+WsGwYa4iCYKg+0MGbgWWp7v4wOvVbAo7PKHqUXOubuHj/B7i2IjlZM3eJHqxpjhZQmRuZau1RrNSPgV/cEFKdolXPB/Rd3ddLCe4GAwXc5vjLP+qU0AVBwRD1IeExtXEsYx0BUn3ssMUEuRA5V2UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BpMwi2NLxGuxlLQ4zCULDpERF5I1pK7QzwboEpPz4EE=;
 b=WgjulLtYlDTKgWFMDtnnYn1luj8dyY0WhUKRHPSJHyuLlmWtKjAR1lifeelANyzWToB3The9LZTvzoaF4zqeWCgmNq0WU6KVXNdLH27CffTvdG8jj4XQnol9iszwdAVVOi5Y9dA9OTxbHDvta09xYFExsSkCNEf7Zik2xRqoGqcz2+G3MPqzYpoCUjGBSOPQdZCP+MdRy1vjD1FT0crbUnlKwy3DBLx/CsrJMFLLGb5VPK8+gGQppdAG4pzu1VcUYJ/Ij0r+5VOnvW1oHDlIyp8p7Oido6X8U8p2nAb7BqceFKqWXvtkbGadALI5qtr/JxtrDNU6xWEHViBl+YrrxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BpMwi2NLxGuxlLQ4zCULDpERF5I1pK7QzwboEpPz4EE=;
 b=cqLuDA5MocP2/tYcPFpRnfh0Zar7sam0Z5YlmYNAnft7gO4kcw/sKmcFn6W+BFYsmnVL5BUJtA0ZyRBejfJUUEm4xDrMM3NS1VCgWVPgFk59e9SUNEd7/OzNNBWwGsDBeGp0AU88RzVMV7ViMtwps9eH8ZsdnWQxWXZbHuvYBec=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BLAPR10MB5106.namprd10.prod.outlook.com (2603:10b6:208:30c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.27; Sun, 26 Nov
 2023 17:41:12 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c%4]) with mapi id 15.20.7025.022; Sun, 26 Nov 2023
 17:41:12 +0000
Date: Sun, 26 Nov 2023 12:41:09 -0500
From: Chuck Lever <chuck.lever@oracle.com>
To: NeilBrown <neilb@suse.de>
Cc: Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org,
        Olga Kornievskaia <kolga@netapp.com>, Dai Ngo <Dai.Ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>
Subject: Re: [PATCH 06/11] nfsd: allow admin-revoked state to appear in
 /proc/fs/nfsd/clients/*/states
Message-ID: <ZWODNaH7TLLJFvQB@tissot.1015granger.net>
References: <20231124002925.1816-1-neilb@suse.de>
 <20231124002925.1816-7-neilb@suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231124002925.1816-7-neilb@suse.de>
X-ClientProxiedBy: CH2PR05CA0014.namprd05.prod.outlook.com (2603:10b6:610::27)
 To BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|BLAPR10MB5106:EE_
X-MS-Office365-Filtering-Correlation-Id: 25c5de68-28a1-4b34-e7df-08dbeea6e1b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	vewv86o5it1m+KkfU0N609FzUx4ShpTTJHRa2FrqjkZb8AVWDjE0/cB0z+xtDOJ79Is6Z2ViMxKgVGrKsUeb7aWOW3m53I1HmCsd/HZCpHFmGGaVg9ga0lUmUfquD+VPZ7BwPRAuC2tX/14r0k6Qg73Vik+qN3UFYwL1FcY6a9EjCpnimd3SyUvc6v9uB+FiyinUYSoVWGZikYZqIBAqgkFpGOdNNrndlz+/xHD8qRDOY9ZvYYtFrAU/0k0NRMKN8q/vjzWkB/jraC0+Ltg6C/TMIbmU4KHl5Gg9KQkWWkL1z2DSJaMU6ibN5N10HxeV1lal9kwEDke4eB2d4KUG/bfxN4+C8Am70gSIPjVkQcyzkkIwdMi2YQedj14RBFIm/fnlDIoywsI9OCnV6jqZ2UFvdZMEmRtyMlywXsnsmsnG4ha1CqYazvWCvort9aHouT2ntvR+wK6qBGplo3lKucA2RWrV/5LB+kc3t7LeFZTwrZVhRi0Mvndn7XXhRfaktVlYJ1BNRo2dil/USdzmqejMXatxdal0V0K/gbqURPTUjuNsS6KWPsrS6tV9x6ZMlogeEg3krc4owcvNYEZQOgmUJVuz0Qgkq+JL+X6TZCc=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(136003)(396003)(346002)(366004)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(6666004)(4326008)(8676002)(8936002)(6512007)(9686003)(6506007)(66476007)(66946007)(54906003)(66556008)(6916009)(316002)(6486002)(478600001)(2906002)(38100700002)(41300700001)(86362001)(26005)(44832011)(83380400001)(5660300002)(21314003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?2638QF+OcH467zuvcN4boHNake0kLaW90jVAALoAUHcEzaC1q69znEgCD5Yc?=
 =?us-ascii?Q?96b7U1K9WvbvSaFrJHTWJ3kWXR6ekZif0xNKG67FaWRF2PIWgJpw9hkQKZrV?=
 =?us-ascii?Q?bBtbFdJHQEPIQIWPGzAhaugUUUKwPrFusuOuuNqXvFBkAppSHnk6b5fSw6Rt?=
 =?us-ascii?Q?y9mSulJwj6ph3v5wJZNGuAxWc1rH8aUux277SCPJrZ+dEHMLaseIBaFSWid4?=
 =?us-ascii?Q?V9rO1vwO+SVaaXF9/rhUehSde+v9tl5C7nnecbNDollkI+Np4KxIMk12WF2y?=
 =?us-ascii?Q?aRAU1pyJhWZlRbiq5ZRWaHEZ9J8zXxpLXcIqzGAHqCCeGYQ1NuaIDWBRgRn2?=
 =?us-ascii?Q?cA+1MxWHVbcsYmtHN24Cg1Fnm3SpbI4YH9Y5ZGbAMdc+7ll5c0NM2VXbSRo7?=
 =?us-ascii?Q?WMeeHE8S9iOre611jTtG7RGL7uPcqDt5YDnE6hmv/zfRHrFkG6+3U/dRvDEg?=
 =?us-ascii?Q?kHoUIRebJp15bfMrMvXPBtnavLhyTCeiprsLeksKz4thYuXbZKKOzt5HJgvq?=
 =?us-ascii?Q?WgmleBOVzpy0xORpB5KQdo7OnTsagaBAJYV+J5aF16haE0JYd/z30jGH7n0m?=
 =?us-ascii?Q?BB6XD6gIW0OAQKnr7jKknRqtM53kMrFFNH0R8SEfjJKMHQyY9f0FR3yxSMf7?=
 =?us-ascii?Q?Ma3IE1Ww16X9J4cTXyybwYhOoG3lsHDJSSM5XSk/+o4SI5OytJUcu5w9TwAr?=
 =?us-ascii?Q?j9uJfbuQAiRWT0IwaILaqY7jhlXMr9K06EjGVE82n7yxSiOmtc6mbErp/nFc?=
 =?us-ascii?Q?1v4awMj6Qu7FAzH2OVoqnzwDxLYjuMboNFEkLqfUhfo3V92XKGJHzDShf2PW?=
 =?us-ascii?Q?kv7iuTltcT5mVY6JQCLI5TPh+h7czdcgVoLACco0MOhSQlisfT9Y/5XVjuY+?=
 =?us-ascii?Q?gyX8xqpQ1x7ENC+h9EA098PTF56DkIkSxd4s8exNj8r5SXWfyUXNx/epIiaV?=
 =?us-ascii?Q?8hMTEK1uLGcXTiVv8HI0MKyKaoN9rDPMXmB5I2UVDM1fbYz3JKqJyATari7u?=
 =?us-ascii?Q?NBOosRQG27u8EaMby304QdXmLL7LhcDIc/7plcwpSeyYTVvGlK0ScjpjWudJ?=
 =?us-ascii?Q?Q1WVEYDldpg7ztBh+UELpq/+cszBYxd7tYva7H/Fz2YD19bnLASKL1cUtOrw?=
 =?us-ascii?Q?gEWVyEUTqSRLj6/nMocE+ZTx8hXXcv5ciN3P0FZ7pqy4yWYWQOw9LUKb8P6Q?=
 =?us-ascii?Q?vKhJuwZyrmhh3ryGUvENYVtOqPov4qLliTxslGjK8ebn6/FAUKhjNfzQXNPM?=
 =?us-ascii?Q?L0uRN8krwpR6ruRC1JMO1N6rCB5cYJ5+Qm3bp5idQrPdxnM5pL7woLGZKzMf?=
 =?us-ascii?Q?3/+I+c/QDwQjYeIDkQf6C6BrL9kTUYMwjuY5SOL9njcSVb9Fu5cTD+5OO/5x?=
 =?us-ascii?Q?OGBpnsX5uuTTl0N8hwNJ9pAdvr85AmNGZFp4cAE0hX5JBb8SmzQTqbeZDama?=
 =?us-ascii?Q?AKQM5YMdT6UKxjq9qYk4O5/fGydgyJ5Fj2DO51a/h7bXDqKAJ+e1veljsH86?=
 =?us-ascii?Q?M1U8GbwRFCsO17u2G99rowVhx+Zt99FOkjMQ+nzTrEZuUwcX74+zuO/DGRh1?=
 =?us-ascii?Q?6gNbvgfre3AKzH1GhJiWdEXPBSx0I5ZJ57H7+xGmZlA6M1v7lEONd0w/sFfm?=
 =?us-ascii?Q?bw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	8x1DWUyQXeOFLlg1Vtxs5vAiyrQA0Jd6womXg9pGl00AyktsIKeUOqiovcV0Nz0FoRyOBq7TBQDFGDuT/npH0uV4Fu4qD17uwjbzRz/bZhk+YV0Iyykay2jE04jyiorfkqNcwPSsL4mHwNycEuFpXSSFaQ3R7JkhaGj+++4QZPpOsnoJp2bWDKcegf/kkPKyfvEzuxKhMuxF3IzuD40hv8F99JgS1PK8YIYWgOEkHqweTgJKE6CUeEu21i3yAmLlj84I+PhOWHW3onAzeMfFcHMFwRdhK6B3kK1W7l7x7+3c8C3NNq5PDDfM4/IA5qdHIW/oZMLJydOvrNGmk5l29vUC1u35e5GDyvfo6xDaQ7dSXaRGMQ/GV+HdWFuXAu9/hoe+DEyCv7WqTmKPW6WKpS6FUQIZlBBicYUV9e54VbftMT9WQsL+unSQUeR3V3ew4ugzoXYYTZN+MwfzWQ38QFcNWdL3TMICL6pRP6r/59nIZhLtx2vX41Y4CAOJcLSNkZyvRf6/vNhgYEsHH7h0M0a6b0Cqr3R2Rv1yHt1cVvgxJV2TSyWYkUzkakWOtUgruDpPJQha7rsHew8d838QBuatqrHwf/bTCXhFqpxK1b0BTJc4NC1eGDfxliiKkaZJrnwV3fdA0qutn3nuWEpnhnxEUWSyNzOiqM60GQQ2oiAflFsL8i1sU6/OBIiWa3asNoLhWcISOLWTdTWmYmUpVVJIHP9WTU6zcSyH8qp71TWASGakAM/lhLsuUGouYPl1nsm6kvPamtN0aGEBIr3+mKE16B6YP0rcX6aLDI3gb001WkR0fYZI7696Eid4d/dt0fJXFkaklQ2fWLPSJfyfoRBLEk54Wdh9foKbRG6GlKVJFZ7Q/cyiUauz2IrRjQpX
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25c5de68-28a1-4b34-e7df-08dbeea6e1b1
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2023 17:41:12.3202
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Lp2Q5IMe6MRZ3AO1hTkrOSDUDJEpqyJHKXun20TtgLaK10k6eVwBt7yf9DmoPzElI3yoRbbw4hrOhRXj3zXASg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5106
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-26_17,2023-11-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=876 spamscore=0
 adultscore=0 suspectscore=0 phishscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311260131
X-Proofpoint-ORIG-GUID: j4pNujm-cpc11jnStzi5NH3XIEuKR_EX
X-Proofpoint-GUID: j4pNujm-cpc11jnStzi5NH3XIEuKR_EX

On Fri, Nov 24, 2023 at 11:28:41AM +1100, NeilBrown wrote:
> Change the "show" functions to show some content even if a file cannot
> be found.
> This is primarily useful for debugging - to ensure states are being
> removed eventually.
> 
> Also remove a "Kinda dead" comment which is no longer correct as we
> now support write delegations.

Nit: I know it's in the same piece of code, but the "Kinda dead"
clean-up is perhaps not relevant to the purpose of this patch. Maybe
do it as a separate patch?


> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
>  fs/nfsd/nfs4state.c | 82 ++++++++++++++++++++++-----------------------
>  1 file changed, 41 insertions(+), 41 deletions(-)
> 
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index 477a9e9aebbd..52e680235afe 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -2680,17 +2680,10 @@ static int nfs4_show_open(struct seq_file *s, struct nfs4_stid *st)
>  	struct nfs4_stateowner *oo;
>  	unsigned int access, deny;
>  
> -	if (st->sc_type != NFS4_OPEN_STID && st->sc_type != NFS4_LOCK_STID)
> -		return 0; /* XXX: or SEQ_SKIP? */
>  	ols = openlockstateid(st);
>  	oo = ols->st_stateowner;
>  	nf = st->sc_file;
>  
> -	spin_lock(&nf->fi_lock);
> -	file = find_any_file_locked(nf);
> -	if (!file)
> -		goto out;
> -
>  	seq_printf(s, "- ");
>  	nfs4_show_stateid(s, &st->sc_stateid);
>  	seq_printf(s, ": { type: open, ");
> @@ -2705,14 +2698,19 @@ static int nfs4_show_open(struct seq_file *s, struct nfs4_stid *st)
>  		deny & NFS4_SHARE_ACCESS_READ ? "r" : "-",
>  		deny & NFS4_SHARE_ACCESS_WRITE ? "w" : "-");
>  
> -	nfs4_show_superblock(s, file);
> -	seq_printf(s, ", ");
> -	nfs4_show_fname(s, file);
> -	seq_printf(s, ", ");
> +	spin_lock(&nf->fi_lock);
> +	file = find_any_file_locked(nf);
> +	if (file) {
> +		nfs4_show_superblock(s, file);
> +		seq_puts(s, ", ");
> +		nfs4_show_fname(s, file);
> +		seq_puts(s, ", ");
> +	}
> +	spin_unlock(&nf->fi_lock);
>  	nfs4_show_owner(s, oo);
> +	if (st->sc_status & NFS4_STID_ADMIN_REVOKED)
> +		seq_puts(s, ", admin-revoked");

Wondering if this addition (and the other similar additions below)
would be more appropriately done in the previous patch. These
additions seem to have a different purpose than the purpose stated
in the patch description: "Change the 'show' functions to show some
content even if a file cannot be found."

Just a thought.


>  	seq_printf(s, " }\n");
> -out:
> -	spin_unlock(&nf->fi_lock);
>  	return 0;
>  }
>  
> @@ -2726,30 +2724,31 @@ static int nfs4_show_lock(struct seq_file *s, struct nfs4_stid *st)
>  	ols = openlockstateid(st);
>  	oo = ols->st_stateowner;
>  	nf = st->sc_file;
> -	spin_lock(&nf->fi_lock);
> -	file = find_any_file_locked(nf);
> -	if (!file)
> -		goto out;
>  
>  	seq_printf(s, "- ");
>  	nfs4_show_stateid(s, &st->sc_stateid);
>  	seq_printf(s, ": { type: lock, ");
>  
> -	/*
> -	 * Note: a lock stateid isn't really the same thing as a lock,
> -	 * it's the locking state held by one owner on a file, and there
> -	 * may be multiple (or no) lock ranges associated with it.
> -	 * (Same for the matter is true of open stateids.)
> -	 */
> +	spin_lock(&nf->fi_lock);
> +	file = find_any_file_locked(nf);
> +	if (file) {
> +		/*
> +		 * Note: a lock stateid isn't really the same thing as a lock,
> +		 * it's the locking state held by one owner on a file, and there
> +		 * may be multiple (or no) lock ranges associated with it.
> +		 * (Same for the matter is true of open stateids.)
> +		 */
>  
> -	nfs4_show_superblock(s, file);
> -	/* XXX: open stateid? */
> -	seq_printf(s, ", ");
> -	nfs4_show_fname(s, file);
> -	seq_printf(s, ", ");
> +		nfs4_show_superblock(s, file);
> +		/* XXX: open stateid? */
> +		seq_puts(s, ", ");
> +		nfs4_show_fname(s, file);
> +		seq_puts(s, ", ");
> +	}
>  	nfs4_show_owner(s, oo);
> +	if (st->sc_status & NFS4_STID_ADMIN_REVOKED)
> +		seq_puts(s, ", admin-revoked");
>  	seq_printf(s, " }\n");
> -out:
>  	spin_unlock(&nf->fi_lock);
>  	return 0;
>  }
> @@ -2762,27 +2761,28 @@ static int nfs4_show_deleg(struct seq_file *s, struct nfs4_stid *st)
>  
>  	ds = delegstateid(st);
>  	nf = st->sc_file;
> -	spin_lock(&nf->fi_lock);
> -	file = nf->fi_deleg_file;
> -	if (!file)
> -		goto out;
>  
>  	seq_printf(s, "- ");
>  	nfs4_show_stateid(s, &st->sc_stateid);
>  	seq_printf(s, ": { type: deleg, ");
>  
> -	/* Kinda dead code as long as we only support read delegs: */
> -	seq_printf(s, "access: %s, ",
> -		ds->dl_type == NFS4_OPEN_DELEGATE_READ ? "r" : "w");
> +	seq_printf(s, "access: %s",
> +		   ds->dl_type == NFS4_OPEN_DELEGATE_READ ? "r" : "w");
>  
>  	/* XXX: lease time, whether it's being recalled. */
>  
> -	nfs4_show_superblock(s, file);
> -	seq_printf(s, ", ");
> -	nfs4_show_fname(s, file);
> -	seq_printf(s, " }\n");
> -out:
> +	spin_lock(&nf->fi_lock);
> +	file = nf->fi_deleg_file;
> +	if (file) {
> +		seq_puts(s, ", ");
> +		nfs4_show_superblock(s, file);
> +		seq_puts(s, ", ");
> +		nfs4_show_fname(s, file);
> +	}
>  	spin_unlock(&nf->fi_lock);
> +	if (st->sc_status & NFS4_STID_ADMIN_REVOKED)
> +		seq_puts(s, ", admin-revoked");
> +	seq_puts(s, " }\n");
>  	return 0;
>  }
>  
> -- 
> 2.42.1
> 

-- 
Chuck Lever

