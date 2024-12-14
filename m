Return-Path: <linux-nfs+bounces-8562-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 652B99F1FE7
	for <lists+linux-nfs@lfdr.de>; Sat, 14 Dec 2024 17:35:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82BD3161BEB
	for <lists+linux-nfs@lfdr.de>; Sat, 14 Dec 2024 16:34:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8827F38DE0;
	Sat, 14 Dec 2024 16:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="inViRyrD";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="bXnL9KvY"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C28D7E1;
	Sat, 14 Dec 2024 16:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734194096; cv=fail; b=MnO1BNx7vor/C0hS0dDmyml873zLIICX3OZJQRn5WlDLMD0MQ+48U3k+O3snGlGmtsIYeF9CTw1hDqkCswy+bEi7jOs01va/G8k838H3I3kKisDcgZz7tmuVOaCa2ll6wrE/Tu0Pk18oZlWNeBCZ6JxaXi4xqZmHXjmHRA9Um60=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734194096; c=relaxed/simple;
	bh=7CzXYoTYpDWmiGGfyRoKJwmdWQfYBppyf3EB4e8dqqc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Ff+Ij81StnWWDHv+BOXcL5WNs4DL77Eft9lkhG82/JEdad+sB0cjeBq+ClhCdPNq3J3bX5NDIsgIa1kxLruHsEvaii/Aw1rKfw/pvJLf/lX+cA0Z5ZMtt6mvMoQN5y3Ug2IvsweARdZnr1Q1H1YSTduW4HgXK4lZMF0gzBZB/vk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=inViRyrD; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=bXnL9KvY; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BEEPrPa017913;
	Sat, 14 Dec 2024 16:34:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=ga9JQaphQj8PEPmr7P951CSmVXjxwmlumzzHJJDI4YU=; b=
	inViRyrDsuL/rz28rGqDx7Z+xHHwSZKWHyN44hGmX7mNQdaffEpB9fC1LNe+hTMt
	xMZZbNyoGGZjyNv2VUlI7JAVHB7JHJw6tRooSwcYP91rIrFd91ZEOBr39xo3xW6u
	NWSiUcegf8pgjWx5XymOwkghwvcZf8PL9xu1Yyiu1RtbJRqvqYbxdfuJkqeaVvyT
	ZcYFvr9sXYhIquce3/qt305oFqRk/lgnMpYgFUnC4GVkEu1Vlm4ym31Y5tc27aGa
	CVZvub4vJ4c7fMhV+tU5KPG9hENPgugy/joNVIaQOdjOhC53MdbXClfr0EsspnCO
	xaAzY3pjcofts088MGrYXQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43h22cgh7b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 14 Dec 2024 16:34:37 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4BEEQ3FT032040;
	Sat, 14 Dec 2024 16:34:37 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2046.outbound.protection.outlook.com [104.47.55.46])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 43h0fbw5qw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 14 Dec 2024 16:34:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tXD93HElL+VfO0HeESZUdkeDEWPJPmOt6teQmb6MFyasY75qs//akwARQ/iQ5TOmy+HG99GMW0oV/gH8CQQJ/fZ/Re+EsdlTiZe6g8gV7jmFg/KYxlbdXjHLG/kFFGomH/ZXE4QpeaC3DQF6MubEbaHl6XyYiiyxPTWlUCw2dejfnZsMZuZSDsSbHwO0eFHhqZEZK1CjtPa3V0J9ciAFVhbPrrHlnoPBdaBl7theGlMXqcGdXkeNqNsohDWCiA0o0PnqVeS8xr2bLoRXSrszFYQeRrof1dnQiDiWVWrTKb1FrKecPAkk1MwW4M08FqW3wMo0uPjsa0QfJObNdYHw8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ga9JQaphQj8PEPmr7P951CSmVXjxwmlumzzHJJDI4YU=;
 b=kFXkYON17V4yIm2ezwwn4OGH34AKBBxTzZl9HfBCcCEEP7KhfFhdqXuO8xc4UIdV24ga86gU9MHsu6tzBuM8Cmfm3Z5P/0kBZqo9UUn5Ev9TgP29GjSLq4ZrAFKCxS8ehwEauoPbqNLaTIsG2RJ3LYxwyGTcddKQy2QEYIV8Hlt6XgZjIVPZduyQKVD+zxq92tMRvSyiBWd31NvRjfg8iaqznWhaErcwUgyWk/tYvuZqA4dkrAFFcikZi8ELO0Ztj6/nRwtIPBK3A152KhWhLB3TKVkL7Go+GBJy6ycIJLYupc9b0Fa0hQ8s6/8xe/+EGwjk6/BqfqIVChgf+EzZgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ga9JQaphQj8PEPmr7P951CSmVXjxwmlumzzHJJDI4YU=;
 b=bXnL9KvYSnPCCMxEREIeJtqdDTzLW00ArS5+pENNdHrhRgKDKI2qRu40/9O1QkG0M6fD2J8sxjw4DRaWlsrmeqDatmbrimBdMVmAo9iu4nAFLmwM+fg6Raip4upJ1YuHTF9LMhp8/Xt/8UjypESliw3AUv7YeEUUcnX3BWrfXeQ=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by IA1PR10MB6051.namprd10.prod.outlook.com (2603:10b6:208:388::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.19; Sat, 14 Dec
 2024 16:34:34 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%7]) with mapi id 15.20.8251.008; Sat, 14 Dec 2024
 16:34:34 +0000
