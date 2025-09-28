Return-Path: <linux-nfs+bounces-14755-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E0064BA7782
	for <lists+linux-nfs@lfdr.de>; Sun, 28 Sep 2025 22:14:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2710A1895790
	for <lists+linux-nfs@lfdr.de>; Sun, 28 Sep 2025 20:14:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 774FA27703C;
	Sun, 28 Sep 2025 20:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZKIHlHXz";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="CTWxiib4"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B6D5278779
	for <linux-nfs@vger.kernel.org>; Sun, 28 Sep 2025 20:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759090457; cv=fail; b=VgpEFEPCreXWzqf/SokrGJIXcJdR8+SOD66gKgyNiMqsRXy/UNVngcfgr/k6gFmJ/dcwsLdGgVuA/j5Qx9fq2CJCGfIjb1iwFuQwsiflvjBPjurxduF9ZY7dVroK2YGbKuvsQIbM32Hn1zeUPoO/SMli5WBSBqeVfS/6LZI1A0g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759090457; c=relaxed/simple;
	bh=sCIcVTf1DnyiW+k8nCYmglGcioaWIos2ejmIwDZh3sg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=k06u3lm2H54X8KUv35yNQ7ogfH9yhHR5ufHMFRbvfAgsS1zeJEmz7PXMyYC5MWSM62MqB9fmHa+5sN+fsr4RrXxGOKI1PImw7rXu8O3doa57KuEnyGzoqgln/5EbAZgyY/IsR3kpZKdLHYsndRM3qYrY16f3VwPIeQvZoEI68cs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ZKIHlHXz; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=CTWxiib4; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58SJUJlF015851;
	Sun, 28 Sep 2025 20:14:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=GAmhAGvpOn50w3Qol8HP4yPBNFATRUASxi3B2Hha/dQ=; b=
	ZKIHlHXzsI2KOVxiOTNU6FA6QqnH+DC9w8SyMHTSz5yvui77rik5NRTZdZCHHTBT
	DdYQCalswhpIPGgiqY7l+sjSIZYAHoK6jsVRalg2cEjfH5DK5y7gMQtcSX8Mvs1I
	JBzVPqn8l41iHxgs9o+u1RoN9OO7LwY8bHCRlrw4QfMjl0R/suDZ7hc0kqxO7vNT
	SdIEeC0vsLBDoC16gN9SF/DxHuUAYCWd1UMNJB0tBNQZPkL1WK0wsEg5FGjyOcPm
	HsaDaaQ963hLwsRSnQWrmanjO3zbMimwXeutwB9+Ka2ZyyM4D5hyjXeJqvgGPpb3
	mRbvgXM0UQGidVgYOVPbAA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49fb7gr0jg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 28 Sep 2025 20:14:05 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58SF48ES011557;
	Sun, 28 Sep 2025 20:14:04 GMT
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazon11012048.outbound.protection.outlook.com [40.107.200.48])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 49e6c65k9m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 28 Sep 2025 20:14:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ofu4wk8pJM72pE5M4ND2E2afBEcEm7IiGIHbDNkGbhPMRCvJLxmqCHkF4AhRy9DTy/WK22hLLZmcEo1je2kiVY0qrFsjNQKQNDB2RqI+NpvGLxQYM38L4ch3dkI5IacStWgK4l0AZ+wZRCJMROJZuStSHwck85GCt98i7kF1hgN5SliiXrvQ9rpxJLgjwQNO5Cbo/vP0L8acgBH2FbuIuyf5KoNUc2vfzaDWN/zBjHpxEYzISXYlHYPIGL9QxeuACL2fMf8cOJ1C7ltLpnaYDHkekkPLlMzjLiVnYv50IeX96bDi5ap45qUQjjQGt7t5XMx8XTeqMu1NevaeoquVAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GAmhAGvpOn50w3Qol8HP4yPBNFATRUASxi3B2Hha/dQ=;
 b=RO28MKq1c6nR35lKCHCc/kvm64fujhVyq9Qk8S2+MTtEBVrQ6w0G4KShvgUSegDVnvuq19HKsrOEX8cRYd/s10RBzTlQ/Mf1eHXTNTff+il+jgy1N8vgMCFlUvg+imXbDo3ZJJuNUVH15YNsEoRa9w8HfSXMDo92ZOXhVclpMNOhh4mWiRkR3FRblL+lkZ0kjYYOs2Rwc0/E2OrwLP7FlvSviwxQ8F9OT+bNn5FgGj7vRldVasduTGxaMhVh0mbMnAm5q4B6NQz8DR1axEszVLDgDOgFRzEWVXo7SGH3okksb27bYzfI+RAXnEaWrwIKTpB299JJ7DUge/kDaj6pJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GAmhAGvpOn50w3Qol8HP4yPBNFATRUASxi3B2Hha/dQ=;
 b=CTWxiib4r/jr/tQNswWkOR6T4O+PMLOB2u6Ssex3qr3Qzxh7r1j6+UfF/AZb5YAImauLlosOOJGQMQpc8e4L58vMXbHv9AVf9/9xvyIcA8SbAD2qpsP04GNlaeh3hdzLm1FNXFqgBHhSjMnB0a2Pztr4fC1MfF68UccOrN4Y8wU=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS7PR10MB5973.namprd10.prod.outlook.com (2603:10b6:8:9f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.15; Sun, 28 Sep
 2025 20:14:01 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.9160.014; Sun, 28 Sep 2025
 20:14:01 +0000
Message-ID: <ca879f80-94be-4bc8-a7e9-4f55007ebeb7@oracle.com>
Date: Sun, 28 Sep 2025 16:13:57 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] nfsd: Avoid strlen conflict in
 nfsd4_encode_components_esc()
