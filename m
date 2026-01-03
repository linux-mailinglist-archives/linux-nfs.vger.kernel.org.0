Return-Path: <linux-nfs+bounces-17421-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 6187DCF0542
	for <lists+linux-nfs@lfdr.de>; Sat, 03 Jan 2026 20:46:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D5241300485B
	for <lists+linux-nfs@lfdr.de>; Sat,  3 Jan 2026 19:46:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2A9B1A2392;
	Sat,  3 Jan 2026 19:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FrbVku53";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="JWue/BIT"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7E95DDA9
	for <linux-nfs@vger.kernel.org>; Sat,  3 Jan 2026 19:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767469593; cv=fail; b=aJGzymh6WfTj3iQjuQ/61jtGaCgd4BCbQcaAgvk1Gk7XMUKX/MRXk5nsf6NAoUfSJ8JRf5ncug3hOzAQUSntQrsdnn7jsFjgwBz2MxWC4+zS3KEkKMIoNq4HRBOZjsdZN9861lF0Fif129ige/Fw8XEw30zdMtFeY7Iia7YXNr8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767469593; c=relaxed/simple;
	bh=3BxDPU3+ypdyT0ruUNwa86iIJSlx2S0tLPhiwnuKPWA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SoZK6OcJfcu4mc6nHGaK++2cxFGM7rT+YzhGAJkaz1ohAATxJyrI+FDPfnDSpEASlBnVCHYN/PiRkKJCMl6KL3b+t041Ju+ixV/avxGqhZ4uOBNtZS0GNiJ3ep5Gq8LYvlBCIcUYQffL2bxnsVEjKmtXBX0QITULvzZ+uFUKzdA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=FrbVku53; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=JWue/BIT; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 603J0Q9U2167796;
	Sat, 3 Jan 2026 19:46:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=g9ZdZkZ5tORklpEfhI1vJU3XtqmHg0KI/RwJQKp5pt0=; b=
	FrbVku53j2bxKAEXcJ4GMUGqfTcXyuzjxIVodKXy0rguBvAHuaAEogii/cjlJVw4
	KcW/bFJVx4Na/1WOLMtiLE0kmlwWUyP32jd9rMxp30eOwkz5sBMdgOPaLtWIjmWr
	mWfEYyP6xg8f6gvtCTpIo40DyVX7rR713B4Df5R09KGlFDFTWFf3bhNFp7ajFxYk
	R5yt6K9jR8UJqJS4ssiMxVYogrillHSqscCO9+17CpP5+E5Scq6qeHsbFTQ3m6bs
	lfycBvRw/CWLUE5/oVAhd5SXLXMEixkQp9/2RROZiDkYiHeD0VYezDkWIeoWEDUC
	Xwud1sY7gfoT+T9TGCcqVg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4bev2jga9y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 03 Jan 2026 19:46:18 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 603D8FWb030787;
	Sat, 3 Jan 2026 19:46:17 GMT
