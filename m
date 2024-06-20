Return-Path: <linux-nfs+bounces-4194-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 02550911517
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Jun 2024 23:47:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B3711C22931
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Jun 2024 21:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F01B97B3FE;
	Thu, 20 Jun 2024 21:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cHsXsGVU";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="qQ8hvryB"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C33380605
	for <linux-nfs@vger.kernel.org>; Thu, 20 Jun 2024 21:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718919888; cv=fail; b=LPfvEIMbtqAuxrj8eVJZQHUxpfAa4+HNRxvmakmjL2JmE8NLgMRfm6BwkiSzqmtRn/YNZrx2YOvzSqUi4idlV5/eXr3zfAMxryQgjuK9VO4ozsSCt/RcAEvfxZwNIaZM+fU9S7baDT4hdq/CRox6XMEBwgHIUA/p19KfGm6I3MU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718919888; c=relaxed/simple;
	bh=NcQYxoGVldsFa+6EZhJBc75yl9tCV4pfxFZoXjOsQOQ=;
	h=Message-ID:Date:To:Cc:From:Subject:Content-Type:MIME-Version; b=PdYt/ZY47Cv/HMGA+roTngwTFUHuwWuc9qYrLd8tDfqTbW67T39HpPJPAU/oOqeB/plU38zr+nz5XvaL1q1XzKQGDVoZBqOE3gvbFOP75CTALgxw5i1Q4+XBpgaE2JZa5s0V5pHp/faOyBjjpo/PgHt2xjrPX8I67SYNZDltHhs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=cHsXsGVU; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=qQ8hvryB; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45KKtQNM025089;
	Thu, 20 Jun 2024 21:44:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:to:cc:from:subject:content-type
	:content-transfer-encoding:mime-version; s=corp-2023-11-20; bh=t
	pC+92jPfG8t/SBsDVKoS3Svztq48aBL3E5kcnJUwWo=; b=cHsXsGVUcTOgMvZaL
	jFaSUmgHu7psFmB425CsYx0m5zhWdtGceDX2SmaUWvv1BiduUNEtGwpRLsYKD7je
	hjFxi3+I3mLbuMtoxQjJufDDEj/tBhOKx2RCMJuSLnA4cR0AMSuSLGgA+VCp7rfB
	0PmlUMSnTXfde6C3HpYoBo6qXDjxmxd5AHUQoMZh2S8DMKy+Q2U9c3A80exnRygZ
	+0tn8LTCpZi1RTrynG0MOuOittLx8/2ITd7e4EMqbR2demV1XR04FeibrUzNOSah
	ilSDldeRm/qs8CW4F/vXjBOu2VXLtVLq5X8qeTAIy1YkF5HTUYVRWmg+F1sM1IjA
	3mgpQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yvrktrhwh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Jun 2024 21:44:41 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45KKix7o025125;
	Thu, 20 Jun 2024 21:44:40 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3yvrn5aq7y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Jun 2024 21:44:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mmD6bMYVPFWTjhXoJE1SjGPIgtPuFVi5DIb0KP8Qqxghz9X0oOKatR3BXRJgUfFc4xG9kbc2M5dMgvUi14OCIuK2J4eVLmJZQ4aY8a9mAKxWH7DCNQcogpt1YSowxldJ2KmEKP0C61EFC43wE52Oj0hiKJQYuoQ1GFfJAsk0A4IUFCHRaPgMhwFmkLw9DGyaB/3wI78rlFc3Lp9+OfW6crje7Vi38svzYioi867lY8kEqhyGkHVxJt/Hs8S4B4ljWVMxHR0zjvzgH/YKad2RtsbYjhx/CcxVgvk1N2XliAviPZgYbcHeamQqHi6igUyXWn5I3NxNy92Swof7pXvdpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tpC+92jPfG8t/SBsDVKoS3Svztq48aBL3E5kcnJUwWo=;
 b=c58AavlVtaEFHjiecKdTDAhJcHu4zxH7FQmMCEmzaZVlXjojNZ19e6Bg81xWwV3Ftf2UW76LDzfghe8l6yuKsTrT61YyhufMmNsTb06EF2d5vWIsI5BqgGqc1DKELE6IG5zNlZH2aqiLqn2YXYCeqUlM0lk1mB6KrlCyOk8XvMJcT2YJmekgDH0wD+qbylBcfcU9W3gdbYAg+BsNVVQX/bu5bi9+Hg/QriGeyDrXDLZyhg1ibUtGKwqE2ragiP9dwe+AduVggQTqIoc6+Qkbs7JvMQHOuOAO4yC+vpnb5W8lzwd2g8rBr6ECbzGZQ7ODmQpaRY6jZGuPA5iA+2LF4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tpC+92jPfG8t/SBsDVKoS3Svztq48aBL3E5kcnJUwWo=;
 b=qQ8hvryBzdqq9sXEU4ELd0zGi5bwg64TTSJsMQp18AyBgoFfcx83DfrbfDGZyNH9sO4VOof8BGIPDScY3KNDR9HL1EqEPyiJ6bjrAOr78vPMuzBW416RvJ5sVwA+1JXa2Qz6sAxL/3/t/bBSuy+Pz+FEg3lFKDIBgnk++Q1xA9A=
