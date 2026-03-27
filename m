Return-Path: <linux-nfs+bounces-20457-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OM5bAkiIxmldLgUAu9opvQ
	(envelope-from <linux-nfs+bounces-20457-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Mar 2026 14:38:16 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B0FD34562F
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Mar 2026 14:38:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C1D9F311A16E
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Mar 2026 13:21:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A77103EBF14;
	Fri, 27 Mar 2026 13:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="igDwmfxK";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="vvlZx5Xo"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1605A3093B8;
	Fri, 27 Mar 2026 13:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774617559; cv=fail; b=KoEQk+2edXqK3qXHVJqgCl82iCL1zJV8bq+IaMkrMi0Mz4fBBddAvDIh58eKBwySa2niF7SXB0EzRbDs96CSfQawDJ1ghL/9uKFHGVqU5UvYh60fjTcY2/jTCj+6oqZ0Z5JCfQUlla7pWE20fef513wZZYE/RzKZmP0bU80TA7Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774617559; c=relaxed/simple;
	bh=8c+tzhQ7c3pSfs8wSRuB+PFFSkiSvx28n1VlEtyZ61s=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=eh8GcQgqmm266rFkYKcC1Qbi5FqxHeEuDoV/agTOauIw5CMhB1fKFbmb8eKrADG4socxUy1Aw2vc0jbObgP2AaqAlwf1EfCytm34641DAMCNw+pOW3OHMPGrItHxfC0xdNfz6jn3YNgG4a4J7ToM/cbZfzVMIUzzd/HH4L0aNjo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=igDwmfxK; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=vvlZx5Xo; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62R51NrT2206504;
	Fri, 27 Mar 2026 13:19:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=kUSXc88Leumng6Zaq59M69xxP6yzgpKFlkAMxOXrsTE=; b=
	igDwmfxKQzGpgTU5C0sg4lp1OioXAD/dNfiT0p7YGXemAQLDDxEOkRAYobYY1568
	sY9sQRfXgogCjSceZYMNPvk//wLLr3mikJNDdD6Zl4rwD3c/sJQQDsaHKgQ3cQQ/
	a32RgAjpNMHcznfPnNe15M5zhhWTXqahrVucFzrjfToflbQk2/xkJPPbIDScNuP1
	vEksOKKc/SRSGbTESGePFZuWiKY4ObbAV+PPQ2CeXBuXoQyTwCAtk5kxzJNNi4ZK
	wjTy6xwL7LtB3S8o2XanoeF1K05PRZL358fbKfbgTsnGoe7Ic7Ca9rsgk/bu+8Tm
	0SmPjTx8qV+jAOesJVcygA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4d1kgft1dv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 27 Mar 2026 13:19:14 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 62RC595b000699;
	Fri, 27 Mar 2026 13:19:13 GMT
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11010048.outbound.protection.outlook.com [52.101.85.48])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4d1hsedgr9-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 27 Mar 2026 13:19:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wilJkwRLKN3wdbQcaryqSQ/kfRlnJSSMNLHiuzScYL5oexpVSMn2ilxmGPI2rcSwjxIp2MVT7WpxN8V0AG/jLOP9uP7MbR4Clyt0PLAxwGPH7HSHj2OoW7wf0tU5mriQG8+TEwq/GwFp81vaiFf1P8E8XbTnU6omgZNybQ+gcvlXFzwwZOX3WNE/D/NLWAWTOFXWzNIvzoxAqjFWsGziFdYAZqp19bOfSUeX+1aeeFOP4aWAkniZF1xYEd3W7DKrdsYdXcnYWY7RfS9TL3Ei9CdNACmTNByE0vRaA4TilkjgO881qfJkVbiSTxsbp+6JvrLYx8Ogp4xYvGp1WUWHYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kUSXc88Leumng6Zaq59M69xxP6yzgpKFlkAMxOXrsTE=;
 b=XAyiY8IguOWHU0mnjXKs1/a/IRguAWzDHceKJA4ZsTvlhstRuqbRZn0gOWrYP6gpbjMrHD/5tb4GJ8ZRqSrB1dRpJBL8rIWCj6kNXwgl0yA5E5IeZcwr5YicIeWdM7pYNrle+T8mZ1gDsfR9lgG7VPWkLtLlTS2qXohOaDfOukxzmOOM6mlgKm9ofBKeKZKNHuJMdfLcRUvNu3sXqWu+W1g2Uht9cAC47cqqfOPVX3qKfMHl2LAhHHgzxeScHX1pugL7al0mJeya3RGH9vx/WncwUpZPCUdE+3zbGg77ECghaALeA4nhCGqpnglMyiIGddwqP/tUWebdvjz4jjytWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kUSXc88Leumng6Zaq59M69xxP6yzgpKFlkAMxOXrsTE=;
 b=vvlZx5XoggJ/L1t+Myk+L6pqImzuTcZrfza/Ul4OZBI1dD3eIedKB5wIMM2SJxfPyAqyDM4tH1BypAjlLtF9GlA9wuh5gKzK34Re9Bgn27bMF3WqmeXc5mKCmskgpQNfd61V7fkTqhXV2Dt0TtQqxte5L6OFiKrkK+REVMRqbZo=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by IA1PR10MB7287.namprd10.prod.outlook.com (2603:10b6:208:3fa::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Fri, 27 Mar
 2026 13:19:09 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::4083:91ab:47a4:f244]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::4083:91ab:47a4:f244%4]) with mapi id 15.20.9745.024; Fri, 27 Mar 2026
 13:19:08 +0000
