Return-Path: <linux-nfs+bounces-19840-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cDmsEwUhq2mPaAEAu9opvQ
	(envelope-from <linux-nfs+bounces-19840-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 06 Mar 2026 19:46:29 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F6A0226D43
	for <lists+linux-nfs@lfdr.de>; Fri, 06 Mar 2026 19:46:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A55B33038F67
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Mar 2026 18:46:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54FE433AD94;
	Fri,  6 Mar 2026 18:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UKEOZdBa";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="yLm8BaSm"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE719277007
	for <linux-nfs@vger.kernel.org>; Fri,  6 Mar 2026 18:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772822780; cv=fail; b=L7AEgSr6xEGmQ9yfTSGTPwm/N+6DZghL3lujXcGeVc/lK8PENTReAa5Rlc51Zzv5tFvGQY+Ojqs7LuwZyrSAqiaVwGs/TFGvUsXubyZ34u8xjxQiPmQDE6YxXM7OcgrvUIgZIGXxpV1vTZdsdezKiLAi81LwDG58cIV7z16uQ4Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772822780; c=relaxed/simple;
	bh=tFU5BFlR6LYePiU3cJhJ7S/+6cSl4HKojaJQ399Qh/o=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=js51ZJ1fTRIFYvaDy9PA48T+bqmLc6mkhWuRzvtvStqYD7/7yJlRn8HbdX2TTWO7RwL4GGDHD/nRbz+e8N93B0D3C435AFvRwhAJiMmg1eUeiepkLdyULOBohPQDbQ4gQaFvFy093YZpRDPiK3tYGZt/4Iu0C5hdDeqtAUlXfXQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=UKEOZdBa; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=yLm8BaSm; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 626IXUxZ3159030;
	Fri, 6 Mar 2026 18:46:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=H6T6s29tCk3pibRX9EiMmvtbZ5QFrpv+AxUhkZP3DdA=; b=
	UKEOZdBaEm8If6KSla7y9uwBWPuxFhajpEC0SsrRpGBHq/p8mVlVfYTu0t/wglQr
	cxX6szbaNNOzw6tv+rDrq2YnUVNYOq9XJGkwM0pERt6jI5dnFPM5quREJDIRVOQv
	U1xNnmtxfipSgvg996BX/1LBLn8MwiiBUPeR/XcF3WN1QC84L7cdy/e6cmo785+v
	/3bx3nWCJrvKbjZTiwdX4BHZddCFFPh8nKGJusNW1DzCFU08fSRCsav4Utl3+40O
	q3FZeyJyEMuYBT3ELpqS6Uw/kTv2darm5Ys4UAgcEaAvd3DCkeILGS1T0Su+/rJa
	ZvmHVj1Odfn2dqvqZI1nzg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cr4ae00cy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 06 Mar 2026 18:46:06 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 626HBafQ027327;
	Fri, 6 Mar 2026 18:46:06 GMT
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010017.outbound.protection.outlook.com [52.101.193.17])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4ckpteu1bm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 06 Mar 2026 18:46:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FKZrPlWxL7iyPSmdD44MZO1y7D88yB4q/MHffjESr1To5LRzH/yAKuVjw7nksJ2IaqUjjROR7NRMKhyCcHgypT4NtS/mYygfKFfBIgRCMdP2bHOzQRk6FbQZEQVNLspm6lm5QLi8xY1b2nw6TmbNS5r0LKwD/J7K8CvibtLOlnH+x6Ek+V+hMHxUpqAs4v2Hr/Bfe2FktwZg9uO8/U/n5AwjXDzwQz8OwcPjqkhaRsZMMbsQpu/3RfmD6XFQKRQaJiYFZnNc1qSvJ9p1EDOkwGWl9mZTMyt9i0VFIXaJa16BKETbMu4vkRBywzzRiWZae37GyJIM7RpWko1EQY+BcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H6T6s29tCk3pibRX9EiMmvtbZ5QFrpv+AxUhkZP3DdA=;
 b=AgO0KsJ3kJ4+IvdFK2xLZXOi9gUU+aUfHrhWIC5Jra3zv1gNGDKaC151ue+6Z/J7Zk6CbmtfdCCua8IgP0mr/8lZoSMuroh2f8HGCbqTbdhU3HevV0yCAsoghG8qBsWzz/UvptmlOfk7tuhW5nljkMocvn8jvtba3+tKA/00LrDWQhV9rg7c1Yycwa/RwHKYri8B4TWVV9Nz289yrmFdQmUOyaziMghNAOahkbyH/HgExRFEX36FtcPz6VcXyvI+MZ8ErmiWD8ZiYxQPMd+t3OK/4o1SdwI3xTU2XvcU7tznVtoYUhzNKI37RPFwEa8u7OFxukGBxsjfjGX6irERrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H6T6s29tCk3pibRX9EiMmvtbZ5QFrpv+AxUhkZP3DdA=;
 b=yLm8BaSmecNkH77YX1wyoCJDIr32gALYAvro2sSUtXa1cnUeqDfpRVMh+Z091SQWXpXDZlGWvWE23niIT3FsfxoFNYNSHXdMNlBP5ZrYAZmBiLlrt816ayDQ9EODiJXaqNhl7KsMZk8G179hb1udKAs9QgQHtEJTmZYHoeRDs7k=
