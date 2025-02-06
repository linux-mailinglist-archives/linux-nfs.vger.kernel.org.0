Return-Path: <linux-nfs+bounces-9906-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E2FBA2B0A1
	for <lists+linux-nfs@lfdr.de>; Thu,  6 Feb 2025 19:22:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A255C166AA6
	for <lists+linux-nfs@lfdr.de>; Thu,  6 Feb 2025 18:22:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C766619D8A2;
	Thu,  6 Feb 2025 18:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MrXc4Kqp";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="juSckean"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5BD0165F01;
	Thu,  6 Feb 2025 18:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738865864; cv=fail; b=Hbk0IGDkOBFCwq/uHhoopxGNeuSdTj2Xn0Me6BbHJawNPD1KPlxrhe/Sozvt0yS9n+E5g5g4lbVvKfzxphkTHLZKah0ggUiCQI82IVZaW5/+Fili9AGAIvbij6QoPi7FqXvGCKT7ixAlgADhPMMq7dloP4EIWM5Q8wEt8mzA/1o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738865864; c=relaxed/simple;
	bh=bZBPAQztIHpMgj3/k8E9tC/W+Y8QMXe+8K8cgDD1UcI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=byDE1dDHrIGUf5wiOMGCiiZzWfsEM8HhZY/M8L5UGtLv2BO9r/LFSZGMtGF5lbqUc0mwFFfOa/BcTSu2dEQVQOLMCtzEMHE9SM1XfPXjh/LrWJuFp4uGS4qM60BhQJ66OM9VGOleIMJZsl1oAKWuJHY96fJtvNv7o8Iac8Zfqeo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=MrXc4Kqp; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=juSckean; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 516EFNfQ027581;
	Thu, 6 Feb 2025 18:17:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=IIcXWf7MNGFeBwEy0DKqM1jpKlcQYTayUjU7Nb5AmrU=; b=
	MrXc4KqpO2FogiXq9BL22Co/RfUhnrVjLXVrZ/r9MN8tf4ZrE/Rnz2vnTWnwGuKi
	zzauz/xa4Bmabv41aEuPb3ndj/R1sqPYALIyEItgr14+xVqMwP7u6zXIaGmCuzET
	0zHsQNXXFrCVo2h5pR3Z80nnC7cwlRNSrv3JSHz5kQWicINAOBkw4d4n69uFhJL9
	AeTboWKtFqp0gbNocDNBzv2M34raZUlnmhNhOXjgPUObqUITuyaLcITJWVX49PnZ
	uPQSEG93+65MEbVZ96ieUPjn05MTt4roBnHKL2vPNr4IUsJnOnrEYMHhGi4DOK0M
	uxzgGdGI1/zOLmPJOLPvoQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44kku4w5tu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 06 Feb 2025 18:17:29 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 516HIVtx027001;
	Thu, 6 Feb 2025 18:17:28 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2042.outbound.protection.outlook.com [104.47.56.42])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44j8fqby90-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 06 Feb 2025 18:17:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MtKIEqcEAacxMVx6WD5locXoGK5+XdyFT6XrLm/ykJjNmLC/8fwUr/u0Opd3ABt+R25bd2Xz6YGRgFDTJJyMRPYF1QcyXw7Q8ama0s8RkRRH4GTbF3Cdvqu7Z7CW/vC5gYbXarf9tpzIjPo9NrkcOdDbu10jjWhE7RoGz/pPu/v+58RhD9m49IQyvGNjX5KCSthg8so+9YyPjDEWoePB5/1glMRR0/m0MD6+WTDpmBVXiOqTwJVj6Cb4+kGKq/WEALBqzCm/C+mqE48Cw5USBTg986kOpBAohiDLjb1w5XCqJeqYwnLpcE6yPCQBdLyy+ACAFJr8HY+1/V9ktZlnXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IIcXWf7MNGFeBwEy0DKqM1jpKlcQYTayUjU7Nb5AmrU=;
 b=cEfHeSSUOXVvwVivzHNIdlWa5zMGJKv+7vJhmwRWw7RwY55W0L4vyfZNmBb7ch+uSwRCR0oAtMvCWoEhsYuEH0RpiccwCPBuoqpL7JjjUi6IuOTpImaDa15oRRWrDKbQMyF7kS6/f7d3fXnfIMSp0NkkUX0u852T+Go4ram52hOGBY68ZvW1QfxyDp9F/p6OcECgtSmKap7Q/PML2PQMe1cBB8uaFiRg0wacoGuA+xb7PKmbSxQtnCdLjumO20RfEyzdrjg5yd6xFTXmvaI67y5vd16ZI+70Nrd7Czu+uHfMYh/Dw5WNtPGgx/b2fv3lATx3VCiL3gu2U+J4jFTnvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IIcXWf7MNGFeBwEy0DKqM1jpKlcQYTayUjU7Nb5AmrU=;
 b=juSckeanfI08thOEgxFXQH0NJT9yWPOMe63SornIkfmiRQBacxySwSUM6UiI/UqG0qeefJR+M1Nw0sQStRIJYJm/mOK3euylu4cpmUwHkLrAX7s9qCCOAgDbMWXHWYsoFx7mOJIrFLLiMcQgI8SwEtdxOcmsgjAaF9LM5UHFW/o=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DM6PR10MB4188.namprd10.prod.outlook.com (2603:10b6:5:21b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.10; Thu, 6 Feb
 2025 18:17:26 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.8422.010; Thu, 6 Feb 2025
 18:17:26 +0000
Message-ID: <d6ecad5f-b2a5-435c-9209-d784a23b013c@oracle.com>
Date: Thu, 6 Feb 2025 13:17:24 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nfsd: don't ignore the return code of svc_proc_register()
To: Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>,
        Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>, Josef Bacik <josef@toxicpanda.com>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzbot+e34ad04f27991521104c@syzkaller.appspotmail.com
References: <20250206-nfsd-fixes-v1-1-c6647b92ca6f@kernel.org>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20250206-nfsd-fixes-v1-1-c6647b92ca6f@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH5P222CA0009.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:610:1ee::25) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|DM6PR10MB4188:EE_
X-MS-Office365-Filtering-Correlation-Id: 2375ee6c-1445-4254-6a7a-08dd46da8247
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NnFWbWYwaTZvcVhNay9sRGlORklTRlNmenEzMUsxNzRTL1VQY2FLY3h5TVhr?=
 =?utf-8?B?U3JZR0lpcWNVQmtkS1dpcG5RWlEwOUZTTVVKb0dGRFpmZDB5Tk9WazNma1RR?=
 =?utf-8?B?NWtlWXY3ekZ1MllURUtwOERST2xOem1qNXFsbmE3WkNqd0JXRG03RXVkQjgy?=
 =?utf-8?B?azVubFpWbHVVTmZiTDJDbHFPanY2eGtDYzV1UmVTcytVWEtvMHJ1VXRtcElQ?=
 =?utf-8?B?aVZSQ01zaUtPbnYyU3ZTWlozbVg2Rmhqa2F5dm83a3VZQi9EUWdzcEVSQllk?=
 =?utf-8?B?aXkxMlRsQ2dJTE95bjhTdXpWMUhZRFZHWGFwNVZHUzRUNVlIMVlCTTZJb29k?=
 =?utf-8?B?MFJLZTJTSFFuTlA3NWlDeUVKb0tLMHVKNTdPNS9nRERuUGlkSkFUUTRRbGE5?=
 =?utf-8?B?VUx0Y0ZoNHhJNXFXaFdTTU92bmVIakVlR0pmVWNaVzdwSHkvRU9WSWRrQ3Vx?=
 =?utf-8?B?Q2hUZHpSV2VWVExlblBzMEJUZkwrNlRPSzVCcWFNSXBqbnh3bUlxa0g1M2FY?=
 =?utf-8?B?MTJNSEppRC8vUlNpMHlUS1hRMUh2K05TZC9wOFRuR1N1SzA1cFdyQmd6Szh6?=
 =?utf-8?B?ZU4yWkpYSkp6MkhPUHAyb0dXT1ZrTlNEZzZwV2I5K2cwUUppT2FLY1NKTjho?=
 =?utf-8?B?WkZ4dUxjQ0drQithVzhuM2xIdDgyVzY4R1RheEUvejhlek82NWZqRGs4SXZI?=
 =?utf-8?B?T0pVb01VZEdGOFMxRUFPWE5CMzFRQWVrNTJmWkRRVlVaMFhZUFJsYlVXcUJs?=
 =?utf-8?B?UTVudFl6eDYxUUZoQTBVRTIxa0J3UU0wYmwrWGlIYld2NVJ3dzdhaitsejkv?=
 =?utf-8?B?U0ZQRHpmMGNxRzczNTVMUXY5ZlZ3QXVaaXdJV0xxQ3MxbXltUGxGOUNvbTdV?=
 =?utf-8?B?VkRHUmJrSTY3SUpxNDNiTU9iZklsbGdMcjNyYUpZMnJRckVqMmdNN2t0endK?=
 =?utf-8?B?SUxibWt2N3h6R2pWSFZjeGRjN2lmUHUyYitXUEZmU21CZUZNdkNsb1dNV2d1?=
 =?utf-8?B?NlJWdE5oeEhnMFozVklFUW5Sc1cyVG9qTkhSajQ0Q3RtSEZ0K21DUG1rNmZJ?=
 =?utf-8?B?bzY5WEtKL0tSM1VuMGNUKy9TNUxFaExNWGpZK2Rua0E1cCs1V1RYUnl6aWIr?=
 =?utf-8?B?eER1RkpRb1MzRklwZmcrbDJpTGt1RjVlVkx6R1hrM3loVzArbnJwbzVPUVJZ?=
 =?utf-8?B?cXp2YUorQ0lDOEZXbDliVi8yS0xBTkw4VnBURG53N1A1NzY4Yjl5eFJ2MzZY?=
 =?utf-8?B?Y29FSXJLeFowdHVMS09LVEFra1lhNGRQMDRqYjNpOWt3NmN1RFNKK3c2ZWti?=
 =?utf-8?B?OGpYdGlheGg5NkV3T3dEWHdXcEo0WVRlUmxtNldDVDFPRFhVVEdzdlRORUJs?=
 =?utf-8?B?ZXREVVdYbUxxSGxPYms0eE1hUDRuZjlEUmJTaFJjaU1OYVpQdGw5Ylk5MTc5?=
 =?utf-8?B?clNJWitxcjlRMzIyMkc0NVN2WTR6a2ZhT2xQc0lVNGJIdGdrMTNkV2lOcWlF?=
 =?utf-8?B?V2dMbXV2MkZCSlpBa3d0aks2OFM4TjNpeEEwanN3ekRocGtFVmoxTjhGZFAv?=
 =?utf-8?B?RTRZRVl5YTNPMlpsb05PLzZxV2tmS3VxRlA1TTBqRFY0WEE0WFpBNU95Y2Fi?=
 =?utf-8?B?VGhDZkthMVNKVG9WSzdueUxyd3VsWTlCMm5VWldqN3ZBa0JlQ3dleGxTSTFK?=
 =?utf-8?B?bThObGhXbmpBRjA0cHRvQzM3VXFoN3BnTk1aOXE3bWVJaDFlc0xvak45ako1?=
 =?utf-8?B?cThJTXZNMmQ4cnE4ZHFHYml0dnJzN0hGZ0YwbFQyYVdsdkpqM3FGbi9JeUZJ?=
 =?utf-8?B?T1gyRWNXUEprVVJUMFI4NGxmUmdkTlc1Rlg4WHZPUE5rajZTQ2JiaHBIeUlp?=
 =?utf-8?Q?RrZaxd+aJSFcB?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N3IzSmRKcVFsSDNTQ2FQN3kzd3hSbjBQaG1EcUpHVjhZQlJMZk1xdzczNklJ?=
 =?utf-8?B?K3dQdHpNMWdZVnFwZlRqaXFQTEQ4aDBHVHdLSHFETUN6VDVad2dvYVdZdlRx?=
 =?utf-8?B?U2diNE5QOGJ1emhOS09OTGw4S1haNnZmV3FmS3JXcUFTRVpua2ZJVXBTWFZB?=
 =?utf-8?B?T3JxOXpTRXBTemNWSUVIOFl5dnIyVVJzVURQalJCOGpXcjFSM2pKMGE3RExL?=
 =?utf-8?B?dHQ5TW5XVkVzRCt6MVlCZ3pUQThOa042Wk0zOUIvRHFQeEdDTUN0NDlDdUk2?=
 =?utf-8?B?cGZKUTZyeERUdjlLWXpPRHgzb0sxQmtBR0VYYkRjNDFoemNIZmRxTWw5NFIx?=
 =?utf-8?B?WkxTS0hSanI1bEhibEdpYVlyVlRHbGNobmR6eGU0QmhZYzJTbWZ5eHZCbEZZ?=
 =?utf-8?B?U1dtM1dSaG9EMmFEM0lCOExNZmNCZUMxYW1LQnFROE1UcEZGSUpHMXVseEFn?=
 =?utf-8?B?NElDQnNWQU9YNVJnRm11WmQ2bnBLNUtmc1h1M0doZnNPYlMyeDcxY0JJVTlI?=
 =?utf-8?B?aDJicndtN0YvaTZ4ejYvMUt0bmFTUGVpNmQ1aXNpVGJSZjdRbDNJQjJpK0xq?=
 =?utf-8?B?Tzc3YklheFk0QTZIclIwRE4yNFFyQmd6d21VK29SRDlUQ0tTOCtqdHhLcmZR?=
 =?utf-8?B?TmczTjdaQTQ1UU56SzhPYTErdmRIL0c0S1RKZ3d5Ky9ML1JqemRMYXBVQ1hZ?=
 =?utf-8?B?eGduUVdxTVhlN2NWKzBzWTRyekdQSUI1UkR5TG5iTGR6TG96RklVbzFFcGRj?=
 =?utf-8?B?bE5valhta0hNTTU2dEtqL2FXdVpZeGRPMEFwVWc0dnlrb2V2Rm1XUWFGNFZq?=
 =?utf-8?B?bkxGT2NOUnQ0a3ZYUkowR1BpQkYvL1pjZFhWMjBOU3M3eGMybFRtclQvZThO?=
 =?utf-8?B?Q05zVzZKNTFBa0ZzcEpMSXpBRXZ2N1RkaGhsak8zWkMzalAybHNGNFlmT2pZ?=
 =?utf-8?B?Z1AxT1h6ZjZrcE5TczJmVWUvQmNqZGRMQk56K3dBbzhpd29BLyszdGh5a3Vn?=
 =?utf-8?B?WFU3TlJYR0tDakNDcXJRQ2dWWjN5S0FGUnE4UTg1cXZ5U3prSlNadjBqdDAv?=
 =?utf-8?B?WTlvYWFMNlVkaTI2aW1WY3ZqZEVLZFEzS0lFRXVEa3lEWjEzZUZnVFovbW9P?=
 =?utf-8?B?S0xUQnRaMFFIRkl0MHMwYnZzS20yeUF5TFBUZkN3OFlzSmwxUytUM0J4VllW?=
 =?utf-8?B?UElDcGNlMVZQVm9PYmpIMG9zTTl0bklmTUhYeG5ua2IzdjI1UHVzSldkZzFv?=
 =?utf-8?B?ZWNFR3E0NndZeTBLQ2doWnJFZ21FVW4wbkVjTFN1SC9TQWQzVVRaemgyT0xa?=
 =?utf-8?B?aFlyWmlUajdWdWV5U3loY1RBekJiYXpGaFI2MVVNWWlzTWI5a0RuenRqK3lh?=
 =?utf-8?B?QUx2UzdTS3BQcDFJRU5XUTVFU0Q3dkRRb29qamFrcThDWko4U1NCaFFib2VN?=
 =?utf-8?B?QmhSODFoSmRMMks2TWZTZGlVY0lPSm5kbEZxRjNmK3lCU1U5Qnh3QzNWRkIx?=
 =?utf-8?B?WG14WDFhdVJ4NjZMRXpxdkVYenhMK1ZSSFlFcHdFcFBQWU1CS1IzVW1yenVu?=
 =?utf-8?B?Z2FGam9pNm5rQXdYNWV0V3RDdkhaOUVvMTZJUDlVRVBLcm9YWjZBbkMyN2dQ?=
 =?utf-8?B?S2xNT3U1emJLelNQNlBacUdzazJ3cnhjOGNNazhJcFo4eHlMWERhaXRIYnNo?=
 =?utf-8?B?eGJmVTVMcThNbUorUHZEb3VhZkxheTllRThUL3loTDR4QXZkYWpVT29hb3pQ?=
 =?utf-8?B?Zng2WkdaOXJEeHZ1N3lnaGJ5OTRSdTRENFNKWCt1NS94QnZOQko2UHVmaFZt?=
 =?utf-8?B?UlY1eEY4VXo1dTJlamN6SGFoSko1TklENzhUVGJJZTVOajJ2SUMzZ0dUZk1j?=
 =?utf-8?B?WEp1RDFDbG9IUEdoT0dONjJLUnpVTmNHV3YvM1lKRTduVXNoNk1Uc1ZzQ2F0?=
 =?utf-8?B?dFcxeFdOVXpsdktKdXBFalNlOVZFc1pHUS9wNnZRZzVnbHd3Q1h1anZCSjhN?=
 =?utf-8?B?QVU0WTBvWnlYUFRyR0RoUnd3R0tIQ1VQdUVjYVhFd0RVcDJ5TmptS2grdnhQ?=
 =?utf-8?B?VUZ0SXdUSUM4RVZlRDJ0WDZSMW9WdnJZK1owdkovUi9EdjA0eFhSeVhuMWdj?=
 =?utf-8?B?YUdGN0FjcEN3U01YVUNIYXR0bW9FVGhUSlRLQ1JnUS9USEFqTnI0ZUEzU1dn?=
 =?utf-8?B?Wmc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	d/NN7t9c5x1EqjAufMFBDU67V2VwZCL11ayqqx09LiwwGz7qjuDt6Ks7a0YwnGM4pTzs/XNkLor0pPt0bdhHjAQ5PIohL2ne+kLnxIzXjTwhzph/tbvSGue/jUaSD6mcYO8fjZdwJ7N0zML86Smjex6iHywhWV2M8ce9Hu5Rc40Pe0+509j9/Q5y9phOKH9sqJyHR3bsnmDZS5ZHl+DX0AG1cyrgmtTneVaHRRWrzR0Hyuuax7Mwq9PNZgO2GJRqDGHKAs6cOObciP2js5lPQIBw8bvaN+LfQCn8KUKPIdBhgNHIcWGAEFq7QKNZt7SRNBZOqTAJb6xAEmdXUHHc9MmC9vEkWtTiaQXkzc9Ff4ej1Rc/JWlggpkZc86DuZVHmr01mS/sk7qMjHkRLJkkMTfXCSsxb6Q7QWnyZBgbs/87xDTYqx70MeSlFbvz0JE66p5PolWW83pux4XSQ/yOa0QK6odpLUSjM36HHAoqTM7XyU05HGMk2tPlptMjnPYgYgV5je7ee1mDhRlVpLsHtVX6b6qmPdJivNzkC0QBmPvi0kHihboOK20hoa37YOEcFoWcocduj4KAAsA2CRgeGK9b1LzWhboKNMvgSq+KpAY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2375ee6c-1445-4254-6a7a-08dd46da8247
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2025 18:17:26.2077
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NXnpGbod9gKRfoLDbYfCLtm352pj1qZib/I9Ip+elBa/20zXzF0Kfwn6zPUsGYzYm/OCltp6kfS8szeAcKf38w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4188
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-06_05,2025-02-05_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 phishscore=0
 suspectscore=0 adultscore=0 bulkscore=0 mlxlogscore=999 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2501170000
 definitions=main-2502060146
