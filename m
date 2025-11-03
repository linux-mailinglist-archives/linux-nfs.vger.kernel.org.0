Return-Path: <linux-nfs+bounces-15951-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F855C2DC4E
	for <lists+linux-nfs@lfdr.de>; Mon, 03 Nov 2025 19:58:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10F4118984F0
	for <lists+linux-nfs@lfdr.de>; Mon,  3 Nov 2025 18:58:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9EE328DB52;
	Mon,  3 Nov 2025 18:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="a2wXSj5V";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="PWOHoU2Y"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39FD686352
	for <linux-nfs@vger.kernel.org>; Mon,  3 Nov 2025 18:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762196287; cv=fail; b=fm8115NcBVl2oje4pyd4GA3+2vAB8fdZUI1Tiyl46vqYTV0aVlFyhS0WEY8K7Ssr5toh5DR99ZtwY0aDvlLoZ9d0XWkAvVvt7918pKhaTRkJmf2xhzFhB6SebNPIi9LWqWqBbMdNiEqj/UfuAzaFaxRY0UG8PiEBh4uNmZOCnvg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762196287; c=relaxed/simple;
	bh=4NB1iHKkrIj7P1iir/ORqbC0mbRAVI7o/g4cHFT/e0M=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Al7KqBVeuGnefDrQbwUGFb/K246DhwoHBU2S7ESpazuVXh5iUNvsoUQxKLi55miq/eh486SjDmuW28yV02ZpgRA9NTICFg31EBthxhoV8Jvekoe6hkWl9eHUZLIIAVB/gsIcoixjA1DDki3uaUw8JnL0ctrrx38QPiSLvFWEnZs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=a2wXSj5V; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=PWOHoU2Y; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A3IWS9B009035;
	Mon, 3 Nov 2025 18:57:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=H91NCZeaoRlSavxB/4kSR/EyFY2fwnSX1X015SWUC3A=; b=
	a2wXSj5VhFfRb++g4Tl5kHNe7NstklqIHLzvHh9ItilOe+mf+1Fb07lpu/WcqRRW
	1hDBjllPl/a1wlLlHqvjXvWUNd4aVrQgKFYAtTDMeMiu4htepaDb8WvAqagBG21b
	tN9HCllHyOXF72HO59XeCmlVMxeWYkaED+D+1RcQULGpDKuj0rVr7Xo6MrNBMuCG
	moveY9llaR5eON0J2rmvuACdeBQofm1IEnl+Ib+uDvRWwj11C0cQP4FLeXiMdCrr
	fI0OxC5dpVhDqLzOMOxpH4dAlkIZ8wX2l6njibT/poz+FZdvwnUOAP7Pygc6PIaE
	aIg2OzIgPrFbSznyr5/rug==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a71rj82gg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 03 Nov 2025 18:57:54 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5A3Hj7rj015623;
	Mon, 3 Nov 2025 18:57:53 GMT
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010032.outbound.protection.outlook.com [52.101.56.32])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a58n8agj5-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 03 Nov 2025 18:57:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d4sWOdwuya/8QnJyhg0ouOijE7e3CiIwE+TLvbfEy3fxPUXg9U2tlCkjgJHyZ0cS8rO/vqMuXonIUxbYbEPAqorGt01AnG8FE+mIk6YU5iXd4MeQbfVogdAR/+Z6XcsdlXtzsLlSWYr9po6GSW1j0QlnYcBvzOe5p79P9x4YPsU/V74m5cogsY+lJmsRThzSTXTWgpZuC6F5Yn6o0nF9Jf26Hax5hrPL7OzWwEQ+trpdJik25FKiv65xWen4N06UQoCH0MSwTLcjn0G5Shv2LR1J1W9UdK3lu298PeCfGI3P+jOIkiU2mSYIrcGpgV7HbDf3O9Atseee51pndmgxpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H91NCZeaoRlSavxB/4kSR/EyFY2fwnSX1X015SWUC3A=;
 b=h+oxh2s4u7h4z9TLFTgAlbh6UVLmWHpOAIwsK/NXfDkJZ4AKKPmUutV9gVxKlqUxTO7s/mY5VkGQxQz6x8ivJZy9wKzfOhL+Uit7STxBlTxnwF5GRam12QKniNQd5WT6JPBagfGi8SQWPsyc8S0EWCU0oj/+p6M4pmvxVdSmxnZ9bvhOL3JrBH5qY5FQHxhsTeHowTmX85/kbhfBsy0bOA1AUFLsdGwCxwzYy30ayOy9eg+XvEjFF2Txxnq3yEQTi610pGdDrIncsXuOwZPiZhhMEcDxrQ+aUZjuXiLtl6d21VGoE5HjxYCYCElAa02ZQufRL4IPOP8Fg0AJH7IcWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H91NCZeaoRlSavxB/4kSR/EyFY2fwnSX1X015SWUC3A=;
 b=PWOHoU2Y/EdJwWZGNc/h2LX/1EMWA6OF7U3QE1UwtOEdXI5Z6siAdqmueTwA8iATnPXH5dk4ucLJ/wPYVLE3BWFaNDUVuqJepVhYMpC1xuM3EiUq0PryGiPz0FuGIg8TLtMINflbx4Ej9BV5ReupKYmcLmjxFedAddLos6fFP04=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH0PR10MB5546.namprd10.prod.outlook.com (2603:10b6:510:d9::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Mon, 3 Nov
 2025 18:57:43 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.9253.017; Mon, 3 Nov 2025
 18:57:43 +0000
Message-ID: <f0d7da8c-2447-4f57-a64c-6a8eb7853019@oracle.com>
Date: Mon, 3 Nov 2025 13:57:41 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] NFSD: Do not fence the client on
 NFS4ERR_RETRY_UNCACHED_REP error
