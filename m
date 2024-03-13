Return-Path: <linux-nfs+bounces-2283-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F7BE87B174
	for <lists+linux-nfs@lfdr.de>; Wed, 13 Mar 2024 20:16:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92AD71C20F7F
	for <lists+linux-nfs@lfdr.de>; Wed, 13 Mar 2024 19:16:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4B1853811;
	Wed, 13 Mar 2024 18:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Zg2krGSm";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="DlbwvhoX"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9112B4AEEA
	for <linux-nfs@vger.kernel.org>; Wed, 13 Mar 2024 18:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710355607; cv=fail; b=oO/kgoj48C+hwa/bS8+M3E8p/yPLHBLXJ1OPY5vhWTRVVjPI/Fik0VLbOvkSFP/xKvlqo6vNMTtMAEC5kkKNY7nFhmO47pmGBJCFwyss+MGw5edcu1y9o0KdE1PLVmynr3u1hMCF+VJ0raZ9rHcdKnoBYL9826O1dk/Xbbbumtc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710355607; c=relaxed/simple;
	bh=ti8iMdk+6Gy6KDwV6RarZzQi0GSv05yMUmSLrUgN1lE=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gtoggCQz8MzOWhxJI0SjnMbU0MwhH8gE7XIWXJvZOybYpnF7LPBbPpn1Ttgcx9tOq4bQbrePYD3Ml43gZvYaaMHb/o+4QkrgR1VKRNeYtYZC13lMGcFRRMrQalf7MvkRsnJntrvm656C8Nb+2uL3zMzdbIZsAFr3RALZcculYNM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Zg2krGSm; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=DlbwvhoX; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42DHxcXK022087;
	Wed, 13 Mar 2024 18:44:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=bCuxn6O30B2SS759t/nk/yBx4TrSyRpY+YatceE2B6o=;
 b=Zg2krGSmmn48NskdEiW9EcC4gZh4/as+RsNvRSXeKGX4JzG3k4TmCAYtH6NMBHUUKGN5
 gGZNwpPQY8faB+pr6gZpy+sgFFvUmHDh0FhIgQ/QK+sJgSqKyRpBuo31N99/ZgNHF6t4
 GtMcsK3Nwzwm0ZxpUF9VDWjlhmdgHWuYZkKs4OsLgAK2flbS+/FakI0UcaAIaVt7SI2s
 QjOlvxzLU5BUp2RuX9sPKS+BlkFKZ8vvfHL14znJVq25WsTJd1cTXNU7WV3hTPL1op3i
 VC7P4iBLYyrNxoRrXokBBcWCY0fL3qbNUVKIqAzSoKvGzvmO1cTGgnzGJdcHP3ci9yDK 7g== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wrepd1mre-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Mar 2024 18:44:30 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42DI24dK019865;
	Wed, 13 Mar 2024 18:44:30 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3wre798qmx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Mar 2024 18:44:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QWvwiZapPUTLthmuMTVKh/w7aGDq/X2rPgJEjhLXxA8dS2t8x/W9pdgfp8LmgSu9peGF+fgbclYVB73EHAp7yxprxP0J6OfQN3Qvg+R2bFifcyuSl8E4JLn41W2KbPBC2X5+0MlzUPd5DhIOLPBWKSzm1po5DVnWEaQSArZyp247fvONb/jdi0T4mUYrno20W7Sd4OkAgu8DGzl7WJ6zQWQX9vFf5sGIi6ZpzwwMTqWtqJVlznI7MCg8cbTfC3BIud+eWzYK9gcWLIEpyjHUnQsvnA0T7PiuLwOsCLjrtMWeG8tMIkEKA2o4QvhVwmYl5r69dUZVjer0lfvex+5FzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bCuxn6O30B2SS759t/nk/yBx4TrSyRpY+YatceE2B6o=;
 b=VChVDPH66+MWPkSXYG1WiYIdqMhLVgQEuD/lhHztxOOs2pnucPuBmJwXw1pvNyDZPCQDTA+9m2nEP+E9vRszfPgb+oeFZbptxqDlvy87AX48PSDjGxSZqXOquQsfQ5halzeNGWYPJ9IlLrD85bxc6NnVPIjvDyz8sekzl+PO8FPgNefd97c9SnFAkhe7GDWqS6keuT01aFQcKbpoRYYwyQbay2x+OHAcdmfAkdJKv1Pn1JPqJYPQCmVjZm61czqDUcmYuw867kakOEns6GvaRl+SNTuloAqhQELU/t5aUY2Tt+1e2UraO/HLhWwsKiPuRD5o+hoif0CMmtHLVtaXjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bCuxn6O30B2SS759t/nk/yBx4TrSyRpY+YatceE2B6o=;
 b=DlbwvhoXUQ0ll6Dxy17KM+SgvBZ/HtWW/OrZfpqjUnrHFPGyg26wt9kToGVmzMIYa1oTxwI3jfcqs1/0ftY5q9k01cyEzkLBRK/zdSjv7D4Ya91WlmLt/bKExXcUhvORaQgW2XYDkwm28eBnIXtnl4sFHPaZxvEv44Jd8f6fkgs=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by CH0PR10MB5194.namprd10.prod.outlook.com (2603:10b6:610:d9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36; Wed, 13 Mar
 2024 18:44:27 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::b7ab:75e7:2cf9:efc3]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::b7ab:75e7:2cf9:efc3%3]) with mapi id 15.20.7386.017; Wed, 13 Mar 2024
 18:44:27 +0000