X-Proofpoint-GUID: k1Cwd_FIBQ3AUP3mNHs8iiMEDYgukMis
X-Proofpoint-ORIG-GUID: k1Cwd_FIBQ3AUP3mNHs8iiMEDYgukMis

On 2/6/25 1:12 PM, Jeff Layton wrote:
> Currently, nfsd_proc_stat_init() ignores the return value of
> svc_proc_register(). If the procfile creation fails, then the kernel
> will WARN when it tries to remove the entry later.
> 
> Fix nfsd_proc_stat_init() to return the same type of pointer as
> svc_proc_register(), and fix up nfsd_net_init() to check that and fail
> the nfsd_net construction if it occurs.
> 
> svc_proc_register() can fail if the dentry can't be allocated, or if an
> identical dentry already exists. The second case is pretty unlikely in
> the nfsd_net construction codepath, so if this happens, return -ENOMEM.
> 
> Fixes: 93483ac5fec6 ("nfsd: expose /proc/net/sunrpc/nfsd in net namespaces")
> Reported-by: syzbot+e34ad04f27991521104c@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/linux-nfs/67a47501.050a0220.19061f.05f9.GAE@google.com/
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
> I looked at the console log from the report, and syzkaller is doing
> fault injection on allocations. You can see the stack where the "nfsd"
> directory under /proc failed to be created due to one. This is a pretty
> unlikely bug under normal circumstances, but it's simple to fix. The
> problem predates the patch in Fixes:, but it's not worth the effort to
> backport this to anything earlier.

