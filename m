Return-Path: <linux-nfs+bounces-14807-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4AE4BAD1A5
	for <lists+linux-nfs@lfdr.de>; Tue, 30 Sep 2025 15:48:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 502CF1721AE
	for <lists+linux-nfs@lfdr.de>; Tue, 30 Sep 2025 13:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBB741EDA0F;
	Tue, 30 Sep 2025 13:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="qsLwn0+q";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="eNB52QYz"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 368201E260D
	for <linux-nfs@vger.kernel.org>; Tue, 30 Sep 2025 13:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759240125; cv=fail; b=AJqv7wnVs5/709eIwjFxUahHXke+HHSqvGv/h7+P13mQRDlf/6wRy9ythvAz2diQ2K3xK0XwJVgayLPPG2ThCr77DXhZBsKJTV3x7CQiTAg9Y4K+rcm+/ydvPyZUiDmjpgeJ2d7Uer4orgV9jiJ6tLLUwI38uEJPNxMGajGx2vY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759240125; c=relaxed/simple;
	bh=JXHoDYS4fYnwWDOCbzRDinfTamfq4yimfCrj/nbFTZs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=oZC5tbftlngqHSEXvcbB11eTRIuFm0+W3w93Wo4fxVQrjZCAd1mLwC7C+f5yHvBD4NKkT63FLzaCGp0M+5Z8XapFLWUiIC5M7YK0U2kB7fjEcZ0OjvYxtXevE+E+QxC6KSN1zHe7wWBX2dcW96CFleNE+HQPChiDBHkCTte2mgE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=qsLwn0+q; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=eNB52QYz; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58UDiecd005913
	for <linux-nfs@vger.kernel.org>; Tue, 30 Sep 2025 13:48:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=HJL4bQwkgZy8O+Wry4L0rz9v5N0eWo2eHQruu34tCtY=; b=
	qsLwn0+qSjRJwjOQzQYAAk1thdGZ2TqqG7DMipT0TVK9XZkhPnl97NrVbqJL//b3
	H9vhf3uWYffvOiVOTTeIRuf5W3EUwuvSB6YJ4uLQz8btVzCf36erWQhVuopDToxT
	wnMJFIJAVyQhI3FUg0s8yuXqlUOs6fFYpsW2vzL+TbrIuLzlR6icVjbEnqtwQ8ry
	exuhZmCJ1xeyd9EQF1s61MtH2oqGZqLLeYL9nyWCZeLgwWwaTXrb27AUd6lxmlAv
	HiZgArYVCFaiD4uk87019a0rLqPZaVhUEFAiE1rdbY3H+5ojsiifmBtmapIZqhz+
	BEnxoenpOmjAJ/iMpYMkGQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49ggbtr0bk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-nfs@vger.kernel.org>; Tue, 30 Sep 2025 13:48:43 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58UDCRYS036269
	for <linux-nfs@vger.kernel.org>; Tue, 30 Sep 2025 13:48:42 GMT
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11011022.outbound.protection.outlook.com [52.101.52.22])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 49e6c83a46-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-nfs@vger.kernel.org>; Tue, 30 Sep 2025 13:48:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZnrtyJeLcX3iTTWB8zAgs8FbF9zVY3eeYsxU0H58hpXWMR+2rfJg16ZVcflZPPBCqwc/Wl8z5Z3dMpOlapTRMc/38bbL5500gg36EncZVBae6kRo79YIORPzLq+aCGq1rLBouJFSAmpaTqEqgPCwXh4CjolRvSOuqMdXyO6HarRyJJe9ZzHWhsjFCfnH4M0NAfu0VrAybSAG1Rze0xKScg+KKaJWcokCRbLDRPdZnIdhC/eHz4wG+r+5QLQOWKEhem2AEU/xR/zR5U4aFN6rVsN8b+Yc51ISOQeOaadpIaMtWEEic0bUJ1zRJPj+t7qRQLh9w/eASezy2K/mI3aasQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HJL4bQwkgZy8O+Wry4L0rz9v5N0eWo2eHQruu34tCtY=;
 b=yJIn4Oir2QCBA8zjUw79iswQd8deLmOqA5sstBNQGt3yfwHMLpRqUMiQkOb7P3WxRToGk2gxtE+4EvOkl2Gqh0n9g8Nncgie/cyJXJpTKO+2vrE1s+SKpJ8JL52FPm9jBOiRlRhKpe7Y8Ism7t80giM8XD31Kq999Tx6GDDmDCmpUAIRHS0pXl7ZBNyE6A/MuQyweYnq7CutVb/7rfE904YSDhTwciRMz8aN5RF4Z2P+lIxJfofclnaV1IRVMaMWb7IKDRPf2ZNlKatZm8VDTxPKTx5Hs9DocPZDVszdSga+3xRR4bC+gyumjqFPBVeGLmlf/g75fSpRfLEt2tOJjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HJL4bQwkgZy8O+Wry4L0rz9v5N0eWo2eHQruu34tCtY=;
 b=eNB52QYzlSCKHI2Rw/RherjsghmTPgaU62iEjYbXPDTp853jqSeK1AgQC32QwcXn8MBPYyIZPnDM4YtS9jhWA+6t3bhAmSuhpN0dh0ExU416L5cjGsS3ShvxZZRUT6MHkVpUo1UPcYX34mLEe1DjvkpduJSZKQton6mN3YntG0c=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DM4PR10MB6157.namprd10.prod.outlook.com (2603:10b6:8:b6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Tue, 30 Sep
 2025 13:48:38 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.9160.014; Tue, 30 Sep 2025
 13:48:38 +0000
Message-ID: <b85d61ab-4df9-4b99-b998-399d0dfd9b69@oracle.com>
Date: Tue, 30 Sep 2025 09:48:37 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH pynfs 0/7] nfs4.1: add some basic directory delegation
 tests
