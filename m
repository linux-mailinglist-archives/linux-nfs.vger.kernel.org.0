Return-Path: <linux-nfs+bounces-16156-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B9129C3D5FE
	for <lists+linux-nfs@lfdr.de>; Thu, 06 Nov 2025 21:35:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B0B194E5FD2
	for <lists+linux-nfs@lfdr.de>; Thu,  6 Nov 2025 20:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90BF227F171;
	Thu,  6 Nov 2025 20:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="iebGObUT";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="fyuWVz0X"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9BE852F88
	for <linux-nfs@vger.kernel.org>; Thu,  6 Nov 2025 20:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762461340; cv=fail; b=LwsI0QTmbSAKv+tQMxW94H5uxLSLz5oPaRRS72AD+to16MYw4SCnfspopyybIas4Fpkm0uxyTAX0Wq3n72Ap7ztnA8xjNWY1T6NwtIWdbcj+g4kYndblP+1VXHiyyyWOeA3THbzYgP2+S1F9bFrjN7vFG0xzYRyQQepu4bApjgo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762461340; c=relaxed/simple;
	bh=8EPPiBId8IONNnH7B43nDDwFHLxPwOosu2KJ4cRxIWc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XokmVvtdDMjWUHS5UPZ4PDmaFC+EiYxdbgTZqa3EmrmbOt54kwsbSdlengJalCffCgdsN7/3C6XuZUr+2fQoAHCagELH85tJTZnMd5rVv9FXs9nNyzYimBAdWAv21tkkScF9uRh0aVV57KTFgzjvEpJM+F5OBSIN0JDjOV2yots=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=iebGObUT; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=fyuWVz0X; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A6IgNbZ000529;
	Thu, 6 Nov 2025 20:35:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=C3TQeuWTAhz8/S1gpfCsJf6pA691UH5bC1IVCRs1PzY=; b=
	iebGObUTJpb0NEHGbQZuffIdsYBclq1uYe8L9vkAS0ctPV8uJJezZGMDX4XI4ePi
	Vif8/iJlkBq9+Fi8BSnrswF7BtcKW0mzWKk6P9XaexZrHq0IUNjBVH4riick9jtj
	kRoTEMW0NuozhcVQsOW0zhJgDRBE2bkabJktJqHfPKeiMVlXugAz8mpiWE0IIc7n
	4+SrqWcet126W+JkMnPJ1ZzkSbq7Kra/h0/WdN6oBaqNH/zHKffFB1D/l4Uy7l/1
	m66OqImPovyQk2t5l8QJR9Z3DlJRJ6JgKhci9sopFWd36iLItXOApgmBKJvAm4R4
	1qSOTlcwwR1h435VNf+U7w==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a8yprgeyr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 06 Nov 2025 20:35:35 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5A6JWU9n039499;
	Thu, 6 Nov 2025 20:35:34 GMT
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010050.outbound.protection.outlook.com [52.101.193.50])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a58ncndt1-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 06 Nov 2025 20:35:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LYsznliMOiB4kJZtHeK0YD2DRgua8URqfyFeXdtg/ZKz34SJGVawsY/j9OoOpLyaTb9hvdBtq3vX4mrlHb0YZHK7lYe38Bi/F5DyXULvwSr09XRiTOkNP3aGNy+7SZ1PUKropsmbu7zfxb7soppIMEf6Tf2OTifCLOC/df2ixoagkZWP0ZPX6kVdNt2hF20WRzeFMLEoQvcRLRFFy6/IL30k1TMFmqZ98aOyFKCD2u8A/biDUBsOTgb7bmo/S2h0X0djC8ivMrLyJk1liHOU+wwvtOeVDx5A8QT+JNoyDEFDW9Zrc5QA8u4jCcZyHr4Zu/HMcb5MrSsajxZzh7tFWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C3TQeuWTAhz8/S1gpfCsJf6pA691UH5bC1IVCRs1PzY=;
 b=mrEDs3R84ibHXVeHDngnoxQySZBJBYzKNn+C6iTFL4oeMVuEtgLy1UcS5mZeL11IYODxYx+iSy7VBx1nQZVbus/x+Uyt7438jFyZrvOCZ6O0gp5Nrwh2kBLy/W5aIlJ0y1v0jdVgtC5DaXpMmFibILC7ovDSeDaIey8MsZXDNyFI6keXtYJU+VBlBp+UjUgdy0eZkw+CH3tViGjKK6gAvhVviMnk6kIiXkXw7JrasCpvAVJxm8EXHigvLUAEfklftETWy9gGjNQ2DuNeIZWOIIk1NCZU6IDp4m0jNwETATkBCKwwZnYzbpK6FU32Mhd0Ex1fqXshj4hCBKNi97UvMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C3TQeuWTAhz8/S1gpfCsJf6pA691UH5bC1IVCRs1PzY=;
 b=fyuWVz0XX6FMjBtb0YwAHPw/jlBDIHIuHl6DVqYN1WSBj2V94XOWtnUM5AJPGjhHplRSrypZUZ/3CNUJpNgHXS5wSbpyesFvGqYZfCAKBehOsHm3zukOPe2VJWPqwvJzOzmbH3SEtayrHwrUxnTaENXvVB/BULDPqB+usY/jBIE=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH0PR10MB5626.namprd10.prod.outlook.com (2603:10b6:510:f9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.8; Thu, 6 Nov
 2025 20:35:31 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.9253.017; Thu, 6 Nov 2025
 20:35:31 +0000
Message-ID: <7d9bcc0c-d997-4fb9-aa0c-831b8f08a9b0@oracle.com>
Date: Thu, 6 Nov 2025 15:35:29 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/3] NFSD: add new NFSD_IO_DIRECT variants that may
 override stable_how
