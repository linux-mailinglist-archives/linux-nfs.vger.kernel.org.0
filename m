Return-Path: <linux-nfs+bounces-9881-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 90163A2921D
	for <lists+linux-nfs@lfdr.de>; Wed,  5 Feb 2025 15:58:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE2427A162A
	for <lists+linux-nfs@lfdr.de>; Wed,  5 Feb 2025 14:57:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 839A3198845;
	Wed,  5 Feb 2025 14:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XbfaNyYY";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="FYQNNEvs"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57F4C18EFD4;
	Wed,  5 Feb 2025 14:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738767313; cv=fail; b=acrn7Z9wgofvNOaSOeUNP82QE2cXnrWEbDyoPMvegQXphpfVkNGRfFzx8Gl+6xvCobern8Ez6eYSRQsJco4V6USurOMKiRDhkYECsSOwZgHTe/h7PyETz/MhJBmQZSorSPaOZQ1fKAowQWLvnssmnCkt2B2pjU98X3QBl6jgXAs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738767313; c=relaxed/simple;
	bh=1NSMvLkZasH7sNSJHlLZVM++2//Bzh4UxuX2nfQnuV4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=N7lsPa3HRW17OKXuj/cgSdA7Bw9tVv18qEA/G+eBLldF7I2EJn2sP5IsmpCvRGTz943ywAGUHgn+ODU9v177ABU7n4+ng9tMoQJSUKlBgMSkm/3LN+MsTpUwnrPH46URhoxrN5MLooLEIEPPKoEJUpLB8NnH3Qs8mgvS+3TfTMw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=XbfaNyYY; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=FYQNNEvs; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 515DRUbK014000;
	Wed, 5 Feb 2025 14:54:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=gAP9l1DbGijbLtvznLYkS1xjrQNwGpOuLca4qk4dh8E=; b=
	XbfaNyYYIAOCS7a8yZWbb295YiWsLF9mVpQ+6VSmt3eWYZpqAEcKoHFILyjD3aVB
	1yFFkoBuzp7ST+jHOp79CodpX0DOAKP2u45TEQtU6mj98SFKNTEZTdQ8G6gf+rN6
	vAUcefpzgDM/fxE4i6sBHhVuipiJgpH3RnmF8B1du3bqi+PxDwRfs8apYNXwm9VN
	JolFQ5zB3TJd6fWkdNXlGQ5UAkwp/rbJTM191gSQEghxjBvcdVvMw33POjCdtheO
	4emlY0nCkQNsvm2l6qrtFJNwaUipK/ShAtaLDkH9664rYu08L2rt68NValEI7CfI
	63GQ84kVY/H6rurxgI3tKw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44hfcgyeyj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 05 Feb 2025 14:54:34 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 515El6or022731;
	Wed, 5 Feb 2025 14:54:34 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2043.outbound.protection.outlook.com [104.47.56.43])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44j8e96749-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 05 Feb 2025 14:54:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q2T1Z6g3qUkNPFEC7nCA5TGxCjfaed4OYzUWjlZsasI1BnGXMS5NFcl7L88SkIPFCBrrztPugB49qswiDm6pyuU/mNG0u7fYCpppRUzG7/8uPZsQl0yHNwZo8dEMNLSflfmwmX+uBpSbW3VQK5VpztDGopuIpAmN4A4rHjMPeyGLwgr5ubOcxIdryPYH3vY84wghaqyucYNbLxZD/UzXqEurQh2irZ35hATBqP4SVyRvW/Njo3NxNEmMidT0//msUg3UePrswpQ2HEu5f7M95xmd4DWv83QaEuNMQroTx44Z6O9+yjyH+yDyZQBDFfHfE1/6giSMLvL361oR/yxmog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gAP9l1DbGijbLtvznLYkS1xjrQNwGpOuLca4qk4dh8E=;
 b=S18fHNNwNm2meB5Pb5Hqgbx+y0+HnNypkDVpfnymThgPuWImXtsLHhnaJuAUHamUvVAEYtW+Fy7g8or7xns9FNoqbum4R41pdJvorC0YYt5D/F1hnRIwPKCjtLRHL8mnxl2YK/XDAn88c4/98w0+mmjvM6rpJE4zKtHKT2lRNDoOyesFkVh5unyta4RzZM8hFhgGx99ElWS5vHb93bSiAkMeWPiohhu4LLBTMYtOedXkeRIiNmyfjL7KGD9OiX916sztIMcojyNdnuIiLJ7dCDoeHT0+5WsYZ3Lrss37nGc4apnSEwMUb0GdDhBwEJY3JXimMmWLVRBAPjVviiDaFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gAP9l1DbGijbLtvznLYkS1xjrQNwGpOuLca4qk4dh8E=;
 b=FYQNNEvsLsDOCSnJpPujngvSN7dlwGa1tk1HxFXl5bxa92JL3Dtq84x76JyBvbu9vrUtLdkpMUQBINC8gSOkVUncxQBRfzH+nJmBhdE2eSNkAbQ5ZpWhA0M2dYeFJEdvwwVZsECQHImYwrvfWcGKLfAverBmgSZFGbPZeEUuer4=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS0PR10MB6055.namprd10.prod.outlook.com (2603:10b6:8:cc::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.26; Wed, 5 Feb
 2025 14:54:30 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.8422.010; Wed, 5 Feb 2025
 14:54:30 +0000
Message-ID: <8a05743a-5da9-46d1-bd89-c56cdc38fcdc@oracle.com>
Date: Wed, 5 Feb 2025 09:54:28 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] nfsd: map the ELOOP to nfserr_symlink to avoid
 warning
