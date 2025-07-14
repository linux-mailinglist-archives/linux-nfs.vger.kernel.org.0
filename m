Return-Path: <linux-nfs+bounces-13054-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C6026B0421D
	for <lists+linux-nfs@lfdr.de>; Mon, 14 Jul 2025 16:48:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA1131A6512E
	for <lists+linux-nfs@lfdr.de>; Mon, 14 Jul 2025 14:48:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 947B51C861D;
	Mon, 14 Jul 2025 14:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="q654BDwC";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="xo4C7QVF"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA0D91922F6
	for <linux-nfs@vger.kernel.org>; Mon, 14 Jul 2025 14:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752504489; cv=fail; b=b3AgQkePvP+nTHlQxOrDZ0yn2/1N+j2bOqxZ125OiGcAgMKlJN8yLmv+Ut6vaDd5+CjnosznLix1mbY01+N8t72Mg+0MBs7mSuSBcDvJGi2DJSlAUiRNvgsTt/65yCibsYOnP16kfl9fAHU81JCxuaSEICFm7Tk/rlh+ZDdbnco=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752504489; c=relaxed/simple;
	bh=8uYe3oVA1vKRcX3j2NkgcGlxoDsZ6byxFiQI2qpOPoQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NT3RDyaQryB0DElLs5QOw06SKooyY5+U8S2M+2RQI63tKmrC+9FS9zXnrI8gkOELqO2lWVXmtjEwlQLgjxqSGC6ElloDQj7fn2FBklaQyLHuo8nG5K8//TAj4AajrZ2f1ioA0i+Bj5yR/ORrWv76xUTjq5SQ883+9xypiJOqrd8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=q654BDwC; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=xo4C7QVF; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56E9Z6FK001413;
	Mon, 14 Jul 2025 14:48:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=R1RQ2VqOgH4WxXgpiyBQYS2C1VYbLqX+Am6qhUhHHls=; b=
	q654BDwCGx2efYPT/2DCDnN19pkdW9zRe8cQlvgIcXFaFCMUc/Imwc37ky6twdbo
	FYL90oBVqZ++dzfxfpOgGJAN+hGp/Y3NcCxD3f59jWAG5QhZ6fmFDe2f4hCFa1EU
	fkqSRiUPVIsWXTHxLXZkmycFDGg9aMrE+j9aH42qsE6QpJVvpjFUGkwBiU+bITEa
	O7FitFkxN4C4KiXbe9bWd35WiY9MtAgkCHiYPejU77vTUPQv2tzGDyFJ7UGbVVFQ
	nmLTZu4ONAB4Ow3r7SFtfKqZcbog12IpiDdNsDkAk8eeYmdNrnC4q0a6OC6FZrVS
	vs+WYuZ1rfEeYD8TTv2BAw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47uk8fv9ne-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Jul 2025 14:48:01 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56EEPSAn013811;
	Mon, 14 Jul 2025 14:48:00 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12on2064.outbound.protection.outlook.com [40.107.244.64])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47ue584dxn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Jul 2025 14:47:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wjqYKB74LL8hRoSfjJmo6Cvgjm0qSVxznuMfnm+SduojFmZmVe1XyRO/3lVqjQKDwQlTUeqU/vCiO5WoPNrp+0aF1auvXYE6lTlqdBUIaf1e0/6NucZipGeXsnS/MS9Tr3+rwgyUA2zuKR8bx1/cEimxlfcifObuqLqTw1DaebzW+rDb/50dVicJXaUvkyD6ym2Emqo3wJu0Xaz1l6a1a5lKbc12qt8R5wuNrfDnWhdftWvhWTAl5oBd/DGogUcChDyYpDkoW1bMS83DOtSlhxDlaHxiof1CHUWUilTGvIF/nNuIYX6X8SeNTgVfz+35biLvxTYKuliLLMBkiq0/BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R1RQ2VqOgH4WxXgpiyBQYS2C1VYbLqX+Am6qhUhHHls=;
 b=aB125L0x/aCbSEd6F/ZCNliyZBFY5bKo0q2rBZA/lwpeN10lWU2fQ5+gbdqDnP/kQprP3rPwWfalNMNVWjGi182DWzTsPak+P6E6Z9pg4KNMekOxk13aU17fItQHHmtx9LHemayGR2LP74h9UWQ64oziMzJDHU5EsDBgOGImwJZHxAw61s1yz7d5tZraKxG73d5sip8IbzdWdtNW0VfR6cj0CzxYy5wbCAIEFISFutp8IJglU0YjOBbdC0z5wbzBPn8DlX8G+iPiBiW9mzYrjnrBCt8eD5oeyywMmi/ExJawhhLfwci098WSegdNIWX8NWCgz3ytJywm+cD6U/CMkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R1RQ2VqOgH4WxXgpiyBQYS2C1VYbLqX+Am6qhUhHHls=;
 b=xo4C7QVFKjks8TUYFNQh7+nxfQFvr0k4Atqkk7Fnlu+VtIeA9V0vzo/l3fqiQ/iCbJOe6M85+Yc3zxl7wlEKfeFkDd3K6ldiwqsDOcxS4PLUk6WAZI4VXPBZsCS734pdI2t2Hz/OIiDtvnnVyn1029eqd8GiU1lPPz582yVlWfU=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by IA0PR10MB7349.namprd10.prod.outlook.com (2603:10b6:208:40d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.35; Mon, 14 Jul
 2025 14:47:56 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.8901.021; Mon, 14 Jul 2025
 14:47:56 +0000
Message-ID: <6b5de853-b283-4b5e-9628-fd0b50d7645c@oracle.com>
Date: Mon, 14 Jul 2025 10:47:54 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] NFS: add a clientid mount option
To: Christoph Hellwig <hch@lst.de>
Cc: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
        linux-nfs@vger.kernel.org
