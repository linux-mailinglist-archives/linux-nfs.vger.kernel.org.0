Return-Path: <linux-nfs+bounces-13981-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 172C2B40C97
	for <lists+linux-nfs@lfdr.de>; Tue,  2 Sep 2025 19:56:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB04C4E2029
	for <lists+linux-nfs@lfdr.de>; Tue,  2 Sep 2025 17:56:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABDC933CEB9;
	Tue,  2 Sep 2025 17:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gT5nI2k6";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="y6On45/f"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F229F2DE70D;
	Tue,  2 Sep 2025 17:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756835783; cv=fail; b=TKwb2wjSab2pMQAn+Z35bivzuN3QCcerhbnt6B1FPzQvCCLc0NoBfxIaM2qwmwcYPdvH8u1I5zqQeiJNg3TGdeIrJv/2u0OpUqaoGdbIPBlj+AtLv4QJYplNqEGWbe3UPsiQegu/F2LdhoHs3dtWDrd5pSN1BfHwpo86VAFTMq0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756835783; c=relaxed/simple;
	bh=RUu84OS+E+rCGFlM29xbzvf5zbEZ9+6K/RWLmLxChl0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=eFmQDV2Opaqpoa14FLTXCh435jz1ZcgYhSbXerviay9DGlsut1bHtmnhxq9RTgKbcBYSNnfY0dNRfbNCjtQtjWhIaTIBU0/SpP7IJxbJxF5DlraVtTJrLVeKK3UvfQnikMogXc07iQeEBW125f06Od8amA858WciWUZkaoP6Qtg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=gT5nI2k6; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=y6On45/f; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 582Gfxwm016784;
	Tue, 2 Sep 2025 17:56:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=T2XAVHcjlyOdWu8dYo4yA9QM9XHfbHdxo2JdR4iszJQ=; b=
	gT5nI2k6LNcq9EzZcs3sqwF1VHu3VfViYz0j0jnFxXgfJdMQjMJ/6FWaB1KdSp25
	X74TG+DjHtSbPK3QbojpK7/2QzIwo16hh+93V82v/tX+7mQZyvo/4XC8GkQVYn+a
	OmHMEX0meMO0+2pfAuFVBTH3kx2mga5ruKNY4FZllRvyHuUYROPONcskZBA+EMew
	JYN9kvHFKj8Ez5GJqAkgWvOhiiSWEGlZM7+pNMCPtvSUYig9PmNs6kuBkvsC735G
	NOuAz49MTDvV5W+6uA9Kyc9Q00jJFWwor6sK9i2tuJlI/gE6kQD/KhXTLWCjEwZE
	2W4Qf+3iGFTuPnX5jeQVEA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48ussymjyg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 02 Sep 2025 17:56:17 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 582GuNVO040664;
	Tue, 2 Sep 2025 17:56:17 GMT
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11011054.outbound.protection.outlook.com [52.101.62.54])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48uqr95ns9-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 02 Sep 2025 17:56:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x/N54gr0owkpFaGLZ6E5xj2cuEYX1Hz0m0Evti92/fB0ivJL02G0o5CVJXrC70pwL3sni9Zm+j3Kr4wPzL2W2P7TB4wOn2Una3ch82CHdmIzBBQIg+Cr9dJOI4KkW0lmsYZXWuOzaWyw8Wh6s8kUmRERseWshZdhBisJ6ULqyUBuK60JGBpKSp+24zkM8OjYS3x2JyVQ2gGxlXrH1QKB/B6a3HqJ/RhZKebZ7aIavx23ecfFGwzNuNunD0ZkASwT9WDcDjp7Au2K/648iLMFtI8vZ1pqQr6DEFhRZ2dcdRP7+B2TaDW9d1ZxsW2NjxwkYN4ufeP8Xzt9XE7KrLV+fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T2XAVHcjlyOdWu8dYo4yA9QM9XHfbHdxo2JdR4iszJQ=;
 b=UkbanCuD8783OilvddJQShU3V9NoIK4bKQGLTehCbMlahvWRsU6nYEzU6XZVNAVUCmjw6yP1+xelKg5LoiZrpvOsD8Rf/H4ZpIUymZSttRiMU1Qp6L+R5txhaZIOEh7UR4rNZqGVSElt3lPicVywNz0pjr5q6GkaxqYgtH6Qj8oGGiLqKD29mmKMeQArcKAglImqYAifuPpxRSP4ADsmDnE5X2QchmdTJFurETgiDfgra2NFTLQT7JunTgvR2jAO3Hcn8LKwufyr+/sKdw4dojJrGx0shSh5KzXcI52topEi6HEfO1/e1fNsGIf57i+4ODPFKScCcaQWi9MlcAmrwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T2XAVHcjlyOdWu8dYo4yA9QM9XHfbHdxo2JdR4iszJQ=;
 b=y6On45/fyIQFeL4RpRaI6CxiFEeQCQHsCmvbhq9uXvrF7TV4RxJZyT+rJQYrZJg6QOeQVIZcyp2rTkzbOBrA35pm4eiXeQ443/UcBM6gBxObJIirM2kUDxcTAXgRiWmC6KU1UE/BTpSWFx6kA3tV1s4yLrIWL6VUXhsMidOa7+A=
