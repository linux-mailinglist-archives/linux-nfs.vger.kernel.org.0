Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2331D798419
	for <lists+linux-nfs@lfdr.de>; Fri,  8 Sep 2023 10:33:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232196AbjIHIdT (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 8 Sep 2023 04:33:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231129AbjIHIdS (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 8 Sep 2023 04:33:18 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40DDF1BE6
        for <linux-nfs@vger.kernel.org>; Fri,  8 Sep 2023 01:33:14 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id 3f1490d57ef6-d7260fae148so1683506276.1
        for <linux-nfs@vger.kernel.org>; Fri, 08 Sep 2023 01:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dneg.com; s=google; t=1694161993; x=1694766793; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WnZIqhpw3jazssTabJDhoAUYitbT/k/F3tsvnJf8530=;
        b=hUkxVZeOtzKMQZLAA2Tgewh+yB749M72UAMQ9jj0Wa1HO7naykci6m1+WWztVcxYs2
         hmyVAJJiA2Ixe6ebGXtUQ9vgRcAPVRvsF94y1b79JH5SWwFSgeQFUm9tqYLGIV8v5HUu
         m06FLZc3lqfldGKDpBik4kxSYQBMJ/v3u1DsNXY2viRNpshL1MyOzjemKSBWE1JrPSUA
         fsty1qrHMqUfp2YLw39RP3nXVhFbiDsvZ2hgZPHP+7vm3abzuQqmq5uzK0bbhwnAi/At
         /Iw0hNMnTIPCfaglh1aBz65aacn2cIH/p/GUMphVsO0mZOow0+8U5DAOn7R3j/sURdH6
         8GXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694161993; x=1694766793;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WnZIqhpw3jazssTabJDhoAUYitbT/k/F3tsvnJf8530=;
        b=e1EN3UulPbZeLFdVKI6+JgpRuE6afTW1KUa0zQQKpRomjb34Re1XNWyIC00oHuqe3V
         f3oF4CIHJJ5gSbDbu2tFDJcOzetQI3THAmfzoQ1MLLsvwrtPgO/EeJ0BygeseJ4OEFgO
         ftrHCt/UGGTE1LfJ3fHkQKJCMVhVZThoBIlOjBiihT0YhOOhAERix9CdCWLVoRdoT8H1
         v2pZYTL8Azqk/uz2ktHP0qBqEVdDQxLrwQdZQrI0czOrszUYOK2tW9z8Xird5qMnZejv
         KKSHFchwzDSpTVn6zDAnwcAi7XxSEx++gDd6Qki8wT6MOrittXfMo0s0aedbl7nwVyOd
         MF6Q==
X-Gm-Message-State: AOJu0Yy+zd1HqUy6F0PHgpDVOOyaDgbq3A9YZ8yzEUav07i9PjQ9dqKw
        woJcOX8Jf3u7+ltPlW2CtJhZAV474k/+y0OJ96N9GpmtwGwkubvsSig=
X-Google-Smtp-Source: AGHT+IFi7z/THbiDUuV5V4sMNb6cnzBfx4/ICSKIwBg/2XbmUOIC0/3G5rwachN0A+wgAP8uEM51b3Y3cxWGjs+oUJQ=
X-Received: by 2002:a25:3716:0:b0:d78:40da:3b25 with SMTP id
 e22-20020a253716000000b00d7840da3b25mr1527547yba.47.1694161993234; Fri, 08
 Sep 2023 01:33:13 -0700 (PDT)
MIME-Version: 1.0
References: <CAPt2mGOcf+y1acYqzB+a3aZOJM0kE=FcWr-Xs15ECswGXP8-yA@mail.gmail.com>
In-Reply-To: <CAPt2mGOcf+y1acYqzB+a3aZOJM0kE=FcWr-Xs15ECswGXP8-yA@mail.gmail.com>
From:   Daire Byrne <daire@dneg.com>
Date:   Fri, 8 Sep 2023 09:32:37 +0100
Message-ID: <CAPt2mGMzFA2JEASJGtwpbG20o+fKK_5fv2j++ksXDmMnqvXsYg@mail.gmail.com>
Subject: Re: rpc.mountd & manage-gids behaviour change?
To:     linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

For the benefit of anyone who finds this thread via a search, the
issue turns out to be this change to SSSD which introduced parallel
requests:

https://sssd.io/release-notes/sssd-2.7.3.html

But then the rpc.mountd "client" threads would send 8 requests
(rpc.mountd threads) to SSSD which then all get sent over the wire to
your LDAP/AD server whereas before it was a single request.

New fixes from Redhat:

https://bugzilla.redhat.com/show_bug.cgi?id=2234829
https://github.com/SSSD/sssd/issues/6911

Daire

On Thu, 24 Aug 2023 at 18:39, Daire Byrne <daire@dneg.com> wrote:
>
> Hi,
>
> We have lots of Linux storage servers running combinations of RHEL7,
> RHEL8 and more recently RHEL9. We also use "manage-gids" and have lots
> of groups of users and apply permissions to directories on the
> exported filesystems.
>
> We also use sssd and AD/LDAP on these storage servers to resolve the
> groups and do the user lookups. This setup has worked great for our
> needs for many years but we have noticed a change in RHEL9 which
> results in many more uid/gid lookups hitting our LDAP servers.
>
> It seems like with RHEL7 & 8 era kernels and nfs-utils, sssd/nss would
> receive a single request from rpc.mountd whereas with RHEL9 we now get
> duplicated requests for each rpc.mountd thread (8 by default) even for
> a single client mount. So 8 uid/gid requests hit sssd at the same
> time, and because it's not in cache, all those 8 requests go out over
> the wire to our AD server.
>
> So for lookups not in the cache, we have 8 times more requests hitting
> our LDAP servers. Not to mention that sssd sometimes crashes or loses
> connectivity with the LDAP server with this increased load.
>
> I had a look through the changes for linux-nfs but nothing jumped out
> at me in that time frame (other than code to make exportd
> multi-threaded). Does anyone have any ideas where this change of
> behaviour might be coming from?
>
> RHEL9: nfs-utils-2.5.4
> RHEL8: nfs-utils-2.3.3
>
> Cheers,
>
> Daire
