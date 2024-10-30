Return-Path: <linux-nfs+bounces-7580-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E74D9B68F4
	for <lists+linux-nfs@lfdr.de>; Wed, 30 Oct 2024 17:16:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6A471F215BF
	for <lists+linux-nfs@lfdr.de>; Wed, 30 Oct 2024 16:15:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 175974F201;
	Wed, 30 Oct 2024 16:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="n9bgZo8b";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="wY/JYYxa"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96C8231A60
	for <linux-nfs@vger.kernel.org>; Wed, 30 Oct 2024 16:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730304956; cv=fail; b=N6vLJP/645h81ncejWnJ5gGDYfQ4sDb09w7+R3mUJGjvof+DjkmthkGFmaFEhmlLCKuT8oYgRRqHHaXbCGciI5sL1CSDoMNUoNm/Wkqn6nWzQA7BfB7k0PulYBEyjr06ZdSWyT+A3hIBVU9qxACrF6WvjyyTJKiM2w8Mfs5qaUY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730304956; c=relaxed/simple;
	bh=hBl/yjDDZcif4LBsZlD62UEujgYEYGS1iuTY3dTHTp8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=H7UD6oy7F/0A2pOrluzzK0wX/By+jT26Zi+I9KOKGsx5VbANAaQlR67kfDCetlaY9fuzGcNWhwhnvj4tQwNmFPti97tygv2Dw2fhbKB9gXuvvJTvEpVdB4e6TDjDnAdOqr7Yh7uyKrPi+WvcIYn3MxvloGb/5QLUBKSHR3Rh/I0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=n9bgZo8b; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=wY/JYYxa; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49UGBalP001645;
	Wed, 30 Oct 2024 16:15:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=hBl/yjDDZcif4LBsZlD62UEujgYEYGS1iuTY3dTHTp8=; b=
	n9bgZo8bhEFiE6sYuAQ/vrA76LN2tOgRpEoleWnmuU6iSsSQRHhV6XiQMLO9F0Dt
	GxmOTF0ncGJScAI4zJQVGfzGrQiD/i75YEGlTxZjRys/T/6ebqIXOYgZT7CInoLX
	O5MeRbD2NaIqLyYMHeSicgMNZ9YkRRsSJbZG7nvhGPnhiLSRCR8SLFcqMthm7t6/
	qUPoj43E8/tOB50MRNJdkHHmRDffLnjkq55xBNMshd/E3mj30fApbOVhy8nMAljY
	8QZTuBy8o1OukQqluC3ss2Q2Y1VDboavn+g1nC+78cG8T1K87ftPLXXGwSvCSquF
	RxK2gXZ2pH+D8sg0kOkXgw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42grdqgbvg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 30 Oct 2024 16:15:51 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49UFuk0K004818;
	Wed, 30 Oct 2024 16:15:50 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2171.outbound.protection.outlook.com [104.47.73.171])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42jb2vx0hv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 30 Oct 2024 16:15:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cniGasfR0xjvgx+GSMYDPIfSQ8zub8IVeGYm1nSpaRyS0R2Ig7d1aG3kiQWxBdr44tSStAdIkIap2cLQCrwyN2gPmugi8GJke+MEsf2qH5FTFh7v9zGQ2OxOxTHzWb21FmDgT9zLYN1l6wQg4Pw7c9F/6jnBDpSihhxM/CyoEdutGzsbRRqPraTOwCWnz3uHoTG9wlVVHtCsGZOD+H6IIHRm/oFW+VWwX/wkN8m0m+Tao5YsJd1JLhZcfQl9chPWAhgM6W7n1gKbl5OaUzRPszXxR0cQdrkb7a/RdiXpnx7BmWIdgRhz8eYBYbeRGlGrL0lvJkdDskJIJ5ZrPuHzvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hBl/yjDDZcif4LBsZlD62UEujgYEYGS1iuTY3dTHTp8=;
 b=NooMyMQhu//vhf7dyYAIa7wcWBQXiS3YRvCpOrENVkv1lGzuir9mLyhViw+D+hmEb7sOxs5/xkfSQbcMhLfLcbS3MocQlpI0lzS9M8tOEjnYO2BhfYvmySaY8t/elJBqH7lkAgJ/ZtPOztnDKWm1x/L4/Mc7TEPqE79CcQB7B7eoUP00gcsanBNI5IMFm6xFaBFiZukqouSrfK0oVYnWTrpylC0zotF9tL4Y6Q//LPzjc3neBQM5FaoFbbN49AmB8WqLf3WY8iy7iLJfpE/ZnaxbkkR2536K4JXYp8jcXtbLrrWFMoSxv6q/rJftPxNerl6N07pdt2iFPazxWjiiog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hBl/yjDDZcif4LBsZlD62UEujgYEYGS1iuTY3dTHTp8=;
 b=wY/JYYxaiKJ1lGH1mQ+yWbpaoCaLi9iHqH/qFmmqlvvrtPsKx2XgcEHxLZ16pmGCeU56DQoL8R8jh0YWvM/OXzNIos4UPwbjg82mHLbWvJM6f3mYi+pczrIUb8kHOltu0bx10HWcbFmqXfrJNJcucB95HH2uUN0f1DnPgyXaa50=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CO1PR10MB4514.namprd10.prod.outlook.com (2603:10b6:303:9d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.25; Wed, 30 Oct
 2024 16:15:47 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.8114.015; Wed, 30 Oct 2024
 16:15:47 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Cedric Blancher <cedric.blancher@gmail.com>
CC: Brian Cowan <brian.cowan@hcl-software.com>,
        Linux NFS Mailing List
	<linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v3] nfsd: disallow file locking and delegations for NFSv4
 reexport
