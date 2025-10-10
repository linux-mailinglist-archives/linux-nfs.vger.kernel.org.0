Return-Path: <linux-nfs+bounces-15123-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 671B2BCD02C
	for <lists+linux-nfs@lfdr.de>; Fri, 10 Oct 2025 15:03:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 725BC1891DD4
	for <lists+linux-nfs@lfdr.de>; Fri, 10 Oct 2025 13:04:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C6D7275845;
	Fri, 10 Oct 2025 13:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="K9KL9c7P";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="h1GrURNu"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D4C753A7
	for <linux-nfs@vger.kernel.org>; Fri, 10 Oct 2025 13:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760101424; cv=fail; b=cS+HFFCChAk1qU4vGZUN2IWYAhBPFhsrhmcpaJPUnoJQEJpyLfx8OUYB3EDhEs4Dq6vEBVxygj3UHKZYQKyPYN51y/aCgB+ApkFXu+8acBQcflh6FsDsFW+qaGugzMSwKR29YzbuGuar6+WRG/BbXI2hskDQidrFJx2D+bhC2P8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760101424; c=relaxed/simple;
	bh=+uw+XQWJCt2c3uNteky+4yKndVj2YEt784FKUQy7vzA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RhOAtKNB2qwlCeXji/TkmocITqJHxYxZmAT+x+Vk2xWWVlBYlHTO2SyI3fQiXZN+fKXwfBMuFeVejePRay6+TXHDEHRqO/5Tp+u0ArBnmxrWocJEhRfHHQhPT5FGEon4HCD8v9Eef5wkbTmv2hWdz13fUArgdTnmU6DZlNmc0Bo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=K9KL9c7P; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=h1GrURNu; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59A8tl8Q025978;
	Fri, 10 Oct 2025 13:03:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=h1TE3Vx4hVqfAnbN0aXMLgE0qU+9ZziTsIqXJoIRX4s=; b=
	K9KL9c7PnBzlIBXxB+JfBeT4zj+otbIjOQLbZpjeYhyaqcs6mTpItIB0kGHIxxKU
	8IP45mbVfzbTceF0BBBP2ilSpfVnbeVOAdSwAlNtM3fx3MdgkSf7vn1Xp3TY090U
	TtV4WRUHNpt3kyOSYTzCnRhfd632oqu6xzWCDrrp9E/PpNWd+PMOnf6IbA0HvzCu
	ZYAIZUQg0yZC40Ij7g2CzrlItw6+Kn8OIYVXvWVwpQxD/DI9cMsJo4nN4u8rMxu6
	Ke0VLVaZ2VzgoonXGGht0bKtBAiODg73iJXndsSFb/BfOPYMu1/1GI5zkNzJbBQm
	msZtjWb1FJrK4x54FUWXDA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49nv8pkkmp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 10 Oct 2025 13:03:29 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59AC2WoO010410;
	Fri, 10 Oct 2025 13:03:28 GMT
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11013048.outbound.protection.outlook.com [40.93.201.48])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 49nv686cgh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 10 Oct 2025 13:03:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RCpsemyc0FcxEdoI9wDphGyVQWe8MQCItRlsdF2+Bi5cGE8fc4GuLJJE6p+9Q9jT+GIkgxCa4pQG19+QiBxA7yA+ip+QVjq2L+3LPgGiPhioqYSurimg7no+zwBiXvYvNVmY1OODTQAAN3Bsx6JW0jDshsGYoGjRFSRSTfvyMTqBAqVpOdqmgbpdi+kvMfGinye81CH4CVnmx548AA3dJnKspXgAOqgHriY9q8Le7gWULCM02NrG+9VIKbR805oTEDBGachDN3gNDItUE79VwiQ9zl8QQbgM9pB84LZA3u9RBtvgU432dSbszjdaDXKEOCe0GBgEE173pt9sNTTeCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h1TE3Vx4hVqfAnbN0aXMLgE0qU+9ZziTsIqXJoIRX4s=;
 b=taqdnviNWrUOIthxEs7o8aiSVoWFPHqHygyu9yV0KTBCgKuHOjqWowQ02fFeWbIfLdbJ8FuPLn/p/y7rzQb07BC0qdzy+GNGQqs04YpItoo/8cprdmQxTyszZUA3RWS7q1tZVE3QWfE3e9jRf/YWIHWretFNXPICEiAQUYvnCPvj8dgIPwSGs/9v18YGydZsbZrFpnMIUTl7cccEHR+NNoRHMXTcti8dsow9Pf003ux34W07AFQ3yu5mC5FeVyKlXPpX3CFYCDBHnGzCXBCcPd6r/x5oe2TynAwSa2ZUSrGRJ62DklWozRdSjyU2bqde5G2LD/TurinflqS1BywGYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h1TE3Vx4hVqfAnbN0aXMLgE0qU+9ZziTsIqXJoIRX4s=;
 b=h1GrURNuJz4nGG4bpjehGrP2zTPnaV9BFDMfkkR9phthsg/SerUXocSPg2SQb6j17hOtr6dY/4DY6P/RH3UN7u1J30EV5YZLto+3ZgCVgESNq7+4oIQbtRxfYE0kJGrfhRUJThk+o+uaT031Y7Pk8GlTNnepfiAvVr4yoZ/gpGI=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS7PR10MB5182.namprd10.prod.outlook.com (2603:10b6:5:38f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Fri, 10 Oct
 2025 13:03:06 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.9203.009; Fri, 10 Oct 2025
 13:03:06 +0000
Message-ID: <c302bfe7-1503-45c6-8388-6c6f1cd1b5f4@oracle.com>
Date: Fri, 10 Oct 2025 09:03:01 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] NFSD: Do not cache solo SEQUENCE operations
To: NeilBrown <neil@brown.name>
Cc: Chuck Lever <cel@kernel.org>, Jeff Layton <jlayton@kernel.org>,
        Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <dai.ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>, linux-nfs@vger.kernel.org
