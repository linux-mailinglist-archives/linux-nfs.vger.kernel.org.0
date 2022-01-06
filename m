Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90770486304
	for <lists+linux-nfs@lfdr.de>; Thu,  6 Jan 2022 11:37:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237899AbiAFKh4 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 6 Jan 2022 05:37:56 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:29320 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232212AbiAFKhz (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 6 Jan 2022 05:37:55 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2067Xs6s020263;
        Thu, 6 Jan 2022 10:37:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : in-reply-to : mime-version;
 s=corp-2021-07-09; bh=e/blLMeWNHG2vli9uM2u9jGqUHAzFUPmvM3ngA8k8kQ=;
 b=shRfJHkbJM6fgEnuBMGnmnIRiPN6wtd8v9fB0ILlLDtGOv/zdCigBejk3bjbQY8ERASL
 yvhPxNwWATqUtteJgt9DIc5QCJDUSdc8akZCK67A6+/E4XR+bLDuPF3MumkY3X16LB2E
 26Sc8EuO/fg5q13rDGNdfKl/33Tw47bDd/32cqWdPDAoA8r0Zu5XnusfrEkWC333QXvL
 ev9NQfXbf4kI4gp4YYzvyi4je4P3KRLuTo26B6aJ3fHaTsV9sGc/COVF9GdwqeTpowkL
 kBLpeqD5xlG30Ok+J/YhgHF5h3mPV7xdOaPw2sd/14G4NDqdBfAxdr91PY+hKtbicwyC Gg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ddmpdhc3e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Jan 2022 10:37:43 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 206AUDWf019400;
        Thu, 6 Jan 2022 10:37:42 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2176.outbound.protection.outlook.com [104.47.55.176])
        by aserp3030.oracle.com with ESMTP id 3ddmqhdrtc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Jan 2022 10:37:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VhW2TaEED+p8616B6xwSs/kmfs4lR1HtTdu2ONT1p5ms2hvSZAKt5v+Y8plRPojuC9BsD82FMYIkP5ekO7iXG4IzyZRHQbRkbbuj5CpRfpAx5XWiWA/cfoIbgF1nZrrvKZZZJ0u97o93mxjDdC6KKhUnjhmqlvRN1MXPT49PvBcJm2kb9/GULnQdwJWrfnUbyW2VWR6ynQ1zTKSrXZrGYDA7sM7HMIoMMjIWrHDZqEf4HsPgTETBJmEzi6/48mfL32PYIaVJMdh3u++vMkF0Qo2t9W3Enayp+6s+/7j5ST3K7+4cSey7nPG664MfcygI3TxJ7yn2HNLFMtz24SSXGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e/blLMeWNHG2vli9uM2u9jGqUHAzFUPmvM3ngA8k8kQ=;
 b=MRaTiIxg8RmTBp5j61dZOGxdv+CQNf1ybP1SJouqjoAQN6IabMTjb3sR/7kWyOiI5XXnFCzxphxO5MNW3D8YPeXDrE5JaFixRW16CEfibqX7gDzOX8goi4AKwvHTKkYAML8k/DtlGz69TZjYOSss6eu/n5bLSmxFRLMUJorRm5Dn30FnhgUlO/Zwo/agLU9TF/Xzx+28tKiGWuUguFE0u7+FBud36e5b+MdxhknbBN/nAn88x1F0GSzi4I2AZ+sUk1TVx5aB5b686H4hMuMkeRwIRilUlnd9ZWZAitXWlpwazI/JuG6zWljPHL9r4BdxTE9+i0i4a0KNdN8zmfkqwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e/blLMeWNHG2vli9uM2u9jGqUHAzFUPmvM3ngA8k8kQ=;
 b=jvNZz8R9+m4dAIXVRFLXJeMSLmdzYQShPJZSt/4vK6F/rISnQOMlep1VxuuX3tLtTu4eARZIl08uJKCFchmCQtzND3471qyOQYQR4Xg5HVjMTIWOq24mKmrFeb8RjCFVn07vjIjtS+dc9nvpHxptI696zsEfq+/lslI3kP2Q82c=
