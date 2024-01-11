Return-Path: <linux-nfs+bounces-1035-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F307E82B05D
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Jan 2024 15:14:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11BE81C21DC1
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Jan 2024 14:14:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 291E43C47D;
	Thu, 11 Jan 2024 14:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="IZ1LHLmC";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="i+i2cmWE"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 167C13C092;
	Thu, 11 Jan 2024 14:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40BB6X6P000525;
	Thu, 11 Jan 2024 14:13:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=Vz2aqQeSNqewnd07QmeJfxeLtFu3oi9CdoBaoFgJAZw=;
 b=IZ1LHLmCLEFqX3F9fISshAPrNQ/UWhVo1GrWJkRwHmcaHGoNDdmwcMRQnmZbIGSW26tV
 H7fQRQOpBfW4nFFBVnt7u8uX19NCdYwB5DIU9O6G7P7f1eBfKXGsR+vVkRTa7abcNDTW
 Y2f2mnvRWjAun8preOmLCadChw0iOAuUTp1FF+7q5CQoX68eR3T0sj8zbaVIXvA1gpa8
 kPFJjNTn5mSEM6OiMYpS1x5UZq+IbswIRQDdGqAQwryFW22EomWm6KFdcmhjyR1Xldfo
 01f6ZNKvGexwlbhzump8AYn9ziYd1kLithzFIp6vkFU/xNmqLl2+IerfC8SZeHF7Y0Ql dA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vj4wwh828-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Jan 2024 14:13:30 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40BDGl3Z006706;
	Thu, 11 Jan 2024 14:05:56 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3vfur6yb4y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Jan 2024 14:05:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ABBeJptSn/roJIeklJgUG1kojUZZBxlsYMVYnD9nKnwj80bUChaHTMxqLAKDyevE//QmOz6gIRlh+8ffyN42BXij7J5IJvK/SZMlfht+kujoMA+2rNpUvzlCjAwQ5yxMMAai+UVrwVsDPVkHv/QFZwevXcAeMMOkhxFG0MOC07koIp7eUWaktg5UCktuGn6oh1qu3wX+lRKxpzbC2KHpnYHkIxxEbV3yhTlFahcQoCn5BFCUHrdvNfuApzesFRzpN3WH27fYZyu8sUlvnyU8JHkrZv8YrAnUaFigWLcCY7a5CQg6YxShun7CPLix1reOKsWjQnY1ab4ZCHGUUa43BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vz2aqQeSNqewnd07QmeJfxeLtFu3oi9CdoBaoFgJAZw=;
 b=Mrwn447K9aBJagAwdUJfwXiMcn27UoyNcLScwDLUTBYz2okAOkCIV4PWz7473NM+n3zDJ+erpxDS1us7H0Lh2X/0uiBvzZj/TnKuGQf5s/nT8Wjld0yVr+z0ReL7ryL0E/VoGJ5owAN4+sK8bKeXUqzylM43VXr+0rHqYu7lIqSjupRDiSEn3xApyHIjaTjpEiKPi6/dPS9QhbAX6K67wtE07l34afygcVUAhKgkaKbRx6CbNdhZTbtzkfd+tl/FErSTQoUgA9yKDFEVZOcAwwdhRDSmrr7Bm+JkjXCAcmJXoRwzc3X4dGBc0l7R/douOhqTGeie+6HnMxnz99p4xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vz2aqQeSNqewnd07QmeJfxeLtFu3oi9CdoBaoFgJAZw=;
 b=i+i2cmWEqygRo/Hlr6/7CALeeNp/QARAgYb/JVVS44IJOffhbGkZDenrYyBtuK+6lT0K9hBU743yHDS01GT/dIUzmkghaE504bGSYX+xriR3z+ykt9VgJzmKSFsykOQt7oxa3DeTkp7S6GIJmvTPpTmUHcGcEbiIDZ4vF9355lA=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH0PR10MB5257.namprd10.prod.outlook.com (2603:10b6:610:df::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.17; Thu, 11 Jan
 2024 14:05:53 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::4027:2de1:2be4:d12e]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::4027:2de1:2be4:d12e%3]) with mapi id 15.20.7181.020; Thu, 11 Jan 2024
 14:05:53 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: email200202 <email200202@yahoo.com>
CC: Greg KH <gregkh@linuxfoundation.org>,
        Linux regressions mailing list
	<regressions@lists.linux.dev>,
        "kernel@gentoo.org" <kernel@gentoo.org>,
        linux-stable <stable@vger.kernel.org>,
        Linux NFS Mailing List
	<linux-nfs@vger.kernel.org>
