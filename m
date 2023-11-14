Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2710B7EAD0F
	for <lists+linux-nfs@lfdr.de>; Tue, 14 Nov 2023 10:32:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231382AbjKNJcR (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 14 Nov 2023 04:32:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230271AbjKNJcR (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 14 Nov 2023 04:32:17 -0500
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F21C518E
        for <linux-nfs@vger.kernel.org>; Tue, 14 Nov 2023 01:32:12 -0800 (PST)
Received: by mail-yb1-xb30.google.com with SMTP id 3f1490d57ef6-d9a4c0d89f7so5689659276.1
        for <linux-nfs@vger.kernel.org>; Tue, 14 Nov 2023 01:32:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dneg.com; s=google; t=1699954332; x=1700559132; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qvpqkRiLE7bv7mvMuYtgpCgALDCW5o5I9QnxEKtqklY=;
        b=CIGAd1tcnh1Fd0g7pvL6q0bwRS6xznxK3VuWsCYcL6DbBUVqEnmTITIqyYIYRrl4iT
         1olQS8q6D6q3UWzSNrx/JdUkc65hmmSm+EGRFhiKh0p0G+/d5D6pCDu6veiJrrArOkiF
         8Bnmz/bdpmMSHyTK8WYOstRgSaVV6ehTOXTP9/4gvRlx8Fc5puaGi8Jbk15MtdMInhRk
         s6fh2T40kZV79M/pi60mYaF9kpvyJamo4ghMQ5ozvra8l1OAvWVJ1xctsf36PuWLfMUx
         cIcFpaJLyJu1WiIUwO6+DxiSbdWPzmQwSz8K7O//5w7PJxUeCqLz4FQGCNHHCuYglTz1
         pEGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699954332; x=1700559132;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qvpqkRiLE7bv7mvMuYtgpCgALDCW5o5I9QnxEKtqklY=;
        b=YX9rv6jXUGb8gQmlJQhVHemTnrzXV4S2wZTvL3XvDcvN2byGlz7fm0WyOL1/ctxldK
         rsEfDQqQ0IdqAqSxZ0IOOkyTvBC0MdGvEc8v+5tjZtiY1TXTgS/zEnuiC+Ylhxn41Yqm
         67v9jUd7HwwwWpJ1ONUHbsNsjr+JBxkFDmro6QTjJFqDjwQE4cxDjFPSI25HFhUHGthr
         ymZtGu7snAKJ5+z7sB2hzatq/OM6pcKQvcBxluAJZbZgRIvk9l1iSu8iQzwEx052qFLQ
         H2Eb6GOujnemPXwqLZLm7LIebUJxeX9YSGsRql8hNaBTukEHM4kF8aaEQLimUUV9NLvX
         f9iQ==
X-Gm-Message-State: AOJu0Ywo7KJoJNmFDEi4Tq7Ahal6irr8QHkOboqh08/wT6ui8EMeQCWc
        3HHviEsJYB58rHvzGHwfPxtqRHtLJWm4Lr+IACKI7QHEeDdie2H4
X-Google-Smtp-Source: AGHT+IGlBkM00dR3aCknQwH7AKO+cAlGo5DebW6eI4t09Mk9q6aE5Vn8RdyOGr1qgnlJ6clGu/N1ybv9+SpotOuXwAE=
X-Received: by 2002:a25:2086:0:b0:d81:754a:7cb8 with SMTP id
 g128-20020a252086000000b00d81754a7cb8mr8293202ybg.65.1699954332129; Tue, 14
 Nov 2023 01:32:12 -0800 (PST)
MIME-Version: 1.0
References: <20230828055324.21408-1-chengen.du@canonical.com>
 <6b4e6cd5-5711-4033-b813-2f8048c35921@redhat.com> <4bbbb46c1d2311143f590e57c04c7692e95c04ce.camel@hammerspace.com>
 <cf245bf9-0674-4ee4-8b9d-044dd656977c@redhat.com>
In-Reply-To: <cf245bf9-0674-4ee4-8b9d-044dd656977c@redhat.com>
From:   Daire Byrne <daire@dneg.com>
Date:   Tue, 14 Nov 2023 09:31:36 +0000
Message-ID: <CAPt2mGPyBXgCF6s+HsqbdVLtEBidun_ukE=uhE-kOXO=5OOv-w@mail.gmail.com>
Subject: Re: [PATCH v3] nfs(5): adding new mount option 'fasc'
To:     Steve Dickson <steved@redhat.com>
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        "chengen.du@canonical.com" <chengen.du@canonical.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Sat, 11 Nov 2023 at 14:45, Steve Dickson <steved@redhat.com> wrote:
>
>
>
> On 11/10/23 2:08 PM, Trond Myklebust wrote:
> > On Fri, 2023-11-10 at 11:54 -0500, Steve Dickson wrote:
> >> Hello,
> >>
> >> My apologies on this delay...
> >>
> >> On 8/28/23 1:53 AM, Chengen Du wrote:
> >>> Add an option that triggers the clearing of the file
> >>> access cache as soon as the cache timestamp becomes
> >>> older than the user's login time.
> >>>
> >>> Signed-off-by: Chengen Du <chengen.du@canonical.com>
> >> On a 6.7-rc0 kernel I'm getting "nfs: Unknown parameter 'fasc'"
> >> error... was this never implemented?
> >>
> >
> > No. There are no plans to add any mount parameters for this
> > functionality.
> Thank you!

Just to add, we still revert the patches that changed the default
behaviour from v6.2 onwards.

We found that the access cache not only gets wiped by interactive user
logins, but also various automated processes (e.g. sar/systat
collection) that also frequently "login" across all our clients.

When you scale this up across thousands of clients (render farm), the
result was a 40% increase in (ACCESS) IOPs to our netapps and a 20%
increase in their CPU usage. So we will continue to revert the patches
for as long as we can.

Cheers,

Daire
