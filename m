Return-Path: <linux-nfs+bounces-20476-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cNg2A5fWxmkCPQUAu9opvQ
	(envelope-from <linux-nfs+bounces-20476-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Mar 2026 20:12:23 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6214A349F4C
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Mar 2026 20:12:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0F6853000A43
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Mar 2026 19:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83B10257821;
	Fri, 27 Mar 2026 19:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="eXrY5W7Z";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="BccxZkDX"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDFB7329E5C
	for <linux-nfs@vger.kernel.org>; Fri, 27 Mar 2026 19:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774638507; cv=fail; b=OPa2OOkg2m9ZwHQZ49a7aPGp+gBHQHyfNx8r1OMetsUYxXAIEOQxBmgPJ0eGQ5aUx0uqr5OeE138tsVRgmM1fi1u29yszIzNvFp2ZHPpFHRy2TLOC4IE4uOjh9rxdY7qSkQRvUOck7SXKf4W8YBDejn1NUlKszCE56lQcQb8fSY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774638507; c=relaxed/simple;
	bh=sVeNmfQbULZQWyzZBy2dPkmK4F2pLReDGpqiGwAUxrA=;
	h=Message-ID:Date:Cc:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PR6DQ5+fyLzxAjfdjtRtFuTQqdZzU1OVJ0akZMQ6nyJsuKT+5FOuS3ZPglbmVs9FqtxmZk0Ib9uXm/BYnYZFOLJwKGR8f+h1OacpSgcJ2TlJIyk1/XDF3HgCYkK/4gehN/evER10vx/JDB/Crqo214sHGbXraoEh7vHQBZZE33c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=eXrY5W7Z; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=BccxZkDX; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62RGvrQV980051;
	Fri, 27 Mar 2026 19:08:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=C+dFzs4xPq3NufpRqUW7FLPdp6c50IRYy2i/j6eqWHM=; b=
	eXrY5W7ZjT1G937nqnP1aIA6kQYSbMd9VSeMKNj6sN4Q6neD7+GIXOkc6YiXUoeD
	uneaBycF9QB6Jf5y+GULe9ThcQPX3UTqfB3jn8NjQ+JSN10oZ2K2gI/YjU0PIuNT
	ExTTvogdb6romomElCQ5kGZSkKGIFqsWqDgt22jvPZaMc6CZPg1/qvRXF9Wqvmza
	pnyz2oAPuqdMS2hHXon8sAcb6iq1jRJl6aY5cmVtTaii+mfx8u6PdxBXsK/LUq1L
	RB5ZuRlmvI44aoKPDaAUSu8r7WPnZpTR2QARWTyxvOiljOtfEmgtV1yHrKMX+qdg
	mdWPw5+YTKSHyE6s+F8FIg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4d1kgftm5y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 27 Mar 2026 19:08:18 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 62RIUUmk000591;
	Fri, 27 Mar 2026 19:08:17 GMT
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010069.outbound.protection.outlook.com [52.101.56.69])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4d1hsesyc2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 27 Mar 2026 19:08:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lxBorMKEDSGDY60RCBtc06yQBuK88AHjLltlKpoPhTS8r1UnpWB5UiKEVaOLEX/ph7FexKpG3Nc/16avBlZWlGFK2JGNU0Fa9r3KD8C6s06VJxeH8Y0RdUcQPME/b6txL10XqNUcIqzMut22bpPlf/BduSDFvXjmwpShmrpNOXt98xT0IoGFopydzHu+L29zlikS3kKRPpHL7ppyyNbc9joyZyRiHyxebhX5UU5dByZ8Mk1knacuBsWzx8D5gyeV4dFdt24520XNEKDzY5bnVHxp6QdYKM4SFQQPaCxqRvUW3Sh4+3rw3NJQhpZ1oqcFWik3LTl4zhmkhHDSqOiwbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C+dFzs4xPq3NufpRqUW7FLPdp6c50IRYy2i/j6eqWHM=;
 b=M+aURDzL9UQ4egMzeinPzAnzaWmaR+P4CUDa8H8LI4qIPjdS/ucRnyZ3ijFn/9ld8Y2kWdR+uUh8WW0Fotb2PfjF0LDGMyk1vslZT21P2xOyNB8QEveMR5fZvkTx2ham6C6zVZNyPeh0m89gqz8cEgDADf/ZH02K7a5YDQ5L8axS+dIzQ7p99G73ZjFDGEl94ROnjITFkkdXSlnS3T2kfAbJIlk3HP4gv6GvJ+W7kUVi6iDkclHjODMoGrQsAvy+z2oCExv6r08lcUonDOVGyi9ebe6etLEUQIO5cPmG5E2XGt4Fo1x2JL/OzccFeZpRk5U5r6w3d1G5xPtkWVm6kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C+dFzs4xPq3NufpRqUW7FLPdp6c50IRYy2i/j6eqWHM=;
 b=BccxZkDX6LwJDkEhyfEN4CuL63/GkqAPTio6hrvNXfsv55jPJoVColdFbX3ct70+QvBNo+BNgQV7ogIZnxC1+tQTc1IyFPsNjmPT/5LqUVNj2rYhKAyzLLZZAIOgZpGCgrF9iUZr886Exac+sBiiUPj176WlFwVfLL43tP9ophk=
