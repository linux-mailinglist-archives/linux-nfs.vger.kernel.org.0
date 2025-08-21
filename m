Return-Path: <linux-nfs+bounces-13847-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03A48B301FE
	for <lists+linux-nfs@lfdr.de>; Thu, 21 Aug 2025 20:26:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE6E6AE0690
	for <lists+linux-nfs@lfdr.de>; Thu, 21 Aug 2025 18:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D58AB2E62B3;
	Thu, 21 Aug 2025 18:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Nybqazte";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Dnu1aJrq"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7C83341AA5
	for <linux-nfs@vger.kernel.org>; Thu, 21 Aug 2025 18:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755800690; cv=fail; b=kDFU1u6nssQkJS2EYT6iWJMASyhiRnkJ3O2HG6epu6IDIMtED7/5IScDuwOa5UfebLBdumZDJwbss1WgsOGed5vaweHTDtoz6lXustSVIAE5shtrphPeJhnVU8f5pDSB8l7Mb73NXk92y15iNCn2qNLtaGX+Yvv+8A1hyGkTN1Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755800690; c=relaxed/simple;
	bh=DfVlLYtrl03A7wxm8lOKiNwlVTqWROp4q8JhGy6OEN8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VCK69x9NQVx5vgWGM6OjlHgdJLq6Jg8Pwstt329izbOw6P/Skk+GQwHHo7dnmLEiE7p/L086Cm2ec/5WnbfSSwCUQdNg68Q0b1Rv0YJ1fqE4sPUqVUDOgGTKVZsyqXrX//CL4sn00x0BxtNyfPZVLbuab0gWG2YPJLsVpATDL9w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Nybqazte; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Dnu1aJrq; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57LIN5Xd004957;
	Thu, 21 Aug 2025 18:24:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=Enc9JTEbLR01wvP6EHGz5I44jc9954u3rk1FxJ6XJpI=; b=
	NybqazteUmeJyy/gK+wLcuAcnHq/gcRp4qlhBFl4Eu8sl1PwhIZrfSYlUMymjnhR
	i0FxOdK/3CYwRnOJHbPVuDODTKnuoCZPBBCqwiWCO48axTMq8YrA2una5kEjqp+d
	gxN2TjFleCvpZ+AbcGuoTKBbpkjPBIWYxQrBLT7TysOv7AWgFSt7UtfsaFUkRGzp
	Exl7bKOMlM+mMW0MyN4JKmC5ozx7bScZOcIf9jgYef6yJkCbj0cHbvIkJnlBWMGB
	6E6hjSf4SLfv2t0Faxof48YiTRkhTuD+Ytozw3w4KXdAVsGIpT/s1tILDeLhoSFz
	YL4OiQv+WrXku2c6SIRL3w==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48n0w2c5j1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 Aug 2025 18:24:39 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57LGx9H8039426;
	Thu, 21 Aug 2025 18:24:38 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04on2080.outbound.protection.outlook.com [40.107.100.80])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48my3see5d-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 Aug 2025 18:24:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kvzWrtI+3FoHsgKZyIUSlLpRVpmO4FjSQeRhx/WKbkEiYrlizPbIhOjUIv4vx9jU30hHdBTt8yawbUP7XyFywBcWipFB+6Ik6nB5MIv2lb2XhMtSsw3vnpz1DzP6c6pgr6y6gW1mrNKIgcAZGeJWP1owlhJoUR5B8gS3Olq1sZXM5+6r6H38vPzVcPQAtlrr11G33AslqLNx+h3KgKjEcvUQGn5T7fRXKQlmctgMYwZvMGd9g0WoPAPg6353NX/EDXlt0x69nbLfovYnbIq7yay9nVFTjvDeM1dgl0kOmfskmNmkBIATcRGgwn2ZOIj5nRV06fH82y0RUf72+NUznw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Enc9JTEbLR01wvP6EHGz5I44jc9954u3rk1FxJ6XJpI=;
 b=fJqyYRth3ns+frN2wSQ2O0/AkzEFSVee4Dqc55LRKL3oH9j5x/xip1iI8x7b+MZ7i1JsJ2OuObcHsGJuaStzy/3wMu2rk2G0SRjZT/xqjGphoP7Vh2mTEQwn3hiE+HOVDJ+V73/k74DTt93iJ6PbX5SeNevwLckQ+W0STR59sPpMn1Cpn/QVY3H+fd3xcjkj4W+F0f6c+Gft6J4ikqe4o8ZhEhAYNZjQp0UM07oo4/fuUIxZpuew/SLaIoQ4r0Jqfptrm4x0Rea2JZzY1/nlTF4QCX+3fayh+wr/ApTqqWXn7yQNu8RiUE6cSfHOzR0De81CCYOymgqefJMHG8j7Kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Enc9JTEbLR01wvP6EHGz5I44jc9954u3rk1FxJ6XJpI=;
 b=Dnu1aJrqFcS9WBHSDk8G7/sUHZ2CBDpOAzwkoznLCByFexNtOnQ1YO2pm23Gpx6Imunc8zue9+eEQFgk0TQkSl0F3Uo6xrLM8Hd8fZV6URd4QARaCLHpPt13oazIfTA3LVSjRAg+fwSeERQFJ9J6kAGETCkaSYsYSB45Sm4OPhY=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH7PR10MB6628.namprd10.prod.outlook.com (2603:10b6:510:20b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Thu, 21 Aug
 2025 18:24:35 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%3]) with mapi id 15.20.9052.013; Thu, 21 Aug 2025
 18:24:35 +0000
