Return-Path: <linux-nfs+bounces-13633-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D089B25908
	for <lists+linux-nfs@lfdr.de>; Thu, 14 Aug 2025 03:30:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D92B5A243F
	for <lists+linux-nfs@lfdr.de>; Thu, 14 Aug 2025 01:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78BC2194098;
	Thu, 14 Aug 2025 01:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LWOxtLGw";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="D4mPk8uK"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA1D813EFE3
	for <linux-nfs@vger.kernel.org>; Thu, 14 Aug 2025 01:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755134999; cv=fail; b=ubbM7y/WlbDbux1vfGq87aywxQ4Eyh0fCrE2Qmwrmn5yFQx6L3eOq2x+EzvXR3GkBVkJSPlYYx6PU6AVbiK/EXqsMPZceuaWnJihsUr5W/0XuMxGvQOuEDzy3PfNj+9hfzal+KTRHfX306/Gh+j/CmCmVYnMfNh8H3JB/kasCRI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755134999; c=relaxed/simple;
	bh=oRXmczurtjYssi+qoJS8ENvqZXKxSnG0WpQRBdz9tpc=;
	h=Message-ID:Date:Cc:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CvQpOGwbNLXrpEorRKMfultnrilnzpjgLxr5WbCag59MyDmkz4JFSuiPGZ2r0ieF18CSsHgk2kou8rjSgh/I6gxHNcjxwbDuXTJxEgbLzkzoFmvC0eGNa3y2zvGvBC3nON7yV3evV0VXJypXoOEYhvbf6VEIgjdUHS0mxrCYNFw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=LWOxtLGw; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=D4mPk8uK; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57DLu3u9031978;
	Thu, 14 Aug 2025 01:29:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=MSnxTn5gOfe2TiXDpnSTGB7q6ntiG0I/bONn5voKQCw=; b=
	LWOxtLGw2SV9zzR5+q+Lbf6KMIa2b2WCoRsKMIxDHhp0lNYnayOz1YvqVJkfBx0i
	QYikl4qvtcEQNBFzjJzusKK88At5eV/dG3KUY5ba1qBsHELdwGxpkXzZujEIIe2z
	uBzjxstia3V4xaH4RpzSg5kounQlKhyjiSAtHMDt1qDCgsLsvgobv18ooEaouagc
	Bjg1MSU1n6Sf+GFt/D6KHdx2tGA/Uqeq6w+0YMHPGGfpcQdbW3Q+KyaG2FX4bmKd
	JM4gxXWRGVs0ScRiGArCx5YNlNE2Q6lEAfU8DRWw3zFAiCHrZXOnJKh5OD5bHDO3
	6yDrrVSNFNCUeYUZaHkLZA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48guch97ha-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 Aug 2025 01:29:51 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57E0H7NE017475;
	Thu, 14 Aug 2025 01:29:50 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11on2042.outbound.protection.outlook.com [40.107.220.42])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48dvsc3n21-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 Aug 2025 01:29:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yt9D57ktCaNM9S70BC/Bvb9k16AFl+2PjQ1h7RE//tajeUxX0Ti3KvfwaMdRpUMluEv0vnmsrWfOMnkdsSFlvo6wG4mIwQJ6Qhx7JoyRSH29y4JMLWkFQI9XaVjrgtlhVQ93D/BAdyw5yg6S0G4ZxvgX6ybvk5QXe4c/wWUZXterlAxOkZ7FADTAZk1DWM8mnhkAWcEbSj9TuWYcRaj6OCLPyywUN5r+X7p4hPI/g6fGGbbzlEKGzZLhxLkdT7y6I34+/bVxDlVPCZjVwtjmGNo4/KhyNWNVmM+C33mGIUve2xzvp9+pHWixs5qdpRXxrP3WNihO2lWz04gAkdgiAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MSnxTn5gOfe2TiXDpnSTGB7q6ntiG0I/bONn5voKQCw=;
 b=Gtp1UGJ3wOsbrybevFyNdiLeYcYdHW3biN3YXjG+RABDT04wAZW0HqdTxW9Vef0e9qMw00q2h2PaalXZweHbKZHbRfjg6GmZAVc1VYTcBBvbmyDL4gA5zLItLDSsiZlN+Qzhb9MPOgjq0X/XyXSFDYJjmM49KxEUPGW5pko4lBSZU5jQy7jlgOCU9pPrpSIh/Nv7zGYwgxq7pV5e0FQtdN36krmS5Z4VZaOf3TtbcxKGd2Fita1eTAUJyf1EYYshJyOoZPX1GMykC7A7+86c0noh8gdnrOZyYGYkuQJyWtDpEaUEQC3Gg1xp9wvhl9HiF7nyaC+ihOMFhLB11M9zAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MSnxTn5gOfe2TiXDpnSTGB7q6ntiG0I/bONn5voKQCw=;
 b=D4mPk8uKIp0/agO8/X0RQjQFmCtlUyD5iD8jU90RMZNSYpu4PqCa5nVZcLLASH4lmgSH0uF5vC39OrarCF4Rj+97j1HVsncFEuX9xu96ol96q7HHerFKxR1fFDocW/CYhISy5u0HnQsL/27F+ccBtbZcgAqzH1iRxOgSXPaosAg=
