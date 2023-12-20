Return-Path: <linux-nfs+bounces-720-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 061BF81A060
	for <lists+linux-nfs@lfdr.de>; Wed, 20 Dec 2023 14:57:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE54D28454D
	for <lists+linux-nfs@lfdr.de>; Wed, 20 Dec 2023 13:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFA8B38DEA;
	Wed, 20 Dec 2023 13:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YJ/agqNT";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="GpTtJXlQ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBC8638DE3
	for <linux-nfs@vger.kernel.org>; Wed, 20 Dec 2023 13:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BK5UGTt022482;
	Wed, 20 Dec 2023 13:54:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=ZN8wpRsPOOHX55ieBAv4e4+65kDT4mgwkx9SAf1MUmQ=;
 b=YJ/agqNTnlw9WxD0L0/d4MjybGrPtgtOpmqK9K1gheQbJEPRpI7J/N6d5vzz7QEzVhox
 lr6PlVPe2JJ98N5jhi3PhyxUJhW2m5hJ5vwqAaJbS0ajqQPMvj1yzcOjpDmjijKnONup
 VlujRyJ/IzhM8hGilKTlwSH2scqlzerv/KUBfXLQTXRCEPyHroFg+bzqmAS3J4TKhUyd
 RVcHiJZXOZeLesFcBonavLFrRQ2LT6p+lBkxcdpCfNBvRON6EeQkaqXGzd7Tkws9ccxN
 Kmm7f1DE8rgHEUHWAx58lLyHwODmPvtOYQy360gMM+ZdaEPh+eBOuVNI6VusfHqOk7uh Tg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3v13sb8cua-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 Dec 2023 13:54:39 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3BKCBqsp022275;
	Wed, 20 Dec 2023 13:54:39 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3v12b8sh0u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 Dec 2023 13:54:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DBzF/+6Yr6rQl4yDjVU48B7dA/XQ2rKTHXCryJUUUt6OBnf5w7YnBMitSIjXkxb582YIH2tLNNnCT0jeNhB+qBI5d0UeT1BTbse67TgO0p9mZ8aZ9Cmm78ybdWbnIwOrrrodiXYO353LdQg3HVVH3h6gbBCnE45gTnBNIxPobCMpJqq7seBqHbYfi2pNBy1UQwP0IXAtXPf9RWZ2ko/ZWmx4038RBdGeJRpzMWauEnm6j9QdlxJUJryBehsa+bteZVszV2+9EFZD8Azddb7Uwp8q3le4Q2JtF6wKhkHrHGLCMfChCOIOumpSmyvpMiNj7NHsjRfjPInfEoUq6yqzmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZN8wpRsPOOHX55ieBAv4e4+65kDT4mgwkx9SAf1MUmQ=;
 b=AcCdw2XlQDphNrrL7Nyjz461hezbRf5182BTBKLsxrSmN1uOKdUVYKzQOWEhjpxDzxM7GHGLWubMoxl8e3ReM2YrYpkKSery11VtC/SJ7MAEtui2wAGovSvA9o9T1t3gsTPBOpGEx33IurS7WeGfFO6CL/PzXYMw/q5q2iCKmbrj8EBh+f4YGCJiiQjK4df/tPiJjBCuDqk7U/2cBiQNwnQqANwqdccKfajadqNZGR3wspg9Xc/STlINuzSRpgLUX9iFT++SsWBVH8sWZcIGxXGRgakJWcXi3Dsl+MMNQUde4Q9d1Lk2WJosIycYSPE1x6fORSH54AAK7b6C29d0tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZN8wpRsPOOHX55ieBAv4e4+65kDT4mgwkx9SAf1MUmQ=;
 b=GpTtJXlQCZYoD37CagQ5w9y59pzOcJi9dfhpcnae90r690k1rOZ6Nc+iz1c+DzB8s6WuCxOHVt9MLPKcQt1tLEkUeDNSe1k/LsVgrrZ+VUQ/e3tdvGhZcqUyxH7RoibEDq7f5BZwwdYDxFf7gyTzxgDC8hU1e4kxflbnkJBaM7Q=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH7PR10MB6228.namprd10.prod.outlook.com (2603:10b6:510:213::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.38; Wed, 20 Dec
 2023 13:54:36 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c%4]) with mapi id 15.20.7113.016; Wed, 20 Dec 2023
 13:54:36 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Benjamin Coddington <bcodding@redhat.com>
CC: Dai Ngo <dai.ngo@oracle.com>, Jeff Layton <jlayton@kernel.org>,
        Linux NFS
 Mailing List <linux-nfs@vger.kernel.org>,
        "linux-nfs@stwm.de"
	<linux-nfs@stwm.de>
