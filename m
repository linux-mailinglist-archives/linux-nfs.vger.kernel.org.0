Return-Path: <linux-nfs+bounces-13586-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 21C9EB2373B
	for <lists+linux-nfs@lfdr.de>; Tue, 12 Aug 2025 21:09:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19B5A1B67213
	for <lists+linux-nfs@lfdr.de>; Tue, 12 Aug 2025 19:09:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B2C327781E;
	Tue, 12 Aug 2025 19:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mHjPhHIX";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="YiylvvGL"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8AA2279DB6
	for <linux-nfs@vger.kernel.org>; Tue, 12 Aug 2025 19:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755025711; cv=fail; b=IMTJTeTZfY/ss+F1GS5pxAj5l72wlb7mgWC3fHM7P7GFxxxb26hj5YFNQDHh7l5TpXRP7iBF7mSBRnrRsnhMHn3EdjCE1oP4htJmD5hICjxRbuaZbriiS2efufDvppmBArQHv4TkH1qd2oRUoH324hA6wjFAbkXhcEFz58tFIzA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755025711; c=relaxed/simple;
	bh=nr4/Mt/GE6iAAzrQ8Fm341RusuHX3jB7q8t4RRDRI34=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LdYwG1VHhqXElU2quxa0BTFNaBzgN+D3XKEA2Wrn1jBO31CHzo5OA6nyvx3MJlH4orcbn5RxXXK6Rh1hHwGWeMEYAGY4uQlqrZMABRH10O5wVRGjY4EE85UZ1y88WlUaTbNf7xEc+0zKABkF1WcyOqX++inbp1pmhiLfUQp6pok=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=mHjPhHIX; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=YiylvvGL; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57CJ2fQu005164;
	Tue, 12 Aug 2025 19:08:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=hI8uszjuxHprVCi4Hb5TxCNPud0HkfH6mOmpt5fmXPI=; b=
	mHjPhHIXjKB99fsaoUAljeEqzjyYp0J29Ev6rOiDwQmL65tK3OHXXH6d49+01S1f
	k96zIwZzK/fl00ovCfVwPiQHeVTZnONgQ3uZ+DLgYUHR+pAWgC6QjD4WsfAdYqko
	/7/KNrmGMIwse5nHYG0lR1EAxhB8KUwo8M0Hw3sSFZiehTL5HS0+UBqGuumdkpPs
	v07rpj0v+LJE1UoElDTCDat6x6mHwuVKyTTqpPvoUdCdWw4D85JimKfVqLkaH7AZ
	LAh/OS3KDGSo1XojmcmI+YQIdW9guEYLs6xKODNMVgF6iHDLS4AdjyPwL/s4ZzM6
	zUXuOSVBUD/lfz16xeUqzg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48dx7dnb91-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Aug 2025 19:08:24 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57CJ1D4K009872;
	Tue, 12 Aug 2025 19:08:23 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12on2060.outbound.protection.outlook.com [40.107.243.60])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48dvsgpdq2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Aug 2025 19:08:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UiJy6Z0jxFevhGDqOikG4KoaZNOctl5RY5L9YC8WGGum0Lpg7JvJjtrkcCiyDXMycFld2++ZQR6zd9CQlJdcZdb3QoiJUNbQ92sx0nEaMJ+7+lCrpdXFEfEUZlZjVyz27ybmBETOSUYvP8x7cCg2pjexx7G15RLMLYsCW7rkrPmHIHCoo6kasVyIVZKLUlg6ngqLn/GdsERyZnBoefhEEbcwy0F1DC5uq2b+Lsg7jUlcarMnvHJFpXdRLaaFE3gj39zc5lCgaN+8bxlA88J0eqSZQfB2MC1pWsOBmTATjUJPWAKlQDdzTDQVnclNpDVzNC+0rdDdO8khE3Y3qwL2Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hI8uszjuxHprVCi4Hb5TxCNPud0HkfH6mOmpt5fmXPI=;
 b=MjucUajZsn4JZoJYf16+M5/W1O2k5zmdGYpMUiihw++YwoJvlTLu1ol3p5dY2cZw9w1bhk/IPLXQ+Ec5k9ksGhA0dwxa4/7Q20AN65+XG4KkzDjB+pPgSDpGXhJm3s6JTsFdXSgVya7x5H39t2DLKIbBpFL93qS1Jg20UBqPwloJLRboAdtTSnDzLuZiGIJX+P9pnCtkRc+iOrpbyJjmZqPzT5/oICJDPK78xLz/NgT20sWV12zCeGU3d7vbNw5cXseUoIcSz/BNiyDTk+DRIUsIXLg8kFUWUhGe03D+By3u3Tcg+Vci4wuGvBvSpMfelaGjK94qCEJJd8H+GwxbHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hI8uszjuxHprVCi4Hb5TxCNPud0HkfH6mOmpt5fmXPI=;
 b=YiylvvGLC7dZSqy+GgRojeev5j1dMz2X/D1hqiKTczYzEb7nmzDIf/oXKQyN2E5egVgot8CjSeXlY+k2sAfY0a+GczXXrgFpxhEhAyhm5ru/RaPgpfi1UjLLzp+gJEe6GplGZKOg+TkTLQ6zIjmfXxCxvta8X3cHCK07sU0p8YA=
