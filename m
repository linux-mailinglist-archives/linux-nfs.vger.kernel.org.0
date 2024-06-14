Return-Path: <linux-nfs+bounces-3841-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C7D849091F1
	for <lists+linux-nfs@lfdr.de>; Fri, 14 Jun 2024 19:46:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 527FC288A33
	for <lists+linux-nfs@lfdr.de>; Fri, 14 Jun 2024 17:46:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 760EE3D66;
	Fri, 14 Jun 2024 17:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cso0pmrt";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="mR/jFPSk"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30B4D19D89C
	for <linux-nfs@vger.kernel.org>; Fri, 14 Jun 2024 17:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718387191; cv=fail; b=eKeJOPfBSH6OE6XXHocuwPBvRYyTKxSey8niyYcHZpJ5IHZfbA5sG9s96N5TUUCuTsfRxZ/SiYhSu2lkqG3J4PPFsamDQa6mtq/enGNhVZIhEuYQZarQKYPIBtCHsOqDk9IOE6Z00xFjgciLSbotoCwM3t0/Hz083uN82NYMe4E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718387191; c=relaxed/simple;
	bh=xZFOwAKE9YbvlGu7DhtDzyZ1ql/7ZbjvU5R129CVaz4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XbiM+tw9m6nxYgd7N8Cp28uiG9wqMbZV8H2Ocqhedm2JcCu1gbLcFWL5P/HDOY+sxIppHiKfNQkmJdZN1DNdoN2l+KvQX02eBcz3zzDyUCzEt2scf+Y3Ubk2NsnBRZ0L3z+kWrKsNeufX8UTncnA5+amFI6MzYKnM7m54Tz6Asg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=cso0pmrt; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=mR/jFPSk; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45EDGwWn007152;
	Fri, 14 Jun 2024 17:46:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=corp-2023-11-20; bh=xZFOwAKE9YbvlGu7DhtDzyZ1ql/7ZbjvU5R129CVa
	z4=; b=cso0pmrt4XpIQLHf9lP7zBvcKLQWiP/P0LAeyX8VuT4SPEudN0XBvhCup
	Z8Wozl3o1hdSCMRfxetRLlu0w+/YT+ZhXYVYDNs3ki9AYwihwAWm1mdPa+fW2o0/
	d1dugyosxslXBBmhfE6tCO3Grr8oCUtKKyuQSRXtM2pjyepdDO5klPsNKXMw0fQu
	iFQZuOPSfslcaWupheiYWuaPo27eSA7q4FDqAm4qYLqDXCmi+Zr4E6x4z6LdYrNn
	B3T2j9WuyJlN83cZ3xvCkeWXVI4aMS0BW51dRCxZTqWGKhelVpepAqvwPkB+DY6I
	VmesehvtbH44z06XaQOIrDSXeo9Hw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ymh19c5qh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Jun 2024 17:46:24 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45EGScdI036656;
	Fri, 14 Jun 2024 17:46:24 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ynce20mu6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Jun 2024 17:46:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UjrY60Ufjq8EyXy+yHpix7GASYn1j1ody403GvCtfTa4csDeSNUUM6RiclvFz+0RM28PSZ5pue/XpfspUMTft30ur3KU5V0+tuekIaZx/IW9cjpUsSjV31tC8wTohzHyZaxX6i7zg+wIvudgLye9Qi0h8S1BLn1QDtvJcMfjCLqrwl7zNQg7Rhb+QRwDvtD2PQymwgzpt6r3nlNdnLzmHRN4zOqqChSUcQ6pafX0dXrC0Ex1XcsicDC0gEqn0Op13vOqWbj7cMeRC2J8cdkHTuZHm2CaUD23oCtrHU2w6oy7DeP2XklHXhJpkRjACon7coCoR16928WRuQ+0WTG2oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xZFOwAKE9YbvlGu7DhtDzyZ1ql/7ZbjvU5R129CVaz4=;
 b=XIhuBRzZtiTMXCFYTgsgsBK1RgLALrvHrRdNCxHdsU8XEhI1IOqTQn0JYtIrMnive9Gs1LGrjjirdib0J8oY1oghNavEiUen85ydaub9AwopNDplDakcAvGztVQT6+p5L+jwi+EebliFGmUDhyC4UvBKUCu/AluNI9lmcOVNV5paJaO6PH6Da1YVQFHUvUoNFGbdANX3ijb06tBJ5Zgv5/uhl3biBBytzk2rUdrEX8pzBkh676Gi4Ba8wYZN+kGgVtOecFLUcK4uM/GDmRH7YH3AAhPY6fUoG/T40z498tx7cv9bMA1ig9Nw7KOHTfA2AzNUdhoZjYqUUjDv8hWRWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xZFOwAKE9YbvlGu7DhtDzyZ1ql/7ZbjvU5R129CVaz4=;
 b=mR/jFPSkDLEE2EE2gX40cGTiTEolWsOkDJYcsebJyVHp3AbYHFdJGNDXClSEVO3NqjxTu4e8hKfdMOUDiHHy4SPMNLtO6kn69tGqQDDiufWIQtjboOoBy4NCTQs5gAKiwjea7VMtXRfOpq4PynCQMLlOtODe+DQIjqh3ttZ88cA=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SA1PR10MB7755.namprd10.prod.outlook.com (2603:10b6:806:3ac::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.25; Fri, 14 Jun
 2024 17:46:21 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.7677.024; Fri, 14 Jun 2024
 17:46:21 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Christoph Hellwig <hch@infradead.org>
CC: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: reservation errors during fstests on pNFS block
Thread-Topic: reservation errors during fstests on pNFS block
Thread-Index: AQHavmmwJwrL3nOnBk+LjtpoM19XRLHHda8AgAAS+oA=
Date: Fri, 14 Jun 2024 17:46:21 +0000
Message-ID: <C02C8230-4ACA-4F2D-AC28-B9583ADCADA5@oracle.com>
References: <34F83726-2A28-4E29-A40E-A01BED7744EC@oracle.com>
 <Zmxx-H2KrT5QpJ-g@infradead.org>
In-Reply-To: <Zmxx-H2KrT5QpJ-g@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.600.62)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|SA1PR10MB7755:EE_
x-ms-office365-filtering-correlation-id: b2c792d9-55e2-497d-fa3e-08dc8c99e73f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230037|1800799021|366013|376011|38070700015;
x-microsoft-antispam-message-info: 
 =?utf-8?B?amp0TU5LYlYrTUFrS2NjM1NzUStFRjNLeU9XR3d1SkNGZnNiV2NUV1hrQ1Zs?=
 =?utf-8?B?YUh2SCtXclhpSWhPZFFSYmI3THZ2Y0d6U3M3UVo5V1FVK05Rd25WR1lYajg2?=
 =?utf-8?B?TnNwN0RzRWxwdmFaMUgySDB6NHFoTWtTblRqVzB5dGZrM0VqYXNKVXZhRklI?=
 =?utf-8?B?WFllQUR4dHQxRnA2YkE5TFcxekdaLy9hRlU0ZHB2Zm53RTExOUNNZWdra3Ns?=
 =?utf-8?B?QTdMZ2cwRElraUVuMG91QlZnUXZDK3dzWFpTMDYrcE9MWTZONUk5Q1hod2Ey?=
 =?utf-8?B?eEdKOXk5OWd5UEpsZ3p1VGdpZ1JoZE85N09uQ2plQUhjQWtTVEpMUXl3VGkx?=
 =?utf-8?B?bnltdi9Gbkp0aVBCVVlCKzFtNXRzOXpqNHhjdVdybDh6VEkvdUVmWFlqN2xE?=
 =?utf-8?B?dDFDaGNEWUhyb3dCRWtFNzNCcnYzdU1kazBkUjJUeW83ci9ab1U4eWdnVjhl?=
 =?utf-8?B?YTRadHhtdUtmSjlubE9yaWhrWlpkR2Rmc3VGMWhXakdiVEF0dXdoZTZ2K2Ey?=
 =?utf-8?B?UzB0OG9SQ0hVb05HRFNxWE5FcWl3VFhGaE93eGJvWnBRSnZMZThkZk5wcXA5?=
 =?utf-8?B?SkxvRWRaUkpvcUNFMlduMHkvWkRxVmZ6bHBsWjlGVXdLZmRVTVJzbHZBQk5K?=
 =?utf-8?B?bURralRVSnV1OWlNbnRYN1M1Q3lYczRpeXBoNFNhUVJqcE82YTZPY3cvWmR6?=
 =?utf-8?B?VnJidGxrdFlSNTEzT1B2N0RUVmJGK3B1M3lURFB1MVJmM0duVHJGV0Q5cUox?=
 =?utf-8?B?eHkwVEgrb25LZ21Ec1QyVkpDaFNLQ1MxU24rczhBLzREaWg1b0svYTM4SU51?=
 =?utf-8?B?OVlLNmpzRUd0UEd3WmRTUGwzR1NxSHBxZGhnOXpLSzZRSzkrUkhXdFJBaVNr?=
 =?utf-8?B?SnlUVWZRVzl5Nk9xc00rZy9ySmlUUlNmbDZWQkl1QTJOSU5TTW9XK21MVnhx?=
 =?utf-8?B?WmhwdFY0Z2c5YlRXYzUvd3BsaU51ZGFaRk5vV2F2RDgwcldBWnJrejd5ZmNw?=
 =?utf-8?B?c1FEQ3FjbGs3Y1hXZGJzUS9KeHhUN1Q1WkpwVVI4clJCclBIckVXUlVlMG9s?=
 =?utf-8?B?dlFhSnRVZTRROEdIVnpLYlhpak84ZGg0QVhyODd4QzNoNCtXSDgxTERGTkZ4?=
 =?utf-8?B?c2c0TXZ6Q2N6MXdTNlVtL2xvOFp4UHlsNExEY1g1Z0V0YmU1TkFyMERVTWFU?=
 =?utf-8?B?bzlJZU94RDlGaU4yeE56R0lUNXdlRW1lY3NGWDN5VEdDa093Mjc3VklTQkdE?=
 =?utf-8?B?YWlNRS8rZlJheU1kMDV2emZ1c1cyU3Y5ajI2SGEvQTFka0JJangrY0ovN0Fk?=
 =?utf-8?B?dFpsSzNkVVFGRjNCdjFvS21pZ01TMlgrY1NHSmFxdVJBUWxUSituQzBXWXQ5?=
 =?utf-8?B?enUvZlBzcGpBUjZlQmp1SlREVjJMMG43SkRhVjZ3M1duNDFCLzVnQ3RWUXdn?=
 =?utf-8?B?THZWenExaHZMM1RadFNxemxoMEh1TC9mbm1MWXlYaWVsZHVTSHJsQ2NyMGRS?=
 =?utf-8?B?bEN1a2RLUmRqT2dYaWprVzhNT0FGbHdjV2hndmx0OTJFRERETzJIREFHTnJD?=
 =?utf-8?B?RnNKZ2w5dFVadHFFa2tDaWxTSzVtc1U5Y3l0d0RBM3djT2V6V3FNMkVkSHVx?=
 =?utf-8?B?aGc0ZElJZTI0TGlQbGQ4QWQwSFRucmMrU3lGcERxTU13bjdIVlFTSWtMaXdF?=
 =?utf-8?B?S1VKY29KTXdCM28rOWExNUprQWdnaHVZdml3TmdsQWxyWlAwZnFSSUJTR2VY?=
 =?utf-8?B?dlFmSUx1RytoYW12Y0FpbmZ0NnRmekZZWHArWjNSOUhnSU9xSDZGNVp2Yyt3?=
 =?utf-8?Q?A5dHztgU0A4RHHAsiHJ26V+fJ7KmdeRCJtuiI=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(366013)(376011)(38070700015);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?akhBMFZOUmx5a0g5YWZnaUgveEQyNUZNZi8rQk9ndk9EemRDMTJMTHVGMWRz?=
 =?utf-8?B?dEk5U0lvZFpVdTI1WHNyZDBabXNLNm56Y2FYUklHSjFnT3VnV2ExZlVzMCtL?=
 =?utf-8?B?Ni9XMGV6Y09WZ3R4NlEweWFFU0xabU50bU5OblVlS0VzbzdVNjF4TXRVQ29V?=
 =?utf-8?B?bmZLTTRNM1B2VnJER2gzRVRGa3NoR0tFUjNpZVl3MGNHZmg3WXliZWh1Y2lq?=
 =?utf-8?B?RmRLSnk0cTJGTUJOckloKzlFM2RPVUlQbGd4Vkt6TndDMVk0RkZ2WTNXenJ4?=
 =?utf-8?B?RGphWmt0Q2NMdTdlbVZFaXlsUDRUQmNwdEJHZ0s1SVBxVW9zUEgzVENhSkp3?=
 =?utf-8?B?UUZna3dkcVNXNG9Zcy9aUDk1UktML1h1QWlTMTM2WFZpcHNhMG5VbUlJV2d6?=
 =?utf-8?B?TVZpei81a1lYVW9TOWlvMXcwamwxOWVUNTJSVW5pVmJpWkRuYmpxTm5aOWlU?=
 =?utf-8?B?a1N5RTN0Zm1iOG5zcnZPNU1RbGEzcUhIT2Q4Q1dGcXNkUFdCY2tQeHE0Z0pW?=
 =?utf-8?B?T3MrWWhOb0NuN01DMDFOVWNHNzE3WS9TbWlHaWNSK3VXaUlScHFMYmE2STJG?=
 =?utf-8?B?Q0pxaVBOUG1ONWVwS1VpYUd2QTdtK2daMHJ0NEw5ck12ZlZrK1BaTjZDd2hj?=
 =?utf-8?B?b29UVXppNGpsa0tJSjlScnNVaTRpY3ZvVVl0azlTNzRMSFVQdHVycXdrckI5?=
 =?utf-8?B?OFlEWDdqRmxDU3ZkQ1dSYnNKKzZOME9nOGprUWljWUlrU0NtUGM1bUUybWtE?=
 =?utf-8?B?eFhhbmVVVXByWmFNeE9QMnhPOEVPcThaZWxoNDZZeW54K0kwWVVhVlgrQk56?=
 =?utf-8?B?ZmRvOG9OWEtLN3JwR2FkVExKb3A2VkFnQisvU216d0RDek5uaTQ3SEdvOUty?=
 =?utf-8?B?Y3N6QW4yTTBtalRUa2FGNzVDWnNBVHA4Y3NldU9xSHdUd0hDNjJla3hINVNt?=
 =?utf-8?B?d1dYQVQ1Y0VzYzRsNE9DWDE0R2x5TGVMcnptS3M4dU53TmFjdmZCWGI5TjJl?=
 =?utf-8?B?bkpUR05wc2xESDVuYzEyeTF6dllSN3dXUXhOK3dEcXpZQkEvUXlqUE5mbklv?=
 =?utf-8?B?cVc2eVNqWkxCcUFlbmlSdjI1K2ZZOEtQNUlDS3gvMDU3dWJEUzlLbkZ1YUZv?=
 =?utf-8?B?UDZoZlZYVCtWa2ViWTFFaTFxbzFaUDJZVTJ4d3BFeUhBNWhiWCtXSFAvRGFw?=
 =?utf-8?B?cjFocVdnQW9tbTBDejhCZVdFRjhTT3dHenRLSGlOZElCUWtYOU1ZeU5jaXI3?=
 =?utf-8?B?anZqbHZRenl0K3VQUHY4UnVCNHJNV2pabWFhTkhMcXdsTHcwMWVyZitNL0NG?=
 =?utf-8?B?SktWeEhxV240ZmE0dG1BZy9rWnJ5eWpOWHRqUXEwaEE2YzBBU3E3WEpZZWdX?=
 =?utf-8?B?L285VXViTi9FZHhCWFJ4TWNWWVMvTGFoSERZeVNGczRPYTI5cUFPL05OYVI4?=
 =?utf-8?B?cER1UU1aQTNUajMvM0hJK21zVG10em8xaVRCSTV6MFE3ZmQ0ZG8rL0VYWEIy?=
 =?utf-8?B?NUhFZUlrRWRlK1Y3RXJpSzBGYkVYZHdHcUZhbTIvNzJkaTVWZmJKMDJFZ0E2?=
 =?utf-8?B?RkdMbWs4ak85N2U2NXlUZWpkV05UTXBPM1RIS1N4bkdQZkR3Qm4zWndKcHhN?=
 =?utf-8?B?cHRGZmVpdGE4Y0VqekF0WjBmNUNPd3NIL2JTS0I3SnAvOVg3TFlsOFM4Wmxi?=
 =?utf-8?B?QUVKMjhYZ1h0QnhlL0R0QUl6UDQrTzZhMnNwbDR2Y09HajFsUmFGNEZ1dVpN?=
 =?utf-8?B?RlJZaWwwdlZVOWtUQkJwVS91RFpEdGZlM1VGT0pCeU1TTWNESlkyQ1VoRnhj?=
 =?utf-8?B?Z2VSNUdXd0ZYbHFyZDRZVVJsOEZCckNvYmRTRG4zbStTelR3a1hEazdzalc0?=
 =?utf-8?B?VVR1dnVSMnNlSGRoajFLYjRMQ3RMUUlSaEtiZThJb2FqWEoyV202Tjh3MXdI?=
 =?utf-8?B?TElMakg2NVhCc3QxcGxYL1pncEQ3YnI0anJnc3VDdnZqamVpbEpsaXJ0OHJo?=
 =?utf-8?B?cEdXdXQ0NFFWL0ovV3laaTlPS29WNWRtdmRicEcrbU9GQVdycHlBQjhFSGw3?=
 =?utf-8?B?bVN5cm1vanRkNTJUMlNpYmNUc2UxYjhhQkg0U3NHV3VHRmhHNFRMRlNNOHg0?=
 =?utf-8?B?SlN6SFZaZ3JVNXVSUm9EQ2hrQVdtN2k2RnF4TEtYTld4VWRpMDcrVXMxODRU?=
 =?utf-8?B?UWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FA69C943EF58FE43A5B42C365CFCEC8B@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	Oqqd82xQ7kFjcUg467us47yg6u8l7X3zd6nlvOpz/iL5rfXzT3aPFrVsiXWJA/J4xzDUBh1VC8Cz/jUjwoxetJRStciVk/PSEUYHRPTlCZV/mIqHXxRRO3AFF0buow+Kqq8cerqFxhSTof02FerQtpnPsh4d3BSZ/jmVlD41he9MbnEcWra/hFKwM4nbcAwOiS68HWAZ30D01z2M9XZAFq9gFM1ltH5bw00DJ21BflJgRT4yhIQrN8Mx5WUEGZmH3HAHr9Y5jL/yfbKY2sI4Egc83YvJrQEKX3533xWK8FdDWZiwaaSMv6vzHctur2hSC/Xxl5l9LCBBVfikBJQCQvr/Z91D0skQf6zyfWqqQ+1fDd9kKq1R0DySeqz96/qGWEruGZbhVQ5SmAvyyRvPpkAWCCJ6+NeCXR1yEgGKN0DH8H24o6TfMmwgvDv5WOnoFyi0A2ZoqtFvzuZP71ecfRLjYf30SiNJCzNSOiq1FQxmu6YMn48lIBMrrUL0AgPffbz+NLzySgMc3Qk48GKvAjwOy6If76h/ECHEPpInXCLCQmJyu9Jj1eoLbkkP1hTqIpoTcI/ypPnN8wzTcvIEP9IL+o2TD1rLddJMEN770Vs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2c792d9-55e2-497d-fa3e-08dc8c99e73f
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2024 17:46:21.6800
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sDiAp6Dy1EVfCUxft30qvrHv9oK20cNicFDF/SvQMNvBn1u58mk3sWQPHGa1p98ndvVn10GNdMFPfuNfYJtSOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB7755
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-14_15,2024-06-14_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 adultscore=0
 mlxscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2406140121
