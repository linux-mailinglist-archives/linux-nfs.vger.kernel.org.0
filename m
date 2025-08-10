Return-Path: <linux-nfs+bounces-13543-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 39169B1FAC0
	for <lists+linux-nfs@lfdr.de>; Sun, 10 Aug 2025 17:35:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 336D4176E1F
	for <lists+linux-nfs@lfdr.de>; Sun, 10 Aug 2025 15:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3B3E226888;
	Sun, 10 Aug 2025 15:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BbDtB0Nm";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="PbaKTkOt"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A301C683;
	Sun, 10 Aug 2025 15:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754840120; cv=fail; b=uudkyhcJQwMDLKk8rUQKId/d/TsY8yKCsh/8p8XwuRxHbqe2RJgAMKOp4SGtmAh4K8cz1/lSU0dFOOxFy9OHm1oSNhlWdfe9z1SginyqJA0x581aZiKmJkNffyL2twMPaBDAVTsknPLWnE3wa2EiEHj2ySTSD2v2PRro+HbZtgI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754840120; c=relaxed/simple;
	bh=xza+fDj3pZIAwhAsYn5xhSypojpKo3DM53OV74BWIFo=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qqRAlR5X0rX7A5ML4WktIsfMmplE+pjI9fhidKUnvT74wQ5O01rtOEJZ5UQMsmTHoP99ixfDMitSOAuWi8q0rX6h9P7jr78Dg6/G8a4cWNCo+4UYEQJ1w5r5wjLtiUYqUmQFbAZ16jDfCPf/q+Q7B1EwvICRXuRkDwKxB0JPv74=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=BbDtB0Nm; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=PbaKTkOt; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57AEUiaG009957;
	Sun, 10 Aug 2025 15:35:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=r/rbmF6Lv9lX6Gxq42KxE8zlLNlRaflT++8TUEqNSOY=; b=
	BbDtB0NmqzOodawl9traaeZw1luyVQsWvcwc431l5YtowY5kiRFo8hQ8CN9LmjR7
	YuOVjd/VmD3HmUiVZKSzqd37XL3YiUXMeUM/easiOpTnljVIgM3TrM7YaDRK7v27
	MqOjQMoyoVu0gVF4lEOmlRB3zoUZywHxwchrul198RYNPjHh5tem3tVYFoJy1ZQA
	2ZjXiqL5Ut9J/qNMBbMxcwOs1phLXVJP+Ds7pmxvE33bmhQDoBsChJweA+UCFJhv
	C3fZuR7rePYsng00XITNrCS55IDESqmliUoDGsY2al7iaj1eUixTlgqxclBLfzky
	FYg6IW1g6U1kmko1MElHDQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48dvrfs9ka-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 10 Aug 2025 15:35:02 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57AEBKIJ029979;
	Sun, 10 Aug 2025 15:35:01 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02on2041.outbound.protection.outlook.com [40.107.96.41])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48dvs7sra3-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 10 Aug 2025 15:35:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hDEu44nzOIeFJBtKRTJM7EXhAZR+AUWr1b44xsHeJsiwFQNQO7yrI+BYuN3YAB3fGCa5oOISlKeSa2clA4z7ALXRKtJcma9HxphMIWnd6CO5ovhpui98NIzcQEBH2nPdoQe7V/6VqPgpEMagyksoUBxdFjovYi4OY0H33dT6B3OL+yT5MyNAlYk91KTClCAIQrzcW3RSisBztlwA780UcKUSYaKZi9Rj/cYTx6GnIle6oP2n5F08CKOBhJIEGR06vhTkV/TsAz0USPXAgLy9SEGn6vxykCSy+air7VoO17G+FvDs1wBtHq8sklhq3jl5KO04V55w+mKCB8ROqkuNUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r/rbmF6Lv9lX6Gxq42KxE8zlLNlRaflT++8TUEqNSOY=;
 b=pRGREXeya67pL6jcGZIqx2mqxen5RTaG/EvAMJc17rf5kUO4GdTinWiPtm+GeUgwGFIkvNLF+o7dOX2jgubafJb0Ng12o5pRV7jolxqXD7z6JMLM5IXVgfua+ysWL3y9ZlIxjAGYF6f0mxB/wqAuul5W3fdcuVTZQpqF0AQFMJuSRkVnXxAxwY5EeBWJOVQ5jcMY7l2/XjAERs/28kItnabiyJqmJ8iNYxiPxcot6pQgY/dZlBqWqumZZetEVUrYjrQN4KHphA3lEsnQN5nk1aNbnpUWwnDJB5FwNSV1CBGHFJj4w5PI8Xlw7Chpu0V5zTDw76Q5aULCndCjQkqu3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r/rbmF6Lv9lX6Gxq42KxE8zlLNlRaflT++8TUEqNSOY=;
 b=PbaKTkOtKv0mDw9x61pCtTVWq45+h3Hl/9Qz+3jWwBNoDBO+/nFyHPzRQ8reWA8ZRlbFvnixoBL00Sh2/aVjANYangRE0VNJ+riEQbjcw94ALKK9ilB3T1SF+6Mzy57EIkZDcA1jaCYD48fLYFXB/OPGx13+DGWno3/bc/yuyus=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by IA1PR10MB7446.namprd10.prod.outlook.com (2603:10b6:208:447::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.20; Sun, 10 Aug
 2025 15:34:56 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%3]) with mapi id 15.20.9009.016; Sun, 10 Aug 2025
 15:34:56 +0000
