Return-Path: <linux-nfs+bounces-4066-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 61C0490ED23
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Jun 2024 15:14:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65EEF1C2118B
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Jun 2024 13:14:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 645F314375A;
	Wed, 19 Jun 2024 13:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DKsWSgkY";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Evoecsdy"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E7FD1422B8
	for <linux-nfs@vger.kernel.org>; Wed, 19 Jun 2024 13:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718802873; cv=fail; b=hJOxpwFtASsDWXmIUtDdgUdy12M7lC0XrusDAPdFgdyQBaM3HfBKuZlhVjCfxL2CfEMPRBGz1nEYfNhOPDGZMznHE+OMzRrTFdlqSfKlGBjRVa9zLwDmtqPxz3Z4fgsFzSoJJBj1jN2Z+/vdZBB39LKycSED2SSUxQL2+tI5p4s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718802873; c=relaxed/simple;
	bh=m6lqh7OwnCxlhrNIon+jt841AbPPo4usAlHMg2MSdos=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qV8gxxdUiKMA8wmHUAW1qHMogB1EuOczem5fN5K2Oxbksy1ikhUA4JHMTRnXqhJufLGrG6F+mPshr7RAeHVvHwAuhv58OyLXM30DdvC15/je9/ZFpH6/OWhfDpYtHCUbX9ciEycdHVfzIlumJiC+/PJyHwLI/WiI9sxF9n2ofoQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=DKsWSgkY; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Evoecsdy; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45J1tX3U031146;
	Wed, 19 Jun 2024 13:14:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=corp-2023-11-20; bh=m6lqh7OwnCxlhrNIon+jt841AbPPo4usAlHMg2MSd
	os=; b=DKsWSgkYS6kp8eQAo5PYc8DruVgFOwl1/EKG1W2F96hA7BgYxR3k8cgZw
	Nk2fVJrXeq8Jy5LZKCEfBrUVYRlOxvf4TbfjYLTRHlePMSUPgfUgwwO9ELFilPvR
	999ZQ7hSjz4tUo2mmRTq5ODw9aGnPeDbqpSiBESX3iOFMWtkQwsFV+DoPUZ+0B5A
	c00n/6OVFsDDNRbT8BD0g/3VsHoPCMspxnlYTnudjJdmwpwzQnOU9VXmmL/iwnZC
	vfIdqhtkKCH5nnlGHTw5lBj0V8O74dpleYXAg6LLxt/uF5u2AQjPm1kAKIMF2ECB
	0cN2xjlnhEIIUByOUfL26tD+iSQ2g==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yuj9gh88e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Jun 2024 13:14:21 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45JCRa91014870;
	Wed, 19 Jun 2024 13:14:21 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2170.outbound.protection.outlook.com [104.47.55.170])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ys1dfm4x1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Jun 2024 13:14:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vbf9FnbPGUOluAMcGZ3ul0FcTH5ISLY3ga3Ua8Icwnw7c3y7FjAaDM1GNmPpEUFUM/zf09/xxYyee2fgzHqKsgZj6qV7ISi4oMJakdGdXL+4pb4X760584McrXTcq4VCN0/zGgRpwaVmp7qBEvkUGA2471IshW4A07Uf6gii1Jps2Uc0Ukwoh3s7Ir1pC9ZUPVLOrJ+JvviBEuT40YzB/uZRc6a5gQZnFcoIxnw0HeKYc/zhlQmybvX09fOJkrtTY1O+P+58o551kUf3krLDd/ZIIWxXAkB/zuMC5+lPLr+TJ629gY8JDiwCmG8lYUCG9qAgyOEHBxM6eS4KxaytJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m6lqh7OwnCxlhrNIon+jt841AbPPo4usAlHMg2MSdos=;
 b=PtsvacPISZGwjC7i3OjchPzWhnTFQKC9NLb4k1oRSmjJrKnXIWO39iRENtsaTmd8CmriiU7AEBt/RYUBvcBEOMdicEEHdfTHbNmNlhlN3NJ7TIHX/+A+bkmEj11ugUaYBcg6Kcy8+m6PNYVoBfZQx0vRwdbnqIigchdxbZ5XIBdHabQ8z0BjQC3tXpj2iYwihEGrq4JJ7REQEo8tn64BPsjQKg0qIIFbbdHIltmUEFrVtIzBnck1/Wdjl2BDafxVGy7X7xzVfK/ue4VWV2v/c0HHUp7Kx2DbVdgM49edXwSKZ/y3+/p9HZHe+VG5jtnu0C0ZNfpYHzbJC/3HqHVsOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m6lqh7OwnCxlhrNIon+jt841AbPPo4usAlHMg2MSdos=;
 b=EvoecsdyeHeOvQitltLs7q+Xh0LqBthm6rRAZLUEDpo1F9G+3Hg0Cwg7lxlncMNyKYAp/iA+HlxzZkZ47p3SWjXTS/0W5NujAujA8X/UQrXEj4iQ2zsVCQh7QulfkhTA12UoXzPPVrwv/VRLE7akWngJLUXHnrRH4yozQ14xJHQ=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH7PR10MB5832.namprd10.prod.outlook.com (2603:10b6:510:126::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.19; Wed, 19 Jun
 2024 13:14:15 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.7698.017; Wed, 19 Jun 2024
 13:14:15 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Harald Dunkel <harald.dunkel@aixigo.com>
CC: Calum Mackay <calum.mackay@oracle.com>,
        Linux NFS Mailing List
	<linux-nfs@vger.kernel.org>
Subject: Re: nfsd becomes a zombie
Thread-Topic: nfsd becomes a zombie
Thread-Index: 
 AQHawINhxmk/oYie502r8DWoEFDBZrHMBR+AgABQzACAAUEIgIAABisAgAEXgYCAAF95gA==
Date: Wed, 19 Jun 2024 13:14:15 +0000
Message-ID: <27922D49-743D-4FC2-86C6-6926FE52537D@oracle.com>
References: <4c3080af-eec7-4af5-8b0d-c35ac98ec074@aixigo.com>
 <C1CE3A96-599C-4D73-BCC0-3587EC68FCB0@oracle.com>
 <4eeb2367-c869-4960-869b-c23ef824e044@oracle.com>
 <661a6c9a-81d6-46fd-87ec-274100b12189@aixigo.com>
 <ZnGfEDvQB1FRGVQK@tissot.1015granger.net>
 <668b479b-3a51-4287-b9d7-44d6dfa4eaf4@aixigo.com>
In-Reply-To: <668b479b-3a51-4287-b9d7-44d6dfa4eaf4@aixigo.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.600.62)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|PH7PR10MB5832:EE_
x-ms-office365-filtering-correlation-id: 527b0029-d5f8-4c09-3643-08dc9061b851
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230037|376011|366013|1800799021|38070700015;
x-microsoft-antispam-message-info: 
 =?utf-8?B?RGt3K0VkSk5GMXlDSkF1RTR2RWd1OVF4MWkwN3RPRGlscVpJMGpQVkp0ZWVD?=
 =?utf-8?B?cCt0akdkcVJpMU83RUpQdlFyc0U4MG9MTlE5cEJXc0gxS2RvamhFN1ZRT1Y4?=
 =?utf-8?B?enl5M3FlNzZPYURNUlNqREoxaHZkT1FUK21MODlWb0o5RlBYMm9XYnp4b0I0?=
 =?utf-8?B?MTBTQ3FZSkhhY1o1YldnQ3ZRT28rOXArdDBSeTRKU1JESUR4ZmFENG1BeGpq?=
 =?utf-8?B?UmFwaGYvN2ZRVmVxMlZJRU1LRTVZYWoxRnFpNXNrcEFPZlNJc0Fjd1ZUczBl?=
 =?utf-8?B?NnFMczQ3WEZ2TWVSYy85S0hrZWE1eEZTYkVOY2Y2SVRyb0F1NU82R1l5ZmVY?=
 =?utf-8?B?TkV5WW05ZFZRc2FCb2IzZ2UwaFBEOGRYcThXTk5oaW4vY0lZaGF2SExxSk9s?=
 =?utf-8?B?THpveENyTlBRRTAyYWpCLzVkT21MQzlJS1g2cWViYjdPV010bDhZZCttRkhn?=
 =?utf-8?B?Q01TcVMyV01vay9OUXZEOWJuNUxHK2ZYakhCZk5QTWtySlZKR040b3p4YXVw?=
 =?utf-8?B?Y3hmcUpKdlB3bE8yV20vNXNveEZhTlEySDRibEtlY0xTcWt1YTErM0lBSUVM?=
 =?utf-8?B?VEhDeGNLYWRUL1daNjkva1J3YW5ybm4wUDRRdmNGT3ZmZm1HRXA1M2Rsekhp?=
 =?utf-8?B?VnVhUS9oQ3BHcnU2K0FWQ3JJOG55dWNJTk1GbXBrM2ZtMjFlaU9aazRraWUv?=
 =?utf-8?B?MU51RzFycERzaWMwM0doL0IzSU52Zkt5Y1gvaHdNMXRwSUlMVzc1MjNKYUZv?=
 =?utf-8?B?Q2JabTV6cktmdlpvYS9YN1JONnBHamlMUTJJNCtLSVJNMVJ4NVBleHlUdEV6?=
 =?utf-8?B?VFozbjBVWGt4NG1IU3YwWmJYbnNLWlVUTUlJNVl4TXk0WnRpQnY1Z25oQ3d5?=
 =?utf-8?B?YlpldW93NmFjcTJpYW9NVGo4dzh3V1BWb0J0ZnhSajB0dFI3dmFWUHcwQm1Q?=
 =?utf-8?B?YW1hS3U3VU1TQUNYaUNjaHNxM0JqZmd6cEZKemFaV0R5T0JFaXh5QUZNTmNw?=
 =?utf-8?B?OU9Cd1ZJemVrN1FSV1NQYnFIOE5CRDRjUXB5bGxMRGlBeGY4YnRqem04MUdU?=
 =?utf-8?B?MDhJclZlcGh2eUxCSnNyODFEbCs4eW9OYVZCek04S2psTmsvUWErNklJL3gr?=
 =?utf-8?B?Sm5DZXVrSUVrNG9VTXZiK0pSeS9DOFVNSzFGWWcrTEYrQXdyR25LTFBrU1pF?=
 =?utf-8?B?ZHVlemwyRHV2SGRQdHdzYkwxWjhNNWt3ejRlZmlOMFhpN1c0S0h3MnZGVWN5?=
 =?utf-8?B?QlNrT2s5dUY0bGhPT1FrL1ZvVHNZaGc1SVFzcjhoOHhMUnd1S1NIeFlvNWZ1?=
 =?utf-8?B?RnZibGM3NytoRGVyOFB4MUFiRUh0UU10Kzc2MXNVamYySEN1aWhpNE90NTlo?=
 =?utf-8?B?NmkzQ0hYOVNMRUwxSU0xcDhnSmp2VG11WXNxdEVVQXVjTWFFOXlJNnhVZGFx?=
 =?utf-8?B?bXBTaHpXdnhxb1c4RjFGRlF4bThkOFA4SldrNVMzTnVPb1djOGRJLzM0OVRQ?=
 =?utf-8?B?NXdJc290c0NxRVBBNEUxK1FXZGxrWnNVcXlyQkx2c0R1Yk42ZVd5NjlETC9S?=
 =?utf-8?B?clFONlN0Rzg3V3VEYzNkRkhvbW5BZE9Kbi9pQm1jZWhUL2dUQU5Hd3lLNENK?=
 =?utf-8?B?OUhTa0NYK2lXcDVGNkhsak9QTnA2VFI4VDVuTE9xeE5rRlE3a3BnNE9nUFFM?=
 =?utf-8?B?elF4aUZBRCttbU9TNHBmR2lLbk1CQ0pka25MeW1RMFZyTjlCUk9BdmY0Nmk3?=
 =?utf-8?B?QUQ3Y2ZtT3VQQjhsVG5FL2t6dFBJblhZVmVHaTRabytJT3lkbERMa0dTLzhM?=
 =?utf-8?Q?R8pxi9CJiJo+ynLStiR8c9ZBmW4i8mVGKGMFw=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(366013)(1800799021)(38070700015);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?Mk1kR2k2Tk90VnllK25vaTVNNHAyU2xXQXpRMTRUdHlJcEtrL3FPOGJaaVVr?=
 =?utf-8?B?czdjdEVKUXZvUWJtQm1pWWlsdEMwbG45cTg3bytVNVZIUFdJb09UTHozaXdG?=
 =?utf-8?B?QmN2aTZZZG9JeWNMKzZwOUExbklOK1R3YVBXMWFjWEVROHc4bDhDU0ZzeHJK?=
 =?utf-8?B?cGhsT2ZiQ2pMb0ZvZm9CQUdOQTY1aEp5blBMRkYwVWFKbUFXays5VmFVc1FK?=
 =?utf-8?B?bEY4Q0JKRTdQLzUvbWNXT2llTXlNR2F0U3hRQzZnTFE1dnJtTlUyVDIvdjYx?=
 =?utf-8?B?WGVsYXM5NXBhc3I3UFIyOW1YdGdUaVVISUp0cWFvNlNXQXZtV002dUw1bndQ?=
 =?utf-8?B?WTgrNHNCVFpYQVg5Q2JodXNXanY0UEFDMUxWcGJpaHdSRXRwMW9FTllOTXph?=
 =?utf-8?B?K3F6dzdTUlFBSmdjOTNZVDBsdHdJU2RQVXd0c3hJd2FDM0ZqZDNxRzdOblNr?=
 =?utf-8?B?YlVheldxWXNZM1BrZnNsQXV4eTFaR1FmYlhxUnpPQU9WYVRsbTIvMzdWZzRO?=
 =?utf-8?B?cW5VNmhidXliaXJGNTQ3UHNrc2czV3QvV1A1Y2psL0VxUW4zcGVhQncwQ0dN?=
 =?utf-8?B?VDl0K3hWYXR2V2NKTGJYTjNoQ2JwS1dhdFl5VndGRXB6YUdId2tJeTlVVjhj?=
 =?utf-8?B?cUV4TVN5V0Q0ZExlLzY1RE1ybncvaitIN3o3WnNQT2Nrb0M0Z3JVT3NEc3JJ?=
 =?utf-8?B?cmFHRG1lQXEyWDlxV0F0YmxNOEREakppODJROUZ4ZWN1eHM1NkpQejRmUTcw?=
 =?utf-8?B?a0o3ODdSV2hxelFld05nTkFYbmhuZWlMU1hRTHROMlE1VDFEMXhrNlVDREky?=
 =?utf-8?B?YUF2TDNuTzgyamIxdEFyZFgvNmNpZzMzZW1GeUx1ZDdkZElXRU9GYkJpaTVY?=
 =?utf-8?B?aG5JM1lMNDJKaFh1STFCMHdFUEJtemI5LzZPNlI3clJQREZnUnI3aHdabXNJ?=
 =?utf-8?B?NXREV2FYWSt3TXJxT01HRXJ0SFhac3Q0Y1BQUVpYWFNGaGxROGk2eHY1RzFz?=
 =?utf-8?B?Qkpic0l4T0o2MmtxanFDVlJXMVlEUllFNmVxRzFyaGxJRGxPMm9sTklUdVJr?=
 =?utf-8?B?UXN6bGJRRTBCNlRXRkwxRFpRUGFtaXBRamRqM1lPdVA3RzIyY0Qyd0lLaXIy?=
 =?utf-8?B?Zk9wN21sTllqVmxtaGlhYVNkOHNVVGRoQmhKTGdET1ZLVW5oUUQvVmNkVnFS?=
 =?utf-8?B?VFBLN0s5YjdGMFJNMXZGOElxcmdmaHd4VnlldVBHbVJWRkVFalpKNmxibTFl?=
 =?utf-8?B?UHIrKzhldmVlZnNJT2grbEd6bkx1OFNlQ2toN1FJWVZXZVEyZ0VnbVc5ai8v?=
 =?utf-8?B?QkN2VTBYLzd0WXA1Si92R3F2eFJmQitpeStzd3NpZ2lSa0VJSFArNFl3UTlj?=
 =?utf-8?B?T21EejhZQmE1K2F5NDNGUWFsSFNSWTlHczRRVEVYYUVhMWJpdE9HTTE2c3pQ?=
 =?utf-8?B?OUpzQUttTkFLaktYdjdnK0xXcnZTSllaSEI0VkF6V0dKVnc2TkNtRFd2REJv?=
 =?utf-8?B?aVBLbjBYM0k2WXRVVUlUTjAxMmZMcUxZeVVHN2RRUThPSEtLUmltUHZhVkV3?=
 =?utf-8?B?UUZDMDMrODZRcCsxbExUcjJzenpQeXBoSklzRTdaMDdVRHBqM2lzSVMzbVRO?=
 =?utf-8?B?YnZ2eXlqS0xJc1UydHVYZzltclRsQU9xODUydnRsQTZ0cTF2NFI0L0NhcExO?=
 =?utf-8?B?N3cxNUNub1VPRGQ1akVTaXlibmRwRFhYRzMxVjZIY0E5dTNVUlJaT0k2cWR6?=
 =?utf-8?B?RjhNSlhhQnFDNGZvaUNLY2NCNVlaTEx0bng5V3l6Sk42L1NRTVZZTmVRcFhu?=
 =?utf-8?B?KysvQnI4QU5VK0VyajdyM3JVa3BxcjV3RXVkSk5qMXp2OU9majVUOEtXUGQy?=
 =?utf-8?B?UXVwS01OR3NUWlJJY3FRSEVIYWxMbzQ1MTJoNjN3ZjhadUkrNUJqNlAxdU5K?=
 =?utf-8?B?MlJYeXBxaVFMZ3JpYXVIMmtiaXAxT1ZZSTZrNThkTlBsWXlrdHdqa0Zkek9F?=
 =?utf-8?B?YXJQYzZIeUVETk00RFk4MGo4K1BQOCtEeHk2OFg2K09JaW5BSDlQMjJsZTFy?=
 =?utf-8?B?ZFBuV3Y5enJsNUo0YTJla2EvOVJtRENKRmM2SU05cmlCeTBYeUdHaVFXV3F6?=
 =?utf-8?B?TEVJRElOdkl3NWRmZ0FoM25xQ0JUWllTbVpYZ3lFZVhnTmJnTm1YVFJ1RHZG?=
 =?utf-8?B?YWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AB15727A7B7CDA46BA75CCC189331553@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	UCkuBE+eVPHmqatruYezBuaFeNg5yAAttv+V1vvf+h/Vsg/o/eZjJOgUhZ0D2RHWe9rlQzTnEDPGMoVEOfJxjclqT3BvlH9AVluGozMwq7OqdYcoJqvIaJr7RpIuqiS1r5n8E6p191TIt6+Ka0zZm0xoDXzKC3aYTMRbmyXHRPh9nK5f8Z8GnTdwXmIhdo3fJ7y7e4lQtBJJbxpRynxo7q9xk6dAG1zfHyF31tBtBBpOLy9aQx2HMQIWso+b/Dr+g5DQZG0hdG2JxqB5mg8IFCAaK+lfFhN0Wbe+UxaCxv4PyYK4DNkvWj4Z3sDQBwz2cwfUgIx1SJ0qwjqOGNXQjaq3YM8v8F9OVhn3Q1gYdRcxTYMsWEJCkH5MacgdLDxPhk9ESnKj/pznAR7jimqoxrXydldZD9Bv4g5Os/5dIKo8LpqDGpRx9t2k9lOGPpK38hYUc2QHaRgWRNQhVDwlNk8/lN7hBv9fl3ynIDqxss6dEmdrernjmGN8q0LXnNPoxck85RTLcsUsOiSgjRm1dlRdxKKTW8rVSzygk/UhGiB02fOQFEQFRYCN25ETVc4Igo2edJ/x14p0YJhy3UvlxSLAdfOHeOqjzIzXFxkwAbs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 527b0029-d5f8-4c09-3643-08dc9061b851
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jun 2024 13:14:15.8005
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sBVPzDAE2QWaWe6vBaN8lh4MrmQ6HO8dKD/H8CbaHL66uleyFCdkLGFd4pDlE+WSkgFNO+BSezi4WNPIb3gv3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5832
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-19_02,2024-06-19_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 spamscore=0
 adultscore=0 mlxlogscore=999 phishscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2406190099