To: Li Lingfeng <lilingfeng3@huawei.com>, jlayton@kernel.org, neilb@suse.de,
        okorniev@redhat.com, Dai.Ngo@oracle.com, tom@talpey.com,
        trondmy@hammerspace.com, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: yukuai1@huaweicloud.com, houtao1@huawei.com, yi.zhang@huawei.com,
        yangerkun@huawei.com, lilingfeng@huaweicloud.com
References: <20250126095045.738902-1-lilingfeng3@huawei.com>
 <20250126095045.738902-2-lilingfeng3@huawei.com>
 <e9a10562-5c8e-4bc1-a767-20ee1b07e4b6@oracle.com>
 <7edd3481-df5a-4d22-87f5-367263b19ea8@huawei.com>
 <04b06966-ad5b-46ce-a629-b6de7b428360@oracle.com>
 <774bf740-28db-47e1-8a7e-dc32c435b6ec@huawei.com>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <774bf740-28db-47e1-8a7e-dc32c435b6ec@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR16CA0001.namprd16.prod.outlook.com
 (2603:10b6:610:50::11) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|DS0PR10MB6055:EE_
X-MS-Office365-Filtering-Correlation-Id: 45580c7c-dd53-4291-05eb-08dd45f4fec0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dkNMaFhIamphb0cyNWQwb2xxYWRMMUZRRXdiT01ReTFiQ1Y4SWdJTHJ1VTVw?=
 =?utf-8?B?QzBpMDF4OVovRmhWU0UzWFUwUEdaSUZqY0t6N3pVb1J5VTNhZWNRUy9TYm1P?=
 =?utf-8?B?SWQvVkJSdGxaR25BY285OUU3K2NLcVZ4RFhBRm5tS29lRWkvUnptbHNqME84?=
 =?utf-8?B?azVFeGVaUVU0aEtCeGUzeEd1ejF4cUxxUVl1Mmh0VHRUQzR4enV4ZzdPa1Fr?=
 =?utf-8?B?Nk9NcFhVaXF0eVVpWm52QUtleXU0cENYUnJqZkplN1lBRjMzYkR0THRTSXNh?=
 =?utf-8?B?dFh3bWkzdW82bHkyN0pESHZpaE9LYmxVY3dyYzh6bTRaeldUTVlyMXRudk83?=
 =?utf-8?B?ZDJ2Y0N0dFpnUnVRUkV4dGJMR1I4Vk4yTmlyRndFcFhMMkpDUTVzTTVrWFhF?=
 =?utf-8?B?TE5GeVB1OXA3UkJPb1oreEhIaU4veG5wMjJCYnZFM3VKcHlRMU5UTkpWd0sy?=
 =?utf-8?B?clN4Mm5ySWY0aURCYlp5TUZ4L1Y0ZXlINzFJa2NZOE8vYVJUamNWMGtIWWJw?=
 =?utf-8?B?MXk2VWlnTllRVzdEVS95QVYxbEc3VC9VaHMzSDhTL1hBekdMc2VXYmhZcnBv?=
 =?utf-8?B?N3BuL3JVSXEyV3A1bXFLWUFSNDZJUjZXVVRnRVY0UVdoSlFLQjlqa0l2UHhT?=
 =?utf-8?B?OE9OYkVyUmdoRDA5VmVQaHB2ZzV6NzcxT3RKeU5YdlNQbFVDb0dVN0o2UFlL?=
 =?utf-8?B?Y2tYUTZFaUVESjVSdnJ0MlhqUGJXSk9FMXR4Y1haaXpjR05HdHlaVDhwdVBE?=
 =?utf-8?B?bFROcW5hMmdtalIyRXFwM2RNaHAxVGpMZ1lVWGdJcForTGpCSXl4ZE9xdGs3?=
 =?utf-8?B?b3RXTko0a2dNSlduVSszTzhmMkhTRDhLRVg2dGEvNnFKTzV6c0pUdGpnSzJS?=
 =?utf-8?B?T0ptMEJYTjg5bk1UcjlXVHVRY28zb3VjVGZ5UlNXeVJzdXV0TDlvWEZTYS95?=
 =?utf-8?B?WWc2K1pRRlc5VEJ1eFNKS2Y5cE5YTS9ZVGJMNVdtYVFienZmS2E5OE43Tklr?=
 =?utf-8?B?RXVDYTF6UlpqckE0b21iWmRuMzRGY0c5b1pBRkF3dkt2aEtRQjh2MEQydm9N?=
 =?utf-8?B?TXpHbXp2dG9VcGcxbDJ0RFVaSUlzcWFsYm9ObTcwMFRxbGVneCtVT3gxZWNL?=
 =?utf-8?B?Y1BSZGhiMS94dWxucHVRM243amFnWjk0MUhRQnNHdk5FMm1EYjhxVzd3R2pt?=
 =?utf-8?B?T05zUiszOWx5eE1wbUhBWXYvQndVUXdiOUJSUTZmOFYwMTZFenNxVXh3STBN?=
 =?utf-8?B?VkVBdUtYSm5IS256dTlTaHhJZ2pldURSVTByQjE2QTFpMzE0U2szZFp2bGhB?=
 =?utf-8?B?TWdNMjU3VGdtVDlDV3N0WW9vNTF1L2IyeHZhN1MwMlJiNlIvU1k0dDF1NzJU?=
 =?utf-8?B?TVAwVmN0RDcrTjdNU0Vla1NTS1VLL3M2am1SZ1Q5UnpaeDBqMzBEQmRxTUpx?=
 =?utf-8?B?emhFSFRSR2NVcjNueC83NDN6MHlPbm9VdUJzamd4VUcrWXlCRklUcUhFU3I2?=
 =?utf-8?B?cUhXWlFHS3ZVMlVvNUlvQTIyN0NHMlpyZzUvVGlJaC90SWI0NWEzaVZ1eFl3?=
 =?utf-8?B?ak81Uld5blBGbWlmREN0RzFnZFNiR3ZHcEpWU0I0VTlrK2ljOHJheTFtWG4y?=
 =?utf-8?B?dkkwMXE0SS9INHBqbXRvbENVaU5Ocmk1bTFyeVB1YUNiY0hLSVZhQ3N0Nmlm?=
 =?utf-8?B?VTRtQW9qZmpmNjMvcU1Rc2FkT0FrajBVeHJVd2VPRDhjTHZKVFltS2dCUEVL?=
 =?utf-8?B?SGdvcjRBeEtucVZaOXlIK1Zjbm0zR0hNdkRwd2pEdTF6ZG9HV2YzRmMxK09H?=
 =?utf-8?B?L2N5UWphdDRDZCttSkUwbEZHbDNhUDlnM1M0M3FFcmh2Q1MzeVlxMUl4ZGVa?=
 =?utf-8?Q?W9oRvKGleNqrK?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K2hLNEdKUnRzVFVnaUx5WFd5blJ4RlU4QVdVMmhMM05vcG54SlBJWWJIMW4y?=
 =?utf-8?B?SDNHVEpJSy83Mm5sNWV1eHhTTGNVYlJvNFFuT3ZycER6L3NOcFRYQjhOdEhq?=
 =?utf-8?B?OHBQS3FUdHBFbzhGNkZGVGhTWFB6NkR0SzJUc1ZhS3hOQ3dzV0dGTk40NWor?=
 =?utf-8?B?Q3JpUlhOY1R6OGlxL2dnaWVXQzlrQmo3WVZIaDA0QWRhckl4N1lvdThjY0RK?=
 =?utf-8?B?NEtQTUVPMnJCd1FmNkkrQWFtTmQ4WVdON0RpRmRlQ1JQU2x1MEpZUjJycU5j?=
 =?utf-8?B?ZU5TaE9lRWt2cFFGQlkwRGdsOXBwR2tJbVhFSEpNMzhvenVNUUZiV05FN1A1?=
 =?utf-8?B?cElvOG13Z1dNTEQ1ZGNObEpEZXRlNjBHVFZmZzRUMWJobWVjUjBtbFFEUTBh?=
 =?utf-8?B?emVDRk9neDFlcmFIOHRsU0U5M2FXVWdxNXFMWHc4SU5zMlNkYlI0MTRJOHly?=
 =?utf-8?B?VkpBSHkySVJyajlIY2pyV1BIejNZejFVLzV4cnBFZUlXcVJaeDk3alp1M1px?=
 =?utf-8?B?QWJwNDBTVWs3WUlPZ2VlR2tTclVyVml1cFJ3SGFSdnJJVmRSUW1pV0dTUnpJ?=
 =?utf-8?B?Wlp1RUxmQmRsdTVmVHRyZ1VpcnNxVnBRYmRZRnd0dStZQk96Zzlsc3BQb2Uy?=
 =?utf-8?B?TlVFQ2M1T3Zkc1hrN093bmZuYVJjak1Zc1NCeG5YdXdOa1ZEK1QrM1lVNFRL?=
 =?utf-8?B?Ym1vejlwUVcxK3pvOWVSbFRmSlZYbzNLM2wrSlRpd09HQ3kvVjFZSnpvNS9r?=
 =?utf-8?B?ZHVLTXVMbmErMExUR01tc3lyR1FQc1lLR2Q1QWxLQkYwcnBKNUpUNVFlQS83?=
 =?utf-8?B?eVBSQmJHVkw5SGtTMjJjcWFtNm80TzUvd1dmbG9HdGxHWmFnV1dnVkgrcnJM?=
 =?utf-8?B?UWVLbTJGbG1uMkYwOXJyOWpJV2VPaFcyRUI0dE81ZmNFOHZiZjUvcVcwZWdL?=
 =?utf-8?B?cnlTZnQ1aHN0L1FLa3gzZ2pERVNUN0NGNWFxVS9UWmh0Y3VFT3U1aStZelFV?=
 =?utf-8?B?dVlCajVsSnpWZUxRVmwrcmh2RGlmbXY4WFFoN08xeHVNNkJaUTRjWXR3UU1O?=
 =?utf-8?B?UDZiSWZiOHk3NVJIaG9SYm1ZN3BKK29TVGRmUm0yajRlYlFaLzcycFh3QTFV?=
 =?utf-8?B?cTdaK1ZZWXh0L201S1dKMEZYVnlsbXBUUDlmcXdPenpMdUJsUG0zcmswc2ti?=
 =?utf-8?B?bmhiVnVMZGtXTkswK3BJdW5UNzRIZzkyYlcwclMwcThTNlpNTXNqY25NWTNs?=
 =?utf-8?B?anR6LzJPRzIwZ0VTUGl1RnhIcWZ0SytCdGhsMzZrNEN5OFl1ZU1Ea1p6SlVw?=
 =?utf-8?B?cG9DKzNHaGxta3Y0UVdnU3RuV0U0NGRPazRyQjFTU3prSTZUYjZUQ0hlOStP?=
 =?utf-8?B?WVVtSUI3OGhIdCtrLzRmblZhS25EbjZZdnZhZTFneHdXenZCWS8zSmQ4K2ly?=
 =?utf-8?B?OTFaU2VXOThVY3ZoZHZHeWx4YWtacTIxa2NocUFQWFRzUlUxemNZRkZReUgz?=
 =?utf-8?B?VTdBdWVzODBYNGpoVTBYWDZROVF2dFRpL1F3MWVMNWV5bC94R1JtSHZNeDFB?=
 =?utf-8?B?THdBZnVCL29xUVpKS0s3N2FPTitDaWVxSTBVdnJKYlZlQTlZU1ZxQlBHanNr?=
 =?utf-8?B?VVNZMVo0NWJPQzZOSDkzNzN6eUtYQ3o0d1ZHeFd1UURuOHE5ZjJnNldxSElH?=
 =?utf-8?B?WFBlNkRnMG5RL1RLOElFT2xpYWV3UUY5NjVUeUZvYlpVWU1IUzlBT3JScTBO?=
 =?utf-8?B?djFhME5mOGwrSXA1TVNsQVNwenlKOVU2MC9Md3pySnF1dnR5bi9rU2VOWXdu?=
 =?utf-8?B?L1lmVjlPSytBdFFhbm1QcXZ5ZFptSG0zNDI0a2E0cU54YlZleTRlWmt5RWtM?=
 =?utf-8?B?aTd5d2NNZmpxMXZxWUV5eW1iSnUySWZxQy85VzMvc2JKMnY0cmxUbUk1T0lO?=
 =?utf-8?B?ODl3K0ZjckRVWWlqNGJXR05uM3oxdG5lSlFGNkM2eDN1OW5iL3hudGNyc3Z4?=
 =?utf-8?B?NmtPV2t0VXFLYlB6cDd4YTNqa0pkMDJuVkhVbjVUN09yZmQvMUFoeFplWGZ6?=
 =?utf-8?B?K2VZYUR3UDRwZzEvZ1JhRTJ0YnBUdDFIVW9Xdm1PZ0RkZUs0dU92VEZmOU5N?=
 =?utf-8?Q?ju+Ja2SrPsHYPTDrqEX2KsoSG?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	0re0F+e5/7rcYVBluYUhYYoY6WjTPsL65VBWy9+GSs2v/RqvlVgOh5ROOSl0hzPwG8KHhactyRnAuUMv/tMXvFvmI6Xx2kT+w/jAWbbmQmP7PEPUVIQoYSR5Eo1grt96k8fvDtVJf84uuoRGYmlhZF56cftevdYqxGBxNL8N5xV9/0ZILajhQT/TgDmL5aSyEyYxyKV7uoErWR5GsVi9hvdcbTEZVtjFo+ouTQ9ID8glHVPPfPlgmX+CEEvE/8BSDSI6ybO7xvdzbORsvXqCmHexHxdSxnzcBbC/sAlsiTGtpUbpZLxZXazn9GOZBggxm0WbRJYqC2CdQNyhCbiXsUrPmxQlMUcNTMGJDZ9xoew1DOUAC9tvw8hTkipS8J8yl6qsml1BOL+KC+nofpTr/A5NbmPjpTb7kC9phiAetRo+6KlIIMCRMit5eDBsJHQ8t94H+1DK+kxoLq9tM/fUovslBw89meryIZphqcgox3/eLT9hSoQ+2mrRkuzvDnNiyL2t0UKnW1WviX89DvZO5eeiAXSzq98NxGKsgKD2mfiru48CXMpa3fbF8r9fLPFyc0d0Fkn4U2iXZMeJ8Kv0C/fzSgQYokJ4lxH736NmEyo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45580c7c-dd53-4291-05eb-08dd45f4fec0
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 14:54:30.6234
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ayTzVxHhnBnj74b6qYO2CxUMxEkPqB21TiIwRX9ebBsOo0AtHxYSlEeU6c++tUzbN8AL5+cJEUsLbDN08VaXsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6055
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-05_06,2025-02-05_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 phishscore=0 adultscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2501170000 definitions=main-2502050116
X-Proofpoint-GUID: YHdgoZ1u4KdQb4M0q2UeNMfMAS6V4ibN
X-Proofpoint-ORIG-GUID: YHdgoZ1u4KdQb4M0q2UeNMfMAS6V4ibN

