Return-Path: <linux-nfs+bounces-16054-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 54130C36310
	for <lists+linux-nfs@lfdr.de>; Wed, 05 Nov 2025 15:59:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98B7518C6C09
	for <lists+linux-nfs@lfdr.de>; Wed,  5 Nov 2025 14:59:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA24832D0CB;
	Wed,  5 Nov 2025 14:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="m/hujfl2";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="EdyxrnGy"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22919328B52
	for <linux-nfs@vger.kernel.org>; Wed,  5 Nov 2025 14:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762354726; cv=fail; b=NZr0IXnymdgcST9M6DifT3ZuYlEXaox9SavfO396n6mxAzOKx9TlzUfzTUQHjk/0kEEUx+nd7xaWGZ55fsAaKFfZNJXUudxa5vOexYZWWpQ9YB2xbw2PzVQbBwVHSHElcfrsIEqDYHnTtUA13Eo5MUFT0gmnyRqvAa0YfV6F3KA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762354726; c=relaxed/simple;
	bh=VxA6+NFvnO2Qx+d89e0CJgsCwvQZ0oYrj7kwQPtLipo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=F0sxcKq3jb6oDtT9XnwyWT+itlBjujOIWM4axDRWADWYRsBWWyO+nwlVlTgmBFVXb3trzT1ApweGC1vfH3M9yekRZl+kDH7ldvSawt4/CIva+wnpDsMR2v0Alh00lpxsm+njvvk73pxZUZ5lC+SakiUMAGwSc+fsnYCfVmEVb/Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=m/hujfl2; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=EdyxrnGy; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A5EET01004455;
	Wed, 5 Nov 2025 14:58:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=2c/zY7NdEtus8rEEz1hILHzzh43KUNeeFRNo5n31vU0=; b=
	m/hujfl2WRxlAq7wLpVJW636/WY6/6XJGK/ZpcH9HJhtPgTlWy9k+ClC0etWPXzd
	0twA4XQN/R1bUEdTEwqJV6JRGRodchSivyXk0OH4CZMdoa4SrQUXVtYe8ZwrwKKO
	/yksD8osJ63ZfflohUCYfR5z7YI06D/St0BYs+CYNYR8OUH3FeCbpxSe9fGBpyVg
	YR0RgE7uTUkIkr2m44yDL5iNoJRVl4JjjH7nGltBATIqSlk8dT/tzcyeHzPBxTut
	MXYaAq8Oxq9P3mzc7BOQyUvnYRREN54LFsaqNpnj2jZGIHtJa6xaGtT7CAPf02q6
	QsaU5bUd7RuUSeXHY+ys9Q==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a885wr3r9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 05 Nov 2025 14:58:42 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5A5EhlGg010788;
	Wed, 5 Nov 2025 14:58:42 GMT
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011013.outbound.protection.outlook.com [40.107.208.13])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a58nb343w-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 05 Nov 2025 14:58:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TkFa7cP/4v3XtyGUoAMOgFlFueRaLqp6uPk2C4ssXFS3bQzRCP4hE7LRcoL+ueGJ7BrCx0RozX40z7vyMhPm+k8xLR/uSUMcZfRmTl/xfAFafxviB2xd8OOYqSl8TlaADQwsZooly/g//6/6jhJaBvJwVlSUh8JdeiOvwsg7moYw/ma9L1NkpGblNGDFJIMcMLiDF7MIBQRIk87oKXPbTVnb5TOG35Lig26/qDRr4TIc/xYDl2wJ3jDlA45Xgjqx0/qIR/y2Y14ROJ4THZLh7TOg7Z5kF9iS3PH/Czqd202FbUf73fJkvw0AE+i77ehEBCrzVf6TakhiFj9vFey90g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2c/zY7NdEtus8rEEz1hILHzzh43KUNeeFRNo5n31vU0=;
 b=ZYtLRf10+VjdUbqr7jIlz00cRZ19GKKVptZAR2uO98qadUfzWLLLOji2yElGTZCcmESy6SIn6T/s8MfQED+Tyeo+1NdXIstNydNde5hCdIQ3KmHK8e/ym+eInw/lyLoQOqx/6vRwzyYLx4olNZnt/sHz4En8GCE8g5RE0af992icOL/+cb76EJw2YvdCRv0b0SYqinuot2pMHkRxjfgbaCP3JLMUlx8iW5uC4P5/ULbY4FSC19MNOvHQsbyOsOj+y/Pi0HofUWePiQsFN68AZ/nk1+vbAoHrH5A0cWHztebMJkhruPEp3lsPOBWU0UDqFrZjBaKomMAlbBx4MJFNrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2c/zY7NdEtus8rEEz1hILHzzh43KUNeeFRNo5n31vU0=;
 b=EdyxrnGyYdjbO4QSSPphUm4WAl/ZDikaR8+32btBxmBDwV26oyoru2c0n5kYueHwrA0oRH+Lw07LGV24iTnZzOhVt4zvTcpwhU2TAPcp984X6o0+9q3vEv14P5qLeQYypytpSvMzEitlh2Bu4WCSSfY6Zgox8ThFrw+KqR/H7gE=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SJ5PPF2BE4E177D.namprd10.prod.outlook.com (2603:10b6:a0f:fc02::798) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Wed, 5 Nov
 2025 14:58:30 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.9253.017; Wed, 5 Nov 2025
 14:58:30 +0000
