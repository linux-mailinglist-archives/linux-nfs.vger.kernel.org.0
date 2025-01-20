Return-Path: <linux-nfs+bounces-9395-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B5B67A16F17
	for <lists+linux-nfs@lfdr.de>; Mon, 20 Jan 2025 16:15:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3B4616A636
	for <lists+linux-nfs@lfdr.de>; Mon, 20 Jan 2025 15:15:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FCD01E0DAF;
	Mon, 20 Jan 2025 15:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FTMHcpu+";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ZliOyo3o"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8020F1E0DF5
	for <linux-nfs@vger.kernel.org>; Mon, 20 Jan 2025 15:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737386134; cv=fail; b=ADbsDDSLTZDBdDuzWzSsRFonQ5aP1h6vvL36M1z2eaePq580kAEfZCbcFBBfmMrHKbf+LfiVOK+1ruPuLRjuukeBTQyv/hyN+uNhSX3tmI9vbhFEHQ3uSZ2f9OY+ShzPwZOlBTXfLwwyIr8qqCQ0NznF0MpZhIOjrE2R6gDkCW4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737386134; c=relaxed/simple;
	bh=lTCn/gNTqRFVWjW3t9Y5JY2ySVRrJEI6StH/5MAYpQQ=;
	h=Message-ID:Date:Subject:To:References:Cc:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NiWk9q926VASSAFKc9e6xWfho5IJFUNqutBOu0axdYkx2Y20NGjW5CrUrqQ5AHPjeQ2o8XjeDPsBJPVkmbDCI8/eZr90O+qSyKzhPgDhI27wzChyP3QA9sD07LzN90JLHsTrJR2tYn4B/gwKD34LkIqbmQ7rFYzEqVVTKVW/VdI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=FTMHcpu+; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ZliOyo3o; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50KFBusH027792;
	Mon, 20 Jan 2025 15:15:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=bYiOnKG+NXi3hkn+ScR/35Dd5VrEt7B+bbjjzru8t3o=; b=
	FTMHcpu+reL0EoC6eiOolp8Bm0GyOz6ORX+AquQBN1DsTHiC8wZSmAC5vE+qgple
	LLQLr1GdShGSg8D7fThDSGcy/iju+/qtoG5t4FhBR5RtvSXkkFL+/PKzFqWc9LEf
	cOxRRYxO9oNaRD/u3rKWm/NV6RW6ahzXJG6Ut+z+1usWXBpQYCjd6nEgD0bj877F
	bVgCoG0mecrJGdzM29DnzgxskOxjGk/F8x30WS7TMEpdmIteELJGhALeanBU+3ha
	/zOd35Y71kLPfPnTAC4VdCKom3dtbIYhPTRF6f1ySAJKWpIAT4Na2PFqg8b/N+6V
	1vN+hCE+Xk56w2XqO9KfkA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4485nb3vb4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 Jan 2025 15:15:02 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 50KE4rbR005462;
	Mon, 20 Jan 2025 15:15:01 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2043.outbound.protection.outlook.com [104.47.55.43])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4491937jf5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 Jan 2025 15:15:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sg5iUIKRvYEEowMBz1afxAoRc+8Ch0axcliPGzCpA7LuytqPCKtA1xeAJ3iLrsjpB+q7HCKo4ASVby9J7jrHd5mKmX5xW79eRam807ngPpu+A/1DQ4M11gDWOvD9MMwjuzuneNhp4GH/qYROeRGfFeouR2Yd+3bZrUsTxPrUiapnR3qr8GsGK6jZB5U14UIJNCCQVNnWhIm9dNdWojZSni+831olQ8Z+rKt+p2CqAz7boSDiRtY1YTUo+S1XnBHmCad5yAlBAweFpBMylHEwHFktz8G8hSeuBUs0HRHq+KCYWXpkrqKK5l2kZez13XSihNAeCV8bYVTIgSuvEvFJog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bYiOnKG+NXi3hkn+ScR/35Dd5VrEt7B+bbjjzru8t3o=;
 b=JkWDL7rSq3Ikmu2HRFpoiIKFyraUUgRLQrUlPVOP13uS9jQgWRAOnVvwJPLswa1LHY7xxu9tOfDCtjK3XxBa+v7hD38kpe0Z0uaUa1S5124s9zLJuSd6WMyukuqmqisPsQLO95iHsFtKDb6cKuEpoBfb/ZJ8lpVS3ZaRaGQdcBZJKVXe15a1ccfdKP4u4M+UQtUwldTWlz3a+A3Hxr30spdrC84M5lyMtBfevzscS1wd3M23ql6gLmd6lPJZU13tSfSA+vRbaVYkgiCWW+YtXooh9mmme6MCAPS49ZtZ1iN3nk5lsOwZwZXwzD+SncGZmiXkoVA91PDd64SPUn/eeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bYiOnKG+NXi3hkn+ScR/35Dd5VrEt7B+bbjjzru8t3o=;
 b=ZliOyo3oHP5YV8YvZWAP7PZzo4pMJY2aby/igmEZtaM2eW3gcEFNVh9XY5oVRQ1odIUUB1RaLwsYL/GhnjXqaAF9DbCYuOH6wViwDkaiQsLS4j7Hc8a16tpW4MRW4jtRWoYuyF5wnQ+fcXtESim2X5JAIzA/5+ffhbfRO8DSdU8=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS0PR10MB8128.namprd10.prod.outlook.com (2603:10b6:8:204::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.21; Mon, 20 Jan
 2025 15:14:59 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%3]) with mapi id 15.20.8356.020; Mon, 20 Jan 2025
 15:14:59 +0000
