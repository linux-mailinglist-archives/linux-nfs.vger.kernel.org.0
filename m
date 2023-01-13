Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9308D669CC0
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Jan 2023 16:47:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230064AbjAMPr3 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 13 Jan 2023 10:47:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230119AbjAMPqA (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 13 Jan 2023 10:46:00 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2093.outbound.protection.outlook.com [40.107.243.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3176A2EB
        for <linux-nfs@vger.kernel.org>; Fri, 13 Jan 2023 07:37:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nsGRObmwj4hDc0fsjAbk6jdhsuIk7G5L34mUVpTGPOAHo16hBh9XoNuFo6VNFE7f4nOTECFUNnqKr9BzXRxaIDu77J6ezZ9BbqepaXqvOHs3c+a+IROuRBzaNvhaFCL/LeTheo30+IMIIRQbQ5s7PDkdpD1wDpCYlmtnXxi7dGuY81Q7bK3gr5/r/SOG92r8zVF+Zjd+oeGK8AYC3ECixihyH4w0qcfoDkPnQcza3IC4AzBiQG8eNWS3zhkmuALIBCoiMVgKp59oIu3zkZ1Jy/cilQ2LwKhiulXGO9D56qB/pBe7FZE6B7yQDFqKb+Av/QRvXcROQFtJ9v6pMnHhIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7pxAwIm5250PBilsWxg0OfPm0x0kf9nK0qI6yB8Odiw=;
 b=KsffK4HL0/bSB4wDQEgfmPqxfEHchX74wuA0VyfHApZ4T/8liDhQnMTmUCqsNhn4M35RYEIw0T7n39LaNr5OEQrS38XISyddVmsvAhQnHc9CUSuNlv1j9t/x49Xk2KhY1LlGOcgaRu51cHmJPDvhBqtEs2NYnja+DhfO/IjPBryt9/i+5yPsdV+7A6tKtDqXPfNmQ6x3a9TxSg0FkkXe9qmXRNsl0Cu2irrpK+kqowfDBwM8U6+wDSc/eZVUxYTDHKj4EkqMpsHMhYI4YMtZa3X8MsBcA9m0gd2/ltvSs72LQ/5MOFV33bzOmAgXci70jfxoekBVOKac83+Ym2FOlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7pxAwIm5250PBilsWxg0OfPm0x0kf9nK0qI6yB8Odiw=;
 b=ZvbjSBhASQTAkq+EkJjNuBPvtQx4AFhF5DCiXWf550YtVTxr1jAfDe326PZAp8K8ZYx5OzMK9T13nHy/H06yfwt9MzFD4/gGHQblRxDEwCvwUg5L8si2hHLeY+7yRPvHyX1UPl0piY1zpJG40/dW9FYMAz3/0f/AB3QAp9DGjVI=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by SJ0PR13MB5474.namprd13.prod.outlook.com (2603:10b6:a03:420::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Fri, 13 Jan
 2023 15:37:19 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::7007:3376:4f4e:b87b]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::7007:3376:4f4e:b87b%4]) with mapi id 15.20.5986.019; Fri, 13 Jan 2023
 15:37:18 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     Charles Edward Lever <chuck.lever@oracle.com>
CC:     Wang Yugui <wangyugui@e16-tech.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: a dead lock of 'umount.nfs4 /nfs/scratch -l'
Thread-Topic: a dead lock of 'umount.nfs4 /nfs/scratch -l'
Thread-Index: AQHZJZtACPZxdcEfRkysts8xN6Ri966Y9OUAgAGQ/oCAAekjAIAAD4yA
Date:   Fri, 13 Jan 2023 15:37:18 +0000
Message-ID: <FBFF4BF0-EC67-472B-9B8A-A0891B1EFA90@hammerspace.com>
References: <20230111165945.7605.409509F4@e16-tech.com>
 <20230111173534.82A7.409509F4@e16-tech.com>
 <20230112173046.82E4.409509F4@e16-tech.com>
 <5B9215E4-99FF-4C52-901F-8D909DD165BD@oracle.com>
