Return-Path: <linux-nfs+bounces-2907-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 241FB8AC19E
	for <lists+linux-nfs@lfdr.de>; Mon, 22 Apr 2024 00:15:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6B19280DBE
	for <lists+linux-nfs@lfdr.de>; Sun, 21 Apr 2024 22:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B639B41C72;
	Sun, 21 Apr 2024 22:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="JTZISqw4"
X-Original-To: linux-nfs@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2097.outbound.protection.outlook.com [40.107.237.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 272EDD2FF
	for <linux-nfs@vger.kernel.org>; Sun, 21 Apr 2024 22:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.97
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713737705; cv=fail; b=YIkwljct7a7VPOADBXeBt/pILEpeFs6+66AZqh9dWBs+kYYPI/sisw7N+FLcSHxMMhYn4UyxZlv0DvuvQvUNYMc1A3IEqpw0AGm5t4EHFKj4cNtcGWb9MUXnS3ogjr2Cer8WfZtdHLT/qr8yMOhfYWTY6n+ak5VT/+8O2xUtYCs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713737705; c=relaxed/simple;
	bh=RFRtrROi6H7hxk3SsFXoS6qkuq1Y5xyeiIUp+8xnMCE=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QQ46fd/eXah6NNAFirGi90ripzzgGDFlE4qb571ezs5OFUlbHj0xzjCLjis5uVdofBQ2xg/OsBN8ymT/vQ5gt35Dzw/XveZLi7Lu2xyTZLIvaBSc2yU4r7b7haD77EoEDJRZnnNeT/+VeTeHHgw5P5+MQxnYCIvD1UwfRov9PWg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=JTZISqw4; arc=fail smtp.client-ip=40.107.237.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DdF+UXG5dEAJ1DGFLMRviqpO7qvNhbrKD2jqw4A88aFiOOQ0XRSe1FbTJInMeI1vytP2wl5DRqIacHZgDMI0VSGYtwH7kfJuWlQ6i646HH4sabAry87KoDwIsmXWpn3o/V/nk1QRLefWIM4ke5KtxK23YSZdcyUEjkCHZCTs8X9qjjk7+Xh28O/yRg6i3xGi0jZGtyBXI7ncFA310nrXtBIHNRPJ7KmZHU6PW0Ppwk77pyYKoJ2kZsy3mxw/rmTzDMEp/BGahFrVXdDUr+JnapWBzNBov+YqJatq7Qn958tYnu9ke8WYTnxIpXLoR5/CIWhXKBV+/5xWalSJiTUlUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RFRtrROi6H7hxk3SsFXoS6qkuq1Y5xyeiIUp+8xnMCE=;
 b=jr7kerwbNRVP4Z0uFmY+umKTmb3MCqO4spM0f0hHSldSojTb6U8dodQYUOoinnt4qKHeSQ0YwAc1M4G9N0U/6DNK4kfAfLwm75YxmjCGWe2fw7E2dPTKiARaejn/hNYRKLBxsjIW1eaBBwrBI/9y8dCVPTpoHlbAVlNoQdhMbk6cs73P637gqVLUzNRm55gN7YI/jtAr0aXS5nikFflOTwb20/Zo0eGyexyf/o1ZwigR02/Qa9QxORRNC6JEFEr8zXI1a4sW0nZAysRQAmH9S+wc5wivqEFE8nTv/dWYap2L/xBFR2M+BIa9huIhqH04l4B59L7+5M1/F43U0uf10A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RFRtrROi6H7hxk3SsFXoS6qkuq1Y5xyeiIUp+8xnMCE=;
 b=JTZISqw4s02VEAc3ePWR7THirQKagGaD7Ix0zq2b4X8fe8S1QI8vpyzgVkXeZHionqeBSyTTClwK/ZiBOFhKdqUCT+oF9q/oFTkYtlKXIw2IgGECsyEL0ge1mhViaCi2andbaQTU/tLmOCa4k6mr8DT2m2NcAZX0/XTHvWduCrE=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by IA2PR13MB6587.namprd13.prod.outlook.com (2603:10b6:208:4ab::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Sun, 21 Apr
 2024 22:14:58 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::5bb5:501a:fb40:5057]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::5bb5:501a:fb40:5057%6]) with mapi id 15.20.7472.044; Sun, 21 Apr 2024
 22:14:58 +0000
