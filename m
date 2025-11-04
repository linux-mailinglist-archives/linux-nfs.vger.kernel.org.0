Return-Path: <linux-nfs+bounces-16029-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE1F7C32F41
	for <lists+linux-nfs@lfdr.de>; Tue, 04 Nov 2025 21:46:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9E1618C24A5
	for <lists+linux-nfs@lfdr.de>; Tue,  4 Nov 2025 20:46:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 006D22DC320;
	Tue,  4 Nov 2025 20:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="akeUj/Ij";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="VMRa2LHX"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 611602C181
	for <linux-nfs@vger.kernel.org>; Tue,  4 Nov 2025 20:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762289156; cv=fail; b=ihzm4/dlp41YgtyOQ0pSkBPKIbWbul41Xa8XNBY+3CZvFLCVjmF9Ak9eRcJwXRunRTWW440AgJAFz6WYQBaxHSOo0Xi2u0FdZFd0w05w5X3AqMGTiSnHZSZd7UDKxvG/r02kg+cdoZ/1vrYNhKPQdfhZE1gVNFRGwwlS8IyHnog=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762289156; c=relaxed/simple;
	bh=4GLSi3Cm9T84aOr7AgttAO2u1Ss/ES86iF/u16hIqDg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Xi/Pet8m5jUpiqyuc6FZdhFXK0FYs1A03yhnWtefny2KBD2k3tjodhKNNHv/X4qeKPC3LRg6KL8eRgU+7q8/qGoDZkiEJwa+5mmuoxtHKqCehqMCZasIdbkThomqqiJrO5D6khgXcgjg2N8xw1G5dSvZzfgfnGMvNDgWXjpXeUw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=akeUj/Ij; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=VMRa2LHX; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A4Kj2m9002790;
	Tue, 4 Nov 2025 20:45:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=l4IbdI7eIMqbAR1GODJ4Z5OejCr4TYAtZOAik1uO3zc=; b=
	akeUj/IjziZME8P6toYGL9xyJbQwlHq3IMXDdbs88GS2EKbMsD5VTWemmZMAuV9A
	zxRjTBOGFf0e1hyOZWrk9CVnrwfAt5ZzpASTdZi0Kf4pIgpT3swPGnyACqAAqEs7
	sJw93gNew+rpgIfZZqEusWTqWpMpz4bktMLFcqgdWLgcnvQT5fiYeqE2Gut7e3KK
	dbBdlaSNpcTBH8ChFJdMFvpPuOwgWPEFlUIoSIFMQES1+QZjVqUZcY7TtoFsjqXs
	YPzVS8Clq/imWggi5cZAQSkzPwm8WktQFPK20uKAagixQiYr1HtxuPzrIiOZ2oeF
	9iTPcZtvcnnMz+mP85Ukkw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a7rspr00t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 04 Nov 2025 20:45:49 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5A4Ka7md024770;
	Tue, 4 Nov 2025 20:45:48 GMT
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11010003.outbound.protection.outlook.com [52.101.201.3])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a58n9vjer-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 04 Nov 2025 20:45:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uHiqfrVYjlOWE6b0fHky1rGw1OOS2QQcdGiEijoNlhyMKXDlDAwG7UttUVcAT5GM8x1gbKkU0waIU9urb3Gn2gAVPRr6L/rg4mtycpktfl+apfCAjAzAMEa3p8j3swgu+a5XMyzMD6bON+taXOHN/vNK0P3c6Oyt790CCcv4Swsl1WkTcmE6HxmRhwHFzEEO7a8Tcio+Xh/BR4QbDCqpAle1OVJJYKZ4omNcNFJf9S4cU9OSXButgqpO94NVfgoxVPfIZ+MvFzvAFHcPzrXojj1NVxvEis2o1len3gYb1GDhabS96W51In/rFJZn553tvi0s+wWWmRFMGs4RGWVBUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l4IbdI7eIMqbAR1GODJ4Z5OejCr4TYAtZOAik1uO3zc=;
 b=NroyEhWyRoSxAyFCl28USjl8VEaI3hRQwXo4OFeXFKhjlGgKyFdKnwO4PpQknDMv7cADPlTaep3wNhm/+LGVbnSuqurH+XKl9cqIxD0M3R9M2OYUUwOS/MblsavGIoim/UuEzPrYAZ1oJiAuCxClekiWn2fhmdqv7uyD+d721ivMy1BXMUkzA86GVVShojDL1Tf+mPzo5cEh8nY37t46tqlgT0IrQcPVpcR8nFUkG+BJDz2bSocmIlc7OGdUr+11/lkXOuRNaHB7/dEEPoqjy+6zYV8ztDgs3NG/la606BvwnjOsborgI+gzyks7EtC53Tk43i8kynP2KE0K8DJmeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l4IbdI7eIMqbAR1GODJ4Z5OejCr4TYAtZOAik1uO3zc=;
 b=VMRa2LHXtrtduEimgEjQW02i83zKjlcKpIXzznAmB9eaBeFbOTJq+8HTICyhcFZucNp4+sJpXr9qmoMEefI7TCujDarX8olOp0QAo2hFr4eryGzeuYRgB7U/XixvF+Eon1UGfKqfGsix+L1cUUCnqMVHtOP+6s8+eAeGpto49k8=
