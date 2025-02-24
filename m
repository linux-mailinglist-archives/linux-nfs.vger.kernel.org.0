Return-Path: <linux-nfs+bounces-10314-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 748C7A4249E
	for <lists+linux-nfs@lfdr.de>; Mon, 24 Feb 2025 15:59:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BAC9C18916F3
	for <lists+linux-nfs@lfdr.de>; Mon, 24 Feb 2025 14:51:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81FA0221F31;
	Mon, 24 Feb 2025 14:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jQvKOO9o";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="bLrJfAIq"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2AA81B7F4
	for <linux-nfs@vger.kernel.org>; Mon, 24 Feb 2025 14:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740408517; cv=fail; b=UfTK47RXvkrK+mDVADxbvs673rWCvc38DH4rB3/bSE4MiBpsWAc0/nCiSJTONMCOAuNbU1nQdU/UJD3D/NOE2vKMte9ejjoPhBcgE/Bj4Y3vKpT5fUqMYdvZhpxudPs+ABQKpg+zhLuxYZGWtnhXmjGplBOsPhBla9TxvW3kkjc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740408517; c=relaxed/simple;
	bh=GQlCaSxIcmwPyseUxWpz1X2nU1PD0p8FdAry79bJLfo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hbsMUnQaYGpUp5+BSC/kMg6lB0TRocr20lwqrXY96BgZcUpGyMZsI0CZf4QtAw29eCb+iuVJ9LRR+sIqhV8R8CQrn3vyqx+8sSpZPFAfzQfBQT8rtRxkgLnR6tXr/v9YzP3Dbq+gLmlAWJc2RXvLFphckvYbP8am1CYYK7hLipA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=jQvKOO9o; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=bLrJfAIq; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51OBMtJU017702;
	Mon, 24 Feb 2025 14:48:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=arAybgGJGVOB3mPyAjouKJam1bKBqDSNL50x86uCPYk=; b=
	jQvKOO9ozVPdeAW7nbwZjfmhA128C8MY1vwYQvY8/ZN/l2OhegO3vRZo2mmSGNAj
	JEp2Ct1ZkYBYPSMI3KklzrRz+1Lk0DTUUbjHCzcFPhAZ9d8cmnj98rvK2PxToLr7
	xUnNxSmGTeFk0txIllnAnTAm9Zg3Irron+HFhKZ5fF0Mo5du3d3ho5kZSFLpqvv4
	uqkDERyyh9LmH1jDWvv5Jm8gYPHiHlHuwuN6AutgJUU9gnvPZ+UxLuwR+wO1kG64
	GB2K9+QklamJvprhsLDFA2GDZ1Y7b1pNCylO7oPArIFsZUTRrQvTYwZIoiqVs14L
	iBHXM18csfUiJN4nSvQ/hQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44y5602qyq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Feb 2025 14:48:20 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51OELpCw012702;
	Mon, 24 Feb 2025 14:48:20 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2041.outbound.protection.outlook.com [104.47.57.41])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44y5190qtn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Feb 2025 14:48:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wn14jV+g9mLyCdJ6Z8SJH9iBfrdwTmX0rV4UMOdAaphU7ao0bZqN6zEKf4k4lve21icE77XpDiwb6ug2u1Z+De5ZLa/QxQC3+yq1BnerKmms/kbCm7FPfVbOQAjVMdS3nEMPGmgUyS1jcPdEvJYkFs1dAPp0+nRgv+2ziRicECCf8+WPwjf0T1pBbEVyC12sxaXi6A/UHUDvgpMH4JDdu3PNcmx54liuybJt77rcWdTresljpSA9Xwn4csHfWDx1LLiJC4rDOCOT47V7eQ6jgpJ7p0iSGEdlZFg75RHaFs7BvcwE6SoOE3Vjo7iqmnkOWtuiX5eX1tDI3jflvQE4IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=arAybgGJGVOB3mPyAjouKJam1bKBqDSNL50x86uCPYk=;
 b=vaQiS2DpmcFpmEBqceaEGbVDE4C4hvlCFLWkK2poOcJb8ZnGZ76XsA9fdH6YJEX8R/NssJ4LPQesATABCrbJTfRj6LazJNBrNiJEgH8y0Xnl2sY/pMSaYy/2RM4IpwBIk91WxC4bP9xNYRJYmyGQiNXO7Trvf6VzRI8W6KE3JudLgujeUQugvhahm82ksklC4ReCTD/T8eql8phHZDqLwRq/SNdYRJFl6b8aqBqV1lfFT4rPH+0BLQtkFHKn+uykH7h3aQxOXhqKNX83+Wkw2wBK+LCJhWB7qowkf59mVmYHDjHXIAGQspx1oljb6Y4lX8kcAy+hcgs2X+wjOqa1WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=arAybgGJGVOB3mPyAjouKJam1bKBqDSNL50x86uCPYk=;
 b=bLrJfAIqRK02dnE0ljOIam8hPltXQYZ5o6GiqYNuiKsAKXe0w90a9yvBgmpeKZoQhg4ro+9NlAzyj/Pp3duugB31/+hLtKDzXovEp349jMC0EyYuCROjriHXK9RQpjuTRIDTLILrPG1GnclIvFrruVVk9zwVA4NIv2hOtpLiUS4=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS0PR10MB7245.namprd10.prod.outlook.com (2603:10b6:8:fd::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.20; Mon, 24 Feb 2025 14:48:17 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.8466.020; Mon, 24 Feb 2025
 14:48:17 +0000
Message-ID: <4d607c89-8500-4d4a-ae42-09987b16e2d0@oracle.com>
Date: Mon, 24 Feb 2025 09:48:15 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 2/2] NFSD: allow client to use write delegation stateid
 for READ
