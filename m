Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7E807D4610
	for <lists+linux-nfs@lfdr.de>; Tue, 24 Oct 2023 05:40:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232156AbjJXDkq (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 23 Oct 2023 23:40:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230213AbjJXDko (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 23 Oct 2023 23:40:44 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A69CFD6
        for <linux-nfs@vger.kernel.org>; Mon, 23 Oct 2023 20:40:40 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1cab2c24ecdso24555925ad.0
        for <linux-nfs@vger.kernel.org>; Mon, 23 Oct 2023 20:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1698118840; x=1698723640; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oWeGYZJ7Zqr0SZ51s3Tlaj8JTzPWhfxnA67l062INq8=;
        b=Yka22y6GudilGqFN93hZ3gwUjSZ7fiAGVB18y4YS4VOx58FRysiSaOTltq7hIkbDBd
         HPXEDh59iJ3MMQ96QGEDnefC0uQijgkyObUH9MU4SVox2nSN+nx8v13NOTjz8p3rnxMY
         jD8H5GanpdTZOGT+9uo9YTlYuv2KagQsVwNsOG3qC3oci8YOhcZRYJ7jn0lz/Q/P6e27
         PLsZyIvvJ5kJ+BVqjs3Gpf3tuW9rtUzbWudkY7Z16SUUP/5epPAtS32tHEwpdoAZO2rj
         OZ5NlqtIiGQTPibS/tUMx/VVSgXuisk/853Fpn45b9rUTefWXD6Zy7yMeU/+HbSKPCG8
         H4Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698118840; x=1698723640;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oWeGYZJ7Zqr0SZ51s3Tlaj8JTzPWhfxnA67l062INq8=;
        b=Kszpda93K9ulHFtfQQBkXV1GipHcZqdgW6D4i1buI/o/YHtW4In57orwEAdYeHctsw
         tXyx0/OVZTYyRSF5mIY7TXAoLFfxUkh2iWcTo9A6g/W8gKTdqY2TCAs25RH5kaJZrgOp
         S8sHImoaBfvM5cgZbhC2bKbgYeA96usXjoUydc9jqnm0JN+yp+9PcUlmshssCJSk0+jT
         OE63lmYw93bQV/pD9h3DHh1HH+H9hT6b6xFfpEF5h6gcwlkf4ddxSKbp2urPVkPa4UGC
         Olz50DI5ySNX9zwW0Gjnv0SOtMaW/Q+70SO/vmyWzgkMbS22xy5kyZyiViBx2rww6m4f
         j9yg==
X-Gm-Message-State: AOJu0Yywh2GIbaunLR6sBS0tQvKY3rDhmnZavPbMUn8fdKq81BUXgck6
        2LTrBERBp7WPuKWyukGN8tE/rw==
X-Google-Smtp-Source: AGHT+IHBoF+8WS2RfetzLDwdufPuai+lmlctVilCrpXxsuy5LNKEo/W+GvWNVlLVD0/hEfe7bag85w==
X-Received: by 2002:a17:903:84f:b0:1c9:d25c:17c6 with SMTP id ks15-20020a170903084f00b001c9d25c17c6mr8511411plb.1.1698118840059;
        Mon, 23 Oct 2023 20:40:40 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-20-59.pa.nsw.optusnet.com.au. [49.180.20.59])
        by smtp.gmail.com with ESMTPSA id n14-20020a170902d2ce00b001c739768214sm6668917plc.92.2023.10.23.20.40.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 20:40:39 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
        (envelope-from <david@fromorbit.com>)
        id 1qv8HU-0039F0-1Z;
        Tue, 24 Oct 2023 14:40:36 +1100
Date:   Tue, 24 Oct 2023 14:40:36 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jeff Layton <jlayton@kernel.org>,
        Kent Overstreet <kent.overstreet@linux.dev>,
        Christian Brauner <brauner@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        John Stultz <jstultz@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Chandan Babu R <chandan.babu@oracle.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.de>,
        David Howells <dhowells@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-mm@kvack.org,
        linux-nfs@vger.kernel.org
Subject: Re: [PATCH RFC 2/9] timekeeping: new interfaces for multigrain
 timestamp handing
Message-ID: <ZTc8tClCRkfX3kD7@dread.disaster.area>
References: <CAHk-=wiKJgOg_3z21Sy9bu+3i_34S86r8fd6ngvJpZDwa-ww8Q@mail.gmail.com>
 <5f96e69d438ab96099bb67d16b77583c99911caa.camel@kernel.org>
 <20231019-fluor-skifahren-ec74ceb6c63e@brauner>
 <0a1a847af4372e62000b259e992850527f587205.camel@kernel.org>
 <ZTGncMVw19QVJzI6@dread.disaster.area>
 <eb3b9e71ee9c6d8e228b0927dec3ac9177b06ec6.camel@kernel.org>
 <ZTWfX3CqPy9yCddQ@dread.disaster.area>
 <61b32a4093948ae1ae8603688793f07de764430f.camel@kernel.org>
 <ZTcBI2xaZz1GdMjX@dread.disaster.area>
 <CAHk-=whphyjjLwDcEthOOFXXfgwGrtrMnW2iyjdQioV6YSMEPw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whphyjjLwDcEthOOFXXfgwGrtrMnW2iyjdQioV6YSMEPw@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Oct 23, 2023 at 02:18:12PM -1000, Linus Torvalds wrote:
> On Mon, 23 Oct 2023 at 13:26, Dave Chinner <david@fromorbit.com> wrote:
> >
> > The problem is the first read request after a modification has been
> > made. That is causing relatime to see mtime > atime and triggering
> > an atime update. XFS sees this, does an atime update, and in
> > committing that persistent inode metadata update, it calls
> > inode_maybe_inc_iversion(force = false) to check if an iversion
> > update is necessary. The VFS sees I_VERSION_QUERIED, and so it bumps
> > i_version and tells XFS to persist it.
> 
> Could we perhaps just have a mode where we don't increment i_version
> for just atime updates?
>
> Maybe we don't even need a mode, and could just decide that atime
> updates aren't i_version updates at all?

We do that already - in memory atime updates don't bump i_version at
all. The issue is the rare persistent atime update requests that
still happen - they are the ones that trigger an i_version bump on
XFS, and one of the relatime heuristics tickle this specific issue.

If we push the problematic persistent atime updates to be in-memory
updates only, then the whole problem with i_version goes away....

> Yes, yes, it's obviously technically a "inode modification", but does
> anybody actually *want* atime updates with no actual other changes to
> be version events?

Well, yes, there was. That's why we defined i_version in the on disk
format this way well over a decade ago. It was part of some deep
dark magical HSM beans that allowed the application to combine
multiple scans for different inode metadata changes into a single
pass. atime changes was one of the things it needed to know about
for tiering and space scavenging purposes....

> Or maybe i_version can update, but callers of getattr() could have two
> bits for that STATX_CHANGE_COOKIE, one for "I care about atime" and
> one for others, and we'd pass that down to inode_query_version, and
> we'd have a I_VERSION_QUERIED and a I_VERSION_QUERIED_STRICT, and the
> "I care about atime" case ould set the strict one.

This makes correct behaviour reliant on the applicaiton using the
query mechanism correctly. I have my doubts that userspace
developers will be able to understand the subtle difference between
the two options and always choose correctly....

And then there's always the issue that we might end up with both
flags set and we get conflicting bug reports about how atime is not
behaving the way the applications want it to behave.

> Then inode_maybe_inc_iversion() could - for atome updates - skip the
> version update *unless* it sees that I_VERSION_QUERIED_STRICT bit.
> 
> Does that sound sane to people?

I'd much prefer we just do the right thing transparently at the
filesystem level; all we need is for the inode to be flagged that it
should be doing in memory atime updates rather than persistent
updates.

Perhaps the nfs server should just set a new S_LAZYTIME flag on
inodes it accesses similar to how we can set S_NOATIME on inodes to
elide atime updates altogether. Once set, the inode will behave that
way until it is reclaimed from memory....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
