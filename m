Return-Path: <linux-nfs+bounces-8416-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BB46A9E81F6
	for <lists+linux-nfs@lfdr.de>; Sat,  7 Dec 2024 21:29:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A8E318837E3
	for <lists+linux-nfs@lfdr.de>; Sat,  7 Dec 2024 20:29:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8796414C59B;
	Sat,  7 Dec 2024 20:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QNzxrI4i";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="o5nh0fpP"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 746481487E9
	for <linux-nfs@vger.kernel.org>; Sat,  7 Dec 2024 20:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733603369; cv=fail; b=NlKSvJ9XlyhHavhiNlCtk2vT6LtA8etrnCuRvmNN4Cf09fXXosPHyENDUGfHGDlarsfGgPzXN4xmFYPlZ/eiUFSY61YGoW+GgpoA2Xzv8Nc3dWtm8GjNdxJTrSsWsMPTDmgDJscX+ILG7mFBa+kabMbVg2josWmUMkt1SMA4eeE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733603369; c=relaxed/simple;
	bh=G1Y6y/HkcWzw6eC+AN/2mGDgQnmt2XKpBdEz3AdJXKk=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UTF9CdzDopLgYZ9SLHrk1fI368XLko06fTkrHntjBgCPNZaUDk1GNkhMzss+aCnidWyauWi9FHAFIFGPpnh0OSzV+m/rrFZRyhiXlUma29wlunahvWiaFX0tBHa3GbeuFlkgCqMfbTNTnmRyw/8Xc1XjKVoG1cjq7UWG0DCpnTg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=QNzxrI4i; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=o5nh0fpP; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B7KSX6D025010;
	Sat, 7 Dec 2024 20:29:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=HMGSRayK8NmTGCCF5A1b/fFRB9hiuHPhuyEp50i5KAY=; b=
	QNzxrI4i9eTGq5abuddqc84CzNO7DOzx+klitJeOtAuhFjBM9doI8PMoQnQIp1/S
	TziwTLFRAvjBZH2PMR+SkjeiyPHZ7Ous/67X78RPnx5lrGC8pzKVhNDnB85pH8EQ
	kSofqKW1v/MYg5RDm7jFKImRzOjm1nQZIEbxz6DReEhBlk9Q3SjhaLQ12i+DXw1Q
	bbR1Z2guYJ3zaJV6ByaRRn+Qaq9Xzu66Vg6e7+dMs4dPn8d7dLKihpOaX0vSud0u
	wf/6zqYA+S+GjRPs6gI8g4p2A5c99TPr+ZdehQMComBed2iEScKALquCZ7/YdmZD
	0vvsQtCYIrDqdLCVDir84g==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43cdysrv1h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 07 Dec 2024 20:29:16 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4B7HROGn008586;
	Sat, 7 Dec 2024 20:29:15 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2042.outbound.protection.outlook.com [104.47.70.42])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 43cct5quhx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 07 Dec 2024 20:29:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ur4JwdAIlnC+zcV237nKqgUREcLBQbxdcJPZczha+Xi58xRPTudymBYOIJ2ZvQPo2k+LJEjM8c4s3W5re5eetKcYmzZoTx7QmlVbMZoBDpgPwIqMW/HO3pa2YbIn2doIuuuIEOgg/8oOCl0eCvscZYKcYlTcLOQL5x6a5m3GDOTsH4FVPcfV8kj6WkapCxnK1S4qUlcBpRZopXTW6ULLNOG3WLSbvIfXu0ulbsufX3Pc9qsuBmc67djSaEONTUAegiMolvfHNlS545IHmOJeLDC+4SBjAtXpyLCCI6AY4DSsGkI36EVAQ1kS/JviNQbjWV20cCpMceTozMXHao412Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HMGSRayK8NmTGCCF5A1b/fFRB9hiuHPhuyEp50i5KAY=;
 b=wr/yeKLPy2LGAJ94ZrlOj2QY5Kx2CtZLceyjhAW0p2SvXAjQenqDV0ayvVRsu87Leb3Iqs/dIsWoxghP3Itsfs1FU0WNdTmdsIig3lqKPPDTUHP/twvi2uVC3GMELyeGMe0Wnn3VI3zm7uIwXSQQEAm4rgpaRGTdLxa9WybwAeGvTssIUx1tjOIUnHbU21Kh+gnJo76oy62PncKWH7e2UwXyysjb3c2iND50DraES4EEvCjcwVI2YcwhTChDmNf+Rleery/Qo4eGzo+BklgaPm324RaqHXclKTbzyI4ZEiy376zauGCMXIuVEE+Xc6D3HClDWNPBPCTwjMIXksC8nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HMGSRayK8NmTGCCF5A1b/fFRB9hiuHPhuyEp50i5KAY=;
 b=o5nh0fpP12lJmG9bxx1ZLTuT3kRCTsA44gap/SfoeH9Wr4lusyHuPky95fonsUxPxNLCwcDXq1+Io4WU7JLjLNgW/17/nQYdihsM1+8O0hxIC5b0bCQoh02njxUd3YP3mPxyTvRMRVFlTtCbl9Z2tr49atyGOuvBTycXQqo4Mig=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SA2PR10MB4620.namprd10.prod.outlook.com (2603:10b6:806:fb::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.12; Sat, 7 Dec
 2024 20:29:12 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%7]) with mapi id 15.20.8230.016; Sat, 7 Dec 2024
 20:29:12 +0000
