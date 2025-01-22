Return-Path: <linux-nfs+bounces-9476-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C622FA1960F
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Jan 2025 17:06:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5348616C43D
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Jan 2025 16:06:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EB0021481A;
	Wed, 22 Jan 2025 16:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="IlEVd88t";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="GVpKN2Xl"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C78DE21480F;
	Wed, 22 Jan 2025 16:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737561995; cv=fail; b=Y6Wmc2NGWDK03uIiTEJu9gYpbZ5mJI/uE+T6a0WERYEfqJWDSWgGIn6H6+B9GVF5PeADaMWI9n6MvdU4VPhysWniW0WJGriwpPHiFiJbJqCCY2KEuybhJZa/U3ZKqLcCMysPuM6CWwlHXKUjZvSXSL3RXzVsTVpWB1QruArZ6O4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737561995; c=relaxed/simple;
	bh=41JLAGVDYJt/A3A233/q1ysQmK6zfjOiYY/SaSgmsCw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tEKvW/pRGfMIvQbHjhS26ZIR40H4lHroVSfiaOfCHsfivmXqhI8+zQfB784LBfZN0JgddJp17IST93KTziyJZVI4yQ4E+PaKNx02oEEcGiv1638S4bhfrCLWNCjhmuBJKPlUaZiSMUv4qWAR2Mkh+q8uel5BoYZNtiQFrax3yLM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=IlEVd88t; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=GVpKN2Xl; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50MFfwew000522;
	Wed, 22 Jan 2025 16:06:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=5rwzyJVvjFD36rCB9u0M7LSUcTIbZMAk2lt/3ttLqR0=; b=
	IlEVd88t4hKE2uf1Jsr2YwvTslUniqRRab0zIE4Br6ECeGpSJ03sD1seUWxNGLQF
	StNI51Y1qny8+3lx+YL6xWG8ozMtlSMcINR2WEKqOd+Gv8Z9AHb857amdIwAVejt
	IKY7Q6V9m5Dpd0OSWUNVz5pzNGxjHQH4t0xNd/vnM8k8S2uJ09sMWv8z6FpQajeF
	DXIWrye8Ew+7IMAjC6L5WB/2bQoHITDHXb6pnmPbupX1HameP1f6auZGeug+J79U
	gE+rkkp04mQeA1Q78iEPdWxahBXafj7Wb7QC32Sxb+tOJ0dMPVvYFlhZhLZKhqO/
	kDzDg7Mx/eQoCGP0KOtLuw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4485nsfy7e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 Jan 2025 16:06:23 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 50MFrwOO018627;
	Wed, 22 Jan 2025 16:06:23 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2174.outbound.protection.outlook.com [104.47.58.174])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4491c3tega-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 Jan 2025 16:06:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=poUkaco/BLcXX0Vz63jpbhfbnsXyS8rOgiO6ZiECtpFffiwLSls/2TkrE/I0+s2Fe1LcWg2VhgOkaJT17/5nGqdTk0A/1en1mhJ7trEdqgh7hQLsPJ4/wocFDbywsxH6gpzRpkNv0bnos7bDVn3X1l0URA5PUSBq9fAs/prSOturO22LjmcqtDHLZcpsElAG4jku83zEANwkaqAz3kfB6wglJtZuAQcKYVEYiWotT+jjpeaXJEuNZjKjrm64Rk4S8YryGDe9IFn+5m75OutT8bDMXS/9RbRHhqRy9aN5qC7PjGVdsROjcujRLYN0p6xmrFIxENBaawS4o53towx62Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5rwzyJVvjFD36rCB9u0M7LSUcTIbZMAk2lt/3ttLqR0=;
 b=pvyeSYUSz6s68eshslvJOssCg/Z13KslyRO5W6H+UfaXTC32NMWFKn5F2KjASPa+XEEYrwte64r9vWjxQCwFadmnOz1GcNhfgQdnkI/G6OnmpO+YcVEVwouu8NaBejnkrba5N9g9niXDbMidvMcoB3IVyeDh76Wc7f/eiOJ4rPnL5DzxTnrUo8xmgg0/e++PqrhR4/WzXWv+yDpVxqsfIf+gduLVvPrXGM4/sBMvaog9qRoc3xH0Zd9F5KJvgrSvAzYdhrQBF9HJpE4niX5sFbiG31+FJdAfOGJICbdJZVma/j1u/MhlGHcjxC7zeNh6Ga/EnlallL3bLw8oYMmG2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5rwzyJVvjFD36rCB9u0M7LSUcTIbZMAk2lt/3ttLqR0=;
 b=GVpKN2XlePqWrrkesht0iHFovKFtSiyCIpQ6vKA2qViPmdRKFcX5jmc3GBf4TfsnYXpcpWfAmC/DLeJNYwGnoTdnKX+nlU/sDXb9xkQLobAq7+gwzOx8IuMWq43FrFxt8ePWDFcJdGhz7Nk0qvEn3FoVY6WKPr/p5BL2HdjAqhQ=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SA1PR10MB7593.namprd10.prod.outlook.com (2603:10b6:806:385::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.20; Wed, 22 Jan
 2025 16:06:21 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%3]) with mapi id 15.20.8356.020; Wed, 22 Jan 2025
 16:06:21 +0000
