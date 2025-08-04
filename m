Return-Path: <linux-nfs+bounces-13417-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02EF3B1AA01
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Aug 2025 22:13:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2EB9417D9CD
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Aug 2025 20:13:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93DE021D5BC;
	Mon,  4 Aug 2025 20:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Ehd8MqvV";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="J4p5kWDq"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD7EC16F8E9
	for <linux-nfs@vger.kernel.org>; Mon,  4 Aug 2025 20:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754338432; cv=fail; b=m9nLgPV7cW7+uIHBklM6rNqPHMMwxbnf63ZS3zfSgaiQsLqqRMJTc0BrT0XyHVk3mxTwLDQfkk2VmJcTzJ1fcGzBE1rJnMNyKKKOUnyuC8sURtUJulxV0fpcw6uBKRHWiQeXvjXRuZP8vY5mBbu0DWfwqgb7UeEisOdlYB4fSW4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754338432; c=relaxed/simple;
	bh=s5caUaxMhw+LxZYDUUOfTYkYfSiqq5q7h2j9b5bStTc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lxoEW56DGYLbwolT0DpE3gl+Zns6+ZUrhT0SBIgVLV5TCkQvNswonr83lF2SUEw2jj6ycpWFRwdVEwxKPqlErAJamfOjJiWIfC4kIrmCzglRhcMold8fKzC9NOCPYdd+p5usHlN+LasnSx7JJcwCsO3jPHMRx8+0wOX0R9c6tNo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Ehd8MqvV; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=J4p5kWDq; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 574JivgZ017070;
	Mon, 4 Aug 2025 20:13:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=rz5jj8EBQ6sQL+5RM4NWclp+SYER1zg/YkE2qtBWKOU=; b=
	Ehd8MqvVEfvuCzGECApo+mlg1b9/W6I3vjXmHqPOgwod5lRUWZoOQc+aPyZl8+oe
	7k1B4I9kUIzl/dBhVzL+JLmogIn5aDPOEGMRJJM/iYZ/9tsvjZ10nukQ+5x2TSyv
	WqIqciYuVEirDZX/mxPlXRkxcpWH9MxZt2pIsyJYV61BsGx+q0M/kAmP+6pG9AHd
	25Da5oojZhHVmYslv0PQmpYIWV6UO1yry/fc1kPF5oopS2DmM5A98g91gDVbDh6P
	jU3jVvCL8zMFZoo6rLBrOPthAfApGUrld9EDcjaDXZxGxuGHXu+aV9HQx+Dte019
	9Ldjt5AuRk5xUnPGcHJtAA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 489994kf4p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 04 Aug 2025 20:13:47 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 574K0GkR015050;
	Mon, 4 Aug 2025 20:13:46 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02on2065.outbound.protection.outlook.com [40.107.95.65])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48a7q14bev-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 04 Aug 2025 20:13:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oizTqY9gEZybwWGeVqHc20/Dx+I8BBiw/jmp12WnyUuXwn66sPuwhNXvi+w9wfrajKuMIkMs2MvI0fdycCmY7dq+7r0JvPNRTZgZNmk8tZAbiWVER9zIClLNYZWn85x3dXH49oToCGA+/+jyQYLj63vTswqJn4huVmcFcyJeY9gL5td7yOplYZthKxqjLl/DN0S0xvqCb22WT/5b37ncpTStIUPbrMgLLzsQu4SZmWT5RNfJIkHowqyRE0iSJGSn1cz3XrT70gWHUa16LyJBa28Q6qdN2R39jAMGV7knnvolh+Dfnjjzpr8W5b599afP3pMzxLJNp4dMT76qyidT1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rz5jj8EBQ6sQL+5RM4NWclp+SYER1zg/YkE2qtBWKOU=;
 b=wXErY6x4tkJYeSqBzqhy8qMye69XzVGL+eDmi4eUhzGy7nE6MgyhaL8b4EXrxwMFz+/xZDPnA0kD+fuI1dTueW3Fbke0L+BV6ZR1c580Q635e915bhUQ+RqrH2I0MpRAXfD/FlAhynaB0X4W7pEl1kjpOx8hjiDBikEAeEurZQmy9uGyM7zBQdC4GZinzugd0m3jtjwDmdGgUcNgJxwJm6LbuBTajaYtSb7+dWUu0muPw0iUSZmUjzgp7zYmd4BtirdYSCYxr/DO4N2R5cfiEAkio1+sVn+B82pdqPRj8La6j1o6FLrcW2Qk3Q/nOUUDR8gzQ0gPoF2iq4T59PwZmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rz5jj8EBQ6sQL+5RM4NWclp+SYER1zg/YkE2qtBWKOU=;
 b=J4p5kWDqrGchAPLcP4BUn7sodBmfauQORbu6MgFuYzd8iQf7CFyFqyuDkqhrdQDIksxWKeJrUIrnt4zrpz+NaMn53nrzKpoAWw2vcQUEbKWzUfm4DZg+DsCPEEqX7zHx2b1W8USXAyGUDc28CdOgx3sY8H3pW60uPCdb9Cc7mO0=
