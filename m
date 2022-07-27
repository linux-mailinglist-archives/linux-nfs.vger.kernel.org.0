Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BE365831DC
	for <lists+linux-nfs@lfdr.de>; Wed, 27 Jul 2022 20:21:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243059AbiG0SVE (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 27 Jul 2022 14:21:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243430AbiG0SUb (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 27 Jul 2022 14:20:31 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57D435D0F8
        for <linux-nfs@vger.kernel.org>; Wed, 27 Jul 2022 10:20:27 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id z25so28141858lfr.2
        for <linux-nfs@vger.kernel.org>; Wed, 27 Jul 2022 10:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tkjIxH2Hswl1VdSvd5f1Wu9dxZhTkwFPncCPJM7JMW4=;
        b=iAC67o+kfKNmxXzwSq5HeVmj9MxmkQWymyLRFCoSJQ0Bc+fVY7gfb5yrnNiHC/zSng
         YKNbmaxFXjSOPlSn3m1A2mBzjqjNidZPwkCctne8bKr8MhsOb9rGToC8v9+qiaTKDWLn
         t7zIHTae7d3g4AGrmcvmHopj82AewGidJDvTJfylxYvDCD5DyD6nDTCOXYY0QMKa1swQ
         iaQGfoaiCXbnwxolJOJsKRAgoUbRkw6chI3BEFmUl4heCLsJhHU6E70Ue8p43TqOllfQ
         94lBZtz2wSUpRwcbs7FZzcy4qpM7m6FnvuQgV4Udy1OVAunBdedROd7E3v7sxb9KW6vn
         Rv6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tkjIxH2Hswl1VdSvd5f1Wu9dxZhTkwFPncCPJM7JMW4=;
        b=lxgb0g0GzjneqV7qhOsLVfCzc9peGvvmYTLwq9lFDdCQdYW0O7mzNraFcD/ZQL5iMR
         tdsWJ3k+5ld9oPBwPY7V0LqWi7NKmXhW8H2ZQTWs+GZt3YN9axGjfmVATSIBMf3nQwGz
         Q+I451Ftu4GA1p66D/wyVaQPMPAF6+HT72ypkxWjpbEVxJAxpG1XG94Z+8ZiOE4ZoA7m
         R8dV4sH239aYIUIofa7PALyPi76O2E1c2YXAu2EmLs4OqCg6MiZAEGjeCGk3ftlUPtHk
         L3K53G64C++zWzaCPUN2NCKNu8RQgJBjjk7V4FEJQqmvqGn8rCwnBNL0X0/mPo3GW8K0
         vIwA==
X-Gm-Message-State: AJIora+AU9mJoDohJmSLwTSLIdzfA2wDzHo6Y+CYDnp/31WMMu3ehEQZ
        IvwumG0wblSG4HhU51s8UGx5is+c1oD5b5AjgmWBQrEhQZo=
X-Google-Smtp-Source: AGRyM1s2WFhQ1uIU6NAnCSSQ5ghZYo+j7ENWyjSla7htf0esVROMtlb4MElo+RF6kTg7erMbEcx4lc76idzUkLBEEko=
X-Received: by 2002:ac2:4d06:0:b0:48a:765d:144b with SMTP id
 r6-20020ac24d06000000b0048a765d144bmr8245497lfi.208.1658942425341; Wed, 27
 Jul 2022 10:20:25 -0700 (PDT)
MIME-Version: 1.0
References: <CAD15GZd=sxsXiNmuN-FpRk3E_cKRF_CTLqxd5XJ4KhtON4XkPQ@mail.gmail.com>
 <CAD15GZe1__nJ6SfAr1zs4Vq4za9D=FP__SotyS37RVh=2OWu-g@mail.gmail.com>
 <CAD15GZdCYTr0Xfn1-n-aXf5FxLDR-zrYR2TutHk_4RRbP6+pVA@mail.gmail.com> <14F384C7-1900-408F-9289-05173A8C1BC1@oracle.com>
In-Reply-To: <14F384C7-1900-408F-9289-05173A8C1BC1@oracle.com>
From:   Jan Kasiak <j.kasiak@gmail.com>
Date:   Wed, 27 Jul 2022 13:20:13 -0400
Message-ID: <CAD15GZfOqca-jBN11o2b6iVeWU5hFXXB6oj55wYEWWgwK6VKdA@mail.gmail.com>
Subject: Re: NLM 4 Infinite Loop Bug
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Chuck,

I created 3 bugs:

https://bugzilla.linux-nfs.org/show_bug.cgi?id=390
For the original issue I reported with FREE_ALL
because I'm not sure if its fully fixed.

https://bugzilla.linux-nfs.org/show_bug.cgi?id=391
For scenario A

https://bugzilla.linux-nfs.org/show_bug.cgi?id=392
For scenario B/C because they are very similar

Thanks,
-Jan

On Tue, Jul 26, 2022 at 1:34 PM Chuck Lever III <chuck.lever@oracle.com> wrote:
>
> Hello Jan-
>
> > On Jul 26, 2022, at 1:16 PM, Jan Kasiak <j.kasiak@gmail.com> wrote:
> >
> > Hi all,
> >
> > Even after applying the above two patches, I have discovered a new set
> > of NLM 4 requests that break lockd.
> >
> > Unfortunately, I don't have enough experience to suggest a fix, but
> > would be glad to test anyone's attempt.
> >
> > All requests are non-blocking.
> >
> > Scenario A
> > =========
> > lock(offset=UINT64_MAX, len=100) - GRANTED
> > free_all() - never finishes and lockd thread is stuck busy looping
> >
> > Scenario B
> > ========
> > lock(svid=1, offset=UINT64_MAX, len=100) - GRANTED
> >
> > test(svid=2, offset=UINT64_MAX, len=50) - DENIED
> > correct, holder offset, len are (UINT64_MAX, 100)
> >
> > test(svid=2, offset=75, len=10) - DENIED
> > wrong, because holder (offset, len) are wrong (UINT64_MAX, 100),
> > because the above
> > lock overflows during comparison to (49, 50)
> >
> > Scenario C
> > ========
> > lock(svid=1, offset=UINT64_MAX, len=100) - GRANTED
> >
> > test(svid=2, offset=UINT64_MAX, len=50) - DENIED
> > correct, holder offset, len are (UINT64_MAX, 100)
> >
> > unlock(svid=1, offset=UINT64_MAX, len=50) - GRANTED
> > weird, because it has now created a lock at (offset=UINT64_MAX + 50, len=50)
> > not sure what the correct behavior should be here - FBIG error?
> >
> > test(svid=2, offset=75, len=10) - DENIED
> > wrong, because holder offset, len are wrong (49, 50), because the above
> > unlock has overflowed the offset
>
> Thanks for testing.
>
> May I ask that you file these as three separate bugs here:
>
> https://bugzilla.linux-nfs.org/
>
>
>
> --
> Chuck Lever
>
>
>
