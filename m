Return-Path: <linux-nfs+bounces-14827-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FC09BAE933
	for <lists+linux-nfs@lfdr.de>; Tue, 30 Sep 2025 22:54:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C88E11C6FC4
	for <lists+linux-nfs@lfdr.de>; Tue, 30 Sep 2025 20:54:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5875A277C81;
	Tue, 30 Sep 2025 20:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QszyC5hU";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="BKy/4XyQ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 861EE4C81
	for <linux-nfs@vger.kernel.org>; Tue, 30 Sep 2025 20:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759265685; cv=fail; b=Evey7e5Tu6llDvU63aCpwv9YSBgdFR7lP35ZwUG7mXhuVywJCq0mYB7ZcWCHBo0eguOPYf6cAats4A6COP8rgIP2XJ0R/CFhZrypQdOyYd6cvRZgMFChtTvfnrnB2//wEh/ic5rp+NNk0GWBhVFGJ5BMtW3KD2AcAuv9wy4yv28=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759265685; c=relaxed/simple;
	bh=+8mPmdxSxxp4oZuzTIQbI6vpMOwS+b6NTVDr177QP+Q=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NAlxGEy8lufF2ISzwTLm4LdB22i1ltluP7MlXmy8rMxCiq3AosStNG3Jvd1IrAqE1CqBBlRAZiLA+XG/D3dBD8mQtVkQzS+uFBofL5Bw3mKwkwdFQX2YFf5Gvooa6mRu45fNo51CWxmDFiO8dyc9U5+TodWDHTAr7bFcYklcgIk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=QszyC5hU; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=BKy/4XyQ; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58UKMjUA023853;
	Tue, 30 Sep 2025 20:54:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=lDhNK+BThpoLBZ2Ho34CBJ3yR6r1J+5RjUD61yJR6mM=; b=
	QszyC5hUKvBB9vVaxtDMoIfWlV9slWK2F+x1wR18JO/D/7xMi6l1n07IgmD2m3k8
	IHEjRWoG+UZyGiuJ3xQSf8iEI0+Z6HFf4SFoKLuz1AhxZuZUXgzxDghE+OP5FLNT
	n6mxgTnm+L6oPL5Px0G49k7uyUyMv3H1cjO7Q0twuuxvbUcCMBbYF5e7kuDaWoAe
	/1CIj6SL+WQl+yQrfARaAjT9UoC09KwTbBY4xpvnnaJ5WCJ2OdnhdOco+9jQ5HEe
	8agFX/6yidgrAU4CCWkhIkGxVbocPEonC+D4IThrnVXdHMYEI+nAVoM6v1wN/79y
	zkyqj+Diezk+tmEfBhIPOg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49gkxngamw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Sep 2025 20:54:38 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58UJVWQG007740;
	Tue, 30 Sep 2025 20:54:37 GMT
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010069.outbound.protection.outlook.com [52.101.193.69])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 49e6c9cn8y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Sep 2025 20:54:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d9yobh6Ua9cbr+Pyzn5DycMxawzUjr659jcX/+N1CqlWFYkjz0hgUXY33kPZ/04tQtVvtFL9/LgbvXnR3Npz42UeR05YsOuA5kourZuhcIDMwKD1IrM1cTdn8j3z9D0v8FRqq2uGspMhGkc2F8N15Q0Al2zkTi+YdgydwdqkDy0giI6o85t02EA3QAIIy1ydwU5en3k1AgPaSZFn6XP+R009h4zHYxwfFKBaP0eNMdG/OnEN87sctvRYpDbz9oskDJcPCZUg+U2Z4w6FPfH9o6HsIT80zWx7lQO9Fr6wwHMeA9LoxlO/6T8AiqWEVHLWjl98dWXonk9mZp0iMsj8Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lDhNK+BThpoLBZ2Ho34CBJ3yR6r1J+5RjUD61yJR6mM=;
 b=ipqTUHamfezTI2HDHBEfogFUcfPPRwr1zkkGfp9nnVceUg+oJsn4gooUNJLYUyBCCBB564PgrgOqpjGFNF8oaOme/D+UJ2gUVT76ylAYZ9YS/ed0G5rEpuPlcCcV2ofPsfe1IEwiM+F/uBoyjXLoUrLzleTubDl/nOW47rU/SBqrlsToZH3nlh920V9bUOdNgKu4aHoDulaEk1kCkNw58F4XDE9wrHBKxmKcoyaaL0MQLQk6U2NnYZBLWlIZwEM9aZhCm/iVOJggoeLrApqnyPF8E0+GKbjnwHytUo+Wn+pxkWcqCgOgjmWddmoZ+cQl9m7PFa64YmYv3TWvl2gkkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lDhNK+BThpoLBZ2Ho34CBJ3yR6r1J+5RjUD61yJR6mM=;
 b=BKy/4XyQa1WvzoBpRNOnfgNZlYdeLNrHbczCwtnHg0PcZAMvyVoYXzCfaJIrQA9gZlOoOMCvLancyqdNu0UGTIkjWETBhZxCufMqUkMDqRUN7PnBkEc8COoCVb+SdHw5yhSaI7XnsaZm4rDixkFIBVEYob+F4b+y04vMVPmYC5k=