Message-ID: <b45404d4-cbf1-4f42-ab74-5868ef7fe895@oracle.com>
Date: Sat, 14 Dec 2024 11:34:32 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 09/10] nfsd: handle delegated timestamps in SETATTR
To: Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>,
        Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>, Jonathan Corbet <corbet@lwn.net>,
        Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
References: <20241209-delstid-v5-0-42308228f692@kernel.org>
 <20241209-delstid-v5-9-42308228f692@kernel.org>
 <2a3c0a1f-0213-4915-a4c0-a2ba31ae1bbc@oracle.com>
 <f697868bfa7f219d51ba8251db32b22ad942ecd7.camel@kernel.org>
 <c4835f2b-0edd-49a2-9f61-5bd7090382dc@oracle.com>
 <f2284ade0fcda383c29a4be58a3d0eb012bf5ec5.camel@kernel.org>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <f2284ade0fcda383c29a4be58a3d0eb012bf5ec5.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR07CA0038.namprd07.prod.outlook.com
 (2603:10b6:610:5b::12) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|IA1PR10MB6051:EE_
X-MS-Office365-Filtering-Correlation-Id: c68a8f33-96bb-4a21-903c-08dd1c5d3137
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YlN4RVY3aE9aWHcyS1hNREdPQ0s1M2l4bktBTXJJUnhIQ1dNbTJYTzNNRmRR?=
 =?utf-8?B?d3ltSXFaZ3JkMUdTbFJHUEdvUVdoT0dkblloemFMeVFseDZiN2tpSEZHVVlx?=
 =?utf-8?B?UVlXck5MZXFBYUo0Y3RHL1VldG92dGNZalBlN2RSdjNRcFJIVXBhVmJvRzln?=
 =?utf-8?B?Vm5BcHEzMUxYZWFTY2JHU1JxbmptTWFSNlV2TTZuMUxJbThGNENSbXRQZnhw?=
 =?utf-8?B?UTBoQUZ3L1NCNjQzMlBpYUU4Um9JYURIdndzeGh2ZUtNelIwbTZXRU4welI1?=
 =?utf-8?B?U2p4eHgyNExSa3BtMTlxVkdnZVNFdUtQQk8rUUdENnBSN2NNaUZKQzVYekI4?=
 =?utf-8?B?UHY4RmZDbVJ3ZmVQRWFKa3NRMGJOSUpNZEdBdkNqb2hpZG9rOTlpejVqQjVD?=
 =?utf-8?B?YUlwc1R5SklpQmVoSWdTNTVHaElhdGpiMmZubFNTWHM0VzR3Qnp4VkVPeXJ0?=
 =?utf-8?B?RFI2WGFjejhFZENwU3JUYjZjR2ZqeUhWcGx4bllOSy9CUGZoWERQT1pUL0M4?=
 =?utf-8?B?MFVUa050T081eWtwOTQzME5jVm4vQm5PV2psNC85WVN2RDJ4RTBOL2ZvYVVO?=
 =?utf-8?B?NG9vUUhGbzd0VTBYeUlsV09PWWFCTmpLR1lYNWFEV1podHk2aGo2bUtyQmp6?=
 =?utf-8?B?aWpEM0NYSW1SdUc0UVptRGVZOXg5UlBsdXN0SzJKdnJyWU9xTVZHWEJzR0ty?=
 =?utf-8?B?TFBmR3llNThwU3YxbWhvZW9mcDhNcm5vMTN6RythczI3a2RaMThPdU81WW9h?=
 =?utf-8?B?a0phbHgySWFxWWYvbVBqa1RuYjJKV3NjL240VDZqMVZiM05OMlN6WW1pQ1pq?=
 =?utf-8?B?eDUxbTBxeXVFSFhGM0c1ZlY2SHA3MHdUOG1TUHRDV0dybm4yU2lMYUtHVUt1?=
 =?utf-8?B?V1kzdDNHd2J3bFl5T0w1T3JvQllEZ2tNaW82YVB1bWlmR3ZuaHhRazFTczgv?=
 =?utf-8?B?RGFQc1JkVjNXRUt4OWQzYUlqemxHYnZQbzhIczRoNjBKWTZnSnNHY2J2K1hY?=
 =?utf-8?B?RzFUaTRWNlBvMitYNS9JWUJOS0NLQWJMbmVtMWhCdllKMDF0U2diWUJ2Tnlv?=
 =?utf-8?B?YUFVTXcxdHAzL29oK1ZGM3hobnNyMUxtMFErWURENG9RLzhmQkpYS2ZYVXJv?=
 =?utf-8?B?aFM5ZldOZW56dEsrQjRBTmFKM1RTSTczLzhGTzBTZUhZMlVlb3RMWGxvMmhh?=
 =?utf-8?B?aG94MW93Yys5T2RiRUhkbEhiY2lOQkVOZEFlS2QvMjBYcU9FYk02V3ZIWC9k?=
 =?utf-8?B?YmdlaXZzRHdvbEV6eGhkRVJOUFdoRjM2N0JjK1VFWHZTSEhJYVlUZEtRbzlv?=
 =?utf-8?B?U1ZRS2E1dkhHdlZKMU1PeU5Lek1nUnVOUCtyWmdpTkF1ZlR6TXdkVG1ZSjV2?=
 =?utf-8?B?UHUvRkpZdXdrais1V1dhUTdTSi9sNzZianVENkNWSXBxb2JJOTlOTVJ6bldT?=
 =?utf-8?B?RjlIUVZFZGRVOHJCeVFBb0NsMFVFcW1sM0dLb0ZhZUlFemI5UXlrQmp6bnpT?=
 =?utf-8?B?YVpZQXNlWUdZb0VyTVhUN2xweUI1VVdlZXQxWW5LcGFMOHFQV254TG84Tnoy?=
 =?utf-8?B?UEo4TkJhRjNlTjRmZDNUYlk4eXMvdTNENjY4V2tjeVlkU2l1RVp6aXpLMHpT?=
 =?utf-8?B?QlVuWG5EQ3dya2xHTjhSOGVYU1MzNzlDZmdQOFJCWWtCcTU1OFFSeFFwODdm?=
 =?utf-8?B?RG8vZzQvRVdNV3A3L3QrdXpFa3dtaStBSzdSTks2OG9zM0syTEVIRkloVFdv?=
 =?utf-8?B?dHJRNWJzWElJTHNjSUFzaFlucElMTnpiNmtaMDBvYzRHcU9sQUFCZmI1ZXFU?=
 =?utf-8?Q?/4lT/C89FBHOfPzNq58LtzPEvQT8nCEJ8S8EM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d1BoYm1PdGlzNjNxanNXQ09qdHloeHg5M1dxRnZiR1RGNWxrODBSaFpnc21u?=
 =?utf-8?B?NnBMdkpweFJnUGcyOGxYL0w3N3RTaENtZUhnVTg5RE9UTGthK3JQK01SOTV3?=
 =?utf-8?B?cjM1eWg3N1c5M010dUszVUw2ckhXNXN0citSbTUwL1YrTHZwUnNKMmlGZE5x?=
 =?utf-8?B?Skh4eHNVV1JrU0dmVHhqU25OL0ZJdEdYdTlkSko1VHJqT1JKenVDTmdKeCtx?=
 =?utf-8?B?RXFGM3hpQ201aVVLcWladW82MFFHN29MVzYrSFpDdWlEMEIzRFJIOWpRRjgv?=
 =?utf-8?B?RS9Gc2dnc3Y0MUVLV2xSakFvOGtBSWdDdXJReTZMYThxWS9YQll0WU9abTgz?=
 =?utf-8?B?dnJHVnJaSkNoTDE2VlQ3dVovQ3J6MDluU1RzUE5TZjhWZEVBZUVwMjNQVWF4?=
 =?utf-8?B?M3NmMVJCR3BydHVyeGFhanVodzRBcXgyWDFnaW1wSWI1cVJ2OEFEclpqMFV6?=
 =?utf-8?B?YXJCRUNVY2Q5WnVjUUIzSHdhM1pvL0MvT2d6VEcySDhOQVEwSm5Ha3BiWE9a?=
 =?utf-8?B?d3B2Z2cydGxpUEVjU0dUS3E3OVZpcUVSNVJCWnpsSTVHUWFYSk52YlFpdVM2?=
 =?utf-8?B?RlJIcDJtcmk4bUQ0VVVMclh1Nnlzb1ZMSVFoanhEQVZLL3pPUlltRGk2VHdt?=
 =?utf-8?B?VW5oZ1U5TkVMSkxwV2VST0tneEZLNmZNQytoeDJZcmQ3N0VaV0pKVTlCZzcr?=
 =?utf-8?B?bVJlMEI4MEVGZGRsVlVTT0VXVFFxc3NoZWFhZlU1eEROOHZZajFOUVM2SlBV?=
 =?utf-8?B?WkZSd1B3VFdNem14L0poSGZXNUdVbVVtMEhFeVNaQzVCZCtScEVCalhZdXli?=
 =?utf-8?B?dnFKaFZhdWVCVnltYUNsYzNROW1QUWtUWVBYTEFXQUpXb0gweGZYN29JNnJP?=
 =?utf-8?B?UFRUWEZuRWh2TDhhK2pIZjVYd3E2a1V5U082Q1cwN0lCdUcwdTRuWHdvR0FK?=
 =?utf-8?B?RHdCWU92aW9PNnVwZ2piT1pSSy95OFc1Zy9SblRxcjRPdjNMK3kzVTJaZVkw?=
 =?utf-8?B?YUphUk1JeXJ1cS9VWG1aQ2Y5NGNyOVU1ODRaMGUzVksxYnpwcEY5Q0VaQ2Iz?=
 =?utf-8?B?YUE5Yk8zUXhQZU1BaFlPYXNJRTF2NmhGb3FUamc5Y1hRRHp5Q2xZNFl0MXBB?=
 =?utf-8?B?OG5yMVVScFMySFRrUnhraGl3V254cGUzdGVxV2V2QU5SY2k5ODd6OE90eXdR?=
 =?utf-8?B?R2loUkpZWHhQSWtOOThieFB4bXNyRlg5REJVdlZNZTRZMnBHZnp6TFRRU2ht?=
 =?utf-8?B?aGo4Z3FSc3dRQm05ZHN3TWhIYUdkSEdnMzhsUlIxcWlEMjV4U3UyeGFZR1lu?=
 =?utf-8?B?TFpycEZzZ3RlQnNBNmJzOGVkRTFvOXFCUVBWK3dPS0YvV0QzZDZKbmMwblpj?=
 =?utf-8?B?NGpFQzFEcHE3NVl6S3JnYVJBY3Z0cDN2aDhGQjZuOEIrN3NHOVI4ZVVZbm84?=
 =?utf-8?B?ZDBKOHdhS05XRWtxRmN4eVZtWG00cDc0MXprODdLVFlZc3ZPQTFabmRTVTVj?=
 =?utf-8?B?dEgvSkpucWRyeWVra1dIT1NkdFFwb3kzSWg2MGxabnh5U2gyWkZJRTdSWC9I?=
 =?utf-8?B?SXlubytBaWl2NGkyTlBoTUZGVHpabm9qQWg5SVhoSi8yMWxpVFgvVzI2Ukdh?=
 =?utf-8?B?VVRSM2ozRXZnclc4TnFWN3RFUW8yK0Vnd3VTdlAvNTlzUEluR1dRZ05EWTZl?=
 =?utf-8?B?NjV3UFpiRWh6em53UExzQUNzakx5eUMybnBYSVB4T0VBbmdJZmpISUZRZXVJ?=
 =?utf-8?B?Qkw0UHVWWmtYamxDc29veUs0ZFN6bW5BZWRnMjJ3cUpHQUhJdXBJNDNvT2c5?=
 =?utf-8?B?a1J5RUd2RFBhZGRaZUZDVGd6Si8zWmpyaUVHZjJiYlJyWCs4Z2t0S0h4MUpS?=
 =?utf-8?B?THdaNFo0ZTdQODBoOG1mL1VtT2Jna0g4c0RZUnd3UDFHaiswbUFSa1RTblBr?=
 =?utf-8?B?Z0pNSXh5RG5mbURtb2VLVEpIRUNIRElUS1FHRVU1K3U4WE5jcGpDY3ZFTDlX?=
 =?utf-8?B?YXpUVU1jN3lzSTN0Qk12WEdhdnF1bmR3dFJVNEhxbGJzRnZqNUdtTGNWNml1?=
 =?utf-8?B?OEJRYjRZTC9iSmpLZ3gvZURlTWExWmlmTDJTU1FubENCSFNFRkJBWWt6bS90?=
 =?utf-8?Q?ZrYcVLvzRYgts4VNGevm3PkRG?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	n/H4ovLkrUHA42cKiUAQ1HmK80M7Dd7894Ocb398P7slQrKjPS/nlWZ48VobR6ewyIJmZHJrfTv2H4HZwY1Xf+0A7OePY0e8JPSP3X+zqr63RIf7RheKT9TID5mfhE/VMEq3eChlrrMJf/RqI2goZQIUNqH5X6qgLobhU1sTRcjZlZN2/DDe7M/pWcM+b5Xtc+O0OU6+UNAuMH7sd7x2q1MoUd7agxrx5YGKt7CvQAmk3/yJT6eR61sN12HxsQ6rcIs4IS9Z5CQP71hxvVD5FGqpMoM692PKfr6q8cqMGafQDjwPEeQPGQ2ABrE5mHpvNowS4LLYFgHUKuRTuOCmCxaVGXTlsueI1NPYibocFKY7HGIEHjU9UG5NMVEEWyU5emI5UTf3RPplIFdAux4j0mH8C2AmJhL+s4cxbCWs9ahMuoKQ0fe6A6t/jet2w2ZYcUMC7CK0eMiIcWHj4MtIAkgfADN2C5Kl2woThGLzx3kWCn/M+bs589MybQbtqYqE3c/qxoFrYry2h/ZeljkGGUcq+tMziO6ByT8B+Hs1t5ZZQdqRgZCdl2ND3pxN0E+aC3zM4PYcIMNB6ibECmk5YzgqwyJEd2vnvvQ/vvNu5YE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c68a8f33-96bb-4a21-903c-08dd1c5d3137
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2024 16:34:34.0926
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l7tynWK8piXu20AcIcvfnE7rDSTp+pVCRDNHfSlvwnDbMT6rsPUz9lQNKX+1u2qCi1uLaQgU2AHB25bdZ8Ef3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6051
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-14_07,2024-12-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 suspectscore=0
 adultscore=0 bulkscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412140136
