Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBD345B62D5
	for <lists+linux-nfs@lfdr.de>; Mon, 12 Sep 2022 23:35:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbiILVe6 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 12 Sep 2022 17:34:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229838AbiILVe4 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 12 Sep 2022 17:34:56 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2104.outbound.protection.outlook.com [40.107.244.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3531101DC;
        Mon, 12 Sep 2022 14:34:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DQmGA7Z51RjKmM5aWe4pDO3cJ0t9F8Qgq21JwG/7POg26QhtlooM6B/pvjyoDVBbWS73JU5iEEqIQcsaE/y5zPf2XqiUP7VTVoQgsDsAj5p3hFnaFCB09FmARm+S/Ym/o+3h7Icsb+QIJFeNlqsYwBgCNzhmykLpxgaBGzSZFXPUnAqB1E7+YF68Mc7CHWoKj2F51gNu+4vl0KBoecmXNXkAAPGDtAKh2eBFmkOJ5tFNAX0QAkQpRVMRv4DMfdr5S8vsH0gGfBC8JJXHi6ZxhFnSuZMguTlQw8Xjl6gWQiq9Xe5VS6l5cE/Ztm9bWLsBJgoTRPMew3uvHGPJWDJjCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ff4xmca5EIQkB33d1mxUBJeAeH4lmt4G8MD5GksQz8g=;
 b=f2pqFsbG9E3Y3H/rfb4N1BDypE6jnC7MKhamW8mavE/RM0sFtObYP+NguiHUoInYLODQdI6DTOYkJ54mWKaaQLDf6086RrrdMoe1bQ4A6LdwufIpKlIow9ZQGCA9HAOZ8wv34vLivqCYCeN54/ArcebaUlz5HPnR6IXf6Dglan5BYzbmgZD4xxM+FgRpGy6zTCE9NYmULQbi2agkNL118UyttiF+dHuOtFwXetfQJWwq/HlzoV7tCTPlbg2ZhIWKVE9zN3B4x03ywxDRGmpc52HxFdfY6lGQ1V4tt42oisjxpV//DTt/Fq7K+CdnujKrnkmILbAXF7DxoKuh17Hg2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ff4xmca5EIQkB33d1mxUBJeAeH4lmt4G8MD5GksQz8g=;
 b=d44nHp5qbut0lkUqiNwDsyKlqVlsM0sXMyfafIWVUUtvXHlfRx9M9hwwRiJEg5cohl+azsfQGAIDz5rCLuFeo5uIdUrJDfgCoxC6ji5N5dfvxipTxVYwTEP4L6pO3rWDYdTznOC81luilRwxihFC0eP0icvE32EqHqn7quFeAAM=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by CO3PR13MB5669.namprd13.prod.outlook.com (2603:10b6:303:17f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.11; Mon, 12 Sep
 2022 21:34:52 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::f1c7:62d0:a63d:f5ca]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::f1c7:62d0:a63d:f5ca%3]) with mapi id 15.20.5632.012; Mon, 12 Sep 2022
 21:34:51 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] Please pull NFS client bugfixes
