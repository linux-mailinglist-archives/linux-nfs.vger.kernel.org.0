Return-Path: <linux-nfs+bounces-12900-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A620FAF9663
	for <lists+linux-nfs@lfdr.de>; Fri,  4 Jul 2025 17:11:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 553397B9FFD
	for <lists+linux-nfs@lfdr.de>; Fri,  4 Jul 2025 15:10:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0049419C54B;
	Fri,  4 Jul 2025 15:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Xr+BJCV6";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="zvtMIASO"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF8041BD9C9
	for <linux-nfs@vger.kernel.org>; Fri,  4 Jul 2025 15:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751641865; cv=fail; b=HxvKuBprrZObmiW/VnwW9imHZg39lJwQbrnxeg4A0ThR0Aac0hOE/Hk0LukQnYyumfsMRthirj51nwW2GgNHfE1rxvUMIyXFJvnYLTU8vAA920XB0ZKKlNKirhez7H+uyH9cQSrv4SOVdZruXesvMi24nWzTlMk6xom+TSfcTuo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751641865; c=relaxed/simple;
	bh=YpfvRJVccYzg+AXrYuEloyEj9njbE3OT3T9Q/DGQdMk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=km1KMLhf1xntPY9bCyLGsjkTPXy7qBp4+RREh29veXQ5yFgoJoGlwtCB1Xutzb6dTiEgSnrg/1ZDrmzmZCnu+drTX66wjp87dW2JwgDHfuamukd+2C1ShoSF/2p6ALNe5+yrHH7J1I7Dji7ruj6JtfgCPc3pB7Jz4axvnc6OW9k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Xr+BJCV6; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=zvtMIASO; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5649Yuc2032640;
	Fri, 4 Jul 2025 15:10:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=mlF5aakPDzqTdPM1fWg3MMpWcVFB0ExlkZD0cuMYLnE=; b=
	Xr+BJCV61aHJw58vgMhHXWmn0xECDdd01OkEGzD2n3akEcbkoylrIs40nYTAPkio
	ldQdkgGNnh1hK3mVuLf4nxrSmbP8vITSuC2oXN3T6W+hVxwnQXXWlz2HQIu+zKmn
	lllbfqcCwssZB75DEkAmZW40aCRlQYwFBsJSE8VWwBq/bTNZo5WqKsHPD+5DTQfU
	LSXZqki9B8g/JNC2f4k+NC1LmTibw1QboZt+AsRY7+PIaeeQ13TOOSjj9T110M/M
	db802kT8VT4YUjHFKbSN+D4qGANV1jzgIUBX6RiMKIAbHvif/BwTinCdnTRx/mde
	iOP/9GVR70pECbvySIJyjg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47j7afaxsg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 04 Jul 2025 15:10:42 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 564EMOYK023941;
	Fri, 4 Jul 2025 15:10:41 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02on2083.outbound.protection.outlook.com [40.107.212.83])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47jy1jqjmh-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 04 Jul 2025 15:10:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JYwDhXL6uzNPuWpEvsWr4x92p3hi6RRNB5KVJ6ZEx3NGLQ2kOVFh18RoK/hHih6PGkwtWPs5aYrRxB0uQYW6pYQowFNHQ4fRuV6ngapt9haty47noq5PsksubvogkwJEGW1AZ9+J5fflXyycmK6Dqb9osDPwsDwGNi+9Vp97UBWT0eK1Wc3X+8ke3fYot+37rHg1/adNfixdl0oR/KrsT8RrTg4/0s1OfsKdtBu//T3BtSZVublizDB7cusqY+Ru5LToa0hBK/Dvw9FHRdGhm6podpP23xJ+LUz6MTWm5v2bsCOfUP3YDfA1noaZfoytPn92gbziPI/AyGCT/ykmwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mlF5aakPDzqTdPM1fWg3MMpWcVFB0ExlkZD0cuMYLnE=;
 b=LPhOwqvlUo2a+7hbUcqMsfz70HyDr9Yl0M+TKu4/Kq9xkMxXcvtFKFqKls+653DGGESf8IntqnR/LYPHTVTyUgRYleE5+hAm1uJkCxYaarzLiMYVZfFA0LPohsKO7FH7Da7JrYlwfOStIRfR3XP0R1VteMeUf8SAAVeO1Qojep/QampIMN+LfntJ/vMtwVir7iVsz69Jq1xiia/J/Fwvl2HKROPv6j8IPgU71NULA94v76Yp5VN/gTRZHKfzOjeoB9wmLtSj/Ks/MAvHAnYTxuzocDHfmJWSbOdwPsj7ryymkCr7hOj+114dlOkp7Jv1iznZi7qQ804HGAGjsjuIqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mlF5aakPDzqTdPM1fWg3MMpWcVFB0ExlkZD0cuMYLnE=;
 b=zvtMIASO5wNzaJdaA/i9xkdgYmGk8JAKIBJXpgJ1dr9l4nKI11QpxStTt566K9p6sm3lCtTaw/ptg4Biq0FmFN1HIbrQ+ccidO2w/gNPU2rxqIECigYzDPhvo4Hl7C0u2A5kYI14UZLpb5luwp4/tqWq2XcMU2MHGdxsIcasJmM=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SN4PR10MB5541.namprd10.prod.outlook.com (2603:10b6:806:20e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.18; Fri, 4 Jul
 2025 15:10:38 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.8901.021; Fri, 4 Jul 2025
 15:10:37 +0000
Message-ID: <d789346f-4232-464b-867e-f176606b5f02@oracle.com>
Date: Fri, 4 Jul 2025 11:10:35 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] nfsd: discard client_tracking_active and instead
 disable laundromat_work
