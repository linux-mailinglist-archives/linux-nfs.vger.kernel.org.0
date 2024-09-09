Return-Path: <linux-nfs+bounces-6346-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BF15971CD3
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Sep 2024 16:38:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AC441C23271
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Sep 2024 14:38:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CB121BAED1;
	Mon,  9 Sep 2024 14:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mtsxlbmi";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="AP29cFjE"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36A0A1BAEC1
	for <linux-nfs@vger.kernel.org>; Mon,  9 Sep 2024 14:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725892683; cv=fail; b=OKI/4AwwKLc4zl8OJSt7MmE54WHcQDoyk/3aWWh8h5PinU55TJiJbvwH/4qIyJt+MPGguqGbR1aVP9g3gmbACVZ3vtfXMzVUBjnlrIUYpeAf6t7ievQCiv+wU7luKh7ERLKKoblaxwpnu1tGjDyqVxY/anayqTzhXki4+LyZSM8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725892683; c=relaxed/simple;
	bh=oRg3Y4JeIV3+7TFm/E8tZHscnRfqOFVU+tvZ0Hrqb54=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=r01QlzCVPHwmbnMdV80WLh2QzRXMPS52xwexrLD86FJc9/AuLGKn5ZriMbHkSeaULQKJEPZf9Co/OwdURduSMcr0YpjX+eRVvhUjm8VVltGTWmLmfZ1yC4TJrUjH21Xzt7oZ4HeGCHzajr1yGckCG8NokWRxklZIv90la0UOmFQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=mtsxlbmi; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=AP29cFjE; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 489DfUKJ029116;
	Mon, 9 Sep 2024 14:37:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:content-transfer-encoding:in-reply-to:mime-version; s=
	corp-2023-11-20; bh=Uj2ee5lNAn0vWc5dxdP1ryD79ymLVIeT368OU/fGDBI=; b=
	mtsxlbmirFQ/Fn2DRXk/hBLy5E7wipG1ECHuzjYXZcdbPl3cmySKMgGEmmvHCrO7
	17jWvKxZYQppnfEhdvOPccrAPb+9DbHyr3G4cSrF3oGc8ItW2sGNmzJ0Wy/XClF5
	DSCTyWFRscoHx1WghBoeeFvXdUpPyGjaAAyC5f6D0LWygkwURGTIkV5jOiaoVVWz
	y5bNJNfcbt8sUDJQuC9RHK5NNSy6P35LSeO1Ke3kSU3FLpUem8S0o9/hnCHU+jmH
	xbuVeT/gukxEvbTc0/8HqchMu8aU/+mQra+/Qdg8WqPGjLM0h5Xrd3FheGO/Jayc
	QBh1EhhwghRG54ESD+19ZQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41gevck4sp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 09 Sep 2024 14:37:51 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 489DEpQN032415;
	Mon, 9 Sep 2024 14:37:50 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 41gd9dhu0r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 09 Sep 2024 14:37:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pcx3kpxiGhn8hD8tVIA1SbUcluazGLCfyqyR09WGf3vAt5oyFZ0r9CCp4KwPatoOBlOZommoGbaVTwpWbjsHTpNsGhlSXjJ88HkyyJG6V2so3tSbddFmHp2F+RDWLpXjBty2gBZFcZR6NdINDvaR0Qa1xa5Hvm+CdU/9A98QDCIW3ZKE6EjVO3W6HXEHt+fIFEkwWUfceVYwY2FSyHZKvRXKrRhHH0K3pXufzxckhAir3LlMBTbwkkZcDaiPTaKLAR36lqvsocZ5Y4IimBDORwcy4pT5s/jdGIG+ozs0QULUamreiQlfl6/YD7eFbsjPKRKZ3yOptxvcmGwsmhDGeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uj2ee5lNAn0vWc5dxdP1ryD79ymLVIeT368OU/fGDBI=;
 b=JpAPKFgP5LFIhrNs5Enmw3+jFZHryOlWpUHqyiKnzwA3GS4GML9yteHCIXKLDA3ZUTZQGEiIQ5b6JcpBm4Ye9jDX/Ui1hbKhQvlR5eJv1nuPVPdrjYCxcvdx2uWpTEncy4neYfiMNBvAbxdwNSOh6jT5IghE0HnCobTZPmStQZfaNAXfhS+IGecvrmrsjCw2+a1jZVo7boDOL3Tj7YYWiHnCn+EXCSGEn4Oz11xRaKw47ScQ/AUj4g7Y2eWiVQDewaxXOkUSACktJS8ABVPsvqMfdNYmNaIdR3pqxBVfKj0uCbI6sHuxtoN7Z3i4avxv023VZqcPIt+SjDvGilViKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uj2ee5lNAn0vWc5dxdP1ryD79ymLVIeT368OU/fGDBI=;
 b=AP29cFjEJ0+sAkQrKFp1K9iT5WTJRbosokI9N/L9djFwSZe5tdszMj6Ic+5rAHEkkfmpdxZrMfQRN+IYBWVAc6Hh83xCbsexRY8htc3samxQIiUuVx6T2RUg2UDup0nif+KaajJU1qclePjdgdbJ2pZNCV563mWdV5drt7mIWHA=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS7PR10MB5976.namprd10.prod.outlook.com (2603:10b6:8:9c::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7939.10; Mon, 9 Sep 2024 14:37:48 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.7939.022; Mon, 9 Sep 2024
 14:37:48 +0000
Date: Mon, 9 Sep 2024 10:37:45 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Olga Kornievskaia <okorniev@redhat.com>
Cc: Jeff Layton <jlayton@kernel.org>, NeilBrown <neilb@suse.de>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        linux-nfs@vger.kernel.org
Subject: Re: [PATCH] nfsd: fix delegation_blocked() to block correctly for at
 least 30 seconds
Message-ID: <Zt8IOQUF/VEkCPgO@tissot.1015granger.net>
References: <172585839640.4433.13337900639103448371@noble.neil.brown.name>
 <adadfa97e30bc4d827df194814e4e05aa26b8266.camel@kernel.org>
 <CACSpFtBYpQpAKVOmHLPUOr5LvoYq0-ea_NFMctqhMYSamUL_ZQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACSpFtBYpQpAKVOmHLPUOr5LvoYq0-ea_NFMctqhMYSamUL_ZQ@mail.gmail.com>
X-ClientProxiedBy: CH3P221CA0001.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:610:1e7::11) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|DS7PR10MB5976:EE_
X-MS-Office365-Filtering-Correlation-Id: 21517f33-f911-4221-e9ca-08dcd0dcf9a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OUZRcW4rR1Rkb1NCQ1dLQTV3WGNMZ2l5bU8wRmNNdGZRMzVjOHA4R1VIblMx?=
 =?utf-8?B?RUE3NWZnSGlMMVk0VG83S3JIcVNTaFJCUkYzRGZRVjlQdEdBSVN0Wm5HVmhW?=
 =?utf-8?B?TGhPKzNjVEg3cmNpY3ZWczkzNzE0VDJGbG9DSFBhalJaMFFhS1VLMDRlcUg2?=
 =?utf-8?B?QkNpblhMQ1UrR3ZQbGFMMlBaU0tXeHBRaWE3cWc3ZXBPKzEwZnhzOXYrQmFi?=
 =?utf-8?B?TEdmeFRmaTlUeUtJUWJLa3dGZWtvKytSWktsSHRMRFVKMFRHUlNSd095aXcv?=
 =?utf-8?B?SlQ0Rlh0U2kvOHR1c3Q5SDM3UGY0MWxLVFFheGdxc0IreUtqeUJWQ1d6Y3Ny?=
 =?utf-8?B?Yy9wdWxONmdMUWRJQlBVUE9xY0I0d1MyV1hhOG1hQkM4YTgwV2ZDWU5OTUNG?=
 =?utf-8?B?ZTlVVEVTUTMzNzNoaC9iS21DUnhrMzVpSGJDYmdOQmNJWVNINDNheklWZEdz?=
 =?utf-8?B?eHhOdUxZZGhqWVNoUFFHYmJSMVIrek56YnIzcGR4M2tkblE1RGxnQ25vVVNG?=
 =?utf-8?B?b09VNWdZUzlsT3A4REU5VmJma1NXY1lsdGhJNXlDWjh1ZG1nNkVWd1NvK3Rk?=
 =?utf-8?B?NmdVN09xdDIxU2gwYitkdXJZWmx3VEkzS0hDOVRzUWxhL1N4QlVVeElUUjVi?=
 =?utf-8?B?S29Tc2NzY0tySk41MlQxR2JRYXprN1V5QnV2WkxLZkRScllQSnNlZVRHVHVN?=
 =?utf-8?B?SE1waTlvV3VQQnJ3a0RGYVFIdXBSTmlCQkNBOVljWDFmTXB0SnMvaUdkQk1B?=
 =?utf-8?B?bnYzdk12SCtjRFBkVk9aZEE0dTBJa3UvTS9Ka0trN256QisyTXZ0WG1saTgz?=
 =?utf-8?B?cDdyaDk5ZHNNcTE1MXBxY1p0RnBhN2JHVTlkZ1QxbFNSVVQycnorVjhBR1JI?=
 =?utf-8?B?WnB1bG9NVkVKTHAyWHdoS0lNM2xjRVMzdGx4TURhRXA5Z2VqR3FoZmVjYXRa?=
 =?utf-8?B?Y1MwMXpCTXhtNFBoWDdKWlZLWmd4NGswU3RodktHUW9mcmRUbTRYM3daMlBq?=
 =?utf-8?B?UWFxMHNrencyelpMaXB6c1gzN0FyWTJmeUN5UkprK2RNRXplb3ZNRElIZmcx?=
 =?utf-8?B?VUlEQlM4Tm1SRzVmMEF3eWhWOE1hZ0RuZWtWbHR6V2JBMHhzZlgramIyQmdD?=
 =?utf-8?B?MVluMjVTWXdjK0xubS9WWXhtS3EyaHk0cHV1dEZyQUJNMDdFcXlMRlVhNXFt?=
 =?utf-8?B?bWk2cllOdU5PZUNydys2UlQxRzV4eTYwMUMxUEQ3TkRaK3JMazZVWXJFeU5W?=
 =?utf-8?B?Q2xRaTkzSmprQWROcDVQd2dIOS9RNTRQYzQvdW1Gb2pEci9iMWkwVm1FOVZy?=
 =?utf-8?B?K3hxNmEyTmVJT0U3Q05IVlkzUjVST1RNVTg4cEVWNENRd0ZFOS90MjZmeFRy?=
 =?utf-8?B?SWUycUJ3cW5xbjFzaGJ0Y1pWMFlyYlhiU3FvYjNEWHB4cEwvWUNzaDdoMVRK?=
 =?utf-8?B?TWpRQU1GcTJraUJyU3ZuYzlFSWJzWko3NDkzMmlmb0dZNStEMmJHd01CeXpV?=
 =?utf-8?B?eHhCbGV3dE9Zb1JmWWRPL3l5SVlobVMzL2ppV1VkZXErVkxlVHdGemZGd29z?=
 =?utf-8?B?VHV2MmJOZm1UdFVCNVAwbjdRQlMya1BJUEs1eW9DRDhHakVIRUNOU3V6a2x4?=
 =?utf-8?B?QzZEd0NQRWhhZTdrRVBqbFZpcjVJQkp0Vy9DVjR2cWh3b0RlODg5QitHMmIw?=
 =?utf-8?B?TnJUdUc3d3RvZitONWQwdFh3bE5OYmlpMmNsQ3dWWk9xRU8wUnhGQjF4bTBV?=
 =?utf-8?B?Q24ybHVGRDNsN1ZNek5KNzVDRWZ2YnhoU2xpNlVjQVg3c3NvR1hGTVBpdThM?=
 =?utf-8?B?aUJ3VXJ6TG5LeVRmaC8wUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NWF2U2hMeDBjVnBmUGFXY1VoM21QWHh6Zmd1cVJIQU1HbXNoSTF5UmhuWG0y?=
 =?utf-8?B?aVZpS2RYdkRxcGQvZ2p3TTFMSm5tb1hMejVad2Q5djV1UDBPMkZ5UldXcW1z?=
 =?utf-8?B?RGY4OXhyZTZRTlJDOThrWUVPR0hTbFlXZThvQ2k0aWk1UGQ2dlhqN2VqdTRH?=
 =?utf-8?B?T2EvTnFMS21nOEVMZytYdFRzT0cxYnNKMkRSMXQxTS9kMWdNYmlCTjdYaU5V?=
 =?utf-8?B?UEd2amRVaEJwZGw2NFBscExQZGxzOTFoZXl0bmNvaDR3OFViWUs1MEtxSmZl?=
 =?utf-8?B?Rldpc2M0dDlJeXRxVHFhQ29hcmVmMDZSeEMvTkxFVUxMclk4YnJXT3B0VmJl?=
 =?utf-8?B?K0U1aEx2RE9RR01zRDF3S0d6Z1NVYldPZFN5TldiWWlMSXc2d21ROGM1c0pk?=
 =?utf-8?B?TS9sMVZnYWQxbGRkSnd2UnRMNm5Oc2RpQzErcTliZGkzOFZyNHRnSGZOeVBj?=
 =?utf-8?B?MDNjOGd2QVQ1Z1hoa3EyMzJZcU54VndwODF1NVNWNVc5bDNVNjBGM0cxVEdC?=
 =?utf-8?B?UzhqR1dTL3ViYTBqb0hLcklVVUsrd3BJZ2VhYitKN2lTRzVkekNoVmQ4TFYv?=
 =?utf-8?B?VFRyZTg3eWlOeStrbFVSdVh4dkZKdy80Yll4U2x1RWdZU0FCaTBWOXJxT3pM?=
 =?utf-8?B?U1FpbVA1azJTMUhFMFBodC9HWmJ6UlpvQzVqS1h6bGdQSUVKcHErNm1XS0VZ?=
 =?utf-8?B?TVZHLzlObDkxLzZXYVNUUDNtTXdOWFlUZjFMT0Q1UGxRR1JKVDRZa1ZrckdQ?=
 =?utf-8?B?Y0ZDTDloOEx2RWhwSFVBZ2V4WE9LeUtRK3hnV0hQOEZ2SThmUkJwcEZQbDEw?=
 =?utf-8?B?Y3RmcThuYXJnNHRNUDZqODA2SUdHRmZOQmN5MGViRFA1Ni95TEdaWlU0cVpJ?=
 =?utf-8?B?MzVzNDNLUm16dFM5UHFvNG1EckowNnpGMnFCME8yOUUwdTI5WExZbFVkSGdj?=
 =?utf-8?B?QzAwamVCamhtWGlEdnpzUGFMcllwbzQvNWJVdWlwc3psK2NNUlJoL3hKMWx3?=
 =?utf-8?B?Yis2d3RuZVFKY2RSb0xGU1NMcWEwZ2FpaEJmYzR1dkRVZTgyQVY1Sy9KK3By?=
 =?utf-8?B?UEd0aURycTU2cjdXQ1UyZU1zWHNSbmUvRlRkS05UK1NCRHFFMlYwTWVMR2NV?=
 =?utf-8?B?Z1B3c0NSbWM3d1BlS1pMbUFYMU5QREdZM3dFS0lMa245SUF6bWh0NVg0REkx?=
 =?utf-8?B?YUxXdThjc0JKSnpYc0k1SWhqbFZBSzNsc21aSEFidG9oRVhld2VMTG1ESEV0?=
 =?utf-8?B?TG41YkxlTW53WDNtb1cxUzlIVTYvNU1vMnViem92V3ZhK3dRc0JnM01MUmNp?=
 =?utf-8?B?aVVCZk5zWjdCdFZzQmNOVlRIUmJJY0RUSEtBcHVjODRxRE4xV3VBSVRaek5z?=
 =?utf-8?B?VW1ESXE0UjhkSWRQTFRlS1ZPczRvbGhyYXhCZlRMWjdxM3RMbWxpcnM5UFVK?=
 =?utf-8?B?d0c4aVVoL3dJZnlERlV3RmZlbW9GeWZBWU1oeGU4ZjE4Z1plT3JjUVdna0Vv?=
 =?utf-8?B?RUxtM01jTElrNTJTd2xPK3JCWUNaODA3L3ZnUEhTY3ArdkxFQ1NrTEtWK05N?=
 =?utf-8?B?WUkrb1BUb1JPUFhtc3dZTTY4MWhCSExwbmpqVUc0TlVGUnFPWndIRmpqSlg2?=
 =?utf-8?B?VW9JMXNIMjhEZkx3L1ZOSHF3NVQ0ZTE5WWVjUERBeTlYMCtGbVdZMDR6cGw0?=
 =?utf-8?B?eEVYdEhlYTBzMFZLWWlqVTdUYzNycy9JdEh4L3E3VDcvbGlnS1U4UzRITGh2?=
 =?utf-8?B?dUxHdzdydTYwSnpUNnBsS3JkcDM1dDhOeGVSemtuM1RjWk9QMTBIZ1VCMlFm?=
 =?utf-8?B?K2EwZjFsWlpORG80S1BjQXlxa1ljcWRRQTUxb2h6aWp5TkZBQXMvaW1BN2RK?=
 =?utf-8?B?NW9NNHFpY29GdkpVL01kcEpoeGtuWkR6TkxSUmp3UTdUdk9SbFp3THRkT2ht?=
 =?utf-8?B?WHVvaW80d2pRSTdvRzdCZjMwekZYYUtDcU9wNUM0d2NuQ0NrZ21uVjZhOXFp?=
 =?utf-8?B?V3k5RFFCUWIxT0krOWdRaDFmNWN4c2ZRL0VCbSt5T1hjTnhMOWRNR243QzQ3?=
 =?utf-8?B?bVovSjhTb0tLRmZ2R1ltRVg2bElaUTM5RWlwOHRvZFcyY2g3Y1NPUDh4T0kv?=
 =?utf-8?Q?fWeZcAGg6mFKaXZOjq6sChW9P?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	2bVJHKyuaqJqaTr4K+VFrIdlymmveFwiq+2cnicRVU50Uml5KkiNLn2HoZMwVPrEkCXrakATn7KNKB1LQFEgCjMzW8IVCKJK7MoZeUjZdRv9l6G2p9ziyILFZRTK7fqnWmGg4hcRi2AtVBr0efBz7KfSez5bh7pf3Mlk47oRjVKwn8cEH5jBP/JNiduF/lc2SQqjINRiKx53NmpB9hlvn0FayOqcO/zGskWZtm8T+8qEMXjqWu9RFFIv4tr1Knf5PpgnEqRsQcWiPlHuJKVsLNCOW8r8DLr5c/SD5lHJoDE8JBqQ8gY9ezoj8Pw5es9hcFF8zHcH9TylFsXXDDLXFerjrM/SPTv29oeJav2lrd1j3lsSkyXlKclNty14eHOeA7u/hRymmTiZ58o/XhKYvF9oAOTiQHinHhcHYXKkYjn+9R1o0k2o5vHBrJo9JcgTu5tH4040FTy7I4ei+X34STsaRZ6KeIBD5o74Jmdz4LAKkWW5WRL9D/eqxRpxBvlGjzzkIWThmHsWgxdVIHpQsokmJ4N3/tlQhLD3PyEKzx61CiFQzBLxotHWFP6WuO/ghMUnVKs7bkkAwQ8/MaP3q3mL239vNLKy6LvQkPw9IFk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21517f33-f911-4221-e9ca-08dcd0dcf9a6
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2024 14:37:48.1238
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ISg5KslmX1x6fSUjECxW2PjfEx1tmxsA/W5O4D6B1poIXa9wH7dcNpM4lb5f0jiatWdnE7I4ls1M0woAIwSfQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5976
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-09_06,2024-09-09_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 spamscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2408220000 definitions=main-2409090116
X-Proofpoint-ORIG-GUID: WOxR5qm-6EmD_YaJgRx6RHrbPlEaYvwz
X-Proofpoint-GUID: WOxR5qm-6EmD_YaJgRx6RHrbPlEaYvwz

