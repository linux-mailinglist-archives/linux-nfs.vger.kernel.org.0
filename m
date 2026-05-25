Return-Path: <linux-nfs+bounces-21908-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id nYEQACPJE2qHFwcAu9opvQ
	(envelope-from <linux-nfs+bounces-21908-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 25 May 2026 05:59:31 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 416BE5C59B4
	for <lists+linux-nfs@lfdr.de>; Mon, 25 May 2026 05:59:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 28FDE3006B3E
	for <lists+linux-nfs@lfdr.de>; Mon, 25 May 2026 03:59:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 623B62D8DBB;
	Mon, 25 May 2026 03:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="pts41oOK";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="r5wEnEe9"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F291429D;
	Mon, 25 May 2026 03:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779681566; cv=fail; b=PT2Nn7joLxl1wwbO3SzQSV6Zz3zbPN6jip7VD10mdyN+EoMdvqElQyhLBDXPZGnr3xIveFNHBIQMUJiTBAeX1PZtMxhwuN2isplJwncLcFCUnIqvouZuMPdz3LiMIS4QQ5pqKASEzcgsH79EH8DjBuFscsPc6XePW760M47aSPo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779681566; c=relaxed/simple;
	bh=A79Auqde8XhMf8Nr5msTMBTjyRVUHBzVyYj4E6nchcg=;
	h=Message-ID:Date:Cc:To:From:Subject:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jWhK8GxuyQC1Qfv5+ZNvmRbafehq46KEq78ZobqNhYseCAi4Wt7olM5okJJdAkeuAWTde8N8Cd0ssTQwQpCfRqY3VVHl6+WD58OBomAKMGH4gzhrdSJoz9jyOIg/NVJg+Pt+gksxzdf9MT/81OGp+NH0IM7nIX1HqbUaH14Dfpo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=pts41oOK; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=r5wEnEe9; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64P2deNS1696193;
	Mon, 25 May 2026 03:59:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=Af5i2tTDtHwugOMbTq+z6fhcaDpRtSUnrfbn/PDvRR8=; b=
	pts41oOK4KniejoARMZFHmPcgg1KWuOCN+5zC0Kmo/jHupfAJv2XP0f6fasZHStb
	shKDP1abSqmU7Y+AiLgGGU7xNpSwC9Qa6FT3/LUQUJPR7W29pw+rvFpgOE6kvA6Z
	kKJmTgYZoQCXC0FdbT/+v+zBqkbCzjexkkfwCr2d11NmIXzlym+j96d4nWbsfdad
	bBz05I2glZBIf9HWFoYnI7alzAerWEpuax10STgCpaAG2o4bZKlFFbdGVUO0kMDl
	KoXbsIGkxYy4ULypDuO/khy2M3PL5ra2DfwR2A01OW9H1osotr889/J8A8OQmQN5
	UwZTXjhuU4TIXAzTr1n5QQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4eb49cj0cr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 25 May 2026 03:59:14 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 64P3sf7G031340;
	Mon, 25 May 2026 03:59:14 GMT
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11012004.outbound.protection.outlook.com [52.101.48.4])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4ec0addtjp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 25 May 2026 03:59:14 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EF68G7odexBUG9O1qcqXaxBCIl29MiSOJlAFaAHz6RTdiHRNYP94z7+T8K3f3tsrkfgNl66aQ3ptPbENdbuRPjD3uN5ZqUQoM1HH7c62qQP/vtGhSVjCqNGs5eY3ofTauuBqh5P3pHJ+vvHVHNcdw2xss9nU+VnqH6X/3ZPH5+CfYTrf2tzvPaUheiz4+p7U82tKdieECKeWykRb9GvMBHLiSGrW9STlifVW1Oi1x/g5MFwWQMDPq/cd0i8EUrEXkhFTG8f1q1ehnDkW0TLOlfelUT0D6hWri9nY0iqugd71imfvjatw1E/p4lvuPL9R49ceTZ0HwOcHnK47DIUmjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Af5i2tTDtHwugOMbTq+z6fhcaDpRtSUnrfbn/PDvRR8=;
 b=c14q7uvvfdggfVyB52zyxheOCBoLDEHBlqqYTffO+T3WxfvYkJRuD/ja+uM1qQbnAzKi5vz05vt7MEz1VySun4bsV7efUHKWcz+1qlRa541fViXIBNdu6CISIJVU5bM+91cgsk8MJeuYbWyZCxxzP4qIGDr/RNY7gMksgc+WkT+gmjEMuUiiWkXttX6t4rv72ZnzXqkWqThiA/zWRb9XkLMIohcwuRxIWDF6gcwrKoQaN41GQgQe4lc5edljohPxgFZWrSStmsfZHf4E/DhSNrjSH4+s3zf/vT3rjODFY21WmL6O1KedQxAec3sDRDI1E0wIPuNSmkm3BreSKAypJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Af5i2tTDtHwugOMbTq+z6fhcaDpRtSUnrfbn/PDvRR8=;
 b=r5wEnEe9Oq38kv4BAS4qzv704WS6xgp4rUm5zre5HM54pDDU3/htMA1TYEcguf4c2OoETuMfdtIBzeojD0d5rV6bdivwRMh8iBzTFjH6vhpif2L+i2pG4oqAOoco8nHJuW/Jeeu0tCwbfpJ6rv0fix6WumiDbHkUyK5zYfmTwUw=
