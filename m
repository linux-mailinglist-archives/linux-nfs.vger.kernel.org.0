Return-Path: <linux-nfs+bounces-15804-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F734C217F8
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Oct 2025 18:30:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82C4D3A067E
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Oct 2025 17:26:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24815368F34;
	Thu, 30 Oct 2025 17:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="sYa/QVsM";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="A5nGL3BJ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6FB4368F28
	for <linux-nfs@vger.kernel.org>; Thu, 30 Oct 2025 17:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761845167; cv=fail; b=osGwFeEKLoECo3Prc+nDBpqLixASo4aJ/oMydv9Q9VRp4WLYU90J2DgW2Bbb/iPEUOjWY0SGYnoNfVQfQbNHGsdpOr01IUrd/8lq3Z382T/+YXUf98UsfHEXtPV5jqUWqdykgeRb4yGvBBgHX9QXp/d3LcRLTKm0g2eMOUGuosg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761845167; c=relaxed/simple;
	bh=FG1MVqu/MKw3n+wOGjFzcKnhSStj1DVM1PjLK60RY6g=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JQ7dfGUrBBFsMQZqLBTHj4USYXPqTKeKejcSStrofdmQUYo8AzmaSDn79nuFcF48bIl4OpG1K/WtuazSzajoOgK9oAOjcXA0Y1/Gi9JkPUgc+8BXpMsD+4ZCkPGRaFH4isa00nEbEgwcP7seIy0DAAJ1FH/VuBdk+f6RW3Cpan0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=sYa/QVsM; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=A5nGL3BJ; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59UGuTNX007470;
	Thu, 30 Oct 2025 17:25:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=WG+9sTaSuWH0pUz6n237hjyUgujraVNHrXz0CwWIqk0=; b=
	sYa/QVsM0QZhnCo49JIR+JdRCPvhHdCk+6f6CoBKSgymmINS7LY10afYhm3n54fA
	KZ7Z8YARxYgLBPeUZwtE9LBgQj8XNjspJuUbALfnHFeS12auV2UwfpZSC2kU2XLn
	I2KF2fUOS5bSHMpVvTPWhmb0UQRzPdwe2Qi2cKkpQ/2s/XUwlJ1og5kK9n3cyV6+
	3wyMQXxJkJ2J3Aywk8D89Yi4WF52kyYBS7xyIsYofaA09LrDz359dijdoXvvzBRy
	Ie6OcduwNFtK9NlMe0VO0kUxiglCiZ6vaco70vrLuMqHZY8vWjoOlVrWN0Yn4tbd
	6f431t35prLypyveLBuCnQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a4b2qg8t8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Oct 2025 17:25:48 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59UGEHv5027455;
	Thu, 30 Oct 2025 17:25:48 GMT
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010038.outbound.protection.outlook.com [52.101.46.38])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4a34q9d2sn-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Oct 2025 17:25:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=POtz3HVGR+mVPDBc/mHsETyiZPui33ABwBAz+/vsssK/3sXlbsEVuwsymkrtxkKOY9M9o3RMxqWXaiCELNydwfJgQPMcvm59bzAib1X/Kyl1vlLIXJSxBkp277rQchVZhHdGj48aalz7kDqlVXyZ3XRm9dKds7BM5wq+QHAl7iqTx34FCYQXJa0S04ETLHu5oFnwuoWjjX+pBNQlKL1yRtUIx6kvSyTkQrAfWrSkvmgAjzSAsci+7uwTwB8IZpuSHTOp2QGsxvNdrHGBxILw4GHKkQIDCmz2my34noaThehIRBVHT/eKpDYHqJ9qY3omW3W2lm+p4lLJ5vpskNNX+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WG+9sTaSuWH0pUz6n237hjyUgujraVNHrXz0CwWIqk0=;
 b=bCGagX015VJFS778OvZpFYhHMgXFdYfyPGc6Cofqf2GCuYySstOUHK9ExHHW2DRW3x1jnSROjRA4wC8YZVWbr8aPvxVtuEKGaoD97kjUWtyQV2dEJ8o+8VofSxLSisF0gin5wJ4siKGJw6Y0YfAP2GmFGB8Ss7cplNKxqpKW7VsJWFekfd/BjEpFLpONrhCzphHeDZ6Z0kwoXsa41RdStmbYIjDQMBkBM371LfCKr6/JCqH3wtighcayRP48hmxP8HPhORu7qta+ZHC2AI4yzUsqZlTEfZEihnShK4mgEcO+7gYn9ylmsSlXSzZ+4hMDgEc+JhgpnLIF1lnZj+NG7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WG+9sTaSuWH0pUz6n237hjyUgujraVNHrXz0CwWIqk0=;
 b=A5nGL3BJcMA9uukzSuS1xaPpqxoDMDmMpKN3uYl/8Id9U8gWgff3mxbgYEzOK1WO1COQnCKFELuNpFeOIeBDx6sJsdcyjyP1erJgBJ0qNvST7wa9xXfPoC4u83S/zTju9qa/FWsWa+WUipiQP7BD+sgPGC1Tmvc37fqKAKGASQE=
