Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A77BC621C99
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Nov 2022 19:59:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbiKHS72 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 8 Nov 2022 13:59:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbiKHS71 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 8 Nov 2022 13:59:27 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2106.outbound.protection.outlook.com [40.107.94.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A12615E9C5
        for <linux-nfs@vger.kernel.org>; Tue,  8 Nov 2022 10:59:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j0vgV0jM8+DanOC7/WnYji2qlEm5leP/phwND3ADUFloA/A38y8MMdHTJKgkaWi2a1J1e5LQ8qS4zGOUWC+OGBAXSaNy/wxnsRJSaJFbMcU207IvlDlQ93lziWr5drC6Twdb87epZamzp7QUuk1xYjw4GMzAfCzr6TijLtS9iqmikOLhi9mc1cyTR/3B4Wvko6sOJ+iUFRbBb1uek/0CozOpRZ+A++xeIO+gPbDEuS5nhQcipA53NzY1veHYbrX1uBIqEkNCZpHBv6Wod1tbFUWUYsOQiBFVHDLFW/UCxqp3PjRRXtsziWrbM//47pro1EUAd1qq00/17w1Q8+A8bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rUXIsWHLR3j9dFcOtL08yPfTnAN0CjktMU2OM9wvfZE=;
 b=WY9ZCBwCbYOdD6CLIjl393ewDiSZaWHTky/ieo3rGnCzI7SlIVABYFMjjR7M2f+2ub/kVEOhQfQtrdZ3I/EZNxvAgEuihskLLYuPnDo6SODXtWrXDePfQgKc335r1VvlUdLzkoXUApP6Y336xVvKXrf1yEVkeHHfSVcBg5PTxTOVS5z1dC2RjsRgzRFXB0SeQA+EhiMhb5yGAF9C54yXhUomCaRZXpXcH2wEwY7VEx4PGqiAA+M5fwXC1MwSP/E/Yd3ygL7aP9nCfLqYMfP9F8kMwlynATRu3lOm1Z9vdQ7rtBUHTSS19DDAVa5L0egyIsQoN2kpEWK5vH2H/gJDzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rUXIsWHLR3j9dFcOtL08yPfTnAN0CjktMU2OM9wvfZE=;
 b=LZgRvRiPyQpwbt08zhd2H5OLkkQTgMVoC2ky8iYvHna8ib5sYpE61XX8Hya+5IzsQPTXAZ59/hAhG6ttB+GoHqBa6u+epNf7bwrGKMFjJ/okXNNsE7DcNwnSI1xJX2COHJXbDBrrRyrlLi95K+yqkYXv3KaufuYtmYXwOkqscQY=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by DM6PR13MB4115.namprd13.prod.outlook.com (2603:10b6:5:2a3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.27; Tue, 8 Nov
 2022 18:59:24 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::9927:a5a2:43a2:4801]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::9927:a5a2:43a2:4801%4]) with mapi id 15.20.5791.026; Tue, 8 Nov 2022
 18:59:24 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     Charles Edward Lever <chuck.lever@oracle.com>
CC:     Jeffrey Layton <jlayton@kernel.org>,
        "trondmy@kernel.org" <trondmy@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] lockd: set other missing fields when unlocking files
Thread-Topic: [PATCH] lockd: set other missing fields when unlocking files
Thread-Index: AQHY8hNCCVE1uG9XTE231alNVaBdka4zSOCAgAC6T4CAAAuKgA==
Date:   Tue, 8 Nov 2022 18:59:24 +0000
Message-ID: <07EF2FD9-C49E-4414-B05B-83CE9D3AD6C3@hammerspace.com>
References: <20221106190239.404803-1-trondmy@kernel.org>
 <2b5cffddf1d4d5791758e267b7184f0263519335.camel@kernel.org>
 <6D002058-C292-4F77-A1B7-C943B3A203C5@oracle.com>
