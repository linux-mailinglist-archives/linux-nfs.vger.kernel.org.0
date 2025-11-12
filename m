Return-Path: <linux-nfs+bounces-16293-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 24BA1C52BE8
	for <lists+linux-nfs@lfdr.de>; Wed, 12 Nov 2025 15:39:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9E5BA4EDEA2
	for <lists+linux-nfs@lfdr.de>; Wed, 12 Nov 2025 14:32:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A740829CB4C;
	Wed, 12 Nov 2025 14:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="du/YWjxN";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="H2zdUHjj"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 140B2197A7D;
	Wed, 12 Nov 2025 14:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762957927; cv=fail; b=pmPcdgBPOZ+YaK7yeV+IvOlVKYsU63cPjWpITS+Ey4hRluLOtcE9UKV6E/7Dt5Ki/NRyxtIdxjxV7AtjDoRNz5I7NeE6sfQPYXqJAlpQ+qOzTgauUsaioLANr+qUU5tmXnVG4TABcfbSuQdiXR9EmIJr32dWJH3XVd0F1KzZD1E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762957927; c=relaxed/simple;
	bh=snpU8F62gBRX6G/YLFoFXygE50PflbxZrK51mzV5XCw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=doeLMja/FGvsYpZKiB1x8PIpUa3UB15GV9AzV5AS7etXR9V9+TSjotrAKDZhcrldUb+yzGd9AmYep4KUh9bDJp4sMp381f2Cj7pZ8KZjT5owAI3jamImzdNk6ePtY8DpgIgKyTLtvmOq84Ak4G5P4T4qse9AgwcQ6ebrtPc14bU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=du/YWjxN; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=H2zdUHjj; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5ACEEFw0012857;
	Wed, 12 Nov 2025 14:31:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=TQlMUe2yMCsFIu9cb9bODwXVgZQfAQ1x4eppba28ku4=; b=
	du/YWjxN5wcRJx9LLvkYzYkZhldowcdvmJ0a20CVmHYFcIUN5WwSmIzCDD0uKRLS
	1jytG0f6LUoaIJhJc+RJQf/z1KC5GTdh1z+aLyPVON4darJh5VO2OVDjNyuNkxlX
	w9lG6sm79sjzJ44p/VNvLVczYaEejNq4mGWsJJfcS3C8Ybxvhoqf9oV4RCk/EdAi
	bip5353Ki4L8myFnXCA8Jhzop4Ze0L1mqhRZJx0Jzid3perWEA1QTLxdqfWyQrn6
	LHjWA2SYLaZfmButbb71R/2c/CDxnnMj+6IgzOI0mgpzN3oQjnnyc1fUAaCS3keg
	v4BLZFLnICk6AVGeK20Ehw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4acu3tr4tq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Nov 2025 14:31:43 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5ACEG4EH032464;
	Wed, 12 Nov 2025 14:31:42 GMT
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011019.outbound.protection.outlook.com [40.107.208.19])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4a9vamh6r5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Nov 2025 14:31:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MazXwB+Ib/Z/5YuGIMARLULpnQcDre0prI0OxEMMNaQlV63PhWEqa4Q83uEYWonUkJiNe5vqCRzIY8x4MUEZILNVQzTXg8blaeIhBlryr1Lh3UlQ4PGVt/uwxhTXInhRmd0PoQ7ceSO/oGwKzxT10sKpA9MRiAqrF/G59Sn5SYWbLSVrG7l59r/+ppA4A8kmoGVr/mCGrxkcUrxv4q5bAa9QkGKzQgSpFjg982zvJTMaNxm4v4EwrdIBmzgKdeCNvcfohtOTgA1Vl3LKjJx9dsxXyDOWB/kYbPtp2rdGyYOFzmYtaR/YydVSaD0GecJ9/VaejTswdKM8/LGjhxUt9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TQlMUe2yMCsFIu9cb9bODwXVgZQfAQ1x4eppba28ku4=;
 b=Bmclpfa5P927+a0upD0Jcttl4KTpOWCe25xD4f5jNDtirkZ3Gc9qPPwgvjrMHjFXG/s5ArMEpLc3t2I+lyqR+qsS8us7Kb+s9yutuENyfbiJx+K2EMcyaG0npSexDS3EKc1Uyyg7K3dCxW+U+PqcPcy3T0ItdDaqNsv6ZzwbCZ5gZijT2J4jGYbMwl+ZqZ/tQvWeNxKYlGmYSISvEBqHAnNb8c+b5paGkQtm9cH7IX1++DLlAwfAwHlevgKxFfDb9NS7nD/NkRAYS4pyi3N1YF3oXpTOIP4rFxBrGsjBHPAjaDBSgYoCl1CFncwblAHixYQDngrbkYDow4gU9cZvAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TQlMUe2yMCsFIu9cb9bODwXVgZQfAQ1x4eppba28ku4=;
 b=H2zdUHjjwP7IFOSwHzeObs2cHjVxfwPs26eWTKOR5AZhDQ/R/hkrj6E6JgLwJ1t/uYUa60L/dojXKFaRmlUEksBOAjgPT/NJa0YFXkb9zUBf9d8bPOEiIsK+wBAm6VcSVuhvvrEhZiMdnoXCJkG74YW2tZ8i8bInUrYQ7NkGcvw=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SN4PR10MB5557.namprd10.prod.outlook.com (2603:10b6:806:200::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Wed, 12 Nov
 2025 14:31:39 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.9298.010; Wed, 12 Nov 2025
 14:31:38 +0000
Message-ID: <f7dd4e03-352f-48ba-8a0d-ab9e793ef385@oracle.com>
Date: Wed, 12 Nov 2025 09:31:35 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 5/6] nvme-tcp: Support KeyUpdate
To: Christoph Hellwig <hch@lst.de>, alistair23@gmail.com
Cc: hare@kernel.org, kernel-tls-handshake@lists.linux.dev,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-nfs@vger.kernel.org, kbusch@kernel.org, axboe@kernel.dk,
        sagi@grimberg.me, kch@nvidia.com, hare@suse.de,
        Alistair Francis <alistair.francis@wdc.com>