Received: from MW6PR10MB7639.namprd10.prod.outlook.com (2603:10b6:303:244::14)
 by PH7PR10MB7054.namprd10.prod.outlook.com (2603:10b6:510:276::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.12; Thu, 30 Oct
 2025 17:25:43 +0000
Received: from MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::69ee:3509:9565:9cd6]) by MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::69ee:3509:9565:9cd6%4]) with mapi id 15.20.9275.013; Thu, 30 Oct 2025
 17:25:42 +0000
Message-ID: <a0ea4dca-7805-4b69-9b61-a58461f644c6@oracle.com>
Date: Thu, 30 Oct 2025 10:25:41 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] NFSD: Fix problem with nfsd4_scsi_fence_client using
 the wrong reservation type
To: Christoph Hellwig <hch@lst.de>
Cc: chuck.lever@oracle.com, jlayton@kernel.org, okorniev@redhat.com,
        tom@talpey.com, linux-nfs@vger.kernel.org, neilb@ownmail.net
References: <20251029232917.2212873-1-dai.ngo@oracle.com>
 <20251030055509.GA12657@lst.de>
Content-Language: en-US
From: Dai Ngo <dai.ngo@oracle.com>
In-Reply-To: <20251030055509.GA12657@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0376.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::21) To MW6PR10MB7639.namprd10.prod.outlook.com
 (2603:10b6:303:244::14)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR10MB7639:EE_|PH7PR10MB7054:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f5a573d-cff7-47f1-480b-08de17d95a80
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?QWt0YTRxdW9MVnUxdEIxU21kNS9KYjFYbmltWTRzMFZtcXNCZW82RWI4QmFS?=
 =?utf-8?B?b1NYUmlsMXdtem9abngxRXVNbmFyR1A3cm9ZSHUzUmJzMXI4VnFYTllRa0lN?=
 =?utf-8?B?TjNaK1dYOUJ6bC9EVEc0eGhLVnZGTmxWY1dSQm5BT0N5V2pOa0RDcWg3SGM2?=
 =?utf-8?B?bkhBcTUzd0VUd1N0dW05dHhneVAvaE1YV3FYMnFWcWt4dVY5K0czTEpDUU9t?=
 =?utf-8?B?MldiL0xrcmNpcDJIOTJManllQ3JnWFlUbVFBVUZQT3ZITkMvNWVVa0c4QWEr?=
 =?utf-8?B?eFUrUThJblY4QS9JUVQzQlFqYXRYd0lEOWEzbjZ0SUp6ZmpKZlhaQzhUK2Iz?=
 =?utf-8?B?N0FtQ2FodVQxdG01THp5TGZuVGxNeStoSjhFUXBuMndrdW9pMkk0dWlzczRR?=
 =?utf-8?B?UFJMRlVMbUtPNzhhNDUxZVFRdEcvQ0JJbDNINlZwbGpQMEtUVXpyVkt5OXQz?=
 =?utf-8?B?ekVOWk83Z3RwNTl3M280MWZxclRFdDFBeGcvMGMxMG16ZmFxTjBKTDJ0Z3M5?=
 =?utf-8?B?WmR3MXJqSVppM1NjOGQ2SnBSWTlyNy8zZ3VqUDYxR2lpQWdxQmszakoxOGkr?=
 =?utf-8?B?UEtFaEs3NWM2L0Z1WnNlcDhhS2RwK0FBZUNFM2VodVo5d002TnBEQzE2Z05x?=
 =?utf-8?B?VTVBTmxmNmRDVjVoT3dENDBQbU1yWmJtS0tiZDV4YUVoSU1tcWhDZi85RTRL?=
 =?utf-8?B?dUZhL0Uza2xFY3kvYUlCVFBLeVhycEw0WjBUMFdmQlhYRm1ZbFYwZ3M1Qi9J?=
 =?utf-8?B?OHZJMnFaSG5ITEtOUWU2SlhwMWtzZG8zTk9Wa3Q4MFJJYkxMZzM3d2JvWEJU?=
 =?utf-8?B?bFhMYUNRRm43aVZKMVZrRmpyMGFTbTBPenE0UDJmb2FqR0t3dENEdy9PYWU4?=
 =?utf-8?B?RGxPYTZxVnhVWUpmdWtVaUtlN2FkSFA1M2hTMDAyUHcyUXhLZXlVNTlCMU1L?=
 =?utf-8?B?ZzVCMG5xRmJJTTJmZGxzQy9zdm9vZGtzZzRPd0dISWYrZm55SnRmN2pYVGl4?=
 =?utf-8?B?STMrYUc1Rm8vd044by84QWNEMHJ3MWtlbmgvVExGU2FzZEpaVURIUVlXNWpZ?=
 =?utf-8?B?eWl2SlFUUUprTWhtTXg5YnQxVGtNb1g5M0p0S25kd2NoSEg0NlVzSURJWmEw?=
 =?utf-8?B?UVZPL2JOanFzZU1Mdlo0ZHNSMWJUZWJIT05Lem45LzBDcnpxRHJ3WmlLOHFT?=
 =?utf-8?B?WDdQR042cEE5NnpSR2xUTDdmWWQ0anJFVG5MdXE5WDJwY3U3MnNOR1NaT0Z1?=
 =?utf-8?B?eTFVNFNWWXJQOXQ4MVFsN2Y0bW9tUVI4aGQvYzdKSzQ5MEh1MDJXMVB3bmdo?=
 =?utf-8?B?RUpFREtzQ3M0MmVFS1lkaTJzNWc5bnJvYkRDUlY4czgwL3pQQ0MwWllqNW96?=
 =?utf-8?B?K052eVV2bGtJWlFVc21UZWVBbW1YZEhGdmhkdHVTck5yWnlwY1FoUDNQaU5L?=
 =?utf-8?B?QitIWXhjT2hJaHZwUzdNZngyeUxjUElnN05qUEdGL1hkNGVMUWVPZ2ZzVWFY?=
 =?utf-8?B?S2Q5bFhuaFdhc0dCTzJ1Zm9aSlcvYWJHak9WQkczRTFhQkpwN0huN1pmU081?=
 =?utf-8?B?SzhCMGp2dDZwd1VWbnp1VHRhWU94d1NkLzdkaHNOMDdQWWVKaGJ3U0tHZHV5?=
 =?utf-8?B?THpJWkVoazd6aTdBbjdMZlhZSHhFRGZjVzA5bzZzT2VzbGRhb255YzBkOGVT?=
 =?utf-8?B?bjd5djhhWnZ3VHpsaUM3N09DZmgwVnkvV1pES2tUL3Jpb1BLQ1J4cEF6TDNv?=
 =?utf-8?B?QkJZRy9jR2NFbnRMdWU0aE9yZWN5VjMzL1ZqUzlFcE8zbWo5bjhUeW1MWVdT?=
 =?utf-8?B?VEJLNi9NVWlsckczeHZ3T3FndDVIYkUySWVXYW1RVDFpenlmRHJYZWlQeExZ?=
 =?utf-8?B?SUVWSGdoWGRETDFaVjV5em5HNkhobHV0ZDZ0b1JERUZ5dlBZOFJTZm1hb0Y5?=
 =?utf-8?Q?oIe83Lnwd4pibjfvusN8oRQZb8AfCi/g?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR10MB7639.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?elRoMHFXTHR5eHV2U1V1MWFWR3FiNjMyVDlmNzNTUWRyemZCaHZlWVhWczBI?=
 =?utf-8?B?U0IxMng5QkpQaXErV0FxR3BaTHFtNkpPMWwvcGJyMVNCemZtaGhzK3lNRGZ6?=
 =?utf-8?B?RS9qTkgvVGM3aXZ0SDBJYjdrY05LS2wyRk5GbFo0RlFUYUVFR0NTOVdteHhF?=
 =?utf-8?B?U0twcTZPNGJscDNWeE8xNnVWNTJQNVFwbS9idnNIaCtPN0NBdHcySjVpSWRN?=
 =?utf-8?B?QzArUUdnSGtQbC92eGEyb3hZT3VWOHNmQW1JNVZlT3JUT3ZHeFMvbDRvbkJ5?=
 =?utf-8?B?TjFMckRLa1VicXY5VEtBcGF1UEdKR2VNVkszQjRsVzgrSWwrQ2FZaS85K25u?=
 =?utf-8?B?RDlyZ3Y3SXpHVXhZcEZiT3JaZ21rSFh2MlcwZlR0YlBZVFdHZjUySTJmaXk5?=
 =?utf-8?B?TUNob3dncmg0T2NkM1AyMEdQQjE1UlRJbW5QeGdmTmc1ZFJPSWsxR2RjUkVu?=
 =?utf-8?B?YkhudWtob0I5NDMzVy9UVTBJWEY3NEZXOXlZWG1taXhoTDh2UUhqMldMOUlV?=
 =?utf-8?B?ZDRMbWx0V2JDVG41M3dQdXp4WE9PRUc1UTRNUm15NU12a0laOGVXV0lLRkhx?=
 =?utf-8?B?Um56N2NCQmYyUGJTRVRWb1ZTM2llOWtPN2dNZFhhVWY3QlY3cS84M1JQSjRC?=
 =?utf-8?B?ZW4vOUtGT1lVQm9kbnh6dHBWYy9palVxWXNOWjE2aWdRZXBZbGtsVlF5bCtr?=
 =?utf-8?B?S1BWUTVxbEtIWmdPS0dKWGVzS0Q2TG9uYjRURXVzUm42WkxXZVVMbGFMZlB0?=
 =?utf-8?B?Qzhha1llYmpsR3BPd1YxUHFmYTZFSmE2WFpMMHhzZG9YbG9UVVlZL0dOUGFC?=
 =?utf-8?B?TE15UUltWU96eCtWdnlIcEFvSnVucCtkaWpOb0p6eDNzWTZnam5odHlUN1Fl?=
 =?utf-8?B?b1JtSWZhY2ppdFBpeGpGT29QbEJkajFQNWF3YjVuYjlvM0g4c2xxNkU4ZmpG?=
 =?utf-8?B?anU2VEU1RHB0RS9tcm82SWRDQ2lRd3lnZFlwTWRQOUJHVTJsR0FDM2Jxb3Rq?=
 =?utf-8?B?Y0hOekdRK1pGdkdxNUI4ejFYUkRoSHNsdVpMalJKbi82bno1ZmgrdTdoQ0k1?=
 =?utf-8?B?MjlHZTdFclVrMk5mL1hSMzgvaSt0cHJjL0JvNFVsc0kxbUZ4TmFhS0xFVFJF?=
 =?utf-8?B?SThIQkhOOFI2dDBJQW55VXc4c1l5M0lNMGxSamxDKzdZY1Bma0RrZWwvNDJQ?=
 =?utf-8?B?ZHFNanJoK2RIbFNKTVRpMHMycGljSStxT1dScFZ6amxLYUtnR0NudzRpRy9C?=
 =?utf-8?B?TjdWNWRhR3lOOFBoNll4WjRjbkF1M2VLZlJUU3ZTMmdNaEJuVTVxakRld0Z5?=
 =?utf-8?B?MHZjSFhQTm81VUV2TEMxS2ZVdGpNNXFabUhBdkFJcVRzanErcHdXMXBoN0p0?=
 =?utf-8?B?WlBKMmtxRHY1SXFyRjhOS3EvRjF6S1psSEdsQ016S0RQY25MS1B2QWNSREFi?=
 =?utf-8?B?YTVvWit0RUgxL056M0tnQVdoMjBjTHFpdjc1Y0xGa3l5L0liMGNaWHdUNlk1?=
 =?utf-8?B?QVJwRGw3WXBGVkhpS0FEVTJ1bUpxRExROTlxby84ZmNBN2ZBT3NRSEVUOTIw?=
 =?utf-8?B?OGhkU3JkMUVEOUFmMDFKU0FOall1dEFCeUt4NkNudzc2RFZxWm5FWlB2d2N3?=
 =?utf-8?B?R0VOb1ZHcm5iMmlWejdVQnJodTEzcFhGU2g4c3BDdEZXNWNORkJnN2dYS3hY?=
 =?utf-8?B?cm51eVhieGllaExkeS9CVGUyNEtwNlhWR2MvQW53K2g2NmI2dnUveWE5VEdz?=
 =?utf-8?B?WkVDMHk1S0M3eXE4YUswQnR2b1BsV2RsZXdhQTlNOFBYMzg2V3QvbksvVjVr?=
 =?utf-8?B?ckhTekt2M0ExTTBtZG9vQWMzMXN6cDcvdURoN1BNMTh6Tno1UzFGWFVpMzV2?=
 =?utf-8?B?MlNweTkzenIzeXVHd3pTa1kzcVRvY2pNN2c5TnYwdzZSVXFDcjEyOFk1amRN?=
 =?utf-8?B?U3RyU1BZYVB3ZkI3WWl3RHNObFQ4TkM3MGs2RzZ0bllLMFhueFFTS1NvZWVT?=
 =?utf-8?B?OTV5bE52anJZNTNCeHFwL1RzWjFTQTd1d1gyT0ZFNlk0TXNnY0I0b2dxYS9n?=
 =?utf-8?B?WW1EeXE2OTRmOTdJZ01OTFRES2N3cmFEWjJqZDRnUUMxZXgrVXg1Ky93YkVP?=
 =?utf-8?Q?XP6+O2X/ezDrhkA59zWjBCt53?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	9HrSBBplM0xwk6SS5cIFHSkhMMcvF0a3VBNfR5T54Sk4djZkbVUCRuZBqQ49xey0RNHIrTdKdI0WmdSrDYVoflvXG3LLzEa0F5XtmG1vpGiZewNAebH7LhYgufHtH0c0HkddVxTUb4wPgEUsG97O6yyhgN1BmnA4E2yGlUSl+LhXNkOdyZo1Ltrpx8ZYVWeoDuYC3qG5Yb4j3ZCoZ6IJJmZIqAf96OXj+FJgLMadGY6Az83HSNkMCe093ho0Ip3A5iXZVvCdbE+g4vMLvvb5ejKpbQuhuL0c0CUiOeNylTX/DxYmWvkXHX0uNFOF8xAwm+4LdbANQDt+Cwy+WFLKVp0zASpuVSh815z8VL5JS1uZ0Zasnh1Bmtol6Bw77jvgS8sPujPdP9ro23RomEkboL6KpX6Hi+BUPALqIDPiNOQoDXWgOP2np+SFA5T5YdDL9/rgfznrYoIW0nxT6g2+DB5D4NHuDDRNwzSKnNCpVksYXrB55lM4Nm1J4BKsowxiMhpP+LknVFrp2CdE2mYCxyQDdpaT02TNbvAkcR9e2lU3s35rExFOCJ7TRoAl14IfVDjetOLEY7Bj7TUdcmGCYXauj1HlIGTlF511+I1sQbs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f5a573d-cff7-47f1-480b-08de17d95a80