To: Jeff Layton <jlayton@kernel.org>, Calum Mackay <calum.mackay@oracle.com>
Cc: linux-nfs@vger.kernel.org
References: <20250930-dir-deleg-v1-0-7057260cd0c6@kernel.org>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20250930-dir-deleg-v1-0-7057260cd0c6@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0246.namprd03.prod.outlook.com
 (2603:10b6:610:e5::11) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|DM4PR10MB6157:EE_
X-MS-Office365-Filtering-Correlation-Id: a5f5c170-5895-4fba-03aa-08de00280f34
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?RjBubURJdmhYTGlYTkdsWjd4N3p2L0NpMUg1SVN0WU9nQk84QWNsWWtpZzRM?=
 =?utf-8?B?MFFrRzlwaXQ2TUtpU1UycFp5K1pDYnlUaElodnJoYlV5R2VGcTVUM2RRaCs1?=
 =?utf-8?B?RkR0KzFhTkNRZ0pkak90UTNubENsZ2dJVEpBYkRaV3owUmxjZlVzTzhabkt6?=
 =?utf-8?B?MW1oZ2N0NjErOG0rbndkL3pmdTdWTFZvSTdxVDBsTjFPWnZuZjYvZTE0S0No?=
 =?utf-8?B?aXFGZzY3UlExSzcraDAxdDFjdHd5R3JXamhYS2orbDIzTStRT1Z2a1NYenM1?=
 =?utf-8?B?MVFGOVNpWGZWeGpVVU1CQUhVM3plZEl0NktQcURMSEt6ZTBPWTN0NGtsWVBZ?=
 =?utf-8?B?dk5TRERaOGdrSGpldlhBS2ptem1OeTlaNDBhUGVXU1I0M1BTT0hhUFFOMXRk?=
 =?utf-8?B?WEp4SzRCNHdRYkhnTG4renRGVHRKVVhaUjJRTTM4VGxHTVdJL0huS0NsSE4r?=
 =?utf-8?B?bjBTL3Q1SUZZTTJDL1ZUM0dmYzZHeXpZQlR3OGFBN09KNEVzczVld0xIVTAz?=
 =?utf-8?B?RitZRkNMenQya2dWTkxkQ2M2VHI4dmFTQXc0eGNsWTNiQXVSN0t2em5ja08v?=
 =?utf-8?B?T2JoL29uTndQbWQ3ZWJ2SmhKRkp0QWpUcVJmN3RvR2pYKytLdFBnUXlqdEt6?=
 =?utf-8?B?WjBoS0wramllQWUzL2RqOWtIRGtOS3BsZDlBUlROdzhsNDJ6K3NCckV4RDUv?=
 =?utf-8?B?V0VqdXI5M09iRHRZMlBUeElGQ3VhTGU3Qzk4REtMVndpRFpzV0lHUGJOZENz?=
 =?utf-8?B?SlVhUnZESW1JMDZGdUdPQks0YlFSaHNNZm9BdVJQN2xjV1NGbS9LYjJ0V0JS?=
 =?utf-8?B?NmdvSytuOXVjOUVReVpyUlZpM01PUHNmM2w0Ry9xdXA3QUNYdGVpcncxSlFT?=
 =?utf-8?B?cWFHb1BXRG5nUnVBWng4MTNnd0QyL3RDMXAzVnV2SHR0NWxHSWJVcUdoaC9W?=
 =?utf-8?B?NlU1Tjd1clpXOTk1aXRmMTd2QWRHUDBzaVVVejhacGE4RmNIeWtZVHdsalZ3?=
 =?utf-8?B?MHJFSVhYcDM1TnZ6VCt5T3BIckpxbkN0SVdBODdkaDZpQWo2UXdGakFhWktG?=
 =?utf-8?B?cnB3OHJHOGs3S2F1RWthdnNzWDN5eGlzcW51dGJ0c21EMXFzRnlmM1Z4THBP?=
 =?utf-8?B?ZGUxNDhFVGpveDF4QnJzZnFKNXdza0NhU3orWENzUWdJV3VBanhOV2lPS2JR?=
 =?utf-8?B?czRMRkRpQWJlTStXcXR2aVExNFBkWTIzMFVlSGRpTk5CWG8xZnN0WkpITmdy?=
 =?utf-8?B?SllXaURmcnBkNUxQOGJFcGI0L1g3U1kvejArdHVOOGMwOFk2MUdWQzg5aFdS?=
 =?utf-8?B?am1sN25USlYxMlJlNGtkZWtJUFQwcENiWG1nczV1OUFBVFo5VEg3Vk9lN1Ur?=
 =?utf-8?B?WFZaRXpQOG9VNlZlR2Q0dTJxby9EZkx6c1IvZDZneVI3SWhPeWhHK2Ewd3hW?=
 =?utf-8?B?UUVURUswUWtsOUZRZUliYnA4Y1F1ckFqdU5UOHJ1OHlXSG0rTG1Pb2ViaU44?=
 =?utf-8?B?a1YrRWp0SFRxMXBmL3dzdUN3NGpoalVGbzhKWjhkcG9TVm5yQzBvREh2dTVL?=
 =?utf-8?B?c2pvTEJCRVhQOHFJcWQ2SHFZalpuZDh2bkU5ejFWMGYwcUhDT05pRUs0WDEw?=
 =?utf-8?B?OFFIbnNJaEN5a2swTTNTMm1TRXNnTDJOcUgrNXhaTDQwVTdHaE84MDNkQk9z?=
 =?utf-8?B?ZThaMzZ1WGQvUTRCWVBzaURhL1haMUd5OHM0bWVzbTgzOU9pbDZOejQ2akhX?=
 =?utf-8?B?Y2NxMWdBNkhXZzBQL3RLWGlGMVArUnlYYW1LejBDVGRFbWlsWmNLSHJ6b1ZJ?=
 =?utf-8?B?cUFCc3lRZWxJY1FXWjcxZ3oxUFpxT0gxVEl5TGlVQnlLcllKL1hzQUFkMUVj?=
 =?utf-8?B?aFdVeFJvZFVKN1hmTHNvMHBXRTZNcTBHREZWd2pLaVIzWGZaQmVqc0hBZlBa?=
 =?utf-8?Q?Gw5PpSVxnh5KxtdHU93sT2fIOshJZMVr?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?Q2lZVXJaUnU2WHdwZ2N5VVdNaGg0bTg2ZzVXajVzSXVJTWZwSm9yTi96QXha?=
 =?utf-8?B?ZUk4WlhWV1FlVEI3aWNVTy9VaU9SNGlpZjBUc2dFOTNnNVZoL0d1U3QxTXZ6?=
 =?utf-8?B?SXZ3dGVlcUVDNHVXOGFpb3p1OEVHc0RCNlJTMkw3VkxSaUU3UkxKcG5XUHVL?=
 =?utf-8?B?ZXcvL3phVXc4ODVWdFhaM3BGZGsxN0NvdFN1YzcvWW9ySi9Yb1d0UzVCdnZ4?=
 =?utf-8?B?QzZwd0NreWZiOTd4SC9VRmErSUNwcXJ6bFJFV0x3Z2J3dGU5MWN4cUViZkZu?=
 =?utf-8?B?UTFDMG5YOTRjU2trTS9idkJzWiszTC9qV1Z4ekN4MUxoSVFaWUVBNHF4NXV1?=
 =?utf-8?B?VTdLUnpyVWZqdkZCazFhemlKSHhKS0lhTFFzSXQ1WnFHMnN3YkNTQjJTQTRV?=
 =?utf-8?B?UCtCa2tqT0JyZy9zczZuVnoxQjZDOUdxaitZWm1kV0RtWlVRM1NBbEZVQ1ZP?=
 =?utf-8?B?anh1b283SUpWQnRBQUsyeFRJNEFuK0YrRHZ0bzR4YzdtaFRNYTBIdmZ5bU9W?=
 =?utf-8?B?a3lyYWtTSWEwUDBNc2xXeEo2S0NsY0MxMU0yRGh4NGs0T3RXQWd2cnY2NkRW?=
 =?utf-8?B?VklFSnNWeDhIYjhJdGtEdFdvUmx4aFdmWXE0bmlFb2xIeXdoU2pneVJNcXNJ?=
 =?utf-8?B?TFUzM21kNWpRRjdxdlNvN28vam5VMXNhV2h4a3I4UWRRaTRpUkQ4MGxMSVpp?=
 =?utf-8?B?RmhSSmJKMnVHNElXMVEvQ0kwZkdTeTBTZW1QRnFEL3kzR0FXSVRoeWpxamty?=
 =?utf-8?B?bVhFaEp2eGRNMkdpWmlLaWJJRTJrU1JCOUtQU3V5QWkxaksrNFpmSlFOOHRD?=
 =?utf-8?B?MVRiOTB5YWxGUnFjeW12R0Flbm9HSG1rdmIvS043eEdGdGgreWtnWStXa25L?=
 =?utf-8?B?YWJEc1M0K1hoME5FVDZWUG9LeERlTnUwZk9sMEt1R1pxY0ZnS2FkRDhQazZW?=
 =?utf-8?B?ZUlDRGNKZEZvbmVqc2JsMjdrczJwRFlUNmhVbWhuRVprNVNodFNZOTFnaFBq?=
 =?utf-8?B?R05PZWtpdDdZSDVSVUR4ei81c0h3SENuQ3FxN2FqcEJ4UzlsSXFBMUhMNU9K?=
 =?utf-8?B?ZWhHeE54bkNiZWNoRmJJWjh0SjBKN1hBOE93VkVadGZTeFlGR1diUEdpZ3hR?=
 =?utf-8?B?RlRjMVU5NSsxTE5iWmxORzFrU1Y2SURYeVBNZ1kxTnEvamw4dFJsdE4wV1Z1?=
 =?utf-8?B?dnh6aktTWTVsVlZTdUsyV2tMYlFmc1BiSUp4STJCK09pcngzQVptYjFtZTJG?=
 =?utf-8?B?dHNqUTZFUmJXeFVBTEpFWGV3RnZ6UzBpUDRyeWNFL0JEMTM4U1VjREE2bXdP?=
 =?utf-8?B?S1F1Znk1cXYzc2diRlJNT054Y2hDZTljRGptck1zV3R3RkZWK2dzYk9CamM1?=
 =?utf-8?B?OC8xUnp6Vjd6UW1vVU9Ea1ZWS2ZhUWtacUpPOU1EMGpHVlR0RlJyQXh0Tm5l?=
 =?utf-8?B?RXJxT1Jwby85M200bmlZMGtmM2JHelpDSGhDSVlRU0ZvNjVhYW0yeWZBMWg2?=
 =?utf-8?B?TVcvbXlueU9TcHpLakYxL2t0YWE4NGxoUkJGQWliZmg1VHUvYVE4bEY2V2ZD?=
 =?utf-8?B?d2NDRTFrYnphN3ZDejlrSnhSdlZGZHBVakhwaUZMWVArMnZjbHU0R0JpclZo?=
 =?utf-8?B?a0hWVXhHZythVG9INlhVVElWL0duQ0VqVEplSEl3aU9sQ0M3UmNDVnJSVFpJ?=
 =?utf-8?B?VzE2YW11N2N5cVhQMGl1QjJ3QUJ5ZkZ0QmVYNnNZeDM5UUh1Wlpma0FoQ0g0?=
 =?utf-8?B?V002YnczdldoNlh2eW0zNk1ScS9zcVQ4VUdRTGtBV3F5Tkt0QXBMOTMzUE51?=
 =?utf-8?B?TFU4NmljQ2RHK0xYOVFyTUprNjJvcG8yRXBDcjlSNkhkNkRqZ1dkN0VCOWUv?=
 =?utf-8?B?Y0VtSFNUUU5uQWRUWjBiYUhvSkJQUkJCWXBmVnlEOGhqM1RNSUJuVFUvU1JN?=
 =?utf-8?B?UzVnMVJpVUE1SjJQRFNpb0Q3UFlpZEZDN2pKUHFOTHhnbmhNS21EZzYyRFJl?=
 =?utf-8?B?SmVBTXNGcVErR3kzT3ZrN0V5bXV3R1JtbWUvQTMvOGdDZVpnd1FPRXMvK2Iy?=
 =?utf-8?B?M0U5cHgvdnV0YjVwVEZ3OGQwbi92RGxWN2JaZmlGREVoUjJxNXFpMDQvRGZi?=
 =?utf-8?B?dEZ6aFFDRTc4a01QYXF5QVBaWFFUbU1BeStRN0RtM3ZUdDRpYmUxTzZvQTBZ?=
 =?utf-8?B?R2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	xsfmnftkaOHBD/nzwPk48sZ2GzvTwqdJilv/A4NjDxnZOPZHiWhqq67mkv4wYw8+9/4vF7IQkC0jmu+pDrkuCyT9UAoLpfagNzXO4+cZmfLz4wspEpsWuvfzaML+ayDeUJwS2SWFX8Nu98xWm2Av6BYVLvjQ0COWSOGaYv+J9pNvlyJeqIF1SQUc5Xc6JOvUfb5I+yZGjvcfJ+uStQtO+1RrJPe+IlB1z1ukijtPpCIrvBHlWfvzILoQDv9Bx3kzqmFF3fdHQBd1H7FG9ki30PVDmrxui8fBAh9D9oU2t7JMlLG81u+e2XMVRYluLcwCHKPzZSCa2QhMBEif9OBXdqVrrh7+ljtnWswyeV5AvREDhSNDwAa4X02977694MUQTbjrf71UCUZjHFkGnbH04GW/28Mfnge/D2SbDvXRDeB8HQ7sBHt9+SWtGpVOA4ekdZfaFBynYRX7c128K9lWj9UsBXxKOcIt3ymNJhRWkyZz5gDyBFDR8V/uPXLDpBqHzwa/lja/TuUik+fwMl74fTl2isOIx6QlByoGR/MaGdCbKoQFATU7ltrIJELjeIV1nWvdp9bkuShXujqvjbhj7LHxoP0D/MByyOeOwwOQz3s=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5f5c170-5895-4fba-03aa-08de00280f34
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2025 13:48:38.8309
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rfr/+LArZhXOnicOXP+Mo5WKSqf654MaBLVKInuXUF6VQs/xrr9Z1bLRRGtYpC+sR+fl4A5A1wzFxuHN4Joq1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6157
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-30_03,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 mlxlogscore=999 suspectscore=0 phishscore=0 mlxscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2509150000 definitions=main-2509300123
X-Proofpoint-ORIG-GUID: W-bCYwwW8_lDWoeGniVXSganwtFkICQ7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTMwMDEyMiBTYWx0ZWRfX9MXfaI4hwjOG
 0orMTW81eblRYc+uCVBpRjJ5qLqRw5SxefhWLjeb4AXSxF6YqgfRobM/eCrJF0OCIS5EN+esSr4
 NhtkWi9sR7K1sDrdSUrsTj82AuaJp+Dd6ZzhR3BCq5lKMPdUmMqbyW8GuWGmBjO1UmIEA+ql6jU
 ztHQIzF063l8WW9ysUioDXyX99pngLpw/GOXNU2cYMOo1G+e61RW9q9Yd7JHLPC/mCFB/d7EPJG
 WW+Dcv6ZFtDEiAiEXUxfcd3mfwhr13PbWRuvcWqcvd0933PtoixFT50OrAFwfguRhqsMft7YKeN
 QfS5A/VPmRIrrRUmSn5jvL5+OdYLecE31HAnPGfoHkPNoboG5ovTjvNkJ8pN1RFXS2AGjwYY9Zm
 c9/i1QpyZnCIUS9RJLbKzlFHO7CvyA==
