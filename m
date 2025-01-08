Return-Path: <linux-nfs+bounces-8971-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 26B52A05FA5
	for <lists+linux-nfs@lfdr.de>; Wed,  8 Jan 2025 16:09:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0C9C1881A50
	for <lists+linux-nfs@lfdr.de>; Wed,  8 Jan 2025 15:09:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92168B644;
	Wed,  8 Jan 2025 15:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZdJ8LdVV";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="NEL44Tdi"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DE111FA8C1
	for <linux-nfs@vger.kernel.org>; Wed,  8 Jan 2025 15:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736348939; cv=fail; b=dTyjtKO+um12l1JiW8xNjhCqzWNIXhq9pqFDb8keja79BvqNWLWm6v/G0lWTelrGbE1yXHtuPCLubK3epq6sxg6aHfEUYdq+khnyNhHA9jUV47Ty8wSWBfrssIjBjx+3XT+y4enzY3vhrCa4/bsUjChshktUpjAH8Co4FyqbXJA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736348939; c=relaxed/simple;
	bh=ipjn38zYuhMJrbD/VI8gD7IP7cgd3wT0T3MclxZ+c58=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=D8Akg3xcc9VHFQBO81hhEErYDCdVMWK+eud8EfA0iN1OoLbwGzBqGPMKehc7tUtWUHO+NEg8ziZbeC7ZesA5Q3VBTqu7BMQDcPDybeduoaixHS/uV349gcGYd8foKaWGSmQPMWAwrxicnrnVdwsQaLUm1wvszGiR95PLa/LLcQg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ZdJ8LdVV; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=NEL44Tdi; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 508EMj4X021990;
	Wed, 8 Jan 2025 15:08:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=3q//Sr5VCgx0QmxYtDdINkypNh/NPrq7fnsy/uX8MBw=; b=
	ZdJ8LdVVWWNe2cUi2xuxfi3duK+7vGnHqa7M8b+Q/c4PwZUfWRvrkFZWUT/cBUhY
	1Z4c+dDGnYK6qh5/GCMhxxM1TNLkIfbZx97M8659Dn4A1Hk71RcIGRtRwLR5i2OI
	UZMHQaiRfMfnEiqpDpTz++lI6ZTbaed1bleoKE4ao4RnbO+n0G6l59Ph/IHMF2NS
	oguYHr/K7ImIHZKBRJil1kJgRQs9DHfCO0pP2xIq9eQoOiWKx7mRi20UFj0xTm2b
	8jfnwtVPYqlt33lzdWx4YQywcadTGghoSZOrYMVQtE7whkTo880rMTbtPeMMds+l
	FN/R2ftfTIou0Qfum25jJw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43xwhspsy8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 08 Jan 2025 15:08:23 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 508EmpO5019814;
	Wed, 8 Jan 2025 15:08:21 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2049.outbound.protection.outlook.com [104.47.66.49])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 43xueg6xt7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 08 Jan 2025 15:08:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DasoIYLcRlZDLqgDqQA9zha9NJYid5x3TM2xHl5vW+Opf57KBIImektpKSb3i/++SupUqOeWH9QhxfD8wLN5UQHdCNhuh4LTcg7WK7OyraSoHxUkBnndQMwxWx3T47AwfIjh4bFVY1uDGWWQcs1mNTwivEwXsVRNgUkyI8XD3FAbrAVBY3RCKlD6N0APztHT0XZPHjWyAzpDlJp5AGj4R2/lYBEfHuz77D+/eAlIB/AALfGeEN7uDfIZoT26MmGEQ4gIfXfFcXAFycvqCSlArBZMufp5zvFLUzJKMQ17jN295gr/P/dSGJSY8S/uUwkLvpSBtsSYBxHt+oGYAaPmEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3q//Sr5VCgx0QmxYtDdINkypNh/NPrq7fnsy/uX8MBw=;
 b=aVbPjHMo6563PsOQZ+a5c+excUqxLJTstOAW3iCwjl7ySHZnqKj9FTsGZ/e4dHYbh/pZGd4s8yMXyRFctWxj1GZoaeCTYr7kXxzVx9pFx+6IEtuMhYZ1qEnD3M3JPkaClf0VsCbUbEDgSC+U3VFFF2rgkqGBJohByJy8RZWxunHsHHuHXKiRKGmu7sPag9z3q5af2QhFE4YQUn/WIdwgiVyEedHfHWv6f4Vy1SyMHTjCsM5ehZXVirOy3DCph+2PmIZ4PkVWP/QEya82AoV/mqrw79k8BlRwHWvMiF6uPXGAb1/rfmr2+pr+ArjdLSoeZFrm6GO9MRzDzz4Y7HuP/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3q//Sr5VCgx0QmxYtDdINkypNh/NPrq7fnsy/uX8MBw=;
 b=NEL44TdiBnjxF9MCQWu1IKnDMYcIFZuO9Uu9F8gppxCOvRK3Hv+NG3UPeIx4Diewd60uqFnLq+8b5K7Pth003/HiGbSw03fb9k/L7SFB5jYvWeRF7qEA/B4oXkiL7SZKg3tJ7IR5AYZwO6Fu2ducabKPKiqDJf/LTPfuw2hY9Ek=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS0PR10MB6030.namprd10.prod.outlook.com (2603:10b6:8:ce::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8335.11; Wed, 8 Jan 2025 15:07:51 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%3]) with mapi id 15.20.8335.010; Wed, 8 Jan 2025
 15:07:51 +0000