Message-ID: <72c2c540-3d50-45f7-9e3a-9c18634440ff@oracle.com>
Date: Sat, 7 Dec 2024 15:29:11 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [patch] mount.nfs: Add support for nfs://-URLs ...
From: Chuck Lever <chuck.lever@oracle.com>
To: Roland Mainz <roland.mainz@nrubsig.org>
Cc: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
References: <CAKAoaQmaf7d01vK4TfR+=8k4CVN-CX3ESPFh88EaxvcOAQDWtQ@mail.gmail.com>
 <fb7bf50a-29d3-4543-90e8-617fdd205f76@oracle.com>
 <CAKAoaQ=d0RUc2CGSGDej0yYQ5QMWJTEDSXd_Ox3WXx776xzrhg@mail.gmail.com>
 <699d3e51-49b5-4bcd-8c13-5714311f8629@oracle.com>
Content-Language: en-US
In-Reply-To: <699d3e51-49b5-4bcd-8c13-5714311f8629@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR07CA0015.namprd07.prod.outlook.com
 (2603:10b6:610:20::28) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SA2PR10MB4620:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d27bac5-2f6a-4086-54c0-08dd16fdcfae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cG1Mam80L2UzcXpsNElWRFEvbFRkSGRlc2UyTDg3TmdCRHA5WVlTUVo2aW90?=
 =?utf-8?B?d1BLZG1oZWp5MGIwV3J5OUZzeU1XdDlOaGtQUjZlM1ZuOCtxazBZa2toUHlw?=
 =?utf-8?B?b0IxWWp3NmFHSDRIcUxyTWVMNmd3MFZMOGlKZTRPZEpQU0NqeVVZaVdEb3ov?=
 =?utf-8?B?akdoYXpOK3JhamJPRHFyeXB6Z2ZBazc4cHI0NTd5akFXUmNRbFcwbW8xUVZr?=
 =?utf-8?B?SkNBY1pBNWFvdjZwenk5Mmxka0lmazVYZ2F4QXVtWENzbWJkMjJoblhiMmdm?=
 =?utf-8?B?OTVpaCtpZ1FsbGZZTjFJS2l3UEx3UkpTOEpPbEhCZHFGOGNCa0xKcytiYjUz?=
 =?utf-8?B?dmR4ZEtNajRLNTdocFpQVk9IcEcxLzg2QnBGZXVtazVrdWhDeTRoVE1CRHJF?=
 =?utf-8?B?S0Zvd3JLODNua1lCNzF3V2lSYkJlY3VsWGc3aG16VWR5emlzR1g2UXBVREta?=
 =?utf-8?B?NUJtc0Z1S24xZEdUOVQvTXJiNWVzYkU3S2NFL21EVEp6Tk9hOWxNQWN5bTcz?=
 =?utf-8?B?c3BUVWZkd0JLTkFFMUhFS250anBmUFV3ZGJFUTJpZU1EWVF0M1k0ZDhhMktn?=
 =?utf-8?B?L3pTbHhlYVpRRzRmeHJNcFRYT1dKL1FYaThtL0xyTmxXTjVIZXoyQ3FUQmE4?=
 =?utf-8?B?K2JaUTNQeW84TUp5YUlnMGdqL0NkSWo3ZzQ3OEl5czlDZTk3MFVCSGtYT2hO?=
 =?utf-8?B?cDN1OEhleGpTcFFpWXdFc0NYc1J1eHoxa2drMkVNOUtteGJRUjhaRW51L1lE?=
 =?utf-8?B?S3AxNkROcEJrMy9Wc0wwdi9qTGk2a3Q1cW16VHlRQ0M4RkZpK1NhdnlPNGZ6?=
 =?utf-8?B?Qlh3TXVRcHFvQ2h0WDd3MnJoSUhMMWpLU3VNRmprTHVOamNVRFBBU0d6VUZW?=
 =?utf-8?B?aTNDQ0N1ZURRWlloQWU3Skx5U2FuNzdjMXRReXFvZ1hGNmVRWnZUblVOVVBm?=
 =?utf-8?B?Nk03enBqQk16Y1M3cVpoelJOcG1RYlpuNmU3NDNKQWpIdkpwYityUGdwQ1Qr?=
 =?utf-8?B?Tmx6SUhpcTJSQmZtcWR0dnRBWTNrbEw5UnlOaHBBM214Zk5kbytlVkZIakVv?=
 =?utf-8?B?VEFLZjkzSURSUWNZT3kzQWJKcXRNRTdKZlNkTjBZS0UyRFBCRGxxTzZNQzRB?=
 =?utf-8?B?d3RnclBuTGFyWTVSbDVJVlc2alNjWXo0MnVaZldXenQwMXc1OUF0WjdaakZX?=
 =?utf-8?B?U2t1MWlkM09zTm5vUGV6OS9BUXdGUU1HNWl3SzQ0MzZweXRZSXhpVkV4a2hJ?=
 =?utf-8?B?eWRUZkJabTF5alE4em9ZYnNXdWdEbnlsM01uMWhpQWF3QWZOemttT3ovMk1U?=
 =?utf-8?B?ZzRRRkd5aEdRMkRXYWhtOW12ODZKS2RxM1FPdmNTOVVkL1FTWkhMdXBCaVNU?=
 =?utf-8?B?QkxZOVFqY3lQajF0YXlVcjBCSGx4eDJ0bDlscXNjNGRzZHUzVjZnYnJSY0dR?=
 =?utf-8?B?bkN5QkkybjNtZzF2SFo4c3FlVUZGSG1pRlc0SUlQYU1jTWo0d2NVR1dMZE1L?=
 =?utf-8?B?VTRVZktuWmpORWlXK1pna2Q4OExJTGp5azYzRGZJZVp4QitGUENuSHpwM0ww?=
 =?utf-8?B?K3FTU3U0RjhkdFdrNU9BLzJQWXBxRENoTFNLUFFEWWVLWkhGa0VLczZOYW54?=
 =?utf-8?B?cFhtWUM3Mm9LVFRJUFdYdlhIWTJTK3JnWDJHbDV6R0FRdjhyWVhkSk04K0Va?=
 =?utf-8?B?ZHhSWk51Tlg3eE9wc1pHcGJRUnZDN3BvSzBnZzkrbldmSFJEREU1MXpNWnAz?=
 =?utf-8?B?R094TnJwNUd2aE1tR0lLVG9UQXFoZXJoREtrOFRPalllR2dSYklHdzUzMHIx?=
 =?utf-8?B?amdxVnVmNjQ2Mkw5N1pzUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S2RXUDdPOHBCNkhBR05IdzdTWEdrTzhIclJHeEdTb3JHdWlKRHN2VGI3akxt?=
 =?utf-8?B?SzZXZ2h1MFFrTlZnZWJWR1hycUZ0TkNSd05ZcFNqZGgvRTduN1hVMmM3RU54?=
 =?utf-8?B?WXYwVS9Zd0JkU3pPOGN3UzIrNmdmOGZMOE81UDdERTB6N3Zjek5tNjRCZi9u?=
 =?utf-8?B?VUpjZmFiMUtMYUQ1VE9HTGQ1SUhDbmNUM0hCWFJpdit0QXBjSzdzeTFhNnM4?=
 =?utf-8?B?eG82S3pmMHV4SUJsWGVJZGRxclJ4bTZSd1RLOXVXRjhSS08vMnp3OHZwTGcx?=
 =?utf-8?B?bkEvVHcrRXlzbHljVmpWdFlWWkQ3a21vYzJIckhSSFFGZW5MQTFMdldORTZu?=
 =?utf-8?B?RW5zRDl5dEpqTUliQnNVS3dxZlF1V1JQZGRLS0psRkR5L25tRXluQTM2ZG54?=
 =?utf-8?B?T0M2RmRwYittbSt1d1B4VERtbHNjanNUTU5TUTBlRHFIQnFiRUhyVytwbXJW?=
 =?utf-8?B?L2szT2pXUVYxbVMvMWJLaDRaSHArVkdjR2MzZnpJY0tSZ0h4VExObzFpT2k0?=
 =?utf-8?B?MWVuMFV6UXlnVDNiWUlFN1pBQ2FEMldUZGZ0dU5tT3l6MzhEcEcwVGt2Rmxm?=
 =?utf-8?B?Sks2cCtRUW5vSTBzUlgrRVVuS1pjcW5RM1dLUFExeHRjb3paUjVkN1h3WGhI?=
 =?utf-8?B?bE5id0tBRlIrTVovRlUxMXhXSGhYUHZIb0c2Q1J4U04wS3k0dzVZYzM2ekly?=
 =?utf-8?B?aXBaZTMyMlNmVitCK0JKcHZpVFNWOUhnU1dLQVhzaHBCRzZxQXhxMHErdVZm?=
 =?utf-8?B?blBwc2xLVE9OQ1hnMkNlWUp5ZzJMMEQ1RXBseUMyM3NraFJRdUVBejJpMzEv?=
 =?utf-8?B?RFdqMzlCQ0dZMllyb2R0d3EzK0dRUUM5UmlQa0F0cHlvVmtjUW41enRka21I?=
 =?utf-8?B?QmhzWWpxYk9hOFZyV0FxR1Z3SlFERWhYQWw1ZjgrY3JpSDE0OFc4YmFWbVQ1?=
 =?utf-8?B?bjBSYUVCWHNPQkxLSU9qNUZYNklyeTNqVTFxWDBSN1hrZVRNdnJUT2g0L21X?=
 =?utf-8?B?U2lUOXV5U1h3SXNCRzJ5aVZ6OFEvNm8wMFZONGxJMFUwUDVmckxVeWczR3BM?=
 =?utf-8?B?VUtvMzNNQzM1c25rTEltdTU3aC9tNk9nc1RLOTlSUXFqYTlHSnJZTG1mbWpL?=
 =?utf-8?B?SFBkdVkzazFiTSszeXpBc3FQcjV4NHlYYzlVQjgwb1NlYmpyNFN5UkNTVmhq?=
 =?utf-8?B?K2pKcFc1cTFtZk1pcHREbXE5ZDZoa2gxdE1EYzdCU0llUDBSZ3dSc1g1WTFM?=
 =?utf-8?B?NlhXZ1hJOTZxRGo5UmVNNnZMbENPeW13d1B2WHE1TGwyMUNPTHA0TnlQRk9B?=
 =?utf-8?B?SEUySmJWbmpxdVVsdjhXUnZ1OXlCcGZRMDRCbnhtWlcxTXFteTI0bENvZkpq?=
 =?utf-8?B?YVBXcjhuNHgySElkS2xwUlJFRDJKUnRDOTh1cUNUemtockhZSEd6T29EcHJs?=
 =?utf-8?B?NUZTTkdWNGJwZ1FYOGlwakd0TFc3SFFvdllNSU0zNTJXb3BYSDAvd3RwRGo2?=
 =?utf-8?B?T0lqMEIvYXYwbm1MeHgxc1NoajQ1NzBlQjNMQ2NsQ2ZrazdpZTJhS2ZydXVX?=
 =?utf-8?B?SXdyZ2JIQW9CV0lSY3oycndSeGUzWHRENnphOWJmemNRajZyZGh3RTh0QUE5?=
 =?utf-8?B?bHptZTl1UjNnN3RsM3djbWV6RjdOQWFzUlBLZ3d0VEh5YUN0cTlpL1hYbFVs?=
 =?utf-8?B?aFR6T3JOcyt4RWREZDhaT3FmRFNZK1NBbzFZSGhmaFl0eitQNEZOWVpxY3dG?=
 =?utf-8?B?aEtmeTAyN2V5MjRkb0xTeWVFMjY0K2s0b0Q5S0JHT1hBZFE1N3J2UnNGL1dW?=
 =?utf-8?B?dG1teHNrRmt0R3N3ODhtRUQrQ3F5c0V6WFh0dmE1SHhJS213MWhIbkF3SExB?=
 =?utf-8?B?c25pL1M0T1JuLzFVRXNObHhmNFdvTDFkbm55djRlbmxxTXZISVhESHU0a0NL?=
 =?utf-8?B?U0ExbmgzL1lkdEtjU0I4ZlFJRjFDY0dsRmJaaWhlb3ZFNlJ5ZU8zTlRmTytR?=
 =?utf-8?B?ZUlib0tKVzM4REE1L0loNnc2a3k1N1k5cW9BaHRLSHh1d0c5Q3ZQNjhHaHZD?=
 =?utf-8?B?QXMrMWpUcVk2WmJJWVcveXE2M2ZYWXBob2FCMS9CMHlHcG9FdVpHMmJsMDFD?=
 =?utf-8?Q?/TUEwD74L9k+dzmuornAPU637?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	GUXKxmSZZNHLdRyofsCOQUvirVhzAwQpZlQu/R36lLpIQZzGiSq09XZn1toOukxlApYf1Ia81FSU3UG0k2Yxxkv1TRFOaJ9jhoH/lg7pou22tNT57A/z+CIx9eAojtD1fo2PgCm/p5JYzmPjg4/yStorYVFPVu+jYc+/BTdUTyIN8LYQi1CU65FPKyNUng8GAFcZn/nwZ5b+2o90ZrGUa+vWSfPgkO4doXQXde1Pn8tgcAjf90sd3+7JugbR5dWanx0iK1ZKUMdSwvVVcae61BIdr6m1etJoI9LE8tjRji/4tIFpRshGnRXw1s+BBvJWs9aOonulNPw0DAq7Y6X+ka5ROGV/Dsl+5y+DdIsDwdA4wSGV8CB4inRgVhHtk3uXtcqR3xymP0u9XS0n7LaKcwZUw0beDNefHoIMgbK6Mx08Hahy0SrY1MdtDiWAmWMiAjIhzCo9LtRtJaOHKnn9X7wNMrMbewvPeoToaegeLdgaj6sNrnnsO38FMLsPaf0wIfyhkMkopdVIUQdjmIFHz6s31psQLt+iLltcqMXeM+WjxcW2jJ+SrrjJ6lSZsj9jj1YePdi/Y6zE6wAFEBd9DdiDt0DBJ3taUD3VukKriA8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d27bac5-2f6a-4086-54c0-08dd16fdcfae
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2024 20:29:12.4806
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RBAHoPwCUPXX+wto3+owEHEE8XCTc18ojL0vxAT0yBFJ5jzb/iTapFsjnu/8SmOjnecubLj6qVyBtUNWrtP7TQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4620
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-07_02,2024-12-06_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 adultscore=0
 malwarescore=0 mlxlogscore=999 bulkscore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412070173
