Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94BE77DE706
	for <lists+linux-nfs@lfdr.de>; Wed,  1 Nov 2023 22:08:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348033AbjKAUK6 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 1 Nov 2023 16:10:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347764AbjKAUK4 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 1 Nov 2023 16:10:56 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B2E918F
        for <linux-nfs@vger.kernel.org>; Wed,  1 Nov 2023 13:10:45 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2c50d1b9f22so2548751fa.0
        for <linux-nfs@vger.kernel.org>; Wed, 01 Nov 2023 13:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1698869443; x=1699474243; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NBWFFWWFL2IpGLUFcCc1X6zcQFWEtkQQEaX3iixgj/k=;
        b=SXyYzxp8gd70+wOka2N7MlQPugrq/l1Y1NAu89XkfaR02c7Nw9r1J6RVtmeDX/vu3G
         SBT/O58os/JXeRRMltFQLZolKfXM9Vcm88XSAA2YOykS8ajUe7fxh3ovvR7zjEZY2QBR
         5uYF5EB8vLYWuRiDLZ5lF8Ufr7aJHPmWhDbRY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698869443; x=1699474243;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NBWFFWWFL2IpGLUFcCc1X6zcQFWEtkQQEaX3iixgj/k=;
        b=DLaGYm+au+V62+ZAxW3cS2d2JwUxjNV8Eb6aohZ09w6fx7zemsc7FrsqqlgtiS1Gaw
         6f0QyhN8td22vY4TjfDj6BNHMWyHohN2tSY7fglqzbwyDtxbgE7EvYocikCCTHWwHpsp
         XyxxVD1zDNMoYyiOehmjLOc3Ke3X9UnRDP9dsmDKfy7Z831lv5/+1JE3G815td1C/Fgc
         a3MnAYlCpTPIFV1A8BIMpZHAddnVzNn9wUggtyolbmNr14UGn/M8imjfSo1pdUAnPxc9
         7tEJ+bCDf/EskkZrl3Na+aoF34rBQomQfOR+tH94YhDyDwCaS+q380rwH07guNpL534C
         MNLA==
X-Gm-Message-State: AOJu0YydWDRv4OZ7PzURz+RoA0Q88bgwUmiw86rHIJD9YcmvBwgTkEeI
        DwR7snLjf/7sNRXKukeXvEVzS14k9ZAazhnN/XFkMQ==
X-Google-Smtp-Source: AGHT+IHQ1NgRnjSIwxGKf37VB4qCi3gjPZ0hTy9S4biFyjhskKamzPqdYqLhI99siueX04z8NnAqew==
X-Received: by 2002:a05:651c:205:b0:2bc:c28c:a2b8 with SMTP id y5-20020a05651c020500b002bcc28ca2b8mr12598723ljn.27.1698869443515;
        Wed, 01 Nov 2023 13:10:43 -0700 (PDT)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id d11-20020a05651c01cb00b002c1256558bdsm290711ljn.5.2023.11.01.13.10.42
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Nov 2023 13:10:43 -0700 (PDT)
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2c6b30aca06so2266471fa.3
        for <linux-nfs@vger.kernel.org>; Wed, 01 Nov 2023 13:10:42 -0700 (PDT)
X-Received: by 2002:a17:907:25c6:b0:9b2:82d2:a2db with SMTP id
 ae6-20020a17090725c600b009b282d2a2dbmr2496156ejc.28.1698869421474; Wed, 01
 Nov 2023 13:10:21 -0700 (PDT)
MIME-Version: 1.0
References: <ZTjMRRqmlJ+fTys2@dread.disaster.area> <2ef9ac6180e47bc9cc8edef20648a000367c4ed2.camel@kernel.org>
 <ZTnNCytHLGoJY9ds@dread.disaster.area> <6df5ea54463526a3d898ed2bd8a005166caa9381.camel@kernel.org>
 <ZUAwFkAizH1PrIZp@dread.disaster.area> <CAHk-=wg4jyTxO8WWUc1quqSETGaVsPHh8UeFUROYNwU-fEbkJg@mail.gmail.com>
 <ZUBbj8XsA6uW8ZDK@dread.disaster.area> <CAOQ4uxgSRw26J+MPK-zhysZX9wBkXFRNx+n1bwnQwykCJ1=F4Q@mail.gmail.com>
 <3d6a4c21626e6bbb86761a6d39e0fafaf30a4a4d.camel@kernel.org>
 <ZUF4NTxQXpkJADxf@dread.disaster.area> <20231101101648.zjloqo5su6bbxzff@quack3>
