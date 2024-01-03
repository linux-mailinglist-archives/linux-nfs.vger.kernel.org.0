Return-Path: <linux-nfs+bounces-906-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EC8F3823740
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Jan 2024 22:46:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C7571F25B10
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Jan 2024 21:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB96B1DA24;
	Wed,  3 Jan 2024 21:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZPy9F4zR";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="lbo230HA"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF5211DA23
	for <linux-nfs@vger.kernel.org>; Wed,  3 Jan 2024 21:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 403JXUf7007184;
	Wed, 3 Jan 2024 21:46:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=qRcDsBDm0FdTZ8eT9qZMTGXw4hciRy/2LAjMu4j/kOg=;
 b=ZPy9F4zRY09AKD2mj5KlRH0fJErqSJh/8P+nPkseOH4tpYsZO8/AgBy/AGzVU5gPjwZ7
 1UlgzmKiCu8sawarPWW/tdDz93p47TDKoDfdJde/JxOsUYCnqb/nZ72Y7egKPNrf/kfL
 s6u1xR6qhRaB5/3AE2m2RcMRw3tQDfr9oLYlOk8IvxKrUDH9ShzGQ4FzvXRhQn31HGz0
 LVMybY3y4LT/Nypb+AN8L+fnNYa4EQ50JMA9i+aC0pPKSPiz+UW5UsIxWREJYXQiYzJy
 5OnsB4VBT8GmT4TIeASbAY7nZQOhTVTHV/jTnnyva94UQmB8FzPrmeykPt7M5lR7X+ml DA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vab3awwpf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 03 Jan 2024 21:46:12 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 403LYABO021630;
	Wed, 3 Jan 2024 21:46:11 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3vdfm2gvrr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 03 Jan 2024 21:46:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NGvcHhmZpSHOyfEmFcXvKFcrTcW43XRboaeKxoUoIpIHDFmNYJeo6GV25ednECZUDho90+8PsA4fAD137E2L2LUNGpMBVH5ma+I0P/RS42RBgoyLuLzy/nfTSIkzavuAwmV3ufhy7n+G8KijASbdn0mZu4keJxH1ywGsjWzhWKI/XE2od5olkBBObZW/jaZNpmeX+2rQicuM62m8k2F+oGow6PuoQMgdauApxgJ/ggSJFKv8FEK/c3lcE1Bta1k+gmwmkwmytxWHHpkLQhJXjixtuFCoLOzRMJ+65R+gv5u1zuk2nzn9ORy1EJROuCGGD3I7yOkckjZ6hJ/clP5k0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qRcDsBDm0FdTZ8eT9qZMTGXw4hciRy/2LAjMu4j/kOg=;
 b=CZT9aaa9O/Oq9OTpfVKgf3ObxrYQ9L4xVTjV2q6h8HV2qN0lmflBbN8sfjfbGaCu/l6SDJfuhbvxpDWVpbAO0e4ZgIoIEtMQ2gx85FZjY2pNrc4N6pds1zJsuJwI20ArobeX981cEhXEHFaCu4RJV0dn9EYVryeY3lzyo1zFym9X41fNWpiHGl+BvrOFO1daRfP1Sg8Ek91sA56T5DManiFIZLAuloS4jVDIg12CaKNyzC41OlJlYKPE8wJJ3KM4WDQU626LDieniL0WgohQ7QJ/dQGWEQxOLjB1+QEglv/I6Z9y9td0jp3sgXuJH0w5ocucpsI8t9i3Gtr4FML7cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qRcDsBDm0FdTZ8eT9qZMTGXw4hciRy/2LAjMu4j/kOg=;
 b=lbo230HA8C3Yo+meovy3A01lvkadcKkDRKDHOSbEix3MI7uRWEHl97C+mt4Ff2svC3Wvz1PlIVRysi4+BQjNW+u+wgSK2NXXP8JZKxHuXXS2uzl/C9/2aLLa2FDuwZojEO/l6RlYRSt4gByXEUCSBN6nOumE/5RqdtADvzae0U0=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SJ0PR10MB4606.namprd10.prod.outlook.com (2603:10b6:a03:2da::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Wed, 3 Jan
 2024 21:46:08 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c%4]) with mapi id 15.20.7159.013; Wed, 3 Jan 2024
 21:46:08 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Benjamin Coddington <bcodding@redhat.com>