In-Reply-To: <6D002058-C292-4F77-A1B7-C943B3A203C5@oracle.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.200.110.1.12)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|DM6PR13MB4115:EE_
x-ms-office365-filtering-correlation-id: 2a995e7c-da8b-45c8-b25d-08dac1bb5a59
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NXN1szAxXPuSfmRxkQZ8D8/+DWqdptBjKDqh8A1Pf8Pi8iXXl/bNDwID7RNMp3ShfYs7sZZastvEeSRhSzmSIZ5NPE3kIttIYPgxRy8mxqb5lm+xwnBNRDRr2Ffzi13rxshZS7iU0SfH949Dhi+/2qcppQsqnbP+Mnbg12pFne2nnZdeeB7vbtqpj3dssIwBQFzJHavc009Tx/zLmV7/Ng4SQA7pqDkw8tRXnpPGG+PN3mTuY4qsMRz/ZgQHpp7fZmJfueZ0i1CTnpEc0yxb7SubJd31pXhHangTDed8eKM9hvyiy9EUAbqJ/2HAtIUvzN7rgQ+6Q+KtupaeQZ6l3s7LF9v4SA/LB7divr4w8BtzJL/wWvb3dIFEW8y5Uf4IB7/dye+lMRzYXGyM2yW7G2zR6SBefMB1snf1flCoqo1/G6BTKQ9Dxa+wkXN5ItwiSJ8LsVuDhwVnv4bHpKiLJNXZIm+JqsqilWPsHRTotgE1fOZkAT365tmFlFumMdilbwSJcwHyLdkV9rdUIPnQiTXzYSJS4e1yQgSDfHxCE9du8NKo5QfrREqIKa0AZ+esF9f/fSMTuwpyDWK6HaPZhVBzP353ThmaotXMrxbJUaIzW1l0oLYhZ+WtH8vMA6DnfC74UTmLrx730Y9/UjWXQcX5vvKmeGqe0ici/F0RJoNJAS4yEXZT0u8fnCVS/6O8Qmv3spXWNEkqmfKCVuRQhZ/2cIJezQo1e4tOekadXyOpcLoS9GcOxegoWH803ajj4Z9p7WiHgqzvOOmYJjIJKKQ0vi9MlzeNFvTS4fs/9I0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(396003)(376002)(136003)(346002)(39830400003)(451199015)(71200400001)(316002)(66446008)(66556008)(66476007)(8676002)(66946007)(64756008)(86362001)(4326008)(6916009)(54906003)(41300700001)(5660300002)(8936002)(76116006)(33656002)(2616005)(186003)(6486002)(2906002)(478600001)(6506007)(122000001)(38070700005)(6512007)(26005)(53546011)(36756003)(38100700002)(83380400001)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZmtrdTh5TDRXZnYyYjE1cERpcENTWUsvckhTMXFiNC81VW92T1hjTHpUSzdS?=
 =?utf-8?B?RHFnYnBhb0g1SUZTNlE3WkF5ZExhbGRwL256YjU5V3hnVGRZV20xQlhXaHpY?=
 =?utf-8?B?QVI1SHZQWHR5NG5iUGZTdjlwZnpsaUZpSVE4T0ZISFd4eldtV2FZdzMrTEpE?=
 =?utf-8?B?dDRjNmFnaGdURTlyL1JlSGxmTit6NTZ0T1pmdk9NK1l2M082VXZqU3lNbGVw?=
 =?utf-8?B?MDhRU2NzbzZSN1dFcis0eDZZNXZsTkcyOERyajROV1JkRm1HZXlZSGkvbG85?=
 =?utf-8?B?cFFjWVoxKzNpMnY0bk94OUgxbSszNW1zWkM2QnNyLzB1S25IaXNYTG5wLzhS?=
 =?utf-8?B?a0VKSndaaEFHVmw3Ujc1ZXNHMTBwSGJSZ0RDVnNSSjNwT0VDR2RObzhiUEVi?=
 =?utf-8?B?aDBRdGxFSjlNSVUwcnVWQmNwb0kwQnRQd3VmMTRpQlJUckwrbEwxRm5BS0wy?=
 =?utf-8?B?K0xNYnR6RU83NzFyTU5RWDVrQkhuVmUwOWUwK29OMWRMNEIzd244RHNlZThX?=
 =?utf-8?B?YlpnVzZsRVhsZlcwdnhpYk1FYlJYVzVjMnJVcERVZG9ILzZaZkZzM1V5TE0r?=
 =?utf-8?B?U3NuU1YybmlDUG81eE9jV3VlWGZoSmlNS2YvUTg1b1pMY0J1ZFdwbmY0dnFk?=
 =?utf-8?B?bUNuN21veWpITkxDbm1zSVlCQk5HcnBQRDV6eE1PTldvTG1uOHgrMDFVb2I5?=
 =?utf-8?B?aWxGR2xJUUtHSTVQZEpzMlZBOThicHlZbklwZFpRMUxJS3VXdVRUK3U5UktQ?=
 =?utf-8?B?NEJReE5MNkRSd3BUZDN5TVRkU1FmWjRQdlVhMjRmMDRDb29JNE16RXplRGFh?=
 =?utf-8?B?bGpqbXlZZnBrVTlPRmpwOG5oTUhITExDd0JXcnB4WmlOYTNWY004eWw1aFNR?=
 =?utf-8?B?QnJBSGQxTXJURGlWWVo3TGVUdDZ2OWU0TDhSR2dCS29NbkF6QXdIUldWL0ZD?=
 =?utf-8?B?cnpIMUpjWXhKRzBpNjF4Z2M3dWV6cXp0T0ZPblNVREIwK2dCbi9iMzFkMDAx?=
 =?utf-8?B?U1FkY2cxNzRyT3F3NjFWU1RaTGdRZzFPMHhMOTRyeUxLbXNCL3hKVFR1eHZW?=
 =?utf-8?B?QlVCOTQwSktQdWdxUW9WVjJqaWY3WkJOZ1hOVTQ4M3BoUHFJME9GQktrRllR?=
 =?utf-8?B?S1hMelBSSllhWFNOS3lkbXpNTWFZME5odWkvRkgxaUNwTlF4azdwazMxaFdY?=
 =?utf-8?B?eDlUS0pYNS90eVM5UTBDdDVPYkhVUUx0UmZEdkVoWk0zM0V6TGVRMzdUVWl3?=
 =?utf-8?B?VEd6UytEc1g4K2wyK1ZuME8zcGlEYVJKQ1dBb05zNG9JLzBvYndEVFNMek1O?=
 =?utf-8?B?MGdUeC9RUmtRa01XS3JVTXUyMVBUWWErVS9jaHFCcytLUGtMd0NpcWYzQlFz?=
 =?utf-8?B?TTJ5RWdQczFMVjFrdDBwWHFqR0NvTXlaUUdBUkQvNVVtZHdwWlB4dUtpL3cy?=
 =?utf-8?B?c1p5ZDFVdExycFNHS1BjTjdnZDJacjNmSlhCQW8yTlBna09ZUVpqVzI3blZ0?=
 =?utf-8?B?cHJsSUN6dnN4clVRVFlOY1ZhNThyRUswZFhOVzVQdmRlbXVTSmtBOXk5S29H?=
 =?utf-8?B?Z3NBK2ZIQmZQOHpwdGs0RUcxbDcyNWJXMlRWb2F6WTlaYkdITzFjUGdFNm1L?=
 =?utf-8?B?dUdUZHBqNDBraVB1RVZUa3NQSk16bTVERmg0MGhpdXR6bGFLdnpzREd1RmJo?=
 =?utf-8?B?bXlGUXI5U3lDeW1BUDRnNUxlZkl3ejRnRlVTYTJEcmFlZ3pGZDFEbUN1TEZr?=
 =?utf-8?B?RC9iS1ZDN3llNmdDWXp3cUg3cHpJWFI0RFNOUXREV1JhTis3VDdYK29JRENL?=
 =?utf-8?B?dkZFNGl2WDRWNmRzZGgwdlp0YU96clp6VU1SUUE2d09lRzJHc1MzUzNISE9G?=
 =?utf-8?B?aGdmd09pTHVXTXB0S3k3L1JwNkYvVjZLTFcwL1V2bW5XRUxrUU40MExrcTBI?=
 =?utf-8?B?T2FFQlhiM1ZXYURaaGp0bCtwempKdXY1dFdqSXJ1MzlTTG5Ma3Y5dVZYUDNJ?=
 =?utf-8?B?bnF1VmhReVhNeGllcWN3Q3hraVBXVTZFV0REUnhPZU9tZXNGekRHbGE2cVBJ?=
 =?utf-8?B?UU56MkZseWFkYmpuMzFia0Nqd2xneGp3Nm9iaXA0UWx2cm5HVTAxT21FU1NE?=
 =?utf-8?B?QjExU3RkNkRBWlVrS1UrWjRtYkRpVkxxK3lNRGk5VGszajlieUJxUW5wMUMv?=
 =?utf-8?B?YlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7DBF57C9DC61B2459E6267C2D12F5AC1@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a995e7c-da8b-45c8-b25d-08dac1bb5a59
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2022 18:59:24.4282
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2OHpO/AfegD0k6LJ3FXz3ah+3O7MXBZVJHZeABRLcECacK4NiMlb8POwF96OmOSZ+lCoIBmyIFdLTSa4cNB8DQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR13MB4115
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

