Return-Path: <linux-nfs+bounces-5614-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4B9395CE89
	for <lists+linux-nfs@lfdr.de>; Fri, 23 Aug 2024 15:59:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED8A4B25AD6
	for <lists+linux-nfs@lfdr.de>; Fri, 23 Aug 2024 13:59:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0970188596;
	Fri, 23 Aug 2024 13:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cM1GgAck";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="CpMorTsf"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A073188595;
	Fri, 23 Aug 2024 13:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724421547; cv=fail; b=u7CbYQZH5qIJNYP07snnNzCoCSEn2lBg+x0uxToDtbmCUA1teOkCnYYUKgUqGAw9fEmWEvuzsVTbB7wbzbMvHuM3WtFsrzwzJH85p4V33Iaah6KWYpercG5lOHHbQwG/c9OXylzW20u4j2BOHm0fx0Y48iDv2yUok0ziIuJB7JI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724421547; c=relaxed/simple;
	bh=uDlpGXHnIw6Iog2s42mR4MTGA2w4AZac1tb7GH7aXmA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AJLAb1/Hq2hKqZlBZHOlf+7oQX6FE5D7o9lag2VGoHXk8WcStgaP15P9d7wyIV8n/yj1hkv0T8Nr23E+ASDW7p0uMnLz30r3w/OCyPnr9qmrf74x6RtH9LuFSRkbsHmYgh3rSsp+G7FSpRkQT3iA/kBUtEMQb/zjhH+Ahyh5oNQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=cM1GgAck; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=CpMorTsf; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47NDMXNM016759;
	Fri, 23 Aug 2024 13:58:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=corp-2023-11-20; bh=uDlpGXHnIw6Iog2s42mR4MTGA2w4AZac1tb7GH7aX
	mA=; b=cM1GgAckap2rW/I8XTF3NB7qPWcRNBzrevlmW8NPLJSNme008wRuyWmqo
	HWe6OsMZ0oJGx0Drp4BnDa8BnTrecfSO+9Mv5ER76892S2r3ijAvQszx5ERlbbQP
	2C2AK5W+mJRdYIYLCnjZa9yQcBsPTbc1pWj6s9RiTgm/uCvlV0BBTZfLJLw0DsdO
	nk5PoT3lkA8F7NaMawfbDf4OyyQRFSRxxkpSskiMSvFk7elKprIP72qwzmWe0ITj
	iEbVcSJ/f4vb3FXgcYZ9BdD5TX2gTbZBMMpUDs7+LNgl5mjhysyd/T240zw6IuS2
	1Gh3VVgoqPRWdNhV3Zum89ODicHjA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 412m45mesf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Aug 2024 13:58:52 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47NDNYsH006729;
	Fri, 23 Aug 2024 13:58:51 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2048.outbound.protection.outlook.com [104.47.70.48])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 416u90149d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Aug 2024 13:58:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o8tlN8lY0vPiFb9PBsgWO6yPHUcCow5ioU6HyH9i/lVEvMxxXwVqIZgxaJ3fwI0H3fw2Dn/OMKHUdjJs/YMCbokfj4bKy59X51WKJ5vx2P9wtdjLQlItfu4+Ne6zs2QX46rrMnVbIBW1JHrh/ysR1qUizL7KmLxhIMtNJi59p6zReodG2iw+EMFXKcVknM7HNZVy4la5ISFcj+eQk66G81E1T3F7NEuI+YmwK7IGI02U1rtRaZIS2GY3uekZ4yDnJeuKjstWJt4Ruj0jMBpIVBQFVVsXRjB56/L+G6GxnisoVXWMac/27VK2toLcXeOm9U5moqxxbkxb4s/RpZInUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uDlpGXHnIw6Iog2s42mR4MTGA2w4AZac1tb7GH7aXmA=;
 b=UA2Sjhv7azpOlc71uGo/xIzSDsHe24N6d/2jIsa3zB+BAa6Lz7b/Pft7XV8G8SV74ba/K8qJ+DykKwcjqDZHIev0HM8nS4DCqHVegW/P0uNut8bUrl/KvwLK+zqV5aOBsiMhfAXahIbPOuy+flgz3Hs4L0q47izBMewWzbZmuEbfCsahDKuKXsBimrIV+DaM1JZXtRgA2hS5Xcw5Vvt1eHVm/1pgRpfMYBFIJI+i8Xvu/7icFWH6V6Z5gbIV2q4RKG+1K35b9FQ+btjoYBlvu571VI73GqK3XwKwnKNbOullALXDP9AAAOe6CHVhJ6nBvkBfXcO+Q70mUH6yv8kPWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uDlpGXHnIw6Iog2s42mR4MTGA2w4AZac1tb7GH7aXmA=;
 b=CpMorTsfTy8zEVL6IhijznpZymkK0K7n8jZR+B/UZvoJmttKjW/Ls0imK55oX1yHrxOE1eaCFqGIv26mtuB+P8BNEB71Byfk3qLT7TMGZiOBsDzAcYkDzcgkiP7vuwxEvNfB0D1qhJIa0k9y2rlrSCSce+v8kojeyIVeKHb3AmI=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DM6PR10MB4218.namprd10.prod.outlook.com (2603:10b6:5:222::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.12; Fri, 23 Aug
 2024 13:58:49 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.7918.006; Fri, 23 Aug 2024
 13:58:49 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Petr Vorel <pvorel@suse.cz>
CC: "ltp@lists.linux.it" <ltp@lists.linux.it>, Li Wang <liwang@redhat.com>,
        Cyril Hrubis <chrubis@suse.cz>, Avinesh Kumar <akumar@suse.de>,
        Josef Bacik
	<josef@toxicpanda.com>, Neil Brown <neilb@suse.de>,
        linux-stable
	<stable@vger.kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v2 1/1] nfsstat01: Update client RPC calls for kernel 6.9
