Return-Path: <linux-nfs+bounces-9041-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F626A081D9
	for <lists+linux-nfs@lfdr.de>; Thu,  9 Jan 2025 21:55:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66FBF1632FE
	for <lists+linux-nfs@lfdr.de>; Thu,  9 Jan 2025 20:55:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAA76200B95;
	Thu,  9 Jan 2025 20:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LnjXDSY2";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="W2Mg4zfS"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6D7F1FE475
	for <linux-nfs@vger.kernel.org>; Thu,  9 Jan 2025 20:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736456081; cv=fail; b=Fg1iOJnogTDifbU7VpkUE150d7FgPqvFDMG6Zxz+YfFaLfk4NPzgTyt1NnqRaE53gcuM05n3UGRDzIjEV7eLV7XELXX59XI9k8r0ZfGyq7GFnOqzVtlVXZpYTf3SniWUuyaSGjkFlE5ckfyCNFH5FElgQJLPDkS6ZCjs1zVMnZ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736456081; c=relaxed/simple;
	bh=jYNNPBj1ewY4D/t/YhK+JqO0lRSCqR0JZMtIX6l2zAI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SM9QOMa+g9Ojh2KarTKqBzo9M9hkbplzzJgKAlunLelurkHfOV1gutcVt+czfn9tiBv1N/5iwEgnwoSN5ZYRbdE0Ua49HN/9DjOZIhM6h0Hn4UntbJyMFv1lkdr9y96uJA14DUiyZ25qQzQUrYQsTm58ngCOH7szDwtLTaKCwRc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=LnjXDSY2; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=W2Mg4zfS; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 509JorKS028178;
	Thu, 9 Jan 2025 20:54:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=xagj+mQNVaGnwC//U/6pM64Ws2hZ7HRNNCbC04dfxjk=; b=
	LnjXDSY2xeJDEB2mNbGE/EfPDo9eUG/NTrH1lw0pwHXJ/UUZBl01GjQu+gAwX9M5
	J3ebVv4uQ1GjcTZVESatc0CZQ4JrO5tlBKDgK54g9DjdR4endQozsci4WegXanmu
	yViRVJVInqWxgghwMOtWDjHI1mOUA78oRny2Ab8TP8SICZjjI+tlnwvfU2g5seSM
	tDqt5mz04JYahZYJbrfyX6GqZAwylJ5VAuaqaUNXSL8vuYhVDJKi9SBSnZtK95c7
	kJYR5CjpU7R3rLlFwpi7VBCZp5qL8tNdL7015eE5q5xCQ2HTMavF5j5/vUIoR/57
	CK77G5CrvXl4mB2NiM7ZhQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 442my603mh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 09 Jan 2025 20:54:33 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 509K6vEQ011240;
	Thu, 9 Jan 2025 20:54:32 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2176.outbound.protection.outlook.com [104.47.59.176])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 43xuebeq7n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 09 Jan 2025 20:54:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WnkIpRyTB98uHQ/rRrDoAprXB2QPcSCKVxUmRY5KDaMODyk3OYYoFEJB8hw8ca+Pp2T70d8US5B9aka5wfNLDp62zI2TT176G/bs+iUV0KF6TLwW7ncUpTRzzNeRaWGcjgdYp4qfZC+Viu9tp/UUJbzbRmwcHGOrcjnTxf9HXSSvIomjj+L2xFHaffZdlkLmv/CoD/IwJ56EwvxI+a78N7EWO8agXJej0pnJ5rH7MIBpo/md7E2TPJJIsggduGHjhliMJduMJjoao6uKft7G90agT+zydrxJM3IbgCA3IWk9lFTNrueZvR7rk3F075X1aVRBxUZMG9SihLyFJoSgbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xagj+mQNVaGnwC//U/6pM64Ws2hZ7HRNNCbC04dfxjk=;
 b=VSeqoMLVN6r9jHaEIFTUvYI4ZnbZ5gVKMH5OX5UlnnsSLBusizsRcApyQvngvD/DH3UVDlz7dZRH6QsKDyhmVzqenhV+h/Tm8QN1PSJZwhBCDu5/h5cFzKAu85/P/4QEYWlr1Pv/0FBILJ3Jxb7wdhTouBXOu/z5Mys3gR6fyofyk7DyxHU1IYmZr1jEU4PLRZpewkH+RC0wErX17W+74F/qXMSB/ZDfkOhoaMgvSlpztpZontLwEPbTpB807vO/0gesbXQ3Dg7rlwS2WcXFJJ+XTKXBMPj8Db+CjOwc8xSHEcSO8vWvy48YBpj7swReVpQuBG0hk+KmSjWu9BBtGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xagj+mQNVaGnwC//U/6pM64Ws2hZ7HRNNCbC04dfxjk=;
 b=W2Mg4zfSHigpL8xhPYyBrChEF4Z9/hMNrLSF5UhYc4Ijew7lESrusX5gs5ZOlTttgecnNVGbK420nvqYikjkfBZnmP11zt+PwbvEEFiRte6i+p/6kh0T3xdV+ci3iC1vd3unl8zHQAb7bvNDKnIQSVgkAXfneLDmjjqxOp56LZI=
