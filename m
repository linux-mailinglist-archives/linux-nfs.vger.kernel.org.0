Return-Path: <linux-nfs+bounces-7928-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38FC49C74B9
	for <lists+linux-nfs@lfdr.de>; Wed, 13 Nov 2024 15:48:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED6E6281818
	for <lists+linux-nfs@lfdr.de>; Wed, 13 Nov 2024 14:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 281547082B;
	Wed, 13 Nov 2024 14:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DgskIU0K";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="zKsHDwTM"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7B2C2AE93
	for <linux-nfs@vger.kernel.org>; Wed, 13 Nov 2024 14:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731509319; cv=fail; b=TOe3jbkgBCu6jkPQRu9NfOa6iJRM68Bz7BKsspa5axQNCtI9Txd51ash5mN6nnD1dxXnmmgCgbBBrlw3KWrXCWziIrM3+M+nxQDryTI6UYx6TSHPdxPh68vK4JDABNujZLUuxwhFitNMdCv885KdazXwFH4AQz7XBNMYQmeDXSQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731509319; c=relaxed/simple;
	bh=Nvu9uAeGSjHsRWyjrqsZbLEtZWbPbEY1HYPoYhUS9yc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=a/WqcVoj5wXBZytLz2//ClePMAUfzik8hdxKEi6w7PRq88PcRdKPXl/mExpOJWUQUxytD/QmEfYSRF98RzMpWI9NcEjewKeMGiCd+f8IhjeU9+qlDKcxt+U+5G3U8BYbeOKkT1pcNU4IqXqwM/laexgQsP7jjCfq2ZUWL+b2T98=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=DgskIU0K; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=zKsHDwTM; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ADDXXZF013703;
	Wed, 13 Nov 2024 14:48:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=Nvu9uAeGSjHsRWyjrqsZbLEtZWbPbEY1HYPoYhUS9yc=; b=
	DgskIU0KcC+mjxHST+qY6oJmxnO4kK3g8ghOsLjd9EKL3H3G8P1YUh/Mb1et1QL+
	fBUWJDk0fPDsTIomSulNoueZ+mw9u/QMyWJHtSXzLlPyxdn3tgFDSqesvV72sYjb
	QCRgXxHAKnal7j0gTCJ7/xNvVzSxRAqBgCu2MYEtfz8y168uV6A8IC8CofczavcX
	nzw5i2Bi8nr4G3aNtCTGguDa3BqNPBjaFagANGalyS9VcClhevuVkNhyvb13ZlIz
	R54+za62/w4PWHuvgG9d+vOEXS+kIW7V6HDEybYUbeDO2jSaWm9c7uLfdiJuTIK/
	gKhAr9qkcVZrzvQ8uXcMwA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42t0mbf37k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Nov 2024 14:48:24 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4ADE27RV025897;
	Wed, 13 Nov 2024 14:48:24 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2041.outbound.protection.outlook.com [104.47.73.41])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42sx69dtxg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Nov 2024 14:48:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ssOHbyGXggZUv++PoCzzslMquwbLsozgpib6JdwyEoDcUWhk4cJqCV1RMyOhkRvaeEHTbrWWMTHyRJt3Vb45+WGbFxz2hx1B3dht/hDNbDVClhkaa+0+zi7x+3W0ZbAnwlUHGPq8YfPJKaota5wIEQJIzI42nSZ6UPfbAiOtF0+C+JayMx69aejiwZ0XXGaFFRGr9Zqn4RJRD8xl9ce3utz/KLGI9ruf1tu6GV2HbliKqc3ic2kQxH+IkzHvC+/BTQ5AhL3L4MAFVfpnJ6is8kgZAGUQmS8w6SbM4Vl892dUEr7tPEjdbuc4YoYAK80QjDASUSzAvgNuhlqUE4Eh1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nvu9uAeGSjHsRWyjrqsZbLEtZWbPbEY1HYPoYhUS9yc=;
 b=pLXiLJWY7R19bCOFi/3xRdQW4FoxYEc2uUM8MYdfxnCax7tlBOaUbTCbiXLRNR6XYAiosRegUKuUPZ6VJV1PZFTa7GCTPmYgcvrc4lS9aucPzW48nBOaive9NZgDMvGd9RMv47aSTwIzpbVhm4gFsFZqgcVpZjr6SFrsnq3c/z5PHrcm0pvSno1MYAdMdT4bq7hU85ZjK3bCVceVRU4ORWr2ZLUpFCjEeRJViblXmVS27/RPPwtwpHA76JISMK4cvqqYOE1gSHWUt43WsD1im7/IrisU3nj89kE54rIq2s2V/LsEacUwP/2UGP9b1CCfnMrVfIKZp6NKUKnTk1Aj2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nvu9uAeGSjHsRWyjrqsZbLEtZWbPbEY1HYPoYhUS9yc=;
 b=zKsHDwTMOOJThMjowhdnFwZN3bG4iyTe8116etkXjMleFt2rZvbONLJzT1ZARb4Qh2HTsfeYHuD6CCxFCm2svUMswOS+Z24JoXYW7heALc9JsMWsNqEM4h/QZtHjC9hhHQ3K1bhLzP7wGBVK85ZTq5335MgkW/PnmDWv99u94gQ=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SA2PR10MB4795.namprd10.prod.outlook.com (2603:10b6:806:11d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Wed, 13 Nov
 2024 14:48:19 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.8158.013; Wed, 13 Nov 2024
 14:48:18 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Neil Brown <neilb@suse.de>
CC: Jeff Layton <jlayton@kernel.org>,
        Linux NFS Mailing List
	<linux-nfs@vger.kernel.org>,
        Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo
	<dai.ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>
Subject: Re: [PATCH 0/4 RFC] nfsd: allocate/free session-based DRC slots on
 demand
Thread-Topic: [PATCH 0/4 RFC] nfsd: allocate/free session-based DRC slots on
 demand
Thread-Index: AQHbNZB+I2ugB4SFwUqEUTTFEw3DubK1SvmA
Date: Wed, 13 Nov 2024 14:48:18 +0000
Message-ID: <03805410-2951-4BF8-BAA5-544F896E6DA2@oracle.com>
References: <20241113055345.494856-1-neilb@suse.de>
In-Reply-To: <20241113055345.494856-1-neilb@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3776.700.51.11.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|SA2PR10MB4795:EE_
x-ms-office365-filtering-correlation-id: 5efa46f1-8515-4f41-8b99-08dd03f23630
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?dE9UT05QTzRaSmNJTEtLbTRNTW0yTjhiZWVDRE5zMUF1ZUpEa25PQmNMUkdC?=
 =?utf-8?B?L2h0WnNSeUxuYjVNSGtXQWh4bDRvZ01IRnI3VU0reXFEMkRCUk9ab29GRzJS?=
 =?utf-8?B?UTFPYnFXOVRmSEtzMm9qNHZJcDNJcXAxNmlRU2grdWExYjZndWwwVVpRWGpL?=
 =?utf-8?B?RzlURkJUQUpWdC8wQkxFOVFNTXRXZTNUdVVkK0ZlMEtCdHMyL2pQNHhrdUwv?=
 =?utf-8?B?S0lXaDRYa1YvdlRHa1dPMzBLNWJjNEhmNm84aXB4M2trck55WmJSUzd6ZVYw?=
 =?utf-8?B?djRJMDNDMWRENGpBd2YrWHcrMVlpcjBHdGt0clFrUnN3QldyTHlRdXpLRlg0?=
 =?utf-8?B?Q2hucFQ3ZUlaYWEwTnBTMEZ5Y2hjcDJwUjFUZEwwNUs5WVZoVXpRWVEvL2ZP?=
 =?utf-8?B?MVFGcmIxeWZycDJ4eTNicyt5NDNSd1ZoS2x3SlM0VERoYy9SQmNTMEJheXc4?=
 =?utf-8?B?UXd2ZUlWQUphYXkwYkRXVmxqOG9ZSkhMVzRtMnFaSU5BblB4NHowQnp0bXRQ?=
 =?utf-8?B?cWpIZEY3RlJJNUhoMS9OS2dHSDcxNjZYV2QvUzNteG4xczUzelFic0xSWW1V?=
 =?utf-8?B?Q2o4TG1PalpHS2JYRS9PSkpHL3I5MGNraXU1NytBWWhlQ1IzQnpCNGtiQ1Qz?=
 =?utf-8?B?cHBKdmwrbFBjUXR6VWhZdHhTQno3UUhVd25xZ00wN2s2VkZYV1J1TkFWd1Vo?=
 =?utf-8?B?VjJVS0V2dGtDRTVSZEx1eERKZFhNbG5MeG5WYythK1VtUG1tWStWU0xjaWFS?=
 =?utf-8?B?SjMwN1VpdW8vSXVERDhmUUtnZWtkQjlwaWFsME43UXMrT3QvaFZIV2E5VG1z?=
 =?utf-8?B?bUZVZzRnc3JIcDZMMXI5cGhZUEZQcnhKMTV2QVdyRHBDNktldTJwckMxd0tN?=
 =?utf-8?B?YmkvNUVFcWtnOXJCRmJFVDhZS000NkNWNC8yQmVqbit0bms4NFVXQVVlbHBi?=
 =?utf-8?B?NC9JRWQ3OUMrSS9UVFV2SHA3TERTbEl3YWIyWjFYQVFzZzZicnB3djZhdnI3?=
 =?utf-8?B?RjBIdTZzdFY5aVl5c0ExSzM0RFhPYmlKZml6OTlFbkdYUWFlUitvTm5aWi9o?=
 =?utf-8?B?Q0FWNXJyVmI3amhZcU5UekdzTi9peFRyN3FQaTZZREtJTFI2R2c2aWlPNXY5?=
 =?utf-8?B?ZERQUnIwUzMwK3F0MkhtNk4rL28vQ0pvejhab0Voa2grT0YwdGFINUJyRHBK?=
 =?utf-8?B?TTluUGZySXhIem5TYnZuM0p4YmRDRjErZTlyOFMvQlQ2d0UwUG1GcmEzOVZ1?=
 =?utf-8?B?Zk55QVJxN1ljd2NRckRJMUFhdEVCeVcvbmpPdGhWTG8xV3dUUzdLK2lkZUI3?=
 =?utf-8?B?a0dnT283N0JVRHZXTWZEMUhPV3pmUmFjbE5GZlNpRytaZ3NHQ1B1cUxlVVRm?=
 =?utf-8?B?ZndIRFgvMHFzNWd4UFZaMFRjQW9scnJYSzFxS0pvK0dMdi8reDBPSm5ueS9O?=
 =?utf-8?B?SjFDazB6N0tTWHRBdkZJaDdRRUY0YXJmOVk0L1U5Y0lGK05oZGx1MVBPc1c2?=
 =?utf-8?B?QkxqZk5iUmlKc0ZxYW9qeGh6VzFRL042TmpMV2lLaWJaNCtzRFgvdEdtOXla?=
 =?utf-8?B?V0VkZ0FQZGg2VTBOQis4ME5tQWwrem9Nb2M3V3QvSDNMMXpiQ1YwelJrcWJa?=
 =?utf-8?B?VU85MnBlc3lSK2xVcmZQNTE2dmFMSzdzQWZuekprUGRiNnRkc3h6T1M4Zlp2?=
 =?utf-8?B?d3M2djY4djhPcFUzU1lBMVhhOTZtS3k2Y2RpQmhZUXV3NWFIWDIraVNSUDBJ?=
 =?utf-8?B?clhIcXpaa2xlNnhPaXUwcXVBUXYreDlzTnMybUdUNW45blRUOFJXcGtTQUhZ?=
 =?utf-8?Q?kH5r2JFhbFcn9c/IGyLY1CBnFVpYYCMsESFp0=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Rk8yTE5qQ0ZVb1ZsdGh6L3k1N1hYZjlSUnloTmtPTWJ2RnJoN21HYWhadTlB?=
 =?utf-8?B?R2tOb3duWmdITUxnSUxybU56SGtoRDBjUFVkamZtdTFWV3haVklFUFNlMEE1?=
 =?utf-8?B?cHM3aG56cUJZdEtpZFVlSVB4ZmMwbXJ4STBSN1JFRnU0akxpWjZ5NGNiTkNO?=
 =?utf-8?B?Qy8vck0yQTUxajJDRXJOWjUxRngzK1BvbnpxNTRwM2xNWXVoa1pjdEk5MUpD?=
 =?utf-8?B?VnhWaytueUpJcXVqN1pVVmY3WENoZUtBdWdJQ3Z5RU1jTzE5YVZYVE9sVHpa?=
 =?utf-8?B?OVd0QlhjVWZZQzJubkR5em9pcGMwUiszeXlieGpKWUpPL3llRkpqMXg3S09J?=
 =?utf-8?B?bjBhbmhMdmE5blEwbyt0RWljR280OWE5Sm56UU5ySVpCdTZpZFdyOGZwL0FE?=
 =?utf-8?B?cXRCak1mOW5HaW11Y0pjY01GdXNXcWg1L2l1amFabElvam4vOEliRHRJeTdU?=
 =?utf-8?B?eW9wWmZkUjN1MElyMnJFSzdsbm5ITm1vMmRwSEhMWVVPVTZOOHdrYmVrZzk1?=
 =?utf-8?B?R1owYUJ0L205bVhibHVGVlR3N2h2RFZhT0h0SHFIU09PV2xtMC83QmdzVjNi?=
 =?utf-8?B?SUtSY1FXUWJFdFpubmNoSGp1T0grZzlLQnQ2SnM5RGFiZk83ZGZkUkZCMU95?=
 =?utf-8?B?RWdMUjE4OWRMajRRN091c1YvNVdqNFpqbDYrU3ErbnBCdUlBckRzSHBlc21H?=
 =?utf-8?B?dEwwbHNrZm9sMmErT09JaWY4Mzl0UmxwVHdQL0hBU3FVUDFpdzJuVDZwNFVQ?=
 =?utf-8?B?SGpFMVdYT0dOQUliM0hNellXb1RTOHZFNm1iV2FEUWZ0cGhXVG1EeFRnTmhC?=
 =?utf-8?B?VzFEMUk3ZFJpQjZQM0t3N3NpMDJ5TjBEUno3SE1jeVFRdUMwS0FCMENBNHZm?=
 =?utf-8?B?WE5oUnB3eFdIMC9TeUpsQWkvcVR3WmVVUE5yb2R3RFYvcERySkpGSzhxdjhn?=
 =?utf-8?B?TGZicjRVUUgwWjdtbTM4Y043akhwRjhKWXdGckdFSHRYTU5Dd3Nsd2k4L2Iy?=
 =?utf-8?B?TnI1UnFhR1ZJekZ0U0F1VnhwYXJpZjgyREo1T2ZQRlJneDdBVXltQlNvK0xr?=
 =?utf-8?B?SGZxSm41eWdweWJkMnVYQlpwMXBCVlBvNmpoaHc4bmR4ZGFqcGVYL29zUitQ?=
 =?utf-8?B?Mm5XZlNoZUJkblhWbHpFWmhYcmd2SEVYWW1oM0RIZVd3MGFlNkd0clVGRmJ3?=
 =?utf-8?B?dk44VWtRVWdpb0NlTjdUSkM4dzlYZjBON29LYnNnV216ZGRkV2VRNzZhUXNE?=
 =?utf-8?B?cFBBbngrOHppV2RKbC9BNXhtUlErL2VKSFR4Z3lJc3lLMUVUY1pzOEE1eDZC?=
 =?utf-8?B?SXhvSlBydDdYTnVrV3g1clVabVRrZUJ0KzRVN0hERnpOS2xrZFdOcTZLQTE0?=
 =?utf-8?B?d2ZrY1VuRkR1YnF1eFR5TkE4elhMUE9HWHAvdHRXMjBuc1ZDNDYyOU9lUXJ4?=
 =?utf-8?B?ZkZ5d0JNZzZJNG5nWGMyZWgyRHBvTHNwcWVvaklEc2k1Vk80cFZJanJNOEIv?=
 =?utf-8?B?TVV4TzI4a1RMY0hJRy9lSm8vRVpHbW5oQjFJa2pOY0t6eWZqL2JUUis2cTQx?=
 =?utf-8?B?bzI2NE1mYjlDZWNpSFdxa3RVamtiemdERHFTdTc4VG5jbGkyZGVYVnJzdkI3?=
 =?utf-8?B?SEJSTi83Nk9zcktQcEN2cnlLMVVLcDVSV2o1UjV5bjBqSzhQczBSVzJlbExR?=
 =?utf-8?B?b1kwSU44NDFtRWZqMitNUmlXMkp5SDY0TlIycHJkTW1yTk5ZUjVVcDFpZlpC?=
 =?utf-8?B?ZjZzTE1ScnVVWVF4RVBzQ3RNKy84VExZNWY0UExxdmxnY05PcFFCQktwWi9q?=
 =?utf-8?B?VzROc1Q5M3pJZUlSWEZXOXhNbEdIRnVOcDY3WDYxUmtjanVBTCtIa3U5cUJ4?=
 =?utf-8?B?a3g3cnBZNDNJWjhiL2R3YVJVZW96VlJWUzZqVHJKVXdnQW1XUEYxK3pMUkdw?=
 =?utf-8?B?KzRtcW1ieVIvOTJrWE91dnhLeVl2aDBNU0s1eFNLL1NTQ25mellyaXhXaFFz?=
 =?utf-8?B?RXovaEp2aW1ITHQrSVZJN3RHL3M5MWdqZVVncWhkRUVIb3VidlVjNTJuZWsx?=
 =?utf-8?B?c1RXeENjeGpGbjhld1RiZ3p6cWVBejZYSkdXOVRYNDNHS05GMUNVSlFKcWc4?=
 =?utf-8?B?MkxJNG44NE9ObGY0b29ZSE5JOUdRK0tsUkc1czNCYWxqejBBVXFtNlZPaC9N?=
 =?utf-8?B?Wmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8312CC64A33A624E8066D4F005F77587@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	t87se/nFi2U9GrESeMFfRaAQUQphdQGwkXNl++N+gyFwzNnFLTaE+kNRrGIkKCDJFWPQMu+v1xJAsh+G2EQF7EhtJg38kFrHf94B52e+kVBJmOpbpNuyjI/OX3OFYj6fjKOC17wgfFgj067kU9stTUeIHtTXXLNZBTtbLBnLOQLzTl1mfcdTWlH3vuazTxptoUlRZoDtVjvvAaSe6t9QqBzXgitSu05jQgKZ4QXKYpAVJUIPoYddJrTxmi978ubZ4rjBWANHbIEH7zbQotdxge2/aq9fTBDtTp+vGHbYnyiNy4pf+0dMogJC+uusLnbQlVcMMV1Z/NSE5RAsbOWHT/uJ5mRlO1F8+6i/dPrXPe302BfZZ8JA36jIasl4+3UzYtJCF46koBBHkKgyk1woR6w+r535BOZs+ZFEpJZf9NVh16tjlniGYH+u8DcqJ94eSJ+Q8YApQ/62x5P8eZ2Rh9yNgHkeyV99O4yXLOm+bGJSIQK5ZncMqf5Bm1Pixstrt+Ih5tvCpwxjOosVkGy1n8g3/88uocv5HS5ZzCTM1oyOyCWiL8oiojQvqn22M7tlR4SfAvi4Ikw6FSMbC8o1gWf/TJk67Omxnyd+6ib3Cjo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5efa46f1-8515-4f41-8b99-08dd03f23630
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2024 14:48:18.2227
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1EazCv2xbmb7OESGV7pVpjlKYfUbaK4TxGOJS5X59rkuVG1ANCdVsrmfN2rgnJ9Fg6rdgegC/jWlaMZ1j7AZ+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4795
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-13_08,2024-11-13_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 spamscore=0 bulkscore=0 phishscore=0 mlxscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2411130125
X-Proofpoint-GUID: yAsJCz-Klq7qHQaMim1P5KnyfDR5jwy2
X-Proofpoint-ORIG-GUID: yAsJCz-Klq7qHQaMim1P5KnyfDR5jwy2

DQoNCj4gT24gTm92IDEzLCAyMDI0LCBhdCAxMjozOOKAr0FNLCBOZWlsQnJvd24gPG5laWxiQHN1
c2UuZGU+IHdyb3RlOg0KPiANCj4gVGhpcyBwYXRjaCBzZXQgYWltcyB0byBhbGxvY2F0ZSBzZXNz
aW9uLWJhc2VkIERSQyBzbG90cyBvbiBkZW1hbmQsIGFuZA0KPiBmcmVlIHRoZW0gd2hlbiBub3Qg
aW4gdXNlLCBvciB3aGVuIG1lbW9yeSBpcyB0aWdodC4NCj4gDQo+IEkndmUgdGVzdGVkIHdpdGgg
TkZTRF9NQVhfVU5VU0VEX1NMT1RTIHNldCB0byAxIHNvIHRoYXQgZnJlZWluZyBpcw0KPiBvdmVy
bHkgYWdyZWVzaXZlLCBhbmQgd2l0aCBsb3RzIG9mIHByaW50a3MsIGFuZCBpdCBzZWVtcyB0byBk
byB0aGUgcmlnaHQNCj4gdGhpbmcsIHRob3VnaCBtZW1vcnkgcHJlc3N1cmUgaGFzIG5ldmVyIGZy
ZWVkIGFueXRoaW5nIC0gSSB0aGluayB5b3UNCj4gbmVlZCBzZXZlcmFsIGNsaWVudHMgd2l0aCBh
IG5vbi10cml2aWFsIG51bWJlciBvZiBzbG90cyBhbGxvY2F0ZWQgYmVmb3JlDQo+IHRoZSB0aHJl
c2hvbGRzIGluIHRoZSBzaHJpbmtlciBjb2RlIHdpbGwgdHJpZ2dlciBhbnkgZnJlZWluZy4NCg0K
Q2FuIHlvdSBkZXNjcmliZSB5b3VyIHRlc3Qgc2V0LXVwPyBHZW5lcmFsbHkgYSBzeXN0ZW0NCndp
dGggbGVzcyB0aGFuIDRHQiBvZiBtZW1vcnkgY2FuIHRyaWdnZXIgc2hyaW5rZXJzDQpwcmV0dHkg
ZWFzaWx5Lg0KDQpJZiB3ZSBuZXZlciBzZWUgdGhlIG1lY2hhbmlzbSBiZWluZyB0cmlnZ2VyZWQg
ZHVlIHRvDQptZW1vcnkgZXhoYXVzdGlvbiwgdGhlbiBJIHdvbmRlciBpZiB0aGUgYWRkaXRpb25h
bA0KY29tcGxleGl0eSBpcyBhZGRpbmcgc3Vic3RhbnRpYWwgdmFsdWUuDQoNCg0KPiBJIGhhdmVu
J3QgbWFkZSB1c2Ugb2YgdGhlIENCX1JFQ0FMTF9TTE9UIGNhbGxiYWNrLiAgSSdtIG5vdCBzdXJl
IGhvdw0KPiB1c2VmdWwgdGhhdCBpcy4gIFRoZXJlIGFyZSBjZXJ0YWlubHkgY2FzZXMgd2hlcmUg
c2ltcGx5IHNldHRpbmcgdGhlDQo+IHRhcmdldCBpbiBhIFNFUVVFTkNFIHJlcGx5IG1pZ2h0IG5v
dCBiZSBlbm91Z2gsIGJ1dCBJIGRvdWJ0IHRoZXkgYXJlDQo+IHZlcnkgY29tbW9uLiAgWW91IHdv
dWxkIG5lZWQgYSBzZXNzaW9uIHRvIGJlIGNvbXBsZXRlbHkgaWRsZSwgd2l0aCB0aGUNCj4gbGFz
dCByZXF1ZXN0IHJlY2VpdmVkIG9uIGl0IGluZGljYXRpbmcgdGhhdCBsb3RzIG9mIHNsb3RzIHdl
cmUgc3RpbGwgaW4NCj4gdXNlLg0KPiANCj4gQ3VycmVudGx5IHdlIGFsbG9jYXRlIHNsb3RzIG9u
ZSBhdCBhIHRpbWUgd2hlbiB0aGUgbGFzdCBhdmFpbGFibGUgc2xvdA0KPiB3YXMgdXNlZCBieSB0
aGUgY2xpZW50LCBhbmQgb25seSBpZiBhIE5PV0FJVCBhbGxvY2F0aW9uIGNhbiBzdWNjZWVkLiAg
SXQNCj4gaXMgcG9zc2libGUgdGhhdCB0aGlzIGlzbid0IHF1aXRlIGFncmVlc2l2ZSBlbm91Z2gu
ICBXaGVuIHBlcmZvcm1pbmcgYQ0KPiBsb3Qgb2Ygd3JpdGViYWNrIGl0IGNhbiBiZSB1c2VmdWwg
dG8gaGF2ZSBsb3RzIG9mIHNsb3RzLCBidXQgbWVtb3J5DQo+IHByZXNzdXJlIGlzIGFsc28gbGlr
ZWx5IHRvIGJ1aWxkIHVwIG9uIHRoZSBzZXJ2ZXIgc28gR0ZQX05PV0FJVCBpcyBsaWtlbHkNCj4g
dG8gZmFpbC4gIE1heWJlIG9jY2FzaW9uYWxseSB1c2luZyBhIGZpcm1lciByZXF1ZXN0IChvdXRz
aWRlIHRoZQ0KPiBzcGlubG9jaykgd291bGQgYmUganVzdGlmaWVkLg0KDQpJJ20gd29uZGVyaW5n
IHdoeSBHRlBfTk9XQUlUIGlzIHVzZWQgaGVyZSwgYW5kIEkgYWRtaXQNCkknbSBub3Qgc3Ryb25n
bHkgZmFtaWxpYXIgd2l0aCB0aGUgY29kZSBvciBtZWNoYW5pc20uDQpXaHkgbm90IGFsd2F5cyB1
c2UgR0ZQX0tFUk5FTCA/DQoNCg0KPiBXZSBmcmVlIHNsb3RzIHdoZW4gdGhlIG51bWJlciBvZiB1
bnVzZWQgc2xvdHMgcGFzc2VzIHNvbWUgdGhyZXNob2xkIC0NCj4gY3VycmVudGx5IDYgKGJlY2F1
c2UgLi4uICB3aHkgbm90KS4gIFBvc3NpYmxlIGEgaHlzdGVyZXNpcyBzaG91bGQgYmUNCj4gYWRk
ZWQgc28gd2UgZG9uJ3QgZnJlZSB1bnVzZWQgc2xvdHMgZm9yIGEgbGVhc3QgTiBzZWNvbmRzLg0K
DQpHZW5lcmFsbHkgZnJlZWluZyB1bnVzZWQgcmVzb3VyY2VzIGlzIHVuLUxpbnV4IGxpa2UuIDot
KQ0KQ2FuIHlvdSBwcm92aWRlIGEgcmF0aW9uYWxlIGZvciB3aHkgdGhpcyBpcyBuZWVkZWQ/DQoN
Cg0KPiBXaGVuIHRoZSBzaHJpbmtlciB3YW50cyB0byBhcHBseSBwcmVzdXJlIHdlIHJlbW92ZSBz
bG90cyBlcXVhbGx5IGZyb20NCj4gYWxsIHNlc3Npb25zLiAgTWF5YmUgdGhlcmUgc2hvdWxkIGJl
IHNvbWUgcHJvcG9ydGlvbmFsaXR5IGJ1dCB0aGF0IHdvdWxkDQo+IGJlIG1vcmUgY29tcGxleCBh
bmQgSSdtIG5vdCBzdXJlIGl0IHdvdWxkIGdhaW4gbXVjaC4gIFNsb3QgMCBjYW4gbmV2ZXINCj4g
YmUgZnJlZWQgb2YgY291cnNlLg0KPiANCj4gSSdtIHZlcnkgaW50ZXJlc3RlZCB0byBzZWUgd2hh
dCBwZW9wbGUgdGhpbmsgb2YgdGhlIG92ZXItYWxsIGFwcHJvYWNoLA0KPiBhbmQgb2YgdGhlIHNw
ZWNpZmljcyBvZiB0aGUgY29kZS4NCj4gDQo+IFRoYW5rcywNCj4gTmVpbEJyb3duDQo+IA0KPiAN
Cj4gW1BBVENIIDEvNF0gbmZzZDogcmVtb3ZlIGFydGlmaWNpYWwgbGltaXRzIG9uIHRoZSBzZXNz
aW9uLWJhc2VkIERSQw0KPiBbUEFUQ0ggMi80XSBuZnNkOiBhbGxvY2F0ZSBuZXcgc2Vzc2lvbi1i
YXNlZCBEUkMgc2xvdHMgb24gZGVtYW5kLg0KPiBbUEFUQ0ggMy80XSBuZnNkOiBmcmVlIHVudXNl
ZCBzZXNzaW9uLURSQyBzbG90cw0KPiBbUEFUQ0ggNC80XSBuZnNkOiBhZGQgc2hyaW5rZXIgdG8g
cmVkdWNlIG51bWJlciBvZiBzbG90cyBhbGxvY2F0ZWQNCj4gDQoNCi0tDQpDaHVjayBMZXZlcg0K
DQoNCg==

