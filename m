Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8953B328910
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Mar 2021 18:52:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238547AbhCARtb (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 1 Mar 2021 12:49:31 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:39440 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238192AbhCARpt (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 1 Mar 2021 12:45:49 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 121Hfmen098227;
        Mon, 1 Mar 2021 17:44:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=QIfnZPTkwu8O+jT5dlRtXWF9BnBhLhDI7qFvdm/JegU=;
 b=N54FQZWlp3OxDMTTAvM6aqN5SYI1mwGNPGV4GO3TlicMpqgWZULvmOgXPjdOfQTD6N3+
 rGeWxzRbF74OfuG9XFdn0zIQNa2Snlx8d0iGZJXmGFyM+dIsy4p3A12L9O8byqO0pT+V
 nBLT+63Ux6YYsrH4liVCKXkkCam+ICK7FL4cn/QiQ+YocC1uBww9X6vM4XBHtdybi1mX
 x3ie7GaANipwExBCHOjK0RVK4Pdw3/roGomBXDzlHJ92wBQzwASqbW51lDPtIwqg7jYi
 tMX+q1qXvtzg2JpOGQa+AKrrmRqwE6fVC5PDG4c2H4l3TQPCM9bNc7Z3LFd0d+zC+u7N mQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 36ye1m4rf8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 01 Mar 2021 17:44:04 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 121Heuso014924;
        Mon, 1 Mar 2021 17:44:03 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2104.outbound.protection.outlook.com [104.47.58.104])
        by aserp3020.oracle.com with ESMTP id 36yyyxsh04-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 01 Mar 2021 17:44:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RvZ5MnDg6dxvUA04YRHaVQ9h2w2ONQsh6TxAUEt2/W1KTWg4ZO8FPMhIfVTMRFPBumcr+W6aicNzR/UNIIagP/PDAxLWqLuEpgaqsBLuumJkMXrYZtyJ4u3x0+JVdddt7tjZmz4W5OCBncxmQ+QmGDRDLEdrspZU/dxe98MFc2mB6QfIZPMLrFT0LTmzGloUgHhigEQIW321Drg2HXCp64VLsxWGm54QBhFRvrPgBPXeZAQeEnWePpNw8gv+G4il0DSwoZEv0oB3LiaQjmTLForwrBak4M0sMGSeYRxaSZClTZw1HPQqqR5KmUbYx7qJVewq+AItc25f2Om2I5VyCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QIfnZPTkwu8O+jT5dlRtXWF9BnBhLhDI7qFvdm/JegU=;
 b=Qz4lPmi1gYVNz7Plmwg59BbhnhdVkSjyrZb0NJZWG+q5DX/k3OnkEjXSqTPLcj4eZ8Qf+okXss0rgu2zdeFR2ouflyuQse0oCpmvs0ZBV2uRdNwZmO0HQTpC8tNwH3rnNBpVUPfbcz2tT/qIf5Mb2v5Od+vJmk3/y81F9NuyCHBtFXol1W56W69sgYtC27KNgi5u18ZDx2RVRVPD4Dlh4VBkQlB8zaGzPkRlP6hmqHaLHVz6Jsp2NdDicWWzbQGainPPcHxgJJIytRcl4ieebnJUAr3aGgFZOmn5onQRy0uOmkkVqBx20to0wo/Wu5iuz/PqKPav73+R9B6y7Pq4Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QIfnZPTkwu8O+jT5dlRtXWF9BnBhLhDI7qFvdm/JegU=;
 b=pIOlc1QrCUnMgnQiNbeZ7PWnp45L3dsNUhcy0MFeF/WhB478xfuPSHzxSniImc0Siikk6q9YRfAiBE4Gm7newSTLuDgUwWu3JnoTCbQPzGvpIFDuGoIxriHsF1QiKpGo0HX3pkihimIXkpms43JPJ5nCUqgSPtlionYFqujUMEw=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by SJ0PR10MB4495.namprd10.prod.outlook.com (2603:10b6:a03:2d6::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.20; Mon, 1 Mar
 2021 17:44:02 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::6da8:6d28:b83:702b]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::6da8:6d28:b83:702b%4]) with mapi id 15.20.3890.028; Mon, 1 Mar 2021
 17:44:02 +0000
