Return-Path: <linux-nfs+bounces-17581-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B91F8CFFDFA
	for <lists+linux-nfs@lfdr.de>; Wed, 07 Jan 2026 20:57:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ABCAC30D8FE8
	for <lists+linux-nfs@lfdr.de>; Wed,  7 Jan 2026 19:26:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3508C37515A;
	Wed,  7 Jan 2026 16:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Ii3wESpq";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Qt4Ey2sJ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89F5E359FAD
	for <linux-nfs@vger.kernel.org>; Wed,  7 Jan 2026 16:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767804808; cv=fail; b=okqYeErSInDWZar4+P3XQa+LcdxQ2Xy8HQQ/RBlz25fPZh84a90GK4N+L7nlkQ4D3fCA9t7zB+kghYcPkk005assISXkfnQv7CXmhluooD1OH/hrMbZI1lm53VFLJXyKZkw8HWKg7vmkhFhHjkCEQysyAjVpfT95veeCLH9YSwo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767804808; c=relaxed/simple;
	bh=f98ODqow+fQo9gwdNCuIpjdICkXxv6mxjlhtk7920OM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jfEQ/Q7N1BlM1kdRX7aqfP1WfTJ0uPbMEXhN9umFJhYz4es1HQWkRIt/X/O5MtgAjhJTt+0ncmALqORxJsRDehtqGpmF3eOJolC0B1nSeoAxQb9rNko5AKnsxFD/SaRhuvpr5p1NeAe5S+CGZTzbt2i26KkPs6+y5/o3XQB+45c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Ii3wESpq; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Qt4Ey2sJ; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 607CewDv1935353;
	Wed, 7 Jan 2026 16:53:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=AAnUQ0gpTkReIU7glgbCOt66vWVPq2PtlJAhJxG73WI=; b=
	Ii3wESpqOm7bTv11jcsWJjdPaC0vN0SWc8LUIDLTF/5yrGZFgfUzABaW+piYCqpS
	C8iN554Uruu7KCLuE5P3njOWETlGi7/tp3KY1A5MVAWGbcfw+23Ty+WmyxAaNTVX
	9Lwb3UBwxnpnytEzMGAMI5KlnxylnbdAriwvhB5acSgBYWdwfUIdUwa0S6y1oP0n
	olYEBEiuNvuEeHWY3FEKURYmQH45f1irkWwbZHxh2YSbYJ3RRyRbQEspjIGyC66E
	8vIvENyt03QQ/O4RlB8usHFalcpox+7Le19IKZy4iQKmpQMwjXqI/VA17GsEZtGo
	6RgkqQb491COT+Bp7bQAYA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4bhqpsrd6y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 07 Jan 2026 16:53:03 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 607FZI1g020928;
	Wed, 7 Jan 2026 16:53:02 GMT
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazon11013059.outbound.protection.outlook.com [40.107.201.59])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4besj9tkka-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 07 Jan 2026 16:53:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jzZUshGJR9DtL57brv7wgVJoe70inEFVZe4Mt8oxHmxNSVRJ4r1fFhynXxi6FoISkP8wMQwIPkfb0I1ZOyPRrPzXYCMjSxxv6ZX3EZlGetTDu7GVUtPg9Pkb54gBa2UNMjag3S0dq/sp5t3c0D7aMAIXW3cq6pOuWIp2+eXQ0cR9QmHeHc9sDTPXvvRX8xXzs92UbZVSLzG4Xjl6MMaBYEozas4yPPfdJT2ODIMzFM/7c822JkJkpbQCfYz9cm4VYXoNzDkXeTzNCf+5HdI9zqqIwNsgD2CVSIQgBzUdaTWibAY19eaSmIQeDhiGaqp3rlego17dRUWHErVbfW6bGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AAnUQ0gpTkReIU7glgbCOt66vWVPq2PtlJAhJxG73WI=;
 b=fqlUJnSjFwDF0bCuEku/9u9Ts17W8JPrRD2/U3O6Fqu8J+HoNh1zQMv+91Vzo1krxfhYEYQt+KzAL8xVLWbK/CCOTKkcLOQ/B6UUaiXF+KQtrgkdYDnQixkBA3fjcyCYPIFmDKoWlgTiBn0OZ3p0UwFgXhZ1dDnx5gpcxvAPdTSEDSF+XmAAcp4CbdkFm5t4p/ULBBS6UjIyWRmb+vg+FmJbR1NTC5iQOyjcKOu+PF1pqEk4GOLb1AiCmDlFTVk8xUxp3HkNGMGGBL2mh4g5dZIEIHDVzC7UmiISrLg6ZTmKbSjCNVDMvrAN+i7rI2Jab7nhlehwcJeb45bAZgGprw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AAnUQ0gpTkReIU7glgbCOt66vWVPq2PtlJAhJxG73WI=;
 b=Qt4Ey2sJK8w+25bUWogcOZ0pgfYtiP+MT6ZFNKiTl7f9A+T4gCeS67/2KmFtQKH0mz2Lw+eDxRGXzyAM7N6k8K/NBTx6/uw2Ru9PopFROQN/yhrJP9hHjLeOukPik9jKIUXKTe8/HGKQkPJ3qvg7gQP1aEkMkL92SvXHFPxpMgg=