Received: from BN0PR10MB5143.namprd10.prod.outlook.com (2603:10b6:408:12c::7)
 by SJ0PR10MB5599.namprd10.prod.outlook.com (2603:10b6:a03:3dd::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Mon, 25 May
 2026 03:59:07 +0000
Received: from BN0PR10MB5143.namprd10.prod.outlook.com
 ([fe80::71c3:4ee5:93a1:85e9]) by BN0PR10MB5143.namprd10.prod.outlook.com
 ([fe80::71c3:4ee5:93a1:85e9%5]) with mapi id 15.21.0048.019; Mon, 25 May 2026
 03:59:07 +0000
Message-ID: <5386153f-9112-4971-98fc-de90d7aae2c6@oracle.com>
Date: Mon, 25 May 2026 04:59:02 +0100
User-Agent: Thunderbird Daily
Cc: Calum Mackay <calum.mackay@oracle.com>, linux-mm@kvack.org,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Chuck Lever <cel@kernel.org>
Content-Language: en-GB
To: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org,
        Miklos Szeredi <mszeredi@redhat.com>
From: Calum Mackay <calum.mackay@oracle.com>
Organization: Oracle
Subject: Re: [PATCH 1/3] tmpfs: simplify constructing "security.foo" xattr
 names
In-Reply-To: <177945382308.2991556.1256192774754909984.b4-ty@b4>
References: <177945382308.2991556.1256192774754909984.b4-ty@b4>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0058.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:93::9) To BN0PR10MB5143.namprd10.prod.outlook.com
 (2603:10b6:408:12c::7)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5143:EE_|SJ0PR10MB5599:EE_
