Return-Path: <linux-nfs+bounces-9964-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8CF6A2D7BA
	for <lists+linux-nfs@lfdr.de>; Sat,  8 Feb 2025 18:13:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D41B1885BAD
	for <lists+linux-nfs@lfdr.de>; Sat,  8 Feb 2025 17:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB8511F3B8B;
	Sat,  8 Feb 2025 17:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZXD//BMp";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ooLy4L/1"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8E7B1F3B83;
	Sat,  8 Feb 2025 17:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739034817; cv=fail; b=mNOvEPNJBq7U01tCPzeIywPa4qwN3BMIop/x9gA7xiU5B4iN4AP7FhRreCv+FAqFDLOQFISr50F0BYb5mIF8Dn/dZFVv7QbvUxOVtyJmNcUuu/f3X3EQ2VbO6rU4BUWDxs9u9cgJ7TDVpS2iVdp9MQkfExEzDUe04dgMVm+X+ek=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739034817; c=relaxed/simple;
	bh=TGCTkb4UuiZGrCvZtQVixYt47bIhKm2StWZf0qEU2qU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=H/OyOUSw+bPG50cpxaq9DcKa7hxPQyOhR/Aw3Ym0u5/ib/uIbzkvllyyOAoU545L6vrvO24xWa2OKS9GaCvWgLp9E+yF8wuWe38hdpdZN/G++0oIZJFPkmuHxJLdluaHyHIf2S9QGR9t6vn78b8YUM1VCv6ZvqAtzaFmO8dv254=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ZXD//BMp; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ooLy4L/1; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 518GkSl6002694;
	Sat, 8 Feb 2025 17:13:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=T+orNeYpzse+9TMbyZN/LEqPJ6MJdTP8Kw6sbXPrCgY=; b=
	ZXD//BMpLwS0WYr3DsOJ6QjL5s24NduDNbFKHxhMWQVwmxbdTsYfPTiZdsKbEI7y
	KK7NscyFO843zVC5muHNXg+C9O+hpHg2x3jPtUpJi+uKgdv9IX/2qIEYjgJu5uM2
	NW9gMbsI3VnA2F/wyGK3x2LxrI8eYC4ApcShHy/txku3mtQBAA9a3jHIYbXrDYij
	HdUXIf/bpmFczXRr3VsKUUXOG0o8lzc0Sa7d+Ab0BBBTbcsVp23QAwBgu/U7FbPu
	p4OaEhCDE5pcgD+FGYBV+mijqabydFJitjnxF1RYsPP1eUHjmo3WJgoS8NHpz9Ji
	BpzX4ubz6sNcOxienw3HVw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44p0sq0cu4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 08 Feb 2025 17:13:27 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 518GA1vO038637;
	Sat, 8 Feb 2025 17:13:26 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2045.outbound.protection.outlook.com [104.47.58.45])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44p62vd5r4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 08 Feb 2025 17:13:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sJrj9Xytvz22UMK2DeJ2hbTyFydroc3Cg2XJHF+3OzQ1KcgwWdGcgkF/+5FOeKVxjIV7OnwlnZcR082NS9Pe9ya+jzHS6sPJcO3+BZanX23AcSVYJNKzJyrvqp5okvp/kDZ1jtA6YTTmovpw2PfFjQkYFxFmlJef4KvvQotIXAhAPQokJr5Ok/QUJdbaBhhVVxIjOQ0+L7deMWO0HDbrKKJiRTJUx8OWlHcmzn99qOZWWy38wjY37QeGSKZLrT1PyNmsT/acGOqMjA1G6Do7bzac2fu5fChrTBmh57XQ36TKRAy3AQlhLeUdquJ2gBu3e+P7HbkrC634PYTr6l54kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T+orNeYpzse+9TMbyZN/LEqPJ6MJdTP8Kw6sbXPrCgY=;
 b=PK7l5l5jwheJ365HmvMUmAS7x4TQYp7Hmkyh4ydCqM2SgwWV/vPZwC0OvmykXv6Zn4q3njw/XURrIS0IuPure//HY2FZu4FXbOI5NSjDON4HWSXhdvFDcY8xbHc4KVu0vmocA4VesG+fBwVXiz96g4gt5uNNfSFzKOqJ2K8eu3NpaLM1EHAc6Zg3VGAicraE9tZ+ZYDLPECFI+k2oVqVuZ+F8py27Mfz8VLRR0zPd1bBpUEGoy4g49n2ujO9qhC+LzT9qN0SyhWCQjMbhSg6qoWBNXk8NeCpsPGP91x8Df+pg0D74VgYErcZGW1ZVhaohUD+Shw1ptK7BfBZdQS3OA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T+orNeYpzse+9TMbyZN/LEqPJ6MJdTP8Kw6sbXPrCgY=;
 b=ooLy4L/1BRwWALr38aQIUtov/67AFT4amFpMLtQzcjhOpA3eoZbeEUmKWtS0jTFz3qBOmAAQ8l9Fcs602Id4pgF9Rne+kxhH122DzQKE2xzebWKZ+Yl8mtuO2n48egJf8R3ojbbq/zKEvDwcLGymSNtv9s5HKvkSyPCjirLD3cs=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MN6PR10MB7541.namprd10.prod.outlook.com (2603:10b6:208:46e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Sat, 8 Feb
 2025 17:13:16 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.8422.012; Sat, 8 Feb 2025
 17:13:16 +0000
Message-ID: <d7ed5f65-16f6-498d-82f0-6a008679ea0a@oracle.com>
Date: Sat, 8 Feb 2025 12:13:14 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/7] nfsd: when CB_SEQUENCE gets ESERVERFAULT don't
 increment seq_nr
