Return-Path: <linux-nfs+bounces-7626-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D7F69B9723
	for <lists+linux-nfs@lfdr.de>; Fri,  1 Nov 2024 19:11:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0780282911
	for <lists+linux-nfs@lfdr.de>; Fri,  1 Nov 2024 18:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8801A14F132;
	Fri,  1 Nov 2024 18:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="h4S3r/Sw";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="OlxRtgdl"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F40413B7A3
	for <linux-nfs@vger.kernel.org>; Fri,  1 Nov 2024 18:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730484661; cv=fail; b=r34Wz9eKW7m4mBxOD5yUlWXcVuPVR/u6UB9VZrWkpKQaknQdzRTbUYPrHgdNR/SA4F+tPkqVyOWMDgOCubGUBuXuRYfVTq1XrbUNVnu4FN5lp9fM31ocLsQPwtCR63IZ9mxrb9v5c4MtSaaQEXtqNG1dbeb3sOQnKpfsIs4xFCw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730484661; c=relaxed/simple;
	bh=0jAIY2pZRqHrSM+OAK+Awl1e30XnBWzWKvVhN99mQ7A=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Xg6kJpMuMfXanAXxZjflJNiLFcqEQnvso0II9Q0y0pP6ifbTcDDjcihWrF8i3NIrUrxvDOrehr5itFwwrHDL8mwGMSSgl5jJkFHZXbJX65lbPEq7PAsK6kp9d899i3c3U9qH39MKw03NVtFNVY79pCr51a+UwOsNzoAV8mYOZco=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=h4S3r/Sw; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=OlxRtgdl; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A1GBdji012963;
	Fri, 1 Nov 2024 18:10:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=pmyf+Tv5DPxMMnxVUTiOQnoQKQLk04TAR3djDFfuu0E=; b=
	h4S3r/SwLm64L8O05EwBhyze4hWrbdLMAa+iE5r4EKZG6UQB4+t4TV+Woxq5oLjA
	03Li8aaylZcRbcx2/Ed01723j67jgFjDQRZkHZXrlF3WYR8jMDJHJPc1vEmKLKuF
	4UQ1pvtn143neUUAQzIe9qnsoY382MfwxSE1kEOLd5vBM0qeUGxFzVvjrNa+O+Ef
	DH4BYsMmbx/lDUzCuwINuiXNjMbeVSdvDFS5k5HBmXh5J7IEd46SolMFEII8Hr4P
	GSqbh/atCvd0TRhSVHH1H54SXBOQusoWzXyh2BbgSVdhLXgpbmQjJyqg+fwq23r5
	22XpjbMkkjLlz21C1go3wA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42grdqmpq5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 01 Nov 2024 18:10:52 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4A1GPGnv008537;
	Fri, 1 Nov 2024 18:10:52 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2176.outbound.protection.outlook.com [104.47.57.176])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42hnedskn8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 01 Nov 2024 18:10:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wP/hYas/b6MpDGZyvRNA+jjb4VX2U54Co+qu3IBQUNTGb6uvZNgiC+aMGm6yf6riQNYIR6goLYWNBGGe62RGWhSDqWVKQqsvNRtcckxy96j/meivImGoBmxL8M9GXgFZtpdwj/C5WzTITm1oBHEZmWkYXQf49U5CAlgW01mQY7WETrgmol6pdFnHhAFknhcslYtd25Qjul1umREsN+TnEcdpyVtMHBgfzCj4jPxl21BkNja8MCWHs5Xkrsj/7RCIZ2g49IECRCprJlQhPbpicfmRQc9PepTzVVbPi76xDIfRX/HtWz0sOJq+d1IaUSHMP0DRURwVaKUuuncKO6NitQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pmyf+Tv5DPxMMnxVUTiOQnoQKQLk04TAR3djDFfuu0E=;
 b=yUw0y1MOkosDHiDh9exCW1FzQdoFnkxymDigEox5lMJ3Sx/p2aSIzA2LV3PK9CT29nGE+vSSYI73ss8C9UEVMnSe+h1mB7KdunS9bFVdArx7fXpUc6HJAljAVAaA/NPYYSKgLGGpv+zNC369xuNNVuMbKN4tP3a/7Eo/q7NXw2GM5L+2mBUpIgAlJlortZnuPLyJeyMn/CBpT1gr127SfiWe2aRmxyfpquxdPTbbezvNbcTU0U+uv6a4Hzshf5J/IKYq1OXRPW49ISZQUpGJhtkB+X7YNJsvxhQqfB1Wfk8qOc+gRNdDc3Ta+ufAmA//hW8DO+uc+momZT+t0GOUpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pmyf+Tv5DPxMMnxVUTiOQnoQKQLk04TAR3djDFfuu0E=;
 b=OlxRtgdl+TLXMmwYZwPowtdTSGWMOr75X7c5Otnu1SvFSxMHHGGpznw3a8MDQfS/RhZeDMHAGrz9I1J5udCVFvRQKddTA7HwbFcKuiT7jlMxk1192gp9y2DKfMtCnMdBauLrxd2cYwclW1WaRVyanYk08y9gb1IfmcfcmF36j/A=