X-MS-Office365-Filtering-Correlation-Id: cf9572c2-989e-498a-7265-08deba11f729
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	rkDU7QOLkpPniUKKVR1c4f/GpyGjmyKVdtaP3KdQF6DZH0/bILD/f8rU3YOLXRQp//O5/PuQCqEYO6HJ4TfYlXMm7FwPt33niWs7y0bt2rbckeh2kHT0UafrMxo2EiE7TCYPH9CnVy6mVj8+Nj3URFa2+PgMKZmj6GObsHO7Z0GC6qcQ0WE8OMnZnKdk7MZxQdcmO0uAC1HP4tI4G4W4JrzVZX3R3WIflg5NkSwohBYXi1EBOh+iDil0Q+VYHjIBYFmVRbYvkYHezpq5XDkFJW9c+5EyMgsVpAd6zdZc9P7T7dexLJ7rGIhzNUt76m4FqbBIIF9fO+8iKjy1fQgr5DCe0k6UJ21btpLgcv7mjgLM5ZprQLzDW1BUpHmM4fvEoeuJGcvOm4YrGg0jaX899cjYWa4VvTV/9UAQfLCEB42k6Vjlz3of5eQL94IdkHzuBvew6A+ZDXvQMAQc3HXUkuZRhdLuvQn57ZM5DgTsj4IQWPDIyv6HPdFqE0GXgjnIYE3CtYWtaTB4kj4NbcDaZTTWFsxQVloOVQJvoMhKQpuuCxzVTuCEnzSyaPgSez78Pyp1zdxjRFNFANusxVdfWSfhzDdTo9VkiL7stB+oR3fVvX53F+RW80i4NYUmf4i8KfHwX8oyxkflt1M1+O0WDNmByDBjn4ZRvgy8KwCwvu1l/2sl+y3d/cAcMzKhvNlQiaQ3gQoMS1pekqnFBQ+Arg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5143.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T2lBaWhXK2JHVU1KcTRoa0Q1S0hWeXo3MzRRSTJ2LzBwS1VDQkRmR3hEUkU2?=
 =?utf-8?B?UlEveWZZSUpJSE9NRnVKZ2psMUNSbTRYRG01TUM3a3NESUZtQTBibUtSTnRU?=
 =?utf-8?B?MzJmUVBWcVNucnB3cG9xem5MdHlDY0hidVFZNERjdmdBOEoyZFB6MnY5RlVw?=
 =?utf-8?B?WkNWcmJUZjhaK0VvcTJqZmVlQ0JEQVZlZC9hSEJETzJCWGlLdERwV0xvMG9K?=
 =?utf-8?B?WDRFMjhjVUZZY1VuWW1JNjJiWE5ZM01JOERWdk1BTzVGQjQ0NCt6bTIxWXlk?=
 =?utf-8?B?UFc1YXRTUFY5eWFqNkQ5Vjh5bHlTRzZoN2Q1ZWo3c0pNc2E4Q2k4UXBUN3po?=
 =?utf-8?B?WEpEYktVY0g3MjhtNW5RTmZxQ0V0eUpCdWI2dm9lN3h0cUdqRXFXY2U2MVJz?=
 =?utf-8?B?djhaZlNwUktQblRNUEM1L21GWHR0MnRvL21sQW9SMElROFNXcUtSZS9xbUkr?=
 =?utf-8?B?aGZ5NDVzbkllL0tieDZibEhzRVBFU3V3eTBLaENzeGZKYnFsVzBsZGpkVkhC?=
 =?utf-8?B?Yi9YR0Q5ZFg5U0ROa2FKbG9sUzZuUjhsNWZyK29ENmpLUjNrck50cEhFdy92?=
 =?utf-8?B?cUZoQjBpc1p3M3hpSE4wZVlMVVRISTJ2dVhkdUpSTE9xaXlmVlVQaDNMWGZZ?=
 =?utf-8?B?aG1TRVNjTlRNb0xpY3JkRXVYOTVNSzk3OXBLL2JxbUI1Z0EzK1RrTDdGTGpa?=
 =?utf-8?B?NVhEbFdSRno5QzYzY2g1dXliOExYTXF6bDhQNDNNa2RjOE5sU1lTQUpNKzBP?=
 =?utf-8?B?TFptY29SU1dGT1gzSllsaFd6Z0d2WUZOWm5JNzFWS2lsVWYxQlE1a29ORThB?=
 =?utf-8?B?TktmalBqU0JiUlZvVlNRanZJSzFWU3VkdkxOcU9hZjU2Zmx2UUE3TXNwTDg3?=
 =?utf-8?B?VG9YZ3E2M2p0Nm1UT1dZN3B5UktrbDZsUkh2TEQ3THhwZW5aYUpnazNzSUlM?=
 =?utf-8?B?VVdIV05TOFMrcWZ3RVFta0NRUk5VU05lTHc2UXlGbitXaWtQU0grRWZOTTFq?=
 =?utf-8?B?ZUJuQ0RqZ1VsQ0ZvaE9VOVA0T1dpWWNXaUxIZWpQU0taOFIvNjc1bkVTM3hY?=
 =?utf-8?B?YllhckczbGJ1RWF0VWEyb0FXU29LYlJhd0ZBZ2hUdXZOa3VoWTkyTXJjemRk?=
 =?utf-8?B?NDhaVDFoaDNIVGJXZjVrRC9QaGNaZ3FDcmFqZ3k1QjRBSFh3VFVjc09ZS3Fq?=
 =?utf-8?B?VE9ZR3lZRGwxYXkyTzl3VVhEeFBZNmhWaG50TkdlM2NiVFBGZmtxSVY3ZVln?=
 =?utf-8?B?MmpJN21yVjZxSVovbGNnN25zUDhtbDh3UXBUM0huQS9FRFdiNUs5bTZSbWJ3?=
 =?utf-8?B?V1drc3VKd0JoT1l2MXUvM2RYOXlRejlsdkF6VERBeEZoZVROODlsb01LRm10?=
 =?utf-8?B?UnFuUE9pd2J1RGRjc1VVakdDUmRmSTF4WEpvZ2pTRVFkSW45S09NRTRLcjVi?=
 =?utf-8?B?WmFGbHRJYnBzMDg1UEwxUGpLU1hXU2JrVS9lZDZyNlRmb01xZHA2Vytzbk96?=
 =?utf-8?B?ekJ0WkphWDI4emwxeXUxMmdVQ0MyMVF3V0hKTHA3dTBzaEFGTytnaWJPNDVX?=
 =?utf-8?B?b3o3WnUxeVIxc1Ftd0pqeHpyNEc1aFZjbDUvWFNxaVlzWExNOTJ4UFVpNVpI?=
 =?utf-8?B?ait4QXU1c1ZMbEhCa1AzYjcrbTg0TUxuMmVnZ000NG9zUU9DTlN1KzgwVkdI?=
 =?utf-8?B?SHEzYVpaemZYRXVXSk0wWTFvTytsMkJPRGVMeExIVmVZWWxCeGpCMDcrdEdE?=
 =?utf-8?B?UXo2MlZ2Ry9jVHdsU0xUV2dOVk5qeEd0SGV6VkNWV013WTUxWVd5NzFMc1hE?=
 =?utf-8?B?c2ZWTGZIL1JGT210bjVRTnhTclJoak9TZklyM2szd3N0U2dwSTE2NmJzMit0?=
 =?utf-8?B?WTZBU2YwbXRRdHZ6azNWQWtXWHV5ditNbDIzUXI5ZzVPeld3eDhqMktJU2h4?=
 =?utf-8?B?VW1ERThNZTN6Q2N2dVRVRERTVGlWSWRrTU0zSWZJNncxSVY5YlJ5SG82YUI5?=
 =?utf-8?B?QWJkNmxVVUsrM2F5NVU3L1N4REVRNTRYUDlKWFgvTkk1N056NTgzNDBGdlc3?=
 =?utf-8?B?elE4TWw4ZWdJcTdxTnZ6VExiZE85SlpBdVRLK3hSWFRlTS82NndEdXNzdk51?=
 =?utf-8?B?OERna1N0Um1rU213YTMxNzJ5UExtaVhMNDJaVEdRUUxUSnNpbVZNSzZna011?=
 =?utf-8?B?cEVGRzV0QTMzMFhWdzUwL1ppdTFid2JIMTJCWDZ5d25MQzRUdUl4R3lYdmw0?=
 =?utf-8?B?Vm1Ic2k1VVRiVUtiN1ZsOU8rZjFqV2ZERjlpOXJCSVkyblg1L3FKVFNPc1I3?=
 =?utf-8?B?TCtCZThWWDNOdzJXNGdJaVVoVzRTRGRZdFViY2JVRmRyLzlpb3B1ZVQzZGZ4?=
 =?utf-8?Q?XgwfZA6S5EuNFtzw=3D?=
