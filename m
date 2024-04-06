Return-Path: <linux-nfs+bounces-2690-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F38689ABAE
	for <lists+linux-nfs@lfdr.de>; Sat,  6 Apr 2024 17:36:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 646E8B21D24
	for <lists+linux-nfs@lfdr.de>; Sat,  6 Apr 2024 15:36:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 586193B2A2;
	Sat,  6 Apr 2024 15:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QAw/uUfb";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Z/Zdfrug"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 615893A1C4
	for <linux-nfs@vger.kernel.org>; Sat,  6 Apr 2024 15:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712417801; cv=fail; b=kGyCH7843lAl412ylU/L6BDC1+mSSyDU8oujZ2FGMQelaYId2dCYaKpvP3dTDWO5SbpSGQsBPLs549dRq59Bv+BglIfmeXXbqgaRM4HpWOdTq26n0BN71EFh/wCY+NS62vQFmO6msBUgfMnvF8jwFQkKeJmA3wuEy0SJ4C1U+w0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712417801; c=relaxed/simple;
	bh=tMqMG75MeRaMefQGLFJcx1Fz/k+iZ1moUro60nUckKE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JOpoT2K6/OkzjomeoT9IMuTTCzm0iUEWlE0Kig/gUg3tY24P2Bfrx18XsocJaBlIfLTc3wXU5bgtZ/Qabrqlwia+syAf7TrVJo3/n3qomWsyY+wULvk/+Din6sqICyJehBvi4e+OdlUb9kNiQhzsxLfX3sr40ZCiVvR8vB3nJuE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=QAw/uUfb; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Z/Zdfrug; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 436CZ8rJ008735;
	Sat, 6 Apr 2024 15:36:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=tMqMG75MeRaMefQGLFJcx1Fz/k+iZ1moUro60nUckKE=;
 b=QAw/uUfb2JPqDEJr0CEYa7gC8k0OpCuPwf9a7OjMu9WVmBI1Xto4HUgTU6joGwqhdw+W
 /HzujVj80Mwf9IZnrstbfGtaXx0Y4ibHdlwGfdAYDQKkb7ky3tinD0HWlYWTLJg9ewcR
 hAZirUvJzFMqf+VPBeic9Y1BCpy/uiHPeszkOEQQdsBAFNWO0yFB7b2FdjsXyLud8n8d
 slBoBZ4dn69LdAkZFoANwKoeuCkACRCCLuzg5jx/vqhojYF3Y2oAALy8x/k/PT7yDHbl
 KNMpSHXPLXlRPHw/A7eDjeK7POZAAEQ6wvgwXG51SzvET4a7Ee3+YccA/VIrxF5H62J7 Wg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xavtf0fka-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 06 Apr 2024 15:36:21 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 436Das2q032340;
	Sat, 6 Apr 2024 15:36:20 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xavu473f1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 06 Apr 2024 15:36:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ExdNutHPC0QDCVXJJ+WekJieQh0QJL8O0N/QIV7l25OIYsNUvODLGcq3p4obeMyg2uu5OKvCfMfXvq766iY3nMMYP+HaDSJ3mf4PUwyRkg9QpOlCTbITUhQ3uw5ROpXJkEbbMuVDWVD12OU5GnMtq1JhKCwtOvWSv85vam20so5zfmrPmGT0vsfRNRe/JC7C53dIkuiLoU0848+rO6PhTh0GI4LYNv8Y530W0b4W8qBJbN4DXUmroRG3FBJ976/3E/OVicSW8Mf7u/+oViTVQtVTwVB7+YtamlpBELpe5k1k2NNhBJ3+/lni84j/32BMtgDMbbD5GLYAI3FlMJNw/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tMqMG75MeRaMefQGLFJcx1Fz/k+iZ1moUro60nUckKE=;
 b=chxVX+yiePspggd4/DlKf9/so89MVmC0oLXCFrYl9Q1UAAV6/2zLrEkwmCWtFS8VVxU4VEcZdFC0TzyttEK2camN7ec8fXGCfmmZOemPZr0RxAZ2qq/nE+oXeVTkN7UzMzLZPgYA5JvkxtyIqSigjlo0fQQmAYY6vNiMr9srD/nwTG+4ncpV1vxmvjytYRwue3HDcnl17i2nxQl8GOAdiuMrtrV0JBd9nIKCEn3atQOHVZnNh+2S30TPTcwE+BU6a6LPB+459yWvrd4ar46SBBYvBu9UDiSBeucM5JwgvdMwnRrLRW9oxoIUHcVi/RVm5RzcaCRJqURWRr/fKMaFwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tMqMG75MeRaMefQGLFJcx1Fz/k+iZ1moUro60nUckKE=;
 b=Z/ZdfrugkZA/xCgkk+YGzYvTN/7VIA4Zd4VM/UjVad3m/YsDA7z6hMVCFzcjadBqkVUCHUavKPePcgCHEtI14IhmfPWYu4oDydkuSJdqIuVlcbr1MAfoyD5MW7c/yffQb/UAY7Wq0plJOiLTI8Ilb4UYyTul2SA/1WA974tbsYE=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BLAPR10MB5057.namprd10.prod.outlook.com (2603:10b6:208:30e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Sat, 6 Apr
 2024 15:36:17 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ad12:a809:d789:a25b]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ad12:a809:d789:a25b%4]) with mapi id 15.20.7409.042; Sat, 6 Apr 2024
 15:36:17 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: "Hanxiao Chen (Fujitsu)" <chenhx.fnst@fujitsu.com>
