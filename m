Return-Path: <linux-nfs+bounces-9015-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46308A07846
	for <lists+linux-nfs@lfdr.de>; Thu,  9 Jan 2025 14:57:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D095166A62
	for <lists+linux-nfs@lfdr.de>; Thu,  9 Jan 2025 13:57:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68013218EAB;
	Thu,  9 Jan 2025 13:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OzlyHYYI";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="faAY3xBg"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35E2B217658
	for <linux-nfs@vger.kernel.org>; Thu,  9 Jan 2025 13:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736431051; cv=fail; b=ICX4sAiQyJ/u9MWcYYJyljogQTqYl8E1cmrs7HB7934/ynGZ7EcqTx/g4sEDL/gSkeulbDxeH0zETuzqYATSRJ5BDAgDQeN70rWK0EYnny351fCsnttwrBbYI1vnQ8+tx+dsShY5+lMtch7Rq4hSoQDiT/xGsT0Qc9ygs1i9uIk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736431051; c=relaxed/simple;
	bh=CakxqB6O9lwimf33GMiubnDbf/lr8EBX4ohmCnWpRQc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tsOwoHz/Xv61cVGg0Qtv5RdBnonlIN/hLHBpAeSmHpi1Hz+/r8GbTOG3USxPUNPPYnNueeTxu8wMmEp06hlcHSPzFCfT16I4oBWA1OnEn2DZhcW0phi1Fu6QJFDeLPxZXdUAYuJAUJq3A1EARNDb/WDbzKJ4NhpjpVnXpUbzbZ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=OzlyHYYI; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=faAY3xBg; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 509CfpKB025959;
	Thu, 9 Jan 2025 13:57:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=EVeh9uikWbjG466sWx0Mj1Xs+Sy2yNHgNGs97b8/lJw=; b=
	OzlyHYYITLyDX76CYyTM5zPNSEarXS0v0psxOTdGKPYKZpHfVAXMmzDdLyvdmJRW
	X0c3tsxe+CSh79JWIP+GtQ8ORgR3SAdqe/3uWCCwngoA4eJ+N+foZSbrQ5prQ2nc
	ebZHzDP/r0jVHmafl4rENACCJPPghrGEjk9tlZ4difsYmaeVgxV85v++4pY5gSVD
	eDlnLuWs2sbUjhxZn9DIYKMj5bMVNhfnHM1PBHgzVUxvobTxhI/UrQlSAofkW6QY
	bqHsIXrpjIFMH7KHZbVlimwS01g4xGQW/e7c8+mngJw5dcb277wgEw3pT5Gpionj
	TmkU3fHV4p2aqsB/OAq44w==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 442b8ugfa5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 09 Jan 2025 13:57:03 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 509BunI1010834;
	Thu, 9 Jan 2025 13:57:02 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2049.outbound.protection.outlook.com [104.47.58.49])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 43xueaxv68-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 09 Jan 2025 13:57:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rtaSeLz0bKArulzpwP3C4iHUB2MDVKZiaUAnves9W0qI7yIaJ2DkQGlsfTBxipmutUhjIfLwBWKdQSvyXJkp0FRDfWLMJs53Pum6MlpZ1cV5mj/YyuiW5SSo7FPkM7UDDk/A7HcqA2pBXBcnZU1KzxY4vReuhk1WM8/GZjQXv5SLBKuoyhsn8qTUz0+y2ET0VRd0P+9gXZ4reMBtNe/uDvVJU+7T1ht/XvN3MqU4JeZlmq09rL+rHiYuTtDliMH0SMWNQMczZbwzQrn2X/t6u+1/VgmWfJLy0aBnWhYMLisXxKaxmMla2r+dxIlf5i0jZIpl8Sgyn5vktm7hXx72vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EVeh9uikWbjG466sWx0Mj1Xs+Sy2yNHgNGs97b8/lJw=;
 b=x0AKIrzgdnsMQhdyldcRuZefG4LiaNBhf90WPmRQ4j9cXjMCidT4txSD3k/R7C8KCVhnQq+9S+ArV1PQylYYreo7FRBQzyBCmrzast390QmzbB7BHQi09RI55DUjl19w2c3F9Uzxb2ksqzrvMEhUy4/hEnqOiKbomE/l/co3rInSUfQuIYZtsi++qcGDxuCTAKfusMdBnPdR1S9d2Ddq+fDgjgA7AkeiMkWz3kta9dHaU9u4lr3Ag2Dwv1amJapDTvX+7L6jEfuey4LoeXcq0ykw+mXIGJtjBqmgzkpy2MX0N67mxj+JU1Z5HhLFrW1BsCzselljaIR+xuaG0Gg/4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EVeh9uikWbjG466sWx0Mj1Xs+Sy2yNHgNGs97b8/lJw=;
 b=faAY3xBgyJIbhtW1aSOgSnd6o0szy+Ul+pYEBQAA/4CsN92jT18UtbzWvVY15w+p7DnQP3Qbricjs4hh3FnAdhFRmpPx8euUQuBUoYJvBZXSeNqYL1l18nVFAb6nu+hF/6qxblwmBf/BdHK8FPafk8bPRPvVaz4F25OxZ3cBLdY=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS7PR10MB4861.namprd10.prod.outlook.com (2603:10b6:5:3a7::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.13; Thu, 9 Jan
 2025 13:57:00 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%3]) with mapi id 15.20.8335.011; Thu, 9 Jan 2025
 13:57:00 +0000
