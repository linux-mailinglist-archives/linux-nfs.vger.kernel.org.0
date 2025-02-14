Return-Path: <linux-nfs+bounces-10120-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2356CA36047
	for <lists+linux-nfs@lfdr.de>; Fri, 14 Feb 2025 15:24:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 856FB3AEB6E
	for <lists+linux-nfs@lfdr.de>; Fri, 14 Feb 2025 14:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 477F2264FB9;
	Fri, 14 Feb 2025 14:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="loWPQAjK";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="l3XA8xE4"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA3B5BAF0
	for <linux-nfs@vger.kernel.org>; Fri, 14 Feb 2025 14:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739543043; cv=fail; b=k3f/e6LB+lsHTeKYz2dgJNii5WZJKtEGbO7o6kYxCfIdeOM6zaairDc/Ljy0Lc+UjIuUK9AifG1yVIvFjcZfdP7XYvxaagfEICuEqiqbyefFv6DSVojosjZIfr1+AkOOJmugJRVew9s3ikmTLJAPe7FLLq1Ofw9A/GOihhWuf+0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739543043; c=relaxed/simple;
	bh=5VEv/xhTCy/MvmEFQhGKTyN9S6QZqUQV2x+m/kw6pa0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Qjip6LdTjnmXPYqLL3+XjPzaPhF1F6YLr2ZmlXlGipFUku8v2LQ1K37yHr8LYv2j+NXqETgCyWAFWAeK7l5f+ur4fGYPAgs8DM7dRM2PwdhFlnXBIlIjIA8o49n0XikUu5PkOxjySKq+4MekjIXYfrtp3x2FcpinUa6s+IAFzms=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=loWPQAjK; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=l3XA8xE4; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51ECtqbU022708;
	Fri, 14 Feb 2025 14:23:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=sNiY/uEl8j2M9Q8lIMSeiTH8f2XSG5kkwRxTzK2ovnA=; b=
	loWPQAjK43FFjBT1DYT3mMr068ps5fucEMgKV/hF00Vx9psxmpZYtAOSyyEtndQU
	cSKIBlFVeEDZNRUm2eAPKpCXvszNQt2MujpgkATLtkTTN96zmyVldu55cN0t/KBH
	YG5J+seGSyehTxy6SdPqgwLmhxQHFDAcub1lf80keRr0L5xtaVzkalnsNqibFcTD
	WQvBw22OOejZ500od7Za7OhzU6+VoZKeLpDS/PPeF7jbJj2J46BEK5KOWyoSEZl+
	SrpQJrJMV6u/l1G0ChkgfA9mGxAQKbu4ntXdDjYhK2hie35PHNt5SAk1V16AiQZ5
	JeJx8GVkutf6RUC8Yx52Nw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44p0s43qpn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Feb 2025 14:23:58 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51EEJ19m001211;
	Fri, 14 Feb 2025 14:23:58 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2046.outbound.protection.outlook.com [104.47.74.46])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44p633n5j5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Feb 2025 14:23:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AYs28JfeYWsQbg0hu0iMdnJrKu0dfWVnZTTAzNjmi0jheRdXvQbJuvDImTPJYbHTpENEU9xKkQ5H1ugmDLZGNARESZp4GYMCNkFtxT9OJraoqtfXrVyhyvkBTNIn1eDozoc4J2bR+rLNyXOLKshSiobrf9qQots5CRoR5D9+txipqFeHlfVHw4rHUQqYAcIdoRVTyQGoZFasO+acGUvQGXxU+fqE5cMATiLQLencJJiEKD9CMyGHmjulyl3jJZYYDmgspQdZNEYTDwUCQVXN9YQPSIktLoahSGpvtfDJF1Qs81/kppROQAt7BOmfYQGcFulfpWemDcnoivIMnBcDhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sNiY/uEl8j2M9Q8lIMSeiTH8f2XSG5kkwRxTzK2ovnA=;
 b=gyrlGv4DtbPFYoKs8Zlp013/wF41LUaT4n2XiH5tb/gQuFsVScoxnz5FTXoCYGF2VmSqZZvR8OvNhuwVBa8ubeHCxWZTBJy7QDM2+3wE1itEpD8QEW+lxZWjRrhJPY6MQg9EjIsGK05mIXmaq92dV/cd18Dq30UU1gGoT8EUHhfmAIsJx+Ojvgij6JmitMTKQZtaHCiDAc8b7AUUv27pzEqUUfIVzJxVgT65nyD3xoUshXkgYrF3iLXrG1+oQ/roilj2ws60idpjlYXmm2p/E/QenxfhGCo70Z8B+qgFGqTWVKEybk+YRMgv+d8dsSEWHymPL0iMMuk2vCWjefx3yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sNiY/uEl8j2M9Q8lIMSeiTH8f2XSG5kkwRxTzK2ovnA=;
 b=l3XA8xE473R4WwYHSSTW4k1SnXD0gOf2zsCMDC9/PgvEIIEko9s/0l2xsDoLcLuho0dcidpBmLIIaa8GPhvhJKu+zsDxYMU9r+2wl2wxBOWWbFg+FqArTF/FCtECXkOOaqyKvu5excWvGm64lT+7f39Lw4cmQ/gow4o88iw6cq4=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SA2PR10MB4716.namprd10.prod.outlook.com (2603:10b6:806:11b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.11; Fri, 14 Feb
 2025 14:23:54 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.8445.016; Fri, 14 Feb 2025
 14:23:54 +0000
Message-ID: <3966bb3b-50da-41e6-b097-704c56154f21@oracle.com>
Date: Fri, 14 Feb 2025 09:23:52 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] nfs-utils: nfsdctl: dont ignore rdma listener return
To: Olga Kornievskaia <okorniev@redhat.com>
Cc: steved@redhat.com, linux-nfs@vger.kernel.org
References: <20250213154722.37499-1-okorniev@redhat.com>
 <c65ebd14-f7e1-45a8-9bc2-211440977ab0@oracle.com>
 <CACSpFtDjqhgmFO=pTY1ErZEhQZNgewo9ao+RuuGY3hm9CSqcqA@mail.gmail.com>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <CACSpFtDjqhgmFO=pTY1ErZEhQZNgewo9ao+RuuGY3hm9CSqcqA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR03CA0019.namprd03.prod.outlook.com
 (2603:10b6:610:59::29) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SA2PR10MB4716:EE_
