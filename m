Return-Path: <linux-nfs+bounces-11864-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F280AC1098
	for <lists+linux-nfs@lfdr.de>; Thu, 22 May 2025 18:00:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C890500E33
	for <lists+linux-nfs@lfdr.de>; Thu, 22 May 2025 16:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E00F179A3;
	Thu, 22 May 2025 16:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="b/OdFe6c";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="DIkgKd87"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 876CA29CE6
	for <linux-nfs@vger.kernel.org>; Thu, 22 May 2025 16:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747929639; cv=fail; b=bvMfxguE4Wk9V0rytptzO87fOyG42jYUS5W4wI4aozRVOzEuoDyXp5vZ6dwEFGpV9iiV99lRnW9/yl0rOs3HApaqrpbgISM4eeWU+peFE4LTOtfGTXLhO9EhIWiVjBER7FkVd4NSW20SNooXoTfQD0P4C3IXnwJi9mi3WUILVg0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747929639; c=relaxed/simple;
	bh=3gF30p1R3clf5GLTz/O4iODEpFLRc9iiSDeT/FH5UTo=;
	h=Message-ID:Date:Subject:To:References:Cc:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gPScqZRklLL5DF0QwSo/AIiqvPZErxybj1Ce0pN2bJ9pkirV9sP3GuDy/Ne6cV3Jg0Ps9VFqUgUU9erImXhh9fc/MTV11yIhNDCkMi09cgRmubLujz7POkBpFPsK2Nzj1rHcHi20bXqTjUiMplHOIfy8qVU4LMx2eDMUiexzfxk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=b/OdFe6c; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=DIkgKd87; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54MFtk8S002130;
	Thu, 22 May 2025 16:00:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=Ma1gm57aUL4RnYo0LHpZen66KM2MujkcAJUTYmX4+rE=; b=
	b/OdFe6c6OKz/c6OR6vrVLuGHvKMT+9OliLVHZftbC1b4wfDnRmK7mEMwn31vVjF
	DJkdlzC4aERjycRP4/lEHoDKxgef8DntJpdwLyH5cLMkD4shjkCL0hxYfrax3CQC
	X+CFltJRk9fRsul7T9OU6eD9HjNk/3gEh6lh2EAhcgQ21uuJadm2mViGogUxwtpb
	gZV6BxYW6BJ7f4wix1JlNjy7nMts/dfZxIrc1EYVzFrUuthb6ysbS40Nh5P6U+Me
	u1ZTz/2W2cKS7IpCFbTI5qWgE4T3PgCXUOocy+9vce8Wc2Z16T09caT4bV4mwnr3
	KxjEKVCcoBnwHdDE7fs0Vw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46t6gh02g4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 May 2025 16:00:35 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54MEd9PT001822;
	Thu, 22 May 2025 16:00:34 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10on2084.outbound.protection.outlook.com [40.107.92.84])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46rweturkb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 May 2025 16:00:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q+XsY6Cz4UE1swWClh69dz+XIyrAcHEzURs8ihudjxS4Vj5E/TcE3etbdWtAW1mh345f36PuqgEM6DKkD7N3oOpVLjXWiPkaokaznBGMElOdLDH+qhnDiWhkr6+jyrT3naPMpzH1ZqEmFcZWAg7FESBsoyJs2PJAzo2ulBIyeS4pSQvvEf8FQzw2F3dKcLy24Acvky5OLNJ5EDi8WbDRN58hcOX3NzjzXUk38iFL2TJORunZw5YODy/KIHnIL772rCplolPv4n8v/K2poxVVJ9wKYdcBxJbIiWlsMJ6uqotaKNtLcY92G76qT2/xdP1lOtiPn2lqoVkJsZANdGWOCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ma1gm57aUL4RnYo0LHpZen66KM2MujkcAJUTYmX4+rE=;
 b=qCZxMtdIZBGULBloUrbcQc0Evz9RAkwEzjE4aM02tFCKDBBWLiCtUyykK+bojrfbD5XSAddBZQRPmVvknAKU+4eOMxmFxmWiVF2DBQXrtM9ZBoXgcxYEAuftSYl+YbAqcQUJl/vGBjJ7zuGA/9qzX9fNOslSMkiwmjwKL9WLisd0jMLkuGAoak1QG2iF1agLUHZjViQIbxe9YHbtyh/N+fbFhZvpzKJOmqZI/zJ7KHD7LUG9In+mBxhxNGdGawWFu27/Hu+kCs9bdrRsSLInDrqLFYPqi2TuEZtTQbVNp4EJBr+SwgHZl/xciLTAomsEdhuis/ta4x3h+NmxJXse+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ma1gm57aUL4RnYo0LHpZen66KM2MujkcAJUTYmX4+rE=;
 b=DIkgKd87sLdvj0GkfXDvol+Neiuj2cLi2M9U037CntJZ9CM60tH0s7PMgu5TlWLHnaQWrG7XyD9IAF2sFd+k2Wb5S817CpbrcxiajZVyCoWJGkAv6uycz/6LtDcYVXDFbpSJtkOs8M1PZDWXHxAnBZqaEsGV5sq1ltj7ewHCOXY=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SN7PR10MB6383.namprd10.prod.outlook.com (2603:10b6:806:26d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.31; Thu, 22 May
 2025 16:00:31 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.8746.031; Thu, 22 May 2025
 16:00:31 +0000
Message-ID: <45bf7584-7dd6-47ce-9a51-fe47e6ebc5a9@oracle.com>
Date: Thu, 22 May 2025 12:00:28 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: libxml/GNOME dependency MADNESS cleanup: nfsref(8) removal
To: Mark Liam Brown <brownmarkliam@gmail.com>
References: <CAN0SSYw8j-nyObz_F6C13sOntap-JYRNDusx+M8_WHzfPH-KmQ@mail.gmail.com>
Content-Language: en-US
Cc: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <CAN0SSYw8j-nyObz_F6C13sOntap-JYRNDusx+M8_WHzfPH-KmQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR10CA0023.namprd10.prod.outlook.com
 (2603:10b6:610:4c::33) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SN7PR10MB6383:EE_
X-MS-Office365-Filtering-Correlation-Id: c54058bf-5322-470c-b133-08dd9949c6e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YTVOMjUyVnFPamVCTDhlZ2dWT01XNDRlV2hFZnhDc3NDbmVXK0J5WWhhZFRB?=
 =?utf-8?B?d0J5NGo2aG1JYmNPNUJBQWhzUHRFTjY0YkpYQ1B2ZVM3blhIWk1rdEJ4WnVx?=
 =?utf-8?B?UVJXN25XWXBkU2EwY0h1ODlQNmdsVWNZRFgrMXpianRQa3B6SWtJdmczYS9I?=
 =?utf-8?B?SG91K2FXKzg4cEZodDhuTDV3dnprdmxZZWh5U2lGUEd1K3NLVGxJVW1EdlVS?=
 =?utf-8?B?ZkRoNHRFK0xWaUd1YVpLc1ViVzNSZ3I3NExoMUc0RVBSUWlRUVFrOXdXVUJE?=
 =?utf-8?B?cFA1WVJGS3dqRVI5dUt5aUxwYWRUdDJoYjBqOFdNWkN1TFdnNThkNW1ZcW9P?=
 =?utf-8?B?ek1meGovam8xdG9qTy9KR3JscU85SzIyb0paVGsyWW90bHErNTUweVUxNlFp?=
 =?utf-8?B?Rld5WlpSbW9nVTNqbXAvaE9ZdnJ1SE0wNzh1SVVMWmdwTWJuNWtxYkdrcVBj?=
 =?utf-8?B?Mk5MRkRPL3h3aVhSV2VmVUxMblFkVE11TEpYbFZaT1ZrZ2lLcXF5ODRyMFdZ?=
 =?utf-8?B?R2hTb1BISUxLZUE2dXFrMmV6czlxcEtnR1ppaTZEWDFSTG5yWFhNSStQY05j?=
 =?utf-8?B?UlhaMEI1SVJEZlc0TTNGUkZvY3AvYmlJMWxXNHIvby9BeGQzZ2VrSk04YkJ2?=
 =?utf-8?B?ek5PUHczVkxxMnMwYkpqczE2c3FHOFhoMHpWRjNBQnRJUTQ3U09udURyS01o?=
 =?utf-8?B?MXcxalZ6RnNFc3RuZWxyeWFHeWlEMnRVYTFnZk9JanFqWGsvaHJONG1zVnl6?=
 =?utf-8?B?SDZQSk4xYk9IMVdXNzBVdEcxa1B5Ti9CNDZDblNnRXFlS0ZpbEcxS2RyK1Vv?=
 =?utf-8?B?eHEzOTFycDk0TldaUXpyWFpTaThpOXBvOWVlRmZlSUFTcnFQRE9PR3c5NUl0?=
 =?utf-8?B?MWRpMVRaWWdPUzdhRVcxS2lUYktUbDJjakFZcFI5WkRHRUF6QzNWM0Fya1lx?=
 =?utf-8?B?SXBMV3lwL1ZqVGR0YThqaTBqZnVuRDNnWFNrV2xnYlllWnlJOWJVWTBXSENz?=
 =?utf-8?B?djFsa2NaWmhERnFRdWZZOE5tVFFoM0dlL2lvc09PS25BN0p5Q3RXQ2dUY1lv?=
 =?utf-8?B?ZkdoTzJOcU9Sekd5RXpLRmdoNXpVb0VlNzhoT3hPVktKQ2R3T0k2dFlMWG9Z?=
 =?utf-8?B?M0pQSm9mK3BMN0I1VnpUZ3djVGxSNHhick04TG83MUgxc1JBOWpyU09lWjlz?=
 =?utf-8?B?TklJQWgvcWJjYjQvWm13NWlaZlY3ZThGRFROaG40M1BvNWhoV0NBeEhJS3ZQ?=
 =?utf-8?B?V1U5ODk3eEZXTSt6dG9vUjkvc2J0bnZVUmdwaUhOUGw1eXU2WXhCbGlzbE5H?=
 =?utf-8?B?MVJOTm9zZll0Z2NycFBxa0dZWnl3WG9EUEdsZFppbWJyaCtRc2V3NGtOYTNI?=
 =?utf-8?B?WTFhaEpGRmc4dDhseStVZjhaanJBeHRKV0lSUmZ6blFnRC80dmFxb083RjNG?=
 =?utf-8?B?SmRPaVRXcUJLWVFFRUNaZUhJTUlVdm5pWXNDWmJGSVVXa3J6QXd5T3hBZEtx?=
 =?utf-8?B?b3NsTlgvZit2Ry93VGNOeUI2SkdVUGI2aGM5dXFtTHdYbGVlTGxZNEJFZkUy?=
 =?utf-8?B?RytGa1hYeFV2STRpTU16MUd3ZklNYkQ2NmtzcHNNRDdPU2pabDROWVpZeWg3?=
 =?utf-8?B?eDdxV3pqRmEvMFY2bDVpNU1DU05xd0hqeHE1VFlVWWpkZXFLcmFLUEN0NkNn?=
 =?utf-8?B?T0V4MTNPb253UEhOVGRZTkJhN0szemg5TGxnSE56eXRNV1diMTZSbzVReFRh?=
 =?utf-8?B?TDZiVVlVbFdzVnhCeHE4S3o0N3FrdmhFdXFYbWlpeXNWNHNZQVlkN2FZODYx?=
 =?utf-8?B?enVzcUovNGpGUGVMTFFMN3UvTjZ2NEUzQmdDcWZjVlA4R0VuZlBDNGNKeEk4?=
 =?utf-8?B?aUMzS1g2ZUFUb0N1OFlOYlhNci9RT3VHVkVSczBpd1V2THc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K2RvZk92SVhZZmxkdXp1U3pLM1BDTnYySEwxWG5RV3c3U1ZWVDI5MndnYkdx?=
 =?utf-8?B?L2J1TzY3MlRWWGJlaWxzN0s0VW5QYW9sVHEvNWk2dllOR1U0cmNRUGdHUldL?=
 =?utf-8?B?cU9Wd0FVSU5Rc2FFeWw4NUpwZ1psR2pSYjhMM3RGcEVDRWFIWGhSVStLMDZ4?=
 =?utf-8?B?K09mZFhTMHhGY2FnbTJXeW4rYnh5WWUraGJCQ01YeHExeXdhc0xScGtDTjRN?=
 =?utf-8?B?VFhadW5mL3pKVzhTdWhFUFF3YnNMbmdpcjQ2VmpyYlFtVWRpNGUwNUpGNUp6?=
 =?utf-8?B?d1YwdWMwaGtndzNTMXVxVjRva2prUTFsN0dIU0JTZHNTcVIyazMxRTZnbHdO?=
 =?utf-8?B?endLN3Nxc0hEeElWamNYL1IxaHlJc3cvUk1hN1lXUlY3TWQxcmM3M1g4NUJz?=
 =?utf-8?B?azRKemkwTU04ejJCOEprdU12TlpURzdaTkhoOHY3cXVlL0RPdURpMXE2UVp6?=
 =?utf-8?B?MFRuSFBJa2tEUzk2OW5wMFFHQjMrS3g5alJ4SnhzajNXdUFDRzVZUmFyMzZu?=
 =?utf-8?B?RE8wc3BNalA0cUJSVXEwWVMrbjBia0pPbk9xbEN0V09JYWd5VFFhZzNVMTVr?=
 =?utf-8?B?SkYrak0rakd2NlNTVEUzUS85ZmRxNEM4eEsyc3JPUE5iZGJrajJLZFNpVU1L?=
 =?utf-8?B?d2NlQ2c4Q1ZWbXJZWGZjZ2E4Uk5CYnhabFR2L2ZLdUN3R2ZiM0NPWnlQV1l0?=
 =?utf-8?B?U0huQlYzTlAyei9lZEtsVEpDWkRDeVE4M1NmVmRXOEdncTBJbjdwYjA0ZzZD?=
 =?utf-8?B?RGhLTFA3bzRlb1hEeVhoR0pkUE5hL0cwSisxc1pkOEx0NS9vU2t5WDM2djBl?=
 =?utf-8?B?WVNZalk5NE5jK0xZZjk2MkY0MGpteGJRV2R1OHFrSDlLM2NWMEFudS9mdHRR?=
 =?utf-8?B?eHhVck1nUzBJNjF5b1ZnODhSWXRqNG1ON2JVa0krU2t0bkhaSmVFaEFsWjBT?=
 =?utf-8?B?Si9DY3NKYk1iRzFQZlpOc0s3QnJYNnRaUmRORitiWndoWkNVZU80Q2FTaHBx?=
 =?utf-8?B?WGhUaUgvcTdKbmlqY2F3V2VxUlNTWWtFb2xxT0d6T2VjMnVBRGN4M1FLWSt0?=
 =?utf-8?B?R3ZyTUkrbUdnRThnQ25DanFzSlRPN3hYQ2NYRENsRWhXMlZDVzIrUWlYelBx?=
 =?utf-8?B?dExTZWxWM0pESVQ0Zm1PYXlHSG1BWEtwRkJtblpETWx0Umw1ZFAyeW91bkMz?=
 =?utf-8?B?VWp0ZlJ1MTBSMUVFVWVPL1RvVEZYNXRVdFB5ZzFhMmVoWnlacHdtRHJCbUF2?=
 =?utf-8?B?aG9ncjJUa3dDcCtSOU5obW55Q3lsay83VTBSNEovT0cwanF6aG9JTzBlV1FL?=
 =?utf-8?B?RlFrWEczVVdUOGVHZUN4aytIT1ZCcldMdVBUZXA3bnhOTGlzRVl2VGdlaHYy?=
 =?utf-8?B?bTRBcDFEb2NYUThzQ1Z2azJTMUZSU2ZuNUNrWVhVRmdLRWo5L0pzZTZtU004?=
 =?utf-8?B?SkZQemZJaklOeHgraTlBTWVqY25wMHltQ2NiRUVqbUthTHc1aHBhaE5vd2hj?=
 =?utf-8?B?OGlMc29NcjFUOVE0d2FPWDFaaVRhNGtzR1hzSUg1dWZyUWo2Vzl5VXJCM1JE?=
 =?utf-8?B?NUJtY1BmRWdBRG5ZeTQzTk9kQ2pTVWtYSU5lNERWTDJ1MW5Gd2ZwVjdzalNq?=
 =?utf-8?B?dkVDQXdNS21mQjhKY0t3cDlFSUt2dExTYmxXK0pSdE5OUzZRNm5GendURVgy?=
 =?utf-8?B?bGRraUhEU0U2elR0TDJDQUU2QlhoVFUwZmlwaFNIK0R3aEdSSWRHbmVKSUJP?=
 =?utf-8?B?WFNyOW1ZSUZlVjlzaG5rOUhTRVNmdjZZVUFKQ2kwdVFlMFhvMHNRNGxMc3dG?=
 =?utf-8?B?eGxJdC95RW5aLzR6bENNVFZqUTJtVGgxVG9uYVZrbitLMUpsS2lrdDVaNUN2?=
 =?utf-8?B?eDVCVFljalh5bzF1MTErNnBFUEJDdS81UlpyWVZRRDJuR3F4Vk9iVUdRdkJJ?=
 =?utf-8?B?WUpGVHROWHd6WnhhbFdkVXRXTjkrMGhqemN1dk4xOXA5MXc2ck1tYngxdnpa?=
 =?utf-8?B?bDdiQ1AzbkhldEgyNUptdkxCNHBFbUtyWUNaQ0h6aW1pNncwVHRHODhsU281?=
 =?utf-8?B?bmFYRkNxUGhFbWJSZktyT3RBSk5Ca1VzZWcwb1dQbFBPejBDbVIyK2hmd2pr?=
 =?utf-8?Q?DB5DtyxLIryplIMg0ETMClMQY?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ppNRmQ3wp4Ipeh1GmmOgijgyR/gkpuPLtQmkgOZSAYceT5jGYpvt/jfPLeUtnmCFUwZ/Ru/+VGgH6Rljvh0N1qgga0PN63es8oyZCUk6RtDgOCcOcrs01GWRHoorJnCSgrecCYMUmG5l2e+fvewhSOpvAKdVSaEAvN1imWZXeBjm1R9E+Bae0QK250L4Gs4Hzi65Xp+UL81jPFMN2vDW7WRoGX9cluJ1SsSjiQs2EoEddJdYwFrlydu3oBRSGrC+Xt7V2mFU3LwRbJ3At7lTFBSfBh3XmoulHsNXVtIeeHZYif4dZFJj3lFdqHSUGTU4xz2TrdSh2+dQICRDZHWe1xRqrM0myEXcyvitkDGwfBH/3JcNRjPOxJMTT/8J4J47ubvE0baN0s8RZwdqze721MlTKapJkmJ0j4L35HriVPtcDgxUUfoxg5Cyte092glR2+tOtYw8qc9j7GUIJXI/xbeUx4fVwkxf0gOp2dAjYkJPYSi+rkjQ79KoXjW9T+5hTsn4Tjgd2vysNqe88E8/zErKloDn11hg1IU7Lb5Cyb5cK8yFS3dXPUn7Heah2AP7uzt0sbfOx6+iCpZfwC0YqhiavzQ7X4piHmVNCKilmZ0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c54058bf-5322-470c-b133-08dd9949c6e9
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2025 16:00:30.8315
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yaTQ3FC1PBWIDeyKBFzvwsRlsF2D2KhfQ8jGczZnNCBQu/3qOolPgmSZx6jQGaf3gmiRGYKakKsGlPvZ1fubew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6383
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-22_07,2025-05-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=928
 spamscore=0 bulkscore=0 adultscore=0 mlxscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2505220162
X-Proofpoint-ORIG-GUID: ZcURBLeBUlbeDIF5SU82UP2SzzTo_gji
X-Authority-Analysis: v=2.4 cv=Zu3tK87G c=1 sm=1 tr=0 ts=682f4a23 cx=c_pps a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=MJ85MNrLyw5NGUCeqYIA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIyMDE2MiBTYWx0ZWRfX/miKGzqY0r0h JrW5ffKg8TQc5XsYD7vY2ayuCwnAYhM6MTRuxP2ZFnavz8wn/Dsiw8EF4xUhCOkV0DtCoW2peKW qohsVjHb+lvoIQPOiM50MoROFoeDzYhZ+GpnEksrkrX80HBRJmeXUgFRjyVfTgQWs1U6KaEx3Vb
 LI08ff5EDotARf5fn1lQ1cY5fEggmsyBeQLNJ3cIq0y4yjyCM7cCyiWMEFPhSAJn0JNFLAHmWTg WbXZGijfPcVMpzaUX49ap0dHUtTpyQFxe1aH//3yxElajz8sTcvwfz4B+XTUZvM6/SooE8RlYiR QHToPdAbPk67iLJUPbjHtGX7xBVzh4krjwZs3+mXjG2+ggY9QmXkvCC0s3t9Gkq15v8FYEVhto5
 yZUm/MCt0bJTV76HPDEp7Ns2llhiijUIgz/QLcn12FpwgvXGsOO7VMnWD8MtOw4R3XCJnxgJ
X-Proofpoint-GUID: ZcURBLeBUlbeDIF5SU82UP2SzzTo_gji

On 5/22/25 11:58 AM, Mark Liam Brown wrote:
> Greetings!
> 
> I am going to post a patch series to remove the nfsref(8) utility.
> 
> So far the "utility" has only created more harm (namely, dragging in
> GNOME(!!!!!) libxml and cohorts dependencies, and related dependency
> breakage, which in itself is INTOLERABLE; and breaking NFS root
> support); and only obscure "benefits" (NFS referrals, which no one
> uses).
> 
> Following that will be a patch series for Kconfig to make NFS referral
> support optional, and then mark them as depreciated.
> 
> Mark

NACK.

-- 
Chuck Lever

