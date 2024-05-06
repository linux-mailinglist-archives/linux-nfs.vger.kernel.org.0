Return-Path: <linux-nfs+bounces-3187-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 523878BD83B
	for <lists+linux-nfs@lfdr.de>; Tue,  7 May 2024 01:37:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 637D8B22C59
	for <lists+linux-nfs@lfdr.de>; Mon,  6 May 2024 23:37:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3103F1E891;
	Mon,  6 May 2024 23:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XOlNtzOB";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="OHeYKOoL"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6279E1E885
	for <linux-nfs@vger.kernel.org>; Mon,  6 May 2024 23:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715038648; cv=fail; b=C9OhfUqAOKGgXmDzbFh0bWAsyiPfO1h+sxu/2/nz06ruG9WY/+jo3CH6Skcp+yJ+zlBrDc3Ry1ZyxcX6+BvtNOwD/fS9CkfxJvSZ8jmvP+5yAkDZX5/vQO7JESAuQntV5NNSaxd9GO5Vkzzt5/EUiNNMTcsf2uZHdZFGwuZPUuY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715038648; c=relaxed/simple;
	bh=7QYl0s2QLz9vJbd2IC/y7igjj/ym0OPBG3obllEWklg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Cu0aygl6umsWiwcoWsHIulwjFECwSa2hezEB4ibymuv79SAVwLCLYUSW7B4jzZD57bklI0hNGyV4y65F9ucmmW3xE+bFpCsatUI55eXGeuuIxD2wLIWxRO954qSnLuIZWk7R1Uv8c8ga7twEiBo3o45J0DGNvTpjh9xA+kdQ1fQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=XOlNtzOB; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=OHeYKOoL; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 446Mmp99015609;
	Mon, 6 May 2024 23:37:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=Ty/tuIzb9R2p/rA0zkXled78HFGetrTynTnzWicbjKs=;
 b=XOlNtzOBtm+/owMsXovyiLsNpB56a3rjYL40H3H/x8ogMkmksvaQcL3UyjgYMGrW5fEz
 IlqwqDqoYi5/6u5wJNua4E4XR14k5HP41pqcKfNENUGJjv2MW+NZ3/Mpscf4sik4M0wP
 Uqnwj3jiavJaHKC1LBOO+Be3PFzTgYVaa6ZJKsnW6NFSsbUujcjDggra6dwwRMNYomci
 lfKh7fmW0iZikwPih5a6u0hwY59esB1WYIQpAOPdHSpkXoPRq+h0JONzWz++Pa3QEQ/6
 TUqdXh5I9arKKjHSbPOVLtfmJch4rZOc+doOLSIKtRPPUZhJfTbaUZcZu4AvzWBGsA9E 7g== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xwbt53sxb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 06 May 2024 23:37:20 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 446MeaBe014471;
	Mon, 6 May 2024 23:37:19 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xwbf6p8d4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 06 May 2024 23:37:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XeeZ8MnopUKUHCg4X1y4DihSyFW0EW/k2y6kxLRikOuvidGR3K9TgRFXkCJ6mGyk5xIL6ahlCAUwqLvBj3DIwweDuGoOkLYE74cQUSa24bAlGMc9Wg14o9U/YdeT+hIUiprN8SJSO98lGrB+nq5wI35HUSawGlpybWo/BaaV7JeVbQlkCMjAAtV2UyO7NJfLcMynIDGXe+/+hI07VignA7kkKcC13jHw26Kr/XtJC/G24ca340dv5b1snBQJrgettblwzneuxtxrwhi7r+VjKFQ+B56hOwjn9/PHxqd2a8dmffhoKKNK/OZmlJL8EcCXDk4rbCO0+czNWCRAZsZnww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ty/tuIzb9R2p/rA0zkXled78HFGetrTynTnzWicbjKs=;
 b=LlBhdSdAGALfHL490BF2cr+txNiaQXKW3IYzHAlWlzXeF5JHtM6CnPr0n/FIHhooa4QbbI2Qq8INvLy0OZ+0IoTecIt6BViGy+BoqYmn00NahLz9VBjkC+Jig4Oeroii5/Stnpg7ymLZy9+AKDpCQrDOl4WzNu4nqAp4uP45wC2m1aS5I1++KKNmMrr4+Njym5PG5FnCBJ6Vyb+4BYPupIyUB/3yUxP7vD8lks401qiI0iKGa+Djsp5DWWYIRczS1kt2sXpyuyd7XhjiXuedvoeTkQ7D4al996kx6wq/N2aIv7zfIm1+M8HLBzfFGtyOXeQ43AZQPC3zeLMvOO5dsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ty/tuIzb9R2p/rA0zkXled78HFGetrTynTnzWicbjKs=;
 b=OHeYKOoL2yXOIPY5y0t7SM5OmpjBUzv++nAYmCok/HxXyZyOyJRWBnQTA2m2y1LSKWNwrwsLd75YyqzTXC1AF346ocGbSICcINfldF5WFKrHOkfLRMUo0prr8sZGtJskFTjynTWgQhQR07+nHsKxlaXAwGPZjHdvDpFPwrexQ5E=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by SN7PR10MB7103.namprd10.prod.outlook.com (2603:10b6:806:32b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41; Mon, 6 May
 2024 23:37:16 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::4c3a:47c2:806d:2e16]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::4c3a:47c2:806d:2e16%4]) with mapi id 15.20.7544.041; Mon, 6 May 2024
 23:37:16 +0000
