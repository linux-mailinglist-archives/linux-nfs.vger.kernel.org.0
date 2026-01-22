Return-Path: <linux-nfs+bounces-18320-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +I7WHx5ocmmrjwAAu9opvQ
	(envelope-from <linux-nfs+bounces-18320-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 22 Jan 2026 19:10:38 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 85C3C6C0B7
	for <lists+linux-nfs@lfdr.de>; Thu, 22 Jan 2026 19:10:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 50CF230F571A
	for <lists+linux-nfs@lfdr.de>; Thu, 22 Jan 2026 17:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A997C3D9F54;
	Thu, 22 Jan 2026 17:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Hefb8oNf";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="miM+jA5v"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B29203D9F4B
	for <linux-nfs@vger.kernel.org>; Thu, 22 Jan 2026 17:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769101601; cv=fail; b=Ldxy7wOFCDOwL6U7cy40r9CYtW3GMne8so+y6r732M9meKzTMVRzqx2Y6D1OHJK/PaGPy0d5M4GRG7S3xGtoXcqfTbk5RgGjFA5neaea53nZjjFlyU/xD9fN1D7uhh0Vx+QDCtydlk5zSx9eUxfeSG3iTDUkf803lSHTfFGr9nY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769101601; c=relaxed/simple;
	bh=t/Dp0NPC+oqkSIYis1h1Bwm47wBdUl6p42IEGzZJGGM=;
	h=Message-ID:Date:Cc:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TO7GVEuZkm0xMJj9NEwyf2tc0kHwco9UAB6D6QxDjNX59bv+IIjbgWXNeKKfVnpiBuTXLTF5o0TQyhv+ypkbvR3WdVnIFjjCx/hDrxc/3HYFKQz9JbZHzYHIkv6k248AGUxBUK8Y3uzW1v6yhvJhgklTU6IN0MP7QBwuVVrx1GU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Hefb8oNf; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=miM+jA5v; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60MDgRIW1085816;
	Thu, 22 Jan 2026 17:06:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=PsOyIB0xrbJQ/I/HY2Bjz6opfwgxZwrl8LM+X6mlBPM=; b=
	Hefb8oNfcsbLNVboCTiz1EWybQgKTKzO6aEBx9zkgiai5RmBwyZXm9M0eAZrIuBQ
	HiUMOpmVkRaAeRAO/Qa1RvjqkhBjEBNlnTxt+vZng2GU0mo1aXuih/ir+/MWy+C5
	lQsT4E/76LPXOJWspiZC0rgcV2lrpXx4vyItCOf6UfHxt/rdv44D/x5LHgqqEeWl
	zvadQ3EetDakdY2H8ORz8TMo1zBDrkKl49sqqOzfPTpqcoDTUbKvVRpFzl/OOKFS
	8eeJ4va7+fNbbQQ/lCT09GWHDSmsoA/YZ5ESMXWHw7NXLWXqsYPbw67llr8WI6g1
	k+Q1NzpEePgLR1h6PtqBbw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4btagcvne9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 Jan 2026 17:06:27 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60MG0h5V032158;
	Thu, 22 Jan 2026 17:06:27 GMT
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11010055.outbound.protection.outlook.com [52.101.61.55])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4br0vgxrn7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 Jan 2026 17:06:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bccszu+N55ESFx6s3IvaEVyCynjgB1jMLhcFoiIPm0z6bqKepwoUPzucDrw641AwG0hLEL/rs5Dtj38W4k1aIt6TQSiH00qKV/4k5mWSdguEVb6W5fsI76I0lR3wIb00gXzzUii2leOUpM5Kg0khTp4VzhJYNvz8SKo5ClMD3EhIg8XgD6LxL0doVMrONC5spb2Ji+GSPiq98DHzYqFiTxRMDoGvl3ot8tHuUik3pCfGZWb8TNihyGFSZNo68tB32bh4Us5pq3MFSvv9wwoOgeNntdzIK0C1JFj7fMMHTHMn27aHEHewJSU76evJuDa7jMYVbftzOV7OBrscn2UlIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PsOyIB0xrbJQ/I/HY2Bjz6opfwgxZwrl8LM+X6mlBPM=;
 b=JsPvJFkJPjkOXYztHA0sHw9wZnANwFlWrUAnSmaI17JG6rC008DnVo15q13VtqisC7V5PmGVclL1PAgxv0WS2mLNzQ310XgJSyNDtpAHDaBJBANvdZm3koWB7+4dmMhqXFZo4/owx05H3ECQ6WVwUWs9ONKiNpx2SKFHrFI8HeE1UPLEkLmwyGqSwg0SMNBpqQ9Y6qHQMVURpbB0wPbpP6VYmzkPqEwfqe85PCxLrGVEOlTd8yai/ll5+h7cOnsVRQTfcG9wLCi5Xzzoc6lq3ax2xLjYIE2OSeuSLVbdR+vfDlZ7MfS/PYjVwmI1Xzd25c1XwjC0XJTAhDAEkz2jiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PsOyIB0xrbJQ/I/HY2Bjz6opfwgxZwrl8LM+X6mlBPM=;
 b=miM+jA5vqs9D4UtRcvpxWWNjADMmNSY6EmvTc4GjpjQYU0cNdbfQ2ByPePLARZTKY7DFfhUjk5oBWo8mZZj1NSES7m7POe5ky0RBTPtwS/pFGnaFPnze29sC0H7eUUc75MN2AW4b1mEEl+iuhvLBMgyV0KzfcZWBH7riDAHB1sY=
