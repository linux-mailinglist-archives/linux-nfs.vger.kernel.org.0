Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03A2979D1EC
	for <lists+linux-nfs@lfdr.de>; Tue, 12 Sep 2023 15:18:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232331AbjILNS7 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 12 Sep 2023 09:18:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233517AbjILNS6 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 12 Sep 2023 09:18:58 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B649010CA
        for <linux-nfs@vger.kernel.org>; Tue, 12 Sep 2023 06:18:54 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38C9nKIj028544;
        Tue, 12 Sep 2023 13:18:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=XODK+XxjXOEJ/iv60IqgSOKgg7SrCyxYlbHC5NbIuEM=;
 b=XqZQTFJIqpG7Z2dQQg0e28g08Xb6ioWUrMKLRV0yNNnJOPd+Sq7a3kaeuOs33dRya9nr
 pzKjAxDpOTpigU2+0bDYxbEWNYRKVBtQODiMjgMNQ2UIQhT4ylrMTpNtt8UfvIXQ1z+6
 E+/vnxx+WrOPPoB/zS+cgIjzvG7PxpeuFykz0cooTPhADvpZkdmPzhq536c5DQN14BjW
 OYdtk7ydmD3f3CWj+tJ8jz8DVfNuK+crg0goA+hRxdknLXe2VUy4RZPMDw38fTHoXyzp
 yFlE6LpUudIguBI2U8y27vYmVeauZsCln5o1KK5EBe5uVcUZkcU2t2lQnVx2YIdKYgAA rQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t1jp7bx21-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Sep 2023 13:18:50 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38CCIsHj007794;
        Tue, 12 Sep 2023 13:18:40 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2107.outbound.protection.outlook.com [104.47.70.107])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3t0f55r7h6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Sep 2023 13:18:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KBEYdmJxzQUffrC5nXVaufeR7Os+ZevNK6L5vHE70IWt/D9xEZLjJOAeV5fIK8R2MpwCd6v3fIhHcKWArHfY/0b9RvNEg/TV5ploD426gaLL7hO5OHXWONnTZ968KM7tWsBNNyPfZn+HM9MzyqzfhdZjJS6Y9tDit9qZmW44Mt9dR05fyWna/9UDwNBDA4ofFRpNhwn0dBUugdrpSdtvpxsjTM0Gb5kTvv7B5dOre1ZZ1+Y9m5VRmaOsm1f4BM+kg3pLOiYvGdVJ3wj3Xos/wOBHRJ/pTKDe5TaOI4KLlUVTxc1uRqiGfG92CFqduv2j5xVoc3v5LJD20F9HQ6uCKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XODK+XxjXOEJ/iv60IqgSOKgg7SrCyxYlbHC5NbIuEM=;
 b=hvVdlJc0GqhC7wF3NrvA2D1C5XtW4YHudOcVkLQ0oRjx1XsAFDV3MBMfhWWxV9CABo7zrntKCMdVzYcVyTRfxzFf8jpWnOFw1KQZDINc8pWBH50IOKeIhawWpoOwrW5MlLV1ty8mTLuqJ76eqsyB3s8I3x3JrFt8zFnf5v/h/oAuxMYWkXH2K71SzA/gfq6GxKzQrhIODSKBpzhkuvieZwuIct+2pHldz9NeDnvFtGjXq0BsHmxZhRUzi4VMMwd3NnlseBG990WQfcrABbeISMrbmbaZ6UuE4/LFeCTJ1gh2aPCB1gxqOs1GD9ft9guoVdGqz+kyaCu7Nif+Oe1/qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XODK+XxjXOEJ/iv60IqgSOKgg7SrCyxYlbHC5NbIuEM=;
 b=QjgnM+03dw6LQD9z8h6blU3I7VVYvUgQWHqD5xCfd0DCMysHa0kVWNrpjSdlnpYa8Dd/xtvC38YzwuayQauGNQQH7GhHVNknksnVGEPS0VTjXiwJsHVW2CiTztAitNmmVTyvzvBnTq8LpHQtRCPd8OBYS+YUXHrmb49Uw/0azpQ=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DM4PR10MB6016.namprd10.prod.outlook.com (2603:10b6:8:ab::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6768.35; Tue, 12 Sep 2023 13:18:37 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e%6]) with mapi id 15.20.6768.036; Tue, 12 Sep 2023
 13:18:36 +0000
