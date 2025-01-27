Return-Path: <linux-nfs+bounces-9679-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE79AA1D866
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Jan 2025 15:30:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC94E1884D3C
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Jan 2025 14:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 223595227;
	Mon, 27 Jan 2025 14:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VhaKX1l6";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="dVOTUe+b"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F5132AD22
	for <linux-nfs@vger.kernel.org>; Mon, 27 Jan 2025 14:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737988197; cv=fail; b=TFuoYOyzD2v/TVWCQcFL04qQIxP84wrC6oghJYpl7vd6fzitHR23HLxfhlXV8D/cPuabyZCpCR97h66Aq6y+1C5W3PBtogMsm4Bq6xarjvOwiOK+JyB9s2OkmbtDVXA3doe1Op16+vInaB64gnvfg1iCRUEKjhUpbfs+8OupnIU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737988197; c=relaxed/simple;
	bh=BF+Oi2r51w48ADkYkaScK9ipNQuEhg4qa8H3g/DVpDI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=P9z0fdS3b4o22U7zn5UFOVhBnMbA+4Nc+ofzyMdDGOhGDdd9XF3QVIoSlG2lhVq6kualyXu/4tZMtdrnUIoTx/b03dLuuEKLPDYAksfE0f+0UWmsPeILjvp42K+LoSvfkP9C24RmAQhDCB5lzaLxcHkVwHyK1xruHTb1vHW3ei8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=VhaKX1l6; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=dVOTUe+b; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50RCpnFM029776;
	Mon, 27 Jan 2025 14:29:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=gAkEUL90nD7By0lnq0H9GfabxTe093QTBUGevutVLeA=; b=
	VhaKX1l6iOLvvLaytfPrfVnN9aZfEi++vPrYOGPFp/PfSDZAnbWCYx6OZ4GNmMAP
	Z42pQ7TmJbyi/S8A23ouSL+orYgfgqqhh/dIWqL043G511TN9zfPELHo4iiIDzLg
	Nsm/JniUHgGpsTnh1lOHBkeeOXzRla28dMTa+VY9GB54mbdwDPuY/65h/LEbhxRA
	sx8O8RJFUizhGnur/ZWM7soTNtdTK7gf1c03D0zmkjAqN5E86CiSZnFc92qwJwFY
	+L/fGirThg8jjEpjj+U4/JLjjt9QF3LaSi/P6Z4Eeq07yJHj53wvVZH3B9hPDLDg
	V+u7ZB8rO7woHF1MSgQwEw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44eah506n7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Jan 2025 14:29:43 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 50RD4eGN015953;
	Mon, 27 Jan 2025 14:29:42 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2176.outbound.protection.outlook.com [104.47.56.176])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44cpd6s2qs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Jan 2025 14:29:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bYe9S7wu4F9Bp2gDnHbUmmjVmDIBoj7/uuk3CMdlinddS2benAaErAxYXMUHJLrbwfqkQI+y0IY2FdxRoq4S2L9MvDQRKQiiyIUfloO0Krgp8qUAF3JRCEEMnMabdd1j7GL+VOo3JMo1+tklqLtOrnOgonXeGsB2xOSoqp1zp21U3eqK3ftB5N00biNKuCay1XfPFtpm8LgB40YK8+Qu2pJmB9kLB5FcFgfnLkzFIzWKIzHfEqdVmgVoXYXPE01tlJWProFlq/VrRKK1KnktOhcezhqaz9b7dHg1qquH7HgBzR9lIR4THxpN9qc/yWeypw6W7HLuNpTnfioQAYO9+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gAkEUL90nD7By0lnq0H9GfabxTe093QTBUGevutVLeA=;
 b=EaN4hYMDeNKrsY2GU19o0XbV2YLcL3J2xLlAszzeE5DgHeJRNp1GW5AzU/j8iaL3qbzCGvKoF36IHwJl6BDLLbaGOH2JzAJORwjGk00uZfffhZazOTkLVCO56N8OeKF2Wqc3bmHuu9uNTtPahw0oSKgW7JztnUYVY0YRelIV/Z5TzJaITVAvY1DSmQ4FR1FUoqWiYdJoae6oMY+bnWqqzbvlmGyKa3gu/5+41xDAFKTXaiVAmySgqHg4+J1N2RJG/OSmDKxzZOmiOv7j0Tc7gTDDPXhD5YvC9dFKmc7oGH4uL+SL1xaAxRdjBtZcZ9qaasH6IYW3CV3wm1SK/D/UfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gAkEUL90nD7By0lnq0H9GfabxTe093QTBUGevutVLeA=;
 b=dVOTUe+blejufZB+FaST2A+cr00iotAiRuuxpabU8buDaPmgv3sGZXwTeDhPLgx3Q4pJ/WyD2cIRN3JveN7DNxv6m4VFbxGOOp12Bz070Nz4GA8m21oGlBkzeuDCChyiztLom0yCp1anFitQPg8FUA5igukXLQKExLfKCc1xixc=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS7PR10MB4909.namprd10.prod.outlook.com (2603:10b6:5:3b0::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.22; Mon, 27 Jan
 2025 14:29:39 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.8377.021; Mon, 27 Jan 2025
 14:29:39 +0000
Message-ID: <fe9e54b5-d94f-4e27-9e08-31a89004e821@oracle.com>
Date: Mon, 27 Jan 2025 09:29:37 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/7] nfsd: filecache: give disposal lock a unique class
 name.
