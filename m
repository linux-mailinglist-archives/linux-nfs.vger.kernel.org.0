Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C137E5267F1
	for <lists+linux-nfs@lfdr.de>; Fri, 13 May 2022 19:12:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354432AbiEMRM1 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 13 May 2022 13:12:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235334AbiEMRMZ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 13 May 2022 13:12:25 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2100.outbound.protection.outlook.com [40.107.236.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2794B6CF7C;
        Fri, 13 May 2022 10:12:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mWltBR6qpCroC39BV3bdFVsVGtXDZc7bg8blWbHnd5wBh/SHuWoZQNMtyHIZEsG8F69KC4cmKpK77/X08qI2i0D81WNnFoM5rX4CjGEO7ovA6yu4JEyuggUIGJ14GgVDZAKRqbU0wRGQLOoE+tmei/5bmBRG0V7irAehqWYkSkZfKH44gtXrUWDMmxslvVxUvT3XYeLjNkdx4ijenhyHaTZQ/k/2GJdDCAJFav9KM5BvooZm0T1DPi7YbaiHQXr3dMC5ozBA6JuXNSvHAlgmOue7GbnNSB962zinvnCw57gxrleTqTYyC0dKU6Enie1ZJsL0FD758Ui0Q17lBT2FwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IkVC/R69GZHyKo4EGefTkV2K23N2Ocu5C7tiV7YeBDs=;
 b=C832pWGFGk6UoBW4rK5ZCGPb4jelmPkCnriBBz+MP05sUEE/JRg2fq/1sKHkUQYGRnNSzNkkSrsB/MzemRGHg3bQGK8X0JKJaodMOkdDQHiSPXI8yp9ZDZH+N5kCRuKTdQl8HSjI+N5bFDzTsqayEar52hfrgoSmYXcaIxe4vAplN6/TdFi11+YO9NVVmQVHEtbDbe3V+kaoGDwcgiP2MjhKQJIrpz2uxDuobzeSektVAJbCGByE0iXZGChSjNMhHtIRv5H6MDdnaXE39JZBXXCnw5tL9saqxu59UCyHkhQCjK/d4bJTJ8+TZHZ4UhsNAKB5aBnkCpjb2tNVYpd+Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IkVC/R69GZHyKo4EGefTkV2K23N2Ocu5C7tiV7YeBDs=;
 b=OuiPs0YfCLiHZhufHBcQmIJvVJLiMCV1MSliv7fIXllX13O+YwDVgjbfmGOqJp5t1ASLgh2lcXxd97NxFt5yYWN4nNkD5vUQYYRf0s0HlOE3GyIWOaQoqzI7NLeRvEIADo9ile4yaYYhJvFyAe4UCaHBmQegeMZ36wrB31SHtT8=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by BN0PR13MB5120.namprd13.prod.outlook.com (2603:10b6:408:165::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.5; Fri, 13 May
 2022 17:12:19 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::694a:6bf0:4537:f3e5]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::694a:6bf0:4537:f3e5%6]) with mapi id 15.20.5273.005; Fri, 13 May 2022
 17:12:18 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] Please pull NFS client bugfixes for 5.18
