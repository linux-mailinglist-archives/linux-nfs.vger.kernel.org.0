Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86AD145882D
	for <lists+linux-nfs@lfdr.de>; Mon, 22 Nov 2021 04:01:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234187AbhKVDEy (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 21 Nov 2021 22:04:54 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:64628 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229870AbhKVDEy (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 21 Nov 2021 22:04:54 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AM2RBi0000615;
        Mon, 22 Nov 2021 03:01:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=w1uBLbmadqvKCF29gHkZAdNIUXmlxImSC5ge3FnO9F4=;
 b=p+wBEMFj4N1OADwJNkWOJ60aOB5TpxDQT5WrYvcpP15G8xN/OwmAkhpTXebPBPo2tqpQ
 NKwqFjI6iBBOCTt4F/Ea+2gnMhqbKMfjrM2ykUcNFHkFvOVcJsP5OE8+QqkjeQgBVpSj
 xIdt9L5UuMoE6pWnz/JsRSna6yBdjz90zcwsu6C2xYyZ60CHy66bEfaKGOa1z+vgbO8H
 vOqThZdaqBz+tx1OMDTxmVRCpVFF2BavpALF4rbgjuMFjx3zipyWJPsm+96F0AKtXhNo
 yI+uqdGlHSCXdpUzzzzz+APAtlTlVRhp+2+6inx2e9OgZqqHx0zsqi6Z7hKpVyHLT1Qw uQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cermsncj8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Nov 2021 03:01:46 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1AM2uhLt024563;
        Mon, 22 Nov 2021 03:01:45 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2105.outbound.protection.outlook.com [104.47.70.105])
        by aserp3030.oracle.com with ESMTP id 3ceq2by3ab-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Nov 2021 03:01:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fDopgOhNHiyJN+kYkRSkVQOOLn/G8e3udLLFlMYKgD3aa5zKp16c8X4GGmu2SuVJ3Q8HX/Jc7Uo4pGsHXYtUQJJaDGRil1P3QimjD/ZszdcYSiqfpa0NumzLzkqqW/ebHVR3gGQRW/TdZ7cipMO4gzgtTFGZBejisHu1qaVtPaHo6vsQ2Hg3f+q3MCWHeBU3ch6ggolSx+7xowXAws+9L1O1WFIwGDCOFGHjq0WzMlv57mP0JzCn7pbZdObwjoWArf09UTsD01SCx1o6aOFaZp3Y2BkDkbdRzQ+lUTQT7z0lWQyTcX19QiPep8A2taeP3Z4J0KN68MpAsICX2U1zsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w1uBLbmadqvKCF29gHkZAdNIUXmlxImSC5ge3FnO9F4=;
 b=dU6f5I85y/vgg3udZChzKRpNA3NOioAHJmONSwrf31pdcFCBVedLKdmIYJGk94Kxo6q824/laTrU2pjVwyCVfYzr0Ubm6iaj1v6+u0XmDOOptVqCDwr/xOR+lID07lOfIQlblL0iYlzIKWry+ZPHGfuc4Jpc+FOIP3sEgZFs4ni1hu7dTJz817XznYzjqMfkNtGzuYE/yiPr/561crPV7M4Ao1mM0imDy3tfeFvsHuRYAcGfKvzwWOt/6wOFVR8HlVeEf6SUqOM39KEkUqoKx2l7XgkMjmC33LFWljk0L+mD2Kj3f18YTWvphDrAXcYWeMbOBrmmGoRJ0Whh5Zp2cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w1uBLbmadqvKCF29gHkZAdNIUXmlxImSC5ge3FnO9F4=;
 b=hayU38cR4e9u2LDvWLfaMXb+ERkYR8HKmjYx7lrWHRu/zwEKtczDGZLN++mcDvxWxphgLZuNbh5+JCa9yvTJkkyDUqTYlvth//0B9ZzTh/ADyWFP2SqrmjH0yYgiOJVhYN1KD5lsMo+4EqihkIBh1ZOeYPq1vFxFyCdqh00ryHA=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by SJ0PR10MB5663.namprd10.prod.outlook.com (2603:10b6:a03:3da::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.26; Mon, 22 Nov
 2021 03:01:44 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::48f2:bb64:cb4b:372f]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::48f2:bb64:cb4b:372f%7]) with mapi id 15.20.4713.024; Mon, 22 Nov 2021
 03:01:44 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     "paulmck@kernel.org" <paulmck@kernel.org>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] NFSD: Fix misuse of rcu_assign_pointer
