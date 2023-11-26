Return-Path: <linux-nfs+bounces-79-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 38EBE7F94B9
	for <lists+linux-nfs@lfdr.de>; Sun, 26 Nov 2023 18:55:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7B4B280FFD
	for <lists+linux-nfs@lfdr.de>; Sun, 26 Nov 2023 17:54:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C3F1DF5C;
	Sun, 26 Nov 2023 17:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JkT2gMlO";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="q2NkoA3b"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B49E9DE
	for <linux-nfs@vger.kernel.org>; Sun, 26 Nov 2023 09:54:52 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AQHaoM4008606;
	Sun, 26 Nov 2023 17:54:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=fDI2cLoyrBFjIC4MMSUsTDwc9llySHHDcXAnlDPe68I=;
 b=JkT2gMlO3CT4kxZhfn8U+cc3iyt3dIH4rbkHD8m2LdPM+UhFt0UwhsnZAHloUYYLW8Ti
 toGbOPQ4ZxrA7PEghUamKVRZP0ACVf4LV5cV+lZe6xroxwLPmfSg2vJytC7Hp+j4mphQ
 kiQwDtfLxzpAXMguNfKCPtCvJj3zvfi4b0ISTk+E+LdSNr1BKMzi8/C5Q9N4Ejk4o4LB
 TTSGQon+zckUCgUziTpo1BeYim3bvDA4MQV5uLi748m0z57Y+9akODhV6nIyjveEKChb
 RpcNWgtXZEnlgCXtpE3KExhW/Qm+pix7lfs1NNva8nKp1sv+Tn+vzXYUG7ISmIEiGhRV /w== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uk7h2hhsv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 26 Nov 2023 17:54:43 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3AQFhxjw026507;
	Sun, 26 Nov 2023 17:54:42 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2040.outbound.protection.outlook.com [104.47.56.40])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3uk7c45xqc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 26 Nov 2023 17:54:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c+rRRp+hCvVXMILx0wW7GAzLQ6wO/wfOuI1gPnonv8Dj+g/OTekVSzd4i100j7tDWfU6H7MNZ2Z1PLjAhBVRscuAiZYUFNrgqFlHYlejBTqA+xwWVw6gcTWsXiGHCWop3a04QGu/zdW0sKnh7T1Mjy6MfP39NuzgYJGt+4V1q0F7tCl1Mi145oQ5iz1YvzxyW6b+zniENOkMepZWi5EkUxfWEdUdKg7bhu6j+JDFf4ofVGryTVAkNset7dM/Y2jUBR0204E425IyqJeZiVEz+/gLpW0WsjNGGAwy1e0z/72RwhBcpqvyAS5+O4kSZIGkc7SpYLrw5hHkNWWEakeDOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fDI2cLoyrBFjIC4MMSUsTDwc9llySHHDcXAnlDPe68I=;
 b=lSQVBVpdMer4sik80EosY4WY1nv9S8HY47nqA1u+ARmIjvPI6ixbxcPpqJFD+aD9nHasR1iVMQBZ24lKhdpvcvs7ZeuLZKQ9XGZEDl4SjWhlipUyGptQhuIWLHU/pV+HMNOuTRWEs1AExQgopMlfVFFYPPUiUXxa2U595RJJwyY+AlbFKjk5yx2UYDHqd4WWdZNBiVFhelnZdIEvGPwrjepu59y2i1IbQwRVf7WoRDcZ0Sr7ychwvV10d0JXlF9tb+zZV7ODWG/3UHWr5Fh5400GFmSIy/yoNPMHck/lsUKTq+jQYyQAEVkbymRIMhWEdVLwid5g6A6ekYXxGrBx7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fDI2cLoyrBFjIC4MMSUsTDwc9llySHHDcXAnlDPe68I=;
 b=q2NkoA3bxSjGcfmZ5L1IMcyKaIi+19uYGZwG6Pm4/+VNLHtw/pFudpNVmu4vr2kvm/nUwE49a24wF4DwCSwmtu3Q5xj3vn/OLnstFdhDviqayZIzuQr5rn3knFms/wa94LaQMD5QqIHwl4VRdfvVA/jaTCS1/yGQxF2ABYTXJFU=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CO1PR10MB4675.namprd10.prod.outlook.com (2603:10b6:303:93::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.25; Sun, 26 Nov
 2023 17:54:39 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c%4]) with mapi id 15.20.7025.022; Sun, 26 Nov 2023
 17:54:39 +0000