Received: from MW6PR10MB7639.namprd10.prod.outlook.com (2603:10b6:303:244::14)
 by MW6PR10MB7616.namprd10.prod.outlook.com (2603:10b6:303:249::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Mon, 4 Aug
 2025 20:13:40 +0000
Received: from MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::69ee:3509:9565:9cd6]) by MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::69ee:3509:9565:9cd6%4]) with mapi id 15.20.8989.018; Mon, 4 Aug 2025
 20:13:40 +0000
Message-ID: <72e387a8-b800-431b-89c3-0104fbfe6273@oracle.com>
Date: Mon, 4 Aug 2025 13:13:39 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] SUNRPC: call_connect_status needs to destroy
 transport on ETIMEDOUT before retry
To: Trond Myklebust <trondmy@kernel.org>, anna@kernel.org
Cc: linux-nfs@vger.kernel.org
References: <1754334505-65027-1-git-send-email-dai.ngo@oracle.com>
 <48287a80e639d61eb507175ceb44d216e8032510.camel@kernel.org>
Content-Language: en-US
From: Dai Ngo <dai.ngo@oracle.com>
In-Reply-To: <48287a80e639d61eb507175ceb44d216e8032510.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR13CA0019.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::24) To MW6PR10MB7639.namprd10.prod.outlook.com
 (2603:10b6:303:244::14)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR10MB7639:EE_|MW6PR10MB7616:EE_
