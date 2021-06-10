Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39E6A3A21C5
	for <lists+linux-nfs@lfdr.de>; Thu, 10 Jun 2021 03:08:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbhFJBKv (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 9 Jun 2021 21:10:51 -0400
Received: from esa13.fujitsucc.c3s2.iphmx.com ([68.232.156.96]:1403 "EHLO
        esa13.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229557AbhFJBKu (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 9 Jun 2021 21:10:50 -0400
X-Greylist: delayed 427 seconds by postgrey-1.27 at vger.kernel.org; Wed, 09 Jun 2021 21:10:50 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1623287335; x=1654823335;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=ydCRjXrBIJxuSl2TdPumUZ1/rdcT1Up5kQ+cAB73beg=;
  b=iX4wylU56bW9zXMXHe8ZMEmTVKhvHnwUNLP+IUZEU6zRwklj7U7ZTWCU
   rw02c+KLAODYK8B9slUzjtvqQBSXv0w2f43I/bqjtZUn58I5lxbabcB3P
   b5F3dJU9shcKW+jE6Z+Como7XaaZ5QGpjRvoeftQurqFIbBBeZfT5zqGE
   kzYjbXbcU3jXWjq9KPEHv4HuSyxugNb0z7Do/U1pl7RNrmEnAHC6KavaX
   z7H2rkzbv0ddz3gT6vQrOQO2ft4HxCqlLl03DEyLK9p4tfJIFZHXOXIcR
   faIFCdQVwG1CruUpTLYfkbSFhxIjpPfCWjz/jDRytbG6hq7q4QOziFOfe
   w==;
IronPort-SDR: NYeV9ml08zId8dVkKH+MwLagKU7IMKq7UPC+/5Zl0BhoJt2l+64Q2w2lpKdYTY0GeqAZYlOsXJ
 I+9N0Z7aQiJWtRwK8taNT3vEOYfTk2RZGfSH9Kl0G3046JTutPcuQHAi+PN3OSVmrN7kgSYCjr
 YggCUkWBU3kOOytUlQjJrcyiUsOVxt0tU1YEf7c1dL1TCec96o3hGJwmplBtypYSdNx7dr3b/t
 mAjIl13d/foDY0n6mtgjy/be9vngEVpXv92YKGO+LnhQ4jvl41CIkpf2msUEoOk2AdeSATYgUM
 5Eo=
X-IronPort-AV: E=McAfee;i="6200,9189,10010"; a="32607700"
X-IronPort-AV: E=Sophos;i="5.83,262,1616425200"; 
   d="scan'208";a="32607700"
Received: from mail-os2jpn01lp2053.outbound.protection.outlook.com (HELO JPN01-OS2-obe.outbound.protection.outlook.com) ([104.47.92.53])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2021 10:01:47 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O/lOUaZVllVLaFjbGYqnqMLhYpexZAB4dz9vqUGj0OdZ/KlOVDk7AHFGRnDRZZhyFIhh2FYl6C7/DRWPUQDGYrDap0HVcFzJKQDXyKvN7fTeyFsWH5vbeloAGhkFSf7BJLUAHJh4SK7O0Sev/KEiTgpa1b9LbOKrtmP+CykMl+oNruzVMJ1B4lDiYk53FhEQDi8tpAAd5djcuQm/EqAOHiC9KNjtfNe2qNDre5TmW+2O98CrvVW3ADU0MGjAy6L+3KbMciG8oMzdfARXirHP1fiKnqs0Qo392tqJlXuuwShwBJ1JG6WU8BFTF9lBWXozGDP3NbyAnjPL68H+wXB+iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ydCRjXrBIJxuSl2TdPumUZ1/rdcT1Up5kQ+cAB73beg=;
 b=nDRz2NwDgLxhffFBv/+px8XVWy4ExbrBGTKakIq2SMcZFD8wol7lK4RDhbyFXZOXxw5L3PIJCpd/PE2O/9BjmNWEEq0hGg4boYlyd63fEkekfTRA4wNJ0w21lIolis0XS3JzgmwHpeTUWVlJQum+K8dkfhE9E5eFwyPODZUtPIy9XOucXivAZwTeDCexloumcg6qB3JXs2fxtXx26+jirwH1IPVXly3O3oz29NpsF8HvlzWhOsgMbLLJ2B4KsXKufak6IDYPgrmQpkEJqhoA9JjOtLPpNdNUbqYCy+nznehiYizFWa5Zhs6F+AAPwXeIWsKp98ohR/m76tPXnYr3gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ydCRjXrBIJxuSl2TdPumUZ1/rdcT1Up5kQ+cAB73beg=;
 b=B1CWHe3NF9gq6Yb8DMZ3uvaVGzudZ6ocmcJqS+MxF2zJ0YiQhwvmSR64WXtu3DPyXo3Qnxw/hZIZWkzf0jIME1c7cTKMfKEUq62IY7io50mOqMcKjSqiP+0bu5R1l+yiBz8ArvjHQHhpioyjl1yH6Ojbs0pHy/9+WEJQF2u+UHw=
Received: from TY2PR01MB2124.jpnprd01.prod.outlook.com (2603:1096:404:e::16)
 by TYAPR01MB5801.jpnprd01.prod.outlook.com (2603:1096:404:8056::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21; Thu, 10 Jun
 2021 01:01:43 +0000
Received: from TY2PR01MB2124.jpnprd01.prod.outlook.com
 ([fe80::c013:4af0:bb36:2368]) by TY2PR01MB2124.jpnprd01.prod.outlook.com
 ([fe80::c013:4af0:bb36:2368%5]) with mapi id 15.20.4219.022; Thu, 10 Jun 2021
 01:01:43 +0000
From:   "suy.fnst@fujitsu.com" <suy.fnst@fujitsu.com>
To:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
CC:     "bfields@redhat.com" <bfields@redhat.com>,
        "calum.mackay@oracle.com" <calum.mackay@oracle.com>,
        "suy.fnst@fujitsu.com" <suy.fnst@fujitsu.com>
Subject: [PATCH] pynfs: courtesy: send RECLAIM_COMPLETE before session2
 opening the file
Thread-Topic: [PATCH] pynfs: courtesy: send RECLAIM_COMPLETE before session2
 opening the file
Thread-Index: AQHXXZOIFFv34IfevkCoKUhkTeHcvg==
Date:   Thu, 10 Jun 2021 01:01:43 +0000
Message-ID: <TY2PR01MB2124D8FDDDCA29F5691F3DD089359@TY2PR01MB2124.jpnprd01.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=fujitsu.com;
x-originating-ip: [223.111.68.150]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 40853e6e-08d9-4d4c-7b1a-08d92bab5056
x-ms-traffictypediagnostic: TYAPR01MB5801:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <TYAPR01MB5801F8E6D1CB2BFFD2E881C189359@TYAPR01MB5801.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Hj9WACDArcO2iXmbKp7iNaXyjJFN6PyKFzPeC/rFDdQuANAER8R1aFSgOm7/VaZVK82yerYSu4dhGhHvwRYutm2lHKkdHFxKPDcF7Q0dW2qtitJDA55cBYsOvps0wNRq9jB0JaYH9ncw9uscPwO8VDpZ6dnR6NhA1zQREWxSceBH/2Aoq1kag+8lCgEAK7MCIpRQqM89VEkrGLPOp7tE17rJzw94QSfpcv7aGXWnbe5HA+Th52a4vwVgSqYUXedp4sOEPZWj38LdheB8G0a7oxL9K3Jdfn6Tl21k8XwZno7Fx6Lh/5+4Sogn2dh2OnHjN7ORGhvcj+2JvtrJjMmmA2Rv4KFyd05ygprqt7TCTSIC6PlE9IGr7wdgOhBmXktfgMUmnmLN0gcMFAwqpqU2Wi5N+r3jBYiEAIU8F6B9EgZM8zqvBwxFb3h9t4FlLIo6Feydf1LgqJEYwUkVMMjTcpC8ujG9FcnPDwE2IylMZYSkKhMuRBkvbYgmYeYrvTCDcP0SORSURjaE04I9/qTlfOegXfbnfjIDWWY8J9ktSLwaszfBV/AJ7xUvVv7ThacGwHRn5SofDP/S2na4c1m3nn21mxa/AYW5r8gxjzKfPzk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR01MB2124.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(396003)(39860400002)(376002)(136003)(366004)(54906003)(316002)(66946007)(2906002)(86362001)(7696005)(478600001)(55016002)(38100700002)(5660300002)(71200400001)(33656002)(122000001)(6506007)(66446008)(85182001)(52536014)(107886003)(64756008)(8936002)(26005)(186003)(8676002)(4326008)(6916009)(9686003)(66556008)(76116006)(66476007)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?gb2312?B?a0MybE54OThaRUF1dTlVNnUyNjdLaGR6ZTd2aFIxWi9tbG13K2duVmp3bG9z?=
 =?gb2312?B?UHRKWS94cTJTeTMvMTBsVFp5WVU5bHVGZUN2Tm15YWdISjVwUDBZRTlvanZ3?=
 =?gb2312?B?SGwrWEs4ekRyWTVkY0FTT3paYjNNaWtaejBGci9Mekt2OE1KTUlQWXJBLzlW?=
 =?gb2312?B?YjNwKzhCRnAxZUthMXdtanl3TXZBUll3YUlNV1kzdzAvUSszMCtUcWhiN2Zk?=
 =?gb2312?B?STI2ZGltZ1F2TlhqSTBRSVZyNXlOYis3NThzQTYycnFQQzZQQzR0QUlzdHRV?=
 =?gb2312?B?QnpZWG9NMlU2UzZwaHlFa25BblVTbDZ2T1pLd1lXcklOdCtqVSs4WWR6dGFn?=
 =?gb2312?B?K1lnZXI1anpCVkpLV0trKzIvZ2xYc1hTNmt4S0ttTlU3UHQxVVY1U29xR1lR?=
 =?gb2312?B?Q1hvNHova1hDVjdNb1FWdjFEaFhFWE9uUHA5RDVTMjFqWmRmRHN6TDF3U0pZ?=
 =?gb2312?B?TS9Ka0YvTkZZRlNnM3dHQ2QwZ3JYZXFmVTBvTkF4WVFHTW96czlpelkxQXBY?=
 =?gb2312?B?K0pxb0kyc3B1OTVyZW8xbTlVOW5BNGRyZzJmTWUyc3kyd1A0ZEVRa0JlT2NN?=
 =?gb2312?B?L1VkaGFoUU91alFGbUJyVTBzZFNHdU4xb3M3Sm1SNmwva3Zrc3JhNjRLeFFr?=
 =?gb2312?B?aWl1ZUpEQ2FvdXZkU003TldzeHk1Q2xGMC9sSGZ6OGhZOGJXWVVVSmdJcjFr?=
 =?gb2312?B?VS9aQjFBeU5VMEpPSklKTlV2TXN6R21jZ3kzUFFpNzlyOUQ4YUNEZWg4WWRr?=
 =?gb2312?B?SWc3R3ZzYkc1Q2RITmErQVpnVUxmcWhKTW84KzdLRmhDamVLU0RlQ2hhRzY1?=
 =?gb2312?B?akhqRkplTm1EQ3hsV3FjT29mRlh3c2dqOG9CTk43SFpxanI0b2FSUmtwd09x?=
 =?gb2312?B?dE05U0JEVEkrRnRKU3BjQkFSMnBTNjI3bHhJN1NVQzk3NUNCdWZwMU8zSEhx?=
 =?gb2312?B?ZkFwSjRBOHVFbFVpd3F4Z0F2cU9zN09JZzltZmFIWWR0VHMydUlaT0ljeDh4?=
 =?gb2312?B?aVl0N2VHRjhSdUVsWG83eGxLNWdCUTE3U3ZNMWxaRDJpVmV4OE5nZDNxbWcy?=
 =?gb2312?B?UERiVDNJSElyTHNrZjBjdmFmajBraVQxZHhwN211Y1VsZXFtUWFxQzNPVEtZ?=
 =?gb2312?B?SkpueENjZHZPT1o5dEtrTTF3ZHF1b3czeHJkL0F4ZERzaFVlZSs4YlhuV1Az?=
 =?gb2312?B?cENHWkJld1NRTXhmVm01d2lFd082TzkvTG5jZVlrRWc5cUp2QlkveXc1d285?=
 =?gb2312?B?Qk04Nyt3cWZ6aWNXdGppU04vZllZS0d5ejdqekxNMVdoakRCS1Q5bFFyaW1C?=
 =?gb2312?B?WDFyVlNvdWpwOGp3WTdUSkFzcE1JZmc4dXN6SFo4TjF0YVdkTmZtN2phWXpl?=
 =?gb2312?B?UEp6b3Y2KzA0Y0txa2hYcGcyUjBpRWRCa1FHbGtla0wwemdDMThQOG1WRTRO?=
 =?gb2312?B?KzRHZUVsZFBrUG9lL1RhUGpVN3RxQ2hWelE5c0tMck01K3YrdzgzZnNDM1d0?=
 =?gb2312?B?ZDZlU1cwb05nZVkwb2I3WFgxMysvdGdZbGt3YnA0bVppQkI2QUM3VEZoSXhQ?=
 =?gb2312?B?YkIrR29WUnAydVJudUFxa0JLQlU5TEhvTUt4K04xNVd0L240RVgrdUt3MWE0?=
 =?gb2312?B?OVBPZGNVNVgwMTBGTXBCc1crSnhML3R1Z3VtUmZHWGpPU01JWVdSS0crTkVv?=
 =?gb2312?B?aklWWEtDVllQRlhVMmJpNWFoMlkrdmFQYkVoRnFGZzBBN010dHg2Mm1SN3Rz?=
 =?gb2312?Q?BOZNpV1kPzuC+mA+zm55EDROXNwF26HfmVMHX2u?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB2124.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40853e6e-08d9-4d4c-7b1a-08d92bab5056
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jun 2021 01:01:43.6233
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G2epUNmcf54lk/U/ngtgZwOj5jiHmofzUa/3rjHM2/z39Nc9tIL1YvWGoMpqKZmjybw0UvcS8/vHbsMie2ASCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB5801
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

VGhlIHRlc3QgZmFpbHMgb24gdjUuMTMtcmM1IGFuZCBvbGQga2VybmVscy4gQmVjYXVzZSB0aGUg
c2Vjb25kIHNlc3Npb24KZG9lc24ndCBzZW5kIFJFQ0xBSU1fQ09NUExFVEUgYmVmb3JlIGF0dGVt
cHRpbmcgdG8gZG8gYSBub24tcmVjbGFpbQpvcGVuLiBTbyB0aGUgc2VydmVyIHJldHVybnMgTkZT
NEVSUl9HUkFDRSBpbnN0ZWFkIG9mIE5GUzRfT0suCgogICAgIyAuL3Rlc3RzZXJ2ZXIucHkgJHtz
ZXJ2ZXJfSVB9Oi9uZnNyb290IC0tcnVuZGVwcyBDT1VSMgogICAgSU5GTyAgIDpycGMucG9sbDpn
b3QgY29ubmVjdGlvbiBmcm9tICgnMTI3LjAuMC4xJywgMzkyMDYpLCBhc3NpZ25lZCB0bwogICAg
ZmQ9NQogICAgSU5GTyAgIDpycGMudGhyZWFkOkNhbGxlZCBjb25uZWN0KCgnMTkzLjE2OC4xNDAu
MjM5JywgMjA0OSkpCiAgICBJTkZPICAgOnJwYy5wb2xsOkFkZGluZyA2IGdlbmVyYXRlZCBieSBh
bm90aGVyIHRocmVhZAogICAgSU5GTyAgIDp0ZXN0LmVudjpDcmVhdGVkIGNsaWVudCB0byAxOTMu
MTY4LjE0MC4yMzksIDIwNDkKICAgIElORk8gICA6dGVzdC5lbnY6Q2FsbGVkIGRvX3JlYWRkaXIo
KQogICAgSU5GTyAgIDp0ZXN0LmVudjpkb19yZWFkZGlyKCkgPSBbZW50cnk0KGNvb2tpZT01MTIs
CiAgICBuYW1lPWInQ09VUjJfMTYyMzA1NTMxMycsIGF0dHJzPXt9KV0KICAgIGZpbGViJ0NPVVIy
XzE2MjMxMTk0NDMnY3JlYXRlZCBieSBzZXNzMQogICAgSU5GTyAgIDp0ZXN0LmVudjpTbGVlcGlu
ZyBmb3IgMjIgc2Vjb25kczogdHdpY2UgdGhlIGxlYXNlIHBlcmlvZAogICAgSU5GTyAgIDp0ZXN0
LmVudjpXb2tlIHVwCiAgICBzZXNzaW9uIGNyZWF0ZWQKICAgICoqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqCiAgICBDT1VSMiAgICBzdF9jb3VydGVzeS50
ZXN0TG9ja1NsZWVwTG9jayAgICAgICAgICAgICAgICAgICAgICAgICAgICA6CiAgICBGQUlMVVJF
CiAgICAgICAgICAgT1BfT1BFTiBzaG91bGQgcmV0dXJuIE5GUzRfT0ssIGluc3RlYWQgZ290CiAg
ICAgICAgICAgICAgICAgICAgIE5GUzRFUlJfR1JBQ0UKICAgICoqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqCiAgICBDb21tYW5kIGxpbmUgYXNrZWQgZm9y
IDEgb2YgMjU1IHRlc3RzCiAgICAgIE9mIHRob3NlOiAwIFNraXBwZWQsIDEgRmFpbGVkLCAwIFdh
cm5lZCwgMCBQYXNzZWQKClJGQzU2NjEsIHBhZ2UgNTY3OgoiV2hlbmV2ZXIgYSBjbGllbnQgZXN0
YWJsaXNoZXMgYSBuZXcgY2xpZW50IElEIGFuZCBiZWZvcmUgaXQgZG9lcyB0aGUKZmlyc3Qgbm9u
LXJlY2xhaW0gb3BlcmF0aW9uIHRoYXQgb2J0YWlucyBhIGxvY2ssIGl0IE1VU1Qgc2VuZCBhClJF
Q0xBSU1fQ09NUExFVEUgd2l0aCByY2Ffb25lX2ZzIHNldCB0byBGQUxTRSwgZXZlbiBpZiB0aGVy
ZSBhcmUgbm8KbG9ja3MgdG8gcmVjbGFpbS4gSWYgbm9uLXJlY2xhaW0gbG9ja2luZyBvcGVyYXRp
b25zIGFyZSBkb25lIGJlZm9yZQp0aGUgUkVDTEFJTV9DT01QTEVURSwgYW4gTkZTNEVSUl9HUkFD
RSBlcnJvciB3aWxsIGJlIHJldHVybmVkLiIKClNlbmQgUkVDTEFJTV9DT01QTEVURSBiZWZvcmUg
dGhlIGZpbGUgb3BlbiB0byBsZXQgdGhlIHRlc3QgcGFzcy4KU2lnbmVkLW9mZi1ieTogU3UgWXVl
IDxzdXkuZm5zdEBjbi5mdWppdHN1LmNvbT4KLS0tCiBuZnM0LjEvc2VydmVyNDF0ZXN0cy9zdF9j
b3VydGVzeS5weSB8IDMgKysrCiAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspCgpkaWZm
IC0tZ2l0IGEvbmZzNC4xL3NlcnZlcjQxdGVzdHMvc3RfY291cnRlc3kucHkgYi9uZnM0LjEvc2Vy
dmVyNDF0ZXN0cy9zdF9jb3VydGVzeS5weQppbmRleCBkZDkxMWEzNzc3MmQuLjM0NzhhOWQ5M2Ri
ZiAxMDA2NDQKLS0tIGEvbmZzNC4xL3NlcnZlcjQxdGVzdHMvc3RfY291cnRlc3kucHkKKysrIGIv
bmZzNC4xL3NlcnZlcjQxdGVzdHMvc3RfY291cnRlc3kucHkKQEAgLTc0LDYgKzc0LDkgQEAgZGVm
IHRlc3RMb2NrU2xlZXBMb2NrKHQsIGVudik6CiAgICAgYzIgPSBlbnYuYzEubmV3X2NsaWVudChi
IiVzXzIiICUgZW52LnRlc3RuYW1lKHQpKQogICAgIHNlc3MyID0gYzIuY3JlYXRlX3Nlc3Npb24o
KQogCisgICAgcmVzID0gc2VzczIuY29tcG91bmQoW29wLnJlY2xhaW1fY29tcGxldGUoRkFMU0Up
XSkKKyAgICBjaGVjayhyZXMpCisKICAgICByZXMgPSBvcGVuX2ZpbGUoc2VzczIsIGVudi50ZXN0
bmFtZSh0KSwgYWNjZXNzPU9QRU40X1NIQVJFX0FDQ0VTU19XUklURSkKICAgICBjaGVjayhyZXMp
CiAKLS0gCjIuMzAuMQo=