Message-ID: <d2139ff7-58d7-4b49-8ebd-b30d6ba4c9e8@oracle.com>
Date: Wed, 5 Nov 2025 09:58:28 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] NFSD: avoid DONTCACHE for misaligned ends of
 misaligned DIO WRITE
To: Mike Snitzer <snitzer@kernel.org>, Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org
References: <20251104164229.43259-1-snitzer@kernel.org>
 <20251104164229.43259-2-snitzer@kernel.org> <aQrsWnHK1ny3Md9g@kernel.org>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <aQrsWnHK1ny3Md9g@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0P223CA0016.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:610:116::34) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SJ5PPF2BE4E177D:EE_
X-MS-Office365-Filtering-Correlation-Id: 4099e386-73be-41f4-c2b5-08de1c7bc85f
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?L1U0ZHdnRzhiL0dLWTJhQTFwQ05GeGxFMEZVT21pRFBBZGh0VVZubmJvZ3c3?=
 =?utf-8?B?OFVxQjZuZWNkeUpvQnF2L055NGtscEtFZStpUy9WRlBCWjZwT2xTUFBpdUhW?=
 =?utf-8?B?cG50WDNWOFNzNlY0T2hrd2kyOFNnUlJicG54VGpGSGUzR2hybWgydWxoeU1M?=
 =?utf-8?B?OU02dlNHRkI3cHE3WkRuM0ZSdFdGY0ViNFN4dVNWWlBQeDZJVTlSaHRJM042?=
 =?utf-8?B?VWpYVmZMUW16UVljckhZRGZ6cnNUWHBxeVkxMUZNVytXcjRjWHE1alFxT0dt?=
 =?utf-8?B?MzVTcFZ0SGFoZ2UzVzhYRmt3NVYvNnArVWR5bGRTdlkxU0RYLy9jY0gvKzhO?=
 =?utf-8?B?cXlCcnFLQjI2cFQ1Ull0aUVWZk85WG5SZHNKdXpZTDNOVDZmajk3Y3FLSEJB?=
 =?utf-8?B?STFZbkEyNDA4VjFhSDh0d3MrSlA3VjdiS3RTSStxSTVwcGRFRS9xZmwyOU1F?=
 =?utf-8?B?RUpEUEJTSkxGOEk0RGVUTVp2RHNBOEhlSmM1Z3Z2R3V5TDByVXZPMDg5YXN2?=
 =?utf-8?B?ZUhMK01SekxUUnJMUitLRUoyczRQaEtWTUxIY0F2bWxhQ2NVT2lrbmdiazht?=
 =?utf-8?B?ajF0U3FtTVlYUmVRbGV0SWowbHB0aDcrNzJOdFF3Nkp6ZURicGVVLzE5eTlk?=
 =?utf-8?B?RXQzSDIyMkV5MGhJS2NiSC9LL3BsUm9VRm9ZZ0lSaE9xT2Q1UU96T2pLcjI2?=
 =?utf-8?B?cXpPSGRqaTFGREQ5K3lEcG9HUE9XNEtIZWNJSjY5bDZkcVNIU0lGQXdLQmph?=
 =?utf-8?B?b1NURyszeGxnc0QxelIrOG82UGxhRnBGK3d5VjV0UEQ5U1pJUGhWandYUGxG?=
 =?utf-8?B?cmhjcFNMRWoySEpLd0s2d0VBMnZmdHQvK0E1WkZrdjlqb0NIZ1Y5QXpYZFpE?=
 =?utf-8?B?TzlsUHgrYmJUVVhUZ3V2RWdjbFQ3dVlQRkRabmY4eThjcVJDS0JZUnNqK1hN?=
 =?utf-8?B?Tkw1ejdzdFFya2lCLzJ0MVVTcTk2eDRpV2VQQUhjeHFlR2lOYnpSQzZ4am1m?=
 =?utf-8?B?R0dyK2FWeWZmV0JSQWZqL1Y3RCs0SGdadnFVeVhaN2VQckRLODlDVGJSUTln?=
 =?utf-8?B?all3STBweHlhcWwzTmdGNnY5ZVBmbVJEUzNmcGJULys0V3ZvNTl2US96Z0lx?=
 =?utf-8?B?MzlmWWxrV1lERXBPRGQwRkNweFlDY0ZTV0RFYXpZamY1d09Ub3hVSFhHTWc4?=
 =?utf-8?B?d3RrdTZYL0JGakdJeElLS1F5Mko4UlF0c1k3TTlVbklxU2lMems4TW8wQTRM?=
 =?utf-8?B?ak12enc5YkI1S1JOY2lvL1cwYU5HaFM1QTV1Z0NNaEVFL1QwNVpNaU5BN3Fu?=
 =?utf-8?B?aVk1cXJrQXdjYUg2WFVxOFBrUGNvV2VPbTNkQWlIUWNCRmxGZVJrOG1BMHV4?=
 =?utf-8?B?blVNaVE4aU12SEEzcHFnSnBjOVkvN2NsSkdNQm5ndm45eTcvUTlLWEFUREtD?=
 =?utf-8?B?OGFYMWNuY1ZXSWxjOGpNcnpmdkcrNnhWZ29rKzRCa2tKTXlIWWlRSS9GKzlD?=
 =?utf-8?B?OFBCb2xDWnV6eElFaWdyQ2l2K1Y0QXA5M2hXdWc0WmlhcVBJWm90VzhHTW52?=
 =?utf-8?B?SzByMU1NenppV3JHR3Jma21YMk8rQmk0dk9jalZSelBpeFZxcGh3QXc4RDZa?=
 =?utf-8?B?QWhpV2xGMmY3REROMlluWGxzOEZkTUc5ZnF3blhGRDJEV2tjbXIzMnozSjZN?=
 =?utf-8?B?SDFwZHhSVFVnRFVxUGxoZlZoQVhGUm1uRW1wcVhCbmlWeU4vOXVaVngvYjli?=
 =?utf-8?B?RFkwRjRVbFhvUzhrSDFkSm1VbVhDN1NHQzJRYVNMVTUrTmlSOEhGRlF2SEJD?=
 =?utf-8?B?N1hhWFcxa3ZnNXlsNnJCR28wUzRzcHlqWG1zTnA2cG1KcTZTTE43Z2NZMTAr?=
 =?utf-8?B?SlVEcVBBUDR2eVJWTGllakNLZ0YyV1lUN0VTdjd1dVpVQUZiOTJGQXdiVVRs?=
 =?utf-8?Q?rP/nVfpuFLlTziRWDEF2tRJgkA1G6tVM?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?d0RpQkpMQ2kyMTRrQ0ZoLzdtR3FkaVBJWG9TSjFPS01ERmhSZVNScHFldW9w?=
 =?utf-8?B?YzdFN2EzYkFtSU9JY1EwM2d2OURsVWE3cXNIN3hkRGxWb0I4bUtaMXduQlFU?=
 =?utf-8?B?bkc0cnZsOGJKTzIvaWlFMTZMOFBaRnJDajByUkk2aTVtTlpDSTZhbTFxUisr?=
 =?utf-8?B?ZzBSeFFJOWpIc1dzaTBsUWtZbEI3RWR4bUZvd0k1NVpFMmhjODdhZGhQVVZY?=
 =?utf-8?B?VWwzdVVsNWFWd1VNaTJGMGI0c09pWUVtWlRadjZmdSttYnBQK0lzK1JmdXpi?=
 =?utf-8?B?QU5NS3Uzalh1c2ZqUWdSUUEvQnl0bnJWMFpndlFNYWMrcmtadnpJRUtuMUFB?=
 =?utf-8?B?VC9oRjdzRXdlQXFSMEc1djBGd3Fsc3FCQTIxMEw5ZUxOamlnR0RWSkxuN0dq?=
 =?utf-8?B?a09xcDFldXZyWHF0Y1JCc0M3TEYvUGZrNXdib1RvYzZpM0UxY3d0dWdrdUJa?=
 =?utf-8?B?azQwVkordC9SQno1VUhlVEFSNm51ZjJQdW5JRm4xTTRLOTUrQ21FUVVMV2NR?=
 =?utf-8?B?ZExhYThzMzdHUUxNM2RTaTdHeHR3YnM5eVNzUVE1RGNrRXU0U054NTNKYUtS?=
 =?utf-8?B?Wnh0SStjZmEyeU9HMzhTZkhYTjFBSjVoMndLQWZDRHhwY2t5TWJYSFFTc0VO?=
 =?utf-8?B?TGlZRXhPdDNlaWk0VlQwOGRvek10cVV2UEUxU1VNeTQrcDJuaGJQOEh2cEtx?=
 =?utf-8?B?aEovZmdaQldGQldBSE95Vmt0QW4yKytmc3lXZ3lXSEZJZjZobnlZdTFERVV2?=
 =?utf-8?B?VDdoMzZubFN2Y2JFTlIxSnZickkzSG5jaFoxcG9SN2ltLzdNeFRGUEJWbFJ3?=
 =?utf-8?B?MUFScC9lMThCRG1OUXFtL1JEdDl6enRYUWUwb3BEUjErL1ZhbGFTWG02Ryt0?=
 =?utf-8?B?aWtnQVN1ejBVK1pSN2QybUJFdkZ6K0IvKzVQY0Q1ZC94V2x3MHM2ZWRhTkZJ?=
 =?utf-8?B?ZUNYUE1UTlU2QnIxaUdOd2szSGlIL3lRUHJXSnFxMllFN3FyUzNMeS84cWpt?=
 =?utf-8?B?aG9VRkQ4UEc2RHMrcVJERDFKVkRneHpJRjZITzlKMmtjdVlBR2ttT1ovaEpa?=
 =?utf-8?B?Yyt0czJ0TE5CU0s2UmZCdWhMaHMrbGVHbWhRUUo0VTNQZnU0WTQ3VkZ6bHdB?=
 =?utf-8?B?ckJTYW16NDNrOUhNVi80enk5blBpVDM4SGVuTW1XbFdRTkFGNXZBeEpkTTdj?=
 =?utf-8?B?UmhCVWEweE5QQXM2dW8zUllxWlRvcXBXeG8xWUtvZGVvM0ZDUVQ5V0RpQy9W?=
 =?utf-8?B?SVAxRm40SXFBZGhjMGZPQ2pvTWlUR1lpVDVTU3VnaTY4MVZZMThKOUE5RlNK?=
 =?utf-8?B?YTFIVTIzaUVJNHpJSHJ4UWlGZGJtUDllOTNmZE43SzVjbXFEK1dYZ0RMWmJB?=
 =?utf-8?B?dUZYN0VXcjE2T1dSeU1vNjZBMCs4UC9HdVVtYVppUmRFSiswNkhrcm1tMHhR?=
 =?utf-8?B?M25yM1kyV3l3bEVHcDUvZXJhUVpoaFd0WjRjVzQ4YjNJNEdDbXVCTFEzK3J5?=
 =?utf-8?B?MGhTWHlBbzdrb2drL3hJTzArYUhjTnQwM0pBVllvNStrbkZRa0Z0ZHQwYVhr?=
 =?utf-8?B?Y0t3STNuTHlqRXM1NzJuV3Q2U1Z0bm1EQWM0TFV3TGYzYXQwUDRySDJ2MGww?=
 =?utf-8?B?Ry9tOVFMU3FPMGRsYUMwTlUrcGRnZlRQWTIxWWU1OFRrTE1LY044aExjeHBU?=
 =?utf-8?B?Ty9LS3dPOUVtMk9uNjluZEtsZFlVdHhDeG15b2RyOWFaczgxdEtLb1ZlRHlQ?=
 =?utf-8?B?ZlRuQ0RqQU83UzQ5T2RXMUNQTGl2aHl3dUh4ejNCbndlUGd1cFZNVno2WGVx?=
 =?utf-8?B?a2oxdkg3SkZGZVZtcjRqdU1nWEUrK0lHTUVzV0xyYkIveVFFU0R5dVRTbnBD?=
 =?utf-8?B?dkk5VVNxWjNHK0VrN1g4TGN0RGFTczluZkFETFh4UkpJQWMrTFNBbm5wUXRD?=
 =?utf-8?B?UVp4OHVhVUl5VG4ycG1TQUV5WnkxRU9qcFlZV0ZvclQ1dm1KSVlwQzRtYzZm?=
 =?utf-8?B?aDNrcnJ1aHZ5bnNEa1c1NUJzbEV0SFJoYnI3NE9uQ1p2cnNRZmF2ZmhFM2N3?=
 =?utf-8?B?d2lLR213YzJacW55cjYzajY3NjdqQXE0NitvYjRPa2JBbXplZjR0bHFyK3Y1?=
 =?utf-8?Q?m+JGBfIVg+Ih0TW6ZFdEue6vM?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	0zSOzeXDX0WY7aFiyxIm74tlpCr4ISe9/MFoK3DbfPymoaBqPhAklWJMGtttCOLL7vArr9s1l6rZul03XHbqVNlbhkcongm1LI8dQ5TKSHNVvSsllRaHGf/ROGITQwsSWEk7TRzT8hN1QMTvq9J2CgStK5ifjhknuVMesD8M8WAxLLx14PE1w7jR92UUbG5IZDdO+vD9ViTBCBGc0gCw4Sjh9Q9BnX9DjUdcXsG9Bo3QtGsU6yFDcxD8McMd4yIOzcNNtg3Ob/Sp3YvIvtzIMYsae9O1hrrX2ZFzYJFGtZJLCF+o2QOY2RGPpYwASljtG1pE7msX7hKXMDHB0I8dg/hRsbgimcG/n6J2FFEODMus+W7cFiRUUONf+/nbS3nd+iwsGOqp3MbS2+g7NzmiNvD5qNLFNgVe5inQSUTS7kjhJVo/qNq2Ht0vGsD9kAiuS/dV4ZrSOfqgDqdua35jh1DVvdad91W0brAJPiHwqgpCv4sF3z/Rk7Ushp3tjTG4Vwm10VzQ/uhhjakxUQcU8xnjJouwg8sI/Njfj/PM24rxvNyoLyrBieQMe25eb1TB94+VPo53ZPwHlsbG1HRtlzNYPyKjSAoCABuUAG64L5U=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4099e386-73be-41f4-c2b5-08de1c7bc85f
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2025 14:58:30.2559
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JwRY3Ror5QBOwpW9U8bwUu7DYk0Q8hKtBNhTY8GbYwf6GObexDi9q+RuZBOIoFVcEU95nHxYnZFKd+p28CYBVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF2BE4E177D
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-05_05,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 malwarescore=0
 spamscore=0 suspectscore=0 mlxscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511050114
