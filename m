Return-Path: <linux-nfs+bounces-15849-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C2929C2546C
	for <lists+linux-nfs@lfdr.de>; Fri, 31 Oct 2025 14:34:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADAA81897B56
	for <lists+linux-nfs@lfdr.de>; Fri, 31 Oct 2025 13:34:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E84D0EAC7;
	Fri, 31 Oct 2025 13:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="j3DOLJV+";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="fSPXzZrb"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46BF819D071
	for <linux-nfs@vger.kernel.org>; Fri, 31 Oct 2025 13:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761917648; cv=fail; b=OR4jNXaxOK7oN1MJBCO/RrJLBBSREwtcikOY5/WgC8jyOuPm2UsPJXD+dtPEnNcNzG6GL9m7Y0/miW7e5y1eVMsTOw0FxF8Y+NOWLWe1CldrWNNAUk+FIJyqAmFuq5BxN2HjJHLcra7gCHNAMqz5UJ/7h0sNrsM4BG6c25zOzE4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761917648; c=relaxed/simple;
	bh=sFUMcubFZ8CmhXsOvhs7OMmh5qZ5+asGyTZt8gGWqK0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PjTYuua0GIz3GewfZbHtgfCC6X2zWyqdmtLOG4fpucoqNwWPScrPTSW8NX1lFdEy+vNZWAFQ29frqAldfdPa1JGLtWZuB5EnYyJUS6jYuJxaT2tn6EL0vO0ro5hEBVaofeZ5TW5+hpV06XaKqa0gOQoBelJR9RlrOt6T0Ph0MVw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=j3DOLJV+; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=fSPXzZrb; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59VD4EAc027401;
	Fri, 31 Oct 2025 13:34:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=TnZ5dKQL/GEWvRF6iiaWx4Bd7/P5xFhxM4VhieYJll0=; b=
	j3DOLJV+zKyqz6t1Hw7WJnAXa56stcM9wNrcVB/NQ3TvPx2UlqoSwmhR0hp+rUTi
	LTKR1jTLV18Oxq9dpWRMyKSajyq/SSRl8FT6HdP5SKSpoNmx2uVsdpm7JO2wIjwz
	TV+Ix5rKFO9BKrKLO8I6jl9n99YP7zw/KVtgBx/8qS8VhJW+QmD8+LALwyevvug6
	0YXtZFTLcaaGHIbXNnKGhkDkjqqFKSnCc1f2ojr9MnkPoW32H+me2nXFZvvF/Upx
	DbwsQBZ7F1opbA4BAlf5A+HYPJerHgJL6F6uKThbO+srbZPZfEQFkPW2jZlKO2NU
	3mEfBKOSUGjYcFWVLeTqNg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a4wp30276-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 31 Oct 2025 13:34:01 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59VCnZDt000485;
	Fri, 31 Oct 2025 13:33:54 GMT
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11012005.outbound.protection.outlook.com [40.93.195.5])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a4k7bv0y0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 31 Oct 2025 13:33:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f0i3S6cwYikJDBqn4UkjqJORax/OOY9c+TFkeDXe2deR8/OxzNnmQaM2UwY8PcdCYDf8mJydPLk5+FN9mPi7pPcAXX16amwhm0oUzxIloUdMcaXxVSfQgl/if1JKSzVCyHbd1sn2U7h49XJg8Dc54QRR7v13xYj9C5U1gfUU2+eUB1WlY1URFFrPBeil4wTWxMVD2L6IKfARHW8dhltGxUOMlkngreluDlhwgYm2Y0EfBjPlilQPCQKQMdcihg3Z9ua8wo5T5ot8JXFU1SKlJcgpVXVdzpIMmnk7TaskTGTpwjjX1YR6i2HNsWP0WV78PVjaKCHDIVCcj8jYy0pYMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TnZ5dKQL/GEWvRF6iiaWx4Bd7/P5xFhxM4VhieYJll0=;
 b=s+EFQG8y/BqObTi+PQr8xHg125ZIj0nsGHPxjok5A/kFdFusfXmx1f99sgN0asa+vHx/yf4zLmd4f7CGlHKkt8vKODysUa3v4hb2d24qc9al0uT9WsMQnms1oGgAXmgVnTK88fuvlvs1kOsmkkZsVW5AeGVsO6nOmG5kfxZl4IlGE0KB5aptZgIeR7CckYPLgNPs6rVD2VlUC5qVLhmqnUjQGBnKXvLgx9URCnXqOLTR8QfrnkJoYO6d3tIFvZFQ5ZF419YaSUw5izYUjjiMn2XKlcWBTe5anG142EVuyxHioBhspqKLhjoiJeg4M3XM9xue7aFhxO6SLvssbSl73A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TnZ5dKQL/GEWvRF6iiaWx4Bd7/P5xFhxM4VhieYJll0=;
 b=fSPXzZrbN+axzJQO9E4Mr1eOEvQ+l8VCgtrcWAlrhyx0+wq9fnVwwCevuQkC4sFLElbr5lXXNVK6HZoANmLs8Gr+agMwB6V5LR9Z4Q9LanNSJNef/IZh0vALhbry4g6I1o8oP1QTJeNDGmHmw4hN1FXN5K5Zdu6MnFPlwQo/jTU=