On 2/4/25 8:53 PM, Li Lingfeng wrote:
> 
> 在 2025/1/27 21:28, Chuck Lever 写道:
>> On 1/26/25 9:33 PM, Li Lingfeng wrote:
>>>
>>> 在 2025/1/27 1:27, Chuck Lever 写道:
>>>> On 1/26/25 4:50 AM, Li Lingfeng wrote:
>>>>> We got -ELOOP from ext4, resulting in the following WARNING:
>>>>>
>>>>> VFS: Lookup of 'dc' in ext4 sdd would have caused loop
>>>>> ------------[ cut here ]------------
>>>>> nfsd: non-standard errno: -40
>>>>> WARNING: CPU: 1 PID: 297024 at fs/nfsd/vfs.c:113 nfserrno+0xc8/0x128
>>>>> Modules linked in:
>>>>> CPU: 1 PID: 297024 Comm: nfsd Not tainted 6.6.0-gfa4c2159cd0d-dirty
>>>>> #21
>>>>> Hardware name: linux,dummy-virt (DT)
>>>>> pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>>>>> pc : nfserrno+0xc8/0x128
>>>>> lr : nfserrno+0xc8/0x128
>>>>> sp : ffff8000846475a0
>>>>> x29: ffff8000846475a0 x28: 0000000000000130 x27: ffff0000d65a24e8
>>>>> x26: ffff0000c7319134 x25: ffff0000d6de4240 x24: 0000000000000002
>>>>> x23: ffffcda9eaac3080 x22: 00000000ffffffd8 x21: 0000000000000026
>>>>> x20: ffffcda9ee055000 x19: 0000000000000000 x18: 0000000000000000
>>>>> x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
>>>>> x14: 0000000000000000 x13: 0000000000000001 x12: ffff60001b5ca39b
>>>>> x11: 1fffe0001b5ca39a x10: ffff60001b5ca39a x9 : dfff800000000000
>>>>> x8 : 00009fffe4a35c66 x7 : ffff0000dae51cd3 x6 : 0000000000000001
>>>>> x5 : ffff0000dae51cd0 x4 : ffff60001b5ca39b x3 : dfff800000000000
>>>>> x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff0000ca5d8040
>>>>> Call trace:
>>>>>   nfserrno+0xc8/0x128
>>>>>   nfsd4_encode_dirent_fattr+0x358/0x380
>>>>>   nfsd4_encode_dirent+0x164/0x3a8
>>>>>   nfsd_buffered_readdir+0x1a8/0x3a0
>>>>>   nfsd_readdir+0x14c/0x188
>>>>>   nfsd4_encode_readdir+0x1d4/0x370
>>>>>   nfsd4_encode_operation+0x130/0x518
>>>>>   nfsd4_proc_compound+0x394/0xec0
>>>>>   nfsd_dispatch+0x264/0x418
>>>>>   svc_process_common+0x584/0xc78
>>>>>   svc_process+0x1e8/0x2c0
>>>>>   svc_recv+0x194/0x2d0
>>>>>   nfsd+0x198/0x378
>>>>>   kthread+0x1d8/0x1f0
>>>>>   ret_from_fork+0x10/0x20
>>>>> Kernel panic - not syncing: kernel: panic_on_warn set ...
>>>>>
>>>>> The ELOOP error in Linux indicates that too many symbolic links were
>>>>> encountered in resolving a path name. Mapping it to nfserr_symlink
>>>>> may be
>>>>> fine.
>>>>>
>>>>> Signed-off-by: Li Lingfeng <lilingfeng3@huawei.com>
>>>>> ---
>>>>>   fs/nfsd/vfs.c | 1 +
>>>>>   1 file changed, 1 insertion(+)
>>>>>
>>>>> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
>>>>> index 29cb7b812d71..0f727010b8cb 100644
>>>>> --- a/fs/nfsd/vfs.c
>>>>> +++ b/fs/nfsd/vfs.c
>>>>> @@ -100,6 +100,7 @@ nfserrno (int errno)
>>>>>           { nfserr_perm, -ENOKEY },
>>>>>           { nfserr_no_grace, -ENOGRACE},
>>>>>           { nfserr_io, -EBADMSG },
>>>>> +        { nfserr_symlink, -ELOOP },
>>>>>       };
>>>>>       int    i;
>>>>
>>>> Adding ELOOP -> SYMLINK as a generic mapping could be a problem.
>>>>
>>>> RFC 8881 Section 15.2 does not list NFS4ERR_SYMLINK as a permissible
>>>> status code for NFSv4 READDIR. Further, Section 15.4 lists only the
>>>> following operations for NFS4ERR_SYMLINK:
>>>>
>>>> COMMIT, LAYOUTCOMMIT, LINK, LOCK, LOCKT, LOOKUP, LOOKUPP, OPEN,
>>>> READ, WRITE
>>>>
>>>>
>>>> Which of lookup_positive_unlocked() or nfsd_cross_mnt() returned
>>>> ELOOP, and why? What were the export options? What was in the file
>>>> system that caused this? Can this scenario be reproduced on v6.13?
>>>>
>>> Hi,
>>> I got a more detailed log with line numbers from our test team.
>>>
>>> VFS: Lookup of 'dc' in ext4 sdd would have caused loop
>>> ------------[ cut here ]------------
>>> nfsd: non-standard errno: -40
>>> WARNING: CPU: 1 PID: 297024 at fs/nfsd/vfs.c:113 nfserrno fs/nfsd/
>>> vfs.c:113 [inline]
>>> WARNING: CPU: 1 PID: 297024 at fs/nfsd/vfs.c:113 nfserrno+0xc8/0x128
>>> fs/ nfsd/vfs.c:61
>>> Modules linked in:
>>> CPU: 1 PID: 297024 Comm: nfsd Not tainted 6.6.0-gfa4c2159cd0d-dirty #21
>>> Hardware name: linux,dummy-virt (DT)
>>> pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>>> pc : nfserrno fs/nfsd/vfs.c:113 [inline]
>>> pc : nfserrno+0xc8/0x128 fs/nfsd/vfs.c:61
>>> lr : nfserrno fs/nfsd/vfs.c:113 [inline]
>>> lr : nfserrno+0xc8/0x128 fs/nfsd/vfs.c:61
>>> sp : ffff8000846475a0
>>> x29: ffff8000846475a0 x28: 0000000000000130 x27: ffff0000d65a24e8
>>> x26: ffff0000c7319134 x25: ffff0000d6de4240 x24: 0000000000000002
>>> x23: ffffcda9eaac3080 x22: 00000000ffffffd8 x21: 0000000000000026
>>> x20: ffffcda9ee055000 x19: 0000000000000000 x18: 0000000000000000
>>> x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
>>> x14: 0000000000000000 x13: 0000000000000001 x12: ffff60001b5ca39b
>>> x11: 1fffe0001b5ca39a x10: ffff60001b5ca39a x9 : dfff800000000000
>>> x8 : 00009fffe4a35c66 x7 : ffff0000dae51cd3 x6 : 0000000000000001
>>> x5 : ffff0000dae51cd0 x4 : ffff60001b5ca39b x3 : dfff800000000000
>>> x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff0000ca5d8040
>>> Call trace:
>>>   nfserrno fs/nfsd/vfs.c:113 [inline]
>>>   nfserrno+0xc8/0x128 fs/nfsd/vfs.c:61
>>>   nfsd4_encode_dirent_fattr+0x358/0x380 fs/nfsd/nfs4xdr.c:3536
>>>   nfsd4_encode_dirent+0x164/0x3a8 fs/nfsd/nfs4xdr.c:3633
>>>   nfsd_buffered_readdir+0x1a8/0x3a0 fs/nfsd/vfs.c:2067
>>>   nfsd_readdir+0x14c/0x188 fs/nfsd/vfs.c:2123
>>>   nfsd4_encode_readdir+0x1d4/0x370 fs/nfsd/nfs4xdr.c:4273
>>>   nfsd4_encode_operation+0x130/0x518 fs/nfsd/nfs4xdr.c:5399
>>>   nfsd4_proc_compound+0x394/0xec0 fs/nfsd/nfs4proc.c:2753
>>>   nfsd_dispatch+0x264/0x418 fs/nfsd/nfssvc.c:1011
>>>   svc_process_common+0x584/0xc78 net/sunrpc/svc.c:1396
>>>   svc_process+0x1e8/0x2c0 net/sunrpc/svc.c:1542
>>>   svc_recv+0x194/0x2d0 net/sunrpc/svc_xprt.c:877
>>>   nfsd+0x198/0x378 fs/nfsd/nfssvc.c:955
>>>   kthread+0x1d8/0x1f0 kernel/kthread.c:388
>>>   ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:861
>>>
>>> Although I don't have a reproducer to reproduce this problem, I think
>>> ELOOP should be returned by the following path:
>>>
>>> v6.6
>>> nfsd4_encode_readdir
>>>   nfsd_readdir
>>>    nfsd_buffered_readdir
>>>     nfsd4_encode_dirent // func
>>>      nfsd4_encode_dirent_fattr
>>>       nfsd4_encode_dirent_fattr
>>>        lookup_positive_unlocked
>>>         lookup_one_positive_unlocked
>>>          lookup_one_unlocked // ELOOP
>>>           lookup_slow
>>>            __lookup_slow
>>>             ext4_lookup // inode->i_op->lookup
>>>              d_splice_alias
>>>               // VFS: Lookup of 'dc' in ext4 sdd would have caused loop
>>>
>>> This scenario may be reproduced on v6.13 like this:
>>> nfsd4_encode_readdir
>>>   nfsd4_encode_dirlist4
>>>    nfsd_readdir
>>>     nfsd_buffered_readdir
>>>      nfsd4_encode_entry4 // func
>>>       nfsd4_encode_entry4_fattr
>>>        lookup_positive_unlocked
>>>         lookup_one_positive_unlocked
>>>          lookup_one_unlocked
>>>           lookup_slow
>>>            __lookup_slow
>>>             ext4_lookup // inode->i_op->lookup
>>>              d_splice_alias
>>
>> So: lookup_positive_unlocked() is the VFS API returning it. Got it.
>>
>>
>>> According to the information provided by the test team, the export
>>> option
>>> is "rw,no_root_squash", and I'll try to reproduce the problem.
>>>
>>> By the way, could you suggest which NFS error code would be most
>>> appropriate to map ELOOP to?
>>
>> NFS4ERR_SYMLINK is closest. But the spec says, you can't return that
>> status for every operation; in particular, READDIR does not allow it.
>> So I'm quite hesitant to correct the crash you found by adding this
>> mapping to nfserrno.
>>
>> In this case, I wonder if READDIR can simply not return attributes
>> when it hits an error.

