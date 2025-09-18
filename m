Return-Path: <linux-nfs+bounces-14573-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 264EAB86391
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Sep 2025 19:34:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F516565933
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Sep 2025 17:34:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7774E31960B;
	Thu, 18 Sep 2025 17:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ecG759G3";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Zr+3wUid"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 475E3316187
	for <linux-nfs@vger.kernel.org>; Thu, 18 Sep 2025 17:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758216832; cv=fail; b=AYBvu2VA2sCRSOU71CcgMvn7afKv8mo7O5mKGqLRuEoY1FbC2gMbvql6hQxsOEUikWznDGt7hckq5hScdFOrPjzbpNukAFFM/wbFuLgYRUWYrYw0rFb7HeAYNCPadmnP8AW4W6PhgVSqwDXePsDhmX/Xqwznmg5ooJvHQg2X4vc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758216832; c=relaxed/simple;
	bh=chz+OpE/WTt2gt3+1ZXXfq8aMsjcjdbM189PiK8KRGA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sCNhn/6sGJZDeEpuXki0aRJIlRNbW8s59+pMBlHmSsiBBO6IF19ezRfQ9LdOq56gMi1Ef9E/VODSiLfU/89AyUDjfAWL4aJxC7RiIhfaW6vE5Mjnoc3GAMTwmgtwoSThcSLai0YSJW/mHgWe+sca0euY0exbC9PH1QA0GntGFAo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ecG759G3; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Zr+3wUid; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58IGKXQm029851;
	Thu, 18 Sep 2025 17:33:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=kknn32I+JgP3KYGbQqFctWFguzvaWLrrZAtICHg5jzI=; b=
	ecG759G3Nkg3w6bALMbvyhY/3GyQ2IthURUviwvXVOqkdu+Oco1dRPRxxOcSJxzd
	TB8ILEOxLb0ZbmB8h4H65IM2qp59dZR9JCnErGX2T9D+YZ76HwyZt4UjtKFV52hB
	jxr9cwf0Ue3x33AscoK/fUr0a2xbm+09bRV6DDe6b4hf2rD8NkqQL3gYAJpoQ3Uy
	woRfO9qP+oNQ11QNjRb+kg6E5h7lHSJG1+eoqRTc6egCKA0ebG97z9CPS0t97LCg
	SXC8uEfQzbbow/7u8LCWchcb/cqwd8Vrq0BMM8iLID/xWfkGivEiShbhbrxc7Pf0
	XXYZkYXT6GwseC32JalOkQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 497fx8kvdx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Sep 2025 17:33:38 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58IGddRn027257;
	Thu, 18 Sep 2025 17:33:37 GMT
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11012017.outbound.protection.outlook.com [40.93.195.17])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 494y2nr07d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Sep 2025 17:33:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GtHX0OxhOlxGxTmdzwP0rcBUgqNoOInb3R854PXH8Kma9C3pFLSgm4W7GKEDHRHCaIwrugv6t5emKMBN54EDNoJT0Vy60Anxz4/q6ZvqxP2DJr+f/c3lhRKLnK6+3xza8TpXtf6dGsYeDIyrwXklkv9UlmGwhy2X9Wg3gMYcC8NLb2StV46XpZbGa+JdX6NGrxV2p4uF6rjP5gud41HW7mb9JfRkWsceC3tCxvouw75uDkrvlCi/xxFvVZZ4RtubzfwM365KDViunD2lqeOdM4t9oJLuzpwcMxxQLkqX/AMqq7HtINvHKoYKMrmkItZpjGNMav5oAdZi6U9tI0DmNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kknn32I+JgP3KYGbQqFctWFguzvaWLrrZAtICHg5jzI=;
 b=OXvf8gs3y6GDXSmkBS+rxNytCgl8rrSns9v74CimKmuvUVDm8rzx6tEcsuuYCp26JOwSWjHBmAtnkNp7xyI+doKUQvgEAdNtgNOi+Qi6HBomBDlTzImP7M1tOx+ZMWr7EpnMZoA4B4Qi72bidXnKOzcu+hS1flEx91xbqLCDVYsZRC0vpL8rz9yjW/3NAC9vG2wl9oN4TMNRAD5xnPVo/k/LhOo9hT3PidEZWTnxrL+BZnNSa0Gaju/1JK7Et9Ryxy8szABvAgr5Qg60P05Bt3hiTktX+UEQFm/nQSAWZkkdO8yJGbL4fPwHxBhgDiSHBe3cCLc5mvPbHRbteoFWmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kknn32I+JgP3KYGbQqFctWFguzvaWLrrZAtICHg5jzI=;
 b=Zr+3wUideXmbLO2NdkbN20rh89xif7M/TN54LjXh3DD/sl5k7nc+PixphimCeeR3FzFn/oXrCL2B3io/G/pmuo6CEEsv+4hIl2EWSr+uBqrjYTEm9NejCXQq2XhNFG2lSCRPEUk/D5gt5/X7qeUEiuEI7d/v/Flt7sY9q9/yuA0=