Received: from BY5PR10MB4290.namprd10.prod.outlook.com (2603:10b6:a03:203::15)
 by MW4PR10MB5750.namprd10.prod.outlook.com (2603:10b6:303:18e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.7; Tue, 4 Nov
 2025 20:45:46 +0000
Received: from BY5PR10MB4290.namprd10.prod.outlook.com
 ([fe80::c86a:40f1:7833:ef3c]) by BY5PR10MB4290.namprd10.prod.outlook.com
 ([fe80::c86a:40f1:7833:ef3c%3]) with mapi id 15.20.9275.015; Tue, 4 Nov 2025
 20:45:46 +0000
Message-ID: <af8c1f13-5f33-4995-90d5-5433cc63bab5@oracle.com>
Date: Tue, 4 Nov 2025 15:45:34 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] NFSv4.1: protect destroying and nullifying bc_serv
 structure
To: Olga Kornievskaia <okorniev@redhat.com>, trondmy@kernel.org,
        anna@kernel.org
Cc: linux-nfs@vger.kernel.org
References: <20251103221339.45145-1-okorniev@redhat.com>
 <20251103221339.45145-5-okorniev@redhat.com>
Content-Language: en-US
From: Anna Schumaker <anna.schumaker@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20251103221339.45145-5-okorniev@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0079.namprd03.prod.outlook.com
 (2603:10b6:610:cc::24) To BY5PR10MB4290.namprd10.prod.outlook.com
 (2603:10b6:a03:203::15)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4290:EE_|MW4PR10MB5750:EE_