Received: from BN0PR10MB5143.namprd10.prod.outlook.com (2603:10b6:408:12c::7)
 by SA2PR10MB4426.namprd10.prod.outlook.com (2603:10b6:806:117::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.15; Thu, 14 Aug
 2025 01:29:48 +0000
Received: from BN0PR10MB5143.namprd10.prod.outlook.com
 ([fe80::783:503f:ea07:74c7]) by BN0PR10MB5143.namprd10.prod.outlook.com
 ([fe80::783:503f:ea07:74c7%3]) with mapi id 15.20.9031.014; Thu, 14 Aug 2025
 01:29:47 +0000
Message-ID: <44d19311-7644-4f6e-8509-ff7312ba3ad9@oracle.com>
Date: Thu, 14 Aug 2025 02:29:42 +0100
User-Agent: Thunderbird Daily
Cc: Calum Mackay <calum.mackay@oracle.com>,
        'Ofir Vainshtein' <ofirvins@google.com>,
        Chuck Lever <chuck.lever@oracle.com>
Subject: Re: PYNFS LOCK20 Blocking Lock Test Case
To: Frank Filz <ffilzlnx@mindspring.com>, linux-nfs@vger.kernel.org
References: <01d001dc0ba9$e4cb0080$ae610180$@mindspring.com>
Content-Language: en-GB
From: Calum Mackay <calum.mackay@oracle.com>
Autocrypt: addr=calum.mackay@oracle.com; keydata=
 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
Organization: Oracle
In-Reply-To: <01d001dc0ba9$e4cb0080$ae610180$@mindspring.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0227.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a6::16) To BN0PR10MB5143.namprd10.prod.outlook.com
 (2603:10b6:408:12c::7)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5143:EE_|SA2PR10MB4426:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d180804-13ed-4ffe-5312-08dddad20e10
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YnpVY24yWW9QYWNlY0FoZWVER3RQcUFMcmczazVvT2kyQ0hncWZqWGZ1Wk9M?=
 =?utf-8?B?UEpuZzh4K3VVUVF3VFBkMEI4YlRrNFNJcjFpMjJDL0JjMHdDTnY1d3FRbWZJ?=
 =?utf-8?B?U1FEa1FxMXh4SlNFVjVDTGlvQzlhQU0yd1VlRHpWQkt3ZFpXSmpoTytrQnQ2?=
 =?utf-8?B?bjNNWHpNRzNzK3Q1YXFPUGM0cHp4YlduZUQvR1d2NjdFdmJrUHY2U1ZVRGZh?=
 =?utf-8?B?Vk5qbnIwaU81VHFqNHJacEhOeHpNZThDY2hjVFluczNVb2Rod21aOTVSOEU2?=
 =?utf-8?B?dHN2UzhBZmwyOWFxUUdtcFF5elhrbmF2aGVDZTlsZGJrUFpEUFJxVVkzVnpk?=
 =?utf-8?B?emUzOFFpV3VCNkJqMVliakh0YUFpZnRQbUl4aU9EYmFNV1BxQ2NjeGtwL2ZM?=
 =?utf-8?B?K2ZmTmhvS1c3L3c1SmVJK3pjNWdJVjBGcEY1SFN4M2F3Z3JaUVluVGFUVnVB?=
 =?utf-8?B?MWNia2RBZThPOTN1WTBJdFE5aFcrYkNwRjAyYWkzZTQwc0QxOFlVNmlXNWtE?=
 =?utf-8?B?QWdhdnN0OVI0N1Z2dDdNamljTG1veVo4SFhVQUJjRDl6UWV5KzI5Sk1EQll5?=
 =?utf-8?B?TExkVGVpdXI2SmN4aGd6cndYcXo4Rm9xYkEwa201RFRIQitWdTZNSHh3MjdK?=
 =?utf-8?B?KzI2c0ZBSDFhcjgwZWd0WmNiSFkyYndaQUxPS2ZmdzZZNkIrRUhzdDVSNWpR?=
 =?utf-8?B?cmdWQ0NWRnhsRGl5dHZjN3Z6eFRkTWJQS0swNkJMQ3JycXpYTDRjU0F2QjBU?=
 =?utf-8?B?c2ZkZzBNN3ZiQWlIbFlHQkMzcGkvSHgra1ViVm1CVVR0Q2N3Zlorc2pQdXNU?=
 =?utf-8?B?bCtUdHp2TmR5OXJZVXZqMjRCUkxCMDRKQ3E3ZjFsb3JnZGtzNGVkaGsxb3Bi?=
 =?utf-8?B?WE9xanhoQUtCbWRIUmZ0eWpEdjNJNkFJMzEwMG5GTjBMQWxXdjdUS0diajAw?=
 =?utf-8?B?QytZVzV6MUswbW50TW1KbmlmRHdVOVRhYnVDbUl6alV6SkpUNmdQbGs4WTlu?=
 =?utf-8?B?YURPLzhudXQ2NlFXWndydy9panJRVHpOWXdKMklGUDI4TTNySzNlV0pnb1hQ?=
 =?utf-8?B?Z1JGNytERUU1cUhKK0VHTE00YVV6aTAwYXJ2TzMyWGtKUHZzTzMzOVYxUlJG?=
 =?utf-8?B?dkhLZFhnV2NJYkl3eU5OY2pMemd5UnVad3hlYXoxSnRkbUpsMmdKOUw2VU9q?=
 =?utf-8?B?QWFzSE9xdWo5c1MrTWFRc1NhRkNTVHh1TXRrUzZ2N3NUR1hRR2xMa1VuSC9F?=
 =?utf-8?B?ejRuem1NdnROZG1GNjhaQXNWczFkM1BQaHN2R3R2bEliN0RYTW9GWWdaL2Fw?=
 =?utf-8?B?TmFQdFlJMDJvcms2a2dvMnhqQUZNZUZuYVdJSHlTT0p1cVBkamlkdjNnWDA1?=
 =?utf-8?B?YnB1Q3ZVZnI5WXFxZGtrQVVRMEpUYnZ1dkNPU2ZnNzd0NlRIejhHMmVCcytJ?=
 =?utf-8?B?d2UyUUkxcU9VWmJ1RktwcWlWUm9RdTc2MVFaSnhiYUtqaDNxSy92ZzRYU0lw?=
 =?utf-8?B?MGtldWNyYXlReDhrdjR3VUFzOVFoY1FuRElSN2IzcWgyZmpwMTNtbncxd1lH?=
 =?utf-8?B?QzNiRmZ3djRpTHF6UjBiZ0hlRUNvVkZXK09GTXkyOVJ5SVFjcWVIRVF4SzU4?=
 =?utf-8?B?eVM2SFprZjBwbmtCZEx5N0ZjaWhHbk5jTktvZE5tT21QWkdvN0Znckp4OGVm?=
 =?utf-8?B?YXpaZG9weTgwQjZDZE4vbmN6VFhLcFYweGhmdUZ3MXEwRGhJWW5CZWdrUnl4?=
 =?utf-8?B?b04xSzRwZkUzdEhSUHRJakI4eGh3bTZQUm40S2xYQTkvVnRscmViRDRpRHJI?=
 =?utf-8?B?eW5wT0ZSUVJ3Nm5UbWdsME1BNnorZmlJVDhtOWdmR1dxV1ZrZEd0NCt1WktE?=
 =?utf-8?Q?ZpZdYEjT2WKJI?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5143.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SWx5bFZhYjlhSDhmb09IalBldURobUVSV29RTEp5Ky94d0NHYTFwY0xzRVMv?=
 =?utf-8?B?QkNJSy9XOXRtYU84eDBQQXRmWnNoUFcwRndNcWdoeW1McTBvNGFVS3RDTkV3?=
 =?utf-8?B?ZlBGc3NmMENSOUdaL0xvQm9HTjV5anV3Y2o2VmVuNXlVd29wcktEZ1JkMGxR?=
 =?utf-8?B?dmJsWGZLcC9xSFFlQnBmUkJVTWhGY3BHSHA4ZHRaZU90OTd0YWZ5aVRkUzVC?=
 =?utf-8?B?Ylg0U3YyNWQySkkzajVZUTVPQzJYR090bEZ4QnFmUElVTllpY2s4UlpDRXJT?=
 =?utf-8?B?bHdsVWd3d0l6NXdUN3lTa0VZNUFzVkN3N1pmLzk0VVk4aVFkb2JCa2pML0kz?=
 =?utf-8?B?UFN0RjYvS01WZ2RjTFNuTm1qRGYxWlJDMXdHazNpdnBINUlZZDd1K241YTBj?=
 =?utf-8?B?SXFwTVhGSm1Dc3dLNUw5dVlvc2RKSHA3N2ROOU5lRW9JeGJ4OGt6M2tDWTM1?=
 =?utf-8?B?TUxCWGRobmVFME1qNTFZMnByY2RCSXFVbzZEYm8wK1A0MDZqck5JNFUzY3Ns?=
 =?utf-8?B?ZE5oWEsyU01LSXlGRUdGbnZuRnhTNWMxVW1Rd01xTWtJRS85dWN1M3BmKzVB?=
 =?utf-8?B?bHhpenVrcjFESFVvUk02K1hIeTFZS3lDU3dRMGdNUkFBRGt1YkJFNDBhaDNH?=
 =?utf-8?B?SkxQcGlZQm5MVDl2REN0RXljeElrSjRDbzFTNDNvTnYyTFJFOVFzTnNiT3Fw?=
 =?utf-8?B?ZjlUdFVSZEdtbncwV09SaWpEMmsxUnJJQ3ZwTkRDcEhGZ2NQaFgrZDNsNWNV?=
 =?utf-8?B?UTlMREFjak4zYVQrenlGVzRSUkxMVGZrL2kxemZ0akE3OS93TmdpOTNXZnUw?=
 =?utf-8?B?dEpCU0JXWUZoRXNqNGlhVWUxZUtJWGc1ME9aZTBuR0tSODJjQlJrU3c2ZzhF?=
 =?utf-8?B?OERWUVdIZVZlSWxwaHhlcUpWQ2lDK1RBR2Jxd09CajNqMmdCWjJuTlRYYUdl?=
 =?utf-8?B?RTN6ZHNxNnE0bmVFTW1Yai93VDRLY2FudlQwNkFRcHhTMStlMU9kVTI4b1RG?=
 =?utf-8?B?bWRrN1JGSE1zcVZEekRkUkRXK2pudDVUMjRDb2ZlVUVTMGh1L1E5Z28yNDZJ?=
 =?utf-8?B?bjBYczRwTlZsWlgyQjlscWZqc0ZIaFArK0NsSVpUMWxhTkdqeVZhZTNQejlz?=
 =?utf-8?B?eHZpTGlsVURXUmtzcmZHVHd2aVBDbWJ6MGVmSWVnRDBIZWxGYkRQczFXMldv?=
 =?utf-8?B?YnROUktUNmpDUWtib2tNQUlocUdSN2dtYkdYdTN1VHMzZVRCY1JDZi9ZV3dq?=
 =?utf-8?B?VHduQko3Qy9OY2w1amhWalY5Y21idDZOamV3VWp1Q3Y2WWlyNEQ5SDFVOWN3?=
 =?utf-8?B?c1JFVi9pRjlieVEwb1JldVUvNE1SbnBjK2NQUWdXM0ZvOThIaEFobVhYelBv?=
 =?utf-8?B?TllPbGNFVlp3V1FCUHVNRVhvUDF2bmhSekZaeXErUG9UYVZ1VHU4S0Z2SmxX?=
 =?utf-8?B?MmEvZ3M5Vm9LcGc3SC9ZZ0JyRjlWaFdnZ0p3RVZzeHUrNlVWZ042Y1MxczB3?=
 =?utf-8?B?dks1UjVYb3R3OUM0TnVNcFVHckx6aEpJdWp5Qi9Iditzb0NVM1U4RkhxNDhl?=
 =?utf-8?B?REp6UTlESHJadWZOUFFFZmwxYitHRkQ3YnVKVkJhSHlROWhuMm42cmRtQkxU?=
 =?utf-8?B?KzQ2alM2T2RJdUc0aUlkbDlrc2hGQzFXK0FKbStLbjRRM0s4S2VoQjRkOWVW?=
 =?utf-8?B?SThMN0xKRSs3ZG1QVjFITW81TGlBMDY0MHFWU3Z5ZG9hQUVRNU5JQS8zdlcx?=
 =?utf-8?B?d1FhS25iTnlmbnlVekJJbGkra3hEQjlsUmNJekp0cU5US1FYRkRSdkxwNFJT?=
 =?utf-8?B?SUFqMFlERTJkVnhUZU9qeEJZcHJONkhLd2ZudlIzd3cyNG1xQ0w5Ky81VnV0?=
 =?utf-8?B?WFRqNXYweWlGRDZZeVA4cFRYOHhyUGdrcmpsNVRYbEpQU2NTZDk4b3ZNcndG?=
 =?utf-8?B?OFlyVEY4Ylh0a1FRMzZMTUxJRE9zQ0QzbytVa29VV1RrVWxRZkFFMjFRa0RG?=
 =?utf-8?B?KzVTbFhKald0NDZIcjVKU0dzc2pmbUhWTmJzV21vVDNEMWFWSGdEbHVBU1VR?=
 =?utf-8?B?UGJvd09QWDlBNFhrb0tDMjFoTnV3M25wejJaZkJnbjNLa2RmSndzcGVHclpp?=
 =?utf-8?B?SE4raFcwZHZKUzNQdDRRUmFNYTdOOXhtemhLbkZBNDZ4VVZQUFU0ODBONFJW?=
 =?utf-8?B?SUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	fP2fVZfsoBm28s8c5JXOVyvEjkG+0ZSDJkC+Okl+g7p+rqcupZpJ4dgU2FDOszVjMy1S21pIkEx/5XjE5HolFJotYQUWCGRQwh3zEh3xHYB9AlGkaqtsCFyNiS0NxXxN+JYho6RJkjszhb/KRmktGVvlLUBVAkR+Qs2CVK2aN34DuvR9apV7icvLx8mDedw881bHeuRKO7zl6WPIqyBb96MwbufvZyqq3dUSmwJpomvZ6VXmk38vx+V1/b1gk3uNDuoTgcHIWWKBMCnJp6rUP6iSRKydguURcTNF0QNWO/ZfYf+HJJviFLMuLL/ajDLrDHN6DOBS8X1xWAKKy3qM0U9VE1uPYiMXdFhMh9soWQZzPLCf7g/hujq8XsaKMa9mD5zB/nD7ljQ0K88TTHHS1ho1rjUcxNW4NKsCDy0ykQvwyG5gQ8rSb4VfnfigfPx5vnmWWzbqFXbsLDgyWgCYV4iLZYWwMYGI79vHhTlA3ixkKG3HZeDxh8loKv9zZGcORN33qCn1s2omm4eb1WhPh6H5m7Net89AjUCNcC6vkB9uWzb9Pj9s7D8LhzJU+hCu7+ZFq/ZzFu9HyDw0Y7Nnh4EW7nY/3aI6E5lOcScGWHA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d180804-13ed-4ffe-5312-08dddad20e10
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5143.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2025 01:29:47.7309
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x5m/i8MIr/6HX0TIjocZ/kqS58tF8sPWB3SiMRfHmFF/y6dOgbckM1G0GCQaeiP/3UxRx8jOHbeySg3ei6Hamw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4426
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-13_02,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 bulkscore=0
 phishscore=0 suspectscore=0 mlxlogscore=999 adultscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2507300000
 definitions=main-2508140010
