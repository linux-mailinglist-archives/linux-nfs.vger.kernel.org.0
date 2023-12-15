Return-Path: <linux-nfs+bounces-626-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90F19814A58
	for <lists+linux-nfs@lfdr.de>; Fri, 15 Dec 2023 15:20:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20E6D1F26AD3
	for <lists+linux-nfs@lfdr.de>; Fri, 15 Dec 2023 14:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03EBE315B2;
	Fri, 15 Dec 2023 14:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Ck4oNg90";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Gwin3zLe"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF95930FAF
	for <linux-nfs@vger.kernel.org>; Fri, 15 Dec 2023 14:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BFEFT75019044;
	Fri, 15 Dec 2023 14:19:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=8YjQKPG3kcMmh/Fi/Hcha3Kguf6/PYeQNop6kY+rse8=;
 b=Ck4oNg909ZdWaGTyLPHBEnul4cJpHXAxR57SGEPSwoP5z7CpHjsUBP56vwLEzt0nO1FK
 z3opQ0RhL/aGiDWLeFqO+I+5p5AVadGDYBKcvjKpkCbNivyLyaycgkIfRJailQ3VtsAj
 f7hYHSxuaRxgCP+pnM7klEV0yUvdn7TErN1rZXJDQOyi9W4uWkT+rbZmo2gmqLagb9hc
 rc/ud6wiF7J72WjZ4VqpTv4C+9xRh+WJtIKHM15d/Y/oKifV+R8pagl3CcPkUNL1cpBt
 yFYf1GQeO59AeJTwg8wNMdPAvWwrWn4Q2+rnnx4RUj149oPi6tiXF90uAFTMv5tTZptz oA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uveu2dcqf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Dec 2023 14:19:28 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3BFDIoBM012976;
	Fri, 15 Dec 2023 14:19:27 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3uvepj5wqx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Dec 2023 14:19:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lvgoTvh8NFywURJHHkv82oqfX/aNn9ePUrHJyU5GngPvipR6hOuuNMl8ZBGGhrBNpCFeGoccd03K3V6EE3RTAuVbAux69WqKvUr35JyJ75NHqgAF6crKMuA8mGLdKASBEUQa1QwMvDEYwmg/34N6XFyzYyGKFim8HIhxO8sXDnxbLHZlx2/nf3yxfaTZDL9SaOsSlc0YHNgwb2rjQirYdWCwvtnfwnCWVGJzXXypg0pZAnx5E65E8Qi9q2DNbc9nhVceOJFISVld3uFf0AIRPgLHhB1gqALlc8U9vH28wEjmJepWQjSp/zJq7FuS68Zl/y391NIT/+xfDslv87DOXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8YjQKPG3kcMmh/Fi/Hcha3Kguf6/PYeQNop6kY+rse8=;
 b=FUZ+Pj/ktxI/LS2t6cec71Ce+iOOipbnhHo1X+GesdPVi8/W/Yl4CNmcnmuaLXW5ARtkRwWgbbhmOshGafqUaCVRabk7Snz9wwPfb4Nk040r0RlfOZgO1HhO5JWpRE1QNAjNo+McMmT8iE+SjMubCnV8tHjrCGGBVM8Db5GCAmAeYNA7lmlV5dPuRSIdKUaC41V/CaKjm+caJ/uY7HYPZ3ZAP368aR7ac/L9wXErAWEwH20etJgG8hZ24GJafmSEwtaiVq3Xd2tculC2w5HV4eU69ThIdB5glZy+ipGQZ+2D8OPTHrtD0mzu0PIkOcW+gNE2sS62gGocgxajkYWilA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8YjQKPG3kcMmh/Fi/Hcha3Kguf6/PYeQNop6kY+rse8=;
 b=Gwin3zLeQRQ2kCjmIT+edm6ZmtBPmWp+4mFp8nbtaLuL5bSfnWr45Bb2kSVEg9Em4E8jWj3wvpqf+2tbWGt4rRWFwO/SggeahMISH/c6dVEfk4Eyj483dqVNqz1zzatakdkVocr5Nm9VIIbJppCWQ0QsoFRBdewZfXvtGydHEM0=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS7PR10MB5927.namprd10.prod.outlook.com (2603:10b6:8:85::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.32; Fri, 15 Dec
 2023 14:19:25 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c%4]) with mapi id 15.20.7091.032; Fri, 15 Dec 2023
 14:19:24 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Jeff Layton <jlayton@kernel.org>
