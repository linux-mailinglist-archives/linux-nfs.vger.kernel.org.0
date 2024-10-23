Return-Path: <linux-nfs+bounces-7398-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6D749AD4EE
	for <lists+linux-nfs@lfdr.de>; Wed, 23 Oct 2024 21:39:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A386C28494C
	for <lists+linux-nfs@lfdr.de>; Wed, 23 Oct 2024 19:39:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45B8A1DC04C;
	Wed, 23 Oct 2024 19:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AnY+ClEx";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="oHMpZI+3"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 743F31AE014
	for <linux-nfs@vger.kernel.org>; Wed, 23 Oct 2024 19:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729712334; cv=fail; b=cmDEcrakHq83ixlL/NEVZJTnnlnDFGGcolrle3YC+Oyh8swQQXukTZzDPownA7UlxGmZhah0otwNLxx41ECXxd7dcVyYH+sQVdBE+w9GA0ZaoB9AS8EeCW+G0i3e8O6SVwsvnjSvWHXCjnSnN0uvdrYh+PmLUNvwxisDdTSl9LY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729712334; c=relaxed/simple;
	bh=CrrfOmgwptwtJbF/aXURYvW+TYTZet+tbAbNF+GXdjo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lMo34YK0ELXvs4VoccGX+507p4UWfBqkMX92mqgxSsH+j4OUm4X3gNWvPoU9GH/Ol6HcU3yF9VJMR3g4UGhM5JJr/3g1uXHhwNvwmgDb/Ju+a1NRmM5ZcgkfJ/t+6upUyyUAo8ldQ7sexFN1LS5QlTjIwyoSG4syUc50KcLBU8A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=AnY+ClEx; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=oHMpZI+3; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49NFfc5M013899;
	Wed, 23 Oct 2024 19:38:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=CrrfOmgwptwtJbF/aXURYvW+TYTZet+tbAbNF+GXdjo=; b=
	AnY+ClExkqA0VwDdAivDPSsG10+MukwKi4XeDp1J0+5cnSNy3YtiKFHZkLa63ok5
	La4FAkxQui90wBIS9bfp8nIJVT/LHeOoEKcgObwMH5Fb7oo71/RicTszlXReG9oR
	y/ZOnbWguDOE9DXbSdmc6Yrcj0ESjOfxqyahq5W9Erte8lH8UiErwPqcQsslq5Wa
	KjWT853gq/rBLJOH+Z9fjmdB9cyp690mpcsiuyGiUKvRC8fiKqRQji4mMxj8ObMU
	IiVNP6u9OJxCQ8AZ7bQdtBkh+NoYTQT2PFkZs04MsQjEhfhccL4fVUapLyvQKDzg
	LPR4dfoftHc422eVCcTZeA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42c55v10mn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Oct 2024 19:38:46 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49NHqi3o018535;
	Wed, 23 Oct 2024 19:38:45 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2040.outbound.protection.outlook.com [104.47.70.40])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42emhk0afn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Oct 2024 19:38:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r2aZh635scY98yUKRakpoEHCrbIbQlPOOcRYOy2G237UP0tF5bDbasvfqYqr085pSop2jyGZ4SR+GP8brsPaxeqX+0xQAtltCh0lMkKaSxtFLvvT/WxKzsdlhXANTdk7gmJmo0U0FqLUAFCXE+fLB46emC4mWbkbGSPzK51PkogI1DdZTO+5dSTorfJOdFO+C7tHReBA04ypEF0/Y03RBvKu+n3IkrC4W0aCKlTU3ssFB4jkt/Zthck6vhUfaxE2M3yvGzDsNZcxORQGfiO44CbLN0I7dfGvcqY4pzmNtyHEwkBC6HLJxxBJ3vra+DVxCo1WQC58zv7bmzUnGAPM4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CrrfOmgwptwtJbF/aXURYvW+TYTZet+tbAbNF+GXdjo=;
 b=ZXXXtp/aKLK3tMTNrvpSwJ9vbhbbiHDuot2MJDEbwE+ta04jUGLVlZhwpWj9lAv+m2kFbiB4RJPY3gl8Vu6qi/SgzJxyQsO72S5zQA6qUAHW1IL7FyPt8xd1/dw7GLDrwq8VRe8ZScZBJxwONDiFxIbENe3Z/PTUWKViVWDcCdsAbfo5PGfoP1VHM497c+/Trk/rTjkkw/Xnzak8FPFp/+1sgXO5wKM5Xblz0e4DPXU5hVuUX0L6o8IBaEBuvnFqDS7KuvqNWOtwDZy0S2fpUCxACgmHdTrJdPYegSIW910l+2l3N3Dguqm8KRdTtbwZuDJT6UxzSWobpzJgQlg65g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CrrfOmgwptwtJbF/aXURYvW+TYTZet+tbAbNF+GXdjo=;
 b=oHMpZI+32Lduzia4L2Ya8ZAZaFNyCO237mNpKST+CXzgQlcXZ/s8L7QSqNmeKrJzZF1C4E0eQ+EMV2UqfeC2h2g9edm/Ez8HABbT0ctdDClTAyWmlqy2SWh97L+RSaHu16acg0lxszS3/HJbihYn25NfcGvRCIsZU6dR5oeMhag=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SJ2PR10MB7617.namprd10.prod.outlook.com (2603:10b6:a03:545::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.22; Wed, 23 Oct
 2024 19:38:42 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.8093.018; Wed, 23 Oct 2024
 19:38:42 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: =?utf-8?B?QmVub8OudCBHc2Nod2luZA==?= <benoit.gschwind@minesparis.psl.eu>
CC: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: nfsd stuck in D (disk sleep) state
Thread-Topic: nfsd stuck in D (disk sleep) state
Thread-Index: AQHbJYK14pQYtaETsk+otR7Z0qMSDbKUu0MA
Date: Wed, 23 Oct 2024 19:38:42 +0000
Message-ID: <4A9BFCA9-7A15-4CA7-B198-0A15C3A24D11@oracle.com>
References: <1cbdfe5e604d1e39a12bc5cca098684500f6a509.camel@minesparis.psl.eu>
In-Reply-To:
 <1cbdfe5e604d1e39a12bc5cca098684500f6a509.camel@minesparis.psl.eu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3776.700.51)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|SJ2PR10MB7617:EE_