X-Authority-Analysis: v=2.4 cv=Eo/SrTcA c=1 sm=1 tr=0 ts=689d3c0f b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=P-IC7800AAAA:8 a=SbRbU_dmEwLk1SRASTsA:9
 a=QEXdDO2ut3YA:10 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-ORIG-GUID: XrDfuSEgo5Cz_RQ41xE4im4eqw8j2UUr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE0MDAwOSBTYWx0ZWRfX1Q2cc2EuUd38
 UbuUSPD9fCqMAbcSBYGjZRvK+rgHiAVWvuikXpOiqkPEFdlzY1yjoV77jHH6MvYsF2rBtPf+iPY
 wXjAHdSpWhaXXw6aRQwmaRlUWFjeQSedqbYkzu2B4Xza7kMaY+HKwyPMwUMGvMZ5lf9cf0eQ6Zp
 qD1YTDc/W0Q8VIOUww0g6tRNCcovONNDM2AF29EDvnIW4GUfU5TWywDxJxv7noWPyB4IEeNPl02
 vkrD0gb61ckEYsqieWNC3i2rdrxW3fN75Gdz0IyNRsXnHmyuvnH0Atn4TaaLn6eWRFdnR6K1rbD
 Q3qARUglxtoANO1+H6pJ2xQoI1XtodUxtbUTBWcKeGPHTuG5BSE8YciCfr0HkhmNEjf8/FDFQQl
 aIcX49XfJbHENX3o969w2u8VaDZBaWTDH96cHRtgYRurv4l5ReWNmVAHL3PyrHii6iYhReLX