Message-ID: <8997708a-bf82-41f6-b59d-e605e9140f35@oracle.com>
Date: Thu, 9 Jan 2025 08:56:57 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: nfsd blocks indefinitely in nfsd4_destroy_session
To: Jeff Layton <jlayton@kernel.org>, Christian Herzog <herzog@phys.ethz.ch>
Cc: Salvatore Bonaccorso <carnil@debian.org>,
        Benjamin Coddington <bcodding@redhat.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Harald Dunkel <harald.dunkel@aixigo.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Martin Svec <martin.svec@zoner.cz>,
        Michael Gernoth <debian@zerfleddert.de>,
        Pellegrin Baptiste <Baptiste.Pellegrin@ac-grenoble.fr>
References: <4c3080af-eec7-4af5-8b0d-c35ac98ec074@aixigo.com>
 <C1CE3A96-599C-4D73-BCC0-3587EC68FCB0@oracle.com>
 <Z2vNQ6HXfG_LqBQc@eldamar.lan>
 <ecdae86c-2954-4aca-bf1c-f95408ad0ad4@oracle.com>
 <Z32ZzQiKfEeVoyfU@eldamar.lan>
 <3cdcf2ee-46b3-463d-bc14-0f44062c0bd0@oracle.com>
 <Z36RshcsxU1xFj_X@phys.ethz.ch>
 <7fb711b1-c557-48de-bf91-d522bdbcc575@oracle.com>
 <Z3-5fOEXTSZvmM8F@phys.ethz.ch>
 <36f4892e1332e2322ab46e1343316eb187d78025.camel@kernel.org>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <36f4892e1332e2322ab46e1343316eb187d78025.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR07CA0012.namprd07.prod.outlook.com
 (2603:10b6:610:32::17) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|DS7PR10MB4861:EE_
