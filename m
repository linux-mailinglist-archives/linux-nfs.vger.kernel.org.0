Return-Path: <linux-nfs+bounces-11756-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F476AB8F9B
	for <lists+linux-nfs@lfdr.de>; Thu, 15 May 2025 21:03:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 629BB7B821E
	for <lists+linux-nfs@lfdr.de>; Thu, 15 May 2025 19:02:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5CD51953BB;
	Thu, 15 May 2025 19:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kjKqSQs4";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="pU8amsrN"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 113E441C71
	for <linux-nfs@vger.kernel.org>; Thu, 15 May 2025 19:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747335804; cv=fail; b=Hmo89l5b38R1YtiZF7v+xKzE/udXGO4vt39llT/kUnIghTUFpnU+wG7rsqqnhDHKkE+ZplUSSPNS75yT8u+Dh8g5+GqjzNNjcguv3jMRaaX3Fs8b9omjAlD5ps6x6jv4keqhjJmDh5r3Cb5wqe6NqOPl+P2rtHeAucwThOo+GDE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747335804; c=relaxed/simple;
	bh=anVaN4nh45lGizAuWsn7nPQmNlGlrUeFbnAt+EteiEs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=d2WNSX+3dnApAWk0Btg5Em+aBl5QK4n+9QwRRKrukvJBm4ahktS/w7zAFaktB9O4ZPXmMJnQWDk9buL9iVjY6QLigLMjtE++H3OWO0xnAyp7dwkpZjG9eimXN5gWssarbt6rVu9wdcIyOnsSVFW41E3MVMEXa6yEkF5Z07qDlDA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=kjKqSQs4; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=pU8amsrN; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54FF1vj1006578;
	Thu, 15 May 2025 19:03:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=HGev4WMqP9xwnpxsZjnZ2FM7Ie7WUou5jAIutWsmVrU=; b=
	kjKqSQs40t8L6vqt6Fy0P7ZCOCgdfvW3B3Wz3Fa8hVWAXRtuRJBVG4B5V/GpDKTm
	zqT6oJR5fY8U2FAGzRSBcQqi9NezMqoo31ubfFkovvik+mSLm0QKNVFyZoOtovmM
	fv91kIK9vnJ9jqbBY4KIXag3yBrLju5MbdLzze3UWLV5wxIdwxncxfTZ/MUBAyXu
	WDLGy8MS9K2aNPqOIlThj/Fysit22NkGnjiA3yk04QsIjV9d3nGatwjzHTF8+NUE
	FVFtXt/mcI1e7OYAegNTqlXeDgh5y6Wv7zKNNzpStHVt/UX5Ju7OKx/5Xbn/vGBv
	OPtJKE0Y0g1L4ZJSBRXgpg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46mbcgvxqq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 May 2025 19:03:10 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54FHXtoK026491;
	Thu, 15 May 2025 19:03:10 GMT
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazlp17012035.outbound.protection.outlook.com [40.93.6.35])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46mbt9rav6-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 May 2025 19:03:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VNqw5F4KJ00ml6rhMmRQHs6gFT38M3UP4o0irEhnUPAaBifkc+odhx91ry2JK1ZM/94nddHKZbnXxtafvLhlIBpMU/TlNoStRmiNUTbj/mHjGgxcCKfUsi2MjyecKYPYUxdDnb0HRLnUa0PjmCqCa0aKhePIDydjQOpT+XdkG+aQyObf7qoN2FYJ67GCLzVsKoro+epCK58FyYEma3Uzp5o5Wtk7JYo8STqmoj7TBaQJANzsSQr4lD/b2N98JqYfm2SJcwnkoCRY6J+LNVgKSEvoj5WJM7q9VgdZIRvP5CsSO8v/jpVsqX+LJfHyDG9l/MiG4w0HS7P2zXG9PPNJVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HGev4WMqP9xwnpxsZjnZ2FM7Ie7WUou5jAIutWsmVrU=;
 b=iQkg9J8Xk0Wql+Bv4OutJxEaiiRAGYRohnjFdQ0I8+wlYwB7CjXJ1lxBzfJnP2y9i1NeMRUCT99V2ensKJFGS8LdwRpGYWim29wkEXEGpJ5yavTMZy1Q4U9Anpip5hZ5piEf333pf4uinpeaQdNy1wb7syCmxE36ohYmlTgwHYWMco8balH5jQtRKXFZM1GU4wWAusPzgdDKrq7TOKOkyol3hPJBDhEweWgD/5pgyytE+/xpSnnoXXB+oaYn+hJceasWQ1x/XnxM2hxpyMecSNoer1QGG2tbY6RTuIuVlDE2gyXVJbtdo/EMWGbvoE/2lM5pRJCDrxg8P2/HrUKy1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HGev4WMqP9xwnpxsZjnZ2FM7Ie7WUou5jAIutWsmVrU=;
 b=pU8amsrNA0z3nPvjWhL3NyYJaAaAWrB35UzzylKYk2Mn1/JzMGq6rTZ1e9MQDrQwWkLo/NtS4/STem18kfgkwqri2WNnrUvV6j5bW7yuNJLgJVVLBz5kFjgr0fscLwpkQKshL72NBlgwK+Xn9iI7nyt3tD/sORyp4fT4bMEXkBY=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MN6PR10MB7443.namprd10.prod.outlook.com (2603:10b6:208:46f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.31; Thu, 15 May
 2025 19:03:06 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.8699.022; Thu, 15 May 2025
 19:03:06 +0000
Message-ID: <948ba006-70dc-48ce-b4cb-32b775e35633@oracle.com>
Date: Thu, 15 May 2025 15:03:03 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: small sunrpc cleanups v2
To: Christoph Hellwig <hch@lst.de>, Jeff Layton <jlayton@kernel.org>,
        Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>
Cc: NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        linux-nfs@vger.kernel.org
References: <20250515114906.32559-1-hch@lst.de>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20250515114906.32559-1-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CY5PR15CA0091.namprd15.prod.outlook.com
 (2603:10b6:930:7::10) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|MN6PR10MB7443:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c99933b-2b35-4b74-ff7d-08dd93e32032
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?L204V2NoWVhTalU3SjdYekhmU3RjMDIvTzUrRlZPcFhWRVo0NVlIdy9IU0Vx?=
 =?utf-8?B?ZG9jMGFJUk9ieFZVemxjQkJBUDZwdmpXWkFvWkUzMlY2dVdYSi9LQmxZdzlG?=
 =?utf-8?B?VUI5OGxsMU1GYWZxUzNkN1ZGVG9VeEFyOWVaL2c0c0k1OU0rTk4xUGtNZlM5?=
 =?utf-8?B?blVwdWY5QVlIMEI4dk1sRmV2ZCtxWWNoTnkxYmdqZTFzYVh6NGx0WnlYc29a?=
 =?utf-8?B?U2hmWUtjR2hMdXFSdHpqRFRFaHBTYzBPekxJSWFFNmk3aExUOXBoTFpWK2Vz?=
 =?utf-8?B?bDRScTRwWXpKV1pRaEh0QnV2VFoyR2lUMFUyaTM1eFhmdW95eVNhU1hkSThl?=
 =?utf-8?B?VW1sV1ZkVm5EcmtzUkMwcFRxS1dveTVmem82TUZNMlBucDNsdy9oTCs2MjAy?=
 =?utf-8?B?azYyUU45bjZNeU1WTDVpdXlrRnk3b1ZFeXBpQW5RcFRPNnc0clhncWVDNHhN?=
 =?utf-8?B?RFYwWUh2bUxJd21TZzR1Um1rblFkd1R5cHlmRm9zQ3pnOG1IMElkT3hiWE9C?=
 =?utf-8?B?c3pINmxHOXV0TGtrV0tOK3NEclNpSXVKWTA2VlRTbkxZQkU1WE1DMWVXcnNl?=
 =?utf-8?B?aVNuM2RuUmZ4WmM4U1RCa0FXekRML2xyZUFROWlaQmxBWEVVSDNDaEtJaXlO?=
 =?utf-8?B?MDZGWGl4OUdTZDR3Lzk5L1Y2NWI0aU5NU2g5S0ptL0ZZeFhhMHNjMXpCeG51?=
 =?utf-8?B?RmpYTXhDcVFWZVZQYUtyUnI1OFN0SXduZVE2ZDdUa2N0Q1VoNzJ4WUlwTmRs?=
 =?utf-8?B?dUVidXBRRDJYeExzNkxjQUxDNDNyYnBEbjFEMGNtRC83NkhlcVd2VnNNSWJ4?=
 =?utf-8?B?RDBGMEZnbTZvUkZRTml3WjBxYmYycEFxQ2ViaGg0ZWhSWFFNblM3VnBpSHdX?=
 =?utf-8?B?MUJ5THNRSjNvTDg0bnNHSlNnc1lsY2lNa3kyRi81dFMzUUQvb01qdTNqQ2Rt?=
 =?utf-8?B?Uk8yMnl2Z2kwOURQYkhqOVljdWRESEk5ZWI4MXFDTFdTWlZET3I3T01KVW5D?=
 =?utf-8?B?bjJ5MkRxejFwRWdpSEdBWHRITHY4Wm5pOVc3R2Fiei9MWHNxNThKSEJNc2tZ?=
 =?utf-8?B?SW9xZ1hpZW95blM2VkNrVTR3SDdyUHdTaVAyMlg2VDlJd0ttRStZYy9NbkZN?=
 =?utf-8?B?dy9FbFpPc0JtN0xZb2JkQThEVkxaQUtOQzg1bkJLM2tpNXBHM1JRWlJVRHNB?=
 =?utf-8?B?Rk02Z21raEhmTnRvdGNaQUJheEdMYTZjN2h4dFdOV2lYbko0Rm4xcFo5R0Ix?=
 =?utf-8?B?S3FCUFZ5NUxOQnF1SXhhRVRsUjFLTWhWZjhNV2hSTThxS1IwSGptRHJFaXFJ?=
 =?utf-8?B?UFVMYWxobnlKb0dVMTZjQlkvbTZYNFhvcGFmNFd1eGFnUEoweDRLY2lvaC9p?=
 =?utf-8?B?UGx6VjQ5U1kyRzBTOXNreTVRaldqaG1sSlowRXhjVVNqUW5uUWlrRFhEdlh1?=
 =?utf-8?B?MDBZTC9pRk8wbWpBdXNpcUhubDNRUDZaM2JtTGhhcXhDVitVR0U2cmdnTDdG?=
 =?utf-8?B?SmcyQmM3aUIzMkdjUmFPalI5YlFOR2dwUHg5YzFUZGZIQW50eDlyclRQWUI4?=
 =?utf-8?B?ZkFwSVByb3FtMml5Rm41Q01uNmpXRC9XQ0JrZjQ0V1RJakNDUzFSREhLZFZQ?=
 =?utf-8?B?cVpsR1psaXIwRGd6ajFDWFMrVjdaellTUktLRU51ejJ1TTNMU1ZjK3JmbGlE?=
 =?utf-8?B?SGs4UDVOR3liMElOd0tXb0dBMEEzQnVtMEVZRFRMN0VyVy91bFZnZitnZ2dp?=
 =?utf-8?B?ZVU4SG5rMk9zQkY0bEtyZzNOVVMzV0RidzJ3T1BmR2M2QUZYVnFZcnFDNVQ1?=
 =?utf-8?B?MTQxQzZtTXRhQ3VuS05nSnlNVHFtNXJjR2ZnaFc0ZHRMZUNCeC92MHhSQmZO?=
 =?utf-8?B?cEx1T1ZpdldxcStSMEY3TVpUMFFXZ3JXWi9IV3BkZ0tiSzAvUXVCam05aXk2?=
 =?utf-8?Q?yw+lgf8cRH8=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?bTNLdzkwbHpSNXBWWkNOSWRyWjF1RFA2bVYyUEVEWndzVFE5cGQyaVJmeTZG?=
 =?utf-8?B?c1ZUbmlDT1BpNEI0eDhnWmV0THdMUGZBVk5sd1VmYXBxcWtpMnJzM1FqRWwy?=
 =?utf-8?B?VXpyZEFDSHd3RElOQS9CbUxDdnhSYXBCb2NEZkh4Y1E2QnZ0MlV5N21rNXN6?=
 =?utf-8?B?eitJSkRYaGRTWjhLc0JZN3ZyT0xvbXpPQ1BoN0YxMFJHejUrZWI3bjVqTzV2?=
 =?utf-8?B?UGVZQm9SNkh2dU5aazh4RHJpQVN0V3JJS1hidUw1NG5LUVMyd2wrZjRCeUxo?=
 =?utf-8?B?NFhBRXVONDgxUzBDNEtQN3VzbDVHdlJFOUFnMzNVaFpKSDROWm1aSnhialJ6?=
 =?utf-8?B?UG4wQTNMa3AvMXFJZFkycjZkOFB3SlRLQW5INmpIN1hPNG5LdXVING9JS3lP?=
 =?utf-8?B?dXZOMitSN1FJRmc1bmZSRzBWRmh2UVJJNWRadkYwNzVuYVFjTmNqMXo5ZUFs?=
 =?utf-8?B?OWJWL2NIY3A2aS82VWpKU0dDak5TaWNPQm5vS1UzN1JUM1BQQkdldG1XUENh?=
 =?utf-8?B?eVF0bkZzUkVLb3VndEpjREtndElPR3lhWEZwQmRRcXJGaTg3dmhjWmptNnVi?=
 =?utf-8?B?cElzeVdBWW9yYWZpVlhsd2tMVWFTUzBIVnhyZVluQm5GKzBmeEt1cUFvellE?=
 =?utf-8?B?b0c0eWIyK21HbysrOUJZbVlMeVh3Y2lHYUtVS0hEdm5JbjFBZ3NWV2piVVRT?=
 =?utf-8?B?TFFCQTM2VEVRaWMzVDZnRzBDVjRRQkFRVkJRcmhqRHR2ZXZMLytEZDVHNFZk?=
 =?utf-8?B?UGtZN3Eyb3lENGJmS2N3NGFPTkNISlBscCt6MHNjbU14RXJmTElPdnk1cTRG?=
 =?utf-8?B?c2IxcXZ6VURCZmRqY0ZMbEREenVXaVBobDJFa3lCd0NwVlZoU3RPQjhSQUtq?=
 =?utf-8?B?dUQvRXczdEJGYStCMEp5ei93QmNwSzV2eEZOdm9OWWc0aGszUTdEa0V3bmt2?=
 =?utf-8?B?UEY2cytFL3c2VjVLdGgzeGtpM0pyM3N5aFhxc25OTlZxWEJtbDlDNHZnR3lY?=
 =?utf-8?B?RFFqRjBGYXFTMkhyMWlhempNRURjajk3Tk9DV012VkFKaG9FSFZ4dityTU1Y?=
 =?utf-8?B?aCtaRUM2TlRXUVRWZW5tN0x3akFDSkhaV3FvaUh4bTJ4N0N3ODloeUlwemRy?=
 =?utf-8?B?Y1A2S3hLMXBHWDJLOFBnVGpMeTd0aVlvWm1SeGVwWUNuWWNDYjZFNU5YQTJC?=
 =?utf-8?B?ZThNcnY1OEJvVmY5N29FRC9nV3FPd2xkYWE3NFJvcjdNRzJML2V6QllZWU5u?=
 =?utf-8?B?emcyeFhvNjRFUUYyUlZZZ1BsOGtnRjM0elE1dzdvTEJKVm54azk5bThUOG9D?=
 =?utf-8?B?WHRVcC9jRE5pU2t4MmdkMjcrb0l2dUY2M3JmdWNyRHFwcWdaZmtPcStpRFRG?=
 =?utf-8?B?cXp6ODdScHRjVWRKVXVtc1VtUk8rZlJTWVNHazJCbnAraFdjYnN4UzdWT1lj?=
 =?utf-8?B?akRaQTVMT3FWdnBTYVFBRkc5ZE04czF0UkU0dDdWcGZld2FtaVVsLzk4WHE0?=
 =?utf-8?B?ckJBM1JMS2RPSSs3SHVYdWhxN01yTEVPOEtCeW1BakM4NTNUZllJUVFwbW0r?=
 =?utf-8?B?RkM2dGZOT2RMRExISjlxTW95aU5kRkdyRy9IQ1VHZk01M284Q05KSnVZMEI4?=
 =?utf-8?B?cFlTVlNnUWJkTVZ3UnU5VTYxVE0vVVYxN2RDS1h4cXhWYVdzbzBNQmVHcU9v?=
 =?utf-8?B?cGxibVY5MTg3VGlZZytEWWlGTFdNTTlGNHJVMDhObkg4ZDh2Z2dsbXVleExz?=
 =?utf-8?B?Ni9QMzJLcm9jbFhhY0FvVmRGUXdiUnNTUnJ3a25wQVQ4V3VuTmFKVlRpWGIx?=
 =?utf-8?B?ZndieXhFZk5lZEZBWDN6b0NDQ0daemR3MENPeDhTL28yNERucFZJblJaR0VY?=
 =?utf-8?B?RjA4eDMydDFwTFh3eldMWmZ6YzdNRDdxVis0VzRwb1B5R2lVa1F2Y2lFTTdK?=
 =?utf-8?B?dzQ0RGhCUFBXNTZIeHE0ZzZGZE5waHJVcjRLanpVcWtpai9MV04zWldVbzlY?=
 =?utf-8?B?TURhQWhsNHAwakw4cGowTUt3dHkzSnVManpBTDU0TkRNeGR3UjNoMUR6NU9N?=
 =?utf-8?B?Z0R3Wk13U01zd0liL0Eyby9DNHU2OE1rVkhkNHNTZUJvYXV1eHhIRlBkWmJy?=
 =?utf-8?B?SjB6M0U1R2pZNlArSGcyRWx5ZnRFZWROS0szaE9aSU41TE14V2ZsdC9KUitR?=
 =?utf-8?B?UkE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	EZg2YdGPEPTnj6cJwnu1Ga3gjxjLUmoRmoccUGkWvpSkeJw7mS7W6ci+e20cFrzGvjSSpj/pk7eSTkAXri5WnKpA+dtJ3pXZxq3SIBx32+kfg9W97QtM8C145u+nJN41oE6xwDSfpAesxIiKApisRIjFtRSdQDZFaFMbMKRU84wBgG/Iw6BZP3H1ya6fB/LPboRW33b5qXV3tQQURhlbwboseJBBRXg0BRvxHOyLI57J/gWJoEqwe92a4n+YA/3UOe5EJcbKrc1qqO/fjN9Vdaz3Bfmk4CUHgPyiU/Jlvo9vehCcBq9/rf9QpM77PVSxFlvbOJ5hwnjBnfEHq+ET4Mt+xY54doZQjjRrJqWwMKGyO31t+6mwcNm3JbPhZf+mOSXnTWqUQfzDJfCoha6GV269O+SWRb2vNUvAT9iQGaKjOgJjNt1Dq+goKpyEIE4pExXrco1bQoSEz3qsU37MP/cbFGoh6d8fHdw3h24ZM4M8FnSpmkhfWJF2Pj1OxzBPyuzDjq6zpd4Aiw0WR2+gy8NY0PUdpzpMtDAwHLilJtIr0PL/lBq5YqVpfR53XNjclA2dLm66IJYZ6AuU/gKK+tdxQG7QWZBb5VfbIByDt3Y=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c99933b-2b35-4b74-ff7d-08dd93e32032
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2025 19:03:06.5841
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zR9MAHKJWgiFJcyy65oEDTK1DXnGB4KoR/tf6j46AN+h+Ncg5jP2OdpRG2di0Tx1+uHcd9iMk7z2DkdESteRfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR10MB7443
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-15_08,2025-05-15_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 mlxlogscore=999 phishscore=0 bulkscore=0 mlxscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505070000 definitions=main-2505150188
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE1MDE4OCBTYWx0ZWRfXwkxgAjPjgjrh MmlqOQjyIkKptM5/65fvJu+k+EAmn7aQ8oFKmzZXniTxGrQhNmnZfz2YZ7M3UG9Kh4mv5Be6jo7 8oNA72pJAEDJnLYno5LCl30LNmx2S5hSAuiH/GQN+Gd+KxiRMK1gIdX9CZTEt1mURTfF8VuI1j4
 doqgBc7As8M13Kut0matazcruC1exdBmdYB8VwP+/hotdNdv+guwQWWbpsS9F0xRda/BMj0VYAg DQgDndHE77t9AMiGe+rGlfeo4LonlWDrHPuc9VwgVGdWREa6aHCRWuF5mQ9YrorYU9dQUhCY/0o pOts4jJrvRt8rko5lrvcnUUpo6fsQMsuP89CU1KUTwSSPB78apCvLDsWvHCwOdracz9BTzL3ZTO
 0QvIRtwzxou11Fkr9rusj4CDYOPdbc4nAvEpfwGgkZatHsdY79V10zwnnsQP1kygGbekKutf
X-Proofpoint-GUID: a5B0jZlKChwf-qygh1T47hq8gDUvZlwn
X-Authority-Analysis: v=2.4 cv=fvDcZE4f c=1 sm=1 tr=0 ts=68263a6e b=1 cx=c_pps a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=0zRzFQdiskBVQTghk54A:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:14694
X-Proofpoint-ORIG-GUID: a5B0jZlKChwf-qygh1T47hq8gDUvZlwn

On Thu, 15 May 2025 13:48:44 +0200, Christoph Hellwig wrote:
> just a few small cleanups done while looking at the code.
>
> Changes since v1:
>  - invert polarity of a flag
>
> Diffstat:
>  fs/nfsd/nfs3proc.c         |    2
>  fs/nfsd/nfsproc.c          |    2
>  include/linux/sunrpc/xdr.h |    3
>  net/sunrpc/socklib.c       |  164
++++++++++++++++-----------------------------
>  net/sunrpc/xdr.c           |   11 +--
>  5 files changed, 66 insertions(+), 116 deletions(-)
>
> [...]

Applied to nfsd-testing, thanks!

I can take these through nfsd-next (for v6.17). Note: I generally prefer
breaking up patches like 2/3 into smaller steps.

[1/3] sunrpc: simplify xdr_init_encode_pages
      commit: cee96da0c08381059771458ad46c00ed7fabfcd8
[2/3] sunrpc: simplify xdr_partial_copy_from_skb
      commit: 9a5441cbb8a1259d62bdf11deed77c172f766c23
[3/3] sunrpc: unexport csum_partial_copy_to_xdr
      commit: afd5de3042dfa3aed96774892aeee7f5592a1046

-- 
Chuck Lever

