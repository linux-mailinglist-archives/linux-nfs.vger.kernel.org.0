Return-Path: <linux-nfs+bounces-9472-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C164DA194F9
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Jan 2025 16:20:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E1781881346
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Jan 2025 15:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BB002135B9;
	Wed, 22 Jan 2025 15:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="EGQNZCuw";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="kvW9g1hf"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D1D3212FB0;
	Wed, 22 Jan 2025 15:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737559217; cv=fail; b=qAb3RlJAwUh+hrIV6jHwfzq0roLfML98/xdZIMI6A6c3picVY+pDt06hAjKppA0agUqvtHW2LkqlRxOL7oREBKA/seFdJP9APzCaJ0XU1aY9H8aJ8P09lSEtDyk4EkrN5lQDDQNeMirMhmHx1MNfUdNm6CLiqcXMqML+CTpa5ts=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737559217; c=relaxed/simple;
	bh=mKK36itDOLwSTxSzKCTrNhAli3pRMOZV/4SsGgjpYIk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jeSN0pIgBH9pakVLjShPz+RelsspGDkwp8CnrcjZa355jFsKNQGgn59jwKbAszs22MbSqBF/aJHNhHcJh/eFDP2ePkVoOUcqbklxF9uUSEswFVCYNm2NhCYlcwMz7KYMwnDnng+FywkBPOxvFwOKSkm0lwLHtCU+URxxVk2vHeI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=EGQNZCuw; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=kvW9g1hf; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50MEXkDt023220;
	Wed, 22 Jan 2025 15:20:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=VntljHoCoc762uQ9oXKJKae8RY9DI43Qz1o2cAkDFUA=; b=
	EGQNZCuwTfunWLCfbEecOqu4yGPAbew7l6CcjZ/38eco+Cx14SDnL9Gd+WrPdFxd
	nj+7SmT52QTXDQrJ756njq4Gh41EVMqrCQQ4o4sRlfKQOlJiaWfp5VxEL5YFQHfI
	Ig0ncCXoK6DnvMN2jXpKtmoFBRqRyUVZdRF71EsxWQ6yKdKy0UhTfLAVIKPpVbeu
	wsVcJPPDMlXBT8nolgBE7ySKiVsBSsHO2K30pM1qKOGJbbulbspYTGnJUGu/Euqm
	nB4r5MFpe3Rpd3LYA8dT8M64InEPK/+Ygsar18uxHMpgIei53EZ6SpLgUsbjkFI5
	u+FJtyhv+hTPYDSuTRhatQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4485rdfyu9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 Jan 2025 15:20:06 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 50MEMpZs004793;
	Wed, 22 Jan 2025 15:20:05 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2047.outbound.protection.outlook.com [104.47.58.47])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 449195redm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 Jan 2025 15:20:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qoWigN+1mx29cLiTlNYHijt3pIUGJz99ZOI1TIqfkArFWfXR0GABLmdlHTGEHAPsk35RMIwsU4c/jka6qNglWKSMT8tE+RvjZxEwFIFWf53+DKr+2DG4D4RqN+8PNKDqvOUYqMhRbahR/9wKP3Df2o6JOmAlsh6hSqdNrJ9BmzX/5eyEfyJFk+YqUu3+alHFW3AIOex/R2mBRcfaoewatyXWM4cDho6wqA9plRJwQXPRhfUxDLkNaV/NohL9B6ZkjBL5Kr/kNCWSsoAdsVUR+dUQQcGMURfkHlYm2XRLJB2RS/OJq8Rc/4DRICbfX/MeXisuTiSyrWtG4OAgziEnjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VntljHoCoc762uQ9oXKJKae8RY9DI43Qz1o2cAkDFUA=;
 b=C2MRzKwsOhahNVcnJCiLC15820DsTOWg6LGGjP9USST3eWzl2FqrTGZnblmOzD55LWBAo2niOaV3t6GDt7yhQQtz25RpULthaBOLgkSQwHy9ZoWl18QhRAqu6wH5/aPIxw5YDKPDgT4+GenqgKpFr3JrFjlHKkXlA95+vWCIoTy60jP3e9cPNrqdHECHUEUWu0ekrLgt8J3uUIIHX6lruXZK0qOz09zRxvN+p1fwrNDj7H6RqmoUpF+oujFIpmKCbWsgU2qi1njjP0ECeao5+X0DD2SdmHTuyNNkuUG3MQlCuTM6vYD+EFBkd3jUWLKsA61uf+ZaXQZ3eT2mE2vpLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VntljHoCoc762uQ9oXKJKae8RY9DI43Qz1o2cAkDFUA=;
 b=kvW9g1hfW6sgS4L0EalVKlZc8OC2XtPtI31TIsHEOUCT2TupfyHWxiQjggYNC/5ngoF+UPvRRHT6LwHI3KGm3nHgTfIrQY5stLcOErMs3vuVqCrS+rdjGzSRoKBYGc6cGfUEHPjqXMnyjCfhawzwJDq050RfwGOU0PSK8KzTuC8=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CYYPR10MB7627.namprd10.prod.outlook.com (2603:10b6:930:be::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.21; Wed, 22 Jan
 2025 15:20:03 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%3]) with mapi id 15.20.8356.020; Wed, 22 Jan 2025
 15:20:03 +0000
