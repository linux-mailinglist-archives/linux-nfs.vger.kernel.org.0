Return-Path: <linux-nfs+bounces-5229-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 17FF4946FC1
	for <lists+linux-nfs@lfdr.de>; Sun,  4 Aug 2024 18:11:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6573AB2129C
	for <lists+linux-nfs@lfdr.de>; Sun,  4 Aug 2024 16:11:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9A9C4D8B0;
	Sun,  4 Aug 2024 16:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GLG+Yf82";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="NAw0TmGy"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45BBF3BB47
	for <linux-nfs@vger.kernel.org>; Sun,  4 Aug 2024 16:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722787873; cv=fail; b=DyD26Mh5lgp2WWoZr+479vn2K2ERXYKWLIM5HS5Pe2aDO0pNkand6I4hXvbEHDAZ42r/xKlroCbCzHT8zAE7xGhv4uGbqo8KCWi/jUAkHiD5++55zPkQrGvTTrAW0j+wSAy117UJVwxUUrh8j6g7VaLbZ5z3EzW2y9LLmiKLiMU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722787873; c=relaxed/simple;
	bh=vA33pBc6yoiBPmUIAQkiINiL9cBa7qDX1O2c1rjzh4U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IlDxcDWjCeLjjVIm5LbDvx21M2wYRy5bFRFw7yGdXot5f3FqYdWs2bvIh5xeItfe2aOADyNqt7XzwD1rmwNYDa+zWojAv+4eWW4ApBmiCWVKXpRKtOtN6vzIjcOoliI6YQxZ5BVHZOJSzvmHgNCUXB05184BgUkg4ZUhQfISyis=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=GLG+Yf82; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=NAw0TmGy; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 474D9TgW009293;
	Sun, 4 Aug 2024 15:51:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=corp-2023-11-20; bh=vA33pBc6yoiBPmUIAQkiINiL9cBa7qDX1O2c1rjzh
	4U=; b=GLG+Yf82dSlzZz8+ZrG8xJfSramcK+8RzGesDa+BzreacKjfwWs5VcJaY
	pZzTDw+bbiCtlHhrxHTTNGUrNlSyX3rzGB2P05OfLFT0lOBBURaEF1raGX19nejH
	emYX6KxZayDfKBT+k2MGE6A28Lzp/MekCSf1X4VgbtyxYhQjRFwTMrCTs25djGUM
	xhPzxrASz309/QUulcUTscEZEMv65QHBBPh4uEbKlJLGhx3elXN9uRx+qanK8fgy
	62I/UWiWvrPiX8Vb/f1SrLRdaJWXZj8+v+mUIPE0MvO4INxYl1JY17hWlo6+eskG
	CBtFIyihglZsRv6UElT0OzQHmcuOw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40saye1c1w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 04 Aug 2024 15:51:54 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 474CDFmm035131;
	Sun, 4 Aug 2024 15:51:53 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 40sb06gmmx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 04 Aug 2024 15:51:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wn6bsEp6vt0lZiGU2m0nETVafkdkeI39wppNENU1rKF3rFBienfsRyOlTTC4XNJQsGwsTU0a/c8imdJt7mThIfcdKbOvv2HiALMxPCF4bJLY9YhcgUY2IOnJxHCU7wgAlYNguoskPhhWN2dLv7P8NvHPxOUwxOwyWmR5f3rtBFom9mer0+x1UYeWGy1Lg/NTG2WhF27kMTxlZgc9vN1CU6ZUp9oG+zZJwWLLUWQE8uUhuhKMH2pUlVoLpLiQ8r2TCPi0VhSYp47JilP9CXA8DyNrJ9I+0EYKuG9DAYvxFk/peNE/9DcMHqJ6WXOgZ9jsKPYdW4zdxvptGKTEK9EFBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vA33pBc6yoiBPmUIAQkiINiL9cBa7qDX1O2c1rjzh4U=;
 b=jfbrlFS8OaD2egX73GXzHGxoI31GXjrjUXPQVH8vswfu966agD9OFS3cWVSYt4bWPvZJyoJBdBMeP0+OIcQOPld18EFtDnTTxB3rK7GLO36QuCGWIEyPKl1LaSyl3IxbNOgAc9MvONbO9qDEL2XgONzNphK1tUcSL53CUpgBq7kCzUDpZ70h+8GvIAMHL3PHPYH5DX2mjknyFNWuxmG0ATRbL2LiR/OUtsJkGil3HG+lArUfUzzdtBBkcNudcFuCg6/Q8vUhlA4nmUeWuL17IG1O9Dw0MfaB/ALu/Pb4WwlCM+nUaMkLamghyBgHUyLtvOLoDAhz4Kg0ermIbyauXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vA33pBc6yoiBPmUIAQkiINiL9cBa7qDX1O2c1rjzh4U=;
 b=NAw0TmGy2SIiyU479fforjKkzK80zBbiMMndHkdvRh6pAr170R613yYRodNi9A2UGYlzGvAHhn2oCuRCAXZiNgCUnSxbE86UjT0WiYbe0VEJ73A9gy0U3LXEY1CCM2ygKe6ph4aYj5Hf4EZkduOfTBIWwH6PXRKHdVHhKzcDEZw=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CO6PR10MB5603.namprd10.prod.outlook.com (2603:10b6:303:14a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.26; Sun, 4 Aug
 2024 15:51:51 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.7828.023; Sun, 4 Aug 2024
 15:51:51 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Damir Chanyshev <conflict342@gmail.com>
CC: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: nfsd rdma bandwith investigation / possible lock contention /
 request for ideas
Thread-Topic: nfsd rdma bandwith investigation / possible lock contention /
 request for ideas
Thread-Index: AQHa5Qe3dNyBHp+zW02LCWahVKDQRbIXQlQA
Date: Sun, 4 Aug 2024 15:51:51 +0000
Message-ID: <A110B4E9-DC72-4C3B-99A3-2FB213A9AB8E@oracle.com>
References:
 <CAAUwoOgLfKuamNatGYSgE0z=XFM8Z7B5-94caHPaZ53qhSbOjQ@mail.gmail.com>
In-Reply-To:
 <CAAUwoOgLfKuamNatGYSgE0z=XFM8Z7B5-94caHPaZ53qhSbOjQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3774.600.62)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|CO6PR10MB5603:EE_