Received: from MW6PR10MB7639.namprd10.prod.outlook.com (2603:10b6:303:244::14)
 by PH5PR10MB997757.namprd10.prod.outlook.com (2603:10b6:510:39e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Fri, 6 Mar
 2026 18:46:02 +0000
Received: from MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::8386:1d11:46b2:b163]) by MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::8386:1d11:46b2:b163%6]) with mapi id 15.20.9678.017; Fri, 6 Mar 2026
 18:46:02 +0000
Message-ID: <fc0a566a-9cba-4fd0-99a0-d7fb7043a77b@oracle.com>
Date: Fri, 6 Mar 2026 10:46:00 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/1] pNFS: Serialize SCSI PR registration to avoid
 reservation conflicts
From: Dai Ngo <dai.ngo@oracle.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-nfs@vger.kernel.org, Trond Myklebust <trondmy@kernel.org>,
        anna@kernel.org
References: <20260306162927.3276695-1-dai.ngo@oracle.com>
Content-Language: en-US
In-Reply-To: <20260306162927.3276695-1-dai.ngo@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR03CA0010.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::20) To MW6PR10MB7639.namprd10.prod.outlook.com
 (2603:10b6:303:244::14)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR10MB7639:EE_|PH5PR10MB997757:EE_
X-MS-Office365-Filtering-Correlation-Id: 00dbc84c-4f18-4ea8-b58a-08de7bb09d68
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	8wsUqbePGKQrQTvkJR81L+RHfB1cFMgYmYIJAmjpyzg2X9o0yipv8HErp2X0EvnBrUE6vuvZVa9CWfoKaWWose6RqHPQnhUSCLlnbJlGLwTe/suYPHLONgvQ6m1zKgFoKLi1EbWO977t+vh4K6a4lTsO/XGPS2nxkqnPzql8Cby/azVKYk1mMnQBdnJmYAKGRMK/uj4IHwzjHQ8mDytAghLGCRpLCQLVaUqwxWvgMmebnjGrgPAVI+UzvAemq9f408Evzb808D8lnwAIBH2+R1nrQ11UM/LT0IoiOpPtaqsf22HPvWC+LHQBU7T89jN9nqWoY+zxfQvleICihGnl7/wyASsZ4sANbaWVu5oDhtL7DCAV+bRsx/aw8wQ7h1ybPlYiimbDURdHsL+btqttD9DSFTHykBMyM2dBxzOiSK4D3KPbp2QWCD4JFqmyB7JBp7wcqLemsE0+oiDzo4bMnHDI8VE2Sv4r1Y8RU2U9Xw6PpvlbS9j8RjyOehHQOhuwvjh/qTDRmKbakJXSuARJPfpr7B8ndCnZUo+fDE7TLAh1qVPLnlL5rMXwgJ1otUMDLe+B1XR1Tu8kVGSZDwDuXwmvKJXegGettYktHHdBbqOrjzW3bKdzuOIxYgUEyspoDT8FQIOTGQtTA3+8eJHAC9F6uIoDeaqLVp90v83IIUZ0iNhfDD2KRU4upVPLMSQX4gH4Rk5URVV66eHwFNeIIFplBlDumP8sc3Mv+DpFGBY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR10MB7639.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bTFZb2txbjR2bkNEU0FORWg3N3ptc3RWLzVwVjc5NHV0eTZpTFdadVFkc3Uz?=
 =?utf-8?B?a01tN0k2Q0VWSFV3d0RCZVI0TWY4VXNIUjcvSlpoSUxLUEthbjZYQjJzLzN2?=
 =?utf-8?B?dWtVSHRXY25JNEI4VXp5Wi80VFdjWU8weUZwNWFNM2MrYVZvc2Yvd0R1UWF2?=
 =?utf-8?B?RERKdm1rR2NPVjRQZTl0SGlXcE1ibmZSR1NYZndSWmRxdzQyZWloejdYS3VM?=
 =?utf-8?B?Q2pBRTltaGpBZmt4ZzRQMG9nSm9QUmk0bndtQjJBMmlpdXNmUnROcFpTVWth?=
 =?utf-8?B?dktySHh0WHZZYTVxNlVtQm95QVYySXBzREFsQlNlektwZWVJUHBNdkx4bkZ3?=
 =?utf-8?B?anFiSk8yKzljejJPUVBHalhpZmhnVVl3clg1WnducWF3cTk0RCtrTzYrUjQz?=
 =?utf-8?B?VzRDRjBDUkJwUTZkREJWRi9pRnFRWmpuVjBMSkh3Rm1Gcm5lczBQOHNKYzdU?=
 =?utf-8?B?ZjRKMGNMK1A4R3FrTWpadnU3MlpDZURLaVYyOEZrekFob0lPdjF2QndpM0pt?=
 =?utf-8?B?NG1FRld6cEMreENWUTVpeXJ2U3dJWThjeTl0K01Gei9TRU1ia1I2VVdwUG44?=
 =?utf-8?B?N3JyZ2ZqNEpUL3BCOVp3V3RMRzJvQWZjMDB2MFdzYng2UHdZNGFWQ295TnRD?=
 =?utf-8?B?ZnhTTW4xQWY5R1hzRk9DcWFFaXRLb1NyZEJrMnRqR3dKMy9aVmdld0Fvb21L?=
 =?utf-8?B?SmlpZWhVZXZvOEVnaElTVXQ5OTBORjBjQkNvcnBvVnVwUjF5ZVN6OCtOMjB2?=
 =?utf-8?B?Tlc4MUlqNUtsQ1BDVnRndmlYOEhRblZqSnBKTm96UnB0K2srR0xvOUxNUXJN?=
 =?utf-8?B?bVVXMXVqVXdCWE9zazFmRGNOUGl2VmMvYnl0VFRPZnZrOXhnQnQvVHViaG5i?=
 =?utf-8?B?L3k1c1Y2cURlSFlOc1FEL3IyMUc5VUp1d3hXQUdzc1ZRb0VZaGZ6cENtbDQ5?=
 =?utf-8?B?c1d6Q21vMmVnNWFmZUFHVjM4YjlwRjZZZDFvS3pKekdiLy8xOGlKcVU5aHNG?=
 =?utf-8?B?RGtCeWEwSnY0TG9RRzhWVjN3RERkT3A5L0RaOURzWGM4Z2oyYzRrWEx4K3o2?=
 =?utf-8?B?VGVHSTRFYnY4N3Fxa0RPOURIYUhmd3cxK3RIcGhNT1dtbmw4U2M5OEpXTGFR?=
 =?utf-8?B?T1dIMWZ1RjFSMmx1RzVwQU5VUjlFVFNsZ3NuMHJ1QThCMGhXQnNMQzNXUFcy?=
 =?utf-8?B?NTNiTmIxWUt2a1JzSDdOVHFVMEt3VGcyek0zWTZSQ2MzOHB2cUdFNUozNjhU?=
 =?utf-8?B?Y2d6emxHRGhuWWYyTisyaDUweTV2SXlsWE51OVIzdnpMRld4cE1NR214M3I5?=
 =?utf-8?B?U2lGWjNyK3pDM2h0SW9KVmI5NmRxaEFkSytiYk1NK2tIR1hXSTNQeFJ0Nisy?=
 =?utf-8?B?aXV1d1RaaXRCVVhaeWZ1ektjeENqNjZ2Zk5IUUZpQlRubWhNUWlGbGVXWnFa?=
 =?utf-8?B?ei92Y3M2dU9HWUlDekw5WTR6QlBCWkNGMjZ0NmRNQUNxMGNiMHVkQkVuQ2JO?=
 =?utf-8?B?N1QvZCtvc3RGVExwUTJPaXpIamtKdE9zSDg3dWllVWtGMW9hemluTEV5UXlW?=
 =?utf-8?B?dUxOWnRmbkVEbWhmUURDYmo4T3F2QUc0VndTNThLcnRWb2FQNWNLZnUyUFFv?=
 =?utf-8?B?aWRkLzByVzgxYTk2UGx6RzBvemxkSndSQ00zeXhiRmo3K2k1Z3dqekFmcktw?=
 =?utf-8?B?aG5WaWt1YmxoQlpDZTRxUXBWQ1JBeGxZUWMvbUNrczZWakJZMUxmUzdUajB2?=
 =?utf-8?B?Y1hrU3B2NDhJcmFncWJCU21iZis1aDgrcmF5UFFHQ3JBaFFLVUhaY0NmY0Jq?=
 =?utf-8?B?dFFKd2RRaU5mRVNBd1l0NStZS0szclRNeXdVdjN4TTc2dHhMOFdDaTc4TzBE?=
 =?utf-8?B?UnBqbXFTK3RQVVdhc0t4VEdmVkF2MUlnQjJLNC9OcDRpV010NnhjUWQvZ0U2?=
 =?utf-8?B?b0l3Z2RYeEpnckNheWV2RHg5Y29TRisyUGxqd0JYQ0dGSDhhaEFVNURxME92?=
 =?utf-8?B?NFJGak9oN2ZDay8zM2pubW93Y1c5all0Z3ova0VHWjF5RkVud3JqdGltRnFY?=
 =?utf-8?B?Z1NBMGFyRXlRV2c3NllrcHo2SktGcHFhZmhZWE5EeVc3NHZXMmtJSEFuQlZU?=
 =?utf-8?B?Q0k5N0I1V29hR3V3UExDR0htMWNKL0NxVFE1TUFxb0Y2OXJxd2p0K1RCVmxa?=
 =?utf-8?B?ZCtNeERTNFJVWndzT1RoM001ank3YWhVRzFUMkJYeUR1Ylh5NWY1RjEyR3RM?=
 =?utf-8?B?Sm5FUE9nRVUwRFh3bTkxcEtnUkk5OUFjZTBEc3lybnViUFZkSmNhMWd0MU1K?=
 =?utf-8?B?UnIzRE13VFpUUzdoU0ZQK0hGOWFEa04yWTc1TmRuUE53NS9qaVNQQT09?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	vDvAcj+qZ9oW2Mx3ffQYonlXGIpeIO32ex5hKsLDfRmfVNBnmbR8OxALIko5YUgeVirf9PvmyMeAUmZyaLCPwWqUDPNPVASSLrh2u67kQsmXAMne3JLjSW1KCfczBuPS40ZOf87wCevwIFDGfj+oAvC0nk9l53S8exme2DwZiD4w3L3M8r7J+OJ2qJdEYkSji1/+68NwdY+u3jkub04z6JrYXhH0uJW6MwbxZydt30zzRJvzzjAink6kUvMsq99zDo+tM0dCxGpWtRU/EcTvwzoLb+tcqZ4ZKASLoOhOri+62+gonMiNpsuT9C9k1NuVPuAqrRWOU/mc/RM7vS859hmrkYf6vYYr65wVB4mYitTVRbja+mIQQJAktwh+AfZDkn5syrWWUR7IDSjUYUyB1y5cVZ90cT/8kU08fXcf6uc9evjR9tN4vZlcmoFXG+QMwo05adW6qtIHMrUsG6wKNwQO4Igwtpls/dCZbxpS0b5tTmkYsoYC4bjGQPlgkZdfYDbARixPNTIWlvK/5gEjzZ/Lt87yAMm42AORU+zFSe4MRV7mdpksZF52UT8K2OGjSsxct5lBezudnaBovrn5qkYbJwb3H5UzDkDTiCagiVA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00dbc84c-4f18-4ea8-b58a-08de7bb09d68
