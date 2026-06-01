Return-Path: <linux-nfs+bounces-22168-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EMj5FJCbHWpucgkAu9opvQ
	(envelope-from <linux-nfs+bounces-22168-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 01 Jun 2026 16:47:44 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A49B6621227
	for <lists+linux-nfs@lfdr.de>; Mon, 01 Jun 2026 16:47:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4A51A3025298
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Jun 2026 14:42:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F52E37CD34;
	Mon,  1 Jun 2026 14:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hXeh2/dc";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="LcqSlRmX"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBA3435AC10;
	Mon,  1 Jun 2026 14:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780324926; cv=fail; b=QRo9GscIdF3NtiBIJQejzovXzkTFcqG2240js9UA0AX60O2m0l7daZZ82IwsWJqEVkn1CW+pCJ2qIZfGJLKuaFP3gEum1aBKNZm7/+GTCi6BB+l0+aVuqz7paTPdJ7GBO8IJofojONjco0jpzqJy7t/e9ooFK3wwsriUts8BhC4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780324926; c=relaxed/simple;
	bh=CySfFPlRQTiBSHYCZ4kPPXFJqJK6qwQ3oBHQ4YGF4CU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PNp6HSld1kv44+Hgs5Rhexx39oLb80WopONtOT4isnR0KEYgM1G4wbKcbA99pyvxyG+wW/0n/17lmUsgbLuCSsKad3DhrRGxi8z4FmbEU3JI8eUL1aXAwup/ORNVdzQyijZ/UlKovNAV1zOSIJoETLNeaH/Y7NcqIg3z7dmDrkY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=hXeh2/dc; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=LcqSlRmX; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6514QRmw2820807;
	Mon, 1 Jun 2026 14:41:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=2CG6K0W4FIaCinLozZLsWlp19XaDobcYTKeJ3a2InoY=; b=
	hXeh2/dcsKKxFlzceav7WOzkDlNR5bc3ZaFo+5N6uvCv2HNuM4Pz3J8oRilye+M3
	I+ZkChcPUtENHk+YRkaRaPBn5VVvpWah5/u/bp/NNzBChY1USug+Tqz9fiHZfjMe
	RF11lFfsqLcxzZvRoZT4y4o3YxvOA+E98cbMWLRp8FUbEzZo39Yb//jaxXc7idPQ
	OPs1ygyA3u+ttXAbTt/k2PFyUkOPIjmx4a9AcrGGiVslOTSBU+fsDojFyfcKmgo/
	82jvtGi0/ckBn96jgXBcWFg8FrcuOVOxlt+5OmnpB5cAsU/nkXGCQpt6h9eECWwd
	Rlnp6AjCR86PMWpDS0K4kA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4efqs6jakc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 01 Jun 2026 14:41:51 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 651Edtmi006240;
	Mon, 1 Jun 2026 14:41:50 GMT
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010002.outbound.protection.outlook.com [52.101.56.2])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4efpbbhu3c-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 01 Jun 2026 14:41:50 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NNrLqL0Mq8WIwu6ZeSK5kcyhFXGgCYoIHyPw1WL/ZiiQ54tC7cmFQZtWl40EfIj8IeyLls7lYQQ9nI6cPS7ErdaOeAOwHTAUrYCvgVxu1dgcAn6g7y039FEE7kTpjjNqdVvYWIKlWW+p5zcoO59EdjqoXun9hI8eyJk9OyfwuQ2ptQxo8d/nXyg4Nt28q19t2yQjkmkO/ld6ZsxZMvfdxyFwqVI++9J2NTmg12qjVv72dMbyb+A/8xS1Fkl/67d3iRcnPU6CPy1fp+ct5/i8Pn2PauC/WrhWvzubi+cq3B0I6kxSUYnVX1fhNfc2YWc/MfaXU5CSjKo5KIdZsf6rqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2CG6K0W4FIaCinLozZLsWlp19XaDobcYTKeJ3a2InoY=;
 b=b+zRkUIXbXaT/LQBO1Fiv0Cfde7cQRe8bV9OxOmJssYRdu7xb0e31ayufHHNFJiPgJvCg9bzgwXVwzbudC+hGYV2unKOpMHYFSVUt2EErlthGVr8ve0zg4e27OxTGh+qjbdaaWa3/ylDz8sAN9t18gMsScPZMJvtvuS6bzhOfuYyzOoOWpuWH81STuXw3V8cSL1ssxUW/opYnRcZJ5OYeUn1SPPrIsvZndd4dF8QDDAr1OSt6meuVqIPVKye5k9NaeZOuWGWGV+oT8M+Q0xqm+2rKrUXwvz7jfAn2rnWCJiQHHcYadEEXfSpbrl9lp0HXKPnsD+r/NdXPHgyku+Q4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2CG6K0W4FIaCinLozZLsWlp19XaDobcYTKeJ3a2InoY=;
 b=LcqSlRmXwPV8qo6DUbxTGs3C3EmmPSnT64B1Vy87iWFVswnEu+yF+NR5/oPfBtpti4h1X+I87L1G3HnxmPiTEbrEkTTzTeHjO0QZFlfHVpMtRHIszDlRhTA7X9gJm7w6p56FOJleyMJseAeQy/tdVL9Uv/EFRz1gF/sEbDx38WY=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH0PR10MB5869.namprd10.prod.outlook.com (2603:10b6:510:14b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.16; Mon, 1 Jun 2026
 14:41:46 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::4083:91ab:47a4:f244]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::4083:91ab:47a4:f244%3]) with mapi id 15.21.0071.014; Mon, 1 Jun 2026
 14:41:45 +0000
