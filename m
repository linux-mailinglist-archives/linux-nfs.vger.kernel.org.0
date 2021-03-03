Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F80B32CA12
	for <lists+linux-nfs@lfdr.de>; Thu,  4 Mar 2021 02:39:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231147AbhCDBdQ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 3 Mar 2021 20:33:16 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:57302 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233932AbhCDBSV (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 3 Mar 2021 20:18:21 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 123LsXEP110489;
        Wed, 3 Mar 2021 21:59:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=v2fobb3oLelJkZtDyOiC66dy6NWCm4ffQ9YCXHfKT1A=;
 b=gTtGD7WKYCL2FUla7h6z7sssSuRa2D4p6ApIMHwy2Ep9AmEsYH1f59t2hEuyxEX14Hgl
 jK+ovDnjd7sqJXUVgXQIeMEaGrrMIcUOA7TV1KiAJJ6YZwNBy6S/nta5cS4saFv47Q01
 cibXvoFr/NeZQ4eLYAEh7o2Qsy1RzkaCCpGwMicW/hDRI0L50axwT9zrSDd4QD9SmHsY
 u0YKZYyBM3TGnKg0PSIQ213KaJcfJmeAtU4xh8pWRKkxvtdTX8Eb1+gHxHcgGOZDc9zJ
 BM2ZBcmyOqMitlmR39F0TMTmq0NJlm2+RxzIRAoSDaTSzpQJ+iQr+1jfk8Efk3vIoDPL Xw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 3726v7ame3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 Mar 2021 21:59:50 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 123Lt7LX026729;
        Wed, 3 Mar 2021 21:59:50 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2053.outbound.protection.outlook.com [104.47.36.53])
        by aserp3020.oracle.com with ESMTP id 370001ujww-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 Mar 2021 21:59:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S66gqogLApMB5+ygW291GCjz9aJ3PlEs6vxxa1hry3Uqu88TZ6n10GCPb+aif4VoM833wjbxeFzN/ZWIxoavl+W2YTVR4JN2S99mR2cTzGpM5V/UcrSUS6RVtvufvCAw4kj0DvKfPAzx/jLgMTnidgOa0TPpmbMFnG9BVYiUCeJncSz+V/h+XcERUlx0GUB3EX82WwlUvXn+vbslK2geRGzysjUbYfgIBZiQbM87GVm95V2+05FdqawMbQtQdngpO2qg2Mjtl6bXljXHL7FlUBC/P9hLy8mu1OPI9/dTEQh/3M10cgWrISK3Jzkvi65tZ135IRlAEjECofFOH5ZclA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v2fobb3oLelJkZtDyOiC66dy6NWCm4ffQ9YCXHfKT1A=;
 b=lAsc1Zms5RNmD35ETvVn4ItbCPDCbinmn6zYCGSO/3j8PR/q7wQ94zw8j9yPD5doe4sRbs+U1zz+gLIYKX36PlZ23LVwyEP+HwKMR2gTH60vEuVsWXDEKb4pRI3exSEtucy0h55vvyXFbvJcJ0YyxD7LfxeExcKno+5X3hpFchixJTA/lX2gdsA995YTRrAuJcw9dvrR2FLEnO1a8noMUzTrcr++A67/Msk2qDNihDDoZdub4rCdrUPhv945rlN4Fvhh8PICsY5yQ7JdGLM5deHECO3SFFmyC/GvfptcqdznAzHjlUA4uExtgdBaFloOKgtOoaITHaBH6S32qo+lGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v2fobb3oLelJkZtDyOiC66dy6NWCm4ffQ9YCXHfKT1A=;
 b=nhmZEQEFtcsogMPnrVobKFC9JzJohsfYqVgucIID2tDbYnGiH9F+sucmfh7Wii/JwTD3MnIK73yU9PQV9llOCP+7c8Ny/jzhPE6KMMRh0FLMf0FUVopyL8HsfnlzPWYoIaR0UOnL9KDM70yt6ib3IT160LQFCwSYe2JjpYvIuVI=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BYAPR10MB3510.namprd10.prod.outlook.com (2603:10b6:a03:120::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.26; Wed, 3 Mar
 2021 21:59:48 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::6da8:6d28:b83:702b]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::6da8:6d28:b83:702b%4]) with mapi id 15.20.3912.017; Wed, 3 Mar 2021
 21:59:48 +0000