Received: from BY5PR10MB4290.namprd10.prod.outlook.com (2603:10b6:a03:203::15)
 by MN2PR10MB4125.namprd10.prod.outlook.com (2603:10b6:208:1df::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.12; Thu, 9 Jan
 2025 20:54:30 +0000
Received: from BY5PR10MB4290.namprd10.prod.outlook.com
 ([fe80::8c24:37e7:b737:8ba5]) by BY5PR10MB4290.namprd10.prod.outlook.com
 ([fe80::8c24:37e7:b737:8ba5%4]) with mapi id 15.20.8335.012; Thu, 9 Jan 2025
 20:54:30 +0000
Message-ID: <db2fecdd-47d7-40e6-bfc6-1acbf48d782b@oracle.com>
Date: Thu, 9 Jan 2025 15:54:28 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] sunrpc: Add a sysfs file for adding a new xprt
To: Benjamin Coddington <bcodding@redhat.com>,
        Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org, trond.myklebust@hammerspace.com
References: <20250108213632.260498-1-anna@kernel.org>
 <20250108213632.260498-4-anna@kernel.org>
 <8556AFF1-DA71-41C2-B3AE-6BE1F0883B37@redhat.com>
Content-Language: en-US
From: Anna Schumaker <anna.schumaker@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <8556AFF1-DA71-41C2-B3AE-6BE1F0883B37@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH5P220CA0003.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:610:1ef::21) To BY5PR10MB4290.namprd10.prod.outlook.com
 (2603:10b6:a03:203::15)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4290:EE_|MN2PR10MB4125:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c1a057d-65e0-48ff-2f9f-08dd30efcfe1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|10070799003|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?b3hnbHpZdlhLZ0RYYkhKekkzQXdUcnJWTXhFRmw0R241c2I5bjB1OGwwV3Ra?=
 =?utf-8?B?M3VhOFZZVHFNU2lINklOQkUyUnVKSjEydXVpTVpKa242WXcrU24zT0EvRXU5?=
 =?utf-8?B?TU92Z0NUN3pUNFJFQ09jQVdla05RdXBZSk96V1NsWm12V3plcFlpUE1NUDBM?=
 =?utf-8?B?WDVFRXZ1WnlxNVlSc3JJMlRNLzJQbHhoTG5YcTgvMldRVnZuS3E4QWcwY2Zj?=
 =?utf-8?B?by9hMkZrNXFtZHNRMnNLMXo0T1pYMncrWVZVcHhYc1YvVjM0S2k3TktjSnVu?=
 =?utf-8?B?NlRBZVFrTmd2M3dIcDJHTVpWbjd2dVRaVEdORDRKNnJ3N0JaRmw4ZytLSllo?=
 =?utf-8?B?MVJvQStMTjhzaURuVFowUFYxVkN2dFJLdEtRNk5seG5EaHBqNVdlQTk2Tjl6?=
 =?utf-8?B?RVRnYnBYYm5TZFppOWtzZnhhMFVUME5nSjRXdU5McnBiZEUrTDdMQ0owUlRW?=
 =?utf-8?B?NFJOd3liM01CdVo0UTgra0hJcVNtQllPZFVLWmJmQktrL1pXdUpuNlEyTktI?=
 =?utf-8?B?Sk1DaXJHOGxaT2pBc0ZVMFc3WUVIc3NwdUw2RlBVSlduMllLa2tMVE92SWxt?=
 =?utf-8?B?MXlRbWc3RUtCK2NoY0V0Qi9WM2svU0FJUTF0RGFlL2duOWNsalBNdjZNaU1D?=
 =?utf-8?B?d1E0dHFKSWVUQnNFam9NbFgxMFZBazBPdUNmTEZlWDYyRURraE0xRVlaZEZK?=
 =?utf-8?B?ZFdtTkVwWlQ3V0J3MTVVTWt5dUtqazhUTFNMczZBT0kvb0p6MWtnUUxIODYr?=
 =?utf-8?B?cVJTVVJtQ0tidGxMbWtUMEtUVTNLOXpEVzVHQ25saXNmc2lzQUx5NGcxZTU3?=
 =?utf-8?B?SHZvUGF5anpjYndaR1J2emR1dmxUYWlKdDk5Q1pKUFNiY2tyNlpiTWZQbG5Q?=
 =?utf-8?B?eWplVlJLVXNSTDB1OU9sVkdNZ3VzeHlBWHVmbUFwcWV0R1hCd0RUN1JtNmQy?=
 =?utf-8?B?aytVbS9ncHdiNng5eWNieWR0eG5XNDQrd1NHdmFKSVd6UVB0VThRQis2Mkc4?=
 =?utf-8?B?VlVTL0k2SlRBb3ZQVFdSK0l0QnBUNWNWNTlVNUFYQjhiVTBvc1VVa3VYQUdH?=
 =?utf-8?B?NloybE1uUERmWTBKdXR0RGZwaGVuSVc2NGxXNmNZN2RXcUNjeVBQL1U2ODZR?=
 =?utf-8?B?OWFnV1JROUtxUEF5QUtOR0hoZ3RHdWlXU1VjN1hEcDJmWnArRVRjUEY3Z1VH?=
 =?utf-8?B?WTF3QWxPTHk4Q2M5RVJyYldDRlNTdDk4Ulkxait3OGxZQ1o5MURLOWZlOFgv?=
 =?utf-8?B?dEtSbEt2Y2FTOWZiSFNuYkxBaWo3NFB3TUhoTDBjc2dTaHlEK01wTWJNcnMr?=
 =?utf-8?B?MUdpajFFSHhWMGlRQU8wNEhkcmFocit6Zm0wSVlqbDdsQ0d4ZFVTWXF4VVAz?=
 =?utf-8?B?VksrQUVwdGRIRTRORDNHK0xRaExkUzRFVjYrT29aU2F2dGJVcElBQlkxcVpp?=
 =?utf-8?B?S1JGR3czTzh2ZXpjY2dNRDk4anQrdjZFYXdRT09kQkU2R2k3UnVxMUJOVUwv?=
 =?utf-8?B?M3BPd0lMUCtBdEdJclRYa1pZY29xQm9CU3EzUEhEQmJsWVBYSTNEQkhneFk4?=
 =?utf-8?B?dTlZMlNHa3lwMlJnUkgwL1ljQktqQmt6M2J2azNlVXV6VFp5SU5Jby9Lc24y?=
 =?utf-8?B?bk1CY1F2LzFsL0pXWXdoakp2RDVCM2FDT2pPK0dmdmJBQ25XNW9ubEJqNm1M?=
 =?utf-8?B?OFpNSHptYVRMVUJUdlVKM1duNzVIcHAvMWdWVXNwdVFjdmZrN2pQSTZnaG5x?=
 =?utf-8?B?SENvM2FGZHl6RmVxbng0Q0orZWZEMUVoYzQ1WVQrWE0raVhLWVVnZUp4VlFv?=
 =?utf-8?B?V1d1eUlwNmRaVUlId2NlaS9zOEltQWIra2FWS3hiR0YwekFkamFyZjFBS0pq?=
 =?utf-8?Q?qQRHNX4AcTE5N?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4290.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(10070799003)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bGI4SDdtS241aVBHNVZTOVpvMFZ1Vnh4OG5lVWlwUVNqdFV6dzhKNERHdkx2?=
 =?utf-8?B?VnEvTWsxVzlvYllENHhIdjJZK1J0Z3ZTczByS3ZYMjFKdXB3c3VpclJzUyt4?=
 =?utf-8?B?bXRwZ2gwOHF2dHBDRXRYNWE4M1FaR1FnaDhwdUdGUlkvWXlzR3QvaUdWV2Yv?=
 =?utf-8?B?cWY1ZWJDYk02L09oRnI5dm13QlV0a0hJLy9IUk5ndGRRQnhYZXJoK3psWHky?=
 =?utf-8?B?K0NFMmlGOExEZml3KzNEQk1jdTVrMkdza2V1RHpmUDlHbEhjNmNRWGNqUTBY?=
 =?utf-8?B?Mm83RmVGQlVKa0J4YnFuczVqMmlwZWxOM1A3QTF5cXdadzlRUmtCQ2lxWVo2?=
 =?utf-8?B?clRpdUVZYTVwYXpVQjVYcS9sZUVQb05kdGdBZWV0VTlnWWJhT1VBQ1BrQlVr?=
 =?utf-8?B?TU03UUJQUU03eWdSNG1JT3ZtQ3NQeitocC8wUklKMS9tdFM4NWhUT0U2bFow?=
 =?utf-8?B?UWk1SThxbUpnaTgyR2swR01xSkRDejVyTVQxczJMeFFzb3B0dVdYUUNyeElB?=
 =?utf-8?B?TkZwcHZiOGdTTm9acy9FY2FFckplQnB2aHZONWh4bldwdDRia2NUditrM2Na?=
 =?utf-8?B?UU1SMjFOdi9UQUxXbklHOXQxNFBWdVdXdHNKZVUydnJCaXZkRStZWmswSUd3?=
 =?utf-8?B?K2MrYlZiMDVveCt1czQvM2h3VHBlRUFOMDN0clB6c3ppYlNmeitDaXlmNXNZ?=
 =?utf-8?B?NjZHZytiUHUzMFlTcmdMYmkzTU1GSVZsYmI1MTIyS21mOHh5Q3l4anFZVzNQ?=
 =?utf-8?B?dzBpTnRRVXdLb2lCYWVtbThEZm1MZFpsVWdiT1JOcmZKdHR0ajRJWVVtRldY?=
 =?utf-8?B?SWM4MFNMNEZEMjBMVk95S3pFcVo4ak5ldUFpV2U3VVRoc09yc01tKzQ3S1hr?=
 =?utf-8?B?QzNYTHI3bWc3U0hlU01DQmZWMkhRWENSQ1gwZWpSMXZUZ0s3Rnk1ZUxkVmd6?=
 =?utf-8?B?YzV2enhod2w3Wm9xUkhQTjVwMTJSOWppVmVjdHFqVjNZNzFzcjh3Zm5WRTFx?=
 =?utf-8?B?NnZwanowbytpakdXWGszOXVNRFFUaVVNa1poT096VGd3bFJMSXhtcGRaQ3li?=
 =?utf-8?B?ZzRCU3YyRWl6a0IrU1pRSXM5NlRzbGRSSE1QUDZKTCtGVW5abVBpd1owQlZS?=
 =?utf-8?B?MmlJNUpMUlNHRlAwV1hoRlFkMzRhOXZQczJKdkdLTEZFZlhYKzdwUm1WbkFQ?=
 =?utf-8?B?c3N5YTJmUkdQSVUxNGo3MFlEVHlkNFdBRnJhWjFPdjYzbUY4ZDFlSVRCb0Rv?=
 =?utf-8?B?emN3cGo2UkgvL01Dd0MvZlVVZHQ0TU9sWW5uWGY0SW9FVEZ2aTRSV2Vucklj?=
 =?utf-8?B?UjhkckR2K21tbjFha1V4KzNnZU1JQ1MxNzJneUNvOUF0N1RON3RRRDFaTXN6?=
 =?utf-8?B?c0FLU09qZjJ4QS82NWlRQndzeTBrR2hNYXYxVWZnVjRZSjV2MUpwT0tFbmhz?=
 =?utf-8?B?VkwzTXRMMzFXRjdLemlQUWxWU25OeTVkbk5VZ2YzcVBsUXlQRXF6NUpSL2xC?=
 =?utf-8?B?bnJnVkdvRVB4dGNOQmFVclRJTkN5cW1iMzRWSHFoVjBjd09EMFphU2owb1Bw?=
 =?utf-8?B?ckhnQUpxdVd3UURiUWZIN1hZSlpZN3cvbStmRjZmeisyZEdnQTdCK1lKTmZ4?=
 =?utf-8?B?U2FHcTFEa0JCWEU4OUU1anluOHoydmQ0bjFITjFCS3pFQ3I1LzZ0UDFuaGhK?=
 =?utf-8?B?YUltaEVocm9uWGRSVitTZ1pZS1ZiK0hHckdJK0JyQmFrMitndE5heE5Pd2pZ?=
 =?utf-8?B?d09pWEI4S2FHSnVJNjNlaXhEaFZjMUdFQmFZY2h2YTc0WFRIUGZkV3VxVDlX?=
 =?utf-8?B?Q1VxYkFqa2Y0c0tIWTRGMnNkdnB1UEtTRVpXakRqNXNaYkdISFdDRC9HUDFh?=
 =?utf-8?B?a1dkamdvZkVkcUFTRjBmeURrV2ZEaUdlcDBkRTZyOXA4aHZxNFFGcEdjYWVF?=
 =?utf-8?B?alhEUHZUekJHT0szd1pCMWFISW1xd2NLb2c3ampkemwwd3NoZTRQMDFIVnA1?=
 =?utf-8?B?YWd5U3JmUzRKV0YvYVJDMEVnWEdaMUlrdnZURmNoK0w3T29qN1RwK055dDFN?=
 =?utf-8?B?cXRJL1pDb3BjN0IzVVNhcC9sQm8vN1dNVGJMUjZldjVLRkE2OVprOXA0SklQ?=
 =?utf-8?B?ZnpEUXF0MmRmWSsyNWYrcWZla3A2ejBhVCtwd0N0QUpaNncwZm9SUERGdmRF?=
 =?utf-8?B?MnJiQjBvaG9oSkcwdnVvRTRNS09jSGlWREZlcDg2dVlOeFdwcFVuaFZhUDdD?=
 =?utf-8?B?Sms1blZYTzcyZm1aRXRmSmZZQU53PT0=?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	utO49gEYuXFRcZO2SwQkZVQjID/LYk8/9AxU8ZflV6ZxCzb6lq+BLHevxtOuv9rwi/JUGie+hS4mDF3+b4g6T2gIHZPJ0xgjrt4Bcr/uZQirei6PQMvon8Y1UkslppyhGcQRmZd3OhhhnvInp2T7mPlOHzkltoGpJH45U3jKl1Qz2GcR49fBKYuZhWqAYohOUHwAVuyx87V+uf7iBsOWG91Da3/gcY+U46eOexTzbJIF4Fzbme/i7RD9Z6Q1wBTw5MieVPnPAYSPT5fj2dO0GwR5aneD+7cxPIn1UhI9+xHGX9LEh10N/sbTXUJNmMVbUJ/iYclg3XJo7+keHCty2wQDQNElQT/87YoRLK6BspvfovMWKkw1nyK0S9NhV1pX8hdlYhew2bMPTA/xv71uh86RBbkeUn8cGwHNf66u33peD7UtFVmGnYGN6OwMpMLe16/rMdCCEaPV/LXf5HO/52I2tx5EE013998JB6PChnte3ycKM21igd6nKHZOzcahgcSN1sYx+zidREPv51KRAUh69PDkchXa/7v0KgXdYPIGr5etH/a99KxbsswHp5rcCe3HnhUl8BQx3yOkMRinN9+zhPB6zP0bMiNlYaEYk/k=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c1a057d-65e0-48ff-2f9f-08dd30efcfe1
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4290.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2025 20:54:30.1183
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3c4SpQpcazIH+LSBpHWurpVq9dqkxH2vfCSEeUMH7f/UEuW7BVrVniz6IcgjL2QlZoNqzzNoZOJwhrR9e95iVFsvsZ6H7jY8FdKBHJ7asQg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4125
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-09_09,2025-01-09_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 adultscore=0
 mlxscore=0 phishscore=0 suspectscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501090165
