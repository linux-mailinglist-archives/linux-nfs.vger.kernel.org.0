Return-Path: <linux-nfs+bounces-14214-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ED6BB51AEF
	for <lists+linux-nfs@lfdr.de>; Wed, 10 Sep 2025 17:09:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AD4DA0690D
	for <lists+linux-nfs@lfdr.de>; Wed, 10 Sep 2025 14:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6931B329F19;
	Wed, 10 Sep 2025 14:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Yw5omFOj";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="z8isviUl"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BC23329F2A
	for <linux-nfs@vger.kernel.org>; Wed, 10 Sep 2025 14:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757516053; cv=fail; b=j+IIBfAfwaPzKobdQ6gtC9vDCSPJ7It4zoISPrnrm74aFliYUTMauyPZHrXf4+iQnrxdyETsTRiYkgSWtcWTui47OsmBj61vTjGTYXdBAB2tUD3YY/ywWlMp5bdcWjK1mXce8CVQdqb5ddFrEkV3lAEkgm9UikFf0oEoy/TMnGs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757516053; c=relaxed/simple;
	bh=3W3wmaRRvw/1fkhPQlOIlPvBI4NkXeNtv78Ua/OHOew=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CJklZn+zL2rjmPZN3wBgimYd1pkbeUYDuH0r1OSODJVaT0FGImX8OrOvSLiW/HySuAzOUhN8ISoR0k8nJmQnCmcCClIdmM3rxFEZUt7xBxXHIbYrsx/L8l/iZBea73h8Pl9Kh5E2FjqfT9oQx5GO+Xeav2h8miMUX86D5hOvZd8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Yw5omFOj; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=z8isviUl; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58ADBsZQ001518;
	Wed, 10 Sep 2025 14:53:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=Hmk/rNfm1CvfFWTRdl/YuthY9dc/gNJhASjBX5usVdY=; b=
	Yw5omFOj2UQ1SAokwQOBH1G+CU3/3yF3zbpcSQuDWVLKfhuR5TbYsdGTiX9dPNst
	4K8kI7bzlW+gMzrTNwdUeV+LNsCQtABvmrdNBFi69uaINaKo2DKxR3dHLJvtDYE+
	gWl9JpLC3pzJpUWU09DZnzpvP83tFrdtG1LC1WDJVcQEzem1fr42dewcpsOf0WyB
	cDx/6rhhxQVCOUwkFVFzUGh2/ySGtl6U2u7hIOrU8axn4BQnfA1azuR+9/ssRMSg
	tBSzpkHUcOhl5rYL4NkxjRgN7KaUk6I4u3iSQWnKtH1KmILji3FtmHYhW1vwd1tR
	2eHWy1/lJyICI19AoXyZOQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4921d1mg3q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Sep 2025 14:53:53 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58AE72Y2002972;
	Wed, 10 Sep 2025 14:53:52 GMT
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11010035.outbound.protection.outlook.com [40.93.198.35])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 490bdhn2sn-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Sep 2025 14:53:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FmL5iflSSj+H79VeRb7CbPt10TVOVAsi9TEF5lEMJods1tU6hD2CGpQUJDF4YYDPRFw7CFxitjO+4fTIfUiMfM4Q6Y54lCOrwzIg4w1NwYcLMKzDE07ce+X20MV+hudeJmX4UVlNxNsFWgG7BnkwebVlItfvXZZXTQJl23sXaPJEl3HfdTLVTr0yiM1j0U4s4noinfdrApBpoc+QVRH91sZjalT97DKcko5kV1z53AmEMI6KxQofoAYulUZS7Wsxy+XMTN376TeJJ633QL4sHsIMb4eBkKmrFgTPhS8qeKWZIKrZA81ua7+PpbpkdunCd0+d/DkzJszXfqx0fL3D7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hmk/rNfm1CvfFWTRdl/YuthY9dc/gNJhASjBX5usVdY=;
 b=JLHAmK6gY6U2tPIsH5a9qGVCUm5+KEhXqbGLGmw0reTpadRmiloK86wjmZQSKQhIX0NrDNCCphFrIUmuz1Le9yGj/h/nsw0OgEWRG2rWOMhGTiYZgXibmXj/wKhwdJC8ulA0z41Pb0JAEK+2XjkLa4B50L6X0qKY+I13Zpkwa1Y6Mw02SEBt+JUGiASL1l9qeYuFQ2WNbWe7B92MnUplJ5pLlu0wjxF/Br5blArBJ4sYo1+KBYyhCyYea5F2XlTY4efl++fPTBQaHXfQPmpA2pnJKi93wpKpFFpaaXeqBw5UGmlTJFU7PWVk45Zv1WYQapfqG4ag70DyURumZwh4Qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hmk/rNfm1CvfFWTRdl/YuthY9dc/gNJhASjBX5usVdY=;
 b=z8isviUld7evTQm0xoy5v2uQWK6KnEwPtwVg3sx5SA2E06Ja7PXNjQ5g+v/fk0Z/S2cgPH5dOD3Pqz7X75hDRbDacfqS7YA8D9p3euCpsEOC+kPtW8P5KXihS/tiURWykUNqBin5T3BiQMFnOMY+tsAHMO3QZ+wK+FHY+d0MnQQ=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by IA4PR10MB8566.namprd10.prod.outlook.com (2603:10b6:208:568::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Wed, 10 Sep
 2025 14:53:49 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%3]) with mapi id 15.20.9094.021; Wed, 10 Sep 2025
 14:53:49 +0000