To: Dai Ngo <dai.ngo@oracle.com>, Christoph Hellwig <hch@lst.de>
Cc: jlayton@kernel.org, neilb@ownmail.net, okorniev@redhat.com, tom@talpey.com,
        linux-nfs@vger.kernel.org
References: <20251101185220.663905-1-dai.ngo@oracle.com>
 <20251101185220.663905-3-dai.ngo@oracle.com> <20251103114500.GC14852@lst.de>
 <841a3ef8-d5c8-4f87-9244-f79a10c66e3b@oracle.com>
 <b8489e0f-550c-4c63-8429-fb2d44f24c0e@oracle.com>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <b8489e0f-550c-4c63-8429-fb2d44f24c0e@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR03CA0304.namprd03.prod.outlook.com
 (2603:10b6:610:118::28) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|PH0PR10MB5546:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e139254-ec04-45f6-3f3f-08de1b0adecb
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?bG1jKzl6cWI4aXAxdGMybXV5YmlvaHR2Q0FkdTRINzlGWDhYUlNhNUJtOWVq?=
 =?utf-8?B?NTB0UXl5aitXMDlZOXNJZ2YrNmhRanAwWTVzVzY0S1FCZ3lldThwL0l2WFh5?=
 =?utf-8?B?N3dMYjBubjcwTUpIMlQxR0E1bVNLTUpHNGtWWjdNWlFHNnIwU240MEZ5TW1l?=
 =?utf-8?B?RE4zWU1WaU9ic0k0R2tBbmIzWm40cnNnc3dJeU5jRnl4cjM1VFNsY21vK3BI?=
 =?utf-8?B?ckJJM3dmcGgycVVvZWU2UTJZU2x5WlJaMW91eUhMZE1XQnc2ak9jOTl3NDR0?=
 =?utf-8?B?VWkyV3NxaWxqc04vOWhEUzNmSWJpb1JvVzJLVjNhREg2dm1XWGxKVCsxcXMr?=
 =?utf-8?B?Rld2OFRKNzU3M2lEcmgxMk8yMENodEN6ZG5YalpudytBTDZZN2JJY0tVUWxu?=
 =?utf-8?B?c1VmU0FtMTBmRlRxRmZreHZ4OHpjcUxja0JCdWFPM1lBQlVFZUJqS0oxeUEy?=
 =?utf-8?B?WHJoS0tXR213R2pUSGRvQUoxRzJuWE43dit0ekhQd25FbWNSZk1ULzA3cXpU?=
 =?utf-8?B?RzUrTVhvcmJTb1dhY3pCOFRXUVp1Y2V3WmJ4Q2hXRHFXUTBRc0Z1R1ZXc01N?=
 =?utf-8?B?ZEdRdW9FMytEdG5sL3ZTU0FJVkNxbVFuR2dPUmh1NmZmT0gwVTFaV1puQUhh?=
 =?utf-8?B?L0xRUGN5YjY4ZUdvRnlUbG9wRWxFaHdhNCsvWkpJbkE1QnRNclFJZkw1S1F5?=
 =?utf-8?B?WW42NmZnNGlHWmJURWVKUk5VMHl2ZDdBcHpFZmNPUmtrTDFRbFJRTlZTeFlJ?=
 =?utf-8?B?UWMyNE1ZK29hSzk5Vld2Sk9iWXF2RWNDWVZkODNkV2FCaEo1Y3RldG1XTzlH?=
 =?utf-8?B?MGkxa0QzMU80eFZKUk1uQWxHRy9mNXdOZy9OSHAwcUJiSGNDZExTUFZrNDZC?=
 =?utf-8?B?dUpBY3ZVVjdHYkZVa0JqS3c3ZjhxejE4eDIvdTBXSXBXMWI3WGdneWl5NU9n?=
 =?utf-8?B?dlVHTzdIby9HK2Jtbis1bUdDTVlWTHVsbytPNm05ajMzVG5IZ2ExYUZmSlAv?=
 =?utf-8?B?Zmw1T3RmMGF6OWlwZk5QSDMxYWh6RWhvdi91QjdzQ0xXSVVrY28wSVd6VWg5?=
 =?utf-8?B?bllMeC9zN1pGblFnQm1MdTl1dGs4YVJ5Vnd4MjQ1YTdJWjRWdTF6dlY3OGQy?=
 =?utf-8?B?QzJ5eHdzWkJRdDVVWXZFK2thN2lIcXJSQlQ3TFVEQTBSeWkzdXErN295R2lX?=
 =?utf-8?B?WWNqbk9CZ1p6TWMzRDJPT1lWd3hWMi90MldweFNSaGNUaDRDMTU3cnY0NHpn?=
 =?utf-8?B?eXJrcWNieDIvVkhXY0ZXekFlOHE0MVNCYnI3R3I2YlUzYmd2c3NkbGNQVWNK?=
 =?utf-8?B?aTdvK3NEVWt2dlFVaEwyTDUxZ3RiaUtiUi9EeUxabUdmZWtvWk9yV0xKWnJl?=
 =?utf-8?B?cm9XZ0t2QlFMY3ZYRnVVdEZOb0cwdzVmYjJ2cVM4WHJSdlVEaWRaUmJndEoy?=
 =?utf-8?B?enhuMHFUaWRveGQzYkM1VFRQZnY5SnR0VzlHUE5IOE9IMDR5ekVQWExjMDZl?=
 =?utf-8?B?N3pwRVk2L1Q4QWNVclg2QmtGaFZBbzRzbWZDcU9CWUI1VG1saTRiYmtMaTRv?=
 =?utf-8?B?V3FnSVUralh5TWkzR3dxcEp2c1dTQUd5SHY0N2E4RFRMVkFYSXpkRzhweGdO?=
 =?utf-8?B?aUN0bXZ6TzZNbW1uSFFoeVNaOFRuelFGbXlDREFsQSsrand4UStYWm0xZmdy?=
 =?utf-8?B?VlE2eHFzMktLUkJFakROQXdIczBLN2xtL1EweVNJTmNlcmZacThOUDMxd2NQ?=
 =?utf-8?B?bzdDRFVuYzZiblRaUzNmcnlVbGR3c1lSRHkwRlRlZUp4V3ZDQnNWRjAwcVlp?=
 =?utf-8?B?LzllZytjMFZ5aytZQU9iaDNmN29uTTh6a01aQjA5N2JRaE5vVDd5d25PWUdw?=
 =?utf-8?B?NWplYVYyNmdkcjZJY20xSE44alFmVmpWM3o3UzdVOENWMzNnclNndTdZMzhU?=
 =?utf-8?Q?iNUisYThp0oIIzPseCXSHNYvkhYIMRrk?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?emNEV3JJVXM5b1ZoNEg1K2VsTzhuTHdpVHNKb2crTk1FTVJmRzRtaldzS3BR?=
 =?utf-8?B?clVCQmwwODAzeUVzQ0xncU9OYmI0dm5MTGloOHVpTUtTSFhDeTBrZ1JRL3B0?=
 =?utf-8?B?NGJvTE5SbzR6THpIMHN1K1Nna0VORFovR1V6a2RvVUVSOW5tYTIyanIyOXh1?=
 =?utf-8?B?R2I5b2JubThmL25weUlQZm1jWUs2bHY1SzVuTjAzUFdmTFNHaTFFS0cwNnVu?=
 =?utf-8?B?YzQxNktqZTJVcVJvMEY1UnIzTlRGYUNCZkYrTzFHZkkrMUkxeXUvWjBqRktE?=
 =?utf-8?B?WDJybExYYkl5WEsxbHl0cUY5dk5IbkxnMTJBeU5SSkwzRGd1Q3lieEVRSWJn?=
 =?utf-8?B?VDRNNzVqZE84cnNXWDZ5SFR0UjZmMkswMmJDZEg2ZFE0Vm9lRUJCMmtLSEV5?=
 =?utf-8?B?cHhOMmpuVlJNUFRpWitRKzVkM0l2THVHUndiZlFoMjY3LzBUSzFWZVlMNHpp?=
 =?utf-8?B?K3ZKTkg2NG9PMnpUTzRocVZOZFZrS1NrYU9HUktiQkY3bFJISnV2b2VVUStF?=
 =?utf-8?B?ZDR5c2w0OTdJNHlMcFlZNUNVQTVYeGxtZGNHS0EyNzRNM0M3RGErOVYxUmd4?=
 =?utf-8?B?MkRIbmZiaTlIcnUrSmhHazNydll3Z0owcnRQTi9tS0lGK25RNHJPb25ZaE12?=
 =?utf-8?B?Zk4reFdMVFlrYUlDQXdWQXUveUVvVzB5RWU5YmxlMDNITS9GNWVOQjQxRUtR?=
 =?utf-8?B?QWF2cThHb2o4VWV2ZGZtSGNWNVlxUFhESGJwaGVmTW1mMytmcGhUaHR6WHlM?=
 =?utf-8?B?OFloYmsrV2NQMlROcDl5V2dvWk9vWEh2SjlUYVF4amp3bWhoc0ZVd1A3WXEy?=
 =?utf-8?B?VmZYbGs0WHZNRC9ENzBFaUFjWmlXQ3NlTStGWjZvQ0xHaGh2UEhjbUJueTBD?=
 =?utf-8?B?OUgwMjZweEl3b1cxNUN4RlMxMlZMODREQXRxbFQzVElTRmFERjdBcHhpdFhs?=
 =?utf-8?B?RXhlTG9iK2xFTml4OUdiY0V3cHQxRE9Ccm1ONFhWNG05N2RZRG44NDR6NjM2?=
 =?utf-8?B?dllMdERFeEJJcnl5RXNscDB6VWtIRUZjaENnV2xsNUlNd082U0VTUnhiVW5S?=
 =?utf-8?B?OWpBbHN1eHF0QUFjUTcxbE5GVG0wNWRKMDVTYjdVUVZlbGdQbDViYlV0amJo?=
 =?utf-8?B?WVplb2E2R0ZEMWc3N09YMWNBaU5FN0lPYlFnakRjRDhxamhzeEowKzhrRVVN?=
 =?utf-8?B?N2ZBbHpUdUNFVXpYdThHR1lOYWV3MmdiMlJyWDdiT1o3YVNDVVZ0clNaWm1k?=
 =?utf-8?B?dGkzQkQ2WlJxUXp0bUJlaW5oVmRtUk56Z1FmTFJPMkxURERKYS85RnFqOGdz?=
 =?utf-8?B?bjBwRzMxOEViVzZvbEMvaDB6UlpEays3L0VVV01uUkVKd2VjWTNBQ3JoNmk4?=
 =?utf-8?B?MHJkMnQxbVZSdTBLYUxZT09Ec0ZMWG5IZ09jVjErNGZNNW1oN2tTMVV3UHcy?=
 =?utf-8?B?UlZBT0RLQjZhYzlZVkV3MWJpOWVkRVgwdjZsdmZpQnVzV3RRbE1qcXhjU1hQ?=
 =?utf-8?B?MGdZdHYrMmh2NTBhUUdUUGZvT2FsaTg5TFNkZWpReFF5dWJrUmgreWhLa0Vn?=
 =?utf-8?B?YzFWeFNqczlOMmU3dldCTHdqWXc3TzI5YzBmd1VSVllzRWxqbTBQbkZoNlJY?=
 =?utf-8?B?U1B4bWozWTNXN2JQT1JiYnlmZStWekVYbHlRZmEveEttcVR2bk9LeFh4Mzgx?=
 =?utf-8?B?WEV4Q0dUSW9DemplTFU5b0N2a28yb1V5MTBLb0gwaFhrUHIrNEVZMFp1Z3Fz?=
 =?utf-8?B?aXp6MW1BeDRZSlZIUUluUjl1OVMvbXhrYkNmWmlYaVhHUndFLzh0Tm9Zdk5P?=
 =?utf-8?B?WVd2enVjM1RIR0daR2xDYnpLOEZhNFJ5NzNORXlHSWRCQ29PSlgxQjU2a2V2?=
 =?utf-8?B?MUswUVhoS3JQZStGaWJacXAvL0ZVZEhPRjBtdG05RFAzQlJNOUN2SjMyZlBD?=
 =?utf-8?B?b1NLeFUrMzJvT3lzMUFqTVZ2dlhsbUZnbTJHeUZWTHJ0NFJCaUJ3NWgyL1N0?=
 =?utf-8?B?aytKMlZTUENrNlhlTGxJNnFTS1drVXpHOVZGRi9YN1VJVkhDU2pCQ1B0eWdZ?=
 =?utf-8?B?WUZxeTV4bE9CVlUxVHExSW1MWnJFVS9HbTV2N0dLU1ZMdGpUWDUzVUNkWUV3?=
 =?utf-8?Q?HU2qn5bb/IOD4lJO9dWyI2COT?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	hGbxo87bCRGTS6KcP7IBZ3BYU7/+Vu//pAdv9ymdZzt+XcZ469oFGaNUAY6pR072mT9+XKR4Co425xUaXZVFtWsCg9gqZS9gSSy6aukXLo/O+29hJFfAJaRONK0ZB3cY93FR63aRfaLzRAWqLn6BYy9a61COY1yRPMwLHVtAxdFiWh8BKTMPg5aPUwfvh8WL2Zra0724N+HfOgE7rK7ZNLPci3NlymLCXNKj2DbEtJ2vZY/VX8FAWuz0bfVmrtwKiONJomj8ynpsu32NhfRTW14yS06PpmaHCUlpkdcYFJNuiNO9tCSizNuOeoRTakNC7JLa03NGJnjqIEIsMQxJTtwFdX3DyC27m5scvxf9a0t5QHBJnLK0ZJNnLlniXC6KGRo4wDYvXImBKQE09eghC+ncLo7cMlERbGa+xXIFcJpLMloR3MmYMFuD6HyO76fd44WrOIeZNTMpQcXNf6IS3s3Lcw6aX85mCRCqpxEe+QvQGZPw4nEhxpMb/R+9VhePkwcXsYsF3tJiN+qsdNhY/6zmZoEbRg8d/012JKC3JLTDnXhQxVOIgljESkGL150z/ewYCWgS1St++qMzOQypZP6gJOf+NneR1oKVpT0oWB4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e139254-ec04-45f6-3f3f-08de1b0adecb
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2025 18:57:43.5824
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fr4yJ7bJKsI/WmFxL0RwEdE8hjnj9d7mRdaDtf5PIO3/4owKv/mYBumoIBNVFZYgNvJbHgiu4kZdK/k+hSpWCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5546
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-03_04,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 spamscore=0
 adultscore=0 phishscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511030169