To: Nathan Chancellor <nathan@kernel.org>, Jeff Layton <jlayton@kernel.org>,
        Anna Schumaker <anna.schumaker@oracle.com>
Cc: NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        Simon Horman <horms@kernel.org>, linux-nfs@vger.kernel.org,
        patches@lists.linux.dev
References: <20250928-nfsd-fix-trace-printk-strlen-error-v2-1-108def6ff41c@kernel.org>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20250928-nfsd-fix-trace-printk-strlen-error-v2-1-108def6ff41c@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0445.namprd03.prod.outlook.com
 (2603:10b6:610:10e::31) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|DS7PR10MB5973:EE_
X-MS-Office365-Filtering-Correlation-Id: 75595f48-97d5-4e59-8b9f-08ddfecb8f92
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?b01Ja0pzNUZ5dkh0T05MVEFyQ2RCVG9HZS9GV2kzaUt4R29EbXBReWJDcUhN?=
 =?utf-8?B?VzgzbmtJbnVRWkk1WTJWbWttZVc3bCttZ0FHT3p3bHRvNTNRc2gzSExoVGw1?=
 =?utf-8?B?TlN1cFVpeDZxU25QdmdqeTdRS0gvYUR4QkdBTmdwNjIvblZiV1hVdC96MExm?=
 =?utf-8?B?U21IOHRzYU9MaGwvWmlNVXltczV1Q2xIOXpISjZXd0RwNXZqUzlPVENkdFZO?=
 =?utf-8?B?VVJES1ZkYVBEU1ZoUkJFaDVTMXg3KzRWTmRyZTVCYzQ3QnVjb1ZFemxZekVL?=
 =?utf-8?B?anRvL3dEcmlSK2YxRVpLTXNjaWFkbENqU3ZxSWdkcVhUUHNraWthTUUvN29K?=
 =?utf-8?B?UkxZbytSZXdETzI4bDRZWmFzcWNMU01ZcHBGSkoxSkh0WjhnVE15L1g3V1RB?=
 =?utf-8?B?eHhERkVyckpZbmNFbHVnMk9USU1Nd1VvMlY0RTR0M2lhbjQ5aDJldmF5akN4?=
 =?utf-8?B?ZE13NDY4ZUVyMVp6QjM5YjhYYnU1SWVBSlA3M2tlMW95SXh3T1grakRhRDZr?=
 =?utf-8?B?OE4wRU9EOXZvNTZaUjRHc3pyWEtsVHQyUkRvdlZCdGovOFZEbmhTbXVUTyt1?=
 =?utf-8?B?aU1vVzdXZHNna3ZlTENta2tYaHdoMXFRVkVaYjZLZEZvcXBLK0JKSGVQeWNU?=
 =?utf-8?B?WllKUElwaDFJSkdWSzJDZEM3cjEyRHUzM052U1oyN0NyN0RXTGFRVTJqVUhL?=
 =?utf-8?B?Y3krSi9tWGtCNm1xM0RESXRLclppbTJ3ZFdMWHhodFZ3S3AxWkI0aXNaLzVJ?=
 =?utf-8?B?ZE52eU8wQk00Nkhvai85cXhDS0FWRlpvWDVNMlhkWEpXVisyTHc3U3ZXc2tJ?=
 =?utf-8?B?cTdndUlSTVc4N21yQ2JwQU5QS3BTT2RhYmsxQ2V0YzZZWEVxVVVKeitTMWIr?=
 =?utf-8?B?RkNYdGtBL2kvdVdWcmxGRngwVFk0dS9DN2J2Tm5mZFRxa2xJTEx0MjNwekY3?=
 =?utf-8?B?eEp4NkJmcFdqMDl0c0hiVmdObmlEV3pQdFNPZElUWERRTDQraExqeS9LY2ZP?=
 =?utf-8?B?RTBnVElMUHhPenZWczgrSmRMUGcxZDM1Z1Z4SS9JNHpQT2hRL3d2RGZYNHlB?=
 =?utf-8?B?WFR6NmltU0NtVytpVFhYMlFXOXVwUW94RUUxajVNMk9FaVFoVXhCSFBTczkv?=
 =?utf-8?B?b2VFL0dSeWVjai96ajRKQ0JyOURvaG83d1lVNDltNUVmTG11b21ZRUc3ZE5y?=
 =?utf-8?B?SU92SlJCTWVIWjlMQTFoQUFwTk1jcDFEQ1dQVXZyK29ienNkU3lVa2lYRW9K?=
 =?utf-8?B?WGMzVU5VQnJxUkFZS2FUSzlHbVR1TG9BOUt4a3BjL0VIYWd1a08zWXF1RDhp?=
 =?utf-8?B?WXdqSUozTlVDcVIvaEFEUm8rb3ZQVnU3czNVakI5OUhkYlhEQnJBckt2RXZJ?=
 =?utf-8?B?T1NZak5lQy9yYkdQY0JLTG04c3pydGtxZ0hqSnIxNlZaL2ptRWhhcUJhc1Y5?=
 =?utf-8?B?REhQLzNtNVJpR3dsVnluUVFiNXZFZGhoTGdlQkM4WVNBMjhtUFFpWEJyeWVY?=
 =?utf-8?B?ancxMC9xU2RDRXl0RzdJR2FFUzNXa3pvU2FyZFRjdVd0UEE1ZVRlaHZxL0Nq?=
 =?utf-8?B?S0NpQmJhWmZVdCtFcTREZXl5RnlhZXVZVDF2bkFEYmx1cEZBanJ5bEZTMnlX?=
 =?utf-8?B?cTgzS3Y2eXJHbUFYMkQxNnN6aEFNZ0tCSVk3OXBCUEVNUFhXcnpGNE9kZFJn?=
 =?utf-8?B?N0gvLzB6RlRvNjhWQnNXZWkyaGFXYlhMWDI0cFNpWUV4NFBkT0xlNC9iQ2JX?=
 =?utf-8?B?blhRUGpWcW85TGRPdFJNVW5LdXRmR2d0cTczSjkxRThINEJMRHZHN1dYZjZy?=
 =?utf-8?B?clhlVVhCeG9DWjdWZGJDOWkvUVhjdCswdGRoUGZqUis3ZUpIVURIWm1HYVNT?=
 =?utf-8?B?WEpsTFFkMytJZlRDb01WMWpTbyt4cVFFNmpCT2tRYmVxZkE9PQ==?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?aTRDYjRIVndaSzU3UDlSOTRiMWxqYjhRck1vdFhHS2YzZ2U2UVpUUzhGUTdw?=
 =?utf-8?B?WEJ4dU1tOFdQUW1ZWVlFSDh1NDRBbXBnZjhjUGhOdVlpZ05RWlFpbEdORUtY?=
 =?utf-8?B?aEZlSWZDSG0rR0tLelVVQlNYcHZnVFRkL3dVOFVsZm1hSTBDeURzdnpRVGJz?=
 =?utf-8?B?b050MW1ycTdNZ1hKTFJEMmJIejFCKzNGYndVemQvK0djK1Y0cnoyaVFoNmIw?=
 =?utf-8?B?bEFBYW9wb0VSRE1vUjVsK1JhSHdoUmZtblVMa3hqSnArQWFNRFNSNk9BVTNs?=
 =?utf-8?B?dzRzVzBtTFMrMHAvNUxSazNEVDcwaVZ3OGRnVzg3K3ZGNzFXODAzL0ZkV1NP?=
 =?utf-8?B?RDlLb0VncmRKaldxUEJtckJ0Y2dQZFdSdUVGR3VEdDAwZXlHaFRPV0k4bzZp?=
 =?utf-8?B?ajVsS3VPZXJ3RUpmWFJuZlpTSFJZUm9JV0sycHpwcVdhWjErbkJTNFhBNU9t?=
 =?utf-8?B?czVUZ1FkR2g4cm5wbk5kdzM5MXN2SGJOTVB2SUdiRjJYK1Z5THNZRXhrdVBX?=
 =?utf-8?B?Tis3c1l3dlhKK0lsRHlnOUZBSDN1YVNkYUdoS3VPOUxwUzFGTjFZMU9iV0or?=
 =?utf-8?B?aTlCRktSUUNFLzM3ZGovUnU4aEluc0c2NndOL3JwSGg2d3ZFTVdLcExFcEIw?=
 =?utf-8?B?RzhJWXhSRjRyS24rQzVQTkhsTmJxT2pmMHBKVWtyelVqWVNIMzYyUlU5ZTJz?=
 =?utf-8?B?QjNacm5ic25tMEkrdGNJZ2YvekdmT3d6R1o0SEhGQlJId3o1alpnYjU5WUti?=
 =?utf-8?B?K3hrR01GQWVCSStOT05vbnMvUzEyUk1wU3JKdkZpdVR3RXNkU0dMRHQ1OFRB?=
 =?utf-8?B?elBPbHNoTVkxYlRTVHRweUlqWmNsK1g1dk9sWGJrR016TzZkMGxML2tFajdD?=
 =?utf-8?B?VVAzN3hJeDFjMm5leHdxa3FUbC9TQ2VSd0ppYm1DQndqRERGSlp0SHNqMEdT?=
 =?utf-8?B?MXppMVdZVkY4NkZXUFpyOHZGTFRadG5EUmZwcStWSEVxSm4rZzRSTGU1cTNQ?=
 =?utf-8?B?cDN0M0NObXlhWEhQdEszbmdFUWEwR3F4blVZQStScGNZLzhRWWdiVUtvZ2dL?=
 =?utf-8?B?ZFZobHNhbDhzTkFsbWxHamNubDVIZnBOeFFMUkswSWpyYkhTS3owdUZtSHRn?=
 =?utf-8?B?VHRMTUhST0JkWmhiZC9IVU00WkU1dXk1ejc1OXBtb3U5dkE5aDg5MGtTVHBj?=
 =?utf-8?B?V2VraFhhL3lrTU54WTcxQkVEWGMxSytBMXZac3dNWTZvVEpsUWFPeDBtU2xF?=
 =?utf-8?B?UEcxaG9hUTJxalBRRTVNalc4bzFKWnhqUnBtNloyN2VQMGNDQmI4YnIwYkk1?=
 =?utf-8?B?bWo3YWgvbUZuMFh2UGd5T3Bia1RsUTdqb3J4U1FSZEdCeFQxV3FYQzhVTXpT?=
 =?utf-8?B?SUVNc0s5bkgyK2czeXM1SVM1WFRCMHJBSDk1cDlubzRFTjN2bHJiTURsSG5h?=
 =?utf-8?B?cS91ajJyL1VFWHJVMzZyT0pPbWtlaHVxUG1weDZUMmRQYzhMdTU3SXd1TU9U?=
 =?utf-8?B?dGlYVExtNXFNa0hCeFh4T3QvanFlSEdnNDg1OWxXRmVhZ1praU1BMHhSMHNN?=
 =?utf-8?B?akUrMGNQQnJrZmxBU3VvdUVaa3NQVXRDWndCSlRUWjZtVkQ2Y3NvWDBFYzJk?=
 =?utf-8?B?M1EyZlE1dTNhQUxiMW9hRmVCOHpURkNPdmVwd2ZIZTdjTjRZVWIvTTZNZFpZ?=
 =?utf-8?B?b1hObUZySjRTR2tBd2ZkcFVHMlBHRTNHN01rUUpMNHBocG9NSXdyejBEUUhM?=
 =?utf-8?B?K3BKMEp6UDNOMGdqeW5XRFpIa1duZ0d6bmd0Mm1BOHpObVBZRDB6T2pWMmNL?=
 =?utf-8?B?V2pxb0k3MEVGdy9JUEpqVG1FazlYOE5CVkVBN3p0c2FmOXdFbE52ZDZhcUNj?=
 =?utf-8?B?MG5yWWZUTFBDV0doSW1Kdmt5NGV2cnM3Ty9UemhZR0Rma29jZUdacDlWU3o3?=
 =?utf-8?B?OThNLzVMQnlOc3Nva1RkNUtUMHFWY2QwcjE3WjV4elRXbDJndXVyejJMWlF6?=
 =?utf-8?B?VXJrbk51Nm1vSVJYZi9sckpiR1pVUnRMa29OcGhJUXdTZ2IreEwvTE1lUXoz?=
 =?utf-8?B?UVIyQm1zYmorQ2FDc1hLQi9FZXBwVnJKZWJSV3JzdFVvL2F6ZjUyNThPODZ0?=
 =?utf-8?Q?7QeTh+yQix/oEk0zTiFia4Fid?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	U6tysxvZMosS4pNy4mtI52UKYf1wYVWaoy4xA96meCOMIZfUWfGUT047bLabS/C+zYK4y5ufAcw8JOHRtt3oUdA0MFtaTA49WYSs2CCyQQcJLAkE+nmGAN6nXEFu4OocT/iBptF0cHUUMxFwux+Wv15rRZSBCLu+pkAop66rGotKYxNepQ6ccubSA99MNSXV8xKQFrywxfG2/LGltPVUk8+fnds1DuUeKX0lXYCzvKT4bdnh/mMJbbuXdLgF/P6wPoQPtndX6QzBdaULABe7/wN1MCsIDU0bsfwhGEubU3kiJXJ+lzyOyfUqIkzyUkAFJLtmweVhFG+MMtKWtG4MykhJnd5AKjbNVcF+idWvSw3VyIJ59j8GKRL703z7uw7PR9bmhxv5ZLOXklDvXQVssLBtUBijXp9rV4e6PhUVGA9VFC/MmuGI+ChlsOr1tShpy76IzGma999NgrZIRRdj49+yHUubfPGCx7OTlq4i8S669t7E0d0Od1gAMt1kXd0OiHExtEv9APG8o1RHHzdSDwEb3TgCbF//edC1dx0EmJVetbHToLknOzkIGW0zA/yfSYGdhOQ8FF6Vay3IK2GmXENtc6xYZdDUUXxetEXlEkE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75595f48-97d5-4e59-8b9f-08ddfecb8f92
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2025 20:14:01.6910
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: glcpbv2W6JXgEn/Ua2d+ZagrHu5WqgMr8BX3rZmEVSc8ZRh/m0oElK6zjLx9LBzbwWFpuiBlLm8Y9CnHV1olDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5973
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-28_08,2025-09-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0
 malwarescore=0 mlxscore=0 spamscore=0 adultscore=0 phishscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2509150000 definitions=main-2509280198
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI4MDE5MSBTYWx0ZWRfX40wWQBp5/06M
 nskNSRgGWHrmEnqBEkjEcaBPS+0qAVpHXEilVx9kUjT2kQIUFLFvupBEfctoDoCcz/ABYZx5y0T
 hpK6/vJz7OQuUDvnSO4GOj1jNlz43LzcnY+xyrAWCH+U3Qic/Ypbt56nu03ad77SMxPb4Ej5NX0
 g99sr+qPeojig245V0bjO9ef3VM9VMAfNsey+n7N2saXFa1hv//2PqvcX0fF2MVwBMbS6AYuvRo
 l31bKFhU4tlha2TcgqQQI13EuJgK0OCOlDfhFV0ljwT1u1VAHYADrSknx3WR7VlUlpKfqhcd2wy
 y4E2yXVQkzKbnBljQ2hgJlGRJTEeDrjo9lAULkwQbsmC/Y96/IedIdnkyrf9U7LbTyo00lYLxBK
 RKhzqvIULpbBZawes3BPwz/xZ5qtTdtYAydhJtfbIEyhRHYRFlU=