Message-ID: <63a2600a-b916-4bb2-967a-4eaa8a143e35@oracle.com>
Date: Wed, 13 Mar 2024 11:44:07 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: nfsd hangs and nfsd_break_deleg_cb+0x170/0x190 warning
To: Rik Theys <Rik.Theys@esat.kuleuven.be>, Jeff Layton <jlayton@kernel.org>,
        Linux Nfs <linux-nfs@vger.kernel.org>
References: <55366184-94bb-4054-8025-1125db3788ff@esat.kuleuven.be>
 <aeb9e7b96161ac247c247b90c143935e80c7faf8.camel@kernel.org>
 <df8cc19c-f12c-4f7b-947a-4e21f8b97685@oracle.com>
 <80c412ac-ea74-4836-9dae-8be6e3aec0e6@esat.kuleuven.be>
Content-Language: en-US
From: Dai Ngo <dai.ngo@oracle.com>
In-Reply-To: <80c412ac-ea74-4836-9dae-8be6e3aec0e6@esat.kuleuven.be>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR13CA0113.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::28) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4257:EE_|CH0PR10MB5194:EE_
X-MS-Office365-Filtering-Correlation-Id: 36e129c7-399b-4093-b821-08dc438d9c31
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	JpZaBs3MTz6accgK0lsG3GhQvgS6uUYt6Lxa0zRztM1ZVWnRtnPDnYtuwD4+iAHbl6PuQWAFu5YIbDmHZGpvhUg4TgdB+Sx1bD8fFT2qa2QiE7T5D79X7Z/saWW2zs6Uahdky2yxWo40QFaMOmBsf7hUI2sndHjU0UZqLdsBI1kHg7muIrXxfdHfb41FwnRbTJGHa27FBqVhqN3CX/6mbHek5iXYo9x3kQq+Ty0qDMBiH4zsp/rNMIxJw/tnxwB75/R799owxCZS2+GIHlUSyTqBZvoaLCKywtPs31upFOhtfXjRHnikAKwrZRMsgbq7vkw3LKrEe6GRWxC7xmj5zOUZkHsCKRv6n6N1u8u9t/vpPSfhjJBcgTzVCpaE8ooit2Q+qgPH0NqWiILpKC1L9kwlSHJz0VWftLqU5dnh1FafikhCMdTcdqLYg4e79wY3HQuN+gGva2rVCzfbiM8xIkX/wrykUJbqzdJSUH6u86o/wOJ9WkzGoaWcXCAIjYj/IZCe7a/TlSiwwFLOaTjIkOdYAEuyFUpCDaLq/OgGjCTOacumjqM+mUsKx1PCcNxq/BgHd2jIGtbqNm0tnwgn/HeBB02wewKw8WA9rH1hxTJ4dVQBGJwUHHtmyuZn1aBuOJsIVH0yA0VSIooh0SjuVjXvXFrT7KpRAfTSzusNBbQ=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?VWFJU0dHK2dCazFOY0xta0NsQ0pIVVJSMmVReXBYdWRtS04zdzRoZUN4Tkx5?=
 =?utf-8?B?dWJrUnhPaU5WNWhVdm40bEZVN0M0Q2F3MlNYL3FGaUIrY0l3NG1PSzROVzZV?=
 =?utf-8?B?UHFVcC9VYyszcTFZWE5USEFZbEVVZ1lNOUtlWWFKRmJXWFhZaUdtdjhuSGkw?=
 =?utf-8?B?TXNEcDJWZTlHTzdRYyt3aGcrdU1zVDdBVUlwSmZoUXZoRlhJMldkUDNqcmlz?=
 =?utf-8?B?SEtEUzBLaHpyWkhDM1hIMUpacU5jZmZFTHFqU1BLYzBpY3pVWnhUSGVST044?=
 =?utf-8?B?ZVB3em43NjRIUGY5RjQ1TGZ2ZERjZHpQODgzYnFBREdmYkRaYnM0NTV0UWZj?=
 =?utf-8?B?cTBFSENFNUNzb0d3cGdFcGFNRTAzVHVVYURGaVVONnBVckFCTVdKT3RsUEVr?=
 =?utf-8?B?UU9rZjhRRVhRSFlSOXpBVzhORjhsc3EvMEVoT1Y4TTBOY2dNZmxrNXFnMjUr?=
 =?utf-8?B?R2haVnl5MjV2QmlTaUtMZXdTd2JBZmNKUjRsZ1NmK05hZks2OXB6YVRNclV2?=
 =?utf-8?B?ZHpKWU9xemNCSGNqOWxoL2szTU5ZbkppZHRmMEFPbUw0ZlVuakxnOVAxcjdY?=
 =?utf-8?B?TitCS1R2dTZBaDJuV2tDTEZYVlA5YkFsZ3RsYjJkVGFVNXN0TmdlV1ltTHNT?=
 =?utf-8?B?aEJwR0FHYTN1V2EyUjQ1bXVXeGZSSk1Kb0J2bU1mVTRxS0JYTFZITjREYzJT?=
 =?utf-8?B?RFZPdFlUaWtDb1hHTUhLVWJicytlTUxFOTV5Y1YyOHhQcWFCaDY0REJFcEE3?=
 =?utf-8?B?a0hCWmJRNmYwY2pnRnRicGRGNDQzU2V5MXgvSFhXWEZ2RFk3emFzRlJWK1RP?=
 =?utf-8?B?OSt5emV1ZmFQcjRxVVlObmRlTUZjK1R0WTRRVWt1cDFtcVpqU3UyRUpUM2V6?=
 =?utf-8?B?aGdZNGRlYW1SN1ZQeURUNDVpR2xqTzEwQUZCT0NEOEZ5enJuUEdBUGxxVzJD?=
 =?utf-8?B?MWNQc21ETTNsT1dCMHgyZE81NHhXUjFnbGJLUDUrMmkzK2cyaFlSU2FXd2xj?=
 =?utf-8?B?bHlQOTJHbjQ5c2RGZGNjMmFFcVdqK2Q4aFFEbERwT2NOTU1mKzVFWG93eHZk?=
 =?utf-8?B?YlFOVG9nREFRaDUxM0tPakRlQjhyV2dJWHBZWmg5U24yVUNGbE5xOWxGejJw?=
 =?utf-8?B?dVEzZ0hGcWVYYjZHZ1d4b3QxRXh2ZXUvY1QzcGRpajlzT0ZVZGpmV0hFRndp?=
 =?utf-8?B?Si9kQ2ZqcWdFdDc2MTlaL1pyZHE3RHBTQkd4SFFET05ESlFtazZNeUVzczRj?=
 =?utf-8?B?MThmWUNWOUVtN3BSSlBaRzVRK3UxOWFwSk5HVmlPb2hJbXFTZXp6MWJuUllI?=
 =?utf-8?B?L2FoUVNqeUZjZ1VMc2ZuV0Ztc2FRRi8wUElmWWg0NldoeWhLZlhYWVFBNlhR?=
 =?utf-8?B?WjdyNUtvWHZUNjBUa3dleWhIMjAwTnNHSWdhR2Rrdk1GTWRRdThmSElwZGhH?=
 =?utf-8?B?b0xOVEFRMnpWRitCUzEwb0M5dVhvakdROG9XWjZkeTFuZVVudWZTMS9BRWgw?=
 =?utf-8?B?cmpSaVJvS21KanJwZ3crQlJxVkhhYTN0UXN4TDF2QTJsUWVSRzNZTENPSGs3?=
 =?utf-8?B?NlVoVVdVU3hZY05WUWdST0F4NHhSYnpSdkt6QzJTUkpIYnFueVE4WGYzT2N4?=
 =?utf-8?B?QVhpeC8xVnNaWVAvL2VVc2R1NGxLMWM0blR0QW5sM2VxbVlXRGNLd242Z2Mv?=
 =?utf-8?B?MDBNaGtramFLN1ArM2RCaW5ON0xXRlNOdnRhaDBRUnBEeW1BYm5HNTErV0Zx?=
 =?utf-8?B?eUw2VnZyYlA3M1dEaG01QnhOV0Y4RFFTcllnc09NOGZEaVZoYVdmaTFIMCsy?=
 =?utf-8?B?NlhjdW9oRkdjWE1vNlUyM2dtbElYQmVFUG8xVTNIWmxvdDE4ekk1MVh6aE84?=
 =?utf-8?B?NGhrdVlRSmhrMk1EdzFhZWN2QU1xSU1uYmdvVnh5Nng0MUFWZHBhWlBORjFC?=
 =?utf-8?B?L3ZDRTlqRUl3UTZpSmtnOEF0Q3JDRm1ZRXVHUnRlNnlHcmV2TW1HR085dDIz?=
 =?utf-8?B?ZjN2Nm4raHdSUWg0SUZSWFBjLzBJZ1VsTVhOdzkzbEx0Qk5CVEowYTRZWUZs?=
 =?utf-8?B?T0dSM1d0RktKem0wMjVZNVRMMnF1MUhrNmVNT2c1ZFBWVXYxa3RhLyt0cWE1?=
 =?utf-8?Q?yOuP3n2hzVvtMTPhp0j1G+1aj?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	Qyvwjb/Wqc+z7oiBP4wjX6IWt/JbNA1NqF8vZxfBmLFoxKU3i+wWEfI1cli3pzM3ZzCTeCzf7e8Z4/HdnB6KQwgSz4lvuDNbT6/LJVCnJnaQm3PiRWB4r+zvdevU5em41vxvDUgiIYOXJUTR6zQTKOBbzvSAtniZXguEKXIh+NYNciHoMdInVxjFDo5iEUzpm83qpl4KS9sqWyH5klYWsMfdush7lNWbMBRz/VeiMYUlxKCyVQ2iISsItJEK8zuFZ03ymW7He2drOdv73ElJ1xd1lNwERSnJqT2B3I155N5GVlAYE94wxIdLZQzKLdoEyxr8f/wV+zdAiYdMuAu2UqaLq2Y+zs/d/z9t/U3mCzlo7w9L6kB3cYtsa425ONlyFT1+QdkWgD+32sgLY/JERNqW+OSjeRXwrrpV0cUa+ZbgrVjeul2Ca9E3hnKUNoSulquTMkADXOQATP/wOoIxBc1BxmbNgTYe5+6M/wZYx2mpNnsgIsMM0mCYBc4j+GIHSSrQOuFEb6hWpCUDjoUIYUq6W9+Am7QcukZrGfelJDX9yIaliTNscWrVTYFc7cshezPBohSd0wto5u657d/16l1BkJo8ZSOtn6A3lLYXnp8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36e129c7-399b-4093-b821-08dc438d9c31
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2024 18:44:27.1371
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NKTjUQfBGkiGl4ghB0IedcWPFTlF/rLicguL2LtbmJPZlK0KS021+C8qiNsJuOY2gwkcM/a6DqoXKrbC9hhjrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5194
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-13_09,2024-03-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 spamscore=0
 bulkscore=0 phishscore=0 malwarescore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2403130143