References: <20250714063053.1487761-1-hch@lst.de>
 <20250714063053.1487761-3-hch@lst.de>
 <cf337014-f8a6-44d6-8760-61663fef576d@oracle.com>
 <20250714133135.GB10090@lst.de>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20250714133135.GB10090@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0084.namprd03.prod.outlook.com
 (2603:10b6:610:cc::29) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|IA0PR10MB7349:EE_
X-MS-Office365-Filtering-Correlation-Id: 278096b7-d09b-4ef1-2471-08ddc2e56b59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ejA2MFYwdmF5WmtoTzhPaG5Kdkw3UU05NUZ1SEZNN21tV3ByZE4wMWI5RnU2?=
 =?utf-8?B?dmhoemNEQktKVktLWHZvSlNIbE9QZnZqT010VFR0NWNEdnE2bzlVYlpCRTNn?=
 =?utf-8?B?MEdhL1c2TFdkVzh3SVNVSmZDY2Z1eE1LNnNYL3dwU3lNZWgzVUdZQ0k4RUo2?=
 =?utf-8?B?M3FhdFZacGlDZzZId3k1dE5TNmFINUgwKzRQSzJtZkQvcGJCMmltbTJ2OE1N?=
 =?utf-8?B?NGZVSFFFTVdmWU1ubVA2NnhjT0orZ1djZ3pQRGx3SHNxYWx3TlNVZlpkVzJU?=
 =?utf-8?B?bEFPMURHVUFDc2I0eFIrLzhCaGNsdUQzeS8wNVBzT3o1ZjRGTDNXVVRGNWRa?=
 =?utf-8?B?M1lhc3VDcW1IRFRmSWU4ZWFCYkg5SVpIUC81RDVNN1pXVXlaeGJjVjRjS3Rm?=
 =?utf-8?B?dFVuNWppcXJHa1JORTFac2kzby91YnVtSUNSVzR0QnhOc2JUM2dGSUdPa1FS?=
 =?utf-8?B?YnF5MExVekhDZjU5aytvZ1JkZUQ2b282T3RIUFcvTzVIQXNSK2VqMkRTRGRq?=
 =?utf-8?B?d1psTXI4dVJyTVVibDJIdnAxUkxsOUVQTWdmZTdtQ0tqYTNyM2ZOaGxnaCtu?=
 =?utf-8?B?eXhqTVhpMFlQT1prWS9xRlB6NjhMU0pvZGQ4T2IrUWZsTVpZYnlUOWluRTNa?=
 =?utf-8?B?VlpyMVp1YXM0QVN4Z2xZL25GT0VNYkJUOVVxT2dUM1RMZEhuYVZUV3NqQ1Jz?=
 =?utf-8?B?ekJsSERvN252T0RjdDJDMUpWQU1mY2dGVENsODhIYjFDYStFSW1xR2xXeFpp?=
 =?utf-8?B?OTFPY3VmakJsYnc0cVdiTGQ0VmF1OFZrbm8zUHVKSVh4TmFmSGpXOFVQNzRn?=
 =?utf-8?B?WC9hNjdtNEI1WUlEMHhNNDloQ0NJc2JzS2RpOWJBa0d5Y3Jxa1gzRk10QXNE?=
 =?utf-8?B?a0dZZ2EyUjlRSzRndWtBNGt5VXlqN3UrNkVqT2Y4OVpLQ0VIdzU1d0JqSkdW?=
 =?utf-8?B?NUcvRUtTSy8yOVlMdnNweHVCaW5hOHJGNmR0V1hkeFBadjYya3VUa0thMU03?=
 =?utf-8?B?cTJJSlBuM2RwSGttZnAwcHFUdHhMcUJOdWJxZ2VQY0xsQnA5NHJiL2ZUcSto?=
 =?utf-8?B?U2k2NmlJMUNvUGxQUUVobnVVcnVUM0podTFyb3VFQW5EbVFnQ0oxL1ZLemg1?=
 =?utf-8?B?Z3NJeFVpSHNvVW93U1QwVTBrV0h5NmxpK2g5UUF4TGZpdkdocDJRa1Z2cGgx?=
 =?utf-8?B?Z3JGUSt5NEVqK0VRU3EwZ1ovcHhxcG5LejFZMkRGTEl1YkFydHFYdTRBd0JS?=
 =?utf-8?B?SER3d3NNOU9IUVVIMXI1aENDU05BaVRZRytmaXVKMC9xUGZxd0d3SmJoWnND?=
 =?utf-8?B?SmFSUFp4WGxZMnJnVllBK1IwSWswd1NUdTRxVlA1VHZTNUV1MzlUMUxpSmxK?=
 =?utf-8?B?Q2hGdmV2ZUhCdjJZUUxLTGJWUnlDUzNocGVoMkRCRGFPWlRmaENSQjZSRlRl?=
 =?utf-8?B?OVlMTEtBMTNHaUxsZm13MGRwSFgveFZHNDZZd1Y4eHN2cDBBbGs4c1NyMDRH?=
 =?utf-8?B?NjJtNFZCTUJqMnA0c3Y4ZXZ3WWo5R25UbDJFT2gvQkVNY0tZSklNRW52d2RD?=
 =?utf-8?B?MDh3Q2pQTEw4ZFU2alQ1dWFlcUlGNGdCVUgvODYwKzBQOVQrMDluK003S29L?=
 =?utf-8?B?WWg0UE9ubEpIMGl2MStTdUowak5NUVFmV1ZPZE9OcFlTQ0x0dGx2WG9NeVFj?=
 =?utf-8?B?RHdCUnYvdHRRbHF3Qk9GcnBOUTErNm4vYzQxWURqRnpsa2FFalVwaVUweitR?=
 =?utf-8?B?M2dwSUUraWxMditvcDYvTm5pUnFPcWd2bWJiVS9yWS9TRTVsSkZOVHczdmhL?=
 =?utf-8?B?ekg3dGNPRTlsYWRSeFhoZHA5dGZmNjRkWGE5S1c1cVhLY1RsMkFKY0FCMkRC?=
 =?utf-8?B?aXVOSEovdFZWb3FWNlBhVTJlWm5iWTZKZk1RNERvS3libzAwS2J5YVZ4VHVK?=
 =?utf-8?Q?+oyzqYhic40=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?azIvVEN1Szl1QUE3MW1hbkNUN25oMHg5Wm9GOXFZTzhDVlZqNGJhUTFPRllT?=
 =?utf-8?B?cm9kS1JUZ3hydlE3YTlCTlZaNGs5TC9JVVdEalhyV0djQlc3K1hERHNMNnJ4?=
 =?utf-8?B?WHgyU3VKTWJmNFMyVTRIa2xmVkQ3ZUNLcmlsMTZ1VFJoVnlOcnpzMDNkYi9B?=
 =?utf-8?B?dkYxeG9SWndJL2JpRU53YU5wWHZDZ2xieWc2dDU5Ulp5K2RiSGUwQlNTaTlo?=
 =?utf-8?B?RktjTWg4Q1doUDVHWkVzV2NSc1lhN056TVljQ25wdVdNcUo0Q0FhdVVUSlN4?=
 =?utf-8?B?M0hXQmo1SmhmU1FKemxzVVZjUURsZWdNT2huLzVvWGdFb0RldVVsYzc1T3pF?=
 =?utf-8?B?QWJSbEtISGV2bDRhb3BYdXA2NEM3bTJoODRFV2ZoallNdzk3OHlpYWl6eUgr?=
 =?utf-8?B?N0JnNExEUHcrVURpZU1rdjlWY2xyclhTQXRraXEreWYycGEvcHhPRUphWTZY?=
 =?utf-8?B?ZDBNTTQyWE9uY0c3Zmo5U0JwVVFwMEplTFV3TTcxTGU5UDlwL1cwLzVMTkpo?=
 =?utf-8?B?V2gramRLSmtzS2ZzNlBXOUZ4Nm1tRW94RUU4dWE2M3NnVTRqQ3VodUNCTjZG?=
 =?utf-8?B?NWlYVytEYkNMZE51eXZDUUozM08vNkpjNTgyZWVVL092eGFRYXF0ZmFHa2ls?=
 =?utf-8?B?OWs2a0lCSXE5S1BsZEQwdGV5ZSs1aExUeGc1SUpWU2ZyMjFYSENoWVRlUlZm?=
 =?utf-8?B?WEVTK2QxZnpQL3pQeTQxTUJ6Y0QzTjJZN3RBclN6a1E2UzlRNGhXZEtHRHps?=
 =?utf-8?B?dVJGSUtWUFNhU3JtdURRem45RlFVcWlZZ3FIUjlRZTAxb2JVNDFLOGNySDgw?=
 =?utf-8?B?bDMySFJ5RHZOL0tNYzdqRVVXSmVMK3J1Sm5oRGhGMUozK2JJelJralpnbERJ?=
 =?utf-8?B?K2VBODlpN2hSZFZrYzQ5TmFDTXMrT1BwZXFQMm8vRjlpb0V1d2szanhRMzVp?=
 =?utf-8?B?bnd1bS9JMWNYd2VEUkdIWDR0SXpGY1djbXlHM3JWYlU2NUxDcjlTelJldHFY?=
 =?utf-8?B?Q1NuRXNScHczUGI1cStyTnIwek1ia3NNNTdQdVh6S2NLdVdxd21ETTFrMEVs?=
 =?utf-8?B?RDhkZHNhUEIwN1gzL08yRGZtcFpqbWFqc2ZFMmVlNHJCMldaQ1M2MGxxbWxi?=
 =?utf-8?B?QStqbEZjRElFRzZaNGs2UGJ6SFVHVzlVSnpWbGk2TzVRSFR5TXdrK0hYS2tw?=
 =?utf-8?B?QnlRMlJiRWVHOEMwR3BZQ1dJczRFbExURHI0RWNWT3dOcHdWdEpyYkNyMFh6?=
 =?utf-8?B?U2pEQnJiazlKc0tkcXI1ckJVbEpQWlN2Y0s1NTdLK2xlWmFUdXhwSkN0YWpy?=
 =?utf-8?B?QXBLL1ZUKzNKd053dzFlbnZFcUpyU1h0bzNubFpwZFArQ2lSQ3ZJRTNEK2wx?=
 =?utf-8?B?ZFJ4RklJTko0VnFtajVvWmsra0JudDM0dVNPYlBiVDI3TnpZSTNDYWo0TW1L?=
 =?utf-8?B?aStTOFI1MkljbnBYYjA0R2k2R2krQzRPelZaTDV0RklGZ2FCNStaOUUrNnNH?=
 =?utf-8?B?aStiSVZsOTluY0s3SG81b2VQS3B1MnVURStCZ3AvVUJwQjJyVzdvTmNzQnFt?=
 =?utf-8?B?QWh0cjRuaHFaQmMyczIyTk5WQkFxUmpRMWtMczh1U29BSEM1TEhlaDZJT056?=
 =?utf-8?B?NFc4cmpyYVRRTGJJd1RwK3pCd0E4YUhGZmE3bjFHNnpvZVh3dlJUNTdTeUhN?=
 =?utf-8?B?MFJIakc0WlRRM1VXc2YzRkJqZVF3dnNucmhRVDY3ZzFLMDVSdDN3RW9YVHBw?=
 =?utf-8?B?M1NmSjNzd1d2OXBaZ1hoR1lJeDE3cGdHdzI0QWlIODIrU2ZCZVlWVUdPR1NH?=
 =?utf-8?B?NHRybHcxYzJxREFWNVZhMzA5QXE1cGF3TzF6bldMWnl5a2dqa054SE11NlBy?=
 =?utf-8?B?TkRDbTdsaWg5MWYxQkJieE81aUlHRUFTdy9RV2pXOFFJSS9Wdm8vSzFnRGZW?=
 =?utf-8?B?bXJWelc3RER5SFd0Nm9NZ3lZQlJvdEp6YUJtT253TC9pdVJlRXJQRG96emNO?=
 =?utf-8?B?bW9tc1ZXSDdWRTdkdHdqSDdNNGM4bnFPN0VKNlhNMHBMKyswKzFzK2RaMWV3?=
 =?utf-8?B?YlF6MDc1RHJSamlEUjg3T2lBZ0MxL2FXaFF1UTV4d3JDeHF5TnJUR0o5cy9w?=
 =?utf-8?Q?jN/m938F6p19YGGNh0sLb9Wgo?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	UUZQ9EhIWNfJ7Mlz6uYX9BFJiaFOxfLzTohk+2W+gQkyB5b3i/MBtZI416Xc6WHa7m2BOZPU3ONxLcXvdRk0NK6uKaPYxU41RRFhDf/IVr0DNOf3Z8yY7IK1t0QDHnuE+YOawNMv4dqZI6FgSg2Pf7vqxTI0BlO6Egw7DpzvFww3pKbrFA5aPAlNE0/Xgy8dAyUX2GMzr2N5ffPYqW2jL7yZEQszo3INDfW4QL7bYSQAZmLSnrggRNfn+ZguNTHIG1nF2F8xzQS2MThPTPudyLQ4RzCt4s/Hl4Qf+LjSu5RbNeHhaSrXnI+txsNfjkVedbWBQdsjpPPPafmjofKgC2bgk2viz6Zg2Af6JMCcpjEhjRo383sDFkHf0yBkSAeU13ZzTcHp2hpOG7Zq3Rka5IWJQfGCsb8bHQjaeFFddnMjpE4lrF44d7mI2P2Mf91xmZo8C0vSsnllyyMrbENeSPuLUPHumwjDNV2aTnYFfaDmUEKoachamv75Lq5xBno2nXhRzshyR42SHMLnywu3sML9Z1ZDyvGgQmBN3BsZ+KIprZnV8BGiL1tJkpnp1qzf1dlHPiv2AuQCWbaOwjSqxQiY7qzhMTg1+y9qQ3rg1jc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 278096b7-d09b-4ef1-2471-08ddc2e56b59
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2025 14:47:56.4760
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YuE54rL/lqAxvsIX+ZAoT+W5Spn8iCuSsfZP/U6s2WQzDVLsa/ZiMq+B/CxeiZut0xS58YjMB048GAzoO+Gf7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7349
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-14_01,2025-07-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 malwarescore=0
 phishscore=0 spamscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507140086
