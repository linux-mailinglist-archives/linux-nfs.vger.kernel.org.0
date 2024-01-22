Return-Path: <linux-nfs+bounces-1240-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAD5083655A
	for <lists+linux-nfs@lfdr.de>; Mon, 22 Jan 2024 15:28:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A1A5280C04
	for <lists+linux-nfs@lfdr.de>; Mon, 22 Jan 2024 14:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1D2A3D38C;
	Mon, 22 Jan 2024 14:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DWxRQ836";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="KeJ6fpim"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61C343C488
	for <linux-nfs@vger.kernel.org>; Mon, 22 Jan 2024 14:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705933695; cv=fail; b=JP5EvE8+eCu38syB4oc+XP6sd1tG5gL7XjhzezmiTmERZ/TbOL09P24gnNGyXzRbzUFL8qUPoZZD75t3omnIiUXcn8jnFQZR4sKSDKrOFe4VHSK5l9vEQTb0E8+tlg3urnj7hQh/4I8MDtWl38m+GWWPYh//FenTVAGE/kxH9r4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705933695; c=relaxed/simple;
	bh=R0O5h5NGOSKDgsYoD+6fGqYKkYv9memHTGy9oO/g2ZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=BbqaLcPAQLSVQgMn3Uhl+5Fgmws2P164naoA4t9IVbBHtc9jyAHWOA2wqf0vJH/xT5zu8Wj79HmWlNbmdI+2eWWdK8kMbQrMxkhmgwTOhsuFQWK9bjUGdpsVMY7xhtuwZk47axbJP95czDgxKnEzO6McD3c9y8Bi/kOM3EnQLe4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=DWxRQ836; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=KeJ6fpim; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40MAZTom002662;
	Mon, 22 Jan 2024 14:28:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=2bpWr/X7rWwwmzTeHfmxa5ZTavww7zW26Ps39cGpniw=;
 b=DWxRQ836FmFpStD11xd83CJjH4kqkR3fCpHhq8DZDkOit802YoIdzUYewhpSuT/SQfYK
 8j/DFVG96yjZiY+EiLZlMjXT1I1CJ0GIWtS3vDuqZHB/ykM6WpsB7M1Sw49bcPyBX2y7
 jYGrZIBOVt+1+pSUXeOH1f54LbstN37F7Ub5T7moi6ECS4WUFjR+u8Hi1PKQd1LX0NJm
 lUaf0Rb47sYvcXemFiiXthGJduCL4+ZbkiIasefH8FwHl57dXmgFk7F9WSUiL7dD7m6u
 2IhdnrEQUJCYKaPJTSLen/pdvsUS5SQuGUIASrk9+ZFtB26rmk0T54PxO8Md5OOhM2RB 4g== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vr7cukqy5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Jan 2024 14:28:01 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40MDTG5R004905;
	Mon, 22 Jan 2024 14:27:59 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3vs32p80v6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Jan 2024 14:27:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U56cDOhs8bGZnS7JjN4s2iP0/60Yl0ZXnr+pk4Xfd74gAJFwz/IqT+nueU32dG9DvpYZINEd1+whYa/Oy2J+RDeNRBnIUVVpNQkSlUkG9p/1kGJe8u4wsR43aQY8ImC7VKlfx3/VqgwKn8d/8wwv04kVOEzhIHtJAVTswxsamMGRfQagqUT4wwDSmE8OsM4VHtkjaRzrJ6XlIReIcjR2vQuyXuZzpxJtiIiFWVmCQGINZfDwtFbT0LPF5NjpDUb0WpCHxeQ8FB5gmJZlMQw/xU93l/a05SFDu6K3zf7LRVSVZ4QdczvznN+Gsf2SCJnf52Bgcor/+hZHMFU872eqPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2bpWr/X7rWwwmzTeHfmxa5ZTavww7zW26Ps39cGpniw=;
 b=OVwwa07RC79abqbITlflAfHYEKt3jM7XaGIjmySH85KJO+w+kdaG2SF34Z/sYKNtT0/cE8iV3vT8vjJBkOKXC0OHYOABYnWzu6IPc7/nXGWv8yhaw6Z7DvTAA4/KJ/uKkShHpR9M+czSoVAla75YZHa30WpAlWpVy3MoghA/pcm4iVpQE6TB5UZbHdFrBTZFamZzTtuoh86s51QJQd8YxnTggAn5yljHuvS8/2bSHrXW2Y4jfxEc5pC21d2JNQ+XCIzL9AVfuZ3sg0TvuPiNh4x+rH46DkEs4B7AF3y7am6ueG7/RgIwJlPBrldj/yoGwjAl4ur6f5NQmLvo+sgrEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2bpWr/X7rWwwmzTeHfmxa5ZTavww7zW26Ps39cGpniw=;
 b=KeJ6fpimrVJqH/4IUhu9PFn7dSNopc1shPddWmSJcLHFfpCqnKjB0TPnMjxUKGyYF9SICdvsROT+AXoVvVOa96xdUVeAVU9KmEor9n7FZ4s8UUkfnz7yDNkEp+MWDqmSw4ShvLuZgWfaDERcLqKcdoUIFon5bsz2Q9icgG0Vrxc=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BLAPR10MB4898.namprd10.prod.outlook.com (2603:10b6:208:327::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.36; Mon, 22 Jan
 2024 14:27:57 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5475:bf96:8fdf:8ff9]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5475:bf96:8fdf:8ff9%6]) with mapi id 15.20.7202.035; Mon, 22 Jan 2024
 14:27:57 +0000