X-Proofpoint-GUID: 3z3MKpBcurVBqVnxMuFOqSXa2k4I0JVU
X-Authority-Analysis: v=2.4 cv=B8O0EetM c=1 sm=1 tr=0 ts=68d9970d b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=bC-a23v3AAAA:8 a=VwQbUJbxAAAA:8
 a=yPCof4ZbAAAA:8 a=vvBIxY26ws3Y3L3KfksA:9 a=QEXdDO2ut3YA:10
 a=FO4_E8m0qiDe52t0p3_H:22 cc=ntf awl=host:13622
X-Proofpoint-ORIG-GUID: 3z3MKpBcurVBqVnxMuFOqSXa2k4I0JVU

On 9/28/25 12:14 PM, Nathan Chancellor wrote:
> There is an error building nfs4xdr.c with CONFIG_SUNRPC_DEBUG_TRACE=y
> and CONFIG_FORTIFY_SOURCE=n due to the local variable strlen conflicting
> with the function strlen():
> 
>   In file included from include/linux/cpumask.h:11,
>                    from arch/x86/include/asm/paravirt.h:21,
>                    from arch/x86/include/asm/irqflags.h:102,
>                    from include/linux/irqflags.h:18,
>                    from include/linux/spinlock.h:59,
>                    from include/linux/mmzone.h:8,
>                    from include/linux/gfp.h:7,
>                    from include/linux/slab.h:16,
>                    from fs/nfsd/nfs4xdr.c:37:
>   fs/nfsd/nfs4xdr.c: In function 'nfsd4_encode_components_esc':
>   include/linux/kernel.h:321:46: error: called object 'strlen' is not a function or function pointer
>     321 |                 __trace_puts(_THIS_IP_, str, strlen(str));              \
>         |                                              ^~~~~~
>   include/linux/kernel.h:265:17: note: in expansion of macro 'trace_puts'
>     265 |                 trace_puts(fmt);                        \
>         |                 ^~~~~~~~~~
>   include/linux/sunrpc/debug.h:34:41: note: in expansion of macro 'trace_printk'
>      34 | #  define __sunrpc_printk(fmt, ...)     trace_printk(fmt, ##__VA_ARGS__)
>         |                                         ^~~~~~~~~~~~
>   include/linux/sunrpc/debug.h:42:17: note: in expansion of macro '__sunrpc_printk'
>      42 |                 __sunrpc_printk(fmt, ##__VA_ARGS__);                    \
>         |                 ^~~~~~~~~~~~~~~
>   include/linux/sunrpc/debug.h:25:9: note: in expansion of macro 'dfprintk'
>      25 |         dfprintk(FACILITY, fmt, ##__VA_ARGS__)
>         |         ^~~~~~~~
>   fs/nfsd/nfs4xdr.c:2646:9: note: in expansion of macro 'dprintk'
>    2646 |         dprintk("nfsd4_encode_components(%s)\n", components);
>         |         ^~~~~~~
>   fs/nfsd/nfs4xdr.c:2643:13: note: declared here
>    2643 |         int strlen, count=0;
>         |             ^~~~~~
> 
> This dprintk() instance is not particularly useful, so just remove it
> altogether.
> 
> At the same time, rename the strlen local variable to avoid any
> potential conflicts with strlen().
> 
> Fixes: ec7d8e68ef0e ("sunrpc: add a Kconfig option to redirect dfprintk() output to trace buffer")
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> ---
> Changes in v2:
> - Remove dprintk() to remove usage of strlen()
> - Rename local strlen variable to avoid potential conflict in the future
> - Link to v1: https://patch.msgid.link/20250925-nfsd-fix-trace-printk-strlen-error-v1-1-1360530e4c6b@kernel.org
> ---
>  fs/nfsd/nfs4xdr.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
> index ea91bad4eee2..9fe8a413f688 100644
> --- a/fs/nfsd/nfs4xdr.c
> +++ b/fs/nfsd/nfs4xdr.c
> @@ -2640,11 +2640,9 @@ static __be32 nfsd4_encode_components_esc(struct xdr_stream *xdr, char sep,
>  	__be32 *p;
>  	__be32 pathlen;
>  	int pathlen_offset;
> -	int strlen, count=0;
> +	int str_len, count=0;
>  	char *str, *end, *next;
>  
> -	dprintk("nfsd4_encode_components(%s)\n", components);
> -
>  	pathlen_offset = xdr->buf->len;
>  	p = xdr_reserve_space(xdr, 4);
>  	if (!p)
> @@ -2670,9 +2668,9 @@ static __be32 nfsd4_encode_components_esc(struct xdr_stream *xdr, char sep,
>  			for (; *end && (*end != sep); end++)
>  				/* find sep or end of string */;
>  
> -		strlen = end - str;
> -		if (strlen) {
> -			if (xdr_stream_encode_opaque(xdr, str, strlen) < 0)
> +		str_len = end - str;
> +		if (str_len) {
> +			if (xdr_stream_encode_opaque(xdr, str, str_len) < 0)
>  				return nfserr_resource;
>  			count++;
>  		} else
> 
> ---
> base-commit: 3fadfaec904dffab02ebf63dd9c2ae8fa15c6d32
> change-id: 20250925-nfsd-fix-trace-printk-strlen-error-2a24413eb186
> 
> Best regards,
> --  
> Nathan Chancellor <nathan@kernel.org>
> 

Since "sunrpc: add a Kconfig option to redirect dfprintk() output to
trace buffer" is going through the NFS client tree, Anna will have to
take this one.

Reviewed-by: Chuck Lever <chuck.lever@oracle.com>


-- 
Chuck Lever