X-MS-Office365-Filtering-Correlation-Id: b8d39211-1d3a-448a-2923-08de1be3214f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eG9uZnBpckhzbHdLYkJqdXJVUE15aUR4YVNxZlliblFzMGh6cTUyZmpnc2FL?=
 =?utf-8?B?VnNHZGsrVkJsWTJLUjc1VVVtcmpLekViQlkycVZweUt3NG1NNGwrR0VtUGtD?=
 =?utf-8?B?Tzc1UG1DRWRra280ekZTWjRobUVlbmtCbE9lYXdLZmR0dDNldS9DQjZRUjVj?=
 =?utf-8?B?RUQ2dnBHSmt6MWlub1plV0JhS1l1WWhEOUFzRUlwcWozYkNpQTJENm1kSkgw?=
 =?utf-8?B?czhOL0Z5UkdFWjgvMXZmdmY5Q2pGa2psY2ZmVklFTU5sZTJ6cEV4NDNxT1BC?=
 =?utf-8?B?R2hQVlF0U2xxRDFLTVRZWUNYaURxVW5HcDFhVmZFNmp0c3hWSE5iWmxKK2Jt?=
 =?utf-8?B?cTlzTXA4aDVMcmd0ZURnR01UaU5LWEFLNE9INzZDeEV5bW1oTU8xTEhMbmVC?=
 =?utf-8?B?NnVjZmkwM0Q2MUdoRHhwQzZMbzhZeVI1M3YxdUhXK3BxOXZMU1p0ZXVnYTJ5?=
 =?utf-8?B?RUNzbXNzeWRJdWREVUd4OGpHY0l0bWE5V1VQYkxGY1hCNVAxWW5jSG9LNFEz?=
 =?utf-8?B?bHMwNXpmYUpMOWs4WExWUkx3Lzg5bkxrT05zWjJFcThUaHJqZDlHYWtPREZJ?=
 =?utf-8?B?eHpzV2swY3owK1RUUEV4NFIyS0dtVGcreXpLL1RpY3Y3TWlVN2xaVlZ4NmpS?=
 =?utf-8?B?c3JrbzFSTURxK1FMY1ZhVlJNT24xNzRIdE9zcG9Rb3lESHJwYmhvSkk5S2xJ?=
 =?utf-8?B?dW1rdjZXSEp5SHNVNFQ2ZndrVGJxMlVLUDVPcEVtdEZMS2VYck9ScEVsUUxD?=
 =?utf-8?B?RnFYMGZ6SHh4WWNaV0RseEFROTZ5ZXJ1MGFxZzMrdXp4ZTBXRUJJM0dwQmh0?=
 =?utf-8?B?bzBjeERMK09DWm5JMjcvcFJhVU5yeHcwVk5UQmMvczRPYnArSTA4WlBXM3Vq?=
 =?utf-8?B?OG1BMURSRUlHeHFrS1U4bE5NOHRVVW1iN2V0UDVhOWUrU3dBdDJ5L3JPbnNq?=
 =?utf-8?B?OEswdllubFNGR3dzbnFhWjZXTlBKUzNTaFJzSlRUOVBHQ0VYRklzaHIya3N4?=
 =?utf-8?B?QWF0bDY5SzZENDZQd1dVdHE2NkkwZy9yQndUS2dNbWR0ekwxMkZyRklWajky?=
 =?utf-8?B?dHJjL2lHaVpGL0lYUDNPdXBOc3BWUFFxNmNVb0lSQjdxUjZseHJEUlhObHZ3?=
 =?utf-8?B?QXJ4YTRDZ0lYd2NFN3NubTRQTzVuelhTKzFrYTRyV2R3UytTeWx2N0g4NGh1?=
 =?utf-8?B?UmRlT2R0Y1Z6UmV4RHJTbm9KUWV2ZnJUNVN0cEF3ZzFwOTZFaGViUlA5Tnh4?=
 =?utf-8?B?VGZnZitSTU00SCtLNThFVkNUTmMvcEt2dnNaSGZ4SHpzNm5HY1U2d0REYko5?=
 =?utf-8?B?MCtONXJkMTBkb2NCYWVsWUsyeDVlRUtKbXVodDRqV1JuM3hzRmJjVUxHZ2My?=
 =?utf-8?B?U1RjTlEydGRHLys4OTBjSzJMZnF3VmZvczk1Tk9zbWpwRFBjOVIxVUh4cUNH?=
 =?utf-8?B?ejhSWndVMnRxT3NOY1hBWUo2WGUzM1NlZXpoRVo0K052dkVxOVoxcHpFdy80?=
 =?utf-8?B?MGpRb091ZVk5cndKaXB0K0ZldHM3aThDekRUNmZHNFpIWXRTOGU2RGZOQUNE?=
 =?utf-8?B?OG5iUlpMMmlDMmdyRUdnb3h4bEhPTnBrYXlTeHk2RFBVeGlKQ2tpMGxocTVX?=
 =?utf-8?B?UURCSjJRQW05MysreTIvc0V5NWtEZFFha1h5blcxWjBkOXJKR2dubGJMY3dN?=
 =?utf-8?B?TGNyZkFMNm4zWCtyVVJ2ZFJIMnV3aDVHNk1jZnV6WEtRNUlFT3grUitxMlBU?=
 =?utf-8?B?T3JVNlFiTk5CWUFFMDBUQ3JGdm5GNGhyMXR3UWFybm9EKzVZMVJmYkRNZG9X?=
 =?utf-8?B?SWMyYzk1dEJJeEtnSGkzVllZNTJENk8vUXVEOHNUamVTK1NPL0JzaGFLS2FI?=
 =?utf-8?B?dVRBVERWVy92YnBGRHhNQUVhY3JlcXpVNlUwTEQwRnJYY2U3dGJPTXhsak1L?=
 =?utf-8?Q?P0TzDPrsITrVRTHHpmX3hrbEnp1qP9Zf?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4290.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Snc4MEZHSytLTFlvSUZ2TVVrUE0rWWV6V3UrR1FVQ0gybHNQWXRyeVlZSkk3?=
 =?utf-8?B?SjE5MW53QklmeGt5VUY0RG80dXdrMGdwR2U3WXFMekxlQTVjc1hHVDBOekY5?=
 =?utf-8?B?ZW91YVppWGN1T1ZpVzJpb1QvQmprbjRyVk9SZ2dUTWJ4Ry9meUZTSjlVVFRz?=
 =?utf-8?B?ZjY0TC9zcHE4QmZrQ0UwamZZZlJzakI4bTNRVVFyeDRUOFQyc2J1SWRuU28w?=
 =?utf-8?B?endiQ3pCOEtwWWhKdDdYVzU0UjB5Q2drRDh2eExXZ2Ryc1JvZmFLaVdKdXMv?=
 =?utf-8?B?NVNrSFRBVll3c0lUMlBFZHFyaWp3NnRlRHRjWXdNYjRjSDYxWnExd3N4bXpw?=
 =?utf-8?B?WUZwUGZDQkNtY1ArS05kWW5TTHhHdEIrS3FYdEtJc0VFMTBGbVhTbjA3Wnk5?=
 =?utf-8?B?ZVE4Y2pSekFveUw0QTJSKzd6cWl6dmJzRHBNd0VFazBBV3pWMGRERFN6V0ow?=
 =?utf-8?B?SjRla0xmWkRsU0NLeFlPNzdIZnFCbVc5aWpvQ2NaeXIrbURKY1BDTkNzMXlv?=
 =?utf-8?B?NWMwQUJGTXRyTEJIY1g4eUZkcU9mTkZrc3JTZFd6a0Q1YTREdGoxNG9aVDBw?=
 =?utf-8?B?RlNsazRyblNSeDljOVpCajlxY3M1VmMwemJMajhkVXp4QUl6TmFQaWlKS0h1?=
 =?utf-8?B?RHVxRVNLQWtRczIwZ0xudDh6OFJ6L1dOYko3OEVSSGZkaEllaE9ySjUzSVN0?=
 =?utf-8?B?T1pzQjZVNk9mT050U2NkRXk4eERaQ3E3ZUhyS3FnQkJxcjB1c2N0bzhJTEc0?=
 =?utf-8?B?eDhJNzJTRVJEZy9WM2Z3Y0J4TXFkNzNqVXVKRU5hSW1KL0xidEd4Mm8vdDJG?=
 =?utf-8?B?a2tNRnY1UnpDcUdGbTIwWnV5NllYMHZJNEE5NEdlR0RNOTlTUUp2dlRNOTVT?=
 =?utf-8?B?OUhoY0VUdUsyTi9hNXRKK2lGdzZCRmVFNGlzOVFoSzUwV3YyTndxMzgwV29x?=
 =?utf-8?B?Sk13M3U4bzJ0enZrMGZEaE83L1hmOUVQWWRaL0lWd2tEZ0J2ZEoxYU4rZVNa?=
 =?utf-8?B?ZHhKVklaMWJaR040elBQU21hZms0cnBGclE1aGFBTnVCdEtUYm9iR0o0U3Nu?=
 =?utf-8?B?QkZvMXRlNlpta1dnUTY2UlJPWjV5NjVNTDg4MkNraGtFNk92MmhwSEZ3Z0FF?=
 =?utf-8?B?Q3hlYm9MV2xoQWhkOXpLZjNiUEo5L1gxMU9YYmhxdUVPc1M5T21zMWhUZU9w?=
 =?utf-8?B?RHgzNEQreU52cWZnRHZPY1ZzWStqc3lNNGVjQmRHYlZEcUJQYmFjMEZLS1dQ?=
 =?utf-8?B?ZEgwYU9WUGNVQzB6QnlkOC81RmtCWE05UWQ3ZjRuVnVnWGY1L3VGazJMM2M3?=
 =?utf-8?B?OVhPdWtLV1BqbHZiNmYrU0crWklWRVFVZGtkY25WMkRYQTJXVzVpa3BMd2do?=
 =?utf-8?B?TVVVaGpBYlU0dHBFMjNOTnZFRFYrS2hCTm45T2F1c1lqbXFVeG5uZHpPWVg1?=
 =?utf-8?B?RnRiQWNWbk1sV2NHRS9iQjJueWNFOFA5Z1dFNVB5M2JMQ3BoY1ZBYXd1dkhu?=
 =?utf-8?B?dTR0L3Vib1FLNlQ0ODZUTFFxYXdxQzJGTCtySnpaZnVvc0FRTGNIUE9nbDdH?=
 =?utf-8?B?bjdZQ1ZNaFN6eDZtSWxsK2VzeDVTM2hWellRRkVwKzNnVk9tUXhRaEljT3VC?=
 =?utf-8?B?RGNEelZQRWR0b1htYzRuSmhNQzhDZkhOYTVMMFBPZ1g5RXpPMjQ5aG1ld1Rw?=
 =?utf-8?B?SzdTNnJ6TWdkYVVrYWY2UVF3eG1Rb0tIbHoyNmJGMmhsQWhvcnFKWXdnOVcv?=
 =?utf-8?B?WUMrVGRkV1RjVHB0NzdBMmxVTkwxYTVqRjd2NG1BamJzaisvOWpIQ0dWRFY0?=
 =?utf-8?B?bjJjaWpVeUE2OVVHU0xzQjNscGo2MTFCLzBiMEl0bEtVWUVCa0MyUkx1d0Vs?=
 =?utf-8?B?RDAvTWZYQTVONzVDQU9pSDhmSThuU2lKT3BkTzZpNzdUdThxMllHYTJ4cGli?=
 =?utf-8?B?VGdUWjNJYTE4Y0ZtazhObFlDRGVYUkxzY1owVXRXQlNFa0NUekVOczQySWRW?=
 =?utf-8?B?Rm4yWStleHlkYUYvckx1RTJFaUI5NXk4NFdLaisrY0tubFhaeTF4djFlV1dy?=
 =?utf-8?B?ZkVlR21UT3hzMExZcU5EQnVzNm5CWHdDUWVpOTMvWmRYTTFIY2VBOCtGUTVK?=
 =?utf-8?B?ZGh1ZWtPL3BQTFUxZ1VwcmZJQUNkSWt1TTBUVyt6aUdoc21LWVEyY0NzWWpi?=
 =?utf-8?B?QlE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	IePp+UfRJ2heD91KSd8OaU09PA3Mv9qqniuUUMxD9VEkTFxVo5nDsUpGZ7fSXIVqOBmTOXLd2jb9tpSNdCH3BSdTOGKgp1BeHe7q8J87O5PP5RK0bWGmg+TkiQo8Bxeo+TGegm+BYqHYzRkZ9SXD6y9yRmxztv37LPAYGkjd7EIZNvjUPqsX2r6xYQgoeJXwyCbLfUBcFhDU7mK2zPi5DPP4bmAKXCrJNNIsXtTjIK+SVxSgcXZ6fFW1chdFtvLLReCeA7arno6a7BTqRVFKVumJNzdJChBbKYpeAFzfVHtFiwv7qJ99jKQAOvPzLhOUsU6iqxtzSKTP4gyrhGeRc2KwbkYf0kA5U/DDDZYtDd7UmS742GV3TpF83Ony8dET0ZmOyGgN49tMe2YCnCNmMGaQpAdcT/0FSYTCw8J2PFXcLc0XzsPlXlfiMRXj/xMfqrpGje3ruQqKTPvXelUJyn8Ce8BkHK2QQFTtS7nuXsrKDhBJW6sShrWXmPiPtdeA5YscYCWeavlH5O8u7NGJK3gJeHsMqFkg6h0m3p52hevPao7gahlU8TLeHMx1QzXbwP8QT+DpFeJlj8kyr+6Pc57Ds0Xx2L/qrByUe64FW+U=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8d39211-1d3a-448a-2923-08de1be3214f
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4290.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 20:45:46.6434
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: naElyScp/GfWdT71HGIgutJHWoekpYQDYW5eNaDI2keFZlho7xTo7EDF3/FROvuFjsCyOtBAKpkwEWmoF/9se9YswhFmXRXVbsTVq1289Sw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5750
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-04_03,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 spamscore=0
 adultscore=0 phishscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511040174
