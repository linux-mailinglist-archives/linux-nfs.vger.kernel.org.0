Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 230B651D26E
	for <lists+linux-nfs@lfdr.de>; Fri,  6 May 2022 09:41:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381632AbiEFHok (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 6 May 2022 03:44:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357116AbiEFHoj (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 6 May 2022 03:44:39 -0400
Received: from smtp5.epfl.ch (smtp5.epfl.ch [IPv6:2001:620:618:1e0:1:80b2:e034:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6A8C5B3E5
        for <linux-nfs@vger.kernel.org>; Fri,  6 May 2022 00:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=epfl.ch;
      s=epfl; t=1651822852;
      h=From:To:CC:Subject:Date:Message-ID:Content-Type:Content-Transfer-Encoding:MIME-Version;
      bh=+q6EU4ou11rp/Adq8ErA1hBF3oE9f/2O2rhlrWoVrqE=;
      b=ikWj4i/UhSNlTIX4yA2ndQ4Wb3PwipZ5WXfxs6AIfVzec5Q4yJ7yuvAp5hDlkUb3+
        f0KvUnYxznnRWyjhlpBtJwqJREzgtGiscGO202/ntcCypMzeedlPwJXoN0CtD5G5z
        9GeMrTSWP09sNvyTgeuC6+NCxWBeuI1XUQ3hkhPxo=
Received: (qmail 4971 invoked by uid 107); 6 May 2022 07:40:52 -0000
Received: from ax-snat-224-174.epfl.ch (HELO ewa05.intranet.epfl.ch) (192.168.224.174) (TLS, ECDHE-RSA-AES256-GCM-SHA384 (X25519 curve) cipher)
  by mail.epfl.ch (AngelmatoPhylax SMTP proxy) with ESMTPS; Fri, 06 May 2022 09:40:52 +0200
X-EPFL-Auth: +dtnDacP1/Qm7fXShKLMJNoVvZuS6LOxl71MoRkEl4mlgrz+9kc=
Received: from ewa07.intranet.epfl.ch (128.178.224.178) by
 ewa05.intranet.epfl.ch (128.178.224.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.24; Fri, 6 May 2022 09:40:51 +0200
Received: from ewa07.intranet.epfl.ch ([fe80::f470:9b62:7382:7f3a]) by
 ewa07.intranet.epfl.ch ([fe80::f470:9b62:7382:7f3a%4]) with mapi id
 15.01.2375.024; Fri, 6 May 2022 09:40:51 +0200
From:   Lyu Tao <tao.lyu@epfl.ch>
To:     "chenxiaosong (A)" <chenxiaosong2@huawei.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bjschuma@netapp.com" <bjschuma@netapp.com>,
        "anna@kernel.org" <anna@kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        "liuyongqiang13@huawei.com" <liuyongqiang13@huawei.com>,
        "yi.zhang@huawei.com" <yi.zhang@huawei.com>,
        "zhangxiaoxu5@huawei.com" <zhangxiaoxu5@huawei.com>
Subject: Re: [PATCH -next 0/2] fix nfsv4 bugs of opening with O_ACCMODE flag
Thread-Topic: [PATCH -next 0/2] fix nfsv4 bugs of opening with O_ACCMODE flag
Thread-Index: AQHYQ16YLIpFlrH2FUmiiFZ5HnfMO6zWS0oAgBdxzEuAABNUgIAABmuAgAAjKin//+c4gIAAL0qEgACZlICAAHFaAYAgkWkAgAIEEb8=
Date:   Fri, 6 May 2022 07:40:51 +0000
Message-ID: <018da3c0453845329d5ae2ec8924af06@epfl.ch>
References: <20220329113208.2466000-1-chenxiaosong2@huawei.com>
 <68b65889-3b2c-fb72-a0a8-d0afc15a03e0@huawei.com>
 <e0c2d7ec62b447cabddbc8a9274be955@epfl.ch>
 <0b6546f7-8a04-9d6e-50c3-483c8a1a6591@huawei.com>
 <d73a51a2-6b63-b536-61e6-3d18563f027d@huawei.com>
 <3ee78045f18b4932b1651de776ee73c4@epfl.ch>
 <f927bec5-1078-dcb9-6f3e-a64d304efd5b@huawei.com>
 <55415e44b4b04bbfa66c42d5f2788384@epfl.ch>
 <88231dee-760f-b992-f1d1-81309076071e@huawei.com>
 <f794d0aaef654bffacda9159321d66e0@epfl.ch>,<67d6a536-9027-1928-99b6-af512a36cd1a@huawei.com>
In-Reply-To: <67d6a536-9027-1928-99b6-af512a36cd1a@huawei.com>
Accept-Language: en-US, fr-CH
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [128.178.116.84]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
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

> From: chenxiaosong (A) <chenxiaosong2@huawei.com>
> Sent: Thursday, May 5, 2022 4:48 AM
> To: Lyu Tao
> Cc: linux-nfs@vger.kernel.org; linux-kernel@vger.kernel.org; bjschuma@net=
app.com; anna@kernel.org; Trond Myklebust; liuyongqiang13@huawei.com; yi.zh=
ang@huawei.com; zhangxiaoxu5@huawei.com
> Subject: Re: [PATCH -next 0/2] fix nfsv4 bugs of opening with O_ACCMODE f=
lag
=A0  =20
> "NVD Last Modified" date of CVE-2022-24448 is updated as 04/29/2022, but =
the content of the cve is old.
> https://nvd.nist.gov/vuln/detail/CVE-2022-24448
=20
Hi,=20

Thanks for reaching out.

I've requested to update the CVE description and they replied me that it wo=
uld be updated yesterday. Maybe the system need some time to reflesh. Let's=
 wait a few more days.

Best,
Tao=
