Return-Path: <linux-nfs+bounces-4824-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B25692EC00
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Jul 2024 17:52:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4AB5286D3C
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Jul 2024 15:52:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5472F16C857;
	Thu, 11 Jul 2024 15:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="o1v1zObZ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Scx9Jcwr"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CB8F16C856
	for <linux-nfs@vger.kernel.org>; Thu, 11 Jul 2024 15:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720713134; cv=fail; b=nswudAEX0xld6Q+NDdkyZgC4CJDkUsGta5iBs6RtlEJhwIUPuqnoaRINMAU+mClyurOUgb5GCwd89WyVrwZDWk1bKp7Kel4hx8LAE10Z3RPDAZDanBPK5ZrZiEq5frXG/AA2xVwnJDzOG8d3E+XW114PkvfNxTsOsjlX1XT0ZJA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720713134; c=relaxed/simple;
	bh=SeFDHPI8Y/6XoHfM1G+VHXkPi22ZwL7D+t6nUgAg5Q0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GiUR7Rnj1TOVi4APkWGDKI0j2Fe5sXiklTrnTcNGyzjosO2qlxhX8HLjCEIUYH1+6Zii458BUZHPbTqeVtnCByjx92HOG4g8Wn0p9qIc1lzbFzzdXz74YJfXdAj4FxFm6VKmVbwcd/kyW2lA8w6YT+74tRWPni+bOew7ZFa4irI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=o1v1zObZ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Scx9Jcwr; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46BFBYbr014924;
	Thu, 11 Jul 2024 15:52:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=corp-2023-11-20; bh=SeFDHPI8Y/6XoHfM1G+VHXkPi22ZwL7D+t6nUgAg5
	Q0=; b=o1v1zObZbGacl6B6vTKsXUNYhPdHkJDADBA/QG6XRyEf1CD9MplX++1L7
	ss3RFVey64jGfBPeiNa9UW0gEJIXgzyS+uVSHOYyKM4LM/fGqXxIpeZC+P7RMQHY
	Ch9adQ6+AwEMUMoMjp7IADhA5OcWOPpWlKZCkTte3WNFKfOI5GqqbFXsRpc+Wy+j
	ocXAjLzOF0ycD10uhBIuSKDwPkQ+XFISYkGa55wNuAkIVF/s27NY9CNc/Mg1us5v
	eTBxg54Sd7nxNldT0ZETcp8UXwoKyhDqQk/hHcFBLIr4P6mrEHm/LlxKabd0Ka6E
	APsCDCgJYjGKxh7t1jx7oPyBVsXOw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 407emt1985-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Jul 2024 15:52:06 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46BER91F029942;
	Thu, 11 Jul 2024 15:52:05 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2041.outbound.protection.outlook.com [104.47.56.41])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 409vvbf0f3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Jul 2024 15:52:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZSwGzyqjvihRXlJ9TLt96+chCwelnk0AfINmzBgf0CMOMpEhhjRr6R0sSIrjJPErbjprFWbqUJy8P/cAAWPoAc9eGDyOXlZ/NfxBHCd1DG8ALjEIOB3fJ3pf5yhIpx/1TwJ1SCAOyUdKh5ekO6mpnPst6jK9R6oVUZSIeJthlbeao3faii47M0WEfA0+T+1XSecl9uy5ra/z+rJdwN5wtZ511rEt6iRW4A9EpCIUHHSKhJ5Gfsjz6Wu3TMA1TGMXJC12Q0YvtcD21KvSERlQdj3iHqr/Rx3VHc6VldsRvZk1YJLXr0ysjw0AypC8UHRTDycSv3lq81QsP54l4eJf2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SeFDHPI8Y/6XoHfM1G+VHXkPi22ZwL7D+t6nUgAg5Q0=;
 b=SucyThrypJQo32VZtCBDwBvqU+e1Wif6M7n67CNyAZdYnS31al8qxXVdr8u4eUhJyf9vVs4KA27vmGG/PmFAOtZSslT0jShs0rwf4T9Vuy8+xDrgrKMsYaj7ZCbmjkvVgAAeXnGcrtfeTnMLecGbJ66czAcYMOk0mys1GJasHSn/VZqjt+kX/tEQgM6nAJydLzWTtKvBxzrixVfGEfm03+qrpY5fZDc56k7dgok1kpJohxtpVXL5tc527rWwlUsATvAeNMlIbLrlFIou2gIQkVckTria5OQzkKE5CogU1hCMvfV+PfHozacMUNroLHEks05Fx4StOYbjEygWdIx3KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SeFDHPI8Y/6XoHfM1G+VHXkPi22ZwL7D+t6nUgAg5Q0=;
 b=Scx9JcwrmeIXj9q4hZ6cVokULgn1g61wdO5zv+Avh7LZh/77cUZC60I4Ow5j8IKCYmjs3vFvqYhFI6SmTyoHBYbyPY4xW5HG9/PDLyOaQyC1c/1n22IgXbkajT1AvodhYMx+h6s6FBmQFPYaTvmUg3+qV0D+2FHhKZ+SXvAapkY=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SJ0PR10MB5646.namprd10.prod.outlook.com (2603:10b6:a03:3d0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.23; Thu, 11 Jul
 2024 15:52:03 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.7762.020; Thu, 11 Jul 2024
 15:52:02 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Benjamin Coddington <bcodding@redhat.com>
CC: Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker
	<anna@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] SUNRPC: Fixup gss_status tracepoint error output