Message-ID: <70ba83c5-5104-4f8d-bd18-95dcc8c82551@oracle.com>
Date: Mon, 20 Jan 2025 10:14:57 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: NFSD threads hang when destroying a session or client ID
To: Salvatore Bonaccorso <carnil@debian.org>,
        Harald Dunkel <harald.dunkel@aixigo.com>,
        Christian Herzog <herzog@phys.ethz.ch>,
        Pellegrin Baptiste <Baptiste.Pellegrin@ac-grenoble.fr>,
        =?UTF-8?Q?Beno=C3=AEt_Gschwind?= <benoit.gschwind@minesparis.psl.eu>
References: <20250120-b219710c0-da932078cddb@bugzilla.kernel.org>
Content-Language: en-US
Cc: trondmy@kernel.org, cel@kernel.org, jlayton@kernel.org, anna@kernel.org,
        linux-nfs@vger.kernel.org
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20250120-b219710c0-da932078cddb@bugzilla.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0182.namprd03.prod.outlook.com
 (2603:10b6:610:e4::7) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|DS0PR10MB8128:EE_
X-MS-Office365-Filtering-Correlation-Id: bc38fe3d-7a01-4f40-9a31-08dd3965344c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZTVDWEdpVXErUmJoc2xCUGV2VEVPQmZRMlY4T3M2TU5FT3kya0dmMkpjR1g0?=
 =?utf-8?B?OURlbVc5RWRVcUphMkMvQTZNUEJ6QVpHOVFVTlhkaUdLWS9GWUcwZHQ2NEVS?=
 =?utf-8?B?Ylo0V0lhd2ZEM2hOc1ZTMFJjNlRrSzZvaU5pcVAxOG5abzNuT0N5ZmlBTFlm?=
 =?utf-8?B?dW8yaUFzb0RsWUxHYzhJZGtOemYraXdkOGc0R0FITFB4QnRNelNnTVpsbzZF?=
 =?utf-8?B?RWVFNjNIcjZpeHlSdzk0ZHZyODAzYyt6dFlyU1BPdENoMzluL1ZIamxXdlNS?=
 =?utf-8?B?ZlVROStSQ1JnRzZZZXhqZzNiMXBRWmlTa2ZadHNsUzM2UDhJcENPSmxobnFu?=
 =?utf-8?B?TUtaNTVmUWtRcVV5ZFhJVEJDaXJyRmtVSVZTTG9ZL0lEYWxvT3hidkpHSWZC?=
 =?utf-8?B?UzJwU2x2YjRQUGozVTNwdXltdFRjMk1tS1Nua2ZDSWxRU0s2WHA0aE1OSkhJ?=
 =?utf-8?B?MVJjQzJia2JNMk9pamFjdExFU0o3Lzg4TUtMNXkxM1JZWDJHRGZOUURKbGt4?=
 =?utf-8?B?UkEzRjB2MEpEZ0pkTDBpZ1Z0Lzd3cVdxNGh4QU01MGJ1NXR2VEc3bVNuelpu?=
 =?utf-8?B?d0Npb05DT3I1Lzcxek8rc3lBaTdCZUF5UmRGcE1aR0JKYUpaM0JXd1BwcTFl?=
 =?utf-8?B?ZmNyKzRIVE1YUnI5T1JNRTFMNlhLT0dtOGxqOXFLVGk2dmg4Tk9QU01qMm5r?=
 =?utf-8?B?Wk16RDRCM1RWdkhzMmttN01TVG84S3YxbncvSGNFck10ZXdqbm9KRldMMG5F?=
 =?utf-8?B?dUg0T1E1cUJVOUV3L1ZCTzl4VE1ySUZxSnh5aWNKVm04eE14YmxXQ0N6L0lB?=
 =?utf-8?B?czhGQjhoU1RZRnpZTzZZY2pEa3l3eFBDYkRXZGllYUdEQXpOdm5JVWpndVdz?=
 =?utf-8?B?MlJJYXNmZllUUGlKODhRc0tiTFJScDhFME10ekZ4QXB3VHlWWTBNVnloY29x?=
 =?utf-8?B?dzk4dkZLTHZMMkFMZ09rSkdSSWhQM21wK25QSmE3OHZRc0NoZ1BDclVvMHk5?=
 =?utf-8?B?WXdYY05mYmpUMU5kaVVXeTI5b3dtWWdkZ0pqc09JNHpZSXI4UlVoR1VOUW1C?=
 =?utf-8?B?TEJiaFFyQ0w2M3hSSVY2NW5BNWh6VkdKL3E5OTYvcTlrMlRld0hxL2VkQjZw?=
 =?utf-8?B?M1hGY2F2YTAzVFZsZ2F6UFZTZW5Gb05NZGwrOFJCSEtucFVORGF3d2MzY0pw?=
 =?utf-8?B?YnllZFU2NDMxSlVhZCt2QS9RbVptVFdsLzhYaC81NHBBekIvUUkvak5rS0Y2?=
 =?utf-8?B?ekREL2pKcW8yNHpxZXZyb0VkOGN0Q1RqMWNBRjBFcytSZU5sSDJqalVRU1g3?=
 =?utf-8?B?Mk1ydnhLZzZ4Wm5yaGNxampMNUl6dkNTOXhFbTA5ZUUrMFBtbFpvN093Tk1l?=
 =?utf-8?B?VFF0OTVnODNGYXgyWUE3dXpITEVhaS9TdnA1YUlyYXBiUXVIWXRNUnhxM0NK?=
 =?utf-8?B?enUrWFg3R1lXS1N6V2xZeGc5QjR6YlFqOVZsRytKcFQ2V0NmeUJ5bC91NUl5?=
 =?utf-8?B?VmFBbU45UlNRbHl6Wnl4VHhZeENYZTZnR1Q2ZzJYSmVwUnluOCtDbE9jWXZj?=
 =?utf-8?B?UjhFWTRrK3dwRVhraEI2cjVTc3dpT3RCWGJUQmJNbmZaSGhLUkVwV1V2S0pH?=
 =?utf-8?B?TEtxK0lPQ0pIenU0TzkxMktXNFJ3NXZsSVR2aWJtQUpWSk50UUV0ZmxPSjkr?=
 =?utf-8?B?RXJ5Nzdqa1pwdkVXVHA2WWZpWThiQmlSQ0d3UHhsQkE4L2pJWFBLcm5IV0xi?=
 =?utf-8?B?enYvRkpabGlmVUtYc3lkK2tBaUQwTlFUdjJNdHRZWXMrb29rMXVVeVFzTjl6?=
 =?utf-8?B?Uk81TUEwbHQyajkzdVROdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TjBjdldleHF5WVNTV0JUNSs4LzBJNkpaenk1aHZLbWJJMktkazB5TUZaLy9L?=
 =?utf-8?B?a2h5RjBlR1U2dmhEVHJmOUpydGJMKy9pZUtXU1NCZGRFT2VUUGtxSVB3Tmw4?=
 =?utf-8?B?TFgzYkNYaXNtZzJWRDdjbG4yUm1NenRGb1lOUmQyZ2lZTklyUm94N1MvK1Nl?=
 =?utf-8?B?Nlhtemh6M3U2aVVLTUdoUXBHUnVWQ1FVUUUrb3BLNmJZWVpmTUM1ellvamw5?=
 =?utf-8?B?bjhNTEJtYnh1ajdKUFN5QytFM0FwMlhQbEVyU2lNL0plQXRDa3RscTVwQTVp?=
 =?utf-8?B?dlNtaU9JMGg5a3VrcVJXSUVUaEdpbU8yYnBBaDUxQit1SWRWNk1NOHBPQkpw?=
 =?utf-8?B?bFY2NCtKaGM1bXkxU2x4QitWS1ZibTZVaDlQR281bXFIY2VIWTh2bHNPcTR2?=
 =?utf-8?B?V1dTNTVGVFRza3hWR0lNSjV6WU4wTlVwaGE3d1dIVE5LRjY5dzl1SFJFL2N5?=
 =?utf-8?B?b1dyanBqODZXZ2dYa1dwZHViOEZWOGF5cEh6K2hWUi9SZkR1aERkVEh4bENj?=
 =?utf-8?B?QkwwQnAxazBZK0J1WS9yNWFIVng1OUlid0xyK3VOMHlDMTNlK0lqY21pSDFW?=
 =?utf-8?B?SktzRXNidWlySVZjOStjSHhCbnlPdU51eTVyWUcrM3l2R2YzTnp5ZW8yLzFi?=
 =?utf-8?B?ZlBTOWRJaTg4YkRWRGRFVWpYWUUzTGNjL0JIbytYNk0wNGIyU0srSWp1NEVF?=
 =?utf-8?B?b2N1Q0tQSURNWWFrbVdQcG1aZnE2WEY0ZHJGa2czMWdvRHBvZC96UXJ5ZUJx?=
 =?utf-8?B?MjEzb2dwa05ld1A2SEd0QWJFdnhrbkVJMjhGMHArSVZ1NlVOWGJOS1MwSE1j?=
 =?utf-8?B?SnI2RVNlTFlnYWpSQWorelAxWWNIMkk1Tm5wUzZOQ2M1eVI3VWRTc1hTK3pF?=
 =?utf-8?B?bk9nRW56T2xReHpTRzFHUjZFZEY4S1QyY2VKRUtickFnNzdQSnp6M1dqaDFj?=
 =?utf-8?B?emo4WjZZTk9lVzNUTjhZU0t4ZGM2V2kxTHA3bjJ5QkNTUWlwRFBmbUcxVXh4?=
 =?utf-8?B?Zjc3NUREdkwzNmtVc1MwaGk0R29VeGF1NTh2bTgwc3lkaDFseHdEYVh3eFJS?=
 =?utf-8?B?ekxkUzc5TVowWmI4VWJieVpwYURXWVU0QkNqc0R6V2NrY29ONlY5eTYrMHR2?=
 =?utf-8?B?SzEvTkFyRUQvd1puUXpEMTZiZ1A2RlZVdUZiQWtLREEzcWZpc3JpMHRuS29t?=
 =?utf-8?B?T2VuelVTR3dQMHU3WFdoblVFbGVhVjVQZVZxajBzeTdkbWQ4OXdkU2tyTnJ0?=
 =?utf-8?B?anFCeFdxenhvL2ZQNTVkNUVJQzNkb21ITERmNWJWUWlLMkxPVzBpSVorczdw?=
 =?utf-8?B?SnU5R0VjT1NIbGg3ZDVydUUrQUttNmhvNTBlYTI3QTVnOXVTWXczNTd2OW0v?=
 =?utf-8?B?dTVMTnZaVkpHKzVudTNVV0FtWW1Ba1pmcEtYOUNPQXR2UWtZRmNocklkU2ZV?=
 =?utf-8?B?Mi9vd2NONndXUGVxRWdUMWErb1VteXJESkFuZjViUVpPcnEyRWxxY0FaSHdk?=
 =?utf-8?B?MDZRTHBkNzMvNXRBS2tqWGwxb3dMZVNUeGdZQzVOMXVhQkRBMXYwQ0JNeXp2?=
 =?utf-8?B?b1hIdkxaOTB3eXc2WFRqeVF4MUNPaFFlWWRVSUxNTWZXTXE2Z3lxOExHaFBw?=
 =?utf-8?B?cVpRK1lSUTFQSUIxbXVtSjdUelpvNG1OQVYzNngrSEpHSjNNWlI5RWtPaHRG?=
 =?utf-8?B?aUpkSkhjUFBBL0M3K2lEZHpFNXZzcWJPem1SUjE5ZExLWUF3VFYvdDVyem5j?=
 =?utf-8?B?LzVuVEMzVTJjWWtoZzlOY0dlUENDVUx5Y2g4bTV6bU5RRk1ZdDRnbjluTTRr?=
 =?utf-8?B?bEllQzFvdlZUdFFlZ1FSUFRhYmRwMmhVdDhXdXE3QnRXN1FLM1ZyamxzQ29N?=
 =?utf-8?B?Sk5ZWHNRdThxRHhpNUFOOFZwc3Z1UE8zOUluaDMwc3UvK1NsRzJCdEVlV29L?=
 =?utf-8?B?Q3d5ZDFZbjVHYXRJQ3Z6RURwa3dhazd3Q3NCeUU5NHhGYXpjbnR5eG4zYTdC?=
 =?utf-8?B?bmRNNzg3eG5TaWY3WDN1NTBUZUFldWVOd2J6RjlFZFRmNndkc1dMNllSRXVn?=
 =?utf-8?B?aHF2MW5yZzhUQmdFRDB3NDhTb2ZYWVNla1BHbElBMTZYSTV5ZllJcG1NeWtP?=
 =?utf-8?Q?xPUM2AUhCzBwU7IcbED3OXWIW?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	0xz9e7vMn2G3pGd8LylyHmEgeS0225wWlas05+YlU7wGuth9SgvV/h8/PWyLxSQpXTIG7UscJ99rXjk3cfkPehyfbB6zRJAlzqLAxjZmfhy5JfBOddHMqgOahIEndZFirlfFPar9tuHoIbDvhtECTZv2GyWPRQNuAu0Xx3Tn8wEt/8F7/49LFQFFAAxYyTQ79tvfeJz/EE+hWaDGpQTg5jN/igwc3mgBUuyQcNq1ljKrMt7auyF97iLObwjaa8KwpcFCqKIXjkZkDqTQxsYFvCHa3mPaOkfOQGCRyGPyJw6b8ptmRumpWDKMIaYLmAmuLswonfTmpop8Wcjzoe9fO1jkqWG3+SYSdvJjuVXSK2dD6z05mGLPOtTQn4gC5I7mkiQVaqkad/DrqOFQnvF93f2Qn8YISDVU2H81HsTak9EF9Ti2xaoW0UDhOTK8+QMMPFujmPTd6o2TNXjBQqJu3veJzgQVwH/AlKQLOBHxvKhcyzMffz4N2Wk+IY9ZcyPr4BlYo8OQuSePQkSrQPKP/MVYaZwZG9BRv5UwUUlznS2P876/WxqxlMnjtzSh1t9WqMTEGryeGM+TOu1VV1mUbRhR5yfN439iUQeSyL1VbOI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc38fe3d-7a01-4f40-9a31-08dd3965344c
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2025 15:14:58.9601
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EK0VqKO+10ySwUp3w/eFCzXmgzHvPUwD852i9jewnP6uhZITCYTcdNmWKRiq82XPOchd9VcB9/iGaeSNiF2/GA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB8128
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-20_03,2025-01-20_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 bulkscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501200126
X-Proofpoint-GUID: h49EyTrVbumRRJuMttydwY6T_73pvVCD
X-Proofpoint-ORIG-GUID: h49EyTrVbumRRJuMttydwY6T_73pvVCD

On 1/20/25 10:00 AM, Chuck Lever via Bugspray Bot wrote:
> Chuck Lever writes via Kernel.org Bugzilla:
> 
> On recent v6.1.y, intermittently, NFSD threads wait forever for NFSv4 callback to shutdown. The wait is in __flush_workqueue(). A server system reboot is necessary to recover.
> 
> On new kernels, similar symptoms but the indefinite wait is in the "destroy client" path, waiting for NFSv4 callback shutdown. The wait is on the wait_var_event() in nfsd41_cb_inflight_wait_complete().
> 
> In some cases, clients suspend (inactivity). The server converts them to courteous clients. The NFSv4 callback shutdown workqueue item for that client appears to be stuck waiting in rpc_shutdown_client().
> 
> Let's collect data under this bug report.
> 
> View: https://bugzilla.kernel.org/show_bug.cgi?id=219710#c0
> You can reply to this message to join the discussion.

I've created a bugzilla.kernel.org report (see link above) so we can
collect data in a common place. New comments on that bug are reflected
to linux-nfs@vger.kernel.org.

Instead of sending attachments to me or the list, please attach your
data to this bug.


-- 
Chuck Lever