X-MS-Office365-Filtering-Correlation-Id: 78edfe39-6282-466a-748f-08dd4d033613
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VmtJdW8yNVJwb3czS0ovRXRyb2hDVjFYMi8rNWNSb0VyVDBUSDVkL2R2aHND?=
 =?utf-8?B?SVR6Vkt0TW00OStCaFRIbHFCNTRnRlhMSHJScVdUaEJTYnVXNkFpSnRQeHFa?=
 =?utf-8?B?blRHUkxWVmEvL1p5UDgwWHNURHNVVHdEeHQ4N1puUjFMSmZqSkRyVDkwWXpT?=
 =?utf-8?B?Y2phNjhiRmt0cWZJNmNYdy9JbC83K251RC82eVF1K2JtQldmeDR4aFNWUGw2?=
 =?utf-8?B?Wk53bllUTUp3VEd0WW0yRlFvaTgwVnJsdmwwSWR5QWhuMmd0ZHpVRUlPNkVy?=
 =?utf-8?B?RWdiMkZUSjNsSEJ2NUlqTWhnSGNxWldUSWdsVkNSVGkxbWJ3dXpNb28zTmtV?=
 =?utf-8?B?T0QyMitEeTZvNnBsaU1pRHhiN2FJNjhjSTJwcmRQb1pCSVIvUDk0Q1BaVUZN?=
 =?utf-8?B?MGtWcUxoZHR1OGpwUFNKYm9nZDRleXJLbmVNYVorZ1ZCNkVIRnNQd2dBL1pH?=
 =?utf-8?B?aVFIbnMySDgwN3llVXcyNHpXZmdBK0IwSVUydEQ0eldFR0hDa0RMbTFTOEVt?=
 =?utf-8?B?V1BXZUNSSFIyOHZUQjRSQnhHUVExbGowWGRWOEFTOWhaV3hBaUtKYWJhZUx5?=
 =?utf-8?B?VEpzSy9ZYzNWTysrL2QyV1JnenBPdzJaQVNkVnA4NE1zc1hFQnZPdSt2Uy9s?=
 =?utf-8?B?bFJwTnBEZUZpQ01qRXIrNi8wcHY4RnNzODhaVEhmZi9XZ05CZUVLaGU4cDBj?=
 =?utf-8?B?YmpPTE54aVR3OFJ6UGhiT25nZTg0eS9rQ0F1VTl1ZVlhQWR0cm55WThMV25z?=
 =?utf-8?B?NFBiRUIxTlU0NXpuNU16TmZremVYQmpzK1FneW9menRYd0NSaDM2RloxbkxZ?=
 =?utf-8?B?WStoRXVTLzlHK3p6L1p6OCt1T2NTS0Vjb1BNRktmVFVoVzQrOWlCOU4xZVh1?=
 =?utf-8?B?LzhFQVdQYXQ5dEtNMWVNREJ5eWpMZ3JLTy9lbzBGd0lkZERyNWc5b0t0UFhB?=
 =?utf-8?B?Y1Vodzk0bXMxb2RHZkJwMW5IbVpLbmc3UGRIMHJBb05JcXF6aE4vRTVvUndy?=
 =?utf-8?B?OTk5a3JJUnBjZUFBVkw3SE12bzlyN3hFdFIvclBwSUpsQU9TL2RDV29IRFdO?=
 =?utf-8?B?U3FQVkJXa1dSTHNncHFxSGdaeVVGSXJtcVZENS9FN2VMR1VGMU96b05kVmwr?=
 =?utf-8?B?bFREWE4zVUhDZG5rWmpuMTRqSlhRSzZwaUhPcTY2bzVHWkgzV1JuZ3dDOFNF?=
 =?utf-8?B?OHBTb0ZDdjFRNGR6YjU3UXNDellNa0Y4emhEL1JUeDM0ZlRPS2JjUUwwZFhj?=
 =?utf-8?B?b1JWZW16QTUyS3lvV0RvZ3paTmlzUTM1Z1NVUDJZRlYwOHZOTTc3dm9VSUJs?=
 =?utf-8?B?NE5pWEh0Q3Q5S0Z6dUZYTGR3SEFQL0lvQ1VNVjExQWk2TUNJbXFwWUZraDZo?=
 =?utf-8?B?Nzd3ZHNmTW50ZzA2cno2Q1VSYWo0VlZrR2pmaVMyV2dYU3dsdXpYeXdLa1F3?=
 =?utf-8?B?cURQZmkwTlJKRDJqZHBuOThmMDY2eE5aKzlMVi9NcXZyUVd5OE9POXdUbEtC?=
 =?utf-8?B?ZDFmQ3E2RzhYVWdibVVrZUJzbWd0WjhVRVVkaUo3eUluVVV1RStJMUpzVUpi?=
 =?utf-8?B?VUNscXVzaDlJUE9aeURLa1c0NUgrYTlEQ2Z1U3JZWjBTRjYxWTRJWFdobmcy?=
 =?utf-8?B?OXNqb1FtYnhPNXhvVUtWRWFiTXVPMzVPTnBVUW1ZbGpubW9lNlpneTlUMG5H?=
 =?utf-8?B?VlRVc2w4TWVZUFBDck5rbWFrMlNVMkJjTUtqcGlxRGk3MjVNUnFrdUhzSzhu?=
 =?utf-8?B?V2oydXJjODNUZlA2eUFId3B3bXFJd05TaStsdDBlSWErdlBPRy94OE5taXkx?=
 =?utf-8?B?UzF5bnhzaXpnR2hkS0JyUVhXRm4zMXVoSlpCVW5nU2VObXZKR21QT3c0SjRN?=
 =?utf-8?Q?QTFFqStuoniz1?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R3VUbGxpQit1YUJybkFuUDRCNU0wK01NS1o5WkRpUDA0TWttOEcyV1pyMGZN?=
 =?utf-8?B?ZHB2TTl0VXV5RHZxT3hyVDNuNjhpYTdic0oxTmVqQ3RiSnBWMm43VXo3RGVO?=
 =?utf-8?B?R0JtbnZSRmd0VU1jQkpTUXhqSTlJRXhDdkR4QlRrRk03UFYrMFFXUTYxSFdQ?=
 =?utf-8?B?MjBWbm1oSVg4SVBXRFlsak5DdytBVFN6Y25PRGpTaks4MThiRk5VbFo4MnFS?=
 =?utf-8?B?VHFXMGRQbzdNSWZrdVNpdGIvalZjRU9KMXJOWFdKTG50YVFVRVJ1RXpmSGQv?=
 =?utf-8?B?YUdaWUY0UVlOa2NzR25PWDNuY3dVeUtlbmNIYnI0d0k0SWpUM0RySnJaaU05?=
 =?utf-8?B?MEFlUkhyRFlWa0ZpQXhkbFJMa2MwVW03V29PbUtIMk43T29OOEQ4OGxXeURU?=
 =?utf-8?B?YTI5Sm5xNFZ3MEtZNXhBLzNhZ3luTVRqUkxxSVVCQzVMT3NUN3llRkpxdG5G?=
 =?utf-8?B?RVk2WG1mWEJFN0NjL0xEbER6UTRGcWtRN3NYczZLc3VwejMyVU1EbW5JSGF1?=
 =?utf-8?B?SklQc0hzZ3pEUG5CWVkzcG1iZXkxbU10Qm5laTVxZk9Nb3d1YVlacFF3QkpO?=
 =?utf-8?B?L2NTODdDdlZLblB6Y3JjWnM0UEhPa0xpMDBNQ2JNRUpORHpxeEp1Vms2aHRm?=
 =?utf-8?B?aW93cEVQN0pma2NpNnl4bDNNSk9hcmNOSndUcU5vZzJnUk9mZVY0d1RyV0tK?=
 =?utf-8?B?T2JrdzJsU0cwU3N5QjhMSkI5Z1R2WDZ3M002QWJycnh1cVg4MUVidElackRu?=
 =?utf-8?B?NnBmUFpQVU5UMGorclJQZmRnY2ZVYVFVazczb3dITUNHR0F5bjZ4alFsN2o4?=
 =?utf-8?B?TnZoRnlDKzFnaVYxdDdBcnEzWTlVT2UwT0x2YUxqM2RHTjJJYkhMNkJxVHFS?=
 =?utf-8?B?KzFOeWhzNEwvMGxVR2NRbEFObUtUMXJQSXZUQUhJcmpWelJGcmFrVWt4bStK?=
 =?utf-8?B?Sit3cTZqRTdxcFF5c1U0dUpSWWNPZVNvKzd1OTFVMUtYV0JQamFxVi82UTF4?=
 =?utf-8?B?Z2o2UXlEOFVkcEQwWk10T1JRdzZHdi9EdnIwZ01pTFdJZytGNVlJNms4ZnBm?=
 =?utf-8?B?REg5NnZJQUxBZTZDUjFQTzY2emw5Q2dRNDJvbHZqLy9qVzVKY0xsNWdkbzBl?=
 =?utf-8?B?SmcyWm9FK2FydVQraktzSnVaUFhkTHYwS1pRWlFLVWlUYUhhL1UwNjZ0dFZD?=
 =?utf-8?B?dFhKdHkySXBackZXMG85NUZ5YU02akprQVlnOVk5QkVveTZid3hnNkY2MnRk?=
 =?utf-8?B?UU9xSnVJRVl2QTNyNXBJNlFJZGVGMVhxWFlJMERqSExuU05xNDVwYUZ2NzA2?=
 =?utf-8?B?RmFuMURwZ0lqQkhRTDF2YXhuVTJabXFnNzJNTnNPR2JCZGtrUXNCTFZ5L1Zq?=
 =?utf-8?B?eHRpbURKMk5EUFg0UFlBMHJvMWVxMXZzNkRCR3ZPaUJHeDZudmt3VXZSdjdD?=
 =?utf-8?B?bzZYRUN3RU8yZmhpdnhuU2FlNFVER2ZONnh6MEZ2QVhkYkhsQmkvSnVKb1pR?=
 =?utf-8?B?bVVhM1dqNExwMWZITytHTTVEY1NwWnFLOXc4aENKNGZaeElBcDJmRFQxa2tG?=
 =?utf-8?B?a3Y1ZkR5UXhHQjEwdDloR05MWDhZS1lqRTE3REZCdnJPZDRBcEVZZUJyZlJs?=
 =?utf-8?B?QWp1ZGdGa1Z3cnhidzYyTk5ZbE5rRkxHS2M0MithdDRDcHpBU1BQc2pBL3hx?=
 =?utf-8?B?S2tJUmZueGdtRERJOUV0SENKd0N6blRBZU1ZYmRMZW8vM2pqUGVySDlnOXFZ?=
 =?utf-8?B?Qmg2N0RGOTYvb3dwT1FQOHcyKzRJT1NwczV4ZytXbnNqSGtQcmp1QXdLVHJ1?=
 =?utf-8?B?RjZVZEF4bkxNWTd2OEZIWk54L3FKaHRobWtYTGVOS2thNVMrSTExV1R3Ynlj?=
 =?utf-8?B?Z0JGQkpza2xYeDlMU0VuaXVjTzFRWUFaRFZhV1JUeDBnKzhRWkdTRERxbG1V?=
 =?utf-8?B?UzhmdElDckJYQkZPQzg5MFM2em5qMUhFamRHS2FxRU13N0ZvQ3RKN0Q3bU1H?=
 =?utf-8?B?aVZob2FGa0VVbW1INkNSQnFXKzM1bUJyN1hJRTFWS0E0ZmszZ2gzdXVpT1U4?=
 =?utf-8?B?VVJCa0JycEFocm9ib0dkd3kvU3FuMkk3ejhvQXNEVk9OTWI1U09TekFJRnNy?=
 =?utf-8?Q?3ZQfUNlhSIlSrXZSmDVYUgwXz?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	qoXkzb500046ihxxbliKFUplyshjL6Rd9U4fsghJSmLmOjvqzJSJu7P7oHC1whCTTjKjtuf8Y37BbwUye5fhVtvGgW5LGUTjAFUdYvHbhj0D7sFDL5AXcRTyT0/qU6O9CCc8QPUI9UDpXUDRl54qNlJ0Ct8xJTILOsLQuCozv0ARY+qkUy61/aP/CBJfpQstW3+k+7fjibMZzlmHCuiKpbVi67HsK5ZYWo7N4oasHir5YkCo8WC2z8fkWNf/8K89XgBamYZXm4e7lCStyVq3iE9uXuzpNRfUaN4b6xW1mUQEo8l+BIM8qo9+brEqUzra1Wiy6/I3U6eZ1jRpwQsl4ABqTz2UcYGmz/imTRRwlw6dOOH38JJuQ2RbKJGT/yR3KkDJJKUPZvU8FVx8e1wRv3b9gGaFM57PrIgz2z2LXZ24GMIhXK+llt4SSACLPzC+eCRxTBaHsRmM28msz8KafH8vKejlECVQ95f6SttFynzet4Rie1Dh/GP4enmLaAiNBZ4fNsSOctS6csS5DKzXhfb9kJspjN31F1lOpBomUDCtzbt33vsknneJsbHykJAAZ93YQw/rsdfUicC6Ld+j63IQP/KdGKBf0aR0lKFZ8SE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78edfe39-6282-466a-748f-08dd4d033613
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2025 14:23:54.5951
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ePDofyypxuWuhyTX9/5G+efjX2AsxPuw80o5uqNOOsstP7stpWBa0XC2USgf8NyX775lrK9NwzDl1r/0jFZY+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4716
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-14_06,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 phishscore=0 spamscore=0 adultscore=0 suspectscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2501170000 definitions=main-2502140105
X-Proofpoint-GUID: KST-860YauiwyAEycxKHcE8iIghu8RXX
X-Proofpoint-ORIG-GUID: KST-860YauiwyAEycxKHcE8iIghu8RXX

