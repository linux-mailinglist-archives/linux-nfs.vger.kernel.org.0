Return-Path: <linux-nfs+bounces-652-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 852C8815204
	for <lists+linux-nfs@lfdr.de>; Fri, 15 Dec 2023 22:44:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 109821F24634
	for <lists+linux-nfs@lfdr.de>; Fri, 15 Dec 2023 21:44:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F6B847F7C;
	Fri, 15 Dec 2023 21:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="V9q5CIU0";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="CdaiXiMz"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEDDC47F66
	for <linux-nfs@vger.kernel.org>; Fri, 15 Dec 2023 21:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BFK7uC1031560;
	Fri, 15 Dec 2023 21:41:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=91zYQiSsWtghmFbH0bd5KjbxkZy/t7cBE4yXVNNKMc8=;
 b=V9q5CIU0YosgCxQlRUEmLYseiwbFbtao5ASKXOXa3dKSrCeNyGFz2ngUPea13s5xAo6f
 CeUuvn8A1cW3fYECENZg8lBvzkWEU+Q92t1mve+bfpcGFK0uop52hnFCXBGz9HBCey2P
 0ntGQ9K88JI4eZOC9ndxxt90tkUviEnk08hJNMR4HJMVxV/DdUzuZwLWy5Rn5koOdL4V
 CLJ3WED3Q+D3LitWlZkxo3RhqfaiZbacYJMr7lUoIk759SNGtnv/lHTINGya+8SV9lTJ
 laDLog1UCeNQ27az1bCTrRdQ7fDHy9PCkioARzgH/mZaZP7mKfUuIuP4e+75yjEIM2SV Pg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uwgn3vgj1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Dec 2023 21:41:52 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3BFK4VcR039607;
	Fri, 15 Dec 2023 21:41:51 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2040.outbound.protection.outlook.com [104.47.73.40])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3uvepcduv1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Dec 2023 21:41:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iOq5Ex6Q0mGGIple6yAEgDlpdn6zL5f14Vaj37fkHxPXBhvs3yhOrLR9DNLHVjvkukRrQ6MqkJdnRZVn059/4/imPLLjUH9I0zJCaZFwTdCt65ywl4SQW6KzygPhxKb9arIC7ksO3KVrGE3Bf5f5XHYI5GkbkkFMMdPkYgAAxmuKh/G0cOx5X2FdlWUqV3XixPma8lxq9/eQwLGgHj+yeCpM9jNoxzgsp96/5AjWU8ryjyHcTPlaJV3ItGlfp5NDrnzaoc4w1YSbQJzuXndHZqYMvcIOjI57s9zvV2rIecAyEvypSexBBD0BSQ1o7C7sDT5myQZkS5VwiySeB9WS8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=91zYQiSsWtghmFbH0bd5KjbxkZy/t7cBE4yXVNNKMc8=;
 b=RCGr5X1UjFYGBPlKhf8o/QEXxxB4+Q9vK85Jx7nGfr2hIGCwmB5FQkrR/C2wLcb2hW2baqPeA0vJwKm1mpfM/l6usxnvEnHi5vDS5YisnetIrQenL2r5/vRJD93CRBqcP0wRZZ6hO+htHO/fxlFJvKq1V/+TNKsbiSzSXPYR6mCMSVuYCM5BvoHLvyh5NS8grxUkqVMOiC5VAguCsMLws/Lf12dMoNtPPuVbTkMOHJ73RmpxpPNE5pMtrCnUFJVk3nZJvGVpSz42msHQTxvFM0qsK7I4Tcd/UFqUklFTdJcKJvtw8U5DyfbszvzS2GuyiVFyCY0sYPDfP+3a39jVfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=91zYQiSsWtghmFbH0bd5KjbxkZy/t7cBE4yXVNNKMc8=;
 b=CdaiXiMzJIiHW9IrrOhvcflJLH/Tc67UHDYiDlq4yzTdVMX7z8QuecZeUCF0iiqiLbZk7kWuHi1H5Sz6i2xkrc2AznwW9y8TGwu3KwmNn/OJkO2IYyvnqlW7unH0FQtEDQOXvHlhkZBhsrQFi1qA4/W3dw6nibrA0uBybiNe+B8=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH7PR10MB7802.namprd10.prod.outlook.com (2603:10b6:510:30c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.32; Fri, 15 Dec
 2023 21:41:49 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c%4]) with mapi id 15.20.7091.032; Fri, 15 Dec 2023
 21:41:49 +0000
Date: Fri, 15 Dec 2023 16:41:46 -0500
From: Chuck Lever <chuck.lever@oracle.com>
To: dai.ngo@oracle.com
Cc: jlayton@kernel.org, linux-nfs@vger.kernel.org, linux-nfs@stwm.de
Subject: Re: [PATCH 3/3] NFSD: Fix server reboot hang problem when callback
 workqueue is stuck