From:   Chuck Lever <chuck.lever@oracle.com>
To:     Bruce Fields <bfields@fieldses.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] nfsd: helper for laundromat expiry calculations
Thread-Topic: [PATCH] nfsd: helper for laundromat expiry calculations
Thread-Index: AQHXD3s3GSu7nxFDKU+a9rc0Y7q7iqpyyz8AgAAFk4CAAAFEgA==
Date:   Wed, 3 Mar 2021 21:59:48 +0000
Message-ID: <63E16B3E-2524-4257-BB70-F685330554F3@oracle.com>
References: <20210302154623.GA2263@fieldses.org>
 <AC0F5679-8B32-4D75-B28B-67171027B70D@oracle.com>
 <20210303215515.GF3949@fieldses.org>
In-Reply-To: <20210303215515.GF3949@fieldses.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: fieldses.org; dkim=none (message not signed)
 header.d=none;fieldses.org; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [68.61.232.219]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7edbb8d4-e04e-47a3-ca8f-08d8de8faa05
x-ms-traffictypediagnostic: BYAPR10MB3510:
x-microsoft-antispam-prvs: <BYAPR10MB3510CFADCA7CA1FEE23BEC2C93989@BYAPR10MB3510.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2803;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ETAxxf/3zXHFHawVjVkjpzEPChj2D8cewokgzB7z/fH/J25UKBFnkCh56ZA2rpJrz6pKa2rwv8YA0jBqP+KH6Snr3ifMbSUn/ePkI4b2iz2pSG87JfSLQHkdtb+PTpre8/4iOmp8b0NrfZvejjuJLr3HOAJCjywE7kv1JrCprFD6mekMGGBGhisBUqgURjUV4VNGO5v8Tl5paffB1cfyzR7gTVNSVUnjCLgakO1RFLtv7WpeU/ZtP2bqWt6srC4+XYPGSVJKVkZgnmjSbzkHyaw/bkvOSydbR/YPBzO9f2i1jNPkELu1BKG/dl/oURrPV5ztTe1AEKx1slt7pDOhHyloKF/ZrAfVSS6nuX7oTw5qiDi0czaLf/znJMW6YhzI0Tk0zcIazBQf4APKVM1S1wJUU7lMfdz3oM7qufueDBwCW1RsIfdq1QrMmIWskFWfquLkrFgS4auVwPSTbcB7xlA+VtDMPgBfWuZULQNbOPbCeSSqS/L4usqlUxCptY/3LOleNxxFbeKtbQ/xQ+0plc87kb+lHZVbvpIYrAhB6DreCnx9mAGmVsxDVf2puEsZUKlJ44ErVczxzjasEJgJGA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(376002)(136003)(366004)(346002)(39860400002)(66446008)(83380400001)(53546011)(4326008)(478600001)(6512007)(76116006)(316002)(5660300002)(66946007)(44832011)(91956017)(66476007)(6506007)(64756008)(66556008)(2906002)(8936002)(6916009)(186003)(2616005)(86362001)(36756003)(71200400001)(6486002)(8676002)(33656002)(26005)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?ZklGUGJNRnBGSFBYSGFRK1ZrZ3g5c2ZGTkJiUG11Yi9PdlhSVTYwbFFrbzEz?=
 =?utf-8?B?Tjd3YkY1dDFnUWhnWWtmU1dTdjdGZlZNL3lsaWNZbVB2bkhOTjR3dDZLKytK?=
 =?utf-8?B?MTJQRkZlc2Jvc01uTXhrQzU5WVlEZHBzSFJ6TmVCWXRxNENYenludEFacjJP?=
 =?utf-8?B?UWpxWUNPREJrcE1ZZ1JwNWxabitVUjFDb3Q3VHJ4d28wWkVqTXc3SndCNHly?=
 =?utf-8?B?enFnenM3b3Z3QnMyajhDa1J0S3FuaVN4eEVDb3NvZmRDVjcxRHE0NTY3YnR3?=
 =?utf-8?B?Skk3MzNPUnVRcCtiZ3RnZHpvdXAvTTNYUi82VnZvZmpvbnNzbmRaZHAxc3Fs?=
 =?utf-8?B?L2ZISU83bTljMU0vc1pQWS95SExDdXhMZjRtNTR5NUVsZ2pQQ3o2SnRsVGZ3?=
 =?utf-8?B?MUR4MHVsakZkZmxIeFcyWDgxWkh6dkNTUXd2eG5hc2JLbnhXWVowNUtxK0ky?=
 =?utf-8?B?T2VJVkZGZ0Y3Y3lSLzdxT3hYSUp0aEljbUJMWlRBd0ZVWWV6UWtHRlJiaVRV?=
 =?utf-8?B?cS8va0UyblRNcHluSllLT0V5OXFPVTBmZ2pvRXRXZk9PT2tpZi90cysrczdE?=
 =?utf-8?B?R29XbFdveHVuUWNiM3VTYWhKZXJDbHZXSVlqN1dUSCtDWUkwRk83cUJCeVYv?=
 =?utf-8?B?L3k5bkRZbEd4VzJ4UU8za1dtdDdyU2lJZDRxKzhabDRpVm9ERE5HWHhncHNi?=
 =?utf-8?B?YjFaYUx1OE8wQ2ZJd2pSSkhpMERGOW1tZElkNTl3NFpjeXZ2VjFPenZOWFVC?=
 =?utf-8?B?MVFobUVPNHgrYWVLK1UxNEludFArUEtwZ3A4ME5GU1lzMnFTSStuUFhydmVp?=
 =?utf-8?B?LzlyYllsRG1iVm5xaFZ3NmRCY1BMa0RlcUNpOG9qS3ArQnFKc0p2TUtJdGRa?=
 =?utf-8?B?VkcxeHhPMWhyMmJ1TUFFTEVpK0Q1UFRGMkN5NGo5bFFDN0VkS0hjb3lmalQ0?=
 =?utf-8?B?QnEvQzRQbEZ6Z29qNDU5K0drQnlicUYrV0hrZFBQdFJkQW03cnJEYUNXWGxk?=
 =?utf-8?B?VzQ2SGxaaHRSbm1ERUZMRnhqUktZcHNPWFpwYVRCRXZ4alBka2R6cUhGYUha?=
 =?utf-8?B?bEVEd0RWUnRqOXZDVjJPOHFSOTAydXpEeU5zenJBc0lHbkJJNUpUZVRVaUFB?=
 =?utf-8?B?ZFNoSG52aHVxRVBZNkFSNTNKMzBRTUg5QlF1ZGhaVjUxeGNVbWNuZ25FYmEz?=
 =?utf-8?B?d2lqTk5FS1NFOFBtd2ZBSlZLcTd2cVRBMllPV0FKbWdtTlE4T1lyS3c3U2Ri?=
 =?utf-8?B?cWg1cllyMXc5SXh0TDB2UWJESU82MUY5ZmpwVXdRVENnbktpM0grQU9WNnBX?=
 =?utf-8?B?ZTBrTVh6S0ZrQTNlSmNhSFQwVWNUS1I2RVFuUnpIejQzUEh2bTBVdW05MXQ3?=
 =?utf-8?B?TUdyeG1lNUZjVVlpVVgvWWFNem16bUYyRjM2cnFXdnJRN3RCRlFrOXZ3dWRo?=
 =?utf-8?B?SDVReFM0WS9ObnF3MXV1SlB6WkhIR21oKy94bHZ5M1RJbkxhOEdONEp1aG9B?=
 =?utf-8?B?TE80cERkaDE3VnNIRVM0SE53SDFtUVFENnRaeTBrUGd1a05oMGZKVmhPQzhp?=
 =?utf-8?B?L3lXVjFkZzRRNVJiNXQwS0tySGY3NW9jZVlUQmFPYy9sbW0zcC9jRmVrU0pn?=
 =?utf-8?B?aWM1OGVYVkR1SGZBb2hsQ2lORTNJYnVqYktuY3ZsYTBpdmVTSEMyUDNUYzJQ?=
 =?utf-8?B?cUtpamRMS1BMU0l5bkNiOVhnb0JCYklPTWt6aFNsNG40ZUxXanFYTytsYU1L?=
 =?utf-8?B?TTFMRURFdERkMHE3bS83WlMvcVRPUHcrZndVMmVYSUU1R3lnMFJ6eHdTUjNj?=
 =?utf-8?B?YnYxWlVqMVEwcEN1Ym5Ydz09?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <089C99E6F8CF4144B9E79F70FDA5F599@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7edbb8d4-e04e-47a3-ca8f-08d8de8faa05
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2021 21:59:48.6384
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +hoM5zfRpfsy63zmVVsOoU5RL3lnhGRUYmIZjcVGm0rjA/0laaVXjQlNmwFzfGlc5J4USm/rdmCJ5RkcfOXzBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3510
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9912 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 mlxscore=0 spamscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103030155
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9912 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 phishscore=0 mlxscore=0
 suspectscore=0 adultscore=0 malwarescore=0 priorityscore=1501 bulkscore=0
 lowpriorityscore=0 spamscore=0 mlxlogscore=999 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103030155
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

