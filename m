Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5184DA8966
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Sep 2019 21:24:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731332AbfIDPMW (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 4 Sep 2019 11:12:22 -0400
Received: from mout.web.de ([212.227.15.14]:32993 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725965AbfIDPMV (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 4 Sep 2019 11:12:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1567609922;
        bh=MLwzX2Ag6E0I65ugOCYTZJWqOcoWiPUC4NbXXvUz5AY=;
        h=X-UI-Sender-Class:Cc:References:Subject:From:To:Date:In-Reply-To;
        b=TodkIuZtbzt7DuqFOzK8Jc/K3oX8mRYktQaWFPxqwFUla+2nyXui6FMSP9EFUjW8b
         K1oZI6PAx3vuQptP5RsYFiwCcdnii1lLaM+P5JFfq70m7mqGMj4t6gC6ZqvZwY3viv
         nU+CCEUcEU2mJpCewB6W5sSCG5YvhBJ3D+nIdU8E=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.49.100.89]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MYw31-1hietF0Rrn-00Vhmn; Wed, 04
 Sep 2019 17:12:02 +0200
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <1567490688-17872-1-git-send-email-zhongjiang@huawei.com>
Subject: Re: NFS: remove the redundant check when kfree an object in
 nfs_netns_client_release
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
To:     zhong jiang <zhongjiang@huawei.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        linux-nfs@vger.kernel.org
Message-ID: <ee684073-bd3e-9a1c-4d38-702f55affba4@web.de>
Date:   Wed, 4 Sep 2019 17:11:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.0
MIME-Version: 1.0
In-Reply-To: <1567490688-17872-1-git-send-email-zhongjiang@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Provags-ID: V03:K1:bNy8P2eLzO6SWCikq/EyOnMMJ5zURVSF5DwBKeykv7kS4uLyeko
 Xz8h0sMGuFjOw9BGxNzqT48iA7zmqarDJwI+w1aF+HIt6k2HfGMEV/wgS36f5+PCXB1QpuX
 T/H3qWx5K9+lzWMvCEWFIwYduGQ0FEowZqniFhwq/Qfwo4PHp+nOQSwFHTrWmC/HAiubt09
 KGb4gMPJwW1/sLMynSy7g==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:fsNXSIjRR1Y=:IqlSQbzIUD8ciY1tvXPquH
 uO/Y3Zs4vhu/7pYU4lhd4XNNjJlEcfNfnt6ac2FXtnNzhkgx3bHWAwSGWY0pqoF7I8x+O1ZMl
 57G/JIce+6djK0u528GakTpIQmZlV1kM/+bjdhlkotZblYc2kwG/BeOUMffqcElGAw+AQRLEy
 SgUKam/FAq5EUEBC/inOF420LYbqqSak6XBXObJaAF3w/bAroe1+GwXwbYIQpt3djnC3Psxyb
 iUzjx+N4tdZwf0tn8bUUWASO4D5eC+oSZuAyfVYz+9G6eaEDcluQF2qLr7g9VwyFIaOeeNZuA
 2iMdYDTeghM2yu0vBWVqO+vQXNJ6PMLGhFnNUi9k27ywySL+vvR/mel08uedWVIbyr7eARR7l
 yzJFuxye0nYqDu4TuPnSrCG1Rwct9JlS7lvbj6XWBRpUjrleZuoxIjvNUK10thfy6U9NYhzl/
 XDNz4PogYkSbQZXBj3VJQwIZfyYafSoFlcg5/pjEgLloYwC4N7I+tJhqDh3y77FikABLsmlE5
 5XNhymYtlsNUaqvpZxtQnI+ssLCOCutLH37M6EBpksDQh0cHIQPFsXFRt+HWTQnOe7fkoxFNF
 3rsmIVDzdAU+ab/z2etm+pqxqs49pG74MfyzSyS2TSa0CkbRnw6xrOSUzK/QXDu/TQCC7Ly/X
 v+XM70kcDDcNppIDqeV7xA/AAgjOIlY47NVMCklAA2DcUEvcQiPAKxzJ+camnLcJnHmqgxY6a
 zgHL8pNkvgO6ZgjAeyiWTLGBTxJpFedxwl+CmGU/7NCpsJxRz5jjYErAw9Bu+2WcPrywAoNN+
 SkA4G4r2iVedguzdcEQGsxQhtN0hANfiGSTJezO+1DpsegIvF6LMdma4F0d0UGOvXvIDpHbkC
 kWlK96AEpXg8uthKU+212nvzNdyZDd07Dk7dbvObbEXU5XKr0NKs2Pujko5omQ1AKd68AYbV2
 /FwO0Gi57M+EFJfvm4M4PUpoKF71pvhNoGXOVJ9RehrhT1wQY5Ez556j1OeTWAvGkpScOGKZp
 GuqQsoHXRUbixtlYfkxzqgckbcQTW7dkXXMJVjhrlmqq5yrnoQXFhNj6jHouwbLspe8EVFH1H
 mBU2hdrfw8QU0qWFi/HbEs+hngaA3dJNExfy0YfJz86X2Esmx/Gv5WjbyPMtc4EODaAShC2X7
 MqOCidMUBeWxiOmPm67UfVfPhsWcUDcBmC6sUOl39jwB2ejaTt3Ez2qUJsmFEWNtPDzXQe2VY
 SSCL3al2vM+0cK/1/
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

> kfree has taken the null check in account.

I suggest to take another look at a similar patch.

NFS: fix ifnullfree.cocci warnings
https://lkml.org/lkml/2019/7/7/73
https://lore.kernel.org/patchwork/patch/1098005/
https://lore.kernel.org/r/alpine.DEB.2.21.1907071844310.2521@hadrien/

Regards,
Markus