Date: Sun, 26 Nov 2023 12:54:35 -0500
From: Chuck Lever <chuck.lever@oracle.com>
To: NeilBrown <neilb@suse.de>
Cc: Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org,
        Olga Kornievskaia <kolga@netapp.com>, Dai Ngo <Dai.Ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>
Subject: Re: [PATCH 07/11] nfsd: allow admin-revoked NFSv4.0 state to be
 freed.
Message-ID: <ZWOGW8/PTkjp1lKe@tissot.1015granger.net>
References: <20231124002925.1816-1-neilb@suse.de>
 <20231124002925.1816-8-neilb@suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231124002925.1816-8-neilb@suse.de>
X-ClientProxiedBy: CH2PR20CA0026.namprd20.prod.outlook.com
 (2603:10b6:610:58::36) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CO1PR10MB4675:EE_
X-MS-Office365-Filtering-Correlation-Id: 64c51884-a73c-483b-89ce-08dbeea8c29a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	m5N4kaPJPzcFYjlZsGanSGqRwIlxQ4319hP+YycEGHUkitrMKm8A16kl0yoPs6d0D/yAwU8dX9aNpnmE7tpk7sBkP0EdVMIpGVnrMSZsdzG2M+ZLwEb35laaDeywxh8xx77HtwuDP2G+sZipNM45w/Hvoh8u/yDJIOOCjsLy48q4iDunylHpgX+w6WIEYDHBMl4c0WLrAmAtS9KtV6RAktJ85STey9nWcXKO5a8auOmmj8Cm4KJBnLfO9n7577T6K1Br1Mj5I76EcLiChbVn38RluuuJtgT0Yt1rL22s6cYnMuY9uM0KtQQyWqFpW04vyYKhhgi9tsaqGOxt+whimNmOB50z+3qdHLFyNChOTwotxdtZhMNfAtJQ3VFM3diARVGzVfIs5THVbua+v4gllt35ny6teQ3wuLN4bUrxn+qgZKfcTI7q+m42kOSigxiRuxLPPR1pnVGdOBuo/1vV4RZNCFY3rsDFvRD+w6vcNZOzQwc7ShEALQH2xt0wFaJWC4O1gk2J/D3YIDzUkK/a/5ACi/Fe2kWx51Py6i0Zdx5YPWCRwdhEjO9ETiX3uQFU
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(396003)(346002)(136003)(366004)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(2906002)(44832011)(54906003)(66476007)(66556008)(316002)(6916009)(6666004)(66946007)(9686003)(6512007)(4326008)(8676002)(8936002)(41300700001)(5660300002)(478600001)(6486002)(6506007)(26005)(83380400001)(66899024)(38100700002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?JM4ALPRgz2LJF5RIh52goLmf64IQMhunBlInIVpEH/5xrwck6raB8KD8xFTo?=
 =?us-ascii?Q?69zHG/ZtxTNTj70OG3MD+pDyu8Xwh6mvlbawpgOPA/G4ckMdbnlyCkjDFdrz?=
 =?us-ascii?Q?KOfHgyCLjEQ/i26WT0bH0v0hJ6fnD6mwRrWHca2TFVmAS5BC3mO51NXS9pqg?=
 =?us-ascii?Q?m0L3FDwRkQj9Fa8mKYSUM+mYKIQXw/1TQ/Cq3KvXdoCQKdKAOefsboBTElkn?=
 =?us-ascii?Q?a8l6s/V6sPAYRq4klVMoDK4ywyWJ9y9o60zIy32lzI7byZbQMoBN/JRCrqgU?=
 =?us-ascii?Q?Or/LApgtK3pJkFodM57fvVKvHi35H73mcBgGHmDwAsz5WkQ2puTQq3CSjGNc?=
 =?us-ascii?Q?xWXeZWGeIJYsUVURCUzjG0RrmuBqr8++Ai6AN3P0JevWuZJWrspe45sNoNKg?=
 =?us-ascii?Q?YauZJ0jINf9GKDUBWn4fq2J9XsJCrTyW/V8Ma9UcjMPe5yDM5THaZc+Kdr0k?=
 =?us-ascii?Q?wdzuDTyceEpwqHOwL1T9w+jx5Oc7ZgmenR1ZpVe1GUF5w9wPR+NdswRCCnIq?=
 =?us-ascii?Q?3ZXA+E84W4LQVe59V+WH0bQ9gFCiCMJfdwCTfw5wWn7tx2fxkPnXCht0KWv+?=
 =?us-ascii?Q?p8DnhMXUmJJuoxQB9nl+pWE/xg4aG7ep4FW6Mmi/7RqHx16BIoc6UqAHHkGx?=
 =?us-ascii?Q?EdEUC4yGd+d+sznv4/chFm5t0SztK7UKtB98eWtL/9GgMomZ/y1gYsNiJ4sQ?=
 =?us-ascii?Q?rci36YOP7HhWkJL+zkhTjoCgUV97zOOjO6w6LIhICquQFv/rmU7TiRvvb0Cr?=
 =?us-ascii?Q?9Cov1FOLIt5LQp4Mrt3xdEPVe+eUVicaVYO8Y42PWV+7HG+MNi2au0ISMcS/?=
 =?us-ascii?Q?Wv0TqVNOoVZJ9dLJoUBn/Ljqlw3XX3ZtzPzXRAMqdS09VWvUW8yu4N4vPOHK?=
 =?us-ascii?Q?YCB26YgVDA+FZhQuqDeuICIkGLZLYx0vxqwchAJ9i/1PT8Mkhxorgfn8V/0s?=
 =?us-ascii?Q?PTiRLX+BMCNIXb7077L3WdxtPWYUfSsqovBgbXOK7HipNlaxIFgoF07l6xbY?=
 =?us-ascii?Q?KM1bWr42DWWXoviVXOo/7abYSLwRPDJy1Nkwn8XGBAZLJ8WOo7QGthOVr4J7?=
 =?us-ascii?Q?igH8yNOgi+C5CHU6AVaBSMd7OkJUVXtuIi2ZLEpf+kSjq9XlR/jSr9r+rpey?=
 =?us-ascii?Q?coYBbrPX82X3Fs6KFZTnn+M/k3xtlYi7rB61CaiHnDjJQ5nFcRBq3DGGlNsK?=
 =?us-ascii?Q?ZGdbjq7t3bPb7fY70H+UGUzECR7yc1eiv5OX3DJiQG0gvp8dE+OssafWiekE?=
 =?us-ascii?Q?HeWeyRO1sHOOBPEDtKj91bok5vC24DVAeTqgXVRLRr0nEMwZZ+/dc2xrpDVY?=
 =?us-ascii?Q?yOlxm/wBynuQUuCvSB4BgIU9jTjszESI5XgFuj9Op4Ei4dtQzx89z66aWOlP?=
 =?us-ascii?Q?Z3FmA8QKQaZkkh1Zr0995ectjFEyd9x3yMwM/z7u++1qctIpbl28YB5mODUU?=
 =?us-ascii?Q?wooy8xGgsyrHFdBJ/yt4O65tIfIg6CGzjtqj6A/niBj0LwZ/5jpeyfh/+a40?=
 =?us-ascii?Q?qPMl4AqDmHXHMvSOAUwH6Y7YAuKOLPVZu0PHV7nzZvz6UNyYnG7nPsjAHp42?=
 =?us-ascii?Q?w0S922pPy6Hx3TSiz7WQmkB1FVtRCXP0YlpkY7sH/CKzp63v10HVe2RXpEef?=
 =?us-ascii?Q?aw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	lMogHGQG+w0wNHdKr96wMzfYSuSsvX8DWtlRiK1i70rUt4xA0IyPaxdUEAY9uX+IGdeXYtWMnDDIxJ7LFhH/PgO+vTvF9SV7QnrFAbjc/9fCrJwHjHLjWMWXTXavc8CIFgs591YKQ24fRh+ltcr6532G3TQ07q/IQhtcRklpZtgP+wUldXQIYWE2JXdsCrp/Qwxqeo6lK/DqojiUnIqWmFEldD6KhO9YtrEpluuPHcZzq/eB6hrrTp3J/ELVduophGmRnPNu2NjWJzsu3a0wgP0mmvmHQlXrTnRCYBY2NjuWBscBrrqWiPYuzHmlWxso0LcMK6vbVgf/zJlhWcsTBlme18GQf6MBb+0rex/EJqOWnIyAl6nb82aBbFulIhxzg47UO61AEwc0/LrWGS5KQzY62/E57F50QdP/hQcEpzGYKm5hDpsFRIJ4LfIJ9gmaocrsbu9U2jLmGCJ4l69AWPZNRbM3Ob8FO40xjZ5AEGX70zeg7OnEngaXMFR7XwKo/rM89IUWDNyeDcRrdlHUijjXVWWOy9lxT9//rgsCTNiNhA9JImBCSdKF18uS6KxvSawlTHd1fkPFhtgv7SY5Ira3I5YqD4BKg4qO8gZVtAzr/XGDFzM24kdIQKJu6i8rK1DPuvvhAUYR0yez/2fPOAFUKyR1HRv/z4ClhCJfPk6+VBvtxgQR+Fl4oju32PvizqyxT1txPdE1ct5l+uI50i41BDvlTpUfSSWD37Zs5zPmG0P6qmptP47ndMWofc6mA4MM4x0zwc6kYCps3DrBbikiYYj/2SroQ4u7Qxwj1Bvgp0vErI+V8w+LmGVnQtDgQcLBlRbA9SnBS2pxvUEVU+S7y/E6sUVOy2SARjvTVKG7LesNncFI5SCprUQS8cgK
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64c51884-a73c-483b-89ce-08dbeea8c29a
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2023 17:54:39.1426
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Woj2E9SooLgeP+GIH88WPUy/euiqqFIdWQkYXwKOkP/XPrSBvirA1y+HmLVK+/ZO7LaY4UXD5d1V/l4OSAr2cw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4675
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-26_17,2023-11-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 mlxlogscore=999
 bulkscore=0 adultscore=0 phishscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311260133
X-Proofpoint-GUID: 6In5nSaMBxwmJjnM-bLo1vDgGxmgcy-3
X-Proofpoint-ORIG-GUID: 6In5nSaMBxwmJjnM-bLo1vDgGxmgcy-3

On Fri, Nov 24, 2023 at 11:28:42AM +1100, NeilBrown wrote:
> For NFSv4.1 and later the client easily discovers if there is any
> admin-revoked state and will then find and explicitly free it.
> 
> For NFSv4.0 there is no such mechanism.  The client can only find that
> state is admin-revoked if it tries to use that state, and there is no
> way for it to explicitly free the state.  So the server must hold on to
> the stateid (at least) for an indefinite amount of time.  A
> RELEASE_LOCKOWNER request might justify forgetting some of these
> stateids, as would the whole clients lease lapsing, but these are not
> reliable.

They aren't reliable, but what are the consequences of revoked
state left on the server? Seems like our implementation has a
number of mechanisms for cleaning up state over time. Do you feel
this is a denial-of-service vector?


> This patch takes two approaches.
> 
> Whenever a client uses an revoked stateid, that stateid is then
> discarded and will not be recognised again.  This might confuse a client
> which expect to get NFS4ERR_ADMIN_REVOKED consistently once it get it at
> all, but should mostly work.  Hopefully one error will lead to other
> resources being closed (e.g.  process exits), which will result in more
> stateid being freed when a CLOSE attempt gets NFS4ERR_ADMIN_REVOKED.

I'm leery of this: "This might confuse..." and "Hopefully..." suggest
we're not real sure how this will behave in practice with the current
cohort of client implementations.

Also, this paragraph in Section 10.2.1 of RFC 7530 is concerning:

>  A client normally finds out about revocation of a delegation when it
>  uses a stateid associated with a delegation and receives one of the
>  errors NFS4ERR_EXPIRED, NFS4ERR_BAD_STATEID, or NFS4ERR_ADMIN_REVOKED
>  (NFS4ERR_EXPIRED indicates that all lock state associated with the
>  client has been lost).  It also may find out about delegation
>  revocation after a client reboot when it attempts to reclaim a
>  delegation and receives NFS4ERR_EXPIRED.  Note that in the case of a
>  revoked OPEN_DELEGATE_WRITE delegation, there are issues because data
>  may have been modified by the client whose delegation is revoked and,
>  separately, by other clients.  See Section 10.5.1 for a discussion of
>  such issues.  Note also that when delegations are revoked,
>  information about the revoked delegation will be written by the
>  server to stable storage (as described in Section 9.6).  This is done
>  to deal with the case in which a server reboots after revoking a
>  delegation but before the client holding the revoked delegation is
>  notified about the revocation.

The text here suggests that the server persists the ADMIN_REVOKED
status, which suggests to me that the server is supposed to continue
returning ADMIN_REVOKED when presented with the revoked state,
until the state is freed.

AFAICT NFSD isn't recording this status persistently... Is there a
plan to add that (later) or some words suggesting that it is safe
and reasonable not to record it?


> Also, any admin-revoked stateids that have been that way for more than
> one lease time are periodically revoke.
> 
> No actual freeing of state happens in this patch.  That will come in
> future patches which handle the different sorts of revoked state.
>
> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
>  fs/nfsd/netns.h     |  4 ++
>  fs/nfsd/nfs4state.c | 97 ++++++++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 100 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
> index ab303a8b77d5..7458f672b33e 100644
> --- a/fs/nfsd/netns.h
> +++ b/fs/nfsd/netns.h
> @@ -197,6 +197,10 @@ struct nfsd_net {
>  	atomic_t		nfsd_courtesy_clients;
>  	struct shrinker		*nfsd_client_shrinker;
>  	struct work_struct	nfsd_shrinker_work;
> +
> +	/* last time an admin-revoke happened for NFSv4.0 */
> +	time64_t		nfs40_last_revoke;
> +
>  };
>  
>  /* Simple check to find out if a given net was properly initialized */
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index 52e680235afe..c57f2ff954cb 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -1724,6 +1724,14 @@ void nfsd4_revoke_states(struct net *net, struct super_block *sb)
>  				}
>  				nfs4_put_stid(stid);
>  				spin_lock(&nn->client_lock);
> +				if (clp->cl_minorversion == 0)
> +					/* Allow cleanup after a lease period.
> +					 * store_release ensures cleanup will
> +					 * see any newly revoked states if it
> +					 * sees the time updated.
> +					 */
> +					nn->nfs40_last_revoke =
> +						ktime_get_boottime_seconds();
>  				goto retry;
>  			}
>  		}
> @@ -4648,6 +4656,39 @@ nfsd4_find_existing_open(struct nfs4_file *fp, struct nfsd4_open *open)
>  	return ret;
>  }
>  
> +static void nfsd_drop_revoked_stid(struct nfs4_stid *s)
> +{
> +	struct nfs4_client *cl = s->sc_client;
> +
> +	switch (s->sc_type) {
> +	default:
> +		spin_unlock(&cl->cl_lock);
> +	}
> +}
> +
> +static void nfs40_drop_revoked_stid(struct nfs4_client *cl,
> +				    stateid_t *stid)

