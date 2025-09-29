Return-Path: <linux-nfs+bounces-14762-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BF70BA9418
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Sep 2025 14:58:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2BF7F4E1546
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Sep 2025 12:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6011F304BCC;
	Mon, 29 Sep 2025 12:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OtzBH14w";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="AyXvHQJd"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 781F12BCF4C;
	Mon, 29 Sep 2025 12:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759150689; cv=fail; b=SexuFrhGUj/bmzAYdEN/dq1PQzsVr5gfF7K8Kktq8v+YA94JoaN7zyET9sFoq6bNYtbQiXi09GsXgxLShK2ruwBR2pbvZwSQDVLBBWOt2kYrun/dCyanOwzSNh1VlFo4/0qw3X5Wnp2aD+y/5b3aEy+FbXSBdS7ZXAMkZc73NB8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759150689; c=relaxed/simple;
	bh=4G2yoBlXqFI+rlmG7oS4ZMIXoUnMDuvFz5APeP6/jbA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Sx0KPdT0I9Xb/sAcWCtOsSCB/OfokUR38kGmoZm26d1HbrZDS1TeH1uySJJJkCWgbJ/XfzaYZks0cm8GrWPjDYf/KjvmVCOJc08XPvWgCGmGvymXNu3mtvHy9g/CVvqwy8HpTrDh8SfsVOAXpD4MZwZx/IyulildwiKD7Ku98N8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=OtzBH14w; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=AyXvHQJd; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58TCsCiD003031;
	Mon, 29 Sep 2025 12:57:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=p2ps/b6XaNZ2cQ4y8eF4f1DO0n3so1WRlPlDtmhIgOY=; b=
	OtzBH14wTUnwjYXPG/+gt3eRPvnzlfNmYDfNLim7Iso5pJqUEXPcCLJSL3XWWToq
	bzktx3DQ1igZ22b7AsDWl1P+BzJV7ES8HyDXSrN+T6lazS3pCTMTo2WyyPhfn5I0
	BgnHq27SBYR3oMsflAMbW3SStgSp749NfzWFGP0qhECWn8c2J9NmTnQz1g7Vi27I
	S8b8IOVjnw5ExE35cGz3WOU3RM/J4okNgh05rZyuRszgKmtH/dQdDhMClhSs/Ndd
	huWi04050WJD4yu/ROzc8XEN2PXSKpwDZh37UcpzMbAxt4Q07ZPMMzfL5ajpnBrB
	tn0G+tr17XgZ7zBWNivLBg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49fthc8065-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Sep 2025 12:57:59 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58TBLZwl037430;
	Mon, 29 Sep 2025 12:57:58 GMT
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011015.outbound.protection.outlook.com [40.93.194.15])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 49e6c6n37a-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Sep 2025 12:57:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a4i4O+gLP2fBkbFLgL2j2wFKnTDQ1lC+lVH15PuOiYVpmQVVZAwCtIN//2uOZN0zoG6tQIjUrwVevrOsoo7E8ZL5nFg4VmqLyAJy/Gld0yN+KdspluUoyUONzezUdloLL3czPotw8hDHn2vDz7kCovkrODvLfmSZDWzvDchk/bV3aP/jJ75hy/4g26rtbZ4kr47gp3NgFD00ppK2W46qGwHB8gw2O/gt6TrkwYEnQ4rg3fer5a8DXw+FXC96EVrtgneX1o51BhPSHUSJXq74Qd+1RStGOY2qMn0nFiK+IYCMkqPsRpPmrkebBEPmBjJ2R6/fF4WMREPjT2NaBgDj3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p2ps/b6XaNZ2cQ4y8eF4f1DO0n3so1WRlPlDtmhIgOY=;
 b=K1xUwElel0iKnoSHWwCBITirHKlbjFCPEMOnmCn22ZM/TpDxUetmH7qJNq/GPa0E52LxUXtwg954NFFizXVn5WPGjjNnFiC7Lbcnv/N8YXAUZZR2jQH4/IpU/tbQW9zxGVGi4/leZHchw8M1blo0dCsh/5tW170xihcEaFs95gAxjX2X9cq23rJuumShnMBLN7bjdTdAvlrOUBJy3dbuTpqRbD5feq91op21CuBkLIXBqlEExTevuiZtGBBjRM2iJQu5Kxcir4C1vItOpUjK/l9H/hzoSTrm/+EUxQ1tufHeZcxqSVvnyZb2voETvPcGd4lkLVthCgwrXYupBp/QGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p2ps/b6XaNZ2cQ4y8eF4f1DO0n3so1WRlPlDtmhIgOY=;
 b=AyXvHQJdcmweL3Fnd6/7yiHpb2uMKEHLtYzLaOpm+YA3IAz46eV1Zp5Htg+GsOoge9mShV6bowuVQfMGSVrOzKVYZvjMwyagqIwtABVpm1VK7Rl76wgWmHMdZe3UMbX2XNPC5HK25vHhekwYRBUjlRcXCmV8beCtTd7dyc6qpjo=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DM3PPF3F503E3E3.namprd10.prod.outlook.com (2603:10b6:f:fc00::c21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.14; Mon, 29 Sep
 2025 12:57:51 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.9160.014; Mon, 29 Sep 2025
 12:57:51 +0000
Message-ID: <ab4428b2-9b0b-45a8-826a-455807316e49@oracle.com>
Date: Mon, 29 Sep 2025 08:57:49 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] NFSD: Impl multiple extents in block/scsi layoutget
To: Christoph Hellwig <hch@infradead.org>,
        Sergey Bashirov <sergeybashirov@gmail.com>
