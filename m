Return-Path: <linux-nfs+bounces-9604-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 834A4A1C44F
	for <lists+linux-nfs@lfdr.de>; Sat, 25 Jan 2025 17:25:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C5741883E6B
	for <lists+linux-nfs@lfdr.de>; Sat, 25 Jan 2025 16:25:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C71B035956;
	Sat, 25 Jan 2025 16:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="C9QTGcUv";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="LaAmuR2m"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5EB31372;
	Sat, 25 Jan 2025 16:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737822320; cv=fail; b=c1+5PF/GKstW2abaoonRSmS9J+BiKqXey4FY1qdFyg7WEtr9tj32t63WwFsIRz9xrhJm2RJJ/oZ863QONBQsofbcqMLnM1UiCnXmSr7dHDe1JBF3N3/qmEXUGyCLFFWogjTXBnY0p5mjnQFv91ZgkHrHvBuyTGgkuOOaRVRBG80=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737822320; c=relaxed/simple;
	bh=kekdjzjwj7FDuv4laK41fksGFDEKG8wUADO+85GM+sE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FpDMXHgNmCaaNn2JGB963mnmM8bKzAdd0tg9XnxA42a4TMiPJZdrMONB2f040id9ZHTxvTzcSbKrmRonWr+sK6/Ug4+A8evNhStgfga37BY3Fm3jc64LPqJUqo+iCRBJ/t0yn8lYX7ZP3okHOc1pc39yQXPOqEJPUMg+iAN94+8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=C9QTGcUv; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=LaAmuR2m; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50PEfg5W001951;
	Sat, 25 Jan 2025 16:25:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=xOYjyEd0ixHlHEi4Tq9d5p3v75Su3MewMhlISnNg1co=; b=
	C9QTGcUvn65wQFhcES89TYwA6I4uHAlZhRaKGBpfVs4t6leweGrcI+2xg8XXm84o
	6vPGip11xECwTrZPQRRKAMfQ6rq8BeN5IU0KDUTojaf8Hm/OP8tB0RJnnBRZVT1O
	ARWJvuc9hFL0vgs0wlQKVCvhGdNKlBq9Z7U5lxwcwWLuW6Wbhq26F0oNsG4Vog1A
	qnmm9IzQQe3mWBl3DWTiEZXSn/i4vJ1QwRyTcWLE2DdTFf5u+iOF09eyCbtSVLB4
	9m4Oi4mD+/PxI2MfXU/BRhZzoGERcEzliMgqy6ApNY4/BKfwd6Jd5FtXXLOJuZhH
	rtbLm2ta+Al6utMfOmOioA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44cpcc0dkh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 25 Jan 2025 16:25:03 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 50PD12Bw005539;
	Sat, 25 Jan 2025 16:25:03 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44cpd5kwc0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 25 Jan 2025 16:25:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RaIn908mzaui7EqnqW4XSTvn04oPVqMTD8tjcDG0HK3HdDPwZua5fyUK4wqQGVm5MQPLmEOJdEhcwJwwXnTJuMSBBWK9vyuAFFLcq4OFa671O04tEU1Q+fki+mbkXPNr5l8gUI5nti62l96HdOoEwtaiVuLyByw3bQNjee35BNylBmrjcFvl4vAR1LuZPoDMtWAu4OgXg2jO0W0CynHqlfVoc5LObDgV5Ood5N1okxeSFQg2l48G1fzFW7xSE1al1SFI80QbJxvhMMdKH7F5cHM8VwVjY3uP2mxRFZ57aqHyJLSNi3OY+uNmPRNgEZPzlynQ1XbEVG+N82aMwoxlDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xOYjyEd0ixHlHEi4Tq9d5p3v75Su3MewMhlISnNg1co=;
 b=oEh0MCPeyA94ShKao1zNsuRh5sRN2LjTnxH+lLrbhhjyyQx3uPo2P56XRaZZTcEtPZFEzggXTTuVcgxPKSsvnvYXbAbdyrEas33U9H6fD/9CLFcn5Y5H9lwu6xiEoH5OxImAm2hfyQ98BDbgqZ+RarLukkhSqpBzAfbbYYgEkEKEPjZ44+PU6SExo1ScLBXLfj8NDbkAjtMAUhigoBIEIBs1IRZviSWBBJoDI7nqrV1l+KmcO9fRMREIgvf3HaypdxlU/maWh3xJUqZeNl1QjgIWXgJDtDdWjPYQll3RCtyrmCe94/uDytM+8P5r7sCZ5EXFqSdQrne1XICCXvYksA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xOYjyEd0ixHlHEi4Tq9d5p3v75Su3MewMhlISnNg1co=;
 b=LaAmuR2mf5HONmPrjXtkDZ4USU/YI86+Lqu5lC7q06KK/AF0My8OMe0OXHgDYzlWFv5QZXCOCRid+u1IPtHG3FOxTcHM0NHCnakXLnJOCbpOhWwTCHUwYVm5X52VDH8zWsxUceRAJB+9CdtTXiLyC5JN1mvkdY04TFzZrhKnQd8=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH7PR10MB6132.namprd10.prod.outlook.com (2603:10b6:510:1f4::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.18; Sat, 25 Jan
 2025 16:25:00 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.8377.009; Sat, 25 Jan 2025
 16:25:00 +0000
Message-ID: <421c33ce-d43b-4444-a83a-a25f4fabfce2@oracle.com>
Date: Sat, 25 Jan 2025 11:24:57 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/8] nfsd: don't restart v4.1+ callback when RPC_SIGNALLED
 is set