Received: from BY5PR10MB4290.namprd10.prod.outlook.com (2603:10b6:a03:203::15)
 by CH3PR10MB6716.namprd10.prod.outlook.com (2603:10b6:610:146::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.23; Thu, 18 Sep
 2025 17:33:32 +0000
Received: from BY5PR10MB4290.namprd10.prod.outlook.com
 ([fe80::c86a:40f1:7833:ef3c]) by BY5PR10MB4290.namprd10.prod.outlook.com
 ([fe80::c86a:40f1:7833:ef3c%3]) with mapi id 15.20.9137.012; Thu, 18 Sep 2025
 17:33:32 +0000
Message-ID: <23118649-3dc6-443b-beb7-9360199e93e3@oracle.com>
Date: Thu, 18 Sep 2025 13:33:30 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 6/7] nfs/localio: add tracepoints for misaligned DIO
 READ and WRITE support
To: Mike Snitzer <snitzer@kernel.org>, Anna Schumaker <anna@kernel.org>
Cc: Trond Myklebust <trond.myklebust@hammerspace.com>,
        linux-nfs@vger.kernel.org
References: <20250917181843.33865-1-snitzer@kernel.org>
 <20250917181843.33865-7-snitzer@kernel.org>
Content-Language: en-US
From: Anna Schumaker <anna.schumaker@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20250917181843.33865-7-snitzer@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR04CA0101.namprd04.prod.outlook.com
 (2603:10b6:610:75::16) To BY5PR10MB4290.namprd10.prod.outlook.com
 (2603:10b6:a03:203::15)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4290:EE_|CH3PR10MB6716:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a7d4fcd-1aff-4bef-56ed-08ddf6d97d26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VmJTU0hmbFNPeXJyS1JIUERpYnB4aEloK1cyWlljVTl1ZjB3MGRHUTQ3Y2Nq?=
 =?utf-8?B?ZENpSkFCMUlrWmlJR01kVmQyNEJmQVlXaUVSRi9WTFYralNLclNOOGI1ZHF0?=
 =?utf-8?B?SWdQd001Z1J0VnNkSlFrR1N0dlJZRFNwQ1ZKMDk4Y0NvZzZSTkh3Z3ZwTjJt?=
 =?utf-8?B?MXhHOWM4Q1FZTGZGT3RkdUFMb3h6U3NIUnBvK0R1TmorZXFSZzlFLytQeXlh?=
 =?utf-8?B?b3JwY2ZHNnkxUy9qQW9VNW96UzJZNjJNdXBORlZsNTN1YVF1MlgrMzFTVGVX?=
 =?utf-8?B?OTB4aDJKNGRqWnpSOEdFMnlNMEtraHNBWk9STXlWMWJvbkttN3JsK1AzZnZO?=
 =?utf-8?B?NXlScjBYWWxWajIrODBrTVNmNW1sU3YvWkJPZWZFS3pJeXRkak9zRDZQcmNt?=
 =?utf-8?B?STMwalIyN3VJOERpZmgrOWE4cktjRndmVlI0ejJEaHJoVHIvb0tWTTdIdHVz?=
 =?utf-8?B?MWV4VmNrcTI2dTBJTmxHbE16YVZlc0c3d0pBVGg5RVg0MnpoQ1o1Q2Mzamww?=
 =?utf-8?B?dDZRdUlrZVM3YlVrMmh3d3FMM3Jpa01DeWYyTi94ZjlRdmk0MVgySS9WajlD?=
 =?utf-8?B?cmhFbG1zYkNkc1duVVdLTlZpVEQ5ZERqdjNQSVBlWVh5M2ZGd0hPb1krbGxN?=
 =?utf-8?B?My9DMGp4UFdJb05oRCs1dzQyeDEwUUVHZnNLblF4Tzc2UDhQNVdTSzdyaGJZ?=
 =?utf-8?B?SVJ3VXNvRUVaQk9iaUhXZ0EzQ3VhWWxmQW52am9sZysvVDMzVndpNkYzWWNS?=
 =?utf-8?B?U09QTklQT2FLSXVMVTRGeWJrQjhIR3VLRVMzc0tCT1QzZjJrVmJ1U1RSWkRJ?=
 =?utf-8?B?Nnhoc3dSZHlmd1VxMkVLM0g5M3BTQlFUeDNYYUdkdFNHTXFQUnRTZjlGNStN?=
 =?utf-8?B?MnhHRzcwbys1TXllYU9XeHB6Y2ZYaWFlczlkdkVpK05iVnRZV1JNOGExcE1V?=
 =?utf-8?B?TlhlM1pNbGk2TUx2bUp2MERMWGxTZzViVG5WMHN6TVdLazhxRFdtMXl1bDgx?=
 =?utf-8?B?ZzNBalM3a2EvblVrTmtJMWFNR1VIWnR5UlFCVGFQZHErc2JoUDFHenNDdG1h?=
 =?utf-8?B?OG9kQk5Sc0x0UTB5eWZDTEc2Zmg1RE9DOWZVUDdxYzQzbmtzSEI3S1FDMFkz?=
 =?utf-8?B?MkVsajVTNEZSa0hXcjlwQVljeUlMaVhjb1JhQ1JGUDFOVG03TXM0RFJHTk1n?=
 =?utf-8?B?YVI3MXRzMG0yeEVYdEM3eTdBTVVwQlVYUy9LaUo4bFBGeGtJbUs1dDVGYzNh?=
 =?utf-8?B?YVJ4dVB4UGtRR3ZCOW1TWkkxak11YXpnQWZrMmVMTmtNRDI0bkxLTEJLT2JR?=
 =?utf-8?B?UlB6WUw1bmlOMVRtNFRuOGNuNWpZRlBRZDNhS3JZMWcvZU1TV2N2ZHUvT2JC?=
 =?utf-8?B?ZFpsWWEwQXRoaVFVTjdQbHU2T25Tdno3aWp6VHgwNDhrTVBtRm9OUy9WVXBp?=
 =?utf-8?B?OTlhWmxLUEY1YmZtUU9DT1VOanlyNW5YQlg3WWYwaWM5c29GMW9zSDM1R2wx?=
 =?utf-8?B?MTV4OTZwYjdPMDhRQ0JuOExSNnRZMThZSEgxTnpjdGIxOE1vNng4UU1jZUJ6?=
 =?utf-8?B?SkNOUmF1U2d3MnBlenREc2RYTmRSY0hVRllwOWhQK3piTmNFOTI1bDVLZG1N?=
 =?utf-8?B?eHhEcy9NSHYzOGdkYkpuNlBMTUs2OXE5T2hnQXNrKzIxWU1OVEZyblA5K05u?=
 =?utf-8?B?bWlXTFJQcWhjbkt5UU5MaTB5SVpkUzFNUXRBM1F5RUpJb0F6UzRhNmFZRFN4?=
 =?utf-8?B?Mm1ZcXdxVWNMcW1ObFAzQ0lPYVNiTldaSnFQVlZvUFIwNncyZlQwQlBabHZW?=
 =?utf-8?B?TjV2Y0N3K2tBajN5ZkszR0lnWEJ4d1g3TFdyZ2taQXFCK0U3cGdXYTQ0NGNC?=
 =?utf-8?B?R291ZWYzN0tJQUxaNHU3WDhwSGtUTXRPcGxoTlRua3Y0Y2c9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4290.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cDUrcFkyQTJ4MVJkNzV4RmsySGhWOC9pLzB5WWM5Ym9XazBsZVo1enA0Y25Z?=
 =?utf-8?B?c2NUcTAzWUl6M25EemZDVDVTQU5MMjl4Z0pmYy8rMmIyQVdZV29TSENxcVE3?=
 =?utf-8?B?cUtuYXpiU3Y3SDJNSmdtWU9UTWo2bStBU29zclFDNE1TM0ZGNlUycm5RSTd4?=
 =?utf-8?B?UWEwT1Yzd0tqL2ppK3U0aDdFZGxWRFFqSEtkR3ZCV2hzMEh2WUhyVTd4M3pz?=
 =?utf-8?B?SVdCdVlHNWRKbTdybktUeitPSnN0ZjhhTDVEZzMxYkxaQjVZRkh2dmtKNjZ2?=
 =?utf-8?B?akUrTUpwRlNrYUxiODlTNFF0dnRsZ2JtTnNnc2t2Q3JUbWhVOXZLNVpjbExP?=
 =?utf-8?B?VXltS2xva3IyQmNFS1RkSDkvZDNQdlVabjNjMFJwcDJhR1Zrc00rYjV6aXBJ?=
 =?utf-8?B?MGxnQlhzYkpiN3ZuQkh1QTBWVjM2QmtLWDA4QlR5RzZoMXVKaFprWHM1WGZj?=
 =?utf-8?B?YkRLUkFJazlTM0VDeHNRRm5XRGdKVjBRUUtIck1kQ0hvSmJnNTF0WTI2K0Fw?=
 =?utf-8?B?SXJ5ckhhY0RQMDNYVEdORURSaXE0UENrQ1FJbEtvQVRydjZPK2lZMHVtZkhi?=
 =?utf-8?B?cXlZN21zNEJ2ZFBjamszRHRhWElNSFJLSS9vL0RBbzFOV0RHZWVGblN0emp1?=
 =?utf-8?B?VUZ6ODE2OGgrKzdEL3BiU3NiRkFvbThZQ3hDNnhEWEw5bGpTS3dDQ3k5Y2dH?=
 =?utf-8?B?NGljQ1h2WDB2ZWJwQ0VCVkhFV2hyV2hqaVBCclJlak1MbDhiMWRweVIxNFFH?=
 =?utf-8?B?aXVhd0VNUDVuWmR0bGdibWRzOXppY1JIOFBiTEtNUGp6c295ZmdPMlpQeXVP?=
 =?utf-8?B?YWRxeGd3azF6bFB0TGhIcTFSYjFLVjNERjV1RTgvVTVqa3R3a0gwS2xDOXlY?=
 =?utf-8?B?RGcxWVRtRDdmV3JUQlR6MzFLaDdXamt0WmdUVEtLMnZmUmVqSzNRV3R2czZN?=
 =?utf-8?B?TWIvV0JkdjRTQXJRQkNaQWVaU211S2FWd0FoMTNFYnJnTERCZC9WZEcvTG9P?=
 =?utf-8?B?RDlLRWY5UWJvcDJ6dnBUOW02SDFtbGYveEtZS3YxcklKZm0xVU02a0dSaDVs?=
 =?utf-8?B?RktObzhIT2p3WGtMakJ4d0JoQVR1bnZoUEV1aG9sOUxnL01rZmtob1RIdHQ0?=
 =?utf-8?B?eXE1dERGQlNVcStqMDhEOXpCcjdVclgxenBJUkR4cTNvYmcrQ0xaaHdiMTNH?=
 =?utf-8?B?OGduWlEzVUEyOGI0RmxPajBtRWx1Q0xkQ1VtcjdCRmgwejhWQVMzNFYyY1BR?=
 =?utf-8?B?MUtwSE1JeWxLMkpqN2ZURVlid0w4R1ZuakJpby8vQWpSeElwMVVJVmMzTmRP?=
 =?utf-8?B?Rklnb2ZNSnFwUFMrTEs3MUgvMmlTeDVuZkF5SzB3RThjUjRYTDNPR0VpRnM0?=
 =?utf-8?B?L1krOGprSkd3VVZxdmcvZnJCWXJNLzBTNW0vb1VKenFLSUVUSlRwZVA0b0sv?=
 =?utf-8?B?Z2kxOUxiVnc5bjN2eXFST01sSVNjYWxEdnlub3NGWlhGc3AxT0VIU2pRQU1z?=
 =?utf-8?B?Y3dkN1lRT2pCamxLSWovMVdEd0ptcmtocTlRVVh6ZElxczVSSnVuWGlNeWds?=
 =?utf-8?B?dndiQ2Z4L2lpNG5OelJ2OUJKZmE3V0FHa1pxK01Rd1NtR3dPbCt0d1JhczBq?=
 =?utf-8?B?b05iRTk3QWJhaHhFRnNLQVRCQXk4VFhGSy9hbkRQTmhuYlZ2WHNDYk9Ja2JR?=
 =?utf-8?B?b09meldZQ0dadHJrUTIzeEJiY3ZKYndRbUgrZnpybjQ1Ym1uR1l3VVRUNXN4?=
 =?utf-8?B?OXZlSkJPcWZOM2ZkejVhc1hqRlY3Ukh4bm03ZWRoenpNL1N4b0lZeDBnZ3VX?=
 =?utf-8?B?aDd3TmRiYWplUzk1Rk1PdnBlemhIMXk3M0puWVVRcmpYMWYvQ1o5S1RIcHVv?=
 =?utf-8?B?V2NvbFVna1l1YzdvbTBFYy9XejVrN1UzUHAydWx0Rm9qMHpaS09YWTZzeXZH?=
 =?utf-8?B?SGViUVZNdk15bjZZejlDZWpPbWYzWGlieWJwVENYei9DMGNTVFhMdUUzWXdl?=
 =?utf-8?B?dlVrZDl4TUVIc1ZrdnBxTjU5dkFRNG1IMVcvTUhrb0RTc3JGR3ExZlAxOEdv?=
 =?utf-8?B?UG9jWEI2c2JGeTNYR1ZPU3lERlE5VUV1YkVMZmZzVW0yRUJSQzYrY2NzUUlF?=
 =?utf-8?B?NDkzbXEyWE9VVE5IR01mSDZPcGUwTWUxd3ArUzRiSXVCS29CMTFObnBxeUFY?=
 =?utf-8?B?U1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	2DTPTuyZftGb8RT5akPsBm/vSuUxu8iy52hUuelp8aqfCDSEAOlKoowrc96FZemPc6aoMNJ910FHNwlQMTi2NV69K76Mb8HN9qH0E/1VroIQI1/XJ5m4fW2m7s7bwnSHlu0zCaqgbNR6SfimecCQXeJFFtd5xxBN9UjMSCuVc5JFBk2gOSAaXtbsG8hJyKVHp+1EmJaW0vRhAmVKSxyuAlkw7+ipn4SLBdQa9EvCgdvVw0Ee3t8wYztYJz0SYk2Y051x7B4xb6PKOoIvbcVvon1cZyMO4f+jK6DrMEWYr2HTEJwInz0Q2/Rs5sQuwCZzpRVerkOg2am3ArT1+Mk8cFFRgOC2sF31cAfK11hf4pTMfUbkel92llXtNfaC7ukRIv+Tk8UwQXdW+9aoflMj9SieivnYFhNjLgDGnGL8UZwXCjVay6PU/QUSDYWsQ107KQNBdSY3nKgAmEtojPtjmJZe7vyXHzkF8mnQlclsZsKqJJOtHvghOzJa1RjOEzesX+YcxqGk2XpTyJPNrS6Agd1npEyCDn0DAWkKCLY4eTcxms0YvQh1tfey38z2ID1uEbuED8ekZDTpLgX1rLG7lpmDgBqcWBEATvbD0a1qAVo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a7d4fcd-1aff-4bef-56ed-08ddf6d97d26
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4290.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 17:33:32.7389
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wP5Y3OJvCOk7/+VUabfbhJTmEi6Z7HyCt5Yeaq3w48rItp3C15KXjeXIqJJiDs3TyY3UO9CeaW0MCW9ytxbmqXJDtoQa1G/V4VgU1M1uL5U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6716
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-18_02,2025-09-18_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0
 mlxlogscore=999 suspectscore=0 malwarescore=0 spamscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2509180155
