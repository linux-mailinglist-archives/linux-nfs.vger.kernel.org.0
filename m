Return-Path: <linux-nfs+bounces-3536-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B47558D87A4
	for <lists+linux-nfs@lfdr.de>; Mon,  3 Jun 2024 19:07:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D23901C21FCA
	for <lists+linux-nfs@lfdr.de>; Mon,  3 Jun 2024 17:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79F46137776;
	Mon,  3 Jun 2024 17:07:00 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EE571369A0;
	Mon,  3 Jun 2024 17:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717434420; cv=fail; b=fgtaKcum6LLxZdQ4i9JRO8A5VbvU7NQTf1X9TRCeMQntUTKnPO0Dx/5Nt+rin2/PnQCjIj44Ma2HIMbMvG1p4wBhjOii8zqYRbsUJnZqSajz2QqpuNPhDeLiuEulWv0Ww8f83zUAYSThaf/I1bYCXVpTJLa3KaVG0hqF9lLO6Hs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717434420; c=relaxed/simple;
	bh=fZeXG5JUBnwPCg6YvKuhZ+InFVJCHEY1IjGGG77IsMU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VuSzEF3Z8RrkEDGydHsERcSo8ZGGPLUGfT2f4ef/sUVNVyyFvHqAR860X6ph9eIIOsDBBfDFWMBrnPolkwu3e4UYU5agpSrWsCr5X95aUESze5+5e/Driyw7hHBPVJ+Qq03cb0M4/t/j61knugrUH/2IDh3cwH5fpbe8QcUqu2E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 453CRvXO024401;
	Mon, 3 Jun 2024 17:06:55 GMT
