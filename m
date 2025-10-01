Return-Path: <linux-nfs+bounces-14834-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75453BB0650
	for <lists+linux-nfs@lfdr.de>; Wed, 01 Oct 2025 14:56:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5996B7A863D
	for <lists+linux-nfs@lfdr.de>; Wed,  1 Oct 2025 12:54:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA6A62EC564;
	Wed,  1 Oct 2025 12:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="e17uhdS5";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Lwht5qor"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67D152EC090
	for <linux-nfs@vger.kernel.org>; Wed,  1 Oct 2025 12:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759323372; cv=fail; b=d/w9dpBhtxnMZKL3+iKohKOFfGuTto44jtfxzKK2Iv3CbrPByq2LqQ0xf1yXspLwkfv1wcGm5PsRuo9Rj2n0qUKnbNN95EYHxCiID3US9Tl+CIM3oe2xGMWBLYxKm7AIFWw0vqhkGYCW9/BBQHtcfCscY8GqjQ8yqoSeHpJGVBU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759323372; c=relaxed/simple;
	bh=RlrP5kGHqFMQzu5hkl0Nl17H4/GcqNGRa2TkdO2hmDQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=oEO6k+OilIT6V1FOHOEmJjit6JRwQmOH2g+rt3r8qTZjYrAI8DBHdLYBI/8pfCsIgDWDVk7XrA8WJbDv4XQeAyFqXqYbzKKI9CQUMMRCL9icCS6p7UAOzn2vOdfx5BzcwxkD1gY31qdPC7ttpW/b+dc3ZtLtH3GGJaQ1xtnzEGs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=e17uhdS5; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Lwht5qor; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 591CrGkx019492;
	Wed, 1 Oct 2025 12:55:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=bmzghum5b2K+QyJ0ztDTtkDd1dMf8QkaUjlsyfWfFTY=; b=
	e17uhdS5zK0gYX/djUSqrpftR6tzzsy8AWIS6GWckN3iTQtcwk3H9hcx6ccZrj7W
	euU/11YkEMZYg8Me6ssHVOGTj7ggrnSbQGR2ayRmxGzXBvgt01IqM6o5F3Uv/fw9
	KefgS5kgnRSadqJoGpEptbDIlgGOXTo0gwixZbDQZYHS0P7RM3fWbymXOWlHfhZQ
	UstjXuVruFQhUQ8jf15LIyenwRIQ2CpCu0GnYuTYLKdT0WFg17iyTzLJ/KloOQ+o
	Gx557YSwrglsc4KOCN7NWQrsj3vTz+xce+5P1eOZdIkYzGHD/CpV2pbaVPsFR+nJ
	GtBvpMPv08e1F298WJejfg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49gm3bhdn4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 01 Oct 2025 12:55:57 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5919pwJV023217;
	Wed, 1 Oct 2025 12:55:56 GMT
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11010037.outbound.protection.outlook.com [52.101.201.37])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 49e6ca4s6k-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 01 Oct 2025 12:55:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y+5Y6rldvrPe+bp8c1gGXHAyoXgOb+yCYNx4NDvaSFaqG39uJIY+bn6XbY3J7JjLGfza/P16Np4+iqC/SAvXGg9WUSWXCg0km6P1g/mJu8eD8W8VYidQF5+nzRN2a1BdIo/sv04M1dZqvvjIdabakxOJtpFtREW43aleiN88kzR3sumODfD5NCFmzYF0eebaClo28a+1pY0F9flgPCbWoQmjfGloj2X1uGuDUt8QM2d/BbJHTkYLSNV6GpmmwDp/U0DeCa9uYi+kLA/nv7+AbgzKx2DO9khKxJ0D0qZIECSgg1F/x42tCui4D61CkpqLVJNFne+pgdBEItYNmFqu3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bmzghum5b2K+QyJ0ztDTtkDd1dMf8QkaUjlsyfWfFTY=;
 b=sLuGN/aGonIZWg+aDpbITbjwHufOnxsoODzPBa6/hQBbCkSHXZHSZ3WJVOQC/rOpi/uxLKCJHhKmUxPx6c9FvDPX/OFosbPm1YnD4slW7d9MsJTLQ2Tab2y/FlPOXlBIv5Br2IGSfTFCjgP1DRb0LoSTtvchqCu19Jcd2mx5uonF6XzW/oeMTSNxzunoo6w+2nieR85t1cp0yB9taJVu5g23Jf1V922o0jeg+1vmoz0Bf0YnKiqniWwcf9l1LD70DQvxdEDmVyLKIT2MBRcMMO6vII9KjCw8HC2cXe1/dEBIEfBK13LFwYCyTAzg2eEQBYvRTVEzh+soc96abvJ35Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bmzghum5b2K+QyJ0ztDTtkDd1dMf8QkaUjlsyfWfFTY=;
 b=Lwht5qorhL5JKVxyCffxU/O14MmaAr8fnKb4a08vZmM/kgxjVD5NnihJDmKRsu613wKnmS/lWxaZn2mUSYkv+dITc1sW33o3z4zkbWNUwNk+IWBpHJB5l3QePio4ip/USfNyLdUhwndDXeqNMjpFE2ZJ7SomgduFZAjpkqz7tpE=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH3PR10MB7906.namprd10.prod.outlook.com (2603:10b6:610:1cc::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.18; Wed, 1 Oct
 2025 12:55:53 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.9160.014; Wed, 1 Oct 2025
 12:55:53 +0000
Message-ID: <ce7412da-5e93-4510-8017-38f7e56c5458@oracle.com>
Date: Wed, 1 Oct 2025 08:55:50 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] nfsd: Avoid strlen conflict in
 nfsd4_encode_components_esc()
