Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC86B2FF5C6
	for <lists+linux-nfs@lfdr.de>; Thu, 21 Jan 2021 21:24:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726430AbhAUUYN (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 21 Jan 2021 15:24:13 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:42946 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbhAUUXu (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 21 Jan 2021 15:23:50 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10LKEIxH126174;
        Thu, 21 Jan 2021 20:22:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=0aF/55fOz5b/Bt9U/pPEbPWAyAyNub3zlCpxSXP/AF4=;
 b=hutwkHfKHU7hzCNPwkiIFlWiz/i5ZvO74GIWehBQ0NDEHjsFKRhmiowOnmJQPsqnfpLm
 ksHLaXDV1DYT4c0hgd8E8l9C/w0x+hYiqP+LwnLK/OyAF03vYYDU5sVHa313UGbXCIEQ
 5zAD7rdMKL/6DJMQfnyys4JpxLZ8r28XJtA1OmaoTKu1WzvK14yDpxwMwAJLXfk3GUNm
 Nfg5JUWGuV0sPmaq3kCVO2ECVMNIbtwuaVVHltjy+34oFcEhhh6v+wcGer5Kr1+OYL95
 MF5g8WqU5c3x+SIZFJpVZwdodkeWR9qmTK+k879R6BcFn7qjliBTZz3B8c12ZzsEMwaA jA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 3668qn169y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Jan 2021 20:22:56 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10LKK04T183965;
        Thu, 21 Jan 2021 20:20:55 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by aserp3020.oracle.com with ESMTP id 3668rgbct1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Jan 2021 20:20:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RqM7yB44grYgtT8kgstVmiF5as1FBRJz5FTaRc1HKVVpbygbZZ/qN6JpAaEE7tgulc0qj1eXIGAONRcXoUy3oOengNwrIkqcJ+62ovLxRzxBZ7OwFALkvysIbODt9+ERsW7W9fOaZ7lJiRRFekpGIMAkT/SVVLgEIGcZVFr0ykNgXiGlzf/y7MJ5e7YW+p399MAh1B5S3sZMYW+oZL/q7GJPFMAq9KdlWF0zZUTkNyY4utg5PPacp+XRRf/i0f0QchPGbLbA7TOivjG3kKSsbG+HlJK1wmupuUTOrqnbKf5O1gHumxRpmw222TVQvZLnDaQFBiM3t1YaiCX2xIgq4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0aF/55fOz5b/Bt9U/pPEbPWAyAyNub3zlCpxSXP/AF4=;
 b=gGhYnYUTiAzqX6hg3snr709pF+K+WtlGJEMh4I5XLldUfnKGQmPUC6BXWr6KzAgjVdHbj17nr2OnRFdLn3tp9I2IcQsXDMP38RFFFqlKRiURWpr5rtZJ10cYAEqwk5QJHfghAeWLnYZTSsb85w+XeFo3BGkIYC+5u5M6w15m2pWIfUFfSXQo/R1Oaiv5cRZo4jm+MdmNojQgLS/3d9m1dHIpjhiucMfLLsOY/4StOHGqF20fO+RXBmpNKHR++9p2fQZF8HJEYs50vk/h3Eyk6H/wNkLhOdq3uEHb9BJdJ242hAWJ+6fSbu7Gz1svvys67m76FJ/hSumMv2pfDCCNPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0aF/55fOz5b/Bt9U/pPEbPWAyAyNub3zlCpxSXP/AF4=;
 b=oawofJXEZKlC0X9gfXrW3kH9hqhmmJKa+fgk4YQcZSEpGvxNKCE2AgnZFpBfTIXGPr48RMke+kCSpG5r25SgFavBs7X8RMtWNT5PIgazeYp8Vo5HcEJeuMY/6NxsuldraiqslYanDaL13fv5NL2uDZAJFopRwd/knuQJk8qdipU=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BYAPR10MB3718.namprd10.prod.outlook.com (2603:10b6:a03:126::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.11; Thu, 21 Jan
 2021 20:20:53 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::6da8:6d28:b83:702b]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::6da8:6d28:b83:702b%4]) with mapi id 15.20.3763.014; Thu, 21 Jan 2021
 20:20:53 +0000