Message-ID: <ZXzIGmhDZp7v87aZ@tissot.1015granger.net>
References: <1702667703-17978-1-git-send-email-dai.ngo@oracle.com>
 <1702667703-17978-4-git-send-email-dai.ngo@oracle.com>
 <ZXyvCnEuV9L18JSS@tissot.1015granger.net>
 <195ba461-0908-4690-85a9-a9d12ffbad90@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <195ba461-0908-4690-85a9-a9d12ffbad90@oracle.com>
X-ClientProxiedBy: CH3P221CA0029.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:610:1e7::24) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|PH7PR10MB7802:EE_
X-MS-Office365-Filtering-Correlation-Id: fd6cf5e0-40bd-4e47-f32c-08dbfdb6a4ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	DahiprT8EdMWRLV6drnyWVcdBPLLpuh9c87N4ahk77Q/f1wgy9CVkKFehqy/qjseL8COcqe+t753rwWi9HcIzq5FS0VKXKuaGSW99adkPLkwnSSdU1QwDIb7sARhzacYQqcWne0ifOvNmexQfE4i0v8TGY7BXuyNgh+7dZuCXy/f/Jv0NyZ+PhjwALghPCZuxz/L20HxsvQsqTTwuFMoAwCKRb1QwF8fKRqB/mpJ7mxVCjd8DCL0kljfNbkHOTyf4yX6K2QsaZxICEBrcoO5P8hap8ZF7czxphUK+oRALZSsPwUcwV5Uhi9C0iJan3j6YndsTRfBl+Bz0+i6IlTBZQUxPicMoY4lYEQi2ebxUBtQsKojv+0doVsM2UgnQAPy4KsJldgDULYQkUe14FZ4+7BIigruDpwHsQaZPG/gKc0GZ+EYMIyY52z6IomcrWQ5yL7k3aYn0aGJ3CFhzr5+5LLy2iswMN6+YLcED8YN5N2nThRzPXLHJR9BN9NSeVsDuPGT6FvTR+WuH3f1e3YtYON9gNKVT2NKb0tDzaQAK74322O89shJdU6tk1hg1qOm
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(346002)(136003)(39860400002)(376002)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(6636002)(316002)(86362001)(38100700002)(26005)(83380400001)(53546011)(478600001)(6486002)(2906002)(66556008)(66476007)(66946007)(9686003)(6666004)(6512007)(6506007)(5660300002)(8936002)(8676002)(4326008)(41300700001)(44832011)(34206002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?3K0uBS1FC4z3VKPjnTVXhApvl+aOQUzm+1mODWnu7pmzgMyZ28r4N8MaE8Tk?=
 =?us-ascii?Q?OTNYpqlOxLkhJy1EodcvPky7lWUAYEWdxmLIO2mRit8NunvIUiVIyC3YeDXb?=
 =?us-ascii?Q?h+hsAKTpaNHRv9rPCRF5AhTOo77byvEk7hF7emhtEToKWwH3x7NkJGinteDc?=
 =?us-ascii?Q?C2GGg6qnihw5O4DO2yKamrNFGU0k/v4sRG8w2bl3DVvWOZnmzbNtnhW9ZrMK?=
 =?us-ascii?Q?MHqM56YszxWP6BmLApd4lenHPHZDpW2rNTzGZqKctsOgTcUOHiOJqaCMu7F8?=
 =?us-ascii?Q?SG7MuqI+ms1dYxySEtq8EU3uRZD//jJRm9KRrVTOq73Iaws3QMb8kHCtcwm6?=
 =?us-ascii?Q?QIh6yt3p7xNq64C64gZQiopoZXi2R/jqo1T/tdKEY44xNCEUgsBairn2DsYE?=
 =?us-ascii?Q?SFBC9sLHzRkRPplMorqET/PW43+8ZEd3iOTZUpwM63aO/sUoLHIUMEGn5Dzw?=
 =?us-ascii?Q?IgL8t+jA04PJpHn7gLD2I0XrTU67GR4JvULmV/fkx8J1v509iolzGF7i4aWp?=
 =?us-ascii?Q?+DhQWKC3ZDhbrgEgogh9WVhJQHo3jyejsDkKhQlbsYJVAPf2g22LlNMzB1e9?=
 =?us-ascii?Q?C8DLa+gTPqdUpqjhIcI0J2ZZXv8kLYxvMlofQYvyYKbhxWLcI+53Slm3sQQC?=
 =?us-ascii?Q?xQZLHBWWt4DElzmIcmGA7X67WyKtwQbWpU/QSagd96wOkEk28vAJ3/XhoETx?=
 =?us-ascii?Q?Kjqpi0wY18wK9jEP8PRFPUU3+xBOkQnLtKs9NbeiXWbO/lxrOEOluaMUFj2k?=
 =?us-ascii?Q?HjkLDnUSsRDk+08sDCH0q49tXVUVQuuZ77+R7duaE4CB95oEXUUsl0LECf7N?=
 =?us-ascii?Q?id2+qtT08hJZdYfNsxDpVwEv35JmaJWmbK3nPHyeMZy7LJMEYhmqgoylHLu0?=
 =?us-ascii?Q?7MWRht/LUB26SHvoIR9+6Fm1l//RDtgy7SJ8EyAiaT6NSjAVbFp8m9b/RV2o?=
 =?us-ascii?Q?5KDpHUSgTWY7poXYTxc0nZ39cKQi5cZAc8VrmOguQ9purhj0BxL9KmpRKEzl?=
 =?us-ascii?Q?ev9AHUyy0Ntb0HilyZYzCKHsb+CwZjo65nV1B7dxQD0kV4/pmWHRW6T8ewc2?=
 =?us-ascii?Q?05fC8WjQuXZceppn4I+3i3UsJWThFo1kO1e3ba5zdWXDr7K5oZE6dMHhfNrB?=
 =?us-ascii?Q?TWOzqamNjz8cAdjUboxwx7gSY5elO2uynVnGgbzbnK247BjSbTYtd8dK1R2a?=
 =?us-ascii?Q?KNm3jtw9DWbs3EBtExh2pxqmFUAuMMEm+AgsnOrvnAO4nc5iBV5edJDcDbJ4?=
 =?us-ascii?Q?MwZn/jDMvGcAN5KR3Dhqa24bHYUFjGvpH1UPRQB9xlXIjLwrGC4cwNnXGxA2?=
 =?us-ascii?Q?VzpEKqMWkoq/CH8Fn8QZciMDw+0RjX24QCLZ7eNnqgfkaYCW47Zxk0UZ7rXr?=
 =?us-ascii?Q?bd2L1+FJgxSFB22R05lS6r1eC5+/H8P8gnn+TfFvUtvxiWpienvqFUFgedbp?=
 =?us-ascii?Q?SweYO63+A0Jk8H7gkdNllxbRqfODcJ7hlk3lh5bh+/CUvOWZ8gXuvIQBberH?=
 =?us-ascii?Q?qUeUusEOPKFtOAUU3hnMrY6UD6e/rLjPXk1Yqc+HfFBRaBaZ8u47J9QWYu4x?=
 =?us-ascii?Q?2BFxdjUjSgWVJrU4paewby6kJ3Z6IX97j2lEevt6erqV1iHqH9IOseQj6ei7?=
 =?us-ascii?Q?kg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	pdL7e7V9yMiNGI6JjvnSzD1d93z13hXCmAzrcOqFYSauvlmutGvBW518Ducpv9mVzJUvqj/clsJ0gPcvYet2PROB3+aI27LgX0BlXhTobLA+h9rHCA/7s70fK9QTsGAuB5CAw+rZCY2Hq4CQF8tMGcUBDFWn3AKUnVNFLg46qj6G9OUXIri7NaFngtaSH4TmnvYF88SZM/zrF3KmRgFGT7Fp2NCr/dN5JworEJGeo+xtd0qJ39bFK9Y/rOn4dihEmshd8j1QZYxV6nsIxNFwyuVcLpmXYY+QZnsOhrz+WaxzfEt+UPubC6oiQnJnigBBDqv2atkwH5LAcI8+pA6iXqgKJTmtu98rblAdBxkOPyKEoXa/2Q1wbPVuDMOGSiMzqdsLpWEvLBaAkalOgzF1hXUzS+OTIus+sDzhFK8ZUNAN2cwQJu0tJQeOHaYFiik8Dyi+l3Nkp+kBYI91ZhON+wHy5bK8RPxlROPPtxqAYJg8oMXEU/XeObJsWh/S70ihtV9vqZcE+4dLXEzi8UnB3JetfU18RD633anDXANALtbm1SPm6vqMFt/apkFAgXNLbkY/wcprjSmAUjk7KXPc9egahQrbZBpRPNH5kjp6YJE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd6cf5e0-40bd-4e47-f32c-08dbfdb6a4ac
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2023 21:41:49.2780
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pMXBKZZCupN9rdK8Xy/JdTngpiA/0u78IxK4o8+IfHtGq8zx0kdx/tNYL/Yykp/w4cZCPhCZfBx1dOp4hhpR9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7802
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-15_10,2023-12-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 spamscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=999 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312150151
X-Proofpoint-ORIG-GUID: 7oJUpV7jE6BAfz5fJArFPCc-lax8Cltc
X-Proofpoint-GUID: 7oJUpV7jE6BAfz5fJArFPCc-lax8Cltc

On Fri, Dec 15, 2023 at 12:40:07PM -0800, dai.ngo@oracle.com wrote:
> 
> On 12/15/23 11:54 AM, Chuck Lever wrote:
> > On Fri, Dec 15, 2023 at 11:15:03AM -0800, Dai Ngo wrote:
> > > If the callback workqueue is stuck, nfsd4_deleg_getattr_conflict will
> > > also stuck waiting for the callback request to be executed. This causes
> > > the client to hang waiting for the reply of the GETATTR and also causes
> > > the reboot of the NFS server to hang due to the pending NFS request.
> > > 
> > > Fix by replacing wait_on_bit with wait_on_bit_timeout with 20 seconds
> > > time out.
> > > 
> > > Reported-by: Wolfgang Walter <linux-nfs@stwm.de>
> > > Fixes: 6c41d9a9bd02 ("NFSD: handle GETATTR conflict with write delegation")
> > > Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
> > > ---
> > >   fs/nfsd/nfs4state.c | 6 +++++-
> > >   fs/nfsd/state.h     | 2 ++
> > >   2 files changed, 7 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> > > index 175f3e9f5822..0cc7d4953807 100644
> > > --- a/fs/nfsd/nfs4state.c
> > > +++ b/fs/nfsd/nfs4state.c
> > > @@ -2948,6 +2948,9 @@ void nfs4_cb_getattr(struct nfs4_cb_fattr *ncf)
> > >   	if (test_and_set_bit(CB_GETATTR_BUSY, &ncf->ncf_cb_flags))
> > >   		return;
> > > +	/* set to proper status when nfsd4_cb_getattr_done runs */
> > > +	ncf->ncf_cb_status = NFS4ERR_IO;
> > > +
> > >   	refcount_inc(&dp->dl_stid.sc_count);
> > >   	if (!nfsd4_run_cb(&ncf->ncf_getattr)) {
> > >   		refcount_dec(&dp->dl_stid.sc_count);
> > > @@ -8558,7 +8561,8 @@ nfsd4_deleg_getattr_conflict(struct svc_rqst *rqstp, struct inode *inode,
> > >   			nfs4_cb_getattr(&dp->dl_cb_fattr);
> > >   			spin_unlock(&ctx->flc_lock);
> > > -			wait_on_bit(&ncf->ncf_cb_flags, CB_GETATTR_BUSY, TASK_INTERRUPTIBLE);
> > > +			wait_on_bit_timeout(&ncf->ncf_cb_flags, CB_GETATTR_BUSY,
> > > +				TASK_INTERRUPTIBLE, NFSD_CB_GETATTR_TIMEOUT);
> > I'm still thinking the timeout here should be the same (or slightly
> > longer than) the RPC retransmit timeout, rather than adding a new
> > NFSD_CB_GETATTR_TIMEOUT macro.
> 
> The NFSD_CB_GETATTR_TIMEOUT is used only when we can not submit a
> work item to the workqueue so RPC is not involved here.

In the "RPC was sent successfully" case, there is an implicit
assumption here that wait_on_bit_timeout() won't time out before the
actual RPC CB_GETATTR timeout.

You've chosen timeout values that happen to work, but there's
nothing in this patch that ties the two timeout values together or
in any other way documents this implicit assumption.


> We need to
> time out here to prevent the client (that causes the conflict) to
> hang waiting for the reply of the GETATTR and to prevent the server
> reboot to hang due to a pending NFS request.

Perhaps a better approach would be to not rely on a timeout, but
instead have nfs4_cb_getattr() wake up the bit wait before
returning, when it can't queue the work. That way, wait_on_bit()
will return immediately in that case.


> > >   			if (ncf->ncf_cb_status) {
> > >   				status = nfserrno(nfsd_open_break_lease(inode, NFSD_MAY_READ));
> > >   				if (status != nfserr_jukebox ||
> > > diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
> > > index f96eaa8e9413..94563a6813a6 100644
> > > --- a/fs/nfsd/state.h
> > > +++ b/fs/nfsd/state.h
> > > @@ -135,6 +135,8 @@ struct nfs4_cb_fattr {
> > >   /* bits for ncf_cb_flags */
> > >   #define	CB_GETATTR_BUSY		0
> > > +#define	NFSD_CB_GETATTR_TIMEOUT	msecs_to_jiffies(20000) /* 20 secs */
> > > +
> > >   /*
> > >    * Represents a delegation stateid. The nfs4_client holds references to these
> > >    * and they are put when it is being destroyed or when the delegation is
> > > -- 
> > > 2.39.3
> > > 

-- 
Chuck Lever