Date:   Tue, 12 Sep 2023 09:18:33 -0400
From:   Chuck Lever <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>, trondmy@gmail.com
Cc:     linux-nfs@vger.kernel.org
Subject: Re: [PATCH] nfsd: Handle EOPENSTALE correctly in the filecache
Message-ID: <ZQBlKXWbJLfPp318@tissot.1015granger.net>
References: <20230911183027.11372-1-trond.myklebust@hammerspace.com>
 <eefec1ba89a5b70de5a0964e3d321a22ac86ab2d.camel@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eefec1ba89a5b70de5a0964e3d321a22ac86ab2d.camel@kernel.org>
X-ClientProxiedBy: CH2PR14CA0028.namprd14.prod.outlook.com
 (2603:10b6:610:60::38) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|DM4PR10MB6016:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c39a41e-ed69-4a82-ec67-08dbb392c591
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m/iNmYB0vMEwDsBqucOGj8Gs1Sl+QHU0E3cH3MyYjRdh0Snse+Jl3oYZC1WR7qlH+ekSZvQu1RHZCbBhzS4p4XiHDuXZNRSy50VWO5JHFZdnrUpoCnLZXuXpspgQPAWiUXJcpfEDz6hJjpzFvdm88LttXSGUltRHGmMToavKb3fLM9Lp9MypiUUtnp6qYO1AEaxV/uQqwUK06B8x/m4/S6Z/PZG5zuvWsTT0FN4OVJkCnnsJglMx4GnrqgIoRNpxIYRynPed0PAwwpk55w57ofxjY8aLDUWhEzCHV7HjHE0Fbr46vKdiIuGqLGPnpb/4vst/+iD2HP3hYeDQLFyg78jc4eeu4wmYzrv08mGjZ+UqnTvOv9O/tDTOTWk25k5NF0L+5YyqcDjSS7QuhlnpZZyVf1q5zgPRrfSHbQvi/goAXL9oesfYKYJmPkAc5k5AmQVpOB2H6kRUjdlJ8YAPy7QNfsPs2SubmyiJLwAzo9KpNVGX4T5L8zcTDDMJoWrrGW34ICijLNAnyGv/ySR8QrurKDiwafk7y/VvsdXUkMoWxerUyKyu7GTpcyQ1INQW
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(366004)(39860400002)(376002)(136003)(1800799009)(186009)(451199024)(41300700001)(6486002)(6666004)(6506007)(83380400001)(6512007)(478600001)(2906002)(44832011)(66946007)(5660300002)(66476007)(66556008)(8936002)(8676002)(316002)(26005)(4326008)(86362001)(9686003)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YdphFdSL8xn34RpPYP1Iz7iWtQeQ+Q16avEtBkDEMEiiPgPFp8jlYP8ScSif?=
 =?us-ascii?Q?ddAwekzwWFfqU2Y/rZGMRKaYiC1f8GMealruyTD3LTTyLlkBjno15ZclUPK5?=
 =?us-ascii?Q?BK9YW2tkUa3jLhHck6I1FITu6DNf4aypNnavtzynhkG8BWzkrGEdoeMbXaKz?=
 =?us-ascii?Q?cUnGZG9mMOLGtxV3ux5evm309pod/Ek7/Z+ammyu+mHYeh61DWVduCp5ol04?=
 =?us-ascii?Q?SiK6Q/WxKTAo7hclJjnZHwPozz2F5IHcl6wKgD/iFP5GuEzu90mH6Eaj70io?=
 =?us-ascii?Q?xdsOUxa20ltODdgP2oZEeqqGKgqLZQRr3KNQOac+yNK0kUrDeit8yrinDcUn?=
 =?us-ascii?Q?WaFK6jmD1mH7wS5l5eWaYeIJk/25blYglPzPnFADujYne0Vk5H1Chbjv6HRn?=
 =?us-ascii?Q?uqPMyTLJlCoKvNijB2LrgZnqzIXW492Pj0HGgjwAv+E4TWZPuMdZY5yaK2Up?=
 =?us-ascii?Q?g6uQrPRvYt4WoL50CrIW2vBIrcgqjXCpA9GZgPTOuu7b0nTpyLNbSX/fV1PS?=
 =?us-ascii?Q?/799uvtK+ZDRW+hiF8g/O2ptP7XSLggU807yI9jSwiizKodxQMhuedZiuVpC?=
 =?us-ascii?Q?rWRmhpXoQwuFVUJQwrOkxCIs9zclqhRZcbo9vIk5o+DzVftbvpZm2KKvkdC1?=
 =?us-ascii?Q?D6aHgbRSwm4aBvXDG+ZC4OKkQ+Ho/+sQXszjqqlABNWO0eDJYGwVBF0vYY/q?=
 =?us-ascii?Q?wxwuImU/TqEh+SAbrXNVvI/FaNof3e4B4WQSXv4KbVj47xNI6VSzj9wF8k//?=
 =?us-ascii?Q?Cr71GhpFwaXTiDfjLVQDWc73Co2CWbGAo24CLRGml70LC2BK2BAVKrbsvv5P?=
 =?us-ascii?Q?RMioelxQ/QzRWgwlxjnykEhb4QB/eqFhPcYXKgyQSLLBC+Kdtgkt3PrJbcMr?=
 =?us-ascii?Q?RolUlRyWiS9ZHRIUr4BMIhS2lP9+CgdNOCPdbgRKDkoj9ZAjdk4ACXTQGSQ/?=
 =?us-ascii?Q?DcwVMWyFxsr6084U4/Q0/2MX1KUWmV78CrYjvuLZIcQQEKHqZKJSHlsk/o4e?=
 =?us-ascii?Q?upuqBov/yJMoccg2lx5WgP/1kfFq9ofi6Nh2R+QHIqwGJ9H1Tba5/pTatqwB?=
 =?us-ascii?Q?Csn1bIMsOB5PXFAtaUJUIWBfmb41Ryg5Jzoyw3dX1HppaK0tKgob0pAy2BVh?=
 =?us-ascii?Q?3A4BGvn2NtjMpwQpgJHDjx5khsK9glpmv6HMJcrsswlNJ8+Csf5EfK86Q0S0?=
 =?us-ascii?Q?CnEtuE42ngFuh6AVaxUqLBE+sW9ZaD7aL76yj7wDp1GwGTJFt1sMUal/+61e?=
 =?us-ascii?Q?dldVGxhD9m/oLfz62YAurDI+X4RwZGt4BshmHTlb57YqWrfO3j5qd1epHeoI?=
 =?us-ascii?Q?3lOiwhZZaIJ/d4SS2vZLSTd2h0tzbs+Qb/y+skifDqEvk7mf7Jx5MH1HBG0f?=
 =?us-ascii?Q?gxL/T9M9q/ci76z8z8EnAkJeQFS/aSKkMefvOa0dK1Y7M3CbP+hYRmNZ934X?=
 =?us-ascii?Q?naJmsOKl2NZpaKV/tNW5dRGeaEIsRWIJ/lYsbsgZ+7NxsSasED5OoGqYxcTw?=
 =?us-ascii?Q?RYNRwwWMHuTvDOssh758MTfbZHPzt46KzMMUxpw40W9JxeBSe/tbTsxO7qTh?=
 =?us-ascii?Q?SwVOlsHY8as7Uiw3z8AfCXN5/IKkkuwi34+on/anFlFCPPUQs+mwoY1cu9HG?=
 =?us-ascii?Q?/A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: PoEddxjwgdKcBC/E0tb2NzvjoA7tQVyTYeKnfUrN+Ltj7xTrRrDjZ6/s7rvuWYo7BOIG7oSUQn2oPJErBXncfiLfI2rttjUDwIO/qUHyT9zHOIe9UFH4FCTkh6C+GIkqthad0fcMCGayW8ceFZpbA7mQStq6gFME/x1oS25hHGqpoRcq5Of49Qs39ma2+BT1jNPWOJESKd0WOMcY8LvyszXNfX8IHSH4q0hHpoK+xBcZrh+qNFhRKHQ+MrQD5YKcLH+ZuKuy5Ljum2ReLYVCyQdRz6KpDR9sBrrLTi8Gulzo9EhZcd6LOsiZUoazLkEooJb/6IZyjvudKhKN7R7DziV9I4oIHL5jvMg9l6i2GyIaVYRNE2mkrIWLiniOVk7eqNw4wuNp3nhXgoMQVyZbymQDyzooH4G23Yf9aHuwpdgx8B7OvOWndEa/7n8Er/6fe5jy3kC4QFyUlqMR8G5/gOXA+Oaz//mbuNK0BJ6o13oaIjErnvcM8Ypt6rjHrKmYFMh0sHocaKRfXmCgONK3fURibMcWYSK9iunqP3mdCdAA8K0XhCZ0U9ztVIlWT2LUJuUriu5duiNtRf24/k9TiUPHsgePXnb/O2AhRxBlX8IAq354M59JgRSA7trY7gXeIynap1PSs3Hh0RWT58MWyKph/mZwmioSZyL3NoX/mi/c/juB9YSq2ZYaqE7cqMDg5CL20rTQ2v2poFdL4XTOELPFA1MqIUPERHFfRfBCq6ojTam3CxlA5qsFM/8To0gk9ZIO+9q7zP8NkZoBVix8jEFEE1DB1GjCAvxFjRMftStf2zMYw8QTjcPrX0o5UrKj
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c39a41e-ed69-4a82-ec67-08dbb392c591
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2023 13:18:36.5360
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 706la5gvnRJxqbfbaMy7XTWnNdUXzuXyUYuGUOKfGyq+DqkpSXaG+r0iNHU/7H48PO8rduFmTbkmHBx6lwvrag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6016
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-12_11,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 spamscore=0 mlxscore=0 mlxlogscore=999 adultscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309120110
X-Proofpoint-GUID: XjAoVdU5FO_X6GKBWFNwQLjxWcnFqil_
X-Proofpoint-ORIG-GUID: XjAoVdU5FO_X6GKBWFNwQLjxWcnFqil_
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Sep 12, 2023 at 06:44:40AM -0400, Jeff Layton wrote:
> On Mon, 2023-09-11 at 14:30 -0400, trondmy@gmail.com wrote:
> > From: Trond Myklebust <trond.myklebust@hammerspace.com>
> > 
> > The nfsd_open code handles EOPENSTALE correctly, by retrying the call to
> > fh_verify() and __nfsd_open(). However the filecache just drops the
> > error on the floor, and immediately returns nfserr_stale to the caller.
> > 
> > This patch ensures that we propagate the EOPENSTALE code back to
> > nfsd_file_do_acquire, and that we handle it correctly.
> > 
> > Fixes: 65294c1f2c5e ("nfsd: add a new struct file caching facility to nfsd")
> > Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> > ---
> >  fs/nfsd/filecache.c | 27 +++++++++++++++++++--------
> >  fs/nfsd/vfs.c       | 28 +++++++++++++---------------
> >  fs/nfsd/vfs.h       |  2 +-
> >  3 files changed, 33 insertions(+), 24 deletions(-)
> > 
> > diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> > index ee9c923192e0..07bf219f9ae4 100644
> > --- a/fs/nfsd/filecache.c
> > +++ b/fs/nfsd/filecache.c
> > @@ -989,22 +989,21 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, struct svc_fh *fhp,
> >  	unsigned char need = may_flags & NFSD_FILE_MAY_MASK;
> >  	struct net *net = SVC_NET(rqstp);
> >  	struct nfsd_file *new, *nf;
> > -	const struct cred *cred;
> > +	bool stale_retry = true;
> >  	bool open_retry = true;
> >  	struct inode *inode;
> >  	__be32 status;
> >  	int ret;
> >  
> > +retry:
> >  	status = fh_verify(rqstp, fhp, S_IFREG,
> >  				may_flags|NFSD_MAY_OWNER_OVERRIDE);
> >  	if (status != nfs_ok)
> >  		return status;
> >  	inode = d_inode(fhp->fh_dentry);
> > -	cred = get_current_cred();
> >  
> > -retry:
> >  	rcu_read_lock();
> > -	nf = nfsd_file_lookup_locked(net, cred, inode, need, want_gc);
> > +	nf = nfsd_file_lookup_locked(net, current_cred(), inode, need, want_gc);
> >  	rcu_read_unlock();
> >  
> >  	if (nf) {
> > @@ -1026,7 +1025,7 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, struct svc_fh *fhp,
> >  
> >  	rcu_read_lock();
> >  	spin_lock(&inode->i_lock);
> > -	nf = nfsd_file_lookup_locked(net, cred, inode, need, want_gc);
> > +	nf = nfsd_file_lookup_locked(net, current_cred(), inode, need, want_gc);
> >  	if (unlikely(nf)) {
> >  		spin_unlock(&inode->i_lock);
> >  		rcu_read_unlock();
> > @@ -1058,6 +1057,7 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, struct svc_fh *fhp,
> >  			goto construction_err;
> >  		}
> >  		open_retry = false;
> > +		fh_put(fhp);
> >  		goto retry;
> >  	}
> >  	this_cpu_inc(nfsd_file_cache_hits);
> > @@ -1074,7 +1074,6 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, struct svc_fh *fhp,
> >  		nfsd_file_check_write_error(nf);
> >  		*pnf = nf;
> >  	}
> > -	put_cred(cred);
> >  	trace_nfsd_file_acquire(rqstp, inode, may_flags, nf, status);
> >  	return status;
> >  
> > @@ -1088,8 +1087,20 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, struct svc_fh *fhp,
> >  			status = nfs_ok;
> >  			trace_nfsd_file_opened(nf, status);
> >  		} else {
> > -			status = nfsd_open_verified(rqstp, fhp, may_flags,
> > -						    &nf->nf_file);
> > +			ret = nfsd_open_verified(rqstp, fhp, may_flags,
> > +						 &nf->nf_file);
> > +			if (ret == -EOPENSTALE && stale_retry) {
> > +				stale_retry = false;
> > +				nfsd_file_unhash(nf);
> > +				clear_and_wake_up_bit(NFSD_FILE_PENDING,
> > +						      &nf->nf_flags);
> > +				if (refcount_dec_and_test(&nf->nf_ref))
> > +					nfsd_file_free(nf);
> > +				nf = NULL;
> > +				fh_put(fhp);
> > +				goto retry;
> > +			}
> > +			status = nfserrno(ret);
> >  			trace_nfsd_file_open(nf, status);
> >  		}
> >  	} else
> > diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> > index 2c9074ab2315..98fa4fd0556d 100644
> > --- a/fs/nfsd/vfs.c
> > +++ b/fs/nfsd/vfs.c
> > @@ -823,7 +823,7 @@ int nfsd_open_break_lease(struct inode *inode, int access)
> >   * and additional flags.
> >   * N.B. After this call fhp needs an fh_put
> >   */
> > -static __be32
> > +static int
> >  __nfsd_open(struct svc_rqst *rqstp, struct svc_fh *fhp, umode_t type,
> >  			int may_flags, struct file **filp)
> >  {
> > @@ -831,14 +831,12 @@ __nfsd_open(struct svc_rqst *rqstp, struct svc_fh *fhp, umode_t type,
> >  	struct inode	*inode;
> >  	struct file	*file;
> >  	int		flags = O_RDONLY|O_LARGEFILE;
> > -	__be32		err;
> > -	int		host_err = 0;
> > +	int		host_err = -EPERM;
> >  
> >  	path.mnt = fhp->fh_export->ex_path.mnt;
> >  	path.dentry = fhp->fh_dentry;
> >  	inode = d_inode(path.dentry);
> >  
> > -	err = nfserr_perm;
> >  	if (IS_APPEND(inode) && (may_flags & NFSD_MAY_WRITE))
> >  		goto out;
> >  
> > @@ -847,7 +845,7 @@ __nfsd_open(struct svc_rqst *rqstp, struct svc_fh *fhp, umode_t type,
> >  
> >  	host_err = nfsd_open_break_lease(inode, may_flags);
> >  	if (host_err) /* NOMEM or WOULDBLOCK */
> > -		goto out_nfserr;
> > +		goto out;
> >  
> >  	if (may_flags & NFSD_MAY_WRITE) {
> >  		if (may_flags & NFSD_MAY_READ)
> > @@ -859,13 +857,13 @@ __nfsd_open(struct svc_rqst *rqstp, struct svc_fh *fhp, umode_t type,
> >  	file = dentry_open(&path, flags, current_cred());
> >  	if (IS_ERR(file)) {
> >  		host_err = PTR_ERR(file);
> > -		goto out_nfserr;
> > +		goto out;
> >  	}
> >  
> >  	host_err = ima_file_check(file, may_flags);
> >  	if (host_err) {
> >  		fput(file);
> > -		goto out_nfserr;
> > +		goto out;
> >  	}
> >  
> >  	if (may_flags & NFSD_MAY_64BIT_COOKIE)
> > @@ -874,10 +872,8 @@ __nfsd_open(struct svc_rqst *rqstp, struct svc_fh *fhp, umode_t type,
> >  		file->f_mode |= FMODE_32BITHASH;
> >  
> >  	*filp = file;
> > -out_nfserr:
> > -	err = nfserrno(host_err);
> >  out:
> > -	return err;
> > +	return host_err;
> >  }
> >  
> >  __be32
> > @@ -885,6 +881,7 @@ nfsd_open(struct svc_rqst *rqstp, struct svc_fh *fhp, umode_t type,
> >  		int may_flags, struct file **filp)
> >  {
> >  	__be32 err;
> > +	int host_err;
> >  	bool retried = false;
> >  
> >  	validate_process_creds();
> > @@ -904,12 +901,13 @@ nfsd_open(struct svc_rqst *rqstp, struct svc_fh *fhp, umode_t type,
> >  retry:
> >  	err = fh_verify(rqstp, fhp, type, may_flags);
> >  	if (!err) {
> > -		err = __nfsd_open(rqstp, fhp, type, may_flags, filp);
> > -		if (err == nfserr_stale && !retried) {
> > +		host_err = __nfsd_open(rqstp, fhp, type, may_flags, filp);
> > +		if (host_err == -EOPENSTALE && !retried) {
> >  			retried = true;
> >  			fh_put(fhp);
> >  			goto retry;
> >  		}
> > +		err = nfserrno(host_err);
> >  	}
> >  	validate_process_creds();
> >  	return err;
> > @@ -922,13 +920,13 @@ nfsd_open(struct svc_rqst *rqstp, struct svc_fh *fhp, umode_t type,
> >   * @may_flags: internal permission flags
> >   * @filp: OUT: open "struct file *"
> >   *
> > - * Returns an nfsstat value in network byte order.
> > + * Returns a posix error.
> >   */
> > -__be32
> > +int
> >  nfsd_open_verified(struct svc_rqst *rqstp, struct svc_fh *fhp, int may_flags,
> >  		   struct file **filp)
> >  {
> > -	__be32 err;
> > +	int err;
> >  
> >  	validate_process_creds();
> >  	err = __nfsd_open(rqstp, fhp, S_IFREG, may_flags, filp);
> > diff --git a/fs/nfsd/vfs.h b/fs/nfsd/vfs.h
> > index a6890ea7b765..e4b7207ef2e0 100644
> > --- a/fs/nfsd/vfs.h
> > +++ b/fs/nfsd/vfs.h
> > @@ -104,7 +104,7 @@ __be32		nfsd_setxattr(struct svc_rqst *rqstp, struct svc_fh *fhp,
> >  int 		nfsd_open_break_lease(struct inode *, int);
> >  __be32		nfsd_open(struct svc_rqst *, struct svc_fh *, umode_t,
> >  				int, struct file **);
> > -__be32		nfsd_open_verified(struct svc_rqst *, struct svc_fh *,
> > +int		nfsd_open_verified(struct svc_rqst *, struct svc_fh *,
> >  				int, struct file **);
> >  __be32		nfsd_splice_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
> >  				struct file *file, loff_t offset,
> 
> Looks reasonable.
> 
> Reviewed-by: Jeff Layton <jlayton@kernel.org>

Thanks, Jeff. Applied to nfsd-next.

-- 
Chuck Lever
