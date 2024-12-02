Return-Path: <linux-nfs+bounces-8310-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE24E9E0D56
	for <lists+linux-nfs@lfdr.de>; Mon,  2 Dec 2024 21:51:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B6DBB263F2
	for <lists+linux-nfs@lfdr.de>; Mon,  2 Dec 2024 20:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EDC855887;
	Mon,  2 Dec 2024 20:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XyK3+DDv";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="I3mfd44X"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9F711CABA
	for <linux-nfs@vger.kernel.org>; Mon,  2 Dec 2024 20:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733169755; cv=fail; b=bwHUJZJ9joyL0kaTZZKp/sQggwmrUpScBj6BEudMAOy5Vr4hbSh+WQkEXbLH6Mz85lVeOKi51kt+DsoyGpOfwuRvTuA/4fdOzPhkap2hn36EmPxSZwM7EjKs3inBF5y23PV8QQw3iPl/CFg9RP6uGH1B4e6ZbgPCAPrPKoTSpTg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733169755; c=relaxed/simple;
	bh=gZERKkEsctLGGsbrgiXA/00fvpdMKqbdoWki3QlcljY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=exDgu2Ik45jo8Yo0NlMDbjnwE3N2VO+DM6UQHELCFkkQfit1QO7fwNqadzbzQMt39qA+2zAjKAbW5Em+5sqzsD+214fAL94OLMKlpOlGihKk3v1iYkVnEFXdf0zcmNxomuKs9f6VV3wUeCfs0zcowM/hSPKwsZO73G/fkbF1mPg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=XyK3+DDv; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=I3mfd44X; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B2HfdFv014323;
	Mon, 2 Dec 2024 20:02:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=gZERKkEsctLGGsbrgiXA/00fvpdMKqbdoWki3QlcljY=; b=
	XyK3+DDviaCB1x10UimpEbeq9i8iFHmNX+PTxhg7/lRsFSXZYB9u2DbtiC4Ya3kn
	cqrDh2nIj1ZYrNZkiUN/eJSzkkAeZYELVjDXEtINxTgjNYxEykRl4LfD+5DrXhli
	i69DzIh9bsHcwYxiqcQovWy3vcK6rw4BPjAKE7bND+6RfGNn0EqKZkPUP71cPsNI
	Wy5gTgUCIbFRjfiC/bLLfoqgs3sCLSM4Hn/Jq4HcQ2l5DViJSEzFVRiD3DFSbdjd
	ZpcHQJqYqf0jxq03bOsfFox9EJ9n4qHPF0I69sarBfggCa51uNA69ybyegr0041v
	cI2jOw2KAe43GcQvMYFE6w==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 437s4c4h28-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 02 Dec 2024 20:02:19 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4B2JcBkT031430;
	Mon, 2 Dec 2024 20:02:19 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 43836t0vv3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 02 Dec 2024 20:02:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mIZ9hi0KFydWAZQd0XpKBGyRIgqHOJ0K9r1qdR3D3+WehdgLjgjACaEGVeDsuMIGgHJNjZBYT3ZLYF1+IR2JCIOq2tcUzOI26X9cCvPFybKq1VMzSWS7guS5i2PPMYPzCEZ178I9xuNmNtWLoi5N3yT/hG3YbiWmBN8xH7tqFRDB1FbqRdmHzzCcO1cZPJMJXqO99WPMF+dxxIfzfDhyg41wyymx8LiaIW/NGw+rYW7VqRx02+CsqGUIwNBQRewt8OB+yOgky1cqChFYBrphBWaqKeIxSMVOLLiT+oYQIo89m+RMxjFav2xV1uEyIlYF4UeyHbBCmA91iRd2wnPEDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gZERKkEsctLGGsbrgiXA/00fvpdMKqbdoWki3QlcljY=;
 b=xwc9ZXdQ4XWiyPyRojl/eENonmp7V6fDGqgYwgDBC+YmQ8/lTOyuk1LaoHOgN7I8iNvERA1jKfgBEqpG2osoioi0CZ/R51V7PJ5GaIFAJfYFKEzelOLlrIB33VB4kuMV9ySyJLIoKQl5a69+Wz39Kzg79h0aHTCAVGckCR940VGjICJqbMi63mMCU2RdvIIcJT/cbLlJBJWU2yLNAhUXWTmiPBCCTYEAl52xUP//2dHedhOrQS0r9i2PV/5sdriVt2AWTlWk7H8LoyrQLAcSkXU4PyaXmwCUNJcxz06MB49/MFkJQJPxp+2WR5oMz7gdRpa5GmobuHPzuUbQhgW1qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gZERKkEsctLGGsbrgiXA/00fvpdMKqbdoWki3QlcljY=;
 b=I3mfd44XsBnDf9J76AASgUUvKQ9/M5IKdbmIDQtJcI1bWL5gafGwgbAkmOyn8tYtwvKjY/QPG6pJ0/eowCukNm+vObNdANF2oPZv5AWfg1k3anqDghOm/hgIyFzsvChKEIZT0f2qQnQgABHC2dHvmhlJfaMcvh4xC0MkPCvFj58=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by IA0PR10MB6745.namprd10.prod.outlook.com (2603:10b6:208:43f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.19; Mon, 2 Dec
 2024 20:02:16 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%7]) with mapi id 15.20.8207.017; Mon, 2 Dec 2024
 20:02:16 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Steve Dickson <steved@redhat.com>
