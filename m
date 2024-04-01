Return-Path: <linux-nfs+bounces-2586-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0587B89447C
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Apr 2024 19:50:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 242111C2164C
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Apr 2024 17:50:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E761A1DFE3;
	Mon,  1 Apr 2024 17:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mN6O0h/O";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="P6c0NMKO"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE9434EB24
	for <linux-nfs@vger.kernel.org>; Mon,  1 Apr 2024 17:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711993808; cv=fail; b=e3S81hVw/tGLS4oE0ovo/2lwcqgY8mDaJKrpeGpYERys6c+IgnJoSo4k19mnnP8aQ6LKAv1mzYRGlYjEk89JPk5qEijYREADxlug3h91jwk4eInUdHEkq7b9Y+2jRNg2flBH9bUnrzNZsHwL/+M3Tzo/JxLTsaFbBm0o12UZRUY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711993808; c=relaxed/simple;
	bh=iM55fvDKsHxhZOJHeuBo6eJvtCN5mm7XLNPAgzNuR4I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qML5y8eE+p5emg+57QmZtHHfUE5SiKjzG48M3VxZsup0NL2louHBIZ0vkwR0xQUrsgfEj7tfvtivI5xvbnXv86VSXpQaDQO6qj+oRUF5q7ne6pg37R4+NL9v1h2Mui61EKVcVAInKhgz1sU/LPHvhNvoBaAmd/BKY+AoJVmJfV0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=mN6O0h/O; dkim=fail (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=P6c0NMKO reason="signature verification failed"; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4318iBww027623;
	Mon, 1 Apr 2024 17:50:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2023-11-20;
 bh=WftKROTcTJRAWJjqj8us81o+GfAFjQkwQnjGg95dcRM=;
 b=mN6O0h/OToKlMnF0A7rSi3X9VoS5NVORmH2jiWJr4biFD+TEuD0GgXGAeRZ0YSgG9F5B
 h/pMHzJMkij3fkgcaXZU211F+ViLcPsyeQfcne5/f/I5mJlLUFChrQvnjQm/2WyHkxdj
 JLqvgbA4K52SNYOWwt2N6kZkwb7vzQ53lLEQMORi8vC+2JMGqnJ6tYXC8WbjEatcRaup
 PqBMsm8ujiUoIzyGc473VklmPeHVPBF5d8+vM2rpg6thaBE+lX40GWqymWzpGC9X1vUo
 rISSfWzsEQVcYeEa+Fxq9Iwdio3qp73wSPPSQWSGQOotMDQy3Xna4fpTiFWu6f+R/bZr Pw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3x6abuavnw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 01 Apr 2024 17:49:59 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 431HLCZQ023344;
	Mon, 1 Apr 2024 17:49:58 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3x6965pewd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 01 Apr 2024 17:49:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WxGXayfQIeiq/dl3EzuGiovCXn9LwUqD1zGrNPRztonRpiNU4VczYc6V3Ejv9keetGiDWOJiBzzzDQq8enJrbdh2c2l2EM76zQFPd9jCH1hRVPOFma7/tUcrO4Ms6N0Phqkq32SqRM5pi3pjF+TWb8KMgI0KCZiLlAfgJA5FAYOOkQBhUgpNTWCpIbVWzAbOh9wablByHijRWXW8x3ebxGSFH1PtYevFuLzS+AmPc6u/JGkfqsmX+IVjKsLZaDLOMoWSLRHJHxHvgs1e1ZmPRSWcJpfM0aMsj65IC3BPgOBdVjQnLxc35rHQOSQycrq8b8zXZyLCTChK6/z821fPxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sFq7yL5Fx2Bp7i+eHnkt3vtayZfggZKpDOsHs5c/HCs=;
 b=Or7ons10E2gZ4GP6ef9whvE0DUvMvRxpTJf9MN5DfRr2fDfY3xNsnGJXO0hBI6QkWHZOXtZ7aVe+loo+qzrg9ESqLEk+3gEJyo2o1ceCtKm8U6dog4jUoxoj4Qh4/lE1VjtRwUTTychJtPUJ32+HTq82XGxr9AVPTKL8Hszmon9Fjl5xzdExrls57gF1ttfLDPedm2TadwhXk+U/TTTxJ7dBSH6Uy894+91NTTk8zq18A25UAd5KTomliTMze0YHPnep7UM5+36d8l6uO1r//MIDq4fYehBwr+4Ss/SHEuoV96hGExZcqIxDJbkGhs3GD0y/gd0NU4cfgTru2X6zuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sFq7yL5Fx2Bp7i+eHnkt3vtayZfggZKpDOsHs5c/HCs=;
 b=P6c0NMKOdo+RCqK/fRKoc66U+MThzJVeaLwuOF8bMyLvYU4ssVY6y2y981PSbv1jnaZVNBPi7/OdQGpvKq4bi4jY453WgqvjZoskkW3jumQq0ud0NGV9YgUdY45vabRhZYJr26vFvr/V3TFGPYHgoFO7i2TV0+dZ0WSPHarC6pQ=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH8PR10MB6598.namprd10.prod.outlook.com (2603:10b6:510:225::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.42; Mon, 1 Apr
 2024 17:49:56 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ad12:a809:d789:a25b]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ad12:a809:d789:a25b%4]) with mapi id 15.20.7409.042; Mon, 1 Apr 2024
 17:49:56 +0000