Thread-Topic: [PATCH] NFSD: Fix misuse of rcu_assign_pointer
Thread-Index: AQHX3xH+VHtNadGKjEGmHrkZAM4DQ6wOyukAgAARgj8=
Date:   Mon, 22 Nov 2021 03:01:43 +0000
Message-ID: <087F6190-00D5-429F-94FD-EB8459635728@oracle.com>
References: <163752463469.1397.703567874113623042.stgit@bazille.1015granger.net>
 <20211122015904.GH641268@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20211122015904.GH641268@paulmck-ThinkPad-P17-Gen-1>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1d5f2bbb-2602-4d61-d841-08d9ad646a42
x-ms-traffictypediagnostic: SJ0PR10MB5663:
x-microsoft-antispam-prvs: <SJ0PR10MB5663734094E85F3CDDD35A06939F9@SJ0PR10MB5663.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IlQRUJcAlc3KCKpVoYWmR8FBT5RV8fsNkY/teXYAIF17Lyl+zfhScvQqwpgpdN3/FnHkhfYXlhtBkfXpE7YCg5TvJJVR4Xoxcp/b517Jmf1IuttSUCJR8gyKPg4xEbSgrsfRvDRrl77wC5+6For3wAFU/4wL7+ujhJT9CYyRFAnLbYuZasQSg/HJcs1BEk2F6EmLez6aUbjJIfF6y8iBv+rWF/a7v4OrWyTdfGIFcfh6Ccr+8fdedXkjCgwh/CPRN6tKXduCXfbDpUN6a2VFE8/5UqTezlesklzd2Z63+/JiZ4BKmpVhRSFrnsMoIBaVUHua2wy9eGPF0qnhpM+CdhPn+uxbFHQLFQYaqjgozBA9spa7UPaywyct+VCxdu+q1Yr88+Ac2UdSFKST8HN2zrqnO3Eay57SFqiJMsJF+MrlcAQ5Fgrl33szLpqIfIyJhDvaIXkcuL9Mc5pQbisJtWqqJ1aP87StJRv/70qish0blNchsTCt2R4RBOJJ/bOCFRX2iwIh7Xg4GV3oZQmqEEujt2dmuKVw8sCEIbVg0jtDZYk44VGwRgvRyIGGQ9mHQ253kn/bvkUkIxa0WXGiJyeIj8tEwI7SXvhNfAK6mcqE6EXhvRf/WXZQLEjO9zMv/vu3zZiVCvskSCDquV/iD7bOKF6r4OATH7nV0Sd6blI2yrA8xSCHePnsOgKfHVlLuX5hR/5H7wGFOi1UIeQtCVJKQK6IqElJ4+j4OGSZcCC85jKggerXxLUVYQ80AXmYcYJ6jGLHPPKbG1Ty77pDJIjibmdbv5VrxSwIVVLFxByjTS+DNgqGvW8JmHXPPS16GaXbJG0nezBm2QXLmCUYJFztWG/Vt6quFG6N1THk6qU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66446008)(91956017)(2906002)(6486002)(8936002)(66476007)(64756008)(316002)(33656002)(71200400001)(8676002)(36756003)(6506007)(66946007)(38070700005)(6916009)(966005)(5660300002)(83380400001)(53546011)(6512007)(38100700002)(2616005)(186003)(122000001)(4326008)(66556008)(26005)(86362001)(508600001)(76116006)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MG0vZ3lBNDVDdXRjR0JmVkZaSnNLVVBUY1RkSkxoc3lyQXgzVmdxNkRnMm55?=
 =?utf-8?B?aXg5L09wQ2RVS2FrY3FBWmowNkExT1pRaWk0WWtRVlE0RHJQckVwaEpWc3RT?=
 =?utf-8?B?VlRod1diY0R4V042NUdpMG5lOEJGbEMybEkrM3RLUUoxaldWaXppTnU2YkJY?=
 =?utf-8?B?THBCemhRbkhUbnRzOXNINzdod0ZPNmp3UlliejZXYzZWa2JOMGFyMml1bTlQ?=
 =?utf-8?B?bGRZb2F3MS9uNmF1azNkNUN0NU9UMm1rWFdyNEhjQWc4RS82bXF6eVZCOTF4?=
 =?utf-8?B?Y1VmZVY0blBYaFZOVHI0YWtiUitBYXhXNTJyWWZGdExrWjdlQytETmtGOXpy?=
 =?utf-8?B?am8yK3ZLMFlPa0V3eWlYdnBzQ21YRHgvejJPRW5BR3ZobnQvTUpHVWV6YktV?=
 =?utf-8?B?b1BMeklabWcvSlBTa1ZDQ0hjZXJ1RW14akxjU3A3V1pzMitFQ0hiM2MwdGxT?=
 =?utf-8?B?cXJCbHhuclRRcUxOa1JyeUpkdWx4RDNBMXgzYlhpYkpoMXdJYy9pYlRTYkxG?=
 =?utf-8?B?czhnU0NpMGNNSnNnZGl0ZitqVXVRUHU3cCsrTm9CMmFxbHM1dXRRT2NiQ2Nw?=
 =?utf-8?B?NVN0aThNd2o5dHQvelV2TENGWU9jNGUwLzMzVHg4RmRNYkVsajUzdGVwbXFy?=
 =?utf-8?B?cm1YcWI1dTEwN2gyUXRGdkI0SWYyVE92dEZ4dUpPcUcwV25HMUViVkpFRFlr?=
 =?utf-8?B?WU40eXB1bkpaQWR3T3J3cWVqSUQwWXJ4SjZ4Qk9qU3BlYnZmNWlEQisxdCtq?=
 =?utf-8?B?ZmEveTBZOElDMlhSLzh6NExFWGdva2dHc0EvNXVCOUYwNGZZc2lvNm8vcDFX?=
 =?utf-8?B?VmxYNHpvL1VtV1FtUWVLWFhaL0ZBQmFJdkVLeEo2eWtIdkdnUHNyS2J2YnBO?=
 =?utf-8?B?L05Rc2hEWmtQMTRrcm94Zzd2YnhBK1FuMUNoYWxIdnBsMXJDQjkwblNYQ2Rw?=
 =?utf-8?B?YlloN2cxTVFRRk52NXVUVGw4TmtEQUtNWWZwT3ViNlg4OEhKa0ZIb2tRdzV5?=
 =?utf-8?B?aWNSMFJzbEowdWR0WXFNRlZjbjF3NGcwaVo3WEhuWFpxb3RJVVhoSUQ1TjlY?=
 =?utf-8?B?VEE5QmNycTJtYU55Y1RlZzlKSDVJYVlzd2dnVzBRMmlnclpFZno4ZW8zamVY?=
 =?utf-8?B?cHJBRVZ6eWVMYkJha2NzYW5iZ3dXZVk2LzRGeHkxSWM1OUxFYWozbkN6MUVU?=
 =?utf-8?B?QlFRWGs4UHZpaHN6SU94cVRKbkU1WVhFUTNTMmJsR0RCbG1hOU5mMFNDZndl?=
 =?utf-8?B?S3BnTXgrQlA5OXlxdHExeTBST0QxQXQ5NHFGb1R3OFQxUlpIVWp1QjhCTkNU?=
 =?utf-8?B?UThmcmkvQzlIcW9XWjdZV3didk9KdFpjYzVmRE8yLzAvN3dVcFRSbXJXbUpU?=
 =?utf-8?B?MVI4RVFHU2J1Wjk0T3hQM216eElrMkFJZStYUkV2NkFmeHhSUDc5cXRMNEht?=
 =?utf-8?B?WVJkcFNId1l3VUh5RW41Q3QzSnB6RkFFWld6RDV0NzdQYUthWUJmWXl5U0Ux?=
 =?utf-8?B?TGg1K3JqZWt2QVk3bjZmRUdJeVBwTzVsNHlnaVJxZnBvZWRMSUE1cHhoT0FF?=
 =?utf-8?B?ODA4ZnNFU1FRL2MzNWY3aFdOME1JUUFKY2VtcHpWTVZ6SFh0VkhTaVlLeGls?=
 =?utf-8?B?ZWdjcVZGWExGaHpwdkNjanVpdGRnbnlHbWNiYUZUMlRwam5rRmp0MDJjSGZ6?=
 =?utf-8?B?UVcvaGd3TlFpMStWb3VOQlBXbXQ4ajNuOVl5akFOVGx6b2xRbDEwMjJ2REFW?=
 =?utf-8?B?a1JFaDlLeHZBN00vVWExMWljUmQ3QWFpZFB2RmtMeUlQU2RDSFY2QlB0blJF?=
 =?utf-8?B?MGJYT0dVclR4S3J4eE9UYVNwbWFQNUxVRmFjSk9WWHdQN2NUM2tPTkdZdE9m?=
 =?utf-8?B?UlpLanJTeVJZWERCOGhyYk9wZ2JKWmZ6SkhBVSs4OEtKdHg2Vy9BMWVMaGRG?=
 =?utf-8?B?N2RKU1VUZ1pySGl1QzhDWnNQQUdlK3dOUjlYUmZXdnRhSjVZQldsZFZpTnhn?=
 =?utf-8?B?eVNsOThTWklIL0pwU2hjSmhFVTQyeVVUTGpHSW1aU3dSeXVVMXNDbHFTNElM?=
 =?utf-8?B?VU0zWXVxWUk0dGhNemRua3JFOWM5bU1XNWY4NnovTGF1WXRzdjh3bGpsOCtY?=
 =?utf-8?B?MzNENklwZWF3aGEwT0hPRVFHSm44SkdUOTI2RCtMa3dMYmJ6K0xXZ2FxaWxM?=
 =?utf-8?Q?X83r4451BRxaLICfSAhEnS4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d5f2bbb-2602-4d61-d841-08d9ad646a42
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Nov 2021 03:01:43.9969
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QP0Lm8Dhb72M/PyQ4VT34/WBX9LauzU4KkNF1kEo4/uD38MtdR2ZKh3eWFGNbz2/0Rd2y/aAmrfwl4WSudYRKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5663
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10175 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0 spamscore=0
 bulkscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111220015