Nits: I'd prefer nfsd4_drop_revoked_stid() and nfsd40_drop_revoked_stid()


> +{
> +	/* NFSv4.0 has no way for the client to tell the server
> +	 * that it can forget an admin-revoked stateid.
> +	 * So we keep it around until the first time that the
> +	 * client uses it, and drop it the first time
> +	 * nfserr_admin_revoked is returned.
> +	 * For v4.1 and later we wait until explicitly told
> +	 * to free the stateid.
> +	 */
> +	if (cl->cl_minorversion == 0) {
> +		struct nfs4_stid *st;
> +
> +		spin_lock(&cl->cl_lock);
> +		st = find_stateid_locked(cl, stid);
> +		if (st)
> +			nfsd_drop_revoked_stid(st);
> +		else
> +			spin_unlock(&cl->cl_lock);
> +	}
> +}
> +
>  static __be32
>  nfsd4_verify_open_stid(struct nfs4_stid *s)
>  {
> @@ -4670,6 +4711,10 @@ nfsd4_lock_ol_stateid(struct nfs4_ol_stateid *stp)
>  
>  	mutex_lock_nested(&stp->st_mutex, LOCK_STATEID_MUTEX);
>  	ret = nfsd4_verify_open_stid(&stp->st_stid);
> +	if (ret == nfserr_admin_revoked)
> +		nfs40_drop_revoked_stid(stp->st_stid.sc_client,
> +					&stp->st_stid.sc_stateid);
> +
>  	if (ret != nfs_ok)
>  		mutex_unlock(&stp->st_mutex);
>  	return ret;
> @@ -5253,6 +5298,7 @@ nfs4_check_deleg(struct nfs4_client *cl, struct nfsd4_open *open,
>  	}
>  	if (deleg->dl_stid.sc_status & NFS4_STID_REVOKED) {
>  		nfs4_put_stid(&deleg->dl_stid);
> +		nfs40_drop_revoked_stid(cl, &open->op_delegate_stateid);
>  		status = nfserr_deleg_revoked;
>  		goto out;
>  	}
> @@ -6251,6 +6297,43 @@ nfs4_process_client_reaplist(struct list_head *reaplist)
>  	}
>  }
>  
> +static void nfs40_clean_admin_revoked(struct nfsd_net *nn,
> +				      struct laundry_time *lt)
> +{
> +	struct nfs4_client *clp;
> +
> +	spin_lock(&nn->client_lock);
> +	if (nn->nfs40_last_revoke == 0 ||
> +	    nn->nfs40_last_revoke > lt->cutoff) {
> +		spin_unlock(&nn->client_lock);
> +		return;
> +	}
> +	nn->nfs40_last_revoke = 0;
> +
> +retry:
> +	list_for_each_entry(clp, &nn->client_lru, cl_lru) {
> +		unsigned long id, tmp;
> +		struct nfs4_stid *stid;
> +
> +		if (atomic_read(&clp->cl_admin_revoked) == 0)
> +			continue;
> +
> +		spin_lock(&clp->cl_lock);
> +		idr_for_each_entry_ul(&clp->cl_stateids, stid, tmp, id)
> +			if (stid->sc_status & NFS4_STID_ADMIN_REVOKED) {
> +				refcount_inc(&stid->sc_count);
> +				spin_unlock(&nn->client_lock);
> +				/* this function drops ->cl_lock */
> +				nfsd_drop_revoked_stid(stid);
> +				nfs4_put_stid(stid);
> +				spin_lock(&nn->client_lock);
> +				goto retry;
> +			}
> +		spin_unlock(&clp->cl_lock);
> +	}
> +	spin_unlock(&nn->client_lock);
> +}
> +
>  static time64_t
>  nfs4_laundromat(struct nfsd_net *nn)
>  {
> @@ -6284,6 +6367,8 @@ nfs4_laundromat(struct nfsd_net *nn)
>  	nfs4_get_client_reaplist(nn, &reaplist, &lt);
>  	nfs4_process_client_reaplist(&reaplist);
>  
> +	nfs40_clean_admin_revoked(nn, &lt);
> +
>  	spin_lock(&state_lock);
>  	list_for_each_safe(pos, next, &nn->del_recall_lru) {
>  		dp = list_entry (pos, struct nfs4_delegation, dl_recall_lru);
> @@ -6502,6 +6587,9 @@ static __be32 nfsd4_stid_check_stateid_generation(stateid_t *in, struct nfs4_sti
>  	if (ret == nfs_ok)
>  		ret = check_stateid_generation(in, &s->sc_stateid, has_session);
>  	spin_unlock(&s->sc_lock);
> +	if (ret == nfserr_admin_revoked)
> +		nfs40_drop_revoked_stid(s->sc_client,
> +					&s->sc_stateid);
>  	return ret;
>  }
>  
> @@ -6546,6 +6634,8 @@ static __be32 nfsd4_validate_stateid(struct nfs4_client *cl, stateid_t *stateid)
>  	}
>  out_unlock:
>  	spin_unlock(&cl->cl_lock);
> +	if (status == nfserr_admin_revoked)
> +		nfs40_drop_revoked_stid(cl, stateid);
>  	return status;
>  }
>  
> @@ -6592,6 +6682,7 @@ nfsd4_lookup_stateid(struct nfsd4_compound_state *cstate,
>  		return nfserr_deleg_revoked;
>  	}
>  	if (stid->sc_type & NFS4_STID_ADMIN_REVOKED) {
> +		nfs40_drop_revoked_stid(cstate->clp, stateid);
>  		nfs4_put_stid(stid);
>  		return nfserr_admin_revoked;
>  	}
> @@ -6884,6 +6975,11 @@ nfsd4_free_stateid(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>  	s = find_stateid_locked(cl, stateid);
>  	if (!s || s->sc_status & NFS4_STID_CLOSED)
>  		goto out_unlock;
> +	if (s->sc_status & NFS4_STID_ADMIN_REVOKED) {
> +		nfsd_drop_revoked_stid(s);
> +		ret = nfs_ok;
> +		goto out;
> +	}
>  	spin_lock(&s->sc_lock);
>  	switch (s->sc_type) {
>  	case NFS4_DELEG_STID:
> @@ -6910,7 +7006,6 @@ nfsd4_free_stateid(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>  		spin_unlock(&cl->cl_lock);
>  		ret = nfsd4_free_lock_stateid(stateid, s);
>  		goto out;
> -	/* Default falls through and returns nfserr_bad_stateid */
>  	}
>  	spin_unlock(&s->sc_lock);
>  out_unlock:
> -- 
> 2.42.1
> 

-- 
Chuck Lever