X-Authority-Analysis: v=2.4 cv=W+81lBWk c=1 sm=1 tr=0 ts=690b6622 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=HHK4trI4Z7cApSl2X4UA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: _aIrh1EwlB4bWNjFeRYrjw6zz0HEjRPg
X-Proofpoint-ORIG-GUID: _aIrh1EwlB4bWNjFeRYrjw6zz0HEjRPg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA1MDEwOCBTYWx0ZWRfXzNQbe6ywIwXi
 +Qu2jOw+YJzbJRWcTeZCUfYetaK0JalBm36af0MZOOs5pJdy15mYyLizYit4SjvjUE6pQsZBJC/
 cvz0vuKc1zV0sAPbvnCTeyGvML8Zd3HfrPQChuaFWi0CLHDbq+cV/DkvfEx6uNcsWNQGqxI/9H2
 l0Fno1org+5BocPIrzOg1rNOn4dfqX0lVn36d6oR+ZnGmh9VxGZ3EC80/WdFieeN5ZjvdNGFldg
 Jrsua4d+YRpkbZhB+Suf8qX5DaTKTT6mlhd5uBZKwcMZm1cOMY10ZHoH4xLHS7GQWSQfSHLjGYr
 E3JmiPMke6Itp3mqY2TqynxaFjDCfdQWdJ/JyBHteiMMgc+pNCngqBwbAlYo7Y+XLdozQaS+4sD
 CoRAHO4XMW4+qwyzTNQG2c+K0Atc6w==