Authentication-Results: lists.01.org; dkim=none (message not signed)
 header.d=none;lists.01.org; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MW4PR10MB5727.namprd10.prod.outlook.com
 (2603:10b6:303:18d::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.15; Thu, 6 Jan
 2022 10:37:40 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b889:5c86:23c0:82b8]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b889:5c86:23c0:82b8%4]) with mapi id 15.20.4844.016; Thu, 6 Jan 2022
 10:37:40 +0000
Date:   Thu, 6 Jan 2022 13:37:19 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Vasily Averin <vvs@virtuozzo.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>
Cc:     lkp@intel.com, kbuild-all@lists.01.org, kernel@openvz.org,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nfs4: handle async processing of F_SETLK with FL_SLEEP
Message-ID: <202112281638.RNX7e40X-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3a2c6cb9-abe7-ab32-b11c-d78621361555@virtuozzo.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0067.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4f::13)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d4f150ff-8ca6-450d-ee6e-08d9d1009007
X-MS-TrafficTypeDiagnostic: MW4PR10MB5727:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW4PR10MB57277BF68B158101EC86195F8E4C9@MW4PR10MB5727.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1265;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q3ND6zBUmLcKi5J2ueqZMQtGNbszc4eIRyVsmSs36deMYRdDwJ7FBd8BcHaZhlWPSKSGuM1i3eHma3D/frvSTBKPnOpwDRS0WlWdrXE7/+q68uF4G9M9ozVJcACiJW7iUn9TwQwebuGNa9ZiRHMIbOw6HK2zOmjWGk3BWhDNQ7AaOh6U3iucN1VwMzgb/GTmVKAvi92hpGCCXaaR4R4J7bkXZFI8Tn7cdFtb44Cz+dY7jsXhxaK0NAXrz5RbYHVeHbjMKZoAPH5njRnkHBDi9wD3BtZjpJFKoXOpOhUvb61JqTm3HkBDjvJgsyTBMB2TDrcsw37OivH42GwNw6Vag9FWwEoYvcldRcgWVMlyfkVlD3KtpWE4tnDPbjX9WY1eDMF0XOyx0xOMf1qdE/1HhYbxtRor4kzlJL926JiiSmXYgBBk3K2nC3vCbXrD9YytWKtcbj65M4HhZphk/uTE234rGpG2kQxCZmI13mDCCYsUbqVlcV5DUov54/7B71aAfhUCsUsvxqxJuToepcMs9L5xcqSEDE+Ql2ei0bdfGytDHrOOFK5MAncGPNAUN1v6YKkgBRz6tChHMpf4f58jRi0umc3c89X5PcxEfrk0GeJbbbLmUttaVloSaxdvV3T2mtYu6TnClk2zN0Bsg0kJtaXTlGpq9mfMXuaIONhwf1ZOHgOTbXMc4nv3TydqT0iwmhJWcDZAx8Hdx5Uq/w1DX61CebBfdzaJ7ypjM02dlaJDBR3YgCyilKxylnEC/fuSR0nPms0RGANuywlxipoNxk1LmjeupSSpE2ni2dyv1q+BphgmtEjKhmYzYTCMg2QdD9ZnX1n2ZNZkSShssCGlcQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(316002)(36756003)(110136005)(5660300002)(6666004)(44832011)(6486002)(66476007)(8936002)(52116002)(186003)(66946007)(6506007)(9686003)(8676002)(6512007)(26005)(83380400001)(4326008)(508600001)(38350700002)(4001150100001)(966005)(38100700002)(1076003)(2906002)(86362001)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5hiFoJt2XaFPDJ7dxER9tMGspD/3R8wlitx3hfPHpdxmZk5rChnFEiDGCfHm?=
 =?us-ascii?Q?tOXZ7kl+WLrU3v9T+x/nNWeTJY9ZyRRiBSb3Ixor6wyDhlNSvQibG+IY6mRn?=
 =?us-ascii?Q?3l/Y1kNgNG29wdxbxCiJ83+kXO0yFZa2drGSJxzL3WM1IgVTYnkskrGbr+bQ?=
 =?us-ascii?Q?nvWO60xv5zr/pm50qjP227zo10kHWEqNDH1mM8+umS/oKirhjAKtTAGbwKzc?=
 =?us-ascii?Q?9MTFnG/N6itoKbX0ElXwfN6yglHYhcKBsuEEWgpwuUk/5fpZZgGmwpk7Sgt0?=
 =?us-ascii?Q?7+QlqH0bD22czEy6qiBvGSegZVyvT8cUBDM/tOUdugaubYdhxMxRs/neqgZZ?=
 =?us-ascii?Q?dkM97xiN/QArSbD9EAD0IhHzb+Z9l+79pu48g6J6+pZ0xvgWOyR/SNB3BUS4?=
 =?us-ascii?Q?2whE1jP5h3xCF53kjgd3SJWM2LujeRl0qxWkCcKqOtEks7cx44YBpH4mwRQ4?=
 =?us-ascii?Q?uSVdufGVl9g2vNVbAT/WPT4MDd8N1thRzC675/bzFcpobu0z5Q8Ntji/rTZP?=
 =?us-ascii?Q?b2FkNFiDxbkKmYHWOXoWeRuDljnGAQeIUQvyAtytpRpzmJ6NAC5duA9KPyGA?=
 =?us-ascii?Q?gKqKiKD4yQv9vfylxBrI7jMVDLvPKQ+sBvQCHJKTmBioWtYmUhaciTfo7MTc?=
 =?us-ascii?Q?hG2o3E/xXQ7tUauyLfpQ3fJgPWNShU9Z6segEv6BlhSzRvaHd3BM9LwehHfb?=
 =?us-ascii?Q?RTcMA01LzgTfJP/KnvqWTlwtyLKgKd56vJCVici2Zn0Eh6qWi7YasYRhDWlo?=
 =?us-ascii?Q?HQZGQSi9DroN2I8VRpz87fOaK43wpUk/jQ6Y9xLVJVYC3mCIE2wyDs7S7exd?=
 =?us-ascii?Q?pWqs0zv720hVCQGaVgEEpVh6yPsEXoP6GxNJP0bQVLz/RduXcWVz4Aaiw7yM?=
 =?us-ascii?Q?2CJbgWHm1GGYwFiozf6mg7sOCIOOI3jOHSkASjvoWql1QoKVilELRa6cYhHV?=
 =?us-ascii?Q?Fj0PtCA2iMsQAJpHha/la4jO3Zlu4R9TBt6IfBgEj68Fimypw1dxiae9IEWa?=
 =?us-ascii?Q?Y+8feRIwp9FJ+dM8Xbz2LXdWBX2ZhGl1j4SAt6tpBtMwJ8HZH9Dy9585g6oS?=
 =?us-ascii?Q?hHQnsRdKp+Y4R7+Oas89Q9DEG3kWepMn842GYnibBlRG7PtOollM/dWJ2Hwh?=
 =?us-ascii?Q?8kfA1w2FQ0m3Rxpkw7Hry9BJujURy5JsTwQLZPdXjqPMHq3alSVwV+88iQ6N?=
 =?us-ascii?Q?fR+kWbdbajse4lGSEdNRjWElT8cHa4uEKWREYc+ZjQMLEbxLdMFlk3h3oqFE?=
 =?us-ascii?Q?RIqQ6rzEf32YW9xX54BAhJpwoVnb2GMKTtuG+uemJehKZvngS1WvSU8og124?=
 =?us-ascii?Q?qvCsVXmLG7ELYplJFXa8/LOm?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4f150ff-8ca6-450d-ee6e-08d9d1009007
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2022 10:37:40.0029
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kIKdMfaavLya+SFnSoSI4MYM/+08zCCGR/Yil0c/ecLkGWdasCSYggfZkuXho9r+y68FjKUPXdB5ihYekim/dYDI7Unu8eB0S9bhzbXy64s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5727
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10218 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 adultscore=0
 mlxlogscore=999 phishscore=0 malwarescore=0 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2112160000
 definitions=main-2201060074
