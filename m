Return-Path: <linux-nfs+bounces-1487-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4372583DE59
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Jan 2024 17:09:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDA98284AED
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Jan 2024 16:09:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 643BC1CF8F;
	Fri, 26 Jan 2024 16:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BUYtBrOx";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="MAIJlzuZ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8271A1CF8B
	for <linux-nfs@vger.kernel.org>; Fri, 26 Jan 2024 16:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706285367; cv=fail; b=Nyz0xgpiPIUhjKQhE+DYrert0VkdwpHN6dmnU/C2/RvndcIe20nZt0HHeEG+N62fP5TmDvqy1AHnJuVDdP9n4aHd/XIPbmlAfBMVrgT9tpEjsF+YVGbxSc6voMUCi26SZ7wDycOfISsJEvClbsFqCrnCWSgTf/O4Z4G+7vkrMgw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706285367; c=relaxed/simple;
	bh=K9gokjONpcds2psZpk5FPb5qEy72h2rVms/DiGVc8H4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AZl9O+MMorLJS2JzRHmbW9DDJAUIdSOyubDmt4zz4V8SdqCrsOSVczd5cW/OJABVIV+6gRNPPNKHinMBgYstb/dbc4UV+JTPXJBjv/tdI4X27RAXeB/sidDTyUd2vzNgB/A9vwuEes+PumDb0xUUK+Q08+968TxYmyekEy1Yuxw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=BUYtBrOx; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=MAIJlzuZ; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40QEiTxU022324;
	Fri, 26 Jan 2024 16:09:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=K9gokjONpcds2psZpk5FPb5qEy72h2rVms/DiGVc8H4=;
 b=BUYtBrOxohIbvJSJc94rA8/psLrzHtZejGhKz/Xey1B+Ck7WOp6ZUepRKiVdS4BTVQMO
 jJSnz7A7woGi4e2rSZjN3bqNcKeC6QIdOVKGRU48Kg1fnHpxrAzlVVN5avqtrmKXWer/
 GLUToJBZmVLyHMbQlfHnLH52QsRHZhCpGb/9agDd3KmE3zLpPS1sVWwmyRsuh90pN6Ad
 su3nyWercU6Ok5LLEd/DXlfUE/shxoJIwh/1tlOROyK/DEM7iKHAQ2LBLDlYiy/Z5S3Q
 9MetenrfES99AEhjGAebI4F+lGobd25Cja/bpSVQm10qdujWpGjP/aDpDyfbLNseG0lf 5Q== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vr7acamck-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 26 Jan 2024 16:09:20 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40QENsD0011776;
	Fri, 26 Jan 2024 16:09:19 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3vs327jj4g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 26 Jan 2024 16:09:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VlyY/ZIuiReuTzcUaEgfJdzZOMR7/rUHFRQnX4xD4cgAAO32vd9T78HKeuxHKVFweJpt/1ugf8dawfdsJRMFCggBoBFMSk15+xb5Ir8xt8ACUoNHsvqDkBu3vFqyTkclNWz66QfgShCpjb71k5ugnVM3MIx16Sdhtbb2NyFMRW81Pp4iIPPtX7KiqgrCWjqytE2gt2l/iyhpxaPakSm+iWSfpfs6W1RAhQchaZVjL4C8Gg7zwie5R8KnRv3N5n5wRpplBP5T+BCMXYeCktFC859uCLm7jVJIKxIXEdJLgiHPI6OcnkFmwxfGjI96HTdADlJmCfiEVHtsKERcdhNYiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K9gokjONpcds2psZpk5FPb5qEy72h2rVms/DiGVc8H4=;
 b=Ppwc0W/OHFJ82UB6/0MrXHRsxMKIBTEMBzJUvmUZN0KSpXojSno/rmTcAfSVrcl8PjNy8MDO9ufnGVOcLcs2zJ1Ycy1H/AARsE1jJvDQGIeZQRShUM7FyTJ7//8ftyTjSwwXPNMPO5R9tRLAR6cwrEvPk0JFgWcQtQ+jT490lsLT1jIECFRbsEKQHMUSChlowkpVGodPa5gaNk5hhbMDDa26NVCuUpVYycX94MURdUkPgbYfI39F5K5wkg02EaS/QMty3z6C2PiTm2s5fFpbukkTiIbb+JMV/piMKQWvwi/wj6q4RnzOf7fBx+RvTrJ98Bn5Mt8N+QHkHjiSmFm+TA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K9gokjONpcds2psZpk5FPb5qEy72h2rVms/DiGVc8H4=;
 b=MAIJlzuZ7Wccc+UWaiWdMRJ12UJc8oHGoxJr44XZ4mdjasuTjAtXnxj7VXiwHDrZA1B+gSCncmWHtFrDWCv1S+H6hQIK9af9O727uYqWFIQS+bfwq/zRuYjk6yFu4jFvdLFGB1PfLAuB3HVrkM2zrcnKqFtZKegXau3rA6EYnEo=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS0PR10MB7903.namprd10.prod.outlook.com (2603:10b6:8:1ab::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.27; Fri, 26 Jan
 2024 16:09:17 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ed:9f6b:7944:a2fa]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ed:9f6b:7944:a2fa%6]) with mapi id 15.20.7228.027; Fri, 26 Jan 2024
 16:09:16 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Josef Bacik <josef@toxicpanda.com>, Jeff Layton <jlayton@kernel.org>