Thread-Topic: [PATCH v3] nfsd: disallow file locking and delegations for NFSv4
 reexport
Thread-Index:
 AQHbJWR3BlJOXtfJrUiYxWPBjvAIV7KdyhAAgAAD4YCAABzbAIAAAnEAgAF/eQCAABZ0AA==
Date: Wed, 30 Oct 2024 16:15:47 +0000
Message-ID: <B67E796E-1539-437C-9F54-091D178E0171@oracle.com>
References: <20241023152940.63479-1-snitzer@kernel.org>
 <20241023155846.63621-1-snitzer@kernel.org>
 <CANH4o6Pi13aEtQW5-vmuJiuCNzx6tjn1+v=pLUpVMuffX-WkPA@mail.gmail.com>
 <7FB2B261-48F9-4DA0-B4B5-E8E30EC31CD9@oracle.com>
 <CAGOwBeX7xw7cPRXGO5RmLQUgzOjqr-7Bh4EhV=hONpXCAqsX-g@mail.gmail.com>
 <91F0EACF-76BC-49EE-9340-AC60F641B8B2@oracle.com>
 <CALXu0UcAw7xkObkVFFTi6d-F69_qrDwf9pTE+8We3k14CvywmA@mail.gmail.com>
In-Reply-To:
 <CALXu0UcAw7xkObkVFFTi6d-F69_qrDwf9pTE+8We3k14CvywmA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3776.700.51.11.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|CO1PR10MB4514:EE_