X-MS-Exchange-CrossTenant-AuthSource: MW6PR10MB7639.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2026 18:46:02.0869
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hnkITZIpaRCSWw40KUrxoid4Or8rW8fRN+8CLBEmxjEol3ldrmZAThUJLOM+yHLwjdw6Mz2dRTcV1sydT0mP8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH5PR10MB997757
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-06_05,2026-03-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 mlxscore=0
 malwarescore=0 spamscore=0 suspectscore=0 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2602130000
 definitions=main-2603060177
X-Proofpoint-GUID: 3eyQjJ-GUpZWTlAHeKWmOGm5qcrzfbVm
X-Proofpoint-ORIG-GUID: 3eyQjJ-GUpZWTlAHeKWmOGm5qcrzfbVm
X-Authority-Analysis: v=2.4 cv=fJw0HJae c=1 sm=1 tr=0 ts=69ab20ee cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=7Gl3-_t3PgB9XO-mQDs3:22 a=yPCof4ZbAAAA:8
 a=9NrqQH55-u2w1m51i9YA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA2MDE3NyBTYWx0ZWRfX2YpcaR/5L5kE
 DpGRDfLvT0yvtWv+BBhq9+mFawREfoFoBHbdpxbR1hnlEkJSD1yvS3OTC5xgoOPRDj3mpnZr4oR
 i7v+AtO5der7KevqZsZAHtGHYFgHOFH2mN1HpXHgoblrmlkAZxcbuamX/KvdhBZnvuAf3ADBXf6
 VWh6HP+o9qQYf4XFI/HQouM338zouRR6NQhoaCs76TtNOJMEkXflrEJ5BGMGkz8WmlCvlekEKsX
 CYdKwXmYnUBH0zytz4z4ZZ9naov+LoRHrVI1bbiLmHrOI8qNsq+YdtdiVyqk9iHlFnXmc5ebcfd
 6XDRuztK+daTwxheTdd7XWYjmOpf0/pklXemV/1LFZZ+saEMUnc9eD4hW1fI8/gu4Qcg79jWLf9
 9xwfMa5eSardWaKz85JW0j7qfLsAyiWCG3/xjJUEIzLYj0lvNfcJyWJ+f+SDW6TYgASYIDX6B9O
 P+mYBjYxP8WUfSRoW3A==
