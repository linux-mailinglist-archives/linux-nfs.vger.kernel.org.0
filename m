Return-Path: <linux-nfs+bounces-13375-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D4DDB1833C
	for <lists+linux-nfs@lfdr.de>; Fri,  1 Aug 2025 16:07:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C64B1C811E1
	for <lists+linux-nfs@lfdr.de>; Fri,  1 Aug 2025 14:07:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3CD138DDB;
	Fri,  1 Aug 2025 14:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OuPUsSAx";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="KELYI7gX"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19BC5266B64
	for <linux-nfs@vger.kernel.org>; Fri,  1 Aug 2025 14:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754057254; cv=fail; b=pUtmUfMi2mtHSEeAczTQmGC2aD2RYvJx0xsNKVf4+buZpieArtmjED0/yttJmU74hlErKDz8DCKyp8TA3mYF7OTYEz5iLmRsYsgaiWbPxGK9bJFQDiHhVvs69vFqkchP2MW/+EokTS+rrLSEq/ekyNRD0RWOgh54TUVw6+sqEz4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754057254; c=relaxed/simple;
	bh=9+TIVWoHilkseBf18uWilynBQF7JDXzpLHFVEUHw2D4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=esv/2HpJK6Nz18VALrXukqKnOzco/12hmf09Pocq0TUS6Ul5VxQziHRyZtSMiM5UR0VFWEWLQhr8F9m6Mp5bVsWHF36b1MBf3SE6Wooq/h7ln9DboGIRHUxjag/KA87imQuIbigAWUPlA9kWouuduS3qZ7vpi2W3UFyKBYY0zY0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=OuPUsSAx; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=KELYI7gX; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 571BKnWT020169;
	Fri, 1 Aug 2025 14:07:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=7RXxErueVRQoTM8MtTqzoC8xMMfjVupktaJy0NmKHjE=; b=
	OuPUsSAxAEgLCAicFxLB+bJ3P+DwjiEC8V8ptRS2/gRVD3317oVF9mG/yf8UlLxZ
	AlqgNW3DDY/1lH7XNcPrxt/ftQ+P2KT1emqL8fqgaiLWTq08oP/LjplVmljJyqPt
	HTO1sdSFzPOXmeLzZhFigJ0+p5fYomOTKpkdvXWZ5X7XZaeY8nQol8ul+lo/8lmQ
	F9HAfGGX/OsaC+Dxp/W1hKhTmdQJ5XHd27TX20JXUP2+XTLRr/WN6iGJ+c1sQF1L
	dKqBvtn66oQEDgsnXPGQ2bHtrXKelWDwc7vysudibxcEwrk8M94T63xiUj5p/625
	R9v70J2ilZk/uRSXe3pm0A==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 484q5x65a3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 01 Aug 2025 14:07:26 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 571DsLFf034533;
	Fri, 1 Aug 2025 14:07:25 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11on2063.outbound.protection.outlook.com [40.107.223.63])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 484nfe2xky-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 01 Aug 2025 14:07:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dqb3rQNKJqt7h8bPcdrLaVY7758BxSXNiEkizgLoB0C2YbnhBuXhcOycTYl9URFVbKMMRYCHoHovA8ZGi4shiEQRJ2j2OX1F7VBqm+JGogDMMdiCKY48hWdJu65B8KoFYBrArK3TPQ4NKGbQ6TgEJ2ZGbdptyUq8Q41nh2QN5IL71WAzWnetrkgU1a1GGC1v08zlYvhHnagUAlH217e2AmuPVRHfnDRA6pdKnHsEl0ViqeIA3dh8PAqMkgiCTEC8/+rVGa1gOyg3M2lXy8W2KROg3giZ4cwIrmaRKEzfIyBPLyqxdZKTOsA4+dI0B2W4/VllWebDbJHK9vTPxJRStg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7RXxErueVRQoTM8MtTqzoC8xMMfjVupktaJy0NmKHjE=;
 b=G6Nh1Ohi68zylkVb/vVW6WUoHQsbtpLNWTXkkJQWHOr0X1q10+IbZPPclvkUmHIq5AVCLdX+Qmi9LpzTmeLDgqHmXkqCZUPdEKPr/Zn7jmVHwf8A/AaCc9aHVptJDk2WdY//azoyg0XfaEdRY4weA61sTPDaA4Qhbjqoj0+xfVR2fk6OylVmNDHUJFjJq1tBxnIXI/I1qxEb6b5cF1zpx/vF7TLaRA/u5GgPcVnp1Y34yHkOu6pL0/c7XGicfDCTCPe6VuOUBwhy07eqauR216lQwjP+PB5teTC2iWya9TEGkUX52DtWt0vsq0YlCt2b8845VDH6/C1sZr9b7owLsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7RXxErueVRQoTM8MtTqzoC8xMMfjVupktaJy0NmKHjE=;
 b=KELYI7gX4woGKc+tUG0ZmGZYVHlrBpLhwthEP6BbM6U+sMjKZtsrW7T10HwwEO/m1FUp97OBzPOetBwJKZ8JIVfQT9tw8JoliNRh58hOksc9rNqWorWYlTjz9KFYlPtuUWPApmfvPkJm85GNQFzvmTQLM2kdOq7kVGRmo8d6OKs=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by IA4PR10MB8493.namprd10.prod.outlook.com (2603:10b6:208:55e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.23; Fri, 1 Aug
 2025 14:07:17 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.8989.015; Fri, 1 Aug 2025
 14:07:17 +0000
Message-ID: <f430725a-600c-44da-8062-1b45b17537ce@oracle.com>
Date: Fri, 1 Aug 2025 10:07:15 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] NFSD: handle unaligned DIO for NFS reexport
To: Mike Snitzer <snitzer@kernel.org>, Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org, hch@lst.de
References: <20250731194448.88816-1-snitzer@kernel.org>
 <20250731194448.88816-5-snitzer@kernel.org>
 <b5e2e433e70189b4ed05417f8bdb2ff98a82881e.camel@kernel.org>
 <aIvf7VqSeNE3Ma1m@kernel.org> <aIvkm_O4ff3vIKAM@kernel.org>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <aIvkm_O4ff3vIKAM@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR05CA0024.namprd05.prod.outlook.com (2603:10b6:610::37)
 To BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|IA4PR10MB8493:EE_
