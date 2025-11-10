Return-Path: <linux-nfs+bounces-16223-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FB1DC44B19
	for <lists+linux-nfs@lfdr.de>; Mon, 10 Nov 2025 02:01:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15C74188A65F
	for <lists+linux-nfs@lfdr.de>; Mon, 10 Nov 2025 01:01:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C4A342AA3;
	Mon, 10 Nov 2025 01:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="F2MrQSF3";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Oj48DFAj"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1622419D081;
	Mon, 10 Nov 2025 01:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762736475; cv=fail; b=MBkJmBKAqtT7nCcNsOX4pBSKZV96JwIBHTumloPK5ktJoGcCUqCqZsI3oc27TCPTZn637agi/wqMmL4e4wFLXq3pqVKcDzJaTZD/uBEKj+pPi9lBppnl8TgphOsuslC4E2xcbDCjkBfN2suuCmdHi41dJ+RNTXylKWqVB2Mzvoc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762736475; c=relaxed/simple;
	bh=2Xuvee6xhoG09KKoLUK4dTIB4K0emroqQlrdZy365t8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=AS+IN7TcGxQmc7kcMHNULD253lB5+yLrGbMYuTyHrhHYr5NLQjHyKhO3tmArHz3+GI5w8nhAKG2B0voT+nHu7r6ZWoqpCtfan+ZpyfiIHAGLPi7DIHQHLphGyWnnsos5Cf9HQwUU3a6N6qgxE2xV1RbmCP4fkYd6zjj4EHIKj6c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=F2MrQSF3; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Oj48DFAj; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AA0LGxA030570;
	Mon, 10 Nov 2025 01:01:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=VO6FKl04Zi2nv1Dhc9PAOd3xFn/9ezwahUyKqRpfmgU=; b=
	F2MrQSF3+Yjn/M6OFR+4XWdmAl+83bljR7gfq3k+SGoKZ4+jGg8LdF+Ji2SOh0ie
	ZEyJhkqGopFPbnZnlBoacz5Mw5l3msAt0wnLZvdMeHlf3LyKeK26RY2EEx6QuD5j
	pgUu1wmQ7teJdV0bjfRCfIoF4MyD0LO751BSowzb+dms/ZU9q0gqXP1ocS8EWmlK
	vhs5Iy0MaGyeBlGsZW+IFslitSeq6eOCQglIATJIuspL07AClvNum6awuianAOVA
	p9bBQEqBH60paw/diswxaGtpgW8VRsJKIyERtpb0tXFAwpw/KyW+6I39Y1PapRkd
	lx/9haNzRmyPE8qzgl3gTw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4ab39vg5at-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Nov 2025 01:01:01 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5A9Nd5vp009920;
	Mon, 10 Nov 2025 01:01:00 GMT
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11012015.outbound.protection.outlook.com [52.101.48.15])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4a9vah9cc7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Nov 2025 01:01:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=duGKn5U2ijXcLRGOqH6Nwivr8ug68qcbXEknjN/5iMCoNPxCa889FIU7+7ZDBQhN0aHtMRk+FZd2HR0KPqRk3sga5P4thKfjPSiIetzL3BINPsMXN+P8LGMB8sfCJ4xU+Vnn0CTI4cLC/QOXCkNwVv3TPneKXEx10SaWQ+Ie4rBOD/h5W+CtyCOjyF4dEc+mv4qxd8ueKpurJfWjishPNyC17vcIy7f+d5Pqv7RgRDTSJ2gswtE8Vpnj114m56XP9Q8WAR3AoNd0tV+JTsp6yqJOXlHnnVTYzoyJNPbQIbWoTrDZNPqXAmXa7oqSSrLMe4dvnTopNJoRNjvvaeGq8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VO6FKl04Zi2nv1Dhc9PAOd3xFn/9ezwahUyKqRpfmgU=;
 b=EU17AMFgqBJ84bAhoZDWY3IM1NBFEdXXPmATK1Qpo+4T6lCbhzuwEXzsOrLLA0j34XR4Ls7qWn74Hfvt6M/zFidQ2jvnu5Rz3MdBcdZM+5JNzeu1sMHTLnmuqVf/Y2dl0gI51edp8BEvWW50RJN+7A4tX+NFojXn2mV2C5Z3VVfy6M7QlgEhW+BuiAzwhVuiB/sswYRi8zS/f7bu75MUc0JOgJueRXB5GlxLm88os9tUbBuFKJDze+Qx8GpcEzSpRzzvBNshci/OTO/Mq2JhhpUj0TbwwM8F2zyfkZ++3/EZgNFgyv2Ofh6d5jRfxlOVJD3rZvHLzmLMF0Nx9b08rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VO6FKl04Zi2nv1Dhc9PAOd3xFn/9ezwahUyKqRpfmgU=;
 b=Oj48DFAjN3wN561jxGKWmbln5AQgXTkhoS+0WzzRPCLVa6rF74aItoeyAQvTDEXKj0ar+0e0SqP6x1BFgGTKS20tgIWau5lvdwtL4ARJWlXTvUeMIZ9IrUUPhPBr3sW/V138YRY3dB8xacJFlkf/5MrOTbK4Q/OTvFgAvycRz90=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH3PR10MB7531.namprd10.prod.outlook.com (2603:10b6:610:139::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Mon, 10 Nov
 2025 01:00:58 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.9298.010; Mon, 10 Nov 2025
 01:00:58 +0000
Message-ID: <17e85980-9af9-4320-88d1-fa0c9a7220b1@oracle.com>
Date: Sun, 9 Nov 2025 20:00:54 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH stable 6.1.y] nfsd: use __clamp in nfsd4_get_drc_mem()
To: NeilBrown <neil@brown.name>, stable@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
        David Laight <David.Laight@ACULAB.COM>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        speedcracker@hotmail.com