On 11/5/25 1:19 AM, Mike Snitzer wrote:
> NFSD_IO_DIRECT can easily improve streaming misaligned WRITE
> performance if it uses buffered IO (without DONTCACHE) for the
> misaligned end segment(s) and O_DIRECT for the aligned middle
> segment's IO.
> 
> On one capable testbed, this commit improved streaming 47008 byte
> write performance from 0.3433 GB/s to 1.26 GB/s.
> 
> Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> ---
>  fs/nfsd/vfs.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> v3: drop unrelated change to avoid DONTCACHE if READ is less than 32K

The direct code path now handles the "no support for direct I/O" case
in exactly one spot: the "no_dio" label in nfsd_write_dio_iters_init().

So it seems to me that it would be slightly friendlier overall to not
set DONTCACHE in nfsd_direct_write(), but then set it just after the
"no_dio" label. The nf pointer is available in the nfsd_write_dio_args
structure.


> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index 701dd261c252..075d7162eb2e 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -1347,6 +1347,14 @@ nfsd_write_dio_iters_init(struct bio_vec *bvec, unsigned int nvecs,
>  		++args->nsegs;
>  	}
>  
> +	/*
> +	 * Don't use IOCB_DONTCACHE if misaligned DIO (args->nsegs > 1),
> +	 * because IO for misaligned segments can benefit from the page
> +	 * cache (e.g. when handling streaming misaligned IO).
> +	 */
> +	if (args->nsegs > 1 && (args->flags_buffered & IOCB_DONTCACHE))
> +		args->flags_buffered &= ~IOCB_DONTCACHE;
> +
>  	return;
>  
>  no_dio:
> @@ -1400,7 +1408,7 @@ nfsd_direct_write(struct svc_rqst *rqstp, struct svc_fh *fhp,
>  
>  	/*
>  	 * IOCB_DONTCACHE preserves the intent of NFSD_IO_DIRECT when
> -	 * writing unaligned segments or handling fallback I/O.
> +	 * falling back to buffered IO if entire WRITE is unaligned.
>  	 */
>  	args.flags_buffered = kiocb->ki_flags;
>  	if (args.nf->nf_file->f_op->fop_flags & FOP_DONTCACHE)


-- 
Chuck Lever