X-Proofpoint-GUID: 1LvIbhn2uM7p9pyB10WYMmDtVkgDCTuD
X-Proofpoint-ORIG-GUID: 1LvIbhn2uM7p9pyB10WYMmDtVkgDCTuD
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

DQo+IE9uIE5vdiAyMSwgMjAyMSwgYXQgODo1OSBQTSwgUGF1bCBFLiBNY0tlbm5leSA8cGF1bG1j
a0BrZXJuZWwub3JnPiB3cm90ZToNCj4gDQo+IO+7v09uIFN1biwgTm92IDIxLCAyMDIxIGF0IDAy
OjU3OjE0UE0gLTA1MDAsIENodWNrIExldmVyIHdyb3RlOg0KPj4gVG8gYWRkcmVzcyB0aGlzIGVy
cm9yOg0KPj4gDQo+PiAgQ0MgW01dICBmcy9uZnNkL2ZpbGVjYWNoZS5vDQo+PiAgQ0hFQ0sgICAv
aG9tZS9jZWwvc3JjL2xpbnV4L2xpbnV4L2ZzL25mc2QvZmlsZWNhY2hlLmMNCj4+IC9ob21lL2Nl
bC9zcmMvbGludXgvbGludXgvZnMvbmZzZC9maWxlY2FjaGUuYzo3NzI6OTogZXJyb3I6IGluY29t
cGF0aWJsZSB0eXBlcyBpbiBjb21wYXJpc29uIGV4cHJlc3Npb24gKGRpZmZlcmVudCBhZGRyZXNz
IHNwYWNlcyk6DQo+PiAvaG9tZS9jZWwvc3JjL2xpbnV4L2xpbnV4L2ZzL25mc2QvZmlsZWNhY2hl
LmM6NzcyOjk6ICAgIHN0cnVjdCBuZXQgW25vZGVyZWZdIF9fcmN1ICoNCj4+IC9ob21lL2NlbC9z
cmMvbGludXgvbGludXgvZnMvbmZzZC9maWxlY2FjaGUuYzo3NzI6OTogICAgc3RydWN0IG5ldCAq
DQo+PiANCj4+IFRoZSAibmV0IiBmaWVsZCBpbiBzdHJ1Y3QgbmZzZF9mY2FjaGVfZGlzcG9zYWwg
aXMgbm90IGFubm90YXRlZCBhcw0KPj4gcmVxdWlyaW5nIGFuIFJDVSBhc3NpZ25tZW50Lg0KPiAN
Cj4gSSBhbSBub3QgaW1tZWRpYXRlbHkgc2VlaW5nIHRoaXMgZmllbGQgaW5kaXJlY3RlZCB0aHJv
dWdoIGJ5IFJDVSByZWFkZXJzLA0KPiB0aG91Z2ggbWF5YmUgdGhhdCBpcyBoYXBwZW5pbmcgaW4g
c29tZSBvdGhlciBmaWxlLg0KPiANCj4gSG93ZXZlciwgaXQgZG9lcyBsb29rIGxpa2UgdGhpcyBm
aWVsZCBpcyBiZWluZyBhY2Nlc3NlZCBsb2NrbGVzc2x5IGJ5DQo+IHJlYWQtc2lkZSBjb2RlLiAg
V2hhdCBwcmV2ZW50cyB0aGUgY29tcGlsZXIgZnJvbSBhcHBseWluZyB1bmZvcnR1bmF0ZQ0KPiBv
cHRpbWl6YXRpb25zPw0KPiANCj4gU2VlIHRvb2xzL21lbW9yeS1tb2RlbC9Eb2N1bWVudGF0aW9u
L2FjY2Vzcy1tYXJraW5nLnR4dCBpbiBhIHJlY2VudA0KPiBrZXJuZWwgb3IgdGhlc2UgTFdOIGFy
dGljbGVzOiBodHRwczovL2x3bi5uZXQvQXJ0aWNsZXMvODE2ODU0IGFuZA0KPiBodHRwczovL2x3
bi5uZXQvQXJ0aWNsZXMvNzkzMjUzLg0KPiANCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAg
VGhhbngsIFBhdWwNCg0KVGhhbmsgeW91LCBQYXVsLiBJ4oCZbGwgbG9vayBpbnRvIGl0Lg0KDQoN
Cj4+IFNpZ25lZC1vZmYtYnk6IENodWNrIExldmVyIDxjaHVjay5sZXZlckBvcmFjbGUuY29tPg0K
Pj4gLS0tDQo+PiBmcy9uZnNkL2ZpbGVjYWNoZS5jIHwgICAgMiArLQ0KPj4gMSBmaWxlIGNoYW5n
ZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+PiANCj4+IGRpZmYgLS1naXQgYS9m
cy9uZnNkL2ZpbGVjYWNoZS5jIGIvZnMvbmZzZC9maWxlY2FjaGUuYw0KPj4gaW5kZXggZmRmODlm
Y2YxYTBjLi4zZmExNzJmODY0NDEgMTAwNjQ0DQo+PiAtLS0gYS9mcy9uZnNkL2ZpbGVjYWNoZS5j
DQo+PiArKysgYi9mcy9uZnNkL2ZpbGVjYWNoZS5jDQo+PiBAQCAtNzcyLDcgKzc3Miw3IEBAIG5m
c2RfYWxsb2NfZmNhY2hlX2Rpc3Bvc2FsKHN0cnVjdCBuZXQgKm5ldCkNCj4+IHN0YXRpYyB2b2lk
DQo+PiBuZnNkX2ZyZWVfZmNhY2hlX2Rpc3Bvc2FsKHN0cnVjdCBuZnNkX2ZjYWNoZV9kaXNwb3Nh
bCAqbCkNCj4+IHsNCj4+IC0gICAgcmN1X2Fzc2lnbl9wb2ludGVyKGwtPm5ldCwgTlVMTCk7DQo+
PiArICAgIGwtPm5ldCA9IE5VTEw7DQo+PiAgICBjYW5jZWxfd29ya19zeW5jKCZsLT53b3JrKTsN
Cj4+ICAgIG5mc2RfZmlsZV9kaXNwb3NlX2xpc3QoJmwtPmZyZWVtZSk7DQo+PiAgICBrZnJlZV9y
Y3UobCwgcmN1KTsNCj4+IA0K