X-Proofpoint-ORIG-GUID: wCzcYIy2GGKuOQnqhl13QfjsN_9kPy1Q
X-Proofpoint-GUID: wCzcYIy2GGKuOQnqhl13QfjsN_9kPy1Q
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Vasily,

url:    https://github.com/0day-ci/linux/commits/Vasily-Averin/nfs4-handle-async-processing-of-F_SETLK-with-FL_SLEEP/20211227-184632
base:   git://git.linux-nfs.org/projects/trondmy/linux-nfs.git linux-next
config: i386-randconfig-m021-20211227 (https://download.01.org/0day-ci/archive/20211228/202112281638.RNX7e40X-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

New smatch warnings:
fs/nfs/nfs4proc.c:7202 _nfs4_proc_setlk() warn: should this be a bitwise op?

vim +7202 fs/nfs/nfs4proc.c

^1da177e4c3f41 Linus Torvalds  2005-04-16  7194  static int _nfs4_proc_setlk(struct nfs4_state *state, int cmd, struct file_lock *request)
^1da177e4c3f41 Linus Torvalds  2005-04-16  7195  {
19e03c570e6099 Trond Myklebust 2008-12-23  7196  	struct nfs_inode *nfsi = NFS_I(state->inode);
11476e9dec39d9 Chuck Lever     2016-04-11  7197  	struct nfs4_state_owner *sp = state->owner;
01c3b861cd77b2 Trond Myklebust 2006-06-29  7198  	unsigned char fl_flags = request->fl_flags;
1ea67dbd982827 Jeff Layton     2016-09-17  7199  	int status;
^1da177e4c3f41 Linus Torvalds  2005-04-16  7200  
01c3b861cd77b2 Trond Myklebust 2006-06-29  7201  	request->fl_flags |= FL_ACCESS;
7ae55d384b2f33 Vasily Averin   2021-12-27 @7202  	if ((request->fl_flags && FL_SLEEP) && IS_SETLK(cmd))
                                                                               ^^
Same thing but for nfsv4.

7ae55d384b2f33 Vasily Averin   2021-12-27  7203  		status = posix_lock_file(request->fl_file, request, NULL);
7ae55d384b2f33 Vasily Averin   2021-12-27  7204  	else
75575ddf29cbbf Jeff Layton     2016-09-17  7205  		status = locks_lock_inode_wait(state->inode, request);
7ae55d384b2f33 Vasily Averin   2021-12-27  7206  	if (status)
01c3b861cd77b2 Trond Myklebust 2006-06-29  7207  		goto out;
11476e9dec39d9 Chuck Lever     2016-04-11  7208  	mutex_lock(&sp->so_delegreturn_mutex);
19e03c570e6099 Trond Myklebust 2008-12-23  7209  	down_read(&nfsi->rwsem);
01c3b861cd77b2 Trond Myklebust 2006-06-29  7210  	if (test_bit(NFS_DELEGATED_STATE, &state->flags)) {
01c3b861cd77b2 Trond Myklebust 2006-06-29  7211  		/* Yes: cache locks! */
01c3b861cd77b2 Trond Myklebust 2006-06-29  7212  		/* ...but avoid races with delegation recall... */
01c3b861cd77b2 Trond Myklebust 2006-06-29  7213  		request->fl_flags = fl_flags & ~FL_SLEEP;
75575ddf29cbbf Jeff Layton     2016-09-17  7214  		status = locks_lock_inode_wait(state->inode, request);
9a99af494bd714 Trond Myklebust 2013-02-04  7215  		up_read(&nfsi->rwsem);
11476e9dec39d9 Chuck Lever     2016-04-11  7216  		mutex_unlock(&sp->so_delegreturn_mutex);
9a99af494bd714 Trond Myklebust 2013-02-04  7217  		goto out;
9a99af494bd714 Trond Myklebust 2013-02-04  7218  	}
19e03c570e6099 Trond Myklebust 2008-12-23  7219  	up_read(&nfsi->rwsem);
11476e9dec39d9 Chuck Lever     2016-04-11  7220  	mutex_unlock(&sp->so_delegreturn_mutex);
c69899a17ca483 Trond Myklebust 2015-01-24  7221  	status = _nfs4_do_setlk(state, cmd, request, NFS_LOCK_NEW);
01c3b861cd77b2 Trond Myklebust 2006-06-29  7222  out:
01c3b861cd77b2 Trond Myklebust 2006-06-29  7223  	request->fl_flags = fl_flags;
^1da177e4c3f41 Linus Torvalds  2005-04-16  7224  	return status;
^1da177e4c3f41 Linus Torvalds  2005-04-16  7225  }

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