X-Proofpoint-ORIG-GUID: qyYeHTb93QJRQ8jTOcABS-WJxau21eF9
X-Proofpoint-GUID: qyYeHTb93QJRQ8jTOcABS-WJxau21eF9


On 3/12/24 11:23 AM, Rik Theys wrote:
> Hi,
>
> On 3/12/24 17:43, Dai Ngo wrote:
>>
>> On 3/12/24 4:37 AM, Jeff Layton wrote:
>>> On Mon, 2024-03-11 at 19:43 +0100, Rik Theys wrote:
>>>>
>>>>
>>>>
>>>> Hi,
>>>>
>>>>
>>>>
>>>> Since a few weeks our Rocky Linux 9 NFS server has periodically 
>>>> logged hung nfsd tasks. The initial effect was that some clients 
>>>> could no longer access the NFS server. This got worse and worse 
>>>> (probably as more nfsd threads got blocked) and we had to restart 
>>>> the server. Restarting the server also failed as the NFS server 
>>>> service could no longer be stopped.
>>>>
>>>>
>>>>
>>>> The initial kernel we noticed this behavior on was 
>>>> kernel-5.14.0-362.18.1.el9_3.x86_64. Since then we've installed 
>>>> kernel-5.14.0-419.el9.x86_64 from CentOS Stream 9. The same issue 
>>>> happened again on this newer kernel version:
>>>>
>>>>
>>>>
>>>> [Mon Mar 11 14:10:08 2024]       Not tainted 5.14.0-419.el9.x86_64 #1
>>>>   [Mon Mar 11 14:10:08 2024] "echo 0 > 
>>>> /proc/sys/kernel/hung_task_timeout_secs" disables this message.
>>>>   [Mon Mar 11 14:10:08 2024] task:nfsd            state:D stack:0 
>>>>     pid:8865  ppid:2      flags:0x00004000
>>>>   [Mon Mar 11 14:10:08 2024] Call Trace:
>>>>   [Mon Mar 11 14:10:08 2024]  <TASK>
>>>>   [Mon Mar 11 14:10:08 2024]  __schedule+0x21b/0x550
>>>>   [Mon Mar 11 14:10:08 2024]  schedule+0x2d/0x70
>>>>   [Mon Mar 11 14:10:08 2024]  schedule_timeout+0x11f/0x160
>>>>   [Mon Mar 11 14:10:08 2024]  ? select_idle_sibling+0x28/0x430
>>>>   [Mon Mar 11 14:10:08 2024]  ? wake_affine+0x62/0x1f0
>>>>   [Mon Mar 11 14:10:08 2024]  __wait_for_common+0x90/0x1d0
>>>>   [Mon Mar 11 14:10:08 2024]  ? __pfx_schedule_timeout+0x10/0x10
>>>>   [Mon Mar 11 14:10:08 2024]  __flush_workqueue+0x13a/0x3f0
>>>>   [Mon Mar 11 14:10:08 2024]  nfsd4_shutdown_callback+0x49/0x120 
>>>> [nfsd]
>>>>   [Mon Mar 11 14:10:08 2024]  ? nfsd4_cld_remove+0x54/0x1d0 [nfsd]
>>>>   [Mon Mar 11 14:10:08 2024]  ? 
>>>> nfsd4_return_all_client_layouts+0xc4/0xf0 [nfsd]
>>>>   [Mon Mar 11 14:10:08 2024]  ? nfsd4_shutdown_copy+0x68/0xc0 [nfsd]
>>>>   [Mon Mar 11 14:10:08 2024]  __destroy_client+0x1f3/0x290 [nfsd]
>>>>   [Mon Mar 11 14:10:08 2024]  nfsd4_exchange_id+0x75f/0x770 [nfsd]
>>>>   [Mon Mar 11 14:10:08 2024]  ? nfsd4_decode_opaque+0x3a/0x90 [nfsd]
>>>>   [Mon Mar 11 14:10:08 2024]  nfsd4_proc_compound+0x44b/0x700 [nfsd]
>>>>   [Mon Mar 11 14:10:08 2024]  nfsd_dispatch+0x94/0x1c0 [nfsd]
>>>>   [Mon Mar 11 14:10:08 2024]  svc_process_common+0x2ec/0x660 [sunrpc]
>>>>   [Mon Mar 11 14:10:08 2024]  ? __pfx_nfsd_dispatch+0x10/0x10 [nfsd]
>>>>   [Mon Mar 11 14:10:08 2024]  ? __pfx_nfsd+0x10/0x10 [nfsd]
>>>>   [Mon Mar 11 14:10:08 2024]  svc_process+0x12d/0x170 [sunrpc]
>>>>   [Mon Mar 11 14:10:08 2024]  nfsd+0x84/0xb0 [nfsd]
>>>>   [Mon Mar 11 14:10:08 2024]  kthread+0xdd/0x100
>>>>   [Mon Mar 11 14:10:08 2024]  ? __pfx_kthread+0x10/0x10
>>>>   [Mon Mar 11 14:10:08 2024]  ret_from_fork+0x29/0x50
>>>>   [Mon Mar 11 14:10:08 2024]  </TASK>
>>>>   [Mon Mar 11 14:10:08 2024] INFO: task nfsd:8866 blocked for more 
>>>> than 122 seconds.
>>>>   [Mon Mar 11 14:10:08 2024]       Not tainted 
>>>> 5.14.0-419.el9.x86_64 #1
>>>>   [Mon Mar 11 14:10:08 2024] "echo 0 > 
>>>> /proc/sys/kernel/hung_task_timeout_secs" disables this message.
>>>>   [Mon Mar 11 14:10:08 2024] task:nfsd            state:D stack:0 
>>>>     pid:8866  ppid:2      flags:0x00004000
>>>>   [Mon Mar 11 14:10:08 2024] Call Trace:
>>>>   [Mon Mar 11 14:10:08 2024]  <TASK>
>>>>   [Mon Mar 11 14:10:08 2024]  __schedule+0x21b/0x550
>>>>   [Mon Mar 11 14:10:08 2024]  schedule+0x2d/0x70
>>>>   [Mon Mar 11 14:10:08 2024]  schedule_timeout+0x11f/0x160
>>>>   [Mon Mar 11 14:10:08 2024]  ? select_idle_sibling+0x28/0x430
>>>>   [Mon Mar 11 14:10:08 2024]  ? tcp_recvmsg+0x196/0x210
>>>>   [Mon Mar 11 14:10:08 2024]  ? wake_affine+0x62/0x1f0
>>>>   [Mon Mar 11 14:10:08 2024]  __wait_for_common+0x90/0x1d0
>>>>   [Mon Mar 11 14:10:08 2024]  ? __pfx_schedule_timeout+0x10/0x10
>>>>   [Mon Mar 11 14:10:08 2024]  __flush_workqueue+0x13a/0x3f0
>>>>   [Mon Mar 11 14:10:08 2024]  nfsd4_destroy_session+0x1a4/0x240 [nfsd]
>>>>   [Mon Mar 11 14:10:08 2024]  nfsd4_proc_compound+0x44b/0x700 [nfsd]
>>>>   [Mon Mar 11 14:10:08 2024]  nfsd_dispatch+0x94/0x1c0 [nfsd]
>>>>   [Mon Mar 11 14:10:08 2024]  svc_process_common+0x2ec/0x660 [sunrpc]
>>>>   [Mon Mar 11 14:10:08 2024]  ? __pfx_nfsd_dispatch+0x10/0x10 [nfsd]
>>>>   [Mon Mar 11 14:10:08 2024]  ? __pfx_nfsd+0x10/0x10 [nfsd]
>>>>   [Mon Mar 11 14:10:08 2024]  svc_process+0x12d/0x170 [sunrpc]
>>>>   [Mon Mar 11 14:10:08 2024]  nfsd+0x84/0xb0 [nfsd]
>>>>   [Mon Mar 11 14:10:08 2024]  kthread+0xdd/0x100
>>>>   [Mon Mar 11 14:10:08 2024]  ? __pfx_kthread+0x10/0x10
>>>>   [Mon Mar 11 14:10:08 2024]  ret_from_fork+0x29/0x50
>>>>   [Mon Mar 11 14:10:08 2024]  </TASK>
>>>>
>>>>
>>>>
>>>>   The above is repeated a few times, and then this warning is also 
>>>> logged:
>>>>
>>>>
>>>>
>>>> [Mon Mar 11 14:12:04 2024] ------------[ cut here ]------------
>>>>   [Mon Mar 11 14:12:04 2024] WARNING: CPU: 39 PID: 8844 at 
>>>> fs/nfsd/nfs4state.c:4919 nfsd_break_deleg_cb+0x170/0x190 [nfsd]
>>>>   [Mon Mar 11 14:12:05 2024] Modules linked in: nfsv4 dns_resolver 
>>>> nfs fscache netfs rpcsec_gss_krb5 rpcrdma rdma_cm iw_cm ib_cm 
>>>> ib_core binfmt_misc bonding tls rfkill nft_counter nft_ct
>>>>   nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 nft_reject_inet 
>>>> nf_reject_ipv4 nf_reject_ipv6 nft_reject nf_tables nfnetlink vfat 
>>>> fat dm_thin_pool dm_persistent_data dm_bio_prison dm_bufio l
>>>>   ibcrc32c dm_service_time dm_multipath intel_rapl_msr 
>>>> intel_rapl_common intel_uncore_frequency 
>>>> intel_uncore_frequency_common isst_if_common skx_edac nfit 
>>>> libnvdimm ipmi_ssif x86_pkg_temp
>>>>   _thermal intel_powerclamp coretemp kvm_intel kvm irqbypass dcdbas 
>>>> rapl intel_cstate mgag200 i2c_algo_bit drm_shmem_helper dell_smbios 
>>>> drm_kms_helper dell_wmi_descriptor wmi_bmof intel_u
>>>>   ncore syscopyarea pcspkr sysfillrect mei_me sysimgblt acpi_ipmi 
>>>> mei fb_sys_fops i2c_i801 ipmi_si intel_pch_thermal lpc_ich 
>>>> ipmi_devintf i2c_smbus ipmi_msghandler joydev acpi_power_meter
>>>>   nfsd auth_rpcgss nfs_acl drm lockd grace fuse sunrpc ext4 mbcache 
>>>> jbd2 sd_mod sg lpfc
>>>>   [Mon Mar 11 14:12:05 2024]  nvmet_fc nvmet nvme_fc nvme_fabrics 
>>>> crct10dif_pclmul ahci libahci crc32_pclmul nvme_core crc32c_intel 
>>>> ixgbe megaraid_sas libata nvme_common ghash_clmulni_int
>>>>   el t10_pi wdat_wdt scsi_transport_fc mdio wmi dca dm_mirror 
>>>> dm_region_hash dm_log dm_mod
>>>>   [Mon Mar 11 14:12:05 2024] CPU: 39 PID: 8844 Comm: nfsd Not 
>>>> tainted 5.14.0-419.el9.x86_64 #1
>>>>   [Mon Mar 11 14:12:05 2024] Hardware name: Dell Inc. PowerEdge 
>>>> R740/00WGD1, BIOS 2.20.1 09/13/2023
>>>>   [Mon Mar 11 14:12:05 2024] RIP: 
>>>> 0010:nfsd_break_deleg_cb+0x170/0x190 [nfsd]
>>>>   [Mon Mar 11 14:12:05 2024] Code: a6 95 c5 f3 e9 ff fe ff ff 48 89 
>>>> df be 01 00 00 00 e8 34 b5 13 f4 48 8d bb 98 00 00 00 e8 c8 f9 00 
>>>> 00 84 c0 0f 85 2e ff ff ff <0f> 0b e9 27 ff ff ff be
>>>>   02 00 00 00 48 89 df e8 0c b5 13 f4 e9 01
>>>>   [Mon Mar 11 14:12:05 2024] RSP: 0018:ffff9929e0bb7b80 EFLAGS: 
>>>> 00010246
>>>>   [Mon Mar 11 14:12:05 2024] RAX: 0000000000000000 RBX: 
>>>> ffff8ada51930900 RCX: 0000000000000024
>>>>   [Mon Mar 11 14:12:05 2024] RDX: ffff8ada519309c8 RSI: 
>>>> ffff8ad582933c00 RDI: 0000000000002000
>>>>   [Mon Mar 11 14:12:05 2024] RBP: ffff8ad46bf21574 R08: 
>>>> ffff9929e0bb7b48 R09: 0000000000000000
>>>>   [Mon Mar 11 14:12:05 2024] R10: ffff8aec859a2948 R11: 
>>>> 0000000000000000 R12: ffff8ad6f497c360
>>>>   [Mon Mar 11 14:12:05 2024] R13: ffff8ad46bf21560 R14: 
>>>> ffff8ae5942e0b10 R15: ffff8ad6f497c360
>>>>   [Mon Mar 11 14:12:05 2024] FS:  0000000000000000(0000) 
>>>> GS:ffff8b031fcc0000(0000) knlGS:0000000000000000
>>>>   [Mon Mar 11 14:12:05 2024] CS:  0010 DS: 0000 ES: 0000 CR0: 
>>>> 0000000080050033
>>>>   [Mon Mar 11 14:12:05 2024] CR2: 00007fafe2060744 CR3: 
>>>> 00000018e58de006 CR4: 00000000007706e0
>>>>   [Mon Mar 11 14:12:05 2024] DR0: 0000000000000000 DR1: 
>>>> 0000000000000000 DR2: 0000000000000000
>>>>   [Mon Mar 11 14:12:05 2024] DR3: 0000000000000000 DR6: 
>>>> 00000000fffe0ff0 DR7: 0000000000000400
>>>>   [Mon Mar 11 14:12:05 2024] PKRU: 55555554
>>>>   [Mon Mar 11 14:12:05 2024] Call Trace:
>>>>   [Mon Mar 11 14:12:05 2024]  <TASK>
>>>>   [Mon Mar 11 14:12:05 2024]  ? show_trace_log_lvl+0x1c4/0x2df
>>>>   [Mon Mar 11 14:12:05 2024]  ? show_trace_log_lvl+0x1c4/0x2df
>>>>   [Mon Mar 11 14:12:05 2024]  ? __break_lease+0x16f/0x5f0
>>>>   [Mon Mar 11 14:12:05 2024]  ? nfsd_break_deleg_cb+0x170/0x190 [nfsd]
>>>>   [Mon Mar 11 14:12:05 2024]  ? __warn+0x81/0x110
>>>>   [Mon Mar 11 14:12:05 2024]  ? nfsd_break_deleg_cb+0x170/0x190 [nfsd]
>>>>   [Mon Mar 11 14:12:05 2024]  ? report_bug+0x10a/0x140
>>>>   [Mon Mar 11 14:12:05 2024]  ? handle_bug+0x3c/0x70
>>>>   [Mon Mar 11 14:12:05 2024]  ? exc_invalid_op+0x14/0x70
>>>>   [Mon Mar 11 14:12:05 2024]  ? asm_exc_invalid_op+0x16/0x20
>>>>   [Mon Mar 11 14:12:05 2024]  ? nfsd_break_deleg_cb+0x170/0x190 [nfsd]
>>>>   [Mon Mar 11 14:12:05 2024]  __break_lease+0x16f/0x5f0
>>>>   [Mon Mar 11 14:12:05 2024]  ? nfsd_file_lookup_locked+0x117/0x160 
>>>> [nfsd]
>>>>   [Mon Mar 11 14:12:05 2024]  ? list_lru_del+0x101/0x150
>>>>   [Mon Mar 11 14:12:05 2024]  nfsd_file_do_acquire+0x790/0x830 [nfsd]
>>>>   [Mon Mar 11 14:12:05 2024]  nfs4_get_vfs_file+0x315/0x3a0 [nfsd]
>>>>   [Mon Mar 11 14:12:05 2024]  nfsd4_process_open2+0x430/0xa30 [nfsd]
>>>>   [Mon Mar 11 14:12:05 2024]  ? fh_verify+0x297/0x2f0 [nfsd]
>>>>   [Mon Mar 11 14:12:05 2024]  nfsd4_open+0x3ce/0x4b0 [nfsd]
>>>>   [Mon Mar 11 14:12:05 2024]  nfsd4_proc_compound+0x44b/0x700 [nfsd]
>>>>   [Mon Mar 11 14:12:05 2024]  nfsd_dispatch+0x94/0x1c0 [nfsd]
>>>>   [Mon Mar 11 14:12:05 2024]  svc_process_common+0x2ec/0x660 [sunrpc]
>>>>   [Mon Mar 11 14:12:05 2024]  ? __pfx_nfsd_dispatch+0x10/0x10 [nfsd]
>>>>   [Mon Mar 11 14:12:05 2024]  ? __pfx_nfsd+0x10/0x10 [nfsd]
>>>>   [Mon Mar 11 14:12:05 2024]  svc_process+0x12d/0x170 [sunrpc]
>>>>   [Mon Mar 11 14:12:05 2024]  nfsd+0x84/0xb0 [nfsd]
>>>>   [Mon Mar 11 14:12:05 2024]  kthread+0xdd/0x100
>>>>   [Mon Mar 11 14:12:05 2024]  ? __pfx_kthread+0x10/0x10
>>>>   [Mon Mar 11 14:12:05 2024]  ret_from_fork+0x29/0x50
>>>>   [Mon Mar 11 14:12:05 2024]  </TASK>
>>>>   [Mon Mar 11 14:12:05 2024] ---[ end trace 7a039e17443dc651 ]---
>>> [Mon Mar 11 14:29:16 2024] task:kworker/u96:3   state:D stack:0     
>>> pid:2451130 ppid:2      flags:0x00004000
>>> [Mon Mar 11 14:29:16 2024] Workqueue: nfsd4_callbacks 
>>> nfsd4_run_cb_work [nfsd]
>>> [Mon Mar 11 14:29:16 2024] Call Trace:
>>> [Mon Mar 11 14:29:16 2024]  <TASK>
>>> [Mon Mar 11 14:29:16 2024]  __schedule+0x21b/0x550
>>> [Mon Mar 11 14:29:16 2024]  schedule+0x2d/0x70
>>> [Mon Mar 11 14:29:16 2024]  schedule_timeout+0x88/0x160
>>> [Mon Mar 11 14:29:16 2024]  ? __pfx_process_timeout+0x10/0x10
>>> [Mon Mar 11 14:29:16 2024]  rpc_shutdown_client+0xb3/0x150 [sunrpc]
>>> [Mon Mar 11 14:29:16 2024]  ? __pfx_autoremove_wake_function+0x10/0x10
>>> [Mon Mar 11 14:29:16 2024]  nfsd4_process_cb_update+0x3e/0x260 [nfsd]
>>> [Mon Mar 11 14:29:16 2024]  ? sched_clock+0xc/0x30
>>> [Mon Mar 11 14:29:16 2024]  ? raw_spin_rq_lock_nested+0x19/0x80
>>> [Mon Mar 11 14:29:16 2024]  ? newidle_balance+0x26e/0x400
>>> [Mon Mar 11 14:29:16 2024]  ? pick_next_task_fair+0x41/0x500
>>> [Mon Mar 11 14:29:16 2024]  ? put_prev_task_fair+0x1e/0x40
>>> [Mon Mar 11 14:29:16 2024]  ? pick_next_task+0x861/0x950
>>> [Mon Mar 11 14:29:16 2024]  ? __update_idle_core+0x23/0xc0
>>> [Mon Mar 11 14:29:16 2024]  ? __switch_to_asm+0x3a/0x80
>>> [Mon Mar 11 14:29:16 2024]  ? finish_task_switch.isra.0+0x8c/0x2a0
>>> [Mon Mar 11 14:29:16 2024]  nfsd4_run_cb_work+0x9f/0x150 [nfsd]
>>> [Mon Mar 11 14:29:16 2024]  process_one_work+0x1e2/0x3b0
>>> [Mon Mar 11 14:29:16 2024]  worker_thread+0x50/0x3a0
>>> [Mon Mar 11 14:29:16 2024]  ? __pfx_worker_thread+0x10/0x10
>>> [Mon Mar 11 14:29:16 2024]  kthread+0xdd/0x100
>>> [Mon Mar 11 14:29:16 2024]  ? __pfx_kthread+0x10/0x10
>>> [Mon Mar 11 14:29:16 2024]  ret_from_fork+0x29/0x50
>>> [Mon Mar 11 14:29:16 2024]  </TASK>
>>>
>>> The above is the main task that I see in the cb workqueue. It's 
>>> trying to call rpc_shutdown_client, which is waiting for this:
>>>
>>>                  wait_event_timeout(destroy_wait,
>>>                          list_empty(&clnt->cl_tasks), 1*HZ);
>>>
>>> ...so basically waiting for the cl_tasks list to go empty. It 
>>> repeatedly
>>> does a rpc_killall_tasks though, so possibly trying to kill this task?
>>>
>>>      18423 2281      0 0x18 0x0     1354 nfsd4_cb_ops [nfsd] 
>>> nfs4_cbv1 CB_RECALL_ANY a:call_start [sunrpc] q:delayq
>>
>> I wonder why this task is on delayq. Could it be related to memory
>> shortage issue, or connection related problems?
>> Output of /proc/meminfo on the nfs server at time of the problem
>> would shed some light.
>
> We don't have that anymore. I can check our monitoring host more 
> closely for more fine grained stats tomorrow, but when I look at the 
> sar statistics (see attachment) nothing special was going on memory or 
> network wise.

