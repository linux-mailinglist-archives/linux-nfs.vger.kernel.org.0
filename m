Return-Path: <linux-nfs+bounces-6649-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49E88986410
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Sep 2024 17:47:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 456A41C26345
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Sep 2024 15:47:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 549681D5AC8;
	Wed, 25 Sep 2024 15:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KIXJwj8n";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Cj9KVPYA"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92E6B1D5ADB;
	Wed, 25 Sep 2024 15:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727279250; cv=fail; b=a3n63iqKrIRV/E6sZ543Qca+ntVt5hi2bphDNba888KvnUL54dNs+EoppVwjQt9zfnnC5paRZO8Dr+5bFyfu339iLLZ367Y+Qef/zrHz/9nZQSyZDdDcnBSkdtk+SSQ1OdcC5npsnBHo/tgZq5AQUGsaO5r6y8Nn5UUCcPZW7pY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727279250; c=relaxed/simple;
	bh=TIlBvTe2xsl/TqpmOcMNbJZbrAh+Cr9laJNnNaYQ3pk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tOTU3moAuIJs9KOERS35si2LEoFPcqfvQR8hpY6amJYy3n+z+3aGfj1kDQuhp2W4s2mZm3O/TidYGg+k2bGZFboKPenWoCqmeLYzLnfCawM5hANaCwmgJOSGOpR6ohGqpnUFNghwUaXN/bBjli+PmB7iO8SmPmB2v8M0aw87BS0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=KIXJwj8n; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Cj9KVPYA; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48PE0Ygd025336;
	Wed, 25 Sep 2024 15:47:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=corp-2023-11-20; bh=TIlBvTe2xsl/TqpmOcMNbJZbrAh+Cr9laJNnNaYQ3
	pk=; b=KIXJwj8nsEVTPYREXZMLOPH+F7+CvkDrsiQGNZgN1GqPDFZ/uzj3wMoBg
	Edc2P0CojVzvOEjmGYvpZy8nEvb3O4IKp/P4mU6Vhe9q7mpWnizoQl8u+Uzd7oKs
	HMfdmfGmXBmBHPIjKmVx9zuGab3h178Q1E61fUJ5W0wxeYZcJhlOjXaAI8dK+g/2
	E2y5La1DhbV3TW6dQw3rDAY8Z7cB+QoqsEAywf+Ar243S94L9LDu2yNTO5zVkmRU
	z4mdNslVOo+g4pcFv5hh5zC21cFt7+w6x2FTT4rhkc6/IQo2tFvS6BGrbHst5MOx
	UX+mNDDxP1djTDYD55dh0/sHKqNsw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41sp1ajmhf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Sep 2024 15:47:14 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48PEiINp031176;
	Wed, 25 Sep 2024 15:47:14 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2049.outbound.protection.outlook.com [104.47.55.49])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41tkc7dvwg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Sep 2024 15:47:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ixPZsqqfX7EBdIg9MUHLCVBhYvXDhdsPb/qQH9omEqDurs8MU4aOkT6Y9/bdhtYKgyHkhdb4dsdYlTKF7efMqRkS32dGFKLTkhOiMWoDvf5i1G+RG/7eab4Y1A1qy6JCEXkDKafpL1zX1qThWRZfLiK3mw7dsucgCLvw1FrSZ0fVYKR3kcVQqzmOjYQywMgXTYI5lSTTPhc3FQPRPhdU4XsUOgj7jlMZVXws4UN2W064gU/p+a0+JBTebLStNl3EN/OHsA7AzwP1wVSZ0wdr/3KHqdm7/mIg1gR+pHhuf2Ll2eYXThMSNTXra5NdfLK/8jt3/XY4rJTgDCOp4/TOwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TIlBvTe2xsl/TqpmOcMNbJZbrAh+Cr9laJNnNaYQ3pk=;
 b=WLq674teAQ0FY2VuJWXwWXU8PBu+Ta3yxW/W1B9IxnMWqEoraHbBVHMnhQj1stRUFxl0wMzaceyDEYwtRL+j6e2K13UZM9DFwJ9ENXEnaJwDdNqApPJtofqWDYFzmPQk1KTjpcnpQqiudNwZnOPUVZG8C2IQdoe1ong5LTm6Xq/t6791L1rlDlQ7fN71zVzGz/p8SciP5ovT5JMURwvbsoIUniWtV+O93z1rBMrqWFEOEUq7qt/sYlkuPYMdg3pqdAOnJQ7Wkwy+4G1X8l1hrs4PW13b8mL6iRk1oOb4XgTKVAWQSfQV2lE2eS5UyvN2Qys9z9dL0YX/gbwzWFtmpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TIlBvTe2xsl/TqpmOcMNbJZbrAh+Cr9laJNnNaYQ3pk=;
 b=Cj9KVPYAkSr8i94J5G7CobOIGZvtr1H6+BXD+jEgV+w+2evyBip1fFrhy2gCVKcQOhRrOBkVvgY0WGH7IezWCz81S/LOYb0QOE/A5mdxFh5t1no5fxK3AmBPZgUHdBJFQCNOryFMAyZQ5DSpGzaUj7+VeKJQfTS9FtyDrflevQI=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by IA1PR10MB7312.namprd10.prod.outlook.com (2603:10b6:208:3fc::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.13; Wed, 25 Sep
 2024 15:47:10 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.8005.010; Wed, 25 Sep 2024
 15:47:10 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Christian Theune <ct@flyingcircus.io>
CC: Jeff Layton <jlayton@kernel.org>,
        Linux NFS Mailing List
	<linux-nfs@vger.kernel.org>,
        "stable@vger.kernel.org"
	<stable@vger.kernel.org>,
        "regressions@lists.linux.dev"
	<regressions@lists.linux.dev>
Subject: Re: nfsv41: stale file handles after VM shutdown/poweron - but works
 during warm reboot
Thread-Topic: nfsv41: stale file handles after VM shutdown/poweron - but works
 during warm reboot
Thread-Index: AQHbD0PXhlPu7DoLfkSg0Q/j/NNyU7JokNkAgAAMJICAAAjMAA==
Date: Wed, 25 Sep 2024 15:47:10 +0000
Message-ID: <120BC7A9-A1A9-45C8-BBF0-256C7107D0BC@oracle.com>
References: <AFE3E539-B98A-465F-9860-EE142D00285F@flyingcircus.io>
 <9937A07A-F7AE-4A99-B7DE-7CF026E0F7B8@oracle.com>
 <3FB1C2D6-F409-44ED-B799-E2657759E455@flyingcircus.io>
In-Reply-To: <3FB1C2D6-F409-44ED-B799-E2657759E455@flyingcircus.io>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3776.700.51)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|IA1PR10MB7312:EE_
x-ms-office365-filtering-correlation-id: 1d64132e-39d8-4539-505f-08dcdd795194
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?RDBFSmd2Q3BPcWFJdmlST3U4WXFDNHVydXNiY29XanQwVFdNUEtHNXFQNUV1?=
 =?utf-8?B?SEV4a2lzeFlXWEdDQ2x0OFczTnVCYnhKTkxxcWRvYXAwaEN3Q2c0WmtwMk03?=
 =?utf-8?B?MktmOVdXZ0R2eXlQMHVqeE9SeDRzcFF2T3pBV2NHa1I3ajVlYkduWk5QVW1T?=
 =?utf-8?B?aDE3eHgybmdLVHoycS9mb2JLWmxQRHR3TGI5K3M1YzR5My81M29FKzhuV1No?=
 =?utf-8?B?SmFsdGJybXUyQS92WWpUMU9KL0N4MkZxT2RPNXhaVnVMWml2ekVzV3Nmc0Fn?=
 =?utf-8?B?ejA1QlVxNDJYcTMvTGJWL0JJbEExcWk3TlBTQSsyVWliMDN1MzYwbm1iN2hj?=
 =?utf-8?B?cnhUcDVoVjVtR09keHNzTy9LZWRCMmhMd2JJZXU5Y24wS1Z6RlBLQnM5MTF4?=
 =?utf-8?B?WkdXdkkyNnFoQk56eHQwRG95TldlUTBTUm5qYjFlbnFGK0M1WFNoTkhSMkwy?=
 =?utf-8?B?SEM5c29oT0RxL3lUVHZDbWhRV1crN2JIcHZNbU9pREovQ0hWcFlJREl6VHZL?=
 =?utf-8?B?bVhid3ZPOHNvV29CZlQ3MmZyWjVmNU1vZytxV1F1SXc2Z1IzTmo3OHpMVUVY?=
 =?utf-8?B?VGtzOXpRQ0VkVC9KOEdIR25NaExNK241UVppUElIQmp4WnBadzdyZWo3dHZ1?=
 =?utf-8?B?am1sNjAxdHBnRXZZSExsS2NQaTFNRFp3QVo1Wk01Y2UzM0ZnVkdUdjh1RTZy?=
 =?utf-8?B?RnVZU2t5MWdMUW9ZZU5zSkhtWVdOUmxIZGxnOTI0MXJWTGh3WHl2bERXK3hp?=
 =?utf-8?B?UlNpSUVQb2RrNGZleXJ1VlNVQ1NLWlJoVEgvZ3o4UHpZV21HTUExakRqd3U5?=
 =?utf-8?B?QldqQkpCV29RdGFTdmx6UFRNa1QxVnAwVE5NbnhobWF6bWNYQ2hLWEJoTmdD?=
 =?utf-8?B?R0tFZVkrdjQvYkNvbkNySU90dkJLYjFTOWxuR0p1RVpUVGgxNVp5QVdHZlRo?=
 =?utf-8?B?bFg2S2ZLNnQ1WTBlQmpvODVLZjNreUpmY2ZYT3hvQi90a3JyZnR4dUdtb2pJ?=
 =?utf-8?B?UDJFVzVYUUFlcnRzZkdpcHdJaDJ5LzRvUWNHR1JCcHdtVTZzWXVDZEVXL3d4?=
 =?utf-8?B?TmJnSEN5SThzRkJrSG1NSU9tTXF1NnY1REFTK2hXOGhLamR3Q1lHOGVDb3Fa?=
 =?utf-8?B?VFc3WkV1cXhyZXRVbW80NHEvMTJUNWx4bTFoZWlRbVdhTzk0cDVuNzBRTmhn?=
 =?utf-8?B?dzlPUEdoNVZyNFYxZ094K05Cc2JOUHlUUUhNbGZoNDBDa0VnbGZwMUxNRHQy?=
 =?utf-8?B?MzFPdjdoYjR2dlJlSUQxdFQ2ME55OXFZUWdUOHlzWGZROFlNRFNSWWZJKzlT?=
 =?utf-8?B?c0k2Sm0rdjAwdWRINkwyVTBRUTBPV2ZYWEEyNm5iRmltU3BxQlRMa01jSlY2?=
 =?utf-8?B?cjhwR05SK2tMOTBFdmE5Ky9nTlQ2Rkl4MG1VclpxZXNtdll4UEhGMjVZVkQ4?=
 =?utf-8?B?aDNSdGZJNVdRV3J4SkNHY3dWeEdhSStPSGdaejcrQ3k4bkZYVFhNdDZJWnhn?=
 =?utf-8?B?NG1WVnJTekp5WjFZbjYyQmxFNDJJaDBrMTJEZXp0R0NHWlk3QnI5aVV1V0Zk?=
 =?utf-8?B?ME9SRE55MSt0bE0rMVd6akhqMGU3bk5Rb2FJamtlR2FkeU5YVUk1YUN5Y0hn?=
 =?utf-8?B?cHRrWXBORkNrY1BXU2N4bitTNStrWElFOWtoeDlla2lMNGx6Z0FHSEkzcHlR?=
 =?utf-8?B?di8zcmtnZHBFKzEwOVFyeWhuczd5Qlhyd2RvaUY4ZHdBRnc1dnJDbEdFb0c1?=
 =?utf-8?B?Q1BJWDArbjloYTNjYTI5akVpZlhVL2NERTVsdlRCbEo5WHVCc09wZTU5cTgz?=
 =?utf-8?B?WXNuRkw5RzVJd0RvQXVKbE52L3NhblFBVVRGRXYvMGhXaFlCYlE5d0U3SWha?=
 =?utf-8?B?eWlWNmxMTXMrYTR4ZjlwWHl5UkFhOFVmWTUvaE1hSkxiVFE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Ri9Cc0V6TW1OWFVKL1NOd3BiMnFIbHBaMGdXaG4zSU5JeGFLdmUrb21YYmFt?=
 =?utf-8?B?azFNNDRKbFIzRVNqZzhsZGlhcVhQa0pWeXIzeWZTN0p4cUVUZ3ppcjRaY0VC?=
 =?utf-8?B?RDg3b1NwSE00dFZvVFR5cnpWenMwOFBTbUhna0VEclU0Zm5XQVBPcmFhTzNr?=
 =?utf-8?B?U0daeTFEd3J6cHBOVm1kR2NsUkh0OEVyY1U0VkJUQVQ0N0FWUUd6WGh4MXQw?=
 =?utf-8?B?T0t5Ny9jUDg3b0dYWjc1TTBIdlQzQm5tc2o3Tzg5WHduM3lOY28vSWdNeDNC?=
 =?utf-8?B?ZTgvVVludWs0SUpEdGRiOWw4MFNZTFp6UElTM2xRdHROaVVYcHRILytiNDJG?=
 =?utf-8?B?OTdMQ0xJT2Fha0ZsUFQwQ1AzbFNFRytnS2FKUXpRRmJsbzN2VExINmc0azYx?=
 =?utf-8?B?Y2xMQlRnOGxFMkhOaE5FdDZhcHdQOTd3b0ZaNEJPTGc1TUdqZW80eG1zUzZX?=
 =?utf-8?B?NGp6MDY1YmVUZEVVQWtmQUlKY1lFSEpQRXBNUUJaRlAxTEd5U0RaVjJBSlh4?=
 =?utf-8?B?c3pQYTZFOERIYW9IenZRYUM1S3NtOHYxM0ZiaDFsdGxQamoxQ0lsVlpkd1ls?=
 =?utf-8?B?VmVkZ0JzcUdmNmNDQlAxc1FVaTV2c2hLSUdRQndyWHZSbmpIR0d2VHp2RndZ?=
 =?utf-8?B?ZkU4ejhTSGowTmU2ZmtSSWFuU2UvOSt0NVAzMFhRWmdLRi9VcENVaEFvS2Zx?=
 =?utf-8?B?c1MzS2xlSThHTFZHQUI1UnR1bUY5Z0VJR0tTYjVnRmFmUzJMeGM4eFBBRmtp?=
 =?utf-8?B?by9oaVA0K09YSEIwTFVGSVl4ajhWbUh4YUNKaTN1K3A4WnNQRytMZVJmcjU5?=
 =?utf-8?B?V1UraDFHaUJoRkZJRVAzTUszdEZDek5hbk1VeFVBTityR1FrQUR2eXdwRVFw?=
 =?utf-8?B?ZVBac05FQW5JMWdaTENZUjVSbjRjZHZQTkRjTUJINCtsTisvWExxdXdCVDls?=
 =?utf-8?B?S0NFZXdPMkdzbTBKeFpFLzRaWUZEaXZlVk5HSEkxWFI1K3kwVThJZEtENzg2?=
 =?utf-8?B?REZUVVN0aWpzaDJTRndLN0lwV2w2WEZ5TVdLbnpDZk1xWnhEYkJ0Y25XMmZQ?=
 =?utf-8?B?Y1E5QStmMzZpOWtxY2RlaWp1WGIzMXkyZVhrdG9JVTdKQjhLWGtJcUhaWno3?=
 =?utf-8?B?YnZJNFpaM0ZXQzMzaC9oM2hNTkhER0kwSFhRcTFpUHFRTkN4S2NoakpkUHlL?=
 =?utf-8?B?elJwMVBjS1ZqQ0pyWE1KSGhoVHF4TU5yUndpcmJ6UXdEekdBa1VXRlVJbVRm?=
 =?utf-8?B?Y2lBd2lCQWo5dmROS3lJL3JDNTUxeGpjalRBNmVwaDBxUjVLcDRxaFB5V1hJ?=
 =?utf-8?B?a3N6ZmZUaFZIZWhjTXo2ZXZVVVlzdzljZk5ZdkxQS3lReUFObHBDWXJGdFov?=
 =?utf-8?B?N1JIMVZxa1Y1clc2dG1oeExsU0llR1NJNnJuTk1WWUNkbTVFOTNNaklRNHdH?=
 =?utf-8?B?ekFOSDNYdVF2ZTYxOC9BclRpdjZtRmVENFV6akJsMU84dEM0WDJRK1dwWmlP?=
 =?utf-8?B?Z1Vma2hoaXM0SVkybXdCaUlMcDgybmdrWnRHaGZMNFRJRExyNGJWempqYzdt?=
 =?utf-8?B?T0dXZ1lUdTlyeFpidVN0WHcwd2NVTVlMeDA4Ym9pZnRKa2c1U25lSVJkeTFp?=
 =?utf-8?B?YlVzanVhWFRLS2ZqZkl1WmNIcTc2NjFydEt4c1laa0Nkb2hndXZQNlBKc3Rt?=
 =?utf-8?B?eW81V1hOaDFUMmVkRy8vdXNuRGJidkczUVJ5eWRZcXNFSHFwU1hiSkhnYlFC?=
 =?utf-8?B?ZnAvQndEcmJHdWRQMUtsUjYrcmNRMGtRTG9tUENoTEM3SG1xdGxOSVhpeURt?=
 =?utf-8?B?QTlYUERZMVE4NlBnaTJVcTllTHZxTlQyNnpsNXN1b0xVdmtuWmZVMkxWZnl0?=
 =?utf-8?B?d0E2MGdBYjlGdEZiV3RXdC9VenVhczhnTUhkUlJkbnlIcFN2ZHNNdGNoRkk3?=
 =?utf-8?B?SXlkYzBPdmZJejg1NDJsV0Y5eEE4MVRWVVVlOWxYMXBRRmdXaVpOZ3lzOGhw?=
 =?utf-8?B?UCtxMmlDLzBaK0liWnNEUW40eGJFY0RHMnArRUQvdG9Zbzc0T2w2aXptTllI?=
 =?utf-8?B?bGpxcE1ySnJpbUcwUDFVaVlsS3NmR0JWVUdrOWFSRWhyeCtBNytzREFiMG5i?=
 =?utf-8?B?SFVOdXcvcDVVMzVmWFllQkpNRzNqMEEwNm1EMDgvK29yQUw0SlFOQUp3Z3Vy?=
 =?utf-8?B?UUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3517F189628625468A92629F54DCC527@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	wHRg8FwIP6lc11gqPmSQeRtSx/GqOvKNKW84D4wV0jFQt99S924exFAK6Z5hdGh7l6JlJr73qbNmAcvdgvxQWKN8XMDMHWgBH3zHYDowu2sdJMGLuoyeoGmrfkH3yNNwxdX7YKwXSu0o4HPJUP2kxnStasGUGvahNcwACCRbBoNNVyUrRmaBZQ4LaYgCRHymse3CrtC5UWWlHQL1ROp95jPRAFdgZNtlao6UParEsB72LWm+5SS+UyV8lDbzgFnbz2CaRA7zEEUb2IKhmgTH8R3JGvCczz2UsZkiT4dsp7XOyp0NvP4dtc1+F/VjU6RIiPEjZpQCYFGc0lWuEbgNXl8P5hdkwDDERqRU0XA+5xFVdTWjW6QpXwTg0nbkBCymrofATQ5rzU7w6TJulydTKNo9BJiXxgcLULgblLmBMB6ZXEQ9/f9niBkLjUes9U+NyZxtvtAJUFHbMggd8npl2jCZsB+PpsuMmxrySxSTvDGy/yngT/6aK/bOLktwOFEXZ9NJKlyN4NhnS/OMVs5UmYFx9bAEmwKDmOVwUbBlL1D9kmwzcQ4jHcdPXh34P40sM8ozfDBZP3fwHsEVDkV8gANwwlN/vve7oO5wvbWMnGI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d64132e-39d8-4539-505f-08dcdd795194
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2024 15:47:10.8855
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: A8itxgOWCHLFagQWMip7ARvCzn0fTlhVjew4QI46dIelLOp3d9ffqBT4q+BuUR2cF9857ExJ/9hAB4/1oESpOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7312
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-25_10,2024-09-25_02,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=885
 phishscore=0 bulkscore=0 adultscore=0 mlxscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2408220000 definitions=main-2409250112