Turns out, no: the spec has (non-normative) language that READDIR has
to fail in this case.


> Do you mean to add an ELOOP check like the following and return nfs_ok
> directly?

I wasn't thinking of special treatment for ELOOP. I am concerned about
NFSD returning NFS4ERR_SYMLINK as the status for a READDIR operation,
which the protocol spec forbids.

It's kind of interesting that there hasn't been a need to add an ELOOP
mapping to nfserrno() until now. I'm a little hesitant to add a generic
mapping without checking the thousand other places nfserrno() is called,
but that might end up being a necessary part of this fix.


> diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
> index e67420729ecd..3a03eba9d4aa 100644
> --- a/fs/nfsd/nfs4xdr.c
> +++ b/fs/nfsd/nfs4xdr.c
> @@ -3814,7 +3814,7 @@ nfsd4_encode_entry4_fattr(struct nfsd4_readdir
> *cd, const char *name,
> 
>         dentry = lookup_positive_unlocked(name, cd->rd_fhp->fh_dentry,
> namlen);
>         if (IS_ERR(dentry))
> -               return nfserrno(PTR_ERR(dentry));
> +               return (PTR_ERR(dentry) == -ELOOP) ? nfs_ok :
> nfserrno(PTR_ERR(dentry));
> 
>         exp_get(exp);
>         /*
> 
> I think it's a little weird to make this change just for ELOOP.

No doubt, but let's have a look at some code. The code in question is in
nfsd4_encode_entry4_fattr's caller:

	nfserr = nfsd4_encode_entry4_fattr(cd, name, namlen);
	switch (nfserr) {

...

	default:
		/*
		 * If the client requested the RDATTR_ERROR attribute,
		 * we stuff the error code into this attribute
		 * and continue.  If this attribute was not requested,
		 * then in accordance with the spec, we fail the
		 * entire READDIR operation(!)
		 */
		if (!(cd->rd_bmval[0] & FATTR4_WORD0_RDATTR_ERROR))
			goto fail;
		if (nfsd4_encode_entry4_rdattr_error(xdr, nfserr)) {
			nfserr = nfserr_toosmall;
			goto fail;
		}
	}