Message-ID: <0f0c9878-b45f-49c1-b9e8-9ee4b830d51e@oracle.com>
Date: Wed, 10 Sep 2025 10:53:47 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: client can crash nfsd4_encode_fattr4() by setting bit 84
To: Jeff Layton <jlayton@kernel.org>, rtm@csail.mit.edu
Cc: NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        linux-nfs@vger.kernel.org
References: <53032.1757512512@30-10-113.wireless.csail.mit.edu>
 <f4b122ca21ca772ea66d2f5b335cb751d116c3dc.camel@kernel.org>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <f4b122ca21ca772ea66d2f5b335cb751d116c3dc.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH5P222CA0001.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:610:1ee::15) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|IA4PR10MB8566:EE_
X-MS-Office365-Filtering-Correlation-Id: d0c4eaa6-3e01-4d1a-0f9a-08ddf079d9b2
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?dXR5WXAvU3ZzYlFOdkpQRjJ1dVQ4YWRZcm51QnBHS0hLSXE2NTlUaGRaaGhj?=
 =?utf-8?B?SDBoaW9uZzkvVUNUWHdhbEZsc2QyMHJsaFIwcnJNZWZVcTNJRit0ZFY0S2FD?=
 =?utf-8?B?eHoyUEtBRldCV004dVVLYXlJTE5EMU9janhYK2xVYkp5ZWNVYXpFK2Q5d1po?=
 =?utf-8?B?eEpYTVdBVFFrbDJIelB3b0EweisyM0lxM0I2d0hjMlp5eE5YWUxjanRJc0NO?=
 =?utf-8?B?QTdJdlR4NUxGcGJRMGJyK1doNWIxTFJLSk0wc204dEVhNkVyL21maXN1bGRs?=
 =?utf-8?B?WjlTSC82RFN4VHhEQ2pCRWdrOXFSNy9zMGgrUCswSnE1aTdvL2VTc2dqeVdP?=
 =?utf-8?B?dFV5U2pSdnVqMlFOU1YyNmVKdjQ1czFSOW11RXlOd25oKytCUWt4N05BUnds?=
 =?utf-8?B?ZW9jMjhwL04xUjNEMGJiSGw2cHg4REM4U0NXTjYvYWRvOUpMclRXNkhPU1dY?=
 =?utf-8?B?Mmw5N0VwVDhYYVFmQ0YxRU1RQ3hVaUErUHpuNnJhNDF0TThtWHI3MkpzRVpl?=
 =?utf-8?B?TjNOYUNPa1lUSVgrMjB2R0Nzb1hJRXZmY3VFR002cDBCNzVTeWFCNGlqdzlG?=
 =?utf-8?B?RndQenVxeVlSN0JUeUdEMHNlZnNFVWZaejhOUzRtMkYzNzNLRnRRSjNpQmRJ?=
 =?utf-8?B?dzJVOHFIb3lWazQ2RWIwSEgzaEpOdjlCRHl4UHpRaVZrQjRSekszRjFiQ01V?=
 =?utf-8?B?SzAwazdmZzRIRmpTaVVPSjBmSTNMb2hJam5uQkFyVFl5UEhEN3EyL1JnRExr?=
 =?utf-8?B?UmN6b1RjdTI1TjloOUh6MFc2VW8yRlBycllJa21OV3NQQzU5TFg1YXJ3ZVRu?=
 =?utf-8?B?NkVDTEVQZVdrU2M0VFFzMlpEdXRIK3J0QW0xSnBaVTRPTVhCZ1dQUUtaT3p1?=
 =?utf-8?B?UXBwYkZMeTh5Ykw5bFhMMWwvSWExeWtiOUlJWDdLZXhKNzYyYUVaWnFyR1dW?=
 =?utf-8?B?dEVNRWJwWEJQOFFVeXh2bTdSMHhlZVVSU0hiQzFhRFR2dTJaTGpFZ2tYc1lG?=
 =?utf-8?B?Sys5MWQ2eTZ2dERkdTRXU2JBQ3VJbUoyRnMrQlVQS285UzR0M1NZUDZaS3dm?=
 =?utf-8?B?cmltWnpSbW1lanhvc2RLVm1OZ2h3aXZSMGtXRlNyRG1ZMGVuN3U1RXlJYWNj?=
 =?utf-8?B?V0ZmN3g5SEZJZGhuK0JsVlJGd2tYYXFPR01jVE9sSzhldkhQTm5oMTJHWW9Y?=
 =?utf-8?B?L1AzUkdydUR0c3ozTW9ZZXdVTS9Jb1Y2bjFOYm8rZmw3R0NDKzdPOS9aNzJB?=
 =?utf-8?B?VUZmRXFTRUdZRmRyK2NEMVh1T0lNdDNNSXdJSlBETlpjeVdOSlFJcjhZOHpv?=
 =?utf-8?B?TlZtYnpTYUFxd1dkSzNFUFUrOUhDVjlISGgyWS8ySmlVaEg0UHViVHg5YTR4?=
 =?utf-8?B?UnFHT0lzSG4xMm5CU1JTQUJsZVFvVURhSEJRN1hIaDRORDdZTnVCdlZWM3pw?=
 =?utf-8?B?S21CazV1clVoZFNFbTJob0o3ME5hNWdVU1JTckwxeU5HZnY0SytldlBxQzBY?=
 =?utf-8?B?emd0QS94Z1ZEU1Z0WHN0YWZkaXpQTm94YkdpOHBYTzZGb041eXNmQmtTN2gw?=
 =?utf-8?B?eWtNQTZqU3BhNlREdG04MHdqR3gwUG1RU2YydnlZSXc5dTFBbkNjUUlFejZr?=
 =?utf-8?B?LzZLcG5BNFgxem40ZGQwQ1Uyb0xRQW9yR1VCY3RJZGVCZmQvR1dpVDZWb3RZ?=
 =?utf-8?B?U0FUM2F4VlFaVnhEbWNIeGdYTDdaSll1OGtwQ25EUjdMYUtTLzhoYmV3VVo1?=
 =?utf-8?B?NHM0OGFQOEtYVmRYOTR6Sy9LVGVMN05DcjNVTEdwc3htbXZicHRYNW15ZGJw?=
 =?utf-8?B?a0hpTkdpMnZPMXhKZTJxQ3BCTUFtR3FDMVB1Ny9vc2NQNjZPZ0k2VThoL2tU?=
 =?utf-8?B?SzFOTDVyQzVDb3pFbVdtSG5mL0xtZXpva2NNRm5VakZHNnA3Y0dGcGxOWGI2?=
 =?utf-8?Q?REXeK+VT3OI=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?UkFlUExaT1c0b3ViVm9QTjJ6Qkc3aEk0eGExMGFwWDg2c0JsU1E0WjkwakVG?=
 =?utf-8?B?R3ppM3A0THZMLzVIS3ExZThYbHZWODExZmdkd3JqQnUrNlFrcUNMamxOVWwx?=
 =?utf-8?B?Mkp0YkJ6ejUxaTZBL1FQMjFHQ29UK0lPUzA4OEd5dXZwS0NaL3g4TmF1TTJM?=
 =?utf-8?B?U3M0cldGbURXUVkrR05zMjZjRlFRNmhlcXBGSFdDS20yeEVBTGFRQ0FoOGxV?=
 =?utf-8?B?dGY5QVBhMzdnOHJLT3lYRUtqVURqdzJidjY1ampNa1Q5cVJGK3N4c2FHVDI5?=
 =?utf-8?B?ZHVGZDlFdkI3MlpmVzd3NjJUOTVrQ3hBaXdRUVppWUtTYUhyQ1ZnYXFQS1ZS?=
 =?utf-8?B?TW5lNlhqTlFzcXI1NVNKQVJTMGlsbXhyWDE4ejM5RHNXbVF0YmtZNmJKRlIz?=
 =?utf-8?B?OHdkSm5yNm9DdUwwd0l1QlJ2eDlET3BiYzI2NTlkMFVLMDFuRGJBMHRaR3pp?=
 =?utf-8?B?ZUNiL1hLd0c2S2ZsNTBBaCtwVDRWb3hOeVJVZGptTFZ0bTdDOGRxNytHMlVD?=
 =?utf-8?B?THN5bXRNUWRNRlRrNUU3RVBvUEFUdzBXdVBVN0ZHQXFLQUZwMUhuQ3B3QVNN?=
 =?utf-8?B?UFY4SFJDb0lKZ1VDZndpdFBJY0dLTDg5Wm8vbHRsNjNiVWEyMnlTWWttOHN1?=
 =?utf-8?B?M21SNjl5cnVkdFo3ZGdxQkIxeU9lOTc0bEdWMzJEQ0I4MGFGZnBUdEZtWW00?=
 =?utf-8?B?Z2xUYTFYZWlCa3lTNk9ZQ3VyMHNuVXQ4WnAzRXVVY2RmbVVWbWljcjIrNUxE?=
 =?utf-8?B?cnVEQkhGcWI2ZjdHTkJHV3g0OUl2eDlpT3RKRUJsclhkbCs1OGIzRTdUeHJt?=
 =?utf-8?B?YU42VEFkSTYwOWc4dWYvaTJNSUJNd1VMRUlObmZmcXFZK2RmSGNSOG95Zm5q?=
 =?utf-8?B?dmtER0tyU1FOc1lDRnVXbVhVWlM2QXFqYUFtUnhFNmFJUmVHTkJQbXM0M0hx?=
 =?utf-8?B?enpXay8xaUJUaXBxVFNuK1YzUWVqR0hSQkZpUWxEdFlvb096eU5veXQwUyt1?=
 =?utf-8?B?MFN5eGxQVldOVmJReDliZnU5Rk5HWG9NKy8yb3BickpNZWpMMFowVmQzRDF2?=
 =?utf-8?B?bHNnUmNScHRNQ0sxck8vRnlFR2Vaa2RvQ2VLSVc4ZTJ5L3pINkxLZUdqdTdH?=
 =?utf-8?B?Vm5hU2dtSW90ODhRWVkvMmtNWnlkUS9aM0RKM3JMZDhqa2xSM3BUeE5UbTZt?=
 =?utf-8?B?K3FRVmdPS3pSNFRKdGZ3QmhhUGgvTnYrSTZVdGU0OFJtajVHQVdCdjVsRVlh?=
 =?utf-8?B?VUE2czU2YU5kY0M0Y2tUZFo3OTNXYWh0QzVUMHN0NTFxc3JtSmVPZi9HVWc0?=
 =?utf-8?B?bjFTdSsxNlBkd3JMNjFxRTJGVzRDS3dZS0w4akZOc2xCdTlHY2pxWm5IRzha?=
 =?utf-8?B?bHRvYkZ1ZHQvajcrTzRzTlFhMjdmUzVDRjZNN3E5ZTFPUkF4TUlWRWp4UjQ2?=
 =?utf-8?B?aTBkMkxsR3JocUo0a3ZuR1NuK0hyc3hZdUEzTXFHMGZXMXIzMlUrZS9iWlE2?=
 =?utf-8?B?Y0FCcFFpQmh1V2xCZW04akxYc0JLeWVNZVhxVDM1VVFWL002dDhFRnRCSmVp?=
 =?utf-8?B?bWxXOVJKU1I3VjN6dlZ0NjdwcGZsR1ZBdXhSOUF5SWJHMWg3RFRjcUc5dDZt?=
 =?utf-8?B?TzhrSGlyWllDb20vSDdUSjFpOEFsQVkxU29DRnZ3akcrVjh1SkFzMWNPQkdY?=
 =?utf-8?B?UFZ0NmdWYWlYK0ZwZUlJME5wM0kxaTdBaFgxU0s1SG1VMVZDb0Z0WG96UWxw?=
 =?utf-8?B?bFlYR3ZXQ0w0cTRCakRlSzYxeWpLUThwamc4dllES0VWM0RHRm83M3FnS1d2?=
 =?utf-8?B?MUpBMW52NDNidldERnhQNmplTndSdXUyK0F2RnBDY2ZDWVNKenVPMUh3Tmlt?=
 =?utf-8?B?WEJlU2JsTjRUU2tZMUQwdGQ1L0o5V3FWYnBDalVqMXhnTHphNDZ4R1o0emk5?=
 =?utf-8?B?SXJPYVJuQmNBRTl1Y2NDSVNySWhYNDF3aTJRVU0vTE1JWjhXVlptNURnQkQz?=
 =?utf-8?B?U1NteThVNmNUd0dNOGg3aCtjTW5aSzFtU21ESEE4YVY2TmF3bWZ1cWRiRllp?=
 =?utf-8?B?RnBETG5GSFBVOERiSFF0U2ZyRGp3WUlQMW8xaVVyTEJ6RDdBUW9CUkJ3RlRE?=
 =?utf-8?Q?N1xzK7sE97wtPy4YZCyw4Xc0B?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	SX/sPCdiSeHeS4Yq+BcFRSyee/j3SQrJlIx/Z3Lqzns+Cf9ZsWmhfZNQ5M8a7zRVgTSWPBCWrOoA29rtPTwvyiJj8BWxPxtDKGJVJcyjEwX4QOICiJrs2hPAN9qkTHlhraRVzRPHBcAKpFTrLzfwStM/ddArLpaFN/shqQv9PKWzxOwxqPoEnvLDPy3NCnbYEWkuxXyJGTjds6/2DwghOqhB+/FkNLHLTiSzgmhxNwmIF0yaD62T1i2IvAtxWCCQLQJX1sJqsr4rSiLHA+cBNPNtkBV83LMM+UTY58SjzX2mY0cqUF6839wx38yGCav0wL3TmweVHqzcGiLAodZDlkMU9NcNxTLwAwUQhHTNunUMFJ7OsCBD2V8hxiwwuRsiuxcbTmxSvUaKFhQZnjUpdivCBFamOHfww8gSEPbwyKm50GXt0Bnr06elBAGXUiVgsK1rTJr2ZrvgWWquPG34bwn/9a879FVXgaLduQykdjCCEfKzIzV1NKHYO54cZpb3m++Ehcp+seSuX4EBfj9w1VzmJhgOf/Xe3JiNC67en3s0i+2TW17raIln5JfhFCQInQY3MkQ4Ir6iFf9VEygU0r/6VccbZPTl9DaJMX3qESc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0c4eaa6-3e01-4d1a-0f9a-08ddf079d9b2
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2025 14:53:49.2269
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DRKoxjSGjsmwBD0UaijQjbkf6s8b3MoK66iVhk48Rt+FL4SHtWHj/NMeuo/aBblR28TqWPLahbMz5yT9Y/CvUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR10MB8566
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-10_02,2025-09-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 suspectscore=0
 bulkscore=0 mlxscore=0 mlxlogscore=624 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509100139