X-Proofpoint-ORIG-GUID: Z7Yfzc6yixbL2U_VQmseBqtSbW8VIfIY
X-Authority-Analysis: v=2.4 cv=Of+YDgTY c=1 sm=1 tr=0 ts=687518a1 b=1 cx=c_pps a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=LvW1BXxXqpN5pY2-gPcA:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12061
X-Proofpoint-GUID: Z7Yfzc6yixbL2U_VQmseBqtSbW8VIfIY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE0MDA4NyBTYWx0ZWRfXxrQxn5o3m5zu PH3c3Or8wpaWS9QPN+M/IYvngX9WcB50NRs4wtqVE4T5/dQ44zuwdCixEZODec7U8QhgDg2XJTT gKXMwFQgxPTasrZWmFU6pBvxpsD5BZpdnprsS7Ji86qed4+x7fZd0lewuZRZHJxAc7A6bNG/5Jh
 A6+XDhut+KvmkGM2Sl6YpVfnxHDc4QacGBoAoshex0zRNpNuwGnTEbtJrOtDCvG8o2gSS6TRuYe 3GH1WAf/patgz2s05rJs+ckcmqLusStseKFw/o66eNQQhSakc52JN/U3+c79/mA+O9gTpmplm1D U4+FCt0/kJ5g5cl5lgheJ2eEbPxAPoQVlxMHbuAHPU670QH1Kzoe5UfKlb2myFjniwpMDNM/KZB
 i5YpCdHaEX2qP7Zrb0RCpQAxZvT+yDX6zVYMFnDYU2fxFRX/akdKinVhYtAso5K//IFW7VOJ