Received: from BY5PR10MB4290.namprd10.prod.outlook.com (2603:10b6:a03:203::15)
 by SN7PR10MB6306.namprd10.prod.outlook.com (2603:10b6:806:272::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.29; Fri, 1 Nov
 2024 18:10:49 +0000
Received: from BY5PR10MB4290.namprd10.prod.outlook.com
 ([fe80::8c24:37e7:b737:8ba5]) by BY5PR10MB4290.namprd10.prod.outlook.com
 ([fe80::8c24:37e7:b737:8ba5%4]) with mapi id 15.20.8114.020; Fri, 1 Nov 2024
 18:10:49 +0000
Message-ID: <882dca95-f619-4469-be14-c35776c2d182@oracle.com>
Date: Fri, 1 Nov 2024 14:10:47 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: NFS Client crash during migration scenario
To: Bharath SM <bharathsm.hsk@gmail.com>, linux-nfs@vger.kernel.org,
        kolga@netapp.com, trond.myklebust@hammerspace.com,
        chuck.lever@oracle.com, Shyam Prasad N <nspmangalore@gmail.com>,
        Bharath S M <bharathsm@microsoft.com>,
        Steve French <smfrench@gmail.com>, bill.baker@oracle.com
References: <CAGypqWyVW+W-mm51HUsGO2WT76YckFT_uwr4tySsEE8gwHGxVA@mail.gmail.com>
Content-Language: en-US
From: Anna Schumaker <anna.schumaker@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <CAGypqWyVW+W-mm51HUsGO2WT76YckFT_uwr4tySsEE8gwHGxVA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR04CA0064.namprd04.prod.outlook.com
 (2603:10b6:610:74::9) To BY5PR10MB4290.namprd10.prod.outlook.com
 (2603:10b6:a03:203::15)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4290:EE_|SN7PR10MB6306:EE_
X-MS-Office365-Filtering-Correlation-Id: 94dd7c5c-8ff5-47c6-fffc-08dcfaa083d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|10070799003|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NEV4bDJhTmNEM04xckg3enpuM0VRU3hiR08za043cGVtc085UHB1V0Zrb2JD?=
 =?utf-8?B?OVlvdTRjQk80ejV2Y3FQelhMU2UrcFQ5eDNvS1hQS05oS253NDYrcUJNb2Ns?=
 =?utf-8?B?dWZXNEVIVTlQQTRNS2VBdHVLT3VIUXA5eUJVWlhaR3dpcTFlLzd2cHZtY2Ru?=
 =?utf-8?B?T2tkTVhjaFpBcVNLS2VtSnBMcndQS2VjWjdoQ1N1alQ5MG5wYVNVNkoxMk9r?=
 =?utf-8?B?WjA1TDBkWjJqOXRLTFpGZkVxSytCemd2RzM3WGdJazBwamdsYlBMU21mUnd6?=
 =?utf-8?B?NW1Ia2wzamErNm1Bd0pDUElaS1dETmVDZkFyZmFSZDZMNFdQWXNjaElLc3FB?=
 =?utf-8?B?eGFHcTJLdnVjbElRZHZMSDFsNTlPa2E2cCtvbE9KbDRSaXMrL1E4d2R5R05S?=
 =?utf-8?B?V3hqK05sMjZxb1lJMnBmbDJNeHhPaXUzNUpEUTRVaWdpbEJ2SXZMdzdOR2dm?=
 =?utf-8?B?U1RLUStLZjAvb1pvVnQrMTdRS2lGeHVOdXpqYzlucmxnZjdwWVhkeGhuYzZZ?=
 =?utf-8?B?anlKN1pyRm5WMUl6NE9XQ1NFdklTcDlSNVJ2cTlicWJvYmwvQ1kvUmE5VExQ?=
 =?utf-8?B?TlR5UXJrNUxmOHFNN1UrSzgyMmdpaDEweGx6VEFFeGRYbWFRSnA1Y09hTVhE?=
 =?utf-8?B?cFc3OXg4cHRqVTIrSG80OXNzWGd4dEQ5TEtkY2FUMU02TTJEejFCOGpTZ3RT?=
 =?utf-8?B?TG9pR2tBSXpXWXJobmVaQzgvKzlSMjRhWFV1SlNaVkdrZWVjekNkZjl6QkVn?=
 =?utf-8?B?a2lmY3QwODFCODBUNTJNUWRwd0ptdWZ3QndISElMc1NTall1WElXSWNrdCt1?=
 =?utf-8?B?cTliY0Y4UzNRdlpXSXE4dC9WTXkzbWdZN2lMUjI3TllkeFMwZk5paXVhZ1NJ?=
 =?utf-8?B?ZkxBbnpKcHRnaldqUjNSUUloQWorRHppckNZQkxYc1dGZ0FSVjlwUmFPYnB3?=
 =?utf-8?B?MXkvTkhVM2E3dGVVeWkveE1MZlltVTQvZlowVzg0Rks4MHVLSXMwVWJwbU50?=
 =?utf-8?B?V0JvNzhIWmN6REk0VVBuZGxETFV5Z3l1Zy96MGJHNkhqUm1ZUlRTZlh5N3JL?=
 =?utf-8?B?bDl1SUd6TUtkYjhBQ2xpcWQzWldHdTJLYmxVd1d6UUZQTDJlc3BhcTkwSHRo?=
 =?utf-8?B?eE54T1dWdjdPM1FsSjlEQVpKVFQxWmpVZXJ0enVmeHhnR1pMYzJGbUdUTUc1?=
 =?utf-8?B?RlhlcFB2OTBtRnFNWndsdHJINThFK3JJQnZQYnh2bklmRTJZQ1F1N0hmMTNt?=
 =?utf-8?B?eHMwSG0xVzdOaEYyZE9JR1E1cWpkSWQ1ZUlBMXZyVnkxeUlSMWk2TE41NUVx?=
 =?utf-8?B?bUxPdGNRcHZUL2YyVWNrZS9VOXQ4V1NTWXlFc3Y0YXY4bVJRTkU4L1NqamVB?=
 =?utf-8?B?TExLNEx3UTRTU2pnVHg5V1I0V2RqbWdLbFNRdGViUWF1VkxPUUlhRXJNS2RC?=
 =?utf-8?B?bTMzNDJYbDg1YzI5ZnVWUmZlNjgyNEIremZ5Y0c2S3Z6cU1zWVRPU0ROZ3FQ?=
 =?utf-8?B?OGNmV2N5NUJiaXFteG14WGN1dEhTeE5sSCtxbDB6TUhGaGM1R0lDUTV0TjJJ?=
 =?utf-8?B?aUNGZWdySTJlWDJXRVNzazZYaS9zLy8zZ0x2VkRwUytGVUh5dWt0alhTclZR?=
 =?utf-8?B?YU0ydFNZck5rcmdEZlJyNFNlbUxiUVNnR2hxOXBtNTJJQ1k3dGJtL0hvdkpY?=
 =?utf-8?B?aUpSN05aSGFBbDIvUWZjU1NoemMzNmUyL1paQXUwVCttYlFDdjRobVNYcFdH?=
 =?utf-8?Q?VbDomtTeod500TXu2dj7RZHwuIMRTA2lPYFyl8E?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4290.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(10070799003)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Ti9Vc21pV04yWFZxNVl4S082UGswS1g0RktMbU1DKzlPZkZMQyswWlR1WDdB?=
 =?utf-8?B?dzVyME5pTWo0U2RUM1lzWm9GbktoNnZXbGtyL3Zxd3cvNFU5OVBlMWMrSTR1?=
 =?utf-8?B?SnVlaUhxVmVPbG55NWhKMUZuVi9HaFpwVE9FUkxRZEUxcWVGY2hPWGt2a3Zy?=
 =?utf-8?B?NEFkTkppcTV1bEsySFU2YlpDTDZUSFd1RnpGZkFnZjlvTHdqM0FkODI1VUo1?=
 =?utf-8?B?V3h3N1FoeGFJak1kWXNuVWFEaHJreVZpdHBMSWpLKzNrYzdGc21GZmJuY3ZP?=
 =?utf-8?B?RGhLb0o3NklHMW9nMFhxTjhVR2ZNNEVqVTVKTEI4U3pMazQ2bTFXTUNGL1dq?=
 =?utf-8?B?QktvYzF1bFlrWGY3eTVtR2JJNU1YZkNraG51RmlFVUowK3FUM1lQdTIzdzV1?=
 =?utf-8?B?M0t1Sm9WbDZIbGhBQXJBZTlIV0h5dUZOSzlaR3dsN0NERW16amx2VWpiOGQr?=
 =?utf-8?B?UDMzR0JOY283djhyWXUxdk9lRGYzem1ZL2cvZVZKZG8wbUd6TzB3b3lqd0dR?=
 =?utf-8?B?STFIUnR4dU1TOGIwdDYrUnl4SGtmZU0vcGpqczZvZmRyamFMY0IvVkxuam1R?=
 =?utf-8?B?MmdyT09rbDhKeWFrVFIwVFFMWkxkU2o4aGV2K0xudzJKN1Y3cG0yVVpmTkEw?=
 =?utf-8?B?RUVjVUFucWExZEJmeWVpK3llVnNMcGl3aENCeFkyNXdnNEtSc1VzWFJCVTMr?=
 =?utf-8?B?VW5YbStsZy9uVURIKys4ZEFVdHI4SXMwZ0hCMzVjVmw5K3ZWRE1icU42d296?=
 =?utf-8?B?SHUrS1R5S3JNRXdrRURwQlR1TTNNL1RyRlYrNXNFemFxWWtnSHVrLysxQWZB?=
 =?utf-8?B?c0NnR2NzQmplVS9lYlNCa25GdDhEaDJJVWlCUHhxdFVXaDFXRThkZzJOcG80?=
 =?utf-8?B?L3k1UTF0Tm91WUI3dkk4cFZQc2pZUURJbCtyN0UzRXdHN21KSjdzcUE1NHpy?=
 =?utf-8?B?OG1yOEJPSmZQMzM4MXl6cU5UVmNmcFMwblFOalhvWGQvUFNVZjVHT0JyQkJN?=
 =?utf-8?B?d1lYYzBNRHJyMTNmNFhNT0tPenB1eXR2Zk5CNXdxSFovRFlDTFdCKzhyZDhm?=
 =?utf-8?B?YVU1OENPNjg5SUdUZ3BUa3hxa1lsWnFlNGVuSTlJRDFXVnZsL0djZ3A0cnQ5?=
 =?utf-8?B?Rm9jVENKdmpxeTdKTEhmN2U4UTdYMjFtTTliN1NQWUQ0Nk9jZEVmc3NMRnZh?=
 =?utf-8?B?R1pmWUhSa25uNk9tQ3dqT0wweG5adTVxaFRPQjNZSW9SSDhicFRBcXIrS052?=
 =?utf-8?B?Nm1KbmZ1ajkwNE9tQ3FLVmNIUUNDbGxkbEZUTmF2NW9NVFYyd0FLOXdhUW9w?=
 =?utf-8?B?TCtHVHVSR2ZRanBMdUk4NXRJK2p1OHhObVhHMFZWTnhyNCs1VnVqZ1RWK3NK?=
 =?utf-8?B?eUIyRVN6N2JkWUg5empsb1FRVmNJcTgrR0k5aUFkdTQ5Q0FnRDhGOTU2clI1?=
 =?utf-8?B?NUl6RjRGRTg1RWluN3dxY2wydWNGQTJ1TW1VZ25RTGFoYjJudTR5bWRWaVlz?=
 =?utf-8?B?QW45SzRsamR4Qmk5dUdITnJncDZ0QWhwRVZjbHJnRnRvaEM1azZGbHZvOW1O?=
 =?utf-8?B?ZVVEOGJsYWwxMGlieHVuMklpd2s2bHBPM3FNSVduYlQzcDg1UExVenlWZXRr?=
 =?utf-8?B?d1pWbHVBYm1pd2tpT1A2NFpnMENWNnhkNFB3a1dzcnJyN1lhT2RseVk4M0ZS?=
 =?utf-8?B?QnJkTExwUVFVZFphNEtCM1p2Y1dzdU5vSGtHeWhoVy94VTNtYkI1MGVpTmZN?=
 =?utf-8?B?MVJ6ekRJYk01OXBkR2RJS3JlOXNIeEV0cGpwcGNYVkJPNEtQc3ZYV3VkRXo3?=
 =?utf-8?B?VzBCR0RkcmZVY1VRczl2ZXhyUk1UUkJ1TVMyc3VKWFlLMXkrWC8yaE5Qc1Jw?=
 =?utf-8?B?cEFVWVpPeWtjcXRMVHBtdXZVTEJJTmVJUEk4aE9uNEdWVnN2eGt1K0htSEFN?=
 =?utf-8?B?NTY5Vm1pcGljd01OcUVKNXRJN1pFTjRKNkxlcVNWSlRSRUJZK2JoMGlldlo3?=
 =?utf-8?B?YkhkaGxZYlpZd2Q3d0xoVE04ckJoZTRqZ2xONUtMSlB6dU01UVBZUmdKWlRO?=
 =?utf-8?B?RndjRE9zaVRJd3prcktFa3FocHpMRUF1NDQxdTZKSVNNMWNPV2dLSkNIdHB5?=
 =?utf-8?B?L0FPdjY0YjByMTlyTmNIUG9mQXV0eEIzZThLZTAxSjFuRkk3MUMvTThncmdl?=
 =?utf-8?B?WDFlNVVaOTU3SURLZWNFci9TUmU4OUR1UStPVHhRQ2JpUTdhSCtFbS9RSldL?=
 =?utf-8?B?YUJuRDBYaU0wazExb0VPcHJoS1NBPT0=?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	6Ek7Rs73R88WfZxsh6HjuVsYnjDn0C/Iywp1YFKNMYOs57QgYYlzQThh9RmYtqu8N7tv4ScuDjmisQoC+QcTNd6aN+YI3sqAEg0yngfatK5tt/+GdDZ1CIGWua7/Y+Xa4IKWFBtCrJN928ewQTIHozNeMjDnMmXuH1HjWTS+zXigxih+8qss+CcS3/1JclrOU0yPsh4JWbXvblCDuWbTUbSalAYIgHvJ/m/iE1Jl188yAtECSBsucm/jJKo4smIQyDRo0953RWp5eDmqVf0gU0qUDBRShrUlmglay9uFhC9Nor4cHRWP5juhpYOkiUpl+uB1rjzy74CMvrsl9rDgIItW6MTPBCMTXByMgXW/So4JxOWXQ0p8c8duXBkUn8BZ28fZ0mi0xPwqvbtzDW5tqWjc0b7/cAPJFioer1KnRt05T2dh4Rxje5kTpGTZ+WrHq2XLvft1K4Uvoo5HE6b8H6zchmS5vbFz39P3sOm/T48CpZW7l3E3ZHZkh6Rdu8t/Lz9Vf7Spb2w/e/4hKnh52E68gwSZoD/h52srsijGE+gkocFVGIkiKFwR5tue/yvVaxIfmPyf+cWhsBwUZQsu/jNkDHjMF0Y9znIO4NrsHU8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94dd7c5c-8ff5-47c6-fffc-08dcfaa083d4
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4290.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2024 18:10:49.5064
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wq9brFZ6qEZFfUaq9/BLwHOKTzfn03xLxc7ZLRLRS+SHbBvCbxv9cyDhaN7MP7/nedl4OPtK2IMLW5R1wSrpnKEwnnJWuQ/NxXF/eL6HEZk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6306
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-01_12,2024-11-01_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411010130
X-Proofpoint-GUID: rzsNlYPMrl6fgruRUmmKuMr8I1bzBWel
X-Proofpoint-ORIG-GUID: rzsNlYPMrl6fgruRUmmKuMr8I1bzBWel

Hi Bharath,

On 10/21/24 2:26 AM, Bharath SM wrote:
> We are working on a prototype of NFS v4.1 server migration and during
> our testing we are noticing the following crashes with NFS clients
> during the movement of traffic from Server-1 to Server-2.
> Tested on Ubuntu distro with 5.15, 6.5 and 6.8 Linux kernel versions
> and observed following crashes while accessing invalid xprt
> structures. Can you please take a look at the issue and my findings so
> far and suggest next steps?
> Also please let me know if you would need additional information.
> 
> 1.  Crash call stack:
> 
> Jul  8 19:35:38 Ubuntu2204-1 kernel: [ 4453.253541] RIP:
> 0010:xprt_reserve+0x3c/0xd0 [sunrpc]
> Jul  8 19:35:38 Ubuntu2204-1 kernel: [ 4453.253601] Code: bf b8 00 00
> 00 00 c7 47 04 00 00 00 00 4c 8b af a8 00 00 00 74 0d 5b 41 5c 41 5d
> 41 5e 5d c3 cc cc cc cc c7 47 04 f5 ff ff ff <49> 8b 85 08 04 00 00 49
> 89 fc f6 c4 02 75 28 49 8b
> 45 08 4c 89 e6
> Jul  8 19:35:38 Ubuntu2204-1 kernel: [ 4453.253603] RSP:
> 0018:ff5d77a18d147b58 EFLAGS: 00010246
> Jul  8 19:35:38 Ubuntu2204-1 kernel: [ 4453.253606] RAX:
> 0000000000000000 RBX: ff1ef854fc4b0000 RCX: 0000000000000000
> Jul  8 19:35:38 Ubuntu2204-1 kernel: [ 4453.253607] RDX:
> 0000000000000000 RSI: 0000000000000000 RDI: ff1ef854d2191d00
> Jul  8 19:35:38 Ubuntu2204-1 kernel: [ 4453.253608] RBP:
> ff5d77a18d147b78 R08: ff1ef854d2191d30 R09: ffffffff8fa071a0
> Jul  8 19:35:38 Ubuntu2204-1 kernel: [ 4453.253609] R10:
> ff1ef854d2191d00 R11: 0000000000000076 R12: ff1ef854d2191d00
> Jul  8 19:35:38 Ubuntu2204-1 kernel: [ 4453.253611] R13:
> 0000000000000000 R14: 0000000000000000 R15: ffffffffc0d2e5e0
> Jul  8 19:35:38 Ubuntu2204-1 kernel: [ 4453.253613] FS:
> 0000000000000000(0000) GS:ff1ef8586fc40000(0000)
> knlGS:0000000000000000
> Jul  8 19:35:38 Ubuntu2204-1 kernel: [ 4453.253615] CS:  0010 DS: 0000
> ES: 0000 CR0: 0000000080050033
> Jul  8 19:35:38 Ubuntu2204-1 kernel: [ 4453.253617] CR2:
> 0000000000000408 CR3: 00000003ce43a005 CR4: 0000000000371ee0
> Jul  8 19:35:38 Ubuntu2204-1 kernel: [ 4453.253618] DR0:
> 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> Jul  8 19:35:38 Ubuntu2204-1 kernel: [ 4453.253619] DR3:
> 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Jul  8 19:35:38 Ubuntu2204-1 kernel: [ 4453.253620] Call Trace:
> Jul  8 19:35:38 Ubuntu2204-1 kernel: [ 4453.253621]  <TASK>
> Jul  8 19:35:38 Ubuntu2204-1 kernel: [ 4453.253623]  ? show_regs+0x6a/0x80
> Jul  8 19:35:38 Ubuntu2204-1 kernel: [ 4453.253628]  ? __die+0x25/0x70
> Jul  8 19:35:38 Ubuntu2204-1 kernel: [ 4453.253630]  ?
> page_fault_oops+0x79/0x180
> Jul  8 19:35:38 Ubuntu2204-1 kernel: [ 4453.253634]  ?
> do_user_addr_fault+0x320/0x660
> Jul  8 19:35:38 Ubuntu2204-1 kernel: [ 4453.253636]  ? vsnprintf+0x37d/0x550
> Jul  8 19:35:38 Ubuntu2204-1 kernel: [ 4453.253640]  ? exc_page_fault+0x74/0x160
> Jul  8 19:35:38 Ubuntu2204-1 kernel: [ 4453.253644]  ?
> asm_exc_page_fault+0x27/0x30
> Jul  8 19:35:38 Ubuntu2204-1 kernel: [ 4453.253648]  ?
> __pfx_call_reserve+0x10/0x10 [sunrpc]
> Jul  8 19:35:38 Ubuntu2204-1 kernel: [ 4453.253688]  ?
> xprt_reserve+0x3c/0xd0 [sunrpc]
> Jul  8 19:35:38 Ubuntu2204-1 kernel: [ 4453.253730]
> call_reserve+0x1d/0x30 [sunrpc]
> Jul  8 19:35:38 Ubuntu2204-1 kernel: [ 4453.253773]
> __rpc_execute+0xc1/0x2e0 [sunrpc]
> Jul  8 19:35:38 Ubuntu2204-1 kernel: [ 4453.253830]
> rpc_execute+0xbb/0xf0 [sunrpc]
> Jul  8 19:35:38 Ubuntu2204-1 kernel: [ 4453.253885]
> rpc_run_task+0x12e/0x190 [sunrpc]
> Jul  8 19:35:38 Ubuntu2204-1 kernel: [ 4453.253926]
> rpc_call_sync+0x51/0xb0 [sunrpc]
> Jul  8 19:35:38 Ubuntu2204-1 kernel: [ 4453.253968]
> _nfs4_proc_create_session+0x17a/0x370 [nfsv4]
> Jul  8 19:35:38 Ubuntu2204-1 kernel: [ 4453.254020]  ? vprintk_default+0x1d/0x30
> Jul  8 19:35:38 Ubuntu2204-1 kernel: [ 4453.254024]  ? vprintk+0x3c/0x70
> Jul  8 19:35:38 Ubuntu2204-1 kernel: [ 4453.254026]  ? _printk+0x58/0x80
> Jul  8 19:35:38 Ubuntu2204-1 kernel: [ 4453.254029]
> nfs4_proc_create_session+0x67/0x130 [nfsv4]
> Jul  8 19:35:38 Ubuntu2204-1 kernel: [ 4453.254065]  ?
> nfs4_proc_create_session+0x67/0x130 [nfsv4]
> Jul  8 19:35:38 Ubuntu2204-1 kernel: [ 4453.254100]  ?
> __pfx_nfs4_test_session_trunk+0x10/0x10 [nfsv4]
> Jul  8 19:35:38 Ubuntu2204-1 kernel: [ 4453.254133]
> nfs4_reset_session+0xb2/0x1a0 [nfsv4]
> Jul  8 19:35:38 Ubuntu2204-1 kernel: [ 4453.254170]
> nfs4_state_manager+0x3cc/0x950 [nfsv4]
> Jul  8 19:35:38 Ubuntu2204-1 kernel: [ 4453.254206]  ?
> kernel_sigaction+0x79/0x110
> Jul  8 19:35:38 Ubuntu2204-1 kernel: [ 4453.254209]  ?
> __pfx_nfs4_run_state_manager+0x10/0x10 [nfsv4]
> Jul  8 19:35:38 Ubuntu2204-1 kernel: [ 4453.254244]
> nfs4_run_state_manager+0x64/0x170 [nfsv4]
> Jul  8 19:35:38 Ubuntu2204-1 kernel: [ 4453.254280]  ?
> __pfx_nfs4_run_state_manager+0x10/0x10 [nfsv4]
> Jul  8 19:35:38 Ubuntu2204-1 kernel: [ 4453.254314]  kthread+0xd6/0x100
> Jul  8 19:35:38 Ubuntu2204-1 kernel: [ 4453.254317]  ? __pfx_kthread+0x10/0x10
> Jul  8 19:35:38 Ubuntu2204-1 kernel: [ 4453.254320]  ret_from_fork+0x3c/0x60
> Jul  8 19:35:38 Ubuntu2204-1 kernel: [ 4453.254325]  ? __pfx_kthread+0x10/0x10
> Jul  8 19:35:38 Ubuntu2204-1 kernel: [ 4453.254328]  ret_from_fork_asm
> 
> I looked at this crash and noticed following:
> 
> During NFS migration, when traffic starts going to server 2, we do see
> BAD SESSION errors and the reason for the bad session is that the
> client sends an old session ID to server-2 for some of the requests
> even though the same session has been destroyed in server-1 along with
> its client ID just few 100's milliseconds back. (Not sure if there is
> some caching playing a role here or if session draining is not
> happening cleanly).
> Crash is happening on the client because, in response to a BAD SESSION
> error from the server, the client tries to attempt the session
> recovery and fails to get the transport for a rpc request, resulting
> in a crash. (accessing already freed up structures?)
> 
> Snippet from trace-cmd logs:
> 
> Client ID was being released here:
>    lxfilesstress-3416  [005]  5154.980981: rpc_clnt_shutdown:    client=00000000
>    lxfilesstress-3416  [005]  5154.980982: rpc_clnt_release:     client=00000000
> 
> Just after a few ms, the same client ID is being used here for session
> recovery operation after it has been freed up earlier:
> 20.150.9ß/I\^L;l-22349 [006]  5155.042037: rpc_request:
> task:00000011@00000000 nfsv4 CREATE_SESSION (sync)
> 20.150.9ß/I\^L;l-22349 [006]  5155.042040: rpc_task_run_action:
> task:00000011@00000000
> flags=DYNAMIC|NO_ROUND_ROBIN|SOFT|TIMEOUT|NORTO|CRED_NOREF
> runstate=RUNNING|ACTIVE status=0 action=call_reserve ------> Crash
> after this in call_reserve.