Subject: Re: [PATCH 1/3 v2] SUNRPC: remove printk when back channel request
 not found
Thread-Topic: [PATCH 1/3 v2] SUNRPC: remove printk when back channel request
 not found
Thread-Index: 
 AQHaL6BODuJxHzRsvEmtdxXl8tg1rLCrwk6AgABbIwCAAuRWAIAAJi8AgAMC+4CAAA3kAA==
Date: Wed, 20 Dec 2023 13:54:36 +0000
Message-ID: <30058A8C-7A1B-4C48-A13B-B071424FADDC@oracle.com>
References: <1702676837-31320-1-git-send-email-dai.ngo@oracle.com>
 <1702676837-31320-2-git-send-email-dai.ngo@oracle.com>
 <66BB600A-2C0D-457A-9A13-0F1D7F5E44B7@redhat.com>
 <A958C4F7-7DA4-4BA2-BAA5-9552388F5498@oracle.com>
 <689A6114-B5B2-47DF-A0D6-6901D8F52CBE@redhat.com>
 <AD542840-D60F-4446-8669-13123FF00703@oracle.com>
 <217964D3-3808-48E4-A879-37E4D5E463C6@redhat.com>
In-Reply-To: <217964D3-3808-48E4-A879-37E4D5E463C6@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.200.91.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|PH7PR10MB6228:EE_
x-ms-office365-filtering-correlation-id: 3702f444-e866-4f53-fcfe-08dc016333f1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 dvtxhrlUf+HCi0QXmc/H6n/xTVLD8cq/Dp26zXUTVA+1/RqOFDtoI2gIFVdG+2do5Sd4plrz6p4yw7IOygW4mgXH2ronYALkD6yoUQ3KA2Fh+HpBVWk0P6r6UwYvGeYCIW9v7KueOYFuaBVfdfi9mscyiZM741O4fqWAFZD4imNuhltbdBBXJRdioXkdVmSmyRkFcloaEuqZYm2Q6Qob4Qi7nltPtnRO257CLkVyHPV8AKrP5G/N3RTlwbhOEQ3UmyFVpCn4wg2h3pb5dYWcpX7xhaE5Cnp0KlZfpXPJDYUJCwQDYT5ryMlrtYd7CVjXHzGIwp+K+QT+XghZ3KHoDGXI3gM0NT6DHiOD2HZOMpJcF2WXdol40HDydUfpxJxSAhD/06OaFawcWC9wQt/WVPnvQz4JpIGDuPDToDBlS3a7kGy2fIalKBySznqO8515Zr4KnHMSgx53vNjJ98rq2+4BQ4upQ9y94wFZ4wbcs2bdEltRuuBDEJkYiyvmDa4HZkZXqaIgC9sWvdByAo6ebndbE5jQx627Hy5tIoGHWafFCyxWKtg1O1wwhBKcDhFfjEOQQYS9N0udz+85gzZGStaAB0JpfaLwHIPxGy/aSdaLB9qAOOTrGKarLTo/uUdWFRqRMOKQGYBZN0lO7MfnDA==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(136003)(396003)(346002)(39860400002)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(66946007)(66556008)(83380400001)(2616005)(76116006)(6916009)(316002)(64756008)(91956017)(66476007)(66446008)(54906003)(6486002)(478600001)(38100700002)(26005)(53546011)(4326008)(8936002)(8676002)(71200400001)(6512007)(6506007)(5660300002)(2906002)(4744005)(86362001)(33656002)(122000001)(36756003)(41300700001)(38070700009)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?YlIvY1kwRVA1V0NYd1UwT2U2V1BlSU9XVFp3MHZLckMvTFV6S21QejBSYkl3?=
 =?utf-8?B?YUlnRkEycTZvdzlkYmk3cU1YVTYvRzkyNXZYRloreVovWnpzSnNnRW9nNUQx?=
 =?utf-8?B?SnJTVXlCZGdjaG9CZmFKT0NOaUZwMElOc05WeDl5NnFXMXp3Y1JCV2NEWDli?=
 =?utf-8?B?S0s4NnJNcXBtamx4Yzd0dHB2VzVxVzhBbEp1YWovNmlLUXorOW1lSkhBNkxB?=
 =?utf-8?B?ZnF1TENiQVA3d0l6bDI4L0oxaDYyUUV4T3F5dGR1dVV1MUpBbGhRSnl2TGtt?=
 =?utf-8?B?Rm14TGZOV05LbjhDbG5UanJ0Q1dnYS9lWHlWSnF5WWRIOUxQNm9DdDlzRjJO?=
 =?utf-8?B?WS9IUzFwQm11YVpFS2N4YXQrN0dRSUVsSFR4YkxkeEpaWEtXa1pPWTBSMldK?=
 =?utf-8?B?UXhzRUpkbnJvUkF4VTJuRjEyZFloY3hRVlJzWHlzaDhHYmNGQmhVd1N5R3A3?=
 =?utf-8?B?WEtzU0pUQzY2aW84SWZKaWdJM21FSmFuSUVCOE5VcHRnNHFOUll4RjNONVRO?=
 =?utf-8?B?QjBBeWovSkw1R1Z5TGFJUDNFMHVDNWkyOWJzdE9oem01UXV6aTlWQWF5UnFl?=
 =?utf-8?B?bnJXbVExZHpjWC85VENIdnNzelV1ZzUwaldaMFpVSGwzU0krb3FkdjduMzQv?=
 =?utf-8?B?TW5TbGVYNnpObkJFN2VlMzMrRG5oZk1kN1d1aDhCa0hYS1dYRzdWMTJDTDBP?=
 =?utf-8?B?NFFoY05lcG4yWllFcE5FeG00czVDMHZPT2x5UG8rejA0Y2JoekpjRFg4Nmk2?=
 =?utf-8?B?eG9OTmQvelNNclNwbUlWc0EzQ0VtWVUxc2xBSjgyK0JyNHBvdStxWGo1MkJS?=
 =?utf-8?B?dWF0STFGdVlreXZhVmo5MXRlU2NCaisyUVVkZUdFZmMyUTNEUmtQWFo5UVQr?=
 =?utf-8?B?ZG96TWw0c3p1NkFXMHArN01EWTNOUUY5bGRBZENBdkI5UGMreW1VVmtJdHBO?=
 =?utf-8?B?SEcySExNTjNqQ05kMXBhdGhsdjJpOGxzYWhYN3R5SGd4dm9Yd1QyY3B1bTAr?=
 =?utf-8?B?N1dudGh3aUExOFRNUDIrUVlsUjJhbjhMZno1d29lcm9ZSlVoYndaMXdtK0dB?=
 =?utf-8?B?bFFjbGVBbGhOcmJPZG5QWkdHa3JuKzNZL25YVjVUZUQ4Q1RvKzJLN0NmL1lw?=
 =?utf-8?B?WXpDOE80Q2wxQnhNbGdGbzFKL3BOd0RsSjdhS2lRakVYVGZxbzVjR1BUMU5D?=
 =?utf-8?B?dFNCcUdyUHh6d1JJdlBETk5ubjdnZ1FvMFhES2d1eHc0NERJUjZUSzh1dnNk?=
 =?utf-8?B?dTh4TWg2Wml1ZWQ1bE5mOE5oWDBZaWZEMWUyVitBa2JTY0ptSlRHSzdlVm8v?=
 =?utf-8?B?aXBHNVJhZEFjM0MrOVUzcFl1c2treGpaTUxXUUdteGF0TnlJdHB4ckpDMkdB?=
 =?utf-8?B?Z1ZRdXBoQlhSQmxTMjlTTEtvVCt0QnJicG1FUGc0RlA0dUtkRk5yN0FQbjZy?=
 =?utf-8?B?eXhEenpzYXllSnNZVVZzbnpqVmlsWHNhN1I1NDRsbDlXampJRk5BTTJWemJo?=
 =?utf-8?B?TkZ5N0hpMmN6NXJqVzUySmt4Q2RXQUFwYS9oY3dTMUJXVWRPaVUxOG92QnBJ?=
 =?utf-8?B?U2RDTW5ORFBFNGZDaXhqTmxBOTZwV0JWQ3M0Z1JIeGZHVmJ2azJKblg0THR0?=
 =?utf-8?B?aWladk1OeHVkaUVvcFJpeGdiTk9BVWpwdjJaUHRRS3FWcFB5SGtGd3NMMTRQ?=
 =?utf-8?B?eDJ5RHFraTRkRGxzU2JIbitIdGRYZjArLzRsSzRWUFl0WW5acUxlY1RIQVZV?=
 =?utf-8?B?Y1pnRFppSTYxTEtJVWpvVnFIc1hXb0hUU1VVNXhad0d4N0JqeTYvR1RTei9X?=
 =?utf-8?B?SHc5MHlZekVJTGNPUk9KRHpYTWVMZ0R5RjF3RGV5MlpJM3hESjZwQ1hMMm8x?=
 =?utf-8?B?UWttb096d3I2dURLZUdVZ3Mwa3AvZkZPQ2RXbEpRSlB3SDMwQUovem5hT3Nq?=
 =?utf-8?B?UzRjVTYwMzkyQlNIbUlBZWJzenZRWHlaVXJRdWpDRGxJcnhDbHNDUFN1N1R1?=
 =?utf-8?B?a0ZNSnp6Rk9kY1FMUlBieFVmM1g0TVRyNTdsT2lmYnJxVFpYc2NneStXTFBE?=
 =?utf-8?B?d1NGMEt1ZTZCdWJvNHl5Zm1uOWJiZ1k0WWtlN3Z3LzJBaEl6NUVYNnB6Y1lw?=
 =?utf-8?B?cVRKd1FwSEpZbG9DVmRlek9tckxJekZzQWNtWDVQZDdSazRjL1BnRG11QXM2?=
 =?utf-8?B?aEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3A583B64D074D649A2C7C229B07CD907@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	sDhpLKMkDqFYWdp0J5EYGkEbh02bFLNuv6jeBO7WTlP7ANQzqE0eZaSGjqe7HAPuisPYMhRKxzXb7CWw5gkePMGJK1iJT9GgMJrmS8lO89mROHJi5dw4QdoPp17AJKv0wLoDfqSKxvWT1HBJ4d9sHdpRk7WsKgb7EZn+B18VDFHhlrAGnJuQ8vtcTbunW381ZaDkpW2rOdzGoLf5ONCmXUIiGEGJPUcifNNOkLm34/nyt8Ov6iKqebkDWtWSpTmAFltpZHVbIYonCbqyCyVfSigRn6sDLqf3HTFuLaJKQsaijdhjDibIL8mKEeD5zUXd5pd0basaPRbv+2uoAbUgXlLq8zb0hCIHq1PH9jIO47SpvGMakf/R3yz5Mv9tpeeMC45H9SC7jDLV9o1GCiIJ3FB48ZVlNS/6vptZSdPt4GUKmDiF/JDthRmSX9bNh0KLh4JhnwCSChwoAgbA+cUfg2QuFB59o3Kpiuf3JrgNjYNgvxALBDBF7gBs19DehAoPnFwwm9UsAVvPqGO8yJaSYdhG/vC3I2dHs0dvSb/I65kRFS9BqkDwd48kF9sfnfZwXtZQerup+CGC7Tlger7bso0QrvOVopX8IcmdDx8vV+E=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3702f444-e866-4f53-fcfe-08dc016333f1
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Dec 2023 13:54:36.3927
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4/q5smZBlW5RpdL09C2TWZurK55qr3PVEQ9DnoPmLWS9ibgjsPd2OMuszcmwUXczWhqNEWii5sx4W1oUattHFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6228
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-20_02,2023-12-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 spamscore=0
 mlxlogscore=818 adultscore=0 suspectscore=0 mlxscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312200099
