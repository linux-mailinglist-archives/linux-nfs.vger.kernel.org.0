Return-Path: <linux-nfs+bounces-18078-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F4B0D3901B
	for <lists+linux-nfs@lfdr.de>; Sat, 17 Jan 2026 18:34:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BF7E03019E0B
	for <lists+linux-nfs@lfdr.de>; Sat, 17 Jan 2026 17:34:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA6502505B2;
	Sat, 17 Jan 2026 17:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="I5pbK+vl";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="RjVpSza8"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22CD72459CF
	for <linux-nfs@vger.kernel.org>; Sat, 17 Jan 2026 17:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768671250; cv=fail; b=M4V7cTikFg+JSH+oufIy8DBB8Gc3dmUX+xtrW2D4ddtF40Knjhfq2NHvk7XNA9Od81dorciKSHGNZNXAxRl1PsYBZ5j7l9iSWQ6TcCvfJ12hT6aXULZHj5xhP4VvQbHQ5hTpu7rMo3HUElGMZQS1vJjsqX4lgxrVVMYLvWqdhr4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768671250; c=relaxed/simple;
	bh=p2P1ZJYH+FOOO1rcZsKVH/tTvzzTHyICgniiR7WDsW4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=N8/yc6wOIcKoTS6ZVtZ2z4AjF48aRjNjyNgykCpBlhZ5kexDSXTO77RPjLDWJgSUNNzCt6lW4YPXNlvwJ2JIaEIAfW2cyPbdtDegcBUG4YQsFAzp2BLuZIvT8yyXvOyo3N7FZauFBAOZITTsmDT2ve9TYfr9oLZ6LRlc8cTOmJg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=I5pbK+vl; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=RjVpSza8; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60HHUaZk1534778;
	Sat, 17 Jan 2026 17:34:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=e5x/n9xVe7kMHJLctVZr8C5JuI0JnfuvAbAIwnftpgA=; b=
	I5pbK+vl+WqbJyZI3dNmwBKEky91m8MTO/ehzMjFISJmI8qIQRbFQm/ERJTHnbbL
	y8ZiJbhCALHaqHIW7hkGUO5C402dhvuhxERQ3Q/TE6rqo0xSq/pipeWrE/SYLIfY
	CF+zckyM72rsigBCgaMk12KPgB/8DfhXaJycCFn1a+/sT4/lZbz9w1BOrYcSYq38
	N85LQF9xK4eMtVxN1aX9rVEWngjsmP9lpuVE57/ndRYSKGR/N/XVd2MWi3pbdvF0
	0Ifvc4/hQ2NhpquBvZlS7Z+oyFgXK91GqNTSQlFch5Q2aqRoM5C3OeT1pIvz56Ub
	oJL8pne61II9zUr/uAOLLA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4br1b88e63-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 17 Jan 2026 17:34:03 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60HF1w2J008420;
	Sat, 17 Jan 2026 17:34:02 GMT
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11012058.outbound.protection.outlook.com [52.101.48.58])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4br0v6rhuh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 17 Jan 2026 17:34:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NnNj4S8rsvqzo88tA0c9EXD5etBiK4+J70/1eOBE4aFNnC7rWN3CeqZCQgtYeF09CMw8OA162j/LimFiZlXl7YtNwQhz9wMwLR8hGnN0GuUNthSVGkinZVK+YA5WrmH/emsgV5Nb3qjiXAHu9BMgxfxIkOhNR5/5gaewa5Bc1HUQtJhDwqhqJ1mwBhv3XMhGvPf/YSoVs98eK7AKDKTot+hOyQwKKTY4tGDgegRorvB6WZ9XQxYkt0Odv6DlWJXJ6d6fkw1qYxNgTV/Kj+Ux9gyb2zX+jNUHZ4cz2wV6IqjbMIjUsO++PnRMPrPGfv1n/2OaBW6VSwhk3cTVSXnj4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e5x/n9xVe7kMHJLctVZr8C5JuI0JnfuvAbAIwnftpgA=;
 b=Xqd8Z9ADgGLKj+XqW2Q0Gr3T0Tp7Cb30Mk0WK5yW7SEc+IOjGPOWt7kL8w+P/VVw/Dbb4EKAZhKQbHLjVn6C86jEK/TcdN7zy4us6hMbPhW1dtZg0ET467GxP0iIKRCKb6ZSUE/9HoRm8VCjgQ6OUDtfUbwLKL1oHMWCTdDBrelGg+LY8bepdZTmIhYD/h3dq5ATjQ59hY4fJWH3xk2CJTbIiAmQLxjuSuXgprEygf82b4wHKkGQ7RlJaMYz2DH59Z2HUiLME3nsMQhkZBhV3NqS/4JadkeRo0lYk+ugslmBZJV6I+MGxLRXcqpmHNiF3BIxYY58bHkeDPLaT/MyNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e5x/n9xVe7kMHJLctVZr8C5JuI0JnfuvAbAIwnftpgA=;
 b=RjVpSza8tp+gKVIGF1xDud+sm4NuaDhy1Tx7BLTkitDbVGoTfhy65qTum6GzWJo1NDhOgaSy0yzpGpFmQKLFqkrY0cOhlFooAWqvzupiaR7Ctwoq0G2SBjAQWIkGjGLy9G83q5voev2RN8k3RntpWx2MyzkPfdfGhEowSqVNtNc=
