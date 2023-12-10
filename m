Return-Path: <linux-nfs+bounces-476-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8266980BC0D
	for <lists+linux-nfs@lfdr.de>; Sun, 10 Dec 2023 16:47:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D7CA1C204AB
	for <lists+linux-nfs@lfdr.de>; Sun, 10 Dec 2023 15:47:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D9E8168A7;
	Sun, 10 Dec 2023 15:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Exz10nJa";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="gtAdqwCV"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AED4CF4
	for <linux-nfs@vger.kernel.org>; Sun, 10 Dec 2023 07:47:23 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BAFYWXx008976;
	Sun, 10 Dec 2023 15:47:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=kK8l8LZZwoRaiaDUAW3+HUw6WpOjx2WTryXXuPl8y80=;
 b=Exz10nJaxrRbSw/xEXstCAyao+QLmjhyaB3ytNjsJgG1ewx4RLcXi42RXGdwUvBz61gT
 ti89jXCiuDCjY/oHngpoM7jxYD1EKoCa3W/16CwdR/omsAGUtsJsVoDgg93/k56i+Kk3
 mZElWo5nFydr5nQn+fxBmMGquqNk4zphD1YWN3f1axhnNicloZzaUj4Imfgg/jIJWMcg
 te1nYfwp72HasyKFLCRkC+EMtKsAQCQQV4x56MA/eUSIbAEFu8UqedkdZfLQMzmrCcnB
 fQZzQBRXDt1uRy5MH0wOvd1lfjn938MFWtHHQYyrdtdpTK3jJH0qovVgQDc6r8czL23B 1w== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uwawh06rp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 10 Dec 2023 15:47:22 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3BABFK7m040742;
	Sun, 10 Dec 2023 15:47:20 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2040.outbound.protection.outlook.com [104.47.51.40])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3uvep3xw3c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 10 Dec 2023 15:47:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BXi86yAI+Tonve6OQeQ4V1lyvn4RTJzCDgqpLA+nyXW6Tof10O33zNcb/t0Vcs8WGWQr7VwuIyZlz7PMwJAgua6KWOOL7U7SFx4d/fszxEXg0eFaJhd57vIUUFF0lY/wzMjEVYeQILqUEnZnhxgie/gxP4r4JI+j8K8Hex284Rz8f7VQOFTq/Ub05peC1kNeAvGaq5uQ+yUDq5xEt7AwUhc5DJX/PUcQzQjx7tbrTnpgMqWrdgJT7OjvpuWyL1P2srMyQ57z8mtcuY7pzkx0qDuACU0Ou3Vb+flpbYNy1Gqp57/IbWQ22yOI9dPhLFCZp4izA0Vpmyiik8bCdtKqrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kK8l8LZZwoRaiaDUAW3+HUw6WpOjx2WTryXXuPl8y80=;
 b=B2hgYRucwUqt54askTGoiDiug4E/QOea8CCkoViNnCwcrPdRj5j/DEdsCQl926FLokHpDd4PDDP2+IxL5Qws9lmd3Wiog/SW9zX1PxW4GQk3FtqZD72IpkooaboVvhUmP5GFU5dWbHOhVDwdYyphTNtY2oMsPOVGSoQKSetxZN5ziZIEw25VA5NZXvW8CUuSOVC92P4QgIex46Zzn09N6jjWijxc24yzetysfEFbiwFeV6vBcPJ7ns/Kq0YHP+w6H7glu6oXbNim2bnUHCWWTknblcudxi5w/91HD+3h0gdJv0Zxjc/NT9KgpVI+PQPLDtG4yJ4RNJ6iKioGjx53CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kK8l8LZZwoRaiaDUAW3+HUw6WpOjx2WTryXXuPl8y80=;
 b=gtAdqwCVUB1rDYL9da/UgVUE0YAjqY4BwhIN6xzvIkPux7YG2QgelG+6rZlnS7wLKGpizubZx2UVzMaKCZs5u2+1zOTJlXoSZ4biLyO+ijh06QG7RIo6LnJzPCkSyHnKb9u8VHA/jEviSlXANafCP7NwTyUNwNISacWtc6Keh3E=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BN0PR10MB5269.namprd10.prod.outlook.com (2603:10b6:408:129::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Sun, 10 Dec
 2023 15:47:19 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c%4]) with mapi id 15.20.7068.031; Sun, 10 Dec 2023
 15:47:18 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: ditang chen <ditang.c@gmail.com>
