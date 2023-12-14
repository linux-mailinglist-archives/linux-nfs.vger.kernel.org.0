Return-Path: <linux-nfs+bounces-610-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 11B5C813B50
	for <lists+linux-nfs@lfdr.de>; Thu, 14 Dec 2023 21:12:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 899C71F22196
	for <lists+linux-nfs@lfdr.de>; Thu, 14 Dec 2023 20:12:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1323F6A325;
	Thu, 14 Dec 2023 20:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Cor8wabp";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="SLlLbDJw"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5047C6A321;
	Thu, 14 Dec 2023 20:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BEIDpXt031490;
	Thu, 14 Dec 2023 20:12:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=/DXusMgAldyE4RzvP8bnUuS8KEt82yp7EwgKEit5KA0=;
 b=Cor8wabp6dgg3bcR+T3WjUz+58aIHMyyEShTBhPG4MwSdTp0bhw9YlcBcnSiv6iQnjhE
 L1paDtqB+VXIsLcgzLZRc0DkCPzhhcc4k5bhD8keuvQMTBX1Gaw362XRZBFLedbJtQzk
 OeD6v7NDBMg9ymp1AbMnIS6MB0KidJkBrrTMropUD2ioJER8dj2iWCGuoXIxWiC6K3e3
 4xHqZDZzXDF7x8gmDdEDxzS4081ihkYwS4Ny5it44vm6PUeJ1Hg7MKQUbycJRlwb+hKC
 MX1LRk74MlhGps4XiajuCjZsr3dmXod7ERZzPOQkG0MbcxXE0d4Pkhix78SadW3FYf0m cA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uvg9dbvyy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 Dec 2023 20:12:28 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3BEJRcX1008295;
	Thu, 14 Dec 2023 20:12:27 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3uvepapqux-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 Dec 2023 20:12:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wq9QIraZibHDiTUMnnrBDZIYRE9sY35ZGdEi/nfI3u1WTSjW8+7hIrYp7aeoaqd8X7kfEUVKTNZnEe5aW0uDFNvLXFgR1XLJ44+a9B1/XFnP2TarLwpjmXYNKEqaa/FcdBY1y3lSUDk+GyXJf4c27vtkzgiCVV0S2SO9pYNzFNcZrM3TnXQXdReCOSI2jOEztqq9YxhDwbSkgX4SvM0mUNBMTbOXPnuu0S8SjMw1o/M1t/QtUYKGTSXYClcfZuVItiWBOkswPfG7IprT0ruyfGBuQhhqVcNJW+pg35a79YlbSQtLA+zk84+25oNRCFRnnAYX2O32/58cOZ/uL9xcvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/DXusMgAldyE4RzvP8bnUuS8KEt82yp7EwgKEit5KA0=;
 b=BSNAMKHTCF6zOFji1vVpIGTiKKJOSa1FK2lh/TW4CnL9BM2SjhlubUD+kmxkJxOlOA9hvVzNk+4RdmzDtDNYnLSIPDxTE+4IqliWvqdHQCJpA3/mC21qUGh2aob5qwP2RzpBIwsd+df6nthwYCff6tDLbGoHXna566eb52OC0/5BcYSZgj1XC/DKmNdgyfZRVW7PwBiEgqPuGGL9kPZw0mOlgDzIDwvT5NdBmKUrd0Vl9/SnzpI9fWGoSfk+iDhmJTHx0Fi/+dBejrJW40+l9NQpBWgCRNW6IxJkU04ulyzVeHIS8u1SQmuE3Pkz/T4lmrjNkIYhAbSm4NzszsdFTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/DXusMgAldyE4RzvP8bnUuS8KEt82yp7EwgKEit5KA0=;
 b=SLlLbDJwsGHr3NbIexYswavasuCzFb53+fIptdLkS36BofxbO/yCHygkdeiR5RjtZxzTyaN45HxCXLQnMTS/9Ed0yRA647j4GTekddWWWWmGV0ltxz0ZxOqfbRzLGyWW/eWnu0Un7C0QzC09Yd95H7B7ZkOey+d5DeeDp+LUpkE=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BN0PR10MB5302.namprd10.prod.outlook.com (2603:10b6:408:117::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28; Thu, 14 Dec
 2023 20:12:25 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c%4]) with mapi id 15.20.7091.028; Thu, 14 Dec 2023
 20:12:24 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Jeff Hunter <wjhunter3@gmail.com>