Received: from BLAPR10MB5124.namprd10.prod.outlook.com (2603:10b6:208:325::7)
 by PH0PR10MB4616.namprd10.prod.outlook.com (2603:10b6:510:34::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.22; Tue, 12 Aug
 2025 19:08:08 +0000
Received: from BLAPR10MB5124.namprd10.prod.outlook.com
 ([fe80::eb17:e79d:5975:fa79]) by BLAPR10MB5124.namprd10.prod.outlook.com
 ([fe80::eb17:e79d:5975:fa79%5]) with mapi id 15.20.9031.014; Tue, 12 Aug 2025
 19:08:08 +0000
Message-ID: <2a024899-6be0-4349-aed0-ee05e196fc1f@oracle.com>
Date: Tue, 12 Aug 2025 15:08:06 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] nfsd: unregister with rpcbind when removing listener
To: Olga Kornievskaia <okorniev@redhat.com>, jlayton@kernel.org
Cc: linux-nfs@vger.kernel.org, neil@brown.name, Dai.Ngo@oracle.com,
        tom@talpey.com
References: <20250812190244.30452-1-okorniev@redhat.com>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20250812190244.30452-1-okorniev@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR13CA0041.namprd13.prod.outlook.com
 (2603:10b6:610:b2::16) To BLAPR10MB5124.namprd10.prod.outlook.com
 (2603:10b6:208:325::7)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5124:EE_|PH0PR10MB4616:EE_
