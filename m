Return-Path: <linux-nfs+bounces-3170-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C54A8BD1EC
	for <lists+linux-nfs@lfdr.de>; Mon,  6 May 2024 17:56:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B09E01F216F2
	for <lists+linux-nfs@lfdr.de>; Mon,  6 May 2024 15:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C464155A4E;
	Mon,  6 May 2024 15:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cIk+T4ta";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="RKgQzikX"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4420155757
	for <linux-nfs@vger.kernel.org>; Mon,  6 May 2024 15:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715010962; cv=fail; b=YS1+xBkNYEHfB1qm7B81DvRoNze8+7AZMOS3gqTybOOym9AoSNGGw/W7m/uASG4tbOm34mBToHRr+yituOFW4HaElRlZPw6BnyDEJfdhNw6ngoEiQjQqjRKZ0sQFJv14GuwlzxqWxQeyxiD1ThNuuWiUj6IIMfpBg/40+idSxoI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715010962; c=relaxed/simple;
	bh=w70JV7CWNSCMnXO1X6k4WvtKvS6tsNC8JzOAhevisMs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=n0ZyZ4trus9LRVc6to3eNATNjm7pM8ear0Lotk7DUTMfwGcRfI7suuu8UsvYWOtEV5mw0oG50iIsl9qE/xXFn3uoeZ2ATQHcxidtX3Qnw1Cqk06Xa3cTpJllhz8y+RaSW5QlPFoJ/q11taHUemSSh5znUbI2LbHGRWDbtr8eekI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=cIk+T4ta; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=RKgQzikX; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 446AmxgL018884;
	Mon, 6 May 2024 15:55:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=Ja8fIfvcqwic2QG+5GT+mrtNlItD23gyX0pWQdqucvA=;
 b=cIk+T4taB2vQM6ixIXhNhd0PMCBuGgvXt4Lbt8p9Fw6oXd8s2ORzsIFFLj/qB/7bANJJ
 JTm97RGiEY1tbGqLr8YFr7Jpuk3h0jvis5w7fA0aR0u/xdaJTVfauvahTfk+5A88gt/y
 fd1bkyylVNdvRq3f4h20Waj7CWAYJQHpnCYPfy1rIHIj5hqjsLai00feTgAfhdt1wiEp
 Hi4sL5k/x+OL+hsVf7UD9HBwgW/a9Df1HvwbArEEE1ryqi2p0r0l4XW+zH724KE9CJiS
 SgwxTyeoHjFppwrYGpSKzjRKiNjj/s1Yul7ssSZ9ouGIpfMC3te12hGHEQxrVk54jOSu 9w== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xwcmvawrn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 06 May 2024 15:55:57 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 446FsIGv040858;
	Mon, 6 May 2024 15:55:56 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xwbf61q08-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 06 May 2024 15:55:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aejVV0chd0NXjSzeq4TtT69FbwNz2rf8FfBdmDo+bzUGIfA3XbNrG7xtmckS00XvAzVV+DPknqURCD1b7KgvdS3BVPUkq/D+GX8x9Cw7HxTCdcEZVH8pnYbHS/zAZEheF08a8PncpZwfg5Xw48AtSLIvFWxepkOWQtkrsW3TRPBLQ3Gr4dR4QSaquQZdJX+8VJ1I2NfvJe+1EEfkXgJURTF6z7FRm4BoVUcBPKuHXQK6bgupkHGlfm6JmYybckq2AYTKNfltZzUnwbzwtnH/BV2kb8Xe3r7ngdFHoVcsBELPBspaS+jHbIpAmwdGvYuEshQhtmHeMMSUQJadyg1qFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ja8fIfvcqwic2QG+5GT+mrtNlItD23gyX0pWQdqucvA=;
 b=TWp0GrTlUpgShFJz6TLns+POpox2ICIZmDa4Ht51sXI56AYyUaI9EWYDSvY2QniCLMMODWTFP476Q0Ut5mgT/3XSnVjobIHr/E/kCEfnY7fWLVrUWeeXuwTWQpULDvVoeiRHMGTnnJoR0ptzzNm9EuSs3opj7E5pMyiLeecFXpiOfrvM9ndNq4vbASSLOuEXzpJY0cqxQ2zqpDxCUP3MfV60gK9QW42d8UqcQybvtFfAfqJE4ItOLMOSV+/7gU5QAe3JOV9zO1m1VeGHVEXiPW3L//seTYFHl83jZdQ77AUmn8zRf0G05YykEhWK/TwEqMR1PMKVqcxOPerVyiCq2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ja8fIfvcqwic2QG+5GT+mrtNlItD23gyX0pWQdqucvA=;
 b=RKgQzikXnowDTgV2OZnjdBw3l7ZF/qbIsbpINti7r3OEKhw2+e4GcZ72ZW9ZR/B1jCV824pAcqjBrc/qtiUoBo5uoYiT/tGwoF9BPJ7PJESJ5Uw2fFPFzL6xxpy2NlLY0U3ZHscZjpNY5/4jTjyHe+1vjCAb6W+Tm54PFly3rmk=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SA2PR10MB4652.namprd10.prod.outlook.com (2603:10b6:806:110::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.42; Mon, 6 May
 2024 15:55:54 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.7544.041; Mon, 6 May 2024
 15:55:54 +0000
Date: Mon, 6 May 2024 11:55:52 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Dan Aloni <dan.aloni@vastdata.com>, linux-nfs@vger.kernel.org,
        Sagi Grimberg <sagi.grimberg@vastdata.com>
Subject: Re: [PATCH v3] rpcrdma: fix handling for RDMA_CM_EVENT_DEVICE_REMOVAL
Message-ID: <Zjj9iOOJ0px+Lvin@tissot.1015granger.net>
References: <20240506093759.2934591-1-dan.aloni@vastdata.com>
 <be4563e5-caa6-4085-98a9-a86e24c99186@grimberg.me>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <be4563e5-caa6-4085-98a9-a86e24c99186@grimberg.me>
X-ClientProxiedBy: CH2PR12CA0020.namprd12.prod.outlook.com
 (2603:10b6:610:57::30) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SA2PR10MB4652:EE_
X-MS-Office365-Filtering-Correlation-Id: f20a8a12-254a-471c-345e-08dc6de502f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?bee0exblKQ92boDTHWCu30NIla+85OvWHb3+JviqxHY98Iug+TneRuM6GvMh?=
 =?us-ascii?Q?tAdAdPikmLKn8oiY5vlGid7fiWjRofT74Af1I9OVw6MRcWICR7y/X6gLDApN?=
 =?us-ascii?Q?DICcbb+/5rSPpcpiGeWE3R+YZSLhlqttjTnOtRef+KjtVpMz4cEqSP7g+y8A?=
 =?us-ascii?Q?X58YCnx40rrISfoAOzoetb0yvucdzgRlDucSN2JBtW9hMzbKuxsoCXOFPJvF?=
 =?us-ascii?Q?u80bMXdK+mvI0d45+OxVWQ2MEsmvOnuG8TReMxTGj6QLD2o74aMcYBc01UNm?=
 =?us-ascii?Q?hcS2raFue3/z5G3RbDylmH0A7+jHP6pNQCDg2RAWAqOFkhMvT7qozLle+qyF?=
 =?us-ascii?Q?xZ9m1EqT6OZNWIgTJrTZa+6qA45pYmPQ7PrIs4C/DDXJ7n5n5vL7ZTuZJFZy?=
 =?us-ascii?Q?yXfgkYedXIafG8TtWI5YHeTmvZpYfbxst60SOgEhv/h5MLbyUGh3vZZ+k2Vo?=
 =?us-ascii?Q?dwI2ntKWa0ZzkPVPz/k23B2B9KMZ2mt5HMvC6ydIZLQWRJJCzeYVKf5JiDp/?=
 =?us-ascii?Q?QRkmasKCGnwgaR2hkcXP+6CL2Q9PGjm2MGi2auaHu+z22TSlVRPfDrqU6NPC?=
 =?us-ascii?Q?ZfHGV7j9cdb01RVMW0DTpecLwJgpld/4UTlzujUs5DYkrx+DZxWX+H5nLjKt?=
 =?us-ascii?Q?D5VuPkBp9ie9E0myfUoS0bBWmePUjCyCbIzgX0h9SWm0/dix4ob/CF70uJvX?=
 =?us-ascii?Q?pWo698/UdTscOVeDl1vN94ZC6PyYYG3xDu6cMPgELuY0V3fTt9vHYspWlURz?=
 =?us-ascii?Q?hXiJ1v03AHrXn3VOTIOj5jTw6rlfMxqOFx/Dz8n0EJJ0XG+VjzjbtcNjO7pP?=
 =?us-ascii?Q?SCUSdgLDcYW9Q9gOnG9GlKRjHULAKbVmTYQSa5nNbQPQexUH3hVTZ+TOkDtr?=
 =?us-ascii?Q?E3Qkh5R/HyHYQYlEHB4FB7gRgBpu0Aq+XtC/AyO3Y+SYlN3x0cK38lQPRhN7?=
 =?us-ascii?Q?YB3TnyCquogexjTzsP0Jbe6OZTp4uaqXvOdYZtdOolCh4UTs2Kj4gbFTbPhv?=
 =?us-ascii?Q?JHPTJr2kKOAncWHxOjR1agu7v7VMem/UMbnL2NRfG/ZK0kgI+I6wGnTL28tz?=
 =?us-ascii?Q?e2EFZuwD3FohOgfgiCARnapE5RtgKFIXS1gpFqu07qgdn6YDbLVkstu8hliw?=
 =?us-ascii?Q?yHRgwKOjMhZngM+b+1DFecjpe2jlZ5hyfprA45+AVfQK7LUvkL1bw7Q2oU7H?=
 =?us-ascii?Q?scpP+uqzooIt0Od/LoKNE+wY3+QkGAp0evx13+Kwlt5f7W5lK9quSsCTmtZ7?=
 =?us-ascii?Q?tk5o+Z/t2nU/Zn6uqfuy3M7KMJdi3Am+MzV8BxX1ZQ=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?K1yog+VfXqmzR4ldi3MJAKQ0B0Xt4hWH2S9AqO5ri+VSxyskD+PNbaM9+dmB?=
 =?us-ascii?Q?scr5AoEj+eZLEeRFOjd6jCCrfDC+i7j1BkSDYRx+i5e8zy2ovlKk87c2VkgM?=
 =?us-ascii?Q?esbcSgj6o2iEsl2aiLcvewb2QO4+xpx6rVjmAv77uRXi+lvDgitVyfYgpNr3?=
 =?us-ascii?Q?jimsTs4nJZiODDqMdZiRbBpy3mhbxCIhDmIoSocHOJDw5kNMgkHt2ApkbHRH?=
 =?us-ascii?Q?6O7xfISPhVQJVLYzzN4wtDs9FPJRrILPLIC92PzCbo6VoB8+GwhlZhLh48bE?=
 =?us-ascii?Q?UvLgyCCo/SrKuifRi0JAdSseeJY2ugBPh/5fRB0KaylVtzpeSZz783UmdFTW?=
 =?us-ascii?Q?RN8cH7v+mG0fIkM4+ABjPHMUZfTjdgX+U1XE8UFhBBfqPWDnNvAy41+Vg9uE?=
 =?us-ascii?Q?gPtc6dsD5tuLdbafu+ZIJp+vZbbM334CU5y8IsvlS8NbU8OlwLkIVE5LvARH?=
 =?us-ascii?Q?kwxauRnnMQbkwo3xaoNhLqYfI6EAvTsknBqOrNsB7EhdfzyGGNF9PpMTJiXx?=
 =?us-ascii?Q?hccRyJgF1gGDgzWt+mPfHRLmPxIzvEp3+lhaIUYOG2mM3jmyKFgLt/j4li/b?=
 =?us-ascii?Q?ByBdDqUHVVNbbPjVZRVZDEKdKoMj2wi+qucWBD2iEwykWo1hubZ2sgAJENsg?=
 =?us-ascii?Q?cLpaCwthH6ey6DZl1zyICuX5/6Sb1gjVNa91khtnPt6Hqf9NlEll3djFcyfN?=
 =?us-ascii?Q?dBdG6h3o2PC8D+TG1cPFqxaT0du786g5/CPITqqraQidguS42jotVhS34VKn?=
 =?us-ascii?Q?4gDbXfTPKWLBOkDBH8ZaFGmdHyqczKkQZQNxZcKkyg6QsYcybqpowJnNhWCb?=
 =?us-ascii?Q?cHlSYndLTRCK5t63T8uf4ZNJaSTsSjzv7U9iR/zXOujHzNNwWbDfP5d42xPz?=
 =?us-ascii?Q?rSG0YJ2hBz8tERgKnmM90VllEQuKaJsZFq9s6L6Q6ODZTX2/h+O+ErtSVp+M?=
 =?us-ascii?Q?wDNZbPu4HGo4LVYw+glrvh+XZxDo1Qj1JyDe5hiID4C0Lxrbuz3Y6oBhlYns?=
 =?us-ascii?Q?AOUi5Px+MY2OoMSeT7eBAviH9gRhc9VNqsM6qz3/CT7luCIXuD9s9FI0Ao8r?=
 =?us-ascii?Q?jN6xbKc9kJWKdvnY6C+XUPH5w7vFKDaP6FM7T7nV7IXdIhYfNZg261c8nTpN?=
 =?us-ascii?Q?exScL21WUno4zt+2RSa/MmmIUr0jr2DVvj/a/XwD0fKviTxr3yh5UVdD1seH?=
 =?us-ascii?Q?MsXnZ1CaV8ep5nmIyiWr2JiFFbVHG/pHkdERszGx9xmV/cpGJcSGdslS/1Vk?=
 =?us-ascii?Q?U33p+/bO9NFh8vHjTycQdtO31dZbCzOUpTJYRDmF9JdO7/dHUjzsvz2N3sIW?=
 =?us-ascii?Q?2PTqhZI9lFRZk0cgJL1ZhSzfAZql6WzDv42/l3QkKo4kNJSkK/BTxddhAxL2?=
 =?us-ascii?Q?4qnJ8UaKI87Ke3+SFKp3zWLQVSVgPU2EH9BeeYfPlVLhIDpaHp15zxvams6h?=
 =?us-ascii?Q?1B+ohkQhpqyClENqPVK68QgQr4mJu7Jw1LRWZHur6ZdQbMps33oFOZYhXsDl?=
 =?us-ascii?Q?Mx9g6fnt+xDAfV8oixLYn6e11Iulwi2wMC2A/GZAvDXcga8ArOxc0J6eb8kV?=
 =?us-ascii?Q?xa0MONfZqY2GBYBoJUh49YLgs1ny4g1adxGl0l8ex22PzOo6pWV9VLC7uvJ4?=
 =?us-ascii?Q?yQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	ehIFmvBng7KYJaHxg9hRMQOouhh9cijU/Vk0qB1OzSK8C/p4PQYTc6LHoB9aRM2bPL36TgQlav6X12vWEJf5tVNVoGEXQD1FE/U6jgMe9iJ4kQ4S9iDOSveXcBO91JZOPS+X8L33QCd5J+/shwOV4Y+iSHCInOy6LAYZRJ/wyTTF29X0p2Vye2ljCwRvPu24Z/yUu+b7TVxbdBx3qbTZ+4QEDYE2sAFRuTGxu9jBnSMDiZomaPVkPS8pVwiHchvRsUa4O6ZDwJJtcDGuwFmJoVyYbg0fNNkF+oZuudZ12IsNjcsTaVPVpsg8sO0KZx/4YiFu0LZvwrhy1l02xb4OoG/Z8I4MWoiTiTXvJGEzhsd5DVXE+mGgTFxKw4WBYCpuzLRWeWvyIPXYWFv7QOmetqM3gPfOIsRX+gMkFIASi8NZGCgjkbfUHpPKASGAb+vTlW335IQVuYhft2otu4heFgOYpwJwtcNNH3gNaHpNxxg5d6qpwIf1tkVbxNvMFdKtuma25e125k5ABdPbyi6zcw3ADRvwedE1jI8yDbbZKWPguF4m6TDpDuIOVoNOHP9dJtc99hBIA44zvd8PUw/upY0bJMb3XmCZ/pCs1PVFgcY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f20a8a12-254a-471c-345e-08dc6de502f8
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2024 15:55:54.6906
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 65apTmxCKYypck5pUNk3A9yYiZoJMCSEW9H6G0Zo3TRyoVB32R0ECoXg9F09m0XwjL8UIanVEoowjGggIclUeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4652
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-06_11,2024-05-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 spamscore=0
 suspectscore=0 adultscore=0 phishscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2405060110
X-Proofpoint-GUID: y9g-NFdvv5G0Xrw1bpo7jBYNoa1gA6Yd
X-Proofpoint-ORIG-GUID: y9g-NFdvv5G0Xrw1bpo7jBYNoa1gA6Yd

On Mon, May 06, 2024 at 06:09:51PM +0300, Sagi Grimberg wrote:
> 
> On 06/05/2024 12:37, Dan Aloni wrote:
> > Under the scenario of IB device bonding, when bringing down one of the
> > ports, or all ports, we saw xprtrdma entering a non-recoverable state
> > where it is not even possible to complete the disconnect and shut it
> > down the mount, requiring a reboot. Following debug, we saw that
> > transport connect never ended after receiving the
> > RDMA_CM_EVENT_DEVICE_REMOVAL callback.
> > 
> > The DEVICE_REMOVAL callback is irrespective of whether the CM_ID is
> > connected, and ESTABLISHED may not have happened. So need to work with
> > each of these states accordingly.
> > 
> > Fixes: 2acc5cae2923 ('xprtrdma: Prevent dereferencing r_xprt->rx_ep after it is freed')
> 
> Is this actually the offending commit ?
> 
> commit bebd031866ca ("xprtrdma: Support unplugging an HCA from under an NFS
> mount")
> is the one assuming DEVICE_REMOVAL triggers a disconnect not accounting that
> the
> cm_id may not be ESTABLISHED (where we need to wake the connect waiter?

I'd be OK with discussing possible culprits in the patch description
but leaving off a Fixes: tag for now.

It would be reasonable to demand that the proposed fix be applied
to each LTS kernel and tested individually to ensure there are no
side-effects or pre-requisites.


> Question though, in DEVICE_REMOVAL the device is going away as soon as the
> cm handler callback returns. Shouldn't nfs release all the device resources
> (related to this
> cm_id)? afaict it was changed in:
> e28ce90083f0 ("xprtrdma: kmalloc rpcrdma_ep separate from rpcrdma_xprt")

In the case where a DEVICE_REMOVAL event fires and a connection
hasn't yet been established, my guess is the ep reference count will
go to zero when rpcrdma_ep_put() is called.


> The patch itself looks reasonable (although I do think that the rdma stack
> expects the
> ulp to have the rdma resources released when the callback returns).

Thanks for the review! Should we add:

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>


> FWIW in nvme we avoided the problem altogether by registering an ib_client
> that is
> called on .remove() and its a separate context that doesn't have all the
> intricacies with
> rdma_cm...

I looked at ib_client, years ago, and thought it would be a lot of
added complexity. With a code sample (NVMe host) maybe I can put
something together.


-- 
Chuck Lever