Message-ID: <84527e1a-a163-49b3-8335-a551c2822929@oracle.com>
Date: Wed, 22 Jan 2025 11:06:19 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nfsd: always handle RPC_SIGNALLED earlier in
 nfsd4_cb_sequence_done()
To: Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>,
        Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250122-nfsd-6-14-v1-1-6e1fb49ac545@kernel.org>
 <e85a0515-7972-4428-9270-a982073adcb4@oracle.com>
 <6196ed07e6db1bf664d2f10280cbe0e80857583e.camel@kernel.org>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <6196ed07e6db1bf664d2f10280cbe0e80857583e.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0089.namprd03.prod.outlook.com
 (2603:10b6:610:cc::34) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SA1PR10MB7593:EE_
X-MS-Office365-Filtering-Correlation-Id: af994988-bd75-46c3-141c-08dd3afeb671
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TWRqaVpPMWN6RVBOK0NIRG1CYWZ3U2pjY2RMZUVya1NvZGFGOGVrN0JxT1RP?=
 =?utf-8?B?RWxRWDdoSzd5elJDU0dPeU9OZ0x2Rm1yV3l3eU5udUlvUWs3dDNSc3lLcjdI?=
 =?utf-8?B?c01ERGJYNjZkdmVpb29McWYzekQrNGxzWitjSDFlWk5pVEFjSDJ6Y3VXenJS?=
 =?utf-8?B?SXN2TENiM3phTEZ0eCtBcEUrNWdITkhTN0Q4dUJVOHJKVmROVWE0RHc4MVZi?=
 =?utf-8?B?T0tTcERFYVpBTWh1bDZBRSswc0FjdkY4ei9ZTDZpRWRDUVhUbmZkUXJudWsr?=
 =?utf-8?B?NThtaXN5MWtsK0s5WkZyYmhrYlNNeWtvMlJWa3RVMGU2aFBXZFVCSjcvVlMz?=
 =?utf-8?B?bm14eU1PWXA2S2ZQVENrL3dIbk1wODl0Ym9rTHN6c1hwMHlLRjBkMXV6OUxO?=
 =?utf-8?B?ZXcvc3lKUDdLREQzbmZaY3JxSXRrNUtPV3FmWHJhSzV6K0swanRFd3NydzNP?=
 =?utf-8?B?R0pOM1B1WWtuamV6S3VzaW1iU0hseEs5UW5KUFk1WE5hS0FCK0k5Mkk0dlJt?=
 =?utf-8?B?cG8xNGZhYkFkb0YrVCtFRk9DajhBMlB3eXM0Wms0OThzMGlDYTMyN3NsQVo4?=
 =?utf-8?B?ZzcxNDlHbktIUWdvQ2RCcFlhYncxS0xvbDU2MFFXcUpiZ29BdzhRdmdxMnUz?=
 =?utf-8?B?cGs2VTRxcmNaR2UxZFUyTEdPck1oeVFlZVdVYTlaUVZJM0dQbUVGSlN3OGZS?=
 =?utf-8?B?YUhoamF2NERrWlNLY095V0FjWkNEV09Qdk9zNW1ydGg2M0gzOFlwQmdSM0dN?=
 =?utf-8?B?ZzNUL1ZRUlVmSDRJOWZqcmRkVTUxWkJESGY3OVI4aFB6RFZhLzNFZ3c4UlU4?=
 =?utf-8?B?bXpGYW5qT1g5ZU9TVnEzTmU5b2NhaGFKOXZaWnBnc3JmKzk3Q0F2dXVXRVUz?=
 =?utf-8?B?UjdXQVRlVzdXV09oV3lmbVNHOXpTcStjSjRIQlRSNG9XOXhMOGJXRHgyVlgz?=
 =?utf-8?B?ZytGSFl4QjhDZEcvbE16UDM3c3NEN3ByKzJVOXc4UEVXMjd1QXBiK3lmZHlm?=
 =?utf-8?B?U3dpZTFDRWVrZFBlT3hMRUVMYm1JTmJLOU44ZkxDVTFVM25oQ0VweVdKR09B?=
 =?utf-8?B?Y3JNRFdUY2xJTWVDOUZqKzV6Z01raGVKYlltSi9BbkxXUnNJVzZrb2ZMSkt1?=
 =?utf-8?B?VlFSa3p0R2ZYZXRWcWkraHdEWGFZYUl5QTZ6ZEcxZWE2UjBmMGhJM2o1Nys4?=
 =?utf-8?B?OEhEMmh3NnlIN2FyajdlRzkyMHFYOUxVd1JLdDZBaDRLN2hCM0J5ZXpBL0xN?=
 =?utf-8?B?RXJ4WGxoeENqZlZIam5nbHd5Um5NUlgxd3doNGNVOUZGYXFRVHlrYlZycTEv?=
 =?utf-8?B?TWhuMS9WU3AwbFQwQmhSMFZZM3RWRzRON3lBZEt0eng2bCtYMmkxWlN4WUlE?=
 =?utf-8?B?ZHh6V2ZJSUFOdWlRRDNlZkdLcU1XamF5T0Joa3c3VW92VWRMUDlTeFhmVzZj?=
 =?utf-8?B?RHY2c0dxZXJwQlhxSVZCbURaWlVwOVA0VngzTmdjWWNpY1JKU2hnRGV3Sit3?=
 =?utf-8?B?WVNnM09LR2lTd3NSSG51NzRkaHJ1OUpJUEJ6V0lLREtVVm9VOWRSV3lld2RI?=
 =?utf-8?B?S2REV3BIUHgzNnNaVloxTTZZeGZrV0VOVUJzeEg5UXB6UlZZYzVpMXdvTG81?=
 =?utf-8?B?L1lFRVUwN2k5dlcvL1prcnpRVktzaTNJOFNKTUdvVTZVcC9lYmhUVUkrcXg1?=
 =?utf-8?B?T0R6VEQ0YjZEODVpYVF0VFkwRVFvd1dsUC9PTWZrbnMrSDhvUVB3NlhtMWJ5?=
 =?utf-8?B?ZTZ3UFF6c2lwUk9ULy9yQi9ZSldEdHlMbzRVS1NPVHFpb3NOWUhySVJrSDdY?=
 =?utf-8?B?WFJXYXlDcGxzYmlFVW1TcWNscjVjcndkNXpWbXNYSm91SE13dTBrLzBPRVdu?=
 =?utf-8?Q?AQl++E2f0Wurq?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UTRZZ3NOMEgyeWdFSVVMK3VITVdLSEEwRXJZNlhMK3VvQlo5NjhRR0FqbjJW?=
 =?utf-8?B?OEVuMTJQL0FtSUJ5N0YrZGxadnRTK21SdHRWK0hib1c0VXVmZ3MxNWpCcHlB?=
 =?utf-8?B?Q2dqZ3lMWXBXd0RYNTZ3aW03U0hBc1U2VnNZdDJUd3krUkJZRkNpVXpZYXdQ?=
 =?utf-8?B?Y2cvQ25SdVFGVG96Ni9TTXRJV3Z3cDRnaGFuZmZ3SzdQeG52THovcGEyQkVl?=
 =?utf-8?B?YzZpTERuTUpjQjVsOXhNNGRtbDF1VCtzWDBIYmMzcWU2VDZkY2N4VFlNS0xw?=
 =?utf-8?B?TkVJM0pucTlPTmt1ejVmc01zQ3ZNeEx2b3UvOFM4bzJXdGpUclNPUkZLc2oz?=
 =?utf-8?B?eVY3dDVQeHhScDlENVpxY0tGaC9wa2RRbkUwckxQS0xLSXRwNFcwWGdJU2NS?=
 =?utf-8?B?Qk9Lb3YyeEJLQW00Qyt6RGZKRGp2a0hpOUFHclFhSUtCRU8xOTREZEFXOUFh?=
 =?utf-8?B?d1NNRGY3Umh1RWJRa1BnUThsRUtNQ1FaMFJjODRNeFBnYUp5OXVTNDRRWXhP?=
 =?utf-8?B?aGhyYTR1dFVqWjVkRlZIaGI5UWlGL1U3VGdYYkZNc093dVRiUndrZFIxWFFI?=
 =?utf-8?B?TnN3YWs5VC83d21QQzZ5UnkrTFVvRExZL1NCNDc1a05PeVBVZW1GNTNYQzVy?=
 =?utf-8?B?aWdhSlpoQ1NQVDdOeitwT3Z0aGF6cS82eGE3b3NEWjhsdk9Ba1JNaUg0VHNz?=
 =?utf-8?B?eUtlYU4vblZkQmYyOHlHREVwRHA3NStOTkFscXNzMHVRQy9ERnNZSjRtZGVh?=
 =?utf-8?B?b0NXQWhpQ094WHhydm5idEkydERZV3RDNEN3WXVGVFdUL01qU1NLZzBoQTBB?=
 =?utf-8?B?eVNFK3BFSzNOZTNXSHE0STNVckFpVU11VjlrMkhyNDRJWlFyazdYZ3ltcUV6?=
 =?utf-8?B?RHdub2wzVlNsbGpkNm5EMStrMGFweCtqZkcwM2plN2dkd1V0S0wycGwweGx0?=
 =?utf-8?B?MUVBQUtNNFEwTWhXS3BaQ0JWN2lIR1ZoY3liRGQveEwxM3NDelgrbmNyaVc1?=
 =?utf-8?B?NFc0NlRRS0h6KzhXUldXVUtsTmNMVno2a3h3ek0zaXZDeHBhd254MTBiOEl3?=
 =?utf-8?B?NnZhaldDY2JZNnVQUEtKSnZHUmozQUJWNFVWMXpjVThCRTl6R3RqMkxHaUpt?=
 =?utf-8?B?ZW9EcXVZUE5hRE1JY1NiT3FJWGdVRXo2YUhHY2pRYXVGd1lod3hGSGR0a0lv?=
 =?utf-8?B?MnEvd0JGS3E1OGFaU2EwZGw2SmVnSWhFK2ZqKy9YcjZMZ3ZTWVovNmVXa2tH?=
 =?utf-8?B?cW5IS3dRUmd3ejFITkhNV00vWWRGRlBwQU50b25KSjNGWmM3TzZGUXRPWHJ4?=
 =?utf-8?B?Y0s4U1BIMFp0VXNPVnhveVpMTE5iVjVZbXFkdXNYT1JsWFp3a0txSjBlRzlY?=
 =?utf-8?B?cjlISldmVTk1cndSc0pPTzdHWGhnNE90TGJmUG82VmtaTjdSK1c0RFhzS2tO?=
 =?utf-8?B?ZmQ5UVBFakljTjJRZGxuclFSTzIrelVYaXRDK0VobnpFTk9zS25xYmsrVy9u?=
 =?utf-8?B?MkRaS1hJQzBHY21jNkpuM0s2NXZOMk1nY1E0ams3bjMxbUpFcUY5TitWRnBV?=
 =?utf-8?B?LzF3cVNUUndicENPYmtFa0RBYjFCR3RqTXhza2Q0L0hrOWFXMWprMGVybFdR?=
 =?utf-8?B?QXlHbWRrSkdva2c1cFphVkhPcjRNZVRseVNEdHNJbFQwYS80cTFRN3JNOEFy?=
 =?utf-8?B?MWVJRk9jNys3TjRiaDA4SFlHd0RwcW94bTlHWFhNR2NqcnlHT3lGNnc4ejNH?=
 =?utf-8?B?K0Rrd0Z2QndmenNXeFdONU9nZ3BPb0xlbmVmV2cxQ01pSnhUMEMrT3hjSlMx?=
 =?utf-8?B?WHc5K3ZaVmN3am5CNUxpRzRkTTRTcVdqbFp1WVlDMHlsUWE0dVFvVnI2dU9Z?=
 =?utf-8?B?Q1NYMjBOTE1FRWNvNWY4Ny9lT2NKYXRvVlNuYmQ5dFhqMmJnblZxWlhzU1NO?=
 =?utf-8?B?ZTgxTGE2VnZtN0plTlBwRFNTREcwOFV0UFcxQ3hScjBiWnNTTjJ3bk1Ha1Ju?=
 =?utf-8?B?SGxuOTAxL1VteUlLcXA3R05IYjJJMnBZWGs4aHo4UmM4VjBCTCt0SE5qNFpD?=
 =?utf-8?B?RENNL21COEkxSE9vV0FGTnl3RUMrZnJRWnZFSW96SmZNS3I4Y0NSOTRvVDJ0?=
 =?utf-8?B?UUZvUWd3Zi8xZjEvZ1JwbWFBMUEycTlVOENjbVJTTjJTTEdOU2JCRXlhRDhr?=
 =?utf-8?B?RGc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	F7QB/xEsShOj6Jq0T3svlPe3T5xyKMeAfhHMgg7YQX+bHByiiwBK3hBgQMibIa3AXVdKKcQOMlhQNUjG2iHRWI87YycifNbRzcLPKfA9UHunECJj0nR5CyKGrrM7x+21HtSGPHIGxZBrLcE7NLRMFs83LeaQgwFMaw+zBlA6rmtxnXM65oiU8Nq3sDe55lfJ8BYM3H9lPHRoOlUpeWnnK+QZcfOpp71lKB1z/2dIIGeNaEPgUS4yW/WCW1fAyNU85LcfXPEmjv+7PjCK70sId7jWdAINKN/beSHT4tjrj4df4EZRb4bbQqKd+59PW6rB9AuRwEJtDfxaRd1KrAPzh9h06xFC0S1JVylXq+uRlUDfv+LAymj3utkDQ456w5JNEIXjz4W/eouCJrzwtbZEeqDuzoepq3DVF0h9uSE7hrBIX1nBmbUwTRphUgYFYDoPHJhDZN0IF0A+0UzcvrmpoUPG+9rXnakDEFShthHIsTEvyHd7EnrJgMgKgV4PJoVGrxj89JVIdlDN/yjlmCiBrZdiZf+zmzAL1K5VqPO0uLJ4tKXTlXHGsGBOqdjRxyKT1hQmBRg20r2djbsSI94H/S4SZ2hZKBS2n3IbFlVEKhA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af994988-bd75-46c3-141c-08dd3afeb671
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2025 16:06:21.5158
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XLNcVIP3/8i5OBgaPVGbRYSlzEbrGMxYSf9+VW0jA5JXbuS79H7xfX8e9NcIoyV6kid3cUe/J4ymyqig/zA2RQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB7593
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-22_07,2025-01-22_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 phishscore=0
 adultscore=0 bulkscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501220118