Received: from BY5PR10MB4290.namprd10.prod.outlook.com (2603:10b6:a03:203::15)
 by DS0PR10MB8031.namprd10.prod.outlook.com (2603:10b6:8:200::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.15; Tue, 30 Sep
 2025 20:54:34 +0000
Received: from BY5PR10MB4290.namprd10.prod.outlook.com
 ([fe80::c86a:40f1:7833:ef3c]) by BY5PR10MB4290.namprd10.prod.outlook.com
 ([fe80::c86a:40f1:7833:ef3c%3]) with mapi id 15.20.9160.015; Tue, 30 Sep 2025
 20:54:34 +0000
Message-ID: <2951eea3-772b-4a1a-9169-3d9a3c0661c5@oracle.com>
Date: Tue, 30 Sep 2025 16:53:49 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL v2] NFS LOCALIO O_DIRECT changes for Linux 6.18
To: Mike Snitzer <snitzer@kernel.org>, Anna Schumaker <anna@kernel.org>
Cc: Trond Myklebust <trond.myklebust@hammerspace.com>,
        Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org
References: <20250915154115.19579-1-snitzer@kernel.org>
 <aMiMpYAcHV8bYU4W@kernel.org> <aNLfroQ8Ti1Vh5wh@kernel.org>
 <aNQqUprZ3DuJhMe4@kernel.org> <aNgSOM9EzMS_Q6bR@kernel.org>
 <aNwEo7wOMrwcmq9b@kernel.org> <aNwwOvAZh5VAliWW@kernel.org>
Content-Language: en-US
From: Anna Schumaker <anna.schumaker@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <aNwwOvAZh5VAliWW@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0044.namprd03.prod.outlook.com
 (2603:10b6:610:b3::19) To BY5PR10MB4290.namprd10.prod.outlook.com
 (2603:10b6:a03:203::15)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4290:EE_|DS0PR10MB8031:EE_