...

fail:
	xdr_truncate_encode(xdr, start_offset);
	cd->common.err = nfserr;
	return -EINVAL;
}

Not shown: if nfsd4_encode_entry4() returns a status code != nfs4_ok,
the current implementation packages that status value as the status code
for READDIR (when the client hasn't requested RDATTR_ERROR). The
default: arm shown above is where nfserr_symlink might leak.

I can't find any spec restrictions on the status code returned in an
RDATTR_ERROR attribute. Thus I believe setting the value of that
attribute to NFS4ERR_SYMLINK is permissible.

However, by RFC 8881 Section 15.2, READDIR is permitted to return:

NFS4ERR_ACCESS, NFS4ERR_BADXDR, NFS4ERR_BAD_COOKIE, NFS4ERR_DEADSESSION,
NFS4ERR_DELAY, NFS4ERR_FHEXPIRED, NFS4ERR_INVAL, NFS4ERR_IO,
NFS4ERR_MOVED, NFS4ERR_NOFILEHANDLE, NFS4ERR_NOTDIR, NFS4ERR_NOT_SAME,
NFS4ERR_OP_NOT_IN_SESSION, NFS4ERR_REP_TOO_BIG,
NFS4ERR_REP_TOO_BIG_TO_CACHE, NFS4ERR_REQ_TOO_BIG,
NFS4ERR_RETRY_UNCACHED_REP, NFS4ERR_SERVERFAULT, NFS4ERR_STALE,
NFS4ERR_TOOSMALL, NFS4ERR_TOO_MANY_OPS

So, if the client has not asserted FATTR4_WORD0_RDATTR_ERROR, NFSD
should set @nfserr to, say, nfserr_io in the default: arm before it goes
to "fail:" because READDIR mustn't leak arbitrary NFS4ERR values as its
status code.

Can you confirm my analysis via a network capture?


-- 
Chuck Lever