Message-ID: <f54c0edf-18b3-4432-af0b-7caac995fe01@oracle.com>
Date: Thu, 21 Aug 2025 14:24:33 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] lockd: while grace prefer to fail with
 nlm_lck_denied_grace_period
To: Olga Kornievskaia <aglo@umich.edu>
Cc: NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>,
        jlayton@kernel.org, linux-nfs@vger.kernel.org, Dai.Ngo@oracle.com,
        tom@talpey.com
References: <CAN-5tyEammkfv3QGwe5Z38q1nFAxYV=REFDN++3XrX7Lni+H0A@mail.gmail.com>
 <175573171079.2234665.16260718612520667514@noble.neil.brown.name>
 <CAN-5tyGXxzmMipt8fcdMkpSiPq8cxF5++OJcZriQbcjk9JK3GA@mail.gmail.com>
 <8d72170c-ac40-4652-96ef-5ca39b2cb0c6@oracle.com>
 <CAN-5tyH4qbcxLDaEnnFABHSC3DPpHmMk8O+GEOX1BubfLS5cww@mail.gmail.com>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <CAN-5tyH4qbcxLDaEnnFABHSC3DPpHmMk8O+GEOX1BubfLS5cww@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH5PR02CA0004.namprd02.prod.outlook.com
 (2603:10b6:610:1ed::21) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|PH7PR10MB6628:EE_