Cc: Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>,
        Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250911160208.69086-1-sergeybashirov@gmail.com>
 <aNo0BCzVQxR60qeT@infradead.org>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <aNo0BCzVQxR60qeT@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0113.namprd03.prod.outlook.com
 (2603:10b6:610:cd::28) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|DM3PPF3F503E3E3:EE_
X-MS-Office365-Filtering-Correlation-Id: f6e175db-667e-44a5-cb28-08ddff57cc4a
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?aWVuUmNadVBVZ3I1Ni81SmlrMy9mQ3BkOVZKd0VFOWhjc3Fud0tJVU4vaFlK?=
 =?utf-8?B?Y0thMy9EaGFjeUZYUDJZN0phL092SXA2QThVb29LN3BWTGxaRUp5a1d5c3Zj?=
 =?utf-8?B?VmRPWE9zQlV4VlhrTG5XdDFucEdwVWZYRW9ubkFTMzQ2T0s0Sm1ZeHJjdGYy?=
 =?utf-8?B?TVZTbEVaSWU3eXJ1V1BFNUdvdVZpSHJ6MW5EZGdsS0lCT3VhZjR6VGljSWdy?=
 =?utf-8?B?cUxvblVDWWkvN0FnYmk5aTR3RUlrUmxiUlNaV2haQWlmendFK3l4eHFUaEVJ?=
 =?utf-8?B?VjVBNHRHREJUeGdPYU9qNTl4YXpxWDZISXFodFlCcDdSVTNrSVZucFZCTE5m?=
 =?utf-8?B?S2ltVURBN3RCL0habktmV0ZiU0VHWkd0K2Mza3FlcWhoUmt0Q2dUZkZTcHZC?=
 =?utf-8?B?S0cyZXIzM2tRQmw4UWh1bFQyLzcrRm1MS2VBWmQ5YjNDbk5qbjJjUnBSNWpP?=
 =?utf-8?B?d0R6ZGFZQW5IdkdZbmtlRWkwQU05T3FSSFhVcG9yUjU1cGVIZG54akorZitO?=
 =?utf-8?B?NFhuWnVaWEJSdDhCYm5wUlY0MGE4blh0NEdOYUM0ZE9jT3VXcDdEZm85dERu?=
 =?utf-8?B?SkQxQkRnY3A4MzRPdTlXU3lkWDBvN0lyL2YyMGc3ckFuWG9BSjVNV0NiM0ZZ?=
 =?utf-8?B?NElDNjIzcVB4TnJVSm9nVkFkVVl1aUwxdytJNk1mNGx4dEpXMHNGRnZOUUp4?=
 =?utf-8?B?QzZsSytkdlVYc09ocUhYNWlaaHk3c09zMWg5ZlE3WUZlNVJGczk4R3Nxalpl?=
 =?utf-8?B?S21Ic1Bia09pa3RYQWNTSnJ5Z2JrUjJ4Vm5uSzBVbGd2SGVoSlpjU0llcGs1?=
 =?utf-8?B?TUNsblJtWjdDTERQcmpnbFUrVnZrOFdPK0xTR2ZULzdaUkxSdTNTZ2ZLWlhi?=
 =?utf-8?B?QmR6dW14YkdjNFlWR01RUTdsS050RWpFelkrNTJPd0JLVUQ0YjB1RmwzZkFi?=
 =?utf-8?B?cHEySG4xWWZGYnAxQWtXQzVLNWp4ZTgvZHpTQ1AxYUsvcTczWWlZbDZNdnQw?=
 =?utf-8?B?c0V4ellvTVc4amxKVkwzWnBndnc3VUhGcFAyYTVIdlVJY2k3UUFwRGI0bHhn?=
 =?utf-8?B?a05pcnBmYnNUL0NUWHRCOUJsMG4zOUtyaitodEk5eTQ5Qm93dk9QR0p1VGJo?=
 =?utf-8?B?OExzYVBoQk8zSXRZSEtrQzlVMFJWVnBNRnhoZEpVRGI0OVFRbnRDcS96ZDdQ?=
 =?utf-8?B?MnpRQ2FWaEEzN0oyTDVMektzTnIrRElJZlROTnFMWXVCaitrRFhHTlVQYU5v?=
 =?utf-8?B?NkpzemRvUG0zWmtaK0dCOG5jcGZxQitiMlVhQlQyYlFNeUJDUDVWb0VYUFg0?=
 =?utf-8?B?OXRwWG94L3ZJMWJLZzI5Qy95RngwL3dMV0V2RWl6Zmp2d2IxRWhvV2MyVElG?=
 =?utf-8?B?bXJCbjY0ZWowdDZ6ejJaa1Erd0RSTEltdTZ2ZDFNNTZyOXZ2eUpESEF1ZGJp?=
 =?utf-8?B?NXQ2cFA0VGNocWtGSk5lMm5xWE1zdWd2RElSYkN1T3VCOU92alZoS1kyb2Ru?=
 =?utf-8?B?QWNZZ2FNRlRpbnowOTI4SnZyVXRrUFYraXUzOG5VblpXNXhqZkJaZWVHUWtT?=
 =?utf-8?B?cnlkN2hLdGliZzl4T2UrSjEvaE4rUzNvQzhSa0E1LzhVZlNlWnBDMU9CSVNI?=
 =?utf-8?B?WUMvZy9GUmhLQnY1YlhDUmxZaENCZGFRQnZjY09lbEVoeXpkRkVLNVdRck11?=
 =?utf-8?B?Yzd2REtTdDQvZDdPbDdnMEdYSFZPQ0dDZHM1RWVNeVVoZ1lRdjBnUHZyUHFJ?=
 =?utf-8?B?RDY3dnNINGJOb2tCaVdYaWNLN1kzUkZvSktobHh4NFZpTkg3V05LMFJLb0lQ?=
 =?utf-8?B?dmxNaEFIN0prSmFkKzh2SENPSkNIcjYyUFd0QWJEK3lLSFU0WnNQUjU5MjFV?=
 =?utf-8?B?cTllYUVEa0pWVWZzMUllUXB0THdLUUdyTEYzNzc2QkZCa082bkNCQ2ZyMm1y?=
 =?utf-8?Q?ZglGtTR7gcnDJf3pQ8jenfx1Tb75Z0k1?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?bGRVcjZlUWV2ek9lQ2pjTXlZZWxtek5OQ0cyaTFDQ0YyS2EyaWlNTXFWN1dW?=
 =?utf-8?B?ZDdBczh1bmRScHZtYVJ5UHpCTzd3aHF3dWoraDBsU2J1eE1LYjh0K3lKRG10?=
 =?utf-8?B?Vk8waWNGWjFXYWc3N3EwUEZJcWIyVDhQUFc5bjJsbjNsUjVrZ2tYc2hTcVdX?=
 =?utf-8?B?eUFOVVlqNy9LSkFtR3d5UzRUa01Ka2poOE1WZHk5ZE02ZzhsUk9GZ0lOdzFQ?=
 =?utf-8?B?K3MxYlNiZ2dhazgzWXg3N1BsdEJjR2MrZWJ3VDNISlQreVJ6YXI3Z1VVZ1pv?=
 =?utf-8?B?Y2VDdTBZak9yRkRqUldwQi91NkE0WnFRRGV5dmgzSWNKWEFZNmFGcnJRbEF2?=
 =?utf-8?B?STRwTTdMVmE1TzRnRXdpQXQwNDRRc2J0cysybjVrcTF0clhFVEZYbngwQ1g2?=
 =?utf-8?B?cGtFUFp3Sk9GaHk5ZEd0V1BXQXNqa1VyMVBFSzgzVjNIY2dyUTIxcnFkd0NZ?=
 =?utf-8?B?ckh6WEoxQ3NOWERYTHh5VkdFK0lhOFJjdnJLa2ZDTWdEQW93QnRvb1h6OE1j?=
 =?utf-8?B?ZzU2aVhPaWVKSjlQT2s0Y1dKcEZ0MG1jVFNZSEl1cUhYN3BPUHVDUkM5bVlD?=
 =?utf-8?B?bDRFaUJzSlBNRk1kaWpmTlA1V1poWUdGbEt6V21ZSmRNalkvZ24vSUx3VE9V?=
 =?utf-8?B?YTd5TkttcDB5Q1JxT3VCeHVabXVHZUhSNUUyNlI5VkEvMnFvdlRreGQ5a2Ra?=
 =?utf-8?B?TjJSaTBtZlo3Znd5Uk5nSGtUTVZ0Rks5Tm1WeS9xalNlSHdNUHF2V1BEdWRU?=
 =?utf-8?B?cWVvTnBpR0ZhUzhGMUZLVHFUVkRTOTZnMEFvMXdxVTc4SG5Ldklha1RjMkVw?=
 =?utf-8?B?NUFkRStabUdBQ0c4anZrT3pmN0VDY2oyeWlXTmxNa0dRK2RHTGxyYTFvb1NG?=
 =?utf-8?B?OHIreTQ4UDdaY0JHZGJFOEp5SkcvVzFlQTFtcWhjOUFKYUxucHNibGhCM2Z6?=
 =?utf-8?B?RStGckZSSDlMOXduOTFMNzZyLy94U1hCUmliTzRNZHdXck9GRW5QakRDQ3NX?=
 =?utf-8?B?cTZWN0tDV2cvc3hKRTloNDY4Z0hsNVpmV1ZRV0pwSnR0bmNndUtxTnd1by94?=
 =?utf-8?B?b1lWS2R4WXRYczlQZS9MbC9wY1JGQnFndzlHYXVSbk9KcC9CVTJxT2xQb3Zm?=
 =?utf-8?B?UkE5RUJ3ZndTK3ZNdk1qZDVrbVBlZkhYaEU0aThiQVFtOE1oS0EzL2dJSGo0?=
 =?utf-8?B?czNWdW1wUysyb0x6TWZHYmNLdnB1bDBjV09zRFhwREtwRW5DdDJHb2NONE9k?=
 =?utf-8?B?ZVBSOXBnOTZkaGpRQUdqVHQyenErRzRWU3UvQmhFWDBOemJFWnpnVmV3MEZW?=
 =?utf-8?B?dVZ4c1JvNWl4cDlFdDYvVVhQWW9EclF0dlhZdEtWdTdtVHRLS1AzMzQwVDB2?=
 =?utf-8?B?RlFCNk01ZEtNekh4Q2QxYVZtQSs1V1BFeVExdm8vYWJYd21DOFhIcHkyb2dX?=
 =?utf-8?B?amJPUEdkTm8yalN3TUlOTHRCK1ZqRm1XQ29ObHF4blBLbjlESFNzeG0wWGtE?=
 =?utf-8?B?eWIxSGxmU1JXSVhrVVo3Tk5PVXpOd25WQzNTak53VGRQZ2NnR0VpOTNuUjd1?=
 =?utf-8?B?clp1MHJTaEMzZHB6ZkN6N2VpL3JHZFUvTjhHVGtpQkhRcnIvRUM3dlNFWEN1?=
 =?utf-8?B?cFg3Z3h2QTNyaGg2TXcvUUNkZkF3dForY25rdHd3VUZOdmlZVzZTOVhZSWdJ?=
 =?utf-8?B?L1hXYUJXL1FJZU1xcHIxN0lYTlVtVDJiYXhqYjNJejV6YlY1bkRKRlBabFlW?=
 =?utf-8?B?QThzcTNmdk96bHBqQ3RBNko4SUZnNUxpajlxOGJsck52bGU3aEFuTlo3R2tN?=
 =?utf-8?B?U2YxWGVFa1NvMm0vUktjaE1EMkc4a3NGTjFDL2xBaW13bk5FZ0pSNUJwQ1g5?=
 =?utf-8?B?MnN3NkhyTHROanMrdENVS1BUVmdZL3BBZkRwQmtoOEc2aVdSSCtWUmd1c0Uw?=
 =?utf-8?B?b05ab0R4cHRBMTd6MHF6dzEyMWRzTDgwZmdvZU8zZTZHSEZHT1Q4WFI4RU55?=
 =?utf-8?B?Zmg1Umoyc2NUOEptcmNiZHhMeklXeHpyZGFFSmxvQlJvaDFGUlArV2RHaFdm?=
 =?utf-8?B?WU5JSzFwbU42dzcxelpHaExmZXltcWdxUTM3eDNXVHFtWjdZbEh1ZnlwK0kx?=
 =?utf-8?Q?a20HWh4lFlpXvBe/J4rPVXpAz?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	l7a80pa9vRL2Cnqn/2SitKeNd3iLSApNmV+yQWpMaLs5T1yfykB0skjmwKn5FT0iafI4ik3wAQ9yb1E1V4/u2jvCD3bhRgsdzrMlcyKYlPbo8biKooQNMAg0eNG0ocoEhJt3u6Tvv8thmYHv0nJSZ2my0+5L/kPtNINK2YKgXMGfX8pOsn2fS/b5kbwdRgYyggNA0gjYiVeDxmTiZzXjGT0R8ukuA9J7gWJqtWqlBkAc7coPYD02Ub6rIJjqXM/rX4tybeuKb7669qwWujjLq/zYvnR2BlAHx7L3sIOFB2nbiC3nHFSfwmyTqWbJx9iB20Isbb4uwxb3afSJ0bcktM7NJh0nmM0q7vFzLfUMGEN2jXmJ0iAPAQk1SGLDL+Q+3QsCJjvrzQD2RIlns096YVxRN77kyiQVg1a8lLNyMtSTwvOOKPLmowI8jJOW921DJSdfa61kPX9s+nHrQ321TPL2Xevb5CXRQZgLg+UzfCrhDqaBo4p8AyCo+BbHEd6vMi2PjRiGY4MeJHMfOyJmO44MHG4M9fQs6EUnfgeoQ0hAL4mBaO5HMquhRQrkknGusXll8oi8YLtGvjuf4k2MFhkBTRda66CxWtZcXhwS+90=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6e175db-667e-44a5-cb28-08ddff57cc4a
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2025 12:57:51.2784
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NpVmRAmeuu9QY6ZW5m20ugUb6rTubBzaYWpbjuTsB8Jr68bRhSgyAiZXO7Yh/qNdQ9zopp38404WxPv0j4/Xaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF3F503E3E3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-29_04,2025-09-29_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 mlxlogscore=999 suspectscore=0 phishscore=0 mlxscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2509150000 definitions=main-2509290123
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI5MDEyMyBTYWx0ZWRfX7YN6G8rlymL4
 yexFwKCOSNU+aDGzcNtlh67QgTrCzhxezDTq2/mwxDZ9HDNRmAkvqNOWM0a4kUCZ5W10u/CE9DU
 vmZBhmcxy77GgTcsAWZyqxOVkZGzJU7c5no6wQpXC0hEmn14NDE25c+3QtlWM48ykBsvGrWHW5R
 h2fTQmLLQU7xLeZYBqGxGZRENjULCA8QSi+3IPciz19RXpiR+Z9b9cdMI/DWZA+WrWxoRDy2msO
 KtulKVKArGyHVYZyQHJUO83zZIfYulCVRVbBJwSM1Hr1ZC10D9T0NelkXub6kLUzIA4z2+vTlTb
 gCKeNe+RX2qGZlzFisi8g8OczC8Qhz6F5mHeBoeU/kzshFQFDKZrgBy7SuIN77utSPKrA0Xp5uz
 MVKy2kBVrEJ4Wh7LhiyrjZOzIAkigA==