X-MS-Office365-Filtering-Correlation-Id: 44200820-7eba-48b5-e700-08ddd104b925
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?NTF3ajE3M3JOQTVJYzQyckFkNGF6YkJubG9DOFV5MHFRTUJqSmhJeDRyM3Bj?=
 =?utf-8?B?TlIzRnM4cWFSeEVoQ3RLL1NXSkxkWEd2bWlBMWx0N0ZEWkZDWGJpR1hxY3dq?=
 =?utf-8?B?YktuQ0liaE92ZGxVVEd5NFJYdTdYVDVrcEZhbUEzUjY0ZlF6bUk0OGc4OGVQ?=
 =?utf-8?B?NEUrR2pqU1BUWmM2V1pTT0syMzBGVC9DOUMvb1F5U3plSFpsaCt0VlQ2ajVZ?=
 =?utf-8?B?alBscUU3NEN1Z2syRDc1WUp5UktVajI5a1d5RnNYcFVtOUlpUmU3L0VhNy9Y?=
 =?utf-8?B?elVQNENnNDFmdmRkS2QvUTdLY2dtR3NERFZ5MVdhemFoYktYTzA1cXpUckJY?=
 =?utf-8?B?RWxTNEJ1TllnQUZjcklPU3MyWExzSXpoN01pMGV1dXhTUEIvUzBaTExYZWxp?=
 =?utf-8?B?Z1FnbjlIcW54ZUJvS3hIRUx3TlhtSkhzd0lDVkRWSGlDdTBMVEphUUw2UGc4?=
 =?utf-8?B?OTRhNGFXbnJkYXAwcWFIa05BSFZ6eEtrZndwNUozOENKSEFSQjRpVTJvbjJ4?=
 =?utf-8?B?NWdUV21HdDFhZTdEMXNpM3Nlcy9rbFZuRXVBMk9pOHgyS2hleUdiNUM1SkF5?=
 =?utf-8?B?enVUaDAyYWhxYmYrVWszSEd4VFZoV3c1Mno2dlY5MzBMVnZldU1QZnJNbWdP?=
 =?utf-8?B?eUthUldaTEpzRFNQMzdrOS9tUlBKQ1U0MU1GS1NPa25NK2ZGZEpOOHZEbjRZ?=
 =?utf-8?B?N09NWlNMVEt4VzNyVzdUSFBwZkZsbk1NK0lPZjRIYU5LdzIvbDIzTmRVNG45?=
 =?utf-8?B?bzVmaFVKdENWTUNJcU9zcjJqSWlSNy9HTGJVL1RnRUlLaTZ2aUJjNFA5QUZF?=
 =?utf-8?B?SjdIK0tub24wZmlyaU03WkFZWGdJb2tPdGxCUnhzdE9xdVpvNCtHM1gxUk9X?=
 =?utf-8?B?WHlrcTdac2hUU3M2SzZFa3ZvWUQ1SUREVEtqWkNHSnpvV0FRdElmTTZHTVhn?=
 =?utf-8?B?NkFqVUJLZ2ZJeVREYkRlWTcvYXBXMDBnYjlXQVg4UjJhcXhKV0hjRUtjVmZK?=
 =?utf-8?B?c01pa3VwWGVYMGxSR1RBZjQxNXZCZ0VEN0RSSVlldFVyVTlVbVE3QjJzK0Zv?=
 =?utf-8?B?bkhVTFR6RXJsZ3VOUW1HdzREcFY2Vm0wMVJTK3NWRDhRZXNpa1M1K1FtRGpU?=
 =?utf-8?B?dlNDMTRLSzRoTTJHWTRJTGFYNUoyaUxybWJ0V0p0aTUva3Nhejkyc3R3TjNr?=
 =?utf-8?B?bGpFU1lzVGdkbFZScTYwWlJCSW9KOWgwOVpQbG5pYXhUbWtRNnlONElGeUxN?=
 =?utf-8?B?cGV1N2pYUElSZHg3czlIVkROaGp6dVlRWi9NeHlWeGpDSHVWSFNiN0xGTUZk?=
 =?utf-8?B?a0kxNzhGU0EzaUdSWWtCTGMxOEt1eXMySFJ3QUNwUzZ2Zm1XOGtRb1QzWDIv?=
 =?utf-8?B?V0doWmRGdk5ZZmpKR3E5aGN5dlZma2toSWpZUmtsc0NScERqWGJ6YnVMZGgx?=
 =?utf-8?B?SnRCbE14TTFqOWgyODdyUjk0Q3Irb1lBdEx1eWVWL3BNNWZFSGkvb1Q2NmlF?=
 =?utf-8?B?MzJHMXU5SnQ0MnZXdTJaQml4dkxna1NlaXM2eW9OUWF3V2Z0SEdnZlZhazI1?=
 =?utf-8?B?U2lpSGwzMWp1M0NZRm1LNERKb2ZCbjJoMFgveUNudUVpaG0xWnNjVlJSZ1Jn?=
 =?utf-8?B?VEhwaVlSWkpRMm85TVB4YXRKWDdHamZBNk42d0RkTzk5WjJMcHA3V3dlSW9D?=
 =?utf-8?B?aXJuczVpdnJ6NFpYRlM4cHF3bkh2M2xiRllma0R3MmZ6OE55bmNpbnQ1WVgv?=
 =?utf-8?B?T0REZnJUTVhRQ0F2OWRySW1CcUl2ZGozdjJmd2t6V1BkSWt2M1NZUVVpclRq?=
 =?utf-8?B?TVNwbTMycjJ1ZG1Hd2U3WXlVRFE4Mm1FVFJaMkJHSmFOVXl6d3BrRU1OTUdV?=
 =?utf-8?B?VmJQNXN5NStaRDFwaTkyT2hoSEphZktaa1lHYk5GeXpwK0IxTzArU1VMd09V?=
 =?utf-8?Q?CtFWamO7Edc=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?SmIvSHVWK2d5Z3FXMTY0VHJwd3ZTd1lsb0t5VTQ2SU9mdU55a0l2a1poU0hT?=
 =?utf-8?B?VFE3QVdhbnpxYW5Vd2xpRmNKUVpLdkkyditnTGpiZHpIOGNzWTBYbGZPS210?=
 =?utf-8?B?MGQ1dGdLcTF1OHFzdjZ0c0pvakZwaUZTOXdRK2lRNmI4RUgvVDlwN1FBQ0pj?=
 =?utf-8?B?Y3IrenpLUTNreHNFS2xoU3l5ZWFHUnBxb1l1MEZRNEtyRlFXMXFkZkFsWmpJ?=
 =?utf-8?B?N2pmaHFBVmFnRm5GTm9XZVAxM1VTVzEyWGs5VjVOMDNKTm5uak9kSVNBbTRq?=
 =?utf-8?B?KzIwbTNFbG5sZ3hsUU4wTXh4TW5TaGZNQ0hwM1g1RjZsWkVHZWFmMEJQeVdV?=
 =?utf-8?B?SGU0VHhyUkxuQVh6RThaMHdrWjltSkZIZzdxSjJLeWtCc1pMdlNRaTBEdnBk?=
 =?utf-8?B?TmlXeUR3cWVzcENjZmEyS0Z2UzVpdGUvR1pEZ0VleHlwN0ZlWnNLOUdRUkdD?=
 =?utf-8?B?dXFodXhaMnNTVG5uR2pOZnlwWCtVM2xxRE5DVjRiSTgvV2RiNUo4eW9sNTlY?=
 =?utf-8?B?VlhWU0dVTnF6UEtxazdkWGRiRmdmL0Zpc2Nsb1l1eG90aWdYWHZOT2FFcVJr?=
 =?utf-8?B?Q1VCY09Gd1hBWnE5QXBmU01Bd0JkM2FCYkovdk1GamFpbWxFdzREQUlsTXFH?=
 =?utf-8?B?MEMyVEZjRUw0THVFQ092S0dIMXNFTmNJYmJLZ0EwYTk5S1JNYytTYy9WWUJV?=
 =?utf-8?B?eitpY0xZY3kramw3ZFBxWkowMGZCdHBSWG0yaWlLaVdGZjJ5UG5ZK0pmak80?=
 =?utf-8?B?WGd0bmsybk5iR1d2QXNpdzhBMHBacE0wL1BlWWE0TjY4SERsZXNrZC9MYzlx?=
 =?utf-8?B?dExrN0tseXNQYis5bFgzQ0h0dVFDa0RWNktsQ1RqdGZqbWZuMzhnSjY0V1pS?=
 =?utf-8?B?SzU5TCtENGZ1c21xRDRXcmNvcVZtMUE4bXE0NklWY0R3VElwNy9YdGV3VmhP?=
 =?utf-8?B?cTdaSFpSTW5TRjRCd1FrZit0OTQva2tRR3JZZEkwVDN2Z1dPUFdldFZ1SjBZ?=
 =?utf-8?B?VGNadStyYWtlT2U4a01KQXYxdTVGc0ZXVjI2TTU5WDNKZzRmWm51UkpGWUpW?=
 =?utf-8?B?eTlPT1BZbHhTL0ZzZSt1a1pzOERZZE15R0VCVTlpNUhXa1l6Yk1sK2ViZkUy?=
 =?utf-8?B?bk9JUmJaeWNsZmJaOEs5OUMyMUZtT0psSWZudXhDbjVRR2dWU0ZyZllqSjJq?=
 =?utf-8?B?WXlNZkZ3T0xnUUJRbVpXQXZNQVYzV0lQeTA2WDcybkR0WVJLWExVdC9qdGdq?=
 =?utf-8?B?ZmJvSkhHQTRtWlJKWmpKMXpCMGNtN21LYmJZWXl1SW5yVTZmVkZxR1dyeWNG?=
 =?utf-8?B?WnJsTFNrSUpZOThZZFg1R0oyOThjMWpxUEI5Y1NvT2d1KzFKRm5JZ1AxYnJG?=
 =?utf-8?B?d2hEYmJxRXdxZDJxeHlsbytWWkJZZHhta2ZWTEgzYitpMDl4RzVtYS9SQ25v?=
 =?utf-8?B?NWpENkFnYkZqN1QvODNZSDZJR1BaVHlIWHYvYkxsQ3hJQ1czUm5WMFhZYWlY?=
 =?utf-8?B?anFiemNtVVp6RlpWczhrSXVvbFB5VEg3WVhtUDVMT0diZENLY25hQ2k1K0xs?=
 =?utf-8?B?M053ejVieDFIRjRrZk1Ualk0alBkNkkybENhM2NWOU5kNFppdm5HL2oxZ3dq?=
 =?utf-8?B?SkR5QVExZ3VxNEdMSTk4ZTJwODYyMVZXY0ROMFd6ZEtnNXArak9Jb0xYZWZB?=
 =?utf-8?B?MDgvSHcyK3NyNXpVYTRoVEpjYlZSbVkxNTBJUDlZZHgwL01Udzhab0crdjBa?=
 =?utf-8?B?a2lzZVYvQWhZTzRpT1V0aklIZmhsNzNPOGI0MUlKdWhmTlR6c2FlYkZWdnlG?=
 =?utf-8?B?WEpNZFlqWVBSU1VEaDVxL3RxQTlieXBtV2hmODFReUc3ME5wSkRnWE52ZmI2?=
 =?utf-8?B?TlN5NzV3WW5lODdSbjlGMjU3T3RXOEhHdHpiT3pqSHJmVHJYbnpMd3ZYNStz?=
 =?utf-8?B?TGdDN1dzd0RGQ2M3M0dhbWgvSjgwL3l5bE1oWE8zQ2FLbzJ0VTgyUlh0SnI3?=
 =?utf-8?B?REc3dmd3dlNSd2tXZTdYUlNFVlNBOW5YU04xRTlSanZwUUR2VUxXV0M3K1JZ?=
 =?utf-8?B?b3hNVDhpSjFLWlZkbVNyd3g1S2VNT05kb3o3Vnh5ck1CVE83ZlE1alcvV1cz?=
 =?utf-8?B?U24rK0ZiTG9tYXA2bEVNVksrbmZBOVhpVEZNSElwYzE4bnlJRFRid0hJTldS?=
 =?utf-8?B?QkE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	bzg3dGGD5LwlHg4sjYiSJ6X7doxrxxrLLb1JcC0XP1YF48oehftY+bmaxjvdm6UFoy3v5+5emC71iz2nNcEf05MkY+dxkEiNfK9Tc2Mz9U+klvpDHbHrL7vx3D+lW78a13i6cyskuryAGZGAYhtl7MIq0QbSG+3eYKKPcNTaMdDnd295cVPu+IK1t+RHvGnsM02ZYr3PJTPZwblCf2aYNyqKRvjg8PiPslxsfF2qr57wYAJY1hYDcdn6uyDtgv5zaCwt9UMSmIMODAijlUJaNtWzMUtoahRK/8WCE/KHenK/vDHo5HxVbjW3TcO6qXfbsIOLizWba87B9LB96n8pk7ANyAqPU1c5Mr7iDq4mVLamaUzEYLyWGUuumbNT6XMDVWNyjHDXTSrstJyUFGjGaeOIuED76ED3+1KrM0u3ztPnS3qnicwgc8TunyibV1H9CTJZePMJ3bIzCQQc9RI4eIPI4DyRJeCwitVukW48QOCcml8plOQsqdSWK4e7y/XOYFzgLvJRwzHpVWQynN+DevENi3B0H72UMtmQNfAg37hfKCxs+WGyp8B26sOR+0+5ObyTfZEuNZZYhRmaRZfnlD/kJeya1T/TJIXWBdkAgc0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44200820-7eba-48b5-e700-08ddd104b925
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2025 14:07:17.6408
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VDAfikMxfEGztyDdavho8Aj7mr3QDYKOhcmPeK8xk1fokihIj6Wxhv/tev7r3bQzvyMBcGHnQP8+IrN4yq82oQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR10MB8493
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-01_04,2025-08-01_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 suspectscore=0 mlxscore=0 phishscore=0 spamscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2508010107
X-Authority-Analysis: v=2.4 cv=X+lSKHTe c=1 sm=1 tr=0 ts=688cca1e b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=h_Plik7XHjxaP--tmSMA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 0YTn9N43lfWV3VX7CLfVLynlcPO0ah2A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODAxMDEwNyBTYWx0ZWRfX1MagmBpe7dpX
 LAxWdkTnbrunRf8EcAx9QlBw7da96A8hydGwPiOC5KdqUaZK7gZRNAHmqDMnDZbGwPZquT6Az5k
 TCeZ5+nAsyYOEa0CJHmKRX7Ow+nTbosjCWN9wXNBrL6OnQY638L3NEidUagKgjQMYAqMA5+wq4p
 dESd8U4RULucQLgAc3C8e/pp9gfck/dV0SZ37wzslL1cmMer66t3DX9UlRJVct8r4VTvQehXfHZ
 enPB2h/DohJSyANAlLYs+yrPGDbMJuvyJOWJEgy5goFSEockt8U2+uxqoeJRJV5SNKtx8emM9JY
 vQ/ycL8G5LSewTp9QCFLB4OD9kJ0JsTDN/zuDXVryaFUUPmb2tdDr0FZ+852eHlNSH546hljhPi
 kWm0PmP5zvGzptyKMZZYmKRlAounyNzvR0ehr36pD9ZLzTVio0ZpUfQs4H4cFUkLI/zfidox
