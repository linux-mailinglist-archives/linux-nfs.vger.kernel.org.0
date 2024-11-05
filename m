Return-Path: <linux-nfs+bounces-7675-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C10F9BD799
	for <lists+linux-nfs@lfdr.de>; Tue,  5 Nov 2024 22:28:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DDFC1C20B7E
	for <lists+linux-nfs@lfdr.de>; Tue,  5 Nov 2024 21:28:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 843581E0B65;
	Tue,  5 Nov 2024 21:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hP6ayixy";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="FGROuRNH"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 973C9216204
	for <linux-nfs@vger.kernel.org>; Tue,  5 Nov 2024 21:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730842126; cv=fail; b=lBsFV2pd9VuHBpyGfuwT9XJLnNUWferakxQsbfr5pHuqmG9XYfQnUgjAFKbHdkf+sqqTSa6s7FQlRw1F70AKKy0hyY9fah7hk+VDUjY0K+BDqd71deso2XlbKQwBlX/WSgal86D/YJKriOU4XVRrOBTFSgLvoG6PrwEShL4I0Wk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730842126; c=relaxed/simple;
	bh=SxuVldkzhQ8Ep6CpRSKy/foOH279BcudtRxFJiUPQhY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=uvxMhjV0dmEt3NzTm0kE0KNVpTssnOR0qQO55uyQeBWbbIljiydGPA2dEiWFKVhizj6TwLP7P3AbMxANdQuYh/5p5MRqq+eLFxWd3j7S6dxCKOKfNg9wsYL9dHoaRe8zhaOT1PWadJUj6XLN22l7zBTjnA8gQr8kZ8weuXF+1+8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=hP6ayixy; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=FGROuRNH; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A5KfZaa007096;
	Tue, 5 Nov 2024 21:28:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=VQj/FxgTebQ73bvVMH
	TxVxYdeA8FjZY1F6LI9wLSpP8=; b=hP6ayixyYfczXs+mOh7Gu0pEtxczI6cpgC
	jV4TuANmSvBB1bb7x4/tbMcILn0UvYblGcnX88U/g2DU0JgdP/yPIEP5RohoezDL
	BQX/CSZHSxoCMtzWX1qS6YpEGuZhvDC0EN2OdBnNuQA6vsqoH9Fqa84NvJMMawp5
	CYObQUjTrKUB99e6c4pf5DYvEr/D+rbMy6nLO7Gke5R/ZOnoGdBlVC9LTpu1h4sl
	Rpj23NFmXEUniSQMqyNDZ4Pr+eW/EC5dkOHct2DOblSNlY20DVmDbZ2rh45WwR1Y
	+G5b6uSgkAhSn1zGAKu9akFoFUB98oY30m8TQVMKArpRsxUV3lxw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42nbpspfs2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 05 Nov 2024 21:28:34 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4A5LIG1h037339;
	Tue, 5 Nov 2024 21:28:33 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42nah7pm3c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 05 Nov 2024 21:28:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XXPpDXLqiTmE23tAk+U07vjykloLplEjfWso0bQ/ZBbY8Hg0jSxYOEE4t1lUcKmQkjo9tleoaqPHKMpDkRjsCrTd1WG6edCa4CZEdoAod3eX24JVVdyBBN1TY5ju9CrXU/8R2pox1E2kO/IYQRsIz+4mEnCM0xUgcCK4OfXOdwSEU1Uef5opEcDcjRUc82XaG2InSzjDOaUyj8VT+XQZMvlRO1loByfNig1RJSC55olUwkEGb43zH2DWTenUh8NJp8gIRhai7HDy3tlbodkqOhMBUgbvAc524KSOmEgR3OV+1go97+m5NMqf9wkcsuIPrzvaqxKwQUlco4oq87+Lfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VQj/FxgTebQ73bvVMHTxVxYdeA8FjZY1F6LI9wLSpP8=;
 b=NtIPcGxxghCvoGcQsRvoyx+4Pvtx6US50eMr6GNP2fgF8wZjUdEzwwBOOGYgjGj40NmuPWb01xbssMF0pROnQztKJ4Zo0uHnSUePL5fpj33OIasXMY4omrKNx7QbTW/U93fC2ZPsftVbiIeewxvkx9jrAmYiArXmUs6YSaWIin9fRlbLw1f0t6dW9Mo3r7PLHOiBUtXX6c1+FjeIzICqPRceqJv72qv3PF+Hnbgm2uVL/+v3n5lNhYqJW/EhQ1nN0kEBe578zAUQNVjdvC5lKInn9iTyOFVgekYJ9qPQ5BkEFaxO2184CKxtQMtKD/pFwY/2ZDfEE4zsys+6iN2ZaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VQj/FxgTebQ73bvVMHTxVxYdeA8FjZY1F6LI9wLSpP8=;
 b=FGROuRNHrwie6TOdH4TGvr8hiK0N82+g04DauFNI2fwKw377Mb55cNiPZBKdDJ9aLfTqQVRwtIEAqnJ1XM45TiAIQPU/Ksqg0GHrItqs/g2aRZstWOK8w5WvSWD2hD9okONfbSPGobqLwoJ/NlemX4yZm4UMDReIWK4I3JttfRQ=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH8PR10MB6504.namprd10.prod.outlook.com (2603:10b6:510:228::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Tue, 5 Nov
 2024 21:28:27 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.8114.031; Tue, 5 Nov 2024
 21:28:27 +0000
Date: Tue, 5 Nov 2024 16:28:24 -0500
From: Chuck Lever <chuck.lever@oracle.com>
To: NeilBrown <neilb@suse.de>
Cc: Jeff Layton <jlayton@kernel.org>, Olga Kornievskaia <okorniev@redhat.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        linux-nfs@vger.kernel.org
Subject: Re: [PATCH] nfsd: fallback to sync COPY if async not possible
Message-ID: <ZyqN+DSQydG84DNe@tissot.1015granger.net>
References: <>
 <ZyovsQBNlmoSLWED@tissot.1015granger.net>
 <173084080089.1734440.10665206263775584488@noble.neil.brown.name>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <173084080089.1734440.10665206263775584488@noble.neil.brown.name>
X-ClientProxiedBy: CH0PR03CA0111.namprd03.prod.outlook.com
 (2603:10b6:610:cd::26) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|PH8PR10MB6504:EE_
X-MS-Office365-Filtering-Correlation-Id: eab9ef0a-4460-4bd6-1172-08dcfde0c92f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?r52o4IFx83RPIPUyf0lnm8zkUuZ9Yne2qPg+d5KV/1Puyk7gBcRgJSuFRgsQ?=
 =?us-ascii?Q?HTIef3FuGzqTwJ8JMJVU6G4TbbVPf+VZ5ft5RZnW2ZVT1inPtmA5IvxcUSjM?=
 =?us-ascii?Q?YPpu+Gkai4TcgCxV9Tfb2gG8+fSgd+EYdFiIqjFKrETEEOgUYlupGOk+PZfI?=
 =?us-ascii?Q?H9ONa0k65CoQQOd0iMkSSkr5rc//tTb+4gAguxujrImcH974XGjAdh+h2aJo?=
 =?us-ascii?Q?vn9UFL2Vy2keOQ44h0EcazkMQxaCHQIN6Xx0/WwUaAR+DP+CGE5c7b/cPQSx?=
 =?us-ascii?Q?6CuJ6w0z5KW12JprjVGYwIe+02y8GpJpIBL5yMEsHETRJD1F10dRNGOEGEa9?=
 =?us-ascii?Q?9zZ5VfAlEnyi1NV0h20T6l/Xzx4K9YeQ4o33BkxQJaDPjN8NlG9nsQHRDab1?=
 =?us-ascii?Q?hV7xIhgPyT4uRlISt82WgFxRlb9YR2hWNe6tad/5+2RQe/SuXBsmQUSDjHRj?=
 =?us-ascii?Q?mYjKxbbMziPZVV/aJEsShI4t84xx4am6rY+ciNv22bJekAYt4TG+mSASmrIi?=
 =?us-ascii?Q?97wJIOOyuGKg7PjUQrjs4G/ekpOHZGT9AxoCOwSakO1b1NXW9XdTJyrQumFh?=
 =?us-ascii?Q?KfJDTZPQtTE7SmbPgH5e/Q6GAprzCbDuoa8fN1mj9VMQncfC2dHwBoy+4gHH?=
 =?us-ascii?Q?AD93PwPPJob3WYvKrKWqYakH+ps0ccBN6MnWIzEgdRn+PLfi0v5OBSA2H9OZ?=
 =?us-ascii?Q?cJfIrymQ6W0GMtDWVsYJjqVBuMKxBxuwZHsuqx25SPSpFENTIviUUQLDqPlh?=
 =?us-ascii?Q?ui1z5vypRJdr9N1x4qW/jubd4EtrEqTCV4SSFazcssXELFphM8CQ8Diopl/6?=
 =?us-ascii?Q?MGA/PTSGroRXoT5svDG40H5A/ySqhZ+kuKQcUjHyr41l8KECdj4GRLKRVOdV?=
 =?us-ascii?Q?v/o0bmpdo7QVjfguuU27JA+tgnzm/c0Ajbie8HNUnYsoXqGIgRvbCZWqQkW1?=
 =?us-ascii?Q?WCmcgbbUWTlCitFy+UE+IY+VsxISd4uRmTRBNOfgj8gSwlwGkHeIF5dbq3eL?=
 =?us-ascii?Q?A6R7fADetIezcegvuJn4lC31jOJpFyjMHlkaxV596xolvQnx5oDY/jnTGBKl?=
 =?us-ascii?Q?vH3F34OqC7F1ikQnIDRWg6yMTCWPFmq8+P0vamR3Dhk00xLmqIfcHeBnDzyt?=
 =?us-ascii?Q?wUg0sY4UgRbWdAXxWNMrdoiRffXInRnw3MSVIHk6CintL3v2cT3V/aJJzx6B?=
 =?us-ascii?Q?d/jZRSDLCApZ9/T7lUs7g9cFGxHHzq/VZqr9EYB7mfSTNuud+naQHByqWEMF?=
 =?us-ascii?Q?7EaqDs+i4tUlQRWpyVeAr7gh46Q79cGz1hLDmT2cwtRDx/EkedW+JJl7gVjl?=
 =?us-ascii?Q?qhOl2cKrpmCds3W2vWj2wSOm?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8f3gS75BNHgMOPJ+EmdD9MqTMzx4dxVS0IVOOsQUURR3PZWPHh4xfKuYswE3?=
 =?us-ascii?Q?j8+IjBhPJXG/ApLtcPC/255OAKhx3in1bFsd5NPMKHDwac9NGM4HnKTMa4cr?=
 =?us-ascii?Q?KfzHKaYavc+iH9ZEQu49dC9bNXm7m4VIC3feDb6m6VX+Hrqeq8+7bESS60NV?=
 =?us-ascii?Q?Ynw0BlF3yLgKMJy+gjkaKiIFBP499LurQfY2xlAHXCXREVtkZKmoI6WsFCeX?=
 =?us-ascii?Q?MEr05YeIB7UhRGrntfRjOQUCHrGhJqrLJjT/dCPTq8HBw4SGVg8e+eQif+f7?=
 =?us-ascii?Q?7w71e3Z4sNK0fEvlapHHAF+yYo2DtKbbHpkS46Eay+UxGidnM1iVXwhVo0Hp?=
 =?us-ascii?Q?xTq4bwh2aDPrOl+twkGr4+NhgwgkTHEC8dC5kbp2bYcMLirJjaxylKdu9vt2?=
 =?us-ascii?Q?8+U3BPak66ya4yYXRUM+IkOhaFRNX5zg1mEQZteTZQ85zOa6Pgxrx469ld5f?=
 =?us-ascii?Q?1i2Pv8JvUE3WqRu55LOtUQmronIGlBLC0roFe6mS1LvCCQvhgvu3d8U1p6OQ?=
 =?us-ascii?Q?bxW+B9dqQ3D+EJmy5PVIGvAIdDem+b3oz8kFrIpM989dRgtHVrLjnWgBC5p2?=
 =?us-ascii?Q?4nop6mGq1AKMtowDPeFS2m2EHl2yqtaVES1zLaNm0QG+uYq5EQtI5uRNTuZI?=
 =?us-ascii?Q?voKoIxI65vmAwBG+FNCyxf+gq6vaav2o2N3AdDGqo6coXTseYA17OB7xniFw?=
 =?us-ascii?Q?VP+l4VmERPo371t8CtTSJTofMaSIll2gLCosT0IPsJBUBPM14yA8bEzHM1en?=
 =?us-ascii?Q?JSDP1MqF1P/fZVMKvkzZs5KeeT3akfDU7Una4liUxmV3d5OWq2zXWGxxgudG?=
 =?us-ascii?Q?IGU508n8z+tcVgtUs/f+5w2Hu2R0c4GzuNwHw22WasdBdO0Wh33+/NCZKKs1?=
 =?us-ascii?Q?aQK0ewopSVaD+7N/Kdun69Pb+uxiWNms2gO76+afmtDnalA1pYI6CSw9GXQ7?=
 =?us-ascii?Q?XT/FNhHdOTjpl+biWQKdEcQvmlJC5wP34GktGXaeG7xVTLQXZo8OBr9jCJGh?=
 =?us-ascii?Q?KpSG2Jh54NtvRLqdlXo0lMPPfu1yI8+4QUsv3kyE0vUz/xdwwGJHjI1xmGpw?=
 =?us-ascii?Q?jbY7gHOoGWiPoS/0t8cNOnYxmAF/bVw6u3JZuTGm8CxF7OP5ioLlHuYuxpAZ?=
 =?us-ascii?Q?cUzGHyn0g5Ljw+yUQvNKBL3iuy+8Gm5R3NrSk46L3+r3Cs5K7IqrIi+WT1Hq?=
 =?us-ascii?Q?DmsdB0VvLLwL8dwmPSjPn3WucovX5Q1kZTlBJQXTKtCfqcUx0YZf/VJzhk9w?=
 =?us-ascii?Q?xaGI3jna81duCZr22eq/XBfH6/zIrB3tK/QxY8czOxfKXsc0nWbJIC5poAsW?=
 =?us-ascii?Q?o3T0tdoPfdaW1r5GJohsIIt8u5oO3xrEcqm771L8JhMyLpU1kgtTS9vq7Hd5?=
 =?us-ascii?Q?+X24bs4/VLMjdvnCDmfPhHd5VeFLf+kz+80VApaUP3mETqWtcI59JJETUlyH?=
 =?us-ascii?Q?Z+BR+p6H5MCZp9nLLf++UacKSLBjlieyhkXzn9h9MtQpCiL1DtCx8wCrl3az?=
 =?us-ascii?Q?bb/y8ou6c67Dnpjpz/JwlXecJFdNr+sx+BbURQtJsvFVz36NhPcwbb4wshxT?=
 =?us-ascii?Q?89MtE7tqJSww3lTGq8WuCXjwlHVItowu1/yPoaUd?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	8R5NN4Cw2Wf9jdci6/g8kUIL/AhO+5GxoRG0yKAKHcGosp1dVzviyi/EkhPIjAkxeBJePqTAy4cZblCfeX4ue6SyGxAMafPVdKLS1tYVkkfP1i9sgE3i5iXayGeNiAWM+71pFf6T/sRBcMZWLjHpTCqdZKDo7SYF85jBTgU+hRI5vJ0eszlujoNmguS+fTYI3msN1eHzepmrVnSsHv2bSRy5PC9iErPiTBBoYUvJ04wAMfZ6dxQtVxfZCriKrrkdZmaROzGOapPaegMpd5UYfTlAW4YglzsILpfpYtkesiw+FKLCXCjX48CIABFzorNBH4RMY0zZABd413OKBi3zzqKgUMVAvvPwBXUerafl85AmR7qiAmf7bg9LlYjOSgSEIivaeQTl36OltUFhFvMcj9wyfemJ1/ixprToYz/EgnkQct+7miinmx9UiCtkqj+8qb/g5aQJSaVhS9ke98V7XmJzzobXA5JGErIPidzedOj1yA0XZpjblO+BirqwUve/5uRS60ECIbCibWxVuSO3mkgA8JhjH2bkQB76jyO2OPHD0AAAMAdM/L9x1OfLF7fGv0JPicuvwc1CVeZUnhbpwRP4wIVooeMS07SfWuGiWUs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eab9ef0a-4460-4bd6-1172-08dcfde0c92f
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2024 21:28:27.1323
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BvqRNYdkkRAUBEZbteAtus4Giw6HOY50rl8St2WG/0/SWQP5JQD+vb7C884/8pohmsMF3LaMYWdt+ZHZskv4aA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6504
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-05_06,2024-11-05_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 mlxscore=0
 malwarescore=0 suspectscore=0 phishscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411050166
X-Proofpoint-ORIG-GUID: l7eSmSWeLE0lOOExkA7kihH5p4vb_pAx
X-Proofpoint-GUID: l7eSmSWeLE0lOOExkA7kihH5p4vb_pAx

On Wed, Nov 06, 2024 at 08:06:40AM +1100, NeilBrown wrote:
> On Wed, 06 Nov 2024, Chuck Lever wrote:
> > But more importantly, the problem with the automatic backport
> > mechanism is that marked patches are taken /immediately/ into
> > stable. They don't get the kind of soak time that a normally-merged
> > unmarked patch gets. The only way to ensure they get any real-world
> > test experience at all is to not mark them, and then come back to
> > them later and explicitly request a backport.
> > 
> > And, generally, we want to know that a patch destined for LTS
> > kernels has actually been applied to and tested on LTS first.
> > Automatically backported patches don't get that verification at all.
> 
> I thought it was possible to mark patches to tell the stable team
> exactly what you want.  Greg certainly seems eager to give maintainers as
> much control as they ask for - without requiring them to do anything
> they don't want to do.

Yes, Greg and Sasha want to do something constructive. I see
suggestions flying by from time to time. The last specific one I
think was rejected by Linus. It appears to be an ongoing
conversation.


> If you have a clear idea of what you want, it
> might be good to spell that out and ask how to achieve it.

Perhaps having a separate review process, where each patch in
nfsd-next is audited just before the merge window to see whether it
should be marked for stable, would help. Keeping written notes on
these decisions would also be helpful; Greg asks when an explicit
backport request comes by why it wasn't marked when it went into
Linus' branch.

Making it easier / more automated to test-apply such patches to LTS
kernels is also something to think about. I have nightly CI for
those branches, but it tests what is already in the LTS queue rather
than testing NFSD-specific patches.


-- 
Chuck Lever