X-Proofpoint-ORIG-GUID: hDkL9rlw3590DbI4MMJwfucpc-BZmv69
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDE1MCBTYWx0ZWRfXyjQW/yFFbPY2
 7X3m+ecTcjIOyfzCHem6kHxBhylEj6mbk6jctA9BtSXE4cTqhPGQu9k8KR4qsk0wgNN4fx2aFoc
 MLJmiWzkBcGQ6TxcVo/l7bZetWJJ2ulbFjRqSLLOKhN6Hf9sJylWvjJeRXxi/Qp4zFzYwr3gQNc
 GNRa9WDD5kLdo9HC6N5/hRC2EvuCTwVL3GL9hAMELnwx1GpVoGpTDo4XWp2GfhoF+FX88arig9k
 I/2aNM0esAeCZIDiKlON5npUP04OxtyP7vcMQNawJIqaTsZ8kmItIdP1lOIJkBINYWQy6Xja9BO
 oN+YX+z/vx9P/KWxgm5B3ksx8ByIzrXMOpMIIAM87QywY7vr9fWBdE9MKUiqEBjwb8EBt/zSj2p
 g0KCXpULvHUBhry7XrMUulaHuvh/lg==
X-Authority-Analysis: v=2.4 cv=d6P1yQjE c=1 sm=1 tr=0 ts=68c19101 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=fZJI4VREJM3fC8ttLUoA:9
 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12084
