Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DF9C7E5F17
	for <lists+linux-nfs@lfdr.de>; Wed,  8 Nov 2023 21:23:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229551AbjKHUXZ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 8 Nov 2023 15:23:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjKHUXY (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 8 Nov 2023 15:23:24 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2091.outbound.protection.outlook.com [40.107.237.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AF22213B;
        Wed,  8 Nov 2023 12:23:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=biQFNoOS5JEwVsIJlwchmitVaRCJsHPXikD1ndLcxLS6jQahgp4weoYGp3jgVfLgbVUkyBS4OefNkZvscDe8S9eLUHMUp0EEtSHhmHhM0CnVb+xfOfpa2dzkeh+Z6gBNlfH3GrIwe7LbUOwJSC5Vtaxrc9KwagogbXtLdw5hVRqJnBIKx1H397lq60x5ocibN8ceI0g/aeDmIbd07AE9KS3L8zO8+2XdqafIc48wo6RtQGBT5Vd0sZiujBmQljzHXr7NTM2xIMMPBQ6KAW+RHbPd0y9i2GP764KnYoxy2RXsqmNWOm8LiqZ2OUQzqOrWgFo/nwLYJ12IeDyij3iw8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y+uJYQFYv6ngmRkqHH2FlVKSinl9KohhiS71MnKOF6I=;
 b=XMIbM5LCPc6eH7PRrpJCgQNcqyeKu16JW4yz/Yt5xGi85l+8h+3M7CP/wPfVFw9HYJ/PCndomfouSy88VwiXNpjAQ4Br0n0JdR9gnXQ32RRL+O5NGgGgVrU1XNNKRGp0ldASsRtygvphcNeJgDUIhpEyChwZkUL/mqZIrYeetUF3bQ5fqS00HN8ePAbdZrsQVRU0DyC5pQY9OnhlOFrOnY4IE/gedenHynQmoI7P/Ft1LxifAYN7+KZQ3yE+5MYHyjK09ZOYrCp4VOv270B2q0Tp13JufmXWy+8FC5NEvC9j/LQVcVWNd1nvVe8X0vpvaSJeDzcasCvaQOe0hhCLKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y+uJYQFYv6ngmRkqHH2FlVKSinl9KohhiS71MnKOF6I=;
 b=IWbSoPV29fFz+Y/DFeEqY4EVw6wfUl568ACIA1wwaDJ/46BsDrVWhslgK98PC37wF3w8mTdDKZx27FOjwwOpqshgxUPHD6kl8usAjvB6c6//1U+PKsSsmhTdF6OSKqxOpruvvNUmlwO8q3pVzdP3HDM32MRqwZmx+Q9hhdC0eTw=
Received: from DM8PR13MB5079.namprd13.prod.outlook.com (2603:10b6:8:22::9) by
 MW3PR13MB4155.namprd13.prod.outlook.com (2603:10b6:303:55::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6977.18; Wed, 8 Nov 2023 20:23:19 +0000
Received: from DM8PR13MB5079.namprd13.prod.outlook.com
 ([fe80::50ca:9941:2396:90f0]) by DM8PR13MB5079.namprd13.prod.outlook.com
 ([fe80::50ca:9941:2396:90f0%5]) with mapi id 15.20.6954.029; Wed, 8 Nov 2023
 20:23:18 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] Please pull NFS client updates for Linux 6.7
Thread-Topic: [GIT PULL] Please pull NFS client updates for Linux 6.7
Thread-Index: AQHaEoFpyS/snDsZsE26fh9RUP8jmw==
Date:   Wed, 8 Nov 2023 20:23:18 +0000
Message-ID: <0c5dc383d262d49f842a76893b1efc2545cfe9ce.camel@hammerspace.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR13MB5079:EE_|MW3PR13MB4155:EE_
x-ms-office365-filtering-correlation-id: fed9bf53-6492-4493-7dbb-08dbe0988bcf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QLNukj0se1rmvfa88hbcUpxLzYMAwT6vuf03Qf4tHjQwSI5tnSdf+QJhL9xSrg2Yco0KEfqNjecROsBp3o95HP0KkV4hciJa4lc3CHe8pyU+FH9b6kEmUMlAIQxS+1fi3miB2OVRBeauWfohUqPTc2OkPDQymWKFno4Ctnm4v1luf/GNjinay7IOZTqXS8Uu1ezSoThEXqK5bVeqBiOQZYUqYROKkOTOvFeMoB5y+7YNf4f3FKzAWGhk05cxKUONMe3zU/osN5/3mCN//jCqEgtRQQNfjPpM7JNFiWmlk5G+XDNdstwJihBi02w4XAJAMyGjMApy9g56lyqKcH8yImRPQpmDTUMegXGWFV3bD+0ia24JmSqzUcRj3KwdS7BIfFUQyaYoREFXaHo6ubIqjBtan71EZuOGHp/yatJ/DMza/AjtueJMQAs/B5M+OV/a4YmbTlXPxUjz+VLkB/eP+P7if/UBbTyFa1psHNzVYfzWnRcJSZswGxM0EA2Ku5unMNvzbSjO+Q707M8LcQvqyD1z/6ePStCfuPbU4QFqElJonl/9mqgaxRxlXFNVqqc33O0VF6ZsCIUnMrBytuXPaD+6oH0h1OyBKzMOphkhsEzcGI5WJ1ZSP5KyvsmfYFqUzRkwbuIXz47IRzEuy89zQ5bV0Szx4MqPUQGmWaTKFBU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR13MB5079.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(376002)(39840400004)(396003)(346002)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(2906002)(15650500001)(41300700001)(4001150100001)(8676002)(8936002)(4326008)(5660300002)(66556008)(6916009)(316002)(54906003)(64756008)(66476007)(66446008)(66946007)(76116006)(38070700009)(91956017)(6486002)(26005)(478600001)(38100700002)(6512007)(71200400001)(36756003)(2616005)(6506007)(122000001)(83380400001)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VHNTYnRVNDg2MVJCUjVTcGs5eERUV25sTXlQNHdKSm43Mk43ZnFQUEttOGJD?=
 =?utf-8?B?S2h3Um95aDkxdnNEbUorRjZlaWhwNnU5bTNuemI5a2ozQkFXWGxFNGFkQkhV?=
 =?utf-8?B?NVNKbnMyZERWZ3l0WmhDMGtDUFdGbVpoczBGTVlGalBzT1hTTEdwSmNrVjNU?=
 =?utf-8?B?SHZDeXlqRmxBMHFSeDMvcWlzWmU3ZkxTTkVlWlZCWnlVaXI2bTJ1MnBsd01P?=
 =?utf-8?B?K3lYTytwVW9CNzFsV21QcXpTbWV4UnpNVTNORmdyRnRuTlkwcWpKcUp4OU9w?=
 =?utf-8?B?TXg5NENwMmxZRWlLZXRPVm5OVjVGWFZVaGxFMTNwK1Q3K081c2JVTFFmbEdm?=
 =?utf-8?B?bU9zdUdUK1hrQjdqRzNtdTBQckpFdUhVOEVrM1VLbFlQNVlIQ1dndElZYVhm?=
 =?utf-8?B?VWJSdkc4RmhIeUhoamU1b0l2c0t0QVV6ckprS0pKb3hGQlcrMVNTSVUrVm1i?=
 =?utf-8?B?SmxPTGVBcVo5cGhKTHNFZjJCa0Jpays3eS80UVFCZk5GQ3hYVHdNWFFlWnNP?=
 =?utf-8?B?U3VsNUNabG5vRlBTQnR3Z2RlQTBEaGNZMmRrTTg4d2hraXM5SHpnL005bGQy?=
 =?utf-8?B?RnU2TnRiVlk3R0w0VWVSaUxWdDgrMHFaZ0RLYnFnR2dqTEM1MlBDeHMvTGhN?=
 =?utf-8?B?d0RreFNqbXpmRkJIb3VLYUtwaGFqS1liZHIrNVRsdmZlWk1pUE1DRU8wS0ts?=
 =?utf-8?B?V0s0RTFIQlE5Sk1BZnRueE5iNU1IclBNYktWbE5ja01NMTJIbHAyRG8wSUsy?=
 =?utf-8?B?MTM4MG1jSUc3ZGZtYk83RzRGVzJCNXBxTlpPL3dnRVJxY2c5b1hGbG5zYWZL?=
 =?utf-8?B?TmFFTjRValNrSkF0ZVJiSWlZWVZHcmZJWlhxbGhYTnk0UDJjSDJNdkNsNHlE?=
 =?utf-8?B?UlVOdXZFc2VabVdnSytkWmZoY1Z3dmFXeHNnempnYUhQd1I4dUwrcDFQTkJH?=
 =?utf-8?B?RFdFbGJBZWoyc3pFbkVFbVpod3lvWnRZcWlwZlVVMHFlOVNnV1hKMVJPUnpO?=
 =?utf-8?B?aFZOSGtuY1VXVmZJZnlqcGJiM3lwMlVGQWRtVzZKWFJQVDQwc3ZWbVp3Yi8v?=
 =?utf-8?B?Rk51bUZaaWFxQWthR0RJZ3FYdjFNSTVDVHh1bDlNZnZSTHdobjhkTFFUMExn?=
 =?utf-8?B?MStuajJnUkNJejJOQzdPOFlmb3NBSE95a2YvTjZjdHl4NXQ5SGZ0MjROYytV?=
 =?utf-8?B?OFoxcnBSaG9aeGI1dTR3NDJXeDJmR2orblZKMWo0YjNqSjE4bytjL1NLcVho?=
 =?utf-8?B?OEZ5dzUwb0x6Z3pBSzFnaUtvSVJqelpKMlowdVdFQmEwUHdaeTFMUTZyL3RV?=
 =?utf-8?B?Z2RPSWRQTEN5Qk53WVZhbmNid2NvQ1FrT0VFb2tzL245ZmdNUGNrb3h2ZTVw?=
 =?utf-8?B?OVN5NmprbUpLSTN2NTRUdm80WnhJUzdaNDB5TXZiM3JiN0dkd3QzY2JVZDRp?=
 =?utf-8?B?L2VpS0FYamFNUWl6bEhHVUY1R3RHTlNvcTArbVkweXVvV1hHbHBnUC8xZmFW?=
 =?utf-8?B?Um9XS3NZbC9nUml0WTlKdnkycDJ2aTJFQkFhUFdNZVFJM0NaRVQvaGtmTlY1?=
 =?utf-8?B?bGEwOXNKUGUrbkU5dXNlcjZNK3dZck0xTk54N1JUZHQ5ZC9Xb1g5T25ObWg1?=
 =?utf-8?B?dmR1V2t0R2ZzMHRReWVySEdrdmRxSmhCK0NUYlN6dXd5SmJQWjZuNFFvNUFB?=
 =?utf-8?B?bWNyRXlTK2ZGdXFWUjhueEJhQ0NOUFNGQ21nUGQ1WUFTRi96TUFEbjFpUEt5?=
 =?utf-8?B?b2R6SU9SSW1jNnV2aVVLQ1RhdHVQN1p6M0lNSTJKZG5xWDV6ZHFjWGY4amVR?=
 =?utf-8?B?YS92TXdkNU14NVo1ZndwSEJqQStPWFlxR0FIUVJlZzJIaW5NL3pCNTg2MFRn?=
 =?utf-8?B?SXU4K1M0dUs5UFdaMnovdVZob1hJaHEwamRkaTBSZDM4U0ZyWk5XbjZQVkc1?=
 =?utf-8?B?Mm1zMEpxU1hxbzYzbFBrdUlzaWcvbUswOGFUQWtsUzN0YmVNa1hMSm9CMFZl?=
 =?utf-8?B?VW4vOGdMWjhWRzdYdmtNdFl6VVllczY0WGJhRWFJckx3OUpEbndaNlRrdjQr?=
 =?utf-8?B?ZFpybWpyTXY3dFQ4WTNZSFlHaHpwYW16clkwYjNjMndrVStpOTg4ODhlNE9F?=
 =?utf-8?B?MlF3WHhFQ0ltbk5qTDNycDd2ZHBmOGw4VU1VSlExVmRZV0tTZVJYTDl0djFY?=
 =?utf-8?B?a1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1B87237D574AF848A66320E5BE9A13E5@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR13MB5079.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fed9bf53-6492-4493-7dbb-08dbe0988bcf
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2023 20:23:18.7979
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: k4y4ziIWQkDf/yIZ+CO2qvH/d+iKgkB+VLfpRCnaAzFLBu48Ux+wsMm3HtPSnYA1M38k2o3lMnirGKs9KnH7mg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR13MB4155
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

SGkgTGludXMsDQoNClRoZSBmb2xsb3dpbmcgY2hhbmdlcyBzaW5jZSBjb21taXQgMDVkM2VmOGJi
YTc3YzFiNWY5OGQ5NDFkOGIyZDRhZWFiODExOGVmMToNCg0KICBMaW51eCA2LjYtcmM3ICgyMDIz
LTEwLTIyIDEyOjExOjIxIC0xMDAwKQ0KDQphcmUgYXZhaWxhYmxlIGluIHRoZSBHaXQgcmVwb3Np
dG9yeSBhdDoNCg0KICBnaXQ6Ly9naXQubGludXgtbmZzLm9yZy9wcm9qZWN0cy90cm9uZG15L2xp
bnV4LW5mcy5naXQgdGFncy9uZnMtZm9yLTYuNy0xDQoNCmZvciB5b3UgdG8gZmV0Y2ggY2hhbmdl
cyB1cCB0byBmMDAzYTcxN2FlOTA4NmIxZThhNDY2MzEyNGE5Njg2MmRmNzI4MmU3Og0KDQogIG5m
czogQ29udmVydCBuZnNfc3ltbGluaygpIHRvIHVzZSBhIGZvbGlvICgyMDIzLTExLTAxIDE1OjQw
OjQ0IC0wNDAwKQ0KDQpUaGFua3MNCiAgVHJvbmQNCg0KLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KTkZTIGNsaWVudCB1cGRh
dGVzIGZvciBMaW51eCA2LjcNCg0KSGlnaGxpZ2h0cyBpbmNsdWRlOg0KDQpCdWdmaXhlczoNCiAt
IFNVTlJQQzogQSBmaXggdG8gcmUtcHJvYmUgdGhlIHRhcmdldCBSUEMgcG9ydCBhZnRlciBhbiBF
Q09OTlJFU0VUIGVycm9yDQogLSBTVU5SUEM6IEhhbmRsZSBhbGxvY2F0aW9uIGVycm9ycyBmcm9t
IHJwY2JfY2FsbF9hc3luYygpDQogLSBTVU5SUEM6IEZpeCBhIHVzZS1hZnRlci1mcmVlIGNvbmRp
dGlvbiBpbiBycGNfcGlwZWZzDQogLSBTVU5SUEM6IGZpeCB1cCB2YXJpb3VzIGNoZWNrcyBmb3Ig
dGltZW91dHMNCiAtIE5GU3Y0LjE6IEhhbmRsZSBORlM0RVJSX0RFTEFZIGVycm9ycyBkdXJpbmcg
c2Vzc2lvbiB0cnVua2luZw0KIC0gTkZTdjQuMTogZml4IFNQNF9NQUNIX0NSRUQgcHJvdGVjdGlv
biBmb3IgcG5mcyBJTw0KIC0gTkZTdjQ6IEVuc3VyZSB0aGF0IHdlIHRlc3QgYWxsIGRlbGVnYXRp
b25zIHdoZW4gdGhlIHNlcnZlciBub3RpZmllcw0KICAgdXMgdGhhdCBpdCBtYXkgaGF2ZSByZXZv
a2VkIHNvbWUgb2YgdGhlbQ0KDQpGZWF0dXJlczoNCiAtIEFsbG93IGtuZnNkIHByb2Nlc3NlcyB0
byBicmVhayBvdXQgb2YgTkZTNEVSUl9ERUxBWSBsb29wcyB3aGVuDQogICByZS1leHBvcnRpbmcg
TkZTdjQueCBieSBzZXR0aW5nIGFwcHJvcHJpYXRlIHZhbHVlcyBmb3IgdGhlDQogICAnZGVsYXlf
cmV0cmFucycgbW9kdWxlIHBhcmFtZXRlci4NCiAtIG5mczogQ29udmVydCBuZnNfc3ltbGluaygp
IHRvIHVzZSBhIGZvbGlvDQoNCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCkJlbmphbWluIENvZGRpbmd0b24gKDEpOg0KICAg
ICAgTkZTdjQ6IGZhaXJseSB0ZXN0IGFsbCBkZWxlZ2F0aW9ucyBvbiBhIFNFUTRfIHJldm9jYXRp
b24NCg0KRGFuIENhcnBlbnRlciAoMSk6DQogICAgICBTVU5SUEM6IEFkZCBhbiBJU19FUlIoKSBj
aGVjayBiYWNrIHRvIHdoZXJlIGl0IHdhcw0KDQpNYXR0aGV3IFdpbGNveCAoT3JhY2xlKSAoMSk6
DQogICAgICBuZnM6IENvbnZlcnQgbmZzX3N5bWxpbmsoKSB0byB1c2UgYSBmb2xpbw0KDQpNa3J0
Y2h5YW4sIFRpZ3JhbiAoMSk6DQogICAgICBuZnM0MTogZHJvcCBkZXBlbmRlbmN5IGJldHdlZW4g
ZmxleGZpbGVzIGxheW91dCBkcml2ZXIgYW5kIE5GU3YzIG1vZHVsZXMNCg0KT2xnYSBLb3JuaWV2
c2thaWEgKDIpOg0KICAgICAgTkZTdjQuMTogZml4IGhhbmRsaW5nIE5GUzRFUlJfREVMQVkgd2hl
biB0ZXN0aW5nIGZvciBzZXNzaW9uIHRydW5raW5nDQogICAgICBORlN2NC4xOiBmaXggU1A0X01B
Q0hfQ1JFRCBwcm90ZWN0aW9uIGZvciBwbmZzIElPDQoNClRyb25kIE15a2xlYnVzdCAoNik6DQog
ICAgICBORlN2NDogQWRkIGEgcGFyYW1ldGVyIHRvIGxpbWl0IHRoZSBudW1iZXIgb2YgcmV0cmll
cyBhZnRlciBORlM0RVJSX0RFTEFZDQogICAgICBORlN2NC9wbmZzOiBBbGxvdyBsYXlvdXRnZXQg
dG8gcmV0dXJuIEVBR0FJTiBmb3Igc29mdGVyciBtb3VudHMNCiAgICAgIFNVTlJQQzogRUNPTk5S
RVNFVCBtaWdodCByZXF1aXJlIGEgcmViaW5kDQogICAgICBTVU5SUEM6IERvbid0IHNraXAgdGlt
ZW91dCBjaGVja3MgaW4gY2FsbF9jb25uZWN0X3N0YXR1cygpDQogICAgICBTVU5SUEM6IEZvcmNl
IGNsb3NlIHRoZSBzb2NrZXQgd2hlbiBhIGhhcmQgZXJyb3IgaXMgcmVwb3J0ZWQNCiAgICAgIFNV
TlJQQzogU09GVENPTk4gdGFza3Mgc2hvdWxkIHRpbWUgb3V0IHdoZW4gb24gdGhlIHNlbmRpbmcg
bGlzdA0KDQpmZWxpeCAoMSk6DQogICAgICBTVU5SUEM6IEZpeCBSUEMgY2xpZW50IGNsZWFuZWQg
dXAgdGhlIGZyZWVkIHBpcGVmcyBkZW50cmllcw0KDQogRG9jdW1lbnRhdGlvbi9hZG1pbi1ndWlk
ZS9rZXJuZWwtcGFyYW1ldGVycy50eHQgfCAgNyArKysNCiBmcy9uZnMvS2NvbmZpZyAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAyICstDQogZnMvbmZzL2RlbGVnYXRpb24uYyAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgNyArKy0NCiBmcy9uZnMvZGVsZWdhdGlvbi5o
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAxICsNCiBmcy9uZnMvZGlyLmMgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8IDI5ICsrKysrLS0tLS0tLQ0KIGZzL25mcy9u
ZnMzcHJvYy5jICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgIDMgKy0NCiBmcy9uZnMv
bmZzNF9mcy5oICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAyICsNCiBmcy9uZnMv
bmZzNHByb2MuYyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8IDYyICsrKysrKysrKysr
KysrKysrKystLS0tLS0NCiBmcy9uZnMvcG5mcy5jICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICB8ICA4ICsrKy0NCiBmcy9uZnMvcG5mcy5oICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICB8ICA1ICstDQogZnMvbmZzL3Byb2MuYyAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgfCAgMyArLQ0KIGZzL25mcy9zdXBlci5jICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIHwgIDggKysrLQ0KIGZzL25mcy93cml0ZS5jICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIHwgIDIgKw0KIGluY2x1ZGUvbGludXgvbmZzX2ZzX3NiLmggICAgICAg
ICAgICAgICAgICAgICAgIHwgIDEgKw0KIGluY2x1ZGUvbGludXgvbmZzX3hkci5oICAgICAgICAg
ICAgICAgICAgICAgICAgIHwgIDIgKy0NCiBpbmNsdWRlL2xpbnV4L3N1bnJwYy9jbG50LmggICAg
ICAgICAgICAgICAgICAgICB8ICAxICsNCiBuZXQvc3VucnBjL2NsbnQuYyAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICB8IDEwICsrLS0NCiBuZXQvc3VucnBjL3JwY2JfY2xudC5jICAgICAg
ICAgICAgICAgICAgICAgICAgICB8ICA0ICsrDQogbmV0L3N1bnJwYy94cHJ0LmMgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgfCAgNCArLQ0KIG5ldC9zdW5ycGMveHBydHNvY2suYyAgICAg
ICAgICAgICAgICAgICAgICAgICAgIHwgMTQgKystLS0tDQogMjAgZmlsZXMgY2hhbmdlZCwgMTIx
IGluc2VydGlvbnMoKyksIDU0IGRlbGV0aW9ucygtKQ0KDQotLSANClRyb25kIE15a2xlYnVzdA0K
TGludXggTkZTIGNsaWVudCBtYWludGFpbmVyLCBIYW1tZXJzcGFjZQ0KdHJvbmQubXlrbGVidXN0
QGhhbW1lcnNwYWNlLmNvbQ0KDQoNCg==