References: <20251007160413.4953-1-cel@kernel.org>
 <20251007160413.4953-4-cel@kernel.org>
 <98277504-3d4b-4aff-9810-1847e6bf4030@oracle.com>
 <175987517335.1793333.17851849438303159693@noble.neil.brown.name>
 <711bd35a-78b3-4309-9cb7-9e2c7a83a87e@oracle.com>
 <175996099762.1793333.16836310191716279044@noble.neil.brown.name>
 <468cdcfe-971b-4ed7-a7ef-b1d70117a579@oracle.com>
 <176005255127.1793333.10926466897571153606@noble.neil.brown.name>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <176005255127.1793333.10926466897571153606@noble.neil.brown.name>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR07CA0144.eurprd07.prod.outlook.com
 (2603:10a6:802:16::31) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|DS7PR10MB5182:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f1e96cc-f019-47d3-2957-08de07fd5a60
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?NHdVSFJ3clBvRVNSWUNSdkg2c2hZY1M5UGdJRzJoYU5OK2VwTzR6Z1NVTFVq?=
 =?utf-8?B?ZXNualZSaEF6R1l5S1FQdVg0NEZGcmhmcUxUSTE4ZGppYm5RZTZ2YzFZQTFW?=
 =?utf-8?B?cTdVYzNTVkJHNGc4YTFrOTk5aW9ya3FibjJ6NDJESDdCUTZnZXFNYkRwMWIv?=
 =?utf-8?B?Q3BRWW5zTzhEdUFKcUJPdnlLSEg0TGYxa3FOVE9rWUJLREVUYzlQcmtFdUt3?=
 =?utf-8?B?azc3bGhOM2JyTThQRkZUUFUzUEo3eno2V1c5T29ZQXk0dXAxYlhsc3RPR3Nn?=
 =?utf-8?B?ME9lRTFTcm9Pb0tXK2VNUTF1S04rL0V2L3dKeFlmUzZtaTdHOHdzMG90Slov?=
 =?utf-8?B?ejIxT1lia1hQdVh3RGhVd0R1N1lSbUk4RVlOVXpDTWV0dXl4YkxYTElCdmdO?=
 =?utf-8?B?dzhMUTZUSUoxSXdBZkpVMEZyREwyc2UyYVR6d1dHMFR0b2FpZFNyQlNXK3Zy?=
 =?utf-8?B?VDFUTXNVTWo1NXV4SmdPSmxLcFRERCtiREx1TGJkNXkvZEtSTVk4ek1LQWVZ?=
 =?utf-8?B?bWF6NUpEYnVidWxGWDJ3c1JheWFSNU1QVUIwbGR6V1pvN084b0ZIcGRRUmdN?=
 =?utf-8?B?SnhQUE9IcmtKbGIwUzZDVGdVZFRPYlFjSklIMVRBRzFoSUhWUEJKMENCQ0dz?=
 =?utf-8?B?eU9WbmsxV3VsTnVvOWhyVGNteWdlUWtlQ2N5L1RNQ0FNRHlzSk1xUks2aFpT?=
 =?utf-8?B?UGluSHNZZjJjUUhSQ0RONVVKRkFGaGdiTmtKTUQyZlJKWEJyVXU2UjUrdENy?=
 =?utf-8?B?d0pNUXI3aFBsdlg0WnkwMWxtUDM1MnE0ZmJSdjJGZDFucnJJTks2b2dsV05Z?=
 =?utf-8?B?VjN6bmRBaTBiZWswQ2l5aWdBcW4vdE81ZzYvaU1UOGZmc0hZMlRwS2xlRTBp?=
 =?utf-8?B?ZW10bDdLd1IwLyszMy93MEtWRUx5cDgxWjJKOFpNUHlPVjdRQVBmSXhjNGE2?=
 =?utf-8?B?NVNISkl2cmRSNSticnkvTW03NDFQTk1LbnRCYUFMQkczbE0xZ0tZazVmdDNr?=
 =?utf-8?B?ZDJrVk5TZ3lMaGZoQkwrWWlDNEt1QStIS3JRNkNwSkc0MHVpNTJtbGFxWEd3?=
 =?utf-8?B?ekRkMWxkcmVMcVlRbzBiRjVSYXRPc0tIbkZxd2xZbGQxMUxYaVdYbHRJSXVy?=
 =?utf-8?B?enpmbmcwRWpaa3Z5ZUpzeXFkTktVa2xzbjY0ckk4dmRER0VIWlg3STJOcS9i?=
 =?utf-8?B?RUc1NytHVWlydVhRL1pSam5XVmpSVERmY3FES1ZDUUJkUmw2N0hmMTVRVmVK?=
 =?utf-8?B?VWxUcDlIQUx1SU8yRzZGTEg4SVpvQ0ltcnlMOTlMMFVvRWF0UzRXY01BTDNC?=
 =?utf-8?B?R1BBMlJuQ3dkcDRKeEh5dWlPT1pua2x5TjU4WkZZdFFvVW1kYVZQcmNZK3hQ?=
 =?utf-8?B?aStIcEsxSlp6dUgwM2RkRWdUNUQ3VVZ1Q2M1Ni9ub0J1bFk5NW9iNjdFc1Vq?=
 =?utf-8?B?ZWF3dU9kMERIL2tYRnVLRnFCazRMMzFqRVhUaW1SOXlWRmtPRVdwd0lQdTZq?=
 =?utf-8?B?WEw3Ym81V1pKWS90MU5wNFYxYTlVTHRuZlY0MjI1L3lvZ1dGRmFLZjBJeHlH?=
 =?utf-8?B?Qk51RmtibUc1YkUzTjA2bzhKUm5qeE9SSnl1Um1icTcwSnFoYnh5cFA0TjNq?=
 =?utf-8?B?TUVWbG1hTTExZE5QMEdhVWhnV1Vyd1RZSkpsYVZGWEtVSFR2SlAyMUEyV3do?=
 =?utf-8?B?K3Ezd2JON2lqOVl3d1JuK0lmaHNDakpZTXRIL3BmNG5IVzlYSFNjVVdRNXNl?=
 =?utf-8?B?eWlGQys0NWhGNXJFVlFRczJGNnh0d29xM3FBSlJEcGFLVlpxOVRURUhOUDgz?=
 =?utf-8?B?M0gzeW5xdlVXZ0lsaHpjWEYyWUZ5STYyL24raGJHcmVMMDFiL0N1RnExQWVE?=
 =?utf-8?B?V3d5U0lmRjhFS09pT2dqb285elZaTmdkcnB3cnovNnRJSWlaMWxMN004TU9l?=
 =?utf-8?Q?RTG8LQx+laP1cxT97ETXDdRMnEwj/EaO?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?MnJtUDdtL1ZtYVFhZ1Iwdk9aS3p6QU16NW9zckwwTnpKTTVadVduUi9OVHZh?=
 =?utf-8?B?eU9MN2d3ckVSWlFVWXZ4aG1ZMGVwWi9vWVVYa3JSWlNJL2RycFh0Y01rNVNh?=
 =?utf-8?B?b3pOYXFMZExzTzZ3THI3b1hmWVk2VWppOE9KTFdFMEhacUdUYkpnT0NHVWds?=
 =?utf-8?B?dWhKMzR0TUtNWFVPUXZLdjR5ZlhwdkF3Z09WV1JKa2xyV0ExdWI0VFlQejI3?=
 =?utf-8?B?dWhUdEJVdlM2Uzh0N3NYMm1IY0NWb0RqQ0tNRlVRbWFJNDdlejZaNTFBZmd0?=
 =?utf-8?B?dkZ1bkF3QXEvOUhoQzNkUjZEb1NtS3ZXK3pBK3IzUWE3NGhsWEgxd1pxUnRv?=
 =?utf-8?B?c1B1V3JQRHVXUE5HeW1tN25uZnVWZnJhTlByOWJkQlN2aXRKa2V6d2ZUcWFI?=
 =?utf-8?B?L1F6dHZiaEVzZklSZlpOWkZXMHFTN3ZBSjhQOFRoeEMrSk9nLyt5bW5lVml3?=
 =?utf-8?B?NU1TN0tocURDUG4ydmpoeTJ4QTdJSkFrQmw3cE91ZmhBdGR0YlhFQ3lITmdW?=
 =?utf-8?B?djJxWmxiYndoRVZiQ3E1MG1KamRqZE1WbkMzQ1lsS2ZQdk93QU9sQnEzRk1U?=
 =?utf-8?B?c3h3Qm5DdnhIUWNtYVBySy9LalJ0TFZkZ1lMVFFOTnJacXZPczFxK2N4LzRR?=
 =?utf-8?B?VVF5ZDhXMXZRcDFVbllPS09DdFg0MExLWEs5NURyQVJIYlBjQWU2QkNGY0Vn?=
 =?utf-8?B?d0F0cUpwSzN3WUNFTXZtUDllZjFObUd2SHlvdC9QYXRqd1BrcU5NeXZKcG9j?=
 =?utf-8?B?a1ZWOVdwQlRYYnpLcEZDVXM4cDU4QWJUNlZOY3MrT0J2akNKamFWQXMvRmtL?=
 =?utf-8?B?OC9YYXR4SzJkUkloenl5ZTFnMWI1c1BkaWloZWZveTkraHRGRmRNNnA2ZzZu?=
 =?utf-8?B?azdmQmVtTHdHaG9IbFowTitQRm1pYWdJNWZjdVE4ZG5ONk5OZU53QVJSRFk2?=
 =?utf-8?B?TVlNVXZiVm50eXZiS1VHbjU1Z0NUazVldis1MWZKMEF3RGh3d2RNbVM0TWEx?=
 =?utf-8?B?dU1QNm53cUtDQm9IZHJpYVU0QXdmRlNjbDlGa09nUkVXeVhraENLUTUyZGhJ?=
 =?utf-8?B?eXUzakV4ZWJMRU1ReHVBSlNoZ2pKTnMyZ0pIeTRVNDdzbTRLL3ptTzFQaUZ6?=
 =?utf-8?B?MGU4bUhib3Qydjk3OW84cUJPOHRpRmFvNWtsdVdHU1pTcWd6Vzd0dzE5bzV5?=
 =?utf-8?B?YlVtbFp5ZndiNTVpNjhsWFNad25zS05UVEhJblRibC95dkhja3FIeEozQWlP?=
 =?utf-8?B?QjRieUR0THpaODF6NHBYK25TMnVGQldJZXlUNTJrbDBFb21rVDUzNHJnd3RK?=
 =?utf-8?B?UEFDV3dMMjJyTmxKdXp3MTlzWm4vL3F4bzE0TkpBUnVkQUZ3Mm5UNU9ZQ3do?=
 =?utf-8?B?OFgyMWtzODZlL1JPZER0SldlblhOblpza1hWSVNETnU2VWZtc0NKZG1SZGtz?=
 =?utf-8?B?TDAwNzhyZnFXSUx5Y09PRGdhWllQT1lqdjZ3WlRtejV0Z2xXV09XU1FJVzdZ?=
 =?utf-8?B?RnRycU9ZMzVaS3piQ1o0Y3hIalNrU0Z5Qlg5Nk5POWNPS0Fzbll2VlZGMnhu?=
 =?utf-8?B?aVNPaWNxalJoS20vMG5udFJRa1JGY091NFIrMUxJb2wxTVpUSXVNdDAwQmoz?=
 =?utf-8?B?WkZCd2YyVmVjVlNkOEM5YjhRU3dqQkY1U1VPRlczVGxGZUtGQlB5WmJ6VkR1?=
 =?utf-8?B?L1BFVW5nZktWSjlTTVBlTHdtQWpZdW1seVNrVURNVG13M3QvU0lqb1ZQQWF1?=
 =?utf-8?B?clkzeGZia0llOEVHeW5xWUk5MXJWRWY5cXhtUEs5T3JCT1BjcVhSV01zdklN?=
 =?utf-8?B?QXprcHRRS1NWYUVUUzMyblhYS1lBdWRHTytWNXRYbGd6QTZhR3ZjVnNHYmJR?=
 =?utf-8?B?NEVOcC9iYU1yS3JDUks5M1RPekNYK0V0TVRCdTBTblBwVFNRVlB1TkdzSEVR?=
 =?utf-8?B?aStrK1krRGlpc3FyMmVUUDhGOG15cFIwK2IxZGt0K0NBN24rUm9XT0xvc3dV?=
 =?utf-8?B?alJacVdHMnQ4QU5ic2tPSjZoQ1lqUEM3emYzaVN6elpCOVZBbUtTRXhOMzlW?=
 =?utf-8?B?aWE0dHlhOUpqbHhmSS82L3V2WGlvMmVXZTB0aFdhYndyUm85M2xrVTBSeEhq?=
 =?utf-8?Q?UKj8up8fAwv54X1vzKYjvJWRv?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
 5APxeh3rAEtThzipxptqTaSqPkfAteBbzAYb1+DWIKBMySVsLfni1w8U0Z0nFmE3XEHA4dEusoKf/mP5Ot+qt3gCq2ZUc9SAGpPxfxBzinnbIryOXSFjzI8r2r9MWUEy5kyVAuRExgB1/ui00FbutpZId39tVqDR7DgA1nGoWbLttq6nJRD+IRcve0Hdiix8saE0Th7nT3vQ5+7SqCgo4t5FWAcnXn5aKjHXtCxCk5HDf0TJ/6SQ3hDEe3R6tzFC8Fe7EbD4yOwoB0RNppchEeuUav8EW83NVLDeRDtIGDhkBMKidZqsoQQrYahDLsYz8YVI8yiwQB7IZqU79Tiu6YJd2D2hRsVp08DjXDZW4soJ6p0T9OZW4Cfl+Kn2GYLGSalZK1ZjMKEI/TfXGt2KzaKYo6voBkyUZt5omqFNA0Eylgm7k2Pogi/CLxHRk9avB/yNr/b/KJnYHHTfMpgSBDdFWqlMTPLXbgaETNNejpaS6YE1dv0j2+B3eTME8vdQRq0IN8fXsZv+TF6S0XX3V4Jx+bG9VWsuPU67M+WEJDu/RKEDyLLfxpqO+G5FWnyo7yx0afgKEg7Roajkl3cXzuzqaK7SjmYLv/G7aaBqeYk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f1e96cc-f019-47d3-2957-08de07fd5a60
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2025 13:03:05.9812
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zmy6xE8sqmqwZq2x+yNQNf0jRzJGOtOpLaMJEJXM4T1ldeYf4qlOkWDIy4w5OhUuj3R5T4XEd3GZk5AMMBL34A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5182
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-10_02,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=974 suspectscore=0
 spamscore=0 adultscore=0 phishscore=0 mlxscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510020000 definitions=main-2510100075