To: Mike Snitzer <snitzer@kernel.org>
Cc: Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org
References: <20251105174210.54023-1-snitzer@kernel.org>
 <20251105174210.54023-3-snitzer@kernel.org>
 <c1f4d144-826e-4c27-821c-47652a7b67d2@oracle.com>
 <aQ0CUPcYYg6-5IJ1@kernel.org>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <aQ0CUPcYYg6-5IJ1@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR18CA0041.namprd18.prod.outlook.com
 (2603:10b6:610:55::21) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|PH0PR10MB5626:EE_
X-MS-Office365-Filtering-Correlation-Id: ffbc5f43-b587-4a7c-dcd5-08de1d740757
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?ZmxReVBLU3p3dFcwN2Z5MGRTZUJhUTUreEptUUsyRGtrT1p4UnMyUUNXRzNE?=
 =?utf-8?B?d3laRjlKMnE1bUpJVTNWMCtMbHB5RnJRbUpUOFYrbDZoZ3VpVUJSQVpFUUVJ?=
 =?utf-8?B?R0tCWkU0b0c1MnNqTlZoenorMmI5NTBoUFhaT2NTL2pMcHZWOHJEK0txSDhr?=
 =?utf-8?B?eW00Y2MrY0s2MFBGL1lDOXhzUll1ZnJuZmcyQjFFdFl2WmdPTEVlY3E1dnd4?=
 =?utf-8?B?QzNFNVhFY1p2S25kUGM2d0R6N0FGTkJqTWFwVGE1L1FPbW45L21OTllZamUy?=
 =?utf-8?B?T2RJME1iY2xBcWFpdDBDUlhyVmZTT2NMbFQzQ0phaFFRZlpqcFI1VlRGVGFI?=
 =?utf-8?B?U0VEQi9Ebk1TVEx5T0V3akZRdmVySGc0bG02elNxZWFWMDhURW13RFpEb1JL?=
 =?utf-8?B?RzZOd0dVZ1RXRVlHVThxRFhGZTJiVDA1VEF3citXUFUrSG5UMzFiNmRTMDZi?=
 =?utf-8?B?NXJSMGlDSEROSFU0aHYrRXVWS0tGNTZQeS9wSnkwcGhIb0dQSWlPaDdtNDBI?=
 =?utf-8?B?blVPK2xEZDA1eUd4a28zdHB5TzRWMk9wWjZOeEovRTBNdE43WUtsQ1lBblVM?=
 =?utf-8?B?RVFNTDQyQmIvZEhxMk9VK2U4QS9MclBkd0VQUWtqTDdmaDhQRzYybFd6K0VS?=
 =?utf-8?B?T0VvNndpOHN4SGZRY3FZRWk3QklnRHZsQ2JDZTBuTWZwZzlGNWlRVExNd05o?=
 =?utf-8?B?RnplSE1BNHRsV1FNQ1ZQbDdZVW9PR1d4Ymh2TWg3dVlCQmV5d2lRYW53YjlY?=
 =?utf-8?B?azltWGg1ZGFkc3dYb01lQ1JDc3h3cGg3QzBNSFNVOUhCMHR6WnR3blJvWXFr?=
 =?utf-8?B?RnpkSTFjOXh0Zk5vN0hJcnlBNm1oczZoZ0dyQjg3cHFxYzkzR1JSQ3hyODNx?=
 =?utf-8?B?cDJOYTVwZWlRQkVCWUJrYzJ5SmI3QzF3UGJRSG8vWjQwSG1DdVo0WG9Bb0I4?=
 =?utf-8?B?ZkhHR2kxbzU1TWZGcTZQNnVJdFNmakRlejZvSWdJTERVZlpTRXh6aHNza2Zx?=
 =?utf-8?B?SkFYMWNmUk5qOXBxanRObGVvRjB6cnUzY2pQb010YzJMS0xyc2RYRlNEQWNK?=
 =?utf-8?B?UEN6dGlRbUFkWlFOTHYreWFXUkJFZTlqV0RCZ0gwd0NoTFBiT0xPbmZiSUpU?=
 =?utf-8?B?UkI4QmdnUzNJS2lJYi8zSEs4MWpia0hZdHZ3Y0ZndFR0YkhZMFhrMHVjeWFk?=
 =?utf-8?B?T0hNREhHR290SVlQZHVJNk01SnhMNmJuNkVQS3p0aVp6TElwSFlCKytmQzZF?=
 =?utf-8?B?M3hSVE9BamRrb2ExTnhoQ3JXVS9qMkpOSmtEcFByTWlVVXNLenFib09uRG15?=
 =?utf-8?B?TzBvdG9BaVNlcUtaZ1IxM2JXMExLYTgxMHNzekExQVhZZSt5T2FOc3BndFAw?=
 =?utf-8?B?VDBxVS9mNWpETlF5SGFCYzlEZXlaTGtkMFpFQzdkcEx3SEEvSEVTS3hyaEIr?=
 =?utf-8?B?VUhyQjltQ0lNM2VxcTl5VEZtTWZmWjQvMzZDQU9IQWJqNWRUMFR4YlJCc3FW?=
 =?utf-8?B?eG56ZUhiNVlTUlZieUswMUhwRUdlRjRtS0Rud1pEQ3RDbGpIcFIxRWZxdmZ2?=
 =?utf-8?B?Z3ZYTU5rVHBLNkJ1cDdZaktPNW9aYkFMYlVncHpFaDFjRHdkcDJ5aWJCZEQ4?=
 =?utf-8?B?TU5ULzRlSkFIaHBrS2dXTm1MQ3lKS0FpRE9SYkxiVUpLZk5TckFmNHh4TG15?=
 =?utf-8?B?NGpqUkJRMzFPVHhleHhlcFJHRkRneDZTcjFZUktqdUxpNFpwWkY3aUVNMHB5?=
 =?utf-8?B?bmVjbG1OVUJ6L25wbzZISUpFQWcvVURReTFhY2RUUDV3Rm1yRk9XWm9NN04v?=
 =?utf-8?B?QzBoeU9hNENlVHNaVnM1RFVrblBVaUZpdXcreEgycVNFeUtlQTdiMDVXdXlv?=
 =?utf-8?B?a0hNaTh5Ky84eGVHRXhBOEpSbXA3YXl3dFNxYkVkNGt6d0ljdThOUWkyUnFZ?=
 =?utf-8?Q?N5QYxtoSaC11BMu8JTUkKd99RyD+mbdb?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?MXRwVDhnbkhrM2xKUXNPUXYyaHF5cVhZRjFzc3F5NVgvNlJxVTd2WVRmaGh3?=
 =?utf-8?B?ZERrSmJLell3cE8rcENndUdHYjcwT2xmQjE1R1lqS284RWNNemtndUhOZXRB?=
 =?utf-8?B?ZEF5ckRiSWh6MmphR0VobXZjNld4M3h1cHFGOUtWS3Q4TEVqVlVIa0xFb2Q4?=
 =?utf-8?B?aGVUc3ErR2pQV0hvQmJMMmlDVVJCbzEwYWFyeVZlM1pta2xVVmRaNmo4QXlv?=
 =?utf-8?B?Q2E1L1hPUitJSytHK0s0UjlsZTBEMWI4OWpPYlFhbFI0SzdPbFVON0ZKaUhR?=
 =?utf-8?B?WTBHUy9VRnZmVHlycFUrSTNwYUJ2ZVJBYzh4WEs3Qm9aWVdGMTY0NkZXelZz?=
 =?utf-8?B?SUJIajBoSTBWN2NLbkdKK0pVTlRPdGdQMzNxN3V0Mkdqc095RGdQY2tlT290?=
 =?utf-8?B?eG1KZmpJZnRhd2lhNDl4c2ljelhDaVgvRDlKVkNlMU1xeWRHRnJoRWg5RFBH?=
 =?utf-8?B?VStqVGhkVS9GTXJ0VStaSU1ROGZTKzhzNndna2VSNElUWFJWbytWdnRUZUJ0?=
 =?utf-8?B?NFQ5SExBcnVWWFBmcmRxcjBnU3VNak41UFN2QXArMHhNejJjUG5xMGxuTDdY?=
 =?utf-8?B?bmFTU25nVUhrNmIyMExVQm5IT3ozMmVNREhuM05zeWRjemRwY2k5OVN4T0xX?=
 =?utf-8?B?OE5GNjc5TUpFVlA3REZOQk1UWjdMSXB2cmdvQ0NveXlYOFIzVEtTci9jQVRa?=
 =?utf-8?B?WEpneG92WTY0OUdEQjJLZVpkanpwTXR5T0N5bHUweFlwQ0FLN25SZnRkbWF3?=
 =?utf-8?B?R0xleCs2dnR1N0hUZE94THowU05UOFpxRk9DU0pZZXJEbDdlVGFGOUFkaE5L?=
 =?utf-8?B?WTFIY0ZFZTRXQ0xBRnVoMGRJRVpPaXdEREMrSTdBWk5pd2I3VE04WWZGcGha?=
 =?utf-8?B?NkpmUFRmbGZIcFJZczFxdWdtSllZeGc4Q2NyWEZWMVpUQ3ZRYTZmR1pGS0Zr?=
 =?utf-8?B?MXN6ejUxSzhLNmRJVjlyS2dqQ0tXTE1obGxYeXBwR0ttOStGTDNoM2N4VHg3?=
 =?utf-8?B?TEFpb0dYbjdFT3IvWUpzWlBtNjRZemtLYTA5U1htK1B2ajFubmtFR2R6SGlQ?=
 =?utf-8?B?Z0tIbEdGcnVJbEF2dXpMYVBuVnVLQzgxQ1J5dTdYUENSU01wWXc3VEkzM1V4?=
 =?utf-8?B?QmJmSElHcnBORlR2ckRxUU4zVUprcjRSM2R3MUQ3emx2ZXd3a2JJck0vM213?=
 =?utf-8?B?VFptZkZFWTJnZFFWQm1aQmhxYWQ1VWtrbENNU2E3czMybm1KemlJaG1zRnhJ?=
 =?utf-8?B?QnViZU42bEhrcGJWNFppR1RiUVBubnREUWQ1Szc1YU5pM3hsNVNxTU1peXFl?=
 =?utf-8?B?WEhlVmw0cG5iMk02Z1A2MDU5ZW5OTDBOcFg1eTVoajYxWGZ5S1Fjd2d4WHIz?=
 =?utf-8?B?aEpYdmNhZktkU1ZucXNvUVlDN3pidkNCUHZhK3YvZ1NVd0NEbWVJUzlDV1Mv?=
 =?utf-8?B?alhmb0gzWWREb2YyUWhUUER2d1kvOU0vcWtKR0FkbWdJMGdacDhjcmJuYVBT?=
 =?utf-8?B?a3BDSlZpWm1Lc3V0NG9aTmN3enhLZTgrdCt4bWpxTGQ5VzVjZnpvOFRpNEpk?=
 =?utf-8?B?RllsTlc1RnphTjRFOThpY1czQ1NqWE9VNlZYMVpzTEt0WWhrb2tRYXF6Smli?=
 =?utf-8?B?V2NWR3NnTy9ZVzFEL1VHd0tpaUFhUzZ5YVdXaDZMKzdOSXJQNi9xemgwS1VF?=
 =?utf-8?B?SnozQStqZkhEUVhLWFg2VkpjNnZXcTlvM1FjTVZHMndQUk41RFRYSnlhd3Fs?=
 =?utf-8?B?a2RNVWVyNi81VVpXUFovdVhKTTZmMm14WTlLeE9sVGRRV0xTZVZMVExzaWph?=
 =?utf-8?B?S1Q5U1R4S0hXaSs1Y3JlclNrM2kwNVVhU0xzTEMxRmx4UGllS2R4cmxzQnp2?=
 =?utf-8?B?Q1JSSlh0bkVHUW5sZzY0U3VnUThoMUc5bWhYZG9aYThNZDdoZS9ZQXRSM3Zw?=
 =?utf-8?B?TFFUU1AwZFRWK0dWMk5sSjQ2aWRhT01yellCT2pXOC9Ebkd5UFJmQ0gwd0k5?=
 =?utf-8?B?SkFTTFNnM1UrQ3JPRTV3SGdGaVBJTm5DTlJmczVHYURhREFXNEZoL2VtMFNG?=
 =?utf-8?B?L3gzV3RLdkJVUEdGMjVwc2Joc0t0OVU3a0dQT2VFV1RaYkxHaFNmb2VIWUJC?=
 =?utf-8?Q?294deSreZGcAqtzCFLBKbK2Jd?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	8htIpuEg9oJZ6qtUSj2kRNzAiFR1xdS4FOdr8PQHPjzyd5MRHvJ+Jc/+TxSB6eoIy9nKt7skDV3t65VsjvlHN9lMt9D7TGjDwecYMsvstYHiavlyRbZPSpLhansOvNwc3ZZN6WaIm0/PgGoh/nUJcQOSyTzitlxIR6dPNUhWhHOQSGN+p1rHARUMshhwamouwLRNTPupP5FcNdMFccnjG4dtPfSxloDSia7IW0redea2jbomG5mHnFKRTB5sIhcH+MPcJOtCJJL4L4h/khw2J2YP1jW4KIAAC6Ed5bgCsRD6qySn0kiivlfw3xVRFcZ7LENxS1/PVa2sP6L8bR4iNDjf/Lya39g93gJ4togz6nm6hMdoM/ml/kUl/8uYRbaUoV46tOR4ptd9nsWx2Eidq+lY5QngWUrvFI+BZzXug81MWBkxmuSzA2m5qGtmc2g0LaStKo7iCiOsVS8LIc5oIHaO5whB/+N04f1yMgbCfejlTQvKnpLVMSsFPAXdXuwGDwaguQmtakG/xRY9SAxi8sqGmkTwxTNMYQ5UIgRB4cuHfuhcdrNJeIuVMe4yHS78Vgc5tFfW9wYWB4Z3I2BIeF5jlxRXt8U/mgqUItbTuA8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffbc5f43-b587-4a7c-dcd5-08de1d740757
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2025 20:35:31.0755
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M56/EEHTtXf/kLD7SOjXyOtXlokNpOa6t/qwoUPUc9L2JgTcXOKHYUdLk3yrQtEUmKWW4NK+dutVVCVWnfrhhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5626
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-06_03,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 suspectscore=0
 mlxlogscore=780 malwarescore=0 spamscore=0 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511060167
