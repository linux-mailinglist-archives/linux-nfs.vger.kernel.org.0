Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF2DB735E60
	for <lists+linux-nfs@lfdr.de>; Mon, 19 Jun 2023 22:19:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbjFSUTg (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 19 Jun 2023 16:19:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjFSUTf (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 19 Jun 2023 16:19:35 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2097.outbound.protection.outlook.com [40.107.93.97])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9855DD3
        for <linux-nfs@vger.kernel.org>; Mon, 19 Jun 2023 13:19:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KXsMVUbkXbfjVcFz2VlQMb9OPMQmTiWd3ouLGplVdSMDcpyq48IuFQSzY/xM8IrgkBQTJSkDzMANkjuXUPlKyiT2Ifl2L4BO3E/AVcOwaDKuK1p4ynYF/i3uA/tTdLRugngHNOQvG3GJ236Rm2thSIQE3bOkWLriqD+zwx9rB3Cmm1UTI7E+fPGH/SmJiU+ZDPUcWFxUVIlCcSckzxkvGuvBmDElyBTbsFsNopseszy7ca/6CuuDuSvilRY+6X23N/Pyf7uV+Nj2gv60OshOAPvp6h1+DJyOkV2ge1MJWgMQM8xZpkC/lyWukdK8nXqvjXRNEJpaBLzehP3kjHeQBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZZkXlrWWryJfoIkAMG5NmvXdLZaV9GQbBozR8b3fOtk=;
 b=ebdVu020ryYpvXeX1VbD/oNfLnwo37MmRUZPVgD/4uaSqEHKu2GbscjvlGWxQ0SPbim3VWMt2qf70BUGL+YRqCuLBuD1hZd24g/CN0sh/9JLAgaC3pKHv5uiYnsf8tIgaanE/kG4sREWb42lBag9mpwjM6uAN6lmUUWY+zOHz+xjPlWPe0e14L+0edPsSOVEGKLm1Fw/0VXh6wIn92ZfL6ObfAoVFbAHpFbYGrPrNe0tI+6RrWdot7j9MmuyJyWAVVoByiTV2bUgoX7g4C071BZ0c45acfVkZgmbeIjOYXv+yNvfyp5AlA8AJIukreOCbm6ldXpjyc/b4BQtPNmSQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZZkXlrWWryJfoIkAMG5NmvXdLZaV9GQbBozR8b3fOtk=;
 b=QXyxq2yr5PIw9IIoi1RBBcK9lUgB0iXb3DNmsEnqX+N3Hfhg09ysAvu5Q0lMwcksjaW7RoO30vrXDsuj1TgIxnx0OXKpWp5gdWBvhG5iw8deLmxcb5DUfiMHov1saFWbMxMEd7LV3so0hIlDZxmTC1LNkScOnDRrZNXw69zHVBg=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by MN2PR13MB4054.namprd13.prod.outlook.com (2603:10b6:208:265::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37; Mon, 19 Jun
 2023 20:19:28 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::6a2f:f437:6816:78f8]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::6a2f:f437:6816:78f8%7]) with mapi id 15.20.6500.036; Mon, 19 Jun 2023
 20:19:28 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "chuck.lever@oracle.com" <chuck.lever@oracle.com>
CC:     "dai.ngo@oracle.com" <dai.ngo@oracle.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: NFSv4.0 Linux client fails to return delegation
Thread-Topic: NFSv4.0 Linux client fails to return delegation
Thread-Index: AQHZos/Q4xRI4OBFakm+oIbfuQpI0q+SgG4AgAAJjgCAAAcVgA==
Date:   Mon, 19 Jun 2023 20:19:28 +0000
Message-ID: <8d6521a18dd88d6fcf5e7cc05d9a5936ff56db94.camel@hammerspace.com>
References: <f9651599-846e-3331-9353-8a8264de1a27@oracle.com>
         <d5efe21b5f6a4bc7edd0f8ed441f63aa76b7e41a.camel@hammerspace.com>
         <D1821C7B-7A7E-4B99-BAB2-89AF03223605@oracle.com>