CC: Salvatore Bonaccorso <carnil@debian.org>,
        Sam Hartman
	<hartmans@debian.org>, Anton Lundin <glance@ac2.se>,
        Linux NFS Mailing List
	<linux-nfs@vger.kernel.org>
Subject: Re: NFSv4 referrals broken when not enabling junction support
Thread-Topic: NFSv4 referrals broken when not enabling junction support
Thread-Index:
 AQHbFbWgp2fWmvplk0mUZs37kCic+rJ8qeAAgBMlywCACDnYAIABGh+AgDAwSoCAClAlAIAAFk4AgAADKACAAAEsgA==
Date: Mon, 2 Dec 2024 20:02:16 +0000
Message-ID: <A8C1C88C-35D5-43D1-B848-1E0CF337F1F6@oracle.com>
References: <Zv7NRNXeUtzpfbJg@eldamar.lan>
 <e7341203-c53c-4005-9d70-239073352b2b@redhat.com>
 <ZxUVlpd0Ec5NaWF1@eldamar.lan> <Zxv8GLvNT2sjB2Pn@eldamar.lan>
 <1fc7de18-eaf0-4a1e-bd41-e6072b0f3d7f@redhat.com>
 <Z0VVLw9htR7_C5Bc@elende.valinor.li>
 <e86284ac-7a77-440b-bb5d-bdb1e6f23a40@redhat.com>
 <Z04OnJtb1oDl5sfd@eldamar.lan>
 <328fdce3-a66b-4254-a178-389caf75a685@redhat.com>
