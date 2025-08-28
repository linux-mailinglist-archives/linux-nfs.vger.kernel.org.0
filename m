Return-Path: <linux-nfs+bounces-13926-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 006B1B38FB1
	for <lists+linux-nfs@lfdr.de>; Thu, 28 Aug 2025 02:17:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92C2B17CF9B
	for <lists+linux-nfs@lfdr.de>; Thu, 28 Aug 2025 00:17:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E98E6CA6B;
	Thu, 28 Aug 2025 00:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="b6vmYyas";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="eRLsqL1W"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FBF430CDA0
	for <linux-nfs@vger.kernel.org>; Thu, 28 Aug 2025 00:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756340274; cv=fail; b=C+FURBY7hhMmkNYIS/tmeH7MxQOYKL/9g80WBG8bu/jVc3WcS+DLRZrifnMsNgxEVzut/jasR+0IvhTVWLZDM3iBxO/PGQ09yncmEXMEDTv39j29uo29aVagFsy5CyBBAvGtbcnyS96uxmIlcxDSa5ratwrU1644uf/Vd0P7OlE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756340274; c=relaxed/simple;
	bh=TvoFOaALp0k0vTsQ/lPg8+giNi4m09JfyXL79xrevIk=;
	h=Message-ID:Date:Cc:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=F8NRsCCIsKlTJjfWnWieZRxtWLSV1Z7UW/MacdC2o1OxOj7hHqobBaHC/CBEgM1RjPcYrd2rrtuhZLHt19iwcoq3njkST+CodsmMWyj7gxF5+rwHrMjA/YBl1xyUqEa28yCjQqNY3Be3pxFTAYzbRlYgDraM5dMyssqMn2ZpovE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=b6vmYyas; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=eRLsqL1W; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57RLH9Ut007649;
	Thu, 28 Aug 2025 00:17:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=1cq8G+1uffWkTdjX2B1FgnEYaOi65uqvU8apMLk45Sc=; b=
	b6vmYyas54V2KTYCd/co3fz0QgeP8aD1avFlWaiGBdKLmyTkHH1LvnH2aYVrnfuS
	3Urz/KvpiPnz142lYNbY0JtvnUzSD6PnuQRWzLJt2stKChh1C7XL+NdVQfx6wX8P
	K5ko/s/AVbR5r7BqsYJUOl8SAKBpbMP0/FBt2r6iTsNAcV6QnDJ/uvo6sXyHUTN8
	ynv5q82hv5yR4+2vpDe+MPls4KUbf/a35cbxA30IRWFcqaMN4+EfjEnxl4s8vYyj
	W20x0cmUwIng+PUu3Ui0Kb+6szI0kfVQXpr7syD8ba8+F2XnbCMRsNZvbp31ReLB
	xdtwRtwjvXIe33KnxSKOig==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48q678yhej-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 28 Aug 2025 00:17:50 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57RLgoGn005021;
	Thu, 28 Aug 2025 00:17:49 GMT
Received: from bn8pr05cu002.outbound.protection.outlook.com (mail-eastus2azon11011011.outbound.protection.outlook.com [52.101.57.11])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48q43bcw7v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 28 Aug 2025 00:17:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c5+bqNY/218G9rr/IPBuT8U7MIof0UVNx7zYhNfbhT0aa16cnYV3Un6eKz4hT6S1wV96sbAHsokRsfpt9eh+E7ejNWU7l/YMoLo8lZ1BUcvJUU0kiuphbwaY1Xex5LTAU/S/N1eEiTFC5G8qbu/4eKrelNWNOeKLBvhZ2hI4q8FOY2FPWJ5Si/PRkTdz2t+JYWsdwCEVU7HjVAErXCt2P3ePoxnefAW3eaoSpwn6ikY2cSVsyxjCS5Tz3Nsx3MJFl6/dy1LGv660P7rB45OXAcu/Ux7f+PtscCNm2KXx64AOXD7Ok5KIIrMbAWpmKaD6uCAQUFGZi6PSFTpSMSlaFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1cq8G+1uffWkTdjX2B1FgnEYaOi65uqvU8apMLk45Sc=;
 b=fHozrfgIAKhivcxS9sUoAklTUcPNjVe9kjX81XlmlrpHP4bkvpJpkjLqbMR4xBcf4Ow9jM7jKh8uMUJ0li5pNH/4ifPRf0fPbLhwumpLuy6pzY5SsvjJs7UbzbWgzW46hl7ol3Om7I2+nnh/hr3D+Ts2NrNV4I6EtEXtuYgFcmP9IWZZMxGxMrroYiin+qx+HAn4C9RlEJHLbb3kWUMTQAPPIHx4Y+mfnGvESorDtZA9VAPMjnKZaLjuXg4OMENTHY/gdl8G+5oyZ+EkvZVMBUTIb6oorAE8wVaxho3wG0NXkW7unAfQHGAUL3EiLGaSOeWARzooc+8Tf+Vyx7FjEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1cq8G+1uffWkTdjX2B1FgnEYaOi65uqvU8apMLk45Sc=;
 b=eRLsqL1WxhBXYgxNlXXcY0hgJjPU/PCdklL9N3aXpZJfqnrPXafpjQLXHHxjKBKTOZRk2LhdsRdJKmjsZp6GdIqgVIyEqOqZCLOReonOu4fHLrHjR/QNpV+EEOJbJeoMk+YbLztIvmTVD5OnzLHHs52XhFQwOc8jfCW1MaLM0OQ=
