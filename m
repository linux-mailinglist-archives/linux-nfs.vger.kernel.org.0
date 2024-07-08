Return-Path: <linux-nfs+bounces-4732-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E629D92A859
	for <lists+linux-nfs@lfdr.de>; Mon,  8 Jul 2024 19:40:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69AC42810AD
	for <lists+linux-nfs@lfdr.de>; Mon,  8 Jul 2024 17:40:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 060B3132132;
	Mon,  8 Jul 2024 17:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ktXTuznK";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="lqZ94X90"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A32F9AD2C
	for <linux-nfs@vger.kernel.org>; Mon,  8 Jul 2024 17:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720460412; cv=fail; b=XbIrlFCkMJBJzMtz/Jvm5dw+44wfHzen1fdY1BcQgBD5xfA7BJGU5KYzz2zVNWOv+3bCTizWcMxlw5qNlARZWqZZN1SL5PS1Gv5sdtRy3ZcxXIcasfVfGjFvkkjqqFeaewZkAY8QuIBAOrH8xlvJLiykYZREtqubLipY00XyENw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720460412; c=relaxed/simple;
	bh=XPJqbu3f5VyQ4XRmY99Fz1J4aZEWVK1CYc0ctAKcjq0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ee+JwK0zUZiMBAZyYldcU089RndelJcMfV+qZZHiwVjG6d/5twgza0kkn1ykH3lrPx7/Tp9Wf/Y1uLtkMFF0ct3jlqMGLWi8Ym5a0jXEAI8IzSyLQ5yB5VdjDS2AGafPRc0LN+YLheMwF340E4uph8Q9nEIOqrU66G6VJHhsJ6c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ktXTuznK; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=lqZ94X90; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 468HXWkU005977;
	Mon, 8 Jul 2024 17:40:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=902O9d0Z61llHWntrTumDsXSQwFKsFuir9yShWQTpJA=; b=
	ktXTuznKnvEjSA01DIBOTvV7qkY1DVhLzbEKuy8M5++YonUz7ljuOXuE+LEc7BmK
	c8bkX7uJ5I1WlLfkewCEJ0RRk1Q0ypq5WsqXTnAYT+P/fKgkxlZnESaZ1QAeOo6k
	SKDdolusAawKy2ywiriKp668hpE35F+3aNHZS1LA66DN3XQPeOiWFIH0VKiqPmbS
	HJUI4c8B19WWXnjuZh1zIiiXxMsh43kF2++KCLefepvXBCh349QRCeN2jWNonrKO
	g8QDVVyjt1wW/ENgXZxt6JP9DW2tevG/xthxtdBYyxqAiofwX+ImSKJqvSD7uukE
	ZHfs0UMwdomAImykPyuwEA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 407emstkwd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 08 Jul 2024 17:40:05 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 468GauTU038234;
	Mon, 8 Jul 2024 17:40:04 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2173.outbound.protection.outlook.com [104.47.58.173])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 407tv01yax-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 08 Jul 2024 17:40:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nxPG/CQxZhi9VNG28jMZlHHBXMyK/JpPSRyHUD5rnaio4CaDGn470hmXvngto/lQuwUd/N/lOlaOd466quodHyz90/x2dO2Ry/OTqbtQ8LANlMcrCaPkQnNGEVO7XkZOSfsWNrebX+b+cRyQJctAjTB+fyEr7T+7gQOy5zDNVXxWLwPBY2V4H9KKiOwoxWbJyfNQ2FA0Zx4qr/KkDL45u4MUfoDwKqzGV9J2tRsm2XpurYUo/0T1CoZPrgAAe3R2tCOmwbnb5F55pJ6RiXXg7amgb7p4kp5UT9Wd/gewPzl4Nl45hGH7WQUczf0G28Mv4bKMldBcg1QY7Y5uPov4AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=902O9d0Z61llHWntrTumDsXSQwFKsFuir9yShWQTpJA=;
 b=i4rpcE2Ax/2pQ71UWr+cgAdVFVNeNzOl683/Go6VZxU2pCdH4P0DRrwggdl4e2cH8lTvY+vzr2x7qWC/wZZ9Y+qxpNtBpgH9NtX7J5AeKa1CAEOD3Os4j1UcfFpKjo9fIf/KVD6QNanhVfi072GaYa0FUBA+56TdIy7s8k08ao+SVdrT0HXaqgffATLMuSKyh2fAR9+SY2Lmzw/ZfvXcUlJs8VL4eXTc5/gPAr3LYhMy+oCujETbd1DlPZfiBLw0tKw8XJ9RNoyd1Frh6+nU6XiAWFQ5hpyvciqdri6LAVUZubO7GaBAfAYOfa/GUAntxxSrze+k+KpIJCvkFM6HPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=902O9d0Z61llHWntrTumDsXSQwFKsFuir9yShWQTpJA=;
 b=lqZ94X90vnq06jT4qUZ46qP5kuS3VshtMgAmYnILauVsmeTMlKFAhobpX2LT/E8uBnbdQnMNnxFtoXvdkKfnSQn4eNJlNvploopJoHp+d2tBMyx1SQYxSa+1jQ33X5wP6AaFFsyATbxGt8DCRozw1v9K9hPRI/WWz6isoTg2VhU=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by CY5PR10MB6261.namprd10.prod.outlook.com (2603:10b6:930:43::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36; Mon, 8 Jul
 2024 17:40:01 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::4c3a:47c2:806d:2e16]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::4c3a:47c2:806d:2e16%3]) with mapi id 15.20.7741.033; Mon, 8 Jul 2024
 17:40:01 +0000
