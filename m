Return-Path: <linux-nfs+bounces-6850-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D729F98F8C5
	for <lists+linux-nfs@lfdr.de>; Thu,  3 Oct 2024 23:18:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07ED71C20C3B
	for <lists+linux-nfs@lfdr.de>; Thu,  3 Oct 2024 21:18:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4500A1B85F4;
	Thu,  3 Oct 2024 21:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="IEliyDIj";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="tud1Gz4j"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60FF61ABEA7
	for <linux-nfs@vger.kernel.org>; Thu,  3 Oct 2024 21:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727990265; cv=fail; b=lJUfLOSJ5bTD007YqY0P8tdUnFj2tpwACeSvM7tmzM/RZjkHGNxIoWOZcRloEWEoDHN+Ls6h7c7u/bZ6UIY0TetAT2EgkcCwq6gQjqdSHxGQFJ8WEHk10s6Je5S6NbII6lEeV5t/rtNWqWMi+OaCOqZyz8f2HF8U3tA2WMQI1hU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727990265; c=relaxed/simple;
	bh=gcBlTM21SX/xFp2Y+BunLcNMBHaeFPrmfdy4e+BjGWI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KoURHxb5IzIPOitugYi/cI9SPQ4bQ2CaxpEuWXEGl+2doglR3cnX6UU7hln7Mfc+llqW8qw+IahK0Pw/cDtjtTS3QhTCc0pHaqN7OM0UMY4VKQYK7clOx6f3WsBegEcKZDrME/biKti5b/CN8RRaEUxZ1ZqAhU3Xw0UuFU6VzTM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=IEliyDIj; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=tud1Gz4j; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 493Jkrt8017414;
	Thu, 3 Oct 2024 21:17:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=pw4Lx5nXHWE9T/DmukmDySE2ycBP6EIVPVppkQm3OLU=; b=
	IEliyDIj0XM3+TOwvBLkvl5ytrpb6Tq37R9dz6OI4AVRW4NcBQpnqcM0fqSJNMDQ
	sm5jYEoIQAaeTS8FzUXYrf1XlimPeYgJZ0Z881KQU7vyuPZdxM3C71qFzKifGGNc
	KiA31y7aLkFUEE2RGLGkbAcaN12xRKwuYHSc7CwZzJMsyb35PI7Ppfg/tqCX6hV4
	anvHmOi2smwikIUW4Tyxpd2eMIgyBnWADy1e2ca6P/TTKZEcNUiMbRlMPIexiT3J
	axINas71aqmoQHb5jWNlfS/+BLjZ/6Ycb5ggScjncFkPFdg7BdYBxTqAhvBYT+B9
	djooIZBN46AzeeKqLtchmA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4220490d4v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 03 Oct 2024 21:17:15 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 493JiDrE037929;
	Thu, 3 Oct 2024 21:17:14 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 422056f7vt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 03 Oct 2024 21:17:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bt0IZj/AEfB6UD89T5FgQ4wOPUpNuomYNWXhSv94fPL5UOH4vHr9JIyEmzv3xyx4V37iZnvnz5FohsAItANJgI7GPKDGWybCbW6pdTU2K1hAQHc6llx/4+MkGA33VY0DcMGhfjFnaaaLRg9K6P7O7wyQzDTwcjEcIb8aQMWEiVJLUZ4PoSe2DY+Xb6CyS4iiCwhXBqCO/Hux9Hev9SGOzBu/WUTr5tBGU28HtD7+rzAi//43IFVWs4T46M3q/tkZONemfwETRtfbam8f1cUwhHAlA5DOQ3D8FYO4yE5x2U5FImiExF7am27jg7SeVkMVVCdy1YrpymSBl4spq5z5cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pw4Lx5nXHWE9T/DmukmDySE2ycBP6EIVPVppkQm3OLU=;
 b=QfZ4YkF6WeFRxfKFD+Y8GbXrfjmh3l/3U7/xv04X6HG8ORutFB4kTz2U0twfdqTmrjnOW9WJMNpeMZB3IN3q9ft7JY0gez+/pd7vioKXivuXCpuuCxS6IkiSPu0pDzRXR7tWSQue1wXxWH6Kqk9ZX6By+Nr+8uA8iJ7TF4s82Ztsq91qh0vJ7gyhf0AQuoeQpKR+N891dJSGvJz1Cn/txAxiGzLtv0VlZDHMNUfVv5JNZz1We0fwWTIn7KtoQRWMGw/jSMorsH0o7ZTSi6EKWLqptKnTajkUVk6JHT4JnTYpQrWJqDap3BJweivzKYa8h57sHfo5D8OijGijkuhRsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pw4Lx5nXHWE9T/DmukmDySE2ycBP6EIVPVppkQm3OLU=;
 b=tud1Gz4j4G3gOrmYUDytGJswEZW2bjWRMNORGXhaswQqIjNUJ1MaSxOrp0o28vM30RSYMqf83MbRM0FhgJW8X7UjsTYWcGofKwvD/ZlFZZ6fbdsLFpPlW6HwXvzZmMtacEFbQ0ifl0Xst/cH2WzgoGplXC3ZgZYYAxzOdgzdfSo=