Received: from BY5PR10MB4290.namprd10.prod.outlook.com (2603:10b6:a03:203::15)
 by CH3PR10MB7744.namprd10.prod.outlook.com (2603:10b6:610:1ba::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Tue, 2 Sep
 2025 17:56:13 +0000
Received: from BY5PR10MB4290.namprd10.prod.outlook.com
 ([fe80::8c24:37e7:b737:8ba5]) by BY5PR10MB4290.namprd10.prod.outlook.com
 ([fe80::8c24:37e7:b737:8ba5%2]) with mapi id 15.20.9073.017; Tue, 2 Sep 2025
 17:56:13 +0000
Message-ID: <b04e9fcc-487b-4071-a0c4-577dbf4cd55f@oracle.com>
Date: Tue, 2 Sep 2025 13:56:08 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] nfs: more client side tracepoints in write and
 writeback codepaths
To: Jeff Layton <jlayton@kernel.org>, Trond Myklebust <trondmy@kernel.org>,
        Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Benjamin Coddington <bcodding@redhat.com>
References: <20250808-nfs-tracepoints-v1-0-f8fdebb195c9@kernel.org>
 <0a01b5bb79b9cc012af310f6be72d8b7b32c18fe.camel@kernel.org>
Content-Language: en-US
From: Anna Schumaker <anna.schumaker@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <0a01b5bb79b9cc012af310f6be72d8b7b32c18fe.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1P221CA0039.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:5b5::17) To BY5PR10MB4290.namprd10.prod.outlook.com
 (2603:10b6:a03:203::15)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4290:EE_|CH3PR10MB7744:EE_
