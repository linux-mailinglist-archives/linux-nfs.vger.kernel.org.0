Return-Path: <linux-nfs+bounces-7258-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85CF69A2FD9
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Oct 2024 23:34:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C0CF28572F
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Oct 2024 21:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 941591D5CF1;
	Thu, 17 Oct 2024 21:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QqwyuKZi";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="o+qbaKi+"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B9981D5ABE
	for <linux-nfs@vger.kernel.org>; Thu, 17 Oct 2024 21:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729200888; cv=fail; b=tXdurfUV1IuRFnuZey1rI7wKq8FuKmSPyipXHx6BtwTnRQZ3enHoJasrmhn8nS6wJTHo1IlJiePzWFWtZKQRt5B6DgOXDmnLA7cJjoL15xTYZn7eDI+Qki0q5rjXY9UJspY8NDT68RvnqtuAmZbNuyB34PlA053vcvwfz3ytw7E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729200888; c=relaxed/simple;
	bh=7FhVAvcT8NycuFIBEzGL8qm6Au8ruTL2EPgGVE1FU3A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RpLbOf7pGA7XpZ5ybcMmpXBWp2qsAvuKobXpM2qQtxNpGF3Ud7asTg5t0mJ6IBWfehssMOBKDPujU2u+V12BYbIF/szRgVwU8WV8qvpDks3NMUE7AqzPxZA3PkwIBvzH+Pfy+LXWgG29uDnkQqNe6X7xJK3PxyAHlD8mXrlfiME=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=QqwyuKZi; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=o+qbaKi+; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49HKu5ul002819;
	Thu, 17 Oct 2024 21:34:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=tb5/60MR+tfg/a3xt8XYLLKXV/31j1RLqS5ItFh5tvo=; b=
	QqwyuKZioYWbG45rogXtcU47zHTYQdh9IpGU29lnS9+3jbRP5bqwZMNYShTfOjrM
	8A6yxO0vrH9ESC8JAvAiD9QFClPkYD179HNfolste2mMXSFd0T9y5wUN6KClI3pf
	ahc0a0X5kBF4H/2OBVainztCQxEvq/zk+egWql7ZAx4ZIY385E8iC5RvSNrJdI72
	z8DYSC6P+pQju6PFlxcc2yxGIaIsaAaRAX9tqNKh2lpr1SN6YU2Uv67BTv8RjVvQ
	1PEtIQ23aHRCMT3HGqZIStvVNc8ASqtHGuR6vRXERA+uQ/JHr+L7ssEci9VZLGKZ
	G7TQg8P2K+Us0hd0YvwaNA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427gq7qgs5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Oct 2024 21:34:27 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49HKbLfM038706;
	Thu, 17 Oct 2024 21:34:25 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 427fjhascy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Oct 2024 21:34:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rVvU6+/dRsFv899gIGt7Wvdxg2VSnH75upbEHvToBYOPUKynfydPqBqJODorxV98JGtx2LbCkMfW9h/Z9sPGqRbCKZHXvgB+1e83yLhoO1i/qrESrAZylU4hlfP7bVcMZWCl/z5WOxx3sEiQwv4S56oet4TG43ILiJ/Cc7ct8HVPyOUiVkA+GtTjSKs9q1Lq5+YhJEebvK5C5D9BKp5u/Zcudh/5NNZtO5ExnasnT9v/xAFRmldCHy2F6nuZ2/LWpXZ0Bh7OVRtcAMIZ8KYtDuPHMB7X+hDYpTwZnaJ3esJaxxlSQY5ncOyHXmeZw1UnMGQOy9LzmvkCqn6Dih3rAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tb5/60MR+tfg/a3xt8XYLLKXV/31j1RLqS5ItFh5tvo=;
 b=Jm/h/z52P5R5ZyguapKj+EQLrBEExeOwA9wiuVDydNK58uvMQ4C/yXwkocEyUbO1LA7SKdIciOchUOND85OBFBUEad+u/cUCGCgSKUzKI69JkI4BLZmfpb8hrlz0scH6KNaX68eX8LHiowKypHS0rDCYWRbA5qMa4V1TC+B2sv3SCfgFaY+1v9JxKpb2nVE57lLIK2m/bsoVmCSiSRwHnoOEw9rfIMHsr0vayZjJWFG0HegN5Ypyh3aEEy1JeEv9Q9qv6AvyDEie/6SO9LcWdwAiaV3UFYmJvEUP6ijpR/UW1REfQr2R6mH9iLVQgSgFs6XHVlMQktkCjgs7ynFeWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tb5/60MR+tfg/a3xt8XYLLKXV/31j1RLqS5ItFh5tvo=;
 b=o+qbaKi+ZOgjmSbqnHKofu+50s3IzSWQXoeLxmP8ky5PDH66+l4bOEdKW7QfNOFMjN6g7nXMmpFKAPwd+2plR4P++gMwy+wgg3DxUEtNa8Wc4JTlfd6qzdHl5yZbKlpEB/xdMoh/yBMCEJySU8NFrtHAk7I4dqcbZG132aOBJTc=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CYYPR10MB7675.namprd10.prod.outlook.com (2603:10b6:930:b8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.20; Thu, 17 Oct
 2024 21:34:23 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.8069.016; Thu, 17 Oct 2024
 21:34:22 +0000
Date: Thu, 17 Oct 2024 17:34:20 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: NeilBrown <neilb@suse.de>
Cc: Jeff Layton <jlayton@kernel.org>, Chuck Lever <cel@kernel.org>,
        Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <dai.ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 5/5] lockd: Remove unneeded initialization of
 file_lock::c.flc_flags