X-Proofpoint-GUID: GOIstelWT7z5rmYBznuQKVBCpXekelvo
X-Proofpoint-ORIG-GUID: GOIstelWT7z5rmYBznuQKVBCpXekelvo



On 1/9/25 10:10 AM, Benjamin Coddington wrote:
> On 8 Jan 2025, at 16:36, Anna Schumaker wrote:
> 
>> From: Anna Schumaker <anna.schumaker@oracle.com>
>>
>> Writing to this file will clone the 'main' xprt of an xprt_switch and
>> add it to be used as an additional connection.
> 
> I like this too!  I'd prefer it was ./add_xprt instead of
> ./xprt_switch_add_xprt, since the directory already gives the context that
> you're operating on the xprt_switch.

I'd prefer that too, actually. I don't know what I was thinking going with the longer name, and I've made that change for v2.

> 
> After happily adding a bunch of xprts, I did have to look up the source to
> re-learn how to remove them which wasn't obvious from the sysfs structure.
> You have to write "offline", then "remove" to the xprt_state file.  This
> made me wish there was just a ./xprt-N-tcp/del_xprt that would do both of
> those..

`rpcctl xprt remove` will already do both of those in one step, if that helps. But I can look at adding in 'del_xprt' if you still think it would help.

> 
> .. and in stark contrast to my previous preference on less dynamic sysfs, I
> think that the ./del_xprt shouldn't appear for the "main" xprt (since you
> can't remove/delete them).
> 
> .. all just thoughts, these look good!