Subject: Re: [REGRESSION] After kernel upgrade 6.1.70 to 6.1.71, the computer
 hangs during shutdown
Thread-Topic: [REGRESSION] After kernel upgrade 6.1.70 to 6.1.71, the computer
 hangs during shutdown
Thread-Index: AQHaRGdDPVVRS6J16EqNLtqy1gmHDLDUWOsAgAALIICAAAMCgIAAPMqAgAAB4AA=
Date: Thu, 11 Jan 2024 14:05:52 +0000
Message-ID: <1FAB3DFD-1CEA-4E7E-BF2F-12755F511A98@oracle.com>
References: <58ac38ae-4d64-4a53-81e0-35785961c41c.ref@yahoo.com>
 <58ac38ae-4d64-4a53-81e0-35785961c41c@yahoo.com>
 <2024011127-excluding-bodacious-1950@gregkh>
 <3b8250ac-79e4-46d1-a508-5773e6330fb4@yahoo.com>
 <2024011114-attribute-semisweet-788c@gregkh>
 <bbfe6944-a7f0-46f5-8a30-79eccf84664d@yahoo.com>
In-Reply-To: <bbfe6944-a7f0-46f5-8a30-79eccf84664d@yahoo.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.200.91.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|CH0PR10MB5257:EE_
x-ms-office365-filtering-correlation-id: 85976010-ceb9-4182-61c7-08dc12ae6c44
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 G9RpungpNCHmzUnbPJ1++eUBbtkX6510Hkv3Mte7W7QaksjfVxiSHA7KtzBJ5jiXy1PgIPRX7ieOOGAsCo0wg78+B5j0BRsGZ22+ff3iYS1Z4qQbDX/OtZUXhsYwz4ZhiZ4kApKqtm9Cvu2lcxqaOU22JBY2JA7CtVn7z307lNW2XT+euIPD20lVRXPKRIEDoF9xDq7GJ7CFPJ7I/fyF1zw4tybUcMkYS4hOKPZKpNEn41fQGl69ZjNoTWPyxfLBZaepNX8cpb7Q6O9Ep4eYuZb9yB+aA1UVopnU20mVCLztcESZeGAiltFoJvwssIk6SdcZ4PrmXPbzlH/h7SlIbvMAcsr2NadMe+qwvtcfroAxr9K3HUKPcweK+RMdKA8Qtvveo/GAYeidJ8SvkR0t+ZmOmhQEsfgmAyLgGCYI83yDq8pUoFRP+S23TfK/7orS4efXxKACjax5F/+24MdyE8Us/vuzpey7XkAp++pATmfa3jcT/cSeJaOzCkFqIuXjwNi3nkl/Hx56xy6XN2GFERPefsoyC5i8Nvkr/ozETc/MuFySh4nzUNGCEqJ0yBwKfRwWoYMdSM4txg11k/25A4foJJ9WRK3hqXAtWZgqQwh/nHxaM4+JIV35GgV40r8OCzGgzquLej0N97Lzi/GPf2UF1DrjRGC7VyFYPqD8X7BnMJeLyeQQAq2eTD6dWJKH
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(396003)(39860400002)(366004)(136003)(230173577357003)(230273577357003)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(83380400001)(33656002)(26005)(2616005)(71200400001)(6506007)(6512007)(478600001)(53546011)(6486002)(8676002)(66446008)(8936002)(38100700002)(91956017)(36756003)(6916009)(316002)(64756008)(66476007)(54906003)(76116006)(66946007)(66556008)(4326008)(86362001)(122000001)(5660300002)(2906002)(41300700001)(38070700009)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?dFc4VGYyK3VvS0tYNmlpZ21OVGxYVnBIYWl2eHN2d08xZWZQZ01mbldNOUpS?=
 =?utf-8?B?UXBGL3FHUkxQT3dSMGhodm1jaEhrVE5PaU04YWk1c25FTnBhZjRZNExLNlo0?=
 =?utf-8?B?K0Y3bzVrNHQ5dFBNeUVlU2ZmTGdQLzNkMFZPbGxVRXAzNkxSS3owSjNWQWhD?=
 =?utf-8?B?d2pmYUZqTnV1Ui84YWFhK25XcHgrNmdkRTcwd21NM1lmeWErek9EQ1ZwazZB?=
 =?utf-8?B?WWFyLzBJWnB0UUM1MzdHZmN6U0dPSTZ1b2dFUDdhdEZSL1Zsak5XSkdrUkR4?=
 =?utf-8?B?K0xReSsyRlhZRnU0RERSSXhCZUp1dU1yUHd0UDN2YStXSTByOEhvQ3djRVIz?=
 =?utf-8?B?SDY3Vmk0VUsvdE02NGs5Z0FUMmlmejlKaytTU285VERWeTJValpKQ3kzZ282?=
 =?utf-8?B?QWhjOWZkU1IydDFBQVg1TGhWN1JHTXZxR0hTaWcxYkxXSjdONXdiem1nOVQ2?=
 =?utf-8?B?NDhiUEtSK2EwMTA4QUJjZ0MvWEF0NzlBUmt4VXNTaDBkTEJPNlI2ZHpaUThF?=
 =?utf-8?B?R1dyeng3ZEhvRzI2ZXlhOWNKRkQwWkpwaldrNW5mV2oyWGR0K3BVNUZVYklG?=
 =?utf-8?B?MFIvWkJuS1haUk5iYXNoNndXb0s5N3pCS2NwZXMra1h2NFJIdmFNOE9sUTcx?=
 =?utf-8?B?cWV0aWt2cGVqTU8xOENLbFNrSG43MzVnUUM4Z2lEdGFrT28rYVBYQTBJQjZS?=
 =?utf-8?B?bkpXaDdrMWJTc0NIOXRFdlJIUjdQbkpHZDJ2YWlCSGpubDh4U2ZhWi8vZGRK?=
 =?utf-8?B?SEV3czl6R0tQKzMvbVlMYy94TFhLd09SWFJqS0swUVJJQ2ZEN2d1Nkw5MmN1?=
 =?utf-8?B?REkwVGZjcnZBSy9Td2VIYmUzVkJCUCtneHd0ZEdaeEVwVE5YcDY5UWo1OTRS?=
 =?utf-8?B?K3NHeEhhOCtXVEV2S0JUeGdTdjhNYVN2bjM0Z24yV2dRelZVQnpSdzEzWlNL?=
 =?utf-8?B?Ym85WERpSzVoaWNTMjhMWW1aa0hPQVdJMEJLQzA4d0dDNERUUFBQeml1TlhG?=
 =?utf-8?B?R3B5R2RNcEplSHVJYWVjcWo0cDdDY0pSM0ZJZlRqZkQzV3UvS2xFQ2ZDMTRF?=
 =?utf-8?B?a09jY3VyRVk4dWM2c3BDVjg3SjdkQTdFc1BQTzdLMXZQWnl0M1Ereis2R2JR?=
 =?utf-8?B?b3NPV3Z5dHp0b0tYZTUwNmpmeE5jQWhNS3ZEN0ZlMm5Rd2tXNzJYbUpPczFM?=
 =?utf-8?B?bUxOTmlpMld1L3dSQ3krdDlpRXp2eGpWN1N3NTUvUysvV1E0dmswR0JxYWdk?=
 =?utf-8?B?elQzcXI1SWxtdTlEcDl6RjI1S2NpOVNKb0xGMmVsQklkQjJJL2Y2L043WDJs?=
 =?utf-8?B?eUx2bFY5bkplblN2Qk1yaXNqb1JscVRkWjJuaVNjZXVEM1Z1SmNWZHJrZjVa?=
 =?utf-8?B?M05VMUgrZFJ6YlVxYjdaNTNseXZrRmMrdERFZkVzK29GZUcrSnEvM3NIOThX?=
 =?utf-8?B?L0FrYTJkQTdxRzhnT01RK00ycDBKbEg1T2FzYVhldlVZY3N2VU9lWUppOEFj?=
 =?utf-8?B?QXdmS2Y5Umt5WXBkVGx1Mzd4VW5kbWQvc0h1b2ovQ3d1aW5wM2xwSEFmMktW?=
 =?utf-8?B?NGViNmc5VlArRzkvN3RUYU1LNVNpOXN4cmVoUG1ySVhsM3IwcTlKWElsT3F3?=
 =?utf-8?B?WXZFcm10SXFLRWRqUzRORXFwRW5wRFZMZmY2TW03MWdtM3Y1aHhQMmpwUHpp?=
 =?utf-8?B?NnVzM3paUlA0Wlk2djE1SVk5SndWVERZR3FGM29rWG9nWXAreUlZRk5DamtT?=
 =?utf-8?B?YlJFR09vN05CVmRWRzhhRzZlZEFhR1orZytlTFVmTjVvenE0cS9jYW9PSS84?=
 =?utf-8?B?RDR5Nk9KWEd4WlY4UFpLeTZTZTNnV1FUblpJcTVQMG93eE1jYkw2c3hhWFZI?=
 =?utf-8?B?aFA3UFZsTDk4Q0hYMzFCbFR5YW8rS0RpazRLWll0Vk1mV0ZGaElkenArOWRn?=
 =?utf-8?B?NzNXQ2VqVXlmV3FQQzEzeWpCeWNJTmdpK1g1RDJtQXJlbE8xcW05TFFRdC90?=
 =?utf-8?B?ZE5qUHF3WGQ1SUlZOEVqbXVPdDErSGZWTERCQU5NSUYwNXJaMlRxOFlCUENY?=
 =?utf-8?B?SHRYUXVGZHlBUzJ4aTYrVjRBQ2t3alAwV2x1VTJQd3BZaU9wUDZHR29CZ09T?=
 =?utf-8?B?TUNIWnp2NGxxOGtQdFlWNlRsaU1pK2lhRXI5VVdaUTJ1YTQ2eUxnODZZTXAv?=
 =?utf-8?B?cVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5335EC94C40E2F4A9B3CB1B7B54439C9@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	6vBWfcu7M3/UQEBXoQeSO9aWMaF304I2WFMrNzHONsaYRAV7S9AuN+VWrvrs1CqrAL8byb2YOcPK1xUUx+Zr7qRzkjieRCbuDYlpkKPJ1hgMcff+V7pfzRakNsP8yCApwoPTL/JoEVXe5tZBZS0spYzAffKNUKah+BMtW7GQliQROWYJSLCUiXGpuMQi4HAv29We1B/hjDs8WdGvTY31ZhzzJLzd124iIJ2fUqyY/YU5SmCRMN8Vyfup5Mkn/QDS953poRPetx/543l1GkUcGJJNIQ9ixHPRfo0VahRsR+mvhPAlNUBtC4xnevn4Q0LBnFkPl7UpabUlyDZZOCqZwM21iwIIZ5wR6XvRVbjIU51xBmaFvl/0Yi72HPlnRtGx5UlRXkShpsBCFuDiA7taxCiDKUD04H94ZbNQ47swUuf2vOu/FrynHfuXO8eNBEYPoZyfzHY3qEL9Iy+bv0bOn9ClTkB7RAzsJuW1G4VHkx37sKyoqIIqr+BvgQt3X8r7oshynQ+wEMoHncqj3B6xfuKkJ9KAWLvPVepKM+L0EuKtFtsdrEHj6JiPW7er7yPPCIO04X8t5d69tdCdXz8Buo3sHhzlbfeBEibKDAhjn1M=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85976010-ceb9-4182-61c7-08dc12ae6c44
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jan 2024 14:05:52.9501
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qFGhCuhQJp14oNFEvZdefSXWPb7oSUKGajlYurfw3z3iByLKimSAJtXBybIw+R7wsqc/Gu08xkwXLl1hsEvtPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5257
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-11_07,2024-01-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 spamscore=0
 adultscore=0 mlxlogscore=999 phishscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401110111