Thread-Topic: [PATCH v2 1/1] nfsstat01: Update client RPC calls for kernel 6.9
Thread-Index: AQHa7i0UNj/LC/EjQE2iBvWdTJluHbImuy+AgA244QCAAHiwAA==
Date: Fri, 23 Aug 2024 13:58:49 +0000
Message-ID: <0BDD1287-471E-47A8-A362-DF660806CED6@oracle.com>
References: <20240814085721.518800-1-pvorel@suse.cz>
 <Zrytfw1DRse3wWRZ@tissot.1015granger.net> <20240823064640.GA1217451@pevik>
In-Reply-To: <20240823064640.GA1217451@pevik>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3776.700.51)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|DM6PR10MB4218:EE_
x-ms-office365-filtering-correlation-id: 23e1e480-184f-454d-3f68-08dcc37bb686
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?cHRTUUJ2aEtKWjJoUzVRdlZTQmlwSkpGNkpxMzB4TnR1S0crMjJ4dCtUWnVY?=
 =?utf-8?B?Y2V5SzI5d3ZnbCsrMkFBc0txd1hYemtVSmszYitHUWR0WXFzTlY1V0tEZ0M4?=
 =?utf-8?B?Q0pQSzhtY2U1MGh5UUkzZ0NkZ2k1VXNmMmdaRlFyenNLbzdKN1dheFRmL0lO?=
 =?utf-8?B?SnBoYk9WV1NLdi81NWhTMk1IUGc5UDJmNWdIck1lMlhyNkIzcFhUSS85SEVy?=
 =?utf-8?B?OElIT0JLeG1FaXBPSnFmdGl5WlQ1YTk5ODV2QXVNUm5XckVVckdsRjVnSUFG?=
 =?utf-8?B?MUd3d3JPVFFCQjl3ZWY4N1I3MlRscEV5S1JzeXozcENHVHNPcDZqdWQ4NXZa?=
 =?utf-8?B?Um0vUjcwcU1nbUFuZ0FUc1drS0RpaFY3T3hnUHVFeEppTGM2ZWt1aU1qRGdq?=
 =?utf-8?B?cXc5TnZ4b2liTWQ2TXBuV1ZFYjRSTi9XajJMVzJRNjZDNzI2em0zTVcyOGk4?=
 =?utf-8?B?SXlOTmdLUG5IWTJpcXVBU21KZlNHd2ZmakYxODVJOW1ESExQWTBNTytvWm5m?=
 =?utf-8?B?NnpaL2I1aHRzNDc5TGc1ZU1Penh0NkIxTUhsS2hCSkhXVjBtUzQ4QkZOWkJO?=
 =?utf-8?B?L25BcW9iT3hDMnJxOStXaDBCMnBzcEhzSTVWeU9sMmRVbloxMlM2bm96N2xa?=
 =?utf-8?B?L0ZPM0k0aXN5eUl5UW0vMG9nZ2szZ2h1V3N3OUtPaVhEczNNdjhkZVhpTFNL?=
 =?utf-8?B?Wis5b3JoR01vNjc5Y05RMGtSMUxyQ1JEVnJtTWtEUnlqLzFqdUxmdDhTRTJU?=
 =?utf-8?B?RVhoNjlCejcvNCtKNTNmQ2QwNmtzd0lEdDBvTktIbmt1QXNkcS95Q2R3U2py?=
 =?utf-8?B?ckE0Nk1VOXA1RGJTVEJKR3N0VVFGRWEvL1UyNmdRY0dJNFcxRXpickZmWWhQ?=
 =?utf-8?B?NDA0elVpZU80SThDdmlzakh5bkVjNzZwQ2NIY29ibkpjbXF6UlJYcmFXaW9T?=
 =?utf-8?B?VnJ6QThja0RtanJPT3dNcVVENkZmV3N1T0taVitvYzlVRFB5WVkwVGZGZElS?=
 =?utf-8?B?SDRxYXBtcXlCeXBDRVAzQmFxendvM2Iva1NpRnQ2YlNabmVyR21OYUh6S0wv?=
 =?utf-8?B?TmU0dGR6NU1JeFBuUithYzNzZFpnSm56QTNZSFd5RGVRbnhJbWl5NzNoR2FH?=
 =?utf-8?B?TFVXRDNOT1VLTGxvSVZWVUJQRVFTNUIycHpLOTU0blNCTm0wdGF4TmJxMTRo?=
 =?utf-8?B?UkdybU9Jd3VKSEhBZWJONDljaWIxVFdLRHBrUkRrZnRRUiszRmRhVCsxWG5a?=
 =?utf-8?B?YktnSy92ZDFrSm5WeUVHeFR6Z2FwTUdyRDNTK1AzTi9BT2QwTjJ1Vit4WWIx?=
 =?utf-8?B?R2xBb0duL2VDWkpLeHVIekpjZDM0cjBobnNPYkxqdThMZVhDUkM0dVV0bHpW?=
 =?utf-8?B?WU1OcWJ5c09jejV0djVTdlcyYlBTYVJPNmdIMit3OEljaGlDMGZxZjgrbnY5?=
 =?utf-8?B?K00xRDQ0SWZSL21jVGpBTVdLdVFsSzVCT2k3UmpMVVpHQ2EyV2JQT3RUL0g4?=
 =?utf-8?B?dGZ4Z2wvSDIybktIUUt6dWJEVHRIb3JWcGR1ZWNsZmV0aS9DTWU1ai9HYk9n?=
 =?utf-8?B?cXFIaHZrTkNCZjNheW16VEUySW1DYnBsV1ZvK0Q2UjRkeWhVdU8xQXlVRnZo?=
 =?utf-8?B?dVA5OG94ZUkrS2pUUGt1WE9qRjJZMzFnL29QZ2liczFWUjhncVR4U1J1T0du?=
 =?utf-8?B?VURTS29FZWUyMlNiMkpuQk45Ly8rZUF0RFk5dmxDRE92MEl0REN6a202UjNG?=
 =?utf-8?B?OU9BSG4xN2ZHZThCbEtWbm9iV3RIdUkvUDJ4UUN2LythSUpUMGNLSUgwZjlL?=
 =?utf-8?Q?9uNioUwkuACiZArzp3xa/sgpKsSqXEzokqVKA=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?alpLWDF2Z1ZPaUlyeXVVdEEweWZvcDdoaFRHMkp5ZDN3eEpmM2EvRkd4V2Qz?=
 =?utf-8?B?WE43dFQrM3NQcGNGRnVRUXBYRndYYmk1Ykw5Z1g2c256Um9kbk14Q3ErdmpZ?=
 =?utf-8?B?UXpmL1dJeDVObmVJVjJPMURhdmhCOTdvVW1uejFNR2VEalVRZXY5MlE3TkRq?=
 =?utf-8?B?MFpvQk54dmNmYjdXbUFkcVdON01MUC9mYWo1bWRyNU50eHU2bmd6cVIycWFH?=
 =?utf-8?B?bGpiM2dPMzFtR1o2UHRKU09Lb3gyQTB1NW5LQVBURkxUZjEzZE53UVNKNWFr?=
 =?utf-8?B?M3l1S0VoelR6WGVObXUxRDQzaEZqNlNQZjVRQlprdXk0djh3OUhVNXEzaElB?=
 =?utf-8?B?VnRyUWFmaE44UzVMa2lVd3picmZ0S21DbDFOdDNIazZtOWV3QXJMM2htZ2N5?=
 =?utf-8?B?REdJQjhIWnVMY3Y2YmhSMmhTYU5TZ0ltNFZhaUFsQXljZ0VDK3F2dnpKT1du?=
 =?utf-8?B?WUtsMWpkWm90d1JCL0RsQ2JmeVM5QW9OK0ppQVRiZCtJREtGMXdEbDFvWFRp?=
 =?utf-8?B?a1J3QURqbWVMTUtWZkZMV3BlZ2RIMnFkVU43REhmVjVpQXlkUEdNamltc2VC?=
 =?utf-8?B?MS9JOVE0NzM5ZHRZdUFOVE93dW53YUZxb2J5QklJRUJrUnlRbE5OSGgwUGpN?=
 =?utf-8?B?ZkxzRG9vUkZ1R0Y4TGJpN1BuOVJscUUyelo0ZHZ3aUJRS09MUm56d2ZvTzc0?=
 =?utf-8?B?UEdtc05oWjFWRm8vaGk4anh6STNGZlMxS1Qrc25yVVJueGFha3pjSmM5YTVo?=
 =?utf-8?B?ekNCMUQyQWp5dGtCS2ZZVzJWMGk2cXhVVHY2U0JsUTJ3OGRadk1Mcm5NOHVx?=
 =?utf-8?B?L21SQ1NnS3JvWFRUbDhoazFZdnFhdGlGK1hQejV5aHlsbVhDMUtNSUJIaTho?=
 =?utf-8?B?ME02eGFzMHdjUjBCY2FlUVRTSndmdnA0cGNFKzN2cytEaHZrYmV6K2labmNa?=
 =?utf-8?B?R1FwYkdhdjcxSUdXYlA1ckQ5VzJXRzVVRVZPTlZibWIxdWxDS0l1cVhVdGFI?=
 =?utf-8?B?a0NQbkFRZ1IzVjVLcjd1ckI2amhXV0dsKzBCTjMzWkNXb3Z6eGJwV3hlYURu?=
 =?utf-8?B?di9kYm96aTRkWXE0eDdYeDgybW41cHEvYmNqcDJuRCtkN0NmKzU2amNzWEJv?=
 =?utf-8?B?MWM0U013RzB3RDFJOWJOMHVKck1XQmo4VVVaTlMrUVJacmxCNlNoQ1pWeURo?=
 =?utf-8?B?d1o0VWw2ekVuVHNPSmVkcXBsV1hUL2RDVUY1OE5ZMjZjT0JZUDFlQ0E1cTdu?=
 =?utf-8?B?R2ZHTVVhVHkvN1pBUWtreGUwWTNuUUNYWjFUVFJ0SWlyOEdCeTUrSjM1UzU1?=
 =?utf-8?B?KzNkak1RVFlYODZKZWViV1NOc1YyUEw3NHdsOXNicWdweWIxSmljQ3BwUFhV?=
 =?utf-8?B?TGo2cGFpY3lQUmJWRElOUnA0QWZzdjFmWDhCTjlURlZvdHZFN05xYVpHSjZz?=
 =?utf-8?B?YlhxelhJamxKQzZJNkJPRVRPbkgzUGsxMm95NUxMcVVrQVptZmNMWHczL2xR?=
 =?utf-8?B?TUsvSGlMWFYwU2ZHTEFlMFZ3NUJtT0E3VGgxeHFxeEtXdTNOaUhUNnA3eDdS?=
 =?utf-8?B?bmZVR25Odkd3aTJGNmIzS1U3MkV2bDNqVHFjSzdqUWFaNkhWYlB2UHFqSlBu?=
 =?utf-8?B?QVF5cTVCNDZkVGF4QWdxaU83TmVBQkVsU2F0TFJYaVBaWVNycnBQY0crc1pM?=
 =?utf-8?B?dDhHeFkyb2c0MmVOaDBRY081N3NsY3NUSVVUZEhib3l3YXJnOUF0VDMxQXVR?=
 =?utf-8?B?LzBtU0xtcWFzMlQ4RzBJVXpzYTJlc05NQkRNQitTdE5hNWZCZEJwVnBtbFQ4?=
 =?utf-8?B?TEhnZE9GcVpRMjFnaXcxYVRVNTBsZ1YwYjN1YXBmL2RrZmErTTQwc3RBbEd1?=
 =?utf-8?B?cWJjVnhvaENkVm5XbzhnM0p4VnBzeUlrMkpUazBWRWZDM0NXSnpvV0VoU1Bh?=
 =?utf-8?B?VS8yNStnaS9XVXY0d0JQeFFGMVBIZnBPS1JscUVvZnFrODJMNFY4UUd2RXVU?=
 =?utf-8?B?cHF4aHptaDhsSlZnNjkrUkNTOE93bmFyNDUwUCtrMEd3VjVFMXRNaVVNOTNG?=
 =?utf-8?B?YWpzR1VCNUszZGoyL255ZEpwUnQ0TndXTHpSdFE0NkljYUZnVXYxVGxYZkFX?=
 =?utf-8?B?dXVRRW9MTXpicG1HSnU2VGVNREpJbHZORG52bVVnWWV3QkdCY0FJaTMvSFZQ?=
 =?utf-8?B?MWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AE3191FB276AF342B551DB8DF214665A@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	K1jFVBkV96q+aFqDSF0ZocjXjSDVZrN4BmBegjzYkkCF7M1jfqL4GDklT3xX5Gm1kzSYaIRZrx8Jgxr8K5d/PcxO/QB2K41dFpa6CsNw0YFA/sbYRPcaq1F6vU1Ro9kW93+ZIVCKEDQMJPIJ8L6omZaYnTosWsEhiIiGq/1YI1dWDAZEJUE1wyM8FD/NASl6RcvyLrA5Lujz0svesUvTA8io68z8uOJ1yXBwzU/NNeZ6ve7dGLRnBUJi9YI4ANomaOqTgnRhvI5iy5vk2erUsjTHe00qEuhew9aGSB0MoHI107aQrJcS6EuqUYpktbw6FZugYbGedKQGO9zilGmoRrUAq7Y+lEsiUuTZNUG6xFRU5B99rSSRC7TS+kwWVVblBnMtDQtgWDIWRDD2fMdWKznrVSU2r3/luhhrcArnoKCUnB2NzpGLZKTNJau1Ir3MZm+0iAfu0VS17qjn99oMrOTXRUNpbJiacRVk1XpfMmyDe8FKdtQZp+YNvoSkBU4BlxsUPdRghlLrYmlGYzDPYH6i8dvlhHjSbopMXp1vsUgxoetcdkDUu5wmVXm/O16NWDQUkKpKiBAtNZ/+cYIwpdN0SemuSJNITCv31AB60Gc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23e1e480-184f-454d-3f68-08dcc37bb686
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2024 13:58:49.0188
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yyomRbiXfO2C/95lxXVXijU9oxssmtr1VNwT+InOg47Q13MRel3Suxyctoo3MUCfg1oWZZdso9BxZY3zHL1qpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4218
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-23_10,2024-08-22_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 malwarescore=0
 adultscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408230102