X-MS-Exchange-CrossTenant-AuthSource: MW6PR10MB7639.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 17:25:42.8524
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +d1ukBxBDJRtyiHw/dUcEdnCX1nGOywVCA3HDHMP11CBGpIbeZlNSt3/XDKReOu5JdLgOWG70zb7oqHT69b0EA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7054
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-30_05,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 spamscore=0
 adultscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2510300144
X-Authority-Analysis: v=2.4 cv=MYVhep/f c=1 sm=1 tr=0 ts=69039f9d b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yPCof4ZbAAAA:8 a=Q_IyHj9OCRPX1g5BcKEA:9 a=QEXdDO2ut3YA:10 cc=ntf
 awl=host:12124
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMwMDEzMCBTYWx0ZWRfX/94rFnPGJ7GL
 TLaQicEVCUi4p8jCoiFuTYw7Rom8CYcr4xefNkj00+WephpfDwGA4lmFegsfF6sgPMk+N4YYYgi
 wlmAX2OcTLFnOiDD38MUXXI0mq9znpNuZ4UO96Kbvk94kg2JDdqswzunsfvOs/8HeYU5J+SHWRT
 T89Wmrs1OeN4mgBW793uawwJrBYjfNIroeG65WPxMrjGM2APIV/YwgI3nXAYPDDFKC/MNxHhB3f
 RV2cTgSOkMagj4xS0o/TB9PlApFee07FZbGR7CiZnkMcVFt1Lio7dAKTiZKn4tFVmIGXr012Qkz
 uLxVoyLodQ08SbbH8rSN8HRtQgSYQZsxE7xH7UDaapals7fbUw41kCIKRnzal0StoRMK7Bi/47i
 rQxij/yw+VO164dwCns4K4fFz5JMhLKIUGhy7KukZxpnthjtXGw=
