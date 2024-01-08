Return-Path: <linux-nfs+bounces-971-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF3A4827191
	for <lists+linux-nfs@lfdr.de>; Mon,  8 Jan 2024 15:39:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24F6C281525
	for <lists+linux-nfs@lfdr.de>; Mon,  8 Jan 2024 14:39:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA93747784;
	Mon,  8 Jan 2024 14:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HHGy238Q";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="y2/f12ye"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D741B47768
	for <linux-nfs@vger.kernel.org>; Mon,  8 Jan 2024 14:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 408EOPBA026986;
	Mon, 8 Jan 2024 14:39:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=dJqkUsfhZwmteRxzBwug55E9DYirQnycWnq7vO/Y8lo=;
 b=HHGy238QaAOkwUCSHtH++/kzcElERonFSWxoMuhrdHAvAvte0HYkV36vsmxmRXYXoKn9
 vw1G/iOh6e5VVEstjkbo05M/H6kyiz4Ff6Pi4jZgFpqZchFUV0YLSzjzm6XvI3CDOzXm
 CaHnipbzc/ZPANqUlez2FrXm1SXoSs3Ic93ZaCxJqbIUIBcyITwLRc77ODRwBaOe4fXM
 00mugTbrOQDWQbWxR5aYSCVwTOYgBsPtvpbFpmW+VBgGDhjptkglzPsIHumxXYk/+heO
 teIDoGJxCMOPueMpubuxGdfok51H/6O93vIX+N3F+8mXJ/9j8karyNvQDuLzyLuuaUjJ WQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vgjsd81gu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 08 Jan 2024 14:39:46 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 408DJmMp012097;
	Mon, 8 Jan 2024 14:39:46 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2168.outbound.protection.outlook.com [104.47.73.168])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3vfuwf94k6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 08 Jan 2024 14:39:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nn5YTohcrfo3/tVvm9qtQHCN+auc/Rv9agTfoZyOOE1f97u3PO9cxnycpumuu1UYYGsKhLi/gmsrfS8mzWjPhyrRKCO3db9TJeAFFRwkoQYUvc4mLweqEE7/WoXU14gYiKMjtheDlctjCsZtWhNRUntQtR6O3VR3dtC55cdsfQsWdEmJPpxlkSuOQEsjgVBXBlBE2VH7FnhTIU9gQABt+ysX36UP8zDQiyiWdBxhMs3VZ95IgN4lKvd+FdjmnWY7bIa43E6FD9boe/AgJoOkXOnpVGWmygM5U4W7aj40AdVKqVJ0OX627Gmtu5KbKaA4qMGqrolU6bMdKJJJCUcDcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dJqkUsfhZwmteRxzBwug55E9DYirQnycWnq7vO/Y8lo=;
 b=YWDFiE7aFp5V/0dUZJ7UzFt8KUatgFACBBv4FPXtDjvnwm/c1/lH1k0SMzqUkRNCxLX6yfeySGHfiaWGSjgCoP3Us6I6kcASztH1togtSld31LCEvM4hR9k63gOtVcRqLucRGRVihKJsWZ9duKNdTi5LNffz5qNy1mV0WUKbpiEHZauoNx3+n4UgrBzloQp5i2muNaWCXRFA/ABlDN033ZIaFunA7HBfq2tlgPm8XIFWgkAP5/56mHZluYU3p0dYuNWEusA2WlXb3Inzg6wqP89rcweyPzis+Mxtl80N+FxkhVhmpS/0hPuARKZrG0s1Wibih/zgC45WzEm/EkH2Ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dJqkUsfhZwmteRxzBwug55E9DYirQnycWnq7vO/Y8lo=;
 b=y2/f12yevir4mmqLmWC9lPqgmYW+v6Vij2BSivT4rbDG7kFt8C36VTOUEWcUNyZd8ceTj40ryEB/UCy+35/46V8+TUBzahwnCiSr5wX/6IJ1Buk1P/imxPOk/sKD/DoJVRBGJ9iNJPSBz2v4GKGh/C6eaMUNW8c9FNGaCH6Wnpo=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS0PR10MB6896.namprd10.prod.outlook.com (2603:10b6:8:134::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.21; Mon, 8 Jan
 2024 14:39:44 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c%4]) with mapi id 15.20.7159.020; Mon, 8 Jan 2024
 14:39:44 +0000
Date: Mon, 8 Jan 2024 09:39:41 -0500
From: Chuck Lever <chuck.lever@oracle.com>
To: Cedric Blancher <cedric.blancher@gmail.com>
Cc: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: nfs-utils&nfsd&autofs not supporting non-2049 TCP port numbers -
 Fwd: showmount -e with custom port number?
Message-ID: <ZZwJLb7j65QXR1+K@tissot.1015granger.net>
References: <CALXu0UdFR7Xn51eKFUUi6a68wvDKc-RXz7F4LKyQgDptqfYbgw@mail.gmail.com>
 <CALXu0UfSJ0Qc3HOecf4pQ=VnEVqxRw6OGzNwhh9BUVYaHV7_oQ@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALXu0UfSJ0Qc3HOecf4pQ=VnEVqxRw6OGzNwhh9BUVYaHV7_oQ@mail.gmail.com>