Received: from bl0pr03cu003.outbound.protection.outlook.com (mail-eastusazon11012052.outbound.protection.outlook.com [52.101.53.52])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4besja5v4x-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 03 Jan 2026 19:46:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fyUeyVwMEU2QD4gCdvHM97q0B0Whz1Q3F9f5lEKpeXkFnqlVh584IRH+VOfqyWVNRNEGm7VnbZTYwip8VimhfYeFr11wTQdhf498uS4mK+KbQUfCl2bC7C/Joagn1OOfD3Y3p2IpeVmNSUnOHuyu7nsbJ9suWq0cGUx3YMKnNVJeWZEJeV1ALJP8woFGce/v7rX40cK6+a9G/34uESccjuORMRoDQhXK8VVM9g/HOxPSGzwVWvTaiGJt/EsDKOVLE4aj2+PJ8ruh7yh4ZCRWT0pB904A3jpvBaX2ZvFMY/IsBOPNUzbUkwXO4Kc4pWBG0CAUN5hUJ4AK5TQD4QfpkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g9ZdZkZ5tORklpEfhI1vJU3XtqmHg0KI/RwJQKp5pt0=;
 b=V37bHnU4rVx0LFvAL2XfRVENWkoMOxJK8yzEE+jgyGWVsJ+Ew6DYXGrPwMCgdT7cryyPNSaDUCv1lelAz146//WMJ1Vtj5bpi7GpHwoGM19vyTwyV8ib67IyodyfQ67n1gGTLNlvrSqlWLgrDNVJKE2I31GZcEZ/KNSrkfqKYfnAt6ldQOhu6//WohpY1tEPPNPmpOsfSnBV4LjYwjuAa3LlbVg4l/kg3GYeGQqk+qGAjOKaSPwUSDZVBP8kQzKpLrZQ6IEU4oAnjqECGDluR1mIO7w1/Pm9+RZ9TpZLU0uEwf9fv3Og/4II8l2B0VYNKYoDyY5D8Wi43fkTAENeVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g9ZdZkZ5tORklpEfhI1vJU3XtqmHg0KI/RwJQKp5pt0=;
 b=JWue/BITQW4GcHCzhUnUVv8avZDOkOWnB5eaqqSZP5xlYRvLdpf4ao5aqaHgNNs6ukgwnCIR47q8RmIsoyMQSNZDzOBtY7LsvHh+CLA7fojIU9HPffo82XT6VBE+cRbyA3M8lRFUzahv8sYYh0hJPjSvXRSnq0Ry0jBnlrz3sLI=
Received: from MW6PR10MB7639.namprd10.prod.outlook.com (2603:10b6:303:244::14)
 by DM6PR10MB4137.namprd10.prod.outlook.com (2603:10b6:5:217::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Sat, 3 Jan
 2026 19:46:15 +0000
Received: from MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::69ee:3509:9565:9cd6]) by MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::69ee:3509:9565:9cd6%5]) with mapi id 15.20.9478.004; Sat, 3 Jan 2026
 19:46:14 +0000
Message-ID: <a6f43aac-ee02-4b53-b096-7c31e50a7927@oracle.com>
Date: Sat, 3 Jan 2026 11:46:11 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/1] NFSD: Track SCSI Persistent Registration Fencing
 per Client with xarray
To: NeilBrown <neil@brown.name>
Cc: chuck.lever@oracle.com, jlayton@kernel.org, okorniev@redhat.com,
        tom@talpey.com, hch@lst.de, linux-nfs@vger.kernel.org
References: <20251226212213.1385803-1-dai.ngo@oracle.com>
 <176679520754.16766.9950497518646716091@noble.neil.brown.name>
Content-Language: en-US
From: Dai Ngo <dai.ngo@oracle.com>
In-Reply-To: <176679520754.16766.9950497518646716091@noble.neil.brown.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PH2PEPF0000385E.namprd17.prod.outlook.com
 (2603:10b6:518:1::6c) To MW6PR10MB7639.namprd10.prod.outlook.com
 (2603:10b6:303:244::14)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR10MB7639:EE_|DM6PR10MB4137:EE_