Received: from BN0PR10MB5143.namprd10.prod.outlook.com (2603:10b6:408:12c::7)
 by MN2PR10MB4159.namprd10.prod.outlook.com (2603:10b6:208:1d7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.21; Thu, 20 Jun
 2024 21:44:38 +0000
Received: from BN0PR10MB5143.namprd10.prod.outlook.com
 ([fe80::783:503f:ea07:74c7]) by BN0PR10MB5143.namprd10.prod.outlook.com
 ([fe80::783:503f:ea07:74c7%4]) with mapi id 15.20.7698.020; Thu, 20 Jun 2024
 21:44:36 +0000
Message-ID: <d489e2d7-d4ed-424b-8994-6abf36a01e06@oracle.com>
Date: Thu, 20 Jun 2024 22:44:32 +0100
User-Agent: Thunderbird Daily
To: Olga Kornievskaia <aglo@umich.edu>
Cc: Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>
Content-Language: en-GB
From: Calum Mackay <calum.mackay@oracle.com>
Subject: ktls-utils: question about certificate verification
Autocrypt: addr=calum.mackay@oracle.com; keydata=
 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
 smRifw1wGg==
Organization: Oracle
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0401.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:f::29) To BN0PR10MB5143.namprd10.prod.outlook.com
 (2603:10b6:408:12c::7)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5143:EE_|MN2PR10MB4159:EE_