X-Authority-Analysis: v=2.4 cv=JNU7s9Kb c=1 sm=1 tr=0 ts=68cc4272 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=JK0ICHbpONilo9J_Oq4A:9
 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12083
X-Proofpoint-ORIG-GUID: wggB6eFumtCbL0U5YK0vhZCa58qf7X_d
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfXxb8xAksGBUtN
 JDT3fnsJJF7jAq9OADwC+I33zh31+AE6TkAtynxpAJ3nyWX8S7LqnKj3naLFsVnpGMrDPI+y/wX
 OWidNfZS0Xkci4KwGweV9aee+VlURcQtCzi2z8vVfoQZYx5lOHVjbmLSrQihyxkmoex8x+mArih
 1OO1VPVwim9maCBRn5QLvSR/Y3xIhv7BLv6OnN8BR+oAZ6px+xvh+A3d1CnvBvVarykoK8j4NUQ
 ndEKCH1G2zYCJt6zdtwf2xLF4Gu1faDnBeLplx1QGhEJs+x3x98UlTwiF0H9U3cXNfQQTH4ES8+
 q41p95wvORFOk32UVQVJsh2jIHMn6aRast+w5neewvqqAzQekV+Oc4h90C+G9JOUGdgYx7g5wOp
 augj86T9EqG4w/EjtTbdZNYDm+i9qA==
