Return-Path: <linux-nfs+bounces-12329-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D9BEAD5ED3
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Jun 2025 21:11:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2089F3A8D76
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Jun 2025 19:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 656D32951B9;
	Wed, 11 Jun 2025 19:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="M9adLfwr";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="w4RszF4a"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92654185920;
	Wed, 11 Jun 2025 19:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749669076; cv=fail; b=Abm1s2P1qETa8l93r/J0l6BHuC9+Pv1c9L1W8YElsDC23U1C8vj6e3HY3bbH8r9DdFSayoFl39Wxwci/SMsEyZTYdbsWQrm+ecgzJbXkXHsQrRXm0yHrV2FYe5eUBMakH0EKWwiNQeQ82mxLycMlsFB08U7UipS/8ga09c84iRk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749669076; c=relaxed/simple;
	bh=5sNDw5BU+4WFrgdXaarMM0fbTkdZINdJqa+jwEwxsSM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bWysNueG6erTN4Zoc5UcaQ4u8MgmW41IUoRdlKwNP6GE/oBj7osC0zydqCwUm737Xo86+86MjPwMnHLlE+BTELCKCzEHFpbVf1JHF8fg/+vtWrO0qmn98KmXb7eEB/wGZAkJmj5wPPd8xFsyElBK4SSA4uewM4YkfSY12uy13Ek=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=M9adLfwr; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=w4RszF4a; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55BEfa9L006978;
	Wed, 11 Jun 2025 19:10:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=9kx8Rxw3nmSBCFfiHnYFht+qATU1VFEmXLyUwFk4aeo=; b=
	M9adLfwrL8Y3j4tW6aqPyk0tbvO88w4lfBXVQiPx+PjvBvnfwNRYNhHOGjSWrlxQ
	BnrFUH8RrhI6sfjn+9sqPUzYSoiPRbaQAe5mrf9rwQGGjNNVEAYN9sdcuY9LpjF9
	IpkOngZUC4PW+LBR4jz4tC2wNkGnVjmR9f+vOBEXMUjXAIoihmFF5sOesV0Ata9A
	n0pvV2xZumsYkP+nti/rwbg26LOZaEsOgTz7qIzbyLEZ+bqXEvArnkOuHcjctgaW
	B3MVfejYoOf0BGIqhZnJJSEshrHTcdqMs8cLFboHI1puk9a56W18AlGvyZjfBotR
	oh4OROJAcMST0ihSmMVDsQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 474dad890x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Jun 2025 19:10:58 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55BIIDBS003908;
	Wed, 11 Jun 2025 19:10:57 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10on2071.outbound.protection.outlook.com [40.107.94.71])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 474bvamda9-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Jun 2025 19:10:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TPGwAWqBFR//TQxivfr2xQbhKt76BZ57gqhVIT7XB+fv8JE4mo2bgYr+KT0lytHbgHfY3KmmkDTdsjnQW0ecXCNStNp4tsUF3j8cAWw7WFQ5nigMZPhmzldCu+woAsy4h2lXiYhFgyFXnMWMhGJ6Ng4NbWmK2RcrftmCnQy595TjkxyxdDE1ZG4ktQXRqh3VYdlnq5qJL0ZM9Nq3TuZManNYA9czJXn3Z3NbwuaMLJ8QIy8+CxgYorOsM9NlfPprFakocN5Is9UjReZVx2DNP2brPGyDoqzlHAGcH5nCa+76+oXd67MQKVB3bJ57/Mtq/2WGM2BmC8P8CfcAJYgiIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9kx8Rxw3nmSBCFfiHnYFht+qATU1VFEmXLyUwFk4aeo=;
 b=YUkPd1HVuHPTqZ+hUF9xqdS6swba80ln5UfGYwuqaJw7OxbbeAEILOlPuPgn+KzSLIHV4VtrjqIZwrmMbC5k4de5uoC6fKhoytDSrZCOJ4L8h1hNeYYhnlSigXOiN7WFLvih47g4uQmGqVzEDu9eNHaQeOdoxuPOuaj5B860rDrnkkWnFk6433uB1F6bk6/VDo9ajUS8pLvx07echlyzpgwMH9egv37vTT1MA0tc27370aiFsTRDIjitY6KuqlG4JNdG2Usq+aquziGVAXHrMf71kdFUmGBTa4hjgKrodrdPX+gLNFLQwlaErl8Cj2ikFOvr9GPsrZFxYUZkhp88og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9kx8Rxw3nmSBCFfiHnYFht+qATU1VFEmXLyUwFk4aeo=;
 b=w4RszF4atbHtRGG1Dmy2AqHj+UTswV75Qqndjcwt+KYic/uZlCwCdGe4SWR1QZSc1JX7B+3a0yrIJCCnKUY16VNjXGRab191ewESbo2cD6B7evfQv4HzeQFoEPe/3zwJ7lKKMtuiU0GFLNAx6ia1KhEbQDouKLtbEozqKu8BEkQ=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SJ0PR10MB4637.namprd10.prod.outlook.com (2603:10b6:a03:2d6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.18; Wed, 11 Jun
 2025 19:10:53 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.8813.024; Wed, 11 Jun 2025
 19:10:52 +0000
Message-ID: <d277b990-fa08-47b1-a827-a0e81e9d2ca8@oracle.com>
Date: Wed, 11 Jun 2025 15:10:49 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] fix gss seqno handling to be more rfc-compliant
To: Nikhil Jha <njha@janestreet.com>
Cc: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
        Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>,
        Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>, "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu
 <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, linux-trace-kernel@vger.kernel.org