To: Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>,
        Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>, "J. Bruce Fields" <bfields@fieldses.org>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250207-nfsd-6-14-v5-0-f3b54fb60dc0@kernel.org>
 <20250207-nfsd-6-14-v5-4-f3b54fb60dc0@kernel.org>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20250207-nfsd-6-14-v5-4-f3b54fb60dc0@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR14CA0041.namprd14.prod.outlook.com
 (2603:10b6:610:56::21) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|MN6PR10MB7541:EE_
X-MS-Office365-Filtering-Correlation-Id: ed22caaf-f96d-4d48-4a20-08dd4863e075
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L3d0SURkYm8wTmxWcm9aR2NWRGVXRXNIeGlsRzRlVUg2ZDcvUDltcCtGTHk1?=
 =?utf-8?B?N0xuS2Z5RGEzaUF3ZTZkS05XRlViUXFPb2VtZHdsdk51RDFKcytIdG51S1dX?=
 =?utf-8?B?UGxtMEZEY2k2RWlOa3FyVGZCK0hjTmNpQ1hvTDZleW5rRVVCYUFNZEcveGF3?=
 =?utf-8?B?S3FxZ3Q4cno0WjR3Vi9VRlhnb1Zsd2c5V0k3VWZ2eGtOR1ByYi9iaG9WeTd0?=
 =?utf-8?B?dGN2cnhIVmZIMjhwS3Q5T2JKa0R1bzhRWVpCNE14bFI1RnByZEpOdFcvQ0lv?=
 =?utf-8?B?OVA1SHNpNXFkSHlGaHQ4VWZvbzk1YTZYUVFBdFJxdGxaSjNZTDUwaVdsalBX?=
 =?utf-8?B?MHh1bzYzbzlDZVVWakNmTm44YVlBK1E4ZzF5THhialJCNWRoRGRlVmZ5S2Zi?=
 =?utf-8?B?YldCclRSd21mNkwwOTBwTjNQRW5ud0hYZ2svSXp4bFBJR0xQZ1lpOUpRdDBh?=
 =?utf-8?B?Z3BpaXlhNEdYOXVyUWU3emdYeTJkTnJEMkVIWkN6NnNwa1NHSzBUTlVxQzlq?=
 =?utf-8?B?SUk4dTJtTXJBdVFwYjZzbE1OZmJwVjhRTVhWWlhBSExnSDhyVTJXcmVnWnc3?=
 =?utf-8?B?ZjZwZTNadkF2SmxuR1Z0emZZWXVDV2xjVjRrcFlMUWt3L09WbzlXV1A0YkZB?=
 =?utf-8?B?RzRFSjkyQTJPWWdaaUhCU2VEcGhiZVkrNC9Pc3N1WVNiVmxrcU9KNXVGS29F?=
 =?utf-8?B?RlFLdkQ2VXRuSVBoYTA2NjNBenYzd1ljMWpUN2ZVSDNIdTRKTk5yK284M0RV?=
 =?utf-8?B?S0E0QlRiTlN0eXdub3cwcDVsUzZ4V050U0h2SUtKbTJ0RjA1ckFxNURQZGVO?=
 =?utf-8?B?c1lGcUxScC9WTlhsa0dOc2wya29tVkhDbWM0SnNEdUgya0JDSFNhbHJhT21B?=
 =?utf-8?B?dG1oaFl0RnFXYVVOcUF3aEFXUGwzTkpQL3lzR1hSVG43S29oQXYrVXQvTG9l?=
 =?utf-8?B?bzkybVM0VXJLZUhJbEM4RUd5SlN0UVVEbVVKditQeVdJRFE2VzlYMXVySms2?=
 =?utf-8?B?aHVkcHY3Yk1CbzBkdDRYdkt1Vm5wQTJsV0NucUZXV0pMODhxUVJtRnJXM3FQ?=
 =?utf-8?B?eUpQTU1DTnJhWFo5aFM4L3REakxzbDUzdjM1NEI2eTFwTFFXa3FramI4YnJz?=
 =?utf-8?B?R1o3Z1JzVzdXU0tkakdPaDUzYW9SODNlanppS2t6SVVLN1l2eFpFZEJCMDVr?=
 =?utf-8?B?QklZQmRyaUxKOW9aaVljNjJpQm9kRndscXVaZXNUejZHTldrMEErdTJtcFk3?=
 =?utf-8?B?QUtEQ2dscmFJN28zUDNyNEdFVU1tNWxDOG1GOTJVSDZpZ085MHNDVTR6VXB3?=
 =?utf-8?B?Y3FqOUlBSG5iR3RXRS8zZ3A1S3pvdGN3eDJlMEVMTXJyUHh6TDI5b1dXdWtJ?=
 =?utf-8?B?b3pzdU1INFoyeEoxZWZweWlKQ2o4Vm11SFgrb2VNNW5aMU0vdGFpSy9lNXdh?=
 =?utf-8?B?emM1UFFDazJWZjVGNEo2UnNyTzZheVFlcFpYdXhQU1Rtd21wU1ExdldhajRT?=
 =?utf-8?B?NHZqMkVWMmJ6UTJWb1BhRUFhTFR6c2hMQUpRbGgrL2dqZDdTdmlkMi9uUUJX?=
 =?utf-8?B?YlZrMTNEQ0J5NlcvMHJBSit3R1dCUjAyVjFXSHg5RTdSSUxhODd1WFBGVHJw?=
 =?utf-8?B?cVIwYmoxSWtrRE5yaUFTT3UvRHdxWlkrc09UUWtaL3BoSGlHd05DSGRRY3NU?=
 =?utf-8?B?SFVZblRlZ0Q1OTNJbzdTQnQ2M1duZ0hrVVZRa0paQ2FYN3ZzcjN4YkZkWkxv?=
 =?utf-8?B?VkcvOXd5NXB1KzlhSmRvSmdnU0N3b2tCeWw3YWR3aFllLy9iVTBDaTFOQzhv?=
 =?utf-8?B?cTNYcnRjWVQwRXQvdms0bmtZQ3dyVzVIWWNNT1lJZ1pWbC96VjV3Ti9pWXk4?=
 =?utf-8?Q?87B/7sK6lEAev?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WmZCMCtSUUdnbVJ5ejlWcGNXZXAvSG4zUGluekJEVG9oTVJkMmdsd3J2OUNX?=
 =?utf-8?B?NFN4c1VZaVhnSUFDTUZsdjhQd3dMU1FzS29GcWU1VG0yYjQyR2xPdk5FN01J?=
 =?utf-8?B?SGxyM0tOWVQ0T0xsODZTK1NSdlRaQXNmSWg4N0IyZU9KSWRENU1zRTlCUVpG?=
 =?utf-8?B?bmJMVGpITTViRDhNOXh0aEtBZG5Ebzl0Y3dCYzFBOWJwTy9Vdk1OSTBOTWdh?=
 =?utf-8?B?T1hnbDB0Q3lEWFVoc3l5azVURkg5Q1JkNzc2MXNEcEdIVHFNV0ZyU3NhWksz?=
 =?utf-8?B?WVhpdGxHZTkvZXVhWXgyN3I1YWQ4dnZjbFVLelgyK29zdzA0Z21CcmhjUjVK?=
 =?utf-8?B?L0ZaSFd3VnVvK0RrK2NNUFlmay9qUHZJcVJzWldlbDRlRU9wd2lXRGxGb1lO?=
 =?utf-8?B?TmpZZnoyNm1jdE9KSnBBNGRmYWRaVXZ4Y2luODlIUjN2OUU0RHRGNWw0Snhn?=
 =?utf-8?B?SFNLQUl5cEY2SHMwRlQ1U0JaVmd5MVFPREZuTlI5N3gxQXlDOGtHSm9pRVhW?=
 =?utf-8?B?L3NIeHhrNEJsTm9nYVRDNHdsb3NNNUZIZndncklPYSs2Qm5wekV4ZnBsdVhu?=
 =?utf-8?B?TThCNmtSVUo0M01FeGpUOTNleklmYkpvNG15Y1lES3o2ZHF0L0RDU21WMmQv?=
 =?utf-8?B?cEZ6MUkwYlpBOC9DWGNjZ1VvT013M1dHQzJrZFFLZ0twdi8weWV4c0FYUHY0?=
 =?utf-8?B?QkllWEpERXowcUl1bkh0Rkh5TUVPU0ROaDNoaW5ac29rWll0ODgwSWplZEds?=
 =?utf-8?B?MWdleElmWlh5RGc1eG9sRVRLb3VFU0tRZjFrcFdtVFlTdXhSV2FpVTRoZE93?=
 =?utf-8?B?aERoQnJnNnhZUnVTVEVPaUdiREZBY25JVFFGaGdQNnY2Tm1FT2NDV21IQkdH?=
 =?utf-8?B?ZkdraDBVdFUyU0VPVWVlVGxzb2RJZXpHSHdpNXA1ajFueVhVQnhyL1hxSEJm?=
 =?utf-8?B?Um93UHZEVzQvNCtMN3BYck1PeXpkbmpzUElraUMvbE8rNm5VbmEyaEFpQXFW?=
 =?utf-8?B?cDVNQUludERZV3BMQmppeUQyWHdFeDlqODd2Ly8rckxJUVRpazRUclhITXdT?=
 =?utf-8?B?a2V2QlFQY1QxTVdOODB0Tnk4VWlmdmlaTGFSeVEyT1dYcVBld3pkVHlKUHJt?=
 =?utf-8?B?STk2Y2RWbENNeUhMYSsvaVVWWG9VcUtQT2l3cGlEdnNCVy9HUDJkMGxYd2c4?=
 =?utf-8?B?VmFTR1l5TjdNVFNnTUdQc2VUdGRJZzhDb2U4NGZhditjTld0SmMvZXpIdG91?=
 =?utf-8?B?VCs5aEx0Rmg4SDFrVUVDazF0YnFDelJXL3paWWVvT2Y3T3luNFdDYWRFemhi?=
 =?utf-8?B?YlZtN1dRc1RUR2o4aVJWWlBoN05Fc2tDbGZnaGF6SVZsemdqZlhLazExcHc3?=
 =?utf-8?B?bmZBbFBQRTIvSTFwSU1NRlFqKzRFVnR1alZkbk12VDZjVVMzQVc4b2t1SUpw?=
 =?utf-8?B?N3FPcWlyUWhEd1locDVxVFdNZnZVVW14eG83WnJ2Tk1LMStlRXk1dVdCTXRT?=
 =?utf-8?B?ZWxzMnUzeWhMZnBFR1VmTExKd2ZqajRkaVZpNzk1Wk1XeW5JYVBTNHJGNlFV?=
 =?utf-8?B?N3VrcGN0RExINXhmdnF4aC9Hd2lCcVZ1L2JpeHNRUlk0RVpNVjc3MjhBNFR6?=
 =?utf-8?B?T1FtRm00dTdjZ3ZFSFNmOE5ja1ZzVG44Qk9BeEdBa0tTUzd2OEhrVHZqWWFQ?=
 =?utf-8?B?Qi85bDBmQmRWbGNrWWxyeDhLUnVqcjFKVGtMT1ZaMHhnMmNuRjZuSTlQSWY1?=
 =?utf-8?B?SVZwWUNNNGx5WXU0a283cWdmSzBmRXFjdkJCUWpwanljN0VIeHFMZzk3Y2Jy?=
 =?utf-8?B?emxyMDQzNUtrb1VkRXdabzZIQ0dSQS9zOGJ2VVp0eUk1K3g3SThoaEJJa3Qz?=
 =?utf-8?B?UHZKa0VGY1NXVnZuME5DcmZRMkJpWmpLZWJTMkdWaStIbi9ZVW42TlJZdGhX?=
 =?utf-8?B?cTR3NnRib3NjL1pIR09sdkxMbDVQK0NWK2N4amhUOVhTTUh0SlYwc2pVRFky?=
 =?utf-8?B?bFJNa08xVFhleEQrSVdWZTIxZ09CZGtYKytWRlJneUNLMklRb3NFV0NMWCt1?=
 =?utf-8?B?WitYQlFVZUtlOS9IUFpGNVg5YWQxSHdsNFhSelpKS2kxbjczYWdSbnYzbzJY?=
 =?utf-8?B?aDAxVG5yRGNXMjhQSzNPVEpwRTF4VU9QWEVFcW9QcHR4Z1Ftb0NmeEMvZ2dk?=
 =?utf-8?B?Unc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	w3ZJtlhn0s5916RuTm9gemBhhKbKcF8TRDV+xtyhyUph+MQYe7j6GFyiC7fWLem457YF6tlyFvMVF3lJHKjGpCgxQKHpAN3Fs+Ce02iCQEijMKHcU92Ytt/FPoiTPXBnbMLuyyuD4kJgm1iYpFWCFMkcE9mb9/kiv65mY4uQt3wBXEmcTJiFAKTxLr6UnJELJw0+sxhZijYXvr+ccodUnOwoVZG8PrJcAVAcnuNNhKrHvnUVdeMxs6BOf7Qv+DxFDnbWJkwhXdxsW1C3C0rk9akJimKyRe8WwlskCpNryrFcL20FT1/EcZ7ChZUO3OFQF/XLt21bHsbeWSTNlJ44WlMXzlJRCQf/on3VWTNb/o0mTJsyk6YqcLNl4IGW9EY3YjLLkD/bRluJK1D8fUaDP57imQUPCO5a6oz+tk1D4G93BofC3hREhXoknW+wSakeRcEuolM2t/jEV/8GIafI7X0Ukk14HxYoTQPxqtZYJ3v9xVsn98H4pCV/KtAdlWCYBlVzDrYa+15TbYaIG1sgU3Y+nVMUa6yocRVzt1Z1AFoOrup9M+rDnJBdvtJ4AE6wYs/Gmpo2t95bFqK3HiS1wEwOdk98i1YRTzuK6GM3kGY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed22caaf-f96d-4d48-4a20-08dd4863e075
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2025 17:13:16.3197
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JFnQrI/Kmkyh3HAgjZtMkOxFsLMTXOFyI8beCFHVEhyfuCIAhwcheQVnhBYzuNzQ9xpQ0pfESUwElMp1di6hrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR10MB7541
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-08_06,2025-02-07_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 phishscore=0 spamscore=0 adultscore=0 suspectscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2501170000 definitions=main-2502080145
X-Proofpoint-ORIG-GUID: FwSakDdYnCkKo37RZRL8ZumxXvwnbvq-
X-Proofpoint-GUID: FwSakDdYnCkKo37RZRL8ZumxXvwnbvq-