X-Proofpoint-GUID: wggB6eFumtCbL0U5YK0vhZCa58qf7X_d

Hi Mike,

On 9/17/25 2:18 PM, Mike Snitzer wrote:
> Add nfs_local_dio_class and use it to create nfs_local_dio_read,
> nfs_local_dio_write and nfs_local_dio_misaligned trace events.
> 
> These trace events show how NFS LOCALIO splits a given misaligned
> IO into a mix of misaligned head and/or tail extents and a DIO-aligned
> middle extent.  The misaligned head and/or tail extents are issued
> using buffered IO and the DIO-aligned middle is issued using O_DIRECT.
> 
> This combination of trace events is useful for LOCALIO DIO READs:
> 
>   echo 1 > /sys/kernel/tracing/events/nfs/nfs_local_dio_read/enable
>   echo 1 > /sys/kernel/tracing/events/nfs/nfs_local_dio_misaligned/enable
>   echo 1 > /sys/kernel/tracing/events/nfs/nfs_initiate_read/enable
>   echo 1 > /sys/kernel/tracing/events/nfs/nfs_readpage_done/enable
>   echo 1 > /sys/kernel/tracing/events/xfs/xfs_file_direct_read/enable
> 
> This combination of trace events is useful for LOCALIO DIO WRITEs:
> 
>   echo 1 > /sys/kernel/tracing/events/nfs/nfs_local_dio_write/enable
>   echo 1 > /sys/kernel/tracing/events/nfs/nfs_local_dio_misaligned/enable
>   echo 1 > /sys/kernel/tracing/events/nfs/nfs_initiate_write/enable
>   echo 1 > /sys/kernel/tracing/events/nfs/nfs_writeback_done/enable
>   echo 1 > /sys/kernel/tracing/events/xfs/xfs_file_direct_write/enable