X-MS-Office365-Filtering-Correlation-Id: a1e7dad3-87a2-4428-cf33-08ddea4a0141
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?NzI0aWkrcnNucGZWZUxDZ0NwNzlxRmV6KzVhVFhjRkxKT1V0YWJNTys1WGht?=
 =?utf-8?B?OElnc3Y0eVZPTDV2ZWhtR3lsMktRUDJmZERnS3NVaFFzR3hUQjhnS0tPT210?=
 =?utf-8?B?czA5Q2kvajlvQ1dlM1VqZGFkNGhnckowTE1TYkJWc290b28rUldVa2QyV1h4?=
 =?utf-8?B?bURrVDVnVExic2RmK1p2a3VOcXJwQlZDUW9oTUdRTytqWVdBZGphaE5kV3Rw?=
 =?utf-8?B?NW02UXpVVVpreEhvYnJqZEFOR29xdWV3Ui9YeEZZRk8wVW5BdFVYak5hdjI1?=
 =?utf-8?B?WkN5T2hkRi94WThqaDN5amlKZ214NUdYS0JwRTdBRFFzN0VyU0dWUVZ5SUtL?=
 =?utf-8?B?cWZmOUJmaDZEZ3QvdFNOSE9zZXV5Q2xxYTUrdjcvVHN4Wm14S2pWaGR4dHdW?=
 =?utf-8?B?RTFISTdVRzU1ZzFyMkNrcDNMKzNEem1xd1cyaDhyakxDQ3EzOGY4MXF5UTFN?=
 =?utf-8?B?RlVrSzNtVkJRN1dvSllsWFBkaVVnbWU5R1RrdEVNVEJLbC85dDgwTUFTZ0w3?=
 =?utf-8?B?eVJCTGwzWUZIWXVobG5wWHB3am10bmw2MlZObllJTm1OelIyZjVvZ0NtMUhD?=
 =?utf-8?B?WHhrRFFjZ0FENlkzWVNySC9kWklIbDNlNWlaYlVDdXJrUHAvdldFTytGdnpP?=
 =?utf-8?B?ZGpFcUw2Vk8rT2FHNEtkZUQzUkxScVdWcWZFTzFqUFU1Y24vMUxHSmcxcitB?=
 =?utf-8?B?OWF2cE5IdnVva0NwaXUyTmhwVkd4VkRvMFFacnJYTjUzMjhYOFJTckJFMHJU?=
 =?utf-8?B?SXNtaDJFa0ovaVR6Ri85Ynh4ZStxMGhNQTNlWmtPYktaNUR1a1IvWDJjeXZh?=
 =?utf-8?B?OEZNVWNnYWlzTkMzMmI4Q2duSmxXeUoyK04rYzRuNDhSZzBvZmZ5NGlCcXFn?=
 =?utf-8?B?N3ZLa3dOTmExbzhhZU5LRFp6cHJodndUVGY5L0svejVzUWxhZGdlWm5tRnFl?=
 =?utf-8?B?ZFhyK0pmTzhpblpYMDVzSzhDL3M0WVRwaFNJOTRzanllalRNSENTdE1tMkNt?=
 =?utf-8?B?dXdZSDdKenFJQlVzb3hqWFNsbWEwV3VtSDB4bkZKMzJkMjBETmJZeTBGNE1h?=
 =?utf-8?B?d09zRGlBNCs2WGI5T0pHZmViT0Q0OE9JUlBsUlAxeVc5Umx5R2poZGFTNnpF?=
 =?utf-8?B?UWgwU2o1RklNMVd6bVNoVDdFRjNmTU9ZNWxHZ0tZOGxHa2ZRMCtwakx6Q0JT?=
 =?utf-8?B?eDd0eVVxVTkvY3lFTjlNaUZXa3dxL2dlcVFGZ1pDVm1LeTg4T0IzMFV6V3Zr?=
 =?utf-8?B?cHEyT1E4VmtSV2luZ0p4WDB2TlRLWCsxUUUzUlVZNXN5dENUd0g3c2o2WGZt?=
 =?utf-8?B?OEFKNkg1cGVaOXFOeGNRUGt5U2c3T0c3QnUyTjFsWWIvVzF6N0NEQ2hHeVQ3?=
 =?utf-8?B?MWRZaFNOOE0ra3EvV0Z5SDZza2pqejc1VW83Q25Ody9zdWVVRGxLbmtFZmx5?=
 =?utf-8?B?YnBxMjhmRkxzN0xMWkxVU1Y1d0Z5aWVOODQyZTJtV3NKOVBWajRXZTN0cEgr?=
 =?utf-8?B?TTdKYW1EanRud1BFUTdEY1JjYVFoWmsxQ3N3d0g3TC9FMk1DanVJcFVpaWVZ?=
 =?utf-8?B?Uk9QUDZHZFpnU2tPTnRqZzlxSHQ3NDltb0dkc0I4UWdxTEY1MW5QRVUrOGE0?=
 =?utf-8?B?bHlDeG5qOXFmTUJaemNSSDg5V0I0enJVMVV1cGpyc0xlQUVaa0JnQm5zRVJL?=
 =?utf-8?B?WXhUT29IWnVPQnZqVnBSZHB5Q1Bkbk9TeFhwMXFDTVBTUVAvUkRpSGlFZHdr?=
 =?utf-8?B?RE1oUFpXSWcydlNFUlB5Y0lFZUphTm9nVlllNjk3OVQ0NFhYaHExbXJkdEEv?=
 =?utf-8?B?RUhsaWI1NGxEbXM3WjFiMms3QWRkSStDUVdKMlJLbDNnMjg5dGErWkNDaThv?=
 =?utf-8?B?SEdFTzg2VEU1c3RtdXd4MkRxc3c2bzljNlBNZGhxSGZIR28zdGlwVFVmT1cr?=
 =?utf-8?Q?EgRfY4zv7B0=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4290.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?c2kyWmx4TGtnMGM0TmtOWEpQNnJNL3ZKYVRLemQ2Y2JmRlk2TElGeHBlaUlu?=
 =?utf-8?B?VVlLeEh2SmEzZ3NHSGRuZzdCM3dXeUIzWk1KeEhlUk82aXhEYXZieUN0aW5K?=
 =?utf-8?B?dHEwR29Nelp4Y0dwYWtUTmtGejhuNGhRTXFGWjNWZ0V0d253WjhOaEF4OE5X?=
 =?utf-8?B?QWx2SGRXeVYxdDJOVmNOZ3BwZ3VSS0lrb1A4cnNTNVAxMm42QTZjeFQ0WHlu?=
 =?utf-8?B?azVXZVJZQ3Fhdk05ME1DUTBRMzhCU29ucmRSVUl2ZkkzMnhIS0RPVk42MFow?=
 =?utf-8?B?RU5YUVZVakt2UkJoYTQvV1lsQVppbi9aK2tpaDRFUW1hWVUrK25DdllzUVVD?=
 =?utf-8?B?SUFZcmRudXowWEh1Z3hpdGsrazAyM2xKWW1DUmlyRGN2YURBMFZlQzFVTlNJ?=
 =?utf-8?B?MUtHekJWNXVmaG1QZWw5TllFZmU5ZEwyQlZlcWxZUnk1bWZQVExRdFFEVExK?=
 =?utf-8?B?M0xWSHBUVy83a1RQelRNa1d3azAxM1d2b1BsWjBTK0thUmpSb0Z4MXJWZ2Vw?=
 =?utf-8?B?Yjlsek1Gc21od2ZjclpERnd4NFREWGhzbzZBaDRMejF4TG9LekdxOExKbXVM?=
 =?utf-8?B?ZHR6c0trSGoxbi84TXBUUXN3d01wUU1FODhZRzdqeUNGL2JhOGlHSlRubGxM?=
 =?utf-8?B?ZjQ1MFJpYUl3ZjlFUis5c2YwTG1scnR0dlhJVEJJZlkyNVlnKzFPWDEyZ09U?=
 =?utf-8?B?UEpvekptdTQ0M3Myd2s0RzBlSXh4NzA5ZEY3MGRCa251QkJ5ei9leEdNUHZD?=
 =?utf-8?B?ZDFyU1dla3ZkcSsxWEZyUms5VGRUS2cvMkJkM0ZtdzZYbkQ4cDZPSVBxQWZq?=
 =?utf-8?B?RHY4OEJMSUpNMHRDZnFIdUtNWlNtdEJ0b1RRQTZUaHkrRDlKYXNneWIzeVVW?=
 =?utf-8?B?UFcxSCs5TkdBV2tlUkZzUHRDRURmdmZ6WTBwZWgwRS95MUV6NnpGdWFkMExO?=
 =?utf-8?B?Q2xnTkFsbndCMytVK2ZnNWZmclozZWZtd3g5Ty9qSU9kcFM5a25nWm5vbjYz?=
 =?utf-8?B?MGJjTktkNmV6Q0l1OG0zNExucE5SQkJ6RmdnYURIc29WNjVDMFBtK05zT09T?=
 =?utf-8?B?TU5lZTRJMW9CL09HdTB1ZmR5OXF5K21zSlJPQU85a1ZTWlp6bXJnOEF5Tnd4?=
 =?utf-8?B?dWlDOUhGcTU1OCtwbUo1cXFRV01yaWxaVTBTcGZVTTlCaU9KWTFSTlBwZjYz?=
 =?utf-8?B?aHF1WFJuU1ZpWHVRdFN6TEt2VnpLYTl2WHdOeDdkMHJLRzRnclFBUThGN3JV?=
 =?utf-8?B?aEtTemVDMUNYOWhkSUt5eWRrTEFGOXpub1VDblJ5WFJDM3BNYW92ejF1U1lx?=
 =?utf-8?B?UWs2WWV6cW1lZmJCNE5OV3pPL2dpT0JZVC9EYXArcVZvZER2WE80MS8yUWtI?=
 =?utf-8?B?bmlyeWkyYURCWkZ5cEhZZjZJemk5YjFiaC9SelRDMDJRQzZzMEoxa2t6YTJ1?=
 =?utf-8?B?M1BmMTBuKzFBRkE3b2R4N2hRMDlIUFF6SXVPM081V0I2Ylo5anFtZVllL2hj?=
 =?utf-8?B?U1BCQjRlNVgyaTY5L0pJTndJZWhxbldpZEMyTjhzT2VmRDBCTU9kWTR5ODN4?=
 =?utf-8?B?MkUrZGpkc05aUUNqK1RmS0ZCU0pnbERjSEVLeTlsMzh3VFcycEIwQjhoWitv?=
 =?utf-8?B?QktsUHBpSVVIZ1Q4ZWM3QWEwVEthVUo2K04xczZXWUFRMFFsSUVmWjZmaDBu?=
 =?utf-8?B?VGlMeGR5M09ST3VENUwzaksyQ2E5SnhMMG4ya0RNdVkwUDBwWEtFM2hpNEZR?=
 =?utf-8?B?TUFuZU9NS0phTWp1Wml3TUdyTHJVamlkeVNodlEyWDFVYmZIMngyTnlwTWRq?=
 =?utf-8?B?V2F2dHVnSkdDZWJLUFZjMFIxUC9XTlMxRnpaZWwxL3A2WXNwcXZSSEl6MFZ5?=
 =?utf-8?B?TFM0SmxobmZDZ2hNN2FYaThLV0tVU0FLQUFJeS9zSUtEWHYzV0dlSVNqTVJG?=
 =?utf-8?B?eGZGbWVEbmtWMDRxOXF2a3AvcDh4N0Y4OWxoTjlKdktiVHhEM0NrUEQ4bGlX?=
 =?utf-8?B?bi9xcCthRFpiYjI3V3ZxSFh4THpYcDBKUS8wS1FPWkc4TVNDa1pzdzloUmVT?=
 =?utf-8?B?OVkxYXRPVHpJS1RlNUFlRnEvYXN3WXhJc2lCM3VQTTVzR3E3eE9OTWtoZTJE?=
 =?utf-8?B?VGNxaFA3alJ1MzlFeVJCMXlqMVROK1pNazVjN0hyNWtGTUpWdXpwMVJISDhj?=
 =?utf-8?B?ZGc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	kP42fWlFQBYauVmwH66oxwFHi4VaMp/3CVcrUiv5rYfuYFNre1mdef3K/iHt7Kc1z4LHKVWNtfIRZesqIREilxrbnTM18iU5olYcb4cRef+PbOP28i4VTfaxsNkiNaUlwm5ewUS+E9fYp05bIZA2RlOClZDkU8xUZLn4WgXOEFnjH1uwCc8kgPsh0MC0VapGZ/1Zt68qe72SjfpWe02kST7XIwZ9NtFaYZrRvnjqiZvASs3vdFy0HMi9AXhLjylF/F8M/kVRHUc7Q+/bgXApXPUdso9y+i9QWPs4KYnAdFW3bPLNZKIzYaJLOApKosU/K3u+0vWzwZdOlXUk85sFq8khwOJiE9802SQrEAcE/jZmea1pGyBNzAuUrhD4whU2H/wpNJTTvVMl6CB2kdNc0cD2Bcxot4jn611G6wg/78vtlVdhPgr5lQ/hXKXeMi4JvQLckxnQPSDIQ0r6Sj3tMjzW3X0ygbyp3agAhUOSgCHjG59vCvLM+uhpdBUPIZMc2W2EorI+sj8jcp3RRVEg1Ni9nkurj4pulAMPhUgWonFeWtywOiPga2+AXfQFyn89q5P2W1y+GmdGCNK4GjbIMGLUVppHgscn/U2+oSectAw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1e7dad3-87a2-4428-cf33-08ddea4a0141
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4290.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 17:56:13.1492
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j4TV3UnsYcTJCFr0mADcQ+2NBEkHuBq7nUaD2xJ/n2LsmiuSy3mc0IcxautnFUIK65hHdKul6i9HsCfkqujorgR6Vplu6eVo9NwlelRWVK0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7744
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_06,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 spamscore=0
 malwarescore=0 mlxlogscore=999 phishscore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509020177
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzNCBTYWx0ZWRfX4hnDyri1TRGy
 /X69tH3VVSegWE9A7th+5SgmSpm169WWGjry0lbpI2kADpCvxmwmEdLidkqZYc+gJfRUq60fCjH
 LGFEQoa8TaxBHKaQa0BSszIoHU03w+qduJIYaemUp6JyAwqDr6yIQRKX703C8KeVsGzsyuyiVKA
 2rNBQaBmGa1KuJVwOaBfbs4Sl7FOf4s6pOUQD64PINvXPrPBdBxl1cxXgtv9zrKeAT+AaomvjMe
 eCLLuMZ/ly+OWwvBmw+ScDsZUIFG/nWB4Kh4+oObW1dNAbDtTmHYawbXrRA8dII35tO7j5lepFJ
 L1OJVJPuW0Plija1zAA1TNPcI+ou1Z5gkOCQxhKNDvkIBLZTqRqvuacsut7NriqkXVxuLt+46dZ
 G/9W/8os