References: <176272473578.634289.16492611931438112048@noble.neil.brown.name>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <176272473578.634289.16492611931438112048@noble.neil.brown.name>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR14CA0023.namprd14.prod.outlook.com
 (2603:10b6:610:60::33) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CH3PR10MB7531:EE_
X-MS-Office365-Filtering-Correlation-Id: 15151bee-657f-4577-dd13-08de1ff49ae0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Z2dGUzAwRENKNDRPZ0JTWjd4V2h1UmowTGhXUi9ONDJPTnhwMHVhWU1JWlNY?=
 =?utf-8?B?UUQ1UFNsank1aTJOZURtc0htS2lhejJDVWxXY1VQdWpDeWpnYzVSR1JyZnpR?=
 =?utf-8?B?Wk9zaTBmeVIzMXgrdTNVL25MZnVIVnNJUkc0SXdmRzJJb3lRUW9pUmNtVUQ0?=
 =?utf-8?B?TngyNmpmbkRvdWZ2NmtjbERJQkc4L00zSmF6Q3QvMWVDS3Flc2R2NkNLdGJR?=
 =?utf-8?B?eXh2dXB2OGtnRDlzOCsxT3I5M0lUeHB6cnQzNnJDTUI5M0tVcEtPNDNFbGdF?=
 =?utf-8?B?VjFkMG50dGZUZURCTzdxcVJLTUNyM1ltS2JjSmx0c29XY2Y5RzJ1YnZWcllW?=
 =?utf-8?B?TEl1WGxxbUFOZ2NvaXkxVDRScnZpTDNUOHZ0cXUrZ0MyNGhORC9FRE9kRTc3?=
 =?utf-8?B?R1ZyQ1lVd2RJajNSWkRjYmxKd3pzVkJFemJjWXg4ZndsYzdUODl3aGhCdXVM?=
 =?utf-8?B?dWhNNVdQVVpwaDFBOE5QRHhGZi91Wlpad3ZhRUd5disvVlNodm9qbHJDS2Y0?=
 =?utf-8?B?TXVpekE2VTIycjBzRUlESmdFb2VCbktwYXU2dnlZT2VFVUZYM1dSUm45ZGFN?=
 =?utf-8?B?STVIZ0tUZXBkNVhhOWhRSzIrOW1uRy9ETURHVjNrUEtMUU03UTdwU051b2lZ?=
 =?utf-8?B?cHY3N1puNm44OGNLU3JsdWZiYmxiMlVQVHoweDk1cUM0VnZlTlAreUorMkhL?=
 =?utf-8?B?eXBTVE95VlV0dWFLUEljWnlJM1JZUE95eGF4d2F3d3FocmVqbk0vOGhlczV5?=
 =?utf-8?B?THo0RkpZRDV5YVZaYXNnS1YxazlqWm8wRTdLSTB5bEVwT3FvUzJMQXlWUzE1?=
 =?utf-8?B?WXdBOUVpa2hTUXpKSXNLYWlCVy9VTFJBY1NqNnM3TGVzdmZtcU1qSHVmTlFu?=
 =?utf-8?B?cjFtOFVyMEY2WDVQaWRTelNkUk5TbktLQlp0WFRJd0oyWlRvd1BDZEMxN2lB?=
 =?utf-8?B?d1RMb0wvbWI4QjRnSHYwcWQyMXpucjNoVmVmeC9oRiszMTFES1V2WFViUjJl?=
 =?utf-8?B?RjkydXlWNXdMWW1aUUE0RC9vb2tpQm1nc0k5bmNVcnNYaGNPeXQ0bUFjZTEz?=
 =?utf-8?B?eGxTOVBuNWI1Nnk4TjVLZzV2UENRVGpUQndpUmZoNEU5OEUxZ2w4Z3h3N0Ir?=
 =?utf-8?B?MlZiNTJhc0dwWSt3cTAxb0JabTRDbXFFQjVPQ2FZRTEvQjF4Qitwbnc0bEda?=
 =?utf-8?B?MHJObEFxbE5kTFNMUklpbWh4ZjU4NlZOVitFQWV4dFJqZWUyZGxSOXc3ZHR6?=
 =?utf-8?B?R3VEYm5lMDJkSFZiRHNzeHlkWGh6RzA3NnVoMzZaOWxvcytUNVZ6S3U0UG96?=
 =?utf-8?B?ekxOYlZBV0lqUzdGQnA3WStEbERLVEN4cGJvV2QrbnVxVk45TjFHN0xEU1Mw?=
 =?utf-8?B?djcwNEhTQTJtSXNUVCtMWGVwRXoxakY1V29WRmlDQ0R0TkpHaEVYVTQrSzNl?=
 =?utf-8?B?bnhUcTdNNGZBU0tMbEo5WmFuRmJIUFFjUmlENWJBOTJsTXEzZ0J3YlpVSUlJ?=
 =?utf-8?B?R0JwcW9HMytiNTJqVkRlUW1kQWxmelJIL1RhUXRRcXVYUk9TR2s4TGlCSjdC?=
 =?utf-8?B?Zy9ObEsxRWFkN0hRNnczcjhhMVA2c3VUWmxSdUFXYlpBNzlWcFM0enROb1Z4?=
 =?utf-8?B?d0hvVlBHZUVNalBUNDVjQStSN0EwWnV3ajgzTG1KT3FtYkE4Rnc1ZnJFNHVY?=
 =?utf-8?B?azg4ZzdVSFM2dXdEalVoeVpsQ2JnUExTSjRMUmIxT0lDeFdYRWk1L0pqYVRY?=
 =?utf-8?B?WjRQWXZNRkFGN24yZ2FlOEJnM2VxeGcxZ2RPR0x2bTlUa1hudFZaQ3dSaHMy?=
 =?utf-8?B?cDBrZmVGajdhdlpHMExmV0lSbStpc1RMc0VvSmVqYTh4T29zN1BmRk95cVFx?=
 =?utf-8?B?aDB2UmoxY1IvZTYwemhTUVpBZ3ZPWm1MZGV6NldTT1hXb0dlVVpraHRXZjZX?=
 =?utf-8?B?czAwcWM2UVZINVRSMUF5TXZQMmd6TmhIRzJVMGNabFFpOG1Gdk8zY1ZpdlZV?=
 =?utf-8?B?YjNMbHU3MldRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MjhzTUtOayt5MjFNSklaY3JzS1laK3lyTDdZWEFzUWUwTnBQbnJpWUN6N1Er?=
 =?utf-8?B?eGZ5ei9WTXdHeklYdmNXVkhrdXRsNHMzbWtvTE51N25yUWpjR1QvN0pnNXdT?=
 =?utf-8?B?c3U0SFJZeDBpUXB0VzBkSmJjRDVHdW1tWXhCMWJydUt4R2EvTDBZb0d5cEor?=
 =?utf-8?B?NGNIdmUycUVaZWFVd2JqMnFHSkhYSjZlUmlhWGhSRFFwc0hWenJaKzJSS1R1?=
 =?utf-8?B?bnpabGorU24yMU8vMGUvc1NiTkMrNFZidC82N2tlZmlvNnNHclplbE1ENVBD?=
 =?utf-8?B?S0g1UndKcnFBbS9JRFpBZmMrOXNFbUJZYjJlV1grRWtnTWVpSDVOT0N3Y2xH?=
 =?utf-8?B?OXZ3RGlqK2FvVDhMNXh2M28zaEp6MzRQTnR1T0JOV3FyaVA1c0kyVDZja0NY?=
 =?utf-8?B?SzhxWlltT0owTXhQRG81ZXhzd2QwbHpFNlA0azBxZlBUSDNJbk9XVy9aTWRp?=
 =?utf-8?B?Z0NkL0VvMERMNTJBYnovVlA2a1RFTEduZDJLMEZmSk5RY25wbWJKazlSRXoy?=
 =?utf-8?B?eXJZZUhOSDFqUlJvTklrZkxFUFI4MTFWcTFyczNkdFNwRjBTUklLYVY0MHFZ?=
 =?utf-8?B?U0JwYVJyMldId0d0K1lXMEZvV2g5RFd6NjZCV2tNd25IcFNKOUZMNU1nU1Na?=
 =?utf-8?B?WTMwUGtRMzZTVGVJTFhDSzI5eTF5UkNORWM3aVpjOVdPK1hyaXd4SXhyYnpp?=
 =?utf-8?B?MzFMd2Y0U1RCbjFReTdmUUJOSHVETjRzR0NWOHVnK2dJMWp2VHJ6bWxHRXdy?=
 =?utf-8?B?d0tLQXZGcWZOOTNBK0FaaFEyS3o4UFlqTHJrdjhpMUg1bWY3YlJwSmhNTXNR?=
 =?utf-8?B?OTg1UE42QjBTRnp2NXBjWldXb3IxVDBNT2JHZUoxbUVrUld3SFg3V29oNS9D?=
 =?utf-8?B?cC8vRzI3aTlGbGRtekdiYXZDSnh5LzBpT0pYYnIva3RPV0dHRjlEQitHT3RU?=
 =?utf-8?B?NnY5RVZvN2FSWmV2NUNQNFIwdm5wMXFMSnN0RjYrN05HdDY5bSsweWV0b0Zs?=
 =?utf-8?B?dnhnSTh1OW5jQWhnQnArNmZ6TDRsaTVxTlpRcnp4RDd4WHhKN2NreWw4MDNo?=
 =?utf-8?B?V2YzbkRKdUYwY0pjeXhkNDdXVnhrcDVOQlk3blBNRVkyS0RIMGNUVjFwRzZW?=
 =?utf-8?B?eGcwWXUxQ0p4QUtLSlIvckhsb21LUlRxTUJwSGdadFJWelJzV0hCWFBCcWpB?=
 =?utf-8?B?V21zMTA2cTlMaWV2enk2UUo5ejg3RTdoTEdGZEMrL3RIaVZqZ0JGOWxTZlF4?=
 =?utf-8?B?eGsrSWs2alBIdEh3K3pPaWwyMXFReDF4RzlMaVZQOGlJWGlaNmpYd2I4NkhJ?=
 =?utf-8?B?MTR4VEJ3RHNwdWxpMG1CbVlJVkp0dFVZMEZJWEdCcHBwdnc3WE43WE5TdGZ0?=
 =?utf-8?B?WGw0MDRtKzRBb2tINWgrTUliSzhudVU2UTBUOG12U1J1dUJLWVdrQXdTQ3oz?=
 =?utf-8?B?RmtoTWxxS3dyZUxhYWtLQzJ2U2dRTHhwbXNoRWYrVFFmMEMrbWdhcXBMTlN1?=
 =?utf-8?B?Z2ZSYk9vcktPK1pxL2VvYnk3UnRTR0dXeGlrRTF3WXRHZjRlVDhvSEdzOU9E?=
 =?utf-8?B?TjhVdXdob3VFRDVhM0cwWkJVV3hkK1RqaFRlbGpFUURnU214aGlmQ1JpbHc5?=
 =?utf-8?B?d045SFVSMVJHMlE4bFBCZ3Z3czZ3L0Y2UkZzQjVzNGowZ1NHYjcrWGlhek5w?=
 =?utf-8?B?RU84SDVhdzhveTdoWWJseHczVUp2NExhV01oOVVma2tpRmJTc2ZuRkNSNGdx?=
 =?utf-8?B?dSt1T2N1VFdEbVYxUFlmWGt6M0dVRFJqTng3STFzRjZ6LzZ2NnQ0NGphTVlJ?=
 =?utf-8?B?THMyaUNVaExDaEdkdUZuNWVvQk5GTXdzME5UTi9uWi9VZDRjWHd5QmxSRWU1?=
 =?utf-8?B?WC9XbnhjVTc1TndzdVcvWjVEbU1MVCtabmdGa1c3SjVOMCtOSEE0T2xHY0Jx?=
 =?utf-8?B?Q09KUWYyM3FZN0F5TEpqRHRibVgrT2RZOThXYkhDN2pOZSs3M1o1cC9uK3JG?=
 =?utf-8?B?NTVhd296LzRUQjhnWFJWcHF0U0FLb2EwM1dFamw1VmpSVTJ1c0pscEFMVjZO?=
 =?utf-8?B?WlMvV3Ruc1F3aHBmMzEzbEFDczJtd2VSMGZKODZBWjB2RFJFcnd6VWJrME9T?=
 =?utf-8?Q?7WGJE7BTPtgqM4wf65chosaYo?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ERDELUcHkdrzR2WLCkQ7wBs7qtPIbp4FxoZVh4NLmmXOLFTHd3S4m82ypQ+aCCW5iGkXy2FxQQJyIUATpVUC4lpyQT/BVPigLwr4sZVwF0EtEstReiVWmLPRFAFVd50B8adrFFLMfKlRASmswADA2wI50YmefpcEC6mEzNR5a8pMHeiGosPo7dNztyzEmUs14m8O9k7wE2Kj3oUEp8VYIUuwIbARd9FgpkbdTgRTX59wUzUqf0niWdf2Xi0Ny3cQHfcD/jlEBj8irug4A0d4u7AZylPa2vvT+JX2R829NcsclYxn78VwqxyAwKkMBx3hXuugOQk9lalcRxzJeUhARZSoQKgDyPykkZ4I83je5aBSkkXZCx3U+3eMqsd0nUsN9fjDEvKZPeDe2xJOQ97UcCZB2h47cqIKfrJCTRHU8uc9OH33lBaLOLlzinMWztdYkgdj1LzPoZA2ycP+3JvUxGGyd89ywp5QLM4S7aMMVKm5U+RUlkhwiKakOGRMBo3PTM1pQpbsE5IBze2COq6gM2yvptou6mSPew3hakBybQLLi1e54Y9SQSNqxjMJKFd7s3Piy18+N1EmQkkIaUgf0YiCl8KvojQ/WMn4UHEvBiQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15151bee-657f-4577-dd13-08de1ff49ae0
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2025 01:00:58.0622
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ls+uIJehF67nfZPbfrUrf7E/4XOSglMXvRfNvICLWLozcIPAWETPd869SJSywvg6V7Zaz+KPO73PQySOE3+ZyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7531
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-09_10,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0 mlxscore=0
 phishscore=0 mlxlogscore=999 spamscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511100006