To: Dai Ngo <dai.ngo@oracle.com>, jlayton@kernel.org, neilb@suse.de,
        okorniev@redhat.com, tom@talpey.com
Cc: linux-nfs@vger.kernel.org, sagi@grimberg.me
References: <1740181340-14562-1-git-send-email-dai.ngo@oracle.com>
 <1740181340-14562-3-git-send-email-dai.ngo@oracle.com>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <1740181340-14562-3-git-send-email-dai.ngo@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0406.namprd03.prod.outlook.com
 (2603:10b6:610:11b::14) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|DS0PR10MB7245:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b078faf-c4e7-439b-13c7-08dd54e24621
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bkVwQzdOMFhJN01yUS9INzNNcUJJZGlsNmdzY0hnbHZDUEhXaWJhSm5HaStt?=
 =?utf-8?B?TmlwaDd0WGphakVYblBUOElPc2Jwa0RHS1dlT1hTREVoV0xNeHZaT3AwdDhG?=
 =?utf-8?B?RFpWQmJtd056bnBYN1prcVRjNzVPdFdYZ2xRYmxiZ3Y3M29kN0x6SFVYS2ZG?=
 =?utf-8?B?TldDOFFkbGF2akJEWlFFTGpFTFpKYWJXemZnUGNsT3J2T0xTcHlWdW02Qmsv?=
 =?utf-8?B?bk5sek9EVW5ZRFhQYmg3aXFvTDhRYWdiTTZYWmtGcHUxQUNoY1p3OGoxQ2wz?=
 =?utf-8?B?SEozUU15NUN5bDBMQjBwdnNoeS8zVlp3UTU2TlhoUzJtVmZNQkt0TncwemRz?=
 =?utf-8?B?aHB5ajhCd21wQ2xGaWNPL1RiL3RUb0sybkNTdGlyeldLQWlNYzRONUdxWmM0?=
 =?utf-8?B?dGczZi9CRm4wRWpLcmdLTHFCVTZnN09Xcld4VmwvbCthVXpweENjUUhEZVVm?=
 =?utf-8?B?UWdyOGM2SnZYK3BucmM3b2drVGpRVkZkSGd4cnc5MC9CMzd6T2hyb2UyUExH?=
 =?utf-8?B?VVVscnAyc0hZT3dSUXZiSDlNcGpDVUNUUXNHTUZCYzkxcjhGTVBRUnpweFox?=
 =?utf-8?B?eFQ2U3A4OE90THJ6SWRDU3ZoV2VaRTVqT2dwWVNoNHd5Ulg0YXRSMllBRlNG?=
 =?utf-8?B?MTVGZHhqbEJPMjBIYTFHRldUV0t1N2cyMHEzYlRKdGk4REc5djI0a1dmcXZK?=
 =?utf-8?B?ZzI5bnl6a0pyTVcySTkwK2EyUDgxdnNEQk1nclprdEJ4bnZBMVVYNWdTajF1?=
 =?utf-8?B?VU9RYXpTRFBTamJXYmI3bWFpVHZtVUtQL1BkRDM2OS9pcU1vVkVGM3NFVC9o?=
 =?utf-8?B?ZjNaSFUrUGkzMDJid0hucFVoSk5IdnBTcXU1R3dGZDFhS1FHaTNydU9oOHJF?=
 =?utf-8?B?ZUVtaUFPV1hZci85djFqSHJ6RmNMdGZNdGk2KzNCV2xkUlZjWFJhOGVLZkFB?=
 =?utf-8?B?M0kvaXJ3dCtlQ3JORFF4U2dzRWxpenFTaUtKWmVtaHRQNWJNckRuYWw2VWhT?=
 =?utf-8?B?OCtRRmVsa21PdTVPZ0ppLzV3VWtrUEpNOFN2dURPdXRka3ZnZTlaRnVkMHVL?=
 =?utf-8?B?enltQnVjV05vMDhjSGRwalhUNVVYYStPZTh6eFdYK0RjZkYzZzN4SkVOZHk5?=
 =?utf-8?B?b0pwbmdmYVBlMDNGZXg4S0hHckt0UVc5SzIrRWJmOGZTTGZqWis2Y1d6MDJu?=
 =?utf-8?B?NHZzc1FUS202bjIxeitVMTZqS0M4bkZiQ3I4d2xwdFFlZktrc1lXMys0a3d5?=
 =?utf-8?B?RG15S0xKUFc2c2Zhc3VsT040VGFOT1pubGdFcnJzSjVIcFpnSnJEMkxMWWk2?=
 =?utf-8?B?NWxva3JTY1JibTVOK0d1N3VhQUVIKzZKM1VyLzZYK0c1OXZrSXpIbGwyQjg2?=
 =?utf-8?B?M1RoSzZiU1VzRUVuR2dXR0NDb0hPZVFXV0F6VHkwdWFvYkVXMkx0b1lleTdW?=
 =?utf-8?B?TE9uT1lXcjQ5b2NIK3R1NXBUNXNIY29NZ1hDK0RQRGFINVE5bU9yOHNVQXAy?=
 =?utf-8?B?M2srTEZUTDB1M0tVemswTENlbUl2dzlRWFc3MHF5dFJXTGMzV2YwTlFYUEFv?=
 =?utf-8?B?TE4vQkdaZHpMU2hMTEZZWU1QYlhyajlvcnV2RUlSL1VJOHptY3hYTXRreVp2?=
 =?utf-8?B?TjgwNjdHR3RxbUt5aFdYdjEzUk5IOTdjemdGOGx6d2tTWWhkZ3UvZ2duLy9i?=
 =?utf-8?B?czlwZkFMRlBDaWhaLzBOb1VBOGlIUzg4dXlkTG55UXdiMGxZQ0grRWxDTWhY?=
 =?utf-8?B?eXlRMTBkTjJ3ako2UkV5bXV1dGVUU1V0SktUMktPeEtYc2NtS2RlMTgyZW5E?=
 =?utf-8?B?cUgzc04ySWMyZVhKOWREcFlOZVFsdHVLUHdjd0Z6bk8rd0t1RmxDVTYwcDh4?=
 =?utf-8?Q?x6abMf6lGswRv?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N2R6WUduTk8zeWFxREFreW9YL1k2d0JUNGJkc2I0bEpJbFZwR3gwMVVmSklh?=
 =?utf-8?B?b3hwbWV4OUVhU3hrVnFwdVpVcjJuTHJOcXYyQm1aZktYbXI2eDVWTytvRG0w?=
 =?utf-8?B?QXpNWUc0d0RpS1R0a29VcHpHOExGT0IrM3hVSEEzWENybXJmSzg0WW1ES2Rk?=
 =?utf-8?B?ZEZqMFdIMDBWbWZKYU11Uk55bjBFQm1Calg3Q3gvWTl3d1dEdDYrejFYTHhP?=
 =?utf-8?B?Kzd2dnY3Y3g0clpVRmRaVHl6UG1LeFB1UjNwSkVYWWxvRGRHQWxCRTh0V0k1?=
 =?utf-8?B?NkpHVnFpd2xWNVVabElaeHNxY3I3LzlSOHRYS2lHcDBRdDJaVTdVcFJGdVBl?=
 =?utf-8?B?d0lvMGc1MGMvai8ySE1scnJvSkpjeDZ4NVloeWNuQ3YwR1g3eDZpdUpPd1Zu?=
 =?utf-8?B?ODhRUDBHTGh0SjVrK1JSRHJDNnBSSTdJV2p0NG11bXJiajRZVFFYZVY3dGFU?=
 =?utf-8?B?Qm9GOVBuK20rR20vdDcxZW05RTQzYVk0d3AyN0pSQVlLTnpnOG9lUEJ6K3Iy?=
 =?utf-8?B?eDFvUEtFSG9tdEZ6N2xhcVdFa01KaEt5Mi8wU2ZxWlZXbUpPRVpxRFZrYWZQ?=
 =?utf-8?B?V2FEOUV3Tm9aQ0pQdzQ0REZ3Q2IwcWRacytNbVJjd05od3pVVnRTbjFGQ3NL?=
 =?utf-8?B?cUpUOWNuQkJRK0tZd1pYaUtreHNwL1NFTzBCdS8zb3oxa1AzRkdCUjdjdk85?=
 =?utf-8?B?S3g5MGNPdGpESWE2NXF6ajl0Z0NQTnNmTE1WaHQwYlNJb0ZSODlIbXZTNUdh?=
 =?utf-8?B?Z0dOb3pMbkxMNnlkck5VQmR5QW9qcUZ0N2w0eDh2MllnVHBIZkFuSHNXUTVn?=
 =?utf-8?B?T3RtUTNTQlc0UmVTUmt1TzdDUkt4OHEvSDBCeEdOOHZNc3JveWFrUnNnNjdw?=
 =?utf-8?B?T3JTR21GbHVseGNUU1VraklJOGNxVldxRFV2R2Fia1p6em5jeG1nZkFQeEV1?=
 =?utf-8?B?WWg3a3NUdHgwck5UelhOZHB0Q2ZxVXl0NUxsR01aYlp5UkdGOGFQbkRSenVR?=
 =?utf-8?B?blFRQlVlVm51WnNJZzQzSGRsaW1kay9oRG01dnY3aUlZSU16YnhueE5IVVBU?=
 =?utf-8?B?Q2ZsSkQzWGhpdnNDQi9kckQxVjlqWCtHUGFrcW1Qa3FwcWJsbmkzR0Vpb3Vh?=
 =?utf-8?B?dlNkcEJoZ2NhWE5IalduTk4vdERwWXpzazN1YmZDaHNJYUJQMHRLekJlSmhZ?=
 =?utf-8?B?ckptSVhoeE1XdWJuZHRkcmdoVmx4M1RCR2w3eUsxdDlyYUd6dmxyQXIrd0Zw?=
 =?utf-8?B?cUV3MTR3UHJ1QnJVVkQ4MkJ3T1dnbmMwdkZEcE54ejJ4Y1ZBcjhma0lYQWpY?=
 =?utf-8?B?bU9mQWFPUXBBZC9FNXBkOExQNWRmdStpcFJtQlBIN2p2Z2pOeVZXNFFvWGQz?=
 =?utf-8?B?MW5YdWJCbmVmb3oxZHpIRmk0NTgwM3FFRXY5bnZnU1ArUFQ3WGo1NVcwQTJE?=
 =?utf-8?B?clVLMUlGZy80ZUpXYmlWL2JSTjBUVnpPcXN6QjVqWnJoOENSVnBBSEJrTDJM?=
 =?utf-8?B?b0lhdURtY09kM05ac2ttZ1hGTko4K0RoZGRyckRUZnE5QWVUNm45dWxNSk9v?=
 =?utf-8?B?RDQ2YklHZGZwdzRTNzFwTUFMaVpXOTVoSE93WmM5b1o1T3hETUNlZXJmMzhF?=
 =?utf-8?B?VDh2em1JQjRIWmUrYVN5THRad2p2dXMrNTJxNFVheEd2NkdxUEdxZk4xLzlr?=
 =?utf-8?B?TmpSZkRsN1hxNUFRb3RGV2FCWHUwZHlMSThyeE1xQzFVSzFBZ2pGVlpHU0JK?=
 =?utf-8?B?UzRkenhPMWg3YU1VeDdkNUZ0cnlVV3FzYnphWnVzK3lsWkk3aUoyZ3BSckEx?=
 =?utf-8?B?OXQ3RE5ROWI3S01aMEsraUk2UjdLdGcvQXBmUlhuZ2dJVmJpSWx5SkpwcmhD?=
 =?utf-8?B?WEx1aU0wRDZtS3V3WndNRzk0RUpDQXcvRHpadmNCR28wci95KzBnSWkyVUM2?=
 =?utf-8?B?NHRseVhsVFhvMmRmQkpXUWJ1ZmZnR3ZadUk4NTZQWkUxditac0tsWkQ5SVNP?=
 =?utf-8?B?SWp5Tll6WVYrck01RkVHVmlISCtxZ1dBMGlTUXNjN01CZ2ltOXdWRlE0bGVE?=
 =?utf-8?B?ekZER1lja2x0WWltSnhkeHNEL0U3UXNmWHZ3L2g0UDhTM1JIV3FlaEhmNzFq?=
 =?utf-8?B?K0hWNHhLdFlmMStiV2tlVWpQd3pzR0tUblZHSER3Qk5mNDdRRGdZUktpN3ZW?=
 =?utf-8?B?cmc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	505VuScgl/U2UzLgy4OnQuZbBXXsDqdN4ogoN5rVKAuVpeW754vnrTKzqcASzzeZh43cf8Kdo2HCjSZob/L3Ih/MOrvA9I0mNAaTKY1iOlmhVebpRTlezNo8CKAJZavhNgVFMUJ3aSoxAdUpOkPFTC7Fnj+cd6D9YwaPY2VNXBDIIgCXKSUiJUC0S/0cKCuzb0uJYId0eP8i06xKmhSTrq9Q2+wzVzLCkI4KtpgSrpxyNICQ7SZpoxjEQ0ojHeeo6OwVSOAYZc3EZILHi1HyHDMiwQJbUADEv4yLA6kzSdcv1TQQEhks0KsRHNJToxWPJX0fCngdBfmqWDvM1zNvajeTygJb1O5Z2O8FkoUU+zeSxBbZIQLEagemavEGo0ROc+ah7e8jsX28okEJJ2Tq8e4PkmKA6xUafMNuLLK7QnX/qfjA2f2pNepKPC8T96jMZWQFpsCZLUfNWsqA/u/vz1rCC9vuaSWWTOc/WrVpVEPYZKJhkTHFeuaFcL8W/OoMj2MhhrH4bDvZt7AdjfYAAKnKkT1g/4PRCi38OI2oZeRtp3bAaW+3F+/GU/5eA/gX7Y8s1goCbRB8eM9RbErvOvsEalqPoSW7YPaJWBq3zzg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b078faf-c4e7-439b-13c7-08dd54e24621
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2025 14:48:17.4092
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mThu1LuKgOSr+VsHXRMw0ft81bPTDgZY76DvWy+TToeiDU9vkcoVafPhAClvblYgdibXkPKuKMHumFkE0YEk0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7245
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-24_06,2025-02-24_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 mlxscore=0
 adultscore=0 bulkscore=0 mlxlogscore=962 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2502240105
