Return-Path: <linux-nfs+bounces-4087-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B94B90F5F8
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Jun 2024 20:22:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A247E1C2120C
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Jun 2024 18:22:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7CDF15252C;
	Wed, 19 Jun 2024 18:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BeLc/UEk";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="tjvA5koH"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B787157E82
	for <linux-nfs@vger.kernel.org>; Wed, 19 Jun 2024 18:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718821356; cv=fail; b=vB4oaEDTqooYX+HAxMCh668WxHoiYlL9lvmtVysdUxDkcYM0XssL6yMmkq+T3zor12TG8DFjIAWTXcYoF/n4J93UA9XM7+/ym1IecbncQt3ce2OORtXdpUTnqEjgV4Nr5k0ngwgMKfg7OtKH8RPwNflb9Xcml009ksHxDaICG1E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718821356; c=relaxed/simple;
	bh=euiCz+17zTqqSVR/uJipiFmD1QTkUNMbTvVw7ATiRmE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=o6RrREdTxhei++zbu8N5Oz0BhV/FFDPNRc5JZ+hWHFWmbgHkp7E9UlN3CRL/6Gj2QLJ7EBnE9zswlKnKuYyJ6PaqiIeu9tVSe32mbVRcWOYNoaC3VJgmnHOjgnOkl6w41s1Oyox9WoBxXUxcHBj1fVGju+iTtHZwHwmxjVm0mS4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=BeLc/UEk; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=tjvA5koH; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45JFBWxL009333;
	Wed, 19 Jun 2024 18:22:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=corp-2023-11-20; bh=euiCz+17zTqqSVR/uJipiFmD1QTkUNMbTvVw7ATiR
	mE=; b=BeLc/UEkHORkskpdIvj0f13tYIcTeieS8KNMbKm36a4sxH/gw0tuvvk3c
	mejzWTAAileXGkLVSWKfprujsFQY20lXQClDM3bjgwWV+3fq4T/a0sSR4rNlk5y7
	ezFMUwCOl2Y9tWnfqN1KghsE4k/Jtr5DaaqR/QZmaljl+d63+jK1hGsBXtHkx2Ky
	5jzleJy/OqjP8BYVoLzLj434LyyI8Uqt8SbYuQKwx0kjbMqHjiKTCJwpr4uViMBj
	/jG6zDnYfOPA0EYYPWFeAFY+MSmdqAf6DiIiaeE4p2xzf7bEKwQTElvyI9emIWOB
	JRbb6swcwoe252vqx1vDkSzPJWZ9Q==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yuj9ghtca-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Jun 2024 18:22:15 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45JHtXQQ007116;
	Wed, 19 Jun 2024 18:22:15 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2175.outbound.protection.outlook.com [104.47.55.175])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ytp8g5xh1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Jun 2024 18:22:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gsvgLoqKJcWzI1/UG4Ykhwpby65xtF+920AZyFynHM9BeOuGbUqHZtD9NUCr7NBYf/mllAhIKnFbfcn4ZLOmAgS/vIevwDwje6GRj5kByrXcB2rs6lkExXC1Ponyl8LL4hE5ameyWR6WWdZ5yjxiiR88qCCNaeaFIEYcLmzmhyT94TPlNOEzRpDoabUryXByrXm6UMi+GZDsaTaybnt2yAQcMs1nBeYKSaRxpibyY5cX0b7gQw9g+segE2X+ZT4SZ0sq2uA4Y4wpGF31XlDSkckSP5VIBHJXJODeF5TbIyaoYk5rySFxjxIy012XlLq+nGn1R+XlO2wHuIfHyVpxlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=euiCz+17zTqqSVR/uJipiFmD1QTkUNMbTvVw7ATiRmE=;
 b=RaS0lT8QrOfUZwrn/801a8xDp3+5h6sPMfE80/f+lWex6OfRAl0aWoV5cEMzegA04wXFBDm5+N2cR5RjrthWRSUXELpOrSrG0zvX8mR3PpLFdwhdwITh83fV9mzg/8Wfo88UjpvltzNlVC8sqP6Kw/1wKTPE7wZb65DbO64GpUQzrsLL0u/2bRb5kgO9q4JedCmMUjtKKqqYdjUC5nhNn09y9iFl+4JicEEVIonaH5bVfq5Hy5cBBDCw7O4PnaAj38GoRcFviEixxSEuvjVwjc/CFrKi7qtpMQX8vowhGdoyDpIHZIvlqXvRzeMDgLl0kM1p71rcwDz3OMLUpoixkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=euiCz+17zTqqSVR/uJipiFmD1QTkUNMbTvVw7ATiRmE=;
 b=tjvA5koHKa5mJw695YTgTH8crVHViVsbTNcgI7edyorlSaly6YvhjC0CRUiWrN3Pt2pV6va6Ohos6yKgcOVqmHeLMrbp6U8kQQZZh5FzySVJIUuW3qIOXYkwRhI6vuA7bumsHdmXXJZtOZva5w1+mCm/nr2DUUGwuI/T/Hf7weo=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SA1PR10MB7813.namprd10.prod.outlook.com (2603:10b6:806:3a9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Wed, 19 Jun
 2024 18:22:13 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.7698.017; Wed, 19 Jun 2024
 18:22:13 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Mike Snitzer <snitzer@kernel.org>
CC: Neil Brown <neilb@suse.de>, Christoph Hellwig <hch@infradead.org>,
        Linux
 NFS Mailing List <linux-nfs@vger.kernel.org>,
        Jeff Layton
	<jlayton@kernel.org>,
        Trond Myklebust <trondmy@hammerspace.com>,
        "snitzer@hammerspace.com" <snitzer@hammerspace.com>
Subject: Re: [PATCH v5 00/19] nfs/nfsd: add support for localio
Thread-Topic: [PATCH v5 00/19] nfs/nfsd: add support for localio
Thread-Index: 
 AQHawbzkA6q2NL13ck+t/s2/VqCfZ7HOlUwAgAAWqwCAALS5AIAAAhyAgAACl4CAAAJNgA==
Date: Wed, 19 Jun 2024 18:22:13 +0000
Message-ID: <4E371D3D-F0F6-4DE4-9EBD-426525736FE0@oracle.com>
References: <20240618201949.81977-1-snitzer@kernel.org>
 <ZnJxTsUuAkenmvWP@infradead.org>
 <171878101003.14261.1089014272023335768@noble.neil.brown.name>
 <ZnMb7NxuXnIikSQK@kernel.org>
 <D1A3A43F-757A-43D6-BB71-AFAF2E17C060@oracle.com>
 <ZnMf3dtGkAHfuFJe@kernel.org>
In-Reply-To: <ZnMf3dtGkAHfuFJe@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.600.62)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|SA1PR10MB7813:EE_
x-ms-office365-filtering-correlation-id: 893636c7-ed57-4a83-bcd5-08dc908cbde7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230037|366013|1800799021|376011|38070700015;
x-microsoft-antispam-message-info: 
 =?utf-8?B?eGdIb0F1QVNRU2VMNHNFTEV0RlU4eW9lSyszcUJZMkNxVVNDVStmQ1BqQm0r?=
 =?utf-8?B?T0pTeURocVJLektEalNlazNSZktGTkRWcUxtQjBZWWpxZlI3YjNCUjRTSUhY?=
 =?utf-8?B?VzNZRXVCc2tOZlFjNmhFVVFKVXNWNmovaERZWEtmNWx2Tk1QY1VXdWVsNjVX?=
 =?utf-8?B?d0V2cDRVYnVXMjdoOEJkc0c5WXlpOHJPSDcwY3lXaldzc0ttWFJiaiswU0th?=
 =?utf-8?B?MmNaZFdseDNaLzBjbHRvZlQrUFhxRi9meVJyejRtY0ZxaTlNMXI2RjB0RUJM?=
 =?utf-8?B?TlMzZHh1cFdKZXlMUUhUZU13NnNhOEk2bVBoU0lWQnhaQ3U1SDBDRWZ3L2E3?=
 =?utf-8?B?M1BicDdFV2oxTTZDdXFtc3hUcno2ZVdFdEU4U1B4NGpLbUFLTzJTUVBwaVY1?=
 =?utf-8?B?dG1qWjlkOUhnMTVQTytTMVZWaDRXb01UK200SFY4Ni91dnhVZlBvbldyazhh?=
 =?utf-8?B?ZHM0NXkrUFBQbDlXL2dCY2tEbXUrUjBhT1UxVDhnM0hjdSsva2RvTVdlelJN?=
 =?utf-8?B?WFVwZEFCMkpHNC9tUWg0enR6R0ZCQ1BoRVI3MFU4cE1BemRqZGFOS3dIWmo5?=
 =?utf-8?B?dGNrR0JiY3Bsdkd3YUtVRmhEelJiNFlKZnVyY1lhcllPa2RKWm11R2tZOUg1?=
 =?utf-8?B?MFE0QTFYdGZkQXFZaVMzdjBDbGJQQ1BaZ0ZmN1NQOWRFQWtrQlg4UFNaSUR2?=
 =?utf-8?B?TTg2R1hvM2w2YjJRZWZKRXorVGpFT3hiWjRsSXo4cVB4U3U4dDhDOEl3TVhv?=
 =?utf-8?B?alFIeTd5MjFYem5rZlVVWmhpZHdpdjZ0b3hjWnI3STU4N3dFSjNHL0UvSHhl?=
 =?utf-8?B?VjliU1FHS0x2RThvMkVxUHBpbS9WNDhPYzY2SGxXRnBGZ3dBL1lXdmlOQ3Zi?=
 =?utf-8?B?YjhhVHU1R3k5WUdta0xMcElPQTRGUER3VVpiZ2FpU0hZdjIyTWxpdHpWN2Ez?=
 =?utf-8?B?Tk05RlB5QWIxMStzd0tmeG44dzV6MnFyTnd6aUF2Q0k2YlJ5cTJvL1ZRN1Zv?=
 =?utf-8?B?djVsUDF0NUJ1N1hmbHlNTXdLM2V6Y0FCbGVvbnhZU0QyM050YUtXOHdIWHNz?=
 =?utf-8?B?MHNTU3FmVHU2Y1Z0WUxDcXZIT1ROTHlRemNsdVVIMDVRdFdFV0ZqVmxPRlg1?=
 =?utf-8?B?cDA2OXBIaUlEV3ZHSG14RFpjYjdCZ1RoaWFJUzdqNHFHLzJ6ZW9aSXlEZFc0?=
 =?utf-8?B?OW1welRPUS9UcHdnUXB4WG8zdXpKM1UzcktlZ1dqK3pUaVFBaVd2RHdsRkR5?=
 =?utf-8?B?OTNrUUZlZmNsZ3MrejlZWWNDWm4rM3lmcWlYTWVHczFhYnVJQmtuS2p5bmQx?=
 =?utf-8?B?UmxtNWJOTlBJeEhhMStGL3BhNlZJNXk4TEd6VDliNXpVWlFGRGpLalNER2ZQ?=
 =?utf-8?B?K0tTS0tDWGhZQjZadHZ5WW8vbGRWWFU0bXcvMll1alZLRWZvbkhvUHhlU1Rl?=
 =?utf-8?B?c2Nid01KOTI0amFSMWVNOXZjRDhaclBhZ1EvSnJPUWl4eGxUQ0d4UFczOU1K?=
 =?utf-8?B?UWswMWxldE9xZW9FM0trOTg1d1NkT2xFUk13elUxMjI2Ky93SWQ4Nk82RjNF?=
 =?utf-8?B?V0NXWVl1N0FjZzJPUUNibXlBeDh3UGtkQnZqd0RPaURQV2ZhY05oNXVzU002?=
 =?utf-8?B?TkV2NVZTa3dKdW1ISWFKOUZuTkNBRlExd05hK3FSZmVXTzkvY3J1akZrR2FF?=
 =?utf-8?B?cmZROTFRRHh3Ty9lYnJDRXQ1bHhDeUV6U05wRTI3UlNYRXhUUElrejAwSU41?=
 =?utf-8?Q?Zc346Ri7QaO7oSi2urw/gyWBkDsDZoJ0mZqoNWl?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(1800799021)(376011)(38070700015);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?NDc3MSttREpucUM5cFBvL1ZuWUF5S04zNEtnQmRZbnlNbEJGY0xnTVNvbUI1?=
 =?utf-8?B?Sm9UZjgyZUNXYzVnek9EdWlTT2Z5SGtRNy9zQ0RJeTBiS051K0dXQUZLdXNW?=
 =?utf-8?B?a0owdTFrUjRRSStjOWkwbnhpeWlUZUliU1FRak5ONjZqZm5jRXlQemNobzgy?=
 =?utf-8?B?T2E0SSs3azlIdU9yZVFaZkpiaG80MDhNQ1NjV2h2WUUrMW9BcWEydzZTT1dV?=
 =?utf-8?B?bzNxanBJOXBYWDRpYzBhQnFYbkRpc083b1BJa3hkMmxRUUl0ak9NdHNOUWNh?=
 =?utf-8?B?TnVoWHU2VzMvajVtWHRUOHFENDlaeGVzYVJXSEhCczNZTUNJbnltTkV5bHJU?=
 =?utf-8?B?eFpFMnFzdEdld29QYkxrV3dFYmdqM2NCSm9NOER3eDdDQ0FJb2ZIN3RwWUxy?=
 =?utf-8?B?TFZqLzhmemQ3c0EzUXpzTm5ZSDRCNnk1VXdLc0JFekFMbVNiMWJsQzJCU3Ew?=
 =?utf-8?B?L01VNjlVSzhJaG93YVVjdXhQSndMRWRSRWhSdzAzZlhJZGM2aUVOMFg4d2J4?=
 =?utf-8?B?a1FlQkE1SlBFb0ExL2pJZ3FCNzduMUlkbnl4QWZjUFZ1YnlZNGY2QkJiTG9P?=
 =?utf-8?B?MDlRY21NK0V5d0svcEdWTTdhUTh6elUxaVFweWFndVR4NFljUlRaeklBYUwz?=
 =?utf-8?B?Z2tsV0FOS0lCc3kvV01sd3ZMNlp3VjNpb2NacnJFOGRPbG4zN0gyZDIvQllC?=
 =?utf-8?B?RE5SM002aXpRQlR1VldpTWd6Mk9lMWpDZ3JmZFZJbEZJTkdYOGhYV1pOZTR3?=
 =?utf-8?B?Z0hwK1V2c2pra2czZXVuWWIwWUVlMjRlN2NrbHNudmk5M1cxaVlja0VJcFhP?=
 =?utf-8?B?eTRQZEFvczlXS01jUXg2amdhRWJZODZuRmoyUEZzT2hnNzFQRUtyMW9rVmN0?=
 =?utf-8?B?S2QyelFmUGNkRG9sS2FsdVJtY3o3bFVaNVlsd0JmKzEwTDNNWVFEcm81VCtF?=
 =?utf-8?B?MUxZckFaUnVhVFpKZ3hYeWlTTFZxMVo3R1FkdXBLdXg2TFlhZHQwbFdSeGNi?=
 =?utf-8?B?Y055UWN6Vm9KdnhWNERUblc5a2hhWjhRWHFUK2h4b0V0RmwveUU3eTNVenpp?=
 =?utf-8?B?RU5TWFhOeStqSzFGL0NzWHZIQWRaQjJ5MjM3YlNVSVhJTEkzczBJVUEyNWVs?=
 =?utf-8?B?L2YzSDV3LzNqTkpCOSt0MWRxd1FTRmc0b096ZldLRktQd2M1a0RHZ01MSGJl?=
 =?utf-8?B?RVRzQ0Y4UkNJS3BFQnorZ2R1cWM2UjRRTUFtbHpjMFpqVllPbElTeGVyRUI4?=
 =?utf-8?B?M0FyWVZTSU5hRGw2U1pSU2U3M2VZRWU1RWlrUkErOTdXMTBINUZibTR1NFVu?=
 =?utf-8?B?WlBIYjNHTE1XTDVJYUNXTDR5cVBzSkpodEtKblk4cHdDZW9wU0krdGxGUDVI?=
 =?utf-8?B?emNTZUlCMEg4QXl6TW1WQ1drOFRSM2x3VnVsdTdPcDdVbUhGdjdVM2UyemNh?=
 =?utf-8?B?WmxzRkt0Vm9uOGUyZHRudjJVQTJxQkUwTmZSeGp6Rk02NEpVcEt1NW1KUVVF?=
 =?utf-8?B?QmltVlVYcUtURGQ1NjZ6NUt2NXF5VjFqUTdGQXdoRkl2Q2RaTm41SWJtSHFJ?=
 =?utf-8?B?aEk0SWw3M0V1VEZ0Q3BVL0pNVlEwZWRJT1A1ZHFvWitUN0wrSlN1K0FSdERQ?=
 =?utf-8?B?bURRQkFxZjByTmZKR0tENFhxTU91eXV1bEZhb0ovK0lNUzN5TG9OUkh6RUJp?=
 =?utf-8?B?cE5vNHJKOXp6dXZrNUxsZFlzQjJmZUpSeFNobU9GRURCNXVTd2VkWmh1c2ZT?=
 =?utf-8?B?dWZXSE84VkJERmEvRXNPYnlsMFFPK1YvSlMybDF0OVFvbHlpVTc4a3I3a2dQ?=
 =?utf-8?B?Q09WblNMdnQ0WitoUlh3VTZZdkRnRE1NTnpWVVJZTmFFa2Y0N1k3UjhzZXRS?=
 =?utf-8?B?dEZpOTVSUDlIMmY3RHhkNDlnYWlBRXVRR1EvbGIrZDk5VktlVWcwNldaSkhJ?=
 =?utf-8?B?VWlhZ0VSTDFTTzV5WlArekszaEIrMnNaTEllQWFmYlFPTkc4dUd6R05nMk5F?=
 =?utf-8?B?RzNZcFliY1BVZmNRUmUrSUo4eitnaEU0ZDA4QVAxT1dKcVUvS1dncDNiREEx?=
 =?utf-8?B?R01ZemNGNWczMHJHald5QnYxaEplem1KWDNPQUZqNTJSYm13ZkVJaVhMeHRV?=
 =?utf-8?B?cy9XSzZzUDZMZC9nYnQ2UW1OY0kxVDk0WGNoWkhZamI5STVHYmdiSWR4SkNB?=
 =?utf-8?B?SEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D631E5ED00C1E64D9A6C4A9ED860DD3D@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	0clzGCgowlJbwTBp9Z8dprZcp6gyLm4Sxe6/c2b1ygjtEFI3/1oZ2nCkyJiL+XZHiNcPRf7FwZh8O7Gx+DLlSLkmj41hcvwFiylYrVc+wVYNUmKpfP96KH7dvLKMiuDFOV7gzuh+i34ek7Oh1rv6zcJbvMo/eSiZyvv25acb1er/+e21K2iwTAH2xSefAPhCyAsbRqxk+YOvCQR2iV6BhFyGESw8QTET7vyQDONA2xNitiZot8Rj90/oKEiIQ4gZKIS4I8KhhharJtDRP52NtgbTWnUtOHxm2CbveCeYvklzdor1grT7anhCGXsU4d0+yDT/j6q8ZAU/7m6GS9aC198QXxdJ4zoKuuE1A/bhQ174kuYyWeSR9ElImf5dpGQm1Skivkh/L/N0Pd8UbFJKhaM3VZGi32zQ9gIWkGol1UYPhNqIxtijPNS5IuQjwLZV/ITnIE8YvX4Z29fN0xHzAV938vv+eLhZRfarhxFY1tUTErvOW/Ovuk/7xPEQfpSNMcOSGeW2Bf90um3QvFI838U4p11y1VlQGqncsReOaAhSoSkjqtUiBnuvFuVFNxqXmnFgqP5x5A/LUzfFtQ+7XKeKIimzdCQ7+YXi89SoW5w=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 893636c7-ed57-4a83-bcd5-08dc908cbde7
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jun 2024 18:22:13.5241
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BnqvyhUm9o0xygfaJGoo7tSnzY6lq1wH7kz0i2WIa+BeqVMjHu+5edU9StFNmRKhHXVgFsjX537J8ZdFcSrN3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB7813
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-19_02,2024-06-19_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=996 phishscore=0 bulkscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2406190138
X-Proofpoint-GUID: vGZfnJ-nLF5CqlITLJTkg0tYWvT-lqae
X-Proofpoint-ORIG-GUID: vGZfnJ-nLF5CqlITLJTkg0tYWvT-lqae