I'm having a lot of trouble compiling this patch. I'm seeing errors like this:


fs/nfs/nfstrace.h:1800:1: error: declaration of 'struct nfs_local_dio' will not be visible outside of this function [-Werror,-Wvisibility]
 1800 | DEFINE_NFS_LOCAL_DIO_EVENT(write);
      | ^
fs/nfs/nfstrace.h:1796:17: note: expanded from macro 'DEFINE_NFS_LOCAL_DIO_EVENT'
 1796 |                  const struct nfs_local_dio *local_dio),\
      |                               ^
fs/nfs/nfstrace.h:1800:1: error: declaration of 'struct nfs_local_dio' will not be visible outside of this function [-Werror,-Wvisibility]
fs/nfs/nfstrace.h:1796:17: note: expanded from macro 'DEFINE_NFS_LOCAL_DIO_EVENT'
 1796 |                  const struct nfs_local_dio *local_dio),\
      |                               ^
fs/nfs/nfstrace.h:1800:1: error: declaration of 'struct nfs_local_dio' will not be visible outside of this function [-Werror,-Wvisibility]
fs/nfs/nfstrace.h:1796:17: note: expanded from macro 'DEFINE_NFS_LOCAL_DIO_EVENT'
 1796 |                  const struct nfs_local_dio *local_dio),\
      |                               ^
