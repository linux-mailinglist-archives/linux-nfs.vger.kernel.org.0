Return-Path: <linux-nfs+bounces-689-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CFBDE817429
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Dec 2023 15:49:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A98A1F212E1
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Dec 2023 14:49:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04DC9200C0;
	Mon, 18 Dec 2023 14:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WdsmT+G/";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="TEQ/FlW+"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EC26101DB
	for <linux-nfs@vger.kernel.org>; Mon, 18 Dec 2023 14:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BIDhsbt015916;
	Mon, 18 Dec 2023 14:49:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=5UFdmC5vBblEEqPUr7f8PPLN22pMqll6xlVQhTYaxng=;
 b=WdsmT+G/car8cJ77qrSNx+2kGdBM1wWrbO0iJreJjVh7I+5gROQoFfI92dQyAfTjarV6
 w+TOkVjDqn+4Q+gQ8QZQVZm/J55KCNVzb2oKZc6bdcZcN3Hr8C6hkwJjdipHZlDwGuTE
 tagXhYT8NweTCblUu0OQk1oe8MB9mUS+UWzfjOJIWf52z8O4rCkYNFqZbDBir3DGXMX8
 BypqKCooyA1uBfoPVGg50IBljXCNvMBpBE/N8QFO5PbiadD9bNGOyVUa8Z68/iV93m/+
 0pgOgIM5cp6CmQBtGOY6p0kUT16XpOmRD2LX45VEtCMSPupde7l2tOlzUsg0LsMEKC0E gg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3v13gubfmv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 Dec 2023 14:49:26 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3BIDdgHL022284;
	Mon, 18 Dec 2023 14:49:25 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3v12b5g3d5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 Dec 2023 14:49:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fg/IbRJu4L4wqSLvZ545VsXd9mlCmn42zGCMNLLuvvPJAg5X23PKDPIO7DmdEOJZVkW14/76srhcJZOKGdMfurAiqCsYUm4dOETeDt78B0H0jjETk6+P+DbUScUnrcl5u8TkUG9MH4gjZyOpBQR/YcRdB5rrBUni3+uvtwh+IE5SxdNsI7ETTNf6fxq22Tzg66JQ2vpAciINnl2S2uJXB5+zAXeK+wrlggzk3lJbixi7QtyLJAaCnq00F98ODnL87xMQ6+ohPrOCpGjQzgkEvyIvoumrfKe59GTTulbFnloYzQhZHxxRQinADX/JMu3UV3hNDodfS4/OrnDzu/TAkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5UFdmC5vBblEEqPUr7f8PPLN22pMqll6xlVQhTYaxng=;
 b=YZTPKUZyUZEKL6v1Wa9JugihxMxLhXp6jnDSCnz7pGawCbLJondQBLF9toelEB/2NCXvX6Q/J2mAEUFhGoD25uG9Ix3WUg87K1fdttvfm94SpzdQxedjvewtPudiswVnpyrSBYRjzPrz3eiXPy2hgbyOdjQ3NCSN+xAje4y7RSXCwX1HBn3vj3pNaoyOlr8DuV5j140Dm4yWt0AYt3TSeO4eiooGuGyqlIBd0yueETtNP394Pwf6uf5O4N0hOGEU+iDd5Qmhe0u8RdnR2lO8M2zXWW6+xY/P039owlSjDRyyR/vFbS74Lgvnz6N4uaBKY9n/d4XrV2m0iQjQf+dBDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5UFdmC5vBblEEqPUr7f8PPLN22pMqll6xlVQhTYaxng=;
 b=TEQ/FlW+uyw5rpE2BAR7+lCQTzIMjGpjyZGnG51AP9ON3T7entQp/FsVgah6WgF4SHfL7Oc9l0Ud3vD4Hc7tkYDF2lgRYO/owqFrFpY8awKTx85oiLK8g1NDJJLbkdMBVFR7m6lXFlUJCu477/O8VziT68AwpAAvo4FWcm93PzQ=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by IA1PR10MB6220.namprd10.prod.outlook.com (2603:10b6:208:3a3::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.37; Mon, 18 Dec
 2023 14:49:21 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c%4]) with mapi id 15.20.7091.034; Mon, 18 Dec 2023
 14:49:21 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Martin Wege <martin.l.wege@gmail.com>
