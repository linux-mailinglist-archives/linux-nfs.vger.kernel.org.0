Return-Path: <linux-nfs+bounces-10139-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CABCA36F78
	for <lists+linux-nfs@lfdr.de>; Sat, 15 Feb 2025 17:30:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF07217081B
	for <lists+linux-nfs@lfdr.de>; Sat, 15 Feb 2025 16:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 626A61624F0;
	Sat, 15 Feb 2025 16:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WYIDHQte";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Mo2Zj71Y"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CD411DF98C
	for <linux-nfs@vger.kernel.org>; Sat, 15 Feb 2025 16:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739637010; cv=fail; b=Ose1LrRUjRs/BFchEhaAdga7HZonSNP4lWdXT2fMPEccmD1rqOBWw7+rZo13mGbBLX6cunJeE6rh0Q4TcaOHQVfh7Ytxod2HSNidFFT7Dp1NOAbgY9hafUfkhC7Hm2o6nm194Qa0vHeIrst/bdvUGFXz0zgAE3zRFm1EwchMK3k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739637010; c=relaxed/simple;
	bh=5C3e23LjFXgNUsXG54kdsYywiYWHdNHV2K/SaZJgH5E=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=adLFHTzaPY9f7+hIpdiGc+ytTIuhuM3bdJAsLvo8SvtDvC2HAV6BfTESCEO0e2PvFQ5cyA5adflZZTbJFDk01MRQohR+6j9rnVjkESbZCazSbE+sGhgl3xLL7b2tmsd2bJhVrRFxjw9DJTVvK0AnWNl6D+9ejau0wXV0+hocq7A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=WYIDHQte; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Mo2Zj71Y; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51FCasb9013323;
	Sat, 15 Feb 2025 16:29:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=2QxrDs2bQACU2VtQI8rZX11FXcoI7w71eSjoda72IZE=; b=
	WYIDHQte7Wkg6pbKdZV4n7Bmn7tWssbQsomEmN2sOeSP/q3XvY/8H2+Fqt/J9v0w
	+Tm/Ehftf39303d2JYFDe3K8XNfl89CJn/lPN9BPVrjiHWxHaHGxm7LjXXwOPrkR
	WeMP8u+Ulh9rPuKzjrqPxVEzfut8DgLquAnQAg3iKlMy1EzsVGV3xpJumok4q3Hl
	s5un5DQEqj0T/NrCxj6WFPw9XUmtwWdfnxI1KHus9Xu0iV1lcOo+fr7s1xxrNHsV
	DxdAjBMSLsYmtbIKL4Qtj0aGdoDy05gKKbawYxjOx36N8iCAhFJqzUKy3W1FFpUJ
	0gQXzXVtZda814ejNgQikQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44thbc8hwf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 15 Feb 2025 16:29:50 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51FFVaKM028343;
	Sat, 15 Feb 2025 16:29:49 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44thc65mg5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 15 Feb 2025 16:29:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aRKPs2HGXDnvuMQ2JTILfyHe7tlo9GqewOZs2Jbugf+Ws6/TjAvtjSpxiJng8NAscUSZkELHgD440H9pINTHbwMK1SKubXdURvpB4pgZDv7kuaZtcSbIkf4dVMliuxtpQLovR50sgYfkPILJ83Bf0tVdlHuuB6YTEqiVCAKnJcAirikVVDLxBZVI4FAPFAbJzdRNvmZ1ge2zfWqQrOhIzFtlWdp8dx4m+0ZEetMs99nsJ+Ou1nLanQAyS1wyvALsEDdOB5KquoFUNQYU566He61uwzv15VL0GpEranTNIwWoEFubuokGhO94XEVVlp5WS3TcizZdjFgrnnkMUHfoqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2QxrDs2bQACU2VtQI8rZX11FXcoI7w71eSjoda72IZE=;
 b=jBuOlcUTcYgolXi4izRFBgzmjmiyiNfKU49Jp+m0B6ogPr5fbBjAX+rYvLhEAEv10hTqFQC4Je4dnFkmlnsuaOYqm0jxwMkhaYrI9rmJb+UqkDIvigsZ1UcVNZx9kNf4PsTJBiUnoayszkeDg2Kr+RcA9G+umzymz/AX2hnmpnQebooQmaKDXvycYqNmy/nFFPR2NkM04u7/PHELX9KdH6ncc3aiKmRp/BW0q7pZ0bFFMXfvWviXQ6wTyePOV57RXA6v+q20n1HkRWEnhSuLml3r7UhT1A6Hq3JXKHPW0sL7BEeyHrjedbtIyEHkqtbH4PGdHuwC59icVmuZvFfZRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2QxrDs2bQACU2VtQI8rZX11FXcoI7w71eSjoda72IZE=;
 b=Mo2Zj71Y98oO1oTs/ksPi4jF+sNx38aN1v2pst0z1hdKU0uJiqsb5VhsrHf7MROMJux1RzXS6a5mzALoq9PQXPnNA0wM/rEzpnfE6bKhWROJOwhU3zYouNXGfhpnCn19JLAz8l5pSxkgOujfaEQFqXkq4z32ZCuCvF9hnl0TFK0=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BN0PR10MB5141.namprd10.prod.outlook.com (2603:10b6:408:125::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.18; Sat, 15 Feb
 2025 16:29:47 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.8445.017; Sat, 15 Feb 2025
 16:29:47 +0000
Message-ID: <4c790142-7126-413d-a2f3-bb080bb26ce6@oracle.com>
Date: Sat, 15 Feb 2025 11:29:45 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: nfs compile error nfslocalio.o and localio.o since v6.14-rc1
To: =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>,
        Mike Snitzer <snitzer@redhat.com>
Cc: linux-nfs@vger.kernel.org
References: <20250215120054.mfvr2fzs5426bthx@pali>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20250215120054.mfvr2fzs5426bthx@pali>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH3P220CA0029.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:610:1e8::11) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|BN0PR10MB5141:EE_
X-MS-Office365-Filtering-Correlation-Id: 6aaaab7a-4770-42c2-f458-08dd4dddf637
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WkhISWF5OFAwTTBXNmV1eHNBVXRFZTdEVDF2ZVBvY1FpZ1p1TmpsUndqL2Y1?=
 =?utf-8?B?L0tiZUFtUDNhM2N1NG5vU0o1dVdMZVR0Ryt5VndSMjNpTVFnaWNHZDc5T1Vs?=
 =?utf-8?B?L0J4WWJQcmhVRGFBVXFVbUFPUEM5MGJpRVg1eDg5ajdOS2tNczFyWUNZWWtt?=
 =?utf-8?B?V2pIUmtDVGJud1ZtRTB4em9MbUxFZEdDejlDdEtuWW13WDQwbEhYT0JveVBY?=
 =?utf-8?B?T2Rib3lYMGwwVkNWdUluZTFjZ1JWenZ1TWFmRjZLOVR6dUZwQ1JNaGZ5MktT?=
 =?utf-8?B?UG90WHVselhDa0NBS1lHc0VoOFp0UStqazJPRGRUL1E0S1ZvZTF3eFArbStI?=
 =?utf-8?B?d2NXV3NEemxzelNuaittV2R1Z3lVTzBTSk96UXVKWXgzZkpnZW42Qy82Vjlx?=
 =?utf-8?B?eXhpcnZJOGxJczFPcVozRTFWeHQvSEJCM1NQcDA2c2E2eXJod3NORlFNOGtt?=
 =?utf-8?B?RGc4SHk1ZHhCS3hRY08wQnBOTW0xUXhIN04rb3pQOUlqcVFtNVdwN1BtYUVS?=
 =?utf-8?B?cDgvTG4xWlNoMzhmNTJKRDk2Ymxvazk0clUvcnphbUlvWHJWTFRoVFNiWVRX?=
 =?utf-8?B?eGN3T0lkM0ZyK0dMWjR3RzMycHl1d1dMdTdtT2JYeEExbHNlSloxMUtEMVhK?=
 =?utf-8?B?ekZtVG9pRWRDL2liOWVyTTZLdGhHMDR6QjJ6SDVObWlwaW44VVRkUzhaMWxa?=
 =?utf-8?B?NXptN2FQZWVrNFE5dG5kSVdpaFlyN2JsalRpaDdaa1o2cEE4anlVWlNNMzhp?=
 =?utf-8?B?UzNtbGVBYjhhMnpEOWhiOVdGZ3pZenp0Z0xkNXlUemJjTWMxUVB0RkJHOVZ5?=
 =?utf-8?B?amZ3bFNONVZlNDErV0lJUVBTc3hEejJzUjE0SmlvY21OSGg2TmoxTlFJblVN?=
 =?utf-8?B?VzhDT0x2akFlSlBZYmN4SngySnlsMDNkajhNQ3B4dTgxU1RJOE03dGc0OXlu?=
 =?utf-8?B?N0I0bWowVkdpdVB1ME51REtOdFpiYm1ZcEZnb1pTbGN1UDNZUHp2bFlnSEpS?=
 =?utf-8?B?aWVka0o5akpoaWtlQlpUMVBzNXZXU2VaMkxDa2p3Y3kwNElDUmNpVUVmZzcv?=
 =?utf-8?B?T0M1eDdPTEFaa2RWZWF0bWcxWXF4a3RoUnVSdXp0VTFUaW56aTlwODllc1Iz?=
 =?utf-8?B?bnM3SXBGd1ZuNmtvc1pZOTFISWdscER5dVlnSzJJNXFHd3JUOUJHNXEvc0lP?=
 =?utf-8?B?d0pLeEQ3enhNOGRYU1lxcTh3Vmo4dXo4cjZ3dEMwRjNnSitTT1hZVUlQaXVt?=
 =?utf-8?B?NTFxWEhyMm9HdGFzVC9Pam9zSTlqZm9TNGhMS3VYRDVzRk1ZeFMzWkd5Sjkx?=
 =?utf-8?B?RmNLdG9wQXlTUVRrajFZdEJCR0tzSWp4MG55MEFKQUg3NFJkRW5nZVR5ZDlF?=
 =?utf-8?B?L3JsQUlxMm5YNUNnRW1NZ1c0eEhlcGtqWXhYbHMxcXkrZXFqZGVpeFhwZTZv?=
 =?utf-8?B?aXlMUnBpOXJ4cXU2aXp3VTJMN1F5L01OZ1ZaOG9pUHQ5YTBHSy9sNXdlZWJY?=
 =?utf-8?B?U0c4eURtakpzVGEyZ2Y5VGZjNTFjcDVzYndFTXNYVi9ZYjJHQ2h3cW0rWS9X?=
 =?utf-8?B?RUQ0WnYrcGJheEZzOFlJeUQ0cTNhTnBqTW9xT284V21QcDdhYWlLeVlYKzBY?=
 =?utf-8?B?RmRYZUtYUExPdUFyUGEwMVk5SElEcGZUeE5qRG1CYWdhT0ptbVJyMDNXNUxE?=
 =?utf-8?B?OWtoVU9kajExMStuTE1vdUN2SU9Cdm5TbG5nN0ZKMng5K29sYjNwaW53OXFF?=
 =?utf-8?B?dUxOcExPdURpVEdqN0JqcTJhTlVXd2luZ0F0VUxKUlFIYTZvS0taMXpSTmhI?=
 =?utf-8?B?TjhHZVBlWWk2R3ZRM1BBRVVleUxyRFBmQzdhaWhhR003YXU5cTRuTktWdHZz?=
 =?utf-8?Q?rtcbE8qqv7UG0?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S0pMMWtlZDk2YWd5OXROY21aQ0hOa292S3htRGVtNUg3ZGtkWGdXVTR5bk5H?=
 =?utf-8?B?RmpLSklWL2ZqY2N5QjNIL0RuKzNObkM5TXErNDVyNFFjVytYRWJWR05HSk90?=
 =?utf-8?B?RGd2VmduZjdCL21RQ2VpQ1NoaU1INnM1YnAxVXRyek9GcGM3ZndEUGV5V2Ey?=
 =?utf-8?B?cXpucUsrS1JTYmxMTjVwcnpGLy9GeW80VXFUUGtselBnYkw5YmxxMnlTS0dU?=
 =?utf-8?B?NnhVZE9GMDZ6NHlxUVh1YWtzYkhGbXE1U1VQVTRIenQvRGRPYm1WQjN6c0ph?=
 =?utf-8?B?ZzJjcnZlSURoeFFZK0lEM1dNaHV3QmNkcHVyb2tGSzZCamVSZDRGVVB0M1NS?=
 =?utf-8?B?ZTlOVmJQODFrM1Z2VnlVVjhvTWF4dGJkeEh1dkNleWNlWmg1bHRKbEY5RlpP?=
 =?utf-8?B?Q0U2Mlc0T0hVTzgyMVpaRHRlUkFGd0dBWnBFbVVDVEpLakhOWVN2dFJKSGRi?=
 =?utf-8?B?ZlNBTjhvNkJocE5ZQVJpcmh6aG81S2VkL2Q2dTd1U2IrUUZZTzh4Wm84eHky?=
 =?utf-8?B?N0FEWkFyNnVzL0QrVStvUVdMT2pleUFQc0ZoQ3MzNlJ5OG5wT3h0aHB6MGdB?=
 =?utf-8?B?M0NIWmRUc2dLUnFIQ1l2STU2ZVJrcE9nSG5lS1lqa1Q0Y1JJcENZMWY1RFNq?=
 =?utf-8?B?aFRaY1dCMi9XblJPQUFKL0VkajJkOWlVclcwM20zM0tFeXQrMVpodUdwS1oy?=
 =?utf-8?B?U0RYOGNCNCs2cm9XY1FWaEhTMk93VmpManNHemZBRlpkakg0QXJLSEl3TzRp?=
 =?utf-8?B?c1Y2cDVTVDNsZ2VWSzR4aGZOTWlwQkVkck00akpSMkZnWDhXNXJRcnZ6czkx?=
 =?utf-8?B?dXA0ZnFwU0JXVXltY3NQWVdNV0k3QU9ad3lRMnhld2ZoVTR1Q0hkU3k2b0tX?=
 =?utf-8?B?cnpQWklxRW9iTXlEblJldVRsb2ZPTjQ1STlYdHhqdGFKb1ZUN0Fzck1zMVBx?=
 =?utf-8?B?cXRtZ2NjR20yL3h0a1hmOUxmUGhzMmoza2IyVWUzYkhNZDVVOVNhTFF2c1gr?=
 =?utf-8?B?VjlUTTJEVE9sVHEzQ1NlSVU0WWhIbnhYOVd3dFA5Nzc0b29Nd2pJWCszUlQz?=
 =?utf-8?B?eWdrM3FqK1Q1V1hYY3ZNTkF0ckRIUHpyVFhsejQ0NlFyU3NoQ3g2dXE1Um1U?=
 =?utf-8?B?T0MvMGM4VU13RHZrU3dsbHY0eUJBVEZvYWZQZUd5T1BpU2pnelNCMkhkQWZ0?=
 =?utf-8?B?RTlxNnhFR0E1WS9KWVVvS1RNbkl4R3hQaGZMNzlXY29zT2xIcWhGVENob3Jm?=
 =?utf-8?B?RGZmbUlOMUN3MU9iSDl2d29KTWwyVSsvZ2ZvbC9hLzFSMDBVUlFxZFY3TURY?=
 =?utf-8?B?ZGxFQWN5dlVtZjE5WVpqdzRUaERNdjBPOWpSRFA4YSt2MDRPcDFpZ242Nm9M?=
 =?utf-8?B?ZTVBQXMzOU1iSmd3U0trQmV1RnZxYW1iVU1aczUvTWIxeDdQeXRTa2o3cGJY?=
 =?utf-8?B?L3BJdUVoRmt0bVdYbjU0Uzhhb2M4dnZtSFJWTm1BSlhyZmI5TmNpQU53WVNY?=
 =?utf-8?B?MG5ZSjRUMXpzZ3hLVzV1YWlBemNGRU0wMWZkUHRDWUNHVnNNMnJWL0lSZWNw?=
 =?utf-8?B?UG4yK0FFYU1nRUd4d0NyTkh2MzVxNnluQkRndHAwWnNlZkhJSCtQTjZHaXZa?=
 =?utf-8?B?QmZzVDhUdjFkY1hscVdGN3h1MEVENFFDRUhBcVRFdCtZNHB6Q0VVdUdzaVJY?=
 =?utf-8?B?elppUkZvdGk2bkJvVi80YWtVT0lMUG43UkJLNi9hTVpVNEQyYVp5ckw2MGNn?=
 =?utf-8?B?d00rMmltaWh2UE5iU3dhNzgyN2dWZmFNMXlzV1g2S3VJWDJKVWJSVmVXMmow?=
 =?utf-8?B?SXZPeHptaHJXUVpUQXlBM0RtcnpqRnRVb3JMSlhINEVqUkdZQVVUTkpyS0hE?=
 =?utf-8?B?MUVFcVhrMEZFK3dGVmZZMC8ya3MyYWZOZlFhNWtLQW9TaW8vMTNuUDcwVG1F?=
 =?utf-8?B?RllncWhQeGcrL291aDF6MENpSnlmMkNzV2FqQ0hFUjRON1k2NWoydC9DeGZD?=
 =?utf-8?B?ZmRGRXZ6UXJoUHUxUjdIalRhUG1wRWo1dTVjUWN4SXp4S2M2TVVhMjZxL09r?=
 =?utf-8?B?SjBnRGRheHMvRHkrbGxoK0RUaHFwV0JTQTBSS3BXYlRkYjFuQVJCSVdwN0NP?=
 =?utf-8?Q?Kqtgn0zdBxQEDFHe6ZH4a8skD?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	rrA2ZBQaK+mXFa9Z025bRR1FtP3gYAcqsLJ/gap5kkAs7QT7+kP7DApnU5XuGLAJfKw8RwpfShcrj+Ike8OscMuJ7d2ST9ntC24GK61wTWn7MLuW8+Bnvw54nnEyu/ki17wD947Pf9wdWN8wkCZgadUgLBW13Aq+a2MS7T/7HAv1jMYcrxpYkw1gXdedcPkoZjLs6TQbFmBtCLhGCeWzQQZ8onomjvVaU3socn/Tdf9tRy8EG/8dY3rSTLJBokNn5Ydaa8iDYiw9OmONZjm25X2RSkkP5vRq8HsdVaN/zbd08oviDUHHQGbsfeSo93epem+7ihAJgVqv8tGxdF8t1kNiGylarfB9rz/6C/4rrPPdtmAaz0EGKX96pudg7PXqZ0YnTKAAVHC4kh6yJ6loYfkB1v84nCk9eMDa19lHGjO176hzFPl+2tcARrq1ujoiJDvaL3X0ALlzWI4wgda+USdRTr7c5TxO8V8DMPO2SAtIqloP2m7iTlIUX2FxmBcNcVoIeBeKNj960XyG4QJ8E4xggKyqywBdAg/ZYgR7CicjXghYwlqq5AouUjeRXOwXcBkbFpYYEAjQ7R9qE7ycQTYWoBaDaawiMIEH2z67sho=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6aaaab7a-4770-42c2-f458-08dd4dddf637
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2025 16:29:47.2761
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oh++3AtUhN4dbFeGEgqAKQrdCBDDkzmZ24abk64k/EXGs+u1o804OD9BKn5qtUMHj2V1fcj3078ALN1HcA5Ogw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5141
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-15_07,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 suspectscore=0 phishscore=0 mlxscore=0 bulkscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2501170000 definitions=main-2502150146
X-Proofpoint-GUID: mnQVyl87oxiDRk4_rd-kuUyhyw1f7j_R
X-Proofpoint-ORIG-GUID: mnQVyl87oxiDRk4_rd-kuUyhyw1f7j_R