To: NeilBrown <neilb@suse.de>, Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org, Olga Kornievskaia <okorniev@redhat.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        Dave Chinner <david@fromorbit.com>
References: <20250127012257.1803314-1-neilb@suse.de>
 <20250127012257.1803314-8-neilb@suse.de>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20250127012257.1803314-8-neilb@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR11CA0003.namprd11.prod.outlook.com
 (2603:10b6:610:54::13) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|DS7PR10MB4909:EE_
X-MS-Office365-Filtering-Correlation-Id: 0efd3796-22f2-4703-98d2-08dd3edf0830
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OWs4eFg2eUhUYjZBQTZjV3V1aFBSYkxMaktvN0VHaFg1M0J3MmV3TjBITkZs?=
 =?utf-8?B?VFFVRG9IbThobkNEOUFoeElzL3R0ekZZcWJKNzIySkxKTHovU1FYc3RvYk85?=
 =?utf-8?B?SG1SVndmTnJMbUNoQytjM3l1bEZkVVA1Q1dWUnRXdW15WWhFTkJaSFk4ZGQ0?=
 =?utf-8?B?SkV6cXBBak9QVnNQRXJyc25uNU1qa0diZVZSUUFUTGNUdGdHYjJNa296L2o4?=
 =?utf-8?B?VlpmNWVPR0UrRmJPR3EycHpFeDZjOFA5UUNJV2xZSmZqYTB5RVFQeHkwckpX?=
 =?utf-8?B?dDAxS1F4QXMrZ201amRTbmhLZGoxUWFDYzJGOVNKR0sxZThJb3ZNcnV3dE9C?=
 =?utf-8?B?dHBUL2lvUzU2WDkyQVhtb2h2SVlRZ3NQMjFWR3BMYXZXc1VpMTdNUG10S3BY?=
 =?utf-8?B?UDdncXdKck0wRFhGUTVqdTRUR0h5SGhkZzJWdjRmelJENlM3SU93OWVGbmQ0?=
 =?utf-8?B?bXRidEtUTyt3eVZvVm5YN3lYVkdqS1d3Yk55VktRRmZqTUFnYUZlSkZ3VUhY?=
 =?utf-8?B?ZHRuQThBOFpKZitMNFdnaEJJbnJGVDduQmdJUVVMRXJsVkUzb1ZXaDhjbDFT?=
 =?utf-8?B?dGNSNVdDTGxCRDYwYXdycEp4YjNva29uWjJablpxMWlrcHNFMVdBYlJaOE9P?=
 =?utf-8?B?NHB5SHViWm5rd0pic1BXWW4vUzhiZFJ1WGozUmVmdjZ3OS9TdUNIQzNoKzdD?=
 =?utf-8?B?Lzk3UVhIcm9La3VLNFNNSkhmdklXeVU5NE9naWFQaXFTNDlZeTJQYkY0L0FF?=
 =?utf-8?B?MldieFBsTzQ3NnY2b21md3hhelM1SDl5bHprS21vUnFzdVRkTDVidjRyZzVH?=
 =?utf-8?B?WVRxT1RNRHpPQ09PNkVIZ2N5dm9FUk52MVRyRjJPSm5MQlFuaTdOYkE0eVdK?=
 =?utf-8?B?dVlxenZkWis3RVVDRFRkODNEc0lVY3ZvYUpFUFlmMjBaK0NYc3dXNUhHSmlB?=
 =?utf-8?B?NDd5NXNZaHlmSjl2TGY4SWVpS21IZnlkZjdsQnEydHNsd2Z5aEREdzRiQmsr?=
 =?utf-8?B?Mnh2ZnVTSWRuSUtKUG5kTVBZNDMrN29BR3dvR05xQUQ1NlpUTmFNQk9ia3V2?=
 =?utf-8?B?SDNINlZFR0tMLzRuSXdPZmszcXZTa2MzZW9qbXdJR3duUXNJNmpDRGFObTVB?=
 =?utf-8?B?b0psZzlURUUrRm11dFBXR0J5b2d5TW54WVhXODR1bzJUYktHRThQMWJjM0JV?=
 =?utf-8?B?bEFFUllCdk1VNElSSUVETGVmaFRMSE53QTZ6UGJaSThvT1VGWUNiQnlDYzFN?=
 =?utf-8?B?VmFzK2lRYWV1cVhxNUhCOTIzMXNsTjZmTmVUdGJFMi9OQVlEOTR1V1VWSEV1?=
 =?utf-8?B?TGN2OHhta1RLWFZGMHMvVENtNnJUeXZTWVBIS1NDWnhpb2xYMFAxUnIxVTlE?=
 =?utf-8?B?bmp0RlZyUEY4MENqak1GOTZsdTdhanllNzF6SkU3UFNDSmpYcHlaTVNHYUpW?=
 =?utf-8?B?a3ZUb3NhQUFydmpORWpHbzlqTSt6ZWJrc2RtOXJBbE9KRkcvRGlWdG5qRUZS?=
 =?utf-8?B?NU9GQk54VFVsZ2FVSXpWNXpPd0hlSTY0Q0EyTnNKQ2dMR0g0SUJ6N0loN2xu?=
 =?utf-8?B?Q003QzV0WFFNdGdGNUpHT3pFa3R0dCs4aW9iMGcvR2V5M3BmS2d2ZnBPbm5w?=
 =?utf-8?B?bVdrVjFQV3ViSEVKWGV2MlltSzV4d1hCcnVFOWdNZHlBS1FGKzNHQ2UzYWRN?=
 =?utf-8?B?Sm1KTkFHYkMxVzU1cU1VWE54OVVZaGJ0VGNJWGdLUFk3WFhqTnFzMlZTbkps?=
 =?utf-8?B?dHYrYTIyV3lzU0J6TWUrWXVwVXlwVDNZbi8vVy9vaVZFcFN4WVhYa2kwa1RK?=
 =?utf-8?B?V2Vjb2phMzNuTlV2OHd6T1oxQXo2WGNzbVQ3MGJqQmV1UUNwZGV0QWRYc3Br?=
 =?utf-8?Q?uwArAl8ZhOweN?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?emsxWUVtTEtZa2ltdVFMTnFzN2VWTnRZMlRaelltUkJKU2pxSHBzUUR2MlY1?=
 =?utf-8?B?TWpJcG1EUEJMRll2NFc1bGdDdXNRdE9QallaRHBKa083c2NLM3BSSCsvN0x3?=
 =?utf-8?B?cmM2QkYzSnR2SHE1dzNWTlRIcDdqK3VoMWpEMFVwREtqQlZiZUJLWVZYaDVO?=
 =?utf-8?B?L3hVcTE0b25nNzZuU25RbHhkOGR5dCtET1hXdi9JZk9IWWk5czdVa205T3Zn?=
 =?utf-8?B?VFord0lIS1QrZERHOFFCb3VFaEpWWlhLWFJJMVRDN0lLUlYwYURRNWh0RlU2?=
 =?utf-8?B?RXkxMStaZ2NiOEJxTXIweWx2RHhOMW1ZR0FzRVVQd04vTGovS3Iwd1BhTVQx?=
 =?utf-8?B?NVFvbmZxMEd4NzNQNzE3dFFldURER2RwdGR5SWliZWRnWHoyRFFnZ2x0QldI?=
 =?utf-8?B?YlV0VDZ2dTlKakc4Mzd4bWJOYWtIYVhTTFhFa1J1VksxZmJ4WHMxQkcvNjJj?=
 =?utf-8?B?RTNWU2NjNWoxWnF6UkFuQUtZc1RMRSs5SVFhWHUwOWMvYVczWHJ3RW13M29V?=
 =?utf-8?B?TGh3cVo4MVpOT1MycUxZNXc2QVg3YUlLQk1UVVhkK09JWDc5RVcvLzgxSEZo?=
 =?utf-8?B?K3F4MHcrMmcyd0NUZGRzOVJBemYwUDJMMVM1VElOWHVKdUdjT2Jvdkw0NG1W?=
 =?utf-8?B?N2JlVGE2ZUFSRGUycG9HVWlTbHd6ZnFOWlVidEE2KytJWHpsakZyVENKeG5F?=
 =?utf-8?B?QnA2RG15SzU4aXZta2QvbDdVRzNoajN2a21WMHNuWnFQRzZXdVQxY1NIZWdm?=
 =?utf-8?B?WVVCNms5UDVVS2xZS1hhQjU3RW1KbFYwV2lxZ0txVm5BNjQyaTZ4bUR0UHE2?=
 =?utf-8?B?MU4wSGNuajMvcy9LcTNkVGI5TDBrTEhjU1g3NnlmZUExRFd2YVJJUGtVMEM0?=
 =?utf-8?B?TGRnaWtWOXNENWNrVXNsWFdqcVAyY1ZYK2VvQzBhRDVpVXcyZVVBNGFJVW9n?=
 =?utf-8?B?eENVUjRRTlcvbG41WkQ5TEhGUkJ3c2ZrajhVMWR0eTMxY3VDRUI4SDJ0cVJH?=
 =?utf-8?B?UlRHNWFPK0lPaUQrUHN0RFprRlF3UnVWR1gzTjhGNzhMTTdWMm40SVVlaHZG?=
 =?utf-8?B?SVQ4ZHp4S0R2RVJyU3BDQllBTjFqRW1QT0JMNVJTM1hGa1pjTWxSSmxVdlp4?=
 =?utf-8?B?emVCSkdWOXBycEhpTmlzK0lVWkJhT2hkblQ4YVJQSXJRSmYzWUpiM3FBL1pR?=
 =?utf-8?B?dld6WVptNG9FVGFFeTNKeHhsOWVHSnJjV2J6OEJTMGhSNlpXNTVCZDR5cDl0?=
 =?utf-8?B?cDdmbkxjNGtzbmppNUZvUnlNaHZuQUYzSzhKUm9teVRwcFpmbnA0SG5iNHJl?=
 =?utf-8?B?bytiQnBLTENtTXh0a1FuTksyck9HVExsYWp6VTBlUHNaUVJFMUhYNlRISlZ2?=
 =?utf-8?B?d2tiWEFWTStqRHNDM2tsNFVBa3ByU2x3SEJmOHMvT1g0bXk1bkFkOHJERmFj?=
 =?utf-8?B?U0tLNFJKUnU2N0ovcHB1d2FaTDYyZUNvV3BMRTRZQmJOcGhJU3AzWEFYMUh5?=
 =?utf-8?B?WS9jM25abkhOQ1RNcDQvc3dkb21RbkdoYklMbHorOTNROUVLRk92c0VQZWlO?=
 =?utf-8?B?WWtOQzR5TWQ2RDRuWTRRVU9YMXB1OW1RbjZROE1hV3NlbnZad3VTa2FacVpy?=
 =?utf-8?B?d1R1SEhYaGNwcERxZktJeE5vaUpRYmtLY29acGJlK0IyNzBDRzZuR3paaGlE?=
 =?utf-8?B?TytKVGd0VVV3V2lHQk9Wd2g1NFZwSVpDYi9VS3VlL2pRSnJPRi85YklwQkZq?=
 =?utf-8?B?RVJKZERERi9OMWE2SXh5bG1CamMxeEVwQ0g1dEIyaDZPOHVFZmRhajZsY3Jh?=
 =?utf-8?B?OTJUK01jYzVMZFRUNFBiSlZNUjJVOEdzcDZnNjE2Rys5b0lzbHEyakIvWHFZ?=
 =?utf-8?B?SnpNdDBiMlh3dWhpckF5M3ZYTDZldXRvMnJ6Skw0L0NUVko3THUwZnBKd1Vp?=
 =?utf-8?B?MXhMbFVFVUZHL1V1a21adFBwY293dmtNd3ZqeFFVVmtQaWdzL0dNcFNrUEVK?=
 =?utf-8?B?Q1J6cjk1aGxTMEJOeVljWEprWW44TEp4UHVVNCtJblpTRnFiUjJYS1BXWnpP?=
 =?utf-8?B?MTg3eG5wM3I1NUltaTNHY3J4bTBReUd5VUFOWDhVQTNrV3k2cUpRQlR4aHhv?=
 =?utf-8?B?ait6REJQSXJ5UnVRYkJMU05IWkVsdjFHV0w1eitVUFJrVUd0L2F3eDRwdklM?=
 =?utf-8?B?WFE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	35FAZmtM/asVhmU9W8FFp6fKFlSK771r4oiAsiDPK6aICUcEKA0N2tQ78rMJjskw7YeBkd5s0gaps2MnuB5ioq8Kx+ug8LDBo3lmpovScPMXpAAs2hW/u7mtX54EIr0erfmaUNc0J4hbNK1crBbAUZlm88esvu3k6SeRi1Lq2sPvk180aiHUy99pNHX6H5THwky5hYwVLiGzBoX+MuT/pSxnlO77pMe4QO8JnrbkN9bWXTDJhPDGQsn7F9Qk11oMjqOwGMM+EhCHytDkz6zHcY662azV/gmSQnLLbpNVm3tW8RNeuNPVgB1g97dha8lYmysdwDwEhdkViRU52fW1pxkO8BaK0FCrPIYCUIwHSgkTwfErHPxI8Oh4+ONjtJajSK655ivw3a0vF/ozVtm8KPJz/4pdyvwPuXitAK7vpP4svxxqCUEEVF8C3KCp+0zhcRy/aF/SAPs+4/mpAdiJSu/NDx2e8MQJFgU8f6H9yUUjqZi1dm0wJPwz7GiNqZT4DkHotsyIphG7rRAwjWi2xP0Bd+c3XE5bgySeKTMfzWhuItY7DzntIdlrBW8mYZNQukUYEZTRYstLI9HPJH85rTu+hnR7m9Z2vhbb6gVbboA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0efd3796-22f2-4703-98d2-08dd3edf0830
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2025 14:29:39.3915
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U3PhAz4do5ZqKgrH8HUJ1R4mq3BRVDX/wuN4WogC4mfdDW3ppt0cje0QpAkYGDd6eYHFSmWep8KiiX/f99khQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4909
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-27_07,2025-01-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 spamscore=0
 malwarescore=0 mlxlogscore=999 bulkscore=0 phishscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501270116