X-Proofpoint-ORIG-GUID: o2C2LlowXEXKP8pSwvFeCn6x4R8JR1bY
X-Proofpoint-GUID: o2C2LlowXEXKP8pSwvFeCn6x4R8JR1bY

DQo+IE9uIFNlcCAyNSwgMjAyNCwgYXQgMTE6MTXigK9BTSwgQ2hyaXN0aWFuIFRoZXVuZSA8Y3RA
Zmx5aW5nY2lyY3VzLmlvPiB3cm90ZToNCj4gDQo+IEFuZCB3aGlsZSByaWRpbmcgbXkgYmlrZSBo
b21lIGFuZCBnZXR0aW5nIHNvbWUgZnJlc2ggYWlyIEkgY2FtZSB0byB0aGUgc2FtZSBjb25jbHVz
aW9uIChhZnRlciBwcmV2aW91c2x5IGJhc2hpbmcgbXkgaGVhZCBhZ2FpbnN0IHRoaXMgZm9yIGhv
dXJzKS4NCj4gDQo+IFdlIGhhdmUgYSBzdGVwIHdoZXJlIFZNcyAodGhhdCBhcmUgYm9vdGVkIGZy
ZXNoIG9uIHRoZSBoeXBlcnZpc29yKSBnZXQgYSByYW5kb21pemVkIFVVSUQgb24gdGhlaXIgcm9v
dCBmaWxlc3lzdGVtIGFuZCBiZWNhdXNlIG9mICRyZWFzb25zIHdlIGRvIHRoYXQgZXZlcnkgdGlt
ZSwgbm90IGp1c3QgZHVyaW5nIGZpcnN0IGJvb3QuIExvb2tzIGxpa2Ugd2UgbmVlZCB0byBzdG9w
IGRvaW5nIHRoYXQuDQoNClllcywgdGhhdCdzIGV4YWN0bHkgdGhlIHByb2JsZW0uDQoNCg0KLS0N
CkNodWNrIExldmVyDQoNCg0K

