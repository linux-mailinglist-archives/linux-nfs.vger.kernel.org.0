Return-Path: <linux-nfs+bounces-2588-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 94BC88945C9
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Apr 2024 21:55:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2242A1F21574
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Apr 2024 19:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 902F053814;
	Mon,  1 Apr 2024 19:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bQfZtOUb";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="V1MiJmGi"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FC7F3A1C2
	for <linux-nfs@vger.kernel.org>; Mon,  1 Apr 2024 19:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712001328; cv=fail; b=qnj4YeVgu4LPntlqGW0PcHpUyi4Z2KxctTrkEa2jImX2Z18lmHlHOmVMtv3YzEzmqXITRooaJW74w2kQ99XOnbLh5DobX7mlfgYBT/XIz1b9vdDWYQ696UsSLOlwj9cr9hbB/gGV0T3lax8O5ewm9rBRiK8WtKWHCxF4bAXX3EU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712001328; c=relaxed/simple;
	bh=SIPZQ7lWMeyVNMs6u1Ryh1OyY0t06TeAs00o9HsCPnM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VH+XKiMZ8z7zXhn7txlpZUB0/4ouGjokMAiQQRDMh/+bolr9V+kmvvgFGNH6Ncm8fP/jTPBTw5i+bS5DJNt47Zjx5cCS/GqAQ7SHlMgV0oERmQUy/pp7n0qUcBtTr+sTGqMCHvhuBRDBdKXzXZHgRuoGxrNvcO3FXI5gI9P1Nuc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=bQfZtOUb; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=V1MiJmGi; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 431HuVnZ027643;
	Mon, 1 Apr 2024 19:55:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=yXVgQmrpECfbN4CbZH5cyydMPfjRwa7hvEZcRJhVUiE=;
 b=bQfZtOUbLYf4j9gJRnUxPyn5XZKN7FaKivq1E+MxpiFn5KOzygHfBZPA9/2mhRWp4H9l
 y5jiMLg5o2EpIAjC/5Ukkj8an6EnY6qV0UktGkbdNvMbR8mht/O5cI4dzAVSRA9hrpMH
 EpOFxz/++aftk/FJkIHICZxrAvJp3JE7xdDy/DoBnc0MufSvC5l4e7b+Dksb52bEb5Id
 aa4YXr48dbW8qjHTcdZxXsVWI6AgfvY6y6sL9FCOTbyPd2v4wbX/473YfoggVy2qwz8B
 7JD8TLSy8A436cUA6p2J71q4NoxLgidnO2ltruVytZUb6q8oqrHtov9GUQ3OnUqPy/0C JQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3x6abub4gh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 01 Apr 2024 19:55:21 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 431I0ENj017990;
	Mon, 1 Apr 2024 19:55:21 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2040.outbound.protection.outlook.com [104.47.74.40])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3x696c2xju-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 01 Apr 2024 19:55:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YqXFwzMd6tPkNFzb/pmNBGEpFyCi3PF5jfixNPbsbtrS8ieDUB+uNtyKy+CzGLtjQHM2f1ZbqksjFti9WDBQBewTZ9dBdM1wep9FEbBa/fNVBkCM1JAKQs/PRhlM2STucrWhFYgpUD4Eez1g5uqp+b7Etp5a3EMM8f+CyTGZCnzDuk7fAIn+Su2ttRCNCqba4U7p3z51cshBX+kaH732jnJLscwm5mC0Ea9iQ+gElFRe2LcZBBEFfgRlhW3t5IWLvprOrp6Y1rS7y6Wu+xIyZyERarHoPQS3EcWXgZ760yELUQuDJeEM8NTFHaQM4Gh+3zr5SVSaFSW0Z9keiaT1Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yXVgQmrpECfbN4CbZH5cyydMPfjRwa7hvEZcRJhVUiE=;
 b=X3RC44TN/GvJvB25tGPWstukCCrQfHWaXKYwroAl6m/VwSYlCiP9e2Tek4e02e4mrHHjgeqURslc2qkDo09grn0iO22Am7awlof55To00O5LfVWB++r4rBxybpqZRunOhM9PZCyANi3NwM4qgAnwBMzB/wRKTL3PFBddGobo72YONe9ScryqikZ3XbZLCU28917v6vAdO9+8aZZcJlQ91l9DJI7p/UYsGYQfYHbNIPtcKlHA5aSxiYUso2pqfzpEq5doOuLlPilB7akybGQ3CSvqc10RcI+RuguZd6AdTi470LqzXQNCH4SSJiUEqrKpKHHTasFJjBAOeYqF9uj4Vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yXVgQmrpECfbN4CbZH5cyydMPfjRwa7hvEZcRJhVUiE=;
 b=V1MiJmGi6SO/B2RUm1ytuAbJ6azFLgH6LsZOUIBVFi1yYMVXGqznnAPpuHUj9X2AgfNKcLCFRTA94vLUofTL9B25Ncpte31+uwqdX6GFjFzOheDTgWG910Ey6/7Gl/zAm3FAnNGbbg/w3TkYLZp4y6gC5nmkCsaGkHP9vndk+uY=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by MW4PR10MB5884.namprd10.prod.outlook.com (2603:10b6:303:180::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Mon, 1 Apr
 2024 19:55:18 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::b7ab:75e7:2cf9:efc3]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::b7ab:75e7:2cf9:efc3%3]) with mapi id 15.20.7409.042; Mon, 1 Apr 2024
 19:55:18 +0000
