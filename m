Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 731E45991A6
	for <lists+linux-nfs@lfdr.de>; Fri, 19 Aug 2022 02:18:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238384AbiHSARt (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 18 Aug 2022 20:17:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234164AbiHSARt (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 18 Aug 2022 20:17:49 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2092.outbound.protection.outlook.com [40.107.220.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A74ABB92B
        for <linux-nfs@vger.kernel.org>; Thu, 18 Aug 2022 17:17:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cIwGhLsnP+kOqy1VmqbP/2yt8iP6MNIpVpbnbCBmpvc/WUckshwJkR66Lza2ENBIWHCNk43sPYLT+U+9+T4QcrfajnfInLF2WtGPXnwK0gWq92Lfz8L2iY4T8kqgdn8dFZpm0Cmx1eXJagqQkijGsE+7GAjjVbtBlRSgfEfSGPxO/AuA33ah/udQtlCEARJXTOFKRLEGv7LWtoPtmeDatpF7e0SI3zzVWKWphYFPZbQM/hfj2aMmYXTnsAfIbUUf2EKzgRRaaNKQ6PxmLj58GXE0zMI+dFKWTnTN/rFHIZLQlXCoCHCUYI6iOe56lB6Kk8yl+TUSxeauWiLmN+EA9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RuSL12iyTElVFe3RbYpyNXSioIJ5fVNHlbnpy6uqLTA=;
 b=UFTVHMr1p/Y2P/m0FB4PVlsubz+78dlzjuRzAQcgqJwpmI7BP0E2gBeOmtXbBX/g7GwGgkqwpQYBRaqLijUa7Pt0SAFzxRrd5aLvbNIme2jdy2nKUEPcNMpVI/8fFII0lm+h9DWiXgIhYKsa2oI+Nu410qnu45mG9F9BzqkW7GDRSojhKjjV7T2eNKsBNlMA2205dEjC0GOXWDHMCPMKXUzM5yxOKjnNUV7rgivuOQXM3kjf6KGU6zFc2CtD1inSxXNmzy27C44DSayuqW6mrT62iZLYYgsoxX1n6tmdLjgECzT0zoit/lCg5yZM9eBPh8Xn57iU+1P7nt69NCv/7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RuSL12iyTElVFe3RbYpyNXSioIJ5fVNHlbnpy6uqLTA=;
 b=RHtvV68t1cUPzaCtRIFPEskd8VA3e/lrVJXagk5DJWr5fNegqGSi6NjVS1UOFs+tMirjmroy5gCyUmdsEWnjl7A61w2zvyyHWUhshtjB4n6GQjvbB5lWXhWCNCXLGYH5KNldUONan3ebBWc2KYNkE7wunp2+LdGSBdjz+GsuGuE=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by DS7PR13MB4624.namprd13.prod.outlook.com (2603:10b6:5:3ab::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.4; Fri, 19 Aug
 2022 00:17:45 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::6dcb:fcd2:921b:9035]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::6dcb:fcd2:921b:9035%8]) with mapi id 15.20.5566.004; Fri, 19 Aug 2022
 00:17:45 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "neilb@suse.de" <neilb@suse.de>
CC:     "hooanon05g@gmail.com" <hooanon05g@gmail.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "aglo@umich.edu" <aglo@umich.edu>
Subject: Re: [PATCH v2] NFS: unlink/rmdir shouldn't call d_delete() twice on
 ENOENT
Thread-Topic: [PATCH v2] NFS: unlink/rmdir shouldn't call d_delete() twice on
 ENOENT
Thread-Index: AQHYs14Y8o8H+uhWfkyevwHHj+bLPq21W3aA
Date:   Fri, 19 Aug 2022 00:17:45 +0000
Message-ID: <d6a1c7378a4c666be93d22707405e0e0136a01fa.camel@hammerspace.com>
References: <166086695960.5425.17748020864798390841@noble.neil.brown.name>
In-Reply-To: <166086695960.5425.17748020864798390841@noble.neil.brown.name>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7daf9473-d2e2-405c-6350-08da81783d55
x-ms-traffictypediagnostic: DS7PR13MB4624:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rfteCkqWgWpI8dp9WgW/OGmCoiOIkR0y4ahmHEd/aSk94HVDdBzOexFzgd7d7excrtMJAw3+UrP7iEyG6eCqlNShVU8FXaLuhODV5LQt0SL2+d/m8op2P0u4VqVy+JKn4y7OzuCtGtgLkJkuYRKzMIW0ABA/z/2SfT24FEPeRPC7Uzjm96EeJME9LmMIjVGHtLgjyn8Hb9uzEsGCpKubwohKXJsKmXnmkeaBZ8Nh17eRjiR4LfyOZSBLJgy49Gme8pf579scKZ3QkIJWMc+y+rOZjOfhhLl5HhMr6eYdqq9mbSEndJg6uvdpRRTLKDNXRlyottunOdjmzGJvo4N2KddC/1LIVd0R4jC/s5R6NBIvur8smdmESIJ07sGaBJOQUHWXX89RjuMco+8jNnt4G2Qywb8c+kNKqmyAIIe68QV4+zr6rn4F5ZlPvbgTJK94ShIL06Ei5E/MsgOPB1m/z6GUdVRiBm2t3OFbeDM6jJ+d1vRMGiwcCpEuZ+dlidTVfE03VL25gm90sRaOiQ0ST8a6D9E8huHocDmmU+fIaqqKCCSUy0KKEaftxQSxvsSFtnYnQ063x1C8OVBYaHCGTGcbgVfDn6IFsQO4xGhMbiLf6XSkJdAfMFo4Lf+GPlR+9WDWSSdfqV8q0sqTq1K25quxDHq8J82Y0LwrCOra3a5rDTK1XjrTKIUqd0LTD1iabijX304bMXfjp6x3vaF09UJJxYuDFirMEZ4/IZoFnFiJ/LLgTFZ6jSRx5tcWRz504Ef+4I3f3sjLvFqMsBJtGw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(366004)(396003)(376002)(39840400004)(346002)(316002)(64756008)(66556008)(36756003)(122000001)(6916009)(54906003)(76116006)(66946007)(83380400001)(66446008)(66476007)(2616005)(186003)(38070700005)(71200400001)(478600001)(6486002)(4326008)(2906002)(6512007)(26005)(86362001)(5660300002)(8676002)(41300700001)(38100700002)(6506007)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cytyckJiNHV6U2s4U2lLd1ZDNXB2eUdGSGhEbER3aHpBZjZ0cWM4Ujc0c2Nx?=
 =?utf-8?B?Wm8rYXozcWtVRmJuQTZQb2dQcTRGOWNmZkdpcmxlQ24yM2dTMSt1YUhMWjJP?=
 =?utf-8?B?WXlKOWdrYWdRZnVBTGJtdngxWGU0V2M5ZXJ5YzBtNlhoZXlCejB6QXB6d2o1?=
 =?utf-8?B?WkpULzFJTUtYUnVDS2Z2bGl4ZndkSVhqa0FHZUJxT2x5NGxUekt1dkRiNUUx?=
 =?utf-8?B?QnZ2NUVWNGdhMU9LN1pNdVJTN0NNdGU5L2tINFZ5aVdsWnk5VUs2T1JSaWl4?=
 =?utf-8?B?TG9uK2NsVWhmN1MzU2cyTDQ2Ny9MVFA4djBiVnRhWHlheTlqK1lnT2RPQXR0?=
 =?utf-8?B?bE82QzVINTRXeTQ2S25XNGlMbGxGSVpaUWdxVURsNmRtSW1KbURKZ3AxOExX?=
 =?utf-8?B?UDgxQjFxQ3ZibEE3RGU4dmNoTnNyblpvZk1IbDk2WG5xeXVVZFRDZGliZ08w?=
 =?utf-8?B?dmN3UW5VRmNSOUVBZng5cDV1Ny85S3phRkFhVjlkd0FWN0tuNm5DNTRGczBL?=
 =?utf-8?B?VGJZdTlnRkVTeWRBeTMydlVCMUtvTEhXc0hJbWVxazE1VXVicDl0VTlQSWlV?=
 =?utf-8?B?NFJ5Yi8rdm8va0J3VzEvcFhvcWZWUXFZeDE3MUxTeWMyMDlpczNlSC9SR1dq?=
 =?utf-8?B?M0ZSa01IU2Rwd21QVDVoY0NKVWZLWEwzOTE2YVZEOWpZZVA3NWhyT1NrdWh4?=
 =?utf-8?B?aTZxcFE3YzdEOFlDeG52d2h5ODhqUE1GNndNWXFETjhlbU5ReFN5ajUreFdR?=
 =?utf-8?B?ME1uTW50dzJ4b2ZmQzZiT1R2ZUNsM1VyQkZSSklQTk9PQkN3TlhnaGRPaXFk?=
 =?utf-8?B?WkZidkovWjBIV0pPd01OL3JSOGxuWHZ2VkJJTkhaUFhhL3A1azJKY0xnaHI3?=
 =?utf-8?B?QTdUc2NERlVyM09mdDZQclNXT3Y0Sit6NnBXQmYvWStLbjUvT3dkM2o1N0d1?=
 =?utf-8?B?eWpqeGpsbHJhUVdGWWl3VStlOXllQjJJM21NandRS0s3UkozL0pVRFBPQlIw?=
 =?utf-8?B?ZFd0OXZuVWNGaXF1L2NJQXpSZVZWNWt5WVEwMGVsZCtaQytJL3kzb0JyV2Vl?=
 =?utf-8?B?M0dnQ285cEV6ZU5wWGxsdGRLeVUxK3BvRUtRTTNpZ0pHcnhHVHRoZHZQYkl6?=
 =?utf-8?B?blIxSTRxNm9UY1lkUHgzMHNYdWgwRUdMdU03ZFRWVEFYb2lQUWJ0N2Y5Nllk?=
 =?utf-8?B?SXpOR0k0Y29KK0d2cTV0UkNSSWx5K3JUSThQekRHOWlwSFp5MFVNYW5oOEZv?=
 =?utf-8?B?b1NGemVYWmw1U1piMlpZZ2FwMFdyZlo3SS9CWmxwbXVSOXJTOVozWFdlNmFv?=
 =?utf-8?B?Qi9scHNMM28raW9zNkdjNGdob2RDVWRZQVF6ODgvZnFoZ0NiNDRabGJZMllp?=
 =?utf-8?B?QkxyS21keGN3MEtRT3FTQm5XQ2xNVnZIcWFsY0lsNml2T3RON1kwb1dPM3pt?=
 =?utf-8?B?OGFNbmJIdVBKODE1Ky8xLzFiZldkZE9VNGNjTWlBcXIyaGd3T2J5cnRFc09r?=
 =?utf-8?B?ek9UckR2Qmo4dTF2V2JIczRCeHVXd2JlMXNLOUw1NGlaSkViY3hlaDRoZWo2?=
 =?utf-8?B?bWlPS3hvdzF6TGExK01wU29MZUJsSVdqREFXR3B1NTlRSWdDcTZnaDRFem42?=
 =?utf-8?B?U1F0OURpR0QrOVcrZ2tINERKMC9XSzl5bEFxcnB1WWdlSlV2VE52QVJnbTZO?=
 =?utf-8?B?R2NPd3V0Vnd0Q2VDODl6aklibjJtd0FhZzdVazM2YkRpTnZpNWVQWENxT25P?=
 =?utf-8?B?TlN1aGpQMGhXdXpnT3k0dEN5TTRKemxQblduV1FPWDN2YjNOMlk3OVZyVjEy?=
 =?utf-8?B?b0lubXVlYjllcTNXK1lwdEgvMlh3MVcrWGZpdWgwUE1kWGxnd2pXc2cxcmVV?=
 =?utf-8?B?dDg2QnM1dVYvU3YxVG1VUThmTVNVbllSZm9Ia0U3SEpJd2YwSUoxZEtBTTkz?=
 =?utf-8?B?NTJ5c1NTQ2ZQakZsQ296Z2Jmam4wdXhLZlBFMEcxZmpVeGd2TXV0RWFKZWYx?=
 =?utf-8?B?czFxVklpc09HdEJQVCtTbTRYTzVyVGZLMmdRanI4L2YwTExYT0t4aFl2OVNE?=
 =?utf-8?B?M0dOZnNvRDhXUFJTSGUrNFBMekxLQUN6MnQvaUZ3VHlDNUVlRmVPelFNMzFC?=
 =?utf-8?B?RmY0NmhtaHFZZzdHTjMzRWNhZ2prRjJLMXZ3RHFEUm9uY21ud25zb1oreDhn?=
 =?utf-8?B?NlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EB6F1E69289CC945A262A98398DDF432@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7daf9473-d2e2-405c-6350-08da81783d55
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2022 00:17:45.0942
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nNHjyi7Ti20ZgK3FIjsz7GBG7SNk9F919djcLPtb2dk4MECv+V6J31BVMXB7xCAwDqZX+k1/DZVkaVOR7eU0Fw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR13MB4624
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gRnJpLCAyMDIyLTA4LTE5IGF0IDA5OjU1ICsxMDAwLCBOZWlsQnJvd24gd3JvdGU6DQo+IA0K
PiBuZnNfdW5saW5rKCkgY2FsbHMgZF9kZWxldGUoKSB0d2ljZSBpZiBpdCByZWNlaXZlcyBFTk9F
TlQgZnJvbSB0aGUNCj4gc2VydmVyIC0gb25jZSBpbiBuZnNfZGVudHJ5X2hhbmRsZV9lbm9lbnQo
KSBmcm9tIG5mc19zYWZlX3JlbW92ZSBhbmQNCj4gb25jZSBpbiBuZnNfZGVudHJ5X3JlbW92ZV9o
YW5kbGVfZXJyb3IoKS4NCj4gDQo+IG5mc19ybWRkaXIoKSBhbHNvIGNhbGxzIGl0IHR3aWNlIC0g
dGhlIG5mc19kZW50cnlfaGFuZGxlX2Vub2VudCgpDQo+IGNhbGwNCj4gaXMgZGlyZWN0IGFuZCBp
bnNpZGUgYSByZWdpb24gbG9ja2VkIHdpdGggLT5ybWRpcl9zZW0NCj4gDQo+IEl0IGlzIHNhZmUg
dG8gY2FsbCBkX2RlbGV0ZSgpIHR3aWNlIGlmIHRoZSByZWZjb3VudCA+IDEgYXMgdGhlIGRlbnRy
eQ0KPiBpcw0KPiBzaW1wbHkgdW5oYXNoZWQuDQo+IElmIHRoZSByZWZjb3VudCBpcyAxLCB0aGUg
Zmlyc3QgY2FsbCBzZXRzIGRfaW5vZGUgdG8gTlVMTCBhbmQgdGhlDQo+IHNlY29uZA0KPiBjYWxs
IGNyYXNoZXMuDQo+IA0KPiBUaGlzIHBhdGNoIGd1YXJkcyB0aGUgZF9kZWxldGUoKSBjYWxsIGZy
b20gbmZzX2RlbnRyeV9oYW5kbGVfZW5vZW50KCkNCj4gbGVhdmluZyB0aGUgb25lIHVuZGVyIC0+
cmVtZGlyX3NlbSBpbiBjYXNlIHRoYXQgaXMgaW1wb3J0YW50Lg0KPiANCj4gSW4gbWFpbmxpbmUg
aXQgd291bGQgYmUgc2FmZSB0byByZW1vdmUgdGhlIGRfZGVsZXRlKCkgY2FsbC7CoCBIb3dldmVy
DQo+IGluDQo+IG9sZGVyIGtlcm5lbHMgdG8gd2hpY2ggdGhpcyBtaWdodCBiZSBiYWNrcG9ydGVk
LCB0aGF0IHdvdWxkIGNoYW5nZQ0KPiB0aGUNCj4gYmVoYXZpb3VyIG9mIG5mc191bmxpbmsoKS7C
oCBuZnNfdW5saW5rKCkgdXNlZCB0byB1bmhhc2ggdGhlIGRlbnRyeQ0KPiB3aGljaA0KPiByZXN1
bHRlZCBpbiBuZnNfZGVudHJ5X2hhbmRsZV9lbm9lbnQoKSBub3QgY2FsbGluZyBkX2RlbGV0ZSgp
LsKgIFNvIGluDQo+IG9sZGVyIGtlcm5lbHMgd2UgbmVlZCB0aGUgZF9kZWxldGUoKSBpbg0KPiBu
ZnNfZGVudHJ5X3JlbW92ZV9oYW5kbGVfZXJyb3IoKQ0KPiB3aGVuIGNhbGxlZCBmcm9tIG5mc191
bmxpbmsoKSBidXQgbm90IHdoZW4gY2FsbGVkIGZyb20gbmZzX3JtZGlyKCkuDQo+IA0KPiBUbyBt
YWtlIHRoZSBjb2RlIHdvcmsgY29ycmVjdGx5IGZvciBvbGQgYW5kIG5ldyBrZXJuZWxzLCBhbmQg
ZnJvbQ0KPiBib3RoDQo+IG5mc191bmxpbmsoKSBhbmQgbmZzX3JtZGlyKCksIHdlIHByb3RlY3Qg
dGhlIGRfZGVsZXRlKCkgY2FsbCB3aXRoDQo+IHNpbXBsZV9wb3NpdGl2ZSgpLsKgIFRoaXMgZW5z
dXJlcyBpdCBpcyBuZXZlciBjYWxsZWQgaW4gYSBjaXJjdW1zdGFuY2UNCj4gd2hlcmUgaXQgY291
bGQgY3Jhc2guDQo+IA0KPiBGaXhlczogM2M1OTM2NmMyMDdlICgiTkZTOiBkb24ndCB1bmhhc2gg
ZGVudHJ5IGR1cmluZyB1bmxpbmsvcmVuYW1lIikNCj4gRml4ZXM6IDkwMTlmYjM5MWRlMCAoIk5G
UzogTGFiZWwgdGhlIGRlbnRyeSB3aXRoIGEgdmVyaWZpZXIgaW4NCj4gbmZzX3JtZGlyKCkgYW5k
IG5mc191bmxpbmsoKSIpDQo+IFNpZ25lZC1vZmYtYnk6IE5laWxCcm93biA8bmVpbGJAc3VzZS5k
ZT4NCj4gLS0tDQo+IMKgZnMvbmZzL2Rpci5jIHwgMyArKy0NCj4gwqAxIGZpbGUgY2hhbmdlZCwg
MiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZnMvbmZz
L2Rpci5jIGIvZnMvbmZzL2Rpci5jDQo+IGluZGV4IGRiYWIzY2FhMTVlZC4uOGYyNmY4NDg4MThk
IDEwMDY0NA0KPiAtLS0gYS9mcy9uZnMvZGlyLmMNCj4gKysrIGIvZnMvbmZzL2Rpci5jDQo+IEBA
IC0yMzgyLDcgKzIzODIsOCBAQCBzdGF0aWMgdm9pZA0KPiBuZnNfZGVudHJ5X3JlbW92ZV9oYW5k
bGVfZXJyb3Ioc3RydWN0IGlub2RlICpkaXIsDQo+IMKgew0KPiDCoMKgwqDCoMKgwqDCoMKgc3dp
dGNoIChlcnJvcikgew0KPiDCoMKgwqDCoMKgwqDCoMKgY2FzZSAtRU5PRU5UOg0KPiAtwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZF9kZWxldGUoZGVudHJ5KTsNCj4gK8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoGlmIChkX3JlYWxseV9pc19wb3NpdGl2ZShkZW50cnkpKQ0KPiAr
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGRfZGVsZXRlKGRl
bnRyeSk7DQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgbmZzX3NldF92ZXJpZmll
cihkZW50cnksDQo+IG5mc19zYXZlX2NoYW5nZV9hdHRyaWJ1dGUoZGlyKSk7DQo+IMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgYnJlYWs7DQo+IMKgwqDCoMKgwqDCoMKgwqBjYXNlIDA6
DQoNCk9LLiBJJ3ZlIGtpY2tlZCB2MSBvdXQgb2YgbXkgbGludXgtbmV4dCBicmFuY2gsIGFuZCBh
cHBsaWVkIHYyIHRvIG15DQp0ZXN0aW5nIGJyYW5jaC4gSSdsbCB0cnkgdG8gZ2l2ZSBpdCBzb21l
IHRlc3RpbmcgdG9tb3Jyb3cuDQoNCk9sZ2EsIHdpbGwgeW91IGJlIGFibGUgdG8gdGVzdCB2MiB0
byBzZWUgaWYgaXQgZml4ZXMgeW91ciBidWcgcmVwb3J0IGFzDQp3ZWxsPw0KDQotLSANClRyb25k
IE15a2xlYnVzdA0KTGludXggTkZTIGNsaWVudCBtYWludGFpbmVyLCBIYW1tZXJzcGFjZQ0KdHJv
bmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbQ0KDQoNCg==