Received: from BN0PR10MB5143.namprd10.prod.outlook.com (2603:10b6:408:12c::7)
 by IA0PR10MB7577.namprd10.prod.outlook.com (2603:10b6:208:483::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Fri, 27 Mar
 2026 19:08:15 +0000
Received: from BN0PR10MB5143.namprd10.prod.outlook.com
 ([fe80::71c3:4ee5:93a1:85e9]) by BN0PR10MB5143.namprd10.prod.outlook.com
 ([fe80::71c3:4ee5:93a1:85e9%5]) with mapi id 15.20.9745.024; Fri, 27 Mar 2026
 19:08:14 +0000
Message-ID: <941d32c3-afec-476d-8962-543e34beb3e8@oracle.com>
Date: Fri, 27 Mar 2026 19:08:12 +0000
User-Agent: Thunderbird Daily
Cc: Calum Mackay <calum.mackay@oracle.com>
Subject: Re: pynfs-0.5 tagged and pushed
To: =?UTF-8?Q?Aur=C3=A9lien_Couderc?= <aurelien.couderc2002@gmail.com>,
        linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
References: <33de50bc-5cca-4071-ad32-05a82da89c77@oracle.com>
 <CA+1jF5rbEzKyvzvq7ATzGhy0xthL8baRLV-zDCe7r=e2OVh3og@mail.gmail.com>
 <CA+1jF5pguuUukL+5im41x0OewGX+kTtjFNEF3VD0g7nCC47XhA@mail.gmail.com>
Content-Language: en-GB
From: Calum Mackay <calum.mackay@oracle.com>
Organization: Oracle
In-Reply-To: <CA+1jF5pguuUukL+5im41x0OewGX+kTtjFNEF3VD0g7nCC47XhA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0455.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1aa::10) To BN0PR10MB5143.namprd10.prod.outlook.com
 (2603:10b6:408:12c::7)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5143:EE_|IA0PR10MB7577:EE_
