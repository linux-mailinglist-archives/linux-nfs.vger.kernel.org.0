Return-Path: <linux-nfs+bounces-12912-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 144E4AFA60A
	for <lists+linux-nfs@lfdr.de>; Sun,  6 Jul 2025 17:02:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F62A17C61E
	for <lists+linux-nfs@lfdr.de>; Sun,  6 Jul 2025 15:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 561D717A2F0;
	Sun,  6 Jul 2025 15:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KdMweOJC";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="gO+IGX/d"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF70350276;
	Sun,  6 Jul 2025 15:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751814136; cv=fail; b=Yq52l0cBX+jXB80Psb+FMWHBhxgFEjiHFirSFx4z8f4k8kK5glIwjPFX9zYNgxa8eIPuu/CZTxGSqAveOoQC8141jYUbeL+MKDjOeQHvuWPvpn8oHgAp0pyloPOBm/8QyAIkWw989zDUb6gnbriPgN22nfHooPOwK3qFVwCU1LA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751814136; c=relaxed/simple;
	bh=8iM9+wWGC7b2HBIUdLVm4RctzR8d6jXCpqxCCF7JLjE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rxA6aF8hpNDHwWGxVEpsotnKzrNIFpqTsMrfvj99V0UTs8IKsP06sjdNrPt8/RsdX2sztt2FSQ9nAvMo4pOatjCJZnftvpvXi2ADiQPrRM8I7iFiwlv0rDe+lBkHJ3aFljxxsqlvWu/mpinsXyP7iH6kRah0kstqAcA9IlrtYug=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=KdMweOJC; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=gO+IGX/d; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5665Zfo6001953;
	Sun, 6 Jul 2025 15:02:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=XNm3WkiccUXkI8CM2KuTpAY//2CLTERbBDsCr7ZheqY=; b=
	KdMweOJC8+V9mRnJerG4B0nZT8kB93720YykzaO4e3Y+7I/+c7yRtuCVqyTsGcho
	EuHJq9toWkOKVzU3i5ctOLyMO99CyMe79CWtfDhsyKj7DtlXySKJ+2BUtwYeavix
	/xgQUZHOmiL2HMwN8Gvyq+JdrBgFksAUmZ8sLgt39S4E+3kJ+CqMK+CPrGc74stU
	UO0HYQe6AO8ViNaJL/rgIEq9hVyn8pf7wCeYfwhDDsxwnlPOLxrcyi0ZzhY0m765
	QSAhyyn89qHwqkp5avxX1/3beI6miTX29hmf9NI3vsZm+gpdQX9fGYWdeYmaoWa1
	TSxTlgVJAzDBTi1QOAbKuQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47pvkxsadw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 06 Jul 2025 15:02:04 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 566BJMsX040441;
	Sun, 6 Jul 2025 15:02:03 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11on2041.outbound.protection.outlook.com [40.107.223.41])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47ptg7n8vs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 06 Jul 2025 15:02:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LcUCkaa4KBbXoGFUES+Ueh5lNAHt2KQ9HfddLcDhYggpFkvh307Oozjkxpaz5ef8WeCXa6L//X7e+FV9VrSYPgbJxkn8uu63KZti/3ZV3Qw3X13Jlb4oD7o4oD9JHcPVOxwSGk4Vy5lNqeNBvc/lA25gec/7DEiGFBcffdQCwtlWM/dCl8jpVXYAZjoEvRYT6B/fremLPKgzQYpzMdincFCoaRSTKtlB2c/KC4JAi0rKQmME+irTY1M0DmkSEWqIVgohZ5DHt1dJaCOGBhsw0CFeaojpqk8M/c3pv5VybrYh1NyB78kaMG4WYl8PkrdulvTDglYq89PEM7aUJW9mdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XNm3WkiccUXkI8CM2KuTpAY//2CLTERbBDsCr7ZheqY=;
 b=P8eYcUemdxYOaHd5Vxq2RBDFX259o13sCCi0WI/GYYG1azRwVXXtk4IdXJOJyX1SyT9Gna5KRr03sV2QEaxNcSVndnOaTwNbtS18E+CEmsZC866nbZyMhrPT13jmcbPZcfhNbAEc5vxSG405CfJXk4zQUOKHTdWVHwG3l5UvjmXsXokfnpeuO8Y2BnkaNz1Qskc3mE0oYiiHmLHEPs26XsuSFjoJdhzBSfQexvsr2JBOvuTdW/25qPwdK8XJzIArqgWJlTYIq1JbMCiX6V9VdFu8ds51INFHJCkfsHEjECeZheY5k8Lg7I2u06rJdQVWTtCFbE3oRzxTXWc5lfVDiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XNm3WkiccUXkI8CM2KuTpAY//2CLTERbBDsCr7ZheqY=;
 b=gO+IGX/dhlDCAlaV4Hun96/iX5zBLcVXW9GPy090ICFXI0cWCjFn1FSALPg3sh19YlzRbZDLSSLmrgh+penwxTxIxpC01Vl3Etc4auEPGoACccVUOkhOLsdq5R3sSOajYYXlV8nlgG0r+HlZlpPkN7wP1IatjftXnTdkIL01s4o=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH7PR10MB5697.namprd10.prod.outlook.com (2603:10b6:510:130::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.22; Sun, 6 Jul
 2025 15:02:00 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.8901.021; Sun, 6 Jul 2025
 15:02:00 +0000
Message-ID: <050458ff-fe36-4f45-b3fc-8a1b4aebd622@oracle.com>
Date: Sun, 6 Jul 2025 11:01:58 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] NFSD: Fix last write offset handling in layoutcommit
To: Sergey Bashirov <sergeybashirov@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>,
        Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konstantin Evtushenko <koevtushenko@yandex.com>