Date: Mon, 22 Jan 2024 09:27:53 -0500
From: Chuck Lever <chuck.lever@oracle.com>
To: NeilBrown <neilb@suse.de>
Cc: Jeff Layton <jlayton@kernel.org>, Dai Ngo <Dai.Ngo@oracle.com>,
        Olga Kornievskaia <kolga@netapp.com>, Tom Talpey <tom@talpey.com>,
        linux-nfs@vger.kernel.org
Subject: Re: [PATCH] nfsd: fix RELEASE_LOCKOWNER
Message-ID: <Za57adpDbKJavMRO@tissot.1015granger.net>
References: <170589589641.23031.16356786177193106749@noble.neil.brown.name>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <170589589641.23031.16356786177193106749@noble.neil.brown.name>
X-ClientProxiedBy: CH3P221CA0024.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:610:1e7::33) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|BLAPR10MB4898:EE_
X-MS-Office365-Filtering-Correlation-Id: 29edb409-b080-4ce3-eff6-08dc1b5653dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	5fzKbJtGcqX+zUXGs76c51xabG39BXFnGHPJKXIrfD+fLW4BAdYQNjpEwxJ+qE0zilUiPH9w4ByQLml8ZHurXQ2AcYv4u0icBDUv0fxX04d33r9Bvlci4eWDRXZucyuKlN4RG4Bw5gULqbgPJt4IqJJ+aW+JLG1u2pDIN9Fvm+gTOTay8my48JL9UeQGXyx+TCWZ/E99sZDaoZ2COgftCxO9X/AoJlBFBtlHmrpZJPcyZB0JuV9cpQFiP6UBZMGeCb9SPlc92fXmv82E9vkibwVbC51fP1DqgPrSlR83Xp7drxh6YiI+VOslLTZ+yTT9PKfnNQbEJcscBgXM3qZuucDR+EIFpyewIZlv59VZYKU07dx4Zp+hZjYP/MTHo5Ymzl+HnwP1vRWGik1SrG4FA0eaNyZwi2w7Qp2i1C5eFxPEjQYDbcrfxx+Hay4wTOJExccK/29A+Js/tySp/wgQuylbojGimOJ+fnnIOGFL6weUMIUqgJjOxIaF8FcSdVJZ3aLUhMgqXMtQ3bYLCxD/p+v+vw5QiPLNuJNVsiH/w116+Y7Or3Qh08+l+ZUiaVRp
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(136003)(396003)(346002)(366004)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(6666004)(26005)(6506007)(6512007)(9686003)(83380400001)(478600001)(5660300002)(2906002)(44832011)(41300700001)(66556008)(6486002)(8936002)(66476007)(8676002)(4326008)(54906003)(316002)(6916009)(66946007)(38100700002)(86362001)(66899024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?jzggSwlJN80pDcpCZAxX9QPVuiGSbAmkAeuEn2VhQ+iVsHlOFLZ5K2Ya9Jrv?=
 =?us-ascii?Q?N3eYH1ceFEMMGMRponcagaHIKzH6VA9SGF/ZQjcFLBV5QkMWCc80qN+aJkjC?=
 =?us-ascii?Q?ysYXq8PQklnAtAY4ldd/wHhNVLHhW+NxqanfrluohMV5Bmbesuv13nZA8ZU4?=
 =?us-ascii?Q?iWPgWAAg2Md/Zu3AEl5SayEs/QNu3xfABNVLJAygMpkk2tuDPWwNuW62dwLh?=
 =?us-ascii?Q?5appA0uhEDjVfZzB6/nBTuoYoEkZLH2Vgjex9yrYkrIh3Qmg2xZ9N6DYiqwY?=
 =?us-ascii?Q?iniKbs08cdMpkFBxJLAdcV56RoEGZgFiovcGDD6MFEXKY3tf2fpmzE+YvSey?=
 =?us-ascii?Q?s5DjQXH4pzVGl3UrXrXiz13LdKmtN18L83MVdRPv4Srac3wVJ15xe109Lk1K?=
 =?us-ascii?Q?Ugr44dLbn08nH12wszN5gjTZZ96TX0CKsJMBcmN1m/xo6gwzEYK7Ne8dKxXs?=
 =?us-ascii?Q?atZlHoE5H9+P6N51kyJvS/TqsztESHXKIOLBM/9mZywAMFg2OVddrDDlZVtg?=
 =?us-ascii?Q?G3pXQ/q+viyHYPOQWPT9nH4OehzuOEJflW+417yXIIl/X5dKIVO8EHRbOmIv?=
 =?us-ascii?Q?8mqGbd/8UxGHT2Y330B/BB9zlhs8rTV8UMcElFyz4M0DvwNIyGeOzfi6FQmx?=
 =?us-ascii?Q?hVL0QoRNPmA0HQVlQhqohH/66uBLrAUgjLsIulHLMv0QGVFaW1G2+vyFfeS6?=
 =?us-ascii?Q?H9k9ynz+UmYub3ZC6PsxJ0+6qEsTqah8UmG6E6aZoFQpGcjfmbh2COB3C6/L?=
 =?us-ascii?Q?I1+yNpd++S8U8HRWP/nL3zZeXu+ufpXro7w9rCnRfxubFHEMDiMW0XtwXOil?=
 =?us-ascii?Q?ssVpWOjSEFCDJViLCUYYXlnlYvy+IoJBrPDJ797D190qg+nXjsgkekU8Mmo5?=
 =?us-ascii?Q?3dlUyoE7AtQW9MT42keC7mq8Q++ibnff9EOvaZiG9UPnhM76AOxr7bmIs4V8?=
 =?us-ascii?Q?N6rhuD8mMUAxEL3VVBF10pV4dp8k59Hv3BWlytvp1bb7/u7Sp4PWbOQxIS+t?=
 =?us-ascii?Q?iRHhg2RpECoZ1zhCKaPwTSm9vRJb4k3vpurW/DWebIQzXsZSv/E01kN1ofjk?=
 =?us-ascii?Q?GOGOfuQXpiBTmQ9VV+4BNrEKm9yKhvlz6x7ZibpldD7jidTY/Oskbsjd7hV9?=
 =?us-ascii?Q?2Iw7s0ueyPbWxWFaXfJWlNC9ZoxXqVW+YI4mbtfqpcspvMrl8uIZiU2Jc/ow?=
 =?us-ascii?Q?Yk1oEyHVVzj9NaVNFieDaBGMCqVIUxMq0Z7ji4DpXk3A6wAbDX93t4ZgjGRS?=
 =?us-ascii?Q?AGNWwmKN8GNuiKRioGWeZCN+usZvKM2F0p4NwrFjf+PwhV0C0IjcjgBkZxAX?=
 =?us-ascii?Q?+zXIfo3es5XI+LYa5gXGOPXQavP7Kae7V94SF/fJGoACOFDuHhpjcBwQ9rYA?=
 =?us-ascii?Q?PUp2w9M7LyYoQton3eY5b66eV36taZPJwVRRKxrlnqkYRS4DJPvNwd5FW489?=
 =?us-ascii?Q?4Qjl+zxWr/4TwyYD5naoaHX2vLky9LxhBN+jMfUFF49jDibC3hE2XbzKs7Ed?=
 =?us-ascii?Q?hUbMFpipjtI/i8tiF2zF10FZ7dIzbWgS93QyFQrgU1+a7N2HJIG1f9onaAnD?=
 =?us-ascii?Q?fTvN5fe2udUjz+2pGxOwczmgQ9mViSygyIXf6QDhlNk5sQcptOK0btlNVJP1?=
 =?us-ascii?Q?zg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	RDhzialYMzNBD0Mwr/AEgcyyLnR8jvHnv34341nGXUQFYZDYalFjAxHZ+UFp6DV4CPRwVbnRQvDHfhLvVsWlwRjqXgYuN7ZqgY10sHalDQB+6XIGoGGHMdac789H3Wa5WPMLE3Cfo/NBBp8NCqIPCEb2JCC8dm1KEwerYu2sjB6uCH924YP3RqX/Mv7iO9FaBS4lAT+3dfUXlpPih3KXMZQsg5M+teXy0zqdM5FwdZad8a9yOjOzzqkXGN8H+vnDiEY0wls7Bp/cKP6OVnR9i0KNvKLD50Kq3zvCCdptbjUNoJEe8RKFADw+8CpMf57xYEp8HUqDG+GMLTzqyoVsdkOsq2dqXam8W5EcyqffTmAqv/wzhsMWw5wDv+LjnIe6WngXZ3wIf5lQaBWlIzGcitN3vA16YmHAPOWAAOpENOVi3h/+ARlW1+xih8j+jfg/rSHmkAiyyFQeV1BffwdwGbwU+WEP68Y4igoR7/vnL31sa3c9h8maschLzCO960n+Fanmd+ivovta5MgumI8mdFD5MYHntfIPicSX0E/SmeRuo3bTMTKn8r28iMScOoveHtkihS7rfcqN9dbU9kKRiAQGKzHuuGFrKm1gThbbmqE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29edb409-b080-4ce3-eff6-08dc1b5653dc
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2024 14:27:57.1108
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NUDrhfYm4IxUYgbzxlm8oelS3MeAFxJneqISRblNyxMkSEojrWBRdSuKxH+O2xOVTOoS/jqurNJThNk4AyKH9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4898
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-22_05,2024-01-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 spamscore=0 mlxscore=0 adultscore=0 bulkscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401220097
X-Proofpoint-ORIG-GUID: SJ3JAfXrHs96M5cBx4dgwZNt1BzJNKCU
X-Proofpoint-GUID: SJ3JAfXrHs96M5cBx4dgwZNt1BzJNKCU

On Mon, Jan 22, 2024 at 02:58:16PM +1100, NeilBrown wrote:
> 
> The test on so_count in nfsd4_release_lockowner() is nonsense and
> harmful.  Revert to using check_for_locks(), changing that to not sleep.
> 
> First: harmful.
> As is documented in the kdoc comment for nfsd4_release_lockowner(), the
> test on so_count can transiently return a false positive resulting in a
> return of NFS4ERR_LOCKS_HELD when in fact no locks are held.  This is
> clearly a protocol violation and with the Linux NFS client it can cause
> incorrect behaviour.
> 
> If NFS4_RELEASE_LOCKOWNER is sent while some other thread is still
> processing a LOCK request which failed because, at the time that request
> was received, the given owner held a conflicting lock, then the nfsd
> thread processing that LOCK request can hold a reference (conflock) to
> the lock owner that causes nfsd4_release_lockowner() to return an
> incorrect error.
> 
> The Linux NFS client ignores that NFS4ERR_LOCKS_HELD error because it
> never sends NFS4_RELEASE_LOCKOWNER without first releasing any locks, so
> it knows that the error is impossible.  It assumes the lock owner was in
> fact released so it feels free to use the same lock owner identifier in
> some later locking request.
> 
> When it does reuse a lock owner identifier for which a previous RELEASE
> failed, it will naturally use a lock_seqid of zero.  However the server,
> which didn't release the lock owner, will expect a larger lock_seqid and
> so will respond with NFS4ERR_BAD_SEQID.
> 
> So clearly it is harmful to allow a false positive, which testing
> so_count allows.
> 
> The test is nonsense because ... well... it doesn't mean anything.
> 
> so_count is the sum of three different counts.
> 1/ the set of states listed on so_stateids
> 2/ the set of active vfs locks owned by any of those states
> 3/ various transient counts such as for conflicting locks.
> 
> When it is tested against '2' it is clear that one of these is the
> transient reference obtained by find_lockowner_str_locked().  It is not
> clear what the other one is expected to be.
> 
> In practice, the count is often 2 because there is precisely one state
> on so_stateids.  If there were more, this would fail.
> 
> It my testing I see two circumstances when RELEASE_LOCKOWNER is called.
> In one case, CLOSE is called before RELEASE_LOCKOWNER.  That results in
> all the lock states being removed, and so the lockowner being discarded
> (it is removed when there are no more references which usually happens
> when the lock state is discarded).  When nfsd4_release_lockowner() finds
> that the lock owner doesn't exist, it returns success.
> 
> The other case shows an so_count of '2' and precisely one state listed
> in so_stateid.  It appears that the Linux client uses a separate lock
> owner for each file resulting in one lock state per lock owner, so this
> test on '2' is safe.  For another client it might not be safe.
> 
> So this patch changes check_for_locks() to use the (newish)
> find_any_file_locked() so that it doesn't take a reference on the
> nfs4_file and so never calls nfsd_file_put(), and so never sleeps.

More to the point, find_any_file_locked() was added by commit
e0aa651068bf ("nfsd: don't call nfsd_file_put from client states
seqfile display"), which was merged several months /after/ commit
ce3c4ad7f4ce ("NFSD: Fix possible sleep during
nfsd4_release_lockowner()").

Not having to deal with nfsd_file_put() in check_for_locks is a Good
Thing.

Am I correct in observing that the new check_for_locks() is the only
place where flc_lock and fi_lock are held concurrently?


> With
> this check is it safe to restore the use of check_for_locks() rather
> than testing so_count against the mysterious '2'.
> 
> Fixes: ce3c4ad7f4ce ("NFSD: Fix possible sleep during nfsd4_release_lockowner()")
> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
>  fs/nfsd/nfs4state.c | 26 +++++++++++++++-----------
>  1 file changed, 15 insertions(+), 11 deletions(-)
> 
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index 2fa54cfd4882..6dc6340e2852 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -7911,14 +7911,16 @@ check_for_locks(struct nfs4_file *fp, struct nfs4_lockowner *lowner)
>  {
>  	struct file_lock *fl;
>  	int status = false;
> -	struct nfsd_file *nf = find_any_file(fp);
> +	struct nfsd_file *nf;
>  	struct inode *inode;
>  	struct file_lock_context *flctx;
>  
> +	spin_lock(&fp->fi_lock);
> +	nf = find_any_file_locked(fp);
>  	if (!nf) {
>  		/* Any valid lock stateid should have some sort of access */
>  		WARN_ON_ONCE(1);
> -		return status;
> +		goto out;
>  	}
>  
>  	inode = file_inode(nf->nf_file);
> @@ -7934,7 +7936,8 @@ check_for_locks(struct nfs4_file *fp, struct nfs4_lockowner *lowner)
>  		}
>  		spin_unlock(&flctx->flc_lock);
>  	}
> -	nfsd_file_put(nf);
> +out:
> +	spin_unlock(&fp->fi_lock);
>  	return status;
>  }
>  
> @@ -7944,10 +7947,8 @@ check_for_locks(struct nfs4_file *fp, struct nfs4_lockowner *lowner)
>   * @cstate: NFSv4 COMPOUND state
>   * @u: RELEASE_LOCKOWNER arguments
>   *
> - * The lockowner's so_count is bumped when a lock record is added
> - * or when copying a conflicting lock. The latter case is brief,
> - * but can lead to fleeting false positives when looking for
> - * locks-in-use.
> + * Check if theree are any locks still held and if not - free the lockowner
> + * and any lock state that is owned.
>   *
>   * Return values:
>   *   %nfs_ok: lockowner released or not found
> @@ -7983,10 +7984,13 @@ nfsd4_release_lockowner(struct svc_rqst *rqstp,
>  		spin_unlock(&clp->cl_lock);
>  		return nfs_ok;
>  	}
> -	if (atomic_read(&lo->lo_owner.so_count) != 2) {
> -		spin_unlock(&clp->cl_lock);
> -		nfs4_put_stateowner(&lo->lo_owner);
> -		return nfserr_locks_held;
> +
> +	list_for_each_entry(stp, &lo->lo_owner.so_stateids, st_perstateowner) {
> +		if (check_for_locks(stp->st_stid.sc_file, lo)) {
> +			spin_unlock(&clp->cl_lock);
> +			nfs4_put_stateowner(&lo->lo_owner);
> +			return nfserr_locks_held;
> +		}
>  	}
>  	unhash_lockowner_locked(lo);
>  	while (!list_empty(&lo->lo_owner.so_stateids)) {
> -- 
> 2.43.0
> 

-- 
Chuck Lever