CC: Neil Brown <neilb@suse.de>,
        Linux NFS Mailing List
	<linux-nfs@vger.kernel.org>,
        Olga Kornievskaia <kolga@netapp.com>, Dai Ngo
	<dai.ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>
Subject: Re: [PATCH 0/5 v2] sunrpc: stop refcounting svc_serv
Thread-Topic: [PATCH 0/5 v2] sunrpc: stop refcounting svc_serv
Thread-Index: AQHaLvIpI3Gh1yYMNEWNLEmjJILL4bCqLZEAgAA35gA=
Date: Fri, 15 Dec 2023 14:19:24 +0000
Message-ID: <23A34EAB-A72E-459E-8D2D-7160CB25B549@oracle.com>
References: <20231215010030.7580-1-neilb@suse.de>
 <7659cf71534f9e81cb95f1571f1942a30b7f5a60.camel@kernel.org>
In-Reply-To: <7659cf71534f9e81cb95f1571f1942a30b7f5a60.camel@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.200.91.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|DS7PR10MB5927:EE_
x-ms-office365-filtering-correlation-id: f8f86162-74c1-4254-3152-08dbfd78d6ee
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 xSV9s3ab0i53sDxX8A6iyc4L3slY1A9uK7D//2rxmZSCIiSiu+VIeJCUQJFDFr0gesRRxD5UihA8gzmsWyPd5y/kQgyywAZCX9QhITDxpu3I1ajeX9U/17Iynm+Ms1kDvskWXsKG0eXnTucgET2CLP0qxMMLkoUX0AVxNmdmpfVuQh9EEnAB2h7Se7kpF90pzmmGpxxaczj9Uf2hIXiJKMiXfzxB1s9FR3WK4Q965EhPYHEBTdG6BHW6svmnDNuDUa7sA6mLgfEouoFeFFE5qGUVlMFLGytKh8q5nPIq0LkFcUXhN4526M5p0oT3YI2us0w7/8Ne0LB7ku/HoD/XA790El3WLOXO/mup2YQ+ERmyIj5PEV7DSnAW2066DKErDFOnZVQlNn20HZ7NxLVxIMkyKiiXTZhN1sflgpFq8xPvh32Uzs5EE/OiQI31QZshd9ONe89V1QJIN4nEdNbq/BzJ+zFqDLPyYxlath1H+KE8S1ydCps3YSzT6pECIGfo7Buz86w3gMY9rThaqB7wQFr1ediaQC3rnHCp//TWl4PBFyPDmUc3VyzSEw34cE9+BwFZFynnAVsTjP3F/c6qO51nl+C84LchfB376uUJv1BwiMh0F636XLrTnDA7sm6Wzj5T/la8Q/VZHNb8KVm+0w==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(366004)(376002)(346002)(136003)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(26005)(2616005)(53546011)(6512007)(6506007)(71200400001)(122000001)(38070700009)(38100700002)(86362001)(33656002)(36756003)(41300700001)(4001150100001)(8676002)(8936002)(4326008)(91956017)(478600001)(5660300002)(2906002)(83380400001)(76116006)(6486002)(66946007)(66556008)(66446008)(64756008)(54906003)(6916009)(66476007)(316002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?clRaR2lRQzlzaUtqQnhiRjhkckhjbkhpZU1hak9Za1pDL1ZoS1BEMWthT1lG?=
 =?utf-8?B?UmdlcldrbDd4RTJqQmxsU3ZIWHg5R3lML2drd1Rsa2VZU0JHOUpWdHRTYWh3?=
 =?utf-8?B?ai9VOUhBVVpRNmV0Q3ZGRE9uYkdUcG5IRGdXcXdOeEdnZVUzTnA3eThXWE1N?=
 =?utf-8?B?a29lRFllWHQ0dTFTT3ZXZkMxYUdRTmN1NVExeTNJRkd6NHRrVmplRDJlQnJD?=
 =?utf-8?B?MzU5TW5haHMvL25BU1JacXpYYVZGWWp4UHdkMnpjZ0tBSkczU2lkcmtNRlNv?=
 =?utf-8?B?V1U4dlhJRGpQL251ZkJlbHhReGxLcjI4TlN3TW5CTXloL3Y2bmdPaUloNGpm?=
 =?utf-8?B?ajRmT09OcU5aVXdKWFF3MGUvTGFJaWVWdm0xbm11OWYrRDhQSTFmaTlrTnJq?=
 =?utf-8?B?TXdwUGdzeEVsdmxhQnNhOHJDblRIRUJkVXNGTldVNHRzbVBkSFVycldpeXkr?=
 =?utf-8?B?R2FHd2hud2NFYnJscElKaUtLdEgvSTN1WHZ2OEc3dUNFVGdVbXV3UWZNVXJW?=
 =?utf-8?B?RytBQ1pCdHd0bm11bGoxUFNUQTFVdGd2MlZsREFyUVJXa3hRektobDZMMXRk?=
 =?utf-8?B?UElMNFZ3WDc2eG9KSXlsaWdvN2pGczRxY2xIWkwxZ3RFNTFtSCtuSDVRdWFo?=
 =?utf-8?B?d24zZ3RqRjc2YTV2NFR6dTVZS05FcTIwZkVXMGVydUE1V3ROMklwdXVCd0xH?=
 =?utf-8?B?N08vUEZxNER0M1hrRGc0VDhwNk9HZ2ZwRFZNMFp0VzJkNUFiMTQ4RktDOU00?=
 =?utf-8?B?eGkxdXpuZVMvTFUvSk1YVzhEaGZsdHplK05sVmhmK29OSVlBOTBlZHhyZTNC?=
 =?utf-8?B?ZnFZaXdsVm5hNHdOUUNtb2Z0YVY0bzBUOGcrTXY0Y3hXVVFtM1NoQ2F6ckQy?=
 =?utf-8?B?bTY4SnlQRUpqcEtuRWY2eGxhRFlSVHROb0tocVVRQUhFV3pIakZldGdUZEh2?=
 =?utf-8?B?NnRrbmtXbnYzK29ZcnZmR21rdXFCTlQ1b01yVzN4Y3NqWGZDaGl5eEg0NG1a?=
 =?utf-8?B?UmdiNHMzaXlLOTRNZzhFS2F3K3dnUjF5bmZKQU1KRjFPcVNPQ0IreUwrYWxP?=
 =?utf-8?B?NWFQYTNiSUkwcGFNZGE2UzFvRnlWOG8yRDJzK3hPWWE2MS94L25LSzNlMHVq?=
 =?utf-8?B?RzBtSVhGRFRuQVg5K3NEZFF5NVNEVnd4QVl1aGdUcjZTMlVUQXRXRkZ3Q20y?=
 =?utf-8?B?L2oySEptUFh6WmU0aXJrSjg4dVByVkRGWi91emVZM1pVaTFhVGZuVXRhSFBJ?=
 =?utf-8?B?NUs2UHNNZ3VJUTVIOE5mczBLaVcyOFU2cWpLVlpGY1F5U3oxcndNMXBCcHM1?=
 =?utf-8?B?M1NDVjRqZ3IwNmJieTk5MWJhNmRpRHY3UFlUQ1gwSFQrU3lZcEErUkdJN1I5?=
 =?utf-8?B?T2RYL25NTW1OMjBFZy9SQkl1YytROSs2N2VWbjJ2QVFaVE1kTlZXbmtTY2JW?=
 =?utf-8?B?WitucVlyOE5US0FORXVoSzB1MjhjdkI0Z0RxeUdkQldTemxGOERLQU5oamtq?=
 =?utf-8?B?ZlVkTDRXZnlNdkJCZ3BXVFZtV3RyWFJrenlkT3NMNjZMM1o3QTBzK1pXYzRS?=
 =?utf-8?B?cS9aWHVZRVpzbVJLdDdaT0lXVExmd3VPRWhzbWxMdXVDd2hWa0xjYjE1ZGVD?=
 =?utf-8?B?bmxwYWJuLzlhS3FVcW8wajRxT1IvTzVXejhVeW0xWHRKeTVUQmJQYTlTcGRH?=
 =?utf-8?B?V3cwY1l4MmFuK2ExMHcwZWV1eHJxcWtqNVRNRzVnZXlHWmhsbmRlNi8yNUJw?=
 =?utf-8?B?aGN5UTNWWkx0QnlOcm11T2Q3TUlLZ29hdnNTOUJFTTAyQjRmNm92ZC9xeGk1?=
 =?utf-8?B?T0NxS1RPU3BhL0JLK3B6R1pKdjNpaWdMT3ZLODNKV0pKVUlMeTdabnZKWFNL?=
 =?utf-8?B?c3gxdEF1UmtvYmtqSlFiVnYyTzJqS2cxbytvUlNWNHZyNU9iUW1DUFAxaVA1?=
 =?utf-8?B?WXJ6Mkkxa0dwaENjTGcrZXozWGljS01CVGVZUGtkdURtMTVTY2JJTXdCU0JY?=
 =?utf-8?B?ZkRqR0Fqa1F2TXZBK2pGMUpGdWJTbjYwME9oZjFCYThiTkpQbEphT0FFclpp?=
 =?utf-8?B?bk1CeW8rQWxHa1FyTlZRZXNYd0JkcEdab3NkcUJZNkJNU1NibVUrNWgxeGtD?=
 =?utf-8?B?QUwxUGhyVzcycXV6YWQ5RFZ6cnUwTHEvL0JvS0dxVjd4a2JaU1A5MFEvSmow?=
 =?utf-8?B?dlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <90BA955C44B8994AB31CB69B375CB7C8@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	uJg4OwE/jq2hkYOTXNN0GTSQKDg8ntNYxmy8M2ShMSRltG3GMl7f1K0hZ9aAgmFwFn9fh5QzfZuti4mEWQnD6KaV+yu6M95jB3N4zcWdZ77xwvyHcFDWib6mXfdRKJpSUxIQZPVcJlBuAvW0Ew5Z9oWBkjVGa2eG6M6H5uPlt/XTasuzUYiL8PelVOJkdbKbjmmlX6p4BlaWHM+V2acfkralfMOqkNIsVKhVD70d1oK1C6k1JBcsCuEtuT2/ZFCa/tFAgrSBLaSujnEbuJCPME7cBFEqVF14f1+mS36oV7PJ84BOfE/K5eu5NZiMEt2Xpcrmq+F6AFnNCcMcAdM4gYjiUIf547lQlOLe8qzTt08UVyHmA/1wql+Sa4DMHe3v/Wyg8qdwbC7cSK2UQ8oi1rUcu6FDECicPg9vRJY1oQJBUKqw4qMWdTku+/oQN8ddgYW70uBvE89UgA2w6Ppw8JWChje1pLFz45B33G7p25EqfbnCpHhjvuDo4KCptpk/cezalEHD8tFkLGWMyf4uTh+ro/kvKV7JGxp0zvisXaXiRaSN3rJkqN01Md6siDOgTQrNeqgbjA3qKUnhjQtvUEupfzMqYy3beNyTQz5+1Wg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8f86162-74c1-4254-3152-08dbfd78d6ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Dec 2023 14:19:24.6411
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PGLkri7bwt/YAwMcIoSdXULw0uV9tLRtBnymrBjW+vkUK9ozgJhB8GydYEI6GKauRVvdvx1OqdTzNZc9oAKqSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5927
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-15_08,2023-12-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 suspectscore=0
 phishscore=0 adultscore=0 mlxlogscore=819 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312150098