X-MS-Office365-Filtering-Correlation-Id: 64437b76-e903-4154-a9a4-08dde0dffb22
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?MzU2ZnJSTEJnNEFBZmRjNUl3ZGk3aHBZOEswdWluaXpVd2JiSWYwYUtjVzFm?=
 =?utf-8?B?d3Y1cWNmUVE5dGlJTjZwWmQwNjZrNVVCcmZQblNtWkFENkRJWjRXZUVUcmV6?=
 =?utf-8?B?M015OVlNMW9lM2txZlVkMWd1T3UxeUd4UkdOVFlkd1hqRlgzSTBKWVprb2pm?=
 =?utf-8?B?ZExaOU9wRTVuemYxKy9Ia2hkbk5TUnFsek9xOTFRTkg2c2sxQlRSMXRCL3pr?=
 =?utf-8?B?V2xETHp2cUxwaDEveWp5QjUrVHF5S3VyU0NCcm5Ud2hCQ1drSXpIajFaZ0tn?=
 =?utf-8?B?eERBN2xwR2JJV2tjQjFraWxPMjFjQllCRE5WSTVXZU91Q3VHVWV2TDE2M3Vr?=
 =?utf-8?B?KzgyMUNvMlBPOGJvRUVEZHVVY0RyWjE0LzYvS0lHR2ZIUTk5OFFPbUZYQVBJ?=
 =?utf-8?B?MFphRStkZlJ6U0pNWWdzK0piSVVzN3BLR2tRMVVQRTZNeGxWclFYZ08xemZ1?=
 =?utf-8?B?eFFjMkNFQzdWRnJwL3FBT3FDVms0T2tRNmQzSXpHeHZuMUxBa0tFa29uU0wv?=
 =?utf-8?B?bnYwS3JKaC9KZjBGdXhJREp1R0RhczhOa2VocVVZQWF5eUlVbytlRGUxcWJz?=
 =?utf-8?B?YndMeWo3MGFYT2NpdTdTcStvbVRwa2tMSjFOV3NXZ0VOOW1qSTV4WlB4amha?=
 =?utf-8?B?SkZrYVpsa0EyNUw2WkpNZjR0b1Q5ekRRMjd6eDZ1SGRKOU9VU0hReFZNQ1Ju?=
 =?utf-8?B?clNMbXJEL1NTcm1xSGhGdXRVNndCQmpxc2YwaFo5T3phZ1VMOGdnUnZlcStp?=
 =?utf-8?B?WEtTUXpON2ZJWjJOTC9rbTZSdzAyM29PMVBSU0cyVG8wd3BKUzBWVDFxN3Q5?=
 =?utf-8?B?dm9XU0tUWjZNaUpJUUVvdnBQUFErODBhMklhQ25VaFREVmc1R09KMlZFTGlJ?=
 =?utf-8?B?akpESWM3eHJSOXE3WFpKenhvOUJ5d3lYVTRPVW1nMTYvM1NIRTZlZ205NFBN?=
 =?utf-8?B?MUF4K0tPR2FZN3lqNlQzTUczVFl0d0xKYzZvMjRCV1hURWh4REdTN0lnMkdr?=
 =?utf-8?B?L1FNa1RhVkhMNitQNTFEcm1ZTnFWQ3d0QTR5V0lLTWVWYlljTlNVdzV6bHpH?=
 =?utf-8?B?OSsxeWRjWjRUS2ZKYXV2KzNEMEtndlA4eUZWTWRKM3ZBbTJqNnhhbXRON24r?=
 =?utf-8?B?M3YzdDJUVlBJd0JhQU1HdnpaNzhoQ0loWldXMmU3WnMyTWhZc3hLc282NUNa?=
 =?utf-8?B?bWh1bVJNOXI3R1lDZGNlNDl5Y3EwK0lCS3NFVWhaeEI0NnR6WHBublcvWU9K?=
 =?utf-8?B?YnhYNWIwVVdUalFpdW1OZ1R5cHZsaTRWT3NJVkxkRXRHQnN3T0hMb2xKelRW?=
 =?utf-8?B?YlU1ZzFLYmV1RDk0VTdiZXpFeXNhZWVMODBVWWhkYnRwbTQ3dUw3eU13RUhp?=
 =?utf-8?B?c2NuTy9kZFpsRmJjeDBTYlBZUm5pbzJneU1RczVURGdHNzYzS0hKTWhwbWlE?=
 =?utf-8?B?c1gxcnZVVUNVVWEvcjgxdkl3N25KQjFjSFJOb3ZucWdYQnZ5dVB5Vk9EZzAz?=
 =?utf-8?B?NTA5RDM2cUpCRW9waWczTThHQXh6a2VFNVJZUE4rSjdpZE9uSUtNKzdoZGlu?=
 =?utf-8?B?YWZMMm8zS1FUZk4ycjdZNUN5SlBJQ1l4Mk8vTlNqSEdZd2x1RDBoNC9lVnpQ?=
 =?utf-8?B?NnBsZFhJYkdNd3hjbHh3SytkamxocWFEWFhhTlNLaUI3NGlXK2I1RXIzMHpk?=
 =?utf-8?B?bjY1RWRUWUo3ajVzTkNCZmxYRmswaGFDdkF4MVoxbnJCV01LbFdhcXFwTjJr?=
 =?utf-8?B?em93K3FHYXNxdzM0ai91bHppd3pLeU1oTmV4bW00bnV0U2xlenR3d1BQWnVB?=
 =?utf-8?B?K2tBcldhRi9mZ2RYUmVDeElnOGhTSWdFcHJLL2ozbGZjNGpUM0pIeGROaWFu?=
 =?utf-8?B?RnVBalRMRFNnSUVBdVBiVllDLzJXQTF6T3VOekYrQUxEbHp4YkxadnhOL2Qw?=
 =?utf-8?Q?73sxg8L/LRM=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?RWNSR0wzRktrTHVLS3dSRkdyaXlrZWY1ZDlFUWhDc3daYlo4RHVZell2WlZX?=
 =?utf-8?B?QXM5Yy9iV1N6cGhLcm81VUR5R2lCbGJMZjh4d00zVjZEMWpick1UZC8zaTU5?=
 =?utf-8?B?WHdhTUFZa0xhQlI5dDBoSUtmOW9YNDVmK1VqREw3V0VibXBLQ3lKTHdEMFBH?=
 =?utf-8?B?WnF4TGt0Sy9NMjJ6RXVFYjMweGIrM002L25oOGZpbGFpWURKQU01VlAwYTJ2?=
 =?utf-8?B?Ymo2RU1BSkRWOTlrTnJMZGRQcllvS0dCZzZJYTZxTk1Vd04xamFkcDgwNjND?=
 =?utf-8?B?R1pGZnI1aVFaMVgxdW10ZWhoU2dBNkFhQnRray9LSlVkTzdsbUFYZmJLVTFY?=
 =?utf-8?B?VXdBTlZnN0w0RGhUT1ZNMThteDRKcjlxU3J5TWxCcE5Eb2VGRW9zSmVNQ3FB?=
 =?utf-8?B?OVM4SmRJaDJGQkdKUHZmN3FFNmpmSGlJaUZHYjJmekFaZVpWa3Y1d1BHdkZu?=
 =?utf-8?B?U2xDbVZuR0JnaVZTcG41b1Bvb1Y4bnBsb1puR3gxb0RoUitPSHhxZWJGalNW?=
 =?utf-8?B?UGlmYkJYbldpM3hhUzFQejc0bytNYlJiQk0vMzRRRWpFb0JtN3hXUjZaU1Uz?=
 =?utf-8?B?KzA5NGJNTzBoSzloRnFsQXBhODZKQmZKRW9ZUmlzaU5qMC9ydVhEb3hFdG9Q?=
 =?utf-8?B?QURNaUtoaHQrUTFPTXVpQVlQeFplcnBDQnRkNG1zQjc2dU5UbkZCRHJwOGNI?=
 =?utf-8?B?Q0pTNC9hbERNcTBjTkFibElBeElaL3lVM0ZGSlpvTDZyT1J5Y3M0N28xeHE0?=
 =?utf-8?B?dE92eGFvT292cCt6V2IyQ09wSWF4OUlkS0lXOWlTdjVaN0FFR2M3NXJBMUZh?=
 =?utf-8?B?OFpMT3BSV2ZrQ0VrUkNNZysrblZlK0gyRGNnbXNHTjVuUzRrMTl1d0ZVd3lM?=
 =?utf-8?B?cFdlRzhhSFFna2hZWjRsM2lhOXpZVHNlcUM4VXFqVWRYM1ZMVkdwM251cmdF?=
 =?utf-8?B?R054bFQxRmtsT3RReHhMQUdyZitTSmJwRzdVcFFld0h5SnhLTkxDcHZBTVZx?=
 =?utf-8?B?ZjBqSXNUWTdPS3JORE9XcGxnK0VNNUduTTNIYzdjRUxoaUljWW8zTEdoOExX?=
 =?utf-8?B?Nmh6UjExUDFoODJMaW1SZEM2Yk9FTUMxZnNUMjRyNno3bnI4dGFYTUhnQWxX?=
 =?utf-8?B?UW9sM1FhblJiajlDek5Rb1NjQlRZOFFMNlZhTVJQb1lpSmFzeHJqWlVMaU9s?=
 =?utf-8?B?YzU5aFlsTjdEM1F3cmJnOUZsSGJLZ21RejlkV3RvT3UyeURjS3NwK3RGNGRB?=
 =?utf-8?B?M1Z4MFJYT21hdGhjcjBDSlplRUZTRXNFU2ZIdTd0NTNFdjFKbXFSWTJYQnRE?=
 =?utf-8?B?TjJocEEySzkwVmJ0Smx5S2EvMFIrVzRTY0NCdkZBbm5mN2MyUGpnTHBVeFVY?=
 =?utf-8?B?S2VERWhVbjBFakxLaXkxZ2kxYUlEZ25adkFncmpVU2x5VENwNk9YWkM0OFVa?=
 =?utf-8?B?dytSUm5CMi8xbm45Vy9vek9JQ1pzZ2JERzJVUDhtZDlMVmJBc29UZFI5L2xy?=
 =?utf-8?B?MUVFU0VWSlJHdk9LY0prdkNrV2MwRFBKdnlRbGFwSk1DQlRuME53MUdHWW1s?=
 =?utf-8?B?MndZU0xhTFFvNzd4QUJKSVNsYlZSWmtUMTNmQzFOeVUwVkdaa2NmZmtpTWw5?=
 =?utf-8?B?TDhwRmdDTy9BOUlxOWRWZy85SFZVZ1dUU0M0ZkNTRGY5eDdSU2Z6K1ZwL1p6?=
 =?utf-8?B?VlNiZ3dPMjNieGhVUFltMDA3MFNheUdhV0dMd3UvOWZjK1RWL0lXQUVycUx5?=
 =?utf-8?B?YjFFcEpJRXBpQURXNTVFVmpYNlJFRmJXOXNabzByZUFCK3NZSmxWa0xQcExm?=
 =?utf-8?B?Y3RxNmRXSElPL01XdFMrS3hCY242RTRHZzV6b2Y3UXM4UUlEWUdhY25iRlpp?=
 =?utf-8?B?OVQwRFFBa3pjUXVoclN3cDF2RkljS1RBY2tMc2RvWDl3Q1duNTVQT2QraU9z?=
 =?utf-8?B?ek4weGNZTllJaVM4cnpMeGwrMHNIY1doRDBNZDVkb3hjbHRBZEZjU1lwOXg4?=
 =?utf-8?B?d3dxN1Z2WE83RDg3MGVKOVJsTmJlb1dpMnpqL1NJclEzZ3dBZFpKNFJaSE1t?=
 =?utf-8?B?ZDlWMGdGd24vaFEydllqekpkdXozT3JZRlRldjdVNFhkMmJtQTFNdHlvVVpM?=
 =?utf-8?Q?RKOIQG20k2BZO1RVbmQTnS5eH?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	JFMUyCD2wxrYPhQQ/ZKlniYH3RSAC9vguYoIwJmMfWHgz5oZR3Wfj/vgcs3XGZpInQnUh2tPl27H4vWgKeGWuBhT+zrIQukB5JjgZE7EcnfhFLRVaY2zoIwVuLqnvQlt4rj+5jnBkFZuxkN9TpH4NAO3FcW9W1PLallIUnfGwsBnZmc2Bb9ux3R9e9mX3PHg9EKVtJYKpkMyxbsyAGytLKW8opHBG1DEz+BIrSwBYoIQN+Yo7SjzALmPAXMhNUDfuH/1/EmsTc81bOxtmMyxWiLFhk0zvsJTWugaEn7mJOBAWF195VGW1icXhgCuEUHsX/lr7pQzVjipx30GA/GecIZzgX60O6Sa9doR4q76A3mOi4zzfp8Z+7xe1KgYKCKavMu5Tr0OjlVx4kyfrGEXWECfcTFHO+xvP+hzUOm54EjUyPKHeO34MPM8XfcYlJo5EImTrXB38913gls8bFLQdFWI5iIMU0RX9XZ1zovW4TTmDRDlVbrC8HLgW59Afs7Fy61ln1ypSGudd3U9m/FJaMBAY16iUmQCKXB0z7k2eStT70/JUihB3S82MkJizHbJNdKtMT1COeM+eD1nPkOvOs8w1mKU6Y1cHJ3T1LLgIzg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64437b76-e903-4154-a9a4-08dde0dffb22
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2025 18:24:35.3526
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H0LCQ/QTxqN2/69qpxU/AP9Q69Zlh9og4xgREV0hj70ReLFDE0vfoxJ/egOFAE6ssX9Cxw42cmiVcXP4/2I92g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6628
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-21_03,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 adultscore=0 mlxscore=0 bulkscore=0 spamscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2508210153
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE5MDE5NyBTYWx0ZWRfX7jecm4EpB9cN
 RB1OiWmAXRVmt04eaYwNduLhxPWRd7dvn7NsYSiFNI47IAihfBo+aUIGXjDhF1TzRDZJSuLtWpm
 iEXlXwafHctWnESmhHj0i4wu+cmhLUgyC7FOxU7PJFDzYOqRARoCd4ygTz892ONcK9gqFH4SKuM
 7y37ZxzsDQXdA91n4uSwmEsKOuJhqpJxBa0xrqQAHDvkI89xgAeAG54Ako7qyRpScIPHKmsQQQf
 ErvhiiF4R737tfYcM2I9gnnpUx4vzDpK+j5g27w4Rf4D3G2mq4exNkz5jqfShD4eW9BCzH/YWmQ
 zKPqkk4Gh2D51k2LP3fUV6DF1uAtBuvN3C6G3QoPOYi4M3A59x59SRnVFPO9r3g1xsVEHYpstIG
 aWGoSuVGDZVbhBwzZwD8Qm7NHgKiZQ==
