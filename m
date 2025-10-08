Return-Path: <linux-nfs+bounces-15058-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EFF84BC63B4
	for <lists+linux-nfs@lfdr.de>; Wed, 08 Oct 2025 20:02:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7EEB405965
	for <lists+linux-nfs@lfdr.de>; Wed,  8 Oct 2025 18:02:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AB5119E7F7;
	Wed,  8 Oct 2025 18:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rutgers.edu header.i=@rutgers.edu header.b="Jk2gPL9s"
X-Original-To: linux-nfs@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11022118.outbound.protection.outlook.com [40.107.200.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78A5F34BA3B
	for <linux-nfs@vger.kernel.org>; Wed,  8 Oct 2025 18:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.118
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759946560; cv=fail; b=JSaVFS5w4uuAflapyAm8JNxgzonP6GyUezbmIOySNJIV5pZjhpbCaLYOOR9N9O+L0QnnseJrl86BDmTnNwW1UjmYxe07d2GOphjDrYifO7GZpW/zArDJXqmmi0Fd1wrWEpDywhZCtOllBJn1WkZyG4ZFDc0pOFPRYuVMQZ0UFrA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759946560; c=relaxed/simple;
	bh=xhasbNOI8HvBu38BkIjdme7WfBlsE0wRjFW9PVGNQCA=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=E0kIdUGAzGUDQvqZY1pNv30lKai96N6WY58MS493dC744uhPvhb2kDV0jn60ezG382aQvwbS2G2LQqLYgcjHR+uYHviUtdaVqWbQqNY1EHztTJk1lXsWslGfNJo+5Qsx8IfxeI6WUgb7CeBJCVQML97fBG89WlT7nxAFiWxdv/A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rutgers.edu; spf=none smtp.mailfrom=rutgers.edu; dkim=pass (2048-bit key) header.d=rutgers.edu header.i=@rutgers.edu header.b=Jk2gPL9s; arc=fail smtp.client-ip=40.107.200.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rutgers.edu
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=rutgers.edu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ULMmx4PgFRWUFHm0uXKWLjNMtUKCiIx28L4eDuDXfr/RBOHlN4oPt/TtZPOS0sq++/5kK2cr5a+OM87IqpXXYvTk0HChnZS0NQ0vWg+QYj/t3Rf1DqsmtJuYy15wcZ29tiD+CnWSS8kVQRhcY257J4m6tRhYmue79Q/HGRnjEjDRCbVCFXYo/UfS7UMnEat5oklZ8FyQs/jjiLJm4KJmOfCIlo+4DHFdi5MRisBj5tLaiq/w33KUnWlZ/mrXTHjXdonNl2kHKsqBy7uuDqLUmH93kiYHtId+G4DinykbSuhX48wUrQvFRX4n0fxNzLGcAqHbtHxShTR++UKxPVip3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xhasbNOI8HvBu38BkIjdme7WfBlsE0wRjFW9PVGNQCA=;
 b=I0o7BM7DAFDm4QUJ/PN2eI7KqkB4C8agQ09K0IiIL26Nr6IWSQUrz7OVQsp8hzRyAMi0WMmbWkwHv4mHaEz+JWWXqaqk/lLF+1iscapXE2RoB0pTdY9dsSQCsIFFXtNTieL81yETWShOlLNyigX1QI6eDcWgaqonFP4O/6e73MtLz/ZZyixQd9YD4WzLNgkZSN1Li/Nmlq23Q5kd3As4AD1LgbBZEL6ogb85XaowZ+iqFDd666a+vUNxiU0EN+QHPWmFikF4yU2KGF5fdmL2zPBjpHC+OZHdrnQrM8iiI5QDlSxHJhDnP65NdlrOU/y4BnBjBFY2m8JNQ3Mpr1azHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=rutgers.edu; dmarc=pass action=none header.from=rutgers.edu;
 dkim=pass header.d=rutgers.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rutgers.edu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xhasbNOI8HvBu38BkIjdme7WfBlsE0wRjFW9PVGNQCA=;
 b=Jk2gPL9sUNkJuy7K4BQ47SBDfN+ktbCIlDM6VN8NUiXBYJg+qnnnGVzh3WBRfMyqODSEjVfTH6yozYpeO7SUrmSWKjqcS+P+Bj3pSVN3RyHIg/HvA6FrR0JQV0EzproSgQzagBpgQOt3tB1C2FDAXXw1oU3ZyZvJKwxRaz+Uym4tZdXUvZniIwQQoSuVeXAwl6GDY6v3YUfk1emEIAhgBDViCdfuLqcdArUuBtWOJCpKRR3ASCNafi0Ss+lRgL5kzkvZRQNLrka8wVJC3BIRfbLocN2Mse+NiMzZ5oRmy9QouISpElULSm+DXjW/oEKKk8BBkdiMhtfVRaSCqFl2pw==
Received: from PH0PR14MB5493.namprd14.prod.outlook.com (2603:10b6:510:12a::11)
 by DS0PR14MB6757.namprd14.prod.outlook.com (2603:10b6:8:f1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.9; Wed, 8 Oct
 2025 18:02:35 +0000
Received: from PH0PR14MB5493.namprd14.prod.outlook.com
 ([fe80::c4e6:a77b:bbcc:efd4]) by PH0PR14MB5493.namprd14.prod.outlook.com
 ([fe80::c4e6:a77b:bbcc:efd4%4]) with mapi id 15.20.9182.017; Wed, 8 Oct 2025
 18:02:34 +0000
From: Charles Hedrick <hedrick@rutgers.edu>
To: "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: can gssproxy be used for both cron jobs and normal users?
Thread-Topic: can gssproxy be used for both cron jobs and normal users?
Thread-Index: AQHcOH25NeU8Ty0LC0K93JLD8RtBxg==
Date: Wed, 8 Oct 2025 18:02:34 +0000
Message-ID: <a4a13129-a50c-4ecd-b323-dfcb4066af5c@cs.rutgers.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=rutgers.edu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR14MB5493:EE_|DS0PR14MB6757:EE_
x-ms-office365-filtering-correlation-id: e5e7a396-0418-46f3-741c-08de0694dc06
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|10070799003|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?dFg3Q3VoVGNoR3pOaUk3S0pFSDhheHdrMTBOcTJCQXVzU3gvUmo1MWVYQldW?=
 =?utf-8?B?ajY3VEU0dTdTS3oyK3NaNlFRVkhVZDVoV2VVeFRmK01IT0RTOUY1ZW9xeExD?=
 =?utf-8?B?RlQvdEgwOHYvS0s1aWF2UndkTVpJaGNnNWwyUzNsMk1lZkt1bkJ5aXBDMGNE?=
 =?utf-8?B?angrREZNdlZmUGVIV29KS2RUT1NYNkVJdXZGS3BZd0REbzlENFp0a2hTbEt5?=
 =?utf-8?B?TUY4VnRmMVVBTElzV2pXV1dzU1o2a0hyK2RpY2xMb0JGSHN6dTI0Qldmb1l3?=
 =?utf-8?B?SnNPbGl0NElUUk41cHp3MzNpeG9DcW1zRStvUDNPdFRtVUZVSFhRbC83bTlW?=
 =?utf-8?B?Z0tQNWlpUS85MkVtaGc5eGdSU3hoQVlGdEpWdTRkWWpKYVVSV3JjMnFna1FT?=
 =?utf-8?B?MmFsdmtTUndVejk0cDBTeVd6RG9rdTlndDVickJUQXJON1Z3bVpYaWFSbDN0?=
 =?utf-8?B?bitUMU4yVlVhK0VwMmsxT0pkODFabnlrZ0M1alp0RVkxMFZjZzBhQUJva0lP?=
 =?utf-8?B?bkx0RG1UcVdlZHp2SE04Z08xYmtBSS94SnZqNGN3QysrZnkvMGdzaFB3WUtN?=
 =?utf-8?B?aTdOeXBKaEROZUsvVkcxYTh4NE9aRW1mRTJyVEwxS2lhb1pJalg1V2FXK2Ur?=
 =?utf-8?B?dGdSV2VnWExBamxzdWt1MkltNDBpMitsQlA2b1BqSVRtMWtuQ0JvOXBPUEZp?=
 =?utf-8?B?Y1FaRVQ0OU8xL2pmRjJCMDV1czQ5QWsxNnp6Q0xuaVdFZ0l2U2VjQWtzKzBF?=
 =?utf-8?B?bUhqY2ttNmxXQVdlV2xhQlh0dTZDclZGM3FEWGNDYm5vcFJ0cXdIOUgwMS8r?=
 =?utf-8?B?TmhYN25VQmM4NE9zbnI4cndaRjhwQjNFNmRJdGxucmxoMkkzZFdOWUJYS1hr?=
 =?utf-8?B?dlRGTXRqYVhtaVd4azBSWHNYR3ZXTnJMQlhNVGd0YnppWVhrdm5RWDg2eU05?=
 =?utf-8?B?eHBiYlVrcTRCL21jZnY1NXRVNGhrYkJMMXU2cFpOOUJUaXJZeVY0S0JNSy84?=
 =?utf-8?B?OUJHNkt0NWFWM2FXMUMxc0VBeE9wMExHZ0Y2RVRoc1ptNnZGeElVUTNWaXpD?=
 =?utf-8?B?MTg5UnV2NXhyOHJPVm9JMnpEbktUNzhmb1BNTTRjaEVNRjVGY21oeDdSWlpp?=
 =?utf-8?B?dlliaTdEVWUwdHJ4OGllTjBzdTVBaE1UN2pXNEZubGpibWhsc0I3RENzQUsr?=
 =?utf-8?B?aSs3TXFFNVM3WVZpZ1RWRDY0TzRlRVdhN1F0Q3ZsMHM0dG9EMUZRM3dYWWtP?=
 =?utf-8?B?N2pwOGQ3Z21Hcm5zdTkxT016cVdyK3A4dmV2aTJlQjhGejFZQ0VJaUpmY3ht?=
 =?utf-8?B?a2sxamJMd3VSRkZQN2o4NzZYbXB5NEFsQ0g4UHJiTUswTUR3VzlqRzVJbXRY?=
 =?utf-8?B?STg3MTZxektnVWJ0aElBNUJham05UGVZVkxLRi8reXpBK3VWLzVpZkdlaDVK?=
 =?utf-8?B?Q2VtQXhnVUJWaWdhazFLMGhWamJhVFBGZTFGNmorZlYyQjJIQWpNTWNTVHFX?=
 =?utf-8?B?aDVJOXBVL2hlUjNzdlQrUmNIUndsK3REYnB3cDhqaE1XV25TYVFrTHVCMUdw?=
 =?utf-8?B?cW4ybGMrMUYxYWJuSjNPWHhFNG5xWHJkcW8rRThGdDdTWjMxTUx6bW16ckZw?=
 =?utf-8?B?S2RnMWRid3k2ZnRaMUE3YWVzN3ZkRnE3ZDUvOWdudGpTTk9SbmZrMGdvcVVa?=
 =?utf-8?B?UjJOODkrOG9zb3VJNzlYcWdnVFViUkRPN1BWOVVzVFNJS1RIV000RG1MVXNS?=
 =?utf-8?B?aW5qZER4SmVqMUF5NXlISHcvSlZvdUVmcTdTSUtIZ0VDMkFwUGNZaG1QYXRk?=
 =?utf-8?B?bFU3WjkxOVcvNVN4emg4L1kyRUMrVE1wZU5seWR0cWdGbnU3OTg1OU9QYnZi?=
 =?utf-8?B?TndlR2s3NWVZdTYrUkpKL2V6Q25Xek1VeG1kTnhuVDduNzl5ZzFpMlFDWFda?=
 =?utf-8?B?YnlEYlFnY3hEYjcrQWo5YkUyMFZrVlZ1Q3pIZzRja29mSldnTEVpS1lRYVJx?=
 =?utf-8?B?Wlo5NTBTQmczRVArditLZ1V4UUE2bU91VUx3RFhnOTZhK2xnMXhrdlBSMkZ4?=
 =?utf-8?Q?Jft03r?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR14MB5493.namprd14.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(10070799003)(1800799024)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MERIcGEyM0JpbEFuQ0p5bllwcDBYODNlS1BlL21TVVIrejBKb0xoR0NTS280?=
 =?utf-8?B?a0hTSnBxSzFTc0QxUmJiejlob2F2dzFWZUc0cFRHSHFBTGl5ZzdrNkN3cGZp?=
 =?utf-8?B?dXQxd1V6S1lZeFBlVisrbDlRSlBrNEVoY1hPU2w2RVpLdC9IOW4yb0Y4UXF5?=
 =?utf-8?B?QTQvZTdtbitKUXZmbDNuQWd2eHR3bkREeWMrUE1QcE1hTkhpWmZVdU55bGYz?=
 =?utf-8?B?cVVvYklnQXk3UGgxcEVpZGpXOUlDa3RiZkJEQlpjL1JhR3ljRHJZWmxUbkcy?=
 =?utf-8?B?QzF2UTZPaFlSZW1CN2RZRjBQNCt0TksyeTBFN280b3FrZi9TSyt1WjRjN0hx?=
 =?utf-8?B?MnB6RTVLUFpsR2VHZ1k0UURoY09RMVQrd3o1VHBUTk5xSDMxSW5XTnVSaHZD?=
 =?utf-8?B?WWdPbGJGNkNPZWxLQXc3cnNESW1uSEhmallqZjJuV0o3cjAwT3NrVEd6SkVF?=
 =?utf-8?B?b1dOamJDK1FsNmRnaGRtNnpURlRSZE9oampzYWVUVzY1bUk4cnZzU1cvT1h6?=
 =?utf-8?B?NDRyZWZMZUhBNXhhM0hiZ3FYMXRHSUs1TFBpUkdkWEwxV21QYmMvMHpBL01M?=
 =?utf-8?B?OEJ4ZTN6WXRsR3RrSFJMOVBnTDBiUjdkaHVwTXl6VFl1bjhiS2VIdThxODI3?=
 =?utf-8?B?NHM5QlUvYm1MdUxkOFFSeE1LbDRHYlBSZmtMY1M2UHNwcnViN0RLUDh0RHI1?=
 =?utf-8?B?QmIvSUJFZW9GZlZNTWl2NnRqUHlRenFqL0l1VWVBcWJRRkg1TVFka1FMYjFB?=
 =?utf-8?B?bDZoU2tRT2k3blhPSS9WN0ZrVURIKzVheXN6bkdCWklieTdoaFQzUFJZWWJ6?=
 =?utf-8?B?MXFzRk5pbFhMWm9rdHJ1Z0JXN3VtLzZ0S1hUbkxmaXBCUndMYnRlSTl2VGpD?=
 =?utf-8?B?YXJETXZzNEJ0OVVVY3c0Nm1zalJvand2Z3B3Z01ZU2g4aGVIM3pFR3JsdHdN?=
 =?utf-8?B?NTVOS3AwT1Z2OFpzSGVLUWYvYTFXaHhBZ1NCT0kxSE9RWjY2aVpoK0o4WXE3?=
 =?utf-8?B?YUJ1NUpNcVYxTmtFaDhZRDM1MGxmR050UkxCVzdaWG5kTTRWQmR0YVY0MVZm?=
 =?utf-8?B?R1FkaXlQa3N6RHF5K2hCaU9JcnFHK3ZLT05aSTVrdzd0L3k4N1lQY0E2cDRy?=
 =?utf-8?B?YTgwME5ITDBiUmY0K0hrUnFNT01vNmRGRTNFeUpmSDZEbjZKdGI2N09GRDcr?=
 =?utf-8?B?S0NZWEtsRFQ0bG5GcENhRHZOVUZkODU4dEF4bEMvV25rR1FMOE9pMXpBRE00?=
 =?utf-8?B?N3Nza2lvamtSV0lKRnBZTlZzYy81NFVhK0JwZHF5ZXJSRHZrTlhDcDh2Y255?=
 =?utf-8?B?UHB0ck9zUTdQK1lpcGVqWjFySFkzYXFESVMzUHVjd3I2YWNaRTB5REwya0Vr?=
 =?utf-8?B?OVZaT1pqTE5FN1FwTWlDSkFLaVhUcWNJNzZsZUJmMmRWdVNDQmVyWHFMdVhT?=
 =?utf-8?B?ZUc1dGxXSVBHZW5kZVVZcHdkRUQxeHFzRWp4MmFzbG9vbnBnZW5jaVpZNTFH?=
 =?utf-8?B?NWRjR3F3WWZWRWRISXk5OFdFaGpyVWZVTEcvTnlNSEs3cC80Ym9uRTlDWmgr?=
 =?utf-8?B?NlhldTkzVEljMTB3TDVGeCtnWTVDWkNhTEdCOUJGcis0c2pYckpINkZPVW93?=
 =?utf-8?B?bmo4akhIbTJld1NGYm1OM0tEaEhHYWRURkF1eGRoZFFtK040M2dwYjlESndy?=
 =?utf-8?B?ZzlFSytvN29FK1RnNTFseERwSmNDN1ZhUm5kK2x3L1BQSjBIMHRRaVRzbWtK?=
 =?utf-8?B?Y2c2d0ZQS0Z2RWF0cTJrUXIzdjk5TlVMeHk4QnRWVXlsVkh4UkFWMVUyQlV2?=
 =?utf-8?B?eVdkc3NHVWpFU242cVdwc1FFMGpqK0dYd0pMeHR0NFZOZnp3UEtNK2RjcmlN?=
 =?utf-8?B?TDVqTEJ1YkxLRHRFVXQ3QTRCK2xFNXRubkpGc1cwTW9QdE5od1lYSktUa2pm?=
 =?utf-8?B?c2hYWGo3bml3RVgrY1hCRTJuZ0NHMXRSRitPZEVqUFNYbjB2VW5MdlZXVDFF?=
 =?utf-8?B?R1JBdS9BNXBWVFNULytuU2pYdXcrK0Z3MjFhVys5WHpRTmp1NHN3VkFhWTBn?=
 =?utf-8?B?SWFQcFpjeEpEQnZ0blowVGwySWtoZytkek9MS2RxTDFUYkVkWkRaV3JFelg0?=
 =?utf-8?B?QTVsRWJlRUJNTElFLzY5VzJmYkp0Qzc0bFY5MDlTNEx2WnIyekk4UWU2ZWRV?=
 =?utf-8?B?Wmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4A72A46F0DE4CE4EA832102E53DFCE89@namprd14.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: rutgers.edu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR14MB5493.namprd14.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5e7a396-0418-46f3-741c-08de0694dc06
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2025 18:02:34.9062
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b92d2b23-4d35-4470-93ff-69aca6632ffe
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sN7mzVhFU0ilWubxPL/j5UvTDpDU63OvI6Kqeh0wWAtACyEndYAoNC2V4Djmm3ehFdsYlTqPdexDX7WG7OA3xA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR14MB6757

TXkgYXBvbG9naWVzIGZvciB0aGUgcHJldmlvdXMgY29weS4gVGhhdCB3YXMgTWljcm9zb2Z0J3Mg
aWRlYSBvZiBwbGFpbiANCnRleHQuIFRoaXMgaXMgVGh1bmRlcmJpcmQncy4NCg0KLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0NCg0KQWJvdXQgYSBtb250aCBhZ28gdGhlcmUgd2FzIGRpc2N1
c3Npb24gYWJvdXQgZ3NzcHJveHksIGluY2x1ZGluZyB1c2UgZm9yIA0KY3JvbiBqb2JzLg0KDQpJ
IGp1c3QgZGlkIHNvbWUgdGVzdGluZy4gV2l0aCBjb25zdHJhaW5lZCBkZWxlZ2F0aW9uIEkgY2Fu
IG1ha2UgY3JvbiANCmpvYnMgd29yay4gSG93ZXZlciB3aGVuIEkgZG8sIG5vcm1hbCB1c2VycyBj
YW4gbm8gbG9uZ2VyIHVzZSBORlMuIEl0IA0KYXBwZWFycyB0aGF0IHdoZW4gcnBjLmdzc2QgaGFz
IEdTU19VU0VfUFJPWFkgc2V0LCBpdCBhbHdheXMgdXNlcyB0aGUgDQpwcm94eS4gU28gbm9ybWFs
IEtlcmJlcm9zIHRpY2tldHMgZnJvbSBsb2dpbiBvciBzc2ggZG9uJ3Qgd29yay4gSSBsb29rZWQg
DQphdCB0aGUgc291cmNlIGZvciBnc3Nwcm94eS4gSXQgYXBwZWFycyB0aGF0IHdoZW4gaW1wZXJz
b25hdGlvbiBpcyB0dXJuZWQgDQpvbiwgaXQgYWx3YXlzIHRyaWVzIHRvIGltcGVyc29uYXRlLiZu
YnNwO0l0IGRvZXNuJ3QgY2hlY2sgaWYgdGhlcmUncyBhIA0KVEdUIHRoYXQgd291bGQgYWxsb3cg
aXQgdG8gZ2V0IGEgbm9ybWFsIHNlcnZpY2UgdGlja2V0Lg0KDQo=