fs/nfs/nfstrace.h:1800:1: error: declaration of 'struct nfs_local_dio' will not be visible outside of this function [-Werror,-Wvisibility]
fs/nfs/nfstrace.h:1796:17: note: expanded from macro 'DEFINE_NFS_LOCAL_DIO_EVENT'
 1796 |                  const struct nfs_local_dio *local_dio),\
      |                               ^
fs/nfs/nfstrace.h:1800:1: error: declaration of 'struct nfs_local_dio' will not be visible outside of this function [-Werror,-Wvisibility]
fs/nfs/nfstrace.h:1796:17: note: expanded from macro 'DEFINE_NFS_LOCAL_DIO_EVENT'
 1796 |                  const struct nfs_local_dio *local_dio),\
      |                               ^
fs/nfs/nfstrace.h:1800:1: error: declaration of 'struct nfs_local_dio' will not be visible outside of this function [-Werror,-Wvisibility]
fs/nfs/nfstrace.h:1796:17: note: expanded from macro 'DEFINE_NFS_LOCAL_DIO_EVENT'
 1796 |                  const struct nfs_local_dio *local_dio),\
      |                               ^
fs/nfs/nfstrace.h:1800:1: error: declaration of 'struct nfs_local_dio' will not be visible outside of this function [-Werror,-Wvisibility]
fs/nfs/nfstrace.h:1796:17: note: expanded from macro 'DEFINE_NFS_LOCAL_DIO_EVENT'
 1796 |                  const struct nfs_local_dio *local_dio),\
      |                               ^