Hi Pali -

On 2/15/25 7:00 AM, Pali Rohár wrote:
> Hello, since v6.14-rc1, file nfslocalio.c cannot be compiled with
> gcc-8.3 and attached .config file. Same problem is with localio.c.

If the interwebs are correct, gcc-8.3 was released in 2014. ISTR that
recent releases of the Linux kernel no longer support gcc versions that
old. It appears to be snagging on kernel-wide utility helpers, not code
specific to NFS.

If that's the case, it might not be possible for us to address this
breakage.

Adding Mike, who contributed this code.

> Error is:
> 
> $ make bzImage
>   CALL    scripts/checksyscalls.sh
>   DESCEND objtool
>   INSTALL libsubcmd_headers
>   CC      fs/nfs_common/nfslocalio.o
> In file included from ./include/linux/rbtree.h:24,
>                  from ./include/linux/mm_types.h:11,
>                  from ./include/linux/mmzone.h:22,
>                  from ./include/linux/gfp.h:7,
>                  from ./include/linux/umh.h:4,
>                  from ./include/linux/kmod.h:9,
>                  from ./include/linux/module.h:17,
>                  from fs/nfs_common/nfslocalio.c:7:
> fs/nfs_common/nfslocalio.c: In function ‘nfs_close_local_fh’:
> ./include/linux/rcupdate.h:531:9: error: dereferencing pointer to incomplete type ‘struct nfsd_file’
>   typeof(*p) *local = (typeof(*p) *__force)READ_ONCE(p); \
>          ^
> ./include/linux/rcupdate.h:650:31: note: in expansion of macro ‘__rcu_access_pointer’
>  #define rcu_access_pointer(p) __rcu_access_pointer((p), __UNIQUE_ID(rcu), __rcu)
>                                ^~~~~~~~~~~~~~~~~~~~
> fs/nfs_common/nfslocalio.c:288:10: note: in expansion of macro ‘rcu_access_pointer’
>   ro_nf = rcu_access_pointer(nfl->ro_file);
>           ^~~~~~~~~~~~~~~~~~
> make[4]: *** [scripts/Makefile.build:207: fs/nfs_common/nfslocalio.o] Error 1
> make[3]: *** [scripts/Makefile.build:465: fs/nfs_common] Error 2
> make[2]: *** [scripts/Makefile.build:465: fs] Error 2
> make[1]: *** [/home/pali/develop/kernel.org/linux/Makefile:1994: .] Error 2
> make: *** [Makefile:251: __sub-make] Error 2
> 
> 
> $ make fs/nfs/localio.o
>   CALL    scripts/checksyscalls.sh
>   DESCEND objtool
>   INSTALL libsubcmd_headers
>   CC      fs/nfs/localio.o
> In file included from ./include/linux/rbtree.h:24,
>                  from ./include/linux/mm_types.h:11,
>                  from ./include/linux/mmzone.h:22,
>                  from ./include/linux/gfp.h:7,
>                  from ./include/linux/umh.h:4,
>                  from ./include/linux/kmod.h:9,
>                  from ./include/linux/module.h:17,
>                  from fs/nfs/localio.c:11:
> fs/nfs/localio.c: In function ‘nfs_local_open_fh’:
> ./include/linux/rcupdate.h:538:9: error: dereferencing pointer to incomplete type ‘struct nfsd_file’
>   typeof(*p) *local = (typeof(*p) *__force)READ_ONCE(p); \
>          ^
> ./include/linux/rcupdate.h:686:2: note: in expansion of macro ‘__rcu_dereference_check’
>   __rcu_dereference_check((p), __UNIQUE_ID(rcu), \
>   ^~~~~~~~~~~~~~~~~~~~~~~
> ./include/linux/rcupdate.h:758:28: note: in expansion of macro ‘rcu_dereference_check’
>  #define rcu_dereference(p) rcu_dereference_check(p, 0)
>                             ^~~~~~~~~~~~~~~~~~~~~
> fs/nfs/localio.c:275:7: note: in expansion of macro ‘rcu_dereference’
>   nf = rcu_dereference(*pnf);
>        ^~~~~~~~~~~~~~~
> make[4]: *** [scripts/Makefile.build:207: fs/nfs/localio.o] Error 1
> make[3]: *** [scripts/Makefile.build:465: fs/nfs] Error 2
> make[2]: *** [scripts/Makefile.build:465: fs] Error 2
> make[1]: *** [/home/pali/develop/kernel.org/linux/Makefile:1994: .] Error 2
> make: *** [Makefile:251: __sub-make] Error 2
> 
> 
> Reproduced from commit 7ff71e6d9239 ("Merge tag 'alpha-fixes-v6.14-rc2'
> of git://git.kernel.org/pub/scm/linux/kernel/git/mattst88/alpha").


-- 
Chuck Lever