X-MS-Office365-Filtering-Correlation-Id: c2850fcb-bebc-4f97-3d40-08de4b00c0ae
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?bW9GNmkxMXUrQjNFeWJROWhxZExFWk8rYlZMU1pSanM5Vm1vRkppVmdzeSs2?=
 =?utf-8?B?d2xJMXBJeXB5MVdJV1kvVWx5Mm0xNm05aU1uS2N4UjZ4aTdORHFvMnd4Mmg3?=
 =?utf-8?B?T0lBRUpha2FvcXl0VlFFNTVMSlV4TkVLdzRYclVlaUdiZDZvVmU3M3VTSlo1?=
 =?utf-8?B?b2dGYmh1M2c5OCtjL2RWRlhnMGhDTkMrdU4vWEd0UDNQais5RlVOQmRFOGRx?=
 =?utf-8?B?UWRkTTF1czU0cGJWRVJYamN2TFR6YTVSalhjU0lWbUorUXl1UHNvUEU5TVIz?=
 =?utf-8?B?YnFpdDQ4TjBtTGE5L29UYmlDMk95Y29IeTZWUGFWNFNvaWF5ekxQd0VRUEFn?=
 =?utf-8?B?UlJsdzNXMGNOMzE1M3R0OEV5VGlPdVhYM00zVXEybVZNTUFHSTVWTWFETENU?=
 =?utf-8?B?NTZoT09lQlJoSmVYbEhCMnhvYkVyUkNmUEZMY0NiRTdKdzJoVW1UTFZFTFFC?=
 =?utf-8?B?NFIzQkJvcFd3WWNkZVN3T2lWaVh5QUlSR01qZVM1UHdmUldJTGlTUDIvZjBR?=
 =?utf-8?B?eFBwbEROMlNpK1VLNzR2ZDlaUlpWWlg4bmxxYll5ZjNDYWN1S3RINlQyVm5I?=
 =?utf-8?B?NHduWEVFYmZMakpWMlFYTWJrZzBoN2VwR2c1OWhrWWdoVCtJd1FEZ0R2aEF4?=
 =?utf-8?B?RFhoRHFmWHZRaFB3ZndpMC9FVHAxbUMzVTNETmZHRHU4enJPWjZaT2pVNVhT?=
 =?utf-8?B?clpndU9wYnlDbmlYOGxtV3F4K0krQm93c3p5aG5YRitSa09lWmhCRkVlbTBL?=
 =?utf-8?B?SDJ4NEZGcXpIUHVaYmM3OGlndSt6NjN6THdjdWtTbFNPOXd6MnJENXoxREdC?=
 =?utf-8?B?ckx1MFVwaFVmbW5CbEc0NjVwVmV0b1liNTBjd3R3SlNzam91RUp3djVBWUpr?=
 =?utf-8?B?eXRZU1o0UEg0SzNTcmpoRkNVWGRkVHNXWVJmLzlUVUxPYm9XLzdQN0VLcDdi?=
 =?utf-8?B?WVh1WFl1b1FpOXpvczM4ckZZbmg3eHNudllyYXRLRXdsN2xmSWRtVEtjdDRB?=
 =?utf-8?B?RFpyUi9UTytBcXZzenVHKzM0VmUwSE10cGNsRCtlVUtwZUkyTDFzSWRmdjRj?=
 =?utf-8?B?K2RibmVSbFQxMGxwd3BnQlk2dGJUeXFZN0htL3ZZbUdMajNlcmc1aGFINEM3?=
 =?utf-8?B?N2dmSVpPdEl0UGM5SWdZYXVqRTNRR0Q3bFRCUjUzVjJKOTQzdmQ0VFpxZTZo?=
 =?utf-8?B?a0JqUytlamlRQjJ2Yko0VkxKTm9sbDB1U0N4Y1VPQUlTSVBJKzVzWFZSL2FB?=
 =?utf-8?B?NHFaV3ZaM1hHaTlNdWl1STlSZEhpN1FLSjdLaFA0ZS90ZnRBYVZFZFNmVS9h?=
 =?utf-8?B?RmZZT2VtWnV0S3MvMFhzYVcrNXRlcHA4QVhVTzBqREVySTVrYStWb0VkQlpO?=
 =?utf-8?B?N054a2Vqb05rNWI3U2Y3cVUya21Zd29LK3A3SUlpd3I2U1VkUnYyOXJBSGNl?=
 =?utf-8?B?SGZPTTdUd3dyb3BVYjdVdENPcUdQWUwxMEFmTzN1QVA3aEtMbTVRUnpRVUFx?=
 =?utf-8?B?Vkh3aFRCNSt4RDV1WGFPQkRRQnFnanVYS3ltZG9QZVo1WXJ4V0dnYlc4a3lk?=
 =?utf-8?B?QzlzWGQrZUhlUEdXUmFIbFpONFNselpiTDUrQzFtZmR4NmtjRnlrbWxqRW5m?=
 =?utf-8?B?cHhxaUFMc3FXTEc1eGFKUjFJVWhDV2diN280L09lVWtleExabTV1MHZwK0hD?=
 =?utf-8?B?REh2QTRrSG1oQzY5YjdyU0M2bThqV25jSjdsNGM1ckJBU1cxNE1hNkpCak9D?=
 =?utf-8?B?TENRMHdnY1E3ajkwRnhJckZZRWxLamthRjRYaWd2bGhaQWhVaHdqS3pVdC9X?=
 =?utf-8?B?b2oxVVg0eXZEL09KakxxNjkvejBnajlqNGxEcVUzVWlMWVVobWVscjBQOVhn?=
 =?utf-8?B?TmhwYlB2QXd3WXcwLzdCRjlzblM0eUp1d0JHNzlFREtET1MxOXd3UExnUllx?=
 =?utf-8?Q?llMPTFqvB96mefNy1krauviTpiRcRRO9?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR10MB7639.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?L0ZlblkrZWNjeDBKWHVZMm1VU0MwNVNVSjNUR3dwMSt5RDZveHVnNGJPZ3dR?=
 =?utf-8?B?ZGsrc2c1WEN3dmk4ajZhRWo4ejc3SjhTY2VkeEtoMTBzeTdRTnE0a2prOVho?=
 =?utf-8?B?eWxvZEpOcTF6Tkg3NDZ1R2c4eWRkeENHWEhFUC9LSU0wZEFqWFVZQjFyd29F?=
 =?utf-8?B?Ni96b2xGdEcxWU9RU1R6c0o2bnBzOWxxMlQ0VzdNdTZpSDdZN3BIVEoybk5X?=
 =?utf-8?B?NEJVTDlEeVhlSVhCZmF1bjNiR3o2UXRwNGgxZk1zbzBmbFFLcitxZ0doVXcv?=
 =?utf-8?B?ajBxL1VJTVZIakwwbmFQODBaajVaT3BES2J6VVNCd1A5VHdoWHMweHc0WkQ2?=
 =?utf-8?B?dW1xSEg1V0FVZHd3WWJNTFpVOFhGa2pZU0s0OEJDZkMxeUxSZmRnYmpIT3Zz?=
 =?utf-8?B?OGFiZjhiWDQ5Q21UQkU5ZTdmUVpHWktMQWwzN1hYZFRqVEk5V0NxZWNLS2dF?=
 =?utf-8?B?cnVucnFBaGlWWS9vMjBrR0ZKcGN6N2N5Q3BaQ2FrSUd1dU5xV1B6aDVBalBU?=
 =?utf-8?B?eGphNXNnTmx5SXlaTVFpcm4wQjRTS3cxQXI3cXdWMTZRWVQrK2o3YVN0cFlO?=
 =?utf-8?B?MHk5WTl6bFRSR0wxVis1NUplZzFWRkVxNXNrMGlyc3RPcXlkd3kxU2NOcjFu?=
 =?utf-8?B?bE43dVV0cWJXME9kZmtMSXZpMXpjSW9rU0Fxa1p6Y0dKMG9NVXY5cTRmTWFS?=
 =?utf-8?B?MXRldXlua2tpYXgxVHpkeVF4VFlkakpscU85ZEZHZFQwcDFpWVVTTVBMcnRC?=
 =?utf-8?B?TU9VeEFTZ0FxNXJvWDRyQmNCMWhqbzNYaG9FTElVb0w5bG1IdmlRK0xtdFBJ?=
 =?utf-8?B?UXNRc0twWS94ZGVveUo3ODlLWGRvOGlLQXpTWG5oVnhacDJGOEhUQzdmaklQ?=
 =?utf-8?B?cXZ6U2lRVms3ZDJuNlp3L2ZLMWt0dUk2c1I3Qzd0NnJ4NEtTWlRTbThoelNk?=
 =?utf-8?B?TFJocFFYZlJLSTZaQmpKZUljd1U1Vnh5cHpSNW9vUmFib3p5bnpCZHhwcUhV?=
 =?utf-8?B?eWhYZEVaMWEwWGUyMmpxK2l4bElXMFlwOGg0RytnbkZVZ0x1d2VpenpQZnB2?=
 =?utf-8?B?NVJkN1FiZUhZcHBtRFJGU1ZRNGlUejJRcXNIakROU25MUTJwTXFETml6VzNi?=
 =?utf-8?B?eFh2VXE0azNFalVQU3p5dUluOHpDTHREendSVFZkSHBDK3dUMlNhVzU4N1Zk?=
 =?utf-8?B?T3pJbklZcHRRdWhHakdaSXFteG9GT2puK1NyZElmYyt6WHF1OXkwd2tWQUZQ?=
 =?utf-8?B?TzVCNDFScGxaTzA2LzVRcWlFZ3k4N3Z4c254UnQySXl0UEdveGRrQ0x4U1Fw?=
 =?utf-8?B?MG0zdEVCYm05VjgvUm0rYzdqeXBkeWFJVEZnQ1JodmM0VzdKdmRvQWtDQXhQ?=
 =?utf-8?B?UUhQQ3JRMWZFUXN6OEs3V2dJWlJRM25ud2wzVzFmRUhyNkdyck5MdDZqV2RU?=
 =?utf-8?B?OXVnSG1RbkFpR2VHV0c5RVpmU25CTVE2N2xzdm4xUi9peEFHbkhjUW1NbVlu?=
 =?utf-8?B?RUZvMG1GWUtIdU5IRUI3bC9DbTdISENaNk84UmM0a1ZKYTRvcVhsd1g3em5P?=
 =?utf-8?B?YjhDSXNDZlgzRWlva1FFWFFSemh2VEdjTHd4MHBJVUVxMmErNm9vbUczYnNv?=
 =?utf-8?B?VWtPeGpEZVljemxyOGlQaWUvRkg2M0JLcDNjZTBKZGR0Z0Y5Y0I3WHoxeTdS?=
 =?utf-8?B?eXVuZXdsU0RsV0s2ZUcvenRLMnN0VkFxeGVPcXIvbUk4M1cxanFvZUVOcHZZ?=
 =?utf-8?B?SW9HNmZzT3B2VDdlcVk3Y2dUVGtpbmorQlV0MXZpUzZ0ZVRxUHQ0ZzBQSFcy?=
 =?utf-8?B?b21zQXcvTDZ2OGh6T2tNbGdEUkxqVnBDSWlPeVFUYU9GUXh1bVZMTXk3Rkps?=
 =?utf-8?B?dFRIT2NXUWIybEEwVWlWcFhXTDJocGtocUpnV3ZxTzdLeC9Za2x4TVBoS25L?=
 =?utf-8?B?WXFYS1F4eFhQTVVkck41Y2hrTFE0TVh0OE9KdWF5VGpGSEZtcXBOU1ppUFVi?=
 =?utf-8?B?aFlQOUtnNlBUR1pDbExidEdJQVAxMmREK3VJVTRLRW83S3BaTnkrNkcrMUZ4?=
 =?utf-8?B?ekdhMS9abGZxWkpiblY3OTBkbVJhZFJoKzBjL2dmZk1iSXZlaFB2U3RLVGpo?=
 =?utf-8?B?UkxmMXF2TXMxUmZIdmt4QWFrV0JDODljanlKOWRxT3FHQ005YUJWT3E1MzJx?=
 =?utf-8?B?ZHM4bmY1SmZDaktXTXZkNVlKTUZVcEs3QmpZVHFLWXdETGJhaC8yb05NTTJU?=
 =?utf-8?B?cWlmalJvcXpTeWZGZWJ3ak1mbEUxb1dMbzZZSTRyTktER1Z0dGZQMG9hQ1ZU?=
 =?utf-8?B?bUlJNUVRS1NNWGszY1VCTjdWcVlTMktEY3NUdG5uMXRhVk9aU05JZz09?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	p8KOPYWZ+/WGXSyIN7a4TWYXI8CETc+7tvY5n35ks+95UBdNRUQDiD0DPEhNNKh80rGb1/gw5bcQyiD86yyBaw42hTDAzEispxLjKZJQrZJupX1crrzPjU+ibyOXCdUiV0g/7O2XuEIPrwFidcFta4uDnNipdjCF2nzNCD9ThOyvlMiwiIxuJw9N5KTA/5BpmokqF5xbRXRkN6wxiLL2bc4ehlQHglUd9Es4xelUzM2HvjzX9A19qS/wXZEeMk8ozcIOz32sEccLRdHyPsQDI5JP7CLC235wJ44fWNE26PHmrm+rRyjqxSOq+nM1TpdqmGA21OM58zKiCQTotG85bFXbWPYbN68WaMB+WRrWvXxZ97eaJoqbBGuNZK6oibTGbeBfyrlzVW3FJqzFBBBD+BKwLkTJS2FRp168YG6L6/VeH3LWIUAxLN251PQqK+g0iZfl3z7fO7eo7q6Ms23UjsgmyxSoMPQT5WXu8rX3BKhQfzFVI9ZqFif5kiidf5B5kWIpSVM4D9JnIBd5Ra5CWGzqOwmkySGVyvdvaVfvcBCFDiO2i4FsoYnG11rBKrT3S/p1uZvjEn9mjfVcrUGe+t/sDdI5AAkHCmJa5rmC2h0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2850fcb-bebc-4f97-3d40-08de4b00c0ae