X-Proofpoint-GUID: XrDfuSEgo5Cz_RQ41xE4im4eqw8j2UUr

On 12/08/2025 5:55 pm, Frank Filz wrote:
> I believe this test case is wrong, relevant text from RFC:
> 
> Some clients require the support of blocking locks. The NFSv4
> protocol must not rely on a callback mechanism and therefore is
> unable to notify a client when a previously denied lock has been
> granted. Clients have no choice but to continually poll for the
> lock. This presents a fairness problem. Two new lock types are
> added, READW and WRITEW, and are used to indicate to the server that
> the client is requesting a blocking lock. The server should maintain
> an ordered list of pending blocking locks. When the conflicting lock
> is released, the server may wait the lease period for the first
> waiting client to re-request the lock. After the lease period
> expires, the next waiting client request is allowed the lock.
> 
> Test case:
> 
>      # Standard owner opens and locks a file
>      fh1, stateid1 = c.create_confirm(t.word(), deny=OPEN4_SHARE_DENY_NONE)
>      res1 = c.lock_file(t.word(), fh1, stateid1, type=WRITE_LT)
>      check(res1, msg="Locking file %s" % t.word())
>      # Second owner is denied a blocking lock
>      file = c.homedir + [t.word()]
>      fh2, stateid2 = c.open_confirm(b"owner2", file,
>                                     access=OPEN4_SHARE_ACCESS_BOTH,
>                                     deny=OPEN4_SHARE_DENY_NONE)
>      res2 = c.lock_file(b"owner2", fh2, stateid2,
>                         type=WRITEW_LT, lockowner=b"lockowner2_LOCK20")
>      check(res2, NFS4ERR_DENIED, msg="Conflicting lock on %s" % t.word())
>      sleeptime = c.getLeaseTime() // 2
>      # Wait for queued lock to timeout
>      for i in range(3):
>          env.sleep(sleeptime, "Waiting for queued blocking lock to timeout")
>          res = c.compound([op.renew(c.clientid)])
>          check(res, [NFS4_OK, NFS4ERR_CB_PATH_DOWN])
>      # Standard owner releases lock
>      res1 = c.unlock_file(1, fh1, res1.lockid)
>      check(res1)
>      # Third owner tries to butt in and steal lock second owner is waiting
> for
>      # Should work, since second owner let his turn expire
>      file = c.homedir + [t.word()]
>      fh3, stateid3 = c.open_confirm(b"owner3", file,
>                                     access=OPEN4_SHARE_ACCESS_BOTH,
>                                     deny=OPEN4_SHARE_DENY_NONE)
>      res3 = c.lock_file(b"owner3", fh3, stateid3,
>                         type=WRITEW_LT, lockowner=b"lockowner3_LOCK20")
>      check(res3, msg="Grabbing lock after another owner let his 'turn'
> expire")
> 
> Note that the RFC indicated the client has one lease period AFTER the
> conflicting lock is released to retry while the test case waits 1.5 lease
> period after requesting the blocking lock before it releases the conflicting
> lock...
> 
> Am I reading things right?

I see what you mean.

But since a waiting blocking lock client obviously doesn't know when the 
lock-holding client is going to release its lock, the waiting client has 
to start polling regularly as soon as its initial blocking lock request 
is denied. It has to poll at least once per lease period.

If the server notices that a waiting client hasn't polled once in a 
lease period, after its initial blocking lock request was denied, then 
it seems reasonable for the server to forget that waiting client's 
interest in the pending lock there and then. There's no need for the 
server to wait a further lease period after the lock is released.


Looking at the current Linux nfsd code, that does seem to be what it 
does. I see that when the server adds the blocking lock request to its 
pending list, it adds the current timestamp to it, i.e. the time that 
the blocking lock was requested.

The nfsd background clean-up thread (which runs at least once per lease 
period) removes any pending blocking lock requests if a lease period has 
passed since they were placed on the list (i.e. when the blocking lock 
was requested). There's a corresponding comment:

	/*
	 * It's possible for a client to try and acquire an already held lock
	 * that is being held for a long time, and then lose interest in it.
	 * So, we clean out any un-revisited request after a lease period
	 * under the assumption that the client is no longer interested.

https://elixir.bootlin.com/linux/v6.16/source/fs/nfsd/nfs4state.c#L6824


There's no pending locks action taken on lock release. The timing is 
based solely on when the blocking READW/WRITEW request occurred, i.e. 
the res2 WRITEW in the pynfs test, which is before the sleep.

So, whilst the RFC may seem to suggest the timer should start at lock 
release, it doesn't seem unreasonable for the NFS server to start the 
timer earlier, at the blocking lock request, to avoid an unnecessary 
delay upon lock release if the client has lost interest in the lock, 
i.e. it isn't polling.


Presumably, the pynfs test was originally written to match NFS server 
behaviour, rather than RFC wording. I'm not sure what other NFS servers 
do in this case. Waiting longer wouldn't change the test result in this 
case, I think.


Does that seem reasonable to you?

thanks,
calum.


