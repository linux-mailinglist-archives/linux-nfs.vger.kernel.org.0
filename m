Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80C776F8713
	for <lists+linux-nfs@lfdr.de>; Fri,  5 May 2023 18:54:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231676AbjEEQyP (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 5 May 2023 12:54:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231222AbjEEQyO (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 5 May 2023 12:54:14 -0400
Received: from sonic313-14.consmr.mail.ne1.yahoo.com (sonic313-14.consmr.mail.ne1.yahoo.com [66.163.185.37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61FF819417
        for <linux-nfs@vger.kernel.org>; Fri,  5 May 2023 09:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1683305652; bh=qmS+yITaQIP29+iePr5tVQ+LCnz4GuDMsK1RUBrVGhg=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=gvc8wZgPHVSGyK6FJ5osb9KzCbdhjhry13KCMpz+2/Ybuwwi0i3supM6jOwUxaU8c1fm79FyE8ELpWceSowrfKfUwDj8BWWoqyjqQkE27jNzjG1TiA/8HpathNr7yvKku5pPvM7E68I5DZQsM6IafxGKlQgl8ivIn/LrgrQ5Aw33y4Jh1bxmrlyYfWccTbxRLehMSGXVUA8erxIHGPcZjybPa+m+nYFYApIglGG/52kWQXaXvjyt0rHO1PgHK/tbT/ugJAK5dWut5oxHHWO/R+iu98b5fHseOuSFSl5Rc2wQvsiN++476xDD5XTAf5IuySWSfMJ3wcyY8lRwCxcI3w==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1683305652; bh=GnyRcDhCCWd49uLtYMtEATlT3I68OgfLr8B04gVfoQy=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=JCzOzBeWANOecrJoYxDOr9g2mRIzPZXN6hEYpk7vqLjnCK0yx9c9hKOen03e3D4SqE/lfAa80oLGX13w/3/VvfHU1+4Yy6vBnBDwZ5hg/mNCZOcp/F9obygwcZyhWRJQ+l49KgKDwDxkhlZO37OkOtdDSPjq5kxgilGjxaxSId4nh8cYa4kAX5GVkHQ/LlpuWCYO9E2wg7JNiKPoQTHFisSoNonTqhzFwQVqVOhMaNs3lC5UiCsiaQ71XF0az0/HVYufspCA6ZW8JVyyTQBCORh3MQSP0AHKsuae6IWHN9xPZFe4u8gYXnA9M2oNgNH9jjUhdOx1zs6pZ4ZBMoMLjg==
X-YMail-OSG: OG98wlsVM1lsQ1.6u2uqa46LzgmZnXUHC86eZ3.M5BBvAH0o5qSYREuJ9atkNjL
 D8gN021a4KK7J.fSx5BvXnuLvtVQMqvUIYzH1WW.HYDyUdcquuxhppsveK6.GyNWvqiXwYwoD4SJ
 pnM3nDnOhH2yvMDy9_tNhhQBT2BBBgR0njwtV64CYWOWdwaPGIFRnLmGKkROI74Nc2iYykQkMR1Z
 pL6DN_OuI2jIGMc4QBRyyL6Fe1.5lu0zkzAbj4E8m_3p8x0MKLwGCclrhwYnyzzeMMFbB26wMewt
 Fp5aTAwEyi5c8Z2wTx7YkKJ_aPC_faKkkqsgbhrrmzKLj1VGckapU4GPhQX_uTdZbmqR3BBFre_f
 C4RyY_v8PWRRNiZ7TrA2yexkKNLqAzk9jjgwGUjlu5_iYqp2vt0Syhh2VXVWZJdxtjPm8tVcAybL
 Jz6Xmt0OgjBu.mW6JWYDAd_FnSHO35Qg6IYosV1q5Zxc6LS.kGIuZtJC1ptVptkf7iT_.juwIDDD
 w5fmhnhReFOBr910BKQ8qKXE7Zaeas3T71elzJLQdPn9XuIV_v7K6U1hiW84CFeajY6L7FuDH9v5
 pkDwsJ..dRhzclT5Supu7pMct_0p.39GT_j1Prz0ALIIz42yVplqIir3L0KZeS03yhgrzQQtBxNN
 ermya7m3wycTExiPtgHNGViWk3k.b9UiUsAQGkZeITYuAxYlPPAcH4WrEglozq7bsAEygO6kQf4T
 1yaqLpcziWYv52U7czAdZ10s5PiAH8Znuv7dSlkvpQAtRGgVneJRiDO1_k9VsIhGvY8LGuJIjcHt
 K.4c.L5WHuq9kD1WBxx13B7qF3n.hYvSyMfoe7QXgiXMc44QX9rup58VFuKllBf6xXqpQ2FnGdkp
 JEaSpjEHAbfwfVmJ5NJRAZfZOim9FXEReWfxlobJT9Ui1rZa0LPjrI76BNtYNtX.11sN96LHUCZA
 Pbkxk8sj55ai9b.5VltcPkOTj.vtBQyAyS1TgK5AI1xHmAtNAOz2UjLvUQdMNswW2OES1jSApScs
 YZqaGd1f3RNjZfu5PV_VHaGKSaae97pnESsjz9VnJYuLldzXKkLlpvBKCq0.xk1ZKBFqkN2BvqYp
 SpEF35tlbbw4b1wUECjn0HPcgY3EibYaWg_fnAW4tLI6A8qUekBxsRAePsZ7eMAVbo549pmpn2et
 8rczyQqVxcPdU4NeNDhsLsNLUmGbuagGiMPW_1MO6toi63rZZY1Fzn_N0irbytIk72hyDR8tkCSd
 YwMz4X3iJUroRxg.an.A9oj4FAUy5Vmd7wQ2R8jF.SY.1iH6RknArUOeOljF2ndMB3gJA5CjD773
 62J28pq4ruABV.lTa4knqQADyWoZPIx6nm_23j8Ab8FxrRvY1OhzLk1pMwtaxD8PU0WIliHvH.gz
 cVykLQhcnGFWveXR81tkJU3AXPBdcoE7YYK6YCi827HpVGNN36PU5qcuN63VY6GMg11tHUGO.Er3
 iLL1ZfaCniRgD2srUc2CI0UTjNjqcE9jjTE8wKXRTRUobXP6sS4KS9a7ixfud7zOVBkoBdcsNspR
 oOAKsdnB7ruMiZRnLVn3flPaDcxRgCYq37BJTZSIK_8gHH1p1qEeeYTx8f1yp1BRc2M.4T_qGpqo
 Q3DDmdJC6VJzWm0MHPeMp1DIIDqD9an_WmIqqmdLOst3iSEF9k_jQsH6YdxF1BkqH3Iu_S_TJi3I
 h24vibMwdTAue4t2nEe3AwURE5rT8RTKtWBip3MZq3Q7JOnBBqHht3Xs47SACb5zwrp4A.NDn3N_
 203g17DJC8x2ZLezikeZVRH27MOwpeY41B6IXH0Kn6XUx6iOZuOUdGoBvAvJjIE6_hjCU3M_FNCZ
 Jl.JOhi83Ld3J8CSuN8uGOjRPK7OgrCjxJfjZXggbr7nD0PJoL2pbVEqzLPH.y3ElZoL0lpeXdsB
 eEMymKaGrkB7ehyYiAHYh0S5KRqRzXYTAAGUO5GLkcpeOI3ik1JeTt6aCwEMRgNZNGF2zPIcdwDl
 mdH5A_AebVKwnnN7IlPHYqaUwdXcA.u.bEUxTh8BkxbcSE4pcVSs3_nscJ59tCqgzeKBFsEJ4S8L
 eFp9eUMMu_sGILc9QHvYm5XSMs7B4bFAYvDQeO392ERbNuYb58oRUm8DlXN21maaJ2UsbV7SGIMj
 YCyTrvonvlxTjKoE7DqH1veDVcpXNpTXCIvUHD2l_6W2Jqdm27lJjBn1h.sUoGz88S6niF93Z_Rw
 JpnATDnAxpCRzf57ONyQJ3Za.ntEHOhyB7ReL86hYaxjfE6CZqkBdKWKKXQ1wGfeARGgMmFedqKk
 Qc.9fYQ--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 076b0c49-4c26-4ff6-a733-e41b8bfe0c79
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.ne1.yahoo.com with HTTP; Fri, 5 May 2023 16:54:12 +0000
Received: by hermes--production-bf1-5f9df5c5c4-8dccp (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 5ad00bb60cbca83274984f7707b1a4a4;
          Fri, 05 May 2023 16:54:10 +0000 (UTC)
Message-ID: <1600f24c-70fb-15f3-029a-7152d8225437@schaufler-ca.com>
Date:   Fri, 5 May 2023 09:54:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: NFS mount fail
Content-Language: en-US
To:     Paul Moore <paul@paul-moore.com>
Cc:     Roberto Sassu <roberto.sassu@huaweicloud.com>,
        linux-security-module@vger.kernel.org, linux-nfs@vger.kernel.org,
        chuck.lever@oracle.com, jlayton@kernel.org,
        Casey Schaufler <casey@schaufler-ca.com>
References: <1923bc2f330f576cd246856f976af448c035d02e.camel@huaweicloud.com>
 <d34c30ba-55cc-8662-3587-bb66e234b714@schaufler-ca.com>
 <CAHC9VhQu7GQ54H0k=C8ZWU-5zOX35QNWrBMEyNTE1AU_e8DcPQ@mail.gmail.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <CAHC9VhQu7GQ54H0k=C8ZWU-5zOX35QNWrBMEyNTE1AU_e8DcPQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.21417 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 5/5/2023 7:03 AM, Paul Moore wrote:
> On Thu, May 4, 2023 at 9:00 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>> On 5/4/2023 9:11 AM, Roberto Sassu wrote:
>>> Hi Casey
>>>
>>> while developing the fix for overlayfs, I tried first to address the
>>> issue of a NFS filesystem failing to mount.
>>>
>>> The NFS server does not like the packets sent by the client:
>>>
>>> 14:52:20.827208 IP (tos 0x0, ttl 64, id 60628, offset 0, flags [DF], proto TCP (6), length 72, options (unknown 134,EOL))
>>>     localhost.localdomain.omginitialrefs > _gateway.nfs: Flags [S], cksum 0x7618 (incorrect -> 0xa18c), seq 455337903, win 64240, options [mss 1460,sackOK,TS val 2178524519 ecr 0,nop,wscale 7], length 0
>>> 14:52:20.827376 IP (tos 0xc0, ttl 64, id 5906, offset 0, flags [none], proto ICMP (1), length 112, options (unknown 134,EOL))
>>>     _gateway > localhost.localdomain: ICMP parameter problem - octet 22, length 80
>>>
>>> I looked at the possible causes. SELinux works properly.
>> SELinux was the reference LSM implementation for labeled networking.
>>
>>> What it seems to happen is that there is a default netlabel mapping,
>>> that is used to send the packets out.
>> Correct. SELinux only uses CIPSO options for MLS.
> SELinux can use the NetLabel/CIPSO "local" configuration to send a
> full SELinux labels over a loopback connection.

True enough. As you point out below, that's an advanced configuration
option. A typical SELinux system isn't going to be set up that way.

> * https://www.paul-moore.com/blog/d/2012/06/cipso_loopback_full_labels.html
>
> There are several differences between how SELinux and Smack implement
> labeled networking, one of the larger differences is that SELinux
> leaves the labeling configuration, e.g. which networks/interfaces are
> labeled and how, as a separate exercise for the admin whereas the
> labeling configuration is much more integrated with Smack.

Which is consistent with the general approach of the two systems.

> I wouldn't say one approach is better than the other, they are simply
> different.  

Agreed, for the most part.

> The SELinux approach provides for the greatest amount of
> flexibility with the understanding that more work needs to be done by
> the admin. The Smack approach provides a quicker path to getting a
> system up and running, but it is less flexible for challenging/mixed
> network environments.

Smack does have knobs and levers for setting some network attributes,
and netlabelctl can be useful in certain cases. Smack could take better
advantage of the netlabel capabilities than it does.

> There are other issues around handling IPv6,

Smack CALIPSO support (to replace the existing IPv6 handling) is on
the short list. When that gets done depends on many factors.

>  the sockets-as-objects
> debate, etc. but those shouldn't be relevant to this discussion.

Agreed.

