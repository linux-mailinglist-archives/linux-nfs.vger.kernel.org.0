Return-Path: <linux-nfs+bounces-10341-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27D13A44A32
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Feb 2025 19:24:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68A9D17BA3A
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Feb 2025 18:23:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1855820DD5A;
	Tue, 25 Feb 2025 18:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LvgQ2sVa";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="a46IhaTQ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5903B19DF4F
	for <linux-nfs@vger.kernel.org>; Tue, 25 Feb 2025 18:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740507678; cv=fail; b=luSmVa2dKJcCUbJL9NUuqJJ81eGnQYbcFoaZ7uVLXV55cva/mf/AnpRkMrCls0BcMSCQcp6RxXbhssurhFlJxusrEhXhPXBZUDnNg5g24JcfwFsoRnH1q+v1B/IkxyIppMMgc7j7fw44B0FFWAn/IJ1+B6JVLYKhHqxo54TOnJY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740507678; c=relaxed/simple;
	bh=XYAsMIzyCmtbaOd8y5POJ/1N94I9GLQLwCWQ3pWgEMU=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Cl/yClE8SS+OTcc9ZJvT/wO8ccBwJw3kpXXMQ9oNZsOMnhjrUa/JHgfuciv7ZDf8y+9dv+wooDgv5dPjuVOfUe6kCNVoT+KviTWTl7YMwX7CDbR5WOGBPwX3sduUxfcYOtDVpSsYG4HbxU2IMm11M9P+27KUvFbHjJzCZTjLa9E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=LvgQ2sVa; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=a46IhaTQ; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51PHtcRQ010272;
	Tue, 25 Feb 2025 18:21:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=gVruetUKI/2ZSK1uaM1b9Jn5lzgqhDfgB7ZgcA93za4=; b=
	LvgQ2sVaHRh93zkHe4EPlrP6EjiM87n/82fWXGrwyrX56N90rh1K9v6ic8nRVipH
	kJ/bhtgpqA5n/1wc5y4uXkN6Qr6CNux8JCpDWQ0Rmw1O+s0FoMl2AKzyzTfPtcfN
	3M9RZAtz1Y0m4+l1+bKvbmFI7GI3XcKg6h7W53pL+N/YgWFjYWPjO7aRkiejvfg1
	aAKO6a4k6BzBMqg5LdUSfNfc5VUSNZDfqbl+XmeSGabnFWh8PuArhtFYTWwpdd0o
	Fwk5/hZ0Mb3Xb2NwOUSdH3UbPuf2j5LkDC2CNlmyyVFfMthKri6eL/zYB+EEsnaj
	cX3quGpLJyBBG8KW3GdX5Q==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44y6f9dw0c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Feb 2025 18:21:14 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51PHprRX024523;
	Tue, 25 Feb 2025 18:21:13 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2045.outbound.protection.outlook.com [104.47.55.45])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44y519n5fp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Feb 2025 18:21:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MR9GOexArFTlja6dZktojJ7GbrP9hOpv5Qj7vZLZgQodcuFK5P3an670lSTsYQDEsy0gXslbNtSkYkzQeLdgIEzg5Crv4PwAv4cnXoppTdjOOVYkrOoJucH1seFzhMRzneUWz4hqdMBy4vuQz5GHOxNJrX252Wqd57vo2hIQJOPQBjbgBcwVnycz0cxPnCSOPLU5tlj00Yt43H7JwI5+k8AfHUZcHlbns0DAhyxqk7WLiTGF1mUtRFTqjvXS9z/DMYY6jpNuPuuAJtqbu4/CEXJH+Cl7uY+rOp6hyds5DoXHMunIJwG0aZQo838zeyrHwNXiU5ukScNddwir+icLLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gVruetUKI/2ZSK1uaM1b9Jn5lzgqhDfgB7ZgcA93za4=;
 b=S5EjPrmOoDoo1jsM/pQmoEPmIlZvuJQqAAZXbzpPswteYHuQuI5nHy1zRNvnOBVEPMsO8C9ALn+I16vAaSZ4gDy8MLlkwPOwrRJdDe4QvYN4VHpTtZTFe3wsbOa57IoW1OvF2lgpWWIqPYrOUK4SJlNG5XQdcigM2+X7qYZ+dKW3LstqmFrXrMacF2xTIQSAyBJ8sd7h+1fgZ3FYsIQ9obeJLERa+IzzKffh09SNZDKEwi7axQ0g+5EqItsQrqYlzjdcRaCY4XtBlMQzBD4yUp/8yJg1gW1sjD8uMtfSl+rdNX++InSyWO4mqNwUc5Q1m0C9ZaruvMqle7KZEnBItA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gVruetUKI/2ZSK1uaM1b9Jn5lzgqhDfgB7ZgcA93za4=;
 b=a46IhaTQ0hWEKCQVw5tqTtUACq7ruxt4FZXypBRbm9AA4o5oy3qF0XtlFr/p8mohNsSnVm1mS1uDEJrtk8G6CucZ3E7+3rhwNBhhfnCYvX4AMsLaKZEIiWTJ2JzrJR4wu3pqLRr1XaHhbpjZsmVV+vce0vFZs3FzXJKmYyFdHAw=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by IA1PR10MB6124.namprd10.prod.outlook.com (2603:10b6:208:3a8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.19; Tue, 25 Feb
 2025 18:21:10 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.8466.020; Tue, 25 Feb 2025
 18:21:10 +0000
Message-ID: <06bdc056-2453-4fdc-9881-2b0bb9b8ab20@oracle.com>
Date: Tue, 25 Feb 2025 13:21:08 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: Run 4 separate NFSv4.0/.1/.2 servers on 4 separate TCP ports on
 one Linux machine?
To: Takeshi Nishimura <takeshi.nishimura.linux@gmail.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
References: <CALWcw=Gscd+3dHU81hhU0maH_v1R2ws5ND3bYR1WkdEESs4Cjw@mail.gmail.com>
 <8fe1273c-ca34-48cb-ab24-848f81648f9a@oracle.com>
 <CALWcw=Gyq7m4X0dUKScn+b3Q7_QXz82p_Dck_eCGaC3ESMi=nQ@mail.gmail.com>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <CALWcw=Gyq7m4X0dUKScn+b3Q7_QXz82p_Dck_eCGaC3ESMi=nQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH5PR02CA0008.namprd02.prod.outlook.com
 (2603:10b6:610:1ed::15) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|IA1PR10MB6124:EE_
X-MS-Office365-Filtering-Correlation-Id: be0280bc-aa59-4737-b33c-08dd55c92ddf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eXc1c1Z1OTlON0JxSnNiM2d2enZiaXpMMDJleUd2R3BTRjBwczJnbm5vdmVT?=
 =?utf-8?B?MnlQcTdDc1AyVWxHNkRlSjYwSm5sRmZJU1hsbFloRTdCNm1DbXU5TEZOYnIr?=
 =?utf-8?B?S1NSZ3NpdDJlNzUzd29tWFBVbEJsOVNRRU9YbGUwNmR2RjZMNWhOWTFTQ05z?=
 =?utf-8?B?b2U5YXFacEZnWW9mY05hK3QwcDFpdkNvVDA3dm1vMUhCRkpzZ1dsVjluKzdm?=
 =?utf-8?B?eGdnU1FPbGV5bWNzOS9zNFBCL0xacDRRdU12NktBOVZUT2cwVXAxVkFpMXVJ?=
 =?utf-8?B?ZzRkUjZDSExVRUFzL2sxekt6NHJUZ2k0QW1YZUtPYWtpQ1cxd1NKVzB6L25j?=
 =?utf-8?B?c3dJZU9keGdKQXhvRkZjaWFhRzFubWRKWTVwUTMzSUtsNkNkQmR0d1N0S0hJ?=
 =?utf-8?B?Y1JyNERlY1hCWDU2VkxIcFU3Mi83aXBVWkk2NnZlUFF6Y3hZN3BNMXZSM3hD?=
 =?utf-8?B?TUlKZnU1VEROMjhFbjI0ajNpenhGeVhxNHFZM2dnamRlWUw3NEE3eUgxRmNY?=
 =?utf-8?B?VUhiUWNmMEgzdFg5b3BNR0p4bElmVmFRbDJyQlViSHhwbHhwT1ZFcnQxQnpr?=
 =?utf-8?B?YktiMzhXNzZvYlNQTU5OaG5zd242eGVuSm1rNTVicW10bjZmbDk3TjR5Y3hM?=
 =?utf-8?B?RGxVeUZRQW1zdzhQVE1zNUNBQ3ppeFZnZ3VacXA2blR3dytwOEZMWDJRMHI2?=
 =?utf-8?B?MVNxTnVOSk5SM1JlUmZxMERaU01MYnBuU3RXMGd4L1VnSm56SjdiQVM4Y1hB?=
 =?utf-8?B?NDhnbmFMQ1ljQWJYcUlMd2YyRmhHYmc3RWVJYWNDc2prL0lqVDhoM1dVbExG?=
 =?utf-8?B?SHBwZ2pUcDBUZ0tCN3dPK0tLYjdrTjZOMm1KeVJSQ2hnQnNMd1VtTjR1QTdJ?=
 =?utf-8?B?NkNvUExCVk81dHpDeTB1Ui9IQkxyZGcvVGhvTnNlM2Z3RStmS1E5a2RvcWZp?=
 =?utf-8?B?WUc5eUpEaVJDdUpESG9nWDNWS1ZDRFVuZ0RzWVc1SDZybGx1ZXh4ekJnMXlm?=
 =?utf-8?B?dldIM2UveHBiaUZWUExpOXJBanY5NUlGYUQyZjJoK2xOVWVlS3MyWFpMNE1U?=
 =?utf-8?B?NHNuOG5vaTNvbUhwcWJqV2FqSWdiLzZvSm5ES3F1b2ZCUXE1VXNoVlNvRStj?=
 =?utf-8?B?WCtRRnNNOXdlOXlCUWM0QjNjNDNKV3NRenVDNnVGcmJLand3YTJjbDdiMC8y?=
 =?utf-8?B?MXJPcXI4bGtHN1dPQWhEdE9RYW9reStlYTQ3TGFFMEUyMmgrUk9sT3U2ckVm?=
 =?utf-8?B?dTBoQjBRbXA3cFNqTnV6OFhUZEhlenNjYmh1WE13ckdWRVREQjJDcjNCb2xJ?=
 =?utf-8?B?Tlo1TC9uSEhZcnk0K3hmbjRZSmVaTFRCOU5RYTRkVVdEVWdlSnlLbkkzZjNX?=
 =?utf-8?B?bng1SU8rVmY4S0pzZXpRZlBpbllMSFJ0dUx6bVlNL3lBeUtLNlNxRk90K3JC?=
 =?utf-8?B?TG9PSjVKcEJGQVA4L2wzWVZjcjZVN3lHYzB3TjZVc2dxVVdobFROK3pGL2NI?=
 =?utf-8?B?ZVNPQXZBTTV2VVduK3lFU3BIMHBUdnBSTytoVStpNHYvK2ZhR1BRVW01WnBQ?=
 =?utf-8?B?Q2g1cmJpY3RsbnRWT1R4R1Y0eVNLYUs3bjcxaXFLWnY5UmtmOGJtUTN2TE0v?=
 =?utf-8?B?ck1NeHRZc01jNklQZ3B3cDM3ZytDRHliazFyNkhEeG1UMXZnSWtKQmtqSkMr?=
 =?utf-8?B?MnhGbFN4VTJrYnBKTjlmdTdBWjZRejYyblkyTXpyY3FaMTFzVUowYUx3Z01v?=
 =?utf-8?B?V2NqSXNKMithNU4zdU1ra3ZxMEpjMVorYWY3ay9SZ2Jra0QrNjB6Vkwxak5m?=
 =?utf-8?B?RlVQRTZTQlc5amJGeStpbVpEenE4ZGNWRDF4NjJ6emphcUE5dHMxNWwrNW91?=
 =?utf-8?Q?o9VdA5TXT/Kuz?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cHNycWdRN2ZLYzZ6enFCY3h5VisrSDlzRjNaVzc4bldoR240dlR0a0ZacWU4?=
 =?utf-8?B?TG42ZlloYUZVb1NNU1NqK3lVaGZmRVlwQmorQnZVNzBWTWtqSUVjMmZ5Ylc3?=
 =?utf-8?B?bDQzSklXR3I5K3V2emMwNDBaWlAxemNNanZVeG1tVGdoME12ZnhiZm4vRzlL?=
 =?utf-8?B?V3VybmVEQlhrMFhWSG5nYlRCa3hxL0dOL0U5NWNsbGlEQ3Fpd09QRDdjTHBx?=
 =?utf-8?B?MHB0azZHQTFpa1hXUDFHN2dqdldqQjFjY1EzbXM5SEc5Mm1IcE5EeHlSMXo1?=
 =?utf-8?B?VldPMlBkM1RzUzRaakdlWnhJYnlFMzBpM2pEMkhseDhxMzdiVGJ4SGhDeGJw?=
 =?utf-8?B?cFovYkIyUEZ3MndSYUFqeWFsazUvSkVHMWpROHEreVVSOENKYmIzbnFtdzQ0?=
 =?utf-8?B?WTJhek5pRzZoQkQ5V0JGL2lBTHUwOVdWUm42Tld6bDVLN2VWUDA0QTNaRm1Z?=
 =?utf-8?B?cW5NVWVRdThhN09XZXkweTZJK0VHNnlKb2YvdEpZelY2QkVJTDdjU041Vzlw?=
 =?utf-8?B?bHQ3OE9SdHJidzVHUEdsOEtMUUFWZkpua3ZLdVVIVzdnTUtrR2NpclVKWWFW?=
 =?utf-8?B?amszYmhHQXQvZjAySWlqb3JmZnowQmZhM3FQNk9LTWVmTTVLNHdpV1NLMUEx?=
 =?utf-8?B?RXdlMWVMM0tXV0d0V2pNaWwyajVFRFVoamd3aWlpWVUxUGIySXNMNlVDYkt2?=
 =?utf-8?B?UjFSdnNtRjVCUWl6UXFONG5jSWNBUTRkMmtNd283T3crUXpSVWY3VHNYS1JQ?=
 =?utf-8?B?Uzk5WmxtUU1NUFZhOFM4OVg5eStPeWZwZnMzeGdsMmpiMStheHo0cFQ2L2Vr?=
 =?utf-8?B?d0k0QjA5QS9abU1tU1ZpQzNma2tmVS9tYnNCb29Ubm9NSGlCMmNRazlSNXo5?=
 =?utf-8?B?NTJYazl1MTl2MUdUZUxQc0RnTjJpREpXS25xU0YvR01rKy9zMVFLZEdqWVBm?=
 =?utf-8?B?ais3MXhCVm1aa3Y0ZGVHQ0NwMFF2QldvVC90d1RJcTc3bUg4S2tZSFd2a1gw?=
 =?utf-8?B?SGlFN0hHc2pyMjJtMmVlMTk5SEp5ZWpXUFlIWElLb3ZFS2pEbDhRc1FvWVBy?=
 =?utf-8?B?TnpwR2pxUW1TVUUxWW0xemIveHNQWkNDdUxXV0k3QzhFNWVqQzNkUnhnQUFk?=
 =?utf-8?B?cFlLMFhxQkZoQk80ZGxrTDRsZjQ1UlBoRjVMUlBXYkN3UnJWWXBNeW93NWZC?=
 =?utf-8?B?VHVzd2dIdTRwalJNdlV6b2p0Wklyd0xHbmlOWUIvTG1rWVVxaUkxZFFBSVZV?=
 =?utf-8?B?dWk2dkJJWHVjRkZnQWFlMEx4MCtwQzBHOEdoRWJsMmc3eStDbUs1b213OVJi?=
 =?utf-8?B?QUNnWU1kSkkzQzlWeG1oVG1EYUd2RW9ZSklLekM2cGZMU0tSR21lVFdyZEVL?=
 =?utf-8?B?UE5qT3U2V2plZTgvOElvcTNEQ1FGYmlsam9BN1VzNkNCOXlyWDB2SUNsUzhx?=
 =?utf-8?B?MDRrUUErUmNzSC81a3lTVzhpQmtsNHpkQUxqWTJMK0R5Sm5ETmsvdm9nMENl?=
 =?utf-8?B?cFp0ZTlFbSthUStoQnZHcVpGYXRGTlB6LytGMENibnNneHJxeU1RZHNqREJk?=
 =?utf-8?B?N2NTM0pSRzVsb2pkRFAyUll0dUVjWDlhQWE0eE55N1VYWlA0T2pGV2hXdGor?=
 =?utf-8?B?VFFHeE1nYzRDZW1HWDdXZmlhL1RzNStYRzdxTnJ4ZlFYZ2x1bStFckkrU01i?=
 =?utf-8?B?QW5PN2lSd1IyRndDenNZVUgwZDZSaENlUmptZStHZisyS21TV1BQUDIrYWZa?=
 =?utf-8?B?WHJlbWlaWHVzV1lrSHpjdXdBMFJOZTRxU2lVSnlVNVhDeXRmcTUyclpkc1E3?=
 =?utf-8?B?WmxxRThGSHhSTEFoUFNiVkoyUDB5TXl4QVhmYUVEWFVpMm1RSm5yNEN2ci9W?=
 =?utf-8?B?b3V3Mnp1RlJiVm1Rc0dBbkpRSjRUa2ZMK3hHL1dkbG9rTjlQdkh5Z2ZUSVpT?=
 =?utf-8?B?RHNhaGRKS2t5c01DdmE0QjRnWUZsV1dLS0tYVTV1cmI0WC9LRDVNaVdsU2RH?=
 =?utf-8?B?YjljSWRwa3VQclRsbDQ0MTBqbThRR0pCT3NHck5TTFhXY2s5WVhPQjkvQ1F1?=
 =?utf-8?B?MGVtb0libUtvTU1zdlovdlpyU0RnSWdKbVcrQkNBcmRUcDJSNi9ucFhQaWtq?=
 =?utf-8?Q?tczu0VPHKSoSApdaTgGxMoOks?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	BnzNv2LyTMo+b++MbpCpejuzcfgVXwHCKNJP5MkisUETCxibUlwXdBV23eVsxUYSz4M1Oal2I+h4u/lUfBPy375mr/uGOx/UAPvmW/rZCCWUcXTwUBlahpfQgE+QqTAhzgOhYqp1iOoAh5hRIgRjDZJYNdh9vZ+uFeaC2V2ZmCfeI1p1kIKMHny4ZNhYyqNZOqe793q4dEI8HYl1EwHmNk+XZk6w+8+Et4zCsWEHym7p6UPZ1KZ17+vpBOfxWTQfflvt4IjUOBs3t2FOZrqWLxSWc+bg9Ecuk75fnoO9ltDvdaBewvrBIsPIMihO5l/eUqZFbTze8tIfPaDhL0Xyu7a/grpewNsxOLFJ2lGUSaTxLR6KDTLlu8xJd9s0zckGomdSiQAFkqz6q1I6L2ziY5+ma2zN3r82kASYzqz8Jt2RNIFDlbcPCQkFGg5QHO/vxjZK4SLWPAr38xdVFA3geIIT2yeom6bvyT6QaY3RtqpXX/29d6HGDGT/nvTzw6xzMUFjoRy1lNO17pZDQVR8FTmpL/Gq65fiCqponnEr81ZX5ATKtS865wrCXLH4gydzGM1M5nO9v/laSNbcXuhDI9jofCP4wdFl5bo3zNaB35E=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be0280bc-aa59-4737-b33c-08dd55c92ddf
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 18:21:10.4908
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xcv+tJZfdrOl82zJk5Z8Pk2Y0yevOXxXmN8yI8q0/dApgFFmOHyMRK9Q2fWUdweyyzblAalNwkPmdoqGDkfvJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6124
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-25_06,2025-02-25_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 adultscore=0 mlxlogscore=999 bulkscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502100000 definitions=main-2502250114
X-Proofpoint-GUID: htoaBymTTICAOZERu-U9VjDB0CWcJeC1
X-Proofpoint-ORIG-GUID: htoaBymTTICAOZERu-U9VjDB0CWcJeC1

On 2/25/25 11:34 AM, Takeshi Nishimura wrote:
> On Tue, Feb 25, 2025 at 5:17 PM Chuck Lever <chuck.lever@oracle.com> wrote:
>>
>> On 2/25/25 11:04 AM, Takeshi Nishimura wrote:
>>> how can I run 4 separate NFSv4.0/4.1/4.2 servers on 4 separate TCP
>>> ports, say 2049, 12049, 22049, 32049, on the same Linux kernel, and
>>> have a separate exports file for each of them?
>>
>> This question has been asked in the past. We've explored implementing it
>> with a single NFSD instance, but it looks difficult to impossible
>> without massive code changes.
>>
>> The solution we recommend is to run separate NFSD instances in guests
>> (containers or qemu). The host system might provide a NAT routing
>> service that makes the guests appear on the same IP address but
>> different ports.
> 
> Running in QEmu is not acceptable for performance, and it adds at
> least a 1GB RAM usage for nothing.

Cloud providers use qemu virtualization without suffering critical
impacts. IME if qemu isn't providing the performance you expect, you
have some tuning to do.

If you have performance data that shows a problem we can address, then
please post it here or file a bug against Filesystem/NFSD on kernel.org.


> A container is also not a really
> preferred option, because the OS files in the container must be
> maintained and CVEs handled.

My understanding is that in simple container deployments, the container
gets exactly the same kernel and set of OS binaries as the host. There's
no reason to get fancy if all that is running in the container is an
NFS service.


> Why is it so hard to run more than one instance of a nfsd server?

Let me put this differently. The administrative abstraction on Linux
that handles this is a container. This gives you a virtualized network
device, virtualized storage, a security realm, and a high administrative
wall between the individual NFS services. The containers all use the
same pool of resources on the host, but appear to be individual NFS
servers.

Making it look like one NFSD instance with multiple administrative
domains serving on multiple network interfaces is unnecessary, and
would require a significant development effort.

If you want a solution you can deploy on Linux today, then qemu or
containers does exactly what you want (with the addition of a NAT to
conserve public IP addresses).


> Is there a cookbook or howto which documents how to set up a MINIMUM
> container for this?

Not that I'm aware of, but that doesn't mean it does not exist
somewhere (and possibly in several pieces). These days, distributors
provide a significant amount of documentation; none of that would
originate from the upstream Linux community.


-- 
Chuck Lever