Message-ID: <5facdb49-8ede-42c3-ba35-63b266f4e368@oracle.com>
Date: Sun, 10 Aug 2025 11:34:53 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] SUNRPC: Remove redundant __GFP_NOWARN
To: Qianfeng Rong <rongqianfeng@vivo.com>, Jeff Layton <jlayton@kernel.org>,
        NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        "open list:KERNEL NFSD, SUNRPC, AND LOCKD SERVERS"
 <linux-nfs@vger.kernel.org>,
        "open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20250810072944.438574-1-rongqianfeng@vivo.com>
 <20250810072944.438574-4-rongqianfeng@vivo.com>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20250810072944.438574-4-rongqianfeng@vivo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0338.namprd03.prod.outlook.com
 (2603:10b6:610:11a::10) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|IA1PR10MB7446:EE_
X-MS-Office365-Filtering-Correlation-Id: 85cf0de6-6aba-4db3-f5b6-08ddd8237540
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|921020|7053199007;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?aExCNW9ZN3lNVE1rdDBTa1MzTWEzQmI5d0NJd09WbW9Hb29NYmRiZ0VaMVVN?=
 =?utf-8?B?QXdNbFVmRUtBZFFpWU82UUwzMFpBZVVVNitFWWhKb1lZSjBoVXQ3cUFiaXFR?=
 =?utf-8?B?YUNtN0ltVVR0Q0I1RFQwUmxza0trZWpydjRiRzl6VFFtWWNSbjJDZERpcXl1?=
 =?utf-8?B?aEZCS2dBZ3dVK3FqbXpuK0NmZDBQU3lHV0VpNXFKaEFkUEp2THFWSFp2MGFp?=
 =?utf-8?B?UTVrMk0vZ05mQkIxZUhFbXZtd284V0VuS2diN1ZjQ1Q4bkJNWlhIbmJiOTdj?=
 =?utf-8?B?Z2dnbEpBWXc5Q2hJOXJsTi9jUWpGYWhsQVR4VDdGSWcxTWhIQlIwVjc1R2FZ?=
 =?utf-8?B?RXkwYU11Q2xTYW54c0NZemtzMXJVNVVvcjdSMzNmcHl2WS9XR3cvenV6R1Bt?=
 =?utf-8?B?cit4TUphaVJscmxEUUgxdnZmcGdNMkZVVHdtWSt2ZzY4cmI3WnhhQlVSdTl3?=
 =?utf-8?B?bE8wWHE2TEwweGExRzVBOC9QWElSMFQ4TVF4UXh1VHZCV2w4SzJaTHFFYWVK?=
 =?utf-8?B?czR5KzFOcVNNWnJENllqcjhZQUs2b0FhOFhQZndQZmx0TlFKTDJvUDRsTnVW?=
 =?utf-8?B?b09UbkZpMG5xRXhZTGNNNlRvY3ZXNWszN1dvUmt4WnNHQWFMaFBLUkhwbk9P?=
 =?utf-8?B?cGtncm52SW9TWEJZRkJlWHlNcDBGZG9QODJySDlBdVM1aERIdE5GdDZKaEZo?=
 =?utf-8?B?S0dDQnZGR1NXRjZvaEw5Ujc5ZURjSkR2QkZYaEEyZmNMam9aMjF3ZkU0RUd5?=
 =?utf-8?B?OUl0b2JKdVpYeWV3T21QUFF2VzNMSndOU0FQakhlMWxYVW1kUzhEYkYyYmsx?=
 =?utf-8?B?WlhWWnZRcDltSGZUT0VJTjByM1FZNHdNbmp6ZXRUNEEyMTB6eTBRSUc5S0k3?=
 =?utf-8?B?VWR5aHhBei9oMk1qM2RRSVJ3Z0IyVnVSNnZyVlZvdTd1UExxWU5ubGhlN1Uy?=
 =?utf-8?B?NWFSS0tvVm0ydHhjTzNBbnZwQ2RxWnZlUHdEaFlKQ3JMVmxWL0hkRWNkVC9I?=
 =?utf-8?B?L0lVYVF5WWVEM2RSWXE4d2FmeHRTNU55b1VhTEJzc0dNaWI5aGtZbHVzSUtj?=
 =?utf-8?B?VktLVDE4dGhWUThtYWR1VlZUZW8vYU96Yyt3NjNWWjRUVzlSZWFWbW9Bc3NH?=
 =?utf-8?B?SVhKd2Z5V2N0RDlDc29LOVhKdVZRdHJBY2NwSDFaTFhIaFlSdVQ1K2RZMXZ1?=
 =?utf-8?B?aW82UjNORXNneWNJMUs0dGVseXpsTGJ5bVZNazlUK2E0aUlsUFpndVhnNWdS?=
 =?utf-8?B?bUx3M093b3JjQkxVZUMxU05mazNoUjgrb1J2Z3B3RDVjSU9WVTBMR2kvTEZa?=
 =?utf-8?B?dWdUaUFPSTN6S1lvS0x3aXg1RTh3bkdJOTBSa3l3NFdmbnY2eTF0b1dMaWc0?=
 =?utf-8?B?VVVlL2tnbFhVVkJ2QU9PL0xXOUFaeVlPcExwY1djeTdRK2JMa2JyYkhFSlVi?=
 =?utf-8?B?Q1RnaHQrNERMc01Qd0tLaDgwNFlzeUVMVkM0ZzRKU3dFOVNYc2x0OTYvaVlQ?=
 =?utf-8?B?YXhQb0ZwTjVManZjTTg5YXdST0F4d0p5aUMyMXR1WlRYcUwrdWh6M05heWcx?=
 =?utf-8?B?ekxXVEdraHFtNjJFMTJPTWY0VUZrbDFST3FKaW9HSzNxbHpPSFQ3QmdNVFhq?=
 =?utf-8?B?amlnTEdYNGhicWxKbDI2M3BDVFBxdmtDVEdxQmVGbzQrYkVUU1l1NVBhOU1B?=
 =?utf-8?B?STdYTWZJT1pGZjBoYW5ST2VaQm9QcmRMR1FtanU1Rlc3L1kycUlaNWlBcUsy?=
 =?utf-8?B?dDRjaHhpVUxEMW1SUlpxMUovdmFPNS9pUTNXakZnL1ZpWEVsY1pUTGllaGRl?=
 =?utf-8?B?blVOaWFhV3JjQlZLWjRYUEtTUGlKVFRCYUEyYkRLVGtseWl6c2FwUWxzcVZy?=
 =?utf-8?B?Nk5xNWEzQk9PcHhzM204U3dxZWVMNFlDUDB0bHNISHU3YitHbWc5UTZJVHRC?=
 =?utf-8?B?bkZuRExJL3VUY3RQVmpkOHBTZkQ0ZXBlcFhVR3ozcUo2V2hHRXd3akNHRXBq?=
 =?utf-8?B?OS8zWVFMYnhRPT0=?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?eG1TT04wOWVuQ2VaRVlOV2dOQWtZZ2svNktWMU8waC8xOENIOHNrUWZzcEVQ?=
 =?utf-8?B?Z240VmFKVUJlaHE5V2hsajdkZExMSGFYZ29CSnFGZGFnMHc0d0g4MFo3OEZK?=
 =?utf-8?B?ak5yMy9qSW9rWnhvQkNWWUlYTzdpM0JJR08vUjVZYTNlUU0vcnpaWStxTUQ2?=
 =?utf-8?B?VTNwLysweDFTMCtST0tSMVhhWTM2R2ZTK2xVS0k1Y240azZ5QUw1QnZKRTgz?=
 =?utf-8?B?TWcrTFd5NWVHajRWWm9uNVZHV2RyUTIzN1pZeldscHhhTVdtT0lwdEI4a0Yx?=
 =?utf-8?B?MDFqWUNTbXRGdjV3ZHdMU3JUZVhRVm51ZzJCejZSTEV5ZGdSWWswejFpS0xm?=
 =?utf-8?B?M0JKYkNpbHZaNUh6WWJNQzE3V1lwNWhJZWNVcm9mSm5uUVd3YWpNdEVmcWNz?=
 =?utf-8?B?NnMxNVpXUVhrTjB5Nmw4bXAyRlBOUW5TZEkxS0RiSzZleFRTS0FscW5pc3Bo?=
 =?utf-8?B?MHhYNEdNU2QvR0Vhaml3SDcyaCtJVUl1ZlRqMUhqU0xSaG1xTnZMV1JLVnZU?=
 =?utf-8?B?eGk3bXZsUDNMU2xxZ2N5Q0x0L2hTeWlIUFdUTW9NdnJvM1p1NWFyYVFGcFlu?=
 =?utf-8?B?eE9rbFBBQlQ5UVJUcUtWaXRpbEpneENGQm9YaWJWTWY4aDhQQis3d2o0eW1n?=
 =?utf-8?B?Q0xsaDI2N3NsL3M1enRJV21MaEE2VUVLVy83ZDNscXNHQlZhM0FFUVBOc3M2?=
 =?utf-8?B?RTJjMEZMdmFsTFFGOTdIUHhwWWJqczRSRXlibzZtVE1JMWZxK1ArVVlDMFE1?=
 =?utf-8?B?TDV0dUlBVklqckNib21FcU54bjBvUmozdFl2NHVYOHlLZXNjZkN5dHZUbzI2?=
 =?utf-8?B?TUoxOTFlZ1dtY3VrM0V3TERrMnFkby9qSHdzNVQyUkRYcHVmOU9tOTMxbkFa?=
 =?utf-8?B?VVJQVmFtTldBQmJiWit2dW1yQ0hZR3ZDSXNkTUx2OG5KMndBMTdJenFrcWJy?=
 =?utf-8?B?MXc0N2puL2FacEx4a01FRHh5dDRvK0RZa2llM1BMTkhvbXZKVFlUNzZmUnIw?=
 =?utf-8?B?dHBBektWdTBpSHpPbzJXNW15OU1ZdDNoNStvTXQ3UjZOYmRSTjZHdnU1d2JF?=
 =?utf-8?B?VnNHTGplSEdnbVFqdGRnTm52dEVyOFo1MGFsNUJUcmVXVmgzRkNYVmlNZ1Jr?=
 =?utf-8?B?VmgzZi9FZFdGbTZ1SmVxOHFGS3FXclRiVnl6aFNsMDVOU3EvNWRZYXNZWGhj?=
 =?utf-8?B?Y1psb1phS3VSMHdTUTBQNDFuOEpLZG1uR2xDck5FRlVzMy9DTTJSencyMEgx?=
 =?utf-8?B?TnMrdUFMUnp2Zys4cEJYZVN4WG8zeDBUakxKWHFydmxpWHFZd3JIQlp1VG9p?=
 =?utf-8?B?Z21vSmxGU0kzNHRXZ2k0bGd1dnpmbkViWldNR045dTZyWmVPZVlNbVZzM2gz?=
 =?utf-8?B?eHRUMjNCcWpvaHNia3dmREFoZC8rOG5uZEhLZUZYaFlnWVJOUEFyTms2T1BE?=
 =?utf-8?B?ODJKOUw4bmtxMXZnam9oQ0JsOU5iaWJOMVUzNmhXWVMvRU8ydVZJZGpJY01O?=
 =?utf-8?B?UzV6d2I5bjEwMWFJajEvSkF3RElZVXFvNUdGOThhbnNEbU5lQzNUbUNCTzFT?=
 =?utf-8?B?V3ZwdUs2c3JCaUU3M0l0bkVTWjJvRXZ5WFJnSVIzWEJ2R2hiR3FKajY3TjhV?=
 =?utf-8?B?MG1LU3pydU0yQVQ1d2pwZ3lBMEhHZGRUWTZXUzFyMGNVT01MdjVNc1VoWFhT?=
 =?utf-8?B?YmdxRDk3eU5NR0RqWHo5K2trSncyNW9ETStoUDROS2UraWNiNmI2WnRpMG0x?=
 =?utf-8?B?RWdWMGpLZGdXOExHdTBvS0Q2M2ZUaEd4WW8vQnpudlF1NndpY01sNDZmRFVK?=
 =?utf-8?B?VkllRHFnSEZ6OEx6VGlGM29VVU82Ykcyckx0ME9zUU9zT3VEQmF1aWp4eEZ3?=
 =?utf-8?B?ek1iWmdWTUxzTXIzVE1CSUtMNkdieEdudTMrbFBjQU9tZENWZTV2Qm1ZVnhx?=
 =?utf-8?B?cnVqTmhzQUNJTEF0N0hKeHZlQ2JKZ2ZFOVpHOFcwMW55cTBXWWt3T0FPRHV4?=
 =?utf-8?B?MExuWEhKOExPNFNxTlFkR0dZRVpBRkgxclY4NTFBNUVqYVk1MmlmMVlpbjha?=
 =?utf-8?B?YUdyaE16VFhBenBzbUJvVzJSRGJ5Y1RBT1FIajVZcnFteWNWOTh3Ui8zTjRi?=
 =?utf-8?B?QUNOaGo4STNiZDd4NFRaQ1A4OU9TVk5KcFhuZEZWNUZHV0tGS015TTNYWVY4?=
 =?utf-8?B?OFE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	3zM2p28FVbGBO9OFZnExQoh+N52Nkwsf4dshsv5rX9yHM27FjaFPrmBCtIT9X9J2g9qKevAE1sy3CqPjxE9R/syNK2Ns77c1WCfzuP73IcnlBMqRvNCQU7M2DXfL0kSt6PAaNwZRNG+znXexgho34tm8KS1rwUW10cD4RMG1t+KM47JFxUVr14naRK8LTIBmtOINFVv5M+VjLDXZXnIzMWPp/xU5+RWVHufCkKrO+SDYT72xSaQq5JiZFbFW/kuFGpiCjLvuJGR8G+7GJC0VZeUdHOS74aR37zaEbQkXntm93QNsnFsnR5iRcTpQULPEOtLdHmE+Jiz/WAAKOsGP+qW7Ii51GPkNJqTzP74GsxD6J5mEBHR7Kg7LeNTFv8np4nB0tYFYEIYyijhoK+UdDk+TP8M3KN4veEMryPAOZQwBNP1IqYRTteOzdLhN+1yjVzGM3MDWZGmJpP9zZoZwci8fMO7NCv5sUFDPUy9L7xzluIyOlbqKCW8oIwslxbKXq7WwR8M+kjZS4CNIJhhHUnaZVHGEGF47/wNhjrVVBPrEwR2FT6UlcmGgrlATaH3q5h3YsJyznCBUk4P8MN4+HuwysRz6DQIcGE4o7zEIqfg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85cf0de6-6aba-4db3-f5b6-08ddd8237540
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2025 15:34:56.0980
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Yx9KhSRYQqdbiK0ylM4yekzD3PH+bZuqAzZcyVglZ8dnY8mTrGAdarr7P+93D6XZHyjLZ65lWVlwqCxD0WfrrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7446
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-10_05,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 malwarescore=0 spamscore=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2507300000 definitions=main-2508100113
X-Authority-Analysis: v=2.4 cv=B/S50PtM c=1 sm=1 tr=0 ts=6898bc26 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=1WtWmnkvAAAA:8 a=yPCof4ZbAAAA:8
 a=abX8VSmDdWvCKrzMVIIA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 9wzgCWK2queznLzYng_wHkWiCGqlHv77
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEwMDExMyBTYWx0ZWRfX2+kNs9kLkmQR
 gVKgzMMoK/f3G3Z+EYt0zYCU7zDWpmHyUOoBZuNaeRBVIn1w+BesXwUfg14PADd0a9Mpb3P0YAY
 z+lgB7Y0lp2CUtL11HWMrv8FOYsZwZVzZk5D24UgZ12qLhEYJlczvrVpdHGPJQpcIKUpOujQC9O
 2w3VW41FDA01UGVfH72U/blde2ylZfMkDFWIV2fllhQ8hp2WqChEQb207NoHwyTe9TkDmtugfG1
 lCZ8r8+S74GwgnMNYZa53Z8QsKRziHgz5o/NJS39atIju47lEh099seOvGHo4KzvybjAFQFgHbN
 vfMoo6wQHkNL0Urs3uzP53m271K1JH4k3+UPu9IB/D0oFvK6g1XgeoYWBIKLIYUXKtjwR8dIkzO
 fGo5lysZbZSsl143PnILTXKlpe94HBESRy+TfhGAmeisls1DLM7qh1k9FmyYUwwaMO71due0
