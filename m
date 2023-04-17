Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD2006E5214
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Apr 2023 22:50:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229521AbjDQUt7 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 17 Apr 2023 16:49:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229898AbjDQUt5 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 17 Apr 2023 16:49:57 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2123.outbound.protection.outlook.com [40.107.237.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D16BA4C33
        for <linux-nfs@vger.kernel.org>; Mon, 17 Apr 2023 13:49:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HqrAqEW1ViAlV3MZCog5IHU2a3TL03pNJGDYBkbNZgMM11+94MFuBBPOCEi6KwzYBUmdmaM81nuylkujAkPi9eJNzh6a+N8UhCU9Sxyq46yAU4jsXy9Zvh6PctEZyCNXGIcfsdBDml8gY59owyhaL76ROwN+FzbfNbW8IrQSlAcR1apzmUBpHIS0K+d0tPRSW05Z8R/sYIBdI1SKSljJ6QVDf4c1RXgEknnvhI8TI5YsX2Q8u/9TNE77VJkWliMFIy3otY/8gQbe7qqEKqkxmcjyR9X1Bz90LcYGPT9bMsMxMpvcBGBEX/YA1A+PiKwqf1mYmXWd4QB2LYd8IWYWXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mXDMPaSPb9/MXqGxErOrPv7D0g0X4Qdmg7pDyGs4n2E=;
 b=lMkfJv1N2UBtCjjoNwYyNYfT3uwfiiGVZBHuFa8rknvD2lhTXF1gg+BCuu+8xHMRFwoPMAJGS20JowZ1ePIZ/rqtR+kizqz/WMqPcHFuUqYeyLl9E6XPW4r3t8PGEfO4nPV8CNm4gClGJmRiEw0lX50eU68//cFS8f704q2wc3RH57tzTZJH0zaMFppWA6OPsLXgZmDoo3rRthWs+yFMzrRejLtsUCtADYcNo5pEKK4R68KOB9dNFJUKMiudW9CM3M1iMI1aYBhxDftA9QNkO9Gj4AavtBRYA4ByuSrCfmHwK9vIu8XAK+z71Vqrp+C9vYuUUzKKfBQ2rn1O36qvCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mXDMPaSPb9/MXqGxErOrPv7D0g0X4Qdmg7pDyGs4n2E=;
 b=JpXM9QPLt+vMKxCvWzdFQLe0nPER58nlkxqdfcS46BeKv9eQQT9N1XnycotPVpd83+zzBmt349ee/7g5PngNl9vaRiF0jhnptHRR6K2+uKAuOGOhUS8BE+PA6LBwARU59ZkYirtisJdf/XAgj7D4+Tgka7lTdzJiP+AwYnPYSHQ=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by SJ0PR13MB5787.namprd13.prod.outlook.com (2603:10b6:a03:3ea::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.45; Mon, 17 Apr
 2023 20:49:48 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::3627:d466:b0ae:1740]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::3627:d466:b0ae:1740%3]) with mapi id 15.20.6298.045; Mon, 17 Apr 2023
 20:49:48 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "dai.ngo@oracle.com" <dai.ngo@oracle.com>,
        "jlayton@kernel.org" <jlayton@kernel.org>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] SUNRPC: increase max timeout for rebind to handle NFS
 server restart
Thread-Topic: [PATCH] SUNRPC: increase max timeout for rebind to handle NFS
 server restart
