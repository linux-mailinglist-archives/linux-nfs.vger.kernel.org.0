Return-Path: <linux-nfs+bounces-10931-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B24ACA74182
	for <lists+linux-nfs@lfdr.de>; Fri, 28 Mar 2025 00:27:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EF5617982A
	for <lists+linux-nfs@lfdr.de>; Thu, 27 Mar 2025 23:27:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B05A31E1DF2;
	Thu, 27 Mar 2025 23:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="VcAbIsuI"
X-Original-To: linux-nfs@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2106.outbound.protection.outlook.com [40.107.212.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 171431DC99E;
	Thu, 27 Mar 2025 23:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743118023; cv=fail; b=QqtZd7/nzjy+KzGgNC6bzxF8B6MTw/WpIO4+qoKJneqedyU2H/vRBg243bAkTDLIe9ks1Qvjt9pyzeL4prqQnQQ8lAuD/YxhNF3CG96hxDZOO0DUi0vZitgJ2ECvsgTgYwI89bWkTy8WdBy92hDVYvSINQlgDDq6NHFaL69tvPs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743118023; c=relaxed/simple;
	bh=0WFQWkHJI+cx9HOBYanbNFFRP5IcKqBlcSWkpxcTm84=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Pv//CPR6gGaLUe6ecjmz08IhEKnN9bZTgDNUX9XbVTzlP6oFexbJgzDHZs25ViM/pyWKK4XAFydqrKg0EPU9mcWQHFyu3bpghEaH/tkMN/u/jsKMyQ3ysmVg81TrCqraU2CEvX//mVxv2pq2XWKgD1hKeJdDX+zjDpsULV7oWQA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=VcAbIsuI; arc=fail smtp.client-ip=40.107.212.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aFzd6BOJ8PmDk/OBhHuNNkEFkpwtFfoKQ61+cLlk6VbVVlo5SwamIA4Zxy9k1nWVYVBwn+ytMU0LTr5AO4q3wNf2WdOj7XSvu1wOkpPrBGmJDHKdTiWooumDUHJ7whh+RVFyf+nTCBLxfDENfzM14hUeOnJgfdlCsZCuk0dCY2UQ8UUW8rrxABMXe3JWz9oQ8jQFa7fgt5MYmqKpOXgnXjw5hRk/NsGiQlsJ62FeCut3f58JM7Fz5uoZHukRpJp3XrbCdOhrnr97+OC559dSSryY/gQ6Z0c/7y71G+V1xyMSwmumEfI9g8SvMBTTSnemENgl5du59NHV9txIQKlVYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0WFQWkHJI+cx9HOBYanbNFFRP5IcKqBlcSWkpxcTm84=;
 b=rLYkHMgA9T960/wAtiDP93HHj7Z0bjsBz69agKyeZGye/pTZrNS1mvMIfc+DD7NJCJyVHizrRLJb9ZMHdZTN4MmITbbWCQqp1BeJeuO1Y8oUIbG2bbbnADFoX2B3HUj0FWo3x1GM3hhHgG+3CcKbURe7aWIgzozW2JgqoJbdDiFIDiUvQWnLfJeaV3oymVSDtE+308yccx2+vnIh9gVYqyjLKEfCCu122mpK9HR9MTQZ6llO1LxEXg8bsTOw8IpiOqWq853PJht7zESiBoPVLBv/rGNFO8YODY+wpjHefer12lI9FDZwe3wrQnFbjvgNfqX30Cc3/WX4s4msQFGiMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0WFQWkHJI+cx9HOBYanbNFFRP5IcKqBlcSWkpxcTm84=;
 b=VcAbIsuILCzMH3qunMMfGndFmCQev/4a9q1bQtuX438Ns03xNUgRQ9Y7DpJXV/O03/vljTXiy0LwBfhaEaaE4+w/CT8/wDaB86QiF55aR8LPR0EDR1dsz28oWYDI5u8yOSN67/m/pIHnOHKslHtgimTzxgIrCCbTdTxBTelAA+A=
Received: from DM8PR13MB5079.namprd13.prod.outlook.com (2603:10b6:8:22::9) by
 CH0PR13MB4652.namprd13.prod.outlook.com (2603:10b6:610:c8::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.44; Thu, 27 Mar 2025 23:26:55 +0000
Received: from DM8PR13MB5079.namprd13.prod.outlook.com
 ([fe80::3312:9d7:60a8:e871]) by DM8PR13MB5079.namprd13.prod.outlook.com
 ([fe80::3312:9d7:60a8:e871%5]) with mapi id 15.20.8534.040; Thu, 27 Mar 2025
 23:26:55 +0000
From: Trond Myklebust <trondmy@hammerspace.com>
To: "erhard_f@mailbox.org" <erhard_f@mailbox.org>, "linux-nfs@vger.kernel.org"
	<linux-nfs@vger.kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: 'refcount_t: addition on 0; use-after-free.' and 'refcount_t:
 underflow; use-after-free.' at fetching files via nfs (Talos II, kernel
 6.13.8)
Thread-Topic: 'refcount_t: addition on 0; use-after-free.' and 'refcount_t:
 underflow; use-after-free.' at fetching files via nfs (Talos II, kernel
 6.13.8)
