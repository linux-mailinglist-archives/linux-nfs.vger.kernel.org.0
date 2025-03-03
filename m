Return-Path: <linux-nfs+bounces-10437-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0000BA4CD8D
	for <lists+linux-nfs@lfdr.de>; Mon,  3 Mar 2025 22:33:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D0C03ACD43
	for <lists+linux-nfs@lfdr.de>; Mon,  3 Mar 2025 21:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19BEA1EEA47;
	Mon,  3 Mar 2025 21:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QFIfjRnR";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Myx4cuQr"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E16C1E9B3D
	for <linux-nfs@vger.kernel.org>; Mon,  3 Mar 2025 21:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741037631; cv=fail; b=MP2IdssEh9MZKhQ2opu8Wa6fF284KVOM2jKwwQuGJPieocpBrx8wnlcDkMWsvDas9n/PCi1wUdSL6CFA0ABb+s2ourtf3dIV/iPhXklqtcLqQml1qgA/D8Qxadmb5jQaotF2eqPBL8mlFtlYLG1+DxmlUDA/TQqRxhVTPDzGBBw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741037631; c=relaxed/simple;
	bh=7oVOa+PFTJ96yiFjXCu93iLGCl/cq5IpznpQncrf3xs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dLuH65SQ0/KUImwEh7yrvJltWJrj042699HhiaLQCe6ZoU1m2Vqb7i6bUxHNjrI6gmAG9uLaTnoM1dJrXskAQj0cTzUOd8cHCzaDYtxW/xC5r/J0qUUe0bbT4ygHHd422ClUEwahuRj7zW8Cnuo3XzXL+KamafCpD7ETYfGWUYw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=QFIfjRnR; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Myx4cuQr; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 523JffpA004714;
	Mon, 3 Mar 2025 21:33:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=B8W5quMEzSsGJHWnzl/VLZAP/+zGTXD0Ld5FvqhnRSQ=; b=
	QFIfjRnRPdAwhD++M/qpB3w6d79hHQjtjCOmwrLGU5+wQOAeOFWEKuC3lQq/9vS3
	3DbgVqGWWLiz5A01FM+aXcZ9ygm/B2I9bdNHDWqnv1mNiYyMugkxWOeD4pKoL2Cl
	aom4YjdxL5O1EQxzdCniMCKfROmYhV1q230aeOl9TyYtsyv4TSJAFnW3t5ETwe+J
	6wHH4uj9cuznhvtR41sJf/gtoo6aGEJGU2kXdwjHqVDSjEwZR+0pFr4ztMSOSfuw
	dA+OHKvF69955ZBDT3RWN3grX5Qd63ZkBpm19Z4wiWMMrGAJVE2D4Yfi3p5Z5To0
	X7Fg1ll/wG7lp76FN1IR7w==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 453u86knqy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 03 Mar 2025 21:33:39 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 523KuI1S021940;
	Mon, 3 Mar 2025 21:33:38 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2045.outbound.protection.outlook.com [104.47.58.45])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 453rwu21ja-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 03 Mar 2025 21:33:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XIZJuh9o2rn/I4qNGXRIrpJMWo8twu+uDlpTsNnBuLwbuI7voNqPo2X3iPJWHyyn3V3u9GJ27pTLZSB2YAe2tGkDPnIE5ku0fF2xigpL/mwkTRqpciY5odcjJ4mCLjwlYKLLV7/UqP6AkrnPYap2N1NHfQFAC1kfy7doOXLpvQhRmrRqopCdr21dxKeA0Y60KdwYTn+YaPiH+uFv7LsYD1pl9Bp38zlPRlEA5Bco1QuggCc0lx2ChXiQ8YD3pKpH03M2MgL+VYQpbvQVYUQIkwYVdeaJVbqV+EwMjiDl+SKXiHg95gE8Wi3yk0AENsno0VffUhMAm+d5SIXE7bTSiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B8W5quMEzSsGJHWnzl/VLZAP/+zGTXD0Ld5FvqhnRSQ=;
 b=kn4iDCGkeJOFH6+NfmAFBKAZ1K7TzE2m574RdWPGgs7ZSOHYT6I9NPVAoS2h4GE2iUP0zyO0xG7r6U+geqA53lf7Z2gFV+Ci/t/poeOH8YnGxaMtrLGqnOfkJnHRnIIKbRO06R3SQAJk2OR5vj3xDPfUnoU2CLjbSALcT7RBXP0NfyuOAtWot1lidH13dyzHQU9YoiR0CL4vyg8TrSDGRNIvPzII5HxwR3/T95AIjakRpS92LjUQ6G+C39iVyt1ioP2NDDXJ0HmZS7qKGO8JNVng0G8DIB7uDNUwnY91PT6ShJWKdwy7ahQyAHpNumE+qcuDb7qHiUHoPx/JLlzWSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B8W5quMEzSsGJHWnzl/VLZAP/+zGTXD0Ld5FvqhnRSQ=;
 b=Myx4cuQr0vbeFFZu8UEWP7z90DSxSTGmmlK93+A5Z5bjQackRhw+yDoq4iYB5ION5MnBdN9/Z0iyeyy9ooz0qucSQ2n1Nv17p7Wfkjt8Ulb1wiqoVKObSZL/YcAYY1nRznIGQwO+FlkHubWMV61TNJr/njvlII2EwVsY6MsL0K4=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BN0PR10MB5176.namprd10.prod.outlook.com (2603:10b6:408:125::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.28; Mon, 3 Mar
 2025 21:33:35 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.8489.025; Mon, 3 Mar 2025
 21:33:35 +0000
Message-ID: <28387789-7d8c-4161-a0cc-56dccedde5c8@oracle.com>
Date: Mon, 3 Mar 2025 16:33:33 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] NFSD: Implement CB_SEQUENCE referring call lists
To: Jeff Layton <jlayton@kernel.org>, cel@kernel.org,
        Neil Brown <neilb@suse.de>, Olga Kornievskaia <okorniev@redhat.com>,
        Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org