Received: from BN0PR10MB5143.namprd10.prod.outlook.com (2603:10b6:408:12c::7)
 by DS0PR10MB6245.namprd10.prod.outlook.com (2603:10b6:8:d3::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.10; Thu, 22 Jan 2026 17:06:18 +0000
Received: from BN0PR10MB5143.namprd10.prod.outlook.com
 ([fe80::71c3:4ee5:93a1:85e9]) by BN0PR10MB5143.namprd10.prod.outlook.com
 ([fe80::71c3:4ee5:93a1:85e9%5]) with mapi id 15.20.9520.011; Thu, 22 Jan 2026
 17:06:18 +0000
Message-ID: <f93f2e78-9f6b-440b-a3b7-4393899947f2@oracle.com>
Date: Thu, 22 Jan 2026 17:06:16 +0000
User-Agent: Thunderbird Daily
Cc: Calum Mackay <calum.mackay@oracle.com>, linux-nfs@vger.kernel.org
Subject: [PATCH] pynfs: Allow NAMETOOLONG along with REQ_TOO_BIG in SEQ6
To: Animesh Javali <ajavali@redhat.com>
References: <CAHPU9Sizox_r6-jSa8ik90f4q6itBo-3M3TopdGVmFymKJPUaA@mail.gmail.com>
Content-Language: en-GB
From: Calum Mackay <calum.mackay@oracle.com>
Autocrypt: addr=calum.mackay@oracle.com; keydata=
 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
Organization: Oracle
In-Reply-To: <CAHPU9Sizox_r6-jSa8ik90f4q6itBo-3M3TopdGVmFymKJPUaA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P302CA0037.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:317::9) To BN0PR10MB5143.namprd10.prod.outlook.com
 (2603:10b6:408:12c::7)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5143:EE_|DS0PR10MB6245:EE_