X-Proofpoint-ORIG-GUID: O4g45ogaybR9D6xv5-5lqnqsiuVU_lzz
X-Proofpoint-GUID: O4g45ogaybR9D6xv5-5lqnqsiuVU_lzz

DQoNCj4gT24gRGVjIDIwLCAyMDIzLCBhdCA4OjA04oCvQU0sIEJlbmphbWluIENvZGRpbmd0b24g
PGJjb2RkaW5nQHJlZGhhdC5jb20+IHdyb3RlOg0KPiANCj4gT24gMTggRGVjIDIwMjMsIGF0IDEw
OjA1LCBDaHVjayBMZXZlciBJSUkgd3JvdGU6DQo+IA0KPj4gSWYgeW91IGhhdmUgb25lIG9yIHR3
byBidWdzIHRoYXQgYXJlIHB1YmxpYyBJIGNvdWxkIGxvb2sgYXQsDQo+PiBJIHdvdWxkIGJlIHJl
YWxseSBpbnRlcmVzdGVkIGluIHdoYXQgeW91IGZpbmQgd2l0aCB0aGlzIGZhaWx1cmUNCj4+IG1v
ZGUuDQo+IA0KPiBBZnRlciBhIGZ1bGwtdGV4dCBzZWFyY2ggb2YgYnVnemlsbGEsIEkgZm91bmQg
b25seSB0aHJlZSBidWdzIHdpdGggdGhpcw0KPiBwcmludGsgLS0gYW5kIGFsbCB0aHJlZSB3ZXJl
IGNhc2VzIG9mIGtlcm5lbCBtZW1vcnkgY29ycnVwdGlvbiBvciBhDQo+IGNyYXNoZWQtdGhlbi1y
ZXN0YXJ0ZWQgc2VydmVyLg0KPiANCj4gSXQncyBwcm9iYWJseSBzYWZlIHRvIGlnbm9yZSBteSBm
ZWVsaW5ncyBvbiB0aGlzIG9uZS4gOikNCg0KVGhhbmsgeW91IGZvciBjaGVja2luZyENCg0KDQot
LQ0KQ2h1Y2sgTGV2ZXINCg0KDQo=