Message-ID: <86dd7031-744d-4448-96ed-6d3d9c2e49b0@oracle.com>
Date: Mon, 1 Apr 2024 12:55:16 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] NFSD: cancel CB_RECALL_ANY call when nfs4_client is
 about to be destroyed
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org
References: <ZgbWevtNp8Vust4A@tissot.1015granger.net>
 <97387ec5-bcb4-4c5e-81af-a0038f7fc311@oracle.com>
 <ZgdR48dhdSoUj+VM@tissot.1015granger.net>
 <09da882f-4bad-4398-a2d0-ef8daefce374@oracle.com>
 <ZghZzfIi5RkWDh9K@tissot.1015granger.net>
 <84d6311e-a0a3-4fc6-a87e-e09857c765b3@oracle.com>
 <039c7e38b70287541849ab03d92818740fdf5d43.camel@kernel.org>
 <Zgq365RJ9M5qsgWY@tissot.1015granger.net>
 <5108ca5a-b626-4ae9-a809-ae3fffb50cab@oracle.com>
 <a30b343f-b6cf-4566-9565-28a5fd5ca851@oracle.com>
 <ZgrzwVp4GrbmZGWt@tissot.1015granger.net>
Content-Language: en-US
From: Dai Ngo <dai.ngo@oracle.com>
In-Reply-To: <ZgrzwVp4GrbmZGWt@tissot.1015granger.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR13CA0089.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::34) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4257:EE_|MW4PR10MB5884:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	cIdqHtn5sRQ1dvUeL9Z8Ln3o06+JfQmiCdDmFcwzpowp5gsRXt/puJa5eyLcIpiZNoH1ppfZ/4b8v+V+3uoLqUTrWJ2HeRDjVXocVnot0LgmUIzgPnLx+VYyNdU1WIOMBp9/mFHG5CMBnKBcuVUtwPByeqAFVunFWEfvcOT73tPmi6DCLXqYZoBnyklaa1GSQw9wAVmMeNZw8uqpzPXSnF/rS1WUUt4WL1eaB39tqVwRMdkD8H7yl/BoQ2lP5Z77tGGGoz5xPZUN0vHNJN5B5RVrDboFffGYfBtAmPRbO0mrtqM7P5dSQFA8UoTfpOAKdVWDlclLpOsHE07Sbywg1gdlNd0hTbU99JutUYiHS22mamO6RKjo5HHF7G2DL84dcaHuNGGvyXEte4G7B/vnVxVlfK1PO4XQAIumTSOuCify4ukLRYN2DLx0/AOibpCUOghP8+evirtrNsm5zRjY+7zDaSqgBKeU892htAphYG8JgYEBJVH5gRwBxStGbzDZbFsQP8g7E240qkeJ+kaKl9e3oyfvMknEQXFBk6Ejn/c8KBq6AEoqMtELfwnaCG2gR+1/bM8pXxDI0KKCitu6p2usJ/trh9h4lUD/8fyudBxvD2vEzSty1ArH6L7PW6s4hQG0no6IndXgFIFA2pyZyc8cApUJR6/YW4l9YM7StKo=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?YklEblBRQmdFb3VmRGE0dUo4RVVrMXl2dkdWMHkvVzE5K3lSTUdqUlJ1eEp4?=
 =?utf-8?B?S0NETGY1dmJkNExtZHJQakVGNlRVY0t4NVY5VkdJbHRGamVjbytyZFMvSkVD?=
 =?utf-8?B?QVRtZ0xMc2x0RDA2VUJxTTdua0ZBOWR0ejZOdGxEZ1JnWWFoUURERjlrdE5w?=
 =?utf-8?B?VUNzc2NRZTVSMEVhdUFvN3lUdk5RcDM4R3FGbEVRRnI5VXpFNGlXUXVnR3RN?=
 =?utf-8?B?T3RXaTVrbzRIVWN3cVI4MW11RTRWZ3B4VkZEWWVWUjhGSE5jd2VuSWRWUE53?=
 =?utf-8?B?dFlTNkhwRGdoYUJTTTM3ZXBCMlRRcXRrQmVibG8wTlRRUjU1M1p1Qmp3WTZY?=
 =?utf-8?B?T2dXd1RpS2FmWEU0YU9QSlJDblUzRFhRaElPVlhoa2lhT0lvS1htUVhjL3NE?=
 =?utf-8?B?VHNLamZyZ0tJRzc1RG5KcmFHTkpxcXJGVVdSZWU3WDloQkNuT0lLTHFBVXN2?=
 =?utf-8?B?TmFqTllIMVVEaTZTTWVINlRwK0NybUN1WTlEeHJ0YXIrTzM3dU9haFJmVzd5?=
 =?utf-8?B?NVJpdDFoNC9OMGVlK1lsRnJRbXhBMGU5b0NyWndHQmtEVTZZUlh6eGpnTk1D?=
 =?utf-8?B?UksweEI5QWtIaHVDaDRGUTlxbHNGTkxDVkpmRnkxVVk5SXE3S2dITW5iSlUr?=
 =?utf-8?B?QzVPY3VSSC9sZHpjYklENEp6akxnL0haUm16WlZuS3BZRGxnVzlBYjBzbDZr?=
 =?utf-8?B?bElqVTZVS3hwMGxRWk5NYXBicXNFYXQveEVFM2VwbXp3Q3VPeFMyRGRoYmVs?=
 =?utf-8?B?U2ZOVjRnQldobmxOaTRZbEVGN21NOHAzRmgveVZXSHFIVkFzbThyd3ZlZm5C?=
 =?utf-8?B?dXpjTVlCdEdpTTd1QlVMLzhWcmRadUFWOVU4Sm5mT2xMRVZEaG1Ic0lFaWM0?=
 =?utf-8?B?ZE9oRm1rNW1MMFE3WldlNFBHdjJLai9ZZ2IrTkNQWUNZSkpRRkRjeDVuRms1?=
 =?utf-8?B?M0VqQTk4N0JtSkliSVM5V1J0VkRzOWI2dUdmd1lBNHg1OVlWVE0yN1dWZ2FK?=
 =?utf-8?B?RHNDdWlBVEFLekN6cCtCS1JqZ3NWS3RjWEk1dFFRQ1hpZjZDV0lCa1JFN3Ry?=
 =?utf-8?B?cHRaUHJmSlFaMmNrYlB3ZjFxRjRxdEhyN3A1a2tsRFN3NUsvZ3hpN094SEFj?=
 =?utf-8?B?MUZ6K20vQWNjTkROVGRTNTNVRk5sd1ErVFBXUVNvdXBwZkFaQ0FZanNLQWM2?=
 =?utf-8?B?YmV0bi91cVYzVndRNkd1c0dPdlZ3UjArV0hVSmx0WjM5L2ovMTZUTEMxdFcr?=
 =?utf-8?B?alQvcit5WW4wN1JvWHFuOTBxNnVPMkt4WlRRL0c1Wkg3ZzU1ams3SXZSYTlq?=
 =?utf-8?B?RHBraWxGeFRudEpJd1RLU3FLYnU2a0tjWGp3dGdWSlE4NjczR0ozYmVTNklp?=
 =?utf-8?B?MVpnQ2JoUzV6TUlUL3VnMzJGVWtpZFNJdFNFRjQwNlBHSURrd2kvS1JvQkRj?=
 =?utf-8?B?ODVrRTdSVE9lc2NPSml4QVNiTUhOWFNMZkJybDh5WFdlVFE1ZTNuMlp6bW5n?=
 =?utf-8?B?VU5mZGczendyYXp0VTYyc1ByUElqckxCMEU1SW05QUV3VE93QVNtS0M2cEVS?=
 =?utf-8?B?RUVlbi9EVnVWdjNwTFk5b2pBNmZCR0dkKzkzWjdzKzkxNGFPemNYS2EzUzBX?=
 =?utf-8?B?T2R4VW12ZkR4dkl6S2VlZTdtbVBYTDUrL3UzV3Q3dS82blVlK3hQNVJjN0Vq?=
 =?utf-8?B?SHN1akhTM3JldCtyRmJSM2g5bzg4bldxMWREd1hpbVRpQU1BOFRKS0o5Zk5M?=
 =?utf-8?B?cXo0a05XdXJYZWRqcWt6eGFBdzF6NVU1TXlLbzQ1TTdrbVRKc3ViZEYvWkhZ?=
 =?utf-8?B?dU9oazhRTWxZVnIxOFRFYWRDcjkxTmZCbEx2eVkzWFZwSGFXdWlrd1N2cElK?=
 =?utf-8?B?TW54K0czbnMrOWZCNDlBdjY2WURONldEcnFZZC8yZ0NWZXpvMEFubFNTbFkv?=
 =?utf-8?B?VERNaXkrcVZISGJsR3lLRVlHdmp0QTlQUVM4dlY1R3QrazVJRWVuYlNQSWwv?=
 =?utf-8?B?V0NoRVd3c3JIaUdmOUpQMHNRbGw4RTFxVnlNWDg5NE9rNUJ4aFdQbmQ3T2Yr?=
 =?utf-8?B?M09aRFJ1S1pRNGFUTk5WYmQ3WXhFeUVxZllVbU5KQW1VUzhCS0MrZVZtaHBa?=
 =?utf-8?Q?9b+PVwqpkdMaeoPAfVCd86RR5?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	ZAg7UxG2KSqsg/OMoArFt0aXkwjw8aEKSVVTUA0H1lk99xXzeX2iooLM1gBXim2qQXKVdZYjDBIc/uNrATFjYy8whMEthESXkV8l4ejRPJ3ubNBXPS+zHBjn3c6EImQDMd1Et9NNbaYpsPA1JDdunOhzEIV53aNIbbb7A7JLzniQ0GY4Nk421BDX9SZ6WpxOuuFH3iHmtIrRJOoGebSEYdJHO9dyyK0Y6mDwG4Lq3jPGzW1SaiWYmdqaKbNuFkBs30rSkoLSDbQFIu8XYbrAUoxQ+GAF8o2Lly69JOA8xWMszPnYmz6dfVJkSaau/yGzipBsrp8Tw36XJitgvcokXBRIrGStkary/QzA0l8Wd1XSFn8jnkVldy/FdsqVC8IujnhwxhkvKThg50VlBx2ovi3gBD8q58cHCyDRyyxp8z85OhEGFZnhT7cBWoUN14ndq2/Kkf2b2RTbQ3GTKDMBycEksb9mrqmPWY/HzsaDGyM35mLultLmSOBghaJkW2oGoFFHlHmVwBjY5iUafTjqaJqKDCI2+VlFUz7tOeEbQ9c1gKaV8unLT9I3dn0TcNNDJ/tM5SSm/Z+fG8ZEgAtBwEMdaOyAE1QTaZVDqyBuKMA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e1db4c8-f4b2-46a3-a2f6-08dc5285a806
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2024 19:55:18.4681
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zfl9qeBbQ926aTmHPd3GiCGqqjxqdlswBG+7XwZqkgxGwcOvMNVAEEQ+v9ORHh4YDAd8lcCJjPLZL0w41XPO7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5884
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-01_14,2024-04-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 spamscore=0
 bulkscore=0 adultscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2403210000
 definitions=main-2404010138