Received: from DS7PR10MB4847.namprd10.prod.outlook.com (2603:10b6:5:3aa::5) by
 LV3PR10MB8010.namprd10.prod.outlook.com (2603:10b6:408:282::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9499.2; Wed, 7 Jan 2026 16:52:56 +0000
Received: from DS7PR10MB4847.namprd10.prod.outlook.com
 ([fe80::f8b0:7eee:d29e:35ed]) by DS7PR10MB4847.namprd10.prod.outlook.com
 ([fe80::f8b0:7eee:d29e:35ed%7]) with mapi id 15.20.9499.002; Wed, 7 Jan 2026
 16:52:56 +0000
Message-ID: <0bc24199-7e23-4419-bc70-17ad4bebd690@oracle.com>
Date: Wed, 7 Jan 2026 11:52:49 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] NFS: Fix directory delegation verifier checks
To: Trond Myklebust <trondmy@kernel.org>,
        "hch@infradead.ori" <hch@infradead.org>
Cc: "anna@kernel.org" <anna@kernel.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
References: <20251219201344.380279-1-anna@kernel.org>
 <aUnHnlnDtwMJGP3u@infradead.org> <aUnq_d93Wo9e-oUD@infradead.org>
 <53d40f4781783f9b79196bb30975b788be8bb969.camel@hammerspace.com>
 <aVyp3SIddHB5sMhp@infradead.org>
 <1df4bb7ff3e6fd607c1811d75fcd6dcb860e320e.camel@kernel.org>
 <aV3ttYmT2vAtPDws@infradead.org>
 <d8ddd23a18985ae360855931f185d0e24c466310.camel@kernel.org>
Content-Language: en-US
From: Anna Schumaker <anna.schumaker@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <d8ddd23a18985ae360855931f185d0e24c466310.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR03CA0299.namprd03.prod.outlook.com
 (2603:10b6:610:e6::34) To DS7PR10MB4847.namprd10.prod.outlook.com
 (2603:10b6:5:3aa::5)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB4847:EE_|LV3PR10MB8010:EE_