X-MS-Office365-Filtering-Correlation-Id: 3cf591f4-4742-4e29-93c1-08ddd3936768
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dm5ubDQ3aTUxWmE0QXk5N2VQODU3MU5hSXJrRWJ2OXBJdDFidVhvZkl4S3Fr?=
 =?utf-8?B?YjRYd0k4TExEVStiTlFlTlVzZ1NNOGE3R2YvbUdoaU91QUhUMWJnM284OU0v?=
 =?utf-8?B?dm1NMlFRUUQ5NUdWUU1ZaGFIVlJnTUpRRThaQmdsVUJDdTdtakp6dmxkRzkx?=
 =?utf-8?B?OGNHRklEVk9tbi9DbXg0NmdRUWNvbXNjeERxdjdRdmxVU2hpaXdSVTl5cmFC?=
 =?utf-8?B?dlVidS9DR0lJNExnTlV5bDdIZ2VUdzliOHQ1cG9YRFk5QWpXbTEwSWdMM3J4?=
 =?utf-8?B?dTFEdWoza29KZ0J0SEhGSU00UVp5TnRHcDFVdEpTOVhzMThhbDFoYTFnbldJ?=
 =?utf-8?B?eWJBTzB6dWdDc0tpUjhRWXdUdzN4UmFvaVRhMkszd2xrc21JNko2SDU5cGJ0?=
 =?utf-8?B?aHl2M2N2ZHRIRW55VlhjeDNIQlA2TmpHTlI4b25Cb1ZoNS9OdTZMMUdadGdn?=
 =?utf-8?B?d0NWRWZodUdSTjJCL2MvNHJJcjZMZVRWdEJOYlRVNW5JVUF1bzVrRzlOdVJk?=
 =?utf-8?B?TVJlK3BKWkZRRXVtV2xGWUk5M0U2dXU0TFVuZHRuYTkxRW9xeWtoblJrVWpa?=
 =?utf-8?B?Zkg5WHBZdzFSaERvS0dLL1ZCcjJ0TFBRenZWUTR1NFRYT2Z3MUhBcjhwd3E3?=
 =?utf-8?B?WlQzU3MwbWhjbkZ3UHFtOWdKSFV4ampJL2pNdWZDc0NIMzFZRnlVV05DSWMr?=
 =?utf-8?B?ODdWOXFhTU9SaVZsdnNGRG9iS0hoQVVWTktoVGtxU2VTNG1UUEVtTFU1SlV5?=
 =?utf-8?B?SXZIREpKZURFOVFFT3ZyeERla2R1TzlxT2U4eDRDVnNWNXNrSWFPT2dkeTZa?=
 =?utf-8?B?UEQ4SDVONGZWU2FHTWJRRWV2eEVBbThZYUpCUGo4VXFzdVpvTGhwbGtYTi9y?=
 =?utf-8?B?d0dCZnFIWTE2Y1A3VGZMM1FhOEp2R2hBRXd3TlE5eHk0Wk9Pa1lUaitXeGY5?=
 =?utf-8?B?bzcyUDJTdzJLU3k1dTRTNm44bjdrbVE2Z0RYbjAzRStPNUs1eU4waFYvTUdY?=
 =?utf-8?B?eWRYL0ZuWXkvMCtKd0x0KytoWS9XZ2ltcHNXejB6VVVvNnZtUzlicHNZV1NB?=
 =?utf-8?B?M3BwMjdaTUJ0bXpTSE9vd1Jsb2NjaVdjRkVGTk01eVNsNGNtS2VPMDNjdGVj?=
 =?utf-8?B?N1FJSEptczhPUUNqZ0wvYlVqMFJNTklvYU9GSVh2THdoTHhzRmYzZGFJVUVn?=
 =?utf-8?B?dHdEVGloK3hDMlo0ZkRiOG1UTDF4OTQ2Rk9TTUJrakFMc3VyS3FnSW5mSkhx?=
 =?utf-8?B?TkE1LzZrcHNlYm9ETmVVMjROU1JIcmZ0K3l5WmFhWEZ0RDR6NUQ2TytkVTdn?=
 =?utf-8?B?N1VYTGIxRlNrYXpYdW5Bc0dSSHVRQ2Zub29YSGdvQ3FFWC9EWUdRa0VYVlp4?=
 =?utf-8?B?V0tweGlhS0hKVUVUOTg2MDA3Y1JNQ1RPWUppcEJtdnp5MmM5aXN3bUtJSUox?=
 =?utf-8?B?OGtTZlRPZEcxRDE3cVVON1EvMlh6b2VJL1ZQb2ZKYWlQTURzMjlFQkZJR09E?=
 =?utf-8?B?U2trdjZIY0Mvb0cvMnhSWnNxK3NIRUR4STV0cjdiODZvYWRsWEFXeHRFNkNG?=
 =?utf-8?B?NGV6em5HeWd2ZStBNmdWUEtnUUNISXRqK2pHbk03RkM3VTRzbXMrSzZQUHhw?=
 =?utf-8?B?Q2lPK01peXl2SVBqZkMvVE04bEM4WUhyL3ZmMGRZRysyZ0FDaVBNUXhpb2Vr?=
 =?utf-8?B?RzB5NUJnVFlDNUoxdDZvUkd3OU9RV1ZMbkd1VEpYWGl6TElGY0lDeVVvN3RC?=
 =?utf-8?B?RGpTTytTbHBGS1BnUFpFYWJxZS9IL25IalhoNDBDZ3JjdTRDNnl1Sm1PYkNG?=
 =?utf-8?B?UFZQOXdJRjQrRUlSRTNYM0FKamtrTDBvS3hIcmFSWWpwN2NmNExNQTVDZ2M0?=
 =?utf-8?B?L3AvSDZBbld6NFpzSVNFMnFVUVBpSWV5eEVZYkMwellROEMvM3R5QUVPbFI5?=
 =?utf-8?Q?erblLIGmEqA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR10MB7639.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ekZEZTFVbzdiVUg3QXliUTkrNG02dUU4emt0UDNZSXdabkwyY1dwVkZiNGN5?=
 =?utf-8?B?bDRUb21VK3UxUjFlUHFEQThrM0hjU2VIWFpLM0tkakQvZmpSZ1VpSmQ2eVpN?=
 =?utf-8?B?V1JlclU5Rk52MVRZNnBwdUhFdGwwMG9nakwwaGMrMlhrenh0VkVHOXRPOC83?=
 =?utf-8?B?SmV4aFNVZTlXNkRWS1hJZEZ5dStJOGd6SlNkTXJTc0Qyb1JtZU5xNnd1UndJ?=
 =?utf-8?B?RkN1aFVYQXpiaGQ4amxGZlZlVmlxZWNyS3A4dFJtSERiSzQvdkJmMms1WkZz?=
 =?utf-8?B?VEl6WnpjMHRuU0xGTG45SFl4TU5mT25KOHIwL1VaaGR4L3hzY0tLUm5rMThQ?=
 =?utf-8?B?WmNRRGZING1Xd2pHK0NuOGJlQlh0aEFRSW54bVhZUnZQeTdsZlhFRHV5ejZT?=
 =?utf-8?B?b2pHN2VnbkZOYnM0c1Q4K013NTZpNzI1cHdwN09zMHExdnM1Zjh0NzFIK0M1?=
 =?utf-8?B?Rk5oMVBzRjBsTVg5Z1NKN2J3aXF2Wmkyd1VQakZBc21IcFp3SCtnaDJ5anF5?=
 =?utf-8?B?YXdkcDByT0ZUcU9XNFFhQy9YVmpRNXVFV29xQ25DT2J5eEIwQlNGL2NicFNz?=
 =?utf-8?B?TDdyVEJFd1lYM2M5cFNIQUo4NjV5WEFTakNMTWNDY1UzWHg2b01qZWNSUEp3?=
 =?utf-8?B?dnRHK2VjbjRMck5Kd3JxVklnZERRTVkzNEo1d2c0V2ZQV3M1L3VYbHZKRzly?=
 =?utf-8?B?WTRQUjgraHN4YXhROGtMK2x4SVltZFpiNk5mTUZCRTdGOStkeUMrM21IVWNW?=
 =?utf-8?B?Q0J4bnVBdmdXdjc4QzdGUFFMeTVkR2ZtUGo5SnhrVk5OMEptVlBnTXk3RGVp?=
 =?utf-8?B?MnExd1VkSGVBb2s4SmlZZm5Ic1RMNE4wWWFwbEdHUStjTXc2MUN3SlFyUW5k?=
 =?utf-8?B?NmRYMXFjVVhJeHdZaVBrYzNXcitsaHhFY1lQWXNxT284YmZNUzgxTEFQQzhX?=
 =?utf-8?B?akg1TTQrOXJJQmEyN2NiQnU0MThNeFNRVENjdGtBS3p3L3lXWVhzTk04MFRq?=
 =?utf-8?B?UHFIVDVRRkpsM3N6emR6bDRDNlQ1SXg4TE5lS2pENWdSbHpOaEJCRjRMa1cy?=
 =?utf-8?B?a25KeXdEOWEvWVRidDhkbU9Bb0g5MjVvYkIwNUJxcHBZVnQrZ05HUU1BL2pu?=
 =?utf-8?B?aHV0NTU4RVo4Y00wVk5wb0l6T1lpRm5QZldFOTdXZnc0dEFlRjFUMmVxU1Zj?=
 =?utf-8?B?WmhsWDEzeEp3ak0xK0oyc0duYkpzRzRoNVRJTGQ2UHE1ZTQ5QkE3NmVuYW84?=
 =?utf-8?B?V2d0OTAxL1piYnlEZUQxTlZ6a1orMUd6YU5UM0N3em42aDd5Y2RCN0ZnbXVz?=
 =?utf-8?B?dFUrSktXQkJEc0xsVjVJaW5Ta2pPcGFnU0ljSmdrYUVjaitLVkZkRU51UjB4?=
 =?utf-8?B?UHlTT1hJMS9lRmdtZ0FNV0RZam5qd2NWdVI5VG02aURjcGxFRm5va2xSTUdh?=
 =?utf-8?B?OWJyQjFPQ255TzFSTEVGc0RRSXgxbWhwamMraXZZUEhSZGdqK2pJdmJuNmlr?=
 =?utf-8?B?cC9HT3dWKzN1V0owNmtaZXlJcUJGaldPNFlGMHlTamlUb09YRVZzeU9SeUY4?=
 =?utf-8?B?MDUySEtUT2hjdlZpQ0pjcjZia1JWNW1mSS9qSlpodzc0MGhxZnRzTEZ3eGdN?=
 =?utf-8?B?NTdUODN4K20vYVVEdm5YaWdKbkdXN0FIU25idlRmS2psWGg2WEhPaE84eWdF?=
 =?utf-8?B?T0IvaWtReURreHJNVXZiOGlkWU92aElJbHdNWDV4V1pjVXlCYWY2ZndWRkRF?=
 =?utf-8?B?ZDM0cllkeDkyTVowZDNwZll6N2l6UlZNMkErL1ZXWHlkVjE5R1FCeE5jTWR6?=
 =?utf-8?B?bW5tby96WnJDc2tqZWhVRXFUVHlKMXQ4a0oraVE3QU5kRTk3c1pmSUxDRkh3?=
 =?utf-8?B?K1RhR0FrRzc5L0FQWlNwK0dyVnNBK2ZwNnhtRDdFcXFLVjZSU29vVm1nNSsy?=
 =?utf-8?B?SE82MXhJNHROMklDZDVpVHpreEg2am8weWlNbkp6Y1doYnVZQzlmd2hVc2Nu?=
 =?utf-8?B?RTM1YjUzR0Rid0twcXlyUzI4SFNqQVh1T0RUVnQ1ZzJwVklJd0FOTmE3ZG80?=
 =?utf-8?B?SHFsUG9HTy9jckp4cDJQWlM0anp6U095aWZjeXAzV3cvWkdEdUtPcVFVd1ZV?=
 =?utf-8?Q?Dv6/j8fW+vHgrybicK6nNjkbL?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	EDH3JL2bAnM4VJKtCHSQMeqZ6IYaKzF2UNGB+tu7cs+4pPOcVeiigzD+wj6s3dXE8Ipw6a2Hnqxj5KKX4bsbLEEQ/JGa1zEeg4LjLXy4cDvlcYQX0A3bR0ZUwZHtN8Cz0w8Hv6yLbgyTuU+l4dcRKPba+yye+kk7y8CL7NK+E8ESZYR2+YzrvtlNofCXaXLK4DHtt/mCZUrX5aVxTLopUFpsA17bVluBwouDD6A0KGebuP71KZUJi9nZt9OYPzBvAV0gthYEhK/WHIPIZXWnYISCaM/SmNBXZ5bicfA6yQ7idE9sirnCtVvEpegpEE6//7+3HKg3bYX6kh0lXhN2iJnjv3tNHV4us7tk0/yqCZaFavCJOtua72tu3shOGwHcB+/mZYmoeFHBF1Vx7hQUNbJ9EVKduh2mG+GNzdODBCShTxgIh7bxFRk6S26qIzfeWlufB40OQejgiMEAoMM75Ae4/2mgOhhtmus/FrkdcmMYeeVWmiwRDyKBMsH70PrFzdspg+IAAqKfdTPF3VTTq9VwRq4WQhw9P6nO0O30epkJZRvnNDcTwcZJ0BxMV4n41KkR9fygrz4uRNYuB8KtuGxc8fgYQ1XuFy1Mlt02Sg4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cf591f4-4742-4e29-93c1-08ddd3936768
