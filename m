Return-Path: <linux-nfs+bounces-7096-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9878D99AAEE
	for <lists+linux-nfs@lfdr.de>; Fri, 11 Oct 2024 20:18:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95746284F15
	for <lists+linux-nfs@lfdr.de>; Fri, 11 Oct 2024 18:18:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 752611A2545;
	Fri, 11 Oct 2024 18:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="G7jATiQG";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="t9LT1SEI"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6BEB804;
	Fri, 11 Oct 2024 18:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728670705; cv=fail; b=fVQ9sjh3vdi22i35E/KaeSuSwzwKod+hTmSPDwIv92yNT7dNXubxmfVC6eXgyqyuaFpOOy5GdN3QE/AoJvd82EBTeNknEtFrt+2zTiq0Y8sKDR2FuBz00xRoqk+9O2P9g7FaAvVXaAPdgi5PDO9ONu7C7aSdlsp8fo5/8R7plUQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728670705; c=relaxed/simple;
	bh=ezF3qwjWNu0QktbH57e8/y1iCJKUBGOf/dFOIMthhUQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XmLDCSwxnTNJIkvrYB90IU4+iM/MNKIiHxQYt9817rRW6ZmcopugxewD2rQ8Ga5vRz2N9u0uBdX9pruKRBGdCI5hnb63M4ZvCKX+RFhnoqGKJYIq3l18vcGohhgO/AvYX/WmYBU8ZaFujSO5EoR19eUeDreZYclVxy1LQVPU4qw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=G7jATiQG; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=t9LT1SEI; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49BCpXYg029759;
	Fri, 11 Oct 2024 18:18:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=ezF3qwjWNu0QktbH57e8/y1iCJKUBGOf/dFOIMthhUQ=; b=
	G7jATiQGL+atD+UskSuOIwW/zge1NhzDk/6y6UUzYnrR0SWas8L1yrMP+JhGg5Ex
	e9IVB/QFdair0SCSnEvyG0F9rgQmmwRUNtHDLZL0GKzrLDiT0117z94TWbERyqg2
	I9b1EV27P6zSfRAcc+pyPqWnUL+dPSy/vGs8XK8+pY/d3fcvm4aSQJNsZ9WIvcJ2
	ZtO45LpGd/6ZQDfFmugVT+4Gn0FBTmXPD+sctViWM69B4NEaKJmj3oNrx4MTN5mo
	57Su1srJuhbDoBn+anDRThwhpazI/3AuA8FzzyvIAW4yP5TBXdP2nWhohzD+2FAs
	oZP2EtUfZP6G3wGdf8DmvA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42308dwjs8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Oct 2024 18:18:12 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49BI98EG014654;
	Fri, 11 Oct 2024 18:18:11 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2175.outbound.protection.outlook.com [104.47.59.175])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 422uwbju6q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Oct 2024 18:18:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h0QXJ426OSM/VLByMqZcDB/rrbhgWFSoH4Qk0dI24+PJ7/pUodqH2v39rhvxLzzeugGGlXeMRQI5NSkRZAfqNQHNI98j49U0ieZhy5msEGW4GlugmASV0dZjfKtaVRqQ2KVTVlHl+y2Vqj9BDnBp0/gnsjHEGnzggym5eFCsPoumEOqDSHTRggNzaPLPZLergvUXELBM3TkwS5LGAqyjp0HrNKQAEhw708uaE1S7/Ts9SCRzNSiEKXykuPsPfjmM8ngz18XiBPeZ3sEUCUCdaDOvnJv4ytWnRNJe3UObtmZY+wCjFdmyGBs0e8PWm+6yGSbshWk1QxXBUYKFx8tyaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ezF3qwjWNu0QktbH57e8/y1iCJKUBGOf/dFOIMthhUQ=;
 b=r4S8cYyUotIdskVlsw8fyh2uSaHSYGhd8CGpNJ4QtGVJKPaYw/JeUQWBdXGYyYd9Sk4d09VkcAeCqbUYYLFdNAg30icESjprwZX79OnuWdtvai3h5OVNrgy1xjJD92bbhnKEBa/lzkkImCdyx98vTg8cMquxZKHKAEo0GDdzCEa9ED7UYbuPjYULWhZv+L9SBUcrwt2Rm8OLMOH+JggJix+HONOxUoTfl9PVMj2l1qOEOD+cxTZUKz4ky1ukkzQB+aDbMwYM3X7LLmqtrIiLtIw4rcDOuV041TWgLAIPeQqIrRvKCd+ps+fTJNQ/G5xsqfx5tZJ0z8wMpk2breyNIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ezF3qwjWNu0QktbH57e8/y1iCJKUBGOf/dFOIMthhUQ=;
 b=t9LT1SEIJGJk9nNXM7tR/nsVmbNOWBsi2flF0Qga3/JNcDJlsTWteWppYnganOsntzKr6ISpUYWWOZvyXylFoqTbLCdYtIo1Xh1sd/Pkt8OuIvD8AXH6DHrasDYMb6A7QyKaS+WTWplaqeuOEZ08d4jO1uoDJ75AbYCfM8rGRgA=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS7PR10MB5976.namprd10.prod.outlook.com (2603:10b6:8:9c::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8048.20; Fri, 11 Oct 2024 18:18:08 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.8048.018; Fri, 11 Oct 2024
 18:18:08 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Jeff Layton <jlayton@kernel.org>
CC: Neil Brown <neilb@suse.de>,
        syzbot
	<syzbot+d1e76d963f757db40f91@syzkaller.appspotmail.com>,
        Dai Ngo
	<dai.ngo@oracle.com>, Olga Kornievskaia <kolga@netapp.com>,
        Linux Kernel
 Mailing List <linux-kernel@vger.kernel.org>,
        Linux NFS Mailing List
	<linux-nfs@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        netdev
	<netdev@vger.kernel.org>,
        Olga Kornievskaia <okorniev@redhat.com>,
        "syzkaller-bugs@googlegroups.com" <syzkaller-bugs@googlegroups.com>,
        Tom
 Talpey <tom@talpey.com>
Subject: Re: [syzbot] [nfs?] INFO: task hung in nfsd_nl_listener_set_doit
Thread-Topic: [syzbot] [nfs?] INFO: task hung in nfsd_nl_listener_set_doit
Thread-Index: AQHasSgfq92jO4adGE2aUUYlbrdUmbJCQxwAgAIRoYCAA/UAgIA3Zx0AgAMAoIA=
Date: Fri, 11 Oct 2024 18:18:08 +0000
Message-ID: <2E11BA19-A7FD-44F9-8616-F40D40392AA4@oracle.com>
References: <0000000000004385ec06198753f8@google.com>
 <000000000000b5ba900620fec99b@google.com>
 <172524227511.4433.7227683124049217481@noble.neil.brown.name>
 <ZthtZ4omOnFnhXXr@tissot.1015granger.net>
 <f37c0b837fd947362eb9d5bf7873347fbc5aa567.camel@kernel.org>
In-Reply-To: <f37c0b837fd947362eb9d5bf7873347fbc5aa567.camel@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3776.700.51)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|DS7PR10MB5976:EE_
x-ms-office365-filtering-correlation-id: f88a7ca4-92ce-412a-246d-08dcea210ed1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?S3UvZzZhRmNpZ0Vtd2lLcThveUdjNjAyOHJOdXhBSTM1dHRVTWE5UHNTWFRu?=
 =?utf-8?B?RFlZdmZ3ajJhK3RXclBiTUF1cnMyZW9YUS85NlBpSkZWb1pOSXc1YjE1MEti?=
 =?utf-8?B?NTl0aHBxODBzSDNFTHlWMWxzd0UremRQUXpFTzF2dXRoSWJjYksxN1B3Q1pw?=
 =?utf-8?B?bjBaYXpNK3IwMXFISTZLRUMrOHNBby9sTWkrN0RydTJVa0hrMDJndVFGZVRP?=
 =?utf-8?B?SnRqNE1neDNPVU96YWM5SkRUdTBPdFRkQk9QNmhXMGdlcmdxc2FUMVA5NTNW?=
 =?utf-8?B?TE03djdEYnFNSnNYWkRwRkJ5Slh4a08vOEZSUXh0UVlCSm1rUDdtNm1ORXRK?=
 =?utf-8?B?M3BFeVhvZWFlR2syYnRBckZzYlpwZkVJMmx0RnB0cjU4Y1IzRjlHdWt0cVRV?=
 =?utf-8?B?TlRwSzVITzg2YjcvOFROK29mV3puY3dPendGbjUzaVlDc3g4TWg4Mm44YWVk?=
 =?utf-8?B?QXNHd2FpbVV6THN3dVhxL1cvV0h2NTBDY1BDUUl6aTNwUml6TmZDdzVjOGor?=
 =?utf-8?B?ai9sMG4wOTNGaUFmeDFndmxOblMwVDFOWkozaGl2eWdXMmhmS3E5ZklTVEVq?=
 =?utf-8?B?ZjdSaWp5NXBuekE2c2gzMnQ2TTU1bkpsS2NOV0d2RWQxeVJoTHNZYTQzRHho?=
 =?utf-8?B?U29LaGNOd05ULzI1UTN0L2ZFTy9sK2NXTFV1ZnBVdmZNdGhzZVdwZFBleC9l?=
 =?utf-8?B?RGYyZk13MWE0VkdjUUZlKzRCTFVzT1JTWVQ5VVV2M1ZibFFreVI3N2JlSzNv?=
 =?utf-8?B?M1ZGci9XdHgwN2JhZlEyaDNkSmJXUERDcFFBVWIyY1dyVXFoU1dvcVk2K2gx?=
 =?utf-8?B?YjlQL2JLSFN0Mk9rbTJtVjRaajMrSXpiOHF2dGVJVTBZV0ttWkJxOTBwOGI3?=
 =?utf-8?B?SjNMeFVhMGlaVkVpNVlnaWFHMTY5OTBCSFlxTlEvSThpVmdnVnV2cWUzU3VU?=
 =?utf-8?B?cURWVXJVNXJZejBldWtCeU41eURWbUNMRTlHMWQ2MExxZVpWRUh1c2R5ZVZl?=
 =?utf-8?B?eTNWSDRCdXdlejFHeVJQWXJlWGNEYUdiV0xXU2tiNHJCQitnbmp3MlkzSFRV?=
 =?utf-8?B?Tjh5VEc1dHFPK0xLWkZpQU1BNXRWZnd6T3EwOFgzR2x6YWxqRlBYNnYxckZW?=
 =?utf-8?B?RlpadlZRUTVyKytMUGpoQUEwR3NMMmJkODhTMHN1TFFNUlhBYlZvS3hZcS9a?=
 =?utf-8?B?T0FuanBRSFhuRWZSc3k3SVcydnhTZWRUcEJORlRHT0w3SFVCSU44MDFGWXhq?=
 =?utf-8?B?bzZPTitMY1lhOHpFcmxQd3pZR0xjcXdKc2xuY05oSW4ybXByNEtHajYvb2FM?=
 =?utf-8?B?c1R3b3VUY2txQ3dkYjdyUkJxNDJpOXFyallEdFA5OU92WEUvYXZrZklzMGNv?=
 =?utf-8?B?cXpESk92VTlxdTFxS2lqUWlxQlJYVFR0TGRIWHZRdk1rM2xJRmQwdkoycVlx?=
 =?utf-8?B?dW9RSVg4ZHM4ZWZPZGpVei9IOUlKQ3FIcldISU5kMFMzVE04cG92anFYNDJE?=
 =?utf-8?B?enZSc3ZlNlhwZWI3bU50V01rdHY1VEQzaXEreFJVd0t0anZtbTVWaDlzcHJr?=
 =?utf-8?B?MEhIeTFDdW1jZ3l4Tjk2cDVkMk9peE8zSjB5VHM0MUtNTUh1Z3pCa2V1aVdn?=
 =?utf-8?B?YkxzNW9kRVl3SHZkTXFSY1JqdjI1eGRBcTE2c0V6TUVpUHhTUHVVZ2g5YnVT?=
 =?utf-8?B?Z014NWF3T0lYbEtOVjJTQmJsNlovWDFZWUZGWmpHTGpQYW5XTjNvaE1UMlNr?=
 =?utf-8?B?V1ZSK2M4MWdqc0pNOFZDSGwrWFVDNEU4Ti9YQXh1czdzYitHMlR0L2ZEbThs?=
 =?utf-8?B?VldBWlRrZTVFOXlObmhoZz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Zm1Rb2RVc1RhM2I5a0YwM2hMNmdjTHlNRktYa0tnUmhmRlV6V1orSHlCRU91?=
 =?utf-8?B?R1Y5Q2tzTGw1Z1BITjNPbUdNOWROVmowandSbkQyVmtMWHI5bks5R1RIZTJW?=
 =?utf-8?B?WWV2Mm5CLzdOdE5rWEYwRlYzR21LNno4SzNtQ0xGako1QmhxaUExcUlEcFpR?=
 =?utf-8?B?bFdzb3E5R2JYQzMyR2JuUFUwaUR0eHFnSzdFVVg4TWtmdUwyencrM2dLMzVI?=
 =?utf-8?B?VUM2eFhvRDZZVE4xaWErRG9CVXNURnVoNXdRTEJKSjkrMHBOSXlLNG9OZG1v?=
 =?utf-8?B?UFVNT2FGRHJqaDM4RU40MlExcFpHWERkVGo2R1Z4T1NqRkp4d2Z3YVo0elIw?=
 =?utf-8?B?ejVDU0FXMUg3ZWNUUjMzZXA0S3BrYlA0SEpMd3l4NG9CYlRMUE9URWJ3NERa?=
 =?utf-8?B?TStOWGt4RzRrZjQrSHhrRklMaWdheVo5TTVTRmVlNGkxUE01b2plVS9lMHNz?=
 =?utf-8?B?T3JwL21TOG9zUmJta0FVdkw0L2x2TW1yR1RVTkdPbGJvUktmaFpQbHJaWWlV?=
 =?utf-8?B?d1cxUWlIWXRjWHJjTjIxU252Ylo2S3djaFhaclBEaVVtZUJaaEkwQWFmUklW?=
 =?utf-8?B?T1pEaTBMOTJyMG5WelQ2NHR4WXNmeWs4dTEvRFhvemptMURVYkZqVmJKK1RF?=
 =?utf-8?B?Rkg0aHBvWU5UdEdqNEJPWFQ0Mzd2cDFmd214cStKRzhZUU56NVVwR3VuanQ1?=
 =?utf-8?B?aGF0OWVoS1VnUnhYSVIrZ3g2d0VRQmVWQTBlWWlkZmIzNXNFbjlCWUJucHB4?=
 =?utf-8?B?cGtnbEpvMmE1c2ZSODgyN1hwZHBxdEgxOWF1cmg3SUpHUGJteURLV1NQS0Fj?=
 =?utf-8?B?cDJ6SzhWTGZZWnNrL2V5Z0VpM1VrQzFTYWZpNFFUV2VJMjZzdGJuY3R3dDdq?=
 =?utf-8?B?NFRDL2IyMUxnWmFxU3VnSWtJRG9hVzFDVmRUMm9VM0NUclJ6cE85K0xWMWF5?=
 =?utf-8?B?aUxrc1BQTXJqSFR6YlVvaENMSEhxeXRnZURlc2pqNy9iSjZSeWNtWXVFeXE2?=
 =?utf-8?B?WU5KWFlua092bXBDeHNodURmVGFoQTdkQXJqc2lDRTdFVXBMdE5PWU9LN1FN?=
 =?utf-8?B?R3V2RU43MzQ0VG45SCtaalE0UnJObkhDb1M3bUFmazB4dHo0V2xrMEN4dkZ0?=
 =?utf-8?B?ditXYldvSFNwSmZ6dU8xSHlzMG1rYmxCcjlxNWo5MUJYOGt1K0sybm0xUUIz?=
 =?utf-8?B?c0VGWU94VW1YcFFXaVJhMmJKUHRKR0JtNnBoYnZrWlNtRy9pcHV1VDZ5V3A2?=
 =?utf-8?B?a2srM0ZwVHQ1cHdCS3JjK3RmUk0wWGdiUWJhdXNiOWhOaTJvTC9Ybyt5R01q?=
 =?utf-8?B?OW9SWkIxbEpLdHkwR2x6QlhrNEZBc2J3MTBzelU2MFF1aHhobDA0My9Mclcz?=
 =?utf-8?B?aUR1UkVtcEZiQk16dnN5ampOZzN4b1dSNUo1cjhaOFJaZWl3WDk2c1hzZ3do?=
 =?utf-8?B?V0hxeVYxRjJKdTdvMEZGRFdxOWoxdnhsZGFyNGR3b0xQT1hyandEN3c5YnBE?=
 =?utf-8?B?NWFrTVNDdWNtWlZkZmxTS3dFa0wvK3JwVUEvTllrVk1nMUtJWDlGd1RrTU9Z?=
 =?utf-8?B?c216TGdidnR4K3FpUzRwQmN3YVlUSWFJZEo1MXNZekFvaVlYS0F0VytHSHcw?=
 =?utf-8?B?WTNNUDRmb01BME1WWG9MNEQrNlZSbXJvQ0gwbTZkSGg0YTNFQ29UczBNS1lq?=
 =?utf-8?B?TzVNUVVKRzlYM3Qzc1Q4NW5KTHFkeFVmdlhBRC9jRXFBNUtSeEJlbEVYaWhy?=
 =?utf-8?B?N2szZzYyalUwSWk0M3c0eHZ3N3ZkR3E0OE4wTWlZZ3RkWDNTOENRWnhMdUxI?=
 =?utf-8?B?WCttZS9DT2NhMFZsekhvcjdIWlNqdHp0a0k3NTNkdDJBSmd1QnRhMCtBcmVI?=
 =?utf-8?B?VGIvMnQyMFZOV1I3RGgxeWJ6RE5JREFlVnV5QmQ4dW1OVUphR2gxSk9RVDRS?=
 =?utf-8?B?YlVGUUNZL0EybHk3cmd5QjgrczZ3dkt3RzkrWnZkSjhtdmZINjVlNENUc2tw?=
 =?utf-8?B?ak5WcHZ1eldTQ3NpYkl5QUJmZ3pZUFdIUGVzaFN4NXc0eGRyWEV5Tk5ubkF0?=
 =?utf-8?B?aDBya05DOWlEdE0rWDczbW9wTllUbXFYT1piMVNYSEV4a2NTcE9KcVVHYjh5?=
 =?utf-8?B?eWZzVzE3NjMwN3JPRG45UmJPTitSR2RXc0F1N0h1UHVKbU40SUxOaTZVYWlt?=
 =?utf-8?B?eFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <99F6A2926D238343BDFA99CD5CB809C2@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	OmGhcXWsVxlx2EYb1ZWXPDPOE4drITYN7YNgrcwBCl6WDyOyiMtUbR4dEqADA6xulKkjQDg56zPp1hCrHlwJoNAReG9TUWcSoVsaof4zca/NIjaXnEfhj2KYtmLAbkjf8RJHXwfwnSZ+qM++mZWOPWXvu4j84E5bsypxHtUGcrkw+UrLbii2wJJYRqaeKlfwHZl9PMJ+ngv4/AAJgntsrV+60p2xqnPT0h1cDUfMysrem+EuuM0GsIE4VDl4O5LqvXaiIzlCQteQvCzsVWb/Epbrv9kk8c7nCCW6stfEt9vogLzYNyuTn1Fwa4ovkTsr6BAz03L0B6SDZSg89VXlrAuJ75sANWOdb3aKtWavB4a0GL8KYM3ypRwk7NnrnDV1BCK5nnZ5xMHv2qcfr9HEhSfrWIbzJxOa4oiuSKM8DPXIANc36sHtNuf+ChZNhKbeow/P70BSYBvPl9Lpkl/aXYmQg4dT6yxu0mFCb4gLo8x/2vKHpFIa01ZelnzWHHtdEI5bbQdmJfs6SMbXuVR77lnlkcinPpgjQP1GqQszPG71cmZI6VADZJRbaqtk2iZRG54JswvLl0WBdfvJWvkGF4zp6fPxmjXB2f0m0hBV9tY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f88a7ca4-92ce-412a-246d-08dcea210ed1
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2024 18:18:08.2602
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: em0x4Rsvr8tCELLG864FOZPpbDPaWnHHOr9to3L3VaHvQy/nZ8KQYKy4Ann4T4BkXHgtxkJbT7iIk3+o2OD8WA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5976
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-11_15,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0 mlxscore=0
 spamscore=0 phishscore=0 bulkscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410110127