X-MS-Office365-Filtering-Correlation-Id: 9cee038f-fba8-441d-9913-08de4e0d3504
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NlczVGtwMGFTNnhHVEw4dkNCY01ZV3dDdEo0dDlPMGM1U2RoT1VadmtMeE1i?=
 =?utf-8?B?WVcrR1d5a1ZzYTNIaXJOTGlzQmkvUmVTbU5KTDBpUGJ6NGhJWWNFNFdhSThl?=
 =?utf-8?B?UjRUemVseHNmai9DUlV1MU5LcHBSWUEzeERhdy9IWU53MURNT0dyYkVVbWN3?=
 =?utf-8?B?eGlVTms3OWVLRHF3eFFDSkRDRjFXKzBVZEsrd2NtMDRjZFpvVDNpQVBoMlcy?=
 =?utf-8?B?WldLZktsVDB2dU4xbnM3cGxMY3kvZm5KdHNGOTRNM3Z6czZuZzJ0SG9DKzhZ?=
 =?utf-8?B?U1JKa2VuMUhhSGkvRW93UmRKbUhsakcxMmEzWXFRbDBHQWJRRHBPZW9kMU5Z?=
 =?utf-8?B?cTdNa3NOSmlmSm9FTVVVZDhPWFk2dGFzWXFkSWFOWHZUWDlJK2RRUTZEdEts?=
 =?utf-8?B?UFl5d2VBb0xQRVJKYUE4aEh1SzdoVHJFV3h6YU4wUXlsQ01XcEJzOVQ3Um1V?=
 =?utf-8?B?dTZDQ1F5Tm9pQWxvRmdRT2dKSDh3VHRBdFpoTGFpdFFUSjYrNU84TlY4ZlBJ?=
 =?utf-8?B?cHc4UThvTUkyejJ6eGVnQ0p3QjUzbEMza0QrTjJ5M0x5Um55UU55ZHVlNzFj?=
 =?utf-8?B?RjZMWU5RRU5DS1JYRG1TVkViZ285NDBBMlA2UTJkRjZmVC9qSWp3aFZodjAv?=
 =?utf-8?B?WlB5K1hGNXRZMVRYRkZwamI3dXlQMWIxdzc2dEk5eFliZ094ZWk4WHR3cVpq?=
 =?utf-8?B?ckdFRmZCMUZjVk1zUTFjMTdoWW84Z2pkZi9ocXNDYWliWnYzVGgrYTFGbUtr?=
 =?utf-8?B?WUhVUC9ZQUZDODk2aEI3cmRYY2VNamNkcGRIZDZZTTY5MGNqVk56OUFvL3RL?=
 =?utf-8?B?cVBLMTVvODhsV3UxMHZJMU5IUExwZ3ZJSlgzSzVQQjJDc1FNMG82Qmk1aU9L?=
 =?utf-8?B?WS9kNjBmdnZCNHp4MGcwdWxTQVRRT0p0L3hKSHB3QUFBZUpLL3BhVnIxc0Rp?=
 =?utf-8?B?eVoxbDl1S281Y3pwN2krWFYwZi9nYk5jRjdTbGtNTFYwWFZlNHNwZUROd2Ji?=
 =?utf-8?B?d0FReDVHaU9vSUxFSWZxK1cvL2NSMW5KcDlSSUJXekhnaWV6Qi9MZ0xPaXJV?=
 =?utf-8?B?NDNSQjRObDI5WC95cFVCV3FuZVBzTjNBNS9rOHMxaUlDOVNtNTFEN3dScVNx?=
 =?utf-8?B?OVRNTjRhMU1vT3ppSEJlK2phNHd4aFAwMktUODZQRi9tZS84QUNKaG8wcTBK?=
 =?utf-8?B?WlZtcTk5aGFGbmIxNHAyQ2IyVUp0SUtobm5IYWYyTlZjNWJNeEVjM2NmWmtX?=
 =?utf-8?B?QjRRdkFscXJ0OUVXT0NLb1daai9FU0Nna0VIK2VEaG9XNnNqc2hDdXJLejky?=
 =?utf-8?B?N05lWnlKQ0ozNmt4VVlGQVRFeWNtbzdab05XZlpVWVNxK1p4ZXNsdXp5RHpE?=
 =?utf-8?B?emw3R2NZVDA2ZGo1NWFSZFFrTkl5NTZFQjNqV2JBRWlMZ01aQzVVOGM1cnBG?=
 =?utf-8?B?TVBEeG1hM05TUjBza1pnT1NkTzFiRFJub1VnSTdHK0dGdExGZExUQXMvZ2tP?=
 =?utf-8?B?YS81Skg4MDVudFVEUFhzcWxRWFRIdk5WQTFVeHZ1UzJqNVhTczJGMUx6eFlv?=
 =?utf-8?B?ZGtsYW1OeEtsdndPTU85dzJsRUs5QmIwVkhnQlRrblUxRW5Sby9lM0lpUTY5?=
 =?utf-8?B?T1dLWFVqVldyNVVYQnZpcURhYlZaaWNZeE4zTytMbGRmUzU0QTg2VU81SjNw?=
 =?utf-8?B?cjlacjVzUTd1VGxHa3R5c1ZtbjIvUXdoK1BZZEFXMUxoQmJQOFFXOGZLMStj?=
 =?utf-8?B?VHFxMXFHb3RNS0NjRWRRYVhPdjl4QnNlZ21jYmM3SlloMXZUbFcyVWZYTnF4?=
 =?utf-8?B?dlBVUm1Uc2hOTkorV0MvODRuZUo0TTZyTHNVNkh1MHNGNjlwalBsWS9wbEJ0?=
 =?utf-8?B?SHRweEdINDVlQWF1ZmJVN1N1TExCUlc2cGQvR2gxblpsdzM0TWxCbEl4M01U?=
 =?utf-8?Q?xWJXswlRS488cjXyqX+TxPjowzboXb/d?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB4847.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NzVlbkFnenkrT0tseVlETkxxdUJENnE3S0lwM0VkeDBxMENXY3d5QnFJTkdz?=
 =?utf-8?B?cWF4MjZiYzAyUnppWk02bWFXaTk2SFhtc011cFA1cnZBSWl2NlhMSzQvQ01p?=
 =?utf-8?B?Q2duTTRDdjM1d01TNkdXT3JFb29QSlhKNnhqYXRVN2N6MHBXSmp4RXdscm5D?=
 =?utf-8?B?YWlGU2s1SytrUk96ZTY3VklVUG9zUlMyd1dGNnBHOXF0WThza005MS9KdUV1?=
 =?utf-8?B?VnZ1eXNrb0RDUjRrdjJCL1dHQWl1NFhNNVNoKzVsUlZwNG5sSmpKL2NjVTRV?=
 =?utf-8?B?dHNJR3pWT3dIbFRGbFFsSUVGV28wNno3ekl5SUdlTS9GcVJCRWpwT0FJcm9x?=
 =?utf-8?B?OUlzWkhFR2VNTktlb013elBWdkk0VC8zYUk3Y1c3aGYzMTRlclZxQXlwNkN6?=
 =?utf-8?B?RDFRVU1OeS9XTmJjUzJHVVIrdzZvWmVPQ3FpbFBleGlXK0FteDl6Tk1zblQv?=
 =?utf-8?B?c1F0NlhmKzhKb1FvNVBRQy9XeW1Rb1pGWXYyUERObXdncElDNVhNT1F0bnNp?=
 =?utf-8?B?dUJjN3F1eFhpVW9zZEltcUdkZjRoWU5sNXRqNHAyVENwKzdUaGhWRmozaGdO?=
 =?utf-8?B?L2NRaVEwY0p0WDhaZlR0WkdMUSsvVENyWTlWWEZnSy9hNTlVS21qc1l2bWJQ?=
 =?utf-8?B?b253Z0hDcm9VYWxPZm5tQms3ZjVRR1ZOQXNIL0tsRTFOeDlxcDkrVjRuQWp0?=
 =?utf-8?B?b0xxUThkakNOc2d2SE5DK3BoR3NXbmlEelE1OFBSUVYwSXA4R2NQRmxVeVdp?=
 =?utf-8?B?SlVrTjIzOHVKOXJPOC9SRmVCT2taVVBqSi9RQkgvOUE1cnZVemROYVNRL3Va?=
 =?utf-8?B?b3NxbjRvQUhmUDBxNFZwQUVITENza0V2T3U1YmNEWWVPQlduRlNrRUJWc01P?=
 =?utf-8?B?bEhabzNyVXNicmtlc0pUL0lsd2JMTng2M0wrejlwcVFPR1JoRkVFYzNtS3h3?=
 =?utf-8?B?M0NHRy9JcGx5SWRjVWJvemVnK1dNV0IrbGxsWTJweG9JeXo3SWIyNjVMMXcr?=
 =?utf-8?B?VVdjWEowT0VrNS9SK2kzbEw3U00zNTRNU3I2QnBPdmd5QVlvZG9qUFFnazhu?=
 =?utf-8?B?Q2RpakZZbzRsWi9SYjFRV1l1TXh0Y0FJdldyQTdlRWFHSlo1Q0pTdXQrVnVr?=
 =?utf-8?B?YlNyaUpjLzU4MDVGcTZpSnBGdFNGYzdpckdiVkpRU1dNT0h0L205UUxkL1E4?=
 =?utf-8?B?aDkwdzRPYTJJU0FmeUsxcDIvWi8yeHVVMmhTODBGT2JkcUlWbGxKVXhXNS8y?=
 =?utf-8?B?UHowaWlWQlo5eDNEN2pJRlM4QlRiMklpbWw4RHBHdmx0YUdGdlFSdGJiMklU?=
 =?utf-8?B?RkpyRVRBVHNiNDJRb3dMSUk2cFVhZXVRbjNWWFlPUmUxclA5QVgyQXd1cWti?=
 =?utf-8?B?TzFJdEFUajRFK3UxNGNUWm9XMVVzZlVFSXZmVmJZbVUyQ0Y2RWVlekdjQzZa?=
 =?utf-8?B?dXJwQWNDTERTcFZFdmdPQzVqS0pEeHVBWG9seWRWTU0wU1ZMams5RmtwL0dv?=
 =?utf-8?B?dHFZQnJEVEIvVWVoZ2NIaEd4OWFHN1ZERmlBSDhGemswOGJjUTArSUo1Rjk0?=
 =?utf-8?B?ZGZOenI1dVNMYTEyYURkTUlWamtSYzYxZU9aNTI3M0N4Q2UvYlhvcWtCRndL?=
 =?utf-8?B?M1V3b2I4MWlZVWZIUzg3SGtseEp3QmRmV0xpbWdVcU5VQWxqbU1qdXQ2Sjc2?=
 =?utf-8?B?Z0swSEFRbmtheGU2K25ycGFRM1dkeHhmNUlyUzZnd2RTbE5IaC9nSmNodW1j?=
 =?utf-8?B?MHAwR1kvcnJzRlo1Mzl2NTR3OEdITXpMc3dLd1dJY3plUWdaTHBvVFhaOEhi?=
 =?utf-8?B?aWVhSm9Bc24ycWNJL00xdmVZR044S3YxSExqcWQwc0k3MVZIRFVpYUNqZ1RV?=
 =?utf-8?B?dWd2Skp0NDY0Y01JTUZhb0s3MWErQkJJWTR4RnkrTEFtdUVOZkJKVUJLZWdv?=
 =?utf-8?B?UE0wa1BaQnhpUHdOS3YwenU4djQ1Y0ZBdTdrQnQyOVdPUEQ3OTlRdEFEUDFK?=
 =?utf-8?B?UFBZV2JzWWkxZGt6bGxxQnErY204QVlyclBpcnc1TjA2R0grRnpHZGpXWDI5?=
 =?utf-8?B?eG9hK1U4eVNkUnlhazdDTXBNQVJCaFJTRFBLSlEvcysyRyt6TjhKeDIrVGtT?=
 =?utf-8?B?NVdUSVVHcWZQLyswNXRsaVk3UHlvTXZ2Q1ZVT0VZeEVMNDdoZkR2Vy9HbE1z?=
 =?utf-8?B?bjdnL3cyVzIzZkcwdnIzZUVUd0JTZG1ndkJUdk1zNkx4OHg0U281OGhGZ1JM?=
 =?utf-8?B?U1gxcEhIejhWdWhyMmlrZ2diQ29vOW9xNExFRUd0S0F6MGFLeUg1MmhwNWw4?=
 =?utf-8?B?QURYUjc2K1JDcThRcjFtM3c0REgwY0VQbmdVRy9qVytVa0JCMmxHdEFocDVX?=
 =?utf-8?Q?2SkCMyXEmjHSGrcw=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	WPSFCdYG5wXOTLx6vo/uDj+E/ewFGrH7uqrpX1Jq6dviyZxg+LKdLDceUn6LKtbYiZ4EgGzAp9/2BncgTLhkm90fPIJ/B4DtqJCLZZXECTTBdZFm25iFUxX6n9UC39WMZeK/gsqvF0A0+wMyzDB7htRVWUDSkNolhgfh1s5LWj5xX2JPNxWLHku+bqE+JNJ6mI4EuBefImeKt20+kBZnRUEDHD+TLO6srZXoGiOQ6v21ctPT0dXZyxUlulVlrG9OF1dLvuGFHtcHUPJPSzCkwXVm9Zx+BGnVo7oLlhGRzehBEmOWjypakZ8qBVA7cJl3UdoMFhV+whLJIQuxD0k9yJ40lT5yvfPyVuOkT4qNhO4OW/mKcGPHtqIPUMU8WHc6uQec3yEbrlXGNNlUeq4nLKr8z8XL5qV8kVFxazX7qty7W31XDNBs/CmJwTqr4klX+0RIceYEMnsPKk84tz5unm79CPxjT7WeMwOhS3WaS9BjCpLkf7m6Xh5SGwk8QdnMux7OLFVPf5p0kq9wi2dmMNVUsxmgykYWEF7IRDOVUPeClwQZkxOcnaGB8Dwnu5jpdS5wy6A5hPDwFT1AfYHR4u/+BIwVVfUbvo87zhYZMSA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cee038f-fba8-441d-9913-08de4e0d3504
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB4847.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2026 16:52:56.6949
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Oh4/CCe9UNJsD6PsSdpSowGG2DHouqU9fi7rWLtv8vYcSQp4XGaENYPhorOhKhCdoehK/95+Qu9LsDYI7k9oWIkdCCJFADbIJ0eNsKqw4l8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB8010
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-07_02,2026-01-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 spamscore=0
 mlxlogscore=999 phishscore=0 malwarescore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2512120000
 definitions=main-2601070132