x-ms-office365-filtering-correlation-id: 6e3c90cf-c3af-451c-f170-08dcb49d5b1e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?Y0lsOXJ1NkU3TnpyaXlna215UlFWYWFKRFh2bVJ3RlNOK2M4N1Z1OVpXSGRW?=
 =?utf-8?B?ZGVnS005dmY4VFErUytSczk4Wk14ai84dDdKc1QvSXNQd1BtZWVYRDNHNEZL?=
 =?utf-8?B?eEVpTGZETGpYYnRiTlpNMXNabjVGREp1ZS83YTJyV2haNW9ZNjM4MWRYWmZa?=
 =?utf-8?B?TGZBZWZzamRzS1ErWEQ1K2o2V0dFZVpRbW9YQTRWSGhuRmpQV004c0YweGcv?=
 =?utf-8?B?MmovWlVmUTFPWE1FcVpCUm1adnlhTjdaaWFiM0QyK2ZTRk0wMVgrL0tVVmV5?=
 =?utf-8?B?dmJGUEtGaTZsbmhtTjFXamtIc3dzYU5BaXpJeDJBRnl4NjEyWklnQ2pjRUJk?=
 =?utf-8?B?UnZrdnRWRjkrZjlmL2laL3psVUNTU3dYdjRNSEFQbmF2S1pkdGVCSUYrU09W?=
 =?utf-8?B?T25MYkxOYWZoa21Vd3ljOG14RmVCWVVTUEgvdStBcVQvVWRKdnFHOTJTakpm?=
 =?utf-8?B?ZlBYblhsRnNyclIrQjc1LzZJRENqSkQxKzE4N0NNK0c0U3FLWWlqUklVSTNZ?=
 =?utf-8?B?VXZjNjJYY0JoSUY3aWlBYTFBQU10OTVGMnBLbWhYMEZYNGVmZG9JMDRBRGJq?=
 =?utf-8?B?d0Q0SzY1dUN4bEtUZlFjZFlwSlZ1cmFYSWJHQ2RGWmJxdXVValBEdVpQa2di?=
 =?utf-8?B?bG05NG5EMTdaTnU3dHFqbnRkcFdadkRyQ0FNSm5CVWxoVmZkT2NZdW1TVjdj?=
 =?utf-8?B?MzlqK2lZeHZQbXNqZVcrUEhMSW81R0I0c2x3elZxbUh5SC9uNlhZVWxoQ2lT?=
 =?utf-8?B?bmlQNThHNndMc0czM2toaWZLTndDbE5TUXZuWm9uL2xRWEZIa3RveE1Qb0VV?=
 =?utf-8?B?aTQ5VGZ2Vm5OSE41K3NIZ2pCbnllK3FQcERnYTZoM1RuMUMrTDJuRm5YL0p3?=
 =?utf-8?B?U014Y2V2MUZqUnVGekV0cUE2cDBtYTQ0VURVR3laczkwcnV0SmdGa2VhVTlk?=
 =?utf-8?B?ck5XcTI0eXNPSFpLUjZqRm1jTURoQmN2T1hnemVDQVMxU2laSzd0N0hlWjZn?=
 =?utf-8?B?Z1BMZVd2Nkd6S2gzRlk2dWs1d2hVdkVtRWw0MG9Ec1ZUOFh0TjJTYVptcmw3?=
 =?utf-8?B?TmtxT2FLN0JSOUVxMmpyRmU5ckI3cmwyVzY0dWVFVHg0RVpjeE1nMDE5cXNx?=
 =?utf-8?B?cVZ1emswbFBReWZxV1p1aE5kTGNwYWVYM2dzc0xZV3BrTnNieG94ejJnWHBm?=
 =?utf-8?B?S0syWGhTV0ViV0FWS3lvK0tYQzgxV2ZpNE9MOXVZaHNSNDVEV0QyOEdHR290?=
 =?utf-8?B?QVFSWlN2UCt4bFZwcFVtci82T0VDWUQvQ0NkTHIvZ0RPTzBhNmRmdmsxWE9i?=
 =?utf-8?B?YXJJNlU2UVpieTB5VTZxTFUyWkN4VllwYmZseUFELzlEOG9XN0QyZVVGZ0F4?=
 =?utf-8?B?YytiV0pDWjQ2QThPSDhub1BTakZuZ09OVlZBbTRwVG4veHRlZDhhM3lZdHVH?=
 =?utf-8?B?eG4xSG1rb2lHL3FEbzZSbnF2U2o3ZGR3UkIrSkU0QStWRjFZWXVVTG1xTEtk?=
 =?utf-8?B?S2NyYmlNMmV0UlBmNTA3THZFSi9XeHc5QzlkNFFXK1ZldDFBUlhIZWJYZTJS?=
 =?utf-8?B?aDFPTWtQUWdYY1RoQjJCWVU1VzJGZlpTQlNpMmVBR1g3UGVKcWdzKzlnTi9i?=
 =?utf-8?B?aGVXVVlmbHlrTUNzWHd2R2NxVTN4NlpGSHJheUdGMWhXbUsyTXBpelRPbUxI?=
 =?utf-8?B?b2VmK01MUDJXTEVHdnFHK3dpZTY1UmpsR0JzMld5a3ZFRHdnK1p4WU5pZ2Z3?=
 =?utf-8?B?ZlhtUVNvRWxvTmxHMzc1cVhSQmw4UWYwNjRUSGpFVnVIYXp5L3l2Tk9Ha2Ry?=
 =?utf-8?Q?k/9b7L0R9EDSskN/GZqIzpD8SwH6FN4jowtrs=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VUVTR1hzb3kwN1BRazU5VUFzWnBOUzY1eGZrak9CZ0wySnZJTGNvSnRnTUtJ?=
 =?utf-8?B?TXBEQ00wSG42dzE0UFYwNzQrV1hqb1JYNjEzbllUZER1QkpoUGM4YzcvN3ho?=
 =?utf-8?B?cjdGb1d5UHdJVE5nU3FneXdyUEJYTjhxQnhSb0MxeUkrbVdyWFBLU0pGMG9T?=
 =?utf-8?B?RVdOaUlkbVFLcmVSeGdYQ0N3T0dGUXpJazF1UzRkMklQV01TbHdyTUVYa2s1?=
 =?utf-8?B?WG1oeHJ2NUVkbG1DK0dZWWhHNnpES2k2WFE4aVpud1JtVkQvS0VyaWpuK1BY?=
 =?utf-8?B?NGVaUXlUZ0t1KythR3U1R0dnTFFWV0tTVjhLanF4eXd1VmMrNVFBQkpkU2dO?=
 =?utf-8?B?RElYM2pyV0VBODVLOXpBMFdNTUdSa0lURHZKa0ZVOGowdnNSRjFleHV4NXVZ?=
 =?utf-8?B?Y2JJeVF0V0MxNEtIRkhNMnAzTnpSSndrQUIvR1BmcVMydytraWdCR25IaGxX?=
 =?utf-8?B?NktBSllDMjJhM1NsdWlhSS80UW1MRGxnQ0J3VnNtNSsrRkFJUi9LY0RvNTJI?=
 =?utf-8?B?cWFDRXc1aXBsbHVVWjQvQ1l1a1Z6UmNSSkExaWJENXhraitYak94S2FFOVM0?=
 =?utf-8?B?QTVtZGxrWk80czR2QVdpWXlWZzJHMytnR2RHV1dzNlRiYTByTTlxdFpJWEZB?=
 =?utf-8?B?c1hDS2MvQXRpbjRoNnJoMithazRLTnZIZ2tIUlB5djlmMUMxRGd1TkNzeXRX?=
 =?utf-8?B?QzEzYTlxQ1RuekN2M3AxMVAzV3dYTkpNWTZtUFNnOWdqcDA2MEFGNXNnWW9Y?=
 =?utf-8?B?N0FvMC9sWExRTS9LZmZlaFVNV0t6M0VhVE9SWTNmRHFiRXZCcEtZZHpLWTZZ?=
 =?utf-8?B?VHVycE8zQVhkMFlhWXg5NEtwVktvV2pldSs3SitDQTc1WjJrS1c4REp0Qzdh?=
 =?utf-8?B?UHJ3eHkvZXRRaDE1ZE94U0EzbjZRTjc4emJiYmpudEEzU3NjNU5ncGk0QWFW?=
 =?utf-8?B?NVpxZDVCWHdaVUZHSHRHbHc5bnNNcC8rSG9UdWs3ZWwxTlZ0MmphR3hZKzR4?=
 =?utf-8?B?WTZIR2doUTduaTlhZ0FPQmdybkN6a3AyNXB3VWxqNGNwRmNSdzRYb3FFc01o?=
 =?utf-8?B?Ri9GakNOM0cvcHJUZlFHNk9BMmFYb01XbnRqOEpuZXBQYU9iT0lYQlc4a0li?=
 =?utf-8?B?dzRMdVFjOTdjQ1FURVJtQzZGMGtRbGhPZG1VYU5RYjZYNVNSV2ZqUUVJUW1v?=
 =?utf-8?B?QWVyMlRrQ1lJaGNEZEs3dkw3Umg1dUN5N2Z3K1RnaFNqenhvd3dmeVJZYjQ4?=
 =?utf-8?B?ZXYwV0JENWM1c2FJWDIyTXgxc1IyTUJLTHU5elBPU1NKNVZyRFpWbzlyN3Fr?=
 =?utf-8?B?NG4zMzh4N1RFT1VSZTYzcDBYQTdVT1QrYmIyb0RpUU05aUxzM21CVElDZU1S?=
 =?utf-8?B?U1JJWTdrWElFT212ZEtwZGIvdDdOYkltdVpnYVoxRGpqNWlTRE5NdnVGWGhO?=
 =?utf-8?B?bzZWVlZMYVo4cU9yZmVMY2ZuNXpVYVdWdmZueTF2Nk9KN0lRUThZWUtCM3Z5?=
 =?utf-8?B?K2NURmhYTzVNUXdIaXlodysrSm9HOXBDNm5qMzAwcVRFVW5rclljSnJ1OVRt?=
 =?utf-8?B?ZzkxZGtjY1JBMUlyMnBRYWg3UkVjNHpSNkFhVnIwRnJ3bDlXaUdzaUdjREVm?=
 =?utf-8?B?ZStKOE9XT1ZKcUJKR01uMFNqeDIzT0JtUkRpa0FuQTlwU3FaZU1wR3A1VkdS?=
 =?utf-8?B?MXJNVGRIZHY3bmlMbGt0VGRTNTVpcGNvdXFBMVRWM1VnaGd0RzRoQXpJeUNE?=
 =?utf-8?B?cE9lYlN2NklwN2VJV2hDOGdkdGpuZm5TYjZyK292dWR6dS9CYjFCdTRYZXJE?=
 =?utf-8?B?VmhzQ2pTTTZDZnB3MHlJdnhOWXRHSkVkc0M5M1QvRE9CQjV1VWdmUGVkRnhv?=
 =?utf-8?B?SC9qaStwNGRZQWIwYXhEZ3ArWGxDYXZENFhlWEdBRkhXa3ZrUmFZWXVBbTdt?=
 =?utf-8?B?UVFWL1BpVEFSY3Z6ZWJERkJsQ0FBSEFydEdwckQ1WmVuNlFEQXlhaCtpV3hI?=
 =?utf-8?B?WnpPYUZQamVFd0tQY3hVTDJiR3FFdXg4YXZUa3kvNGZvUHI5L01ja0hUT1Qz?=
 =?utf-8?B?QmFHbnU0M0Jqb000Q3NSc01Bd1JHc1JDeElZYThmbXFjeEkxdHBzdjBiT3o0?=
 =?utf-8?B?d0l5ZjlFemkzZ3piMjBPWE04SVRCcldLb1Nnbm9KWjUyT1JhN2d6OURtMlRy?=
 =?utf-8?B?WlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BA18FC4154F0914BA8ADC696C04D94FD@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Y75PnvxbYFEurElZ9ukeS3FUq2wLxBFhuZT6Odu86uZwIw00kJnCZgZL4dH0uIwG/4fj/Bhpx6lXAOGVghmIw/bjHzNBD7nrZgfQWWrWqLESLIVW+Q3aFZPXHnf3fyJvXU+pZR4ODtpPEG0w9g2LYSbGLxYiKwUVmscvAhYrHuutXnKK88vnpO7javw9Yj3BnAebveezf4APC3D+HfpdwIOn/m1zrWte5Y74UVx5WDFrgM1jqPOkuNMVDhVLtFGV2lvHRIrjo6co5PGlBTg0yNv+py2rHVgrpEFNlCGY2a0OFVjyZXStcIpl0CXxMpGDkZFJFJLTmRi6263Ya0ZHUoAnUggt/lYucwmDgZMM7unswEYMrbF8Ll3/3Wjkucq++tMLPPJ0t4LIR8UhAdYFBQUaT8agf3rBef0bw25UwY8iqVY0nm13KJ7QBX7BPCCOUBYHxxGNo/dxz0oTsk7T2dfSWDFK7oECYOUA57tRH10oiDW9A71kV75soypGAZ4NRZMiBehI756q4giIJBbcPTrlBmUo2vAo7Q6voYm/eSWS7cgK4Fu8xX1LxD1J+33IffHmTWKiCBCTw7hTooMD3N7k4c41cDFOCJqZXq4qxXc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e3c90cf-c3af-451c-f170-08dcb49d5b1e
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Aug 2024 15:51:51.1182
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZTgwjgsbEqBM4jaKdnf6m37iVW/LLGSAMigj9HYgW8cG72qkW0diKpMTbURC2KIeMh86/PLpSVDpe1zQk2whBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5603
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-04_10,2024-08-02_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 phishscore=0
 mlxlogscore=999 mlxscore=0 adultscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408040113