References: <20250301183151.11362-1-cel@kernel.org>
 <20250301183151.11362-4-cel@kernel.org>
 <c6707203ccf07646e62db9d5e806629f2d3c9d5b.camel@kernel.org>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <c6707203ccf07646e62db9d5e806629f2d3c9d5b.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR08CA0024.namprd08.prod.outlook.com
 (2603:10b6:610:5a::34) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|BN0PR10MB5176:EE_
X-MS-Office365-Filtering-Correlation-Id: 82673223-bbcf-48db-3c2a-08dd5a9b0d7d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eDkxU1htT3g1T2c2TlJ3YStSa293VVNvSnhzKzczQUNmMllOTzRwR05QZWtE?=
 =?utf-8?B?TkpKOXoyWkVZR21qUDcwNjJuK0dkOVNEWktEUllxL0tDclkvdHY0Z1NSc2ZG?=
 =?utf-8?B?dWVDQjdNb1JYY1FUMjNsYXNYUmF0SjJHeE1wOVRjWmVId3k2Sm9uaE4yWFAz?=
 =?utf-8?B?STlRckRVczM2TEdMcUttaFh2MzVoOUh3N2ZPcjhQb0N3MkdDdTVNbUxTem5Q?=
 =?utf-8?B?M3FpYzRQRVRuOUV3VHhuUGxPL3lkQ05kL3AzU09zd1Jod2wySysrNnlscmo2?=
 =?utf-8?B?OTJjWEZBUmkyTjdhWUpWZysyeTk0ZjQ0aVpxMDF2QWRsS2VQUWViNlNSTzNH?=
 =?utf-8?B?eCs3cXFkVlFPZ3FRQXBGck16SmNrWHBXTWg2YkphTG5Oa0VnZ1JBdVZJMDcz?=
 =?utf-8?B?cnU5UkJWNk1jN2RkSEJLMTl3WXA2VWtrNkp5clFWbFErZDRaSmkyU2p2bDV1?=
 =?utf-8?B?VEgzbnJZNGVZZ3oxNkJ5UVNxM2dPWmJNS0YrSGZkaG9sZ01rRHE4dVNBaE1k?=
 =?utf-8?B?aUp3VmVmb0w1UXBmMHZWRis3ZU43RmtOaHNWdXRNQUlZWFNtcmJ1V3VjZ0Iz?=
 =?utf-8?B?WGNkOStxQ1pGSnBsSVM0OUhpMUh4VFN1TUZQOWJrV1hkaUMyZEc2V0xReGNz?=
 =?utf-8?B?M3p6MWg0SHZvU0lTSXg3Q3crSmNMTVJOMzFQeW9FV09ZU1p5dlRycmVkemxU?=
 =?utf-8?B?djN5dDhIOXJYNHZ6ajVmRUYvYjJJVVg3aVZMV0RUUjQ0aU00RkMxYWhUOVpT?=
 =?utf-8?B?dnBpcEQ1LzlUVEdHVkRFcXZzcmdQSkhZbTFVY2hDU0JuMzlqdVVuMkVpYzFX?=
 =?utf-8?B?VHI3bWpGVVBKaTJiNTlPRllybWNESitFR2FBeFp6b3RJRi96bVNjMGhOeE5j?=
 =?utf-8?B?bzliMHpxc09iU0gvNzYyMml4b0NiZXRhb1ZGOTN0aVluUElqU1NjdVBjMWha?=
 =?utf-8?B?QzVaZ3FXSFVsaHFBc2xiaUpwV29sWFpYaEVCWEdnQ3dCbmE1clpBYzMxdnNa?=
 =?utf-8?B?bFNHNnZla2RNSUpIRWxnLzU4Nm9NZVlHOWRGUm1BYWpZQzFZV29uMzlkR0dN?=
 =?utf-8?B?VzNEcUpQU2huSjF2ZktPZmR5djY0dTR4Ry9UMmVTZ1pKeHlUY00ya0xUaW5T?=
 =?utf-8?B?OGh6MWFBMDNWa3NaM3F1WGVOdVBKdHM2bFYxTEg0UVlscGdhK3hzdU8zbWFD?=
 =?utf-8?B?VnZjK2lsTjYyZ2NjOWdQc3RRM1Z3MytQdDhaL2dLL0J5NDhTK0YvY3o0YXo1?=
 =?utf-8?B?Mk5wdEVjM09PYXNTb0QvSVpNR3ZFVmowWVdhMEExa3pDSVhFM3EzaWxtYkQr?=
 =?utf-8?B?a0VtMjVTa2VJZVBVVU8yV0tXTy85c28xVU9YbWIvSGhBSW5zUkYvSHdPU3Nz?=
 =?utf-8?B?ZUZIOUhpVCsvRk54OUtsaWNRSUZmeDN3WUt1elZxTlNMZzRKb3pORlZFTXRj?=
 =?utf-8?B?YTVkWktNNm9kYUZEVjVQZElUZEEwRUo0bmt5QnY1bHI5UjdEWVE1MC9FeExm?=
 =?utf-8?B?bnJ5aG5CS0FhV1BTSHQwNjBkdXZac1JkcHhERXZuMnRwTkU5Tlp6RUlKNDFl?=
 =?utf-8?B?aHM1amlicXl5NTlnbDd1TVJnbEZJSGIrYitXQ2ZtY3BlbVNycUpBdTFKaHZR?=
 =?utf-8?B?RGd0RGdFcjlVd2Z0a01oZWlhTEpISWdWaG8vR2R4VkR6UFplRTJOZjl2SWgx?=
 =?utf-8?B?TlFGdExmY0o0NEMzZHl1MFJFMk54V2p1R3RuU1EwRC83ZlpKUXNaVStESDRI?=
 =?utf-8?B?RUR0eVpralkycHVhRkdZaU05YXFMeVY0Smt5TzlodTNxaVhjM0NFTjhFVnlF?=
 =?utf-8?B?blIrbnpFbXJVVEhCcmZPaHl6bkxqdHV0L3U5L2NlQ29idzV5TkhTTVpPSStj?=
 =?utf-8?Q?jJWEaUr1J3ofn?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VC9SM0xnWTgvbTMrNzNYSFgyYVNGSXJiREdubEJ6cWxnZSswWm4wTjNNQUh1?=
 =?utf-8?B?U0J6cWVTOTQwSjUzcGFVbmZvWTQ4MjFjdk1JL0ZLWlkyVUdtZGNlc3JUcHo0?=
 =?utf-8?B?OXU3N3N0YURRZlJtNGMzSlVUUkNUcWZkVnA3dnBHNWlBT0hhQ2NwTHIvN25V?=
 =?utf-8?B?Q0VnTjlsd3Rqd2NYVlhUUWZPTzJsVDIvaHlCZnp3aitMUVhQS1RUL3VGM1lO?=
 =?utf-8?B?ZkY3WUJ1YnZ2cDV1VVJEMTViMjlGeFNtT1dDRGdmL0FYS2lTTjBvajY5bGNZ?=
 =?utf-8?B?K0MwOVgrWUdjdW5Wajc1TmtYazVQSGhNSE5Ka0FSM1l5a3E5eHJtcCtYSmJ5?=
 =?utf-8?B?Q3NHcmxmYngrN3dtaFhteFdvZnYvK2p5RnUrenprZkFPUnA0Q2R6bGJrMjU2?=
 =?utf-8?B?YWFYSFZxUjNhOTZza3F6QklsQUNYTzFHM1d4dzRWRVJuWk9TcXNFN0REUElV?=
 =?utf-8?B?dnd2dUljNVVEalJlTGlYbFJpMW54bVRHWS9QNllOMUZPc0FQamk5dzA2VlZu?=
 =?utf-8?B?TDVybm9tdWdKYjFVcDM5Vzd2ZkZKV054dmQyZ3RUdm1JaXlQd3VyVkZtVkFG?=
 =?utf-8?B?RS9sc0kxR3VacW1wQkdHWXBFeDJvQWlKd1FCSGF0MURtTS9JL0RKOUR5cThD?=
 =?utf-8?B?WW5tU0Q0Z2grSjB2MjBIOWtCclhkOVh4TzNqa1R3U2EvZWZLNW5MYnQ3VXp2?=
 =?utf-8?B?VFNnVTBQcERZZkh2QStwRDJoTkZGVnZ1RjcyRzZiRFVvUjhjbTRibmNCcUdF?=
 =?utf-8?B?cXNZaTRQUDd6Q1d5dFNHemp5dmNUVzI4QjlpMkNtSDNXd0R6VXRqZVdrNTZs?=
 =?utf-8?B?bDZtMlBoZUdoZTBtaFlKVUh2M0xWbTRZdnRueHJWMi9ZYytiZnhqcWVkaEE5?=
 =?utf-8?B?UXpZbWdXUjlpUHZUZ3AwcXF3VzZJSXBLL2hnK0ZSS3d0TzVmM053RG9JdXVx?=
 =?utf-8?B?Zk9sbm5FQm4wRUZVWEQ0d3ZGQjU5UlZueDdmNlYyNHVGZ3NTb1RRRy83VnZh?=
 =?utf-8?B?VUhsOVNUSmh6cGd6ekkvUmdiOE81NzcxVXBORllRTHlSVEN1dEZLRXFYYlZZ?=
 =?utf-8?B?UnV6RlYweXVxNEJOMkpHYURJSHdFYzB0WXU3YW1CQzgrNU5NWWdVclczUE1i?=
 =?utf-8?B?NW5LT1lmUUxEbXRwdWxSbUJycXFScDhobVNZcVU3WXFoTTJsSE0zM2RNenVu?=
 =?utf-8?B?amtDYVMyK04xczNWRkM3WjBYYVJ5MlBINGV1ZWhuZ0ROcHBKRldZUDlPTVlk?=
 =?utf-8?B?Y0Z2dU5tZmhEa2s5bklOTlY5bS9jbVZmVmZqdHRwTGEvOU5GNlJTMC92VXht?=
 =?utf-8?B?aVBJbENlTVRjMTlZVGhMZkpud0JLalN5ZEVNNlBNY1RLd1dMZU9naEsveUNL?=
 =?utf-8?B?UHhpb1ZhQzRuTjA3T3lnSFVaL2dKWWphOFg5OTZXUmlBM3A5SmdkMkdkbmho?=
 =?utf-8?B?SEFJZXRmRTFxeGZPQ3NsQTZOMDF2WVdlSWtQT0V0b2dyakd3Y2ZSUUtpNFFC?=
 =?utf-8?B?RDVmNkFKY3Rja3UxaEo2Vzh0Ny9aTVd3SlhXeVRxNGNFRFdQc0JXVTlOSk5Z?=
 =?utf-8?B?Vm51Z0N1NUIwVUMzblhWUWh4ZWZnTHdmdUl1MVRiQ1RNTWM4cWI4U3gydVVn?=
 =?utf-8?B?cmRKWjMzWmdBRktya3pubWxaN2F0ckRtUUwzTjNqdHNMUVVQZDZ4UFhLU2JN?=
 =?utf-8?B?aUJuUlN0dzhMcUxWL0w3Yjh4a3ZISGVrU1dmSkttREUvNE5GaXlicVpqVSsv?=
 =?utf-8?B?Ym9wY0JjakQxc2lGd3VJemFHUDllWjlMNFdvS1FEKzIrY2F0dkpzb1VWY2VT?=
 =?utf-8?B?WEwyR1lpSnJ0UyszRUxoTDBOZXFacWxVblhIU3crcmxmb1oya3NmZ3dpTHFU?=
 =?utf-8?B?YlJIbmN3OXNNOUQrK29OeUJBYkkxR3Vibk5vOGdtSUxGMmFwK0V3bEVlTVY3?=
 =?utf-8?B?ZzI0SHpUbkJBWUo4cVQwS3p3ejJ2Q0d3cGZHYWVyeU5wU0pmTUY1NmRYYnQx?=
 =?utf-8?B?QWQ4VUI4aWVSa0lOQlIzb1RRbzJHT1dNZWVOUUpCSkkvS0hML0ttNDVtRVN4?=
 =?utf-8?B?Z3F2empwYTdaNGJJT2dreXg5cCtMenVyYkJqZ1A2NFFVb0Q4YUU5VzdnOHFv?=
 =?utf-8?Q?RdDuCOiP2+93yguLjDWXtU7NK?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	9H67K34YqxFas5nWRSI+IUrV6xN2VxDYfLoRdgBREi9eYLI0yqpq9Z3UDmFZqdADSHlW+Eju8IffbUemzAVVFmMQItSvmuHNSoJkcHYeD+Y5cJfKtt+rbaFJ7NCKTSbHddc9KF+e1m7fPw1msjkSzAFs++3qp1mjELEwOb1lj9d1SLT/G2o5rJ/qV4KAgXT1AZsGp+mdDejmjC8InWLBH8y9rYM6Sgj6M422b5n7lK3BFYOT3oNiIK65RHQ80qiJLMIGYshfJhfofbl/EcA9t7qyJZ7wFz1PsaaEfLZLsytmkzkq4OBCpaYS90cWFqdrHzukcCIPreJU8keapiL+z8du/ZtpKTMcK5YANTfLxsZj9Vb1oXJA6PC70UX2anrzozQWAncq7gTOOrxAHpiNWIniGqQgOxbxj+BRU1PnoQAmaUdt3dpsz+dqrsmCBUvaRRx9XoyvvxL8XNQZAsMoBcUrh63dv34ZbeXReGZBIF9if5pDobr1gFkOfmHEJiolnuuEm7/Xbbf/M9z5pEZ+2ztRAlOH0u1D3FyEriDtLL9TNsrjd72TNNockdmGi0iclDhA3gV1RvgiNBTw5ElQS9PyXywn42SM1+eDFvMiDko=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82673223-bbcf-48db-3c2a-08dd5a9b0d7d
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2025 21:33:35.0314
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vqfYdhDy7/zcQ67B6tsdPJnPSi8V6HEBhA5ObDwt9nx66ut1C7rpjWxip94KT/wnn+HPi4vJ7H28QOqI5KBR6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5176
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-03_11,2025-03-03_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 bulkscore=0 adultscore=0 suspectscore=0 spamscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502100000 definitions=main-2503030167
X-Proofpoint-ORIG-GUID: ym5j-vhzJIZzJoDFy2mTZep_DJyS1t2R
X-Proofpoint-GUID: ym5j-vhzJIZzJoDFy2mTZep_DJyS1t2R