Message-ID: <ZxGC3GvzFiFrvN/9@tissot.1015granger.net>
References: <>
 <03d89ad174357456abf2053e22bfd61ce59b5658.camel@kernel.org>
 <172920015817.81717.7256529679417338308@noble.neil.brown.name>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <172920015817.81717.7256529679417338308@noble.neil.brown.name>
X-ClientProxiedBy: CH2PR14CA0051.namprd14.prod.outlook.com
 (2603:10b6:610:56::31) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CYYPR10MB7675:EE_
X-MS-Office365-Filtering-Correlation-Id: bff2eed4-5228-4337-1b9a-08dceef3776f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QjZxdU8vYXhJajc2NWFCRkxIZS96cS9za1RIVDRzTEIvdzRwMFZpR1M4Slpu?=
 =?utf-8?B?YnZ4VUZKQTkzT1V2NFI5ZFV4cnVhZ0NSaUcyUk5DV3N0MUZLQmFScVlQRzdY?=
 =?utf-8?B?RjR2Mi9iOG5zc0xUVktJaXhIVjJOODVxV2ZMU0txNDlMZnd6Zk1jSE80Qk5h?=
 =?utf-8?B?ZFhDVGs2eEdNRkc2ZFFZa0pCTkc2M2k1bHFSVmRoR205ak5HNjlPYUhOa1Q5?=
 =?utf-8?B?ZU1BOTBCNDNTWGlhZlAzYmtJZDBjN2pFWjIrZm43anJiTWhtN2VKNUlKd2dJ?=
 =?utf-8?B?ck9GRGFFNFdyOGN3UTFqbTFwWmY2ald6TEtKYTZzNFAwRCszdDJvUlFhNlJP?=
 =?utf-8?B?aHc3YXlHL1kxWTBxbE11Z1hpRmovY0VNcnFKWUhEbk1EVzdYN2NjQWZib0pT?=
 =?utf-8?B?U09tMGRva01PNjZIM2pmOVpSRHlNWXhFWCtXL0JueFRiajYxcFJqY2hrSmFl?=
 =?utf-8?B?L2gwTXJaSmlyL1k5MEhEdmJLcWNSSU9qbVI0T2QyaXJXcnFqNzV5V2RKOG1T?=
 =?utf-8?B?YTQ4aU55Tk1Nc2FBWXYxUTNzZ05kNFdwL0QzZDdOZlNES252OGF3WmJ5YVZ6?=
 =?utf-8?B?UXJ1b3BBSHdiMEtPaEMyL1MzNVNqT0ZVOE9GamlRNTFSNTdsL1k1S0p3a3dF?=
 =?utf-8?B?blpId2UveUlUeG1Xb3NINUNXL2Q5MUtPTHZBbDA0aDhndHNxMW9lZGlaSEFU?=
 =?utf-8?B?RnAyZFpwTFlWOGdmUFpWVFFJR3hDWWFYN1hleEtwVkFMUEJGT2NyNGpRZFdz?=
 =?utf-8?B?NnBmOFFNS1BuanlYemY3c0IwQlBhTE5MM05KcEJQdTRldjdqZHovM1RzbjZq?=
 =?utf-8?B?ZllTbVU5U28rZURWL0dCNDVxcTkraXgzSGhRN0NJQTh4ZDRTVzdhQThOSHRz?=
 =?utf-8?B?WGRvWnNMODhVWDlOcFJzeWlaamZtcjc4Tjh3ZkR5M2NmNnhwLzhpcGlLR1pi?=
 =?utf-8?B?cXVBSHJaa21JYVYrdzRLSDZITUZLVjBlcmFoMElIWFpldFlZLzFyZHpBYk94?=
 =?utf-8?B?NXNzZy9iUFplOXJjN0ppUFR1TWVKck9xUW8xYnZWWVVsSUw4WUxZRWEzNzhu?=
 =?utf-8?B?aWZsd2pQQ2tuSnVaZVY4REZiTUdCemcwZXFJNjFNK3BkVDVwTG1mNHNPK2M5?=
 =?utf-8?B?Qmhqd2hycFlRaTBvYXhHMDJSSW14Q01oYkh4YUt1QmpzNUprdFlNRktONU1P?=
 =?utf-8?B?bGZHeG9wZE5EeDB0UjVwQ0FNWEkzQnR0bWo5VklrTUw5U0ZJcFRFWEZKUWZm?=
 =?utf-8?B?aXpGVFppSEpGRkZ5ODh3RkREeUxRVHRjOEwrY0FWbjh0dW12VEM2aTh6ZGM2?=
 =?utf-8?B?SzBtcmM5V0FsMEZOdExWZHJxMjRpdHYyQ1hTUTB1UHNqSktmTUFOSmgwUzZX?=
 =?utf-8?B?bHZIR1Z2MHk5dG9lZmhMTGgvTG5VWjVGMkIvN3lDU0k5dEFObVcvZklzYngx?=
 =?utf-8?B?YVZqQW94NEFNRWNhMUw4Y1MxQ1FhUjBvNjhiaVU0d3VjV0lsS2xMQkg3eTVW?=
 =?utf-8?B?MTRqT3lldUNkVjdWWU8wcFg3WVNwWlp2TnI3NmIyUENoSjgrWDVyWFliTm1L?=
 =?utf-8?B?UWdBMlM1ZlpqV20wcG5USTVBczUyUmNXM016TlpOc0hmVndxYmp0QzQ3S3cv?=
 =?utf-8?B?bW1WRDZPVzFhcDBjcHFOcmlPNXJVMUNSWjJhQTV2ZGZvZkluUUpCM1ZVOFBI?=
 =?utf-8?Q?gAweCfN3v0IXj+yZ7FCu?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RWZNQmZWaHdaWTAvMm5aelgrYUx2aXpDOEZTakJWR3QzL1dUeDlHeHVzbjF1?=
 =?utf-8?B?MnVGd2FNa2hPZCtZWnZmOVJoeWJyS3BneEFiNmJGa2hPSFM0dWx4NHFaZEFq?=
 =?utf-8?B?Ykw0eHpiUmRqQmRmY0R2SmYxVVloekpzamJZWnNzNE5hRFlpNWpHUUplYzIr?=
 =?utf-8?B?d296SXhSSmFpVmNqNDhac0VLL3VJaU1HUUlKaHpPWUwwL2wvRTBJQWthKzM3?=
 =?utf-8?B?d3pPVk9OckdXM1JYY1lGa2ZEdTYyMlV3bTB3cXFPQ0Q5eHNxUmxoUzVjVjd5?=
 =?utf-8?B?enhNL2x2WTN2Vk45YXRraUx4cE1uVU8vY0lWNFJJcmg1TVkwS2tnTThzQmJq?=
 =?utf-8?B?aXYxeVlqOUZpT2IzU0IyTXN5bXNCVWIyNDZqMHc2NzNCbGNRZEhDeXkvL2dM?=
 =?utf-8?B?K0NtbFh4WS9McjE3SjA0T2FueFJ0b2tTV1E1NWIzbXptS1N1bks3NXdoaWhZ?=
 =?utf-8?B?T2RZM3VDd3VPQ21zRnF6VDZJc0xrVzc4MkhpNi8rTFhtK1M0cW4wb1FVT0hk?=
 =?utf-8?B?OXlpNEtBdlZxTDFFTE1YSFNlY1dzQmR0MERvQ2hyaGtOV0RRMlBKaUZsTnNQ?=
 =?utf-8?B?TUFPQ0JaQmRnaU1HbTh1bXhpckhaRFVDM0tlWG5IdU9sSFVqWnRWNnNOM3Fa?=
 =?utf-8?B?Q0JFVlBrTC91OGN0Y3hoNWROVFhtcDJKV1J4eVNBRzY5a3N2MG1EYnFRakM1?=
 =?utf-8?B?NFNwWHJJTVU0WTVUS2d6cFYzamc1ZE5JKzhBZHF6SFEzOTJGL0RUMDk4bWg5?=
 =?utf-8?B?UzArdE1ackoxYzJUd1UwRVQxcDhPZXVuT0YzNWpQdnNFMk1nazdBNFNkS1Ja?=
 =?utf-8?B?Q0lUeXd1QjhyM1R0R0ZHQkhVckZTVjM0ZUtyZDVnRjdOalN4WjR5S0pRNlNw?=
 =?utf-8?B?emNLOFhvUmYxcWRRdUFNNGpkZjdjUzRDR3prZS90Q0NuUldYblkvTXMxZFh3?=
 =?utf-8?B?b1F0VTlSS2lXekI4MS9XWGIvQXFKdEZtejcyRnF0QlZjb01YdFoxZDR0Vzlv?=
 =?utf-8?B?L3pHSFNkcnpIa21mR3pmWHNXVFJteHBnbFdSWUcrRkVhSXFzcFh4anl1M2Yr?=
 =?utf-8?B?eStmM0VuSVZHbGozVmlUdFZiOUhCN1pLU0pQb0ROMUpPU3VKd1NTZVlFTUF6?=
 =?utf-8?B?Q0d6MVpkdU0yRUtJWVVuajJMNEd3NVNHOHRwY2NNVFZJMHNFUGlPQUk2ZkNI?=
 =?utf-8?B?eklRY3BwWnZDWXBxU3Zwc1NsVkpRRUtzY3doNDAvc3JtMjRDQ0oyL0p5M1NF?=
 =?utf-8?B?b1ZMMjFQTmI0bWFzRTZHb3ZrdldTdGdmTU5oa1dFdndGQTc3cXJLM2FVZ2Nv?=
 =?utf-8?B?SHBkMVlTRGlUMXFSc2NlL3duU2ZuZENIWG1jb3RXWGRoeld2QmdjajBLTVZZ?=
 =?utf-8?B?dWJRV1VOWUdPZkdZQ3k1anVmQ2NVc0tXY040TGR2ME1xU3BGd1JVYmhwTmRH?=
 =?utf-8?B?S0JkaDdJVGxiWnRMTEdCdlM4aEs3NmtiMmhqNG1CdXZKOHpLRE55MTFxQTRV?=
 =?utf-8?B?YlBIR3I2NUN1NTU3MFdScVpBWTNmSUpZL2tSenJyeW9yWmkyL21ZYlNyQ1Rj?=
 =?utf-8?B?U2tIT1NGODlKZ2g5aURLazVTM3ZKZ1FJelhKWXVIWS90MkxtbkNYUjRzMDk3?=
 =?utf-8?B?VjNHaFpmWTF2U3dENkFuWUUyRFVTbkhxSG1UQ0JsdGJraFJQbVBYOEF1Vmc0?=
 =?utf-8?B?N0pUWTJ0cEhqWDFLMk5yL24xREpvY1hzQ0JkRHJkRFRQMlZZUnFpTzEwT2g4?=
 =?utf-8?B?bzBacEY1QmYycGJEVUF3NkNKMlliVE1nSTBKTVNVRFlsYnl4dFNZZm1IYmJL?=
 =?utf-8?B?ZkNFVzR6Mm9WeDRueS9XSWFnZUhmZEZjUW4xNVpsZk9PK0xYKzNUSk0yVEZ1?=
 =?utf-8?B?b0dsOUhvK28zeGhBOUJ6NksxdDlRWWNhLzR2bkZSTUZtSElQTXFhOGdlMnN5?=
 =?utf-8?B?cmF5TjJlc050ejJjcVQ2SndFUjBxNHJCOTdueW1zTW5GWDVJWS95ekRvV2FG?=
 =?utf-8?B?VFlkUVo4OG1IMmlPMHp3UXdNYkpVazhEWWdlZnJCUytoL1VUMHJhK0NTdjZK?=
 =?utf-8?B?RkdZR1lDbVBNczZpWE5oanBWWUpTSVVicmk2bW5kSExFeFFSOTlyNDJKalpX?=
 =?utf-8?Q?Q86UxdQIiJdR8S8cq497uTC8U?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	QMZ1D8BHSj2EnfqjtP7WX/lbM4dCBzhEhmEDNX6EKLq02lMmupYg9Rzdb104S6zEAQiGmipgLF+e6dF9U3dacUBef4oVgvo/wjN8PPWkvGzmG7Kxeek+cAffv/gW0og4wHpZVMcywwExh+FEpbetOFoY3hLhgAX0aMVKYf9XPamklHVnij8fi+cWpGos61XIxKqv43HYAU4dvyUgZLRXb+8Pjhj5TB3hxd2apQdBu7KW7mwsokQys33Y9JdxRRuFAtKMp5wFuuAmL5h1XIzcPuVmbhDhu+ig6wW0L5BMyw90k7i4mmZyD77Fb8KE4xViF+ZpQFRoH2qdA/Q2KGqFZvROV7tVXZHnf4dqmIz8w7kkkd7nUYyog8hep0piw754f+mrdw1EPizhfB92+Yp0MV6KWMO6OaT/sO75JH11ZBWDpnicz/n/Zti40B0qmymvOyqpjXzcOqT+CP4gCIUlxHoykvHMzdEatCcSLmhMqM45jt6cpMDKaIr6UYUTrzGs1FeSXwk80NHa2iQziPrXrwxzDA3+kJetn5bBrWa4D55op+tjMpAyqaoW9hddLnGO/ZkfkEuxsrA/xrbPBYmZT2+TqH5sWQ7M8CsVa96+lkk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bff2eed4-5228-4337-1b9a-08dceef3776f
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 21:34:22.9145
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hltLJDWlMbyFo5wkVpmH6RO+huYGgUcabouAE1nZmpbf/P2zZ5QhQZZdZbPjZHnG2Y6hUdfiRJheVO4kN8qe/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR10MB7675
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-17_24,2024-10-17_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 bulkscore=0
 spamscore=0 phishscore=0 malwarescore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410170145