X-Proofpoint-ORIG-GUID: n-BZ47nS3kkXMfRzGxHgdw3J5WIgHrxv
X-Proofpoint-GUID: n-BZ47nS3kkXMfRzGxHgdw3J5WIgHrxv


On 4/1/24 10:49 AM, Chuck Lever wrote:
> On Mon, Apr 01, 2024 at 09:46:25AM -0700, Dai Ngo wrote:
>> On 4/1/24 9:00 AM, Dai Ngo wrote:
>>> On 4/1/24 6:34 AM, Chuck Lever wrote:
>>>> On Mon, Apr 01, 2024 at 08:49:49AM -0400, Jeff Layton wrote:
>>>>> On Sat, 2024-03-30 at 16:30 -0700, Dai Ngo wrote:
>>>>>> On 3/30/24 11:28 AM, Chuck Lever wrote:
>>>>>>> On Sat, Mar 30, 2024 at 10:46:08AM -0700, Dai Ngo wrote:
>>>>>>>> On 3/29/24 4:42 PM, Chuck Lever wrote:
>>>>>>>>> On Fri, Mar 29, 2024 at 10:57:22AM -0700, Dai Ngo wrote:
>>>>>>>>>> On 3/29/24 7:55 AM, Chuck Lever wrote:
>>>>>>>>> It could be straightforward, however, to move the callback_wq into
>>>>>>>>> struct nfs4_client so that each client can have its own workqueue.
>>>>>>>>> Then we can take some time and design something less brittle and
>>>>>>>>> more scalable (and maybe come up with some test infrastructure so
>>>>>>>>> this stuff doesn't break as often).
>>>>>>>> IMHO I don't see why the callback workqueue has to be different
>>>>>>>> from the laundry_wq or nfsd_filecache_wq used by nfsd.
>>>>>>> You mean, you don't see why callback_wq has to be ordered, while
>>>>>>> the others are not so constrained? Quite possibly it does not have
>>>>>>> to be ordered.
>>>>>> Yes, I looked at the all the nfsd4_callback_ops on nfsd and they
>>>>>> seems to take into account of concurrency and use locks appropriately.
>>>>>> For each type of work I don't see why one work has to wait for
>>>>>> the previous work to complete before proceed.
>>>>>>
>>>>>>> But we might have lost the bit of history that explains why, so
>>>>>>> let's be cautious about making broad changes here until we have a
>>>>>>> good operational understanding of the code and some robust test
>>>>>>> cases to check any changes we make.
>>>>>> Understand, you make the call.
>>>>> commit 88382036674770173128417e4c09e9e549f82d54
>>>>> Author: J. Bruce Fields <bfields@fieldses.org>
>>>>> Date:   Mon Nov 14 11:13:43 2016 -0500
>>>>>
>>>>>       nfsd: update workqueue creation
>>>>>            No real change in functionality, but the old interface
>>>>> seems to be
>>>>>       deprecated.
>>>>>            We don't actually care about ordering necessarily, but
>>>>> we do depend on
>>>>>       running at most one work item at a time: nfsd4_process_cb_update()
>>>>>       assumes that no other thread is running it, and that no new
>>>>> callbacks
>>>>>       are starting while it's running.
>>>>>            Reviewed-by: Jeff Layton <jlayton@redhat.com>
>>>>>       Signed-off-by: J. Bruce Fields <bfields@redhat.com>
>>>>>
>>>>>
>>>>> ...so it may be as simple as just fixing up nfsd4_process_cb_update().
>>>>> Allowing parallel recalls would certainly be a good thing.
>>> Thank you Jeff for pointing this out.
>>>
>>>> Thanks for the research. I was about to do the same.
>>>>
>>>> I think we do allow parallel recalls -- IIUC, callback_wq
>>>> single-threads only the dispatch of RPC calls, not their
>>>> processing. Note the use of rpc_call_async().
>>>>
>>>> So nfsd4_process_cb_update() is protecting modifications of
>>>> cl_cb_client and the backchannel transport. We might wrap that in
>>>> a mutex, for example. But I don't see strong evidence (yet) that
>>>> this design is a bottleneck when it is working properly.
>>>>
>>>> However, if for some reason, a work item sleeps, that would
>>>> block forward progress of the work queue, and would be Bad (tm).
>>>>
>>>>
>>>>> That said, a workqueue per client would be a great place to start. I
>>>>> don't see any reason to serialize callbacks to different clients.
>>>> I volunteer to take care of that for v6.10.
>> Since you're going to make callback workqueue per client, do we still need
>> a fix in nfsd to shut down the callback when a client is about to enter
>> courtesy state and there is pending RPC calls.
> I would rather just close down the transports for courtesy clients.
> But that doesn't seem to be the root cause, so let's put this aside
> for a bit.
>
>
>> With callback workqueue per client, it fixes the problem of all callbacks
>> hang when a job get stuck in the workqueue. The fix in nfsd prevents a
>> stuck job to loop until the client reconnects which might be a very long
>> time or never if that client is no longer used.
> The question I have is will this unresponsive client cause other
> issues, such as:
>
>   - a hang when the server tries to unexport

exportfs -u does not hang, but the share can not be un-exported.

>   or shutdown

shutdown does not hang since __destroy_client is called which calls
nfsd4_shutdown_callback to set NFSD4_CLIENT_CB_KILL.

echo "expire' > /proc/fs/nfsd/X/ctl does hang since it waits for
cl_rpc_users to drop to 0. But we can fix that by dropping the
wait_event(expiry_wq, atomic_read(&clp->cl_rpc_users) == 0) and
just go ahead and expire_client likes shutdown.

>   - CPU or memory consumption for each retried callback

Yes, the loop does consume CPU cycles since it's rescheduled to run
after 25ms.

-Dai

>
> That is an ongoing concern.
>