X-Proofpoint-ORIG-GUID: dY_DomLsiFDz1Aiaxhvz35bALrzjOzaq
X-Proofpoint-GUID: dY_DomLsiFDz1Aiaxhvz35bALrzjOzaq

DQoNCj4gT24gT2N0IDksIDIwMjQsIGF0IDQ6MjbigK9QTSwgSmVmZiBMYXl0b24gPGpsYXl0b25A
a2VybmVsLm9yZz4gd3JvdGU6DQo+IA0KPiBPbiBXZWQsIDIwMjQtMDktMDQgYXQgMTA6MjMgLTA0
MDAsIENodWNrIExldmVyIHdyb3RlOg0KPj4gT24gTW9uLCBTZXAgMDIsIDIwMjQgYXQgMTE6NTc6
NTVBTSArMTAwMCwgTmVpbEJyb3duIHdyb3RlOg0KPj4+IE9uIFN1biwgMDEgU2VwIDIwMjQsIHN5
emJvdCB3cm90ZToNCj4+Pj4gc3l6Ym90IGhhcyBmb3VuZCBhIHJlcHJvZHVjZXIgZm9yIHRoZSBm
b2xsb3dpbmcgaXNzdWUgb246DQo+Pj4gDQo+Pj4gSSBoYWQgYSBwb2tlIGFyb3VuZCB1c2luZyB0
aGUgcHJvdmlkZWQgZGlzayBpbWFnZSBhbmQga2VybmVsIGZvcg0KPj4+IGV4cGxvcmluZy4NCj4+
PiANCj4+PiBJIHRoaW5rIHRoZSBwcm9ibGVtIGlzIGRlbW9uc3RyYXRlZCBieSB0aGlzIHN0YWNr
IDoNCj4+PiANCj4+PiBbPDA+XSBycGNfd2FpdF9iaXRfa2lsbGFibGUrMHgxYi8weDE2MA0KPj4+
IFs8MD5dIF9fcnBjX2V4ZWN1dGUrMHg3MjMvMHgxNDYwDQo+Pj4gWzwwPl0gcnBjX2V4ZWN1dGUr
MHgxZWMvMHgzZjANCj4+PiBbPDA+XSBycGNfcnVuX3Rhc2srMHg1NjIvMHg2YzANCj4+PiBbPDA+
XSBycGNfY2FsbF9zeW5jKzB4MTk3LzB4MmUwDQo+Pj4gWzwwPl0gcnBjYl9yZWdpc3RlcisweDM2
Yi8weDY3MA0KPj4+IFs8MD5dIHN2Y191bnJlZ2lzdGVyKzB4MjA4LzB4NzMwDQo+Pj4gWzwwPl0g
c3ZjX2JpbmQrMHgxYmIvMHgxZTANCj4+PiBbPDA+XSBuZnNkX2NyZWF0ZV9zZXJ2KzB4M2YwLzB4
NzYwDQo+Pj4gWzwwPl0gbmZzZF9ubF9saXN0ZW5lcl9zZXRfZG9pdCsweDEzNS8weDFhOTANCj4+
PiBbPDA+XSBnZW5sX3Jjdl9tc2crMHhiMTYvMHhlYzANCj4+PiBbPDA+XSBuZXRsaW5rX3Jjdl9z
a2IrMHgxZTUvMHg0MzANCj4+PiANCj4+PiBObyBycGNiaW5kIGlzIHJ1bm5pbmcgb24gdGhpcyBo
b3N0IHNvIHRoYXQgInN2Y191bnJlZ2lzdGVyIiB0YWtlcyBhDQo+Pj4gbG9uZyB0aW1lLiAgTWF5
YmUgbm90IGZvcmV2ZXIgYnV0IGlmIGEgZmV3IG9mIHRoZXNlIGdldCBxdWV1ZWQgdXAgYWxsDQo+
Pj4gYmxvY2tpbmcgc29tZSBvdGhlciB0aHJlYWQsIHRoZW4gbWF5YmUgdGhhdCBwdXNoZWQgaXQg
b3ZlciB0aGUgbGltaXQuDQo+Pj4gDQo+Pj4gVGhlIGZhY3QgdGhhdCBycGNiaW5kIGlzIG5vdCBy
dW5uaW5nIG1pZ2h0IG5vdCBiZSByZWxldmFudCBhcyB0aGUgdGVzdA0KPj4+IG1lc3NlcyB1cCB0
aGUgbmV0d29yay4gICJwaW5nIDEyNy4wLjAuMSIgc3RvcHMgd29ya2luZy4NCj4+PiANCj4+PiBT
byB0aGlzIGJ1ZyBjb21lcyBkb3duIHRvICJ3ZSB0cnkgdG8gY29udGFjdCBycGNiaW5kIHdoaWxl
IGhvbGRpbmcgYQ0KPj4+IG11dGV4IGFuZCBpZiB0aGF0IGdldHMgbm8gcmVzcG9uc2UgYW5kIG5v
IGVycm9yLCB0aGVuIHdlIGNhbiBob2xkIHRoZQ0KPj4+IG11dGV4IGZvciBhIGxvbmcgdGltZSIu
DQo+Pj4gDQo+Pj4gQXJlIHdlIHN1cnByaXNlZD8gRG8gd2Ugd2FudCB0byBmaXggdGhpcz8gIEFu
eSBzdWdnZXN0aW9ucyBob3c/DQo+PiANCj4+IEluIHRoZSBwYXN0LCB3ZSd2ZSB0cmllZCB0byBh
ZGRyZXNzICJoYW5naW5nIHVwY2FsbCIgaXNzdWVzIHdoZXJlDQo+PiB0aGUga2VybmVsIHBhcnQg
b2YgYW4gYWRtaW5pc3RyYXRpdmUgY29tbWFuZCBuZWVkcyBhIHVzZXIgc3BhY2UNCj4+IHNlcnZp
Y2UgdGhhdCBpc24ndCB3b3JraW5nIG9yIHByZXNlbnQuIChlZyBtb3VudCBuZWVkaW5nIGEgcnVu
bmluZw0KPj4gZ3NzZCkNCj4+IA0KPj4gSWYgTkZTRCBpcyB1c2luZyB0aGUga2VybmVsIFJQQyBj
bGllbnQgZm9yIHRoZSB1cGNhbGwsIHRoZW4gbWF5YmUNCj4+IGFkZGluZyB0aGUgUlBDX1RBU0tf
U09GVENPTk4gZmxhZyBtaWdodCB0dXJuIHRoZSBoYW5nIGludG8gYW4NCj4+IGltbWVkaWF0ZSBm
YWlsdXJlLg0KPj4gDQo+PiBJTU8gdGhpcyBzaG91bGQgYmUgYWRkcmVzc2VkLg0KPj4gDQo+PiAN
Cj4gDQo+IEkgc2VudCBhIHBhdGNoIHRoYXQgZG9lcyB0aGUgYWJvdmUsIGJ1dCBub3cgSSdtIHdv
bmRlcmluZyBpZiB3ZSBvdWdodA0KPiB0byB0YWtlIGFub3RoZXIgYXBwcm9hY2guIFRoZSBsaXN0
ZW5lciBhcnJheSBjYW4gYmUgcHJldHR5IGxvbmcuIFdoYXQNCj4gaWYgd2UgaW5zdGVhZCB3ZXJl
IHRvIGp1c3QgZHJvcCBhbmQgcmVhY3F1aXJlIHRoZSBtdXRleCBpbiB0aGUgbG9vcCBhdA0KPiBz
dHJhdGVnaWMgcG9pbnRzPyBUaGVuIHdlIHdvdWxkbid0IHNxdWF0IG9uIHRoZSBtdXRleCBmb3Ig
c28gbG9uZy4gDQo+IA0KPiBTb21ldGhpbmcgbGlrZSB0aGlzIG1heWJlPyBJdCdzIHVnbHkgYnV0
IGl0IG1pZ2h0IHByZXZlbnQgaHVuZyB0YXNrDQo+IHdhcm5pbmdzLCBhbmQgbGlzdGVuZXIgc2V0
dXAgaXNuJ3QgYSBmYXN0cGF0aCBhbnl3YXkuDQo+IA0KPiANCj4gZGlmZiAtLWdpdCBhL2ZzL25m
c2QvbmZzY3RsLmMgYi9mcy9uZnNkL25mc2N0bC5jDQo+IGluZGV4IDNhZGJjMDVlYmFhYy4uNWRl
MDFmYjRjNTU3IDEwMDY0NA0KPiAtLS0gYS9mcy9uZnNkL25mc2N0bC5jDQo+ICsrKyBiL2ZzL25m
c2QvbmZzY3RsLmMNCj4gQEAgLTIwNDIsNyArMjA0Miw5IEBAIGludCBuZnNkX25sX2xpc3RlbmVy
X3NldF9kb2l0KHN0cnVjdCBza19idWZmICpza2IsIHN0cnVjdCBnZW5sX2luZm8gKmluZm8pDQo+
IA0KPiAgICAgICAgICAgICAgICBzZXRfYml0KFhQVF9DTE9TRSwgJnhwcnQtPnhwdF9mbGFncyk7
DQo+ICAgICAgICAgICAgICAgIHNwaW5fdW5sb2NrX2JoKCZzZXJ2LT5zdl9sb2NrKTsNCj4gDQo+
ICAgICAgICAgICAgICAgIHN2Y194cHJ0X2Nsb3NlKHhwcnQpOw0KPiArDQo+ICsgICAgICAgICAg
ICAgICAvKiBlbnN1cmUgd2UgZG9uJ3Qgc3F1YXQgb24gdGhlIG11dGV4IGZvciB0b28gbG9uZyAq
Lw0KPiArICAgICAgICAgICAgICAgbXV0ZXhfdW5sb2NrKCZuZnNkX211dGV4KTsNCj4gKyAgICAg
ICAgICAgICAgIG11dGV4X2xvY2soJm5mc2RfbXV0ZXgpOw0KPiAgICAgICAgICAgICAgICBzcGlu
X2xvY2tfYmgoJnNlcnYtPnN2X2xvY2spOw0KPiAgICAgICAgfQ0KPiANCj4gQEAgLTIwODIsNiAr
MjA4NCwxMCBAQCBpbnQgbmZzZF9ubF9saXN0ZW5lcl9zZXRfZG9pdChzdHJ1Y3Qgc2tfYnVmZiAq
c2tiLCBzdHJ1Y3QgZ2VubF9pbmZvICppbmZvKQ0KPiAgICAgICAgICAgICAgICAvKiBhbHdheXMg
c2F2ZSB0aGUgbGF0ZXN0IGVycm9yICovDQo+ICAgICAgICAgICAgICAgIGlmIChyZXQgPCAwKQ0K
PiAgICAgICAgICAgICAgICAgICAgICAgIGVyciA9IHJldDsNCj4gKw0KPiArICAgICAgICAgICAg
ICAgLyogZW5zdXJlIHdlIGRvbid0IHNxdWF0IG9uIHRoZSBtdXRleCBmb3IgdG9vIGxvbmcgKi8N
Cj4gKyAgICAgICAgICAgICAgIG11dGV4X3VubG9jaygmbmZzZF9tdXRleCk7DQo+ICsgICAgICAg
ICAgICAgICBtdXRleF9sb2NrKCZuZnNkX211dGV4KTsNCj4gICAgICAgIH0NCj4gDQo+ICAgICAg
ICBpZiAoIXNlcnYtPnN2X25ydGhyZWFkcyAmJiBsaXN0X2VtcHR5KCZubi0+bmZzZF9zZXJ2LT5z
dl9wZXJtc29ja3MpKQ0KDQpJIGhhZCBhIGxvb2sgYXQgdGhlIHJwY2IgdXBjYWxsIGNvZGUgYSBj
b3VwbGUgb2Ygd2Vla3MgYWdvLg0KSSdtIG5vdCBjb252aW5jZWQgdGhhdCBzZXR0aW5nIFNPRlRD
T05OIGluIGFsbCBjYXNlcyB3aWxsDQpoZWxwIGJ1dCB1bmZvcnR1bmF0ZWx5IHRoZSByZWFzb25z
IGZvciBteSBza2VwdGljaXNtIGhhdmUNCmFsbCBidXQgbGVha2VkIG91dCBvZiBteSBoZWFkLg0K
DQpSZWxlYXNpbmcgYW5kIHJlLWFjcXVpcmluZyB0aGUgbXV0ZXggaXMgb2Z0ZW4gYSBzaWduIG9m
DQphIGRlZXBlciBwcm9ibGVtLiBJIHRoaW5rIHlvdSdyZSBpbiB0aGUgcmlnaHQgdmljaW5pdHkN
CmJ1dCBJJ2QgbGlrZSB0byBiZXR0ZXIgdW5kZXJzdGFuZCB0aGUgYWN0dWFsIGNhdXNlIG9mDQp0
aGUgZGVsYXkuIFRoZSBsaXN0ZW5lciBsaXN0IHNob3VsZG4ndCBiZSBhbGwgdGhhdCBsb25nLA0K
YnV0IG1heWJlIGl0IGhhcyBhIHVuaW50ZW50aW9uYWwgbG9vcCBpbiBpdD8NCg0KSSB3aXNoIHdl
IGhhZCBhIHJlcHJvZHVjZXIgZm9yIHRoZXNlIGlzc3Vlcy4NCg0KDQotLQ0KQ2h1Y2sgTGV2ZXIN
Cg0KDQo=