X-Authority-Analysis: v=2.4 cv=fe+gCkQF c=1 sm=1 tr=0 ts=690d0697 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Isj609wYBD7ci382qDcA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 2kIvnAxtVgJ60t5q9K6ZUTkMVfE469Ko
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA2MDEzNCBTYWx0ZWRfX9apYDNnD9NJE
 DtuYnL++UiHrfW1QaS0Mydb54Oav9XQbo/Q7pHZmBjnqQmAmFAlwTzVw2bxC/VVICx7mEOa3XsA
 rxZpBTSAAknoG0sljISRzOM90INW2HCPiylicAbLAwhUDayesux10H75aZktX82FMjA1xMFE6G0
 PEj2j5iYjvNz+ZxB5uQh2qWMAoUQ8wAoP/oMWCSLW7wyJvY8TuLtESr08NPNSmN+MhZVGxNg9Sj
 6n42hOs2Vzt5xnTH1Tf/MZxRjiLX9fUBOUMgdFWfo6uPVdsLqqFUTekklNag8KREsa/6mJm1EfO
 aQzeQODeCKEbW2u7UvG02kOrIA6a2V34ohwwz3ZBC/0sRRETsYjqpYqfOm5zZWno1BKE95sFDuj
 VG9c1xlFdl6h0pqVL6ZOUo3LRBvP2Q==
