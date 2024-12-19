Return-Path: <linux-nfs+bounces-8673-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB7C69F85B0
	for <lists+linux-nfs@lfdr.de>; Thu, 19 Dec 2024 21:19:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B0A816C19F
	for <lists+linux-nfs@lfdr.de>; Thu, 19 Dec 2024 20:19:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2508D1D63CD;
	Thu, 19 Dec 2024 20:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VPPt9z3o";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="NsP8L+lZ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4DA51D5CD1
	for <linux-nfs@vger.kernel.org>; Thu, 19 Dec 2024 20:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734639324; cv=fail; b=t6LRRWYf0DBrFU2wbJwuuonUVTVwR5OIkMOUx5AAwT4Tx6vvYldW5kgZwcayquokIypUOHPm0eYP71Jndjt4PjfgQ//fmxHQ8fRzUMYReg5H+B6WP+dzrNkSnyhV5vwYevhGnpDtJsUhy73cbo5sD1AUmSScLZBqKHj51Yub5Uw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734639324; c=relaxed/simple;
	bh=FircyynMjITWHRwA9Okn/eCwa1sBuPQ3FCl2kRQCJWk=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sPEFUdYJ11fbu2MEWnC8h8YrvfnfcN3Dnsbhx/dL19fybizbyFXvLKu1xhho+MeVRfgyUjukEqJF4WZj60rlvOod3rjNVrwR0osHRa5RR2pFDEU+Yor7JISSpJYQEAHeC3zR0c5ddnxDHEgD5UcCFg1DmWSMPY9grs7dP1lCyOE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=VPPt9z3o; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=NsP8L+lZ; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BJIMlCt030963;
	Thu, 19 Dec 2024 20:15:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=gKCmSgrhzX9rLMcM/eHYOQId5IJv6MtlML0QtLdzaq8=; b=
	VPPt9z3or7sb9VUigJiJL4uQpV0l0VZLUCv3Uv0DGC1VunUDcAX7f19iFGVwhwcx
	ixlqHeem1/XNBl6MQFyQpojm9sJLPqlKddRA+BXcQS2TZYp4Er/O7mEJ6Isf7qpX
	npex2EP6Mk5GBOaLJ6UJ1LOajwc65KLpzYrlaVInCwwTb5/nJZF1rWDn1Gt4JJiP
	fbHiuDmqV5VRIa3xaX9IrS+gMtVkR69eA4Lgq3WE3EX4UilGA9AxVefTSqnXdtdb
	vyHPO1m1d3X4J86iBaTZa0p8Is1+zPjqFxktpGfIFSkuGrIPWWYmE+RmcMZrbWXQ
	lNQ9OCkam1NcSV3eNmH//Q==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43h2jtc2n2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 19 Dec 2024 20:15:16 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4BJIhcTD010926;
	Thu, 19 Dec 2024 20:15:15 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2040.outbound.protection.outlook.com [104.47.56.40])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 43h0fbgkf6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 19 Dec 2024 20:15:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y3kjsqhvPnrxNsvo3vtL2LPIFJ1tcC0G2a5YBwXrUdsfWxzxqIVPfjzCuPHtr+vESFaHqk2T+K+ODNXcZhbSyfKXpHS4I7WdL7SMIw8PF/AX+tyAZSPfsLo1vUldEmKKiaP/s983RMt1oCniYYAnMr1U70BOcdy78s62DaKNH/4eaR2gP12IluSSLYcAwcmO689MZmjS8Ah5HxjWvoI2u9ko00dK+499K7wpYlmsLgzQCr6BzG99zy3OYieLRC2AoR6DhEL/4gzSadxF7YN5hvnLgpNvvZamslGCpRqV0eVcUt3MH9Wtg21do3vh5/3mRNBqu0p+lp4zMbsx+S5Ikw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gKCmSgrhzX9rLMcM/eHYOQId5IJv6MtlML0QtLdzaq8=;
 b=W3tFjKrwcAAQ2TvIhSgY29C6YECoFeqLdPClT0HYfxabXxQDrrEpNYDkiBpP3n9dFK+rZmHcuXWJ1+Dh9KDPfEgB0chqlwEOXN0ZuGUo34HLnRXJoSoDUdf826UISgVERqXZQXBs+4akllQ53KoUTE1OVBCd9GC0SNf+h7M3EZMflE6tooqqPvQcY94aNMeKVRQIGe0fyq1OlYoUjYKAsPz79pn4/y07zBKr6UK6cC8r0n+cDzW8R60tZprYf+n5PL5d8DPkZMhcfmieD0HTPTO4EI0W1nOahkZjOA5kFbrI8AUy6INSZy/HFfmhPoYZWOKC3PzEB5zfcPY6lVPI5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gKCmSgrhzX9rLMcM/eHYOQId5IJv6MtlML0QtLdzaq8=;
 b=NsP8L+lZ512dcQqj6qzHp29g2ucflZJbo+doi+1yWZD2L0YvuMM2jAaXFOVkNCZI8yJnHG4633quXQF3HN32vwjimp4pEipCoKcekkTwT1StcoXUL9OVU2vVcHbnBvmvUOBCOT67vH8VirHbkghqTpO1yp95mJafu4Shn/C9ufI=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS0PR10MB7222.namprd10.prod.outlook.com (2603:10b6:8:f2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.14; Thu, 19 Dec
 2024 20:15:13 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%7]) with mapi id 15.20.8272.005; Thu, 19 Dec 2024
 20:15:13 +0000