X-Proofpoint-GUID: CPqY-PuXaFtY3c5v3ROxBIY_bREGxB-3
X-Proofpoint-ORIG-GUID: CPqY-PuXaFtY3c5v3ROxBIY_bREGxB-3

DQoNCj4gT24gSnVuIDE5LCAyMDI0LCBhdCAzOjMy4oCvQU0sIEhhcmFsZCBEdW5rZWwgPGhhcmFs
ZC5kdW5rZWxAYWl4aWdvLmNvbT4gd3JvdGU6DQo+IA0KPiBPbiAyMDI0LTA2LTE4IDE2OjUyOjAw
LCBDaHVjayBMZXZlciB3cm90ZToNCj4+IEkgY2FuIGZpbmQgbm8gTkZTRCBvciBTVU5SUEMgY2hh
bmdlcyBiZXR3ZWVuIHY2LjEuODUgYW5kIHY2LjEuOTAuDQo+PiBCZXR3ZWVuIHY2LjEuNzYgYW5k
IHY2LjEuODUsIHRoZXJlIGFyZSA0OCBORlNEIGNoYW5nZXMsIDggY2hhbmdlcyB0bw0KPiA+IGZz
L25mcy8sIGFuZCAzIGNoYW5nZXMgdG8gbmV0L3N1bnJwYy8uDQo+ID4gPiBBcmUgdGhlcmUgYW55
IE5GUyBjbGllbnQgY2hhbmdlcyBkdXJpbmcgdGhlIHNlY29uZCBoYWxmIG9mIE1heSB0aGF0DQo+
PiBjb3JyZWxhdGUgd2l0aCB0aGUgTkZTRCBtaXNiZWhhdmlvcj8NCj4gVGhlcmUgd2FzIGEgYmln
IGNoYW5nZTogTW9zdCBjbGllbnRzICg+MTAwKSB3ZXJlIHVwZ3JhZGVkIGZyb20gRGViaWFuDQo+
IDExIHRvIERlYmlhbiAxMiB3aXRoaW4gdGhlIGxhc3QgY291cGxlIG9mIG1vbnRocy4gQSBiaWcg
Y2h1bmsgb2YNCj4gYWJvdXQgNDAgaG9zdHMgaGF2ZSBiZWVuIHVwZ3JhZGVkIG9uIE1heSAyMXN0
LiBUaGlzIGluY2x1ZGVkIHRoZQ0KPiBrZXJuZWwgdXBncmFkZSB0byA2LjEueHgsIGFuZCB0aGUg
dXBncmFkZSBvZiB0aGUgIm5mcy1jb21tb24iIHBhY2thZ2UNCj4gZnJvbSB2ZXJzaW9uIDEuMy40
IHRvIDIuNi4yLg0KPiANCj4gVGhlIGN1cnJlbnQgbmZzLWNvbW1vbiBwYWNrYWdlIHByb3ZpZGVz
IHRoZXNlIHRvb2xzOg0KPiANCj4gL3NiaW4vbW91bnQubmZzDQo+IC9zYmluL21vdW50Lm5mczQN
Cj4gL3NiaW4vcnBjLnN0YXRkDQo+IC9zYmluL3Nob3dtb3VudA0KPiAvc2Jpbi9zbS1ub3RpZnkN
Cj4gL3NiaW4vdW1vdW50Lm5mcw0KPiAvc2Jpbi91bW91bnQubmZzNA0KPiAvdXNyL3NiaW4vYmxr
bWFwZA0KPiAvdXNyL3NiaW4vbW91bnRzdGF0cw0KPiAvdXNyL3NiaW4vbmZzY29uZg0KPiAvdXNy
L3NiaW4vbmZzaWRtYXANCj4gL3Vzci9zYmluL25mc2lvc3RhdA0KPiAvdXNyL3NiaW4vbmZzc3Rh
dA0KPiAvdXNyL3NiaW4vcnBjLmdzc2QNCj4gL3Vzci9zYmluL3JwYy5pZG1hcGQNCj4gL3Vzci9z
YmluL3JwYy5zdmNnc3NkDQo+IC91c3Ivc2Jpbi9ycGNjdGwNCj4gL3Vzci9zYmluL3JwY2RlYnVn
DQo+IC91c3Ivc2Jpbi9zdGFydC1zdGF0ZA0KPiANCj4gSSBoYXZlIDMgY2xpZW50cyB3aXRoIG1v
cmUgcmVjZW50IGtlcm5lbCB2ZXJzaW9ucyA1LjEwLjIwOSwgNS4xMC4yMTgNCj4gYW5kIDYuNy4x
Mi4gVGhlIDUuMTAueCBob3N0cyBhcmUgcnVubmluZyBEZWJpYW4gMTIgYW5kIHRoaXMga2VybmVs
DQo+IGZvciBzZXZlcmFsIG1vbnRocywgYnV0IHRoZSBob3N0IHdpdGggNi43LjEyIGlzIHJ1bm5p
bmcgdGhpcyBrZXJuZWwNCj4gc2luY2UgTWF5IDE2dGguDQoNClRoaXMgbWFrZXMgaXQgdmVyeSBk
aWZmaWN1bHQgdG8gc2F5IHdoYXQgbWlnaHQgaGF2ZQ0KaW50cm9kdWNlZCB0aGUgcHJvYmxlbSBp
biB5b3VyIGVudmlyb25tZW50Lg0KDQpNeSBuZXh0IHN0ZXAgbWlnaHQgYmUgY2FwdHVyaW5nIG5l
dHdvcmsgdHJhY2VzLCBidXQNCnlvdSBzYWlkIHRoZSBwcm9ibGVtIGlzIGhhcmQgdG8gcmVwcm9k
dWNlIGFuZCB5b3UNCnNlZW0gdG8gaGF2ZSBhIGxvdCBvZiBjbGllbnRzLCBtYWtpbmcgc3VjaCBj
YXB0dXJlDQppbXByYWN0aWNhbC4NCg0KDQo+IFRoZXNlICJiYWNrcG9ydHMiIGtlcm5lbHMgd2Vy
ZSBpbnN0YWxsZWQgZm9yIHRlc3RpbmcgcHVycG9zZXMuIFdvdWxkDQo+IHlvdSByZWNvbW1lbmQg
dG8gZG93bmdyYWRlIHRoZXNlIGtlcm5lbHMgdG8gNi4xLjkwPw0KPiANCj4gQXMgYXNrZWQgYmVm
b3JlLCBkbyB5b3UgdGhpbmsgdGhlIHByb2JsZW0gY291bGQgYmUgcmVsYXRlZCB0byBydW5uaW5n
DQo+IG5mc2QgaW5zaWRlIGFuIExYQyBjb250YWluZXI/DQoNClRoZXJlJ3Mgbm8gd2F5IHRvIGFu
c3dlciBlaXRoZXIgb2YgdGhlc2UgcXVlc3Rpb25zDQpzaW5jZSB3ZSBoYXZlIG5vIGlkZWEgd2hh
dCB0aGUgcHJvYmxlbSBpcyB5ZXQuDQoNCg0KLS0NCkNodWNrIExldmVyDQoNCg0K

