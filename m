Return-Path: <linux-nfs+bounces-9183-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C627CA0C46D
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Jan 2025 23:12:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83EC73A5EF5
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Jan 2025 22:12:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 699A01E9B13;
	Mon, 13 Jan 2025 22:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ODUVon44";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="qPeiPmuk"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4DA11DE4D5
	for <linux-nfs@vger.kernel.org>; Mon, 13 Jan 2025 22:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736806350; cv=fail; b=AqTUnU+mDWGg8hT1kZf4646tdO+bKJTcNeXFudWfmiNGrRg1OczP5TkeRVoBmq4LeV28YbAEkyCdeXCymv8yZ09OJlN7/qvajpAKHKKh87uXdg+jlOHmRLcwemYn8V0btd2S+dvls5qk0pqRUwFhu5xQ7+CUdM5pS+JzCgUgMc4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736806350; c=relaxed/simple;
	bh=pYtZB0jh3R+c0VYVe6KWc1xFXZt1oVQumshpLafufug=;
	h=Message-ID:Date:Subject:To:References:Cc:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Fv74+tBjdPd+8dPR1dRlD0IIbFyHNFPbhIK86217OmsFB+av5YjIKXsR1dHmqWpEcrVM2UsAqUVECl1dnnrNY91vUxcYhr1DpmKdS7dAAIgqGQJOf6yT+YmHIiUufb+zh4T/BlrBurmRNxxYxRSQho7yAj0cFO7Oy+MyxUKPYkA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ODUVon44; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=qPeiPmuk; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50DMB50Q014405;
	Mon, 13 Jan 2025 22:12:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=F5b7T6qvBWign9wGl4ZHU8wLAPhrZnYXcZWFdqoXu44=; b=
	ODUVon443rQTr8gV4MlIQInSDgrRQ+NDvEH8amXecVen/dkYN97RbUE9FYKKSQAE
	2ypRhnc31OX3ctiqRxciEuJbekmZ08FgGMwx3nw2+VC1EwgTeeq1oo3ndIk1bH+5
	3YKXuT+rheHS6E4dY5uVx2f+o4CcutrhL6eNhEX0KA7GTQ1nlLYUrcnmjtpsEuw8
	I3FtdcSbRcqvDzU2JmJqif6femywLBeSX9Jlcb7aRR7FT3sBfhLkf2p61KqsH2U2
	fwFKKnTMpQkE0v2YICPJ/5goz9i9wZyCGmZFlx2sKB4Kb48O5efd6MWZWyxD0rEO
	XuKLrV1yySJ29f9F2VgCeA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 443h6svkcy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 Jan 2025 22:12:17 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 50DLdKmI040378;
	Mon, 13 Jan 2025 22:12:16 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2043.outbound.protection.outlook.com [104.47.70.43])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 443f37hjjw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 Jan 2025 22:12:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yFOiOi+RcoG5MYRoqjfHjUnlyGW9iOH4uV5oG9NYyNLQcRngzkX+kYzWp9KYdbyrRYnCEHH1hj4fkYI8lNmJZyqn9zq37J8zylQX6DxFJIXTMlJKzaFmb0/EZkemhfh/qJy5JRO+jn0aufxzLKN5HcVQd6dAG2vcW9yGcnRmSThvuYvK++izTkN5wpT2k/I6w2lJpZO8E2ENv3cdqEcu+ckqQJleKlEQiliuaFobl+dwkxm1qtpkS4BTldzL+HHZL/s6nj4q77CoXvo5JxkulhtJYqEoBOlkqgBLZxXQU+z9JUIYNeC3UMxf/k2UMmS3wu+HGNO/XxWs/+MrPmm7yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F5b7T6qvBWign9wGl4ZHU8wLAPhrZnYXcZWFdqoXu44=;
 b=WD6btHBgGf5o3kyy52GY8SJKtIJ4pbq9+tUb+ayMOH9AWgd/iTX2j8YeeYEzXVrgMolVawulgP5y4IkTDqg6076V+o8+DOoGo+IKzT3HuXmFn5EYk6w3Cd3xh1MgztiWmsFUWDdMuuwKgslZQgDM0MwT3RvCcMbxk5GDmnU7p31Xcc1aDBzkZOsjUygNKWg9yPxbf3G+mXSOM5e6dPQq0npf5+TLEirNjm2f3d1djMy5C/GWz2wNDzIMVpHOA3Z30GUVzEIPvX7bkSXrlK+gx1yJNlCbsvnPmEBjoCMLFnZSl2Ax9KQocSQqVufrBQPlXfIQZ2lm+TOisY3l/9/ssw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F5b7T6qvBWign9wGl4ZHU8wLAPhrZnYXcZWFdqoXu44=;
 b=qPeiPmukBZO8RuSLm7L008+FoYNcyBNQmWrgrUhs7S2sp1shXqZFITtMUTGNxS5WKY2WvSTvGFQDOM7zIlNmopIcUCNnYo7ljhJlsJNV+Fk5czB630SIdTUTYxnDGM8XervEM7eNC5qgI334qes2Rv7//DtnB8idb9sZ2kIniGQ=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS7PR10MB5022.namprd10.prod.outlook.com (2603:10b6:5:3a3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Mon, 13 Jan
 2025 22:12:14 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%3]) with mapi id 15.20.8335.011; Mon, 13 Jan 2025
 22:12:14 +0000