X-Proofpoint-ORIG-GUID: NE_8DhJALqSa6nUW6GdtjvDU0-MFsHU2
X-Proofpoint-GUID: NE_8DhJALqSa6nUW6GdtjvDU0-MFsHU2
X-Authority-Analysis: v=2.4 cv=N7kk1m9B c=1 sm=1 tr=0 ts=68da8257 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=pGLkceISAAAA:8 a=1jErGLbxFBGpJpPkHqIA:9
 a=QEXdDO2ut3YA:10 a=cPQSjfK2_nFv0Q5t_7PE:22

On 9/29/25 12:23 AM, Christoph Hellwig wrote:
> The subject line is odd.  What is impl supposed to mean?
> 
> I'd say something like:
> 
> nfsd/blocklayout: support multiple extent per LAYOUTGET
> 
> On Thu, Sep 11, 2025 at 07:02:03PM +0300, Sergey Bashirov wrote:
>> This patch allows the pNFS server to respond with multiple extents
> 
> This patch is redundant and should generally be avoided in commit log.

To put this another way, the patch description should explain "why" you
want this change -- what's the benefit going to be. And maybe a little
"how" it is done, if that isn't obvious from the diff.


>> Signed-off-by: Sergey Bashirov <sergeybashirov@gmail.com>
>> ---
>> Checked with smatch, tested on pNFS block volume setup.
> 
> Any chance we could get testing for this added to pynfs?
> 
> Also what is this patch against?  If fails to apply to linux-next for
> me.
> 
>> +/**
>> + * nfsd4_block_map_extent - get extent that covers the start of segment
>> + * @inode: inode of the file requested by the client
>> + * @fhp: handle of the file requested by the client
>> + * @seg: layout subrange requested by the client
>> + * @minlength: layout min length requested by the client
>> + * @bex: output block extent structure
>> + *
>> + * Get an extent from the file system that starts at @seg->offset or below,
>> + * but may be shorter than @seg->length.
>> + *
>> + * Return values:
>> + *   %nfs_ok: Success, @bex is initialized and valid
>> + *   %nfserr_layoutunavailable: Failed to get extent for requested @seg
>> + *   OS errors converted to NFS errors
>> + */
> 
> I'm not sure how Chuck handles this, but kerneldoc comments for static
> functions and thus not as public documentation can be really annoying
> due to the verbose formatting of the paramters.  I'd generally avoid
> them and instead of have short comments explaining the interesting bits
> about the calling convention and/or functionality.