X-Authority-Analysis: v=2.4 cv=OcOVzxTY c=1 sm=1 tr=0 ts=690a65fd b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=20KFwNOVAAAA:8 a=7n4VvvSflUrm9bKhTukA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: lsc6NyCvnTgoPSuef0Ny89kdNz-Sgldu
X-Proofpoint-ORIG-GUID: lsc6NyCvnTgoPSuef0Ny89kdNz-Sgldu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA0MDE3NCBTYWx0ZWRfX0HuZPVRd36Ez
 jTfNTU3o6gQXRHeBnAUsy3F9rlsuG7HqQvD16wfLVuG82ola57BvhXN3JgXaVfiSZbRaGw2Ks/o
 qPymddSLEzNzuO7tU/bJyk0lobs12K3E3v9zbED+nFw/R0dIwao9S4x296mPa10sNG4aU95H4U7
 0BYfi5Dj0MivkL+Tvkq1G/75tD+fV6hN/GHCt56S+UX95Xr9vOBEuB2B7Ooi4LAKsO8W3xI6rzX
 TOy+k/yfOIMrAUqnyHZCmseXV1P0e+FjsbJLgQATcMKBm1mn/KD9y3caJGZNNHu6LfRaAdqvUj+
 unqrYL9aOs7VMfurvpxYwX5yl1sAdOqXGC61wH/OnZyO9PvZm7EEXtfZtebQ/TQluo+aASnX05C
 Wzm7TSDHuh1oV8oXCb72FVH0dhoHow==