References: <20251112042720.3695972-1-alistair.francis@wdc.com>
 <20251112042720.3695972-6-alistair.francis@wdc.com>
 <20251112065925.GF4873@lst.de>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20251112065925.GF4873@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR11CA0006.namprd11.prod.outlook.com
 (2603:10b6:610:54::16) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SN4PR10MB5557:EE_
X-MS-Office365-Filtering-Correlation-Id: d86517ca-f932-4688-d3dc-08de21f830b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZXpxMnFEd05RMzVzenhnOTlCaUR3Y0tXdmUwaU1WMHFoSVpxaDg3dGFwbjUr?=
 =?utf-8?B?d1hENmNBTDJCK0J2NXdsbE1LeThQeGpDQm0raUFrNXJWSEFoTXF6OUJ5eGNi?=
 =?utf-8?B?Tm5iSTZReHh4WEk2YVpyWW9mMEV2ODlxTlFLcXJuaDFaMnlJZHEvWGxaNi9z?=
 =?utf-8?B?dkVodEdKMFI1UjdCajhRcnRWaHJ6MUFjTGJxQW5vRE1WTXd4WnhLTkhBL3B5?=
 =?utf-8?B?emFmZmFicVozWno1MGFrVnNremkzZUkzL05tTXRmemZDQlFacCtDeFljcXJr?=
 =?utf-8?B?RS9GbXhkN0tXUGtZdkNjMmUwQ0dNeWFFcGQzcEI4RXVSaGVSbE80a3g4SzhM?=
 =?utf-8?B?T20xUmxWQ1VLTDgzbHdZMjRVN2J5eElaTlNKWWVoUENwMmhXb3oyUlgrd2VN?=
 =?utf-8?B?QnEvdWRyaGc3QUVSOHFXSXBZY0JhQUhzdkJtV2FXT3podVkzaWN3aVRwN0ZM?=
 =?utf-8?B?MS85elFvTU80VkdoOXFVOUowU0FXcnZXWTVIVGdwS3pVTnA4M3V2MTQ4SFRS?=
 =?utf-8?B?K1ZKSE8wOU9lNEFRd01UekRjZHN5UC9NNXJwbTcxalRuY2FWMUhsYWpMMkRi?=
 =?utf-8?B?eEhyMnNIdzZCOVc0UEJtaWxqK0FYMXpWL1NzNURUUSt2RVYxME8vSlpBcVJB?=
 =?utf-8?B?L0FPQXR6WlZNNjVJRWd6S2IySlZEZzB1d1ZhRmlGNjBtYXYvbVRXemJ2U0xX?=
 =?utf-8?B?Tm5YRlA4bkEwTTIrMVhUZXF1cTJoSkMvRXFkV1JyRFpLeXhLNkdYL2lRK2U5?=
 =?utf-8?B?MHFlek5mNzJuTkhRZktDMS95NWdCUldRaGpVeHEwdHdOOWhHSENCdUdsWkc3?=
 =?utf-8?B?QkhqUUdqOFNsMld3VHdLTkFOcnJXZnFWMFdNSTVKSk5TUm4wM0x6ZGFhNW4v?=
 =?utf-8?B?RzdmcEVUS1d6cUtwN01rSmlkR3g3ajBSVGlKZFBFeGF5eHBIMEFuRVNWVVhh?=
 =?utf-8?B?VlpOYTZmQk53blBWUGxSMDk3cnZHS3lJVlhRZUZmQjg5alp6cy95cjlsSWRi?=
 =?utf-8?B?K2JkT3BuYVQvUXhVVzNxZGYwbkVkWlVNbnlIUmpKcHMrRDVUTjhJTGp1YnV6?=
 =?utf-8?B?eDZnTDN4YWxncUV0eThUNG9TaXd2R3VGK1UyR0pzM0NTSmFSVU05cUxCR085?=
 =?utf-8?B?a21COGZraDNiMVBxYTFBYVhaVUt0MGRmY1VLN0IvcjBzMUo3ZFBRSnloVGJL?=
 =?utf-8?B?dGNrRWlZbGt1RGpZM043WmF2T1pNejNid2NWNi9zWjEzclI5dnd3RDNoUWdk?=
 =?utf-8?B?SnBXNnZ0TzVyOTRRTjlYZTkrS0lwTHpxYmdwNGhYUFhUQ0NHbFNGdlBSWW5o?=
 =?utf-8?B?bDRLcnUzY0FxN0cybDBwdDdmTU5udTVOYUw2SHp3TDNYcVN6U3ZSVGRCektW?=
 =?utf-8?B?Ymh6dUJzcmVtSVNRSlFTSmVJRk92UzdqNFdrVm8xR1pBVXN5a2VqYStPYWlE?=
 =?utf-8?B?d3FWNHNzeVVTWHJ2TThNWTFSSzF2azNsak5kZzRyOE9qS3F0Mmt6WmtSMmRx?=
 =?utf-8?B?MUFsY3NiS3lOTzRvT1JvWFlBb2VZdHhHdWFrUFd2TWhhUFA5QkNBNmZNTVJl?=
 =?utf-8?B?QjJOcDZDekxRVVdodlFNdXVpb1ExTDUzazlWRGlYcUUyYTU3bmxGWWNVS3BT?=
 =?utf-8?B?OGo4cVEzMmJxNUJOZVBEdjJTSGd3SDMwUTNCMkdlY2gyb01wQnMvd1VoR1Jz?=
 =?utf-8?B?QjVQOGxVVzlsbjRXK3U1M3IyV3VyYUpRYm12QXE4clFYMGY1dFNra0xiMDNj?=
 =?utf-8?B?ZGVCNEh0MzhBNGp3TXBCNDRWU0p6dFlaR1ZqWlczckxxNUFTUEtCT1BBQlQ3?=
 =?utf-8?B?ZXNlWjBXeElkNnUybUkzeUswWnhHSFFUYmpkeWpZclUyczNIOTZzR2hISmpH?=
 =?utf-8?B?bm5WNy9vVXZTRFNWb09tTHFiMUhyelVJMkt5R29uTGwvOHdkcFlKNUI1Mndp?=
 =?utf-8?Q?YJJDOS6+3Tf7dsfxzR1sc+DXSOTvvEs3?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aTMzZzFtQXVMVXRQYXlKSHhEL3UxQnllT3BydXp2ZVFMVng2aG1USHdhYnZh?=
 =?utf-8?B?ZDhNWDhGUjNZZ0Y3d1RnclgyaGhTWmJaNHg2VlRKQXBtNDJkZDA0Skpyckl5?=
 =?utf-8?B?ZmxnaEtBSzRHVjJ2WmFIbU4wVEJTOVpwWXB2ckxEL0RTZnRUYWI0RXBYZ0Nz?=
 =?utf-8?B?UXlPVmhWa1ZZYU9MbHVpbkc4L3NmcUN6d2ZwcUtsYVJNM2duRGhCdXdSWFBS?=
 =?utf-8?B?VkZoeHJSdTFobysvYzVNUk5BR1RSNmZkekJKRGIvMWRDYUxGWjg4T3BLTHhv?=
 =?utf-8?B?OEVNWDVSaUM3RllPQXNHMFppSWs1NmY3Yllqc21tSmVhS2FmYmRwYTVTcnVa?=
 =?utf-8?B?cmpIZEdnY1c1V1hkeHNkN0s0akJ1Vi9BNEZNSkhLdWsrSTNRTGJJdDBkSTVX?=
 =?utf-8?B?NUo0TXcrSDVmWWc4bzJ0TktwT1R5MmdsUXBmblk4QnZYU0Y5VklFdEQ4aEZl?=
 =?utf-8?B?RGdYaFJjdlBjR3g1NXpQYStkK2VUd0wyVVlDczdnK3d5YjVSZGJlOHhOTm5C?=
 =?utf-8?B?Q3dKcFNtM2JtWGx4MlFRREo1Y3hwUnhiM0F4aHp5VkhObThOVTI1UmRQbkdP?=
 =?utf-8?B?TWRhQWU3c0Z1YkRiRzN6cHJYTHZ2Y0dCYVAwVkZOUDRuSS9GTUo4VnlMbHJB?=
 =?utf-8?B?WVZOczNOMkdBTzZkM3N1ZDB1ZFpRdHlQNi9PaC93WTVjTTByR0NIbWx1dXp2?=
 =?utf-8?B?RXowNC9tdFBUaEtzOGV4RkFteWRPdW9SU2NsdmdwcjY2MVVSS0FvZDF0R2w2?=
 =?utf-8?B?b0VKb3R6VlBrWFRkVzhqODlzcGYwMXVTZlJIeFNlTURyOHhPT1h0cEFtOUhT?=
 =?utf-8?B?ckN0TlpMaGtmTEIzcFpjbElhRmJsMFFxUXhiajgvM1NPM0I5a0l4UFVXRVY2?=
 =?utf-8?B?Q0J2OWZ0cXR3Rmc5VzNUZEZqdXZyWjJHZ0tMS2I5Ym5ST1dacGFuNWRFWTRm?=
 =?utf-8?B?Y3lTVGcranF0akVHanR4a3FWV21Ed0JWM1doMDBSUjA1ZXova2hIaDBOWHNH?=
 =?utf-8?B?R2lNZDNGOENkU2g4eVNhSlZDOTA3cGV2eERwM3hJc0UwTGttNnF0RWxEUGRt?=
 =?utf-8?B?cGRqRVVoYTY2TTF4QU1xenpUSGFNcVB2WUxDZ0ozdjdydWd0eVlDQ3pLcy8x?=
 =?utf-8?B?cGpHbmR5MmZtNS95WjgrZEVORzRIV1dmQlZsYUF5M1FYQ2VTeWNwQ3BzOXQ5?=
 =?utf-8?B?SmFCK1J1aFhpRlRDdzRJZ1Q2Z3BNVld1a3JaVXIrU0FqSFdmczNhRzVhOWtC?=
 =?utf-8?B?SFhhTkxoVG04OHY1ekhSZUtNOCs1MFpHRUhtaW1WendhSjN4NVd6TU5yR0hH?=
 =?utf-8?B?QjYwbGw2WjAwUVVVVzJOamRWbWZHeGR6ZGx0Q05kL0lDZ3R4K0FxL1VtZ1Zx?=
 =?utf-8?B?QU5hN256RlBDVEI3NFBDaDliczcvU3IrNGk0OFc1eU96VkZmRHZ6SGRyeFkw?=
 =?utf-8?B?eUswSjFlOTNSSWZuZkFRWnEzVTVRR29UUklMN0w3ZXVsQnk3YmRlOW11bXlR?=
 =?utf-8?B?NWZIdXFTVWFub3lNZDNlTW5zV3A5Z1hML2p4dE9YQzU5YlFzeHl4UmNLWXJk?=
 =?utf-8?B?RDNXbzdSMGZ6d1NaSUEzTGlsM1I0Y2JkQm1iS3lSeXhBaE40YXRMZlRJRW5l?=
 =?utf-8?B?Z2VBcHZtZ2UwdEM2SWw3THJXalBOVFVLSUg3MUlrRGR1YTg2WWVSYmtsL2Zt?=
 =?utf-8?B?MHVucUdUc3BpR0J1ZXg1R05Lb2pKMmNsRzdNbFBLd0tTSFp3REF3amtQVWVm?=
 =?utf-8?B?cXRsT2ZGNjU4Q25nNGM4OWx2c2JrelhSYnpxZUt2WEtqR1pvNFBPRVRkZVVG?=
 =?utf-8?B?RjdNWkJZL0J5SmhZSFBGckF6S01HZEljWnlVS1E3VGV1M3JZVzBZMDNISWRr?=
 =?utf-8?B?YVFaQ0lwM093MHJwVXcwUXU3enV0QThQWnNreVdEL1FaTjVTUzJhZmhuVS9M?=
 =?utf-8?B?NHZFRE05OURpbWp1akYxZmtzL0F2MTI3MTA1YmtwSXprbmd1alBpOFIrUjJJ?=
 =?utf-8?B?ZWVtc3Z2QUdjMm1ZM2dEaTM0a2JmMkpMbWdMbUpYTSs0eVYzQ3dZbTRKMDBj?=
 =?utf-8?B?YjNFeVR5amtiQXk1NEdmTHlnKzBCQzE3OGlZOUE4bWdmUndsS3FSdHNrZ1Z1?=
 =?utf-8?Q?r8EsjmuESm624Ay2BwFf8HLGj?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Qjnv8idzuCxVU0Tz3Am3IFxiuqFjee7SzmTJJCC+VjQPplYyjyG2Uu1m0f1teXdosjlvOGL1vHYNGgleX5zNSnvqHPyWm7tqRqhmNl9iaNHxCUneG8uax4/rgwdDOko8m/B/1qp5/KVuG8uEwfxr6XCS1GuNgX5kUziLmoSMpCxUfzCmwpDc2h4mbKepqgGJlNpa1mCV6vQWtCpuaY3eEwNk6+ydOoap//Sf51qbcWlOQMsJWPVLA46KzzmM+KLSJLDhe52aXiVle9ZKwo1vo7JaYiwdXfAZEAFPd1xKtZVb9XkCIyJGCgwnF9vAntERZkNx9jKUN+EAtBClVEwRYAxFtO7Ie1+LC2E98GlSGgakREx3kuQUhJEqoHa9bIjJsN9YCvId//pB9ZpGINfo4rVACYvom48koaIRgfypuIMcwoZaImU9UNi54FdpEVElqauzTIputgDPAV1bK/nyuI5fxyC8HVPIiCFyWUOeBlnKLeqwBesjUuuz6OQl8buMY/8slxy4jROflIJORWffR2Zr8d53kWKglQbcYqGZzQ6AzviWEZ4WY9NedTgaCcfJTAtls6rt1RmDMrxybvfnnXSfkayv+zg5kENSPJ+iJ3U=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d86517ca-f932-4688-d3dc-08de21f830b4
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 14:31:38.8555
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JjGFbM4H6hlEwGLA2B90YJ4k30zKDi3pMx4MwZvDB+w689SgrNpJPM4mUetIrB9RettFvmbSAcNcf5WnM2XJHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR10MB5557
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-12_04,2025-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0 mlxscore=0
 phishscore=0 mlxlogscore=935 spamscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511120117
