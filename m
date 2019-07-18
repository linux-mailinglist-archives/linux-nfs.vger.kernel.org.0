Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D9CF6D69D
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Jul 2019 23:48:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727928AbfGRVsQ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 18 Jul 2019 17:48:16 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:40143 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727685AbfGRVsQ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 18 Jul 2019 17:48:16 -0400
Received: by mail-lj1-f193.google.com with SMTP id m8so28784015lji.7
        for <linux-nfs@vger.kernel.org>; Thu, 18 Jul 2019 14:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V90HhcWbibDdV+Hl4DqdmtK6PSYfay5zZUxbiy11qL8=;
        b=AbgndksikCBx58WAsi1ZczhBouPLUfbgjv2sLtcDmsg8pYFCnm2zhxh9h2WQ1oZOAa
         rQmJ9vzofCYprP8eVKn1nAZCuA6rj6P1X+ofHAMx8hqNbSoQpeXpkLPrni4gm2YCoC8t
         ZOy8gHGdwD8Q6udD5ij1jCGNlNuIpsQhmDFo8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V90HhcWbibDdV+Hl4DqdmtK6PSYfay5zZUxbiy11qL8=;
        b=UVQ4HaA3GotkvssD2xXkkSrQ+0WG/rZddk3ad4sRxEPp8W94M5e2nESYlGh4XrV9n4
         Ao2WQthIJtGeUAvXcKIpaTYzGt6LSzKDuFxiW67isMYoMOeJiE4Kq5g469B0w1CD12ge
         zNUjafKplt+uAnk3wYPunNMuhX83JhodFJql6Ims9cXBppiLTVznQo70EKptCh2iI1mS
         5eFKYS1ylz2ckVNUzXU0d8j1Rsbe7DlnwcQKY4/A8H1NGnFVJPGSn6VKP02JMAhhH00W
         kp08y3y5CDxNhKH5opyWiiOR0WV1E8TzH+bWFIlrN5Z27awsP+DjODCjf4iXBowf1YWl
         hg1Q==
X-Gm-Message-State: APjAAAX97+lKLDNIWnsnNH5jxFq+e++06GrYBboWRWEvBM7h8gXECwUF
        3Sq1Z2I6AlCYloli3F/MBElzBe3TUqc=
X-Google-Smtp-Source: APXvYqzNXJCo6s/FvBChshaqioXlPlZC/eEkarr52+blMpkvkm0nKcMsLC0D2Hc7/F1yHHQYVM/nUQ==
X-Received: by 2002:a2e:730d:: with SMTP id o13mr8192558ljc.81.1563486494083;
        Thu, 18 Jul 2019 14:48:14 -0700 (PDT)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id f30sm4134873lfa.48.2019.07.18.14.48.13
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Jul 2019 14:48:13 -0700 (PDT)
Received: by mail-lf1-f43.google.com with SMTP id c19so20282809lfm.10
        for <linux-nfs@vger.kernel.org>; Thu, 18 Jul 2019 14:48:13 -0700 (PDT)
X-Received: by 2002:ac2:5601:: with SMTP id v1mr22485468lfd.106.1563486492738;
 Thu, 18 Jul 2019 14:48:12 -0700 (PDT)
MIME-Version: 1.0
References: <333e896cf5bcadd8547fbe4a06388dd3104ff910.camel@hammerspace.com>
In-Reply-To: <333e896cf5bcadd8547fbe4a06388dd3104ff910.camel@hammerspace.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 18 Jul 2019 14:47:56 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiiLJ3r2t02iqCtMxTufTCpKrPBmQ_L7ePZ4f-MwJ8o6A@mail.gmail.com>
Message-ID: <CAHk-=wiiLJ3r2t02iqCtMxTufTCpKrPBmQ_L7ePZ4f-MwJ8o6A@mail.gmail.com>
Subject: Re: [GIT PULL] Please pull NFS changes for Linux 5.3
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Jul 18, 2019 at 1:25 PM Trond Myklebust <trondmy@hammerspace.com> wrote:
>
>   git://git.linux-nfs.org/projects/trondmy/linux-nfs.git tags/nfs-for-5.3-1

This got a conflict with the debugfs "don't behave differently on
failures" changes in net/sunrpc/debugfs.c.

See commit 0a0762c6c604 ("sunrpc: no need to check return value of
debugfs_create functions") by Greg, but I suspect you were already
aware of this.

I did a hack-and-slash "remove the error handling", and the end result
looks sane. Except I left the "if the snprintf overflows" error
handling in place, even if nothing then cares about the returned
error.

I think my merge resolution makes sense, but I thought I'd mention it
in case you had something else in mind. Honestly, the snprintf()
checks in do_xprt_debugfs() look kind o fpointless, but the comment is
also wrong:

        char link[9]; /* enough for 8 hex digits + NULL */

that comment was copied from the "name[]" array in
rpc_clnt_debugfs_register(), but it's bogus, since you actually use

                len = snprintf(link, sizeof(link), "xprt%d", *nump);

on the thing.

And you know what? If you have so many links that "xprt%d" doesn't fit
in 8 chars plus NUL, maybe you don't really care?

But it's also worth noting that the whole snprintf() overflow check is
*wrong* to begin with. When you do

                if (len > sizeof(link))
                        return -1;

you're testing the wrong thing entirely. The returned "len" is the
length that would have been printed _without_ the ending NUL
character, so you actually had a truncation even if it returns
"sizeof(link)" - because then the NUL character was written instead of
the last character.

So the overflow test *should* have been

                if (len >= sizeof(link))
                        return -1;

but I suspect the correct thing to do is to just say "we don't care"
and remove that error check entirely.  Same goes for the other case
("len > sizeof(name)").

At some point error handling doesn't actually add value, as long as
the error itself isn't fatal. And when the error handling itself is
wrong, it's doubly suspect.

But as mentioned, I did *not* remove this part of the error handling.
I only removed the debugfs parts. The error handling may be wrong, but
it is what it is, and it doesn't really matter.

                  Linus
