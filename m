Return-Path: <linux-nfs+bounces-3533-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B42888D8494
	for <lists+linux-nfs@lfdr.de>; Mon,  3 Jun 2024 16:05:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33EA11F21ED1
	for <lists+linux-nfs@lfdr.de>; Mon,  3 Jun 2024 14:05:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB23212CD9D;
	Mon,  3 Jun 2024 14:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HbwDyUQ4";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="BN/wPmGh"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7FDD12EBC2
	for <linux-nfs@vger.kernel.org>; Mon,  3 Jun 2024 14:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717423507; cv=fail; b=V+G4fFAcPJ6NSPte1MsJL7tjHqaPQ0kvkrePxVuEl3obNSRDEcmVRdf0n4dynHA2j9bWjMZRWKL5aqaAoFfUmUHSDauyXQhOQx++Ys1WdfcXAJXahcCGnFm8B7NkWOyWxPUksambe5ffFBQZ/M2rvM782CUOjFNd2RJ/hvtN8do=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717423507; c=relaxed/simple;
	bh=uIGUms2n5HOti/QR/mlXI0OsTjzVoPGVIWq7j1FVO6A=;
	h=Date:From:To:Subject:Message-ID:Content-Type:Content-Disposition:
	 MIME-Version; b=SisxD104dURQa8L/CC0GrEsrhMC9phVGGKE2Rt/HzJQRcDeGwmoe/G88obd6uSQq3IcYcHW7RI17fKEXOLnl2SPLz6rkCoCkDatXtFMskVJOCBxSkVnws1uwLVl+JiWTcLaGoRMrUPV+X9AyUKEYmVHRmDd7ko/VDMW/z8oYA70=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=HbwDyUQ4; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=BN/wPmGh; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 453CksVk008849
	for <linux-nfs@vger.kernel.org>; Mon, 3 Jun 2024 14:05:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=content-type:date:from:message-id:mime-version:subject:to;
 s=corp-2023-11-20; bh=drVaHP5/XrHFCRhj7LtCvOrvCCUotmiUdsKbpToikS4=;
 b=HbwDyUQ4+JYBbcI0ESaDMsI5IOpGFY22Cz1BM55sXcWSlEU2UmlSIkil8aj+E/FGFJ7Q
 pabdrinlZEAsDXS4dGEZr0HghlydfXFSxf0q+l98kEIT2LVPU3mCnHAMYtsm/ASwMS2g
 EppLUsFTb3x9n/lF+u62dtXOPrKX3Xm6d1QWemBqaFywT1NcaT+vbOA8/0oxSf22GWf0
 RTzp/HmdauHVLwjVhoR/pVxh+NlRh6Sx9v1Q4hHerxfCQ2ZqevhpPx0Wt9fhdEx4cWYs
 NJ/BPWqm0DZLZnkGarlu7rW98cyQJdVvuRAPzQ15JSsJ4QUcHMMw3acaJa13fmPreOKW 1Q== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yfuwm2wsg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-nfs@vger.kernel.org>; Mon, 03 Jun 2024 14:05:04 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 453Ca51U015599
	for <linux-nfs@vger.kernel.org>; Mon, 3 Jun 2024 14:05:03 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ygrjay6ct-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-nfs@vger.kernel.org>; Mon, 03 Jun 2024 14:05:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DLVgQRNsDAIaeMs90xkbgxERrLuudcyCdGhh7qcPj0xRrfH1fXUT+ANPjEL9VhTm46hfF0LBJcGeFVsYoyqebU4A7KCfh+2GdJr8PzP31inW1XKdJaQZI3pxVf/tdX9EK9kq/mDjsymmaFy+oufwj5eQ7zAom0EIYo6MFRXzHiuEEJOR8B5TdWye4RMzIBLByPDgg4aLnsF48kkTyGwDfAsKJR0xpNfZ4em6h1o0V/gzmtr9yd3khxAGoNSPGfk7Wzx6vCzfWdXEs7U+GCwnls5vCmQmJbxF798QOg4uLLxKyf9/7UvSqwXvLoNF5HNoJQWy1q/4FEKqSZX4OIFbhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=drVaHP5/XrHFCRhj7LtCvOrvCCUotmiUdsKbpToikS4=;
 b=c78PJrz5ojYoquqnSPiLgSdf1rq72R31Jx5fpXqLPf1kPUVka9QXULi3WgNFYpM6M2RhPYdrQeInWC2/YbAj3mU971UnDzZm21B4V9PW8T8ZK6UB8nRIkyG2zM47hDv+d1tbiYKDQWAjYqrUBrKCzI7CAbXTXk5Wj7gbL2Bc5D2BU27SRkiG9kSY7+T94L0Ui3BGovGZf0TL1yVD3m7HTu46UrDs1LR35dXehOlr43BE+xYXHOBjCF9zRSBbTeEoUzeOL9koSzZUW9Clu5M3prZvzDcct27bDce5a7Y+hDZ/A3A8X9cB8ROCQ50POLHlW60OKg6YfeE3c1QiKacUdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=drVaHP5/XrHFCRhj7LtCvOrvCCUotmiUdsKbpToikS4=;
 b=BN/wPmGhN0OIc7BJ8N5IuyaQKJ3M9wQk/QFfQxU4mpn1Lb/W1f//lot0K8yh1Kp2g1yQtDbUC8sdyCh7wQ92fHHrMJCWsrfJRAjkBVpIEzXG+XZtrddPqakYizzsqYnNwt89nytfoHFsU/QsaWMaHt3cqm8d/qyA8AlfZC0taFw=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH3PR10MB6715.namprd10.prod.outlook.com (2603:10b6:610:148::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.24; Mon, 3 Jun
 2024 14:04:59 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.7633.021; Mon, 3 Jun 2024
 14:04:59 +0000
