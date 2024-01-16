Return-Path: <linux-nfs+bounces-1126-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8451782E7BA
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Jan 2024 02:55:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2DF41F23A5D
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Jan 2024 01:54:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D60D21097B;
	Tue, 16 Jan 2024 01:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GF0PsSpG";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="NU+epRWB"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 830B6F507
	for <linux-nfs@vger.kernel.org>; Tue, 16 Jan 2024 01:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40FNdLSr017139;
	Tue, 16 Jan 2024 01:43:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=lxr0oCiwu00FsjoXBxJUydQezR6p478Igv+m29BfSpE=;
 b=GF0PsSpG5WSk/0vvftaV1dsNil5Q44EsPjIkUlD9/A8zkB6XbFYpjCpXh4qL4zGLt8p9
 1gX3rcpE/3U++OHkyatstcfwuHdnD9cwwIlU6tAX0gOlFEE5byQrppt2gMtAWvL6NHCt
 1U/BAZVgQPSr+yBkbsEHGQqlCJu+ailrSI+8tCNyqXore2qjiAxGiWApE4+TNXYlLdy4
 gqGrdhZ7yHJFifLPYIqS01n90gQY/Ap8nqj8N8tnMcsUCy5yh2t/QRpGHAABFrEjgK9G
 TQIdbmmbNJ2y+vIFJqp06cOHbsbo7oZP+gzArwYFr5THI1xRTtpqSm5aZxjDgcGPdGTJ 6A== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vkqcdu5w8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Jan 2024 01:43:21 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40FNohot004478;
	Tue, 16 Jan 2024 01:43:21 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3vkgycyr3u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Jan 2024 01:43:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YYdmfkqwjEcd8lcYzy8DzOsVTRRDb/Y7SjfYjghp8ZC0oma//VxNnLWtmDQogLhfI0Y7gb2aH3t3EB4mMGxYfcS0b37iz/2vrYkArlLlDclcYDlnJtUVgvUfwQXcll5h7fTLWFy9yNv9NHbdlYr7toNnBtHBXbMJDqqfikXvvNE91wsoH4sAxcdrYQgwBpGVtBbkAOrYmFnwmAbIyzvXw7Lz6Zca+5il944tp7DpcAD5AYvQWHbpr0muBmFUmhnK8UqPmOu+w4bzjzYfMRLAMHfHj2+3moOMIQ/+gZDmGJxk7EdIGfmBHK4c7EwEM682Ae+OCdb/FbfIo/4KewcNGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lxr0oCiwu00FsjoXBxJUydQezR6p478Igv+m29BfSpE=;
 b=PvSbmhLoIVIY2SuzeAA6SCUkVs92p/10pqlBFQWUhq/174AL2Puv7TWJs75PbReBLXD8QM1+lK9zu3nO1sGD6EnWnNnyPPJhWboDvjJBUiNKKy+YHHNnjx0JnfjRmcOFBp3isr1JceKN6uh/Hrshy5YVZqaQZVBDBmEX/qyPlCelFjBruCrzCqcsq5r7hBhsqNc5ST8/0ru/BwgfiBuAspe1Ou3LnLLHOrNGHBku+tjZrPc7v0zDc7utcS7zkQSRTNdvA/w6tBTqRYRT3dM4Sc1Tnq0L5yFaK3wcR4omIlLIiSlvacx5Lk64PX2WLd8OSe2j3vJMY58/p3XdwXOV5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lxr0oCiwu00FsjoXBxJUydQezR6p478Igv+m29BfSpE=;
 b=NU+epRWBlLMzKBY+AaseF0VtbyBpxoYxdYDM3IzQEF7bQnjmTSY7595cBehE3S2CPithKh65aARKpkcYWaf9eRg98KrYCbk1tioNUICuXRq938sIbTFbJ4yUDZs/vTKul+9zuo1OTjCvMuQUXvv4i8337aRy2o+UJKA2CWC4eo8=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH2PR10MB4294.namprd10.prod.outlook.com (2603:10b6:610:a7::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.26; Tue, 16 Jan
 2024 01:43:19 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::7602:61fe:ec7f:2d6f]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::7602:61fe:ec7f:2d6f%5]) with mapi id 15.20.7181.026; Tue, 16 Jan 2024
 01:43:19 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Dan Shelton <dan.f.shelton@gmail.com>
