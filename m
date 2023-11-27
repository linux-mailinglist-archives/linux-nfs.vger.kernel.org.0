Return-Path: <linux-nfs+bounces-89-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD6CC7FA45F
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Nov 2023 16:26:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D14121C209BD
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Nov 2023 15:26:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45C5731A8E;
	Mon, 27 Nov 2023 15:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UYyyh0L3";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="vkYP2Vm4"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32A9AB6
	for <linux-nfs@vger.kernel.org>; Mon, 27 Nov 2023 07:26:14 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3ARFJC51005225;
	Mon, 27 Nov 2023 15:26:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=TyaLXcVZPkp4UR9Zx4x/yzLk2xUgNkNkPipLVHmArUw=;
 b=UYyyh0L3pShzweewQFOcZf+gGQXssSZ/Rg1UZ9r38dhjHIsgNSR6L25PCedNO1BIoLs5
 fEwDkya5HJTaTMXifD9BF7TWvkup/jHKl5+opgebr3TfU6OM6tZ/W9qwYPgIQAWZH0Cn
 mtEfmqCIO+LuAerfRyYgVLVMxc2OzlytCYuNxRCec0xKtP3FFP7y0cV8dur8tq2bFCDg
 mWu661WeFRr3bU/bUYQ6cPhofUctG9ZxC/oEjzBrtHQLinjFXFDoNeSYvqG3H6RP/etS
 KFPwkiKhlKIG5YSgp3lC9QuSyQ9XkT2qftK2Ig6ebkQrBV/GVPaPIHX44VJHW3N0uwIl Vg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uk8hu380p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Nov 2023 15:26:05 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3ARFG3rv002242;
	Mon, 27 Nov 2023 15:26:04 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3uk7cbnhxk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Nov 2023 15:26:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jNFcUVo3GiWg9NBYtFzdoX8WMSSLG4chWcNc3v8QYuCV99MkCZUGEfgs6oKmFN9xT1AoDzJiEgew2yN6hT2f1Fdip4vXUdQ7t9/v05uhdQ8m5k1jV6VJ3UmUrmsPQJyH/Nw+cfcyooixGzRoi8/eGs3R5TbEqAPlGlUSdtrKcSePUPq/aIF7u5898EzXrUpuXgvFcAyEd8OORtc6H5DhHU7OimTJtCa1Au2h/O1r5Xe1NH0R3cATLkdbe5iTQlyowB0Q16GzNV7k+5Sm34wt+iE0RkW4yGybHlyL4T5+S6ltglOnhwjj83VgZacWeKs5YVCikBlVp7LLTubiTTIbAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TyaLXcVZPkp4UR9Zx4x/yzLk2xUgNkNkPipLVHmArUw=;
 b=C3mNJeFkjeCTGMWx7n57JOy/BZKiANlg60lFf7XzQJo9al8QKlzhd3DPDAwTAGcGtUeNjmmrbR8kdZEngVo6gaLpAlA5zGjkBy8SOqg3E9cvu09XEUZGHAhIPqKbtKS6Tci/k5NG8x177uvUBK4gHOzC4IV10ay1gqWmBvrm124oFkDj6/B0tYYydWhRDbgRooSW6ASmelrmDn+NKWTbK6ZGn+Z457XGuhXYpKJV1lZmklFLbgU6zWX2xsnmt4ZAW8GXlmiSt7fP76uHU7qSkg0q1HU7m8a0O+JyfAwzDImm2XT3UjNNngtMcirrOaou+Xv1Zz8xq4s3xY1ocKKGAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TyaLXcVZPkp4UR9Zx4x/yzLk2xUgNkNkPipLVHmArUw=;
 b=vkYP2Vm4vyCgfzY5RwiSnNZDBgaB+XZA0fYLEIhRqrS6hn/q4FpTdob8n7Eb4KyjdX1QPdAana7vWyJWRr5S9QgZbS1KxpFX1qGXFjcKGpvNmBfqej6cYUUjPRWFV5VVoLVMoMBPwlbrlUGTukhrI1cmlSgsX/vXoCXdnsed+60=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BY5PR10MB4228.namprd10.prod.outlook.com (2603:10b6:a03:200::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.29; Mon, 27 Nov
 2023 15:26:02 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c%4]) with mapi id 15.20.7025.022; Mon, 27 Nov 2023
 15:26:02 +0000