X-Rspamd-Queue-Id: 9F6A0226D43
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-19840-lists,linux-nfs=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,oracle.com:dkim,oracle.com:email,oracle.com:mid];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dai.ngo@oracle.com,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.963];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Action: no action

Christoph,

The new mutex, pbd_registration_mutex, is initialized only for the
top-level pnfs_block_dev in this patch. The mutexes for child pnfs_block_dev
instances allocated by bl_parse_concat() and bl_parse_stripe() are not
initialized.

Should we initialize these child mutexes as well, in case we later want
to support concatenated and striped SCSI devices for pNFS?

Thanks,
-Dai

On 3/6/26 8:29 AM, Dai Ngo wrote:
> With SCSI layouts, the NFS client must not submit I/O to the data server
> until the Persistent Reservation (PR) registration has completed.
>
> Currently, bl_register_scsi() sets PNFS_BDEV_REGISTERED before performing
> the PR operation. If multiple threads concurrently start I/O to the same
> SCSI device, the first thread sets the flag and begins registration,
> while other threads observe the flag, skip registration, and proceed to
> issue I/O. Those I/Os can hit RESERVATION CONFLICT, forcing fall back to
> the MDS.
>
> Protect the registration path with a mutex so only one thread performs
> PR registration at a time. Other threads wait for registration to finish
> and only then re-check PNFS_BDEV_REGISTERED, ensuring no I/O is issued
> until PR registration is complete.
>
> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
> ---
>   fs/nfs/blocklayout/blocklayout.h |  8 +++-----
>   fs/nfs/blocklayout/dev.c         | 15 ++++++++++++---
>   2 files changed, 15 insertions(+), 8 deletions(-)
>
> v2:
>      . remove fio test from commit message.
>      . rename pbd_mutex to pbd_registration_mutex and add a description
>        of its usage.
>      . move declaration of pbd_registration_mutex before the (*map)().
>      . protect unregistration op with pbd_registration_mutex.
> v3:
>      . replace PNFS_BDEV_REGISTERED flag in pnfs_block_dev with
>        blkdev_registered boolean.
>
> diff --git a/fs/nfs/blocklayout/blocklayout.h b/fs/nfs/blocklayout/blocklayout.h
> index 6da40ca19570..311b14334902 100644
> --- a/fs/nfs/blocklayout/blocklayout.h
> +++ b/fs/nfs/blocklayout/blocklayout.h
> @@ -111,17 +111,15 @@ struct pnfs_block_dev {
>   
>   	struct file			*bdev_file;
>   	u64				disk_offset;
> -	unsigned long			flags;
>   
> +	bool				blkdev_registered;
>   	u64				pr_key;
> +	/* Mutex to serialize SCSI PR register/unregister operations. */
> +	struct mutex			pbd_registration_mutex;
>   
>   	bool (*map)(struct pnfs_block_dev *dev, u64 offset,
>   			struct pnfs_block_dev_map *map);
> -};
>   
> -/* pnfs_block_dev flag bits */
> -enum {
> -	PNFS_BDEV_REGISTERED = 0,
>   };
>   
>   /* sector_t fields are all in 512-byte sectors */
> diff --git a/fs/nfs/blocklayout/dev.c b/fs/nfs/blocklayout/dev.c
> index cc6327d97a91..f1e77c4290ae 100644
> --- a/fs/nfs/blocklayout/dev.c
> +++ b/fs/nfs/blocklayout/dev.c
> @@ -33,10 +33,15 @@ static bool bl_register_scsi(struct pnfs_block_dev *dev)
>   	const struct pr_ops *ops = bdev->bd_disk->fops->pr_ops;
>   	int status;
>   
> -	if (test_and_set_bit(PNFS_BDEV_REGISTERED, &dev->flags))
> +	mutex_lock(&dev->pbd_registration_mutex);
> +	if (dev->blkdev_registered) {
> +		mutex_unlock(&dev->pbd_registration_mutex);
>   		return true;
> +	}
> +	dev->blkdev_registered = true;
>   
>   	status = ops->pr_register(bdev, 0, dev->pr_key, true);
> +	mutex_unlock(&dev->pbd_registration_mutex);
>   	if (status) {
>   		trace_bl_pr_key_reg_err(bdev, dev->pr_key, status);
>   		return false;
> @@ -55,9 +60,12 @@ static void bl_unregister_dev(struct pnfs_block_dev *dev)
>   		return;
>   	}
>   
> -	if (dev->type == PNFS_BLOCK_VOLUME_SCSI &&
> -		test_and_clear_bit(PNFS_BDEV_REGISTERED, &dev->flags))
> +	mutex_lock(&dev->pbd_registration_mutex);
> +	if (dev->type == PNFS_BLOCK_VOLUME_SCSI && dev->blkdev_registered) {
> +		dev->blkdev_registered = false;
>   		bl_unregister_scsi(dev);
> +	}
> +	mutex_unlock(&dev->pbd_registration_mutex);
>   }
>   
>   bool bl_register_dev(struct pnfs_block_dev *dev)
> @@ -572,6 +580,7 @@ bl_alloc_deviceid_node(struct nfs_server *server, struct pnfs_device *pdev,
>   	top = kzalloc_obj(*top, gfp_mask);
>   	if (!top)
>   		goto out_free_volumes;
> +	mutex_init(&top->pbd_registration_mutex);
>   
>   	ret = bl_parse_deviceid(server, top, volumes, nr_volumes - 1, gfp_mask);
>   