fs/nfs/nfstrace.h:1800:1: error: incompatible pointer types passing 'const struct nfs_local_dio *' to parameter of type 'const struct nfs_local_dio *' [-Werror,-Wincompatible-pointer-types]
 1800 | DEFINE_NFS_LOCAL_DIO_EVENT(write);


Am I missing a patch somewhere along the line?

Thanks,
Anna

> 
> Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> ---
>  fs/nfs/internal.h | 10 +++++++
>  fs/nfs/localio.c  | 19 ++++++-------
>  fs/nfs/nfs3xdr.c  |  2 +-
>  fs/nfs/nfstrace.h | 70 +++++++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 89 insertions(+), 12 deletions(-)
> 
> diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
> index d44233cfd7949..3d380c45b5ef3 100644
> --- a/fs/nfs/internal.h
> +++ b/fs/nfs/internal.h
> @@ -456,6 +456,16 @@ extern int nfs_wait_bit_killable(struct wait_bit_key *key, int mode);
>  
>  #if IS_ENABLED(CONFIG_NFS_LOCALIO)
>  /* localio.c */
> +struct nfs_local_dio {
> +	u32 mem_align;
> +	u32 offset_align;
> +	loff_t middle_offset;
> +	loff_t end_offset;
> +	ssize_t	start_len;	/* Length for misaligned first extent */
> +	ssize_t	middle_len;	/* Length for DIO-aligned middle extent */
> +	ssize_t	end_len;	/* Length for misaligned last extent */
> +};
> +
>  extern void nfs_local_probe_async(struct nfs_client *);
>  extern void nfs_local_probe_async_work(struct work_struct *);
>  extern struct nfsd_file *nfs_local_open_fh(struct nfs_client *,
> diff --git a/fs/nfs/localio.c b/fs/nfs/localio.c
> index 768af570183af..cf1533759646e 100644
> --- a/fs/nfs/localio.c
> +++ b/fs/nfs/localio.c
> @@ -322,16 +322,6 @@ nfs_local_iocb_alloc(struct nfs_pgio_header *hdr,
>  	return iocb;
>  }
>  
> -struct nfs_local_dio {
> -	u32 mem_align;
> -	u32 offset_align;
> -	loff_t middle_offset;
> -	loff_t end_offset;
> -	ssize_t	start_len;	/* Length for misaligned first extent */
> -	ssize_t	middle_len;	/* Length for DIO-aligned middle extent */
> -	ssize_t	end_len;	/* Length for misaligned last extent */
> -};
> -
>  static bool
>  nfs_is_local_dio_possible(struct nfs_local_kiocb *iocb, int rw,
>  			  size_t len, struct nfs_local_dio *local_dio)
> @@ -367,6 +357,10 @@ nfs_is_local_dio_possible(struct nfs_local_kiocb *iocb, int rw,
>  	local_dio->middle_len = middle_end - start_end;
>  	local_dio->end_len = orig_end - middle_end;
>  
> +	if (rw == ITER_DEST)
> +		trace_nfs_local_dio_read(hdr->inode, offset, len, local_dio);
> +	else
> +		trace_nfs_local_dio_write(hdr->inode, offset, len, local_dio);
>  	return true;
>  }
>  
> @@ -446,8 +440,11 @@ nfs_local_iters_setup_dio(struct nfs_local_kiocb *iocb, int rw,
>  		nfs_iov_iter_aligned_bvec(&iters[n_iters],
>  			local_dio->mem_align-1, local_dio->offset_align-1);
>  
> -	if (unlikely(!iocb->iter_is_dio_aligned[n_iters]))
> +	if (unlikely(!iocb->iter_is_dio_aligned[n_iters])) {
> +		trace_nfs_local_dio_misaligned(iocb->hdr->inode,
> +			iocb->hdr->args.offset, len, local_dio);
>  		return 0; /* no DIO-aligned IO possible */
> +	}
>  	++n_iters;
>  
>  	iocb->n_iters = n_iters;
> diff --git a/fs/nfs/nfs3xdr.c b/fs/nfs/nfs3xdr.c
> index 4ae01c10b7e28..e17d729084125 100644
> --- a/fs/nfs/nfs3xdr.c
> +++ b/fs/nfs/nfs3xdr.c
> @@ -23,8 +23,8 @@
>  #include <linux/nfsacl.h>
>  #include <linux/nfs_common.h>
>  
> -#include "nfstrace.h"
>  #include "internal.h"
> +#include "nfstrace.h"
>  
>  #define NFSDBG_FACILITY		NFSDBG_XDR
>  
> diff --git a/fs/nfs/nfstrace.h b/fs/nfs/nfstrace.h
> index d5949da8c2e5d..132c1b87fa3eb 100644
> --- a/fs/nfs/nfstrace.h
> +++ b/fs/nfs/nfstrace.h
> @@ -1599,6 +1599,76 @@ DEFINE_NFS_DIRECT_REQ_EVENT(nfs_direct_write_completion);
>  DEFINE_NFS_DIRECT_REQ_EVENT(nfs_direct_write_schedule_iovec);
>  DEFINE_NFS_DIRECT_REQ_EVENT(nfs_direct_write_reschedule_io);
>  
> +#if IS_ENABLED(CONFIG_NFS_LOCALIO)
> +
> +DECLARE_EVENT_CLASS(nfs_local_dio_class,
> +	TP_PROTO(
> +		const struct inode *inode,
> +		loff_t offset,
> +		ssize_t count,
> +		const struct nfs_local_dio *local_dio
> +	),
> +	TP_ARGS(inode, offset, count, local_dio),
> +	TP_STRUCT__entry(
> +		__field(dev_t, dev)
> +		__field(u64, fileid)
> +		__field(u32, fhandle)
> +		__field(loff_t, offset)
> +		__field(ssize_t, count)
> +		__field(u32, mem_align)
> +		__field(u32, offset_align)
> +		__field(loff_t, start)
> +		__field(ssize_t, start_len)
> +		__field(loff_t, middle)
> +		__field(ssize_t, middle_len)
> +		__field(loff_t, end)
> +		__field(ssize_t, end_len)
> +	),
> +	TP_fast_assign(
> +		const struct nfs_inode *nfsi = NFS_I(inode);
> +		const struct nfs_fh *fh = &nfsi->fh;
> +
> +		__entry->dev = inode->i_sb->s_dev;
> +		__entry->fileid = nfsi->fileid;
> +		__entry->fhandle = nfs_fhandle_hash(fh);
> +		__entry->offset = offset;
> +		__entry->count = count;
> +		__entry->mem_align = local_dio->mem_align;
> +		__entry->offset_align = local_dio->offset_align;
> +		__entry->start = offset;
> +		__entry->start_len = local_dio->start_len;
> +		__entry->middle = local_dio->middle_offset;
> +		__entry->middle_len = local_dio->middle_len;
> +		__entry->end = local_dio->end_offset;
> +		__entry->end_len = local_dio->end_len;
> +	),
> +	TP_printk("fileid=%02x:%02x:%llu fhandle=0x%08x "
> +		  "offset=%lld count=%zd "
> +		  "mem_align=%u offset_align=%u "
> +		  "start=%llu+%zd middle=%llu+%zd end=%llu+%zd",
> +		  MAJOR(__entry->dev), MINOR(__entry->dev),
> +		  (unsigned long long)__entry->fileid,
> +		  __entry->fhandle, __entry->offset, __entry->count,
> +		  __entry->mem_align, __entry->offset_align,
> +		  __entry->start, __entry->start_len,
> +		  __entry->middle, __entry->middle_len,
> +		  __entry->end, __entry->end_len)
> +)
> +
> +#define DEFINE_NFS_LOCAL_DIO_EVENT(name)		\
> +DEFINE_EVENT(nfs_local_dio_class, nfs_local_dio_##name,	\
> +	TP_PROTO(const struct inode *inode,		\
> +		 loff_t offset,				\
> +		 ssize_t count,				\
> +		 const struct nfs_local_dio *local_dio),\
> +	TP_ARGS(inode, offset, count, local_dio))
> +
> +DEFINE_NFS_LOCAL_DIO_EVENT(read);
> +DEFINE_NFS_LOCAL_DIO_EVENT(write);
> +DEFINE_NFS_LOCAL_DIO_EVENT(misaligned);
> +
> +#endif /* CONFIG_NFS_LOCALIO */
> +
>  TRACE_EVENT(nfs_fh_to_dentry,
>  		TP_PROTO(
>  			const struct super_block *sb,