X-MS-Office365-Filtering-Correlation-Id: afad7136-cca9-4159-f71d-08de59d88f26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YzF0dGhkOVgwYVhjeTJxdy9EKzZnczJRNVdaUndoTVR4NGRUNURlV2ExT0xm?=
 =?utf-8?B?TWRSaCtaZ04zWXRWN2NydFpSYldVTjk5TUlVUThUSmRlZ0QrUWl3OXI5YjhO?=
 =?utf-8?B?RTlJbi9rZEFGNEdYTjBUV09Ibzh1V3dQTUlRRjBrYnlCZCtERWsxTlF6U2Q0?=
 =?utf-8?B?Tmo4SlNKOHUzbnI5U1AyWUVrQTZQbjJ5Y2w5c3JzV2V1ckRPU0Vacmt0S3k0?=
 =?utf-8?B?OWE5SXdXUktTYjQ4ZitMTjRlSWh0WGdScndyU0hpL285ZEl5VGZPOW8xWk5q?=
 =?utf-8?B?bC9LK2psalBiNmNKMFlURVREMlNlV3FXNnVNa3dxR2dzRERkeE9CQWFFbXhL?=
 =?utf-8?B?NU0xaFVHbGZ4eVUvRkJLYjlxL01rcE55c0QvL3ZRdmcyNjJITFFjVlZaVEw2?=
 =?utf-8?B?Y3RvNUJwdjlyUFY2RWpVRXBPcnJoMm9JS20vUmZkVlRvQ1k1RWRpTFFDVEpY?=
 =?utf-8?B?cXlFT3NERVBNeEVtQk9DNGlxeWw0empNdFBiMTRxdUNkMUlmcmpDRm9wMVd6?=
 =?utf-8?B?OXdpRWJYUU45eTlkUDFmNWcxQUh5RXk3RzUvTHFhbUN3R2c2UnRkTXB0SjFv?=
 =?utf-8?B?dmltSlBaSWZHMjFWSEFiTElxb1p3V3FsK1hBbW95U09QMFAyYjB3UzU0UmZw?=
 =?utf-8?B?dURDazRLSXFYZThpWDQ2ZjI4eVduckh3cWlWUXdBNXRCNmV4bC85NGptc2ti?=
 =?utf-8?B?S0VicWxjV05UV2M2WXZTbFdtdVNDUzhNUFp6dXQycEpoZzBCQWQ2RGJFMGJW?=
 =?utf-8?B?a2QrbEhoV3N4bnJ1bHdpWDR4eHFidXZuWVQ3d1pLcFQxOG9pemJjb0V6VFRV?=
 =?utf-8?B?Z2t1cnZTdzRzTzh0Ry9sSUNkQ2NoNXFTU0gzMDl2ck43YlAvQVVyMDBFSnZI?=
 =?utf-8?B?elhFa1lPaHJvVE1HZDJhLzdsMXhPRFAwYVhicDI4NWZNS1hGZ1c0czBGN3lP?=
 =?utf-8?B?VGRLOXBZdDUxVUtLcWp3Ym5Bd2owTDEzWElRM09SS29oTEx6dFpjWGMyWDkz?=
 =?utf-8?B?d3dxeExZMS9pKzBNZHE4bkFCdVN0ekwvWE1YMUxKN2NHWE5jNmNQZ3JwRmFV?=
 =?utf-8?B?SEgzcmRQcWVNZWExK3VudDVDQWU2NVBXc0JJZFhsekt0ODFwekpkR1RuVitt?=
 =?utf-8?B?aENyN0pGMDBrbERFT0p2RGs2bG83czBFU1BsZUl2b3NYSXY4dWE4cHpDUVhX?=
 =?utf-8?B?VzkraXNYSTRDc3laTUxzd2VTeHRSQnZXbjNMNzNtVFhRZmorRFAzQld6Ujdr?=
 =?utf-8?B?dVIrVStGNzdjUnZyQjVJaEkyV2tNVWJid25oRlA2REFmd1ZLb0FrYmlCRVFq?=
 =?utf-8?B?aWo1RFZheUF3VXpwakNHMms0R2tmQi8vdXhmcVJiOVh0dG5WZW1tbUxubk9I?=
 =?utf-8?B?TTRlRE91eWducHZ0MlJZSGI1ZDlxUGl0QXRpZXJ0YndzQTlZZzY2OUphU09S?=
 =?utf-8?B?VDQvM29Cc1RjV1M1eFdzQmppK3JLWXIwdHF3UHZDZUF4UndEajBYSnVPcmF3?=
 =?utf-8?B?MFp0QVV5MzVjWURZKzFBOVh5NGZOZ2t4dUh6V3pOTGZWYTVocFBHZXNmd05x?=
 =?utf-8?B?S0VCei80azBTaGNEL0hZbVlIVVJ6TTlqeCszTFdPMEY1OWdBRnpHWnRCVkhD?=
 =?utf-8?B?K3k2QU1RSnp3ditubnJENzNManBhSHJVNno0b003U3JoK0Y3clJnYW16dXJv?=
 =?utf-8?B?VWczR242UlNCWVM2R1A1ZmNYYVE1NzkrRW1jQWZ0Tks0MWlCcFpXTWFkTVdt?=
 =?utf-8?B?K2JMLzdOTDZQdnZyVnhqK1JrSWQ1TElON2xTbE40S2pBOGhEZDZUL2cycXlp?=
 =?utf-8?B?L1RPZ3BkdG5ub1lvS3NoWTk3WDhWc29aMUxxOC9PUngxWS9pTkhOL2V0ZlIv?=
 =?utf-8?B?ekJjend3Y0o3S1RaYnJDSWFhMFIxRU5WdHNtbnp5SURyVmRuak0ycDdlbitp?=
 =?utf-8?B?em9PNCtwNHFaNWIyZnNzVGlxMU92RE5JOE5pNkhITG1sR09tMW9ncGZmeG9E?=
 =?utf-8?B?OGlWSXk2NVdkbnh4S0t1Qkk1S0xNV3FnT0lLT0xxUWNEVk5DSGt5UTlDUVo5?=
 =?utf-8?B?RG00VFp4alJIMWFaWmNwUmQ3WnNQSlJ2dGo5Q25qaG0wdjEwbVdPR01lWDhT?=
 =?utf-8?Q?yhOE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5143.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eEJvM0lDT0NFSHlpaEVXUHlMbXo5cU50aDZQV1luSW1OR2RVdmhSMW5rYm5G?=
 =?utf-8?B?TjdQaStmSUxpMzZPZDF5ZXdZQTZjZU1jeTZOeXpGL3JhMFJ6M3JiaFpVaUgy?=
 =?utf-8?B?V1BaM0lJdlRGckVoa0tYRW1OVVo4RzVZMWRENU5POGVMMms2V2RxVEl6NkxP?=
 =?utf-8?B?dDc3UEd6UWFHVEl4MmE0KzQrNzJvQ0pOT0VpcEpkQ3RTMFBRWkNHdTk2QkxS?=
 =?utf-8?B?cFJqQUs3S2E1VkpoVHkwcEhiRjE0QkwwMzVSMWlmTC96djFwVFpoUGZOK3dC?=
 =?utf-8?B?aVdKWVk1cDdlZFBMeS9ZYnBMdlplS1ZXWUdxWDNCdVZzcVFab2ZsUzh1aHJJ?=
 =?utf-8?B?ZCtLRmNlYU15UURsa0g4T0xBVjc4WWpMbit5LzNwbVVUM2pseHcxV2Z6WDBH?=
 =?utf-8?B?aThRbDluZ0oxanNXZVlDUk9neDN0cURPNnVLN01nMGl6ancrZjkyYVhRYUpW?=
 =?utf-8?B?T3c1bGFKcXo2aXhxTmgzN2szYzdlR21XS2tEUk1aWlZJMnNuWFBnQy9hbUZL?=
 =?utf-8?B?VW9Gb3ZLNWVnVzAwcmlibWlrQjE5VDV3RlVlSnEwRXZNT2VsM2ZQWVFxV2Vs?=
 =?utf-8?B?L1BhSHNjUkR0TlRSVUpGcWpoUWZxYXBvZ3hvRks3MDBvb0U1a0I3Q2lHTDFx?=
 =?utf-8?B?S3UxU1JjUEdpaDBJRkdNMnFPWERYL1JKaTMyc0xRVngxcTVTOEZ1cENDcXFS?=
 =?utf-8?B?cHlmZFlqV3lxbXFia3RyWjBjZEZEb1BKTkxhREdwUG9GVHF1eFhnRFNpOWo3?=
 =?utf-8?B?ZEZ0YTFzNXVuKzJmNGtCZXBuYzhxbEoySkJKTENzc1lDWVNIY0J5Z1hZdHhY?=
 =?utf-8?B?TWNmSlFnTVFRbkNjTVR6c3k1U1h1ZGxzbXJya0Q3enlnZnRKeE5sTTQ5VnZC?=
 =?utf-8?B?cTdHVmtqWjBvayswTmJ1OUE4aENDNjQ3VTJUT1BmZks0U3ZEeVc2Zm1RV2M5?=
 =?utf-8?B?UXluSlYzUnZwN1BBZUtpUVR1UlphZDFNWUpHLzd4NFdsU0x0b0hFcFJBR3dJ?=
 =?utf-8?B?SlBYd05oR0xyRm9FRnpPcGpheTdtYjJMM09VdkI5dkRvMzBGR0U5WExtMmgr?=
 =?utf-8?B?dGdXYkxhYWppd0NyQk0yTUZuT3J2RGNPOEM3SmdsazdCUUJRZW9CdXlwVkVS?=
 =?utf-8?B?b3FIV1dzbW9Lcy9zUVpBT2ZndUgrMGdRVzdycjlPT3NFYlY0UkxZcFVPOFJH?=
 =?utf-8?B?UmZENFBDVjhKazZUR0gvdlI4Qmd1L3luZ2s1SVhESTNRdEF5SzR6ai9TTVNv?=
 =?utf-8?B?c0xmd0xia09mSTBWRk5NdWRORi8wdmJQOFJWNlhUZmtRV05RK092RVhFMi9F?=
 =?utf-8?B?VjNzeHUvSTlVMmUzOXh0eEc1MTkwU0ZIdXUwTTQ3N0ZYV0dERkFhOHh6UEJs?=
 =?utf-8?B?anpjQ3Q2QnNUMm50eFVobVcxYXhHOUNJQWdUd3VaM0ZTdUU4NVJhdXNBM3FX?=
 =?utf-8?B?TTJGNjUwb2tTVHM2eUNOU2wrR0FZREl0Z3ZVR014TlovbDZMdUNmNThJOUs3?=
 =?utf-8?B?NnpmaFRqU21aVUFhUFozQktjNjNBaDlubndnaExOdWtwczFsOXRCMEYrMzlN?=
 =?utf-8?B?bFF1RjFudC9GMlYzcU9vWHQyMGdyaDNOcDBiOWdDUHgydVZQb05EenljRXFp?=
 =?utf-8?B?eEliUnlIY0djZklwcVVuZU9xWXA0NmlYUWY5SVFyUUFkellySTcvT3A0aWVC?=
 =?utf-8?B?ZGF4R2ZqWUplaTQ0L1ZGWXB1MFRKZkNWazdTcDh4SDh3WnBwMVE5blYxeWlq?=
 =?utf-8?B?NXNMODc3bCs3NC9XRkdrY2NSRU5NaENRN1lzM2o2eTFuVzU3UFcwVnlQZlJo?=
 =?utf-8?B?Vmd3VnBQSk91cTRnOGJ0ekN1ZVQ1dGREYUI2QkNaODNUOFFxazdIaFdabWQv?=
 =?utf-8?B?NXRvYnc1MUZDYWZQN3h2NjFwUUhnR1BJZ21vTHY4ZjRGdmtCRnR3T1NRcVJR?=
 =?utf-8?B?Nm0zb0xMRURhY2xkcnJRaUxwUENoOUxnSWVUdXNDTys3ZTk5V0VpN1NVMXBz?=
 =?utf-8?B?TUNhNHVLRHAvYmdqcHh6Y1FDbHZRTmRHSElWZGQ2ZmdxZ1RVQnVtRDNWM0Zv?=
 =?utf-8?B?VzI4V3ovUFFvbWVxa1czYlJrdFRKNnBLWFYzSnlnRnJmaW0rWHBnV2dKdWIx?=
 =?utf-8?B?ZmdLaldXdm5PY3R4TkVSUGJVdkFDMUk3RUFtZ2k3VEVoT1JwK2VoVlVCVkli?=
 =?utf-8?B?clI4cThJOTZQSFMrb0JEWjNFWGpSeXlIeVU4eWorNDMrSWN5cWY3WEY5alFJ?=
 =?utf-8?B?ZVVKR1N3TnlMQkREMXF0VXZtczBlc3dWMVBCWGZLRGVBRnVYN3FESzhOdmFO?=
 =?utf-8?B?cEJZS2RiSXA5c0JxYVg4cmF0Mjc2K0xFVUgrU09rQkxjam04RitPUT09?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	sMp+Rdtiw/Vu6gmQhmjzASu0lXS+s1YJkYqZ1gcLyMyTmM/5AB8pmLyv7KIdEFzgOr2RJORVr5FrGs5nh/rIzFKuSwlCDw4x43rAUZIzBlL70dqhvfPC6xKT5GSOU7aHktl4CVv2LkZeA7mlp3WrgDHVFHFn6sYOhm4V4PNIvsNGaV+khkwWbTYgJzYifHoPFJLf7e0L2UMBN+Vmn2VKt0lasuUKBcnDcJnqLluB6/BYuV4cjobBI1Bw0MenMKSKsYWfNzGfwPNqeTS3CJ4MHlocOz76GSA+tLO8PM84XwvWqAghAV3+SFGbkEc4okyI7TcXZEhORJweoXPez1K0puMgL9DevGwLW2sabID7iiFyw1tCLTZLGRy1bomHschLpGwPLFo+PwAcdnXnv5+hTwxGE9gdY1eq9YCGLd3OPURAijkSUSmOJttkcXgaCIGwrkEaH73Ha7kQtwqK9DAOFcMGJJ7RQPnN6OsuCSYTspeqkPwzBZlHnXEtqvzBzxOJ21IT0tWvIRfcovkQCb0SbY+12aSml3nLOBz/akbOX/3OS+A+W+/RIkydYBVzdjbSKIhMyYRVmE4nreAQL1uU0bdxFykPPwPVgYA94XL6zxs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afad7136-cca9-4159-f71d-08de59d88f26
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5143.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2026 17:06:18.4835
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IKvzhCHgXX7BfudH3/0KGoh9AUAcu4x+M7TAO7HdeQPgEe2VzYKZjrzjolQmr6NfLtTVVdaPHVDhhkZmGP9bMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6245
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-22_03,2026-01-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 adultscore=0
 spamscore=0 phishscore=0 mlxscore=0 mlxlogscore=539 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2601150000
 definitions=main-2601220130