References: <20250319-rfc2203-seqnum-cache-v2-0-2c98b859f2dd@janestreet.com>
 <d78576c1-d743-4ec2-bf8c-d87603460ac1@oracle.com>
 <20250611A18503192e946d6.njha@janestreet.com>
 <81cd5e1e-218d-4e24-b127-c8d1757e4d99@oracle.com>
 <20250611A1905207b67479b.njha@janestreet.com>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20250611A1905207b67479b.njha@janestreet.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH5PR02CA0003.namprd02.prod.outlook.com
 (2603:10b6:610:1ed::23) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SJ0PR10MB4637:EE_
X-MS-Office365-Filtering-Correlation-Id: 5302468f-6d98-4fa7-3eeb-08dda91baf32
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?b3ZVM1o4ZDBZZUdNTHFRZE0zUUFlVmE0TkkwdHhsVndRamhiVUoyNFNHMklm?=
 =?utf-8?B?R1BZSFZwemx4UDdUN1Jrb1lBUFNudGx0RXc3b1B1d2FWdDZud2kvK3pWZDNC?=
 =?utf-8?B?Znc4Y2Z6MzBmTmJ6eHIvR1BPUVQwYkUxVzBCSThpRktNa3Vjb0FSS2s0N3U3?=
 =?utf-8?B?YzUvSHh4WDNuNC8wRU11QXErbUlPdHNBK2NraGVMT3pRUkJPZDBDak5rSDFE?=
 =?utf-8?B?NzJ2bTUrL2QwNXRRLzI0T0RYSkw1QU40WlpNajJJS0tMd1B4VkwrRFl1QXJh?=
 =?utf-8?B?NW84N2ZqWUw5SWtiTHZBR0xWZFRmOG5OTEJOMWRSb0lseGlnTXRJUTRma3VG?=
 =?utf-8?B?L2JnbTJwUXJrREJsVWJaTDBvTFMzV1A0Rm9ON1U3alhzRiswLzZYRDRFaWpr?=
 =?utf-8?B?dGh2SkFBZFFPMmdDWDFGN05LQ2VQa1llT1dGUXpVdjZwL0RnRVA2RGZUcFVG?=
 =?utf-8?B?UEtuQzcvZkpiSVJIem5sZ3hVL0g2WlhpS0dUOXJpRWJnSWkrSDBGN0hZVWln?=
 =?utf-8?B?NDcyMXFrRmYxVDhJbkcwNkN5RTlDYitmOG9UNzR4VmF5YzFsa2loakdmRXQ4?=
 =?utf-8?B?UWJQcy9HSmM5R2R3S1JKWVVwSW9pallwM1VoT25PT21qNDBVK0Q0a3p0S2M2?=
 =?utf-8?B?TDRseWtzeTdmQ09wVHB5Witzd2VRNTZNL09pSTY3dTRGNng5V3ZLRCtaM2tK?=
 =?utf-8?B?U0gzVmYwN1dMWFliVGVZUXJkSjVkTGdVUnkwbi9GdkxmZmMwcXN2MnRuY2ZU?=
 =?utf-8?B?c0IvWHQ2Y3VhR2x4Q3EzMVh4d1hvYkJWeWZyWUJoRWp2aHJGamJKT3ZRWUVO?=
 =?utf-8?B?ZVIwcmtESHNWVjc3aHJuQTZGVStXM1I1VUpGUFprM2ZRYUlqWWJxMWpwQnBn?=
 =?utf-8?B?ZFlxSjk4dWZ4ZERqK3RBWUJ2eFl6UXNuYjBNMEt2K1A0Q3JURU9acXNVdW9D?=
 =?utf-8?B?R2ZDRWNXQzdJTmVxZkY2TVpvNUlBbGR0emo4YWxWeDNQRjJKMTRaaHN0ZlRN?=
 =?utf-8?B?dXpCMUNRTllEZkI5TXRyWE84b2VWVXh2VFU3ZFJTVlZqb1ArWDluQjVXc2tV?=
 =?utf-8?B?N1BkWkhWZnR6d2lXTUYrT2U3RXROTHU4a2lOT0NlaGxDM2lUMGJXTWJyMS9y?=
 =?utf-8?B?ckljMHlSU2lzT2JBNjBPY25aZTFudGw2YlNBa3U5bU84aHNkTHR4SW1Fblhm?=
 =?utf-8?B?SWl6RUpqNjF6ZkJLOXdsZ3FoQ3QvbjFFeWIrbGk1c0ZBcjY2MjUwZnZsVW1z?=
 =?utf-8?B?WDZ0d2RTaWFrRitqSjV4ZCtoczZxUDR4SG9MNWw2TlJ2cVFkOG9pVkU0ZE1W?=
 =?utf-8?B?cE9STTNZV24weXdneHBoaXlXUllyL2tiTk1uSnUzVTNBalUySVlJbXF0VmIr?=
 =?utf-8?B?Z2praEZZTlJxd2tTUnpzUW9ZeUhPN01vV3lSbjVHQXRwby8yVC9SaXYvdGZy?=
 =?utf-8?B?azlXTE1helVnL3diZkJlMTFoUnJRUkU0a3hzeFB2dWtPMlUzVkJtZlVDbzJH?=
 =?utf-8?B?Z3NqaDBveVNSeGNSc2xsbDVsYWpmMVJkY3lLQ1BGc1lHSFRKVEoxQjd2R1pV?=
 =?utf-8?B?cmlWQURYUnc1VE5ONzJPZnRyZTUwTHljeEJzWVBkUDYrRjJ3YnZTcXVHWW43?=
 =?utf-8?B?R29lUk1jYVR3Y3J6K3dURVAxZWxLZ1JHSldocGlRS3BSR24yWXMvWUZyRmNR?=
 =?utf-8?B?V3R4VmU0d3BtTjdYSUd2RDc4bXo3aFBlSVY4ME5yWWI5MUxTTmtsWVVmUDVT?=
 =?utf-8?B?Z1RmWkxJdkpwdE9NSDhyNkRsRWpRRC9pRU9YY2YwdURPanA0WUNVQ3RvMDVV?=
 =?utf-8?B?SFZQLzR4Q21wS2VEY2FyY3JwNVAzTWdVSTBuL0YzdGl5RmI0L1BDZ29BZG9j?=
 =?utf-8?B?ZS9IK2xYZ1dnWGp5ZXhDeFNsNHBwR0dmOTVUZFRiV2YzaEdFTG1MdTRxUTBK?=
 =?utf-8?Q?uAfPKeJvDE0=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?WXhoU3d6L3RKWjVZa2ExSlJoYmNPay8xcVVncnRBMkx5Q0FwRVpJNnZjZ0Ev?=
 =?utf-8?B?bXVGbk1ibTZjNVQ5eThtVXdMYjA0bXlmMlNMcklPZ05mdUdCYTBFcmY2ak94?=
 =?utf-8?B?RU4rRFJZK3hKNlo5MjM1YzZnZHBhNnBsc0FTMmZ3OGlOSkN6NnN5SDMyTkRp?=
 =?utf-8?B?WXVwUVY4UVliNUNHN0crWis1TDg2UEE2SUZ2dVQ3bHFnalZIcXZIOVVVM2Z4?=
 =?utf-8?B?RElZYnl5VDZXUVR2T0M3SzBHVkxuK0loWFNWOUcvMDBVWGxQWk92MUt1dUFt?=
 =?utf-8?B?b2NabFNYYTQzZ1ZNMkdaYmV5QzkvdVM2RXduSUhRZTRUZUxTRVRUZDRiT1k0?=
 =?utf-8?B?TlhWckFFZzhpV0ovZzMvNGtkSHBVOUdHb282VnU5YVBrOTJBNGR2dTkrakVY?=
 =?utf-8?B?U1BZbFhRNjgzeWxvZ1l1UTZ5S2xFZVIvenduemZRdXRpK0N5QlU0d2dmVGoy?=
 =?utf-8?B?bzg2ZHNqWmxxU3NSUzJBbUdEa2h3VEpobUlVUlRndWxEc0hhTnFQeFRlOHpV?=
 =?utf-8?B?NkRPRUxpbUdEazdHZzVJZXlqTVY3aXdkWXpOY2d3dnhqSFBkNXRnRzhQVnhQ?=
 =?utf-8?B?WStKRnZ0amN2MkMvVm16OW1VQmZzL2ZMdmZJNVdsWFFaUjUyYkgxNXpPUEU1?=
 =?utf-8?B?eUZ5dHVGQ1FlcjRScko2MnREdkZQKzJCN1FMRXdneGFHUnUyMGJucFp0YUNG?=
 =?utf-8?B?VGl6R1JpcjdqdjRWdDlBMFV2V3BHM3ljRzlGZzQ1dXVYaU85Z2hHK0s5N0xM?=
 =?utf-8?B?MkNFSWdWYVEwb1oxa3RNS0h0YUxINWQ5VnArR25MSS9acDE4ekhEYzJQWk5F?=
 =?utf-8?B?citNTUNMUENkNWZteDU5bTdqY2tJb3krM2NRMlpHU1FibWl5QVZnTitucXJH?=
 =?utf-8?B?eXFlN2dWVkxaMmNodTZHMUpORHo0VnZLbVk3OE9yZlBxaE5TNmk1ZXdTSDJi?=
 =?utf-8?B?c2E2L2NOOGVGempTUnRMazM4bjJrZlROTnVoU3BGeHJVaFR1Mml0QTdYSU0r?=
 =?utf-8?B?QW44TUVKM0xMOUU5RnJCamhkWmhuaDdvbGRuK1drdWtvUFlIeGJhRTRCZ2Jz?=
 =?utf-8?B?R09mK3VmaDFwdS81MzhmbzZMWlBJdmk2MWlYS0J6NVhMV0E1T3djQ3Y2Zkxu?=
 =?utf-8?B?UXRzYXQzNmpKV2RHQTVyRXhPOHpRWmd6WFFoUjh4N0s3VTg2c3BMaitPWThk?=
 =?utf-8?B?ZHI3alF0SnJteUdJK3Fiano4c3F0QnZhNXErZHd3ZDhMSS9ESmFBTjFBZmU5?=
 =?utf-8?B?c21XWjdHeld0UklDbmt3djhGaGRFMWJVcWFiR2YrM3FDYUdqNFFSZ2loOE5T?=
 =?utf-8?B?RGJqcnlCTm9UZ09tWk9FVFI4WTJlcXpJakpJTjRpRXYyVjF1eUNzdWlzeU1W?=
 =?utf-8?B?WGM3VVh6RlVFbjF6MEVPbGhoVEVaelpuMTlXei8ya3RRV0NieHpnVWpWNklY?=
 =?utf-8?B?T2FJWlZwd1A0QUg1SzBTT3lHS0NBMzZ3elMwV1FGcmdyNDFmYm9GYjZyajhB?=
 =?utf-8?B?bVRwZ2YvWTU2SVM1RG5jVEM4Nzk2TW1kdzc4R2hWUER5V2NaWkY0R2NOQUFM?=
 =?utf-8?B?SWFhd0pRcjA2V3RrbDdYTThBN0p1MEJnN0hJRndVc2l4MU1oalhSbFd6dkVF?=
 =?utf-8?B?NUFuYTlGY0JEeXJHNURSbXZwR2J6MkNKZ2FSWlNIazlMMTQ4N0svSXdHUE1F?=
 =?utf-8?B?SXNmZkhyekwxT09RYmtFcUtuTFFIa2NnNGpXUEprbUMxVXN2Q1QrSHpjL0RH?=
 =?utf-8?B?QytKdHhBdEtRVHVEZWdlY0trdzRCdkpwalE0Tm1jUGNxVStYVnQyOFhMK1Fa?=
 =?utf-8?B?RDMxNFpVZWN6RnJVakFTRnRuZzRlMHltQVlGVXdWZ250Q0lqV0tORXVDVnZ5?=
 =?utf-8?B?TFF2VXN5VWUwdnFpcWNHZmJkTnNTRHkwSTB2T2pGQ09BQ3ZIdUJlNENDZUxJ?=
 =?utf-8?B?aDBJTXJSTE9kVVQ1Q2traW5lWlpuRmEzTDR4NUh5amgxRDE3SmIzbytwTmVF?=
 =?utf-8?B?dHdGVlZJd0VzQTkrNEJGMkE4Q0NkaG5HOS9tczdLaUdjTjhDRVRoV1poNGxw?=
 =?utf-8?B?dE1NaWVMVElZZkdlUkNlZWg0WW5zNjh5NlFiQ0FVejQvYXdadVE5cUdaWlkx?=
 =?utf-8?B?c0QwY3cxY3FySWsyaVREZkMzZ2QyS2UzQmphYlBqUDVVMVV2eThMVnpsbHIw?=
 =?utf-8?B?ZVE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	taGTT4EM8144W3QbJZV1TbuTxpBSeMZY/Da58+WTMun0pG7JNckpJFL2hpPP/gz06dxRNYdnmoSKHU3HEDdTcFsPFq9a7xPePOvM8gXUMk4V5tMcMSUn5+aZQ4nAmIXtnu5M9SPLoqnvpvQ2iXEYtL75reDvDFBDO7yYXyL7lW91Z5hR+vS2QcWALfql7fGwoOlnPmBfpTSWdXT3eAkaLRnx/u0SxWXWVVflBSIMW1tketrOi1r1BS9swgXLHBH5C4jpXhE48jU0GWZbLzhv1uWar8mLv9nIB7zXYXMeTihuUr6GpiSoHhTtbXDLC6QHj69MoxPFAfAwMDLzK9e2+NAnzli42jpBDb7j6bqLKBO4OA18jgnn6nPx5m2OIVkQPD4rfnIwkmlb7mTPfBgyljt6Kvnym0Q9c0y/S2hrW+Nx7Dx6cQ9gVoHgAb8g2nEPl0s0/CrgZTXPzQ8js56lYz2kMERGVwhq32OdCPtkboUebEKYxyyxfK5paP9zNSLNmR9hZpoQqzl6idtNrfT3KZcAmjL+YxURE99mi+pQBki4WZQlAq3ko/RfIa62SMFT7/t1RbBeqL+eP55a/sKhsF0au1/HNKSxl+ube3aLwm0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5302468f-6d98-4fa7-3eeb-08dda91baf32
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2025 19:10:52.6562
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IIIWCcIw4CjyHSym5fe13gZaA8G6c4I2uDgxOIe83iQP5XAaMUeuAP9gDRAUo2vZCDcPp+iM13/BpXDxYEET/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4637
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-11_08,2025-06-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 mlxscore=0
 mlxlogscore=999 phishscore=0 spamscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506110161
