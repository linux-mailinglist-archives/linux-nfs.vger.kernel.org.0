Return-Path: <linux-nfs+bounces-12268-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 32817AD3B90
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Jun 2025 16:46:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FBFD18847C6
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Jun 2025 14:46:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0660778F39;
	Tue, 10 Jun 2025 14:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JomB3YxU";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="VXXncev0"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B0B81E5205
	for <linux-nfs@vger.kernel.org>; Tue, 10 Jun 2025 14:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749566747; cv=fail; b=LE74zFVHDJOn0D+71+zaBa9ES15S+Xajk3P9KNv7W+3Y1CtTLsiVr0KgD/kIy7f20djGIAshMM/Ot/kW+4SkxBgDkbLHv8AVOlvQLKGZGvvXZUJ0gSskEEuGwq1xTOUU3BzQzOyFYojaUI0vnUdudGVkDL/g3jLTt8c8lvfuBXk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749566747; c=relaxed/simple;
	bh=WttJv4yXc4JacNWo/ha22gOpLi2xFdS2IwqfrY5YzGA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cemsahUjKU+mPEPUU9vbgXuW/fdFM/fBlce+81vxxdHnh/sDlc23MiVSdBD4JliDkC9egpaLh+asxpKcPDdf9S/dHbumefL2+yyS9a4NosmmPSBnsT8BUcrQbj+4Te99aWLPI8CZkQfavq87FdDcjrIUE6V+VDVfocr1I8kvluo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=JomB3YxU; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=VXXncev0; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55AEXdT1006981;
	Tue, 10 Jun 2025 14:45:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=bRTnyXESDhr0frsqYkbVFa4oOe2RcgMcOm3RRxAY0fE=; b=
	JomB3YxUI4d4wdLsgPCTuhLcLXHiApKbmKhjQheGjMtW0nnReueO8y9de4yP1nkV
	MmVPIHlKaKjmg21B8atLW2O4NfPgZgaOHzg4wnU21mu7ii8d3xEegYPMQaMmSuCE
	VpUrV/n2RGXJns+n0ENqnISi0Tlw4sunrmXdtcrHlKYuDKnWFVnW0dTescMjXar5
	xg9P+RewgLtTSp3p1A5IRimX3swYqgGcMndbSgvLUbjxdIj8eyeZtHmvwGKF1RCT
	Mvjvv3JrtN/R4oN2TkbaIstorPQUKfUrWoNsULDXESMhe7XAmwFD0DABybVcw5gl
	l9LqR3LLzRMHEoD9b+JiFw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 474c74veva-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Jun 2025 14:45:39 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55ADo7hf011859;
	Tue, 10 Jun 2025 14:45:38 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10on2076.outbound.protection.outlook.com [40.107.92.76])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 474bv9tgby-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Jun 2025 14:45:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lVQVQ5b4Dc3v9FU3lOTxdsPyMqq7F+SnXXBcEczTlSgSSpQ/uF3mq9UjTuJ4GvHNV1E1FDn+p4xLXsIufC7nHsQZQ2sKbq9Wlu09qx1SvFENq/FiqTAG//1OGOcnE0OC+RTRvvxc6cIdIHRXhT9qHJSV9A5ztXbqR5X5t1vWOeOsixqKtJQlpx/66EuRERv1+/u6avh6oYsfdrcE2/yaxaVUGMEDpdc4nOhHu6ViSFsm5JkWDiImflDr3Nb+eoOD3BjfvWBTzlT4jW+3qartU9Ednc9PmiOICHbGgZBRXwm+MNIZWgbrS6HmRjBqI5/ssx/qKVfBYOKBlHqofe/Twg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bRTnyXESDhr0frsqYkbVFa4oOe2RcgMcOm3RRxAY0fE=;
 b=U/UknqP3bsl4YVMtDxvvkBVFPJSySM1sYb4vI1huNBKyTBjwkDJAGHpZZiOhLDQIzS8eASQclp4rcfOrSCUamIRS7rVnTuB+gYPfvtLuraRHZzlLcH2IhopdEpm8JGX9XHORf/Hznh3tXdoKehP2/57y1oVlTRmj6BY4GCPRO/CeXO+xoaCOqUxbQ2La5Xuc0Hk2mUXyO1nsZWGX9/cO0mzpX/iLtVKfSE8/PhCdHlqQue3Tu3EO9kG0YZD8XLPAtN5Kr64g7EK0r4mgmSoO9cumspC4Drpuv8RwwOqyvc8YWKecDRrr+V+6/2BjbUv4muodFZN5VwDJOHlkoEDLbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bRTnyXESDhr0frsqYkbVFa4oOe2RcgMcOm3RRxAY0fE=;
 b=VXXncev0IAfhqJQy8sQAa7fjzWw6JQ8gYfrRghS5xUDdzbdFgjh0BRWTqmU5tZX/522X69X75+a1551j8QQVgVmGsj512502SsCilimXIKi0iKp7Qu9v719y59a0yDT6DRjvHprscHIhmCSAFpgk0ESYkwtoYb/dGWtWaWJCgs0=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS0PR10MB7150.namprd10.prod.outlook.com (2603:10b6:8:df::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.26; Tue, 10 Jun
 2025 14:45:35 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.8813.024; Tue, 10 Jun 2025
 14:45:35 +0000
Message-ID: <be0ee860-6fb6-4ca6-8742-7be730365a3f@oracle.com>
Date: Tue, 10 Jun 2025 10:45:33 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 1/1] NFSD: detect mismatch of file handle and
 delegation stateid in OPEN op
