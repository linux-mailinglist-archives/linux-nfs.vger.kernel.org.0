Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9061233BCE7
	for <lists+linux-nfs@lfdr.de>; Mon, 15 Mar 2021 15:36:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234924AbhCOOaM (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 15 Mar 2021 10:30:12 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:43090 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235293AbhCOO35 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 15 Mar 2021 10:29:57 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12FEPkPC046631;
        Mon, 15 Mar 2021 14:29:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=3iffQR/G8DPDJDWNeQ4qFcLHdPsQqcHTz51A7s+Pt+o=;
 b=0JBCeTqxvqNxxp+h8+jMvBEVhJzeBpewwo9xGo1gFDrSp/x/ATieXnpxwtk6O3RUVWTh
 taoFHHAjkYs4/Z9BICzSy0ohZxGcwtXw9Fyd7sVLnAx+XRwATrL9Myhh2C+HHNjj8Q9n
 Fr8ShEvY3iDDXv4FRkbIXBajA86vPxPvbaVduk099PSo/3nAuXjlQKfdV6Gx7VGnXrXl
 GYBzlZefsdC5JhspjNsFhM5Sqmu3u+JxLE7Oy4Ee8ckQtXBfQGIkSOOavWwJZv/+qx8i
 4mcdVLmPow2IaiJFzPhgHRd54qfIoSeXUh0jwVAI5X2uBvVzxplSqr1Sm//+v9S0w7lC Hg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2130.oracle.com with ESMTP id 378jwbc5au-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 Mar 2021 14:29:37 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12FETa5r086649;
        Mon, 15 Mar 2021 14:29:37 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2102.outbound.protection.outlook.com [104.47.58.102])
        by aserp3020.oracle.com with ESMTP id 37979ywyht-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 Mar 2021 14:29:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kvEXUZ/+vtZTsWISQaX2Tb92EgJTlMU0WalP8hDEnq+E7qNj+vWHjSS7Ab/Txz7N1/J+KvZck/NXiSBxRzxCFX2fSm/geyF/4wc5h5vSaDP6RBE4MSTMAecjDvWlGnY3pkdcvt9Mkv6jE+gnP/zFYSPyoSOxS3RBxQYI+1HNhdV5jhO2EdRx5mgIYtVbBT12O7jMUW0+FNdqAlLUC1wcGQxCZaWNYmMgqKcTqEaSxADaNYItJabFsnsqZfzhfW1W7y9EXF6Iboimw5wHuwOut2+aTjEo1EUzBnGFEg9wvlbtQYf7/0+E6a8dS7ZwQfxAw8ojUl6eF30AQPj0eiLjbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3iffQR/G8DPDJDWNeQ4qFcLHdPsQqcHTz51A7s+Pt+o=;
 b=BlnjbPR+MwGWFReHZMDTwfL9+VpUl9vBTtEe3kNWQpTMf85UW/mrtpBcle0jC07ofaGcQWLm8Y64fosvX3tNfZrOOZQqbnW5P39p/g/yp07xc0GfTcEcaoOZLjIfw6oFF9m9kN0mOP6RybIfhOlqCK/vCA6g4JP7Y9jshDJkSoDmin7fz6SBOIvHKKFg9ndnTN+LhzA4CFGe3HZ7xjqi6dQsBlHqkrNslcPMWyFfzGBBx9M0xjtngUgEX1VkwzUM+5H8u6FNFETXFeYSDIGyxJ8yqbAFqhVINkcJ6UBaQFRi7PnKhbDcI6d966GjZWq7WxiyHst9fUxZYtcK9iGMMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3iffQR/G8DPDJDWNeQ4qFcLHdPsQqcHTz51A7s+Pt+o=;
 b=qhj8MqkfZ/G8/GO2Y0Pi5byDUzbg+ztjj1DAPGmDdyDs44fNtfGMiwTj6F1JuYhNNpWWBhaQcAwe0u8VN0NG/1WK9DtDZApHMjTvMwKfwXl9leieMjLrUpyn0n3OYVAYNRQKsFsKSeSy0A3REqAyYoqpVdr53OnapCQErcWoobc=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by SJ0PR10MB4669.namprd10.prod.outlook.com (2603:10b6:a03:2ae::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.31; Mon, 15 Mar
 2021 14:29:31 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::50bf:7319:321c:96c9]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::50bf:7319:321c:96c9%4]) with mapi id 15.20.3933.032; Mon, 15 Mar 2021
 14:29:31 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Paul Menzel <pmenzel@molgen.mpg.de>