On Mon, Sep 09, 2024 at 10:17:42AM -0400, Olga Kornievskaia wrote:
> On Mon, Sep 9, 2024 at 8:24 AM Jeff Layton <jlayton@kernel.org> wrote:
> >
> > On Mon, 2024-09-09 at 15:06 +1000, NeilBrown wrote:
> > > The pair of bloom filtered used by delegation_blocked() was intended to
> > > block delegations on given filehandles for between 30 and 60 seconds.  A
> > > new filehandle would be recorded in the "new" bit set.  That would then
> > > be switch to the "old" bit set between 0 and 30 seconds later, and it
> > > would remain as the "old" bit set for 30 seconds.
> > >
> >
> > Since we're on the subject...
> >
> > 60s seems like an awfully long time to block delegations on an inode.
> > Recalls generally don't take more than a few seconds when things are
> > functioning properly.
> >
> > Should we swap the bloom filters more often?
> 
> I was also thinking that perhaps we can do 15-30s perhaps? Another
> thought was should this be a configurable value (with some
> non-negotiable min and max)?

If it needs to be configurable, then we haven't done our jobs as
system architects. Temporarily blocking delegation ought to be
effective without human intervention IMHO.

At least let's get some specific usage scenarios that demonstrate a
palpable need for enabling an admin to adjust this behavior (ie, a
need that is not simply an implementation bug), then design for
those specific cases.

