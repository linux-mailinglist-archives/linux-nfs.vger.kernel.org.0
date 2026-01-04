Return-Path: <linux-nfs+bounces-17432-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F31E6CF0C88
	for <lists+linux-nfs@lfdr.de>; Sun, 04 Jan 2026 10:16:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9983A300B287
	for <lists+linux-nfs@lfdr.de>; Sun,  4 Jan 2026 09:16:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A17F3207A38;
	Sun,  4 Jan 2026 09:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="iAlWgGet"
X-Original-To: linux-nfs@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010035.outbound.protection.outlook.com [52.101.193.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB88A1DD9AC
	for <linux-nfs@vger.kernel.org>; Sun,  4 Jan 2026 09:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767518185; cv=fail; b=FF7TncHA3NmwHQR4VvbL4w/xzTwfeWUGppAB58nsjmuWgNGb733Q5HMfY+X51q/KhLogdAiUru5k2s/q4wl7QzaLLvgNroW0dGTYdHehc5klk/oIoGQY2wf0CI4/jj1fxWPRUnsry+knn387gIj9AKX71yqJmCoD81WRNaUbv9c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767518185; c=relaxed/simple;
	bh=K+3Q8JHP8V5wccK/a6yXSnhvPMWoqzXA6tncQkaN9es=;
	h=Message-ID:Date:From:Cc:Subject:To:Content-Type:MIME-Version; b=N3Xfk/I+jZPjs6DtP/EMuU1r2ardMs3hGruysmysafakr9h9Cf7hV6Gv855rv6X7SA7NnKBT7cs59UQMT8ci/G0Nhel0OQEhDIPSN9dbuXKmCSy7f0TUa0R12e8RECnAgdkmnCY3n6RBxdZijJVwHDJBAeSnyf3edvVIktmaQrY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=iAlWgGet; arc=fail smtp.client-ip=52.101.193.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L33B3L4x6x6Ny2yXXcJfgCm6V+B8bz3wxGEqzpAsjwYlsnvvd+lSuyRGVtjOMmUdfkbfiA7Q5RbbXaFFw9VDqJS3lGmu/iQmwu2yqen8iEQkZ26kUI/tfk2wvHxWyMJacz0M7W6tDZm20NRx1BCdjUz3CWIEzKCaKMahTZ/fSr9i7c00ScGJ1rOOmdIxqU/ioZn/aETf3rh3pG+A8qOWe7f27qJk/KqGgBK1FXU9LC4QPbdnlgLhUJPSMboczuZvtcExjVJJdeVvKc/kys5v8el74ovHc+IoJO+pXn2GaevTiQ3hRkRPZXay7VFwwRBrnWgmoafD8OmGUBJq8vnxRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1E4cu1rESoTt3INSEmWBFLZ+nVJBZSz1oy6MwXpZ9jw=;
 b=XCQjzWkTx5xaAWCqoamsfH/4nzQfHFdWRxws5imAyq98KZVV0cp1zUbJ1fnr07ma0qBCcF27Mw7LzNOYBRLusaaOs8e8SJAnHSXnZTBZ31JccBEeLD4kpQPrzyVHWhJ2bRvmGWDNbRM9/PX+6bj3cvRn5xgE/w0uB2TIJ2QMzpEk6AqY/iR8jHNVtaV4ezg+bplBZ3iyZPDO3+xZdvrXB+RcJhfsNhwwnPlFFjusO7A1JNBA2c9k8KA04rTVz+4ydsivthEPy9eic51Szhgy5X4f9JkCM9h1hv1GN9uTa576V5Qc3lC+uATO5isEF7N3hMKd237TGTDfViNbYJh5Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1E4cu1rESoTt3INSEmWBFLZ+nVJBZSz1oy6MwXpZ9jw=;
 b=iAlWgGetofY6uz/MeB9CE97cFnZJg/zqztgKrz4JUCbwh4koGjx5cy0PIfldHdf7vpedsKVExXDfreF2/gNOK8dfx/zIbSjAxjTz1AxayJDiSoeYlHNsnSzC7r2k49cXco/IFIoxput1LfeDKDk5VNyn9a9+dTSpKKt5zwQ3vIKep3CPrXOR2OBbrlNp7aKfNZp64Ok3qEpxAZVyBdZto7v0PtnvEr/07m0HLBstTMwxZTqwSxue3ED9lxm1ONiAK9tI62hvVUCYo7xMF00OFflfqx3HVeu7PlFXUMMkZ1lOE5AJrKfP4KqY1gY+JmMK10PMT35GqTbyA1upJ3vVmA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by CH2PR12MB9458.namprd12.prod.outlook.com (2603:10b6:610:280::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Sun, 4 Jan
 2026 09:16:18 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de%5]) with mapi id 15.20.9478.004; Sun, 4 Jan 2026
 09:16:18 +0000
