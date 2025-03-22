Return-Path: <linux-nfs+bounces-10761-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E138A6CA92
	for <lists+linux-nfs@lfdr.de>; Sat, 22 Mar 2025 15:31:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB7A91B61E87
	for <lists+linux-nfs@lfdr.de>; Sat, 22 Mar 2025 14:31:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A037249EB;
	Sat, 22 Mar 2025 14:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HYPD60Ql";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Z+Laqv2G"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E15329A9
	for <linux-nfs@vger.kernel.org>; Sat, 22 Mar 2025 14:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742653902; cv=fail; b=XRNXcO6TTupZ24PcQWceeHR+epQN1IRA332Q4SBgOap1ShLbN5NWpKmDp+0RtTAAmVpFWldTKTay5u3FsKvpwuhhHAlSBGbgEb5oEGpi6bz/+MnkRMkCG8zdz9f8BCyRI+NPEllAoxEFf+6/O3Aj4WIu/4g9NvXktcF70DgYikQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742653902; c=relaxed/simple;
	bh=q5JGeF1b1PQrZ9WU/y/mSYlNuF+7ss+2NeZn999BlHA=;
	h=Message-ID:Date:To:Cc:From:Subject:Content-Type:MIME-Version; b=H8byF8GRU7iAzDMQG+M7fPavGgLzUZpw4YFEX/52ZD7XgqwsmR4R6WfjBdAGXkx7N868IFSi5Mykimky8B/oCAfe4ak5IH7vYtVFfkz4b8wmNi6hlxGrW5MGAyjzGdAK2dtJ/oveF5bNYX0fBsjqO62W3yI5cRzfBU3RZREefAQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=HYPD60Ql; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Z+Laqv2G; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52MBsqtL021696;
	Sat, 22 Mar 2025 14:31:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2023-11-20; bh=CpNZ/Av2Jmn5brZV
	tybAa5G5jND2qAMxEYmOuvvSwMQ=; b=HYPD60QlskebFfdiIRQ6FznLRw4xJCKs
	Hn8cXdaFcg89SrWFcSUzCuPUFLvoRIvuG+WOPrb7YX8pvvtOSRrSlXb0F0AY2LyK
	ibqRJA3jG115huU1X2aU4niAa3/fFesjNOonpWQ8D5yLjsbkNU1FjCZzBVGqRJOt
	wHb/isP2dbb17Q+ZNrOO3XCaGWGWIX9tnvsdB/eEfgJSvzASCQQbJcMeK8EVRA/y
	jJhVW8kYdmoCoTIzyo5GLCniuE+2582FoYVuWRIUyEHyN8DoVa31m1fWXcbmYtPj
	H7bGe4A7obnnOv7L2089rQFec6rYRjOX6Mp1fDmOXe20kdpZPYiErA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45hn7dgrst-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 22 Mar 2025 14:31:38 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52MCWlhW026209;
	Sat, 22 Mar 2025 14:31:34 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2046.outbound.protection.outlook.com [104.47.58.46])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 45hkncm52b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 22 Mar 2025 14:31:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yUofbuVFDxVR70BwLfrh0jB/8eFtUFT7bH3SOFofhG0SWM1FeISvwYrDk+psr0Il7b9YahSjSgxWTd41Jb8chDSnJGYxNc3Ea91sJT1nSUD3hsKRb2hFmTZo57gPHRegsh4e/ynTSw1StUoOo+bsx+KvNvEW/4Pet8bH+9FeFlLFBXScIHBNfiztHJTsby58kAWMm1RJd3PcXla6hOYU9G7ZAwwb4XtUQkKDKEbn+Lgj+2TKXvBXTRe4caIUHbfHn5TK1Kr7WZkOb45ZqaFedMuGlk6kSWK6XOGQnGd2AKlNb6NUHv/Zi9YwlDWogvRVoLPRpTXKB+DIewpRqke25A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CpNZ/Av2Jmn5brZVtybAa5G5jND2qAMxEYmOuvvSwMQ=;
 b=V3HbEqYGeso5ukumo+E+iiBq2oVDIhu70FgUXuxO8A5jQQchM24eJDGn0pH8umpbYb9s1lLwR9PapmO4TQpzakJeHtV84jkqJ1RPfI4GhSiuFrX63FxiiOzjsOI82wkyKaUp/qALy3GN6m5l6yTLtTrrmfYVt0VKRjBPo6s7gk1XtDmYkRzEudRKyv/1TmZ6E6793KDKzbHaNagRhgEOpcCGItJ6lR4dpCbhKS+pMJVV7ihDKbBALRYZUYgBq4v13RPwGlnDzPeExlf5vJI6wSnu3bKn5/p2v6OZZD0+VCqatUe+OjQTGC+fbMWlwHVAHyvMcNlxTbSe1ws2vNwTpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CpNZ/Av2Jmn5brZVtybAa5G5jND2qAMxEYmOuvvSwMQ=;
 b=Z+Laqv2GDyzxHG3R9AQ97ALQXCbhdxp6tqjRLjH+K1VncrVf28Hn77+ZLpcBcnbzmDUa3p4h0sDxoSJaeSBZzgKC+GGITnzkhoMJrC5g5tSPV7MbfTbNCa0zi45RJhwC3KvxMKZWI8IP97kez6UDyL7ezJGRGqYvVlFzBT+m2I0=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SJ0PR10MB5717.namprd10.prod.outlook.com (2603:10b6:a03:3ec::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.36; Sat, 22 Mar
 2025 14:31:32 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.8534.036; Sat, 22 Mar 2025
 14:31:32 +0000
Message-ID: <b7223c8d-22f8-4a6b-b5fc-635f0ba0f01f@oracle.com>
Date: Sat, 22 Mar 2025 10:31:30 -0400
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
From: Chuck Lever <chuck.lever@oracle.com>
Subject: [2nd notice] Announcing the Spring 2025 NFS Bake-a-thon
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR12CA0020.namprd12.prod.outlook.com
 (2603:10b6:610:57::30) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SJ0PR10MB5717:EE_
X-MS-Office365-Filtering-Correlation-Id: d3c52749-ac8e-448e-23df-08dd694e3d89
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eEIyVE5vOEdSeXFmNE1DRmU0TEFTTlJtTFE2RHYwU0hpY3pqUHNJbkYwMlFE?=
 =?utf-8?B?cEVDeWcwUUYzTy95bHd4M0hrUEgvY3UwZ3p1aGFhaWJNWWRPODZIdjZaZGNu?=
 =?utf-8?B?a1BPeHN6RGloZW0yMXJscmJqVmtJcDlGajRBa1ZSU2o5eXIyQUVFYTR1VzZN?=
 =?utf-8?B?Z1pGdUpzd2NFQmVtV1BhRGxpQ1RsaWFuUmlzSHZnUlFCdnE5U1pXWHBISFpD?=
 =?utf-8?B?WjduZnFIem43SG1SYnJISmpqVXFjVXBrTWZZcUR2MzN5cWM3U2ZrVklVeDZ4?=
 =?utf-8?B?ZUtxOVFQTWhheHBHQ2pUeWptVVMzeDk0Mnl5TGpTYnFxbHk5bm1yY2l2VkRK?=
 =?utf-8?B?MGpwR3dpbEhZRkkrT1ZROC81TVdaYjl4RTdZYUhWYlVBTGxQTW5ZWElrb3Ft?=
 =?utf-8?B?U1VYZm5iT3MzRUNRN1FDc1BWSUpKZDRlaFMrRzZkYi8rei81dm1Ldmkrampt?=
 =?utf-8?B?Z3FXaC9idjVvV3JhSDZEbjJzOG5Pa1d5UFRydU5lVlZBanVENWJnUERmT0xV?=
 =?utf-8?B?SXRXdnVpS204NTFmQ05MbG1DMGNvY2dwYmJvaksrbC92Y2ZZVHpvUnJMNVIz?=
 =?utf-8?B?VStvS3kyQ2JpOFZnN2VBampCQ0dBKzh0VXZNbkJ2M3BONERxQTVHWmZ2Tkp6?=
 =?utf-8?B?VGVLU2R0OGU1cEZDM2RCTHBqdXM5bmh6TVd6SlFyaEE5cmRsUVBQMktsVHB4?=
 =?utf-8?B?SUwvUHM0LzkvTm05UHJIanJLbE9QTDFkU1U2STF0cGp1NVZYUjQwOEZtVVJK?=
 =?utf-8?B?Q3VnVXkxdG1qZVFnY21Zc1hPN0FiQmUwZnErSXZnVTQzUER0dncxcUhYK3RB?=
 =?utf-8?B?Q2pqVWlhSnNJWXFwRWFOY0ZVd1dkQXY4S2FtYXQ4N0ozcHAxZHhyMXpjZyto?=
 =?utf-8?B?SzZaWUMrNllmdzZHQ0QvVHdnRVpZSkNheW56MnpEU3E2ZzQvMVo0TlhWVGt6?=
 =?utf-8?B?d2I5SStKb1I1ajNUYkJiblNWZFRMNWJLQ0c5RlBESUxqeWl2QktsZnpaczBj?=
 =?utf-8?B?dDhRMjVMaG1aRG8zK2FzamhmTUQ5UXVJaVRsczJsek5ZcjNneGJudlZwTUdS?=
 =?utf-8?B?Ui9GZFh3K0F4VlRCbXhYU2lYT0lHTmJBZXN2bFp3RDYwMElIeVZIWDk0akpM?=
 =?utf-8?B?QXA5eGxobXhNZy9GWlNvbnQrS0pFWlJscFJyaVMyWVN3Y1dOZjBKNUo2dDlM?=
 =?utf-8?B?QnJpemFoZmpRcS83WWxXcDg1MFRuOHFKUHNnZjdETFVGVkw0TXM2U3d4RFZv?=
 =?utf-8?B?cTM2N1BPVDgxVDVST2liNSs3VVYrVmRGdXltd3dYSTYrM2x6cVhvdlhzSTFG?=
 =?utf-8?B?UkNXR2JqcnhESUVPYTdzb3gybVl1WHhiRFR3QlovdjRyamtTb28zeHZJRGFG?=
 =?utf-8?B?eDU4T1psak5sYUFxZmhSSkk5MVh2M2VHaUN6TGhDUWNwU1FGeUJ6OVh3L0VR?=
 =?utf-8?B?U1FiVWxHQnArZWY4L3VSTlJYcnkzT3FTQ0hsdGpzM1U5dG5mUEcrSW1rV1dM?=
 =?utf-8?B?YVk2UTJYZHJmTU9pNGt6dlVmSHY1RGZnOEx3N2t6NWJHUnYvUnJua2Njei9U?=
 =?utf-8?B?TWRHVitCZ1lOZFMzQlpOQjFHY2J1OUVVQUh3UjVGN2FNMkFHYWRzMzJycHQ3?=
 =?utf-8?B?V0J2a0dqdkJzdnRVWktTYmFsTDkxcGh0aW1reWJuYzU3cnRCWUhhVEk0R1dT?=
 =?utf-8?B?WXo2aS9mQnZ2S0ZoRWprVEM1ZW5RMmRZNGRDOFJjL3ZqcndjOG9BU3J2ejU1?=
 =?utf-8?B?aDZOL0dXTUJjRXozZG1zdzRQMUJacFhwTithVDVUamsyelNEZEVBVUp1T1hP?=
 =?utf-8?Q?0Xgoqbe4W8cGUVjVmvfD+wFNaNgCYA3/GeDc8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T3JnQ2dTZy9GWUNmWGc4VHhOVkEzM2xodjFOUCszZXYyTlkyRE9lcS9yWVhE?=
 =?utf-8?B?cWsxZW1TOUpVbU5PS3k4SzdqdVNkTjBBczFPSEsvbUdXdUNtTEtQb1g0aDd3?=
 =?utf-8?B?Q21qZWNJc2JpV0ptcGh5azF0aVR6MFNkcVM2Q0M0cEJrVG4yN3ZWV3g2ODdw?=
 =?utf-8?B?VitXQkNlU3lyTVpkeXA2VHNnT1ZDUHM5SHhzbE1pRFBITkk5LzBMNVB4d3NV?=
 =?utf-8?B?WFBXdHRGSkJPYzljNGJiSkZienA0WlZWUVhUcjdsL2dzY2RUaXpKNDFCZmo5?=
 =?utf-8?B?eXBZNXVoaWpIaDM4UWo4QnBLS2dqOUZDN3BVOVArTHVHUU1NdElheWVBamlv?=
 =?utf-8?B?djdBaExmZmxsOHd6SVFQblhvUjNNZjRYUDJuRWUvZFpaMjFmNXJtTDhUMEdz?=
 =?utf-8?B?VzJPUjk2N3ZyamIzcDJPN0FoNjQ1M0hSY1RxVHA3UVFrQ1A0ZndkT2FwOTBG?=
 =?utf-8?B?dEk3Z0Y3U2piN3dwQzlvdDJ4NXBJcGdwTXgzTXpzVWVtWUJrT0hoNW9SNlVw?=
 =?utf-8?B?L2hsNDBiK2lTL0NORnJFdEJPK2tURXltZzdTelpTVWIraWdaa1k3MG9XR2Vw?=
 =?utf-8?B?N0ZzdzlaUXZsT3VrbUlGaTJOdDk2aVZpUVdCV05yZVUxVFJkSGtHWlZDWEN5?=
 =?utf-8?B?cG05TEVXYWhkbGRGclJIMlY3ZEdNZlBnMndBei9KYVJsTklER2p3VzVyblNa?=
 =?utf-8?B?N3c0NVNZcFRJWnNXSFQ5SHBWZ0cxaFp2aHV1Vm5QZjlWc1czaHpPb3dPOVdW?=
 =?utf-8?B?ZXF4ZFlRL3NtWnEvbG1yNTNkYXlUcElRNVZIcXI3RDZFMTloL0tpSitlSXI5?=
 =?utf-8?B?WC9LQnFneHc1TldxZEc1SjRVUWJJOUZ2TkRGdGtwdWdoQ0ZPQ0Ixc3B3YnNR?=
 =?utf-8?B?RUk0S1JoN3BpWkF5NndSQWhzc2pwVmpCQ0Flc2xpS3BHSHUxNHREWHpYZFdt?=
 =?utf-8?B?VGZvM1BoMTF0cmRXTlA0RWxHcHFCNjJWRFo0QWdSWmtGcTRSbnFSZXVrQVRn?=
 =?utf-8?B?TzBJUmRYa3MyYmY4MHlxYVZObVF2N2dsOEtmTGZsbFBrUUUvSEd6aWc5clpR?=
 =?utf-8?B?a2EwTkF3eDdraEh6WHFvVmpqazRvTHY5OGd6ZEtIdXhPeHhBR1NwNTBQNkZX?=
 =?utf-8?B?bTNkZEJsdm5JaWNYaXBQWEtDR25lNUFKS0wzT3N4Z0FYam0wakpVaXF0SS9D?=
 =?utf-8?B?SEV4NXVYUjJXT3NSN3pMT2VlZWo3NEV4K0ttVFhpYnZVMnVsN3FSRys2WmRu?=
 =?utf-8?B?eC9hWSs1Z2hIaWNUZGR3RDdONDUwYmd4eXZtZTJMTEpLL1lGM1F3dXpWNENJ?=
 =?utf-8?B?amhReDh0aFp0UHEyUUM2a240djdSTFdVWmRDSU95eDhCYXlQYkRGSTlGc1oy?=
 =?utf-8?B?ellTSjdPcVRuWU9hbnJFc1BESFZDWXExTjczMVI3R0xoSmpTUFNKY3dZOXQ0?=
 =?utf-8?B?cmMzQXFPNnR3VzFsZmFQSTFKNEdrQjFPMG9GdURZQ3lCVWpLUGFwKzFWejZy?=
 =?utf-8?B?MUZiRFRseVk2QXp2NTk1Ny80NXNjblFDWW4yZ0p5RW8wM253dmxZZTZIODdW?=
 =?utf-8?B?N0pvWmg0SC80OEhqYjAwTFFYREx6bUdYU0ZzaVZUVUhqb0lwR3BCaWY3RUNW?=
 =?utf-8?B?dmY2TmwzNzA2T3UwZGFTZGQ4QTI1aW9yZ1hod3ExNG9UL2dRaEZFRWZHU2Fn?=
 =?utf-8?B?ZERRV3VaWlVxSEVSVzIyUzdBMTQ4Z09xdk9SUUlsRUJOM2pZQnlIUm9aTmVH?=
 =?utf-8?B?TzdaejRrZnVnWCtsOFBBaDdrSFpzZ0s4Q0VGYzV3WkhoaEh4YnVPL0FMTGFE?=
 =?utf-8?B?QjdXNFN0L1ViYU0wQ01kQzBzK1hxbmFqZnZwTjkrcDlhMWlrb1RJY1k3ZXdl?=
 =?utf-8?B?M1JpdVhZYys5QXJpWDVkRCtWL2pRZzE0UnpUaWJkdGVaUjlsSDhTSTdZc09Y?=
 =?utf-8?B?SFhzQVpTN2htSVBRZzZqclppUVB0RWtncWlULzAxVEw3Qm1EeHhIM1FLQWhB?=
 =?utf-8?B?SXE0WkZiSDJWUGYwT1FXaTBpS09KZDErRGtFNkRqTDl2ajBRZ3ZFWEh2RWh4?=
 =?utf-8?B?ZjQ5THJoYzc5YTd1cHZPMnJtcGRKWE9WL0NzVWhDeXdWWXE3T0s1SCtrVW9a?=
 =?utf-8?Q?k5r3WcQmt9xvHSlaWV3byJ7nA?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Z50VsjFlyqlMcwg2s8gbLuiFci1vvFu3NLGRfOWBAE7JA9nZ71lqsElFrs+pgLdhU+Phu51EoLLoYLDYy5+thp6cirInbQXmATqqvYZ1g0K1LTFys5Ot7lARhARLvxav+4rVeulqwq+nY4jeC14bViBGwJpaaPH7Y7yHzipgXTDTKamQsEOp5P+O/Ng+cG56GDvQ6Oa5ZxcQ1DdKNHIM323hXW6nSMFr3qzPKHgLA+Yk9cEToTei6l6zlF3bpUuaWZJ5LxgNH9Vp6grJH3hWrm9QSOfBuaCBW4uOfw7Iican/q1U9tQ55MHHTJFl2jqSrmiCUdV2OcIDE3jCLEFyOxKeL7qLa+8MytlNjJ1pZ1zwCT/3iscO1BrbAgsuldLM3skimBFwgx+Bj+VfWwYI1XMuBoFkaw3JWT2geGpnP0GPHUwYzBrynb95F7+IgKuAPTHLV+tgSNODcdaIkVjVhv2G8G9bOwPdDbDGsLPAoRMiwTax9Y71FiJ4/oOsNBiMP9N7ZM3y9FjNYPhAu4Gc1l/RgfFH+w+VJPcs5faCnoXP5qiBzCizCva3Q9nDH+yDHteySRjWi9mv0xou1SOU8kCQsson+Fcb76c/LR0R5Tg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3c52749-ac8e-448e-23df-08dd694e3d89
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2025 14:31:31.9373
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WacgTssm6n0WcWAsIdCo3uiw/e/ddqme3nS7t8Fcu96aN46UrL8GDYuN6QNLPpVY2zk+ckyRNjT9WrWNwbnk1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5717
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-22_06,2025-03-21_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=726
 bulkscore=0 adultscore=0 mlxscore=0 spamscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502280000 definitions=main-2503220106
X-Proofpoint-GUID: wR594rJaqgo5EEGpciIJ8QEHajMWxea2
X-Proofpoint-ORIG-GUID: wR594rJaqgo5EEGpciIJ8QEHajMWxea2

Greetings,

Oracle is pleased to sponsor the Spring 2025 NFS Bake-a-thon event, to
be held May 12 - 16 in Ann Arbor, Michigan, US. This is an in-person
event that includes secure remote access to the test network via VPN,
enabling virtual participation.

Event registration and network, hotel, and venue info:

http://nfsv4bat.org/Events/2025/May/BAT/index.html


Questions? Please send them to bakeathon-contact@googlegroups.com

-- 
Chuck Lever