To: NeilBrown <neil@brown.name>, Li Lingfeng <lilingfeng3@huawei.com>
Cc: linux-nfs@vger.kernel.org, Olga Kornievskaia <okorniev@redhat.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        Jeff Layton <jlayton@kernel.org>
References: <20250704072332.3278129-1-neil@brown.name>
 <20250704072332.3278129-3-neil@brown.name>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20250704072332.3278129-3-neil@brown.name>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0054.namprd03.prod.outlook.com
 (2603:10b6:610:b3::29) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SN4PR10MB5541:EE_
X-MS-Office365-Filtering-Correlation-Id: f9830afa-d026-410d-06e3-08ddbb0ceec1
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?SWVmNU9STjNvSWgrZ3k0SFZMa2Z5S0hqVEVJTTl4WFZZUDN5NkFjRFAwWisr?=
 =?utf-8?B?N2VYTFUrN1JZZUlxMCtPN3JEWnE3MU5sZTIzOWtRZkNiTVZLbGhIWEVTNFVy?=
 =?utf-8?B?NzN2akx4YmxlZVA0ZWh6b2ZZY2RCNE5Hdk0yRGxmbTExazdDRnB0RWVZaE84?=
 =?utf-8?B?QmlwS3FNRU0wbXM2bHB5Y2pBQkd2dG05MW9oSE5BQ21YWDQvMlRSVzFhZlR3?=
 =?utf-8?B?NkNBbk9qeVUzTzNzaEVQQkpqVkl2d2J0RmFxVTQzWE11SWdYQ0g4d0YrenVV?=
 =?utf-8?B?WnJIaDVLSS81MHI2MTFHQnBVendiaGVpeXpMRk1QYlN5NldQMlpwTmk2YXRP?=
 =?utf-8?B?aFN3TEdNc3pJeVNZMWJONldZWURrblRla29oK0ZPNm1Ceks3MkxmTERsdVo4?=
 =?utf-8?B?dE44d3J1YWQ2YWQyeU8vYXVZeGRKaE9DbW5pc2dKTkxDd1FpTWdTVUV5WlRB?=
 =?utf-8?B?aDBJQVkwM05kUW5uYXRBTzh5aEkyZ0tQOFNWaGR3enFZdmdBcklMZlc5dE9F?=
 =?utf-8?B?NWdPZ2ZIaG9wY1hCTm5EOHh1MGJnWFZqNElFRFJDUUlpdTlnYnNYSG03R0ty?=
 =?utf-8?B?SU9IbzZHNDRFcjNqcEJldGhhTlFRd2xwMzQ4SS9LQUE2bHRZT05OUmlQUDlC?=
 =?utf-8?B?ZGlxR1BRSUEvcE11MlMyVjVXTWIySWtqSEZJV3VBQ1NqMFUxV1h1WkxmTGZX?=
 =?utf-8?B?YTNtaDlZRFRJTjVjdXlNS0hOcmhwWVNvV1gwekVteFBxSy9IWFI3ZGVyYnYy?=
 =?utf-8?B?MVhjeG5teXdQRWk3aVQ0NFJhb0ZlQ0ptNWhqWHExMTVqUDFoVzJ4MHY0em9k?=
 =?utf-8?B?YzdMaHZIaS9MenMrSjJHSkowZUdTcEJoTXVrRGRKeDVLOVl1c2pySTg2R2Y2?=
 =?utf-8?B?OHpuUnlidWIxS2FnWURjWkEwaVlucEdnUVhGMHgxOVJEMEpBQmM0MGVGbzl3?=
 =?utf-8?B?VW5aTTRUZTV4WVJkU0h0aHZpK2NyNUsxMUJwKzhpU2RMSW5BQ09vQk1RaTBJ?=
 =?utf-8?B?SThuN3lmUEtwUVFDdDB0MnR1T1dXSUJrT3JzN25ISFQzVHlZekI1cmJqZklV?=
 =?utf-8?B?dVRIS2t2eXJTdG9IUHhVdDEvVlVIMjdOM1ZEbnhWM1J1UFZFemxEUEQ2c0Zs?=
 =?utf-8?B?N1VPY2ZJdWhvKzVaeHkxUnVmeDVxV1IvQzd4UVNsMzk1cVhLYUVmYWhuT094?=
 =?utf-8?B?cXVMVDMxSkVEMXdnNXFTMG8wSWw5bElmRUxPSDB1aTRqaExaaSttOXpyZGZh?=
 =?utf-8?B?aUF5aWZnNk1FSDd1V1hmeEJGWFBnVzRkSmpMUDJRRUMyVC8yUElhWGRCN1lD?=
 =?utf-8?B?VXIrT3dVMmdWTUorSDJlYVorMHZpcm96Z2tEd1NCOHY4V2FkT1N1T3hqNkZF?=
 =?utf-8?B?NWZpUmlTdnA1NjhLRGtYdXE5V05iMzkxUXZWbFpFZlVTUFZMUEcvUVNzWUdt?=
 =?utf-8?B?OG10K3JWN1RhTlNjUzJBN2VERDE5aU1jY1pyQXdkTzM5MitjS3duRlRzWVI4?=
 =?utf-8?B?T09iWEN0VVdrdk5WR04yWHo0V3dyM2dZb2VCYTNzV3NDRzlhU3pEbXpQTkNG?=
 =?utf-8?B?M3doL1EzYUE3M0JSNTJVZ2xSdGRaaWl5bkJuN2dkbWtQQVI2QWY3cXA5WXM1?=
 =?utf-8?B?MmNFU1dkNDdGNzVRRmd0U0QxVjZVcmVTYW1zOFhxeGV4Ry9Ta0xsMVpaL1Bv?=
 =?utf-8?B?c1JMOUIwdzRDZW9taW95TDN3QkFCYXc4Y1o1ODZwZXd2bHFjRHdBM3l3djlu?=
 =?utf-8?B?bEpGVDNsVmJHVnF1VmpXNGhaTU1pZm1ydmRmdThEanNTSmIyUkhtR2cvUmkv?=
 =?utf-8?B?Y2puL0R1WEJIZGFwRk9nZnBnYTJYUlZDVmc1cFV0ZS9kVldGWWJOVE81ZzN0?=
 =?utf-8?B?aFBWOHA5WjU5RFdxb0JWK25IWXJFT1RUWVpETEg4QnJ4a0V0b3RyZHoxUGVo?=
 =?utf-8?Q?/BXW+P/9e7Q=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?ZWd4L214YUVVSHozejQvNTVPLzdrQVduNHR3OHRBelBsSlorVEpycTZyV090?=
 =?utf-8?B?ZUswUURQVDQ0L3JQeFVzUy9jNkt1dW9waW8xUENJZnltZmZGVnBVRjlINHQx?=
 =?utf-8?B?Wmw0aWZOYTBTWVQ4b0dUaXh2dHYzbldWbTd3ZGV4bkFHd05mRTdvRU0vc2Fm?=
 =?utf-8?B?blluTnFUWFd4UWlNc2RQSXJvZmo1WitDaW1Ua0dkMFlTUW5BNVAwelh2T3Jn?=
 =?utf-8?B?Z2xrNFk3TndyQ2kxWXQ3QXpCVW5Cam44L25sVVVoeWNjdXB5MUYrb3RHTGxr?=
 =?utf-8?B?OHV1aEV1T1ZkVWtkZEUxc3hQYjFqR1h5d05Vd1FPbFRtbWs3eHYyM1NtNFhR?=
 =?utf-8?B?RURUcDVwbUtCQklsRVpheWtpZU53QnUwaEJrby9SK2MyRzhSbGo1cEtYcUM2?=
 =?utf-8?B?ZzRUclR1bVBjdUN2eHh6eDhaRWVxTE1jN20vdUtNUEJDM0o5Q0dBakV2S1Zx?=
 =?utf-8?B?UHNsNGNoS2VQKzdTMndjVmRLZkh3aE91ZUtIRk9yLzE2TVlsSGFBK2dRN1hi?=
 =?utf-8?B?QzBhMEs2ZTZHVUorNWNGdkNOU0hRNlZaeC9haTFjYmxBZ0N4RVE0bGZSeXlm?=
 =?utf-8?B?cERTZVJMSm9sU2pFckJHM0pqWjdlTjhHRTRONUE5dHQ1SmJtQ0UwN0E1MzFZ?=
 =?utf-8?B?U0duRFdaSVRneVkvODFPV3pHNHBJd1NQeHpwa0FZZGVzSmU2WlU5TXRvZFVB?=
 =?utf-8?B?ajhMYlB4MEs5eDRaak12cEh6LzRwYlBrSmVqMHkwSnFPY2p4RGM4REh6dnk2?=
 =?utf-8?B?YlBabGszQm56ckVOemJYd0tYaWd5aVVNeEltWGt6ZkdxM2tKOGR3UzVwVVVl?=
 =?utf-8?B?UjgwUDQ2SlpZMklpQ2ZaS0s5dUNqSCtSdkRaVERDUzR0UWpNL1NhSjQwdnZn?=
 =?utf-8?B?aU4zYS9CUktQbGxTZ0dtM2VlMnNCWER4czg2ZVF0SnA3L2pndEhuZWhIbzdH?=
 =?utf-8?B?RlFMd04zaWJBbmNUYjAvU2tmdmVZeFpSbm5yZlk1Tm9WTDIyR20xZHhlOVRI?=
 =?utf-8?B?dVk3SVFiSmhJVjZWQlNTamIrOExCQ3FxakV4MGRPL2xPVmM5aDFOVk5COG1r?=
 =?utf-8?B?RlJ1YkNINnZtZDZvWWN0Y2MzNHp4U0hhMWYweHV6THVBWC9jckJBOVRpcytP?=
 =?utf-8?B?a3dQZFBrelo5Z1pTVEZSY08zSE9ia2RlUVFleUJPV25jMTUzaWE3TlJ4UU5W?=
 =?utf-8?B?NElKMTJna2FTNjNtUDZhMG51emV6ZWh2dmxlL0cvalA4WHZPQVBKdmVKaktp?=
 =?utf-8?B?SFNoMzJnRVB3aEQwVGhGZUNCYzdmZyt1d3NRY0lxb3J6V1o3ZCtYN2ZobEx1?=
 =?utf-8?B?T2p6dHBKNmlHV0ZWdFRiZlBzNG0yUm5UVm9tT0JxblRtOGtjVDBLZkVMdGNY?=
 =?utf-8?B?d0ZNczloTkJSVnd6SzNSdzFmWWVMZzlLSGNucldpWDBSUmhab0RmTmhhMGQ0?=
 =?utf-8?B?bnp5TmFGbW5tVThoQzh5RVVYU3pmODF6eDFrbFhxRFp4Y3hoYVNpLy90U0I4?=
 =?utf-8?B?SzJNd2Q4YWZPMmw5MHF4dEJHMHYzMXQvTmdPa0xDdDRQZ2N5OWthcWdtTVBp?=
 =?utf-8?B?NHpIclVKVHBMSFIyZDIwS0htOG95NkU1MUhxVkhWdXZROGc2UUZuR1NJSTdx?=
 =?utf-8?B?UUFoT2hLbHJxUmZ5MWViSUlITFQ5Ti9aRysweGgxaVRWRndHWm5oNzIwcS9h?=
 =?utf-8?B?RzNWQU5iS01wNHhNSXVueXhYcU1ZOEVjYnpSMHdibEwyRzNLNVFiZWFmTUNQ?=
 =?utf-8?B?ZW93NnJXNk56TjdjcDc4KzR3SmNENnh2aXNCVFkvOWczNjlLaFovaFhtdTNL?=
 =?utf-8?B?K1ZhVkJMOG12emdOYWZsdUQ5NTBsUHBtSTYvMnpheTV5YVgrdFBwNmUxak1a?=
 =?utf-8?B?T1BjWk9jdUJvS2J2cXhkN2JiMXdEc0daNXI4SERFdnZBcFNBUWJ3a21sRG0v?=
 =?utf-8?B?RURUU0h5NjIxM1F5THZJM3BPODJtQ3cwdFJ0bkViYlFiaXNVcTNZcDJCK1Fu?=
 =?utf-8?B?RmwrZ3hkbjA2K0h3OTFLS2RSZ0hFSFU0UnZ5TkZuVUdYOVowWDhFMEZiR24w?=
 =?utf-8?B?akZLenlrRHQySjlMMDdCWlIxR3hoeHFiNFZEWHljc0dMWlRRN285ekxNcnc0?=
 =?utf-8?Q?oBsU9cHNeRTlTxKCKtCDndhLi?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	sz5RSxuwZUVzZ/5gPZiRrqfLqb8cExMzusmcFiHlHkVTl+Iz87X8i5xPzZjiifDvJY1m9sxSEDhpquD2ridxV2M7HgWLBnkzS5Illo1grNfuWsZ/XUoBBtjECfCNoJe7L4qYuWVkidM5VEubJHZKcIgqKjNdORFEwQjwJmKm9lFh8YT0uIQoO6awrlcZd4bDMuZ4V0qJo8Tk2QMF1xErowt5jsm9Bg/Q4N/9Ta4nqnhLCfj6EnSc1+0MSwp4c+B1NDJWqwl3m2+my85GrpNg6iUD8hKSmhpSAdyuUH5Ic3YIlMqSX5DIm+z+6LXkhFaqLlZ0hz0tDPBvX9oYDED1Mf89MFVu+AwNm1BPQAe6pJyUhPSanL1S2SlJ4nM2abTA+CsAIbJD5vN+Zy7rSaTVDBWtyw9KNSGgxeS5MxsiEqNLIdKSpkoJ2fswBmdUuBjaSi7Kqu0bx4ihDLMdJI34fjA5ESMcBEmHIGnaZpa9mLdCohcop4+gcDpLf6EXDxvMQ96r8XNXFFsOK4PUOEnWfQRjPn9Mx6YJMz+XG0HwHhhcEk4AT3kji9hBz0uKyVTorcHuM3MH96Av9RKc89zoen32Q7CoHsvTM61XH3xF218=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9830afa-d026-410d-06e3-08ddbb0ceec1
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2025 15:10:37.8586
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4+dhhSJRaweN27JH4dVlRo1BDA8Jdl+mBZAmaxYRv1HD2MIrBxi/ntcXhjOo09zrGo9EVwZxNzDEeeJG8vUB9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR10MB5541
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-04_06,2025-07-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 malwarescore=0
 bulkscore=0 suspectscore=0 mlxlogscore=999 phishscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507040115
