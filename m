Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 57785D5191
	for <lists+linux-nfs@lfdr.de>; Sat, 12 Oct 2019 20:20:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729481AbfJLSUa (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 12 Oct 2019 14:20:30 -0400
Received: from mout.web.de ([212.227.15.3]:59313 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729469AbfJLSUa (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Sat, 12 Oct 2019 14:20:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1570904407;
        bh=aaWZ/GEhFUyuau1WLazwaF/9LjLt3tQSmn3IW5rsK9k=;
        h=X-UI-Sender-Class:To:From:Subject:Cc:Date;
        b=ns4lRxydJaMhx7IMaqVl1woGwIegUwPnThzeQKkMqnCFlOVzZVtlPWB8WwvnnDDiR
         nwS8v02AgU+QvXjRjNnWfh4bnHZJAjFL3oNYIo2mky3yF4q7QI1oGcQgGrtX69I1fu
         vsj75aNJbJ+bgwe/7GMgYsBaIPCKaQawe70ce9c0=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.132.155.250]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MNP6P-1iQCYJ3mYr-006u2b; Sat, 12
 Oct 2019 20:20:07 +0200
To:     linux-nfs@vger.kernel.org,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>
From:   Markus Elfring <Markus.Elfring@web.de>
Subject: SUNRPC: Checking a kmemdup() call in xdr_netobj_dup()
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Cc:     LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org, Aditya Pakki <pakki001@umn.edu>,
        Kangjie Lu <kjlu@umn.edu>, Navid Emamdoost <emamd001@umn.edu>,
        Stephen McCamant <smccaman@umn.edu>
Message-ID: <9b5a5e63-2a24-ad79-20e2-4c01331ee041@web.de>
Date:   Sat, 12 Oct 2019 20:20:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:nKLKL3PDDdmuI9RcDSwwek58eQCcNUmIgwCtbOTx0ztaQxes30Q
 l8bYrZHDYKw5tceIOxWS5JzGW+8FTN5RUk1XaLNSMyiwLP1JR1x72vBuc9MOpkJm1AtiD5T
 1lCRd8yHNfowLH5lR0vx9+Mx4PRBrrvGjqhjOQm7fdznf3GrPln+173YGQ3cLkxRaOioml+
 tTu0cJhrn7CUdtplADi+A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:i4jvdSQpe0c=:lRFZtU5kAMdd9/Joye8SrC
 DU3buPgh7Rk1TPkBv182lGVkXEYXZKbJ5AR86DoqxL1Ulj0TRg14eGCs0DfTJ7r5nsuLeLfyK
 RW3ytmlE16u7Q/Xxcv1HBf8UKQSh7uAu0dHBgxQwvn5Ty6FBjQ5HnlSYpFcMPPzgihVr9+ZER
 bEvac3/n2biZ69DUlRTgxtVXYhAYhX6ejU15brKEf5jMXYcoDjBB7KeCzBIsgLn+OoR0tXicJ
 6/xqwryrymcvr0m5TwicUtUKObLD8bxf/XFsITVlh7MvxZRmaMQKlmG7n36KCHLPNpjFJG0u9
 MH8RxlDDpCcAm+PzNloWZ3dLhy5fL6F91fOvvbUJGIz38iq9w+sM3XVsYCojvNP/Sj8HIQSoR
 uprZltcdG8sStbvRu/GCj9jL0E9qCzlghdLdHJqgCFV6ZL5oEVp5jn3vj+bI0/1u1u0uRRT67
 Xn1eYhfT1MUYCy/4qoe4qALOua8m3ZVklXL64vy7RkBN3QO1nKLjK31k67OFu/Oly+uXPkyo3
 S/kBLGteBIMOQBjicVauhf8iOdcxKqK2TmP8spod9GsfDK3B/itRi6pNL35ob5ZCJI+KQyKCk
 pq8ukqovPDGsTLpyjZKWCsI/oIu4zezC3GSQgCVF+1PGml78/MUf99m9jVNcsH7n3x3twHIJj
 zXnKuyAfumSvuKmCr8yai6qBBGgBUB1+SFGDbJ1aY/XYg951O8iM8mBtx7nluGlcUycdZT1ZL
 P6Ih5vQjoiBApzpGF72L8PSdPoTWpuI94rvK72HKSh9z0nwP40b+RNa8CmW+GciG0boku1NeG
 GVD4pYqxUZmMZE4LrF+b2dQsUfz9DD24Vs8CaTv5lFhx199DIlQpd+DZcAV3xCLV68gUgUGhv
 i8U451KGQ/nJVJ8VTFS0OTJQK1eD/0NiU7pazgevzo1Sttd3JEwxii9naHiIbT1eSEc6vv14K
 qd7L2qwMYPDlzyeFwFGej3TOyuBRFKHE74y+MlEdGBEa3hTqtHiKcWYUKSXcUyLqVPAN1AVjO
 /xZv8RSm+YTv+o5GnPqi5C6d5E5X32hKv0R1Cj91puq+7drMXeIDoTGnC50USA6qP6fmrwTp7
 1r2TJblcG5JgZK7kWuayUDwZigrd6fifmOdqoiVv/t1s/Z4Ysq8xX6ZNjNkfvsC9aYMOvxtpU
 Vu0a9r7JSXTsfZbSuLfBe0NS8JDyFSTDu98CDtFpzvACHuQ+A+6zA+FOXIDVYy0OCMQuvSPOp
 egmFZCFCz3/lv0FYh/DLW+YnPyHEbbPuyda+cY4bBPftA4OjueoAyPhXFlzo=
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hello,

I tried another script for the semantic patch language out.
This source code analysis approach points out that the implementation
of the function =E2=80=9Cxdr_netobj_dup=E2=80=9D contains still an uncheck=
ed call
of the function =E2=80=9Ckmemdup=E2=80=9D.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/in=
clude/linux/sunrpc/xdr.h?id=3D1c0cc5f1ae5ee5a6913704c0d75a6e99604ee30a#n16=
7
https://elixir.bootlin.com/linux/v5.4-rc2/source/include/linux/sunrpc/xdr.=
h#L167

How do you think about to improve it?

Regards,
Markus