On 2/13/25 12:30 PM, Olga Kornievskaia wrote:
> On Thu, Feb 13, 2025 at 11:01 AM Chuck Lever <chuck.lever@oracle.com> wrote:
>>
>> On 2/13/25 10:47 AM, Olga Kornievskaia wrote:
>>> Don't ignore return code of adding rdma listener. If nfs.conf has asked
>>> for "rdma=y" but adding the listener fails, don't ignore the failure.
>>> Note in soft-rdma-provider environment (such as soft iwarp, soft roce),
>>> when no address-constraints are used, an "any" listener is created and
>>> rdma-enabling is done independently.
>>
>> This behavior is confusing... I suggest that an nfs.conf man page
>> update accompany the below code change.
> 
> Do you find only the rdma=y soft-rdma case confusing, or do you find
> that when listeners fail and we shouldn't start knfsd threads in
> general confusing?
> 
> It was always the case that if rdma=y is done, then any listener
> created for it does not check whether or not the underlying interface
> is already rdma-enabled. This hasn't changed. Nor does this patch
> change it.

Not saying the patch changes the behavior. But you have to admit the
behavior is surprising and needs clear documentation.


>> Reviewed-by: Chuck Lever <chuck.lever@oracle.com>
>>
>>
>>> Fixes: e3b72007ab31 ("nfs-utils: nfsdctl: cleanup listeners if some failed")
>>> Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
>>> ---
>>>  utils/nfsdctl/nfsdctl.c | 4 ++--
>>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/utils/nfsdctl/nfsdctl.c b/utils/nfsdctl/nfsdctl.c
>>> index 05fecc71..244910ef 100644
>>> --- a/utils/nfsdctl/nfsdctl.c
>>> +++ b/utils/nfsdctl/nfsdctl.c
>>> @@ -1388,7 +1388,7 @@ static int configure_listeners(void)
>>>                       if (tcp)
>>>                               ret = add_listener("tcp", n->field, port);
>>>                       if (rdma)
>>> -                             add_listener("rdma", n->field, rdma_port);
>>> +                             ret = add_listener("rdma", n->field, rdma_port);
>>>                       if (ret)
>>>                               return ret;
>>>               }
>>> @@ -1398,7 +1398,7 @@ static int configure_listeners(void)
>>>               if (tcp)
>>>                       ret = add_listener("tcp", "", port);
>>>               if (rdma)
>>> -                     add_listener("rdma", "", rdma_port);
>>> +                     ret = add_listener("rdma", "", rdma_port);
>>>       }
>>>       return ret;
>>>  }
>>
>>
>> --
>> Chuck Lever
>>
> 


-- 
Chuck Lever