X-Proofpoint-ORIG-GUID: 7O_UZt_9mIeFpyMNS_fvxpq3WGu7O5vB
X-Authority-Analysis: v=2.4 cv=EJwG00ZC c=1 sm=1 tr=0 ts=6849d4c2 b=1 cx=c_pps a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=h6pNz4pCAAAA:8 a=yPCof4ZbAAAA:8 a=vRSfqmNgIlPkt5tEergA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=ZpoZn5rNyLF8gW58NSEC:22 cc=ntf
 awl=host:14714
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjExMDE2MSBTYWx0ZWRfX+8lC7IDlzoKL lQ7KlyXXtsPahNSMSdZUakdiJiDRpC1R5ket9fSDoZIw8C4IGlRA0+XNYT/siZnh1C/5midnQWX jTwJ2Lr6KiYYnBjLvOFbQ8Eux9X3srNz+d8q7Wy0hiaxZAiXxzzhVW+9xuHGUvuh/Cyo6xLzRAf
 I8zTRUFaLlPOuDrQ1fYoKb2uHmVo8I4hRxDRhQBjV2VUWwBTXD9cSlzU4rkQHwUeyTh94cpKh2v QfRyHsfh8THojyy1ihHOrWqa/JvgmpeSQYhaSV0UJq078pI310LBcfkGSs6ku6abcOVUxxdjAvO 0U3gicXxO6dYVVoroKVXib49RkMFJfc3RRKLjmnvMP6O+WXgDXJEdBqNgp/RydarC/DGZhnYk3k
 FUr6QZh+NhtApJ0oZK/Na/eUa/i2ZOOocnD6ZQu27lTo0unj+5Mc/znj74dBcmqUoyt07HpW