X-Proofpoint-GUID: W-bCYwwW8_lDWoeGniVXSganwtFkICQ7
X-Authority-Analysis: v=2.4 cv=NPHYOk6g c=1 sm=1 tr=0 ts=68dbdfbb cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=i69aFSdIO2X5cXaGO8cA:9 a=QEXdDO2ut3YA:10

On 9/30/25 7:37 AM, Jeff Layton wrote:
> Add basic support for testing both GET_DIR_DELEGATION operations and
> CB_NOTIFY.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
> Jeff Layton (7):
>       nfs4.1: add proposed NOTIFY4_GFLAG_EXTEND flag
>       pynfs: add a getfh() to the end of create_obj() compound
>       server41tests: add a basic GET_DIR_DELEGATION test
>       server41tests: add a test for duplicate GET_DIR_DELEGATION requests
>       server41tests: add a test for removal from dir with dir delegation
>       server41tests: add a test for diretory add notifications
>       server41tests: add test for rename event notifications
> 
>  nfs4.1/nfs4client.py                 |   6 +
>  nfs4.1/server41tests/__init__.py     |   1 +
>  nfs4.1/server41tests/environment.py  |   2 +-
>  nfs4.1/server41tests/st_dir_deleg.py | 221 +++++++++++++++++++++++++++++++++++
>  nfs4.1/xdrdef/nfs4.x                 |   3 +-
>  5 files changed, 231 insertions(+), 2 deletions(-)
> ---
> base-commit: 3c14d9e3ad12272ab2f6092c85bb28ab03951484
> change-id: 20250930-dir-deleg-4ae7364fb398
> 
> Best regards,

Reviewed-by: Chuck Lever <chuck.lever@oracle.com>

But one question: should these new tests not be in the "all" group?
Seems like most NFS server implementations won't support directory
delegations.


-- 
Chuck Lever