Thread-Topic: [GIT PULL] Please pull NFS client bugfixes for 5.18
Thread-Index: AQHYZuyZVhGNpyugBk6t4tWi0WytLA==
Date:   Fri, 13 May 2022 17:12:18 +0000
Message-ID: <bfd5b2161954d919909450ab9737308e6299ee11.camel@hammerspace.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a2cb69f6-a3c9-4a93-529f-08da3503bc11
x-ms-traffictypediagnostic: BN0PR13MB5120:EE_
x-microsoft-antispam-prvs: <BN0PR13MB512023A67CAD0FA85A022A20B8CA9@BN0PR13MB5120.namprd13.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Tf3m81UvP/AL0GykW4glZ4oBmqu+FDYe4Olf1gbg+Ek0ebLkB71ZNZn8aObwo4BNQUWzroFZSEha2a/7l+ylWeSyeNTCsM493ve2sAdqvjJmpemYwgjitikUZC+PFzVRa/BOAxCyZCImQPduTwn2P6k/m7apy3o7VXi2fmjLzo7G0nJzlRNuiKncluwYgEmPasQli02qSnb0IhENfafoCNXI4mohW0LYq6h+xLM4m6LOAz8AYENOGijS1EEGwiqIj8MRqeWtWyXkCPbtn9yHTJNy7yyXkOa4g+iNvrn0Pq2K686syKiATANoAyozfetZMsjtYYH7dnrpl8xuOOtheg7NZ7TLDMQr1CUBu0G8gPEBw0XIqzkk3rDqKEiGfD1Y5OVlWiCRfV3+Z7DqLUEqVBvuIMY46uo4LV/n3NfzVvtML21wo2hKI5lgklx1DrCvdOL50EH7scfa1UEmx4jeaf7899DfDTGDA+yZlKNSU3UoTcvQrQHS+BlienKsiOMoy/ic+oP2K3BKWqVqbEbHW2g9vGeYfW0RbAuyfHQOdvX3rBO0i7qTZBE9F0Z+ks7XtUkm9W9oQKiNa+je/xFWGt/fu/R0Q6yR/y2ky4bS/Kbdpevo2FqBwhYlGruKNqgq2h5Tyowsg0BbdDm3clradAHtl4bA7ETSPqrzU0/u4WxX0s7DMlsphunEqVQRQ1rbQyYOaAfCL4taOBYgEWpa9g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38070700005)(83380400001)(38100700002)(66476007)(2906002)(6486002)(508600001)(5660300002)(6916009)(8936002)(186003)(36756003)(2616005)(76116006)(26005)(64756008)(8676002)(316002)(66946007)(6512007)(66446008)(4326008)(66556008)(86362001)(71200400001)(54906003)(122000001)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ODl2STg3Und5YU5xRTBucWYwRDJFVXNodnZzL2ZIR21MZVU1UEJxUEVnY2Iw?=
 =?utf-8?B?WU9jaDZoR3plYUJCUXFiTGp3Y1VidW04RkxjSjNnQ1FrV0l1dzBjVGFsNFJl?=
 =?utf-8?B?MjAxMGZzWDZpRU1kbUZ5WGNxdDgyeUhScUowWStDcHFteUlCY1Jhd0ZjSmlF?=
 =?utf-8?B?dGZsVlFnNmo5eFF1WHlNbDN0YlFLVXVTZXZpeHdsbVpPSmVYeFBLU2Ixall0?=
 =?utf-8?B?Q3M1eWhxVkxWYXF3U0l1V2MxOVE3K1lGOGd6V29pNkFNd3VQVXUzemZyVGRq?=
 =?utf-8?B?dWlzaGZUdG9pS1lRc0MwRlpOdGhaaFJMTkwzeHVZSUE0czJwamdpaUczZm5W?=
 =?utf-8?B?RUs1NFU0SElHaDRlNkJqSHA0eENnYlZtZkV4T3FZMFg3TTNDMkV3aENSVFEr?=
 =?utf-8?B?V0k0ODBZd1hVMStnV0pXa201WHVpZ0ZDWWw5YW1Od2NPS3ZiV0hOWFZXUjBh?=
 =?utf-8?B?dnZGeUpjbDhCUWlOOXFidVYvOHJ3b25WN0RFSjQyRzFJTlYrejAzWGphREQy?=
 =?utf-8?B?bGdiTmtXOS9yL3Z0NS8xZ3pPZnV3ai9NeTBQTWRmU0czMmRGdkh2WkpSeUhX?=
 =?utf-8?B?NWZuREJyWmZiU3BhbmhKRTQwaTRSZ1JQMEZHRllpZjZjYlQxZEdGOE82c3Zt?=
 =?utf-8?B?RytFT0lyZTl2Q05EcHhlSHhsTUpIZ0x3d3NqbVVibnFGYjdDcUxRVWhpUWhE?=
 =?utf-8?B?MVBWSVFRUlRtb3BMS2xONmg3VUpIZGhVM2Fsa0xUVDMxajk5MDl5cXQrSERw?=
 =?utf-8?B?eU8weXMvUjFaRm9CMDBlWjdNaW5USER4S2RYVlRobFhJWnRGWmhjSXpzeUc0?=
 =?utf-8?B?WnRrZ291QlBTVzU3YnBRci9SVElhUDF6S0hBQVhxbk10V3VkM0l4SzJnTTBR?=
 =?utf-8?B?cHN2Vzd4WGZiTzc1WS9SM3dPdUdvZWRTak5xWGZEbVd1WTNrOUVxMXBhY2Zn?=
 =?utf-8?B?dmtWN0xxUDc4NzlvU1ZaYmZBQ3NnTlZqcWpPL214MXpWZFZIakVTemVuSmpl?=
 =?utf-8?B?VjVFd3p1ZlhReTB1OTE2YXhaanEwMDk5eEFSSUhaWVlHYTVqbi9ISm9zQUl0?=
 =?utf-8?B?cTRUa3lvb1Y4Mk04VDVmSHAvZ25JdDBzL0gveDdkeW4wTlk1TDFjUFMyZUdX?=
 =?utf-8?B?bGUyeXZodU5wcG5iTFhWVXZZTDA1eVkrczFzcUVlMjhHZ3dXRGR1UTdlbXpY?=
 =?utf-8?B?azYxN3lSTnZpK242NmVDSHpKWGUvTWNhbmhuWG9walEycjV0dWRDNHRWTzFp?=
 =?utf-8?B?OUgzL1ZDY2Z0T3A0MzJoenNXV1V4UXFna04rZjZ4QTJqbjZjSmxrODJSMEtw?=
 =?utf-8?B?K3BrY05rc2ZJb3kyY2R4QThkNmtXS2lqcWtUc2swR0U2amZtK2l3Z05hcTZZ?=
 =?utf-8?B?V0RZcSt1aW1ET25mWk9CQkJXVlNGM3ZjVFh3alcxVFYrNzZKNGFhM2EyWjNM?=
 =?utf-8?B?bDRxQkJaKzUxNGxzUkdiYzdrSjM3cmNTUXViWjl0Qi9OenVDMkFvclhxOEdU?=
 =?utf-8?B?WlJWb2ZwQXV4YktvaGJUdWU1ejliemtCcHhPRS9FNXZNaUxZMFdhdnpIdWNT?=
 =?utf-8?B?czd2Rm1uQWhZeisyTnhldnNubFoyYXNvQjBlUWJTY3k0SVhrRGgwWmpBVzhi?=
 =?utf-8?B?UkdPT2NiMlllQ0t2VFNmOWlmVER1cmoyRGpwb3NmQll6ZU5rWktPQjFBRURX?=
 =?utf-8?B?d0RCMEVldURTVGtULzdQVlVNVEFYT3IwOU5iNkdjU3BDZmdIcU40T0JXcmdU?=
 =?utf-8?B?cFdHMGpFVEJyU1RVNVBLUXh0L05ISWlPdGdhN2MrWXBBRndHTmFFNW8xQ0FQ?=
 =?utf-8?B?ZDNxd1AwaHp1UjVBc2lkV3BWN3p3c2VCQWNIcUdzK1plbTdDLzBpd2w3UGJD?=
 =?utf-8?B?Njc2ME5nMHVBcEJKR204TEFpc3ZDa2oraUxHbkFMTUxqUTRUQTQvbDlvREgy?=
 =?utf-8?B?Q1BMaDdleitwSThXM3ZweTBSb2g0aDRZZDVOQXhEMzVnUk54RzB0elJ1SnVk?=
 =?utf-8?B?R0F6bEY3dDJzRXhVTWlEVjJnQklMdURabE5sN2w4Y3laSFFMNGNKTFliL0E0?=
 =?utf-8?B?djNidjFMa0lGcHdjR0hPc0l1d1B6TnREc3NNTlF2T0hGd2NGQmlNU1dQK3dK?=
 =?utf-8?B?Y2xoTVBxNWlUT2lzLzJmZUhjQjNjL1Q3Tk05b1RrVEUzOFBha3lYR0dSQnJP?=
 =?utf-8?B?NU1RNEdva2tIUnV1RUtYak9MSkVEclRwMU9Ob25HeEFuVVhFeEdCQkFYVHJj?=
 =?utf-8?B?VEt0WC9aQ3JBRWRxSzN6V2syUVBOVDRDZk4vTmFzSmU0S0NqN0tSM3RETjhK?=
 =?utf-8?B?RXplMUcrMUlNTWt2ZlV1WWNzUDkvdXJ6a1p4c1k0V2xZY3NLUjlPY2dZeTR0?=
 =?utf-8?Q?gIXeapL3wpEXXwFg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B8FBADDD99D1EA4C979681E737D07241@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2cb69f6-a3c9-4a93-529f-08da3503bc11
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2022 17:12:18.2147
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qN/CctKgAFim8Z/K6YkpnOZQJJP6f3MoiRVr93iQ0qF2YIThA1C+8xpewKCS6C/X4RTmtaOXo5j8vFnqPwV/ug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR13MB5120
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