X-Proofpoint-GUID: 7O_UZt_9mIeFpyMNS_fvxpq3WGu7O5vB

On 6/11/25 3:05 PM, Nikhil Jha wrote:
> On Wed, Jun 11, 2025 at 02:54:09PM -0400, Chuck Lever wrote:
>> On 6/11/25 2:50 PM, Nikhil Jha wrote:
>>> On Thu, Mar 20, 2025 at 09:16:15AM -0400, Chuck Lever wrote:
>>>> On 3/19/25 1:02 PM, Nikhil Jha via B4 Relay wrote:
>>>>> When the client retransmits an operation (for example, because the
>>>>> server is slow to respond), a new GSS sequence number is associated with
>>>>> the XID. In the current kernel code the original sequence number is
>>>>> discarded. Subsequently, if a response to the original request is
>>>>> received there will be a GSS sequence number mismatch. A mismatch will
>>>>> trigger another retransmit, possibly repeating the cycle, and after some
>>>>> number of failed retries EACCES is returned.
>>>>>
>>>>> RFC2203, section 5.3.3.1 suggests a possible solution... “cache the
>>>>> RPCSEC_GSS sequence number of each request it sends” and "compute the
>>>>> checksum of each sequence number in the cache to try to match the
>>>>> checksum in the reply's verifier." This is what FreeBSD’s implementation
>>>>> does (rpc_gss_validate in sys/rpc/rpcsec_gss/rpcsec_gss.c).
>>>>>
>>>>> However, even with this cache, retransmits directly caused by a seqno
>>>>> mismatch can still cause a bad message interleaving that results in this
>>>>> bug. The RFC already suggests ignoring incorrect seqnos on the server
>>>>> side, and this seems symmetric, so this patchset also applies that
>>>>> behavior to the client.
>>>>>
>>>>> These two patches are *not* dependent on each other. I tested them by
>>>>> delaying packets with a Python script hooked up to NFQUEUE. If it would
>>>>> be helpful I can send this script along as well.
>>>>>
>>>>> Signed-off-by: Nikhil Jha <njha@janestreet.com>
>>>>> ---
>>>>> Changes since v1:
>>>>>  * Maintain the invariant that the first seqno is always first in
>>>>>    rq_seqnos, so that it doesn't need to be stored twice.
>>>>>  * Minor formatting, and resending with proper mailing-list headers so the
>>>>>    patches are easier to work with.
>>>>>
>>>>> ---
>>>>> Nikhil Jha (2):
>>>>>       sunrpc: implement rfc2203 rpcsec_gss seqnum cache
>>>>>       sunrpc: don't immediately retransmit on seqno miss
>>>>>
>>>>>  include/linux/sunrpc/xprt.h    | 17 +++++++++++-
>>>>>  include/trace/events/rpcgss.h  |  4 +--
>>>>>  include/trace/events/sunrpc.h  |  2 +-
>>>>>  net/sunrpc/auth_gss/auth_gss.c | 59 ++++++++++++++++++++++++++----------------
>>>>>  net/sunrpc/clnt.c              |  9 +++++--
>>>>>  net/sunrpc/xprt.c              |  3 ++-
>>>>>  6 files changed, 64 insertions(+), 30 deletions(-)
>>>>> ---
>>>>> base-commit: 7eb172143d5508b4da468ed59ee857c6e5e01da6
>>>>> change-id: 20250314-rfc2203-seqnum-cache-52389d14f567
>>>>>
>>>>> Best regards,
>>>>
>>>> This seems like a sensible thing to do to me.
>>>>
>>>> Acked-by: Chuck Lever <chuck.lever@oracle.com>
>>>>
>>>> -- 
>>>> Chuck Lever
>>>
>>> Hi,
>>>
>>> We've been running this patch for a while now and noticed a (very silly
>>> in hindsight) bug.
>>>
>>> maj_stat = gss_validate_seqno_mic(ctx, task->tk_rqstp->rq_seqnos[i], seq, p, len);
>>>
>>> needs to be
>>>
>>> maj_stat = gss_validate_seqno_mic(ctx, task->tk_rqstp->rq_seqnos[i++], seq, p, len);
>>>
>>> Or the kernel gets stuck in a loop when you have more than two retries.
>>> I can resend this patch but I noticed it's already made its way into
>>> quite a few trees. Should this be a separate patch instead?
>>
>> The course of action depends on what trees you found the patch in.
>>
>>
>> -- 
>> Chuck Lever
> 
> It shows up here, so I think it's in v6.16-rc1 already.
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?h=v6.16-rc1&id=08d6ee6d8a10aef958c2af16bb121070290ed589

In that case, post your fix delta To: Anna, Cc: linux-nfs@ and she will
apply it for a subsequent upstream pull request for v6.16-rc.


-- 
Chuck Lever

