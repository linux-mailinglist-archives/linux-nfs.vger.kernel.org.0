Return-Path: <linux-nfs+bounces-4037-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 91C8990DFD4
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Jun 2024 01:26:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C2E11C22D67
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Jun 2024 23:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B98023759;
	Tue, 18 Jun 2024 23:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="W49J0Vn9";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="BJU1TFn2"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6890918C3D
	for <linux-nfs@vger.kernel.org>; Tue, 18 Jun 2024 23:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718753208; cv=fail; b=b2yW93nNexdrn/eALyIreiS7Un0nYlv88MESyiZDMS46sLD1j1xSqI1MyFWxzOs7cOdylxrPaQ6v9+71K5bGng/Y4tFD8ps8fpuhdlwloiWFoTC9ZPVvaow7xkBnkXq+OcT10V1vqq3w3r3FqpcmUnT2F20TnfFK40LNa70rU8Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718753208; c=relaxed/simple;
	bh=JO4apm464NciZ5M4a+ameddU+kyHT8iTeVlO0ATOLnc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cQeUv6OLI/GLtk9mLa2ZPsFjD8RxUf9lHVcJPHl5+wuJBbZFsC1OJMJV/rPffdItL9Ttihc1MPsieYvtyGupC8dxHxPubFcKHVfaPEURW3TEnMlkEnGHjAiAcIb+ScBGrUvPgzhWpB+VXCLZ4DQCMByqzfI0hzSQ+jO4TWnCHc8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=W49J0Vn9; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=BJU1TFn2; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45ILal5T011034;
	Tue, 18 Jun 2024 23:26:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=corp-2023-11-20; bh=JO4apm464NciZ5M4a+ameddU+kyHT8iTeVlO0ATOL
	nc=; b=W49J0Vn98kFGFvxo4WnBgTEsrIGC+H3Wyp8MJ/OlvVe7ahXU1rDH+9a2i
	pBi42GFiO8zg1K7d4ugpOjoInrzQl9qHX7ReNCGco61Ae/D4s3RmGn2+Tny0wWxP
	cBYBPUIhENKDEMD9q5jtiKbhmHEgbtEn3bCR8KsqDxPXaj3STEKNsqOlTB5qPys3
	ooUsQwLx7IRDZYZRvqvukhIr8lPTUn7tJI+vR1s1y2NnbymM1AIS/F1IEED3uq+F
	StR6+Uo6vJEJc72bsbMJJP9PbuHGxqiZLJ2/7J70myaOmBJizMqyPUHGlv52bcoB
	VjVi8xCeadYr/Od9H5+o/7lX7pH4Q==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yuj9n83ky-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Jun 2024 23:26:38 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45INEQoD034587;
	Tue, 18 Jun 2024 23:26:37 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ys1df3ka4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Jun 2024 23:26:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=btu9xvC0e5Jc4LdPJwgXjjzKkPFhsm+VerpxAZpJHL+wLM/CKGwEVMGH5tdRcS06WnERHwyKGd8TBn9TbrJqw82/gHwtXxACGUq+/w3q/dDAyM3ksMqmjgUeJ2fOP2UIlRU0TN4vkJpxEFNCHkcdat97V+gC/WHYmmIf6XWebhUcXxSoLxmZfG0n+/Qhj2MCDKCZ4DiOixl32JBzqkdt4mZiA6/Wg8gLFLKq2AqPRa14TChoBG5N0GPrOzklmQye3PbJ46Awj1jhMzEhYGMKo+mdCWh3WgV7NYRSdHF1F0xI/Js1dunVyPMXHU/dk3rK/5BqnYxPeuzI608ndJI1zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JO4apm464NciZ5M4a+ameddU+kyHT8iTeVlO0ATOLnc=;
 b=iwWzSa70xfoGffs0+5NS9t2H5wyD3p71HndKipv9JUXruiLSgV+h/GH2h49iwx6xRgGbgj3OWRSaYukfnDUzlywSO/1p0G9s1iUtQZC+cRxDvwQ1seYVwTikQZqBkP5QKH7gFIy+xWn1Fn5bATEyWykJD/0A5J0kzPO8acpS9F47+i4VCH41PWI8ATkfIfRGtYkHjklQBMrJ9v3AEoOriw6Lfdv9KSt9EIxOtVEyxKq+9KdC+rdTeTKgSa2g6o87BWge2VLki9XdOcUSRuV6GlSdXN4vDkAowbTmj9cgfJXKbJfSDGlKUB+u0MW/f5KNPiBMZlhL5SXy4MqKq8HDJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JO4apm464NciZ5M4a+ameddU+kyHT8iTeVlO0ATOLnc=;
 b=BJU1TFn2uMmNM0aGMi9qEPjZNQqMxYiynh1cRAE5tdDziWGYW+kJ9baZlcylHxu1ndJXbSOWXoV8atr6w7ULL9+e1gRvxCQVAJ4rxOezQcvPnT662yJ5OOI12iBlhejcZTcxZq8iNfRFWXAtSZI/7QCoa+Ce0gdO3qr4Wnx3S0E=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH0PR10MB5562.namprd10.prod.outlook.com (2603:10b6:510:f1::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.19; Tue, 18 Jun
 2024 23:26:22 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.7698.017; Tue, 18 Jun 2024
 23:26:22 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Neil Brown <neilb@suse.de>
CC: Jeff Layton <jlayton@kernel.org>,
        Trond Myklebust
	<trondmy@hammerspace.com>,
        Dave Chinner <david@fromorbit.com>,
        Linux NFS
 Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: knfsd performance
Thread-Topic: knfsd performance
Thread-Index: 
 AQHawa3dybcUo3ed40e1woBUDQls6LHN2rIAgAANu4CAAAKdAIAAAygAgAABH4CAAAY3gIAAMnyAgAACcAA=
Date: Tue, 18 Jun 2024 23:26:22 +0000
Message-ID: <E14A0A67-71C7-4ED7-BE4E-525A186B876A@oracle.com>
References: <87354accc0d1166eb60827c0f8da545e0669915b.camel@kernel.org>
 <171875264902.14261.9558408320953444532@noble.neil.brown.name>
In-Reply-To: <171875264902.14261.9558408320953444532@noble.neil.brown.name>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.600.62)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|PH0PR10MB5562:EE_
x-ms-office365-filtering-correlation-id: d9ca3b27-ee1a-4bda-714e-08dc8fee10cb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230037|366013|1800799021|38070700015;
x-microsoft-antispam-message-info: 
 =?utf-8?B?NWR0ZmtHVEVWL1dxUnY1TTZOeS9KcjVDSnEwam1JSnYyVWY2dXpyV25xaFJm?=
 =?utf-8?B?T1RRYmFjV3pRdUMrNnMrWW1waE9vRjNHN284NTlKSFYxQVoxVzBJU3Y1SDc4?=
 =?utf-8?B?S2JrWTF0NGxiTkNXWGZ6c2QreWl2ZDFyalgrZUI2VWNqb1JJOWxBNFAyZjhN?=
 =?utf-8?B?TTlwWDFwcGVJajh4SXVQRjMvbUJkVTdRYysrb2ZDRXNyaUxZOTFHQmlGcTkx?=
 =?utf-8?B?U0xocWt1aUUvQ3d5RGNkUVpzRlU5WTVYd0JZWlFWM1c1OEVEcGRrWHJwQ3Nx?=
 =?utf-8?B?bVlvYXFRa2w1TjA2T0tqN3BEZVRjZHlWZ0JrUmI5VER6aTFRNTlqcGZ5TUwv?=
 =?utf-8?B?TlFqanUrZ0psK0tVK2xqWnZkU3d3OUt6ckF6WmNzM1N3cEVBY3E4dXdJd1ZJ?=
 =?utf-8?B?U1lYbFVYUmNBOWdWeDdJNm9HLzVhSUtFZVJWc1NaU2FzdnNrTk5tVlU1UUlj?=
 =?utf-8?B?aHpMVmtybnQybmFoUStuZERTQWdZSnliWGJuT0lxaFlXNVNwQzNLdFpPZjg0?=
 =?utf-8?B?OVFjbzRpMENzUVdUcldPZ1VxalNDb3JYaEIzR2I5azRCMmxvUkV5S2pNRDNI?=
 =?utf-8?B?dDJTbTBreUdPR0NRNkJxTVFqSXRPS0dXWGJ5N0VmMThlNGxNd3JHeHNXMlB6?=
 =?utf-8?B?djhiQWJOL3hxSU42V1IwL0JpbHBkZkRralcyYXVjczRrZTcyVDlGd2g2QUE5?=
 =?utf-8?B?TnowRzdVSlN1VjAxZ2FKbjdJbXhBUWZXU053N21FR0RScE5vZVZMNzgwc0FU?=
 =?utf-8?B?b1c1WlJXaXViL1VKS0VBWUE3R2ZZbndMZmNaWUdKNkVsWjI3VVFpd0wyRkg4?=
 =?utf-8?B?a1N1QTRMYWttTlpScG9vWU1qWWJjWUtzOGNuamhURFlFRzF5SUNrY00zKzNU?=
 =?utf-8?B?bEpKRytybGZwdnN4U3MxVGJMSHVBa2ljdkFIQ3BZYXpVcGp3YnM5bUVyd20r?=
 =?utf-8?B?cUdiRVJNVzJKaGJyeTNyNmlNTVlVajV3cGtRZ2RSbmNSeWVlYmpETmY5dEFO?=
 =?utf-8?B?V1EvTXhnYjJEOGFpVXdGRDhKTFpFNTRYTlZMR0R0Uk9uUEg1SDRDd2JIcXdx?=
 =?utf-8?B?NVEvWVJWWTBrRldjQzVHdzRsU3A0TWlsQm9rK2k4TE9VVjV5VEVFZ3MxMnA2?=
 =?utf-8?B?aEZvc1N3eFJ5ZWNXU0dwaDViYnVYUXV0VmRZVmJMeEc3MitkSS94TXhQMi9s?=
 =?utf-8?B?cTNhdXFKdG9FZDVUUlpvL2grSzNIcFUySnlPWTl1dER0MXNXa3EvNWVWbWhB?=
 =?utf-8?B?TE5NM2E1OWxrcWpSd1hZV2lNdUxOVmZMcVZFdW9FdkxWS3VLNzBFMGRycFhO?=
 =?utf-8?B?ODNMRXo1ckl2aThIaXJIZFBreG9IYXJRcGw5RWlteU5JMjV2MGNEeXBYOTRy?=
 =?utf-8?B?eUxOY2VXY0pYMzdWQkwrSEZMeUkxY2xCNDVBVHlTWlFnM092NzhkR2EwVHRh?=
 =?utf-8?B?VktCTFE3NVBSMzVqSXpnbnR0aWpPMU9ReHlRZHFkNTJPUml0V1FRdDJzWG1p?=
 =?utf-8?B?bDJkd0tQVUZzR1g2TkhuUmpBd0Z3bWQrcDNuQVV3OENBd1oyaHN3ZVBKT0dn?=
 =?utf-8?B?UlFMRFpPdGltY21IcGtxUG9QVjEyWVJnOEIrWjBDNUY0NHZkL092c2ZaZGpk?=
 =?utf-8?B?cVlXM0pQLyt4cllkYWVad2ZKemtnQllHY3YvRDFaWHNRdEh6VlY2bTIwZElv?=
 =?utf-8?B?blUxQks4TmdTclZNMjUrbmZFbisxMHhxcUtuZlB4Y2RzVGlDL0xEU2NHeHhk?=
 =?utf-8?B?MXR4OXRWVFVJT1BiSGNhV2xwdGNpZWg3TDI0MkVNdW5UN0xDUEhNVW0vVFlD?=
 =?utf-8?Q?SjnNv6UjQ03fFWg3dd/FD/Vtp+zsx6Ydxw6LU=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(1800799021)(38070700015);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?TDFsanFkSHFpb1l4SW9LRGZiQzFwaHdRTXliZDNiWHZKUTRwSEFaN0k3amdz?=
 =?utf-8?B?c1hLZ0QzbmJPUlFNc1hqckhyZUgrZnFyVjljSjRZK1ovVEwwcWx0RFI0YmVP?=
 =?utf-8?B?NUQxS1hscTRGZ2ZGVnR2VWV0WTR3QlRVejRybnJkaUJMYUZNaGV1TnAwL1ZC?=
 =?utf-8?B?OER2OHpQVzQ1dGw2Q0NLVnE1Vml6WjRQcW1TTC9zVjlSQ0FtSjFIMHRieGJQ?=
 =?utf-8?B?aFRhYmJpRWhxWmFFTHBoRkRDZ1liOWxLQ2Z4M1htTjlVc1N1eUV4Z1FBR3ho?=
 =?utf-8?B?MUczZG4zN3JYT1gweGl4OTZuMW1NR1EyZVBUYjRMM2hZcGxBK2dnc3FGK2Zv?=
 =?utf-8?B?Q2dQVGNJckdVUG1GUGQ0YUpJZEJnL2QvTndpOC9zV0dGZ0RqQWwxQS8zbVhJ?=
 =?utf-8?B?eU9waklnSGtTM29FV3NsTHl0S205S1pIU1NwNjBGVUJvZkJXcG1wZERJb1dn?=
 =?utf-8?B?Q1hBUVQ3ZTJ4VXpxM0RueTVzUllnNUtDK3NqQU9OOHl6WmxycFNMMjZVc1cv?=
 =?utf-8?B?TnNRSm9OYS9aV0t4WlJCSlYzRkNKZktJMUcrKzc0azRqdUVEYUhoS0p6ejl1?=
 =?utf-8?B?T05BMkQ1bmh3cENFbDlZajNDM3hFd3ZzTm1TQVh5Wmorazg3cmFXVjJkMExT?=
 =?utf-8?B?dVdSZlh2WFdwOXlYRHBzNWxPdzVLU3FXd2NKamRpdS90YzE0TEdkZnIwTWJv?=
 =?utf-8?B?OGxzdnVJaEgvYWVMbUU5U2pVRk8xK1ZqSGlJcFN3cWNnTlVuS2FnbmNTdk5w?=
 =?utf-8?B?REdBTFdZcE9rdnArb0N5cGxzQWJ2aE11T1V4Wk5xWXM2MmFZdzRjQWdSSFZJ?=
 =?utf-8?B?SWVjckgvLzk0ZFNLVEkvdUR6cEFPWGVVMDVQY3NyN0pEVFRGeXRxeTF2S0JF?=
 =?utf-8?B?OVFCQ2hKL3lPQitqSVRDWjViaGJlbS9iQ1VmWnRIcUJYWEZjbHpwRnIzRThy?=
 =?utf-8?B?UE0wWnFieWcrYjVSK2lka2lmRHo5OU5lOWtRMFZSTFBTdUZPbGlSWHppcjJl?=
 =?utf-8?B?a0l4dnJzazFRN2RDazhweUc3UllJcFJJbnN0RWY2SU1Xb3NBVEV3WUVPZ05W?=
 =?utf-8?B?b29aL01TRXk5c3JYMzBDZ0U4cE5pMitxSk5BN2FWTWZjZU03OTBhSC8rOE9Q?=
 =?utf-8?B?UHZEQlJDUWtDYlUxc2VZeVkvcFdRQmR0TGFJa1BYdldnS3dwNCtHNnpvYjAz?=
 =?utf-8?B?MWVaY2VHZTJ6c2RDeDB0M0FPbWtLc3dzNmlmdUN4d05OaWlRWDBYc054VUZh?=
 =?utf-8?B?RXUzSUdLVUw5Rkx1WUlMVko5aUV6cTdMRHkyWGdqOXJMMkN6RDlCS0x2cWtq?=
 =?utf-8?B?SmpLR0lxUkhFWnlENSswcWtQM0dwcXdnSkhtcUpjbUxqR1g0bG5scWRkMnFJ?=
 =?utf-8?B?S1lVRjNvM01NTk5VMDJHRE1TbEpuMVQvNVRBVzBxNEJVV0dENWlSSjdzNzZQ?=
 =?utf-8?B?eW5GMjR5U0NvdFNTVGd0M01GNlp2cC9vYnlTRFZ5eG9sdXZBdmZycTBycUM1?=
 =?utf-8?B?b0VYOUdaN3FKYkltTWQ2YlBnNUZjR1k5eGJRRTMyQ0lQSm10a2VqUVlQL0lF?=
 =?utf-8?B?ZnVmR2ZNQldjcmxTN1EyZk0xT3RQZ3JnUDBxckxFSWhIb0NYRFdpdjZyYXBN?=
 =?utf-8?B?dU44VGN2VTBrYmg3N1BFMGJ4Z1NYWTV2Q0lCcHp3cHVQeGcxdjlSU2dxeUt1?=
 =?utf-8?B?OWs4NHNtUFUyK3c1ZmwzMEoxM2pHWlp2WCtDWkkybWp4NTZQazFHdEhhNUYw?=
 =?utf-8?B?SmtSaXhka1RTb1JiQ0RwYzR5K1F3THZNMGhKZU5UN1gwS2VpTjdzQ2hveE9q?=
 =?utf-8?B?UU1EUGQ4eVJmMHZjczhwOGZOeXFjTEprTGNCV25FMUFkRjkxNW9neWtPRUJh?=
 =?utf-8?B?b1lOREJCcHNzZ2x2SHRLbG41ejRNbGJZa2pUaDU5L0dkNWJrZlhHL2ZtcUpp?=
 =?utf-8?B?NEUwdytacWxra20xZERYdGtBNmdvSGlBZVlBeXVWVDRNTkdJMjEzMXFyQ2lY?=
 =?utf-8?B?VzNUV0JWcE1DNVdxZlhZbG9PN0ZnUWV0TUpQZFZuZTR4Sk1XaS8xdE1nRzVy?=
 =?utf-8?B?WDN2bVZxZitKVS9uYnpEaVhtUDkrWXdTRnR1OHNZNXlWMTgxZDFWWnZZRHB6?=
 =?utf-8?B?MkxrUkV2aWJCTkg1VTZHMGFUVGx0a3czd1ZWa3B3L2R2TDBKRlR6SWdIZUEr?=
 =?utf-8?B?Snc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <49CEC93508AA504EAEE1D551D55256A8@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	OJOWjEMMKRFVxzlRVpyYMQErZi+nElY39lQ3t1Dv0iflZf7TsMxtnKQUWS78Y5ek8oDXHPY5x34HzL4GafDkNiuhq3NHu9DcuYpGWgk+f6pLh6UsfsOLRgb9ChrVJAACJzBm2zPJF2WDj2wjqK3jvmWvCQxxBJK9N6fWCHhxfJzQW2hNXwkTxuXm56/0ZJJZ588PgvH9b8KVO3z9RokFRHdoEV6yx8kGHc+w9IbHXb469Zv3MFvDLFi/RlW6VO+Jh32ofy4aGiNOTZn/coV9kgki0/GpFbg1ziadgvE8Tqscf8J/iSdZErP0bs0K84z7LCUWhoPHnsuMH4CJe/rha+6VE9sfufrpHwqLS6oFYS38BDCCkCTQlM27izvzT3cFlc8JYqY6lTaT1fE1drvzdjkeiHx+s9X7dCMgI4v4cynfseRK92SgYaEGj6R9xnrE1/Vocrps8ytDpPz26UKMXZcsZUMikh6bmM2Lu3kZtJbHB0ncbGel699aZQfQspY66KDp9kR50T1eTjtBQxqIqQ++KqRI4maN/F9BAQzjBN9oa7yH96hxO7j1S2Z3VAClX8XGSI8KPysP/1PFv7eWLvOeKxx2wX4r68UGPYeHDic=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9ca3b27-ee1a-4bda-714e-08dc8fee10cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2024 23:26:22.5920
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dueQ9sMQIXZPtlxy0ndSxZz0kpVHJVuwkzAzKsUnM7CvOsNzr+K9h8oGzWAkEcK1OVALwP3PGpcS0KzAQLQ/+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5562
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-18_06,2024-06-17_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 mlxlogscore=999 adultscore=0 bulkscore=0 malwarescore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2406180172
X-Proofpoint-GUID: QighXp2mJ2whMBWtzdv6asV9omuJLGqT
X-Proofpoint-ORIG-GUID: QighXp2mJ2whMBWtzdv6asV9omuJLGqT