CC: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: NFSv4 alternate data streams?
Thread-Topic: NFSv4 alternate data streams?
Thread-Index: AQHaI0GeBpbKRni6mkOBsRTBE2M9rbCS5YcAgBvtpgCAAGkHAA==
Date: Mon, 18 Dec 2023 14:49:21 +0000
Message-ID: <3DF544D4-EFBD-4C0B-9856-91A3092A26B0@oracle.com>
References: 
 <CANH4o6PeiV+ba0uLVzAnbrA3WtG8VSkvjA1_epfLCVyH-r-pJw@mail.gmail.com>
 <DBD9B468-6FF2-4806-8706-EE679BF69838@oracle.com>
 <CANH4o6MGLTCYuDBZfyrDn7OpD=HcUG9KcY8Qhhv5mzHj4Jr03Q@mail.gmail.com>
In-Reply-To: 
 <CANH4o6MGLTCYuDBZfyrDn7OpD=HcUG9KcY8Qhhv5mzHj4Jr03Q@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.200.91.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|IA1PR10MB6220:EE_
x-ms-office365-filtering-correlation-id: 4630bccc-cd18-4ca1-f218-08dbffd884f1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 x0ICygKMdGxonuX8DuJ4wwTi7+tkSorQ6Mx2v2DQ1KcbkruttRX9QvKc0CjZlAWOpH94CWx0KWXqpzdzxDqVjGKgI//wPGNKHjVuuG6f0Lw4mVpyFAU8iMkTCQ192FeU3D9eDheYFB5cp1hQG43uTN9doLrShfTKIOEpJPzODcvJMZsQRgNRiVG1ZaCc9MMcQm32Bt93nwBbx1rP89xO7Rdd1ptLT45J9BINdRB7KQUueSB9e2USzo9HJBq5qlLCsvHxZqizvpytU/P8aTUz1rJJ40n3c9QB+sCb8Enl7FTfwc7ZU8Idieo1cUFch0+btVR4u52spNaKpuis8cu6sdZyTgl4CaJ2Hb2FjbHuvblqhVayskfXzPL19ylPjZdGZXAcCOu+Oc7BTS4tlbo243ck4y+8TcTkKhjGkaodA0PQ2gmc3+PX7BT4xQUrZl8CVXPAh4TuFcbhMPj3RCUpYBL3yjisaV1uthGJ5JyTLsR0JlH1tG/d7+ZVMJtnG0J6GYdSxSrSHlHtqaJuGAOGN+Y+HzjvHKbwJD84uPqEeayGzU+ip6mBtkhZhLDXe+USWoqxVSBxnD/K8xgYJdnUbZFnfHi+sqS+2s08GP+L96XJ+bto6DH7pOkaTWmbZG6YriysO5KfnUw8CkrsL7vU7Q==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(376002)(136003)(346002)(39860400002)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(38100700002)(2906002)(122000001)(33656002)(38070700009)(36756003)(86362001)(41300700001)(76116006)(64756008)(66446008)(66476007)(66556008)(66946007)(91956017)(6916009)(316002)(83380400001)(6512007)(2616005)(6486002)(478600001)(71200400001)(6506007)(26005)(5660300002)(53546011)(4326008)(8936002)(8676002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?M2s0QktkaHR3b25IYlgxajIrTS92N3V5OFA1Nk1vYUhSb0NNSTdHT0RkaHhx?=
 =?utf-8?B?WU50R1Jhd3FWb2d2cjVYVTFDSkdBZWw1ZjhiSFN0UUJjRm5wMUxSK1NEaytW?=
 =?utf-8?B?dFRGU1pQQk41ME1aR1FOczliYnZNVjB4U0Q5NGZNS2ZhN0tNbWhoQVkyWUp0?=
 =?utf-8?B?NEdsbWFZTGpsMTJkSUJiYjZmYXd0bVg3Qis0d2l0RlFyaFo4U2dNaFNZRTRG?=
 =?utf-8?B?S2FmVnV5eG1IZkJWaXhSbFJIT3c1bFExSU54WVcxQlFCNnBnVlE3TnNWYmo4?=
 =?utf-8?B?S0xjUFpZL2JzTk1IdllQc1dJRGJIMU5pZW5rUlRaTUlTRFNQYzA4cEI2K01E?=
 =?utf-8?B?cmVTNzhaeCthZnNWSEFEWXo0TEJlTVZwQjJoOHFLVXJ1WE1RNHRPdm1aSDJN?=
 =?utf-8?B?TmVIVUFhS0VEU2l4Z1pHOEloMWlFWEtQdW9nSy9YMnhMaWFCVXFqOTg3Ylhz?=
 =?utf-8?B?OWVDOFQ0SGZDR2NEZ1VNZmF3ZDE4WDZnQzJiZ0FwN295WEVBUXhOU0JqL0NP?=
 =?utf-8?B?MXRmTGlSWHdyU0cybWxBT3NUeElNTGgvVXFzckxQUENmZzEvY2JtMk0ybVJW?=
 =?utf-8?B?M2swSGFTdDFUNWJZK2w0OHNMN2pVa1dONy9ncVZFNXdCNTdoNUg3TWlydGpD?=
 =?utf-8?B?alQyTjQzS2VXdTBJWHJZZlgwdjRRaytNKytZc01pb3M4ZGpZL2JOUmkrOGxa?=
 =?utf-8?B?dStKTVA5M2k0bHhhYjlKNmlpcjFXemRuc1RLTjM3cFZ6RFRIdTZGNTR0aEgz?=
 =?utf-8?B?SDgyZFJsYzBPait4TUhtazd2a0Fnekc4Tmo2SUFpZlBnOTAxOWdLYWZib1pL?=
 =?utf-8?B?TStGZ2I1Q0d3Qm5aK0dFWjcrYVplSzYwZUNLOVVYM3R2NTRCdUJabDNwbENL?=
 =?utf-8?B?T3Zya1VjTGcrYUpYYzZ2YmJ1bm9laUdzdklYWGQzZG1mV3hiaTBJSUJocUZ2?=
 =?utf-8?B?bEczb3d5eHlJMit6Z0hrcThBaTZYVE9TOFFvV1ZsMlJ3Y0dMdDFhcS9kS3NK?=
 =?utf-8?B?cWxOYlFJb3BhV2hxbHZDeVJIWnBiYWQvbm80dURGWTE3Tk5SWlpFKy8rVUxV?=
 =?utf-8?B?UEp2RE1uS1U1UU1KbUY3S3lWRGJWRkh3emFxL1RZaEJKTmtmOU96VXJPRVg0?=
 =?utf-8?B?STZGcUtXdnFyRS9DRDdVOWcySnlIVFJ0TjdDYmZOY3N4dE9EUG9SM1pDU2NO?=
 =?utf-8?B?MTdlYnk1SVZ3cmZJanVDRVU5L05MNUJrN1lkazZYS2pEdjl0QnhoTkdNRWFT?=
 =?utf-8?B?VERZYkVhNXhZL0Z6d3pCaWRLejVBamhGZFlBelpiYjh6cU1NME5lN1BaRE5D?=
 =?utf-8?B?M2hwU05KY2R3RitnQkJhMVF2K05jMkk0VjNPWXpIR1R5VGsxN1NJWlpOTmdk?=
 =?utf-8?B?UmpVTzF2Uzlnb1VuM3RURTFFRVkzQUdZZ1UyUHN0T1NCNU1uWWE4ZUtsQlp0?=
 =?utf-8?B?SFl0d3FPTVdvaFBFOTVWRUtiRHRORS9oNVNmaVpDSnQyTGRXa0xGaUt5LzBu?=
 =?utf-8?B?S0psNm1oYXFpTUlTcE1OWHRaRE1qdTZ1aDJHT2c5OVlBVnFicFFNYWR0Mmtz?=
 =?utf-8?B?WTlsTFhrTUd2TjBoWjFtRUxIYmMvb3hRbFZURjZuSUZEYVNzSElMM1pPQ2pm?=
 =?utf-8?B?NXE0aHpQbmp1eS90aVFYeVhpM0UxVzdpVUZ1Sm91TnBJbkxydzIvcTQvNkE0?=
 =?utf-8?B?RDVoWkZ5MGlzU3g3M0ZlT3pVUjlGbWRBTkJEMCs5am9OdHVheExBYzNaL0k2?=
 =?utf-8?B?WGt5RWJwWHZwemsvUWx3V2hXQjd2YVFoWWdjZXA2R0ltOTlLRFZiU0hmQVBY?=
 =?utf-8?B?TFpidnEvQy85cXo5aEFrRHk1Wi9VVUtBUHNraEdxNnV2UXdqWVJEY1FTQ1p1?=
 =?utf-8?B?bmVLb3hWaGxkUnZnNXQrUHE5ZXhoaEU1YWxaSjJKcU13RWcwVDllMmxueWdk?=
 =?utf-8?B?bmRON0REMFhNTTY0dXBpT0xKdlRhN2xQclhTVG52YlUyUXIyY042K2huR3li?=
 =?utf-8?B?bTVUSnplamk0d210ZEk1MXd3QzVCZm9kVDA5c3NuVTZ4SGJzWFBZVWdINjg3?=
 =?utf-8?B?cXFpWE9EeUZHZWxadDF1alRzM3JsdFI1VXJLY2gwSU5ybndMZjNRN2dGMDU0?=
 =?utf-8?B?TFU2MXFaR1V5TDNyNFVCQ05VV2ExYndEbDJzOFFKOWdZR05yY21kKzR1ZXpz?=
 =?utf-8?B?cnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3775300D5E247040BC9B4DE797911687@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	2p2eXiKVYs5DRZDc6acduZHzIpxQ2ZxitOvYyGwagjc4qhFrAwe74AS3sE/lu5HQyQqX4a09UzJm1NjQvWwWkkMbWLxDejV4QOTLwJ0u290+8ss0ekLMd7Y/97HQ3UsdIF/fbHEpa0ABip7FAp4fSGg9R9ls7U0NZKq02G7iWKuTQ1f+JfnKTyMJaMcLvXYPMXNeNVqyxIPcm+1pALB9RSXQzl+iq1ba6A7Qqcuidq0smXb8i4VcI1LCGksI4ywCzdDaZyHDTQZn8dqY7NxNj5WDgbRSNFyuy7c7/6e78qaD+UmoIHypLFtEGFK/ZUDpHYAl6OR2VJXbtPX0QqmCc/TmFspbaonMevMOOC1VMHIhwcwMM2Ti9i+u56evnoJ1LBRAYhQZ/ixRqZ5yPY22GEJS4WQg8P/KZChTrnRGQ4WVnZzW1n/kNifPmfT/Z4gAfxp8QJbgc2Nwth9xBzvxfzY1w1khb/RyPOB4WHd4tqxxtJ/3bVtXiNhPgw8BRc971aUXGVOUJit6glWWJ2kNkKKPHak9tZY5MNSnMWLpL7j/mhdVmm24pdTJgZTlf3s4YBAqAanzGDTPlagl2JAIksl5qtXdsrxzmtTAJhVelww=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4630bccc-cd18-4ca1-f218-08dbffd884f1
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Dec 2023 14:49:21.1096
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QcMlgIoPCwbfDHj5vq5cn7FvZMJrka7mcmAfM9cRHwnfzkZgZcIT+7m8ydc71zeHy0TgCXTeJuGMtQJDTVK9XA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6220
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-18_10,2023-12-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 spamscore=0
 mlxlogscore=949 adultscore=0 suspectscore=0 mlxscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312180108