Message-ID: <7fb711b1-c557-48de-bf91-d522bdbcc575@oracle.com>
Date: Wed, 8 Jan 2025 10:07:49 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: nfsd blocks indefinitely in nfsd4_destroy_session
To: Christian Herzog <herzog@phys.ethz.ch>
Cc: Salvatore Bonaccorso <carnil@debian.org>,
        Benjamin Coddington <bcodding@redhat.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Harald Dunkel <harald.dunkel@aixigo.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Martin Svec <martin.svec@zoner.cz>,
        Michael Gernoth <debian@zerfleddert.de>,
        Pellegrin Baptiste <Baptiste.Pellegrin@ac-grenoble.fr>
References: <4c3080af-eec7-4af5-8b0d-c35ac98ec074@aixigo.com>
 <C1CE3A96-599C-4D73-BCC0-3587EC68FCB0@oracle.com>
 <Z2vNQ6HXfG_LqBQc@eldamar.lan>
 <ecdae86c-2954-4aca-bf1c-f95408ad0ad4@oracle.com>
 <Z32ZzQiKfEeVoyfU@eldamar.lan>
 <3cdcf2ee-46b3-463d-bc14-0f44062c0bd0@oracle.com>
 <Z36RshcsxU1xFj_X@phys.ethz.ch>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <Z36RshcsxU1xFj_X@phys.ethz.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR07CA0043.namprd07.prod.outlook.com
 (2603:10b6:610:5b::17) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|DS0PR10MB6030:EE_
