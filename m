Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E15A5006F2
	for <lists+linux-nfs@lfdr.de>; Thu, 14 Apr 2022 09:34:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240371AbiDNHg3 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 14 Apr 2022 03:36:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240360AbiDNHg1 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 14 Apr 2022 03:36:27 -0400
Received: from smtp4.epfl.ch (smtp4.epfl.ch [IPv6:2001:620:618:1e0:1:80b2:e059:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAA6C3EA84
        for <linux-nfs@vger.kernel.org>; Thu, 14 Apr 2022 00:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=epfl.ch;
      s=epfl; t=1649921637;
      h=From:To:CC:Subject:Date:Message-ID:Content-Type:Content-Transfer-Encoding:MIME-Version;
      bh=mEgjtCoTKQpDlyOYjMdOl5zQO9O84yOnOduKLc6NT5c=;
      b=jYwAXBDyVgPCPEwBTOc5CiPx4He4ACBtnvLFE7DDzYlDtHMlNS0Bj+lCsyXcECKXJ
        omESDTnBzenZWrXH4d9YTYMEs25fc3T2nAftUSl1nsWeARMFe0D35NETYZD4sNE42
        BXWELxxuUJ/EgFKH36L350bJhzfJegyKWUHrwk0Lo=
Received: (qmail 57937 invoked by uid 107); 14 Apr 2022 07:33:57 -0000
Received: from ax-snat-224-186.epfl.ch (HELO ewa11.intranet.epfl.ch) (192.168.224.186) (TLS, ECDHE-RSA-AES256-GCM-SHA384 (X25519 curve) cipher)
  by mail.epfl.ch (AngelmatoPhylax SMTP proxy) with ESMTPS; Thu, 14 Apr 2022 09:33:57 +0200
X-EPFL-Auth: CZt9fkWZbvd0KTvik+0w++xgCfXP2WMJ0UuHl3KK5wTnQdKluvw=
Received: from ewa07.intranet.epfl.ch (128.178.224.178) by
 ewa11.intranet.epfl.ch (128.178.224.186) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.24; Thu, 14 Apr 2022 09:33:56 +0200
Received: from ewa07.intranet.epfl.ch ([fe80::f470:9b62:7382:7f3a]) by
 ewa07.intranet.epfl.ch ([fe80::f470:9b62:7382:7f3a%4]) with mapi id
 15.01.2375.024; Thu, 14 Apr 2022 09:33:56 +0200
From:   Lyu Tao <tao.lyu@epfl.ch>
To:     "chenxiaosong (A)" <chenxiaosong2@huawei.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        "anna@kernel.org" <anna@kernel.org>,
        "bjschuma@netapp.com" <bjschuma@netapp.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "liuyongqiang13@huawei.com" <liuyongqiang13@huawei.com>,
        "yi.zhang@huawei.com" <yi.zhang@huawei.com>,
        "zhangxiaoxu5@huawei.com" <zhangxiaoxu5@huawei.com>
Subject: Re: [PATCH -next 0/2] fix nfsv4 bugs of opening with O_ACCMODE flag
Thread-Topic: [PATCH -next 0/2] fix nfsv4 bugs of opening with O_ACCMODE flag
Thread-Index: AQHYQ16YLIpFlrH2FUmiiFZ5HnfMO6zWS0oAgBdxzEuAABNUgIAABmuAgAAjKin//+c4gIAAL0qEgACZlICAAHFaAQ==
Date:   Thu, 14 Apr 2022 07:33:56 +0000
Message-ID: <f794d0aaef654bffacda9159321d66e0@epfl.ch>
References: <20220329113208.2466000-1-chenxiaosong2@huawei.com>
 <68b65889-3b2c-fb72-a0a8-d0afc15a03e0@huawei.com>
 <e0c2d7ec62b447cabddbc8a9274be955@epfl.ch>
 <0b6546f7-8a04-9d6e-50c3-483c8a1a6591@huawei.com>
 <d73a51a2-6b63-b536-61e6-3d18563f027d@huawei.com>
 <3ee78045f18b4932b1651de776ee73c4@epfl.ch>
 <f927bec5-1078-dcb9-6f3e-a64d304efd5b@huawei.com>
 <55415e44b4b04bbfa66c42d5f2788384@epfl.ch>,<88231dee-760f-b992-f1d1-81309076071e@huawei.com>
In-Reply-To: <88231dee-760f-b992-f1d1-81309076071e@huawei.com>
Accept-Language: en-US, fr-CH
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [128.178.116.84]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

RnJvbTogY2hlbnhpYW9zb25nIChBKSA8Y2hlbnhpYW9zb25nMkBodWF3ZWkuY29tPg0KU2VudDog
VGh1cnNkYXksIEFwcmlsIDE0LCAyMDIyIDQ6NDEgQU0NClRvOiBMeXUgVGFvOyBUcm9uZCBNeWts
ZWJ1c3Q7IGFubmFAa2VybmVsLm9yZzsgYmpzY2h1bWFAbmV0YXBwLmNvbQ0KQ2M6IGxpbnV4LW5m
c0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGxpdXlvbmdx
aWFuZzEzQGh1YXdlaS5jb207IHlpLnpoYW5nQGh1YXdlaS5jb207IHpoYW5neGlhb3h1NUBodWF3
ZWkuY29tDQpTdWJqZWN0OiBSZTogW1BBVENIIC1uZXh0IDAvMl0gZml4IG5mc3Y0IGJ1Z3Mgb2Yg
b3BlbmluZyB3aXRoIE9fQUNDTU9ERSBmbGFnDQrCoCAgIA0KPuWcqCAyMDIyLzQvMTMgMjM6MzIs
IEx5dSBUYW8g5YaZ6YGTOg0KPj4gR290IGl0LiBUaGFuayB5b3UgZm9yIGRldGFpbGVkIGV4cGxh
bmF0aW9uIQ0KPj4gDQo+PiANCj4+IEJlc3QsDQo+PiANCj4+IFRhbw0KPj4gDQo+DQo+QnkgdGhl
IHdheSwgaXQgc2VlbXMgdGhhdCB0aGUga2VybmVsIG1haWxpbmcgbGlzdCB3aWxsIHJlamVjdCBy
aWNoIHRleHQgDQo+Zm9ybWF0LCB5b3VyIGVtYWlscyBjYW4gbm90IGJlIHNlZW4gaW4gTkZTIG1h
aWxpbmcgbGlzdC4NCj4NCj5odHRwczovL3BhdGNod29yay5rZXJuZWwub3JnL3Byb2plY3QvbGlu
dXgtbmZzL2NvdmVyLzIwMjIwMzI5MTEzMjA4LjI0NjYwMDAtMS1jaGVueGlhb3NvbmcyQGh1YXdl
aS5jb20vDQogDQpPSyEgVGhhbmtzIGZvciBsZXR0aW5nIG1lIGtub3cu