Message-ID: <a53a1a3e-d7df-45a7-a3ba-8946d2570ba7@oracle.com>
Date: Mon, 1 Jun 2026 07:41:43 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] nfsd: release OPEN-decoded posix ACLs via op_release
To: Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>
Cc: Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>, Rick Macklem <rmacklem@uoguelph.ca>,
        Chris Mason <clm@meta.com>, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260531-nfsd-testing-v2-1-e13e6355fc07@kernel.org>
 <178027597098.2923901.17316619429004997151@noble.neil.brown.name>
 <6924de18c6fd50d61e39b426bcfdce7617ce2976.camel@kernel.org>
From: Chuck Lever <chuck.lever@oracle.com>
Content-Language: en-US
In-Reply-To: <6924de18c6fd50d61e39b426bcfdce7617ce2976.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0004.namprd03.prod.outlook.com
 (2603:10b6:303:8f::9) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|PH0PR10MB5869:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d43ca7a-afa5-41b3-5576-08debfebe794
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|18002099003|22082099003|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info:
 h4cpvFznonE0xHVuEiWBJfn0Fo6eIkg0xxlnDIcK/42w8/t6dGjPf1/Ucgui1eWAhpogL0/pfR3pE6fCKLENl6l+TqguOQz05vvPy5UgjwuHd0t6/nDqHh9MtcBOvSNKhGP14Z809xCkAqEH7LATA6QwbUDJMqMWe6Iaz/8IEic0g7CZzCa0+5tJD0rSOtdHVdEl/s/yW3nREJ1viBkN5g/G4dS6ul3rs7CGc0K4BWwTLuNKoXDbgfCxkFDhkY1COg2Dd2+6QFvLCsSaQixIv5IkrHUhvZM0IlquCjF+8hVbCbqi24wBbXXnO1427FPkp0o2frOGE6wU/9t9oDScmnyTC1qS12QORoD9uVc7KszcKqj1DiGvfd++vuYgmWagO90LcCvwATRriWy5BmmYMrR+Ag8yjJvgCScjnYXd0fbrA6+yBMMdDiG7wmJyeLsEp0ZM4VQqItRrO5bwCwdxxLglzBfz/GWpvWA8WGKMCmCEESwZvGohw2be1coNlbzyxBWUWTpa5mhV4B4GjJqP1ydQpTic0dqIgFNcpq8J9bsCqZ0TD+UOLRSHUfuYm7vJu2m4Y0uA0ldRVO61XbvAGvZT2GijWUOWzrQgTvE0P2mLiuORYYuHnRtiFRb346JI+D2+fOj9YyBhp2tY5UcWsRAdpsasNYXmdki1JCg+H/GALg80Kxsy/zDmTz7Wg3CKKTL0xasi8SmSXc2O3nHvYg==
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(18002099003)(22082099003)(56012099006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?ZFhEZkpJQXJjcVZIb3piU2FjN2ZLWDRmaHcwUXljMVhDVkhEeTdBZWtiYmo1?=
 =?utf-8?B?a0hNUHVkaTRYTHh5OCtqb2J0SGhXRHJwcHozTjFBREVBWmNyZndvUzYxaTlM?=
 =?utf-8?B?R2hBbmVnWStqeEc5QXVaUlhHaU1ITmhMeFIzeStuY0NKK1pXR29CMEFwWUlH?=
 =?utf-8?B?dkVQMGUyakZGVzNhYnRmN3gwcnB2bWUzMVRWdHFuSG91ZW5MWlQ4U29lYmtj?=
 =?utf-8?B?WGpUbFltb0x2SEY2MXZ0S1JmRVFDUzJhRlNhbmQ4VnNQQk5ieGFMRXhVMndQ?=
 =?utf-8?B?RHlPcHVhWnQyZFNrMVhQRFpiNjJRR0ZmWWp3ZGVvYUI2OUpacG8rR0ZoZ3c1?=
 =?utf-8?B?REEyU0luQnh4VkttVnBKZFh5eTV1cjRBcWZvQll2MHVSRnRPM0ROTXhrQUM0?=
 =?utf-8?B?NFJUclVmblBXVHFIZjlGdUg0N0VrTGJya251dllsNVp4TUZXY29zUGdwVDJh?=
 =?utf-8?B?TzU4elRVZXBSOFlEOU5tTk14ZFNUZWtCeFh1d3R3QlVXd1JIVmFTbjB2V1FF?=
 =?utf-8?B?SjhTanBNcUJ2Tjg3M2lucFoxMnlpa0o5VzVLSURHWEZqbWRBakhHQUhpZCt3?=
 =?utf-8?B?L2ZobE5jWU9UbGx3cWNZb1ZiLy9QNzMrZ3l4dkFMNmhFSjJETmFvcGE5Z1JE?=
 =?utf-8?B?VkxFcmt3d1VtQUR6blk2ckorZ3NwOWdyZHUxbk5Fa1VUUzJrcW1hbU9YRmto?=
 =?utf-8?B?MExDVVEraFJhWjQvdW9DYzU0SkNIUUFLV3lFYktwZGJaNWQvOWl4OXp1V2xK?=
 =?utf-8?B?c1kyVDI3OWlEajIxQlFIZVNyVTFET3M3MWx0OGQ2ZGpaWWJrRnUzU2MwdTc5?=
 =?utf-8?B?RlFCTU4zN2xnZ0w1S0NTNFN0QzQ3WmV2UThRZWwyMGRoZDc2dGFpc3FtbzJu?=
 =?utf-8?B?ZzBnbG56QTVOSEIwMHpJTHI4RDdrTm1yL3FyQ0pQenJZRkdhaCs1M1FaaXNM?=
 =?utf-8?B?SzI3cnFyaWJBYmNlWGs0OVV3R084bkZTbkd0M3F5MHB4NnJERG1CaHpCVEds?=
 =?utf-8?B?SS9ZVkErZ0YvRXYxTDd2VTNsa0czVnFQZkVobEZDNjk3MHJkSzhoZ3RIdGNK?=
 =?utf-8?B?clZSMU5JeFV3VzdSeC9WVC9JaWVxdGpvdUxqcUNvb1JZekpnSEZLcFIwaGkv?=
 =?utf-8?B?VnJMSzE1ek1TbVY3eGpiaG9yb045eTBvWitWRmU3NlJvdVRlcWF3WnpZM1Vo?=
 =?utf-8?B?UFFPaGR0U042T3pFNTVQWVN4eTliTy9xNE1QL241b2g3Z2VxWk05cnNVdmZx?=
 =?utf-8?B?cjk0RU85SGE4OXVDRTNuc2Fudm8vaDU1eFBIZUI1KzhUQkc1VkFaTmhVNkVM?=
 =?utf-8?B?QWZSeFFGS05DZjEwRmg1cGNjczNHVm5mbzlBeU8xcFpPaEk5cmVZQUF1ZjR1?=
 =?utf-8?B?Z2xzUklYcUtPZ0R5TUg0NkdnTDhDY0FHUFprVjZkenNNaVljMFNpeUpqY3JT?=
 =?utf-8?B?bEJRSVNKaks4aU9qR2YzUlRQZ0FpSERxSnFvQVRmb0IvWGFiYmlnaHlROUJw?=
 =?utf-8?B?eDdjbytIUWo3MGNTV1V6ejAzdlBPaHhYaDNNNEVvRVlXRFlhckhpR2R4V0tJ?=
 =?utf-8?B?RTJCa09SNnpGdXpPWmJxUEhnMFRSNXhwaVFnYkVvcGhvVi93VUg2WGw5bGtq?=
 =?utf-8?B?ek45WlkvQUpjd2FlZFNTUUYrWWhKQXp3eW1keVBXWWo1SUFia2t0M1BWYVlO?=
 =?utf-8?B?RGpudXNwdmNnVEcrTitIVzZrMFYyS21tMXRWU0l6Y1RzQkdtdnc3a0ZLd2Z5?=
 =?utf-8?B?eEoxVkxBMy9YbmhHdktOYjZRZk1lSEU4cWV0ZHl5aFdycGdLVkw0VHBZeUp0?=
 =?utf-8?B?UkhXYUd4S2VidGphM0d4NFRyUTQ0UmQrZzBrcXRVMXBUN3ZDdE1pY0Y2Y200?=
 =?utf-8?B?ZE12Sk5LdFFCbHl2TExya2VGUGhhYnRUalg4a2ZRMjlQRmlnQTJDeU41ejk4?=
 =?utf-8?B?ZjFyL2pnY0MzUGYzK3dpWUE0SjV5Q3VaMDFnYmJpcWFQdDgwOVIxWTZWcVlz?=
 =?utf-8?B?WlR5S0g1Z0w0N2VQTEdJS0psWHNZWEtlOXZnOVFWcVFyMHUybGE5aHU4RmdN?=
 =?utf-8?B?VU15b0JKMGZqT1psU1MybkRvbXhMMzRXMm5PNndpQ2F2eEtCMjFNUXBwU0h1?=
 =?utf-8?B?RThpVnRaSTBZRGI3dDJ6amwya2F5SDFBN1dzaTVQRWhmMzZwKzAwQ3FjNVpB?=
 =?utf-8?B?MGJxSXh3WUIzS0xlZ2FvS3ROc0E2VEwwK1RNRHNwa2cvODdxbVlIY1BQT1Rs?=
 =?utf-8?B?bFNUKzZJdGxXVjVDcXRxUzVQWlJHL3NZUTdEKzdZM1VTQmY0dTgxRnRnSUJh?=
 =?utf-8?B?VWw2ZkdQQUpVM0o5Rm5aVGhNeUNMSVYzdmhnV3BBUHhVZEdHNzdydz09?=
X-Exchange-RoutingPolicyChecked:
	sD3zCl1mX4RSQfEgtJPdvd72fvO72XGBcox98mpzaDMOFNuQXH9/MPeKK1639LY/Lm2IZkcQ3BBCxzz0UY7ZgjxAC30VX3mXYnfG6cpujkhhLFGxj74QiH74/7wvHxc7qdPylH6ZLGI7cERhQpgqVHQyHeYznELt1DCaBfLT2tnahxyM2KasYHzwI3JIOgLCXVUf0Kn/5Xq0LsbERCIY21YmEckAHYU9cevit7sMljxXxfhTLbpTYtRniStUYxcyvKC//CoEkg4aRfhq6dp+OBp6jIdu5lCwwUu0z3ABm4uWoBR15QzOqhjapwKLn5n1LzLrLe2tsVHURgQvbx35cg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	eaIydmph0XtUtH1e2O22dPE/xIfHUeX34g3I0KAAV1KKmpiUKs4v9xy+MUVA94nSEUXtQ/GgBM3oqyAdy9ZoegA6RbYZzleDs2PUgI0CVHXevF7tYiOBWvJCys+HIgXji3Fu9sedWxjfeDblIU3Y8rMEggI629ahz4oylQ5oP1+TTYpy6AeWV3d+o2TkhWC7e8TX5X+ttro6eEmLroMaYhZrogb+eE2nxe3ol/BXLqnf4ExyCEZwiE1WNpRrCH7giSHKRxVLmVxoxZDuo6C1FFNq3DgtD9Ghx78EQd4SxwaGz0Jk5soAHkxlgNoQRX49Utg2zRERp89ePIVYzvnjk19VQmWF5vYrP5LupPIECzZay0SqXmyZUTrQoUKfRFiPVHXpIFMaSIsidaBaxLEu1Fe4djQAl0mhe3mSc806bnntEJacSsMsMaOC6OKwSI+vgso8Bg0NfN8sTFwIjWzueQMO0fdF9hPVkDwntMgHJ362bmr4gbzPxSoaoqeCMDPtYOFqwpjtITya2S7eF65gd5gNC8GZny+vCzeYWM/fPRxeL4lKNjk9IQf/yo7s2mnzXKDvTEZx7ca6Sofi4Y3UngjiVgVbaDL+a+uFdogccug=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d43ca7a-afa5-41b3-5576-08debfebe794
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 14:41:45.9051
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bK2mNkqWO2liibgy7eP/+dmLxMWZiOL8EOdyptNw3xJkc1I9eawW5MQqi4IRACU6eYO09iPvG+Akd1vOP1Vo8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5869
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-01_04,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 malwarescore=0 lowpriorityscore=0 mlxscore=0 spamscore=0 adultscore=0
 phishscore=0 mlxlogscore=907 suspectscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2605130000 definitions=main-2606010147
X-Proofpoint-ORIG-GUID: LBBAZ4Hxku8nfv7v_SAfgD13tc1Wz844
X-Authority-Analysis: v=2.4 cv=POQ/P/qC c=1 sm=1 tr=0 ts=6a1d9a2f cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=EIcjfB9IiI4px24ztqRk:22 a=MuQVlGaEh7SLIQIqPM8A:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAxMDE0NiBTYWx0ZWRfX42Rv4LhBEe9m
 RTYYaLBvyRLTn8tOgToa4z3HtsN+i0AmW6+zcq7PERhoE1UrWvB0Z2/S+l/qMnvQ3PchqdPp7KR
 NkskconMd9DPTT1NTHZjCmGubrwFSd72bOU/Ov3pOFHUdxiPQ4AVCeS4WcVqAd9uJ1KCWaiMn3R
 kbISVZpycKzwCxShb4U4dSe+nNLB7O8gsGr3fZ/pRXtOHgo9/G/rp3eD8rl4W7BfiYzlGuX5fBU
 p/TBrOd9ksJ46mCsxWnzRnDMXt/I2rYGaIlZGXxetNuJjc4NLdLDhZSST3o03pCdWFJZYeE5yN7
 uhTKbP9N9GMX7Vh7qChpFRQ6sJ/vS7hgopCEbykn6d0OsjB9bNZK4nhi0xl/M44uVjIDcUCFSy7
 3Ii3xwpv42XnmskOpWBxG7MVEY+mvWOE98EVS13VJxz2OMf59GFfZxP2vSUrOUsUe9ngHLJK/eH
 +MFQl2xfCMZN9yMsocA==
X-Proofpoint-GUID: LBBAZ4Hxku8nfv7v_SAfgD13tc1Wz844
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-22168-lists,linux-nfs=lfdr.de];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[brown.name:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chuck.lever@oracle.com,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: A49B6621227
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 6/1/26 6:41 AM, Jeff Layton wrote:
> On Mon, 2026-06-01 at 11:06 +1000, NeilBrown wrote:

>> I think this patch is good, but I think it would be even better if the
>> ->op_release() call were moved out of nfsd4_encode_operation() and
>> places after this if-else.  Then there would be only one call-site in a
>> fairly obviously-correct place.
>> But:
>>   Reviewed-by: NeilBrown <neil@brown.name>
>> for if you just want to stick with this version.
>>
>> Thanks,
>> NeilBrown
>>
> 
> I like that idea.
> 
> I'll be testing a pile of other patches today anyway, so I'll make this
> change and test it alongside the rest.
> 
> Chuck, you can either take this one and I'll do a cleanup patch along
> the lines of what Neil suggests, or I can send a v3.

v3 sounds fine.


-- 
Chuck Lever

