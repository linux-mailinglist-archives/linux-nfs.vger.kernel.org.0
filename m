Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72CC37DE068
	for <lists+linux-nfs@lfdr.de>; Wed,  1 Nov 2023 12:38:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235292AbjKALi6 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 1 Nov 2023 07:38:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235212AbjKALi5 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 1 Nov 2023 07:38:57 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 415F0F7;
        Wed,  1 Nov 2023 04:38:55 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-5a7afd45199so68560487b3.0;
        Wed, 01 Nov 2023 04:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698838734; x=1699443534; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m59jZyxH1gZ4IkJNBzdNka8KVbsaoVT0nyeW9BoP3MY=;
        b=AbceKytzbEm1fI6aJYaC1xgszi8ZaazKEewzYxEeIa1ryBQcvsQOrXMWoRCCtA1pZ9
         xsRT6HfikEC13gutV14GgKFexrHw2ErdRcXEw++19GFKFn/iXSFPWGwtpeKOuMLORAzi
         ImKVLOFcGgiDOvJXQ32c1gkFN1dQQzDLOsMu3J+UnF7O3wv8vr1GwiMK8t7yGT2YAA/1
         x2fXufvwli5f4k3NfrLLRrTf0Uy6j+9QGZYKKngmgwzcwK8BEG6HM+qRZ01lphBr1EwC
         L6OAQEEoL8mSAmPJ2a/3hyHMhcOyEbVTQRf1qzR64eVYw2+n0hcBKelPoQZiXZ9yrGdB
         KLSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698838734; x=1699443534;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m59jZyxH1gZ4IkJNBzdNka8KVbsaoVT0nyeW9BoP3MY=;
        b=LHuLGLA8sPOhw2N+B3J0HXaBHCsw8MH1HJbkNQinAYvMIvK0Wztp2A7OnjDfd0G3/e
         oGQvx+++BBKadAQXF0fEQ25qFn2uaR7E7oUdXrQYLGCEErqZiRQZbCJcORCsaHFsWrrj
         j99x9CRlXGGDPjEZqUnracHP9iMiDaOWAq9VKYEmzKwaqqqfeFphMFowsJPbOSldYyPe
         C5vaRYCvi55jtgMei4TBIrEh28xNEcpB7t7EqFt4/zwMrGf39NER4jhZgbbQfjSFKqEr
         AmBf/XONrEgGmHYQGnyK1qYKX+WpGl6QJ2P8624oiDB6rZqpcw8oKjomIPn2xcpwZynr
         g9Cw==
X-Gm-Message-State: AOJu0Yy4kgZCJ7nwc78gR/YwxCT+a6wRIpxzf3doDasep0DvBKOXx73Q
        DW0nuY+B5+tVKC+2dwiz2pcj5VLL2R3g3K2bTmM=
X-Google-Smtp-Source: AGHT+IGPiQGs2flMchmrpUm3exXHwdHaIxqaR1nEgkE1E5+9YOWUy0Mc758PsX3a/8WhBl38xRZWvkoZHjkiwWqRbg8=
X-Received: by 2002:a81:ae09:0:b0:5a7:dad7:61dd with SMTP id
 m9-20020a81ae09000000b005a7dad761ddmr15318204ywh.20.1698838734410; Wed, 01
 Nov 2023 04:38:54 -0700 (PDT)
MIME-Version: 1.0
References: <ZTjMRRqmlJ+fTys2@dread.disaster.area> <2ef9ac6180e47bc9cc8edef20648a000367c4ed2.camel@kernel.org>
 <ZTnNCytHLGoJY9ds@dread.disaster.area> <6df5ea54463526a3d898ed2bd8a005166caa9381.camel@kernel.org>
 <ZUAwFkAizH1PrIZp@dread.disaster.area> <CAHk-=wg4jyTxO8WWUc1quqSETGaVsPHh8UeFUROYNwU-fEbkJg@mail.gmail.com>
 <ZUBbj8XsA6uW8ZDK@dread.disaster.area> <CAOQ4uxgSRw26J+MPK-zhysZX9wBkXFRNx+n1bwnQwykCJ1=F4Q@mail.gmail.com>
 <3d6a4c21626e6bbb86761a6d39e0fafaf30a4a4d.camel@kernel.org>
 <ZUF4NTxQXpkJADxf@dread.disaster.area> <20231101101648.zjloqo5su6bbxzff@quack3>
In-Reply-To: <20231101101648.zjloqo5su6bbxzff@quack3>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 1 Nov 2023 13:38:41 +0200
Message-ID: <CAOQ4uxgGxtErFEcSdxoFDnZZ1XfmVKn2LT1dQcJqhNj5_rnC6A@mail.gmail.com>
Subject: Re: [PATCH RFC 2/9] timekeeping: new interfaces for multigrain
 timestamp handing
To:     Jan Kara <jack@suse.cz>
Cc:     Dave Chinner <david@fromorbit.com>,
        Jeff Layton <jlayton@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
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
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Nov 1, 2023 at 12:16=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
>
> On Wed 01-11-23 08:57:09, Dave Chinner wrote:
> > 5. When-ever the inode is persisted, the timestamp is copied to the
> > on-disk structure and the current change counter is folded in.
> >
> >       This means the on-disk structure always contains the latest
> >       change attribute that has been persisted, just like we
> >       currently do with i_version now.
> >
> > 6. When-ever we read the inode off disk, we split the change counter
> > from the timestamp and update the appropriate internal structures
> > with this information.
> >
> >       This ensures that the VFS and userspace never see the change
> >       counter implementation in the inode timestamps.
>
> OK, but is this compatible with the current XFS behavior? AFAICS currentl=
y
> XFS sets sb->s_time_gran to 1 so timestamps currently stored on disk will
> have some mostly random garbage in low bits of the ctime. Now if you look
> at such inode with a kernel using this new scheme, stat(2) will report
> ctime with low bits zeroed-out so if the ctime fetched in the old kernel =
was
> stored in some external database and compared to the newly fetched ctime,=
 it
> will appear that ctime has gone backwards... Maybe we don't care but it i=
s
> a user visible change that can potentially confuse something.

See xfs_inode_has_bigtime() and auto-upgrade of inode format in
xfs_inode_item_precommit().

In the case of BIGTIME inode format, admin needs to opt-in to
BIGTIME format conversion by setting an INCOMPAT_BIGTIME
sb feature flag.

I imagine that something similar (inode flag + sb flag) would need
to be done for the versioned-timestamp, but I think that in that case,
the feature flag could be RO_COMPAT - there is no harm in exposing
made-up nsec lower bits if fs would be mounted read-only on an old
kernel, is there?

The same RO_COMPAT feature flag could also be used to determine
s_time_gran, because IIUC, s_time_gran for timestamp updates
is uniform across all inodes.

I know that Dave said he wants to avoid changing on-disk format,
but I am hoping that this well defined and backward compat with
lazy upgrade, on-disk format change may be acceptable?

Thanks,
Amir.