Message-ID: <43921656-e0c3-4b55-ad1f-4965ff40f1f4@oracle.com>
Date: Fri, 27 Mar 2026 09:19:07 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: A comparison of the new nfsd iomodes (and an experimental one)
To: Jeff Layton <jlayton@kernel.org>, Mike Snitzer <snitzer@kernel.org>
Cc: linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
References: <4ebbd194ccfb3bcea6225d926b4c9f339e21c813.camel@kernel.org>
 <d453add6-ed23-4d61-af95-d80133b0e456@oracle.com>
 <33582a86daf135336f6bc0d5260d8de0501abadd.camel@kernel.org>
 <acWbrlvt_dUB9X3R@kernel.org>
 <70e9c23a97d94a3dad5aa7f03f5a22c0950b00bf.camel@kernel.org>
From: Chuck Lever <chuck.lever@oracle.com>
Content-Language: en-US
In-Reply-To: <70e9c23a97d94a3dad5aa7f03f5a22c0950b00bf.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0372.namprd03.prod.outlook.com
 (2603:10b6:610:119::10) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|IA1PR10MB7287:EE_
X-MS-Office365-Filtering-Correlation-Id: c1f47732-a424-48cf-06a1-08de8c036dca
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
 t4kPWqxNfJBa2h69wDCe0ij6WDafESnfWUZvQzp/FH7wCGeUXX6a8PPJVZeXtF8oI1DFuEwNLBGuZx/nrNsxw3kDVLFw4/pb0SwrwsI5vBkkDt5GfVIohlR9pgiLFRmUQSqHR3dA2FErl81pe7slH9kk9GFK2JMPIllBORobJDReBv5TDF64z4/yzDQPrqaq/saRL+wnuqy8M5CB/mt1azMHVhaPKYdhS+bfwOEkNBV2Q+6gBaj9dRjzezwCYBuvDI89xL+nz8ty5L+puUUQSu18mib8iWQx0WSa8TAVV08keqwAhGAttowhNuepXFtOSZmsCaONktK7K8sivx9MpZ6XVhDqM7H916STcHVy/47DaWeGORmZZpeCMkPjbD9z7c8wUjml/2IvRuhLjEvTZIfwlpGJPGdJeE69unoO68MYqJ93czP7aFV2xMfEuOwgwE87uJbSyI8qBDMtaimKVpwFdNic5HBYUdDmgkqkrhJozzJ2AQfHPQ9CKnwMmTHJFXJDa/n3w+3FG6jdb4DYlwkoP6Dwfgwo7hfoXw8MEIxJYmSDisVKB68AtVuiXxbE3Cn2ovYosjJhQHNFnVeRxmaL9hZh4bErdlc0pVZBNzCHyYdaS3fP2ZoNzRXSApeXimMRRgl0mYtuFrUUT3320tbt5JHQ5sB/bZtbygT8d6n0RtNyiM/CN4NeJEjikDS/GtF/ZVRpanJE1kTC47rGJodEZGpfaci/MVSFG0kuj/8=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?bHI2NCtQV0xrU3BuWXR3K1EwRWx6b1VpYkVIeFVjWmYyZXBsa2FzWHV3dUVL?=
 =?utf-8?B?YXpNYTF4c01FMzJlSVRhOGlDZW9hcTAzMWdURy9KVkpqOE9LQnFUOXhTZmJF?=
 =?utf-8?B?bmZYZElPRTdLTVB5Yk41WjRTbnZPYy9lZjU3Q2s4anVFK1M1ejcrdVY4Sm9W?=
 =?utf-8?B?YktPb2ZJTHFCdGRjYStuUE9temY0ZnFkaU96RFhmUWw0Q3FSOTExbSszZU9y?=
 =?utf-8?B?dmRCRERHM3pUaU5jcENZYVVUTWJVWmpBem9iOXpSWXdwZXRFbFcxQzFkb3Jn?=
 =?utf-8?B?QUFKeDdBSDErZGZWellhaWpIT0hmTk5RQlNHNmdrRWhlb0d1N29xcVhiQlF2?=
 =?utf-8?B?aDI0b0d6WFlkcE9NRjZBelZZcGZWaVFucmhya3d4N28xL0oxN2gwY3FKUTZm?=
 =?utf-8?B?NDQ0VlBvejJrZVZZVGY3b0pxSGRyODJ6elhUMjNHWHF4dTRTM0l4RjlCcThX?=
 =?utf-8?B?WWF2WDNhTUVaNmNxbWVLVjI2WFNOaDc4Y0tEcUxTY1pNNzFFeDlOWFJVUG9v?=
 =?utf-8?B?K3cwQ3lMcmlwNG1iUlNGSUR1R0FiWUlWVlNNaFU2SmFXeW94Uys3WlNaSWli?=
 =?utf-8?B?MGFSNEtXUFUyek11cm9jdXgrOGx1dkFVSFlBK2tSUkhTZENRdE5TY1NCTHFH?=
 =?utf-8?B?K0VXbFVBWjNxOWthWDBxN0ZLZ080MEtWWGZOSGZCVHlpbm5GRXBhRnN3SlZ0?=
 =?utf-8?B?VWQ1ZTAwZm5XeVFYeWZnVTVxNXJhVlN2dS9HTmREbE5XZkxkZHBXY3ExZzUv?=
 =?utf-8?B?R0VjOGlDbXhhM2ZCM0VOTEhrTjlkMzJmb2x0UG9TUjdxU0JHUi9yaElzaXpm?=
 =?utf-8?B?SGNrN1FpQS9EeXMrcHdmTTUwdFNEL2dYMVNXSVFHQjBxUnRtZFlGU2lrOFFS?=
 =?utf-8?B?clhkaVIyTVIyenIvQW9tcE8zTFVSaEx0RWZBVDdSb0V4Vzl4YzJRTW5MdGdz?=
 =?utf-8?B?RVVZMXhhMTg1N3NnUmRTcHNmY1BWZGlvaFZwRVRRRkEyTEYzMjc4OEZ2WXZz?=
 =?utf-8?B?cWo1M0t6Y05ndFhUT3FDQURZTDVWRzJ0QUlBVFRQU3NaREd5QmRmQnJ2YnFE?=
 =?utf-8?B?YTFiYnJpdkpkTUw4TWlSWGtxL1hqbnFiS2ZhVi9oL0NRRDlyVDZ0VmQzQ2Rh?=
 =?utf-8?B?dDRjV3R0U0VzMm9FTy9kZFJ2bTEyNE9CM1pBSHI4NnMzUHVLSGpIakRPL3RX?=
 =?utf-8?B?ejdISm5pYmFoa1c2T0xncFFIUExTTlJWOS9CakdSREtZVHZIaHEweTc0UG9u?=
 =?utf-8?B?blo5b0NwQ2RNYVdrcW5ZZXM3cUVRU3VIaDdUSXh4eDNpYllQMVQyYnZZODZI?=
 =?utf-8?B?Y1FIa1pKdzd3Y1d3Q0hvWEtqVjdlQVU2dDQxTmlRb0Z3SjM0ZkNuYUVoMlJV?=
 =?utf-8?B?b0lvemdvZ3BSbVhoNHMvbTJiN3M4amVxMkg3WWpjYzJ5MCtaalBWV21CQXFo?=
 =?utf-8?B?NHA4NThGWGFWYXVMRk1aTFpCNWRFSnJRK25EdnVHUllPTDBPVTA0a2RTcjBG?=
 =?utf-8?B?b0NvNTFFd25LODYrMUtHV0dreVdERnU1YjRvem5uKzJQN3VUQ0FsTXM2MWJT?=
 =?utf-8?B?NUNReC9zRXhRSDhuU2tGK2dEM0pvNmd4aDZVYmxqL3ZqL0xmcmVhNFdIS1U5?=
 =?utf-8?B?VGUzRHJvVUdGT0ZyWVZSNDBYWk1wNTd3QXVDV2hEVUhyU0xXWTNMdit3R3Ri?=
 =?utf-8?B?NmFWL2pURFd0Q0dmZlhZeTNWTnYwU1Z2c2hCZ1h2M29vVXRZZ3NsUjVUVEtB?=
 =?utf-8?B?YThWQjY3LzRoYTBDc1ZpT2VNblBCVVNnZE1mU0N5RHRtM2lUeXN2SnFLdlpB?=
 =?utf-8?B?cm5KODVFRWRKNityTXVrZHFJTUFYcVhkSWRFeEI3NW1GbjQ1S2Z6OEh6RDVU?=
 =?utf-8?B?OGk0eENIMERReG5vSmdwQmlNRlRuclhiVTdoRTJHdDRJYkhPZWhBaitTTEln?=
 =?utf-8?B?TDhselZlWWFTZGh2bWQrbkViVkVJdG1zOEtkRitnMjdScEpRcXQ4K2ZwLy9a?=
 =?utf-8?B?WS81cjFHUzIvZFpiNU1kbnpmRWo3eFRyMkI3V1VtcWd5S0YxK29JR3VxSEtk?=
 =?utf-8?B?TmRldFNWMXYvU3Ewakd3N21hTXIwWm1SZUZLTnVjd0dmV3lDMitvcWxSaXRr?=
 =?utf-8?B?VWxlZy9JSUFmakttT1pnRWV1ckV0SnJLMHlFbUlRRTdzalB1QlQ5bDVobzYz?=
 =?utf-8?B?S1I4Z0xJelM5Z3NyZ2txUENuSGswTWVyNlovK1JtUmszZG4rK2Nsc1ROdk8w?=
 =?utf-8?B?dVh2UXBBb0lkSmhmb3pQNFJsNTJHZHBmc1hUc3FpMktvSkV0ZDlTWVR2a0s3?=
 =?utf-8?B?eEZYLzBqQ05rb2dUdXczUG9LU1c5S1h2aHdqdldNWlV3VEVBZ3M1dz09?=
