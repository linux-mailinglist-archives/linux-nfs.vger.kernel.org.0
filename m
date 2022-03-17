Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1593A4DBD5B
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Mar 2022 04:05:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230486AbiCQDHH (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 16 Mar 2022 23:07:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbiCQDHG (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 16 Mar 2022 23:07:06 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2134.outbound.protection.outlook.com [40.107.237.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D77A21248
        for <linux-nfs@vger.kernel.org>; Wed, 16 Mar 2022 20:05:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QNXDeysKJolfxC3FXmZteinWh7ty+Qsi5iQ0GdejyUMbDvvLXeuAYIZ2fCHGA6uvzxA27X5vKZCO+1Y/BC/89exhEsPTfPEy1iFBA1t83BAWnKsNyRxZNfYSgdJpJcx+keQLG4kf6Uj2hwfGQ0gfYqddQ1MmsIiB6QdKUGrhPA0EBFMHKmWVRIc246E6tzQLY0NuTHeVhOGH/o4CjNJvQj9hrocHHTyVAh18DrqqSJhfyTipfAcAeRLhd1H/lEAsMRotZy+kX1MAdjr1FY5wMCbjMRqWg4skhR509P4qF+fCihXao530GMhwaOP1tKGL6pL5oekzQI9HMJfYSgyWow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MIFOaabgOGKGI+cl9WEQl6E3doh8VrQG+fn3TtO3m7g=;
 b=e4eAH55FM1j1MmyPwN/0/hgFuYgK38efwITCzQFR3t+u7ENdWI7pmrm80Ss276TzNrtgOkZg2WuiLCrgsES+Vz/HUHoGeaQIL//QozgwtUfJ9Gaz6F6nJyrxToB81SpAK/WG6JDUZ9LEjyAOLWANxRB3Ndwgp2MxRR9z71oBW3nciDDBmDXcpdWdsa2UBGamyR/sxIA8Yxq9x1pJlt0dc3vr/fEh7RA+l6/IMdFCzNcT7w91wbwas9DidOXzUQegJOCFELvVo6zXMYCs3YwlJAHOhszQMoee126Uy9eOt7pMbF5leE8dR4z2Tli3K/SEQoCrX4NOT5Ql0r+EDloTUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MIFOaabgOGKGI+cl9WEQl6E3doh8VrQG+fn3TtO3m7g=;
 b=E74kH13wS9Y+qBVEv9pu3RWhPGPZzPtTxODx3qJwDj/XGQsLv1T8v88EnTchxPkyVD2E6YhgjRv4zGCjkQxS8K3WORy2vw8+QA7hio8Xs5ospyMx4dHjVD0uSHUL3jWCbL1isUxfhWGpF+TzQKkFn0hT7znaDgnNbguTPOB7yuw=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by MN2PR13MB3807.namprd13.prod.outlook.com (2603:10b6:208:1eb::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.14; Thu, 17 Mar
 2022 03:05:47 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::70cc:dd9c:25b:4f3f]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::70cc:dd9c:25b:4f3f%9]) with mapi id 15.20.5081.016; Thu, 17 Mar 2022
 03:05:46 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "enrico.scholz@sigma-chemnitz.de" <enrico.scholz@sigma-chemnitz.de>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: Random NFS client lockups
Thread-Topic: Random NFS client lockups
Thread-Index: AQHYOTNtgmB6rJCmJ0isIByWAotJaqzCffsJgAAMRwCAAAczf4AAU+2A
Date:   Thu, 17 Mar 2022 03:05:46 +0000
Message-ID: <800eb7d5daf7f59548645b1a310d2ba7993ba8af.camel@hammerspace.com>
References: <lyr172gl1t.fsf@ensc-virt.intern.sigma-chemnitz.de>
         <lysfrhr51i.fsf@ensc-virt.intern.sigma-chemnitz.de>
         <fd4d017808a5ff9492fc6dfce8506f64e600fb35.camel@hammerspace.com>
         <lyilsd8sfi.fsf@ensc-virt.intern.sigma-chemnitz.de>
In-Reply-To: <lyilsd8sfi.fsf@ensc-virt.intern.sigma-chemnitz.de>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ba0a0c14-294d-4ec7-30fe-08da07c30887
x-ms-traffictypediagnostic: MN2PR13MB3807:EE_
x-microsoft-antispam-prvs: <MN2PR13MB3807812ADABBA1B7F7629A56B8129@MN2PR13MB3807.namprd13.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PFRPGBFSFyrCc1t/zhJ1w1mvZo/eHArlc+VYbdsX5TohsB2RcFhaXAjCky1D19gRBSs/sxi4J99Oe1aN+dCnuEzRsLvIDKbeJHxWpiUuJLJ5XF/9xfm/0yBGgf3Ug10/mO7Ro72mPFK4408Q/XsCNmdPjXXkrduHLRRMQmTzNwxCaYUeRBzaVK4JBsaW2eyFSuanJfLODYdst0/9wGy4lfsYNm6lachmDT4Sxg30AicGDkwJ60MbzQ7KbYT/bmp3eeAr2r9UhOkexjFBEJEIKKOaWSb6m7dViLu8gl2THdGLsIi7fzVE0GBzeLCkH37fIXh+6sQy/Dmx946kXSCoabK5Ng7vGBdwz9MPpFSboCc1Xbz7i4qenjCWLWxm3nc0r4JzhuKiARgj7dHMyOyEOAYOtL92nMN8MePrNOn4HNFlaN8hRTdpydtZrT4ENVHpKKTHZkaHRPvdtdRpfrStZx2oxwa4fdo1UxSu5wjtUgWghkENvQ/0ynbb1SV283cJrTIF/Rf3tyY1701oESzHB3txAiOtTRLuOUSJ7HUc4xeQZwNkl8TgQ1A2fKh8pVWNzA7I8w7zKQbsUDqnR+IeR++YBV2JzONKTaK0y8lgz07ykoKZRPdgU1nymYgpkK5K48JG01OejqGk8UN+cTSEmvbJzcBNEGk/xlPdnIIg1dpBOitqCY67/q0mxmYZdiSQWc4hpycSlUPnhkMBEU+c6wm2esEYkfoiQ6+PCI+ZerG47fKyWp6SYn53vPYZs21i
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(99936003)(8936002)(2906002)(4744005)(5660300002)(966005)(6486002)(508600001)(122000001)(38070700005)(83380400001)(38100700002)(6916009)(2616005)(6512007)(186003)(26005)(316002)(3480700007)(8676002)(66476007)(66946007)(66556008)(4326008)(66446008)(64756008)(6506007)(76116006)(86362001)(36756003)(71200400001)(10090945011);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Vm1nelRtYVZDMjdSdjlLamg5L2UvR2N6V282QWlTblVrOWF4T2VhMkVta1Ev?=
 =?utf-8?B?TDlnbFN3UXdPUDV5czRWeWtReWkwVUFkSnowNEZGUkxXYjA2WjJ0REE2aDFB?=
 =?utf-8?B?M2xJbDRzT3p5RE1OUnlJV251eGdsK1Y1azYzeHdET1JkaTBaQTY1bDQrcE9G?=
 =?utf-8?B?T1lib2N3NXFCNzdsTlAvQ0hycU15NTJFV3k3VUFHTkJjSHVvb2FUOFlNTmdU?=
 =?utf-8?B?UlJ0NGc3czF5eXpmQWFHTWhqdGlaNEdnQVUxYTdSeUhBRXlEcktERHAzU3NY?=
 =?utf-8?B?VU5pRkVsQjg5eHZLM2dvN3lMcE01bFU3ZUFUOHpQMjVibG9iaTJWVGJRdndl?=
 =?utf-8?B?NkxBMVFXNFJ3ZTdvV1k3TWszNmtXL0VtcndJbElrSmxpOHdSWEFzYXc4aHF2?=
 =?utf-8?B?RDFoOUtnZkdSQ1dEYkJVdzZNTzRzM29KK0Vzc3pVRVpSM28vVVZLUld4aHpy?=
 =?utf-8?B?TFBEZFdzNmtxbzE1S0U4c3YwMHM1ZWJvU0ZqRkptNXJUSXpuUVBJQ04xeml3?=
 =?utf-8?B?ZUxQWUJkcXhEbnJhaFJaQ2t2SHNReWgrQ3ZLQnJzWnViMW4zcVpyMXZtaG9u?=
 =?utf-8?B?bEVOWEl2TEttSGFvUnNsdi91U2xEZGNBb3N5M25pcFNDRUlyM3NJMkFzS0N5?=
 =?utf-8?B?Ym92RnF4dDJYSzJoNDVpUjk4YnRDSlV1djhIWm5GTFdzS25nSDN4YmJHdEk5?=
 =?utf-8?B?YWg0cnloemhCUXJUcUhpeFVzZk5qV1VOS0J5WEZEN25yTDZOTE9Va3lFNWc5?=
 =?utf-8?B?Y3BwRlkrcUlYd24rZTA0ZEVCYTBDQ0tEb1hWK3A4U1pjcytadUE5MzMvRDRR?=
 =?utf-8?B?WTRLdjBXSjJLamRQM3p5MlhLSkV5aW05UCs0enVNd0I2N3lKUmNhem1wMDN1?=
 =?utf-8?B?NFNFTmNvd0RNREJ0SmZkZU5HamVLQ0JOUitwd3J4d2FYbVBvM2dYMjhwZ1JO?=
 =?utf-8?B?TVIzazc4OG5FSjlZYVlkMTFNTUMvRmRETGxtWU85OWxuS1RXSk02TGtubFJJ?=
 =?utf-8?B?MHpPWmMrQWVKOHJBZkJYWDFRKzhQMGZNUUxNeHRhbkhTRUh5RnV3TDFlQysy?=
 =?utf-8?B?SU9aMzZRWU1lZ21ILzhZSDFDM29icjVxSHVSZ0pHN3JNeWN4a25YaWFsdkdT?=
 =?utf-8?B?MlBFSmFLUDRsQ3ZiMHB6MzQvVUppZ1NmMlBIWXNpSUJ1NlJsb2t2ZVMySGtV?=
 =?utf-8?B?eEhVSnRHNzZ0bkFDeHJrWEhGUFZnbzliTnE0YkRlWTdXaTJaZ3hNYU11eTRo?=
 =?utf-8?B?WjlzbXB3bWVTOWVOUFk3elo1emY5eWZvMXJ4TlBxUndxSmc3NVZBN0ljaTYw?=
 =?utf-8?B?c2xlcXVsdGtUVkJjRjVKeUJBU08yYW9PSDN3dDhvZTMwdmwvZHIxRmdHRmRC?=
 =?utf-8?B?QWhEUmtwYXdkcHZWWHowc2ZuSk1sQkZyWU1LZkdiSEduTkZWKzVjS1JZQWFw?=
 =?utf-8?B?aWtjL1hxMWZwV2RUWTAxSFJzWVhYVHpDZ2xyYnJUUVRzaWhmYTl3bE1WRnkv?=
 =?utf-8?B?VUJZakdBcGZKTCtWVVVrOVB3V1R5R0lacitBS2UrUk9VbTZpTWF2R3QwQktY?=
 =?utf-8?B?MEpwQnFDYmVIT3RLRHRiNDVQTHRJZGFjY1F2QnJTZjNVRDV2dmtjaXNmaDZU?=
 =?utf-8?B?cE1vMERwakI5N3B4R2d0dXlTeWFCdUJCRTJWenl6dEpDanVEdG9vcEU0QUtT?=
 =?utf-8?B?ZGFwZDgzWWpiemhEV3Z2ZUlrb1RaZzZ1ZDVkSmI0OTVQZmlGTmh5bzNVSUZi?=
 =?utf-8?B?Y1JmUzRXOTVaeS94R3VzdGdGYVIxeFJHUE9RdUkxUzdPLys5NW5jczh1b2VY?=
 =?utf-8?B?WXdTY1VuYmdEYklhT2NyNnJwci9VNWJNVTB2dVdQcWpmUVEyR3Z6UVViUy9z?=
 =?utf-8?B?SWVtYVorTllsOTBjUVJNNXhNd2FYbjFFMUM3b3FoTnVSWlRobHNwVXFlOGpu?=
 =?utf-8?B?anJLQjI4RVIyc3NtY3YrTW15a1dsS1Q4UkZQMk5oVU16VXJ4dnM2ZHVWazlY?=
 =?utf-8?B?Z2R0VWUyc3pBPT0=?=
Content-Type: multipart/mixed;
        boundary="_002_800eb7d5daf7f59548645b1a310d2ba7993ba8afcamelhammerspac_"
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba0a0c14-294d-4ec7-30fe-08da07c30887
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2022 03:05:46.7722
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: m2BJCIjqJ1KnOO9kvkaNWB7apjqZZIx/sWXymbPnXaMwiXU3sUHtEh5di8So9yIi1d3Yz+G99nYyq62P+B2rgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR13MB3807
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

--_002_800eb7d5daf7f59548645b1a310d2ba7993ba8afcamelhammerspac_
Content-Type: text/plain; charset="utf-8"
Content-ID: <29F46B0226647B4FBCF6DFA75B0592A8@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64

T24gV2VkLCAyMDIyLTAzLTE2IGF0IDIzOjA1ICswMTAwLCBFbnJpY28gU2Nob2x6IHdyb3RlOg0K
PiBbWW91IGRvbid0IG9mdGVuIGdldCBlbWFpbCBmcm9tIGVucmljby5zY2hvbHpAc2lnbWEtY2hl
bW5pdHouZGUuDQo+IExlYXJuIHdoeSB0aGlzIGlzIGltcG9ydGFudCBhdA0KPiBodHRwOi8vYWth
Lm1zL0xlYXJuQWJvdXRTZW5kZXJJZGVudGlmaWNhdGlvbi5dDQo+IA0KPiBUcm9uZCBNeWtsZWJ1
c3QgPHRyb25kbXlAaGFtbWVyc3BhY2UuY29tPiB3cml0ZXM6DQo+IA0KPiA+IEJhc2ljYWxseSwg
d2hhdCB0aGUgYWJvdmUgbWVhbnMgaXMgdGhhdCB5b3VyIHNlcnZlciBpcyBpbml0aWF0aW5nDQo+
ID4gdGhlDQo+ID4gY2xvc2Ugb2YgdGhlIGNvbm5lY3Rpb24sIG5vdCB0aGUgY2xpZW50Lg0KPiAN
Cj4geWVzOyBidXQgdGhlIGNsaWVudCBzaG91bGQgcmVjb25uZWN0IChhbmQgZG9lcyBpdCBpbiBt
b3N0IGNhc2VzKS4NCj4gU29tZXRpbWVzIHRoZXJlIHNlZW1zIHRvIGJlIGEgcmFjZSB3aGljaCBw
cmV2ZW50cyB0aGUgcmVjb25uZWN0IGFuZA0KPiBicmluZ3MgdGhlIGNsaWVudCBpbiBhIGJyb2tl
biBzdGF0ZS4NCj4gDQoNCkkgZGlkbid0IHJlYWxpc2UgdGhhdCB5b3Ugd2VyZSBzZWVpbmcgYSBs
b25nIHRlcm0gaGFuZy4NCkNhbiB5b3UgcGxlYXNlIHRyeSB0aGUgYXR0YWNoZWQgcGF0Y2ggYW5k
IHNlZSBpZiBpdCBoZWxwcz8NCg0KLS0gDQpUcm9uZCBNeWtsZWJ1c3QNCkxpbnV4IE5GUyBjbGll
bnQgbWFpbnRhaW5lciwgSGFtbWVyc3BhY2UNCnRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5j
b20NCg0KDQo=

--_002_800eb7d5daf7f59548645b1a310d2ba7993ba8afcamelhammerspac_
Content-Type: text/x-patch;
	name="0001-SUNRPC-Don-t-call-connect-more-than-once-on-a-TCP-so.patch"
Content-Description:
 0001-SUNRPC-Don-t-call-connect-more-than-once-on-a-TCP-so.patch
Content-Disposition: attachment;
	filename="0001-SUNRPC-Don-t-call-connect-more-than-once-on-a-TCP-so.patch";
	size=3015; creation-date="Thu, 17 Mar 2022 03:05:46 GMT";
	modification-date="Thu, 17 Mar 2022 03:05:46 GMT"
Content-ID: <E4A9B0288CB4F048900DFB744E2CBBDC@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64

RnJvbSA4NWZkNmFlYzdhMTQ0MGI2NzQ1NDhkZDkzYmQzNDExYTU0ODZiNDliIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBUcm9uZCBNeWtsZWJ1c3QgPHRyb25kLm15a2xlYnVzdEBoYW1t
ZXJzcGFjZS5jb20+CkRhdGU6IFdlZCwgMTYgTWFyIDIwMjIgMTk6MTA6NDMgLTA0MDAKU3ViamVj
dDogW1BBVENIXSBTVU5SUEM6IERvbid0IGNhbGwgY29ubmVjdCgpIG1vcmUgdGhhbiBvbmNlIG9u
IGEgVENQIHNvY2tldAoKQXZvaWQgc29ja2V0IHN0YXRlIHJhY2VzIGR1ZSB0byByZXBlYXRlZCBj
YWxscyB0byAtPmNvbm5lY3QoKSB1c2luZyB0aGUKc2FtZSBzb2NrZXQuIElmIGNvbm5lY3QoKSBy
ZXR1cm5zIDAgZHVlIHRvIHRoZSBjb25uZWN0aW9uIGhhdmluZwpjb21wbGV0ZWQsIGJ1dCB3ZSBh
cmUgaW4gZmFjdCBpbiBhIGNsb3Npbmcgc3RhdGUsIHRoZW4gd2UgbWF5IGxlYXZlIHRoZQpYUFJU
X0NPTk5FQ1RJTkcgZmxhZyBzZXQgb24gdGhlIHRyYW5zcG9ydC4KClJlcG9ydGVkLWJ5OiBFbnJp
Y28gU2Nob2x6IDxlbnJpY28uc2Nob2x6QHNpZ21hLWNoZW1uaXR6LmRlPgpGaXhlczogM2JlMjMy
ZjExYTNjICgiU1VOUlBDOiBQcmV2ZW50IGltbWVkaWF0ZSBjbG9zZStyZWNvbm5lY3QiKQpTaWdu
ZWQtb2ZmLWJ5OiBUcm9uZCBNeWtsZWJ1c3QgPHRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5j
b20+Ci0tLQogaW5jbHVkZS9saW51eC9zdW5ycGMveHBydHNvY2suaCB8ICAxICsKIG5ldC9zdW5y
cGMveHBydHNvY2suYyAgICAgICAgICAgfCAyMiArKysrKysrKysrKystLS0tLS0tLS0tCiAyIGZp
bGVzIGNoYW5nZWQsIDEzIGluc2VydGlvbnMoKyksIDEwIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdp
dCBhL2luY2x1ZGUvbGludXgvc3VucnBjL3hwcnRzb2NrLmggYi9pbmNsdWRlL2xpbnV4L3N1bnJw
Yy94cHJ0c29jay5oCmluZGV4IDhjMmE3MTJjYjI0Mi4uNjg5MDYyYWZkZDYxIDEwMDY0NAotLS0g
YS9pbmNsdWRlL2xpbnV4L3N1bnJwYy94cHJ0c29jay5oCisrKyBiL2luY2x1ZGUvbGludXgvc3Vu
cnBjL3hwcnRzb2NrLmgKQEAgLTg5LDUgKzg5LDYgQEAgc3RydWN0IHNvY2tfeHBydCB7CiAjZGVm
aW5lIFhQUlRfU09DS19XQUtFX1dSSVRFCSg1KQogI2RlZmluZSBYUFJUX1NPQ0tfV0FLRV9QRU5E
SU5HCSg2KQogI2RlZmluZSBYUFJUX1NPQ0tfV0FLRV9ESVNDT05ORUNUCSg3KQorI2RlZmluZSBY
UFJUX1NPQ0tfQ09OTkVDVF9TRU5UCSg4KQogCiAjZW5kaWYgLyogX0xJTlVYX1NVTlJQQ19YUFJU
U09DS19IICovCmRpZmYgLS1naXQgYS9uZXQvc3VucnBjL3hwcnRzb2NrLmMgYi9uZXQvc3VucnBj
L3hwcnRzb2NrLmMKaW5kZXggN2UzOWY4N2NkZTJkLi44ZjhhMDNjMzMxNWEgMTAwNjQ0Ci0tLSBh
L25ldC9zdW5ycGMveHBydHNvY2suYworKysgYi9uZXQvc3VucnBjL3hwcnRzb2NrLmMKQEAgLTIy
MzUsMTAgKzIyMzUsMTUgQEAgc3RhdGljIHZvaWQgeHNfdGNwX3NldHVwX3NvY2tldChzdHJ1Y3Qg
d29ya19zdHJ1Y3QgKndvcmspCiAKIAlpZiAoYXRvbWljX3JlYWQoJnhwcnQtPnN3YXBwZXIpKQog
CQljdXJyZW50LT5mbGFncyB8PSBQRl9NRU1BTExPQzsKLQlpZiAoIXNvY2spIHsKLQkJc29jayA9
IHhzX2NyZWF0ZV9zb2NrKHhwcnQsIHRyYW5zcG9ydCwKLQkJCQl4c19hZGRyKHhwcnQpLT5zYV9m
YW1pbHksIFNPQ0tfU1RSRUFNLAotCQkJCUlQUFJPVE9fVENQLCB0cnVlKTsKKworCWlmICh4cHJ0
X2Nvbm5lY3RlZCh4cHJ0KSkKKwkJZ290byBvdXQ7CisJaWYgKHRlc3RfYW5kX2NsZWFyX2JpdChY
UFJUX1NPQ0tfQ09OTkVDVF9TRU5ULAorCQkJICAgICAgICZ0cmFuc3BvcnQtPnNvY2tfc3RhdGUp
IHx8CisJICAgICFzb2NrKSB7CisJCXhzX3Jlc2V0X3RyYW5zcG9ydCh0cmFuc3BvcnQpOworCQlz
b2NrID0geHNfY3JlYXRlX3NvY2soeHBydCwgdHJhbnNwb3J0LCB4c19hZGRyKHhwcnQpLT5zYV9m
YW1pbHksCisJCQkJICAgICAgU09DS19TVFJFQU0sIElQUFJPVE9fVENQLCB0cnVlKTsKIAkJaWYg
KElTX0VSUihzb2NrKSkgewogCQkJeHBydF93YWtlX3BlbmRpbmdfdGFza3MoeHBydCwgUFRSX0VS
Uihzb2NrKSk7CiAJCQlnb3RvIG91dDsKQEAgLTIyNjIsNiArMjI2Nyw3IEBAIHN0YXRpYyB2b2lk
IHhzX3RjcF9zZXR1cF9zb2NrZXQoc3RydWN0IHdvcmtfc3RydWN0ICp3b3JrKQogCQlmYWxsdGhy
b3VnaDsKIAljYXNlIC1FSU5QUk9HUkVTUzoKIAkJLyogU1lOX1NFTlQhICovCisJCXNldF9iaXQo
WFBSVF9TT0NLX0NPTk5FQ1RfU0VOVCwgJnRyYW5zcG9ydC0+c29ja19zdGF0ZSk7CiAJCWlmICh4
cHJ0LT5yZWVzdGFibGlzaF90aW1lb3V0IDwgWFNfVENQX0lOSVRfUkVFU1RfVE8pCiAJCQl4cHJ0
LT5yZWVzdGFibGlzaF90aW1lb3V0ID0gWFNfVENQX0lOSVRfUkVFU1RfVE87CiAJCWZhbGx0aHJv
dWdoOwpAQCAtMjMyMywxMyArMjMyOSw5IEBAIHN0YXRpYyB2b2lkIHhzX2Nvbm5lY3Qoc3RydWN0
IHJwY194cHJ0ICp4cHJ0LCBzdHJ1Y3QgcnBjX3Rhc2sgKnRhc2spCiAKIAlXQVJOX09OX09OQ0Uo
IXhwcnRfbG9ja19jb25uZWN0KHhwcnQsIHRhc2ssIHRyYW5zcG9ydCkpOwogCi0JaWYgKHRyYW5z
cG9ydC0+c29jayAhPSBOVUxMICYmICF4cHJ0X2Nvbm5lY3RpbmcoeHBydCkpIHsKKwlpZiAodHJh
bnNwb3J0LT5zb2NrICE9IE5VTEwpIHsKIAkJZHByaW50aygiUlBDOiAgICAgICB4c19jb25uZWN0
IGRlbGF5ZWQgeHBydCAlcCBmb3IgJWx1ICIKLQkJCQkic2Vjb25kc1xuIiwKLQkJCQl4cHJ0LCB4
cHJ0LT5yZWVzdGFibGlzaF90aW1lb3V0IC8gSFopOwotCi0JCS8qIFN0YXJ0IGJ5IHJlc2V0dGlu
ZyBhbnkgZXhpc3Rpbmcgc3RhdGUgKi8KLQkJeHNfcmVzZXRfdHJhbnNwb3J0KHRyYW5zcG9ydCk7
CisJCQkic2Vjb25kc1xuIiwgeHBydCwgeHBydC0+cmVlc3RhYmxpc2hfdGltZW91dCAvIEhaKTsK
IAogCQlkZWxheSA9IHhwcnRfcmVjb25uZWN0X2RlbGF5KHhwcnQpOwogCQl4cHJ0X3JlY29ubmVj
dF9iYWNrb2ZmKHhwcnQsIFhTX1RDUF9JTklUX1JFRVNUX1RPKTsKLS0gCjIuMzUuMQoK

--_002_800eb7d5daf7f59548645b1a310d2ba7993ba8afcamelhammerspac_--