CC: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: nfsd:Multiple nfs clients with the same hostname cause session
 exceptions
Thread-Topic: nfsd:Multiple nfs clients with the same hostname cause session
 exceptions
Thread-Index: AQHaK3jvrsNXtDw4ck6A4vYn36lDLbCiqVEA
Date: Sun, 10 Dec 2023 15:47:18 +0000
Message-ID: <964C16DB-9573-4B37-8F8B-235714CC9202@oracle.com>
References: 
 <CAHnGgyHoyce3Fi5KgCJvHg52R8GumLphPhpzdvZKrwEXy0BnsA@mail.gmail.com>
In-Reply-To: 
 <CAHnGgyHoyce3Fi5KgCJvHg52R8GumLphPhpzdvZKrwEXy0BnsA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.200.91.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|BN0PR10MB5269:EE_
x-ms-office365-filtering-correlation-id: 9299ad51-3eaf-405a-e162-08dbf9974a64
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 vubboFgvgUhGTcxXQ7XTnWW65bv/bTlw4LrwQ0juz3HcgHFGX2taEQ3st6/KXTBmItdZwTGj0idiX5iUwOOp44+mdpS/aJ/zlaG9gHyV/U+/GxiDnakAoonzkuOug4fEmNlX7Bjq/FzHCIaj9yE/eTdxHFUAWJG/coV+tod8RhhzL537hvGdnN4bQX/7cxbqm+MVHSeSefd7jjYq9hR4+ENc0NFjwmt7GBNNGywtF2VNsP/w3AvimwWZcEFMct7SHT4gUWZjwC+J25kb8tMbc1pxCZfnIMqv6e4qOCv6fFlSnN0+ina1NUCAyB4/4zAC+7g4uxbma73KMBwKPj3K7VHbkuOVJv+PsdqF3LM6nyH0PFN7fllkDNr41z51GyPV8xez3cJ08fOro9bFVL8MV78KAu+bTqlOvJt6dqZ0urOjH2bph/Uxn6LfFMiYhpg44zt7jz+wAW5awxURPb6PQSg5FBk0cKflbl3blazYc+FQ4ihZ9isO/K1tb8l1xzzRoqNPkZdrMBLKTWZMH3/ttxFRT9q9jlm7X3XkHeHquUOZSNsCpmVcvLZ9OKemYbOtpLP8HaeC9/9Ad7ieU8kLnJQe9938KtgSSPUt/P5iOlmqkr480fFbApu2ZqtJ4SmcPU/MAi0MGOuWWUTHiQ4vRg==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(366004)(396003)(376002)(39860400002)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(66899024)(41300700001)(38100700002)(2906002)(5660300002)(316002)(4326008)(8676002)(8936002)(6916009)(76116006)(38070700009)(66946007)(64756008)(66446008)(66476007)(66556008)(2616005)(33656002)(86362001)(36756003)(91956017)(122000001)(966005)(83380400001)(6486002)(26005)(478600001)(71200400001)(6512007)(6506007)(53546011)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?dU4xVWhzaUUzSTUxWC9EcjE2d2xaZ2xCM3pJSEVHTEx5N2tZcmRIdkc1UWRl?=
 =?utf-8?B?c2xDV3JYTGNHNmVld0VSbmtncWlTTG9zTFNoM3JlVFFzdytBMlF3T1J6NGN4?=
 =?utf-8?B?SExiaVpESTdVY0VMVXlXL0d4WGJ4Q2dmeExFSVBSMHZvUnpYTVdkMC9USVBO?=
 =?utf-8?B?WkpIM2tJL0dCY0gybE1zSXd2c1B3YzFpdGs5TGxyN25VNngrVnh0cndIU3Rr?=
 =?utf-8?B?aDdqVlhoa2lLeUR4dlJ3RWtJeVF0bnVLZFpxeUZqVkVtS2xnbW9OOVJGWWc0?=
 =?utf-8?B?RERJTk8rVGhxdDlZMFhHbG53OHExaytCeXB5eUYzNkgxOWJqZ2c5K1l5UlFz?=
 =?utf-8?B?MDN4MXBiRXkraGRJZ0ltV1d0bDRSTmQ0UkE4R3JqdHQzMGlSb2h0OURVOVho?=
 =?utf-8?B?QVVSQzJlVGx0bk9JdzE2VWpXdmVoRzhsZzZVV3RWcE44eXp6dDFmSTlneUw4?=
 =?utf-8?B?bmwyRHlhWHVOVlMrYzVPNlBJVU1sREtqWmZ0cnhONjlWWUZvUC9WR0JPYktx?=
 =?utf-8?B?VEQwWEROd2Z6YldBTkJnT3hrR2ljaXdyanlMVkZtR1g4a2g3VWhqeThNeXVV?=
 =?utf-8?B?OUhBc0drdncxZ29QKzBCVXlYbVk3QXdDN21tZ3llaXhxajMycmpmTm9lMXdY?=
 =?utf-8?B?UkNkSHlQcGpQQnoySnJIQmZRcTNaWVJNQ0JkWWp0S2RQUUlnVnRCS2dWWEVz?=
 =?utf-8?B?Ryt5TTV1dEpQaVNheFFkQ3NHNWk4VWZIM20reFdZKzZoaHgxWmE4c3krdURK?=
 =?utf-8?B?WnhncGs1VEw2dms3UDY2Q2RYbS9Hd3QrS3dMUFdhNGJoeGluQ3FocGtkdkxH?=
 =?utf-8?B?YUVsZWJGTEFkMlh3NXByeEl6Y0RxQkFCeC91MEF3a21zZlJaSDJmTFFJNVA2?=
 =?utf-8?B?RVBxRnk2TGY4T25sbTlZeE5URW1kTk9BOGhIWVVCdG15WTNaMlhDdmNiUzVH?=
 =?utf-8?B?WWxjekJSVjhpYm9YSmdOOXIxaVFQOHpjQ2h0MGtuMVVwVlVrdFNZWmdqaVgz?=
 =?utf-8?B?dlEyTnd6ZjJCQ1EwQlhVOVEzdlFZM2tQLzRkY2hKOURZOEhxL3RjSkVkd2Fr?=
 =?utf-8?B?MG5xcmNDVCs0YmRkZDJWaDVuZGFFS0krc0lPNGtnVmVjeHRuR3VIWmpjaE1D?=
 =?utf-8?B?dzZUd1lRLzFsbEZBSnd4aTYzc2dMOXJvL1kwM212K0tOVkVhdnUzYlpxaWlG?=
 =?utf-8?B?aU1WVG5taDhIMHo3S3NLMnd1VmJ3NGE5b2ZFeFI4WkEvVnJLV1FzWm1OSjlB?=
 =?utf-8?B?VDIrQlFGQXVHSGhWRkgwVUk5MGJZZ3V1YUczUXpTYW9UYjI3bWxZWlpxczZY?=
 =?utf-8?B?QmVIZ0VIdnBMMVBGZU9TbUlCYXdXSCtjL1hPdTlReEQ0QkZoYnlmN3NQV0hB?=
 =?utf-8?B?QWxTbFdJV0VDSHRLRzY2UndLUkFzTkU4RmkzVEFzK1gzNm0wZ08xZE5yTDFT?=
 =?utf-8?B?aDhYa2hPR2hBeS96dGQrbnRSNGUvdWwvZXBSSWNBQ3U5MHZVSVIvV044UEV4?=
 =?utf-8?B?cGdkM1g1VVovSTlxVGdhS1NSUDY0Q25sTDFoaC8wc0RKczd5NXVzOFExanBC?=
 =?utf-8?B?SlRoV1pZd1czbmtLdTZSWVUrV01xbUxuYnpCLysyclFwUnpvTm5OazlNdThR?=
 =?utf-8?B?T0FRWlpyU2VBQUt1VzVlU0tFdjdkOThmR1NGUVJQUFlLYVZBWEJPektaMzhS?=
 =?utf-8?B?SDM2ajdhcEFKaE1EUzhKVGRRNU1PcGd2RW9XOXd6eElHdTY1d2ZrS0Y0UHBS?=
 =?utf-8?B?QVQ5dUl0RTRrTmExWjd3V2crcXNZMTFHdjVuZlZLNjkrMkZ6ZTcrazBuWUIy?=
 =?utf-8?B?YVBsdHBpbjZtMTZPelVmS1NsdTFTeHpBYm9CeXBmcWsrUHAwOHpUTHRYbGhm?=
 =?utf-8?B?bGxWUkNMbHRRZ3dGeUQxZzRRWW5yT3kydE1Ga0pJTFBzOGdBbWdFeWRZZjB6?=
 =?utf-8?B?bkVNS2MwUFIwRCtMQWgxRGtNYjQ0QzZmVkNybk1aQzdaTk56YVJNYzAwdzNj?=
 =?utf-8?B?aDk5VjRpVWoyQmM1ZDUrYldlWkl0cytuNDJGOXN4Z0RZWko5Tkp2emhRL2l3?=
 =?utf-8?B?UzVOeHVzdXFrV2Frcmd5TWhEWHJEbldYL21WbnRZVmVBYXh4Q2YrYlpHNVBG?=
 =?utf-8?B?ckVNd2JjUzltTS9Ia1JJdjhkMzZ5bHZvRThMbFJsSFF2QVhCZXJ1eGY5bXJO?=
 =?utf-8?B?QlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B9E4D73481A8DB41A9B125DC2007730A@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	JsGs9jwxZFDt0YfGLq5XLETFpko4DhZPKxFbpv3oortYo1jmwi37BpXD1QKxVQF7UsVy4jesHzV8eCQlfB+MS4YM3uQY8J2URJCeYx5ihzr9D+z0gUeHk3vjB+TCxKHs5u/nZZuE76AqYYR1LM4OvjDNRlZf+IR1CLJmc3KTipmL4WG4GoJ2fWUQvEM3c8AJZa3RnAHKiUDPSzeX+xUuII09y8hbaOpN+RTWiwIrn7ItYPkxrr8TSbz0WSpHq6N0xAHCXeAoj1OGULOjX03P9sR86EKMzdeQWUeN0EMf9d7aDHAc2QeZA5MAGN1Umac9yWWl+PL/agf3IJRnzm+QFPHMOzZAB3cFP6sx7rctwmzBAGXzTU7JyqLw/0wBtaApcJbaBbkCLQRT5ch4UPOHpDyvp1pBghaWK+PTmDrObJKAh4GgrXhC//+a+wDbO21l85SdtMrauppGI7NmCIU5HDl3nSZF+O7On5d4r3ePEsnm4WByM5BMQhkUBTcqMZI9peCBYIxT2vJE8pDjqAmmipbn9puNKTGVAy9C2Q2I60YdfVJ2McQXg1ITFXDkfxW/Q1Dkh7dLNY84hMyBMbln7AgeaTO2QpMNj7rzCgEYu2TnVrFqU4R6mtHP5sCoqR8eQwkh28k0PZ2VTjE0GZlDdo87WlUdFUIyqip0rRisCSnRLd+qa6aNJ+W6TtfjXNA8mW1fyDEfw+ElbFLkCrOCNNYwFE9DQPTYEMsPFgssW9Hca7juVs53n2AuAMNwgNlgK/147/to3GtPhGafH05SWjwMs4G+rJz5/EoI7zaVgnw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9299ad51-3eaf-405a-e162-08dbf9974a64
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2023 15:47:18.5947
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1MCznVOWw1vhZo9SH9b+S+ZuMsOtK85dL5w5KvJNN92/TfzSPWlbDmlzCow1xKyUJdY/mpYS6Hj2SsGoBUeQdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5269
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-10_09,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 spamscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=999 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312100139
X-Proofpoint-GUID: GK0b-uP6kEy2X-TV7ySeySLocx_gH39g
X-Proofpoint-ORIG-GUID: GK0b-uP6kEy2X-TV7ySeySLocx_gH39g