Message-ID: <35d2a207-7671-4f8a-be2b-3da03fedee50@oracle.com>
Date: Mon, 6 May 2024 16:37:15 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] NFSD: Force all NFSv4.2 COPY requests to be
 synchronous
To: cel@kernel.org, linux-nfs@vger.kernel.org
Cc: Chuck Lever <chuck.lever@oracle.com>
References: <20240506210408.4760-1-cel@kernel.org>
Content-Language: en-US
From: Dai Ngo <dai.ngo@oracle.com>
In-Reply-To: <20240506210408.4760-1-cel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR05CA0039.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::14) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4257:EE_|SN7PR10MB7103:EE_
X-MS-Office365-Filtering-Correlation-Id: 93c6fd55-dce7-466f-1a46-08dc6e2576dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|376005;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?NGxOSk1vV24wODNZUTZUcDM1NFZyTW1SbE1mT0VFOXpPSmpFN1cwWk4zL24r?=
 =?utf-8?B?MkZ4ZVZNczRXVUV0NWRGTGhGbkhHNDJyYzUzNkE1VHFuRWQyNDRuc0tCQnlT?=
 =?utf-8?B?d0E4V0YvUnpDUHhDTXhpaDE0MFphdkU3U0pMcjVIdnJiKzhSd0ovTmlTc3BL?=
 =?utf-8?B?MFo0cE11Smw4L0pVY0pncU5LTFB4K0pPdzNDRDgxN2UyaTRYeno1REJETlJU?=
 =?utf-8?B?WStlK3N6VGYvcWdYcVZrcldLU1JoUUZHem9rWWlCTGdKSGcxTFVvQUYwMnFX?=
 =?utf-8?B?QW9leXdSb2RwTXZjVE9Tc0VzRk9NdmZOcHRRN3RjUDdreUJaeXdhOWdIY0Yz?=
 =?utf-8?B?MVVsMnNZdTRDWHlnamNVRTNkeUEyNktGMDBla3M4NGRxL1dnOFlNeHIwR0dU?=
 =?utf-8?B?N2hDTElrN1BFVmtwc245T0xUSWJZTlNiclNmSTRySlRsMGhpT3dlQlFFbzIr?=
 =?utf-8?B?SXFSaDA3dWxsdDh4UHZpSlhtY0dMbHRPY1FNaEJJQlR2bFNYaG1LYnRGOWdm?=
 =?utf-8?B?VUk1Y2hVekNwUFhINGtyU2tmc3dEeUtjQXBlcFpuQ0FGVkpja1BNK1V1VUV1?=
 =?utf-8?B?Wm0yQm9XSjJLOUFTQzZ4SUlhWnRGNzU4a1J3RldJY2dKMk41RWp0NlA1Qnhs?=
 =?utf-8?B?eTRuSVQ5SjJ6U1g4RGdDNzd5d0UyNHJuS1U4ck93RTdRcGc1cHFXMUdRajNo?=
 =?utf-8?B?NEZVRmxzcW10UHd0alk5NkllajNyNUh0NHAyVEpaQWxDd29rNzZjZk1yZ2JF?=
 =?utf-8?B?VWpPRFFmZ050b09aWER3ZFhlcE1HT0R4WGs5SmVSbGdublJnVzNqT2gwdklY?=
 =?utf-8?B?UmRmWkV0K0tSTUl2OHhtUFRyMlErdHBpS1FkMFVyYWlpLzVZWkdwQjQ1ZFgw?=
 =?utf-8?B?OFNwalR3cEdUckpvM2JRTS9rNmpMOTRycVBTZDd5cmdaZWEwRkxSbU9SaXFq?=
 =?utf-8?B?RjJKWGx2Rk5XWnRqbmRuSndLZU9nWGZVNVFhS1poMDV1VW5qYS9PaEhxc3lZ?=
 =?utf-8?B?MFptSUJON3BiNjMrSS92VEYwcEJpRzdYSjhVN2FTYVB3UDJFR1BSN1Zyd1Rt?=
 =?utf-8?B?VDJjQ0Z6c28vMi8vU3FqNUZQdm82RG44Tk1ZdDZ3cmkyUG9jbnJFODMvT1ZC?=
 =?utf-8?B?VVgzQXNLd0lPQXBhUE9EREtla0hwK0gyc0M0cFlRQW5kTWxjRkVCRWFSZlBx?=
 =?utf-8?B?T0svbkFaZU5PSmxhZ0QxUHNKQzhPditnU0l2YXNkU0QrMzQ2cTlKbEtUSnpi?=
 =?utf-8?B?MXZZMmhUa3JXL2JCUGtScXdqa2N5c25NdStzUnM0UmZwYnU3KzZ2ZDNlNWFL?=
 =?utf-8?B?c0grbXhsOXJydjhoTHFQZlVMVDdva3FmZXhXb3JFc1l4emtnZ1NKeVJKeXhI?=
 =?utf-8?B?enlNUkF3Q2kvZUFjV1ZhNUJuRWpGS25EanI0K2UyNllYOUQwUk5hQm5yTHh3?=
 =?utf-8?B?MC9HVFlZL0Y4M0FEeVZTSmF6aTJGZ09nMDNvazRFOXozRDJyUVJYMGs1UU93?=
 =?utf-8?B?MkVVakdFck1UdWtkTHVwQmdaRVFZS2ZMc2t5dm03RERDODNlOTVybk1tYTBB?=
 =?utf-8?B?OVhFTDdURENJYmhlaTl6eUdsaVBhVU53dzF6SlZrak9zMGEyZDdGWGFSMnFE?=
 =?utf-8?B?T3g1MndEcjZuTS92SDVlNmtBVTlMQTNWanM0U2pxTm5PVFNuZlFVSXQ4VGlm?=
 =?utf-8?B?OWprZEJLaVAyUmxIQXpETTArZjRTRUZEUmEwYmJRWkNncFVVallkc1hRPT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?SUpsZk8rVVZqdzJsZWNTakhLdlhTY2dwVjBhWXNaSWoyUStVb0hWMU9ZOG5C?=
 =?utf-8?B?RDBubzRqYzRoZ1dVN2R5RFhZWEJTTE9lbHRIVytpZ2lrUWZ4enBVNkJmbjZ2?=
 =?utf-8?B?ZVFvM1RXTEIySi9BM1FuaFQ4TnJQMldXdGpaalQ1NzVnV3EzWnhIcWhmYTlu?=
 =?utf-8?B?aWlkQzlvcXV5NTFHQWZrRFR2TFRZS2QrWFZuRVZzYUpQbzdJWEdmMHZqbUVT?=
 =?utf-8?B?em5NTURQa3A3VWV0ajMxem5RYkFFZWhLSjd0WnVwVS9uV1AwS214eHpadUFS?=
 =?utf-8?B?RzA0cUFYL2lzaTEzS01IQWdOQUhBUVE3QTh6SFNrWkJNelhVUC9EcGRDcVAy?=
 =?utf-8?B?S25yYWQzeGFJY1ppV2UrSDNoWS8xWW1OZWFiQXVxQmVpcXRZc2plWU1MOGpD?=
 =?utf-8?B?QlhvL0k0a1Fsc3M1ZVF2RTVOTWdZTjMvYWFDTzA2UE9nQStFSmFGTWdMRk5F?=
 =?utf-8?B?bTRVOWRQcnVYelozRThZUU1GRklNbVJ5ODFFVUNYT0ZmTVFIYjVyejUyWTVw?=
 =?utf-8?B?NDdaZXlrQk9WVmkvMldpK0RVQnZhQm82a3BZTXNEYmFkYUd1SzdWYmpHSkNq?=
 =?utf-8?B?MDdJR3RoOUdIb0RXdEdiaUU5MWQ4OXdCbnU1TXNKaS9jak1OZEN5QzhuM0Jx?=
 =?utf-8?B?Q1pEN1VnTUxqVzBxUHBJSDFmSUhzdzF2YWJwMWFaaGkycGthc1hjRHovV2Jw?=
 =?utf-8?B?cFhHTHBUVHVBaUNWcDluM2ltTE5DeWdTNm5oRW1TNEMySGFBRkNyQ3lkaFBN?=
 =?utf-8?B?aVAyd3AvWTdFNTAxS2luRHRiTS9xYktCdlFwdExsd1k0cHRHWUk3SmZ1Tk1B?=
 =?utf-8?B?aDU5NnZ6bXFUSVhKeHUzemlGQUZuYlcxKzFsRDVOdzhwTkNqd2UxdWsweDJO?=
 =?utf-8?B?dnV2R2Z2U0xIamNITkZMTi8wUTkzcGpER29ra296bEdrNFROd1BSYzRGVVBy?=
 =?utf-8?B?ZkNxdmVkbWt1ano5bUpsUGpkV2JDQ2hpWmRNb3BiR3FnWTV0dDhROTVTMklp?=
 =?utf-8?B?YngxTkFkR20xS2JueVdiWTBhYXo4eTJkaHRMWlFjZjQyZVlnS1U4YXd3R1JW?=
 =?utf-8?B?cDJ5K1FhMEpvR1AzMm12MVAyb3pYTFhzSEdycUlWYW4vQUk5WUsrRlJ5S1Nl?=
 =?utf-8?B?bTJaSkFQWS9HaGt4a2MwS0Y3LzMxeC94eDJPcTl3aGRoRTNNK3RzcHZCRHNT?=
 =?utf-8?B?ZEk4Q1dLS25LNDhBS0tkMFVIY1Y2YmZ4Zk1nK1g4Q3JEdjhHZTFKVFh5cDZo?=
 =?utf-8?B?eE5tYWtkUW1yUGVvcWIrc2J5b0VvR0p1K1RxNTdOOVVpM2N2aDZpRFRRQnNL?=
 =?utf-8?B?TU05K1JIYkF5RkcxZUsyUHJ3bGsxOVY2dmxUU1lMWGM2eVgrWXpXa0s5ZU5S?=
 =?utf-8?B?aVVpQmJBU0FSQmtxN3kxMXJOcnQ5TlR1cEkvUEQ4MFV1aUJ2a2EwWHpDVk5j?=
 =?utf-8?B?U29tazZGVFZSUXI3eUZIMFZtQ3ZMUE5KejZWOFl1emhQRUt0N0U1ZjRtZDB5?=
 =?utf-8?B?ejRhc2h5MEJIek10M0p6TENhdXRBNEh2WllyczNneEVvQ1dzR29KQ0p6bWtn?=
 =?utf-8?B?Y2pJUkEydkUrV1d0ZTlQbURiRDRBQWl2bk1JMzBRQkRmeWFDaU9aaFEzUStq?=
 =?utf-8?B?a0JxcVg1ZENWd0tjV1NGbXpVQ0ZLOTVLU1E3T05laUhwcW4reEF6THF6Rldz?=
 =?utf-8?B?VUE3K1RQaUNFME9LTzRiVmJOMTcvTjVpK1VYTXhwbk9NVWVvbHNWditwSk5o?=
 =?utf-8?B?OG5YdkhiUE03RFJhVG43Q1huOU9Zc0toS2NqNkZQSENVcUp3ZDhTQ29RNkdK?=
 =?utf-8?B?UEVMUkFrZXRPcHRhLzIyMGs2TXRCWUVhMFZKRHJ2YlBERG5ZdlJqcXhQVW5L?=
 =?utf-8?B?czV4VmVLc1lBc3NlU2lEb2JnZnMwNGFsbHlFNnNWei95N3VZb3pXY1hMTTJN?=
 =?utf-8?B?SDhaSHdUMHhqUklDMHdwaDB1UDNSOStYZkhmdml4S0xpZ0dOb1UxK3ZIMmhO?=
 =?utf-8?B?eFhHa1l4aXdzWUtybXZQdURRY1B3UFlJOGc0MEVaMVFWdXBFcnhreFMrTkVk?=
 =?utf-8?B?MTNIM2hBaGZHemhObXV2OStPSHVpWmZhbHkzaWQ3ZW9oMkwvVE1rT0h6NHky?=
 =?utf-8?Q?TLz25uvL2lpQXHlbLnVUSuzAc?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	OQ0l+80HYhf3uucAlv8pAnQcWzv2LJK79Cb1VBNv93GehroDX8WI18/9uZ62YGI7f9AAbwRfwcgntZKy9oyGNLy93DfbFEVmvpFbiGBRhJRKd8Be6aqe6bqhP4tFxuyL+X69lpE8EwXrv5aXZxCgXDIjeL+Egc8hpCrL9SfJcSFcsfwwS02Gmm45u0WKGSlSpGqCogdzZfbLPc8zaN2qikmJNbZPaBg/DdccrFEoekhY8rzmeZq2G0ZmkqDTEvpDKazItAyggMrfzu61zmSZ8NjzcRjvpcsfFZAPE30ng+GTf0Me3lLJWKjWr9tHg+EXwk5TaoXiiOpO1ImEQlD/hzVA36yQn46PX3MGPhpPWa7BBXdNVy5t18Wn8DuWpw986/xc/e+98KDUHHPMJth/YdnufQlZLVNfrErQ7k7UClQ5QgcQzztwp4GvU6nX8FDyWe4F/gQ+3yCe95bbzMrzbCLa+5D7dPcDySu1Hl2EFQCKASM8bvytVm84kJkMpmjk0ufxkju9QMep/fSsFJ8sGtZdxTk8YiHOYVsk83HyhPZ9NrJuoboCl4XwhSyKA+J4yzIFUVVlRQuv5Fn3ui+8u+kfsZ/4HRqXrz/yOIg+XmU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93c6fd55-dce7-466f-1a46-08dc6e2576dc
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2024 23:37:16.7859
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vNf2evIn5CIec0kV4QhDqiBb+DzWB2z1Tw+nHBLLRBB931Nur8tYIwqFU2Xkk71vGBAbmoUmprX9yZ99MseSjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB7103
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-06_17,2024-05-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 mlxlogscore=999 bulkscore=0 mlxscore=0 adultscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2405060171
X-Proofpoint-GUID: wexCS2MRD47nhVQ7cBg00o5-cZ47973-
X-Proofpoint-ORIG-GUID: wexCS2MRD47nhVQ7cBg00o5-cZ47973-