Message-ID: <447f41f0-f3ab-462a-8b59-e27bb2dfcbc0@nvidia.com>
Date: Sun, 4 Jan 2026 11:16:16 +0200
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Mark Bloch <mbloch@nvidia.com>
Cc: Linoy Ganti <lganti@nvidia.com>, Bar Friedman <bfriedman@nvidia.com>,
 linux-nfs@vger.kernel.org, Maor Gottlieb <maorg@nvidia.com>
Subject: Possible regression after NFS eof page pollution fix (ext4 checksum
 errors)
To: Trond Myklebust <trond.myklebust@hammerspace.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TLZP290CA0002.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:9::8)
 To CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7548:EE_|CH2PR12MB9458:EE_
X-MS-Office365-Filtering-Correlation-Id: 7783af56-b69e-40d1-e04c-08de4b71eaf2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K2JkSEZLZnVRbThJUFBDSWJpblgvNlFSRHcwdjhTbmtiWjZZcytWS2RaVDls?=
 =?utf-8?B?b295aUd4RWF6dnc0QXdSNEFNdThRMndINXk1VEk5Z1hod3hkSkFwdUcvQ3Zi?=
 =?utf-8?B?d2NoT2ZzWW43cDYwQzYwYmJZYVp6ZmRzYXdCVFRJQXROMnMvUVNXczdQM09H?=
 =?utf-8?B?OGtmbjFwa3AyV3gxaC9Oa29YQURCelp3SjJGcWd6YkNhei9PNWtFK3QvNUIr?=
 =?utf-8?B?WEtXOEpZVzF0d2N0RmlSYStGSENrVWVHU2dEaEJqY3FlSWdJT2VqWHVtVlFO?=
 =?utf-8?B?OTBUdGJWMzBHenZjN0VoNElhd0p5QUVOenhvNHpReWN6aUdoUFFwQXp0ZVc5?=
 =?utf-8?B?UmtEMk9xNC9vd1BuNXhOYVF1MVNIT0RXVWJad3VLYUNPanhxaCs4Qm5DYUhy?=
 =?utf-8?B?UlFpZHBZbGZTZnZObS9NU0JCbUVlUU9HeC9PVHVJNjloWXpxcXh0VDZBRVF2?=
 =?utf-8?B?ck85L3QweFBOb3E4ZUhyeHNnMC9GYTRRY05EYVh1VHFNVDZieERLYW92cVoy?=
 =?utf-8?B?bG1FQmcwQm5JRXBpbVdQVm9iQmVXRUxKdUtzeXRGejRobWFmbjcyYVQzWUdW?=
 =?utf-8?B?c0Izb2p0VmVjODk0d1M5K1RJSlBHczJxSGMyRkw3a1VJQjMyeGc5UHpGQTE0?=
 =?utf-8?B?cHFRc2V3ZlJ3UUs2R2p0WFdKeWJmNGRQN0RZcFA1ZUdKaEJvUE03cCtWWWVu?=
 =?utf-8?B?UFkxWVBYOURabDVEYkkrVkh5V2hZT2RJZHpHbktlN3E0TmhNaGhJaFcrUjVS?=
 =?utf-8?B?c0NnL1podXVGQVRnR01za1RwZGQvb3ptUXpLU0lSNS9VRTZpNjlROTMvZVJs?=
 =?utf-8?B?WEpad1hRUmFYdDE2OFFuamZjSzNmTjhjK3hMeVdQbjRkY05xZ3d1UkxtamU4?=
 =?utf-8?B?VGZzc3Fsd1lIeW1PMkxwUStDc3NwTlI5bUxLbytSWW9xcFNHbzBmRjhGRUtH?=
 =?utf-8?B?L2ZJZHZ4b1RZcnFIT1B4ZVRXNHdmNmw1SXV4STVaM1lnMTVBalBiTFVJc3FF?=
 =?utf-8?B?dytRTFZseTkwczhBdVlBT3hnTENMekNiMGJTbnlVNG0zZFFOWk5sK1JldjZO?=
 =?utf-8?B?MnNCdVZLMjNiN2ZFOTY3RkNVMGNacFNoTlRzTzVDTTk2dDRGZGN2ZFUvbWxQ?=
 =?utf-8?B?S3VCQnFQaU05SU5WRktGLzl0dVpIVjFhSjVpWUhheU5weEtJaWVwTHdrQmNu?=
 =?utf-8?B?VGgwMStMNEN5amd0dkhFclUrcm1wUG1pdjBGRVBVOThnY2xkRTNMYlIwLzVJ?=
 =?utf-8?B?ZUFOeFJaalNuazFJaE9BbEZYaGlEZWNRVFZ6NkFTUXN2S1lWZjgvSmUwV3Q0?=
 =?utf-8?B?Z3RRK3FMQjZNV0ZVb0pOazZhbnpnaTFZdnNoeEU0Um1CNndXM2dxNDdnZ1dN?=
 =?utf-8?B?U1FReUdrRDU4K1R6M3RiZGRrQUh5OUxnZ1MvOHVaRjM5QXM1VkF3Qmtudkg0?=
 =?utf-8?B?Y3lnU0xDTysxVmNTQU5kQmxSdUNUcW4ydHFFMDlBS2VHTXMyUGFxeG8xb2ds?=
 =?utf-8?B?c2JOMENkakJBZFgxK3RUYTFGaGdZUk90K3ZWVHE1TERYL3hVdkpXdXRZVlI5?=
 =?utf-8?B?RTNVOTBSK1J6Y2ozS2xWdkpPbkdpYzNCMHBHbWNXOWFLTkx6Wmh1OWFEaGlZ?=
 =?utf-8?B?V01ROTBIYmdCRzRFSXNIUkw4R2E2YlU4eUdxb1pJUjVCb2VPdFFaSXdnSFZp?=
 =?utf-8?B?T01YeDZySDRPVldnMHJYUE5kTitPaXFsNDZYT0FqSnBOQ1QyaFo0QjhxVnJE?=
 =?utf-8?B?VUtDR1IxdVRVK0I0czBRdGZhSXI3eHBMeTdrQnhuTWlrdlZ5dzI0VjRlU3ha?=
 =?utf-8?B?YWpZMW4zWE0vWTFKVUtQb25EVTZyQ1RINldub2kreWU3Zy8wSXAzRERYZExJ?=
 =?utf-8?B?b1IvZnRuUmpYMWtvbVFSSHprR1pXaDRBUDF3SGs0R01aRHlXdFBLUmpSWWVZ?=
 =?utf-8?Q?qh/Q126a/WEmHWtIVIIcOxgvmZu/RGe8?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7548.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RzQyNXNPUGVvUFo1ZG9OL1YvQ1BXb1lkN2FRMGN2OU5yMUFXWEZoWGZDaHBW?=
 =?utf-8?B?elUrV005TjR4Y1dWSU9YR1NiKzFaY0xSR3krdzF1TVdqSFNod1pYYUVrRmRD?=
 =?utf-8?B?YzVmRHhVUmFzMEtGWDlIRmM0MXFqa1RWYzFXVkJSNkcxUFRSV01BNUhRWGxr?=
 =?utf-8?B?dFZlRG9sVys3djV2SFIxY0dIL2pBSzN5RUlVUVJGMVluL3VHTFRNSStmYmF4?=
 =?utf-8?B?Q2Y2Rm80RERzdXNCNmlmYUlXNUZGcUhhZlVNSmlId0RneWR0OVp6STFCd1ZM?=
 =?utf-8?B?aDRPcndRMWNMd0dmQWVqN3Z2VTlFcWgwUCtUT3JXdXI5dmI5OEJubmpHVjdC?=
 =?utf-8?B?T0JsWmVsRlZNZUhQWjUxQnd5Uncrc0F6enVmdVN1c2txNjhCQmxPM2JmTkdS?=
 =?utf-8?B?TktEMWdTQ2lxTlhSL2psVk9TaGptbElDQlEvZ0dpK2Z1Zm5DYnBlWitKZCtR?=
 =?utf-8?B?KzI2aXFMVHhjck1PeUhNYWUvRTd0WUdlWTM4WnBBUFBPc3NuTFkvSXJ2RE5P?=
 =?utf-8?B?UWtkaW5DR3JlaThMVStyUGw0a081U3k2MzVMOU5oMWg5TFFCK3NQZE1Da1Y3?=
 =?utf-8?B?TG1xQlFYZC80Nk03YldNMitrY1RLODlsUEx4b0tMU3prR1FTRjlFRCtiMWZa?=
 =?utf-8?B?aC9tSTN1VVdiNVg3WDBrc3Z0ajdSYmZEdXloTVpCSzJGQzZGaFg4NGlIbDFN?=
 =?utf-8?B?Rng4MGIxT2FpeG5FMnF2VmtPYkZTT2ZTeDJ6R0dwbC9tYWpwZk9zS2tPcmtS?=
 =?utf-8?B?Nmd4TWVjd1lGZS9xS3h0VFV5OUE0Ulp1QWM4ODRrOWhMZGZ3UW5BdjJEbFRp?=
 =?utf-8?B?b3VLSWN3RTQ5ejF4QVh6OXYvRHU2U3kvUThla1pMQzM5UFJOVUZycFpPeURt?=
 =?utf-8?B?cUlhQW1QMjZTNzhYVTVDREtmemRxK24vcVJmU1A1Q0RFSWQ4LzQzTTVmd1VH?=
 =?utf-8?B?ekNzUFNjWDdhU1craHVCa1lDN2Fma3dhdHdYL0pjUFRUMmtnSUVTWitscU1F?=
 =?utf-8?B?SmpKbjdTbkFNbmF3bDFjZWY3NTFsdjZZQ1JIY1ErbEdTVjllZzJCbVA3Qmgw?=
 =?utf-8?B?cHh1TnVBLzdFVUpDQVdBRlJPdzJHaEdyd2xPZVVjTzZNeE1jUDNLL0pIZnJs?=
 =?utf-8?B?dUhJSEsyNWRRS0VQbVpQUUE5WC9HdTJCYnpEVmdjTytHWjg5TndBUkNBNlBl?=
 =?utf-8?B?cjU2cW9LdVpWa2RRZ2U4bEZPUldmVmgralRtOWUvd3JTckVpdXJ5ZmtsNm9V?=
 =?utf-8?B?SHNaczVCaFZtdWY5WkZPZkhWN3lxUkRQaThTRlNJeFZPd1ZnMldxUktaZXFq?=
 =?utf-8?B?WFRMVjNaR3c5MllBTDRDelFGU0Z5Y0hyTFNydnpJbS9pbGRSRk9yQm1HL1dO?=
 =?utf-8?B?WjBmM1c5di9GZEU5b1k4U05OZFo2ZmZIRVUwMXVzT2M0WXFLQUpxUFN3U1px?=
 =?utf-8?B?ZGFId1dsZGcwbzhPZk90Sm9PaVlNdjZJbm95UzdjQ0tJMzhyYzRIbExwV2l0?=
 =?utf-8?B?ZVZhNlRTRGUxcjhYbTBRNTlaYjZ4VFZSZFZGNDVybE42aERnKzJpcGFWaXBx?=
 =?utf-8?B?Z2Jad01UeHY0RjNtclBYb0RDRnE5Smc0VXdKUGlqNFBpN0I2clN0UEZoQVo2?=
 =?utf-8?B?ZnIrYTFkeDRvY21pWHRBa082REx3a1BxRjR0dXpPaVV4TVc4TXNGY09uRGlw?=
 =?utf-8?B?MkxMcWQ1OXd1dnRoMEIyOGN4QWI2Mi9YSDRTQzRXa1JZSUxmMDFQd2tUd21C?=
 =?utf-8?B?eUVqM3BQUmplVjQ0eWw4c2VUdnJ5aWcyZkRyaUprRm41YWlXSFZLRXVLbEVk?=
 =?utf-8?B?QzRTWlRwb2k3N3BDY2xMRnl1RWZHeGxDbTRreUE3QnJwMVg5Wi95bHBYb05n?=
 =?utf-8?B?MS95V2l0YUxlYVNBbTFzVGg3ZzZKak51TDg5QWpFN3l5cGFFR2Rtcmx6ZEd2?=
 =?utf-8?B?TTJPQThKWlBUWm1nZmZ0RUxpOHFCYlFaWHZoalRqUXN2aHZOMFJNN0dxVmdK?=
 =?utf-8?B?NHdBcUxTdWwwRU45TE5hQjNxSlE0L2NQSkhrNEx4UjFRbnc2a29sL2toVDls?=
 =?utf-8?B?clUxNTl4NEhLaVBDcWw0aTNqOGRiSjZUSzdMRi8xOHpVaDNzSmV5Nzcyb1hj?=
 =?utf-8?B?UGl5Q2FFS0JPT3J5QWZsK2x3cHJTSWVtcDdGejNhOVZuNVF6VkZrVVcwckdu?=
 =?utf-8?B?Q0hVZzkvZ2lIZ0RMZE16NlM5dmM1QWRBSjJCbDV3dGVvUDJPZ1VCMjhCSGV0?=
 =?utf-8?B?ZjBZdnpOdEQyRWIyWnNLQno1M3orcGplV1NrM2VCTXhaQXZFNGtrYkNhZkNq?=
 =?utf-8?B?aW5keERVb2pJWWh2QzBwZUlwdk9zZkc4L1MvOGhTY0o3ZFV0cU9sUT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7783af56-b69e-40d1-e04c-08de4b71eaf2
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2026 09:16:18.0067
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gbtTDFAI0/Up6j60k++8l0K1V2NYBdGCYr30ufYH0c3nV/NPAkXTRG9L4EJP+UjYm7B3Zhg1nc2CsRpmfK3gJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB9458