Received: from BN0PR10MB5143.namprd10.prod.outlook.com (2603:10b6:408:12c::7)
 by SN7PR10MB6955.namprd10.prod.outlook.com (2603:10b6:806:329::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.13; Thu, 28 Aug
 2025 00:17:47 +0000
Received: from BN0PR10MB5143.namprd10.prod.outlook.com
 ([fe80::783:503f:ea07:74c7]) by BN0PR10MB5143.namprd10.prod.outlook.com
 ([fe80::783:503f:ea07:74c7%3]) with mapi id 15.20.9073.010; Thu, 28 Aug 2025
 00:17:46 +0000
Message-ID: <a94dfe30-ff3e-42f2-9318-0aad74c68d7f@oracle.com>
Date: Thu, 28 Aug 2025 01:17:37 +0100
User-Agent: Thunderbird Daily
Cc: Calum Mackay <calum.mackay@oracle.com>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH] sunrpc: hold RPC client while gss_auth has a link to it
To: Trond Myklebust <trondmy@kernel.org>, anna.schumaker@oracle.com
References: <20250827223831.47513-1-calum.mackay@oracle.com>
 <6813623b0780828d7e2a6dced04f74f803423f20.camel@kernel.org>
 <b18de932-cffd-4d56-851d-e4aeca73e08e@oracle.com>
 <31c40217b2bbbf5367c3a7d7ea0021e6d7879460.camel@kernel.org>
Content-Language: en-GB
From: Calum Mackay <calum.mackay@oracle.com>
Autocrypt: addr=calum.mackay@oracle.com; keydata=
 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
Organization: Oracle
In-Reply-To: <31c40217b2bbbf5367c3a7d7ea0021e6d7879460.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P302CA0020.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:2c1::9) To BN0PR10MB5143.namprd10.prod.outlook.com
 (2603:10b6:408:12c::7)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5143:EE_|SN7PR10MB6955:EE_