Date: Mon, 27 Nov 2023 10:25:59 -0500
From: Chuck Lever <chuck.lever@oracle.com>
To: NeilBrown <neilb@suse.de>
Cc: Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org,
        Olga Kornievskaia <kolga@netapp.com>, Dai Ngo <Dai.Ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>
Subject: Re: [PATCH 11/11] nfsd: allow layout state to be admin-revoked.
Message-ID: <ZWS1B2qGiu2SqARc@tissot.1015granger.net>
References: <20231124002925.1816-1-neilb@suse.de>
 <20231124002925.1816-12-neilb@suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231124002925.1816-12-neilb@suse.de>
X-ClientProxiedBy: CH0PR03CA0226.namprd03.prod.outlook.com
 (2603:10b6:610:e7::21) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|BY5PR10MB4228:EE_
X-MS-Office365-Filtering-Correlation-Id: 7913e405-25c5-4c5a-7771-08dbef5d29e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	NIrRA51+xkOf2YyFxFSUURbpdxCzeahawatQGEE8nptZXHPTkmtdQL4WA6xF3vK3ZEO//Q15ZaRFDQgkZpSid9mGFpIaVQPkjkN7P4OCWjSvEV7Jpee8Gg1WCen7KzrlWI7z5lffCuXzE9GXK4oMSnCXLoTmVK3fg1kSd2lm/exHdNx7TsGf4cIENR+JXxyO9G94L4vXO7YXxIlTUZoRbjjCCnSXJtcoe4P9ndu684aAbFc1+34FbPpZBeGvw1JkjUaP73gS6uEbgsLQ8DQN+Ty1thJoqkP/TT1R2ytaUBOiyDujR1sWETxVcdplBI4FhoJoGT7Gu6hHhrKzuErftJJ9AF8ovlKSXNkARtXMogsWQ31zIhxMAEOfKr+opJFlmoUwJCxNoijTA+lF52W3TRRzfeAmF1gmOkochPv1KJ+e9f8dS7AjG6KLQzgjneVcIGOCWdIKS4KEua0z0z/dYLAUCZYlhxe+/bg4tleSi6gbtGlolb3eoiUOybxkwZKCwzbOzlbXkf/B9XCIRFwxRitIpMrt2wTGNFr+QSTDWsMr4QpMO8PssdB1ah/9AXrOpJzuylWL26nb66LqZxKlNRx+bOsIlGn6mYAfjRbOndc=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(39860400002)(376002)(366004)(136003)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(5660300002)(2906002)(6666004)(86362001)(478600001)(9686003)(6512007)(26005)(316002)(66946007)(66556008)(66476007)(6916009)(54906003)(8676002)(4326008)(8936002)(6486002)(6506007)(38100700002)(83380400001)(44832011)(41300700001)(21314003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?r1gAFyl7JNIHorowrUvcj3fy/LQp1JD7bWdk5L7knrvd/DwxSRBxpU35g80+?=
 =?us-ascii?Q?HYtcIYUQOmyJ2MJTjexNV3Up+kmTCxo6VbDnZFxXgyoNQW5f73zp3iPx06RP?=
 =?us-ascii?Q?2ibmDRbm6v1NR0lPKubjI1YYpx/Wk+fbUuzhHluz0E4+LZC5ieKRJwNdjg+c?=
 =?us-ascii?Q?i8GDGYRLwEWpX3ODE7cmSicyZNwX/LfQlTslwMTmADzNemBHqEhcv31YZxac?=
 =?us-ascii?Q?L/BGYMHbPPYzSuUo4n5ErEw7znfLwkzdN1TKFCp11tb3JPrStR152s4YF0GE?=
 =?us-ascii?Q?9CYvox3G0IohtCXKpBOs37RF5I4Uf8/p6enhQkwAQoLpt2xZlyeW5svL9YXB?=
 =?us-ascii?Q?LTFfWh9ajbh9qkL8Iv1YbU/MggReJotM6LvsiXi/1wzKpeRV5vfdJMym/UtB?=
 =?us-ascii?Q?8XlBLNNfA5fFFTmu3BGSvNIHdX6Z10dowoXfEImljqi34htkxzzLXgN6Z6Wj?=
 =?us-ascii?Q?Ia26N+oAv7oEqjjpTKnPCun+5EIIdUsD5eCDfn0pzd3NjxcwJH2ZY5dNoQT/?=
 =?us-ascii?Q?lfB9QOAVm8o23bqBjPOtOJlo372Nypab/tDJWDHu9cHWCzR0QxE/1lN+beRV?=
 =?us-ascii?Q?4Uf31AokK7b75PemvhVoLRbz0BCKme2dsxr0CT9VVYp3vOntqSY5jGKBWz3E?=
 =?us-ascii?Q?BbAt5dWY39pzzArWh8fthW1iqSfAUhgufKwTf79FXoA9Yokihx148cc0ds0S?=
 =?us-ascii?Q?rdw062hiQtxxlXcFbp07wBboU4tNxBcJAW3GMLq1FWAslNTFGPrhk0I253kX?=
 =?us-ascii?Q?Oh80QcwUBdfp1dFFO+fgkneRCzC8NetEUen/ePvKqkkV874ZM0xZyb+MCdpk?=
 =?us-ascii?Q?j2RdOQwHTvUdnqhME2RtJinqbb4/vYdWabvRZorIKAw3ik0kJg7wBC4rQ4lR?=
 =?us-ascii?Q?U+kh/3vns+2yWvmHXzy76NiZphGEHRQFOEJSTRYKSsA1YiXA/mBfqwyrqZ6k?=
 =?us-ascii?Q?YEU5Cpv2iQJcwE/mcdp7hbBuNvJh7dejqYMdYKhYHoZUctjd/50ZBQQoz4Ar?=
 =?us-ascii?Q?TxTwMWp0IrrosIqauEvo+7TXDhNBfVTfBXeSRhJHf+ffMIaAyPfFyt/LGI42?=
 =?us-ascii?Q?fqj8y4XOLHQtaeZ8MhZ2fxfNkqsx8xi2kppqOqkDIAYWQ/bp8aSOf85HBhb8?=
 =?us-ascii?Q?kdD2/kKREeE646RKi9VwYbzRsWCjM5s/tmDzd8P8XMETmTrhW32eJWGV9t4v?=
 =?us-ascii?Q?+Ubny+QcKTOiY9GtWPs5efErf3B4hVHd95IEP+AJo8AG5z1lDmFDgumoWF5+?=
 =?us-ascii?Q?0PeHoYkxAf79RDPPCiqi9YMco+ARtGBV3twqHKA5eKOu5VaV2utha3LQ79ie?=
 =?us-ascii?Q?c7ljFfMYiL9KLhOeOvC7XlwTs1rIdeBXkTS3oO/gXqWQDjAzgn1nZK3Rrzcq?=
 =?us-ascii?Q?E56V0rzE5ePesay3rVKTt7AjCZV3RXa1YEqfxMMp/S+P8bJmUmPwA9gmJ37p?=
 =?us-ascii?Q?9umVbcPhyoej8mvKL+s3Eb5fddBhTaxIffasPpIUnaCuFIZuWMQz9gIWGvt2?=
 =?us-ascii?Q?VnY/b4cWjiGx0wJiUNPiFhJibRQ2eEFJk1zDF46xbJLMbmMJobVLNURt0GFj?=
 =?us-ascii?Q?3ie+eS31y2HbHrtWQYhvg2tn21iwfvpF9y+JF/LdMCAi/IZvCb07O/iSeZoy?=
 =?us-ascii?Q?ag=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	I3m9eBJtJ99vvuYT51BYdg/soYf/ylqU7UuB+EIsxK8xSD1cz1YuNjT6PtTAI8WHBjNilAyw9w7pt8KfAJ5gEAiOqN9A1bgiju3XClM4GLfauumBv2rYdHGyxHlc5/iDXvtX5JNfFGA1VFkoH1aEqoooQPEwTyRFMbzcnnPPeRQYrcuTj4feK7rZVmN3YYz7kI3Tu1tIRkHx8meOygEXsace17P37sxpv2DE6RrVib5N03wdZFh4a5L5u8X1DwRWr1PKYMLeEFM/JVj2pNw+93UI16iFuJSthNwHFHqDPBuKrIsv1IJ65Cmj+5FD7SOwIDFCnG0+eijoH8dk3XMqSYMWB4+nxH+IkWM4sDOi15VzZpgwjNgfaa5m/gNXNKkCDUxFJQcZHm3M2I0FnkLMB2idptBnRcafo1O8OFwHZnrJdmlDSyABUtcmFLpj6SjEZJggbtWddbWtyANhMgkVLuBRtANcmLnjWBFzQzjaeek/p2Pi42m1mUf/AHpyS5DaEbcyw96FWh5BEHgBBQNmta3idVm0suE2YeP+AySu/DDqVC3wIJjpks0bEZRQ2d3mf4ik/XBY3Zexb/Pq/BvNG7QOlpYfGhLmQDUm8yy+brAEfXpD9GUwYyCKPOY84FdO3y2hgTZD+KBNq5zp5Et1xhqivWqZl/GHQKlUQubVsbDVZ2itQUFLeixmHzLY0VdRMcmjCbRtlP1rOjfM+ZEJO8Jbwvi+2WnZS4We3LuyZNhyKzH85N/zuJHRaLJfuNOEwxDYyFslArSJyCX+wlaEX0J45LekkQx/Ny0W6JJu6LVBreh/TRqojqaeXvDHZDiKe9l24aPu8ArlCnZ6FmdfpHYtuzSbWLJTFzc7cXk5Lr24AU7r2LvOhLnm3rx5Njs4
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7913e405-25c5-4c5a-7771-08dbef5d29e8
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2023 15:26:01.9768
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /ynuxeggzer14/o23rhqQHexc6oU8lmlYlBTydBxTaNU3KnvIO/iRmB42Q3iWTNdud6Fhivg3UgCSXZp39tVJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4228
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-27_13,2023-11-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 bulkscore=0
 mlxlogscore=999 adultscore=0 malwarescore=0 mlxscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311270105