X-Proofpoint-ORIG-GUID: grovbUWtg71bLcfoyMRDrpa94Vuv2eRZ
X-Authority-Analysis: v=2.4 cv=IsYTsb/g c=1 sm=1 tr=0 ts=69725914 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=sSgIgaIE00W-MnUd1qgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 cc=ntf awl=host:13644
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIyMDEzMCBTYWx0ZWRfX/r5qp2nUpc6D
 3BrvGiGWV7B0kXt2aN8MnkHoNfD57BSX8h52T/Z6L8ybwljCdXiWnJJeqn2bdkxhH0xb8PelygU
 8MK1svHNh98noD/s5HvGYS50jmQHAAiatXBLsmNUcz4QFcW1a+TUK7Pj/JDWx7WdupIQW6dEY0j
 Pbri8cz+4UUH8rDSAcqu3oPZOcxed3tGcUbfyxfhJsOzp8hBRB7ks0txL/H6LDgiTXY26n61Xpo
 ZIrFTO69yBtqOHgwWbngcJfFrOl6+CwBA0t7ni0+YcoWsRm+7Dq9rgXZSXWCo9PqyBp1jVbW85v
 FS4Vj3JRiJS6fDKwoFIsMERD1AYJTmZSMJBAmSLrIiP/t4xYC/2172S2BM3e9RLhaU4BUXMxG92
 24fhFhC79FDzyLhv6AjqbHFEp60udk6Z39nJ4tjDlt+iKpvvzkhBEsNVwB6CUKaqyq08y/lykm7
 ljZUB3tA7Q6/JbHd8wHCi298Ngj0Z05LXcgaASiY=