Message-ID: <e85a0515-7972-4428-9270-a982073adcb4@oracle.com>
Date: Wed, 22 Jan 2025 10:20:02 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nfsd: always handle RPC_SIGNALLED earlier in
 nfsd4_cb_sequence_done()
To: Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>,
        Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250122-nfsd-6-14-v1-1-6e1fb49ac545@kernel.org>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20250122-nfsd-6-14-v1-1-6e1fb49ac545@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR03CA0029.namprd03.prod.outlook.com
 (2603:10b6:610:59::39) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CYYPR10MB7627:EE_
X-MS-Office365-Filtering-Correlation-Id: 65c2a9df-67ac-40a9-2b86-08dd3af83ed4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L0FRbjdLTXJROXB6MzdIZWhzVmlmVGtsaHhaczRQOW1ac3JVcmtoWWN1ZWhp?=
 =?utf-8?B?Q0NjMm1iTFBvb0dadW5rbnNWQWpPaG1UaXlCVzVKUDV0VDhvc1E1alhsaVJn?=
 =?utf-8?B?eWtCWTNtM01SdHY0ZFVzc0traWhoV202d0N6SlkrUFFpV2xWMUdEUHp4NHRw?=
 =?utf-8?B?dU1RcmJYcVdocStybEhFRzIrMDBFUWVTaXYxUmt5dVdnK1laZ3VNRkIrM25L?=
 =?utf-8?B?bVZia2VSazFrODdqTlo4RlpHRW1rZ2pBa3JQQ0NhbFFwUjF1RUorZnk0eExr?=
 =?utf-8?B?WnBuNDRGYk9TZ2RkWUszYzVCc3FEMHBBa0lpeTV6cVBUUWtqdGJNeEdUTEdz?=
 =?utf-8?B?REFKV3RqMkZTNllMMUJ0cG9QUkYvbnpRSHZKb2lCZzdhdUtZYUptQVI1QVd2?=
 =?utf-8?B?bWpvVGpwNWF3cUdzQzBWeVZCRXhUUWdpYS9vQ2NOVldDWi95czlsWHdXOStP?=
 =?utf-8?B?TmRsMnJoODdFczYxbXdiVFM1bmJkUDUvVk9QWjlLMGdobDdFZUVFSkdrRVd5?=
 =?utf-8?B?U3FmY0oxTVJYc0FLbkYrZyt0cEJPN3FYa0lyUHRKQnhYV01UVlFBbXRnVmhY?=
 =?utf-8?B?blRoZXdVaXQ3MnJra3prQXo4QmVwSHg1Z2JUN0tSOVVnVlhpNWJ4MklqY3V4?=
 =?utf-8?B?bVRRM3RiZjFLbXltZDVzcndFcitvck1vaDRDOXN2V2RrM1hNR2ZldjFqUHli?=
 =?utf-8?B?M3FPbk1sNGt2L0dtbWV2K2ZsYkw3cjdsRDlYUFRrbHlNUW1ZMHc3bEY4c2N3?=
 =?utf-8?B?U0ZMSlhIUGNOYU1oNElYUnZmNkora042SklRd014K2JBaXp5NzE2cWtkY2hk?=
 =?utf-8?B?d25CQ0F0bE11eXAybUNadDA3T0dDZ0lpczdndHB6b2MxOFRnc0FxMUNOSFJx?=
 =?utf-8?B?QnFlMDJYcVRkRGJrK3VtM0hXRjJGOVdTRDlZUXlHcm5pRFVFVVJEZGVFTnYz?=
 =?utf-8?B?aEZ5QmcxV294bEJSYkdEa1ArOURKSU1rdnZaQlFpOUw5TnFrT0xteVd2K3RU?=
 =?utf-8?B?VGhJWnhoWkFFRG5pYkQrM2piT3FoekNjcldaM09Pcy9WaDNTNnFqZ1AwWHdH?=
 =?utf-8?B?U3YvZ3dpNWU2SVRjdUlydzQ3MGdBMkpCWWx4V1p4Z21LeFBlWFIrditMM1Nj?=
 =?utf-8?B?dHFKSmp0Wm9VbFVobGQzUjVvbnA3dVUwdkd2V2lGcG40ZnpLdlZGcGFwMGtk?=
 =?utf-8?B?cFM4V2JGdFpmTTdDa2dVdnJMTEIvMDJVd2pWd0hGNlBXMmZIc2QwZjRhaWg2?=
 =?utf-8?B?Ujk2RXZ3eDZ2TEVpUkhRNUxBN3UzbjBURTJWVkU5aWNCM0h4YWx0MVVneW9H?=
 =?utf-8?B?cy9TWUZuNE5OMWJCZ0NvdjBGTXA3U1hDYVBLM2FUdE9TeGwrS09Md0hkZnU3?=
 =?utf-8?B?Y3V3dWZUNEg5T2JqMWszdEtqY0xyQkdQVWk5NXZxZHdNYWRuWm5hR1Z1Qk1T?=
 =?utf-8?B?UFpzTUc5SzJpSy9vSktwSVVMTk5RQUovbDJRRUd3dDZVSm1oQTNZZHJQR3ht?=
 =?utf-8?B?K3VldGtxOEt5SFhrbUxYb3RqSWdDQ0dkeHhJaEd4KzBsQ1N3TzhLSENPZ0g3?=
 =?utf-8?B?SlJLei8yU2pCdWIwQi9JL0RxQlJ4SGJTQ1plTTNjUktZYUdBYW80amx0bGpn?=
 =?utf-8?B?eEtrYUphaWRHZW90T0dOYndyeFI4UnpPMXJpUEhYbWp6REFiOVVEREhXZ1gx?=
 =?utf-8?B?SzNSaFpqUitpTkJHTHdHY2t1K29QdDBqdEo0ZTViVHdHRTdIUzNnMGhEZVQv?=
 =?utf-8?B?bVpIcVFwbVNRVHBJb2JXSTdKcURLS3dRRllHaTFzbkw5MzNZZnRmSnVMOHlu?=
 =?utf-8?B?RXFvSlNOYm1pYjdNekxQbnFWa2N1YnU2eVAxb2hkdEJjOHc2V2NWamJpNWJu?=
 =?utf-8?Q?9QoPQFzwj2K+g?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NTRwNmJjUzgwMStQY3VXalVqYzdGSGxueXRncmtqQ3RFMThoZ1ZHTm44YStR?=
 =?utf-8?B?bHBybkY0dU5hZE1Jb3ZNSWJ6MlYvanJTSGd0MFJ4Q2pIOVlqTTVrb2MxRmFN?=
 =?utf-8?B?ZURQdnpnaWR4NjNqRFM3L3Y3UUJ0SHBabFVCRkRTcTlZaU81MUFJb1lPaTJu?=
 =?utf-8?B?RWkycnJIdjFKbjdqUS9MNmxpd0hYMXVOcjd0alp5N3Brbzl5MC9kMnppVEpJ?=
 =?utf-8?B?cE10SzNMVElWTG51YkpQV0lpMDNhb3JCOVFaZHdZWmoyUHdJVi9BanRBOUJh?=
 =?utf-8?B?U0l1OGQ2SXRud0g3M285SkplZ0wxdHV5V3h4ZFM5eFg3UDdJenp1aXd2aGpE?=
 =?utf-8?B?S0JVaWlDeDBTd2hYc3RTUUxucFQ2R2l4R2RtSlBWbjc2Qk1SemQ5OHNzOTRw?=
 =?utf-8?B?bCt0UHhWV2xNR0I0dGtjOGp1Q1FUR245dkczbEt6LzN2N1EvMklMcmtHc2J5?=
 =?utf-8?B?djZmUmk2cjhyK2g2dndVTGM0Uk1XRlg4SnpQTjloV0lRZ1liK2taRE5iNGZq?=
 =?utf-8?B?amNmNVpWVi9MczJCSGg3ZHM1c1dubkZ3WGhIZjE5UVU2U2RvWFpraXpOUjlK?=
 =?utf-8?B?SENZUVo2RzBwSnc0bTdzTnY4QWl3TkMwWlh0eWtqT01BVXBicWRmeGhWTEo5?=
 =?utf-8?B?clZMUzJ3bzR6Zis4RU1GRmJHaEJhT2JFUnR3djR0NnAyTC96bFo3bGoreHJy?=
 =?utf-8?B?SktvN2EyVXZ1M1FsYzRCVEx0dVVmRFRzSm95ZWhhM3QvTFhDU1dtaVU5VmZr?=
 =?utf-8?B?bUlnbU5MdGNVSWV5dHYxYXJvRkJRMVlQTEhaZVlmdEFoQXNYbXd5SUQwUGNx?=
 =?utf-8?B?NHJGUHY2RENSUG13T3RYeEEvR2t2UXIrNEVuMFM0MXc0WHNramlicWRURzB5?=
 =?utf-8?B?TGRycENxamloYjZieTNFajVyWlN1MXN0cWdLZTR6aFlqeXYxUHdnNi9RdTlI?=
 =?utf-8?B?MVNHNVlHQklhRDI0MFllM1IxMlRpRWxTOGRlRWJWdGg0Q3o2VE44TFFWNTVN?=
 =?utf-8?B?UTJNZ0ZwZ0V3NTI0c3BGeDRUWGdJMWpOQlJKVkcrNHNqV1pMWENTZHpPdnhn?=
 =?utf-8?B?WG1kQkh6UjhjM0UyY1ZJS0VHcHhWZE9qS2tyaVZaYnRrUWRCOUVqaUc4elc0?=
 =?utf-8?B?NW5lcXRjYkRGbEUvT2h2MWU4WjgwNmg5cVZUU3AzaS9aaldLWDlXQ2d3aFlY?=
 =?utf-8?B?NGFVaDhBeW1UV2F5d3JHT1pUZjg2cWVYelVXNEkzbG5BcW45MTVWampCRkIr?=
 =?utf-8?B?bms2NXpFN3ZZTFBiYUdaRU52UXlEL2ozMWxTVldZU1FjRmErOTI4UkNURVNG?=
 =?utf-8?B?cEVFM01HY2MrZEJTdTc5VnlkT1cxS1RhQzNNdnM0QlI1bVlobEhVYVh2Uzg0?=
 =?utf-8?B?cUlJSzJESXYvL1VDMFJJVmtUTGxOYTViRHpsTkFXMG1mWG9QOEFhZTdpcldt?=
 =?utf-8?B?YXBoNCtORlMvcUhoMGJCYWtGV3pJcm1iVjU4eGg2RGNzdGh0QjcrOVdxZGFK?=
 =?utf-8?B?M1hNMzZyUnp1R1BEUUpVUFpQbnJtTURuWGhsQWx6cTNRM1pFdXRsZjJCZzVP?=
 =?utf-8?B?NktkSm9Fem5VbU9Pbks5QUwxWHFoWTZEcmRVVTc0ZHI3M3pINENsdVdNelMy?=
 =?utf-8?B?TGNGQW9Zam9yVlA0bC9yYzZiakViTTJTcG1pWFpPa1RoQzlPRWlZMm15NUVX?=
 =?utf-8?B?ejllRU1iNklWSFM2NmdkNEcwbklONS80eGVVYUYraGltR1lTaGdzMHFRN1pK?=
 =?utf-8?B?aVF1WlMwblVqaE12MEgvbEY3dXlKazhrVGlXTHFCWlI4dnBRSmNZNTE0QW5D?=
 =?utf-8?B?NGdvZjg5cTRmYWltVm5TZHdUdlBaWDJEcWFHQ1ZreFNCZU9INnZvcVo1MWEy?=
 =?utf-8?B?NXd3Qk9SeTFTQXlWdFFzeTkva2M4WDduS2xxdzczcWYxQlhVbCtQbmVHL1VM?=
 =?utf-8?B?MG51UGNNeDlweENSZkRHZXVrTlYwdlBsYUh5Tk8vYXVpQ3UvMmo1VElpVHFz?=
 =?utf-8?B?MVJNcWhMZjFIb3M2T2ljcnNDWEtoMHd0d0FCSEFBTmdHMEZYc0pYMGhNNVdD?=
 =?utf-8?B?KzBRVk55QURpNTdjK09MNXBRVmtmamRCQlJmMDMyZkhMRnU0UjN5d1NINC9C?=
 =?utf-8?B?b2U0MUVGODhYY0FlcnFBVlIrMFlUT0VDZFh0dVhhMEIvekVNcU1XcHMzY1Mr?=
 =?utf-8?B?VGc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	is/0bVZi5q69SLQYD1gw9Pugef7d24WZnytYVBPNtFgkYpJvY01bITxYkBrO9YlgFNWy8b036VpbVTPbV7TQVJqRvxEraynM0V3JwhBlC7Jp4b5oF9OqLg6xdgVG1EcjyxDQPAs+7aTSwzgwvAxq35+i005L82dZ3mtexVHXwypFa9sGTUs9AUeA+HHrpFS2D/Ovq4EelFU0W5muO7kVy6qPSWsN7+3lKwzlJIPd6aCHSqsgilBXRCMnSOoRpdwl2JSLkcDbsWQQjijWlO4GvAK+JZ6HdHnJAxbtEKfcU7v7Bi29mpaY8Iz3JUQtyVHXfDf3blZ0MyNMFbiPkXt7IaPoaT+TWdv9r6aJN0om1abRPjyyIArIiEW7JvuJWRvOsgg5l37ip91p6JDEQWOWRMkZ912C0SLJ8TX7WNZvY8H7NUE7GHWSKUV73af71tz2DaWstyX8j+z8ihHYbXDoj4KVYsVJiGE2ekZRGE8iISM1jMJ1w0fqM0pBKmOCvn+G4yZNHUGHPsNrYKLL2VCTaqQ+e1tm8Ajm72z+RK/j0m6XJXV7BL9Rc2t3YwP9Z4QMQjavEE7MaVMjcTxLGd7Vduz29R//oAbUNrWp8JF0l3M=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65c2a9df-67ac-40a9-2b86-08dd3af83ed4
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2025 15:20:03.8386
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: buu/5VgIWZ94MD+tRTC/gpf93dSSZNbwIOf/OsdWsOZO7sqid5EaurkmcjztaVWjCjIUmR6J7KkzJVgmn+NiqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR10MB7627
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-22_06,2025-01-22_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 bulkscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501220113
X-Proofpoint-ORIG-GUID: V3dOtnQOSjgnxYqWddBMKbNLYQBwpIKk
X-Proofpoint-GUID: V3dOtnQOSjgnxYqWddBMKbNLYQBwpIKk