X-Proofpoint-GUID: hDkL9rlw3590DbI4MMJwfucpc-BZmv69

On 9/10/25 10:49 AM, Jeff Layton wrote:
> On Wed, 2025-09-10 at 09:55 -0400, rtm@csail.mit.edu wrote:
>> Entry 84 (and a few neighbors) in nfsd4_enc_fattr4_encode_ops[] is
>> NULL, so if a client sets that bit in an OP_VERIFY bitmask, the server
>> will crash here in nfsd_encode_fattr4():
>>
>>         for_each_set_bit(bit, attr_bitmap,
>>                          ARRAY_SIZE(nfsd4_enc_fattr4_encode_ops)) {
>>                 status = nfsd4_enc_fattr4_encode_ops[bit](xdr, &args);
> 
> Thanks. That looks like a real bug, alright. I think we just need to
> check that nfsd4_enc_fattr4_encode_ops[bit] is non-NULL before calling
> its handler.
> 
> Care to propose a patch?

597 #define FATTR4_WORD2_XATTR_SUPPORT      BIT(FATTR4_XATTR_SUPPORT -
64)
598 #define FATTR4_WORD2_TIME_DELEG_ACCESS  BIT(FATTR4_TIME_DELEG_ACCESS
- 64)
599 #define FATTR4_WORD2_TIME_DELEG_MODIFY  BIT(FATTR4_TIME_DELEG_MODIFY
- 64)
600 #define FATTR4_WORD2_OPEN_ARGUMENTS     BIT(FATTR4_OPEN_ARGUMENTS -
64)