X-Proofpoint-GUID: grovbUWtg71bLcfoyMRDrpa94Vuv2eRZ
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.15 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-18320-lists,linux-nfs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,oracle.com:mid,oracle.com:dkim];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[calum.mackay@oracle.com,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 85C3C6C0B7
X-Rspamd-Action: no action

hi Animesh,

On 22/01/2026 11:39 am, Animesh Javali wrote:
> Hi Calum,
> 
> Attaching the patch for the fix and the adjusted FIXME comment.

Thanks very much indeed.

One small note: in future, please send patches in-line, rather than as 
an attachment. I've appended it.

One small note on the comment below, too…


> 
> Description:
> Ganesha returns NFS4ERR_NAMETOOLONG when a single
> pathname component exceeds MAXNAMLEN.
> RFC 5661 allows name-length validation to occur
> before request-size checks, so this behavior is
> RFC-compliant.
> 
> Updated the SEQ6 test to accept both
> NFS4ERR_REQ_TOO_BIG and NFS4ERR_NAMETOOLONG as valid responses.
> 
> 
> Best wishes
> Animesh


> From db10968082baad86f0cc04db95dc064b96ecd911 Mon Sep 17 00:00:00 2001
> From: Animesh Javali <Animesh.Javali@ibm.com>
> Date: Wed, 21 Jan 2026 03:00:33 -0500
> Subject: [PATCH] Allow NAMETOOLONG along with REQ_TOO_BIG in SEQ6
> 
> Ganesha returns NFS4ERR_NAMETOOLONG when a single
> pathname component exceeds MAXNAMLEN.
> RFC 5661 allows name-length validation to occur
> before request-size checks, so this behavior is
> RFC-compliant.
> 
> Update the SEQ6 test to accept both
> NFS4ERR_REQ_TOO_BIG and NFS4ERR_NAMETOOLONG
> as valid responses.
> 
> Signed-off-by: Animesh Javali <Animesh.Javali@ibm.com>
> ---
>  nfs4.1/server41tests/st_sequence.py | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/nfs4.1/server41tests/st_sequence.py b/nfs4.1/server41tests/st_sequence.py
> index 9be1096..6c306b1 100644
> --- a/nfs4.1/server41tests/st_sequence.py
> +++ b/nfs4.1/server41tests/st_sequence.py
> @@ -68,8 +68,8 @@ def testRequestTooBig(t, env):
>      sess1 = c1.create_session(fore_attrs = attrs)
>      # Send a lookup request with a very long filename
>      res = sess1.compound([op.putrootfh(), op.lookup(b"12345"*100)])
> -    # FIXME - NAME_TOO_BIG is valid, don't want it to be
> -    check(res, NFS4ERR_REQ_TOO_BIG)
> +    # Accept both REQ_TOO_BIG and NAMETOOLONG errors
> +    check(res, (NFS4ERR_REQ_TOO_BIG, NFS4ERR_NAMETOOLONG))

I suspect that Fred's original intent, with FIXME, was that we want to 
check specifically the REQ_TOO_BIG handling, even though the RFC allows 
the server to check for NAMETOOLONG first.

That probably requires a separate test to be added, which doesn't 
trigger the latter. i.e. it would be good to have a case that tests 
REQ_TOO_BIG handling on ganesha, which the current test doesn't.

If it's OK with you, I'll fixup the comment slightly when I apply your 
patch.

thanks again,

best wishes,
calum.



>  
>  def testTooManyOps(t, env):
>      """Send a request with more ops than the session can handle
> -- 
> 2.47.3
> 