x-ms-office365-filtering-correlation-id: 6fefa9f0-a6e8-498a-4023-08dcf39a4d5f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?M2VjVWJqQzhEYkpJRTZvRUFvcU9XU1RVNmYxOVF2TVhTaEFGRGNGcnYxOHJ1?=
 =?utf-8?B?S3lmMCtZZklQU05EQnl2cnRuaVExRld6UlNpblJqVmNBbjVsWmxqblR0L2FT?=
 =?utf-8?B?eDE4MjVsRkFydHh0RlNzWjl3c2J0RVFONUJkMFhBek5vWXRXYUZkS0ZZVzFx?=
 =?utf-8?B?aTU0ckpPOGUrUHpnME5qd0xWa3FnWHR4NUgvWURxc2pudjYwNmZHOE40UjRo?=
 =?utf-8?B?QTNpbkZiVkhidEg2RW5VZ1RueTJhUlk1L3RKNGtVNXlpNXA1aUZTdmhydGVD?=
 =?utf-8?B?SWJKV1NHWjB5UjB6V01sRDYzMVhDNVRKZVZEOE93TkRnZjN6M1V4bzVOMGhk?=
 =?utf-8?B?WGhuRDVXdTkxRFVrVndMVlM2NXV0Uy9VVGw2VGhUU3hmQVZrY1hIcTB5Mnh2?=
 =?utf-8?B?SS9obFRCcVloTVNvS0YrR0JwOWloYnpmQlNRNGZCWFo0Yi9hRm1HQmZrcHEv?=
 =?utf-8?B?dW5xK1pKRDdWR3dtdy9Kb2pvcHg1N2dCSDlQVWFxUW1FZlh6eWhyY2UrMnlt?=
 =?utf-8?B?bzlEMVBHS1BDQm5uZEdSZUhWdzVIWVE5MmFMS0ZNNTNqOWhBaGZ5OTh2SHpu?=
 =?utf-8?B?U1RpYlRZZnRMSWQxRDhYZFNiN3lUSG5xK2hpQzlkL1duakgwMWFKblI5Rjdp?=
 =?utf-8?B?UlFQUHE4MFhMOEVEdnpkVVVoWWVDQ0RTYXg4ZC9oMTU4SXorR3V2MU1wMGxl?=
 =?utf-8?B?b3pzcG1yNHhrNm1HMVFxdzZOYnE4L05QRnQ1VEpzMHJGaFREdXFvK3YwMGR1?=
 =?utf-8?B?bjdUM01Db0tHZ3E0ZEJuSVJqbWVVUFIrR1I0UHFxRC9sbW5LbHl2MmFndGpQ?=
 =?utf-8?B?aC9vN2ZjS2dkTU40ZjlSS0dvcDdYWGZsSUtiMVcyOGU4dU9ndTd6VktQU3I0?=
 =?utf-8?B?ZWgzY2kzQUJuRmlKTUpVZFE1KzRTL2ZZaW1rc0ZJOHVTcGt5YWF1OGNhdm42?=
 =?utf-8?B?R0VlMzZJc0x5VmtVbG1lbG54K1ljM2tibmt4bGVrNU1kNXJxeWFiOXA2ZzdY?=
 =?utf-8?B?RUNjdi90eXpZSEN6Ulg2Q0haWFhoSDZ6QS9hc2lGN2kxT1VEdHFLNm9BMHFX?=
 =?utf-8?B?MWhBayszZTN6eTdyd3hwRzFjdDk5bHlwUVVTK090OXlCajZDR3VlZERrdmpM?=
 =?utf-8?B?UkhVMkloeTVlNGdRbXBjSExDeXVyYkpUcFdmUXUzQVZRblZTbGkrUnJnN3hy?=
 =?utf-8?B?RlpqVi9DRjZ2Vy9KWDdCendIRXNpNU01dVFaV3A3WmRhbTZSZ1BFaGFFUmt4?=
 =?utf-8?B?VUF3K3VqZmZiaGVkUVJuODAyYk1NemVaVDZROUtNWkx0dm9MOC8rZWFUUFVE?=
 =?utf-8?B?c0NTSk0vaS9kQi9DT2FoL2VuV3JCOFR6bnNCeU1oUzVZb3R3NXVKZGVYc2lD?=
 =?utf-8?B?Wm42dU9XRGk5OXNLdlJUODFEdEZ0NDlTT1ZLbjgxRWtDK3d6aEx1SDhmKzli?=
 =?utf-8?B?NHFKMEY3Rkp6QXVGOC9NYWtGa0F6YXZmcWUxWW1kdTI1VVI4eTNqOWc4V3ZR?=
 =?utf-8?B?aS9xTkF1QVN4VEFSbTdZaW5vWDlObTNQYlc3T093NGsxOC81ZWFrR0ZzVVVY?=
 =?utf-8?B?SGZYVXk3L2xUQlozRWtwaDMxTGZIQUYvUmQrUFl1a0lyU09lS1Q5bGZ6NzRS?=
 =?utf-8?B?WXJzS1YvU0pkSTFOZlM1WHRxMWh2Z1hTTzl5eWJPRm9YalN6ejZBUjM0S1ox?=
 =?utf-8?B?azN5eDZLWkpWSjJZN3Ezbk9uU1lNTStQdDljQWJ6WE93MEFzbXZrSHpZOGJS?=
 =?utf-8?B?Z3dPRUMraEhhSldKaDd6dHVjMjd2YlNob1dMdXZRdnV2Yy9FbldTdG5wTndv?=
 =?utf-8?Q?+D8Dc5u2l3H9PIWqWCTfMPJrsBVF/p0I8ufoo=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UEVmTWhtOWxUbER5WmFMZHp4V2JGSkw5dnRGcndqbVhHNGdUV3dWWUJyb2s0?=
 =?utf-8?B?NXVkdHFqRHJhQXN5Y2VRemJBQlNaaTMvSXRpOW1SMXIvd0V6dnphMXQyN3lR?=
 =?utf-8?B?ZTRBc0IzeWMzU0t4T3RNT3g2UDR5c3ZHSkFlbnNWVzNjNkdOUTYwWTV4d3Fj?=
 =?utf-8?B?L1RGS0Q3cTI5V1JFSE5rZmwwODUyWTdLQ2ZTZWt0YkZEUTZ1eG54YWtRRVhW?=
 =?utf-8?B?SFRHSndXMUJGTkk0TFNvbmNwWFVYc290eHZRanNUaWFJVnFTb1h4TTJwQ3NX?=
 =?utf-8?B?MkRQc1JFRDUvZDZFeXplSExnTmNtM3YvSVExL090OEMrSGJmQzdJODUvR2RF?=
 =?utf-8?B?MlpwZnBPSmRHUHFyYnlSZnNYVDhHNHhMWVdvdkk2TEd1ZE1LU011a0xybXBN?=
 =?utf-8?B?cUNtcFFUTUFMcXY0a3VzVWw2VDJKVkc1dGlLei83ZTVQSzYxdWpkNmQ5ajd0?=
 =?utf-8?B?VTNhZmJxOVgzRXNCNERTc09tQVZTSlVzYnB2cVovdC8rZy84cks1eEY3ZTl5?=
 =?utf-8?B?QjJrckZ3cU12cWQzbDkyOGxFZjIvcU9iWHhwbURFZ1ZGVHQ2b05BUkN4SHpY?=
 =?utf-8?B?b1BCdFhHVms1SFdBcEl0UFBSNUZGSUFETDV6NW9ldmFQZ3FxWGVELzQ4b0sx?=
 =?utf-8?B?SVh0dThKUVJTc0ZGYWYrbUhkSFFOVFVOUDIzeVJweU0rVFhDeG0rMEFDajNz?=
 =?utf-8?B?ZzZtY2J2NXhleXcvMjYxeHE0RDZROUlSZlhIaTZ2UEJoeUR6UmJzS1YvSTVP?=
 =?utf-8?B?TmNvdDlNcFJFcWxYbm8rUzlhcHRqY0dxZHNMNkpsM2kyYXphY1pTQ3NBQTQv?=
 =?utf-8?B?aDFZbXEzVTVSTjdTaXdvMVJWbk9rWXk2TG5mNG1BS3Q3Y2dNMzZHQU5heVVJ?=
 =?utf-8?B?dDFReVllZXNybHhZRkxjV0pBdTZJQy9HR2FjcWQ1ZnVmODBVNmhIU1BvcUFi?=
 =?utf-8?B?MXZiSDU1NmYrekFQWnJ3UnVncTA4WHFQUjREZUwxNWsrOUs2aElkM1MyOExJ?=
 =?utf-8?B?UU16VGxJRjE5aFpSZlpZYXhQOHYrc2lleS9QRHl1cG5YUHI3Z1BDNlhJY09i?=
 =?utf-8?B?L2lrMCtJSE4vTldCWnJDeExOWG5nKzhGZXhhUXhsOTI0OW1tRlIvMFZiYTBq?=
 =?utf-8?B?ZFRwYVc0NVNYQndrdUZDWFdlQTRUWXM0MG9aRE9SWk9FVnhQWERwNGxIckVw?=
 =?utf-8?B?bnIzdWoyNVRobDRLVklld0sva1kxL2ZjaXkzSnJHNkEzMHJNRXA1Q1R2MEJJ?=
 =?utf-8?B?TFROZ1FjWFFOYkVCdFdIWlBCNGZ4RS9yemFWd3dnMkZpV1Ntd0xTYzYyOTQr?=
 =?utf-8?B?dytOU0hEMDdHYXJhWDRONnRYZmZsMHRrZmI0UG5EQjcxYjB5cmk1SmNqYzNa?=
 =?utf-8?B?VTVVaUN6YXlENElySWg0RERoazVsN3FIQWRIcFJWR1VGWG5WRVEwNlc0emx3?=
 =?utf-8?B?Y3BXQmJ2MXVTa3NaOTc2UTZOUkV1TlFJSkNQbDc1djBZYlBQK3NSWFYwNGpZ?=
 =?utf-8?B?bUtWdVVOQlZSL2E2TCtaM2kwUDhuZ2NXRDJYQ003VVlNcFVkZ1J5SDlEalZw?=
 =?utf-8?B?eFNsSEVDUTFpQXBXT1FFSitJM1hCSXM3TkF0aDZROC9EdmdOTndKalpPVWhS?=
 =?utf-8?B?cW1HOEloMmloVWl6SmNQdmc5RTJ2YUZ3clBCeGNxbjROdHBIaThiQVVJTERI?=
 =?utf-8?B?cnZjS283N3N0MFZ6MVd4dllndjZBRlFIY01wNGxvTzc0UGlRVnlvbmdqWG83?=
 =?utf-8?B?aDhCV2k2RWNKWW4yRkRodU44Z3VLZkU2Q2ZISDNyNmJRNzBucHBCZEpLeFBU?=
 =?utf-8?B?MTAwL2xhVDArOE0zS3dadFJCK0FiQ2EwYTUzM3lZTlBrMFVPZ3YvWFk0RzRW?=
 =?utf-8?B?Rnh6RzQzQS90VUFBNlNpRTdPdjRScjh4N0tLdUFDb1Y2TXE5WEVYRTd1RXhz?=
 =?utf-8?B?a3o3NGVPT0libzRXRDlZTVhOcm1KZVRFbTNTN0JvZEwxY1o0NDc1QzFTL1V3?=
 =?utf-8?B?ZFA4ejhvVzdIN0h1dWE2bkNTU3ozUVZwYzJVUmMrNEQwUmwrN0VFNEdwVVRn?=
 =?utf-8?B?VzJSVDFSc1IyUFlNWTdmMzhwMUF5dnF5YXJsNlluMmxaWmFyNG1jUzM2OGtD?=
 =?utf-8?B?RXpmeGpJbWNlUjYrcWE0REZWMHBYU1dqZXYvakxaTkR0dmRRdDV5TWIrMDNv?=
 =?utf-8?B?emc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E7741A9B00F884408C35B273901E53D4@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	zTIv4tkMhu/svNiE+Dtm3MY0lEo0Qb96tfwrOH1vltgk0q+f8bypABFUr35QfxHCULc14zCJ6i6NkLt0HU9jIy4P5v4JccZixg29UEhHMBYbB0zlet3ZHIuSQhuLE7wEt0bVKqqpmBribZA0KI1tWlPbGvUqH3A3A9Yez8q4zc3jkYuUOFnDflpo547sBTU36z6MFQXJiD7da9qcwXvdMi7GWyZAH0YOBZrtpS66UM/yfE2RI/lhOrJv1N3SnmNzm3FSJEi5VerbubEeDWkuq4EbnOGU0YYijJ4oNQH9BJxBBswdsHFrudQnCVz7Cjl04JfZWP4zBqCaCB5tdy1OnZQQO18SSgs7vDHnt2cROvvYQHTb+u4+bgkJbS5+P7qEaermkBGFOLcOj4KU5aas63rRxVci0KsgJUrO/HL3pOXDCZ00nQTyUo2VY4oD58oQMyKXOsKNb6gKWQrPrI0cZyHvqGnLcxyHCYWa25mGKXcEI2l5UYWc1/qC0KAlXpLFkjLjRGw2juuOz1DFi6+S6L+YL1gCOTkV8O7wCe2YeMGsKMvndrC+cPA5fEdp4o3yMsLLgx7Z0gI3C/D5odTnVIiT9B3WyhZ48e4DAxnuoBc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fefa9f0-a6e8-498a-4023-08dcf39a4d5f
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2024 19:38:42.8347
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5oLxrE7nG9ED4D5IkRzp1vmBFiQDzz6bSbF7i2kN7bUbcSMonWDQotPFpc8RhTIoqUhkQlkZxSSAhSVmi7pPsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7617
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-23_15,2024-10-23_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 bulkscore=0
 adultscore=0 mlxlogscore=999 mlxscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410230127