X-MS-Office365-Filtering-Correlation-Id: 6065e06d-9f67-49b7-15e1-08de8c34326e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	6UIULFrHSD8Fx/Xlcv2b/sjIJsST4soFY/HdTnv5TnwZh/xKNhV/OZtOLjtvDUR3UzgtrsCXMra7dD/IXgd54frIpe4q3nqMJ8kyltzi5NrCFMezv417p3DrRXYNvTtSeqZSRwwgUgtv2V8KvNvxlM269rJoJQ3tCk/qutvbulujYSUsQ8NDArh/sC8kVU1fTwM0u1XR4274HGkbai/MGs8SUUgAvQJcG19uPO0hDPyK2jog+nJcr2jnN00Wru7/9dzrVMNuUoZ5EIl/2YetV55EXClPhawl0XMIiKhBzg8utXrzFSowN2w/NoP/G3CmXE7pYTjfrMoHV4Y7B/BAYUTWbqLIrMAcXhDfxdH/kZ76eTuKBmy3t/1/dxinCX9GNrxtULbCJ1aFYve5uBVDl4I07lvJ8TDzPKWv1vzqy/STvTCfrBYI7KZRlhTkdAZgh5Vd3WJyz9yRgcElaB0jzzNNyNCjNgZoxnEI7zmo/Gvge2gpEBgqzhv3RHr0SsC6L4U2NH/CfyeQE/jZvlLArKWNr946zjUW0GPY8TH9ytVvlWsDn3rgtvIWKr4wWX8jSXRhdeUF1t6hGJLrHc8++rVBXggjVznd6urJHS1w3fTmcFgr3JP6Jr2THv9wVTWkOLTpKFgDyxilSwTiQipHExZN7F0U/yPbL/6T9qnsyHM6UOYI/KgQijOYfnAAiVpoxLxT2rscxsNILC5Lpbavu5ceJpWk4lBXGuzfHNNQIr0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5143.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RjVYMG5nTTRuaitMMFpqaWJleFJZUTdxRlpQa0R5ODNBbkJSSjQwWmVEbnhp?=
 =?utf-8?B?RllKUjBPelg5SlpsZEo5N2pqMDg1cjBVcUQzU1RzekxEaEZxKzIzUmhhMDNt?=
 =?utf-8?B?VDB4MVE0QjN3SnRBQmpqakY4WmVQMURxWStTZzJ4S1ZZZFk2Q3IrMzlyaWV0?=
 =?utf-8?B?M1I0WjUvKzJ4NnJTN0xzUmZTMDZYdjJETXp0OVdNU0k3aDBUb2tmYjNobWlx?=
 =?utf-8?B?dXNXUDhzUFBwZmUwWTg2bndPb0Y5cUU4MWkxYWYxaWJMajJvbndaamZYNzZS?=
 =?utf-8?B?Q3pkcEhBNFhvRjg3aG02S3I1MTJtUVdMMWNQWEtCRlJ0WXkxSTJJdnRUbXU1?=
 =?utf-8?B?Lzk5R09ieWhiTmR0K2ExWitJbHRQUXBGdlBZL0MydWhJeWIvY29LRmtNam8w?=
 =?utf-8?B?bFF1OW54Q25vVEJXNjRBbVFvVFhEL21aMlRqTUJTZytscmgxUHhKRHVGZ2l5?=
 =?utf-8?B?Q29YN0srRjZ2ek5lQm1FVzBoQ0Z2YXFxSDNka2Jobll2WktDeE0zNEYzblpX?=
 =?utf-8?B?UUpwQmV1VzZqQmpZV1lKbXJyS3dRTmZBL0N6Mng0ZGgrZi93SGJDNm91VDYr?=
 =?utf-8?B?dC9CZlJvbmNrekhHTCtxOWlCOGw0ZUlhSzJKd0h6ODZaZ1VEOTBlYzF4WmVN?=
 =?utf-8?B?N3kvYm1lUjlEcE5CazRiSDRReHQzZDNqQlJrMVFzVFhUMmVZeVJVWnU0WExU?=
 =?utf-8?B?QzlSaUZZdnh0eTdxQkVXRjlhMmxISFR3V3UwRkIwTnpTMlJ6b2pHZEZUQlVJ?=
 =?utf-8?B?VDJPWFBOLzFCSWU5L2tCekgxWUppc29ZOUFpQTBHTEo5QlFsTHRXRjVUYkZl?=
 =?utf-8?B?SGhGU2R1dVJuVlhENGY0YngwekFVMDQ0TzVXeE9Wa2psNVFGdC9FNjNBYXIy?=
 =?utf-8?B?aGhiQWhQS1h3dzJlUXRPWkhnNlN1MGIrTDZPSURscHMyMmsrS3k3Q2M4RmM1?=
 =?utf-8?B?ekdWYUZYODRKdmtBS0xRQkU5REdQQk9IdWNrVFA5NEc1aUR1d09zckg1U2N5?=
 =?utf-8?B?eno4clFkMVZiWHhIb0c0WkJ2UEJIY2t6d2tCdFlOdTdPRW0wUmh6d2tJMm9x?=
 =?utf-8?B?b1U4eXhPY2lxSUhtWnRHeTVnem9uU0N0aXFadytiSG53ZzQ1NVI2dGdSTGNY?=
 =?utf-8?B?RXFNSXoxbTN6Qk01bVFITm1lSzZjbUJtRVhYZG9jMGFoanBVWllmWVEwNGgx?=
 =?utf-8?B?YTRnRWpqNS8zWDhpL1lPTW1ZeVg5TFVrT2hRUXUyT0hSdjdocUtmaGx6Z2lF?=
 =?utf-8?B?SzgyaWEyMkZBQ09xZ3pGVFJiUnVhS1RRbERZR1VRQmhMenVTWVhvcTVFVkFE?=
 =?utf-8?B?SkNkeWYya3lNNXgwSTlwL2dLZmhBSVFiZVFZdXJMaEVFZEQ3TFZhNW1DNU84?=
 =?utf-8?B?a0xUNmdWLzN5SmlUd3AraDlCUXlqNktxdEhleWtXUXF6ZXdHaGx3U3RheXFz?=
 =?utf-8?B?bVRvdTc2YjB4SlpranN2WFl4d1J2K0xsb3hSdGVmMG5Tbm5wMFd5T3ZWa3VC?=
 =?utf-8?B?eTVNSFZEUzV5SVo3bHMwcDNmd2F1VWNOMCtpenZsVENxWnpuNGxlT1pCTnNR?=
 =?utf-8?B?REcybDMxaHZQRExXSS90RzNIWlB0WWloNTVqL204THJmUWZ6Z2ZkR01nRnN4?=
 =?utf-8?B?czZwQVNnUS9oNFk1NkZDRFlHUDViaXJyZDhLWVdrYlN4SmQ3S2dza2dqSGYr?=
 =?utf-8?B?dk81Mm82eVc4WTkxQk94VVpNdGZ5VmRvQmhFOTkvOGVSMnh3MU02a1NGVGxz?=
 =?utf-8?B?YitTRkFDZ1dBakltaUZYamlCYUYvbkcxZE42T2NOeDlPL2RKVVhVL1hNUmYw?=
 =?utf-8?B?NlZlMkRrTFIrbStMMWlKYk4weklBS1R3NXRGN1BjYWgzRkc1eFE3d1hBUzNC?=
 =?utf-8?B?WUx4R3NiZ2Q5elNBQmxIclQ2M2t0djZidVE1bjNtUGY4Sno5SWsxZnFRa3Nv?=
 =?utf-8?B?SThwaEZ6aU8wVlJnTHFLTzkrMHFrRVR1YVdwckVOVEhVTHFqTzI1Z2dKc1Ja?=
 =?utf-8?B?aExNM080SC9iK2tUczE1M0o5cHgvL3VmT0lzWWhDTFRzZjFOTWNqVlI1VG1r?=
 =?utf-8?B?STVzYnAyQzBoS0poNklxV0JSYWRQS1Qwcms1UTBaT2JRYnpMd0pmUkxWdkkv?=
 =?utf-8?B?U202elBQZ2hCSjFFL0FmM2hieFAvOHVpdjZVL1VSTU9WV3VMeWJWVmNVOTlY?=
 =?utf-8?B?RDQzMjZjbFA0ZVZMSmRCeFZKV2FYVENybDhlMzdteDE3Z0hma1F5bGZjNnF1?=
 =?utf-8?B?d0dIV1JrKzl3Y0NGQW55M0JBcS9KT1ZYem5FczRZa2JaYVdLZTlXSUFHZXg5?=
 =?utf-8?B?T0gzTUtaRXh6eU1OclNrV2NzYjR3N1lmMm5mNVhmd2N0VGc1eWZjQT09?=