DQoNCj4gT24gSnVuIDE4LCAyMDI0LCBhdCA3OjE34oCvUE0sIE5laWxCcm93biA8bmVpbGJAc3Vz
ZS5kZT4gd3JvdGU6DQo+IA0KPiBPbiBXZWQsIDE5IEp1biAyMDI0LCBKZWZmIExheXRvbiB3cm90
ZToNCj4+IE9uIFR1ZSwgMjAyNC0wNi0xOCBhdCAxOTo1NCArMDAwMCwgQ2h1Y2sgTGV2ZXIgSUlJ
IHdyb3RlOg0KPj4+IA0KPj4+IA0KPj4+PiBPbiBKdW4gMTgsIDIwMjQsIGF0IDM6NTDigK9QTSwg
VHJvbmQgTXlrbGVidXN0DQo+Pj4+IDx0cm9uZG15QGhhbW1lcnNwYWNlLmNvbT4gd3JvdGU6DQo+
Pj4+IA0KPj4+PiBPbiBUdWUsIDIwMjQtMDYtMTggYXQgMTk6MzkgKzAwMDAsIENodWNrIExldmVy
IElJSSB3cm90ZToNCj4+Pj4+IA0KPj4+Pj4gDQo+Pj4+Pj4gT24gSnVuIDE4LCAyMDI0LCBhdCAz
OjI54oCvUE0sIFRyb25kIE15a2xlYnVzdA0KPj4+Pj4+IDx0cm9uZG15QGhhbW1lcnNwYWNlLmNv
bT4gd3JvdGU6DQo+Pj4+Pj4gDQo+Pj4+Pj4gT24gVHVlLCAyMDI0LTA2LTE4IGF0IDE4OjQwICsw
MDAwLCBDaHVjayBMZXZlciBJSUkgd3JvdGU6DQo+Pj4+Pj4+IA0KPj4+Pj4+PiANCj4+Pj4+Pj4+
IE9uIEp1biAxOCwgMjAyNCwgYXQgMjozMuKAr1BNLCBUcm9uZCBNeWtsZWJ1c3QNCj4+Pj4+Pj4+
IDx0cm9uZG15QGhhbW1lcnNwYWNlLmNvbT4gd3JvdGU6DQo+Pj4+Pj4+PiANCj4+Pj4+Pj4+IEkg
cmVjZW50bHkgYmFjayBwb3J0ZWQgTmVpbCdzIGx3cSBjb2RlIGFuZCBzdW5ycGMgc2VydmVyDQo+
Pj4+Pj4+PiBjaGFuZ2VzIHRvDQo+Pj4+Pj4+PiBvdXINCj4+Pj4+Pj4+IDUuMTUuMTMwIGJhc2Vk
IGtlcm5lbCBpbiB0aGUgaG9wZSBvZiBpbXByb3ZpbmcgdGhlDQo+Pj4+Pj4+PiBwZXJmb3JtYW5j
ZQ0KPj4+Pj4+Pj4gZm9yDQo+Pj4+Pj4+PiBvdXINCj4+Pj4+Pj4+IGRhdGEgc2VydmVycy4NCj4+
Pj4+Pj4+IA0KPj4+Pj4+Pj4gT3VyIHBlcmZvcm1hbmNlIHRlYW0gcmVjZW50bHkgcmFuIGEgZmlv
IHdvcmtsb2FkIG9uIGENCj4+Pj4+Pj4+IGNsaWVudA0KPj4+Pj4+Pj4gdGhhdA0KPj4+Pj4+Pj4g
d2FzDQo+Pj4+Pj4+PiBkb2luZyAxMDAlIE5GU3YzIHJlYWRzIGluIE9fRElSRUNUIG1vZGUgb3Zl
ciBhbiBSRE1BDQo+Pj4+Pj4+PiBjb25uZWN0aW9uDQo+Pj4+Pj4+PiAoaW5maW5pYmFuZCkgYWdh
aW5zdCB0aGF0IHJlc3VsdGluZyBzZXJ2ZXIuIEkndmUgYXR0YWNoZWQNCj4+Pj4+Pj4+IHRoZQ0K
Pj4+Pj4+Pj4gcmVzdWx0aW5nDQo+Pj4+Pj4+PiBmbGFtZSBncmFwaCBmcm9tIGEgcGVyZiBwcm9m
aWxlIHJ1biBvbiB0aGUgc2VydmVyIHNpZGUuDQo+Pj4+Pj4+PiANCj4+Pj4+Pj4+IElzIGFueW9u
ZSBlbHNlIHNlZWluZyB0aGlzIG1hc3NpdmUgY29udGVudGlvbiBmb3IgdGhlIHNwaW4NCj4+Pj4+
Pj4+IGxvY2sNCj4+Pj4+Pj4+IGluDQo+Pj4+Pj4+PiBfX2x3cV9kZXF1ZXVlPyBBcyB5b3UgY2Fu
IHNlZSwgaXQgYXBwZWFycyB0byBiZSBkd2FyZmluZw0KPj4+Pj4+Pj4gYWxsDQo+Pj4+Pj4+PiB0
aGUNCj4+Pj4+Pj4+IG90aGVyDQo+Pj4+Pj4+PiBuZnNkIGFjdGl2aXR5IG9uIHRoZSBzeXN0ZW0g
aW4gcXVlc3Rpb24gaGVyZSwgYmVpbmcNCj4+Pj4+Pj4+IHJlc3BvbnNpYmxlDQo+Pj4+Pj4+PiBm
b3INCj4+Pj4+Pj4+IDQ1JQ0KPj4+Pj4+Pj4gb2YgYWxsIHRoZSBwZXJmIGhpdHMuDQo+Pj4+Pj4+
IA0KPj4+Pj4+PiBJIGhhdmVuJ3Qgc2VlbiB0aGF0LCBidXQgSSd2ZSBiZWVuIHdvcmtpbmcgb24g
b3RoZXIgaXNzdWVzLg0KPj4+Pj4+PiANCj4+Pj4+Pj4gV2hhdCdzIHRoZSBuZnNkIHRocmVhZCBj
b3VudCBvbiB5b3VyIHRlc3Qgc2VydmVyPyBIYXZlIHlvdQ0KPj4+Pj4+PiBzZWVuIGEgc2ltaWxh
ciBpbXBhY3Qgb24gNi4xMCBrZXJuZWxzID8NCj4+Pj4+Pj4gDQo+Pj4+Pj4gDQo+Pj4+Pj4gNjQw
IGtuZnNkIHRocmVhZHMuIFRoZSBtYWNoaW5lIHdhcyBhIHN1cGVybWljcm8gMjAyOUJULUhOUiB3
aXRoDQo+Pj4+Pj4gMnhJbnRlbA0KPj4+Pj4+IDYxNTAsIDM4NEdCIG9mIG1lbW9yeSBhbmQgNnhX
REMgU044NDAuDQo+Pj4+Pj4gDQo+Pj4+Pj4gVW5mb3J0dW5hdGVseSwgdGhlIG1hY2hpbmUgd2Fz
IGEgbG9hbmVyLCBzbyBjYW5ub3QgY29tcGFyZSB0bw0KPj4+Pj4+IDYuMTAuDQo+Pj4+Pj4gVGhh
dCdzIHdoeSBJIHdhcyBhc2tpbmcgaWYgYW55b25lIGhhcyBzZWVuIGFueXRoaW5nIHNpbWlsYXIu
DQo+Pj4+PiANCj4+Pj4+IElmIHRoaXMgc3lzdGVtIGhhZCBtb3JlIHRoYW4gb25lIE5VTUEgbm9k
ZSwgdGhlbiB1c2luZw0KPj4+Pj4gc3ZjJ3MgIm51bWEgcG9vbCIgbW9kZSBtaWdodCBoYXZlIGhl
bHBlZC4NCj4+Pj4+IA0KPj4+PiANCj4+Pj4gSW50ZXJlc3RpbmcuIEkgaGFkIGZvcmdvdHRlbiBh
Ym91dCB0aGF0IHNldHRpbmcuDQo+Pj4+IA0KPj4+PiBKdXN0IG91dCBvZiBjdXJpb3NpdHksIGlz
IHRoZXJlIGFueSByZWFzb24gd2h5IHdlIG1pZ2h0IG5vdCB3YW50IHRvDQo+Pj4+IGRlZmF1bHQg
dG8gdGhhdCBtb2RlIG9uIGEgTlVNQSBlbmFibGVkIHN5c3RlbT8NCj4+PiANCj4+PiBDYW4ndCB0
aGluayBvZiBvbmUgb2ZmIGhhbmQuIE1heWJlIGJhY2sgaW4gdGhlIGRheSBpdCB3YXMNCj4+PiBo
YXJkIHRvIHRlbGwgd2hlbiB5b3Ugd2VyZSBhY3R1YWxseSAvb24vIGEgTlVNQSBzeXN0ZW0uDQo+
Pj4gDQo+Pj4gQ29weWluZyBEYXZlIHRvIHNlZSBpZiBoZSBoYXMgYW55IHJlY29sbGVjdGlvbi4N
Cj4+PiANCj4+IA0KPj4gSXQncyBhdCBsZWFzdCBwYXJ0bHkgYmVjYXVzZSBvZiB0aGUga2x1bmtp
bmVzcyBvZiB0aGUgb2xkIHBvb2xfdGhyZWFkcw0KPj4gaW50ZXJmYWNlOiBZb3UgaGF2ZSB0byBi
cmluZyB1cCB0aGUgc2VydmVyIGZpcnN0IHVzaW5nIHRoZSAidGhyZWFkcyINCj4+IHByb2NmaWxl
LCBhbmQgdGhlbiB5b3UgY2FuIGFjdHVhbGx5IGJyaW5nIHVwIHRocmVhZHMgaW4gdGhlIHZhcmlv
dXMNCj4+IHBvb2xzIHVzaW5nIHBvb2xfdGhyZWFkcy4NCj4+IA0KPj4gU2FtZSBmb3Igc2h1dGRv
d24uIFlvdSBoYXZlIHRvIGJyaW5nIGRvd24gdGhlIHBvb2xfdGhyZWFkcyBmaXJzdCBhbmQNCj4+
IHRoZW4geW91IGNhbiBicmluZyBkb3duIHRoZSBmaW5hbCB0aHJlYWQgYW5kIHRoZSByZXN0IG9m
IHRoZSBzZXJ2ZXINCj4+IHdpdGggaXQuIFdoeSBpdCB3YXMgZGVzaWduZWQgdGhpcyB3YXksIEkg
aGF2ZSBORkMuDQo+PiANCj4+IFRoZSBuZXcgbmZzZGN0bCB0b29sIGFuZCBuZXRsaW5rIGludGVy
ZmFjZXMgc2hvdWxkIG1ha2UgdGhpcyBzaW1wbGVyIGluDQo+PiB0aGUgZnV0dXJlLiBZb3UnbGwg
YmUgYWJsZSB0byBzZXQgdGhlIHBvb2wtbW9kZSBpbiAvZXRjL25mcy5jb25mIGFuZA0KPj4gY29u
ZmlndXJlIGEgbGlzdCBvZiBwZXItcG9vbCB0aHJlYWQgY291bnRzIGluIHRoZXJlIHRvby4gT25j
ZSB3ZSBoYXZlDQo+PiB0aGF0LCBJIHRoaW5rIHdlJ2xsIGJlIGluIGEgYmV0dGVyIHBvc2l0aW9u
IHRvIGNvbnNpZGVyIGRvaW5nIGl0IGJ5DQo+PiBkZWZhdWx0Lg0KPj4gDQo+PiBFdmVudHVhbGx5
IHdlJ2QgbGlrZSB0byBtYWtlIHRoZSB0aHJlYWQgcG9vcyBkeW5hbWljLCBhdCB3aGljaCBwb2lu
dA0KPj4gbWFraW5nIHRoYXQgdGhlIGRlZmF1bHQgYmVjb21lcyBtdWNoIHNpbXBsZXIgZnJvbSBh
biBhZG1pbmlzdHJhdGl2ZQ0KPj4gc3RhbmRwb2ludC4NCj4gDQo+IEkgYWdyZWUgdGhhdCBkeW5h
bWljIHRocmVhZCBwb29scyB3aWxsIG1ha2UgbnVtYSBtYW5hZ2VtZW50IHNpbXBsZXIuDQo+IEdy
ZWcgQmFua3MgZGlkIHRoZSBudW1hIHdvcmsgZm9yIFNHSSAtIEkgd29uZGVyIHdoZXJlIGhlIGlz
IG5vdy4gIEhlIHdhcw0KPiBhdCBmYXN0bWFpbCAxMCB5ZWFycyBhZ28uLg0KDQpEYXZlIChjYydk
KSBkZXNpZ25lZCBpdCB3aXRoIEdyZWcsIEdyZWcgaW1wbGVtZW50ZWQgaXQuDQoNCg0KPiBUaGUg
aWRlYSB3YXMgdG8gYmluZCBuZXR3b3JrIGludGVyZmFjZXMgdG8gbnVtYSBub2RlcyB3aXRoIGlu
dGVycnVwdA0KPiByb3V0aW5nLiAgVGhlcmUgd2FzIG5vIGV4cGVjdGF0aW9uIHRoYXQgd29yayB3
b3VsZCBiZSBkaXN0cmlidXRlZCBldmVubHkNCj4gYWNyb3NzIGFsbCBub2Rlcy4gU29tZSBtaWdo
dCBiZSBkZWRpY2F0ZWQgdG8gbm9uLW5mcyB3b3JrLiAgU28gdGhlcmUgd2FzDQo+IGV4cGVjdGVk
IHRvIGJlIG5vbi10cml2aWFsIGNvbmZpZ3VyYXRpb24gZm9yIGJvdGggSVJRIHJvdXRpbmcgYW5k
DQo+IHRocmVhZHMtcGVyLW5vZGUuICBJZiB3ZSBjYW4gbWFrZSB0aHJlYWRzLXBlci1ub2RlIGRl
bWFuZC1iYXNlZCwgdGhlbg0KPiBoYWxmIHRoZSBwcm9ibGVtIGdvZXMgYXdheS4NCg0KTmV0d29y
ayBkZXZpY2VzIChhbmQgc3RvcmFnZSBkZXZpY2VzKSBhcmUgYWZmaW5lZCB0byBvbmUNCk5VTUEg
bm9kZS4gSWYgdGhlIG5mc2QgdGhyZWFkcyBhcmUgbm90IG9uIHRoZSBzYW1lIG5vZGUNCmFzIHRo
ZSBuZXR3b3JrIGRldmljZSwgdGhlcmUgaXMgYSBzaWduaWZpY2FudCBwZW5hbHR5Lg0KDQpJIGhh
dmUgYSB0d28tbm9kZSBzeXN0ZW0gaGVyZSwgYW5kIGl0IHBlcmZvcm1zIGNvbnNpc3RlbnRseQ0K
d2VsbCB3aGVuIEkgcHV0IGl0IGluIHBvb2wtbW9kZT1udW1hIGFuZCBhZmZpbmUgdGhlIG5ldHdv
cmsNCmRldmljZSdzIElSUXMgdG8gb25lIG5vZGUuDQoNCkl0IGV2ZW4gd29ya3Mgd2l0aCB0d28g
bmV0d29yayBkZXZpY2VzIChvbmUgcGVyIG5vZGUpIC0tDQplYWNoIGRldmljZSBnZXRzIGl0cyBv
d24gc2V0IG9mIG5mc2QgdGhyZWFkcy4NCg0KSSBkb24ndCB0aGluayB0aGUgcG9vbF9tb2RlIG5l
ZWRzIHRvIGJlIGRlbWFuZCBiYXNlZC4gSWYNCnRoZSBzeXN0ZW0gaXMgYSBOVU1BIHN5c3RlbSwg
aXQgbWFrZXMgc2Vuc2UgdG8gc3BsaXQgdXANCnRoZSB0aHJlYWQgcG9vbHMgYW5kIHB1dCBvdXIg
cGVuY2lscyBkb3duLiBUaGUgb25seSBvdGhlcg0Kc3RlcCB0aGF0IGlzIG5lZWRlZCBpcyBwcm9w
ZXIgSVJRIGFmZmluaXR5IHNldHRpbmdzIGZvcg0KdGhlIG5ldHdvcmsgZGV2aWNlcy4NCg0KDQo+
IFdlIGNvdWxkIGV2ZW4gZGVmYXVsdCB0byBvbmUtdGhyZWFkLXBvb2wtcGVyLUNQVSBpZiB0aGVy
ZSBhcmUgbW9yZSB0aGFuDQo+IFggY3B1cy4uLi4NCg0KSSd2ZSBuZXZlciBzZWVuIGEgcGVyZm9y
bWFuY2UgaW1wcm92ZW1lbnQgaW4gdGhlIHBlci1jcHUNCnBvb2wgbW9kZSwgZndpdy4NCg0KDQot
LQ0KQ2h1Y2sgTGV2ZXINCg0KDQo=