On 1/22/25 10:10 AM, Jeff Layton wrote:
> The v4.0 client always restarts the callback when the connection is shut
> down (which is indicated by RPC_SIGNALLED()). The RPC is then requeued
> and the result eventually should complete (or be aborted).
> 
> The v4.1 code instead processes the result and only later decides to
> restart the call. Even more problematic is the fact that it releases the
> slot beforehand. The restarted call may get a new slot, which would
> could break DRC handling.

"break DRC handling" -- I'd like to understand this.

NFSD always sets cachethis to false in CB_SEQUENCE, so there is no DRC
for these operations. The only thing the client saves is the slot
sequence number IIUC.

Is retrying an uncached operation via a different slot a problem?


> Change nfsd4_cb_sequence_done() such that RPC_SIGNALLED() is handled the
> same way irrespective of the minorversion. Check it early, before
> processing the CB_SEQUENCE result, and immediately restart the call.

It would be lovely to have some test cases that exercise the server's
backchannel retry logic.


> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>   fs/nfsd/nfs4callback.c | 32 ++++++++++++++++----------------
>   1 file changed, 16 insertions(+), 16 deletions(-)
> 
> diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
> index 50e468bdb8d4838b5217346dcc2bd0fec1765c1a..05afdf94c6478c7d698b059fa33dd9e7af49b91e 100644
> --- a/fs/nfsd/nfs4callback.c
> +++ b/fs/nfsd/nfs4callback.c
> @@ -1334,21 +1334,24 @@ static bool nfsd4_cb_sequence_done(struct rpc_task *task, struct nfsd4_callback
>   	struct nfsd4_session *session = clp->cl_cb_session;
>   	bool ret = true;
>   
> -	if (!clp->cl_minorversion) {
> -		/*
> -		 * If the backchannel connection was shut down while this
> -		 * task was queued, we need to resubmit it after setting up
> -		 * a new backchannel connection.
> -		 *
> -		 * Note that if we lost our callback connection permanently
> -		 * the submission code will error out, so we don't need to
> -		 * handle that case here.
> -		 */
> -		if (RPC_SIGNALLED(task))
> -			goto need_restart;
> +	/*
> +	 * If the backchannel connection was shut down while this
> +	 * task was queued, resubmit it after setting up a new backchannel
> +	 * connection.
> +	 *
> +	 * If the backchannel connection is permanently lost, the submission
> +	 * code will error out, so there is no need to handle that case here.
> +	 *
> +	 * For the v4.1+ case, do this without releasing the slot or doing
> +	 * any further processing. It's possible that the restarted call will
> +	 * be a retransmission of an earlier call to the server and that will
> +	 * help ensure that the DRC works correctly.
> +	 */
> +	if (RPC_SIGNALLED(task))
> +		goto need_restart;
>   
> +	if (!clp->cl_minorversion)
>   		return true;
> -	}
>   
>   	if (cb->cb_held_slot < 0)
>   		goto need_restart;
> @@ -1403,9 +1406,6 @@ static bool nfsd4_cb_sequence_done(struct rpc_task *task, struct nfsd4_callback
>   	}
>   	trace_nfsd_cb_free_slot(task, cb);
>   	nfsd41_cb_release_slot(cb);
> -
> -	if (RPC_SIGNALLED(task))
> -		goto need_restart;
>   out:
>   	return ret;
>   retry_nowait:
> 
> ---
> base-commit: a8acd0de47f22619d62d548b86bcfc9a4de2b2c6
> change-id: 20250122-nfsd-6-14-77c1ad5d9f01
> 
> Best regards,


-- 
Chuck Lever

