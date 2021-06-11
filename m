Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 137C83A39C9
	for <lists+linux-nfs@lfdr.de>; Fri, 11 Jun 2021 04:31:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231161AbhFKCdX (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 10 Jun 2021 22:33:23 -0400
Received: from esa4.fujitsucc.c3s2.iphmx.com ([68.232.151.214]:33839 "EHLO
        esa4.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230160AbhFKCdW (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 10 Jun 2021 22:33:22 -0400
X-Greylist: delayed 427 seconds by postgrey-1.27 at vger.kernel.org; Thu, 10 Jun 2021 22:33:22 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1623378686; x=1654914686;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=vkIU2/wau5z5sov3ZorlNol0KcJG6CIfMtKLRfzkuM4=;
  b=qh2W2KjFnTjkz2JgEIWDSkFM+9tqO1dfzVnYho4UQPb/JQU0rtCd/CNW
   AjGvS9K7TyfRh8fStVM1Z3XWoak2B8P52IDOu3dW3hV00zHCKTMvJaKZc
   iOStHCm9+ZIsF50Z94JTCEEP/jNrtZjbImZ9upsBo1lC/eUsCUloSVAzH
   MfkAD0BAgCCZ/zWdNtiK+pzN2mrz/F2tMDvFkRy21tZ7ueb5JkZ1nSZ0P
   GNRQlgvOWqMh2VdgMw2UUKmqpVAmlebU9vA+K0Rr9no5eGgBnQg3ikbDE
   oOXdGUj2O0SHFNKJ6O/RGs6CA+LthTHf1oqvhmnln8IxCeTUmIMAYCjLB
   A==;
IronPort-SDR: Ya3OAeT2PSfVFLPqtf4E3LxLLedGjU6D4OlzuNfhYdaV86biwS2Q3MMir2PK0jiIpuHwFyRyZn
 TFgfP5L30/Og8ap0c5V4fuzPXDbWvDimSw47anhjYRooS6YSKPDRwDywprhQsePHW+Z2rhOQTx
 RI3VqMsRMdGN4Nu5XaEyOYxlUgJYBnf3EqUDJRswpz8soP8EEC1x8FNenvyk/RfouMTLqJ5rch
 KCUs2Qjb2sZ9tE/sAX0bm3k9tvThhqbckqDGG9ATiBspjtZyRjgfUweX2ILa8IxJwEphzymnnp
 Ffk=
X-IronPort-AV: E=McAfee;i="6200,9189,10011"; a="40831989"
X-IronPort-AV: E=Sophos;i="5.83,265,1616425200"; 
   d="scan'208";a="40831989"
Received: from mail-os2jpn01lp2057.outbound.protection.outlook.com (HELO JPN01-OS2-obe.outbound.protection.outlook.com) ([104.47.92.57])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2021 11:24:17 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GPIHWlpsLAJyW7baw9M3yinHZRBit2LLpAhPVIa4BPm0oGD5FssL0/FV+vQpzEUIXlyUonHdN8blJVCKMhzgqU4CcXX8JPje23wqnqOzgfqXanyPGzLuofWEmo11NBS/0Gfc0tJ3kwGtV0q30E7CocDS8neFKt42N2oOGDmJ+jEKZKlIGdyPd/XIjH+P4MH7u69zGnVIWpVecHGqZF5SGblaB1Nmnu7nl80WYxy5ES4XfSdlyAN1vU3X5OFZbfAmPgJERQmfs74xN3y7q5kFywrUm4Dt94JiZAjw2XTQ5M8f2Pkd6xehGcYVumqQQiRdC92MenKzk2YhHSc+1UIwGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vkIU2/wau5z5sov3ZorlNol0KcJG6CIfMtKLRfzkuM4=;
 b=Co8bsMxd32P0BbtWoPdeGVD7/uPaig1RSt1P202NBhntS1Yhs5gp4FZofGW6ln2hkAlrqae7A58qBuowXDwEmW+VXAI7NdvYFARusZ5V7y0lcn1z7BxlWaaNQw6w0q1NPePEGVhRVMkdMqb16R57cMflynKgT/E71SUDwsmjE45czP9Fficbl9gJvcCPmrtCSCCaPbONODH86SFZNB0e80N36dlRRs+Ve23niaqIDOvw9H7aV8i5N31fBWi5Cymew246BBxsfhqXStTiACjW2at4zSH5H2ALKrdomU29uZtL/QO+aGcrGVDlBS5MDO+DVUsAnuhRS/hVSsuyuAtP3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vkIU2/wau5z5sov3ZorlNol0KcJG6CIfMtKLRfzkuM4=;
 b=M85b/OA4a6Ax3DDKubr992FblOHk8fmXIYYI0XpS1HMeNEeUh4cm6IQA3gy7pVl80cXE4SSAVSFmCqXldvIxBx10N5gAioudC17oHBqqcMqM0t2qEnXsWRI9g6vgZbt8ui2KZIt8XmR5VDA086zuTqneDnoJSC5el2CaksFTGBs=
Received: from TY2PR01MB2124.jpnprd01.prod.outlook.com (2603:1096:404:e::16)
 by TYXPR01MB1774.jpnprd01.prod.outlook.com (2603:1096:403:e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.22; Fri, 11 Jun
 2021 02:24:13 +0000
Received: from TY2PR01MB2124.jpnprd01.prod.outlook.com
 ([fe80::c013:4af0:bb36:2368]) by TY2PR01MB2124.jpnprd01.prod.outlook.com
 ([fe80::c013:4af0:bb36:2368%5]) with mapi id 15.20.4219.024; Fri, 11 Jun 2021
 02:24:13 +0000
From:   "suy.fnst@fujitsu.com" <suy.fnst@fujitsu.com>
To:     Calum Mackay <calum.mackay@oracle.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
CC:     "bfields@redhat.com" <bfields@redhat.com>
Subject: =?utf-8?B?5Zue5aSNOiBbUEFUQ0hdIHB5bmZzOiBjb3VydGVzeTogc2VuZCBSRUNMQUlN?=
 =?utf-8?Q?=5FCOMPLETE_before_session2_opening_the_file?=
Thread-Topic: [PATCH] pynfs: courtesy: send RECLAIM_COMPLETE before session2
 opening the file
Thread-Index: AQHXXl81EHT4eNgqtEyzmmuklPlz7A==
Date:   Fri, 11 Jun 2021 02:24:13 +0000
Message-ID: <TY2PR01MB2124CE5AA2EFBCA46CBF97BD89349@TY2PR01MB2124.jpnprd01.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=fujitsu.com;
x-originating-ip: [223.111.68.150]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5ac6488e-5e8b-497c-8f02-08d92c80014b
x-ms-traffictypediagnostic: TYXPR01MB1774:
x-microsoft-antispam-prvs: <TYXPR01MB1774A320040A4A180A32234589349@TYXPR01MB1774.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Tn7LAYJHjCm/2C55Y6K2kK4iLP+4pOBlTGtL+1oWBpnlMmMLA/rrrEK/96X3VOQhtZgeDyHprxy0VChFcQCEZ/GekwKRDhsslZEdbuPcyWC9NZKx9Gg887jbXHentfcLIKmKHGep/RZX7E6sSJ+IjLjPstyVxgTWZ+2Fvr7EZW5VBxB678n15xu0BHHVD0EtAJUc0uVDi7OU9vm4K5Wl22IT62jGPGEPCEMpvyZOfQIsA2hv4Emke7k0MW7cGpUeFibDy4wGJ2AI8turY8dQkKqcRbvvsaIkr+S0aTMLS3g4pGDIiifz7oC/YyLsvkNxXESrNQq46RF934HLb606+I3WFqHoZkzcI7nSs4V7bpJRVCUf2BLRb2lG1pzf5iBirr1O3WWgvwN7R+aiUdOocCzScd39JOcj1MVrgAR9kRen3OLP/F1f6F6wo0qywMCPKwtW95X1IqWxSmA9/bZb4q5Vo2tPxWHIg0w9unou24F/CfzTpbOxYhD9f8lzBRjv42u+sVbTy+jqi39QFMDwZEk3Ul0dusMmZcX9J3oD8xlvcVrlKS83z9NGC5fnuypqy2fRaD7ZtqY1uj+dZjpplNdqjW08aEId1MHVCqQSwm69han2GdVebcYwRIxzV0CBKQxXYmTcLR4M6k2CXwrrKvn3pkuCP8CsQM4ZsdfPNOHKghyhetP9QuapU/igQkK6+LeffreoiTzmL/RqJ1vV04GVzVzQSKNmzIUdqrIrByqJAG2GROmtUncYrhopFxoDMG5IehoSSNNJmNlfPhYJk5ZJA54rSAZVE2uxZHxG1b8FMh8fav+QgB+XCJzsRRbvJUuG0gf2A9RTAw40g0CPa4ZugXGgs1BpofCnBu3q380=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR01MB2124.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(376002)(346002)(39860400002)(396003)(5660300002)(66556008)(71200400001)(66446008)(45080400002)(66476007)(316002)(478600001)(966005)(110136005)(83380400001)(64756008)(76116006)(224303003)(2906002)(4326008)(52536014)(52230400001)(6506007)(66946007)(186003)(7696005)(26005)(122000001)(38100700002)(85182001)(33656002)(53546011)(9686003)(86362001)(55016002)(8936002)(10126625002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?Qy85NktxQUVZRlBBRkRBZU1jTENQa0dON1grdjJoaVEzYTl2MkNnU21oK2hx?=
 =?utf-8?B?ZDVsMGZIVi9KcWxmai9tb0pld2g3MmxVc1BkQTNEaENUY0FNL2hpNG9NTmhK?=
 =?utf-8?B?N3dMUDlaN2w5MlpaTWhmZ3FlVmlCWjFUUThTUFNvdWFzYU4yYWlHTHFvdzNZ?=
 =?utf-8?B?SU1kbTR6MTFGQVBvT3ZTQ3J6ZUlHK0p5NmRZUmlwSi9Yc3ZuZHNzRlREZjRQ?=
 =?utf-8?B?NlpJOHVjYXpESXBBTWVOSTY0NTEvb3BlZHplT1FJZG44U1VkNW9wNFF1Y0xw?=
 =?utf-8?B?a2FrTytEWjNDNHZBckJ6YnZhcEJlVnowYlp5aVpzVTBySHZ4RFhwVGhKZXdt?=
 =?utf-8?B?Q2ZzQnoyclVSWXJvM01Zb01SR2tma2EvempMRTlhNUYya3ZKT1JCQ3dxWGgw?=
 =?utf-8?B?V0NrUU5YM2Y3KzNwRzVURHVMY2h0NW5hYm4ySzRuVW5FaTMzd1VVOUJFZjRm?=
 =?utf-8?B?UDNOSHUwWWZJQVczNWxuQnRTa2ZWSkJOeUNYamRYMVVxTXRGSkhqSkZVeFgv?=
 =?utf-8?B?dVJEcEo3WU9jekUvTkxkcGZVaWVGUFNkZ3RmVnlvVTY4b2xpU0RJY1dzNnFL?=
 =?utf-8?B?NFcycWJ2QXJPUzVFUk5NbU5vc2VXaUpoMG9NN0o3QTdDMklEMldXTzFaaDdJ?=
 =?utf-8?B?S2Z5NmdCSWVCZ1ozL2hEM2xBRWdDdVp6aU9TSkxnb2lIbE0ycndZOHRCMURE?=
 =?utf-8?B?RjIzb2xaeHIzaEFYTmkyZFE2eWQ0anoweFMxUWdTVExHckl4dnY1OTRNL09l?=
 =?utf-8?B?c1h1OGVWQUFwUm55Vkh0WnJyV1RCQjZYWFJ1bWtLKzVZamdTVWt4cG42YlM4?=
 =?utf-8?B?WXFKZFJCYXAvQmgzUk9sUWhvMktVMUhTazZ5WnlOOHVLbjJPVUtQSzJ6Si9C?=
 =?utf-8?B?L2xKWGNWeDdSaldCQ1ZTblRHNFNHKzlyNFhaUTRlaXpxQ2hnZ0o0ZjVMbWJN?=
 =?utf-8?B?eVV5YzRzKzdFYjNKVWs5a0lvMmwxVUFwNVlsQytTTFF5MWRKdjMwR2dpNm5m?=
 =?utf-8?B?SHFndDdYVk9aTzFTZ1V1VTFLdUR1RXU4YnJOTWlqRnIxN2FhcHpSS0tJSUJS?=
 =?utf-8?B?c09xUmg3OWpTdDh6RHMzL05ueGdORDlCekNRM3FvU1hhS2pmcHlHaEtnOElk?=
 =?utf-8?B?NFYrVW5pclRBRW9zM1BXU01TTUFTZUd2V2drNjFHcDUzYWI5bFJDbnJmTXZD?=
 =?utf-8?B?cFgrQ3pTU1UxdUI0LzVrNzMzK0t0U2UvUEx3WnR4cmtEUnZISGVMeEtncjVS?=
 =?utf-8?B?NXBXbWxQMDJhdUZiVFJIcWhLSEJUcXpCTzRQeFpJOGpaUXkzbkMvZlMvenVD?=
 =?utf-8?B?VFdwaENjVVZNdTBVZ2hMNCtsUnNXN3BUcDRKQ1ovOUZSUlZKTVJMZHZlZjdE?=
 =?utf-8?B?Qk1lU1hDcEl0YjVFa0liaXhTWUtLbFJjRExLcEpwR3FvV2VQanJ1WENpZ21w?=
 =?utf-8?B?YU91bjg1TWZaZis3OWZCNGdTSGRyQ0pHWSszdnhPU0tzU3pTLzIwSms1UVpG?=
 =?utf-8?B?MnZlMDJ5VTJYVUdFb1RzR05xRytZRFNRNnJwK2VRK0JiZHBQQ0ZCVTdaK0sz?=
 =?utf-8?B?bTUzeDRwR082Q2NHRW9SR3hMVXRHTWNjWGI2ZXdMVkRSaWE1bmZ2dFlSOFNp?=
 =?utf-8?B?OThEVmdJSnREaUNHTCt3U0pjWlVuczIyc3gvSEJWK0JoanVvOWRMalk2bkFO?=
 =?utf-8?B?MjI3ek4zcmtFUmVZUjhBdnJCSDV3dGU1YWVlRGxBU0JNRmdZcmRvbnFvK1lU?=
 =?utf-8?Q?GD2nEbbltdlC1e31NM=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB2124.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ac6488e-5e8b-497c-8f02-08d92c80014b
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2021 02:24:13.8011
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Hd5i8C5uY0553o5KJxgEpiYiqp8CXBcSobgTH3hkzadYXQWhW3c8wYC5SCryTpkxm8ov7hNqxu0dDsQgNYJ7lA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYXPR01MB1774
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

5Y+R5Lu25Lq6OiBDYWx1bSBNYWNrYXkK5bey5Y+R6YCBOiAyMDIxIDYg5pyIIDEwIOaXpSDmmJ/m
nJ/lm5sgMTk6NDQK5pS25Lu25Lq6OiBTdSwgWXVlL+iLjyDotoo7IGxpbnV4LW5mc0B2Z2VyLmtl
cm5lbC5vcmcK5oqE6YCBOiBDYWx1bSBNYWNrYXk7IGJmaWVsZHNAcmVkaGF0LmNvbQrkuLvpopg6
IFJlOiBbUEFUQ0hdIHB5bmZzOiBjb3VydGVzeTogc2VuZCBSRUNMQUlNX0NPTVBMRVRFIGJlZm9y
ZSBzZXNzaW9uMiBvcGVuaW5nIHRoZSBmaWxlCiAgICAgICAgICAgIAoKSGkgQ2FsdW0sCgpUaGFu
a3MgZm9yIHlvdXIgcXVpY2sgcmVwbHkuIFBsZWFzZSBmb3JnaXZlIHRoaXMgYmFkIGVtYWlsIGZv
cm1hdCAoZHVlIHRvIE1TIG9mZmljZTM2NSkuCkp1c3QgcGFzdGVkIHRoZSBuc2ZkIGRlYnVnIGRt
ZXNnIG9uIGh0dHBzOi8vcGFzdGViaW4uY29tL3NzWUtVQnR6IC4KCkFsdGhvdWdoIEknbSBub3Qg
ZmFtaWxpYXIgd2l0aCBuZnMgZW5vdWdoLCBJIHRoaW5rIHNldmVyIGRpZCB0aGluayB0aGUgdHdv
IGNsaWVudCBkaWZmZXJzLgoKUGxlYXNlIGNvcnJlY3QgbWUgaWYgZm91bmQgc29tZXRoaW5nIHdy
b25nOgpJbiBuZnNkNF9leGNoYW5nZV9pZCgpLCBrZXJuZWwgY3JlYXRlcyBuZXcgY2xpZW50IHN0
cnVjdCB0aGVuIGNhbGxzCmZpbmRfY29uZmlybWVkX2NsaWVudF9ieV9uYW1lKCkgdG8gZmluZCBl
eGlzdGVkIG9sZGVyIG9uZS4KSW4gcHluZnMsIHdlIGNhbGwgJyBjMiA9IGVudi5jMS5uZXdfY2xp
ZW50KGIiJXNfMiIgJSBlbnYudGVzdG5hbWUodCkpJyB0bwpnZW5lYXRlIG5ldyBuYW1lIHNvIHRo
ZXkgY2FuJ3QgYmUgdGhlIHNhbWUgY2xpZW50IGluIHNlcnZlciB2aWV3LgpJIGFsc28gYWRkZWQg
cHJpbnRrcyBpbiBuZnNkIG1vZHVsZSB0byB2ZXJpZnkgdGhpcy4KCgotLQpTdQotLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQpPbiAxMC8w
Ni8yMDIxIDI6MDEgYW0sIHN1eS5mbnN0QGZ1aml0c3UuY29tIHdyb3RlOgoKPiBUaGUgdGVzdCBm
YWlscyBvbiB2NS4xMy1yYzUgYW5kIG9sZCBrZXJuZWxzLiBCZWNhdXNlIHRoZSBzZWNvbmQgc2Vz
c2lvbgoKPiBkb2Vzbid0IHNlbmQgUkVDTEFJTV9DT01QTEVURSBiZWZvcmUgYXR0ZW1wdGluZyB0
byBkbyBhIG5vbi1yZWNsYWltCgo+IG9wZW4uIFNvIHRoZSBzZXJ2ZXIgcmV0dXJucyBORlM0RVJS
X0dSQUNFIGluc3RlYWQgb2YgTkZTNF9PSy4KCgoKVGhhbmtzLgoKCgpJIHN1cHBvc2UgdGhlIHBy
b2JsZW0gaGVyZSBpcyB0aGF0IHdlJ3JlIHRyeWluZyB0byBwcmV0ZW5kIHRoaXMgaXMgdHdvIAoK
c2VwYXJhdGUgY2xpZW50cywgYnV0IHRoZSBzZXJ2ZXIgc2VlcyBpdCBhcyBhIHNpbmdsZSBjbGll
bnQgZ2V0dGluZyBhIAoKbmV3IGNsaWVudCBpZD8KCgoKdGhhbmtzLAoKY2FsdW0uCgoKCj4gCgo+
wqDCoMKgwqDCoCAjIC4vdGVzdHNlcnZlci5weSAke3NlcnZlcl9JUH06L25mc3Jvb3QgLS1ydW5k
ZXBzIENPVVIyCgo+wqDCoMKgwqDCoCBJTkZPwqDCoCA6cnBjLnBvbGw6Z290IGNvbm5lY3Rpb24g
ZnJvbSAoJzEyNy4wLjAuMScsIDM5MjA2KSwgYXNzaWduZWQgdG8KCj7CoMKgwqDCoMKgIGZkPTUK
Cj7CoMKgwqDCoMKgIElORk/CoMKgIDpycGMudGhyZWFkOkNhbGxlZCBjb25uZWN0KCgnMTkzLjE2
OC4xNDAuMjM5JywgMjA0OSkpCgo+wqDCoMKgwqDCoCBJTkZPwqDCoCA6cnBjLnBvbGw6QWRkaW5n
IDYgZ2VuZXJhdGVkIGJ5IGFub3RoZXIgdGhyZWFkCgo+wqDCoMKgwqDCoCBJTkZPwqDCoCA6dGVz
dC5lbnY6Q3JlYXRlZCBjbGllbnQgdG8gMTkzLjE2OC4xNDAuMjM5LCAyMDQ5Cgo+wqDCoMKgwqDC
oCBJTkZPwqDCoCA6dGVzdC5lbnY6Q2FsbGVkIGRvX3JlYWRkaXIoKQoKPsKgwqDCoMKgwqAgSU5G
T8KgwqAgOnRlc3QuZW52OmRvX3JlYWRkaXIoKSA9IFtlbnRyeTQoY29va2llPTUxMiwKCj7CoMKg
wqDCoMKgIG5hbWU9YidDT1VSMl8xNjIzMDU1MzEzJywgYXR0cnM9e30pXQoKPsKgwqDCoMKgwqAg
ZmlsZWInQ09VUjJfMTYyMzExOTQ0MydjcmVhdGVkIGJ5IHNlc3MxCgo+wqDCoMKgwqDCoCBJTkZP
wqDCoCA6dGVzdC5lbnY6U2xlZXBpbmcgZm9yIDIyIHNlY29uZHM6IHR3aWNlIHRoZSBsZWFzZSBw
ZXJpb2QKCj7CoMKgwqDCoMKgIElORk/CoMKgIDp0ZXN0LmVudjpXb2tlIHVwCgo+wqDCoMKgwqDC
oCBzZXNzaW9uIGNyZWF0ZWQKCj7CoMKgwqDCoMKgICoqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqCgo+wqDCoMKgwqDCoCBDT1VSMsKgwqDCoCBzdF9jb3Vy
dGVzeS50ZXN0TG9ja1NsZWVwTG9ja8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCA6Cgo+wqDCoMKgwqDCoCBGQUlMVVJFCgo+wqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIE9QX09QRU4gc2hvdWxkIHJldHVybiBORlM0X09LLCBpbnN0ZWFkIGdvdAoK
PsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIE5GUzRFUlJfR1JB
Q0UKCj7CoMKgwqDCoMKgICoqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqCgo+wqDCoMKgwqDCoCBDb21tYW5kIGxpbmUgYXNrZWQgZm9yIDEgb2YgMjU1IHRl
c3RzCgo+wqDCoMKgwqDCoMKgwqAgT2YgdGhvc2U6IDAgU2tpcHBlZCwgMSBGYWlsZWQsIDAgV2Fy
bmVkLCAwIFBhc3NlZAoKPiAKCj4gUkZDNTY2MSwgcGFnZSA1Njc6Cgo+ICJXaGVuZXZlciBhIGNs
aWVudCBlc3RhYmxpc2hlcyBhIG5ldyBjbGllbnQgSUQgYW5kIGJlZm9yZSBpdCBkb2VzIHRoZQoK
PiBmaXJzdCBub24tcmVjbGFpbSBvcGVyYXRpb24gdGhhdCBvYnRhaW5zIGEgbG9jaywgaXQgTVVT
VCBzZW5kIGEKCj4gUkVDTEFJTV9DT01QTEVURSB3aXRoIHJjYV9vbmVfZnMgc2V0IHRvIEZBTFNF
LCBldmVuIGlmIHRoZXJlIGFyZSBubwoKPiBsb2NrcyB0byByZWNsYWltLiBJZiBub24tcmVjbGFp
bSBsb2NraW5nIG9wZXJhdGlvbnMgYXJlIGRvbmUgYmVmb3JlCgo+IHRoZSBSRUNMQUlNX0NPTVBM
RVRFLCBhbiBORlM0RVJSX0dSQUNFIGVycm9yIHdpbGwgYmUgcmV0dXJuZWQuIgoKPiAKCj4gU2Vu
ZCBSRUNMQUlNX0NPTVBMRVRFIGJlZm9yZSB0aGUgZmlsZSBvcGVuIHRvIGxldCB0aGUgdGVzdCBw
YXNzLgoKPiBTaWduZWQtb2ZmLWJ5OiBTdSBZdWUgPHN1eS5mbnN0QGNuLmZ1aml0c3UuY29tPgoK
PiAtLS0KCj7CoMKgIG5mczQuMS9zZXJ2ZXI0MXRlc3RzL3N0X2NvdXJ0ZXN5LnB5IHwgMyArKysK
Cj7CoMKgIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKykKCj4gCgo+IGRpZmYgLS1naXQg
YS9uZnM0LjEvc2VydmVyNDF0ZXN0cy9zdF9jb3VydGVzeS5weSBiL25mczQuMS9zZXJ2ZXI0MXRl
c3RzL3N0X2NvdXJ0ZXN5LnB5Cgo+IGluZGV4IGRkOTExYTM3NzcyZC4uMzQ3OGE5ZDkzZGJmIDEw
MDY0NAoKPiAtLS0gYS9uZnM0LjEvc2VydmVyNDF0ZXN0cy9zdF9jb3VydGVzeS5weQoKPiArKysg
Yi9uZnM0LjEvc2VydmVyNDF0ZXN0cy9zdF9jb3VydGVzeS5weQoKPiBAQCAtNzQsNiArNzQsOSBA
QCBkZWYgdGVzdExvY2tTbGVlcExvY2sodCwgZW52KToKCj7CoMKgwqDCoMKgwqAgYzIgPSBlbnYu
YzEubmV3X2NsaWVudChiIiVzXzIiICUgZW52LnRlc3RuYW1lKHQpKQoKPsKgwqDCoMKgwqDCoCBz
ZXNzMiA9IGMyLmNyZWF0ZV9zZXNzaW9uKCkKCj7CoMKgIAoKPiArwqDCoMKgIHJlcyA9IHNlc3My
LmNvbXBvdW5kKFtvcC5yZWNsYWltX2NvbXBsZXRlKEZBTFNFKV0pCgo+ICvCoMKgwqAgY2hlY2so
cmVzKQoKPiArCgo+wqDCoMKgwqDCoMKgIHJlcyA9IG9wZW5fZmlsZShzZXNzMiwgZW52LnRlc3Ru
YW1lKHQpLCBhY2Nlc3M9T1BFTjRfU0hBUkVfQUNDRVNTX1dSSVRFKQoKPsKgwqDCoMKgwqDCoCBj
aGVjayhyZXMpCgo+wqDCoCAKCj4gCgo=