X-Exchange-RoutingPolicyChecked:
	ItLLA4s3PIs8Ib6ypFcdX8npXDFkSdV7v/GqFqKSwrY2iumPmluYerRIJFiOQdXwSz2ExghUgqh+3eGT4XXq6CY2j3wOZ5UEmis5Kt/ykzfXmDx4SpM/svP4siQTtR4Tk7ib/SWNfuR8aKV+Da94Ir+xNUcqVzbcOXKPbuMPsiJsWEksBULcRalG0ta34BY66c4/6lIykHLPNWZDkkL5CTE7iGh3N2FcyDLCA/OpjvXIVN4CNtRAmcEsO20b6RBaBlti0wPvgM9ka7wo3WvYTJh0s4TDin/rj0AoWsmeU/RktPr7M0ECwabOCGUuxRRPseqpgO8lPXXhh0/PQNUhkQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	i+SYMKjKoHRgnDQPgV+HrL7qkbnQnNb9vUCTS9H0D4MtFZA0ZV0vYpxjHdIpavjV3+Zo3sjU7nJL7YqxWGgm4zWWZxdR0sPIJlU2hLPDbRq2b+Q7Ddewh8Rsu0IFOSqADcfGAmOrT+1sDUZczLPbyonptasTQyMwTNNRRtu6CZWNoBWtNhmbx3L4yOly1i7DdsViqJjhdsNsUWZurEKhanqcvcYUmdd3suELNpulu6+c0IeirWpcgR7Dqx7crswg4bYg9dLoDz14MDR5stMbdgOwyrvjHE/Be1u5LHbAdEHEYkMXl9t4NYT4IvoUCixFUOXg8h+Wbv429vkIJxTU/VKl8Qf6Uoa6blvEo1Di8I57V50sJKcf3jurRVNkyXpLimWY5kpUFoORMe4IsiiZl1JL+drp1VyvnD/YLprX9qVMdQVptJy6PD7US/f/1NiQ8OenhRSmpyPEiFMTp0uGkQBK853AAqiHCO/rsYc7UCKpBkU7i3X5cGCd7DBBDSZCpgypFTOUW0v4Y3okMBzLq6HKJwc3PcvdbyVdd7paDWWyMwrM7xK1nNxTSEtmmyj89I1rxe/tlqBTH4n+VcL5X3F1FPuPsoFBHUYHz5IuohU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf9572c2-989e-498a-7265-08deba11f729
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5143.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2026 03:59:07.6068
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7fbdcePDfEs2KqPoClSIjomHIUWKKC2eAtmJz/FfU0AMp98SEoibRyvDC1p0F52uK/wm1rEtjIJheqa1GF2SLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5599
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-25_01,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 spamscore=0 malwarescore=0 suspectscore=0 mlxscore=0 lowpriorityscore=0
 phishscore=0 mlxlogscore=999 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2605130000 definitions=main-2605250035