X-MS-Office365-Filtering-Correlation-Id: 0bcb4457-1114-42f7-4186-08ddd9d392cc
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?Z05SZEVCM3lpY0VJZFdBdGxhbWtsRHlKdlJNbTVGZS9YUzkxYzRScFEvd0FV?=
 =?utf-8?B?Q2x0TmFaa3Q4eXJBb2pOMG43aHNIaVRSem1wSmJ6QnV5VVZLU0R1K3hzWnE3?=
 =?utf-8?B?Q3ZqSC9FU21sMTl1bTBrR2x4VWN5SnlId20rVmtIY2lQTUphWFJ0TDI5K0tj?=
 =?utf-8?B?aU9kcVBSalBJQkVhUU1NZ2dUeGc3N282K3c5THVnQ2srbVk5aGhLcDNLcTdq?=
 =?utf-8?B?dURlc2xKTU5ZSlNSWEREMFFyWGxmZHE0SDdDeTNGOUdCMjliSTJzNUp5SzU3?=
 =?utf-8?B?U3lnay96TGtzV2duZGJVUk5DSjZ2enYxa2Q3NjduNjdXNG1WLzdmVTB4QUJj?=
 =?utf-8?B?ek1sYi91NDIxT2Y2cm1rbC82dWdseE9ZeWVkSVZJb2RwcmxoaENFSXZncTd4?=
 =?utf-8?B?bDBITHFhUW5pYVVJUG1UTDF0MEFETHpmRTFRM3YrZVZtNWhhclR3MmpqdWhx?=
 =?utf-8?B?d05vWUkzcnZ6UytwWUZVbVhsRGpZLzNSZkJqdnVsYkRPdmhuS1l1SVo3Smky?=
 =?utf-8?B?dTI3aitad05ENnQxWWJUNkV5THpGdm1lYXNJNHEyeTUvdUl1VUV6OHNhQ29j?=
 =?utf-8?B?eW1RM2pjc1ZIV0Rpakd1dzZzTTBleG5UMmpEOTBuek93c0dpY053SlNYZEZp?=
 =?utf-8?B?R2pjQjFFekZkb1FHZzBXQmE0Rldwdlc1Y1FIdUhVMXlBN0ttMElYMmxJVlNO?=
 =?utf-8?B?d3pDZFpnd01BMHI5ZlhHc241eDlqK1hHTEdLdmIrNjgzRmZNc1R4STFzRGI1?=
 =?utf-8?B?azlOK0pTaFllajFhQmhIaXdaMWNsOFhOM2N2Ky9JbEFpSkJWTWdDb0g1N0tQ?=
 =?utf-8?B?RkI3UjA1S3NxdUJ4cy9Bd1ZJcFdrZnpxazF4WFp6V2NiVi9MYVFlVGg3UUNy?=
 =?utf-8?B?ZFA0dEdKcy8yc1MvWjFrdXZlQmczZHhZZDBMS3RJTFNCb3RudkRDbHg2ZFk2?=
 =?utf-8?B?azRKRzgxZDI3Y2o3ODRJL3lHOXRMOVViTjFiUGJlZmp6Qk42L0h2Y0Q3ZUFh?=
 =?utf-8?B?b0IvcTFCZHBsSzFWRFYxWmdPa0VTY0tBWFkvNWU0UHc0SVZwS3I3Y09JNXJx?=
 =?utf-8?B?SGcxaUgzL255TnNQYmVUc1BaVDltbXdmS3k2b2pSWVg2bXoxQVBhdiszQjdl?=
 =?utf-8?B?aHI2dUlWODhTK0NKTEFOdDQ4TGRiRVpldUM0ZTdBZ0lYVXNjVXlGRmgra1Uv?=
 =?utf-8?B?ZkhGK3lGdGFYUkQrNVBsOCt4VElRbnVDSXBEY0RYRWFPMXhBUkc5eGVoY3d1?=
 =?utf-8?B?MGFad3dxaTVlRVh0T2k3RStLZlhQTlpmcDlIQVJPTCtvSnRWYk5zOVVwRDl2?=
 =?utf-8?B?bXkvOUpacEczVERkOTZzcjNaNkRsU24wVGRxMDdyVDJSbXdjUGhXUkVTQnlT?=
 =?utf-8?B?YXljYW9ReG13TEg0NGtvdTRObndncU80S1RwTmtNdXZzQkRSR3lLb1pSUUFI?=
 =?utf-8?B?V3pwSGZsditOWCs1bERIR2NYd0NNRk45NmVoV0pWNkdRL0JvT0xUME82ek9V?=
 =?utf-8?B?MHhBQXJkR2xGNEQ2OFhCYkJ1WmlLTVN5WkF4ek9oaUFjeDhaSmcxK252SWJ1?=
 =?utf-8?B?eThUSTk1UFR0NFBieVlLQ0o4OS8wWG9ROWJOK3g2ZXJ1b2lCb2NuQ3FxeEtx?=
 =?utf-8?B?c3JIV0RhalVhR0NDR3c2U29rRmZBb1I3THBITk5Ud0VaSW9QTW9SLzd4R2Jn?=
 =?utf-8?B?OTRwbU9ma1VOMFNQOXdQYVg0R2pPejR4dDFhYzlrNE13Yzc0cWl1eW9Sckp5?=
 =?utf-8?B?ZU92R0g4MWV1UVcyRkxTeTVjRnA3UVJQeW1lMmovUnFTWnhDQ0ZUNUh3SmdT?=
 =?utf-8?B?S3h3TEgxSEpHenpscUFOMUpOM25lV2ZBTnZWUVpnaFZQV2VnK0drRDFqMXgz?=
 =?utf-8?B?UU5rVnF6OW1DaHdvc0NRdnFRZGRJL1VwQlNtZksxQk9Hb3dUZ3A2T0RGak1F?=
 =?utf-8?Q?GE0leNgpGF0=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5124.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?U09NVXJzZmJySkdpWTloMmFaUU9POUp5ejdRL2dXVUFwV21IS0hIV0lINmtw?=
 =?utf-8?B?bExYLzFCQ3JSaW05aXpQT3JSVXBJTzdxaTZlZFJWWUR0TzFKNjF0dEpibzBt?=
 =?utf-8?B?R1lscVBVblFNOHJCaVJuSGVxSkNndGJycGsvVnFGbm1XbFdwVTB5Q3FWdWJy?=
 =?utf-8?B?dDNxVEMxN2ZXeWliZDlMWE52K24ySXdIVGJhZ0lmMHpEaU1tSjBsYURkcWgv?=
 =?utf-8?B?cFJnSXE5WDFCMG85NmlkaENBSm54cW9ORUhqYjBiTGlMVktGUURtMGVzK3VM?=
 =?utf-8?B?ellSZFBvdFUyYnNBZ0h5T0lZTkR3bWlyR2ZEbzkzSlE2Q1RuVWNoQ0pGKy80?=
 =?utf-8?B?WEhDbk5sWHdRNHprSGVxZjlZWVJINGR2bzhLdWY4YkZ2VzduaUtrWEd1b0ht?=
 =?utf-8?B?OHpVVVlrVlMyektCRWpEdVd1MnhyT3FaWlJjVVBCcHFWMzdqMFVDUFJnNUZC?=
 =?utf-8?B?eVFnaWM0YnNoajVOaVFWWVJtR0U4T1o2NW9aaUJoR0ljOWFDNVRBQ2FHSHNp?=
 =?utf-8?B?bFY4YisrelkvcjBONllzaWNacnkxd2VXQjNHREZHSHFmWFpBa1djaXpyNlNW?=
 =?utf-8?B?ZXo5U0ovM0hXdWYxRlFCNnhKSTF5SWUzY2FEajU1dGgxQ05jdTVENDI5dUh4?=
 =?utf-8?B?YU5pNmxUZy9RQXRZYkFqbWkyU0d2djJpVkJ4U0k2SGgwWU9PV1NJbHRZcTJr?=
 =?utf-8?B?L3U0WXRhYXM4dHlzbEJ5MjFITVRnQUFvaUdwaEtvL2duOWtTZjVGVDVVOGw3?=
 =?utf-8?B?NlNNckFkb0Q1Y2hNT01Vc0RvQStnMkNrKzhnOXZ0VzRIRFlIcms1Q1NkUlFE?=
 =?utf-8?B?K0hFd2RJRCttMEN2TjQzUjk4bzdJZWUvMmJXVi90SEgzdjVGbXZ3YjAvaHVy?=
 =?utf-8?B?UTludnhkY2llMkozRHpNdVd4SmJsVnZZejNwVVJIRFREaXFLd1lZaUtRZURz?=
 =?utf-8?B?NDVacU9BWjJ3Tld6TFovSVJ6UlZ1N0MzTVBjOFdnVkhRTFJjY1lzejZ6Y2xR?=
 =?utf-8?B?WE85MHlTWEVhaDJsY1lVTDRrTzBzYUFRbFp4amRqM21oSnBLbllZdTVDUjYy?=
 =?utf-8?B?cGhsdExOTXk2TDRLV3AwUWU0dGsvMWloYnJVb1RsdGZHSWsxYnBQbHVDUEJz?=
 =?utf-8?B?RnFrbkZsdzJnNmRmUFdtLzJZTEs5NHdYVGdadlFYaVU5Mm9FU1B3YVhYMW1z?=
 =?utf-8?B?VEcrSWwrK2x5Q29INmdONW1STzNKTWU5TVNiTHc2YmhNNHJwcVZvK0FhUHVq?=
 =?utf-8?B?cENYOW9KOEJNUDg2bEVHZk9BOGN1c0ppY25HM0REamoxSmdac0NPMHBla0dU?=
 =?utf-8?B?Uy9sVjZ6dklXZEVzQ2FWT056TXNQcTFIMHRlYjJBUDNhV3ViaFQwVktXdTJn?=
 =?utf-8?B?L21PeVFRbEtsVjdFMXVWQ2VaaUpGMGlkTktzYXpoejFpYkNpSlduVExHbVZ4?=
 =?utf-8?B?eE1lcHVEK0pNc1hKM3QyaldnbEJTQ1ZGMS9zRDRIeTJCYnBmZ3c0T2x1aUhL?=
 =?utf-8?B?VHpqTHNoWithZGdVQTFBRDdjUHQyTkFDNVdIRTRUVHFiMHgzc3JVS0F0SjFw?=
 =?utf-8?B?VytyWW5WOTFWeEIzdzg5UGNsS2hqTXZJRHdXaWw2U2lLUjlzRlZPMUlKRjVR?=
 =?utf-8?B?SkpxUXRPUFdENXd3Z2taaW9JRmt3Tk40YW04bjlHTUhCc2hpZ3pObklkRTBK?=
 =?utf-8?B?Wm9VWHlIWHZBRFQzUmM4WHZvOXZFTk1pNTJES2tmTXRYT0lIdEgyKzhpKzly?=
 =?utf-8?B?NVp0TElYWGZvcVpGRW1zMkpiOEhwRmRhZ2k3Q3diY0xSZlpSV2JkanlySzZx?=
 =?utf-8?B?UzNNYWxtT1FpTVpuQUg0azA2OGtvUHhiUUhHWFloeldQOEFtT0ZjdlI5bmZU?=
 =?utf-8?B?dzBteUlRS09yS3YwN1hUVkVqNmhZc3V1aUdMWElVWFp6TGN4aEJheHcxcmR5?=
 =?utf-8?B?YTJDSWk1V3V4dTVxZ1d3MFloN1hBYzlwWi9lK2JkcmhRd1FOWHFhckpYNWVE?=
 =?utf-8?B?YjN0RmpFSk1EUm82Y2dIcG94WVdrL3o2MXdwTlZaVnM2RVRQNjdvTW1PUnVN?=
 =?utf-8?B?QnAwUHF0V0k5aVRQMjZxMDI5MmRhZHNRaTJCaWRyVEF5eXBRNGFHNklPTlox?=
 =?utf-8?Q?Y2yMUf3MnuL1igMZeLJfeV2pN?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	64rizv/pgqTmc7SWBGfNcSkhLdwMVNwz/gkEcg5FTflmy9GKUXflF5fnEEhWEqUjyE176P7RKVz7pQNA9t5zNsNZV7hhR78oAwcfEAxibySXs/Oa+nN0pOwrqNjx3a7J2bI6Wq1c/p4Q7q8eFXtPXPhbbUCLY70Gho37pOvQEnFzUlpNPwuf4B5p+LMASBZ0Z5cPO6QogEGv7gnHpbydRmb9qPOSKxeTNwliuq4stSSehaYAXHBfUvU8yQabPC6DHtO8SSxC9ZPewxsVbJ6C7JcggpSnXQ+otiEZSCbNM09EzubTLnlgvyt/p2G3edCCElMDp42nbsrR9GcyDbUWm0ybqReRbBhqyjoCNxOWfYzMTmAJ+k4FMnU9pfRlUBdMDJEafuElV05c5+kbwS04sFVSkmW/mDWfekuIFicYfl8hjaMK+y9QrxOdktN8XmMosx0BnEIP/iVAUOlehTpoiRKTGnX42eiSuG1yvYWTshdDrAoowpGvyC54ob1vikQdReNG3KOaJcwStqEr7KDBxdO6rYHiQ4xa5A+WjQcNXWAEXzvMUYGY5hcyrzDXfcV2AgiMF3GuzXpb3oIulz2tDzZmVsOqDdG7dX0yVRGl9HA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bcb4457-1114-42f7-4186-08ddd9d392cc
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5124.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 19:08:08.2263
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EmYpeJhPA0XVTPxS8iimebDIY8/j35ZzSVVxfo4B+VqXF9P8NZgziz3+A1tbEK9jMb0SgngKgkgOLAAAqV3M9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4616
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_07,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 adultscore=0 mlxscore=0 phishscore=0 spamscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2507300000 definitions=main-2508120184
X-Proofpoint-ORIG-GUID: EVK4fd7axserYVUo9qXF-GgS_w5vPcFK
X-Authority-Analysis: v=2.4 cv=WecMa1hX c=1 sm=1 tr=0 ts=689b9128 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=20KFwNOVAAAA:8 a=7EEwvMb_rxBKEJ9oGVEA:9
 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12069