CC: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v3 00/10] Make nfsd stats visible in network ns
Thread-Topic: [PATCH v3 00/10] Make nfsd stats visible in network ns
Thread-Index: AQHaUG4C+4uQY5SwQ0C91OpquKLptLDsQx0A
Date: Fri, 26 Jan 2024 16:09:16 +0000
Message-ID: <042AE6F1-DA11-4768-8135-CD3C7762CF77@oracle.com>
References: <cover.1706283433.git.josef@toxicpanda.com>
In-Reply-To: <cover.1706283433.git.josef@toxicpanda.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.300.61.1.2)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|DS0PR10MB7903:EE_
x-ms-office365-filtering-correlation-id: 89fe4385-f5b8-40b9-f77a-08dc1e89257d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 KJbSAe38rP1Ls0USCknqPwems9VfQZeBPuewdCPjSWQtFor72b1LzWQNTNX85kFAdJ7Y+kaegqJZVRvbVEpdVIwm2nlO87o4cDDtmjPuEgPQSZ+BKLRtyWtv6jDC1nuUsmihHY8qdyzSc29MaDAOoCTxuuVefNmiUR26mH6+uebMXRzsYUD4vc/p4LL36bdYqHuBepoWqIyMh3VKvEDHY8t/ig8MPUylYhnPRhBjIUnRgwXCsoRuCQCKqqXDirFHzQhs8XAFIJx6VvFHCuxEqwK8YApEdzM8k1XyaX2tjjTShua9jFjEE0pMmU/XdRxXQVLwqABmbqqiREvZH34TTARGAZmeKI0ED3RRC1eyXe9VDMqTj4FlVC5dUy4KtE/G0H6lhWDPKMt99EFMcHfUy7PNatWiVrpkR8InWDeSrpTUhcqWEsvtBGjDRE48fMGAYbpeIY8kDu0agWX2beIZ6lebSLH+j7Z2aSE2x/KC/C4sfSnzpbMBXlqzCjmabGO+YHzQPsidG4GXJhhiY5aXiAEZfko8C9+VZxJ6o22nSH8Ah7ZF+FVGFmlV9snjBbFltTtVS6pL6CGMugMu7P2i19p33bNc35V6sQJXgNI2M79CeISY37/NIYZVsZjLOwFDzTtKbtirhvH/D8CFVfd+bQ==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(376002)(396003)(136003)(39860400002)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(966005)(53546011)(6506007)(71200400001)(2616005)(6512007)(33656002)(26005)(478600001)(6486002)(110136005)(91956017)(86362001)(64756008)(66446008)(66946007)(66476007)(76116006)(66556008)(316002)(8676002)(83380400001)(8936002)(4326008)(41300700001)(5660300002)(36756003)(38070700009)(122000001)(2906002)(38100700002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?U2pOejNjeEVPQzkwWHlkVUx3Y3NTZGhEaHYvTjYyRzdUZGZFNFVQL2hEenpC?=
 =?utf-8?B?QmNhYnNteHlPWDJTUmhYRzhMRTk3T2pDUGxIenBRYU54K1V4YWdMM3h0Q2Ro?=
 =?utf-8?B?MHFaOEpBVlFxaXVFUG1OSkQrSEYrN0NCU09IcTgxenZQMlZDNVNoUThuSE5Q?=
 =?utf-8?B?cEVqZW0zdFl6N05qdDJyTFZqZlg5ZUkyVWd5TUZwcFMrUlU5TUZ5VnE0WFBZ?=
 =?utf-8?B?VEJvTkZPaFpVc1kzVDl1MHlKNERvL29ENFBjUm1Gd2xydzFxUytHdVVCMldh?=
 =?utf-8?B?SVljcEFCdUw1M1BER21aa01aVkRmbU83SEJMcFFuVXgwQUw3bE82QzA1ZEJ5?=
 =?utf-8?B?SUVtRTkrbmlOd2N5TG1yVzdlSmdUQkFpOHF4WFh3RDgrMjJqSW05NkFwMFJQ?=
 =?utf-8?B?bEF6OFFBR0Yrd1FLVzdBTUpWcS8zNklmczYzaXZFaWJjcU1BQ2ovbEt2b2cr?=
 =?utf-8?B?VnQ5eWhQUFBzMEdhdjh4MVQ4K2J1eEw1bGRoY3E4U0ovZDlDZExDQlRkT01M?=
 =?utf-8?B?QjlXZXdINkJGdys2OGdZWlVmK1Z5bVlKWHlraDBBakF6OXNUeGpmWjlyckZR?=
 =?utf-8?B?eGdFdXlEbytFTmZlVmoxTDFkSkNaTUNoRVRweUMzbElQNyt1bUtsalFzZ1Bt?=
 =?utf-8?B?Q2xHV0hNM1Q4UU5USW9hOTdvR3plUFlyMnJvNnNLd09RUmlQa0ZSaHRHZWZL?=
 =?utf-8?B?Q3FiaGlzRjNhV2tERVoyVGx3NnVQTEtqbVdVNHIvclJrd0RUQkIwRWlyMmxY?=
 =?utf-8?B?YWs1TWxwdkgxV2lnR003M003QWhWVVcvOUhZdE5XNllxV0ExZjNvMHFIUHRo?=
 =?utf-8?B?QzRuZGlmajlTbnVVd0JlWkptaHNIcWtFMXlWd0JCMCt3dWwyZDJLN3lJbDlF?=
 =?utf-8?B?QXdaTXZWUDZ1UVhNL0JWVWgrcXFubDRYcVlOaUpuVXJDclRITTlIRTZpTklP?=
 =?utf-8?B?N2U4aVRpeUtGZjd5Nm5nUkg5K1JiRnZBWnRzelpIaVBtblZRTFU3V012a1pa?=
 =?utf-8?B?UnFXYmRLVC80OFZjRkp2OHlVU083Wld2R2VsOGEzSHJKcVc3Y1lmaDhVVzIz?=
 =?utf-8?B?UVdCTmliVTllK2FGN2lIU1ZvTzJ5VzNXQnorU0pxc0tlL2p5R3RLd1FQK3JL?=
 =?utf-8?B?S0pNZlNJRFNlaGVtK2ZaWFlnaGdCVUdjOCtMVVhlZjBmSGFoWUJLZ1ZMTzFJ?=
 =?utf-8?B?V29Ed0VxSHRhVDF3Z0hxaFl1ai9qd0lIOHRzWE5HMkZPWStJcUhNckVwWWI0?=
 =?utf-8?B?UkNOWEhubDBJdVFTVWxpR0tCVFROY3dyMkFWd3FFSWdJeW0ydXI0YmtCM3JH?=
 =?utf-8?B?RHJjTUJaRTRQdXVNZ3lvbVR1L24wZDMyMVl0KzRHTGJyajFRaWU5ZVlPZnI1?=
 =?utf-8?B?T3JNTWpRS2tWNy9oUlc2b1VOWUpjOUUzYWFjQlo1cnowUGVUb3ZwYmpUeEE3?=
 =?utf-8?B?Y2ZaN0wrNDFrd0VPY1pWS2hoOWpvaGpRQ1M4dGdIOWNQb0twZU1tUURpcXky?=
 =?utf-8?B?anZoQWRvMTBYd1l5TUtEU0tObERBUm01UjkzSUJ1NUNIQk9IbFAraGVIQWxZ?=
 =?utf-8?B?YVE3WTRwc3VsVE1UaXQyb1d6TUZVeFdEbzhHYWJjNGtoMUZHdEJNVVV3elJC?=
 =?utf-8?B?Zk9za2dMU1Nld0pOTVJESEY2TTVhNmlwUDB1L3JCT3p0WFQ3NEM0UFE1VjZv?=
 =?utf-8?B?ZnJTRTQrNUlXa2JhYnF6YnJnMHgrc3pOM3IxT1pmNzJsUlhxbmRkQ1ozRkRw?=
 =?utf-8?B?OW03enNrQzJoNDdMcGhROVE5N1ppVWR5RWpKSFo0VGcwdlJ2MDhnQUd6a3pi?=
 =?utf-8?B?eDlrcjlsRWFXajlodUpGcXRsTlhUTitSeGRTQlFBdXh6WDJQT2tiUGk0Yit5?=
 =?utf-8?B?MlMzZVEzU2NJbkRHTGxQMHVpNm1sRStEdjh5elpxTHNyMWtJL0xWcUpKTGt3?=
 =?utf-8?B?enQ0akJ4TFFsQ1hCY3Z5Y0pLcU9xWldUWGQrWUlmazVkbDdLUVlWRFJBZGIz?=
 =?utf-8?B?bnk4TmNoVHprNkxuYkZOUlFZcUhnOVNEWnJWTzRmWXVpcU5STExlSEVjM1d3?=
 =?utf-8?B?alZrdERDcW1nc3Rid3RzWUdDVnVId3FXSTdIRW5laXNXRDlnRVhlTDFZR2pQ?=
 =?utf-8?B?RHlhK3gvMWg4TzMrVXU1U0xNM1AwMHNMdXpCYWNiL3IwOVZqZStKc3l3cU0w?=
 =?utf-8?B?V0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2CFB89E2FB0D2A49B83F07940194F9DB@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	rLTaZ8JQTwOR/NZrQKS/nNXDVq/kIiZcLwPu5TbIWBgUh+hENrL/P5PTU2bE7UOK0Jd7u5ww3ONvzesbWNze/4pURoJsdjM7s+m79ynBWurcbWmvVhsA18yWjRvIzqzTl1c+KQUppbEb8K22a/K5KVsNHH5USOWGGWL+OhcWRlzGMP8DLlELd86a6dOG/PdkbEZbD7k1ucPjkS3oF10SQcDtg6HbUAj7HAD+0w3YqgGPP/9xzU1h3Rtcuef26oYtYJ51wbZ3ZvNtQpwZ20AXrtv3ZdjtmAkRIXZJCSLtVA3a2gBHsM2AnuvMTEZ7IuFcBSKBCLaMunYRRGZUvI8V9MVuk0IdRU4gp2WxtpxPazysqbElFxU/LLgEH7KIs89gjo3t52lyk5xWDEdJ+kyMEF1114Dq0OYQMj7AGiETKqKdNGfn0Rk/gVFf0Pr4MeF8VV8oQGVw0RPYiZXe1p3iTuozXsRFzr6l8vRqYbl8JG4fawly86jzdaDD19XsNoCYZ56XeBXFBiGStjik20HMK/E3os4nlfuuI9Ua+P5arecx80xv2R7oZVz6mW1NHB0ZXwYhJqYdrr5VnxQBE/5aMlRhAtuE79jU+U4cxARdjGc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89fe4385-f5b8-40b9-f77a-08dc1e89257d
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jan 2024 16:09:16.8018
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P0UBwhKhjbIv2ie4yvXcwmjOtatkEz7XMxOVkD6UhX8nFsD8er92NiBhLgeRfi/XUaBcLsH7I8Gz/aqHpq4HkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7903
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-25_14,2024-01-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 phishscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401260119
X-Proofpoint-GUID: r2TmFR4gVGHvzla4KdppnZ3Wj7nNQCfq
X-Proofpoint-ORIG-GUID: r2TmFR4gVGHvzla4KdppnZ3Wj7nNQCfq

DQoNCj4gT24gSmFuIDI2LCAyMDI0LCBhdCAxMDozOeKAr0FNLCBKb3NlZiBCYWNpayA8am9zZWZA
dG94aWNwYW5kYS5jb20+IHdyb3RlOg0KPiANCj4gdjE6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3Jn
L2xpbnV4LW5mcy9jb3Zlci4xNzA2MTI0ODExLmdpdC5qb3NlZkB0b3hpY3BhbmRhLmNvbS8NCj4g
djI6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LW5mcy9jb3Zlci4xNzA2MjEyMjA3Lmdp
dC5qb3NlZkB0b3hpY3BhbmRhLmNvbS8NCj4gDQo+IE5PVEU6IHRoZXJlJ3Mgc3RpbGwgb25lIG5m
cyBjaGFuZ2UgaW4gaGVyZSBhbmQgaXQncyB3aGVyZSBJIGRyb3BwZWQgcGdfc3RhdHMsIEkNCj4g
YXNzdW1lIHRoYXQncyBvayBmb3IgdGhpcyBzZXJpZXMsIGJ1dCBJIGNhbiBicmVhayBpdCBvdXQg
YW5kIHRoZW4gZm9sbG93IHVwIHdpdGgNCj4gYSByZW1vdmFsIGxhdGVyIGlmIG5lY2Vzc2FyeS4N
Cg0KSWYgdGhhdCdzIGZvciB0aGUgTkZTdjQgY2FsbGJhY2sgc2VydmljZSwgSSB0aGluayB0aGF0
J3MNCk9LIGZvciBtZSB0byB0YWtlIHRocm91Z2ggdGhlIE5GU0QgdHJlZS4gQW4gQWNrIGZyb20g
dGhlDQpjbGllbnQgbWFpbnRhaW5lcnMgd291bGQgYmUgbG92ZWx5LCBidXQgaXMgbm90IHJlcXVp
cmVkLg0KDQpJZiBKZWZmIGFncmVlcywgSSdkIGxpa2UgdG8gdGFrZSB2MyBmb3IgdjYuOSwgYW5k
IHRoZW4NCkplZmYgKG9yIEkpIGNhbiBmb2xsb3cgdXAgd2l0aCBhIHBhdGNoIGZpeGluZyB0aGUg
dGhyZWFkDQpjb3VudCBzdGF0LiBKZWZmPw0KDQoNCj4gdjItPnYzOg0KPiAtIFNwbGl0IG91dCB0
aGUgbmZzIGFuZCBuZnNkIHJlbGF0ZWQgY2hhbmdlcyBpbnRvIHRoZWlyIG93biBwYXRjaGVzLg0K
PiAtIERyb3BwZWQgdGhlIGNoYW5nZSBhZGRpbmcgc3Zfc3RhdHMgdGhyb3VjaCBzdmNfY3JlYXRl
KCkNCj4gLSBDaGFuZ2VkIHRoZSB0aF9jbnQgdG8gYmUgZ2xvYmFsLCByZS1hcnJhbmdlZCBpdCdz
IGxvY2F0aW9uLg0KPiANCj4gdjEtPnYyOg0KPiAtIHJld29yayB0aGUgc3VucHJjIHNlcnZpY2Ug
Y3JlYXRpb24gdG8gdGFrZSBhIHBvaW50ZXIgdG8gdGhlIHN2X3N0YXRzLg0KPiAtIGRyb3BwZWQg
LT5wZ19zdGF0cyBmcm9tIHRoZSBzdmNfcHJvZ3JhbS4NCj4gLSBjb252ZXJ0ZWQgYWxsIG9mIHRo
ZSBuZnNkIGdsb2JhbCBzdGF0cyB0byBwZXItbmV0d29yayBuYW1lc3BhY2UuDQo+IC0gYWRkZWQg
dGhlIGFiaWxpdHkgdG8gcG9pbnQgYXQgYSBzcGVjaWZpYyBycGNfc3RhdCBmb3IgcnBjIHByb2dy
YW0gY3JlYXRpb24uDQo+IC0gY29udmVydGVkIHRoZSBycGMgc3RhdHMgZm9yIG5mcyB0byBwZXIt
bmV0d29yayBuYW1lc3BhY2UuDQo+IA0KPiBKb3NlZiBCYWNpayAoMTApOg0KPiAgc3VucnBjOiBk
b24ndCBjaGFuZ2UgLT5zdl9zdGF0cyBpZiBpdCBkb2Vzbid0IGV4aXN0DQo+ICBuZnM6IHN0b3Ag
c2V0dGluZyAtPnBnX3N0YXRzIGZvciB1bnVzZWQgc3RhdHMNCj4gIHN1bnJwYzogcGFzcyBpbiB0
aGUgc3Zfc3RhdHMgc3RydWN0IHRocm91Z2ggc3ZjX2NyZWF0ZV9wb29sZWQNCj4gIHN1bnJwYzog
cmVtb3ZlIC0+cGdfc3RhdHMgZnJvbSBzdmNfcHJvZ3JhbQ0KPiAgc3VucnBjOiB1c2UgdGhlIHN0
cnVjdCBuZXQgYXMgdGhlIHN2YyBwcm9jIHByaXZhdGUNCj4gIG5mc2Q6IHJlbmFtZSBORlNEX05F
VF8qIHRvIE5GU0RfU1RBVFNfKg0KPiAgbmZzZDogZXhwb3NlIC9wcm9jL25ldC9zdW5ycGMvbmZz
ZCBpbiBuZXQgbmFtZXNwYWNlcw0KPiAgbmZzZDogbWFrZSBhbGwgb2YgdGhlIG5mc2Qgc3RhdHMg
cGVyLW5ldHdvcmsgbmFtZXNwYWNlDQo+ICBuZnNkOiByZW1vdmUgbmZzZF9zdGF0cywgbWFrZSB0
aF9jbnQgYSBnbG9iYWwgY291bnRlcg0KPiAgbmZzZDogbWFrZSBzdmNfc3RhdCBwZXItbmV0d29y
ayBuYW1lc3BhY2UgaW5zdGVhZCBvZiBnbG9iYWwNCj4gDQo+IGZzL2xvY2tkL3N2Yy5jICAgICAg
ICAgICAgIHwgIDMgLS0NCj4gZnMvbmZzL2NhbGxiYWNrLmMgICAgICAgICAgfCAgMyAtLQ0KPiBm
cy9uZnNkL2NhY2hlLmggICAgICAgICAgICB8ICAyIC0tDQo+IGZzL25mc2QvbmV0bnMuaCAgICAg
ICAgICAgIHwgMjUgKysrKysrKysrKystLS0NCj4gZnMvbmZzZC9uZnM0cHJvYy5jICAgICAgICAg
fCAgNiArKy0tDQo+IGZzL25mc2QvbmZzNHN0YXRlLmMgICAgICAgIHwgIDMgKy0NCj4gZnMvbmZz
ZC9uZnNjYWNoZS5jICAgICAgICAgfCA0MCArKysrKy0tLS0tLS0tLS0tLS0tLS0tDQo+IGZzL25m
c2QvbmZzY3RsLmMgICAgICAgICAgIHwgMTYgKysrKy0tLS0tDQo+IGZzL25mc2QvbmZzZC5oICAg
ICAgICAgICAgIHwgIDEgKw0KPiBmcy9uZnNkL25mc2ZoLmMgICAgICAgICAgICB8ICAzICstDQo+
IGZzL25mc2QvbmZzc3ZjLmMgICAgICAgICAgIHwgMTQgKysrLS0tLS0NCj4gZnMvbmZzZC9zdGF0
cy5jICAgICAgICAgICAgfCA1MiArKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0tDQo+IGZzL25m
c2Qvc3RhdHMuaCAgICAgICAgICAgIHwgNzAgKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0NCj4gZnMvbmZzZC92ZnMuYyAgICAgICAgICAgICAgfCAgNSArLS0NCj4gaW5jbHVk
ZS9saW51eC9zdW5ycGMvc3ZjLmggfCAgNSArKy0NCj4gbmV0L3N1bnJwYy9zdGF0cy5jICAgICAg
ICAgfCAgMiArLQ0KPiBuZXQvc3VucnBjL3N2Yy5jICAgICAgICAgICB8IDM5ICsrKysrKysrKysr
KystLS0tLS0tLQ0KPiAxNyBmaWxlcyBjaGFuZ2VkLCAxMjYgaW5zZXJ0aW9ucygrKSwgMTYzIGRl
bGV0aW9ucygtKQ0KPiANCj4gLS0gDQo+IDIuNDMuMA0KPiANCg0KLS0NCkNodWNrIExldmVyDQoN
Cg0K