CC: Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>,
        Olga
 Kornievskaia <kolga@netapp.com>, Dai Ngo <dai.ngo@oracle.com>,
        Tom Talpey
	<tom@talpey.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v2] NFSD: trace export root filehandle event
Thread-Topic: [PATCH v2] NFSD: trace export root filehandle event
Thread-Index: AQHagStoXb7RDa+G0kK+isab4bg/yLFZycoAgAGiUACAAAHWAA==
Date: Sat, 6 Apr 2024 15:36:17 +0000
Message-ID: <21A5DF99-1FEA-41FD-B569-FFA45EF59A7A@oracle.com>
References: <20240328161654.1432-1-chenhx.fnst@fujitsu.com>
 <ZhBDsqxNnj+b5iRg@tissot.1015granger.net>
 <TYWPR01MB12085681A09D7DA36C4114F93E6022@TYWPR01MB12085.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <TYWPR01MB12085681A09D7DA36C4114F93E6022@TYWPR01MB12085.jpnprd01.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.500.171.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|BLAPR10MB5057:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 cxxD9pVXhApi66f3bloI5wrS8ZBwTjlZmkiwThuDVLKlNMgaO0C5WNkB9naOsqmU95CDwEtq5U/w1p2hB5AR8YzCFPHio3xlqI4SVWCouM6jJXtwhllZU8CJYBmibxLBeiu4fcH+/5aINNLR555FfeKuWr61Wrx+2VvrRy1aKq7a2yIfbazFaI0h6AuONCa7Q2qL4P19EgtpJK+dlICtMV5w+Z4S/gz4ca3Yh89JU1O/aIETJtuWVs3Nh+jE1Zu/KaTN682w4hG6JEOzQg6nCmPz+fRvBoYyVHT13eRiPLNWuhRYNMbF/70tjcFO9GclEZwImqkO9EQk2IsRt0EfoZ5bUQrkNJ+pVf04hU8ZFEVQ47fuB2oznEQAkU9Qz+nDca4LZ2VAyBIlep2YrqsvDTLp41RGfdD/1mtpOgEdKO51DckZkfE4Pr1WQHp2nblOZdVpHrvunaLwiw5SjhCXipWhhQ9MeuJ3Vfx0U8samoyOXQiGDGu9VS1IkvAhqPNUB8+an0iZbR2JW2qahhM9QM22ag9n7eibU0kY7Ic/QmN4bGonciegsGYMIQeH1iffWtmwSmmsZZIU2ZBeeVpzqYoinYlExWv+Ua5v71B0l/BETuvCj3yPkfT4qinhqmkVwtzomcQI8ze2IpGD9nRCbs5YFqu2Deke2USs3lWKgCc=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?ZFM1ZXQxSmlpdk5zVHVuYVZ2YTRaMFNNVVpVK2xaYXFSdWpTUCtRUGxXR3pH?=
 =?utf-8?B?M2Q1QWU0UHlsZi80Q2JSLzJ5TVpYeTNJTTIzSDhNWWRNUExPeGpKMndTV3R6?=
 =?utf-8?B?dW9IRHpUVzR3ZFc1QTJ4UERSNDZ0Y0orQVBjb0hEdTR0a3FERSt3S2QzQ2ZL?=
 =?utf-8?B?SzAyOGRZN1RUVkM3QVlvMllhNDRocVZHdldRN1hQUVBOK0NUcURCS3oxdE9B?=
 =?utf-8?B?NDA5NWJ3TG5NNGxQeFZ2aW1QSDZwWEFkbU9jVk4xSUVNQkEwOGNpdGtTSk5L?=
 =?utf-8?B?eEMvY3BUamdPcEdLM1ZHSkFKRkM2RmNzbVRHWDlacy9nUVFoMjVvWHM2UHhu?=
 =?utf-8?B?Z3o1N0taeWZjYXloRjl4emdSUjV4cE9UZTlkNlRIa2h2RGNkdGxCQ1NZVEJy?=
 =?utf-8?B?VDQwTXRkaG9zVC9uT1RRcDk5cHNVQ1BLK2R5c1JLSzlqaGZraGNoZ1VKUFkw?=
 =?utf-8?B?SWRLeHpmQnZsQXhJNXR1YldwRGdRRjdxdlFSMG1JS1crNCtTYXRlRnBJYkNO?=
 =?utf-8?B?T1NMZTlwREkxNjhDQXpiQjlNZXMwc2E2VkF1VkF1VWQ4ZUhncjgwT2RneDdq?=
 =?utf-8?B?cTlidzFmVFJiWjgxZ3BJc3lhR1gzTS9UVmM4YUZRSzc1ckF6dzJoMThRZ3M4?=
 =?utf-8?B?NUtxdFh3WnMwN3FBVTdyNnJ2OHAvUWU4Nm1FanRxcjBCcWN5bm8rdURqc2t0?=
 =?utf-8?B?dVBRN1dKK0NRc0NVcGpPbm0wRVJ3UGU2SHd0bFFQWkJqQmtrRXdURXo1UEtQ?=
 =?utf-8?B?RjdINWhsTUdVd09VMVpHVlREcVZrRTFqTlRMc0YwQzFONWYxY04wMGRJMEpP?=
 =?utf-8?B?SWkzMWluS3JBQmRxVlFaK0t1WUQ4U0JPRjlXWFVQRHNHYjJtNHk1QTlENGta?=
 =?utf-8?B?LzE1TytSZkxtN3g3Unk5N016WmZFOWk1am1kbFpyMjhQY1lKQnk5bm95NUIr?=
 =?utf-8?B?U3Y1YnBubi9XeEVLd29ha2hiQU5NdG9XbEZiUWNpUFlpc1VBUXhDZnJFZngz?=
 =?utf-8?B?cjBRSll3MU5DRmUvTWhqcWJBa3RaQUpWNTlQUEh5amd0MUlkcC96bG15bHFB?=
 =?utf-8?B?VVJDUjF0dXBSYk94V3YwUUY5emtMSTZZZVl1VlpwRUNtZXlneWgxcFJZY0R5?=
 =?utf-8?B?c1ZuN3o4cmNGL1FPOGp0Tm5RZ25ySWNQb1J2cTRNejJYeFRXQktwdnMxQUcz?=
 =?utf-8?B?dEdMN290c3AyWlFIR2lqR2k2U0pHenFzUi9kTDN0dHQ3WEFuaGlSVXk1UFpW?=
 =?utf-8?B?TmFDc1NEM1U2ZW1DR2YxdjRTQzBsNVVWWlh0RDRKTDFyUXdPK2QvcnlweG5s?=
 =?utf-8?B?ZzZKd3JXUzM5SnZVUjJRaTdhU09mNUYreTRvejc3SFp1dzg1Qk1XWjlSd2VJ?=
 =?utf-8?B?bkg3dWw3bjFDRDAyTmROaVpYRTlQSGdxb1pTczNBbThnS292bDNsMHpjZjJ5?=
 =?utf-8?B?emlCekRpeHlyOE5PNXB3N01MMXljTVg2K2t0NjhvbG42V3pLNDU5QzlZS21x?=
 =?utf-8?B?SUZkbVNXcW9IelBKUUppLzMySzB0NVFNWWJGby85MS9PM1dyRnZ3VE9UcWlq?=
 =?utf-8?B?ZHJ5dkxPT000SUIvRUhzOEQwL09Lb3Yvbzg2QWErSnVhQXNOdHpUbUVTWXZw?=
 =?utf-8?B?K0lXaER0a3JkMlBiZy9rK0NQWUVnSjdvYk5VRE9TbmtGb3Z1VCtPMnZzN2oz?=
 =?utf-8?B?RkhpTjZVdEN6VGlvY251ZittL3FVTDBGdEtrVzhjTE5XK2ZiSnEyOGttL0Fi?=
 =?utf-8?B?TzM1SVY1eWxBS0F2SnduTUdENzY1dlAraUdZZ21rdXFNbUJNUXpaREFEZitM?=
 =?utf-8?B?c3VPMmhZeWQwZkZyWlFGUk1IRVdqSUs3WjZEZUtpMGFIQXVvQWR6TkkvL09J?=
 =?utf-8?B?UHFxN3hVS2p5OTcyK2lUNENOS1IzYmszU0RwVlFjR21sZWo4dkZaM1B4aUFD?=
 =?utf-8?B?K3JINzYxL2RLME0wQ1hDZkF6MUpUb2lRbGh1RGZoUk9BTGNyaWVBdDRqQnc1?=
 =?utf-8?B?dlkyNHZiaTNNdlc2anQyUXQzMncvSHpzOURXVWxBMjJGeSt6SldRWEpyVnc1?=
 =?utf-8?B?UHBQTkdLRTFWT0JMeTZGaVUzeGNSVStqZXQ0b2xBVmdSOE1ML1ZqVHAxbmtw?=
 =?utf-8?B?dkZ6cDZiN2NJMFgrVlkyNWFtcW9BYjAyc3dtVTU3aEpqYjVDbFBnVWhKdmY2?=
 =?utf-8?B?Vmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <506BE7075F3B264E8BBC68818812CD5C@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	89QJk5oR9fBm12Jvoxsnw8mPo4+sDjZriyEHD+HeLueFz93oeFHmggmwcZPMYL52D5dQazOJEoWS3aW8bfIHcPTCsxdODK0VS10cbh9sd3GgoPInKz9y+ncXRjWBps1QyjjfvESxcHtLZ4DNcfACe7aFCEsfT6vWmQxNBsNPCm2YmvvUva3a6uy8sQbzfqRjlJKVRczFDRHQVIKsw/ikOf2tp7pBJouKQPQ5/VlQ4dXM62nbfa4TBNJL3felkLyzMrbQUJY7AI1nkLJy52HfuIP9kpQ9J1G17W//PHlRd1MBDqCwY/1rrlZcrnWYcT2kSF9K6BugtTjY4AggQh+YlW15qDSSpL3B6riZGQilD5DTnqVrmv5C6mJ9DrIm6klhkrr1iToox7NBdxD5HnhcuAqyiOFr7sJEfjoCtIBvk4RMx80OWIGpkjatEPxoDReCz+x36mEm89AtWazoUOVgROpj57eQHt/0b5TntQLAgrOuXcKmVNKdHfV0MAK9uau4uh4G80lsiuEFoJRPce8xwpkfMo1smUrBeQW4XzjVUY47H8PH9IUE/ZuB7jO2V1HT1tnRDSXE1w4vP9KTezyCM1jUGmfTX/Jym6HwvyQcN9E=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d7be766-0b8f-4d1a-c05f-08dc564f4cd6
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Apr 2024 15:36:17.1017
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Q0Ec/7X1al+7PGzWYdBTjBlMbrgyxOEdlN6FX4TMcUYhxlrG2wAZ0zGJff5XeShzNb/EyNvIx9lifzhIS+ouNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5057
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-06_12,2024-04-05_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 bulkscore=0 mlxlogscore=999 mlxscore=0 adultscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404060123
X-Proofpoint-GUID: XCXcnp6sB1cibQmi2uO1GOaRo__LiT68
X-Proofpoint-ORIG-GUID: XCXcnp6sB1cibQmi2uO1GOaRo__LiT68