CC: Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        Eric
 Snowberg <eric.snowberg@oracle.com>
Subject: Re: IMA over NFS
Thread-Topic: IMA over NFS
Thread-Index: AQHaLsPZW/EK7Ecvw0KqEDHq/jCz+rCpNiAA
Date: Thu, 14 Dec 2023 20:12:24 +0000
Message-ID: <A5E7CB34-2D3B-4667-AC01-B9BC55016629@oracle.com>
References: 
 <CAAcGnnaatt0HAMFosw2PjF7+5ERHRD5XBMg6+cz1WRNm0MOcFg@mail.gmail.com>
In-Reply-To: 
 <CAAcGnnaatt0HAMFosw2PjF7+5ERHRD5XBMg6+cz1WRNm0MOcFg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.200.91.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|BN0PR10MB5302:EE_
x-ms-office365-filtering-correlation-id: 92483128-be15-4119-cfed-08dbfce0fcee
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 Y94UbkE2VO9tlQNCDkMnkGxtLXGa8dgCiH3mPtYJ+Q+hqhWboe2RM28Ec+COnjBP6nk1miRg9GlUtDSfBiTYdUMhonqLpDBwXwOzdgpVm+RdbdhyC/wx2NQiJkhh38z1rrs/Tvus5V7bpagDG3mrbT+0VE/1rso2EegS/SuFlY6h5OaYN8MOAlv0klf776Q5neNpvqaN8n9tNpzlpeyPHbtP8VXHQ88sJ5sYVkyF8DonGfKUcGEKdFTbVOOjkhJUKYUCgPnykTd1bZn4r/lqWhj2hr5LXQdDB0j9rLsvoieZXbGr2O/L4AeRorYlx7KxiO99OrHJGTbjd4sqeloQqo8FXJEh2gRssxPlqMCbd7/DJOEc1h5ukx+yqraGb3UHz/IoaPx3YL0ftVJNJachKP8199cpuOU9GR+1ChoAJ318X3K4Rl/FVoJET8OkAiHbVoFb+i0+xS44oIWTPoa0oD+P6YxJr9bm/AyOs83/jm3EiSLrQhKx+UC0s2rTspwRXBF6dcEokkN5Oid+KkFmFpb0SxUIaoeIzLvorzSXKJ02Y12K4EA/EbGWEG/jWR+eCj1NETed1PKnonnMQkp9pOdm/OhlNThcGnOWLngYI3et7ZLtvZ0ShAX6wOnnRDjNGB6BSzwIH3zt7/bX9HXjhA==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(346002)(376002)(366004)(39860400002)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(8936002)(4326008)(8676002)(122000001)(71200400001)(53546011)(6512007)(7116003)(6506007)(86362001)(107886003)(33656002)(2616005)(2906002)(38100700002)(54906003)(5660300002)(478600001)(66446008)(66476007)(66556008)(66946007)(6916009)(316002)(64756008)(6486002)(76116006)(91956017)(66574015)(36756003)(3480700007)(41300700001)(26005)(38070700009)(83380400001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?VytrWW9OODU3cmZrdmt4aW5TQXJYblhoSUl3cTFVaFY2OVpJT0FSWmwvYjBH?=
 =?utf-8?B?TGhrRFg5Wi85eE0vcjUxVHlUeldnQ0pDVU1HTnVXb09hLy9aaHo0cXJXeGVD?=
 =?utf-8?B?QnVRRXFKdUVCUWVJM1M1bTNOOUFIUTFacG1PbllRb3lsRVNXVlIyS2FFbC9x?=
 =?utf-8?B?bmxCeVBTTFoxelRxUnlhMGNMWWkwWlBjWkx0K2FGRjY3d25zUUlkMlY5NkhW?=
 =?utf-8?B?WFZvSWJsbGNnaEZFY3htQi9ncFk2eXlvdHdqQ2Y2VmM0MzdsMUtWY3NGaU4z?=
 =?utf-8?B?eUw5R3lDL2dQZDZZRkk0VURIM0pWd1pzeDlITW5JeFI1OXZGZ3c3RllxcDNu?=
 =?utf-8?B?R2hoNWJxaTNLVGFFbGhKTmlqZFlHdFVtVHB1eVVMS3IwRGR6Skd3YnR1Zzlw?=
 =?utf-8?B?Q3BSeWp4ZTY1emNJZzhGK1J1dEY2dnZENFRqY2JqY016YmNoY2FTSkhkcHRt?=
 =?utf-8?B?WUs2NmlsZWdYcGMzTE9vM1dYazFrdlcxZWcxNzdLUENlSVp1UStNOVJ2YUNj?=
 =?utf-8?B?b0xORXhUMEdoZnMyZm0wRUxrb0w5OFNsbVJGUXQ4dHIzN3Q5N0ZobXhFRWxS?=
 =?utf-8?B?MG9kUUtNblY2c0VNS2hKcVJyaWc0NXhqRGl1OFZTS0c4TGc0cnR6ZHJneG56?=
 =?utf-8?B?SldBU3FURzR1UU1qTU1oQnE0NmRjY0RNMzJONjB5bzl5aUdlajZyaS9xOEN6?=
 =?utf-8?B?TmNxSDVDbkpoMjRkN3BwNEk1bFNBd3VXeSs3RmNCSjg2R0o2cFlrY1pkMW1y?=
 =?utf-8?B?T2dRNk9VYmJ2M2tQTm9sbkkxYThzTkZYclVCeE5XeklXL001Y2dObkRaSzNY?=
 =?utf-8?B?THJpMDA1bTVjZ3RsYWdqeUxIbWphUzdQdTRLRi9RenY4UnZnWis2NFVYVFRK?=
 =?utf-8?B?TG9rMkRTTWVUNXlDTmIvT0FJVklWOGwxLzFrRWJoVTZaWTM5VFFsRnQ1WnIz?=
 =?utf-8?B?NXpKZlVjcXAyQ3d2SEZEcUdaT21HZWdIOFQxTThGWGRPUFprNHNNYk5TU3hO?=
 =?utf-8?B?OWdXVm9TenBQbHI4N3Jic1pGNHhiSnpQUU1xZThDNG11SzhSdy9UWGh3SWgr?=
 =?utf-8?B?SWVoc3hCOWx5bnNOVjhTNGpiaTdxMzF4eHVBSU1GMm1QeEM3ZGRlZEpHUzNv?=
 =?utf-8?B?a2dkUnQ2QWMxWVJ2bjNNZ3B0bUJ1NUJ1dFZBVFFmaU5ONzczWWRtcGFKSnZU?=
 =?utf-8?B?Zk5GR3RWQ01zZUNhRjRVcGtBVTJwNWFJdE8rTXdkQWg5MnY5b0llQm5Bc2ht?=
 =?utf-8?B?dTZoZkJpUncrNC9MQkR1dzkvYTE1eWlvTTBLalljaERNT3ROcklHeUdUY0Ey?=
 =?utf-8?B?dUJJTEl1QkprblF3c0RDcER1Y2VhQ0RpVFZWWnM3Z2V6T2g5NGMvbGcvaDRS?=
 =?utf-8?B?ZldadXVHMkxuWkN0RUFPUlp2TkRoOFprWGxvcnZINkhDTGxpSGJqQkVMOUFM?=
 =?utf-8?B?c0V5SVJiOUEvTlordHNYVkVOclZ1cDl6bGRYa292M3ZNRWRpNEtJTUtsbnk0?=
 =?utf-8?B?ZTRKaFJyMWhZb2JmQ1BoNUppamNLbGc3M0RoVVdWMTdRSTRBalVkcjRPdXo2?=
 =?utf-8?B?N0hTYUNEZGs3NDdxMXNSdHdhSER1VXZvZEkwZmxRQW5FYVJVUDFxdHREOHNI?=
 =?utf-8?B?QXhPdHFyMlFDQXorYisxeFpvaDRCSVJod01MdFhCenVTQ1pWMmFvMWxzOTR0?=
 =?utf-8?B?ODN5UithOS9kM2pCQ2w1UExPd09vU3JlVmxUUWxnNmVtRk5hOVJia0dpdW4v?=
 =?utf-8?B?MTB0V3prRFFHMHgzVVRDRVN6ZGlSWGlzMVJMZEtSZUZreEJLemNZRXFPSmlr?=
 =?utf-8?B?MVN2NTN6SE04aEtydmFwMWV4a280K0dEc0xGenhiUWkrZ2NCZjdqOHBaVnRZ?=
 =?utf-8?B?NGlNdDNZTlU3eXdZWnEzUy9OREYwWUpjVDhXcGJBRURtRXNBZHlsU3dFMjZI?=
 =?utf-8?B?WWR3VlJMWU9pd1lmcU8zT1JpVTFYYmNwRS8yRTVBUERwNjdEazRlb1dvQ1dy?=
 =?utf-8?B?b21laDd3eUxybVpnUHRld1JKc1B5RVdWL2pxc3F6c0gyWXloRFVDWVBlRjVZ?=
 =?utf-8?B?bzFvS2xYUzVwZkRPaFpTenFRNG9nVGNyWlN1bXFkaDF6dmo2ckhIeC9NTldM?=
 =?utf-8?B?NTNOWThuZUdyTEZxMjhkQ3lPSXhiNkNWUUd2cVhNZ1dmSFVuS01PbjZ3Mys0?=
 =?utf-8?B?amc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7D49226F48C67D4F830BE99CB9D576C2@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	2zxzJHQ9f6YznryKx/fH0UgToM900gXGExUHOmZfMU6fpBrP+Q7j90xPb7vD6Eqz8byh9MF9yQ7Di4tLAZxCjdneIFWB/c071ldWhV/6TdN2FvgW01/t6rHGe6rjZ+GwdG7aN+MwzCRxaTbwjqeljBZ7O8Tpa0GhuzQxMk9swJt6jmtcEVOaIkKHzckE7y8Z+/00xQa68O9pfscKTuW72SOIIS60I7HDqmSfnReK3AeppjYyMY6boKjZYSiXvo/KWl/JAVh9NUvacqV2Japi/hZTAXnQTY5sLE1JtTQJThzx2aBB5aIVmvSvnqB+oeHXiTaQQDlHSDu/CsXiOKxGJomDjXIaSs881kS8MykU+KULBZL7NXqrmdC0j4T1yYZA/3y/hxr6DjLu5v2TpXlAaZ3qsh6xuZUJmjM4XR0N943GCTqfhnrcd/r6C4cZDleWVxccgD282Waktv+FFKIipdhrq4hh27l8SWbI9kxaeCIGNbz7AvZAuvjnPTyptvSHctQWRfEc4ZXLW07IVWLD9bFk16l37VRNh62/11bTDqAFLMIKeuF1nA1ARayILNMk8Ny/XdlPOsge1m7A8CJN2azQ59v8BLuFW3a2IWQngYM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92483128-be15-4119-cfed-08dbfce0fcee
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Dec 2023 20:12:24.9356
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: p5ff2iwIWZUJOJMctp86kXy7CTvwhs2FCyHAb9zRM863GuQ1da9i16b1jFTlLiMvf6SGylOkFrjpTmbonovlTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5302
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-14_13,2023-12-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0
 mlxlogscore=999 adultscore=0 phishscore=0 suspectscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312140143
X-Proofpoint-GUID: GSLob4lXSUA3uP97osQN_bzxJ507ZAup
X-Proofpoint-ORIG-GUID: GSLob4lXSUA3uP97osQN_bzxJ507ZAup

DQoNCj4gT24gRGVjIDE0LCAyMDIzLCBhdCAyOjI44oCvUE0sIEplZmYgSHVudGVyIDx3amh1bnRl
cjNAZ21haWwuY29tPiB3cm90ZToNCj4gDQo+IE15IGFwb2xvZ2llcyBpZiB0aGlzIGlzbid0IHRo
ZSBjb3JyZWN0IGZvcnVtIGZvciB0aGlzIC4gLiAuDQo+IA0KPiBPdXIgY3VzdG9tZXIgZGVzaXJl
cyB0byBoYXZlIEludGVncml0eSBNZWFzdXJlbWVudCBBcmNoaXRlY3R1cmUgKElNQSkNCj4gdmFs
dWVzIGZvbGxvdyBhY3Jvc3MgTkZTIG1vdW50cy4gIFRoZSBsaW51eCBrZXJuZWwgbm93IHN1cHBv
cnRzIHhhdHRyLA0KPiBidXQgb25seSBmb3IgdXNlci4qIGF0dHJpYnV0ZXMuICBXZSd2ZSBtb2Rp
ZmllZCB0aGlzIHRvIHN1cHBvcnQNCj4gc2VjdXJpdHkuaW1hLCBidXQgaW4gZG9pbmcgc28gd2Un
dmUgbm90aWNlZCB0aGF0IHRoZSB4YXR0ciBzdXBwb3J0IGluDQo+IE5GUyBpcyB2ZXJ5IHNwZWNp
ZmljIHRvIHVzZXIuKiBhdHRyaWJ1dGVzLiAgV2FzIHRoaXMgZG9uZSBmb3IgYQ0KPiByZWFzb24/
ICBJcyB0aGVyZSBhIHJlYXNvbiBzZWN1cml0eS5pbWEgd2Fzbid0IGluY2x1ZGVkPw0KDQpJIGxv
b2tlZCBhdCBJTUEgc3VwcG9ydCBvbiBORlMgYWJvdXQgNSB5ZWFycyBhZ28sIGluIGNvbmNlcnQN
CndpdGggdGhlIExpbnV4IGludGVncml0eSBjb21tdW5pdHkuDQoNCk5GUyB4YXR0ciBzdXBwb3J0
IGlzIG9ubHkgZm9yIHRoZSB1c2VyLiB4YXR0ciBuYW1lc3BhY2UuIFRoZSBvdGhlcg0KbmFtZXNw
YWNlcyBzdG9yZSBzZWN1cml0eS1yZWxhdGVkIG9yIG5vbi1zdGFuZGFyZCBpdGVtcyBhbmQgdGh1
cw0KcmVxdWlyZSBzcGVjaWZpYyBORlMgcHJvdG9jb2wgZWxlbWVudHMgdG8gYWNjZXNzLiBUaGUg
c2VtYW50aWNzDQpvZiBub24tdXNlciB4YXR0ciBjb250ZW50IGFuZCB0aGUgYXV0aG9yaXphdGlv
biB0byBhY2Nlc3MgYW5kDQptb2RpZnkgdGhhdCBjb250ZW50IG11c3QgYmUgc3BlbGxlZCBvdXQg
aW4gYW4gSW50ZXJuZXQgc3RhbmRhcmQuDQoNCklNQSBoYXMgbm8gc3VjaCBzdGFuZGFyZC4gQnV0
IHdlIGRvIGhhdmUgSW50ZXJuZXQgc3RhbmRhcmRzIHRoYXQNCmRlc2NyaWJlIEFDTHMgYW5kIFNF
TGludXgtcmVsYXRlZCBjb250ZW50LiBUaG9zZSBpdGVtcyBjYW4gYmUNCmFjY2Vzc2VkIHZpYSBO
RlMsIHRob3VnaCBub3QgZGlyZWN0bHkgYXMgeGF0dHJzLg0KDQpCZWNhdXNlIElNQSBpcyBwYXJ0
IG9mIExpbnV4LCBpdCBpcyBjb3ZlcmVkIGJ5IEdQTC4gVGhlIE5GUw0KcHJvdG9jb2wsIGJlaW5n
IGFuIElFVEYgc3RhbmRhcmQsIGlzIGNvdmVyZWQgYnkgdGhlaXIgbGljZW5zaW5nLg0KQ29udHJp
YnV0aW5nIHRoZSBwYXJ0cyBvZiBJTUEgbmVlZGVkIHRvIHN1cHBvcnQgaXQgaW4gTkZTIHdvdWxk
DQpoYXZlIHJlcXVpcmVkIHF1aXRlIGEgYml0IG9mIGxlZ2FsIHdvcmsuIFRoZSBhbHRlcm5hdGl2
ZSBpcw0KaW52ZW50aW5nIGFuIElNQSBtZXRhZGF0YSB0eXBlIGZyb20gc2NyYXRjaCB0aGF0IGlz
IG5vdCBhbHJlYWR5DQpHUEwtZW5jdW1iZXJlZC4NCg0KRnVydGhlciwgTkZTIHNlcnZlcnMgYXJl
IGNvbnNpZGVyZWQgdG8gYmUgdW50cnVzdGVkIHN0b3JhZ2UuIEFuDQpORlMgY2xpZW50IHJlYWRz
IGZpbGUgZGF0YSBpbiBzbWFsbCBwaWVjZXMuIFRoZSBkYXRhIGluIGVhY2ggcGFnZQ0KcmVhZCBm
cm9tIGFuIE5GUyBzZXJ2ZXIgbmVlZHMgdG8gYmUgYXR0ZXN0ZWQgb24gdGhlIGNsaWVudC4gVGhl
DQpjdXJyZW50IElNQSBtZXRhZGF0YSB0eXBlcyBkbyBub3QgYWRlcXVhdGVseSBzdXBwb3J0IHBl
ci1wYWdlDQphdHRlc3RhdGlvbi4NCg0KSWYgeW91IHdhbnQgdG8gYnVpbGQgYSBMaW51eC1vbmx5
IGltcGxlbWVudGF0aW9uIG9mIElNQSBvbiBORlMsDQp5b3UgY291bGQgZG8gdGhhdCBieSBjb25z
dHJ1Y3RpbmcgYSBzaWRlIHByb3RvY29sIGZvciBhY2Nlc3NpbmcNCnRoZSBzZWN1cml0eS5pbWEg
Y29udGVudCB2aWEgUlBDIChpZSwgb3V0c2lkZSBvZiB0aGUgTkZTIHByb3RvY29sKSwNCnNpbWls
YXIgdG8gdGhlIHdheSBORlNBQ0wgd29ya3MgZm9yIE5GU3YzLiBBbnlvbmUgY2FuIGNyZWF0ZQ0K
dGhpcyBraW5kIG9mIFJQQyBwcm90b2NvbCwgd2UganVzdCBjYW4ndCBtYWtlIGl0IHBhcnQgb2Yg
dGhlIE5GUw0Kc3RhbmRhcmQgZWFzaWx5Lg0KDQpZb3Ugd291bGQgdGhlbiBuZWVkIHRvIGludmVu
dCBhbiBJTUEgbWV0YWRhdGEgdHlwZSB0byBzdG9yZSBhDQpNZXJrZWwgdHJlZSBvciBzaW1pbGFy
LCBvciBtYXliZSBqdXN0IHRoZSByb290IG9mIHN1Y2ggYSB0cmVlLCBzbw0KdGhhdCBORlMgY2xp
ZW50cyBjb3VsZCBhdHRlc3QgZWFjaCBwYWdlIGFzIGl0IGlzIHJlYWQgZnJvbSB0aGUNCk5GUyBz
ZXJ2ZXIuIElmIHlvdSBkb24ndCB3YW50IHRvIGRvIHRoYXQsIHRoZW4geW91IGhhdmUgdG8gYWNj
ZXB0DQp0aGUgd2F5cyB0aGF0IGN1cnJlbnQgSU1BIG1ldGFkYXRhIGlzIHZ1bG5lcmFibGUsIG9y
IGFjY2VwdA0KcGFpbmZ1bGx5IHNsb3cgcGVyZm9ybWFuY2UgYmVjYXVzZSB0aGUgd2hvbGUgZmls
ZSBoYXMgdG8gYmUgcmVhZA0KZWFjaCB0aW1lIGFueSBwYXJ0IG9mIGl0IGlzIGFjY2Vzc2VkLg0K
DQpUaGUgY29tcHJvbWlzZXMgYXJlIG1hbnkgYW5kIEkgd2FzIG5ldmVyIGFibGUgdG8gZ2V0IHRy
YWN0aW9uIGluDQp0aGUgTkZTIHN0YW5kYXJkcyB3b3JraW5nIGdyb3VwIGZvciBzdXBwb3J0aW5n
IGl0LiBJZiB5b3VyDQpjdXN0b21lciBjYW4gbGl2ZSB3aXRoIHRoZSBjb21wcm9taXNlcywgdGhl
biBwZXJoYXBzIHlvdSBjb3VsZA0KaW1wbGVtZW50IHNvbWV0aGluZyBsaWtlIEkgZGVzY3JpYmUg
aGVyZS4NCg0KDQotLQ0KQ2h1Y2sgTGV2ZXINCg0KDQo=