X-Exchange-RoutingPolicyChecked:
	q5cvC+OiPLSodVbPldkQnxQCr1rLuXvgPrS/5euL+oyd3v8gIpdRoIsXp/s3glifWZwIKCgXM2/vqD0TmgFz9FweEsIcxsnXULm1dUDrrOXGJU+c9p/DgG4SBzJSIVutfesfCXQJjIfCW6LUJoYfBpHeoA57T55GWVVJkzxSt+1bkLA5eUQ290CZG4z9i80R0Jeiwq4RdxyFi1vIgrDl4hQazDi1tKGqR8vaEwMLHFFUZa97hvUVaILt9HhlNmMAGTAPU3dHN86VB3QtszCh+7iV2gOK+sTbeRl/aDBzclEuVb9rrCmzBLhjeML5PAMx84tykTGNMSopAH7pNSWYyg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	x5E4ve2WLBwFmgqHw3T2aVHm8X4z8/HpmNXCZ1x+ilW6t2RuhHNh4XkdDuIYb29ah1IFLJeF/4vEjG27mCSRvDhFRthrG3vNO4Ts1kXmB4+viR0+b7hhYGKe9uuNcW8lBevT83ifU/n/LXD8JVrImHVbQHPf381k5WsVNBSke3kotFg2SSaxupNKWu6bxOCXbtcvw61f6w2PTPCUGcdu7EHE1onHLTVmSR/UaGguScEFT8lTZmIxdpx64tebiPF7r/qUerfcC3pJlmmehSaC+3j4ZIy3jxWGQQTDRRfYYKpz3SKINbT9zjxBPmSLPPG26EeloHz0FdR6HGJqp08EFSuA9pdZIreFvs6/pKwrWXC/nNf+6S+FUsFywLj2C6zfYWBUXEbxNZcsfCLP0PUX8qNpQ93IPKWkemPnkuU6tKey4MdRjIelblMUtfnE1JSoh9ZmDQi2Ije2QJ/xlFkjxuK8yXdFr6xyb7NE+N8uy0fKMpwJ0fLfjW0OELkeFv/3CC+icv2PHt7jE2YJEhBCZe3d2ZZTik5YxhbXpO8vEHFg/Z5z9kBhxF52dAKDD0sW0V/2xs2UzHBoWeMOqmHlA6/0gt0n6L/v1/C0TxjMLU4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1f47732-a424-48cf-06a1-08de8c036dca
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2026 13:19:08.9171
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4B4wLGX1IRjAnbmcyN8ck4nMLPuyz0JJcmQcwqFMpe2gvp36ipKr5mlsM2MUNYbyQK1wIB+7CzYzJLlmnokSog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7287
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-26_04,2026-03-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 mlxscore=0
 suspectscore=0 spamscore=0 malwarescore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2603050001
 definitions=main-2603270091
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI3MDA5MSBTYWx0ZWRfX/mQKk3TPrm7P
 F4wpBORpg0I3Zmqrfg5yMaSX4IEw335FBao1poaNVY7aE9RfKqbWCGPtxHC9MXD4iNuh38+Ngvq
 5rC4XxDdWj1Xk6hnNkQheIU4LfdtW6X5B0jxbpUtljg6tOmy5dUsK4+RwFDV2sIexfmLwuIrdJG
 bBOEF3rRyoQu+vxRChiJgqcwQg+wXPMJx0rkgbbXJmW34flXLaKx2KGx/NdHGFv9h6WJaMBbT8g
 TAI3TH7ArAKU1WomwpwHw2DXlZa+NBKB2FatqF9m7G9C7AxbME4QyDpY3ie869gM+LUICcI7g5n
 KdZymsyv1QjE9q6HgLUSAln9iZRxUQUjEIZ9qJMTRtUXQXeocajOdFBQH/zXj/UfKKB/o9rEpX6
 OyvXcd9axp7mxDLwYUfRH56t7pbbluoJtucCIGeSOFX1mcKYyWPPBpgPsgZjkivEPPYzGIsECEs
 vGqUA6dTVl4Mor+wC+Q==