In-Reply-To: <D1821C7B-7A7E-4B99-BAB2-89AF03223605@oracle.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|MN2PR13MB4054:EE_
x-ms-office365-filtering-correlation-id: ba29aaa5-a810-4690-f0e7-08db71027bce
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IH1TnZSUM2Wran/N58pI+6QYvKxR94mOKQT9UZFY8+XCaXTES4PMXevyik27oGRzvsPlnquLGc8bZJZp5P8SbDugXulWcLRxh/S0APTnMqXC2smAxmCo1jaqzGiZRI2N0mjiKpEeyXY2ryB41mw5mO6IEoBU7BZThCNwibOy7N+xQ/433B8pOAeX8Wo00kt00UCu5FjprLjDIBEEL8h2vbCcAQ+DKuWM0jLTKU7xuRkPwCLayRUY2Hkdg8iqjhCp6v047cUHwCREVw0P25lJtptcuhH1GlHcgV/hVp1WNXMxzpU4iBYSlfjcUiFWCrZ6qDZJg4W2JaDhEaDcNy/IGc+bl47dx0WyYgWUkt5xMWnC+EmlTYKJgKvTtlC44+UFytLzhmCdyoGXfF2T+6HcJiza1ng6nSISEfUaXI9LvYxhOyxp2ulVxz6vpqw8mK1cJwPGylRMCy44FHhaC/fBmynfncWqFF/wrHc3RT4Gfn5nh8VFyTvuGcyodoCF0JL8WzU2viTJQDJiRxQUUznmCVmMAAsC4Y6vu83VmlSpGei4jVn5tnxPBS+CqVAJEdL7Ne21aoh0YUocLHTL11bHHxHMmdqoMQWUP3gBrTM75wJ5VzEq1koe4EVKyBwa6qWzfJd803XqDfssnzgYsvQx8LKAFWAOND2nQC+phibOXDg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39840400004)(376002)(136003)(366004)(346002)(396003)(451199021)(478600001)(2906002)(66899021)(54906003)(6486002)(2616005)(86362001)(71200400001)(122000001)(38070700005)(36756003)(186003)(6506007)(6512007)(8936002)(8676002)(76116006)(66446008)(66476007)(66556008)(64756008)(66946007)(53546011)(5660300002)(38100700002)(316002)(6916009)(4326008)(83380400001)(41300700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MTNrZlRud3VGMDdKc3ozSkVqenZxNFJqa0xsMmQxYVhvb2JnNkRmc0VJUzdB?=
 =?utf-8?B?aTBIZERyVWZOOVNqQTVyRjk1NnJyd0JyR0ZnUkx4bzBqYUxzUTUvNS9CWnJj?=
 =?utf-8?B?K0FqRGE3L1F5TFY4aTBQMG9LUDNaSnRMN1B0NkJFNHExNVA4OFhNVWYwNnUv?=
 =?utf-8?B?eHBva3kyNG11VVVyb2hqU2NKeXVqSlZZVjAxVGtQUVdobFBacGJuOFRISlNN?=
 =?utf-8?B?ajlBOEtod2NzY1dObncxVFNUUnlBS00wTmtoT3NlZHpLREExTlpPRXNxekIx?=
 =?utf-8?B?UktJcEdzWDNQQXJLWkxxamYrVzhlN3FLd3ZZdXd2ajRGQmN6cVBDMFdrZ2tW?=
 =?utf-8?B?bGliamRxaUV6Qm56NzNXS0lQSjFwM1V5VW5WM2N4ajg0MHp3em1NZ1JxQ2JU?=
 =?utf-8?B?REpBaHd1bTgxUDFpOWwyVGg4cFMrRUNuQ0RGRHIzSE81RWNoOWEvamVFM250?=
 =?utf-8?B?RHNwSlJxOUZOUUcreHlvVnk3V1hiYUFzT3NnTml1b2xZdmthLzJGd1lHTmpG?=
 =?utf-8?B?bWZYV21haEE5MFo4ZjRwSDVLdjB3a0I1Mi8wV1pQcE8vZDFHeUlhZ25SZG1M?=
 =?utf-8?B?cEltdy9VdzBvV041YUlQYWJQMVVYOVZGVlpsS0FTcjVGYldGU2dMSFl3aGp6?=
 =?utf-8?B?cFN1WjRxa3ZnRzVJeWs3QWQ0U1VMbzlDTXZQOG9zUUJmcjBHeHdCSW9FdUtF?=
 =?utf-8?B?Vys0WGxsOWR1bE83L3R3czdNS3o0aVBLK2hiR0RxYjV6dnhmRlNYL3FYM3pa?=
 =?utf-8?B?L0dUeDRjNFBEK3VSa3dsM3N6bGxvVHVZa0R0UUhUT2hHVnVYaThtaWNCRlJL?=
 =?utf-8?B?TGVkcFMwNHhYVWNoclQvT3pFWjVZVFBOTmYyWWZyNVR3dXpBak1zell4K0xu?=
 =?utf-8?B?aUM0UmZEK3htZThaQVc0bk5NYUJ0NlFwcjZOUVJheTdIdGpaRjFTNEZpdjBE?=
 =?utf-8?B?QmVPNTlWdzlTc2VPSXBSK0dZZFllbGFmMmEwMnFpSGQ0Y2VZVFJhMUMzMnQ2?=
 =?utf-8?B?cTZKb1lsUU1CdDJFZFF3U09abFVBOXpra1RqejBZWnZUVmRjbkNRbUN2RnFp?=
 =?utf-8?B?WEx1MU8rZ2V0Tk5kWlF5OUYrWTNLREhBOUVpMXBzQ1E1RVFiNGFCRVRLbHdO?=
 =?utf-8?B?ZE56ZEpwMEcxcm1rbC9tMFVxbVk4K3NZb0sxd0lXY2RGcjhoaXRUSDJrZlR2?=
 =?utf-8?B?TWM4RFVPdG5lNGhTVlBuQ0tPYUlaeFVNMW05d3pISTlZaTlhMXVSK1hQdWg5?=
 =?utf-8?B?YlJycTYzajlRaldCRTFXcGl5cFh3NW0zalQrTTU2LzVpd05MeGVEZW5QL3Jv?=
 =?utf-8?B?TlZOd2pubGVacm15Wkt5NDBUYVBBTlV0ZTRxMUtHMXRRVnVPQTl2dUdMMHU1?=
 =?utf-8?B?WU10ejlnZnVYcythelBLYUZXNy9hZDVwUTNMVHR6TDhreVVGR3NqcW5qUnh2?=
 =?utf-8?B?elp5VmJMOENib1VXeDduZkZERW91cVJFay9pOCtSNVRMaDFBdllZZmVXY0F6?=
 =?utf-8?B?U2tpQmUzUjRWYmM3dnR4bVdDMko2QXZZMXhpeUJBMlJGdDJNVnd5WEVRaXEy?=
 =?utf-8?B?L21GMUJiK0tQblFkY1RkcFJxd2RXcnRMRThzeE9GbzI4TnF1Ukd2Yzd6dXo5?=
 =?utf-8?B?aUdOSk90dWhHa1I0UVlzeHVtR1phMkR6S1hzZE9Jb2RmTGVRS1lvZENvWVAz?=
 =?utf-8?B?aDJVY2RzRFROTW9VaFFyUWZ4Mk9rSTV2aFBUTFpFRWljdytPRkdOSHNzeHNv?=
 =?utf-8?B?S2FQdmZUYVhTZStpMDh4ZE5OZUZPR1dmdktXcFdQRjN6MXpETDF4dGhBNk1q?=
 =?utf-8?B?TnYxQmJjWENDWnVZZ2Z3S0lsWjRUa1o1empNN0VIV2VqZm1vcDN1ZG11czQz?=
 =?utf-8?B?OG12aUtseWVXS0cwTTgvOXBXam1RTnNNUmdHRmIvS2VtWEFmc1pXeU5ReGI4?=
 =?utf-8?B?TTcrU3g1dGFyZ3ZORVk4SWFsNEFtZG53UXVHV0xnVG5OeE8vMzY0TVVRa0Zi?=
 =?utf-8?B?OUswU0k3b3VQTXJoNHlhMXdqT0ZYQnF2U0FhRHM1WUl6ZlltUmM4RnF4RVVY?=
 =?utf-8?B?aWZaUm5Qa01EanZmOUMzN3NsVVJVL2xJVExiVDFuMXlNcXZmclJMcUVnbjlH?=
 =?utf-8?B?S2VTNnNnYXdjZnhvZDAxU3N3S2NkSzFhVEREN2RTV01qbjBTRE5nOVU5Wlpq?=
 =?utf-8?B?cTI0OFF4eGpxTEV3czRIa1gyTmIxQVUvZ3VneWNjY2FJZGM3NVFYa1h3Q2Zw?=
 =?utf-8?B?NUpVMzVSWThSUzl0MlNkN0JxcDZ3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <ED0F1551C24F0045A7FD3973DEB77A40@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba29aaa5-a810-4690-f0e7-08db71027bce
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jun 2023 20:19:28.3576
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Dgydwm61HqXjBudLNLU+OOwMoEcT0F/b2/nYQ+oiwUVBzvOtZW4aOuSPALQfXYpOcMOEj9qtaV54nnL19F2pOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR13MB4054
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gTW9uLCAyMDIzLTA2LTE5IGF0IDE5OjU0ICswMDAwLCBDaHVjayBMZXZlciBJSUkgd3JvdGU6
DQo+IA0KPiANCj4gPiBPbiBKdW4gMTksIDIwMjMsIGF0IDM6MTkgUE0sIFRyb25kIE15a2xlYnVz
dA0KPiA+IDx0cm9uZG15QGhhbW1lcnNwYWNlLmNvbT4gd3JvdGU6DQo+ID4gDQo+ID4gSGkgRGFp
LA0KPiA+IA0KPiA+IE9uIE1vbiwgMjAyMy0wNi0xOSBhdCAxMDowMiAtMDcwMCwgZGFpLm5nb0Bv
cmFjbGUuY29twqB3cm90ZToNCj4gPiA+IEhpIFRyb25kLA0KPiA+ID4gDQo+ID4gPiBJJ20gdGVz
dGluZyB0aGUgTkZTIHNlcnZlciB3aXRoIHdyaXRlIGRlbGVnYXRpb24gc3VwcG9ydCBhbmQgdGhl
DQo+ID4gPiBMaW51eCBjbGllbnQNCj4gPiA+IHVzaW5nIE5GU3Y0LjAgYW5kIHJ1biBpbnRvIGEg
c2l0dWF0aW9uIHRoYXQgbmVlZHMgeW91ciBhZHZpc2UuDQo+ID4gPiANCj4gPiA+IEluIHRoaXMg
c2NlbmFyaW8sIHRoZSBORlMgc2VydmVyIGdyYW50cyB0aGUgd3JpdGUgZGVsZWdhdGlvbiB0bw0K
PiA+ID4gdGhlDQo+ID4gPiBjbGllbnQuDQo+ID4gPiBMYXRlciB3aGVuIHRoZSBjbGllbnQgcmV0
dXJucyBkZWxlZ2F0aW9uIGl0IHNlbmRzIHRoZSBjb21wb3VuZA0KPiA+ID4gUFVURkgsDQo+ID4g
PiBHRVRBVFRSDQo+ID4gPiBhbmQgREVMRVJFVFVSTi4NCj4gPiA+IA0KPiA+ID4gV2hlbiB0aGUg
TkZTIHNlcnZlciBzZXJ2aWNlcyB0aGUgR0VUQVRUUiwgaXQgZGV0ZWN0cyB0aGF0IHRoZXJlDQo+
ID4gPiBpcyBhDQo+ID4gPiB3cml0ZQ0KPiA+ID4gZGVsZWdhdGlvbiBvbiB0aGlzIGZpbGUgYnV0
IGl0IGNhbiBub3QgZGV0ZWN0IHRoYXQgdGhpcyBHRVRBVFRSDQo+ID4gPiByZXF1ZXN0IHdhcw0K
PiA+ID4gc2VudCBmcm9tIHRoZSBzYW1lIGNsaWVudCB0aGF0IG93bnMgdGhlIHdyaXRlIGRlbGVn
YXRpb24gKGR1ZSB0bw0KPiA+ID4gdGhlDQo+ID4gPiBuYXR1cmUNCj4gPiA+IG9mIE5GU3Y0LjAg
Y29tcG91bmQpLiBBcyB0aGUgcmVzdWx0LCB0aGUgc2VydmVyIHNlbmRzIENCX1JFQ0FMTA0KPiA+
ID4gdG8NCj4gPiA+IHJlY2FsbA0KPiA+ID4gdGhlIGRlbGVnYXRpb24gYW5kIHJlcGxpZXMgTkZT
NEVSUl9ERUxBWSB0byB0aGUgR0VUQVRUUiByZXF1ZXN0Lg0KPiA+ID4gDQo+ID4gPiBXaGVuIHRo
ZSBjbGllbnQgcmVjZWl2ZXMgdGhlIE5GUzRFUlJfREVMQVkgaXQgcmV0cmllcyB3aXRoIHRoZQ0K
PiA+ID4gc2FtZQ0KPiA+ID4gY29tcG91bmQNCj4gPiA+IFBVVEZILCBHRVRBVFRSLCBERUxFUkVU
VVJOIGFuZCBzZXJ2ZXIgYWdhaW4gcmVwbGllcyB0aGUNCj4gPiA+IE5GUzRFUlJfREVMQVkuIFRo
aXMNCj4gPiA+IHByb2Nlc3MgcmVwZWF0cyB1bnRpbCB0aGUgcmVjYWxsIHRpbWVzIG91dCBhbmQg
dGhlIGRlbGVnYXRpb24gaXMNCj4gPiA+IHJldm9rZWQgYnkNCj4gPiA+IHRoZSBzZXJ2ZXIuDQo+
ID4gPiANCj4gPiA+IEkgbm90aWNlZCB0aGF0IHRoZSBjdXJyZW50IG9yZGVyIG9mIEdFVEFUVFIg
YW5kIERFTEVHUkVUVVJOIHdhcw0KPiA+ID4gZG9uZQ0KPiA+ID4gYnkNCj4gPiA+IGNvbW1pdCBl
MTQ0Y2JjYzI1MWYuIFRoZW4gbGF0ZXIgb24sIGNvbW1pdCA4YWMyYjQyMjM4ZjUgd2FzIGFkZGVk
DQo+ID4gPiB0bw0KPiA+ID4gZHJvcA0KPiA+ID4gdGhlIEdFVEFUVFIgaWYgdGhlIHJlcXVlc3Qg
d2FzIHJlamVjdGVkIHdpdGggRUFDQ0VTLg0KPiA+ID4gDQo+ID4gPiBEbyB5b3UgaGF2ZSBhbnkg
YWR2aXNlIG9uIHdoZXJlLCBvbiBzZXJ2ZXIgb3IgY2xpZW50LCB0aGlzIGlzc3VlDQo+ID4gPiBz
aG91bGQNCj4gPiA+IGJlIGFkZHJlc3NlZD8NCj4gPiANCj4gPiBUaGlzIHdhbnRzIHRvIGJlIGFk
ZHJlc3NlZCBpbiB0aGUgc2VydmVyLiBUaGUgY2xpZW50IGhhcyBhIHZlcnkNCj4gPiBnb29kDQo+
ID4gcmVhc29uIGZvciB3YW50aW5nIHRvIHJldHJpZXZlIHRoZSBhdHRyaWJ1dGVzIGJlZm9yZSBy
ZXR1cm5pbmcgdGhlDQo+ID4gZGVsZWdhdGlvbiBoZXJlOiBpdCBuZWVkcyB0byB1cGRhdGUgdGhl
IGNoYW5nZSBhdHRyaWJ1dGUgd2hpbGUgaXQNCj4gPiBpcw0KPiA+IHN0aWxsIGhvbGRpbmcgdGhl
IGRlbGVnYXRpb24gaW4gb3JkZXIgdG8gZW5zdXJlIGNsb3NlLXRvLW9wZW4gY2FjaGUNCj4gPiBj
b25zaXN0ZW5jeS4NCj4gPiANCj4gPiBTaW5jZSB5b3UgZG8gaGF2ZSBhIHN0YXRlaWQgaW4gdGhl
IERFTEVHUkVUVVJOLCBpdCBzaG91bGQgYmUNCj4gPiBwb3NzaWJsZQ0KPiA+IHRvIGRldGVybWlu
ZSB0aGF0IHRoaXMgaXMgaW5kZWVkIHRoZSBjbGllbnQgdGhhdCBob2xkcyB0aGUNCj4gPiBkZWxl
Z2F0aW9uLg0KPiANCj4gSSB0aGluayBpdCBuZWVkcyB0byBiZSBtYWRlIGNsZWFyIGluIGEgc3Bl
Y2lmaWNhdGlvbiB0aGF0IHRoaXMgaXMNCj4gdGhlIGludGVuZGVkIGFuZCBjb252ZW50aW9uYWwg
c2VydmVyIGltcGxlbWVudGF0aW9uIG5lZWRlZCBmb3Igc3VjaA0KPiBhIENPTVBPVU5ELg0KPiAN
Cj4gUkZDIDc1MzAgU2VjdGlvbiAxNC4yIHNheXM6DQo+IA0KPiA+IFRoZSBzZXJ2ZXIgd2lsbCBw
cm9jZXNzIHRoZSBDT01QT1VORCBwcm9jZWR1cmUgYnkgZXZhbHVhdGluZyBlYWNoDQo+ID4gb2YN
Cj4gPiB0aGUgb3BlcmF0aW9ucyB3aXRoaW4gdGhlIENPTVBPVU5EIHByb2NlZHVyZSBpbiBvcmRl
ci4NCj4gDQo+IDJuZCBwYXJhZ3JhcGggb2YgUkZDIDc1MzAgU2VjdGlvbiAxNS4yLjQgc2F5czoN
Cj4gDQo+ID4gwqDCoCBUaGUgQ09NUE9VTkQgcHJvY2VkdXJlIGlzIHVzZWQgdG8gY29tYmluZSBp
bmRpdmlkdWFsIG9wZXJhdGlvbnMNCj4gPiBpbnRvDQo+ID4gYSBzaW5nbGUgUlBDIHJlcXVlc3Qu
IFRoZSBzZXJ2ZXIgaW50ZXJwcmV0cyBlYWNoIG9mIHRoZSBvcGVyYXRpb25zDQo+ID4gaW4gdHVy
bi4gSWYgYW4gb3BlcmF0aW9uIGlzIGV4ZWN1dGVkIGJ5IHRoZSBzZXJ2ZXIgYW5kIHRoZSBzdGF0
dXMNCj4gPiBvZg0KPiA+IHRoYXQgb3BlcmF0aW9uIGlzIE5GUzRfT0ssIHRoZW4gdGhlIG5leHQg
b3BlcmF0aW9uIGluIHRoZSBDT01QT1VORA0KPiA+IHByb2NlZHVyZSBpcyBleGVjdXRlZC4gVGhl
IHNlcnZlciBjb250aW51ZXMgdGhpcyBwcm9jZXNzIHVudGlsDQo+ID4gdGhlcmUNCj4gPiBhcmUg
bm8gbW9yZSBvcGVyYXRpb25zIHRvIGJlIGV4ZWN1dGVkIG9yIG9uZSBvZiB0aGUgb3BlcmF0aW9u
cyBoYXMNCj4gPiBhDQo+ID4gc3RhdHVzIHZhbHVlIG90aGVyIHRoYW4gTkZTNF9PSy4NCj4gDQo+
IE9idmlvdXNseSBpbiB0aGlzIGNhc2UgdGhlIGNsaWVudCBoYXMgc2VudCBhIHdlbGwtZm9ybWVk
IENPTVBPVU5ELA0KPiBidXQgaXQncyBub3Qgb25lIHRoZSBzZXJ2ZXIgY2FuIGV4ZWN1dGUgZ2l2
ZW4gdGhlIG9yZGVyaW5nDQo+IGNvbnN0cmFpbnQgc3BlbGxlZCBvdXQgYWJvdmUuDQo+IA0KPiBD
YW4geW91IHJlZmVyIHVzIHRvIGEgcGFydCBvZiBhbnkgUkZDIHRoYXQgc2F5cyBpdCdzIGFwcHJv
cHJpYXRlDQo+IHRvIGxvb2sgYWhlYWQgYXQgc3Vic2VxdWVudCBvcGVyYXRpb25zIGluIGFuIE5G
U3Y0LjAgQ09NUE9VTkQgdG8NCj4gb2J0YWluIGEgc3RhdGUgb3IgY2xpZW50IElEPyBPdGhlcndp
c2UgdGhlIExpbnV4IGNsaWVudCB3aWxsIGhhdmUNCj4gdGhlIHNhbWUgcHJvYmxlbSB3aXRoIGFu
eSBzZXJ2ZXIgaW1wbGVtZW50YXRpb24gdGhhdCBoYW5kbGVzDQo+IEdFVEFUVFIgY29uZmxpY3Rz
IGFzIGRlc2NyaWJlZCBpbiBSRkMgNzUzMCBTZWN0aW9uIDE2LjcuNS4NCj4gDQo+IEJhc2VkIG9u
IHRoaXMgbGFuZ3VhZ2UgSSBkb24ndCBiZWxpZXZlIE5GU3Y0LjAgY2xpZW50cyBjYW4gcmVseSBv
bg0KPiBzZXJ2ZXIgaW1wbGVtZW50YXRpb25zIHRvIGxvb2sgYWhlYWQgZm9yIGNsaWVudCBJRCBp
bmZvcm1hdGlvbi4gSW4NCj4gbXkgdmlldyB0aGUgY2xpZW50IG91Z2h0IHRvIHByb3ZpZGUgYSBj
bGllbnQgSUQgYnkgcGxhY2luZyBhIFJFTkVXDQo+IGJlZm9yZSB0aGUgR0VUQVRUUi4gRXZlbiBp
biB0aGF0IGNhc2UsIHRoZSBzZXJ2ZXIgaW1wbGVtZW50YXRpb24NCj4gbWlnaHQgbm90IGJlIGF3
YXJlIHRoYXQgaXQgbmVlZHMgdG8gc2F2ZSB0aGUgY2xpZW50IElEIGZyb20gdGhlDQo+IFJFTkVX
IG9wZXJhdGlvbi4NCj4gDQoNCk5vLiBJIGRvbid0IGdpdmUgYSByYXRzIGFyc2Ugd2hhdCB0aGUg
c3BlYyBzYXlzLg0KDQpJJ20gdGVsbGluZyB5b3Ugd2h5IHRoZSBjbGllbnQgaXMgZG9pbmcgd2hh
dCBpdCBkb2VzLiBZb3UgZWl0aGVyIGRlYWwNCndpdGggaXQsIG9yIHlvdSBkb24ndCwgYnV0IHdl
J3JlIG5vdCBjaGFuZ2luZyB0aGUgY2xpZW50IGFmdGVyIDIwIHllYXJzDQpvZiB0aGlzIGJlaGF2
aW91ci4NCg0KLS0gDQpUcm9uZCBNeWtsZWJ1c3QNCkxpbnV4IE5GUyBjbGllbnQgbWFpbnRhaW5l
ciwgSGFtbWVyc3BhY2UNCnRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20NCg0KDQo=