CC: Jeff Layton <jlayton@kernel.org>,
        Linux NFS Mailing List
	<linux-nfs@vger.kernel.org>
Subject: Re: hangs during fstests testing with TLS
Thread-Topic: hangs during fstests testing with TLS
Thread-Index: AQHaPm8s2o2kQKEy6EOaZCqQ1j2yibDIbaUAgAAHFYCAABHeAIAAGQIA
Date: Wed, 3 Jan 2024 21:46:08 +0000
Message-ID: <DC58D77B-FC07-4B96-88A8-67F9ECDFD0CE@oracle.com>
References: <117352d5dc94d8f31bc6770e4bbb93a357982a93.camel@kernel.org>
 <ABBA5E37-2E13-4603-A79C-F9B9B8488AE3@redhat.com>
 <D1091C94-9F23-47E9-A9CF-31CCEFE5EF8A@oracle.com>
 <AB421B16-F1FD-414C-A9BE-652D868F03A9@redhat.com>
In-Reply-To: <AB421B16-F1FD-414C-A9BE-652D868F03A9@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.200.91.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|SJ0PR10MB4606:EE_
x-ms-office365-filtering-correlation-id: 39866e68-eb86-4d4d-17f6-08dc0ca56532
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 ulDFvOA6bmlZ3n55Z/RzdbFh2Z9UKBIblgmNfPGJ1LNp0p9jKtawI30q6JfVsnqF9L4gOw63j8ezGfKoa9P7BSADUtgRuJMREtg0T7g+M3lfLRDfKgh977JBoKD5R+zhoYXiL2ust5rHWBGk0WKPuxLh2U6Q7Qe+sjS/kWNie9hUok+fD0lEAaMjO2oEBr6pwMAGaits2fvyLWlpKOR6LLOiQ1/GQEm2jl/wBIq7cc0oCl59sAhtdRLLfqgScp0Z+jpEJRLTj/7yimyHVNsZNa3XRhK8qXvwZfNZo7Sei/gfq3NJv4NWeCghH/xJJV3s4wdsnGvfTQ5ejBXar+LYn2aWFTVrlDmsAbSvAZC3f4cIvhWemATJ0OZffs3HKbcIVvYaBLj58aTaPJR3N6dTr1i8xvBzK5xzSNc9eoB/cPmGBrevG3gquk2NEtQnzmE9hdOnOZTO4XfPXN862Z7//3TKUulN8dfQQsZRZEHDACB8da4El4cJw5cvwb+QPHj8prQ1xLpoUrSg1sNrWsf5nOiazyrZFkZG8EW68ICK5eFSFxkKQCF3PCiiFWl38pIRez5Fs1D+5GPtnXCm9UD0VR6oalBvETWKv+LkQawFEmUg8Enb3cKEW/TYxUHZiajL
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(376002)(346002)(136003)(396003)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(26005)(2616005)(71200400001)(122000001)(83380400001)(38100700002)(66946007)(91956017)(76116006)(86362001)(64756008)(66476007)(54906003)(66446008)(478600001)(66556008)(36756003)(6916009)(316002)(966005)(6486002)(5660300002)(2906002)(4326008)(8676002)(33656002)(8936002)(38070700009)(6512007)(6506007)(53546011)(41300700001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?MG5IaXIwbVNRR1dsRGIyR08zUjVhYUo1M2YvQVJzQ25IRjF5Wm9FZklucCtq?=
 =?utf-8?B?RWtET0VKS3dLM21wR3FCNWh2ZW5Tay9zLzBVd0dBaURhQXhEdzRvTm40TTB3?=
 =?utf-8?B?a2xuWkhJYmNtL2NGN2tHYXdjT3VFamFObVE5akJFK1QySkk3a1V6ZUkvN3BZ?=
 =?utf-8?B?REFRSS91QXBsMm1kSXg0Vnl6Tjdrb0ZJV2hPZStFc2hKNjl5dkI4NG1UdlVN?=
 =?utf-8?B?NjRockFaMGUvV1dhK2lkZDdydDI2Y1I1em5sVHpGUk9qa1RyeFVqSzBBRkhR?=
 =?utf-8?B?ZDJKcmxZUzJCUW1vcnlNT01tS1Rmc0lGYW5UQjlGWUs0RS9PUWFLa2s2Wm5t?=
 =?utf-8?B?T0d6NDFtU29QbmtZbWIwbjdaSDEvMytIT2xqL3I5NkVyaEd2SjZveTRoVFpE?=
 =?utf-8?B?Y2xoWGxRTnU4dzNCNE9SNGJ0blBRWXcxdmlEQno3aUpobmxEMitYME5INjVI?=
 =?utf-8?B?eU5hU04zZ1llWVVKMDFsdXU3angyK2cydnJ0T2tRSUpLSjJVSm4yN3N2bEcr?=
 =?utf-8?B?N3N0TEsvcUZMMlJKZUFCTlpTOHBJZ3FiVmRBY0hsOFdSbzAyL015NzRTRlI3?=
 =?utf-8?B?ZmRqOTl4Sk91bU5mVHRwa0RVa055MEtoeWlQYXMwaU91VXJtSzA4N0xtVCti?=
 =?utf-8?B?QVdXVzIvRkdlaDZDK1ZFL3ViSFZyMy8zS3ZvbjBHY0xhV3FvUnlYN3NHcE5I?=
 =?utf-8?B?TktZTG5yWUcwUXpQZkE1djFqYmkza0lMU2RoUmhNT09meDdqdjdQY1MxOVRQ?=
 =?utf-8?B?U1R6dC9sb2RuZ3dvakNvamNCNXI4WFNmSVIzeXk3OVNPUlRBU1hTT1hGR1Nm?=
 =?utf-8?B?Z1lwQWhMZ2ladDdzb3BaMVMvelV6Q3ZRMmNpc2dUeVREd2NoS3NLREZxN0dN?=
 =?utf-8?B?R1JiY3pGY2h0TjR0VW1wVUVvUEZRN24zbnZHenJWdlYvNGhCMzgrbkd3QnND?=
 =?utf-8?B?OFU4T1JmYVp3YktIenl0d0FPSlR4R1YwRmI1QWhDQ1I1bmZUSjhDTDh4WE9R?=
 =?utf-8?B?QmJxeDJWVDZiVDg0ZG0zK3IvVWRUZU44UHprT3l1UGxEZ2xSWmllZ2ZnWGI4?=
 =?utf-8?B?WkViTVZJNzI1WkVqL3FGN1BZam45MXEyNWJjdVJZM0M1SFArdEdvTFI3NjND?=
 =?utf-8?B?YUZvRWRER3gxaGtWZHgxOGU0cE5JK1RwZ2pkaDZaQW9uRDJsN0o4b1RqejY4?=
 =?utf-8?B?S0gzbnBObUlwWFJuMXJHSVlqdEVvMVVkTTg0endkUWFWcHBmVGV4dDJWaUl4?=
 =?utf-8?B?M1BpSWM4YkpqRzZ0M1BsMS90WHZZRG9PWlRyMktpMjJrWXNwOUVOWGE0clVu?=
 =?utf-8?B?bHFBcFVOWm1RekI0OFpTeTJESG9xcHdMRHE1QzIxTlBSY2N4Zm94SzNxRXdK?=
 =?utf-8?B?NW5tWDZDR3BISENuK2hwVm5uS3RNL0o2M1hDd1VEWXA1bWRySlRMNmNrTGpl?=
 =?utf-8?B?K2dBam9icHVLcHhlMWtWekYrQnRacFNKUnVNcnRtMXVmTnJ1cmtRaGtrdnhQ?=
 =?utf-8?B?S3djZlJjNFdtZ200WG1MeENaZkpZMjJCamd6bTdXWTdPRzB2M3ZGRUJyWWhk?=
 =?utf-8?B?WDZ0b21KWkp4L3ZZbnVCLzdDRTJ2YzRHa0pBbVQ0UG1ja0JTZjBxRU5pKzVY?=
 =?utf-8?B?YjM2bUkrOTNrWHU4SUErcmFaY0E1TjJ2QTgwaDdreGN1YmtidFFzK0NlUnd6?=
 =?utf-8?B?L3BWeklIZkFsb2RBWGt2bmtJVVlIcWNjOFJxWnJtNHBvU0h6ZE1tWWo5Tm9K?=
 =?utf-8?B?S1o2aWh6MnZlekJrdmV0VFlnZjQ0ZWdqNTB5VjVrV2o1N1RZZWpHWEIxaW5D?=
 =?utf-8?B?dWU1Q0tyOStYODFUVDBsVkZwajRWcmVJamlMQnVkSFlGc1h2eWc2R1pBbkNn?=
 =?utf-8?B?NEsxVXVrWDFFT0RtMzYvdGYwRk0wSU1XSGNEb2VSZjNwYkNrZU1tdzlrUHAr?=
 =?utf-8?B?c044Ry9GSnRtSHhZOENhUjNyQnVDZnJWSG5ZbzRSZTRCS1VvUEloZzJvd2xx?=
 =?utf-8?B?dDJJbnFnR0pQcWxzNWJ0U3RBVFNBaWtUZ2F5YStyWjhUaVUyMkxrWUJLV3ZW?=
 =?utf-8?B?NzgwalpabkpXMndjRUFuOHJIczY5VENxNUhxMXByNno1Z2NSV3YzQnY4am1K?=
 =?utf-8?B?QWdsS0hLcTdncnoyWTVnVExHbWhXL2F3eFFiaDdJZVQvWnRoRnJXWXJwbEtz?=
 =?utf-8?B?dVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <058AC51E97D1A7418EB22A9DAE974D26@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	5Q4MZxCcaROkfyFr1pfkNbGlY5fNHML/LEYes7Wy7iHOXRB7DhxDF4YN3bjtBbQKInmR85wW1DBpkhkmml002tLPpgtKX0Nbwu7x+pm3uaTmQtPB6uBNvpwY8HuwuDQ/UCsJi85OAHPrMyijALW/Dgy/HTQEpwZprutvr91NUdYGhJuCS7YLQecXc8yDyAPkFzTtqOiB/jzltY1wmrH1ZBWIZUtuAd3oy1u75s38kbxhuMU4Ad5iIY3LjZ8nGlT8YAGYf8dPrqGsvkw9QUWgt6erHzQ1R1lJTHbr19atmaGj9SfGegmDQ4uOo18WZtANJehMa7UOvsqOHhsR3X+sl7OezZ+GtWvd73mDcUoRi6nsAKtbs4f+gzHn2RhtxOmOk4KvJwCIcmPDmq0K1j6SHWXn/Q+fKHeFFofsKKIKC0LV+jtbkkqlgSINz0rzEE6Nb+E14fKHuBJPHR7YUJZQE53bKKcFCRbALJJQGGkwvImkPrxIUs+TObbj27k4yKpFJBMjV2UmOEww1acaxGOW+uaYWZ3W/LeOWg/539wvG/brOiUdEHxjy+tDo8rc25dn891sppRLPg7lDoxJeg6gQI8mVWDWrl8oDZVVYwkNjY8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39866e68-eb86-4d4d-17f6-08dc0ca56532
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jan 2024 21:46:08.6431
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: I8VGeUajXu+TjcSksi8opz3ZdoY7uXnx7G8JsnU4CzF9Xwb9PQpaHuPyE6snjxzMCTw1A9sUMICjI24eG4obUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4606
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-03_08,2024-01-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0
 mlxlogscore=999 phishscore=0 mlxscore=0 bulkscore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401030176
X-Proofpoint-GUID: SrX20XF-21e8op6YloT7U4cPHACQjtOZ
X-Proofpoint-ORIG-GUID: SrX20XF-21e8op6YloT7U4cPHACQjtOZ

DQoNCj4gT24gSmFuIDMsIDIwMjQsIGF0IDM6MTbigK9QTSwgQmVuamFtaW4gQ29kZGluZ3RvbiA8
YmNvZGRpbmdAcmVkaGF0LmNvbT4gd3JvdGU6DQo+IA0KPiBPbiAzIEphbiAyMDI0LCBhdCAxNDox
MiwgQ2h1Y2sgTGV2ZXIgSUlJIHdyb3RlOg0KPiANCj4+PiBPbiBKYW4gMywgMjAyNCwgYXQgMTo0
N+KAr1BNLCBCZW5qYW1pbiBDb2RkaW5ndG9uIDxiY29kZGluZ0ByZWRoYXQuY29tPiB3cm90ZToN
Cj4+PiANCj4+PiBUaGlzIGxvb2tzIGxpa2UgaXQgc3RhcnRlZCBvdXQgYXMgdGhlIHByb2JsZW0g
SSd2ZSBiZWVuIHNlbmRpbmcgcGF0Y2hlcyB0bw0KPj4+IGZpeCBvbiA2LjcsIGxhdGVzdCBoZXJl
Og0KPj4+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LW5mcy9lMjgwMzhmYmExMjQzZjAw
YjBkZDY2YjdjNTI5NmExZTE4MTY0NWVhLjE3MDI0OTY5MTAuZ2l0LmJjb2RkaW5nQHJlZGhhdC5j
b20vDQo+Pj4gDQo+Pj4gLi4gaG93ZXZlciB3aGVuZXZlciBJIGVuY291bnRlciB0aGUgaXNzdWUs
IHRoZSBjbGllbnQgcmVjb25uZWN0cyB0aGUNCj4+PiB0cmFuc3BvcnQgYWdhaW4gLSBzbyBJIHRo
aW5rIHRoZXJlIG1pZ2h0IGJlIGFuIGFkZGl0aW9uYWwgcHJvYmxlbSBoZXJlLg0KPj4gDQo+PiBJ
J20gbG9va2luZyBhdCB0aGUgc2FtZSBwcm9ibGVtIGFzIHlvdSwgQmVuLiBJdCBkb2Vzbid0IHNl
ZW0gdG8gYmUNCj4+IHNpbWlsYXIgdG8gd2hhdCBKZWZmIHJlcG9ydHMuDQo+PiANCj4+IEJ1dCBJ
J20gd29uZGVyaW5nIGlmIGdlcnJ5LXJpZ2dpbmcgdGhlIHRpbWVvdXRzIGlzIHRoZSByaWdodCBh
bnN3ZXINCj4+IGZvciBiYWNrY2hhbm5lbCByZXBsaWVzLiBUaGUgcHJvYmxlbSwgZnVuZGFtZW50
YWxseSwgaXMgdGhhdCB3aGVuIGENCj4+IGZvcmVjaGFubmVsIFJQQyB0YXNrIGhvbGRzIHRoZSB0
cmFuc3BvcnQgbG9jaywgdGhlIGJhY2tjaGFubmVsJ3MgcmVwbHkNCj4+IHRyYW5zbWl0IHBhdGgg
dGhpbmtzIHRoYXQgbWVhbnMgdGhlIHRyYW5zcG9ydCBjb25uZWN0aW9uIGlzIGRvd24gYW5kDQo+
PiB0cmlnZ2VycyBhIHRyYW5zcG9ydCBkaXNjb25uZWN0Lg0KPiANCj4gV2h5IHNob3VsZG4ndCBi
YWNrY2hhbm5lbCByZXBsaWVzIGhhdmUgbm9ybWFsIHRpbWVvdXQgdmFsdWVzPw0KDQpSUEMgUmVw
bGllcyBhcmUgInNlbmQgYW5kIGZvcmdldCIuIFRoZSBzZXJ2ZXIgZm9yZWNoYW5uZWwgc2VuZHMN
Cml0cyBSZXBsaWVzIHdpdGhvdXQgYSB0aW1lb3V0LiBUaGVyZSBpcyBubyBzdWNoIHRoaW5nIGFz
IGENCnJldHJhbnNtaXR0ZWQgUlBDIFJlcGx5ICh0aG91Z2ggYSByZWxpYWJsZSB0cmFuc3BvcnQg
bWlnaHQNCnJldHJhbnNtaXQgcG9ydGlvbnMgb2YgaXQsIHRoZSBSUEMgc2VydmVyIGl0c2VsZiBp
cyBub3QgYXdhcmUgb2YNCnRoYXQpLg0KDQpBbmQgSSBkb24ndCBzZWUgYW55dGhpbmcgaW4gdGhl
IGNsaWVudCdzIGJhY2tjaGFubmVsIHBhdGggdGhhdA0KbWFrZXMgbWUgdGhpbmsgdGhlcmUncyBh
IGRpZmZlcmVudCBwcm90b2NvbC1sZXZlbCByZXF1aXJlbWVudA0KaW4gdGhlIGJhY2tjaGFubmVs
Lg0KDQoNCj4+IFRoZSB1c2Ugb2YgRVRJTUVET1VUIGluIGNhbGxfYmNfdHJhbnNtaXRfc3RhdHVz
KCkgaXMuLi4gbm90IGVzcGVjaWFsbHkNCj4+IGNsZWFyLg0KPiANCj4gU2VlbXMgbGlrZSBpdCBz
aG91bGQgbWVhbiB0aGF0IHRoZSByZXBseSBjb3VsZG4ndCBiZSBzZW50IHdpdGhpbiAod2hhdA0K
PiBzaG91bGQgYmUpIHRoZSB0aW1lb3V0IHZhbHVlcyBmb3IgdGhlIGNsaWVudCdzIHN0YXRlIG1h
bmFnZW1lbnQgdHJhbnNwb3J0Lg0KDQpJdCBsb29rcyB0byBtZSBsaWtlIGJhY2tjaGFubmVsIHJl
cGxpZXMgYXJlIEhBUkQsIG5vdCBTT0ZULg0KVGhhdCBzdWdnZXN0cyBjYWxsX2JjX3RyYW5zbWl0
X3N0YXR1cygpIGlzIG5vdCBleHBlY3RpbmcNCkVUSU1FRE9VVCB0byBtZWFuICJyZXF1ZXN0IHRp
bWVkIG91dCIsIHdoaWNoIGlzIHRoZSB1c3VhbA0KbWVhbmluZyBvZiBFVElNRURPVVQgLS0gYW5k
IHRoYXQncyBvbmx5IGZvciBTT0ZUIFJQQ3MuDQoNClNlZSBhbHNvIDc2MmU0ZTY3YjM1NiAoIlNV
TlJQQzogUmVmYWN0b3IgUlBDIGNhbGwgZW5jb2RpbmciKSwNCndoaWNoIGFkZGVkIFJQQ19UQVNL
X05PX1JFVFJBTlNfVElNRU9VVCB0byBycGNfcnVuX2JjX3Rhc2soKS4NCg0KU28gbXkgInJlYWQi
IG9mIHRoZSBjb2RlIGlzIHRoYXQgdGhlcmUgY3VycmVudGx5IGlzIG5vDQp0aW1lb3V0IHNldCwg
YW5kIEVUSU1FRE9VVCBpc24ndCBleHBlY3RlZCB0byBtZWFuIHRoZSBzZW5kDQp0aW1lZCBvdXQu
IFRoaXMgY29kZSBkb2VzIG5vdCByZWx5IG9uIGEgdGltZW91dCB0byBzZW50DQpyZXBsaWVzIGF0
IGFsbC4gSXQgc2VlbXMgdG8gYmUgcmV1c2luZyB0aGUgRVRJTUVET1VUIGVycm9yDQp0aGF0IHdh
cyBzZXQgYXMgYSBzaWRlLWVmZmVjdCBvZiBzb21ldGhpbmcgZWxzZS4NCg0KDQo+IEknbSBnbGFk
IHlvdSdyZSBzZWVpbmcgdGhpcyBwcm9ibGVtIHRvby4gIEkgd2FzIHdvcnJpZWQgdGhhdCBzb21l
dGhpbmcgd2FzDQo+IHNlcmlvdXNseSBkaWZmZXJlbnQgYWJvdXQgbXkgdGVzdCBzZXR1cC4NCg0K
Rm9yIHRoZSBwdWJsaWMgcmVjb3JkLi4uDQoNClRlc3Rpbmcgd2l0aCBORlN2NC4yLCBJIHNlZSB0
aGUgY2xpZW50IGRvaW5nIGFzeW5jIENPUFkNCm9wZXJhdGlvbnMsIGJ1dCB0aGVuIG5vdCByZXBs
eWluZyB0byB0aGUgc2VydmVyJ3MgQ0JfT0ZGTE9BRA0Kbm90aWZpY2F0aW9ucy4NCg0KVGhlIGNs
aWVudCBpcyBub3QgYWN0dWFsbHkgZHJvcHBpbmcgdGhlIENCX09GRkxPQURzLCB0aG91Z2g7DQpp
dCBwcm9jZXNzZXMgdGhlbSBidXQgdGhlbiBuZXZlciBzZW5kcyB0aGUgcmVwbHkgYmVjYXVzZQ0K
eHBydF9wcmVwYXJlX3RyYW5zbWl0KCkgZmFpbHMgdG8gbG9jayB0aGUgdHJhbnNwb3J0IHdoZW4N
CnNlbmRpbmcgdGhlIHJlcGx5LiBUaGUgc2xlZXBfb25fdGltZW91dCBpbiB4cHJ0X3Jlc2VydmVf
eHBydA0KaXMgZmFsbGluZyB0aHJvdWdoIGJlY2F1c2UsIGFzIHlvdSBvYnNlcnZlZCwgdGhlIHJx
c3QgdGltZW91dA0Kc2V0dGluZ3MgYXJlIGFsbCB6ZXJvLg0KDQpTbyB0aGUgY2xpZW50IGhhcyBw
cm9jZXNzZWQgdGhlIENCX09GRkxPQUQgYW5kIGFkdmFuY2VkIHRoZQ0Kc2xvdCBzZXF1ZW5jZSBu
dW1iZXIsIGJ1dCBiZWNhdXNlIHRoZSBzZXJ2ZXIgZG9lc24ndCBzZWUgYQ0KcmVwbHkgaXQgbGVh
dmVzIGl0cyBjb3B5IG9mIHRoZSBzbG90IHNlcXVlbmNlIG51bWJlciBhbG9uZS4NCg0KVGhlIHNl
cnZlciBzZW5kcyB0aGUgbmV4dCBDQl9PRkZMT0FEIGFuZCB0aGUgY2xpZW50IHJlcGxpZXMNCndp
dGggTkZTNEVSUl9SRVRSWV9VTkNBQ0hFRF9SRVAgYmVjYXVzZSB0aGUgc2xvdCBzZXF1ZW5jZQ0K
bnVtYmVycyBubyBsb25nZXIgbWF0Y2guIFRoZSBjbGllbnQgdG9zc2VzIHRoYXQgQ0JfT0ZGTE9B
RA0Kbm90aWZpY2F0aW9uLg0KDQpUaGUgc2VydmVyIGRvZXNuJ3QgcmV0cmFuc21pdCBpdCBhZnRl
ciB0aGUgbmV3IHNlc3Npb24gaXMNCmNyZWF0ZWQgYmVjYXVzZSBERVNUUk9ZX1NFU1NJT04ga2ls
bHMgdGhlIGJhY2tjaGFubmVsDQpycGNfY2xudCBhbmQgYWxsIGl0cyB0YXNrcy4gT3IgbWF5YmUg
dGhlcmUncyBzb21lIG90aGVyIGJ1Zw0KaW4gdGhlcmUsIGJ1dCBJIHRoaW5rIHRoZSBzZXJ2ZXIg
c2hvdWxkIHJldHJhbnNtaXQgYW5kIGl0DQpkb2Vzbid0Lg0KDQpTbyB0aGUgY2xpZW50IGNvcHkg
b3BlcmF0aW9uIGlzIHN0dWNrIHdhaXRpbmcgZm9yIGENCkNCX09GRkxPQUQgbm90aWZpY2F0aW9u
IHRoYXQgbmV2ZXIgYXJyaXZlcy4gVGhlIGNsaWVudCBjb3VsZA0Kc2VuZCBhIENPUFlfTk9USUZZ
LCB0byBjaGVjayBvbiB0aGUgcGVuZGluZyBDT1BZLCBidXQgaXQNCmRvZXNuJ3QuDQoNCkNlcnRh
aW5seSB0aGUgY2xpZW50IGV4cGVjdHMgYSByZXRyYW5zbWl0LiBTZWUgMzgzMjU5MWU2ZmE1DQoo
IlNVTlJQQzogSGFuZGxlIGNvbm5lY3Rpb24gaXNzdWVzIGNvcnJlY3RseSBvbiB0aGUgYmFjaw0K
Y2hhbm5lbCIpLiBCdXQgSSdtIG5vdCBzdXJlIE5GU0QgZXZlciBkaWQgdGhpcyAtLSBJIHdpbGwN
Cmxvb2sgaW50byBhZGRyZXNzaW5nIHRoYXQuDQoNCkJ1dCBhbHNvLCB3ZSBkb24ndCB3YW50IHRo
ZSBjbGllbnQgc3B1cmlvdXNseSBkaXNjb25uZWN0aW5nDQphbmQgcmVjeWNsaW5nIGl0cyBzZXNz
aW9ucyBqdXN0IGJlY2F1c2UgdGhlIHdyaXRlIGxvY2sgaXMNCmhlbGQgYnkgYW5vdGhlciB0YXNr
IHJpZ2h0IGF0IHRoYXQgbW9tZW50LiBUaGF0J3MgYW4gZW5vcm1vdXMNCmJ1YmJsZSBpbiB0aGUg
dGhyb3VnaHB1dCBwaXBlbGluZS4gVGhlIHByb2JsZW0gc2VlbXMgdG8gYmUNCndvcnNlIHdoZW4g
dGhlIGZvcmVjaGFubmVsIGlzIHVuZGVyIGxvYWQuIEkgdGhpbmsNCnRyYW5zbWl0dGluZyBiYWNr
Y2hhbm5lbCByZXBsaWVzIG5lZWRzIHRvIGJlIG1vcmUgcmVsaWFibGUuDQoNCg0KLS0NCkNodWNr
IExldmVyDQoNCg0K

