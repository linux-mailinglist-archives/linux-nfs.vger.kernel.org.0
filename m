Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 70860A9DAF
	for <lists+linux-nfs@lfdr.de>; Thu,  5 Sep 2019 11:01:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731196AbfIEJA7 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 5 Sep 2019 05:00:59 -0400
Received: from mout.web.de ([212.227.17.11]:53029 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726231AbfIEJA7 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 5 Sep 2019 05:00:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1567674041;
        bh=oB3bmBAKtdD7xnQeTE01Fpj2GGVIbeI0onzpxEhFfcY=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=EltrRV35wq83LsJvrbIUK/3bpz2V4kEVyc+F/AmWu5M7HvUhhIppaTqUYQB6cNSb0
         W2llsPsor7qawsISNJmUh43IoKq5CNuPBcaKaW4pMDod6IcjJoHFXHnx96KPUhzT72
         Mzo80lU8Y/QWO2fvV24W//YR8Tkgik7BgxavwbSE=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.49.131.221]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LqUbl-1iakjB3BlR-00e4tW; Thu, 05
 Sep 2019 11:00:40 +0200
Subject: Re: NFS: Checking the handling of patch variations
To:     zhong jiang <zhongjiang@huawei.com>,
        kernel-janitors@vger.kernel.org
Cc:     Anna Schumaker <anna.schumaker@netapp.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1567490688-17872-1-git-send-email-zhongjiang@huawei.com>
 <ee684073-bd3e-9a1c-4d38-702f55affba4@web.de> <5D7075B7.3080400@huawei.com>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <6687a296-e656-872e-02e4-e2722383d363@web.de>
Date:   Thu, 5 Sep 2019 11:00:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.0
MIME-Version: 1.0
In-Reply-To: <5D7075B7.3080400@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Provags-ID: V03:K1:JGI4Kdb1X+tX6r1o//YJwssZSVrhn4aPjhxvTHKP+LPXAolf4WC
 Rjf3nYQR9kJMSBl5LC9CcQXxj+UDUR8h4LclQuRlAGPl475FWvxzEd9RfuUW9NIz+XdnDcd
 tMtNKI2igB6tOCKGgt3wzPkF8C2LRflSKK0QaMzvkizHoWocvIkHx/O3olY602VN+930hbD
 UekodEPGJA6Mw41WRdt6w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:LRic+8Eijb8=:aVzZP2KymNl1d5QHIvOOI0
 NHkAV1DCL7uUVa9Lseiif/BXzrL5yylqT1X4wP1Yg9QDcwIHnDs7CQwyen9f+KuQP0/i/XA6/
 C9MKN8CIUxJYaLWcbQPHlEyOW373Juay4rlwq5mtPhYKaAUSL1Zd6MOndGyIo9vCToFA5ckJm
 JtHwGdRt5Tav2fvfGmrfWr2AlbTC3LsGgF7sra33+Jv/IsP4NuYFeoZ2k9gN/7gBiDPpTalYQ
 rZkWw/Ctetb0d7Hh7z1SLu+U6MuFaKFMQ2dOapTQ7ZuO+JUnoCHMmWdjXa4MbEGXODxHFM+Vx
 Nc80d8gQJKlHu+UCKJVWPfvrYkpll0xTrahs1FFaNu+DU9gmxCPsgT9NK+cU/OwlPLOkU0ewj
 4AbMtC4ksO6FzgeXOysz+QBQu8Lyrz2d27wfsEa0TR7VTyyuJSfE4vYhMR5DXve4+pM0WHsrT
 dS1IpOgaXExFdHXwCjEnn6czmKHDsXZMShWuqaYCCracx9fSmv+IqPfG0RuZYOvOyc9JXc6vG
 SG/vfNFWzqQtLx+Hy1wb80egcVlkbeveq1A7QskaIvbfqJQ2ec7P6Xq++xosMF6VcEvRzxAZH
 bfVsGPqIeqco3mqni0rh9n+392g1N1I4nmUA/Unleo/2MNOkj1mPtfIzAjcMkIlYfooU+9nl3
 Rb1IJlgqP2GoR6BgD26IGVDOnYnJ5dAPed4Ej6SxLx5FNbXyDq192sigJA6DpcLXK4CJrVtoT
 oZm4KM1iyyJjdO2Gunz3BPT5w3vHCbk77xI1vbrK/5DrtZp3S6CgbAl3hyrB1pz3b+ZoNxJEn
 Plqybkuf0jcV76sLbZLzoiD6sBPqST30T0HWDgbe5nblrW0EjgSaeChR26K/yzq/9GTO873jj
 iCKKtTGdpV4Gp7rRbj2oHmsZL+d1FVzZiROzA4P4TMxP5Q0Zmcx1TSebMI8J5liBisWYjQTfo
 5m13vuWIWcrt5Q2VIGWJY3hlqjZ57JAbORrNd0f9vvzQasqZlLhqaYC4cvOjBMNpsBuwm+vNh
 UA1Oo8uEtslpzfiMvealV71fHvxW97+4W0JiR/kOAk5SE1Go3Amy/bDm0y2r8hwIIv0qw9DiP
 SlnEvcqCB/glwneJuAH4d6jTIWZ//orwSCM+5/rxkhklJLdNfPZx9LH1+wYtunkiJp1nykpaH
 p2RNwavHuMemKihI+oIXAQhPqdaLlA39WmH26E1uPdwKfTsQapPY7abvbPI8v6T4SSFOW22cn
 JZA8MR3nNewhVCiMW
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

>> I suggest to take another look at a similar patch.
> How to fast find out the similar patch. Search the key word doesn't work well.

This is a recurring development challenge, isn't it?

The occurrence of related update suggestions can occasionally become
more interesting.

Regards,
Markus