Message-ID: <cbc55c4a-ac98-4121-b590-13f32a257d65@oracle.com>
Date: Mon, 13 Jan 2025 17:12:12 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: nfsd4 laundromat_main hung tasks
To: Rik Theys <rik.theys@gmail.com>, Christian Herzog <herzog@phys.ethz.ch>,
        Salvatore Bonaccorso <carnil@debian.org>
References: <CAPwv0JnSQ=hsmUMy0VY-8k+dANBLNkJdFJ75q9EEE+Hj0XXB8A@mail.gmail.com>
 <d54d71f7-9bdb-49a4-8687-563558eca95e@oracle.com>
 <CAPwv0J=oKBnCia_mmhm-tYLPqw03jO=LxfUbShSyXFp-mKET5A@mail.gmail.com>
 <49654519-9166-4593-ac62-77400cebebb4@oracle.com>
 <CAPwv0J=ju3fZ8C_FFeDnzzKT-ppXaLCde64hQof3=g641Daudw@mail.gmail.com>
Content-Language: en-US
Cc: linux-nfs@vger.kernel.org
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <CAPwv0J=ju3fZ8C_FFeDnzzKT-ppXaLCde64hQof3=g641Daudw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH3P220CA0010.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:610:1e8::20) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|DS7PR10MB5022:EE_
X-MS-Office365-Filtering-Correlation-Id: bcc1157c-a765-42a7-2564-08dd341f55a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NlRUM2VsNGpOMEVQMk5hWFBuNGlSUHFaNjYvZHhUeUt0cEZta2I0SVBScW9y?=
 =?utf-8?B?am1mUTRUNnk4SDhVQXFxcWp5ZlRNRzNmZUl3eWxyd2U5ZVZWaklSWnJicUNQ?=
 =?utf-8?B?S0tRcCt4OTVJNSs0aWQ0NXAzL1c1alFXNWJXMDVCcG1xWjdYMk1mNVM0dGN2?=
 =?utf-8?B?aUdsbGc2dzAzcWtDK0RocHRxK2Vpd1dvVW45dCtrVm03dTdvZWhKcTRuOG9H?=
 =?utf-8?B?QnJteWZBREM1Z01WMHhaNG5EV1hqeW5zU05Bby9xL1ZUU2U3OVdvRER0a1V0?=
 =?utf-8?B?U1E5aUFDaDRaNnFZdVNhTkN6THdLak9FLzBLN0k5QjRXSW5LMEl0Slk0VlFI?=
 =?utf-8?B?T2hYR2hSOEFId3RBTFFpTzVmbzVqSGlOeHplblpHR25jUlhjREZYV3hXK25v?=
 =?utf-8?B?bUZ2L0tNTktCd21OZXlXcXlHVEdZMzhCaWNzVmNIOG12S3gwQkNyYjNpQjRx?=
 =?utf-8?B?RFN1OVlrYzhDNUNVM2hOUVhYekl1UzAzVE9wcHU3aDFhNERQUDJtU3ZVV3M2?=
 =?utf-8?B?cXpEbG0xMDd4RE1DYW9PTElRK3JPVHh5eFhBVkMzMXF6OGU4aFUyYTJkRGs3?=
 =?utf-8?B?UnR5cXZtaGVCRXFqTVo3U2FtazFFT0svUkkrNWQwVlFHKytLWkpadU1qQWlW?=
 =?utf-8?B?bnV3eEUxVUVYUDVXZ0ZQU05paFlhUDg1VXJRMTdsZW0yZHFzaG5jalJheXRa?=
 =?utf-8?B?TjBReUhsMVltMW1DelVzQnZaclZXRlZXSVo2eVc4M2FsQkdITXRSM25WTTE2?=
 =?utf-8?B?UFdSV3NTeWNNeS82V1B1VHhpNkp4VnorSG9oT005b3ZMM0NIV0Fmak1pUGtJ?=
 =?utf-8?B?a3JVdWNjelppQnJRUy9UZFVLVkVvTHdkMDJieG1yY043RVNEd0hEcEdWTHN6?=
 =?utf-8?B?VTR0aEZQdnc0b29kVmlPWlJCaUlWQnVpVDBheFpVallScmlyRFFvMW91Mngy?=
 =?utf-8?B?cFFTNExLa3pMYkJxVmlWOHpXZUtURHpLS0RjY05SSThrczN0cmpPZXFleHhz?=
 =?utf-8?B?ekk3RGF5NUNabHk4a3JPZWcrMXFWQ0crRGZtTXVJMzZISDRTQ1E0WmlMRHNl?=
 =?utf-8?B?SkZTV1JmaUtiaWxMdVgyYWwyN0c0dXJ2aXZrR0xqNDFndlAvdGpvZTB0WHBt?=
 =?utf-8?B?Z2VBaEJFK3F2RElETlViTDNsK2doWXdrOVFBcjBnZ2RpR0xRanRESUR1MGFL?=
 =?utf-8?B?VXpPSGRTWUVJOUc4MUpwbU41QzhxMEd1ZzJjcUhwNm5FOU45bW5kNjN0L21D?=
 =?utf-8?B?V1NNWTJrOFZDa2V3dmdnMFVEeW51ZkZiWXd3cVZMQ3hNcVI2MXo4YTVka2xW?=
 =?utf-8?B?Y2xmRktYNU1LTUM4VnlYWFFXaGdDc0YyeU1DTS9mWW52dlBJNVV4WlcxeVda?=
 =?utf-8?B?Ym12WWU1bjRISmlFNkszenFkMGxGYXowdEVKOVB1SXd4TFM0OHVIVzduYnNH?=
 =?utf-8?B?QU9NR21BMDdEd2dRSndhTWRERno0SnFWSUZjckVDeGFoeXBQdndVQURpZjh3?=
 =?utf-8?B?akNVR3JWRFZZQld1NDVRZUR3aGs0NDZ3OE9GN1UvNEtkUksyN1ZKVHgrc0FQ?=
 =?utf-8?B?SjVWTU05Yk5pMjZSa2RCWXBUOTdZZkRiMzcwdExjbkpKN1FNSXlFUllOTSt1?=
 =?utf-8?B?RkJoaUo0OEZtcjdpdjd3ZktkQ0JyWWdWNFhoa09ad0l0U3ZNSTNrSlNnODZa?=
 =?utf-8?B?ZmY1SjIxUk9YZkhMNVBMRFJvSW92bEs1VmM3dFFQUWhEdGtSS2orUnNFSTM0?=
 =?utf-8?B?QWtjSFpncWlqVHAwa0tYcTgyczVScnQyNE5oeWwxazZSUXppNi9Jc3YwbzlB?=
 =?utf-8?B?M2RzeDFBSUNqMVJ2eDdKVkJzRnNoOUlCOUNMNndYZjhQR0haWHdPMUI3TTZ2?=
 =?utf-8?Q?lyCnLJAcFKBwZ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Zzl4aXcvZU9yRTNaNUxtenhRL3NhUDlQeFhhWHM3SXRtZlQxWFVaTlNQNWR2?=
 =?utf-8?B?Y1VXWk85YmxWTHFmaVZ6OWlxQTFzeVRMU0FtSENXTVIzajd1WDlMelFvOHFs?=
 =?utf-8?B?dkhaeG94L2h2eHlIcGh3Tytab0RwL1YxMzR2SkZOTThWbXhLTFBYZzJkNHZi?=
 =?utf-8?B?U2xLdllUSVdweHZ4TnJZSzZtZHVyWE1EWWdPODl3UzlHdkd1MnpGbnN2UlJJ?=
 =?utf-8?B?bG9WMm5JSjZEbVVhRVpkbjVIRWcxUEltK0VTbkJWZm53MTk2YWFPTExzOEtU?=
 =?utf-8?B?K2phVHNjdzU4UkM0SHlhb0c5UVRMWTFmTjBGVDRqOUs5VnVHREVENXA4aWlJ?=
 =?utf-8?B?Mm9hdWFyQ3A5T0VjZnpJV3kyZXJJWjhRVEoxV0pFQS8xSFQwZ0RTUldtOVRS?=
 =?utf-8?B?aVg1WnM1MlU5RFJ4TjBQcEo5Y285UHFnY3pPSTZKRmROL3lOU01pNUVmd2xl?=
 =?utf-8?B?cXF5ODBJN1VuazZISnpoQ0JHTmE2MHdNZDBGbDVJeWJQQzJLZE9QaUZBN0dn?=
 =?utf-8?B?MHVONVBWNTRWWWJ1OERZOVZ6KzY1Q3BoRzJ5b0FOVDNjbGlkTFVMaFluWDJH?=
 =?utf-8?B?RGdpTUxZRDluemJBUlNBbENLbGU0TlVuUnNxYlJxbk5rOWR5SnA4V1NQUnNs?=
 =?utf-8?B?VDZaU3c3TTF4dG55UVZTSDNrSkRzSERNM0ZjcWtxbHhPWnJMUktOcU5DUG5H?=
 =?utf-8?B?SGF5SDFhUnVSSTg5UzhxMWxsMU1iMXdVckpGOHNtT0d2MGIydC81OVZTMVdz?=
 =?utf-8?B?ZmhKb2NYSW5wVS9YT0IzcklPRkdLeUlHanZneS9qalhEaXZTUVRRcmJPKzBP?=
 =?utf-8?B?TTNCczBSaDNOdzJjNnFCZnRKK0YrV013bEtzQ1VaNXF3WDdrOWVMdEozVUtX?=
 =?utf-8?B?VjJRSnd3ZjFtY3ArSExOOFQvWFpEdW9sUGNOa1J2WDM3MWFiWlpXbHVoSCtz?=
 =?utf-8?B?dUJhckdjSzFSY2dEMTJSempFSUUvUmxtZGNma04xd1Q5czU4N2luYTZwUkRx?=
 =?utf-8?B?VWN1cDhlK2VXaG1SWEMzazdzVlJOeFpkVExyckd4QUpkOHBJNTB5SlU1RHB5?=
 =?utf-8?B?R0VMazB2NE5lLzFjZTVRK3NFNkFONG9MYmN2KzhHMVN6U3B0NWdHQ1hNRmlM?=
 =?utf-8?B?UDR2U041dnpMMncrQmtPZXFuckNPRmoybVNxbXlwQlVzZ25EcFhCa04ydUtB?=
 =?utf-8?B?ejArK1lDV3dXaFNUUzN0ZkRFRXRzMWYyMFZOd2J6a1pQbE52ODFQUTExd09S?=
 =?utf-8?B?aWtieUVQaW1oZjgxZGNiRnJtV1FWRUlRQ090V214ekRPbFpIUDJYenkzVWho?=
 =?utf-8?B?YjBSK1NOWkk5eXJSaXNZQXJ3cS8wSHVKNkU1eTdTM2RWdThaT1FOMVlTdVZO?=
 =?utf-8?B?MFE4UHpuNFJIeEZjVlNFYWdpTFBDSURHd0FpdU8wK2xUNnpZeUsxSEQ2bXh6?=
 =?utf-8?B?M1ZWdTVHRmpIK1RIeDlrbUxKSUQ3UW9PMVJhcVZla0p5OFVWd25uQTNCV013?=
 =?utf-8?B?K0ZSaE9HTkE3WWdkL1dxTkgwVFM5c1hJWXVHd1I3QVZMTVFUakh3YWhzN1g2?=
 =?utf-8?B?S0kvSmw5SHdjYk91aFQ3eFJTVUxDNFFnVVFMdDN0Z1JEVnBmWHVsbnExdExs?=
 =?utf-8?B?eUdERy9GVm1vZ3JiYXRSY2dEQlhnTFRjdFBhSTdXaFhJRmxVNDd5RHFMeG0z?=
 =?utf-8?B?ZlpSNllVaDBjNWxIWHVmc2c5MEF5RkZoUUVEQU5rUkJTZFN6Tmw0WVJvMDRW?=
 =?utf-8?B?eVk2UUlFaHVmYS9peTQ4ZWhkNGZZam1KbTVEQzlCeWpwL3UxTHdCY3JTZkFC?=
 =?utf-8?B?L0N4a0ljY1p4ajE3UFdla1p6dk8vMkxIY0ZpU05hUWRrU0JwaUZoQ3dXd1kz?=
 =?utf-8?B?ek0yWG43NVhHUXo3UUFYZ3lEWGEyMjRQVlQrZlRzeldvN1NJTDROV2haZ293?=
 =?utf-8?B?WUw5aTZYSHBSZmxIY3JXME9BQy92TjBlOVJIRW1VaGdPbnYzRzNDbzAvc2Zi?=
 =?utf-8?B?YXM4MWZDaCtVQWR0MVNpRHFwSHRpZ0ZPelFEU0JBMStpYnljcTJSMjZrWGhO?=
 =?utf-8?B?dVRvNVJ4am9xUkRxMENpSEE2bE1SUmU2VmJKTWFyNlNiSm9tMmphYVRzMWtx?=
 =?utf-8?B?clZzWGV5dzgzeDVkWTU5M0MwTWtlbnhmK1EwT0s4dWtVcTFKSElFQ3RsMkdH?=
 =?utf-8?B?U2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	0Qa8biSDhmwqLTw/qM5YYWt8HOuD68Zj2zkhwDEHqehJ+uvlNhZI+6rvk3q1WU4gZUZ5P+Ft1nIFMwU3OPfjTGRF9cFcBAkFym6zydlHE5jENBRaoHQU3Ngc3tiOKZ3V8T6Klpng+G/xeIXS9AseGSXgpCP7oHc5oax/YuV3IfuxhbJBycwY84uTfuog1sHftDGehCQ4aYgjH42cgjlsO/gEU/pgHV0tif11IURgffxKEkdntuiUH0At3tMR8j8hQ1aJ6xXTq/1NSuP+GHfPVztNp0NYER18N6gX2SMFAOA0gJ5LwKwwy+nvx34U54PsB7ho876T2TNYH6XUqm50g9x5eBRuH617pacPVvRJBvMxtCRjHvq9+pMn4PKNma+OyDmLBYnlBbkOqkf47ZGh+JJlWd0h3nnIsu1Bd9487UXv75DwJJoj7qGQzPxOrV0r9AUkK+CIibcfPiWgCVj7+M2kmBaULofbOJnV/UN6fl4N6jTwFLg4VEXJWFd2zhLwNawMNWkeVoac6X23Ci646pNJVbTgCLGKP9djhVi1FcmkJpPN+m4g2M5rA2TCA3Gdgi0iGSu28Mv+FQYRiBxNeK+dAsvDLsP21bcAyuBKXas=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bcc1157c-a765-42a7-2564-08dd341f55a1
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2025 22:12:14.3205
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q5w+QME3fAbclbJV4m0317na56elnNCaq2L70EamRa0qn4w5rHTEHj1vuMUIOt31Ufc7vBVpUjLr6qVfPWRZQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5022
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-13_08,2025-01-13_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxlogscore=999 spamscore=0 phishscore=0 bulkscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2411120000 definitions=main-2501130174
X-Proofpoint-GUID: 8y1qOxxExoyH20StAsfuBMrQWF5sMvpL
X-Proofpoint-ORIG-GUID: 8y1qOxxExoyH20StAsfuBMrQWF5sMvpL

