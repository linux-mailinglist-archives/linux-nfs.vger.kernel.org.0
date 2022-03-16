Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A2354DB5A9
	for <lists+linux-nfs@lfdr.de>; Wed, 16 Mar 2022 17:09:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344699AbiCPQKn (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 16 Mar 2022 12:10:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350013AbiCPQKm (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 16 Mar 2022 12:10:42 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABCC16D182
        for <linux-nfs@vger.kernel.org>; Wed, 16 Mar 2022 09:09:27 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id b24so3329581edu.10
        for <linux-nfs@vger.kernel.org>; Wed, 16 Mar 2022 09:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1wccu283m0j2cvhv5YfH/qsu7gZjC8CzYS7zLEvDWgw=;
        b=F9bUa1iIyg2dNDp3c0mEONmzBiiJLq+Dx12wELrZsXXWpVoa0PMj7epC6mclwcjFPE
         UA5IdO9YDD4lUZjcxq1ODS2t1LInzhlDv8+DyFQDXH9bq8GP8YIoN9WnqkXoZ0Uecl80
         vhwX9PEgr01GXQzONrmQw5HxYdjdACOAahtj89c2cQbsOJeZWHIOE8QYNhc8Jex4y5uF
         SU0Mm6P0KHg1A9XS1rxJyoaCXGSOeuUXdQZq0Kdc8uFdw1UyhRtn59GFxDLZLe2Ajr8q
         K5ks7GIQ4dVe3Sfrvpbtfyf6qGwFWSCSBnhRW3YtXyRrQz2/EU8OEBFsEig+AZuYtuOC
         ykyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1wccu283m0j2cvhv5YfH/qsu7gZjC8CzYS7zLEvDWgw=;
        b=SyiHVydEi51oQcT4MYuJ7kgJcRNtf8aW4CpFXjdBLAPCI3dLXv0d2ewdMm4mBK+yUf
         1JpTd1Q1NR8Bbcs58+5kb9J244VpoFAGTXeoHq3Ccy7aVwp2TTp/fkKtj/+ekNPtYgiw
         J6VbES5zFdTqzACsf/PJrL4wQydiIugyf8IEctMNvWqS9VK7+eNXvvhLawMuU9Fwk72u
         PhjqgIdMxS3x2Q5qsKaXvaN59z7Cbfy1C0vRV4M5PYRhAdDusoh8gNYmtdy2HWEZe4mP
         VxNdUw/DiIOfZAyoJQvwLxLc+NEo+fUbD9WAd2IHGUIlZVBc85rLrdhNnsCVP2Q6rM2B
         3O9w==
X-Gm-Message-State: AOAM530tdmw6MpXEZhK4wmoywzHLaAvOiWRvJP0/NfACvo6CvcsC7RbV
        w5sJpPvFfMBc8HzSQwFs9bNr16BmGZr5NooytKU=
X-Google-Smtp-Source: ABdhPJyWJtowu0Ci6WVZokg53Hu01BkcSDRa5VeZEcjw9zRTflrM3IqFcuvRj8Jph8sU1E1C7f94BPbjG2ISbeHzgi0=
X-Received: by 2002:a05:6402:42c9:b0:418:ac44:3418 with SMTP id
 i9-20020a05640242c900b00418ac443418mr193174edc.97.1647446965992; Wed, 16 Mar
 2022 09:09:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220223174041.77887-1-olga.kornievskaia@gmail.com>
 <CAN-5tyHy_+tBfv3PuD0CBwHbppHo3pRNwo0O9xRGjZxK0-rOjw@mail.gmail.com>
 <a494ba2b-7e2c-bcad-bac9-12804b113383@garloff.de> <B476B883-D5D4-4112-BB08-6D9172C5D335@garloff.de>
 <8849D8CD-0720-40E2-A752-1C9AADC93C55@redhat.com> <40CC442E-C228-4C66-A2F0-DB850DBC5EC5@oracle.com>
In-Reply-To: <40CC442E-C228-4C66-A2F0-DB850DBC5EC5@oracle.com>
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
Date:   Wed, 16 Mar 2022 12:09:14 -0400
Message-ID: <CAN-5tyHZ-7=V=CGT+Ni6DWZYbvXgpGoBn_sXeTg54YqhPZsufg@mail.gmail.com>
Subject: Re: [PATCH v1] NFSv4.1 provide mount option to toggle trunking discovery
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Benjamin Coddington <bcodding@redhat.com>,
        Kurt Garloff <kurt@garloff.de>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Mar 16, 2022 at 11:14 AM Chuck Lever III <chuck.lever@oracle.com> wrote:
>
>
>
> > On Mar 16, 2022, at 8:39 AM, Benjamin Coddington <bcodding@redhat.com> wrote:
> >
> > On 25 Feb 2022, at 17:48, Kurt Garloff wrote:
> >
> >> Hi,
> >>
> >> Am 24. Februar 2022 14:42:41 MEZ schrieb Kurt Garloff <kurt@garloff.de>:
> >>> Hi Olga,
> >>> [...]
> >>>
> >>> I see a number of possibilities to resolve this:
> >>> (0) We pretend it's not a problem that's serious enough to take
> >>>     action (and ensure that we do document this new option well).
> >>> (1) We revert the patch that does FS_LOCATIONS discovery.
> >>>     Assuming that FS_LOCATIONS does provide a useful feature, this
> >>>     would not be our preferred solution, I guess ...
> >>> (2) We prevent NFS v4.1 servers to use FS_LOCATIONS (like my patch
> >>>     implements) and additionally allow for the opt-out with
> >>>     notrunkdiscovery mount option. This fixes the known regression
> >>>     with Qnap knfsd (without requiring user intervention) and still
> >>>     allows for FS_LOCATIONS to be useful with NFSv4.2 servers that
> >>>     support this. The disadvantage is that we won't use the feature
> >>>     on NFSv4.1 servers which might support this feature perfectly
> >>>     (and there's no opt-in possibility). And the risk is that there
> >>>     might be NFSv4.2 servers out there that also misreport
> >>>     FS_LOCATIONS support and still need manual intervention (which
> >>>     at least is possible with notrunkdiscovery).
> >>> (3) We make this feature an opt-in thing and require users to
> >>>     pass trunkdiscovery to take advantage of the feature.
> >>>     This has zero risk of breakage (unless we screw up the patch),
> >>>     but always requires user intervention to take advantage of
> >>>     the FS_LOCATIONS feature.
> >>> (4) Identify a way to recover from the mount with FS_LOCATIONS
> >>>     against the broken server, so instead of hanging we do just
> >>>     turn this off if we find it not to work. Disadavantage is that
> >>>     this adds complexity and might stall the mounting for a while
> >>>     until the recovery worked. The complexity bears the risk for
> >>>     us screwing up.
> >>>
> >>> I personally find solutions 2 -- 4 acceptable.
> >>>
> >>> If the experts see (4) as simple enough, it might be worth a try.
> >>> Otherwise (2) or (3) would seem the way to go from my perspective.
> >>
> >> Any thought ls?
> >
> > I think (3) is the best way, and perhaps using sysfs to toggle it would
> > be a solution to the problems presented by a mount option.
> >
> > I'm worried that this issue is being ignored because that's usually what
> > happens when requests/patches are proposed that violate the policy of "we do
> > not fix the client for server bugs".  In this case that policy conficts with
> > "no user visible regressions".
> >
> > Can anyone declare which policy takes precedent?
>
> "No regressions" probably takes precedent. IMO 1) should be done
> immediately.
>
> This is not a server bug, necessarily. The server is responding
> within the realm of what is allowed by specification and I can
> see cases where a server might have a good reason to DELAY an
> fs_locations request for a while.
>
> So I think once 1) has been done and backported to stable, the
> client functionality should be restored via 4) to ensure that a
> server can't delay a client mount indefinitely. (Although I think
> I've stated that preference before).

Reverting the patch is equivalent to introducing a mount option (with
what I'm hearing a preference of notrunking being the default) but
possibly better. It solves the problems of the broken servers and it
allows servers that want this functionality to use it.

> I don't see any need to involve a human in making the decision
> to try fs_locations. The client should try fs_locations and if
> it doesn't work, just move on as quickly as it can. As always,
> I don't relish adding more administrative controls if we can
> avoid it. Such controls add to our test matrix and our long
> term technical debt. Easy to add, but very difficult to change
> or remove once merged. I can't see an upside here.
>
>
> --
> Chuck Lever
>
>
>