X-Proofpoint-ORIG-GUID: ruRCOKIyQESewb-RUa6eMjIA1H73V38o
X-Proofpoint-GUID: ruRCOKIyQESewb-RUa6eMjIA1H73V38o
X-Authority-Analysis: v=2.4 cv=bp1BxUai c=1 sm=1 tr=0 ts=695e8f6f cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=SEtKQCMJAAAA:8 a=aLNBUNfdTVPEvjX8TRoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=kyTSok1ft720jgMXX5-3:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA3MDEzMiBTYWx0ZWRfX71iYh62nGC4V
 bAKO0rWPSiNmerM2DZIdkBuDbJuxen88YVVedNM37kZ2n65CKMTP6jvw6ZhlZ/jcwh8KJubYiap
 KuOKK1e+NKc2Rl16z4QNCI7K3RK1+stUnlzvnrwNqE+R/IPC6hTIon9/1fxY3bSHyX9kb4+Fkno
 kLMnLPafcW+cscTc2pF2Hz5vBYXpVsyGyFV5L1HOrqQsR8sWu0qzp6xLGz/MNkppuC7ivyJDo0t
 px6rbPDQ/BVS4ZckGGKSyGmXMHO4wL1Exrom9wlz3db8sCUWMRMG30ixstBRUbXDL1fFTfqBkrb
 mR2Cg7bqKkT/C1WfCz24wgICObykTOeX/ZqYyr1MXIT6kuEQuqNHZgVKzTOAolXP0HM2AtnN8su
 EIJOI35a8H0g4P0niNOD38cP+tm/dtz0Z8zd75jGRnasdB/BJfvIQ6DRL1QWFUb7u0XqilOLnt6
 ivxsSNvx3YtQSNh0dIw==