Thanks!
Anna

> 
>>
>> Signed-off-by: Anna Schumaker <anna.schumaker@oracle.com>
>> ---
>>  include/linux/sunrpc/xprtmultipath.h |  1 +
>>  net/sunrpc/sysfs.c                   | 54 ++++++++++++++++++++++++++++
>>  net/sunrpc/xprtmultipath.c           | 21 +++++++++++
>>  3 files changed, 76 insertions(+)
>>
>> diff --git a/include/linux/sunrpc/xprtmultipath.h b/include/linux/sunrpc/xprtmultipath.h
>> index c0514c684b2c..c827c6ef0bc5 100644
>> --- a/include/linux/sunrpc/xprtmultipath.h
>> +++ b/include/linux/sunrpc/xprtmultipath.h
>> @@ -56,6 +56,7 @@ extern void rpc_xprt_switch_add_xprt(struct rpc_xprt_switch *xps,
>>  		struct rpc_xprt *xprt);
>>  extern void rpc_xprt_switch_remove_xprt(struct rpc_xprt_switch *xps,
>>  		struct rpc_xprt *xprt, bool offline);
>> +extern struct rpc_xprt *rpc_xprt_switch_get_main_xprt(struct rpc_xprt_switch *xps);
>>
>>  extern void xprt_iter_init(struct rpc_xprt_iter *xpi,
>>  		struct rpc_xprt_switch *xps);
>> diff --git a/net/sunrpc/sysfs.c b/net/sunrpc/sysfs.c
>> index dc3b7cd70000..ce7dae140770 100644
>> --- a/net/sunrpc/sysfs.c
>> +++ b/net/sunrpc/sysfs.c
>> @@ -250,6 +250,55 @@ static ssize_t rpc_sysfs_xprt_switch_info_show(struct kobject *kobj,
>>  	return ret;
>>  }
>>
>> +static ssize_t rpc_sysfs_xprt_switch_add_xprt_show(struct kobject *kobj,
>> +						   struct kobj_attribute *attr,
>> +						   char *buf)
>> +{
>> +	return sprintf(buf, "# add one xprt to this xprt_switch\n");
>> +}
>> +
>> +static ssize_t rpc_sysfs_xprt_switch_add_xprt_store(struct kobject *kobj,
>> +						    struct kobj_attribute *attr,
>> +						    const char *buf, size_t count)
>> +{
>> +	struct rpc_xprt_switch *xprt_switch =
>> +		rpc_sysfs_xprt_switch_kobj_get_xprt(kobj);
>> +	struct xprt_create xprt_create_args;
>> +	struct rpc_xprt *xprt, *new;
>> +
>> +	if (!xprt_switch)
>> +		return 0;
>> +
>> +	xprt = rpc_xprt_switch_get_main_xprt(xprt_switch);
>> +	if (!xprt)
>> +		goto out;
>> +
>> +	xprt_create_args.ident = xprt->xprt_class->ident;
>> +	xprt_create_args.net = xprt->xprt_net;
>> +	xprt_create_args.dstaddr = (struct sockaddr *)&xprt->addr;
>> +	xprt_create_args.addrlen = xprt->addrlen;
>> +	xprt_create_args.servername = xprt->servername;
>> +	xprt_create_args.bc_xprt = xprt->bc_xprt;
>> +	xprt_create_args.xprtsec = xprt->xprtsec;
>> +	xprt_create_args.connect_timeout = xprt->connect_timeout;
>> +	xprt_create_args.reconnect_timeout = xprt->max_reconnect_timeout;
>> +
>> +	new = xprt_create_transport(&xprt_create_args);
>> +	if (IS_ERR_OR_NULL(new)) {
>> +		count = PTR_ERR(new);
>> +		goto out_put_xprt;
>> +	}
>> +
>> +	rpc_xprt_switch_add_xprt(xprt_switch, new);
>> +	xprt_put(new);
>> +
>> +out_put_xprt:
>> +	xprt_put(xprt);
>> +out:
>> +	xprt_switch_put(xprt_switch);
>> +	return count;
>> +}
>> +
>>  static ssize_t rpc_sysfs_xprt_dstaddr_store(struct kobject *kobj,
>>  					    struct kobj_attribute *attr,
>>  					    const char *buf, size_t count)
>> @@ -451,8 +500,13 @@ ATTRIBUTE_GROUPS(rpc_sysfs_xprt);
>>  static struct kobj_attribute rpc_sysfs_xprt_switch_info =
>>  	__ATTR(xprt_switch_info, 0444, rpc_sysfs_xprt_switch_info_show, NULL);
>>
>> +static struct kobj_attribute rpc_sysfs_xprt_switch_add_xprt =
>> +	__ATTR(xprt_switch_add_xprt, 0644, rpc_sysfs_xprt_switch_add_xprt_show,
>> +		rpc_sysfs_xprt_switch_add_xprt_store);
>> +
>>  static struct attribute *rpc_sysfs_xprt_switch_attrs[] = {
>>  	&rpc_sysfs_xprt_switch_info.attr,
>> +	&rpc_sysfs_xprt_switch_add_xprt.attr,
>>  	NULL,
>>  };
>>  ATTRIBUTE_GROUPS(rpc_sysfs_xprt_switch);
>> diff --git a/net/sunrpc/xprtmultipath.c b/net/sunrpc/xprtmultipath.c
>> index 720d3ba742ec..a07b81ce93c3 100644
>> --- a/net/sunrpc/xprtmultipath.c
>> +++ b/net/sunrpc/xprtmultipath.c
>> @@ -92,6 +92,27 @@ void rpc_xprt_switch_remove_xprt(struct rpc_xprt_switch *xps,
>>  	xprt_put(xprt);
>>  }
>>
>> +/**
>> + * rpc_xprt_switch_get_main_xprt - Get the 'main' xprt for an xprt switch.
>> + * @xps: pointer to struct rpc_xprt_switch.
>> + */
>> +struct rpc_xprt *rpc_xprt_switch_get_main_xprt(struct rpc_xprt_switch *xps)
>> +{
>> +	struct rpc_xprt_iter xpi;
>> +	struct rpc_xprt *xprt;
>> +
>> +	xprt_iter_init_listall(&xpi, xps);
>> +
>> +	xprt = xprt_iter_get_xprt(&xpi);
>> +	while (xprt && !xprt->main) {
>> +		xprt_put(xprt);
>> +		xprt = xprt_iter_get_next(&xpi);
>> +	}
>> +
>> +	xprt_iter_destroy(&xpi);
>> +	return xprt;
>> +}
>> +
>>  static DEFINE_IDA(rpc_xprtswitch_ids);
>>
>>  void xprt_multipath_cleanup_ids(void)
>> -- 
>> 2.47.1
> 