So, the first thing that's sticking out to me in looking through nfs4state.c is that we're setting, testing, and clearing the various state recovery bits outside of a spinlock (and taking the lock right after). This seems like it could potentially open up races, which could be what you're seeing (how often does the crash happen for you, is it every time or only sometimes?).

> 
> 
> Client code:
> 
> void xprt_reserve(struct rpc_task *task)
> {
>         struct rpc_xprt *xprt = task->tk_xprt;
> --------------------<<<<<<<<<<<<<<<< tk_xprt pointer is NULL
>         task->tk_status = 0;
>         if (task->tk_rqstp != NULL)
>                 return;
>         task->tk_status = -EAGAIN;
>         if (!xprt_throttle_congested(xprt, task)) {
>                 xprt_do_reserve(xprt, task);
>         }
> }
> 
> tk_xprt is NULL in above function because, during session recovery rpc
> request, sunrpc module tries to get xprt using
> ‘rpc_task_get_first_xprt(clnt)’ for a given client but it this
> function returns NULL.
> 
> static void rpc_task_set_transport(struct rpc_task *task, struct rpc_clnt *clnt)
> {
>     if (task->tk_xprt) {
>         if (!(test_bit(XPRT_OFFLINE, &task->tk_xprt->state) &&
>               (task->tk_flags & RPC_TASK_MOVEABLE)))
>             return;
>         xprt_release(task);
>         xprt_put(task->tk_xprt);
>     }
> 
>     if (task->tk_flags & RPC_TASK_NO_ROUND_ROBIN)
>         task->tk_xprt = rpc_task_get_first_xprt(clnt);
> ------------------------------- Returns NULL
>     else
>         task->tk_xprt = rpc_task_get_next_xprt(clnt);
> 
> }
> 
> 
> We also noticed that, In nfs4_update_server after nfs4_set_client
> call, we aren't calling nfs_init_server_rpcclient() whereas in all
> other cases, after nfs4_set_clien we always called
> nfs_init_server_rpcclient(). Can you please let me know if this is
> expected.?