X-MS-Office365-Filtering-Correlation-Id: e66194e4-a504-42be-bb04-08de00638f27
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R1ZHSzAwWFdjdHR1TFl3cTBMbmM0aTd0cHZvR2pQdXkwNnlENDN1NUFQRzk0?=
 =?utf-8?B?MlNtbm1YRmdQUFplMVZSc1I4eUhWRDdDdzIrR2ltcnN6YnNhNjF4SEV2WVZ0?=
 =?utf-8?B?Tmc4L2xuMDhneU45N0djemVBb3RkbzRXLzdaeWg1ZzB5Yi9KbWhYdTU3VVh4?=
 =?utf-8?B?S1RzYzdPVUFwQjJOUjFWdGVFZG5Va01xT2h2MzNHQVJaRU15Zm9Zb2xaSHdq?=
 =?utf-8?B?QU5NV1BheDlnNmpscnhYVUJTQ1daZ09sdlBEUldpVFI3VTJGSE9ZUTI4aEVS?=
 =?utf-8?B?ajFJQ0lkbFlsamF3Q0pvNzJUV3NEZ0IydjdWNzdKWmtSQWNUV2xHOWRPSkk5?=
 =?utf-8?B?TVFFZUd2TXN3Zi9QYVM2MTlKc0dQL2J6Uk9BZDhqK1p1d1RCSjFSV0ZiTDI1?=
 =?utf-8?B?SjdCNWtrUkl0d0JpbWh3MUlQcTJmOHd2Z0ZLM0VYSk9wWUxqY3JSbVlycVI1?=
 =?utf-8?B?NFRiQ1FOTzBWU3dYR1h2bmgrU2V4d2ZNa1ZxTkRtQjRzcld1YlFyeFppakFB?=
 =?utf-8?B?c0pJN3pKcFhuV1FiN09acVFUeVMyVkV3YWptVEhoK1VrZnFvRjdlUklKclE1?=
 =?utf-8?B?Q0MzeXdoNFpLdEg3Q3p1cjh4VWlUMHljcVEybWl3NmIxd3BRZGhPSzA0cGwx?=
 =?utf-8?B?dEJUNXhoK1RLRk1FSzlRSUNVRm4rRDY4UFZsQ3Zja25MSnh3S3IwMVFXRlU2?=
 =?utf-8?B?YmoxaE1WNkFUbDJ5Wlc2VHl4TnJDdUwrZWlQTTdxVVpTRHRWMFpjbGlOYk1v?=
 =?utf-8?B?NmhnK2FwZHN5dzRiTS9GK09EbXpCK2JCTEJ4TnlsQWVIUTlQRmFid3d5Tmlu?=
 =?utf-8?B?L0tBeS80cGRSclZ2N1dTdU9BS2dod2EyRUtYMFVPWFgxUTBNQU82dnRKc0pG?=
 =?utf-8?B?Y2J3VGQ1NEdwVGRiZWtRQlVuR3F2WWJob010ZWVjMWZROXBQZWRWR2xOcHAr?=
 =?utf-8?B?MTNsYTBPeUhsb1lsWnZQZGZsNUQ5dUl5SWtEVWV5aU5DbnllT0FjRGNXZ0hw?=
 =?utf-8?B?cElVNS9DK3h5aHFySk83UExLRDQ4VitOeXZWeGdaMURWMDVsWnZ6L2YzNDFV?=
 =?utf-8?B?NEVjaWJrTTNQcTFxTW1SSjlwc0NZMS8xeUw0WUFWYmRncklEWldQa1hmTDZx?=
 =?utf-8?B?NzQ4c21Qb2ZNemF3RGtXaFhWZTltNkhXM1pnREdodmJVbEZYTk0xUDhpQ1FT?=
 =?utf-8?B?ZUFlN1FoZnAyM1MrcWNkYkFRbFNrVzNYYkM1YTd3UlFEMmhRZzZMRWFlSy9k?=
 =?utf-8?B?RllTU0VPUVdMaGhoeEhjQ01YcHhqN2IrclF6TGlUTUFkbjJIaEwwRFZnMUJr?=
 =?utf-8?B?eEdNYVZ0dWs2cktENm43YUtBb3I1UE1VZXRGRDEwNWRHQVBySm5lQmxVSDRC?=
 =?utf-8?B?bUwrOU1aMFArYWpaVTJZdUIwdGRJU2tPazZGMGU2UWRLR1VLTFQ3K3lad0xM?=
 =?utf-8?B?TW13aGhGemhPdkluY01lY21oeC90YkM5aG1rRHJXdVVaaVBCOGVxSDlRK3A5?=
 =?utf-8?B?VzRnK3NFV1AyaXpnRlRQUVY3UHl5Wkh3dmR5Q3RYMU92cGdRaVMwTVZhTzRL?=
 =?utf-8?B?KzFjbVRYcE03VEFObzJ5L2R2R2IxK25jQW9mclU1VnVsNTFxYlFERTFTRFRQ?=
 =?utf-8?B?NklycnQrZU0rbUNTTzJ6aVhMcTVHeHFDWFZobXRsMlorRWN1cXhlRkdmZ1h2?=
 =?utf-8?B?VGZQcUNsNHYwZWcvbmVHM1dVeHhDdHpSNzB2MWR1RVZyYy8vOFgzZTNVZUdX?=
 =?utf-8?B?OEFjbDNvVnFnZWN1NXB1MG9qdWF3TjJBZnlUOTgrNm5wbWFtVFpJZ0JGeCty?=
 =?utf-8?B?RWhxeHRLam5sU2xCK2JPcUg5Ym16eUdHZGJBb2RyNXpzTk56b1lXZ0pVL3My?=
 =?utf-8?B?MlpHbFhNalJBUndndHZPOW5PTTRuaS8vbFJ5V1lWL2R0NEhoYllYNzZrSnlB?=
 =?utf-8?Q?oaPwrJKPXGbHQhAeigf/Fa9ltDtyYkaR?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4290.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RmFoYlovU21NU2N2TjM0SUdkNTlhS2EvSkx4cnVIRGZ3V0FpU3NDeStiSFNT?=
 =?utf-8?B?Z0FvUFp3eUswUnJpeHFFSy9KMzhFQ21UUzRXUG1wUUkrT1VsSEE2MkVaVC9K?=
 =?utf-8?B?VGNXcnlHdXZueCtSV3RiOW5XNDd0LzZpQWx2N1JaNHFTdGxHRGRnVU1kTlZH?=
 =?utf-8?B?aldVTW5LcEZOUW5PckVqaThNR0dtYjRqOWRHbFl5V0NoaWtHampSaXNPamRi?=
 =?utf-8?B?MWFTZUFrM1VuRUgvOXF3dlVrSTY2WitrbzdaSHhBc1ZsKzVEU0xJdVhOVGNr?=
 =?utf-8?B?bkcrU0E1bGV2bW5ra3FzcHZlK3J1UUsza2RpdHZIV1pqSElGWXc5TzZINCtD?=
 =?utf-8?B?a0hEWlBvdUlkTmVmb1VqbDlEbU8rUGZJUEUva1B5Q3JQZU9IU2FycXc1Y25w?=
 =?utf-8?B?TEZRSjI3T2I4STNtQkUzNnpIdkNTcU1xUHpZWjZCbnRtL2pSaVN5L09sVFFK?=
 =?utf-8?B?WXpUZnl6WEFON3dYb2tLWjRkRWtrRTgraUxscHhrK0ZuV0dXNnpIbmlaTk9V?=
 =?utf-8?B?eU13KzUzTFUwbVZyQzl4Z2FZVm9EVWpXL003SDhiTnVibDNKOTlyQWpOUTJ4?=
 =?utf-8?B?MjAxVFpXSGY2bWt4L3E4RmUwMDhXU3hoQ3lZRmhoTlU0ME5EMUk1Z3AxUmw3?=
 =?utf-8?B?aHRSUjlLdnBOdnpxTllzMVg5RGl0ZWx3VVlWMlRzY25XWUp6TUhTTEw4Nmpv?=
 =?utf-8?B?TUVLRHZpVDUybmEzWS9TU0FHZmhVWUFDNDVJMkhweS9LY3ZPNkExdU92bTR3?=
 =?utf-8?B?YUNCekJ4TlpPZjRwRWlUcS8yVUlhbTNrSGEwZG5QOE5IdHllVmZuams2dHV3?=
 =?utf-8?B?N0swYk05aDRMcVRtOTdmTDl3dWxkaTdqYkxHaDRDT3VPQm9jUVB1blZYV0tF?=
 =?utf-8?B?MHV0VXVwQjVqMVpoMHBGa0w3YkNmWGtFelc0YWxBbXU5Rnk4NTgrTFdxWFA4?=
 =?utf-8?B?R0ZzbGM1OUhTVXdnRW8zYTUxQXViSjBqZVJEZzFDbGJJSUVtSS85aFFVTXVT?=
 =?utf-8?B?TndNNlJzWEdCZklKeUxlRW0rcFpmRmIvU2U0T3lJTTdnTGN4ZHZJSWFWam9u?=
 =?utf-8?B?WW8yY0dtdjFJeEc2RHdlN3kzK2tLUzRPODNncWdSMjlLOFhkeEp2YlJvSll5?=
 =?utf-8?B?VFp5MVgyS1VKelA2enBxUDFtbVBjWjVrMnYxY0dTdFVlRVJERHhLQnVvZE5H?=
 =?utf-8?B?VnNvdVl0eXpiMEZTOUxFVW9pb1hEWkY4c1psM1JFVEh2dGcxdEdxUndPM0Jj?=
 =?utf-8?B?NmhpTlppUG91NnBBeFZIUG12NTZLSlYycGpwMTQyekIwWWZ3bDdwd2kyZjBM?=
 =?utf-8?B?OGR3dEw3UzVOMWhTNlJCSHl1VG9VdWl1RmZFL3RsTys4YW5iRksyYVFFc2Qx?=
 =?utf-8?B?UGRSM21JbGdWblN3eVZhSFUzUjRLQnZwcnlEZ25BTDNBTlA5NGRJL3FBaFBJ?=
 =?utf-8?B?b0hFU2RqampSRGh0d2RzTkRBeDJhWEtDYTB5L2hmbDNlYWs2VXhnZENPaEVC?=
 =?utf-8?B?ay9OMnJFa1pLM2QwRmlEMGkxdVRzaEtMNnQyVnViS2ZkVkJQaGx6Ri9RRzR2?=
 =?utf-8?B?ZXhybEV5V0hvdkFkSnZvUVdpbjZpYm81RWVINjRpdXV2b1pLYWxETnJTVlpj?=
 =?utf-8?B?cmI1M0xzSlhlMkNTb1Jma2FKN29QdWVhUXdIZXJGVzhDODRPd3lqaldFcmkz?=
 =?utf-8?B?dVQvekJvclBnTno1eWlGN1UrV25QVE5WbGs2T3ZVdHZhcFkyWE5KWDdLc1R3?=
 =?utf-8?B?T2hzNndFSDZFaVFrMmtwN1VKSVd3VlBXL2FJYnJlZkk0UVFIYmtDYW91QVdy?=
 =?utf-8?B?QXN6OVYxZ3E0dHBDYlJ3MnBuRE9ON0lPUFErZDdxWFB5NEI4R2d3eWlPUEhP?=
 =?utf-8?B?b1ZuUnBuRkpueW9LYXpYL1AxcUpMMHlqOGwxNWpjZlJIN0owRjZIc3lpZlBU?=
 =?utf-8?B?RGhKOENmUXlBcDVubUNpNkJPTjZOWDRjanVMd2ZHMmNBOTJCUlBXRE1laTF0?=
 =?utf-8?B?RHNuVWVjTVZ5STBQWkpwV2oyaC9GYlEwSzFEVm0xMWlRSm1tTEhDQlcxOEhL?=
 =?utf-8?B?T3R1TjJGMHhBMUQyb1BGYXNPNnVOaDZ5SmliWDhyWTJJRHI1emkyaDVKRk5p?=
 =?utf-8?B?ZnhYRi83bHVua1JpUVhVdm5id3NtQVZVcDR2bko4N2ZROUNXKzg0andwVXRC?=
 =?utf-8?B?OFE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ktePyidrrGFRHeSRFG558KqxvXCaksQC6iCZuuKQrFjP4r6R5W4G5cy+TStTuNhImUIseliyT8WQ6Q01m3GrsZZ9yuRgrf3CF16TbwblM7bM2/HoHk3qi6Du18ex7t2rFcSmKoKMQGTe9vZK2ou7VAJroVLzSw9r0HHmXs1AJjyMH6DRraZSdqoSj8UXVtmlvf1ZlbqdCHD6hbdoydrlJE6vfefNNbgmQReW8xNu63tzEOJV1Flcgn9geiKI5/d4XsxXnWkQnykZs4yCvOFQj2mqdf+spOxyi1qzbSJpKKi6YsJN3pMWI0kL7UQ+xPOSY5qx1WU2fXBnqepZlRghaQIe7quoxP7hNbU/jUWutNJXL/0HnAdRtMNBXHZT4dgMpFXoNOT1hiAVjrngVV7tmAOwXT0fkL9gmhm5OWNxz7R0BOtlgTS/kFdZ9y5Pvy9K1Gv93AI2bqae0CNoicKZ6HVQ00Oq4/5sk2kqlG8V8IHmm7+Y3P7gShKjiTQ3ZhqecIcV+6F1EcSwcOkRhmnM/XCwe8ejV71WK82lJiqCtCBxU7MMQUUb9JmEacZi+I7EToDZJLhhpZi5XFhnXO7XxuOONqwSBuDcnB1X93fmvdI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e66194e4-a504-42be-bb04-08de00638f27
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4290.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2025 20:54:34.2310
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g1s3TNEkIR3R6gB/1jMV/luTi1g4iGbI0YhtBxCasweP99la8pZAp4KbiI0kIzdERqPvK1DogCyCs/siF6NUefcEdzAOxyZ7BEjhasti5S0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB8031
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-30_04,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 phishscore=0 bulkscore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2509150000 definitions=main-2509300190
X-Proofpoint-GUID: Qp3ATg-zNqPua1LjsFRRMbN8O4nr0Km0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTMwMDE2MSBTYWx0ZWRfX/T241UPZwJ7k
 /GkMNvUDdwYelbIw9mAuWhcuD7g8GThlSsV/Oz6/0yGUxGt9in298VQ6jOVNxDy1qYRhCB3EA7k
 3FMRJhllkdWj9l7CCJrIGz+bciTUgBi1uSj91g+iVazEv/zI43F/4zzIjt4gQJEkV9JQtBQphbm
 +aKK/shqkaDc2NQXqeBTXxFcY7R5tO6FHnK5r9+DlhPkSds4+SUvlISSgmj0YU1YLaiXDk1+mvw
 S0Owz5xQMLGeLqgD0P+BYm65cqCH6PvaAYwyRTDMqkizgh2GJnwGiWEVG7FEJuFuBytvc4OWBjY
 A1ayN6PN91QXC2GJtxejSNPozFr+GUwoB1lfSl8ptVj8MImf1GYEHuZKriWXvomtfS/C25whhA6
 uqgSBsW5jn15QaM1399K7m8xT3C2mA==