X-Proofpoint-ORIG-GUID: r-fp_vygGlYhg9j50ECorhtI_FtIeNgM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA5MDE5NiBTYWx0ZWRfX/oW4a6X9cnbU
 AoviekOvMySapR/z0OdxNAleSO7g3fRx8vw0yH0HqtcSzYF22VmnPAcDJ5T0doDEXxboiXZiCz8
 U4KmEWS8K2l6QzpQEAwi0JRllq57XdXNEU/u7NkZZQuWx7UCXmudticGqEtwKPj6dvM8Sfjzvxy
 dsqtd0ekjhVAL7EQv5qtiGmNnMwWw6llICJtEsefSEbYQrmR5FQ564Uo4rwpuvMJGDTea5/JbVK
 DFUKfBR0hg4YBQwVMzZTZ56nMeHXl+OIpts2nvr8FaA4oxEXNRqklIDSiF4bovYEPP3aPGeH9uE
 0NCwLo7aZogbocqunHrOAEFZ5RgCryxo4BNhYd3jQubaIuhgF0wtGeO7UKvel/9uGBONIG+09HT
 byOoDoi7Uh+w5kFYTvX5LH1zT9JBrh8XtJi9CxnvmHSzjx4uMZc=
X-Authority-Analysis: v=2.4 cv=A/Nh/qWG c=1 sm=1 tr=0 ts=6911394d b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=_pS0ycK8BaKN8Z4_6BEA:9 a=QEXdDO2ut3YA:10 cc=ntf
 awl=host:12097