X-Proofpoint-GUID: FBTRYB3jH_gi0fNOCXB48eWWBJ2TnTkc
X-Authority-Analysis: v=2.4 cv=I4dohdgg c=1 sm=1 tr=0 ts=68e90421 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=PROgJ-Fr0R4lkwZqs8YA:9
 a=QEXdDO2ut3YA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: FBTRYB3jH_gi0fNOCXB48eWWBJ2TnTkc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA4MDEyMiBTYWx0ZWRfX4XPBtU1eHj7D
 euOu/6M3HLM+AcR+2I3pMjV2fz9q/+ROx281BAwn9094JDsrhJRwn1Wy+yHyiGbUxFlM7NrLkJn
 EgBtk+3xvnwMedNyLQV/FFFMCqxeLMVKBgo9sItGWdpbH1vLMKktVQVlmeZXr9slMKeQmTqNcTp
 aiWvg+0veOxwUBOqFLIggcD9gqmx7nD6Or5DSKcfXS1j42hYbY5Gd+TixLCT6c/oxDwtcLvzKMm
 dBcDvyFqs74x4042K9DI8DA5SsHH7Ykz4VAFPDjfi7Wz3HWPXMR/5knJKuELlYZeiKiLSzGln3P
 C73tWMeXM12sizWhw8CfBYYlyG7dshQeIR2IIkkBn8V1F+0yLAx0vdDE0vhhTeZwMLNUqDKBUf3
 IOzHC2qW9DQhwDTHeOsay9qtj28tnQ==

