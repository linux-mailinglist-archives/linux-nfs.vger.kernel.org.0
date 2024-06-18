Return-Path: <linux-nfs+bounces-3991-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D28E90D647
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Jun 2024 16:56:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E04582928A5
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Jun 2024 14:56:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEA5015A489;
	Tue, 18 Jun 2024 14:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="IlU35Y7F";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="aoRNueOk"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C05B2139DA
	for <linux-nfs@vger.kernel.org>; Tue, 18 Jun 2024 14:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718722332; cv=fail; b=I+TdXBVTcrSw+sCMeSY++A2iXkWR+XE6H1qzg7pPNU7t4yNXgRMCKCBBCmS/W9Or/1SIJhgW/mEKbtRRZ3oHUvADo/v/twQsRkzi0FS4yaLXw7sjkad/2QZdOnV2Mk+DBjKz1rxsJfYXBSarCufVvUGLWejPCB8a/tVM/4JlyVc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718722332; c=relaxed/simple;
	bh=EtXqcao76hmtIeD2MTR0ciykJhL3b7n7fw/lEHSRDnE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hOaPzdLIfgF74Hc6BcZAhOMQU2QaLZ2k/uf8TAr7nq1yHhKaIJpRuf/Wpk+3mOYVjL6SVta0Hr5PTTce5f4UtzaXwYEU8y+j/lzg4YyOpWR5oH9aYOGpnRzLs+gR4qmAQHvS2x9U5/KqArPZiMVSXToW8WLfKKboxQN3uzfS4so=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=IlU35Y7F; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=aoRNueOk; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45I7tTY5004288;
	Tue, 18 Jun 2024 14:52:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:content-transfer-encoding:in-reply-to:mime-version; s=
	corp-2023-11-20; bh=qyQgQGojf+Du/OxvQr0m/gdcVSySbmASz3I5uau5/f8=; b=
	IlU35Y7FKMbbmSeGzQhe3LmC1mSXGXm0RVMUZmGfeIjMOFES/ATLDsBvHpjeyvpY
	6s9XRTXIJy3CA9SSlAqNPA19W6hNosLDC07Td2u8yMSXgvmnTksS7e6SXWjs+nnc
	g2ufDrQ8J2cIN/PuHaWAAVdl9cJD73XJwlUk/OMd+e1fzo+ou5aSpqOi0E7ALTtE
	clE+nzLAgZw+2JVWE0430RzBEvYvsuA2BEH6N+8uL7pvsaJb6jgvlcq5udYznXLB
	E/b4YB7PMF4ivY5xBlJ9aY7VrJ9L3AWM0KRSXT5mC83rf519/q6I77T68yK0SngV
	VUNJ029RNJxpn30eYBaVoQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ys1cc52nk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Jun 2024 14:52:08 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45IE7XtP007273;
	Tue, 18 Jun 2024 14:52:07 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2045.outbound.protection.outlook.com [104.47.66.45])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ytp8eh7p5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Jun 2024 14:52:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jeYdtvIavn/Nr5J/63cxgVVCqmYvUaHw+MU3t8GNJzRmBOoMPoXLfhLGhboltkhKLoxtcfaKKn4oHrgEQO5Sja3dvOIk5zBnulEvchmmCg4E/D5XmiMPzhZQa4oHHxjztoYTzcU5Nge0gJnRt9CB/DCtlT8/54ANa3zRqsTxMyq1ldxJMPhLxRFc5qk1QhS9MdvkLMjQWTRT6lA0Bt2S0jMWDFef4ispZKIuA+XFb94VAxlJLf70x408DKQW798EH5lshOOa0llI4Y4yJgDtAGaH3LC8/wbHaDDSiS92UL6wUxOU1V+ozE9BtE6kngn9XnXzbRE94vaZpqHHWWr04g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qyQgQGojf+Du/OxvQr0m/gdcVSySbmASz3I5uau5/f8=;
 b=F5IJZCsSnrPtteM78BeJh1JmicwzS3dKAKLFEueRGT2OEenZ9UJGMNupTIR5VcNE1BucK0lBT+sJ/OiBdpfjd7Gf7DIRO4d4QY5CAQKczaZT82UFw2XNQVDpad8uz2Y8g4Fn1aO76WvlgXRyEbsXpACWQXj9An9jB2U1ZvghzT0Xyhj9gjVXNMTm4M6C65gc2dQGD+VIMIDgOOWhIeo3xbPIdeiyHAurAxkhD/1EDTWRFXVcNzM1zdkhjMnhJchqKKUfjGz7p1ztO6feUNzWA4fqG7bVmg1HwdIqwCENGhB2ipMy5CDQltHQ8diOWpGgGHJgoyye7U4TZeL1/bMTjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qyQgQGojf+Du/OxvQr0m/gdcVSySbmASz3I5uau5/f8=;
 b=aoRNueOkPWo+TGZ7bQL/i0LboSxM3UAghAeiVlPxLfHHAJ9RXM0kuDpCtwDIdojVO3g9QW5bVWDM5rRaP9gQoI2pg4Fmc95ELGyJoTQd3my/8tC+6MEMFOKq5vdAZSVRk07nMNTuQCEDFGLtX019qx0C9k+1apdEwkj4+wdCqO0=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SJ0PR10MB5669.namprd10.prod.outlook.com (2603:10b6:a03:3ec::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.29; Tue, 18 Jun
 2024 14:52:03 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.7698.017; Tue, 18 Jun 2024
 14:52:03 +0000
Date: Tue, 18 Jun 2024 10:52:00 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Harald Dunkel <harald.dunkel@aixigo.com>
Cc: Calum Mackay <calum.mackay@oracle.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: nfsd becomes a zombie
Message-ID: <ZnGfEDvQB1FRGVQK@tissot.1015granger.net>
References: <4c3080af-eec7-4af5-8b0d-c35ac98ec074@aixigo.com>
 <C1CE3A96-599C-4D73-BCC0-3587EC68FCB0@oracle.com>
 <4eeb2367-c869-4960-869b-c23ef824e044@oracle.com>
 <661a6c9a-81d6-46fd-87ec-274100b12189@aixigo.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <661a6c9a-81d6-46fd-87ec-274100b12189@aixigo.com>
X-ClientProxiedBy: CH0PR04CA0022.namprd04.prod.outlook.com
 (2603:10b6:610:76::27) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SJ0PR10MB5669:EE_
X-MS-Office365-Filtering-Correlation-Id: e1bc0695-09e5-45c8-9b2d-08dc8fa63742
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|1800799021|366013|376011;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?aS8reUxkeTFQaEc5Q09BVWllc2E4K1FzTzd0THI5elorN0NrVkZxVCsyODZQ?=
 =?utf-8?B?TzcxV1pmcUdpdE9yYnNjeWs2aVh5RWZNZGsrNEIxYVdRWmtoMFhycy9CV3R3?=
 =?utf-8?B?MDRqMWE2RmJrcVgrSFRISFVxOE1ubVFqL1BMWXVXbnRkVk9jT3dRMmdoTzF1?=
 =?utf-8?B?TTBBR0RZVjVybnR4WDFJRm1MZC9ra1NSZ1g0NjlETzZGUmxlNGRwUE1iaUVR?=
 =?utf-8?B?UmNuYzNqcmh6REpMOExCck5BZmRldlFUeWx6ZzUydlZpSVRDbUIwc0xXTjRZ?=
 =?utf-8?B?M2d6Q3FvT2F5S0t0Rkt4bUJERlp2UnlzdGhRMUlHb3JMU0RMdXFFWWQwVFgv?=
 =?utf-8?B?OUFXd2dQMjhUSGNYQkJnczl2WnM3RUljVU4zRTZMaWMyYU9LT2ppVDRWMjBh?=
 =?utf-8?B?OWthUFBxVzVYZ21aYmdQOHJoVVRxYVErVVpzY1lRUHBvYUViemh1Vm1lVHhC?=
 =?utf-8?B?aFdnWlFERkdXd1FmZk0yOExabXFJZ2ttN1dPS2VtN1JKd3NEVnptNjN4aVNO?=
 =?utf-8?B?bE0wRUpwV1BiQWpDYStqQ2F2M3BHejFseEdVOWNBVlB0VHRZYzZGV1k5a3Bw?=
 =?utf-8?B?VWErWW55cWExQWlVZ0xaVzdoTVZjY1I2bVVPNFNHOFBPc0N3dGdUS1hSTytw?=
 =?utf-8?B?S2Q3TDRSVHV0aG1NajR1NDZtMGhoSWlCZi9FdjBWTGw4ODdJNm5lZnY4NmRh?=
 =?utf-8?B?WWF3T2c3clUzTmJkcndsK1VZeVNGdnJIR3pMTmtXZFdaTVk5ZEpjaXpwTndP?=
 =?utf-8?B?VEo0aEV1blRvZjN4ZkxHSkZHYkNpc0oweDM4dVM0cUtYcEhvbGpWRmVOVFE1?=
 =?utf-8?B?SHRiMVFxSHo5bjhRYWtrWWdqMUJueDFHVmFjNWQ2NUUra1B4dmRlbnB1SFAz?=
 =?utf-8?B?WmcreHhzZTRVbHA0ZVgvOG81VVJJZXpBakdzanFrV1dKOWx4L1JWTm9uSzRR?=
 =?utf-8?B?R3NVVThySEZSZ1NHSlFSKzNKdXRNdWN4OUxKNldHbXRhK2luVlFvMjZibE0w?=
 =?utf-8?B?bXVCZUkxUFVpRWVzZmZiTWlxQVUyT2FPMmRIRC9vVFp4cWg2RjVEUzQvWk9u?=
 =?utf-8?B?cG84d1ZyZ3Y4VjgvcnBEK3gzNnMzNE5Yc0JZM1lCTzR2bGZPL0VQRTdUVFNP?=
 =?utf-8?B?ZUFKWUVVNFd5bG93Rk5pL09QUnUxNENSSm1aaVpwT3NIMmw2bkhzL2dPMGJW?=
 =?utf-8?B?dlA5dEZ2anE0RXBxNGRTTS84VGJuU29qODVEZ3hCRkt5YlZkZUN3Qk1MYjRz?=
 =?utf-8?B?ZHQ5Zk9wUnA5WEQ4a2VPeUZ1cEN1MVZvTmVQaTg0blhCMmM3Vlh5aTZ2RVBL?=
 =?utf-8?B?WEg4c0piMzRsOUNXUDFNaXFaODVuVGF3TVdtbDlIcDVLb3ZDcXpqa0N6ei9z?=
 =?utf-8?B?M2FSRW5QbmdoMER5VmRuc2dTbFBteUtnbk1vMmFKYjZQajlpdVA4aGtBcXdI?=
 =?utf-8?B?cmRtMVVQSXlRelFCZ0FwOGVsNTA3OEZyZW9QaXQ5ZGpEQTVYVG10N0Q1eitP?=
 =?utf-8?B?UmRleUxkWFNDQmxML3RFbmVZSDc3UVpIT0ZUWXcxNnJOUUNsU1c3Y2pjcjhx?=
 =?utf-8?B?c0VxbkZiVUVqdk9uYVc4OEM4cDkzYWpQT2pMSTcyL0UvVDFwZDViSEJUWWZG?=
 =?utf-8?B?VkJqa2xoQzVrMDJvVzdBMkpzUWQxOC9rR1E2RUJuYXdZRXhDKyt6MHJUTWdF?=
 =?utf-8?B?ZzdXMk5ZS2RFM1VXRE1lT2pmVERjUk1vTDMzQVlMUG9FaSszRUZ3QnJsMG5y?=
 =?utf-8?Q?tgxcNS3yP1b+onEjNK6+bSTKfe6vk7PnIGr9TPf?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(366013)(376011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?MnYzM1VVa3NFZWwraFNEUzE3T1NqcEdMdGZMcWFMVUpsbjY4NHlZTUFYcVRq?=
 =?utf-8?B?WVlYUUdRT0djL2piTzh2SENobzEzdkpVMFBLUFFtc2xsNmhQd09rUExSYk5E?=
 =?utf-8?B?UC9VNTRsdmFycUpTeWdHbGNxTzB1ckM0TkhURWdFbVBWbnlPMWhadExVUFdr?=
 =?utf-8?B?Q2Q4SjFkOTJiZ28xVDhQL045NkVxdXY0dzRoei9scERLTDhmQ0NRVEVXQUM1?=
 =?utf-8?B?REdzOWJDRXVOOHNOdmVwOFFxYTV5T0FrZzFyVUhSRzdTdm8zMWc2QXNwZmxG?=
 =?utf-8?B?M0JaNDRhSEV3WGhscTFveXVKWFlaTlB6MERDUUFjaG9oZktGR1o1WVVFWnB5?=
 =?utf-8?B?VmRNZlR2L1dURjdZZFhadFhZM0tkRG54RmlGeGNYTmNQYkZZcVpMVlhrR0JK?=
 =?utf-8?B?YTZUQ2xER0ZYMVpEUmd5RVBZSjFyU3dwL0E0U3Z6QlBpMnRtb1BJSW1GV2tV?=
 =?utf-8?B?NUpKWFVsb3ZDTlJUZ2pEWHVGV1F4OXJ4KzVQU28zRHdJMVBhejhONkpYYXNE?=
 =?utf-8?B?UDYzUTJlTUJLODZVS1A1Y2VnNmF6MGZkUlpQUUNMbzdVKzN1U2FjR0hwZlA3?=
 =?utf-8?B?OFBoZVI4S2xNM3FldHRCYW5tbk9TNVJUUkJONXZReW1NNEFhR2kwQVJuTkxD?=
 =?utf-8?B?bHZjREk4amI3eTJoeTNuSjdiZWRiTmtucmJGZW8zMjBIK2IwY3NzclkyRkxP?=
 =?utf-8?B?dytUQmwyZ01VSmJESWt0ZjZVcFJqOHk1S3YzVXZnTlJ0bmRteW5ZZ0dFSnVG?=
 =?utf-8?B?U1BpT3ByQ2xZM0R3TlNvTEhaRjNKYlhnTzdOSnArMy9YZUl1R2NOeUE5dU1M?=
 =?utf-8?B?cWNreU5GdllXcnRmK3FlSVZwTm5KdGg0K01ibVZFbG5CUndPYlJ2UFZxYkp4?=
 =?utf-8?B?UXFlZDh4YnBsRXNDQVl6STNvR056RU9abWVuQkFrZDdQdlYrakpyTGZjTmJQ?=
 =?utf-8?B?azl2ZFZSakQyVCs4cXVVQjZUOHZZd2gyL0RpRU9xM3lGaUk4VHhxVUlvdG9P?=
 =?utf-8?B?Z3JNSXJwZEwrZW9ZYndnQ0ZTTTgvOXdrQW5xVmE5aTNIeTJObmhlalFsdUNk?=
 =?utf-8?B?eVBIK1pCY1AwSHNRQkdQNzdsNG5wSE02RlljTlRqNTBkaUJWZGdkWUxXbG91?=
 =?utf-8?B?UXdJNkZYK2F1TjF0M1dRZXpoSDJUanNsWTBISStJa0Fhc2FDNFUxdFNZczl1?=
 =?utf-8?B?Rzk3cGg1aG1GN1J4WnNwanN6TUY3TGhKUVhBV3dna3AvUTUyanM1ZW9JUkMv?=
 =?utf-8?B?VUhKVjlIdXkrRmREWGhFd2drZTRVTUQrSVJOTE85MTc4amtrdmh0dE5KRzB3?=
 =?utf-8?B?RS83UlJkOU5NT1pGQlJ1Y0FQYmZYT3V0bUJPcDB5bDkrQTBLeDZ2ZnhvMlNm?=
 =?utf-8?B?TjNGS0hSUHNGL3FPa2tBZ2IreEFKamt4dUdKMWhNa0VJTG5MMUNRV0pLTFpI?=
 =?utf-8?B?aytNQ1pqS283Z2FyN0FKZ0NrenVpQXRzUzlxOHArZjcvajIxbERwd1k5ZzM3?=
 =?utf-8?B?cU9XMVhoYUo1UnZOTDBNVjg5dS94aVU4bmxsMVJTcE5Mc3FSYUo1TG9WY01q?=
 =?utf-8?B?elo5UU1HVjhqa3hYdmFJeEloTTN1R1FlaFNuZkFwaTJMemtvVzFwU0EwY3RG?=
 =?utf-8?B?UWJUd3VBcC9ncnlJL1g1V1F6M3YvdmRKd2IxVjhCUUlmVVFJSWR2TDZCdVRY?=
 =?utf-8?B?RWpYbjVIeGl4aUJJUEVSc2JpYjZVT1pKaTN5RWhXRXJDdzk1K3hCa0FlNDda?=
 =?utf-8?B?SW5OYjZQQkNCd082N0NOL2g5TUh3VDN4RDdhTUFMWW54MHJTNER0SUJzM0da?=
 =?utf-8?B?Z3c1OFpyMWRYZGVRUktONmtZeWRyZkxOYnFUSmtCY3lGOVorajd5eVQydlFq?=
 =?utf-8?B?b2pJK0h6d1dyemRQdENJMXpsd1JJejEyL1NWbW5yYndaQVMvZFNZYUlwWi9h?=
 =?utf-8?B?cWFtVXhiKzQ2NHNaTWVXek0zMFFyTDBOU1hCb3h6cU9DMVpUNEI2WW15MjF1?=
 =?utf-8?B?bGxxNVdOb0ozMlZWekdiQUhYUVcrRzZXU0I1NDdVVVAxeVZUTk8yUmpMRlRz?=
 =?utf-8?B?UlJRaFFDZlpDckZsU1RvZzZhYWVHMEw3YTc2YVpacEdhdlF2SzBobk9Td2Za?=
 =?utf-8?B?NjRBK2VESllmVzI5Um9abVMzT053eHAyaytXbU5VOHpYM1N1Z3YxUWlsUHUr?=
 =?utf-8?B?bEE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	F+aSopemrXWa173DObPP8G686jYOPwhcrkLQFr6jIo36vtre5VHm4ROWgUJGVEi4OYowAOMTgYlzmiUdLcyMJI3AdMfRvUoCjVJGKu8WeqMw9gnYk5JJq/SlYuTRAO5S3kWK97854ycwViR6j1y5bXrykQmNmEJKYcrV4jicR7tsvLEBVkwjTUnOqsIudVbFphvgIicPUFvR3lB6NPtIidI/qHRcA4Bm8XXk7ve3+UbQmQjy7A5ePIdDzPNyln7Re0YxuG4hn6aae5lmc+emmE3rvUJHyrr8S6gfT9ghEkrnj9Qd4/NLFOTfiKEBgoaQNePBCs1GogGc2BRgGkjf4V3xuMW/7AEIq1ZdkPQe6sE77NyRQmDDbEbUeyfb1/fiXUDtpEAQ0saNEqtQGaiREhGZSctYeoChXQ1pmmyHt0Cb/F3JfCr/J68cK+NEaY4gHydpdtlwILWm914R10t9gnGgFInF/sOLoBwIVFZNTsVcLgOHtozmihSuy3IBm8onlCFg1rMWUpPGzxitJpL2hjnoG1ZYXVBWSbIGefOzLj9iFb3Pk5gQrZE2GkBZlXqiLu+XDJ/zVgo6ZS77xtrAj82+ODWIdLNZu1S6NTM8Hjg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1bc0695-09e5-45c8-9b2d-08dc8fa63742
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2024 14:52:03.5354
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wlcTN6RTPdlsdcbdfe/CMQgxWoYoDLzqgYjtjS9Q5sdb5gDyxLYSc++xYwAKytp6V9yid4d9tatW2BC+uFB9zA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5669
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-18_02,2024-06-17_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=999 phishscore=0 bulkscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2406180111
X-Proofpoint-ORIG-GUID: s8bcw5d5DURS88ZrxxkYcAKdBl6iFGD0
X-Proofpoint-GUID: s8bcw5d5DURS88ZrxxkYcAKdBl6iFGD0

On Tue, Jun 18, 2024 at 04:29:55PM +0200, Harald Dunkel wrote:
> On 2024-06-17 21:20:54, Calum Mackay wrote:
> > 
> > Harald: do you have a Debian/Ubuntu kernel version that doesn't see the
> > issue, please? i.e. ideally from the same 6.1.y series…
> > 
> 
> I had migrated the Server from Debian 11 to Debian 12 on Dec 11th 2023.
> The kernel version provided by Debian 11 at that time was 5.10.197. I
> can't remember having seen a frozen nfsd with this version.
> 
> Since Dec 11th I had these kernels in use (all provided by Debian):
> 
> 	6.1.66			linux-image-6.1.0-15-amd64
> 	6.1.69			linux-image-6.1.0-17-amd64
> 	6.1.76			linux-image-6.1.0-18-amd64
> 	6.1.85			linux-image-6.1.0-20-amd64
> 	6.1.90			linux-image-6.1.0-21-amd64
> 
> These are all "upstream" version numbers. The second column lists
> Debian's package names.
> 
> AFAIR nfsd got stuck only on the 6.1.90 kernel (installed and booted
> on May 18th, first time freeze on May 26th). But I've got a weak
> memory in cases like this. I haven't found older kernel log files.
> 
> Please remember that I have seen a frozen nfsd only 3 times since
> May 26th. Its not easy to reproduce.

I can find no NFSD or SUNRPC changes between v6.1.85 and v6.1.90.
Between v6.1.76 and v6.1.85, there are 48 NFSD changes, 8 changes to
fs/nfs/, and 3 changes to net/sunrpc/.

Are there any NFS client changes during the second half of May that
correlate with the NFSD misbehavior?


-- 
Chuck Lever