X-MS-Office365-Filtering-Correlation-Id: c2f5a154-34a3-446b-412f-08dde5c850a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aG1jRG5EY2YwUlBWR2ZvMzhsbnE1OFMxam95QmtGQk5kcVJPdVFxeEU1NFRR?=
 =?utf-8?B?L093VHlKU3hhSnJqRE5kTWd0ZUtVZm01bkpxMXVaeEJkR0ZFRnpJMExaM3hI?=
 =?utf-8?B?bkZvOWZ6bzlFWTQ5WlJtZDVlRllCZit1T3NmMVJTQU0vR2VnTmpEcjVtQ2lj?=
 =?utf-8?B?ejUwYnpwaDFUb29MampkMmMycjBrelNXQ0V3b21LdFhGSERlWHltMlFLeW82?=
 =?utf-8?B?Z2VSZ2NXOGlNQUVsN21MSlJNMkRJTi9EUE1vMlQ4MU9NMElwVDhjK2JXenJ0?=
 =?utf-8?B?V3hIVmZUZitHaVBNREM1UkZJdSt2SWFBVktvTnYwZFlwY2pVOUlYT2V0UGox?=
 =?utf-8?B?Um51MjdQWVVvMXpyTjVsVndIY0dZNXJuR1NralRZNCtDd09NV1FSQlg0WGhn?=
 =?utf-8?B?WUVmbTc3NkQ3cHM3TGRRY3lWVnZnWENJa3ZYbHZQZGswRy9UZHVpekIvQUE0?=
 =?utf-8?B?TEk0Nzk1elpOM0RMN25vZWhwNm14ZkNoQWx0Ymh4WVdCcHlDRGY2TTl3MlRy?=
 =?utf-8?B?SWZSR0JKamg1VkYxSVBNV2d0Qm1ISFVwb0J1RmR4L0FDRFFOYkswTTV3REZo?=
 =?utf-8?B?MWZzdHlUMmI2akJXMThYQ3lUeE1oakZUOEsvVFYvUXRGamh6cnVFK3gzTnVu?=
 =?utf-8?B?MHU4MkNvbmExLy9ZaXhYSzlUU3F1bDVUL0hxcW9XOU5ad3FLRTZaVW50RnFz?=
 =?utf-8?B?czF5ZCs0SXVWcXI5Q3RJL21NZzErSDk2T3E1YUhPYURqOHRYNGxZRGU0NjAz?=
 =?utf-8?B?V0N1Zzh5bk9DaDl6V3FIOTBtcWcxVTcrOVlQVXN4em1qTlVDNVFXZjFULzRv?=
 =?utf-8?B?ckczZDZDdk92WVBGOXNxeXFwTkliemY3Nm9UeTE2WFhlZWxudDdBWUpKbzRk?=
 =?utf-8?B?TnJ3SU5seHJhYVFsU2N5dS9YTDFyMEovc05PYWNpajV2R0NFY2JQTXM1VWhm?=
 =?utf-8?B?U3VUUW9UM2xtc2JXUnlpc3lRSXBZay8xOXBHZlhMNFRGeTdXM0trYzREYWFX?=
 =?utf-8?B?QVVoeUZoK1JJS05FYkRscVdwSzhma2djZFlhM0gzZ3JaS3lDWVJJVjhzZGgy?=
 =?utf-8?B?cytnaUxvZDVDN3NFazJiRm1EYWM5U3lsUndyNzZPOHVkWG50aVBzUUU4cGRL?=
 =?utf-8?B?UDd4NGxOaDN3UmtPQWUzWkoybm42UEtFaHovOTVkTnJOTStVVnBWTEN3aXM0?=
 =?utf-8?B?aThhMWZuK1lYNWhHaUl1bHV3blVpbVVPWWZzOUVkMlNlTEc1RmFjZTFvcHJp?=
 =?utf-8?B?eEdFMDNxVVhsRVJoUWRNaWdkd0p5Sm5hVE5nbE5CTjBOYnVuMHNXM0JUb1Bj?=
 =?utf-8?B?R0Fwb2FJR0p6MFZMdHNLUkZCUTVoYTFoTkE2U0VhSVA3cFVRYnlMRkdaUkpn?=
 =?utf-8?B?K2JrY1N4cmRsOWZyTjBxamMzVGhDN1l2MVNrU2RyZGdmSXhqKzUvRW02MkNG?=
 =?utf-8?B?SnVjeWdHU281dkhRdTRkb28zSjE1SUVtT1VEVzhIcTZUbkpsNlNPUmVvenZR?=
 =?utf-8?B?MVV6dC9ZZXQyS1gvd21OeU02QUlISFJLWWxndjJoczJYeDNwZThTMksvZHpj?=
 =?utf-8?B?WjhjMFk4QWtrdXVIeEpNZW52WkZkZGZUbmoyWFVlMkJJU1c0ZzJZNkFKakth?=
 =?utf-8?B?NnEzbTMyNnhvQUk2K2JPUDhsZDRlcDBoMHNHWXlNTGNUR3c1Nkp6VFVTT1dR?=
 =?utf-8?B?UEhFenN2UFg3K0JyeUtYRlFmbGdvNjNzNGwxODFJRHRDOGEva3pwMXdXV0xZ?=
 =?utf-8?B?OU1RVG5OTldyVjRxdEw0T2ZQNnM5emJiN21PQnVZclJHYmpKK1hKWmtFQzlK?=
 =?utf-8?B?UEl2WW0xWi9hOHdlS2VXdm5nWVRiZnpSWmMxcGNmeVR6Z3huM3hKbWZOZ0tr?=
 =?utf-8?B?M3JaSEI5c2dSdmVBVENmMWVObXlLV1FTUkk1RWFVWko4VjZjNmtzMU5qQ3hX?=
 =?utf-8?Q?U6K/mOiZW2M=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5143.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WUhTSitFTUMxeStTaDBWOVdxZlNPRi83c3JVL1NCejFlWTRLL2RwdW5jV3RE?=
 =?utf-8?B?YjVBTGQ5WGpEL1FLK1FEV0JmMmpMNUJBdmI1MlUrUStDbjBFZnhMbTk5Z0Zp?=
 =?utf-8?B?Y3NFRjhWZjUxeE9HNURqRmIrUngxT2w4UkRLUXcrZEhGM005aDJGVmp2bktn?=
 =?utf-8?B?OUo1WExEcUxKRWtpN3BoN05kRGwxLzRlUkdodVNibDBSQ3A5RlhVUzEwOVhs?=
 =?utf-8?B?UStZUExsQzJPOEU3ekk5N1lvSXpUZkZ4NzRJMzIwMHFxMlY3Z2pzRzNSNEpB?=
 =?utf-8?B?aXRPS1lvaWNkZzQ4M2NhdmtSMW1vTzN3cG9FWWhjV09jbWh3YUJPWlQrT2I4?=
 =?utf-8?B?YWNsTnBiMUoxeGZ0bFpaL29XV3FQdTVoT1dubjF2Y092dGZPbEY5WSs0ZE9N?=
 =?utf-8?B?eFVDVVRtV0dyU2xRMktCQ1NrV01wdFNQM05SbC91a2VuTHpzYk5TNC9VYW1I?=
 =?utf-8?B?aXVvREo3b0pMUjF6TmszN3BJSW1qNzBnZkp1YjF0bHN3SHNJQ1ZGbGtsRWZz?=
 =?utf-8?B?VnVzb2xNeFU3NmtMYlR0Y2I3NTA1eWFCVnZDdlBSbWVvVmFHcHZXNCtkRHd3?=
 =?utf-8?B?VEdJV2RTUGFGVWRRVlJrb21rL1IwYjNFUkl6Y0NWTGluQU5HZk9IZmNIQ1Fy?=
 =?utf-8?B?cnhwTzFvRkUxbVRGQjFYdlNIeWd1SUVxbnV6MUh2cHNPTUtQSXEwQWw3V1RD?=
 =?utf-8?B?VkV3eTNSYU5US1A1T2hlbXJBN3Fwc2ExaVJPQkNuWEZDaWxKaVFiMVp6dWR5?=
 =?utf-8?B?aEZNRFhxaHpEcHVzTHlJalhuUHp2WndsN0wrTWpLNnBQdU5qRzdqTEpZMktV?=
 =?utf-8?B?Y0dZQm8wYlM0bDBIZEFLTURzTmozVUNQS2FXeGNUSStqaTNhNVRwYW42aC9y?=
 =?utf-8?B?OHJiODU4YnVmamhoZ1pBV1hCbm9nL0g2OGF0UUNIVXdyelZ0eC9QQ09jRGJr?=
 =?utf-8?B?NkNrNmNqaU93VDlIK3dSZmVzSkZJQlVjWXN4WmhNUHJEZXQ5QjZEck4wMHFC?=
 =?utf-8?B?UlkvbTRmTWlEMUQyaXRGUW9mV3Z4OVRtKzBWVmtxbGpYekJSSWNYSktOaWtp?=
 =?utf-8?B?VGFVMEJuM0lTMjUvaUVrQ2Z5ZjAvSWwrSW5FYUxoQjc3c3hVYkJXMG9VQ1FE?=
 =?utf-8?B?U0NRaTMvRk1WcHN1YzVFY3NMQnZmSVFNMDRIN2ljTGhnRmxsWU1JeU9qa3hm?=
 =?utf-8?B?b3lSUUNGamtFamZMOEpRWTdRMXlVSG8vL0pYWW9OY3RWcS9XK3ZNNlppTkR5?=
 =?utf-8?B?Mk1qK3NIVG5nejZxTWVCNjluMWl4OHBsckROSXhaSXl0QTZDbnU2OUVnYlQw?=
 =?utf-8?B?N2VmZnV4QVV6Y252ZXk5eUd3SG5lUWtsckxScTBZOThWa0tuN2lLdUV4eVU2?=
 =?utf-8?B?TjVtUmUzQzBNc3QxejFCVVgwYU1ENy8wdmpjOW5SUEovVDlSZXYwUVNHVTlZ?=
 =?utf-8?B?WVpiMks1blhKM0RMOW1IZjhCMkdXVVZoRk9iN0RxcWgwSlRIQlVkSzR6Vnhr?=
 =?utf-8?B?NTRlUmdHV042QVNhd1RXTjBrc1dUcmdqRXF2UXdQaVV6QldQZmJBRjEwUE5E?=
 =?utf-8?B?d3VyVFltSCtIaS91UjNmNGhFakhOdjIvTUdDN01KelRtRThudm1tZ0tMS1kr?=
 =?utf-8?B?SzJTdzBBSytMTFh3eGs4dUkzRSsrY044ZUdCQlE1bVdnQXJaUDdTNUNhODBo?=
 =?utf-8?B?bENER1lhaTFLaTFJR3g2TVM5T1ZDMlNXc2NZemV4azJSWEpYZmFLMDFTWGkw?=
 =?utf-8?B?eVZYWmtaaFZHdVpKbXBsMlY5WllYSy9LSDJDWG8vRWI4TFFQYWtQSkNJNDNR?=
 =?utf-8?B?VWFCY25XZlNpNitndjF5ZFlKcVhIaVUvSG90VWVxSE9yeitpSm91UEdSb3Js?=
 =?utf-8?B?OEovRlAzSmI5ZUg3MVoxbjJvY3VEWlFEWmV6czdqWkFtMnBOQmxxYnNEQTBh?=
 =?utf-8?B?OElvQTFuZGdkSy8rUXNvV0JCK3luNlNOdFJoMFJ5T0ZlUjVGS3lXZlRqOVRM?=
 =?utf-8?B?Vkk2NDY5d2ZXWEd5SytIc294RGNtWmZJM0hJU2J2RnpQeTZKZjgrcUZJMDNZ?=
 =?utf-8?B?UU9CWUNoRmtYZm9WdVBBRGpINFcxYjVLUHY4U0Z2d0NJWXdBdDlTWWNZQ3Ix?=
 =?utf-8?B?Q0NEVU44RVIxM2xPQVlpTHJWQ1liWXNiUnRoYWxubWR5ZTAwM25TSnRPUUxS?=
 =?utf-8?B?Ymc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	RYiL03xR1zVpZLbAa40egTOiDpMdqhHvaNP8woNmskxSRHs8y5W2k9pZ6elmCActt/LAAgtBqVT6hca0Ew4Ao1NO5dA6zdX+cuF2TyidrTz5T78okdycvd/H/7clWq+wN9Ayo9XzjSetxUWHnZLFDai7EJGeqd1LNS+K+NhlGxLBhZnKVxDfVlZNS5eEYyh+1Njg7JIYWiNR8OU6hggxJca/zTfyuwtbaOA73x0Rxu3SvQDBBizqwTr1HUlGAsv40XcnXpoMrW+BeS8kZD+S6RJFp0/oAexgruPf5rIEOAHi86LALsAsdJlzKpgNfTlF10veSA/wePtthBZRTwirWxGSfRQOPQBCicbt+IPy7RN1n9Ztrvuan3WsDeIkK5J4zCId1hg6D/0zcBzp3x5lJxvDl2ptXouIJ8RwKzAZzHK832iSjaTbSGXWqcS8O8I/UdjRfjZZ4dcqzWYdEAT3uyg5O5QtM6kJcV/SB6ZLtFTu9pwZ8CAjYXy0JP0dKkOfeOPHShOCnSQI8SjeCitP/SYRT/T45PaSnYg+Y5c35M88CYfYtBzxMTcUIkw+n/JRIurSCrcrBjamOl1FmGx66G5ceXldtquQIVDs5p3+a1o=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2f5a154-34a3-446b-412f-08dde5c850a6
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5143.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2025 00:17:46.8548
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: THw+A1Qhu7BLR0QLTSKnw8ZDJbuiTM3wOMjsIw+ozR0goyTsgV60zHcsRTii5SlCYSMIE6Yr+fdbguOvFGmegA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6955
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-27_04,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0
 mlxlogscore=999 spamscore=0 suspectscore=0 malwarescore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2508280000