CC:     Bruce Fields <bfields@fieldses.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v4] nfsd: Log client tracking type log message as info
 instead of warning
Thread-Topic: [PATCH v4] nfsd: Log client tracking type log message as info
 instead of warning
Thread-Index: AQHXF4QMcZqDAZilKkOXhmJx3OtVZKqFIDAA
Date:   Mon, 15 Mar 2021 14:29:31 +0000
Message-ID: <00C0B25B-CAA7-4B72-9879-519859F34CAF@oracle.com>
References: <20210312190634.GE24008@fieldses.org>
 <20210312210259.77310-1-pmenzel@molgen.mpg.de>
In-Reply-To: <20210312210259.77310-1-pmenzel@molgen.mpg.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: molgen.mpg.de; dkim=none (message not signed)
 header.d=none;molgen.mpg.de; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [68.61.232.219]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 33fb582c-b3a1-44b7-7c7f-08d8e7bebfb9
x-ms-traffictypediagnostic: SJ0PR10MB4669:
x-microsoft-antispam-prvs: <SJ0PR10MB4669ABBC24D7538A3B5FEC72936C9@SJ0PR10MB4669.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: p1aDnWvm26n5K1Ca7vusvY3+w4Jcx4p/31PE82VhGeLpfq48BYsLPHW2OpCYeWhiXLXcZ2JoaItyIFRxZAle9KJCiBfiAgWT1Tp+rm0MJb59gbrOHqIu7TJ4E1K2IEMwqWisK4hY86U1uYx/gaInJlq76gnY7kIpAsNaufwAyNZlecafyu/xTt+qD0uDKFUkEIXfkFAWsJgBrM4Dhu31N2Y8q+qNxllkwSG8USR1uyh6YL3uzjoe38DvgqJOTPyNxfUe9PHo+T+UKn2Ti0kBJSll6pB8uW1uQxg48Tgn1L/5M6uvDaLdKa0U+Otgh6823rUfCHFDs0gSnTUgQAB4Vk5dWQeoQCZf5GzTuTNPLboKEALQ1O8je0MqoU/9/3Ek4/qn+lBnxLzcCL7GKsHkGIDOGlmyF/BHQRvT9SqtVuuLM9JKL8VBA2WO7pz5zH5+Yp7+xtlleXewIWcpPSmsJ+k6vVXTygRlm/bH5OyLUhIDVa2bTlblv5cmuP5JhkATpCOwtvwMpO+vH3vlzyB6DWr0Vt1UApVbFfiKj3mYJwB+NpDpxLJnHefrI1Q8OJVwvwcIl3OJdQ56o4fqlsC1QvRehHSLS7N/MbCVnVI0GNKbsDENfE6nE1fjzAWO0NFi
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(39860400002)(346002)(396003)(366004)(136003)(71200400001)(15650500001)(6512007)(33656002)(6916009)(186003)(316002)(26005)(86362001)(64756008)(2906002)(36756003)(66476007)(54906003)(66556008)(66446008)(53546011)(8936002)(6486002)(8676002)(4326008)(478600001)(91956017)(6506007)(5660300002)(66946007)(2616005)(83380400001)(76116006)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?bnpxYng5d2xNWi9SSllTUHJDbUVrQUVhVVZYYzk3d1g5ZU9tR3Nlb2doWk1Y?=
 =?utf-8?B?ZzNTUlozVDdnNW5MM1lRNW1vYmdReitSam1BRWc5SU9idzNtWFBXUVNmOHdk?=
 =?utf-8?B?ZlBvV1hobFR1Z2ZpN0FWcVU3ck5OTmpOTnRZa1FqMnE5L2pHK0crMUZiWlJo?=
 =?utf-8?B?d1FrSDFJaXFUNkZoN0QwWC9YSlBNbndWY1FLQkszenlnRmN6UkpkaytobnpU?=
 =?utf-8?B?MTNiOWlxN3h3V2dpQWpRZlJ1SEpOSURWVy9TV3U2YUZJakFYR0lvSzJubmpF?=
 =?utf-8?B?aE1Mbzg0aFI2WjI4WFlGaWkwNnRoazk4LzVmTm1wT3pSTXlYd1kyTnFqZHRh?=
 =?utf-8?B?K242UW1VaHlENkhCa1VQdkhNR2VkbWVVQXJBRjZJZStZVG4wSjNsNkV4SVJJ?=
 =?utf-8?B?S3NHcFNDTWdVaFdWWDI5OTYrS3ZxdUVhN3hYd21nS2ZSTzlXNnBJLzU3L3hY?=
 =?utf-8?B?OHhqVkkwa0YwemRQcCsxdW1CM1g0MnU5SExKbUhLVmNyeFZxcDFvYXFMdXli?=
 =?utf-8?B?SlVtTWhmYzZ6KzViWU1lNWFQcktHbUI5bW1IeUlEb01kWklEbmRwQURNWkU2?=
 =?utf-8?B?ZU91ZXBtNmpmSDk4TWNjQXFpN3ZFZ1hJeHJFcVJOY1NDN2ZaZDVhMUlkbmdv?=
 =?utf-8?B?NHRPcTZCTlYrSU1tdUp0Q2YxcVJjVVNtWlAxMVUwTnRJbGphQ2RMUjZJWDRt?=
 =?utf-8?B?eXpjM1dhNkxLNUcyUDVQMTVsMHNEN0hOUy9uNDZFNHFqdmFRZ21ncTAzUUZw?=
 =?utf-8?B?UFEzTXdkd2laOFFiNld5NjBxbUlBNFkrTlVkOVJzNmtmb0ttNnVzVjE5V2g2?=
 =?utf-8?B?bEs3VEJoSmh4ZzhrSWprcmY4MGp6MWN0alpFcktGYzZLbFhVKzlna3ByTzV5?=
 =?utf-8?B?OHR2dit4NDZaRGpVcDMwTW1YMUZDcXcrOS9UcWMyQmVHbTZCRTd1N1VXOVFx?=
 =?utf-8?B?OVp1a0ZUakR5anlUUE0raDNSbDJ5VVFnTWFKbmZUN2JHSmZqa1J3K1JnTERh?=
 =?utf-8?B?V1dGK0pVcEc4L08wd01jdXBITzQxNkZxY25ReS9GNGkreTdSeGNMYUFoVWt2?=
 =?utf-8?B?cUF6NWhWOEVDU1dwSy9jdzQ1YzNZYlZIZTRuRzY4UGN6TlVyNXgrcnR1b001?=
 =?utf-8?B?cVZzWGtvUmtkbllMeElSYy9jdFRBWmRXdEF4bXowZW9NRjlGZmhPSlZreUxk?=
 =?utf-8?B?SUc0dFo0MHRmWlV2SXIrRFU0R1FyclRIZ3ZZc29UWXlBVUZZRnVrSWorOEJH?=
 =?utf-8?B?ejBBMS9lSFZYMFc2czBCQUpVRUUrbnZJUG94MUdaRmkvYjluRFJrUkhvQTd0?=
 =?utf-8?B?bnA3cStoSGJIKy9yQk5ydzFUdXY4QlhCYlhlWmJFc1h2R3pKTWcvd29pT2JS?=
 =?utf-8?B?ZmQvMlorWFdpTzNHcHJSMGZPOUFNdWlZUGNFdVgwVEY4TndtU1RJYkVBWk1q?=
 =?utf-8?B?bnhXa3VNdWE4bkx6SFUycUJiaVorYS9lN1d1ZWNBZXlqSTZaUGt0OFA1R2VX?=
 =?utf-8?B?cERnV2d2QzVZRHhJajlKeTBVS3VLeHkzaTkrRmJ5LytQR2lycXk4N0psNlN2?=
 =?utf-8?B?N2RtUTAyQ2o0NnQ2MXp0eDVOSUsvUzhZNk9vTFdtckY2bEVUd0lBL0QzTzRB?=
 =?utf-8?B?aGY2YWllK3l4NUhrcmI1REJTS2x4NGE2S0NBMkVNdzJTTkRnbDNrSTJ4THhU?=
 =?utf-8?B?SzVEemVINzdVWlJHdEVjZmg1OXVtT2RKVEtaN0dYQ2RqMEZtT0puTlFSTnZC?=
 =?utf-8?Q?LNY3ehdGC3dDaOoeLRo3Ry/Gh4XPf4i4QKyEc0C?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <CED6F8FF2984914EBC8D584E320581CD@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33fb582c-b3a1-44b7-7c7f-08d8e7bebfb9
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2021 14:29:31.7878
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WSJ38tbhUJBhoXzbGxx4mRrusIySEC2LTDY5FCDC5K4YbuGqfypQVoUSzNACs/oBR+pkTU6ZqYz+HjrsehObig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4669
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9923 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 malwarescore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103150105
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9923 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 spamscore=0 mlxscore=0 bulkscore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 adultscore=0 phishscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103150104
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