X-Proofpoint-ORIG-GUID: -LBscApdwwSpalsu3_937EXsKbWpbj6b
X-Proofpoint-GUID: -LBscApdwwSpalsu3_937EXsKbWpbj6b

DQo+IE9uIERlYyAxOCwgMjAyMywgYXQgMzozM+KAr0FNLCBNYXJ0aW4gV2VnZSA8bWFydGluLmwu
d2VnZUBnbWFpbC5jb20+IHdyb3RlOg0KPiANCj4gT24gVGh1LCBOb3YgMzAsIDIwMjMgYXQgMzow
M+KAr1BNIENodWNrIExldmVyIElJSSA8Y2h1Y2subGV2ZXJAb3JhY2xlLmNvbT4gd3JvdGU6DQo+
PiANCj4+PiBPbiBOb3YgMjksIDIwMjMsIGF0IDEwOjU54oCvUE0sIE1hcnRpbiBXZWdlIDxtYXJ0
aW4ubC53ZWdlQGdtYWlsLmNvbT4gd3JvdGU6DQo+Pj4gDQo+Pj4gSGVsbG8sDQo+Pj4gDQo+Pj4g
ZG9lcyB0aGUgTGludXggTkZTdjQgc2VydmVyIGhhcyBzdXBwb3J0IGZvciBhbHRlcm5hdGUgZGF0
YSBzdHJlYW1zPw0KPj4+IFNvbGFyaXMgc3VyZWx5IGhhcywgYnV0IHdlIHdhbnQgdG8gcmVwbGFj
ZSBpdC4gQXMgb3VyIFdpbmRvd3MNCj4+PiBhcHBsaWNhdGlvbnMgKERCKSByZWx5IG9uIGFsdGVy
bmF0ZSBkYXRhIHN0cmVhbXMgdGhlIHF1ZXN0aW9uIGlzDQo+Pj4gd2hldGhlciB0aGUgTGludXgg
TkZTdjQgc2VydmVyIGNhbiBmdWxseSByZXBsYWNlIHRoZSBTb2xhcmlzIE5GU3Y0DQo+Pj4gc2Vy
dmVyIGluIHRoYXQgcmVzcGVjdC4NCj4+IA0KPj4gSGkgTWFydGluIC0NCj4+IA0KPj4gTGludXgg
TkZTRCBkb2VzIG5vdCBzdXBwb3J0IGFsdGVybmF0ZSBkYXRhIHN0cmVhbXMgYmVjYXVzZSBub25l
IG9mDQo+PiB0aGUgdW5kZXJseWluZyBmaWxlIHN5c3RlbXMgb24gTGludXggaW1wbGVtZW50IHRo
ZW0uIFZlcnkgbXVjaCBsaWtlDQo+PiB0aGUgSElEREVOIGFuZCBBUkNISVZFIGF0dHJpYnV0ZXMu
DQo+PiANCj4+IEkgYmVsaWV2ZSBTb2xhcmlzIGFuZCB0aGVpciBzdG9yYWdlIGFwcGxpYW5jZSBh
cmUgdGhlIG9ubHkNCj4+IGltcGxlbWVudGF0aW9ucyBvZiBORlMgdGhhdCBkbyBzdXBwb3J0IHRo
ZW0sIHNpbmNlIHRoZXkgaGF2ZQ0KPj4gaW1wbGVtZW50ZWQgc3RyZWFtcyBpbiBaRlMuDQo+PiAN
Cj4+IEluc3RlYWQsIExpbnV4IE5GU0QgaW1wbGVtZW50cyBleHRlbmRlZCBhdHRyaWJ1dGVzICh0
aGF0J3Mgd2hhdA0KPj4gb3VyIG5hdGl2ZSBmaWxlIHN5c3RlbXMgYW5kIHVzZXIgc3BhY2Ugc3Vw
cG9ydCkuIEkgcmVhbGl6ZSB0aGF0DQo+PiB0aGUgc2VtYW50aWNzIG9mIHRob3NlIGFyZSBub3Qg
dGhlIHNhbWUgYXMgc3RyZWFtIHN1cHBvcnQuDQo+IA0KPiBTTUIgc2VydmVyIG9uIExpbnV4IHN1
cHBvcnRzIEFsdGVybmF0ZSBEYXRhIFN0cmVhbXMgLQ0KDQpJIHdhcyBub3QgYXdhcmUgb2YgdGhh
dCBzdXBwb3J0LiBJIG5lZWQgbW9yZSBpbmZvcm1hdGlvbiBhYm91dA0KaG93IHRoYXQgaXMgZG9u
ZS4NCg0KDQo+IHdoeSBjYW4ndCB0aGUgc2FtZSBiZSBkb25lIGZvciBORlN2ND8NCg0KSSBtZWFu
LCB5ZXMgdGhlIHN0YW5kYXJkIE5GU3Y0IHByb3RvY29sIHByb3ZpZGVzIGEgd2F5IHRvIGFjY2Vz
cw0KdGhlc2UsIGFuZCBORlNEIGNhbiBiZSBtYWRlIHRvIHN1cHBvcnQgdGhhdC4gQnV0IHdoZXJl
IHdvdWxkIGl0DQpzdG9yZSB0aGF0IGNvbnRlbnQ/DQoNCk5GU0QgY2FuIHN1cHBvcnQgd2hhdCBp
cyByZWFkaWx5IGF2YWlsYWJsZSBmcm9tIHRoZSBWRlMgQVBJLiBJZg0KYWx0ZXJuYXRlIHN0cmVh
bXMgd2VyZSB0byBiZWNvbWUgYSBwcmVtaWVyIHBhcnQgb2YgdGhlIExpbnV4DQpmaWxlIHN5c3Rl
bSBzdGFjaywgaXQgd291bGQgYmUgc3RyYWlnaHRmb3J3YXJkIGZvciBORlNEIHRvDQpzdXBwb3J0
IHRoZW0uDQoNCklPVyBmaXJzdCBORlNEIG5lZWRzIHRoZSBjb21tdW5pdGllcyByZXNwb25zaWJs
ZSBmb3IgdGhlIFZGUyBhbmQNCmZpbGUgc3lzdGVtcyB0byBpbXBsZW1lbnQgdGhlbS4gRXZlcnlv
bmUgaGFzIHRvIGFncmVlIG9uIGhvdw0KdGhlc2UgYXJlIHN0b3JlZCwgd2UgY2FuJ3QganVzdCBt
YWtlIHNvbWV0aGluZyB1cC4gT3RoZXJ3aXNlDQp0aGVyZSBpcyBubyBob3BlIGZvciBpbnRlcm9w
ZXJhdGlvbiBiZXR3ZWVuIGxvY2FsIGFwcGxpY2F0aW9ucw0KYW5kIGFwcGxpY2F0aW9ucyB0aGF0
IGFjY2VzcyB0aGVzZSB2aWEgU01CIG9yIE5GUy4NCg0KDQotLQ0KQ2h1Y2sgTGV2ZXINCg0KDQo=