For NFSD, the tradition is to avoid kdoc comments for static functions
unless they are the target of a virtual function call.

Static functions otherwise can have big comments. Just not kdoc style.


>> +nfsd4_block_map_extent(struct inode *inode, const struct svc_fh *fhp,
>> +		const struct nfsd4_layout_seg *seg, u64 minlength,
>> +		struct pnfs_block_extent *bex)
>>  {
>>  	struct super_block *sb = inode->i_sb;
>>  	struct iomap iomap;
>>  	u32 device_generation = 0;
>>  	int error;
>>  
>> -	if (locks_in_grace(SVC_NET(rqstp)))
>> -		return nfserr_grace;
>> -
>> -	if (seg->offset & (block_size - 1)) {
>> -		dprintk("pnfsd: I/O misaligned\n");
>> -		goto out_layoutunavailable;
>> -	}
>> -
> 
> There is a lot of code movement here mixed with functional changes,
> which makes it very hard to follow.  Any chance you could first
> split the functions, then introduce the new pnfs_block_layout structure
> and only then actually add multiple extents per layoutget?  That'll
> make it a lot easier there are no unintended changes.
> 
>> + *   %nfserr_layoutunavailable: Failed to get extents for requested @seg
>> + *   OS errors converted to NFS errors
>> + */
>> +static __be32
>> +nfsd4_block_map_segment(struct inode *inode, const struct svc_fh *fhp,
>> +		const struct nfsd4_layout_seg *seg, u64 minlength,
>> +		struct pnfs_block_layout *bl)
> 
> I struggle to see what the point of the nfsd4_block_map_segment helpers
> is, as it seems to add no real value while making the code harder to
> follow.
> 
>> +{
>> +	struct nfsd4_layout_seg subseg = *seg;
>> +	u32 i;
>> +	__be32 nfserr;
> 
> Nit: nfserr can be local in the loop.
> 
> The subextent handling confuses me a bit - there is no such thing
> as a subsegment in NFS.  I'd pass a never changing end of layout,
> a moving offset, and a constant iomode directly, which should simply
> the code quite a bit, i.e. something like:
> 
> 	u64 map_start = seg->offset;
> 	u64 seg_end = seg->offset + seg->len;
> 
> 	for (..) {
> 
> 		nfserr = nfsd4_block_map_extent(inode, fhp, ...
> 				map_start, &end);
> 		if (end > seg_end) {
> 			bl->nr_extents = i + 1;
> 			break;
> 		}
> 
> 		map_start = end;
> 	}
> 
> 
>> +nfsd4_block_proc_layoutget(struct svc_rqst *rqstp, struct inode *inode,
>> +		const struct svc_fh *fhp, struct nfsd4_layoutget *args)
>> +{
>> +	struct nfsd4_layout_seg *seg = &args->lg_seg;
>> +	u64 seg_length;
>> +	struct pnfs_block_extent *first_bex, *last_bex;
>> +	struct pnfs_block_layout *bl;
>> +	u32 nr_extents_max = PAGE_SIZE / sizeof(bl->extents[0]) - 1;
> 
> Where is that -1 coming from?  Or the magic PAGE_SIZE?
> 


-- 
Chuck Lever