X-Proofpoint-ORIG-GUID: 0YTn9N43lfWV3VX7CLfVLynlcPO0ah2A

On 7/31/25 5:48 PM, Mike Snitzer wrote:
> On Thu, Jul 31, 2025 at 05:28:13PM -0400, Mike Snitzer wrote:
>> On Thu, Jul 31, 2025 at 04:58:00PM -0400, Jeff Layton wrote:
>>> On Thu, 2025-07-31 at 15:44 -0400, Mike Snitzer wrote:
>>>> NFS doesn't have any DIO alignment constraints but it doesn't support
>>>> STATX_DIOALIGN, so update NFSD such that it doesn't disable the use of
>>>> NFSD_IO_DIRECT if it is reexporting NFS.
>>>>
>>>> Signed-off-by: Mike Snitzer <snitzer@kernel.org>
>>>> ---
>>>>  fs/nfs/export.c          |  3 ++-
>>>>  fs/nfsd/filecache.c      | 11 +++++++++++
>>>>  include/linux/exportfs.h | 13 +++++++++++++
>>>>  3 files changed, 26 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/fs/nfs/export.c b/fs/nfs/export.c
>>>> index e9c233b6fd209..2cae75ba6b35d 100644
>>>> --- a/fs/nfs/export.c
>>>> +++ b/fs/nfs/export.c
>>>> @@ -155,5 +155,6 @@ const struct export_operations nfs_export_ops = {
>>>>  		 EXPORT_OP_REMOTE_FS		|
>>>>  		 EXPORT_OP_NOATOMIC_ATTR	|
>>>>  		 EXPORT_OP_FLUSH_ON_CLOSE	|
>>>> -		 EXPORT_OP_NOLOCKS,
>>>> +		 EXPORT_OP_NOLOCKS		|
>>>> +		 EXPORT_OP_NO_DIOALIGN_NEEDED,
>>>>  };
>>>> diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
>>>> index 5601e839a72da..ea489dd44fd9a 100644
>>>> --- a/fs/nfsd/filecache.c
>>>> +++ b/fs/nfsd/filecache.c
>>>> @@ -1066,6 +1066,17 @@ nfsd_file_getattr(const struct svc_fh *fhp, struct nfsd_file *nf)
>>>>  	     nfsd_io_cache_write != NFSD_IO_DIRECT))
>>>>  		return nfs_ok;
>>>>  
>>>> +	if (exportfs_handles_unaligned_dio(nf->nf_file->f_path.mnt->mnt_sb->s_export_op)) {
>>>> +		/* Underlying filesystem doesn't support STATX_DIOALIGN
>>>> +		 * but it can handle all unaligned DIO, so establish
>>>> +		 * DIO alignment that is accommodating.
>>>> +		 */
>>>> +		nf->nf_dio_mem_align = 4;
>>>> +		nf->nf_dio_offset_align = PAGE_SIZE;
>>>> +		nf->nf_dio_read_offset_align = nf->nf_dio_offset_align;
>>>> +		return nfs_ok;
>>>> +	}
>>>> +
>>>>  	status = fh_getattr(fhp, &stat);
>>>>  	if (status != nfs_ok)
>>>>  		return status;
>>>> diff --git a/include/linux/exportfs.h b/include/linux/exportfs.h
>>>> index 9369a607224c1..626b8486dd985 100644
>>>> --- a/include/linux/exportfs.h
>>>> +++ b/include/linux/exportfs.h
>>>> @@ -247,6 +247,7 @@ struct export_operations {
>>>>  						*/
>>>>  #define EXPORT_OP_FLUSH_ON_CLOSE	(0x20) /* fs flushes file data on close */
>>>>  #define EXPORT_OP_NOLOCKS		(0x40) /* no file locking support */
>>>> +#define EXPORT_OP_NO_DIOALIGN_NEEDED	(0x80) /* fs can handle unaligned DIO */
>>>>  	unsigned long	flags;
>>>>  };
>>>>  
>>>> @@ -262,6 +263,18 @@ exportfs_cannot_lock(const struct export_operations *export_ops)
>>>>  	return export_ops->flags & EXPORT_OP_NOLOCKS;
>>>>  }
>>>>  
>>>> +/**
>>>> + * exportfs_handles_unaligned_dio() - check if export can handle unaligned DIO
>>>> + * @export_ops:	the nfs export operations to check
>>>> + *
>>>> + * Returns true if the export can handle unaligned DIO.
>>>> + */
>>>> +static inline bool
>>>> +exportfs_handles_unaligned_dio(const struct export_operations *export_ops)
>>>> +{
>>>> +	return export_ops->flags & EXPORT_OP_NO_DIOALIGN_NEEDED;
>>>> +}
>>>> +
>>>>  extern int exportfs_encode_inode_fh(struct inode *inode, struct fid *fid,
>>>>  				    int *max_len, struct inode *parent,
>>>>  				    int flags);
>>>
>>>
>>> Would it not be simpler (better?) to add support for STATX_DIOALIGN to
>>> NFS, and just have it report '1' for both values?
>>
>> I suppose adding NFS support for STATX_DIOALIGN, that doesn't actually
>> go over the wire, does make sense.
>>
>> But I wouldn't think setting them to 1 valid.  Pretty sure they need
>> to be a power-of-2 (since they are used as masks passed to
>> iov_iter_is_aligned).
>>
>> In addition, we want to make sure NFS's default DIO alignment (which
>> isn't informed by actual DIO alignment advertised by NFSD's underlying
>> filesystem and hardware, e.g. XFS and NVMe) is able to be compatible
>> with both finer (512b) and coarser (4096b) grained DIO alignment.
>> Only way to achieve that would be to skew toward the coarse-grained
>> end of the spectrum, right?
>>
>> More conservative but more likely to work with everything.
> 
> Thinking/looking further: I really do prefer the approach I took in
> this patch (over the suggestion to implement STATX_DIOALIGN for NFS).
> 
> Otherwise NFS would forced to needlessly issue an RPC via fh_getattr()
> even though we're talking about NFS faking its STATX_DIOALIGN response
> (so it doesn't need to do the work to do a full-blown GETATTR).
> 
> This would be wasteful for the NFS reexport usecase.

Jeff's point is that applications (and in particular, user space NFS
servers) will use statx() to discover these values. The NFS client has
to implement STATX_DIOALIGN.

I don't buy the idea that using vfs_getattr() to call into the NFS
client is wasteful here. Isn't this done once when the nfsd_file
is opened? And, since these are emulated values that are not fetched
via the NFS protocol, wouldn't that mean the NFS client could respond
without sending an RPC?

I prefer to not add the exception processing to NFSD if, in the medium
to long run, the NFS client has to get support for DIOALIGN anyway.


-- 
Chuck Lever

