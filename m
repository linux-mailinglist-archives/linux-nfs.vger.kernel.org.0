Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E782D6F47
	for <lists+linux-nfs@lfdr.de>; Tue, 15 Oct 2019 07:44:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726004AbfJOFo4 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 15 Oct 2019 01:44:56 -0400
Received: from mout.web.de ([212.227.15.14]:36769 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725810AbfJOFoz (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 15 Oct 2019 01:44:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1571118274;
        bh=bIA8xFrgcYI+ZFsdMvznmWQBTTL2aT6W0IdrsY8EdtQ=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:Reply-To:From:Date:
         In-Reply-To;
        b=Hr/zKMzzXZrYvNe242TO/lEmj9MoHKdx1nmOPfCm+OCk0+t3QXc9D3wmfJYcZiPwj
         mPQ064X/gqTA2Mh33vmFxVAzkWjY951N9zIFSREwbYFDvTmTKB5uvE6PdZsSJknyvi
         9VYuI8LuXkLIN1gNRYC9Lp1z+2eGeGu6Py6usxa0=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.132.79.11]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LtX9Q-1hsqpS23G8-010wHP; Tue, 15
 Oct 2019 07:44:34 +0200
Subject: Re: SUNRPC: Checking a kmemdup() call in xdr_netobj_dup()
To:     "J. Bruce Fields" <bfields@fieldses.org>, linux-nfs@vger.kernel.org
Cc:     Anna Schumaker <anna.schumaker@netapp.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Aditya Pakki <pakki001@umn.edu>, Kangjie Lu <kjlu@umn.edu>,
        Navid Emamdoost <emamd001@umn.edu>,
        Stephen McCamant <smccaman@umn.edu>,
        LKML <linux-kernel@vger.kernel.org>
References: <9b5a5e63-2a24-ad79-20e2-4c01331ee041@web.de>
 <20191014223350.GA19883@fieldses.org>
Reply-To: kernel-janitors@vger.kernel.org
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <68ca7b7c-100c-0fc0-8819-e1fa891d5414@web.de>
Date:   Tue, 15 Oct 2019 07:44:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20191014223350.GA19883@fieldses.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:1kZQCR/TJ1RnBB90TGi9jHPQsEZeQIs8AQBFNixFYgCQ/tZ1/Q6
 ioGdjmPX5ffxee9kWVKBAxZwKMFCZ+sgaT79SDwLNfNOhDPQSVogS+ieYLkqMsxTSeaam+Y
 gWdUjbwAKvIhgJQjcq3l7PYDGY+RzGtlNAg4xg8C94oaoOGDax+HRlkX5GQqQ7js5rKnHm7
 KsgsG99rch3QuUhCPLlTw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:GUuH0qsXvV4=:j8lsCQ6h3ETfScKcQKuP0/
 eokp99coGmKLAe6oVZb/ix5WCCdNwcxAxR2axtmszxBSqCY6j+malu0Z7PfKM7dgRfi1qNpe1
 lFfRZekzMzpTMcx1K5bPTt7Bd1XYK8WHwx73u18yNMnbFbwHk+AdWd730kC5oE0VG6Rf1MiXB
 N+Ha1Qv1cTkHYdMRrx8BpXbwtP6SeIq6Jjb8/13oIPvOnQBDJ1TZTIbUN7tJk+UNvlElzFIOJ
 UygfSyY2sKDZzzyDHh6fnqKoryvyG11VcyhKjtWsXC/oY5RA56V5oOLWQT2jATFX+GMWQcU5s
 HzXtdgfKk1d6fd4ODDW5tYEwo+mH2vrBUYwNwTUmqWaySKLgC6cqO8D+4FnL3Yc2+KrwZxaDN
 v7N8BOMc/QB/n5nKgaXFnqDyD9n9VNSV6Y0Xhn0reizcEV5elfCeg9njZQwlX63ZG8871lo3S
 7d+nGEqImAvd8GynnuaQetlsVwjflUU6nQzzxT2nAAEPvEd9oSxiEyjKlZ25BH5hR2KJpgG5P
 f0Dz+M6fbLzqm5Jbcxq4ctFhR4Q38jYCQJFo9kGpw2Ko6FmxNnSKs+T05hdF1hUutADb8BcrU
 OxSK3jBWMaqUFBVYyYAyLe06Rt0/jP2u+scc695tD9q3qOPtsbl6SX/b+06zKbh4udap7UKO8
 TF0N3k9MTS0AjA3T6NIyKfHHM7/QlQTZWRLMhbsL2ANZ1wM13lqhJOhmzwBWxP05FfAN6gArj
 oA+NzK9p7Erl+WKZAmqUCMUFo+zJMYwWFsXt4WT02+JVo/tC7fbaUt585kV/7MjYlPp2cupgy
 +gTbTK10s1+Adpe0aOVyv99uAHglxpcw/kBjyCTDFctKxDUrqhvDNsQmdKlDUf9NSH0Knu0bt
 shc7Ys6i1GCkuF6BTVx/N3vX2G2zSzr/4gIjTkRLlcIlygppTDffkswVURMB1nm6Pdom9PRHC
 tgokHnt3dfOIeiJqUyBq591i9qO2xQ0SHEFua8ldoat5ZX7qyr8CQv1L/lPyc/DZRsDpfBi6W
 81efbhG/dOydc9Fh6ydVhNSrwFihEEj6TeMYCf1LjbfdNvXgCU4n8XtjZUljdHhSAoRb/BbQy
 mJQz0v4qfnmba8UBuaT04wGVwMGjKCeKVd40CpyJpg5479a9Cg/euCkT1Ph8blwflfXYKmafu
 5GpAfLe9fHmQhi4oKcgBcTjohqhUCh3lCTMsfTJuJz2xB+zRqONjdKo8ks204bfW8YPq7Riqc
 xqRWT4N36X/GOj2eLxRrQqrDptGSBMwTHeNqyC4X9RLLDncdDELtz2/MA1sE=
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/include/linux/sunrpc/xdr.h?id=3D1c0cc5f1ae5ee5a6913704c0d75a6e99604ee30a#=
n167
>> https://elixir.bootlin.com/linux/v5.4-rc2/source/include/linux/sunrpc/x=
dr.h#L167
>>
>> How do you think about to improve it?
>
> On a quick check--I see five xdr_netobj_dup callers, and all of them
> check whether dst->data is NULL.

Your information is appropriate.
https://elixir.bootlin.com/linux/v5.4-rc2/ident/xdr_netobj_dup

Such a Linux source code cross reference can point out that the function =
=E2=80=9Cxdr_netobj_dup=E2=80=9D
is used only within the source file =E2=80=9Cfs/nfsd/nfs4state.c=E2=80=9D =
so far.


> Sounds like a false positive for your tool?

This depends on the software development view you would prefer here.
The desired null pointer checks are just not performed by the mentioned
(inline) function itself.
I imagine then that a dedicated macro might help to stress software design=
 constraints.

Regards,
Markus
