Return-Path: <linux-nfs+bounces-15108-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 319B0BCAC90
	for <lists+linux-nfs@lfdr.de>; Thu, 09 Oct 2025 22:20:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E25704E2245
	for <lists+linux-nfs@lfdr.de>; Thu,  9 Oct 2025 20:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DBFA26CE39;
	Thu,  9 Oct 2025 20:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Il1USMWw";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="fWiFfEd/"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B98D5212549
	for <linux-nfs@vger.kernel.org>; Thu,  9 Oct 2025 20:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760041248; cv=fail; b=IVU1uWAGSTEh7wdQqeYHQrBQCTfng+y3ZWOv31pcjKhT7RSI2p/u+5USoTPdn1GRa+0lQw/2DL7D9AOTbky5PMrbggzzefpvN4wCdB+RkHzZ69xIuyFF3SLWb/el99EBMgqL9AAhrGgsVVGdEvx3OL0uT7R/prH9ygIJ7zMd3x4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760041248; c=relaxed/simple;
	bh=aUlgxahkJBAnx/WDzegyr/wIlwC9caO9STnXmkOx8GE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=V/ZeodD46xYfwEvnFmrMJ+eqxeL0JKBFT5vE7ITlvw/UBXn75TJmGaOBqyntn9JkbUAa7q3XbWDJy69oloJCZhfq8HcVngyBalXG2F5hifLNrtVtZKI3H+qCYghTl3MUQ0Dm8w5O9ZdFVvrFkbfvX5lSoMoNKPR2Ab5BHyrhhYo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Il1USMWw; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=fWiFfEd/; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 599J0oqp023251;
	Thu, 9 Oct 2025 20:20:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=hFnMbONTDQ+Z9WcrGOUUeikPeHkkgx6cnuWiTuZRk1Q=; b=
	Il1USMWwAnU0Wr544X7GvkEVP7BHykBqkyySGlrP1pzW+14ri0Iq5E6KnHfB7OOV
	ISa8gBkzJTxVTrG2iUATpbXwG+camlz49nStPfhgv53/A2t6vsxIt9LEn37L0OEA
	VZH3GJ/okTIKzxuPW2gW4bAtWOxuMBynl119uNq11uDBGNxK0pVJrNezPkQShax/
	Iirp1PzZuEc/I5ws+aLURRuqYWr1glxRNQ+UcaflhwN+ltGFyMgQUA/72kfN8Tlt
	fbeIq5fFipBNwaUza7UXTdtobnmoIx59o1v1Vj3K7AD2sQYE5fUuEqbAv/QhBERF
	l+8scZKS8aVTX2YzqFgeZQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49nv6dte0a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 09 Oct 2025 20:20:36 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 599JeRhc014414;
	Thu, 9 Oct 2025 20:20:36 GMT
Received: from ph8pr06cu001.outbound.protection.outlook.com (mail-westus3azon11012000.outbound.protection.outlook.com [40.107.209.0])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 49nv67w83e-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 09 Oct 2025 20:20:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sBBeo+N4ncFuFKXxK4lpCpC3/24W/24vjg0a8guHFDdHqr4PNyX8XqzIR8oHr4tZp7BGAVkI+Ekni+/pwa5eUMJ9uecgIt7pxz4VSWnAYd98aqL/CBVa9D5Ml4KWa/QU2KGZDIGtHh+xBEn6LQjtsrGmhCKZl97CjScnFkDfjpYP5k6pp8is9dMdokaaQvd3hodCN4ZhUdvtgsptsWZY5xhFyUXk61B/rucI+SJVrLq5CyXDgHta1FmOsVjMikyaXWUBQUXs7UvWp3AUUpxarbu1nscSlC3CseuCGCpISbH8aE1e487TdXRsZn04MiLF9IIUd/c8b9mgalot64OfUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hFnMbONTDQ+Z9WcrGOUUeikPeHkkgx6cnuWiTuZRk1Q=;
 b=uBXM0f6tHtOV96Ygi8eT2DRd8mQaf9I4szU+0mIdye1R2KJtmwWT2tN39ST67geoL0GPstaPcRSmXaGIN4E2Zsv8xEfWfJXOAuqwcaFimLSvuK2P0BNTXcuzXravdNHgzaafodmMQi+ozc6g1qIpUUmG1zLQaB6L4ek6+AnhgDwo15XAedRVU2GII2FquBRSwRg6JTDOv7ozFOn0qjHtK5FUO512iD9OQUn5EqMZw7TyGo7ULpDwmgpVQtbPWahmiFsyXc77Tmij26kQEUvg2pqBFMt6JuU4XjqiROkiuSLMtDjMvqS+4m1ehuZiut0c0vLH2zG3VBeVxps4sC9IVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hFnMbONTDQ+Z9WcrGOUUeikPeHkkgx6cnuWiTuZRk1Q=;
 b=fWiFfEd/EnzQNRFGrxsBBq15FAczcmmFVXIrw4n8hPG00/3sAi0KNtburBUAuKndVH8CxKuuFJ8A+z3BgwF1L5TfXn6enwXhLj2hzTTytsZ4sF7/hhKG0vOySbZtPwpuOkNOOH9ih02VqdAzoig2wv3KtnHuKfCLVdMASaNnduM=
