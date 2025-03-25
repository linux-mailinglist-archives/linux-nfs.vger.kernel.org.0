Return-Path: <linux-nfs+bounces-10843-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 26730A70200
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Mar 2025 14:35:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 23DD97AB26C
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Mar 2025 13:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94E1D2528E3;
	Tue, 25 Mar 2025 13:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BnpCz8b1";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Kymq4Lvj"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDF60D53C;
	Tue, 25 Mar 2025 13:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742908877; cv=fail; b=lu+QLTO0Z9OROYaU3QjthXnOEtIQ7B0PbuGkbh+XiV8cUzY7N0121PEJbwwXRWasUSivzkpGgowikLxLfGylK/ELALKNS1wzbCGIcoI0lm4oYRj7mHvU5VrRMZay09+Fy78Y+D3qK7qO/wjkTUGdKjbVHC0tKQJ0R1GOzsotx4M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742908877; c=relaxed/simple;
	bh=OyAoZ7LqrfE5rsopMiJ+G6QqRzFvv5PHHV367OZJEjc=;
	h=Message-ID:Date:To:Cc:From:Subject:Content-Type:MIME-Version; b=kN1fNFHAg/K+ynuyV8t03TrBaq7dAIHWMV+QVP6jVT5aCWV+pD24mmpBrDOklr3sTejstyv5/UPmv9mgT/IuLyHPYLbkJflsbytw+6HPoLwuu8SJ+9EwFwKPZZXzN2Crbg4/UF5vumryV5px+ieR81YvWknHmh5Xb6zfeYAUBs4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=BnpCz8b1; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Kymq4Lvj; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52PBfptY025783;
	Tue, 25 Mar 2025 13:21:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2023-11-20; bh=+WeyDPOmqWuyGeAp
	aCd6NkSdS3TtMng5VYxKnxI/YjQ=; b=BnpCz8b1LbY80mIfyjl+jQoGCwI0Iw/h
	Cr2jcRoA0uEiqCZwe22l8pjrMVlq99jVz91RuVJK2Se0SbCGZZyJBJM7oZEvwx+5
	iM4rwAW3ZKFtz2QECF1cuRUI7I1JGLf/I3l5BcDkl0JyMUDadYkzJoQ8nPx22vQ8
	OsHdZZ79OPzFx1BfzDYG+IA0Rk5Khd4QCqnw0nQz5YY8OSHjpGcjcpkzYE20dIwp
	pHUooYHGLXh+OgDnh/3hoR5ueyZ8aksxoerxai9jerlE4UwX1DphZRNuTp3VzWHx
	KcA63ylkPMMZzfdK5CM1l0K5abP2EEZEvO3gCfTEFGKWqr1CEpzX7w==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45hn7dpvaa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Mar 2025 13:21:14 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52PCvJDG036852;
	Tue, 25 Mar 2025 13:21:14 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2176.outbound.protection.outlook.com [104.47.57.176])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 45jj5capg0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Mar 2025 13:21:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J24o2lM/eHum2co56dIyG4GfFFU4cnLxioCgAaV2xSDFTRt2PdCp2Y7sl+uPv9c1nRKQRQQmJ10rnlIbu9LD8X8OMt3EetjaomlCcumcOFlyf1ziLihoHXjgYbjnfsxSMgD1D7VPvrG94B/hgE+EMdQ0bfIzKbAXkvsSn72Sv+z64rCDWhEVtNuiMMhgfwmZev3yzrE3Xx/AnBCsD4uLaNC8blJTB6m9J6VUOKOSseDMLq+MTBsyL9OHn1HTjcuAlb+pRW8ZIzfzqB7Uh374j65j0L1iwq4UeR3Aqr7Xrw22bkTGu4IdOI6ynAm1zkuDG2sUIRSlLC8ZIxWzTUG21A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+WeyDPOmqWuyGeApaCd6NkSdS3TtMng5VYxKnxI/YjQ=;
 b=WoESxGVswHWISx9IT8jXtcB5dgvZmR2G5obHiTTE/Afm5ddLFszNIq4Usk6/Vkdssbha6bueLlkBCM0L4+u7r0yo7OUqNNFoHO37J4om2IoMpeMOfcJgA4YgxGJkiWou3MkK41hw+7miJtfGFaTJV/GHq8g5s7t7UdcdLERBab/0kDxk6Y1POWrCUtDr6TyNIFb05REWfZRD8171d47GsVo/AlMMsoYvVCPOwHJby3JQbajCPXS+X6Lon/vv9X13pmfatQU0uF/BjLGrcNGXACqPEC2pyK0HU+UXOHp2v3nXSMHFxb/E9mhhUdiKfO6kKZGj98IADrx1tKxt2AeS3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+WeyDPOmqWuyGeApaCd6NkSdS3TtMng5VYxKnxI/YjQ=;
 b=Kymq4LvjkM4gr1pAkU3deDbo5XIyjBCQUsHPgMQNooeeUANxhybxizYbTFzoEhDahNkPuiro/XHrD8JMZ+dEifaPCrCPmB6gOVpFCSFBx2m0O3mWW+u9MdGKs4gvgHGT8YWUqW+Rt4OfnKXGMuEMwBMzashcoY7ylDKZo872Rbc=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SA2PR10MB4796.namprd10.prod.outlook.com (2603:10b6:806:115::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.43; Tue, 25 Mar
 2025 13:21:12 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.8534.040; Tue, 25 Mar 2025
 13:21:11 +0000
Message-ID: <e51834a5-2f11-4783-9065-e19a150283b2@oracle.com>
Date: Tue, 25 Mar 2025 09:21:10 -0400
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "stable@vger.kernel.org" <stable@vger.kernel.org>
Cc: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
From: Chuck Lever <chuck.lever@oracle.com>
Subject: [for v6.12 LTS] nfsd: fix legacy client tracking intialization
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR08CA0007.namprd08.prod.outlook.com
 (2603:10b6:208:239::12) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SA2PR10MB4796:EE_
X-MS-Office365-Filtering-Correlation-Id: 51855e94-5d4d-44ef-6b4a-08dd6b9fe978
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?V3NzU1lhWWNUazhCR1dlM3JZVk1ka0lBR1ZkcTFmUFlZaDJCK1J2anJDNEZm?=
 =?utf-8?B?bVk3Ri9ma0tNU2xYMnphVEphMlRMNCtwOGFLTnFwOWhyVFB5UTh6WlNnL0Qr?=
 =?utf-8?B?K0lqcUkyMEFMTUFFVExWWnllRndSaFgzdlJUcnZMWGtuaWk1akxobFh3L0h0?=
 =?utf-8?B?MlUza0NwK3lCdXg2V0ZBenoxWEx6a2pmM0ZBREdFcWJlS3RPVXF3ZVk4ajZM?=
 =?utf-8?B?dEh4UVFWcThTMDhvbU1ERmV2bDVaY3JiOS8wek1YZTAxc1Zld2JoK2dLRDZz?=
 =?utf-8?B?SHpKUGpFUHpaN21QMlRXRXdhWFNhNEloSU02MitZS1hqN0NzdFM1V3Rua3dj?=
 =?utf-8?B?eThsa0xDcVRKdlNMQy9pcGtGNHNCUHdVSDlpS2xTMFhHZUhNaVBmekhFMDV5?=
 =?utf-8?B?RGxyMWdpWk9veDZjRVM2dWU2WmhWeDFhVHFvSTRRWElETkRJblZ3N0t2V2Zm?=
 =?utf-8?B?UG56QTJ1aVVDb0xCQ1ZrRnJlUk85QUdPQnpFODQvNldBejFKcVpDUkhwS1B2?=
 =?utf-8?B?NUF1NHRnMVkySWNzWmMyaks4amE2N2hhK0JEa1d5VS95UU15Uzhta3ZaQmc1?=
 =?utf-8?B?S04wNTE3TmhKLzdPVHVRTFJab2JpODBXWkp1Z0YzWFpOdUN5VUx3RUY0eFdj?=
 =?utf-8?B?MWc5UE9OeS8wTFFVN0tWd2twdHI1OHJoZ3JRSGdQNjlkRlh0OXhHaUpnNWNN?=
 =?utf-8?B?ZmovUnVpVnZ1NWszOCtRS3RHTm15WS9weFAwYjRyaTRNQUZGNmQraUlMQkw3?=
 =?utf-8?B?MUMxWlh3emViSlFRRXByMjBjL1htd05ob2J3WjlPZWdSWFExOVBRRmdwYVFS?=
 =?utf-8?B?N1lhOEsxOGI4U3h4NFhCcXlVSS9zYXR4YjRCZGtoM2NQcFcwa2ZBWGZNNVNR?=
 =?utf-8?B?L1NpdCtFNnA0N3FuSXRBa29XSHJHeDZ2SmJaUk1BKzZ3cldjQnJVbWxuMUZW?=
 =?utf-8?B?YVhhOWNKTGFuTHFZMlFXR2ZHZ0h4aklZTVNhUy8wZzFrSjFNNFB2QjNkY2dl?=
 =?utf-8?B?cVBOTFd3OEFZbGpqc3VPbk91RVE4OUJxVllNTU1yVTRreWJmaytodHk1QzNx?=
 =?utf-8?B?blozcTdxT2txbmxMS0FWU0VrYndRTFdIdzFhQ21MYzE5T1Vhei9iWjIxZWk2?=
 =?utf-8?B?b3I3dWhWVysydnQ4Z0JpcjVFbllMMHdUVGdJYVQ2S3g4RXdYaHNDZzFqbVpD?=
 =?utf-8?B?MkNiMkc3SURHeVBRV2xmZSt0UTA5USs1ZEFRa2dWT0wzTEFLbFFraEhJUmgz?=
 =?utf-8?B?eFMrQm5hT1RFeldWTnFrZ21ZNUJmNjMxSnY0ckhEZTlsQkU5dzBVL010RGVN?=
 =?utf-8?B?endyY2F0dnRjN1pSMDFxYVNaTUhZb3NrZU9jeG82V01MbDYycmlnNWZBYkMz?=
 =?utf-8?B?eldHaFh4cnhKRlZQUVVFb1d2OXVsUHBBdWx2Ykg1eVNqNkp4V3BGc0MremY1?=
 =?utf-8?B?ak5ZSmNPZG1ZYUlRWEtjUTk4eUdrRndrMGE0cDNKYklhUjBETDVrWUF1RjAz?=
 =?utf-8?B?WHozYWE3QTg2Vjd1RUUzT29YMWFDUDBWTVB1VEpqTDlRUmdqUGdrT09yZmlJ?=
 =?utf-8?B?K2l5WWhKbDMyOTdUT2FJTnBvUkRRRzhrSCtkUXJyZGNZVFNteEJnREI5ZWJa?=
 =?utf-8?B?V2JrZDJuYUZueFBQVUJoa1FHeUM0eDl3d3Arb3c3UElNYy9ZKzhkTVpBNXFm?=
 =?utf-8?B?di9Ia01nWEUxNXpFemFwV0puaTJnaDkxZVp2Y09YN000UzJYQkVSVHZYSjE0?=
 =?utf-8?B?Rjl5M0lhd0JRdkQrb3NyMWF6ZFZFOFdQZHpnRkdheC9tSlI3QTY0ZFRwVGRs?=
 =?utf-8?B?SWFQYXZVOS9COW1RZGVGWWJFbzJzQnRwS2hNZVBHMThPQkE1Tk51RVdhUnds?=
 =?utf-8?Q?Vwz5pMQ0GUsZq?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bDgzczlTZ0IyWC9LbXlLb2Y5emlWZm9wenZIQXlXU3B5aUlZbm9ZNnA1MEZD?=
 =?utf-8?B?N0g4VThYekhFMkZHRlc2VGtkNytlTzRid2wrbjBFNDhZU3ZFWlZITE9oMUR5?=
 =?utf-8?B?SzRYUHQzbUo5eG9NdzF4bmhaY0NmWnpEYTBJVk1WM3krbVpzUEdzZWtpNkRP?=
 =?utf-8?B?NU0ySHFlcHNsOE9YVWlaVE5SZnZmZU0yZWhEZCtqaEZ4dThFOWgxUjB6elBX?=
 =?utf-8?B?eEhKWXB3QUtsVFpiMFlYbUpxeEh1NDZ5dlFndnQrbytxQnIvRVNJcEFWTWVl?=
 =?utf-8?B?SFdDTVpEejFJMGVJL25XRndwV21nOGJsUnJ0ZW1CMUFLUnlTUzFzelZycU5a?=
 =?utf-8?B?bndFdTkyVEdidi9Da2dLaHk3Vk5DVElGN0I4M2dLK3YxNTdQMThCU0FjcUxB?=
 =?utf-8?B?QWdHZEZRejhQZ3FEOVNSdEVOeXBKZWdsZENlb3R4dUZaczJoL3ZJTGpJaVla?=
 =?utf-8?B?NVM0Y0tjbC91WDc1SGVMZ1dXL3FjNUI2UGtTT0tYVGdaRExuSVhIOUhldEFu?=
 =?utf-8?B?dk9CV21pcmVBRTF0b1h0SzZXSXV0SzRudVRDNitjWThwQXlwc1dPZW5TR2Jr?=
 =?utf-8?B?dE43V29tTjhrZkNzaDZUVWdIVXZ0bzdCNUltMEZmc1BUWW03cTJWQy8rRC9y?=
 =?utf-8?B?c3EwZ0MzK0xGRDM3YjlqRmZjSFNMOUltZW9MMlpyMGVwOWpxODRyaytCbnBU?=
 =?utf-8?B?MnpBNFRTZzFyeUUrMHdLY29OVUJSdk4rZ2dxVGZDT0FIV25rMGtOVXhyQTNB?=
 =?utf-8?B?T3pHZ0tQTytuMDFEOUNIN3lYeDNRaW5NMWhuVWIrNjVBblZPR2hYL2dOUHQw?=
 =?utf-8?B?VzZrejJUeEFudi9NU1l0UmNPN05ZaVRwYjJSOEk0S21ocy9NVVhoVXFDUFVm?=
 =?utf-8?B?TVZZc3Q5Q3Yyc01mcVNYZWxyTk9nbEZBaU1XZ2Q0cTFwYldlYzJWd3h2UnI2?=
 =?utf-8?B?UGplRHpBdCttTVdyT0k3LzBtdUk0Z2tnWkFvYlI4eFcwa0haaDJtQklMNW1w?=
 =?utf-8?B?NEExcGoxZzEzbzliMXdhcUFTSjQ1L1orQ1JTSDgvVGxENHd2aEZRWWQyTHZq?=
 =?utf-8?B?amdndUVlNHFTT3JvZi9FMjZHYXFGc3JRM3dHWEY4TjZEZE1mamVUYnNmaG12?=
 =?utf-8?B?R0xoMnErcnlVZHBIWDVsaW1HY0RHT09Dem12VWZoa3hxbk4vYXZTS3psOVRL?=
 =?utf-8?B?MmlyZkl2dWdSUnhIYUUxS3NGd09STmtKR1FVTGdKNEk3OGEzeG1mcCtEbDJ3?=
 =?utf-8?B?V0RvT2xlejNQSUtyZ000eWVFK0Npb1lkTXVnL0Y0c2ZBYlRvcTk5ZkxVNFZj?=
 =?utf-8?B?ZUJZamV0UVNTVXllTU80NTkvbE9GVzAvVHNWdHYxRzlqc3ZoZU5idVhCc1RD?=
 =?utf-8?B?eVFML25RbTgvY2F2Zzc4MngrVnlrNElveUZaWFMxMC9UTlNIb0VRNFVXc2Jz?=
 =?utf-8?B?ZTJsMThuc1Yvb3BmQ2dtWDRuQmRVRlp0T1ZqU3dDdlN3N2wrY1p3RzNleFQv?=
 =?utf-8?B?cnVUQnAxSCt3L2oxQnU3N0hGd05UL21jNm11Q3hVQWtIUFBkUWlCMTlJUUJk?=
 =?utf-8?B?Z0V6UUR0a1JabDRWTllpSTlhRjZKSnh3dkNjTXdVMjBPdkZKd2tQcFB6djFU?=
 =?utf-8?B?YjhzN2xSOSt6YmZVOW9lWTh6dEIrRlVUODM1RDVGOUlmb2prVk0xTmZkQitC?=
 =?utf-8?B?MFJnNWtDV0NDY3N3S04yd0t6K3VENjNQdWRFTFFwS01GSmxWaWlQSlB3VUpm?=
 =?utf-8?B?MytsVUErWE9rNkR1MG5PZDdiYVN2SzhXcU9mSnlXYzVRQmNGWWxxUEJYemVy?=
 =?utf-8?B?eTg5OGpSWjFCaUM4YnZ5QzREa2Y4d2JQblhjUFprZHo2K2MzUkJkRHMxZVZm?=
 =?utf-8?B?MW1BVVhiV2ZoYkx2ZityM0hSbm9pQjc2b2VVd0huK1lrbmVNUkk5djM5Unl6?=
 =?utf-8?B?dzdhNG1XUGtGVFJhTGZOTGZOQmVRMWZCRlM0ZUJmTWIzelRGMnZHQWMyRWNj?=
 =?utf-8?B?aG1oK0JMekhzZVp5WGlSaDFUTXNnVWVHek9Sd3h0cXo5Zml6MzIyNXJ6b1Bm?=
 =?utf-8?B?UjlLRGtiRkxDWHB5MUwvODFmcFltSEtmUTZneUNtaDRENmpmVlRFWkQ3WGNP?=
 =?utf-8?Q?ehqMN2Uo9NIjRR12updO+mtME?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Ei34sGJeibH9t+kEizXNAm1qU0uDkWJyz+ihVGT/LjePDJZqEbKY6wOeu4AGgAFq0Sm36k3Oytn3FGbEvG0x2Rg5NVwNtzh14tWTJBbAW9rH9Du4hDQFr5MTLh1VNsGDTQoi/tL6aPW8h29JR7PAesL75jetUgnUROs2T23EFscnyL1tdv7ZfgytPCUKthYZ02lubZZmhNZwPCl1lcr32m9DLFq0c9+/E4y/wFxQUPa0OCnZhVlapaXTEi7Vq8Zr8T3UmfjPA0+z3NFKZoIegFxbptxfb+T6PAWWbNuzs6Nir6ZWm1ty+VEPYLELc3siHnZHyPR8j3FGRDTCXpGi3CnhMWSxM1W82TUu2VzsL/e3dHdqQbZ6rz5v9JIymIVFASV+natDAVV2jZ95CG5Hhtvh16rwT53M8jlU/npeL7ywQ8CoNQBniM4wwRv5rHRdU4ruvBXE8oKdp87u3S6pacVoe6inr69ImjbguHemYEG9QkMqz3yFVOMTS1ulHMaz5xLxX0OkdOHCmwcd5UXw71JRbQhTJG6F9oK/iAB94d89bdbUTrLnkIDSq175ZEabwKuLgFIgp82e7PUZrrZeDkyC4EXcZG+5WtRLnU2Jq2U=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51855e94-5d4d-44ef-6b4a-08dd6b9fe978
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2025 13:21:11.8513
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KcZgHcnjgo58BwRCC8H5u1gqL3wUnG3gdvAFUp/GoKgaWmJ55MTujF8Eo+2ZD4/t1YnYQakcFU9yN8gJEMkfhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4796
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-25_05,2025-03-25_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 bulkscore=0
 malwarescore=0 mlxlogscore=920 suspectscore=0 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2503250093
X-Proofpoint-GUID: oWG949drys0XkV2Ih1kl-RieI3UhAT_M
X-Proofpoint-ORIG-GUID: oWG949drys0XkV2Ih1kl-RieI3UhAT_M

Hi -

Commit de71d4e211ed ("nfsd: fix legacy client tracking initialization")
should have included a "Cc: stable" tag. Please include it in the next
release of v6.12 LTS.

BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=219911


-- 
Chuck Lever


