Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F31B07D16D6
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Oct 2023 22:21:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230196AbjJTUVm (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 20 Oct 2023 16:21:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbjJTUVm (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 20 Oct 2023 16:21:42 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 185181A4
        for <linux-nfs@vger.kernel.org>; Fri, 20 Oct 2023 13:21:40 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-99c1c66876aso189595966b.2
        for <linux-nfs@vger.kernel.org>; Fri, 20 Oct 2023 13:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1697833298; x=1698438098; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XP/w2rcRgohzEDCbF3zAswI8lw4+mMJo52iF5/bT45w=;
        b=hqc7ea0COAmFv5MZPwSBclL6NfgTYs+tcpUPSzzToCUZ/TwOo0hu4g8a7FGMseXNsd
         NyABRTQUYO3pBlR8m58SHKKix/tS2Kbetb/DHV2SUb1E2yfgMlnbb6fsD4tQ6kvq4agG
         rYfEk8Cp6+fRvYnrlk4hLH6JfDTVzKAvswqRg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697833298; x=1698438098;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XP/w2rcRgohzEDCbF3zAswI8lw4+mMJo52iF5/bT45w=;
        b=OEY16AauJGLiB5oN67avStuigNF1XFjZZdnvowPop1HVRad89/ZDIiJpTrmFU78L0V
         Svx0w/HM92Bbpg6w/hReaBhMuAbAnZSpOPaiwj4W1YQdyjzRzf1HrI4kd1l5UrcQAU5H
         iVpQ/DWRFM32GmvlwRSDoOMyyXNg+cqCA+6kiG32eouk8IcLa9EpvVDr2NByTqtYkbn6
         8L5IqLtYzswmvQmqgIyO3hagiblUlU8IH68vQ57B+3qctvdBVTSg1XAt4eDK5xqFTycG
         q3we/wscVxneILhRiH37SKujI2mmM9hcSW//odMh1dh5407nPTE/BvtaQM0J3xJlvKVq
         5s/Q==
X-Gm-Message-State: AOJu0YydbzBZpZ0cxwk9vdHyjBtfSvIxvdvvaMP8nuK2YXrKU2/2jqoG
        zL5MjyL/AjlUQtkFb/ux0w7gbN52VQS5Ef24T5UPv3+e
X-Google-Smtp-Source: AGHT+IGczATG+ewhSJ8yx7OBsgekZgwyUakCZoG0ool7fgnY2jXysi1cWEnKsyKsLXk/91YIJTDyNg==
X-Received: by 2002:a17:907:9495:b0:9a5:b878:7336 with SMTP id dm21-20020a170907949500b009a5b8787336mr2098616ejc.7.1697833298431;
        Fri, 20 Oct 2023 13:21:38 -0700 (PDT)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com. [209.85.208.42])
        by smtp.gmail.com with ESMTPSA id i26-20020a17090671da00b0098e34446464sm2149414ejk.25.2023.10.20.13.21.38
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Oct 2023 13:21:38 -0700 (PDT)
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-522bd411679so1837595a12.0
        for <linux-nfs@vger.kernel.org>; Fri, 20 Oct 2023 13:21:38 -0700 (PDT)
X-Received: by 2002:a17:907:7e9e:b0:9ae:50e3:7e40 with SMTP id
 qb30-20020a1709077e9e00b009ae50e37e40mr2195962ejc.52.1697833276793; Fri, 20
 Oct 2023 13:21:16 -0700 (PDT)
MIME-Version: 1.0
References: <20231018-mgtime-v1-0-4a7a97b1f482@kernel.org> <20231018-mgtime-v1-2-4a7a97b1f482@kernel.org>
 <CAHk-=wixObEhBXM22JDopRdt7Z=tGGuizq66g4RnUmG9toA2DA@mail.gmail.com>
 <d6162230b83359d3ed1ee706cc1cb6eacfb12a4f.camel@kernel.org>
 <CAHk-=wiKJgOg_3z21Sy9bu+3i_34S86r8fd6ngvJpZDwa-ww8Q@mail.gmail.com>
 <5f96e69d438ab96099bb67d16b77583c99911caa.camel@kernel.org>
 <20231019-fluor-skifahren-ec74ceb6c63e@brauner> <0a1a847af4372e62000b259e992850527f587205.camel@kernel.org>
 <ZTGncMVw19QVJzI6@dread.disaster.area> <eb3b9e71ee9c6d8e228b0927dec3ac9177b06ec6.camel@kernel.org>
 <CAHk-=wjma9_TSwXosG7GBXQaZ465VH1t4a4iQ8J=PFpE=4bhVA@mail.gmail.com>
In-Reply-To: <CAHk-=wjma9_TSwXosG7GBXQaZ465VH1t4a4iQ8J=PFpE=4bhVA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 20 Oct 2023 13:20:59 -0700
X-Gmail-Original-Message-ID: <CAHk-=whrB++OBZ9nO72QjLnWuSQxee69JQp7mo3cwDiaS6tTLw@mail.gmail.com>
Message-ID: <CAHk-=whrB++OBZ9nO72QjLnWuSQxee69JQp7mo3cwDiaS6tTLw@mail.gmail.com>
Subject: Re: [PATCH RFC 2/9] timekeeping: new interfaces for multigrain
 timestamp handing
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Dave Chinner <david@fromorbit.com>,
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

On Fri, 20 Oct 2023 at 13:06, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> So on reboot, the inode would count as "changed" as far any remote
> user is concerned. [..]

Obviously, not just reboot would do that. Any kind of "it's no longer
cached on the server and gets read back from disk" would do the same
thing.

Again, that may not work for the intended purpose, but if the use-case
is a "same version number means no changes", it might be acceptable?
Even if you then could get spurious version changes when the file
hasn't been accessed in a long time?

Maybe all this together with with some ctime filtering ("old ctime
clealy means that the version number is irrelevant"). After all, the
whole point of fine-grained timestamps was to distinguish *frequent*
changes. An in-memory counter certainly does that even without any
on-disk representation..

               Linus