Date: Mon, 1 Apr 2024 13:49:53 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Dai Ngo <dai.ngo@oracle.com>
Cc: Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 1/1] NFSD: cancel CB_RECALL_ANY call when nfs4_client is
 about to be destroyed
Message-ID: <ZgrzwVp4GrbmZGWt@tissot.1015granger.net>
References: <ZgbWevtNp8Vust4A@tissot.1015granger.net>
 <97387ec5-bcb4-4c5e-81af-a0038f7fc311@oracle.com>
 <ZgdR48dhdSoUj+VM@tissot.1015granger.net>
 <09da882f-4bad-4398-a2d0-ef8daefce374@oracle.com>
 <ZghZzfIi5RkWDh9K@tissot.1015granger.net>
 <84d6311e-a0a3-4fc6-a87e-e09857c765b3@oracle.com>
 <039c7e38b70287541849ab03d92818740fdf5d43.camel@kernel.org>
 <Zgq365RJ9M5qsgWY@tissot.1015granger.net>
 <5108ca5a-b626-4ae9-a809-ae3fffb50cab@oracle.com>
 <a30b343f-b6cf-4566-9565-28a5fd5ca851@oracle.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a30b343f-b6cf-4566-9565-28a5fd5ca851@oracle.com>
X-ClientProxiedBy: CH0PR13CA0024.namprd13.prod.outlook.com
 (2603:10b6:610:b1::29) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|PH8PR10MB6598:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	/qUy93soT8YN+oT4lCGcuN5MtUNzOAVHsDI0N5M01Kuo95FkoOSTOzGLNxEHKEU5laO58skPrvXJ1v3mLcAhnAd/gEm7A56quw+e3HAHHa9JdcX9pRpBO9mt7dmS6x3jfkP8piPIrZWolHduSIZNsmEZ2vGlG1eHZkvaAMdV5pVAxUitMOXIxy0W5tMCzkQpgUT/sYjKb7OyJBrmmmZzC02JbT2JCoBGNMs8cF3B6CzS90kns9MhPzEcrWBzPlApClhpYoFzh9jdlA6IvZrpjOu+HVlhMaVl003WWKjcbuykqApDnYD25QXdjdR2OJuxmaD/++nLUmQXBN9peSWocAD0hcBMGHThm1NW9aLSDV5Fo0ostIG0FCpGQKC1e/6O6KoRsv7eEA1V7v93dqSBTsTBxkYXUp7dqflE4JqOFQiYtazTX2JJBcE4kLayfg6k8wetbcwFBBkA1oFal+Aoe0cN3VB9rNpH9v2F3r3OnFhw+9so4QL9HR892qmp1KKtjWuPqoof0OUVcjkCfPVrVlMOq8mlfyK7CxlISJ2m26uI+B9b7VrKaMUYaxeLZaB55e9CT29jiRksK204eBQYnugk+SzgKtu7DPEOai+TCAsnX9enO3xwFfJwRkzkJXUdfY+ktb7kBDBLHTLuWkv7HCMJ6A2SF3HgJqE2v4Zp4VA=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?iso-8859-1?Q?7m4v0R2mDVdPz4TJQG0K7kwcisTUzuHtxxbeQolwpvocxj9xru+GzBa5pe?=
 =?iso-8859-1?Q?rt9OLLoMdjNLPwqYXAYfJNDNeVNfdJx+NVvbLaSIkSdU5uB7YxEvOr7Mat?=
 =?iso-8859-1?Q?bGm7MixufiXTF4AEWvZDqeueXewnU89E9l5RjGvwBFKZxfYNGQnzc8eXKH?=
 =?iso-8859-1?Q?G4OdJa1MzLMiC3ca0amYm367e7qX0hwCJDVpci73PLj/c7fVDMjcAWwUTw?=
 =?iso-8859-1?Q?VDtfYlInuQWU12Oka6fwowCX6sHDaw1jWFli+bhcJQ5xUxbXy24a8LC4Sc?=
 =?iso-8859-1?Q?kkZ6oPxUh5JZWJ8WVQhT9p659OZ5ccpecdm7exIaDoENUzpjfJXGDwlIUD?=
 =?iso-8859-1?Q?K0sdFOgoPVMZmnbCofDj2n4FsZS3cTovS/lwkH1/t2IRMpYv8OvFF3yBOr?=
 =?iso-8859-1?Q?ukjXfPqrB2o6cheeSFH2INAZXZbnPPE9LJYuJPY+L7qdiJVbjg2gTMCkbr?=
 =?iso-8859-1?Q?F/7LRqEtKBPK/b7465p0eDSEzSZArM0gMg9A/m2mLLRuMeW0lRv60xkhsf?=
 =?iso-8859-1?Q?TegPRTSalNoualyhyfmoN8PB4pm6+BQcpWp5DH/ou6uLqgLSVzIYlo6o9I?=
 =?iso-8859-1?Q?KrrFwFTipZ3gCi8D5BQvpPewLP67nf+Q2AqxtB0GFq/mIVuCIgVc5PZP3G?=
 =?iso-8859-1?Q?eswUtHh8rjpfGGPsWSyiC3sTiAemt3joIgF+zdwrZZChwbLiBjL0epoMQu?=
 =?iso-8859-1?Q?4PzIftj/qKmMhhqzccXUWCgoH/mGaSPQmpWjxcHD/s7GB210h1tq0Xal5K?=
 =?iso-8859-1?Q?X4GM8onyhAFq4ybOBDbvd7c/sblIL12egq8QsZQBcpuWbJBynk7yuzmE2o?=
 =?iso-8859-1?Q?u+kX3Os8NrXcUnpMReVEn6g724ZufVBfi9vaKQtAEmdlfq8NPfeulTl4dV?=
 =?iso-8859-1?Q?RdpSEID+maN8yPXice0QrZpf0JoauCpC/1kDWGGzC1f3xU+EjNDzLqM17m?=
 =?iso-8859-1?Q?29UUqKcUYAfs/sgBkZX3791E/Bytuy/Ouw6GaUz91+ofvQQrNndK9Wp3id?=
 =?iso-8859-1?Q?6mKcc564cAOYdz1xCGzBPwNBAb/iuqxoBIRRXbygjqMNr5VQHLjEuYB3VJ?=
 =?iso-8859-1?Q?NOcEHg8SMKAFwM7J0tgxBedNYWGqtOLjBTaiLbJeSTONwGeC3LCpMzjVJ6?=
 =?iso-8859-1?Q?iYo01823QsEELrKsxZa/qBUYFKGE4gokhs/7IeiTUTVnlkDGC7PBMIQTOb?=
 =?iso-8859-1?Q?C084ccmBEwd+aiULJT4yjp+d442LT2dV9IlQHBKmo2YOSzgMLk7r9jWN7k?=
 =?iso-8859-1?Q?FPUdgnp2hAARmnMPx1B0k0UM10YTn7IkLJE44hzTboTGMYdfyz9lgjzA8A?=
 =?iso-8859-1?Q?YGeuDI02oZLFcJkmtiGldBwR/4kkltV/dKRIAxcyBCsol8G8rNWOIJHQAJ?=
 =?iso-8859-1?Q?YDJ7NOS8e7+M8Xh9jWf3iGKZd8evwsHsWBL+CZEr2SCeNGuG5O0UHd0kNL?=
 =?iso-8859-1?Q?8nDYnBFemLpBbdVDrNCIdwJnQZuoZ1NksFC2s9hYlvxiTuAni3d4tYfRkS?=
 =?iso-8859-1?Q?xIuGuNRSV3lGtBSlkhZd83B1Zr72W6NATnJxsQNqN8Mt2knORhzB9eMwoA?=
 =?iso-8859-1?Q?jB52ZrP49O14PfBTtHsRH+T0kyx/H9x9P7DD+G4XBOJYdogUYwrhLZ4vfB?=
 =?iso-8859-1?Q?uvRyXEagMG0kCfygS/QJ1IJfye/BtoxhHoBW2FHvoQB+H83n9kNOpHhA?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	bcBWvJMepbiX9WGtpR8bOrOuPH53YF6OkMsAwW9tpjN8uGZOBoC9FKHQwvPwOCQWspAfo2svP9b/plG8oty75cErO6MNm/Yd8Gv5QHFewavIwDy3CDEPDPLAGSiugFP2FikxpoKEn05qD3ZgnlAqJhrJ5phIydwQZFF1tkOHHMyy3vtZvFNyfbj+EwXsK2j7fcmpDPfMq1pWJBGcDAd2TwlCTKzvpLdgQ1UTR0RB+pYnDj4nQ9dDSBdakXuwUO0xxh98+02o9KHpOn1B4WAu+XbJI6Pt1jaDB2I98bRnjq10bHYn6WUsmWEaSqcCPqCoTeb8L3GV8/G0NspNaZc9DmtICfimqqEZZ2/aQWjuRuvTkVJMmuIdJhps54etIuneUz9ppwhfbw4hrvtv6blzMInLu6i6LCiPvdASEnBgQ1ZOfgLC2p8HBJ3odLwCEnFKEyYEGA/f5dwxNdAi7Fg6VD7E96OT0O1Yavv2hdu2jn+Ot3WXDrVD1Ud3jc2NRwdm7Bc/g6CcY3ujHUsiYaUfgmmYaqJYcDqwTgqmIoEL43F7QP4XqLT9aaz3itfhH20jWq1H7P2t4R/v2uGIHCAy2WUFvdQNXdkbLQZlWS17M/g=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96c67983-c385-4380-99d8-08dc52742493
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2024 17:49:56.6703
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3jZiqKIBWNOZ0bT/u1mOWhCwahX3IYh+SPfF2vLw34yoWGU1YzSRo5e7ODG857qXT3FLU5hm4xUVfPNYRyeI7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6598
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-01_12,2024-04-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 bulkscore=0 spamscore=0 suspectscore=0 phishscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403210000 definitions=main-2404010126
X-Proofpoint-ORIG-GUID: -C2Bc94C0tNk2dCnq8Z4EqvZ2GPryLPX
X-Proofpoint-GUID: -C2Bc94C0tNk2dCnq8Z4EqvZ2GPryLPX