Hi Olga,

On 11/3/25 5:13 PM, Olga Kornievskaia wrote:
> When we are shutting down the client, we free the callback
> server structure and then at a later pointer we free the
> transport used by the client. Yet, it's possible that after
> the callback server is freed, the transport receives a
> backchannel request at which point we can dereferene freed
> memory. Instead, do the freeing the bc server and nullying
> bc_serv under the lock.
> 
> Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
> ---
>  fs/nfs/callback.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/nfs/callback.c b/fs/nfs/callback.c
> index 8b674ee093a6..58e865bba03f 100644
> --- a/fs/nfs/callback.c
> +++ b/fs/nfs/callback.c
> @@ -270,7 +270,10 @@ void nfs_callback_down(int minorversion, struct net *net, struct rpc_xprt *xprt)
>  	if (cb_info->users == 0) {
>  		svc_set_num_threads(serv, NULL, 0);
>  		dprintk("nfs_callback_down: service destroyed\n");
> -		svc_destroy(&cb_info->serv);
> +		if (!minorversion)
> +			svc_destroy(&cb_info->serv);
> +		else
> +			xprt_svc_destroy_nullify_bc(xprt, &cb_info->serv);

Any reason we can't ditch the if/else and unconditionally call
xprt_svc_destroy_nullify_bc() here?

Thanks,
Anna

>  	}
>  	mutex_unlock(&nfs_callback_mutex);
>  }