Received: from SJ2PR10MB7618.namprd10.prod.outlook.com (2603:10b6:a03:548::11)
 by SJ0PR10MB4416.namprd10.prod.outlook.com (2603:10b6:a03:2ae::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.10; Sat, 17 Jan
 2026 17:34:00 +0000
Received: from SJ2PR10MB7618.namprd10.prod.outlook.com
 ([fe80::480e:bc8c:36c7:493b]) by SJ2PR10MB7618.namprd10.prod.outlook.com
 ([fe80::480e:bc8c:36c7:493b%4]) with mapi id 15.20.9520.006; Sat, 17 Jan 2026
 17:34:00 +0000
Message-ID: <25b3e4a2-700c-40ee-9b7c-a627e1c42f01@oracle.com>
Date: Sat, 17 Jan 2026 09:33:58 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: Bug in nfsd4_block_get_device_info_scsi in nfsd-testing branch
To: Chuck Lever <cel@kernel.org>
Cc: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
References: <45f16856-b71d-4844-bf11-fc9aa5c2feed@oracle.com>
 <a1442149-fdc2-4f66-b73a-499a2e192960@app.fastmail.com>
 <108fb719-8654-42b8-9e37-275726f4b5d8@oracle.com>
 <08c33c91-abda-42de-8771-e61d48b50cc7@oracle.com>
 <a7493441-cc53-4b99-bb62-9092650d61f2@app.fastmail.com>
Content-Language: en-US
From: Dai Ngo <dai.ngo@oracle.com>
In-Reply-To: <a7493441-cc53-4b99-bb62-9092650d61f2@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0151.namprd03.prod.outlook.com
 (2603:10b6:a03:338::6) To SJ2PR10MB7618.namprd10.prod.outlook.com
 (2603:10b6:a03:548::11)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR10MB7618:EE_|SJ0PR10MB4416:EE_
X-MS-Office365-Filtering-Correlation-Id: 7834aa9c-b19f-4af0-d92e-08de55ee9971
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QzIrK2hHMVh6UEh5b2tIendMSTVqRWVQemxKQTA1NHkvQVFDdVBhc0J6K3B0?=
 =?utf-8?B?OUk4ZWFoWE5EVllMSVhtV1JtSkdlSE03cU9mRHJiSER1YWQ5and0R3djTS9x?=
 =?utf-8?B?MVNkYWw0M1FjUDBJUDFvQS8wZGloQzgwdkg2VzBKSVB3Z0UyVERpWjFHd2ly?=
 =?utf-8?B?bnI2UXk4R3lzYkNaSTVocnBDT2FndmlhNnd0U0JQRys3VHUvYndlam13UHYr?=
 =?utf-8?B?SWpiNzk2V24rNTdmZmgwMmV0QlhzWC9mY0xwTTM2aEFqdENEWjkvT2ZJNFBL?=
 =?utf-8?B?UDZDeDBnUlQ4ZHNoblRpM0puak5sYTVwY3BFMmJxNldGY00wdExiN3ZOZDY3?=
 =?utf-8?B?VEhaSTRmbVZCZHh5bUtvWWo4a3hSaEcyeEdXd1hwQk9uZVdad1VhVG5ERGdD?=
 =?utf-8?B?ckQvaUxJbGVBS1RDMnpVVzFEY0JqL3hFT1NCZmNLSHE2dXN2V29DQkY4YWZu?=
 =?utf-8?B?bjREcGI3QkJaRE9KT0NlNFZHbDRXMjRtbzlldW4wbTJYVHllQzBYbjh3dWhM?=
 =?utf-8?B?dWM1R2M2L2N3QWNTRTA4WDFFd2pSQVkvUlB0S2F0QjhmdEgzRHlhZThJTEQ5?=
 =?utf-8?B?c1RDUmxIZnJyTmxoVnhLMkplblNrQ0FUUFErY1BXdXRrc0E4V0hWVFA2NHUv?=
 =?utf-8?B?VmhJa3oyd3lZVUJKZHJRdGdDUGJvSFhFYmZBY3NrU3F6U1RnTlpKTWYvd1Vx?=
 =?utf-8?B?WU8xRU8vVHQwTlVhS01hWlNlM2dtVm01TCtmQlE5U2I0T1FQOUxvR2JsbGJq?=
 =?utf-8?B?TGR4aDI5MmljdWplSXp4blJMQWlKRUZ3QmJJMEptTUlhTm1sYUovK1pHbEh2?=
 =?utf-8?B?NVJnbTRPbzNYVDdmYXVUVEZQNE1FTThZWXQ3M0l4U00xRHBOeUhTa0xNUk5O?=
 =?utf-8?B?VzdWbStSek1LOW9CRnhmZW15NnpRb0pVcUNXV2JDKzZVM0NWT0hoYnZRZXRF?=
 =?utf-8?B?RFBncHlmV3puYnh6OTRxR0paSWdmWitqQjRkSTNBMXV4Z24xL2VLVjZzMlRN?=
 =?utf-8?B?M0QzUVdwVUM0aTFhQVhpMHd3UXhxa1J2RFh3VEYyWVdiNGtQMUZWcXVrUkhG?=
 =?utf-8?B?OTM3TUJSSFlPS090VHJsRm9RdFVSclUxczZoa28vdVJ0MDVZcmNQaGhubnJ2?=
 =?utf-8?B?L3BlQm4yTzZOYkM0Yk9mKzk2bEVvcElPeU9zWTExOEtTdjRleHV3QVNHZTNM?=
 =?utf-8?B?L041TG9mSC9TM0RYRmtmVlBoQWhLZlFONmpwMmFLOG5zd0UyUzRTZmF3K3Rk?=
 =?utf-8?B?ZEQzbGFSRE9jWmRoNWQwN0xLa2xoZW1uejAxNkNzWkpoVCs0TWpZVitnOHpD?=
 =?utf-8?B?a1BsWmdQbFJINjVBb3Nmb3hQbkFLSjZkMnNUWEhoVFFqb0F4UnZSNHJtd3Zr?=
 =?utf-8?B?S2xzbUQ5ajhwT1o2Vis0MTdJUFFyVDQyNVBDZHZMQ3k4WThFamdzQkNHRVQz?=
 =?utf-8?B?alFUNWFydFIxUm5FRGM3Sk56NThpN0J6YmZNd0FOQ2xWTWw4L0NMOC80c0dE?=
 =?utf-8?B?REh6ZjBtTlpyQjgybnEwWGZjNW5sd3Bsai9CVWJCQlZQQUQzc1E2cjVSa1dr?=
 =?utf-8?B?V0Y1M1RVYkwyWEpGTVYyNWg2UVdpTm9NU0p6SWNtaU9pT1pjT3FjNWdIQTNt?=
 =?utf-8?B?d09OWTFGUTJwTUljL1UveGZqUkFkQ1VPdWdhK3VMOHpnR1ZqSXV5VHgrWGtu?=
 =?utf-8?B?WkMrVEN1TXB0dkc4Q3NHOVVRZlhMYTVFbDlNRXk3NEtPdXlRanJCQWlCeDVj?=
 =?utf-8?B?WHMvK3MrUkQ2cnduUWJmNVR2QUlLZzE0TkNqd0I3a3RuUEZyaVF3dmRQTmVJ?=
 =?utf-8?B?OWppOTRpZHNCUXh1QjVUS2dyUjJKK0NZdE14Ny85dXl1OWNieER3K1lIRzBZ?=
 =?utf-8?B?QmpIR0l1VkNqcjN0NTRDdDM0VytZSDlLYmhUdVhhTlJ2N1RmaXpnMk1sdnpn?=
 =?utf-8?B?ZFNuRnBrWWRNZ2xURGpjL2dLUHFXRlIvSXpxWU1DQ1hBdFF4amhIblNqbjAz?=
 =?utf-8?B?bWFNUEpNT2dTamkxOVJOTEF0dFRzRDdQUy94eUhLdXNMbVRneHUrMHM0K1Y5?=
 =?utf-8?B?V0dxNGJzM1p5WDNHb2drL0FMTjNDdGpsNjRiR251TUZ0TGlzZlFEWlZZektq?=
 =?utf-8?Q?vPRE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR10MB7618.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NHp6b3BvMWo3bElMUklGQ3l5VWRRMnUzc0FoV2RMY1p1ZUU4N1RLSHloRHIr?=
 =?utf-8?B?MUZIWDZTMitETWpLWUpKSHBCQzFTYnFJVFdrYUN2UTUwbGlqT05hMnR0cUUx?=
 =?utf-8?B?T3ZsbUswUkZ5YXFuYnJlVFZmcmZyUWgvcVRaWHMvNjFKUWhnSVVBcEt4a0Zo?=
 =?utf-8?B?RG96ZmFkWU1sYmgvYjlTWUtLMGRhZGp4ZmRmTThkMXlmSllsSXpwV00zOG5z?=
 =?utf-8?B?MVhjRjQxTStHWi9ZWXUvc3pRSEZBeG40NTFmbm9ZVXpGQ3lCcWF2c3FIQ3Ax?=
 =?utf-8?B?cE5LK25RVDhmcXhRTndkQXZhdlcwS3l2dEVzVk9FK2NjS003ZnAvRzVpcDRj?=
 =?utf-8?B?dkhGTjN4RXU5ZVVNREJYR2ZGb3RZSFNwWjJ4eUdmcEN6SVdPQSs4eXpGN0pS?=
 =?utf-8?B?ZmxmUzljRktCTGdvbHNWOXlMVE40eTNsQTZ6RzRjL09rdEtKTG1lcEk0b09H?=
 =?utf-8?B?VHo4K25EUnh6Q1ZWempYM1MvMGRDbGNKeWpuZG5HWE5PbllwMXVMbENEZm52?=
 =?utf-8?B?dldIVWdiT2JwR2NYUXdPU2VCcnV4OG12aVVWdDZnZlpLMHk0T21tVjJBQzFZ?=
 =?utf-8?B?N3RrL2JPS01tTUJQdkpiT2FCeitsWmxaamxiQkZQaHhxMVVUSTdTaXQyZFpD?=
 =?utf-8?B?ZkVkVEtOYkNWY3FselZoMUFPZFpFZmEzdEdwejNucnZsOVdtemY2ODNaNkdZ?=
 =?utf-8?B?ZzZVMDhuTEljYzlLNzAvczJJWGlTTUlVUmpqYm05Rk1QNU1jK0IvYWgvaTJJ?=
 =?utf-8?B?QkQvZnYwOGhyRWg5Y0JmVWRPcU0xVWtlTG5tejNZWFhUcmRNTmIrdDFFbmVl?=
 =?utf-8?B?cWR2Y2FVdXYwRnpEaTJCT1BXdENFUk04eVJHMUJUTG9OWDkrMmFhOHI4aFVW?=
 =?utf-8?B?RWk1R2NxRld1UG8yaitqMUxuWXN0WTNWQXhEMVBoVWFuaFN1ditnd2tkSFBI?=
 =?utf-8?B?OHRzKzBsOHFYQ3JHdCtUUk5wUUVwby9DTm9aQXp0anVFdHRvZDY1NURhd1VG?=
 =?utf-8?B?bTFsQzVUT1RjeHh5WVg2SUZvRGUrWStJeXkyUTdHVWdlYTQ2amVlSnIzVkFl?=
 =?utf-8?B?ajA2SGxQUUxzQ2Q3Z2xTWU42WUcrcElaTC85NDN2UitnaVVmVjk3ZjJ3anRu?=
 =?utf-8?B?cDMxN1h2eStMekc0NnFqdTBQWTVNd0RLUXlaTE5xcDJXUnorV2dtTDlXem1B?=
 =?utf-8?B?Tm1kbFVpcjBlKzErcWFzcEdFc0c5TVMrOER1cE51UEJ3YVlhaGE2Q1RWTy9U?=
 =?utf-8?B?VXVJWHJZeDdxNENhNTUxV0ZHa3lrSTFYdHJmR3NaaFpRdFNaUXFWWFVBcURz?=
 =?utf-8?B?S0lOVkhlMFJmWWJHNWJEWTJrVnVEYzVVYzFodGtjNkVEdmU4NktVQVhZYjl5?=
 =?utf-8?B?eDZoTFIvQ0tyclhXdXlXSmlsekZsK2JNbUMzRjR3Unl6ZUMwQ2ZPUm5lTFdq?=
 =?utf-8?B?Um45Ym94S2V3MWNSeUZBVDlveVM1eXBGMDIxVy9hc3RZS3JldnlQb2ZGSWs3?=
 =?utf-8?B?Wm4vaTRLVUtNNUhOZEdCTURPR1FBUFNDMHI0eVY4b0J6YkZnYThwRkREYVd5?=
 =?utf-8?B?YkJaSHdFVUY3TkxzRE5MNFIzQmcxS29PaHljV1crNVZVeTM0MDdvOWdJY205?=
 =?utf-8?B?YlpXMXp5anR2bkozaVR2elN2dUdDL1Y0MGxTRkRZSHBtSE1tK1U5VTR1RmZC?=
 =?utf-8?B?MjBaelRFdm04eXRIdjgzTFR1S0VmOXlUbHNIN1c0aHpDbzFVUjB1azhrelZy?=
 =?utf-8?B?Y3BLQjNra0NTb2hLaURZeVZjbG5GdEFrVUl1Yy93ZTdSRk1oTUhOYTNINWJ5?=
 =?utf-8?B?N0dzU1JNazU2Nlo1TFpnRmREaWZDVFJnc1pwMnNRUlVTSFVuUFk1WWRHZ1VD?=
 =?utf-8?B?TkY4NGEzbUxJVCtCYllqSEROanFjb3E5Q1dpWi9ZbGJCZXN3aUpYSmhGek4x?=
 =?utf-8?B?cWJBd0U2NFhYbko4ZnV0SWFIZUwrSkU2dTRHMXcwYTVtcE1BNzIvck1JOUdU?=
 =?utf-8?B?bWg2cWh3Q2txYTVIWUNDUGFvNXdXRmVFdkptYXdhMXJITHJFbnNodmFNdkRa?=
 =?utf-8?B?ZjltUWdRZDFqZEFlc2xYM05URm8zcXFKQWkrWXBLNzJiMEpRVEIrT3h6S0NT?=
 =?utf-8?B?bDlsRUFjcktMUlFSTU9sbjRVQlpaQi9xL2NMN0J5SVh1WkNBS25vT0hoREsz?=
 =?utf-8?B?Q1RlWTZFWkRTcUJ6VFVrTWIyOEZ0eFBpUDB4cmMvZG5FNW5iUUhCbTZwYXBp?=
 =?utf-8?B?U3krYzFUaXhzMEdlVXJzajdPY3RPMytLRWRxQnZuV011NGY2aTNkejFhN0wv?=
 =?utf-8?B?QkZHMWhzSE1MN2Y2TGJNSzZTS21EcDFjUzFyaThkdW9mclNTUkVhZz09?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	6jmdP0Hjh5C/8f7o0/uPgHjJPIlGUJunSN2OHl43HSzIaRaWanNlSZwZPB452i52uFmwdQxeLOc8T683myCqM8jBOu5SdkIeuiD3W3/nlfT7R/fmVvsENIK4nGhf0DhWwpI4cvQUxtkNrrsRIhl2L3z3nYrhEmsZFCUGpoA4V+mk1+eUx01Skk7WmSO7eVCp6PoTei7tFU7pWBNZ7IWCgk8Mk/PkE1SzLHHP7vockQ4Yx37x8yBXeefv1r4KIph5XimjSiqY4vN4hY5xr6PUDTQGq9gCdJMoI762HdaJVPzK67AJRcAK3XmVrlORhZ+Kd0mm0yifldC7SreJLtr+Ec60oX7rPoV0Owhm/yo1ckspTRLPeH0yoiAbntNeVskGWGr5w54mvd8mGhlQJIL+OCkualqHVPUfOZwx/Rq6i4BsvITPIb7MesVaa6U5tGkOlUPXniTT1bg9u7WNuXBTjmw9yTKHPda90nzQCm7XwXz4chperY3sj9TRduUlOVoC4jKvC1j8HjXFzFjRMBVJ31WkBQCaNMOpzfaER90Iq0obOpYAGkXuDBpJTbxp2Rzu9P236z9ILoC4TF3WzN1b5W6E0zVg3HejT6ic/8dMOFw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7834aa9c-b19f-4af0-d92e-08de55ee9971
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR10MB7618.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2026 17:33:59.9731
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DjhgunVirL1fNSF9lxWCmvpl0wI/iCSMrNwgU4Dscnk2QmCDGl05quPHzqyefleTaQNEz+OHrjEwUuqUBNPTsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4416
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-17_02,2026-01-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 spamscore=0
 malwarescore=0 bulkscore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2601150000
 definitions=main-2601170146
X-Authority-Analysis: v=2.4 cv=WbcBqkhX c=1 sm=1 tr=0 ts=696bc80b cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=H08s1JHxVBIS2fuimEMA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE3MDE0NiBTYWx0ZWRfX0dxjAF7aOdqQ
 jL5qe7e/BCT0Zm7GxOWuXg3xHYlx0D1a59utM8Grbc8N6pOOj56FUJfAbaTpLsXR3QsBFYUecNo
 GoNPENDWfa02ysZ28uM4zFd9/UpOBF9YjeLvDBFCQamgsFRLhOyBsoHw6BfPYxI9jYBju2MT6R2
 8WzoW55rzJtNl96BMIRGhjpoO6QLRm7heNP0Avot0H9iP6jSFZ6TnJWZrTKCWByoCs1ankXrO+M
 QNYwBA4TLCN4yZ3FWOgxH3B3o4JfyRDD3rjNxJJW/jnqiJuPQHkN0bwC0T6trUzCgPAX0MHy9Xy
 EB1w+aHhB0z7CrvazZidewFEoUbwL+h6oVJHoLK/a3b+NdhAaZr4K3YDTsQi61qMz4wEo+9kz1G
 i+rEwU3pJQcdru8Lw/0l121ClODCk1XI0pMk6tG3U4Rc26qYB8TqslEKBxgjA5TVPNXvNClrdAw
 3vZVoU9uqdixjFYFgxg==
X-Proofpoint-ORIG-GUID: OaEwIcS4tUu4st7mCl8aq1jsxvop3Adj
X-Proofpoint-GUID: OaEwIcS4tUu4st7mCl8aq1jsxvop3Adj


On 1/17/26 8:52 AM, Chuck Lever wrote:
>
> On Sat, Jan 17, 2026, at 2:04 AM, Dai Ngo wrote:
>> On 1/16/26 1:55 PM, Dai Ngo wrote:
>>> On 1/16/26 12:00 PM, Chuck Lever wrote:
>>>> On Fri, Jan 16, 2026, at 12:15 PM, Dai Ngo wrote:
>>>>> After the entry in the xarray was marked with XA_MARK_0, xa_insert
>>>>> will not update the entry when nfsd4_block_get_device_info_scsi is
>>>>> called again leaving the entry with XA_MARK_0.
>> I tested the following fix and it works fine:
>>
>> diff --git a/fs/nfsd/blocklayout.c b/fs/nfsd/blocklayout.c
>> index 60304bca1bb6..18de3e858106 100644
>> --- a/fs/nfsd/blocklayout.c
>> +++ b/fs/nfsd/blocklayout.c
>> @@ -343,14 +343,18 @@ nfsd4_block_get_device_info_scsi(struct super_block *sb,
>>           }
>>
>>           /*
>> -        * Add the device if it does not already exist in the xarray. This
>> +        * Add the device if it does not already exist in the xarray. If an
>> +        * entry already exists for the device, then clear its XA_MARK_0. This
>>            * logic prevents adding more entries to cl_dev_fences than there
>>            * are exported devices on the server. XA_MARK_0 tracks whether the
>>            * device has been fenced.
>>            */
>>           ret = xa_insert(&clp->cl_dev_fences, sb->s_bdev->bd_dev,
>>                           XA_ZERO_ENTRY, GFP_KERNEL);
>> -       if (ret < 0 && ret != -EBUSY)
>> +       if (ret == -EBUSY)
>> +               xa_clear_mark(&clp->cl_dev_fences, sb->s_bdev->bd_dev,
>> +                               XA_MARK_0);
>> +       else if (ret < 0)
>>                   goto out_free_dev;
>>
>>           ret = ops->pr_register(sb->s_bdev, 0, NFSD_MDS_PR_KEY, true);
>>
>> -Dai
> I applied this fix, wrapped it in xa_lock to make the update
> atomic, and pushed to nfsd-testing.

Thank you Chuck!

-Dai

>