DKIM-Signature: =?UTF-8?Q?v=3D1;_a=3Drsa-sha256;_c=3Drelaxed/relaxed;_d=3Doracle.com;_h?=
 =?UTF-8?Q?=3Dcc:content-id:content-transfer-encoding:content-type:date:fr?=
 =?UTF-8?Q?om:in-reply-to:message-id:mime-version:references:subject:to;_s?=
 =?UTF-8?Q?=3Dcorp-2023-11-20;_bh=3DfZeXG5JUBnwPCg6YvKuhZ+InFVJCHEY1IjGGG7?=
 =?UTF-8?Q?7IsMU=3D;_b=3DnDe68+S+04F0LbT/Ztw3WfygWvLd9aY98vD7pAzAw2Ny5Puyk?=
 =?UTF-8?Q?Vnl/x3ZFdknSyTWsGfV_si4X+UgGCM3mKUN+aAQ+ZmD6IzZDB55IO8b4xXJWqpl?=
 =?UTF-8?Q?jgbf7Y6qP+o+HdnhOH02R0hL5_LKdcvQcMsPEtdPsxMBgrSh0NPIBQViNFymVfv?=
 =?UTF-8?Q?ArF8q3fQgSMCgEw1wUfz85bwNf5vhVl_rVIHOEHcZH1bKhUvpsIQzCIS4XDhzT4?=
 =?UTF-8?Q?mD5RRXjU1IQEgoKyrT1afnxz+MTAzLB1oQ4iJ_A8lr9wJTl8oFQYjdNcAcLBwAN?=
 =?UTF-8?Q?wCu+AyU/d7oTLfnLRu95R42ehfqKHHSFGgUHyfxckOi_PA=3D=3D_?=
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yfuyu39qt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 03 Jun 2024 17:06:55 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 453GjIGK020540;
	Mon, 3 Jun 2024 17:06:54 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ygrj0t6h3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 03 Jun 2024 17:06:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ms9tKjWdZaaDLBPsI5paxsXx7zQtzYlx+YxSg2t83pl/b0qd+9AVk72QuSXYwlmyksB1f4QWm3xRcyfbxk4bC5D47u9e8ZFZgJwe2S7OWRYCa07urbdMuh2QXbXXubRf10YQUXFr89jBHo8UvKkWDOZzqKzQLsClLVkKsNeSMz7SHJgWms9GL4Px132HTBY09MyAzgt7+AAXvyNxOnQf2W22YP6oCb9MO7kr+/KYffp81ZD6GakXMFpOV3gLT9XYZPY1q4THZEamywXB1dk7l3d9GcTKVBkfvVD+xvglabk+nFBb/lBndwkc+O8PEw9jppaCgHf/dCh5MaicGUHmZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fZeXG5JUBnwPCg6YvKuhZ+InFVJCHEY1IjGGG77IsMU=;
 b=Jz9KfkhSH3XN22KnLjKq9i0QomK06FWl5NYfS7/sTLpX0PCub1+CV4bJpP43fGO1rHCn6VYSTnExPxc72a28JTdiKtU6D7HmmVyOBT6+ebeE7nZ6xiaqdhrw5wcQFU1TDU4Qh311De5tv5OXZk1BRT8PSeYhgXoNOBAgLbQRgMAgvjOrZ+Xa5ldnu9ou23RtoMrtEqBPGYiMW4+FdZNimCz1wZrsnxTrKfpFLZuAhnLRYxBKfrBzLNlJa741keREnh/6jRdYoLZ63ZaiHZ6Du60EdX+N/Q0sk27Qmvr6S6KnTzyzAX1NXpEQMA1s0UFX8QAdphuAK88OnxVQCEqJOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fZeXG5JUBnwPCg6YvKuhZ+InFVJCHEY1IjGGG77IsMU=;
 b=KP17fmMNuVIO+U0Rj1JH9eSBICnrs3BQaorrR6Zq+vpkiNKprMQmumQUoxpIQoPGPg9MsttdU+JVQn/0YE3te1v9QSOdUkMj/ssO4DvLBs5x6CzM0ufJ95+eWinkq/eJ1oe+xZRshcpF5uv/c2MkMGwfbh2Nj4ZcYteA/TDNXXM=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by IA1PR10MB7488.namprd10.prod.outlook.com (2603:10b6:208:44f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.22; Mon, 3 Jun
 2024 17:06:51 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.7633.021; Mon, 3 Jun 2024
 17:06:51 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Zhu Yanjun <zyjzyj2000@gmail.com>
CC: Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "kdevops@lists.linux.dev" <kdevops@lists.linux.dev>
Subject: Re: [RFC PATCH 0/4] NFS: Fix another 'check_flush_dependency' splat
Thread-Topic: [RFC PATCH 0/4] NFS: Fix another 'check_flush_dependency' splat
Thread-Index: 
 AQHamkmDfBfBFsNf5kaeN/1BZO1Wh7GAavwAgABo5ICAAAR7gIAABDQAgAAI6gCAM+xcgIAAKu+AgAFsqACAAA9RgIAAA36A
Date: Mon, 3 Jun 2024 17:06:51 +0000
Message-ID: <79A07589-B4AC-44D5-A81A-4B80FFFF93C6@oracle.com>
References: <20240429152537.212958-6-cel@kernel.org>
 <efc4f895-3a45-4b44-a47d-532896526458@linux.dev>
 <90F6A893-5315-4E53-B54E-1CF8D7D4AC4D@oracle.com>
 <f49907ea-cedc-44b7-9ffc-30c265731f3e@linux.dev>
 <675A3584-6086-45D4-9B31-F7F572394144@oracle.com>
 <6d483d75-5866-4c4e-8d86-c89a2b27f5e7@linux.dev>
 <F2726F77-06F9-4DB4-B2A8-97F21B045A6F@oracle.com>
 <CAD=hENdL3v6gMpU7SBdkLjcyuEhzCvTRxt3+N+8m6ybuVKGHwA@mail.gmail.com>
 <953940CF-98DE-4727-8E32-066CC4B3E8B2@oracle.com>
 <CAD=hENdTMVXB-3w3j3WDMBjUcuE7eRWZ1itZcc8==szWCe4KbQ@mail.gmail.com>
In-Reply-To: 
 <CAD=hENdTMVXB-3w3j3WDMBjUcuE7eRWZ1itZcc8==szWCe4KbQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.600.62)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|IA1PR10MB7488:EE_