References: <20250704114917.18551-1-sergeybashirov@gmail.com>
 <20250704114917.18551-3-sergeybashirov@gmail.com>
 <f1fdddde-2450-4a2c-a1e8-ee6a3ff81090@oracle.com>
 <2swioqrkdxgo3clt77vfc3iyta5diffsoecbqes7pisalsdm4v@d35b4pfsik76>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <2swioqrkdxgo3clt77vfc3iyta5diffsoecbqes7pisalsdm4v@d35b4pfsik76>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR10CA0030.namprd10.prod.outlook.com
 (2603:10b6:610:4c::40) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|PH7PR10MB5697:EE_
X-MS-Office365-Filtering-Correlation-Id: 5edd5fa1-5b35-4138-a16b-08ddbc9e0f4f
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?SWV1QTVsN25uTkZWVmgrb0cvL3NHaHJpYjR3N2gwQ05qS1M0ckVQdkszbG9t?=
 =?utf-8?B?UEhNVDhiU2U2VUtpYVUwNGxZd1RvU200OC9UUDdhVWNaczNqRU1yOGtCQ3dV?=
 =?utf-8?B?dVFPM1N4K0hMYm52emZ0RndTd1JGZXh6bmlVZVhKZTB1ek5jTnFrWEdvMHJs?=
 =?utf-8?B?andONkhHNFUrb1VkM0ZYSHpmcGdJZFhNWFVnTlkvQmJzbU9JU21ta0RwZFd3?=
 =?utf-8?B?Qk5KUlcxRitFSXlXbXBwa0ZCRW1PTFpWdkIzZGtVK0UyTkNRR3NLbzNjTmpI?=
 =?utf-8?B?SmQ3dWoyMEdzSW5aWjUwUzR4d2xzaUdNdUNtYVBRbVYzWXZxSkpuckIzMjlY?=
 =?utf-8?B?VmtqQzZYU0VSdnBCMWxSVjBLazZUZ1NiTHFORzVKYkVjQlB0bEVZQ2Q2RkVl?=
 =?utf-8?B?LzZNTDN5MEUvUlQyOXdIZVJLYmJRVlVhUmFIaFVaWGxNc2J2cDNWeWduYU1O?=
 =?utf-8?B?Q25rdG55cTZGOEJqSnB4QmN1R0R3VTYrT3BKVGxRTXlVRC9OVVFrSWxZdzRm?=
 =?utf-8?B?bS94YTVXZVA5RmxTYnFadzFPOGhoZlphbkhFSVc2djc0TGZSU0EyUkFoK0xC?=
 =?utf-8?B?dU5VQlJkbUZVVDZyUE9rWTUyQTMwWWt0cFNaaVVyS2NDajRRTVdGTFhnR1B2?=
 =?utf-8?B?Qjk2NlluY3hXM2pvc3ozeVd4YzJ1MThPRVVpS0pjM2tmWVJCQVZLL3oya1Qz?=
 =?utf-8?B?NTF5b2g1VE9nK1V3cDZPc29YREhPRjhWSW1jS1hpMjBaamhuRU5Eb0VkaVdZ?=
 =?utf-8?B?bTA2Y25qUWtCK1BpSkFZVEtmaFVyOVBIeVZQaDBDZmxjbnI0UEEzSUp5cC9I?=
 =?utf-8?B?S1luV1puVytTMGxEUjIxYWEvNmlTd1MxRW5rUkppOWFRYWtGUlpleTVCdWFx?=
 =?utf-8?B?TmJ3R3BidXZLNkVVVkdmVTlneVFFY3BQRDlYd1RFQ2xlS1drajh6TlZRU0J6?=
 =?utf-8?B?TFZYeWRGd3RVMGpXNG9IQjd6NUdQbDJqZlhXUEhXNlhoa1Exdm5UZGNQQ0lw?=
 =?utf-8?B?ejJoT2NyZkJUQUxNQzhWdk9rek5JSDNyUUxnY2p3QkNNVjNZMHhrbWpyWDJY?=
 =?utf-8?B?b3g0Tnhid1pNSFZoQkl1U3V1UnhmNk5YdVRvVlZFc0ZTZFpuMGxJeGVqdlB2?=
 =?utf-8?B?QWJLK2N3d2IyS2dBWlZPZEhWZTkrdEtSODBOeXBPZjFBOGgvQk8rK0FYMkRE?=
 =?utf-8?B?Ui9qamZwaUFFSmFXUXVCSGpscXVObkVQbC9lOFpHUmlhU3lsUVFGUU1sN3NZ?=
 =?utf-8?B?MzBTY2NQYXdQRk5xVTVEY29MRC9pcDBZZHZDaVhLSGdkNXpGZGNNM1R1bGpj?=
 =?utf-8?B?K3ZPTVR6c1ZralZrQU1SdVhFQm5PZWdZdkdySWxrZDN0dVlzZExUcFNISWF5?=
 =?utf-8?B?aU01ZWtuQWgvUGJXelVMM0graFIzc0lFTnU4dzdxa3R1R1VWeUJSU2ZJNGNV?=
 =?utf-8?B?ZXpSU21QVEFiaDFYM0p6UE8rYUIxM0hkWXpmK1hmZ1k5Q3Z2d3J4YUo4U2FC?=
 =?utf-8?B?Q2RCdE9IbzVLSjBuaTZpRGFUZHoxUlBjSDV3OUVjM2lwT1BvMGM5SEhQQm5p?=
 =?utf-8?B?bTZVNWtOSW9Td1JLOVR3ZW5STkxiOHY4LzdKZGl4WndjVnZWVXY5Q0xpbU9X?=
 =?utf-8?B?T1Fua1c3cXdiMFA5dEQ2NGFaYnRpcWY0Sld5Q2lJVDFsaUcyRU52UU1YZzVS?=
 =?utf-8?B?aWRROHhQblFteG1CVkZnbjU4L3RZWnpnbDlXUVFHL01uclJVSVM4WUQ4Q3lT?=
 =?utf-8?B?S2JQSnhaWTFXRDlzR1EwMXVkdXJlWmQ5eTdlOHg2MDlJWlRqTUNFUnBTb3Vi?=
 =?utf-8?B?NXFyamhGSFB0WFBaTWZSanR2RElhUEV3UkxjS0xPcUdndVRSSGNJMVlVUTBT?=
 =?utf-8?B?TVh0TXNka1ZqZWY4TzJQZUp5UU92QktPSzEraWxTRDNCVmZOOW5IWmZzU2dx?=
 =?utf-8?Q?gaWVK3zZRaM=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?Y2c5TzBoM2gyeVNzYjNhSCtuRUlSZXNJTzBWSEhCamhlMVkveU1qOU1UaUtV?=
 =?utf-8?B?azFFMDVWUjRjZW1mZVp1amhhRGlMc2k1bFFEbTBYR3RzT0E0SWt4Vi9mVlU2?=
 =?utf-8?B?NVpvZHJsM0NSeDRKVU9lMllPb0JmUldlR3dBbXdPRWJDOGVBME93ZXM4cmtL?=
 =?utf-8?B?WE5kaG5ROU1Nc1QrNTNkTXdVajhiVVM4cVR3TVpVQjRqYi83cjJuU1A2R050?=
 =?utf-8?B?M3JOdXYvNzU1VUFtczVtSHp3Und0MjQrZ1FBL0FtQWRROWNMKzI1S3dvQko3?=
 =?utf-8?B?bnp3cG9KZGZONndkSkU5MFVMZW9pTUxsYnhIeVVBeTAwdzNrMkMxaG1zSW9N?=
 =?utf-8?B?U3k0WllvR3Y5WFNDbEpJd1U4ZDZxRXF2T0xuRzI0N3hRUHdMWGxMZk50YUZr?=
 =?utf-8?B?Zk00S2NWbkRDeS9iczE3a25xa2FlRHcvUGZSODlzaHdaTWU1L251OHJIUy8z?=
 =?utf-8?B?S2Y0bHNDL2pseTFKMEs4YXR3b1FHSFMwSHVyVXdCam5jU2JqNWFrNHlEYjlJ?=
 =?utf-8?B?QUxEaFJWeHNnOUFBcFhmQjNBWGsrczJSS3JQZElwUzlRMHJQVXBtT2h2V1p3?=
 =?utf-8?B?M2t5ZlVkQnI1eXlUbzZNZW9INFk1SERQN0ZRZXFFUS9iTkx2L1pSYVR1N245?=
 =?utf-8?B?U2s2ZkdyeFF3cFRxMmttbzJBay9mWEJPeHpOa3dTMWczam1kSklBc0JMemtQ?=
 =?utf-8?B?SWxqOThrc1dBSDYvME1DYjVRWFRLVEExaE54SXdITUtjVE1pNTAwU2t2VFNx?=
 =?utf-8?B?UFdkR2QxZlA1cGhtSnNlRnZWNE95T3B3TkFZUGJzbW53YU5YaldyMWt4N0Zu?=
 =?utf-8?B?a2V0dFhIOHdmQWJTaS9DMUJKY2hJcEJoWXNnK0lpeWpnbHo2V0lKYWR4Z2xZ?=
 =?utf-8?B?MkVOUUFwYlBMUDVyOC9lN0p1WXhaTW1WSWUvWmEvbFUvOTNvY2xBUy9UcGgx?=
 =?utf-8?B?UjdxSW9PQUZnMW1raExGMXlYeERJWFljQi8vNGhjRTdCZWdaMmJEN1dhd3Qz?=
 =?utf-8?B?UlBXUjZKWS9QenFZSXhZS1dKenpRK1BkdE9zblpzVm4xQmFENmlEdU1oSTBm?=
 =?utf-8?B?Q1NYY09FVmxGdDc1ZzlFT2RiZTVkN0x1THYrVUJOV21KcGVLb29laTEzWlNN?=
 =?utf-8?B?dy9FZitSMDBBcXdpN05HNUFlT1BVc3VwNGFCY29XL1R6RjdyZFpHK2o0ZUVF?=
 =?utf-8?B?dzdsNFdWNk9jTGVWSWRYdVVmRWQva2JBemRPWEpVSHlxWE5iS3NQc29xYWk2?=
 =?utf-8?B?QVlJM0FxL2VGbmJycm9NY0dZRFg3ZG9wTENJMHdINHNvdkJSM0pLM0tBQU4z?=
 =?utf-8?B?bjZYU1VUSGlmOFp0emRQOUpSQmdUd0prVWxPb3pEemNZTUYvNGU0b21ZYTZG?=
 =?utf-8?B?RzIwK3dYUittWnV1d0pmeVZtVlNnUEY3RzVFSWVteWZWRk1VSG9GZWJYVklx?=
 =?utf-8?B?eUZTaVNNZkJhWmtiTjdrNDY0SmJXRFdhZHBvVzVDcGZZS0pHMllJSW5lbmRu?=
 =?utf-8?B?eUVKRU8rUEozRTdSZGJoZ2ptR1RJd1kvL1hidzZUMk5JZ01CS09FV3MzcUow?=
 =?utf-8?B?dHUyQ1ZZeGNHbk84czBtcGVlZmRMYzNCMHBGWnc3QU0zMTFGSXlURmsrc0lU?=
 =?utf-8?B?QkN2ZEpmNlJMTnpWSU1reWd3SGRFY29uc3UwODZ3N1AzejIyWll1OEE0RGo4?=
 =?utf-8?B?WWJ2Zk9XSi82MDNhQzhXTllvVitqNW1tTXk4bW5VNzJmeWdaV0R3a1J5QmYx?=
 =?utf-8?B?VzhrVDhyUU5qdzJrWU1sUzZJK1kxek9odEhkVlZPNFZEdkhOREp0Y05FdGY3?=
 =?utf-8?B?Q2FuWkpPcCtWU0R6ZG1FRXliZ3RhQk02UHJZOUNXbHlQOE9ucW00ZUJKZVMx?=
 =?utf-8?B?WkxzZzIyN0U2cW5za0o3akxTaVBmbGlGblFGMmdWYWp2MWFPZWVvS0ZjRDdX?=
 =?utf-8?B?VmU2QzloUDRnM0dUQWQ5S0ZsZ2NSUGZaRVlZeURwRGF6TythdG1obGcvWGIx?=
 =?utf-8?B?Rmo4eHM4R3ZCclpZVEcvcjAzRHZvais1TFZoaWpiQ21SM2oraEZoVEswNnFP?=
 =?utf-8?B?SCszRURpbXFXTUFYaStab1BIeFhwVTlxV2dhYS82WSt6Q29OaE5jK2o5dFE3?=
 =?utf-8?Q?vE9CN8y5+xUpaUrZBKA8uUEVV?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	coQbZKH/i0hv1xsqwA+WHy2FmpALaYG2jN8AO3EcDhgMlJNsP73bgRFKXPQUGZlJgSccMzjy6eyhZL8bd48rEqBuXJyEk7psHuy0lQyj/aN1XDA/C7lmR8ePzniz1bQ3pO/bOsJauR/SDxIgdXTLVR/ha6F1Utv/FKIu8LwMOWnUcgKnX28yMuFchRSPzPNNHZsl3lT6tJSStxeHlfp5K+N57T5CDxdDMJGPf0qP5bsFZv8//8zl3dLH9wxJVkIxRnXJ2PZURtbdFETRPec2XfypAdONLQa/pok9uDK5GbLpylNIQh/37fj4ayyevnNqxHSFeeuhhYAL5r9QOFpITlwSIjIuKAKwa9BkJaUjLz2o47w3cLpqe6ZBX/jOO2IjfjvHh5XBXXKybPXZmEEIfI1L7OO5q1B0ytLOhyV7r+/R0FHvzgkhD6tyxWbX+vwaSQ3vDorZ+70+JiGx/87CReDbYJ+ak6BkHwOywl6ElB/G0doNoNx0zm4GunCx/3xT98MGO/bfPIxfUFrYAw+0DFK65yWouWux5EC5ZQRy7mX6vHS0446LwFN875ps0Qd2QLC0ggbkSn86u8r4Bi/z2CwROsdWeLMsoKZrvmYCgI8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5edd5fa1-5b35-4138-a16b-08ddbc9e0f4f
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2025 15:02:00.6513
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AEQ0iL4YEbzJ7h6PeIjkEsXPczjYtRHmETmVz+eQuoGcOgk8iUrJjh2Vd96jEtWRwx6wjahWrC7dLsQtnTLyYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5697
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-04_07,2025-07-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 malwarescore=0
 mlxlogscore=810 spamscore=0 phishscore=0 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507060095