x-ms-office365-filtering-correlation-id: 8d9c0f5f-efdd-4bde-4536-08dcf8fe1d5b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?UW81Z0c0NGxJaFZYWFRtT0YxSDlWUllYUERMeG1Kb2xsclhkZmZsNGN3a1ht?=
 =?utf-8?B?cTc2c2JMNWd4b2VpVEdoMXc3bmlGVmFUVXRpSDJxN1JjZk5HdE91VEE0a1gr?=
 =?utf-8?B?blJuUXRhdW1FSnpXdy9hYmdUZCs5STN6VDEwMEhwVU5nR3NCOUZqMFhaRGpI?=
 =?utf-8?B?VW1QVE1JR1BjVFVrSHpZVi9UT1RMWFRLcFJoS01BUmhVN2Y2cnhWMGVSd3dQ?=
 =?utf-8?B?T0RSUkVZRGVRWmZKek1nUS9XTkdsUUQybmFFbDY0cHoyNnJwMXMzSHdwd1lm?=
 =?utf-8?B?WUN3anA5UXBkY3ZROTJseTRDWWJ5RHJZZ1R0NXF0ZFplTkpCK1RZZ2d3eSsr?=
 =?utf-8?B?WVB4MDUwT08zMExEaE5ISjhYRndCWEpuMmZhYmRiTDl5S3h1T0xpSytKam44?=
 =?utf-8?B?REVoSjMxalJCQXJnaTV1NHFpWVBXcm1uUU5Tcm5rOHdPOFVic3dmQU5RTWhr?=
 =?utf-8?B?U3g1YWllRzh0cUw2OGZkWVdPck9lVnlSS3NzRVVubEhUOG5xN1kxbWlFTHRH?=
 =?utf-8?B?OHRkeWgwYUhNdEl4TGdsMlk5VG9ObkllcFFWN1hNeVAvanZOa1MwTmEwUjl6?=
 =?utf-8?B?VUY5cjEwNHVNTGdqVlZmVlRSSFQ1S0NjOHdRTmJSaXFxMXFBa283SUdtOUd1?=
 =?utf-8?B?YzF3S1ZlbTVmOEpYWCs5Qm9jOGp4ait2dlBCNmxNd0ZGT1NZcndUNWJHL1Rz?=
 =?utf-8?B?aEx3ZFJQazZEVmFoUkJybXF3MmJDQjJjSzZQaWNpU0ZmUDRsUExEY1NPRG1H?=
 =?utf-8?B?bGlhUm9PeVFCMVBtMkNGYVRZTFJFRHZySWhXR0NVTlJabEF6T04yeGtkVUxw?=
 =?utf-8?B?VzNiZjJWV3VrWWFKTjdETDJ5OExHL2hjNGRYVlExam1BbENsOTRNYUlQWU9T?=
 =?utf-8?B?N1d4amE0dGJYZXBESVZtczBIdnVmSkdXNUxjVFF0amJzVC9QNXNEZlJYcW9w?=
 =?utf-8?B?RTlkVkpLM0xIY2FOYmhJTHFsbkZxVXlSTk1IWDB5SkxpVGNBbWpDT25IMVA3?=
 =?utf-8?B?VXVyQjAyeTJUUVV4N0x3Y2t2WUp6WVVzMVF0NThLeWdSek1WQlhDMk9udEU2?=
 =?utf-8?B?cHBxNnRGeTFjZVZKNGtSYlBxRC9IdjIwbDNiZGcvWERtS3hLSjc4M0dSaFFT?=
 =?utf-8?B?TndrTUU4aExHV2R5KzYzT2ZUci9nMERRNFFwRFlTZzVFemJGdDhlUHNUM0kx?=
 =?utf-8?B?bWx2aytaeEdEZWlKUGJGdmVraXVHUUdSWmhEWk1za1BkYXhiVnlVZklIWjFE?=
 =?utf-8?B?NEw0ZFhFWlQ5N2RvNGxZWGZMUEU0a0svSE9DVFl3VkRJWDByZm1XYy9BQ25u?=
 =?utf-8?B?VitSSzd6OExORVlHZUwrbVQzMEM3SXJLWlJrTzB1S2dtRTlCZ1BnK1p1ZkpM?=
 =?utf-8?B?VXZheklTR1pNM2R4SWE2MEdqZGJnK1hZa2pkS2NBTG5RVlRhZXJLRFBVd1dq?=
 =?utf-8?B?TjRoVnVLNXZBTmRTQ1I3Q2hRcEtScm9pU2VtS1lGQWdsTkZMVkV0N0RxaS9o?=
 =?utf-8?B?RXhTK0h1NTZ0RzFrWU0zRXh0Y1FGcHZxa0RFZ1JPRlQvQWR5UENnZ1dJRzAz?=
 =?utf-8?B?b0RuQ1JKeitxdldaeC8vUmw5YTRmVk9aRm5PTzVjdnkxa3AzNWlKZXRZajdT?=
 =?utf-8?B?VTVJOHVkbnduNms0MFVBZ3JlbmExTktoVE9kQ1dDZ3FVTk50TFU0dGQzck9o?=
 =?utf-8?B?U1EyNmpOUUNvdkpCM0tHZDFkcUJ5b2JzN3lNNldCZThsVVkxckpmSHd4K0lC?=
 =?utf-8?B?d1N3Nm9tS2JNRzhHTEwwWWx3eWZYZmVNRDdYTDhodk9XSXl2ZGdBaE1pNDBL?=
 =?utf-8?Q?mfTWPwSA2x5b5BuACrWwz+k+vLf20+GZ0sSrA=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dm1zZzRYUHhBWEtqbXZycTJHNHYvSllFUDJkaklZeGwzNmVZMnljWkd2RzlU?=
 =?utf-8?B?NFdIcFhlZm95SEZDSFEyUDUzeG1HUmJHRDhTblRlY3R3OURvNnZOdklGQXV3?=
 =?utf-8?B?NkFnanF6ZW5BbWgxSzBiSVNDN2RqSEpMNTZPd1dvR1p2OGZ0ZmFjL3pxQW9J?=
 =?utf-8?B?RzdxZXlhbkV2UjMrL2NGeHNsQS9BYWpzekszK24zR1ROdjcycFY1SGtmRmYx?=
 =?utf-8?B?aFQyb0hReWI5YmdBbkN1WE1ISFIwTDR4aHkrNDlYNXM0STBDcnZDYWY3b3Jx?=
 =?utf-8?B?bTRZVDl4YTVVZWRsdlVkbnp1RHBDR3EybDJkLytKaEFvWkJnTlJpdEhhSVQ3?=
 =?utf-8?B?UU83b1c3Y0NWeUlSdUZNbTBub2dQbktVYmFYSW1mOGRsTmxHd05LSGF5UWkz?=
 =?utf-8?B?Z3BaZ3IyMyt4aXFTQjNOODR4VDkzSG5Xd3dnTHM3eEYzQ3pZaGRnSXVGNFdN?=
 =?utf-8?B?WWEwZHkyMkhHVHlNOUY4RjBDSTBxTmJkUjdDODlKL3hhZ2pNNy8yaFJYSmp4?=
 =?utf-8?B?N3haclpCSDU4VkJWaEU4dmswRUxzSTI4b01vc0JmaTFIeWhzTUFkMlZMNEdq?=
 =?utf-8?B?bys0V0J5MXk1bllvdXp1dkFINWlDT0EzQTk2MFc2T2JSSkdGZUtuY0w1d1RT?=
 =?utf-8?B?RkRobXVWUFZKcXdLNWFwOE85eU83d1RYVnhaMGFMTUdRZ0JPQS9oU3E0L1Ju?=
 =?utf-8?B?VHBoOFJKY1lqZ3pZSXU4U2thcXN1MkdsZ1Rid1k0d1hjUVExVy92c0VQT0l6?=
 =?utf-8?B?cE1zWkJ4YnNMcW1RNjJkUjVTeGNia2pYQ0w1cHd4WHdoQUx6ZnBlYkpYTkM0?=
 =?utf-8?B?L25JSGNHditQbXljYWJGUUtCMXdpRDBjNW1YQnN4L004VzJWOXgySUkzK3V6?=
 =?utf-8?B?Y0RGbFQwOTNlVWQrSUpkU0xMRjBGbklMeHJHMUJqd01HR0pvV28zZG1GMGlH?=
 =?utf-8?B?MkZreXgrMVFhaElRVTBRSmhKUzZqbnZxbzlDa3FVZ0JlMVIySkJaTlByejdU?=
 =?utf-8?B?RW13SGxWamsrSktYRFdXZnhRdUEyd2VaRWhKS2JYWmJZeUJTeFlBS1ZSc2lO?=
 =?utf-8?B?L3J4MnV1QzFISVNWNmRmL2pUS1J1T09HaldQTlpabTRleUJIL0hIZGtCWVFX?=
 =?utf-8?B?RWxWL1lvYzNhaHdvenV1QTM0UFA3WFBxOTA2WUd1SDRSU0ZiSzA2MVNMUnUy?=
 =?utf-8?B?Y1hJNDBQeURBdjZzWmhVZ3RxWEljTklFMGtMcU1CdTN6WFkyZDdnYnliMXcr?=
 =?utf-8?B?aGVqUEdQMStsTGtLUndyT1M4L3FlVXo4QWduaml6STlOcUlCbTZMdXBMYkxu?=
 =?utf-8?B?c3pDVlIvRHVreEptWVo4eWZQbFJPK0pML05uYW9mdEcySEM3aFVpSG1KM0VT?=
 =?utf-8?B?VDE0Z05CWVlkWXZYRUgrY0NPWmZKeVlQZ1FIQkJNeE52UGc5aUkrRnJ0Y0tq?=
 =?utf-8?B?MHBWT2pDbEZOM25aWk9IUUtxVHBtMUorK2loU3lKK1pNaXU2K2tuZUFaSjFG?=
 =?utf-8?B?VU1EWUxnU2hHZzQ5L1BzaHJJYXM1dTdtK3V2M1paaWcvcFcyS1didmZQMkdQ?=
 =?utf-8?B?SzRtZkQ5NU9VOWo4SnNaUDhyelBVeE8zUHlFMVBsb1hlcnB2WUViSVMrZTc2?=
 =?utf-8?B?STQzUFg1cWQ1cFJ3RndXYTIxczVNQ29JVXdrOXFhSzhSTDc2ZFRhbTM5UDRH?=
 =?utf-8?B?MWxJS2UwT0c3RzhRVHNMSXhLVmFEUkpZenQ0N2pHdFJxN09YY21wQW1ISnZj?=
 =?utf-8?B?d2NLV05SMDdIcVcxL3Z5SVlrM1N3cENrZVhjaktaWGh0Q1czMFkzRTNPMXVT?=
 =?utf-8?B?VXd5Rzhpb0dkYVpLbFJ5Y0w4M2MrTFdXZG5EWlFCVTZEbjNFSXo2L0NJWFFH?=
 =?utf-8?B?Q2pSTXcvekR2VzBhdFV6NXJNTUJQRlRRRnY5czdvVGVTMUZlN3ZiN0dvVW1K?=
 =?utf-8?B?SVlPR0FoVUNoNWdiS1E1U0JkYmNTVHhyQlJjV2ZUZFhvTnRjbitOb3Jva2Jz?=
 =?utf-8?B?Zng5dGhnSEwveUkycDRmNUpIR1dCejgzMFZBcVpyMzhmWW55RC9mQmZBQW9z?=
 =?utf-8?B?L1BBME95RHo3bUNIbG9aMDRuczNPZlUycks3Z2xWZjR5eTQwZkpYRm5uRnMz?=
 =?utf-8?B?WGRWcnhXZFN0WGQ1UXBMcnZmUXNGV2Z3bnRSY1l1c25XeG9Pekxma0FTM1JK?=
 =?utf-8?B?M1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F598E059ECFB244781421D58E0321253@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	QmltgIB6TqvEU7M47XOzVLkuhRAB9DOaZQrYcPqYbWGdbQ0p4tOgPI8JALH8eZZmGvOiItnJIMtytmy9Yv31v/xnv09AtX8lSS3u/A/QIrxyAyC9XGzY+k35xooBY2cRdvNtzhnzFn9TRSV4bejHipVxee0g0PjA5bwJ7X6pJVlvLgKudOSe0o6DAgkpwhrCAthYnyLDTcIGjwi9TXPJYl59GvXrVxhkVYOeawirQBzQ3FyU0nPUsSdKq4mZ74oPKTBQm6ONidc2335i1IZPEKEJ+4l5UYzvELHiiUUioLLoa2bfsydMQkc/uveNLczwE3d+mS+UDfMYdH1Sf+p8Y0C7UnF2pJ7AE2rRI/qlI2FtjlUzS/u0L6LWKF5hGtrUMVwkxjnhUwx/89KtYNdIq3RwCrgehbVab+bmQU2JdMvRQdAe/boPUklpEs9Q8O9APBIxNe0yY2GABLq/2OUtXgfLpVjRqveXjclHsrbSRM9uenmk9a3l2p+ikJE3MChKDCtVWVB5ePAwsmAvcp/8dRRkNMROVsIHhosADXY2iMetQWDs1+xBR33DA8gvDr9FF9g7olnE3mxYMhyqgItHd/LkbNBez5GYtd9PHJTEsmE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d9c0f5f-efdd-4bde-4536-08dcf8fe1d5b
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2024 16:15:47.7584
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4mJvFhCDJbMVkfeYYX9V174j2Ytj2w+B2OuqCNxzR+s1HA1+LA0s5tf4hXhOEEMlPrssbK5EGWjF6gQOrWApgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4514
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-30_14,2024-10-30_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 bulkscore=0
 adultscore=0 phishscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410300127