x-ms-office365-filtering-correlation-id: 077ffc3d-8c05-450f-75b9-08dc83ef9006
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|366007|1800799015|38070700009;
x-microsoft-antispam-message-info: 
 =?utf-8?B?YU9hRFVtb2svM2ZpV0d5dkJNTm1rdUJHRzQ3RkxiSzlER0oxVHJZTUVqcGd2?=
 =?utf-8?B?T3VRVGV0UXMyekN2bHZ0QnIrUUlTSmZPdVVsOG50STN6RE85eXBOR0Y5Vkgz?=
 =?utf-8?B?ODFqNGRxaXMvdng4WkEwNGI1cTYwTktZTHlaZU92Z1ljQkJUc2FSOTNuZTVN?=
 =?utf-8?B?QnpjQVNESlEwdXg4bzdXQmNKYWlyT2hsNlY2a1BKcVpnYnRwcEJySFVjK0pm?=
 =?utf-8?B?MWZXdWRGdmhHTWFFdS9wVTFkdVFVYmVjOUxVK2twUFI0cWMzdFZkZ3pmaHd6?=
 =?utf-8?B?N1drcWxiRmxBRkY3MDF1L0l3Y1ptWklHUFVsZTNwM2lkWUo3bnZybEFjVGVr?=
 =?utf-8?B?NU4vQncxS29PckQyaDBCUkkvK0NLVDB3VmxNM1F4aDZsdXhOKzFsVjhYck80?=
 =?utf-8?B?SW9ER2hQaE9mK1VYc3Rqa0VIQ3c4UGg2ZXlzRjgwck5mTWNZUThzWGtzS2dT?=
 =?utf-8?B?QUNEN2FsbE9TMTRSWjZsVm9aUGhyQ2hMVjEzWXVCNEtBUWJQY0xKTWxVTmhQ?=
 =?utf-8?B?Z29KQ2dPYjU2dU5wSVlSNTVOUHg1c011cGhwMkhXNFQvN0RLbXhWS2VXT0VO?=
 =?utf-8?B?NC9idkRlakt5clNuSnhWVUxrek8xeCtSRlJhNVJOdExjanI0eDRHMEMySkZs?=
 =?utf-8?B?dlJtQm1aUDlldEo0ditWQ05VL0NOeXdOa1pPVEtpWnRQT3dJak1MNFBaSnRH?=
 =?utf-8?B?c0h5d3lod3F6K2tBRFlha2FjbFdrWSs0dUNFdktjS3NVMU5oUEwvcHpqejdi?=
 =?utf-8?B?UTVRV3UzR3ZzRUlIWklaVWoyNUpCREUyZTd1VndlNXFpY0JIcVphRFpXajlR?=
 =?utf-8?B?aDhNb0YrSVk1SkNycUZteElwa052c1JPcTFLSktaeCtKelNqam1rdXB3bGpt?=
 =?utf-8?B?YVF6emU5UUF2c0FrY0NzdFljZzIyRXRJdEFtdTJYMEFhOE5BN2hncko3S3ND?=
 =?utf-8?B?UHVZbEI1YTA0bnR4U21nQzNLZllSSVJhV2x6Zmo3cDlIcGZ6VjF0Wlk3WnRa?=
 =?utf-8?B?WmZBZmVrTzBVZ1IwOXB5cFRzNzRHZ1dYNm9OaGtnbVFSRFFIV0xPQWNpOXhw?=
 =?utf-8?B?RjhlTTAyaHpWQVY4SkwxT2kwdTV2d1VUd0g2VDl1SmlBK0twb29lT3pkNXBj?=
 =?utf-8?B?RHBqSzFrVWQ1K3ZSVENsQ21VQzhJRUplM2Q0YS8vZFYraXV1aVBCKzhrUkpX?=
 =?utf-8?B?ZFhJRnNqNjFkT2F2WWZwVm45ZXBKYTNPb3FLZ2doNVNEY1BKOE5heVFTekla?=
 =?utf-8?B?UHdvWWtrdDVwVDEwdXhuUWw4TXpWNWRtajM3dWpPY28zcmRRV28veTh1K3Na?=
 =?utf-8?B?anpQR0RKVVhsRUNzeHh5cUovcWpQaGg3dGt5OVk0NE13V1B6S0VXOHpnTzZ3?=
 =?utf-8?B?WnRUVlNuejJGb1B2VGpDTEVLd2Rtd3RsaFNCR2VsWE9IeWQwRWZzbWF0OGIz?=
 =?utf-8?B?RkN2QkNrREQ0dDJKMDZqL0U2RExTcHBXYUprOWNDVFRSZUZ1bGF4MnprNjNI?=
 =?utf-8?B?UVA1Y2lLZkRnZ0NuRnJiK0JQOG5CcURQQkRSNUsxaWZKcTIxc2lJYTQwblVG?=
 =?utf-8?B?Z2w5bzl6SDVtWklNWittTUVqWW9tcDlTcVpzNWxKOCt0eHZsV0RzRFQycTUx?=
 =?utf-8?B?UVJmaWhlSHI2MG4xVG9OTlBOYlVXbldPWU9zdlhjQW9TWG9POXZUR3p6QU15?=
 =?utf-8?B?TjlmaXJnTXB1bFkrT25iMjRwZWJCNmsvTVA4Vlc2QWcyMG9SSCttS1dVcmln?=
 =?utf-8?B?QW5QWmJHaXhiUURzTkYvSDZIRjg1MkszUy9KeWU0T0Y3dDNWRDAxYWNuNDBJ?=
 =?utf-8?B?Zm53Vkg0STZlWFdsZC90Zz09?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?MWJXandNSFlWVUxtMkthMjgzbW44MmJPUHNFMTRNZ0Q4dkswL2lyRGpDOXha?=
 =?utf-8?B?K0hnbkdjZEdMVjFBUmJGalE3YnhFT3g1bzNVUjdaSnlld3ZoVzdpWTV1WVZ5?=
 =?utf-8?B?UGdiWXNhZGQrbzVKa2VhWXU2VG4xRlJhK2IraUd0NDhFN3V4N3dBb1pRSzFs?=
 =?utf-8?B?bUhsYUZId3JmT0I2ZXIreGd0eldsNGRMQ1pnbHkwMHg1MUFyZHdNczArLytE?=
 =?utf-8?B?NWlyS3AwYlJEV0FPeGJuYzVLekpreWpQYW9RQ1NiQ0dDTmdOUWFTU2JiQVhH?=
 =?utf-8?B?WHh3VDFHQXd6cUluRzFwcWltTGdGSFFiK1psM0NBR2tZVGVPNWF5bC9la2dB?=
 =?utf-8?B?WUR1a2FZZ2wzUmVHVENTOUkvR1MyZXdXN3ZmaXAwbmx3WG5sSzl0anlqUmhs?=
 =?utf-8?B?S3h2Umk0OUVvRjYyVmc5UC8zeUgwWXVZNTI1NFpKQy9ydkFBTVNTazBubTAy?=
 =?utf-8?B?SldPRXg0UnlFa3dhWlMzTGQ2UDIwalZXUGI3QkR1RENubHM2L05TTDdvbThN?=
 =?utf-8?B?ck0zY3lEanJzRFZ1VjNicG9kTzBwYWpDYUwzazBFWjhqZ2p4U05UdXR1YUQ5?=
 =?utf-8?B?alNZWUpGbUZGNVpBMGZtcDZmeXNFV05ISlBab09LSHV5aUh5akZCY3JLWFBt?=
 =?utf-8?B?bDQ1eVNobzhCVDhJbGlWb2xHdTd2MmNIRjYwZXlNNEdZV0w2YWhzQW1YL1Uy?=
 =?utf-8?B?QVZLM1paSEh3QlRPMS9zREJueldneTJ4Tm5meDJEL09LQ0JWbGFPVFFSSkI5?=
 =?utf-8?B?Y0p2SWdHK1dwamZ5QVVZRTZibTlzMnNNQzdrMG9XYjI4M2Z4cXE1SThCSjQr?=
 =?utf-8?B?NXpsaUtlMEJTZm9jczZ6UFBoZ3JNR0kvQ2REMm1kK29XVTlqZmZ6VlFTa0JY?=
 =?utf-8?B?QU1qQVlXaEZLRGEvcVZpVmtaWldNcDNrUWtQeW5XYm5NVjFnNU5ZREYrTjZT?=
 =?utf-8?B?d3pZa3Y3b24vdmJCK3ZhN0h2NmJwaVJzZGJNZXNEc2hvTHFDSDl4V0FibUc4?=
 =?utf-8?B?cFBXYUN6aXpEcCtCSUxTeUVpTFBPNmJtYWFGU2hOTVQ0NkQwaDU3bThISC9h?=
 =?utf-8?B?dTBPb2ZoZFFQVjcxSDVmKzJpeC9OaExLYnRtWFBFRDBwQThVOHJub2Fsa0ht?=
 =?utf-8?B?ZUJISldySzRka3VmU2I2dVA0a3I2bVdIZmh3VDhhSXNDTUFYVDNrQkFQUFpm?=
 =?utf-8?B?S0JQaHp6cnY5QUdqNUEzKytsTlVSNXlDTmlUc05PREVRVm52RWN4YUdVaENv?=
 =?utf-8?B?NW5WbkwvaG5SaG5iWWx2RHZ2U3BGRWJoOTVSSmsrZ1h3Und0TzFuZzFLMTlC?=
 =?utf-8?B?UW5ib3ZVTTRhcjJ0cmJkMHFRNlZEbktLTU12T0tCaEVlcnRwb05zRlpxN3N2?=
 =?utf-8?B?OTdreHFldnhoaUtPTFhWQnZPUkgxOHVTNkdwaUxtVUxXSm54dnhFcW5oS1B0?=
 =?utf-8?B?K0JiTzRBSHlmZnVwOGt4RThjd2NxZGpheEQwZlBvd3B5Sjg3WVZNTW1hTHpX?=
 =?utf-8?B?TExFVzA1N0tMclovS3Z4NHNzMDZ6QWdXQUpSNHV3TDdHZ29DSFJ6aGI4Yk5v?=
 =?utf-8?B?b2xNMEhPYkRBYzN2TjgyZnowUEFtSERUZFYvUit4cXEzMWNjOGo0N290dy83?=
 =?utf-8?B?WDA2cmtwY3V6bEVlVmVaYTF5d3BIaCtKWFlRNWZKcTRxRmJRU0gyMlpCd0Rv?=
 =?utf-8?B?L3dDL1dRdm9FOEhFbWE0aERESTl4STlxVFFLTk5GNWpkS2doZUJwMmZQd1R4?=
 =?utf-8?B?MUh5Q0R1Sk93bmVsU1ptcFFlU3d6M1FhVDNiSThQdElTU2ppcTUwdUlaOHpE?=
 =?utf-8?B?WG13RCs3RlNnT09yZGZxS0I3SWxYUSt6eSttbEc1di9mbkZQUWpwVTlQYTRt?=
 =?utf-8?B?a2dzSHlMR0haUDluVklLamNNbzIxT0JTWHlHeE4yOEkza3h2WlE0WTlSbFEx?=
 =?utf-8?B?TXd1QTFsNHlsZlNBSlVIZUZMVXdpOEN0MzE0aWE0ZU5oVk9XcFZiZG9LUnZJ?=
 =?utf-8?B?NVlESWV0ZzBKWUNJZG10cm4zSFpmNTNDeTBiWThGL1loQ1U0ekQ1eXRUNDBT?=
 =?utf-8?B?djlvcFFwcnVIRjNib0dlVlJoYjRFeXpscE9YQVlzd2l0V3p6Q1FxYXp3aHpL?=
 =?utf-8?B?bzErOVBUY0ZMR0hKZFNBWVg5ZU02V1pnS05Ba2gxVE5QczhaVW9CdzdDWE9x?=
 =?utf-8?B?dXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <668342F861C1D842836DA1829D413E2C@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	vQA8RQylZ3kTfYKTMQMWkxHR/gqaHsmNXhwCLIvPVl8H52/+s3FQiuzAoqTPRGqupvYZGGIejQoPhWpZ2FRtvIsLtk5mEhZS92fS5MpTfGT/KGA7PyPS8Bfj2dAhX0J0aekl+GDSlsRqCyNeHYoEu3DOab6n0f8EX1+s0Iy2wVVyMz0ny/f90IxyVq5e7vt1Gx7biRroKzfCgrzZaj/vjs4kk4txxA/QryS/Gl29lsoG5QL9F2kSU66YuueZK5YZ9FlOewu2wgpCFqjjjrkqVqg7p5q3IbfqCwsPlP8m3QhS1Y2Wf7jM0GKdcGw91cI9RjBUs33alCsPccqoDCQB53O6Yq6je+g9jyk8mHTz3AaCP9TryeHmkGYclnPfhnbzzYaoNokZL7uhQ9XFTZI0emFhb/KAkCVv779w6tCt6kNQiRgKOc6JzLyOXbzz14W6fAduMqhdtViZTolszqtIdX5vmFj9ZcvbjRRAklD6MVEcv0Ne/7FlQptqmbWowP142wK3OFuqV2UQ9YVmb0c4trnfhw1ijlMRMaXso+Xlzbd0/zHFXh0RDaPGrjxAdczNH40IY9tjb0HB3qeko0UIfGeYVmgb5PCQneG/OjjV4JA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 077ffc3d-8c05-450f-75b9-08dc83ef9006
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2024 17:06:51.5907
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2rS83U/s99KWhYBT8igfecyIHNgu7pbKU+WIBwGJRgL7JJRqqid12Gq5h10arFFLpwN47s2xZ6agzi1scQfxvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7488
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-06-03_13,2024-05-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 bulkscore=0
 adultscore=0 spamscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2406030140
