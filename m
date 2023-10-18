Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FE407CE9FF
	for <lists+linux-nfs@lfdr.de>; Wed, 18 Oct 2023 23:31:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231439AbjJRVb5 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 18 Oct 2023 17:31:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjJRVb4 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 18 Oct 2023 17:31:56 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CAA6EA
        for <linux-nfs@vger.kernel.org>; Wed, 18 Oct 2023 14:31:55 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-9ba081173a3so1204809166b.1
        for <linux-nfs@vger.kernel.org>; Wed, 18 Oct 2023 14:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1697664713; x=1698269513; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ECKpgvAUzJR9x6tmoRvOJm7k5hgaq6eXpehPithmdco=;
        b=Ac9dz8zswGFxsmltVOx8gzHtiaMUBO2y25lQgNRnhHQxZNz88kigBzIwC13DQTLzHT
         xfFpACNmpnF2YyEJZNGpquoNzaHQxKFs91OUX1T8x3+tBYvYMC/jK7z8UODjHrnvkNxL
         KIh5wQhJaXAaAxEH/tEG9R63nF/zDglOleTHs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697664713; x=1698269513;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ECKpgvAUzJR9x6tmoRvOJm7k5hgaq6eXpehPithmdco=;
        b=bazqMOAyLD/faNu0lJXJv9RuKUBhzYXIRUciP3BIgMCXosRZt3lQRpPEGeniJy/KXh
         j/KtHfrmemsjG9EuYE2/koFGthT8o7+HjRRCB1bngpf65Mz9v5dSIpU78G+z3+BIxcyF
         yZm5RiZCKkYo7G/y4uGljDNUP7QgD0hiAGtbsb1Sk8FdiSm/hxDpw7+ba5OdnPxH8zGR
         lBqoEB4U8INJUab02li+P9pkDDShhy7ddYItY7Aef9ZHPzAN4ptZjz223E+ThGrrfQNW
         BhcMyFzOvpb/iql9vndaIx8hfKymfw51KsA+2O0GFxpki/zEQfPc8T4ouOY7m/+/74dg
         EGow==
X-Gm-Message-State: AOJu0YwD+YofEpmCvmzJjyhPGOlzNyxX5uxBTiuY5D4fxFZWUj0Dh0Sf
        vDGbw5fRCJrr2wFbr23Q1pmJbQlhPb54KXBdy2RuEMIX
X-Google-Smtp-Source: AGHT+IEv5kSarTjHX+Rm6IZPah/aF59NYd/Hb/xqQTSq6tAT4QvuJonjtVDqM1WWd5biwrFwJ0Na0g==
X-Received: by 2002:a17:907:7211:b0:9c4:4b20:44a9 with SMTP id dr17-20020a170907721100b009c44b2044a9mr356588ejc.65.1697664713436;
        Wed, 18 Oct 2023 14:31:53 -0700 (PDT)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com. [209.85.218.41])
        by smtp.gmail.com with ESMTPSA id g22-20020a1709064e5600b009ad7fc17b2asm2337076ejw.224.2023.10.18.14.31.53
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Oct 2023 14:31:53 -0700 (PDT)
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-99357737980so1204467566b.2
        for <linux-nfs@vger.kernel.org>; Wed, 18 Oct 2023 14:31:53 -0700 (PDT)
X-Received: by 2002:a17:907:c0d:b0:9be:7b67:1674 with SMTP id
 ga13-20020a1709070c0d00b009be7b671674mr409722ejc.3.1697664692747; Wed, 18 Oct
 2023 14:31:32 -0700 (PDT)
MIME-Version: 1.0
References: <20231018-mgtime-v1-0-4a7a97b1f482@kernel.org> <20231018-mgtime-v1-2-4a7a97b1f482@kernel.org>
 <CAHk-=wixObEhBXM22JDopRdt7Z=tGGuizq66g4RnUmG9toA2DA@mail.gmail.com> <d6162230b83359d3ed1ee706cc1cb6eacfb12a4f.camel@kernel.org>
In-Reply-To: <d6162230b83359d3ed1ee706cc1cb6eacfb12a4f.camel@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 18 Oct 2023 14:31:15 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiKJgOg_3z21Sy9bu+3i_34S86r8fd6ngvJpZDwa-ww8Q@mail.gmail.com>
Message-ID: <CAHk-=wiKJgOg_3z21Sy9bu+3i_34S86r8fd6ngvJpZDwa-ww8Q@mail.gmail.com>
Subject: Re: [PATCH RFC 2/9] timekeeping: new interfaces for multigrain
 timestamp handing
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        John Stultz <jstultz@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Chandan Babu R <chandan.babu@oracle.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Dave Chinner <david@fromorbit.com>,
        "Theodore Ts'o" <tytso@mit.edu>,
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
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, 18 Oct 2023 at 13:47, Jeff Layton <jlayton@kernel.org> wrote:
>
> >         old_ctime_nsec &= ~I_CTIME_QUERIED;
> >         if (ts64.tv_nsec > old_ctime_nsec + inode->i_sb->s_time_gran)
> >                 return ts64;
> >
>
> Does that really do what you expect here? current_time will return a
> value that has already been through timestamp_truncate.

Yeah, you're right.

I think you can actually remove the s_time_gran addition. Both the
old_ctime_nsec and the current ts64,tv_nsec are already rounded, so
just doing

        if (ts64.tv_nsec > old_ctime_nsec)
                return ts64;

would already guarantee that it's different enough.

> current_mgtime is calling ktime_get_real_ts64, which is an existing
> interface that does not take the global spinlock and won't advance the
> global offset. That call should be quite cheap.

Ahh, I did indeed mis-read that as the new one with the lock.

I did react to the fact that is_mgtime(inode) itself is horribly
expensive if it's not cached (following three quite possibly cold
pointers), which was part of that whole "look at I_CTIME_QUERIED
instead".

I see the pointer chasing as a huge VFS timesink in all my profiles,
although usually it's the disgusting security pointer (because selinux
creates separate security nodes for each inode, even when the contents
are often identical). So I'm a bit sensitive to "follow several
pointers from 'struct inode'" patterns from looking at too many
instruction profiles.

          Linus