Received: from BY5PR10MB4290.namprd10.prod.outlook.com (2603:10b6:a03:203::15)
 by IA4PR10MB8328.namprd10.prod.outlook.com (2603:10b6:208:56c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.14; Fri, 31 Oct
 2025 13:33:49 +0000
Received: from BY5PR10MB4290.namprd10.prod.outlook.com
 ([fe80::c86a:40f1:7833:ef3c]) by BY5PR10MB4290.namprd10.prod.outlook.com
 ([fe80::c86a:40f1:7833:ef3c%3]) with mapi id 15.20.9275.013; Fri, 31 Oct 2025
 13:33:49 +0000
Message-ID: <503dacbf-49b1-4ed7-97db-8b92aff9f1c5@oracle.com>
Date: Fri, 31 Oct 2025 09:33:40 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [v6.18-rcX PATCH 5/3] nfs/localio: do not issue misaligned DIO
 out-of-order
To: Mike Snitzer <snitzer@kernel.org>
Cc: Trond Myklebust <trond.myklebust@hammerspace.com>,
        linux-nfs@vger.kernel.org
References: <aPSvi5Yr2lGOh5Jh@dell-per750-06-vm-07.rhts.eng.pek2.redhat.com>
 <ed50690c04699c820873642ea38a01eec53d21af.camel@kernel.org>
 <aPURMSaH1rXQJkdj@kernel.org> <aPZ-dIObXH8Z06la@kernel.org>
 <aP-xXB_ht8F1i5YQ@kernel.org> <aQKhAksYqPjOzUNv@kernel.org>
 <aQQV1Fw7MX-3cdZd@kernel.org>
Content-Language: en-US
From: Anna Schumaker <anna.schumaker@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <aQQV1Fw7MX-3cdZd@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0361.namprd03.prod.outlook.com
 (2603:10b6:610:119::27) To BY5PR10MB4290.namprd10.prod.outlook.com
 (2603:10b6:a03:203::15)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4290:EE_|IA4PR10MB8328:EE_
X-MS-Office365-Filtering-Correlation-Id: 78ce007a-82d0-4ee6-4472-08de18821ffe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RXdoYkZaNmQ3R01lQnF0VjFUblRJYXhjTGttdGtuaXJwYzdKbTUvQXJ3SHNv?=
 =?utf-8?B?UXlxSEVJQitBak5lMXhETGJld3pLYjR6c3FNSUlzTjFxdEw2a05FVGZRU2lJ?=
 =?utf-8?B?V0xqUkhEV2JaWXRQM0NxVGl0TnorY0pRbEFPRlI2RjhkUkxwa0ZEbVRoU2xQ?=
 =?utf-8?B?dUlKa2djeTNsaGx0UmJMdXFDQUxIOUtkQXpMTkI2MHYySzJsZWNJTHJSUjZz?=
 =?utf-8?B?b1kyT21vaWUwaEptcnVLZ2Q2NTc2L2lyelZzeEpraHByQ2pvUHZhOUFDTGlm?=
 =?utf-8?B?empHQ0RmSFprbVhub2tybWRYYWhJQU9jSWVWbXVFS214YkxlOWJJSVhHNUVT?=
 =?utf-8?B?RWVGaEliaXJFM3V0bTEzL0NsdVdYMEQ2Y241VkxzbU9zUHgwa0s4SmVLWVpN?=
 =?utf-8?B?cW1yWW1MMEJwZnlicUNZeFVENzJHMWJOeUZtV3RvV0NrdEd2Um0wa3Mvc3ZJ?=
 =?utf-8?B?YUtqcVY1b25iL0xFRXQ0eVJYTkJhNVpBRkpLTHpCNmFvOUNHSC9JL2dwejNR?=
 =?utf-8?B?Y3p0bHAydnlhakdvZ0FDZ3NIS3ZPWU1EZFBZSnp6V0EzNmxaYStFMHFqcGVX?=
 =?utf-8?B?MFFaUHJXWlFyT0EzVFhDZ1VuT0kzZEMvcWZjZE9mRmlaR2ZEQ2J5QURDQlI1?=
 =?utf-8?B?MG10QUVqVXRnM2Z0ZWxBM3U5V2psQ09kODhnK3FMeEhRek1MQ3VZWXZQcWk2?=
 =?utf-8?B?ZElNRWxSazBKNmVaazMrZ3BKM0dYRWxuZDhPQ3VjQ3hjSUFIdHRWcXZVZmxn?=
 =?utf-8?B?cmRXVWZHMjk3OGlzMDF0bzExMDI0SzBQaHpib0Q1MmlCYk9FZWxBZU94dlpP?=
 =?utf-8?B?cFlXV3B3YTRncUVscVdiNjZET2p4ZlJzakNtZDRQWUJWck00Vmtwa0haaWV0?=
 =?utf-8?B?QlBNTDdUN21QUEpSMmNiY0pQU0FXeEpwdCtMVlFRUWxCOEhDd3pDVzFYaHZr?=
 =?utf-8?B?UitlRG5zTHlUZEZlTTRCU0l0U3dHcGt5Y1JPUnlpTElFc21FeGtwc1E4Rmdo?=
 =?utf-8?B?NUZRVmMxRllObUVJeVZpczgyNW5HUm9VQWRCMlQ2L0g3dzZxcm1teWROR0hC?=
 =?utf-8?B?WDJTYnROZmJISkF0ZDhXZWExWDFocTljRUNGZVVPVW14UVJ0TytJUWplbXl2?=
 =?utf-8?B?Y0dDTjhpaWV3eWpuOFJZV1RvOEhFcDlWc1BJclFPRGtWOUxPWFFJTmxmT2dL?=
 =?utf-8?B?THhlTFcxV0VtWjY4Y1ZWR2hvYyt5U1V6SXN4MXczMC9DQS9RYjNzaFNhSC94?=
 =?utf-8?B?dkhDTWFBVnB6TlhPMVpwYUJ1NTNHWERZMGluUGlkQTY3QXZVVEYxU1Z2dHEz?=
 =?utf-8?B?ZmtLcEhyaXEyVlNyQTJTNGZYMHEvT2xVMUlxZUxtZk01RXczQjZhamF1K1Bl?=
 =?utf-8?B?NytJU2pYR0EwMENzZSsyOE9WZ0FjNSt0QkdZSlB5NkNhcmxJdUJpMkt5dmlK?=
 =?utf-8?B?RnEvdklKWVM2SXA5ZFNINDhQWjJBdkI2RjRvK0lxd3JZOGVRYmhhaHd6Y3Yv?=
 =?utf-8?B?aFJVQXVsQnFLa3NjL2dQTCs3MXFyRGNGS2JOUXVDTlRyWW5KL3FmM3pvYU9F?=
 =?utf-8?B?Q1U1eXdMYm5PMG1NWDdhN1VKRkRtNG1aR2hwUUs0cmxoK2JVLzZpenlIMGFL?=
 =?utf-8?B?VUFSLzJhT2xLa0RlVDB3emhGSU52RW90ak5LWE1haFRhRDRpN1pXZXNvd01h?=
 =?utf-8?B?MG1jbnVvbmlsczhVVGtHSm5mTVpScVNndFo1MDBObVA5VVgvMnRXQVlzSlpF?=
 =?utf-8?B?eHV6U2pGamx3OWI0bUk5c29kUDVEdUUrTGFXUmVreWFLVTdydWtPSWhuSis5?=
 =?utf-8?B?Z1lsL0c3eWlrYVRQT0RXQmhZaUdhZXlzZUdjZmJrYzRid0taanRHaTdpMXB4?=
 =?utf-8?B?MkVMVmVtV0lleWVWc1Q1UnJnL3pibXhxdWcyWFl2Q2RwQ0trWTZUN2ZrWTRt?=
 =?utf-8?B?TGhDMjhzN05xOTYybVVaWUcxSWhRdk1yM25EOExyV2tXbFR6eFcyRklKZlVx?=
 =?utf-8?B?dm1SejNMSHlnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4290.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?czVaV1lpMlBzeTFtVHdxSXVLSjE3Z1FuS0VXaVpkblNKWjk3RHRBbm9ncVlC?=
 =?utf-8?B?OWtoQk5BYlhTRFNVNk4xeXBEUWVGcUVVSzh1T240a1Jjd3ZKTjNYSUE1aUJM?=
 =?utf-8?B?YTBnd1p0Mml2NGZIYzU3d0pLQnliTUMyQ0dsSTdHQnhVbEFZRkJBU1lCMXZI?=
 =?utf-8?B?K2FQTXdJNldsS1ZYMVM1RytFbmxEQ3NqMEp6U0ZacmJPSEM2VWNTVUhOM2RB?=
 =?utf-8?B?WGxxdEhWVUNhL3lvMHlDdEJjdSs5dlZBK2NNWnhzN01iVjlqbWdXbkdkQVJX?=
 =?utf-8?B?RnU1dk1yZGs1dmVMYjdOZXVFeWNJZC96em9rNWJBVDU5NXBqaHZTTUdYKy9K?=
 =?utf-8?B?cy9TOXgwL3FOQ0tnUTJSekNlYjhqWGhZOVZKK05YSllXcGFwV2NLV1NSQUMw?=
 =?utf-8?B?NGkzRXZMbW95dFh6Yk85NU9Oa2FmSm5ZL0VqTUdYYmxmM1hOUnZxS3pLYlBr?=
 =?utf-8?B?bVBoRkYzWkh3TDNjSnU5djltUjBOY00yMG9INHpGWHY4WVRtVDhPYll6Mml5?=
 =?utf-8?B?STBJcjZXNE9vSVVGcEJkNVU4YU56a1AyeWFMRGtNdDI4MCtqMzlROEZGb3BY?=
 =?utf-8?B?WGNhb1Z0SVJWNUt6eEx5UkpWV3hxRTBRMGRwUERSTE5CSTBwaWNTRzFZUkli?=
 =?utf-8?B?cEdnMXNBTmNyRnJEY1N3bUNWMGs4SmFyaVErdkdHcjBSd2l0cFhPM3pZT3ZN?=
 =?utf-8?B?Y2lTL2VHaWNoaEozaExoYVRSL2U2MFk4QitkeG02UFQ0b3dUUnpYSXBwcFhr?=
 =?utf-8?B?L25aS1kzREs4aVJTZzBPZWhOc0FkWGtVanIwWmNJV25mSkZMenZ6N0xEelkz?=
 =?utf-8?B?WVVSbHNCbHpOK2RVV0VTSkhLVFB3cmQwMmpqZ2ZnT21UdG9EUWZxcVVwVG9U?=
 =?utf-8?B?WkN5QjhIaG5nMVVmNlA2YzRZRUVtNkM4SjRMa3hIYkJVNzJsMlpybHo2QjdY?=
 =?utf-8?B?c3g3dkk2MU54cVZidEF0VkRkNis0MzVEUFc4OC9UVVpBeDRsUHA4cUpSVmZF?=
 =?utf-8?B?bm42NmlUWGRsQ1ZUbmhCVDJUQWF3ZWxXMGo2RkdaeE95MFJ2QUtqdUtLckV0?=
 =?utf-8?B?aWIxb0RkSDlkaFZEc01DSzVmeGQrZmgyREZTQ2FZYm1uTEZlMVZHbTNHSDJx?=
 =?utf-8?B?YXA1ZG9VbTBDdkpkU2hFY2tqVmIxSXRaWXJSb3B1ekNjQkJlcVZWdjYwV0Vn?=
 =?utf-8?B?SGRvQ0NJUlpTcXdDRzdLaExoc0dLZ2NpUVFsMjBhU1FnVEZXTTJ0ci9UaUgv?=
 =?utf-8?B?ekJrWmVsTVVxVDhpWnJFb1daRHE5QmpUejBJb1BpampUTjlubUl5V2VYT045?=
 =?utf-8?B?R2p2Qk9lSDlsRmEwbHZ4VkVXYXJsUDBUanQ0Q1IvQzF6NG5MdFFDaHRqQWd1?=
 =?utf-8?B?L2U0QURKNVRtQ21LV3RkZnE4RGI3amRFaUM3eDhKZlRIaWRXM2x0Yk1ub3pC?=
 =?utf-8?B?M0pHNk14cGJKRkp4ZGowZzFFWVQySElGc01PRHhwMFZEWHlqRHpjNDk3TXpw?=
 =?utf-8?B?V1dQdUpCY2xDNnpoeStIbnJtZ1grNHo2SHpneG16R3hCczFQdTNudlZSTFlG?=
 =?utf-8?B?OFE5ZGJJcEdpVy9oYTY5d0pJeTRhaEhHZnFQb3gzWEphWGRMWDIrRU02RGVy?=
 =?utf-8?B?b2ZuOUh4eG9Lclllc1FHWEVnalh2Qy9wVTU1TW12M1dPbFNRZ2Z0cVJGODFv?=
 =?utf-8?B?TEFxcy84TTlKaDRpVHRUYXB5SW94U0o4Y05HV1kvaUdIYmNpTm9PQTlmN0Vp?=
 =?utf-8?B?a0FYSENBR3pBMmRpbEdUbXl6TUFxdW1mbm85R01iZjZoL1dPK0FubzVHa3NL?=
 =?utf-8?B?ZzlzS3lFWmdCVWgxcEI0SGpxV2hwemExMjRVa2RGOVRqdmwrQzNZcHFPRk5Z?=
 =?utf-8?B?RXRSZEFsRmhrUmlrZnRDRzBtdE9aVUNOM0hlL0tnZ3gxQTlvbXZtSW1OS3Fy?=
 =?utf-8?B?UXhaa200QmlGbmwydVUzR3lVbXdQL2t6di9id1R5N2dCamNkMm1SZkwxS3Ft?=
 =?utf-8?B?ckZpQXFTNTN2cFQraEZIdGQrK3VmSGlhWXJVMHhMME8yNmZsbFVyeHNJUVhi?=
 =?utf-8?B?cDA1SmQ2RnRkMHBDbUpPdGdMcHlSejBoNVFRRWhPNjIrUnd1dUtDUkxReW8r?=
 =?utf-8?B?YVRMaG1aWlFwajFhc1NITnVPWWRicnhqRnZ5eXpYSHpldGlmU3JOOHNZY21s?=
 =?utf-8?B?ZEE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	vq6Nu0eOHWxAOB09dmZseVbTktATRbEVDN3t4TBASmB9hxXXpfNzgABtn3tAW5LDTP8PWHMHfpU1ZUWtvbVoKkVyu8dqx0ivpiAhSv5UKkc5+LjxvC1GO7I+O6ssn2B5by0AS3s6yiNAjHdvFMkgvMTpWQF55hK3VJc9WFqodSDGXn9Vzq8/bpS+ewlZULTd9GKOSGte+uVJ7y3pc9ZdAvBVtSpGqHrxJ/ixHa4m+p5oyNcnRsetKtrjVo8pKVajCufbsSSnPSbQwspD6bPUW4sC8LGD5zr7xpaRZstfiecdmq9d/2/YWvZV65rhJj35GsqYmnx1Vr/7qPz5JE7LRMLHAArprMebUqNDT765p7Z2vMaSddB3+wK6xhs7fmGX+752ngEmhkeDW+ge83hQ3uPbZrxbhL4vrDDZ2RE9mOf/+cWmrpvfKK3e/3Dkt3tRyHT/SF3kAob5cntI26jj3yffmBlOcAR2Guithlkl3jfEAJF8E1ekxNryObs1yvmmaSvp7Q2KC16o+9Elnqp0qbvwrYAOnjjnByQPZ7n2Du03oM8kW4nOsi5qLSzYDpHKIntB2IlX5u4AlqtotzWGfZNWvCskhXBe7qGnGuQW9mM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78ce007a-82d0-4ee6-4472-08de18821ffe
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4290.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 13:33:49.6270
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i8FRLgs37MnnAK8jQKBYD9ibh7IQKerv6s6yygyxCToDPUTS8TJjxjM66FC0c0X76rGa99JRXqJoM2hqX9BGMlE7UpuM9JVYWdccIR8GZTM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR10MB8328
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-31_04,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 mlxscore=0
 phishscore=0 suspectscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2510310122
X-Proofpoint-GUID: vJkS74T4oqMqhrwP9c0LS8iKnNGnbQbZ
X-Proofpoint-ORIG-GUID: vJkS74T4oqMqhrwP9c0LS8iKnNGnbQbZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMxMDExNyBTYWx0ZWRfXz5hXesSHTsTs
 buy4sjBYZyBFWvJUZgr7fbwdBkmyrZNATGnSLJj8qvTtJ9iA66qzBWZE0gv1E6qYASxbSk3PHnl
 1IRDGC+fZVZdkQ2kOBSADpbKs1CLZETak+AYUsWvaGcssL34SYqijP6LAQCGvqglEKSEu9CKEg0
 V8LJqOJlTFv69I+yJ0EQ84kKy9ya5vWf8Bfe8cpka7mLPrGtJcpyUyzPNp2QLryfM/1iBjVLDUp
 ODrvjz4OecMEJMi69RAmUg+TragDlnW7ClpoSoTRTiVAhtnWNz2r0DhGzbcaTa0znn0nSoWiVt0
 iIvZHkXUpk+c8Sed5SDUZ+9+b5j5ssXBu3DcLPU8QaEcdXFxQ6Rbj5BC5DjF1/1GFD8Djm7gl3d
 ebJSHTYra4+2zflsCJleF6pmNHzDKg==
X-Authority-Analysis: v=2.4 cv=BcPVE7t2 c=1 sm=1 tr=0 ts=6904bac9 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=JfrnYn6hAAAA:8 a=4xA3uB-soVQXAcI7jWUA:9 a=QEXdDO2ut3YA:10
 a=1CNFftbPRP8L7MoqJWF3:22

Hi Mike,

On 10/30/25 9:50 PM, Mike Snitzer wrote:
> On Wed, Oct 29, 2025 at 07:19:30PM -0400, Mike Snitzer wrote:
>> From https://lore.kernel.org/linux-nfs/aQHASIumLJyOoZGH@infradead.org/
>>
>> On Wed, Oct 29, 2025 at 12:20:40AM -0700, Christoph Hellwig wrote:
>>> On Mon, Oct 27, 2025 at 12:18:30PM -0400, Mike Snitzer wrote:
>>>> LOCALIO's misaligned DIO will issue head/tail followed by O_DIRECT
>>>> middle (via AIO completion of that aligned middle). So out of order
>>>> relative to file offset.
>>>
>>> That's in general a really bad idea.  It will obviously work, but
>>> both on SSDs and out of place write file systems it is a sure way
>>> to increase your garbage collection overhead a lot down the line.
>>
>> Fix this by never issuing misaligned DIO out-of-order. This fix means
>> the DIO-aligned segment will only use AIO completion if there is no
>> misaligned end segment. Otherwise, all 3 segments of a misaligned DIO
>> will be issued without AIO completion to ensure file offset increases
>> properly for all partial READ or WRITE situations.
>>
>> Fixes: c817248fc831 ("nfs/localio: add proper O_DIRECT support for READ and WRITE")
>> Reported-by: Christoph Hellwig <hch@lst.de>
>> Signed-off-by: Mike Snitzer <snitzer@kernel.org>
>> ---
>>  fs/nfs/localio.c | 83 +++++++++++++++++-------------------------------
>>  1 file changed, 29 insertions(+), 54 deletions(-)
>>
>> Anna, apologies for stringing fixes together like this; and that this
>> same commit c817248fc831 has so many follow-on Fixes is not lost on
>> me.  But the full series of commit c817248fc831 fixes is composed of:
>>
>> [v6.18-rcX PATCH 1/3] nfs/localio: remove unecessary ENOTBLK handling in DIO WRITE support
>> [v6.18-rcX PATCH 2/3] nfs/localio: add refcounting for each iocb IO associated with NFS pgio header
>> [v6.18-rcX PATCH 3/3] nfs/localio: backfill missing partial read support for misaligned DIO
>> [v6.18-rcX PATCH 4/3] nfs/localio: Ensure DIO WRITE's IO on stable storage upon completion
>> [v6.18-rcX PATCH 5/3] nfs/localio: do not issue misaligned DIO out-of-order
>>
>> NOTE: PATCH 4/3's use of IOCBD_DSYNC|IOCB_SYNC _is_ conservative, but I
>> will audit and adjust this further (informed by NFSD Direct's ongoing
>> evolution for handling this same situaiton) for the v6.19 merge window.
> 
> Hi Anna,
> 
> Please don't pick up this PATCH 5/3, further testing shows there is
> something wrong with it.  I'll circle back once I fix it.  But this
> 5/3 patch doesn't impact the other 4.

Thanks for the update! I've already looked at the first 4 patches, but
hadn't had a chance too look at 5/3 yet. I'll skip it for now until I
hear otherwise from you!

Anna

> 
> Thanks,
> Mike
> 