Thread-Topic: [PATCH] SUNRPC: Fixup gss_status tracepoint error output
Thread-Index: AQHa06Zlmua5rY536UGCdGYX4HOZRLHxpqaAgAAFuQCAAADSAA==
Date: Thu, 11 Jul 2024 15:52:02 +0000
Message-ID: <2799ECE7-E3D9-45E6-9B47-47934B38A284@oracle.com>
References: 
 <27526e921037d6217bdfc6a078c53d37ae9effab.1720711381.git.bcodding@redhat.com>
 <Zo/6G7ANcWEWkd0l@tissot.1015granger.net>
 <C3887ED2-B331-4AC9-A73B-326D7DDAC5FD@redhat.com>
In-Reply-To: <C3887ED2-B331-4AC9-A73B-326D7DDAC5FD@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.600.62)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|SJ0PR10MB5646:EE_
x-ms-office365-filtering-correlation-id: 48a6bbbf-5996-487a-ceca-08dca1c1683a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: 
 =?utf-8?B?b1FFWGY3KytNMXpjSVJnSnVoZmszL0xqQkNpcmswSHl5dFFaNHZQMEdvM3lR?=
 =?utf-8?B?N2tZcTZmQ3M5d0hsMDd1UzErVU9ubFB2WmtzWjkrT05QTnR5ZXkvK0I0Mmxr?=
 =?utf-8?B?WW0zb0NYeWZEUUd4aVhGNGNHMno5cWFSaUdUYlhSN3FUQ0c2V1RoTkt5VWJh?=
 =?utf-8?B?ZWpTVUJCbHhzbTBLbXdKeG5SUy9tUE15NVlOSUQ3b0Y3THZuMU1pOU8xdW50?=
 =?utf-8?B?bGQ1MzNQVzRZQVhVMG1GWFJxZEFYVEloUm4wckNMcWRUVmsxdkJXaFdVS0hG?=
 =?utf-8?B?dmczNmM5bHNDM2k3elRyUXJJcVhxTWlxM1M0YWwyZ2VqcG5hNUxTQVBBaTRw?=
 =?utf-8?B?RjZETFVkRW5SYXlPS0R3SzlTcHYxQmVJaEplQzBBVjAzMlZzVW16RUdEZDZj?=
 =?utf-8?B?YUF2Q0FQd1JWRmV3QzhPdzMzQzl4L1M1YkUwbENzYzgwQldwUTRRaWJoREhi?=
 =?utf-8?B?T3l6NlpQaUFOcFR5SjJyb1Bqc3J6eWRXZTdPaFVDYjZmQUdxTU9aQXd3RWJR?=
 =?utf-8?B?K0lxR3Mwd2pNeGJWVk1Gb0syTUw1OW4wOURMTXlyTVNwRE1GTFpJM3Aybi9n?=
 =?utf-8?B?SWwyaDlkTzl4K0YzMFFaQlJhYmFwdUNOT3ZzT3RHZnNHRVBuTytPM0JxSUJE?=
 =?utf-8?B?ek01UTdBTUNpaDkrY0ZZUWE3ejExOGxvLzFJZFFlNE5jSFVqaEl5TG11N0NQ?=
 =?utf-8?B?ejN2MGVUeTQwdlh5SUwrV1VDK1FvbjhtSlNDczlYNTJ3bS9tWDhPSDh4clBI?=
 =?utf-8?B?WXNHa21RZXlraURXYWVPdXFRSzEzUUQ5bXpLVTA1N2hyOG9NN3FZUk5FcWZQ?=
 =?utf-8?B?blROWjdLVWJMSzRyN2ozM1Zwb1JVODBXZEpXVGowT1c1Qm0wUnVBSWYxbXFy?=
 =?utf-8?B?NXNVNGpWNWo2aXc0ZnViVFNIK0FQMTMxODhSVXl4OFZ2MlFYN2xCaEJVbWNs?=
 =?utf-8?B?MkVReUZSUWFNUFZLdy9wZHc3ODNtRUIxbkpIUm9XTFZteVZQTlp3d3pYNVM5?=
 =?utf-8?B?VitPNWJzUVFLdDUrOS9CR0g0U3h5QVE5UWMzNnRwUTUyZzNEOVVEbmlwRkQw?=
 =?utf-8?B?OEE2SkdmWmNYdjdCMGU0S2xQc1hsZ3cvTksxNkdYUnJHNFlXcHNZdWhnOGhQ?=
 =?utf-8?B?USt5cEtzM3ErUWFqZW1LNHlKL0hPdmF1VTh2Rkkyd2plam5rSWxzeVcrZ1Bl?=
 =?utf-8?B?ckxCWGpnRUpydW9aM3I0MUNqMVpwY3hTYkp2TWlIK2ZHRklMdTdBK2g1K0Nj?=
 =?utf-8?B?VERKbnJ0ZUF4dVFEWTl0QzBIbnN1Y0ErN25iQzNGMzdKT2lwT2JpaGk5eGQ2?=
 =?utf-8?B?YmEwUUplcUYvRUZ4OWdpZzBQRUpvY0NyMDI5QWdGM2xwY0U1Z25odEFRZXVJ?=
 =?utf-8?B?aWd1OHhpWGd6MjZHWHhiS0VDRmwySXZmKy9BclR6U0VsbFl4YzZGOUlIbXpG?=
 =?utf-8?B?RDY1TDNsQXIwdnZyL1E3YktUYWJtV1JiVDFsMFppYXVOMGxFdmVhaVkrUkdx?=
 =?utf-8?B?THdxNUU0d1FOQUtXRjNDeWFRVi8xWWVIVjFxSWcyTjZSUmtTQ1oyYmxFU0k3?=
 =?utf-8?B?ZVY4eWNJeXM5Tm1UM1RXb0FrdFFuaS9OaTV3VUtZbnI0WUJhVVF6emlnUmlS?=
 =?utf-8?B?VTNKRlRsN3ZHbFJ3SFJDcWRGT3d2VFp5R1drTm92L3lJdVFHcWpEKzcxamd5?=
 =?utf-8?B?a2l4TnI1REp5aUl3QktZMjh5WHBic1dOMWZBMW12ZHYwazJFV1ppR1p1QWkx?=
 =?utf-8?B?T0ZvM3dpeDkwOUVrak45a1RIYkxPUnF2NEhWNWdrZEFWZ0FYb2VtSW5Iem1G?=
 =?utf-8?B?cTgwYlEvTlBTOTRBSHFzb3R5Q1F2WjFFNUd5RXhzczJGUlFnTUZIa2xNbnNs?=
 =?utf-8?B?VVN3Q0syZnJ0UVk4dnliUFM1V1VmV0g3MVV1SlFhL24xc3c9PQ==?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?Mk14T0VEUUpkbzFBK0M3Y3grUzVWOXR1c1YvT29TWkpwcXFwNUloSUppV0ZQ?=
 =?utf-8?B?c0hxUWNRejllbDNJRUdXVDhqM2srWnpWUXo0aTg1OUJKUFdLVmVaY0FkMVh6?=
 =?utf-8?B?YksyV2tHSVVLMlg0enE2cUJnZ3piQkFTVTRQdUxEUnJhWkVPc1F5VGRRV016?=
 =?utf-8?B?c0MwT2Y5ZXlFR2hWcDlScmluV3RRamxPbE9INlZ4SDkxSlRLNWVueXdXSjVT?=
 =?utf-8?B?R1JGcjdNSklSUVIwVkdxdkROcmkyaFlXOU5FcWtwY0YrZDJkQ2FLWjBXR2xw?=
 =?utf-8?B?Y0pBR2I3NlFnSGZFRStEZlpKYXVMYmMyT0JUazFFaVk4YktXSUl4c25LQ3c5?=
 =?utf-8?B?MlpHbEZhMDdLRmFObGxUZkFSVlJuN3k3b3J3RmdtMEVSS1YvNTFIVlErdWR5?=
 =?utf-8?B?MkVPSFFsK3E3N3hJRnBsa3laTUg0eHlPY3R4b0Nmc0p3ZXR6VFNpRm8vTFZK?=
 =?utf-8?B?bEN3UlZTdG52cVRBbmV4OG5DekV0OVNxSDlHQU1GK3JjeGtITmdiTU5ISnFF?=
 =?utf-8?B?S2hPZ3JEVTNIdW53R01mdDdyZ1EyQXNhZ0JVYVVYbTcyd2RHMkd3akgvWE9w?=
 =?utf-8?B?TFBmWVZDQWFhS1ZEKzdhT1RZaXlMdi9KcjlVT0lBL2tFdzRmb0dVOG5YUXhB?=
 =?utf-8?B?RzMzRFpZSWplWEhwTHd0T0k0K2Zqb1l0RzNrd3VQSFhEVWZ4WG9jYUVFdHhD?=
 =?utf-8?B?NTRGVkJndE9rdWw5TTNNZHptMitLQ3lhS0ZHTFdmYXFacGVMNnl4ZlRHOXBS?=
 =?utf-8?B?NjNCL3RYaUpOcFpUajBGbjNRYlJMbUV5UlRGZmQ1c1A1ejdTSEd0cXNRcnJy?=
 =?utf-8?B?N055N3R3LyswL3BvWm00NEJiTjNWUEJ4dDhKeTc0QVdLNHd1M0xxeEpqd05h?=
 =?utf-8?B?N2xUSkRVRGlzZEE2VjhSbVUrd09Ba203RWZ2TU0zWm5CNlpZWHZqYnJ4d3VJ?=
 =?utf-8?B?WVIyWUhBdjBNRzNKRjJvcTNHdFhIekJKSkpxTE5DRXBJSlRHajlKeXZyaVRH?=
 =?utf-8?B?c1RCOUdEY1FZeVFDeG5NQ2s5aXhvWXVyL0o2U2ozaHVKT0hpVXpLSjZhc1pR?=
 =?utf-8?B?T1ROdDAzekZnYlN1ZWhxR29IUHF5a0o5MmhLSFNSeXNXWkY0WWFzTFZveHhF?=
 =?utf-8?B?RmtKK200Rjgza0RCMkZoMWxPZEgwTkprdGgwMnozc25uZFgxamdxbklCMEhr?=
 =?utf-8?B?YzhSZElpTm1VclF6cHRoNUI0eHlyajVISXkwVys3NUptUGtaeXhQTjQyK3ZC?=
 =?utf-8?B?SzNsTm1nbnJDcVhvbkZtWUh1TFUrOTBBd09pcnVKcnN4a0ZXc3V0dS9oR1N2?=
 =?utf-8?B?ZFZySVBaSm42dTdrdC9iSVNBMmh3VDNZMlQxZjkyUFVpZmFmSExGYjkwdGIv?=
 =?utf-8?B?MG94RzRiaE5STWpYd1pPdVQxT1l5bDZxampFRWV0OXNwTmdCbTlQZnZBZ1Jo?=
 =?utf-8?B?Q1R2SDhkOWVwSGFxTTVOa3gxbkdJeEh2QTl1cGcyQVVudDJ0MmphRE5RK243?=
 =?utf-8?B?SXFJMTdQcE5MajVjeDdTNXlwSE1HZXd2bE95aHhINFRNZTlwamFMeWRPM3lk?=
 =?utf-8?B?RlFvNXQ0REVEN1pBK2V1QmZ5Smk5dXJ6cDUybDV5WldLcXo1NGJEWVBGMUI2?=
 =?utf-8?B?ZXhTSFVvVU0xaERjajF2VUprZEF5WlB3TjVqZVNtYzFIOGJTNG1hbXFMNG4r?=
 =?utf-8?B?V2VrUlVzOEtlb3BNVVJ2cGZ3SXJWMVlMZWM5cnVLa3JJMmROYkN6aFRIQm1t?=
 =?utf-8?B?M3FwRENiWmw4Y2lnNWVHSmljMTRWS0dkNlBCc2JZNGlJWFpBcnA3RVZKYjc3?=
 =?utf-8?B?YmdQVVNPVXpGQXNwa1RuMHBWRlVGdHY5ZEthSE1Mdnc3S1dVblhYTmdmMzVB?=
 =?utf-8?B?U0dNMWlXSEdHOXdCRFBoZXYxSE1RejdINmtIQXA3d3ZBdkFnK2RISXovZVNk?=
 =?utf-8?B?SEozVUUvakUvQ2xCNUNybW50UlNnUE5SUUJTL2VUb2t5dzVBT3RiWkNiZ0lv?=
 =?utf-8?B?Zkp6d1ZkYUUyYVd4d2VHSGxhUHoxa0daVWdEQ3ZGVmxabXVucHhXSktOSTlM?=
 =?utf-8?B?QnBrNzZpdUNCVDRjMUtKUmU3UXlid3dYcUZMSE5xN2dYTGdBY0lYL0hDcVhi?=
 =?utf-8?B?S2lwTnN0VFNrcnc5UmMybVdGS25KdlNJTkJvYmhqTnJOVG1lekRyZEovNGVH?=
 =?utf-8?B?UXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8F266E9849A95546B2C3EB99EE157203@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	+uC/25pghU/EC4trw3tw3QfxGQ/8CO2dmg3/ti7uongWXjcEkIPmFTf2Mgg9VgE9ZaA9SLUZ01WC9UTu5dZa3hTjHF2Rz76LPcDLxm8OT7Jko+3dirmrqaM27K7Ib7Z2jHDgDRBcCyx07SSLLP6RHFlgdFtyZhLsWt+kavPnYZatqumj8KxpUzQw1oKADsylGeiOde5vsfcVuYlQM461wB5pDL8VBOBb9/nbwyylSHsyAZOyrREHMpRrzAiGGR4Tf3zikXGDYS01kw/fnIuDKHSSdsGvDqoc8WxJ1as/axyJCLF04Vyh8UQsafRP92QV5DrKVhqDHvx1z0Dx1Xe7ZZXArNpCe1AcRrNDMEVQB+qpg8obUL0R0VsCbnnthqO1XuZRj3gxQIIse+0T8P/yxZdQXtBlFOIG644iLq+fEXEqgt9mDO362d6pwvwqUe+zx8GSLwI52+3qjj1OB5KpjfbJJjlGJKPgzxPeBu7xLZ7t3rGc/GrvES4AEqjfQj7KjFcwowlXbeqN1WuAK1DwlUgPfH1NoQStuGOENKlMhOrTYzoPzhDqiRmdeYPPWt0+XwiV5QAHVDM+RJx+48xPJIs3a/29A0Ytp0QJL79RmN0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48a6bbbf-5996-487a-ceca-08dca1c1683a
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2024 15:52:02.8882
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: whdjRChQZXnCrhW/8Kme2lNPvVbWX862rJgTP2a4UXVd3JAJkZ+cLAvhUqwm57SFf2Utg5dF42gQkCPIIlLgJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5646
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-11_11,2024-07-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 spamscore=0 phishscore=0 adultscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2407110111
X-Proofpoint-GUID: IlzviXXRYF6z2bFRF6Gb2MX4Y8u7qAog
X-Proofpoint-ORIG-GUID: IlzviXXRYF6z2bFRF6Gb2MX4Y8u7qAog