X-MS-Exchange-CrossTenant-AuthSource: MW6PR10MB7639.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2026 19:46:13.9886
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AiXhp5jyR2+RIbSTMe0Cqeftz/lE9g/XxqFbL/H9AoOpKoOKHhCTWFo0+Ri60WA2enkvjrGk5VLB/y7hZr91PA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4137
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-03_04,2025-12-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 adultscore=0
 malwarescore=0 suspectscore=0 mlxscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2512120000
 definitions=main-2601030178
X-Proofpoint-ORIG-GUID: jFn7GscN_dJOONKrhsNknzz_zLcQTZqc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTAzMDE3OSBTYWx0ZWRfX/daIrk1M+AtS
 aWJyTKnoostaCH+0lNI1s5WCQnYwguAtwa0n14Cllw8tGfR74LQza1farZEfn1Xehz7hvk2e65Y
 KkT0Vvd4vDPLoq0dVf6BLiuHjGefNNs5f3V6irOMsyGnC3xWXG6a/Ty8W8I1oDWZ+O8t0wkgeOf
 MqSNlvOsWkvzlcdXU1xfny0lMFfpW6Ge0RORHHJuFEcpO2nAsvV2usgP4TBZR4i4wXZbsvHDdz+
 RWbfW4ceVT68osehnRGKWQE9x/0qem+gPPXgSbKMqsC6apUJ1fNeViBkAuujfTBnr+uZsqBWrZ1
 7M1tO6aZlocGM+Kf6fQqxDW5PVRP5DA/pELxCyVzJfS8VApq4zAak1qB7kxeYLssqSKL/6Eto29
 FW0H4vDW0i5fa3a2tau+/ztWYPKo6qNObyx3EV8H1VWIeZWGV5jXDRVcAQ7CSGYglEXZLPzJgmL
 CruVNd98ihNKooThFyCo0Cl2x7sHF5kop+IvXnqI=