I think entries for time_deleg_access and time_deleg_modify are missing
in nfsd4_enc_fattr4_encode_ops...

> 
>>
>> I've attached a demo:
>>
>> # cc nfsd128b.c
>> # ./a.out
>> ...
>> [  354.732253] BUG: kernel NULL pointer dereference, address: 0000000000000000
>> [  354.733355] #PF: supervisor instruction fetch in kernel mode
>> [  354.734247] #PF: error_code(0x0010) - not-present page
>> [  354.735053] PGD 0 P4D 0
>> [  354.735482] Oops: Oops: 0010 [#1] SMP PTI
>> [  354.736120] CPU: 2 UID: 0 PID: 1459 Comm: nfsd Not tainted 6.17.0-rc4-00231-gc8ed9b5c02a5 #28 PREEMPT(voluntary)
>> [  354.737664] Hardware name: FreeBSD BHYVE/BHYVE, BIOS 14.0 10/17/2021
>> [  354.738645] RIP: 0010:0x0
>> [  354.739087] Code: Unable to access opcode bytes at 0xffffffffffffffd6.
>> [  354.739677] RSP: 0018:ffffa7a380e0fa20 EFLAGS: 00010293
>> [  354.739956] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000053
>> [  354.740327] RDX: 0000000000000014 RSI: ffffa7a380e0fa78 RDI: ffffa7a380e0fc50
>> [  354.740691] RBP: ffffa7a380e0fc28 R08: 0000000000000001 R09: ffffa7a380e0fa68
>> [  354.741060] R10: 0000000000000000 R11: 0000000000140000 R12: ffffa7a380e0fc50
>> [  354.741432] R13: 0000000000000010 R14: 0000000000000054 R15: ffffa36c03bdba00
>> [  354.741802] FS:  0000000000000000(0000) GS:ffffa36fa6c88000(0000) knlGS:0000000000000000
>> [  354.742215] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> [  354.742519] CR2: ffffffffffffffd6 CR3: 00000001885a6003 CR4: 00000000003706f0
>> [  354.742887] Call Trace:
>> [  354.743030]  <TASK>
>> [  354.743152]  nfsd4_encode_fattr4+0x310/0x6b0
>> [  354.743396]  nfsd4_encode_fattr_to_buf+0xb8/0xf0
>> [  354.743645]  ? _nfsd4_verify+0x9a/0x160
>> [  354.743861]  ? _nfsd4_verify+0xd0/0x160
>> [  354.744072]  _nfsd4_verify+0xd0/0x160
>> [  354.744278]  nfsd4_verify+0x9/0x20
>> [  354.744466]  nfsd4_proc_compound+0x39c/0x720
>> [  354.744701]  nfsd_dispatch+0xd2/0x210
>> [  354.744903]  svc_process_common+0x481/0x630
>> [  354.745130]  ? __pfx_nfsd_dispatch+0x10/0x10
>> [  354.745362]  svc_process+0x12c/0x1b0
>> [  354.745558]  svc_recv+0x7d0/0x990
>> [  354.745738]  ? __pfx_nfsd+0x10/0x10
>> [  354.745929]  nfsd+0x8a/0xe0
>> [  354.746083]  kthread+0xf6/0x1f0
>> [  354.746260]  ? __pfx_kthread+0x10/0x10
>> [  354.746464]  ret_from_fork+0x80/0xd0
>> [  354.746658]  ? __pfx_kthread+0x10/0x10
>> [  354.746859]  ret_from_fork_asm+0x1a/0x30
>> [  354.747069]  </TASK>
>>
>> Robert Morris
>> rtm@mit.edu
> 


-- 
Chuck Lever