On 7/14/25 9:31 AM, Christoph Hellwig wrote:
> On Mon, Jul 14, 2025 at 09:24:20AM -0400, Chuck Lever wrote:
>> On 7/14/25 2:30 AM, Christoph Hellwig wrote:
>>> Add a mount option to set a clientid, similarly to how it can be
>>> configured through the per-netfs sysfs file.  This allows for easy
>>> testing of behavior that relies on the client ID likes locks or
>>> delegations with having to resort to separate VMs or containers.
>>
>> The problem with approaches like this is that it becomes difficult
>> to manage multiple mounts of the same server. Each of those mounts
>> really cannot have a different clientid.
> 
> Having different clientids for multiple mounts from the same server
> is the purpose and only reason for this option.

It would be helpful to explain exactly what test you are trying to do or
what bug you are trying to explore. I can't think of a way that the
current client code base would ever need to behave this way. So I assume
you are trying to test some kind of server behavior. If that's the case,
why not craft one or more pynfs test cases? (Or, maybe pynfs already
handles this case).


>> For testing, why can't you use the per-container clientid setting?
> 
> Because having to create a container is a lot of effort when all
> that is needed is just a mount with a different clientid.

Since this is for development testing (?) I am hesitant to endorse
adding it as part of the everyday administrative interface. Especially
since this will break things (on purpose, of course). I don't relish
having to support administrators coming to us complaining that some
unimagined future use case is not working with the clientid= mount
option.

If clientid= does get merged, though, what is your plan for an nfs(5)
update?


-- 
Chuck Lever

