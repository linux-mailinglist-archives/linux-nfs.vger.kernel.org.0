Return-Path: <linux-nfs+bounces-2967-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C72278AF649
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Apr 2024 20:08:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE2891C21A4F
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Apr 2024 18:08:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E873813DDD9;
	Tue, 23 Apr 2024 18:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="P+ye4RRC";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ZS6MMSqa"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C155339A8
	for <linux-nfs@vger.kernel.org>; Tue, 23 Apr 2024 18:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713895697; cv=fail; b=IrqZ0PVSbqtF9TZU3OouaXgU5CZn/HHSClNueyajOHm0F6A5NHoiTYdk7KfjUluYNL7DTE2KFST/7lDtL3orHZVRvLzHjbKm4sojTzlqrHzzbHrrLsKiz7zyq223FFAOTvrcNAhTcBKM0fXKcSzxb6FqebTqY+1VvrduOL3EJlE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713895697; c=relaxed/simple;
	bh=uUK3fi7/NWLvu5p/A1Zgz9/ro1Qqfp9M/vMc/RRbIj4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=k9d3kGlfBdYeTNcdVVaKdFAB7GUqq6ZBs1g5UGPSwcVX/WeaR0ujZneVhPxbzeAFRuMM19UW0p2YbxdpuD7b7ncxxyzZqozh/5q+sE29+e5KbIi5zT0sWsvx0uHAq1wv8SiRIXdrPlXfdTCSSrZ9UgowaqXdMeJ7im+mn9uQAi0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=P+ye4RRC; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ZS6MMSqa; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43NFU8nC013748;
	Tue, 23 Apr 2024 18:08:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=zWIVUXtqLIhF3DC+7hhA7osIczz+ggGluxXwej/lxZo=;
 b=P+ye4RRCTJqatw2DjPfGZhvhdaRpFqGPZosrrHAPts6j6ve5MethOvnKdX0MMi0yGVQs
 OPYb9MzGgljHkcK+ZTEkyEtajR3PAves9J6VdXk2xbDB3gB7qlos7lMu4rpkksQnUt6O
 5sXPFyK3l+RuqWNsn4AFwnv+qUvOvGcqbaKuUBC/Taz3BHHyEk/UpID0K9+xzulzOVe0
 9TCEpoGAL/klfiQd/jUOgfE+WQ/RMP+365Un3bUv5/3OtDHp50KwRUQLfQZTFCcbVUa9
 P5i4yIGFYast7mQ5S0EytjgAk+NIEWtW8elRv5ZXS3Qx7/ZwiI0nwcxS5TmguNxhzumg zA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xm4a2eqmw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Apr 2024 18:08:13 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43NHZG1T006273;
	Tue, 23 Apr 2024 18:08:12 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2041.outbound.protection.outlook.com [104.47.73.41])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xm457nsc1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Apr 2024 18:08:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZVrW4eVwAAL30cpTZAg1mkufV+wSu9aGWB0EHVbRMQxiM/GMbmdYCup8pEalsNNRfWvHqnVEj9IoXST055JQizmp0FA3BywX7ecUeMnPUlzWiYzp8hdysO9MUiTBmoG6coDT6y0n2YleR/UgF6O+xP6XmLWpfnf9Dlb8+jCSL8F8xXRXTeNcUCfuc2X+EZGq2hLpS9SO60zNWESUVWKIiQfxztTwPKbmhSAZrovDobo4wXsxW8EDOm7yecy+6ZNHSyFF8gtKl8qkZsDq+2KBHTmSx1iNifu3P56TslbhOVpq5Yw9F/d9ssJQ002BaZqsYR2TaDvxoMODMCK7il2tUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zWIVUXtqLIhF3DC+7hhA7osIczz+ggGluxXwej/lxZo=;
 b=Qmbk1jMw3T3PM5zZcitHgcC8aEEjzHvW3gqrPlI3HxkpewuYSHWXyT42VmQYCb3/5oSs+2zc6Fi/q0XesWHgEQ5E4ZCm0FBcCJBLAQ6XJpJ27yvVH5vmRuZd5QZCcfxXf7WUM3XX+Sfd1ndNFrMJyjLQfOnFJn3DbfI6TrnErnBTBcOkO1p9FH1nw510um/2QFnGFxW+JxRVe9/bG4Yc+PRPo9mgcFRZ/DWMp3Hvs0k27ZSCVuXZDJxdUIci+afgy3onDt8jDZmUYgwlbaNDOas4bP0ixK4DfRm5bdLt1FfrVj+FBIOB8Scy2OEWcvK6UmJlWOvIND4jigKmlyPAHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zWIVUXtqLIhF3DC+7hhA7osIczz+ggGluxXwej/lxZo=;
 b=ZS6MMSqaIgRrVjhgu3gLd9CIp02b/Smk2CUzyieN9LiUAvxeTa1lEbOnfIhkvA3L960LRzkRccxZNJDZKbyCi5LNfhj4oS29xpjW+qzPzSHJKabjz/1B95yWAQByfQ9Ie6asVX4bG4gdbhsSRBqvCc3n1pfaVFWqWB4cMWq450U=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DM3PR10MB7945.namprd10.prod.outlook.com (2603:10b6:0:47::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 23 Apr
 2024 18:08:09 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.7472.044; Tue, 23 Apr 2024
 18:08:09 +0000
Date: Tue, 23 Apr 2024 14:08:07 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Dai Ngo <dai.ngo@oracle.com>
Cc: jlayton@kernel.org, linux-nfs@vger.kernel.org
Subject: Re: [PATCH v2 1/3] NFSD: mark cl_cb_state as NFSD4_CB_DOWN if
 cl_cb_client is NULL
Message-ID: <Zif5B3fT5JA8GvEt@tissot.1015granger.net>
References: <1713841953-19594-1-git-send-email-dai.ngo@oracle.com>
 <1713841953-19594-2-git-send-email-dai.ngo@oracle.com>
 <Zie6ochDV9VjumK4@tissot.1015granger.net>
 <d18e8b50-2eb1-419d-a937-9314ea39e08e@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d18e8b50-2eb1-419d-a937-9314ea39e08e@oracle.com>
X-ClientProxiedBy: CH2PR14CA0008.namprd14.prod.outlook.com
 (2603:10b6:610:60::18) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|DM3PR10MB7945:EE_
X-MS-Office365-Filtering-Correlation-Id: 282b7c46-dcfc-426e-e003-08dc63c05544
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?Y3jG/8RMHxoK8PaEk2bTbNFhBxpiisfAi2eIJLPyXiSzbmncMQnN7lGKXrMN?=
 =?us-ascii?Q?NnJI0PtqsfaJEI0AcsNf5eEuQ7rlW7/gp+ITGt5O/b61BlMVNVBohD6JZRky?=
 =?us-ascii?Q?RHsi9XYl80v6Svm3d27HIGIglo6WmcyuNmrx9bun+yRMjEFX/NirNP73vkJs?=
 =?us-ascii?Q?H5h1w8d8N/+5cXj1gtWzuvVYHuob2jowm8M3yuVryNRajq0X39cMkT8zeUgp?=
 =?us-ascii?Q?JitbSUptEc614U6SubY5s53mg6fFQmzH9EYX3/Okz82HIjkJFDreLb7SMEbM?=
 =?us-ascii?Q?OyxXGFTJuYAE835Nd/wWB+7kRMIRy5BxvbIV1EZ8Qqy52KpzS5yNTl3J7QRZ?=
 =?us-ascii?Q?qJE7oqckBz3UiCC7+jt5ukD9hozg1YW3Kzyg41vhd6f83prQuv7r21skBxcO?=
 =?us-ascii?Q?7HIs7C0ejm+kqWTfOFOKy+TLqeiCglCTa3AA3jORbrSL8j2ydss8EuUy29mG?=
 =?us-ascii?Q?eFCK715buFfGkQTqtUPgV/qLbXUAPh25r+mUUn7VVlHjeVF8ok8vAEGiRtES?=
 =?us-ascii?Q?WVQcvG8yKhK+ovBVmbM8MJIv/oncqxeUUewXIe7r8/q5u292wfZIPnHsAwrZ?=
 =?us-ascii?Q?lXoTiDboMbhbQCtqzitC9nxslYlIS1p0gR6NsID6QeEYo2Uk00zGJRYdzfiT?=
 =?us-ascii?Q?zhmA/IivoroGPKEXz1vUxJ+JHdVycXf/uvWbFYows4puTpTmrlNw6266nng4?=
 =?us-ascii?Q?28CPRijBmgTL39cPNP2/bjr2/Ec326tubCqv8p+abX19VADJYML7r6x2/eW7?=
 =?us-ascii?Q?RBOLS60JScm+sI0zC+bIvP6O2GwxDgj7TigiGg7Qp4HN8tnXqL/iINBCmjXm?=
 =?us-ascii?Q?mV+yPvh2M7T0zeEUeGqotNvyYmU4oVcwRFSp/G5+Z7xFLpWabTx55vPZTCc2?=
 =?us-ascii?Q?n40cz58EzPwO/h9XZWsbvh1IjdMM8lhwCg2q36TdLDivsoXJRBA2jCBIE9bj?=
 =?us-ascii?Q?FxH/GTefR+bGvFaYoucqWl2jIHkvwbaUxr8X8wvRkOxlKiCn9cYCInmg7+kY?=
 =?us-ascii?Q?hJjgEHmhdR8Hoz9RWN+fAHMyFHbF6PHXGmlBeWbj9ZDLCCdj+qj5FHPvhdkX?=
 =?us-ascii?Q?1mvweog6+IPueSPVSGEamDIJeMpl83Oxydg8I/GSPZbjdAx8DjiKsystXIDD?=
 =?us-ascii?Q?Fjzo8T4Xw5yuwwD2D0TccHp+wN69iR82CToOO7dL/rKCdYWTYh7ilrc5NCs7?=
 =?us-ascii?Q?R1ewqighMmMcQhenQGFdMgbC0gHIqT9YjeTcjBSNq0xHnWXAj65rAw9TUDgg?=
 =?us-ascii?Q?J07NwqLHS2kPO2ggXsfjWH3g7miaprNzl5qp4OKQAA=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?4lbasnDQek8HPrjhzu0NEbnPLGxO5DzQr7/asHaiIlmymEAYglYiQMUrKtkq?=
 =?us-ascii?Q?YhgwxCAqlvMi6n/IBkjLj/fHL4FTfhpJcTsBR66Q7WVwVOe/9ofOGAGdy0VF?=
 =?us-ascii?Q?L7mhESVthrC73+VKLKMy2/Kxa3SJa8Ukl+YVSR2cZXpyM17YcWkpKXwZfiJ9?=
 =?us-ascii?Q?f9UQ89nCZWUu2N0CaZOpSz2GwRFEoGgAx7MeeNHmCnf8MhRms/VWyBpj1Xhr?=
 =?us-ascii?Q?tLEb/uZFIdbGmBwEz/qThAAaN56g2D00sD1bikU/sOg+f+VZtF8sF6AhRxLK?=
 =?us-ascii?Q?sElg1pwj7XwxE8vp37XEguQf55px/1sE+a7NYmwYcBgFoa4s3OR93wQtuNIQ?=
 =?us-ascii?Q?Y5dRlkVWR32YHVX0rR62NN9rn3li/P/HYDKtbWpkiGy737Z+TXAXlZX013Wz?=
 =?us-ascii?Q?ZRBZr/Y3WjWxkJMg74BPvpOLaAtPVCWRZeHN5N89bMqmOEP8J42W3btt87xB?=
 =?us-ascii?Q?ON1tHWjKRR4vkcjVLXLFoosulnjroNfbEoTuFhk4CG4mJXE+vpcqO02xrt6l?=
 =?us-ascii?Q?azuk1ic/yFzYsWKnE4eukDwmS8mtreisH/zcPLJ2KMSAVng7leOAnhMR/osw?=
 =?us-ascii?Q?eyyQA/kBoO0VTvL1CmytqZ1tgzNB6H8yFXGkaCfc26aN4/6zYTOZ30P98vLZ?=
 =?us-ascii?Q?mJNg6d3SZ3eYS4AfBQqbeJXLyOIW98UrgmxLzbT143nFPy1EvqGV4gIkHi60?=
 =?us-ascii?Q?98Z6JRoCy1NcAdqTJ9QwR1YWizihQu0aMSaL0GB62Y5kX+D6FnDFQ06qjYtK?=
 =?us-ascii?Q?nvnBldxchCbqIMRg2TXqmYqy/JJ3n6rM5uAMOsTbI/kcdrn1xI7fIX77WUOR?=
 =?us-ascii?Q?aZhrqJCbfXr7zjUXIXaZbqJi15cvQj3vQat8IcpH3gveFyGkxVuODI9oHln7?=
 =?us-ascii?Q?pAsf19kPqpwMPDIi0qj7wPrLr3ZGj527Lj4kVy/53+lbhnKLG322Ia1cQR7u?=
 =?us-ascii?Q?n1QAdu671SgLuZ+nqG6o/rI0RPHxjDAaEJk9kLE9omPJ1hlj9cwPn+fkPfVj?=
 =?us-ascii?Q?/mEpHbfZ7tIjmFFAuJtjl+9I3VBcJMSZXQZURgtLJ0tzjc494W+0lBTEdvo3?=
 =?us-ascii?Q?8Tone/+8pwkiGu6Xg4E4V7KTjNPONke/aiMC+MFUxsbYoALAragNtPIo7epx?=
 =?us-ascii?Q?lbDf0cAO3/9TH8h33Ii6xMlqzrsUz5Kc1eT/LarwghMKt6dZMBcNB93DmwTy?=
 =?us-ascii?Q?prtZ7vQXV1EwfH8nFvHtcCMZUztXMjIJcdejpDvpNKgcEwVHWa2eGmPBphVu?=
 =?us-ascii?Q?yLLUUhJLOd7BDL+MB52CYtRhLGdQWNbt6KujXIFq5mo/EP5OQWIbKyFyV6rH?=
 =?us-ascii?Q?4E4GJt9xk931wMYvtB5m/Wf8B/2el1HveRxtXKIICQ8puVhN29EweQotg99o?=
 =?us-ascii?Q?PAZFi/rRBwIaTc9+v2sVnHp5mP7K1QEEBYyhkkSNFs2E3rCrCac8D/45Yk10?=
 =?us-ascii?Q?gIFGj+tdo+0LEARxTHrWQJLpwU7yYeB9UV6AiF3sqiRNeueXCS+1dfyJ5sq5?=
 =?us-ascii?Q?FLEKIvXYhAyjfsUvpNstYHC0OV2AQs5AVVA3vIPtYRKRp54LCYk4i9uZo45a?=
 =?us-ascii?Q?t7BYUjQdM7YWWRLhT2RmZ4jtHD//LV3dUlIRNiyWjukaBpegEUkxTkSqAsXu?=
 =?us-ascii?Q?6w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	6wkLq0V4cCuBsPtyPiJNlzG13C2Ol00ok4Gw5wBk32SCBbJDCjfgMaCuvQkWPo2Sv1fKoYSlvjnvqQr8lFkimWwwoGu4E1vHgoIiyS0rz/oZQuMra8ZOg4yD3CvP89JoW4Lu8LyS8jKJN4zu0P8RpFVmR+4wVqazxFxiP9qDK7EBw5Raxt1UeBBHUNvQxE+2aY2F+bvlgZ1F8lyaeXSRQ31SvNwHBRg9iZGRaZgu/hCIx+JJKP/SwST5jtWEW0gn49tbZn4/11rSM4sULuyY6xKSEA3GWeWRDWGlCi7uMmVwoghFqUHcZbYmEn0H715W18Jk+9QtTy5hTMTKvYAlwD96L4E+0E8dQpMWeU4wFit1+wZC07MojawEUrZmNidIyQygRggXW3HkGLZZemFJxJJtKeVAzv6B/HVFaP9DzAdBYHenDJoHCnovohJ8r3wHpjPZ1FjLtAxZhvGcrFSDDeGLKzmMVb9VHcHSAHF4CCsK2yAZhSw9xj6WbH4UBf4DlTBO02SdRxAunlljZWxRW9GGXOj7DaWvdlYpaEnfxTiWAP4feen/TcrE2r4Kv+JTxFCa1wL4zk2ENqWcwkO5x+Ie5G0wAzM4vXG7fjAYLHI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 282b7c46-dcfc-426e-e003-08dc63c05544
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2024 18:08:09.6760
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2aLO1PQgw1QZnxN4oLykCRQPdWG2M64H8NS4YrYtaO48c+NQIykipqjszWoMbxJo5a7MLqLMXJxX8HQsd7il9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR10MB7945
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-23_14,2024-04-23_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 spamscore=0
 bulkscore=0 suspectscore=0 mlxlogscore=999 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2404230041
X-Proofpoint-GUID: 60wP-q694zIW0vLj_K0ExPZ157EMc7LS
X-Proofpoint-ORIG-GUID: 60wP-q694zIW0vLj_K0ExPZ157EMc7LS

On Tue, Apr 23, 2024 at 10:49:25AM -0700, Dai Ngo wrote:
> 
> On 4/23/24 6:41 AM, Chuck Lever wrote:
> > On Mon, Apr 22, 2024 at 08:12:31PM -0700, Dai Ngo wrote:
> > > In nfsd4_run_cb_work if the rpc_clnt for the back channel is no longer
> > > exists, the callback state in nfs4_client should be marked as NFSD4_CB_DOWN
> > > so the server can notify the client to establish a new back channel
> > > connection.
> > > 
> > > Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
> > > ---
> > >   fs/nfsd/nfs4callback.c | 9 +++++++--
> > >   1 file changed, 7 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
> > > index cf87ace7a1b0..f8bb5ff2e9ac 100644
> > > --- a/fs/nfsd/nfs4callback.c
> > > +++ b/fs/nfsd/nfs4callback.c
> > > @@ -1491,9 +1491,14 @@ nfsd4_run_cb_work(struct work_struct *work)
> > >   	clnt = clp->cl_cb_client;
> > >   	if (!clnt) {
> > > -		if (test_bit(NFSD4_CLIENT_CB_KILL, &clp->cl_flags))
> > > +		if (test_bit(NFSD4_CLIENT_CB_KILL, &clp->cl_flags)) {
> > >   			nfsd41_destroy_cb(cb);
> > > -		else {
> > > +			clear_bit(NFSD4_CLIENT_CB_KILL, &clp->cl_flags);
> > > +
> > > +			/* let client knows BC is down when it reconnects */
> > > +			clear_bit(NFSD4_CLIENT_CB_UPDATE, &clp->cl_flags);
> > > +			nfsd4_mark_cb_down(clp);
> > > +		} else {
> > >   			/*
> > >   			 * XXX: Ideally, we could wait for the client to
> > >   			 *	reconnect, but I haven't figured out how
> > NFSD4_CLIENT_CB_KILL is for when the lease is getting expunged. It's
> > not supposed to be used when only the transport is closed.
> 
> The reason NFSD4_CLIENT_CB_KILL needs to be set when the transport is
> closed is because of commit c1ccfcf1a9bf3.
> 
> When the transport is closed, nfsd4_conn_lost is called which then calls
> nfsd4_probe_callback to set NFSD4_CLIENT_CB_UPDATE and schedule cl_cb_null
> work to activate the callback worker (nfsd4_run_cb_work) to do the update.
> 
> Callback worker calls nfsd4_process_cb_update to do rpc_shutdown_client
> then clear cl_cb_client.
> 
> When nfsd4_process_cb_update returns to nfsd4_run_cb_work, if cl_cb_client
> is NULL and NFSD4_CLIENT_CB_KILL not set then it re-queues the callback,
> causing an infinite loop.

That's the way it is supposed to work today. The callback is
re-queued until the client reconnects, at which point the loop is
broken.


> > Thus, shouldn't you mark_cb_down in this arm, instead?
> 
> I'm not clear what you mean here, the callback worker calls
> nfsd4_mark_cb_down after destroying the callback.

No, I mean in the re-queue case.


> > Even so, isn't the
> > backchannel already marked down when we get here?
> 
> No, according to my testing. Without marking the back channel down the
> client does not re-establish the back channel when it reconnects.

I didn't expect that closing the transport on the server side would
need any changes in fs/nfsd/nfs4callback.c. Let me get the
backchannel retransmit behavior sorted first. I'm still working on
setting up a test rig here.


-- 
Chuck Lever