Does NFSD have metrics in this area, for example?

Generally speaking, though, I'm not opposed to finessing the behavior
of the Bloom filter. I'd like to apply the patch below for v6.12,
preserving the Cc: stable, but handle the behavioral finessing via
a subsequent patch targeting v6.13 so that can be appropriately
reviewed and tested. Ja?

BTW, nice catch!


> > > Unfortunately the code intended to clear the old bit set once it reached
> > > 30 seconds old, preparing it to be the next new bit set, instead cleared
> > > the *new* bit set before switching it to be the old bit set.  This means
> > > that the "old" bit set is always empty and delegations are blocked
> > > between 0 and 30 seconds.
> > >
> > > This patch updates bd->new before clearing the set with that index,
> > > instead of afterwards.
> > >
> > > Reported-by: Olga Kornievskaia <okorniev@redhat.com>
> > > Cc: stable@vger.kernel.org
> > > Fixes: 6282cd565553 ("NFSD: Don't hand out delegations for 30 seconds after recalling them.")
> > > Signed-off-by: NeilBrown <neilb@suse.de>
> > > ---
> > >  fs/nfsd/nfs4state.c | 5 +++--
> > >  1 file changed, 3 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> > > index 4313addbe756..6f18c1a7af2e 100644
> > > --- a/fs/nfsd/nfs4state.c
> > > +++ b/fs/nfsd/nfs4state.c
> > > @@ -1078,7 +1078,8 @@ static void nfs4_free_deleg(struct nfs4_stid *stid)
> > >   * When a delegation is recalled, the filehandle is stored in the "new"
> > >   * filter.
> > >   * Every 30 seconds we swap the filters and clear the "new" one,
> > > - * unless both are empty of course.
> > > + * unless both are empty of course.  This results in delegations for a
> > > + * given filehandle being blocked for between 30 and 60 seconds.
> > >   *
> > >   * Each filter is 256 bits.  We hash the filehandle to 32bit and use the
> > >   * low 3 bytes as hash-table indices.
> > > @@ -1107,9 +1108,9 @@ static int delegation_blocked(struct knfsd_fh *fh)
> > >               if (ktime_get_seconds() - bd->swap_time > 30) {
> > >                       bd->entries -= bd->old_entries;
> > >                       bd->old_entries = bd->entries;
> > > +                     bd->new = 1-bd->new;
> > >                       memset(bd->set[bd->new], 0,
> > >                              sizeof(bd->set[0]));
> > > -                     bd->new = 1-bd->new;
> > >                       bd->swap_time = ktime_get_seconds();
> > >               }
> > >               spin_unlock(&blocked_delegations_lock);
> >
> > --
> > Jeff Layton <jlayton@kernel.org>
> >
> 

-- 
Chuck Lever

