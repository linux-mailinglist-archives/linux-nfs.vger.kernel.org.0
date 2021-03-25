Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74C46349788
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Mar 2021 18:04:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229524AbhCYRDc (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 25 Mar 2021 13:03:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbhCYRDP (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 25 Mar 2021 13:03:15 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BBC2C06174A
        for <linux-nfs@vger.kernel.org>; Thu, 25 Mar 2021 10:03:15 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id k128so1572767wmk.4
        for <linux-nfs@vger.kernel.org>; Thu, 25 Mar 2021 10:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kPjImxbc0j16YTDsctlF5QenHzAq8GpQ8k5qI+eI3cw=;
        b=B14a6J3YTMWA2ZQsYlzpWgY91J3F1t9bvaIXfwGSm/YkGTf3wvIRfOjm4LiggD55R8
         B41RE0W4JnD9ZHJBIHDYEYmVULtpK9mYRp58QSYod76m5g6MueM2ZS7uYM7fIEXLMGFu
         DI6RUJYpNDjIVTaYg70C9iBNnl241dtpK1xzIJizE23dna/HAHxyvNrKzOLQb5X3L/YD
         lMv6LZWxdqdo08EoYz44FdkOtJgYuKnpDfAfqEr4MGtIkz1sCVVlkBBu+igiF82bYbpD
         qTpfvgHaKY6qwIBSoTX0V3Q3l1IHN6dB4CvgmUjNrOxJa6BjoVNxllUVQdJHdpAAbkPj
         nPng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kPjImxbc0j16YTDsctlF5QenHzAq8GpQ8k5qI+eI3cw=;
        b=uMOzaICjG5LWtilGOo+oriBw9E+31n8A4oIHqllbPLivoqK/jkWwt1Lr11HRnE7KYQ
         iAROdL6pmdw3DJg/hLU5DqLjCZAlpy4hJCYpVbKd9weDvH3KeiGyP+sGV1LI+QnyzGin
         MQpQicu5OoV96zKmx0gy0PyUIb3bknayLt67+daCl1kgL0A2NTryiFZHB+aEiOUtZuaY
         7XcMuCSdMeteAJKv2Yn2D+yV4H1hIndtqHIMtKE4hr0SrKBRjGbmJ/Ir1da5VlNC6aiU
         PB5ON0O1ysNoM/Gixd03U/OYMmmSLJelRa2SrdNLGqPtRJMe39aG7XAHcA7fN9zqgrV/
         +/2w==
X-Gm-Message-State: AOAM533SJgwmuG5SEGwgypxWfZvqZW59lpjrOZQFbLCXHXoySVuC+e+z
        jvqEhKwTZMqQpSSY6U42L34UF2UadIuJUfxK2hB4utNn
X-Google-Smtp-Source: ABdhPJyLUHuwNsavzguMNPIWjKXpOPcMK7MDzqvn4GDQbLPsSp9aejGkHlqNoYPeYq52SgPL2mclOFR3Nc/y2bzI0SQ=
X-Received: by 2002:a1c:7ed4:: with SMTP id z203mr8572194wmc.89.1616691794199;
 Thu, 25 Mar 2021 10:03:14 -0700 (PDT)
MIME-Version: 1.0
References: <CAD8zhTB-ie445UwCJnd9qW242EzcFX9SuWJxvaU3KnB1h-dFyg@mail.gmail.com>
 <A33B308D-1B41-4125-96A9-5DF19816D571@oracle.com>
In-Reply-To: <A33B308D-1B41-4125-96A9-5DF19816D571@oracle.com>
From:   Pradeep <pradeepthomas@gmail.com>
Date:   Thu, 25 Mar 2021 10:03:03 -0700
Message-ID: <CAD8zhTC9Bk7GQoUtCz4FstknKEnyw4H1DsZXzUeekR5Bpgkkpw@mail.gmail.com>
Subject: Re: NFSv4 referrals with FQDN.
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Thanks Chuck for confirming that. I will try to post a patch after testing.

On Wed, Mar 24, 2021 at 12:20 PM Chuck Lever III <chuck.lever@oracle.com> wrote:
>
>
>
> > On Mar 23, 2021, at 5:56 PM, Pradeep <pradeepthomas@gmail.com> wrote:
> >
> > Hello,
> >
> > While testing NFSv4 referrals, I noticed that if the server name in FS
> > locations does not have IPv4 mapping (server name has AAAA record for
> > IPv6; but no A record in DNS), the referral mount fails.
>
> IIRC, that is a known bug, but it has been rarely hit up to this point
> (only case I'm aware of is during testing, which is how I know about
> this issue).
>
> The DNS upcall needs to be fixed to handle this case properly. As Bruce
> likes to say, patches welcome!
>
>
> > With debug enabled, I get something like this:
> >
> > nfs_follow_referral: referral at /nfs_export_1
> > nfs4_path: path server-1.domain.com:/nfs_export_1 from nfs_path
> > nfs4_path: path component /nfs_export_1
> > nfs4_validate_fspath: comparing path /nfs_export_1 with fsroot /nfs_export_1
> > ==> dns_query((null),server-2.domain.com,19,(null))
> > call request_key(,server-2.domain.com,)
> > <== dns_query() = -126
> > nfs_follow_referral: done
> > nfs_do_refmount: done
> > RPC:       shutting down nfs client for server-1.domain.com
> > RPC:       rpc_release_client(ffff97fdf170c600)
> > RPC:       destroying nfs client for server-1.domain.com
> > <-- nfs_d_automount(): error -2
> >
> > It looks like NFS client does an upcall to "/sbin/key.dns_resolver".
> > "/sbin/key.dns_resolver" works if callout info is set to 'ipv6'.
> > Otherwise it fails too.
> >
> > Does this mean setups with only IPv6 records (AAAA records in DNS),
> > NFSv4 referrals won't work if server returns FQDN in referral? If
> > anyone has tried this and made it work, please let me know.
> >
> > Thanks,
> > Pradeep
>
> --
> Chuck Lever
>
>
>