X-ClientProxiedBy: CH2PR19CA0013.namprd19.prod.outlook.com
 (2603:10b6:610:4d::23) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|DS0PR10MB6896:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d2d0233-6552-48e2-4296-08dc1057a77c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	xuwKPu3T+LjMSCkqoT8eAwJcDRC4t/R0M+KEnAEHiTpaqNoiK8xhyv6P6pYSkK1iwHoqwIwjqEdhOZFSfzPcvkAji5iA42339ozaL39JHTYeQztUnR9epI/ofJ04vOZTbIRs+kWE0E1Lpfc/m1AgRacafdZUyWbm3l6+bjJtRipOacp1NYf7nQhoR7lcjMBEuL2lxd/RK+YKnMHTVo20ULarhyB7+k4iikxK948D66xtAamQ9IjDE92EEz9DCl+EOLXMQgnyj3pmzEb4rOOP+dcMvxRji1MUgPtrpBjSuntdnzxTDvaRGE1UOie6zD9gy2x2uT9DDZ8a+NzDCJM3UB0Yc6//jDa7Xi1J8UetrBUs7/jPz7iSrYO4S5RmRf0KTuY4VxsSQ+CtRicXtHIouN9kE74r5ZABq0VSWFKflkYh+OTLlxQf4NXAHf2bFZF8IqiTLi2SuhIwmIg4jLjoG5Vmgaf4U6EbdTXxshy9NtTvPJjMDk344mbl0G9hAFy2qMWwEmuwLi7gtcIGkxazlQbouGGs4DrGmiZXaeEfYjzraltEPh81gPkpdf8wVPowp8nrvhPC10YPrKMa9Xw3EcARz/L9q5vFq8QPtQr02/8=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(39860400002)(136003)(346002)(376002)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(5660300002)(2906002)(86362001)(41300700001)(38100700002)(9686003)(8936002)(8676002)(6512007)(6506007)(66476007)(66556008)(66946007)(6916009)(6666004)(316002)(4326008)(6486002)(478600001)(44832011)(26005)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?LDNkpr6cF2/zVzK3UsuFuVppy1U+/eDvGef/m5Ur+EY3v1dhZ9neo33+Zs8Y?=
 =?us-ascii?Q?lGrZUVaXyvJRJP4PfgPP9drCLyAQ7H+l+iMFSWwR1bFqib6UMB39DElfXJN2?=
 =?us-ascii?Q?jyFjZx8SPmCpMiQMtsMh00kd7KTfWUHaDnFeHFMxFP75MfgNNvFZVmK0Bnce?=
 =?us-ascii?Q?PNRYJtP1PIoDw8cSKVePUv3S/t+ytXUdiOs3k9vPwhaIlXkCIu/Xakk0Ybov?=
 =?us-ascii?Q?HZ/X5pQYqviltOm0ZhUCgf077U6AM69OOoCnXzcubNXE43H56QCjqwigjXMy?=
 =?us-ascii?Q?g9bW1yCMQ1Q63Ad0Tx8f6qlggsade+dbbKweJr6Wuhh+6LAqeuiSovGVcFH/?=
 =?us-ascii?Q?ZngZHxGSmlFEgtHbnpSWFjrsXQ9H+c5xnkyVIVSlWmV88iNwJ+rg3y1PtJ2S?=
 =?us-ascii?Q?LjzD12uKC8VrXJ5OsphgdVzqdcRkSLbnacxAEL3jlavFzduUwutHfBLPBX4z?=
 =?us-ascii?Q?DMfSELuxMgfDNDhO/JNYKi0llbo8T4vwPeMqEWkLmS7EhFprjOje0XkC1VF6?=
 =?us-ascii?Q?8OTb6pOdjAQ3V1S+VMuPtQutR5bnn3A8/gZqrOxsIvUkcrVm5YAwLaqxQSrK?=
 =?us-ascii?Q?jOgJ0ssIU3cRbxTib9CdB6FTMvG1AZrAAV43FzIrIjnon0tk1pgku7P9fa1+?=
 =?us-ascii?Q?Bbk+1ekoj3J5jJ2KmeD1x4rFrPLzbn830iELIzI0ktICcwqEQxk2Z7INTjAT?=
 =?us-ascii?Q?nzmHpkS68NEJ3SF7aA7DuycNTWyk4677mOlHiNdlDibLsP5/A/1jvHfVKDYi?=
 =?us-ascii?Q?NiRtqTpyShMrj7O53/LinqKnyMvw7UEia2P0zN7iKX1Yg6j6yTc96ZodsTAZ?=
 =?us-ascii?Q?Sb1b7H+vhrFs2yIn5QGiqbyUv1WosmY3RPRlhL6tfjLtweLMP8xvx2VeOBH9?=
 =?us-ascii?Q?TTmvvJMvpAYihVx5O8bKrSaWJJ7w375WOWW6a/AN7aOUDeW0qamS63p8jOi4?=
 =?us-ascii?Q?2Vg0noo5VgPqOMsRX6+baZ/XvEIzGsolWgxL0XNyysnlVACvLybKk6qkzHPg?=
 =?us-ascii?Q?5cSgPA7gno/PbsXn/qqesk3eqbwE4AG1k5YhW8DqO9zwE1JTw72YPoZhcyIp?=
 =?us-ascii?Q?1RW2G7eE9s/BlNFdCk7eLagRqWa7CMLcT9GAgwYTJCYJL3LajXR+dALZt5l0?=
 =?us-ascii?Q?j7QSB67DEeaLMZMf020lfTNCNGA/Vh4mC4EXSe2kbFW1vfj3XBSQo/DHoeLl?=
 =?us-ascii?Q?Q6hoi3S7VIoyNBJdhAUUSTttGggjk9Oez1idQsp4th8FuXD/UdK8pD4uLSnI?=
 =?us-ascii?Q?Vt/sGSgelbwaJJCIhx9tRxfI5V7utzumBws7dHwVXYJ7xloyRhshDBHiLryT?=
 =?us-ascii?Q?Qcp++o4iwDa3/4Vz9p4MUrFV3dQyoFf7PZMexCab2XWlxx+Juo08wz36W5hH?=
 =?us-ascii?Q?+cp+EWfnNHaQ0Otj1mNxshncuFZ+JwP0WKFMBVpVgRMgjsYfbaSrD/F2Z0PK?=
 =?us-ascii?Q?AeRH9ZCrBoG8hPAHQHEJzEUb3hTDfVu4j47fkfn/FtkUYhC1OFkkKdjh0r52?=
 =?us-ascii?Q?urzvNRw6KQ3X8eaifRNOyB8lS2NWG36sahnKFHhs3Oa929rPmZVgsXpB7jVW?=
 =?us-ascii?Q?TmOUqfktOIkZfplILP/jsfax+5YPeX15VjUd/Fvn40mheqoOk9HMau3tl8E7?=
 =?us-ascii?Q?fw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	AVxNX4/bY4BIgarab/AKqqLtI55rPNCdGCtU7KJ1Oj1R+QwDFv1FRpp5R6qTLk/TR6XBu5SwHFm1f/Ng3oM0ASIjRI884l4QO4z9ZhjoXGgCBzvL5YZgXozIdJRmWSQleHq2LgZ7byuPYQRktHVs998+n0Xmmjufd38dGeB1XjZLGMx15yOIbdw8dAkm7eCYhTKpEELItbjFLHeMJtz3cwPInNOVos66ojy/l+Wk0Nkj5XP73U3ajAJs6Gl9hEA6oQfESlG+2eaSNZMvQoPprGPS9REzPni8Skh8xbqy22fcH/iNTG4R5vw88bNStcrUHEwQffIAqrK/1rqslMxPZu4x64vm8mK+NCioKaaSIGrlS8v+9enQQ26TqnfzAGMuJeDjmEcEX4LK6w96C4m9tMVHEyZyBHVVN5zLifS3IqCEx9Y2OB/FaKVeOaiNpMQAREeCggRhpjZGow8BhNMALaxOXBA1oSQNxHAV5/FG7xVi0pq4F5Ai2tOI/1EKd1tAISFvRBHl1IyVlUWH5R9UiMOt7CNio3rIZCzpnLCq0wBxvIo+2McmV045efDqFbQqkkXcyLaNPOj9TcqZB/5D9Dc6/3kQ0ciaSgVFDIqqCAE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d2d0233-6552-48e2-4296-08dc1057a77c
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2024 14:39:44.0156
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iVsKHn8jM6QLj8cqBg8WnkrpMDYlxwKqg4pDeajv9hF5wZryXtQTse/EonznFeYIS0a9neZPmBBymQxDwHpRpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6896
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-08_05,2024-01-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 bulkscore=0
 mlxlogscore=999 adultscore=0 spamscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401080125