X-Proofpoint-ORIG-GUID: kbc6PDNJKwYd91KcEfXVEbL7s5hMjUSH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI1MDAzNiBTYWx0ZWRfX0c8nHE5kF3f0
 FIJoZ2nBZIGHhUiDrZIWwxnmXuHK7gRcD6UZC5K0CE1zC1+Na7cWXqT4YEvxXbaFI2QXbvhgM2d
 5kKp3h1CEI/si06kVv9VAXtZ7P4Geo/ZtgcwYRYVOcnSqfhDyrrzFJy2+YQnp6hYGYQfkEbn/C+
 5JhSeUY3heJ2Q0zzP1v7hKJmWXDrpsb6f95vaCT4u9/cFOupMkqVRuKYmIL/SBbtiWyvm3q/dXn
 cA58NI1806ZQCCrhI42pt2a+2LsdDR2H+uWwnDXU2IrPcZjTjZgoZKJ8kABiP03U59RdmwiNhWF
 z13bcuyky4pgac3O2kXefpQqVEKq6mRyl1gi6ZejtbmHacOD1bzcBbSAu+uyMiO9aAFSO8y8pt1
 OAAHgzWw8lkPURBaNWjyq3TATy6X0Cs6dqpUf9cuRNIOF9VtFGvhANXT+XoH7xBJ07It84Q7jJj
 X4FwsZJJzyXniHObePA==
