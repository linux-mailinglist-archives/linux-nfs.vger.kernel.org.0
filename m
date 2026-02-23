Return-Path: <linux-nfs+bounces-19149-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qG1vAkG7nGlSKAQAu9opvQ
	(envelope-from <linux-nfs+bounces-19149-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Feb 2026 21:40:33 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F99B17D058
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Feb 2026 21:40:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DA0D33020524
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Feb 2026 20:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5013637755A;
	Mon, 23 Feb 2026 20:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Dgr6ZVRV";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Qd3ytBCH"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD6E136EAAE
	for <linux-nfs@vger.kernel.org>; Mon, 23 Feb 2026 20:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771879229; cv=fail; b=NUuIpO2XpVuIRtrmFchlNxqOKbIwrbDXEK+BTK9S5FrR/ghSwQ2Fd5mE29NId+hG4m7LXibPzhsaYatGPxSTq3CBWbIJGZIEp6J6Oz2ga2RCSHAc7wnN669Cjy31LT+a09+lufOyKnKVxCFoyvncsk/skjVmj9RRNQxWAGJ44CY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771879229; c=relaxed/simple;
	bh=FRPEXGZcoNAzcbqjN66kjk5msWddtBYuIxoZVcQ4XQg=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 MIME-Version:Content-Type; b=qz1O/9WTjezjKCt7hvCcB02V82bu4sFNnatQKgHNJBDvQqNw+7Szg1oL611y7K0DuChbYdq+d2iuHIYcFuo8s/XpQdmY7sYDy2rYPKi5o40P4kOHp353ZUJsnzMtPeWIK9+4UeEtCzfCKUZsW6hVzXNzy/8YgsOsfHCKMu+QSRk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Dgr6ZVRV; dkim=fail (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Qd3ytBCH reason="signature verification failed"; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61NEuwwS1140526;
	Mon, 23 Feb 2026 20:40:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=FRPEXGZcoNAzcbqjN66kjk5msWddtBYuIxoZVcQ4XQg=; b=
	Dgr6ZVRVJKCfHfPYAxrvtCrJtOnSMmwGaGqZ9RMq3pAgDDx3cJVhJH0GoKHOD8/v
	rBj/coBK28TpF2UHbTlkJfOTxz0CKmNOTbLMSq9X6THF8/6YPIf5a/EYttoeF/by
	jcoLP5AB9/HODWD0Zh2qDELHthX4/7CL4VIrKNfKmzx4QZnvrtvpjgQ+2E8tYB9J
	3ZroAQifzl71vEhCvqmDyuqju9CMrr9AXF37DhYeu8sTyfkDHiBUuo7i00vvLlGq
	8x41+x/vDYG6NVSCgoI0Jzfxgfh0QItx2rl9mf7TOoBFQm3frsviF/Rx7LCDd87c
	lUqqqO7YIj27M+7k8S1yjQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cf58qb20r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Feb 2026 20:40:26 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 61NJwIeV015915;
	Mon, 23 Feb 2026 20:40:25 GMT
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11012030.outbound.protection.outlook.com [52.101.43.30])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4cf359403v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Feb 2026 20:40:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=exNJ/toR/jc8QVmcCwafKDzu27vFRhW5MKgUhtK+3aKpZ/+gplQBhqEKm2UlsQXXA91bjAu0/qIji/t1wQOm+EfUFScD427NDy7Vs66iwx8IEYotD6wYrrFukE3pvn3mYfi7vSGgOEnVJcK7r4TcYKt8yLvEmpTUNdD6rjtlC+zMe2j7Jvm3AxlFlk7B2cF5IuNJmy+iCdgZxYMR2QMdYzMd9I/NnOET0GTSFa1yo/ogu5O7BSyZR2KhawgrXNgqfbJ/dm9iY9a+6Y0ve2gtl6QiNAcJaKRoS4H+HBt1YHFiegH8X5GuNxxN/+zDUWZyXE/TlIrsNeKVLlhaxM3ydQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TP7q0F6DYKSSuT2U8/w7Epybag4l4dOGHBcKxjjkJ+A=;
 b=f9xekxe8OmcozlVstES/iT6DrGARwuxzZA7a/8IoDP/59hD2bJR2nJAZJq+mYb1GKETr882k5ARRyckbFOOl8S60fyL2N4AN9ANq6QvUOq00ytyrUjdMd35uIX2NylGf9IP5hN3EbhGbN8wwxNpJ62Vq0bJmp/uB2cEcI2wRiC0y94N4zAvgW69QavKD5MrJgfhLBba6jrCeuN9YSJSlIPnhc5x7dbbMu469GO8tXXdtbleBJMglzifOYFcf83knqgWQHOJJ5LjDCa+e4e9VIrUGU8zReyw4/lYFYqqkpBrbhvOxxM5C84lBzWiyKHGBV+ZsmqsxrEDl7vz7Ys3Skw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TP7q0F6DYKSSuT2U8/w7Epybag4l4dOGHBcKxjjkJ+A=;
 b=Qd3ytBCHUEGw3D95mlZs2C5m+HjAaq5fXGZfolp9KHISQg07tHgYE5+7hniGPfmoXvRzzP1KiSVEQgwl8PqCxQq9iCFWKirIMM3wkOInbC7CnO3cc8CYAeKtTMJjP1fRu4Z/CHJNmPxH+jOigMwA0yLy5xGsWp2s5yUwOT+x694=
Received: from DS7PR10MB4847.namprd10.prod.outlook.com (2603:10b6:5:3aa::5) by
 CH4PR10MB8145.namprd10.prod.outlook.com (2603:10b6:610:235::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Mon, 23 Feb
 2026 20:40:22 +0000
Received: from DS7PR10MB4847.namprd10.prod.outlook.com
 ([fe80::9ad:e2fb:c910:cdd1]) by DS7PR10MB4847.namprd10.prod.outlook.com
 ([fe80::9ad:e2fb:c910:cdd1%5]) with mapi id 15.20.9632.010; Mon, 23 Feb 2026
 20:40:22 +0000
Message-ID: <d0985146-6caf-40f5-a11f-d9585bc33377@oracle.com>
Date: Mon, 23 Feb 2026 15:39:36 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [External] : Re: [LSF/MM/BPF TOPIC] Implementing the NFS v4.2
 WRITE_SAME operation: VFS or NFS ioctl() ?
To: Dan Shelton <dan.f.shelton@gmail.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
References: <f9ade3f0-6bfc-45da-a796-c22ceaeb4722@oracle.com>
 <CAAvCNcDw+FgjEq-Vvx=yD2sD8Fwr5oVfahK03mCUgiyC7nKsGw@mail.gmail.com>
Content-Language: en-US
From: Anna Schumaker <anna.schumaker@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <CAAvCNcDw+FgjEq-Vvx=yD2sD8Fwr5oVfahK03mCUgiyC7nKsGw@mail.gmail.com>
X-ClientProxiedBy: CH2PR08CA0020.namprd08.prod.outlook.com
 (2603:10b6:610:5a::30) To DS7PR10MB4847.namprd10.prod.outlook.com
 (2603:10b6:5:3aa::5)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB4847:EE_|CH4PR10MB8145:EE_
X-MS-Office365-Filtering-Correlation-Id: f6fb247a-d22c-46ff-9dd9-08de731bc41d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MVgwR2I1V3lPb0lzUFBMNkdiN3YwUUhxaGU4aXI3cXVqQ1ZkcEZYTjRFanp5?=
 =?utf-8?B?OUsrTWZQTzE0Yk1OTExpMzN4M0xJRnAxeWJEYjJOckY5RzNOSkNCUXBDdjl4?=
 =?utf-8?B?V2xkRWloNGd2dnlVTzBUcGpyRzgzYStCSWJDMlZET2JiMzUvRHpYRTYrS0cw?=
 =?utf-8?B?WGpIUWcvbU5NTlM5VDFzOTBkK3BhRUFvcE1wS0NldDBZL05lRmwwNGw5Ujdk?=
 =?utf-8?B?eFpwdEhranNOZFhkdHNGQlIxQ25iMFNGZWdrZG1UZ01oQ1FnemlNL1lVayt6?=
 =?utf-8?B?aDJabHpIcjQ4dkRsRTB2WEtVcFBLNi9lMEZ4STN5emlEano4TC9DWUdwaVhr?=
 =?utf-8?B?azNXLzFTL1JYNmtURDVzQXlHd0dXTW1IVTJPV0EyQ3B1MFQydUxNZmorWSta?=
 =?utf-8?B?czhpL0JGMFZ1R0VYVm5PZU9JK3E4bHNOMURJaitETlE4TVFROTd3cTFseCs2?=
 =?utf-8?B?UTVFTllqY3UveloyTmdtMTBNa0owdUc2dDlKazc4dllldXc2Y0RaU2srRDcy?=
 =?utf-8?B?OGROTmEyUHJRRUw3Ync0Y2xNa2U5ZjhNdUIrUmNqQ0JCNEVQQzFxRXgrQkY3?=
 =?utf-8?B?cklmZVkrWFVQMEJWRTl2WXlDSjNlM2p2Z1BTQUJDamhoYjA3MFBVbUdoNDF4?=
 =?utf-8?B?RGE2bGJURDVxZ1A3cm5SYWcwUlVjbDZTVWZPdGJXdWlyV1gyWnRXdjRTaHAy?=
 =?utf-8?B?YjJrdms3eWtvdjZNN0RXWktXU0ZvbDhXdWFONEF5c2xiYjF1QnNKaEIrM2U5?=
 =?utf-8?B?MFRSWDVqMWhmQ1RCNk9UdGlWVVBYTVpmeXU4dWNwRngyWmx0ekE5Wk8xTzBI?=
 =?utf-8?B?S1FjQ0c2RU92U050aDZKRGR1MERiY0hSZVNsdUcxK2poSVRsSXI1VElIUUox?=
 =?utf-8?B?M3hucmpxN0JOVTlsdkRpdzFYclhMTWFneEVDT2xocjJMNnQ1YjV0MFVLUkNX?=
 =?utf-8?B?Y1lGUHBFVGtxbEJSZmt5NlprNUswVjdwNDJJaDB4WjB1a2RBaXo4YXVOemVm?=
 =?utf-8?B?WWFyelJEdEtjaUpGTlBlb21pL2Ftb0hHMnVWcndvNGV1cHhidzB6b3lmT0Rx?=
 =?utf-8?B?a2JQcUNrd2hoY21VeXBYRkJmMVpzeE9TaU8rWVNWUnFuajVpM3lTY1NNeVF1?=
 =?utf-8?B?TWt3cmlBaDR5TjZ1Q0NvcVBoU3hhODd3anNGczVIN3pGbUhsa2pWcDU0NlV1?=
 =?utf-8?B?djBTc1Q5SG5iRXAvOW56cnVlckZSaXhleSt6K0ViODViVS9pSTZ5Q2NYekdv?=
 =?utf-8?B?RW1QVDMzSHl3UXE0WDhibGtBcm53dG8xY2R0RGExN3Bud2ZrWmxNbm9RUFVx?=
 =?utf-8?B?UVBkUzNWLy83Q0VZY2Nzck5iSHNDMzZGdVkwS3lhV0IxWkpFK1JkL1VhU1RS?=
 =?utf-8?B?aXcwcC9CNjBaZnYybjlBajlrakNZYWNkVm9HK0pCVDhLZnZBTWI5Y0VaRWRl?=
 =?utf-8?B?TzBxbVBFVWxhWjdIc0dGM1V5Mi9CYWF3MUFKVWpZdEJtYmdSZStrY1RDUEVX?=
 =?utf-8?B?bEl1NGttL01VVUY2MVRnS3J1ZEV1aDNwTFVVeTRaekcvS0RET0ZoYStmUFdq?=
 =?utf-8?B?cUYydmxielhtR3pMcFBmYllMSUVsbjk2ZTk2ZWVzcGx3Z1NFQkllOG54bGpu?=
 =?utf-8?B?N1BoQjJMN2hsNWNxaEl2dURKNlRnL2p2ODgybG43SERYLzRYcXFTK3lUMzAx?=
 =?utf-8?B?MDRuTWRBVXNmTkpiMnFha3A1YkdXbFpPWnpvK2tFY2k2NXJQQlFscXN3QktO?=
 =?utf-8?B?UkJMRUs1WlBPUkRoWGFKWUw1NHdvdEU3b1EzdXRmdCtwLzkyd21sU3o5bmlp?=
 =?utf-8?B?TTVvaFNMeitwb050YTZnY1FMK0N4QTN0ZjdJOGE5bFZHcXgyaUErSklxTkc1?=
 =?utf-8?B?V0EwSW1ZQ3hXU2pVaHRGUzdxdnJST21ZYlpxZWZqZEdmbVIrVGlROTh4TmJG?=
 =?utf-8?B?UEo3OWhrR2FhZEd3SkVnVW1GcFNKN2tydzEzN0JWaTFQVDJlWk9KdmtKWTYx?=
 =?utf-8?B?OFlOMTlQS2tnZUNVRStQZ1VBVVVNeGY1Mi9Zc2tXeGJlUS95cGJZNGUycTdq?=
 =?utf-8?B?L0pyWVYxR0Z1cHAvVlNJTEsxY2dwaXlhWVVHS2VMUmJiNDhGdHFjQ0xkK1lp?=
 =?utf-8?Q?WVa0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB4847.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z2JnWHYvOXVhUnRnZXMyWlUxVHlTS2g5ZjBGVTlCWTdLeUpRczRvSVQ3ZGZq?=
 =?utf-8?B?dk51QUpSRVRmbjVRbUdFL2hNNVBrMENSODRQMS9tbGVXeTh2dlkyb3AwbVlO?=
 =?utf-8?B?TW5tRWJTK1lTTnk1ZU1hSXZHWngxOThYOG1VVDZJOHowUGRLOVhhVkUrdXo0?=
 =?utf-8?B?ZDdQWmxzUUc5aXBySEhHcW9GTHZTMGN1cnZzR0E2WHA1ZUJNMVhiOSszNmUr?=
 =?utf-8?B?NDRtSytvell2WEhYK1dCMnNvZVhNUS9ZVmpVU2tseVVOd3BTakFJNlYrSGVR?=
 =?utf-8?B?ZlJSbUoxWG1XbXI0cmwrc2NBa2JYejF4bFhrMklwYTZkNVNwcnBlcHJTSkFT?=
 =?utf-8?B?eUxVcFZZOThsYjFrQU93ZmcxRnRROVRYa0pjTXNiaWJqTWI1d0h0QkJCSWhW?=
 =?utf-8?B?WWpiVmhsNTFpWm5zd1FhRkc0NXNGNjEvT0FvM2FnbVJQdVpVSWRSeFRtdmJD?=
 =?utf-8?B?eWV0ZFFYUnJzVTl5bHovOFBUS1YyOVZITWZTeElBeERQRzFsMkYzOUh1TjZ3?=
 =?utf-8?B?L2lOYWlPRzEyOXhKSEpZKzdEdTliTDg0Smt1eXNBK2VjNzV0TUUzUFkvVFFI?=
 =?utf-8?B?cnEwdU9lVGdMWkJLUDhOa0NKR2tzV3BxYXJRQmZuT3FFR3R5dVJzWGRoQTNH?=
 =?utf-8?B?ZkxHdkgxRjNHWEk0NlJoZTVQTzhHNGc2OWJLemk4ZWRMRjFZWEhQZHlsZFAr?=
 =?utf-8?B?VDlQNlUzd2RTSm1qVjhTYURkTVJ6cjR2eXNIakJCZ1lmWnUrUENvaHJ0Zlpx?=
 =?utf-8?B?ZWNNVEdneDkyUVltU1IySUo2cFNVT0JCam8vRjdZQlpFcmYrcFJNZmxuclFS?=
 =?utf-8?B?eWwzNXVCRWRKb2xNdCtpK3ZtWVF1bnZtQnFRdXJsdUxCd3VtNFMrZTB0YjRG?=
 =?utf-8?B?MVdBakVKU3Bvc3M0OWQ5NmZoR2dGNGpReDA4Y1dzMmpBN1BYL09ERmtmSFhn?=
 =?utf-8?B?dWRsWDZxaUdXVDNuem5qeEN2NFlOd0xtMGZjb2lpMWRRajlCaUR5Z1ZsVG9C?=
 =?utf-8?B?SHlzSER4cHoyNTkyTU5Mcml4S2Q5M3laZFJVZm1sY2YvUXhSZTlhOTJUdTEr?=
 =?utf-8?B?UDhrak9yTmp0NFBoY1ZrbEZMNjd1N3d5YloycDZ3OWltZmhsdWc4eGZrVHFv?=
 =?utf-8?B?SVU0V25VTVlScTJleFBoRXdqN0JzVTdWVFJlTmE3NEpFbDRoNGU0ampEbHZE?=
 =?utf-8?B?R2ZZRDFnZVc2MWlKMDVlSzNscWplN1ZtMmlwT1dmcS8yWnRzNHBPZDF1QUVC?=
 =?utf-8?B?MSttMUlnRndEQjV4Vmd6b1JMS1hHLzREcnc1T0hSdlFzN1UwcTF0dnlvcElE?=
 =?utf-8?B?aWZHYmFEOEdyUzV6dDJkQmttdVQzSXZVT3N6K2loTTRxTVVWaXVuUXRDNGhV?=
 =?utf-8?B?Y3FWK2RzcVpuMFM5bWxlTzNvYytUUHFkd0NKNXhLdnJ1T25TbVlIQWlKYnRu?=
 =?utf-8?B?ZHBsSzN6eVVmdER2dG5BZGxDUVNGc3lkUEF1cnV2QytpNUxXakd1KzhSQm9Y?=
 =?utf-8?B?ZXdQNk5HcGRreWFsQlUwT2FWajJMSmpQZmh5TXhRYWhnVzNJR0RFRndvTG05?=
 =?utf-8?B?b3hFYTYvMC92ZFFoc3laOXlmdHd0VFJiTUNjTEJreS8rSkF1Vjc4RHJObW9x?=
 =?utf-8?B?MGdNcGNmV2ZRR0NPdHZjSVBYcjMyOW1DTUtQRm0vV3FaME9aTjRyOEdWWTdT?=
 =?utf-8?B?VU0vNFB1YUFOdHBwOVlUREpaQnVZdUZjaG9MUVdhUGczT2tHUmdZMmo1SEJL?=
 =?utf-8?B?cGxzSjhuNHkzQU9iZGVZK0l3SzhIYzFNMkJvdDBiTm1tK215bzNKWmwxdCtI?=
 =?utf-8?B?ck9uNU5aMFAzWld2Q3lJT0RGTy9DdjkyNktFYTcrL0NuMk1XMUxrOURCSmgz?=
 =?utf-8?B?TWJVRFVrUERKeDJ2NC9PNWxJNjNsWDlyclhncFFOcExYVWQ3RnIxR0poR3pY?=
 =?utf-8?B?S2lXV0JFd0xnN2tNOWh2MnRoS2MxSHFvRUlNcmhBdTFzYnVrbml4RXF5Zm5X?=
 =?utf-8?B?enM2SVRSNy9QbXRyVTVvTDFnQUlKVm50RGRnR3FqbHFmdEdIRG12SzJoTEhk?=
 =?utf-8?B?OEduMXE4VStLL3BsT0dCakRlWFo4aElOY2lKdHI3WFBhMlhVMWExVUtHTG00?=
 =?utf-8?B?MndITDYyVEVxb2dnNDZZZlNHck5nMnVXWU5ySVlPOW9JcGJHMEpCbmZrcUpy?=
 =?utf-8?B?RTRSNEtNYzlzTWRJQU94dVpEbEY4VzNTQi9DZ2FYalM2clZGOVRiZ2ZYb3hI?=
 =?utf-8?B?NGN0T3hjNW5hR3MrQWR2LzBxY0Fvek0va0pHN05LcW9zbENKVkl0R2M5bGZl?=
 =?utf-8?B?dm1uSWhDOENYRkErSml2V1NHV2hKTjZGaEcwRFV6TDdDSEFxMi9tNUd5aUJI?=
 =?utf-8?Q?ZxmAKqCNoF7neqDI=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	5FjoflxXueCXXHXYkFSSkvjgzUNf6X6JONuvQMOTnLNYKZU/HvaLmHWkYsIjnBlrcOr5tjVBI30f+AS/zUz7HS4JWx3nYA1FEQga/t3xE/LxXm/Ksqjy58C7on0ybiXxl6RcYOC30RkR5bQSdU+p4yWzawc6hsw7YnUAjaTvseq9TA9DPkULlAlDftD1CwJXvOKJ8Yes0HBXOrxBcB3akpJlErdis7fkhvs2RtFYXcGiVIjBXxi4w3qKSrfmkTI6DAOU7I2tNdyBpyqQoj0p6FLBIoB33LZsYxIrGL1ECN0GdykB6ml5XYzAMdaBxpp+azbM70koAnHnac4l2qw/K1i3MsT2Qe8nQrIOi7lFLVzSH9AaQhHStkDkzQsM7widztnk2D4WudkVov3zKKWX9/FmOAcifAzpQtyiysQhXVDeEdOsP/IbfYSdLzquX1uMngBxrjK6GVYoI24Il5rWqTzmw3BzHvAVRIJX8Fi2NDV4jqNfN7ARO+kDBe5bM2bqM84ZKoNX99QRyYFrMshSwuKptsohl6OrJL9ni1Sb45IoBQfy9xS6iP9EbJ/5V7C7ves/b8nTvhJo65G+ZekR/1PymrBnB4pLDFbwoJIcL8E=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6fb247a-d22c-46ff-9dd9-08de731bc41d
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB4847.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2026 20:40:22.6220
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 37UFhjt1qRu0tQ2Eex4Amxj2LbB6SpW3sqddqpwkUV7E0w/YzNnqMZ5u9WMmuWAXs9/dW5JWJFHD/wwBB3MwKb5/jX1E742iIOC46U8PEJc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR10MB8145
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-23_05,2026-02-23_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 malwarescore=0
 spamscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2602130000
 definitions=main-2602230179
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIzMDE3OSBTYWx0ZWRfX0BFniB6zew3F
 JjFpt+UJ9s5th5txnTY4TlGbK4V/dIpr7WTyKcoqfewg5D8dfdI8yhsTaTJcwHuQdSHIoLzcrHk
 pm+Ngv8yxb4PfkraHGYcScgsdnm5YIpR3ZC2c/WOE6AW2rRe/ioEgNspeZT46z/Uo9uUfdh9TXO
 bgiCxJ3z5MUos8E4wkuYkl+QZZIMbBVlx8IpxtwELCArP9xsYKocuQZIdb3iHoNq901xEgqEpPl
 fXXzL3iotZCe/TW9abyPJVNWZO4dlxYDhnmOdmkmoAA8KVwAUN8fQv2qIY6bxLFn+YPJwA3ib/q
 MtY4aOyd58PA/Wg5eV4JTkOMEWtPfqr73HhIc76yIroZZWMHFj253NXq1EBIXxiT6iA4G1ZBvyV
 XUqsX86wJum9KvmfwdPEt8MU/DELUYsHjvtimBTU0fr+ySWWNWFw/Sfanh6c7tKE8jbBM+lDzh+
 y3uIweOKHnU/6FAAeBw==
X-Authority-Analysis: v=2.4 cv=XNc9iAhE c=1 sm=1 tr=0 ts=699cbb3a cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=RpNjiQI2AAAA:8
 a=yPCof4ZbAAAA:8 a=w8MW-GEMpI6hVJaH8yYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 8w0ZRuJ0k6mPqPE_rtBjVrCekRW_MWlZ
X-Proofpoint-GUID: 8w0ZRuJ0k6mPqPE_rtBjVrCekRW_MWlZ
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUBJECT_ENDS_QUESTION(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_ALL(0.00)[];
	TAGGED_FROM(0.00)[bounces-19149-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	R_DKIM_REJECT(0.00)[oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	HAS_ORG_HEADER(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	DKIM_MIXED(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:-];
	FROM_NEQ_ENVFROM(0.00)[anna.schumaker@oracle.com,linux-nfs@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[oracle.com,reject];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 9F99B17D058
X-Rspamd-Action: no action

Hi Dan,

On 2/23/26 3:25 PM, Dan Shelton wrote:
> On Tue, 14 Jan 2025 at 22:=E2=80=8A38, Anna Schumaker <anna.=E2=80=8Aschu=
maker@=E2=80=8Aoracle.=E2=80=8Acom> wrote: > > I've seen a few requests for=
 implementing the NFS v4.=E2=80=8A2 WRITE_SAME [1] operation over the last =
few months [2][3] to accelerate writing patterns of
>=20
>=20
> On Tue, 14 Jan 2025 at 22:38, Anna Schumaker <anna.schumaker@oracle.com> =
wrote:
>>
>> I've seen a few requests for implementing the NFS v4.2 WRITE_SAME [1] op=
eration over the last few months [2][3] to accelerate writing patterns of d=
ata on the server, so it's been in the back of my mind for a future project=
. I'll need to write some code somewhere so NFS & NFSD can handle this requ=
est. I could keep any implementation internal to NFS / NFSD, but I'd like t=
o find out if local filesystems would find this sort of feature useful and =
if I should put it in the VFS instead.
>=20
> Anna, what happened with this? Even a pure software implementation (no
> SCSI acceleration) would be a win, as less space is used on the
> network wire.
> For a sample implementation you can use at nfs-ganesha.

I presented this at LSF last year, and was talked out of doing a full
WRITE_SAME implementation. Instead, I did a fallocate(FALLOC_FL_ZERO_RANGE)
implementation built on top of NFS v4.2 ALLOCATE and DEALLOCATE calls.

I hope this helps,
Anna

>=20
> Dan
> --=20
> Dan Shelton - Cluster Specialist Win/Lin/Bsd
>=20