X-Proofpoint-GUID: BZqfnZcY6zqJVQDqhYs70z0EELc44kjE
X-Proofpoint-ORIG-GUID: BZqfnZcY6zqJVQDqhYs70z0EELc44kjE

DQoNCj4gT24gSnVuIDE0LCAyMDI0LCBhdCAxMjozOOKAr1BNLCBDaHJpc3RvcGggSGVsbHdpZyA8
aGNoQGluZnJhZGVhZC5vcmc+IHdyb3RlOg0KPiANCj4gT24gRnJpLCBKdW4gMTQsIDIwMjQgYXQg
MDI6NDY6NDlQTSArMDAwMCwgQ2h1Y2sgTGV2ZXIgSUlJIHdyb3RlOg0KPj4gSSd2ZSBmaW5hbGx5
IGdvdHRlbiBrZGV2b3BzIGFuZCBwTkZTIGJsb2NrIHRvIHRoZSBwb2ludCB3aGVyZQ0KPj4gaXQg
Y2FuIHJ1biBmc3Rlc3RzIHNtb290aGx5IHdpdGggYW4gaVNDU0kgdGFyZ2V0LiBJJ20gc2VlaW5n
DQo+PiBlcnJvciBtZXNzYWdlcyBvbiBvY2Nhc2lvbiBpbiB0aGUgc3lzdGVtIGpvdXJuYWwuIFRo
aXMgc2V0IGlzDQo+PiBmcm9tIGdlbmVyaWMvMDY5Og0KPiANCj4gUmVzZXJ2YXRpb24gbWVhbnMg
YW5vdGhlciBub2RlIGhhcyBhbiBhY3RpdmUgcmVzZXJ2YXRpb24gb24gdGhhdCBMVS4NCg0KVGhl
cmUgYXJlIG9ubHkgdHdvIGFjY2Vzc29ycyBvZiB0aGUgTFVOOiB0aGUgTkZTIHNlcnZlciBhbmQN
CnRoZSBORlMgY2xpZW50IHJ1bm5pbmcgdGhlIHRlc3QuIFRoYXQncyB3aHkgdGhlc2UgZXJyb3Jz
IGFyZQ0KYSBsaXR0bGUgc3VycHJpc2luZyB0byBtZS4NCg0KDQo+IEVpdGhlciB5b3UgZGlkIGFu
b3RoZXIgcHJldmlvdXMgYXR0ZW1wdCB0aGF0IGZhaWwgYW5kIGxldCB0aGUNCj4gcmVzZXJ2YXRp
b24gbGluZ2VyLCBvciBzb21ldGhpbmcgZWxzZSBpbiB0aGUgc3lzdGVtIGNsYWltZWQgaXQuDQoN
ClRoaXMgaXMgdGhlIGZpcnN0IGZzdGVzdHMgcnVuIGFmdGVyIHRoZSBzeXN0ZW1zIHdlcmUgcHJv
dmlzaW9uZWQuDQprZGV2b3BzIGxldHMgbWUgcHJvdmlzaW9uIGZyb20gc2NyYXRjaCBiZWZvcmUg
ZXZlcnkgcnVuIFsxXS4NCg0KDQo+PiBCdXQgbm90ZSB0aGF0IGdlbmVyaWMvMDY5IGlzIHJlY29y
ZGVkIGFzIHBhc3Npbmcgd2l0aG91dCBlcnJvci4NCj4gDQo+IFdoZW4gcE5GUyBsYXlvdXQgYWNj
ZXNzIGZhaWxzIHdlIGZhbGwgYmFjayB0byBub3JtYWwgYWNjZXNzIHRocm91Z2ggdGhlDQo+IE1E
Uywgc28gdGhpcyBpcyBleHBlY3RlZC4NCg0KRXhwZWN0ZWQsIE9LLiBGcm9tIGEgdXNhYmlsaXR5
IHN0YW5kcG9pbnQsIGVycm9yIG1lc3NhZ2VzIGxpa2UNCnRoaXMgd291bGQgcHJvYmFibHkgYmUg
YWxhcm1pbmcgdG8gYWRtaW5pc3RyYXRvcnMuIEkgcGxhbiB0bw0KY29udmVydCB0aGUgcHJpbnRr
J3MgYW5kIGRwcmludGsncyBpbiB0aGUgTkZTRCBsYXlvdXQgY29kZSBpbnRvDQp0cmFjZSBwb2lu
dHMsIGJ1dCB0aGF0IGRvZXNuJ3QgaGVscCB0aGUgbWVzc2FnZXMgZW1pdHRlZCBieSB0aGUNCmJs
b2NrIGFuZCBTQ1NJIGRyaXZlcnMuIElkZWFsbHkgdGhpcyBzaG91bGQgYmUgbGVzcyBub2lzeS4N
Cg0KDQo+IElzIGdlbmVyaWMvMDY5IHRoYXQgZmlyc3QgdGVzdCB0aGF0IGZhaWxlZCB3aGVuIGRv
aW5nIGEgZnVsbCB4ZnN0ZXN0cw0KPiBydW4/DQoNClllcywgaXQncyBhIGZ1bGwgcnVuLiBnZW5l
cmljLzA2OSBpcyB0aGUgZmlyc3QgdGVzdCB3aGVyZSB0aGVyZQ0KYXJlIHJlbWFya2FibGUgc3lz
dGVtIGpvdXJuYWwgbWVzc2FnZXMgKGllLCBQUiBlcnJvcnMpLCB0aG91Z2gNCnRoZXJlIGFyZSBh
IGZldyBzdWJzZXF1ZW50IHRlc3RzIHRoYXQgYXJlIGFsc28gd2hpbmdpbmcuDQoNCg0KPiBEbyB5
b3Ugc2VlIExBWU9VVCogb3BzIGluIC9wcm9jL3NlbGYvbW91bnRzdGF0cyBmb3IgdGhlIHByZXZp
b3VzDQo+IHRlc3RzPw0KDQpnZW5lcmljLzAxMyBpcyBrbm93biB0byBnZW5lcmF0ZSBsYXlvdXQg
cmVjYWxscywgZm9yIGV4YW1wbGUsDQpzbyB0aGVyZSBpcyBsYXlvdXQgYWN0aXZpdHkgZHVyaW5n
IHRoZSB0ZXN0IHJ1bi4NCg0KSSBjYW4gZ28gYmFjayBhbmQgdHJ5IHJlcHJvZHVjaW5nIHdpdGgg
anVzdCBnZW5lcmljLzA2OSBhbmQNCnRjcGR1bXAgYXMgYSBmaXJzdCBzdGVwLiBJcyB0aGVyZSBh
IHdheSBJIGNhbiB0ZWxsIHRoYXQgdGhlDQpQUiBlcnJvcnMgYXJlIG5vdCByZXBvcnRpbmcgYSBw
b3NzaWJsZSBkYXRhIGNvcnJ1cHRpb24/IEkNCmd1ZXNzIHRoZSBQQVNTIHJlcG9ydCBmcm9tIGdl
bmVyaWMvMDY5IGlzIG9uZSB3YXkuIFRoZSBwYXNzL2ZhaWwNCmxvZyBmcm9tIHhmc3Rlc3RzIGZv
ciBwTkZTIGJsb2NrIGxvb2tzIGp1c3QgdGhlIG5vbi1wTkZTIHJ1bnMsDQpzbyBtYXliZSB0aGlz
IGlzIG11c3QgYWRvIGFib3V0IG5vdGhpbmcuDQoNCg0KLS0NCkNodWNrIExldmVyDQoNClsxXSAt
IGh0dHBzOi8vZ2l0aHViLmNvbS9jaHVja2xldmVyL2tkZXZvcHMvdHJlZS9wbmZzLWJsb2NrLXRl
c3Rpbmc=