X-Proofpoint-GUID: Anw22M2l8m7lrGGJn4oqGDjXRW0FikL5
X-Authority-Analysis: v=2.4 cv=a5Uw9VSF c=1 sm=1 tr=0 ts=686a8fec cx=c_pps a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=tN1nE8GmmqShDwqSVg0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA2MDA5NiBTYWx0ZWRfX1gDEc9c4Qk/h j9V2Zbz4d1BJpU9uaIEN/i9wbuzGftb0+bbDCIM8RZiC50H0RmOPVhAYwVe86QAGY5jAAPKhxeI QXFgIwurTCLircr976lniZHPFyvQ3Q7HyvHQoYmz/O141LtCoP7rQRCJ6Wbq+OKz7pBD+qjaHX7
 XNaYZLh8LeHQJMYrAX4GZNvwPwwUGk9npwhrhAPZ2GKrCEFmw2hz1Vtw/Lc18BX4zf5YjXqWnpN jK5WerfyLPo/BiC/5uSuxij85bs5IuOTvlt1+zXEFQhKZE8B/n+NeoZbDltKpgo74NpiRTBTD/D t8Dskdxb+yvK9zAF0O+mIIpaNaVuGYq5Y3FgBQRCqmgLWPVtuYlFhBV+Zt1xhCgpMzxmn770S1W
 9FUzXBQ+I6OVYbw66rZqaUxL22dsAbxBw28c8IUZ7+efzjGLHNOQnJoxR1IT0QnMRvQmRwwa
X-Proofpoint-ORIG-GUID: Anw22M2l8m7lrGGJn4oqGDjXRW0FikL5

On 7/5/25 2:16 AM, Sergey Bashirov wrote:
> Hi Chuck,
> 
> Thanks for your kind guidance, it really helps to understand the
> process of code contribution better! I'm on vacation next week,
> will rework and resubmit updated patches when I get back.

Dai, Jeff, and I appreciate your help with NFSD's pNFS implementation!

-- 
Chuck Lever