On 1/12/25 7:42 AM, Rik Theys wrote:
> On Fri, Jan 10, 2025 at 11:07 PM Chuck Lever <chuck.lever@oracle.com> wrote:
>>
>> On 1/10/25 3:51 PM, Rik Theys wrote:
>>> Are there any debugging commands we can run once the issue happens
>>> that can help to determine the cause of this issue?
>>
>> Once the issue happens, the precipitating bug has already done its
>> damage, so at that point it is too late.

I've studied the code and bug reports a bit. I see one intriguing
mention in comment #5:

https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1071562#5

/proc/130/stack:
[<0>] rpc_shutdown_client+0xf2/0x150 [sunrpc]
[<0>] nfsd4_process_cb_update+0x4c/0x270 [nfsd]
[<0>] nfsd4_run_cb_work+0x9f/0x150 [nfsd]
[<0>] process_one_work+0x1c7/0x380
[<0>] worker_thread+0x4d/0x380
[<0>] kthread+0xda/0x100
[<0>] ret_from_fork+0x22/0x30

This tells me that the active item on the callback_wq is waiting for the
backchannel RPC client to shut down. This is probably the proximal cause
of the callback workqueue stall.

rpc_shutdown_client() is waiting for the client's cl_tasks to become
empty. Typically this is a short wait. But here, there's one or more RPC
requests that are not completing.

Please issue these two commands on your server once it gets into the
hung state:

# rpcdebug -m rpc -c
# echo t > /proc/sysrq-trigger

Then gift-wrap the server's system journal and send it to me. I need to
see only the output from these two commands, so if you want to
anonymize the journal and truncate it to just the day of the failure,
I think that should be fine.


-- 
Chuck Lever

