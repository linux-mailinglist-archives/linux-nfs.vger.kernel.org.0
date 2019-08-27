Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A8079E3A2
	for <lists+linux-nfs@lfdr.de>; Tue, 27 Aug 2019 11:06:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729481AbfH0JFm (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 27 Aug 2019 05:05:42 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:36891 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725805AbfH0JFm (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 27 Aug 2019 05:05:42 -0400
Received: by mail-io1-f65.google.com with SMTP id q22so44596382iog.4
        for <linux-nfs@vger.kernel.org>; Tue, 27 Aug 2019 02:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=zadara-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=41s+ql3XXic7BH9K4S+zEsnCGvy2BPURvUIjyI9LDhU=;
        b=lDPxKt1W3HqHa27DUHtgHs9SYK2JwDJLI6eTjHk80ThnTwgbROWNqJGw3EpOSmXZIn
         VV7Vm6I1pnqpLhAlzn04tnYQR9+Hel0ObDWQW2OoJRTjouvNne7udNSeIZOo13Al/UcB
         Pl73y0IM6t6tZ6tFGYLGhDs33qlbgbFxLyXs3m1D0Jm3QCZZ65fpBHyUP1h6XZiV2+rZ
         xbQe+kpcBByKF9mfE195p6z641BV2oZjJRePX7iMtl3mPjaFMb2ffLjg/ph1Lgf4+dzp
         UlW8D+8bcKnfzVs24CkjJcfvwNAj4SxetNqvnugqmvG5z81OnBYuexq7oPRXspwiY3eF
         bSUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=41s+ql3XXic7BH9K4S+zEsnCGvy2BPURvUIjyI9LDhU=;
        b=gAilNPF01evtKaxDert3onG2tnAJBT/Zw0fqNxZ1UhLyZY9bqbuOtdPv70GcqAKSWs
         qO4oK6a+c+aPm2nMyCxFZOkvFFmuJx0pe0M2BkQjkamFX4dbXuCWJUSSsxUfqK9G08+O
         83oTj6LaA46dJZHyuOiacQ3F/W4AG4ePZLU0JJRA+GmVvVslJUBxsSb91tHM4Q3WUO+s
         burb1H2UqcQM7yeS1osYfJtlQjdB6Z+MLhTHQPbps4BNi4zMJ0H9/din/spWgGz9wvlf
         wLt7R9CmQpXh3bdBCuWA01VM/YpDvvwku134K2QYic3GelIEfVtdLX8rxIGZKk4TYJ+F
         PWPQ==
X-Gm-Message-State: APjAAAWBYIwCrhHPJ2T9WgqZZPMgDyae5IDsA8E+BDAJNLlHV61XPYkz
        xXUWygygPo4GCTiCr65ncVcpAYh/zSYXI6afYqkCmQ==
X-Google-Smtp-Source: APXvYqwtlixYRlc+Ezw0oYO/OHCnnYil+P2vE1jwbuLAFUET4dltU+wvE1qJYteFMi/hNem8ddphAEOU1p0v9iVbddc=
X-Received: by 2002:a6b:f30b:: with SMTP id m11mr5769906ioh.214.1566896740446;
 Tue, 27 Aug 2019 02:05:40 -0700 (PDT)
MIME-Version: 1.0
References: <1566406146-7887-1-git-send-email-alex@zadara.com>
 <CAOcd+r0bXefi79dnwrwsDN1OecScfTjc8DYS5_9A8D5XKrh7QQ@mail.gmail.com> <20190826133951.GC22759@fieldses.org>
In-Reply-To: <20190826133951.GC22759@fieldses.org>
From:   Alex Lyakas <alex@zadara.com>
Date:   Tue, 27 Aug 2019 12:05:28 +0300
Message-ID: <CAOcd+r059fh7J8T=6MdjPSCP39K5fpOZTsXZDUKq5TrPv_RcVQ@mail.gmail.com>
Subject: Re: [RFC-PATCH] nfsd: when unhashing openowners, increment
 openowner's refcount
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     chuck.lever@oracle.com, linux-nfs@vger.kernel.org,
        Shyam Kaushik <shyam@zadara.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Bruce,

Thank you for your response.

On Mon, Aug 26, 2019 at 4:39 PM J. Bruce Fields <bfields@fieldses.org> wrote:
>
> On Sun, Aug 25, 2019 at 01:12:34PM +0300, Alex Lyakas wrote:
> > You are listed as maintainers of nfsd. Can you please take a look at
> > the below patch?
>
> Thanks!
>
> I take it this was found by some kind of code analysis or fuzzing, not
> use in production?

We are hitting the following issue in production quite frequently:
- We create two local file systems FS1 and FS2 on the server machine S
- We export both FS1 and FS2 through nfsd to the same nfs client,
running on client machine C
- On C, we mount both exported file systems and start writing files to
both of them
- After few minutes, on server machine S, we un-export FS1 only. We
don't unmount FS1 on the client machine C prior to un-exporting. Also,
FS2 remains exported to C.
- We want to unmount FS1 on the server machine S, but we fail, because
there are still open files on FS1 by nfsd.

Debugging this issue showed the following root cause: we have a
nfs4_client entry for the client C. This entry has two
nfs4_openowners, for FS1 and FS2, although FS1 was un-exported.
Looking at the stateids of both openowners, we see that they have
stateids of kind NFS4_OPEN_STID, and each stateid is holding a
nfs4_file. The reason we cannot unmount FS1, is because we still have
an openowner for FS1, holding open-stateids, which hold open files on
FS1.

The laundromat doesn't help in this case, because it can only decide
per-nfs4_client that it should be purged. But in this case, since FS2
is still exported to C, there is no reason to purge the nfs4_client.

This situation remains until we un-export FS2 as well. Then the whole
nfs4_client is purged, and all the files get closed, and we can
unmount both FS1 and FS2.

We started looking around, and we found the failure injection code
that can "forget openowners". We wrote some custom code that allows us
to select the openowner which is not needed anymore. And then we
unhash this openowner, we unhash and close all of its stateids. Then
the files get closed, and we can unmount FS1.

Is the described issue familiar to you? It is very easily
reproducible. What is the way to solve it? To our understanding, if we
un-export a FS from nfsd, we should be able to unmount it.

For example, can we introduce a sysfs or procfs entry that will list
all clients and openowners. Then we add another sysfs entry allowing
the user to "forget" a particular openowner? If you feel this is the
way to move forward, we can try to provide patches for review.

Thanks,
Alex.







>
> Asking because I've been considering just deprecating it, so:
>
> > > After we fixed this, we confirmed that the openowner is not freed
> > > prematurely. It is freed by release_openowner() final call
> > > to nfs4_put_stateowner().
> > >
> > > However, we still get (other) random crashes and memory corruptions
> > > when nfsd_inject_forget_client_openowners() and
> > > nfsd_inject_forget_openowners().
> > > According to our analysis, we don't see any other refcount issues.
> > > Can anybody from the community review these flows for other potentials issues?
>
> I'm wondering how much effort we want to put into tracking all that
> down.
>
> --b.
