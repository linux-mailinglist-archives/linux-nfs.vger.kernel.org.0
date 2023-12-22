Return-Path: <linux-nfs+bounces-778-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 68A8F81CBA7
	for <lists+linux-nfs@lfdr.de>; Fri, 22 Dec 2023 16:03:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D36E11F269FF
	for <lists+linux-nfs@lfdr.de>; Fri, 22 Dec 2023 15:03:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8AA223752;
	Fri, 22 Dec 2023 15:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="d7aSAAKc";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="uZGSpJT4"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19E5D2374B
	for <linux-nfs@vger.kernel.org>; Fri, 22 Dec 2023 15:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BMDa3VU032481;
	Fri, 22 Dec 2023 15:01:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=t0GnCp0VemMsIrbXBdk/hNKZk64DdN96VGSljFh9HHo=;
 b=d7aSAAKc1V6AsTGc8zAlR4QQD2r6UVcMdLBlETpmXDmXymz30whxBGlqaC1YA/1BvOea
 LQCYKAQVTsd63/Ov84t5BLVq7jB9K8IRAInjO4KMsvV6mepjY7vmg2MBtoKWNe+pFPZ1
 kLT8SBu0njYW1hUoeGDp1CH2lRtA2zaXUAdzfrME0kZi0O2dG+EXYF+j0DzzHfvIT4hi
 9QbiwWt75Qh0GijiFRdjBusNlMnWOBe8ZsCHpEPEH5W+L2oqY1rY+tj2h7Ti0RHA6Y2O
 shVIQAQOtoWOedk0pwOsH0262pBuSx+mqiqHgZL0OQwbyc+lC4/riOJqAcAXwfjI2Mss 2A== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3v56pu8s5s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 Dec 2023 15:01:54 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3BMD1LFM000912;
	Fri, 22 Dec 2023 15:01:53 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3v12bdutuk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 Dec 2023 15:01:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n6QDduiNZeSCHkm5ecFtyRn/ib7s6s++5Om1ddmSge+UR/EKAVjo8uoMYdzHZuqPTmV4rhbbm6sSaNx+miAFEnqqBGtsg7Sh8/Hb0NADEtNU8FnABDLaMMuiN47CElLGvzf2F+TSUX0rUK1/qHnO7frylLFaHuavEgX1v7q3yXnjV6RFwnOfGjNwI5O80ggwTG6bJO+o6pUKOBo11tI+P/2+ks8Ov5Kih3VUfLa3Ur3nT4fJL62NNTJME046zZxG1xlWVO8ZCmD9/yXeC3GvdglAn+sX6hTMIFCIqbB1k3xjPyOr+OLXMZoQo3UwkHXSNFqN36nE2Uxe0WcKoyJD4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t0GnCp0VemMsIrbXBdk/hNKZk64DdN96VGSljFh9HHo=;
 b=GYEbC3ymVeXab7OXiCWstqeQsQDlKmN5r+5k2WZ9bJYaumqY3kvhQLVYK/02jox3xZt+hHJoiLBCAUVfHefBvc/76kDGd+jNwt3aCeQU3P5AXL1Po/FQwVFdhtZTRatXRhXb1yT5HZbQ752IgO0HetONiXIp7rxkXjsgTktYRmTefIACyuRdYc6jI/1zGUPF7nFZz3boUNmhPkwkjJRgnc2kphp2Z0OP8x7gNX9s/3NWCPdtuLqERZjpTYYnP0gxj3E7RknqVmiatomtqBrtfTKy2MdSljNaV38GV7YNyMN2lfQtblbYNFSFi/B9PSVG+JCOVSVA6hO1BXZI5nBTIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t0GnCp0VemMsIrbXBdk/hNKZk64DdN96VGSljFh9HHo=;
 b=uZGSpJT42figs7Od5UhJxuCcaBdvbPlbrBbUOFEItOPaG1EOzPGkvUjZYj+M0ozoRZ1Wezj/V+mKA8GzriXjVKgk7OhMCOUXlu5RHoHuLeEG4/srP7Pj0eIKe0/4BNizKiEksTPejXoxutO65iy/VVwUNuqdcA1Qv3hq9Xekjn0=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH7PR10MB7108.namprd10.prod.outlook.com (2603:10b6:510:27e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.21; Fri, 22 Dec
 2023 15:01:50 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c%4]) with mapi id 15.20.7113.019; Fri, 22 Dec 2023
 15:01:50 +0000
