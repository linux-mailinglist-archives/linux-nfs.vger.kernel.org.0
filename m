Return-Path: <linux-nfs+bounces-2969-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B020C8AF7D3
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Apr 2024 22:14:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9805CB230D0
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Apr 2024 20:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27141142621;
	Tue, 23 Apr 2024 20:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AYcvGzeS";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="e0B+hJCp"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F951422C7
	for <linux-nfs@vger.kernel.org>; Tue, 23 Apr 2024 20:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713903243; cv=fail; b=OC1kiS5uGzdPBLMP6HmBTo8g8YscXstgFkdjJkL9cHwvCSgagY8NZ3l9/nMvonoaRq8CEr5W1RjCLHWVWSgJP4N0iwR4ZzpwpMqUez8+XvhyRtB5bwZ/Z+GR1TuQgPPo3V/5c9WpcAWH5T2G5L1vvRIGgSOH/EtikQGk9gbSvyU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713903243; c=relaxed/simple;
	bh=DqF+cNco53dbkTU6JsTucGqmYgo/Vfh+OitOwQcdqMM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DPVWNpaPBnVcQ6UQYB3VdQeEbY5m7c4ZhTmlPoBa96mG+/pdwIuxsqENH5k3Ox47l0EEzXxaHcF450P+wBEpvQ4I9xiQF9GNDGTxuPMLuhCSFveZHHSgkKS5l7Cvcw0JOPVsSazRmuzbeMZCe3RgzXZ4c3jXO9sWdCT8RLPR5A0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=AYcvGzeS; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=e0B+hJCp; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43NJdGVv017209;
	Tue, 23 Apr 2024 20:13:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=jIATb2faSgaGIs0HGv37st50qeA5XqO4sCgdJ3BYU14=;
 b=AYcvGzeSIcIR/huIeFATbQkH/SgBmfGB687iQCZn1L3QMc4NUQGL/16OgOGrOG+e8706
 rGaPSfGL7hlTwZ0WG/cEeHBwplGmM4G+QML2nWcI7wO6qC1aaCvDof2Xj6KhlBysODgt
 BVhvLd5xSt1KAf+0kDmflmRd5BbFqCjORxRGPrnPsH7m4FI565G4Px8nvb+9xZeZHWpI
 wONUHgqiYoC0mLYHY8f55DZMJty1q7dNdzWWEwOpsUpLU8e2Lm8Xrboqr5dsrEuD7F0A
 YNk+ltblmKu936yI2gXcoMlM2qyprZwoZAL061SUEXVaRf7l1RWeukATlVV0+x8PBRQT hw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xm4g4eb1k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Apr 2024 20:13:56 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43NJP677025241;
	Tue, 23 Apr 2024 20:13:56 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xm45e36ay-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Apr 2024 20:13:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pf/RqEnyyEsskTUNvNPlrArGbrp0rEXUkyehseDdSs3t5MeSTQjtD367SgsJg4NferjU9vKW93RPhXth27XX4FB+grIKrp1lM6iOAIuXMFzX1+GJhFw6JYS7yJCpAUHqBTxZPwtsS+dK2hlNBjCNQBpMXjp+ckPLntSjDMAbLFlJr83rOkbSavZ7eWUho/GFpKeS1Gypmm2PGaAntVRuSlugcb988qJd1BOceqd12FgebOIFzeGNZoVxSDwGItk145dz7qWQELQyJcWTPfHgutf2xJ6oCO7g50JdqHaLwAAsFm/ZqrvDZzEovk8aWDeSePhIAZKHyYo1NKD0e3blKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jIATb2faSgaGIs0HGv37st50qeA5XqO4sCgdJ3BYU14=;
 b=DZYsscwz0kZ2nJCiYYb1kPwJR/ID6YBZXmSOhk7MyF+jnfStoHdkQc3j9As6OaP2A554YI0MxYojSjPGn3aJWx/F8mDJsO+PsIGHqY3/wKXHob3lqU32uj7XO4odCFBS/dhZ46wReIaTMfwLKLvr+EWo60it/Rpso9x9DZRE/X90fMQ1S+86WzHsGbPuwIsT1hG5MhxQZJnGTtuWiyC0pLN9Xl7PVuK7fyab9ZXm9z6Dheuu4PTJEZIcpxAIcCSUfbrLgaBh2lTsX1EoyVHir6zkRWbzQ1IW4vd1qK0rwqRQZF26ZfpI6UrHAQ7R9WxCbFAQrajoViileVRdIQkVaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jIATb2faSgaGIs0HGv37st50qeA5XqO4sCgdJ3BYU14=;
 b=e0B+hJCpa5fJr0NtfLbc8Q5634oACQWtKz7JfCwxts96vP40hqi/iLjWBKU0s216nVdrG4xcGaUpEdx0lXz7iXnk5ecKeixK1k6BKObgUIGwmE+I2y1s/aI73rQpTaOjeE/9bkMRjq+MgW2y7WHJclViRVEVDn3Rekvbxl8iDf8=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by PH0PR10MB7027.namprd10.prod.outlook.com (2603:10b6:510:280::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Tue, 23 Apr
 2024 20:13:54 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::4c3a:47c2:806d:2e16]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::4c3a:47c2:806d:2e16%4]) with mapi id 15.20.7472.044; Tue, 23 Apr 2024
 20:13:53 +0000
