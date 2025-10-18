Return-Path: <linux-nfs+bounces-15367-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A02A8BED827
	for <lists+linux-nfs@lfdr.de>; Sat, 18 Oct 2025 21:04:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A8653AB6B6
	for <lists+linux-nfs@lfdr.de>; Sat, 18 Oct 2025 19:04:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80EFB1F584C;
	Sat, 18 Oct 2025 19:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mlJJOurt";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="HTSkwxWQ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B10A71EF363
	for <linux-nfs@vger.kernel.org>; Sat, 18 Oct 2025 19:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760814268; cv=fail; b=twV0H+Vyas7roX3XVYAiabKdSr2tH664qy0CW2mBnclV6yPZifSJgHr3mG4TTQAsG9grHm0wgI8g6PgCcChOIV7Y8/yyAaYfw9W3tVYL3k4LE3c11LdRtgIbIvKspb37gT/oilKowYu4GrN+LHn1XNqswXClmIVKvbQrZPxbb+0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760814268; c=relaxed/simple;
	bh=GQ7I+AIanOHmehNQVrrdS+Gkd6hlscY5l6w3EzKoS+4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jemHIP0gBVICKmNf2icXiUK2GXmGvSUjs5XEf01uqxEo8nkm4YNglcNm2muzP4iDmB8UV6keJV3URbZW8AWCSYT+fVx3B2+HY6X6v4F0X01Oi9Et+ZuOD0wJnVrRB3iAOT843upUkpeLXd8VMQUQ5dwjDAUzjHQXcBymOTIMjCA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=mlJJOurt; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=HTSkwxWQ; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59IGYntt003524;
	Sat, 18 Oct 2025 19:04:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=NJ4+bTRntxJ5xG4WuTRzL4KFFp/nmXRkUoQJT2N5kfM=; b=
	mlJJOurtafp5lb7Wuh4dDTzMOeIGn7GOZXIRa1Uy1GjkLUNkYE565Y2MTvtTpRaG
	X3wMHJbfgfQVB7WWmRAwetlIv4m58Vemas6D0btN9EtvLfWKhBxFVWW28LYgnWpH
	tK9JjmewvqBu3WdH5BwEcmZyXG35kJwMLUGlJY10Q4ycMCVF6ARBiYA1BKZf01WD
	43vmaCP9FGXRpHKz7juBprw/cJ8db9V6bmabhZpDEQ5QcmPwb0ZR9VtYYjb3ArA3
	A7nJ42ns2G3n8R996ejKMvTlxegPnROeBSZyoSBVGO8N2sITR1GnfTAlluXYobB4
	gzduAQZ6UJYb4UvwuUCRxA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49v301rfk0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 18 Oct 2025 19:04:21 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59IJ0bvm032281;
	Sat, 18 Oct 2025 19:04:20 GMT
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11013034.outbound.protection.outlook.com [40.93.196.34])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 49v1baf6cf-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 18 Oct 2025 19:04:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K1ABJFtN3qb1FJe5balNFv8/sW/yYlqPTaVrmjMAsvKMSsn0ofLauO5SZKsOL4Xpj7vBK6KnxkwwsfmbQfkEQe+ImBLMUzrlU2eXn6at3dUEeUXu01yrTaBUwYDAkDiP6FtDN4YhiypL+iJZN5WOOCPG3TqO6Tc14xUSbXhPQDIEPQe8Sjff78x1D/dRWMQLSUfzFDN96psG7lZiwDJbPuCNKai4LBn9sfZUf7bmbSdSJrGhfqrQs/Wes63b79wTVYlOPf/35lprI/uZRYyki1u9NUleAWOL7VKJBY1bveLPCsm4zuYavAKCwsWxWFwCxFzYhrBztItk1yk8NKdJ4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NJ4+bTRntxJ5xG4WuTRzL4KFFp/nmXRkUoQJT2N5kfM=;
 b=dqoFP2P3PUfat2ADgfi2b8Uhd0DgYRYT5Qz+ZaxmcdQAwnZ5HIA1cqnVl570nEf4xQjEeJCLmLUxxPvNWBsOvS4pEdzJaAR4yqBRiQPom5gayLwjt2Li3wtY3c51XSAUYy2YYb0ieQy58gJbH2B1VBh58tl/fk008ScM05K4pEq9S1HM5cZjK34KOBSYSYbxrfTYWGB9exss06ZqMg03gLx3e3fscqplhf7IJWiZrfejiVQmJ9SyL8EokjaJSS8mpdCLtD6tO1oK+CuWldun7pQcyp6nBnjh19qcFvtL1IrysRCL4XzBiPfZQPZmMwGkt7GMy5JkEyyVDyZb+ppz4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NJ4+bTRntxJ5xG4WuTRzL4KFFp/nmXRkUoQJT2N5kfM=;
 b=HTSkwxWQugP3AfDsLFZHWwjpyFTrkqdyOhQD9yzGxtEQKBoadia7ejUh6knI1wBDc2nY+ybwFQEtgrHSROxIzou3FTsUEbVbWPFMwGYCBBBAExMPySoI4U4VdWA7rgOUSC+PRSMwhkoeNZsVlPuUY+0NmH65EVZA0k5wU0HkUEE=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS7PR10MB7299.namprd10.prod.outlook.com (2603:10b6:8:ea::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.14; Sat, 18 Oct 2025 19:04:17 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.9228.012; Sat, 18 Oct 2025
 19:04:17 +0000
Message-ID: <3ab2c457-b4d3-4c3b-b41f-4948653f06b8@oracle.com>
Date: Sat, 18 Oct 2025 15:04:15 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/7] nfsd: discard OP_CLEAR_STATEID
To: NeilBrown <neil@brown.name>, Jeff Layton <jlayton@kernel.org>
Cc: Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>, linux-nfs@vger.kernel.org
References: <20251018000553.3256253-1-neilb@ownmail.net>
 <20251018000553.3256253-5-neilb@ownmail.net>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20251018000553.3256253-5-neilb@ownmail.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0070.namprd03.prod.outlook.com
 (2603:10b6:610:cc::15) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|DS7PR10MB7299:EE_