Thread-Index: AQHbn2qpmAW7E6D7J0GiSkR06MhXNbOHoJ0A
Date: Thu, 27 Mar 2025 23:26:55 +0000
Message-ID: <f22702d0d80a3f2c157bd25209517af7788610a8.camel@hammerspace.com>
References: <20250327234607.2bc4aaea@yea>
In-Reply-To: <20250327234607.2bc4aaea@yea>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR13MB5079:EE_|CH0PR13MB4652:EE_
x-ms-office365-filtering-correlation-id: 20e05e66-051d-4bc5-5b8c-08dd6d86dd09
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?UmZ1TzJyZGdpWXh6OWF6TmNDOWNvS2FNOUtDbldjTmt0Um0rck1LZXEzc1pa?=
 =?utf-8?B?Wnk0KzltbUZSa1hUSEpGY2I3emFESUFkM0VCRkdaV0dFdFFQY095cFB2WlpQ?=
 =?utf-8?B?Z2pFMmFrTnpXZk16VFJIOVZOUkVJUmtUUEE5RlBlWTE2L1hMWFUxVUpMenNz?=
 =?utf-8?B?SU1nNTIyRkFkMFVmcWI0c0ZOSkNueUhKU0JVM2NrV1lKUEEwcnZ1dHgzeGtX?=
 =?utf-8?B?QStaVmNEbS9hMm91L3dTdFhtMFZtNzlMMlVINXV1MmdlNGl0dHBja1JyMHo1?=
 =?utf-8?B?aUpoT0ZKU2hTcnM0bSt3R3kwUmVXSWxOTVYvTlcvZmViWC9SL3RSVklTRFNF?=
 =?utf-8?B?UG1XWkovd2cxT0FDUXRDa3Y3d3pjR3U4ZWxtcGNSc0s3eUNvMktZbDRQQXZj?=
 =?utf-8?B?TG80QXF6K1pwUjlIUitIQ2FXSHB1dXRQQ0FpbEJOSWhMUFJwSUg3Y0Uva1Zs?=
 =?utf-8?B?RlBNSi9EczBCU052Z1QzREMvamxya2JhWTRVcGN2dUhNbHljMFVxQ3l0WnNp?=
 =?utf-8?B?ejVuUXZJVThCdm1ubXo1U3BUMXVqemJaQldwNnhxTldrM2U1TnRiWGxDL3hx?=
 =?utf-8?B?WE9KbEI5UVVqQy9HQzdvNkIyMnFCekRRL2g3Vmc5eHNvQi96bDF5K2FKOWl0?=
 =?utf-8?B?MXZCeHlUakVjRmcxdS9FVFQ0bERqYXdNc1ZjOWRLREZBNVlscTBVL1lPL0l5?=
 =?utf-8?B?ckNFaWxaeTJVTjYycDY5SjE1cVhLYlZZNVh4dEdFM3ZQc1FjelA2MTIza0hz?=
 =?utf-8?B?ZE54RTRzbTRFaHlBek9Kck9kQzBvc1A1WUxpZmlHVDhPdFhLT0NpUWZ1OUUv?=
 =?utf-8?B?NzhtUHpoMHgvNjF3a2x0M2Nra2xJeGdaZ2c4TEpiTjNpZUlqNUFJMzZ3QXlQ?=
 =?utf-8?B?R24vK0JhMXZuelpYcU5hbUw1VDcwOThPcE5TakdiOVVVSHhTR21naUFFQlNo?=
 =?utf-8?B?Ymt6Vm5GdEE0T1g4NmRLNFl4WjdmcE1zM0ZmL3Z6RHVWRzZMcURSVkhBcllI?=
 =?utf-8?B?ZS8xbXZCUWEwaWk4LzJRWTZKQVJtZStNS2IrQjBUTEQ5elp6MkFBWFRscklo?=
 =?utf-8?B?aXhkZnhZWUgySGs5NEljZEtTUnhlZ05LSXN5aG1KWnVsWDBqaVJQa2tUSHZr?=
 =?utf-8?B?Q0g2Z0dZQkhUTWRzK2xxbEwxN09VYXlMa0RWUTBpVHVaQmdzWi80R0JKSVRW?=
 =?utf-8?B?QkU3OUxxK2oxWjVwWno5TGloS3JDamRxMGd4VHg3ellsS3dXbEZQRmRnMlY4?=
 =?utf-8?B?RVpYQUtaWnhBZlA4L09RUGRrMUJRbFRSRld6NDcrbE1iMk5RckhoMGE5SDhn?=
 =?utf-8?B?VkxnMkdORW1VbE80alQwd1lzNUZSME9Xd3ErRTNnd21GdXdLVk5pWkJReXh0?=
 =?utf-8?B?bzJkUFRCS0FhbE45a0cvM1VGS3R6MExNWjhNSWlTV3FXYlNrdE55dWh5S2dn?=
 =?utf-8?B?SCtnTS94N0xPeEd5bXIzTWJOYTc4RGtnWm5UNEFmbDlNMkdEVmZ4RFd2RHkr?=
 =?utf-8?B?TStaNzVkVVh6RVd1UDY5aWs0eEJxb0ZkVTRHNHhva0VHTitXTkhQMEFWcVJL?=
 =?utf-8?B?Q1RMUmVhaXJtOEovV2FZUnF3WHU3d3N2eDc4c01VY0VJN1NsaVVCZFBRWC9k?=
 =?utf-8?B?WG9oeWlBd2ZiOW1LVUV6RU5pa2VMSDdYcnNkaFRUVlJPL2tHODBoSGpxbXIr?=
 =?utf-8?B?UDArTElDT3VYNERWYis0Y2pOa09CSWErZVMwUnZRa3lac3N3elpVYlp6eDN5?=
 =?utf-8?B?VmM0RGdoQzdTenhFUzdVaUw3bTA2V00xL2hHWVMvbkJPS2ptSk1GMlR4MlpK?=
 =?utf-8?B?TXUydFlmblpSVmZtVW03blhLK0Q2akxUZWpEU21CVGdzNDcxSllnZUdoZG1J?=
 =?utf-8?B?V1dHdjY2OUF2VGlzaUx2cUJWdEpSNkJnRThRRkFCQnNlaVNqTVdIOElKMXdw?=
 =?utf-8?B?cktSUWdhZTFVYjJPSDlJRzJ4c1M5MzNRZU5GOXV0RFplbHFnN1ZWT2dvRHJP?=
 =?utf-8?B?RzFHamRaMm53PT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR13MB5079.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZDRrcUIvWi8zd1N5SmVndWw4R2wrMUJVK20yZ0FPVU9Md3hwN3ZlNkExcnpU?=
 =?utf-8?B?ekpaVEJZek95aDFsV3dUdnZQbERBakhFRktNWGhIc1RvMHR0V2lKT3J0NFNN?=
 =?utf-8?B?cnFwWHhHRlhkeDF2ZlJpTGFLV2RSRkR6cHFPQzc4Y0JJSVhYL1k0VThIWjZj?=
 =?utf-8?B?KzNtSXlVdElKaWd3Q2xIeXpwbzloeWJvOXYzb3RVZkE0UVQ3NEtOaEtmZ2J2?=
 =?utf-8?B?VG9UU2piTGhzc0NIUmpnTmJuajdwNE1nU3Eza1J1SzA2MnBVRlk5MnBzelBk?=
 =?utf-8?B?bVZDNnllVHc4bUlkZzlRVk9FalJXUGExRW14djg0eWZHZHhMR3haeU45QWNi?=
 =?utf-8?B?WGFkejU1Q2FwVFQ1dTEzUG5JN0V2c091dnRFcndzb0xTMXJHK25kYUVneC85?=
 =?utf-8?B?SW9oSG8yVllQcWdWeXhUaHVJcTBlWUNXMXVyaHJ1OVkyNU9ETFBSY0FCVjZH?=
 =?utf-8?B?K0c1VTRzQzFYallOMTNEc0dIc01KV0lpUGdVcEpZUkVrRXViVHB6NllVaVQx?=
 =?utf-8?B?eDgwdlA0Rkl1TVRlT1U5Yi9YR0Vockhyak5IaUhLWFdDb2R0L1ZocVN2WFpV?=
 =?utf-8?B?ZE5Ec3Q1c3hBaFhIU2N3aGRSTWExOG1ZMk1MMjR0WDZERmxzc3c2TUpidkZq?=
 =?utf-8?B?bDlNaW5mTXF6aHEyMTE4YVhMQWJrVSsvYVhXenZaS2hhWFRBcjRnVDVleUha?=
 =?utf-8?B?OEE2NlBBdlRpclRzdEdYZVU4aHN4RFpZQzByVVovbVRXVmdkbmZZYVJ5NWYy?=
 =?utf-8?B?dlRRdEdnOVpoT2wzNzVqSWkvanpTL241c3BwbzRwVWRtdWxPTWRCdGs0OVZ4?=
 =?utf-8?B?cGZyZVdyZXBnWm9pRUFQSmdnUlI5endXaXpEOER3NWVzSitKMi8vSlNoRUR0?=
 =?utf-8?B?ZnF0Y2grRllnZWNKVXJSdC83WDRZYXk3WG5FZVBXR0hyTTFFL2pCV1FBRk1F?=
 =?utf-8?B?bDdIUjdjMW9ZdzN2anVvQzFYek52UCtLY21ORUNaY29xaTRRUm1pMnVzSzdO?=
 =?utf-8?B?MDFSRC85U0luS0JwM1c5cGhZZVdDT0tjbjd3TVM2c0lqWXJIRlNiTWJHUy9i?=
 =?utf-8?B?SnIzdzZ1dmxCNW9HRExPTFNGZW5KcFJjRnNyUU1tMi9QdGtHNjBDaFNYdWZR?=
 =?utf-8?B?Q3g4SHhkbWJxMVM3Y3V4ZzNyS0Y5Q1EvSm9yRWVnM1RYUEc5R3BZTzYzTnc4?=
 =?utf-8?B?S0NZNnBZYmpOYzFCaEVkMWtER3lSZXdFZVJIWm9ocERXNFkwbTk5ZEhUcDFH?=
 =?utf-8?B?VkJLVnBMZ2VWMFBuRGpVTDl2cjMxT05kUjVHc016SDFlZGlVRTJBTUpzUGpG?=
 =?utf-8?B?VlN4K1lZV2dzTE1idHFCa2FhdFZxNCtzK1NpUzNLdTl2VjYvVGhZL1FsYVlD?=
 =?utf-8?B?cTNUN1JXNUErVFFEWnRscWx4TmlMRW9vaTc3YkpTUGFIZTczNDAyempneDA4?=
 =?utf-8?B?c2JkZ2pZNmtDdnpWblBtS1J6aUtJb1lQdU5BbDJuMmF4T0t5SFBQT1hQMHBM?=
 =?utf-8?B?Q3F2TUFsbE1UUVpTdGt0VUc5L0JnVlpKN2JUT1hJOS9xVXpHamRRRWw3aHBV?=
 =?utf-8?B?bEFFQStsd2Z6My9VTFVOdVI2OGxxbUJxcGhDaWZRVitiZ1NZUEVVNjAvZ3Mx?=
 =?utf-8?B?QVZ6NDE3WUFKZU1TYXI4YU9EWjFIRkx0cTEvWkp1OUI5WU9ZVzNOd1JQWkRB?=
 =?utf-8?B?NFQ5dFp0TGR1NFFyV3VYY3hqcVo2UjZEWDJTQlllYkk0amtxc01tbE13N1Rp?=
 =?utf-8?B?cndwOWtNY0k0Ly8rNzZrdTk0VGJPbUJYazlMNy9tNjBzOXkxUU5BVkV2anEw?=
 =?utf-8?B?aXdPa1dtZFJqRUJEcWNYanJ6UDNqMVNoSmQyWDZQZk5EdTlsR1ROYUtWUFUx?=
 =?utf-8?B?N1FjMDNGZUQxWmI0SFJhUGU5Q2xUaGFUc3Z2bTBSdEhDVmpjUGtjdEs1MitQ?=
 =?utf-8?B?ckltVzRPazNkeE4vWjJmbFQ0b1VhMjFKQU5DVngwTkI3QTY3ZzYva2VleDRz?=
 =?utf-8?B?S1cvQVFBMFVsdFFkV0d1Q25JM0ZsbWNFUzRkV3dxcEVNQlFGNUdBUkQ2Q1Av?=
 =?utf-8?B?SlM0VTY4U1JXRGQ3b1VxczR1V0ZmL2FQMFc0OWJxdGp2OHFwdStUMXJmN3Qv?=
 =?utf-8?B?S1c4MUdGYWJHRzFkYWgrNDRCYW5RK0p4TEdiZGd6eVdCUmFyVUo3RDBZOUtJ?=
 =?utf-8?B?UHozdklZNmU3N2pjLzNFb2J3MitYdk5EQXYvMHFMcVJBL3l5aG03MENaL1Ar?=
 =?utf-8?B?UU5zcWJLZ29OZC8zZVlJdU1iZE5RPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4D8E1A1AFBB2D3449AD73C325A9C0FA8@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR13MB5079.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20e05e66-051d-4bc5-5b8c-08dd6d86dd09
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2025 23:26:55.7381
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uLUGNwbVasXeulgod4V2X5HBQxvOUfEyWz6POSyBctl03czjnKexyVhUNaIbE8FoyKpmUwsFCqwcr68FDcyrsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR13MB4652