X-Authority-Analysis: v=2.4 cv=RLW+3oi+ c=1 sm=1 tr=0 ts=68dc438e b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=Koiyb8fEc_k2pmM-oY4A:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: Qp3ATg-zNqPua1LjsFRRMbN8O4nr0Km0

Hi Mike,

On 9/30/25 3:32 PM, Mike Snitzer wrote:
> Hi Anna,
> 
> Given that my NFS LOCALIO O_DIRECT changes depend on NFSD changes
> which will be included in the NFSD pull request for 6.18, I figured it
> worth proposing a post-NFSD-merge pull request for your consideration
> as the best way forward logistically (to ensure linux-next coverage,
> you could pull this in _before_ Chuck sends his pull to Linus).

I've applied your patches with the one NFSD patch acked-by Chuck and pushed
it out to my linux-next for a few days of wider testing. I agree with Chuck
that the remaining fixes can go in through an -rc once they're ready.

Anna
> 
> If you were to pull this into your NFS tree it'd bring with it Chuck's
> nfsd-next (commit db155b7c7c85b5 as of now) followed by my dependant
> NFS LOCALIO O_DIRECT changes.
> 
> The following changes since commit db155b7c7c85b5f14edec21e164001a168581ffb:
> 
>   NFSD: Disallow layoutget during grace period (2025-09-25 10:01:24 -0400)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/snitzer/linux.git tags/for-6.18/NFS-LOCALIO-DIO-post-NFSD-merge
> 
> for you to fetch changes up to cd784fe2704a1c90ef3a1a116aacdb08a9d594e3:
> 
>   NFS: add basic STATX_DIOALIGN and STATX_DIO_READ_ALIGN support (2025-09-30 15:23:35 -0400)
> 
> Please pull if you think this makes sense, thanks.
> Mike
> 
> ps. I know you've been looking at all this, but it is late, 6.18 merge 
> window is open, etc. Just being pragmatic by acknowledging the awkward
> sequence needed to get these NFS LOCALIO changes to land. If you'd
> like to skin the cat a different way, that's fine.
> 
> v2: dropped Chuck's 2 "Fixes" that I had folded into the NFSD patch
> 
> ----------------------------------------------------------------
> NFS LOCALIO O_DIRECT changes that depend on various 6.18 NFSD changes,
> culminating with: "NFSD: filecache: add STATX_DIOALIGN and
> STATX_DIO_READ_ALIGN support".
> 
> -----BEGIN PGP SIGNATURE-----
> 
> iQEzBAABCAAdFiEEJfWUX4UqZ4x1O2wixSPxCi2dA1oFAmjcLkYACgkQxSPxCi2d
> A1o0BwgAnOhyvsON+TFdIL8opb2IYIsFxKQ9pakKUm38NSMe4fm4DRl7V6+Co0AZ
> kYWWSQEkq7CSLgJ99L8DDhcDo32L5AJyGpCp1zydhipGLu5lJ04ANfTsPOQjVYrQ
> jA+a5mCaLxx3X2Je8LgVo3PelalmpsRsAwwOjAFg6wpay+VtiDYtR/jQqeT89l4K
> euUC8aKSjM1XPIA84vjN0m+yrs6RTvzLFUS7dpE3JibL9L2eunS2m2d4wTlLky34
> vxqRHwe3FaSqO1r/JdS6jMqTrlrPJsEgyri+DGBwPzeBH4Lu/lAp9NXp2LE57Eyr
> tMOmTnmi4OMVlC6YAVwFq+RuiuSpOg==
> =5fHh
> -----END PGP SIGNATURE-----
> 
> ----------------------------------------------------------------
> Mike Snitzer (8):
>       NFSD: filecache: add STATX_DIOALIGN and STATX_DIO_READ_ALIGN support
>       nfs/localio: make trace_nfs_local_open_fh more useful
>       nfs/localio: avoid issuing misaligned IO using O_DIRECT
>       nfs/localio: refactor iocb and iov_iter_bvec initialization
>       nfs/localio: refactor iocb initialization
>       nfs/localio: add proper O_DIRECT support for READ and WRITE
>       nfs/localio: add tracepoints for misaligned DIO READ and WRITE support
>       NFS: add basic STATX_DIOALIGN and STATX_DIO_READ_ALIGN support
> 
>  fs/nfs/inode.c             |  15 ++
>  fs/nfs/internal.h          |  10 ++
>  fs/nfs/localio.c           | 404 ++++++++++++++++++++++++++++++++++-----------
>  fs/nfs/nfs2xdr.c           |   2 +-
>  fs/nfs/nfs3xdr.c           |   2 +-
>  fs/nfs/nfstrace.h          |  76 ++++++++-
>  fs/nfsd/filecache.c        |  34 ++++
>  fs/nfsd/filecache.h        |   4 +
>  fs/nfsd/localio.c          |  11 ++
>  fs/nfsd/nfsfh.c            |   4 +
>  fs/nfsd/trace.h            |  27 +++
>  include/linux/nfslocalio.h |   2 +
>  include/trace/misc/fs.h    |  22 +++
>  13 files changed, 514 insertions(+), 99 deletions(-)