X-Proofpoint-ORIG-GUID: 97NiWYC7yluwXVFfsfCInzslu8bsReht
X-Proofpoint-GUID: 97NiWYC7yluwXVFfsfCInzslu8bsReht
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA0MDExNCBTYWx0ZWRfX+u37bjw5T3HQ r6PWAQtOl8hHERaORSa2ahrugO3tyI1u8aNYJRoq4vhze0/LWdHQcoD5xDQwC1guZSc4jXf3pO0 20nSF8i0PEcOMnCsnfkm0mr7bU2SNFFnUKtM4DBwbBD8t6aufOc+Zx/crFww1nXSeM8Vgf3B26L
 qjJj2A2hYI5BfKmvrEtklxyZTmnR58yD7M6BP8SKl7MNLcs1g1iobyTJNAk0gCeVzffNJHG0g/Q guQr4Ow2DLxiXiRh6JtYd7R4LN/pivMn6IeIwrKkd/RsMnAZf1k9BZb2F7bHfNucEDZCmDHZc/Z K1jnB3tGiDDM6sXGwmAM2188sMmAWlhWcznTEWQtQ54kxredEspvyErV2ExxUi5tZyJ4jwix/e0
 Ulf0f9ShoY7cIP/aWTgi5IYYbnhGENVxayYCUuhcqZwOAkhQws88fZ8UYmtBw74reG4RKNXZ
