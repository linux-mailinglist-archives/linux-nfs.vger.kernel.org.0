Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4230430219
	for <lists+linux-nfs@lfdr.de>; Thu, 30 May 2019 20:41:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726125AbfE3Sl5 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 30 May 2019 14:41:57 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:33043 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726029AbfE3Sl5 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 30 May 2019 14:41:57 -0400
Received: by mail-ua1-f68.google.com with SMTP id f20so1213854ual.0
        for <linux-nfs@vger.kernel.org>; Thu, 30 May 2019 11:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1wi1CgXGczwmD2uWEiktyjAdwUJ1i7BhofFGP294Hns=;
        b=pchrlDFbzLuAznVU7JlAQRVpCUZETGglmMHT52PgRBywREcrS1UKM29hMPJnq1BmFp
         cIHe7Ma2u38d8NRbjaBjP5yb2/3L/O/0t3JkQbdVvXeBbp36lsdMCu7W6tvbGZeUmbrD
         R9qRYfVvQEYqE5jiJ7Z5OggFaY/zEwdFlcQN/UkwRcF0W00Qzo361+zLKP1xbUP0Xc9B
         IMeR0xItVgiQ93TkZYImnV3zcqqZaogYcOA2keGGMN5GtyO2RBVk3IyI76L8V77Sh2A2
         AYzHjchBsmwxpdPi1Z8e3mnIvZzSnJBTA+PQrm6vXBUlKh2m2OfXd6UGVluUuqOrLBPG
         EeIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1wi1CgXGczwmD2uWEiktyjAdwUJ1i7BhofFGP294Hns=;
        b=cCZirXX/E51h2JFeXFDuYGTI8HmoP5x88zsfVZtmzDJNcnISZb+4Nu8vM7dO0sIQLe
         wugQ93e2cmu8wxWtHygOSw//BwAJwGV+sjY0VSMMehA5eawquwezpu1lT7ZbtGFzX6vS
         4sS11snJShFv4w/SwIivfztEX6hwi+BC9rkdzXe9udzMmY8uMCVSbY/Ak/sWpEzo+XM9
         2VTuUs7nEMjyhPnWIvYv2MyH44vF4AO9Wq4mFRWCjPOuORKMVwb2KiOUmBZc16WN3NHD
         cA9rjbj0qY5IOFlfHaUxKsOCYl7lbWi87u9cz7aLsnY7eBDJvxDglaVFN0v59cfbRKxv
         K3gg==
X-Gm-Message-State: APjAAAUdPPmR/lWwp6xZkiIfj4rXdeEBxEtzvY4wYqym1gXiX4RUVqpf
        OeUTrtjTTUK4ID1nySjT+3Bti4hnNL9pqMVpy04=
X-Google-Smtp-Source: APXvYqwfOHwMJmd/blmB11PP4/t71Ka2/eBczZ9dGgfxGuBO7hy8mP4eDkSlshV1JJBxZWn1trZxOeHXbf02flGaN8E=
X-Received: by 2002:ab0:2447:: with SMTP id g7mr2790670uan.65.1559241716127;
 Thu, 30 May 2019 11:41:56 -0700 (PDT)
MIME-Version: 1.0
References: <155917564898.3988.6096672032831115016.stgit@noble.brown>
 <1df23ebc-ffe5-1a57-c40a-d5e9a45c8498@talpey.com> <CAN-5tyHUah=fAsiSLb=n__q5HxRy3qeS83evf-vB59r4cpYgsw@mail.gmail.com>
 <9b64b9d9-b7cf-c818-28e2-58b3a821d39d@talpey.com>
In-Reply-To: <9b64b9d9-b7cf-c818-28e2-58b3a821d39d@talpey.com>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Thu, 30 May 2019 14:41:44 -0400
Message-ID: <CAN-5tyEBb3_TLvuN49FBB6qz2kXSZLPxHYZfQQX0jU4qFt4Z4A@mail.gmail.com>
Subject: Re: [PATCH 0/9] Multiple network connections for a single NFS mount.
To:     Tom Talpey <tom@talpey.com>
Cc:     NeilBrown <neilb@suse.com>, Chuck Lever <chuck.lever@oracle.com>,
        Schumaker Anna <Anna.Schumaker@netapp.com>,
        Trond Myklebust <trondmy@hammerspace.com>,
        linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, May 30, 2019 at 1:41 PM Tom Talpey <tom@talpey.com> wrote:
>
> On 5/30/2019 1:20 PM, Olga Kornievskaia wrote:
> > On Thu, May 30, 2019 at 1:05 PM Tom Talpey <tom@talpey.com> wrote:
> >>
> >> On 5/29/2019 8:41 PM, NeilBrown wrote:
> >>> I've also re-arrange the patches a bit, merged two, and remove the
> >>> restriction to TCP and NFSV4.x,x>=1.  Discussions seemed to suggest
> >>> these restrictions were not needed, I can see no need.
> >>
> >> I believe the need is for the correctness of retries. Because NFSv2,
> >> NFSv3 and NFSv4.0 have no exactly-once semantics of their own, server
> >> duplicate request caches are important (although often imperfect).
> >> These caches use client XID's, source ports and addresses, sometimes
> >> in addition to other methods, to detect retry. Existing clients are
> >> careful to reconnect with the same source port, to ensure this. And
> >> existing servers won't change.
> >
> > Retries are already bound to the same connection so there shouldn't be
> > an issue of a retransmission coming from a different source port.
>
> So, there's no path redundancy? If any connection is lost and can't
> be reestablished, the requests on that connection will time out?

For v3 and v4.0 in the current code base with a single connection,
when it goes down, you are out of luck. When we have multiple
connections and would like the benefit of using them but not
sacrifices replay cache correctness, it's a small price to restrict
the re-transmissions and suffer the consequence of not being able to
do an operation during network issues.

> I think a common configuration will be two NICs and two network paths,

Are you talking about session trunking here?

Why do you think two NICs would be a common configuration. I have
performance numbers that demonstrate performance improvement for a
single NIC case. I would say a single NIC with a high speed networks
(25/40G) would be a common configuration.

> a so-called shotgun. Admins will be quite frustrated to discover it
> gives no additional robustness, and perhaps even less.
>
> Why not simply restrict this to the fully-correct, fully-functional
> NFSv4.1+ scenario, and not try to paper over the shortcomings?

I think mainly because customers are still using v3 but want to
improve performance. I'd love for everybody to switch to 4.1 but
that's not happening.

>
> Tom.
>
> >
> >> Multiple connections will result in multiple source ports, and possibly
> >> multiple source addresses, meaning retried client requests may be
> >> accepted as new, rather than having any chance of being recognized as
> >> retries.
> >>
> >> NFSv4.1+ don't have this issue, but removing the restrictions would
> >> seem to break the downlevel mounts.
> >>
> >> Tom.
> >>
> >
> >