X-MS-Office365-Filtering-Correlation-Id: 78cfb369-3dd8-430b-2657-08de0e7922c2
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?Y1dwcWp1NVBKUGRidnR2QWYraUtnakM4dUl3ZVNtajIyNjJnWlpyVHZnUG1O?=
 =?utf-8?B?VXQvbmdLbGJjd2pnNHN0dDJ2WTB6VkRxajcrdWkyQkxYdVc5SnpjdGRWUGEx?=
 =?utf-8?B?eGVQNVhMd2MxcVEvZjM3cXZHTTJNQmZEMGV5QmR5UmpxdG9iNHRLTXBEclor?=
 =?utf-8?B?TUk3OE9qdTZsMzlWdG5QUC9VSGJDUmQ5MTVxMWtDMmEwTFJkY2tPVCtyTUF2?=
 =?utf-8?B?WEV3c0pwSmdiM0dMbW9sc3dHYzNaamEwNTNlekZtY2tCRkRCT1A2UFF5czVj?=
 =?utf-8?B?ZS9GWVNTV2N1S2UzS21yYnFaTWFBVmpLd2p2YkRVcVFJaDJHOTlxdVBBWk4v?=
 =?utf-8?B?VUcvSk52VytFbkdpZjRuU2F6RUpDV1FZNVo0aVYwRk1yQnFJVTRSZDBqRldy?=
 =?utf-8?B?U3pycXh6NmJFcVNmL3dDaklIeWoxamwwWWFKN3RvampxTE9yKzcrcUV5Rm43?=
 =?utf-8?B?U0ZObk5OQ2FVM05BQ1QxVW1QQlhLUWhiMjluMkhjeHVzTi8rNVFxc05KZDhB?=
 =?utf-8?B?NlFhUkVaVmFVdU8xdFVYZjdNQ2JlVFhpNGNkQU5KUG5sT2Y1NHRSQ0dRY1Jq?=
 =?utf-8?B?QzJyU0VodjZBcDlHTHJBaExxQ2dENnFqUE1QVHBDRXF2My82Syt4U2RrRFUw?=
 =?utf-8?B?Z09zNzFCTy81NjZoZ0x5dzNPOXkwa1RpU1Fkd080V09YcDF4VlNzdDBMc0Qx?=
 =?utf-8?B?Yk4rM2pTVUNENEdOV2RKeThLNWR0THZJNU5TalV4TFhWaVRJMTJmYk80MTll?=
 =?utf-8?B?YlFDTzBFc2RFc09UKzUxMEtXOHE2SXdVVFZKMjhhdG5vWWd2cXdxK3pzUEZH?=
 =?utf-8?B?dHo1VlJTSDY5SHVXTmxzRG1rRitTMGZISFBlRi8rMVJKdUNwK2hoaXJJM2ZU?=
 =?utf-8?B?THJxYkM2elBQdXZMZzRhMFkybmRCZUgxeDlzVlpWa0JObXhaTGxjL2UrWTZR?=
 =?utf-8?B?NHJuMWVCVVV5Sm02QVQ4YmxwdmVOMSt3YnZ2SW1YNWJvT1Yvc2lWWnJuR1dE?=
 =?utf-8?B?NndjOTRsZHB3Wmp6eUtibVRHcFNuN09Vdjh4V3JQVHdjcjlDN1c3bksrVEFl?=
 =?utf-8?B?cjhDWVlVU2V0djZ4S1JyMitoRGw2em5zek04SUlPbmdwOHczRG03NjliMmR3?=
 =?utf-8?B?ZHpkdnh1TGFHWDAyT29wUHF3M3AyS2VQaWdxS1V6UG5UUUNxRkw5cFN4aUJ2?=
 =?utf-8?B?enpsTlJPcXVVa1JaVEV2T2xaeXB4RmlKRDJwMk9pLzdkKzhRS3IwLzZ0bWxo?=
 =?utf-8?B?Qys5OWllMHJqM2k2ZmIzNVNTK2lYL2dsU1Y3WWRZS3pQNVluYW9RcGlLd1h6?=
 =?utf-8?B?eGxyV3lzYnViUENKNTh4ZFM4L0I1YlBocVVqYVRxYmIwbWQzbVJ6bXU4ZW56?=
 =?utf-8?B?bHdITjM1UFBvaWlNdVN0c2IwSW9jT0t3YlBzQXlPYU9kVTBxY2QzWGVCWCtD?=
 =?utf-8?B?QnhwSmZMTlJvRzRmWWtDeWI5VXFpa083ekNMUkgxWnFBMEJPMGhBQk8rS3Vy?=
 =?utf-8?B?YStZY2V0S3VIRlY2NE9jWURxaTEzVWVGTmloREpUYVhaOU5EemRtaitJaHhB?=
 =?utf-8?B?VHVEQk1vbE9CbXcwZ2l3RXl2aHd4MTlRVUk4UllseDBncHNVemovbTAweUpp?=
 =?utf-8?B?Vkx3bUxZcVdGZDc3cTFJUWJhSTkwdFg3MW9GTGo4S01xWE1Jc0RTVU5IbHBY?=
 =?utf-8?B?QlpOakFVbWtVNE43dW5hQ2hhdDlJY0RndWsrbGxuNVBxeEhNMmY0TjlCVU1w?=
 =?utf-8?B?THNHMlRoM21pRy9MbDJQWjNsSnF3NjdWdlpwM3VyRDB1WDBhQjRVRWpla2pq?=
 =?utf-8?B?RnNDRlBsZ2VLYkdzUG81Zk1PRThpRWQwWXZlVUQzVVdVTFdLeVUycmxEK3Mx?=
 =?utf-8?B?S1FGM3RzRlp5b1MrMGRROXlVRUtjQWViaHdQMkwzdmZkckp0WHpqeWxmMWdu?=
 =?utf-8?Q?Uws6jvxM3IW0ByFbhsTvhOMzYROjcXo8?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?MHpvRnhlNXBBVzdEejY0ejI3WW9sTGJvakhsUUlBR3RxdTZ0VFZFOWlaSUhl?=
 =?utf-8?B?MlZMdzRZT2gwVW80T25nalI3TjU3UkJPaWZZV1ZyOVZrL1I0aFBtazRjMmJ5?=
 =?utf-8?B?R3FyQk1PQVM1Q2JMTGZqNHF5LzJubmUwRHVlemZLRVIyVFVQN2k5Um9hWjVF?=
 =?utf-8?B?VjZXQVJHU3hQZ010OERTR1lvSU5PTG5UZW01WFJqMlJiWDBaRUVsQTg5TU4y?=
 =?utf-8?B?UG9lOGZHTHlVcVNzWWNBNFlNc2tLTGJlTHZ0V2wwSUxpeTBta0U3dGNjL1Vs?=
 =?utf-8?B?eUtMVVZnRTBWSFdhNGw4YWpvMHVjdUtIV0pESnJVVnVWendMLy9HWXFhKzBu?=
 =?utf-8?B?U0M3bGNzUHZ3bFU2STVxblpMVEJuZGpiMjFNUEFRamtBZ213clhkNnV1VXJT?=
 =?utf-8?B?RFBYZmZtSnZWYXRGa1VwclBEYW5PSWpxOUFOa05EL1BNb3gvSTNHbk9nMUNI?=
 =?utf-8?B?SjkwRDN0WE1ST1JQQWV2blpCaHpoWkhJWk9DSS96bDJUVFR3N0ozOE9ONU9s?=
 =?utf-8?B?ckpOMlh2VTVPTmtnNXgyazF6YjF5WE11Q1VYVUkxZm05UkFSZFV6OGUvTXRE?=
 =?utf-8?B?alVsQk9ZbC9ES1pqMU0rNnBZc2FYbk8yTE01UmZEdmlZa1hlQ2F1b2M5RHlY?=
 =?utf-8?B?ZHNkc0xkc2M5cCt0dy9IVENoNjFrVkpNWDJFaVdwbnFmem1IaDdIY3BMOWIr?=
 =?utf-8?B?b0E0WEliSnNxWkJmVytBMFBsbnZmYTY3SzE2SkJXRkx5UlQ4YWhGaVJvRk5F?=
 =?utf-8?B?RlFXS0lWejkwMi91S3M4QWpGQjZIOGVUanF6c1ZjQjExWmc5aHU1VDl2algy?=
 =?utf-8?B?MXJyd1VlRXk1RWtYTDlncEdyT2xSajdHSGJobDV1Wjd4NnZFb0dxNzVRZWx0?=
 =?utf-8?B?MTRLbUNsam5nTjVSaE9IQ2FFTE1EK0Nnb1dmRXR5cGNRZnU1bXpsRDJsRTBj?=
 =?utf-8?B?SXlUdXBSd2I2eWp4eHd2QitZWlpwY1BHRUxycGpaVGxTc2RsKzJhaGFwaTNG?=
 =?utf-8?B?Q0M2d3g0VnhyeElMd1VpQ1VHSUNuZEV2QndITjVqN2Q5L3NZbXUvcXRCYkRz?=
 =?utf-8?B?YTNsNG9ickRmRVBtdmlld25OSzFPdU0zQTg0UG4veVVPYTBkVkQvWXJlMGd6?=
 =?utf-8?B?Zm1QL2tVVjkxWXR6TWREM1JLWXpKT01ZTVhGYUdUZExMNElLZXUvaklIaUc4?=
 =?utf-8?B?VkNybk5ES3lzQXpqUzkvZkZsam0xbktZUzVjV0pGOHQrRU5zQkdiQjRrcEFQ?=
 =?utf-8?B?UVBYZ1BiOFY1YnlaOU9raS9Wdk5kTkxwOHVPazBSdTE1dW9XY3NOQ0J2TFdV?=
 =?utf-8?B?SGpheVlwbjkzNytnS2RPU1BLRjJETnZ4OGtYOTROVUF6TmRDYTlZS0J5bVAr?=
 =?utf-8?B?cHVta0VWRFQ5TlFDUXJrQi8yVEszcEJFdUl3SVA3eVlwYXNma0trQ2krZGtk?=
 =?utf-8?B?MzZQU00yTDd4aThDT2Y3WmRScWpiL2wrdjg2M0JLeWxuZ0d0b2ZlcGpKWHZw?=
 =?utf-8?B?UmhFWTBOR0h3aGRudndUUmdjZE9yV1ZLMkdxdG11Q0htY0owb0lHclB3dU1U?=
 =?utf-8?B?M3BrbG1KcGYra1dTU0RmRFpzNWlOdDljY1JpUWdMbk1peFMrcHI1eHhaUHNJ?=
 =?utf-8?B?WEJDS2ZaNnZxWlNjS2ljRWJ4TWZ3Q3czVmdyd2xwZGdNWm5PdWVIYldEbUZy?=
 =?utf-8?B?OGNNTXVBeWlRZmpvenVGQVI3Zk5iQTFPcVlmWFkxV1I0WVc3MEFHQmx6MHla?=
 =?utf-8?B?U3AweHZ4T1h3K3NReDFvSU5nMENFY0swQmNrSFVTU1NiVEllcC8xclZDNUZK?=
 =?utf-8?B?aGRvcXBlc1RoTTkzWVRnanczU0NJMTlLUzE4RVVOM3RIV3BBaGlTc3NyL2Rw?=
 =?utf-8?B?OTMrZU9GRWxJd0hTS1J3VmI5TU1GZ3pPYnVwbWkvejJBelJsemdOY0xrWkxJ?=
 =?utf-8?B?OWtRalIwMVM3Qmd2UVRVZlFKenU1U1k2NW5ER0FabHUvcEJ0cC9CQnE2d3ZM?=
 =?utf-8?B?WnF2M0x3dlI3NWlWdi84VG5UN1IrVE90WDdnem5sUjdCNWNzS3ZYMld6eG1j?=
 =?utf-8?B?YWdENk92UGFKOTFveHlaNHlOR3JKdWN2SXU3Y3dkUFUwZEh5Z2pZL1U5ZWJk?=
 =?utf-8?Q?gdP3LNhC8UYhT4EqnRl7wJjOw?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	nlUwYSmErvaWIgg3RbCSa4GlG088deDMyHezjA/8xuf7aPFXos39E0+iPeFE1YrpHhLBp/uJV0WyF2cv85kIyNclba9EYP/6aI0rw0YPb7ucpUK616kdT21sH4+hNkPgtCG3ZMAzmz6Oji9b16oRVrN/3KpabRev6Lbon0+3Az+In3qY1Xy3Aap9J9w0cZOaVAMV6lpAHyclbZ37PNTCqAQYiOZTVjmg2HumPnAtsCwoNOeNuxZxoupFMGE+QJS5FTt0koUia/pI3Z//dhkjuUmWzh7F/5t8Z/Dj7w/RoK5hA0Qcl9oqvPIRXFoDYBrm3Gc2UmLV+3v5srcaa/cqipDCsxgu/s2kR6J6F3KL/cMjZ1sebbx++otqoB1qyz+3zgG3j46NXc61Erc71Cnm1GCoPtEY+D0JaBLML0XlKxlZRAqszJ1nebgVkWwMTWjVmqzRcr1KsQbk5wLL6LjgH4GhflkuV3JIdVLG9yErzh0N0WSez3K5CY5N0hBxQkLGXJX8Mcs8JY36cmFc984ZnfuyJnjlV3m2OMHyWyHI3UOp1mpo6fFBB8fye8TBbYtWfoAnh5q9dyB+o32XTQKQVS7t183vceK0Jouk4ryCl0g=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78cfb369-3dd8-430b-2657-08de0e7922c2
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2025 19:04:17.1507
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IKgOH0v8A940NhsSnHbqhTUWTkgUGy5x5EaJm+LiPQY87HDyHv4cmmSnEl3I9z5To5rQ0D26H9U7/rm4a3Ufjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7299
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-18_06,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=844
 phishscore=0 bulkscore=0 mlxscore=0 adultscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510020000 definitions=main-2510180138
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMSBTYWx0ZWRfXxx7CZDrpQqid
 YXRK4cGmTByPQlIHvlGMQDfvB7QVqA3rNJKDZCWH6qH7t4mbk7O10u3JDjeTg05iNwpJrSILIsE
 pyT33eSm0OIXoZYW84Io7Kq0mFEo1Aidz19nJgcfGPx+wSpjlZTbDIoEe26SVoBmINhKuiXbBad
 MtHsEnAl1QDVKMWhHosQhH3KyibSQr1GGCjHm/0kbXDYyCgjQJBJbyTEYumeB08gIFbfPEjs/Lu
 dh6L2eOGbDjULV8CawaM2EoTxkA5Zmw1s0K2uMq4Dd/rnvyE4AYhyjXYacLQpAcJhn3T6QkGOwx
 tCE5czhITfepJR/zdRtOVRVgqndhinaHmi+Pws6YkAxv2ijAHV6DgNzKPnhSqQOaa3jh9Mbf0W+
 FMQDol+9fQOS+Ttyt98rHhq8N+rwqX7ZwAsuf2h3owuoLXFlU3c=