On 5/6/24 2:04 PM, cel@kernel.org wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
>
> We've discovered that delivering a CB_OFFLOAD operation can be
> unreliable in some pretty unremarkable situations,

Since the fore and back channel use the same connection so I assume
this is not a connection related problem.

Sounds like this is a bug that we should find and fix if possible
instead of work around it. Do you know any scenarios where the
CB_OFFLOAD operation is unreliable?

-Dai

>   and the Linux
> NFS client does not yet support sending an OFFLOAD_STATUS
> operation to probe whether an asynchronous COPY operation has
> finished. On Linux NFS clients, COPY can hang until manually
> interrupted.
>
> I've tried a couple of remedies, but so far the side-effects are
> worse than the disease. For now, force COPY operations to be
> synchronous so that the use of CB_OFFLOAD is avoided entirely.
>
> I have some patches that add an OFFLOAD_STATUS implementation to the
> Linux NFS client, but that is not likely to fix older clients.
>
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>   fs/nfsd/nfs4proc.c | 7 +++++++
>   1 file changed, 7 insertions(+)
>
> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> index ea3cc3e870a7..12722c709cc6 100644
> --- a/fs/nfsd/nfs4proc.c
> +++ b/fs/nfsd/nfs4proc.c
> @@ -1807,6 +1807,13 @@ nfsd4_copy(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>   	__be32 status;
>   	struct nfsd4_copy *async_copy = NULL;
>   
> +	/*
> +	 * Currently, async COPY is not reliable. Force all COPY
> +	 * requests to be synchronous to avoid client application
> +	 * hangs waiting for completion.
> +	 */
> +	nfsd4_copy_set_sync(copy, true);
> +
>   	copy->cp_clp = cstate->clp;
>   	if (nfsd4_ssc_is_inter(copy)) {
>   		trace_nfsd_copy_inter(copy);
>
> base-commit: 939cb14d51a150e3c12ef7a8ce0ba04ce6131bd2