In-Reply-To: <5B9215E4-99FF-4C52-901F-8D909DD165BD@oracle.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.300.101.1.3)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|SJ0PR13MB5474:EE_
x-ms-office365-filtering-correlation-id: 59829720-7403-470f-48a9-08daf57c0e1f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dxJ1/5ULG2E3iqJZSw/PhndY/xl6IOj1SiTLGty6iiYf9ZezYPXcwCj2WIGht3xPBP3gce8xV0AdH8E6A0DicN2wCOMIy55GfSeEsPdujZE70DZtMAHc/LFGKn9BzqchujBdfMBEVJj/WvGHosIpatOK4W5KzIO8MRYQNsXrisGDpyuVdj67zDAFrgwwakOM0We9y5mFBIU0ENJrjB9tckUBJNeaUBLjkTG/DDoLnhrNdxKzYB8RIP9u4kawLfE6XyMvSssxRvkRD+JgSSZK+rCHDkVViewME5FFZRF5yff55L/+s0TfVuBK86b4XuPmE6ndQmM9l9yaxzbw2CIu/2owsBpS/m2c7dG/be4D7j7i115XYw8hwULKEQjzsuKIblzHso+LRATwr55YNpdZ6dTOGw/A7cuOzWPua54I1SNj1KgGgvw4ICzR6KaN1cwG8uadgEHE4X6uBhgCy73mlS7SE2RO2B4bRvmBzWnq5oS7of9b04CALI4qJ7eujSgH4gQqS9pKlGTRSns9/wKoxf1/vL7XmauvKfLngqlFj+wgIYdtZdxc3LJufaGROGrP5P8ItKi/XQjpV5acK/oTdNGvYkFzzm1NUFv7vIk+goB0HXtWFWdUNfRo9sdOUMGKy18XRP04OwjEo4LRIreE8GiBTZdQ92+DSCwWKz8IxDVlU39V0CKGwIsC/1bER5a4CP4sI4l0Xn5RoVYaKdcF4/oUB8s8bq42NCYNZKE2u4Y=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(396003)(376002)(136003)(366004)(39840400004)(451199015)(36756003)(6506007)(53546011)(6512007)(26005)(6486002)(478600001)(71200400001)(38100700002)(122000001)(186003)(86362001)(38070700005)(83380400001)(2616005)(33656002)(8936002)(5660300002)(2906002)(66946007)(316002)(76116006)(4326008)(66556008)(6916009)(8676002)(66476007)(64756008)(66446008)(41300700001)(54906003)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OW9QRnVhSzZpcU4rczdKVUN6aGJPNW5IY1NOcnNqQ2FXVFVZZXpSSDg0SmVp?=
 =?utf-8?B?a3pXYVlzUTdRektsMitJMXBxSmh5aEF4K0xhYTBPZC9ZNjBFK2VQemsyc3ly?=
 =?utf-8?B?bjZPYWFFeFBaOGFCRmxaM2pqdWUydXF0aXUrVFhRWHV1OHdpQm84UVBZdWIw?=
 =?utf-8?B?VG42clRCRG5PdHYxcnlIMkdaT0ZMODhnT3dJMlFSQXF3VjlKVjlNem1YZ0E4?=
 =?utf-8?B?NFNnaWxBU2FjaWFJSUVuZkkrNHdsSGd6bWczcWtCOEl1Y3lhd2Y4WkpVUE4v?=
 =?utf-8?B?ajROeEFWTVN0U2VhQTU5OGJuMHppVDZqQ2I0MjZNR2l5OGZOd0JYTmp6UVg4?=
 =?utf-8?B?Q3RTUi81RFU0V3dsd296R1k2K0FGcDdRb2pHalVUUFBUWUw0RUgwa3psRGo2?=
 =?utf-8?B?MWNQVUZCdm12OGMyM21GZFlpalFoWUFJVUxGOEVJSS9FL2Q0ak5pOEppbGdW?=
 =?utf-8?B?ak16bStkUVdEUTlqK1ErV2RTN2pYWEhHbEhrSVQxbWRFalpsUis2U25hMEFU?=
 =?utf-8?B?OUVKNmVPN0F2dFVEODNTL3dXUzdVL1dBMzhCUkcwK01PekJqdXprVXdZWGoy?=
 =?utf-8?B?NlFaSTdmYmFtc1diMTBmMlVYMHljU3MxcU9lUC9IbDFkeVVBTi92eTR0Mkww?=
 =?utf-8?B?UlY1Zi9aR2ZqMHVyYnptem9oNStobHVjNDVTRkpSQjlMY2MrM1hvblpXa282?=
 =?utf-8?B?N1hZY1p0Q2ZRMmxRKzdpUVQ0b1Q4V0tFbzhmN2NvVWprQ1hOeHBzZUJTcG1t?=
 =?utf-8?B?cVdLYXFRaURIUTAvajVVbzhRQ3UxcE5MRUhRdjRnbmNLTWdHanAreEo3aUxL?=
 =?utf-8?B?TU9VamdkQzdzUGlnUXlDMGVvK3JPbk40Qk9hVEhDZ1dQejdUbFpRT0dkNlRE?=
 =?utf-8?B?T29vbHNhUitqYXRwOS9udHpja2ZMbnhEVVduRWMrUTNkZk8wRmNweFQ3Q09o?=
 =?utf-8?B?U2t6WWhVckhlZkVLanI1Kzg3dGlGYmF2UHZUT3p3UzYvb1NTalMyODFNS1Rq?=
 =?utf-8?B?ODNTT05ERzQ3Um9jM3FDTWlTSG5HSXRpeFJMZmY3VlArSE5WcFA0QVJBa0RX?=
 =?utf-8?B?SzFYRkl3ZmNiazJvdTVTalJ6aEZoN1VsbGwxYllsNlhtZ01ac0tuTWtpdUQr?=
 =?utf-8?B?dnhYWGlqbGRzb0Jrb1lWWGZoMTZSQzFqY1g0YlZBUjlUY1dLbGw2UjNtSWdN?=
 =?utf-8?B?TzNLSUJsL0l0ZGxKbjFoQ2NzeHhhaDNjRDVSVmM2VlZxUWsvM05FMTBzeHlz?=
 =?utf-8?B?WkpyOXRyMVpmVTdNOENobEJOUGZVMllpdUhnaC9pdmE4azMwdis3UE14NU1n?=
 =?utf-8?B?b2cwWEhkcHVWMHJEdGNtbHJaRzMyMkRXU2NFaktHckFwQVY4Y1BhRDRSZ2lV?=
 =?utf-8?B?SDVkeHRBTjlFUkx6Y2gwSFdnLzNVUVJXNHl3YlI0ZXhuWTl3MU0rKzc4KzFq?=
 =?utf-8?B?alg0akQrbjRuMHZqTHlQRXEyVTEvazJsL1RIUFpQRkJoU2pBbFc1cS93bzhH?=
 =?utf-8?B?a1dKMkVPaUpLSnZDWWpVNTVoUFN4TE5TbXB2KzA0amZVN01wNDc1UlhtbkVQ?=
 =?utf-8?B?V0I4QXY0T3hNNHhocVgrblo4Sm1xbUFrTlYxa3dDU05YZ0VvMEh4OGhNMzIv?=
 =?utf-8?B?bStmN2piajduRzNhMVkzdXluSFRlNWR4VGpBSGlRdXFQM3FZRE9PMTVSZVY3?=
 =?utf-8?B?ZjJMbkN4UUllUURESkhMczRacGMyVUUvekF2Z0ZWclEwMDVjRTJPSVkzRTVL?=
 =?utf-8?B?UlY0aWV2cnVQWjFGNktJMmNBczRremMyaFdtWmdmaVdSNi9JeFRwOFF1L2hi?=
 =?utf-8?B?V1BKU3dwZlFWa0QrT3ppVnJ1QzlMVnA1SGNxNmExSXRSS2hPWGlhWGJGamlU?=
 =?utf-8?B?Qzkwajg4MWJuQkFzbC9vazdiZVFML3VUY2toUjk2bzQ4ZjBPZmpaR1RpUk5r?=
 =?utf-8?B?eElmSktoN3NOOGtNeHd2NWNHZ1M2MXZQNk5ZTkN1RWNCRG0vM2oyQ1BJMmU5?=
 =?utf-8?B?YjJnT3N0SmprNk83TGdINkpyRGllczlEQlZYQlJJaVdBWUo5SUVyUlVXdHFI?=
 =?utf-8?B?MEthVllaNmdpSnJ5SjhhY1luTlJiK2V2c1QxcEJCZnRQdkJLV2VWSEdmNGdP?=
 =?utf-8?B?SERxK09ISXh0UVNQdTcvd0YzbDZNOGpBaU52eDlpTmdSUEs5b2Jqek12eEhz?=
 =?utf-8?B?S3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5F38EB45C05BA343959515C5D0E2B55B@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59829720-7403-470f-48a9-08daf57c0e1f
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jan 2023 15:37:18.7558
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YAXZ+WY99lKNtkfruIEXT4mABoz/Qlg3WMyxGNOVprdRi34W0DAtdWdQQmA07fqjJM0iA0/nO3p3ineVN5i7YA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR13MB5474
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