Received: from SJ2PR10MB7618.namprd10.prod.outlook.com (2603:10b6:a03:548::11)
 by CO1PR10MB4596.namprd10.prod.outlook.com (2603:10b6:303:6f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.9; Thu, 9 Oct
 2025 20:20:32 +0000
Received: from SJ2PR10MB7618.namprd10.prod.outlook.com
 ([fe80::480e:bc8c:36c7:493b]) by SJ2PR10MB7618.namprd10.prod.outlook.com
 ([fe80::480e:bc8c:36c7:493b%7]) with mapi id 15.20.9182.017; Thu, 9 Oct 2025
 20:20:32 +0000
Message-ID: <2ae4be6e-50ce-496f-8b5d-63b131745848@oracle.com>
Date: Thu, 9 Oct 2025 13:20:30 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] NFSD: Fix SCSI reservation conflict causing pNFS
 client to revert I/O to MDS
To: Benjamin Coddington <bcodding@redhat.com>
Cc: chuck.lever@oracle.com, jlayton@kernel.org, neilb@suse.de,
        okorniev@redhat.com, tom@talpey.com, hch@infradead.org,
        linux-nfs@vger.kernel.org
References: <1759249728-29182-1-git-send-email-dai.ngo@oracle.com>
 <475D1227-CB10-461D-9EC1-A303B74A701E@redhat.com>
 <ddcea773-3d9a-47d0-b857-087655b2ec13@oracle.com>
 <AFF0E6AD-F593-4CCE-89E3-AA72E1650D99@redhat.com>
 <c0dced8a-29d1-4b5c-9fe6-47d065aa7255@oracle.com>
 <ddb63ff3-80cc-40b1-8e8e-f61575e85828@oracle.com>
 <B3F0921A-C9FE-462E-B3E2-D8D0E6B3521E@redhat.com>
 <2cbf10c7-d434-4490-9e1a-8455e004d595@oracle.com>
 <C3EE031E-F587-41B1-8ECA-A29B56AA6764@redhat.com>
Content-Language: en-US
From: Dai Ngo <dai.ngo@oracle.com>
In-Reply-To: <C3EE031E-F587-41B1-8ECA-A29B56AA6764@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0296.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::31) To SJ2PR10MB7618.namprd10.prod.outlook.com
 (2603:10b6:a03:548::11)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR10MB7618:EE_|CO1PR10MB4596:EE_