From: Trond Myklebust <trondmy@hammerspace.com>
To: "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
	"steved@redhat.com" <steved@redhat.com>, "alex@caoua.org" <alex@caoua.org>
Subject: Re: [PATCH] mount: If a reserved ports is used, do so for the pings
 as well
Thread-Topic: [PATCH] mount: If a reserved ports is used, do so for the pings
 as well
Thread-Index: AQHajMTp6pVGPQKHO06pIbu2/6XZArFynxwAgABTMYCAAFyrgIAACiwA
Date: Sun, 21 Apr 2024 22:14:58 +0000
Message-ID: <ae1d55fc8e6951832548323228fc2b9a0eb5dfe4.camel@hammerspace.com>
References: <ZhkMcZDhJhsVjo52@vm1.arverb.com>
	 <42faba18-0042-407e-9957-497806cfeed1@redhat.com>
	 <838909fda3f022bdf1ae3775ae0c0395e6102f85.camel@hammerspace.com>
	 <32779e7d-1f5d-449d-890f-6d26f0d6cf4a@redhat.com>
In-Reply-To: <32779e7d-1f5d-449d-890f-6d26f0d6cf4a@redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|IA2PR13MB6587:EE_
x-ms-office365-filtering-correlation-id: bce13a0a-25ee-471a-1e41-08dc62507b31
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 =?utf-8?B?NE5FL3o5S3p1KzJyei9WK2Z5ZElEV09yWktPb1dEVkhaeC9IMzE0NGdGUUYy?=
 =?utf-8?B?RXZCbFFSN0FYVS8vVVkzbWI0R1JvYThKSmJsSU55WVF6Mi9QK3BJWXhndUUw?=
 =?utf-8?B?dm9SNGpCWlg1OEhxMDF4MFdOb0QvSE9BTEd3Nk5idzRVa2NNWlZrL0FSVW00?=
 =?utf-8?B?WTluZThtUWgvSS9IQ2RUN2F5SU1xejBWVlU2WHRjUXR2Zjl6VGUzQzdTWDk3?=
 =?utf-8?B?RFllekRGNktudnRtTFUvbmp4UWJVYzRoU1Z1Mnh1U1RuQlladUJqZ1J0eUIw?=
 =?utf-8?B?aE1FaHp6bzlMcjdidndQY2NITllzaUlqUlFEZWhnTkw5dTVkWXdNNzlNeVlF?=
 =?utf-8?B?N0xYbWRxNFQweFZJc3d6emNqV3pueXJvOU1ueUlMMk96dHV5ZnVtZW1XaGZ5?=
 =?utf-8?B?czh5ZlA4K1J3dStWTS9kSStmN1VHdDRSKzNwSEV5RFBmeTQ1aDJacTVxSHlj?=
 =?utf-8?B?UVNobmJNY1QrS0lMaU9sUEI1RE9jdXBRalJrdFpIbTVvRUQxN1htSitGdUxS?=
 =?utf-8?B?MytScXQyblp2a0lGSHhlanFLUy90dTN2Ly94eGY1RjlhbXdqMC96SFRybmph?=
 =?utf-8?B?b1ZGSHFVSmRGNUtiZmxlc3JWaGFaYVB3N1ZRODRkd1ZDYjlXaFhURFNCR0VU?=
 =?utf-8?B?STFUbkhDQ2p5aENLWWtySzkzbVFCRG9tL2drTHF0dHRPRjRoSm5NV2NlUytp?=
 =?utf-8?B?blRxKy9rK245c3NjQzhjTndTaDZYZVVLYkJDaFVBZERqcVJ2aGZxUXBZalN4?=
 =?utf-8?B?YURCcUY0d0VwZVVta2E4L2VoUFF5VVpqbVFRSzU3VzJwY2Z1TmxVRkVxVW4z?=
 =?utf-8?B?U1BpQko1M01YL1pJc1ZJbkE1dTlic2Nqdk5ETkNVb2JlMU1ES2Z0SVFOY3Fl?=
 =?utf-8?B?aTJnNXdVaDNsdFhvNmJudG1DTWRqUEQ3cGhyTWx6RzlRVS9UaG1QYnZkM3Yv?=
 =?utf-8?B?a2srdElZVndlelpSQUtoVWxIRWk5WUI0YlpQVXdRNS9heWFjcGs1MFpEVVhI?=
 =?utf-8?B?YTRhZFZFSE5LUzBtYklKWVpuU0J0aGdnRlBFUzNUTHE1bENCbGN0WDZtSVEx?=
 =?utf-8?B?Z1VXT1l4WFBja1krWlczSDhQc1g0RmVpZ3pmUmo2a0JkQ0tSOG5OTVlvWkZ0?=
 =?utf-8?B?TkZ0REFsUElIbDUrNkxPbHJOM2dlczJCL21Cd0N6ajdzaEdJZkNEcVVoVC9B?=
 =?utf-8?B?ZnNST240NGxMWXU0YjZOaEs3dnZwVWdia0Z5SDNBTTdRbnE5elM4QmlVOElI?=
 =?utf-8?B?aHZGanVqekE0N2lPT3hta2NLeXhPRHVpbFJ4cnlBTUFjN3FKT0E5STUxZk1s?=
 =?utf-8?B?ZCsvWlRFN0tnOTlhSmZPUHdrSU5la2RZT1Ruek4rOC9OU0VOdW1LZ2hTTkpk?=
 =?utf-8?B?Q0xSWjlIMHpTeXpjMnk0czFYMEk3b01qTU11a3lHWXFWbDRhdTJITmdIK3ZC?=
 =?utf-8?B?UVJZVVBPZ3o0RlZYeTlYVHcwRWtmdlRJVjhlRm52K1Z4azloMTVUcXNidTNQ?=
 =?utf-8?B?YnJvalRBR1NkNGwrUWRiUm5TZDZXcExuRE53V25SYm9WRUR1QUtyQWZPdHJz?=
 =?utf-8?B?OUdNMmFsNTQrZ3JhUFVOenhNMTVlR3VpdDZQbDdDcis2ejgwMUt1cDc3c1VZ?=
 =?utf-8?B?WlFHamM4M0t1N01yZ2hDd3prdzZSeWJGTHlGTys3Y2UybGowK0VaMHlkWjBa?=
 =?utf-8?B?UU5meWhmZG5KUVNhd3l4YWZIUXdNeFhZbFhXQlpQSW9HMVZCczdSeDVTaWRz?=
 =?utf-8?B?a0V0UWMwVENKbkdINUdPaHppQU5WRVV1NWJWR2h6ZHJrSlIwN25vMEFubUlm?=
 =?utf-8?B?TmNWbUNQb3RLUmJJTzkvdz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cDVCY3c1aWhjaEJXZjJBR2lVMDdBbkJMdTZjQU4yanI5eWFQaHFJYk91RmFl?=
 =?utf-8?B?UXRsWGdXTG96cGdSODRsWFFTWVhXQkkyc1ZjTE5SdkFDUWJGd3VTVzA0U25T?=
 =?utf-8?B?QnVwWGZja3c3c3c1WFg2dHp4RkZzajdiSVd2SjAxZnFQb202eERwQzFjSlpE?=
 =?utf-8?B?bm93SFkxUjAwQ3RYeWZGSlB4S1RNUDJVZUpvN1RJUjhEUXBxS0FwV0hCZExN?=
 =?utf-8?B?d3Q4c2pDWDRDcVZ5MCtSSVZSTlZjMzdlVjh4QjNsS0lNd29ZQ0l4RGtZZVlP?=
 =?utf-8?B?L2dzM0lkbUl0QU8zMm94dTBLTTlTTG9OeW5Ma3hOYk4zS09UTWFtNkFqcU9J?=
 =?utf-8?B?Z1puNmNCUS94ci82c0x2cnhZNjdDOTR1UFY3MHpSbVdhMXhKb0VDdlBLaUIy?=
 =?utf-8?B?TUpkeEtKTk5ENDlSOFIyUmt0bGZra3JFSHJUZjhma3hCczRsTHppQmxEVGZh?=
 =?utf-8?B?dTBITlFWTkhDSnNMMDZYN3ZpQjJ1S3NrN2VvUGI5TzNlckFSUXpNOGpReUdl?=
 =?utf-8?B?WlZhRE5NcU5WcDNGUVNiU21WL2ZhSWxsSGFBTzh6d3I2Q0xXWUZuQU81ZERO?=
 =?utf-8?B?UGxFdEZCTEtIRkhVbWY5azFBc1l4SUNrd0FRNTJIN2pnSjlkVi9qTkFqamgw?=
 =?utf-8?B?UHp5NlAzc2MxdENsVDRjci9ydWdaa05zbnFzdUFrbnVIM3p3eWtLUngzZERk?=
 =?utf-8?B?QzU2UmtKUnpmWk1SMEN0bmhibU1wT1krMGZrZXlSMWdtdzJrYWRPZHNLUTIy?=
 =?utf-8?B?SFZhRHgzemVLZzdHYkxpQzdzVUI5RlhOQ2kwb2RzT3RNY25rNzlLbm84UGlI?=
 =?utf-8?B?WEQwM0VUR3A5SDNtbzZnRzRWYzRKd1daVGRZU1RLdkRsS2VSOGFnT2pZSzhK?=
 =?utf-8?B?cXBPcUhJSDlxOVZVY2FZSEpDWnBBWlE4dHFQZkwrS0d5TGFtRVpKVEhqMHYv?=
 =?utf-8?B?MHdVdlJTdkh3QUl2RzRpZkExVytOVVA0VmFGcVZSdDRIUDh1ZXc4UXY4Wit0?=
 =?utf-8?B?QndNdHJtaDhFVGJYcHRUWHZsV0xybExIR2s1TDBNMkRkK2QxNVFLS2ZsdTBM?=
 =?utf-8?B?bW1oNVI2UG5XZFhZUXNQc0FqWjJrMVZpT0E3ZlV4ajJEV1N5S3BQazlXOUlp?=
 =?utf-8?B?aTRTSng5K1BlZ1B6cXpIRi9Bb2F3NDlxR3lxT05nZlQzN0dLOFkyZjQzL3hs?=
 =?utf-8?B?eFJxTlR2SXA5dGZUUlJTQzdDU3VQcW5CeEJqUVRhQVc3TlJaczN4S0NsL1Fl?=
 =?utf-8?B?S01EaUdkMXdYaFdmMkFVRTNXZ3dqTzQ4ZHlidVJBMTI1MEFTR3FtOTU4Y2hB?=
 =?utf-8?B?K0ZCWjgwMjhJRzl5bE9GSmJxWjVPNW9zY0NnandTMHdVUWsvamR2NWJHK1BJ?=
 =?utf-8?B?SUZUSk1kcEtDb2ROTEFKWDM1VDFnSWFXQS9taFkzaE53YktVUWFGYmxmUWpl?=
 =?utf-8?B?QzFEeGg1bXdoSEpMeWdLeVZVa2VCWnIyWDk0cXVPcVppVVFlcXVnZ1pUMWZa?=
 =?utf-8?B?bldlRG55azFHdllDVzk3QzRwSWdQZDFPb21Sb2JFMWV5eU9uV2NVOTRhWUxx?=
 =?utf-8?B?ZkNyUVk2c2JwUEJsWEVLbHhwQURnQVBuTG5HbVNQSmp6dHo3dFcyY2pueG9H?=
 =?utf-8?B?cUxYV1VtV2JjMUdJdktBbUhHQVBsZzRxYzc4RkpFYzhRbXVUQW5QRkhyZlNH?=
 =?utf-8?B?MnU3N3k5dnBRRnZrN3RiUGVvaGRaaGhsRkhIcUNaOXNyeTI3dkVtSm9SZjRS?=
 =?utf-8?B?Yy9qZmkyOVhtbFpzdVMxQy91RjhoTi9DL0w4L3lTZnhQeWVrQjNGeHR6djJm?=
 =?utf-8?B?U3ZUOW11UU14RXZVR1lIZmlWUi9IR1RzZ0ZvTElKV1RQY1RYaVhrVWJvSmVt?=
 =?utf-8?B?WXZPN1R6dlhybWhxZmttWXlkb0ZTKzRRK0dYMG14L1kvRkp4Q3A4Y2I0TXpT?=
 =?utf-8?B?WVFBUkdRd3J3bUFxRS9CNTE4STZtS2JhQlhabWNodUt5Qk1aM3ArWVN6Z0JW?=
 =?utf-8?B?aEFsTXF3aFJ5RDF5bThRYmxmNzFua0xpcFRUSXZHWG5qOGRVL1ZLdkM2blp3?=
 =?utf-8?B?OXNSQzZ3SUFWL2hzOTdrbXlxZ2Jla3hkeGhKWVhoNWZ3YVFnT2g3dFI5RS96?=
 =?utf-8?B?amJlU0pHWjJLV01wNEYrZmtPSUJUZ0dPREFzZ0E2bzBHZHV5cHVoSDlGSUp2?=
 =?utf-8?B?d1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <080F4532ADE888498219244DA84DD0FD@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bce13a0a-25ee-471a-1e41-08dc62507b31
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Apr 2024 22:14:58.2944
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 96etsiu8k4ZQ4yRROmY69Q469iqO4N6rRxIwc1R47chMtjmpb/HRlyL7nihPMGueMSdqy/qiSVnDunPB+aualQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA2PR13MB6587