Date: Mon, 3 Jun 2024 10:04:56 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: linux-nfs@vger.kernel.org
Subject: long-term stable backports of NFSD patches
Message-ID: <Zl3NiBnuYSeSanWt@tissot.1015granger.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: CH0PR03CA0015.namprd03.prod.outlook.com
 (2603:10b6:610:b0::20) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CH3PR10MB6715:EE_
X-MS-Office365-Filtering-Correlation-Id: 55a7e051-3fc4-4fad-36c6-08dc83d627ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?lqJEeWeIxjiKbgzp2kSExgYI60T1TwhFkg2LxGoOuEOhDRQDO+vfBFA2NhiV?=
 =?us-ascii?Q?kpQJMldliYGXSMQkSOO92GUHaUww+YRm3s0NsMeYv4+lrIFsgWd0FrqX5IiI?=
 =?us-ascii?Q?Qbp7t7oQLFWmkACHpn5Z18DTrwpWEyv5nll8E8f9apbfDQNVpWAmPocw5rqa?=
 =?us-ascii?Q?lqA3wR8tYZ0YnHubsLQzLmM5LHIOcI1rBF4n+4j/duU1mwy9S7LlDrOiSVM6?=
 =?us-ascii?Q?FdTJkbj7l+nr9sg2z9mKjiwgF6jfixM2IDmqkWmSLmQkggxEJJYDT6+Entqp?=
 =?us-ascii?Q?ibVP2XMjWsHnRBPqeWJHrtHITDrQHzofpHDTPTYOVoGFKg0gp4fZEA5T4hxL?=
 =?us-ascii?Q?7twSaBT77rWr7Uib1rD/ZbrZCFzlyDbjPxhfQt0Mas0/nNiazyMjnqYcdt2p?=
 =?us-ascii?Q?Qjzz8HMObQsnScofaHT8ejo/AL6QIoKUkj6LxQ2c3ojxbKWjHskQ2BMwtx0Y?=
 =?us-ascii?Q?iIQTLmkxHjhwXUQfDiJVLDyWnWE3UXmrjDPxocDHH8fs7+DKVDG8K9ZJDbUP?=
 =?us-ascii?Q?OoYnGuMYlapnm1tjT6B6npTpvYZcNmd/aFQF4Lz2o9MHVF41vA7D+h3zltWw?=
 =?us-ascii?Q?8ZSFL7Yrgxeawz0Kls1qYIiLoCl9PxEbMF1IimScVzNqbnZlsrON+/UTz5kl?=
 =?us-ascii?Q?+Pl5X7sNPfKjtThrNC6VSuiYDQ6S0IzH84qyyTQyXvWwRBvEw3X3tlA4Y2WR?=
 =?us-ascii?Q?wDeVrWjv3QHZqC+ryEauDEjEpjALyWHTSMxIvNZirTnHD/vMv+EeZRU0VGOD?=
 =?us-ascii?Q?DyvMeci9YBzIH8WQRAp5nIzKQ648LAAV4BJTfQ80+eRu7Z2EIDfP3pE/T3L8?=
 =?us-ascii?Q?d6CBjMS/adnp3ko35CAJy8Idypzzlb/FQVVHvMj7ie5JpFWj3dbW5ySu3HbI?=
 =?us-ascii?Q?Rgn4qkC73ry9s+yWrnDxOVNRhs4HUL0npHbT24zkKCQoMHqUTgh3989hFlO/?=
 =?us-ascii?Q?UsCHdsGd6zAgzG5CqrwPzs4TuQV6c+aIljLvud6CfXRYLhD22BNXKhz2ez27?=
 =?us-ascii?Q?mp6j76wrL2Twe5obzCB1tRjUJFjWcU5MKYZSFSCeHHIZyFItjFzhdH5eJdCy?=
 =?us-ascii?Q?kfD+cJbDpczi4QgHlkcivuMlu1O4h24xsDC1IjOxETdJcIgxxi+7U/+bfAyU?=
 =?us-ascii?Q?/uLng4ZVbiHBlmBmgJsDLmaaIJoOPn+wgzeLYALYrnrTg8bUv8hKnqDHGjmn?=
 =?us-ascii?Q?fM8BugS2TYf5bYjx3NQuHSobKrTxprOa3hSkjXNMi7PP94XmIdzfhXlNm5K/?=
 =?us-ascii?Q?9HVaiAWdhm6Qen/dvukRXtnex6gK/h//gf6XMqV52w=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?AF0wz6sCBu4Xer/XgrhMKglI2zKses/PcDuddk2dcGC36857FfWwqC6FHqt0?=
 =?us-ascii?Q?DAD5gyjKsnaqNa6CeeHJXEG876aBQOG+TJGdVnRF6uWLykcQRWG8dq3bBlvp?=
 =?us-ascii?Q?Mw/qh5ly3dIZatEEg46hngXIOTQJoSLwD0YCeGAGgbkthXTTFuYgP1TSHXag?=
 =?us-ascii?Q?i7a4/owy3ckmdNze748J9iV7u/dKgR8p23cRfWQ9LDipZ4OoFhNi6J2/XexI?=
 =?us-ascii?Q?QDb33r5aQNVSipE8J5BOhmo61oVlyjiUnHKMYqEvd+TqAHJJYqbaXhCLij1Y?=
 =?us-ascii?Q?q+Mq4cITzQCTdJ9fy+l9eNaEdmVVyzPvueo+yPdVAxVsj3BN8UUd8c4DSIGK?=
 =?us-ascii?Q?7luqwz85x8CkuMvDqOOo2DXZK6CpRB6TBCyB23a6C9ioWs/CmOL5isdZHMqc?=
 =?us-ascii?Q?L0g/vY7Xc74DEig7yB9Ot7EgUnVuDifAatZTmFzTHojnk/xIDv+pRs147daE?=
 =?us-ascii?Q?Cafpjj7H2OmJy6riW8nvvE9X7OStLlV2BPHMLKSKH6amKsc1vZ+xU8odIwGV?=
 =?us-ascii?Q?plnNXJEcVmmc/794z3dSMW5WkQ0zpDYP9PE84rtMkqEpZsl6ZAkUJa75g2hU?=
 =?us-ascii?Q?2YhRX6h/9xKILHCLaRqU6X3LKSZoT0XKBraX4S2XK3erSDT/8EEsEi4/g0Xx?=
 =?us-ascii?Q?o4VgCv+AOzYKB8OnLCwMSNop57zNk6zhgIV1qTEintwNTNIiC6IbpQpA2xbK?=
 =?us-ascii?Q?ybOd8PqsZetWdPctnmDJc9mV3h9kl2Fv9bzzRgaAlyKrmlF0+WaefCRr7n5Q?=
 =?us-ascii?Q?23BDeQTE+ItUGChz62aAsjJ8RqIh/QSPpd2z/h8Xd6Kn0gZHdmkcKm0jDgHA?=
 =?us-ascii?Q?nFvS9k/i7vi1xlgMCJJxwAIJI9x9i/1/IKhSkCrSby5avWT94PMDrLjFmjB4?=
 =?us-ascii?Q?opSvbUPTlYI9Tyjo7MEKSfrIxD2Nq0DgvdegBfnBLuymotKPguLOBYqNW7nw?=
 =?us-ascii?Q?AVrvtO60fMove1Is2GXbRp9CniQDKHyD7ai+vJfyKE7VGjjWdk6P9tUEQnEu?=
 =?us-ascii?Q?r3rPfl5DLWLcV8E1cbngTQnm5p5z+MqNgFhgBnF12X2rquvqRJtXiVFDcZhp?=
 =?us-ascii?Q?q28W8jjD5fFE1C+cbB9jxOc2dPbhcNLpTrgK62JUO9Y2yEt3e6V+nJqBC1fl?=
 =?us-ascii?Q?6s/a88HTnvrfsgvNt4KOlsCYig8DZF4N91zT/80d0Z/N66JjD+2EqC//3j44?=
 =?us-ascii?Q?lkzv4RQBHz9eTRo7l7Pt9VIGfqv5UHeRsKf5i2edpOgjiVFpIfnOaT7tpRQX?=
 =?us-ascii?Q?97SSxUk92LmgKJtksuM1bGNnPx/N6SIw5sfnx5PvheXv479bdS73MaOUOcoe?=
 =?us-ascii?Q?3ilWYscY6VFnLp2Ua+QTaDPZJBVVPlia5z/6BUngafIHdu561ovB4B30Ybov?=
 =?us-ascii?Q?fq+LllzTRcTvINvBHJ1gOHi2TlbhmoiLc/7tF+W/qECJg5ysElO8feJ+Tp0g?=
 =?us-ascii?Q?WG4XER/sgFEC6dh4KTO/l0j7cOFWwnBiFUABVEDBvsvchanEEbQzQ3dV5ih+?=
 =?us-ascii?Q?hN1LiLibd+xp56lkhpzBJWxhseJErjCSpSBXL+zEMGpBwoT53SAG/vhx+4Hz?=
 =?us-ascii?Q?e2evJ/hd6AhzTkSafxKftJpNLOwClPUJdiPwWh5a6NxAD1C9RmyQJHRPpeHT?=
 =?us-ascii?Q?6w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	KstqeMbzHzv7RTDdlpfo6YkdXEmeds3a+labUY8gX8HdS8YHyUAWXrQtMONdt8Ds+3obvUQlAG/jrBVJWhxQchfDWM0k+NLk4/UFb2fyQqHQZ4bo/Y7eOVYNabQjldVdHM3B/DgsTVxcvw5zUTWhkfB6UwcSiH1nfX4KaKsJ9ofujuber99Xt97EZh/LyUyHSWHDY8ZmKIWWIGpwGU0JxZPr3Ma0HXw+P2MKVgyElLLmUVXs+480NBckh9UVKo1vRiJWPS8mtPvkpPqs6gC6jAcSgsI8amEOFLRc92eVOHn1nrOdqAL89i5tQZ1fyl94R9pZx+8fYqvUhY2SzpsdH4BzkH/B9X0QoRzm7pm8iKovoZCU8yBv1SAkgUIkpFVUSSqIcm/ARtwulY0cizzvGVgUJEc+87LlzJETtvalyzppnd0w3L1tdLCPsMhBdd0CBfyPF+wZN+B6eV2Aivc1bmdLVCH2ktuEyB+/fbc0m9qNCjt55Yxrnl4KGqsFZcXVSrw2fuuMQmiWjBNdEvbzqYcZGUKhUC434RoIiEprFMGreKt9GBpfXeHYQhVVojGLwT+iso7cUl48ETjc6NRN3x5xyZXra9jQyPWWW8Bc478=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55a7e051-3fc4-4fad-36c6-08dc83d627ba
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2024 14:04:59.3307
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5++2wO1+TH6VlTF+fKUzBR6qtFWZQ7r6u2rkEErFPOWmxg2jzy2JUMgHwvcnwTrj2Cr3MPNioOca1jVOXMzpnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6715
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-06-03_09,2024-05-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 adultscore=0 bulkscore=0 spamscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2406030117
X-Proofpoint-GUID: 8xZ8HY6NkMGUVLzKbj00MwCHKyAOZwHU
X-Proofpoint-ORIG-GUID: 8xZ8HY6NkMGUVLzKbj00MwCHKyAOZwHU

It's apparent that a number of distributions and their customers
remain on long-term stable kernels. We are aware of the scalability
problems and other bugs in NFSD in kernels between v5.4 and v6.1.

To address the filecache and other scalability problems in those
kernels, I'm preparing backported patches of NFSD fixes for several
popular LTS kernels. These backports are destined for the official
LTS kernel branches so that distributions can easily integrate them
into their products.

Once this effort is complete, Greg and Sasha will continue to be
responsible for backporting NFSD-related fixes from upstream into
the LTS kernels.

---

I've pushed the NFSD backports to branches in this repo:

https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git

If you are able, I encourage you to pull these, review them or try
them out, and report any issues or successes. I'm currently using
the NFS workflows in kdevops as the testing platform, but am
planning to include other tests.


LTS v5.15.y
There has been one new report of problems with freezing NFSD threads
in linux-5.15.y, which Neil tracked down and fixed. The patch must
also be applied to nfsd-5.10.y.


LTS v5.10.y

I've continued to build out automated NFSD testing for this kernel
and origin/linux-5.10.y. I plan to send this patch series to Greg
and Sasha soon.

You can find this series in the "nfsd-5.10.y" branch in the above
repo.


-- 
Chuck Lever