X-Proofpoint-GUID: gOumjwQbfYyyHqcVrejzSq404Ft9Oqoh
X-Proofpoint-ORIG-GUID: gOumjwQbfYyyHqcVrejzSq404Ft9Oqoh
X-Authority-Analysis: v=2.4 cv=NrLRc9dJ c=1 sm=1 tr=0 ts=68afa02e b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=PyjNDq14wqEkUo4RvGIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAzNSBTYWx0ZWRfX/w68sPx9UK48
 hr/tVLBQ0gA6FQiDmSetJuNuqutmMFstJeb240MK/0Ab2AuG+8cP7UU5K2SqHWqVJT3n8pj056y
 OQ1Dt9GAuZoOEgRfSKcGyosZ3SvmhJWSbJHhLwfYjT+K7As1snfQgIXctwBSFN8YkN5p/OIFgX+
 KoSgN8c3yQRyVabt8repfw68TeVwP3DNzyFqLQwJrhFjavX76cIe9vvy/h/JVKVkmhoFN3fKTBi
 pWceb5CoAxoWDr38j4jJDu91iOEAfbHnexbDHmaLwGd9kex8XTXNdOBi1Rvgrbaz3VJMqzkIAAj
 pT2HZINzWUMEwUwozCOSXWDmLmjp/fonHEOnZ3GGbFaK+OKCidq/1wEZlQFdMrx+bsasD5oSM1T
 9LuUKtsP