I'd prefer to document this by labeling the actual commit that
introduced the problem in the Fixes: tag, then using

"Cc: stable # vN.M"

to block automatic backporting to LTS kernels where this patch won't
apply cleanly. I can derive the values of N and M from the commit you
mention above, but do you happen to know the actual culprit commit?


> ---
>  fs/nfsd/nfsctl.c | 9 ++++++++-
>  fs/nfsd/stats.c  | 4 ++--
>  fs/nfsd/stats.h  | 2 +-
>  3 files changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> index 95ea4393305bd38493b640fbaba2e8f57f5a501d..583eda0df54dca394de4bbe8d148be2892df39cb 100644
> --- a/fs/nfsd/nfsctl.c
> +++ b/fs/nfsd/nfsctl.c
> @@ -2204,8 +2204,14 @@ static __net_init int nfsd_net_init(struct net *net)
>  					  NFSD_STATS_COUNTERS_NUM);
>  	if (retval)
>  		goto out_repcache_error;
> +
>  	memset(&nn->nfsd_svcstats, 0, sizeof(nn->nfsd_svcstats));
>  	nn->nfsd_svcstats.program = &nfsd_programs[0];
> +	if (!nfsd_proc_stat_init(net)) {
> +		retval = -ENOMEM;
> +		goto out_proc_error;
> +	}
> +
>  	for (i = 0; i < sizeof(nn->nfsd_versions); i++)
>  		nn->nfsd_versions[i] = nfsd_support_version(i);
>  	for (i = 0; i < sizeof(nn->nfsd4_minorversions); i++)
> @@ -2215,12 +2221,13 @@ static __net_init int nfsd_net_init(struct net *net)
>  	nfsd4_init_leases_net(nn);
>  	get_random_bytes(&nn->siphash_key, sizeof(nn->siphash_key));
>  	seqlock_init(&nn->writeverf_lock);
> -	nfsd_proc_stat_init(net);
>  #if IS_ENABLED(CONFIG_NFS_LOCALIO)
>  	INIT_LIST_HEAD(&nn->local_clients);
>  #endif
>  	return 0;
>  
> +out_proc_error:
> +	percpu_counter_destroy_many(nn->counter, NFSD_STATS_COUNTERS_NUM);
>  out_repcache_error:
>  	nfsd_idmap_shutdown(net);
>  out_idmap_error:
> diff --git a/fs/nfsd/stats.c b/fs/nfsd/stats.c
> index bb22893f1157e4c159e123b6d8e25b8eab52e187..f7eaf95e20fc8758566f469c6c2de79119fea070 100644
> --- a/fs/nfsd/stats.c
> +++ b/fs/nfsd/stats.c
> @@ -73,11 +73,11 @@ static int nfsd_show(struct seq_file *seq, void *v)
>  
>  DEFINE_PROC_SHOW_ATTRIBUTE(nfsd);
>  
> -void nfsd_proc_stat_init(struct net *net)
> +struct proc_dir_entry *nfsd_proc_stat_init(struct net *net)
>  {
>  	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
>  
> -	svc_proc_register(net, &nn->nfsd_svcstats, &nfsd_proc_ops);
> +	return svc_proc_register(net, &nn->nfsd_svcstats, &nfsd_proc_ops);
>  }
>  
>  void nfsd_proc_stat_shutdown(struct net *net)
> diff --git a/fs/nfsd/stats.h b/fs/nfsd/stats.h
> index 04aacb6c36e2576ba231ee481e3a3e9e9f255a61..e4efb0e4e56d467c13eaa5a1dd312c85dadeb4b8 100644
> --- a/fs/nfsd/stats.h
> +++ b/fs/nfsd/stats.h
> @@ -10,7 +10,7 @@
>  #include <uapi/linux/nfsd/stats.h>
>  #include <linux/percpu_counter.h>
>  
> -void nfsd_proc_stat_init(struct net *net);
> +struct proc_dir_entry *nfsd_proc_stat_init(struct net *net);
>  void nfsd_proc_stat_shutdown(struct net *net);
>  
>  static inline void nfsd_stats_rc_hits_inc(struct nfsd_net *nn)
> 
> ---
> base-commit: ebbdc9429c39336a406b191cfe84bca2c12c2f73
> change-id: 20250206-nfsd-fixes-8e61bdf66347
> 
> Best regards,


-- 
Chuck Lever