X-Authority-Analysis: v=2.4 cv=A9hh/qWG c=1 sm=1 tr=0 ts=6959720a b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yPCof4ZbAAAA:8 a=o-Nrg2mjxIC6mMfGm-YA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 cc=ntf awl=host:13654
X-Proofpoint-GUID: jFn7GscN_dJOONKrhsNknzz_zLcQTZqc


On 12/26/25 4:26 PM, NeilBrown wrote:
> On Sat, 27 Dec 2025, Dai Ngo wrote:
>> Update the NFS server to handle SCSI persistent registration fencing on
>> a per-client and per-device basis by utilizing an xarray associated with
>> the nfs4_client structure.
>>
>> Each xarray entry is indexed by the dev_t of a block device registered
>> by the client. The entry maintains a flag indicating whether this device
>> has already been fenced for the corresponding client.
>>
>> When the server issues a persistent registration key to a client, it
>> creates a new xarray entry at the dev_t index with the fenced flag
>> initialized to 0.
>>
>> Before performing a fence via nfsd4_scsi_fence_client, the server
>> checks the corresponding entry using the device's dev_t. If the fenced
>> flag is already set, the fence operation is skipped; otherwise, the
>> flag is set to 1 and fencing proceeds.
>>
>> The xarray is destroyed when the nfs4_client is released in
>> __destroy_client.
>>
>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>> ---
>>   fs/nfsd/blocklayout.c | 33 +++++++++++++++++++++++++++++++++
>>   fs/nfsd/nfs4state.c   |  6 ++++++
>>   fs/nfsd/state.h       |  2 ++
>>   3 files changed, 41 insertions(+)
>>
>> V2:
>>     . Replace xa_store with xas_set_mark and xas_get_mark to avoid
>>       memory allocation in nfsd4_scsi_fence_client.
>>     . Remove cl_fence_lock, use xa_lock instead.
>> V3:
>>     . handle xa_store error.
>>     . add xa_lock and xa_unlock when calling xas_clear_mark
>> V4:
>>     . rename cl_fenced_devs to cl_dev_fences
>>     . add comment in nfsd4_block_get_device_info_scsi
>>
>> diff --git a/fs/nfsd/blocklayout.c b/fs/nfsd/blocklayout.c
>> index afa16d7a8013..e4c63e07686c 100644
>> --- a/fs/nfsd/blocklayout.c
>> +++ b/fs/nfsd/blocklayout.c
>> @@ -318,6 +318,7 @@ nfsd4_block_get_device_info_scsi(struct super_block *sb,
>>   	struct pnfs_block_volume *b;
>>   	const struct pr_ops *ops;
>>   	int ret;
>> +	void *entry;
>>   
>>   	dev = kzalloc(struct_size(dev, volumes, 1), GFP_KERNEL);
>>   	if (!dev)
>> @@ -357,6 +358,20 @@ nfsd4_block_get_device_info_scsi(struct super_block *sb,
>>   		goto out_free_dev;
>>   	}
>>   
>> +	/*
>> +	 * Create an entry for this client with the fenced flag set to 0.
>> +	 *
>> +	 * The atomicity of xa_store ensures that only a single entry
>> +	 * is created for each device. The maximun number of entries
>> +	 * in this array is determined by the number of pNFS exports
>> +	 * accessed by this client that use the SCSI layout type.
>> +	 */
>> +	entry = xa_store(&clp->cl_dev_fences, (unsigned long)sb->s_bdev->bd_dev,
>> +				xa_mk_value(0), GFP_KERNEL);
>> +	if (xa_is_err(entry)) {
>> +		ret = xa_err(entry);
>> +		goto out_free_dev;
>> +	}
>>   	return 0;
>>   
>>   out_free_dev:
>> @@ -400,10 +415,28 @@ nfsd4_scsi_fence_client(struct nfs4_layout_stateid *ls, struct nfsd_file *file)
>>   	struct nfs4_client *clp = ls->ls_stid.sc_client;
>>   	struct block_device *bdev = file->nf_file->f_path.mnt->mnt_sb->s_bdev;
>>   	int status;
>> +	void *entry;
>> +	XA_STATE(xas, &clp->cl_dev_fences, bdev->bd_dev);
>> +
>> +	xa_lock(&clp->cl_dev_fences);
>> +	entry = xas_load(&xas);
>> +	if (entry && xas_get_mark(&xas, XA_MARK_0)) {
>> +		/* device already fenced */
> If two threads race, we could reach this point before any thread has
> called ->pr_preempt().  So I think the comment is strictly speaking
> wrong.
> It isn't the case that "device [is] already fenced" but that "we have
> already committed to fencing the device".

Yes, that is correct - it's either the device has been fenced or it's
in the processed of being fenced.

>
> Is that an important difference?  I don't know as I don't know the
> purpose of fencing here.

Fencing is a mechanism used to prevent data corruption and ensure
consistency in a shared storage environment. It occurs when a server
is unable to recall a layout from a client—typically due to a layout
conflict arising from another client gaining access or control over
the same device. In such situations, fencing disables or restricts
the first client's access to the device, ensuring that only one client
interacts with the device at a time. This helps maintain data integrity
and prevents simultaneous conflicting operations.

>
> Does the second thread need to wait for the fence to complete, or should
> the comment acknowledge that might not have completed yet?

No waiting is necessary, as long as the fence operation will be
done then that is all it's needed.

Thanks,
-Dai

>
> Thanks,
> NeilBrown
>
>
>
>> +		xa_unlock(&clp->cl_dev_fences);
>> +		return;
>> +	}
>> +	/* Set the fenced flag for this device. */
>> +	xas_set_mark(&xas, XA_MARK_0);
>> +	xa_unlock(&clp->cl_dev_fences);
>>   
>>   	status = bdev->bd_disk->fops->pr_ops->pr_preempt(bdev, NFSD_MDS_PR_KEY,
>>   			nfsd4_scsi_pr_key(clp),
>>   			PR_EXCLUSIVE_ACCESS_REG_ONLY, true);
>> +	if (status) {
>> +		xa_lock(&clp->cl_dev_fences);
>> +		xas_clear_mark(&xas, XA_MARK_0);
>> +		xa_unlock(&clp->cl_dev_fences);
>> +	}
>>   	trace_nfsd_pnfs_fence(clp, bdev->bd_disk->disk_name, status);
>>   }
>>   
>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>> index 808c24fb5c9a..12537e0a783f 100644
>> --- a/fs/nfsd/nfs4state.c
>> +++ b/fs/nfsd/nfs4state.c
>> @@ -2381,6 +2381,9 @@ static struct nfs4_client *alloc_client(struct xdr_netobj name,
>>   	INIT_LIST_HEAD(&clp->cl_revoked);
>>   #ifdef CONFIG_NFSD_PNFS
>>   	INIT_LIST_HEAD(&clp->cl_lo_states);
>> +#ifdef CONFIG_NFSD_SCSILAYOUT
>> +	xa_init(&clp->cl_dev_fences);
>> +#endif
>>   #endif
>>   	INIT_LIST_HEAD(&clp->async_copies);
>>   	spin_lock_init(&clp->async_lock);
>> @@ -2537,6 +2540,9 @@ __destroy_client(struct nfs4_client *clp)
>>   		svc_xprt_put(clp->cl_cb_conn.cb_xprt);
>>   	atomic_add_unless(&nn->nfs4_client_count, -1, 0);
>>   	nfsd4_dec_courtesy_client_count(nn, clp);
>> +#ifdef CONFIG_NFSD_SCSILAYOUT
>> +	xa_destroy(&clp->cl_dev_fences);
>> +#endif
>>   	free_client(clp);
>>   	wake_up_all(&expiry_wq);
>>   }
>> diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
>> index b052c1effdc5..eead2b420201 100644
>> --- a/fs/nfsd/state.h
>> +++ b/fs/nfsd/state.h
>> @@ -527,6 +527,8 @@ struct nfs4_client {
>>   
>>   	struct nfsd4_cb_recall_any	*cl_ra;
>>   	time64_t		cl_ra_time;
>> +
>> +	struct xarray		cl_dev_fences;
>>   };
>>   
>>   /* struct nfs4_client_reset
>> -- 
>> 2.47.3
>>
>>