Thread-Topic: [GIT PULL] Please pull NFS client bugfixes
Thread-Index: AQHYxu99v4HLErvl0UaeGOpVItxbaQ==
Date:   Mon, 12 Sep 2022 21:34:51 +0000
Message-ID: <d483818d4a936584fb0603cd2c6d4fb0b0937a38.camel@hammerspace.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|CO3PR13MB5669:EE_
x-ms-office365-filtering-correlation-id: 6bec409e-134d-4c02-c044-08da9506a053
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: k6eYq3F0U646rANBBjluRHSnh+4l7iLz4D3vLqVLVpexvW6sWZN/Wp7rxzx5Q+legrtspj3sIIy0fkSI84WxWmDctxOls4EX+OD4lrwsR2Zz83ssCGvpOD0iZ1xazmla5VNib5x6tYPVc49bxJNI3uu6Gi5fOssS/pMNH+FqAOV+DIQ6/6dFPWQHjfQNQgM1PGmDqxXvKAdBePa9yDXruoulmLksjUQBNunpxgAPik5MIgqebIgurW0M5LFbeV32bNGZJGTBxyfSTPw0oNh0dRLK9VZ7RPvdC20dO92z1Q6twnvlYT+yy42M+kI46Yb8Unoxv647et22FaU1K21cdJ+wSMm66o4iC58Nk+dMMmtTN6oSAJl9GfNWfHHM4oLeD/q5C8HqPe6N6RR+RXy6gaOSBljq5A/QYfcTjIQQbAZV8R5p3MbEU2f0lvO7X+Ba0xc9tdWMp6Ri/DLpeRDbKF86hfNs8awwCUgrdciE1CYikyKg2L49aPQ+pMaRvUipBc4d8SDjGvpKml9/iVKRWV3vlny2z2v8Uh4oGyCX9oiJLPk0KTEXDfAvizqBR653TorESRNrYJ8TrBCXuHAoYUsIDC2BwkpDwB/NGvDJuF5NMPyWGIStlRJqO0jrlIsL/WPl1iSJiW7X5CL6jAdF7tM0ah2dPTq+cS7qm4hwrh1P0Y/VRJyh+u3K/+rNHLCphDjeE71cbmuaDWascGmfC50zaY0XGvgN39uCVYzbL159P+0+i8XJfsQ/mhKpkW8S8ScpiQDLvL9HlVEKpENPnw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(376002)(346002)(396003)(366004)(39840400004)(451199015)(186003)(122000001)(36756003)(478600001)(66556008)(66476007)(66446008)(38100700002)(26005)(38070700005)(6512007)(5660300002)(2616005)(316002)(4326008)(66946007)(86362001)(6486002)(64756008)(76116006)(8676002)(71200400001)(83380400001)(6506007)(2906002)(8936002)(41300700001)(6916009)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aUZLNW1GNWdxZWxReTlqZ21iS1pXaEtLcjhSY1E3aVk4UXc4eE1YaVUrM0FF?=
 =?utf-8?B?VWRIOFZQT2hic0xzVFlDZDZ4OVlJWXp4V2hIWXhFU0hUcWZYQkJXaHRNdldP?=
 =?utf-8?B?Z3hKaFVCbGszMzZpejdDL0MySzFYcnNPSDhxbmVrdnZGYjlVeVNtdHdZTDlw?=
 =?utf-8?B?dndwR0p1dFYzM1dPVkkvenhOWXNpV2Z1K0taakttRDJPZ2hFTmorUEt1TWFm?=
 =?utf-8?B?MGNBT2pzRHJWUForYlorVlliM1ZLVmdEQzI1aUR3aElocm85RHdpeXVPNnFi?=
 =?utf-8?B?a0ZWS0M3eXRRa1BsMVJUMlJZNlM4NXVQQ0VKVDF1OHkxbHR4U0pkUWw3b1lp?=
 =?utf-8?B?TksvMVBoOGVLQUtJbVZIYi9JSEIxODk1WGFSbGhmTGY0aGc3VFg0V3gzS25l?=
 =?utf-8?B?RHdmSVE0QVNqd0FieUtHSTA1UHQyempld2FhdzVoOS9YdklscndHZzVNN0R5?=
 =?utf-8?B?bDBIK21rY2NsaGlwOTU4NkVVMnlyTWh0NGtaVTA3eHozOXpmQ1hYZmZRdkJi?=
 =?utf-8?B?ZjVFb0FLNDZUVmdsRlRWU2lDYXRKR0xLb05ZWGZpM2hzdzBIYWtRdGdma3FX?=
 =?utf-8?B?TG9nZEt5MGhMaE9jbjRkbWtqcHFpVkpscUsyVVRuOVh6RW90NDZVb3plTG9B?=
 =?utf-8?B?QVpab3l4cFlmcWJoT3VMZEluYm4vY2VKdmdlMUJkMjdOcjFQVXQ4bWpuVHBN?=
 =?utf-8?B?SFNlWjhwdi8rOWYwamJsUTlXMG5pTmRYWGV5RWYwZUx5cGlHTE1YN2hNd1J4?=
 =?utf-8?B?aHgzZUVYM2pySHdxV2JxUE5yWGpySE1yYis4SWhUbGsxNXNkT3duNnJPYVor?=
 =?utf-8?B?SFdyelJZenVTd0lRN25tTTBKaEEzMXVTSFQvZ0hUdmpkNTgxb3BnQUJ0QVdl?=
 =?utf-8?B?T0VuWDlsZ1RoeTI3Yy9JbnBGazg0K2hHeFdOQmo5TWFDaVdkdXR5NUZ3WFBF?=
 =?utf-8?B?Rm9yZFpqTlNqZTBtVWRacWo4NmRJMFZDSnBlYjNtdFMreXFZS0tSK2xBUHI5?=
 =?utf-8?B?M2kwd0UzajdtL2tDUzdqUnE2aFNCeDNpZ2g2V0hWQi90elY0RDRabmhlSVdY?=
 =?utf-8?B?YjF2anNHeEljUEtCRk1nM2tPSGdLZVI2ZWpEZDd1U2ZPbXNrUVFsZWVGYTZK?=
 =?utf-8?B?YVMzdUdVZmlyalZndThsMXQyYlV1WktSMmVGb1pNaDJSR2hMRWtzckRZQ1A3?=
 =?utf-8?B?S1pvSFNrWGl2dU14UmNDd1VoL3R3UDVyZlZUM04zVEVtdTR6QnM1Vm5nM0FH?=
 =?utf-8?B?UlFKMFhOWGVLR2w5NmtwTm92TnJhdUVKazJ1ZFF1c1FQdzlwNy9IZGw1NXNC?=
 =?utf-8?B?MDdCTEJOVGVOTGloYzJtdW90TmtYekcrakw0ZnBnMXNwbkY3M3duNHhVTzQw?=
 =?utf-8?B?enNEVE9Kdk9vaitBeEEyK1BlQ0FLYmxLOHR5d0hPWGJCWEE5SjRPQXo0N1Y5?=
 =?utf-8?B?djNtRVRYMGdxSm9kTEV6QjEwQzc3N3VTZ1h1U3BjN3hIV3FFYXlySjl0QVRq?=
 =?utf-8?B?RUtmYXdobm5sN3ljUUprL0h0c2JXdzI0YWtpWWhRZlg5aEp5cXZMaXkrV1No?=
 =?utf-8?B?V09QUmRHbzZ0WTZFd2NHZnpwT0RhQnBWS1BJYUs2Q2l0cUc5R2VBYkhqWWFi?=
 =?utf-8?B?bnAwTW5ESHcvcGgza2Q2TGpzMkJjL2psVnFaTUh5bWRZU3hOclNSck5MWEdo?=
 =?utf-8?B?TFFrTGlmTkpwSHVFT1VmOGtlNUJUVDBsSmpva1hhbTVsaS8ycmJxbzlKdzRp?=
 =?utf-8?B?SmhnSlRRNmcrTmFLTHljcDg5Vy9ndStoYmh1TlF3UzErNW5vU1dxU1RrajJu?=
 =?utf-8?B?ZHJDaXQ2VHlVMnVsUC90Vm1wMnM5bkU4Qnp6bEorQ1dGajZ4V0dkYnAwdFp4?=
 =?utf-8?B?TXorOVBGbHE0ODhVa2o1UzFhZzRiSzBFaG9pUWVPS21DRjV6NGxFNkU5QVA4?=
 =?utf-8?B?TzFWVlhTWXZPQTJkUjVTQVk5bTVxSllReDR1TFRvS3VWelpvV084US9GN3Fj?=
 =?utf-8?B?TjZaVm1HM2kzclo2Ti9NcmJwWTllMDNWdDFoeWpRSUpUcWlPZW1JckNYOUpH?=
 =?utf-8?B?ZnBlZnc2QVBxZ0lRLzdSeWJzVzQ4WWM5UVpyUCtmK1lHTlFiNWpQWGFjZlFB?=
 =?utf-8?B?ak5zUnQ2U2xHRklaWTFqQy9QK2tGTGlycFdjK3huRkhxNWVVODBnRjMwREU3?=
 =?utf-8?B?YUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <323D82F0DE710D4FB52CE16976E66D59@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO3PR13MB5669
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