X-Proofpoint-GUID: 9wzgCWK2queznLzYng_wHkWiCGqlHv77

On 8/10/25 3:29 AM, Qianfeng Rong wrote:
> GFP_NOWAIT already includes __GFP_NOWARN, so let's remove the redundant
> __GFP_NOWARN.
> 
> Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>
> ---
>  net/sunrpc/socklib.c           | 2 +-
>  net/sunrpc/xprtrdma/rpc_rdma.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/net/sunrpc/socklib.c b/net/sunrpc/socklib.c
> index 4e92e2a50168..d8d8842c7de5 100644
> --- a/net/sunrpc/socklib.c
> +++ b/net/sunrpc/socklib.c
> @@ -86,7 +86,7 @@ xdr_partial_copy_from_skb(struct xdr_buf *xdr, struct xdr_skb_reader *desc)
>  		/* ACL likes to be lazy in allocating pages - ACLs
>  		 * are small by default but can get huge. */
>  		if ((xdr->flags & XDRBUF_SPARSE_PAGES) && *ppage == NULL) {
> -			*ppage = alloc_page(GFP_NOWAIT | __GFP_NOWARN);
> +			*ppage = alloc_page(GFP_NOWAIT);
>  			if (unlikely(*ppage == NULL)) {
>  				if (copied == 0)
>  					return -ENOMEM;
> diff --git a/net/sunrpc/xprtrdma/rpc_rdma.c b/net/sunrpc/xprtrdma/rpc_rdma.c
> index 1478c41c7e9d..3aac1456e23e 100644
> --- a/net/sunrpc/xprtrdma/rpc_rdma.c
> +++ b/net/sunrpc/xprtrdma/rpc_rdma.c
> @@ -190,7 +190,7 @@ rpcrdma_alloc_sparse_pages(struct xdr_buf *buf)
>  	ppages = buf->pages + (buf->page_base >> PAGE_SHIFT);
>  	while (len > 0) {
>  		if (!*ppages)
> -			*ppages = alloc_page(GFP_NOWAIT | __GFP_NOWARN);
> +			*ppages = alloc_page(GFP_NOWAIT);
>  		if (!*ppages)
>  			return -ENOBUFS;
>  		ppages++;

Acked-by: Chuck Lever <chuck.lever@oracle.com>

-- 
Chuck Lever