X-MS-Office365-Filtering-Correlation-Id: 47bcb27a-431a-4b2b-361d-08dd30b57cb7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VnRHMVV6Z2E0TEwwN0NkSERDZnFUK0hXSlVScUhON3BVWks4Q3pDZ2lWNFpD?=
 =?utf-8?B?aFdZeW1EWk0va0ZPUmQzRDR5K0xXaGdOcGNzNi9LR2REQmd0aEZYWlM3T1ll?=
 =?utf-8?B?aloxN21mTkxKZ08rWnZnMHJ6d21saTVGSmFIRjJZZ1hQbHZoNzRza3ZOZGVk?=
 =?utf-8?B?VHY0ciswcG1GdDZ3ZGt0S3VZbHMwWFpjNnJZT2hNTklWNlROVVVXeFJLT2t5?=
 =?utf-8?B?VFMvYk5sWDBSeHU5bjB4OUFYT0Job3EvOG9ISXZ1UmFkQlJVZm9ORFk4UE82?=
 =?utf-8?B?cGw1azF0Qk5vWUk5cGNWL1BXd2pCd2xNdmJCbVBSK0tSUEtpM29nK21CdEMx?=
 =?utf-8?B?WHV5b1M5cUxTNDIybXJYZVVSNGg3bmtoa0dqZGVSU05TdE81TmF6c011RGZr?=
 =?utf-8?B?ZU1kRi84U0xaYjdHbXVXbTU1eWlwbk9ScjRxcWt4WUdTV0x2VnFqMUtsVkdi?=
 =?utf-8?B?K21seXIzT1BSUmpDWXNacXhlMXh3SXFoRHFuaTc0S0h2R28zZnQreGRPOHZy?=
 =?utf-8?B?QVhHOWhJRWZJdWlzbVUwdE9nRDFTYmlCLzJ5ejlqWmFYWmROeER0V2ZLQ0pu?=
 =?utf-8?B?K2tUdDRNVFQ3aTZuNVpGN0dXTjRvOFJOMWRyQXorWXlqRWV6VCtsM21ITFFR?=
 =?utf-8?B?VEJWQnFMU3djZE55NGJvWVEvOUY1UnR5TzZhbHd0TE51NTZHVU5ybEJMbHBH?=
 =?utf-8?B?d3huU3VDanpkb1NpckhwZjhuZVVvYk1TUWRzWUVaTHJ2c2lmYjU0Nnh1ZEw2?=
 =?utf-8?B?amkzTjRhNFArUCt3c2NFbmpraHVpaEY0bkJYUGV4NHlnUWkzY1hBSUpNa0tl?=
 =?utf-8?B?NXVjekFBOXVlem0vT2FXclBvSlc5bFhUaHNOVnZWbmZmeWlsTnhIZ2VnVnRK?=
 =?utf-8?B?enJGMS9KcnpYcCtKSnVDMXdkUXJIb0owaWVqcnhRQVdQZVI5VGlTdUVySTA0?=
 =?utf-8?B?Y2Y4WmdRdEQ4V0c5YjF0RnI5V1R6c3d5SGxyQ2NDNGQ2cjVHNkR6RllicG1C?=
 =?utf-8?B?Ylh4dXpueUlUNS9rUkc0Vkcwano2MGtWNDFFTlJLKzZobk5pWlhsZG5rdVpY?=
 =?utf-8?B?a0FnMGRGWHZvYjU4NXhTeVRuajZScWE4RWpmZHMvSmRqWUpMYVh0cDhLY3hi?=
 =?utf-8?B?ZDRZcGlCd2QwaVg1YjJEendod0hjWFpKWThSRDhlTFpHU2c0ZFQ2dmRzMWFy?=
 =?utf-8?B?U09MMHlzc3FNZ0dQQitjdzJtT2tNQTlIMStUclJ2SFFJRytBVTF3ZlliMlBs?=
 =?utf-8?B?aTFGN0ZYUkhpNWxUeUszb291UVJLMEU0RGx1T29RK1pJcG15VzRDYmVsT1Ba?=
 =?utf-8?B?NFp5NWgxaVk1TE1mZlFodWJDNWdyYXl3ZXlBN3ZOd1VvSTZKTE04blNjcWc3?=
 =?utf-8?B?WnVwRjRScW8yQjRqMXhVa3pyUGZOVXpab25POFFLY2prdDd4VnY2ZFBHNWFO?=
 =?utf-8?B?Qk5vU0h0RG1Qa3k2RXYrczhiQm5KcmVlOFoveVhiZ1Bncm1jOU1zUFhUcytt?=
 =?utf-8?B?NGhvbkxzV045VGYvU0hVUWM3bUJ4Y3VXdk9GK0tyOVI2TG9zbjg3bHEzQjRY?=
 =?utf-8?B?cHlCUjJ3d3ZSZkRVR0hITFYzcUt2anpWQWxMK3RNNWFzSTR3K09oTXlpbFov?=
 =?utf-8?B?YUZsR3JiL2c2UGd4d2E4T0hralMrNU5vOGtrYXRZV21vSjBuZmNsMWxjVzg3?=
 =?utf-8?B?OWdzTFVHQlRrcUFRSDZTcUJUMGxTaVkzbCtWWEY5bW96b0FPYjZFMkUzMEZE?=
 =?utf-8?B?T1A3azlHM0czTUJwL1lFVWZaOSthd3pTanhIeFFYOXhkQVhWdlJvTGwwNitV?=
 =?utf-8?B?M1hTTkl3TTkvYTBsdjUvdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Nk43RXJzeFh6djhRMUMwc2JlYXk5Y0lZMmJXWElqWm83WUZKTVFwNTVmZmFU?=
 =?utf-8?B?cTRlK3lHdDdpZTYwZUg5QzN0UEVkNkxNOW5CS21jTmQyMUdWS1o1bTZDZ2t2?=
 =?utf-8?B?dWdOLzhEZytBTFJYbTd0RlVaaU9DaE5HWUlzWWJBeW93TWI3SzczMW16WkJV?=
 =?utf-8?B?c2JJTk5ESVorZXNRTVl4NmhNR3NlL3FBVTN6L29YMEZJRXNNSEZDcUIvekh4?=
 =?utf-8?B?UXJHczBFZWpyQnQzLzRzaU05YXh6MkgwajdnM2N5cnd2SUV1VHJnVUluQXZQ?=
 =?utf-8?B?ZWNNaXZSSitZU21Bckp4amI2N0RLSHZYUHNhbFdDSzE5cEl2VVlBQjJ4NDlq?=
 =?utf-8?B?Y1JFVFVsbTl0TGl6NmM0NHFHbVBLUjVYalR1dFR1S1I5MUE5MUJpYklYUEx5?=
 =?utf-8?B?UTgxWE1xeXpkdG85bFRISDBXRE1LYUFEcmxXd0E5cC9rMjNIMzVsdUYzUGZx?=
 =?utf-8?B?SmFRUmt5MjJrVE4wQ1RLblk3azJDUkVvSkUraEI4bjVqMlRVZ05KRnluOUtm?=
 =?utf-8?B?NXdDVmFneks0cjcxcmtxOGN1OHlzeGxOaDJJK3piL1ErL0kxL29rQURTemNx?=
 =?utf-8?B?cUpzUWFyVE9KTlczbDdHLzZqa0Fqck5rb0U0djluU2xkb0g3V0F3WjRNME5C?=
 =?utf-8?B?amdZdTBXV0hFMHI3d0VaZWN3WjFRaVFmVUk0bXI0L3ZQMW5XWTd3d0VhUFZX?=
 =?utf-8?B?cHIwMjBTank3YUNYZW02RHNadEVYMHJ2dGtIWDllZG53dnFwNnlUaWdxS2Y0?=
 =?utf-8?B?anBXOXhhY3MzOXREM2FpQXZPaXpzclVYemZMOE1KRmtOak50OUhyYTFkYlRJ?=
 =?utf-8?B?UlNjczl0RVVMd1hNaWpSWHNZL0dIS1FPMkdZYTRNb1lSRjBHS1JZekJrYnZo?=
 =?utf-8?B?NGFSeG9YTi82Zjh0bzVJbkxpdG1DYUVXL1k2VTJmamRUclptN1pHZCtNOVJj?=
 =?utf-8?B?UVJJQklJcitac0YzVnllSHE0UGNjNHFtUXZXeDF0L0hJSWFvRStNREhGaVR1?=
 =?utf-8?B?TFpHSkRMYXRVSXNWZ1RtZlhhS0dLWnhaRUZodGZiUDl2d3NqQTI4am16Y3VJ?=
 =?utf-8?B?SjFVTUxKTUdjTW5IalRjN0FmYkIrN2RpU2lQaUFRVWc3TllMcElQcC9vamFu?=
 =?utf-8?B?bkhGNmVvcEtiL2JUMFZtb1NtY2YwRndObzVlVHFPRVRXeXA3cGI3SG5FOEx4?=
 =?utf-8?B?UTJvd25qMUVIMXNxNzJ0UGJHRGs1Z0Q5QnhWSEg0WS9MNUE5SVBFWjZiSEov?=
 =?utf-8?B?YjdQdkZFRTA4ZUtpbkFacHl6RTBPSFVJekpJNWwyMEZ1TmRieWUrYktNYjJO?=
 =?utf-8?B?bytyZkh1UGJ2T0tWOU1RZlVVZksxQ0V4QmZ0ZzZsMXpzS1NCYzJCM0oyT1NO?=
 =?utf-8?B?WHdML3pOYUk2RTdwbU82UVE1SnBRTDMvdXpITXBjSnlHQ3JIQUtkanpJUENQ?=
 =?utf-8?B?cWxCQTNuK2dQRHViVHRWM1BhRjFDYTk4bG9CM3A0UHJXdFZLSEp0OHhEN2pC?=
 =?utf-8?B?bkE3MUM2QUl6UU9mdDhHNnk2ZUd1SGRBWkFEOE5VSVQrb0ZYQXZuZmJZb3VK?=
 =?utf-8?B?UDlRcUFObWVaTHk2STdKR2dkdXoyMkk2eUd6QzdwU1hQZnUwOFMrTGhrdHVW?=
 =?utf-8?B?UTVPNEt0bG1MV2J0RDZhZldwSGlCR3k2UUhha0Q0aFRTSzdUWG1LNm5PY3lh?=
 =?utf-8?B?RlUyaVpPOEdYa3NpaVFsaVN4aU9wdzRKd1lVYWNWTmtTYytKYjU5ejRFNFQ0?=
 =?utf-8?B?Zmp4KzVGbk5ZdWRRRGM2Qi9CMGJhZzYxNnpqVURlcEFsQnpXL25QcGpqMWFC?=
 =?utf-8?B?VDlBeHUxckRSNndFZmMwcTdZTlllamUvYmNOYm13R05oOWdiN0E2TXRKOG5B?=
 =?utf-8?B?V2U2MlhPcTU5L2ZDWlppSzJoNkxRd2Fzc3AxbEF5SjBIemVFQktUeTQ2Q0p5?=
 =?utf-8?B?WjBkZk1hb1p1S0ZIRERVT0VKNkE2WkdOaG9Rbjc2RDdvV1ZQc29CRlA4U09z?=
 =?utf-8?B?SUJueDBZL1dEbkdzcDBxNVloVEdJS1RQclhZbmFLUmRsMGVBVzFZTk9iSnRi?=
 =?utf-8?B?QzBFeXJXeGk2MkVVM2dZTHRKWGhTQ1hXNGhyU0JqRm9yQ3FlbGVMbGpJVXlM?=
 =?utf-8?B?RDR2enF4WHAyT2NoNTMyMzg2aklQZmNJeklCazBocS9WMU9sbWtLU0RJM25n?=
 =?utf-8?B?Wnc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	g4670glqQo5DE7aRd/JzJrw0Ln0r72FRF0T70H+M0ohMmYkbaWw6CuftR+m+PuEsBBubBJZOMBCpn2vZ/A2ibKZGUwV/B0d0WM4HNEAt6QwzGGeTPwoScQ1tKcwDeCcWLzorIrHyc+A4TySK+nPYfDKLu6a552GRpDLZgPfhqaf9s4HNI4cGmSjToJ85/tj+9sLlKQHM+gNnEAQBv/5G9aIThG94DmYGVkC56pwHelKroImsniqLKm7k7jW6QWmzIRH04nVtxJ+BfOzCRqmQv2j/6bi+W19+4xu4UI3MJs5COFqWi/cB7cG+la3cTRTWoV0QY7VG3YDHEqQoCwWw9H0G1mTaRvzrO3JJS1/KxpNzevPmkEGCQrb8HAl7T3+wQhXVrH2MIM8pKZjaKKpMhLDAoz4PNWSjBm45iskwce/FfE/462+SusIgydMFWzEylyTCzCJS3IgV3wdOLOCc1N3hfz617MBaL8/ZRy/PdARbdsqoDu3fsQO2nYsjP6/fNnfVDIZdczzpaszTYd4GyzR3FNstXiwmcBwkUHrqqHRwTGUwlOf0tQYuZiHk49KKe8n9Qmfi0a3KQKWdEy2wVlxFgo2NAkfoDR9QxlZ2qqo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47bcb27a-431a-4b2b-361d-08dd30b57cb7
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2025 13:56:59.9473
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vkFQkLhBzD2skaNuvDFr6MsgVCbesEPhYJvlgfcoIiIafzBtuE7fH3Lu6GhsnAJRhf7H48Jp1dvbbF0MnMcnvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4861
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-09_05,2025-01-09_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 adultscore=0 mlxlogscore=999 suspectscore=0 mlxscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2411120000 definitions=main-2501090111
X-Proofpoint-ORIG-GUID: s7Ym1p-MwxFqcMpBavr9StSYec2q_4l2
X-Proofpoint-GUID: s7Ym1p-MwxFqcMpBavr9StSYec2q_4l2