X-Proofpoint-GUID: fv-YmLGnG3QFkDHLq0qVXuzi7WceMW8R
X-Proofpoint-ORIG-GUID: fv-YmLGnG3QFkDHLq0qVXuzi7WceMW8R

DQoNCj4gT24gSnVuIDMsIDIwMjQsIGF0IDEyOjU04oCvUE0sIFpodSBZYW5qdW4gPHp5anp5ajIw
MDBAZ21haWwuY29tPiB3cm90ZToNCj4gDQo+IE9uIE1vbiwgSnVuIDMsIDIwMjQgYXQgNTo1OeKA
r1BNIENodWNrIExldmVyIElJSSA8Y2h1Y2subGV2ZXJAb3JhY2xlLmNvbT4gd3JvdGU6DQo+PiAN
Cj4+IA0KPj4gDQo+Pj4gT24gSnVuIDIsIDIwMjQsIGF0IDI6MTTigK9QTSwgWmh1IFlhbmp1biA8
enlqenlqMjAwMEBnbWFpbC5jb20+IHdyb3RlOg0KPj4+IA0KPj4+IE9uIFN1biwgSnVuIDIsIDIw
MjQgYXQgNTo0MOKAr1BNIENodWNrIExldmVyIElJSSA8Y2h1Y2subGV2ZXJAb3JhY2xlLmNvbT4g
d3JvdGU6DQo+Pj4+IA0KPj4+PiANCj4+Pj4+IE9uIEFwciAzMCwgMjAyNCwgYXQgMTA6NDXigK9B
TSwgWmh1IFlhbmp1biA8enlqenlqMjAwMEBnbWFpbC5jb20+IHdyb3RlOg0KPj4+Pj4gDQo+Pj4+
PiBPbiAzMC4wNC4yNCAxNjoxMywgQ2h1Y2sgTGV2ZXIgSUlJIHdyb3RlOg0KPj4+Pj4+IEl0IGlz
IHBvc3NpYmxlIHRvIGFkZCByeGUgYXMgYSBzZWNvbmQgb3B0aW9uIGluIGtkZXZvcHMsDQo+Pj4+
Pj4gYnV0IHNpdyBoYXMgd29ya2VkIGZvciBvdXIgcHVycG9zZXMgc28gZmFyLCBhbmQgdGhlIE5G
Uw0KPj4+Pj4+IHRlc3QgbWF0cml4IGlzIGFscmVhZHkgZW5vcm1vdXMuDQo+Pj4+PiANCj4+Pj4+
IFRoYW5rcy4gSWYgcnhlIGNhbiBiZSBhcyBhIHNlY29uZCBvcHRpb24gaW4ga2Rldm9wcywgSSB3
aWxsIG1ha2UgdGVzdHMgd2l0aCBrZGV2b3BzIHRvIGNoZWNrIHJ4ZSB3b3JrIHdlbGwgb3Igbm90
IGluIHRoZSBmdXR1cmUga2VybmVsIHZlcnNpb24uDQo+Pj4+IA0KPj4+PiBBcyBwZXIgb3VyIHJl
Y2VudCBkaXNjdXNzaW9uLCBJIGhhdmUgYWRkZWQgcnhlIGFzIGEgc2Vjb25kDQo+Pj4+IHNvZnR3
YXJlIFJETUEgb3B0aW9uIGluIGtkZXZvcHMuIFByb29mIG9mIGNvbmNlcHQ6DQo+Pj4gDQo+Pj4g
VGhhbmtzIGEgbG90LiBJIGFtIHZlcnkgZ2xhZCB0byBrbm93IHRoYXQgcnhlIGlzIHRyZWF0ZWQg
YXMgYSBzZWNvbmQNCj4+PiBzb2Z0d2FyZSBSRE1BIG9wdGlvbiBpbiBrZGVvcHMuDQo+Pj4gQW5k
IEkgYWxzbyBjaGVja2VkIHRoZSBjb21taXQgcmVsYXRlZCB3aXRoIHRoaXMgZmVhdHVyZS4gSXQg
aXMgdmVyeQ0KPj4+IGNvbXBsaWNhdGVkIGFuZCBodWdlLg0KPj4gDQo+PiBJIHNwbGl0IHRoaXMg
aW50byBmb3VyIHNtYWxsZXIgcGF0Y2hlcywgSFRILg0KPj4gDQo+PiANCj4+PiBJIGhvcGUgcnhl
IGNhbiB3b3JrIHdlbGwgaW4ga2Rlb3BzLg0KPj4+IFNvIEkgY2FuIGFsc28gdXNlIGtkZW9wcyB0
byB2ZXJpZnkgcnhlIGFuZCByZG1hIHN1YnN5c3RlbXMuICBUaGFua3MgYQ0KPj4+IGxvdCB5b3Vy
IGVmZm9ydHMuDQo+Pj4gDQo+Pj4+IA0KPj4+PiBodHRwczovL2dpdGh1Yi5jb20vY2h1Y2tsZXZl
ci9rZGV2b3BzL3RyZWUvYWRkLXJ4ZS1zdXBwb3J0DQo+Pj4+IA0KPj4+PiBCdXQgYmFzaWMgcnBp
bmcgdGVzdGluZyBpcyBub3Qgd29ya2luZyAod2l0aCA2LjEwLXJjMSBrZXJuZWxzKQ0KPj4+PiBp
biB0aGlzIHNldC11cC4gSXQncyBtaXNzaW5nIHNvbWV0aGluZy4uLg0KPj4+IA0KPj4+IEp1c3Qg
bm93IEkgbWFkZSB0ZXN0cyB3aXRoIHRoZSBsYXRlc3QgcmRtYS1jb3JlIChycGluZyBpcyBpbmNs
dWRlZCBpbg0KPj4+IHJkbWEtY29yZSkgYW5kIDYuMTAtcmMxIGtlcm5lbHMuIHJwaW5nIGNhbiB3
b3JrIHdlbGwuDQo+Pj4gDQo+Pj4gTm9ybWFsbHkgcnBpbmcgd29ya3MgYXMgYSBiYXNpYyB0b29s
IHRvIHZlcmlmeSBpZiByeGUgd29ya3Mgd2VsbCBvcg0KPj4+IG5vdC4gIElmIHJwaW5nIGNhbiBu
b3Qgd29yayB3ZWxsLCBub3JtYWxseSBJIHdpbGwgZG8gdGhlIGZvbGxvd2luZ3M6DQo+Pj4gMS4g
cnBpbmcgLXMgLWEgMTI3LjAuMC4xDQo+Pj4gICBycGluZyAtYyAtYSAxMjcuMC4wLjEgLUMgMyAt
ZCAtdg0KPj4+ICAgVGhpcyB3aWxsIHZlcmlmeSB3aGV0aGVyIHJ4ZSBpcyBjb25maWd1cmVkIGNv
cnJlY3RseSBvciBub3QuDQo+PiANCj4+IEkgZG9uJ3QgaGF2ZSByeGUgc2V0IHVwIG9uIGxvb3Bi
YWNrLCBzbyBJIHN1YnN0aXR1dGVkIHRoZSBob3N0J3MNCj4+IGNvbmZpZ3VyZWQgRXRoZXJuZXQg
SVAuDQo+PiANCj4+IFRoZSB0ZXN0cyB3b3JrcyBvbiB0aGUgTkZTIHNlcnZlciwgYnV0IHRoZSBy
cGluZyBjbGllbnQgaGFuZ3MNCj4+IG9uIHRoZSBORlMgY2xpZW50IChib3RoIHJ1bm5pbmcgdjYu
MTAtcmMxKS4NCj4+IA0KPj4gSSByZWJvb3RlZCBpbiB0byB0aGUgRmVkb3JhIDM5IHN0b2NrIGtl
cm5lbCwgYW5kIHRoZSBycGluZyB0ZXN0cw0KPj4gcGFzcy4NCj4+IA0KPj4gSG93ZXZlciwgd2hl
biBJIHRyeSB0byBydW4gZnN0ZXN0cyB3aXRoIE5GUy9SRE1BIHVzaW5nIHJ4ZSwgdGhlDQo+PiBj
bGllbnQga2VybmVsIHJlcG9ydHMgYSBzb2Z0IENQVSBsb2NrLXVwLCBhbmQgdG9wIHNob3dzIHRo
aXM6DQo+PiANCj4+ICAgIDExNSByb290ICAgICAgMjAgICAwICAgICAgIDAgICAgICAwICAgICAg
MCBSICA5OS4zICAgMC4wICAgMTowMy41MCBrd29ya2VyL3U4OjUrcnhlX3dxDQo+IA0KPiByeGVf
d3EgaXMgaW50cm9kdWNlZCBpbiB0aGUgY29tbWl0IDliNGI3YzFmOWY1NCAiUkRNQS9yeGU6IEFk
ZA0KPiB3b3JrcXVldWUgc3VwcG9ydCBmb3IgcnhlIHRhc2tzIi4NCj4gQW5kIHRoaXMgY29tbWl0
IGlzIG1lcmdlZCBpbnRvIGtlcm5lbCB2Ni40LXJjMi0xLWc5YjRiN2MxZjlmNTQuDQo+IA0KPiBB
bmQgdGhlIEZlZG9yYSAzOSBzdG9jayBrZXJuZWwgaXMga2VybmVsIDYuNS4gU28gbWF5YmUgc29t
ZSBjb21taXRzDQo+IGJldHdlZW4gNi41IGFuZCA2LjEwIGludHJvZHVjZSB0aGlzIHByb2JsZW0u
DQoNCkkgY291bGRuJ3QgZ2V0IDYuMTAtcmMxIHdvcmtpbmcgYXQgYWxsLiBUaGlzIGZhaWx1cmUg
b2NjdXJyZWQNCndpdGggdGhlIHN0b2NrIEZlZG9yYSAzOSBrZXJuZWwgYW5kIGZzdGVzdHMgd2l0
aCBORlMgdjQuMiBvbg0KUkRNQS4NCg0KDQo+PiBTbyBJIHRoaW5rIHRoaXMgaXMgZW5vdWdoIHRv
IHNob3cgdGhhdCB0aGUgQW5zaWJsZSBwYXJ0cyBvZiB0aGlzDQo+PiBjaGFuZ2UgYXJlIHdvcmtp
bmcgYXMgZXhwZWN0ZWQuIEkgY2FuIHB1c2ggdGhpcyB0byBrZGV2b3BzIG5vdw0KPj4gaWYgdGhl
cmUgYXJlIG5vIG9iamVjdGlvbnMsIGFuZCBzb21lb25lIChtYXliZSB5b3UsIG1heWJlIG1lKSBj
YW4NCj4+IHNvcnQgb3V0IHRoZSByeGUgc3BlY2lmaWMgaXNzdWVzIGxhdGVyLg0KPiANCj4gVGhh
bmtzLiBBZnRlciBJIGNhbiByZXByb2R1Y2UgdGhpcyBwcm9ibGVtIGluIG15IGxvY2FsIGhvc3Qs
IEkgYW0gdmVyeQ0KPiBnbGFkIHRvIGRlbHZlIGludG8gdGhpcyBwcm9ibGVtLiBQZXJoYXBzIGl0
IHdpbGwgdGFrZSBtZSBhIGxvbmcgdGltZQ0KPiBzaW5jZSBJIGRvIG5vdCBoYXZlIGEgZ29vZCBo
b3N0IHRvIGRlcGxveSBrZGV2b3BzLg0KDQprZGV2b3BzIHdvcmtzIG9uIGxhcHRvcHMgdG9vLiBU
aGUgbGltaXRpbmcgZmFjdG9yIHNlZW1zIHRvIGJlDQptZW1vcnkgZm9yIGxpYnZpcnQgZ3Vlc3Rz
LiBPbmx5IHR3byBndWVzdHMgYXJlIG5lZWRlZCBmb3IgdGhpcw0KdGVzdC4NCg0KDQo+IFRvIGJl
IGhvbmVzdCwgcGVyaGFwcyAiZ2l0IGJpc2VjIiBjYW4gZmluZCB0aGUgY29tbWl0IHRoYXQgaW50
cm9kdWNlDQo+IHRoaXMgcHJvYmxlbS4gSWYgeW91IGNhbiBmaW5kIHRoZSBjb21taXQsIHdlIGNh
biBmaXggdGhpcyBwcm9ibGVtIHZlcnkNCj4gcXVpY2tseV5fXg0KDQpTaW5jZSB0aGlzIGlzIHRo
ZSBmaXJzdCB0aW1lIEkndmUgZXZlciB1c2VkIHJ4ZSwgSSBkb24ndCBoYXZlIGENCiJnb29kIiBj
b21taXQgdG8gc3RhcnQgZnJvbS4NCg0KDQo+IFRoYW5rcywNCj4gWmh1IFlhbmp1bg0KPiANCj4+
IA0KPj4gDQo+Pj4gMi4gcGluZyAtYyAzIHNlcnZlcl9pcCBvbiBjbGllbnQgaG9zdC4NCj4+PiAg
IFRoaXMgd2lsbCB2ZXJpZnkgd2hldGhlciB0aGUgY2xpZW50IGhvc3QgY2FuIGNvbm5lY3QgdG8g
dGhlIHNlcnZlcg0KPj4+IGhvc3Qgb3Igbm90Lg0KPj4+IDMuIHJwaW5nIC1zIC1hIHNlcnZlcl9p
cA0KPj4+ICAgcnBpbmcgLWMgLWEgc2VydmVyX2lwIC1DIDMgLWQgLXYNCj4+PiAgIDEpIHNodXRk
b3duIGZpcmV3YWxsDQo+Pj4gICAyKSB0Y3BkdW1wIC1uaSB4eHh4IHRvIGNhcHR1cmUgdWRwIHBh
Y2tldHMNCj4+PiBOb3JtYWxseSB0aGUgYWJvdmUgc3RlcHMgY2FuIGZpbmQgb3V0IHRoZSBlcnJv
cnMgaW4gcnhlIGNsaWVudC9zZXJ2ZXIuDQo+Pj4gSG9wZSB0aGUgYWJvdmUgY2FuIGhlbHAgdG8g
ZmluZCBvdXQgdGhlIGVycm9ycy4NCj4+PiANCj4+PiBaaHUgWWFuanVuDQo+Pj4gDQo+Pj4+IA0K
Pj4+PiAtLQ0KPj4+PiBDaHVjayBMZXZlcg0KPj4+PiANCj4+Pj4gDQo+PiANCj4+IC0tDQo+PiBD
aHVjayBMZXZlcg0KDQoNCi0tDQpDaHVjayBMZXZlcg0KDQoNCg==