On 10/9/25 7:29 PM, NeilBrown wrote:
> On Thu, 09 Oct 2025, Chuck Lever wrote:
>> On 10/8/25 6:03 PM, NeilBrown wrote:
>>> On Thu, 09 Oct 2025, Chuck Lever wrote:
>>>> On 10/7/25 6:12 PM, NeilBrown wrote:
>>>>> On Wed, 08 Oct 2025, Chuck Lever wrote:
>>>>>> On 10/7/25 12:04 PM, Chuck Lever wrote:
>>>>>>>  RFC 8881 Section 2.10.6.1.3 says:
>>>>>>>
>>>>>>>> On a per-request basis, the requester can choose to direct the
>>>>>>>> replier to cache the reply to all operations after the first
>>>>>>>> operation (SEQUENCE or CB_SEQUENCE) via the sa_cachethis or
>>>>>>>> csa_cachethis fields of the arguments to SEQUENCE or CB_SEQUENCE.
>>>>>>> RFC 8881 Section 2.10.6.4 further says:
>>>>>>>
>>>>>>>> If sa_cachethis or csa_cachethis is TRUE, then the replier MUST
>>>>>>>> cache a reply except if an error is returned by the SEQUENCE or
>>>>>>>> CB_SEQUENCE operation (see Section 2.10.6.1.2).
>>>>>>> This suggests to me that the spec authors do not expect an NFSv4.1
>>>>>>> server implementation to ever cache the result of a SEQUENCE
>>>>>>> operation (except perhaps as part of a successful multi-operation
>>>>>>> COMPOUND).
>>>>>>>
>>>>>>> NFSD attempts to cache the result of solo SEQUENCE operations,
>>>>>>> however. This is because the protocol does not permit servers to
>>>>>>> respond to a SEQUENCE with NFS4ERR_RETRY_UNCACHED_REP. If the server
>>>>>>> always caches solo SEQUENCE operations, then it never has occasion
>>>>>>> to return that status code.
>>>>>>>
>>>>>>> However, clients use solo SEQUENCE to query the current status of a
>>>>>>> session slot. A cached reply will return stale information to the
>>>>>>> client, and could result in an infinite loop.
>>>>>>
>>>>>> The pynfs SEQ9f test is now failing with this change. This test:
>>>>>>
>>>>>> - Sends a CREATE_SESSION
>>>>>> - Sends a solo SEQUENCE with sa_cachethis set
>>>>>> - Sends the same operation without changing the slot sequence number
>>>>>>
>>>>>> The test expects the server's response to be NFS4_OK. NFSD now returns
>>>>>> NFS4ERR_SEQ_FALSE_RETRY instead.
>>>>>>
>>>>>> It's possible the test is wrong, but how should it be fixed?
>>>>>>
>>>>>> Is it compliant for an NFSv4.1 server to ignore sa_cachethis for a
>>>>>> COMPOUND containing a solo SEQUENCE?
>>>>>>
>>>>>> When reporting a retransmitted solo SEQUENCE, what is the correct status
>>>>>> code?
>>>>>
>>>>> Interesting question....
>>>>> To help with context: you wrote:
>>>>>
>>>>>    However, clients use solo SEQUENCE to query the current status of a
>>>>>    session slot.  A cached reply will return stale information to the
>>>>>    client, and could result in an infinite loop.
>>>>>
>>>>> Could you please expand on that?  What in the reply might be stale, and
>>>>> how might that result in an infinite loop?
>>>>>
>>>>> Could a reply to a replayed singleton SEQUENCE simple always return the
>>>>> current info, rather than cached info?
>>>>
>>>> If a cached reply is returned to the client, the slot sequence number
>>>> doesn't change, and neither do the SEQ4_STATUS flags.
>>>
>>> Why is that a problem?  And importantly: how can it result in an
>>> infinite loop?
>>
>> My remark was "could result in an infinite loop" -- subjunctive, meaning
>> we haven't seen that behavior in this specific case, but there is a
>> risk, if the client has a bug, for example. I can drop that remark, if
>> it vexes.
> 
> I think dropping it would be best.
> 
>>
>> The actual issue at hand is that the client can set the server up for
>> a memory overwrite. If CREATE_SESSION does not request a large enough
>> ca_maxresponsesize_cached, but the server expects to be able to cache
>> SEQUENCE operations anyway, a solo SEQUENCE will cause the server to
>> write into a cache that does not exist.
> 
> OK, this looks like an important issue.  Adding that to the commit
> message would help.
> 
>>
>> Either NFSD needs to unconditionally reserve the slot cache space for
>> solo SEQUENCE, if it intends to unconditionally cache those; or it
>> shouldn't cache them at all.
>>
>> The language of the spec suggests that the authors did not expect
>> servers to cache solo SEQUENCE operations. It states that sa_cachethis
>> refers to caching COMPOUND operations /after/ the SEQUENCE operation.
>>
>>
>>>> The only real recovery in this case is to destroy the session, which
>>>> will remove the cached reply.
>>>
>>> What "case" that needs to be recovered from?
>>
>> When the session slot has become unusable because server and client have
>> different ideas of what the slot sequence number is.
>>
>> The client and server might stop using a slot in that situation.
>> Destroying the session is the only way to get rid of the slot entirely.
>>
>> But IMHO this is a rat hole.
> 
> OK, I think I understand now.
> 
> According to RFC 5661
> 
>   The value of the sa_sequenceid argument relative to the cached
>    sequence ID on the slot falls into one of three cases.
> 
> of which the second case is
> 
>    o  If sa_sequenceid and the cached sequence ID are the same, this is
>       a retry, and the server replies with what is recorded in the reply
>       cache.  The lease is possibly renewed as described below.
> 
> So the server *must* cache the reply for the most recent SEQUENCE in
> each slot.
> 
> The language in that section seems to suggest the "cached sequence ID"
> is stored in the slot's reply cache.
> Our struct nfsd4_slot stores the cached sequence ID not as part of the
> generic reply "sa_data[]" but as a dedicated field.  We could store the
> rest of the SEQUENCE reply in dedicated fields and leave sa_data to
> store the replies to ops 2 onwards.
> 
> The discussion of ca_maxresponsesize_cached always takes about "if
> sa_cachethis is set" it seems to apply only to those ops where that
> is relevant - it isn't relevant for SEQUENCE.
> 
> So I think I would be in favour of always having enough space to cache a
> full SEQUENCE reply.  The decision of whether it goes in sa_data[] or in
> dedicated fields depends on how clean the code looks.

IIUC the protocol requirements are:

+ solo SEQUENCE that fails MUST NOT be cached. That is currently an NFSD
bug, because it unconditionally caches solo SEQUENCE. I have a patch to
be added to this series to address that.

+ solo SEQUENCE when sa_cachethis is false does not need to be cached,
but the protocol does not allow REP_UNCACHED_RETRY. This is the only
reason to cache a solo SEQUENCE reply. Note that the cached response to
a solo SEQUENCE can be constructed from existing fields in the slot. But
I can't see such reconstruction being clean, and it is certainly a
heroic case (ie, not commonly used, if ever).

nfsd4_alloc_slot() sets the slot replay cache size to /zero/ when the
client's ca_maxresponsesize_cached is smaller than ... I think just the
size of a solo SEQUENCE. I thought that was the bug, originally, but
then Tom suggested there's truly no reason to cache a solo SEQUENCE.

So, we could go with:

0. Fix nfsd_is_solo_sequence (that's 2/4 in this series)
1. Fix NFSD to not cache failed solo SEQUENCE
2. Increase the minimum size of the slot's replay cache to fit a
solo SEQUENCE


-- 
Chuck Lever