X-Authority-Analysis: v=2.4 cv=aq+/yCZV c=1 sm=1 tr=0 ts=69c683d2 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=qN8iZ0LCc0IvDgTb:21 a=xqWC_Br6kY4A:10
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=GoEa3M9JfhUA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22 a=3I1J8UUJPc9JN9BFgKH3:22
 a=Fxp-S4dNkIlY4T5cIr4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: rii6xcolFGy3Fdk_qzjKeH85m044lKi7
X-Proofpoint-GUID: rii6xcolFGy3Fdk_qzjKeH85m044lKi7
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20457-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,oracle.onmicrosoft.com:dkim];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[chuck.lever@oracle.com,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 0B0FD34562F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/27/26 7:32 AM, Jeff Layton wrote:
> On Thu, 2026-03-26 at 16:48 -0400, Mike Snitzer wrote:
>
>> Your bandwidth for 1MB sequential IO of 793 MB/s for O_DIRECT and
>> 4,952 MB/s for buffered and dontcache is considerably less than the 72
>> GB/s offered in Jon's testbed.  Your testing isn't exposing the
>> bottlenecks (contention) of the MM subsystem for buffered IO... not
>> yet put my finger on _why_ that is.
> 
> That may very well be, but not everyone has a box as large as the one
> you and Jon were working with.
Right, and this is kind of a blocker for us. Practically speaking, Jon's
results are not reproducible.

It would be immensely helpful if the MM-tipover behavior could be
reproduced on smaller systems. Reduced physical memory size, lower
network and storage speed, and so on, so that Jeff and I can study the
issue on our own systems.


-- 
Chuck Lever