On 28/08/2025 1:04 am, Trond Myklebust wrote:
> On Thu, 2025-08-28 at 00:48 +0100, Calum Mackay wrote:
>> On 28/08/2025 12:33 am, Trond Myklebust wrote:
>>> On Wed, 2025-08-27 at 23:38 +0100, Calum Mackay wrote:
>>>> We have seen crashes where the RPC client has been freed, while a
>>>> gss_auth
>>>> still has a pointer to it. Subsequently, GSS attempts to send a
>>>> NULL
>>>> call,
>>>> resulting in a use-after-free in xprt_iter_get_next.
>>>>
>>>> Fix that by having GSS take a reference on the RPC client, in
>>>> gss_create_new, and release it in gss_free.
>>>>
>>>> The crashes we've seen have been on a v5.4-based kernel. They are
>>>> not
>>>> reproducible on demand, happening once every few months under
>>>> heavy
>>>> load.
>>>>
>>>> The crashing thread is an rpc_async_release worker:
>>>>
>>>> xprt_iter_ops (net/sunrpc/xprtmultipath.c:184:43)
>>>> xprt_iter_get_next (net/sunrpc/xprtmultipath.c:527:35)
>>>> rpc_task_get_next_xprt (net/sunrpc/clnt.c:1062:9)
>>>> rpc_task_set_transport (net/sunrpc/clnt.c:1073:19)
>>>> rpc_task_set_transport (net/sunrpc/clnt.c:1066:6)
>>>> rpc_task_set_client (net/sunrpc/clnt.c:1081:3)
>>>> rpc_run_task (net/sunrpc/clnt.c:1133:2)
>>>> rpc_call_null_helper (net/sunrpc/clnt.c:2766:9)
>>>> rpc_call_null (net/sunrpc/clnt.c:2771:9)
>>>> gss_send_destroy_context (net/sunrpc/auth_gss/auth_gss.c:1274:10)
>>>> gss_destroy_cred (net/sunrpc/auth_gss/auth_gss.c:1341:3)
>>>> put_rpccred (net/sunrpc/auth.c:758:2)
>>>> put_rpccred (net/sunrpc/auth.c:733:1)
>>>> __put_nfs_open_context (fs/nfs/inode.c:1010:2)
>>>> put_nfs_open_context (fs/nfs/inode.c:1017:2)
>>>> nfs_pgio_data_destroy (fs/nfs/pagelist.c:562:3)
>>>> nfs_pgio_header_free (fs/nfs/pagelist.c:573:2)
>>>> nfs_read_completion (fs/nfs/read.c:200:2)
>>>> nfs_pgio_release (fs/nfs/pagelist.c:699:2)
>>>> rpc_release_calldata (net/sunrpc/sched.c:890:3)
>>>> rpc_free_task (net/sunrpc/sched.c:1171:2)
>>>> rpc_async_release (net/sunrpc/sched.c:1183:2)
>>>> process_one_work (kernel/workqueue.c:2295:2)
>>>> worker_thread (kernel/workqueue.c:2448:4)
>>>> kthread (kernel/kthread.c:296:9)
>>>> ret_from_fork+0x2b/0x36 (arch/x86/entry/entry_64.S:358)
>>>>
>>>> Immediately before __put_nfs_open_context calls put_rpccred,
>>>> above,
>>>> it calls nfs_sb_deactive, which frees the RPC client:
>>>>
>>>> rpc_free_client+189 [sunrpc]
>>>> rpc_release_client+98 [sunrpc]
>>>> rpc_shutdown_client+98 [sunrpc]
>>>> nfs_free_client+123 [nfs]
>>>> nfs_put_client+217 [nfs]
>>>> nfs_free_server+81 [nfs]
>>>> nfs_kill_super+49 [nfs]
>>>> deactivate_locked_super+58
>>>> deactivate_super+89
>>>> nfs_sb_deactive+36 [nfs]
>>>>
>>>> After the RPC client is freed here, __put_nfs_open_context calls
>>>> put_rpccred, which wants to destroy the cred, since its refcnt is
>>>> now
>>>> zero. Since the cred is not marked as UPTODATE,
>>>> gss_send_destroy_context
>>>> needs to send a NULL call to the server, to get it to release all
>>>> state
>>>> for this context.  For this NULL call, we need an RPC client with
>>>> an
>>>> associated xprt; whilst looking for one, we trip over the freed
>>>> xpi,
>>>> that we freed earlier from nfs_sb_deactive.
>>>>
>>>> Ensuring that the RPC client refcnt is incremented whilst
>>>> gss_auth
>>>> has a
>>>> pointer to it would ensure that the client can't be freed until
>>>> gss_auth
>>>> has been freed.
>>>>
>>>> Whilst the above occurred on a v5.4 kernel, I don't see anything
>>>> obvious
>>>> that would stop this happening to current code.
>>>>
>>>> Cc: stable@vger.kernel.org
>>>> Signed-off-by: Calum Mackay <calum.mackay@oracle.com>
>>>> ---
>>>>    net/sunrpc/auth_gss/auth_gss.c | 16 +++++++++++++++-
>>>>    1 file changed, 15 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/net/sunrpc/auth_gss/auth_gss.c
>>>> b/net/sunrpc/auth_gss/auth_gss.c
>>>> index 5c095cb8cb20..8c2cc92c6cd6 100644
>>>> --- a/net/sunrpc/auth_gss/auth_gss.c
>>>> +++ b/net/sunrpc/auth_gss/auth_gss.c
>>>> @@ -1026,6 +1026,13 @@ gss_create_new(const struct
>>>> rpc_auth_create_args *args, struct rpc_clnt *clnt)
>>>>    
>>>>    	if (!try_module_get(THIS_MODULE))
>>>>    		return ERR_PTR(err);
>>>> +
>>>> +	/*
>>>> +	 * Make sure the RPC client can't be freed while
>>>> gss_auth
>>>> has
>>>> +	 * a link to it
>>>> +	 */
>>>> +	refcount_inc(&clnt->cl_count);
>>>> +
>>>
>>> NACK. We can't have the client hold a reference to the auth_gss
>>> struct
>>> and then have the same auth_gss hold a reference back to the
>>> client.
>>> That's a guaranteed leak of both objects.
>>
>> Thanks Trond.
>>
>> Would an acceptable alternative be for gss_send_destroy_context to
>> simply not attempt the NULL RPC call if gss_auth->client has already
>> been freed?
>>
> 
> The expectation is normally that if something depends on the gss_auth,
> then it should be holding a reference to the gss_auth->client (and not
> necessarily to the gss_auth itself). Normally, this happens through the
> rpc_clone_client() mechanism.
> 
> If there are corner cases where we're currently failing to grab a
> reference to the gss_auth->client, then we want to understand how that
> is falling through the cracks, so that we can fix it up.

thanks Trond, I'll keep digging.

cheers,
c.


