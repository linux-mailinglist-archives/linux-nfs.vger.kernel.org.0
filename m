Return-Path: <linux-nfs+bounces-21996-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cApMDNtOFmqxkgcAu9opvQ
	(envelope-from <linux-nfs+bounces-21996-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 27 May 2026 03:54:35 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 888265DE68C
	for <lists+linux-nfs@lfdr.de>; Wed, 27 May 2026 03:54:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9FEA5301C581
	for <lists+linux-nfs@lfdr.de>; Wed, 27 May 2026 01:54:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9ECF1F37D3;
	Wed, 27 May 2026 01:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="EiSvPoyu";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="UvEor8WP"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EAAC1DE8BE;
	Wed, 27 May 2026 01:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779846871; cv=fail; b=kIbqHG5zgOM6DyRBZBijNtksBKk++8mq1BjkUUA7ZXkieQUOUzMBWFlWWYgpOsYuMAiY9vAcIqtklVDwsBKbvtXGI4ntZlK3cA3S5yDJchl22BHQ3IPRpFJHsnOHiwYKopEK+umBo4+V5zByKcGftSKVYn2WMRLXnvEOfOIWviU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779846871; c=relaxed/simple;
	bh=c6GQsc06q1hYOEgcLtF4p0jyYZjZvoZt8vvfwdLqa9Y=;
	h=Message-ID:Date:Cc:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Q7fCDA3pnpCJ+kzVfoEArWCeegIl1PvJ/6kTiXWXvgwy3r6YcnqfglAnzL46b4BYxP6+DP1nn+k7RgwA0obEgaXVOFxTLILyOtpq5DEPsgbzXDNS0/fFOo9NJG9Dy/qS1jXJTRl8hlBn7g9fP3nBHrqX0d7GRR3p3Q6aPve6QIk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=EiSvPoyu; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=UvEor8WP; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64QN0Wgk1249794;
	Wed, 27 May 2026 01:54:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=X5BY76PwUrouRWUY6AJJGZCi640MSeVsFd+Klf2zm5M=; b=
	EiSvPoyu1vXPHSy6F/oBgPGzyrvGhifIlqJQaiZ1GOoDiKIpaQ+qBCHv3vZRF5NT
	b1nu5PJJ7kg0AhZb79h0eg+Dk6qqAOuS9LvpCLfo46FNQSQpysQdEUPn1VYpHZZl
	Vd7L0L1KaCMp3QBNQJJpPVfMbO0TDxHF8Z/XlH7TXodifJbROPD825sryDZ1qtf6
	uVu45q/lOFbtyUBRNhcwhn/5/QntbMiuiOuRL5e1cS9Bamae7dtqsKoyqeTy7IZF
	uYPZxJWy54GssfWpfBa3XTCrokFPI1EvADp7WEl4+JssupvR0xN7Qo27S+grl2X+
	e06cccJR2OdH/xhIpt4Ldw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4eb4sq4qte-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 27 May 2026 01:54:21 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 64R1jHxW017173;
	Wed, 27 May 2026 01:54:20 GMT
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11012056.outbound.protection.outlook.com [52.101.48.56])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4edjsd7ndh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 27 May 2026 01:54:20 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q9AnkpXwkD70PFlYgZUvhZfDLjvzQ4/HvQu0Y63VRZcAI2FLgES2ecr2v1fe59E7XXpihJ+xruyxSB+OrC9yKWiM369I8hiyyWMOb1fZOFY4H8irH8lNcyD3q0+uII9dsVf2l7Ew+Xj7DoAlO4iQV7LOw+Z5v/ROxl9n5UaUXa0qUp9eZpb2S661SirNRPHUqtLPs445vZSUkFjW8gl2VsY7wl3ypvyDXCEjMIHbrOHZlDLRq/WGQ/vvk2/qGSYP14es13TrgxuuJQBZDlLYrI4Iqw97xtmthFLkB7QFxRGkGRAN3r/3yt1Piq2hR42d7ffZ4E9uwEycWytWftAO+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X5BY76PwUrouRWUY6AJJGZCi640MSeVsFd+Klf2zm5M=;
 b=Z+70KDlP15G9M3g1/4sHG/UZQRckBV299+CHGsMRgX+as9CxFL0ZgLza0n1XXba3GYOVJksvAxG5TuB48LaSGGtEvEmxKzivAqisgp9eQJnFnnFiglJTiwnNRY7jqDwyobpUykgVlbTpiFLdf1X0fODJGXujm4/CrMA4KNuXP+XyZ+g0AL0ilcRvQ/ZuAwXbYHJTf/BstQPNm2BErPVNf87/VtZdjeVkjvuJCYy7kPdHCbQ66fO6esgW5gsJTerZ1ZK1bMU5LXt4Pjqc3u6hx1/lrXhGWNe2VIbTemUBTsrT9ZCCp1liqAwTg/1ctn/nG0+avrUNPFP+wjTTWl0Jzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X5BY76PwUrouRWUY6AJJGZCi640MSeVsFd+Klf2zm5M=;
 b=UvEor8WPUKZxbRuD1fUgoed/v+1TdpvPy1H5VGnjkdkFYsdMx38UkGCVMknhsUDlZIy3Br5K7VpuiLnZ9IjJ5a9+AGKS7B8cZulfeFc+gmDPYlOFGsRcjivtrIaGlVJ1Pd5X1JehjeHXPy0oWyOylhep+det8O8f06uyZWy8ZQE=