X-Proofpoint-ORIG-GUID: L_649krnuLRMoGo0QLHHp8fREkg6eNIk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAzMDE2NiBTYWx0ZWRfX/RV9Qm3nBSaZ
 w7/8nmfMPZ6KcnminbvoWVIIYIVTL+cOgjjOV5CWhWuC0aqAabIJD4VkR+t6A3E1CZpAQEt9Ote
 KTN+9Au1xwqzvPnsj2QmrECjvGxiQRt7ZC4fOPhKMyGK50B6uSDR3RNu7bXlF0VYfLyfcI0AwVJ
 FLTNLms5dMoAgwXuATZNetFKJNKKd/Xx3EVVT5hbJ80BWUdF8O9S7YPqn4mMaKKiB3aiLfNKsRZ
 PjTcQFhYPrXAZgytv3kc4eoLUSkO0Tp6rk+ieaxeO0WnUBCejTCQyY6k5OKQxwW5tpd7YnvASE7
 9FIP8JQtr0seI8SiRCOLrqLRPdRXFxqlXlRqthekkryB6ErfjjkbX9Bpj59Wj11DZKDeP8ImdMN
 yfjp2IECYvv/dv71xg1muxvGyWNh4w==
X-Authority-Analysis: v=2.4 cv=frXRpV4f c=1 sm=1 tr=0 ts=6908fb32 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=9JiGLvfpqovRuNHpK-kA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: L_649krnuLRMoGo0QLHHp8fREkg6eNIk