X-MS-Office365-Filtering-Correlation-Id: bcdb47a9-c2ad-45bc-6cea-08dd2ff63880
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bVNKZGhIeHJ3YjFpWWFNWlRna0xpVjVoQzhCeDdBc2lCeFZqVnJiclBDU2tE?=
 =?utf-8?B?MTRndkpkRTNLZkNxUFRweTNPcEJ1UDlrRm5KK3hMUlBqMUFXcUFlalFOenpp?=
 =?utf-8?B?dWI1ek9jZVc3RUFqaTFZckg5RjIxYlVFc1kxaVpqcUVUVHJjblFRVEc5VlZV?=
 =?utf-8?B?R0hDdURoQjEwWU9RZG1OQVN5NHRXZzdabUdqaUZoRXdOQjRTdXA0b2VMS0tC?=
 =?utf-8?B?SWEzbVJreTZ0eDFTNFRyM0wrd041N2hBbUI3UzBSdURkeTd2MEtQY0loMHUx?=
 =?utf-8?B?cUxRcGRnWmVWSHUzenJTeDB3ZnB5cmliWUF1MXRMVk8xc3Q2am9xMUdNTllq?=
 =?utf-8?B?Z1hOSVlHUTJnUVZMUTBPZ3dITmZ6bHZIWlc4U0VsNmVHTkR4SURxdGlHTnFn?=
 =?utf-8?B?bEgrUGUxT05BRDRCZk10VHRJMlpJWFZucCtPbkF3S1Y3TDNNR0poZkpWeWJH?=
 =?utf-8?B?WHNka1F2R1JjTzZ2YXpaTmY5aEN2cFdtMWpYQ2ZNK1RtamFOQ0JKZWh2ZCtK?=
 =?utf-8?B?cmRqYjFhcjFTZnZ1L0dTUzBobms5Ynhyc0tKK1gwbFRBVWdRZjBreExBbnBp?=
 =?utf-8?B?cWhzc01DaFM3TjBCeEVnRE51NmxhbVY2YVM3aW5XUkFqTUUreGtycHFic0Ir?=
 =?utf-8?B?a2ZQeHZlakhDOHhHUHByRE91RndJTy9LZVpGU0VxV0RTSEJvWUJaZDRZYlpJ?=
 =?utf-8?B?SWtFWXdzblFNYXEzb0h2Z0hlS0MyQXNCOU9iNWlnT0N5T3lKMUJ5ZE1jZkJE?=
 =?utf-8?B?dXhSaWtMa3g0UnVyR25wa2t6U3ozUGJhUmlEa294SFQ5VEVPWHBWcDlDNjg5?=
 =?utf-8?B?VFpLeHIyM3BrbXRIWFpobWJTZ2NQaFl5ZjF2Z2F4ekVZVFAvYlZOUnluMGow?=
 =?utf-8?B?dkFoYzVLbUFxZDBNamhRaUUxTUxheUsvQlVtRWZ5VjVrZ1NOd2p2c2d1bDYy?=
 =?utf-8?B?dHdQTGlPSTkrNlpnQ1JkUFJhNnJlTTF6ZStxbi8yQnA2eDhad3ZpeDlITDNw?=
 =?utf-8?B?NlFRRUVLSENQSlppU1dsNFFwL1N4M2ptbVpaUzlmWmZDVmJoVUk0Rzg5SXZN?=
 =?utf-8?B?QXJuR2pyUllWRVF1Q29UcDh4VjQ4MThtUFF6bXROKzZidXlZY3B5OWZsa2Fq?=
 =?utf-8?B?bHMxUzlHK1hVV24xbEhCamlqUEpkbkJYZHY2bnY5WnQrTWhNMnI0ME85ODYz?=
 =?utf-8?B?dFRVRjBlU0wxQi9vNVhocmFvdnhxQXVUZ0VqMU9POUpUT1U0bDBkNkRaUnNJ?=
 =?utf-8?B?Znd4MGt1UlJnYVgxcGNZSFF5WElJMjloeU14QXFDOVl3UlNWZXJVQlBvdzdY?=
 =?utf-8?B?bG9TV09wck5OaXNnUHh1ZUVkZGNRSE5RaVFadDhWdjFjTUg4NU5ZYXNVbTU1?=
 =?utf-8?B?MHk2cEdLd0hpWmlWbXVDMHFKbkNBQit4Y25tV3VIbXdtT3NxdmVSZG9PTVN3?=
 =?utf-8?B?MWdXdSt1MUFHMmg5RmZjNlptR0R4b0hqUnBoV3ZuamFzSGlFTVhoODBKR29i?=
 =?utf-8?B?ZHJuTk9sQmc0bzVESkxGZWlXcWpNSUhCNWh0NjZDNmorZUtJY1E3NUNHQ3hl?=
 =?utf-8?B?cTFXckdEWU5heUhsTEErUkNyM2VzcFlZZnpYTFRmZk5POE1WTEtJTjJET05u?=
 =?utf-8?B?WTM2N2RETWJiZ29RbER1MFd6dWFtM2FhU1JhcGFQZEhLbFFCYmZrWFUycmhY?=
 =?utf-8?B?MXhUZTRvcnJSQmpIT1J1RXhCUVZLRWt4MVpWQlphZ1NJMDU4L2dWdzBqb2Vs?=
 =?utf-8?B?dzJXVFVQanVZbXdwc0NTN1V1YUhBYU84Z3JFUTBab0dLR1JaYysxZ1pIbTU5?=
 =?utf-8?B?Mll4VG9neVloVDhSaXBQQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T0h5SnB1b1oyRFBxclVONTI4SHIzelhIcUs3WTk1T1JZVUhBYmFHdWZVYWxU?=
 =?utf-8?B?U05FYTZSUk1YQnRCazloVHZFQzRaWk1Va2NsU0FkZUhQNzNhL0Q5Nk50Y3c4?=
 =?utf-8?B?ZzlmaUZMOE9YdVV5RUM0aDdFdTluNmRTV0NXbWpwdCtlU09lY0FsSDdSb3o4?=
 =?utf-8?B?dXdsczRuYTBkS1hUU3VpdHVMMUtrcUhqQ1JncWF2d2VDRmVBcnpkdXphQmh4?=
 =?utf-8?B?QlpBYlJ6SjNFcEQ3TzJ5VmtxK3l5dGtjeWhiNkcyV2xzbUs3emhzTnlrSm5F?=
 =?utf-8?B?cStuVDJyVXVMRFlXeWIxSVdJbjZHeEI4Tkt5NmFQdG5uaXp4eUpGejdTZlMx?=
 =?utf-8?B?elEvbHJzR0J0bTNwZzh5ZDlacDBweVRuT0xEUlY0dGp3aWZkbDZqSzU2ZStj?=
 =?utf-8?B?TTNMc0RIQVliNW9YVWgzcmVhZllnUmZEaHNITDlLenlWTTVkbGszelEyZVY2?=
 =?utf-8?B?bmV0T2xUd2dTa1E4TFZ5bXBJVFN1eExhU3d1Sk95WVJkZVNpQW4xR0NybHE0?=
 =?utf-8?B?UmtTZDRZN1ZncDNaelF2dHU0RUwxUnZGZ1l3VjJlZ0JnNGlrWVpNVFFLb08w?=
 =?utf-8?B?WldrWE5UNndXSVdYakhYSGFZRUpMWjRjZDlPdVQyWGpWZmd0ZEs1QmY0dWUy?=
 =?utf-8?B?OTJ3Y3RmTGxYRTk3NzVudmJjenROc3JkSlFWOGZXYXUyRVF1QWIvMDZzOHhk?=
 =?utf-8?B?ekZVRkROOUNTQlovRkRvTzdDemE1bUpJeG5WU3l3SDdiTjFNcDRObTlCMlV1?=
 =?utf-8?B?c2xMUU1FMkZRTFBsOEk5VFV0OE9QaDQ3cmJ4cys2dFAxM3pqOWlWWXpuZGI5?=
 =?utf-8?B?VVdBOThXQmZwV1J1V1hsQUc2WXY2UFQ5cnI5dUV0bm94UzU4eEhjRUNRZ2I2?=
 =?utf-8?B?Z1dvVk03ZC8xcTZMVFhkWUhtYkh5N2s0Nk5uVnV6S1k1bE1FN0JyUlQ0bnZR?=
 =?utf-8?B?RDUySjY1cU9obGJnZzFLTit2eGhmK1pRS1lFRVB1R1R0cG5EWlQ1cndmeEsw?=
 =?utf-8?B?eVhyWlJlc0h4T1JEWTdHUFZlZm9zYTVSNzlHNnk3Zk5JblFaZkR0UE9Vc1FW?=
 =?utf-8?B?N1JrS1ZoUGx1OExBOW1EMFZYa3Q5eUZUVmcvRWl5M1JOdE92cXZ0KzFCSjRl?=
 =?utf-8?B?VWw2amovZEx3TEV4cmg4TU1laHBmbnlRamlpRDNiMmd3T25LNnNtMTUxdHRG?=
 =?utf-8?B?MUJlTXo3bGdwcW83ZlhBaHRMb2J4MmNreGRJZzZZSFVuOHgzK1czVFRWZzlv?=
 =?utf-8?B?czZ2VjYvY3Z5aDduTXRaZldMUEFhUUJXZjNDOVpCV2dtRElQQjhGYnhIcWQy?=
 =?utf-8?B?SzM0MmFsanVqbnUzUHVPR2dsNDh3UXBGQVl5ejUyMy9neUlUdkJBekRIaGxU?=
 =?utf-8?B?RTRsa1ZObUdMbXdUS2ZzamNOOXdhUTMrZll5N0FiQ3lqMlFBNDZpa2VnZUdH?=
 =?utf-8?B?Z0VUUnREWWpGWmF4QjFMTEh0cjFhWXhFZy9hNzRULysvKzhQZkdaQkYxTmx1?=
 =?utf-8?B?V0svaGlTL2d6TmFITVhkQXdNY1p6VGZkckVId1kzeTVYb1QvaG9DN2ZxY3Rz?=
 =?utf-8?B?T0tBR2haS1hmZDhrK2RZYkpSQUUwTUJrZUhBWm5JUm9OK2RUNUhoNHdqNW1t?=
 =?utf-8?B?RGt2cG1uZEtpUEJORGhOWS9MUlJUdVpvSUN4UWN6MDhlai83QXBqaWN6MVZx?=
 =?utf-8?B?SjFsMlcya2JONi9mblYxTVJlZWM5YTBsZDU5emVXcmV5QmZXTTVmWStySTRk?=
 =?utf-8?B?NjdCYWVTVDFMQW94QTFqeFVCTWJSV3FTbzhkL3lPeGlxV0krQ2xTbWFSS0dN?=
 =?utf-8?B?WjB0dXVDRkRoQnlKYUFoN3AzcEk2d1N3YTYyelpwU0pSQkJlTmdrazBlaTJ4?=
 =?utf-8?B?ZzVUcnlvU05OQndsNUpxZUtUN0dQV29LTzlOK1QwWE5aakpvUXBXUE5OUU5n?=
 =?utf-8?B?N0RpelZWY1o4dGJiMnVqaHVKazJ1STJpSC9QS2UwSkw5WkhjL2dRclB0TzNw?=
 =?utf-8?B?bXZQajBNNnM1bkdsUWVYSmFicVVYT0JWREZzVlh1b0hmZkpHU004UWxyYWtQ?=
 =?utf-8?B?cm45c2N5dWlOWUFYeGlzeGRrVXhGczdjem4zaUhVRzlZb0J1ZmZoZTluRXBJ?=
 =?utf-8?B?M3d1Ti9wdkxlZUI4cDB2aUlONVhING1iRkZBV0QvNWdyMmJmK0xJSEhUbXh1?=
 =?utf-8?B?bFE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	a5JSS3749aZiW1a5+pJjr2KXfJkvt5Tu/lVvQk9zrAQZ6kM3v++1/0CC0fTMOyrMoF5gbr/EiznfUzMjPCMROh5jZ1YfD/+zxsWfb0MeemAZjUwOt+cYcxfqkumdMRucgiEapRY2qrt03hY0qXK0hRt/SmrAH2CbY2Y6X7mxsBW4FNiMc2JMlNa444+soOt5dhl6XIW6lU7XszGuieJCW/uuY3+G21iMwl42YakXzd0yW4BBUFXm6oQIXQIDaw8MfkXrbo5Y2zTPIMrmcl7CCVsdLo1Q4usMd+KppSUYfHAZrLZTwfSTep+PeR7YKOj7gVteaoS9XOBTVGFfm9wFGKl0e8Irb/prYQqoCAu/4+SYW4IqQwv+q69WN3zKwRujScorBu1wM1kHEUPExrAXxwQueIxPeKKco8roXYRZ/TAGWo2o90To6UNwF1VJCWUjg9HGopY2PkqW14jLmRyVL00CGRH9IiC8bG3LJUC8jDkkp7agYbf4iyISXGH9IHV9QawOJqZMsaDy8ebyoR1FlEUmwSULOE+quD4wOyGyVC1P0MKWDJpSg+Lq6pySGbXilZAxC0P8ygaMKEnGS89CWHwgtA4WyRgCvjJQAlIY5QY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bcdb47a9-c2ad-45bc-6cea-08dd2ff63880
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2025 15:07:51.4020
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D3tvHZlufGk7g5Z2TB5rNc4vZ4QhGZu+HuhtdhzIUlZwiqxu7jb0a4bdfqkpN6HtLjb0uyQQYTEHwfIcWQMA/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6030
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-08_04,2025-01-08_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 phishscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501080126
X-Proofpoint-GUID: pfShwzXPWT6X1wSkX3xOH_9J8WfDe02B
X-Proofpoint-ORIG-GUID: pfShwzXPWT6X1wSkX3xOH_9J8WfDe02B