X-Proofpoint-GUID: jU_dD6pqs8tzJlImWrj8NSjQ53Rlo894
X-Proofpoint-ORIG-GUID: jU_dD6pqs8tzJlImWrj8NSjQ53Rlo894

On 1/22/25 10:44 AM, Jeff Layton wrote:
> On Wed, 2025-01-22 at 10:20 -0500, Chuck Lever wrote:
>> On 1/22/25 10:10 AM, Jeff Layton wrote:
>>> The v4.0 client always restarts the callback when the connection is shut
>>> down (which is indicated by RPC_SIGNALLED()). The RPC is then requeued
>>> and the result eventually should complete (or be aborted).
>>>
>>> The v4.1 code instead processes the result and only later decides to
>>> restart the call. Even more problematic is the fact that it releases the
>>> slot beforehand. The restarted call may get a new slot, which would
>>> could break DRC handling.
>>
>> "break DRC handling" -- I'd like to understand this.
>>
>> NFSD always sets cachethis to false in CB_SEQUENCE, so there is no DRC
>> for these operations. The only thing the client saves is the slot
>> sequence number IIUC.
>>
>> Is retrying an uncached operation via a different slot a problem?
>>
> 
> Ahh, I missed that we always set cachethis to false. So, there is
> probably now a problem with the DRC after all. Still, I don't see a
> good argument for processing the CB_SEQUENCE result, when we intend to
> retransmit the call anyway.

I expect that the rationale is that the slot sequence number needs to be
advanced appropriately before the slot can be used again.


-- 
Chuck Lever