DQoNCj4gT24gSnVuIDE5LCAyMDI0LCBhdCAyOjEz4oCvUE0sIE1pa2UgU25pdHplciA8c25pdHpl
ckBrZXJuZWwub3JnPiB3cm90ZToNCj4gDQo+IE9uIFdlZCwgSnVuIDE5LCAyMDI0IGF0IDA2OjA0
OjQ2UE0gKzAwMDAsIENodWNrIExldmVyIElJSSB3cm90ZToNCj4+IA0KPj4gDQo+Pj4gT24gSnVu
IDE5LCAyMDI0LCBhdCAxOjU34oCvUE0sIE1pa2UgU25pdHplciA8c25pdHplckBrZXJuZWwub3Jn
PiB3cm90ZToNCj4+PiANCj4+PiBPbiBXZWQsIEp1biAxOSwgMjAyNCBhdCAwNToxMDoxMFBNICsx
MDAwLCBOZWlsQnJvd24gd3JvdGU6DQo+Pj4+IE9uIFdlZCwgMTkgSnVuIDIwMjQsIENocmlzdG9w
aCBIZWxsd2lnIHdyb3RlOg0KPj4+Pj4gV2hhdCBoYXBwZW5lZCB0byB0aGUgcmVxdWlyZW1lbnQg
dGhhdCBhbGwgcHJvdG9jb2wgZXh0ZW5zaW9ucyBhZGRlZA0KPj4+Pj4gdG8gTGludXggbmVlZCB0
byBiZSBzdGFuZGFyZGl6ZWQgaW4gSUVURiBSRkNzPw0KPj4+Pj4gDQo+Pj4+PiANCj4+Pj4gDQo+
Pj4+IElzIHRoYXQgcmVxdWlyZW1lbnQgZG9jdW1lbnRlZCBzb21ld2hlcmU/ICBOb3QgdGhhdCBJ
IGRvdWJ0IGl0LCBidXQgaXQNCj4+Pj4gd291bGQgYmUgbmljZSB0byBrbm93IHdoZXJlIGl0IGlz
IGV4cGxpY2l0LiAgSSBjb3VsZG4ndCBxdWlja2x5IGZpbmQNCj4+Pj4gYW55dGhpbmcgaW4gRG9j
dW1lbnRhdGlvbi8NCj4+Pj4gDQo+Pj4+IENhbiB3ZSBnZXQgYnkgd2l0aG91dCB0aGUgTE9DQUxJ
TyBwcm90b2NvbD8NCj4+Pj4gDQo+Pj4+IEZvciBORlN2NC4xIHdlIGNvdWxkIHVzZSB0aGUgc2Vy
dmVyX293bmVyNCByZXR1cm5lZCBieSBFWENIQU5HRV9JRC4gIEl0DQo+Pj4+IGlzIGV4cGxpY2l0
bHkgZG9jdW1lbnRlZCBhcyBiZWluZyB1c2FibGUgdG8gZGV0ZXJtaW5lIGlmIHR3byBzZXJ2ZXJz
IGFyZQ0KPj4+PiB0aGUgc2FtZS4NCj4+PiANCj4+PiBNeSBmaXJzdCBhcHByb2FjaCB3YXMgdG8g
KGFiKXVzZSBFWENIQU5HRV9JRC4gSXQgd29ya2VkLCBidXQgaXQNCj4+PiByZXF1aXJlZCBleHBv
cnRpbmcgYSBzeW1ib2wgdG8gcXVlcnkgdGhlIGhhc2ggdGFibGUgbG9jYWwgdG8NCj4+PiBuZnM0
c3RhdGUsIGV0Yy4gIEl0IHdhc24ndCB2ZXJ5IGNsZWFuLi4gY291bGQgaXQgaGF2ZSBiZWVuIG1h
ZGUNCj4+PiBjbGVhbj86IEkgZ3Vlc3MuLi4gYnV0IGluIHRoZSBlbmQgSSBlbGVjdGVkIHRvIHNv
bHZlIGJvdGggdjMgYW5kIHY0LnggaW4NCj4+PiB0aGUgc2FtZSB3YXkgdXNpbmcgTE9DQUxJTyBw
cm90b2NvbC4NCj4+PiANCj4+Pj4gRm9yIE5GU3Y0LjAgLi4uIEkgZG9uJ3QgdGhpbmsgd2Ugc2hv
dWxkIGVuY291cmFnZSB0aGF0IHRvIGJlIHVzZWQuDQo+Pj4+IA0KPj4+PiBGb3IgTkZTdjMgaXQg
aXMgaGFyZGVyLiAgSSdtIG5vdCBhcyByZWFkeSB0byBkZXByZWNhdGUgaXQgYXMgSSBhbSBmb3IN
Cj4+Pj4gNC4wLiAgVGhlcmUgaXMgbm90aGluZyBpbiBORlN2MyBvciBNT1VOVCBvciBOTE0gdGhh
dCBpcyBjb21wYXJhYmxlIHRvDQo+Pj4+IHNlcnZlcl9vd25lcjQuICBJZiBrcmI1IHdhcyB1c2Vk
IHRoZXJlIHdvdWxkIHByb2JhYmx5IGJlIGEgc2VydmVyDQo+Pj4+IGlkZW50aXR5IGluIHRoZXJl
IHRoYXQgY291bGQgYmUgdXNlZC4NCj4+Pj4gSSB0aGluayB0aGUgc2VydmVyIGNvdWxkIHRoZW9y
ZXRpY2FsbHkgcmV0dXJuIGFuIEFVVEhfU1lTIHZlcmlmaWVyIGluDQo+Pj4+IGVhY2ggUlBDIHJl
cGx5IGFuZCB0aGF0IGNvdWxkIGJlIHVzZWQgdG8gaWRlbnRpZnkgdGhlIHNlcnZlci4gIEknbSBu
b3QNCj4+Pj4gc3VyZSB0aGF0IGlzIGEgZ29vZCBpZGVhIHRob3VnaC4NCj4+Pj4gDQo+Pj4+IEdv
aW5nIHRocm91Z2ggdGhlIElFVEYgcHJvY2VzcyBmb3Igc29tZXRoaW5nIHRoYXQgaXMgZW50aXJl
bHkgcHJpdmF0ZSB0bw0KPj4+PiBMaW51eCBzZWVtcyBhIGJpdCBtb3JlIHRoYW4gc2hvdWxkIGJl
IG5lY2Vzc2FyeS4uDQo+Pj4gDQo+Pj4gSSBoYXZlIHRvIGJlbGlldmUgQ2hyaXN0b3BoIGRpZG4n
dCBhcHByZWNpYXRlIHRoaXMgTE9DQUxJTyBwcm90b2NvbCBpcw0KPj4+IGFuIGVudGlyZWx5IHBy
aXZhdGUgaW1wbGVtZW50YXRpb24gZGV0YWlsIHRvIExpbnV4ICh0aGF0IGFsbG93cyBjbGllbnQN
Cj4+PiBhbmQgc2VydmVyIGhhbmRzaGFrZSkuICBJJ3ZlIGNsYXJpZmllZCB0aGF0IGluIERvY3Vt
ZW50YXRpb24gKGZvciB2NikuDQo+PiANCj4+IEV2ZW4gdGhvdWdoIHRoaXMgaXMgYSBwcml2YXRl
IHByb3RvY29sLCB5b3UgZG9uJ3Qgd2FudCBzb21lDQo+PiBvdGhlciBORlMgaW1wbGVtZW50YXRp
b24gcmUtdXNpbmcgdGhhdCBSUEMgcHJvZ3JhbSBudW1iZXINCj4+IGZvciBpdHMgb3duIHB1cnBv
c2VzLg0KPj4gDQo+PiBJIHRoaW5rIHJlZ2lzdGVyaW5nIHRoZSBSUEMgcHJvZ3JhbSBudW1iZXIg
YW5kIG5hbWUgd2l0aA0KPj4gSUFOQSBpcyBnb2luZyB0byBzYXZlIGV2ZXJ5b25lIHNvbWUgcG90
ZW50aWFsIGhlYWRhY2hlcw0KPj4gYW5kIHdvbid0IGJlIGFuIGFyZHVvdXMgcHJvY2Vzcy4NCj4g
DQo+IEkgZnVsbHkgYWdyZWUsIEkgd2lsbCB3b3JrIG9uIGl0LiBJZiB5b3UgaGF2ZSBoaW50cyBm
b3IgdGhlIGJlc3QgcGxhY2UNCj4gdG8gc3RhcnQgSSdkIHdlbGNvbWUgYW55IGhlbHAgZ2V0dGlu
ZyB0aGUgcHJvY2VzcyBzdGFydGVkLg0KDQpTZWUgQXBwZW5kaXggQiBvZiBSRkMgNTUzMS4NCg0K
aHR0cHM6Ly93d3cucmZjLWVkaXRvci5vcmcvcmZjL3JmYzU1MzEuaHRtbA0KDQoNCj4gSW4gdjYg
SSBzd2l0Y2ggdG8gdXNpbmcgcnBjIHByb2dyYW0gbnVtYmVyIDB4MjAwMDAwMDIgDQoNCiJTcGVj
aWZpYyBudW1iZXJzIGNhbm5vdCBiZSByZXF1ZXN0ZWQuIE51bWJlcnMgYXJlDQphc3NpZ25lZCBv
biBhIEZpcnN0IENvbWUgRmlyc3QgU2VydmVkIGJhc2lzLiIgWW91DQpjYW4gdXNlIHdoYXRldmVy
IHlvdSBsaWtlIHVudGlsIG9uZSBpcyBhc3NpZ25lZCwNCmtub3dpbmcgdGhhdCB0aGUgcmlzayBp
cyBpdCBpcyBhbG1vc3QgY2VydGFpbmx5DQpub3QgZ29pbmcgdG8gYmUgdGhlIHNhbWUgdmFsdWUg
dGhhdCBJQU5BIHdpbGwgZ2l2ZQ0KeW91Lg0KDQoNCi0tDQpDaHVjayBMZXZlcg0KDQoNCg==