X-Authority-Analysis: v=2.4 cv=X/9SKHTe c=1 sm=1 tr=0 ts=68b72fc1 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=F-IAakfFrwKg0LwurbsA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: xUH96Zv4EcUpuMAlqyN2oQdK9dNGO8cd
X-Proofpoint-GUID: xUH96Zv4EcUpuMAlqyN2oQdK9dNGO8cd



On 8/29/25 10:45 AM, Jeff Layton wrote:
> On Fri, 2025-08-08 at 07:40 -0400, Jeff Layton wrote:
>> This is a pile of tracepoint additions and cleanups. Most of these I
>> plumbed in while tracking down the recent client-side corruption I've
>> been hunting. Please consider for v6.18.
>>
>> Thanks,
>>
>> Signed-off-by: Jeff Layton <jlayton@kernel.org>
>> ---
>> Jeff Layton (5):
>>       nfs: remove trailing space from tracepoint
>>       nfs: add tracepoints to nfs_file_read() and nfs_file_write()
>>       nfs: new tracepoints around write handling
>>       nfs: more in-depth tracing of writepage events
>>       nfs: add tracepoints to nfs_writepages()
>>
>>  fs/nfs/file.c     |  20 ++++++--
>>  fs/nfs/nfstrace.h | 135 +++++++++++++++++++++++++++++++++++++++++++++++++++++-
>>  fs/nfs/write.c    |  22 +++++++--
>>  3 files changed, 168 insertions(+), 9 deletions(-)
>> ---
>> base-commit: 0919a5b3b11c699d23bc528df5709f2e3213f6a9
>> change-id: 20250807-nfs-tracepoints-f1d84186564d
>>
>> Best regards,
> 
> Ping? I haven't seen a response, or these in linux-next yet. Can we get
> them in soon so they can make v6.18?

Hi Jeff,

They look good to me, and I'm planning on taking them for 6.18.

Anna

> 
> They were pretty helpful for tracking down that pgio fix recently.
> 
> Thanks,