On 3/3/25 1:05 PM, Jeff Layton wrote:
> On Sat, 2025-03-01 at 13:31 -0500, cel@kernel.org wrote:
>> From: Chuck Lever <chuck.lever@oracle.com>
>>
>> We have yet to implement a mechanism in NFSD for resolving races
>> between a server's reply and a related callback operation. For
>> example, a CB_OFFLOAD callback can race with the matching COPY
>> response. The client will not recognize the copy state ID in the
>> CB_OFFLOAD callback until the COPY response arrives.
>>
>> Trond adds:
>>> It is also needed for the same kind of race with delegation
>>> recalls, layout recalls, CB_NOTIFY_DEVICEID and would also be
>>> helpful (although not as strongly required) for CB_NOTIFY_LOCK.
>>
>> RFC 8881 Section 20.9.3 describes referring call lists this way:
>>> The csa_referring_call_lists array is the list of COMPOUND
>>> requests, identified by session ID, slot ID, and sequence ID.
>>> These are requests that the client previously sent to the server.
>>> These previous requests created state that some operation(s) in
>>> the same CB_COMPOUND as the csa_referring_call_lists are
>>> identifying. A session ID is included because leased state is tied
>>> to a client ID, and a client ID can have multiple sessions. See
>>> Section 2.10.6.3.
>>
>> Introduce the XDR infrastructure for populating the
>> csa_referring_call_lists argument of CB_SEQUENCE. Subsequent patches
>> will put the referring call list to use.
>>
>> Note that cb_sequence_enc_sz estimates that only zero or one rcl is
>> included in each CB_SEQUENCE, but the new infrastructure can
>> manage any number of referring calls.
>>
>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>> ---
>>  fs/nfsd/nfs4callback.c | 132 +++++++++++++++++++++++++++++++++++++++--
>>  fs/nfsd/state.h        |  22 +++++++
>>  fs/nfsd/xdr4cb.h       |   5 +-
>>  3 files changed, 153 insertions(+), 6 deletions(-)
>>
>> diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
>> index 484077200c5d..f1fffff69330 100644
>> --- a/fs/nfsd/nfs4callback.c
>> +++ b/fs/nfsd/nfs4callback.c
>> @@ -419,6 +419,29 @@ static u32 highest_slotid(struct nfsd4_session *ses)
>>  	return idx;
>>  }
>>  
>> +static void
>> +encode_referring_call4(struct xdr_stream *xdr,
>> +		       const struct nfsd4_referring_call *rc)
>> +{
>> +	encode_uint32(xdr, rc->rc_sequenceid);
>> +	encode_uint32(xdr, rc->rc_slotid);
>> +}
>> +
>> +static void
>> +encode_referring_call_list4(struct xdr_stream *xdr,
>> +			    const struct nfsd4_referring_call_list *rcl)
>> +{
>> +	struct nfsd4_referring_call *rc;
>> +	__be32 *p;
>> +
>> +	p = xdr_reserve_space(xdr, NFS4_MAX_SESSIONID_LEN);
>> +	xdr_encode_opaque_fixed(p, rcl->rcl_sessionid.data,
>> +					NFS4_MAX_SESSIONID_LEN);
>> +	encode_uint32(xdr, rcl->__nr_referring_calls);
>> +	list_for_each_entry(rc, &rcl->rcl_referring_calls, __list)
>> +		encode_referring_call4(xdr, rc);
>> +}
>> +
>>  /*
>>   * CB_SEQUENCE4args
>>   *
>> @@ -436,6 +459,7 @@ static void encode_cb_sequence4args(struct xdr_stream *xdr,
>>  				    struct nfs4_cb_compound_hdr *hdr)
>>  {
>>  	struct nfsd4_session *session = cb->cb_clp->cl_cb_session;
>> +	struct nfsd4_referring_call_list *rcl;
>>  	__be32 *p;
>>  
>>  	if (hdr->minorversion == 0)
>> @@ -444,12 +468,16 @@ static void encode_cb_sequence4args(struct xdr_stream *xdr,
>>  	encode_nfs_cb_opnum4(xdr, OP_CB_SEQUENCE);
>>  	encode_sessionid4(xdr, session);
>>  
>> -	p = xdr_reserve_space(xdr, 4 + 4 + 4 + 4 + 4);
>> +	p = xdr_reserve_space(xdr, XDR_UNIT * 4);
>>  	*p++ = cpu_to_be32(session->se_cb_seq_nr[cb->cb_held_slot]);	/* csa_sequenceid */
>>  	*p++ = cpu_to_be32(cb->cb_held_slot);		/* csa_slotid */
>>  	*p++ = cpu_to_be32(highest_slotid(session)); /* csa_highest_slotid */
>>  	*p++ = xdr_zero;			/* csa_cachethis */
>> -	xdr_encode_empty_array(p);		/* csa_referring_call_lists */
>> +
>> +	/* csa_referring_call_lists */
>> +	encode_uint32(xdr, cb->cb_nr_referring_call_list);
>> +	list_for_each_entry(rcl, &cb->cb_referring_call_list, __list)
>> +		encode_referring_call_list4(xdr, rcl);
>>  
>>  	hdr->nops++;
>>  }
>> @@ -1306,10 +1334,102 @@ static void nfsd41_destroy_cb(struct nfsd4_callback *cb)
>>  	nfsd41_cb_inflight_end(clp);
>>  }
>>  
>> -/*
>> - * TODO: cb_sequence should support referring call lists, cachethis,
>> - * and mark callback channel down on communication errors.
>> +/**
>> + * nfsd41_cb_referring_call - add a referring call to a callback operation
>> + * @cb: context of callback to add the rc to
>> + * @sessionid: referring call's session ID
>> + * @slotid: referring call's session slot index
>> + * @seqno: referring call's slot sequence number
>> + *
>> + * Caller serializes access to @cb.
>> + *
>> + * NB: If memory allocation fails, the referring call is not added.
>>   */
>> +void nfsd41_cb_referring_call(struct nfsd4_callback *cb,
>> +			      struct nfs4_sessionid *sessionid,
>> +			      u32 slotid, u32 seqno)
>> +{
>> +	struct nfsd4_referring_call_list *rcl;
>> +	struct nfsd4_referring_call *rc;
>> +	bool found;
>> +
>> +	might_sleep();
>> +
>> +	found = false;
>> +	list_for_each_entry(rcl, &cb->cb_referring_call_list, __list) {
>> +		if (!memcmp(rcl->rcl_sessionid.data, sessionid->data,
>> +			   NFS4_MAX_SESSIONID_LEN)) {
>> +			found = true;
>> +			break;
>> +		}
>> +	}
>> +	if (!found) {
>> +		rcl = kmalloc(sizeof(*rcl), GFP_KERNEL);
>> +		if (!rcl)
>> +			return;
>> +		memcpy(rcl->rcl_sessionid.data, sessionid->data,
>> +		       NFS4_MAX_SESSIONID_LEN);
>> +		rcl->__nr_referring_calls = 0;
>> +		INIT_LIST_HEAD(&rcl->rcl_referring_calls);
>> +		list_add(&rcl->__list, &cb->cb_referring_call_list);
>> +		cb->cb_nr_referring_call_list++;
>> +	}
>> +
>> +	found = false;
>> +	list_for_each_entry(rc, &rcl->rcl_referring_calls, __list) {
>> +		if (rc->rc_sequenceid == seqno && rc->rc_slotid == slotid) {
>> +			found = true;
>> +			break;
>> +		}
>> +	}
>> +	if (!found) {
>> +		rc = kmalloc(sizeof(*rc), GFP_KERNEL);
>> +		if (!rc)
>> +			goto out;
>> +		rc->rc_sequenceid = seqno;
>> +		rc->rc_slotid = slotid;
>> +		rcl->__nr_referring_calls++;
>> +		list_add(&rc->__list, &rcl->rcl_referring_calls);
>> +	}
>> +
>> +out:
>> +	if (!rcl->__nr_referring_calls) {
>> +		cb->cb_nr_referring_call_list--;
>> +		kfree(rcl);
>> +	}
>> +}
>> +
>> +/**
>> + * nfsd41_cb_destroy_referring_call_list - release referring call info
>> + * @cb: context of a callback that has completed
>> + *
>> + * Callers who allocate referring calls using nfsd41_cb_referring_call() must
>> + * release those resources by calling nfsd41_cb_destroy_referring_call_list.
>> + *
>> + * Caller serializes access to @cb.
>> + */
>> +void nfsd41_cb_destroy_referring_call_list(struct nfsd4_callback *cb)
>> +{
>> +	struct nfsd4_referring_call_list *rcl;
>> +	struct nfsd4_referring_call *rc;
>> +
>> +	while (!list_empty(&cb->cb_referring_call_list)) {
>> +		rcl = list_first_entry(&cb->cb_referring_call_list,
>> +				       struct nfsd4_referring_call_list,
>> +				       __list);
>> +
>> +		while (!list_empty(&rcl->rcl_referring_calls)) {
>> +			rc = list_first_entry(&rcl->rcl_referring_calls,
>> +					      struct nfsd4_referring_call,
>> +					      __list);
>> +			list_del(&rc->__list);
>> +			kfree(rc);
>> +		}
>> +		list_del(&rcl->__list);
>> +		kfree(rcl);
>> +	}
>> +}
>> +
>>  static void nfsd4_cb_prepare(struct rpc_task *task, void *calldata)
>>  {
>>  	struct nfsd4_callback *cb = calldata;
>> @@ -1625,6 +1745,8 @@ void nfsd4_init_cb(struct nfsd4_callback *cb, struct nfs4_client *clp,
>>  	cb->cb_status = 0;
>>  	cb->cb_need_restart = false;
>>  	cb->cb_held_slot = -1;
>> +	cb->cb_nr_referring_call_list = 0;
>> +	INIT_LIST_HEAD(&cb->cb_referring_call_list);
>>  }
>>  
>>  /**
>> diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
>> index 74d2d7b42676..b4af840fc4f9 100644
>> --- a/fs/nfsd/state.h
>> +++ b/fs/nfsd/state.h
>> @@ -64,6 +64,21 @@ typedef struct {
>>  	refcount_t		cs_count;
>>  } copy_stateid_t;
>>  
>> +struct nfsd4_referring_call {
>> +	struct list_head	__list;
>> +
>> +	u32			rc_sequenceid;
>> +	u32			rc_slotid;
>> +};
>> +
>> +struct nfsd4_referring_call_list {
>> +	struct list_head	__list;
>> +
>> +	struct nfs4_sessionid	rcl_sessionid;
>> +	int			__nr_referring_calls;
>> +	struct list_head	rcl_referring_calls;
>> +};
>> +
> 
> This set of nested lists is rather complex. Did you consider keeping a
> single list and just adding the sessionid to nfsd4_referring_call? I
> suppose that might mean you'd have to do more sessionid comparisons but
> in general, I'd expect these lists to be short.

I agree that it's just a little bit more than we clearly need right now.

My eye is on replacing this code eventually with something generated by
xdrgen. xdrgen will manufacture something like this rather than
optimizing for only cases we can see right now in our rear-view mirror.

Even so, spec requires servers to implement client trunking, meaning
they have to handle multiple sessions per client ID. NFSD needs to be
prepared to handle the case where a client ID has several sessions
associated with it, only one of which has a backchannel.


>>  struct nfsd4_callback {
>>  	struct nfs4_client *cb_clp;
>>  	struct rpc_message cb_msg;
>> @@ -73,6 +88,9 @@ struct nfsd4_callback {
>>  	int cb_status;
>>  	int cb_held_slot;
>>  	bool cb_need_restart;
>> +
>> +	int cb_nr_referring_call_list;
>> +	struct list_head cb_referring_call_list;
>>  };
>>  
>>  struct nfsd4_callback_ops {
>> @@ -777,6 +795,10 @@ extern __be32 nfs4_check_open_reclaim(struct nfs4_client *);
>>  extern void nfsd4_probe_callback(struct nfs4_client *clp);
>>  extern void nfsd4_probe_callback_sync(struct nfs4_client *clp);
>>  extern void nfsd4_change_callback(struct nfs4_client *clp, struct nfs4_cb_conn *);
>> +extern void nfsd41_cb_referring_call(struct nfsd4_callback *cb,
>> +				     struct nfs4_sessionid *sessionid,
>> +				     u32 slotid, u32 seqno);
>> +extern void nfsd41_cb_destroy_referring_call_list(struct nfsd4_callback *cb);
>>  extern void nfsd4_init_cb(struct nfsd4_callback *cb, struct nfs4_client *clp,
>>  		const struct nfsd4_callback_ops *ops, enum nfsd4_cb_op op);
>>  extern bool nfsd4_run_cb(struct nfsd4_callback *cb);
>> diff --git a/fs/nfsd/xdr4cb.h b/fs/nfsd/xdr4cb.h
>> index f1a315cd31b7..f4e29c0c701c 100644
>> --- a/fs/nfsd/xdr4cb.h
>> +++ b/fs/nfsd/xdr4cb.h
>> @@ -6,8 +6,11 @@
>>  #define cb_compound_enc_hdr_sz		4
>>  #define cb_compound_dec_hdr_sz		(3 + (NFS4_MAXTAGLEN >> 2))
>>  #define sessionid_sz			(NFS4_MAX_SESSIONID_LEN >> 2)
>> +#define enc_referring_call4_sz		(1 + 1)
>> +#define enc_referring_call_list4_sz	(sessionid_sz + 1 + \
>> +					enc_referring_call4_sz)
>>  #define cb_sequence_enc_sz		(sessionid_sz + 4 +             \
>> -					1 /* no referring calls list yet */)
>> +					enc_referring_call_list4_sz)
>>  #define cb_sequence_dec_sz		(op_dec_sz + sessionid_sz + 4)
>>  
>>  #define op_enc_sz			1
> 


-- 
Chuck Lever