Hi Trond,

On 1/7/26 10:07 AM, Trond Myklebust wrote:
> On Tue, 2026-01-06 at 21:23 -0800, hch@infradead.ori wrote:
>> On Tue, Jan 06, 2026 at 01:32:54PM -0500, Trond Myklebust wrote:
>>> Sigh... One last patch on top of all the previous ones, but if we
>>> hit
>>> another issue I think we need to consider just disabling directory
>>> delegations on the client until all the remaining issues can be
>>> fixed
>>> in the next release.
>>
>> This still crasheѕ generic/633:
>>
>> generic/633  4s ... [   73.075526] run fstests generic/633 at 2026-
>> 01-07 05:21:37
>> [   73.286318] process 'vfstest' launched '/dev/fd/4/file1' with NULL
>> argv: empty string added
>> [   73.314625] Oops: general protection fault, probably for non-
>> canonical address 0xcccccccccccccd50: 0000 [#1] SMP NOPTI
>> [   73.315391] CPU: 1 UID: 0 PID: 100 Comm: kworker/u8:3 Tainted:
>> G                 N  6.19.0-rc4+ #4540 PREEMPT(full) 
>> [   73.316043] Tainted: [N]=TEST
>> [   73.316229] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
>> BIOS 1.16.3-debian-1.16.3-2 04/01/2014
>> [   73.316786] Workqueue: rpciod rpc_async_schedule
>> [   73.317066] RIP: 0010:nfs_inode_find_state_and_recover+0x9c/0x260
>> [   73.317430] Code: 01 0f 85 83 00 00 00 49 8b 84 24 80 00 00 00 4c
>> 8d 60 80 48 39 c3 0f 84 68 01 00 00 4d 8b 7c 24 60 4d 85 ff 74 e1 48
>> 8b 7d 00 <49> 39 bf 84 00 00 00 75 af 8b 4d 08 41 39 8f 8c 00 00 00
>> 75 a3 48
>> [   73.318513] RSP: 0018:ffffc900001bfd00 EFLAGS: 00010286
>> [   73.318868] RAX: ffff88810cfb98e0 RBX: ffff8881d68d8c50 RCX:
>> 0000000000000000
>> [   73.319354] RDX: ffff88810330a0c0 RSI: ffff88811a86d914 RDI:
>> b6162427695ded30
>> [   73.319832] RBP: ffff88811a86d918 R08: ffff88810c685100 R09:
>> ffff88810c685130
>> [   73.320270] R10: 0000000000000003 R11: fefefefefefefeff R12:
>> ffff88810cfb9860
>> [   73.320698] R13: ffff8881179b2800 R14: 0000000000000000 R15:
>> cccccccccccccccc
>> [   73.321135] FS:  0000000000000000(0000) GS:ffff8882b363d000(0000)
>> knlGS:0000000000000000
>> [   73.321640] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> [   73.321994] CR2: 0000559277cef238 CR3: 0000000161792002 CR4:
>> 0000000000772ef0
>> [   73.322422] PKRU: 55555554
>> [   73.322592] Call Trace:
>> [   73.322749]  <TASK>
>> [   73.322889]  nfs4_delegreturn_done+0x1b7/0x380
>> [   73.323173]  ? __pfx_rpc_exit_task+0x10/0x10
>> [   73.323475]  rpc_exit_task+0x5c/0x170
>> [   73.323755]  __rpc_execute+0xb1/0x490
>> [   73.324000]  rpc_async_schedule+0x2a/0x40
>> [   73.324257]  process_one_work+0x16c/0x330
>> [   73.324515]  worker_thread+0x254/0x3a0
>> [   73.324762]  ? __pfx_worker_thread+0x10/0x10
>> [   73.325042]  kthread+0x117/0x230
>> [   73.325303]  ? __pfx_kthread+0x10/0x10
>> [   73.325557]  ? __pfx_kthread+0x10/0x10
>> [   73.325812]  ret_from_fork+0x1b6/0x200
>> [   73.326045]  ? __pfx_kthread+0x10/0x10
>> [   73.326278]  ret_from_fork_asm+0x1a/0x30
>> [   73.326535]  </TASK>
>> [   73.326681] Modules linked in: kvm_intel kvm irqbypass
>> [   73.327046] ---[ end trace 0000000000000000 ]---
> 
> Thanks for doing all this testing, Christoph. I really appreciate it.
> The previous patch was incomplete. This is incremental to yesterday's
> patch, but I'll squash them together in the testing branch, since
> they're both about blocking state recovery in the non-regular file
> case.
> 
> 8<-----------------------------------------------------------------
> From 534676d290af6fae6ad1b067b81c13523340bc83 Mon Sep 17 00:00:00 2001
> Message-ID: <534676d290af6fae6ad1b067b81c13523340bc83.1767798220.git.trond.myklebust@hammerspace.com>
> From: Trond Myklebust <trond.myklebust@hammerspace.com>
> Date: Wed, 7 Jan 2026 10:01:58 -0500
> Subject: [PATCH] NFSv4.x: Directory delegations don't require any state
>  recovery (part 2)
> 
> This patch will be squashed with part 1.

I finally hit Christoph's crasher this morning, and this patch did
help when running with NFS v4.1 but I still see the problem with v4.2.
I haven't dug into it enough to know if it's just harder to hit now,
though.

Do you want me to take back over debugging this from here?
Anna

> 
> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> ---
>  fs/nfs/nfs4state.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/nfs/nfs4state.c b/fs/nfs/nfs4state.c
> index 01179f7de322..dba51c622cf3 100644
> --- a/fs/nfs/nfs4state.c
> +++ b/fs/nfs/nfs4state.c
> @@ -1445,6 +1445,8 @@ void nfs_inode_find_state_and_recover(struct inode *inode,
>  	struct nfs4_state *state;
>  	bool found = false;
>  
> +	if (!S_ISREG(inode->i_mode))
> +		goto out;
>  	rcu_read_lock();
>  	list_for_each_entry_rcu(ctx, &nfsi->open_files, list) {
>  		state = ctx->state;
> @@ -1466,7 +1468,7 @@ void nfs_inode_find_state_and_recover(struct inode *inode,
>  			found = true;
>  	}
>  	rcu_read_unlock();
> -
> +out:
>  	nfs_inode_find_delegation_state_and_recover(inode, stateid);
>  	if (found)
>  		nfs4_schedule_state_manager(clp);
> @@ -1478,6 +1480,8 @@ static void nfs4_state_mark_open_context_bad(struct nfs4_state *state, int err)
>  	struct nfs_inode *nfsi = NFS_I(inode);
>  	struct nfs_open_context *ctx;
>  
> +	if (!S_ISREG(inode->i_mode))
> +		return;
>  	rcu_read_lock();
>  	list_for_each_entry_rcu(ctx, &nfsi->open_files, list) {
>  		if (ctx->state != state)