DQoNCj4gT24gTWFyIDEyLCAyMDIxLCBhdCA0OjAzIFBNLCBQYXVsIE1lbnplbCA8cG1lbnplbEBt
b2xnZW4ubXBnLmRlPiB3cm90ZToNCj4gDQo+IGBwcmludGsoKWAsIGJ5IGRlZmF1bHQsIHVzZXMg
dGhlIGxvZyBsZXZlbCB3YXJuaW5nLCB3aGljaCBsZWF2ZXMgdGhlDQo+IHVzZXIgcmVhZGluZw0K
PiANCj4gICAgTkZTRDogVXNpbmcgVU1IIHVwY2FsbCBjbGllbnQgdHJhY2tpbmcgb3BlcmF0aW9u
cy4NCj4gDQo+IHdvbmRlcmluZyB3aGF0IHRvIGRvIGFib3V0IGl0IChgZG1lc2cgLS1sZXZlbD13
YXJuYCkuDQo+IA0KPiBTZXZlcmFsIGNsaWVudCB0cmFja2luZyBtZXRob2RzIGFyZSB0cmllZCwg
YW5kIGV4cGVjdGVkIHRvIGZhaWwuIFRoYXTigJlzDQo+IHdoeSBhIG1lc3NhZ2UgaXMgcHJpbnRl
ZCBvbmx5IG9uIHN1Y2Nlc3MuIEl0IG1pZ2h0IGJlIGludGVyZXN0aW5nIGZvcg0KPiB1c2VycyB0
byBrbm93IHRoZSBjaG9zZW4gbWV0aG9kLCBzbyB1c2UgaW5mby1sZXZlbCBpbnN0ZWFkIG9mDQo+
IGRlYnVnLWxldmVsLg0KPiANCj4gQ2M6IGxpbnV4LW5mc0B2Z2VyLmtlcm5lbC5vcmcNCj4gU2ln
bmVkLW9mZi1ieTogUGF1bCBNZW56ZWwgPHBtZW56ZWxAbW9sZ2VuLm1wZy5kZT4NCg0KSGkgUGF1
bCwgSSd2ZSBpbmNsdWRlZCB5b3VyIHBhdGNoIGluIHRoZSBmb3ItbmV4dCB0b3BpYyBicmFuY2gg
YXQNCg0KZ2l0Oi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L2NlbC9s
aW51eC5naXQNCg0KDQo+IC0tLQ0KPiB2NDogUmVtb3ZlIGVycm9yIG1lc3NhZ2UsIGFuZCB1c2Ug
aW5mby1sZXZlbCwgYXMgc2V2ZXJhbCBjbGllbnQgdHJhY2tpbmcNCj4gbWV0aG9kcyBhcmUgdHJp
ZWQuDQo+IA0KPiBmcy9uZnNkL25mczRyZWNvdmVyLmMgfCA4ICsrKystLS0tDQo+IDEgZmlsZSBj
aGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0
IGEvZnMvbmZzZC9uZnM0cmVjb3Zlci5jIGIvZnMvbmZzZC9uZnM0cmVjb3Zlci5jDQo+IGluZGV4
IDg5MTM5NWM2YzdkMy4uNmZlZGM0OTcyNmJmIDEwMDY0NA0KPiAtLS0gYS9mcy9uZnNkL25mczRy
ZWNvdmVyLmMNCj4gKysrIGIvZnMvbmZzZC9uZnM0cmVjb3Zlci5jDQo+IEBAIC02MjYsNyArNjI2
LDcgQEAgbmZzZDRfbGVnYWN5X3RyYWNraW5nX2luaXQoc3RydWN0IG5ldCAqbmV0KQ0KPiAJc3Rh
dHVzID0gbmZzZDRfbG9hZF9yZWJvb3RfcmVjb3ZlcnlfZGF0YShuZXQpOw0KPiAJaWYgKHN0YXR1
cykNCj4gCQlnb3RvIGVycjsNCj4gLQlwcmludGsoIk5GU0Q6IFVzaW5nIGxlZ2FjeSBjbGllbnQg
dHJhY2tpbmcgb3BlcmF0aW9ucy5cbiIpOw0KPiArCXByX2luZm8oIk5GU0Q6IFVzaW5nIGxlZ2Fj
eSBjbGllbnQgdHJhY2tpbmcgb3BlcmF0aW9ucy5cbiIpOw0KPiAJcmV0dXJuIDA7DQo+IA0KPiBl
cnI6DQo+IEBAIC0xMDI4LDcgKzEwMjgsNyBAQCBuZnNkNF9pbml0X2NsZF9waXBlKHN0cnVjdCBu
ZXQgKm5ldCkNCj4gDQo+IAlzdGF0dXMgPSBfX25mc2Q0X2luaXRfY2xkX3BpcGUobmV0KTsNCj4g
CWlmICghc3RhdHVzKQ0KPiAtCQlwcmludGsoIk5GU0Q6IFVzaW5nIG9sZCBuZnNkY2xkIGNsaWVu
dCB0cmFja2luZyBvcGVyYXRpb25zLlxuIik7DQo+ICsJCXByX2luZm8oIk5GU0Q6IFVzaW5nIG9s
ZCBuZnNkY2xkIGNsaWVudCB0cmFja2luZyBvcGVyYXRpb25zLlxuIik7DQo+IAlyZXR1cm4gc3Rh
dHVzOw0KPiB9DQo+IA0KPiBAQCAtMTYwNSw3ICsxNjA1LDcgQEAgbmZzZDRfY2xkX3RyYWNraW5n
X2luaXQoc3RydWN0IG5ldCAqbmV0KQ0KPiAJCW5mczRfcmVsZWFzZV9yZWNsYWltKG5uKTsNCj4g
CQlnb3RvIGVycl9yZW1vdmU7DQo+IAl9IGVsc2UNCj4gLQkJcHJpbnRrKCJORlNEOiBVc2luZyBu
ZnNkY2xkIGNsaWVudCB0cmFja2luZyBvcGVyYXRpb25zLlxuIik7DQo+ICsJCXByX2luZm8oIk5G
U0Q6IFVzaW5nIG5mc2RjbGQgY2xpZW50IHRyYWNraW5nIG9wZXJhdGlvbnMuXG4iKTsNCj4gCXJl
dHVybiAwOw0KPiANCj4gZXJyX3JlbW92ZToNCj4gQEAgLTE4NjQsNyArMTg2NCw3IEBAIG5mc2Q0
X3VtaF9jbHRyYWNrX2luaXQoc3RydWN0IG5ldCAqbmV0KQ0KPiAJcmV0ID0gbmZzZDRfdW1oX2Ns
dHJhY2tfdXBjYWxsKCJpbml0IiwgTlVMTCwgZ3JhY2Vfc3RhcnQsIE5VTEwpOw0KPiAJa2ZyZWUo
Z3JhY2Vfc3RhcnQpOw0KPiAJaWYgKCFyZXQpDQo+IC0JCXByaW50aygiTkZTRDogVXNpbmcgVU1I
IHVwY2FsbCBjbGllbnQgdHJhY2tpbmcgb3BlcmF0aW9ucy5cbiIpOw0KPiArCQlwcl9pbmZvKCJO
RlNEOiBVc2luZyBVTUggdXBjYWxsIGNsaWVudCB0cmFja2luZyBvcGVyYXRpb25zLlxuIik7DQo+
IAlyZXR1cm4gcmV0Ow0KPiB9DQo+IA0KPiAtLSANCj4gMi4zMC4yDQo+IA0KDQotLQ0KQ2h1Y2sg
TGV2ZXINCg0KDQoNCg==
