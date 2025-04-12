Return-Path: <linux-nfs+bounces-11122-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 991C0A86F3D
	for <lists+linux-nfs@lfdr.de>; Sat, 12 Apr 2025 22:05:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6A9919E289B
	for <lists+linux-nfs@lfdr.de>; Sat, 12 Apr 2025 20:05:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAB6F2080F4;
	Sat, 12 Apr 2025 20:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="l7yyQnrx";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="UmSrJZ+O"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 753BC1F0E27
	for <linux-nfs@vger.kernel.org>; Sat, 12 Apr 2025 20:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744488310; cv=fail; b=ec/blG/Uv1V91gbjDSdzMwF3nqv2wvShRknexY4wyOMGCsJY+4HBfpNHVDuXkhEG7N9Gz2+VCPkMgd8XKwt57QyMnYnsibFluX7gFp12JdAFMOIsS2nc+evtlpIhXpezo+UAaEPEn85ZVnDPGJf1ZjpEl+yawmvHeQBvnO/xyMI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744488310; c=relaxed/simple;
	bh=clWBvCHodqvIPeUgy6BHQpMP22FP33OtWy0p5vGiLeY=;
	h=Message-ID:Date:To:Cc:From:Subject:Content-Type:MIME-Version; b=eKr8XzMSUcX+5EJ+QQNGOXMJXW98KpA8XskeHaSWgcFdttRmrFEkvCfgSxptPr1S/HDgHxHYf3KAElGrYkT17DlxahtNoMX7kZJqOMZFMNQud5iJisJRVd/0S8oy5uOBJHNjfP8bM0lcLlPSuJWrgA9H5hREMje5ZouREXnQUrc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=l7yyQnrx; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=UmSrJZ+O; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53CJjYLO007365;
	Sat, 12 Apr 2025 20:05:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2023-11-20; bh=Cqs6/GgDmM957Prd
	KMtKQCImROiEyWcoR2c8Vg+x93o=; b=l7yyQnrxropHgvY8pzjrfcrzJ20YepoG
	7odrUdjzX9oBxLZ7+JC0S7aJS1NU9e3++Z122SrRGbJrQVO+ww/6SETlSe2TkJeh
	uBVl8gt0sx+gdx1Mfse/+dtUbBQBA7VleM2v5cj/WN9du1xViii/uTwU+lvXPvdg
	GhpkCHhNpc6N+KOXSXHkTCjhQUI9sA9aTC5RbUD2tudGDgmH3IXsCBv1kcpOmeto
	XrMpfStSYJWRJpWS4abS4cHQqhCHKImeISdhp+aepSDcmzkkLcFV7O/bIv4N/W6t
	q+To5y/sC5SZWm9jMi66yrqrL0gy3vZMnDmsD3XJ+hVAtP2y9W2Cyg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45ywu0r12w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 12 Apr 2025 20:05:05 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53CHMDUQ004943;
	Sat, 12 Apr 2025 20:05:03 GMT
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azlp17010005.outbound.protection.outlook.com [40.93.10.5])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 45yem6a4ag-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 12 Apr 2025 20:05:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J37aeEYxeoSraL+tr1o3NlrTnBLTRjC5G/9EgpXDlGxvZaKWRtrwezStRdRWN3v+f5CJPX5y6KVQKBi+x7+FWGWVC4p1YcDrDRrZsxyUtGsc3e6abkh8pIhMu3f3ZsSuvJZbnWipktO5iBgsdIH9OBHAS0kfsEgl7/f23aX408uFvqzCy4y8cJGFTn7lGgKCaU5quRbxN0qXaf5zjNrZpMiYWFTLzrjcXOluLxov7iSZmeqPRN1zKNdUAoLfGoHuSp15DNDK73NBo7t5dqYL1FZA/fE8QcUIEriR8zgGibIajPR4JKsId8LmVKGfKons0JdsBmPkDTUW+3N7WD73Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cqs6/GgDmM957PrdKMtKQCImROiEyWcoR2c8Vg+x93o=;
 b=sMs3PeKMaFzK0nVmKmiUfGyp9cd3igKw5vO6Q9eA3/H45tm3dOKPvB9WCe5yNrJLcu1zkfvwGwVIVTXTGWM7E5LOb3YP6XoCa6FsnAO0CPtUtwT/1sUgsHs91dwNw/hfamoXM17opnOl29vU5W+SzgIx4iEZGPipj0F58fnJ+ug6aa0m9oJFm8lIurIA4ydYK2+j//mXL3c4ddX0r6VZb8vtsbwknf+ONavGfmvQDRStsF+r58boxJPS1VX8BYGQI0ADZq1yqFqqFCP4MstugWFyRleBFUhXSDT5lrmW9IrhMOabuQtFLLzO35FHnR9NCJwNegdeK4Tp1PwRt+aPqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cqs6/GgDmM957PrdKMtKQCImROiEyWcoR2c8Vg+x93o=;
 b=UmSrJZ+Ohv5vUemNufhETQxl60NcHZ4gIOlxtF1Hoe0+w95s9Vr+fdnSDsaIwTps+r8jo85FQAWWvSMwscCDjPUC1P8eQ58dZsrZSr+Uj41Wt9NXTz4/rW03LRClHfeEckc9b2nM4s+iAxFH0X+6dIQ7105KQetZWTxovDF/JhE=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SA1PR10MB7700.namprd10.prod.outlook.com (2603:10b6:806:38f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.27; Sat, 12 Apr
 2025 20:05:01 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%7]) with mapi id 15.20.8632.025; Sat, 12 Apr 2025
 20:05:00 +0000