DQoNCj4gT24gRGVjIDEwLCAyMDIzLCBhdCA5OjU14oCvQU0sIGRpdGFuZyBjaGVuIDxkaXRhbmcu
Y0BnbWFpbC5jb20+IHdyb3RlOg0KPiANCj4gTXVsdGlwbGUgbmZzIGNsaWVudHMgd2l0aCB0aGUg
c2FtZSBob3N0bmFtZSBjYXVzZSBzZXNzaW9uIGV4Y2VwdGlvbnMsDQo+IHRoZSBuZXcgY2xpZW50
IGZpbmQgY29uZmlybWVkIG5mczRfY2xpZW50IGJ5IG5hbWUgaW4gdGhlDQo+IG5mc2Q0X2NyZWF0
ZV9zZXNzaW9uDQo+IGFuZCB0aGVuIHdpbGwgcmVsZWFzZSB0aGUgc2VfaGFzaCBsaXN077yaDQo+
IA0KPiBvbGQgPSBmaW5kX2NvbmZpcm1lZF9jbGllbnRfYnlfbmFtZSgmdW5jb25mLT5jbF9uYW1l
LCBubik7DQo+IGlmIChvbGQpIHsNCj4gICAgc3RhdHVzID0gbWFya19jbGllbnRfZXhwaXJlZF9s
b2NrZWQob2xkKTsNCj4gICAgaWYgKHN0YXR1cykgew0KPiAgICAgICAgb2xkID0gTlVMTDsNCj4g
ICAgICAgIGdvdG8gb3V0X2ZyZWVfY29ubjsNCj4gICAgfQ0KPiAgICB0cmFjZV9uZnNkX2NsaWRf
cmVwbGFjZWQoJm9sZC0+Y2xfY2xpZW50aWQpOw0KPiB9DQo+IG1vdmVfdG9fY29uZmlybWVkKHVu
Y29uZik7DQo+IA0KPiBJcyB0aGVyZSBhbnkgb3RoZXIgb3B0aW9uLCBzdWNoIGFzIElQIGluc3Rl
YWQgb2YgaG9zdCBuYW1lLCB3aGljaCBpcw0KPiB1c3VhbGx5IHVuaXF1Ze+8nw0KDQpZZXMuDQoN
ClRoZSBORlN2NCBwcm90b2NvbCBuZWVkcyBlYWNoIGNsaWVudCB0byBwcmVzZW50IGEgdW5pcXVl
IGlkZW50aWZpZXINCnRvIGEgc2VydmVyIGluIG9yZGVyIGZvciB0aGUgc2VydmVyIHRvIGNvbGxl
Y3Qgb3BlbiBhbmQgbG9jayBzdGF0ZQ0KYmVsb25naW5nIHRvIHRoYXQgY2xpZW50LiBUeXBpY2Fs
bHkgdGhlIGNsaWVudCdzIGhvc3RuYW1lIGlzIHVuaXF1ZQ0KZW5vdWdoIGZvciB0aGlzIHB1cnBv
c2UuDQoNClNvbWV0aW1lcywgdGhvdWdoLCB0aGUgY2xpZW50J3MgaG9zdG5hbWUgZG9lc24ndCBw
cm92aWRlIGEgZ2xvYmFsbHkNCnVuaXF1ZSBpZGVudGl0eS4gQ2xpZW50IGltcGxlbWVudGF0aW9u
cyB1c3VhbGx5IHByb3ZpZGUgYSBzZWNvbmRhcnkNCndheSBvZiBpZGVudGlmeWluZyB0aGVtc2Vs
dmVzLiBJIGNhbid0IGdpdmUgYW4gZXhhY3QgcmVjaXBlIGJlY2F1c2UNCmVhY2ggY2xpZW50IGlt
cGxlbWVudGF0aW9uIGhhcyBpdHMgb3duIHBlY3VsaWFyIGFkbWluaXN0cmF0aXZlDQppbnRlcmZh
Y2UgZm9yIHRoaXM7IGFuZCBzb21ldGltZXMgdGhleSBoYXZlIG1vcmUgdGhhbiBvbmUsIHRvIGRl
YWwNCndpdGggdGhpbmdzIGxpa2UgY29udGFpbmVycyAoTGludXgpIG9yIHpvbmVzIChTb2xhcmlz
KS4NCg0KTG9vayBmb3Igc29tZXRoaW5nIG9uIHlvdXIgY2xpZW50cyB0aGF0IGVuYWJsZXMgeW91
IHRvIHNldCB0aGUNCm5mczRfY2xpZW50X2lkIHRvIHNvbWV0aGluZyB1bmlxdWUuIFlvdSBjYW4g
dXNlIGEgcmFuZG9tIHN0cmluZw0Kb3IgInV1aWQgLXIiIGZvciB0aGlzIHB1cnBvc2UuIEJ1dCBl
YWNoIGNsaWVudCBpbnN0YW5jZSBuZWVkcyB0bw0KaGF2ZSBpdHMgb3duIGRpc3RpbmN0IG5mczRf
Y2xpZW50X2lkLg0KDQpIZXJlJ3MgYSBnZW5lcmFsIGRlc2NyaXB0aW9uIG9mIGhvdyB0aGlzIHdv
cmtzIG9uIExpbnV4IE5GUyBjbGllbnRzOg0KDQpodHRwczovL3d3dy5rZXJuZWwub3JnL2RvYy9o
dG1sL2xhdGVzdC9maWxlc3lzdGVtcy9uZnMvY2xpZW50LWlkZW50aWZpZXIuaHRtbA0KDQpIVEgu
DQoNCg0KPiBEZWMgIDEgMjI6NDI6MzIgZGQga2VybmVsOiBuZnNkNF9leGNoYW5nZV9pZCBycXN0
cD0wMDAwMDAwMDY2NjhiNTIwDQo+IGV4aWQ9MDAwMDAwMDBhNDRkM2I3MiBjbG5hbWUubGVuPTM1
IGNsbmFtZS5kYXRhPTAwMDAwMDAwN2IxYjU1OTINCj4gaXBfYWRkcj0xOTIuMTY4LjEyMi4xMzAg
ZmxhZ3MgMTAxLCBzcGFfaG93IDANCj4gRGVjICAxIDIyOjQyOjMyIGRkIGtlcm5lbDogbmZzZDRf
ZXhjaGFuZ2VfaWQgc2VxaWQgMCBmbGFncyAyMDAwMQ0KPiBEZWMgIDEgMjI6NDI6MzIgZGQga2Vy
bmVsOiBjaGVja19zbG90X3NlcWlkIGVudGVyLiBzZXFpZCAxIHNsb3Rfc2VxaWQgMA0KPiBEZWMg
IDEgMjI6NDI6MzIgZGQga2VybmVsOiBhbGxvY19jbGRfdXBjYWxsOiBhbGxvY2F0ZWQgeGlkIDEw
DQo+IERlYyAgMSAyMjo0MjozMiBkZCBycGMubW91bnRkWzI1NzEzXTogdjQuMiBjbGllbnQgYXR0
YWNoZWQ6DQo+IDB4ZTIxYmI4YzY2NTY5ZWVhZiBmcm9tICIxOTIuMTY4LjEyMi4xMzA6ODk0Ig0K
PiBEZWMgIDEgMjI6NDI6MzIgZGQgcnBjLm1vdW50ZFsyNTcxM106IHY0LjIgY2xpZW50IGRldGFj
aGVkOg0KPiAweGUyMWJiOGM1NjU2OWVlYWYgZnJvbSAiMTkyLjE2OC4xMjIuOTM6NzkxIg0KPiBE
ZWMgIDEgMjI6NDI6MzIgZGQga2VybmVsOiBfX2ZpbmRfaW5fc2Vzc2lvbmlkX2hhc2h0Ymw6DQo+
IDE3MDE0NDExOTk6Mzc5MzQ2NzU5MDo1OjANCj4gRGVjICAxIDIyOjQyOjMyIGRkIGtlcm5lbDog
bmZzZDRfc2VxdWVuY2U6IHNsb3RpZCAwDQo+IERlYyAgMSAyMjo0MjozMiBkZCBrZXJuZWw6IGNo
ZWNrX3Nsb3Rfc2VxaWQgZW50ZXIuIHNlcWlkIDEgc2xvdF9zZXFpZCAwDQo+IERlYyAgMSAyMjo0
MjozMiBkZCBrZXJuZWw6IG5mc2Q6IGZoX2NvbXBvc2UoZXhwIDEwMzowOC8xMjggLywgaW5vPTEy
OCkNCj4gRGVjICAxIDIyOjQyOjMyIGRkIGtlcm5lbDogLS0+IG5mc2Q0X3N0b3JlX2NhY2hlX2Vu
dHJ5IHNsb3QgMDAwMDAwMDA2ZWY2ZjQyMg0KPiBEZWMgIDEgMjI6NDI6MzIgZGQga2VybmVsOiBf
X2ZpbmRfaW5fc2Vzc2lvbmlkX2hhc2h0Ymw6DQo+IDE3MDE0NDExOTk6Mzc5MzQ2NzU5MDo1OjAN
Cj4gRGVjICAxIDIyOjQyOjMyIGRkIGtlcm5lbDogbmZzZDRfc2VxdWVuY2U6IHNsb3RpZCAwDQo+
IERlYyAgMSAyMjo0MjozMiBkZCBrZXJuZWw6IGNoZWNrX3Nsb3Rfc2VxaWQgZW50ZXIuIHNlcWlk
IDIgc2xvdF9zZXFpZCAxDQo+IERlYyAgMSAyMjo0MjozMiBkZCBrZXJuZWw6IGFsbG9jX2NsZF91
cGNhbGw6IGFsbG9jYXRlZCB4aWQgMTENCj4gRGVjICAxIDIyOjQyOjMyIGRkIGtlcm5lbDogLS0+
IG5mc2Q0X3N0b3JlX2NhY2hlX2VudHJ5IHNsb3QgMDAwMDAwMDA2ZWY2ZjQyMg0KPiBEZWMgIDEg
MjI6NDI6MzYgZGQga2VybmVsOiBfX2ZpbmRfaW5fc2Vzc2lvbmlkX2hhc2h0Ymw6DQo+IDE3MDE0
NDExOTk6Mzc5MzQ2NzU4OTo0OjANCj4gRGVjICAxIDIyOjQyOjM2IGRkIGtlcm5lbDogX19maW5k
X2luX3Nlc3Npb25pZF9oYXNodGJsOiBzZXNzaW9uIG5vdCBmb3VuZA0KPiBEZWMgIDEgMjI6NDI6
MzYgZGQga2VybmVsOiBuZnNkNF9kZXN0cm95X3Nlc3Npb246IDE3MDE0NDExOTk6Mzc5MzQ2NzU4
OTo0OjANCj4gRGVjICAxIDIyOjQyOjM2IGRkIGtlcm5lbDogX19maW5kX2luX3Nlc3Npb25pZF9o
YXNodGJsOg0KPiAxNzAxNDQxMTk5OjM3OTM0Njc1ODk6NDowDQo+IERlYyAgMSAyMjo0MjozNiBk
ZCBrZXJuZWw6IF9fZmluZF9pbl9zZXNzaW9uaWRfaGFzaHRibDogc2Vzc2lvbiBub3QgZm91bmQN
Cj4gRGVjICAxIDIyOjQyOjM2IGRkIGtlcm5lbDogbmZzZDRfZXhjaGFuZ2VfaWQgcnFzdHA9MDAw
MDAwMDA2NjY4YjUyMA0KPiBleGlkPTAwMDAwMDAwYTQ0ZDNiNzIgY2xuYW1lLmxlbj0zNSBjbG5h
bWUuZGF0YT0wMDAwMDAwMDdiMWI1NTkyDQo+IGlwX2FkZHI9MTkyLjE2OC4xMjIuOTMgZmxhZ3Mg
MTAxLCBzcGFfaG93IDANCj4gRGVjICAxIDIyOjQyOjM2IGRkIGtlcm5lbDogbmZzZDRfZXhjaGFu
Z2VfaWQgc2VxaWQgMCBmbGFncyAyMDAwMQ0KPiBEZWMgIDEgMjI6NDI6MzYgZGQga2VybmVsOiBj
aGVja19zbG90X3NlcWlkIGVudGVyLiBzZXFpZCAxIHNsb3Rfc2VxaWQgMA0KPiBEZWMgIDEgMjI6
NDI6MzYgZGQga2VybmVsOiBhbGxvY19jbGRfdXBjYWxsOiBhbGxvY2F0ZWQgeGlkIDEyDQo+IERl
YyAgMSAyMjo0MjozNiBkZCBycGMubW91bnRkWzI1NzEzXTogdjQuMiBjbGllbnQgYXR0YWNoZWQ6
DQo+IDB4ZTIxYmI4Yzc2NTY5ZWVhZiBmcm9tICIxOTIuMTY4LjEyMi45Mzo3OTEiDQo+IERlYyAg
MSAyMjo0MjozNiBkZCBycGMubW91bnRkWzI1NzEzXTogdjQuMiBjbGllbnQgZGV0YWNoZWQ6DQo+
IDB4ZTIxYmI4YzY2NTY5ZWVhZiBmcm9tICIxOTIuMTY4LjEyMi4xMzA6ODk0Ig0KPiBEZWMgIDEg
MjI6NDI6MzYgZGQga2VybmVsOiBfX2ZpbmRfaW5fc2Vzc2lvbmlkX2hhc2h0Ymw6DQo+IDE3MDE0
NDExOTk6Mzc5MzQ2NzU5MTo2OjANCj4gRGVjICAxIDIyOjQyOjM2IGRkIGtlcm5lbDogbmZzZDRf
c2VxdWVuY2U6IHNsb3RpZCAwDQo+IERlYyAgMSAyMjo0MjozNiBkZCBrZXJuZWw6IGNoZWNrX3Ns
b3Rfc2VxaWQgZW50ZXIuIHNlcWlkIDEgc2xvdF9zZXFpZCAwDQo+IERlYyAgMSAyMjo0MjozNiBk
ZCBrZXJuZWw6IG5mc2Q6IGZoX2NvbXBvc2UoZXhwIDEwMzowOC8xMjggLywgaW5vPTEyOCkNCj4g
RGVjICAxIDIyOjQyOjM2IGRkIGtlcm5lbDogLS0+IG5mc2Q0X3N0b3JlX2NhY2hlX2VudHJ5IHNs
b3QgMDAwMDAwMDBlMWY2NmMyNA0KPiBEZWMgIDEgMjI6NDI6MzYgZGQga2VybmVsOiBfX2ZpbmRf
aW5fc2Vzc2lvbmlkX2hhc2h0Ymw6DQo+IDE3MDE0NDExOTk6Mzc5MzQ2NzU5MTo2OjANCj4gRGVj
ICAxIDIyOjQyOjM2IGRkIGtlcm5lbDogbmZzZDRfc2VxdWVuY2U6IHNsb3RpZCAwDQo+IERlYyAg
MSAyMjo0MjozNiBkZCBrZXJuZWw6IGNoZWNrX3Nsb3Rfc2VxaWQgZW50ZXIuIHNlcWlkIDIgc2xv
dF9zZXFpZCAxDQo+IERlYyAgMSAyMjo0MjozNiBkZCBrZXJuZWw6IGFsbG9jX2NsZF91cGNhbGw6
IGFsbG9jYXRlZCB4aWQgMTMNCj4gRGVjICAxIDIyOjQyOjM2IGRkIGtlcm5lbDogLS0+IG5mc2Q0
X3N0b3JlX2NhY2hlX2VudHJ5IHNsb3QgMDAwMDAwMDBlMWY2NmMyNA0KPiBEZWMgIDEgMjI6NDM6
MzMgZGQga2VybmVsOiBfX2ZpbmRfaW5fc2Vzc2lvbmlkX2hhc2h0Ymw6DQo+IDE3MDE0NDExOTk6
Mzc5MzQ2NzU5MDo1OjANCj4gRGVjICAxIDIyOjQzOjMzIGRkIGtlcm5lbDogX19maW5kX2luX3Nl
c3Npb25pZF9oYXNodGJsOiBzZXNzaW9uIG5vdCBmb3VuZA0KPiBEZWMgIDEgMjI6NDM6MzMgZGQg
a2VybmVsOiBuZnNkNF9kZXN0cm95X3Nlc3Npb246IDE3MDE0NDExOTk6Mzc5MzQ2NzU5MDo1OjAN
Cj4gRGVjICAxIDIyOjQzOjMzIGRkIGtlcm5lbDogX19maW5kX2luX3Nlc3Npb25pZF9oYXNodGJs
Og0KPiAxNzAxNDQxMTk5OjM3OTM0Njc1OTA6NTowDQo+IERlYyAgMSAyMjo0MzozMyBkZCBrZXJu
ZWw6IF9fZmluZF9pbl9zZXNzaW9uaWRfaGFzaHRibDogc2Vzc2lvbiBub3QgZm91bmQNCg0KLS0N
CkNodWNrIExldmVyDQoNCg0K