Message-ID: <49f7f3ce-bcb3-462a-b1e3-a99ffb85f10b@oracle.com>
Date: Thu, 19 Dec 2024 15:15:12 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: fstests failures with NFSD attribute delegation support
From: Chuck Lever <chuck.lever@oracle.com>
To: Trond Myklebust <trondmy@kernel.org>, loghyr@hammerspace.com
Cc: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
References: <b00b609b-13db-4404-8bdb-4550195362cf@oracle.com>
Content-Language: en-US
In-Reply-To: <b00b609b-13db-4404-8bdb-4550195362cf@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR07CA0003.namprd07.prod.outlook.com
 (2603:10b6:610:32::8) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|DS0PR10MB7222:EE_
X-MS-Office365-Filtering-Correlation-Id: a6f1b1a3-58ee-4492-8fbf-08dd2069d896
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cEtqbHVkRm5qNFc3QncwbVJleEt1TEZjZ0pHMXM4dlpRK3dJS1JDd284c1Np?=
 =?utf-8?B?K0xCYkkrOTdCRmxlNmZDYmN2WHhlUng2TUU3aU90UVpRUlJKOGVQekVqK0ww?=
 =?utf-8?B?WnJWUmcwTUM1c0VGWFhMek1LRTdMblhzNlJKQWoyZEVhbG15WVhBYkI5ZFZr?=
 =?utf-8?B?ZEdxYjczNTI2MHZ5WnM5amZtNDJBemhYUitQR1d6TTJNM1hYeEpUd3F0QnZE?=
 =?utf-8?B?S2JQZUtWYzNWQXN0dEp4ZXdGemlxdkxwLzVYYUhJRHAyQStXZ1JZVjB4OFVJ?=
 =?utf-8?B?QjF0eTkrZHBDL1RRRkJ0dUd1ZUo2L0Q4UTgrelVGL0swM3dZVkZ6V0JQOGp4?=
 =?utf-8?B?VmlBWGpHSThGQlJKZVh6NjlKS1FiL0s1cUpSRUpPSms5WldPV3d5cjlpVjlG?=
 =?utf-8?B?YzU3ek9mZVFDYkhIQ3ZuTzBleWIyT0dvZngrRHFwM0xHSU9hWGtXazhEY1dp?=
 =?utf-8?B?ZDc4aEFRQ2xmZXowUUkzRU1DMUtPRUY4bjZuRHZpbFlpNGN1T1BlVWRyU2Ur?=
 =?utf-8?B?Vnl3OWFGUUdhNjFrR2NmMHdJY0pUV214KzVUYUtDaW1QcVduY2NySkpoc0NB?=
 =?utf-8?B?TWdldXZPOTl6aTBrR2JqVHdJVDN0MUkwbE5JS1dNZGdrSDMwZW9uVjNWdUVB?=
 =?utf-8?B?VFU5dmgwS1p1b2dmVUxzU21lelkzUVM5aGR3Q1c1WStmR3ZNZVprZHJ2RTZF?=
 =?utf-8?B?ZWRFUkdCK0JHcGpTZEdGdEx5M1hwb3RuQTZyYUhTZ3RqVUlZKzdOTFhVTjNl?=
 =?utf-8?B?VVhScWp4eWYwK1oyM1ArKzJWR3hMa2dTQnBBQzJ1MU5pQzRlUVVkYmNvbktG?=
 =?utf-8?B?VW9GT3ljdjVzbG5wNFpqaEordjRzM29RTk04Q1FDV2traVh5Z016N09lTEQ3?=
 =?utf-8?B?WHRGSXRxMHc2cVlNV0lIMkRNc21XMENDY3RycEhYTU1XUFNGNkRKVVh0MWp2?=
 =?utf-8?B?YUhsUGRlSk40cXZDV29KdVFyNHBTS0ZDaGFQOEQvMHZKdWV1RVY3VUgreGpB?=
 =?utf-8?B?YTNBNEpUVFpTSVBxQm1VWFUveERkQnZhak93bEo3SXltQWtBcnNzLzdkUTFy?=
 =?utf-8?B?Y3lZazExMFk4WHA0NXlzVnFXTGNyZ3pwd3V5VDNyNWNXUjk5RG5FeEFwdG9a?=
 =?utf-8?B?V0RzZzdtTW05bjBWZzRKY1BOKzZLSkpWdHZlM3hFMVAveVBzbWpUNUk5UkpI?=
 =?utf-8?B?UmR1KzBSblUzVDg4Tk92bVlSU3IwcTVaZ3dyYUlxclo1ODloS2FVKzNOM0Yx?=
 =?utf-8?B?SDBlQVJhM0dCbytNSzdqZmZGSFFpdEJSRzVwQ1RxQS9Rd1kxbmF1cWdsUy80?=
 =?utf-8?B?SFdlb1JVc0FVd0Z2SkxqTHFCMlpzYjJNYjVaRVNJSVp5dDJwenVqMVpNenJn?=
 =?utf-8?B?QjMra2Y0cm8wVVI1cE1RSGNtbllDVzVXQy94SHBPRHJpVkhzdnFyVGlhMllC?=
 =?utf-8?B?UlkrNTkxNjVvZlQxWU80SjVqdW8wbDJGSGdldzZraG1panV5b2pzL3VGMDFS?=
 =?utf-8?B?cmlmVE1HTU9EeHRnSTN5eWFZT2JLUXdic0NmMVA3TjhpUE5SZU1PZVpSYVNM?=
 =?utf-8?B?K2p4QXVOOGhQMWkrcnhQNXY5Wnd0ZFkxWFVXU2Q2Mkw0ZWNFd0lxbWFiRXdW?=
 =?utf-8?B?dnduN3I0bUN4QjNBREZPU25TbklEVW9jdEtIMVZYOTlLS2w0d0RBYk00R3RY?=
 =?utf-8?B?c3VqZTE2dklTOFp2UTY1U2t1S3N2c1NORzFQY00zejMxdDdmMTVmVmY3K2lX?=
 =?utf-8?B?UDR4UDBFNmhKL2dMVzZPY0piektzYVViMURjcEpYNnQ4U2Z5REM5VVFmUFJt?=
 =?utf-8?B?aGpueWd5TlRLZm9zV3pzUUxnTEMwN21lQkt3aG8vU2ZaQjd5WEIzajhjOGFv?=
 =?utf-8?Q?hLYvLvkSSOGWT?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZktjalN2MDhGbE9uL3RyTDB0V09acHV1RWtud0lPNGQ1bThrOU5kSDBPcTZS?=
 =?utf-8?B?RDBHdENzME94Z0gwakdET1ZjNHNkN1RjcTgwNlBTL0tZdVVDTG9pTGFmbGNM?=
 =?utf-8?B?aFNKVDdKSTg1NjVINVZOdWJQMHdZUGt2Tm50dVU0VTlNV1NaM3lqKzRZNEJF?=
 =?utf-8?B?TGZNdjd5aitXODZtbVhjSytpWlc2Tk1KV05CYjZ2ajNZN1BlelBOOE5pV2dV?=
 =?utf-8?B?YU8yTkwzWlVpelVkSzE2MmVhNlRNaFlCRm9ub1VuTHIrTytXa0pzamtIRVYx?=
 =?utf-8?B?YTJRMVJyY2ZqN09oZk9OZDd1VmxTdFMrU0dSUk9tNEJBMVZidzkzdGRoMkM2?=
 =?utf-8?B?VzlPdk9iRWJ5VnRBcDJvb0pKd3JLV2hHTWpsZFBCaXlSTlVqTndMc3FITHE5?=
 =?utf-8?B?VUdsVG9XZnVrZzQ0Z29vbXBuYTd4cWdiNVBxRkg2RnhOM1l4TTRGeGFHOEVh?=
 =?utf-8?B?NUl5ck42VUxZS0RuNEd2WmVmQlZ6OC9iaER0SXRad3BybkdpdzBUcnE5Nzlp?=
 =?utf-8?B?SHhnVitYVFFvcDNRQmNYejRHVHNrVGZ3Um5wWkVpT1ZmcmVWZUxhNWEwSDdO?=
 =?utf-8?B?b1Q0c3I2N3g5UmJjVmY2ZC8xZjRwMGhYSndZLzhOd3pEam00U3o5TFEwMm1X?=
 =?utf-8?B?c0dUQnVYbFVhd21ZUWlreXdCSjBJQi82NmJWN3NQRGZDTGsvMmY3WmdYTUt1?=
 =?utf-8?B?dWEvRm5PUTdpN211WlFFSkdZV1E2aHBvK2pzOGZHdzZ6QU0xL3lpRUFGblhs?=
 =?utf-8?B?V2Fpc3BsRTlVakw0NUcwaWp4M1ZzMnpITzJiTzlVZnNqVStWcC9HckhmYk9W?=
 =?utf-8?B?TEVWdzFNV1U5TDJIV1VVelJIbDdWL0lOTHhaYWdCRTBsN1Nza3cwb1QvMkRL?=
 =?utf-8?B?ZkZ3MmNIbGxvMTNORzI1TG1SZjFBQWlPR3FTclJ6Q2pJdncvMW9xK3lSQldj?=
 =?utf-8?B?a05xV09nenBsR1BLSStrdWlROWt0S2VTOTZUK2lpSDFhRXpMSFlkSktyandy?=
 =?utf-8?B?di9oZ3FXeSswOVBScXZDenNRTWE2cFhYYmp6RUUvYk4wTlQ0Mis3dkFVK1hP?=
 =?utf-8?B?cmtsR1BHVUQzbFhvNVI3REN6dUxoeWQzZVRhZjFVMHgxSGEzUzlDR2lPa2JH?=
 =?utf-8?B?NnNBRXZVQXdKazVWTzV4Z3NGdHNXaENzMjZpYVFvQWE3dW03YXhKaFZ2bkw2?=
 =?utf-8?B?VXRONGpRZjhzTjJTN213Ujk3blFQb2pqMEZsb01IcmVuSWg5Y3loeTB0UTVr?=
 =?utf-8?B?OXlvSTVNQ0xUU1JTYXI0c2dvRnV5ZU9wRktUclZ1MDYvczY0SVVFSWU3WVZX?=
 =?utf-8?B?d0MxYUJMZmdHREp1UkdwT0Qvb21kSStrcFpsWFdvRmxtcmVHM2IzaGgzK3pi?=
 =?utf-8?B?b0xoaDAwS1kwZFo1Vzk3cWVwakdUK0J6T3c5UGlNR3JhVTB1SlkxN2REMnVl?=
 =?utf-8?B?YXZjNFdOalV6cXJBNG42R0tOdUJhTnUzMjF4dkRDSTRjNDZSNjl3T3BkUklX?=
 =?utf-8?B?TVFKY1FITkdCeTdUQ2dPam5tTkJIOEZOUE9NN3ZXYnpLdDVjR010dHlDakxo?=
 =?utf-8?B?S1MwRllOeUZnUVIreGtMaW55eDNiZUdEUmk4ajhxR1ZOYy81aFNVTHRDbjUr?=
 =?utf-8?B?d0RobmdSTmtTejNDbGVOV1Zabnc1K2IyT2EyNng2TzhVSHZ6Q05VaWhBMHBa?=
 =?utf-8?B?d0lTZjNaR3BPTkpBSWpOQjVITS9IYllwUkpGMjJyZWVUdFV2a3pTbEZGVmZS?=
 =?utf-8?B?ZXg2LzZITFN0US9IQlc0bHp2VzBPR0pvc1B4VTd3SzR0cHpvSDEzM2xUY0U1?=
 =?utf-8?B?MWptVnZJdWwwRGZEMThrc01ndlRPc2crZU12OHMzWVhqa1dBMjlJOGhoek1P?=
 =?utf-8?B?WENuOHpLUmp0UmdLT2lEaWsxS2xNWU9ER24xb0VYNy9Ma3hya0VuSHVrVml3?=
 =?utf-8?B?NGU1LzJ6MHFWeDgyNUM4Q29JcE1ZK2J0aWxPb3oyRVZES0JjTFZYbTJxd2hX?=
 =?utf-8?B?aUVjcGR4QVBYeWc2UlgrSTBwOWFORkU1YXBCWmNLSlFXZUlKakVML1RPY0Qz?=
 =?utf-8?B?TU9mNi91UDRyOXlIc3l2dGdXL2w5VE1jV1VZa1htVXcwZXQvR0JjY0lJVEVv?=
 =?utf-8?Q?4eBNqzY99fVpcMiViRlRNnsV5?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	A1NUYJmQCnhHNAK4uCXqJyHxLhmIeZX12X+pD0CE8fVGlrJOozTBfFvsK7SNkO7M59+cW8O0OTMIWMsc2OZQN8RpIrTiNPN51zONN3JhWr9aawBqbP9Z3143Mz/4V4RZeCOiA6+Uyc9fFoT5aIMHJfKSKhtyAT4VnCo0hJ44wU4++VYjxTfSXWh37UowjClMvjjN8PyziSBdPY3yeavitgchGhlK/VBIxJB6GzAePgN1T39LAg7WE7R50ULj8urGnkvejTskZVc933ULz6mFfkwpv3t+mC9k3Ar3TsQdwdAWf3XZK+m9fUc9tIfLec/N7JsVrzmHN9S02G4U7syRJIH/VIdbHIZA3GVIXs+INLEDKM4NdbT7XEZ48as+vPObxzzRjnlL6pdRYSYf0a7k0ypt5mH4NhIU2b5E+PDM2Es9daxblxmYj+jAXwZYuQbC3uMU601oYDpyH0KDFFbrgvlrReIxn5xbb7ZXeEVducrL8zvBswxLcNEHKIL/3M7wLhxSx4fDDdmyCsqEvBWXSVdb1CCe4C5jZgPiUADIgeks5NKNKf+guc3OegMK7sYV2tYbeluOvJ2xkuDy4VHDuTuZ4C61QDqtASB4BGPHzq4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6f1b1a3-58ee-4492-8fbf-08dd2069d896
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2024 20:15:13.5364
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7cM3Yg9prg6MZJnzMNZUxGtX+1uQSGArpojjHg/3vkOqJQp//cOltmzNPTYF6cSpKJrgdzs5I+LLK83nZPnX3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7222
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-19_10,2024-12-19_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0 mlxscore=0
 spamscore=0 mlxlogscore=999 phishscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412190161