From:   Chuck Lever <chuck.lever@oracle.com>
To:     Bruce Fields <bfields@redhat.com>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 7/9] nfsd: remove unused set_clientid argument
Thread-Topic: [PATCH 7/9] nfsd: remove unused set_clientid argument
Thread-Index: AQHW8CY7M4MYAupMdEii+MzGDEydzqoyhYiA
Date:   Thu, 21 Jan 2021 20:20:53 +0000
Message-ID: <FFAFBDA2-A047-424E-971D-B32CB08D45F6@oracle.com>
References: <6D288689-85E5-4E3E-9117-B71FB45FFABB@oracle.com>
 <1611254995-23131-1-git-send-email-bfields@redhat.com>
 <1611254995-23131-7-git-send-email-bfields@redhat.com>
In-Reply-To: <1611254995-23131-7-git-send-email-bfields@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [68.61.232.219]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c9dfdfc4-408d-4592-78f9-08d8be4a0d83
x-ms-traffictypediagnostic: BYAPR10MB3718:
x-microsoft-antispam-prvs: <BYAPR10MB3718BA6B78EBC884DFCF0F5693A19@BYAPR10MB3718.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VYOtgwPfxTLdQYho6MUFR8AVvCIMFKHRrk1FIdFVVhfm0alfhCMp7hNBsl867+D0lspqUvQMnPY6UBGhi2BF6Jajn26GRlqmC839HTgJlb5hlAuzakG3+EeaPlm2OsesjAzl8x8PWPyJZ9yh33oAJNBBR/U/UXoxFey8BgWlqqS2LyA1FR+0dpIwn6dLWO1I8n3gB5EY0ifVhLWjd3HfuiNqiO4+U2EewmImKBLx5QhWZ1OR8eudVAadM4YWidEb6xtFS6kXwVNzGAYVQQkXQYx0B028OIt5ffnFyBpmNfDj+qM1Brdl/ofXcLOFjoQ30GHsjXqUaSJGTcK0EmbgcX/xgV79kDoTDL18Y3goQtHqHEF4602bCn9UGnJZHwQhp2ns2PbX4ZX4n6Lgu/iUnXugYDSnnE2fYB7HgR9We/WDmVCZvjLcv1m6URqSXvm6
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(376002)(396003)(136003)(366004)(346002)(91956017)(76116006)(8936002)(66946007)(2616005)(6512007)(66446008)(4326008)(186003)(66556008)(64756008)(6916009)(44832011)(66476007)(33656002)(83380400001)(316002)(53546011)(86362001)(6506007)(2906002)(71200400001)(508600001)(26005)(8676002)(5660300002)(36756003)(6486002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?UDVEcCs3Y3VPdTVtcXdseE1oallMVUNGMGMvOGljNlNXdENpeWNyVll6RDdr?=
 =?utf-8?B?ajBjME54NEg2YUVycGZRdTlaS0V5QWZSVGtmSTFjQzcwNlNUQkhZSWdBOU8r?=
 =?utf-8?B?MzVQSXkxWGRhcVpjR1pyenl0NkxvRlg1djBpWC9LaDVKb0dDL296eFQwanRi?=
 =?utf-8?B?cDdmVmpMUStyR2tFa3MzdDl6bUY0NjZoanZoamlOUDhGN0ttcFJzZzBXdXA2?=
 =?utf-8?B?SXQ2TDlxVUdPcDRiL09nZnJ6SlhKenptSTJicTNJTm1hc1kvdWdvaEVrZDhP?=
 =?utf-8?B?cE41K2dBUnVkT0lPa3RldDBrZ3ZzVUIwcjBtK3NlQUFRb0ZON2Y0Y2J5S3Iz?=
 =?utf-8?B?RmFCWFB5anZEUzNaRjFnUFo2QlR0b1poTHU0eldUN3o2RmQxWXEvbVlZcDV0?=
 =?utf-8?B?amduNUJYRzVveVQvaEowaXRqV1dkb2tkRW1oRFMzRW5Nb2huZy9qT05HSzJE?=
 =?utf-8?B?Q3BVamtnR0ltbmZHRHFURGFRZHZDVjdEcHpFb3NoZGtyOEk4Y09FMmlzTHVj?=
 =?utf-8?B?bm5jcDdvbzhMM2REcVBjNUJZUjhKTnBxMG1hV1ZieEdEbUFNc2dFUHI2TFN4?=
 =?utf-8?B?aENVS2FjRlc2TERmeUNzcEZZY0xqRTlLVjhRZDJRMzlPV1RRUTYvcVNXc0t3?=
 =?utf-8?B?ZnRWRnJtZ2dXWTNPYW1zNzNtSnhmS1VCVWRaZGY0U2lzbG1pYUdydnZQaWVX?=
 =?utf-8?B?UERkaWFFVHdnZmFTSVBtWjh2UjBKY0VoclJXZnRkeTZjcGZLVU16NUlYeG5X?=
 =?utf-8?B?b2w4dDhWSG00ZmVqalRpajZaTE9uR09PUXlpUHFmQWlPbVRtckhxTnhMaExs?=
 =?utf-8?B?Y2g5QkU0R0VJbDI0eEhwcHZLNnZncTFNTTFta3dPMWV6dHk3Y3JTVm9mclZm?=
 =?utf-8?B?RndpNVl3WGpZS0ZEMHFjMVlGd0JaTUZRa2xjc0RYM0dQR1FBYkFWUjMxOXNK?=
 =?utf-8?B?RGFhVVBmaUozMEdsS2xKcGlSdlhucGpXUWZpYi9wQVo3VkZGSjZhc29BRFNM?=
 =?utf-8?B?bDA4QUx0b2VWb3E5ZW8wS3BicE13RFoxUGRKdVR2R2gzdE9Zd3FFb0huZktq?=
 =?utf-8?B?NkJOM0Q4M0tSQ1F5eVR0d0NlQkJIUWs2Z25xcGxIREp2REFIVmU4ajlvMy81?=
 =?utf-8?B?YUU3OWd5aER4UlUwSHJkZjM2VlFqOE51L3A3aWp5OXZIRHYxaGh2MnE5cUZs?=
 =?utf-8?B?MkJUR3R4TlFScXppSWh1UTlWMWM2K2pvVnN5cFY1VGVXcUVmTXpNRmU2RzNN?=
 =?utf-8?B?amVKdG9wV3RrUGtVRVB5ZUJFUE9XeFdxMWJ3Yi9nem9hZWFqYmxtM0NEU3M0?=
 =?utf-8?Q?Hi7XuGhTln0hzHNJrCPv2WAI1/kruoj5hk?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <3102C82F70C47B428CAB838BB069F077@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9dfdfc4-408d-4592-78f9-08d8be4a0d83
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jan 2021 20:20:53.5248
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: doN8yJD0T9upGwFJvpnXCJ56TqMt5gb8TIgi0GrW0ugFb9JfI3mCtpfwWJsHklNZERyLElHaLCkqIKCYku2xlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3718
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9871 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 suspectscore=0
 adultscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101210104
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9871 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 priorityscore=1501
 adultscore=0 impostorscore=0 mlxlogscore=999 spamscore=0 suspectscore=0
 phishscore=0 clxscore=1015 bulkscore=0 mlxscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101210103
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

DQoNCj4gT24gSmFuIDIxLCAyMDIxLCBhdCAxOjQ5IFBNLCBKLiBCcnVjZSBGaWVsZHMgPGJmaWVs
ZHNAcmVkaGF0LmNvbT4gd3JvdGU6DQo+IA0KPiBGcm9tOiAiSi4gQnJ1Y2UgRmllbGRzIiA8YmZp
ZWxkc0ByZWRoYXQuY29tPg0KPiANCj4gRXZlcnkgY2FsbGVyIGlzIHNldHRpbmcgdGhpcyBhcmd1
bWVudCB0byBmYWxzZSwgc28gd2UgZG9uJ3QgbmVlZCBpdC4NCj4gDQo+IEFsc28gY2xhcmlmeSBj
b21tZW50cyBhIGxpdHRsZS4NCg0KU29tZSBuaXRzOg0KDQotIFRoZSBzdWJqZWN0IHNheXMgInNl
dF9jbGllbnRpZCIgYnV0IHRoZSBmdW5jdGlvbiBuYW1lIGlzICJzZXRfY2xpZW50Ig0KDQotIElz
IHRoZSBXQVJOX09OX09OQ0UoKSBzdGlsbCBuZWVkZWQ/IChub3RpY2VkIHllc3RlcmRheSwgYnV0
IEkgZm9yZ290DQp0byBtZW50aW9uIGl0KQ0KDQotIFRoaXMgb25lIGRvZXNuJ3QgY29tcGlsZToN
Cg0KW2NlbEBrbGltdCBsaW51eF0kIG1ha2UgQz0xIFc9MSBmcy9uZnNkL25mczRzdGF0ZS5vDQpt
YWtlWzFdOiBFbnRlcmluZyBkaXJlY3RvcnkgJy9ob21lL2NlbC9zcmMvbGludXgvb2JqL2tsaW10
LjEwMTVncmFuZ2VyLm5ldCcNCiAgR0VOICAgICBNYWtlZmlsZQ0KICBVUEQgICAgIGluY2x1ZGUv
Y29uZmlnL2tlcm5lbC5yZWxlYXNlDQogIFVQRCAgICAgaW5jbHVkZS9nZW5lcmF0ZWQvdXRzcmVs
ZWFzZS5oDQogIENBTEwgICAgL2hvbWUvY2VsL3NyYy9saW51eC9saW51eC9zY3JpcHRzL2NoZWNr
c3lzY2FsbHMuc2gNCiAgQ0FMTCAgICAvaG9tZS9jZWwvc3JjL2xpbnV4L2xpbnV4L3NjcmlwdHMv
YXRvbWljL2NoZWNrLWF0b21pY3Muc2gNCiAgREVTQ0VORCAgb2JqdG9vbA0KICBERVNDRU5EICBi
cGYvcmVzb2x2ZV9idGZpZHMNCiAgQ0MgW01dICBmcy9uZnNkL25mczRzdGF0ZS5vDQovaG9tZS9j
ZWwvc3JjL2xpbnV4L2xpbnV4L2ZzL25mc2QvbmZzNHN0YXRlLmM6IEluIGZ1bmN0aW9uIOKAmG5m
czRfY2hlY2tfb3Blbl9yZWNsYWlt4oCZOg0KL2hvbWUvY2VsL3NyYy9saW51eC9saW51eC9mcy9u
ZnNkL25mczRzdGF0ZS5jOjcyMzU6MTE6IGVycm9yOiB0b28gbWFueSBhcmd1bWVudHMgdG8gZnVu
Y3Rpb24g4oCYc2V0X2NsaWVudOKAmQ0KIDcyMzUgfCAgc3RhdHVzID0gc2V0X2NsaWVudChjbGlk
LCBjc3RhdGUsIG5uLCBmYWxzZSk7DQogICAgICB8ICAgICAgICAgICBefn5+fn5+fn5+DQovaG9t
ZS9jZWwvc3JjL2xpbnV4L2xpbnV4L2ZzL25mc2QvbmZzNHN0YXRlLmM6NDY0OToxNTogbm90ZTog
ZGVjbGFyZWQgaGVyZQ0KIDQ2NDkgfCBzdGF0aWMgX19iZTMyIHNldF9jbGllbnQoY2xpZW50aWRf
dCAqY2xpZCwNCiAgICAgIHwgICAgICAgICAgICAgICBefn5+fn5+fn5+DQptYWtlWzNdOiAqKiog
Wy9ob21lL2NlbC9zcmMvbGludXgvbGludXgvc2NyaXB0cy9NYWtlZmlsZS5idWlsZDoyNzk6IGZz
L25mc2QvbmZzNHN0YXRlLm9dIEVycm9yIDENCm1ha2VbMl06ICoqKiBbL2hvbWUvY2VsL3NyYy9s
aW51eC9saW51eC9zY3JpcHRzL01ha2VmaWxlLmJ1aWxkOjQ5NjogZnMvbmZzZF0gRXJyb3IgMg0K
bWFrZVsxXTogKioqIFsvaG9tZS9jZWwvc3JjL2xpbnV4L2xpbnV4L01ha2VmaWxlOjE4MDU6IGZz
XSBFcnJvciAyDQptYWtlWzFdOiBMZWF2aW5nIGRpcmVjdG9yeSAnL2hvbWUvY2VsL3NyYy9saW51
eC9vYmova2xpbXQuMTAxNWdyYW5nZXIubmV0Jw0KbWFrZTogKioqIFtNYWtlZmlsZToxODU6IF9f
c3ViLW1ha2VdIEVycm9yIDINCltjZWxAa2xpbXQgbGludXhdJA0KDQpJIHRoaW5rIEkgd2lsbCBu
ZWVkIGEgdjMgb2YgdGhpcyBzZXJpZXMgYmVjYXVzZSA4Lzkgd2lsbCBoYXZlIHRvDQpiZSBmaXhl
ZCB1cCB0b28uIFBsZWFzZSBiZSBzdXJlIHRvIGFkZCB0aGUgc2VyaWVzIHZlcnNpb24gbnVtYmVy
DQp3aGVuIHlvdSByZXBvc3QuDQoNClRoYW5rcyENCg0KDQo+IFNpZ25lZC1vZmYtYnk6IEouIEJy
dWNlIEZpZWxkcyA8YmZpZWxkc0ByZWRoYXQuY29tPg0KPiAtLS0NCj4gZnMvbmZzZC9uZnM0c3Rh
dGUuYyB8IDIyICsrKysrKysrKy0tLS0tLS0tLS0tLS0NCj4gMSBmaWxlIGNoYW5nZWQsIDkgaW5z
ZXJ0aW9ucygrKSwgMTMgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZnMvbmZzZC9u
ZnM0c3RhdGUuYyBiL2ZzL25mc2QvbmZzNHN0YXRlLmMNCj4gaW5kZXggZGIxMGZlZjFjMWQyLi43
Yzk1Zjg4MDgzMjQgMTAwNjQ0DQo+IC0tLSBhL2ZzL25mc2QvbmZzNHN0YXRlLmMNCj4gKysrIGIv
ZnMvbmZzZC9uZnM0c3RhdGUuYw0KPiBAQCAtNDY0OCw4ICs0NjQ4LDcgQEAgc3RhdGljIHN0cnVj
dCBuZnM0X2NsaWVudCAqbG9va3VwX2NsaWVudGlkKGNsaWVudGlkX3QgKmNsaWQsIGJvb2wgc2Vz
c2lvbnMsDQo+IA0KPiBzdGF0aWMgX19iZTMyIHNldF9jbGllbnQoY2xpZW50aWRfdCAqY2xpZCwN
Cj4gCQlzdHJ1Y3QgbmZzZDRfY29tcG91bmRfc3RhdGUgKmNzdGF0ZSwNCj4gLQkJc3RydWN0IG5m
c2RfbmV0ICpubiwNCj4gLQkJYm9vbCBzZXNzaW9ucykNCj4gKwkJc3RydWN0IG5mc2RfbmV0ICpu
bikNCj4gew0KPiAJaWYgKGNzdGF0ZS0+Y2xwKSB7DQo+IAkJaWYgKCFzYW1lX2NsaWQoJmNzdGF0
ZS0+Y2xwLT5jbF9jbGllbnRpZCwgY2xpZCkpDQo+IEBAIC00NjU4LDEzICs0NjU3LDEwIEBAIHN0
YXRpYyBfX2JlMzIgc2V0X2NsaWVudChjbGllbnRpZF90ICpjbGlkLA0KPiAJfQ0KPiAJaWYgKFNU
QUxFX0NMSUVOVElEKGNsaWQsIG5uKSkNCj4gCQlyZXR1cm4gbmZzZXJyX3N0YWxlX2NsaWVudGlk
Ow0KPiAtCS8qDQo+IC0JICogRm9yIHY0LjErIHdlIGdldCB0aGUgY2xpZW50IGluIHRoZSBTRVFV
RU5DRSBvcC4gSWYgd2UgZG9uJ3QgaGF2ZSBvbmUNCj4gLQkgKiBjYWNoZWQgYWxyZWFkeSB0aGVu
IHdlIGtub3cgdGhpcyBpcyBmb3IgaXMgZm9yIHY0LjAgYW5kICJzZXNzaW9ucyINCj4gLQkgKiB3
aWxsIGJlIGZhbHNlLg0KPiAtCSAqLw0KPiArCS8qIEZvciB2NC4xKyB3ZSBzaG91bGQgaGF2ZSBn
b3R0ZW4gdGhlIGNsaWVudCBpbiB0aGUgU0VRVUVOQ0Ugb3A6ICovDQo+IAlXQVJOX09OX09OQ0Uo
Y3N0YXRlLT5zZXNzaW9uKTsNCj4gLQljc3RhdGUtPmNscCA9IGxvb2t1cF9jbGllbnRpZChjbGlk
LCBzZXNzaW9ucywgbm4pOw0KPiArCS8qIFNvIHdlJ3JlIGxvb2tpbmcgZm9yIGEgNC4wIGNsaWVu
dCAoc2Vzc2lvbnMgPSBmYWxzZSk6ICovDQo+ICsJY3N0YXRlLT5jbHAgPSBsb29rdXBfY2xpZW50
aWQoY2xpZCwgZmFsc2UsIG5uKTsNCj4gCWlmICghY3N0YXRlLT5jbHApDQo+IAkJcmV0dXJuIG5m
c2Vycl9leHBpcmVkOw0KPiAJcmV0dXJuIG5mc19vazsNCj4gQEAgLTQ2ODgsNyArNDY4NCw3IEBA
IG5mc2Q0X3Byb2Nlc3Nfb3BlbjEoc3RydWN0IG5mc2Q0X2NvbXBvdW5kX3N0YXRlICpjc3RhdGUs
DQo+IAlpZiAob3Blbi0+b3BfZmlsZSA9PSBOVUxMKQ0KPiAJCXJldHVybiBuZnNlcnJfanVrZWJv
eDsNCj4gDQo+IC0Jc3RhdHVzID0gc2V0X2NsaWVudChjbGllbnRpZCwgY3N0YXRlLCBubiwgZmFs
c2UpOw0KPiArCXN0YXR1cyA9IHNldF9jbGllbnQoY2xpZW50aWQsIGNzdGF0ZSwgbm4pOw0KPiAJ
aWYgKHN0YXR1cykNCj4gCQlyZXR1cm4gc3RhdHVzOw0KPiAJY2xwID0gY3N0YXRlLT5jbHA7DQo+
IEBAIC01Mjk4LDcgKzUyOTQsNyBAQCBuZnNkNF9yZW5ldyhzdHJ1Y3Qgc3ZjX3Jxc3QgKnJxc3Rw
LCBzdHJ1Y3QgbmZzZDRfY29tcG91bmRfc3RhdGUgKmNzdGF0ZSwNCj4gCXN0cnVjdCBuZnNkX25l
dCAqbm4gPSBuZXRfZ2VuZXJpYyhTVkNfTkVUKHJxc3RwKSwgbmZzZF9uZXRfaWQpOw0KPiANCj4g
CXRyYWNlX25mc2RfY2xpZF9yZW5ldyhjbGlkKTsNCj4gLQlzdGF0dXMgPSBzZXRfY2xpZW50KGNs
aWQsIGNzdGF0ZSwgbm4sIGZhbHNlKTsNCj4gKwlzdGF0dXMgPSBzZXRfY2xpZW50KGNsaWQsIGNz
dGF0ZSwgbm4pOw0KPiAJaWYgKHN0YXR1cykNCj4gCQlyZXR1cm4gc3RhdHVzOw0KPiAJY2xwID0g
Y3N0YXRlLT5jbHA7DQo+IEBAIC01NjgxLDcgKzU2NzcsNyBAQCBuZnNkNF9sb29rdXBfc3RhdGVp
ZChzdHJ1Y3QgbmZzZDRfY29tcG91bmRfc3RhdGUgKmNzdGF0ZSwNCj4gCWlmIChaRVJPX1NUQVRF
SUQoc3RhdGVpZCkgfHwgT05FX1NUQVRFSUQoc3RhdGVpZCkgfHwNCj4gCQlDTE9TRV9TVEFURUlE
KHN0YXRlaWQpKQ0KPiAJCXJldHVybiBuZnNlcnJfYmFkX3N0YXRlaWQ7DQo+IC0Jc3RhdHVzID0g
c2V0X2NsaWVudCgmc3RhdGVpZC0+c2lfb3BhcXVlLnNvX2NsaWQsIGNzdGF0ZSwgbm4sIGZhbHNl
KTsNCj4gKwlzdGF0dXMgPSBzZXRfY2xpZW50KCZzdGF0ZWlkLT5zaV9vcGFxdWUuc29fY2xpZCwg
Y3N0YXRlLCBubik7DQo+IAlpZiAoc3RhdHVzID09IG5mc2Vycl9zdGFsZV9jbGllbnRpZCkgew0K
PiAJCWlmIChjc3RhdGUtPnNlc3Npb24pDQo+IAkJCXJldHVybiBuZnNlcnJfYmFkX3N0YXRlaWQ7
DQo+IEBAIC02OTA1LDcgKzY5MDEsNyBAQCBuZnNkNF9sb2NrdChzdHJ1Y3Qgc3ZjX3Jxc3QgKnJx
c3RwLCBzdHJ1Y3QgbmZzZDRfY29tcG91bmRfc3RhdGUgKmNzdGF0ZSwNCj4gCQkgcmV0dXJuIG5m
c2Vycl9pbnZhbDsNCj4gDQo+IAlpZiAoIW5mc2Q0X2hhc19zZXNzaW9uKGNzdGF0ZSkpIHsNCj4g
LQkJc3RhdHVzID0gc2V0X2NsaWVudCgmbG9ja3QtPmx0X2NsaWVudGlkLCBjc3RhdGUsIG5uLCBm
YWxzZSk7DQo+ICsJCXN0YXR1cyA9IHNldF9jbGllbnQoJmxvY2t0LT5sdF9jbGllbnRpZCwgY3N0
YXRlLCBubik7DQo+IAkJaWYgKHN0YXR1cykNCj4gCQkJZ290byBvdXQ7DQo+IAl9DQo+IEBAIC03
MDg5LDcgKzcwODUsNyBAQCBuZnNkNF9yZWxlYXNlX2xvY2tvd25lcihzdHJ1Y3Qgc3ZjX3Jxc3Qg
KnJxc3RwLA0KPiAJZHByaW50aygibmZzZDRfcmVsZWFzZV9sb2Nrb3duZXIgY2xpZW50aWQ6ICgl
MDh4LyUwOHgpOlxuIiwNCj4gCQljbGlkLT5jbF9ib290LCBjbGlkLT5jbF9pZCk7DQo+IA0KPiAt
CXN0YXR1cyA9IHNldF9jbGllbnQoY2xpZCwgY3N0YXRlLCBubiwgZmFsc2UpOw0KPiArCXN0YXR1
cyA9IHNldF9jbGllbnQoY2xpZCwgY3N0YXRlLCBubik7DQo+IAlpZiAoc3RhdHVzKQ0KPiAJCXJl
dHVybiBzdGF0dXM7DQo+IA0KPiAtLSANCj4gMi4yOS4yDQo+IA0KDQotLQ0KQ2h1Y2sgTGV2ZXIN
Cg0KDQoNCg==