Message-ID: <89688b35-f6dc-4103-8a13-ae4fe2865e19@oracle.com>
Date: Tue, 23 Apr 2024 13:13:47 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] NFSD: mark cl_cb_state as NFSD4_CB_DOWN if
 cl_cb_client is NULL
To: Chuck Lever <chuck.lever@oracle.com>
Cc: jlayton@kernel.org, linux-nfs@vger.kernel.org
References: <1713841953-19594-1-git-send-email-dai.ngo@oracle.com>
 <1713841953-19594-2-git-send-email-dai.ngo@oracle.com>
 <Zie6ochDV9VjumK4@tissot.1015granger.net>
 <d18e8b50-2eb1-419d-a937-9314ea39e08e@oracle.com>
 <Zif5B3fT5JA8GvEt@tissot.1015granger.net>
Content-Language: en-US
From: Dai Ngo <dai.ngo@oracle.com>
In-Reply-To: <Zif5B3fT5JA8GvEt@tissot.1015granger.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0672.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:351::10) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4257:EE_|PH0PR10MB7027:EE_
X-MS-Office365-Filtering-Correlation-Id: 75627b48-757e-4155-34dc-08dc63d1e5e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?Z2J4VjUydGNESnNLakhFdDlUbnd0NHVUbXROSXBGSTlRYi9sTWRaMGNZUUlz?=
 =?utf-8?B?eDZyOVhoZTVOWXR6UDZsS1F3TTZKRkx4b2xCeGhUYkVuYTQzSktrbHdZSSta?=
 =?utf-8?B?TVo0M3JIT1dJa0QxNTRmV1Q3RHQwYSszUGoyTmgzT0RROWlqK01aQ3ordVZz?=
 =?utf-8?B?aXlJVWJ0dW5iN3F1c1QveENZYUp6ZTZ0K1ltRUtuWVNuNVBLK0k5TVlDYU85?=
 =?utf-8?B?RktYU0ttWS9ZdWpxTkNQb2VxY0FiUldzcHlaZW5zUjJSSUpYWGtUTEdoa0RZ?=
 =?utf-8?B?Vi9TNjNWaldkblJYTHJ1S1ZQTU53cmZOV0VGYzdOQms4MU5BN0xTNjdHNXVI?=
 =?utf-8?B?NDBDUGJ5R01lWkljUEQ1WGZRdTh4cEY4N0VvYWFOYWQ5c1ZlUXlIeTQ1ZnV4?=
 =?utf-8?B?VkhsUkFlc3FBR0xIM2JqN29GanEwSE5GUW1XS1R1U3dWODB5TE55cGNaajht?=
 =?utf-8?B?aFU1MW01QTVlVit6aHZqbzdKcDJpbGZYY3ZMcEMxS2FXTlY4V2pReTFxQ1o5?=
 =?utf-8?B?dFRFN2xpR3BlVGdVZWZGVDArT3lHNmVDVWliWFVQMDhTemtiMElwWkk3bWpW?=
 =?utf-8?B?bHVhc3h1OC9lSzJZb0FadWdUQWt6SDlYTmNjcHJONWdGZXV3SExhbXp4SmNx?=
 =?utf-8?B?RkE5OS9NMTNQY3ZLK21kWi9CcU5iVTNHbFdRYlRPeHBwMWpzQnlmWTY1a0sy?=
 =?utf-8?B?bmVORkErT3dkR1loSGRFSUZIeDI3SjVGNlR1K1hDTGpvZVFzQktQaU5ObFU2?=
 =?utf-8?B?cmNQT2RqdVRvbWhjT1hXVUlZaWRqWnlOSEJ4d0ZzempFUG42UlVETTg4LzFu?=
 =?utf-8?B?eGw2bGxrYlJTa2ptMDBBN0tocmdianFtNWN1U0VaSkVsWFF5Zk5WOHBaeWtM?=
 =?utf-8?B?bFo5cEdXeHFXTnl3cy9jYWpYd0c5aS9XVmdXQVd2LytQbXd1VHVLMnNCaUdZ?=
 =?utf-8?B?VTVwSVZuTnBmSlIzbm9BOVJBQVY1RSs2YTZKMFR3d1VjZVp6bUg2bHZrRzFS?=
 =?utf-8?B?WnBrVTMvZkZ2YU9GaE9TSFd4cWdvMkZlbHlUM2pZY2ZDTWNnL2x0ZkZ5ZTNU?=
 =?utf-8?B?SVhUMGFVYXQrQVF5VC8wUThSeG5pQm4xRE40aUgreEs4YkhXTzRGaWRpMFdZ?=
 =?utf-8?B?Y3NaTzV4dnd5VHN4d2MwVXBtZHdjMEQ3RFg3RUtWTXF6V2pyWE9LVngwNHpB?=
 =?utf-8?B?S3doaSt0ZmxJelRPSEtIMTNuU1RENVBseGlZNTZPOGJ4RitXSm1HN0lEVU5L?=
 =?utf-8?B?YlVhTnQrbEZwYVowc0w2VG0xUTcxeE5GSmZiTk1OZyt6OXRjalRNOERGR2RZ?=
 =?utf-8?B?UlYyVzdnODNneHI0R2lIVlpTczFGeWtIWnRPeXZGK0h2bjJQa3dMRXJMakpL?=
 =?utf-8?B?Q0hxNGtaeVhyYmlpcDVGTUxlT0FXdVNlQlBBUGJiU1BrK3d0SjhxRXlVRUp1?=
 =?utf-8?B?SUk5RXZVcllodWZIYStKTlR0NUwvVkU3T2o5MWowclg1SnhFVmhDanlWeERm?=
 =?utf-8?B?TTZ5M0I4SVVhazhhUERqdDNxNjlTYzZkOUlOWDFsZ0VhZ2JvWWI0SVk0U3Q5?=
 =?utf-8?B?ak11aGdhT1NKZitFR0xWcjJSVzdjdkp3Szg0U0hzcVB6R0Q3UE1wdy9lbHlk?=
 =?utf-8?B?dDBicm41SWlMbkZXZU96bEFYUXg1UUtsZFlpbTdwOFVkRjc5MzhubTllM1du?=
 =?utf-8?B?Y2pVTTYzNGpWYkYzcUkrQkRHY0hUdVF3ZUNLMjV2SDR1UFM5QXN6YkJ3PT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?UW9waWU2a3gzNVNvbE1zWVQzcWV5enJEVS96OHh5MFlSNXMrYkU1WlVzS1di?=
 =?utf-8?B?N2xSTVkrWlgwaDRYWEloeld5WE1ZcXkyU3Q2VnlZMnMzVEdObmxjZ3lUR3M5?=
 =?utf-8?B?cmtTU1YxUkVuZUQxdHRSb2lHdm1iZUlidVJoejQ3OGdqcVIyVDNLbzY3ZkJj?=
 =?utf-8?B?YlVUZVBuZC9QL05BUUlXYXFWekVUdzFUaTVCdDVnSXF5Ylc5eXpkbEgzNU5N?=
 =?utf-8?B?Nlk4cVdPNVRGc0VTeUs0QmtnS3N3TE05RGJYYXY4Mk5Zb3hJK1RLUGpNdC9v?=
 =?utf-8?B?bW1aeENYN09vRFE2RW0rcWhTck1HekdXdjN3R01nK3dDdkREK1ZyTStkOG9k?=
 =?utf-8?B?WXd1YXM3Z0trbmZoRTBhNmhqNTZFemI2Qi84NHFLNStSRjlYWjQvcFJsWjNp?=
 =?utf-8?B?dC9PMFVWNlRLcDk2T25RSW1GMEdvakg3RG5lUkRZVGVkalV1RDlNeS9RenVr?=
 =?utf-8?B?RkMzMGNEYk5JSlhMTjJDMEVVU2hXUEhEcU9LZG1FaUhJYnBiQjlZSWE1RnJD?=
 =?utf-8?B?cjBhVXpCTU14cWR4b0l5OVAxVGo2Mk5Fcnh5RTN4NnFUWks2czBlQ2lMUUVw?=
 =?utf-8?B?TW5DUWJHMjUzeFh5M0R6RUU0ekMwbTg0YnluenErUjN2eis2Ty92cEpTRjF6?=
 =?utf-8?B?ZlhOS0VFWWk2S3dERGJpY3hmRWhHL2Q1TUxMS2pzbWF4OUpjYXliM1FYYUlL?=
 =?utf-8?B?dXdMZkZkK3JOc093K2FISFZqQjB0dDBSNGx1a3lKZ3ljc04yVE9vd1NXVmlH?=
 =?utf-8?B?czF5NHo3Z0ZVYzRpa0wrR2pPK01pYVFWcFlxOEx4Ly9oUnNWY21teGFDaDh6?=
 =?utf-8?B?WDhxSVA3L2VHaWU4TlRNSEJCd3MycHROcXJDbFRtWSsvVU5rSVVVS1ZNUWtI?=
 =?utf-8?B?SllXdDBLakxsUGNsaXRvVWJic2l4T1ZkYmdKL2N4eHlhT0l4TnZKRk1IeFhV?=
 =?utf-8?B?eVFtdHNhLzNmUkZrVDhYOXgzdEYzUW5STmhSSXVOSllXOS9NWTg3WDNmZFY5?=
 =?utf-8?B?VHY0RFlZeC96dDNvZlB0eGZhbXV1ZzcyRDh0ZXBtcW5GZVNENlc5RnM4NUpv?=
 =?utf-8?B?L3R5Tk5VOUFRY3h6SDcvRDRuenlpMmJ1U0dIcnpENHRyRzhWWkxNT1lyVjhH?=
 =?utf-8?B?TnFpaWRnSi9tMXYzcVN5YkdIUFRmdFZ0Wm85NTY5akJQNHg3QmxYZUxWemhw?=
 =?utf-8?B?Qk5RMzZlczM5dmJzYk9XNklKU3hUWGhZbHNRcFVBOHBIY0lnWm9ZMzlhQ1Vo?=
 =?utf-8?B?OFNiNXdObW1sQW5oZDh5QWdrclV5SmtBVEs3U05POWJHNlE4WUd5T0tvcmNT?=
 =?utf-8?B?U2k3WDg2czN6aktlVCt2NjhSR2tpRzZlZ3RzSWYvMmI1UFZjVmZ6eERBdU9N?=
 =?utf-8?B?TGJBOWVuNGlYNnNEa3BCQ2RDa2o5RVFXQTFRcDNnWDh3eDcxWko0YmRXUU1O?=
 =?utf-8?B?d3Y0TTA2NVJYdjYwUFdlK1FFYUxYRi9nVENXdEwyQnRDQVZVUmExSFIxSTFm?=
 =?utf-8?B?dU02cUEvanFTMElZSEpNQVlWWjRuT1ZZaHdyKzUyTXplOFhibExVVGhHNkpj?=
 =?utf-8?B?QnUzaitCalpVT3hNcjYvcTRRYXExTEViNElHRnRuZ2hSRkptNHdrSGd0SndM?=
 =?utf-8?B?RnRMN0xmY2hNU2ZIUUg5Z2p4ODF4TytLK0pXcXhFSWRSbUgvUlpnekhDdWUw?=
 =?utf-8?B?UXo2RU5GR2JkSFJSZ2lJckJQVVZvRkZiOUIzMStVY3RFMlJlVWFVVnNoNVIr?=
 =?utf-8?B?RXBJSVNvN3JqbmtGOERFUmF0Yk12dGEvVmtrMUhrUmtEekpTVHdjdG5LSFJs?=
 =?utf-8?B?SUhGb2ZXSHczMnJwR3RrZkw4WnBqSVFWeEQ1QXNjWXNhTS9IQUdOQUdrQm5i?=
 =?utf-8?B?dmZqb2RicVpiWTgxY2NXUkpsb1o0RVhwcVVaZ1RWY25obE5aY0tObkx0cnF2?=
 =?utf-8?B?T3ErWkNiczNKNlhRNnozcUJReEJmZTR4dXAyTHM4MkxvZDljRVk4SmRIbnJW?=
 =?utf-8?B?Z0JRT1phOW1MUVkwVEVOa2FTOUJVbkZ3L3c1cm1jV1dFY0Ntb2E0Tm1JWm0r?=
 =?utf-8?B?ZFVCNHhpVFVpOFFuUjBPWk1HRnhWT1BOZ2RtZnl1dTFWeWgwS2lFQ25jRm1Q?=
 =?utf-8?Q?KItNOwB81RjuA37BEOty91tLC?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	40SS2wOXrdBC3q4+DFxXNSKIF7rbbSslMDXJodEDCYwrq3E9xuKbKZpHihcA3MI5VK6PJ2BRppCmM9G+XMLQLVxIji4/eJcbyLgO05HoXZ+VYWW+/3k+FA/prZsMFQhF2ai6UyanNOggn0J38/YOVjQtNLAjB2T6hs5g+AAeB6PAxlybMdx8urVM8cGtUqG7RUEmTw8JpUALgpFQ8JhfQCIwn/DvGo3T6dOfWJjGba7VmPpStXIIw0pxfW4oayKr8qPTeCUp7Mq4nmL9PfqN+PFxG8Ht1ySLdkuibx7sX3+SsZSESoGAHp9n1hTGe6wjpztaKx1zKCMqvAcLeEoLWH+qzGx+dKu8KrZGZh7sYrLaW4Nj5Oq67FYTqXXIzFUWnECKOMeElzd+ntGKBeTZoci7/BA8wZ3Gu80U01S9bVPzqKIoscP36BwFpqclhQOj2Gh4QMVq9PiQje+cOVOGjolEy5vP1yPA7Pb3wQNTxVUNm6R/NgKqU1eqT0y1bFC0DLFyhfMGisbl2wRaks+X066VBELd2NLO4bkjlLbP82Qpe3jqkWW0ut9ieZlwmPblnc6BTIG4204Z+Osxbg7pfF4n4DK1SCFGNerXeZeHuBw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75627b48-757e-4155-34dc-08dc63d1e5e9
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2024 20:13:53.8985
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RIs6L+PBIwCpvBErh2d/v8o3Q5QDh6mcCUkjKpIXz0EKeKFQiHTfCcDMyU/R47WoRa/F7LRZyUf6lbuT8xHlZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB7027
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-23_16,2024-04-23_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 mlxscore=0 phishscore=0 spamscore=0 malwarescore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404230048
X-Proofpoint-GUID: H2M5iUZo4vRhqTYtdPtnO2y7FBOUttNH
X-Proofpoint-ORIG-GUID: H2M5iUZo4vRhqTYtdPtnO2y7FBOUttNH