X-Proofpoint-ORIG-GUID: lwdCUZGyEH_j1zWz7eFMcEXWDbz0KAnz
X-Proofpoint-GUID: lwdCUZGyEH_j1zWz7eFMcEXWDbz0KAnz

DQoNCj4gT24gQXVnIDIzLCAyMDI0LCBhdCAyOjQ24oCvQU0sIFBldHIgVm9yZWwgPHB2b3JlbEBz
dXNlLmN6PiB3cm90ZToNCj4gDQo+IEhpIENodWNrLCBOZWlsLCBhbGwsDQo+IA0KPj4gT24gV2Vk
LCBBdWcgMTQsIDIwMjQgYXQgMTA6NTc6MjFBTSArMDIwMCwgUGV0ciBWb3JlbCB3cm90ZToNCj4+
PiA2LjkgbW92ZWQgY2xpZW50IFJQQyBjYWxscyB0byBuYW1lc3BhY2UgaW4gIk1ha2UgbmZzIHN0
YXRzIHZpc2libGUgaW4NCj4+PiBuZXR3b3JrIE5TIiBwYXRjaGV0Lg0KPiANCj4+PiBodHRwczov
L2xvcmUua2VybmVsLm9yZy9saW51eC1uZnMvY292ZXIuMTcwODAyNjkzMS5naXQuam9zZWZAdG94
aWNwYW5kYS5jb20vDQo+IA0KPj4+IFNpZ25lZC1vZmYtYnk6IFBldHIgVm9yZWwgPHB2b3JlbEBz
dXNlLmN6Pg0KPj4+IC0tLQ0KPj4+IENoYW5nZXMgdjEtPnYyOg0KPj4+ICogUG9pbnQgb3V0IHdo
b2xlIHBhdGNoc2V0LCBub3QganVzdCBzaW5nbGUgY29tbWl0DQo+Pj4gKiBBZGQgYSBjb21tZW50
IGFib3V0IHRoZSBwYXRjaHNldA0KPiANCj4+PiBIaSBhbGwsDQo+IA0KPj4+IGNvdWxkIHlvdSBw
bGVhc2UgYWNrIHRoaXMgc28gdGhhdCB3ZSBoYXZlIGZpeGVkIG1haW5saW5lPw0KPiANCj4+PiBG
WUkgU29tZSBwYXJ0cyBoYXMgYmVlbiBiYWNrcG9ydGVkLCBlLmcuOg0KPj4+IGQ0NzE1MWI3OWUz
MjIgKCJuZnM6IGV4cG9zZSAvcHJvYy9uZXQvc3VucnBjL25mcyBpbiBuZXQgbmFtZXNwYWNlcyIp
DQo+Pj4gdG8gYWxsIHN0YWJsZS9MVFM6IDUuNC4yNzYsIDUuMTAuMjE3LCA1LjE1LjE1OSwgNi4x
LjkxLCA2LjYuMzEuDQo+IA0KPj4+IEJ1dCBtb3N0IG9mIHRoYXQgaXMgbm90IHlldCAoYnV0IHBs
YW5uZWQgdG8gYmUgYmFja3BvcnRlZCksIGUuZy4NCj4+PiA5MzQ4M2FjNWZlYzYyICgibmZzZDog
ZXhwb3NlIC9wcm9jL25ldC9zdW5ycGMvbmZzZCBpbiBuZXQgbmFtZXNwYWNlcyIpDQo+Pj4gc2Vl
IENodWNrJ3MgcGF0Y2hzZXQgZm9yIDYuNg0KPj4+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xp
bnV4LW5mcy8yMDI0MDgxMjIyMzYwNC4zMjU5Mi0xLWNlbEBrZXJuZWwub3JnLw0KPiANCj4+PiBP
bmNlIGFsbCBrZXJuZWxzIHVwIHRvIDUuNCBmaXhlZCB3ZSBzaG91bGQgdXBkYXRlIHRoZSB2ZXJz
aW9uLg0KPiANCj4+PiBLaW5kIHJlZ2FyZHMsDQo+Pj4gUGV0cg0KPiANCj4+PiB0ZXN0Y2FzZXMv
bmV0d29yay9uZnMvbmZzc3RhdDAxL25mc3N0YXQwMS5zaCB8IDkgKysrKysrKystDQo+Pj4gMSBm
aWxlIGNoYW5nZWQsIDggaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4+PiBkaWZm
IC0tZ2l0IGEvdGVzdGNhc2VzL25ldHdvcmsvbmZzL25mc3N0YXQwMS9uZnNzdGF0MDEuc2ggYi90
ZXN0Y2FzZXMvbmV0d29yay9uZnMvbmZzc3RhdDAxL25mc3N0YXQwMS5zaA0KPj4+IGluZGV4IGMy
ODU2ZWZmMWYuLjFiZWVjYmVjNDMgMTAwNzU1DQo+Pj4gLS0tIGEvdGVzdGNhc2VzL25ldHdvcmsv
bmZzL25mc3N0YXQwMS9uZnNzdGF0MDEuc2gNCj4+PiArKysgYi90ZXN0Y2FzZXMvbmV0d29yay9u
ZnMvbmZzc3RhdDAxL25mc3N0YXQwMS5zaA0KPj4+IEBAIC0xNSw3ICsxNSwxNCBAQCBnZXRfY2Fs
bHMoKQ0KPj4+IGxvY2FsIGNhbGxzIG9wdA0KPiANCj4+PiBbICIkbmFtZSIgPSAicnBjIiBdICYm
IG9wdD0iciIgfHwgb3B0PSJuIg0KPj4+IC0gISB0c3RfbmV0X3VzZV9uZXRucyAmJiBbICIkbmZz
X2YiICE9ICJuZnMiIF0gJiYgdHlwZT0icmhvc3QiDQo+Pj4gKw0KPj4+ICsgaWYgdHN0X25ldF91
c2VfbmV0bnM7IHRoZW4NCj4+PiArICMgIk1ha2UgbmZzIHN0YXRzIHZpc2libGUgaW4gbmV0d29y
ayBOUyIgcGF0Y2hldA0KPj4+ICsgIyBodHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC1uZnMv
Y292ZXIuMTcwODAyNjkzMS5naXQuam9zZWZAdG94aWNwYW5kYS5jb20vDQo+Pj4gKyB0c3Rfa3Zj
bXAgLWdlICI2LjkiICYmIFsgIiRuZnNfZiIgPSAibmZzIiBdICYmIHR5cGU9InJob3N0Ig0KPiAN
Cj4+IEhlbGxvIFBldHItDQo+IA0KPj4gTXkgY29uY2VybiB3aXRoIHRoaXMgZml4IGlzIGl0IHRh
cmdldHMgdjYuOSBzcGVjaWZpY2FsbHksIHlldCB3ZQ0KPj4ga25vdyB0aGVzZSBmaXhlcyB3aWxs
IGFwcGVhciBpbiBMVFMvc3RhYmxlIGtlcm5lbHMgYXMgd2VsbC4NCj4gDQo+IEdyZWF0ISBJIHNl
ZSB5b3UgYWxyZWFkeSBmaXhlZCB1cCB0byA1LjE1LiBJIHN1cHBvc2UgdGhlIGNvZGUgaXMgcmVh
bGx5DQo+IGJhY2twb3J0YWJsZSB0byB0aGUgb3RoZXIgc3RpbGwgYWN0aXZlIGJyYW5jaGVzICg1
LjEwLCA1LjQsIDQuMTkpLg0KDQpJIHBsYW4gdG8gd29yayBvbiBiYWNrcG9ydGluZyB0byB2NS4x
MCBuZXh0IHdlZWsuDQoNCkkndmUgYmVlbiBhc2tlZCB0byBsb29rIGF0IHY1LjQsIGJ1dCBJJ20g
bm90IHN1cmUgaG93IGRpZmZpY3VsdA0KdGhhdCB3aWxsIGJlIGJlY2F1c2UgaXQncyBtaXNzaW5n
IGEgbG90IG9mIE5GU0QgcGF0Y2hlcy4gSSB3aWxsDQpsb29rIGludG8gdGhhdCBpbiBhIGNvdXBs
ZSBvZiB3ZWVrcy4NCg0KSSdtIHZlcnkgbGlrZWx5IHRvIHB1bnQgb24gdjQuMTksIHRob3VnaCBP
cmFjbGUncyBzdGFibGUgYmFja3BvcnQNCnRlYW0gbWlnaHQgdHJ5IHRvIHRhY2tsZSBpdCBhdCBz
b21lIHBvaW50LiAocHVuIGludGVuZGVkKQ0KDQoNCj4gV2UgZGlzY3Vzc2VkIGluIHYxIGhvdyB0
byBmaXggdGVzdHMuICBOZWlsIHN1Z2dlc3RlZCB0byBmaXggdGhlIHRlc3QgdGhlIHdheSBzbw0K
PiB0aGF0IGl0IHdvcmtzIG9uIGFsbCBrZXJuZWxzLiBBcyBJIG5vdGUgWzFdDQo+IA0KPiAxKSBl
aXRoZXIgd2UgZ2l2ZSB1cCBvbiBjaGVja2luZyB0aGUgbmV3IGZ1bmN0aW9uYWxpdHkgc3RpbGwg
d29ya3MgKGlmIHdlDQo+IGZhbGxiYWNrIHRvIG9sZCBiZWhhdmlvcikNCj4gMikgb3Igd2UgbmVl
ZCB0byBzcGVjaWZ5IGZyb20gd2hpY2gga2VybmVsIHdlIGV4cGVjdCBuZXcgZnVuY3Rpb25hbGl0
eQ0KPiAoc28gZmFyIGl0J3MgNS4xNSwgSSBzdXBwb3NlIGl0IHdpbGwgYmUgb2xkZXIpLg0KPiAN
Cj4gSSB3b3VsZCBwcmVmZXIgMikgdG8gaGF2ZSBuZXcgZnVuY3Rpb25hbGl0eSBhbHdheXMgdGVz
dGVkLg0KPiBPciBhbSBJIG1pc3Npbmcgc29tZXRoaW5nIG9idmlvdXM/DQoNCkkgZG9uJ3QgcXVp
dGUgdW5kZXJzdGFuZCB0aGUgcXVlc3Rpb24uDQoNClRoZSAib2xkIGZ1bmN0aW9uYWxpdHkiIG9m
IHJlcG9ydGluZyB0aGVzZSBzdGF0aXN0aWNzIGdsb2JhbGx5DQppcyBicm9rZW4sIGJ1dCB3ZSdy
ZSBzdHVjayB3aXRoIGl0IGluIHRoZSBvbGRlciBrZXJuZWxzLiBJIGd1ZXNzDQp5b3UgbWlnaHQg
d2FudCB0byBjb25maXJtIHRoYXQsIGZvciBhIGdpdmVuIHJlY2VudCBrZXJuZWwNCnJlbGVhc2Us
IHRoZSBzdGF0cyBhcmUgYWN0dWFsbHkgcGVyLW5hbWVzcGFjZSAtLSB0aGF0J3Mgd2hhdCB3ZQ0K
ZXhwZWN0IGluIGZpeGVkIGtlcm5lbHMuIElzIHRoYXQgd2hhdCB5b3UgbWVhbj8NCg0KDQo+IEtp
bmQgcmVnYXJkcywNCj4gUGV0cg0KPiANCj4gWzFdIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xp
bnV4LW5mcy8xNzIzNjczODc1NDkuNjA2Mi43MDc4MDMyOTgzNjQ0NTg2NDYyQG5vYmxlLm5laWwu
YnJvd24ubmFtZS8NCj4gDQo+PiBOZWlsIEJyb3duIHN1Z2dlc3RlZCBhbiBhbHRlcm5hdGl2ZSBh
cHByb2FjaCB0aGF0IG1pZ2h0IG5vdCBkZXBlbmQNCj4+IG9uIGtub3dpbmcgdGhlIHNwZWNpZmlj
IGtlcm5lbCB2ZXJzaW9uOg0KPiANCj4+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LW5m
cy8xNzIwNzgyODM5MzQuMTU0NzEuMTMzNzcwNDgxNjY3MDc2OTM2OTJAbm9ibGUubmVpbC5icm93
bi5uYW1lLw0KPiANCj4+IEhUSA0KPiANCj4gDQo+Pj4gKyBlbHNlDQo+Pj4gKyBbICIkbmZzX2Yi
ICE9ICJuZnMiIF0gJiYgdHlwZT0icmhvc3QiDQo+Pj4gKyBmaQ0KPiANCj4+PiBpZiBbICIkdHlw
ZSIgPSAibGhvc3QiIF07IHRoZW4NCj4+PiBjYWxscz0iJChncmVwICRuYW1lIC9wcm9jL25ldC9y
cGMvJG5mc19mIHwgY3V0IC1kJyAnIC1mJGZpZWxkKSINCj4+PiAtLSANCj4+PiAyLjQ1LjINCg0K
LS0NCkNodWNrIExldmVyDQoNCg0K