X-Proofpoint-GUID: ZTlUrbjETywTTyOOu4QaHFl37_gNuX3N
X-Proofpoint-ORIG-GUID: ZTlUrbjETywTTyOOu4QaHFl37_gNuX3N

On 12/18/24 4:02 PM, Chuck Lever wrote:
> Hi -
> 
> I'm testing the NFSD support for attribute delegation, and seeing these
> two new fstests failures: generic/647 and generic/729. Both tests emit
> this error message:
> 
>    mmap-rw-fault: pread /media/test/mmap-rw-fault.tmp (O_DIRECT): 0 != 
> 4096: Bad address
> 
> This is 100% reproducible with the new patches applied to the server,
> and 100% not reproducible when they are not applied on the server.
> 
> The failure is due to pread64() (on the client) returning EFAULT. On
> the wire, the passing test does:
> 
> SETATTR (size = 0)
> WRITE (offset = 4096, len = 4096)
> READ (offset = 0, len = 8192)
> READ (offset = 4096, len = 4096)
> SETATTR (size = 0)
>   [ continues until test passes ]
> 
> The failing test does:
> 
> SETATTR (size = 0)
> WRITE (offset = 4096, len = 4096)
>   [ the failed pread64 seems to occur here ]
> CLOSE
> 
> In other words, in the failing case, the client does not emit READs
> to pull in the changed file content.
> 
> The test is using O_DIRECT so I function-traced
> nfs_direct_read_schedule_iovec(). In the passing case, this function
> generates the usual set of NFS READs on the wire and returns
> successfully.
> 
> In the failing case, iov_iter_get_pages_alloc2() invokes
> get_user_pages_fast(), and that appears to fail immediately:
> 
>     mmap-rw-fault-623256 [016] 175303.310394: funcgraph_entry:         | 
>        get_user_pages_fast() {
>     mmap-rw-fault-623256 [016] 175303.310395: funcgraph_entry:         | 
>          gup_fast_fallback() {
>     mmap-rw-fault-623256 [016] 175303.310395: funcgraph_entry: 0.262 
> us   |          __pte_offset_map();
>     mmap-rw-fault-623256 [016] 175303.310395: funcgraph_entry: 0.142 
> us   |          __rcu_read_unlock();
>     mmap-rw-fault-623256 [016] 175303.310396: funcgraph_entry: 7.824 
> us   |          __gup_longterm_locked();
>     mmap-rw-fault-623256 [016] 175303.310404: funcgraph_exit: 8.967 us   
> |        }
>     mmap-rw-fault-623256 [016] 175303.310404: funcgraph_exit: 9.224 us   
> |      }
>     mmap-rw-fault-623256 [016] 175303.310404: funcgraph_entry:         | 
>        kvfree() {
> 
> My guess is the cached inode file size is still zero.

Confirmed: in the failing case, the read fails because the cached
file size is still zero. In the passing case, the cached file size is
8192 before the read.

During the test, the client truncates the file, then performs an NFS
WRITE to the server, extending the size of the file. When an attribute
delegation is in effect, that size extension isn't reflected in the
cached value of i_size -- the client ensures that INVALID_SIZE is
always clear.

But perhaps the NFS client is relying on the client's VFS to maintain
i_size...? The NFS client has its own direct I/O implementation, so
perhaps an i_size update is missing there.


-- 
Chuck Lever