X-Proofpoint-GUID: y205zTr_CIJy4S-Cgq0ts18Te55ZaTiq
X-Proofpoint-ORIG-GUID: y205zTr_CIJy4S-Cgq0ts18Te55ZaTiq

On Fri, Nov 24, 2023 at 11:28:46AM +1100, NeilBrown wrote:
> When there is layout state on a filesystem that is being "unlocked" that
> is now revoked, which involves closing the nfsd_file and releasing the
> vfs lease.
> 
> To avoid races, all users of ->ls_file - after the layout state has been
> successfully created - now need to take a counted reference under
> rcu_read_lock().  To support this, ->fence_client and
> nfsd4_cb_layout_fail() now take a second argument being the nfsd_file.
> 
> Signed-off-by: NeilBrown <neilb@suse.de>

Hi Neil, would you Cc: Christoph Hellwig <hch@lst.de> and Tom Haynes
<loghyr@gmail.com> to this patch next time you post this series?


> ---
>  fs/nfsd/blocklayout.c |  4 ++--
>  fs/nfsd/nfs4layouts.c | 38 +++++++++++++++++++++++++++-----------
>  fs/nfsd/nfs4state.c   | 28 +++++++++++++++++++++-------
>  fs/nfsd/pnfs.h        |  7 ++++++-
>  4 files changed, 56 insertions(+), 21 deletions(-)
> 
> diff --git a/fs/nfsd/blocklayout.c b/fs/nfsd/blocklayout.c
> index 46fd74d91ea9..3c040c81c77d 100644
> --- a/fs/nfsd/blocklayout.c
> +++ b/fs/nfsd/blocklayout.c
> @@ -328,10 +328,10 @@ nfsd4_scsi_proc_layoutcommit(struct inode *inode,
>  }
>  
>  static void
> -nfsd4_scsi_fence_client(struct nfs4_layout_stateid *ls)
> +nfsd4_scsi_fence_client(struct nfs4_layout_stateid *ls, struct nfsd_file *file)
>  {
>  	struct nfs4_client *clp = ls->ls_stid.sc_client;
> -	struct block_device *bdev = ls->ls_file->nf_file->f_path.mnt->mnt_sb->s_bdev;
> +	struct block_device *bdev = file->nf_file->f_path.mnt->mnt_sb->s_bdev;
>  
>  	bdev->bd_disk->fops->pr_ops->pr_preempt(bdev, NFSD_MDS_PR_KEY,
>  			nfsd4_scsi_pr_key(clp), 0, true);
> diff --git a/fs/nfsd/nfs4layouts.c b/fs/nfsd/nfs4layouts.c
> index 77656126ad2a..dbc52413ce57 100644
> --- a/fs/nfsd/nfs4layouts.c
> +++ b/fs/nfsd/nfs4layouts.c
> @@ -152,6 +152,18 @@ void nfsd4_setup_layout_type(struct svc_export *exp)
>  #endif
>  }
>  
> +void nfsd4_close_layout(struct nfs4_layout_stateid *ls)
> +{
> +	struct nfsd_file *fl = xchg(&ls->ls_file, NULL);
> +
> +	if (fl) {
> +		if (!nfsd4_layout_ops[ls->ls_layout_type]->disable_recalls)
> +			vfs_setlease(fl->nf_file, F_UNLCK, NULL,
> +				     (void **)&ls);
> +		nfsd_file_put(fl);
> +	}
> +}
> +
>  static void
>  nfsd4_free_layout_stateid(struct nfs4_stid *stid)
>  {
> @@ -169,9 +181,7 @@ nfsd4_free_layout_stateid(struct nfs4_stid *stid)
>  	list_del_init(&ls->ls_perfile);
>  	spin_unlock(&fp->fi_lock);
>  
> -	if (!nfsd4_layout_ops[ls->ls_layout_type]->disable_recalls)
> -		vfs_setlease(ls->ls_file->nf_file, F_UNLCK, NULL, (void **)&ls);
> -	nfsd_file_put(ls->ls_file);
> +	nfsd4_close_layout(ls);
>  
>  	if (ls->ls_recalled)
>  		atomic_dec(&ls->ls_stid.sc_file->fi_lo_recalls);
> @@ -605,7 +615,7 @@ nfsd4_return_all_file_layouts(struct nfs4_client *clp, struct nfs4_file *fp)
>  }
>  
>  static void
> -nfsd4_cb_layout_fail(struct nfs4_layout_stateid *ls)
> +nfsd4_cb_layout_fail(struct nfs4_layout_stateid *ls, struct nfsd_file *file)
>  {
>  	struct nfs4_client *clp = ls->ls_stid.sc_client;
>  	char addr_str[INET6_ADDRSTRLEN];
> @@ -627,7 +637,7 @@ nfsd4_cb_layout_fail(struct nfs4_layout_stateid *ls)
>  
>  	argv[0] = (char *)nfsd_recall_failed;
>  	argv[1] = addr_str;
> -	argv[2] = ls->ls_file->nf_file->f_path.mnt->mnt_sb->s_id;
> +	argv[2] = file->nf_file->f_path.mnt->mnt_sb->s_id;
>  	argv[3] = NULL;
>  
>  	error = call_usermodehelper(nfsd_recall_failed, argv, envp,
> @@ -657,6 +667,7 @@ nfsd4_cb_layout_done(struct nfsd4_callback *cb, struct rpc_task *task)
>  	struct nfsd_net *nn;
>  	ktime_t now, cutoff;
>  	const struct nfsd4_layout_ops *ops;
> +	struct nfsd_file *fl;
>  
>  	trace_nfsd_cb_layout_done(&ls->ls_stid.sc_stateid, task);
>  	switch (task->tk_status) {
> @@ -688,12 +699,17 @@ nfsd4_cb_layout_done(struct nfsd4_callback *cb, struct rpc_task *task)
>  		 * Unknown error or non-responding client, we'll need to fence.
>  		 */
>  		trace_nfsd_layout_recall_fail(&ls->ls_stid.sc_stateid);
> -
> -		ops = nfsd4_layout_ops[ls->ls_layout_type];
> -		if (ops->fence_client)
> -			ops->fence_client(ls);
> -		else
> -			nfsd4_cb_layout_fail(ls);
> +		rcu_read_lock();
> +		fl = nfsd_file_get(ls->ls_file);
> +		rcu_read_unlock();
> +		if (fl) {
> +			ops = nfsd4_layout_ops[ls->ls_layout_type];
> +			if (ops->fence_client)
> +				ops->fence_client(ls, fl);
> +			else
> +				nfsd4_cb_layout_fail(ls, fl);
> +			nfsd_file_put(fl);
> +		}
>  		return 1;
>  	case -NFS4ERR_NOMATCHING_LAYOUT:
>  		trace_nfsd_layout_recall_done(&ls->ls_stid.sc_stateid);
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index 3d85c88ec4d7..d82ca209eb96 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -1712,7 +1712,8 @@ void nfsd4_revoke_states(struct net *net, struct super_block *sb)
>  	unsigned int idhashval;
>  	unsigned int sc_types;
>  
> -	sc_types = NFS4_OPEN_STID | NFS4_LOCK_STID | NFS4_DELEG_STID;
> +	sc_types = (NFS4_OPEN_STID | NFS4_LOCK_STID |
> +		    NFS4_DELEG_STID | NFS4_LAYOUT_STID);
>  
>  	spin_lock(&nn->client_lock);
>  	for (idhashval = 0; idhashval < CLIENT_HASH_MASK; idhashval++) {
> @@ -1725,6 +1726,7 @@ void nfsd4_revoke_states(struct net *net, struct super_block *sb)
>  			if (stid) {
>  				struct nfs4_ol_stateid *stp;
>  				struct nfs4_delegation *dp;
> +				struct nfs4_layout_stateid *ls;
>  
>  				spin_unlock(&nn->client_lock);
>  				switch (stid->sc_type) {
> @@ -1780,6 +1782,10 @@ void nfsd4_revoke_states(struct net *net, struct super_block *sb)
>  					if (dp)
>  						revoke_delegation(dp);
>  					break;
> +				case NFS4_LAYOUT_STID:
> +					ls = layoutstateid(stid);
> +					nfsd4_close_layout(ls);
> +					break;
>  				}
>  				nfs4_put_stid(stid);
>  				spin_lock(&nn->client_lock);
> @@ -2859,17 +2865,25 @@ static int nfs4_show_layout(struct seq_file *s, struct nfs4_stid *st)
>  	struct nfsd_file *file;
>  
>  	ls = container_of(st, struct nfs4_layout_stateid, ls_stid);
> -	file = ls->ls_file;
> +	rcu_read_lock();
> +	file = nfsd_file_get(ls->ls_file);
> +	rcu_read_unlock();
>  
> -	seq_printf(s, "- ");
> +	seq_puts(s, "- ");
>  	nfs4_show_stateid(s, &st->sc_stateid);
> -	seq_printf(s, ": { type: layout, ");
> +	seq_puts(s, ": { type: layout");
>  
>  	/* XXX: What else would be useful? */
>  
> -	nfs4_show_superblock(s, file);
> -	seq_printf(s, ", ");
> -	nfs4_show_fname(s, file);
> +	if (file) {
> +		seq_puts(s, ", ");
> +		nfs4_show_superblock(s, file);
> +		seq_puts(s, ", ");
> +		nfs4_show_fname(s, file);
> +		nfsd_file_put(file);
> +	}
> +	if (st->sc_status & NFS4_STID_ADMIN_REVOKED)
> +		seq_puts(s, ", admin-revoked");
>  	seq_printf(s, " }\n");
>  
>  	return 0;
> diff --git a/fs/nfsd/pnfs.h b/fs/nfsd/pnfs.h
> index de1e0dfed06a..f2777577865e 100644
> --- a/fs/nfsd/pnfs.h
> +++ b/fs/nfsd/pnfs.h
> @@ -37,7 +37,8 @@ struct nfsd4_layout_ops {
>  	__be32 (*proc_layoutcommit)(struct inode *inode,
>  			struct nfsd4_layoutcommit *lcp);
>  
> -	void (*fence_client)(struct nfs4_layout_stateid *ls);
> +	void (*fence_client)(struct nfs4_layout_stateid *ls,
> +			     struct nfsd_file *file);
>  };
>  
>  extern const struct nfsd4_layout_ops *nfsd4_layout_ops[];
> @@ -72,6 +73,7 @@ void nfsd4_setup_layout_type(struct svc_export *exp);
>  void nfsd4_return_all_client_layouts(struct nfs4_client *);
>  void nfsd4_return_all_file_layouts(struct nfs4_client *clp,
>  		struct nfs4_file *fp);
> +void nfsd4_close_layout(struct nfs4_layout_stateid *ls);
>  int nfsd4_init_pnfs(void);
>  void nfsd4_exit_pnfs(void);
>  #else
> @@ -89,6 +91,9 @@ static inline void nfsd4_return_all_file_layouts(struct nfs4_client *clp,
>  		struct nfs4_file *fp)
>  {
>  }
> +static inline void nfsd4_close_layout(struct nfs4_layout_stateid *ls)
> +{
> +}
>  static inline void nfsd4_exit_pnfs(void)
>  {
>  }
> -- 
> 2.42.1
> 

-- 
Chuck Lever