X-Proofpoint-ORIG-GUID: 5H7NKHjXYnrpFdSDfNlUxPu-AgjwB1VQ
X-Proofpoint-GUID: 5H7NKHjXYnrpFdSDfNlUxPu-AgjwB1VQ

On Fri, Oct 18, 2024 at 08:22:38AM +1100, NeilBrown wrote:
> On Fri, 18 Oct 2024, Jeff Layton wrote:
> > On Thu, 2024-10-17 at 19:16 +0000, Chuck Lever III wrote:
> > > 
> > > > On Oct 17, 2024, at 3:13 PM, Jeff Layton <jlayton@kernel.org> wrote:
> > > > 
> > > > On Thu, 2024-10-17 at 09:36 -0400, cel@kernel.org wrote:
> > > > > From: Chuck Lever <chuck.lever@oracle.com>
> > > > > 
> > > > > Since commit 75c7940d2a86 ("lockd: set missing fl_flags field when
> > > > > retrieving args"), nlmsvc_retrieve_args() initializes the flc_flags
> > > > > field. svcxdr_decode_lock() no longer needs to do this.
> > > > > 
> > > > > This clean up removes one dependency on the nlm_lock:fl field. No
> > > > > behavior change is expected.
> > > > > 
> > > > > Analysis:
> > > > > 
> > > > > svcxdr_decode_lock() is called by:
> > > > > 
> > > > > nlm4svc_decode_testargs()
> > > > > nlm4svc_decode_lockargs()
> > > > > nlm4svc_decode_cancargs()
> > > > > nlm4svc_decode_unlockargs()
> > > > > 
> > > > > nlm4svc_decode_testargs() is used by:
> > > > > - NLMPROC4_TEST and NLMPROC4_TEST_MSG, which call nlmsvc_retrieve_args()
> > > > > - NLMPROC4_GRANTED and NLMPROC4_GRANTED_MSG, which don't pass the
> > > > >  lock's file_lock to the generic lock API
> > > > > 
> > > > > nlm4svc_decode_lockargs() is used by:
> > > > > - NLMPROC4_LOCK and NLM4PROC4_LOCK_MSG, which call nlmsvc_retrieve_args()
> > > > > - NLMPROC4_UNLOCK and NLM4PROC4_UNLOCK_MSG, which call nlmsvc_retrieve_args()
> > > > > - NLMPROC4_NM_LOCK, which calls nlmsvc_retrieve_args()
> > > > > 
> > > > > nlm4svc_decode_cancargs() is used by:
> > > > > - NLMPROC4_CANCEL and NLMPROC4_CANCEL_MSG, which call nlmsvc_retrieve_args()
> > > > > 
> > > > > nlm4svc_decode_unlockargs() is used by:
> > > > > - NLMPROC4_UNLOCK and NLMPROC4_UNLOCK_MSG, which call nlmsvc_retrieve_args()
> > > > > 
> > > > > All callers except GRANTED/GRANTED_MSG eventually call
> > > > > nlmsvc_retrieve_args() before using nlm_lock::fl.c.flc_flags. Thus
> > > > > this change is safe.
> > > > > 
> > > > > Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> > > > > ---
> > > > > fs/lockd/svc4proc.c | 5 +++--
> > > > > fs/lockd/xdr4.c     | 1 -
> > > > > 2 files changed, 3 insertions(+), 3 deletions(-)
> > > > > 
> > > > > diff --git a/fs/lockd/svc4proc.c b/fs/lockd/svc4proc.c
> > > > > index 2cb603013111..109e5caae8c7 100644
> > > > > --- a/fs/lockd/svc4proc.c
> > > > > +++ b/fs/lockd/svc4proc.c
> > > > > @@ -46,14 +46,15 @@ nlm4svc_retrieve_args(struct svc_rqst *rqstp, struct nlm_args *argp,
> > > > > if (filp != NULL) {
> > > > > int mode = lock_to_openmode(&lock->fl);
> > > > > 
> > > > > + lock->fl.c.flc_flags = FL_POSIX;
> > > > > +
> > > > > error = nlm_lookup_file(rqstp, &file, lock);
> > > > > if (error)
> > > > > goto no_locks;
> > > > > *filp = file;
> > > > > 
> > > > > /* Set up the missing parts of the file_lock structure */
> > > > > - lock->fl.c.flc_flags = FL_POSIX;
> > > > > - lock->fl.c.flc_file  = file->f_file[mode];
> > > > > + lock->fl.c.flc_file = file->f_file[mode];
> > > > > lock->fl.c.flc_pid = current->tgid;
> > > > > lock->fl.fl_start = (loff_t)lock->lock_start;
> > > > > lock->fl.fl_end = lock->lock_len ?
> > > > > diff --git a/fs/lockd/xdr4.c b/fs/lockd/xdr4.c
> > > > > index 60466b8bac58..e343c820301f 100644
> > > > > --- a/fs/lockd/xdr4.c
> > > > > +++ b/fs/lockd/xdr4.c
> > > > > @@ -89,7 +89,6 @@ svcxdr_decode_lock(struct xdr_stream *xdr, struct nlm_lock *lock)
> > > > > return false;
> > > > > 
> > > > > locks_init_lock(fl);
> > > > > - fl->c.flc_flags = FL_POSIX;
> > > > > fl->c.flc_type  = F_RDLCK;
> > > > > nlm4svc_set_file_lock_range(fl, lock->lock_start, lock->lock_len);
> > > > > return true;
> > > > 
> > > > 1-4 look fine. You can add my R-b to those.
> > > 
> > > Thanks!
> > > 
> > > 
> > > > For this one, I think I'd rather see this go the other way, and just
> > > > eliminate the setting of flc_flags in nlm4svc_retrieve_args. We only
> > > > deal with FL_POSIX locks in svc lockd, and that does it right after
> > > > locks_init_lock, so I think that means it'll be done earlier, no?
> > > 
> > > Have a look at the nlm4 branch in my kernel.org <http://kernel.org/> repo to see where
> > > this is headed.
> > > 
> > 
> > (For everyone following along: It's actually in Chuck's xdrgen branch)
> > 
> > Oh ok, I see. This is an interim step toward moving all of the lock
> > initialization into nlm4svc_retrieve_args(). That probably is better. I
> > withdraw my objection.
> 
> Adding that observation to the commit message would help with review.

I was hoping to break these up to make them easier to review, but
for 5/5 I guess it didn't help.

I can send more of these clean-up/refactors along for v6.13. But I'm
not sure the actual conversion later in the xdrgen branch is ready
for prime time.


> I agree that moving the initialisation to nlm4svc_retrieve_args() seems
> sensible.  The half-way version in this patch looks really odd without
> that explanation.
> 
> But the whole series
>  Reviewed-by: NeilBrown <neilb@suse.de>
> 
> Thanks,
> NeilBrown
> 
> 
> 
> > 
> > > 
> > > > Also, I think the same duplication is in nlmsvc_retrieve_args and the
> > > > nlmv3 version of svcxdr_decode_lock.
> > > 
> > > Which is going away when NFSv2 is removed. I'm not too concerned
> > > about that duplication.
> > > 
> > 
> > Fair enough. I'm fine with leaving that to wither for now:
> > 
> > Reviewed-by: Jeff Layton <jlayton@kernel.org>
> > 
> 

-- 
Chuck Lever