X-Proofpoint-GUID: EVK4fd7axserYVUo9qXF-GgS_w5vPcFK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEyMDE4NCBTYWx0ZWRfX0nZwRt+JMel/
 1f1glDhj/O7epY/Pfjh51d+7b+p45U0upAb0AE7QGN7hOmm7v88b3yFPdvWfP0qqkMPFsgPDiuU
 RDh+Wst+Xz6WrFA6fkp5emGe2rbFHH//5QJTgtxwfSyle5/UMciqxfkt3yPQPfYobIb3CDKuRon
 eB1Iw3FH7rQrE5uyTkULtnkiqT8mbDx+pPZVzVPs3OO3yI4qYNgz96ROBVbM/EsUWgw6yucyLYK
 F0cn2ygGqzSCez2mk6sU/xbXtvsDpCZKwqol4hIbugnQmf4VEBRvbPBU9XbOCLRmo7Sy+SUAKJL
 q4ZAp7yKsifZ+b7Y9SOFMOXeRQTsTPxkHy8JjyT191cF7ottXgA0iLcdWag8BCLimUP1c6oiUp1
 2NyJ1jeLs4LZ4V9u9AB+nUx7Q/S4fFEdc5SyDttkit71k/Bi/PrDGYi8SI20zd6uDd+6GLfg