X-MS-Exchange-CrossTenant-AuthSource: MW6PR10MB7639.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2025 20:13:40.6199
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4JUV4t2RU4KIAPeIteS4M1vmDmjdMEqdvVrvgT7+8lLv36Xw4ekK1Wdz/wb5946nFADuHbpyAn4Qq/PF+7unAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR10MB7616
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-04_08,2025-08-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 spamscore=0 phishscore=0 mlxlogscore=999 mlxscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2508040120
X-Proofpoint-ORIG-GUID: kOFspJ9j5NU2f4DKxUnW8ZiFdSfwZWJF
X-Authority-Analysis: v=2.4 cv=HY4UTjE8 c=1 sm=1 tr=0 ts=6891147b b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=-koTX6ATg8c_QNDCq2QA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=e10fF4DqEehlLX_lK1wm:22 cc=ntf
 awl=host:12066
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA0MDEyMCBTYWx0ZWRfX8Yto0E6hX8tC
 vgYCeAM+V31SSPn5o8wv0nIEsJQs3j0uQG+p0TBEg9eitwWChNF5WPad57kQMvV2gu6UvL1k4wl
 +9gNhuK4ktXYBMbbBsLujndlEUjqIhmA8M0ynJhXlSGXSRrK7fWuRGYSPwXlj1xAyTtbExUyA2E
 S9z1gXBJvZUblBMZGWsEyQHQ0Yt8eVBtWVfuTe3JCQxZAHsJtseWnCqrXiOTCDiUAnyg8Bop4Vd
 cbcV8D8MpfLxhvF527XTIYFHcxcr/P2dXjJNFCBK96l1CmvLI8kMCukc0eoAPyO3NUpUzNedUHe
 BQd00x7Un5pRbyjinHd93dxXzDCKdkESpqiPJ6ipAimIsQQyH5cqV7Ng8sigKHsj+vPjWf7NtH6
 FclZuNxTeyMNsVKafy4g+uvdQGRreibNbsRgZnePW1yYshFnuQgZBr1IZe28HUQMi/RzBQ3U