DQo+IE9uIEFwciA2LCAyMDI0LCBhdCAxMToyOeKAr0FNLCBIYW54aWFvIENoZW4gKEZ1aml0c3Up
IDxjaGVuaHguZm5zdEBmdWppdHN1LmNvbT4gd3JvdGU6DQo+IA0KPj4gLS0tLS3pgq7ku7bljp/k
u7YtLS0tLQ0KPj4g5Y+R5Lu25Lq6OiBDaHVjayBMZXZlciA8Y2h1Y2subGV2ZXJAb3JhY2xlLmNv
bT4NCj4+IOWPkemAgeaXtumXtDogMjAyNOW5tDTmnIg25pelIDI6MzINCj4+IOaUtuS7tuS6ujog
Q2hlbiwgSGFueGlhbyA8Y2hlbmh4LmZuc3RAZnVqaXRzdS5jb20+DQo+PiDmioTpgIE6IEplZmYg
TGF5dG9uIDxqbGF5dG9uQGtlcm5lbC5vcmc+OyBOZWlsIEJyb3duIDxuZWlsYkBzdXNlLmRlPjsg
T2xnYQ0KPj4gS29ybmlldnNrYWlhIDxrb2xnYUBuZXRhcHAuY29tPjsgRGFpIE5nbyA8RGFpLk5n
b0BvcmFjbGUuY29tPjsgVG9tDQo+PiBUYWxwZXkgPHRvbUB0YWxwZXkuY29tPjsgbGludXgtbmZz
QHZnZXIua2VybmVsLm9yZw0KPj4g5Li76aKYOiBSZTogW1BBVENIIHYyXSBORlNEOiB0cmFjZSBl
eHBvcnQgcm9vdCBmaWxlaGFuZGxlIGV2ZW50DQo+PiANCj4+IE9uIEZyaSwgTWFyIDI5LCAyMDI0
IGF0IDEyOjE2OjU0QU0gKzA4MDAsIENoZW4gSGFueGlhbyB3cm90ZToNCj4+PiBBZGQgYSB0cmFj
ZXBvaW50IGZvciBvYnRhaW5pbmcgcm9vdCBmaWxlaGFuZGxlIGV2ZW50DQo+PiANCj4+IEkndmUg
aGFkIGEgY2hhbmNlIHRvIGxvb2sgYXQgdGhpcyBtb3JlIGNsb3NlbHkuIEl0IHR1cm5zIG91dCB3
ZSd2ZQ0KPj4gYWxyZWFkeSBnb3QgdHJhY2VfbmZzZF9jdGxfZmlsZWhhbmRsZSgpLg0KPj4gDQo+
PiBTbyBsZXQncyBvbmx5IHJlbW92ZSB0aGUgZHByaW50ayBjYWxsIHNpdGUgaW4gZXhwX3Jvb3Rm
aCgpLg0KPj4gDQo+PiANCj4gSGksDQo+IA0KPiBzdHJ1Y3Qgc3ZjX2V4cG9ydCBzaG91bGQgYmUg
YSB1c2VmdWwgaW5mbyB0byB0cmFjZSwgc3VjaCBhcyBleF91dWlkLg0KDQpUaGVuIHRoZSBwYXRj
aCBkZXNjcmlwdGlvbiBuZWVkcyB0byBleHBsYWluIHdoeSB0aGUgZXhpc3RpbmcNCnRyYWNlcG9p
bnQgaXMgbm90IGFkZXF1YXRlLiBXaHkgZG9lcyBhIHRyb3VibGUtc2hvb3RlciBuZWVkDQp0aGUg
VVVJRCBhbmQgZXhwb3J0IGZsYWdzIGZvciwgZm9yIGV4YW1wbGU/DQoNCg0KPiBDYW4gd2UgbW92
ZSB0cmFjZV9uZnNkX2N0bF9maWxlaGFuZGxlIGludG8gZXhwX3Jvb3RmaCAsdGhlbiBhZGQgYW4g
ZW50cnkgdG8gaXQgdG8gdHJhY2UgZXhfdXVpZD8NCg0KTm8sIHRyYWNlX25mc2RfY3RsXyogYWxs
IHJlcG9ydCBpbmZvcm1hdGlvbiBmcm9tIHVzZXIgc3BhY2UsIHNvDQp0aGV5IGJlbG9uZyB3aGVy
ZSB0aGV5IGFyZSBub3cuDQoNCklmIHdlIG5lZWQgbW9yZSBpbmZvcm1hdGlvbiwgdGhlbiB5ZXMs
IGFub3RoZXIgdHJhY2Vwb2ludCBjYW4NCmJlIGFkZGVkLiBCdXQgSSBoYXZlbid0IHNlZW4gYSBk
ZXRhaWxlZCByYXRpb25hbGUgZm9yIHRoaXMgeWV0Lg0KDQo8bW9yZS1pbmZvLW5lZWRlZD4gOy0p
DQoNCg0KLS0NCkNodWNrIExldmVyDQoNCg0K