DQoNCj4gT24gTWFyIDMsIDIwMjEsIGF0IDQ6NTUgUE0sIEJydWNlIEZpZWxkcyA8YmZpZWxkc0Bm
aWVsZHNlcy5vcmc+IHdyb3RlOg0KPiANCj4gT24gV2VkLCBNYXIgMDMsIDIwMjEgYXQgMDk6MzU6
MThQTSArMDAwMCwgQ2h1Y2sgTGV2ZXIgd3JvdGU6DQo+PiANCj4+IA0KPj4+IE9uIE1hciAyLCAy
MDIxLCBhdCAxMDo0NiBBTSwgQnJ1Y2UgRmllbGRzIDxiZmllbGRzQGZpZWxkc2VzLm9yZz4gd3Jv
dGU6DQo+Pj4gDQo+Pj4gRnJvbTogIkouIEJydWNlIEZpZWxkcyIgPGJmaWVsZHNAcmVkaGF0LmNv
bT4NCj4+PiANCj4+PiBXZSBkbyB0aGlzIHNhbWUgbG9naWMgcmVwZWF0ZWRseSwgYW5kIGl0J3Mg
ZWFzeSB0byBnZXQgdGhlIHNlbnNlIG9mIHRoZQ0KPj4+IGNvbXBhcmlzb24gd3JvbmcuDQo+Pj4g
DQo+Pj4gU2lnbmVkLW9mZi1ieTogSi4gQnJ1Y2UgRmllbGRzIDxiZmllbGRzQHJlZGhhdC5jb20+
DQo+Pj4gLS0tDQo+Pj4gZnMvbmZzZC9uZnM0c3RhdGUuYyB8IDQ5ICsrKysrKysrKysrKysrKysr
KysrKysrKystLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPj4+IDEgZmlsZSBjaGFuZ2VkLCAyNyBpbnNl
cnRpb25zKCspLCAyMiBkZWxldGlvbnMoLSkNCj4+PiANCj4+PiBNeSBvcmlnaW5hbCB2ZXJzaW9u
IG9mIHRoaXMgcGF0Y2guLi4gYWN0dWFsbHkgZ290IHRoZSBzZW5zZSBvZiB0aGUNCj4+PiBjb21w
YXJpc29uIHdyb25nIQ0KPj4+IA0KPj4+IE5vdyBhY3R1YWxseSB0ZXN0ZWQuDQo+Pj4gDQo+Pj4g
ZGlmZiAtLWdpdCBhL2ZzL25mc2QvbmZzNHN0YXRlLmMgYi9mcy9uZnNkL25mczRzdGF0ZS5jDQo+
Pj4gaW5kZXggNjE1NTJlODliZDg5Li44ZTY5Mzg5MDJiNDkgMTAwNjQ0DQo+Pj4gLS0tIGEvZnMv
bmZzZC9uZnM0c3RhdGUuYw0KPj4+ICsrKyBiL2ZzL25mc2QvbmZzNHN0YXRlLmMNCj4+PiBAQCAt
NTM2Myw2ICs1MzYzLDIyIEBAIHN0YXRpYyBib29sIGNsaWVudHNfc3RpbGxfcmVjbGFpbWluZyhz
dHJ1Y3QgbmZzZF9uZXQgKm5uKQ0KPj4+IAlyZXR1cm4gdHJ1ZTsNCj4+PiB9DQo+Pj4gDQo+Pj4g
K3N0cnVjdCBsYXVuZHJ5X3RpbWUgew0KPj4+ICsJdGltZTY0X3QgY3V0b2ZmOw0KPj4+ICsJdGlt
ZTY0X3QgbmV3X3RpbWVvOw0KPj4+ICt9Ow0KPj4+ICsNCj4+PiArYm9vbCBzdGF0ZV9leHBpcmVk
KHN0cnVjdCBsYXVuZHJ5X3RpbWUgKmx0LCB0aW1lNjRfdCBsYXN0X3JlZnJlc2gpDQo+Pj4gK3sN
Cj4+PiArCXRpbWU2NF90IHRpbWVfcmVtYWluaW5nOw0KPj4+ICsNCj4+PiArCWlmIChsYXN0X3Jl
ZnJlc2ggPCBsdC0+Y3V0b2ZmKQ0KPj4+ICsJCXJldHVybiB0cnVlOw0KPj4+ICsJdGltZV9yZW1h
aW5pbmcgPSBsYXN0X3JlZnJlc2ggLSBsdC0+Y3V0b2ZmOw0KPj4+ICsJbHQtPm5ld190aW1lbyA9
IG1pbihsdC0+bmV3X3RpbWVvLCB0aW1lX3JlbWFpbmluZyk7DQo+Pj4gKwlyZXR1cm4gZmFsc2U7
DQo+Pj4gK30NCj4+PiArDQo+PiANCj4+IC9ob21lL2NlbC9zcmMvbGludXgvbGludXgvZnMvbmZz
ZC9uZnM0c3RhdGUuYzo1MzcxOjY6IHdhcm5pbmc6IG5vIHByZXZpb3VzIHByb3RvdHlwZSBmb3Ig
4oCYc3RhdGVfZXhwaXJlZOKAmSBbLVdtaXNzaW5nLXByb3RvdHlwZXNdDQo+PiA1MzcxIHwgYm9v
bCBzdGF0ZV9leHBpcmVkKHN0cnVjdCBsYXVuZHJ5X3RpbWUgKmx0LCB0aW1lNjRfdCBsYXN0X3Jl
ZnJlc2gpDQo+PiAgICAgIHwgICAgICBefn5+fn5+fn5+fn5+DQo+PiANCj4+IFNob3VsZCB0aGlz
IG5ldyBoZWxwZXIgYmUgc3RhdGljLCBvciBpbnN0ZWFkIHBlcmhhcHMgdGhlc2UgaXRlbXMNCj4+
IHNob3VsZCBiZSBkZWZpbmVkIGluIGEgaGVhZGVyIGZpbGUuDQo+IA0KPiBXaG9vcHMsIHNob3Vs
ZCBoYXZlIGJlZW4gc3RhdGljLCB5ZXMsIGRvIHlvdSB3YW50IHRvIGZpeCBpdCB1cCBvciBzaG91
bGQNCj4gSSByZXNlbmQ/DQoNCkkndmUgY29ycmVjdGVkIGl0IGluIHRoZSBmb3ItbmV4dCB0b3Bp
YyBicmFuY2ggaW4NCg0KZ2l0Oi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwv
Z2l0L2NlbC9saW51eC5naXQNCg0KDQo+IC0tYi4NCj4gDQo+PiANCj4+PiBzdGF0aWMgdGltZTY0
X3QNCj4+PiBuZnM0X2xhdW5kcm9tYXQoc3RydWN0IG5mc2RfbmV0ICpubikNCj4+PiB7DQo+Pj4g
QEAgLTUzNzIsMTQgKzUzODgsMTYgQEAgbmZzNF9sYXVuZHJvbWF0KHN0cnVjdCBuZnNkX25ldCAq
bm4pDQo+Pj4gCXN0cnVjdCBuZnM0X29sX3N0YXRlaWQgKnN0cDsNCj4+PiAJc3RydWN0IG5mc2Q0
X2Jsb2NrZWRfbG9jayAqbmJsOw0KPj4+IAlzdHJ1Y3QgbGlzdF9oZWFkICpwb3MsICpuZXh0LCBy
ZWFwbGlzdDsNCj4+PiAtCXRpbWU2NF90IGN1dG9mZiA9IGt0aW1lX2dldF9ib290dGltZV9zZWNv
bmRzKCkgLSBubi0+bmZzZDRfbGVhc2U7DQo+Pj4gLQl0aW1lNjRfdCB0LCBuZXdfdGltZW8gPSBu
bi0+bmZzZDRfbGVhc2U7DQo+Pj4gKwlzdHJ1Y3QgbGF1bmRyeV90aW1lIGx0ID0gew0KPj4+ICsJ
CS5jdXRvZmYgPSBrdGltZV9nZXRfYm9vdHRpbWVfc2Vjb25kcygpIC0gbm4tPm5mc2Q0X2xlYXNl
LA0KPj4+ICsJCS5uZXdfdGltZW8gPSBubi0+bmZzZDRfbGVhc2UNCj4+PiArCX07DQo+Pj4gCXN0
cnVjdCBuZnM0X2NwbnRmX3N0YXRlICpjcHM7DQo+Pj4gCWNvcHlfc3RhdGVpZF90ICpjcHNfdDsN
Cj4+PiAJaW50IGk7DQo+Pj4gDQo+Pj4gCWlmIChjbGllbnRzX3N0aWxsX3JlY2xhaW1pbmcobm4p
KSB7DQo+Pj4gLQkJbmV3X3RpbWVvID0gMDsNCj4+PiArCQlsdC5uZXdfdGltZW8gPSAwOw0KPj4+
IAkJZ290byBvdXQ7DQo+Pj4gCX0NCj4+PiAJbmZzZDRfZW5kX2dyYWNlKG5uKTsNCj4+PiBAQCAt
NTM4OSw3ICs1NDA3LDcgQEAgbmZzNF9sYXVuZHJvbWF0KHN0cnVjdCBuZnNkX25ldCAqbm4pDQo+
Pj4gCWlkcl9mb3JfZWFjaF9lbnRyeSgmbm4tPnMyc19jcF9zdGF0ZWlkcywgY3BzX3QsIGkpIHsN
Cj4+PiAJCWNwcyA9IGNvbnRhaW5lcl9vZihjcHNfdCwgc3RydWN0IG5mczRfY3BudGZfc3RhdGUs
IGNwX3N0YXRlaWQpOw0KPj4+IAkJaWYgKGNwcy0+Y3Bfc3RhdGVpZC5zY190eXBlID09IE5GUzRf
Q09QWU5PVElGWV9TVElEICYmDQo+Pj4gLQkJCQljcHMtPmNwbnRmX3RpbWUgPCBjdXRvZmYpDQo+
Pj4gKwkJCQlzdGF0ZV9leHBpcmVkKCZsdCwgY3BzLT5jcG50Zl90aW1lKSkNCj4+PiAJCQlfZnJl
ZV9jcG50Zl9zdGF0ZV9sb2NrZWQobm4sIGNwcyk7DQo+Pj4gCX0NCj4+PiAJc3Bpbl91bmxvY2so
Jm5uLT5zMnNfY3BfbG9jayk7DQo+Pj4gQEAgLTUzOTcsMTEgKzU0MTUsOCBAQCBuZnM0X2xhdW5k
cm9tYXQoc3RydWN0IG5mc2RfbmV0ICpubikNCj4+PiAJc3Bpbl9sb2NrKCZubi0+Y2xpZW50X2xv
Y2spOw0KPj4+IAlsaXN0X2Zvcl9lYWNoX3NhZmUocG9zLCBuZXh0LCAmbm4tPmNsaWVudF9scnUp
IHsNCj4+PiAJCWNscCA9IGxpc3RfZW50cnkocG9zLCBzdHJ1Y3QgbmZzNF9jbGllbnQsIGNsX2xy
dSk7DQo+Pj4gLQkJaWYgKGNscC0+Y2xfdGltZSA+IGN1dG9mZikgew0KPj4+IC0JCQl0ID0gY2xw
LT5jbF90aW1lIC0gY3V0b2ZmOw0KPj4+IC0JCQluZXdfdGltZW8gPSBtaW4obmV3X3RpbWVvLCB0
KTsNCj4+PiArCQlpZiAoIXN0YXRlX2V4cGlyZWQoJmx0LCBjbHAtPmNsX3RpbWUpKQ0KPj4+IAkJ
CWJyZWFrOw0KPj4+IC0JCX0NCj4+PiAJCWlmIChtYXJrX2NsaWVudF9leHBpcmVkX2xvY2tlZChj
bHApKSB7DQo+Pj4gCQkJdHJhY2VfbmZzZF9jbGlkX2V4cGlyZWQoJmNscC0+Y2xfY2xpZW50aWQp
Ow0KPj4+IAkJCWNvbnRpbnVlOw0KPj4+IEBAIC01NDE4LDExICs1NDMzLDggQEAgbmZzNF9sYXVu
ZHJvbWF0KHN0cnVjdCBuZnNkX25ldCAqbm4pDQo+Pj4gCXNwaW5fbG9jaygmc3RhdGVfbG9jayk7
DQo+Pj4gCWxpc3RfZm9yX2VhY2hfc2FmZShwb3MsIG5leHQsICZubi0+ZGVsX3JlY2FsbF9scnUp
IHsNCj4+PiAJCWRwID0gbGlzdF9lbnRyeSAocG9zLCBzdHJ1Y3QgbmZzNF9kZWxlZ2F0aW9uLCBk
bF9yZWNhbGxfbHJ1KTsNCj4+PiAtCQlpZiAoZHAtPmRsX3RpbWUgPiBjdXRvZmYpIHsNCj4+PiAt
CQkJdCA9IGRwLT5kbF90aW1lIC0gY3V0b2ZmOw0KPj4+IC0JCQluZXdfdGltZW8gPSBtaW4obmV3
X3RpbWVvLCB0KTsNCj4+PiArCQlpZiAoIXN0YXRlX2V4cGlyZWQoJmx0LCBkcC0+ZGxfdGltZSkp
DQo+Pj4gCQkJYnJlYWs7DQo+Pj4gLQkJfQ0KPj4+IAkJV0FSTl9PTighdW5oYXNoX2RlbGVnYXRp
b25fbG9ja2VkKGRwKSk7DQo+Pj4gCQlsaXN0X2FkZCgmZHAtPmRsX3JlY2FsbF9scnUsICZyZWFw
bGlzdCk7DQo+Pj4gCX0NCj4+PiBAQCAtNTQzOCwxMSArNTQ1MCw4IEBAIG5mczRfbGF1bmRyb21h
dChzdHJ1Y3QgbmZzZF9uZXQgKm5uKQ0KPj4+IAl3aGlsZSAoIWxpc3RfZW1wdHkoJm5uLT5jbG9z
ZV9scnUpKSB7DQo+Pj4gCQlvbyA9IGxpc3RfZmlyc3RfZW50cnkoJm5uLT5jbG9zZV9scnUsIHN0
cnVjdCBuZnM0X29wZW5vd25lciwNCj4+PiAJCQkJCW9vX2Nsb3NlX2xydSk7DQo+Pj4gLQkJaWYg
KG9vLT5vb190aW1lID4gY3V0b2ZmKSB7DQo+Pj4gLQkJCXQgPSBvby0+b29fdGltZSAtIGN1dG9m
ZjsNCj4+PiAtCQkJbmV3X3RpbWVvID0gbWluKG5ld190aW1lbywgdCk7DQo+Pj4gKwkJaWYgKCFz
dGF0ZV9leHBpcmVkKCZsdCwgb28tPm9vX3RpbWUpKQ0KPj4+IAkJCWJyZWFrOw0KPj4+IC0JCX0N
Cj4+PiAJCWxpc3RfZGVsX2luaXQoJm9vLT5vb19jbG9zZV9scnUpOw0KPj4+IAkJc3RwID0gb28t
Pm9vX2xhc3RfY2xvc2VkX3N0aWQ7DQo+Pj4gCQlvby0+b29fbGFzdF9jbG9zZWRfc3RpZCA9IE5V
TEw7DQo+Pj4gQEAgLTU0NjgsMTEgKzU0NzcsOCBAQCBuZnM0X2xhdW5kcm9tYXQoc3RydWN0IG5m
c2RfbmV0ICpubikNCj4+PiAJd2hpbGUgKCFsaXN0X2VtcHR5KCZubi0+YmxvY2tlZF9sb2Nrc19s
cnUpKSB7DQo+Pj4gCQluYmwgPSBsaXN0X2ZpcnN0X2VudHJ5KCZubi0+YmxvY2tlZF9sb2Nrc19s
cnUsDQo+Pj4gCQkJCQlzdHJ1Y3QgbmZzZDRfYmxvY2tlZF9sb2NrLCBuYmxfbHJ1KTsNCj4+PiAt
CQlpZiAobmJsLT5uYmxfdGltZSA+IGN1dG9mZikgew0KPj4+IC0JCQl0ID0gbmJsLT5uYmxfdGlt
ZSAtIGN1dG9mZjsNCj4+PiAtCQkJbmV3X3RpbWVvID0gbWluKG5ld190aW1lbywgdCk7DQo+Pj4g
KwkJaWYgKCFzdGF0ZV9leHBpcmVkKCZsdCwgbmJsLT5uYmxfdGltZSkpDQo+Pj4gCQkJYnJlYWs7
DQo+Pj4gLQkJfQ0KPj4+IAkJbGlzdF9tb3ZlKCZuYmwtPm5ibF9scnUsICZyZWFwbGlzdCk7DQo+
Pj4gCQlsaXN0X2RlbF9pbml0KCZuYmwtPm5ibF9saXN0KTsNCj4+PiAJfQ0KPj4+IEBAIC01NDg1
LDggKzU0OTEsNyBAQCBuZnM0X2xhdW5kcm9tYXQoc3RydWN0IG5mc2RfbmV0ICpubikNCj4+PiAJ
CWZyZWVfYmxvY2tlZF9sb2NrKG5ibCk7DQo+Pj4gCX0NCj4+PiBvdXQ6DQo+Pj4gLQluZXdfdGlt
ZW8gPSBtYXhfdCh0aW1lNjRfdCwgbmV3X3RpbWVvLCBORlNEX0xBVU5EUk9NQVRfTUlOVElNRU9V
VCk7DQo+Pj4gLQlyZXR1cm4gbmV3X3RpbWVvOw0KPj4+ICsJcmV0dXJuIG1heF90KHRpbWU2NF90
LCBsdC5uZXdfdGltZW8sIE5GU0RfTEFVTkRST01BVF9NSU5USU1FT1VUKTsNCj4+PiB9DQo+Pj4g
DQo+Pj4gc3RhdGljIHN0cnVjdCB3b3JrcXVldWVfc3RydWN0ICpsYXVuZHJ5X3dxOw0KPj4+IC0t
IA0KPj4+IDIuMjkuMg0KPj4+IA0KPj4gDQo+PiAtLQ0KPj4gQ2h1Y2sgTGV2ZXINCg0KLS0NCkNo
dWNrIExldmVyDQoNCg0KDQo=