X-Proofpoint-GUID: kOFspJ9j5NU2f4DKxUnW8ZiFdSfwZWJF


On 8/4/25 12:21 PM, Trond Myklebust wrote:
> On Mon, 2025-08-04 at 12:08 -0700, Dai Ngo wrote:
>> Currently, when an RPC connection times out during the connect phase,
>> the task is retried by placing it back on the pending queue and
>> waiting
>> again. In some cases, the timeout occurs because TCP is unable to
>> send
>> the SYN packet. This situation most often arises on bare metal
>> systems
>> at boot time, when the NFS mount is attempted while the network link
>> appears to be up but is not yet stable.
>>
>> This patch addresses the issue by updating call_connect_status to
>> destroy
>> the transport on ETIMEDOUT error before retrying the connection. This
>> ensures that subsequent connection attempts use a fresh transport,
>> reducing the likelihood of repeated failures due to lingering network
>> issues.
>>
>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>> ---
>>   net/sunrpc/clnt.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
>> index 21426c3049d3..701b742750c5 100644
>> --- a/net/sunrpc/clnt.c
>> +++ b/net/sunrpc/clnt.c
>> @@ -2215,6 +2215,7 @@ call_connect_status(struct rpc_task *task)
>>   	case -EHOSTUNREACH:
>>   	case -EPIPE:
>>   	case -EPROTO:
>> +	case -ETIMEDOUT:
>>   		xprt_conditional_disconnect(task->tk_rqstp->rq_xprt,
>>   					    task->tk_rqstp-
>>> rq_connect_cookie);
>>   		if (RPC_IS_SOFTCONN(task))
>> @@ -2225,7 +2226,6 @@ call_connect_status(struct rpc_task *task)
>>   	case -EADDRINUSE:
>>   	case -ENOTCONN:
>>   	case -EAGAIN:
>> -	case -ETIMEDOUT:
>>   		if (!(task->tk_flags & RPC_TASK_NO_ROUND_ROBIN) &&
>>   		    (task->tk_flags & RPC_TASK_MOVEABLE) &&
>>   		    test_bit(XPRT_REMOVE, &xprt->state)) {
> Why is this needed? The ETIMEDOUT is supposed to be a task level error,
> not a connection level thing.

If TCP was not able to sent the SYN out on due to the transient error
with the link status and the task just turns around a wait again, since
TCP does not retry the SYN, eventually systemd times out and stops the
mount.


Below is the snippet from the system log with rpcdebug enabled:


Jun 20 10:23:01 qa-i360-odi03 kernel: i40e 0000:98:00.0 eth1: NIC Link is Up, 10 Gbps Full Duplex, Flow Control: None
Jun 20 10:23:09 qa-i360-odi03 NetworkManager[1511]: <info>  [1750414989.6033] manager: startup complete

... <NFS mount starts>
Jun 20 10:23:09 qa-i360-odi03 systemd[1]: Mounting /odi...
...
Jun 20 10:23:09 qa-i360-odi03 kernel: RPC:     1 added to queue 0000000093f481cd "xprt_pending"
Jun 20 10:23:09 qa-i360-odi03 kernel: RPC:     1 setting alarm for 60000 ms

... <link status down & up>
Jun 20 10:23:10 qa-i360-odi03 kernel: tg3 0000:04:00.0 em1: Link is up at 1000 Mbps, full duplex
Jun 20 10:23:10 qa-i360-odi03 NetworkManager[1511]: <info>  [1750414990.6359] device (em1): state change: disconnected -> prepare (reason 'none', sys-iface-state: 'managed')
Jun 20 10:23:10 qa-i360-odi03 NetworkManager[1511]: <info>  [1750414990.6361] device (em1): state change: prepare -> config (reason 'none', sys-iface-state: 'managed')
Jun 20 10:23:10 qa-i360-odi03 NetworkManager[1511]: <info>  [1750414990.6364] device (em1): state change: config -> ip-config (reason 'none', sys-iface-state: 'managed')
Jun 20 10:23:10 qa-i360-odi03 NetworkManager[1511]: <info>  [1750414990.6383] device (em1): Activation: successful, device activated.

... <connect timed out>
Jun 20 10:24:11 qa-i360-odi03 kernel: RPC:     1 timeout
Jun 20 10:24:11 qa-i360-odi03 kernel: RPC:     1 __rpc_wake_up_task (now 4294742016)
Jun 20 10:24:11 qa-i360-odi03 kernel: RPC:     1 disabling timer
Jun 20 10:24:11 qa-i360-odi03 kernel: RPC:     1 removed from queue 0000000093f481cd "xprt_pending"
Jun 20 10:24:11 qa-i360-odi03 kernel: RPC:     1 call_connect_status (status -110)

... <wait again>
Jun 20 10:24:11 qa-i360-odi03 kernel: RPC:     1 sleep_on(queue "xprt_pending" time 4294742016)
Jun 20 10:24:11 qa-i360-odi03 kernel: RPC:     1 added to queue 0000000093f481cd "xprt_pending"

... <systemd timed out>
Jun 20 10:24:39 qa-i360-odi03 systemd[1]: odi.mount: Mounting timed out. Terminating.

Jun 20 10:24:39 qa-i360-odi03 kernel: RPC:     1 got signal
Jun 20 10:24:39 qa-i360-odi03 kernel: RPC:     1 __rpc_wake_up_task (now 4294770229)
Jun 20 10:24:39 qa-i360-odi03 kernel: RPC:     1 disabling timer
Jun 20 10:24:39 qa-i360-odi03 kernel: RPC:     1 removed from queue 0000000093f481cd "xprt_pending"

Jun 20 10:24:39 qa-i360-odi03 kernel: <-- nfs4_try_mount() = -512 [error]
Jun 20 10:24:39 qa-i360-odi03 systemd[1]: odi.mount: Mount process exited, code=killed status=15
Jun 20 10:24:39 qa-i360-odi03 systemd[1]: odi.mount: Failed with result 'timeout'.

This patch forces TCP to send the SYN on ETIMEDOUT error.

-Dai

>
> Oh... Is this because of TLS? If so, then please fix that to use a more
> appropriate error.
>

