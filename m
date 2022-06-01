Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DCB853AA7C
	for <lists+linux-nfs@lfdr.de>; Wed,  1 Jun 2022 17:51:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346113AbiFAPu6 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 1 Jun 2022 11:50:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345870AbiFAPu5 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 1 Jun 2022 11:50:57 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2120.outbound.protection.outlook.com [40.107.220.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63CC9A33B4
        for <linux-nfs@vger.kernel.org>; Wed,  1 Jun 2022 08:50:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CLTqxfAhPq0y8RkujmWQV0fI10rgwiZNQWWNNirUf4wKd77XwZtF36s1OZXOgJC8lrSh7hRExFIs3nRtn+PSm38/0hJUN7oZalAriGi/wbu8DyqRPJyK2aR7il0tNMZOxs3eD0Rpv0qyug/oJQK5LjnT5OR8+B8gYhyCY5ZhE+ifIOoI3qnZU4psKDsLQI1Se+u1PWbjwlMczl1zsfSCHH/59S/HV/6UdA1KDCqX4tUUV54v90aATJMPVQgvpiX4AFNGJO7ywp9OcecssGluzez/i5Ic9JZeLd+YCUDhB96ycJjz9CIciMkx0so+T1IUj1bZf9L0RC5Slcw2wWu1iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7WzZSQ0fNLQN5jMXmHE4TKPxqBB9n/yEwNIOd3F40FA=;
 b=D8/mydTAmsWlTqE8n+YmshKlewayEM62A0Bijufb30GPwiQ9+Z8YtEwBkwfOImXFj+jGy3HM+CK9D8JlnVUmaCLig0giYTGnYD/8xL9UIefnzjnHxACVj2TG/wT6tFzHJq+nIW4uQVED+Jh1GNf2aGrKKFdhlSqZ3GNyVe0wYaPyMOMJBMkWEmM0jUnNF1tcVL6w0O3vGpafW0zA9gZsiQYThM3raltEyU1jp0rmEJkKb0OCCs6GzR0KDtjEOi5uavRUabfkIRgn8QicSGbyq1NEyVmKLrFtcaTImWy1zPH8oyMjgJs42mcRdT6q/0JM4GjqQzLFihxDIIgKfBAv0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7WzZSQ0fNLQN5jMXmHE4TKPxqBB9n/yEwNIOd3F40FA=;
 b=AfHnJwcZpzfkTRMyP2kua1b/0mqf4Sk4Ph+vS9U0b81jZqwd5WW+Az2th9GYSDo2GXjB4jB5ip+Nr2s+nOAxIla0AxZaT+O9xEymf6Blz8eoAapHIGJeXreJ25HC5fX7JSGgCpp8WaiaI3uNyR99a9AQ9jSMinqKk/M6XzIpKF0=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by DM6PR13MB3292.namprd13.prod.outlook.com (2603:10b6:5:19c::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13; Wed, 1 Jun
 2022 15:50:53 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::694a:6bf0:4537:f3e5]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::694a:6bf0:4537:f3e5%6]) with mapi id 15.20.5314.013; Wed, 1 Jun 2022
 15:50:53 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "tigran.mkrtchyan@desy.de" <tigran.mkrtchyan@desy.de>,
        "olga.kornievskaia@gmail.com" <olga.kornievskaia@gmail.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>
Subject: Re: [PATCH] pNFS: fix IO thread starvation problem during
 LAYOUTUNAVAILABLE error
Thread-Topic: [PATCH] pNFS: fix IO thread starvation problem during
 LAYOUTUNAVAILABLE error
Thread-Index: AQHYdPUwtG1kTZlHl06QKDjQMPTRBK05FEoAgAARwQCAAQI5gIAAjI8A
Date:   Wed, 1 Jun 2022 15:50:53 +0000
Message-ID: <d858eb0f5c31e74185b2fc0fc29caedd06fe577b.camel@hammerspace.com>
References: <20220531134854.63115-1-olga.kornievskaia@gmail.com>
         <b829962068bf70b5aadcb16fd0265ec64c85f853.camel@hammerspace.com>
         <CAN-5tyGF56-spgEcwLV2cfw4KnNfO_ru9tRH9i_mMh+wmC+cTg@mail.gmail.com>
         <1666242553.16570812.1654068467831.JavaMail.zimbra@desy.de>