To: Dai Ngo <dai.ngo@oracle.com>
Cc: linux-nfs@vger.kernel.org, jlayton@kernel.org, neilb@suse.de,
        okorniev@redhat.com, tom@talpey.com
References: <1749565902-33511-1-git-send-email-dai.ngo@oracle.com>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <1749565902-33511-1-git-send-email-dai.ngo@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR14CA0046.namprd14.prod.outlook.com
 (2603:10b6:610:56::26) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|DS0PR10MB7150:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e1e4f05-1cbc-490f-bbb7-08dda82d7525
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?cWkrWkZnaWtEUE1kYVNGcVhKaEJzQmNPMjVmUEJmNFpnandOeFFTQnZ2Z0xI?=
 =?utf-8?B?U0NHQUZ5dEZUWkFzWkpCdUo1eWwzU2trOEQ2blJRWGo4VGZ6K1JaZTE4S09S?=
 =?utf-8?B?RjUzSGN2NUtJem1oQWhSS05HNG91ZWloaHMyNTBpVG5QVU1xUjRjdm9YMHBN?=
 =?utf-8?B?dnovUWZ4elQyNkhyOGpvY2hqNDU2NkM5anNDRzBYMDlWaWFLSkhXVWswNnM2?=
 =?utf-8?B?cWY2T0pQSWlPSXI5eTFURU9admZDOGRYR3N4c1dGRTdsdURnbVJ6Z1RVYWww?=
 =?utf-8?B?QkpkbTgxYVBRakJxTDM5YXlwU05GNG1mQ1RGUkdad2tjSkZuYjZkakpHdlRi?=
 =?utf-8?B?b0RNQnhPdHBWdW9Yd0NUK2JDQjB2N0tvUHpSQzd4RXFXeWhPeXhOZFE5M0lT?=
 =?utf-8?B?ZVVzQ1RFK0hzeXluS0NnRFlGNlh0blZ0SFV6SXRVZEFBWWlFcWc4dHlONGNU?=
 =?utf-8?B?MVprcnkyc1owVHU2eElheFVMYUhRbEhERHE2dlZUejRJNVI2OEhEUnNaYlpu?=
 =?utf-8?B?VFlYQ1NWU000dmt1UFJUeXkrdi9yazhON0I4dWlXZVdhK2tDQVB1Yy8rWHFn?=
 =?utf-8?B?bkZwb2tjb0ZZYm9aT0cwbFdtK2RtWXlzeGxlSzZQR0Q0RzVBb1RxRzZYaDNl?=
 =?utf-8?B?RUI1amtBYU1lclh1SUk1UHU1ZXZ5Vmk5NkRGRHp2N094cUFaakhFRkU2c1Np?=
 =?utf-8?B?SStKNVpGNnNadzVyWEszOVdBdHVWUUlOMy9JZFBHQjYvQkJVR1A4dk9pSzA3?=
 =?utf-8?B?RGIrcVZMcEdSVWFhQUM4aFh0QXdGZ0pPczFhQ0p5TVdlVVc3UUY3T2FVNVN1?=
 =?utf-8?B?dWQwTm1YV3ljTHE3Q1M0QllHaWdJRS8vaEM3REZ1Z2Y0VVFZL1JHcktKa2hp?=
 =?utf-8?B?by9YVWVOaVdIK2k5bVZWT2ErcWdqTExESDhoby9wN0U4VlVjZ2N1cmtodk4y?=
 =?utf-8?B?ZGpidzIxYmd2NjZoczNMZFMxcjZaeTNPT3ViYWUrZUd3bmY3ZnJWQjNDWHBk?=
 =?utf-8?B?UHhQSnBvZm1jSldnc0NDNDZuQXBJQjNHREVFQmo1c3JYcnkyTEtKK2ZsQmhn?=
 =?utf-8?B?SDlGbnRCakltNXZVQzlOcHh4elY1UDEyVzN5d05xVzBHMFk4WEJoYUltc1or?=
 =?utf-8?B?MVQ0c1ZKZUdpN0Z5MVRzOGhnNUJ2Wnd1RC9jWGxKb2FOaEN2bFRzY09mM1Bh?=
 =?utf-8?B?TXBzYkh0NVFnT3hFNGs4SSthcDk5dUFPVExpK2ZpSEJkZ3hPVEtML1NLMWdq?=
 =?utf-8?B?eTV2S01ZblpoS3N3azE3MHpuL1NCbk9ySzZuMENzMFpENGVkanNBNHE1NEM3?=
 =?utf-8?B?SVRsbWJmeXhNOU5HUzVtMzNvNldqdGYybGpRQXNSeDJ5Wml2dUljL0F3dEtE?=
 =?utf-8?B?RzYwQUtkRno2WVgzcmNzR3BWNW1idHp5bHJEalJqYWhJdUpmcHVTT1BBUC9i?=
 =?utf-8?B?VmlYRmxweGppYzJLaXZFS0g4TC92UUIwVmxUS3czM0tzNW9uRU9YNVBzM0kz?=
 =?utf-8?B?djlNYkdKUkNYanBhRlVOM2tRdzh4RW11Z0VzWjJ0SFkwQWV6OUp3T3ZvK1NX?=
 =?utf-8?B?cmZJK2NSc2lIcWpCU1o3eSs0bFhGS3FNVU51VUMza3ZVRXJqSTZ4YTVObEVu?=
 =?utf-8?B?eFg2Z0VMeGJucG1ZQWVTbHc2UWNrd28rb0hEZ01ZSUp2VjJvY1hkazVUV1VK?=
 =?utf-8?B?Z1kxTFZ2bkpYay9IRytzUkxPS0htRG5vY1I5Z1Q5cUZrQjJoT0ZSZzFaT25Q?=
 =?utf-8?B?MHFPR0M2R2Y5K25MNC9pK3N0Z1RteDhtNzVBNnJSUzJGYktDYStVOFp2UG5i?=
 =?utf-8?B?ZXpYYURvYjZpaFJQQ0ExV05RVFI0L1FJZStmM1FyMlBlSWxNR1VVaUZNc2Jp?=
 =?utf-8?B?Q0VqMWgxbWhOMEk3cE5rNmhRdXMxWDdXQkFsVWt1a01KZjBwcWQrRGNoVXh0?=
 =?utf-8?Q?6fRvaOEfRcI=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?MGFoVi9STDVVeGZHWlJLd1p3eE1FajVrWTZTKy9iL2RPVUlLK1o0dFhzWDM3?=
 =?utf-8?B?clpxTEVISlBsZE50T0szQkhzVDhGbG9tZmVmQ2dHZTNYa2pPNFE0WkFYMXUv?=
 =?utf-8?B?ZlVTcVRXM0VFRGxLNSs3M3E4VkVKN0xGcVNUTVFIOEp6Qld3S2Fud3NUblFn?=
 =?utf-8?B?MjB5a0l3K3BPZkJ4cExFWnRQd2thZ09Md1ltQmdScGh1TXgzQVVseTRDbTRs?=
 =?utf-8?B?ZlFhMERmcXlzK25jemJ6SDduN0dWWEJqZkF4Z1Q5ZEpURUFWUGU3WFZGK3U1?=
 =?utf-8?B?MHNnWC9BTzV4WnZZeVBiRlh3RWtiVkhoS0ZWWEFlcGQxZDd0YnFIQjJTMVRO?=
 =?utf-8?B?Z1hLeTdHc3cwNWkvNk9ZTzVrZGlLdEJ6bkZ6K0dhMFlLSzFZUTNhMkt3cm1O?=
 =?utf-8?B?RXg3R2tmWXdjaHZvaUVVVC9pa2JTajExd3RFaWpvOXp4cFF3Qkl4VC9qVHN3?=
 =?utf-8?B?SXlCNS9QMTdNZ3Z4b1l1NkhVcjF1dEhWY2dPcU5nV0Y2R1VmeVdUWGxpN0h2?=
 =?utf-8?B?c1hublREY3dSVElMcGVFckVRd0tnbm84dDFpbUorOWtCbWdONmxYZVVUeFJJ?=
 =?utf-8?B?cWgyRmhFbVZKNHRqMHpxMUZPV3ROUE1Ta3FPV1JKNUc3M3AyeFVWOTcwNGpU?=
 =?utf-8?B?T0RPY1pYbXZrSjVRTUlHMDFQbVNobGpwUDJEZzVxK2czcC9PcnJJZ1ZjcTYw?=
 =?utf-8?B?eThnODJZb3ZxZlJaRjdKTUpYWUxHVnc3QWlaOVZIeHV1ci9PYUpKN0pDVmIr?=
 =?utf-8?B?dngwYlc3SFFWcTBUSjZYaUpqWGg2MkpPeThXT3JTdDV0eEZTSHAwb0FRMDR4?=
 =?utf-8?B?Rkd4ckpCanRVZ1k1ZTQxcmJnNXpya2pHaGZrcVNaU1cxNjZ1Nkkzd05Fek9z?=
 =?utf-8?B?ajNhaTMwNzBMaE1YS1JyV01Zamk5SGdFY2dYVDl4eE9Wc1VNM29oRXlTOVRv?=
 =?utf-8?B?czlRd3YvUkJBR3dtM3N6UjE4MjNzc3VGY3BzVVgyR09wRXViQkNrQWdPdUJz?=
 =?utf-8?B?RzFNRHhaZVYxZWNpUzk3RmcxSHpmV0lHWnp5S0FRY1lMWk91cVIySFEvUFlJ?=
 =?utf-8?B?MXJKR3l0dU5ZV0FlWmlLdGJyUG8rV0l5VkIzdk5Md2R3c1lKQ1pVYUcxT256?=
 =?utf-8?B?U1BDZ3JPeUI2WjZ1R1haWWRjQ0QxNlVNL0xOaldZVFhnWXI0V2NSd05nRU5H?=
 =?utf-8?B?a2xWb3hDK1NzT2dSUjlCcEdodlJPUFlmZEVHelNqUVdQb1NINkc1RG4rNEw4?=
 =?utf-8?B?SjJvTDJBbWpRS2tVZzRYZW1qTzhjTlpSdHZ6TEtwNUF0SzBBdGRhMENKQ1VJ?=
 =?utf-8?B?cGV5QXZDOXIyUXNrWnVaUkFTbGlsQ1Z5SksxUXduVjBBK2wzdHlKR0s5Z0hI?=
 =?utf-8?B?U1pudUYwYTFZdDJYZ0RZc2hHbjRkNnZ3a2VoZGVUS2UwUEJ5MkMwVmtoUkZ1?=
 =?utf-8?B?emcrTmRlMzdSaGxmMkF1Mmtkd3pLWjhNVUVVeHMvbTduMk5JWTBoNFRTc3Mz?=
 =?utf-8?B?OVBlSm80aXRmUE1PYXcxYU52Mmg1WUgvYkZuTjBTTEVXcXNiNUNMYUtmT0xU?=
 =?utf-8?B?OG5ZczJwUjRDZkxWU0c5ZENsMkpHdWFyL3lNMzdkVUczNnprdUxuMGV4dSs3?=
 =?utf-8?B?VzlSc1dqSDZwVk9NaTFHQjZVNkk0Z3ZVdjZsbHFCaDQ4bnpYSHZTeWo3eCtr?=
 =?utf-8?B?ZnFHaGgrVml3SjUxbGNpTmxKQ0cvSWU1K1pwUDg1Ym9vWStuM0hxYzgwYmJW?=
 =?utf-8?B?ajdpNng4V3lYeWVJb21neHA4eEhVbFRSRUI1Y25CYzk0YVY1c1BVM3FXZVc5?=
 =?utf-8?B?dFpPdmxnWWx1VDhFMHVZSHQvRld0MlJpc3lKRUJ4S1YxTkhSeGtoVWUrT2ZM?=
 =?utf-8?B?V0U3QW1kSkpkSE9mN2VxUHovczFHQTJLYnc2VThwVzB1aFhEUmJ1c3VnZFVY?=
 =?utf-8?B?RnlHc3lsM1V6eGgwV3ViK2RlNGdsSk9CR0pvNXVTSFFGNGt4dUVoZHRmSTRG?=
 =?utf-8?B?NkZSVVJqRUpURnhEZk8zSUpqc1pGVEltNDIrMmJkUW1HUjVXZmR1a1RIdFdX?=
 =?utf-8?B?KzhOaG41emwyVGY3QXhIVXhWaHd4aS9BaGNYZ3pFZ28rbE1MNXAwR3ZnSksv?=
 =?utf-8?B?R1NxZFJkN2l5QnNIY2tDMUNMRkFDZXhDWDhTL3ZPNWpKVWNTMGFPdzRzNnJm?=
 =?utf-8?B?TVE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Ixx5hxg5zAiGuN8jtFAGw0cAdhFC5eBV9ZtuLUPOiKobvkCp3A+VhtukYsfl6c0bYT2+FSZXTCUeeMGZZsjm6lKsnEmRvx5+ptvyqPbTyDCQrfAr4KXcOO2psnCNsFeogSswVnpGeXoc4L1HxnZvnUU3pGGnxHfKwhdn18SHHpwq6T76Whmma+B+OpRlFwgXszi2pAo3rDitzd8RRYSfR35eEwShE6Z6j3flaDb4NSMcIwAqryy2JAvFKtvngsUmqn6SgTZQIYUpbDz1k971GiKfQqqw1HLlQbmKsgfye50/6TkAd/aYoj0NkdeO+wLVqycGa9hyTeOLQ1MjbTGluZinsBPl2PqQGDa2B/MIpxvHH5nBkiXpVuanQkxRTKXNXv3I354LJnyuAGQOQi4elCs0BriUH67hU2hWGq2wk6NhZ0iXxjI7XsUCgTh1dCNiubTuMroC4XuIVWZLx/7LNBEs3w0vNz4p41ng7grP+t7BZrG3Qj12SyBVQH+jqW6W5KaTVBj+UgG7TJcR6oW/hyBOJBna+u5L+uGf8ioLXr46MELnPE2mxj1j98fKbgnUOWt5w68AxXFuaHILFMu1tIzLO2OZdvUCPeeoiY9EY9g=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e1e4f05-1cbc-490f-bbb7-08dda82d7525
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2025 14:45:35.0563
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H9+oEsxVrg+GulaL+CPdK+0Ie7nFigfBScxB3fk0HPTkrNuemlz9xAoVrvUqbn+olVOiNChLDhKBIrxB6giPVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7150
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-10_06,2025-06-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 spamscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506100116
X-Authority-Analysis: v=2.4 cv=LIpmQIW9 c=1 sm=1 tr=0 ts=68484513 b=1 cx=c_pps a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=VwQbUJbxAAAA:8 a=BQGwlwCTAAAA:8 a=pHsUJohEYfLkoe950CMA:9 a=QEXdDO2ut3YA:10 a=HFqQS4YDwGEJ6BLTKAzC:22
X-Proofpoint-ORIG-GUID: G3Q8iT5ll4X9cS7KLFz5rdp22qweblRh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEwMDExNyBTYWx0ZWRfXzZFNKes+cIZ2 5ErOVf702rVuyPkJn5GTL4dPm+vSI0DF0Hk1h8boYKrH6hypFRej+GB5VC8DOjcOtr8bOx0pxQL m0tHhmG0xR0Elsayz4AyO55+ZnwqOrX/lNoRhfM22J1FWVUAHtAWAl0Eg9x/MIcZpI5lPcKAf9Q
 Nf5kfxE8Kd7v47lcGIN3cf802Sq2pe48wzujRRN3oF7/WhZdaswPf2s0vKci2u22BIUlOSqL/mG XjZVhbNO0gEx+Co1NRprndxHh0hirK16cFvEEgpUPLt8bDWi/Ppz51rCzn7elINCDDK7Dzj4ZWb n982buop2Qf6ZxB6/ear+oV1XenxDZZlKf9PuA2Dr4/pur+D3wJhuYtb3Tu9zOUOW9sXtREEm6I
 Qsqq//E12DXbj23PGwRm65lZp6cXxf/OV3clzanRp4Q5nrGvJ0Ct6Y9qjw1KEH9LPnpVEiNu