X-Proofpoint-ORIG-GUID: u4rx8XNmEMx-tSaMNrP8cRw2KLYH3ztF
X-Proofpoint-GUID: u4rx8XNmEMx-tSaMNrP8cRw2KLYH3ztF

On 1/26/25 8:20 PM, NeilBrown wrote:
> There are at least three locks in the kernel which are initialised as
> 
>    spin_Lock_init(&l->lock);
> 
> This makes them hard to differential in /proc/lock_stat.
> 
> For the lock in nfsd/filecache.c introduce a variable with a more
> descriptve name so we can:
> 
>    spin_lock_init(&nfsd_fcache_disposal->lock);
> 
> and easily identify this in /proc/lock_stat.
> 
> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
>   fs/nfsd/filecache.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> index eb95a53f806f..af95bc381753 100644
> --- a/fs/nfsd/filecache.c
> +++ b/fs/nfsd/filecache.c
> @@ -867,12 +867,13 @@ __nfsd_file_cache_purge(struct net *net)
>   static struct nfsd_fcache_disposal *
>   nfsd_alloc_fcache_disposal(void)
>   {
> -	struct nfsd_fcache_disposal *l;
> +	struct nfsd_fcache_disposal *l, *nfsd_fcache_disposal;
>   
>   	l = kmalloc(sizeof(*l), GFP_KERNEL);
>   	if (!l)
>   		return NULL;
> -	spin_lock_init(&l->lock);
> +	nfsd_fcache_disposal = l;
> +	spin_lock_init(&nfsd_fcache_disposal->lock);
>   	timer_setup(&l->timer, nfsd_file_gc_worker, 0);
>   	INIT_LIST_HEAD(&l->recent);
>   	INIT_LIST_HEAD(&l->older);

My concern was there would be multiple dynamically allocated locks
in order to make the locking fine-grained, but I guess that was a
mistaken assumption.

No objection to this approach.

-- 
Chuck Lever