X-Proofpoint-ORIG-GUID: ddNpRfHh3aQhONqg39IRieBt9ACfXyHS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEyMDEwOCBTYWx0ZWRfX28Ga3bJgXNl+
 JIHkyNv2h5TXWEi8xlN1Hku7ChSrHd1RLTDCzbY7luvraiyO887ofDYn1A4vhkpcsLxtjXGU9p5
 50GmPCW/5lRPPZRtg3hVA2VrPxWvUDRRDD6YjmLJ2uL6RIKD85VpfMAUS5oY3oIglBoiJnpa2dg
 bkrIQd2So0a0nUHg4zMMBYRTbIXmBWfjsD0/G09tI99birXS9qc8+SNapp+1vgLo/elEjekZIWq
 AlZj17VzpMIw7+A1BD+gOa7uqQFeDnJgVEyy6wpmWReC6d9fvQKzjlPcGDuUIUUsw/0CvX0L97o
 Na7isghmwUaDV47ryzQAPZwwB9nfuomET6IXZBz57B8Vzxtqhqcsk2iOF6fl+jaUxuRA/LpkgMI
 lr58jkBfetDKD04h2zuSpZxpQOSC0VC+wk9lmtLzQFG952t5S8E=
X-Proofpoint-GUID: ddNpRfHh3aQhONqg39IRieBt9ACfXyHS
X-Authority-Analysis: v=2.4 cv=YeKwJgRf c=1 sm=1 tr=0 ts=69149a4f b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=pGLkceISAAAA:8 a=5p6lPETQwYYAHmxNinUA:9 a=QEXdDO2ut3YA:10 cc=ntf
 awl=host:12100

On 11/12/25 1:59 AM, Christoph Hellwig wrote:
> On Wed, Nov 12, 2025 at 02:27:19PM +1000, alistair23@gmail.com wrote:
>>  
>>  		ret = sock_recvmsg(queue->sock, &msg, msg.msg_flags);
>>  		if (ret < 0) {
>> +			/* If MSG_CTRUNC is set, it's a control message,
>> +			 * so let's read the control message.
>> +			 */
> This is not the normal kernel comment style, which would be:
> 
> 			/*
> 			 * If MSG_CTRUNC is set, it's a control message, so
> 			 * let's read the control message.
> +			 */

But it is correct style for net/ .


-- 
Chuck Lever