X-MS-Office365-Filtering-Correlation-Id: f2a2f614-1232-4299-3701-08de07714be1
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?azZibDRxT1EwZ0t5U3BMNkRnZmhIZE5CeU4rNWJzdytUR2R2YzArcHpBZ2FC?=
 =?utf-8?B?SmhxUm1yeDJqUEJqV3lnekUza3l2cldMWlMwOVJ1bWxvNzB6WlJJdlJmT3lq?=
 =?utf-8?B?Q2ZNZnJkUFNUU1VkU3pHNjk4WnVXdW9mS0dTdXZVSE12QXlHbEN2UW1Icy84?=
 =?utf-8?B?dHl4bExubVVOWTdNcmVsa2xyUktoSlRyeDJ3TnNZL0lPdER3STNuOS9iSStO?=
 =?utf-8?B?RHNyMTRBU0RzRStNWTlBaEVjMy9SWkZoaEZMdnpnRkg0TDgyREVNeXFuamFX?=
 =?utf-8?B?OTVWZXNCb2hxUnBkUERtWDIvRElPZGVSNkFPamZEY0xQcENzejNSbW16Vjlh?=
 =?utf-8?B?UHQ5emhySUs2Rm54QjlxRCtMTWp2RTRXQkJ0R00yTTFkQ04wekZTb25GT2VI?=
 =?utf-8?B?RGliaTVMV0wwcVh5REpsSE44UkR3TWhUc0E3cnpHOFJkS3VZdjVnWEFDQjN1?=
 =?utf-8?B?QkpyOUU5RC9RbjltbXllYkhrRmdpcE9HZTBQdUVsOGdVNitiU3BxMm1zMldx?=
 =?utf-8?B?dnJHL1JzZFNXNVhYR1dWRDlUK3k1Ri80WWkwd21tVDk0ckEweWpFQWNaZFNx?=
 =?utf-8?B?aENnY3A3cHhRM3hSSWZQVVc4Nis5aXhOUVBxSjZMWlAvM3k1cDN5VVNwbGhW?=
 =?utf-8?B?Rm9MMmFTSXdnby9LOVhOR2ZucGRpeDE1QlRMdlh3WXZGazZTOUpzRjBJSTlC?=
 =?utf-8?B?NWlhM1dscnh1aVVERzk2S0Q0M2ZUN2RWQ3gyNGxxaVV4OVVOanhKb09PY3Bl?=
 =?utf-8?B?UnFBcE1TYitGVVkzYTB6T1dYVFh2TkFqNEJ4YmZ6VmJraHlzT1lVR2xWRzhN?=
 =?utf-8?B?YUl6dC9iTXE4REVtRllBL25QeVd5YW1qSU5zTW8wSjJmZ2UyUkd6ajZUSDl0?=
 =?utf-8?B?MDIrOEFzVEs5U3V6emZKRmRTeHZhU081bHVhbVFQejN2QlRWME9OdXA0ZlBu?=
 =?utf-8?B?N3lRZmtkSjZVNEtWcVZuSFhCNXdIVXI5YlU3TUxLMVBmWXJ2a09hSXJWeEFj?=
 =?utf-8?B?aThZZzdUM3Rod1ZZMndlR2dpMmloSUhVUFMrRE1LRllDSDdMZGlPSHFFN2pL?=
 =?utf-8?B?Q2V5cmVhcXNnL2l0OWhONnFZdUlwSzZnbGV6L2h5YVFpaDRwWitWeWdDVGU3?=
 =?utf-8?B?UUVLbVBZWml1d3lIWlBJekZzR2gvdGNEbGhXdm5UNnJZQXpqWHhTRlYwUzJ0?=
 =?utf-8?B?dWNpRjk4WWphU29SYTh3SXJrbGpYbUx5dERFKzg1S0tnUGNxUDRDbFJJQVYz?=
 =?utf-8?B?cUhMY1ZCd0ljWFIzclNNczZCWnpMbjA4Z0hTVmxHbDVtdTdMVWNmRXNBY2JM?=
 =?utf-8?B?L1pHcXRmUnZITit3ZUdKMDBWN2oyTFlQRzU4OXVmcS9ueUJML3VLOHhkVElR?=
 =?utf-8?B?T0VIY3MvcDZLQ3F2MWFoTWI5NVR5YlY5WGhzMytFRTc4c2tocTBYS2xVMnhq?=
 =?utf-8?B?bHBzV0ZQQWthZTlKVVZacDA5Zlllc2Zvc0lTUW91VmJWT1d4aVZzL0VhbFRB?=
 =?utf-8?B?cnVOUkJDMXA0NkFMcXdpTDZ4Vzd1OXVDNHFlRkd6SHJndko4UTR1b1BwaTJq?=
 =?utf-8?B?VDFXKzU3Y1J1NDRCSWR4TmpXT1Q1Wi9oYTcwVUZCYTlSRTBHUmJLS2hlTjVT?=
 =?utf-8?B?d3p0S1FPUzNQMUUzZU56UjRBUXZOcDZRdms1ejZ6cFVSczM0REpPU2JGWFZP?=
 =?utf-8?B?MS9YQk1KSGFqNXVnb1NwbTRRWnY3N1F4Z0xPYmlpaHpvMWQ5RHpJR3BZWTJm?=
 =?utf-8?B?OGkvTEt1UDhscTdBcGg4ZC9jamloeE5yUDlTZlMzWW9JZTkrUktHVnJaL202?=
 =?utf-8?B?bWxVNXB4aSs0dERaWEFqVWtHZ0NkcUYzU0tNOGVjeFI4WWE5YUdMazBpZGdL?=
 =?utf-8?B?WHF5RXRsV2hMRi8xdXdmQ3hnWXQzQ0N1TlZYOW9xWHlMc09LelZNelFrN0Fo?=
 =?utf-8?B?SDl0NzltditpSll0OC9KS2t1TlBjWjN1Mk1pWnZrOGpWMjRVcU16QnUxK2hE?=
 =?utf-8?B?cDU4TjhFNTF3PT0=?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR10MB7618.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?QnVPVWVsREh5K3hRb3JMd2xnYzBXUmk5UzlVOHFwOVNzcndXb0VGc051MjVj?=
 =?utf-8?B?R2F0NnlsLzdJTEV2T21VbVVnR0oxR2JhaFUrdGlaend3NFg5MktSdkRLUW5r?=
 =?utf-8?B?S2Y2YlNScThBT1hCRzRMczFkZlkwbVNjZTlMZDd2U2dBS1Bla2VvV2hBa2hW?=
 =?utf-8?B?ZllLSGFDR1JoWjRSVUhQOUZza2ZNbnRueWlBbEUxdE5OQXR4YnBkNGVQK1Bl?=
 =?utf-8?B?NndqVk9sMnBrSFhYa3dEZmlEamwvSklSZ0F5TitZRXV3cjE3RlBlQkdud1ZV?=
 =?utf-8?B?WGRFUVVnZVZqTU5ZYUVRUytPdzl0ZWxINVRKWURMYk9ScEd5WW9UYlJ5ditn?=
 =?utf-8?B?SWF6dkJHVHU0emNuSzZBRUZaR2xtL2Y3cEE3UTYwZ3AzbmFaTUwxVlY2dzFj?=
 =?utf-8?B?Qmk0dy9ZV2ZidStaMzFGbVNMbzE4ZzZFaUh4SVV4cGU1ODlwUmRldXZpTXBZ?=
 =?utf-8?B?NTY1Tk9QTnZ3amV4cnlQLzFuRkZIdXZYZWhjb3JuRzhvZlpzNGRkL2RmOFF0?=
 =?utf-8?B?K0loTTJEYkFUUDhvbWZqa2hYTlB2NGkwTHBZanJqbFVSM2R4TmZ1R1lPYTBy?=
 =?utf-8?B?aXQyaHd0SVNFZ05BcExOeFROTU9ad3VEWTJkcmVxWFRiZ2JIbFNyYmRmUjcv?=
 =?utf-8?B?ckZMbnZJdjNpb09qOGdHcThYSGJlT0dyVHFsMlVJV0FNVFZja0k5VGFrOUFs?=
 =?utf-8?B?UEtSTm5VOVZVOGJrMGZFYXdBR0k0V2VSbjk0VFhXdlI5RXluNGtLbWRLM1po?=
 =?utf-8?B?bm53YmM2QTQzMmY2QW5hc1YvU2lZNXI5cnQxc3l2TnF0OWp2QkFkdTZ5THNp?=
 =?utf-8?B?ZGt2VW1ib0FSUjNGRlZIOW9SL1dxc05WWDBJK3Z2Uy8zVnlnQXFxN0ovUW15?=
 =?utf-8?B?WENRMnh5clhaWExCM1BnTHdVb24ranFNLzVZZ2JOTzhVNGFxMC92RHlSUFR3?=
 =?utf-8?B?aGwvcTNzV1pYMWJIdWxxL3k2ZDRoOGc5SjhVYW8vM0pTakkwOVdnQmUwaUhB?=
 =?utf-8?B?MjJtakxKc0JWQUNFMkxPS3JUaFlIU2lFYmlNMlk3Q3grUEJxTFJxbEZJdDNx?=
 =?utf-8?B?WnBFa2pZMFI4YnJVcVcwb3BuUDJweHZlRkl3aGF1L1NJYlZFVkZTWGN0R2JR?=
 =?utf-8?B?WFgvRUdDSnZ6Mi9kclFUc1BNbW1UcE9WYTJLSW8yWXBvQ1VYRUtFd0lmWTdD?=
 =?utf-8?B?R2U2TDdneHVnQVdPNnMzdENLYzZhVmgvSnljTldIMWVHNk1LSVRrR1llQzVW?=
 =?utf-8?B?WDV5T2E1alIyVHpFWEIvVHhacmJWUHo4ekQrOGZSaUQyZXhWbEFaSWFsbmFT?=
 =?utf-8?B?bjhwaWc1ejFkWG12MlJMd2xSUEQvNWt6bmJZYlNrUFRhZ3NnN2dpcjNQTEF0?=
 =?utf-8?B?a2l2R1dybWVNS0VWcFFyTVRYMXFteDE5Tmc1dDVGa3RlQVljWG1FL2dlMmdC?=
 =?utf-8?B?NDdNWEZQRHBDblVOaTQ1U3VCZWcxT0tIRmErbEd4bHl0VmNaZkowcWtmME0z?=
 =?utf-8?B?KzRiYVVEbzdnSEg2YlRsM0YwVmFxZnE0VE5TZnMydk5CSlFSWWtvVnU4ZWsy?=
 =?utf-8?B?azI5dkZVblZsNHZaOXZFV3BLOUFCR0l2TWpzRXNSRVhGNmlzdjZrZ3pjSm0z?=
 =?utf-8?B?R296UjMxcTc1bDFRYlB6WUVPd3FEUm1ibElyYXRId3ZGdHQwR3VyQUprUmJR?=
 =?utf-8?B?M3c0TTZybnpVaWNxN3JFbTNNT2t4SEJRNUFnZmh1dFFrQW50ZXN0Vnd1WXUv?=
 =?utf-8?B?bk5TZHMvNFJXUnNwYUc2aXhqc2FtU3laTitUQWxVNVplMW9LV3hlQnZ4TkxP?=
 =?utf-8?B?SG1JZHB3Nk5uU21FZm9NRlhLUVpIRmRtSGRaVGZuZUU2cExvbTFSVEE2WGY0?=
 =?utf-8?B?SVBoQW5WQ1RTcWoxWHlBeWpsaTRSMmJ2THhIUTdjaDE1WUtCSHViTHErdmE4?=
 =?utf-8?B?bDVVWEZGZG9sZXE0L2E2di9ORnI3WjNDczFwV1pjZ0tjRm9oOWF5VGo4ZWhG?=
 =?utf-8?B?bUpKT2dUVkFVbE1YQ1cwZUhQcmoxTTdoclV2Q0FMaSsxd3VPK29rdFRjUkpX?=
 =?utf-8?B?UCsrcEJ3NUJLdjlOTkk2MmxxZm9pVjVPMnFSekdMZHRuSEpKb3VKaHFHNFVC?=
 =?utf-8?Q?2PlDOLk/aO7ExWFBs/wYcWPK5?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Nk6n1qOTING/kM6gQa/crtQM+tePW7KWs5b/8GE6E1D3wEOHsJM6JMlrvAR255+/P28EBXAdU4moVqebZizTe0t7SqYuZe+qmMhTgwJFku67U947VZirejIY6bhzMkj0kzyj4doTPj4wyDDlZtna9AzVKTLdQW4gaGW3IvGKbL7B1UWt94CItbgTBNxbnedauEeJGv9cQtRawV4ypWkRfzl9CzM4UZTlVLlpjtcwyfvQI6RnqP8jGnu3oQpMWT5F+gIbGeUa6f5biQoekaYm1Mf1Ty9Czp+KpL9G2cif/lsG1R6lEEI+dzMPqYFuc9JvbuVVBrtoXwXAxft2XUeR2dlh3cKeCj2f5kNCbDXaf8ZOzKv3X2VtQGWs5B7YKWnvwNG0Qfd1AaFtWaKLxk9FGHyy1yFV6eSQxFjbY+S5EO+7DOPGWzkLBePr3rNUxeMl3gy+o8ecJtGTShtExOVZ9Cp2/U4AmWmyK86QS1JS2G6trDa6WCJNmINwBx1k4bvzscGpOrXbYuoEe/qqyJk6f2nyR6hHO7gxgxRVXHmXp9/FdZWh2/nrD88gVF8i4e7lX9a55Sg+UYJ/1h+jAaG6jwu+COQ2fo3RPWVBcJU7ONY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2a2f614-1232-4299-3701-08de07714be1
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR10MB7618.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2025 20:20:32.1250
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uSRJ6+kLbT+YATaHemYUEuCx6kaLGZDWExFqSXJchKlw52QPomroSkhCWIay0ZALI92XC6uopv778z6XWCOnzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4596
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-09_07,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 malwarescore=0 adultscore=0 phishscore=0 spamscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510020000 definitions=main-2510090124
X-Proofpoint-ORIG-GUID: p875E7nUbIezUGRBr_kmPaA9rA_SsCyb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA4MDEyMSBTYWx0ZWRfX4CJkpFMgixao
 FhI/f5hDUHxdsp/pyMbxh/Ptovas+ygFI6L7so2KD2ocNu11HGK5l8ttVmMHDc2GRVuXlQj2SyM
 JpZUm6kqRsap/1UTaZlk83HUoohhycT8N2K0kcr5l5VSRdx7IqGMd/hEV14O5iMbiq+IflVcrJu
 tT9TVpUaRJoBNZUKjrPPj4yVG/eGtspCCzycQ1WmvTfbtQoW/8SNfHOJn03fELVJOS5GOA2e44/
 h6rQxrNrjvxlFyQCmBvpzoe3mK7LeMR3vHxfOpdLBrVIN7zv29fRc2JT7bht5k+td1xmBhVg7G2
 XihXYNLhFn2gk5uqRhro0161Q/9cV2/aRQPgOOMPlCbLTt5gKCSQX43NFGAOunGKaPJNGP/cl0N
 5QA+vg6XdPngGnQl0PhmMsrXoQo5Ig==