Received: from SN6PR10MB2958.namprd10.prod.outlook.com (2603:10b6:805:db::31)
 by MW4PR10MB6558.namprd10.prod.outlook.com (2603:10b6:303:229::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Thu, 3 Oct
 2024 21:17:10 +0000
Received: from SN6PR10MB2958.namprd10.prod.outlook.com
 ([fe80::1aa6:4097:e5c6:932]) by SN6PR10MB2958.namprd10.prod.outlook.com
 ([fe80::1aa6:4097:e5c6:932%4]) with mapi id 15.20.8026.016; Thu, 3 Oct 2024
 21:17:10 +0000
Message-ID: <9f3b6e45-e818-4f97-9e58-2a0bf2e16f4f@oracle.com>
Date: Thu, 3 Oct 2024 17:17:08 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [6.12-rc2 v2 PATCH 0/7] NFS LOCALIO: fixes and various cleanups
To: Mike Snitzer <snitzer@kernel.org>, linux-nfs@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>, Chuck Lever <chuck.lever@oracle.com>,
        Anna Schumaker <anna@kernel.org>,
        Trond Myklebust <trondmy@hammerspace.com>, NeilBrown <neilb@suse.de>,
        Matthew Wilcox <willy@infradead.org>,
        Christian Brauner <brauner@kernel.org>
References: <20241003193504.34640-1-snitzer@kernel.org>
Content-Language: en-US
From: Anna Schumaker <anna.schumaker@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20241003193504.34640-1-snitzer@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR15CA0006.namprd15.prod.outlook.com
 (2603:10b6:610:51::16) To SN6PR10MB2958.namprd10.prod.outlook.com
 (2603:10b6:805:db::31)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB2958:EE_|MW4PR10MB6558:EE_
X-MS-Office365-Filtering-Correlation-Id: 70c31873-00a1-4ea4-bff6-08dce3f0be5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|10070799003|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UVFKRzNNNUtzQ1pDN2wzOXhOd1RRMDZRRGdEMExYYWtBN1dHTndvYUdSVkN3?=
 =?utf-8?B?eUtjNW1kb3crSnEyc3NyM0ZYbTNLOTRvK0s1Q2ZVNWtmMmFMSkxNcDYxeXM4?=
 =?utf-8?B?RUZaRmUxSXhydmFRNDdSN3ZMYTJwaGJDSXJ5aW8yUDFlVkg1dmV3YWJ1T0RM?=
 =?utf-8?B?R0ZpWlRYTTE5bzB3WnJyZkNNS0l3QUdqRzJOTkU2T1JTRm0xNGhVRUlxRU95?=
 =?utf-8?B?RTdFc0tTMmZwS256UzByTHlZWGp5OVVkbGVMMVZZR3dNbkUrVWl0TzFKYVpn?=
 =?utf-8?B?dk1RdU5sUy9QS3BtV0RiTDZkT1N0Zjc1ck0rMlpjN1l2MlBQL0p3OGg0eGta?=
 =?utf-8?B?cDVUTVc5L1NENWFHODE4SjYrYm5WQ0RacDd0dkxPT2FRTUc5RE1YWFVoQW1w?=
 =?utf-8?B?VEtFUjY4anNyS20wcW0rcVRCMk40Qm9BdVBDMllHN2JpZndpYnBhS2djdDNG?=
 =?utf-8?B?UFNTTVdIQ3pBVE5aaDBLLytKQ1dlWW42TnVMbzkzZnNwVVFIbVArUWoreSsv?=
 =?utf-8?B?YzhEd2F4ZzdHWmFibFVIZHVoa0IyMGQ4d3RxRGtyK3BPRndvQkVuemhiU0o3?=
 =?utf-8?B?ZVphL0tNbmI4R05qZitJRktWT3J4dmxCM0xJYmdwRG9mNHZVOVZhdTFqNDBy?=
 =?utf-8?B?d0ZCYW1VZmZoSVNadUlKbUExSTZrSjhKdWQrMW1iK2krYVNSMUpHTDdTcW9R?=
 =?utf-8?B?b21waUtjL2JWZVRUdFZJb0FwOE5za0s2T2I5bm5NSDNhaVJYZ3Z6RGdFMnhl?=
 =?utf-8?B?eTNNYy80eDU3VVZTa0VmdTE3Q010dktBblh2T2t5dzlwZnZlTXc1ck1NWkxU?=
 =?utf-8?B?WURMM3lhWnhZMlFaTVZHeG9FTUhUTjRua3hjTHBJZHZ0cUljUktHOGsyb0J3?=
 =?utf-8?B?WnhRN2dsNGFTaGJRTEoxZFNRc28zK1NCZWNubVZnQm1QUXV0SmlVU0tqMG9U?=
 =?utf-8?B?TUJSa05CaEx6NUJjZ1hKdVROb2ptd3JHRTVaMm43c3pSbTJ0VWNJOE5SbnNT?=
 =?utf-8?B?L25wMFkxN2x6eGI2TGh0TlcvcVl6U2ZJYkc1bXZyQWpCdHBPaVV3WkNXMGwv?=
 =?utf-8?B?eVdtekRhc2djTUhaQzdNaE1QaVR2UE5HNmdyZTJISXZTU0haMXhSNVNQNGJp?=
 =?utf-8?B?YnBvN2Nnb3gxQkpJZXBSUGo4d0R2VElTVy9pa3Z5MlhiaE9WbmRYakhiZmor?=
 =?utf-8?B?czFDdG41b2JtMTBYckR5T2VPRFJOaDFHWThEYnJZSWxqZXk4WlJ0c0ltYXVu?=
 =?utf-8?B?NEdZZ1FFV3EweXNMVXZXVWdsT2lsMGF3dndGc1Btc2t0NjdWaEhhMjdBbzE0?=
 =?utf-8?B?RGhxdVNzUFpaSWxTT2xlYy91WCtNWlVlS1BrZVlvTE1mblVRM3JGaWs2TkFx?=
 =?utf-8?B?OGdhUXZTZElVQzExRU51RmdLZjcxTzhWNzhwR1VQSmZ1eGl4b29EaE1mOXFR?=
 =?utf-8?B?S1hkaHEwaVBYV0lYRFlOc3hDMkUzcFU1U24raGRvOUxoeDh4NCtVd1U4UU8z?=
 =?utf-8?B?MC9DbisxRDNISjdnWjBKaFBtZG96ZDk2Y3MzNTFwcHdtUXJUdThackdJS2xX?=
 =?utf-8?B?ZTMxY1drOUFTVjVIeUp1SUhrUWE0bmR3eGkrM0gzZlpnM1hjVUlVeEovdlVK?=
 =?utf-8?Q?GodkidXEwoQoG8k9TROxiCyG/sLjZAKyMW87KxFvdFzs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB2958.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TC8rWlZYck1IdkJQYU5FSTN6dGIvOVg5N3N4a2JIeGxEZHQzYW5ScnY4UGVz?=
 =?utf-8?B?bXkyd0NjcmY3cm15V0JBbU5PMmFiM0JQU0VEZ0lRVmpNZ2UxNVluZ1BTVkpD?=
 =?utf-8?B?ZENLb3lJb2RPZGNINjF0SFEzME8rNXVvNmNVSEVwMlgyMmdjclV5aW1jSDZP?=
 =?utf-8?B?ZE4wQ09DR2ZDWUM0b3RSUkVISkoxamNqSHR4Vm5TZWZRVmFWYk9JUnNzMGsy?=
 =?utf-8?B?TVdxdUhmb1NTcVg5NGZjV2tYZzByVFdGMHRpQ2FTY1ByZVNaMHZSMHdmM1ZF?=
 =?utf-8?B?NWpheC9JZ1dnbjRYTnVHNzMvUnhtQmE4OWtSaS9FRTh3VUx1L3FzUGRCOTVx?=
 =?utf-8?B?dFNyL2lYQUp5aGMyeGZTWVhVTFpiTzNvVjQ4Nm5XNUgxL2ZJT2Zzd01XcXBy?=
 =?utf-8?B?Wjd3TjYvbTdHSkEyNzZ1amR5ZmtaUWhmRHB3UXlkTnZ6TVg0RWlQL3g1ZkZM?=
 =?utf-8?B?MElaOU4wUmNMMnNvM21iVmh6VG0yS2xId1BCVkdGYWdHSDBZeG8wUDJNcVA3?=
 =?utf-8?B?Nm1tOEtiVXVNdndPdWVCWGM2NzY2V3BQd1FvcVBNVUxXeTFoVWMxd3ZTZlFZ?=
 =?utf-8?B?T3pNbVhYZlk1MmFGbWN1T0tKM2N4YlUzd0h5blQ1QWNnZ21OM1pJbWlxWmFr?=
 =?utf-8?B?Z00rcVJaWDhsMUxGd0VsblY2THlaWEhVejhtREdMMXNSUUVmOFdPUDFRS0pw?=
 =?utf-8?B?VWxPVUZIMFVDZDBQUDBYVThoUG1oSEJDdWFSWEtmdTl1aWlvL0xOWkwxZVhP?=
 =?utf-8?B?ZVVjV1k2T1FRZzBBbVd6T0RyYmUyT0dQbU1tbnN0UkFsTmtiWDluWlVmNjQx?=
 =?utf-8?B?UE9JOUwxa2RjSXVnaW5wSEt4dFRPTFZFT0xGUTBNRTJEcnlqblQxaGcvUVl4?=
 =?utf-8?B?R1dHenlVanBWem5KZGJZcUl6cm0zVi9mWnl1UTluMnZyWGFqT0xkb0pla0hw?=
 =?utf-8?B?VVRwZHMzZlcrM0NzS043MHNKcjNKcUhuTy94ZjlOSlZGY3dIOGZreVhWS1pX?=
 =?utf-8?B?WUtBYitHVnh3NGFhRG1McWxVQkd1SFZDUkRXckxnMStqSWtpMlVDZzBPQXpO?=
 =?utf-8?B?cjBLYkRkZHlQWXp3cVhEOWliYXBwN2hxTmNwWXU1MWNoQkZDeHJJQngvSk02?=
 =?utf-8?B?N00yL1poNUVvV2tlVncweWpUbnptOXQzUzVzYThJUzZaTlUvSE54NTZuK0tV?=
 =?utf-8?B?eDREc1dXUTBOam1wK00rOFVma2VPMXd4cmxxOTRwVlRWUzRpU2prTmh4MllI?=
 =?utf-8?B?K284amYyeFE3KzBzZ3RHaExqWnRVbFc0M1Q3VHZ2NkdwQ1hrbHJVam1NMVY5?=
 =?utf-8?B?WCtGMGhnVFg4US92UTZsbmgxRHdsR2h1Y2x3VExmeDNrcU16UWUwUVhWa0pS?=
 =?utf-8?B?ZUlDeHJRVlc3aEhOV0lWczFFN0hNVVdreW5QZTBmRU0xUUhyZEUrSGFCL3A5?=
 =?utf-8?B?V2g0UFljRlFGZGRrT09aZm1iODU5c3RMK3VqaXVmM0toZkpsdkloTXRLWGJV?=
 =?utf-8?B?Q3NkRUhjOEw3OXBoMU1pb1BqSHJNNVYwY0ZZeEdscXhQYmIrTmM1QklWSjJC?=
 =?utf-8?B?WmY3MEl3bVJaTVY0eHJ2czJMRk5xalVNcGhmempEMXYrTHBlMDdLc2toWTMr?=
 =?utf-8?B?VkNQOEtHZzduM1NOTlo1cUozOVc2bWw5ZmUxZ2s4K0dzQWhHeXhtZ1JTYnlW?=
 =?utf-8?B?NGptakdLRFpsOCtlNHg2WG5VTWtyeFArOGNXYzdPbTdaZjcwRndlWXNtNzQv?=
 =?utf-8?B?MXVZUVZhYmJCYzF1bXlONTcxZmJkZUE5WDI2TGlrNitEZWJRclorcUgyVTdB?=
 =?utf-8?B?b0hScDFvRHBzRmQ1RGIxZmsxcW1JamlrR0tXRlVkMm81cFFMRkVBazJRLzNl?=
 =?utf-8?B?MGtheEVuNDBEeWFuQ3NCVzJPU0tjWjEzMlAxcnNUcVhzZmhLWXIxYkQyYW11?=
 =?utf-8?B?ZWNpMis0L2YxZE92UmhTNjg5QnhQUTJXTmpVRi9GNDVjbzd6bDlTekhQWUtW?=
 =?utf-8?B?Vys1RjdlOFNQM3NLT1k5OFRHaW1CYkhSNWltVTVTb0F5Sng5Y2x5UTB1NnY2?=
 =?utf-8?B?b0ZFQmYwTXE4ZmhpSWdYQ1hUSVRmc2JjZU9ETVcyUmEydUxTVUFwMHpBNUN1?=
 =?utf-8?B?d2V3dEUwa1dPaDZEN0dBMEVCMlBGbmZ4aVprdmwyMkNOUmJNMXVuVUtjbmtz?=
 =?utf-8?B?a25yU0U0S2ZiSlg3clZtZ1NDTFZuWVRaeWpLai81TUpJL29ZN2VGQmhaY1V4?=
 =?utf-8?B?c29jUytkZ25ZRWllYnJOWnFmaVZRPT0=?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	+nLVhQZA2ArZk953QY67nriOsaESp55snV3uiiyW5N80t0TaAtKwQ2Kq+eOaK4q8R/uP0HP4nDx/fgkNn5X/YYqnCvXlwakHdqYtHzN+TV89n4/F8/8ZEUv/cR3A14Ouqz3z3xQFhw1wwJIlIKwCXDRYTCyVIufWApWl0re1vCvh18Vld5bd0biqYmUT8WpVd0LPmNLiMyfpAi0jBRYtVkHufQ7X5lVT4YIjGzKKLpTW0cgJqN/HsD7jkkiA/QUZJOUxv/IUGv0X3RZ+naMFdTv86iKXwrK89xoG4cBt2s+dN0saWEjKJzYRPUs1EhK0T2ujpUJkKBFZBD+VB1JXVbyMhbbsG4XzZ/mRovJuiHAGwLgyM/NMwJUkNYZGnU5+InONRRbu5raDKjHIb9v5Xmqr4FJLXs/v4vnH7Qxs5Vu3mH1dXRDm9YpKzV+vPsC6nYeoGcGoQ12USrVmrOoxFiblfEzyaHewk8oJ1wKwnSWuKwk6ejv3r2Tb/tGavrGL3hHGm8jZChnosDfIdnDgScPtpbgKgIniz5TY6u84fjlb6VUzX67T9pp4r+2kKbUXBBCtbRNI7B4zjvZ9U+QWvjoCsDngp2VbTpU5SUaQmNI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70c31873-00a1-4ea4-bff6-08dce3f0be5d
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB2958.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2024 21:17:10.6322
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d2QQ+oAVu3B7MoFS03sKPOPd32q+EwmHmUeDSUu5yWHHMi5fBpAm64wPZdHLlO2L3J0t6gJUOjjXvsYM7WJq3rPAHHCyofvSUgSZYOzsgPA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6558
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-03_19,2024-10-03_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 adultscore=0 suspectscore=0 mlxscore=0 malwarescore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410030150
X-Proofpoint-GUID: psgmrshE-hOxNF1PtJWITbtR_c-62bcC
X-Proofpoint-ORIG-GUID: psgmrshE-hOxNF1PtJWITbtR_c-62bcC

Hi Mike,

On 10/3/24 3:34 PM, Mike Snitzer wrote:
> Hi,
> 
> The first 3 patches are clear fixes which are needed ASAP (patch 1 is
> the same from v1 of these series, patch 2 and 3 are new fixes).
> 
> The other 4 patches are cleanups that are more subjective (relative to
> them being sent for 6.12-rcX), I'd prefer they go upstream now but I
> can carry them until 6.13 if that is how others would like to proceed.

Thanks for the patches! I'm planning to take the 3 bugfixes for now, and I
think we should save the cleanups for 6.13.

Thanks,
Anna

> 
> Please note that there are 3 other LOCALIO related fixes that should
> be merged into 6.12-rcX:
> 
> filemap: Fix bounds checking in filemap_read()
> https://lore.kernel.org/all/c6f35a86fe9ae6aa33b2fd3983b4023c2f4f9c13.1726250071.git.trond.myklebust@hammerspace.com/T/
> - still needed, Willy or Christian can you please pick this up?
> 
> filemap: filemap_read() should check that the offset is positive or zero
> - Christian has staged this in linux-next via fs-next
> 
> sunrpc: fix prog selection loop in svc_process_common
> - Anna has acknowledged the need for this fix but it isn't staged yet
> 
> Thanks,
> Mike
> 
> Mike Snitzer (7):
>   nfs_common: fix race in NFS calls to nfsd_file_put_local() and
>     nfsd_serv_put()
>   nfs_common: fix Kconfig for NFS_COMMON_LOCALIO_SUPPORT
>   nfsd/localio: fix nfsd_file tracepoints to handle NULL rqstp
>   nfs/localio: remove redundant suid/sgid handling
>   nfs/localio: eliminate unnecessary kref in nfs_local_fsync_ctx
>   nfs/localio: remove extra indirect nfs_to call to check
>     {read,write}_iter
>   nfs/localio: eliminate need for nfs_local_fsync_work forward
>     declaration
> 
>  fs/Kconfig                 |  2 +-
>  fs/nfs/localio.c           | 96 ++++++++++++++++----------------------
>  fs/nfs_common/nfslocalio.c |  5 +-
>  fs/nfsd/filecache.c        |  2 +-
>  fs/nfsd/localio.c          |  2 +-
>  fs/nfsd/nfssvc.c           |  4 +-
>  fs/nfsd/trace.h            |  6 +--
>  include/linux/nfslocalio.h | 15 ++++++
>  8 files changed, 68 insertions(+), 64 deletions(-)
> 