X-Proofpoint-GUID: Wb1ZZPdnL7tpXqUSPXnihMXvxNczP69R
X-Proofpoint-ORIG-GUID: Wb1ZZPdnL7tpXqUSPXnihMXvxNczP69R

On 2/21/25 6:42 PM, Dai Ngo wrote:
> Allow READ using write delegation stateid granted on OPENs with
> OPEN4_SHARE_ACCESS_WRITE only, to accommodate clients whose WRITE
> implementation may unavoidably do (e.g., due to buffer cache
> constraints).
> 
> When the server offers a write delegation for an OPEN with
> OPEN4_SHARE_ACCESS_WRITE, the file access mode, the nfs4_file
> and nfs4_ol_stateid are upgraded as if the OPEN was sent with
> OPEN4_SHARE_ACCESS_BOTH.
> 
> When this delegation is returned or revoked, the corresponding open
> stateid is looked up and if it's found then the file access mode,
> the nfs4_file and nfs4_ol_stateid are downgraded to remove the read
> access.

I probably don't understand something. The patch description seems to
suggest that a WR_ONLY OPEN state ID is also granted read in this case?


> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
> ---
>  fs/nfsd/nfs4state.c | 62 +++++++++++++++++++++++++++++++++++++++++++++
>  fs/nfsd/state.h     |  2 ++
>  2 files changed, 64 insertions(+)
> 
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index b533225e57cf..0c14f902c54c 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -6126,6 +6126,51 @@ nfs4_delegation_stat(struct nfs4_delegation *dp, struct svc_fh *currentfh,
>  	return rc == 0;
>  }
>  
> +/*
> + * Upgrade file access mode to include FMODE_READ. This is called only when
> + * a write delegation is granted for an OPEN with OPEN4_SHARE_ACCESS_WRITE.
> + */
> +static void
> +nfs4_upgrade_rdwr_file_access(struct nfs4_ol_stateid *stp)
> +{
> +	struct nfs4_file *fp = stp->st_stid.sc_file;
> +	struct nfsd_file *nflp;
> +	struct file *file;
> +
> +	spin_lock(&fp->fi_lock);
> +	nflp = fp->fi_fds[O_WRONLY];
> +	file = nflp->nf_file;
> +	file->f_mode |= FMODE_READ;
> +	swap(fp->fi_fds[O_RDWR], fp->fi_fds[O_WRONLY]);
> +	clear_access(NFS4_SHARE_ACCESS_WRITE, stp);
> +	set_access(NFS4_SHARE_ACCESS_BOTH, stp);
> +	__nfs4_file_get_access(fp, NFS4_SHARE_ACCESS_READ);	/* incr fi_access[O_RDONLY] */
> +	spin_unlock(&fp->fi_lock);
> +}
> +
> +/*
> + * Downgrade file access mode to remove FMODE_READ. This is called when
> + * a write delegation, granted for an OPEN with OPEN4_SHARE_ACCESS_WRITE,
> + * is returned.
> + */
> +static void
> +nfs4_downgrade_wronly_file_access(struct nfs4_ol_stateid *stp)
> +{
> +	struct nfs4_file *fp = stp->st_stid.sc_file;
> +	struct nfsd_file *nflp;
> +	struct file *file;
> +
> +	spin_lock(&fp->fi_lock);
> +	nflp = fp->fi_fds[O_RDWR];
> +	file = nflp->nf_file;
> +	file->f_mode &= ~FMODE_READ;
> +	swap(fp->fi_fds[O_WRONLY], fp->fi_fds[O_RDWR]);
> +	clear_access(NFS4_SHARE_ACCESS_BOTH, stp);
> +	set_access(NFS4_SHARE_ACCESS_WRITE, stp);
> +	spin_unlock(&fp->fi_lock);
> +	nfs4_file_put_access(fp, NFS4_SHARE_ACCESS_READ);	/* decr. fi_access[O_RDONLY] */
> +}
> +
>  /*
>   * The Linux NFS server does not offer write delegations to NFSv4.0
>   * clients in order to avoid conflicts between write delegations and
> @@ -6207,6 +6252,11 @@ nfs4_open_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
>  		dp->dl_cb_fattr.ncf_cur_fsize = stat.size;
>  		dp->dl_cb_fattr.ncf_initial_cinfo = nfsd4_change_attribute(&stat);
>  		trace_nfsd_deleg_write(&dp->dl_stid.sc_stateid);
> +
> +		if ((open->op_share_access & NFS4_SHARE_ACCESS_BOTH) == NFS4_SHARE_ACCESS_WRITE) {
> +			dp->dl_stateid = stp->st_stid.sc_stateid;
> +			nfs4_upgrade_rdwr_file_access(stp);
> +		}
>  	} else {
>  		open->op_delegate_type = deleg_ts ? OPEN_DELEGATE_READ_ATTRS_DELEG :
>  						    OPEN_DELEGATE_READ;
> @@ -7710,6 +7760,8 @@ nfsd4_delegreturn(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>  	struct nfs4_stid *s;
>  	__be32 status;
>  	struct nfsd_net *nn = net_generic(SVC_NET(rqstp), nfsd_net_id);
> +	struct nfs4_ol_stateid *stp;
> +	struct nfs4_stid *stid;
>  
>  	if ((status = fh_verify(rqstp, &cstate->current_fh, S_IFREG, 0)))
>  		return status;
> @@ -7724,6 +7776,16 @@ nfsd4_delegreturn(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>  
>  	trace_nfsd_deleg_return(stateid);
>  	destroy_delegation(dp);
> +
> +	if (dp->dl_stateid.si_generation && dp->dl_stateid.si_opaque.so_id) {
> +		if (!nfsd4_lookup_stateid(cstate, &dp->dl_stateid,
> +				SC_TYPE_OPEN, 0, &stid, nn)) {
> +			stp = openlockstateid(stid);
> +			nfs4_downgrade_wronly_file_access(stp);
> +			nfs4_put_stid(stid);
> +		}
> +	}
> +
>  	smp_mb__after_atomic();
>  	wake_up_var(d_inode(cstate->current_fh.fh_dentry));
>  put_stateid:
> diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
> index 74d2d7b42676..3f2f1b92db66 100644
> --- a/fs/nfsd/state.h
> +++ b/fs/nfsd/state.h
> @@ -207,6 +207,8 @@ struct nfs4_delegation {
>  
>  	/* for CB_GETATTR */
>  	struct nfs4_cb_fattr    dl_cb_fattr;
> +
> +	stateid_t		dl_stateid;  /* open stateid */
>  };
>  
>  static inline bool deleg_is_read(u32 dl_type)


-- 
Chuck Lever