Received: from BN0PR10MB5143.namprd10.prod.outlook.com (2603:10b6:408:12c::7)
 by DM3PPFA927664FB.namprd10.prod.outlook.com (2603:10b6:f:fc00::c3f) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Wed, 27 May
 2026 01:54:15 +0000
Received: from BN0PR10MB5143.namprd10.prod.outlook.com
 ([fe80::71c3:4ee5:93a1:85e9]) by BN0PR10MB5143.namprd10.prod.outlook.com
 ([fe80::71c3:4ee5:93a1:85e9%5]) with mapi id 15.21.0071.011; Wed, 27 May 2026
 01:54:15 +0000
Message-ID: <36507d23-abc0-423d-acf9-573b13a2a135@oracle.com>
Date: Wed, 27 May 2026 02:54:12 +0100
User-Agent: Thunderbird Daily
Cc: Calum Mackay <calum.mackay@oracle.com>, linux-fsdevel@vger.kernel.org,
        Miklos Szeredi <mszeredi@redhat.com>, linux-mm@kvack.org,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Chuck Lever <cel@kernel.org>
Subject: Re: [PATCH 1/3] tmpfs: simplify constructing "security.foo" xattr
 names
To: Christian Brauner <brauner@kernel.org>
References: <177945382308.2991556.1256192774754909984.b4-ty@b4>
 <5386153f-9112-4971-98fc-de90d7aae2c6@oracle.com>
 <20260526-ablief-demut-wehen-aef8446ef5c9@brauner>
Content-Language: en-GB
From: Calum Mackay <calum.mackay@oracle.com>
Organization: Oracle
In-Reply-To: <20260526-ablief-demut-wehen-aef8446ef5c9@brauner>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0118.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c6::8) To BN0PR10MB5143.namprd10.prod.outlook.com
 (2603:10b6:408:12c::7)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5143:EE_|DM3PPFA927664FB:EE_