Date: Fri, 22 Dec 2023 10:01:48 -0500
From: Chuck Lever <chuck.lever@oracle.com>
To: NeilBrown <neilb@suse.de>
Cc: Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org,
        Olga Kornievskaia <kolga@netapp.com>, Dai Ngo <Dai.Ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>
Subject: Re: [PATCH 11/11] nfsd: allow layout state to be admin-revoked.
Message-ID: <ZYWk3KBmZs28QQKY@tissot.1015granger.net>
References: <20231124002925.1816-1-neilb@suse.de>
 <20231124002925.1816-12-neilb@suse.de>
 <ZWS1B2qGiu2SqARc@tissot.1015granger.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZWS1B2qGiu2SqARc@tissot.1015granger.net>
X-ClientProxiedBy: CH5PR04CA0023.namprd04.prod.outlook.com
 (2603:10b6:610:1f4::23) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|PH7PR10MB7108:EE_
X-MS-Office365-Filtering-Correlation-Id: 53fbafd8-8c64-4229-cbbd-08dc02feed1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	qahEHEGZn3s640ghWZpMz24PcpZ0RtGv8rmSdm0zA3y00YKnQ5oe19kKR/aKOIo0k7cjS/R61zEC3Cz1QI7Lj/cHqgWJb+2lWrAXwA2lkwO3TkpnS7PMObWXudAg7ywXo22oL1MO4inWFWErijHxFMqhnUiw2NWKh91WppeH36FhDzFjkZ3kqSuX5i4G/O0t66HdfR+BmaqHYPy7bFDrNDUs18w7I45FM972WyholCeB1zCGw6zIoFygeFIgciT+mVpNjE1up0duF0rVnZB7rCT2SmvXEp6/HsfeV8X5FSTSFnsRSueo0HK4BzAkvGUimLoT8dLgbt0pccm5mIpq5TZupasAJJThvjLEWHrPT7ZJbEbT3A85Qfa4+DPOwsGFNHcc82O8sZsnWce3JQVYu8/55yuZkkdbQU4sle6sp651iejnoBeCd67NpyOJyZXJtNqg4zjUnXQn4686SEMdXTicN8y67GQoMrcfxQNgHrlJZCvme25ibTHr0YnGYfNZWzZrzKiPqTPXgWzh5JOpH87vcPkKb+p4ZqEo+qL7LnusxprQRFjcstEiC/YBTn2HCJPIuIpvQfTu8OwChUYVNcQo2joaMVKERwEYDfvQ9JA=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(366004)(346002)(39860400002)(376002)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(4326008)(8676002)(8936002)(66946007)(66556008)(66476007)(6916009)(316002)(54906003)(2906002)(86362001)(41300700001)(38100700002)(44832011)(5660300002)(6486002)(26005)(83380400001)(478600001)(6506007)(9686003)(6512007)(21314003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?WXDqy/JZmDRejRblFwkgzAZITkUH3hEkOojpegybohCSHf8/Ufl95sjbQzTX?=
 =?us-ascii?Q?KelFV7FiwXyv/UNq3SZzHHc7e+kUZWBAPnrzyNGkG8DEflcVuEMETm7LG97v?=
 =?us-ascii?Q?EMUHrZrVTvPz3v6cDkg3Nfy5kuXeuKkJaRF0drm1yShZzTiK5zMlcHFXfz67?=
 =?us-ascii?Q?RYUk9mXuaJ1dqNsN1oqnz7P2pW6A7PFiNNxeBdFE8leBULFUNL8Mc6ExZ/md?=
 =?us-ascii?Q?fKJaxnYdj7VgQ3GzcPI02GuDs6/9dSYIAc6lsjgcRIbTQ+fgItLDUL3J6y2r?=
 =?us-ascii?Q?ysLtMPfigytjGggTV3L0gqwV5/ITNYw7YRSuFU85WJiBKsa+FPdTmvK11b3H?=
 =?us-ascii?Q?uj4IOycrJanapQhZyRm6/6pkTqyR/8qDnZQ/xGkcLOVTMij0hQmqbXum6sdZ?=
 =?us-ascii?Q?V1dkqp2g72v88tbBgiKv/u/vXbyFyC7zpLsNJFR55/bBfjQBAQ7Xc+iyLQ4G?=
 =?us-ascii?Q?rmW6+Y+hO7gqhhnb0rtwlP0eMDhWq4GeH8BumYFvqQREfOJGR7mKXVW2cXYk?=
 =?us-ascii?Q?pObyKgIIuYcSj9jED2pZt0nhYNa0pg+CMyz/NCpfBGsBoIPfZc518qxfapdo?=
 =?us-ascii?Q?uPtPG2zsTEDXLoTL4+ORByhWWowk9nIta1e9x9WackSlmxBZIlmd0gkwmuWX?=
 =?us-ascii?Q?QDtYw0IuRc2XM0DO5w04cP5agoj80MNjC0G4tSSCccI56M9dGiUGFjfMR4NX?=
 =?us-ascii?Q?ZFJ12rI9L88aJarYiGo2E6SR6qWHa9W4Og6PztCBlqu1Arj0/D7Xz1IOZvVr?=
 =?us-ascii?Q?eERek3AmzPfyuKB4CmoxsQumr4ZUDy0jE6J1v0MYYFkv8cOvXe2cYeN35HN6?=
 =?us-ascii?Q?3mX95QtEwg42cHo6NZGIIDeyXdfbhymHI2AVxsTAt8ZTgTyxD9lzRgCI33Gr?=
 =?us-ascii?Q?WMd/XE9kcundFCYwD1tXcV9ujDShHKon9v2dg5eBtAUbuUXmzjYW5PLCK1yN?=
 =?us-ascii?Q?KV7h2nmrl8mZaaR0eP53a3a3/wdHx2yF6dtvEGq7lHpjGHpCadkwmJUOCIzP?=
 =?us-ascii?Q?vpfVUxabr6EJ8Rk6FbztdGi4dOptjoqu01jt0MSwHcu9b1f010IGa8zKWRRq?=
 =?us-ascii?Q?G5s2ayNUXtQUb3QEQF3vQZ/We22cVR11rQUfie6TUPZqoz7MqsfNvv3Pkw4n?=
 =?us-ascii?Q?iCrzMNZR+2vY//1mxCDU4yj+ckn94ulShw9XffSqnT+97CjEnoNIeOVtH6Xq?=
 =?us-ascii?Q?Qq3BgkmezCggkzomeGKslFWzXf8AiDq9EYZeSsmOQKdGqWcShucrKAk5WNuq?=
 =?us-ascii?Q?89Ve5+xVxBMtaHsRkfykFb53zjDM77Es+r2gXBdd1cSOa2NIgvlwI4AeOyJ8?=
 =?us-ascii?Q?xTx5pzUF/Bxuytu7vob23GKn4i6doKohZDL9iWuwuh32FKl7Fw1R0uWU7Xr+?=
 =?us-ascii?Q?u2QHjne2OCuUbpBGbXf743fGsHJRgv5XqlwDDDQL2eHJlxnRgf2MR6qBPShg?=
 =?us-ascii?Q?8+Ua774D0GnO9r30ow26ibJRJ/3rv19dy9s6gPCvi/1mc8kEJ7ktjBMNZoG1?=
 =?us-ascii?Q?ljJxOiauGsZdRt6pYtzAeK2ZKCPhWK4ExhaO+NA9IRRyCwzZgVe8cBu4iBaT?=
 =?us-ascii?Q?u+ExiGrzZ+g1bMPUSyIO1fO3dWPTLWRotIWTpp9xO4dLOT4PBVWx+Ur/dgMH?=
 =?us-ascii?Q?5A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	0j39tYvlM1cwWHW7lGZkjf4C5sj8k9nBYZPt2AsjdHWYgQb8EinFScSnOoCNgjablbef0/Rw4Inw0C2DbxIcq7BfAgTu50iIgeKj4m4HEYPIWInot/J7qoOLRJ6er3WmHDmrOKMQ1e3N3WBeV2XjUpUkaHac3dOjUP1rsTW2GOmzs12FN93lQwLOuoFVD+7am2WRpcbFqp/zvzgkGcOpY3LdiQxtbAa4BRQSFz/s/MdyG4sTjNx8sKbhXVwiBqg9off5JBH4EgGPANo6C2oLXffVmWP5lM9mououl2Ot2dOQ/flZb0mlsL8gj+yXtiWpuor04COkpv/0BUGUJgLtUhv0ArvFxU4H9YAq3/dT/oBnUkY5U97eGzAqZ4TvU95MeVZ0Hmvp2uEP1MV/eXAgrzDCHVQdwtqAEOuAfkVwiD4mP7EyM6Z3hs8DssYRiOJYSQVZ98amfzW59tOEZWtY3fzwRslRuInX7yO/n3AVYUOy7y6vI8XU0m0vRSyVs5XzqxFqVP697zDb844YIH5cBHWQYA2+QNGHo2NtVlb3HwWi3AGq5leRvX6iJrcQ+JQfRi/EnijrU+d94e8C6VCDS3gNvcAUYAbpqQbkrOE8UMQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53fbafd8-8c64-4229-cbbd-08dc02feed1e
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Dec 2023 15:01:50.4074
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cLQhJQkdSRZu+o/I7P0jhVybYEFSCBrcW/RW02IAAil3e0q/nJmU+4RWmWvHBF8aMdcbA9VdkWyOX/3UTVjT1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7108
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-22_08,2023-12-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 malwarescore=0 phishscore=0 mlxscore=0 bulkscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312220110
X-Proofpoint-ORIG-GUID: qY_k_R5E_IbSCa746cl1Zzh39gC45odB
X-Proofpoint-GUID: qY_k_R5E_IbSCa746cl1Zzh39gC45odB

On Mon, Nov 27, 2023 at 10:25:59AM -0500, Chuck Lever wrote:
> On Fri, Nov 24, 2023 at 11:28:46AM +1100, NeilBrown wrote:
> > When there is layout state on a filesystem that is being "unlocked" that
> > is now revoked, which involves closing the nfsd_file and releasing the
> > vfs lease.
> > 
> > To avoid races, all users of ->ls_file - after the layout state has been
> > successfully created - now need to take a counted reference under
> > rcu_read_lock().  To support this, ->fence_client and
> > nfsd4_cb_layout_fail() now take a second argument being the nfsd_file.
> > 
> > Signed-off-by: NeilBrown <neilb@suse.de>
> 
> Hi Neil, would you Cc: Christoph Hellwig <hch@lst.de> and Tom Haynes
> <loghyr@gmail.com> to this patch next time you post this series?

Re-visiting. Did you send out a v5 of this series and I missed it?


> > ---
> >  fs/nfsd/blocklayout.c |  4 ++--
> >  fs/nfsd/nfs4layouts.c | 38 +++++++++++++++++++++++++++-----------
> >  fs/nfsd/nfs4state.c   | 28 +++++++++++++++++++++-------
> >  fs/nfsd/pnfs.h        |  7 ++++++-
> >  4 files changed, 56 insertions(+), 21 deletions(-)
> > 
> > diff --git a/fs/nfsd/blocklayout.c b/fs/nfsd/blocklayout.c
> > index 46fd74d91ea9..3c040c81c77d 100644
> > --- a/fs/nfsd/blocklayout.c
> > +++ b/fs/nfsd/blocklayout.c
> > @@ -328,10 +328,10 @@ nfsd4_scsi_proc_layoutcommit(struct inode *inode,
> >  }
> >  
> >  static void
> > -nfsd4_scsi_fence_client(struct nfs4_layout_stateid *ls)
> > +nfsd4_scsi_fence_client(struct nfs4_layout_stateid *ls, struct nfsd_file *file)
> >  {
> >  	struct nfs4_client *clp = ls->ls_stid.sc_client;
> > -	struct block_device *bdev = ls->ls_file->nf_file->f_path.mnt->mnt_sb->s_bdev;
> > +	struct block_device *bdev = file->nf_file->f_path.mnt->mnt_sb->s_bdev;
> >  
> >  	bdev->bd_disk->fops->pr_ops->pr_preempt(bdev, NFSD_MDS_PR_KEY,
> >  			nfsd4_scsi_pr_key(clp), 0, true);
> > diff --git a/fs/nfsd/nfs4layouts.c b/fs/nfsd/nfs4layouts.c
> > index 77656126ad2a..dbc52413ce57 100644
> > --- a/fs/nfsd/nfs4layouts.c
> > +++ b/fs/nfsd/nfs4layouts.c
> > @@ -152,6 +152,18 @@ void nfsd4_setup_layout_type(struct svc_export *exp)
> >  #endif
> >  }
> >  
> > +void nfsd4_close_layout(struct nfs4_layout_stateid *ls)
> > +{
> > +	struct nfsd_file *fl = xchg(&ls->ls_file, NULL);
> > +
> > +	if (fl) {
> > +		if (!nfsd4_layout_ops[ls->ls_layout_type]->disable_recalls)
> > +			vfs_setlease(fl->nf_file, F_UNLCK, NULL,
> > +				     (void **)&ls);
> > +		nfsd_file_put(fl);
> > +	}
> > +}
> > +
> >  static void
> >  nfsd4_free_layout_stateid(struct nfs4_stid *stid)
> >  {
> > @@ -169,9 +181,7 @@ nfsd4_free_layout_stateid(struct nfs4_stid *stid)
> >  	list_del_init(&ls->ls_perfile);
> >  	spin_unlock(&fp->fi_lock);
> >  
> > -	if (!nfsd4_layout_ops[ls->ls_layout_type]->disable_recalls)
> > -		vfs_setlease(ls->ls_file->nf_file, F_UNLCK, NULL, (void **)&ls);
> > -	nfsd_file_put(ls->ls_file);
> > +	nfsd4_close_layout(ls);
> >  
> >  	if (ls->ls_recalled)
> >  		atomic_dec(&ls->ls_stid.sc_file->fi_lo_recalls);
> > @@ -605,7 +615,7 @@ nfsd4_return_all_file_layouts(struct nfs4_client *clp, struct nfs4_file *fp)
> >  }
> >  
> >  static void
> > -nfsd4_cb_layout_fail(struct nfs4_layout_stateid *ls)
> > +nfsd4_cb_layout_fail(struct nfs4_layout_stateid *ls, struct nfsd_file *file)
> >  {
> >  	struct nfs4_client *clp = ls->ls_stid.sc_client;
> >  	char addr_str[INET6_ADDRSTRLEN];
> > @@ -627,7 +637,7 @@ nfsd4_cb_layout_fail(struct nfs4_layout_stateid *ls)
> >  
> >  	argv[0] = (char *)nfsd_recall_failed;
> >  	argv[1] = addr_str;
> > -	argv[2] = ls->ls_file->nf_file->f_path.mnt->mnt_sb->s_id;
> > +	argv[2] = file->nf_file->f_path.mnt->mnt_sb->s_id;
> >  	argv[3] = NULL;
> >  
> >  	error = call_usermodehelper(nfsd_recall_failed, argv, envp,
> > @@ -657,6 +667,7 @@ nfsd4_cb_layout_done(struct nfsd4_callback *cb, struct rpc_task *task)
> >  	struct nfsd_net *nn;
> >  	ktime_t now, cutoff;
> >  	const struct nfsd4_layout_ops *ops;
> > +	struct nfsd_file *fl;
> >  
> >  	trace_nfsd_cb_layout_done(&ls->ls_stid.sc_stateid, task);
> >  	switch (task->tk_status) {
> > @@ -688,12 +699,17 @@ nfsd4_cb_layout_done(struct nfsd4_callback *cb, struct rpc_task *task)
> >  		 * Unknown error or non-responding client, we'll need to fence.
> >  		 */
> >  		trace_nfsd_layout_recall_fail(&ls->ls_stid.sc_stateid);
> > -
> > -		ops = nfsd4_layout_ops[ls->ls_layout_type];
> > -		if (ops->fence_client)
> > -			ops->fence_client(ls);
> > -		else
> > -			nfsd4_cb_layout_fail(ls);
> > +		rcu_read_lock();
> > +		fl = nfsd_file_get(ls->ls_file);
> > +		rcu_read_unlock();
> > +		if (fl) {
> > +			ops = nfsd4_layout_ops[ls->ls_layout_type];
> > +			if (ops->fence_client)
> > +				ops->fence_client(ls, fl);
> > +			else
> > +				nfsd4_cb_layout_fail(ls, fl);
> > +			nfsd_file_put(fl);
> > +		}
> >  		return 1;
> >  	case -NFS4ERR_NOMATCHING_LAYOUT:
> >  		trace_nfsd_layout_recall_done(&ls->ls_stid.sc_stateid);
> > diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> > index 3d85c88ec4d7..d82ca209eb96 100644
> > --- a/fs/nfsd/nfs4state.c
> > +++ b/fs/nfsd/nfs4state.c
> > @@ -1712,7 +1712,8 @@ void nfsd4_revoke_states(struct net *net, struct super_block *sb)
> >  	unsigned int idhashval;
> >  	unsigned int sc_types;
> >  
> > -	sc_types = NFS4_OPEN_STID | NFS4_LOCK_STID | NFS4_DELEG_STID;
> > +	sc_types = (NFS4_OPEN_STID | NFS4_LOCK_STID |
> > +		    NFS4_DELEG_STID | NFS4_LAYOUT_STID);
> >  
> >  	spin_lock(&nn->client_lock);
> >  	for (idhashval = 0; idhashval < CLIENT_HASH_MASK; idhashval++) {
> > @@ -1725,6 +1726,7 @@ void nfsd4_revoke_states(struct net *net, struct super_block *sb)
> >  			if (stid) {
> >  				struct nfs4_ol_stateid *stp;
> >  				struct nfs4_delegation *dp;
> > +				struct nfs4_layout_stateid *ls;
> >  
> >  				spin_unlock(&nn->client_lock);
> >  				switch (stid->sc_type) {
> > @@ -1780,6 +1782,10 @@ void nfsd4_revoke_states(struct net *net, struct super_block *sb)
> >  					if (dp)
> >  						revoke_delegation(dp);
> >  					break;
> > +				case NFS4_LAYOUT_STID:
> > +					ls = layoutstateid(stid);
> > +					nfsd4_close_layout(ls);
> > +					break;
> >  				}
> >  				nfs4_put_stid(stid);
> >  				spin_lock(&nn->client_lock);
> > @@ -2859,17 +2865,25 @@ static int nfs4_show_layout(struct seq_file *s, struct nfs4_stid *st)
> >  	struct nfsd_file *file;
> >  
> >  	ls = container_of(st, struct nfs4_layout_stateid, ls_stid);
> > -	file = ls->ls_file;
> > +	rcu_read_lock();
> > +	file = nfsd_file_get(ls->ls_file);
> > +	rcu_read_unlock();
> >  
> > -	seq_printf(s, "- ");
> > +	seq_puts(s, "- ");
> >  	nfs4_show_stateid(s, &st->sc_stateid);
> > -	seq_printf(s, ": { type: layout, ");
> > +	seq_puts(s, ": { type: layout");
> >  
> >  	/* XXX: What else would be useful? */
> >  
> > -	nfs4_show_superblock(s, file);
> > -	seq_printf(s, ", ");
> > -	nfs4_show_fname(s, file);
> > +	if (file) {
> > +		seq_puts(s, ", ");
> > +		nfs4_show_superblock(s, file);
> > +		seq_puts(s, ", ");
> > +		nfs4_show_fname(s, file);
> > +		nfsd_file_put(file);
> > +	}
> > +	if (st->sc_status & NFS4_STID_ADMIN_REVOKED)
> > +		seq_puts(s, ", admin-revoked");
> >  	seq_printf(s, " }\n");
> >  
> >  	return 0;
> > diff --git a/fs/nfsd/pnfs.h b/fs/nfsd/pnfs.h
> > index de1e0dfed06a..f2777577865e 100644
> > --- a/fs/nfsd/pnfs.h
> > +++ b/fs/nfsd/pnfs.h
> > @@ -37,7 +37,8 @@ struct nfsd4_layout_ops {
> >  	__be32 (*proc_layoutcommit)(struct inode *inode,
> >  			struct nfsd4_layoutcommit *lcp);
> >  
> > -	void (*fence_client)(struct nfs4_layout_stateid *ls);
> > +	void (*fence_client)(struct nfs4_layout_stateid *ls,
> > +			     struct nfsd_file *file);
> >  };
> >  
> >  extern const struct nfsd4_layout_ops *nfsd4_layout_ops[];
> > @@ -72,6 +73,7 @@ void nfsd4_setup_layout_type(struct svc_export *exp);
> >  void nfsd4_return_all_client_layouts(struct nfs4_client *);
> >  void nfsd4_return_all_file_layouts(struct nfs4_client *clp,
> >  		struct nfs4_file *fp);
> > +void nfsd4_close_layout(struct nfs4_layout_stateid *ls);
> >  int nfsd4_init_pnfs(void);
> >  void nfsd4_exit_pnfs(void);
> >  #else
> > @@ -89,6 +91,9 @@ static inline void nfsd4_return_all_file_layouts(struct nfs4_client *clp,
> >  		struct nfs4_file *fp)
> >  {
> >  }
> > +static inline void nfsd4_close_layout(struct nfs4_layout_stateid *ls)
> > +{
> > +}
> >  static inline void nfsd4_exit_pnfs(void)
> >  {
> >  }
> > -- 
> > 2.42.1
> > 
> 
> -- 
> Chuck Lever
> 

-- 
Chuck Lever

