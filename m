Return-Path: <linux-nfs+bounces-7530-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B414F9B31BF
	for <lists+linux-nfs@lfdr.de>; Mon, 28 Oct 2024 14:32:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 440761F2262F
	for <lists+linux-nfs@lfdr.de>; Mon, 28 Oct 2024 13:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FCCF1DBB35;
	Mon, 28 Oct 2024 13:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dywRlbfU";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="M9DlWG5F"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 529AF185B58
	for <linux-nfs@vger.kernel.org>; Mon, 28 Oct 2024 13:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730122359; cv=fail; b=a2e/kaX0b9ZYYuZ8ES1ORO9q5IinjCMVFdVM0GTH3n38yYBc7WbKjLzR5wvbEXjWEs1WUE5rCySq16XbDtRF+pZbi5dscm1xUBm11H70T6ONijR+33LSp/60TAHPRDAlmdXamhqrUb0J0Wui8O/RfwjMp8RHICne4+zbDJFeYQE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730122359; c=relaxed/simple;
	bh=xRb1JlWVYvZZPqrN11smeEBTQyrnBnifXenGvK1HFn0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WO43TM/yA9nN3eRhP0HGBd3KetA47WbU5kN8usCKqQkA/wMGpo0G2V+oAdo46lSJ9Xly+yR29Z7mvVKPG4zka6gOa91Wz9YweIkoZjKlFffXlG1uWXDpGXaIu2mRgnhuH5ay/brEdKwLVAKtSVbFUS+s8y0cKVAw6v1aMwTbQlQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=dywRlbfU; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=M9DlWG5F; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49SBSgGo019758;
	Mon, 28 Oct 2024 13:32:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=xRb1JlWVYvZZPqrN11smeEBTQyrnBnifXenGvK1HFn0=; b=
	dywRlbfU7fXORd7+WLfSFQmq0pfJZa5KDMKSzjb0eMmOML1SqVUHkTvQfen/KlFm
	/goOyh+WQYZO3qGj+i7aQs76/lhkqRYyAPZWVBq23IvBnKNoLxxlC1NNGpsQy/k5
	4qS33rQaRUwcJxg+TJZtb+7LkqG8IMVLX3d6Y0NPRTxFjPu5g1f73GHGni0gjdDN
	x6vV6Iq3kMviepyZxcKKKdTfWozuzx+Im4KLYnCIZ0mP9hz8yi+hq+/BbeOrUea+
	z/1jojZ38UQuYaCT6+C3SR8ZQheMi7RDoJ6I58JnxKXyXXW0/xkF6WD+g4JBN/jF
	65pnLsZ8/ZAcwQ2Ih62/6Q==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42grgwatc3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 28 Oct 2024 13:32:30 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49SBg3Dx008465;
	Mon, 28 Oct 2024 13:32:28 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2175.outbound.protection.outlook.com [104.47.57.175])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42hne7w25p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 28 Oct 2024 13:32:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zJSAvehOoxjO2GGIFafAGL5y/3uQzaTqJOwiDfIz66xbSAXDJRf7HlNY8KIxo/PKvriVRhrVXbWBJF3bEwews64X/fuzj5+xGQmcjqOv8GZwNQbHLlfkKo64kg64bzXQbC+2NLvNZIrvftg+gN0WsXkCrOd3eUib22TjwmRcYws7/OKG06VMdSTLd7cu97HmsPV4GByfu9n/jK9ryOHwDJIsYQQ+B5GpUaW0jC+LgIoSNBJdE5MD8MTaebZTC0taSHrAzdMb6Jhu9ZltcTWENztxxoNMLxGOrAFvh59eR4dRkX1doXjc2koujK+dSahZwG2giPqHzw1IhdQh6ADoFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xRb1JlWVYvZZPqrN11smeEBTQyrnBnifXenGvK1HFn0=;
 b=gksIAK6PdFoMHX8zTXAsOjIvgBFL3WaFS0iIHAmlC1KiPesFEl2MCVogRodvJBWTeLIcKLa91nbtaQrUaXVFuxWl8RGxyqBb8hCBjlYUXTXVjwWK9VCFVZAW/Fj6Br3Zb6qwNE4f2tAqGI0znnPvbomWY9Q1SdfiqVurPdj4trf/3R671/26hKRmZ63I/OUW2ErZvUdvJx9wHOmFgX8GGXdPIqfPcovbuEyW+xmWKjfVHQ/RZYCdkZlYtVAeDLfS55BlWd5ZY6Ogl7ypOBSeE0Xvr3LHEMymbRNekvu5u34BmbTknZHgSEdb4hCfnwxZMYj+IaqrNfFIzcJEgzWEJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xRb1JlWVYvZZPqrN11smeEBTQyrnBnifXenGvK1HFn0=;
 b=M9DlWG5FHL9+7gDHuewJmgz5C+s/Td5+NCRG85wZWdl5H0aliNzoJV5FPimCxJ+9bxtGnY3tN53MXo5gBnDMla0uzkNhyK+kyqIF64jwhh5q2i9JQSkWPtr2gzoHl7mSG8VxVVP8YFxoupnZrAq/B4iNEHPrv9a6Y+Ln7y+p7JM=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SA1PR10MB5822.namprd10.prod.outlook.com (2603:10b6:806:231::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.25; Mon, 28 Oct
 2024 13:32:25 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.8093.024; Mon, 28 Oct 2024
 13:32:24 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Tom Talpey <tom@talpey.com>
CC: =?utf-8?B?QmVub8OudCBHc2Nod2luZA==?= <benoit.gschwind@minesparis.psl.eu>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: nfsd stuck in D (disk sleep) state
Thread-Topic: nfsd stuck in D (disk sleep) state
Thread-Index: AQHbJYK14pQYtaETsk+otR7Z0qMSDbKUu0MAgAcuXgCAADo0gIAADL2A
Date: Mon, 28 Oct 2024 13:32:24 +0000
Message-ID: <1DC866B1-323E-4CB0-B1E3-E694FE665D32@oracle.com>
References: <1cbdfe5e604d1e39a12bc5cca098684500f6a509.camel@minesparis.psl.eu>
 <4A9BFCA9-7A15-4CA7-B198-0A15C3A24D11@oracle.com>
 <f7aec65eab6180cf5e97bbfd3fad2a6b633d4613.camel@minesparis.psl.eu>
 <509abdda-9143-40da-bbf2-9bfdf8044d4c@talpey.com>
In-Reply-To: <509abdda-9143-40da-bbf2-9bfdf8044d4c@talpey.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3776.700.51.11.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|SA1PR10MB5822:EE_
x-ms-office365-filtering-correlation-id: 20f4dad1-ee3a-42f6-8448-08dcf754f58e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?TVVIOUFSWkhwdDRFem50bXZ6a2F3MjIvZm4zYlZFMlJCa3ArWmpUSkVjNVRS?=
 =?utf-8?B?UzlnZXAzWmxja1RRbWdTeDZUc2pGUWFvTDQrLzN1OEZIOUFuOXg1NkV1R1dy?=
 =?utf-8?B?czY5L3RzZ0h0bDg5cXZJclZHTkpPY0N2Y3RScklza0xKK0FRSTdWUVdLWGRE?=
 =?utf-8?B?WjJTb0FaN0t0WnVuUEhxQTN4TVBEd0lINTRMSWZxbC9RYlpzaE9RNkVXSlJs?=
 =?utf-8?B?dFRzOGIzR0tLZjJObUd4R1diOVA0VU53a0N5VWgzT3hFVk84Y0g1WDlzUGkw?=
 =?utf-8?B?em9oL0xjSlh4NzN4WWdIU2d0L2xOMmNEOWhITzFFemdncTF4SER2L0Z5dm5T?=
 =?utf-8?B?MUhFc3FDLzk3cHpnaGVvTDl2QlVaeHJFQ25TVjRXWFNDTHFQamV1aFV5Q0NL?=
 =?utf-8?B?UTJOUlVTMlczTXo2dzNIVEdzSERRY0NNSzZGR1RRSUhYRzJPZWtabmJYNEcv?=
 =?utf-8?B?cWRub1krSGFHT0NPMm9ReEwySFNscHJoYnIzM0JNci9sQjhibVd1V01FOHQy?=
 =?utf-8?B?UzdKSjdORjRUNVVDMC9ZYmdWSmM3VTRTZkJZZHZHMHdBWUw3blEzckd5QmVw?=
 =?utf-8?B?UFdWYm1YZm8rVE5BdS9EYUJ4SEtEbXpRdkV2cEZDbVdQaXl2OGVrTmdyVHVS?=
 =?utf-8?B?cFMxdXpmT0pib3JGUjRlQktKNjJjdjZFWkQ5RU9XZ3RBajFLT1VacTZxMWts?=
 =?utf-8?B?emhiOGJkQ2dOZFZUUEVwUG83QVI0SzYrdVBMeGxXblg0RDFoSW1idk1BRDVP?=
 =?utf-8?B?WWdKRFNEU2d0VG9DSkdZRkFPNGl2RXZtcXhBd2s2Y3NRZ0FOM0cxUllXdVlu?=
 =?utf-8?B?TGpzV3JkV0xhb1BaMU55Zy9iY05zTGhJVTlKbi90Sm9QbVNYUGFWR29Za1E1?=
 =?utf-8?B?MURJMGRjd1RjV2JPZm90NUJpZ29nZGdsUTd6Q1dTQTkwNjYzeUF1bm1JdmF2?=
 =?utf-8?B?eTgyOFRseDYyQU5RQ21iQm40RE9YSXVLNG05UFM2bHNUL2g5N004VlpocmNM?=
 =?utf-8?B?aWJvRGE0aDZBWERIKzZIbU53VlZEOHQwSXNVZUp2bFh4eGxlUDh1bHNDbjRM?=
 =?utf-8?B?R0dEc3p6S1d4THJ3cnVBa3NvRS9LQVlOWVVKZmZiOXo0UUFIYWJmZGV4YldW?=
 =?utf-8?B?Wm5pbVUyRE94dUw3N2l0UUxSb1RWZlloL2d3cGR1NHpQeFErNHlyQ1NqNHYw?=
 =?utf-8?B?YkdnMy9vWkFPdGwvdENPaEpzelZ6bGRFN0FXK1REV2J0NVZwRnpxcGU1S2Nm?=
 =?utf-8?B?alBNRXdmRW1FdDYvSGZWV08rUUM5bTU5SnE1dlU3Y3pnNVM4emx0b0F0YnZJ?=
 =?utf-8?B?bUlaQ3NFR05pWUdhNU16OVRPYnZwMlJVR1RtWUkvU0t1RmNXcDM1bUhoZzIy?=
 =?utf-8?B?c1lxT2tVVTJpNWZoaG54TWNnV3N3clFFR1RFVE1RTVJnYjh2NGNOVXpXNm5N?=
 =?utf-8?B?YTNyOTdEVDFCRTlISEdLK0dMWmszSW54WC9mQUE5V3JNN0hwL1BsUU5vYXgr?=
 =?utf-8?B?b3l4VUtsSkVmdkpNNFpFRFZjbzNYbTA2ZUdza29rMEdsU1R3dVdxN2tFSktS?=
 =?utf-8?B?cjYwOFZmWTdBNEFpMllDTUtVUXB1U284bGd5OTdUUFdUelhKaUl0cmhyODQz?=
 =?utf-8?B?NDZtaHNSS2IrdVZwbkFuRmRKVW9kQndReFl0STFESi9lSUZJT0RzOHRXdlBC?=
 =?utf-8?B?SWFqeC9Ra3VKdzJUazFrVHdiK0t3ei9IUUtuc0ZIRENHWElRU09pa0ZOWXVM?=
 =?utf-8?B?ZjdMRDZzU2Z6V2E1T092S3JERWJ4MGI0NldtMS9FaElhNE1rcmhRa3VOaUpK?=
 =?utf-8?Q?q/SiNQSTqAFn5a637N8K0Ds1CAvbjb+5D4WS8=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VmxwRXdSNlJNdnpZTXZjY2d1M0dlM1p6RTM1TXZFWkxEZVJhVng0bk5uRHp5?=
 =?utf-8?B?MXR1SlFsVTZQNGZaZGxCdXB0NS85SE9ldzNKTnZGK3FJb1FEYUFXby9TTjRo?=
 =?utf-8?B?VXVUN0hxTUZYY25nNDQ1NkRnamVNR0VhVDBxZG1xUWhzYXRHT1Fma1hwTDQr?=
 =?utf-8?B?TTNxTXhSMEhKbXp6L1dzUGNkNVY2TWpHQUNYV3dNdGlZMlVzTGNpVEtpNEhR?=
 =?utf-8?B?QmZERTErdmd5ZnVCdEhndkF0Ulp2aFVDc2pJT081ak15MmUzNUI3MUp1UFJC?=
 =?utf-8?B?V1Uzald1aXlxVWZGVXFtNjc5S1d4RW9QMGJEQzErRFFPeU1waE5SSFFFMTN6?=
 =?utf-8?B?UGduMDkxQUpYTWdmYkpYSEQyYTg4TkZjL2hYSGdWZHRhdlQ5M0p4RkxBeGIx?=
 =?utf-8?B?cDZQRzlkbXVkcDgvVzVzUFNZSmpqVk5SaVEzUlB4c0JKY3BOZWprTi8zdDU3?=
 =?utf-8?B?eFFnVkJjSEwwNjFZeG5tV3JTakx2c3pheGhNeEZIU0dmVHJMV1hyMU83NWU5?=
 =?utf-8?B?Zno5YjMvOG5YZzV2ZFFkR09VYWhpYkZmbTdFa0FtTml3WDgzSzA0b2Y3SzNa?=
 =?utf-8?B?YTNtcDNpTUsrSmlzODAyYUZ3Y0YydEJIL21MOWl0bUl2QlR0UnkvRHRjSFkz?=
 =?utf-8?B?M3ZObUhuUWd5WWVicU9XSmFZMm8yN0FSWjZRYnBnWnVzSnVPV2VFZlRhVytu?=
 =?utf-8?B?RFliWFE5dUcwcnVMcW9GeEpsNEdvM1VvZ0hQZFNkVnBlcGFqYi9ZakxUa2pV?=
 =?utf-8?B?Q1lhOUlIVE40OFFLUEFBZEhZcjBtYWwxVnNHOFlnTWZrQ3ZZaEtDc2JQWDhl?=
 =?utf-8?B?cUJTM0dMbzBlNEg1R2FKM2V5OEVaeDhjQkpMd2dETVA2NitXT1pXRm0zQTBJ?=
 =?utf-8?B?QTk4RDQ2ZUNWT2VVa2J5NGZTZVdEcVZaanRkV25nbVJmZWdySXd0cU5BYnpz?=
 =?utf-8?B?VU5SMUZKdmRtM0tQZ2ZPZWQ2bDc3Y2lpMG50T3BwUUxqcWpnYVp4LzI2M0px?=
 =?utf-8?B?d25zc1A3U3lBNjlIM1ZwbmhJYjBxWkRETGZqckl3Q21RSWQ1U0Y0RldtU0xY?=
 =?utf-8?B?S08xT2tabkVlQzh4b0xVNy95S3hIcXpvK3VWbTN2UjBWSjJVZGlWbEs3L2Ns?=
 =?utf-8?B?YmJnU2g2QUFIS0dXTzZYNHVNSDJBamd1S0ozOElSUUNybk9QcUJnQWRYSzc3?=
 =?utf-8?B?eUV0NnNIZER2Q1ZqZ3dxMHRHdUNkajY5VS9YWUNXdEVkblllclJPK2ZGNmt0?=
 =?utf-8?B?ZjZScnBHcUdhY25tL1RURk1Hb3BYRWYzNmlud2JjNGs5R1Q2aEhLTVZ4a3ZX?=
 =?utf-8?B?b2Zia2JydmhoMkpuK0FFbmZMWGhVT3UzVzJORkdUZTF4YzdBV0Y5YnpicW5p?=
 =?utf-8?B?MzNiUEpIWWMreEt2c1dWL2NiUWRZZkx3Q2FreUxQNS9jYjRJMXl5T2I4VHU3?=
 =?utf-8?B?emdsUEVBdjRzL3BqODlJeHd5cEdxVmd6OVFNSnB4Ym5rc1U4dURJNmo2OWVF?=
 =?utf-8?B?bWdXRXJ6ZDM2YVdLNnRJKzdXNG9EUkNHT3J6TGZRYlBSMWFWRFkwWjV0c2tu?=
 =?utf-8?B?dEtPTXhCd0cwbVRTTTd3ekJ4UU5tNzk0ZG1uajczZWd3Yzk2aXkyWCs2L3NE?=
 =?utf-8?B?VGRzSVhVaU03NE5SNFBqeTNpQXNCTm44SXI0OXRmMGtKVEg3MEI5ZGdDclc0?=
 =?utf-8?B?Q0VlRjBkaEEwMjAzNXhoRTh6dUZmQk5lLzNJa0lveGJDeDB0VjlPTjFJcGYv?=
 =?utf-8?B?UU03OEhVSnhxalF6WnZSdVhKTHorL0kweHZzUkw2S1k5NmhUcXdXc3JWb3BU?=
 =?utf-8?B?UWQzZmUxTFMwNkY1NDVIbWwrWWVmeElzdThZczVmUUhrL3htY1lqeUhaaVhr?=
 =?utf-8?B?SzFVWWs5Mk9SakI4SEZhMHFKUE1SQ2xLVTNCU2JKT2ZocG83em4xNTBFNE9P?=
 =?utf-8?B?dzJCM01NZmhmemYweExMcDAwTlAxd1ozN016dlRWL0ZGMmFWU3dCR1lDUlRO?=
 =?utf-8?B?R3RGNmVHYjQ4aGtlcGVYYVpldlpicmpkcEVsYmQvSW5FclZyaWcydHlCeDJY?=
 =?utf-8?B?WjBYbjRJSGNlcXd3b3RINm4zMDFtTVhYRlJ5UzhzNnkvUFJwTFNRZkZ4bWk1?=
 =?utf-8?B?UXRXSTFGTHNlS1VyWFZXYTlUSVEwZlNQNmRJbWcrRzhFU1NHM2xwSGM0ZUlp?=
 =?utf-8?B?eHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <018201307597B44B9D2C62B1EA2534D4@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	VFVs331cE40LJTwK6HsYh6tdm7HKwacOIDmrWOc+2zA0srEbZUqDmu6ek75gOWj0MjaLNTWIhEMryNuVwcTOlV5NJHhD+C+s+sD9sWndN4ye6PF8pibCj/pnudvfJdSa13V6GOQ6kHusLjlzTiKzv73GtZienl2TaF6NP4v0MFIbQ95winUv5UFCZ/0n1EkSCTbDbHNhExKcrRb8slbw687YEqJ7D7BkQPHUMWI4iKJj+nnQODg5UaNZoalrK9unTvzlUuTQQk8LiseiA2FxT5N8w+oeFkUpOzLfLgJFwOVxsCKL2XpjNcGqMK0oDAdyYRVXAluVyKm5Qc4xx2MNaeaQiDkkIqydw4rIkViLVsXGqudX/14kzqwzm+O1d0xeonE1K8OIZWSCVbMtowZms4CZuXAD/dU4y7z/zgfXpR0BWiuwcxpgspuWwjYb5acbN1bNc9j9kd6gpaElkXh30k18s6RMODc04TNuiP/nIfCrTzM6ulC+9hvtv2uCpcxhdZiFf9/z2bM02KdYa5GPJE1f0r+8eDhGvDEBaQGgEKzg0ZV5DnczgYU1CRo7svel8A3xXZdMc9E8VNwTIZBE61UiX0mQaF37jKRGoPvD45I=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20f4dad1-ee3a-42f6-8448-08dcf754f58e
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2024 13:32:24.8237
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wKxHF9L2mDyoSWRaJVbsdGk+72QP7CRiXHnaJVQcRbEb1gE8DzCmUeBLZuRzERJwpv5arZauIPJTMKIy42fkXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB5822
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-28_04,2024-10-28_02,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410280109
X-Proofpoint-ORIG-GUID: KmZwn9c8BaSEW2M-oBNGqbua71BRh4bH
X-Proofpoint-GUID: KmZwn9c8BaSEW2M-oBNGqbua71BRh4bH

DQoNCj4gT24gT2N0IDI4LCAyMDI0LCBhdCA4OjQ24oCvQU0sIFRvbSBUYWxwZXkgPHRvbUB0YWxw
ZXkuY29tPiB3cm90ZToNCj4gDQo+IE9uIDEwLzI4LzIwMjQgNToxOCBBTSwgQmVub8OudCBHc2No
d2luZCB3cm90ZToNCj4+IEhlbGxvLA0KPj4gVGhlIGlzc3VlIHRyaWdnZXIgYWdhaW4sIEkgYXR0
YWNoZWQgdGhlIHJlc3VsdCBvZjoNCj4+ICMgZG1lc2cgLVcgfCB0ZWUgZG1lc2cudHh0DQo+PiB1
c2luZzoNCj4+ICMgZWNobyB0ID4gL3Byb2Mvc3lzcnEtdHJpZ2dlcg0KPj4gSSBoYXZlIHRoZSBm
b2xsb3dpbmcgUElEIHN0dWNrOg0KPj4gICAgIDE0NzQgRCAoZGlzayBzbGVlcCkgICAgICAgMDo1
NDo1OC42MDIgW25mc2RdDQo+PiAgICAgMTQ3NSBEIChkaXNrIHNsZWVwKSAgICAgICAwOjU0OjU4
LjYwMiBbbmZzZF0NCj4+ICAgICAxNDg0IEQgKGRpc2sgc2xlZXApICAgICAgIDA6NTQ6NTguNjAy
IFtuZnNkXQ0KPj4gICAgIDE0OTUgRCAoZGlzayBzbGVlcCkgICAgICAgMDo1NDo1OC42MDIgW25m
c2RdDQo+IA0KPiBIbW0sIDE0OTUgaXMgc3R1Y2sgaW4gbmZzZDRfY3JlYXRlX3Nlc3Npb24NCj4g
DQo+ID4gWzQyNzQ2OC4zMDQ5NTVdIHRhc2s6bmZzZCAgICAgICAgICAgIHN0YXRlOkQgc3RhY2s6
MCAgICAgcGlkOjE0OTUgcHBpZDoyICAgICAgZmxhZ3M6MHgwMDAwNDAwMA0KPiA+IFs0Mjc0Njgu
MzA0OTYyXSBDYWxsIFRyYWNlOg0KPiA+IFs0Mjc0NjguMzA0OTY1XSAgPFRBU0s+DQo+ID4gWzQy
NzQ2OC4zMDQ5NzFdICBfX3NjaGVkdWxlKzB4MzRkLzB4OWUwDQo+ID4gWzQyNzQ2OC4zMDQ5ODNd
ICBzY2hlZHVsZSsweDVhLzB4ZDANCj4gPiBbNDI3NDY4LjMwNDk5MV0gIHNjaGVkdWxlX3RpbWVv
dXQrMHgxMTgvMHgxNTANCj4gPiBbNDI3NDY4LjMwNTAwM10gIHdhaXRfZm9yX2NvbXBsZXRpb24r
MHg4Ni8weDE2MA0KPiA+IFs0Mjc0NjguMzA1MDE1XSAgX19mbHVzaF93b3JrcXVldWUrMHgxNTIv
MHg0MjANCj4gPiBbNDI3NDY4LjMwNTAzMV0gIG5mc2Q0X2NyZWF0ZV9zZXNzaW9uKzB4NzlmLzB4
YmEwIFtuZnNkXQ0KPiA+IFs0Mjc0NjguMzA1MDkyXSAgbmZzZDRfcHJvY19jb21wb3VuZCsweDM0
Yy8weDY2MCBbbmZzZF0NCj4gPiBbNDI3NDY4LjMwNTE0N10gIG5mc2RfZGlzcGF0Y2grMHgxYTEv
MHgyYjAgW25mc2RdDQo+ID4gWzQyNzQ2OC4zMDUxOTldICBzdmNfcHJvY2Vzc19jb21tb24rMHgy
OTUvMHg2MTAgW3N1bnJwY10NCj4gPiBbNDI3NDY4LjMwNTI2OV0gID8gc3ZjX3JlY3YrMHg0OTEv
MHg4MTAgW3N1bnJwY10NCj4gPiBbNDI3NDY4LjMwNTMzN10gID8gbmZzZF9zdmMrMHgzNzAvMHgz
NzAgW25mc2RdDQo+ID4gWzQyNzQ2OC4zMDUzODldICA/IG5mc2Rfc2h1dGRvd25fdGhyZWFkcysw
eDkwLzB4OTAgW25mc2RdDQo+ID4gWzQyNzQ2OC4zMDU0MzddICBzdmNfcHJvY2VzcysweGFkLzB4
MTAwIFtzdW5ycGNdDQo+ID4gWzQyNzQ2OC4zMDU1MDVdICBuZnNkKzB4OTkvMHgxNDAgW25mc2Rd
DQo+ID4gWzQyNzQ2OC4zMDU1NTVdICBrdGhyZWFkKzB4ZGEvMHgxMDANCj4gPiBbNDI3NDY4LjMw
NTU2Ml0gID8ga3RocmVhZF9jb21wbGV0ZV9hbmRfZXhpdCsweDIwLzB4MjANCj4gPiBbNDI3NDY4
LjMwNTU3Ml0gIHJldF9mcm9tX2ZvcmsrMHgyMi8weDMwDQo+IA0KPiBhbmQgdGhlIG90aGVyIHRo
cmVlIGFyZSBzdHVjayBpbiBuZnNkNF9kZXN0cm95X3Nlc3Npb24NCj4gDQo+ID4gWzQyNzQ2OC4y
OTgzMTVdIHRhc2s6bmZzZCAgICAgICAgICAgIHN0YXRlOkQgc3RhY2s6MCAgICAgcGlkOjE0NzQg
cHBpZDoyICAgICAgZmxhZ3M6MHgwMDAwNDAwMA0KPiA+IFs0Mjc0NjguMjk4MzIyXSBDYWxsIFRy
YWNlOg0KPiA+IFs0Mjc0NjguMjk4MzI2XSAgPFRBU0s+DQo+ID4gWzQyNzQ2OC4yOTgzMzJdICBf
X3NjaGVkdWxlKzB4MzRkLzB4OWUwDQo+ID4gWzQyNzQ2OC4yOTgzNDNdICBzY2hlZHVsZSsweDVh
LzB4ZDANCj4gPiBbNDI3NDY4LjI5ODM1MF0gIHNjaGVkdWxlX3RpbWVvdXQrMHgxMTgvMHgxNTAN
Cj4gPiBbNDI3NDY4LjI5ODM2Ml0gIHdhaXRfZm9yX2NvbXBsZXRpb24rMHg4Ni8weDE2MA0KPiA+
IFs0Mjc0NjguMjk4Mzc1XSAgX19mbHVzaF93b3JrcXVldWUrMHgxNTIvMHg0MjANCj4gPiBbNDI3
NDY4LjI5ODM5Ml0gIG5mc2Q0X2Rlc3Ryb3lfc2Vzc2lvbisweDFiNi8weDI1MCBbbmZzZF0NCj4g
PiBbNDI3NDY4LjI5ODQ1Nl0gIG5mc2Q0X3Byb2NfY29tcG91bmQrMHgzNGMvMHg2NjAgW25mc2Rd
DQo+ID4gWzQyNzQ2OC4yOTg1MTVdICBuZnNkX2Rpc3BhdGNoKzB4MWExLzB4MmIwIFtuZnNkXQ0K
PiA+IFs0Mjc0NjguMjk4NTY4XSAgc3ZjX3Byb2Nlc3NfY29tbW9uKzB4Mjk1LzB4NjEwIFtzdW5y
cGNdDQo+ID4gWzQyNzQ2OC4yOTg2NDNdICA/IHN2Y19yZWN2KzB4NDkxLzB4ODEwIFtzdW5ycGNd
DQo+ID4gWzQyNzQ2OC4yOTg3MTFdICA/IG5mc2Rfc3ZjKzB4MzcwLzB4MzcwIFtuZnNkXQ0KPiA+
IFs0Mjc0NjguMjk4Nzc2XSAgPyBuZnNkX3NodXRkb3duX3RocmVhZHMrMHg5MC8weDkwIFtuZnNk
XQ0KPiA+IFs0Mjc0NjguMjk4ODI1XSAgc3ZjX3Byb2Nlc3MrMHhhZC8weDEwMCBbc3VucnBjXQ0K
PiA+IFs0Mjc0NjguMjk4ODk2XSAgbmZzZCsweDk5LzB4MTQwIFtuZnNkXQ0KPiA+IFs0Mjc0Njgu
Mjk4OTQ2XSAga3RocmVhZCsweGRhLzB4MTAwDQo+ID4gWzQyNzQ2OC4yOTg5NTRdICA/IGt0aHJl
YWRfY29tcGxldGVfYW5kX2V4aXQrMHgyMC8weDIwDQo+ID4gWzQyNzQ2OC4yOTg5NjNdICByZXRf
ZnJvbV9mb3JrKzB4MjIvMHgzMA0KPiANCj4gVGhlcmUgYXJlbid0IGEgbG90IG9mIDYuMS1lcmEg
Y2hhbmdlcyBpbiBlaXRoZXIgb2YgdGhlc2UsIGJ1dCB0aGVyZQ0KPiBhcmUgc29tZSBpbnRlcmVz
dGluZyBiZWhhdmlvciB1cGRhdGVzIGFyb3VuZCBzZXNzaW9uIGNyZWF0ZSByZXBsYXkNCj4gZnJv
bSBlYXJseSB0aGlzIHllYXIuIEkgd29uZGVyIGlmIHRoZSA2LjEgc2VydmVyIGlzIG1pc2hhbmRs
aW5nIGFuDQo+IG5mc2Vycl9qdWtlYm94IHNpdHVhdGlvbiBpbiBuZnNkNF9zZXNzaW9uX2NyZWF0
ZS4NCg0KRm9yIHJlZmVyZW5jZToNCg0KMTAzOTZmNGRmOGI3ICgibmZzZDogaG9sZCBhIGxpZ2h0
ZXItd2VpZ2h0IGNsaWVudCByZWZlcmVuY2Ugb3ZlciBDQl9SRUNBTExfQU5ZIikNCjk5ZGMyZWYw
Mzk3ZCAoIk5GU0Q6IENSRUFURV9TRVNTSU9OIG11c3QgbmV2ZXIgY2FjaGUgTkZTNEVSUl9ERUxB
WSByZXBsaWVzIikNCmU0NDY5YzZjYzY5YiAoIk5GU0Q6IEZpeCB0aGUgTkZTdjQuMSBDUkVBVEVf
U0VTU0lPTiBvcGVyYXRpb24iKQ0KDQpBIG5ldHdvcmsgY2FwdHVyZSwgb25jZSB0aGVzZSBwcm9j
ZXNzZXMgYXJlIHN0dWNrLCBtaWdodA0KY29uZmlybSBDUkVBVEVfU0VTU0lPTiBzbG90IHJlcGxh
eSBhcyBhIGN1bHByaXQuDQoNCg0KPiBXYXMgdGhlIGNsaWVudCBhY3R1YWxseSBhdHRlbXB0aW5n
IHRvIG1vdW50IG9yIHVubW91bnQ/DQo+IA0KPiBUb20uDQo+IA0KPj4gVGhhbmsgYnkgYWR2YW5j
ZSwNCj4+IEJlc3QgcmVnYXJkcw0KPj4gTGUgbWVyY3JlZGkgMjMgb2N0b2JyZSAyMDI0IMOgIDE5
OjM4ICswMDAwLCBDaHVjayBMZXZlciBJSUkgYSDDqWNyaXQgOg0KPj4+IA0KPj4+IA0KPj4+PiBP
biBPY3QgMjMsIDIwMjQsIGF0IDM6MjfigK9QTSwgQmVub8OudCBHc2Nod2luZA0KPj4+PiA8YmVu
b2l0LmdzY2h3aW5kQG1pbmVzcGFyaXMucHNsLmV1PiB3cm90ZToNCj4+Pj4gDQo+Pj4+IEhlbGxv
LA0KPj4+PiANCj4+Pj4gSSBoYXZlIGEgbmZzIHNlcnZlciB1c2luZyBkZWJpYW4gMTEgKExpbnV4
IGhvc3RuYW1lIDYuMS4wLTI1LWFtZDY0DQo+Pj4+ICMxDQo+Pj4+IFNNUCBQUkVFTVBUX0RZTkFN
SUMgRGViaWFuIDYuMS4xMDYtMyAoMjAyNC0wOC0yNikgeDg2XzY0IEdOVS9MaW51eCkNCj4+Pj4g
DQo+Pj4+IEluIHNvbWUgaGVhdnkgd29ya2xvYWQgc29tZSBuZnNkIGdvZXMgaW4gRCBzdGF0ZSBh
bmQgc2VlbXMgdG8gbmV2ZXINCj4+Pj4gbGVhdmUgdGhpcyBzdGF0ZS4gSSBkaWQgYSBweXRob24g
c2NyaXB0IHRvIG1vbml0b3IgaG93IGxvbmcgYQ0KPj4+PiBwcm9jZXNzDQo+Pj4+IHN0YXkgaW4g
cGFydGljdWxhciBzdGF0ZSBhbmQgSSB1c2UgaXQgdG8gbW9uaXRvciBuZnNkIHN0YXRlLiBJIGdl
dA0KPj4+PiB0aGUNCj4+Pj4gZm9sbG93aW5nIHJlc3VsdCA6DQo+Pj4+IA0KPj4+PiBbLi4uXQ0K
Pj4+PiAxNzgwNTYgSSAoaWRsZSkgMDoyNToyNC40NzUgW25mc2RdDQo+Pj4+IDE3ODA1NyBJIChp
ZGxlKSAwOjI1OjI0LjQ3NSBbbmZzZF0NCj4+Pj4gMTc4MDU4IEkgKGlkbGUpIDA6MjU6MjQuNDc1
IFtuZnNkXQ0KPj4+PiAxNzgwNTkgSSAoaWRsZSkgMDoyNToyNC40NzUgW25mc2RdDQo+Pj4+IDE3
ODA2MCBJIChpZGxlKSAwOjI1OjI0LjQ3NSBbbmZzZF0NCj4+Pj4gMTc4MDYxIEkgKGlkbGUpIDA6
MjU6MjQuNDc1IFtuZnNkXQ0KPj4+PiAxNzgwNjIgSSAoaWRsZSkgMDoyNDoxNS42MzggW25mc2Rd
DQo+Pj4+IDE3ODA2MyBJIChpZGxlKSAwOjI0OjEzLjQ4OCBbbmZzZF0NCj4+Pj4gMTc4MDY0IEkg
KGlkbGUpIDA6MjQ6MTMuNDg4IFtuZnNkXQ0KPj4+PiAxNzgwNjUgSSAoaWRsZSkgMDowMDowMC4w
MDAgW25mc2RdDQo+Pj4+IDE3ODA2NiBJIChpZGxlKSAwOjAwOjAwLjAwMCBbbmZzZF0NCj4+Pj4g
MTc4MDY3IEkgKGlkbGUpIDA6MDA6MDAuMDAwIFtuZnNkXQ0KPj4+PiAxNzgwNjggSSAoaWRsZSkg
MDowMDowMC4wMDAgW25mc2RdDQo+Pj4+IDE3ODA2OSBTIChzbGVlcGluZykgMDowMDowMi4xNDcg
W25mc2RdDQo+Pj4+IDE3ODA3MCBTIChzbGVlcGluZykgMDowMDowMi4xNDcgW25mc2RdDQo+Pj4+
IDE3ODA3MSBTIChzbGVlcGluZykgMDowMDowMi4xNDcgW25mc2RdDQo+Pj4+IDE3ODA3MiBTIChz
bGVlcGluZykgMDowMDowMi4xNDcgW25mc2RdDQo+Pj4+IDE3ODA3MyBTIChzbGVlcGluZykgMDow
MDowMi4xNDcgW25mc2RdDQo+Pj4+IDE3ODA3NCBEIChkaXNrIHNsZWVwKSAxOjI5OjI1LjgwOSBb
bmZzZF0NCj4+Pj4gMTc4MDc1IFMgKHNsZWVwaW5nKSAwOjAwOjAyLjE0NyBbbmZzZF0NCj4+Pj4g
MTc4MDc2IFMgKHNsZWVwaW5nKSAwOjAwOjAyLjE0NyBbbmZzZF0NCj4+Pj4gMTc4MDc3IFMgKHNs
ZWVwaW5nKSAwOjAwOjAyLjE0NyBbbmZzZF0NCj4+Pj4gMTc4MDc4IFMgKHNsZWVwaW5nKSAwOjAw
OjAyLjE0NyBbbmZzZF0NCj4+Pj4gMTc4MDc5IFMgKHNsZWVwaW5nKSAwOjAwOjAyLjE0NyBbbmZz
ZF0NCj4+Pj4gMTc4MDgwIEQgKGRpc2sgc2xlZXApIDE6Mjk6MjUuODA5IFtuZnNkXQ0KPj4+PiAx
NzgwODEgRCAoZGlzayBzbGVlcCkgMToyOToyNS44MDkgW25mc2RdDQo+Pj4+IDE3ODA4MiBEIChk
aXNrIHNsZWVwKSAwOjI4OjA0LjQ0NCBbbmZzZF0NCj4+Pj4gDQo+Pj4+IEFsbCBwcm9jZXNzIG5v
dCBzaG93biBhcmUgaW4gaWRsZSBzdGF0ZS4gQ29sdW1ucyBhcmUgdGhlIGZvbGxvd2luZzoNCj4+
Pj4gUElELCBzdGF0ZSwgc3RhdGUgbmFtZSwgYW1vdW5nIG9mIHRpbWUgdGhlIHN0YXRlIGRpZCBu
b3QgY2hhbmdlZA0KPj4+PiBhbmQNCj4+Pj4gdGhlIHByb2Nlc3Mgd2FzIG5vdCBpbnRlcnJ1cHRl
ZCwgYW5kIC9wcm9jL1BJRC9zdGF0dXMgTmFtZSBlbnRyeS4NCj4+Pj4gDQo+Pj4+IEFzIHlvdSBj
YW4gcmVhZCBzb21lIG5mc2QgcHJvY2VzcyBhcmUgaW4gZGlzayBzbGVlcCBzdGF0ZSBzaW5jZQ0K
Pj4+PiBtb3JlDQo+Pj4+IHRoYW4gMSBob3VyLCBidXQgbG9va2luZyBhdCB0aGUgZGlzayBhY3Rp
dml0eSwgdGhlcmUgaXMgYWxtb3N0IG5vDQo+Pj4+IEkvTy4NCj4+Pj4gDQo+Pj4+IEkgdHJpZWQg
dG8gcmVzdGFydCBuZnMtc2VydmVyIGJ1dCBJIGdldCB0aGUgZm9sbG93aW5nIGVycm9yIGZyb20N
Cj4+Pj4gdGhlDQo+Pj4+IGtlcm5lbDoNCj4+Pj4gDQo+Pj4+IG9jdC4gMjMgMTE6NTk6NDkgaG9z
dG5hbWUga2VybmVsOiBycGMtc3J2L3RjcDogbmZzZDogZ290IGVycm9yIC0xMDQNCj4+Pj4gd2hl
biBzZW5kaW5nIDIwIGJ5dGVzIC0gc2h1dHRpbmcgZG93biBzb2NrZXQNCj4+Pj4gb2N0LiAyMyAx
MTo1OTo0OSBob3N0bmFtZSBrZXJuZWw6IHJwYy1zcnYvdGNwOiBuZnNkOiBnb3QgZXJyb3IgLTEw
NA0KPj4+PiB3aGVuIHNlbmRpbmcgMjAgYnl0ZXMgLSBzaHV0dGluZyBkb3duIHNvY2tldA0KPj4+
PiBvY3QuIDIzIDExOjU5OjQ5IGhvc3RuYW1lIGtlcm5lbDogcnBjLXNydi90Y3A6IG5mc2Q6IGdv
dCBlcnJvciAtMTA0DQo+Pj4+IHdoZW4gc2VuZGluZyAyMCBieXRlcyAtIHNodXR0aW5nIGRvd24g
c29ja2V0DQo+Pj4+IG9jdC4gMjMgMTE6NTk6NDkgaG9zdG5hbWUga2VybmVsOiBycGMtc3J2L3Rj
cDogbmZzZDogZ290IGVycm9yIC0xMDQNCj4+Pj4gd2hlbiBzZW5kaW5nIDIwIGJ5dGVzIC0gc2h1
dHRpbmcgZG93biBzb2NrZXQNCj4+Pj4gb2N0LiAyMyAxMTo1OTo0OSBob3N0bmFtZSBrZXJuZWw6
IHJwYy1zcnYvdGNwOiBuZnNkOiBnb3QgZXJyb3IgLTEwNA0KPj4+PiB3aGVuIHNlbmRpbmcgMjAg
Ynl0ZXMgLSBzaHV0dGluZyBkb3duIHNvY2tldA0KPj4+PiBvY3QuIDIzIDExOjU5OjU5IGhvc3Ru
YW1lIGtlcm5lbDogcnBjLXNydi90Y3A6IG5mc2Q6IGdvdCBlcnJvciAtMTA0DQo+Pj4+IHdoZW4g
c2VuZGluZyAyMCBieXRlcyAtIHNodXR0aW5nIGRvd24gc29ja2V0DQo+Pj4+IG9jdC4gMjMgMTE6
NTk6NTkgaG9zdG5hbWUga2VybmVsOiBycGMtc3J2L3RjcDogbmZzZDogZ290IGVycm9yIC0xMDQN
Cj4+Pj4gd2hlbiBzZW5kaW5nIDIwIGJ5dGVzIC0gc2h1dHRpbmcgZG93biBzb2NrZXQNCj4+Pj4g
b2N0LiAyMyAxMTo1OTo1OSBob3N0bmFtZSBrZXJuZWw6IHJwYy1zcnYvdGNwOiBuZnNkOiBnb3Qg
ZXJyb3IgLTEwNA0KPj4+PiB3aGVuIHNlbmRpbmcgMjAgYnl0ZXMgLSBzaHV0dGluZyBkb3duIHNv
Y2tldA0KPj4+PiBvY3QuIDIzIDExOjU5OjU5IGhvc3RuYW1lIGtlcm5lbDogcnBjLXNydi90Y3A6
IG5mc2Q6IGdvdCBlcnJvciAtMTA0DQo+Pj4+IHdoZW4gc2VuZGluZyAyMCBieXRlcyAtIHNodXR0
aW5nIGRvd24gc29ja2V0DQo+Pj4+IG9jdC4gMjMgMTE6NTk6NTkgaG9zdG5hbWUga2VybmVsOiBy
cGMtc3J2L3RjcDogbmZzZDogZ290IGVycm9yIC0xMDQNCj4+Pj4gd2hlbiBzZW5kaW5nIDIwIGJ5
dGVzIC0gc2h1dHRpbmcgZG93biBzb2NrZXQNCj4+Pj4gb2N0LiAyMyAxMjowMDowOSBob3N0bmFt
ZSBrZXJuZWw6IHJwYy1zcnYvdGNwOiBuZnNkOiBnb3QgZXJyb3IgLTEwNA0KPj4+PiB3aGVuIHNl
bmRpbmcgMjAgYnl0ZXMgLSBzaHV0dGluZyBkb3duIHNvY2tldA0KPj4+PiBvY3QuIDIzIDEyOjAw
OjA5IGhvc3RuYW1lIGtlcm5lbDogcnBjLXNydi90Y3A6IG5mc2Q6IGdvdCBlcnJvciAtMTA0DQo+
Pj4+IHdoZW4gc2VuZGluZyAyMCBieXRlcyAtIHNodXR0aW5nIGRvd24gc29ja2V0DQo+Pj4+IG9j
dC4gMjMgMTI6MDA6MDkgaG9zdG5hbWUga2VybmVsOiBycGMtc3J2L3RjcDogbmZzZDogZ290IGVy
cm9yIC0xMDQNCj4+Pj4gd2hlbiBzZW5kaW5nIDIwIGJ5dGVzIC0gc2h1dHRpbmcgZG93biBzb2Nr
ZXQNCj4+Pj4gb2N0LiAyMyAxMjowMDoxMCBob3N0bmFtZSBrZXJuZWw6IHJwYy1zcnYvdGNwOiBu
ZnNkOiBnb3QgZXJyb3IgLTMyDQo+Pj4+IHdoZW4gc2VuZGluZyAyMCBieXRlcyAtIHNodXR0aW5n
IGRvd24gc29ja2V0DQo+Pj4+IG9jdC4gMjMgMTI6MDA6MTAgaG9zdG5hbWUga2VybmVsOiBycGMt
c3J2L3RjcDogbmZzZDogZ290IGVycm9yIC0zMg0KPj4+PiB3aGVuIHNlbmRpbmcgMjAgYnl0ZXMg
LSBzaHV0dGluZyBkb3duIHNvY2tldA0KPj4+PiANCj4+Pj4gVGhlIG9ubHkgd2F5IHRvIHJlY292
ZXIgc2VlbXMgdG8gcmVib290IHRoZSBrZXJuZWwuIEkgZ3Vlc3MgYmVjYXVzZQ0KPj4+PiB0aGUN
Cj4+Pj4ga2VybmVsIGZvcmNlIHRoZSByZWJvb3QgYWZ0ZXIgYSBnaXZlbiB0aW1lb3V0Lg0KPj4+
PiANCj4+Pj4gTXkgc2V0dXAgaW52b2x2ZSBpbiBvcmRlciA6DQo+Pj4+IC0gc2NzaSBkcml2ZXIN
Cj4+Pj4gLSBtZHJhaWQgb24gdG9wIG9mIHNjc2kgKHJhaWQ2KQ0KPj4+PiAtIGJ0cmZzIG9udG9w
IG9mIG1kcmFpZA0KPj4+PiAtIG5mc2Qgb250b3Agb2YgYnRyZnMNCj4+Pj4gDQo+Pj4+IA0KPj4+
PiBUaGUgc2V0dXAgaXMgbm90IHZlcnkgZmFzdCBhcyBleHBlY3RlZCwgYnV0IGl0IHNlZW1zIHRo
YXQgaW4gc29tZQ0KPj4+PiBzaXR1YXRpb24gbmZzZCBuZXZlciBsZWF2ZSB0aGUgZGlzayBzbGVl
cCBzdGF0ZS4gdGhlIGV4cG9ydHMNCj4+Pj4gb3B0aW9ucw0KPj4+PiBhcmU6IGdzcy9rcmI1aShy
dyxzeW5jLG5vX3dkZWxheSxub19zdWJ0cmVlX2NoZWNrLGZzaWQ9WFhYWFgpLiBUaGUNCj4+Pj4g
c2l0dWF0aW9uIGlzIG5vdCBjb21tdW4gYnV0IGl0J3MgYWx3YXlzIGhhcHBlbiBhdCBzb21lIHBv
aW50LiBGb3INCj4+Pj4gaW5zdGFuY2UgaW4gdGhlIGNhc2UgSSByZXBvcnQgaGVyZSwgbXkgc2Vy
dmVyIGJvb3RlZCB0aGUgMjAyNC0xMC0wMQ0KPj4+PiBhbmQNCj4+Pj4gd2FzIHN0dWNrIGFib3V0
IHRoZSAyMDI0LTEwLTIzLiBJIGRpZCByZWR1Y2VkIGJ5IGEgbGFyZ2UgYW1vdW50IHRoZQ0KPj4+
PiBmcmVxdWVuY3kgb2YgaXNzdWUgYnkgdXNpbmcgbm9fd2RlbGF5IChJIGRpZCB0aG91Z2h0IHRo
YXQgSSBkaWQNCj4+Pj4gc29sdmVkDQo+Pj4+IHRoZSBpc3N1ZSB3aGVuIEkgc3RhcnRlZCB0byB1
c2UgdGhpcyBvcHRpb24pLg0KPj4+PiANCj4+Pj4gTXkgZ3Vlc3MgaXMgaGFkd2FyZSBidWcsIHNj
c2kgYnVnLCBidHJmcyBidWcgb3IgbmZzZCBidWcgPw0KPj4+PiANCj4+Pj4gQW55IGNsdWUgb24g
dGhpcyB0b3BpYyBvciBhbnkgYWR2aWNlIGlzIHdlbGxjb21lLg0KPj4+IA0KPj4+IEdlbmVyYXRl
IHN0YWNrIHRyYWNlcyBmb3IgZWFjaCBwcm9jZXNzIG9uIHRoZSBzeXN0ZW0NCj4+PiB1c2luZyAi
c3VkbyBlY2hvIHQgPiAvcHJvYy9zeXNycS10cmlnZ2VyIiBhbmQgdGhlbg0KPj4+IGV4YW1pbmUg
dGhlIG91dHB1dCBpbiB0aGUgc3lzdGVtIGpvdXJuYWwuIE5vdGUgdGhlDQo+Pj4gc3RhY2sgY29u
dGVudHMgZm9yIHRoZSBwcm9jZXNzZXMgdGhhdCBsb29rIHN0dWNrLg0KPj4+IA0KPj4+IC0tDQo+
Pj4gQ2h1Y2sgTGV2ZXINCj4+PiANCj4+PiANCj4gDQoNCi0tDQpDaHVjayBMZXZlcg0KDQoNCg==