X-MS-Office365-Filtering-Correlation-Id: 4136f051-1fc6-49a4-d946-08debb92db5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|22082099003|18002099003|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info:
	eJTzoNqy0qawdUf/htgJQL1vSHfqoXPcxwOK1zUMUE4XMiM2PI+lae6aWzgkz7Cx6bE13Zz4xL+oyOryzjsRZQXMQE9KbL+iT32M/S3Y1ma+FM7mI+ccCMabhz39VhYfKGzxXEP8ILzdeKkRCmQoAP32CmIwfmex4O+3FMepxMGezJc0uDcaYXrVtq5ZKhkXajZ9ypGlz8LbVLlWxWqnZ1emwaGhrisyajH3VRUX7lFnllVSyzTWbY60wRWqCBR/3a/pChyh34c2bUZkt5GfQ37JsW+ghXVF8TTUdwo3RnfQyPqME0WUTirWiOrNnTAYaJWmIwfZFYRd+zCSVrJEBSPPPYB/xt+aQp1jAlwplxI/nmZF014vLOeqnK+D2ISiCAm7ZtasgkjoqKJrAfKPwHm5DR+eNBzE/IXxMhGU7w0zXfh8JSsXtGDLZOIDVXxLp512BucaSx+RZhZRKcEz9m2NGstYAaYDRvmf+ergMc2hqaYxkuWwt0F4rYsS0q9ZMT7hA7k6C1WLkbPYNf8znjDURmbrJsN0/y60X4qFEbxnztRbW2Cm6uqNxEgaH91PO1iG1vQYxeUwjZa1a+7EvnZdv4nhQPpXvb4bWNQID6NgP8eiDKmbs/L715barA7tQrfulcS2twNl04D5l32LTxrSJbiRq2iqcPqTZPi2ADz8bcRyKO0fTGTfnUX5L4g3irdcY4CqcKkLATE327nupQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5143.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(22082099003)(18002099003)(56012099006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YzBvUWRIaThTQ3pKSWtsanB6bnJjMDlrZHhDYkJyVHMwSlU2aWxtVGlNME1k?=
 =?utf-8?B?L3FuQkdmYjQ5QlNNUTQ5aU81cG4zV0hsaGMxOVlwckVDS05oS3RZSVlKTGht?=
 =?utf-8?B?K09JejVEZHNpRDYrd3M5RWM4TC94N0c2Y3pSOVBGcTVTM08rbWgranFhT2Y1?=
 =?utf-8?B?RlFBZGVKazZ4NUFGb3dqMGRwdWptVXJXZDFXSjVwU2ZxcGNGS2d5T29lOTg2?=
 =?utf-8?B?Q0hCVUFsZEI3VksvVCsxNlR1cmtqTHdJMU5tMUlST244TnZEUjdCNlI4U0ZN?=
 =?utf-8?B?MC9FNlFmRzZoVGZxVlN6RmNJUDFVTXc3NkZTZmxoYk5oZExaOFBhZ1lUV2pJ?=
 =?utf-8?B?NXpVeTEwTG5LZVU2eUxKU3FXbTJJaVg2RjgzOVlqT05odlcyQUloTytUTWxQ?=
 =?utf-8?B?TllpcXJab3dieUZ5ckVnWHh0VFJlRUpISytKMHBjZWVDdGxwY3NMVmNXUk1T?=
 =?utf-8?B?YXNBNFEvNXRrcXZFQ3NPOUNtTHNVSHllSlo0ZTRIeXdJRUYrRzBmdFZNam1B?=
 =?utf-8?B?cXlWZlQyR1FrNFlmaFZWQ0hGK2JQU1duc21WTjlFS0VPR2ZKQXUrL1JjUW9l?=
 =?utf-8?B?ZFNwZmVvN0NpSEpleDZRYll6LzZuaW1IVnRKQjlsNkFTMHU0MXZudVBVMkZy?=
 =?utf-8?B?VlhqSEpUREpTS3ZjUFp4WW9VZEhwSmt2VzFsdy94N2lsRG42bVJRRk5qQ1lZ?=
 =?utf-8?B?UktYOG1GQmFsTjd4VTNXVjhvY2dsQ1o0LzhXOWY2WlpPc3N0SWFoWkVjeWE5?=
 =?utf-8?B?ZXdYMTU4TFlkZUpmeUphMDdoRWxJQnJGbzM5OG96LzNRbUhtbHUxS0kyRUo0?=
 =?utf-8?B?enptbUR1WFVtUU1MUkRDd29kcDlMZVVZYWZ0TWN5YzZseDdIVmxOWnNTVzFV?=
 =?utf-8?B?TkFhOXJPR1JZUFdZZkZ0SWkwR3lYaGZqdkZudjhqRGhqTXhIcmdMcHk5MWMz?=
 =?utf-8?B?MFNpbzVBOVFOUGhaNzZUYnIvNlhwclVta2tNK3dBNHN4L0VLV2RFelpvcFdl?=
 =?utf-8?B?N3JYVzg0a0gyQS9yVG4zK2ljQjliRFc5Y0kwQ2laRUpoLzJ4VGZKNU5MNSts?=
 =?utf-8?B?M1VnOUZvQjdNd1Z6Mk5yeml5N1VFZzBaL0hVRlhQbTFCOGE3QUUxUWRQT1RL?=
 =?utf-8?B?bERNMVFMSnZPMkI2UXhLT0c4M3BCV3JiTlV0TDBQSlpWdndaOCtGUDFUWTQy?=
 =?utf-8?B?V0tOL05ZR0E4dWpwdmpSTCtPWU5DTmFXd3lOSFlXVkJuT1QrUGgzZSs0ekJC?=
 =?utf-8?B?aVVoZkhPRnoxaE1jSjAwa01Wak01UEQzUjlDaDhoaEhTaGtPU0F3S2FXRWpZ?=
 =?utf-8?B?ZzNIYnQzbWxQWmFPbWo4aGxaRmVGKys3K25iUWZYVGJCMUd6ZlZaODdpM2VK?=
 =?utf-8?B?S241VmlEb0FRVGVWMnQra25FeXlHTmNMUGYrMnczTWpLVWdDNFB3d1o0a3Fu?=
 =?utf-8?B?dWpnanBlMjVBeFBjeEJwdkJadFh1SFdjbElNL0Z0L2VXS0VBaEZlOVdVRm00?=
 =?utf-8?B?ZkQyMGxXdXgzTUw0dHNZQ3lnMzZzQWcwMlJJLytQWUtDOGNQYlRTeVJVdUlQ?=
 =?utf-8?B?ZTRXc2M1UDJ6VFZxVVJNYTU5SHcvd1V4RGVJR2dEMlBaMVc5UnFSU1I3dzEr?=
 =?utf-8?B?V1BmSEZzMVZ5aXFoWDFSdndMQkRKSG9ZVUZPcWhXVGs1eDU1OVV5NGhtZTNt?=
 =?utf-8?B?TjhsZk1JQ0F1dWNmZkZPNlkxNGtEYmhBcC9TS3FySjhEV0RvcWN5WExrU0ZP?=
 =?utf-8?B?ZnlVa0lhUnVySFNLdjZYbDVOektxQkZVVjZ4Rm1nN3k4eEpFWUhJeUZqNTNE?=
 =?utf-8?B?TFBwdW5HQ3M1R3RZVlkrYnZZOFpMaVpmUVZWKzR0ZFMxeEJZWmFYbmtmSWpR?=
 =?utf-8?B?Y0JZRVZmTVh5SW5LOFdWN1QxeW5MNDZRbVprdmlORTdZY3g4R0hScXJ4bkhx?=
 =?utf-8?B?RDlkc0xna0tkaHB4YW9tVEJObzNsUkpONVc5TjBDVUVWa29MOFk0L1RxR3BF?=
 =?utf-8?B?U0ZmWS9xR2RKY1MwczVyZzBLYTk4VDhITUdVOUg5ZytadXRDdnA2ZkJpa0RT?=
 =?utf-8?B?OHVLQndWMUp3YlJ5bURJcDd3eGVENzVSWEZjbmtXR3FEd1NKZEZFaGF6K2Qr?=
 =?utf-8?B?Z2RkbUNvellrdVQrKy95SlJycklKNnhhY05kSVg2bExaVFZONlF4emRDL3hC?=
 =?utf-8?B?Wi9uSHdMRUhvekxNYU1UNEJwcHZUYy9IakVOeklQWkdBMTZUSDdyZHoxT2g1?=
 =?utf-8?B?U2tRVUJsVXpzVHBEUGVHeTg1ajBVc1QwVlNydjFTUElVQkd4bC9tVDZRYlF1?=
 =?utf-8?B?WlIreDJ6bDBoNHM5S0pSRVhaZm1USGVRZnhubzd6VFpvZS8xbGozUT09?=
X-Exchange-RoutingPolicyChecked:
	RLgZW7iMo/KYzOOGeBG9ae1wtcg2Q901NvoKW7JITBsuhpA0rILxPIAXyW9gMOeHa2HYtSkT0LiRRVXaTPCsuYb2XcFsztg85qV8mrPrN8ilQkirNaJnAPABk/KWPEzImqjkaFYoRjPphD3ewoFQyhjVIw7teOCvsrOZUfVMhKr0vFJUZs//Aw1SN5kvr6paBCdQE74TkLAz8RILH6OjWwhTPnKKr3bhnc8akPQuCwhBwWygXY39aY7VAByXGY7nP9/IE4BF/q/W89Bguvuxfd7CotlGz/+ftWEmFAQXCBNzGiNOFQwItys50UDGNIeOXYDDquNAd48W/TBT+8IQ2w==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	uGlCaUmGqaXpKo31mmJJ5Gz9QFuvkvqTkWJTAC7AOkWcX7thPB52CwEbZbpaoB6wQqBHPP3Euuff3PEZtxyvkThwvJ7aw8cx1WZOYo2OEiw0u9a3rWlB+dcmpW3M5TW6sHHEEi+WzrRSy4WPBCe5F8bwQlutHLi/XAJHvhDJLv3ReWzVlXS3pFCc32r5+RorQTSwQCUCmtgxjf/bF+lMyCGnYZBPm8x5skPFZiu37CvIRo3EmW8PXgwlxZgVn6Os0bRsucIVNIMZZsYAWz/Uf+bzhJGa/eE3+nPoAbgaEglvXI8Hd9UP+Fp8wyDOodUcNRssGFXeLlZ//Oy98jIc7sKIqg3iGIh6UyQD2Qswy3Y+aMiQMksYqgg0mAW7rzkyA6gaQBqHjENW5cHTFDHltT48WnSYoj0rPWS5Wpk72vM27AFzRq/rpfhL2gqeKDxCmqv+FuO43Oe0v5aZ95BeQGIThkzCC1sU626ArH7NJhAQCUBD2vlIMmRZ9HSfsjPSw8O+/grbmLYcZ7oElUZa+9hAoib3T02zgNs+ZEsGvalc9/HKYyAEDtQei1Dgv3/jp4qTaKkkFpcCS22dw6ouH6COJaEiF02O7nMY+H0NjCE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4136f051-1fc6-49a4-d946-08debb92db5b
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5143.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2026 01:54:15.4803
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IkMXGq2gFfKD/NQPRUfo7FQXjU/Tjddfd3mZEJnGbNVDkiUoeYdUCMqa7q55Jk89P53HbtD7xN6QN4//1TS5tQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPFA927664FB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-26_05,2026-05-26_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0 spamscore=0 mlxscore=0 adultscore=0 bulkscore=0
 lowpriorityscore=0 mlxlogscore=999 phishscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2605130000 definitions=main-2605270015
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI3MDAxNSBTYWx0ZWRfX62eexP5+XcQE
 Ph6voLm3vDyc3TipHDrhYWSMiDdRjW8LRnmPH7rA7TDxdRKY2vWGicbIIclWb9Vi8k+v5yh5C5p
 8W3ZVsn5gnVysRJETtnswe4FenhGBULNVPixukCIybeDxijhLDT6Y6T3JDxoGcT8xJz04+9DWll
 0aWYy0QQXK/gUvQTmIGhCuOBf5mvOvrPStxUB+OHoGzBI7vWdcZK5/HcZ6uYqSIoOoRIZUt3Wep
 p5WuMlk655jUoUShKUp4Q1PevCVm2jZnRdyx9kjE27GQEPu1QNtMJoWhQ4ttTYZagO/RTD9HtYf
 YcyHXTvjHe5xxvvF+G/W/rH16zvJziTGpgPG/F/wJ5qvf2mQ6JXK4aJELxFLShzYcJq5YhKNTga
 Q7dRw0H8aEMEt65cqyQ7j5zfsyeL4IggrcB1lPxoyMD8FhLj8UzfvYRd2kcGuS7CfUj606eecFO
 BW/Q6OMOGnY9y72qJqrEkeu9xBi3uqR948SrQUaQ=
X-Authority-Analysis: v=2.4 cv=eNYjSnp1 c=1 sm=1 tr=0 ts=6a164ecd b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=7Gl3-_t3PgB9XO-mQDs3:22 a=VwQbUJbxAAAA:8
 a=yPCof4ZbAAAA:8 a=I1Lp5SrqLn6HXeg9KFcA:9 a=QEXdDO2ut3YA:10
 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:13706
X-Proofpoint-ORIG-GUID: ziyOcZ7fm8DSz8mqlhV3tlzDnMSw-oA8
X-Proofpoint-GUID: ziyOcZ7fm8DSz8mqlhV3tlzDnMSw-oA8
X-Spamd-Result: default: False [-0.15 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	TAGGED_FROM(0.00)[bounces-21996-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.onmicrosoft.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,oracle.com:email,oracle.com:mid,oracle.com:dkim];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[calum.mackay@oracle.com,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 888265DE68C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 26/05/2026 10:01 am, Christian Brauner wrote:
> On Mon, May 25, 2026 at 04:59:02AM +0100, Calum Mackay wrote:
>> hi Christian, Miklos,
>>
>> https://lore.kernel.org/all/177945382308.2991556.1256192774754909984.b4-ty@b4/
>>
>>> Date: Fri, 22 May 2026 14:43:43 +0200> On Tue, 19 May 2026 10:13:21 +0200, Miklos Szeredi wrote:
>>>> tmpfs: simplify constructing "security.foo" xattr names
>>>
>>> Thanks, this looks great!
>>>
>>> ---
>>>
>>> Applied to the vfs-7.2.misc branch of the vfs/vfs.git tree.
>>> Patches in the vfs-7.2.misc branch should appear in linux-next soon.
>>>
>>> Please report any outstanding bugs that were missed during review in a
>>> new review to the original patch series allowing us to drop it.
>>>
>>> It's encouraged to provide Acked-bys and Reviewed-bys even though the
>>> patch has now been applied. If possible patch trailers will be updated.
>>>
>>> Note that commit hashes shown below are subject to change due to rebase,
>>> trailer updates or similar. If in doubt, please check the listed branch.
>>>
>>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
>>> branch: vfs-7.2.misc
>>>
>>> [1/3] tmpfs: simplify constructing "security.foo" xattr names
>>>        https://git.kernel.org/vfs/vfs/c/aba5853b137b
>>> [2/3] simple_xattr: change interface to pass struct simple_xattrs **
>>>        https://git.kernel.org/vfs/vfs/c/1cd9d2387c05
>>> [3/3] simpe_xattr: use per-sb cache
>>>        https://git.kernel.org/vfs/vfs/c/12e9e3cd03b5
>>
>>
>> I have been doing some testing of Chuck's nfsd-testing tree, which includes
>> some vfs changes.
>>
>> The test systems are reliably crashing, in what looks like it might possibly
>> be something related to these three patches.
> 
> The appended patch should fix it.

Looks good to me, thanks Christian; no more crashes with that patch.


Tested-by: Calum Mackay <calum.mackay@oracle.com>


best wishes,
calum.