X-Proofpoint-ORIG-GUID: Nj9Ucw4Qp9Rg6ADC6XJNf8_fvM7EVOcV
X-Proofpoint-GUID: Nj9Ucw4Qp9Rg6ADC6XJNf8_fvM7EVOcV

On Sun, Jan 07, 2024 at 11:33:31PM +0100, Cedric Blancher wrote:
> Could you please make a concentrated effort and allow non-2049 port
> numbers for NFSv4 mounts, in all of the lifecycle of a NFSv4 mount?
> From nfsd, nfsd referrals, client mount/umount, autofs
> mount/umount+LDAP spec

One reason we have not pursued stack-wide NFSv4 support for
alternate ports is that they are not firewall-friendly. A major
design point of NFSv4 (and NFSv4.1, with its backchannel) is that
it is supposed to be more firewall-friendly than NFSv3, its
auxiliary protocols, and its requirement to deploy rpcbind.

Also, these days it is relatively easy in Linux to deploy multiple
NFS services on a single physical host by using containers (or just
separate network namespaces). So instead of alternate ports, each
NFS service is on port 2049, but it has its own IP address. That
kind of deployment is supposed to be fully supported with NFSD today.

Commercial NFS server implementations also typically make it easy
to add distinct NFSv4 services at unique IP addresses but all on
port 2049.

-- 
Chuck Lever