X-Proofpoint-ORIG-GUID: ZNdpjJTD3Dd5VpsqdCASWgwACSC9m8KV
X-Proofpoint-GUID: ZNdpjJTD3Dd5VpsqdCASWgwACSC9m8KV

Thank you for your review!

On 10/29/25 10:55 PM, Christoph Hellwig wrote:
> On Wed, Oct 29, 2025 at 04:28:26PM -0700, Dai Ngo wrote:
>> The reservation type argument for the pr_preempt call should match the
>> one used in nfsd4_block_get_device_info_scsi. Additionally, the pr_preempt
>> operation only needs to be executed once per SCSI target.
> One patch per change, please.
>
> Also please add a Fixes: tag.

will fix.

>
>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>> ---
>>   fs/nfsd/blocklayout.c | 17 +++++++++++++++--
>>   fs/nfsd/state.h       |  1 +
>>   2 files changed, 16 insertions(+), 2 deletions(-)
>>
>> diff --git a/fs/nfsd/blocklayout.c b/fs/nfsd/blocklayout.c
>> index fde5539cf6a6..4ca6cb420736 100644
>> --- a/fs/nfsd/blocklayout.c
>> +++ b/fs/nfsd/blocklayout.c
>> @@ -340,9 +340,22 @@ nfsd4_scsi_fence_client(struct nfs4_layout_stateid *ls, struct nfsd_file *file)
>>   {
>>   	struct nfs4_client *clp = ls->ls_stid.sc_client;
>>   	struct block_device *bdev = file->nf_file->f_path.mnt->mnt_sb->s_bdev;
>> +	int error;
>> +
>> +	if (ls->ls_fenced)
>> +		return;
>> +	ls->ls_fenced = true;
> What is used to serialize this?

ok, I'll use the ls_lock here.

>
>> +		ls->ls_fenced = false;
>> +		rpc_ntop((struct sockaddr *)&clp->cl_addr, addr_str, sizeof(addr_str));
> Overly long line.

will fix.

>
>> +		dprintk("nfsd: failed to fence client %s error %d\n",
>> +			addr_str, error);
>> +	}
> Also the error printing is new without any rationale in the commit
> message.

As Chuck suggested, I will add a trace point here in a separate patch.

-Dai

>

