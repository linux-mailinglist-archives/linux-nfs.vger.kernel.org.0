Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46E54538C96
	for <lists+linux-nfs@lfdr.de>; Tue, 31 May 2022 10:16:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244088AbiEaIQx (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 31 May 2022 04:16:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236918AbiEaIQv (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 31 May 2022 04:16:51 -0400
Received: from smtp0.epfl.ch (smtp0.epfl.ch [IPv6:2001:620:618:1e0:1:80b2:e058:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF119642C
        for <linux-nfs@vger.kernel.org>; Tue, 31 May 2022 01:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=epfl.ch;
      s=epfl; t=1653985005;
      h=From:To:CC:Subject:Date:Message-ID:Content-Type:Content-Transfer-Encoding:MIME-Version;
      bh=CenNLQP0Ef7wJoHeA8U/Ob0luMBRirbbvmY7kmaaVkY=;
      b=I5IKk7dWIzb+GLjLorcNs9vCtTo/kHyBjVp8eNNmkrDzKMuDvGJpfy7bQgR9I7Up7
        XAPmYKVoVrmy4Sh58RhwypXlzvj6JEd07kIPTlRCVD+2PN824zINXmC+OLbozzGzU
        aGkVnnehAwe3UkCwcgE7OEowvwR3V6qIeof/oDzGI=
Received: (qmail 28771 invoked by uid 107); 31 May 2022 08:16:45 -0000
Received: from ax-snat-224-174.epfl.ch (HELO ewa05.intranet.epfl.ch) (192.168.224.174) (TLS, ECDHE-RSA-AES256-GCM-SHA384 (X25519 curve) cipher)
  by mail.epfl.ch (AngelmatoPhylax SMTP proxy) with ESMTPS; Tue, 31 May 2022 10:16:45 +0200
X-EPFL-Auth: 7mmrPyVAJhj3wNhy0HajVRgjTyhUFsrx17t6gNEQQFqXLLVCFOc=
Received: from ewa07.intranet.epfl.ch (128.178.224.178) by
 ewa05.intranet.epfl.ch (128.178.224.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.24; Tue, 31 May 2022 10:16:45 +0200
Received: from ewa07.intranet.epfl.ch ([fe80::f470:9b62:7382:7f3a]) by
 ewa07.intranet.epfl.ch ([fe80::f470:9b62:7382:7f3a%4]) with mapi id
 15.01.2375.024; Tue, 31 May 2022 10:16:45 +0200
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
Thread-Index: AQHYQ16YLIpFlrH2FUmiiFZ5HnfMO6zWS0oAgBdxzEuAABNUgIAABmuAgAAjKin//+c4gIAAL0qEgACZlICAAHFaAYAgkWkAgAIEEb+AJxlXAIAAOaef
Date:   Tue, 31 May 2022 08:16:45 +0000
Message-ID: <0a0ed6d1f34f49a9b847cb2891876d27@epfl.ch>
References: <20220329113208.2466000-1-chenxiaosong2@huawei.com>
 <68b65889-3b2c-fb72-a0a8-d0afc15a03e0@huawei.com>
 <e0c2d7ec62b447cabddbc8a9274be955@epfl.ch>
 <0b6546f7-8a04-9d6e-50c3-483c8a1a6591@huawei.com>
 <d73a51a2-6b63-b536-61e6-3d18563f027d@huawei.com>
 <3ee78045f18b4932b1651de776ee73c4@epfl.ch>
 <f927bec5-1078-dcb9-6f3e-a64d304efd5b@huawei.com>
 <55415e44b4b04bbfa66c42d5f2788384@epfl.ch>
 <88231dee-760f-b992-f1d1-81309076071e@huawei.com>
 <f794d0aaef654bffacda9159321d66e0@epfl.ch>
 <67d6a536-9027-1928-99b6-af512a36cd1a@huawei.com>
 <018da3c0453845329d5ae2ec8924af06@epfl.ch>,<db55c8f7-6a6f-410e-74ca-4040364bd38a@huawei.com>
In-Reply-To: <db55c8f7-6a6f-410e-74ca-4040364bd38a@huawei.com>
Accept-Language: en-US, fr-CH
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [128.178.116.84]
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Xiaosong,

I sent the first email on 05.05.2022 to CVE-Request@mitre.org to require th=
em update the description with the following information. They replied that=
 they will update the information within that day. However, they didn't upd=
ated the description and then I sent the second email and they didn't reply=
 me.

Do you know any other ways to update the description.


"I need to update the CVE description as below:
After secondly opening a file with O_ACCMODE|O_DIRECT flags, nfs4_valid_ope=
n_stateid() will dereference NULL nfs4_state when lseek().
And its references should be updated as this:
https://github.com/torvalds/linux/commit/ab0fc21bc7105b54bafd85bd8b82742f9e=
68898a "

Best,
Tao

>From: chenxiaosong (A) <chenxiaosong2@huawei.com>
>Sent: Tuesday, May 31, 2022 8:40 AM
>To: Lyu Tao
>Cc: linux-nfs@vger.kernel.org; linux-kernel@vger.kernel.org; bjschuma@neta=
pp.com; anna@kernel.org; Trond Myklebust; liuyongqiang13@huawei.com; yi.zha=
ng@huawei.com; zhangxiaoxu5@huawei.com
>Subject: Re: [PATCH -next 0/2] fix nfsv4 bugs of opening with O_ACCMODE fl=
ag
>   =20
>Hi Tao:
>
>"NVD Last Modified" date of=20
>[CVE-2022-24448](https://nvd.nist.gov/vuln/detail/CVE-2022-24448) is=20
>already updated to 05/12/2022, but the description of the cve is still=20
>wrong, and the hyperlink of [unrelated patch: NFSv4: Handle case where=20
>the lookup of a directory=20
>fails](https://github.com/torvalds/linux/commit/ac795161c93699d600db16c1a8=
cc23a65a1eceaf)
>is still shown in the web.
>
>There is two fix patches of the cve, the web just show one of my patches.
>
>one patch is already shown in the web: [Revert "NFSv4: Handle the=20
>special Linux file open access=20
>mode"](https://github.com/torvalds/linux/commit/ab0fc21bc7105b54bafd85bd8b=
82742f9e68898a)
>
>second patch is not shown in the web: [NFSv4: fix open failure with=20
>O_ACCMODE=20
>flag](https://github.com/torvalds/linux/commit/b243874f6f9568b2daf1a00e922=
2cacdc15e159c)
>
>=1B$B:_=1B(B 2022/5/6 15:40, Lyu Tao =1B$B<LF;=1B(B:
>>> From: chenxiaosong (A) <chenxiaosong2@huawei.com>
>>> Sent: Thursday, May 5, 2022 4:48 AM
>>> To: Lyu Tao
>>> Cc: linux-nfs@vger.kernel.org; linux-kernel@vger.kernel.org; bjschuma@n=
etapp.com; anna@kernel.org; Trond Myklebust; liuyongqiang13@huawei.com; yi.=
zhang@huawei.com; zhangxiaoxu5@huawei.com
>>> Subject: Re: [PATCH -next 0/2] fix nfsv4 bugs of opening with O_ACCMODE=
 flag
>>     =20
>>> "NVD Last Modified" date of CVE-2022-24448 is updated as 04/29/2022, bu=
t the content of the cve is old.
>>> https://nvd.nist.gov/vuln/detail/CVE-2022-24448
>>  =20
>> Hi,
>>=20
>> Thanks for reaching out.
>>=20
>> I've requested to update the CVE description and they replied me that it=
 would be updated yesterday. Maybe the system need some time to reflesh. Le=
t's wait a few more days.
>>=20
>> Best,
>> Tao.
>>=20






    =