On 1/9/25 7:42 AM, Jeff Layton wrote:
> On Thu, 2025-01-09 at 12:56 +0100, Christian Herzog wrote:
>> Dear Chuck,
>>
>> On Wed, Jan 08, 2025 at 10:07:49AM -0500, Chuck Lever wrote:
>>> On 1/8/25 9:54 AM, Christian Herzog wrote:
>>>> Dear Chuck,
>>>>
>>>> On Wed, Jan 08, 2025 at 08:33:23AM -0500, Chuck Lever wrote:
>>>>> On 1/7/25 4:17 PM, Salvatore Bonaccorso wrote:
>>>>>> Hi Chuck,
>>>>>>
>>>>>> Thanks for your time on this, much appreciated.
>>>>>>
>>>>>> On Wed, Jan 01, 2025 at 02:24:50PM -0500, Chuck Lever wrote:
>>>>>>> On 12/25/24 4:15 AM, Salvatore Bonaccorso wrote:
>>>>>>>> Hi Chuck, hi all,
>>>>>>>>
>>>>>>>> [it was not ideal to pick one of the message for this followup, let me
>>>>>>>> know if you want a complete new thread, adding as well Benjamin and
>>>>>>>> Trond as they are involved in one mentioned patch]
>>>>>>>>
>>>>>>>> On Mon, Jun 17, 2024 at 02:31:54PM +0000, Chuck Lever III wrote:
>>>>>>>>>
>>>>>>>>>
>>>>>>>>>> On Jun 17, 2024, at 2:55 AM, Harald Dunkel <harald.dunkel@aixigo.com> wrote:
>>>>>>>>>>
>>>>>>>>>> Hi folks,
>>>>>>>>>>
>>>>>>>>>> what would be the reason for nfsd getting stuck somehow and becoming
>>>>>>>>>> an unkillable process? See
>>>>>>>>>>
>>>>>>>>>> - https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1071562
>>>>>>>>>> - https://bugs.launchpad.net/ubuntu/+source/nfs-utils/+bug/2062568
>>>>>>>>>>
>>>>>>>>>> Doesn't this mean that something inside the kernel gets stuck as
>>>>>>>>>> well? Seems odd to me.
>>>>>>>>>
>>>>>>>>> I'm not familiar with the Debian or Ubuntu kernel packages. Can
>>>>>>>>> the kernel release numbers be translated to LTS kernel releases
>>>>>>>>> please? Need both "last known working" and "first broken" releases.
>>>>>>>>>
>>>>>>>>> This:
>>>>>>>>>
>>>>>>>>> [ 6596.911785] RPC: Could not send backchannel reply error: -110
>>>>>>>>> [ 6596.972490] RPC: Could not send backchannel reply error: -110
>>>>>>>>> [ 6837.281307] RPC: Could not send backchannel reply error: -110
>>>>>>>>>
>>>>>>>>> is a known set of client backchannel bugs. Knowing the LTS kernel
>>>>>>>>> releases (see above) will help us figure out what needs to be
>>>>>>>>> backported to the LTS kernels kernels in question.
>>>>>>>>>
>>>>>>>>> This:
>>>>>>>>>
>>>>>>>>> [11183.290619] wait_for_completion+0x88/0x150
>>>>>>>>> [11183.290623] __flush_workqueue+0x140/0x3e0
>>>>>>>>> [11183.290629] nfsd4_probe_callback_sync+0x1a/0x30 [nfsd]
>>>>>>>>> [11183.290689] nfsd4_destroy_session+0x186/0x260 [nfsd]
>>>>>>>>>
>>>>>>>>> is probably related to the backchannel errors on the client, but
>>>>>>>>> client bugs shouldn't cause the server to hang like this. We
>>>>>>>>> might be able to say more if you can provide the kernel release
>>>>>>>>> translations (see above).
>>>>>>>>
>>>>>>>> In Debian we hstill have the bug #1071562 open and one person notified
>>>>>>>> mye offlist that it appears that the issue get more frequent since
>>>>>>>> they updated on NFS client side from Ubuntu 20.04 to Debian bookworm
>>>>>>>> with a 6.1.y based kernel).
>>>>>>>>
>>>>>>>> Some people around those issues, seem to claim that the change
>>>>>>>> mentioned in
>>>>>>>> https://lists.proxmox.com/pipermail/pve-devel/2024-July/064614.html
>>>>>>>> would fix the issue, which is as well backchannel related.
>>>>>>>>
>>>>>>>> This is upstream: 6ddc9deacc13 ("SUNRPC: Fix backchannel reply,
>>>>>>>> again"). While this commit fixes 57331a59ac0d ("NFSv4.1: Use the
>>>>>>>> nfs_client's rpc timeouts for backchannel") this is not something
>>>>>>>> which goes back to 6.1.y, could it be possible that hte backchannel
>>>>>>>> refactoring and this final fix indeeds fixes the issue?
>>>>>>>>
>>>>>>>> As people report it is not easily reproducible, so this makes it
>>>>>>>> harder to identify fixes correctly.
>>>>>>>>
>>>>>>>> I gave a (short) stance on trying to backport commits up to
>>>>>>>> 6ddc9deacc13 ("SUNRPC: Fix backchannel reply, again") but this quickly
>>>>>>>> seems to indicate it is probably still not the right thing for
>>>>>>>> backporting to the older stable series.
>>>>>>>>
>>>>>>>> As at least pre-requisites:
>>>>>>>>
>>>>>>>> 2009e32997ed568a305cf9bc7bf27d22e0f6ccda
>>>>>>>> 4119bd0306652776cb0b7caa3aea5b2a93aecb89
>>>>>>>> 163cdfca341b76c958567ae0966bd3575c5c6192
>>>>>>>> f4afc8fead386c81fda2593ad6162271d26667f8
>>>>>>>> 6ed8cdf967f7e9fc96cd1c129719ef99db2f9afc
>>>>>>>> 57331a59ac0d680f606403eb24edd3c35aecba31
>>>>>>>>
>>>>>>>> and still there would be conflicting codepaths (and does not seem
>>>>>>>> right).
>>>>>>>>
>>>>>>>> Chuck, Benjamin, Trond, is there anything we can provive on reporters
>>>>>>>> side that we can try to tackle this issue better?
>>>>>>>
>>>>>>> As I've indicated before, NFSD should not block no matter what the
>>>>>>> client may or may not be doing. I'd like to focus on the server first.
>>>>>>>
>>>>>>> What is the result of:
>>>>>>>
>>>>>>> $ cd <Bookworm's v6.1.90 kernel source >
>>>>>>> $ unset KBUILD_OUTPUT
>>>>>>> $ make -j `nproc`
>>>>>>> $ scripts/faddr2line \
>>>>>>> 	fs/nfsd/nfs4state.o \
>>>>>>> 	nfsd4_destroy_session+0x16d
>>>>>>>
>>>>>>> Since this issue appeared after v6.1.1, is it possible to bisect
>>>>>>> between v6.1.1 and v6.1.90 ?
>>>>>>
>>>>>> First please note, at least speaking of triggering the issue in
>>>>>> Debian, Debian has moved to 6.1.119 based kernel already (and soon in
>>>>>> the weekends point release move to 6.1.123).
>>>>>>
>>>>>> That said, one of the users which regularly seems to be hit by the
>>>>>> issue was able to provide the above requested information, based for
>>>>>> 6.1.119:
>>>>>>
>>>>>> ~/kernel/linux-source-6.1# make kernelversion
>>>>>> 6.1.119
>>>>>> ~/kernel/linux-source-6.1# scripts/faddr2line fs/nfsd/nfs4state.o nfsd4_destroy_session+0x16d
>>>>>> nfsd4_destroy_session+0x16d/0x250:
>>>>>> __list_del_entry at /root/kernel/linux-source-6.1/./include/linux/list.h:134
>>>>>> (inlined by) list_del at /root/kernel/linux-source-6.1/./include/linux/list.h:148
>>>>>> (inlined by) unhash_session at /root/kernel/linux-source-6.1/fs/nfsd/nfs4state.c:2062
>>>>>> (inlined by) nfsd4_destroy_session at /root/kernel/linux-source-6.1/fs/nfsd/nfs4state.c:3856
>>>>>>
>>>>>> They could provide as well a decode_stacktrace output for the recent
>>>>>> hit (if that is helpful for you):
>>>>>>
>>>>>> [Mon Jan 6 13:25:28 2025] INFO: task nfsd:55306 blocked for more than 6883 seconds.
>>>>>> [Mon Jan 6 13:25:28 2025]       Not tainted 6.1.0-28-amd64 #1 Debian 6.1.119-1
>>>>>> [Mon Jan 6 13:25:28 2025] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
>>>>>> [Mon Jan 6 13:25:28 2025] task:nfsd            state:D stack:0     pid:55306 ppid:2      flags:0x00004000
>>>>>> [Mon Jan 6 13:25:28 2025] Call Trace:
>>>>>> [Mon Jan 6 13:25:28 2025]  <TASK>
>>>>>> [Mon Jan 6 13:25:28 2025] __schedule+0x34d/0x9e0
>>>>>> [Mon Jan 6 13:25:28 2025] schedule+0x5a/0xd0
>>>>>> [Mon Jan 6 13:25:28 2025] schedule_timeout+0x118/0x150
>>>>>> [Mon Jan 6 13:25:28 2025] wait_for_completion+0x86/0x160
>>>>>> [Mon Jan 6 13:25:28 2025] __flush_workqueue+0x152/0x420
>>>>>> [Mon Jan 6 13:25:28 2025] nfsd4_destroy_session (debian/build/build_amd64_none_amd64/include/linux/spinlock.h:351 debian/build/build_amd64_none_amd64/fs/nfsd/nfs4state.c:3861) nfsd
>>>>>> [Mon Jan 6 13:25:28 2025] nfsd4_proc_compound (debian/build/build_amd64_none_amd64/fs/nfsd/nfs4proc.c:2680) nfsd
>>>>>> [Mon Jan 6 13:25:28 2025] nfsd_dispatch (debian/build/build_amd64_none_amd64/fs/nfsd/nfssvc.c:1022) nfsd
>>>>>> [Mon Jan 6 13:25:28 2025] svc_process_common (debian/build/build_amd64_none_amd64/net/sunrpc/svc.c:1344) sunrpc
>>>>>> [Mon Jan 6 13:25:28 2025] ? svc_recv (debian/build/build_amd64_none_amd64/net/sunrpc/svc_xprt.c:897) sunrpc
>>>>>> [Mon Jan 6 13:25:28 2025] ? nfsd_svc (debian/build/build_amd64_none_amd64/fs/nfsd/nfssvc.c:983) nfsd
>>>>>> [Mon Jan 6 13:25:28 2025] ? nfsd_inet6addr_event (debian/build/build_amd64_none_amd64/fs/nfsd/nfssvc.c:922) nfsd
>>>>>> [Mon Jan 6 13:25:28 2025] svc_process (debian/build/build_amd64_none_amd64/net/sunrpc/svc.c:1474) sunrpc
>>>>>> [Mon Jan 6 13:25:28 2025] nfsd (debian/build/build_amd64_none_amd64/fs/nfsd/nfssvc.c:960) nfsd
>>>>>> [Mon Jan 6 13:25:28 2025] kthread+0xd7/0x100
>>>>>> [Mon Jan 6 13:25:28 2025] ? kthread_complete_and_exit+0x20/0x20
>>>>>> [Mon Jan 6 13:25:28 2025] ret_from_fork+0x1f/0x30
>>>>>> [Mon Jan  6 13:25:28 2025]  </TASK>
>>>>>>
>>>>>> The question about bisection is actually harder, those are production
>>>>>> systems and I understand it's not possible to do bisect there, while
>>>>>> unfortunately not reprodcing the issue on "lab conditions".
>>>>>>
>>>>>> Does the above give us still a clue on what you were looking for?
>>>>>
>>>>> Thanks for the update.
>>>>>
>>>>> It's possible that 38f080f3cd19 ("NFSD: Move callback_wq into struct
>>>>> nfs4_client"), while not a specific fix for this issue, might offer some
>>>>> relief by preventing the DESTROY_SESSION hang from affecting all other
>>>>> clients of the degraded server.
>>>>>
>>>>> Not having a reproducer or the ability to bisect puts a damper on
>>>>> things. The next step, then, is to enable tracing on servers where this
>>>>> issue can come up, and wait for the hang to occur. The following command
>>>>> captures information only about callback operation, so it should not
>>>>> generate much data or impact server performance.
>>>>>
>>>>>     # trace-cmd record -e nfsd:nfsd_cb\*
>>>>>
>>>>> Let that run until the problem occurs, then ^C, compress the resulting
>>>>> trace.dat file, and either attach it to 1071562 or email it to me
>>>>> privately.
>>>> thanks for the follow-up.
>>>>
>>>> I am the "customer" with two affected file servers. We have since moved those
>>>> servers to the backports kernel (6.11.10) in the hope of forward fixing the
>>>> issue. If this kernel is stable, I'm afraid I can't go back to the 'bad'
>>>> kernel (700+ researchers affected..), and we're also not able to trigger the
>>>> issue on our test environment.
>>>
>>> Hello Dr. Herzog -
>>>
>>> If the problem recurs on 6.11, the trace-cmd I suggest above works
>>> there as well.
>> the bad news is: it just happened again with the bpo kernel.
>>
>> We then immediately started trace-cmd since usually there are several call
>> traces in a row and we did get a trace.dat:
>> http://people.phys.ethz.ch/~daduke/trace.dat
>>
>> we did notice however that the stack trace looked a bit different this time:
>>
>>      INFO: task nfsd:2566 blocked for more than 5799 seconds.
>>      Tainted: G        W          6.11.10+bpo-amd64 #1 Debia>
>>      "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables t>
>>      task:nfsd            state:D stack:0     pid:2566  tgid:2566 >
>>      Call Trace:
>>      <TASK>
>>      __schedule+0x400/0xad0
>>      schedule+0x27/0xf0
>>      nfsd4_shutdown_callback+0xfe/0x140 [nfsd]
>>      ? __pfx_var_wake_function+0x10/0x10
>>      __destroy_client+0x1f0/0x290 [nfsd]
>>      nfsd4_destroy_clientid+0xf1/0x1e0 [nfsd]
>>      ? svcauth_unix_set_client+0x586/0x5f0 [sunrpc]
>>      nfsd4_proc_compound+0x34d/0x670 [nfsd]
>>      nfsd_dispatch+0xfd/0x220 [nfsd]
>>      svc_process_common+0x2f7/0x700 [sunrpc]
>>      ? __pfx_nfsd_dispatch+0x10/0x10 [nfsd]
>>      svc_process+0x131/0x180 [sunrpc]
>>      svc_recv+0x830/0xa10 [sunrpc]
>>      ? __pfx_nfsd+0x10/0x10 [nfsd]
>>      nfsd+0x87/0xf0 [nfsd]
>>      kthread+0xcf/0x100
>>      ? __pfx_kthread+0x10/0x10
>>      ret_from_fork+0x31/0x50
>>      ? __pfx_kthread+0x10/0x10
>>      ret_from_fork_asm+0x1a/0x30
>>      </TASK>
>>
>> and also the state of the offending client in `/proc/fs/nfsd/clients/*/info`
>> used to be callback state: UNKNOWN while now it is DOWN or FAULT. No idea
>> what it means, but I thought it was worth mentioning.
>>
> 
> Looks like this is hung in nfsd41_cb_inflight_wait_complete() ? That
> probably means that the cl_cb_inflight counter is stuck at >0. I'm
> guessing that means that there is some callback that it's expecting to
> complete that isn't. From nfsd4_shutdown_callback():
> 
>          /*
>           * Note this won't actually result in a null callback;
>           * instead, nfsd4_run_cb_null() will detect the killed
>           * client, destroy the rpc client, and stop:
>           */
>          nfsd4_run_cb(&clp->cl_cb_null);
>          flush_workqueue(clp->cl_callback_wq);
>          nfsd41_cb_inflight_wait_complete(clp);
> 
> ...it sounds like that isn't happening properly though.
> 
> It might be interesting to see if you can track down the callback
> client in /sys/kernel/debug/sunrpc and see what it's doing.

Could be that the RPC client was shutdown while there were outstanding
callbacks, and that means that counter can now never go to zero?



-- 
Chuck Lever