In-Reply-To: <20231101101648.zjloqo5su6bbxzff@quack3>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 1 Nov 2023 10:10:03 -1000
X-Gmail-Original-Message-ID: <CAHk-=wj6wy6tNUQm6EtgxfE_J229y1DthpCguqQfTej71yiJXw@mail.gmail.com>
Message-ID: <CAHk-=wj6wy6tNUQm6EtgxfE_J229y1DthpCguqQfTej71yiJXw@mail.gmail.com>
Subject: Re: [PATCH RFC 2/9] timekeeping: new interfaces for multigrain
 timestamp handing
To:     Jan Kara <jack@suse.cz>
Cc:     Dave Chinner <david@fromorbit.com>,
        Jeff Layton <jlayton@kernel.org>,
        Amir Goldstein <amir73il@gmail.com>,
        Kent Overstreet <kent.overstreet@linux.dev>,
        Christian Brauner <brauner@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        John Stultz <jstultz@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Chandan Babu R <chandan.babu@oracle.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jan Kara <jack@suse.de>, David Howells <dhowells@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-mm@kvack.org,
        linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, 1 Nov 2023 at 00:16, Jan Kara <jack@suse.cz> wrote:
>
> OK, but is this compatible with the current XFS behavior? AFAICS currently
> XFS sets sb->s_time_gran to 1 so timestamps currently stored on disk will
> have some mostly random garbage in low bits of the ctime.

I really *really* don't think we can use ctime as a "i_version"
replacement. The whole fine-granularity patches were well-intentioned,
but I do think they were broken.

Note that we can't use ctime as a "i_version" replacement for other
reasons too - you have filesystems like FAT - which people do want to
export - that have a single-second (or is it 2s?) granularity in
reality, even though they report a 1ns value in s_time_gran.

But here's a suggestion that people may hate, but that might just work
in practice:

 - get rid of i_version entirely

 - use the "known good" part of ctime as the upper bits of the change
counter (and by "known good" I mean tv_sec - or possibly even "tv_sec
/ 2" if that dim FAT memory of mine is right)

 - make the rule be that ctime is *never* updated for atime updates
(maybe that's already true, I didn't check - maybe it needs a new
mount flag for nfsd)

 - have a per-inode in-memory and vfs-internal (entirely invisible to
filesystems) "ctime modification counter" that is *NOT* a timestamp,
and is *NOT* i_version

 - make the rule be that the "ctime modification counter" is always
zero, *EXCEPT* if
    (a) I_VERSION_QUERIED is set
   AND
    (b) the ctime modification doesn't modify the "known good" part of ctime

so how the "statx change cookie" ends up being "high bits tv_sec of
ctime, low bits ctime modification cookie", and the end result of that
is:

 - if all the reads happen after the last write (common case), then
the low bits will be zero, because I_VERSION_QUERIED wasn't set when
ctime was modified

 - if you do a write *after* a modification, the ctime cookie is
guaranteed to change, because either the known good (sec/2sec) part of
ctime is new, *or* the counter gets updated

 - if the nfs server reboots, the in-memory counter will be cleared
again, and so the change cookie will cause client cache invalidations,
but *only* for those "ctime changed in the same second _after_
somebody did a read".

 - any long-time caches of files that don't get modified are all fine,
because they will have those low bits zero and depend on just the
stable part of ctime that works across filesystems. So there should be
no nasty thundering herd issues on long-lived caches on lots of
clients if the server reboots, or atime updates every 24 hours or
anything like that.

and note that *NONE* of this requires any filesystem involvement
(except for the rule of "no atime changes ever impact ctime", which
may or may not already be true).

The filesystem does *not* know about that modification counter,
there's no new on-disk stable information.

It's entirely possible that I'm missing something obvious, but the
above sounds to me like the only time you'd have stale invalidations
is really the (unusual) case of having writes after cached reads, and
then a reboot.

We'd get rid of "inode_maybe_inc_iversion()" entirely, and instead
replace it with logic in inode_set_ctime_current() that basically does

 - if the stable part of ctime changes, clear the new 32-bit counter

 - if I_VERSION_QUERIED isn't set, clear the new 32-bit counter

 - otherwise, increment the new 32-bit counter

and then the STATX_CHANGE_COOKIE code basically just returns

   (stable part of ctime << 32) + new 32-bit counter

(and again, the "stable part of ctime" is either just tv_sec, or it's
"tv_sec >> 1" or whatever).

The above does not expose *any* changes to timestamps to users, and
should work across a wide variety of filesystems, without requiring
any special code from the filesystem itself.

And now please all jump on me and say "No, Linus, that won't work, because XYZ".

Because it is *entirely* possible that I missed something truly
fundamental, and the above is completely broken for some obvious
reason that I just didn't think of.

             Linus