On 1/8/25 9:54 AM, Christian Herzog wrote:
> Dear Chuck,
> 
> On Wed, Jan 08, 2025 at 08:33:23AM -0500, Chuck Lever wrote:
>> On 1/7/25 4:17 PM, Salvatore Bonaccorso wrote:
>>> Hi Chuck,
>>>
>>> Thanks for your time on this, much appreciated.
>>>
>>> On Wed, Jan 01, 2025 at 02:24:50PM -0500, Chuck Lever wrote:
>>>> On 12/25/24 4:15 AM, Salvatore Bonaccorso wrote:
>>>>> Hi Chuck, hi all,
>>>>>
>>>>> [it was not ideal to pick one of the message for this followup, let me
>>>>> know if you want a complete new thread, adding as well Benjamin and
>>>>> Trond as they are involved in one mentioned patch]
>>>>>
>>>>> On Mon, Jun 17, 2024 at 02:31:54PM +0000, Chuck Lever III wrote:
>>>>>>
>>>>>>
>>>>>>> On Jun 17, 2024, at 2:55 AM, Harald Dunkel <harald.dunkel@aixigo.com> wrote:
>>>>>>>
>>>>>>> Hi folks,
>>>>>>>
>>>>>>> what would be the reason for nfsd getting stuck somehow and becoming
>>>>>>> an unkillable process? See
>>>>>>>
>>>>>>> - https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1071562
>>>>>>> - https://bugs.launchpad.net/ubuntu/+source/nfs-utils/+bug/2062568
>>>>>>>
>>>>>>> Doesn't this mean that something inside the kernel gets stuck as
>>>>>>> well? Seems odd to me.
>>>>>>
>>>>>> I'm not familiar with the Debian or Ubuntu kernel packages. Can
>>>>>> the kernel release numbers be translated to LTS kernel releases
>>>>>> please? Need both "last known working" and "first broken" releases.
>>>>>>
>>>>>> This:
>>>>>>
>>>>>> [ 6596.911785] RPC: Could not send backchannel reply error: -110
>>>>>> [ 6596.972490] RPC: Could not send backchannel reply error: -110
>>>>>> [ 6837.281307] RPC: Could not send backchannel reply error: -110
>>>>>>
>>>>>> is a known set of client backchannel bugs. Knowing the LTS kernel
>>>>>> releases (see above) will help us figure out what needs to be
>>>>>> backported to the LTS kernels kernels in question.
>>>>>>
>>>>>> This:
>>>>>>
>>>>>> [11183.290619] wait_for_completion+0x88/0x150
>>>>>> [11183.290623] __flush_workqueue+0x140/0x3e0
>>>>>> [11183.290629] nfsd4_probe_callback_sync+0x1a/0x30 [nfsd]
>>>>>> [11183.290689] nfsd4_destroy_session+0x186/0x260 [nfsd]
>>>>>>
>>>>>> is probably related to the backchannel errors on the client, but
>>>>>> client bugs shouldn't cause the server to hang like this. We
>>>>>> might be able to say more if you can provide the kernel release
>>>>>> translations (see above).
>>>>>
>>>>> In Debian we hstill have the bug #1071562 open and one person notified
>>>>> mye offlist that it appears that the issue get more frequent since
>>>>> they updated on NFS client side from Ubuntu 20.04 to Debian bookworm
>>>>> with a 6.1.y based kernel).
>>>>>
>>>>> Some people around those issues, seem to claim that the change
>>>>> mentioned in
>>>>> https://lists.proxmox.com/pipermail/pve-devel/2024-July/064614.html
>>>>> would fix the issue, which is as well backchannel related.
>>>>>
>>>>> This is upstream: 6ddc9deacc13 ("SUNRPC: Fix backchannel reply,
>>>>> again"). While this commit fixes 57331a59ac0d ("NFSv4.1: Use the
>>>>> nfs_client's rpc timeouts for backchannel") this is not something
>>>>> which goes back to 6.1.y, could it be possible that hte backchannel
>>>>> refactoring and this final fix indeeds fixes the issue?
>>>>>
>>>>> As people report it is not easily reproducible, so this makes it
>>>>> harder to identify fixes correctly.
>>>>>
>>>>> I gave a (short) stance on trying to backport commits up to
>>>>> 6ddc9deacc13 ("SUNRPC: Fix backchannel reply, again") but this quickly
>>>>> seems to indicate it is probably still not the right thing for
>>>>> backporting to the older stable series.
>>>>>
>>>>> As at least pre-requisites:
>>>>>
>>>>> 2009e32997ed568a305cf9bc7bf27d22e0f6ccda
>>>>> 4119bd0306652776cb0b7caa3aea5b2a93aecb89
>>>>> 163cdfca341b76c958567ae0966bd3575c5c6192
>>>>> f4afc8fead386c81fda2593ad6162271d26667f8
>>>>> 6ed8cdf967f7e9fc96cd1c129719ef99db2f9afc
>>>>> 57331a59ac0d680f606403eb24edd3c35aecba31
>>>>>
>>>>> and still there would be conflicting codepaths (and does not seem
>>>>> right).
>>>>>
>>>>> Chuck, Benjamin, Trond, is there anything we can provive on reporters
>>>>> side that we can try to tackle this issue better?
>>>>
>>>> As I've indicated before, NFSD should not block no matter what the
>>>> client may or may not be doing. I'd like to focus on the server first.
>>>>
>>>> What is the result of:
>>>>
>>>> $ cd <Bookworm's v6.1.90 kernel source >
>>>> $ unset KBUILD_OUTPUT
>>>> $ make -j `nproc`
>>>> $ scripts/faddr2line \
>>>> 	fs/nfsd/nfs4state.o \
>>>> 	nfsd4_destroy_session+0x16d
>>>>
>>>> Since this issue appeared after v6.1.1, is it possible to bisect
>>>> between v6.1.1 and v6.1.90 ?
>>>
>>> First please note, at least speaking of triggering the issue in
>>> Debian, Debian has moved to 6.1.119 based kernel already (and soon in
>>> the weekends point release move to 6.1.123).
>>>
>>> That said, one of the users which regularly seems to be hit by the
>>> issue was able to provide the above requested information, based for
>>> 6.1.119:
>>>
>>> ~/kernel/linux-source-6.1# make kernelversion
>>> 6.1.119
>>> ~/kernel/linux-source-6.1# scripts/faddr2line fs/nfsd/nfs4state.o nfsd4_destroy_session+0x16d
>>> nfsd4_destroy_session+0x16d/0x250:
>>> __list_del_entry at /root/kernel/linux-source-6.1/./include/linux/list.h:134
>>> (inlined by) list_del at /root/kernel/linux-source-6.1/./include/linux/list.h:148
>>> (inlined by) unhash_session at /root/kernel/linux-source-6.1/fs/nfsd/nfs4state.c:2062
>>> (inlined by) nfsd4_destroy_session at /root/kernel/linux-source-6.1/fs/nfsd/nfs4state.c:3856
>>>
>>> They could provide as well a decode_stacktrace output for the recent
>>> hit (if that is helpful for you):
>>>
>>> [Mon Jan 6 13:25:28 2025] INFO: task nfsd:55306 blocked for more than 6883 seconds.
>>> [Mon Jan 6 13:25:28 2025]       Not tainted 6.1.0-28-amd64 #1 Debian 6.1.119-1
>>> [Mon Jan 6 13:25:28 2025] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
>>> [Mon Jan 6 13:25:28 2025] task:nfsd            state:D stack:0     pid:55306 ppid:2      flags:0x00004000
>>> [Mon Jan 6 13:25:28 2025] Call Trace:
>>> [Mon Jan 6 13:25:28 2025]  <TASK>
>>> [Mon Jan 6 13:25:28 2025] __schedule+0x34d/0x9e0
>>> [Mon Jan 6 13:25:28 2025] schedule+0x5a/0xd0
>>> [Mon Jan 6 13:25:28 2025] schedule_timeout+0x118/0x150
>>> [Mon Jan 6 13:25:28 2025] wait_for_completion+0x86/0x160
>>> [Mon Jan 6 13:25:28 2025] __flush_workqueue+0x152/0x420
>>> [Mon Jan 6 13:25:28 2025] nfsd4_destroy_session (debian/build/build_amd64_none_amd64/include/linux/spinlock.h:351 debian/build/build_amd64_none_amd64/fs/nfsd/nfs4state.c:3861) nfsd
>>> [Mon Jan 6 13:25:28 2025] nfsd4_proc_compound (debian/build/build_amd64_none_amd64/fs/nfsd/nfs4proc.c:2680) nfsd
>>> [Mon Jan 6 13:25:28 2025] nfsd_dispatch (debian/build/build_amd64_none_amd64/fs/nfsd/nfssvc.c:1022) nfsd
>>> [Mon Jan 6 13:25:28 2025] svc_process_common (debian/build/build_amd64_none_amd64/net/sunrpc/svc.c:1344) sunrpc
>>> [Mon Jan 6 13:25:28 2025] ? svc_recv (debian/build/build_amd64_none_amd64/net/sunrpc/svc_xprt.c:897) sunrpc
>>> [Mon Jan 6 13:25:28 2025] ? nfsd_svc (debian/build/build_amd64_none_amd64/fs/nfsd/nfssvc.c:983) nfsd
>>> [Mon Jan 6 13:25:28 2025] ? nfsd_inet6addr_event (debian/build/build_amd64_none_amd64/fs/nfsd/nfssvc.c:922) nfsd
>>> [Mon Jan 6 13:25:28 2025] svc_process (debian/build/build_amd64_none_amd64/net/sunrpc/svc.c:1474) sunrpc
>>> [Mon Jan 6 13:25:28 2025] nfsd (debian/build/build_amd64_none_amd64/fs/nfsd/nfssvc.c:960) nfsd
>>> [Mon Jan 6 13:25:28 2025] kthread+0xd7/0x100
>>> [Mon Jan 6 13:25:28 2025] ? kthread_complete_and_exit+0x20/0x20
>>> [Mon Jan 6 13:25:28 2025] ret_from_fork+0x1f/0x30
>>> [Mon Jan  6 13:25:28 2025]  </TASK>
>>>
>>> The question about bisection is actually harder, those are production
>>> systems and I understand it's not possible to do bisect there, while
>>> unfortunately not reprodcing the issue on "lab conditions".
>>>
>>> Does the above give us still a clue on what you were looking for?
>>
>> Thanks for the update.
>>
>> It's possible that 38f080f3cd19 ("NFSD: Move callback_wq into struct
>> nfs4_client"), while not a specific fix for this issue, might offer some
>> relief by preventing the DESTROY_SESSION hang from affecting all other
>> clients of the degraded server.
>>
>> Not having a reproducer or the ability to bisect puts a damper on
>> things. The next step, then, is to enable tracing on servers where this
>> issue can come up, and wait for the hang to occur. The following command
>> captures information only about callback operation, so it should not
>> generate much data or impact server performance.
>>
>>    # trace-cmd record -e nfsd:nfsd_cb\*
>>
>> Let that run until the problem occurs, then ^C, compress the resulting
>> trace.dat file, and either attach it to 1071562 or email it to me
>> privately.
> thanks for the follow-up.
> 
> I am the "customer" with two affected file servers. We have since moved those
> servers to the backports kernel (6.11.10) in the hope of forward fixing the
> issue. If this kernel is stable, I'm afraid I can't go back to the 'bad'
> kernel (700+ researchers affected..), and we're also not able to trigger the
> issue on our test environment.

Hello Dr. Herzog -

If the problem recurs on 6.11, the trace-cmd I suggest above works
there as well.

If not, there are several "me too!" reports in the bug. Anyone who hits
this issue can try the trace-cmd and report back.


-- 
Chuck Lever