X-Proofpoint-GUID: lNIFv7DJCc5znbYCU8PWGdeEkXWrxCRd
X-Proofpoint-ORIG-GUID: lNIFv7DJCc5znbYCU8PWGdeEkXWrxCRd

DQoNCj4gT24gSmFuIDExLCAyMDI0LCBhdCA4OjU44oCvQU0sIGVtYWlsMjAwMjAyIDxlbWFpbDIw
MDIwMkB5YWhvby5jb20+IHdyb3RlOg0KPiANCj4gSGkgR3JlZw0KPiANCj4gSGVyZSBpcyB0aGUg
dGVzdCByZXN1bHRzIGZvciB0aGUgbGF0ZXN0IHZlcnNpb25zIG9mIDYuNi54IGFuZCA2LjcueCBh
dmFpbGFibGUgaW4gR2VudG9vIHBvcnRhZ2UNCj4gDQo+IDEtIFN0b3BwaW5nIE5GUyBzZXJ2aWNl
IGZhaWxlZCBidXQsIHVubGlrZSA2LjEueCwgaXQgZGlkIE5PVCBoYW5nLg0KPiANCj4gIyB1bmFt
ZSAtcg0KPiA2LjYuMTEtZ2VudG9vDQo+ICMgL2V0Yy9pbml0LmQvbmZzIHN0b3ANCj4gICogU3Rv
cHBpbmcgTkZTIG1vdW50ZCAuLi4gWyBvayBdDQo+ICAqIFN0b3BwaW5nIE5GUyBkYWVtb24gLi4u
DQo+ICAqIHN0YXJ0LXN0b3AtZGFlbW9uOiA4IHByb2Nlc3MoZXMpIHJlZnVzZWQgdG8gc3RvcCBb
ICEhIF0NCj4gICogVW5leHBvcnRpbmcgTkZTIGRpcmVjdG9yaWVzIC4uLiBbIG9rIF0NCj4gICog
RVJST1I6IG5mcyBmYWlsZWQgdG8gc3RvcA0KPiAjIC9ldGMvaW5pdC5kL25mcyBzdGFydA0KPiAg
KiBXQVJOSU5HOiBuZnMgaGFzIGFscmVhZHkgYmVlbiBzdGFydGVkDQo+IA0KPiANCj4gIyB1bmFt
ZSAtcg0KPiA2LjcuMC1nZW50b28NCj4gIyAvZXRjL2luaXQuZC9uZnMgc3RvcA0KPiAgKiBTdG9w
cGluZyBORlMgbW91bnRkIC4uLiBbIG9rIF0NCj4gICogU3RvcHBpbmcgTkZTIGRhZW1vbiAuLi4N
Cj4gICogc3RhcnQtc3RvcC1kYWVtb246IDggcHJvY2VzcyhlcykgcmVmdXNlZCB0byBzdG9wIFsg
ISEgXQ0KPiAgKiBVbmV4cG9ydGluZyBORlMgZGlyZWN0b3JpZXMgLi4uIFsgb2sgXQ0KPiAgKiBF
UlJPUjogbmZzIGZhaWxlZCB0byBzdG9wDQo+ICMgL2V0Yy9pbml0LmQvbmZzIHN0YXJ0DQo+ICAq
IFdBUk5JTkc6IG5mcyBoYXMgYWxyZWFkeSBiZWVuIHN0YXJ0ZWQNCj4gDQo+IDItIFNodXRkb3du
IGRpZG4ndCBoYW5nIGluIGJvdGggb2YgdGhlbQ0KPiANCj4gQmVzdCByZWdhcmRzDQo+IEpvaG4g
Rw0KPiANCj4gT24gMTEvMS8yNCAyMToyMSwgR3JlZyBLSCB3cm90ZToNCj4+IE9uIFRodSwgSmFu
IDExLCAyMDI0IGF0IDA5OjEwOjM5UE0gKzExMDAsIGVtYWlsMjAwMjAyIHdyb3RlOg0KPj4+IEhp
IEdyZWcNCj4+PiANCj4+PiBJJ20gc29ycnkuIFRoaXMgbXkgZmlyc3Qga2VybmVsIHJlcG9ydC4N
Cj4+PiANCj4+PiBJIGRpZG4ndCB0ZXN0IDYuNi54IGFuZCA2LjcueC4gIEkgdXNlIG9ubHkgNi4x
LnguDQo+PiBDYW4geW91IGRvIHNvPw0KPj4gDQo+PiB0aGFua3MsDQo+PiANCj4+IGdyZWcgay1o
DQoNCkkgaGF2ZW4ndCBzZWVuIGVtYWlscyBiZWZvcmUgdGhpcyBvbmUuIEJ1dCBoZXJlIGFyZSB0
aGUgb25seQ0KdGhyZWUgbmV3IE5GU0QgY29tbWl0cyBpbiB2Ni4xLjcxOg0KDQpmOWEwMTkzOGUw
NzkgTkZTRDogZml4IHBvc3NpYmxlIG9vcHMgd2hlbiBuZnNkL3Bvb2xfc3RhdHMgaXMgY2xvc2Vk
Lg0KYmI0Zjc5MWNiMmRlIG5mc2Q6IGNhbGwgbmZzZF9sYXN0X3RocmVhZCgpIGJlZm9yZSBmaW5h
bCBuZnNkX3B1dCgpDQowM2Q2OGZmYzQ4YjkgbmZzZDogc2VwYXJhdGUgbmZzZF9sYXN0X3RocmVh
ZCgpIGZyb20gbmZzZF9wdXQoKQ0KDQpBbmQgdGhlIGxhdHRlciB0d28gYXJlIGRpcmVjdGx5IHJl
bGF0ZWQgdG8gTkZTRCBzaHV0IGRvd24uDQoNCi0tDQpDaHVjayBMZXZlcg0KDQoNCg==