X-Proofpoint-GUID: 7oDzkvqbt0Oplpu9qLBrKgBtVIBvV9zM
X-Proofpoint-ORIG-GUID: 7oDzkvqbt0Oplpu9qLBrKgBtVIBvV9zM

DQoNCj4gT24gT2N0IDMwLCAyMDI0LCBhdCAxMDo1NeKAr0FNLCBDZWRyaWMgQmxhbmNoZXIgPGNl
ZHJpYy5ibGFuY2hlckBnbWFpbC5jb20+IHdyb3RlOg0KPiANCj4gT24gVHVlLCAyOSBPY3QgMjAy
NCBhdCAxNzowMywgQ2h1Y2sgTGV2ZXIgSUlJIDxjaHVjay5sZXZlckBvcmFjbGUuY29tPiB3cm90
ZToNCj4+IA0KPj4+IE9uIE9jdCAyOSwgMjAyNCwgYXQgMTE6NTTigK9BTSwgQnJpYW4gQ293YW4g
PGJyaWFuLmNvd2FuQGhjbC1zb2Z0d2FyZS5jb20+IHdyb3RlOg0KPj4+IA0KPj4+IEhvbmVzdGx5
LCBJIGRvbid0IGtub3cgdGhlIHVzZWNhc2UgZm9yIHJlLWV4cG9ydGluZyBhbm90aGVyIHNlcnZl
cidzDQo+Pj4gTkZTIGV4cG9ydCBpbiB0aGUgZmlyc3QgcGxhY2UuIElzIHRoaXMgc29tZW9uZSB0
cnlpbmcgdG8gc2hhcmUgTkZTDQo+Pj4gdGhyb3VnaCBhIGZpcmV3YWxsPyBJJ3ZlIHNlZW4gcGVv
cGxlIHNoYXJlIHJlbW90ZSBORlMgZXhwb3J0cyB2aWENCj4+PiBTYW1iYSBpbiBhbiBhdHRlbXB0
IHRvIGF2b2lkIHBheWluZyB0aGVpciBOQVMgdmVuZG9yIGZvciBTTUIgc3VwcG9ydC4NCj4+PiAo
SSB0aGluayBpdCdzICJzdGFuZGFyZCBlcXVpcG1lbnQiIG5vdywgYnV0IDEwKyB5ZWFycyBhZ28/
IE5vdA0KPj4+IGFsd2F5cy4uLikgQnV0IHJlLWV4cG9ydGluZyBhbm90aGVyIHNlcnZlcidzIE5G
UyBleHBvcnRzPyBIYXZlbid0IHNlZW4NCj4+PiBhbnlvbmUgZG8gdGhhdCBpbiBhIHdoaWxlLg0K
Pj4gDQo+PiBUaGUgInJlLWV4cG9ydCIgY2FzZSBpcyB3aGVyZSB0aGVyZSBpcyBhIGNlbnRyYWwg
cmVwb3NpdG9yeQ0KPj4gb2YgZGF0YSBhbmQgYnJhbmNoIG9mZmljZXMgdGhhdCBhY2Nlc3MgdGhh
dCB2aWEgYSBXQU4uIFRoZQ0KPj4gcmUtZXhwb3J0IHNlcnZlcnMgY2FjaGUgc29tZSBvZiB0aGF0
IGRhdGEgbG9jYWxseSBzbyB0aGF0DQo+PiBsb2NhbCBjbGllbnRzIGhhdmUgYSBmYXN0IHBlcnNp
c3RlbnQgY2FjaGUgbmVhcmJ5Lg0KPj4gDQo+PiBUaGlzIGlzIGFsc28gZWZmZWN0aXZlIGluIGNh
c2VzIHdoZXJlIGEgc21hbGwgY2x1c3RlciBvZg0KPj4gY2xpZW50cyB3YW50IGZhc3QgYWNjZXNz
IHRvIGEgcGlsZSBvZiBkYXRhIHRoYXQgaXMNCj4+IHNpZ25pZmljYW50bHkgbGFyZ2VyIHRoYW4g
dGhlaXIgb3duIGNhY2hlcy4gU2F5LCBIUEMgb3INCj4+IGFuaW1hdGlvbiwgd2hlcmUgdGhlIHNt
YWxsIGNsdXN0ZXIgaXMgd29ya2luZyBvbiBhIHNtYWxsDQo+PiBwb3J0aW9uIG9mIHRoZSBmdWxs
IGRhdGEgc2V0LCB3aGljaCBpcyBzdG9yZWQgb24gYSBjZW50cmFsDQo+PiBzZXJ2ZXIuDQo+PiAN
Cj4gQW5vdGhlciB1c2UgY2FzZSBpcyAiaXNvbGF0aW9uIiwgSVQgc2hhcmVzIGEgZmlsZXN5c3Rl
bSB0byB5b3VyDQo+IGRlcGFydG1lbnQsIGFuZCB5b3UgbmVlZCB0byByZS1leHBvcnQgb25seSBh
IHN1YnNldCB0byBhbm90aGVyDQo+IGRlcGFydG1lbnQgb3IgaG9tZW9mZmljZS4gUGFydCBvZiBz
dWNoIGEgc2NlbmFyaW8gbWlnaHQgYWxzbyBiZSBwb2xpY3kNCj4gcmVsYXRlZCwgZS5nLiBJVCBz
aGFyZXMgeW91IHRoZSBmdWxsIGZpbGVzeXN0ZW0gYnV0IHdpbGwgZG8gTk9USElORw0KPiBlbHNl
LCBhbmQgYW55IGZ1cnRoZXIgY29tcGFydG1lbnRhbGl6YXRpb24gbXVzdCBiZSBkb25lIGluIHlv
dXIgb3duDQo+IGRlcGFydG1lbnQuDQo+IFRoaXMgaXMgdGhlIHR5cGljYWwgdXNlIGNhc2UgZm9y
IGdvdiBORlMgcmUtZXhwb3J0Lg0KDQpJdCdzIG5vdCBjbGVhciB0byBtZSBmcm9tIHRoaXMgZGVz
Y3JpcHRpb24gd2h5IHJlLWV4cG9ydCBpcw0KdGhlIHJpZ2h0IHRvb2wgZm9yIHRoaXMgam9iLiBQ
bGVhc2UgZXhwbGFpbiB3aHkgQUNMcyBhcmUgbm90DQp1c2VkIGluIHRoaXMgY2FzZSAtLSB0aGlz
IGlzIGV4YWN0bHkgd2hhdCB0aGV5IGFyZSBkZXNpZ25lZA0KdG8gZG8uDQoNCkFuZCBhZ2Fpbiwg
Y2xpZW50cyBvZiB0aGUgcmUtZXhwb3J0IHNlcnZlciBuZWVkIHRvIG1vdW50IGl0DQp3aXRoIGxv
Y2FsX2xvY2suIEFwcHMgY2FuIHN0aWxsIHVzZSBsb2NraW5nIGluIHRoYXQgY2FzZSwNCmJ1dCB0
aGUgbG9ja3MgYXJlIG5vdCB2aXNpYmxlIHRvIGFwcHMgb24gb3RoZXIgY2xpZW50cy4gWW91cg0K
ZGVzY3JpcHRpb24gZG9lcyBub3QgZXhwbGFpbiB3aHkgbG9jYWxfbG9jayBpcyBub3QNCnN1ZmZp
Y2llbnQgb3IgZmVhc2libGUuDQoNCg0KPiBPZiBjb3Vyc2Ugbm8gb25lIG5lZWRzIHRoZSBnb3Yg
Y3VzdG9tZXJzLCBzbyBmZWVsIGZyZWUgdG8gYnJlYWsgbG9ja2luZy4NCg0KDQpQbGVhc2UgaGF2
ZSBhIGxvb2sgYXQgdGhlIHBhdGNoIGRlc2NyaXB0aW9uIGFnYWluOiBsb2NrDQpyZWNvdmVyeSBk
b2VzIG5vdCB3b3JrIG5vdywgYW5kIGNhbm5vdCB3b3JrIHdpdGhvdXQNCmNoYW5nZXMgdG8gdGhl
IHByb3RvY29sLiBJc24ndCB0aGF0IGEgcHJvYmxlbSBmb3Igc3VjaA0Kd29ya2xvYWRzPw0KDQpJ
biBvdGhlciB3b3JkcywgbG9ja2luZyBpcyBhbHJlYWR5IGJyb2tlbiBvbiBORlN2NCByZS1leHBv
cnQsDQpidXQgdGhlIGN1cnJlbnQgc2l0dWF0aW9uIGNhbiBsZWFkIHRvIHNpbGVudCBkYXRhIGNv
cnJ1cHRpb24uDQoNCg0KLS0NCkNodWNrIExldmVyDQoNCg0K