X-MS-Office365-Filtering-Correlation-Id: cbebd70d-379e-4653-487a-08dc91722df3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|1800799021|376011|366013;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?R2ZVbUQwMDNzc29YZ2xBdlhyNlZSQWlUdGJGY3dNbmdyTkloQ1RaTDNkK1A2?=
 =?utf-8?B?SlJkT3pOWWlPMGVQczlNYkY2V2hhbWJTQWFTdkR5ZEk1YWRHeVZWL3lBTWJv?=
 =?utf-8?B?TTZKbGxFWnRBWXhISTh5K09QV3NBSHVsRUxXS2NPTHR1M3greEZWUlplc2hn?=
 =?utf-8?B?enl1ZVprRVhNb3Z1NlFpQWdjb0kvV1RFVnB4SlBnSG9oa0NBamxXZ2JJNDlP?=
 =?utf-8?B?akpVa1h4ZDg1K0FoOGZMejFPQWd1UFdSY00rdy80TlZ5cFFBRVh3VmU3bE5L?=
 =?utf-8?B?RGxEOW1EU2d1ZVR3cE5JMW00WjFIUndGaUd2ZGNUekJZWkIzNGs4NERzSkhF?=
 =?utf-8?B?UmlWN3Mzb0V4Rk5Gdzl4WjVNMUtNMUJSZmlyb012bEcvUmFBeVZiRmpucjJv?=
 =?utf-8?B?ZmZjbXVzR1hib1VZOVdKazJBOHVNaW92WTJzMHU5dmFOQlhyWHU0M1JhNW1G?=
 =?utf-8?B?WWZFM2RoT0xlZ3ZZQmIvb09LWG44RFZ4M1c1MDFaMlVGaGJDYU53cXNacFM5?=
 =?utf-8?B?SEZ6dU03RnB2NlNLVGwwMzFGdzZPYm1uK3RKTTdkUCtsdWpZVW1qa0ZaR3JJ?=
 =?utf-8?B?b1JmM0pCVnUyMXZkOC94eTNtVTFoVTFrZmtiWEVzWVZYbVYvaHN3UjZyby9l?=
 =?utf-8?B?R1hGb1VrOCtwZGg5S1g1bGZ4bzZLWmJhcHZXdGhicFExelNRK0tqNjd2cTBi?=
 =?utf-8?B?eFF4eUxQb05qOVlMOGdCWkQ3VFdMblB2Zmt2ZHJ5WkQ1c2pFUG0rTmoxVFJz?=
 =?utf-8?B?RW9PWWlMWmh2cHlOK3ZwM1dXLzc2K1FFeW9KdWhBL1BpNWhYb0syc2dCTnpZ?=
 =?utf-8?B?UWtYeWpDODJleThYZnczWFhnNWs5TGRjY2lSYjNoZmdmdTZvMjFmY1dzSDQx?=
 =?utf-8?B?QlNyRVAyc1ZTdkZKVWg5K1E2ekc0c3UwaVNyMzN3RzNqY0F5N1VHV0NGOWZD?=
 =?utf-8?B?R1NaVHBNc1JmeE5IMjU3cXB1bUpKMHhvdmF5TjhKWm8yemtkZGZObkw2SmI2?=
 =?utf-8?B?TFNxZjZ3c08yV2VKRWRYbWRwVklFcFEwU2RncW94aXVmeCszeWliMDNFbVNl?=
 =?utf-8?B?U0kxTDkrWGJxc1FZRzRqeE9BTU1xL1VnRTBXQnROUVRoU011Q3JWQVRvR2ZP?=
 =?utf-8?B?UVhYeElub0E0L3FPczRoYzlKNXFHbkt1VUNwL0ZWZytLWGFpcUxoSEtEdVZk?=
 =?utf-8?B?Y3pES2FnOTUzWDNGekZ0VjNtcFVaK21kaDZLcFpyaGMzaW1ZZ1BSWHNYaGlJ?=
 =?utf-8?B?ZEx1NGNRNVkrb1JWRy9kaWJ4bXEyaHpHVFRXZEkxQmVuUU9hdGVlY292c0xh?=
 =?utf-8?B?SmJCd3JGbkRxdG9RRG50RzhLU252dHM3RE9XQS9EUjJJS0d6R3FDeW1DeHN3?=
 =?utf-8?B?TC9raUpEMmF0dFZlNGhyang4bi81MWFSNDhJSEZ5MFVaQkpFVjZVQ1dUNGor?=
 =?utf-8?B?bWFvTjNGWVY1UzY5aCt0cHZYbHMyUGxocUVsS1E1NTVNdWZXNEpyTG5mRG5L?=
 =?utf-8?B?MVRqck1MSEVSWlg0MW9TRFF3Q0ZvWWpYOVJySzE3aDRUTkNJWGVrY1cxSjla?=
 =?utf-8?B?M3U1dzZBU0VFZHgrc0I0cFdkcGYrdkJuMUsvQWdzbVRjckdkaWR5OElBTUdF?=
 =?utf-8?B?WVVGaVFBdklVT29VVFBhVmVFMStIekdaZXFmcmc3cmtqVmxqNkxKZ0x2QlVo?=
 =?utf-8?Q?2uqg89E4e5MpDptDYPhe?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5143.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(376011)(366013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?MUNLeEZaa3cxcVBJL29JMyt0YWNZbS9GWnR2T2ZObVRmMnJaZW9ZMUQ3MDhj?=
 =?utf-8?B?VzJYbml1TE9xTDJoemY1TVQzM1Bjc3FLRGdoSHB5OWxwK3JNYnBFL0ZOcWZ2?=
 =?utf-8?B?NEFPVm5zM2dQaXpKcW5qK1BKQ3JDUUFUOXNCVHdDc3B5UmQ0K3NkbDhXQ3ZZ?=
 =?utf-8?B?TWFBSm5uRGEyUTByck1Vai9SL01hSWZZVmhaZ1dEdU1sN0VZZGJLbmtDZkYv?=
 =?utf-8?B?M3RmS2pqOENSZk9iaW9ZZW94cld6b1dLSEZ3OTJ2dVdWempRa1JoNHFSbWFi?=
 =?utf-8?B?S2ZON00rZldISUJIcTY4TGx4NWc5a3FmdDFxVlMzSlhYUlY3RnVkYmtEODFq?=
 =?utf-8?B?Z3UrSkVQVytyNWo2dk53U01kYlVkd012Y2c5dXh6K0pRRVNHSHJRckpDb1dh?=
 =?utf-8?B?M2FVL2FOV0grdmlBWVBtWTYvWUE5cmJoaDZVSG90QXVtZ0dPQm5VSTZ2V2Rn?=
 =?utf-8?B?UWV2YjQ2L2xFcWxTQWxTaFNUWTVPMEFGNmhuWmY2dmpuQ1ZlRzRHdGJxbHNV?=
 =?utf-8?B?VE9vYnlJWnZQdU9scGhQZFB2ckhtV3hGYW1IL2Q5ZldSL3d0Ujh3QjBQWkJS?=
 =?utf-8?B?ZGc3dFRnV3EzMnlsV3B4Y2hid1JlUWVLOGFLSTlFZGhibWlqbndGWktlOWVp?=
 =?utf-8?B?L3BiUmZEM0J0SmM2T2ZqdHd5YUx6L2R1YmFDcDlrcmsrbjJMMjhRaFNWVmIz?=
 =?utf-8?B?WFhFM0NSQ1Rtd1ozQThySzBHajBRZXNXc3ZCdFEwWk1YWHlneE5xaTc0cklv?=
 =?utf-8?B?a3VqdVA1RTlQUno2U0FpUlZmbFcvcmEvYzRMTmZUWjIyOXkwaS9ibmhiTEFM?=
 =?utf-8?B?b3d2V0x6Zm9YSlJTRmNRSzZMQ3hTR2Q4ekdhb1JNVVREQ2tEVGxXRk9YY2hh?=
 =?utf-8?B?VWs0Mk1veW1BZWJrS205Z2dsS1dyemZ4Y2k0RHJLMzNGSWtkWHZWVUlFbWRa?=
 =?utf-8?B?dWpoSEVzcS94c2hac1lNWXE0LzZKblJCNGV3UTdhaGRPa0xPV3NFVWRBcFlJ?=
 =?utf-8?B?NlhmT3ZHQU0vekJRa2tPMWZSRWdKSmJqL3RoTlVraCtCcmE2Z0ZweWpjc3l5?=
 =?utf-8?B?MENIdHlidlFzWmFXK2JielRlejJGa0I3MW5ZSVNCKzF2QWJlaHFpRGhYS1lj?=
 =?utf-8?B?ckRDZ3FheWc4dW93dkFBWlk0NmdUV25TMFl0WUNkbEpkRzdLQTlkdWQvTGJu?=
 =?utf-8?B?NUhDaWVXVUlVcVF3b2ErV0xwdVVDdVlTblN2VTRJanFPUThRMkUzYUNkNGhu?=
 =?utf-8?B?bWgxVG5OWUVJTkRoYnJ5cUM4UlFUSzNZTWFreGRJbVNUbS9QQ3RpTHdXbzZO?=
 =?utf-8?B?K0hkakZGbE5DS2VsKzR1WncvejcxUjQzc2NVTmdLQkVTclRBemJsNXUzSkFu?=
 =?utf-8?B?TGNPOE9iZy9vRGR1dGZoazQ2MVJ4RE81TVpUazlFSFlyeVBGK2txUWdHdVpp?=
 =?utf-8?B?QlNvMlJINVNvUy9ORXI0V3hlY3hVU0RENjRKSE9XeGc3T25WYWtzT1pkZnBP?=
 =?utf-8?B?aGc5MGxWcnZsZk5ucFNRUFc3TVFSMzVQelhnUTBUd1R2U09sM1lPQ0JuckxL?=
 =?utf-8?B?TmRWQnRUQVd5eWFmOVFRS3h3aGZmNTVUL3VoejNabWpCdE1QaXFqQVdnQk14?=
 =?utf-8?B?NE8zMUJ2aDRYNXN4aXNaUjZPOHptcXU3Ujk2ekFEZURTbkdOcnhJM1h3S3dU?=
 =?utf-8?B?RDRaZGJjak13WEplakFOUTI2c0RFMWJPNGxETkp4UVl5bFFXOFRjNVp6QTd1?=
 =?utf-8?B?dEtUOGQzbjdkNWNkREg4YmR1QVovaEF2aEQwbkR3anoxSG9YYVUranFUdVpG?=
 =?utf-8?B?Mit6Y3haSnJlVGpqNHJhbmxSL2pwMW1jcWlmSkluUjlxcnp5aFZEdHdLajM1?=
 =?utf-8?B?SzJpYWJjRlBFenlhTzdxTDNXTlZPVkdrZnNJYndIbmJ6dDJKTEVjY2JvK3pu?=
 =?utf-8?B?OUd4L01KYlBPcENjejROUmtjbFprUTd4N1NwS0xMem9IakZoTEhseE1jTkVm?=
 =?utf-8?B?R0ZLQ3JlWHFrZzloVVZYNnBRWGt1NzBZMXB1eEhzYjJWZ1kyY2doa0VNbGR2?=
 =?utf-8?B?Qk1iaEszMmdmbGw0VlJmT3RuV2hNMllpbUh2N1Z3dzRKeWVvSmgxZmhrMzd1?=
 =?utf-8?B?d1JMbWo5TUtrd1B0Mk4wanZONngwYkNpdytJaHd0ZUhnbTRxSDZzUFFpUVdV?=
 =?utf-8?B?Wnc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	cLhH1FLww5r2ahAiF00Q6JR6xprHczDovF79YcJOCtkmrI3W91wKjuytTFUiNAptvH+b4gvEnQULnl7PCsZfTvQ/IntAN/mq53aw3WQVRXQhOo+TMiLv4iH49ZuVv71useukolp19/rcYrMHhPYTRmCfMcG95aMRw4lH47+sYGbkKg91tIzbflgynKFyJrpEjQNiOVkpfv6wRPMpe0+TjGZng21PVn8wpZEjzGHPfvz8fKsnck+dsviMNg4USRytd42l1xvTn8YhR8rDz99TAPxeYiNipT8GtVo/PAna6lRnoBglD4gUsdPVIAFhvIhCQO/rHffjp/s2mSBmomN73SPE4pwiE10IueMsxXLHDe9n2MexWlXw0MxRZt0Osu1dLKHNXYOJeJw38fIV2Hui5pveU4jGn4pF/UcN2VHXveW19FOjRrpAXcINg6Ubkpxn2AhUH4dXliK34Gy0hRClhU2szrLreSujrv67NuyoGT5N/l6dCYkcgGqf9zgGRPZagsshyEk0w5uQV9GfMdleX/3ukpDR8WS6hUoQChGllNzLpZFbah/lyaiBqWP+J/NGNyIWGwXwFJB2Te7EMYZaqH/rNgE7XpDAckMlEkWjQkE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbebd70d-379e-4653-487a-08dc91722df3
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5143.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2024 21:44:36.5023
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bhEjWRMwyKzWW/WvdFEyjyLSgBwl/gL0zuFgdkdq6Tt8YkXx1EabEFR5nXGj23efjKt74LaoQoQtNNu0NB5gyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4159
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-20_10,2024-06-20_04,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 mlxlogscore=686 phishscore=0 adultscore=0 malwarescore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2406200160
X-Proofpoint-GUID: OhFXIvZ6NhFpmw1J1h7Z6KiRPh0Wm8Ta
X-Proofpoint-ORIG-GUID: OhFXIvZ6NhFpmw1J1h7Z6KiRPh0Wm8Ta

hi Olga,

A few weeks ago you and Chuck were discussing duplication requirements 
of the hostname in the CN field versus SAN extension in the certificate:

	https://lore.kernel.org/linux-nfs/CAN-5tyENK71L1C=6NwdB4mkxxf1qYZ2-4e-p8FQM=SmA3tMT_g@mail.gmail.com/


For what it's worth, my own testing showed that the SAN DNS: element 
doesn't need to duplicate the CN.

This is especially relevant in the case where the full DNS name is > 64 
chars, which is not strictly allowed as a CN (and openssl for example 
enforces that limit).

In that case, it works to put the short hostname in the CN, and the full 
DNS name in a SAN DNS: extension. There is no need to duplicate the CN 
entry in the SAN extension.

I also noted that using a wildcard CN (e.g. "*.acme.com") does not work.


I've yet to test mounting by IP, but will do so soon.


best wishes,
calum.