DQoNCj4gT24gSnVsIDExLCAyMDI0LCBhdCAxMTo0OOKAr0FNLCBCZW5qYW1pbiBDb2RkaW5ndG9u
IDxiY29kZGluZ0ByZWRoYXQuY29tPiB3cm90ZToNCj4gDQo+IE9uIDExIEp1bCAyMDI0LCBhdCAx
MToyOCwgQ2h1Y2sgTGV2ZXIgd3JvdGU6DQo+IA0KPj4gT24gVGh1LCBKdWwgMTEsIDIwMjQgYXQg
MTE6MjQ6MDFBTSAtMDQwMCwgQmVuamFtaW4gQ29kZGluZ3RvbiB3cm90ZToNCj4+PiBUaGUgR1NT
IHJvdXRpbmUgZXJyb3JzIGFyZSB2YWx1ZXMsIG5vdCBmbGFncy4NCj4+IA0KPj4gTXkgcmVhZGlu
ZyBvZiBrZXJuZWwgYW5kIHVzZXIgc3BhY2UgR1NTIGNvZGUgaXMgdGhhdCB0aGVzZSBhcmUNCj4+
IGluZGVlZCBmbGFncyBhbmQgY2FuIGJlIGNvbWJpbmVkLiBUaGUgZGVmaW5pdGlvbnMgYXJlIGZv
dW5kIGluDQo+PiBpbmNsdWRlL2xpbnV4L3N1bnJwYy9nc3NfZXJyLmg6DQo+PiANCj4+IFRvIHdp
dDoNCj4+IA0KPj4gMTE2IC8qDQo+PiAxMTcgICogUm91dGluZSBlcnJvcnM6DQo+PiAxMTggICov
DQo+PiAxMTkgI2RlZmluZSBHU1NfU19CQURfTUVDSCAoKChPTV91aW50MzIpIDF1bCkgPDwgR1NT
X0NfUk9VVElORV9FUlJPUl9PRkZTRVQpDQo+PiAxMjAgI2RlZmluZSBHU1NfU19CQURfTkFNRSAo
KChPTV91aW50MzIpIDJ1bCkgPDwgR1NTX0NfUk9VVElORV9FUlJPUl9PRkZTRVQpDQo+IA0KPiBJ
IHJlYWQgdGhpcyBhcyBqdXN0IHZhbHVlcyBzaGlmdGVkIGxlZnQgYnkgYSBjb25zdGFudC4NCj4g
DQo+IE5vIHdoZXJlIGluLWtlcm5lbCBhcmUgdGhleSBiaXR3aXNlIGNvbWJpbmVkLg0KDQpUaGUg
a2VybmVsIGdldHMgR1NTIHN0YXR1cyB2YWx1ZXMgZnJvbSB1c2VyIHNwYWNlIGNvZGUgdG9vLg0K
DQoNCj4gSSBub3RpY2VkIHRoaXMgcHJvYmxlbSBpbiBwcmFjdGljZQ0KPiB3aGlsZSByZWFkaW5n
IHRoZSB0cmFjZXBvaW50IG91dHB1dCBmcm9tIGNvcnJ1cHRlZCBHU1MgaGFzaCByb3V0aW5lcy4N
Cg0KQ2FuIHlvdSBkZXNjcmliZSB0aGUgcHJvYmxlbT8NCg0KDQotLQ0KQ2h1Y2sgTGV2ZXINCg0K
DQo=