Message-ID: <3b4ec3b0-5359-4f95-81a3-1d558756bddd@oracle.com>
Date: Mon, 8 Jul 2024 10:39:58 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rfc] nfsd: offer write delegation for O_WRONLY opens
To: Chuck Lever III <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>
Cc: Sagi Grimberg <sagi@grimberg.me>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
References: <20240706224207.927978-1-sagi@grimberg.me>
 <114581777d5b61b6973ec9ef2537ee887989e197.camel@kernel.org>
 <9156BC30-78C3-4854-8BC3-510E586B4613@oracle.com>
Content-Language: en-US
From: Dai Ngo <dai.ngo@oracle.com>
In-Reply-To: <9156BC30-78C3-4854-8BC3-510E586B4613@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR05CA0052.namprd05.prod.outlook.com
 (2603:10b6:a03:74::29) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4257:EE_|CY5PR10MB6261:EE_
X-MS-Office365-Filtering-Correlation-Id: fa0ce3a1-ddd9-4a06-591a-08dc9f74fe5a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?ZG1YRmZwclg1ajN3K0REOHFaUmUzTDhHN1VETHp1c2RpN2o4NHBnUEZheFlD?=
 =?utf-8?B?WHYyUk1JYndRQjVDMkNHQmlYeEpXQVFtcWpQdHlJVUZQTmMySEJZTGZkenpp?=
 =?utf-8?B?Z3JUNmRwTC9meHdreG5ReUNjRlBhOXdheUphRlFJRmRVa0h4MDFQS3h1RmRX?=
 =?utf-8?B?MzRoVDlKZHg2RGoxVFRGVy91d3dVaUQ0NG4yUWpLTE8vSzdndmZISXNwTkt5?=
 =?utf-8?B?U1h2N3NIenJUV2w2WHZXSnlyMXk2MDFHTEYzM21Ld05NNTUzY2VaWTIrNEtB?=
 =?utf-8?B?NDVIaWZpNGFVeDdoS3J1TjErRW85bkYrbHBHSlhPWHJsbm91azNLbXNUdFBT?=
 =?utf-8?B?TCsrSFNhQjBsRis1WE9vek5VM2Q4R2g0a3pzellTTDFIbUdyOE9iSVZWcHk4?=
 =?utf-8?B?cXpMbHc4cGJUdXdFTDVwdlVIR1B6aGNDRFBjUXN6akNJZUxiSjAxTHNCMmIy?=
 =?utf-8?B?VGdTQmRMV200TS9XdjFTNkluaXZvZzNBYmFDMXhaWUtHcERPTWViSkpzRG4r?=
 =?utf-8?B?TmRvcy9HNkw4Yk9hQXFSZG0vV3pVWDc1amhtVm42V1pFaFRidFZON2dKcGtP?=
 =?utf-8?B?Wk1ObDNVRUtDcFNmY055TWFRQXZHS2JtcWs2dklJcm94WHI5Z0hxcVNtK1BG?=
 =?utf-8?B?dVBIaWYyQzY1bFE0Si85VDZsVTdPMGRmazhPRGRGTWFSTlpWOEl0aTJlUzVB?=
 =?utf-8?B?Y1VaSUpXN214U2IvT3ZSU0M3S2hlTEZUQm9JbUFnK0pTSzM1MG1yVE5WUlpK?=
 =?utf-8?B?NjBhNGo3d1lqUGZpR2xHNzRwdUFTeXRpb3labnRzdUt2ajdiZ2xVR2J5OG9r?=
 =?utf-8?B?WDYyZUJXZmM1QWQydlZHTkQzVXgxU3dOQVJHRVgyU05rUm1hQ2RYbTg0N293?=
 =?utf-8?B?RkE4SVJqTkc3OFBzN1M4QU91SXpDWFRVRWlWMmpJaDBoVkRMVS9ZQmdrTWtx?=
 =?utf-8?B?Wk90dTNDdkxmRWdWdkFNY2RiVjlPWU5uaW4rK2NuTmg3U01nQ1E0eXNWQXpS?=
 =?utf-8?B?c004dkw1YVNRWUg3WWxSRVkyMW0xdGFsM1kxUGlDcVF2aVRRdlZMMHNLV2pT?=
 =?utf-8?B?N3IvWFNHTExma2R1cjFCREg5TDZUcHowam01Uk81RXFIUVFPYzhjYzEwVldL?=
 =?utf-8?B?bUN0N2lxcjQzVWdzQ3FiMExPdmp1Y2JpWTh3U0ZETjVZc0NaQ1JUTVZaZ1Ns?=
 =?utf-8?B?NkI4N095YkNkSlNQOVFBVE1OK3U1STdQcURnekE4UlBoSEUzamVnMnc1WjhP?=
 =?utf-8?B?Y1ZDc2NOWUREVFUxbTBiZDBmTTducTZyMEVqSXdlRElaWUNmS1c4TS9NMXdw?=
 =?utf-8?B?UDJDNGEvdDlVenlIV3E2ZHBVeHJYZmtBNTV2NWNpWW5oNHFsUEJmbURaTkZ3?=
 =?utf-8?B?WWRROEsxTW4wVTJuempNNU1kQXB4SFBadEw4aDExbitUQ3lWbFlZTm01QzNN?=
 =?utf-8?B?WCsvK29KK1hWSUJkOW9UNXBiZzF3OTFUK25rVmtSeGhVM3hzVFZmSEpzSFdz?=
 =?utf-8?B?eUt6clVJbmg0eDBhRDBsbDZDS0VhT2xkQnhlYkZKTGxMQ1lZa2lWNWphQU8w?=
 =?utf-8?B?SVgwVFl1OEE5VUg1ck9sM2p4aEZMK1VoR3FNRmFPbCs1UVJ6TlFNZEZSb2x4?=
 =?utf-8?B?eUY5WkQ0TG1pSW14WVJiM2VBaUhlT2tpR1FMV251Vy81bEFZN2ZVbjJSc1Ix?=
 =?utf-8?B?ZzhyWkpUOXVHUGhHSlEvUHQ0bmFqTWhNYUdXZHJlZTZFYjJ0VndtcmtHckhH?=
 =?utf-8?B?K25ueDBRK2JFWWE3WEpqcERQQ293cXBrTjg3MVJzVTVwR0Q3cnJvdXVEaTF3?=
 =?utf-8?B?M1M5TjU3V3k5WFNpZVBkZz09?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?anRpZVMxMERNMXMxYVgxdWxqejZTa3FESGxJTlFIUWlUY1JSY0VkZnJtbE9H?=
 =?utf-8?B?eHFuZzRYMmtIck1jNmc5RG05ekNVOUs3R1pXQWszb3pCUGdIL3QzSDZtZXdG?=
 =?utf-8?B?VXlydzFRc0M1eHBRTno4TjBqVkQ5SWQwb1U1S2NyZUplN3dEaWRLdFUyOGhp?=
 =?utf-8?B?QkpGMlpUVS9qcEd5MjlUWFJTS0dPUHJwY2RGTnJVKzN4SE84c0hScTh5NnNU?=
 =?utf-8?B?STBPOUs0Q2JQMklsZW8zSlZvKzhUKzJIbHhHYkpwcmU3UWp4M2pqVlN2V0hz?=
 =?utf-8?B?Z2gzVHdxQ1EzdEFGOWtGeGZudm5RTk5zQnQ1a29lWXQwUVl1bnVMeDl4WkdX?=
 =?utf-8?B?cW8wVjZIc3dnaTlZM0NmbEZUQWJHTXpBVjAwQlZEb3hDc0dGeS9WdFZMSkxO?=
 =?utf-8?B?dEIzRDRMbUZLVUdmUWhjWXludUIwNmNnSy9NVU1iZ3dJS2xETnBUdjdPd28v?=
 =?utf-8?B?NVhZVmVvOWFrT0FINmV1N1JydW5TTkJDajBJbXQvaGJaUzkzcVRXTlVBZkVR?=
 =?utf-8?B?VGhKZ200WGUvaG16NlA5VmZ1SjBWNzVQNDkvS1J4QVdxYVI2NjdkL2NSQ2tw?=
 =?utf-8?B?bERKZ3ppSEZHeXEyZ1Jpbi9XZVNvV2diVkh4Z20rUCt1Mjdadm9vM3VYbmFZ?=
 =?utf-8?B?R0U1aVhYRWtZQUFvL3dIZ3pKWU80Z09sR2JLNU96TkVEQVRoRFFTRXFwc2hG?=
 =?utf-8?B?NzRJMnlZeVlIMnk1MCtaRWRiWC9SaEVYYndLUW1EbVp0K1JhUzRUbTAzamI4?=
 =?utf-8?B?K0ZKMWRiMG1wd09VdzJwa09ab09FTFFhSzFFeTY0eEZ1bFZLMy82cVFiL0FB?=
 =?utf-8?B?aGhVNFNkZThNY0FxNVhMYllkMzdTRTNWNVlzQnRjamtCc0luazh0NWVMWjdG?=
 =?utf-8?B?Tlp3TFZmRThleVhWTFh2cytxeDc0TFJBVjJlL0doc0hFcTZ4TnN0SnQ4cTBH?=
 =?utf-8?B?dlZuTzU0WU5CS0JydE03S3BDQnN0RXlJQjhJakY3YklOd1RIOTBlelJUUy9Y?=
 =?utf-8?B?MlQ0amxiMU9RODU3Y0JvTmRIeC9nMXZseEdQOGJGM2NkdG9aU3ZDN3FhM1Zo?=
 =?utf-8?B?Z09RZTJJbnlnMWtzeHVpWGNmTVBkTjJMbzl6SmRqTnd5R1Q4VDNXdmZzOFNX?=
 =?utf-8?B?QVJBTU9qVUR0R25hNHl0QUZSVWZQdG5ZblZCQ015d1BiUytJV0s1d1dHNzg2?=
 =?utf-8?B?R0dQMWlraU43YXgxRklRWXVaOGNOVXhKaHV3SmtOYkNERXN6ekJaWHhsZUxL?=
 =?utf-8?B?MmU0Ykpqa09oQVFNbmp4NVI1VTlrVmVJc3dNaE9GS2dySzl0VWFZNWpRRFFE?=
 =?utf-8?B?UmRSUnh5ZnptaUh4S3RCS21mNytoc3B1YWxqOWFSWWpCZUFjZDhDOGcveXc5?=
 =?utf-8?B?eFhDSU1pVEFGL2JJcThWeDIwSWlzZ3NBcHlXWHNxbmxsajkzSDdJM28vZzVB?=
 =?utf-8?B?ZXF2SXVHakxweThNZU9VWHQvcHhJM01QSkk2Y3pKajBGbWJDd2dGVUl4SHJI?=
 =?utf-8?B?RVM4bXhVaTFMYklCSDZudk5aQUxZWFBqb01tK2xwZW1VNEsrSE1Hcm5QMnQ0?=
 =?utf-8?B?b2hva1UxSi9NWFRqd0V1czllcUN5VFVWVDlIWHF2Nm1hU1Fjcy9FcWhsNitY?=
 =?utf-8?B?RmYxUWJoSkxacFF4OXcwd1pubVZWZFdLc3o0SWMzSHdqQk11QzJVR1A1aFV1?=
 =?utf-8?B?QWI0VnFVNHMvYzJrNGg3VFc2elRFSzJENXpySklaV3Y5aFhaVSt6bFlhNVRC?=
 =?utf-8?B?RWdGUE5rZzBjNy9tRjQwTHFxcSsxMTZuSXo2WkRxNTQvVkhMcmtZcUZhcnF0?=
 =?utf-8?B?c2xsYjdqV1NCT3VnOFBnQ3FoUVUybFJLcUxzSDVXOTl0a1V0MnZBRVUzb0dZ?=
 =?utf-8?B?ZUdZZ0FTTUJSdEt1SlFROVRnRzFrc2xmT1dXeXdzMTNoYm1kZkRwVklXU09T?=
 =?utf-8?B?SC9Lems4Yms2TFFnNi8vS1hRTnR3cHlFSXdsUlVrMGY3NzlnL2VsaU00U25i?=
 =?utf-8?B?NS9kZmliSVNMdzFsQkJCQjdGZ0hVa1YxaENjVENsODBUa25PTzhMWTRHbm9Y?=
 =?utf-8?B?alFpMUdURGZTV1NWQ2xqd0VHNC9kVFhOUXcrcXFlRGthWTJlcFh2SkhiT2g0?=
 =?utf-8?Q?M6rbnfeNn4Ry3f3/BGtwXGrUJ?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	E0ae4UcHEJez7jFFcbPBm2si7oUWu8r80wNV+aqG08M+ICDi7KCpqPGb+SS2I5UnKYbxjC3GBIeKoDA4wKZSxYsJcAuaAU8ymfDU6r8YWQQpiqwHic+Kjzw347MtoMr5AjkDSeiwExohgj9WOwVELAQuSTEHTY+mHRG1rGdcHHxMSn14nrB7v8HM1jz1PNeWnEEjf1LF2vqdrMc7CvNqXiQvqfOCNitv0mEiCSZVR6rOMulN9TEpkpDjN5rtIWJEHbhWH3KORi5JcO8irkHrLAwKEs0J5e+toypo0xNNr7/5/BtuZDOdsgE4Sre8r9PNO6LuiXOuYDVbz7Uyt3OJ7uBFSgLg7FGEKGts6dL/BWIf7TYFm1vtxB9IDNthjCySyKDyfFKOSDAjAn/p34WaYHZ0F3GMDiE1VzbztcKS+hiRsuGPiyC+yke2hodQWCdu2kkWM0uCyVtzTNXEl5ujMMM58aWlp4zR0PgicSJ5QnVwumZgMH1ntssO5sVMKYbKvFaSuHgpO+06rFrPU/Dz6fSfie70gUBTZ97Zov+wmJl9FLVss1qPvNHeWS/XmBuqXcpzyh8APFYI92CSwslDpmTakFmySe55cNPokk3Cc5s=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa0ce3a1-ddd9-4a06-591a-08dc9f74fe5a
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2024 17:40:01.3355
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2R5VHMOe+u3duCcyX2BM+EjXOsMM92zKNzTHoZFdREtrTzma+JbgnF4/PAFVRtYfPsiMwFNEbkLCkPfh3l7k5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6261
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-08_09,2024-07-05_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 adultscore=0
 phishscore=0 malwarescore=0 suspectscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2407080132