On Mon, Apr 01, 2024 at 09:46:25AM -0700, Dai Ngo wrote:
> 
> On 4/1/24 9:00 AM, Dai Ngo wrote:
> > 
> > On 4/1/24 6:34 AM, Chuck Lever wrote:
> > > On Mon, Apr 01, 2024 at 08:49:49AM -0400, Jeff Layton wrote:
> > > > On Sat, 2024-03-30 at 16:30 -0700, Dai Ngo wrote:
> > > > > On 3/30/24 11:28 AM, Chuck Lever wrote:
> > > > > > On Sat, Mar 30, 2024 at 10:46:08AM -0700, Dai Ngo wrote:
> > > > > > > On 3/29/24 4:42 PM, Chuck Lever wrote:
> > > > > > > > On Fri, Mar 29, 2024 at 10:57:22AM -0700, Dai Ngo wrote:
> > > > > > > > > On 3/29/24 7:55 AM, Chuck Lever wrote:
> > > > > > > > It could be straightforward, however, to move the callback_wq into
> > > > > > > > struct nfs4_client so that each client can have its own workqueue.
> > > > > > > > Then we can take some time and design something less brittle and
> > > > > > > > more scalable (and maybe come up with some test infrastructure so
> > > > > > > > this stuff doesn't break as often).
> > > > > > > IMHO I don't see why the callback workqueue has to be different
> > > > > > > from the laundry_wq or nfsd_filecache_wq used by nfsd.
> > > > > > You mean, you don't see why callback_wq has to be ordered, while
> > > > > > the others are not so constrained? Quite possibly it does not have
> > > > > > to be ordered.
> > > > > Yes, I looked at the all the nfsd4_callback_ops on nfsd and they
> > > > > seems to take into account of concurrency and use locks appropriately.
> > > > > For each type of work I don't see why one work has to wait for
> > > > > the previous work to complete before proceed.
> > > > > 
> > > > > > But we might have lost the bit of history that explains why, so
> > > > > > let's be cautious about making broad changes here until we have a
> > > > > > good operational understanding of the code and some robust test
> > > > > > cases to check any changes we make.
> > > > > Understand, you make the call.
> > > > commit 88382036674770173128417e4c09e9e549f82d54
> > > > Author: J. Bruce Fields <bfields@fieldses.org>
> > > > Date:   Mon Nov 14 11:13:43 2016 -0500
> > > > 
> > > >      nfsd: update workqueue creation
> > > >           No real change in functionality, but the old interface
> > > > seems to be
> > > >      deprecated.
> > > >           We don't actually care about ordering necessarily, but
> > > > we do depend on
> > > >      running at most one work item at a time: nfsd4_process_cb_update()
> > > >      assumes that no other thread is running it, and that no new
> > > > callbacks
> > > >      are starting while it's running.
> > > >           Reviewed-by: Jeff Layton <jlayton@redhat.com>
> > > >      Signed-off-by: J. Bruce Fields <bfields@redhat.com>
> > > > 
> > > > 
> > > > ...so it may be as simple as just fixing up nfsd4_process_cb_update().
> > > > Allowing parallel recalls would certainly be a good thing.
> > 
> > Thank you Jeff for pointing this out.
> > 
> > > Thanks for the research. I was about to do the same.
> > > 
> > > I think we do allow parallel recalls -- IIUC, callback_wq
> > > single-threads only the dispatch of RPC calls, not their
> > > processing. Note the use of rpc_call_async().
> > > 
> > > So nfsd4_process_cb_update() is protecting modifications of
> > > cl_cb_client and the backchannel transport. We might wrap that in
> > > a mutex, for example. But I don't see strong evidence (yet) that
> > > this design is a bottleneck when it is working properly.
> > > 
> > > However, if for some reason, a work item sleeps, that would
> > > block forward progress of the work queue, and would be Bad (tm).
> > > 
> > > 
> > > > That said, a workqueue per client would be a great place to start. I
> > > > don't see any reason to serialize callbacks to different clients.
> > > I volunteer to take care of that for v6.10.
> 
> Since you're going to make callback workqueue per client, do we still need
> a fix in nfsd to shut down the callback when a client is about to enter
> courtesy state and there is pending RPC calls.

I would rather just close down the transports for courtesy clients.
But that doesn't seem to be the root cause, so let's put this aside
for a bit.


> With callback workqueue per client, it fixes the problem of all callbacks
> hang when a job get stuck in the workqueue. The fix in nfsd prevents a
> stuck job to loop until the client reconnects which might be a very long
> time or never if that client is no longer used.

The question I have is will this unresponsive client cause other
issues, such as:

 - a hang when the server tries to unexport or shutdown
 - CPU or memory consumption for each retried callback

That is an ongoing concern.

-- 
Chuck Lever