On 4/23/24 11:08 AM, Chuck Lever wrote:
> On Tue, Apr 23, 2024 at 10:49:25AM -0700, Dai Ngo wrote:
>> On 4/23/24 6:41 AM, Chuck Lever wrote:
>>> On Mon, Apr 22, 2024 at 08:12:31PM -0700, Dai Ngo wrote:
>>>> In nfsd4_run_cb_work if the rpc_clnt for the back channel is no longer
>>>> exists, the callback state in nfs4_client should be marked as NFSD4_CB_DOWN
>>>> so the server can notify the client to establish a new back channel
>>>> connection.
>>>>
>>>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>>>> ---
>>>>    fs/nfsd/nfs4callback.c | 9 +++++++--
>>>>    1 file changed, 7 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
>>>> index cf87ace7a1b0..f8bb5ff2e9ac 100644
>>>> --- a/fs/nfsd/nfs4callback.c
>>>> +++ b/fs/nfsd/nfs4callback.c
>>>> @@ -1491,9 +1491,14 @@ nfsd4_run_cb_work(struct work_struct *work)
>>>>    	clnt = clp->cl_cb_client;
>>>>    	if (!clnt) {
>>>> -		if (test_bit(NFSD4_CLIENT_CB_KILL, &clp->cl_flags))
>>>> +		if (test_bit(NFSD4_CLIENT_CB_KILL, &clp->cl_flags)) {
>>>>    			nfsd41_destroy_cb(cb);
>>>> -		else {
>>>> +			clear_bit(NFSD4_CLIENT_CB_KILL, &clp->cl_flags);
>>>> +
>>>> +			/* let client knows BC is down when it reconnects */
>>>> +			clear_bit(NFSD4_CLIENT_CB_UPDATE, &clp->cl_flags);
>>>> +			nfsd4_mark_cb_down(clp);
>>>> +		} else {
>>>>    			/*
>>>>    			 * XXX: Ideally, we could wait for the client to
>>>>    			 *	reconnect, but I haven't figured out how
>>> NFSD4_CLIENT_CB_KILL is for when the lease is getting expunged. It's
>>> not supposed to be used when only the transport is closed.
>> The reason NFSD4_CLIENT_CB_KILL needs to be set when the transport is
>> closed is because of commit c1ccfcf1a9bf3.
>>
>> When the transport is closed, nfsd4_conn_lost is called which then calls
>> nfsd4_probe_callback to set NFSD4_CLIENT_CB_UPDATE and schedule cl_cb_null
>> work to activate the callback worker (nfsd4_run_cb_work) to do the update.
>>
>> Callback worker calls nfsd4_process_cb_update to do rpc_shutdown_client
>> then clear cl_cb_client.
>>
>> When nfsd4_process_cb_update returns to nfsd4_run_cb_work, if cl_cb_client
>> is NULL and NFSD4_CLIENT_CB_KILL not set then it re-queues the callback,
>> causing an infinite loop.
> That's the way it is supposed to work today. The callback is
> re-queued until the client reconnects, at which point the loop is
> broken.

As you mentioned below, this needs to be reworked.

What if the client never comes back, decommissioned or student hibernates
the laptop and opens it up few days later. Even when the client comes back,
it might have been rebooted so the callback does not mean anything to it.

>
>
>>> Thus, shouldn't you mark_cb_down in this arm, instead?
>> I'm not clear what you mean here, the callback worker calls
>> nfsd4_mark_cb_down after destroying the callback.
> No, I mean in the re-queue case.

In the case of re-queue, the back channel is already marked as NFSD4_CB_DOWN
and cl_flags is NFSD4_CLIENT_STABLE|NFSD4_CLIENT_RECLAIM_COMPLETE|NFSD4_CLIENT_CONFIRMED:

Apr 23 08:07:23 nfsvmc14 kernel: nfsd4_run_cb_work: NULL cl_cb_client REQUEUE CB cb[ffff888126e8a728] clp[ffff888126e8a430] cl_cb_state[2] cl_flags[0x1c]

but that does not stop the loop.

>
>>> Even so, isn't the
>>> backchannel already marked down when we get here?
>> No, according to my testing. Without marking the back channel down the
>> client does not re-establish the back channel when it reconnects.
> I didn't expect that closing the transport on the server side would
> need any changes in fs/nfsd/nfs4callback.c. Let me get the
> backchannel retransmit behavior sorted first. I'm still working on
> setting up a test rig here.

Thanks, I will wait until you sort this out.

-Dai

>
>