To: Anna Schumaker <anna.schumaker@oracle.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Jeff Layton <jlayton@kernel.org>
Cc: NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        Simon Horman <horms@kernel.org>, linux-nfs@vger.kernel.org,
        patches@lists.linux.dev
References: <20250930-nfsd-fix-trace-printk-strlen-error-v3-1-536cc9822ee6@kernel.org>
 <ced615aa-1aab-40ff-87bf-bdfcb64cd9af@oracle.com>
 <4a5e2517-89f1-4acd-a724-d8310d7c267c@oracle.com>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <4a5e2517-89f1-4acd-a724-d8310d7c267c@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR18CA0035.namprd18.prod.outlook.com
 (2603:10b6:610:55::15) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CH3PR10MB7906:EE_
X-MS-Office365-Filtering-Correlation-Id: bb09d97c-80f7-42f1-d5bc-08de00e9dada
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?VlY3ZytSMkRNMCs3UmJlMFFENTkwOUFBdnpZNUNTTjBTY3BlTE4raFJ2cnox?=
 =?utf-8?B?WUxNck1vY3NlK2F5eEdDaHpQaE40cng3L0JFRkRZTFBjc0pGOUZqalhhaGhw?=
 =?utf-8?B?cXpUMXRDSWMzeU1ya2VacEdUL0JndXorL2FXcWZjb0ovKzN1ckpBK1dzQVNl?=
 =?utf-8?B?MmM3aGYxUGxtT1JPN0MxYnpEdVJhOE5tTzRpb3p4UFhLNFQ5Q0dzRlpNTGFB?=
 =?utf-8?B?RGZPWHVRWHN2V3JHV2tlMHdXRlY3VjBLZXRIRkUydlFyRFhDeFZ4VDRtanQ5?=
 =?utf-8?B?NGpLTHRDZkJBeE5CeU8wMFdQUVNIb25rY09YK09XbG9Od293Uk1XY2xVeko0?=
 =?utf-8?B?V3ozVzJIa2hqV2ZkRFA4TkZxT3lDSUN3emt1MExuRmN3RExJWExtVGRFWlVL?=
 =?utf-8?B?SUwvaEpmeDZvLy96UlA4aUZZd1NLeFZ5RHRWN3lhZ1pCdlUrUFY4NEd0Wmgv?=
 =?utf-8?B?MkRYQmtYMUdMbnJObUQ0YWFPcXlpN1NOZWhpUEVyQW93ZG5nOXlFQUhmekt2?=
 =?utf-8?B?dDBmSXhGbW9EVlloREV6aEI1R1Zqbm1sa1pXOW9yaEd6VWN1aExCZ3VTU2tP?=
 =?utf-8?B?SjR5TlM4SzI1VFZmOSszekwrTFZGRjVaV0RkZExCL3dMajl4VENBUkQ0aEti?=
 =?utf-8?B?ZjZKbjB4UVVYa3pkQ1lJK0N3VmFYK0JZTUJjcEc1WHJSUlVVaE5tR3c2MlhE?=
 =?utf-8?B?S1h2S2JuQmlEQW5VYTlQdHpyUG5NME5wWnAvOWVlbkcyWU1aR1B5UXJQVXFW?=
 =?utf-8?B?Z3huaElNMGhNOWJQRmRLWjhuMDEyQjB3akhlSk5UODVJRjIxZ2trbXFCMkF0?=
 =?utf-8?B?eFlTYnZQOTQrOE15S0RzdGRuaWtobG9kTGMvd0sydDNMNDQrKzhhcUJzYkcv?=
 =?utf-8?B?SXNhVHI3M29iUVNHYk5QYmc5NCsvUUM5TnN3Z2g4TWhkL2hoeFh1ZDA3OEZu?=
 =?utf-8?B?VklRNlZzdkhqU3FDSkpBOHF5Q1hWajREajJpQU5yT3NPTEkyLy9BQURyU1hp?=
 =?utf-8?B?ZWRGZmI2SWFYZlZ1aUNBUThxM2cyM3ZMZmJwUjRuK3lWQ1NjRWtFNDlqZ1BY?=
 =?utf-8?B?cEVVTllDN3ZrMkp1REVqZXVCYzlMQ1lTWll1R2FxME5ZcWlNUTY1dFlpdVZZ?=
 =?utf-8?B?U1kwemtHajRudEFtOU0vaFU3Y1ZRRmV3RzB6NWRsTU1KMTEvckZLOE5tQlhD?=
 =?utf-8?B?TmJtYkRBVkZhN3IyQ1J2MmtlcEdzdTlZWE44NmMrL1RDMms1NERweEZZWE8y?=
 =?utf-8?B?ajRBNXBTSWFjZnVxNG9uZytGL3Q4Qm9zbE5LWkQyUU9INXlqYmxlVWozZTAv?=
 =?utf-8?B?RzFReDYzNDdEMGRjRDI3MXBEQWgyV21ITjZRR2ErdjlSbStuQnl5Lzl2V3N0?=
 =?utf-8?B?WXIvMFAwNFEvQ1FiM1RSNGNsT1JOcjdUUFFsR1JNSENFZjBjWlJxWkgzRHkz?=
 =?utf-8?B?bHBpc2p4QmF3QjNyT201OVZ1SzA2ZUl2QjZOK2FBL1dYdFBzUEVQdTk5VlpC?=
 =?utf-8?B?aWM1M1l6eFVKTUFkaVZVY2w4OGc2ajI1djhtRmttdGZoYVFEOC81VWpSNHRo?=
 =?utf-8?B?aElLTmpXcWdiSjdyOW9YbWdHNWRDYzl2emwxaUVCMm53dldHb0J0UFRiRVpK?=
 =?utf-8?B?ZktpeUZjZElDUC9TcU9lKzhEODNpaXpWd3hhbk90dVo3d0tWQUJhSDkwc3dL?=
 =?utf-8?B?VEFqRlNmYW5TcDdEZWplVHp6UWFIbnhXNGV3WTlubVlzZXEvQ2dsQmxEUnRq?=
 =?utf-8?B?K2hrOU1NRXAwQlA3R1RsY1JSdFhDQmlRaVVQZkQ1bFF0aDlieGQ4b3FZYW83?=
 =?utf-8?B?Q0hBTUdHZ3ByZlR0VWhSczZQTFF3OE5VYTBWVGFHM1BkOVFSQWRiS2xJR2dj?=
 =?utf-8?B?cEs3cXdOckVPL2poV3lQcHlZZWxNWEs2SFlXRWVMRW5BL29naVVsOWxndEJW?=
 =?utf-8?Q?+K7Ht+28Kqk=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?c0E5MTE2WDFhQ2NTQzB0SGNiTmdpYnlRczE0MnZ2enp1ajZhUUdMRmcrdzRp?=
 =?utf-8?B?ZDlINk1iaE9seEFPVm1UWWVlQjBpUklRM1dTTFVHT3BpeHBzVnl4UmwwSjdm?=
 =?utf-8?B?ZFRnc1RQOXBuVisrc1pYVGVTeW5jZUgrUk5jZXZwdWdIMVBMd2F1d3FWZnkw?=
 =?utf-8?B?RlhsckYxWWFGcUNvSTJkNi9GQUZVTDVucWZLZEIwdkNmdDh0Z0hkR05tTy9i?=
 =?utf-8?B?Skc4TW9MajNBTmhiSFNub1V6QURwSWJyaGZaRFNlZk0yOFZZRHUxR1lTSVZ1?=
 =?utf-8?B?V2p5b0JieEpLaVl3VUZXWkUzd2xpSVYvd0NKTkhWbmIvZ2plWGdtN1lvUXp2?=
 =?utf-8?B?YllPcjJjYWcwaTNhQzAwZUwvYWJQKzk0WEZvUmZqY1VMakwxR1gvSTgydTRC?=
 =?utf-8?B?MlhHNEVseWpweTRYbVF4MlhYZVBoY1QxYytpQzZKRFFvbjNCdG5uWXQ5RDYz?=
 =?utf-8?B?b3hLenI3RE15NEh5T05wQmo4S2cvUllkem1QN09aVStNdTlEUERIcGpYdk9C?=
 =?utf-8?B?c3V4c2xHdmR5ekJIN0FjYmMwQ0NXZGNMLzZHMStXcmNaTHlYcjFWbXd5eGQr?=
 =?utf-8?B?SGpkL0tSNzEzeUhOQXQzK1ZJWmpYQWg3Y0lEeWtGaGRLL0w5K0lVRm01VDRW?=
 =?utf-8?B?Z3NKWlhpQXFmNEJNaU1hcldMb2NCSng5Vy9HZHRSRTVPcHhybEdMWEd6R3BM?=
 =?utf-8?B?Qms0eVpKc2d5bk9EK3V5eGNkTkpWTDBhY2s4WGVqTkdQN09XZ21uWHRvNjRv?=
 =?utf-8?B?SWdOUXZKTVhXWDBSMmdXVkM1WlJ5cEpFT3h5RlVMWUs4VTc1OEtXd0JpK2hW?=
 =?utf-8?B?dHFwc0ZTSW02R0RhZE93Sk10L0trR0tKL3FKMUlmeGMyV0lBSkdENHV2MzRT?=
 =?utf-8?B?MXhpM3p4OWxTUnVsN280NlM1T1hzcHF0eVd5eFF1eEhLNGFnbzRIc3BtRXE5?=
 =?utf-8?B?SU4yVWQ5V2t5RnMzOVFWV3pFcUxVS0VWN2VDcWNiTFBvampENlIzZ0NINXZa?=
 =?utf-8?B?YUxLNXg4NXJQdXRma0ZCVm1KdkVqR3RLU2VxNFhVRWlLc1NNR2lHY1VyWDFC?=
 =?utf-8?B?YURaY3FqcTlOdS94VHFrbG1oYU5EaHoxbXBLcHVaVlNDcXU0eVdOQ0ZKR1FI?=
 =?utf-8?B?cmlhcnRCRjZEWFZpNURBaGFrVjFRWFlWVmtCdXdRVlU5YWhiQXlsM1R4cTdh?=
 =?utf-8?B?eDJXODREL1cxSERyZXNUOEYwYzVZTXRXSmt1UzMrZUh0RllTWEE2ZzFUZnUv?=
 =?utf-8?B?YkFRQS9GT0xocUJvbFVrZVVuY1NZRHlyeXdhWG1ldWlnWmNjcjJrTndJRDJY?=
 =?utf-8?B?ajN5RUVJRWgvZlFQQjdHU3hLQVEzWTJWbHdIcVpuSHFwNmtpd2Z0eFhyVU9r?=
 =?utf-8?B?Z1JKK1RsTGZJTld5Vnd4VXRWWDZSQ1ZJN2JNZWlLd3VSamtpL2MyNHBFMUxJ?=
 =?utf-8?B?cUNjQkdwMllLVjNSVWh3MWh1WEd0T0hsVkhaZ3JWY3dBUVFyRWNYSE1LclQz?=
 =?utf-8?B?TVh5Y1pvd3M2MU9EWTNTVmQwazd0SUR0NGhJSjdRWkJ1QTA5OGJZYk9pT0Jk?=
 =?utf-8?B?eTBFNU13ckVkSjk5K3R0cVNELzRLc0JIN05PSDBBZ29CVGVuVE1JWlNwbEdq?=
 =?utf-8?B?OE5SRmlKMFlXWDQ0ZGVrWFk5alU3QVR4V0hhS00vOVMrMGRpNlNKeGhIaytv?=
 =?utf-8?B?ZFJwanI5WERhV0g1WGloZ1NOZTBzMGtuVSswRUwvcm9ETXd3YUlQUHlTZzBx?=
 =?utf-8?B?OFVFdjEvdm5lTFMxcXhPOXJrVzVFQzRvdmNRYVc0eTJQb2c0V0t5aHluMEZT?=
 =?utf-8?B?WjZocWc5eXNEQ3FHUXZKMi9RdlFQcHB5VW0za1VmYXBIMFIxeDhTYkNzcnpM?=
 =?utf-8?B?YW05dnFTV01KcmpCRTJzRW5GcXBwQlVtYm1VWmR3Mkdza3piYlluSUZkSzJm?=
 =?utf-8?B?MHpaOWdlVnVvZFM3cFZrcTY0VUlhZ0RPSmEyVW5Fbjg2UlVEWnJSVldRZkZv?=
 =?utf-8?B?dHFEbEZJaWQwMlh0a245UjQ0cFZXWk9DUG51d3E5TlVNZ0FkanVNb1Y5OEVM?=
 =?utf-8?B?cXZGTzVReFlETC9HU3BubVppNWRkQXFYbmVqcTFrVUpibEsvZUw1emYyOXIx?=
 =?utf-8?B?K2hzY1pBNytyandUN0tEL2Z3czg5NFY3dncwZzY3MTdUakx0bXorVFBpdkRj?=
 =?utf-8?B?b2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	SN6X+BgveR0LiwyfEOjkGtoUKS0zJRiTGttIbEedxT1++yhIJbcRBLmzFG0X4h5zHeT4s9vCulu8kfxLavcf5M7QneFx3DhXBO6x44T78R/cyUuzndqVih7hKRgzT5Fdpbe+4hpasjkyjI3iC0sVImChYyUUxZk69p4iYilMJXOoCbgrOpt+VSZLiexMmZbKvVzt2hrhsUPj1xqHCcx5Z6KxHjCqYA5BrFXFSNBOjxtrUC2jJKPr1jqNLsHYmbQxiD0Y9y7hZEPl9ddg4HbhLfIKo5To9+PifuRXDEaqwFGZhi5IYnEjruZ5EGUA9Vn9e2Qjlh0A8eyLMJnb0Mfdz6O8iWQw3D15yQPMHWWeLjx4hR668A1qhlpvZSJRdx3ztveQA8Pr+inYI8L1y54fp//mswyWtFAzaNy1Pz0UgP4DAcwAfWCGXbb5Q6RHypdILbMpkDed9VVabAG6YBFmuIApSLgAyTEnpbyu0hXw2rYu8gH3gEcM6+oEuWibWbzwsfMutX7FVVjl39mQI147fP3k64Qdjuk0W8D5hS2k9FiF76JP27gLWE4LimzCvNCovWvwD/q4mN2JyhtQxkJfXUmBk+vuBB0ajULJXccDXAU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb09d97c-80f7-42f1-d5bc-08de00e9dada
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2025 12:55:53.4467
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T4wDoImjHM8FZ+8aKNnMTECXVMyLOSskqNokRTXK8E0v7r9zTabQ3ZLWKza28UoJ/gdZx/pIMD/YltBRRqY2fg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7906
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-01_03,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 phishscore=0 bulkscore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2509150000 definitions=main-2510010111
X-Proofpoint-GUID: I6wGFw3EwiN2pdYk5Zbv0BIVgeaHdkzm
X-Authority-Analysis: v=2.4 cv=GsJPO01C c=1 sm=1 tr=0 ts=68dd24dd b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10
 a=bC-a23v3AAAA:8 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=A2O_XW2Mr3XG5WXh_jAA:9
 a=QEXdDO2ut3YA:10 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTMwMDE2MiBTYWx0ZWRfXwfyefoWLYSA9
 wusQHib3eFA7HLNogvZ/85SWYl+Ra5dJGX5zLqiPKXzTtUZry5/+jAu7ztzn8LZ+Yad79fWe926
 oy+E6dhDfhSQoqqBWuHaay2fsqNXoflfi4PnO6EFbnsUhqKuUv3VrlcBdUdymP6V6YMn9CaLRhe
 bM8ktXvsu5LZJTbUJrSvMG+1HMoWYSjh7f5EnYlnyzgqfBjF5IV9m9HedAZmy88VuxvRTAtRaF2
 z8FI+hSRlH/elNMOMl531pt6+e6U6tgmRczMV5wXq09fcP/EqKzr1HFDn74j3WIVGyGBuxxWGbF
 2xszvcq4dsaTyKyrbgfyphzRn2630inanmOKSooTEqJMqWCiACZTvhXCn7/sHBOUQY8JkNX0mIx
 sXOIpA4v3E8J3OHQRAl1GjL0+eQwvw==