DQo+IE9uIEphbiAxMywgMjAyMywgYXQgMDk6NDEsIENodWNrIExldmVyIElJSSA8Y2h1Y2subGV2
ZXJAb3JhY2xlLmNvbT4gd3JvdGU6DQo+IA0KPiANCj4gDQo+PiBPbiBKYW4gMTIsIDIwMjMsIGF0
IDQ6MzAgQU0sIFdhbmcgWXVndWkgPHdhbmd5dWd1aUBlMTYtdGVjaC5jb20+IHdyb3RlOg0KPj4g
DQo+PiBIaSwNCj4+IA0KPj4+IEhpLA0KPj4+IA0KPj4+PiBIaSwNCj4+Pj4gDQo+Pj4+IFdlIG5v
dGljZWQgYSBkZWFkIGxvY2sgb2YgJ3Vtb3VudC5uZnM0IC9uZnMvc2NyYXRjaCAtbCcNCj4+PiAN
Cj4+PiByZXByb2R1Y2VyOg0KPj4+IA0KPj4+IG1vdW50IC9kZXYvc2RhMSAvbW50L3Rlc3QvDQo+
Pj4gbW91bnQgL2Rldi9zZGEyIC9tbnQvc2NyYXRjaC8NCj4+PiBzeXN0ZW1jdGwgcmVzdGFydCBu
ZnMtc2VydmVyLnNlcnZpY2UNCj4+PiBtb3VudC5uZnM0IDEyNy4wLjAuMTovbW50L3Rlc3QvIC9u
ZnMvdGVzdC8NCj4+PiBtb3VudC5uZnM0IDEyNy4wLjAuMTovbW50L3NjcmF0Y2gvIC9uZnMvc2Ny
YXRjaC8NCj4+PiBzeXN0ZW1jdGwgc3RvcCBuZnMtc2VydmVyLnNlcnZpY2UNCj4+PiB1bW91bnQg
LWwgL25mcy9zY3JhdGNoICNPSw0KPj4+IHVtb3VudCAtbCAvbmZzL3Rlc3QgI2RlYWQgbG9jaw0K
Pj4+IA0KPj4+IEJlc3QgUmVnYXJkcw0KPj4+IFdhbmcgWXVndWkgKHdhbmd5dWd1aUBlMTYtdGVj
aC5jb20pDQo+Pj4gMjAyMy8wMS8xMQ0KPj4+IA0KPj4+PiBrZXJuZWw6IDYuMS41LXJjMQ0KPj4g
DQo+PiBUaGlzIHByb2JsZW0gaGFwcGVuIG9uIGtlcm5lbCA2LjIuMC1yYzMrKHVwc3RyZWFtKSB0
b28uDQo+IA0KPiBDYW4geW91IGNsYXJpZnk6DQo+IA0KPiAtIEJ5ICJkZWFkbG9jayIgZG8geW91
IG1lYW4gdGhlIHN5c3RlbSBiZWNvbWVzIHVucmVzcG9uc2l2ZSwgb3IgdGhhdA0KPiAganVzdCB0
aGUgbW91bnQgaXMgc3R1Y2s/DQo+IA0KPiAtIENhbiB5b3UgcmVwcm9kdWNlIGluIGEgbm9uLWxv
b3BiYWNrIHNjZW5hcmlvOiBhIHNlcGFyYXRlIGNsaWVudCBhbmQNCj4gIHNlcnZlcj8NCj4gDQoN
CknigJltIG5vdCBzZWVpbmcgaG93IHRoZSB1c2Ugb2YgdGhlIOKAmC1s4oCZIGZsYWcgaXMgYXQg
YWxsIHJlbGV2YW50IGhlcmUuIFRoZSBleGFjdCBzYW1lIHRoaW5nIHdpbGwgaGFwcGVuIGlmIHlv
dSBkb27igJl0IHVzZSDigJgtbOKAmS4gQWxsIHRoZSBsYXR0ZXIgZG9lcyBpcyBoaWRlIHRoZSBm
YWN0IHRoYXQgaXQgaXMgaGFwcGVuaW5nIGZyb20gdXNlciBzcGFjZS4NCg0KQXMgZmFyIGFzIEni
gJltIGNvbmNlcm5lZCwgdGhpcyBpcyBwcmV0dHkgbXVjaCBleHBlY3RlZCBiZWhhdmlvdXIgd2hl
biB5b3UgdHVybiBvZmYgdGhlIHNlcnZlciBiZWZvcmUgdW5tb3VudGluZy4gSXQgbWVhbnMgdGhh
dCB0aGUgY2xpZW50IGNhbuKAmXQgZmx1c2ggYW55IHJlbWFpbmluZyBkaXJ0eSBkYXRhIHRvIHRo
ZSBzZXJ2ZXIgYW5kIGl0IGNhbuKAmXQgY2xlYW4gdXAgc3RhdGUuIFNvIGp1c3QgZG9u4oCZdCBk
byB0aGF0Pw0KDQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18NClRyb25kIE15a2xl
YnVzdA0KTGludXggTkZTIGNsaWVudCBtYWludGFpbmVyLCBIYW1tZXJzcGFjZQ0KdHJvbmQubXlr
bGVidXN0QGhhbW1lcnNwYWNlLmNvbQ0KDQo=