T24gU3VuLCAyMDI0LTA0LTIxIGF0IDE3OjM4IC0wNDAwLCBTdGV2ZSBEaWNrc29uIHdyb3RlOg0K
PiANCj4gDQo+IE9uIDQvMjEvMjQgMTI6MDYgUE0sIFRyb25kIE15a2xlYnVzdCB3cm90ZToNCj4g
PiBPbiBTdW4sIDIwMjQtMDQtMjEgYXQgMDc6MDkgLTA0MDAsIFN0ZXZlIERpY2tzb24gd3JvdGU6
DQo+ID4gPiANCj4gPiA+IA0KPiA+ID4gT24gNC8xMi8yNCA2OjI2IEFNLCBBbGV4YW5kcmUgUmF0
Y2hvdiB3cm90ZToNCj4gPiA+ID4gSGksDQo+ID4gPiA+IA0KPiA+ID4gPiBtb3VudC5uZnMgYWx3
YXlzIHVzZXMgYSBoaWdoIHBvcnQgdG8gcHJvYmUgdGhlIHNlcnZlcidzIHBvcnRzDQo+ID4gPiA+
IChyZWdhcmRsZXNzIG9mDQo+ID4gPiA+IHRoZSAiLW8gcmVzdnBvcnQiIG9wdGlvbikuwqAgQ2Vy
dGFpbiBORlMgc2VydmVycyAoZXguwqAgT3BlbkJTRCAtDQo+ID4gPiA+IGN1cnJlbnQpIHdpbGwN
Cj4gPiA+ID4gZHJvcCB0aGUgY29ubmVjdGlvbiwgdGhlIHByb2JlIHdpbGwgZmFpbCwgYW5kIG1v
dW50Lm5mcyB3aWxsDQo+ID4gPiA+IGV4aXQNCj4gPiA+ID4gYmVmb3JlIGFueQ0KPiA+ID4gPiBh
dHRlbXB0IHRvIG1vdW50IHRoZSBmaWxlLXN5c3RlbS7CoCBJZiBtb3VudC5uZnMgZG9lc24ndCBw
aW5nDQo+ID4gPiA+IHRoZQ0KPiA+ID4gPiBzZXJ2ZXIgZnJvbQ0KPiA+ID4gPiBhIGhpZ2ggcG9y
dCwgbW91bnRpbmcgdGhlIGZpbGUgc3lzdGVtIHdpbGwganVzdCB3b3JrLg0KPiA+ID4gPiANCj4g
PiA+ID4gTm90ZSB0aGF0IHRoZSBzYW1lIHdpbGwgaGFwcGVuIGlmIHRoZSBzZXJ2ZXIgaXMgYmVo
aW5kIGENCj4gPiA+ID4gZmlyZXdhbGwNCj4gPiA+ID4gdGhhdA0KPiA+ID4gPiBibG9ja3MgY29u
bmVjdGlvbnMgdG8gdGhlIE5GUyBzZXJ2aWNlIHRoYXQgb3JpZ2luYXRlcyBmcm9tIGENCj4gPiA+
ID4gaGlnaA0KPiA+ID4gPiBwb3J0Lg0KPiA+ID4gQ29tbWl0dGVkLi4uICh0YWc6IG5mcy11dGls
cy0yLTctMS1yYzcpDQo+ID4gPiANCj4gPiA+IEkganVzdCBob3BlIHdlIGRvbid0IHJ1biBvdXQg
b2YgcHJpdmlsZWdlIHBvcnRzIGR1cmluZw0KPiA+ID4gYSBtb3VudCBzdG9ybSAoYWthIHdoZW4g
YSBzZXJ2ZXIgcmVib290cykuDQo+ID4gDQo+ID4gQWdyZWVkLCBhbmQgdGhhdCBpcyB3aHkgdGhp
cyBjaGFuZ2Ugd2FzIGVudGlyZWx5IHRoZSB3cm9uZyB0aGluZyB0bw0KPiA+IGRvLg0KPiBXZWxs
IHRoZSBwYXRjaCB3YXMgc2l0dGluZyBhcm91bmQgZm9yIGEgd2hpbGUgd2l0aG91dCBhbnkgb2Jq
ZWN0aW9uDQo+IHNvIEkgZmlndXJlZCBJIHdvdWxkIGdvIHdpdGggaXQgc2luY2UgaXQgd291bGQg
bWFrZSBtb3VudHMNCj4gd29yayBvbiBvdGhlciBPU3MNCj4gDQo+ID4gDQo+ID4gVGhlIHBvaW50
IG9mIHRoZSBwaW5nIGlzIHRvIGFsbG93IGZvciBmYXN0IGZhaWxvdmVyIGluIHRoZSBjYXNlDQo+
ID4gd2hlcmUNCj4gPiB0aGUgcG9ydG1hcC9ycGNiaW5kIHNlcnZlciByZXR1cm5zIGluY29ycmVj
dCBvciBzdGFsZSBpbmZvcm1hdGlvbi4NCj4gPiANCj4gPiBJZiB0aGVyZSBhcmUgc2VydmVycyBv
dXQgdGhlcmUgdGhhdCBkZWxpYmVyYXRlbHkgYnJlYWsgdGhlDQo+ID4gY29udmVudGlvbg0KPiA+
IGZvciBOVUxMIHBpbmcsIGFzIGRlc2NyaWJlZCBpbiBSRkM1NTMxLCB0aGVuIHdlIG1pZ2h0IGFs
bG93DQo+ID4gb3B0aW9uYWwNCj4gPiB1c2Ugb2YgdGhlIHByaXZpbGVnZWQgcG9ydCBmb3IgdGhv
c2Ugc2VydmVycywgYnV0IHBsZWFzZSBkb24ndA0KPiA+IGZvcmNlDQo+ID4gdGhpcyBvbiBldmVy
eW9uZSBlbHNlLg0KPiBUaGUgcGF0Y2ggaXMgb24gdGhlIHRvcCBvZiBzdGFjay4uLiBlYXN5IHJl
dmVydC1hYmxlLi4uIElzIHRoYXQgd2hhdA0KPiB5b3UgYXJlIHN1Z2dlc3Rpbmc/DQoNClRoYXQg
aXMgbXkgc3VnZ2VzdGlvbiBmb3Igbm93LCB5ZXMuDQoNCkkgZG9uJ3QgaGF2ZSBhbnkgb2JqZWN0
aW9uIHRvIGEgcGF0Y2ggdGhhdCBhZGRzIG9wdC1pbiBmdW5jdGlvbmFsaXR5DQplaXRoZXIgdG8g
dHVybiBvZmYgdGhlIE5VTEwgcGluZywgb3IgdG8gZm9yY2UgdGhhdCBwaW5nIHRvIHVzZSBhDQpw
cml2aWxlZ2VkIHBvcnQuIEhvd2V2ZXIgd2Ugc2hvdWxkIG5vdCBjaGFuZ2UgdGhlIGRlZmF1bHQg
YmVoYXZpb3VyIHRvDQpjYXVzZSB0aGUgZXhpc3RpbmcgcGF1Y2l0eSBvZiBwcml2aWxlZ2VkIHBv
cnRzIHRvIGJlIGV2ZW4gbW9yZSBvZiBhDQpwcm9ibGVtLg0KDQotLSANClRyb25kIE15a2xlYnVz
dA0KTGludXggTkZTIGNsaWVudCBtYWludGFpbmVyLCBIYW1tZXJzcGFjZQ0KdHJvbmQubXlrbGVi
dXN0QGhhbW1lcnNwYWNlLmNvbQ0KDQoNCg==