X-Authority-Analysis: v=2.4 cv=etHSD4pX c=1 sm=1 tr=0 ts=68e81915 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=JLDxV_SaAAAA:8 a=cTMn-MkfAAAA:8
 a=20KFwNOVAAAA:8 a=kyINcPqHu3347qWuG0sA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=_uzX4oWg-uDLJ6b6Md12:22 a=07REm91lqynEFC2MfXjm:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: p875E7nUbIezUGRBr_kmPaA9rA_SsCyb

On 10/9/25 12:46 PM, Benjamin Coddington wrote:
> On 9 Oct 2025, at 13:43, Dai Ngo wrote:
>
>> On 10/7/25 1:37 PM, Benjamin Coddington wrote:
>>> On 7 Oct 2025, at 11:59, Dai Ngo wrote:
>>>
>>>> On 10/1/25 10:36 AM, Dai Ngo wrote:
>>>>> On 10/1/25 3:54 AM, Benjamin Coddington wrote:
>>>>>> On 30 Sep 2025, at 17:41, Dai Ngo wrote:
>>>>>>
>>>>>>> Hi Ben,
>>>>>>>
>>>>>>> On 9/30/25 12:15 PM, Benjamin Coddington wrote:
>>>>>>>> Hi Dai,
>>>>>>>>
>>>>>>>> On 30 Sep 2025, at 12:28, Dai Ngo wrote:
>>>>>>>>
>>>>>>>>> When servicing the GETDEVICEINFO call from an NFS client, the NFS server
>>>>>>>>> creates a SCSI persistent reservation on the target device using the
>>>>>>>>> reservation type PR_EXCLUSIVE_ACCESS_REG_ONLY. This setting restricts
>>>>>>>>> device access so that only hosts registered with a reservation key can
>>>>>>>>> perform read or write operations. Any unregistered initiator is completely
>>>>>>>>> blocked, including standard SCSI commands such as READCAPACITY.
>>>>>>>> SBC-4, table 13 shows that READ CAPACITY should be allowed from any I_T
>>>>>>>> nexus, no matter the state of the reservation on the LU.
>>>>>>>>
>>>>>>>> Is it possible that your SCSI implementation might be out of the spec?  Also
>>>>>>>> possible that SBC-4 has been updated, I haven't been following the SCSI
>>>>>>>> specification updates..
>>>>>>>>
>>>>>>>> Ben
>>>>>>> I don't have access to SBC-4 spec, t10.org does not allow guest access
>>>>>>> to their docs. Can you please share the content of table 13 here?
>>>>>> The document's licensing prohibits me from doing this, I'm sorry to report.
>>>>>> I have a single-user copy that prohibits me from copying or transmitting any
>>>>>> part or whole.  Looks like you can get SBC-5 from the ANSI webstore for $60:
>>>>>>
>>>>>> https://urldefense.com/v3/__https://webstore.ansi.org/standards/incits/incits5712025__;!!ACWV5N9M2RV99hQ!N4FtetrpMVBPf88WPTlz6EuwsK0kPhNqw04MXvtXGUwMzzAf0NPkCYhL5HYx32ZZVogW2MKS0Jr8P8M$
>>>>>>
>>>>>> The reason your patch caught my eye was because we'd previously fixed the
>>>>>> same problem in the SCSI LIO target.
>>>>> Thank you Ben, I'll get the spec from the ANSI webstore.
>>>> You're right Ben! The SBC-4 spec says read capacity is allowed in this
>>>> case.
>>>>
>>>> The problem was caused by the DS was running an older version of the
>>>> kernel that did not have your fix:
>>>>
>>>> 28c58f8a0947f scsi: target: Enable READ CAPACITY for PR EARO
>>>>
>>>> This fix did not include the SERVICE_ACTION_IN_16 with Service Action
>>>> READ_CAPACITY. However, the Linux client tries SERVICE_ACTION_IN_16
>>>> three times then switches to READ CAPACITY (0x25).
>>>>
>>>> Thank you for pointing this out.
>>> Would you be willing to test this patch for SERVICE_ACTION_IN_16?
>>>
>>>   From d7fa5d5f593dcfe39b7456dd6f23eb042fb2636f Mon Sep 17 00:00:00 2001
>>> Message-ID: <d7fa5d5f593dcfe39b7456dd6f23eb042fb2636f.1759869410.git.bcodding@redhat.com>
>>> From: Benjamin Coddington <bcodding@redhat.com>
>>> Date: Tue, 7 Oct 2025 16:34:37 -0400
>>> Subject: [PATCH] scsi: target: Fixup two more cases for PR EARO
>>>
>>> Allow READ_CAPACITY_16 and REPORT_REFERALS for SERVICE_ACTION_IN_16
>>> in the SCSI target driver.
>>>
>>> Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
>>> ---
>>>    drivers/target/target_core_pr.c | 7 +++++++
>>>    1 file changed, 7 insertions(+)
>>>
>>> diff --git a/drivers/target/target_core_pr.c b/drivers/target/target_core_pr.c
>>> index 83e172c92238..0b6803754422 100644
>>> --- a/drivers/target/target_core_pr.c
>>> +++ b/drivers/target/target_core_pr.c
>>> @@ -465,6 +465,13 @@ static int core_scsi3_pr_seq_non_holder(struct se_cmd *cmd, u32 pr_reg_type,
>>>                           return -EINVAL;
>>>                   }
>>>                   break;
>>> +       case SERVICE_ACTION_IN_16:
>>> +               switch (cdb[1] & 0x1f) {
>>> +               case SAI_READ_CAPACITY_16:
>>> +               case SAI_REPORT_REFERRALS:
>>> +                       ret = 0;
>>> +               }
>>> +               break;
>>>           case ACCESS_CONTROL_IN:
>>>           case ACCESS_CONTROL_OUT:
>>>           case INQUIRY:
>> The patch worked fine for READ_CAPACITY_16.
>>
>> The REPORT_REFERRALS got a Check Condition with sense code 0x2000
>> (Invalid command Operation code), whether there is a PR or not,
>> because the SCSI target does not support Referrals as reported by
>> 'sg_vpd' command.
>>
>> Thanks for doing this, Ben.
>>
>> -Dai
> Thanks for the test.  I'll send this to the target list, and will add your
> Tested-by unless you'd rather it withheld.

Please feel free to add me as a Tested-by tag.

Thanks,
-Dai