SGkgTGludXMsDQoNClRoZSBmb2xsb3dpbmcgY2hhbmdlcyBzaW5jZSBjb21taXQgZWQwNmZjZTBi
MDM0YjJlMjViZDkzNDMwZjVjNGNiYjI4MDM2Y2MxYToNCg0KICBTVU5SUEM6IFJQQyBsZXZlbCBl
cnJvcnMgc2hvdWxkIHNldCB0YXNrLT50a19ycGNfc3RhdHVzICgyMDIyLTA4LTE5IDIwOjMyOjA1
IC0wNDAwKQ0KDQphcmUgYXZhaWxhYmxlIGluIHRoZSBHaXQgcmVwb3NpdG9yeSBhdDoNCg0KICBn
aXQ6Ly9naXQubGludXgtbmZzLm9yZy9wcm9qZWN0cy90cm9uZG15L2xpbnV4LW5mcy5naXQgdGFn
cy9uZnMtZm9yLTUuMjAtMw0KDQpmb3IgeW91IHRvIGZldGNoIGNoYW5nZXMgdXAgdG8gMTNiZDkw
MTQxODA0MjVmNWEzNWVhZjM3MzU5NzFkNTgyYzI5OTI5MjoNCg0KICBSZXZlcnQgIlNVTlJQQzog
UmVtb3ZlIHVucmVhY2hhYmxlIGVycm9yIGNvbmRpdGlvbiIgKDIwMjItMDktMDggMTE6MTE6MjMg
LTA0MDApDQoNCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0NCk5GUyBjbGllbnQgYnVnZml4ZXMgZm9yIExpbnV4IDYuMA0KDQpI
aWdobGlnaHRzIGluY2x1ZGU6DQoNCkJ1Z2ZpeGVzDQotIEZpeCBTVU5SUEMgY2FsbCBjb21wbGV0
aW9uIHJhY2VzIHdpdGggY2FsbF9kZWNvZGUoKSB0aGF0IHRyaWdnZXIgYQ0KICBXQVJOX09OKCkN
Ci0gTkZTdjQuMCBjYW5ub3Qgc3VwcG9ydCBvcGVuLWJ5LWZpbGVoYW5kbGUgYW5kIE5GUyByZS1l
eHBvcnQNCi0gUmV2ZXJ0ICJTVU5SUEM6IFJlbW92ZSB1bnJlYWNoYWJsZSBlcnJvciBjb25kaXRp
b24iIHRvIGFsbG93IGhhbmRsaW5nDQogIG9mIGVycm9yIGNvbmRpdGlvbnMNCi0gVXBkYXRlIHN1
aWQvc2dpZCBtb2RlIGJpdHMgYWZ0ZXIgQUxMT0NBVEUgYW5kIERFQUxMT0NBVEUNCg0KLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LQ0KQW5uYSBTY2h1bWFrZXIgKDEpOg0KICAgICAgTkZTdjQuMjogVXBkYXRlIG1vZGUgYml0cyBh
ZnRlciBBTExPQ0FURSBhbmQgREVBTExPQ0FURQ0KDQpEYW4gQWxvbmkgKDEpOg0KICAgICAgUmV2
ZXJ0ICJTVU5SUEM6IFJlbW92ZSB1bnJlYWNoYWJsZSBlcnJvciBjb25kaXRpb24iDQoNClRyb25k
IE15a2xlYnVzdCAoMik6DQogICAgICBTVU5SUEM6IEZpeCBjYWxsIGNvbXBsZXRpb24gcmFjZXMg
d2l0aCBjYWxsX2RlY29kZSgpDQogICAgICBORlN2NDogVHVybiBvZmYgb3Blbi1ieS1maWxlaGFu
ZGxlIGFuZCBORlMgcmUtZXhwb3J0IGZvciBORlN2NC4wDQoNCiBmcy9uZnMvaW50ZXJuYWwuaCAg
fCAyNSArKysrKysrKysrKysrKysrKysrKysrKysrDQogZnMvbmZzL25mczQycHJvYy5jIHwgIDkg
KysrKysrKy0tDQogZnMvbmZzL3N1cGVyLmMgICAgIHwgMjcgKysrKysrKysrKysrKysrKysrLS0t
LS0tLS0tDQogZnMvbmZzL3dyaXRlLmMgICAgIHwgMjUgLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LQ0KIG5ldC9zdW5ycGMvY2xudC5jICB8ICAzICsrKw0KIG5ldC9zdW5ycGMveHBydC5jICB8ICA4
ICsrKystLS0tDQogNiBmaWxlcyBjaGFuZ2VkLCA1NyBpbnNlcnRpb25zKCspLCA0MCBkZWxldGlv
bnMoLSkNCg0KLS0gDQpUcm9uZCBNeWtsZWJ1c3QNCkxpbnV4IE5GUyBjbGllbnQgbWFpbnRhaW5l
ciwgSGFtbWVyc3BhY2UNCnRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20NCg0KDQo=