In-Reply-To: <328fdce3-a66b-4254-a178-389caf75a685@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3776.700.51.11.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|IA0PR10MB6745:EE_
x-ms-office365-filtering-correlation-id: 39be10ec-af62-4048-f286-08dd130c383c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?WDRRTVY2NXhpcTBqMTI4NzA0a2VrRGEzUGoyekl2T1A0Wmp4aUpQM1VINndC?=
 =?utf-8?B?T0RwRDJHMmkxUjhiK2xRSncyb2gvbEdYell6dW5oY1hWNEVjcDJScDVjSWxH?=
 =?utf-8?B?Rjc2cTVMRkU0VTJvUFRscHpCZ05OejU5WWlob0pSdXFGWmxBa0hkQlVlVzkz?=
 =?utf-8?B?NFIyWmU0cU56NFd2VDRzMFVEWTRJTlpoU2RBZi9wU0hmUUxxWTJsRm04UDBH?=
 =?utf-8?B?QThiWmpwQ1QzODlOUXp1dnkxbnNzSDhrTit5NDJwMVpWV0NyeVJFMnRlZDFU?=
 =?utf-8?B?T04vS2gzU3hURTJQVDI0YzlJWmo2Vk1SeUpBRFBzSTV0L0E1MXMwTWhSangx?=
 =?utf-8?B?TURQOVpOTGRoV1JVa0hhTkJ1cVd2TXpiRnkyc202NFJqNkdSNis1V1RMWXY3?=
 =?utf-8?B?bXdWcXhuZ2NDY2UzYWFmdjdha1FiYkJ2NElzbEd4UFlBQkhOa1Z4bmtPWm9z?=
 =?utf-8?B?WExiUFI1c0ppbjhDWG44Z3NNZE9oSCtxVDBWOHRkK2k5VzltREIwV1JFT09R?=
 =?utf-8?B?ck1RZGZQQmoyN0M3aVFlM2kwMzY2RXdpaEhYYkMrdGIxR0VIS0VZaS9wcDEx?=
 =?utf-8?B?QVFlWUFOdXdHYW1LWjZMNks1ZFY4aFdOVFRRWHBNSlVDZ0dGemZEYXZRVHFm?=
 =?utf-8?B?U0gxL29sR2R6SENnbkVRS2ZGQXBGOUd0SXNrdGNadllMQ0s2aVNHM2tJc1A1?=
 =?utf-8?B?NzdnWkVMKzBySFUxcFF1V3dIeFJVOTFQOHFDNURWeFNVNlpxa2RjbENsa1h1?=
 =?utf-8?B?SldXYVBWVkhsTy9NOFlGQVlDR085Mlp1WjcvVXh0TGI3cE16UGl5d0RzRVht?=
 =?utf-8?B?STZ0eWRERDNRZnVpcFhhMTh6MW55LzlhK3dIVTBnbkdIZDN6a1hjTnJJRGFW?=
 =?utf-8?B?NlNOUXNRTkVWNUZiV2wyTjlHM1dvMXhQeW8wN3h2TGxxelpzVzVzdzg5UWhj?=
 =?utf-8?B?VUNEQXZEUWxTV2twZEZySUp6TGgrZ1duR3lBalhnb2k0dDlLOWhDM1JLdlJM?=
 =?utf-8?B?akhtcWlNUytoVDJYY3RaU0ZyNGNVTGM3dlJFQmxMclQ5cUVJZkdiWE92alVy?=
 =?utf-8?B?Z29HSDZDTHhRbk5aVmZZUC9OTnpZK2pwSzNuNWRLNkt3cFhvajZqN29WRTlT?=
 =?utf-8?B?S2NTaCs2VzRhWGZwdTEvZ01QeVluWUhSN0pjU2pZb0YzNW9PMjN3ZmZkWk5r?=
 =?utf-8?B?dFRCdTZTWitYRkd2Wkd3NDZzSzgvVFhVVmhYenAyMmloWmxNRU1yaGl1VXFY?=
 =?utf-8?B?Ujk1WlkreU02ODdDQnpUNTVERWx1cnpZNHczZU5meCs1NlQ1TW11K2U2S05x?=
 =?utf-8?B?ak5XWkIxM0ZsQ1oyOWFQOHpRM2VUVXBlTXhXK3R2UUdxdHRDSVZpNFp4bHdk?=
 =?utf-8?B?Qkl4YXRZU2tQMFB0aitsSlZPZCtwbit5cVM2NEozQUdXZWVxQTN6V0EyOUR6?=
 =?utf-8?B?ZlZ6c2ZjNnRzQ3Q5SGxRY29qNWE5Zm8zUzZ6dmJ2cFNEYnY2UUZzakkzcDcx?=
 =?utf-8?B?TTByUktuNzIrUVZNTEZUOFhLUjNxWFVKb2FRRE5hWEVuMzFSME9BUzh2aFoy?=
 =?utf-8?B?cmlNemtyNFBsRmZ4VmljOHNmZE5HUGZobXMwdHNtc3Azd1NmQ0lQWmFrTnZv?=
 =?utf-8?B?M21NSVpPcUhYUTVEU3U1TFczMmk3QmR3N1B3ZmYvTHFwK2tZdUFBVTBqN2oz?=
 =?utf-8?B?dDNpQlYzSVZMUHFkeW5ET1U1dE5RN0VYTVZKTHlmOVpldThxV005N0cva3Ba?=
 =?utf-8?B?WXdrNVFtbFJNWTFPYVoyRGF0UU9FT05zcXNLbVFpcG1panE2ekRCWjNFZXJt?=
 =?utf-8?B?YXlyaDVWMUpDeURlSytyTys2UVltSDZCaGRSOFZYczF4M2JocDlqZGRxMERE?=
 =?utf-8?B?K1VsQnNSczJBdzRDeTBrdlhXN2dTWm5kV3NmY05rbXFmaWc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TElScSt1YlFsYmxPdndQclhlZVF3bUZxZjJ5ZWZCOURjVnI4bmNhd3VwRm5a?=
 =?utf-8?B?Q0ZaZXFCQkVSMEx3YjZsUEhZNENhdUVUUFlTZjhKelEyaUZzWHFSdDE5ZkZT?=
 =?utf-8?B?VVBaT2w5L2NPV2FBdzloMXVVUUQxWktrWmxZSndDd2QwS3hxU1JLVGJKUjV2?=
 =?utf-8?B?d1JpaGVKeklzeVFnc0JPcjNITHNnb1hhRnRaOEFOR2pYakFNSmxrMmt4M2JN?=
 =?utf-8?B?dVl5MWFmU3ZPVHYwV1dnMWg0VUFzMm5hMHVRMTVET0hRZHRkWnRiZFdjMnBk?=
 =?utf-8?B?Y2V3ZS9MUzBpd05qS0xMakphWUE1M09xVTJwVmdCNE5yVDIrRThwdzdWZUl3?=
 =?utf-8?B?OFdzZzl5aXpOUkZOaWo0Tmg5Um0rQVppV3lUaFpreTg4WFpqekw0bXBDYU9u?=
 =?utf-8?B?VzNWeXN5aGIwWFF4cmRzSEhQSXNFbUpRdDRVL0g3ZU9HOUptdC9BZHdYOWow?=
 =?utf-8?B?QXpoSXNNK3RzOUpxcWdwRjFhUlBaS2k5UG13eDh1MzhkNzgrRW1NOHMzOTNn?=
 =?utf-8?B?VnNGYnhQY051NjNPNU02V0djd25nNEdCVEtaeHBpYW9RdEk5NStFYzNERld6?=
 =?utf-8?B?RnBBWTRESWNZcU5uMXVFYUhySkJNVG5wYTFoTDJUQlNuMjMzcDZzSGJPOVJB?=
 =?utf-8?B?cDE3QXVKVWpNOEVjMEl1b0JtUldvZTJEVjU4OTdUdUFocW1ZRDN4RE9nS2dO?=
 =?utf-8?B?S0hGQmpnYTVwUzVlTGtuV2NuUWd1STFLbHZ2ckFOOWdoR3ROMUtPeVJvVlFZ?=
 =?utf-8?B?c3gxeDJxZG1iUDJKeitBTGFHbnZuazd4OXd4R2p3MlJqbVRQOFVIMEtoakZV?=
 =?utf-8?B?WitkRkQ5aDhnbVd0aXpJZXptZjlKQmVVdUttZFc5TVd5K3d0ODhaakxTcGlH?=
 =?utf-8?B?YnlIdkVZbnBzQkgvR29FY01kVkR1NTN6eDBGVUZ5UGhoS2FocWN3RFp3TStE?=
 =?utf-8?B?M1Eyd0NpRHlzWDdnREMrdmczaVBlbWl3c0tHR1hpSkl4clB1bUxVNG1XcWI5?=
 =?utf-8?B?TmF4V09sa2NLQ05WQ1l5WG5mdlF6aUhUd01nOXoxa3MrU3hmQkhLY3YrckRr?=
 =?utf-8?B?c0trNFR2OTZmN0dKM2xadm1KVElOZ05Wam9MOEJRU1ZVbWh1clBEUmFvbnk1?=
 =?utf-8?B?L0lxb2FhTk03aFRuRy8xc1Q5WmlJajZFeHduN1pOSTZYWjZnYmhJQVJrZ05W?=
 =?utf-8?B?OGRSa0EvRkhNVEkxK0RWYXcrV2ZRaGNCdzRXQmFtRldXWDkzZ0VrY1VuRWQv?=
 =?utf-8?B?MXRuR0kwYTRXZnpzK0wzT1RxTFlmS0VyN3ZLVG1MeGVjYU44WWFVZTZncHI5?=
 =?utf-8?B?M0RrVjdXZTF4MkdSOUdzV3ZJSGFHTXcrSXVwbmphZXQrN0JlN0VzQkZQS0ZJ?=
 =?utf-8?B?SnBGcVBRbStBTXlHNzNGWXlZaHh3UWpwMEcxcEs2OFhtKzAzRE5rcHBOZzBQ?=
 =?utf-8?B?QjhkTlRHVUhPMGlWTDhGbC9ZQmpKWWxGTFFKQnREbXNLWkxRcWFGMjY1NHRG?=
 =?utf-8?B?TWtNWnp2N1pSazY2Y1BrSVJYblNRd2doWS93Y2xubVBINEM1cUM4ZTJNTUdv?=
 =?utf-8?B?cnFGQXF3Q1dHcjhJREVjVmxwMFBDNFNXdTFMdlAvWDBnYVphWEltOEdLSWdj?=
 =?utf-8?B?bU1hWW1KNjR2bmVqd0NGcVRMeTFEd1FCaW1jWXRLUUhCUTM2SFNTdXc1bTY2?=
 =?utf-8?B?eVZhZFpqRVVyYU9FWm1hNU1hVDNKOEhvNVYrUDRxZW5BREdSR3l4Z1lKOHJl?=
 =?utf-8?B?ZTdSV08ySUZKL1RtK0x2UmFWb0gyczk5NUR2WGFwNEd0bUF6OUhmREMySGF4?=
 =?utf-8?B?NjhEL3FMZGZCalplS1JKaGk5djVPVnZ3VUF2SHJVSllaZHFHUVBGdC8rZ1dF?=
 =?utf-8?B?REc3SlV5dEtiTzBoc2M0RC9IYmlrWGRBUmtXdGN1MEJEYnpOM0pXZW0yVncv?=
 =?utf-8?B?dW5Vckd4dnYvbEJucnV5QU9wLzF2QVZJbU1DemtkOTZEYUJxSWYyNC9uZkVC?=
 =?utf-8?B?a1FaWEJzM1BScEFzWnNNWjkwT2dnZ2NQVFhnWHhEMk1qQUh0ak02N2tZMEJZ?=
 =?utf-8?B?dktybjZ4dlQ0QXdaWXltdTZubUM1b2lHc1NDVG5zWHJkMWVoZFQ5ZmNxVnNH?=
 =?utf-8?B?YTlGS2phbjZHT0dla0g4dVhCYUwyREM2UHBSZGhwZ1doS00vKzVKTDJueGh5?=
 =?utf-8?B?VHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1B20E80C6F461742A120B9C1B4A80C79@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	m4+gBa8BNDAunKUlSm9+uVh/ZVkYAoNrrXpjUJKFkxRhgrqZqgTPAWyb3mPTSCw0knZE/jTtWeCFMjc1x0/bFl+LGRMY9YzUyZr88N3jJzRmgmIQeG8v6EQuLjwSVljxBHWTf2IgoFjykSdUgdMeZ3S+qHrGmNXZ4REFPGQKvYpEkCein9Qe18YOfOpQ4O4qOcb4/GBsWlwKNfe88lTU8lXU3tQHKy/8KszuOaa3IM73+82A+woxc8F3pMtJ/PSHOvLOPPNYW3Uu6kqMXVI82eEq8ahKsF1hPhUax9zuFeF6KxruJYvaqt/L+BlTRnzKthksRGMvz43Zo22nxXYbA4+UZ826z2Mn9uvtFog6HXeeXoFAv3mZ+n89FqP85b4426129QAn7030CEVRb8Idr6DV53Xa/dir0QDE3BS/XkeN/dLR9pamhsksw1FPa0IrcNpLuE8kYDfVFN+E3X6A9kFYUObX2J/MzcMns31fqYxzqcqD8bXS1my15t07+hsDySrmD+fl0jQHLFipuDvAdPYdto5kxRfF0qwttY5A3fg7QDD3nqD3+B35XbO3eBp9bGCZno/jqN+PY0xcaA0g6+a06YXKuLdTDOiAXsRGpTs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39be10ec-af62-4048-f286-08dd130c383c
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Dec 2024 20:02:16.0265
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0mF5JiFHA4Z3RWkGviahRRmRXf84iWzRk6FukmlukyXE5bP87bLIF+Td+OKrXbHgVLjaWksbYfTf0OiYBrEFVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB6745
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-02_14,2024-12-02_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 suspectscore=0
 malwarescore=0 bulkscore=0 spamscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412020169