X-Proofpoint-ORIG-GUID: M402mLRY2kfNtWpXquzY9XEwpgjJb6dK
X-Proofpoint-GUID: M402mLRY2kfNtWpXquzY9XEwpgjJb6dK

On 12/7/24 10:20 AM, Chuck Lever wrote:
> On 12/6/24 6:33 PM, Roland Mainz wrote:
>> On Fri, Dec 6, 2024 at 4:54 PM Chuck Lever <chuck.lever@oracle.com> 
>> wrote:

>>>> - This feature will not be provided for NFSv3
>>>
>>> Why shouldn't mount.nfs also support using an NFS URL to mount an
>>> NFSv3-only server? Isn't this simply a matter of letting mount.nfs
>>> negotiate down to NFSv3 if needed?
>>
>> Two issues:
>> 1. I consider NFSv2/NFSv3/NFSv4.0 as obsolete
> 
> NFSv2 is obsolete, yes.
> 
> The NFSv3 standard is not being updated, but NFSv3 is broadly
> deployed and implementations are actively maintained. It's not
> obsolete.
> 
> NFSv4.0 is on its way out, but is not obsolete yet. I don't
> think it would be challenging to include support here.

(Indeed, I presumed that /excluding/ minor version 0 would require
some extra work. But maybe that's not true).


>> 2. It would be much more complex because we need to think about how to
>> encode rpcbind&transport parameters, e.g. in cases of issues like
>> custom rpcbind+mountd ports, and/or UDP.
> 
> This is much more than is needed, IMO. NFSv3 can stick with the
> standard rpcbind port, an rpcbind query for MNT. My reading of
> the RFCs suggests that for NFSv3, the transport protocol is
> selected based on what both sides support.
> 
> I think we want to avoid trying to build every bell and whistle
> into the mount.nfs NFS URL implementation. Just cover the basics,
> at least in the initial implementation.
> 
> 
>> That will quickly escalate
>> and require lots of debates. We had that debate already in ~~2006 when
>> I was at SUN Microsystems, and there was never a consensus on how to
>> do nfs://-URLs for NFSv3 outside WebNFS.
>>
>> I think it can be done, IMHO but this is way outside of the scope of
>> this patch, which is mainly intended to fix some *URGENT* issues like
>> paths with non-ASCII characters for the CJKV people and implement
>> "hostport" notation (e.g. keep hostname+port in one string together).

I don't understand your comment about scope.

The scope of this patch, I thought, was to implement RFC 2224-compliant
NFS URLs for the mount.nfs command line. NFSv3 is specified right there
in that RFC. It seems to me that NFSv3 is indeed within scope, and
NFSv4 is in fact not (if you want to be pedantic about it).

And I don't see why handling NFSv3 should be difficult: The URL parser
should simply translate the URL into equivalent command line options
and pass those to the stropt code. That will handle NFS version and
transport negotiation automatically, yes?

Administrators will expect to be able to control the version negotiation
behavior via settings in /etc/nfs.conf. If NFS URLs bypass mount.nfs's
version negotiation (and therefore do not comply with the settings in
/etc/nfs.conf), I think that is not correct and will be disappointing
to administrators.


-- 
Chuck Lever