X-Proofpoint-ORIG-GUID: I6wGFw3EwiN2pdYk5Zbv0BIVgeaHdkzm

On 9/30/25 4:55 PM, Anna Schumaker wrote:
> 
> 
> On 9/30/25 2:52 PM, Chuck Lever wrote:
>> On 9/30/25 2:31 PM, Nathan Chancellor wrote:
>>> There is an error building nfs4xdr.c with CONFIG_SUNRPC_DEBUG_TRACE=y
>>> and CONFIG_FORTIFY_SOURCE=n due to the local variable strlen conflicting
>>> with the function strlen():
>>>
>>>   In file included from include/linux/cpumask.h:11,
>>>                    from arch/x86/include/asm/paravirt.h:21,
>>>                    from arch/x86/include/asm/irqflags.h:102,
>>>                    from include/linux/irqflags.h:18,
>>>                    from include/linux/spinlock.h:59,
>>>                    from include/linux/mmzone.h:8,
>>>                    from include/linux/gfp.h:7,
>>>                    from include/linux/slab.h:16,
>>>                    from fs/nfsd/nfs4xdr.c:37:
>>>   fs/nfsd/nfs4xdr.c: In function 'nfsd4_encode_components_esc':
>>>   include/linux/kernel.h:321:46: error: called object 'strlen' is not a function or function pointer
>>>     321 |                 __trace_puts(_THIS_IP_, str, strlen(str));              \
>>>         |                                              ^~~~~~
>>>   include/linux/kernel.h:265:17: note: in expansion of macro 'trace_puts'
>>>     265 |                 trace_puts(fmt);                        \
>>>         |                 ^~~~~~~~~~
>>>   include/linux/sunrpc/debug.h:34:41: note: in expansion of macro 'trace_printk'
>>>      34 | #  define __sunrpc_printk(fmt, ...)     trace_printk(fmt, ##__VA_ARGS__)
>>>         |                                         ^~~~~~~~~~~~
>>>   include/linux/sunrpc/debug.h:42:17: note: in expansion of macro '__sunrpc_printk'
>>>      42 |                 __sunrpc_printk(fmt, ##__VA_ARGS__);                    \
>>>         |                 ^~~~~~~~~~~~~~~
>>>   include/linux/sunrpc/debug.h:25:9: note: in expansion of macro 'dfprintk'
>>>      25 |         dfprintk(FACILITY, fmt, ##__VA_ARGS__)
>>>         |         ^~~~~~~~
>>>   fs/nfsd/nfs4xdr.c:2646:9: note: in expansion of macro 'dprintk'
>>>    2646 |         dprintk("nfsd4_encode_components(%s)\n", components);
>>>         |         ^~~~~~~
>>>   fs/nfsd/nfs4xdr.c:2643:13: note: declared here
>>>    2643 |         int strlen, count=0;
>>>         |             ^~~~~~
>>>
>>> This dprintk() instance is not particularly useful, so just remove it
>>> altogether to get rid of the immediate strlen() conflict.
>>>
>>> At the same time, eliminate the local strlen variable to avoid potential
>>> conflicts with strlen() in the future.
>>>
>>> Fixes: ec7d8e68ef0e ("sunrpc: add a Kconfig option to redirect dfprintk() output to trace buffer")
>>> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
>>> ---
>>> Changes in v3:
>>> - Eliminate local strlen variable altogether (NeilBrown)
>>> - Link to v2: https://patch.msgid.link/20250928-nfsd-fix-trace-printk-strlen-error-v2-1-108def6ff41c@kernel.org
>>>
>>> Changes in v2:
>>> - Remove dprintk() to remove usage of strlen()
>>> - Rename local strlen variable to avoid potential conflict in the future
>>> - Link to v1: https://patch.msgid.link/20250925-nfsd-fix-trace-printk-strlen-error-v1-1-1360530e4c6b@kernel.org
>>> ---
>>>  fs/nfsd/nfs4xdr.c | 9 +++------
>>>  1 file changed, 3 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
>>> index ea91bad4eee2..07350931488d 100644
>>> --- a/fs/nfsd/nfs4xdr.c
>>> +++ b/fs/nfsd/nfs4xdr.c
>>> @@ -2640,11 +2640,9 @@ static __be32 nfsd4_encode_components_esc(struct xdr_stream *xdr, char sep,
>>>  	__be32 *p;
>>>  	__be32 pathlen;
>>>  	int pathlen_offset;
>>> -	int strlen, count=0;
>>> +	int count=0;
>>>  	char *str, *end, *next;
>>>  
>>> -	dprintk("nfsd4_encode_components(%s)\n", components);
>>> -
>>>  	pathlen_offset = xdr->buf->len;
>>>  	p = xdr_reserve_space(xdr, 4);
>>>  	if (!p)
>>> @@ -2670,9 +2668,8 @@ static __be32 nfsd4_encode_components_esc(struct xdr_stream *xdr, char sep,
>>>  			for (; *end && (*end != sep); end++)
>>>  				/* find sep or end of string */;
>>>  
>>> -		strlen = end - str;
>>> -		if (strlen) {
>>> -			if (xdr_stream_encode_opaque(xdr, str, strlen) < 0)
>>> +		if (end > str) {
>>> +			if (xdr_stream_encode_opaque(xdr, str, end - str) < 0)
>>>  				return nfserr_resource;
>>>  			count++;
>>>  		} else
>>>
>>> ---
>>> base-commit: 3fadfaec904dffab02ebf63dd9c2ae8fa15c6d32
>>> change-id: 20250925-nfsd-fix-trace-printk-strlen-error-2a24413eb186
>>>
>>> Best regards,
>>> --  
>>> Nathan Chancellor <nathan@kernel.org>
>>>
>>
>> There are fewer implicit typecasts now. Very good.
>>
>> This one also deserves some testing IMO. But, if Anna still wants to
>> take it:
>>
>>   Acked-by: Chuck Lever <chuck.lever@oracle.com>
>>
>> Given how late it is, I would postpone it until post -rc1 if it were
>> solely up to me.
> 
> I was already thinking about leaving this for -rc1 since v3 just came in today.
> I don't mind taking it, but if you would rather keep it in the nfsd tree that's
> fine by me too.

There isn't a conflict when applying this one to nfsd-testing. But the
Fixes: tag gets flagged by various automation because I don't have
ec7d8e68ef0e in my tree (yet).

I thought this fix was going to be more urgent, because distros enable
the compiler option that turn warnings into errors. But distros aren't
going to enable CONFIG_SUNRPC_DEBUG_TRACE, I don't think.

So I could take this one. It's in nfsd-testing now, just to let it soak.


-- 
Chuck Lever