X-Authority-Analysis: v=2.4 cv=b5Cy4sGx c=1 sm=1 tr=0 ts=6867eef2 b=1 cx=c_pps a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=Ln_gdIdk0iQ8KoPi8CUA:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12058

On 7/4/25 3:20 AM, NeilBrown wrote:
> We currently set client_tracking_active precisely when it is safe for
> laundromat_work to be scheduled.  

Consider adding "Since v6.10, it is possible ..."

> It is possible to enable/disable
> laundromat_work, so we can do that instead of having a separate flag.
> 
> Doing this avoids overloading ->state_lock with a use that is only
> tangentially related to the other uses.

Please note here that this change is contained in a separate patch so
that the previous patch may be backported cleanly to LTS kernels.
Otherwise we have the situation where a patch adds a structure field
and the next patch immediately removes it, and that kind of churn
without explanation is generally to be avoided.

I would like to see a fresh "Tested-by" for the previous patch by
itself (any recent kernel) and then for 6.16 with both of these applied,
please?


> Signed-off-by: NeilBrown <neil@brown.name>
> ---
>  fs/nfsd/netns.h     |  1 -
>  fs/nfsd/nfs4state.c | 24 ++++++++++--------------
>  2 files changed, 10 insertions(+), 15 deletions(-)
> 
> diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
> index fe8338735e7c..d83c68872c4c 100644
> --- a/fs/nfsd/netns.h
> +++ b/fs/nfsd/netns.h
> @@ -67,7 +67,6 @@ struct nfsd_net {
>  	struct lock_manager nfsd4_manager;
>  	bool grace_ended;
>  	bool grace_end_forced;
> -	bool client_tracking_active;
>  	time64_t boot_time;
>  
>  	struct dentry *nfsd_client_dir;
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index 124fe4f669aa..db292ac473c6 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -6512,12 +6512,12 @@ nfsd4_force_end_grace(struct nfsd_net *nn)
>  {
>  	if (!nn->client_tracking_ops)
>  		return false;
> -	spin_lock(&nn->client_lock);
> -	if (nn->client_tracking_active) {
> -		nn->grace_end_forced = true;
> -		mod_delayed_work(laundry_wq, &nn->laundromat_work, 0);
> -	}
> -	spin_unlock(&nn->client_lock);
> +	/* laundromat_work must be initialised now, though it might be disabled */
> +	nn->grace_end_forced = true;
> +	/* This is a no-op after nfs4_state_shutdown_net() has called
> +	 * disable_delayed_work_sync()
> +	 */
> +	mod_delayed_work(laundry_wq, &nn->laundromat_work, 0);
>  	return true;
>  }
>  
> @@ -8840,7 +8840,6 @@ static int nfs4_state_create_net(struct net *net)
>  	nn->boot_time = ktime_get_real_seconds();
>  	nn->grace_ended = false;
>  	nn->grace_end_forced = false;
> -	nn->client_tracking_active = false;
>  	nn->nfsd4_manager.block_opens = true;
>  	INIT_LIST_HEAD(&nn->nfsd4_manager.list);
>  	INIT_LIST_HEAD(&nn->client_lru);
> @@ -8855,6 +8854,8 @@ static int nfs4_state_create_net(struct net *net)
>  	INIT_LIST_HEAD(&nn->blocked_locks_lru);
>  
>  	INIT_DELAYED_WORK(&nn->laundromat_work, laundromat_main);
> +	/* Make sure his cannot run until client tracking is initialised */
> +	disable_delayed_work(&nn->laundromat_work);
>  	INIT_WORK(&nn->nfsd_shrinker_work, nfsd4_state_shrinker_worker);
>  	get_net(net);
>  
> @@ -8922,9 +8923,7 @@ nfs4_state_start_net(struct net *net)
>  	locks_start_grace(net, &nn->nfsd4_manager);
>  	nfsd4_client_tracking_init(net);
>  	/* safe for laundromat to run now */
> -	spin_lock(&nn->client_lock);
> -	nn->client_tracking_active = true;
> -	spin_unlock(&nn->client_lock);
> +	enable_delayed_work(&nn->laundromat_work);
>  	if (nn->track_reclaim_completes && nn->reclaim_str_hashtbl_size == 0)
>  		goto skip_grace;
>  	printk(KERN_INFO "NFSD: starting %lld-second grace period (net %x)\n",
> @@ -8973,10 +8972,7 @@ nfs4_state_shutdown_net(struct net *net)
>  
>  	shrinker_free(nn->nfsd_client_shrinker);
>  	cancel_work_sync(&nn->nfsd_shrinker_work);
> -	spin_lock(&nn->client_lock);
> -	nn->client_tracking_active = false;
> -	spin_unlock(&nn->client_lock);
> -	cancel_delayed_work_sync(&nn->laundromat_work);
> +	disable_delayed_work_sync(&nn->laundromat_work);
>  	locks_end_grace(&nn->nfsd4_manager);
>  
>  	INIT_LIST_HEAD(&reaplist);


-- 
Chuck Lever