X-Authority-Analysis: v=2.4 cv=Gb4aXAXL c=1 sm=1 tr=0 ts=68f3e4b5 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Q8rMFvucb8MKGmG8mJIA:9 a=eNoJ2FaVHyJ3Oczt:21 a=QEXdDO2ut3YA:10 cc=ntf
 awl=host:13624
X-Proofpoint-GUID: YtSZTHCAHo4ARtX09I_syx0Iyt4HpnFZ
X-Proofpoint-ORIG-GUID: YtSZTHCAHo4ARtX09I_syx0Iyt4HpnFZ

On 10/17/25 8:02 PM, NeilBrown wrote:
> From: NeilBrown <neil@brown.name>
> 
> Having per-op flags which significantly simplify many ops clearly
> has value, so ALLOWED_WITHOUT_FH makes sense as many ops don't need to
> check for a valid filehandle.
> 
> However such flags reduce locality: you cannot look at op_foo() and see
> everything that happens when the FOO operation is received, so they
> should be used with caution.
> 
> OP_CLEAR_STATEID does not simplify many functions and the simplification
> is minimal, so I believe its value is not worth the cost.  This patch
> removes it and calls clear_current_stateid() where it is needed.
> 
> Note that the existing code only calls clear_current_stateid() when an
> op returned success.  This is not required.  It certainly must be called
> on success but calling it on failure is of no consequence as the whole
> COMPOUND aborts in that case the the current_stateid won't be used
> anyway.  So the new code pays no particular attention to status.
> 
> Signed-off-by: NeilBrown <neil@brown.name>
> ---
>  fs/nfsd/nfs4proc.c | 20 +++++++++++---------
>  fs/nfsd/xdr4.h     |  6 +-----
>  2 files changed, 12 insertions(+), 14 deletions(-)
> 
> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> index 5b41a5cf548b..944f10a08c77 100644
> --- a/fs/nfsd/nfs4proc.c
> +++ b/fs/nfsd/nfs4proc.c
> @@ -685,6 +685,7 @@ nfsd4_putfh(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>  	__be32 ret;
>  
>  	fh_put(&cstate->current_fh);
> +	clear_current_stateid(cstate);
>  	cstate->current_fh.fh_handle.fh_size = putfh->pf_fhlen;
>  	memcpy(&cstate->current_fh.fh_handle.fh_raw, putfh->pf_fhval,
>  	       putfh->pf_fhlen);
> @@ -703,6 +704,7 @@ nfsd4_putrootfh(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>  		union nfsd4_op_u *u)
>  {
>  	fh_put(&cstate->current_fh);
> +	clear_current_stateid(cstate);
>  
>  	return exp_pseudoroot(rqstp, &cstate->current_fh);
>  }
> @@ -864,6 +866,7 @@ nfsd4_create(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>  		create->cr_bmval[0] &= ~FATTR4_WORD0_ACL;
>  	set_change_info(&create->cr_cinfo, &cstate->current_fh);
>  	fh_dup2(&cstate->current_fh, &resfh);
> +	clear_current_stateid(cstate);
>  out:
>  	fh_put(&resfh);
>  out_umask:
> @@ -931,6 +934,7 @@ static __be32
>  nfsd4_lookupp(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>  	      union nfsd4_op_u *u)
>  {
> +	clear_current_stateid(cstate);
>  	return nfsd4_do_lookupp(rqstp, &cstate->current_fh);
>  }
>  
> @@ -938,6 +942,7 @@ static __be32
>  nfsd4_lookup(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>  	     union nfsd4_op_u *u)
>  {
> +	clear_current_stateid(cstate);
>  	return nfsd_lookup(rqstp, &cstate->current_fh,
>  			   u->lookup.lo_name, u->lookup.lo_len,
>  			   &cstate->current_fh);
> @@ -2929,9 +2934,6 @@ nfsd4_proc_compound(struct svc_rqst *rqstp)
>  			goto out;
>  		}
>  		if (!op->status) {
> -			if (op->opdesc->op_flags & OP_CLEAR_STATEID)
> -				clear_current_stateid(cstate);
> -
>  			if (current_fh->fh_export &&
>  					need_wrongsec_check(rqstp))
>  				op->status = check_nfsd_access(current_fh->fh_export, rqstp, false);
> @@ -3374,7 +3376,7 @@ static const struct nfsd4_operation nfsd4_ops[] = {
>  	},
>  	[OP_CREATE] = {
>  		.op_func = nfsd4_create,
> -		.op_flags = OP_MODIFIES_SOMETHING | OP_CACHEME | OP_CLEAR_STATEID,
> +		.op_flags = OP_MODIFIES_SOMETHING | OP_CACHEME,
>  		.op_name = "OP_CREATE",
>  		.op_rsize_bop = nfsd4_create_rsize,
>  	},
> @@ -3423,13 +3425,13 @@ static const struct nfsd4_operation nfsd4_ops[] = {
>  	},
>  	[OP_LOOKUP] = {
>  		.op_func = nfsd4_lookup,
> -		.op_flags = OP_HANDLES_WRONGSEC | OP_CLEAR_STATEID,
> +		.op_flags = OP_HANDLES_WRONGSEC,
>  		.op_name = "OP_LOOKUP",
>  		.op_rsize_bop = nfsd4_only_status_rsize,
>  	},
>  	[OP_LOOKUPP] = {
>  		.op_func = nfsd4_lookupp,
> -		.op_flags = OP_HANDLES_WRONGSEC | OP_CLEAR_STATEID,
> +		.op_flags = OP_HANDLES_WRONGSEC,
>  		.op_name = "OP_LOOKUPP",
>  		.op_rsize_bop = nfsd4_only_status_rsize,
>  	},
> @@ -3459,21 +3461,21 @@ static const struct nfsd4_operation nfsd4_ops[] = {
>  	[OP_PUTFH] = {
>  		.op_func = nfsd4_putfh,
>  		.op_flags = ALLOWED_WITHOUT_FH | ALLOWED_ON_ABSENT_FS
> -				| OP_IS_PUTFH_LIKE | OP_CLEAR_STATEID,
> +				| OP_IS_PUTFH_LIKE,
>  		.op_name = "OP_PUTFH",
>  		.op_rsize_bop = nfsd4_only_status_rsize,
>  	},
>  	[OP_PUTPUBFH] = {
>  		.op_func = nfsd4_putrootfh,
>  		.op_flags = ALLOWED_WITHOUT_FH | ALLOWED_ON_ABSENT_FS
> -				| OP_IS_PUTFH_LIKE | OP_CLEAR_STATEID,
> +				| OP_IS_PUTFH_LIKE,
>  		.op_name = "OP_PUTPUBFH",
>  		.op_rsize_bop = nfsd4_only_status_rsize,
>  	},
>  	[OP_PUTROOTFH] = {
>  		.op_func = nfsd4_putrootfh,
>  		.op_flags = ALLOWED_WITHOUT_FH | ALLOWED_ON_ABSENT_FS
> -				| OP_IS_PUTFH_LIKE | OP_CLEAR_STATEID,
> +				| OP_IS_PUTFH_LIKE,
>  		.op_name = "OP_PUTROOTFH",
>  		.op_rsize_bop = nfsd4_only_status_rsize,
>  	},
> diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
> index 368bad2c7efe..0ca30a92d40c 100644
> --- a/fs/nfsd/xdr4.h
> +++ b/fs/nfsd/xdr4.h
> @@ -1027,12 +1027,8 @@ enum nfsd4_op_flags {
>  	 * the v4.0 case).
>  	 */
>  	OP_CACHEME = 1 << 6,
> -	/*
> -	 * These are ops which clear current state id.
> -	 */
> -	OP_CLEAR_STATEID = 1 << 7,
>  	/* Most ops return only an error on failure; some may do more: */
> -	OP_NONTRIVIAL_ERROR_ENCODE = 1 << 8,
> +	OP_NONTRIVIAL_ERROR_ENCODE = 1 << 7,
>  };
>  
>  struct nfsd4_operation {

LGTM.

-- 
Chuck Lever