On 8/12/25 3:02 PM, Olga Kornievskaia wrote:
> When a listener is added, a part of creation of transport also registers
> program/port with rpcbind. However, when the listener is removed,
> while transport goes away, rpcbind still has the entry for that
> port/type.
> 
> Removal of listeners works by first removing all transports and then
> re-adding the ones that were not removed. In addition to destroying
> all transports, now also call the function that unregisters everything
> with the rpcbind. But we also then need to call the rpcbind setup
> function before adding back new transports.

Removing all rpcbind registrations and then re-adding them might
cause an outage for clients that attempt to mount the server right
at that moment.


> Fixes: d093c9089260 ("nfsd: fix management of listener transports")
> Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
> ---
>  fs/nfsd/nfsctl.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> index 2909d70de559..99d06343117b 100644
> --- a/fs/nfsd/nfsctl.c
> +++ b/fs/nfsd/nfsctl.c
> @@ -1998,8 +1998,11 @@ int nfsd_nl_listener_set_doit(struct sk_buff *skb, struct genl_info *info)
>  	 * Since we can't delete an arbitrary llist entry, destroy the
>  	 * remaining listeners and recreate the list.
>  	 */
> -	if (delete)
> +	if (delete) {
>  		svc_xprt_destroy_all(serv, net);
> +		svc_rpcb_cleanup(serv, net);
> +		svc_bind(serv, net);
> +	}
>  
>  	/* walk list of addrs again, open any that still don't exist */
>  	nlmsg_for_each_attr(attr, info->nlhdr, GENL_HDRLEN, rem) {


-- 
Chuck Lever