DQoNCj4gT24gTm92IDcsIDIwMjIsIGF0IDE2OjU1LCBDaHVjayBMZXZlciBJSUkgPGNodWNrLmxl
dmVyQG9yYWNsZS5jb20+IHdyb3RlOg0KPiANCj4gDQo+IA0KPj4gT24gTm92IDcsIDIwMjIsIGF0
IDU6NDggQU0sIEplZmYgTGF5dG9uIDxqbGF5dG9uQGtlcm5lbC5vcmc+IHdyb3RlOg0KPj4gDQo+
PiBPbiBTdW4sIDIwMjItMTEtMDYgYXQgMTQ6MDIgLTA1MDAsIHRyb25kbXlAa2VybmVsLm9yZyB3
cm90ZToNCj4+PiBGcm9tOiBUcm9uZCBNeWtsZWJ1c3QgPHRyb25kLm15a2xlYnVzdEBoYW1tZXJz
cGFjZS5jb20+DQo+Pj4gDQo+Pj4gdmZzX2xvY2tfZmlsZSgpIGV4cGVjdHMgdGhlIHN0cnVjdCBm
aWxlX2xvY2sgdG8gYmUgZnVsbHkgaW5pdGlhbGlzZWQgYnkNCj4+PiB0aGUgY2FsbGVyLg0KPiAN
Cj4gQXMgYSByZXZpZXdlciwgSSBkb24ndCBzZWUgYW55dGhpbmcgaW4gdGhlIHZmc19sb2NrX2Zp
bGUoKSBrZG9jDQo+IGNvbW1lbnQgdGhhdCBzdWdnZXN0cyB0aGlzLCBhbmQgdmZzX2xvY2tfZmls
ZSgpIGl0c2VsZiBpcyBqdXN0DQo+IGEgd3JhcHBlciBhcm91bmQgZWFjaCBmaWxlc3lzdGVtJ3Mg
Zl9vcHMtPmxvY2sgbWV0aG9kLiBUaGF0DQo+IGV4cGVjdGF0aW9uIGlzIGEgYml0IGRlZXBlciBp
bnRvIE5GUy1zcGVjaWZpYyBjb2RlLiBBIGZldyBtb3JlDQo+IG9ic2VydmF0aW9ucyBiZWxvdy4N
Cj4gDQo+IA0KPj4+IFJlLWV4cG9ydGVkIE5GU3YzIGhhcyBiZWVuIHNlZW4gdG8gT29wcyBpZiB0
aGUgZmxfZmlsZSBmaWVsZA0KPj4+IGlzIE5VTEwuDQo+IA0KPiBOZWVkcyBhIExpbms6IHRvIHRo
ZSBidWcgcmVwb3J0LiBXaGljaCBJIGNhbiBhZGQuDQo+IA0KPiBUaGlzIHdpbGwgYWxzbyBnaXZl
IHVzIGEgY2FsbCB0cmFjZSB3ZSBjYW4gcmVmZXJlbmNlLCBzbyBJIHdvbid0DQo+IGFkZCB0aGF0
IGhlcmUuDQo+IA0KPiANCj4+PiBGaXhlczogYWVjMTU4MjQyYjg3ICgibG9ja2Q6IHNldCBmbF9v
d25lciB3aGVuIHVubG9ja2luZyBmaWxlcyIpDQo+Pj4gU2lnbmVkLW9mZi1ieTogVHJvbmQgTXlr
bGVidXN0IDx0cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29tPg0KPj4+IC0tLQ0KPj4+IGZz
L2xvY2tkL3N2Y3N1YnMuYyB8IDE3ICsrKysrKysrKystLS0tLS0tDQo+Pj4gMSBmaWxlIGNoYW5n
ZWQsIDEwIGluc2VydGlvbnMoKyksIDcgZGVsZXRpb25zKC0pDQo+Pj4gDQo+Pj4gZGlmZiAtLWdp
dCBhL2ZzL2xvY2tkL3N2Y3N1YnMuYyBiL2ZzL2xvY2tkL3N2Y3N1YnMuYw0KPj4+IGluZGV4IGUx
YzQ2MTdkZTc3MS4uMzUxNWYxN2VhZjNmIDEwMDY0NA0KPj4+IC0tLSBhL2ZzL2xvY2tkL3N2Y3N1
YnMuYw0KPj4+ICsrKyBiL2ZzL2xvY2tkL3N2Y3N1YnMuYw0KPj4+IEBAIC0xNzYsNyArMTc2LDcg
QEAgbmxtX2RlbGV0ZV9maWxlKHN0cnVjdCBubG1fZmlsZSAqZmlsZSkNCj4+PiB9DQo+Pj4gfQ0K
Pj4+IA0KPj4+IC1zdGF0aWMgaW50IG5sbV91bmxvY2tfZmlsZXMoc3RydWN0IG5sbV9maWxlICpm
aWxlLCBmbF9vd25lcl90IG93bmVyKQ0KPj4+ICtzdGF0aWMgaW50IG5sbV91bmxvY2tfZmlsZXMo
c3RydWN0IG5sbV9maWxlICpmaWxlLCBjb25zdCBzdHJ1Y3QgZmlsZV9sb2NrICpmbCkNCj4+PiB7
DQo+Pj4gc3RydWN0IGZpbGVfbG9jayBsb2NrOw0KPj4+IA0KPj4+IEBAIC0xODQsMTIgKzE4NCwx
NSBAQCBzdGF0aWMgaW50IG5sbV91bmxvY2tfZmlsZXMoc3RydWN0IG5sbV9maWxlICpmaWxlLCBm
bF9vd25lcl90IG93bmVyKQ0KPj4+IGxvY2suZmxfdHlwZSAgPSBGX1VOTENLOw0KPj4+IGxvY2su
Zmxfc3RhcnQgPSAwOw0KPj4+IGxvY2suZmxfZW5kICAgPSBPRkZTRVRfTUFYOw0KPj4+IC0gbG9j
ay5mbF9vd25lciA9IG93bmVyOw0KPj4+IC0gaWYgKGZpbGUtPmZfZmlsZVtPX1JET05MWV0gJiYN
Cj4+PiAtICAgICB2ZnNfbG9ja19maWxlKGZpbGUtPmZfZmlsZVtPX1JET05MWV0sIEZfU0VUTEss
ICZsb2NrLCBOVUxMKSkNCj4+PiArIGxvY2suZmxfb3duZXIgPSBmbC0+Zmxfb3duZXI7DQo+Pj4g
KyBsb2NrLmZsX3BpZCAgID0gZmwtPmZsX3BpZDsNCj4+PiArIGxvY2suZmxfZmxhZ3MgPSBGTF9Q
T1NJWDsNCj4+PiArDQo+Pj4gKyBsb2NrLmZsX2ZpbGUgPSBmaWxlLT5mX2ZpbGVbT19SRE9OTFld
Ow0KPj4+ICsgaWYgKGxvY2suZmxfZmlsZSAmJiB2ZnNfbG9ja19maWxlKGxvY2suZmxfZmlsZSwg
Rl9TRVRMSywgJmxvY2ssIE5VTEwpKQ0KPj4+IGdvdG8gb3V0X2VycjsNCj4+PiAtIGlmIChmaWxl
LT5mX2ZpbGVbT19XUk9OTFldICYmDQo+Pj4gLSAgICAgdmZzX2xvY2tfZmlsZShmaWxlLT5mX2Zp
bGVbT19XUk9OTFldLCBGX1NFVExLLCAmbG9jaywgTlVMTCkpDQo+Pj4gKyBsb2NrLmZsX2ZpbGUg
PSBmaWxlLT5mX2ZpbGVbT19XUk9OTFldOw0KPj4+ICsgaWYgKGxvY2suZmxfZmlsZSAmJiB2ZnNf
bG9ja19maWxlKGxvY2suZmxfZmlsZSwgRl9TRVRMSywgJmxvY2ssIE5VTEwpKQ0KPj4+IGdvdG8g
b3V0X2VycjsNCj4+PiByZXR1cm4gMDsNCj4+PiBvdXRfZXJyOg0KPj4+IEBAIC0yMjYsNyArMjI5
LDcgQEAgbmxtX3RyYXZlcnNlX2xvY2tzKHN0cnVjdCBubG1faG9zdCAqaG9zdCwgc3RydWN0IG5s
bV9maWxlICpmaWxlLA0KPj4+IGlmIChtYXRjaChsb2NraG9zdCwgaG9zdCkpIHsNCj4+PiANCj4+
PiBzcGluX3VubG9jaygmZmxjdHgtPmZsY19sb2NrKTsNCj4+PiAtIGlmIChubG1fdW5sb2NrX2Zp
bGVzKGZpbGUsIGZsLT5mbF9vd25lcikpDQo+Pj4gKyBpZiAobmxtX3VubG9ja19maWxlcyhmaWxl
LCBmbCkpDQo+Pj4gcmV0dXJuIDE7DQo+Pj4gZ290byBhZ2FpbjsNCj4+PiB9DQo+PiANCj4+IEdv
b2QgY2F0Y2guDQo+PiANCj4+IEkgd29uZGVyIGlmIHdlIG91Z2h0IHRvIHJvbGwgYW4gaW5pdGlh
bGl6ZXIgZnVuY3Rpb24gZm9yIGZpbGVfbG9ja3MgdG8NCj4+IG1ha2UgaXQgaGFyZGVyIGZvciBj
YWxsZXJzIHRvIG1pc3Mgc2V0dGluZyBzb21lIGZpZWxkcyBsaWtlIHRoaXM/IE9uZQ0KPj4gaWRl
YTogd2UgY291bGQgY2hhbmdlIHZmc19sb2NrX2ZpbGUgdG8gKm5vdCogdGFrZSBhIGZpbGUgYXJn
dW1lbnQsIGFuZA0KPj4gaW5zaXN0IHRoYXQgdGhlIGNhbGxlciBmaWxsIG91dCBmbF9maWxlIHdo
ZW4gY2FsbGluZyBpdD8gVGhhdCB3b3VsZCBtYWtlDQo+PiBpdCBoYXJkZXIgdG8gc2NyZXcgdGhp
cyB1cC4NCj4gDQo+IENvbW1pdCBoaXN0b3J5IHNob3dzIHRoYXQsIGF0IGxlYXN0IGFzIGZhciBi
YWNrIGFzIHRoZSBiZWdpbm5pbmcgb2YNCj4gdGhlIGdpdCBlcmEsIHRoZSB2ZnNfbG9ja19maWxl
KCkgY2FsbCBzaXRlIGhlcmUgZGlkIG5vdCBpbml0aWFsaXplDQo+IHRoZSBmbF9maWxlIGZpZWxk
LiBTbywgdGhpcyBjb2RlIGhhcyBiZWVuIHdvcmtpbmcgd2l0aG91dCBmdWxseQ0KPiBpbml0aWFs
aXppbmcgQGZsIGZvciwgbGlrZSwgZm9yZXZlci4NCj4gDQo+IA0KPiBUcm9uZCBsYXRlciBzYXlz
Og0KPj4gVGhlIHJlZ3Jlc3Npb24gb2NjdXJzIGluIDUuMTYsIGJlY2F1c2UgdGhhdCB3YXMgd2hl
biBCcnVjZSBtZXJnZWQgaGlzDQo+PiBwYXRjaGVzIHRvIGVuYWJsZSBsb2NraW5nIHdoZW4gZG9p
bmcgTkZTIHJlLWV4cG9ydGluZy4NCj4gDQo+IFRoYXQgbWVhbnMgdGhlIEZpeGVzOiB0YWcgYWJv
dmUgaXMgbWlzbGVhZGluZy4gVGhlIHByb3Bvc2VkIHBhdGNoDQo+IGRvZXNuJ3QgYWN0dWFsbHkg
Zml4IHRoYXQgY29tbWl0ICh3aGljaCB3ZW50IGludG8gdjUuMTkpLCBpdCBzaW1wbHkNCj4gYXBw
bGllcyBvbiB0aGF0IGNvbW1pdC4NCj4gDQo+IEkgaGF2ZW4ndCBiZWVuIGFibGUgdG8gZmluZCB0
aGUgbG9ja2luZyBwYXRjaGVzIG1lbnRpb25lZCBoZXJlLiBJIHRoaW5rDQo+IHRob3NlIGJlYXIg
bWVudGlvbmluZyAoYnkgY29tbWl0IElEKSBpbiB0aGUgcGF0Y2ggZGVzY3JpcHRpb24sIGF0IGxl
YXN0Lg0KPiBJZiB5b3Uga25vdyB0aGUgY29tbWl0IElELCBUcm9uZCwgY2FuIHlvdSBwYXNzIGl0
IGFsb25nPw0KPiANCj4gVGhvdWdoIEkgd291bGQgc2F5IHRoYXQsIGluIGFncmVlbWVudCB3aXRo
IEplZmYsIHRoZSB0cnVlIGNhdXNlIG9mIHRoaXMNCj4gaXNzdWUgaXMgdGhlIGF3a3dhcmQgc3lu
b3BzaXMgZm9yIHZmc19sb2NrX2ZpbGUoKS4NCj4gDQoNClRoZSBGaXhlczogdGFnIGlzIGNvcnJl
Y3QuIFRoaXMgYXBwbGllcyBvbiB0b3Agb2YgSmVmZuKAmXMgcGF0Y2gsIHdoaWNoIHdhcyB0aGUg
b3JpZ2luYWwgZml4IGZvciBCcnVjZeKAmXMgY29kZSAoYW5kIGhhcyBhIEZpeGVzIGxhYmVsIHRo
YXQgcG9pbnRzIHRvIEJydWNl4oCZcyBwYXRjaCkuDQoNCg0KX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fDQpUcm9uZCBNeWtsZWJ1c3QNCkxpbnV4IE5GUyBjbGllbnQgbWFpbnRhaW5l
ciwgSGFtbWVyc3BhY2UNCnRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20NCg0K