From my reading of the code, this is expected. nfs4_update_server() uses rpc_switch_client_transport() instead to swap out the transport for the underlying rpc_client. This lets us reuse the current rpc_client, rather than creating a new one with nfs_init_server_rpcclient().


> 
> 
> 2. Another crash call stack with xprt structures being NULL just after
> migration.
> 
> PID: 306169  TASK: ff4a4584198c8000  CPU: 6   COMMAND: "kworker/u16:0"
>  #0 [ff5630b9cb397a10] machine_kexec at ffffffffb9e95ac2
>  #1 [ff5630b9cb397a70] __crash_kexec at ffffffffb9fe022f
>  #2 [ff5630b9cb397b38] panic at ffffffffb9ed62ce
>  #3 [ff5630b9cb397bb8] oops_end at ffffffffb9e405a7
>  #4 [ff5630b9cb397be0] page_fault_oops at ffffffffb9eaa482
>  #5 [ff5630b9cb397c68] do_user_addr_fault at ffffffffb9eab090
>  #6 [ff5630b9cb397cb0] exc_page_fault at ffffffffbadb1884
>  #7 [ff5630b9cb397ce0] asm_exc_page_fault at ffffffffbae00bc7
>     [exception RIP: xprt_release+317]
>     RIP: ffffffffc0522afd  RSP: ff5630b9cb397d98  RFLAGS: 00010286
>     RAX: 0000000000000045  RBX: ff4a4584198c8000  RCX: 0000000000000027
>     RDX: 0000000000000000  RSI: 0000000000000001  RDI: ff4a45840a573d00
>     RBP: ff5630b9cb397db8   R8: 000000007867a738   R9: 0000000000000020
>     R10: 0000000000ffff10  R11: 000000000000000f  R12: ff4a45840a573d00
>     R13: 0000000000000000  R14: 0000000000000000  R15: 0000000000000000
>     ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0018
>  #8 [ff5630b9cb397dc0] rpc_release_resources_task at ffffffffc0533593 [sunrpc]
>  #9 [ff5630b9cb397dd8] __rpc_execute at ffffffffc053d3ff [sunrpc]
> #10 [ff5630b9cb397e38] rpc_async_schedule at ffffffffc053d830 [sunrpc]
> #11 [ff5630b9cb397e58] process_one_work at ffffffffb9efd14e
> #12 [ff5630b9cb397ea0] worker_thread at ffffffffb9efd3a0
> #13 [ff5630b9cb397ee8] kthread at ffffffffb9f06dd6
> #14 [ff5630b9cb397f28] ret_from_fork at ffffffffb9e4c62c
> #15 [ff5630b9cb397f50] ret_from_fork_asm at ffffffffb9e038db

I would be curious to hear if doing the test / set / clear bit operations mentioned above inside the spin lock region makes a difference here.

I hope this helps!
Anna

> 
> 
> Thanks,
> Bharath
> 