X-Proofpoint-GUID: G3Q8iT5ll4X9cS7KLFz5rdp22qweblRh

On 6/10/25 10:31 AM, Dai Ngo wrote:
> When the client sends an OPEN with claim type CLAIM_DELEG_CUR_FH or
> CLAIM_DELEGATION_CUR, the delegation stateid and the file handle
> must belongs to the same file, otherwise return NFS4ERR_INVAL.

s/belongs/belong

> 
> Note that RFC8881, section 8.2.4, mandates the server to return
> NFS4ERR_BAD_STATEID if the selected table entry does not match the
> current filehandle. However returning NFS4ERR_BAD_STATEID in the
> OPEN causes the client to retry the operation and therefor get the
> client into a loop. To avoid this situation we return NFS4ERR_INVAL
> instead.
> 
> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
> Reviewed-by: Jeff Layton <jlayton@kernel.org>
> ---
> V1 -> V2: replace NFS4ERR_BAD_STATEID with NFS4ERR_INVAL and add
>           comment to explain the deviation from the spec.
> 
>  fs/nfsd/nfs4state.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index be2ee641a22d..ade812bd2996 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -6320,7 +6320,16 @@ nfsd4_process_open2(struct svc_rqst *rqstp, struct svc_fh *current_fh, struct nf
>  			goto out;
>  		if (dp && nfsd4_is_deleg_cur(open) &&
>  				(dp->dl_stid.sc_file != fp)) {
> -			status = nfserr_bad_stateid;
> +			/*
> +			 * RFC8881, section 8.2.4, mandates the server to return
> +			 * NFS4ERR_BAD_STATEID if the selected table entry does
> +			 * not match the current filehandle.
> +			 * However returning NFS4ERR_BAD_STATEID in the OPEN causes
> +			 * the client to retry the operation and therefor get the
> +			 * client into a loop. To avoid this situation we return
> +			 * NFS4ERR_INVAL instead.
> +			 */
> +			status = nfserr_inval;
>  			goto out;
>  		}
>  		stp = nfsd4_find_and_lock_existing_open(fp, open);

Looks correct, but needs some clean up:

 - squash V1 and V2 together
 - Add Reported-by: Petro Pavlov <petro.pavlov@vastdata.com>
 - Add Fixes: c44c5eeb2c02 ("[PATCH] nfsd4: add open state code for
CLAIM_DELEGATE_CUR")

Thanks!

-- 
Chuck Lever