Hi Trond,

We’ve recently started seeing filesystem issues in our internal
regression runs, and we were able to bisect the problem down to
the following commit:

commit b1817b18ff20e69f5accdccefaf78bf5454bede2
Author: Trond Myklebust <trond.myklebust@hammerspace.com>
Date:   Thu Sep 4 18:46:16 2025 -0400

    NFS: Protect against 'eof page pollution'

    This commit fixes the failing xfstest 'generic/363'.

    When the user mmaps() an area that extends beyond the end of file, and
    proceeds to write data into the folio that straddles that eof, we're
    required to discard that folio data if the user calls some function that
    extends the file length.

    Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>


After this change, we intermittently see EXT4 checksum-related errors during boot.
A representative dmesg excerpt is below:

 [ 1908.365537] EXT4-fs warning (device vda2): ext4_dirblock_csum_verify:375: inode #263414: comm updatedb: No space for directory leaf checksum. Please run e2fsck -D.
 [ 1908.375449] EXT4-fs error (device vda2): __ext4_find_entry:1624: inode #263414: comm updatedb: checksumming directory block 0
 [ 1908.382985] EXT4-fs warning (device vda2): ext4_dirblock_csum_verify:375: inode #263414: comm updatedb: No space for directory leaf checksum. Please run e2fsck -D.
 [ 1908.389289] EXT4-fs error (device vda2): __ext4_find_entry:1624: inode #263414: comm updatedb: checksumming directory block 0
 [ 1909.598811] EXT4-fs warning (device vda2): ext4_dirblock_csum_verify:375: inode #423753: comm updatedb: No space for directory leaf checksum. Please run e2fsck -D.
 [ 1909.604308] EXT4-fs error (device vda2): htree_dirblock_to_tree:1051: inode #423753: comm updatedb: Directory block failed checksum
 [ 1909.958470] EXT4-fs warning (device vda2): ext4_dirblock_csum_verify:375: inode #423759: comm updatedb: No space for directory leaf checksum. Please run e2fsck -D.
 [ 1909.963825] EXT4-fs error (device vda2): htree_dirblock_to_tree:1051: inode #423759: comm updatedb: Directory block failed checksum
 [ 1909.985956] EXT4-fs warning (device vda2): ext4_dirblock_csum_verify:375: inode #303617: comm updatedb: No space for directory leaf checksum. Please run e2fsck -D.
 [ 1909.991371] EXT4-fs error (device vda2): __ext4_find_entry:1624: inode #303617: comm updatedb: checksumming directory block 0
 [ 1910.156415] EXT4-fs warning (device vda2): ext4_dirblock_csum_verify:375: inode #423761: comm updatedb: No space for directory leaf checksum. Please run e2fsck -D.
 [ 1910.161959] EXT4-fs error (device vda2): htree_dirblock_to_tree:1051: inode #423761: comm updatedb: Directory block failed checksum
 [ 1910.171364] EXT4-fs warning (device vda2): ext4_dirblock_csum_verify:375: inode #423735: comm updatedb: No space for directory leaf checksum. Please run e2fsck -D.
 [ 1910.177292] EXT4-fs error (device vda2): htree_dirblock_to_tree:1051: inode #423735: comm updatedb: Directory block failed checksum
 [ 1910.267721] EXT4-fs warning (device vda2): ext4_dirblock_csum_verify:375: inode #423744: comm updatedb: No space for directory leaf checksum. Please run e2fsck -D.
 [ 1910.281838] EXT4-fs error (device vda2): htree_dirblock_to_tree:1051: inode #423744: comm updatedb: Directory block failed checksum
 [ 1910.476906] EXT4-fs warning (device vda2): ext4_dirblock_csum_verify:375: inode #423751: comm updatedb: No space for directory leaf checksum. Please run e2fsck -D.
 [ 1910.482403] EXT4-fs error (device vda2): htree_dirblock_to_tree:1051: inode #423751: comm updatedb: Directory block failed checksum

The issue has so far only been observed in tests that use a nested VM setup.
It does not reproduce deterministically, roughly half of the nested
VM boots trigger the problem.

Would you mind taking a look or pointing us in the right direction?
Please let us know if additional information, testing,
or instrumentation would be helpful.

Thanks,
Mark