X-Proofpoint-GUID: JoENcYMAWSAQ5OIRJz2zPgFfzSwQRrpA
X-Proofpoint-ORIG-GUID: JoENcYMAWSAQ5OIRJz2zPgFfzSwQRrpA

DQoNCj4gT24gT2N0IDIzLCAyMDI0LCBhdCAzOjI34oCvUE0sIEJlbm/DrnQgR3NjaHdpbmQgPGJl
bm9pdC5nc2Nod2luZEBtaW5lc3BhcmlzLnBzbC5ldT4gd3JvdGU6DQo+IA0KPiBIZWxsbywNCj4g
DQo+IEkgaGF2ZSBhIG5mcyBzZXJ2ZXIgdXNpbmcgZGViaWFuIDExIChMaW51eCBob3N0bmFtZSA2
LjEuMC0yNS1hbWQ2NCAjMQ0KPiBTTVAgUFJFRU1QVF9EWU5BTUlDIERlYmlhbiA2LjEuMTA2LTMg
KDIwMjQtMDgtMjYpIHg4Nl82NCBHTlUvTGludXgpDQo+IA0KPiBJbiBzb21lIGhlYXZ5IHdvcmts
b2FkIHNvbWUgbmZzZCBnb2VzIGluIEQgc3RhdGUgYW5kIHNlZW1zIHRvIG5ldmVyDQo+IGxlYXZl
IHRoaXMgc3RhdGUuIEkgZGlkIGEgcHl0aG9uIHNjcmlwdCB0byBtb25pdG9yIGhvdyBsb25nIGEg
cHJvY2Vzcw0KPiBzdGF5IGluIHBhcnRpY3VsYXIgc3RhdGUgYW5kIEkgdXNlIGl0IHRvIG1vbml0
b3IgbmZzZCBzdGF0ZS4gSSBnZXQgdGhlDQo+IGZvbGxvd2luZyByZXN1bHQgOg0KPiANCj4gWy4u
Ll0NCj4gMTc4MDU2IEkgKGlkbGUpIDA6MjU6MjQuNDc1IFtuZnNkXQ0KPiAxNzgwNTcgSSAoaWRs
ZSkgMDoyNToyNC40NzUgW25mc2RdDQo+IDE3ODA1OCBJIChpZGxlKSAwOjI1OjI0LjQ3NSBbbmZz
ZF0NCj4gMTc4MDU5IEkgKGlkbGUpIDA6MjU6MjQuNDc1IFtuZnNkXQ0KPiAxNzgwNjAgSSAoaWRs
ZSkgMDoyNToyNC40NzUgW25mc2RdDQo+IDE3ODA2MSBJIChpZGxlKSAwOjI1OjI0LjQ3NSBbbmZz
ZF0NCj4gMTc4MDYyIEkgKGlkbGUpIDA6MjQ6MTUuNjM4IFtuZnNkXQ0KPiAxNzgwNjMgSSAoaWRs
ZSkgMDoyNDoxMy40ODggW25mc2RdDQo+IDE3ODA2NCBJIChpZGxlKSAwOjI0OjEzLjQ4OCBbbmZz
ZF0NCj4gMTc4MDY1IEkgKGlkbGUpIDA6MDA6MDAuMDAwIFtuZnNkXQ0KPiAxNzgwNjYgSSAoaWRs
ZSkgMDowMDowMC4wMDAgW25mc2RdDQo+IDE3ODA2NyBJIChpZGxlKSAwOjAwOjAwLjAwMCBbbmZz
ZF0NCj4gMTc4MDY4IEkgKGlkbGUpIDA6MDA6MDAuMDAwIFtuZnNkXQ0KPiAxNzgwNjkgUyAoc2xl
ZXBpbmcpIDA6MDA6MDIuMTQ3IFtuZnNkXQ0KPiAxNzgwNzAgUyAoc2xlZXBpbmcpIDA6MDA6MDIu
MTQ3IFtuZnNkXQ0KPiAxNzgwNzEgUyAoc2xlZXBpbmcpIDA6MDA6MDIuMTQ3IFtuZnNkXQ0KPiAx
NzgwNzIgUyAoc2xlZXBpbmcpIDA6MDA6MDIuMTQ3IFtuZnNkXQ0KPiAxNzgwNzMgUyAoc2xlZXBp
bmcpIDA6MDA6MDIuMTQ3IFtuZnNkXQ0KPiAxNzgwNzQgRCAoZGlzayBzbGVlcCkgMToyOToyNS44
MDkgW25mc2RdDQo+IDE3ODA3NSBTIChzbGVlcGluZykgMDowMDowMi4xNDcgW25mc2RdDQo+IDE3
ODA3NiBTIChzbGVlcGluZykgMDowMDowMi4xNDcgW25mc2RdDQo+IDE3ODA3NyBTIChzbGVlcGlu
ZykgMDowMDowMi4xNDcgW25mc2RdDQo+IDE3ODA3OCBTIChzbGVlcGluZykgMDowMDowMi4xNDcg
W25mc2RdDQo+IDE3ODA3OSBTIChzbGVlcGluZykgMDowMDowMi4xNDcgW25mc2RdDQo+IDE3ODA4
MCBEIChkaXNrIHNsZWVwKSAxOjI5OjI1LjgwOSBbbmZzZF0NCj4gMTc4MDgxIEQgKGRpc2sgc2xl
ZXApIDE6Mjk6MjUuODA5IFtuZnNkXQ0KPiAxNzgwODIgRCAoZGlzayBzbGVlcCkgMDoyODowNC40
NDQgW25mc2RdDQo+IA0KPiBBbGwgcHJvY2VzcyBub3Qgc2hvd24gYXJlIGluIGlkbGUgc3RhdGUu
IENvbHVtbnMgYXJlIHRoZSBmb2xsb3dpbmc6DQo+IFBJRCwgc3RhdGUsIHN0YXRlIG5hbWUsIGFt
b3VuZyBvZiB0aW1lIHRoZSBzdGF0ZSBkaWQgbm90IGNoYW5nZWQgYW5kDQo+IHRoZSBwcm9jZXNz
IHdhcyBub3QgaW50ZXJydXB0ZWQsIGFuZCAvcHJvYy9QSUQvc3RhdHVzIE5hbWUgZW50cnkuDQo+
IA0KPiBBcyB5b3UgY2FuIHJlYWQgc29tZSBuZnNkIHByb2Nlc3MgYXJlIGluIGRpc2sgc2xlZXAg
c3RhdGUgc2luY2UgbW9yZQ0KPiB0aGFuIDEgaG91ciwgYnV0IGxvb2tpbmcgYXQgdGhlIGRpc2sg
YWN0aXZpdHksIHRoZXJlIGlzIGFsbW9zdCBubyBJL08uDQo+IA0KPiBJIHRyaWVkIHRvIHJlc3Rh
cnQgbmZzLXNlcnZlciBidXQgSSBnZXQgdGhlIGZvbGxvd2luZyBlcnJvciBmcm9tIHRoZQ0KPiBr
ZXJuZWw6DQo+IA0KPiBvY3QuIDIzIDExOjU5OjQ5IGhvc3RuYW1lIGtlcm5lbDogcnBjLXNydi90
Y3A6IG5mc2Q6IGdvdCBlcnJvciAtMTA0IHdoZW4gc2VuZGluZyAyMCBieXRlcyAtIHNodXR0aW5n
IGRvd24gc29ja2V0DQo+IG9jdC4gMjMgMTE6NTk6NDkgaG9zdG5hbWUga2VybmVsOiBycGMtc3J2
L3RjcDogbmZzZDogZ290IGVycm9yIC0xMDQgd2hlbiBzZW5kaW5nIDIwIGJ5dGVzIC0gc2h1dHRp
bmcgZG93biBzb2NrZXQNCj4gb2N0LiAyMyAxMTo1OTo0OSBob3N0bmFtZSBrZXJuZWw6IHJwYy1z
cnYvdGNwOiBuZnNkOiBnb3QgZXJyb3IgLTEwNCB3aGVuIHNlbmRpbmcgMjAgYnl0ZXMgLSBzaHV0
dGluZyBkb3duIHNvY2tldA0KPiBvY3QuIDIzIDExOjU5OjQ5IGhvc3RuYW1lIGtlcm5lbDogcnBj
LXNydi90Y3A6IG5mc2Q6IGdvdCBlcnJvciAtMTA0IHdoZW4gc2VuZGluZyAyMCBieXRlcyAtIHNo
dXR0aW5nIGRvd24gc29ja2V0DQo+IG9jdC4gMjMgMTE6NTk6NDkgaG9zdG5hbWUga2VybmVsOiBy
cGMtc3J2L3RjcDogbmZzZDogZ290IGVycm9yIC0xMDQgd2hlbiBzZW5kaW5nIDIwIGJ5dGVzIC0g
c2h1dHRpbmcgZG93biBzb2NrZXQNCj4gb2N0LiAyMyAxMTo1OTo1OSBob3N0bmFtZSBrZXJuZWw6
IHJwYy1zcnYvdGNwOiBuZnNkOiBnb3QgZXJyb3IgLTEwNCB3aGVuIHNlbmRpbmcgMjAgYnl0ZXMg
LSBzaHV0dGluZyBkb3duIHNvY2tldA0KPiBvY3QuIDIzIDExOjU5OjU5IGhvc3RuYW1lIGtlcm5l
bDogcnBjLXNydi90Y3A6IG5mc2Q6IGdvdCBlcnJvciAtMTA0IHdoZW4gc2VuZGluZyAyMCBieXRl
cyAtIHNodXR0aW5nIGRvd24gc29ja2V0DQo+IG9jdC4gMjMgMTE6NTk6NTkgaG9zdG5hbWUga2Vy
bmVsOiBycGMtc3J2L3RjcDogbmZzZDogZ290IGVycm9yIC0xMDQgd2hlbiBzZW5kaW5nIDIwIGJ5
dGVzIC0gc2h1dHRpbmcgZG93biBzb2NrZXQNCj4gb2N0LiAyMyAxMTo1OTo1OSBob3N0bmFtZSBr
ZXJuZWw6IHJwYy1zcnYvdGNwOiBuZnNkOiBnb3QgZXJyb3IgLTEwNCB3aGVuIHNlbmRpbmcgMjAg
Ynl0ZXMgLSBzaHV0dGluZyBkb3duIHNvY2tldA0KPiBvY3QuIDIzIDExOjU5OjU5IGhvc3RuYW1l
IGtlcm5lbDogcnBjLXNydi90Y3A6IG5mc2Q6IGdvdCBlcnJvciAtMTA0IHdoZW4gc2VuZGluZyAy
MCBieXRlcyAtIHNodXR0aW5nIGRvd24gc29ja2V0DQo+IG9jdC4gMjMgMTI6MDA6MDkgaG9zdG5h
bWUga2VybmVsOiBycGMtc3J2L3RjcDogbmZzZDogZ290IGVycm9yIC0xMDQgd2hlbiBzZW5kaW5n
IDIwIGJ5dGVzIC0gc2h1dHRpbmcgZG93biBzb2NrZXQNCj4gb2N0LiAyMyAxMjowMDowOSBob3N0
bmFtZSBrZXJuZWw6IHJwYy1zcnYvdGNwOiBuZnNkOiBnb3QgZXJyb3IgLTEwNCB3aGVuIHNlbmRp
bmcgMjAgYnl0ZXMgLSBzaHV0dGluZyBkb3duIHNvY2tldA0KPiBvY3QuIDIzIDEyOjAwOjA5IGhv
c3RuYW1lIGtlcm5lbDogcnBjLXNydi90Y3A6IG5mc2Q6IGdvdCBlcnJvciAtMTA0IHdoZW4gc2Vu
ZGluZyAyMCBieXRlcyAtIHNodXR0aW5nIGRvd24gc29ja2V0DQo+IG9jdC4gMjMgMTI6MDA6MTAg
aG9zdG5hbWUga2VybmVsOiBycGMtc3J2L3RjcDogbmZzZDogZ290IGVycm9yIC0zMiB3aGVuIHNl
bmRpbmcgMjAgYnl0ZXMgLSBzaHV0dGluZyBkb3duIHNvY2tldA0KPiBvY3QuIDIzIDEyOjAwOjEw
IGhvc3RuYW1lIGtlcm5lbDogcnBjLXNydi90Y3A6IG5mc2Q6IGdvdCBlcnJvciAtMzIgd2hlbiBz
ZW5kaW5nIDIwIGJ5dGVzIC0gc2h1dHRpbmcgZG93biBzb2NrZXQNCj4gDQo+IFRoZSBvbmx5IHdh
eSB0byByZWNvdmVyIHNlZW1zIHRvIHJlYm9vdCB0aGUga2VybmVsLiBJIGd1ZXNzIGJlY2F1c2Ug
dGhlDQo+IGtlcm5lbCBmb3JjZSB0aGUgcmVib290IGFmdGVyIGEgZ2l2ZW4gdGltZW91dC4NCj4g
DQo+IE15IHNldHVwIGludm9sdmUgaW4gb3JkZXIgOg0KPiAtIHNjc2kgZHJpdmVyDQo+IC0gbWRy
YWlkIG9uIHRvcCBvZiBzY3NpIChyYWlkNikNCj4gLSBidHJmcyBvbnRvcCBvZiBtZHJhaWQNCj4g
LSBuZnNkIG9udG9wIG9mIGJ0cmZzDQo+IA0KPiANCj4gVGhlIHNldHVwIGlzIG5vdCB2ZXJ5IGZh
c3QgYXMgZXhwZWN0ZWQsIGJ1dCBpdCBzZWVtcyB0aGF0IGluIHNvbWUNCj4gc2l0dWF0aW9uIG5m
c2QgbmV2ZXIgbGVhdmUgdGhlIGRpc2sgc2xlZXAgc3RhdGUuIHRoZSBleHBvcnRzIG9wdGlvbnMN
Cj4gYXJlOiBnc3Mva3JiNWkocncsc3luYyxub193ZGVsYXksbm9fc3VidHJlZV9jaGVjayxmc2lk
PVhYWFhYKS4gVGhlDQo+IHNpdHVhdGlvbiBpcyBub3QgY29tbXVuIGJ1dCBpdCdzIGFsd2F5cyBo
YXBwZW4gYXQgc29tZSBwb2ludC4gRm9yDQo+IGluc3RhbmNlIGluIHRoZSBjYXNlIEkgcmVwb3J0
IGhlcmUsIG15IHNlcnZlciBib290ZWQgdGhlIDIwMjQtMTAtMDEgYW5kDQo+IHdhcyBzdHVjayBh
Ym91dCB0aGUgMjAyNC0xMC0yMy4gSSBkaWQgcmVkdWNlZCBieSBhIGxhcmdlIGFtb3VudCB0aGUN
Cj4gZnJlcXVlbmN5IG9mIGlzc3VlIGJ5IHVzaW5nIG5vX3dkZWxheSAoSSBkaWQgdGhvdWdodCB0
aGF0IEkgZGlkIHNvbHZlZA0KPiB0aGUgaXNzdWUgd2hlbiBJIHN0YXJ0ZWQgdG8gdXNlIHRoaXMg
b3B0aW9uKS4NCj4gDQo+IE15IGd1ZXNzIGlzIGhhZHdhcmUgYnVnLCBzY3NpIGJ1ZywgYnRyZnMg
YnVnIG9yIG5mc2QgYnVnID8NCj4gDQo+IEFueSBjbHVlIG9uIHRoaXMgdG9waWMgb3IgYW55IGFk
dmljZSBpcyB3ZWxsY29tZS4NCg0KR2VuZXJhdGUgc3RhY2sgdHJhY2VzIGZvciBlYWNoIHByb2Nl
c3Mgb24gdGhlIHN5c3RlbQ0KdXNpbmcgInN1ZG8gZWNobyB0ID4gL3Byb2Mvc3lzcnEtdHJpZ2dl
ciIgYW5kIHRoZW4NCmV4YW1pbmUgdGhlIG91dHB1dCBpbiB0aGUgc3lzdGVtIGpvdXJuYWwuIE5v
dGUgdGhlDQpzdGFjayBjb250ZW50cyBmb3IgdGhlIHByb2Nlc3NlcyB0aGF0IGxvb2sgc3R1Y2su
DQoNCi0tDQpDaHVjayBMZXZlcg0KDQoNCg==