T24gVGh1LCAyMDI1LTAzLTI3IGF0IDIzOjQ2ICswMTAwLCBFcmhhcmQgRnVydG5lciB3cm90ZToN
Cj4gR3JlZXRpbmdzIQ0KPiANCj4gTm90aWNlZCB0aGF0IG5mcyAncmVmY291bnRfdDogYWRkaXRp
b24gb24gMDsgdXNlLWFmdGVyLWZyZWUuJyBhbmQNCj4gJ3JlZmNvdW50X3Q6IHVuZGVyZmxvdzsg
dXNlLWFmdGVyLWZyZWUuJyBhZnRlciBzb21lIGhvdXJzIG9mIGJ1aWxkaW5nDQo+IHBhY2thZ2Vz
IG9uIG15IFRhbG9zIElJLiBJdCBmZXRjaGVzIHRoZSBzb3VyY2UgdGFyYmFsbHMgZnJvbSBteSBv
dGhlcg0KPiBzeXN0ZW0gdmlhIGEgc2hhcmVkIG5mcyA0IHBhcnRpdGlvbi4gDQo+IA0KPiBbLi4u
XQ0KPiAtLS0tLS0tLS0tLS1bIGN1dCBoZXJlIF0tLS0tLS0tLS0tLS0NCj4gcmVmY291bnRfdDog
YWRkaXRpb24gb24gMDsgdXNlLWFmdGVyLWZyZWUuDQo+IFdBUk5JTkc6IENQVTogMzMgUElEOiA1
MDIyMSBhdCBsaWIvcmVmY291bnQuYzoyNQ0KPiByZWZjb3VudF93YXJuX3NhdHVyYXRlKzB4MTk0
LzB4MjMwDQo+IE1vZHVsZXMgbGlua2VkIGluOiBtZDUgbWQ1X3BwYyBzaGE1MTJfZ2VuZXJpYyBj
bWFjIGNpZnMgY2lmc19hcmM0DQo+IG5sc191Y3MyX3V0aWxzIGNpZnNfbWQ0IHJwY3NlY19nc3Nf
a3JiNSBhdXRoX3JwY2dzcyBuZnN2NA0KPiBkbnNfcmVzb2x2ZXIgbmZzIGxvY2tkIGdyYWNlIHN1
bnJwYyBhZl9wYWNrZXQgaW5wdXRfbGVkcyBldmRldg0KPiBjZmc4MDIxMSByZmtpbGwgaGlkX2dl
bmVyaWMgdXNiaGlkIGhpZCByYWRlb24geGhjaV9wY2kNCj4gZHJtX3N1YmFsbG9jX2hlbHBlciB4
aGNpX2hjZCBpMmNfYWxnb19iaXQgYmFja2xpZ2h0IGRybV90dG1faGVscGVyDQo+IGN0ciBvZnBh
cnQgdHRtIHh0cyBjYmMgYWVzX2dlbmVyaWMgbGliYWVzIHVzYmNvcmUgcG93ZXJudl9mbGFzaA0K
PiB2bXhfY3J5cHRvIGRybV9kaXNwbGF5X2hlbHBlciBnZjEyOG11bCBpYm1wb3dlcm52IG10ZCBh
dDI0IHVzYl9jb21tb24NCj4gaHdtb24gcmVnbWFwX2kyYyBvcGFsX3ByZCB6cmFtIHBvd2VybnZf
Y3B1ZnJlcSBsb29wIGZ1c2UgZG1fbW9kDQo+IGNvbmZpZ2ZzDQo+IENQVTogMzMgVUlEOiAyNTAg
UElEOiA1MDIyMSBDb21tOiBlbWVyZ2UgVGFpbnRlZDogR8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCBUwqANCj4gNi4xMy44LWdlbnRvby1QOSAjMQ0KPiBUYWludGVkOiBbVF09UkFORFNU
UlVDVA0KPiBIYXJkd2FyZSBuYW1lOiBUMlA5RDAxIFJFViAxLjAxIFBPV0VSOSAweDRlMTIwMiBv
cGFsOnNraWJvb3QtYmMxMDZhMA0KPiBQb3dlck5WDQo+IE5JUDrCoCBjMDAwMDAwMDAwODE4ZGU0
IExSOiBjMDAwMDAwMDAwODE4ZGUwIENUUjogMDAwMDAwMDAwMDAwMDAwMA0KPiBSRUdTOiBjMDAw
MDAwMGM1ZDRiNzcwIFRSQVA6IDA3MDDCoMKgIFRhaW50ZWQ6IEfCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgVMKgwqANCj4gKDYuMTMuOC1nZW50b28tUDkpDQo+IE1TUjrCoCA5MDAwMDAw
MDAwODJiMDMyIDxTRixIVixWU1gsRUUsRlAsTUUsSVIsRFIsUkk+wqAgQ1I6IDQ0MDQ0MjIywqAN
Cj4gWEVSOiAwMDAwMDAwYQ0KPiBDRkFSOiBjMDAwMDAwMDAwMTM0Mzk4IElSUU1BU0s6IDAgDQo+
IEdQUjAwOiBjMDAwMDAwMDAwODE4ZGUwIGMwMDAwMDAwYzVkNGJhMTAgYzAwMDAwMDAwMTEyZjEw
MA0KPiAwMDAwMDAwMDAwMDAwMDJhIA0KPiBHUFIwNDogMDAwMDAwMDBmZmZlZmZmZiBjMDAwMDAw
MGM1ZDRiN2I4IGMwMDAwMDAwYzVkNGI3YjANCj4gMDAwMDAwMDdmZDBiODAwMCANCj4gR1BSMDg6
IDAwMDAwMDAwMDAwMDAwMjcgYzAwMDAwMDdmZjFiYzIxMCAwMDAwMDAwMDAwMDAwMDAxDQo+IDAw
MDAwMDAwNDQwNDQyMjIgDQo+IEdQUjEyOiBjMDAwMjAwN2ZhZTg4MjI4IGMwMDAwMDA3ZmZmZTk2
MDAgZmZmZmZmZmZmZmZmZmZmZg0KPiAwMDAwMDAwMDAwMDAwMDAxIA0KPiBHUFIxNjogMDAwMDNm
ZmY4ZWQ3OWM0MCAwMDAwMDAwMDAwMDAwMDAwIDAwMDAzZmZmOGRkZjRiZDANCj4gMDAwMDNmZmY4
ZWQ3OWMzOCANCj4gR1BSMjA6IDAwMDAzZmZmOGVkNzljNDAgMDAwMDNmZmY4ZWI5Mjg0MCAwMDAw
M2ZmZjhlZDc5YzQ4DQo+IDAwMDAwMDAwMDAwMDAwYTcgDQo+IEdQUjI0OiAwMDAwM2ZmZjhlYTUw
ZjIwIDAwMDAzZmZmY2QwODUzYjggMDAwMDAwMDAwMDAwMDAwMQ0KPiBjMDAwMDAwNTgxZGY0ODc4
IA0KPiBHUFIyODogYzAwMDAwMDAyMTkzNTA4OCBjMDAwMDAwMGNiYjJmN2EwIGMwMDAwMDA0YzBj
Mzc0ZTgNCj4gYzAwMDAwMDBjYmIyZjc0MCANCj4gTklQIFtjMDAwMDAwMDAwODE4ZGU0XSByZWZj
b3VudF93YXJuX3NhdHVyYXRlKzB4MTk0LzB4MjMwDQo+IExSIFtjMDAwMDAwMDAwODE4ZGUwXSBy
ZWZjb3VudF93YXJuX3NhdHVyYXRlKzB4MTkwLzB4MjMwDQo+IENhbGwgVHJhY2U6DQo+IFtjMDAw
MDAwMGM1ZDRiYTEwXSBbYzAwMDAwMDAwMDgxOGRlMF0NCj4gcmVmY291bnRfd2Fybl9zYXR1cmF0
ZSsweDE5MC8weDIzMCAodW5yZWxpYWJsZSkNCj4gW2MwMDAwMDAwYzVkNGJhNzBdIFtjMDA4MDAw
MDBlMWVjNTc4XQ0KPiBuZnNfc3RhcnRfZGVsZWdhdGlvbl9yZXR1cm5fbG9ja2VkKzB4MTQwLzB4
MTYwIFtuZnN2NF0NCj4gW2MwMDAwMDAwYzVkNGJhYjBdIFtjMDA4MDAwMDBlMWVlMjBjXQ0KPiBu
ZnM0X2lub2RlX3JldHVybl9kZWxlZ2F0aW9uKzB4MjQvMHhmMCBbbmZzdjRdDQo+IFtjMDAwMDAw
MGM1ZDRiYWUwXSBbYzAwODAwMDAwYzlhZDA4OF0gbmZzX2NvbXBsZXRlX3VubGluaysweDgwLzB4
MjUwDQo+IFtuZnNdDQo+IFtjMDAwMDAwMGM1ZDRiYjMwXSBbYzAwODAwMDAwYzk5NTViY10gbmZz
X2RlbnRyeV9pcHV0KzB4NTQvMHhlMCBbbmZzXQ0KPiBbYzAwMDAwMDBjNWQ0YmI2MF0gW2MwMDAw
MDAwMDA0ODhhOThdIGRlbnRyeV91bmxpbmtfaW5vZGUrMHhlOC8weDFlMA0KPiBbYzAwMDAwMDBj
NWQ0YmI5MF0gW2MwMDAwMDAwMDA0ODk4ZjBdIF9fZGVudHJ5X2tpbGwrMHhiMC8weDI4MA0KPiBb
YzAwMDAwMDBjNWQ0YmJkMF0gW2MwMDAwMDAwMDA0ODliZjhdIGRwdXQrMHgxMzgvMHgyOTANCj4g
W2MwMDAwMDAwYzVkNGJjMTBdIFtjMDAwMDAwMDAwNDVlZmUwXSBfX2ZwdXQrMHgxNzAvMHgzYzAN
Cj4gW2MwMDAwMDAwYzVkNGJjNjBdIFtjMDAwMDAwMDAwNDU4YzI4XSBzeXNfY2xvc2UrMHg0OC8w
eGEwDQo+IFtjMDAwMDAwMGM1ZDRiYzkwXSBbYzAwMDAwMDAwMDAyOTIwNF0NCj4gc3lzdGVtX2Nh
bGxfZXhjZXB0aW9uKzB4MWE0LzB4MzcwDQo+IFtjMDAwMDAwMGM1ZDRiZTUwXSBbYzAwMDAwMDAw
MDAwYzI3MF0NCj4gc3lzdGVtX2NhbGxfdmVjdG9yZWRfY29tbW9uKzB4ZjAvMHgyODANCg0KRG9l
cyB0aGUgZm9sbG93aW5nIHBhdGNoIGZpeCB0aGUgaXNzdWUgZm9yIHlvdT8NCg0KQ2hlZXJzDQog
IFRyb25kDQoNCjg8LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tDQpGcm9tIDYwODRjZTI2ZTYzM2MxNzExNWE2OTIxMjBjZWFhOTU2
NDg3ZGQzMjUgTW9uIFNlcCAxNyAwMDowMDowMCAyMDAxDQpNZXNzYWdlLUlEOiA8NjA4NGNlMjZl
NjMzYzE3MTE1YTY5MjEyMGNlYWE5NTY0ODdkZDMyNS4xNzQzMTE3ODA0LmdpdC50cm9uZC5teWts
ZWJ1c3RAaGFtbWVyc3BhY2UuY29tPg0KRnJvbTogVHJvbmQgTXlrbGVidXN0IDx0cm9uZC5teWts
ZWJ1c3RAaGFtbWVyc3BhY2UuY29tPg0KRGF0ZTogVGh1LCAyNyBNYXIgMjAyNSAxOToyMDo1MyAt
MDQwMA0KU3ViamVjdDogW1BBVENIXSBORlN2NDogQ2hlY2sgZm9yIGRlbGVnYXRpb24gdmFsaWRp
dHkgaW4NCiBuZnNfc3RhcnRfZGVsZWdhdGlvbl9yZXR1cm5fbG9ja2VkKCkNCg0KQ2hlY2sgdGhh
dCB0aGUgZGVsZWdhdGlvbiBpcyBzdGlsbCBhdHRhY2hlZCBhZnRlciB0YWtpbmcgdGhlIHNwaW4g
bG9jaw0KaW4gbmZzX3N0YXJ0X2RlbGVnYXRpb25fcmV0dXJuX2xvY2tlZCgpLg0KDQpTaWduZWQt
b2ZmLWJ5OiBUcm9uZCBNeWtsZWJ1c3QgPHRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20+
DQotLS0NCiBmcy9uZnMvZGVsZWdhdGlvbi5jIHwgMyArKy0NCiAxIGZpbGUgY2hhbmdlZCwgMiBp
bnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQoNCmRpZmYgLS1naXQgYS9mcy9uZnMvZGVsZWdh
dGlvbi5jIGIvZnMvbmZzL2RlbGVnYXRpb24uYw0KaW5kZXggMzI1YmEwNjYzYTZkLi44YmRiYzRk
Y2E4OWMgMTAwNjQ0DQotLS0gYS9mcy9uZnMvZGVsZWdhdGlvbi5jDQorKysgYi9mcy9uZnMvZGVs
ZWdhdGlvbi5jDQpAQCAtMzA3LDcgKzMwNyw4IEBAIG5mc19zdGFydF9kZWxlZ2F0aW9uX3JldHVy
bl9sb2NrZWQoc3RydWN0IG5mc19pbm9kZSAqbmZzaSkNCiAJaWYgKGRlbGVnYXRpb24gPT0gTlVM
TCkNCiAJCWdvdG8gb3V0Ow0KIAlzcGluX2xvY2soJmRlbGVnYXRpb24tPmxvY2spOw0KLQlpZiAo
IXRlc3RfYW5kX3NldF9iaXQoTkZTX0RFTEVHQVRJT05fUkVUVVJOSU5HLCAmZGVsZWdhdGlvbi0+
ZmxhZ3MpKSB7DQorCWlmIChkZWxlZ2F0aW9uLT5pbm9kZSAmJg0KKwkgICAgIXRlc3RfYW5kX3Nl
dF9iaXQoTkZTX0RFTEVHQVRJT05fUkVUVVJOSU5HLCAmZGVsZWdhdGlvbi0+ZmxhZ3MpKSB7DQog
CQljbGVhcl9iaXQoTkZTX0RFTEVHQVRJT05fUkVUVVJOX0RFTEFZRUQsICZkZWxlZ2F0aW9uLT5m
bGFncyk7DQogCQkvKiBSZWZjb3VudCBtYXRjaGVkIGluIG5mc19lbmRfZGVsZWdhdGlvbl9yZXR1
cm4oKSAqLw0KIAkJcmV0ID0gbmZzX2dldF9kZWxlZ2F0aW9uKGRlbGVnYXRpb24pOw0KLS0gDQoy
LjQ5LjANCg0KDQotLSANClRyb25kIE15a2xlYnVzdA0KTGludXggTkZTIGNsaWVudCBtYWludGFp
bmVyLCBIYW1tZXJzcGFjZQ0KdHJvbmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbQ0KDQoNCg==