Thread-Index: AQHZacp/6QlIRljOckmeDtcvLmj9Dq8wCLWA
Date:   Mon, 17 Apr 2023 20:49:48 +0000
Message-ID: <ed95d6e3da7b2a27a27837f19ca39980037eb28d.camel@hammerspace.com>
References: <1680924600-11171-1-git-send-email-dai.ngo@oracle.com>
In-Reply-To: <1680924600-11171-1-git-send-email-dai.ngo@oracle.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|SJ0PR13MB5787:EE_
x-ms-office365-filtering-correlation-id: 41190c90-798d-43a9-392a-08db3f8548a9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /HHSlvkaJ/CSQloJQvXClGxuNLJRnvSGb0YTOCfxDQXza43qnKtnYxtDd7GCI8VEnxohc2vTzUm68ccnhS+MNYlTAGuvkQQrEiRou8kN6Mr8tmZssHZ2iKdAMSoxeA9QmovQRExPzsuf5C9XfgX6stCGvYfpXckj3WqMrTUNM4jjkbFO9L7b8CvJ6h6HrqZl4y7Hh5abt5TPWNJP5rpRqj8g99OPJBepAFcR4u4lXQz0sAd1zuyjztRS94ahwUQckWZAdOCPQNgGNedIeCeaIBQH6xK8su1gLntmtsqKujZrkzmr0hEZ1ualuDnAULSnRChrVCFTILZ9eOwvN8L4icPwuSH4MNodgD0pIOb+Eg+my/9L0iEfmyPI/AChx/dBBIe2A8BlUX0RMtlelmoP6Jlge4kf7Ilfof8QmScta5Df//1s9YssEbl8bhUXKI8Phhm/6+XNc0w/sptAtf+Eyj/RfY8Pk+1vYuybKy96bDTcpsYSblUDUD7GBaJEC1h8+7bTx1wzcko0qxcC9zTZJgIei+eZpa9/G82jsrqw2gG3D7aiyFOfe1KIxrlZGz2RGCv1TfOPNdDHgHD/pTosEA15CZNMqrOGofhRaRiYAUXGyATsFDRTYQRpHRPJii6I
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(39840400004)(376002)(136003)(346002)(366004)(451199021)(186003)(6512007)(41300700001)(6506007)(110136005)(86362001)(2616005)(83380400001)(4326008)(316002)(76116006)(64756008)(66446008)(66476007)(66556008)(2906002)(8676002)(8936002)(6486002)(122000001)(66946007)(38100700002)(36756003)(38070700005)(5660300002)(71200400001)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SFh1NE8xYkFiRXUzcXYrbys0Sm81NkdxUStEblBOSkdoSWNMQmVQeFMvaTNS?=
 =?utf-8?B?a0x4Qk9xeE9PTkg3ZCtOb1grUmw5YVhRTjhaMUFYTHl2NVlYWjZqQmVmbGt0?=
 =?utf-8?B?MVAxUmFkcmNPdXVURTVHWWRaKzMrWG1Kc1FKbUZQbGdvdmJVVnUyTUsxMHFS?=
 =?utf-8?B?VmxsSHl4OGd5azh1U2lybnFEaTdzMjJoV2RzbW4yLzRsYndhR0VZUWRaOUJr?=
 =?utf-8?B?ZzhVcS83V2VBd3loaVYyekx4KzdpTUFERzdMMWt0NkJUc2doQllLYVJtSFBC?=
 =?utf-8?B?bVpRMWpSOUJsL1FOeXROUzdBTld0bmp5bkJIOXJJZEtEcmFjTHdiN2haV2d0?=
 =?utf-8?B?YitWbkxTUlhVM0FkUlVOekwxOVFKNkN3MUs1bERHT21tYnVpSVlaV00wNmNV?=
 =?utf-8?B?RVVieDlHRkdCcjlXRm1UUTZ0UC9aVmtnS2N4dkc2TU1GV1dReVVvVHMyQkRZ?=
 =?utf-8?B?YWFueXRUWGtKWFdXOHB3QTg2MW11Z1V4SmpJNklNSTMwRlkrVG85N09GVkpW?=
 =?utf-8?B?V1ZXUml1a09XSFo3RFhzNlJLRXBQejNHOGZuOTRlM3FTOG1WUlBvaDJXR1hX?=
 =?utf-8?B?VEJoV0RKdi8ybXJxdG11TmZTRDVUbHVERmZHbi9vTFY2UkJDUVlLVnJQTTE1?=
 =?utf-8?B?Tm1UL21oNlh4UGZpUDNwMUxUazVJTkYzNmo5UHhnQWlFMDQvYk1kQVo5TVFx?=
 =?utf-8?B?dDZvQk9UbHRMU3k2MFFuQTRSdjFINXpod1RhVWpIR1hBSHl0dFdMVXp3dUJE?=
 =?utf-8?B?L09sOGI5ZUpoRUVNMDFzY1EvNURqb2R0dEh5MU45ZEowT0FkZjE4OFZ1eE9y?=
 =?utf-8?B?VDUvTGU5S1luSUhkQzcvYWQ4MGFkY2FLTHE5SzRGelk0UmlUbTFlMlpKd28v?=
 =?utf-8?B?RXgyRzBFaDYwbGVJOTBoV2FtS1RrMEt6a24rMHlpUTBMd2d6ZHFhUGRDTk9S?=
 =?utf-8?B?bVZHZGgrRkJOamJxZ2F4NXJxNjMwNmJKM3BRMVZtdFJQdVAvYmpJcllqVVZs?=
 =?utf-8?B?WWpWS3QzR3lLeWlKSks4cytRSFBkU21yVTVhVnJRWEs1UFY0WCtIcFVMcDQx?=
 =?utf-8?B?dzRoMUw5NC9Dak5xQzJTaXlxVUtQQ09WZGRQSHdweWhTOUNoTC9nMW5vYVEr?=
 =?utf-8?B?N1FtUi9JK014K3FQSWpxdWN4ZEM0cFdqZnJ1S0M3S0laR1dSUEFDV2lXOFZS?=
 =?utf-8?B?Y2xJVy9rS0lkbk5YdUFSY2RnLy93ZjMwV0l6cmFVcFhuYUcwZHcvbHFVai9K?=
 =?utf-8?B?YjIxck02cGVoU3lZejlidS9tblhwb2JqVHIvSG00MTVxR2VISWZPS2JURENK?=
 =?utf-8?B?dGdQczg1aGh0dUlja2RBcHF1SVhwZERHWk1YeGthWmR4WWI4MWlXUUVDNVFF?=
 =?utf-8?B?M0V4dzVHdnEwQ2JjdWxyQ2o5Nk4waFJlVjdSL1A4eVphUFM4STUwNlJRaStt?=
 =?utf-8?B?SUZ0RnFiRGxCR0JobmVzMHgxM2ZMN2NhZUdhVFRKS3JPRk5LcjB2b1dZZlJT?=
 =?utf-8?B?VHVrT1FuclhyQVhMSjBEYk9JR2JSUm43SUpUcklzUmZKdlpueExKUnV0Ynpk?=
 =?utf-8?B?STFYbHVDY0VYVkhOWThFTEl3Tk9vQmJMdGFEbE9xSXZkbURxWEhjT1JLTDRG?=
 =?utf-8?B?L2RtTGZUSGQ3WURsQTd1dDQ5ellNZERSN2VjYlM2STZnSWV2VWQ4NktaTkk1?=
 =?utf-8?B?K3dSV3BBaHJubVNYMnRQWklCSEJUTjJtVlRRSC8zZHpEZVY1eEFpcFZWZHpl?=
 =?utf-8?B?VDJWVnN5UG1teXpOSWowaUFrTTY4QWxNOVZNdmMveGlKc2Ftc1dKQTVFSFFz?=
 =?utf-8?B?K04rMERzMVBiNkZweVNNOXZKVGNPclBCcnRtZWdYTzUxanFvT3RKRHVHTHRs?=
 =?utf-8?B?ZnNhUThBWi9jUWdUTW9GOThxUkcvNHg1bXEzSTNoSnNlUTBnUzNqcDFJTW4y?=
 =?utf-8?B?QXo2bFVXMWlYNWRzcGgzQVJUNEJRbCtrci9Xa25DeVlOR0lPalU4Z2FxRmRH?=
 =?utf-8?B?cWFRVkY0WEorcnZ3QU1wcVI3eGFhYitDWEhaUVFTR2EvVGUvY2hKang1YUxl?=
 =?utf-8?B?RURIc0ZaQlRwWjJGK21KUFBIb2EyTW5UdFM2NmRFN1FMYlBFWE5ack5mZmFH?=
 =?utf-8?B?UFpQTTVyVHRyTEFyK2FmNzdEZUx3MjdqelErZVpVaTh3ODhsK1R6SHhoejJj?=
 =?utf-8?B?NDYyTndxUU5EWUFidGhCNzFJSjVNUStKQVg1UlY0N1V0U0g0MzFDOVJ1L0ZG?=
 =?utf-8?B?ZitVREl5RjBZMS8rOUZUK0lPUmRBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0CBD69E0CB5CAB498E9DFCFD836FDEA9@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41190c90-798d-43a9-392a-08db3f8548a9
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2023 20:49:48.5080
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jLK9f5uCFsPxcHMBq6IbR0OuHUUhEPOamQKeU97L3Ly4vj5AfDhND6JPvjHf+QQP1dlqsMhOgVWot7uA+vIzMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR13MB5787
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gRnJpLCAyMDIzLTA0LTA3IGF0IDIwOjMwIC0wNzAwLCBEYWkgTmdvIHdyb3RlOgo+IEN1cnJl
bnRseSBjYWxsX2JpbmRfc3RhdHVzIHBsYWNlcyBhIGhhcmQgbGltaXQgb2YgOSBzZWNvbmRzIGZv
cgo+IHJldHJpZXMKPiBvbiBFQUNDRVMgZXJyb3IuIFRoaXMgbGltaXQgd2FzIGRvbmUgdG8gcHJl
dmVudCB0aGUgUlBDIHJlcXVlc3QgZnJvbQo+IGJlaW5nIHJldHJpZWQgZm9yZXZlciBpZiB0aGUg
cmVtb3RlIHNlcnZlciBoYXMgcHJvYmxlbSBhbmQgbmV2ZXIKPiBjb21lcwo+IHVwCj4gCj4gSG93
ZXZlciB0aGlzIDkgc2Vjb25kcyB0aW1lb3V0IGlzIHRvbyBzaG9ydCwgY29tcGFyaW5nIHRvIG90
aGVyIFJQQwo+IHRpbWVvdXRzIHdoaWNoIGFyZSBnZW5lcmFsbHkgaW4gbWludXRlcy4gVGhpcyBj
YXVzZXMgaW50ZXJtaXR0ZW50Cj4gZmFpbHVyZQo+IHdpdGggRUlPIG9uIHRoZSBjbGllbnQgc2lk
ZSB3aGVuIHRoZXJlIGFyZSBsb3RzIG9mIE5MTSBhY3Rpdml0eSBhbmQKPiB0aGUKPiBORlMgc2Vy
dmVyIGlzIHJlc3RhcnRlZC4KPiAKPiBJbnN0ZWFkIG9mIHJlbW92aW5nIHRoZSBtYXggdGltZW91
dCBmb3IgcmV0cnkgYW5kIHJlbHlpbmcgb24gdGhlIFJQQwo+IHRpbWVvdXQgbWVjaGFuaXNtIHRv
IGhhbmRsZSB0aGUgcmV0cnksIHdoaWNoIGNhbiBsZWFkIHRvIHRoZSBSUEMKPiBiZWluZwo+IHJl
dHJpZWQgZm9yZXZlciBpZiB0aGUgcmVtb3RlIE5MTSBzZXJ2aWNlIGZhaWxzIHRvIGNvbWUgdXAu
IFRoaXMKPiBwYXRjaAo+IHNpbXBseSBpbmNyZWFzZXMgdGhlIG1heCB0aW1lb3V0IG9mIGNhbGxf
YmluZF9zdGF0dXMgZnJvbSA5IHRvIDkwCj4gc2Vjb25kcwo+IHdoaWNoIHNob3VsZCBhbGxvdyBl
bm91Z2ggdGltZSBmb3IgTkxNIHRvIHJlZ2lzdGVyIGFmdGVyIGEgcmVzdGFydCwKPiBhbmQKPiBu
b3QgcmV0cnlpbmcgZm9yZXZlciBpZiB0aGVyZSBpcyByZWFsIHByb2JsZW0gd2l0aCB0aGUgcmVt
b3RlIHN5c3RlbS4KPiAKPiBGaXhlczogMGI3NjAxMTNhM2ExICgiTkxNOiBEb24ndCBoYW5nIGZv
cmV2ZXIgb24gTkxNIHVubG9jawo+IHJlcXVlc3RzIikKPiBSZXBvcnRlZC1ieTogSGVsZW4gQ2hh
byA8aGVsZW4uY2hhb0BvcmFjbGUuY29tPgo+IFRlc3RlZC1ieTogSGVsZW4gQ2hhbyA8aGVsZW4u
Y2hhb0BvcmFjbGUuY29tPgo+IFNpZ25lZC1vZmYtYnk6IERhaSBOZ28gPGRhaS5uZ29Ab3JhY2xl
LmNvbT4KPiAtLS0KPiDCoGluY2x1ZGUvbGludXgvc3VucnBjL2NsbnQuaMKgIHwgMyArKysKPiDC
oGluY2x1ZGUvbGludXgvc3VucnBjL3NjaGVkLmggfCA0ICsrLS0KPiDCoG5ldC9zdW5ycGMvY2xu
dC5jwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8IDIgKy0KPiDCoG5ldC9zdW5ycGMvc2NoZWQuY8Kg
wqDCoMKgwqDCoMKgwqDCoMKgIHwgMyArKy0KPiDCoDQgZmlsZXMgY2hhbmdlZCwgOCBpbnNlcnRp
b25zKCspLCA0IGRlbGV0aW9ucygtKQo+IAo+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L3N1
bnJwYy9jbG50LmgKPiBiL2luY2x1ZGUvbGludXgvc3VucnBjL2NsbnQuaAo+IGluZGV4IDc3MGVm
MmNiNTc3NS4uODFhZmM1ZWEyNjY1IDEwMDY0NAo+IC0tLSBhL2luY2x1ZGUvbGludXgvc3VucnBj
L2NsbnQuaAo+ICsrKyBiL2luY2x1ZGUvbGludXgvc3VucnBjL2NsbnQuaAo+IEBAIC0xNjIsNiAr
MTYyLDkgQEAgc3RydWN0IHJwY19hZGRfeHBydF90ZXN0IHsKPiDCoCNkZWZpbmUgUlBDX0NMTlRf
Q1JFQVRFX1JFVVNFUE9SVMKgwqDCoMKgwqDCoCgxVUwgPDwgMTEpCj4gwqAjZGVmaW5lIFJQQ19D
TE5UX0NSRUFURV9DT05ORUNURUTCoMKgwqDCoMKgwqAoMVVMIDw8IDEyKQo+IMKgCj4gKyNkZWZp
bmXCoMKgwqDCoMKgwqDCoMKgUlBDX0NMTlRfUkVCSU5EX0RFTEFZwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoDMKPiArI2RlZmluZcKgwqDCoMKgwqDCoMKgwqBSUENfQ0xOVF9SRUJJTkRfTUFYX1RJTUVP
VVTCoMKgwqDCoMKgOTAKPiArCj4gwqBzdHJ1Y3QgcnBjX2NsbnQgKnJwY19jcmVhdGUoc3RydWN0
IHJwY19jcmVhdGVfYXJncyAqYXJncyk7Cj4gwqBzdHJ1Y3QgcnBjX2NsbnTCoMKgwqDCoMKgwqDC
oMKgKnJwY19iaW5kX25ld19wcm9ncmFtKHN0cnVjdCBycGNfY2xudCAqLAo+IMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBjb25z
dCBzdHJ1Y3QgcnBjX3Byb2dyYW0gKiwgdTMyKTsKPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51
eC9zdW5ycGMvc2NoZWQuaAo+IGIvaW5jbHVkZS9saW51eC9zdW5ycGMvc2NoZWQuaAo+IGluZGV4
IGI4Y2EzZWNhZjhkNy4uZTlkYzE0MmYxMGJiIDEwMDY0NAo+IC0tLSBhL2luY2x1ZGUvbGludXgv
c3VucnBjL3NjaGVkLmgKPiArKysgYi9pbmNsdWRlL2xpbnV4L3N1bnJwYy9zY2hlZC5oCj4gQEAg
LTkwLDggKzkwLDggQEAgc3RydWN0IHJwY190YXNrIHsKPiDCoCNlbmRpZgo+IMKgwqDCoMKgwqDC
oMKgwqB1bnNpZ25lZCBjaGFywqDCoMKgwqDCoMKgwqDCoMKgwqDCoHRrX3ByaW9yaXR5IDogMiwv
KiBUYXNrIHByaW9yaXR5ICovCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHRrX2dhcmJfcmV0cnkgOiAyLAo+IC3CoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHRr
X2NyZWRfcmV0cnkgOiAyLAo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHRrX3JlYmluZF9yZXRyeSA6IDI7Cj4gK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgdGtf
Y3JlZF9yZXRyeSA6IDI7Cj4gK8KgwqDCoMKgwqDCoMKgdW5zaWduZWQgY2hhcsKgwqDCoMKgwqDC
oMKgwqDCoMKgwqB0a19yZWJpbmRfcmV0cnk7Cj4gwqB9Owo+IMKgCj4gwqB0eXBlZGVmIHZvaWTC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCgqcnBjX2FjdGlvbikoc3RydWN0
IHJwY190YXNrICopOwo+IGRpZmYgLS1naXQgYS9uZXQvc3VucnBjL2NsbnQuYyBiL25ldC9zdW5y
cGMvY2xudC5jCj4gaW5kZXggZmQ3ZTFjNjMwNDkzLi4yMjI1NzhhZjZiMDEgMTAwNjQ0Cj4gLS0t
IGEvbmV0L3N1bnJwYy9jbG50LmMKPiArKysgYi9uZXQvc3VucnBjL2NsbnQuYwo+IEBAIC0yMDUz
LDcgKzIwNTMsNyBAQCBjYWxsX2JpbmRfc3RhdHVzKHN0cnVjdCBycGNfdGFzayAqdGFzaykKPiDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGlmICh0YXNrLT50a19yZWJpbmRfcmV0cnkg
PT0gMCkKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBi
cmVhazsKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHRhc2stPnRrX3JlYmluZF9y
ZXRyeS0tOwo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBycGNfZGVsYXkodGFzaywg
MypIWik7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJwY19kZWxheSh0YXNrLCBS
UENfQ0xOVF9SRUJJTkRfREVMQVkgKiBIWik7Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqBnb3RvIHJldHJ5X3RpbWVvdXQ7Cj4gwqDCoMKgwqDCoMKgwqDCoGNhc2UgLUVOT0JVRlM6
Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBycGNfZGVsYXkodGFzaywgSFogPj4g
Mik7Cj4gZGlmZiAtLWdpdCBhL25ldC9zdW5ycGMvc2NoZWQuYyBiL25ldC9zdW5ycGMvc2NoZWQu
Ywo+IGluZGV4IGJlNTg3YTMwOGUwNS4uNWMxOGEzNTc1MmFhIDEwMDY0NAo+IC0tLSBhL25ldC9z
dW5ycGMvc2NoZWQuYwo+ICsrKyBiL25ldC9zdW5ycGMvc2NoZWQuYwo+IEBAIC04MTcsNyArODE3
LDggQEAgcnBjX2luaXRfdGFza19zdGF0aXN0aWNzKHN0cnVjdCBycGNfdGFzayAqdGFzaykKPiDC
oMKgwqDCoMKgwqDCoMKgLyogSW5pdGlhbGl6ZSByZXRyeSBjb3VudGVycyAqLwo+IMKgwqDCoMKg
wqDCoMKgwqB0YXNrLT50a19nYXJiX3JldHJ5ID0gMjsKPiDCoMKgwqDCoMKgwqDCoMKgdGFzay0+
dGtfY3JlZF9yZXRyeSA9IDI7Cj4gLcKgwqDCoMKgwqDCoMKgdGFzay0+dGtfcmViaW5kX3JldHJ5
ID0gMjsKPiArwqDCoMKgwqDCoMKgwqB0YXNrLT50a19yZWJpbmRfcmV0cnkgPSBSUENfQ0xOVF9S
RUJJTkRfTUFYX1RJTUVPVVQgLwo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBSUENfQ0xOVF9SRUJJ
TkRfREVMQVk7CgpXaHkgbm90IGp1c3QgaW1wbGVtZW50IGFuIGV4cG9uZW50aWFsIGJhY2sgb2Zm
PyBJZiB0aGUgc2VydmVyIGlzIHNsb3cKdG8gY29tZSB1cCwgdGhlbiBwb3VuZGluZyB0aGUgcnBj
YmluZCBzZXJ2aWNlIGV2ZXJ5IDMgc2Vjb25kcyBpc24ndApnb2luZyB0byBoZWxwLgoKPiDCoAo+
IMKgwqDCoMKgwqDCoMKgwqAvKiBzdGFydGluZyB0aW1lc3RhbXAgKi8KPiDCoMKgwqDCoMKgwqDC
oMKgdGFzay0+dGtfc3RhcnQgPSBrdGltZV9nZXQoKTsKCi0tIApUcm9uZCBNeWtsZWJ1c3QKTGlu
dXggTkZTIGNsaWVudCBtYWludGFpbmVyLCBIYW1tZXJzcGFjZQp0cm9uZC5teWtsZWJ1c3RAaGFt
bWVyc3BhY2UuY29tCgoK