SGkgTGludXMsDQoNClRoZSBmb2xsb3dpbmcgY2hhbmdlcyBzaW5jZSBjb21taXQgNGI5N2JhYzA3
NTZhODFjZGE1YWZkNDU0MTdhOTliNWJjY2RjZmY2NzoNCg0KICBNZXJnZSB0YWcgJ2Zvci01LjE4
LXJjNS10YWcnIG9mIGdpdDovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dp
dC9rZGF2ZS9saW51eCAoMjAyMi0wNS0wNiAxNDozMjoxNiAtMDcwMCkNCg0KYXJlIGF2YWlsYWJs
ZSBpbiB0aGUgR2l0IHJlcG9zaXRvcnkgYXQ6DQoNCiAgZ2l0Oi8vZ2l0LmxpbnV4LW5mcy5vcmcv
cHJvamVjdHMvdHJvbmRteS9saW51eC1uZnMuZ2l0IHRhZ3MvbmZzLWZvci01LjE4LTQNCg0KZm9y
IHlvdSB0byBmZXRjaCBjaGFuZ2VzIHVwIHRvIDA4NWQxNmQ1Zjk0OWI2NDcxM2Q1ZTk2MGQ2Yzli
YmY1MWJjMWQ1MTE6DQoNCiAgbmZzOiBmaXggYnJva2VuIGhhbmRsaW5nIG9mIHRoZSBzb2Z0cmV2
YWwgbW91bnQgb3B0aW9uICgyMDIyLTA1LTA5IDEzOjAyOjU0IC0wNDAwKQ0KDQoNCk9uZSBtb3Jl
IHB1bGwgcmVxdWVzdC4gVGhlcmUgd2FzIGEgYnVnIGluIHRoZSBmaXggdG8gZW5zdXJlIHRoYXQg
Z3NzLQ0KcHJveHkgY29udGludWVzIHRvIHdvcmsgY29ycmVjdGx5IGFmdGVyIHdlIGZpeGVkIHRo
ZSBBRl9MT0NBTCBzb2NrZXQNCmxlYWsgaW4gdGhlIFJQQyBjb2RlLiBUaGlzIHJlcXVlc3QgdGhl
cmVmb3JlIHJldmVydHMgdGhhdCBicm9rZW4gcGF0Y2gsDQphbmQgcmVwbGFjZXMgaXQgd2l0aCBv
bmUgdGhhdCB3b3JrcyBjb3JyZWN0bHkuDQoNClRoYW5rcywNCiAgVHJvbmQgDQoNCi0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0N
Ck5GUyBjbGllbnQgYnVnZml4ZXMgZm9yIExpbnV4IDUuMTgNCg0KSGlnaGxpZ2h0cyBpbmNsdWRl
Og0KDQpTdGFibGUgZml4ZXM6DQotIFNVTlJQQzogRW5zdXJlIHRoYXQgdGhlIGdzc3Byb3h5IGNs
aWVudCBjYW4gc3RhcnQgaW4gYSBjb25uZWN0ZWQgc3RhdGUNCg0KQnVnZml4ZXM6DQotIFJldmVy
dCAiU1VOUlBDOiBFbnN1cmUgZ3NzLXByb3h5IGNvbm5lY3RzIG9uIHNldHVwIg0KLSBuZnM6IGZp
eCBicm9rZW4gaGFuZGxpbmcgb2YgdGhlIHNvZnRyZXZhbCBtb3VudCBvcHRpb24NCg0KLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LQ0KRGFuIEFsb25pICgxKToNCiAgICAgIG5mczogZml4IGJyb2tlbiBoYW5kbGluZyBvZiB0aGUg
c29mdHJldmFsIG1vdW50IG9wdGlvbg0KDQpUcm9uZCBNeWtsZWJ1c3QgKDIpOg0KICAgICAgUmV2
ZXJ0ICJTVU5SUEM6IEVuc3VyZSBnc3MtcHJveHkgY29ubmVjdHMgb24gc2V0dXAiDQogICAgICBT
VU5SUEM6IEVuc3VyZSB0aGF0IHRoZSBnc3Nwcm94eSBjbGllbnQgY2FuIHN0YXJ0IGluIGEgY29u
bmVjdGVkIHN0YXRlDQoNCiBmcy9uZnMvZnNfY29udGV4dC5jICAgICAgICAgICAgICAgICAgfCAg
MiArLQ0KIGluY2x1ZGUvbGludXgvc3VucnBjL2NsbnQuaCAgICAgICAgICB8ICAyICstDQogbmV0
L3N1bnJwYy9hdXRoX2dzcy9nc3NfcnBjX3VwY2FsbC5jIHwgIDMgKystDQogbmV0L3N1bnJwYy9j
bG50LmMgICAgICAgICAgICAgICAgICAgIHwgMzYgKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrLS0tDQogNCBmaWxlcyBjaGFuZ2VkLCAzNyBpbnNlcnRpb25zKCspLCA2IGRlbGV0aW9u
cygtKQ0KDQotLSANClRyb25kIE15a2xlYnVzdA0KTGludXggTkZTIGNsaWVudCBtYWludGFpbmVy
LCBIYW1tZXJzcGFjZQ0KdHJvbmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbQ0KDQoNCg==
