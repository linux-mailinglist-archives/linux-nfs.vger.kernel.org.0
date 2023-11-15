Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCF287DDD8C
	for <lists+linux-nfs@lfdr.de>; Wed,  1 Nov 2023 09:08:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230146AbjKAIIy (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 1 Nov 2023 04:08:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjKAIIx (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 1 Nov 2023 04:08:53 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F22198;
        Wed,  1 Nov 2023 01:08:50 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-5a7af20c488so64963377b3.1;
        Wed, 01 Nov 2023 01:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698826129; x=1699430929; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zgfbgSEobRatousrajtd1MKUo9GGvoyPH04y8/doDqo=;
        b=bSmshpaHqz69KlnSBF23evOG2ixqxGimlctyYwj96sd1Os0sj2q0p9hi7rkx0gz5yk
         +/FGVs7nPSQqpAK/L+fpVCwu+sOOs+XWabzheoecZC4sz5OboWOc/RN6TLnoDezuGyng
         3Ku+3/8xsfMWgFcldahZszhGkzCUhis7bb+olWSgy2/7tI8jJWh3DkpnUtIt+Un5hl4/
         HGaNMmgQwb3IFNlHanYSkzuKw/Jp1HX+dvVh1OqpB8UfopKo+H5b+w3qbdRyi+nTP/aU
         cMGY9sod9V36+1tEBiYk3oIrx0cuFLjfXO82QCfsZL879W4NlE8jaAkMy75sbPE0xV3C
         nGGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698826129; x=1699430929;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zgfbgSEobRatousrajtd1MKUo9GGvoyPH04y8/doDqo=;
        b=e3kZjzbIjhYs4IQ5EO9QNH9fZmPrd4kseSyCmYku8ba++99kC/6NjULlqFUtvGxQ4m
         a5PgdEafPdPrtOgYJmph+l4ny0IGhFLIIXiTQSnYjhO03gDLNbV5pt0ic55wP5vIN/ZC
         p0gvWl3+StAgFxEJJOIPuukUWVg/TteZUVXUe+dWiJgVDUgWVSTu3oSS/MDgT/iUqfM3
         MxaIsg3IZDIMM3Yc/tit2Y49koUcWJqmT0W4Tqp6sjetwTtCp5sPl/aLjKtYt+Xepx9z
         ekEA28gKXRvfKHXtnHXBwPcdB8ecmCfEk5LELLYUB3yaNiE9PccMuW3yv+yfKf8Bn1Bn
         5Bjg==
X-Gm-Message-State: AOJu0Yx4veOE6HB3N0iw8LNFPExNv76VnDgvtjRGH7PAl/a8p4nI+oWs
        fuIpnSDZ0Jum9egRu4CRxvtfhTSjd8g7sBpHhuA=
X-Google-Smtp-Source: AGHT+IGRBUWRysQM9zIevnqz2kXSdSgC1kLwK+R6pM3Ky1i1gtJgobEMFWL1l8JxKMDWCm+cTvXeqLv8Z+MqOa/srO4=
X-Received: by 2002:a81:4109:0:b0:5a7:aa16:6b05 with SMTP id
 o9-20020a814109000000b005a7aa166b05mr13757515ywa.33.1698826129298; Wed, 01
 Nov 2023 01:08:49 -0700 (PDT)
MIME-Version: 1.0
References: <CAOQ4uxhJGkZrUdUJ72vjRuLec0g8VqgRXRH=x7W9ogMU6rBxcQ@mail.gmail.com>
 <d539804a2a73ad70265c5fa599ecd663cd235843.camel@kernel.org>
 <ZTjMRRqmlJ+fTys2@dread.disaster.area> <2ef9ac6180e47bc9cc8edef20648a000367c4ed2.camel@kernel.org>
 <ZTnNCytHLGoJY9ds@dread.disaster.area> <6df5ea54463526a3d898ed2bd8a005166caa9381.camel@kernel.org>
 <ZUAwFkAizH1PrIZp@dread.disaster.area> <CAHk-=wg4jyTxO8WWUc1quqSETGaVsPHh8UeFUROYNwU-fEbkJg@mail.gmail.com>
 <ZUBbj8XsA6uW8ZDK@dread.disaster.area> <CAOQ4uxgSRw26J+MPK-zhysZX9wBkXFRNx+n1bwnQwykCJ1=F4Q@mail.gmail.com>
 <20231031231250.GA1205221@frogsfrogsfrogs>
In-Reply-To: <20231031231250.GA1205221@frogsfrogsfrogs>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 1 Nov 2023 10:08:37 +0200
Message-ID: <CAOQ4uxh0rBzNm=OK3DNPyiybm2Jdac4aLYKGHAeDZn_A1HGd0Q@mail.gmail.com>
Subject: Re: [PATCH RFC 2/9] timekeeping: new interfaces for multigrain
 timestamp handing
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Dave Chinner <david@fromorbit.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jeff Layton <jlayton@kernel.org>,
        Kent Overstreet <kent.overstreet@linux.dev>,
        Christian Brauner <brauner@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        John Stultz <jstultz@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Chandan Babu R <chandan.babu@oracle.com>,
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

On Wed, Nov 1, 2023 at 1:12=E2=80=AFAM Darrick J. Wong <djwong@kernel.org> =
wrote:
>
> On Tue, Oct 31, 2023 at 09:03:57AM +0200, Amir Goldstein wrote:
> > On Tue, Oct 31, 2023 at 3:42=E2=80=AFAM Dave Chinner <david@fromorbit.c=
om> wrote:
> > >
> > [...]
> > > .... and what is annoying is that that the new i_version just a
> > > glorified ctime change counter. What we should be fixing is ctime -
> > > integrating this change counting into ctime would allow us to make
> > > i_version go away entirely. i.e. We don't need a persistent ctime
> > > change counter if the ctime has sufficient resolution or persistent
> > > encoding that it does not need an external persistent change
> > > counter.
> > >
> > > That was reasoning behind the multi-grain timestamps. While the mgts
> > > implementation was flawed, the reasoning behind it certainly isn't.
> > > We should be trying to get rid of i_version by integrating it into
> > > ctime updates, not arguing how atime vs i_version should work.
> > >
> > > > So I don't think the issue here is "i_version" per se. I think in a
> > > > vacuum, the best option of i_version is pretty obvious.  But if you
> > > > want i_version to track di_changecount, *then* you end up with that
> > > > situation where the persistence of atime matters, and i_version nee=
ds
> > > > to update whenever a (persistent) atime update happens.
> > >
> > > Yet I don't want i_version to track di_changecount.
> > >
> > > I want to *stop supporting i_version altogether* in XFS.
> > >
> > > I want i_version as filesystem internal metadata to die completely.
> > >
> > > I don't want to change the on disk format to add a new i_version
> > > field because we'll be straight back in this same siutation when the
> > > next i_version bug is found and semantics get changed yet again.
> > >
> > > Hence if we can encode the necessary change attributes into ctime,
> > > we can drop VFS i_version support altogether.  Then the "atime bumps
> > > i_version" problem also goes away because then we *don't use
> > > i_version*.
> > >
> > > But if we can't get the VFS to do this with ctime, at least we have
> > > the abstractions available to us (i.e. timestamp granularity and
> > > statx change cookie) to allow XFS to implement this sort of
> > > ctime-with-integrated-change-counter internally to the filesystem
> > > and be able to drop i_version support....
> > >
> >
> > I don't know if it was mentioned before in one of the many threads,
> > but there is another benefit of ctime-with-integrated-change-counter
> > approach - it is the ability to extend the solution with some adaptatio=
ns
> > also to mtime.
> >
> > The "change cookie" is used to know if inode metadata cache should
> > be invalidated and mtime is often used to know if data cache should
> > be invalidated, or if data comparison could be skipped (e.g. rsync).
> >
> > The difference is that mtime can be set by user, so using lower nsec
> > bits for modification counter would require to truncate the user set
> > time granularity to 100ns - that is probably acceptable, but only as
> > an opt-in behavior.
> >
> > The special value 0 for mtime-change-counter could be reserved for
> > mtime that was set by the user or for upgrade of existing inode,
> > where 0 counter means that mtime cannot be trusted as an accurate
> > data modification-cookie.
>
> What about write faults on an mmap region?  The first ro->rw transition
> results in an mtime update, but not again until the page gets cleaned.
>

That problem is out of scope. As is the issue of whether mtime is updated
before or after the data modification.
For all practical matter, HSM (or any backup/sync software) could fsync
data of file before testing its mtime.
I am working on an additional mechanism (sb_start_write_srcu) which
HSM can use to close the rest of the possible TOCTOU races.

The problem that modification-cookie needs to solve is the coarse grained
mtime timestamp, very much like change-cookie for ctime and additionally
it needs to solve the problem that HSM needs to know if the mtime
timestamp was generated by the filesystem or set by the user.

Thanks,
Amir.