On 2/7/25 4:53 PM, Jeff Layton wrote:
> ESERVERFAULT means that the server sent a successful and legitimate
> reply, but the session info didn't match what was expected. Don't
> increment the seq_nr in that case.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/nfsd/nfs4callback.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
> index 1e601075fac02bd5f01ff89d9252ab23d08c4fd9..d307ca1771bd1eca8f60b62a74170e71e5acf144 100644
> --- a/fs/nfsd/nfs4callback.c
> +++ b/fs/nfsd/nfs4callback.c
> @@ -1369,7 +1369,11 @@ static bool nfsd4_cb_sequence_done(struct rpc_task *task, struct nfsd4_callback
>  		ret = true;
>  		break;
>  	case -ESERVERFAULT:
> -		++session->se_cb_seq_nr[cb->cb_held_slot];
> +		/*
> +		 * Call succeeded, but CB_SEQUENCE reply failed sanity checks.
> +		 * The client has gone insane. Mark the BC faulty, since there
> +		 * isn't much else we can do.
> +		 */

I'm chewing on the "gone insane" remark. Since I'm tagging a few nits in
other spots: perhaps this comment could explain in more specific detail
why the server cannot trust this CB_SEQUENCE response. Maybe:

 /*
  * Call succeeded, but the session, slot index, or slot
  * sequence number in the response do not match the same
  * in the server's call. The sequence information is thus
  * untrustworthy.
  */

That's wordy, but you get the idea. Even better if we can find some
relevant spec language.


>  		nfsd4_mark_cb_fault(cb->cb_clp);
>  		break;
>  	case 1:
> 


-- 
Chuck Lever