X-Proofpoint-GUID: bqEUPqICvDarRc4Z4FYO3gZd6QsO2c4x
X-Proofpoint-ORIG-GUID: bqEUPqICvDarRc4Z4FYO3gZd6QsO2c4x

On 12/14/24 9:55 AM, Jeff Layton wrote:
> On Fri, 2024-12-13 at 09:18 -0500, Chuck Lever wrote:
>> On 12/13/24 9:14 AM, Jeff Layton wrote:
>>> On Thu, 2024-12-12 at 16:06 -0500, Chuck Lever wrote:
>>>> On 12/9/24 4:14 PM, Jeff Layton wrote:
>>>>> Allow SETATTR to handle delegated timestamps. This patch assumes that
>>>>> only the delegation holder has the ability to set the timestamps in this
>>>>> way, so we allow this only if the SETATTR stateid refers to a
>>>>> *_ATTRS_DELEG delegation.
>>>>>
>>>>> Signed-off-by: Jeff Layton <jlayton@kernel.org>
>>>>> ---
>>>>>     fs/nfsd/nfs4proc.c  | 31 ++++++++++++++++++++++++++++---
>>>>>     fs/nfsd/nfs4state.c |  2 +-
>>>>>     fs/nfsd/nfs4xdr.c   | 20 ++++++++++++++++++++
>>>>>     fs/nfsd/nfsd.h      |  5 ++++-
>>>>>     4 files changed, 53 insertions(+), 5 deletions(-)
>>>>>
>>>>> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
>>>>> index f8a10f90bc7a4b288c20d2733c85f331cc0a8dba..fea171ffed623818c61886b786339b0b73f1053d 100644
>>>>> --- a/fs/nfsd/nfs4proc.c
>>>>> +++ b/fs/nfsd/nfs4proc.c
>>>>> @@ -1135,18 +1135,43 @@ nfsd4_setattr(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>>>>>     		.na_iattr	= &setattr->sa_iattr,
>>>>>     		.na_seclabel	= &setattr->sa_label,
>>>>>     	};
>>>>> +	bool save_no_wcc, deleg_attrs;
>>>>> +	struct nfs4_stid *st = NULL;
>>>>>     	struct inode *inode;
>>>>>     	__be32 status = nfs_ok;
>>>>> -	bool save_no_wcc;
>>>>>     	int err;
>>>>>     
>>>>> -	if (setattr->sa_iattr.ia_valid & ATTR_SIZE) {
>>>>> +	deleg_attrs = setattr->sa_bmval[2] & (FATTR4_WORD2_TIME_DELEG_ACCESS |
>>>>> +					      FATTR4_WORD2_TIME_DELEG_MODIFY);
>>>>> +
>>>>> +	if (deleg_attrs || (setattr->sa_iattr.ia_valid & ATTR_SIZE)) {
>>>>> +		int flags = WR_STATE;
>>>>> +
>>>>> +		if (setattr->sa_bmval[2] & FATTR4_WORD2_TIME_DELEG_ACCESS)
>>>>> +			flags |= RD_STATE;
>>>>> +
>>>>>     		status = nfs4_preprocess_stateid_op(rqstp, cstate,
>>>>>     				&cstate->current_fh, &setattr->sa_stateid,
>>>>> -				WR_STATE, NULL, NULL);
>>>>> +				flags, NULL, &st);
>>>>>     		if (status)
>>>>>     			return status;
>>>>>     	}
>>>>> +
>>>>> +	if (deleg_attrs) {
>>>>> +		status = nfserr_bad_stateid;
>>>>> +		if (st->sc_type & SC_TYPE_DELEG) {
>>>>> +			struct nfs4_delegation *dp = delegstateid(st);
>>>>> +
>>>>> +			/* Only for *_ATTRS_DELEG flavors */
>>>>> +			if (deleg_attrs_deleg(dp->dl_type))
>>>>> +				status = nfs_ok;
>>>>> +		}
>>>>> +	}
>>>>> +	if (st)
>>>>> +		nfs4_put_stid(st);
>>>>> +	if (status)
>>>>> +		return status;
>>>>> +
>>>>>     	err = fh_want_write(&cstate->current_fh);
>>>>>     	if (err)
>>>>>     		return nfserrno(err);
>>>>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>>>>> index c882eeba7830b0249ccd74654f81e63b12a30f14..a76e35f86021c5657e31e4fddf08cb5781f01e32 100644
>>>>> --- a/fs/nfsd/nfs4state.c
>>>>> +++ b/fs/nfsd/nfs4state.c
>>>>> @@ -5486,7 +5486,7 @@ nfsd4_process_open1(struct nfsd4_compound_state *cstate,
>>>>>     static inline __be32
>>>>>     nfs4_check_delegmode(struct nfs4_delegation *dp, int flags)
>>>>>     {
>>>>> -	if ((flags & WR_STATE) && deleg_is_read(dp->dl_type))
>>>>> +	if (!(flags & RD_STATE) && deleg_is_read(dp->dl_type))
>>>>>     		return nfserr_openmode;
>>>>>     	else
>>>>>     		return nfs_ok;
>>>>> diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
>>>>> index 0561c99b5def2eccf679bf3ea0e5b1a57d5d8374..ce93a31ac5cec75b0f944d288e796e7a73641572 100644
>>>>> --- a/fs/nfsd/nfs4xdr.c
>>>>> +++ b/fs/nfsd/nfs4xdr.c
>>>>> @@ -521,6 +521,26 @@ nfsd4_decode_fattr4(struct nfsd4_compoundargs *argp, u32 *bmval, u32 bmlen,
>>>>>     		*umask = mask & S_IRWXUGO;
>>>>>     		iattr->ia_valid |= ATTR_MODE;
>>>>>     	}
>>>>> +	if (bmval[2] & FATTR4_WORD2_TIME_DELEG_ACCESS) {
>>>>> +		fattr4_time_deleg_access access;
>>>>> +
>>>>> +		if (!xdrgen_decode_fattr4_time_deleg_access(argp->xdr, &access))
>>>>> +			return nfserr_bad_xdr;
>>>>> +		iattr->ia_atime.tv_sec = access.seconds;
>>>>> +		iattr->ia_atime.tv_nsec = access.nseconds;
>>>>> +		iattr->ia_valid |= ATTR_ATIME | ATTR_ATIME_SET | ATTR_DELEG;
>>>>> +	}
>>>>> +	if (bmval[2] & FATTR4_WORD2_TIME_DELEG_MODIFY) {
>>>>> +		fattr4_time_deleg_modify modify;
>>>>> +
>>>>> +		if (!xdrgen_decode_fattr4_time_deleg_modify(argp->xdr, &modify))
>>>>> +			return nfserr_bad_xdr;
>>>>> +		iattr->ia_mtime.tv_sec = modify.seconds;
>>>>> +		iattr->ia_mtime.tv_nsec = modify.nseconds;
>>>>> +		iattr->ia_ctime.tv_sec = modify.seconds;
>>>>> +		iattr->ia_ctime.tv_nsec = modify.seconds;
>>>>> +		iattr->ia_valid |= ATTR_CTIME | ATTR_MTIME | ATTR_MTIME_SET | ATTR_DELEG;
>>>>> +	}
>>>>>     
>>>>>     	/* request sanity: did attrlist4 contain the expected number of words? */
>>>>>     	if (attrlist4_count != xdr_stream_pos(argp->xdr) - starting_pos)
>>>>> diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
>>>>> index 004415651295891b3440f52a4c986e3a668a48cb..f007699aa397fe39042d80ccd568db4654d19dd5 100644
>>>>> --- a/fs/nfsd/nfsd.h
>>>>> +++ b/fs/nfsd/nfsd.h
>>>>> @@ -531,7 +531,10 @@ static inline bool nfsd_attrs_supported(u32 minorversion, const u32 *bmval)
>>>>>     #endif
>>>>>     #define NFSD_WRITEABLE_ATTRS_WORD2 \
>>>>>     	(FATTR4_WORD2_MODE_UMASK \
>>>>> -	| MAYBE_FATTR4_WORD2_SECURITY_LABEL)
>>>>> +	| MAYBE_FATTR4_WORD2_SECURITY_LABEL \
>>>>> +	| FATTR4_WORD2_TIME_DELEG_ACCESS \
>>>>> +	| FATTR4_WORD2_TIME_DELEG_MODIFY \
>>>>> +	)
>>>>>     
>>>>>     #define NFSD_SUPPATTR_EXCLCREAT_WORD0 \
>>>>>     	NFSD_WRITEABLE_ATTRS_WORD0
>>>>>
>>>>
>>>> Hi Jeff-
>>>>
>>>> After this patch is applied, I see failures of the git regression suite
>>>> on NFSv4.2 mounts.
>>>>
>>>> Test Summary Report
>>>> -------------------
>>>> ./t3412-rebase-root.sh                             (Wstat: 256 (exited
>>>> 1) Tests: 25 Failed: 5)
>>>>      Failed tests:  6, 19, 21-22, 24
>>>>      Non-zero exit status: 1
>>>> ./t3400-rebase.sh                                  (Wstat: 256 (exited
>>>> 1) Tests: 38 Failed: 1)
>>>>      Failed test:  31
>>>>      Non-zero exit status: 1
>>>> ./t3406-rebase-message.sh                          (Wstat: 256 (exited
>>>> 1) Tests: 32 Failed: 2)
>>>>      Failed tests:  15, 20
>>>>      Non-zero exit status: 1
>>>> ./t3428-rebase-signoff.sh                          (Wstat: 256 (exited
>>>> 1) Tests: 7 Failed: 2)
>>>>      Failed tests:  6-7
>>>>      Non-zero exit status: 1
>>>> ./t3418-rebase-continue.sh                         (Wstat: 256 (exited
>>>> 1) Tests: 29 Failed: 1)
>>>>      Failed test:  7
>>>>      Non-zero exit status: 1
>>>> ./t3415-rebase-autosquash.sh                       (Wstat: 256 (exited
>>>> 1) Tests: 27 Failed: 2)
>>>>      Failed tests:  3-4
>>>>      Non-zero exit status: 1
>>>> ./t3404-rebase-interactive.sh                      (Wstat: 256 (exited
>>>> 1) Tests: 131 Failed: 15)
>>>>      Failed tests:  32, 34-43, 45, 121-123
>>>>      Non-zero exit status: 1
>>>> ./t1013-read-tree-submodule.sh                     (Wstat: 256 (exited
>>>> 1) Tests: 68 Failed: 1)
>>>>      Failed test:  34
>>>>      Non-zero exit status: 1
>>>> ./t2013-checkout-submodule.sh                      (Wstat: 256 (exited
>>>> 1) Tests: 74 Failed: 4)
>>>>      Failed tests:  26-27, 30-31
>>>>      Non-zero exit status: 1
>>>> ./t5500-fetch-pack.sh                              (Wstat: 256 (exited
>>>> 1) Tests: 375 Failed: 1)
>>>>      Failed test:  28
>>>>      Non-zero exit status: 1
>>>> ./t5572-pull-submodule.sh                          (Wstat: 256 (exited
>>>> 1) Tests: 67 Failed: 2)
>>>>      Failed tests:  5, 7
>>>>      Non-zero exit status: 1
>>>> Files=1007, Tests=30810, 1417 wallclock secs (11.18 usr 10.17 sys +
>>>> 1037.05 cusr 6529.12 csys = 7587.52 CPU)
>>>> Result: FAIL
>>>>
>>>> The NFS client and NFS server under test are running the same v6.13-rc2
>>>> kernel from my git.kernel.org nfsd-testing branch.
>>>>
>>>>
>>>
>>> I'm not seeing these failures. I ran the gitr suite under kdevops with
>>> your nfsd-testing branch (6.13.0-rc2-ge9a809c5714e):
>>>
>>> All tests successful.
>>> Files=1007, Tests=30695, 10767 wallclock secs (13.87 usr 16.86 sys + 1160.76 cusr 17870.80 csys = 19062.29 CPU)
>>> Result: PASS
>>>
>>> ...and looking at the results of those specific tests, they did run and
>>> they did pass.
>>>
>>> I'm rerunning the tests now. It's possible the underlying fs matters.
>>> Mine is exporting xfs. Yours?
>>
>> Mine is btrfs, and the NFS version is v4.2 on TCP.
>>
>>
> 
> Nope, I still can't reproduce this with btrfs either. I'm also using
> v4.2 on TCP. I assume you're running this under kdevops, so we should
> have a relatively similar environment.

I'm running the "stress" setting, which starts twice as many threads
as there are CPUs (so, 16, I think?). 32 nfsd threads.


> Are you also testing the same commit?

The first failing test run is on 6.13.0-rc2-00016-gb45eda1daa7d

https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git/commit/?h=nfsd-testing&id=b45eda1daa7d79a2bf0426d27d4b359b8bb71d33

I'll take a closer look.


-- 
Chuck Lever