CC: Chen Hanxiao <chenhx.fnst@fujitsu.com>,
        Trond Myklebust
	<trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>, Jeff
 Layton <jlayton@kernel.org>,
        Linux NFS Mailing List
	<linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] nfsv4: Add support for the birth time attribute
Thread-Topic: [PATCH] nfsv4: Add support for the birth time attribute
Thread-Index: AQHaR31Cz2V9CqEb6UGW6ZcWCZJOpLDboD0AgAALfgA=
Date: Tue, 16 Jan 2024 01:43:18 +0000
Message-ID: <0CDB9C6D-5BC7-4E99-8B08-825424D0DD4F@oracle.com>
References: <20240115063605.2064-1-chenhx.fnst@fujitsu.com>
 <CAAvCNcDxZF-ftqb1dRnjUW-q-1m2kyqN-MAGNXUd+i1r_b_vSQ@mail.gmail.com>
In-Reply-To: 
 <CAAvCNcDxZF-ftqb1dRnjUW-q-1m2kyqN-MAGNXUd+i1r_b_vSQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.300.61.1.2)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|CH2PR10MB4294:EE_
x-ms-office365-filtering-correlation-id: b309605a-9dfb-40f3-aaff-08dc16348413
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 ZVXG5Z7ix9QiQ4iTLsMaxHC+xbOb/av12UzuqSNOBMDNEvl0UDByy+d6mLm7X45iVRZxNvERJmJLjbAf/zIn19XtbCaWmkLEZOYRxJtb5oFN/YeBqHvVJISp/9r0Ocptl3pm5ZafyPjeIVuHdYqe43HHMNDVECxhhXO44x9IGuD5CBvyqGASG0KzUBbsU6C6qApOI8ro4TH2qZCfAIZKS2CIKAkAEsxY+43ZThQvijVAYyqOVok03WSM2+My3l4QdEJYlEPyUNJa5HXk4F+vCXdzyzQb4IubxIf05oPl2ClvVLBO0nxWQ8sxk1XdjaaIaXGrgR9lkmPOLZHXQxihq6MxubFQafsEaUjwXAPnIxGCaV8kdueEkrCU0Mo2AolLuCttHWvR//YT2omERIQ+8BM94OoLXd80McYW7B0bFZbwwDET+4qAUHuSPHacMR37SlAnhS0nfGJ1yh+Qd6jDCbgtFHXdtCLEP+WLkSCvG5pYhZ6yEjFgsYeV5iBaWioh2td5x8bqpSzUXZirWZtFRB+himyGqy2puWHuz1pNA97fI8Mc8LPrXw2ua+KnhcUKMFeoxQJYJh0Qw9XyPvSV9uYJxATLYGDIYRY59luKMWlS2Jub28cyhYs/inP/4IImlMjZTA0TV0mGDjecSm1VhQ==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(39860400002)(366004)(396003)(346002)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(41300700001)(122000001)(38100700002)(83380400001)(38070700009)(36756003)(33656002)(86362001)(76116006)(91956017)(54906003)(316002)(64756008)(66446008)(66476007)(66556008)(66946007)(6916009)(4744005)(2906002)(4326008)(8676002)(8936002)(5660300002)(71200400001)(2616005)(26005)(6486002)(478600001)(53546011)(6506007)(6512007)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?eFVWSFQ2Y3p1em04WnJ5aGtQanVSUlRmNXNRN2VGa21PVG1yb1FNbUZDMWZF?=
 =?utf-8?B?cFJOei9wOXZ4ZmViTEpYVkw4N0ZNdVk4UU1HVjZLQjRHaG1EZG9ETDNsOVZK?=
 =?utf-8?B?VXhlMDVjTXdkSHhCZnFKeW01WTNFZmZnWmtoZE9XbzlzdmJKTXYyL2JjdGh1?=
 =?utf-8?B?L0V4OVMyVXJWZDZWYURpVndoaXpZckozaWpjYVVEdTZHRU1GYW4zZ3FFSHhr?=
 =?utf-8?B?ZWJYR1IxMUp5NkdIdjkzZU4rWVZScVpaalVuWHNYcGJNTzd5VzRnbElMSkd6?=
 =?utf-8?B?eUJQUURXYXVrVzkrMmltcTJ6SnEvdlJuR3N2K1l2VHl0TGVhMHZHaGxNS3Nl?=
 =?utf-8?B?TzB3WlJxWU5wcUU5b001aHZreEVSVERBYzMrL2Q4cmMvMUF2bUNiY0M0NjJO?=
 =?utf-8?B?S1JFUXpzQ3FKK0hmQXpFWjdjWHhsdkpFWnZORVJnbmZNemtwYk1FYlR3UTVV?=
 =?utf-8?B?aWRTWUpMcVZvU3FubUlQbFQzbzg2K0dyMmxpWU1UT3ZDVzRGM0JKVHlRTnlI?=
 =?utf-8?B?SjlDNjhxYjVsbkpmNEhUNEgzV2tkalJ2VGg1dXlXODkxK2EzUll0K1BjMXJ3?=
 =?utf-8?B?TTdoVnZJN21TY0RuL05saFFCNU9GSkdWVUZHbTRYQVpJWkVpZk9pNlZNeldK?=
 =?utf-8?B?bDFUS0ltMW5uT0xIMk9aKy9WNElrM3VVS2wwLzYyL0hEVGlwSW1aeGZwdi85?=
 =?utf-8?B?c1VXakRWcW9QT3YrSmNtUyswS0oxYXErZlo4d2hYM0lreElIb2JrNGduTkFi?=
 =?utf-8?B?SldJcC92dnRSS09Ec1B6VmN0bDlHNksvUjFsSHI2OHRwTm1kOFFKQ2Z0dzNm?=
 =?utf-8?B?dy9ja2d5MkVUdk9FUE4zb0JrL2I2aVVrZnpQVzhONjkyUEZXUjJDUmNuekdY?=
 =?utf-8?B?ZDlVQTgzVkFWeVFMcnd0V0R1TVNXd3l4d3Jsd3NnemNNMmR2M1lWZE9ibGM5?=
 =?utf-8?B?eG55TDl6aGpLQVIwZm9PM3pQdnhOcGc3b2dzckY5bUtIVlczeGhtYXI3NmVV?=
 =?utf-8?B?NUMzdE5XYll5RjI5UjVJN3ljWDNkYXFaYWVZVm5OT3V3ZEVlU00xQkdSTEE0?=
 =?utf-8?B?U1UwVGxYV1BnbHVzRGNhSHMwSVpWd2dxMjdUQVYrdDVWL1Y1UU5sZWRZNlZB?=
 =?utf-8?B?WEZTeEVCNDBaek1JWmk3RDRQemc5TEtkQlJNSDN4M0hkOTBET3NVS1JRMWdu?=
 =?utf-8?B?Q0UyMjByL2JUbUxoOWRpL2JPSTZiR3dzU3orTEFVV0NsQllPdTlUWVdsdlVl?=
 =?utf-8?B?dWRMM21tSUcrWlg3Wk5EVXRYUzJiRGx5R2RFcHpvbWpjTUJhSm1FaTBaVkpj?=
 =?utf-8?B?dnF4UlRuNXRoaTBQWTBhVGF6dSswUVd2NWExb2RWVlNpazI0NjlZTDQ3dlRW?=
 =?utf-8?B?emt2ZWcrajlJYVk4eXQ1M0xRcjdJajJjZHlPQlpvMUVnY1ZieGxKWDZsM012?=
 =?utf-8?B?aUU1SC9KYitZcVlJNFFtTDVZMmpPZFRtbzhHTldoclgvaVpRb0lIVVo0T01N?=
 =?utf-8?B?QmF5bGIxUTBOejdVMXpoeUFLcjEySmtxKzhucnB2WDR4VVBPZzIvVWZpTFZO?=
 =?utf-8?B?ckpiQWgzc3FrVzhReFk2OG9vYlRYYXd6dEZlSCtYRmFtdENRUUV4Zi91K05U?=
 =?utf-8?B?ckpOS0h6MHVudVZYVTNpV0J6aCtpcjl6MEx3ZWVWTXVDRGRBb3Uyc1JxcHBD?=
 =?utf-8?B?UStxenY4ZWliaENzYjRjN1oyM1dhbWE3S1dVakRkM2VmRUFrWGd4SUxhQ1FW?=
 =?utf-8?B?Z05GVE00VFFDN3dVdlFBWklDSmZFeTZZSGNFeDc2c1hRajd5Ry9XZ05Jamoz?=
 =?utf-8?B?aXpnck9HUWgwalRnUWZlSHN3SE44dHVTcmFuaDhwTktKQXNBSjl5NUVpMTdv?=
 =?utf-8?B?Z0ZwRVFBWng3eWl1VVBJaUNiNU02WXNLeFJnSWhhL09HWU5LNnMzNy93WkVk?=
 =?utf-8?B?Z1h1RkdOdzh5aTU0d1h0UTVDalZvSzh3Tk9QeW9BWTBjS1ZJeFBKL05VWmht?=
 =?utf-8?B?UXIxdjJtYXRtcTdrVUdTeTJLOVZYekx2MURnOE9JOWVELzZod1RtdzNSTEVo?=
 =?utf-8?B?S3JmdTdQR1k4N29wUEpMWWhhRlJqUzExSE9vTGRPckozbzJxb0VXNEtYZmlO?=
 =?utf-8?B?ajh3ZGtRdTlScHU2MCtZcFVsdkRGQ3lUSFRjZXJrdlR4bWZ6NDB3aWpQS3Nh?=
 =?utf-8?B?dEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <02F77BEE2CF3384EB54901B59DA4E4C4@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	zI+Tjgg70N/fHNkk0RaT90KzG9orFVJFX0jsQPuN8xKjU/sQttJHsisQaHzsaeBS/Ez25IuAmxqFsJCAmZjIoLR8EUvXSgt4VIg6pONvxH2QLtUIPeY+aVthOBzbil/Ftf5JngSlpPCVRHFHgm2GyLSaWjL5b3Qrl5+zpltdbl9B+mzeVDed8kNj3Pl0HEzjVDRk0Vf6KlCSuJ3X7QQQ3aMMQtiez27muV0Oh8OxBXxs6Ucf0kSOIHplw7QTbm/xNZRNmFB13EpU65qHlmduK9/rE80/uFeP2LrYqf8CLg6scjeodw/AOUBIsMLfFN50tY1Ll5xcdaioqkUIllnBDrD0gYjJGouBLTE8zEVIva6rKwZSVowJIn6zqN/v6P+GIaVjhuGw/WF4LidNkrqs0LLcg9jb6cOmyyn6xFYFykJt7Tr45A0pycPdvx4YjNLmCyJDIwpVUfN4RYVM031cR3k+Qvgkr8u6acx279JftP+uPejIBNay2qeqpUWlocl/J30wfZkD03DYeEMKElyOKEUGzSkBT5E0YcA4J+GfTnULgN1xFr9Ldyj+6IkQURppGMVfxs9ovXXPTVxYrWBYkVHGQi/EypcOtmagnUBfmJ8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b309605a-9dfb-40f3-aaff-08dc16348413
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2024 01:43:18.9126
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pTCLW8N7RII/HvfgrK0FGlf2S0nuuoaw6Klo3XvBY+X8fLi25s+PNnuffh+M1bpix0gnX1EMVl3RwWQTATlc2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4294
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-15_17,2024-01-15_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 phishscore=0
 suspectscore=0 malwarescore=0 spamscore=0 mlxlogscore=950 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401160012