Message-ID: <b814b31a-fbe2-4129-8fd5-6a2981ca9629@oracle.com>
Date: Sat, 12 Apr 2025 16:04:54 -0400
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
From: Chuck Lever <chuck.lever@oracle.com>
Subject: [Reminder] Spring 2025 NFS Bake-a-thon
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR18CA0057.namprd18.prod.outlook.com
 (2603:10b6:610:55::37) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SA1PR10MB7700:EE_
X-MS-Office365-Filtering-Correlation-Id: 23fbb1d6-7783-4d97-c798-08dd79fd4e59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NHVtREVBWUxrLzc3amp5N3BQNlU3QnBGVm9YenprY2lSVzd0ZU13WmRYaEQx?=
 =?utf-8?B?RHlpRHJpTXFJU2Q1Q0tkUEkwMGh4K0NFSGwxNlM1d3pqdlV0T294cGl5Vzgr?=
 =?utf-8?B?TFRkSGR3L2VEMVZOWXZ0MktXWkJ1ZnpYNmd1VjhvRFVaZkNsZ1ZvY1MxejI1?=
 =?utf-8?B?bUliemtlUjd6czNzZGN3MStiK1RINjQwS0V0RUYvSCsxMW9PRUJ1dFRVL3I1?=
 =?utf-8?B?S0I4eEUxQnNJbkRxWUFIWXhHcVMvaHg1M2NZZ3BjdHhXSkUxVjlCNFhreFA2?=
 =?utf-8?B?Nk44L2h5Q1pKMThxcC9Ld0JlWkdoK2lzZ0ZocndiUmgyRmVzUjlLaFZqQm5J?=
 =?utf-8?B?bnQrQTd4Qmc3dEREdkNNZzRpcFp0L0pPRHVWRjQyU2tmcGVhVEZZVDBNVTVW?=
 =?utf-8?B?WWhiT3ppbzh3TVlLa1JyWUl1Y1Z2aXZqVmd3WUY1REVVK0xmOGVYZ2FDTE10?=
 =?utf-8?B?UmpkMTQ5a0RUTEI5UlJqbUV6UlRyc3B6MDVYbVNPQTlvaDQ4OGFkMStWNTZm?=
 =?utf-8?B?NWU3WFhSbzRkOUh5UXV6L2twSEQxQmo3MlBTem9KU2MzSzUyNnJkc3NnSW0w?=
 =?utf-8?B?NGhVQS95K3oycGhBc0NXeEkrN3NPNWgzU0lNNHJ6Rk1lR083dU1GKzlmTmFw?=
 =?utf-8?B?V3NPTEM0VjdQaUlXUW5yYWs4SzFBZGttcEFVSUVpM29GeWVxY1YwWktnM1JW?=
 =?utf-8?B?anJuMUZ1OEZ6akdtR1phQmE4ZEFPZENuRy92Y09GM2JuYStNa2JESjU1aHV6?=
 =?utf-8?B?NmNBMVNQb3hqeEEvY2M4QU1EWjMzUk5kbHRCY1RFWEt5WS9KMzV4K0dHWFRt?=
 =?utf-8?B?dzl4Q1A0dVZQQVNoWFMrYVNWZFNocktqdmpSNHJZck8zMTFIWTNtM2VCMlQy?=
 =?utf-8?B?VFV5eUEyUU5LdU1SNHcrRnFXN2lTOC9kK2UwMEZXZ1IrMHloMVoyQlhmazRp?=
 =?utf-8?B?b1gzU1cvMHlSbkliTUpmRzhTSGNkN0J0eFFsWEtSbHhiNVdrc0o5OU5WSHhL?=
 =?utf-8?B?QmwrcElDbk96RUl1aHAwVyt5QllEOU92d1FseVo0Tk01QnVaTVJ6N2ZlR0hK?=
 =?utf-8?B?UWlUKytvUFBrQWJyUldQWmtGeDRnZy9OUzlZQWpwaVBhaHRqZ1ZSejQvVHV5?=
 =?utf-8?B?Nmp4cHhLK25adjM4V2NsSTdkMzcrNVlFd1NQbWs2ZVFGamxFRzdBOFZzaGRW?=
 =?utf-8?B?Y0hqeHBBK29CQkdpb2xUWStYL0pwUnEvbHJMRHdKOUtLZDlSS013dlFnU2ND?=
 =?utf-8?B?MkF1c1ZVY1BoTCtWNHBMbnIrUEFSeEkxQWZLWXhxdmhVK2JjOXZzeG93SUlK?=
 =?utf-8?B?NGl0dm8wejFvQTZtZFRGN2oyempzaUFLUWIzN24xZ0hIc0E4OVhESmswczQy?=
 =?utf-8?B?ZE80Nk5ZbEFpZGx5bEE5azhra3VjOEluL3FoMk9YVktsTC9sQ1N0aTJKT2Fq?=
 =?utf-8?B?VmVJWUxFNVl1TEJKTE9zdHBheWlGb2c3eEl5RnNJM3dJdnY2cDlZQ3VPTUdh?=
 =?utf-8?B?VEFjV0lWYlY4MURJVUpPS04xZzQ5MGFRQUVtUHFVczFkdWpTeEJFYTI4WEUy?=
 =?utf-8?B?MDMvclpBZzlkZEFCSHlRNGpDc3dRejhBcmRZUmh3TUZpNE41ejFaZzBaUHgz?=
 =?utf-8?B?cXF2cHBFd2xXM0t6QmEvU3hHdm04bkYxTDB2M3BQTnNBOFFvbW0rMEVGTzJk?=
 =?utf-8?B?cnV5Rnk4V052MVlicmR0Y3lpS3cwSWVaYTRLRTduK2NPckRUMHZhaERVZ2tS?=
 =?utf-8?B?UC80YWFzSEVqdmw0Uk5rdm10a0hYL1hwS0tjMzNCd0cwY0pXUVZZTGc2Nm5p?=
 =?utf-8?Q?YFJoSHfIwEV1bqtMDWdAcOjZmxz37LL9hWtT4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bzFJWGtUWmVQcHBLRmR4bkdQa01oYkhOMTFua3hVVWFzNW9JNjM3c2tLZ2p4?=
 =?utf-8?B?MWxuLzdnVkpBN0lUczNSbmQzSVVPUFNtZXdIeE9JUldRelllV1p4dWI2bHdC?=
 =?utf-8?B?N1dHMmF1REp3VGZVQ3c1dzJJVXNmNGlmcDZxRTVJcjZGSG9ZZG1Rb2U3b2Vj?=
 =?utf-8?B?OWQ1cVNlOVdjZ0UyY3Exb0NrVm9UQVo0bjBLczNrTVBXbzB5UUxOVkZrRDBl?=
 =?utf-8?B?MFVoSko5aFcxQi93bzEyT3REdVRzOUZjRWN0d1RzSVBZN0pkTVhKV0pkbnMz?=
 =?utf-8?B?RVJNNmYxSU1Bb2ZmYnNWV2VGaEtaVGVFbkxBS0t3dXg2bWMzMEI3TmpRdkRY?=
 =?utf-8?B?MzhpZzRDcVZzL0pTNDB6dnNpL2RpektEOXIzM21LdFgwSWhQS2V3M3RMbzZz?=
 =?utf-8?B?NWZRaDJkVXJCZHRDRkxrZzg1TEhIdjFkWDMyYk8vTUdnNWlSd1djRGZRVjBt?=
 =?utf-8?B?Y1NWVzlzQ2VObVJTMmkwMUl3RjNZZE9xOXByanNOMkI2L0xSWFVsWi9pSjF4?=
 =?utf-8?B?WGxMWmN0Y3UzcHZhemthQzBYNUdJcno1aU9YN29qRjJIZUd4eGZKa1NCWlpV?=
 =?utf-8?B?TFNsdmtuNVhMeVNYOUtPQitIcHhMRW5xc08xRkZLU215cTc5SWgrSVhldUpM?=
 =?utf-8?B?UVQwR2d3WFJCQmFkSHNqcHMrUk5hMHoxRkV0Q2xjUjNUMlphbVVrbnlGenJO?=
 =?utf-8?B?dmsra0w4aDNHZUlMWHhBTWFEc1A1cHR0Y3hSaUJqRjJsM0pEQUFOdFBDVEFQ?=
 =?utf-8?B?OEZ2Y29kWWQwcWxTd3M0UWE0R29JTjIwcHpFdm9qYWg5a29xRjNwTW5PMWt6?=
 =?utf-8?B?THdzMkM5aHY0QXNObTFzVVo2bG1MQ0ZIMExjWE5oc1J0RHVHbWVUK2VTRUJh?=
 =?utf-8?B?Y3daaGN2S0JMdGszT1J0TjJId2ZUWFBsOFRyRUxIMUN4bzdremtmdTBxemRw?=
 =?utf-8?B?TWpET0EzVVl5NFhveURrNCtJbHZGSllVNXVrU3hBYW5ySm5GY2F1bDJOK1JF?=
 =?utf-8?B?SU9aaU1hMjR2RkNxaTh3aGZEZGt6YldjZ2N6SXBNMG9NUGxRUkhZakIxV3R4?=
 =?utf-8?B?NUNEd2Z0SU9EVG0zckJLVk41VGJBTmJveXptcGpnR0oyZ25EOTljWEtwRnNj?=
 =?utf-8?B?RDlCLy93TUJXZFdXSkt1WENDQjZIaWt1dGl4VFlvVmF3TE1QRFUwQkJoelBm?=
 =?utf-8?B?SjkrMElLVC92UjRkUGdKckFsMjNkT1Y2QzBJMkhKUEhEWDNaSk5zQnBRTVlK?=
 =?utf-8?B?K1hvRnZOT0srZjVDTVY4bVZ1MnpLWlBES2pIOHhoODVGaFhBczV4TEZCdmYv?=
 =?utf-8?B?SFFXUW0xWGlROUlNZUlSd1owLzBFd2NKWjVHVmRqRGpWQ1NEbGJhbUlYaHBq?=
 =?utf-8?B?RjFrZFRraGZiK3FWQ09pNVhkRjZkWEtZQi92YjZnQjVOS2U2OVM5Q2pXcHVK?=
 =?utf-8?B?NmNhRTQrMmxoR090V2Y3U0pxaHBCay9VN3Z0V0h4UlI3ODNNbWFySzc5L3Y5?=
 =?utf-8?B?OVhCRUQzNDhMZW4xcjZCa1ZaQ0EvMEdGSy93a2c5S2pJWjZYZW84QTI5bEt6?=
 =?utf-8?B?SnhxYk5iMVVDaHJpQitpYnZBV1VLell2TEpyclh4YWp4bE1OeEhGZWIwUEh2?=
 =?utf-8?B?dUlsTWh4T3F5RXBvQm5yY0hEUWgrRWRlVytUZ3lWM20rKzV1QmJqSnN2QU43?=
 =?utf-8?B?L0N1TkxaMzIxR0VQZkR6aGdiTEdyWlVJd2QvWVM0REJtYkZUL1BVK1hiSWN5?=
 =?utf-8?B?a21waXcxRGQzaXkrbFV3T0RjeWsweVoxcUF2Yndod0d3ZkRUcDVmektBU2F3?=
 =?utf-8?B?UWdHbHJiSzhYVkw2d3pLbUlmbjZTaHdQY2g0Y0hpVjlhdHpvQ2pqK1JhVzRG?=
 =?utf-8?B?bDNCUjBPWTlBRmtGcW5YcVlKWVdjcmI4aVAvSE9ydjdWS0M0WU5SbVdEUVp4?=
 =?utf-8?B?Q2VEWlBvVjdVT1Bja1o3Z01MOHgwOGhaU0Y4OHVaSUtQemJtdU9NTWRjaWs3?=
 =?utf-8?B?Z3hsd2F4NUtSSmNuaGs1b1JmSUlaNElGRWtVbVBUUzhoamZCc0FIMlhWZERN?=
 =?utf-8?B?UW0wR0tMNTlyYXR5eHRDclhwTmFya1hHa0RVZDlCYnVZYTZsM1JIRXdYVm9O?=
 =?utf-8?Q?TGZMcWFLhfu3Fo66NdkPjembU?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Qfi/kVlM36GWF4heTEd7fp3/SuAxWUMudyOa9Y/anaI1T5yNIpwOlPs11KsZz5owHrZf9oeTS2vLtJyaQoNdd2Q+xuhYW7jCeiQi7gzL+3RsCv8pYVbaYfdgmJwPo2PE8KMvuSqEEEX7vcrrk4Zs/rgzhIqnF5+8sKDcnTryCYW3tYPQdlG2DXnRCdHqw7LZ/tpwMLKuBEUzshQ4R3ZrnSE75Ge9upJqkEMhK+Mj3VGORGU3lKHcyCaTIqmzuJls8ZaGvuWZ6mPipyixpsW2zEZo5gsx0LcpwWyEiQ6IpqPZE57hnttSSU632CE5Y0UE4pDOV1R4r28y0VIdNzKSyuXN4hFvIiicEMdrbJmRY/GMlbrhl3k03iRc4ygsJYZZANBmPUKvdyVfWnAnsEQp4x32ITay7I5ftW7i/7tpPbv0WQEAoEWG5oJ4ZuwspETHNYYSr5J9XWPE6aS4E8CIoaiHlKhywPguiEAI/FXuW4M+DVeIK825Y6fz7uv8JMks5xJ5AvjUFTVpTy/8tFNMS2ljWr4Sof83LyS5TJn6GCGLzqrI83c9oWgVNB+KzJdQ+EmuqaAqny8S6HOQCgnOjGUw0Z6QN9xmghwMr5FEVms=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23fbb1d6-7783-4d97-c798-08dd79fd4e59
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2025 20:05:00.6785
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WjXluw7Ql0g7ZFFVPN9Wd3agMNW4RnQq5yJnTfE7DiZwrN2GOEu89M1SgfTIUhhBPK9f6q5cg9ISzrVOw6Fzeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB7700
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-12_09,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 mlxlogscore=831
 suspectscore=0 adultscore=0 malwarescore=0 mlxscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2504120155
X-Proofpoint-GUID: 1IgQ6PiVgu2Xj1G5CGnDaEK49LXL0_P7
X-Proofpoint-ORIG-GUID: 1IgQ6PiVgu2Xj1G5CGnDaEK49LXL0_P7

Greetings,

All are invited to the Spring 2025 NFS Bake-a-thon event, to be held May
12 - 16 in Ann Arbor, Michigan, US. This is an in-person event that also
includes secure remote access to the test network via VPN, enabling
virtual participation in the event.

Event registration and network, hotel, and venue info:

 http://nfsv4bat.org/Events/2025/May/BAT/index.html

Please let us know you are planning to attend face-to-face or virtually,
or ask any questions, by sending email to:

 bakeathon-contact@googlegroups.com

-- 
Chuck Lever