X-Proofpoint-ORIG-GUID: 4kcvgeTqRh3kRHVFiXNXgzlShYo7Jmrd
X-Proofpoint-GUID: 4kcvgeTqRh3kRHVFiXNXgzlShYo7Jmrd

DQo+IE9uIERlYyAxNSwgMjAyMywgYXQgNTo1OeKAr0FNLCBKZWZmIExheXRvbiA8amxheXRvbkBr
ZXJuZWwub3JnPiB3cm90ZToNCj4gDQo+IE9uIEZyaSwgMjAyMy0xMi0xNSBhdCAxMTo1NiArMTEw
MCwgTmVpbEJyb3duIHdyb3RlOg0KPj4gSSBzZW50IGFuIGVhcmxpZXIgdmVyc2lvbiBvZiB0aGlz
IHNlcmllcywgZ290IHNvbWUgZmVlZCBiYWNrLCByZXZpc2VkDQo+PiBpdCwgYnV0IG5ldmVyIHNl
bnQgaXQgYWdhaW4uICBTb3JyeS4NCj4+IA0KPj4gVGhlIG1haW4gZmVlZGJhY2sgd2FzIGFyb3Vu
ZCB0aGUgaW50ZXJhY3Rpb24gYmV0d2VlbiBzdW5ycGMgYW5kIG5mc2QgZm9yDQo+PiBoYW5kbGlu
ZyBwb29sc3RhdHMuICBJIGhhdmUgY2hhbmdlZCB0aGF0IHNvIHRoYXQgbmZzZCB0ZWxscyBzdW5y
cGMgd2hlcmUNCj4+IHRoZSBzdmNfc2VydiBwb2ludGVyIGxpdmVzLCBhbmQgd2hlcmUgdG8gZmlu
ZCBhIG11dGV4IHRvIHByb3RlY3QgaXQuDQo+PiBzdW5ycGMgdGhlbiB0YWtzIHRoZSBtdXRleCBh
bmQgYWNjZXNzZXMgdGhlIHBvaW50ZXIgLSBpZiBub3QgTlVMTC4gIEkNCj4+IHRoaW5rIHRoaXMg
aXMgbmljZXIgdGhhbiB0aGUgdmVyc2lvbiB0aGF0IHBhc3MgYXJvdW5kIGZ1bmNpdG9uIHBvaW50
ZXJzLg0KPj4gDQo+PiBUaGlzIHNlcmllcyBpcyBhZ2FpbnN0IG5mc2QtbmV4dA0KPj4gDQo+PiBU
aGFua3MsDQo+PiBOZWlsQnJvd24NCj4+IA0KPj4gDQo+PiBbUEFUQ0ggMS81XSBuZnNkOiBjYWxs
IG5mc2RfbGFzdF90aHJlYWQoKSBiZWZvcmUgZmluYWwgbmZzZF9wdXQoKQ0KPj4gW1BBVENIIDIv
NV0gc3ZjOiBkb24ndCBob2xkIHJlZmVyZW5jZSBmb3IgcG9vbHN0YXRzLCBvbmx5IG11dGV4Lg0K
Pj4gW1BBVENIIDMvNV0gbmZzZDogaG9sZCBuZnNkX211dGV4IGFjcm9zcyBlbnRpcmUgbmV0bGlu
ayBvcGVyYXRpb24NCj4+IFtQQVRDSCA0LzVdIFNVTlJQQzogZGlzY2FyZCBzdl9yZWZjbnQsIGFu
ZCBzdmNfZ2V0L3N2Y19wdXQNCj4+IFtQQVRDSCA1LzVdIG5mc2Q6IHJlbmFtZSBuZnNkX2xhc3Rf
dGhyZWFkKCkgdG8gbmZzZF9kZXN0cm95X3NlcnYoKQ0KPiANCj4gSSdtIG5vdCBzdXJlIHBhdGNo
ICMyIGlzIGJldHRlciB0aGFuIHRoZSB2ZXJzaW9uIHdpdGggZnVuY3Rpb24gcG9pbnRlcnMsDQo+
IGJ1dCBpdCBzZWVtcyByZWFzb25hYmxlLg0KPiANCj4gTm90ZSB0aGF0IHBhdGNoICMxIHByb2Jh
Ymx5IG5lZWRzIHRvIGdvIHRvIHY2LjYgc3RhYmxlLCBhbmQgSSB0aGluayB3ZQ0KPiB3YW50ICMz
IGluIHY2LjcgYmVmb3JlIGl0IHNoaXBzLg0KDQpSZW1pbmQgbWUgd2h5ICMzIHNob3VsZCBnbyBp
bnRvIHY2LjctcmMgPyBUaGVyZSdzIG5vIEZpeGVzIHRhZyBvbg0KdGhhdCBvbmUuDQoNCg0KPiBJ
IHRoaW5rIEkgc2VudCB0aGlzIG9uIHRoZSBlYXJsaWVyIHNldCwgYnV0IEknbGwgc2VuZCBpdCBh
Z2FpbjoNCj4gDQo+IFJldmlld2VkLWJ5OiBKZWZmIExheXRvbiA8amxheXRvbkBrZXJuZWwub3Jn
Pg0KDQotLQ0KQ2h1Y2sgTGV2ZXINCg0KDQo=