X-Proofpoint-GUID: 0HN3JC8s6VhdQWPmKIU_dFCaUIyIxd0T
X-Proofpoint-ORIG-GUID: 0HN3JC8s6VhdQWPmKIU_dFCaUIyIxd0T

DQoNCj4gT24gSmFuIDE1LCAyMDI0LCBhdCA4OjAy4oCvUE0sIERhbiBTaGVsdG9uIDxkYW4uZi5z
aGVsdG9uQGdtYWlsLmNvbT4gd3JvdGU6DQo+IA0KPiBPbiBNb24sIDE1IEphbiAyMDI0IGF0IDA3
OjM3LCBDaGVuIEhhbnhpYW8gPGNoZW5oeC5mbnN0QGZ1aml0c3UuY29tPiB3cm90ZToNCj4+IA0K
Pj4gVGhpcyBwYXRjaCBlbmFibGUgbmZzIHRvIHJlcG9ydCBidGltZSBpbiBuZnNfZ2V0YXR0ci4N
Cj4+IElmIHVuZGVybHlpbmcgZmlsZXN5c3RlbSBzdXBwb3J0cyAiYnRpbWUiIHRpbWVzdGFtcCwN
Cj4+IHN0YXR4IHdpbGwgcmVwb3J0IGJ0aW1lIGZvciBTVEFUWF9CVElNRS4NCj4+IA0KPj4gU2ln
bmVkLW9mZi1ieTogQ2hlbiBIYW54aWFvIDxjaGVuaHguZm5zdEBmdWppdHN1LmNvbT4NCj4+IC0t
LQ0KPj4gdjE6DQo+PiAgICBEb24ndCByZXZhbGlkYXRlIGJ0aW1lIGF0dHJpYnV0ZQ0KPj4gDQo+
PiBSRkMgdjI6DQo+PiAgICBwcm9wZXJseSBzZXQgY2FjaGUgdmFsaWRpdHkNCj4+IA0KPj4gZnMv
bmZzL2lub2RlLmMgICAgICAgICAgfCAyMyArKysrKysrKysrKysrKysrKysrKy0tLQ0KPj4gZnMv
bmZzL25mczRwcm9jLmMgICAgICAgfCAgMyArKysNCj4+IGZzL25mcy9uZnM0eGRyLmMgICAgICAg
IHwgMjMgKysrKysrKysrKysrKysrKysrKysrKysNCj4+IGluY2x1ZGUvbGludXgvbmZzX2ZzLmgg
IHwgIDIgKysNCj4+IGluY2x1ZGUvbGludXgvbmZzX3hkci5oIHwgIDUgKysrKy0NCj4+IDUgZmls
ZXMgY2hhbmdlZCwgNTIgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkjDQo+IA0KPiBIZWxs
bw0KPiANCj4gV2hlcmUgaXMgdGhlIHBhdGNoIHdoaWNoIGFkZHMgc3VwcG9ydCBmb3IgYnRpbWUg
dG8gbmZzZD8NCg0KU3VwcG9ydCBmb3IgdGhlIGJpcnRoIHRpbWUgYXR0cmlidXRlIHdhcyBhZGRl
ZCB0byBORlNEIHR3byB5ZWFycw0KYWdvIGJ5IGNvbW1pdCBlMzc3YTNlNjk4ZmIgKCJuZnNkOiBB
ZGQgc3VwcG9ydCBmb3IgdGhlIGJpcnRoDQp0aW1lIGF0dHJpYnV0ZSIpLg0KDQoNCi0tDQpDaHVj
ayBMZXZlcg0KDQoNCg==