X-Proofpoint-GUID: 2kIvnAxtVgJ60t5q9K6ZUTkMVfE469Ko

On 11/6/25 3:17 PM, Mike Snitzer wrote:
>> I asked for the use of a file_sync export option because we need to test
>> the BUFFERED cache mode as well as DIRECT. So, continue to experiment
>> with this one, but I don't plan to merge it for now.
> Doesn't the client have the ability to control NFS_UNSTABLE,
> NFS_DATA_SYNC and NFS_FILE_SYNC already?  What experiment are you
> looking to run?
> 
> If just looking to compare NFS_FILE_SYNC performance of
> NFSD_IO_BUFFERED versus NFSD_IO_DIRECT then using the client control
> is fine right?

Not necessarily. You can mount with "sync" but for large application
write requests, that might still generate UNSTABLE + immediate COMMIT.


> Anyway, maybe I'm just being overly concerned about the permanence of
> an export option.  I thought it best to avoid export for now given we
> do seem to have adequate controls for a NFS_FILE_SYNC performance
> bakeoff.

I agree on not rushing another administrative API change. I was thinking
you would be prototyping some of this stuff first and playing with it
for a little while before it goes upstream.

It feels like it would be much more straightforward to implement an
export option that applies to all cache modes rather than gluing it to
DIRECT.

And as I said above, "no plan to merge it for now," meaning it's still
on the table for sometime down the road. I have some other ideas I'm
cooking up, such as using BDI congestion to control NFS WRITE
throttling.

But let's get the base direct WRITE stuff finished.


-- 
Chuck Lever

