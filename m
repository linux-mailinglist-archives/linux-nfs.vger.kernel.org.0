Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B2F250BB08
	for <lists+linux-nfs@lfdr.de>; Fri, 22 Apr 2022 17:01:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1449116AbiDVPCJ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 22 Apr 2022 11:02:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1449084AbiDVPCH (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 22 Apr 2022 11:02:07 -0400
Received: from EUR03-VE1-obe.outbound.protection.outlook.com (mail-oln040092072032.outbound.protection.outlook.com [40.92.72.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EBD05D181
        for <linux-nfs@vger.kernel.org>; Fri, 22 Apr 2022 07:59:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O9GuqMvaePZlP3Q6PmYF0ZXVOFxqZLMQacaWO0aoHFXghiQYn5chw3xcWt0WEnVeuKXmFVEI9Jxsf6uI+PhBjAD+KTKaaBbNeDZFEZHNpI5RsbxEKwIme+bGewNFjs9u2VFGlwu58V6Ih2BG18f3408jJtu7jktv8JtBoLEC/p5RH3uPW4kb8cjKte007GcBumW63NKpXETALpmHA3LYflQqjNgqKljusyTcb5A9JKNZhWams7lhdoUp6OVMfxm8vGYpUSyCHkKAIkuypAdC9eJ3FRGyTNuLPxric4RZgxxlDeP6FYP6crfkJMtjIfNoLwoJTSACS4u2cqASBzAUFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yeuYrUiguUkxh/muq8a5qHyxVcu9/kWIXzlekAOPYz0=;
 b=Bmb7l8GfxyPg+MLJgYtPBjgD3cfbMgYeEdk49bo1k+Wqy0isTAAw10gEYxn4cnLLIgxSBJDeGaIAzK039ElJ8KAYH931A6Ucd6OJPLkNHXw6HLMKqEiZYNQV4Fg+X03O5XcvFxAzjt+T08XLtk0fnEa99F0zzzOYHLAOshleIl1V0+mxPzJCicGfta+EsSqt/8vXRrZnmyqloMhqrVjlK2B6K7dwPsoBZeiSRjRBVb0pxSpqrV+ggpLHIN9mOAJQWlCWZWNDNuu6kjW48A1ztUMu/yH9XyivbVOXxVQOuHsOW6k6qci4gmK6aU6MV814FEyLdXGFdBSC2gPA7sZ+Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from AM9P191MB1665.EURP191.PROD.OUTLOOK.COM (2603:10a6:20b:267::24)
 by DB9P191MB1997.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:243::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Fri, 22 Apr
 2022 14:59:01 +0000
Received: from AM9P191MB1665.EURP191.PROD.OUTLOOK.COM
 ([fe80::543a:843f:f401:da2a]) by AM9P191MB1665.EURP191.PROD.OUTLOOK.COM
 ([fe80::543a:843f:f401:da2a%5]) with mapi id 15.20.5186.015; Fri, 22 Apr 2022
 14:59:01 +0000
From:   "crispyduck@outlook.at" <crispyduck@outlook.at>
To:     Chuck Lever III <chuck.lever@oracle.com>,
        Rick Macklem <rmacklem@uoguelph.ca>
CC:     Bruce Fields <bfields@fieldses.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: AW: Problems with NFS4.1 on ESXi 
Thread-Topic: Problems with NFS4.1 on ESXi 
Thread-Index: AQHYVOLTJWvLLebuJE+8fGO0gJ9faaz5zdx5gACo0QCAAAJi6IAAGkiAgAAlUYCAAE6KrIAA+egAgAACnqM=
Date:   Fri, 22 Apr 2022 14:59:01 +0000
Message-ID: <AM9P191MB16653ED845751B0600F58DB08EF79@AM9P191MB1665.EURP191.PROD.OUTLOOK.COM>
References: <AM9P191MB1665484E1EFD2088D22C2E2F8EF59@AM9P191MB1665.EURP191.PROD.OUTLOOK.COM>
 <AM9P191MB16655E3D5F3611D1B40457F08EF49@AM9P191MB1665.EURP191.PROD.OUTLOOK.COM>
 <4D814D23-58D6-4EF0-A689-D6DD44CB2D56@oracle.com>
 <AM9P191MB16651F3A158CAED8F358602A8EF49@AM9P191MB1665.EURP191.PROD.OUTLOOK.COM>
 <20220421164049.GB18620@fieldses.org> <20220421185423.GD18620@fieldses.org>
 <YT2PR01MB973028EFA90F153C446798C1DDF49@YT2PR01MB9730.CANPRD01.PROD.OUTLOOK.COM>
 <A22B7B39-1FEA-4FFF-84D4-0FCBE42B590B@oracle.com>
In-Reply-To: <A22B7B39-1FEA-4FFF-84D4-0FCBE42B590B@oracle.com>
Accept-Language: de-AT, en-US
Content-Language: de-AT
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
suggested_attachment_session_id: 3c7bcbd7-17a1-72e1-eae0-07461e6ed809
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [b9S2wGUPJJEa/kbwG7kzqIEHZa3OBDEK]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 936bfef1-1f42-4ca2-3b4a-08da2470a316
x-ms-traffictypediagnostic: DB9P191MB1997:EE_
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /FUBq0Uc8LlIixOY7T+9JyIp97uZK3JoXDmfP1lNlLuaVPcUxqGckyUQFuP2Vrm7DtaWkV7fPAitaA4cjS1E1LRLNyIVeKRuT5q42fYyPRoh3iwBOxvUhIzrPc1OdxkTm+dKvIVcdc8vb44Vf1QoUUdy/6tMqHPjjYCJGFb9FdBhE30mZONHZbJ4A6Y0SZcoFU+ZFBKrFsHlNhIAgG50SreD1nBnw6JcasGTSOp+z0snYT7WbGPGKDNgFkmVTECgBgJ9iH5uDi549kV+l5NTnIKcEpST9ky6mMxK7Xw9b2Wu6chY7sVEO6nNETx9JHhj8sAntUVqfAUJ5AYStYg+cU2FDT28unsT6Tabf7qXH1Wb58nJWvesx66myxTR6H+HmAFVbZnQOEEugetUH9ujJFbq54IzA06geRuOFTPc3+F3+CE84UkOiLcwM96CbCrj4mZc4ytr15TClbt8u3rdxqb3DD35MjVijzKnzhWX0E4TQmJACxvq8Bbm/EmcoQyBegNy5GJhaUkE3Z3ZMolpiekc8I1TLpavdgrLAX1OXAiwO2vGaMKbmW2Dqhx1frEvviHLioRFDZZHbtiKu9Trfg==
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TkZwbjYvUGt4bUJ3ZFlQaEVhbWdHZFNDT1J5MzNnT2V1MUxibGJacjM5Q2ZU?=
 =?utf-8?B?MkdsQTRubG9aU2tCNDI4TS9ucnN1eVdPc3ZQTFVPdWxDaElYUVBzcVNTZDE0?=
 =?utf-8?B?S01BZW5QTHRhRnppRWNGeDFNanNjRzFuY2xva1pZaTdxcWRtZnNueWl5WGFi?=
 =?utf-8?B?UVBSMG1sdlVqVXdYL2tkL3AvZkc1cFVxUWhNcHdRTzZLQ3NubTM3NXZlY3li?=
 =?utf-8?B?K0RLQnFnVjNKcTJVNDBQYndnWnAvTE9OVjFnYU5wTmNteWxUV3NYYW1sK2lY?=
 =?utf-8?B?anhuSmM3bUxjQzQyNGNxYzZHM1p0dWhSeCs4SjVZQWR1WHZkYVI2L3RPY0xP?=
 =?utf-8?B?SEJsSm1KNThMSEU5TkZEcjV1TGJvM1g1WXhobW9DbEJETkRhTzZXYnJQMWh5?=
 =?utf-8?B?ZU1yK0dPdUhGNXRYSXlwVy84elhFVFNORGR4YkNRRjU3MUR0TGEwWFlYTVhS?=
 =?utf-8?B?V1VmL0VyTGVNNmMvWEptazdPV3k3U1FCek8zWnJwQzRsQXJZaWlpS2V1VHNM?=
 =?utf-8?B?RHFTcFJUb0FVbUdPZW5rRXF1bERFeTY2VlRNc3pxMHN6a1N3cmJoOGJpWkht?=
 =?utf-8?B?T2g1WVkxeTA5ZElFQVgxZUlDTTdPSC94OGVxRFV0NWdVVjVJMXFXb3lPWjhF?=
 =?utf-8?B?YmF2QnNQOFRMYktxMmN3UjE3WkRlOEhUTU45UFRjZmhyNWxHVDlOcmNNYTdD?=
 =?utf-8?B?NUNwTTdOdDc5Snl0Q2J0dEVqUTNiSjE2L2g0RFk3aEZiNlRISEVjMXdOWTVu?=
 =?utf-8?B?ZzJ5Zm9tdzdXSW4xL28xUjY0N0crOUFEMitHWmhuWGsrV1dtUUlkOVNRb3NT?=
 =?utf-8?B?My84NGFnbytPM0tSY3dKRUI5ajhBamVyazFRaUMzOXU3SHh4bjU5cThKOFN4?=
 =?utf-8?B?WVZFekRJT05TdzhUVnMwMlF6U0ZWV0VXRU9XclF5Sml4RWQ0bzRndmMzWXJl?=
 =?utf-8?B?d2NmVDRHYUFYMDNoTUQzQ01McE1aRHpRUW10ZTFObHlYcjlkOWF3dEF0azZk?=
 =?utf-8?B?aXFkU1I0R0V4V2s0SnBQMlpEZElqdXR1bnlzdllkV3YyQzg1ZVMxQVJLYzUx?=
 =?utf-8?B?ZzJ4anFmaHdtY3FzS2RLMmRMRGpOQlpXYmppUlhtQ014UFZQbzNJSUw0TVY3?=
 =?utf-8?B?WWE1cjNqU2hFd3NTZUQvOFFEYXN5WEI5N1UwQUVFOXFYNk1wdW82RXJJOUs5?=
 =?utf-8?B?M2dvVVpZTE1SbnhzYTlJL0NqK0NpTGJxN2FoVnQxdDU2b1NQUXJsbnZ4RFRE?=
 =?utf-8?B?OWxldmdRTm9JVlV3NFFiUEwxblFQaVNGK1VHUjl5Yk4rUWoxbXBUczZwTWdO?=
 =?utf-8?B?NnEvRmVLbUVvbE5kTDY1ekp2UEhadXpSMWU3OXFjOGN6aGpWcEpRUU8zMkJ1?=
 =?utf-8?B?RzRyb1U1KytoQzZjYU92eWM2QmF1d1RuZ1EzcmNEczAzWndVd3BwcHdLM21J?=
 =?utf-8?B?eWdreUV3UlBia0xhbW5FZCtpZVFhSXp0SXRjV21weXdkZXZqeVN6QlIxUTRK?=
 =?utf-8?B?NHErR2pPTFV6Qk8wb05ub2VoM2N6SDdsVzNnTHJGb0I0TldkM0NxNUU2WFZ2?=
 =?utf-8?B?ZU42SFM0R1dKbEZQRmRSZ3Y4Skp6bEw5TUNSbEtEL0FOVEt4ZjhWZ290Wk5I?=
 =?utf-8?B?WG00cGozdlRHcWkwOGNJSDdMMHpyRkMzLzZibXU4cEVwTmE1SWlhcndYV2cx?=
 =?utf-8?B?WHY1cVUrZ3lnazNMdTAxcndyd0k5UWFUVVVXZWF2WHp5RGNoSVhiS0loMzRW?=
 =?utf-8?B?MzhzT1VPTkg0bjJ2aXdxNzNBOG15dVZxWG5SNDVaVDQwUTd6TmR4em01cC9V?=
 =?utf-8?B?ZzlRbzcyNEhBakNrSmNCd2lzWGlESk9YRGh6bk9oelBBYzVyNWNZK0xRR1ZE?=
 =?utf-8?B?MTZ1VU9EMFpUT0tIcThKeDhKbWs4b0xGTldxRE5wN0Z1VnFxYjJUTVlLQVlD?=
 =?utf-8?Q?QQF/AFMCpbw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-50200.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9P191MB1665.EURP191.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 936bfef1-1f42-4ca2-3b4a-08da2470a316
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2022 14:59:01.7270
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9P191MB1997
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

SSB3aWxsIHRyeSB0byBtYWtlIGFsbCB0aGUgcmVxdWVzdGVkIHRyYWNlcywgTkZTMywgTkZTNC4x
IGFuZCBpZiBhIFZNIGlzIG9rYXkgSSB3aWxsIGFsc28gc2V0IHVwIGEgRnJlZUJTRCBORlMgc2Vy
dmVyLgpOb3Qgc3VyZSBpZiBJIGNhbiBkbyBpdCBvbiB3ZWVrZW5kLCBidXQgTW9uZGF5IHNob3Vs
ZCB3b3JrLgoKSSBjYW4gbm90IHRvIDEwMCUgc2F5IHRoYXQgdGhlcmUgYXJlIG5vIHN1Y2ggZXJy
b3JzIG9uIEZyZWVCU0QsIGFzIEkgZG9uJ3QgaGF2ZSB0aGUgb2xkIHNlcnZlcnMgcnVubmluZyBh
bnltb3JlLCBidXQgSSBoYWQgdGhpcyBydW5uaW5nIG5vdyBmb3IgeWVhcnMgYW5kIGRpZCBub3Qg
c2VlIGFueSBpc3N1ZXMgKGJlc2lkZSB0aGUgdXN1YWwgRVNYaS9icm93c2VyIG9uZXMpIHdoZW4g
aW1wb3J0aW5nL2V4cG9ydGluZyBWTXMuCgpJdCBpcyBhbHNvIG5vdCBFU1hpIDcuMiBzcGVjaWZp
YywgYXMgSSByZWNlaXZlIHNpbWlsYXIgZXJyb3Igb24gRVNYaSA2LjcuCgpXaGF0IEkgZm9yZ290
IHRvIG1lbnRpb24gaXMgdGhhdCBpdCBzb21ldGltZXMsIHdvcmtlZCwsIG1heWJlIDEgb3V0IG9m
IDMwIHRyeSdzLiBidXQgbm8gY2x1ZSB3aGF0IGlzIGRpZmZlcmVudCBhbmQgd2h5LsKgCkkgd2ls
bCB0cnkgdG8gdHJhY2UgYWxzbyBvbmUgb2YgdGhpcyBjYXNlcy4KCkkgYW0gYWZyYWlkIHRoYXQg
Vk13YXJlIHdpbGwgbm90IHN1cHBvcnQgaGVyZS4gVGhleSBzaW1wbHkgdGVsbCB0aGF0IGEgTGlu
dXggU2VydmVyIGlzIG5vdCBzdXBwb3J0ZWQuIPCfmYEKSWYgSSBjb3VsZCBJIHdvdWxkIGFib2Rl
IEVTWGksIGJ1dCBJIGFtIHNvbWVob3cgZm9yY2VkIHRvIGFsc28gdXNlIGl0IGJlc2lkZSBvdGhl
ciBoeXBlcnZpc29ycy4KCkkgdGhvdWdodCBORlM0LjEgc2hvdWxkIGJlIE5GUzQuMSwgaW5kZXBl
bmRlbnQgb2YgdGhlIHZlbmRvci4gCk9uIHRoZSBvdGhlciBoYW5kIHRoaXMgc2V0dXAgdXNpbmcg
TkZTIHNlcnZlciBhcyBkYXRhc3RvcmUgaXMgcmVhbGx5IGdyZWF0LiBORlMzLCB3b3JrcyBhbHNv
IHdpdGhvdXQgYW55IGlzc3VlcywgYnV0IE5GUzQuMSBzZXNzaW9uIHRydW5raW5nIG1ha2VzIHRo
aXMgYWxzbyB1c2VhYmxlIG9uIGhvc3RzIGNvbm5lY3RlZCB3aXRoIHNldmVyYWwgMUcgTklDcy4K
CkJlc3QgcmVnYXJkcywKQW5kcmVhcwoKVm9uOiBDaHVjayBMZXZlciBJSUkgPGNodWNrLmxldmVy
QG9yYWNsZS5jb20+Ckdlc2VuZGV0OiBGcmVpdGFnLCAyMi4gQXByaWwgMjAyMiAxNjoyOQpBbjog
UmljayBNYWNrbGVtIDxybWFja2xlbUB1b2d1ZWxwaC5jYT4KQ2M6IEJydWNlIEZpZWxkcyA8YmZp
ZWxkc0BmaWVsZHNlcy5vcmc+OyBjcmlzcHlkdWNrQG91dGxvb2suYXQgPGNyaXNweWR1Y2tAb3V0
bG9vay5hdD47IExpbnV4IE5GUyBNYWlsaW5nIExpc3QgPGxpbnV4LW5mc0B2Z2VyLmtlcm5lbC5v
cmc+CkJldHJlZmY6IFJlOiBQcm9ibGVtcyB3aXRoIE5GUzQuMSBvbiBFU1hpIArCoAoKCj4gT24g
QXByIDIxLCAyMDIyLCBhdCA3OjUyIFBNLCBSaWNrIE1hY2tsZW0gPHJtYWNrbGVtQHVvZ3VlbHBo
LmNhPiB3cm90ZToKPiAKPiBKLiBCcnVjZSBGaWVsZHMgPGJmaWVsZHNAZmllbGRzZXMub3JnPiB3
cm90ZToKPiBbc3R1ZmYgc25pcHBlZF0KPj4gT24gVGh1LCBBcHIgMjEsIDIwMjIgYXQgMTI6NDA6
NDlQTSAtMDQwMCwgYmZpZWxkcyB3cm90ZToKPj4+IAo+Pj4gCj4+PiBTdGFsZSBmaWxlaGFuZGxl
cyBhcmVuJ3Qgbm9ybWFsLCBhbmQgc3VnZ2VzdCBzb21lIGJ1ZyBvcgo+Pj4gbWlzY29uZmlndXJh
dGlvbiBvbiB0aGUgc2VydmVyIHNpZGUsIGVpdGhlciBpbiBORlMgb3IgdGhlIGV4cG9ydGVkCj4+
PiBmaWxlc3lzdGVtLgo+PiAKPj4gQWN0dWFsbHksIEkgc2hvdWxkIHRha2UgdGhhdCBiYWNrOiBp
ZiBvbmUgY2xpZW50IHJlbW92ZXMgZmlsZXMgd2hpbGUgYQo+PiBzZWNvbmQgY2xpZW50IGlzIHVz
aW5nIHRoZW0sIGl0J2QgYmUgbm9ybWFsIGZvciBhcHBsaWNhdGlvbnMgb24gdGhhdAo+PiBzZWNv
bmQgY2xpZW50IHRvIHNlZSBFU1RBTEUuCj4gSSB0b29rIGEgbG9vayBhdCBjcmlzcHlkdWNrJ3Mg
cGFja2V0IHRyYWNlIGFuZCBoZXJlJ3Mgd2hhdCBJIHNhdzoKPiBQYWNrZXQjCj4gNDggTG9va3Vw
IG9mIHRlc3Qtb3ZmLnZteAo+IDQ5IE5GU19PSyBGSCBpcyAweDdjOWNlMTRiICh0aGUgaGFzaCkK
PiAuLi4KPiA1MSBPcGVuIENsYWltX0ZIIGZvIDB4N2M5Y2UxNGIKPiA1MiBORlNfT0sgT3BlbiBT
dGF0ZWlkIDB4MzViZQo+IC4uLgo+IDEzOCBSZW5hbWUgdGVzdC1vdmYudm14fiB0byB0ZXN0LW92
Zi52bXgKPiAxMzkgTkZTX09LCj4gLi4uCj4gMTQxIENsb3NlIHdpdGggUHV0RkggMHg3YzljZTE0
Ygo+IDE0MiBORlM0RVJSX1NUQUxFIGZvciB0aGUgUHV0RkgKPiAKPiBTbywgaXQgc2VlbXMgdGhh
dCB0aGUgUmVuYW1lIHdpbGwgZGVsZXRlIHRoZSBmaWxlIChuYW1lcyBhbm90aGVyIGZpbGUgdG8g
dGhlCj4gc2FtZSBuYW1lICJ0ZXN0LW92Zi52bXgiLsKgIFRoZW4gdGhlIHN1YnNlcXVlbnQgQ2xv
c2UncyBQdXRGSCBmYWlscywKPiBiZWNhdXNlIHRoZSBmaWxlIGZvciB0aGUgRkggaGFzIGJlZW4g
ZGVsZXRlZC4KClNvLCBSaWNrLCBBbmRyZWFzOiBkb2VzIHRoaXMgc2VxdWVuY2Ugb2Ygb3BlcmF0
aW9ucyB3b3JrIHdpdGhvdXQKZXJyb3IgYWdhaW5zdCBhIEZyZWVCU0QgTkZTIHNlcnZlcj8KCgot
LQpDaHVjayBMZXZlcgoKCgpJ