X-Exchange-RoutingPolicyChecked:
	dhvCROuiAbEWesj6I1ixsCdEOBOvYOmV4aiYSk8eRFMq6I8ULJ0+Slsa+SpSy2psJP8VGn1BW3nA64D020WijvuKCK36PvLu3Qi7zpC4XMgJTBef+f9kHi0Y+Lsi/iyHJzYFnOCaOgVk4FNW23r5v4p/HVHaM5yVIYRcWi84fKgoElHawean8NFSNyJ8g5optSW5cBNnVjJ1Y8WoXk2GRqCSwQa72SRYu6ONZxvHsjMsTVUdP/dWIGEZMgfDU3S6hMnqCGHaR+lL12Ane68942sbJplGmiDEV6QRV53zf6unuRrhi9VjO7JLQVMSyGCDsK0WAXVm6awoz4pZa9Lpjg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	rHNI5egFiKkVmV8FkLR4MJ2JrO25s1NLHwgopFKmkfNZTn3ZJT7WvjVMnqe/t712CfMmM4eE8C4YKexIscWLi6G5Y/XVxkBR64SgbIJk9T+CnEKblxdyVeN6x4hWTGR6Hz/qyHgX9yuRPPHBEShiX+MGFWXhcHu6rjXtGaUfDNwAGrm9y1HNzkW9FoGd6ILl7PJhtt7s0v/rz2Oquc52uSxkL5rjfLIWtIMBBFNhB+O1XJdNiCeytLoGdxkAnZXDNwKukVVKVCsoMJ9wiHYIfWP55VClPb6cv9I+zU6eAMDzx9ePbOqCouq5l5GWwBSL5dApSu/Z9oTmhjtjI5q6riXVIUACVSXM2pZtABtwEBjl+PYK9yzzd0KWw98MFJiZCcHJVJKMoKOeLeh8whCx7OR8KWiNWQABubZp24axRxvZ0JmALEVKnKj9YKv25LV8sQOTfq3BG8O6kofocDAMx6SZGQs2XTr3zJlCdy4Xuvi/tEDMigkYVb6r49s3F9OeGUq0/1qRFDCsoBjt98N7tMEEKZ+cxl9lMTcGnGtLnmktuvQDlp5a7/nA6ccgjq6Gu5FBPqIXYxHhpzu1+tpe51zAb2Dopdg8vcQD0gf9x5s=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6065e06d-9f67-49b7-15e1-08de8c34326e
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5143.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2026 19:08:14.7969
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CHYhgxEDmyUfweTBdLq1WW217SR5iRzZvl+oQzVnq6Lx95B6dcSgDwmulgAbt5s47VPzMDJwqSzeX4GRrZvrsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7577
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-27_01,2026-03-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 mlxscore=0
 suspectscore=0 spamscore=0 malwarescore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2603050001
 definitions=main-2603270133
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI3MDEzMyBTYWx0ZWRfXwyHF4oqKOXb8
 2ULjeI2dLhZay/IeFA22NZY95zzUvR8C38PP0+CHJHSUCLWPU3Rb6y+trZNsKXwNSOkbaXDd4Mt
 e5JU42HklEyzTtLfTgyWa0/IR5RAVMPLemf9rcN3Bi/bmwDA0rGgCNpSNst3aWKufeyqqplcjYS
 qcu3BcF3P+2WSAb4Pw4M9Q3nebrLzH/JO+iL1Usfmua1+cnollvGVzlmdyoAcR6yNnbVp5zynlS
 0oCjIbVL0oshoPD4HkDSLqYDT2Qat1z8fmHq6Azuqz8cBh/vsOP5Z+Y98PPdrBQ7SzlAUoPYdki
 umxFsY3jMOwtgR5IDgpPs9YAh7ZFndVq1nffc4JVx6H04CB56xzM2ODU0KBz8Xbgj/M8mspeRLd
 ancIzeVMyDMioE8PXgdcCQMYIrW5Kq5P3NgIXn4Gma62YGL+cWoKUOO9z47S8JONP6mkJRpf+tV
 UiKUVK6yrDIiO9g9vqw==