On 11/3/25 1:50 PM, Dai Ngo wrote:
> 
> On 11/3/25 6:16 AM, Chuck Lever wrote:
>> On 11/3/25 6:45 AM, Christoph Hellwig wrote:
>>> On Sat, Nov 01, 2025 at 11:51:34AM -0700, Dai Ngo wrote:
>>>> NFS4ERR_RETRY_UNCACHED_REP error means client has seen and replied
>>>> to the layout recall, no fencing is needed.
>>> RFC 5661 specifies that error as:
>>>
>>>    The requester has attempted a retry of a Compound that it previously
>>>    requested not be placed in the reply cache.
>>>
>>> which to me doesn't imply a positive action here.
>> Agreed, this status code seems like a loss of synchronization of session
>> state between the client and server, or an implementation bug. Ie, it
>> seems to mean that at the very least, session re-negotiation is needed,
>> at first blush. Should the server mark a callback channel FAULT, for
>> instance?
>>
>>
>>> But I'm not an
>>> expert at reply cache semantics, so I'll leave others to correct me.
>>> But please add a more detailed comment and commit log as this is
>>> completely unintuitive.
>> The session state and the state of the layout are at two different
>> and separate layers. Connect the dots to show that not fencing is
>> the correct action and will result in recovery of full backchannel
>> operation while maintaining the integrity of the file's content.
>>
>> So IMHO reviewers need this patch description to provide:
>>
>> - How this came up during your testing (and maybe a small reproducer)
>>
>> - An explanation of why leaving the client unfenced is appropriate
>>
>> - A discussion of what will happen when the server subsequently sends
>>    another operation on this session slot
> 
> Here is the sequence of events that leads to NFS4ERR_RETRY_UNCACHED_REP:
> 
> 1. Server sends CB_LAYOUTRECALL with stateID seqid 2
> 2. Client replies NFS4ERR_NOMATCHING_LAYOUT
> 3. Server does not receive the reply due to hard hang - no server thread
>    available to service the reply (I will post a fix for this problem)
> 4. Server RPC times out waiting for the reply, nfsd4_cb_sequence_done
>    is called with cb_seq_status == 1, nfsd4_mark_cb_fault is called
>    and the request is re-queued.
> 5. Client receives the same CB_LAYOUTRECALL with stateID seqid 2
>    again and this time client replies with NFS4ERR_RETRY_UNCACHED_REP.
> 
> This process repeats forever from step 4.
> 
> In this scenario, the server does not have a chance to service the reply
> therefor nfsd4_cb_layout_done was not called so no fencing happens.
> However,
> if somehow a server thread becomes available and nfsd4_cb_layout_done is
> called with NFS4ERR_RETRY_UNCACHED_REP error then the client is fenced.
> This stops the client from accessing the SCSI target for all layouts which
> I think it's a bit harsh and unnecessary.
> 
> This problem can be easily reproduced by running the git test.
The problem is step 3, above. NFS4ERR_RETRY_UNCACHED_REP is not a
fix for that, and I disagree that fencing is harsh, because
NFS4ERR_RETRY_UNCACHED_REP is supposed to be quite rare, and of course
there are other ways this error can happen.

I don't understand the assessment that "the server does not have a
chance to service the reply". The server /sends/ replies. For the
backchannel, there should be an nfsd thread waiting for the reply...
unless I've misunderstood something.


-- 
Chuck Lever