X-Proofpoint-GUID: kbc6PDNJKwYd91KcEfXVEbL7s5hMjUSH
X-Authority-Analysis: v=2.4 cv=LYsMLDfi c=1 sm=1 tr=0 ts=6a13c913 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=BqU2WV_vvsyTyxaotp0D:22 a=VwQbUJbxAAAA:8
 a=fpNMCQBBy1UNFEkrZkkA:9 a=QEXdDO2ut3YA:10
X-Spamd-Result: default: False [-0.15 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	TAGGED_FROM(0.00)[bounces-21908-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
X-Rspamd-Queue-Id: 416BE5C59B4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

hi Christian, Miklos,

https://lore.kernel.org/all/177945382308.2991556.1256192774754909984.b4-ty@b4/

> Date: Fri, 22 May 2026 14:43:43 +0200> On Tue, 19 May 2026 10:13:21 +0200, Miklos Szeredi wrote:
>> tmpfs: simplify constructing "security.foo" xattr names
> 
> Thanks, this looks great!
> 
> ---
> 
> Applied to the vfs-7.2.misc branch of the vfs/vfs.git tree.
> Patches in the vfs-7.2.misc branch should appear in linux-next soon.
> 
> Please report any outstanding bugs that were missed during review in a
> new review to the original patch series allowing us to drop it.
> 
> It's encouraged to provide Acked-bys and Reviewed-bys even though the
> patch has now been applied. If possible patch trailers will be updated.
> 
> Note that commit hashes shown below are subject to change due to rebase,
> trailer updates or similar. If in doubt, please check the listed branch.
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
> branch: vfs-7.2.misc
> 
> [1/3] tmpfs: simplify constructing "security.foo" xattr names
>       https://git.kernel.org/vfs/vfs/c/aba5853b137b
> [2/3] simple_xattr: change interface to pass struct simple_xattrs **
>       https://git.kernel.org/vfs/vfs/c/1cd9d2387c05
> [3/3] simpe_xattr: use per-sb cache
>       https://git.kernel.org/vfs/vfs/c/12e9e3cd03b5


I have been doing some testing of Chuck's nfsd-testing tree, which 
includes some vfs changes.

The test systems are reliably crashing, in what looks like it might 
possibly be something related to these three patches.

I reverted the three patches, and the crashes stopped.


best wishes,
calum.



[    9.215122] BUG: kernel NULL pointer dereference, address: 
00000000000000e0
[    9.218829] #PF: supervisor read access in kernel mode
[    9.221484] #PF: error_code(0x0000) - not-present page
[    9.224201] PGD 0 P4D 0
[    9.225557] Oops: Oops: 0000 [#1] SMP NOPTI
[    9.227773] CPU: 0 UID: 0 PID: 1 Comm: systemd Not tainted 
7.1.0-rc4.master.20260524.el10.rc1.x86_64 #1 PREEMPT(lazy)
[    9.233281] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), 
BIOS 1.6.4 02/27/2023
[    9.237483] RIP: 0010:simple_xattr_set+0x27/0x8b0
[    9.239951] Code: 90 90 90 0f 1f 40 d6 0f 1f 44 00 00 55 48 89 e5 41 
57 41 56 49 89 d6 41 55 49 89 f5 4c 89 c6 41 54 53 48 83 e4 f0 48 83 ec 
40 <4c> 8b 27 44 89 4c 24 3c 4c 89 6c 24 20 48 89 54 24 28 4d 85 e4 0f
[    9.249572] RSP: 0018:ffffd1334001fa20 EFLAGS: 00010282
[    9.252362] RAX: ffff89974107e460 RBX: ffffffff856b2f80 RCX: 
ffff899758b0ef60
[    9.256059] RDX: ffffffff856b2f80 RSI: 000000000000001e RDI: 
00000000000000e0
[    9.259712] RBP: ffffd1334001fa90 R08: 000000000000001e R09: 
0000000000000001
[    9.263416] R10: ffff89974107e460 R11: 0030733a745f7075 R12: 
000000000000001e
[    9.267138] R13: ffff89974107e498 R14: ffffffff856b2f80 R15: 
ffff8997443c5440
[    9.270772] FS:  00007fc098c74500(0000) GS:ffff899ae8a58000(0000) 
knlGS:0000000000000000
[    9.274906] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    9.277976] CR2: 00000000000000e0 CR3: 00000001013d1000 CR4: 
00000000003506f0
[    9.281668] Call Trace:
[    9.282985]  <TASK>
[    9.284145]  ? srso_return_thunk+0x5/0x5f
[    9.286188]  ? srso_return_thunk+0x5/0x5f
[    9.288277]  ? ktime_get_real_ts64+0xce/0x140
[    9.290614]  ? srso_return_thunk+0x5/0x5f
[    9.292776]  kernfs_xattr_set+0x63/0xb0
[    9.294829]  selinux_kernfs_init_security+0x13b/0x270
[    9.297496]  security_kernfs_init_security+0x36/0xc0
[    9.300105]  __kernfs_new_node+0x182/0x290
[    9.302421]  ? srso_return_thunk+0x5/0x5f
[    9.304597]  ? srso_return_thunk+0x5/0x5f
[    9.306645]  ? pcpu_alloc_noprof+0x481/0x990
[    9.308854]  kernfs_new_node+0x80/0xc0
[    9.310876]  kernfs_create_dir_ns+0x2b/0xa0
[    9.313103]  cgroup_create+0x116/0x380
[    9.315123]  cgroup_mkdir+0x7c/0x1a0
[    9.317051]  kernfs_iop_mkdir+0x75/0xf0
[    9.319014]  vfs_mkdir+0xc2/0x240
[    9.320809]  filename_mkdirat+0x1cc/0x220
[    9.322932]  __x64_sys_mkdir+0x2f/0x50
[    9.324938]  do_syscall_64+0xe8/0x5e0
[    9.326895]  ? srso_return_thunk+0x5/0x5f
[    9.329104]  ? count_memcg_events+0xdf/0x190
[    9.331392]  ? srso_return_thunk+0x5/0x5f
[    9.333556]  ? handle_mm_fault+0x24a/0x350
[    9.335741]  ? srso_return_thunk+0x5/0x5f
[    9.337894]  ? do_user_addr_fault+0x221/0x680
[    9.340194]  ? srso_return_thunk+0x5/0x5f
[    9.342653]  ? arch_exit_to_user_mode_prepare.isra.0+0x9/0xe0
[    9.345955]  ? srso_return_thunk+0x5/0x5f
[    9.348377]  ? srso_return_thunk+0x5/0x5f
[    9.350793]  ? do_syscall_64+0x9d/0x5e0
[    9.353123]  ? srso_return_thunk+0x5/0x5f
[    9.355707]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[    9.358689] RIP: 0033:0x7fc09832076b
[    9.360891] Code: 0f 1e fa 48 89 f2 b9 00 01 00 00 48 89 fe bf 9c ff 
ff ff e9 a7 ca ff ff 0f 1f 80 00 00 00 00 f3 0f 1e fa b8 53 00 00 00 0f 
05 <48> 3d 00 f0 ff ff 77 05 c3 0f 1f 40 00 48 8b 15 71 56 0d 00 f7 d8
[    9.371018] RSP: 002b:00007ffd34f0af28 EFLAGS: 00000246 ORIG_RAX: 
0000000000000053
[    9.375220] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 
00007fc09832076b
[    9.379178] RDX: 0000000000000000 RSI: 00000000000001ed RDI: 
00005609edb55790
[    9.383159] RBP: 00007ffd34f0af60 R08: 0000000000000000 R09: 
0000000000000000
[    9.387102] R10: 0000000000000000 R11: 0000000000000246 R12: 
00005609edaeea70
[    9.391136] R13: 0000000000001fad R14: 00007fc098754472 R15: 
00005609edb481d0
[    9.395140]  </TASK>
[    9.396605] Modules linked in: vsock_loopback 
vmw_vsock_virtio_transport_common vmw_vsock_vmci_transport vsock 
vmw_vmci xfs nvme_tcp nvme_fabrics nvme_core nvme_keyring nvme_auth 
sd_mod ata_generic pata_acpi ata_piix virtio_net net_failover failover 
libata virtio_scsi serio_raw btrfs libblake2b zstd_compress raid6_pq xor 
sunrpc dm_mirror dm_region_hash dm_log be2iscsi bnx2i cnic uio cxgb4i 
cxgb4 tls cxgb3i cxgb3 mdio libcxgbi libcxgb qla4xxx iscsi_tcp 
libiscsi_tcp libiscsi scsi_transport_iscsi iscsi_ibft iscsi_boot_sysfs 
dm_multipath dm_mod qemu_fw_cfg virtio_pci virtio_pci_legacy_dev 
virtio_pci_modern_dev
[    9.424581] CR2: 00000000000000e0
[    9.426635] ---[ end trace 0000000000000000 ]---
[    9.429400] RIP: 0010:simple_xattr_set+0x27/0x8b0
[    9.432229] Code: 90 90 90 0f 1f 40 d6 0f 1f 44 00 00 55 48 89 e5 41 
57 41 56 49 89 d6 41 55 49 89 f5 4c 89 c6 41 54 53 48 83 e4 f0 48 83 ec 
40 <4c> 8b 27 44 89 4c 24 3c 4c 89 6c 24 20 48 89 54 24 28 4d 85 e4 0f
[    9.442394] RSP: 0018:ffffd1334001fa20 EFLAGS: 00010282
[    9.445458] RAX: ffff89974107e460 RBX: ffffffff856b2f80 RCX: 
ffff899758b0ef60
[    9.449465] RDX: ffffffff856b2f80 RSI: 000000000000001e RDI: 
00000000000000e0
[    9.453436] RBP: ffffd1334001fa90 R08: 000000000000001e R09: 
0000000000000001
[    9.457506] R10: ffff89974107e460 R11: 0030733a745f7075 R12: 
000000000000001e
[    9.461589] R13: ffff89974107e498 R14: ffffffff856b2f80 R15: 
ffff8997443c5440
[    9.465681] FS:  00007fc098c74500(0000) GS:ffff899ae8a58000(0000) 
knlGS:0000000000000000
[    9.470290] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    9.473702] CR2: 00000000000000e0 CR3: 00000001013d1000 CR4: 
00000000003506f0
[    9.477743] Kernel panic - not syncing: Fatal exception
[    9.481889] Kernel Offset: 0x2a00000 from 0xffffffff81000000 
(relocation range: 0xffffffff80000000-0xffffffffbfffffff)
[    9.487771] ---[ end Kernel panic - not syncing: Fatal exception ]---