X-Proofpoint-GUID: r-fp_vygGlYhg9j50ECorhtI_FtIeNgM

Hi Neil -

On 11/9/25 4:45 PM, NeilBrown wrote:
> 
> From: NeilBrown <neil@brown.name>
> 
> A recent change to clamp_t() in 6.1.y caused fs/nfsd/nfs4state.c to fail
> to compile with gcc-9.

I have a comment on merge process:

Reported on 6.1.y, but might be present in other LTS releases, since
2030ca560c5f exists in every LTS kernel since v5.4.y.

At least, my understanding of the stable rules is that they prefer this
kind of patch be applied to all relevant LTS kernels. I strongly prefer
that NFSD experts review and test this change /before/ it is merged,
since nfsd4_get_drc_mem() is part of the NFSv4.1 session slot
implementation, and since in this case we don't get the benefit of
/any/ soak time in linux-next or an upstream -rc release.

So IMHO this patch needs to target v6.12.y, not v6.1.y, and it should be
marked

Fixes: 2030ca560c5f ("nfsd: degraded slot-count more gracefully as
allocation nears exhaustion.")

(Since the patched code hasn't changed in many years, I think the final
patch ought to apply cleanly to both 6.12.y and 6.1.y).

I need to take the fix into nfsd-6.12.y and run NFSD CI against it, then
it can be sent along to stable@, and they will put it back into the
older LTS kernels for us.


> The code was written with the assumption that when "max < min",
>    clamp(val, min, max)
> would return max.  This assumption is not documented as an API promise
> and the change cause a compile failure if it could be statically
> determined that "max < min".
> 
> The relevant code was no longer present upstream when the clamp() change
> landed there, so there is no upstream change to backport.
> 
> As there is no clear case that the code is functioning incorrectly, the
> patch aims to restore the behaviour to exactly that before the clamp
> change, and to match what compilers other than gcc-9 produce.

> clamp_t(type,v,min,max) is replaced with
>   __clamp((type)v, (type)min, (type)max)
> 
> Some of those type casts are unnecessary but they are included to make
> the code obviously correct.
> (__clamp() is the same as clamp(), but without the static API usage
> test).
> 
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=220745#c0
> Fixes: 1519fbc8832b ("minmax.h: use BUILD_BUG_ON_MSG() for the lo < hi test in clamp()")

Stable-dep-of: 1519fbc8832b ("minmax.h: use BUILD_BUG_ON_MSG() for the
lo < hi test in clamp()")

might be more appropriate.


> Signed-off-by: NeilBrown <neil@brown.name>

-- 
Chuck Lever