X-Authority-Analysis: v=2.4 cv=aq+/yCZV c=1 sm=1 tr=0 ts=69c6d5a2 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=3I1J8UUJPc9JN9BFgKH3:22 a=pGLkceISAAAA:8
 a=yPCof4ZbAAAA:8 a=_dYJ6i6rdxd0-U-sF48A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: o4YDFORroleBBLFDFti_BiRdbaVrf-87
X-Proofpoint-GUID: o4YDFORroleBBLFDFti_BiRdbaVrf-87
X-Spamd-Result: default: False [-0.15 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	TAGGED_FROM(0.00)[bounces-20476-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oracle.com:dkim,oracle.com:email,oracle.com:mid];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org,oracle.com];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[calum.mackay@oracle.com,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 6214A349F4C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 27/03/2026 4:26 pm, Aurélien Couderc wrote:
> On Fri, Mar 27, 2026 at 3:47 PM Aurélien Couderc
> <aurelien.couderc2002@gmail.com> wrote:
>>
>> On Fri, Mar 27, 2026 at 3:57 AM Calum Mackay <calum.mackay@oracle.com> wrote:
>>>
>>> I've applied most of the outstanding pynfs patches, and tagged and
>>> pushed pynfs-0.5
>>>
>>> There were a couple of patches with which I'm having difficulties in
>>> testing, and I've emailed the authors.
>>>
>>> If you have submitted a pynfs patch which doesn't appear below, and I've
>>> not contacted you, apologies, and would you please let me know.
>>
>> @Chuck Lever wanted to contribute a test to set an ACL-on-file-create
>> and ACL-on-dir-create.
>> Was this never submitted?

hi Aurélien,

This is one of the patches with which I'm having test failures; no doubt 
an issue with my test setup. I'll apply it as soon as we get that sorted 
out.

thanks again,
calum.



> 
> Forgot to CC Chuck Lever
> 
> Aurélien



