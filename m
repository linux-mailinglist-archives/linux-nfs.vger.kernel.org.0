Return-Path: <linux-nfs+bounces-3319-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C78AB8CB125
	for <lists+linux-nfs@lfdr.de>; Tue, 21 May 2024 17:24:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55C442832ED
	for <lists+linux-nfs@lfdr.de>; Tue, 21 May 2024 15:24:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04247142E7E;
	Tue, 21 May 2024 15:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Fo5vYuyJ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="IMHG5lD/"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E69821FDD
	for <linux-nfs@vger.kernel.org>; Tue, 21 May 2024 15:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716305079; cv=fail; b=en/f9qfHFZAyRhBz/GQ7Ejkh0TObsw9JhoYOMVTS8huTZpGmUX7WfTxcYQd9o+G0J8r3OE7u5tg4XvBqQ3rlV8ENwGiBf1C/ujKnTjM41/4gZpi99yg55EbHRM7FizPh4sDSFvuwylJAcJlaWsa8AdpWpmnH3jzZ5WipeTmEAUM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716305079; c=relaxed/simple;
	bh=uzKBJgfkGoHj7sjuGyWsoo9Rk7awTc/NJBYwKOH6bl0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Fta5V2ABQ++PdLAETB/PM9XgCp8vpwf0RjFaAz81Vu0XvToDbgrqcwLGzobmIFS1d9/cs3RgNcPfk9IUufwIwBTq7EaO4NxbgmCSP+gtS7GWWi8Kkc5GfMTPQ4d00CV54wJavNLCdw/HwUT3wIJ4AFAmA8FCykb9eJWPxoJG2Hk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Fo5vYuyJ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=IMHG5lD/; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44LCxsxr030135;
	Tue, 21 May 2024 15:24:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=uzKBJgfkGoHj7sjuGyWsoo9Rk7awTc/NJBYwKOH6bl0=;
 b=Fo5vYuyJ/sjS3lwwg4S1Pa6BkSj5TybhiEs3CuyQUNtLRtBYwiwsG1qjEwPsVfDcNwEu
 LYCjSON7J8ogKDV6sD5D8BqjjJP2PG8fZSmwJ5Wbt95Li9pxNCTN9fkLy2IVKAxnLErB
 4vYFgRXz1MinGrwpYCACU96KS2/Q0/2h+OVm8anZEqpIIl8Fy4NXYNxGHRhiYgkloRdI
 57W76mKUePHqjPlN6NjGaLhAvX7UsQl5XSNQFG98UcAmVnlxM6wkDVe2qnw3H2fob+UT
 VBOVb4wvETQZ9Ho/f1h9K02hYC7hkxD3grmPXO6li6cvr/GSxwMO9hdEKWsitgYUYs5c kQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3y6k465pk2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 21 May 2024 15:24:22 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44LFNKfh038571;
	Tue, 21 May 2024 15:24:21 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3y6jsdvx09-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 21 May 2024 15:24:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UBN49u6L6uRRaRXB/sA7na/kgxQUAwqpIWYMGmE8TNdayxmB9M1bukTj/PZkvFq5M7yauy27HXwsWvdx489C7jQSHmDm20DmJeSFXA/Cw9LwyUJmFsllmpK51BO+J/zLoFoYjx6QvAG6hTbrv3s5FaEE4KyeUAugSB1u2WKiD2x0YR1uxQ4zSRWPZmfnO+i6gW2AlweZ2jIJCYcYixi8lm1pH7F/O4xTKWjmsljJiRGeejGM2lsxKK5YrVsvzk3PluYh1JRbCbWayNAEG2YBJRO7x5oU/Avtz4l3+XvHTEZsPHuwKO1yb6aky9Y5mRwDF9DWwNJsamaT4D7aX7hHAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uzKBJgfkGoHj7sjuGyWsoo9Rk7awTc/NJBYwKOH6bl0=;
 b=YeoaIzybq3OYxNQmc6rdWXgdRLYyNyJ9WzysMUWdFRfZu00BRM2ns0gPgZM3DoQCIY+7sIwFStrz1QLTQgPto6+LlYV4O83AR0Afz4PCe1xd+fHWWnfRIiPqidfhK97m7SlCpLepBUyZosdrnr/NA44KDx2NtMQwXVllOo56lSYHWsRd1h/OjqVbxXsn0BVn9j4lcFb6/TdnjuGAnQsNGC00IjDF9jItftwCaShqN17nwv2yScB91fitHQehU5bs9Ij+ivXiNeYMbdLAVdRDJ6H/GHvQ3S8J+t2A5/854S6RZsHO9Udex2F3xEl5QfIGKve+tqG2AjWYrViJfbw7mA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uzKBJgfkGoHj7sjuGyWsoo9Rk7awTc/NJBYwKOH6bl0=;
 b=IMHG5lD/LE7Xxm5h035PJ2+u65igBgOeNSCyEKpIeyIrP3AwDm7/C6ugJNvS/i503K+kvVmgAOGpP2CHvHobvkoycO0ncFnhAIWo3hzGva5uFgdqIb+PreUbcJbzCfiAsWS7RbnqqgrTCWfOz39LMzPm6mmjvkIrP1fb6zHh4no=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH0PR10MB4906.namprd10.prod.outlook.com (2603:10b6:610:c6::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Tue, 21 May
 2024 15:24:19 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.7587.035; Tue, 21 May 2024
 15:24:19 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Trond Myklebust <trondmy@hammerspace.com>
CC: Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "sagi@grimberg.me"
	<sagi@grimberg.me>,
        "jlayton@kernel.org" <jlayton@kernel.org>, "hch@lst.de"
	<hch@lst.de>,
        "dan.aloni@vastdata.com" <dan.aloni@vastdata.com>
Subject: Re: [PATCH rfc] nfs: propagate readlink errors in nfs_symlink_filler
Thread-Topic: [PATCH rfc] nfs: propagate readlink errors in nfs_symlink_filler
Thread-Index: AQHaq36gHq3sfVU9sUex0MXdV/N5jbGhrPIAgAAczACAAAIIAIAAAxaA
Date: Tue, 21 May 2024 15:24:19 +0000
Message-ID: <53269EF0-4995-474B-9460-29A640E8A46F@oracle.com>
References: <20240521125840.186618-1-sagi@grimberg.me>
 <fa1a77fee6403454444fffce839924157778df95.camel@kernel.org>
 <ac2bfa20-d952-4917-8a70-1e821f9b57ca@grimberg.me>
 <d5409ff9ce51e439f442abb1cded7c7ab732b726.camel@hammerspace.com>
In-Reply-To: <d5409ff9ce51e439f442abb1cded7c7ab732b726.camel@hammerspace.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.500.171.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|CH0PR10MB4906:EE_
x-ms-office365-filtering-correlation-id: 2c38d77e-704f-4128-daff-08dc79aa15b8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info: 
 =?utf-8?B?TUNVdnM2S0JOMVFtZmlqVGg4NVRSS25NWnZnRzJZUERCUTQrMnBZaUZ4YVUw?=
 =?utf-8?B?NVlORituMGMySk8xUXVJTGpZRzRZNmE2YnYrS2FMSEMzV2lsVis4OUFJMlpT?=
 =?utf-8?B?VGxsWGZWLzdFazEwZWZjVzdUTnYzWStyaEFSRjg5SkF3ZWtxS0F2ZU5uNXph?=
 =?utf-8?B?TTVMcnpMamhmNW1tYUNvaDQ3Unl0YlBqZzhqUXEwc09mZTZTd082YVNGemsr?=
 =?utf-8?B?ejVGY1Y3eS9hbmszeVpMb1hqOE9pQlpla0NzNXRyTFZxaFl6U0xXaUViWnJn?=
 =?utf-8?B?L0RySFpMQTU0bEZMajREUUQyWk1BZC8vSXQvaTZvMFFlZlRCTzhPaFJDTFFw?=
 =?utf-8?B?YWFQZVFHaU5tMjl4SEFhd2pZVmQ4VjdyMkEvamhQa3VGOFNKajR6MVhkcHla?=
 =?utf-8?B?TVVGcWJjK29CWG1iMjVObFlXQ09NTCtTWVZpMFREZDhYWlVuV0E1QjNyZSsr?=
 =?utf-8?B?OUx5Z0t6c3RPc0VQMHlyOExiWnNIUW9ISlVEazlpL1pIWUFENXNHeXBaa01N?=
 =?utf-8?B?WXFEbE9CUklyZzBpRzdBajJuV2xLOGNUajJ2cTZNNG1McnNuY2hMTzk1NWI0?=
 =?utf-8?B?djNRNUh3VVlyemlPR2pIazFQWVdNU3Y1UE1WY2p4b3JsdzduU3Q0czRNTnBp?=
 =?utf-8?B?S0FtYUpKdldBOUUrajI3Z21BTFhQYUs3NzNmQlhqNkUxMkU2WkR5eWNIUG9U?=
 =?utf-8?B?Mk9PWFBVbHZBR1NZSCtaR3BkQ3hjMUZaQnorZWdoYlVBRCtYTk5PM3NYMEZW?=
 =?utf-8?B?QVpFYmRjT01XTlIwQXNqY1MxcDJMY3pOa0ZzY011c3VCZ2VqdEMxSWJwQW5B?=
 =?utf-8?B?T21BM2Y0V3VPZzVpM2hQSmJxbzcwa3VLMHNkWHdObUNnQkt6MzFDeG41VEVl?=
 =?utf-8?B?WUQ2a04zUkhjSlpnT0xSODM5YXdnLzBoWFNHaVFwRmYzQVNqRi9nbklLU1U3?=
 =?utf-8?B?V0FKYW9MVll2L2JLMUJIRjlFbjhZY0dQTUxNMkp2RUR2QTVYTjJmcS9KZWZk?=
 =?utf-8?B?SFUzaTNjY1F2U0hNay9UQUhwbVhoRFQwdVdRZkRqQk1KaDhGTzBKQ1RZZUNF?=
 =?utf-8?B?SklNVm1RMis3MFVlb1RDRURSREk3R3ZoYldCNDNtZWZDMFNnbFErWHY1a044?=
 =?utf-8?B?aHhxOHNQQXFHZGVjSTVqREQyeldaTjkzMWxEOGF0a1J1aFNRUzdIMUJ5SFRS?=
 =?utf-8?B?RGNOdmJzWGVMNkR3dXdwUnJtUlcwTUNIRU1UV2RTbEhDcFR4Si9qOGFRN3ky?=
 =?utf-8?B?NWlPZnRsaEVKR3hDT0lTRjJSNkJ5WTlJRms3VlhuYnZhRHo1eWpvL0dOd3Nn?=
 =?utf-8?B?THBPbGF4WlJBbVppaEw4RFlhSzByaDFQMFFFWnFxOC8vV3Y2TDZCRDdJRXlW?=
 =?utf-8?B?Z01Eb1I2Y295czJLdTE4ZmFkelpPWDkrdU1BSzBFTkVqMWE1L09wWTBUQzQ1?=
 =?utf-8?B?OWFGZmd5VkFzRFRqdDZ6QldJZUlualByMUtPQStyTWsyUmVSM1ZwUVgxUG8r?=
 =?utf-8?B?blV4Q1dUY2JLayttV0ZUSUI5Qk5RcWIrdFJ4SkpYK0lRMkZMaXptaVpab0pS?=
 =?utf-8?B?a0VBTVpjaXF6T09Bb0E0N0E0R0NFcmFvNHRpWmtnVEx4Skdna3Eza2Fpd3Fq?=
 =?utf-8?B?N1lFdXdIQVRTT1ozYzJnRXJMT0JETWl4T1VhMU42enVoS01xOFZFTFkzaVJo?=
 =?utf-8?B?MkdYVTZLT2hWMzZNS0NDbEZDZzFOSEJPam43eldSVmxEWVZVNy8vWGRpdkJ3?=
 =?utf-8?B?T0d3ZnF4K0ZXNkZOTTBMZFNDV3czdEZFNVc2cGxPd0hZdUNHZms3UHNvU2VG?=
 =?utf-8?B?WjFleUpSMjRWQS90VGZxdz09?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?QWtweDJxT3dKbFFrU1RSaWZKckhnQkRhblYwbG05RHlJM3FZdFJIa3pISlJX?=
 =?utf-8?B?Y1RjNHR2WE9SL2IyQnZJME1KdHp2T2lIR1JWRjVuMXpHb2cwTjIwNHl3alhW?=
 =?utf-8?B?OXJTdkFDc2NsalQ4NVVXakVBbUl1Y0hVT1JOTytFeWdpMUp3c0VjOXR1SFY5?=
 =?utf-8?B?aXVtNjM4OHNxdUIvWEFlTjdsWTJrdlVRZWlIT1NxZmZpTmJLOTVSOFZ0NWVX?=
 =?utf-8?B?SW5LbndTK3d3Z1ZmVXVtSlV3aWdHUkY2bXlkSTBVbFFTMmdlOXdWUngwa2M5?=
 =?utf-8?B?SkNOd0NZQlBpUFhoK3ZnL0NPT1F5MDJCVndscTM1bVVTQjF0cHBIQ3NYa2tJ?=
 =?utf-8?B?NmhrYTdWQ1lUV1gvNmV0OUsrcHJuWkliRmphZUpkSEN0REVzMExneEt5VTZh?=
 =?utf-8?B?VCtLdy9reW5FNzcyT0lOdENNYmFjdkcza0NPZ1hLYkRkQk82VjhtUUpFQUFH?=
 =?utf-8?B?RmpmczlCdzhKVnlNM1pWWElEU2F6MFFFTWxwMU5wclhyNTV3WUJkZVRsckJi?=
 =?utf-8?B?SlBoMjN2ZGlHZW9Zd1Q2QUUwMFdpOUVhL3hVU2xYcUc1WDlPY0V2UkhMd2hL?=
 =?utf-8?B?YXk2cXNGcGtQeE8vNmZ5SzJSRFNxTVhVMnNNdHNoREt0cTZGelc5dllwT1lU?=
 =?utf-8?B?Y3ZycTR3SkJmeVdDUTQ2QWxxOU5JcDNxZGhlZzZNOE5CNHpSMlY2S0hWcVdw?=
 =?utf-8?B?YWFPR1RoRk1VeGsrWGxhVXhvZ1FwZVdsajVtSUNIT3gybW1WSkI0N0N1ZUFV?=
 =?utf-8?B?aTBZc01OK3BhSXhXUVZ4Q0lRMUVuU21mU05mei9MK1hveElZVnNKbHdPNk5r?=
 =?utf-8?B?K1E2NC96NlNZSmFCdmwxNmJZVmJIZm1lUnhYTnI0QTc4OTlxL2F5THUrNE52?=
 =?utf-8?B?THlGVkNzUEdrOGpXZTFndTBNaXVpdW41VHJZYWowU2w3M1pkNHBqTHRsN3lM?=
 =?utf-8?B?NkovalVvRDJNRW9pbDJvZGtxUUxLWGhLY1FiTFVjdmNCUXkrbWdsWmxNbmpT?=
 =?utf-8?B?MkcxcWh5aWVlWUttSWtKbWdxSklUeDRienloMUNIaU9RRnZVeTZaMFNFS0Ev?=
 =?utf-8?B?TEZJRXhudWZXNHNqWGZNSmVnaHo0TktUcm8yNllmR1F2K05hZm1tNFBNNzQ3?=
 =?utf-8?B?Q2x5eEdhejBjOXB1Z2N0NzNyUk9MdGlVT1BYcEZXZ3gzbUR6aFkrTFM1SXh2?=
 =?utf-8?B?QWtPY3RpdDRYdEhaRjg2UXBmZ2xqZkNuTEpkREMwZDcvVjZyTS91SGIvZ3hj?=
 =?utf-8?B?SWwyVExlU2djMXEyemFVS25mbzZ4RG02NzJkN2RLQVNXdnRBNUowMTMvWXd6?=
 =?utf-8?B?T09HcG5PMGxZNTFWRk1QTkRERmpibi9DMlBoSmRhd3dpQnliSTkzTGkrRlpS?=
 =?utf-8?B?bVFKTWN0a1RTc3d6ZWsrNytyUWhmUjZqWHlWdCs1Ky9RZ25MTUMrR3JNdXlz?=
 =?utf-8?B?ZUtZZEtDRE85b3FkaTZ6bGQ5dUpnWERWNWQ3N0wrUFFYMHY1eU5mQTBReDZL?=
 =?utf-8?B?WGJoTWVIZkNQaFpqT24wdXhnMzI0dUZWRU91d1JPaDhOVnhuOGxpVEE2TFJl?=
 =?utf-8?B?MU1XY1gyeWZmNFN5K2RtYUwzRmpMTUFMMCswMm5RTlAzbzVhTXdId1FEUXZX?=
 =?utf-8?B?S0RESHdtLzZucEpIQ0VqSFc4MTNMUjZaVzFXTWczMTBLRXkwbzRxK29YNW1I?=
 =?utf-8?B?N2FBU0FKdkpSMzFldEk0eFhEdWhwdmxFZ1pSa3JXTW4ySW1HWnBHejBmZGRR?=
 =?utf-8?B?dEdQK1c2QndXNFpKalNvQ29jMlJmUVB1WXM2MG4zdkJsQ052a1EzcjVzK2JN?=
 =?utf-8?B?Vi9mZWp3SlRMS25CajV3dU9JUi9CZGUvMUh2WWtMSlJUZ2t4TnAvR3R1RW9B?=
 =?utf-8?B?T3RLTVQrTnU0Yi9ldVUxdUdhNk5zQ3YwbW5DTlBkYVpmdXhsQTRTMWljQ015?=
 =?utf-8?B?UU5pVzBXcDJDS0U1YTcrd0NsbE1oK0ZtUUF2MHlrMGpoUXN1RWtYVy9iZlI5?=
 =?utf-8?B?ZUIzNEtIVmJodHd0WTlkbE00ejdHdHBPQjN2WndSZ2k1cW5kdTFCdTNseUhq?=
 =?utf-8?B?Y3paR21PSEdJa1BEZi9ZdmZvcHFBdDViMExqWVN5bllmK0Z6b1prbzYxYzVp?=
 =?utf-8?B?dWRYZDI3Q3ZUMUNEMTlZNTlpSnV1M3I5cFc2NFhtNVlFUDc2a3VjS2pQdVgv?=
 =?utf-8?B?d2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <273A4CB4A1C6A14B824EB9A19B424287@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	NEANxjhBPbQrD/Im8YJRF5w5vyS1vqF16J9sPfXV1FhGgXEx39Z+hKKZbjwHCWg14OJGuneJPGXfzZXEXgErzu1QO4oNUNbZO4rPTU36QKx3t7tJkr+P/RbA0Z2BMIwV75dlsZmyBysQk6oy4Qe3yLby8srOxhXn1txCp/0iOPh83N/bVmMWy9k8KC+JCT7m/uMSj0AT/EdkMoTWgCL9AKyxi9Qab45rSPROIJ+esj4BBB49d/ccsf3gD3hfdx0M6GWvRkPoMGOiUAGB7/X/kZY6E3WDfghG9Gh1ai3+60BVIUhQHl4qUNGVVf+WykPe2D0cqBKGtRbd/l99uH3SfUPkcA6WBbBsfBJ9HLlWBtBEEkQVj3+zpTLdouJlkt46ZTZGHjjA7GBxxf/11i2h2R5v2sb2psHl7pi4RRdfJIG0RVCtffnCulb4KnIrsKCsrh0FMCI4SW/htpivxlDdfW50mpLw+23nCoDllO+XBqbYo3gwVFFXi8e/fh4Khh7Ma+EF/QkbPEFQTtLJMQVxNU/O6bzopEQqYpFEvwlD5h7MfLUXfrSq1bHHnTYmM5BRVn1m4+5m7PRQqepZW1uJH5KCKtipZV4oU7OtqkC3RGA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c38d77e-704f-4128-daff-08dc79aa15b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2024 15:24:19.5069
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LS+66xHkl1Mt3kE4Ao+YurVtwa5HRNuAX+uDYFdbHFzXvtWL0SuUXMZPjU6wG8brzVBwLXfutfTDJ7CBxcSzpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4906
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-21_09,2024-05-21_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 mlxlogscore=999 bulkscore=0 spamscore=0 malwarescore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405210116
X-Proofpoint-ORIG-GUID: C68voa3nMiOlcBeMplWU5m2HyNFPzmIY
X-Proofpoint-GUID: C68voa3nMiOlcBeMplWU5m2HyNFPzmIY

DQoNCj4gT24gTWF5IDIxLCAyMDI0LCBhdCAxMToxM+KAr0FNLCBUcm9uZCBNeWtsZWJ1c3QgPHRy
b25kbXlAaGFtbWVyc3BhY2UuY29tPiB3cm90ZToNCj4gDQo+IE9uIFR1ZSwgMjAyNC0wNS0yMSBh
dCAxODowNSArMDMwMCwgU2FnaSBHcmltYmVyZyB3cm90ZToNCj4+IA0KPj4gDQo+PiBPbiAyMS8w
NS8yMDI0IDE2OjIyLCBKZWZmIExheXRvbiB3cm90ZToNCj4+PiBPbiBUdWUsIDIwMjQtMDUtMjEg
YXQgMTU6NTggKzAzMDAsIFNhZ2kgR3JpbWJlcmcgd3JvdGU6DQo+Pj4+IFRoZXJlIGlzIGFuIGlu
aGVyZW50IHJhY2Ugd2hlcmUgYSBzeW1saW5rIGZpbGUgbWF5IGhhdmUgYmVlbg0KPj4+PiBvdmVy
cmlkZW4NCj4+Pj4gKGJ5IGEgZGlmZmVyZW50IGNsaWVudCkgYmV0d2VlbiBsb29rdXAgYW5kIHJl
YWRsaW5rLCByZXN1bHRpbmcgaW4NCj4+Pj4gYQ0KPj4+PiBzcHVyaW91cyBFSU8gZXJyb3IgcmV0
dXJuZWQgdG8gdXNlcnNwYWNlLiBGaXggdGhpcyBieSBwcm9wYWdhdGluZw0KPj4+PiBiYWNrDQo+
Pj4+IEVTVEFMRSBlcnJvcnMgc3VjaCB0aGF0IHRoZSB2ZnMgd2lsbCByZXRyeSB0aGUgbG9va3Vw
L2dldF9saW5rDQo+Pj4+IChzaW1pbGFyDQo+Pj4+IHRvIG5mczRfZmlsZV9vcGVuKSBhdCBsZWFz
dCBvbmNlLg0KPj4+PiANCj4+Pj4gQ2M6IERhbiBBbG9uaSA8ZGFuLmFsb25pQHZhc3RkYXRhLmNv
bT4NCj4+Pj4gU2lnbmVkLW9mZi1ieTogU2FnaSBHcmltYmVyZyA8c2FnaUBncmltYmVyZy5tZT4N
Cj4+Pj4gLS0tDQo+Pj4+IE5vdGUgdGhhdCB3aXRoIHRoaXMgY2hhbmdlIHRoZSB2ZnMgc2hvdWxk
IHJldHJ5IG9uY2UgZm9yDQo+Pj4+IEVTVEFMRSBlcnJvcnMuIEhvd2V2ZXIgd2l0aCBhbiBhcnRp
ZmljaWFsIHJlcHJvZHVjZXIgb2YgaGlnaA0KPj4+PiBmcmVxdWVuY3kgc3ltbGluayBvdmVycmlk
ZXMsIG5vdGhpbmcgcHJldmVudHMgdGhlIHJldHJ5IHRvDQo+Pj4+IGFsc28gZW5jb3VudGVyIEVT
VEFMRSwgcHJvcGFnYXRpbmcgdGhlIGVycm9yIGJhY2sgdG8gdXNlcnNwYWNlLg0KPj4+PiBUaGUg
bWFuIHBhZ2VzIGZvciBvcGVuYXQvcmVhZGxpbmthdCBkbyBub3QgbGlzdCBhbiBFU1RBTEUgZXJy
bm8uDQo+Pj4+IA0KPj4+PiBBbiBhbHRlcm5hdGl2ZSBhdHRlbXB0IChpbXBsZW1lbnRlZCBieSBE
YW4pIHdhcyBhIGxvY2FsIHJldHJ5DQo+Pj4+IGxvb3ANCj4+Pj4gaW4gbmZzX2dldF9saW5rKCks
IGlmIHRoaXMgaXMgYW4gYXBwbGljYWJsZSBhcHByb2FjaCwgRGFuIGNhbg0KPj4+PiBzaGFyZSBo
aXMgcGF0Y2ggaW5zdGVhZC4NCj4+Pj4gDQo+Pj4+ICAgZnMvbmZzL3N5bWxpbmsuYyB8IDIgKy0N
Cj4+Pj4gICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4+
Pj4gDQo+Pj4+IGRpZmYgLS1naXQgYS9mcy9uZnMvc3ltbGluay5jIGIvZnMvbmZzL3N5bWxpbmsu
Yw0KPj4+PiBpbmRleCAwZTI3YTJlNGU2OGIuLjEzODE4MTI5ZDI2OCAxMDA2NDQNCj4+Pj4gLS0t
IGEvZnMvbmZzL3N5bWxpbmsuYw0KPj4+PiArKysgYi9mcy9uZnMvc3ltbGluay5jDQo+Pj4+IEBA
IC00MSw3ICs0MSw3IEBAIHN0YXRpYyBpbnQgbmZzX3N5bWxpbmtfZmlsbGVyKHN0cnVjdCBmaWxl
DQo+Pj4+ICpmaWxlLCBzdHJ1Y3QgZm9saW8gKmZvbGlvKQ0KPj4+PiAgIGVycm9yOg0KPj4+PiAg
ICBmb2xpb19zZXRfZXJyb3IoZm9saW8pOw0KPj4+PiAgICBmb2xpb191bmxvY2soZm9saW8pOw0K
Pj4+PiAtIHJldHVybiAtRUlPOw0KPj4+PiArIHJldHVybiBlcnJvcjsNCj4+Pj4gICB9DQo+Pj4+
ICAgDQo+Pj4+ICAgc3RhdGljIGNvbnN0IGNoYXIgKm5mc19nZXRfbGluayhzdHJ1Y3QgZGVudHJ5
ICpkZW50cnksDQo+Pj4gZ2l0IGJsYW1lIHNlZW1zIHRvIGluZGljYXRlIHRoYXQgd2UndmUgcmV0
dXJuZWQgLUVJTyBoZXJlIHNpbmNlIHRoZQ0KPj4+IGJlZ2lubmluZyBvZiB0aGUgZ2l0IGVyYSAo
YW5kIGxpa2VseSBsb25nIGJlZm9yZSB0aGF0KS4gSSBzZWUgbm8NCj4+PiByZWFzb24NCj4+PiBm
b3IgdXMgdG8gY2xvYWsgdGhlIHJlYWwgZXJyb3IgdGhlcmUgdGhvdWdoLCBlc3BlY2lhbGx5IHdp
dGgNCj4+PiBzb21ldGhpbmcNCj4+PiBsaWtlIGFuIEVTVEFMRSBlcnJvci4NCj4+PiANCj4+PiAg
ICAgIFJldmlld2VkLWJ5OiBKZWZmIExheXRvbiA8amxheXRvbkBrZXJuZWwub3JnPg0KPj4+IA0K
Pj4+IEZXSVcsIEkgdGhpbmsgd2Ugc2hvdWxkbid0IHRyeSB0byBkbyBhbnkgcmV0cnkgbG9vcGlu
ZyBvbiBFU1RBTEUNCj4+PiBiZXlvbmQNCj4+PiB3aGF0IHdlIGFscmVhZHkgZG8uDQo+Pj4gDQo+
Pj4gWWVzLCB3ZSBjYW4gc29tZXRpbWVzIHRyaWdnZXIgRVNUQUxFIGVycm9ycyB0byBidWJibGUg
dXAgdG8NCj4+PiB1c2VybGFuZCBpZg0KPj4+IHdlIHJlYWxseSB0aHJhc2ggdGhlIHVuZGVybHlp
bmcgZmlsZXN5c3RlbSB3aGVuIHRlc3RpbmcsIGJ1dCBJDQo+Pj4gdGhpbmsNCj4+PiB0aGF0J3Mg
YWN0dWFsbHkgZGVzaXJhYmxlOg0KPj4gDQo+PiBSZXR1cm5pbmcgRVNUQUxFIHdvdWxkIGJlIGFu
IGltcHJvdmVtZW50IG92ZXIgcmV0dXJuaW5nIEVJTyBJTU8sDQo+PiBidXQgaXQgbWF5IGJlIHN1
cnByaXNpbmcgZm9yIHVzZXJzcGFjZSB0byBzZWUgYW4gdW5kb2N1bWVudGVkIGVycm5vLg0KPj4g
TWF5YmUgdGhlIG1hbiBwYWdlcyBjYW4gYmUgYW1lbmRlZD8NCj4+IA0KPj4+IA0KPj4+IElmIHlv
dSBoYXZlIHJlYWwgd29ya2xvYWRzIGFjcm9zcyBtdWx0aXBsZSBtYWNoaW5lcyB0aGF0IGFyZSBy
YWNpbmcNCj4+PiB3aXRoIG90aGVyIHRoYXQgdGlnaHRseSwgdGhlbiB5b3Ugc2hvdWxkIHByb2Jh
Ymx5IGJlIHVzaW5nIHNvbWUNCj4+PiBzb3J0IG9mDQo+Pj4gbG9ja2luZyBvciBvdGhlciBzeW5j
aHJvbml6YXRpb24uIElmIGl0J3MgY2xldmVyIGVub3VnaCB0aGF0IGl0DQo+Pj4gZG9lc24nJ3Qg
bmVlZCB0aGF0LCB0aGVuIGl0IHNob3VsZCBiZSBhYmxlIHRvIGRlYWwgd2l0aCB0aGUNCj4+PiBv
Y2Nhc2lvbmFsDQo+Pj4gRVNUQUxFIGVycm9yIGJ5IHJldHJ5aW5nIG9uIGl0cyBvd24uDQo+PiAN
Cj4+IEkgdGVuZCB0byBhZ3JlZS4gRldJVyBTb2xhcmlzIGhhcyBhIGNvbmZpZyBrbm9iIGZvciBu
dW1iZXIgb2Ygc3RhbGUNCj4+IHJldHJpZXMNCj4+IGl0IGRvZXMsIG1heWJlIHRoZXJlIGlzIGFu
IGFwcGV0aXRlIHRvIGhhdmUgc29tZXRoaW5nIGxpa2UgdGhhdCBhcw0KPj4gd2VsbD8NCj4+IA0K
PiANCj4gQW55IHJlYXNvbiB3aHkgd2UgY291bGRuJ3QganVzdCByZXR1cm4gRU5PRU5UIGluIHRo
ZSBjYXNlIHdoZXJlIHRoZQ0KPiBmaWxlaGFuZGxlIGlzIHN0YWxlPyBUaGVyZSB3aWxsIGhhdmUg
YmVlbiBhbiB1bmxpbmsoKSBvbiB0aGUgc3ltbGluayBhdA0KPiBzb21lIHBvaW50IGluIHRoZSBy
ZWNlbnQgcGFzdC4NCg0KVG8gbWUgRU5PRU5UIGlzIHByZWZlcmFibGUgdG8gYm90aCBFSU8gYW5k
IEVTVEFMRS4NCg0KDQotLQ0KQ2h1Y2sgTGV2ZXINCg0KDQo=