From:   Chuck Lever <chuck.lever@oracle.com>
To:     Bruce Fields <bfields@fieldses.org>
CC:     Daniel Kobras <kobras@puzzle-itc.de>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] sunrpc: fix refcount leak for rpc auth modules
Thread-Topic: [PATCH] sunrpc: fix refcount leak for rpc auth modules
Thread-Index: AQHXDJPLGG4N2gFkYEKpGIw1cGBThqpvQ6UAgAAS+wCAABUlgA==
Date:   Mon, 1 Mar 2021 17:44:02 +0000
Message-ID: <F2DE890D-C2D7-476A-AF6F-949B105728E9@oracle.com>
References: <20210226230437.jfgagcq5magzlrtv@tuedko18.puzzle-itc.de>
 <C2704113-2581-4B58-806B-BB65148AC14B@oracle.com>
 <20210301162820.GB11772@fieldses.org>
In-Reply-To: <20210301162820.GB11772@fieldses.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: fieldses.org; dkim=none (message not signed)
 header.d=none;fieldses.org; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [68.61.232.219]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7ffaf67c-3020-4d19-1889-08d8dcd999f7
x-ms-traffictypediagnostic: SJ0PR10MB4495:
x-microsoft-antispam-prvs: <SJ0PR10MB44959BE469891B7F66FAB39A939A9@SJ0PR10MB4495.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yfBalh6l9cRdFsdQLlbCiWesaleMZegYMBDUoUC7KW7nNfbA6PIamT+fk0OTZ2qH3jo7HKhJ4X+QLcIUqnrYYVl8mrsZuNin/ZqtoOWwVa79u5u0doZcgUFrUvgaserAJUChrFubZSx2KrrAiIH+ukMAdzIvayTwG/itcUYW60tlnyZ6EeWq3Geoi0KJqSAtoKrpvHq6B4tpYYqX1QNknx8Vanf+kpiyyUnG1Igzfcfcgh3Sg3uuYuymMCgvaydw6YpOCPLYqyjVcAhV7qHNI1YjI9eJSxH1wo8dNR3xBDQwxSEKfBWHU4G7UHA5NtreRsi5VKo4sMryqKh0npsV5hAQJTfFON+NHKBnsIVQhOyhDUHkV9OaO5I5IfLdn/4YxQ55j44irtj3dlT5J1Odi0KpKbxdhQr9rAO8Hoa/zOR8D0OrM2yNSEtb0JR1/vjJkuflajAkqcfIY1EpTflsgfygbavEyGHUAFOlWjs7zWdZpxk8sBL7XhG5BkvfcOI+DOndvoanFo2zy92n99WDkuVXuLseKLc2Klj/qdDM1yt+W8aBOcvtoVKNtPQ4zLBoIrWqlzmQOvCcqTCfQ+o62w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(136003)(346002)(396003)(366004)(376002)(2616005)(76116006)(44832011)(64756008)(2906002)(66476007)(91956017)(66446008)(8936002)(66556008)(66946007)(83380400001)(4326008)(6512007)(36756003)(5660300002)(6916009)(6506007)(53546011)(33656002)(478600001)(86362001)(71200400001)(54906003)(26005)(316002)(186003)(8676002)(66574015)(6486002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?NmMyQWNhSm9GRTRBOUkxT2xoSXBFelJDTkdrK05uVGFJMjNhK05obTY4TjQw?=
 =?utf-8?B?VTlId0tGdGoxeHNiVEVqUXlrckJSeWtxZEJRZ21JcWEyeEVzbVdkWjlyYVYz?=
 =?utf-8?B?N1EwZW5NL3Qvb1J4c25UOFluVzUzaFU1eE9sVzA0TzBMY3hnM0dGVU8vSHRR?=
 =?utf-8?B?a1RhSk5aeC96U0JyOG5rS01rOVdyWHhWV2NXb3NrOVRNUkVHTU94bEErU0w4?=
 =?utf-8?B?a1B5MUNxWG9oL0pueUM4TjlnMGVzVnhGWlUrcjM3TUZPMy9wWTQycXNXK1lS?=
 =?utf-8?B?WS8vVXhYZDdhVWRBL1lzNGNLdnJKcWJWL1dvai9ib0dtemcwa3BjZzltTGpK?=
 =?utf-8?B?MTgvZ2RZclZ3NkFWRGtXclpnU0t5UGUzUHNQeEtoSC9oTFFqWTZvaXVHb2xz?=
 =?utf-8?B?bjRvYThDSXhXMkYveTJyUzlaMlpGQWdiRnRJZjQ1Uy91bUlLUUdpOGJEYXJ3?=
 =?utf-8?B?S09sQVI1SC8wQ1QyZ2t6MWlUN2laQkExUDVzTzRMV0FxVnJWdDNMRkRseHZI?=
 =?utf-8?B?cHp3TGE3TkNwTFVNbEpNcElaL1BYOWk0ZXUraEF3L2dKUVpSL1d0ZU9Mb2Ro?=
 =?utf-8?B?aG5GQlF0YlBWaVZpR0RqaHp3VEVLd21TMjNZSzR0cWN3UFVZUUtSQkVqWGZx?=
 =?utf-8?B?SWxNbnpLblRGVTN3THFOVWRxTDZxTU9VbEp6c0NZSTFlZm9XQ0NNWVVhcUhm?=
 =?utf-8?B?b2ExSGtaUWxNUTcwTXNyZ2lpaExuYXUvMytVNmsyTk5Hc3UyNFh0L0w2WUd0?=
 =?utf-8?B?ZXArUytSWVFpRmpuQ2lTbVVNcUhoaFFWaWNMZkhOTmFuai9WZWh5TGxXQlc3?=
 =?utf-8?B?RUdUNE01VlRpdXVpbGNBVmNrd2ZxalJmMzc2U3NxWXpVdnRCaVJnZ3lITmVG?=
 =?utf-8?B?T2NKR0orcGlkV3hWSmRpTFZNSThPRVFwRFFudUhITDRJVXdKM0IxMkhWTld5?=
 =?utf-8?B?UURKTGIrZllRZzZFYjFXb1RDY2U3T0lUMTVqRXlFemNUd0dCSzZxSnRqUldM?=
 =?utf-8?B?NzVOOFl4NjRVbGVoTExoWTBKSURaT2oxVEpZajI2UTFCNHBhWndYTmJZcmc2?=
 =?utf-8?B?S1JTckJSeDdJS1gwRkU4aXc5Ykk0SGFXQUEvZW9KNk5iS0duVFpGUUlxYlZC?=
 =?utf-8?B?aGoycTZRUVdVSkh2a1kyQ1dDN1ZnNkFscnRoLzJSTHc4YzdJYjVlSlZtTy9m?=
 =?utf-8?B?STNzQWRuU0hHWUsyR25DWHI0Um0wU05uaTRmMUhhZWVCdGRuclNZVTFVMmJU?=
 =?utf-8?B?OFZqQnN1ZEpCSU9WcHJBZStKU2FHSkdHMmhiQUdneXhZMkxsOFFFcFpCd2FG?=
 =?utf-8?B?UmZiRGZXNTJOYk5YRW5pMTNQM1VseE5UZnd1UUc4S1UvUGY2U3pJZnhabHVC?=
 =?utf-8?B?aGt1RndDKzc2by8yNlIxVzRBYmRDdExSK2dzSDFOaUR0dkM3eGJRbDJhT2Fn?=
 =?utf-8?B?bkdYOHArSFRyOHF1K1Z6NkRVQlBQWlRrNUNGZDE2ZXdiWFlxZmlpT1NsN1VB?=
 =?utf-8?B?eHNzRy8xaUdTdGVudVk5bGROQXJsaEcwQmdlZHExcWw2LzI3ckhSb1FudUZn?=
 =?utf-8?B?aXZBaFpMa0VhWUNtMUx6MDNmSC9rTHVaalE1RkxVeHlUQ3NFZEdxWnpKakkr?=
 =?utf-8?B?a1lYZnpiRlRHaXRLSU9icU80QlpLa3ZDUUM5VEdVWmJsNW1VSlJobDRhaVVp?=
 =?utf-8?B?cWZEOUVoY3djSmZXc2RLTHducDYwRVh6eVRjYWs0bUozekZWdHA2d1J1TGZw?=
 =?utf-8?Q?UNBezDH2+bENOfgZqlI9lbp1BNfMjmrVhx6Aodu?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <00C227A38649364BA95060D53FC49479@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ffaf67c-3020-4d19-1889-08d8dcd999f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2021 17:44:02.1379
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G4vMIJDtNy0armZysWh/Z7l3+NSQOMNgJgirAvEYunkRQukQFbj8XfLLn3iOwcrZ22/G3IeQ/kNImO89YZ2tkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4495
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9910 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 mlxscore=0 spamscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103010142
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9910 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 priorityscore=1501
 mlxlogscore=999 impostorscore=0 suspectscore=0 adultscore=0 malwarescore=0
 mlxscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103010141
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

DQoNCj4gT24gTWFyIDEsIDIwMjEsIGF0IDExOjI4IEFNLCBCcnVjZSBGaWVsZHMgPGJmaWVsZHNA
ZmllbGRzZXMub3JnPiB3cm90ZToNCj4gDQo+IE9uIE1vbiwgTWFyIDAxLCAyMDIxIGF0IDAzOjIw
OjI0UE0gKzAwMDAsIENodWNrIExldmVyIHdyb3RlOg0KPj4gDQo+Pj4gT24gRmViIDI2LCAyMDIx
LCBhdCA2OjA0IFBNLCBEYW5pZWwgS29icmFzIDxrb2JyYXNAcHV6emxlLWl0Yy5kZT4gd3JvdGU6
DQo+Pj4gDQo+Pj4gSWYgYW4gYXV0aCBtb2R1bGUncyBhY2NlcHQgb3AgcmV0dXJucyBTVkNfQ0xP
U0UsIHN2Y19wcm9jZXNzX2NvbW1vbigpDQo+Pj4gZW50ZXJzIGEgY2FsbCBwYXRoIHRoYXQgZG9l
cyBub3QgY2FsbCBzdmNfYXV0aG9yaXNlKCkgYmVmb3JlIGxlYXZpbmcgdGhlDQo+Pj4gZnVuY3Rp
b24sIGFuZCB0aHVzIGxlYWtzIGEgcmVmZXJlbmNlIG9uIHRoZSBhdXRoIG1vZHVsZSdzIHJlZmNv
dW50LiBIZW5jZSwNCj4+PiBtYWtlIHN1cmUgY2FsbHMgdG8gc3ZjX2F1dGhlbnRpY2F0ZSgpIGFu
ZCBzdmNfYXV0aG9yaXNlKCkgYXJlIHBhaXJlZCBmb3INCj4+PiBhbGwgY2FsbCBwYXRocywgdG8g
bWFrZSBzdXJlIHJwYyBhdXRoIG1vZHVsZXMgY2FuIGJlIHVubG9hZGVkLg0KPj4+IA0KPj4+IEZp
eGVzOiA0ZDcxMmVmMWRiMDUgKCJzdmNhdXRoX2dzczogQ2xvc2UgY29ubmVjdGlvbiB3aGVuIGRy
b3BwaW5nIGFuIGluY29taW5nIG1lc3NhZ2UiKQ0KPj4+IFNpZ25lZC1vZmYtYnk6IERhbmllbCBL
b2JyYXMgPGtvYnJhc0BwdXp6bGUtaXRjLmRlPg0KPj4+IC0tLQ0KPj4+IEhpIQ0KPj4+IA0KPj4+
IFdoaWxlIGRlYnVnZ2luZyBORlMgb24gYSBzeXN0ZW0gd2l0aCBtaXNjb25maWd1cmVkIGtyYjUg
c2V0dGluZ3MsIHdlIG5vdGljZWQNCj4+PiBhIHN1c3BpY2lvdXNseSBoaWdoIHJlZmNvdW50IG9u
IHRoZSBhdXRoX3JwY2dzcyBtb2R1bGUsIGRlc3BpdGUgYWxsIG9mIGl0cw0KPj4+IGNvbnN1bWVy
cyBhbHJlYWR5IHVubG9hZGVkLiBJIHdhc24ndCBhYmxlIHRvIGFuYWx5emUgYW55IGZ1cnRoZXIg
b24gdGhlIGxpdmUNCj4+PiBzeXN0ZW0sIGJ1dCBoYWQgYSBsb29rIGF0IHRoZSBjb2RlIGFmdGVy
d2FyZHMsIGFuZCBmb3VuZCBhIHBhdGggdGhhdCBzZWVtcw0KPj4+IHRvIGxlYWsgcmVmZXJlbmNl
cyBpZiB0aGUgbWVjaGFuaXNtJ3MgYWNjZXB0KCkgb3Agc2h1dHMgZG93biBhIGNvbm5lY3Rpb24N
Cj4+PiBlYXJseS4gQWx0aG91Z2ggSSBjb3VsZG4ndCB2ZXJpZnksIHRoaXMgc2VlbSB0byBiZSBh
IHBsYXVzaWJsZSBmaXguDQo+Pj4gDQo+Pj4gS2luZCByZWdhcmRzLA0KPj4+IA0KPj4+IERhbmll
bA0KPj4gDQo+PiBIaSBEYW5pZWwtDQo+PiANCj4+IEkndmUgcHJvdmlzaW9uYWxseSBpbmNsdWRl
ZCB5b3VyIHBhdGNoIGluIG15IE5GU0QgZm9yLXJjIHRvcGljIGJyYW5jaA0KPj4gaGVyZToNCj4+
IA0KPj4gZ2l0Oi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L2NlbC9s
aW51eC5naXQNCj4+IA0KPj4gWW91ciBidWcgcmVwb3J0IHNlZW1zIHBsYXVzaWJsZSwgYnV0IEkg
bmVlZCB0byB0YWtlIGEgY2xvc2VyIGxvb2sgYXQgdGhhdA0KPj4gY29kZSBhbmQgeW91ciBwcm9w
b3NlZCBjaGFuZ2UuIFdvdWxkIHZlcnkgbXVjaCBsaWtlIHRvIGhlYXIgZnJvbSBvdGhlcnMsDQo+
PiB0b28uDQo+IA0KPiBTbywgdGhlIGVmZmVjdCBvZiB0aGlzIGlzIHRvIGNhbGwgc3ZjX2F1dGhv
cmlzZSBtb3JlIG9mdGVuLiAgSSB0aGluaw0KPiB0aGF0J3MgYWx3YXlzIHNhZmUsIGJlY2F1c2Ug
c3ZjX2F1dGhvcmlzZSBpcyBhIG5vLW9wIHVubGVzcyBycV9hdXRob3BzDQo+IGlzIHNldCwgaXQg
Y2xlYXJzIHJxX2F1dGhvcHMgaXRzZWxmLCBhbmQgcnFfYXV0aG9wcyBiZWluZyBzZXQgaXMgYQ0K
PiBndWFyYW50ZWUgdGhhdCAtPmFjY2VwdCgpIGFscmVhZHkgcmFuLg0KPiANCj4gSXQncyBoYXJk
ZXIgdG8ga25vdyBpZiB0aGlzIHNvbHZlcyB0aGUgcHJvYmxlbSwgYXMgSSBzZWUgYSBsb3Qgb2Yg
b3RoZXINCj4gbWVudGlvbnMgb2YgVEhJU19NT0RVTEUgaW4gc3ZjYXV0aF9nc3MuYy4NCg0KUGVy
aGFwcyBhIGRlZXBlciBhdWRpdCBpcyBuZWNlc3NhcnkuDQoNCkEgc21hbGwgY29kZSBjaGFuZ2Ug
dG8gaW5qZWN0IFNWQ19DTE9TRSByZXR1cm5zIGF0IHJhbmRvbSB3b3VsZCBlbmFibGUNCmEgbW9y
ZSBkeW5hbWljIGFuYWx5c2lzLg0KDQoNCj4gUG9zc2libHkgb3J0aG9nb25hbCB0byB0aGlzIHBy
b2JsZW0sIGJ1dDogc3ZjYXV0aF9nc3NfcmVsZWFzZQ0KPiB1bmNvbmRpdGlvbmFsbHkgZGVyZWZl
cmVuY2VzIHJxc3RwLT5ycV9hdXRoX2RhdGEuICBJc24ndCB0aGF0IGEgTlVMTA0KPiBkZXJlZmVy
ZW5jZSBpZiB0aGUga21hbGxvYyBhdCB0aGUgc3RhcnQgb2Ygc3ZjYXV0aF9nc3NfYWNjZXB0KCkg
ZmFpbHM/DQo+IA0KPiBGaW5hbGx5LCBzaG91bGQgd2UgY2FyZSBhYm91dCBtb2R1bGUgcmVmZXJl
bmNlIGxlYWtzPw0KDQpJIHdvdWxkIHByZWZlciB0aGF0IG1vZHVsZSByZWZlcmVuY2UgY291bnRp
bmcgd29yayBhcyBleHBlY3RlZC4gV2hlbiBpdA0KZG9lc24ndCB0aGF0IHRlbmRzIHRvIGxlYWQg
dG8gcGVvcGxlIChzYXksIG1lKSBodW50aW5nIGZvciBidWdzIHRoYXQNCm1pZ2h0IGFjdHVhbGx5
IGJlIHNlcmlvdXMuDQoNCg0KPiBEb2VzIGFueW9uZSByZWFsbHkgKm5lZWQqIHRvIHVubG9hZCBt
b2R1bGVzPw0KDQpBbnlvbmUgd2hvIHdhbnRzIHRvIHJlcGxhY2UgdGhlIG1vZHVsZSB3aXRoIGEg
bmV3ZXIgYnVpbGQgdGhhdCBmaXhlcyBhDQpidWcuIEl0IGF2b2lkcyBhIGZ1bGwgcmVib290LCBh
bmQgZm9yIHNvbWUgdGhhdCdzIGltcG9ydGFudC4NCg0KDQo+IEFuZCB3aWxsIGJhZCBzdHVmZiBo
YXBwZW4gd2hlbiB0aGUNCj4gY291bnQgb3ZlcmZsb3dzLCBvciBkb2VzIHRoZSBtb2R1bGUgY29k
ZSBmYWlsIHNhZmVseSBzb21laG93IGluIHRoZQ0KPiBvdmVyZmxvdyBjYXNlPyAgSSBrbm93LCBi
dWdzIGFyZSBidWdzLCBJIHNob3VsZCBjYXJlIGFib3V0IGZpeGluZyBhbGwgb2YNCj4gdGhlbSwg
c2hhbWUgb24gbWUuLi4uDQo+IA0KPiAtLWIuDQo+IA0KPj4gDQo+PiANCj4+PiBuZXQvc3VucnBj
L3N2Yy5jIHwgNiArKysrLS0NCj4+PiAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCAy
IGRlbGV0aW9ucygtKQ0KPj4+IA0KPj4+IGRpZmYgLS1naXQgYS9uZXQvc3VucnBjL3N2Yy5jIGIv
bmV0L3N1bnJwYy9zdmMuYw0KPj4+IGluZGV4IDYxZmI4YTE4NTUyYy4uZDc2ZGM5ZDk1ZDE2IDEw
MDY0NA0KPj4+IC0tLSBhL25ldC9zdW5ycGMvc3ZjLmMNCj4+PiArKysgYi9uZXQvc3VucnBjL3N2
Yy5jDQo+Pj4gQEAgLTE0MTMsNyArMTQxMyw3IEBAIHN2Y19wcm9jZXNzX2NvbW1vbihzdHJ1Y3Qg
c3ZjX3Jxc3QgKnJxc3RwLCBzdHJ1Y3Qga3ZlYyAqYXJndiwgc3RydWN0IGt2ZWMgKnJlc3YpDQo+
Pj4gDQo+Pj4gc2VuZGl0Og0KPj4+IAlpZiAoc3ZjX2F1dGhvcmlzZShycXN0cCkpDQo+Pj4gLQkJ
Z290byBjbG9zZTsNCj4+PiArCQlnb3RvIGNsb3NlX3hwcnQ7DQo+Pj4gCXJldHVybiAxOwkJLyog
Q2FsbGVyIGNhbiBub3cgc2VuZCBpdCAqLw0KPj4+IA0KPj4+IHJlbGVhc2VfZHJvcGl0Og0KPj4+
IEBAIC0xNDI1LDYgKzE0MjUsOCBAQCBzdmNfcHJvY2Vzc19jb21tb24oc3RydWN0IHN2Y19ycXN0
ICpycXN0cCwgc3RydWN0IGt2ZWMgKmFyZ3YsIHN0cnVjdCBrdmVjICpyZXN2KQ0KPj4+IAlyZXR1
cm4gMDsNCj4+PiANCj4+PiBjbG9zZToNCj4+PiArCXN2Y19hdXRob3Jpc2UocnFzdHApOw0KPj4+
ICtjbG9zZV94cHJ0Og0KPj4+IAlpZiAocnFzdHAtPnJxX3hwcnQgJiYgdGVzdF9iaXQoWFBUX1RF
TVAsICZycXN0cC0+cnFfeHBydC0+eHB0X2ZsYWdzKSkNCj4+PiAJCXN2Y19jbG9zZV94cHJ0KHJx
c3RwLT5ycV94cHJ0KTsNCj4+PiAJZHByaW50aygic3ZjOiBzdmNfcHJvY2VzcyBjbG9zZVxuIik7
DQo+Pj4gQEAgLTE0MzMsNyArMTQzNSw3IEBAIHN2Y19wcm9jZXNzX2NvbW1vbihzdHJ1Y3Qgc3Zj
X3Jxc3QgKnJxc3RwLCBzdHJ1Y3Qga3ZlYyAqYXJndiwgc3RydWN0IGt2ZWMgKnJlc3YpDQo+Pj4g
ZXJyX3Nob3J0X2xlbjoNCj4+PiAJc3ZjX3ByaW50ayhycXN0cCwgInNob3J0IGxlbiAlemQsIGRy
b3BwaW5nIHJlcXVlc3RcbiIsDQo+Pj4gCQkJYXJndi0+aW92X2xlbik7DQo+Pj4gLQlnb3RvIGNs
b3NlOw0KPj4+ICsJZ290byBjbG9zZV94cHJ0Ow0KPj4+IA0KPj4+IGVycl9iYWRfcnBjOg0KPj4+
IAlzZXJ2LT5zdl9zdGF0cy0+cnBjYmFkZm10Kys7DQo+Pj4gLS0gDQo+Pj4gMi4yNS4xDQo+Pj4g
DQo+Pj4gDQo+Pj4gLS0gDQo+Pj4gUHV6emxlIElUQyBEZXV0c2NobGFuZCBHbWJIDQo+Pj4gU2l0
eiBkZXIgR2VzZWxsc2NoYWZ0OiBFaXNlbmJhaG5zdHJhw59lIDEsIDcyMDcyIA0KPj4+IFTDvGJp
bmdlbg0KPj4+IA0KPj4+IEVpbmdldHJhZ2VuIGFtIEFtdHNnZXJpY2h0IFN0dXR0Z2FydCBIUkIg
NzY1ODAyDQo+Pj4gR2VzY2jDpGZ0c2bDvGhyZXI6IA0KPj4+IEx1a2FzIEthbGxpZXMsIERhbmll
bCBLb2JyYXMsIE1hcmsgUHLDtmhsDQo+Pj4gDQo+PiANCj4+IC0tDQo+PiBDaHVjayBMZXZlcg0K
DQotLQ0KQ2h1Y2sgTGV2ZXINCg0KDQoNCg==