X-Proofpoint-ORIG-GUID: M1dW5z-ZWynC7qFQ3_F9ZbuScfwwTYmW
X-Proofpoint-GUID: M1dW5z-ZWynC7qFQ3_F9ZbuScfwwTYmW
X-Authority-Analysis: v=2.4 cv=GoIbOk1C c=1 sm=1 tr=0 ts=68a76467 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=20KFwNOVAAAA:8
 a=mJjC6ScEAAAA:8 a=3sqryIrxuagLd3pdQi0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=ijnPKfduoCotzip5AuI1:22

On 8/21/25 2:20 PM, Olga Kornievskaia wrote:
> On Thu, Aug 21, 2025 at 11:09 AM Chuck Lever <chuck.lever@oracle.com> wrote:
>>
>> On 8/21/25 9:56 AM, Olga Kornievskaia wrote:
>>> On Wed, Aug 20, 2025 at 7:15 PM NeilBrown <neil@brown.name> wrote:
>>>>
>>>> On Thu, 14 Aug 2025, Olga Kornievskaia wrote:
>>>>> On Tue, Aug 12, 2025 at 8:05 PM NeilBrown <neil@brown.name> wrote:
>>>>>>
>>>>>> On Wed, 13 Aug 2025, Olga Kornievskaia wrote:
>>>>>>> When nfsd is in grace and receives an NLM LOCK request which turns
>>>>>>> out to have a conflicting delegation, return that the server is in
>>>>>>> grace.
>>>>>>>
>>>>>>> Reviewed-by: Jeff Layton <jlayton@redhat.com>
>>>>>>> Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
>>>>>>> ---
>>>>>>>  fs/lockd/svc4proc.c | 15 +++++++++++++--
>>>>>>>  1 file changed, 13 insertions(+), 2 deletions(-)
>>>>>>>
>>>>>>> diff --git a/fs/lockd/svc4proc.c b/fs/lockd/svc4proc.c
>>>>>>> index 109e5caae8c7..7ac4af5c9875 100644
>>>>>>> --- a/fs/lockd/svc4proc.c
>>>>>>> +++ b/fs/lockd/svc4proc.c
>>>>>>> @@ -141,8 +141,19 @@ __nlm4svc_proc_lock(struct svc_rqst *rqstp, struct nlm_res *resp)
>>>>>>>       resp->cookie = argp->cookie;
>>>>>>>
>>>>>>>       /* Obtain client and file */
>>>>>>> -     if ((resp->status = nlm4svc_retrieve_args(rqstp, argp, &host, &file)))
>>>>>>> -             return resp->status == nlm_drop_reply ? rpc_drop_reply :rpc_success;
>>>>>>> +     resp->status = nlm4svc_retrieve_args(rqstp, argp, &host, &file);
>>>>>>> +     switch (resp->status) {
>>>>>>> +     case 0:
>>>>>>> +             break;
>>>>>>> +     case nlm_drop_reply:
>>>>>>> +             if (locks_in_grace(SVC_NET(rqstp))) {
>>>>>>> +                     resp->status = nlm_lck_denied_grace_period;
>>>>>>
>>>>>> I think this is wrong.  If the lock request has the "reclaim" flag set,
>>>>>> then nlm_lck_denied_grace_period is not a meaningful error.
>>>>>> nlm4svc_retrieve_args() returns nlm_drop_reply when there is a delay
>>>>>> getting a response to an upcall to mountd.  For NLM the request really
>>>>>> must be dropped.
>>>>>
>>>>> Thank you for pointing out this case so we are suggesting to.
>>>>>
>>>>> if (locks_in_grace(SVC_NET(rqstp)) && !argp->reclaim)
>>>>>
>>>>> However, I've been looking and looking but I cannot figure out how
>>>>> nlm4svc_retrieve_args() would ever get nlm_drop_reply. You say it can
>>>>> happen during the upcall to mountd. So that happens within nfsd_open()
>>>>> call and a part of fh_verify().
>>>>> To return nlm_drop_reply, nlm_fopen() must have gotten nfserr_dropit
>>>>> from the nfsd_open().  I have searched and searched but I don't see
>>>>> anything that ever sets nfserr_dropit (NFSERR_DROPIT).
>>>>>
>>>>> I searched the logs and nfserr_dropit was an error that was EAGAIN
>>>>> translated into but then removed by the following patch.
>>>>
>>>> Oh.  I didn't know that.
>>>> We now use RQ_DROPME instead.
>>>> I guess we should remove NFSERR_DROPIT completely as it not used at all
>>>> any more.
>>>>
>>>> Though returning nfserr_jukebox to an v2 client isn't a good idea....
>>>
>>> I'll take your word for you.
>>>
>>>> So I guess my main complaint isn't valid, but I still don't like this
>>>> patch.  It seems an untidy place to put the locks_in_grace test.
>>>> Other callers of nlm4svc_retrieve_args() check locks_in_grace() before
>>>> making that call.  __nlm4svc_proc_lock probably should too.  Or is there
>>>> a reason that it is delayed until the middle of nlmsvc_lock()..
>>>
>>> I thought the same about why not adding the in_grace check and decided
>>> that it was probably because you dont want to deny a lock if there are
>>> no conflicts. If we add it, somebody might notice and will complain
>>> that they can't get their lock when there are no conflicts.
>>>
>>>> The patch is not needed and isn't clearly an improvement, so I would
>>>> rather it were dropped.
>>>
>>> I'm not against dropping this patch if the conclusion is that dropping
>>> the packet is no worse than returning in_grace error.
>>
>> I dropped both of these from nfsd-testing. If a fix is still needed,
>> let's start again with fresh patches.
> 
> Can you clarify when you said "both"?
> 
> What objections are there for the 1st patch in the series. It solves a
> problem and a fix is needed.

There are two reasons to drop the first patch.

1. Neil's "remove nfserr_dropit" patch doesn't apply unless both patches
are reverted.

2. As I said above, NFSv2 does not have a mechanism like NFS3ERR_JUKEBOX
to request that the client wait a bit and resend.

So, if 1/2 has been tested with NFSv2 and does not cause NFSD to leak
nfserr_jukebox to NFSv2 clients, then please rebase that one on the
current nfsd-testing branch and post it again.


> This one I agree is not needed but I
> thought was an improvement.
> 
>>
>>
>>>> Thanks,
>>>> NeilBrown
>>>>
>>>>
>>>>>
>>>>> commit 062304a815fe10068c478a4a3f28cf091c55cb82
>>>>> Author: J. Bruce Fields <bfields@fieldses.org>
>>>>> Date:   Sun Jan 2 22:05:33 2011 -0500
>>>>>
>>>>>     nfsd: stop translating EAGAIN to nfserr_dropit
>>>>>
>>>>> diff --git a/fs/nfsd/nfsproc.c b/fs/nfsd/nfsproc.c
>>>>> index dc9c2e3fd1b8..fd608a27a8d5 100644
>>>>> --- a/fs/nfsd/nfsproc.c
>>>>> +++ b/fs/nfsd/nfsproc.c
>>>>> @@ -735,7 +735,8 @@ nfserrno (int errno)
>>>>>                 { nfserr_stale, -ESTALE },
>>>>>                 { nfserr_jukebox, -ETIMEDOUT },
>>>>>                 { nfserr_jukebox, -ERESTARTSYS },
>>>>> -               { nfserr_dropit, -EAGAIN },
>>>>> +               { nfserr_jukebox, -EAGAIN },
>>>>> +               { nfserr_jukebox, -EWOULDBLOCK },
>>>>>                 { nfserr_jukebox, -ENOMEM },
>>>>>                 { nfserr_badname, -ESRCH },
>>>>>                 { nfserr_io, -ETXTBSY },
>>>>>
>>>>> so if fh_verify is failing whatever it is returning, it is not
>>>>> nfserr_dropit nor is it nfserr_jukebox which means nlm_fopen() would
>>>>> translate it to nlm_failed which with my patch would not trigger
>>>>> nlm_lck_denied_grace_period error but resp->status would be set to
>>>>> nlm_failed.
>>>>>
>>>>> So I circle back to I hope that convinces you that we don't need a
>>>>> check for the reclaim lock.
>>>>>
>>>>> I believe nlm_drop_reply is nfsd_open's jukebox error, one of which is
>>>>> delegation recall. it can be a memory failure. But I'm sure when
>>>>> EWOULDBLOCK occurs.
>>>>>
>>>>>> At the very least we need to guard against the reclaim flag being set in
>>>>>> the above test.  But I would much rather a more clear distinction were
>>>>>> made between "drop because of a conflicting delegation" and "drop
>>>>>> because of a delay getting upcall response".
>>>>>> Maybe a new "nlm_conflicting_delegtion" return from ->fopen which nlm4
>>>>>> (and ideally nlm2) handles appropriately.
>>>>>
>>>>>
>>>>>> NeilBrown
>>>>>>
>>>>>>
>>>>>>> +                     return rpc_success;
>>>>>>> +             }
>>>>>>> +             return nlm_drop_reply;
>>>>>>> +     default:
>>>>>>> +             return rpc_success;
>>>>>>> +     }
>>>>>>>
>>>>>>>       /* Now try to lock the file */
>>>>>>>       resp->status = nlmsvc_lock(rqstp, file, host, &argp->lock,
>>>>>>> --
>>>>>>> 2.47.1
>>>>>>>
>>>>>>>
>>>>>>
>>>>>>
>>>>>
>>>>
>>
>>
>> --
>> Chuck Lever
> 


-- 
Chuck Lever