To: Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>,
        Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>, "J. Bruce Fields" <bfields@fieldses.org>,
        Kinglong Mee <kinglongmee@gmail.com>,
        Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
References: <20250123-nfsd-6-14-v1-0-c1137a4fa2ae@kernel.org>
 <20250123-nfsd-6-14-v1-1-c1137a4fa2ae@kernel.org>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20250123-nfsd-6-14-v1-1-c1137a4fa2ae@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH5P223CA0006.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:610:1f3::23) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|PH7PR10MB6132:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ce27a48-7c30-4849-987e-08dd3d5cd05d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|7053199007|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bW5DUUplRHZISHpOS1VFa1hzcjVhcFNzNXJGV2NUeVliQy9EeVE5VlVtb1V1?=
 =?utf-8?B?MHRZMmk5Mzd6UXFmVzFIdjFnaFNhdDdWK1VGWFliN1NoaHZHOWlISTVzeS8r?=
 =?utf-8?B?V0RLdW5DRkVjK2t0QXY5eTVneGZ4MlFQMVBBU3JPVVJuQjJOSFdEY3I1VmRl?=
 =?utf-8?B?N1BEQTAwLzVEamlRS2lYNUM0Zk83MVQyR2V2WmtBNVpmT1R5SFh3RXBya1NR?=
 =?utf-8?B?Z3dDNU1MMkI0MUc0eVdrTGlNRjNsN3BCWm5uYmk0S1l1Yy8yZlhHb3RKRVVJ?=
 =?utf-8?B?Z1Y2TWtNU09rWDJkSVY1azJ2WWxNWDl5TENkdDBpWlZMc0dVd1lML1dPVjd2?=
 =?utf-8?B?bXBaYWQ3dkUySXZoSkk0ai9VS1JxdGFEaFVYcVBaVEJoSUM3MFJjdlhWYVBH?=
 =?utf-8?B?ZmRNU2wrK1k3b09LQUljUzNUZkZJWXdBN1N5NVY3Z0xqUzFvOGtoZnIrL2hy?=
 =?utf-8?B?UGMvWTVHakJHMnF0bFdLdlM2Ymd4RndQaVZmUFRQYjVQYXlad1oveE81c1Iy?=
 =?utf-8?B?N2s4bjhaRHNoeWZjc3ZEWVFya3pMSjkzcGNlYW1Wa202bG1qZ1lVNW5XMExV?=
 =?utf-8?B?cnhyTzEyeEpuWW1zMWIrOGlucEZhN3FkVTVVdXo1ZkEzZ3U3djM0bGdLSjdT?=
 =?utf-8?B?N3BlZG90UUJpYzllV20rQmM2Y3gxQzVpcks3dDE3TmxmZTJGZVpaaHJuZVVx?=
 =?utf-8?B?YVNFNVJ3aHppWnFQZEc1UFhsZ25DYjczbTlGeXBXZHoyQ1ppei83UjNYQ3VV?=
 =?utf-8?B?VU1qdjRUUmU1dk12NVZIaXY5MkszWGUwZ3U4dFhTSEgzUUZxR3ZNR2FCSG03?=
 =?utf-8?B?UXBzd2Z3eDUzSURSTTRHUFdSVGVRMDZSY3pEbkI4Y0liekhjL0lrTlhXcXlO?=
 =?utf-8?B?VyttQ3NWc3R1WUtnRldqc3VpWmkxZjhpck15UndRZFIwbndxUVdhWjIxOFMv?=
 =?utf-8?B?b0Jlb3Q4R1lCQnViY3BybXpPckFUVlVMbk92aHJyQXBrci96VHVRZXNJQWtG?=
 =?utf-8?B?alF5aWR0cEl0bGxiMXJQbmtWTEptYlRtVFlXT0dXdUg1TXY4VXhXVFBsNnNl?=
 =?utf-8?B?cnZnWGhHMG10YWQ0eXNSWk9UQ1NPeEdzTlhlN2tldkU4RHliRm5UZjk4bDNK?=
 =?utf-8?B?ODJzTCt3TlNaWWxsdzB3Mm4rci9uNmhMSVZlTGdOKzJjcjJha2FhdURGTVpD?=
 =?utf-8?B?NlRkSzZkakpZQWJRRnBtUU5leGVKYXlxUFNIcy9QRmZNdi9SdWJGQXhidmpN?=
 =?utf-8?B?RXdMRWlDZnM3bDB0VjBuTkJ2ZThERCt4SEhpSXRGRlFuekx2cXdRNU9Od2tt?=
 =?utf-8?B?bkNrOHdkUVM4MERyN2RvYW9qdmJPamJvdjNxQWcwZTZCS1dSUXVDbEVzMDho?=
 =?utf-8?B?dlBhV2Yya0tLdE1LbUZaMFRjRy9jY2ZIUzBIa01sUnA0NDhKdHN2bXFjQmdh?=
 =?utf-8?B?ZUhLSkMwaXpDeW1vRWR3U1BwSXVLNmdZbXJwNnc4bUV1TVB0RlNpSlNtRGIw?=
 =?utf-8?B?T0xXUng5Q3RKSUx3aTh2QzZZMFROUGthdk5yQWN4S1NkaCtma1V5QTBpaVBK?=
 =?utf-8?B?ajVxazJaMXJKclkxYmM4QUlVR0x4bThtRFplYXlBSndDN3BTSTJYcjJObXB4?=
 =?utf-8?B?YXROa0N1eklRTTNSWU5CT2dUelR2bWZSUFhEN2VTbjNDVnBGU1pBWGpuMTQ1?=
 =?utf-8?B?ME02KzFtTk0zaVpuNm5TMXJIWXh0UEJwSUVJb0orZnMrQjRGTmJZVXVoaGll?=
 =?utf-8?B?OE90bEVRclN2OXFVMDZDNFpWSC94VkVsNHgybmxjd0h0c09TUDk3RTZOM0Vh?=
 =?utf-8?B?WFdMMFRTM0NEVFdTVHY5QTZLS1BiSFh3a0MzTmlVd3NuYURtYWlvNlFqS1hX?=
 =?utf-8?B?ZnU4NWxzVEE2MGU4cTh5OHpQM0pSYUNQeklIN3UrUGhWQ0VoMHQydTFjekFh?=
 =?utf-8?Q?gRCma3z+Qcw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(7053199007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UHZCcUNoVnM1Z1VYMmpEeU9WTzhBbU1uMnZta2dyNUhEckZ4dzgrTUU0d1F2?=
 =?utf-8?B?eW1UZ2UwTDQzUzNUamdQSjVHUjFnUDlrVXpneVY5ZnNyenZoZkRncFBTSmlO?=
 =?utf-8?B?WmJ2Y3JYd1AwVTIrb2NrS3BzRmFGeFN0cXA0enNZTktxcEp6b053UDVRdkFB?=
 =?utf-8?B?OFVab2JEa2RmL0o5OGxjaWdxSEtmWjVRTzc3VUE5dXdXMmFJb1lYRURKdmsx?=
 =?utf-8?B?QkNxS0luUnl4amsyNVpBTkhVZThLMjVnd3VEdWRvMXpLL2o0MEVickVZeXFB?=
 =?utf-8?B?R1UxaGF0WTdOWGVGR1c3STMrZndUOTcxWU1mQWo2UUk4eDNtTDkyb1JlbzRM?=
 =?utf-8?B?L2RqL3FKRXNhUnYvTlliODRSZEgzZVZWNDB5SFZ1R3hSZGxLRDg5Z25BdzhU?=
 =?utf-8?B?TUpqNEl1UVlERUc3QXQzTjM3aGYyYmF0RWtpMkdDbThhOG11MVhNYVF0RWVo?=
 =?utf-8?B?Sk0wYXplVGdyYVlHY2pFaVpWc08xSnpXTUpta3IvYURIOXNFQTFwQVVsWlV1?=
 =?utf-8?B?d1FaS2d5UDVuc1NadVdxWjFLV1lsT1pCMzNQUEFWdFFDRHRaVWg4Y1Nzbngw?=
 =?utf-8?B?THZ0ZTBHa0xaU0tCdHJzbVRCeHAyQjBtYzlmaXFOMHNYR09BQXBQcHNWRlNE?=
 =?utf-8?B?dW9HOXJpMTBCVXpJNkNDbjdMVGtQR1ZoYjN6aS96RVV0ZmtYc0Y4c1hnREJY?=
 =?utf-8?B?alNxUkhqSHZ2RUM4VkJheW53bSsxYTZCaVZqWDlwWHFwTXIrZFVIcllGT0VC?=
 =?utf-8?B?ajl6VzdDT2NjTHR0NTlMOUU1UTYyNmM4Z2gzSm5pZlU0TUZrdjZkRml2S2FC?=
 =?utf-8?B?VWFTK2p3MTlldmZNRmEyUlgramN6bzhPUkU3QkxmZGEyTWp1ZHhKejhkTkdG?=
 =?utf-8?B?Y0lVc0RTdE9rbkRBQW5nbEE3ck1MV2dYQkdpVUc5S3N5bFZ4TU14aU1VbzY2?=
 =?utf-8?B?RGxhOGYyMDg5YlFFbmpJZWRmTnZvNHY4UTRaU3BkblZxVy9YaCthSlhNa09Q?=
 =?utf-8?B?OFRlNFJ3ejN2eVRvekw2eWI4anNGbkU4RTNXQ3RwV3lPUldFOGhNNktBbzg3?=
 =?utf-8?B?V2dnenZHdkFLWitPbDVJd2JSOUNDWXZVZndITXJmVE1xVmg4Sy9yZXExRGZP?=
 =?utf-8?B?YXlOdlJ6QnZYVFI0d0l2aFRPVkRYMW9zbGVUZTVPNkh2eEtXdG04ZEplRXZ2?=
 =?utf-8?B?bkZIL0NaL2RPNU5PQmlDN294dEErWFhMSjFTbThRNm9LOHZpZCtnOGcweVFG?=
 =?utf-8?B?eHp6WFUxTXBTdm5lY0JEOG9nOUVKS3NjUGxscTQ3K0RKbzBwanBVWWpoNVVG?=
 =?utf-8?B?dWh5Zkx6K2NOR1BoblRnNVVrMlhFWTlxTEtIZlZ6TlRjNUZRNnRjMmlTQ05x?=
 =?utf-8?B?M3F6a2dSaEdqU3FEZjFCODB2aHUwSFlJM1Z5NHJCZHJpSmM2aXZSeXFvMFNT?=
 =?utf-8?B?S0Z5OFp6V3hWNjhlNmlRVkFqb1B4SzlNT0laS1IyM2M5aGJRZG5DZXhsTmRX?=
 =?utf-8?B?MU0wNzdNZTFQd0RRYnZSYnNuemZpTGlHVENDRVlkbFdiTXVwbE92NEQvQzlT?=
 =?utf-8?B?VVB4Z3E5UGl1Nmx1RkJER1ZSU1JRTGhtM0owNjRiNzQwUUxMMVBOR0tTRnlj?=
 =?utf-8?B?SERxcXVIVU1tcUhhSSsvNzNFcDZ3QWZ3aVlDVWwyNmMrV1FFaWdzYzA0UG9z?=
 =?utf-8?B?eVQzdm5MUTZQWElGb0h1UXBFTCtWUkhZZ0pWV05ySkw0Q1NoQ2hIMkhFNWVp?=
 =?utf-8?B?NUxGQTNjR1dOeDArelY2WEh2Rk9hWFVSa3lDVkx2cnB2MDF2SXhZMFA4WFlL?=
 =?utf-8?B?LzljMzVHZjZMOHVPZjVZRlIwZFlMTDI3YTVTOFl0Z0JkSVA0S2JyWTNMK1FF?=
 =?utf-8?B?dmhBWi9KRFNHd3FSSlJjZm80eGpKU0o4bDI4ZUl6eVhiTEhYcldLMHBraHJ0?=
 =?utf-8?B?cjlXL0M4dEFocGJINHBHanRNSS9JRjFkY3psdm1pUFFtcFZHT3R2a0pRZktP?=
 =?utf-8?B?aG5OL0lwdHlnSk1QUEZHNjNCUy9JcFhYZFZvYWNieEo0YVpCUVMwR0VpaFlL?=
 =?utf-8?B?b3NnNjV6TE1nVzJBcTBHQVlYbTU3RG9ocWtPKzlkU1JMa0xMVFVpbkhiaGR1?=
 =?utf-8?B?eUhoMEtQZEs1VXVSeUE4SnpTRGpCYWYrVnBnZlpjQlI5TlhTeHY4V0crMWlM?=
 =?utf-8?B?UEE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	zQ9Ek99yH8nl1+ckrnWeLKyxIejeYoZr9aROFY45exWWq6rL2pG/HwQ9hStULQMwxRx+87aWbHsfjx8ovslccA1QMxeO4/TZk2dCAkdrDK07xFfFoHjN/N2QPJ+w2gTiz4upXI+FbPUXuxa8DsVPImInuVxuqJttyjCRgYYvM8TQdl1IzeQ9enAcuBQvA8LBCOsaq254cidKJZIxmmfmidnYknSNtHd9sBfmhOC+N1ZJN2UlEH9qVRUuxSaVHig1rmJ7lRs6eY9KOcMYMM+tWMKFLafukUDrRi82yw87w0mMyUrAMEmCj6wpAUDJBu72+WlaDELUpTrgz+ckdq2zaHwGy3nEEXvkTKSg3GZsKfQKiQ9V4oZgjYJAKilZm+M0mpL5U/pbPwQevKKo0iw0nSAkHmBqTEZ1+wauE578/u4+62iF6Z/vaZ7m7QSlqtU+E///VieXSZxhwbMvS/vRGqj/6dUL0vZjafg60bU7xC2iCknKORfl/hT0TQPalo8C/QwWdRyqnMFBi3NrkV3H6bcqnGKVsmYcGAxLTdipjm+8EsRDQizJ2B2MnW73A2h78dTQ+RhxGi8rZiiQiOZE/9A4w1JMFs6YYA837lJcibg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ce27a48-7c30-4849-987e-08dd3d5cd05d
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2025 16:24:59.9675
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pA5yTLw0BDkty8aLD/Y5uAti3s+Y9q0VqWjllF+ImMVjB9mLFaoz2JWAiEQf9SlILqfdNe1GpJbgZvp/MZutWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6132
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-25_07,2025-01-23_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 adultscore=0
 malwarescore=0 spamscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501250120
X-Proofpoint-GUID: rCYo4qiXNDyPki0oE-N7M4UvKZJDxwFq
X-Proofpoint-ORIG-GUID: rCYo4qiXNDyPki0oE-N7M4UvKZJDxwFq

On 1/23/25 3:25 PM, Jeff Layton wrote:
> This is problematic, since the RPC might have been entirely successful.
> There is no point in restarting a v4.1+ callback just because
> RPC_SIGNALLED is true. The v4.1+ error handling has other mechanisms for
> detecting when it should retransmit the RPC.
> 
> Fixes: 7ba6cad6c88f ("nfsd: New helper nfsd4_cb_sequence_done() for processing more cb errors")
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>   fs/nfsd/nfs4callback.c | 3 ---
>   1 file changed, 3 deletions(-)
> 
> diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
> index 50e468bdb8d4838b5217346dcc2bd0fec1765c1a..e12205ef16ca932ffbcc86d67b0817aec2436c89 100644
> --- a/fs/nfsd/nfs4callback.c
> +++ b/fs/nfsd/nfs4callback.c
> @@ -1403,9 +1403,6 @@ static bool nfsd4_cb_sequence_done(struct rpc_task *task, struct nfsd4_callback
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

I too am skeptical about this logic, but I don't entirely understand it
yet. More importantly, though, I don't recall seeing (mis)behavior that
I can directly attribute to it, so I can't yet confirm or deny your 
assertion that "This is problematic".

Before making a code change here, let's gather a little evidence of a
real problem. For instance, we might want to replace this logic with
something better rather than wholesale removing it.

You might start by enabling aggressive disconnect injection to see how
backchannel recovery works (or that it doesn't work!). I'm trying this
on my kdevops NFSD while running fstests:

cd /sys/kernel/debug/fail_sunrpc/
echo Y > ignore-cache-wait
echo Y > ignore-client-disconnect
echo 24847 > interval
echo 97 > times
echo 100 > probability


-- 
Chuck Lever