In-Reply-To: <1666242553.16570812.1654068467831.JavaMail.zimbra@desy.de>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 82bdcba2-655b-4c68-6246-08da43e68250
x-ms-traffictypediagnostic: DM6PR13MB3292:EE_
x-microsoft-antispam-prvs: <DM6PR13MB3292F985041BD0F018C1C6A9B8DF9@DM6PR13MB3292.namprd13.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ehgOV/Fsafxa4VwElxcG/v2zQrpTHmrKuueN8q0klIcQAGbZJUvwa5poRgbze6uPl4VCindw1wAsWBf5HNrR+cqoJXMTHbPNMSswkPOl/N+CGWdP1gpsLYQgZqVPMzAyoMom5SKogNIQ/mCFfR8ioCXNB4bygZo8PihdzIfoflNiaErajMt5/yC6DgTOeF7B8DBChh+23+VF5u6yO5dYaTygwpIo9L/STZnmvff5so12qJmHNZcsPQuVpdhoJ5Ww1u7xF6nqrLstIuy0E9eIppwaUlVuJGnkw1e3gfEPDcFpadmsFVT71DAlDwhFeXN0K/R/UZ4oIgRl8vZLwdWl7r9RWH6Mkm0qoR/g5GBBaAZp1D9lyZL7iSTU/ayVxjjgX2Y0mthvRrgo4W/gVumiM+HK2YJGpoiHTxiAHa+Y258R9QdrO+FI6COHZ0aLGCEIsgmMET9gUPH28OfGHAcB2M9cYnSPh+rSI+C1H3G9XOlN4ulwVBKU0stll9Yi0DUK0fJF7U8/9ptU4ssigxsJhrxax6rPllDOdJAokkUaD6lyiMh2rYY/HLN6DAf37k1tOpYQRR8nwpTPIBzz0/tw76SJtaodr5Btvtw9dxtLJOWkBy6/8WFbDJEkDPLwMvqH50dpLYo5/JrljUiPOq2TntinShJZTJirlRcP0YR5if7yUFoF4udch03a/A2mGKL8fQ02uPPDKUd8jFa4QrpVfb9BZOAR4/rHYdM5snzyXL1qC29lyg0FMTKytixiIYab
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(136003)(376002)(346002)(366004)(396003)(39840400004)(2906002)(8936002)(6512007)(66476007)(38100700002)(36756003)(83380400001)(64756008)(5660300002)(4326008)(8676002)(66946007)(76116006)(66446008)(66556008)(110136005)(122000001)(71200400001)(86362001)(316002)(54906003)(38070700005)(6486002)(186003)(508600001)(41300700001)(2616005)(6506007)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U1B4SUNjSVZLUkFWdzgzQUpPa1Zsc2gxeHpVYkltR2xxd0pTaDgvcDdWUDZp?=
 =?utf-8?B?cmhncVgwbkNCWFJMYm9mamYySVBQeE12NUxqSEFJTG1hdjdteFVpY3RiMUlo?=
 =?utf-8?B?aXFVSzg2VnZCdG42dW42MWcveTlGSHFTR1N6cXFDaE9QL2F1cXhDSTRCS2R2?=
 =?utf-8?B?ZHh1YXdvZkFqaW1wUEZPbUx5cXByNXRXQzJkNER3YmdrQ2RPcUtXZHRzQ0Np?=
 =?utf-8?B?RDJQaDZ2di9CdkFBWUhtZ1VUbzZLa3ZYMGVwRFVLeFIxU2FDQlVGYlFyNmtT?=
 =?utf-8?B?bFR1alNLLzgzV2xMUFc4bHRXa0NvbVpNN1VaUlVrcEFQRmxFd2Fjd2EyR1Fp?=
 =?utf-8?B?RElibEZ4cFVoVUV4RURkRjQyUEQweHhzK29Sa0R4b3VLTXJaY0FiU1JKd0NH?=
 =?utf-8?B?WGFyM1lhbXZ5d3lEVkt4M1Ryb1VXQ2JUZDlsNkdmYWNiZ2JDTjN0MTVrNlVq?=
 =?utf-8?B?MmxWQWVVSFZYRGxScjd6K3dQSTVVTTJRSEpsTnUwSVZXNE9PSzJER1pRVkQ2?=
 =?utf-8?B?Q0VzbmZ0M1B2bmhWVXRDaTAwU3RHYi9QZDZ2bTFDOEpSY2t4VndEbTJWSVAy?=
 =?utf-8?B?STlyK3ZKNURKU1UxVGUrQlliaHc2elJsY2Mxd084czR3MXNqNGNBKytmRnZB?=
 =?utf-8?B?L3d6N1RPMDZKWlFlVTNxTmV1RTVNOGlrZ0h6U2RRelQycVQ5elhpcG1LcitP?=
 =?utf-8?B?KzRwcElpa0RQVHBHMVV1c2s3ejBvMytxc1g3aHEwQXI5Z2VraWpnVEhkTzg4?=
 =?utf-8?B?WDJZblYyUzFETlJlQW8vR2l4VEZRdmFrVUlNZHJpL0Z6MzByZnU1bjZ5TGZL?=
 =?utf-8?B?d1UrNTFqL2lFa3l1VmdsWEIraXF6WFdENEQvaTN2cmxwakQ0MFlKeU5rTlVZ?=
 =?utf-8?B?UWRoUno3SHQyNDZEenZXcWtua3hzQmhMSTFscTB3c3Y3ejBQd0NJY3FqOWdy?=
 =?utf-8?B?K1RaTENrQWw3Mm40UHZ2aGFPMzU3YVFSTGVrZUlzalpXQ3pxZFhTOEdXUTVP?=
 =?utf-8?B?WXlPNjNTQVJOSXF4THJ1NzBSZGVYejJoV2xvazFPeXR1VEJPNzFGL1JOTTJJ?=
 =?utf-8?B?WGlNVUJ2RGxsZ3JyL3FlUUkzR1RsMzhIU0FCZFZjWjdkN0pwUVNMM29aeGhv?=
 =?utf-8?B?M2xHbDI4Q3NkaGYwdWJLb3UrRHBYVUR3RllnL1pEMlV1VGZBRndXcjBMb2Zp?=
 =?utf-8?B?Nld5NjFqZkRaa3VLQmtLVENrMGx6U29DRE1NdXY3b1pKaENzUUQ1S3FFUUtO?=
 =?utf-8?B?eVNnSFg4cXVnU0hDWnFwYTJ1TUs2NmhVdDRSdTQ3T05xd2tmS3ZtbGpoN1Iz?=
 =?utf-8?B?OFJ1b21oUzdpTWpSTkt5MWc3aFJtVnFVY01FWmFHYkZaak10OWVDL1FUV1Jp?=
 =?utf-8?B?YmF1cU1PODY1Ti9BeGl2Zlc2c1pDcGdxWFJmeENtams4OWgzQStXcmFWZ1N0?=
 =?utf-8?B?eGw1TkZRblcyTVpwZzk1R1FROFh6MlV1N2dQbFRHcmVYYzBSYThyN3d5eXZy?=
 =?utf-8?B?QU1EZmpIbTVaV1lzbitLZmVKMFBJR0VkQms3Z211MTd4MGZpVDYzTnV6QURJ?=
 =?utf-8?B?VWZUTmNMSHFsdWlFUWEvUDlxTVFTem1iOG5FNkhDSG5KSjdVclA0Q1ZrN1FJ?=
 =?utf-8?B?VWQ5UUhyZVJQdVRJNWRzbmZoa0xmajVrTHB0Z2VKbVozWmlBelNiNDNpNXpV?=
 =?utf-8?B?QkVmUHdHNXJIZDdGSTJzVUpTei8yQU5yQVcwNUZCUDZLdFI0MDJIN2FmZlRp?=
 =?utf-8?B?cXNvc0pDSjFHdVpQRndEejFVZk53VVBScWF0WjVTZVRpVmdNQUYvZmhZWFlK?=
 =?utf-8?B?VzUyd0lub2pIdyt6b0pZMjZBYkNqYnN6UUswbGlNUG0xeWRkdytsQ3IvbXFq?=
 =?utf-8?B?dUo3d3JOOXlpQVhiS2tmMnJKcDBwTDBzdjJzRnBJOE1jL2pRMlA2V21YZWt6?=
 =?utf-8?B?VHR4VzRJK3U4bC9LeFpTM2dFL3J1R043QXV1Tk9Hb3RIemEvNEVRL2R2U3pr?=
 =?utf-8?B?YmhEWjMyRmZNOElvalp4WGNxck0xWUJnUElkaklRVHlzSjcrbWFOVXpDVDJk?=
 =?utf-8?B?MXNIWU00VFVGMklGNEFyU3N6SU5BUnFWTFY0TGN1aktUOUpvR2hjd2o2K0JI?=
 =?utf-8?B?Q3dDT2dBVm12MjR6dTF2eGQxMy9IckM0TDEyUTlCaHY5NG1OaG16Y2NKd21a?=
 =?utf-8?B?V0lkNjNzVlUxUWx1UXI0M2NZaTEvTnpRMmNFejJiRUVvbGlkbHNVRzZBblhz?=
 =?utf-8?B?L3FrcFVja1RYczZ6L2RBd0JpYWZISE1zdVlTclQ1aXBtbHhaU0ZvREhRSjdJ?=
 =?utf-8?B?eGdUTGZOV2tYbTEyUjNiN1JMSnhCaEVSbjYrWG9kMnNpb2w1THg1SzczVlFC?=
 =?utf-8?Q?F2RWegTd/RsIANg0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7A40EAA2A52B8844918142C610881930@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82bdcba2-655b-4c68-6246-08da43e68250
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jun 2022 15:50:53.3723
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hSsNSliFC/roRDyqK9xWusmNu5LkNj8S+fPW01iGwwyf5N/G3CgER4uN7KGj9CyQBoNPmD53WL/14q8QEAcijw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR13MB3292
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gV2VkLCAyMDIyLTA2LTAxIGF0IDA5OjI3ICswMjAwLCBNa3J0Y2h5YW4sIFRpZ3JhbiB3cm90
ZToNCj4gSGkgT2xnYSwNCj4gDQo+IC0tLS0tIE9yaWdpbmFsIE1lc3NhZ2UgLS0tLS0NCj4gPiBG
cm9tOiAiT2xnYSBLb3JuaWV2c2thaWEiIDxvbGdhLmtvcm5pZXZza2FpYUBnbWFpbC5jb20+DQo+
ID4gVG86ICJ0cm9uZG15IiA8dHJvbmRteUBoYW1tZXJzcGFjZS5jb20+DQo+ID4gQ2M6ICJBbm5h
IFNjaHVtYWtlciIgPGFubmEuc2NodW1ha2VyQG5ldGFwcC5jb20+LCAibGludXgtbmZzIg0KPiA+
IDxsaW51eC1uZnNAdmdlci5rZXJuZWwub3JnPg0KPiA+IFNlbnQ6IFR1ZXNkYXksIDMxIE1heSwg
MjAyMiAxODowMzozNA0KPiA+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIHBORlM6IGZpeCBJTyB0aHJl
YWQgc3RhcnZhdGlvbiBwcm9ibGVtIGR1cmluZw0KPiA+IExBWU9VVFVOQVZBSUxBQkxFIGVycm9y
DQo+IA0KPiANCg0KPHNuaXA+DQoNCj4gPiBUbyBjbGFyaWZ5LCBjYW4geW91IGNvbmZpcm0gdGhh
dCBMQVlPVVRVTkFWQUlMQUJMRSB3b3VsZCBvbmx5IHR1cm4NCj4gPiBvZmYNCj4gPiB0aGUgaW5v
ZGUgcGVybWFuZW50bHkgYnV0IGZvciBhIHBlcmlvZCBvZiB0aW1lPw0KPiA+IA0KPiA+IEl0IGxv
b2tzIHRvIG1lIHRoYXQgZm9yIHRoZSBMQVlPVVRUUllMQVRFUiwgdGhlIGNsaWVudCB3b3VsZCBm
YWNlDQo+ID4gdGhlDQo+ID4gc2FtZSBzdGFydmF0aW9uIHByb2JsZW0gaW4gdGhlIHNhbWUgc2l0
dWF0aW9uLiBJIGRvbid0IHNlZSBhbnl0aGluZw0KPiA+IG1hcmtpbmcgdGhlIHNlZ21lbnQgZmFp
bGVkIGZvciBzdWNoIGVycm9yPyBJIGJlbGlldmUgdGhlIGNsaWVudA0KPiA+IHJldHVybnMgbm9s
YXlvdXQgZm9yIHRoYXQgZXJyb3IsIGZhbGxzIGJhY2sgdG8gTURTIGJ1dCBhbGxvd3MNCj4gPiBh
c2tpbmcNCj4gPiBmb3IgdGhlIGxheW91dCBmb3IgYSBwZXJpb2Qgb2YgdGltZSwgaGF2aW5nIGFn
YWluIHRoZSBxdWV1ZSBvZg0KPiA+IHdhaXRlcnMNCj4gDQo+IFlvdXIgYXNzdW1wdGlvbiBkb2Vz
bid0IG1hdGNoIHRvIG91ciBvYnNlcnZhdGlvbi4gRm9yIGZpbGVzIHRoYXQgb2ZmLQ0KPiBsaW5l
DQo+IChEUyBkb3duIG9yIGZpbGUgaXMgb24gdGFwZSkgd2UgcmV0dXJuIExBWU9VVFRSWUxBVEVS
LiBVc3VhbGx5LA0KPiBjbGllbnQga2VlcA0KPiByZS10cnlpbmcgTEFZT1VUR0VUIHVudGlsIGZp
bGUgaXMgYXZhaWxhYmxlIGFnYWluLiBXZSB1c2UgZmxleGZpbGUNCj4gbGF5b3V0DQo+IGFzIG5m
czRfZmlsZSBoYXMgbGVzcyBwcmVkaWN0YWJsZSBiZWhhdmlvci4gRm9yIGZpbGVzIHRoYXQgc2hv
dWxkIGJlDQo+IHNlcnZlZA0KPiBieSBNRFMgd2UgcmV0dXJuIExBWU9VVFVOQVZBSUxBQkxFLiBU
eXBpY2FsbHksIHRob3NlIGZpbGVzIGFyZSBxdWl0ZQ0KPiBzbWFsbA0KPiBhbmQgc2VydmVkIHdp
dGggYSBzaW5nbGUgUkVBRCByZXF1ZXN0LCBzbyBJIGhhdmVuJ3Qgb2JzZXJ2ZQ0KPiByZXBldGl0
aXZlIExBWU9VVEdFVA0KPiBjYWxscy4NCg0KUmlnaHQuIElmIHlvdSdyZSBvbmx5IGRvaW5nIFJF
QUQsIGFuZCB0aGlzIGlzIGEgc21hbGwgZmlsZSwgdGhlbiB5b3UNCmFyZSB1bmxpa2VseSB0byBz
ZWUgYW55IHJlcGV0aXRpb24gb2YgdGhlIExBWU9VVEdFVCBjYWxscyBsaWtlIE9sZ2ENCmRlc2Ny
aWJlcywgYmVjYXVzZSB0aGUgY2xpZW50IHBhZ2UgY2FjaGUgd2lsbCB0YWtlIGNhcmUgb2Ygc2Vy
aWFsaXNpbmcNCnRoZSBpbml0aWFsIEkvTyAoYnkgbWVhbnMgb2YgdGhlIGZvbGlvIGxvY2svcGFn
ZSBsb2NrKSBhbmQgd2lsbCBjYWNoZQ0KdGhlIHJlc3VsdHMgc28gdGhhdCBubyBmdXJ0aGVyIEkv
TyBpcyBuZWVkZWQuDQoNClRoZSBtYWluIHByb2JsZW1zIHdpdGggTkZTNEVSUl9MQVlPVVRVTkFW
QUlMQUJMRSBpbiBjdXJyZW50IHBORlMNCmltcGxlbWVudGF0aW9uIHdpbGwgb2NjdXIgd2hlbiBy
ZWFkaW5nIGxhcmdlIGZpbGVzIGFuZC9vciB3aGVuIHdyaXRpbmcNCnRvIHRoZSBmaWxlLiBJbiB0
aG9zZSBjYXNlcywgd2Ugd2lsbCBzZW5kIGEgTEFZT1VUR0VUIGVhY2ggdGltZSB3ZSBuZWVkDQp0
byBzY2hlZHVsZSBtb3JlIEkvTyBiZWNhdXNlIHdlIGRvbid0IGNhY2hlIHRoZSBuZWdhdGl2ZSBy
ZXN1bHQgb2YgdGhlDQpwcmV2aW91cyBhdHRlbXB0Lg0KDQotLSANClRyb25kIE15a2xlYnVzdA0K
TGludXggTkZTIGNsaWVudCBtYWludGFpbmVyLCBIYW1tZXJzcGFjZQ0KdHJvbmQubXlrbGVidXN0
QGhhbW1lcnNwYWNlLmNvbQ0KDQoNCg==