X-Proofpoint-GUID: pEdCtAbmo3_kK0mYbyrJMlt4_1Gz4qB2
X-Proofpoint-ORIG-GUID: pEdCtAbmo3_kK0mYbyrJMlt4_1Gz4qB2


On 7/8/24 7:18 AM, Chuck Lever III wrote:
>
>> On Jul 7, 2024, at 7:06 AM, Jeff Layton <jlayton@kernel.org> wrote:
>>
>> On Sun, 2024-07-07 at 01:42 +0300, Sagi Grimberg wrote:
>>> Many applications open files with O_WRONLY, fully intending to write
>>> into the opened file. There is no reason why these applications should
>>> not enjoy a write delegation handed to them.
>>>
>>> Cc: Dai Ngo <dai.ngo@oracle.com>
>>> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
>>> ---
>>> Note: I couldn't find any reason to why the initial implementation chose
>>> to offer write delegations only to NFS4_SHARE_ACCESS_BOTH, but it seemed
>>> like an oversight to me. So I figured why not just send it out and see who
>>> objects...
>>>
>>> fs/nfsd/nfs4state.c | 10 +++++-----
>>> 1 file changed, 5 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>>> index a20c2c9d7d45..69d576b19eb6 100644
>>> --- a/fs/nfsd/nfs4state.c
>>> +++ b/fs/nfsd/nfs4state.c
>>> @@ -5784,15 +5784,15 @@ nfs4_set_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
>>>   *  "An OPEN_DELEGATE_WRITE delegation allows the client to handle,
>>>   *   on its own, all opens."
>>>   *
>>> -  * Furthermore the client can use a write delegation for most READ
>>> -  * operations as well, so we require a O_RDWR file here.
>>> -  *
>>> -  * Offer a write delegation in the case of a BOTH open, and ensure
>>> -  * we get the O_RDWR descriptor.
>>> +  * Offer a write delegation in the case of a BOTH open (ensure
>>> +  * a O_RDWR descriptor) Or WRONLY open (with a O_WRONLY descriptor).
>>>   */
>>> if ((open->op_share_access & NFS4_SHARE_ACCESS_BOTH) == NFS4_SHARE_ACCESS_BOTH) {
>>> nf = find_rw_file(fp);
>>> dl_type = NFS4_OPEN_DELEGATE_WRITE;
>>> + } else if (open->op_share_access & NFS4_SHARE_ACCESS_WRITE) {
>>> + nf = find_writeable_file(fp);
>>> + dl_type = NFS4_OPEN_DELEGATE_WRITE;
>>> }
>>>
>>> /*
> Thanks Sagi, I'm glad to see this posting!
>
>
>> I *think* the main reason we limited this before is because a write
>> delegation is really a read/write delegation. There is no such thing as
>> a write-only delegation.
> I recall (quite dimly) that Dai found some bad behavior
> in a subtle corner case, so we decided to leave this on
> the table as a possible future enhancement. Adding Dai.

If I remember correctly, granting write delegation on OPEN with
NFS4_SHARE_ACCESS_WRITE without additional changes causes the git
test to fail.

The cause of the failure is because the client does read-modify-write
using the write delegation stateid. This happens when an application
does partial write the client side, the Linux client reads the whole
page from the server, modifies a section and writes the whole page
back. I think this is the case with the t0000-basic test in the git
test suite.

I think this behavior is allowed in section 9.1.2 of RFC 8881.

-Dai

>
>
>> Suppose the user is prevented from doing reads against the inode (by
>> permission bits or ACLs). The server gives out a WRITE delegation on a
>> O_WRONLY open. Will the client allow cached opens for read regardless
>> of the server's permissions? Or, does it know to check vs. the server
>> if the client tries to do an open for read in this situation?
> My understanding is that a write delegation is no more
> than a promise by the server to tell the client if another
> client wants access to the file. So granting a write
> delegation on a read-only or write-only OPEN should be
> fine to do (at the discretion of the server, of course).
>
> The issue about the ACE is moot for NFSD right now because
> NFSD returns an empty ACE. That should require the client to
> continue to send ACCESS operations to the server as needed.
>
>
> --
> Chuck Lever
>
>