X-Proofpoint-ORIG-GUID: jqTN1DQd_I0hZvJEcf-kT22kzZ-w0YC4
X-Proofpoint-GUID: jqTN1DQd_I0hZvJEcf-kT22kzZ-w0YC4

DQoNCj4gT24gRGVjIDIsIDIwMjQsIGF0IDI6NTfigK9QTSwgU3RldmUgRGlja3NvbiA8c3RldmVk
QHJlZGhhdC5jb20+IHdyb3RlOg0KPiANCj4gDQo+IA0KPiBPbiAxMi8yLzI0IDI6NDYgUE0sIFNh
bHZhdG9yZSBCb25hY2NvcnNvIHdyb3RlOg0KPj4gSGkgU3RldmUsDQo+PiBPbiBNb24sIERlYyAw
MiwgMjAyNCBhdCAwMToyNjo0NlBNIC0wNTAwLCBTdGV2ZSBEaWNrc29uIHdyb3RlOg0KPj4+IA0K
Pj4+IA0KPj4+IE9uIDExLzI1LzI0IDExOjU3IFBNLCBTYWx2YXRvcmUgQm9uYWNjb3JzbyB3cm90
ZToNCj4+Pj4gSGkgU3RldmUsDQo+Pj4+IA0KPj4+PiBPbiBTYXQsIE9jdCAyNiwgMjAyNCBhdCAw
OTowNDowMUFNIC0wNDAwLCBTdGV2ZSBEaWNrc29uIHdyb3RlOg0KPj4+Pj4gDQo+Pj4+PiANCj4+
Pj4+IE9uIDEwLzI1LzI0IDQ6MTQgUE0sIFNhbHZhdG9yZSBCb25hY2NvcnNvIHdyb3RlOg0KPj4+
Pj4+IEhpIFN0ZXZlLA0KPj4+Pj4+IA0KPj4+Pj4+IE9uIFN1biwgT2N0IDIwLCAyMDI0IGF0IDA0
OjM3OjEwUE0gKzAyMDAsIFNhbHZhdG9yZSBCb25hY2NvcnNvIHdyb3RlOg0KPj4+Pj4+PiBIaSBT
dGV2ZSwNCj4+Pj4+Pj4gDQo+Pj4+Pj4+IE9uIFR1ZSwgT2N0IDA4LCAyMDI0IGF0IDA2OjEyOjU4
QU0gLTA0MDAsIFN0ZXZlIERpY2tzb24gd3JvdGU6DQo+Pj4+Pj4+PiANCj4+Pj4+Pj4+IA0KPj4+
Pj4+Pj4gT24gMTAvMy8yNCAxMjo1OCBQTSwgU2FsdmF0b3JlIEJvbmFjY29yc28gd3JvdGU6DQo+
Pj4+Pj4+Pj4gSGkgU3RldmUsIGhpIGxpbnV4LW5mcyBwZW9wbGUsDQo+Pj4+Pj4+Pj4gDQo+Pj4+
Pj4+Pj4gaXQgZ290IHJlcG9ydGVkIHR3aWNlIGluIERlYmlhbiB0aGF0ICBORlN2NCByZWZlcnJh
bHMgYXJlIGJyb2tlbiB3aGVuDQo+Pj4+Pj4+Pj4ganVuY3Rpb24gc3VwcG9ydCBpcyBkaXNhYmxl
ZC4gVGhlIHR3byByZXBvcnRzIGFyZSBhdDoNCj4+Pj4+Pj4+PiANCj4+Pj4+Pj4+PiBodHRwczov
L2J1Z3MuZGViaWFuLm9yZy8xMDM1OTA4DQo+Pj4+Pj4+Pj4gaHR0cHM6Ly9idWdzLmRlYmlhbi5v
cmcvMTA4MzA5OA0KPj4+Pj4+Pj4+IA0KPj4+Pj4+Pj4+IFdoaWxlIGFyZ3VhYmx5IGhhdmluZyBq
dW5jdGlvbiBzdXBwb3J0IHNlZW1zIHRvIGJlIHRoZSBwcmVmZXJyZWQNCj4+Pj4+Pj4+PiBvcHRp
b24sIHRoZSBidWcgKG9yIG1heWJlIHVuaW50ZW5kZWQgYmVoYXZpb3VyKSBhcmlzZXMgd2hlbiBq
dW5jdGlvbg0KPj4+Pj4+Pj4+IHN1cHBvcnQgaXMgbm90IGVuYWJsZWQgKHRoaXMgZm9yIGluc3Rh
bmNlIGlzIHRoZSBjYXNlIGluIHRoZSBEZWJpYW4NCj4+Pj4+Pj4+PiBzdGFibGUvYm9va3dvcm0g
dmVyc2lvbiwgYXMgd2UgY2Fubm90IHNpbXBseSBkbyBzdWNoIGNoYW5nZXMgaW4gYQ0KPj4+Pj4+
Pj4+IHN0YWJsZSByZWxlYXNlOyBub3RlIGxhdGVyIHJlbGFzZXMgd2lsbCBoYXZlIGl0IGVuYWJs
ZWQpLg0KPj4+Pj4+Pj4+IA0KPj4+Pj4+Pj4+IFRoZSAiYnJlYWthZ2UiIHNlZW1zIHRvIGJlIGlu
dHJvZHVjZWQgd2l0aCAxNWRjMGJlYWQxMGQgKCJleHBvcnRkOg0KPj4+Pj4+Pj4+IE1vdmVkIGNh
Y2hlIHVwY2FsbHMgcm91dGluZXMgIGludG8gbGliZXhwb3J0LmEiKSwgc28NCj4+Pj4+Pj4+PiBu
ZnMtdXRpbHMtMi01LTMtcmM2IGFzIHRoaXMgd2lsbCBtYXNrIGJlaGluZCB0aGUgI2lmZGVmDQo+
Pj4+Pj4+Pj4gSEFWRV9KVU5DVElPTl9TVVBQT1JUJ3MgY29kZSB3aGljaCBzZWVtcyBuZWVkZWQg
dG8gc3VwcG9ydCB0aGUgcmVmZXI9DQo+Pj4+Pj4+Pj4gaW4gL2V0Yy9leHBvcnRzLg0KPj4+Pj4+
Pj4+IA0KPj4+Pj4+Pj4+IEkgaGFkIGEgcXVpY2sgY29udmVyc2F0aW9uIHdpdGggQ3VjayBvZmZs
aXN0ZSBhYm91dCB0aGlzLCBhbmQgSSBjYW4NCj4+Pj4+Pj4+PiBob3BlZnVsbHkgc3RhdGUgd2l0
aCBoaXMgd29yZCwgdGhhdCB5ZXMsIHdoaWxlIG5mc3JlZiBpcyB0aGUgZGlyZWN0aW9uDQo+Pj4+
Pj4+Pj4gd2Ugd2FudCB0byBnbywgd2UgZG8gbm90IHdhbnQgdG8gYWN0dWFsbHkgZGlzYWJsZSBy
ZWZlcj0gaW4NCj4+Pj4+Pj4+PiAvZXRjL2V4cG9ydHMuDQo+Pj4+Pj4+PiArMQ0KPj4+Pj4+Pj4g
DQo+Pj4+Pj4+Pj4gDQo+Pj4+Pj4+Pj4gU3RldmUsIHdoYXQgZG8geW91IHRoaW5rPyBJJ20gbm90
IHN1cmUgb24gdGhlIGJlc3QgcGF0Y2ggZm9yIHRoaXMsDQo+Pj4+Pj4+Pj4gbWF5YmUgcmV2ZXJ0
aW5nIHRoZSBwYXJ0cyBtYXNraW5nIGJlaGluZCAjaWZkZWYgSEFWRV9KVU5DVElPTl9TVVBQT1JU
DQo+Pj4+Pj4+Pj4gd2hpY2ggYXJlIHRvdWNoZWQgaW4gMTVkYzBiZWFkMTBkIHdvdWxkIGJlIGVu
b3VnaD8NCj4+Pj4+Pj4+IFllYWggdGhlcmUgaXMgYSBsb3Qgb2YgY2hhbmdlIHdpdGggMTVkYzBi
ZWFkMTBkDQo+Pj4+Pj4+PiANCj4+Pj4+Pj4+IExldCBtZSBsb29rIGludG8gdGhpcy4uLiBBdCB0
aGUgdXAgY29taW5nIEJha2UtYS10b24gWzFdDQo+Pj4+Pj4+IA0KPj4+Pj4+PiBUaGFua3MgYSBs
b3QgZm9yIHRoYXQsIGxvb2tpbmcgZm9yd2FyZCB0aGVuIHRvIGEgZml4IHdoaWNoIHdlIG1pZ2h0
DQo+Pj4+Pj4+IGJhY2twb3J0IGluIERlYmlhbiB0byB0aGUgb2xkZXIgdmVyc2lvbiBhcyB3ZWxs
Lg0KPj4+Pj4+IA0KPj4+Pj4+IEhvcGUgdGhlIEJha2UtYS10b24gd2FzIHByb2R1Y3RpdmUgOikN
Cj4+Pj4+PiANCj4+Pj4+PiBEaWQgeW91IGhhZCBhIGNoYW5jZSB0byBsb29rIGF0IHRoaXMgaXNz
dWUgYmVlaW5nIHRoZXJlPw0KPj4+Pj4gWWVzIEkgZGlkLi4uIGFuZCB3ZSBkaWQgdGFsayBhYm91
dCB0aGUgcHJvYmxlbS4uLi4gc3RpbGwgbG9va2luZyBpbnRvIGl0Lg0KPj4+PiANCj4+Pj4gUmV2
aWV3aW5nIHRoZSBvcGVuIGJ1Z3MgaW4gRGViaWFuIEkgcmVtZW1iZXJlZCBvZiB0aGlzIG9uZS4g
SWYgeW91DQo+Pj4+IGhhdmUgYWxyZWFkeSBhIFBPQyBpbXBsZW1lbnRhdGlvbi9idWdmaXggYXZh
aWxhYmxlLCB3b3VsZCBpdCBoZWxwIGlmIEkNCj4+Pj4gcHJvZCBhdCBsZWFzdCB0aGUgdHdvIHJl
cG9ydGVycyBpbiBEZWJpYW4gdG8gdGVzdCB0aGUgY2hhbmdlcz8NCj4+Pj4gDQo+Pj4+IFRoYW5r
cyBhIGxvdCBmb3IgeW91ciB3b3JrLCBpdCBpcyByZWFsbHkgYXBwcmVjaWF0ZWQhDQo+Pj4gSSB3
YXMgbm90IGFibGUgdG8gcmVwcm9kdWNlIHRoaXMgYXQgdGhlIEJha2VhdGhvbg0KPj4+IHdpdGgg
dGhlIGxhdGVzdCBuZnMtdXRpbHMuLi4gYW5kIHRvZGF5IEkgdG9vayBhbm90aGVyDQo+Pj4gbG9v
ayB0b2RheS4uLg0KPj4+IA0KPj4+IFdvdWxkIG1pbmQgc2hvd2luZyBtZSB0aGUgc3RlcCB0aGF0
IGNhdXNlIHRoZSBlcnJvcg0KPj4+IGFuZCB3aGF0IGlzIHRoZSBlcnJvcj8NCj4+IExldCBtZSBh
c2sgdGhlIHR3byByZXBvcnRlcnMgaW4gRGViaWFuLCBDYydlZC4NCj4+IFNhbSwgQW50b24gY2Fu
IHlvdSBwcm92aWRlIGhlcmUgaG93IHRvIHJlcHJvZHVjZSB0aGUgaXNzdWUgd2l0aA0KPj4gbmZz
LXV0aWxzIHdoaWNoIHlvdSByZXBvcnRlZD8NCj4gUGxlYXNlIG5vdGUgc2V0dGluZyAiZW5hYmxl
LWp1bmN0aW9uPW5vIiBkb2VzIGRpc2FibGUNCj4gdGhlIHJlZmVycmFsIGNvZGUuIGFrYSBpbiBk
dW1wX3RvX2NhY2hlKCkNCj4gDQo+ICNpZmRlZiBIQVZFX0pVTkNUSU9OX1NVUFBPUlQNCj4gICAg
ICAgIHdyaXRlX2ZzbG9jKCZicCwgJmJsZW4sIGV4cCk7DQo+ICNlbmRpZg0KPiANCj4gU28gdW5s
ZXNzIEknbSBub3QgdW5kZXJzdGFuZGluZyBzb21ldGhpbmcgKHdoaWNoIGlzIHZlcnkgcG9zc2li
bGUgOi0pICkNCj4gZGlzYWJsaW5nIGp1bmN0aW9ucyBhbHNvIGRpc2FibGVzIHJlZmVycmFscy4N
Cg0KRGlzYWJsaW5nIGp1bmN0aW9uIHN1cHBvcnQgaXMgbm90IHN1cHBvc2VkIHRvIGRpc2FibGUg
cmVmZXJyYWxzLg0KUmVmZXJyYWxzIHdvcmtlZCBsb25nIGJlZm9yZSBqdW5jdGlvbiBzdXBwb3J0
IHdhcyBhZGRlZCwgYW5kDQpzdG9wcGVkIHdvcmtpbmcgaW4gdGhpcyBjb25maWd1cmF0aW9uIHdp
dGggdGhlIGNvbW1pdCB0aGF0DQpTYWx2YXRvcmUgYmlzZWN0ZWQgdG8uDQoNCg0KPiBzdGV2ZWQu
DQo+IA0KPj4gQ29udGV4dDoNCj4+IC0gaHR0cHM6Ly9idWdzLmRlYmlhbi5vcmcvMTAzNTkwOA0K
Pj4gLSBodHRwczovL2J1Z3MuZGViaWFuLm9yZy8xMDgzMDk4DQo+PiBSZWdhcmRzLA0KPj4gU2Fs
dmF0b3JlDQo+IA0KDQotLQ0KQ2h1Y2sgTGV2ZXINCg0KDQo=

