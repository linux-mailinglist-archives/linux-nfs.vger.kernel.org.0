Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59BD7471FED
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Dec 2021 05:21:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231650AbhLMEVz (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 12 Dec 2021 23:21:55 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:23878 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231649AbhLMEVy (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 12 Dec 2021 23:21:54 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BD4LWWI026648;
        Mon, 13 Dec 2021 04:21:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=/CVP3PdOHMENA9P1Zl8WI+IbzLX/VKnF3ce4Y8X/fgQ=;
 b=FNzFfraLigoDxKmadsqGqbHDoUHIGE8k8Yb7sfR5r+eadmm0gRp0BoRO5GFm+WxHoFSc
 n9HE7NJP5XfrhjglbjrkdomZ8g/gQO1vtBzIXXU6RzWu2FGplAK4O0Gkk7Vt9TJLeGrV
 ZPrIHDSh+Qh5lTB3oW7O+YEmILFS7JbUETki/RnoAnayD2U+xf1nNeT8eaY9U00esawt
 yqOEYlTNh9BEK+HQnKVvrFdy/U1NixsP884yPtqTfKG+XQStzPfIthLqIn4FLCWRGhWn
 61V+bHEaFj5EEYPA8VmiiM4oj9LrmMeB7zbRtnk7dkqSoVBOvisd4l7Di34dnB/T7hjW hA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cvjs2ae85-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Dec 2021 04:21:45 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1BD4LUWh183484;
        Mon, 13 Dec 2021 04:21:44 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
        by userp3030.oracle.com with ESMTP id 3cvh3urhkj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Dec 2021 04:21:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lEvcWoA7UbYyLRkrSZaYTNPLNlYXadVPEOpXD/1IwlfoV4tSERCi3VDZvx9hTZKzoRAqAhSYlFl5/FmdybNOpeALpzdOugqj+Wkdd4CujJMtt6zyZt3EeU1FDfgwaeJ/gmZvIs+mF7Pf83E4OG1AGjN4M4kN9hDR5lUC0k9Q8VYpE118Zj+L3ab8hTbWzKePVv9DxPSFqVp6i2qvmgTLl43K+BqzKJ7aez8HrJy2toZJn2XFFM3Dv9rELlnZR/cA7V/8rCVfJqbK78/guI//XePunyCekXg+uUuChLnz8IyZTTyv5DTfNycvxgk0TVPhM/R/8oP7EfBKx5pCHsYlxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/CVP3PdOHMENA9P1Zl8WI+IbzLX/VKnF3ce4Y8X/fgQ=;
 b=fgErSd+rqT7zIsYf/VGWtb5m2TYroEzJ2dtreg1gJgyqia9KXY8us/f6WADO/UXHJaLc6AeKs7LSYCPGFpxGaAw1TWCvZ0oLFm+7qwl6lrLfiqeBooubNUUwXgDv/v3DE1oaIqHxT1J1DshOUKDWNV1y0EXKyhp+jWd2Uy+EHvDXaVlZNOoOhglipzBOlJS+tohspfnfL+mhOFvgccMebxgaUKVZERDpHCsvYjofU13HIlYH6IEwqgr1MgiNohdlmPM28TuPdftc3QkJMMv39zHE2a7EMudg62C5Mn2NmTqo48Bcx0Gw+dZD2F+iz7YYfq8DA4Abg7a/ZQIVesLH2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/CVP3PdOHMENA9P1Zl8WI+IbzLX/VKnF3ce4Y8X/fgQ=;
 b=hJx2ngG9ILzV9zyp5hoS12I4/r56BHzRvRssv6U7JigOAtEGQPzrORrfWlyoAKDfLJrFEmIsU++zQqZ5JIMhgecSk/tuiiVCdpszuVgx5igDVP0Xfl3YSaRxBp/uZgUXehtMWhUxvOjD05ylSLid4gL5/iPOaus8MNtTwxn4Ugo=
Received: from CH0PR10MB4858.namprd10.prod.outlook.com (2603:10b6:610:cb::17)
 by CH2PR10MB4149.namprd10.prod.outlook.com (2603:10b6:610:a7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.17; Mon, 13 Dec
 2021 04:21:40 +0000
Received: from CH0PR10MB4858.namprd10.prod.outlook.com
 ([fe80::ed9e:450f:88c8:853]) by CH0PR10MB4858.namprd10.prod.outlook.com
 ([fe80::ed9e:450f:88c8:853%8]) with mapi id 15.20.4778.016; Mon, 13 Dec 2021
 04:21:40 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Bruce Fields <bfields@fieldses.org>
CC:     "rtm@csail.mit.edu" <rtm@csail.mit.edu>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: NFS client can crash server due to overrun in
 nfsd4_decode_bitmap4()
Thread-Topic: NFS client can crash server due to overrun in
 nfsd4_decode_bitmap4()
Thread-Index: AQHX2NFEStLOh5EPHEGsmzKRU+63DKwB8uQAgAAFgQCAAAGpAIAt4ZkAgAAkkRg=
Date:   Mon, 13 Dec 2021 04:21:40 +0000
Message-ID: <4D63A33B-5E6C-4703-BD02-9E6D43782BD4@oracle.com>
References: <97860.1636837122@crash.local>
 <11B4530A-C0A0-4779-A9BA-F0E19B62C5A6@oracle.com>
 <20211113212544.GA27601@fieldses.org>
 <9A3E5D78-AE3C-4F45-8CB1-10F2EDA1D911@oracle.com>
 <20211213021048.GA20814@fieldses.org>
In-Reply-To: <20211213021048.GA20814@fieldses.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 82bf5048-33e3-4c49-3c0e-08d9bdf01012
x-ms-traffictypediagnostic: CH2PR10MB4149:EE_
x-microsoft-antispam-prvs: <CH2PR10MB4149D6E429AD65FF2A846FA893749@CH2PR10MB4149.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wPiKkA/gW65tDx5XrRV9hOAdk5H1CrVtA7KFtv9YcyfPEI8vW9yXmxqvDnMnDZ81tET+lB+NRn9RACsv5/AYweDTx16hq8EzkuLcLRYqapgJhKTP5yT/grf107w0D4nkyMVNhcOHayenDR6/B93OkbjMtqlf5MmjKPYccVAaEmDvh8awNopgjOG97GRmbwYcFs8xK6oWLY75B/qu4ybsz/M+/vPwd0hxASRcyHQRnv81vlgDAFzFQD6V9CbVc1TL7TWXGtsq22kx0JdYI5F7LH+zfe6R6xEAWNZDo/ohRazxmJyj778nnXtKwOHA59X6paRE6UT8UmEw6GDWQj3ZSExVUFkgEw/FzIS7sJMuZST3HoB5XdcIHJzHPHtbRlZViros7YGWm3qv1A5P+Q0AfQ5PYSwPQODmgk7dehWD4Poofy+b1DJpqZkGeniUl6mYJSz/uporFSoOSfCRnGoz6ShG6UMUGQ2PoBHPVL4Qr1ZOrE/NQG4QtMln88+vjFiy0O3n751yQIHWxfCATubABwXbHsJmBC5FHUIIlBNjf2T/qR/PapWq4R1DoOM6r/EVIHgaPZlBdjFmzVySrOH9Aq9eergovlK+Q6Y6vD8beTo1XIrUyPvCAeVd9x0VgbP1uiSIn+uTIFyTwvWla1S5CJ579PJKOcVLAZIpx1tDjjthTP+SUevE3oD22lY1mMUJr3+Pwp9Ax8XTvLG+ZYIbQ2VHqLygiYYgX4SRorfFv80QGKeqtkclAJ4tWGYiZYLD
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB4858.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6486002)(186003)(26005)(2616005)(2906002)(6506007)(71200400001)(4326008)(6512007)(76116006)(38100700002)(66946007)(122000001)(64756008)(66556008)(66476007)(66446008)(83380400001)(38070700005)(5660300002)(53546011)(33656002)(8936002)(54906003)(508600001)(36756003)(8676002)(6916009)(316002)(86362001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Qjgvb1l6dXFVYk9pVk5UR0VWeE40S2UwSkNEbFE3Wk9iU2dmclRxcHpKWkVr?=
 =?utf-8?B?TDN1c21OUFJwM0Q0UDFqVS9RRCtnQlVyWDdoR2xwR1pvajNpa2Ezd3JCMkM5?=
 =?utf-8?B?WUhyWGt3dHdQTmhpcjhLWW55eitZUWZvZEoycXpWUzJ0L3lqZjIxUU5BM2E4?=
 =?utf-8?B?dDVwSTZ6NGNVRHJjRlJUTmluUENaZnhERUk5SzliYllYZlh5Zis5cU5xckI4?=
 =?utf-8?B?OUlmaEVOazlCU3FaQWJ6bzlkYXhteXZrS3hWN0JCaEtzS3QrQSt5MTRseXJM?=
 =?utf-8?B?ejMvRVVDMUYvNnlPZ082Q0MxWXJ0SmUxK0d2S0V6bCt2UzFMdksxaGpFL2R1?=
 =?utf-8?B?Zjl3ejAwa3JoZlRTcTFyVFNYTnhPWnJSVUNGZUVTeWpza3FnaEUzelEyUHhR?=
 =?utf-8?B?V29qTnF0NzhJcGpoRUpkeEdNdUJ2T2JRSjVPMGRNRXJxYTRyRDdoUUZLK1h5?=
 =?utf-8?B?azQ4bUhYRm1zZDE4WFViRnd4dUZ0dXdhY2l4SjVneXl4d1RNcmZ3SHp5RkRJ?=
 =?utf-8?B?VUVSWllmcjc3T295V0tvMDBLcmJDZmVZT0dPVmJjeGJaZngvYXJvckl6aUxU?=
 =?utf-8?B?SkNNeGErWCtpRlhlVnJQTkVlL3orbUhaeEluZG0vMXJndEVJZjV2R3pqNGFS?=
 =?utf-8?B?UUxaaFczdC9BWnkrYlhkRzltbGRPbkNSV2FtY2lWeS9JeFVWMHhwUlFZaGRa?=
 =?utf-8?B?dFBPMnpDTEJzbkVhLzBocG5manNnNktEcXllaW12aWg3V0FJZlFvcmJoRzdi?=
 =?utf-8?B?OXBYNXRZdkNFQndxMGcyUXdRVmxwTUtRNmF4bkIvU3ppOHpwb3pvaE9jN3pS?=
 =?utf-8?B?dTRkOGs1eW5xUkpZMnVxR0dNTjdSRlN4U2hLdVhZOUZkdVk4WlY3NlQ1TUJi?=
 =?utf-8?B?Vys3RzduR1BXc0kwSDZTcEwzWlJtSWdERGlpcG56VXBkQ3pPVVZSN3VLYUhG?=
 =?utf-8?B?eUYrdXhRN1drWDB0ZlUveGU4VHpoNjBzWjBxUzNQcDVYU1FPU1ByMVMwTi9B?=
 =?utf-8?B?WXB2TGwxSzEyaG82S3N5Y2VCeUQ3T2UrYjE3bXQvL0JzblRUWlNiTEJKeDFh?=
 =?utf-8?B?UzhsNnNBaks3SmhYeFZwakx1NGNvcW02WExTb1RwbEFmMVRSYmRUTk5DT0Fo?=
 =?utf-8?B?TUlFclpNenM4eW92aEI4Q0tpakRKdEluQ2drOVBIMHBmY2szazR1N3ZNOE1j?=
 =?utf-8?B?eWZhRWNVblkramFqaWtOeUU5TkNiWHdHNEVzWlR0MWdpZWtZb1ZHc2ZxMEFJ?=
 =?utf-8?B?TnpJMFNiSFFuQkd3YldJdThKaUFWT1kxbGdBN1R1cjRKdFpnSmRydnBkOTZS?=
 =?utf-8?B?bkZGaDJtcVlmUnRTK1JrdGhtUGJsYkY4ZVR5c1U5VnhSUUZjM2lxdGNNc2l2?=
 =?utf-8?B?cUlLYmNpR3ZpWXlMNjF2L29GOTdhaWFHVm0vbVBqS0ZXZ24wVG5aMjZQU3Vk?=
 =?utf-8?B?bmMrTjNLcExKN2phYlRyU0d1S1hBMUtlZWtCZGszMUkyQmNyWmU0bHhwWnI3?=
 =?utf-8?B?V05Vck9PYjBQQ3hzS2VBL1dsU2tSWVczcVB4byttNC9INjU4dzk0RXZjTEFx?=
 =?utf-8?B?Mk53WGI4aE82dU5yd3lIVnJ6a0VIQ1d4K04yQnZkc3puVjc0cFFWcG5HSE5l?=
 =?utf-8?B?WEUvU1loaUFZU09xWTlzb1crRitXdEt4RzVQNUlyN24xVHRiRG5tNnJNSlBp?=
 =?utf-8?B?ai9GWkdtcE8reGNwTXJlT3pwaUFTR0EwMVNhSFlNdW1nQW1xQ3RtUFhDWC9w?=
 =?utf-8?B?TkRJdGxnOWZ6eTIxc3c0OW1DVm5BTk1aM1ZSQXdETVJsRXdTYks2QWZrNGFZ?=
 =?utf-8?B?aTErd0ZCZXlNL041SVNhWjc3UDY3WmVGZmRoMVlEN3RLdU42WGlVa3o1VFNY?=
 =?utf-8?B?ZGZXRXVMNVA0NVJFUTV4S1cwdElUL3k2S2JQcGtrckFxTTdkVjNLaURyci82?=
 =?utf-8?B?b252UVp6Y2FWeG9wV1BvbkdtYnpaanBvcXFjKzZqWWlpZ3BDT0lEdUhpYkxr?=
 =?utf-8?B?OVJ2WVVkY0s2NHhYWHpJMnRzR3lxWUhpYlpMTGdrMkRNQ3dFN20vUEpQRTEw?=
 =?utf-8?B?ZVZ4ZndIa1NxaGo2QndaWWk4NmM5WllYWHB0RVZYWUdSUkZlVXhEMUwvaGtx?=
 =?utf-8?B?STVYVzNyMW9YUnJ5US9GZ3l5OFBFbG11RjRUUTZEdGxmZ2Q2dzFXc2NsN1l0?=
 =?utf-8?Q?99VirAqoYClkYBAKkYRWdXg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB4858.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82bf5048-33e3-4c49-3c0e-08d9bdf01012
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2021 04:21:40.8285
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yJ7Yrt9bbUbWKcRc6Xjug25/q/djTxT4ynkvVW09YHGX+Y7Y/NMQ/LbnzzPYiLyo0LyCdiKs4/r8vrHsBRljSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4149
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10196 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=929 bulkscore=0 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112130026
X-Proofpoint-GUID: VVNe_w09CvJOq0cdWPVaf9FTPvWkkwhX
X-Proofpoint-ORIG-GUID: VVNe_w09CvJOq0cdWPVaf9FTPvWkkwhX
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

DQo+IE9uIERlYyAxMiwgMjAyMSwgYXQgOToxMCBQTSwgQnJ1Y2UgRmllbGRzIDxiZmllbGRzQGZp
ZWxkc2VzLm9yZz4gd3JvdGU6DQo+IA0KPiDvu79PbiBTYXQsIE5vdiAxMywgMjAyMSBhdCAwOToz
MTo0MFBNICswMDAwLCBDaHVjayBMZXZlciBJSUkgd3JvdGU6DQo+PiBTdXJlLCBidXQgdGhhdCdz
IG1vcmUgcmVzdHJpY3RpdmUgdGhhbiB3aGF0IHRoZSBvbGQgZGVjb2Rlcg0KPj4gZGlkLiBJIGhh
dmUgdGhpcyBpbnN0ZWFkIChhbHNvIHlldCB0byBiZSB0ZXN0ZWQpOg0KPj4gDQo+PiAgICBORlNE
OiBGaXggZXhwb3N1cmUgaW4gbmZzZDRfZGVjb2RlX2JpdG1hcCgpDQo+PiANCj4+ICAgIHJ0bUBj
c2FpbC5taXQuZWR1IHJlcG9ydHM6DQo+Pj4gbmZzZDRfZGVjb2RlX2JpdG1hcDQoKSB3aWxsIHdy
aXRlIGJleW9uZCBibXZhbFtibWxlbi0xXSBpZiB0aGUgUlBDDQo+Pj4gZGlyZWN0cyBpdCB0byBk
byBzby4gVGhpcyBjYW4gY2F1c2UgbmZzZDRfZGVjb2RlX3N0YXRlX3Byb3RlY3Q0X2EoKQ0KPj4+
IHRvIHdyaXRlIGNsaWVudC1zdXBwbGllZCBkYXRhIGJleW9uZCB0aGUgZW5kIG9mDQo+Pj4gbmZz
ZDRfZXhjaGFuZ2VfaWQuc3BvX211c3RfYWxsb3dbXSB3aGVuIGNhbGxlZCBieQ0KPj4+IG5mc2Q0
X2RlY29kZV9leGNoYW5nZV9pZCgpLg0KPj4gDQo+PiAgICBSZXdyaXRlIHRoZSBsb29wcyBzbyBu
ZnNkNF9kZWNvZGVfYml0bWFwKCkgY2Fubm90IGl0ZXJhdGUgYmV5b25kDQo+PiAgICBAYm1sZW4u
DQo+PiANCj4+ICAgIFJlcG9ydGVkIGJ5OiA8cnRtQGNzYWlsLm1pdC5lZHU+DQo+PiAgICBGaXhl
czogZDFjMjYzYTAzMWU4ICgiTkZTRDogUmVwbGFjZSBSRUFEKiBtYWNyb3MgaW4gbmZzZDRfZGVj
b2RlX2ZhdHRyKCkiKQ0KPj4gICAgU2lnbmVkLW9mZi1ieTogQ2h1Y2sgTGV2ZXIgPGNodWNrLmxl
dmVyQG9yYWNsZS5jb20+DQo+PiANCj4+IGRpZmYgLS1naXQgYS9mcy9uZnNkL25mczR4ZHIuYyBi
L2ZzL25mc2QvbmZzNHhkci5jDQo+PiBpbmRleCAxMDg4M2U2ZDgwYWMuLmMyZjc1MzIzM2ZjZiAx
MDA2NDQNCj4+IC0tLSBhL2ZzL25mc2QvbmZzNHhkci5jDQo+PiArKysgYi9mcy9uZnNkL25mczR4
ZHIuYw0KPj4gQEAgLTI4OCwxMiArMjg4LDggQEAgbmZzZDRfZGVjb2RlX2JpdG1hcDQoc3RydWN0
IG5mc2Q0X2NvbXBvdW5kYXJncyAqYXJncCwgdTMyICpibXZhbCwgdTMyIGJtbGVuKQ0KPj4gICAg
ICAgIHAgPSB4ZHJfaW5saW5lX2RlY29kZShhcmdwLT54ZHIsIGNvdW50IDw8IDIpOw0KPj4gICAg
ICAgIGlmICghcCkNCj4+ICAgICAgICAgICAgICAgIHJldHVybiBuZnNlcnJfYmFkX3hkcjsNCj4+
IC0gICAgICAgaSA9IDA7DQo+PiAtICAgICAgIHdoaWxlIChpIDwgY291bnQpDQo+PiAtICAgICAg
ICAgICAgICAgYm12YWxbaSsrXSA9IGJlMzJfdG9fY3B1cChwKyspOw0KPj4gLSAgICAgICB3aGls
ZSAoaSA8IGJtbGVuKQ0KPj4gLSAgICAgICAgICAgICAgIGJtdmFsW2krK10gPSAwOw0KPj4gLQ0K
Pj4gKyAgICAgICBmb3IgKGkgPSAwOyBpIDwgYm1sZW47IGkrKykNCj4+ICsgICAgICAgICAgICAg
ICBibXZhbFtpXSA9IChpIDwgY291bnQpID8gYmUzMl90b19jcHVwKHArKykgOiAwOw0KPj4gICAg
ICAgIHJldHVybiBuZnNfb2s7DQo+PiB9DQo+PiANCj4+IFRoaXMgYWxsb3dzIHRoZSBjbGllbnQg
dG8gc2VuZCBiaXRtYXBzIGxhcmdlciB0aGFuIGJtdmFsW10sDQo+PiBhcyB0aGUgb2xkIGRlY29k
ZXIgZGlkLCBhbmQgZW5zdXJlcyB0aGF0IGRlY29kZV9iaXRtYXAoKQ0KPj4gY2Fubm90IHdyaXRl
IGZhcnRoZXIgdGhhbiBAYm1sZW4gaW50byB0aGUgYm12YWwgYXJyYXkuDQo+IA0KPiBCdXQgSSBu
b3RpY2Ugbm93IHRoYXQgeW91ciB0cmVlIGhhcyAiTkZTRDogUmVwbGFjZQ0KPiBuZnNkNF9kZWNv
ZGVfYml0bWFwNCgpIiwgd2hpY2ggZG9lcyBlcnJvciBvdXQgb24gbGFyZ2UgYml0bWFwcy4NCj4g
KE5vdGljZWQgYmVjYXVzZSBweW5mcyBjaGVja3MgZm9yIHRoaXMgY2FzZSAoc2VlIEdBVFQ0cyBh
bmQgc2ltaWxhcikgYW5kDQo+IGlzIHNlZWluZyBCQURYRFIgcmV0dXJucykuDQoNCkTigJlvaCEg
SSBjYW4gZHJvcCDigJxSZXBsYWNlIG5mc2Q0X2RlY29kZV9iaXRtYXA0KCnigJ0gb3Igd2UgY2Fu
IHVwZGF0ZSB0aGUgZ2VuZXJpYyBoZWxwZXIgdG8gaGFuZGxlIGxhcmdlIGJpdG1hcHMuIERyb3Bw
aW5nIHRoZSBjbGVhbi11cCBzZWVtcyBzYWZlci4NCg0KDQo=