X-Proofpoint-ORIG-GUID: TCiMHkQrYEBT6RuYcnSxXCAenAWRNfJ4
X-Proofpoint-GUID: TCiMHkQrYEBT6RuYcnSxXCAenAWRNfJ4

DQoNCj4gT24gQXVnIDIsIDIwMjQsIGF0IDI6MTHigK9QTSwgRGFtaXIgQ2hhbnlzaGV2IDxjb25m
bGljdDM0MkBnbWFpbC5jb20+IHdyb3RlOg0KPiANCj4gSGVsbG8hDQo+IFJlY2VudGx5IEkgYnVt
cGVkIGludG8gYW4gaW50ZXJlc3Rpbmcgc2l0dWF0aW9uLCBsYWIgZW52aXJvbm1lbnQNCj4gY29u
c2lzdHMgb2YgdHdvIGlkZW50aWNhbCBzZXJ2ZXJzLCBpbnRlcmNvbm5lY3RlZCB2aWEgaW5maW5p
YmFuZCBjeDYNCj4gbmljcy4NCj4gU2VydmVyIHdpdGggNi45LjEyIHJlbGVhc2UgYW5kIGNsaWVu
dCB3aXRoIDYuMTAuMi4NCj4gRHVyaW5nIHNpbXBsZSBmaW8gdGVzdGluZywgdGhyb3VnaHB1dCBj
YXBwZWQgdG8gOTBLIDRrIElPUFMgd2l0aG91dA0KPiBuY29ubmVjdCBhbmQgMTYwayA0ayBJT1BT
IHdpdGggbmNvbm5lY3Q9MTYuIEZvciBibG9jayAxTSBhbG1vc3QgdGhlDQo+IHNhbWUgc3Rvcnkg
NkdCL3MgdnMgOUdCL3MsIGZvciBvbmUgZmlvIGpvYi4NCj4gSG93ZXRoZXIgY2xpZW50IHdhcyBu
b3QgbWF4ZWQgb3V0Lg0KPiBXaGF0IGNvdWxkIHdlIGRvIGluIHRoZSBjdXJyZW50IHNpdHVhdGlv
bj8gSSB3b3VsZCBiZSB2ZXJ5IGdyYXRlZnVsDQo+IGZvciBhbnkgaW5wdXQuDQo+IA0KPiBQcmV2
aW91cyAgZGlzY3Vzc2lvbjoNCj4gMSkgaHR0cHM6Ly9tYXJjLmluZm8vP2w9bGludXgtbmZzJm09
MTcwOTY0NzI0ODMwNTgyJnc9NA0KPiAyKSBodHRwczovL21hcmMuaW5mby8/bD1saW51eC1uZnMm
bT0xNzE5NjY3MjA2MTQzNjkmdz0yDQo+IDMpIGh0dHBzOi8vbWFyYy5pbmZvLz9sPWxpbnV4LW5m
cyZtPTE3MjE5NjkyMDUxMTMzNyZ3PTINCj4gDQo+IExhYiBlbnYgZGV0YWlsczoNCj4gDQo+ICMg
PT09PT09PT0NCj4gIyBjYXB0dXJlZCBvbiAgICA6IEZyaSBBdWcgIDIgMTE6MTg6MzkgMjAyNA0K
PiAjIGhlYWRlciB2ZXJzaW9uIDogMQ0KPiAjIGRhdGEgb2Zmc2V0ICAgIDogMjQ1Ng0KPiAjIGRh
dGEgc2l6ZSAgICAgIDogMjIxNjE3MjANCj4gIyBmZWF0IG9mZnNldCAgICA6IDIyMTY0MTc2DQo+
ICMgaG9zdG5hbWUgOiBuZnNkLXRlc3QubG9jYWwNCj4gIyBvcyByZWxlYXNlIDogNi45LjEyLTA2
MDkxMi1nZW5lcmljDQo+ICMgcGVyZiB2ZXJzaW9uIDogNi45LjEyDQo+ICMgYXJjaCA6IHg4Nl82
NA0KPiAjIG5yY3B1cyBvbmxpbmUgOiAxMjgNCj4gIyBucmNwdXMgYXZhaWwgOiAxMjgNCj4gIyBj
cHVkZXNjIDogQU1EIEVQWUMgOTM1NCAzMi1Db3JlIFByb2Nlc3Nvcg0KPiAjIGNwdWlkIDogQXV0
aGVudGljQU1ELDI1LDE3LDENCj4gIyB0b3RhbCBtZW1vcnkgOiAxNTg0OTc2NDEyIGtCDQo+IA0K
PiBtb3VudCBjb25maWc6DQo+IDE5OC41MS4xMDAuMTA6L3RtcC9yYW1fZXhwb3J0IC9tbnQvbmZz
X3JhbSBuZnM0DQo+IHJ3LHJlbGF0aW1lLHZlcnM9NC4yLHJzaXplPTEwNDg1NzYsd3NpemU9MTA0
ODU3NixuYW1sZW49MjU1LHNvZnQscHJvdG89cmRtYSxuY29ubmVjdD0xNixwb3J0PTIwMDQ5LHRp
bWVvPTYwMCxyZXRyYW5zPTIsc2VjPXN5cyxjbGllbnRhZGRyPTE5OC41MS4xMDAuMzMsbG9jYWxf
bG9jaz1ub25lLGFkZHI9MTk4LjUxLjEwMC4xMA0KPiAwIDANCj4gDQo+IGV4cG9ydHMgY29uZmln
czoNCj4gdG1wZnMgL3RtcC9yYW1fZXhwb3J0IHRtcGZzDQo+IHJ3LHJlbGF0aW1lLHNpemU9NTM2
ODcwOTEyayxucl9pbm9kZXM9MjYyMTQ0LGlub2RlNjQsaHVnZT1hbHdheXMsbm9zd2FwDQo+IDAg
MA0KPiAvdG1wL3JhbV9leHBvcnQgKihydyxub19yb290X3NxdWFzaCxzeW5jLGluc2VjdXJlLG5v
X3dkZWxheSkNCj4gDQo+IA0KPiBuZnNkIGNvbmZpZzoNCj4gW2V4cG9ydGRdDQo+IHRocmVhZHMg
PSAzMg0KPiANCj4gW2dlbmVyYWxdDQo+IHBpcGVmcy1kaXJlY3RvcnkgPSAvcnVuL3JwY19waXBl
ZnMNCj4gDQo+IFttb3VudGRdDQo+IG1hbmFnZS1naWRzID0geQ0KPiB0aHJlYWRzID0gMzINCj4g
DQo+IFtuZnNkXQ0KPiByZG1hID0geQ0KPiByZG1hLXBvcnQgPSAyMDA0OQ0KPiB0aHJlYWRzID0g
MzINCj4gDQo+IGZpbyBjb25maWc6DQo+IA0KPiBbZ2xvYmFsbF0NCj4gI2JzPTRrDQo+IGJzPTFN
DQo+ICNpb2VuZ2luZT1saWJhaW8NCj4gaW9lbmdpbmU9aW9fdXJpbmcNCj4gcnc9d3JpdGUNCj4g
ZGlyZWN0PTENCj4gZ3JvdXBfcmVwb3J0aW5nDQo+IHRpbWVfYmFzZWQNCj4gcnVudGltZT05MDAN
Cj4gc2l6ZT04Rw0KPiBpb2RlcHRoPTMyDQo+IGV4aXRhbGwNCj4gDQo+IFtiZW5jaF9yZG1hX2Nw
dV0NCj4gZGlyZWN0b3J5PS9tbnQvbmZzX3JhbQ0KDQpUaGUgZmxhbWUgZ3JhcGggc2hvd3MgdGhh
dCB0aGUgaW5vZGVfbG9jayBpbiBzaG1lbV9maWxlX3dyaXRlX2l0ZXINCmlzIHZlcnkgY29udGVu
dGVkLiBNeSBmaXJzdCBndWVzcyB3b3VsZCBiZSB0aGF0IHlvdXIgZmlvIHRlc3QgaXMNCmNvbmZp
Z3VyZWQgdG8gdXNlIG9ubHkgb25lIGZpbGUuDQoNCg0KLS0NCkNodWNrIExldmVyDQoNCg0K