Thanks Rik for the info.

At 2:10 PM sar statistics shows:
kbmemfree:  1014880
kbavail:    170836368
kbmemused:  2160028
%memused:   1.10
kbcached:   140151288

Paging stats:
               pgpgin/s pgpgout/s   fault/s  majflt/s  pgfree/s pgscank/s pgscand/s pgsteal/s    %vmeff
02:10:00 PM   2577.67 491251.09   2247.01      0.00 2415029.61  75131.80      0.00 150276.28    200.02

The kbmemfree is pretty low and the caches consume large amount of memory.
The paging statistics also show lots of paging activities, 150276.28/s.

In the previous rpc_tasks.txt, it shows a RPC task is on the delayq waiting
to send the CB_RECALL_ANY. With this version of the kernel, the only time
CB_RECALL_ANY is sent is when the system is under memory pressure and the
nfsd shrinker task runs to free unused delegations.

Next time when this problem happens again, you can try to reclaim some
memory from the caches to see if it helps:

# echo 3 > /proc/sys/vm/drop_caches

-Dai




>
> We start to get the cpu stall messages and the system load starts to 
> rise (starts around 2:10 PM). At 3:00 PM we restart the server as our 
> users can no longer work.
>
> Looking at the stats, the cpu's were ~idle. The only thing that may be 
> related is that around 11:30 AM the write load (rx packets) starts to 
> get a lot higher than the read load (tx packets). This goes on for 
> hours (even after the server was restarted) and that workload was 
> later identified. It was a workload that was constantly rewriting a 
> statistics file.
>
> Regards,
>
> Rik
>
>
>>
>> Currently there is only 1 active task allowed for the nfsd callback
>> workqueue at a time. If for some reasons a callback task is stuck in
>> the workqueue it will block all other callback tasks which can effect
>> multiple clients.
>>
>> -Dai
>>
>>>
>>> Callbacks are soft RPC tasks though, so they should be easily killable.
>

