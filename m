Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCF1F46F173
	for <lists+linux-nfs@lfdr.de>; Thu,  9 Dec 2021 18:16:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236199AbhLIRT6 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 9 Dec 2021 12:19:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239355AbhLIRT5 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 9 Dec 2021 12:19:57 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15FC4C061746
        for <linux-nfs@vger.kernel.org>; Thu,  9 Dec 2021 09:16:24 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id r11so21308254edd.9
        for <linux-nfs@vger.kernel.org>; Thu, 09 Dec 2021 09:16:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3tHtN7G3YGgTFoTuLt2UtzoWso0slwegtyye0NyKD6E=;
        b=EkUZICBj3sLfwkSa6PVgwK3UJYMBWKD3Zl6QL503dGClSkUivH631EePhpBTiQgDNd
         VoCL1zBnYteGbjvNrexkMxulvtqSc6W1x7ANtURNimEiRxxY81sHWsZDJM+iJu2oAiti
         SYA5FO15uZ/NSRZ6dw7jltE7xXAi1A4hAYadw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3tHtN7G3YGgTFoTuLt2UtzoWso0slwegtyye0NyKD6E=;
        b=iKekndyqK7iEY4hlvLaBieX9hkryCScgtrs/7WVbNiKylXUyTIvbjdbZQ9Ygbmi6NF
         oxDRuRdZdySdOpaNmZtJCRLZFetMBWoxV+hGgIadotrcDbOMctcH9aDx7WALZJVz5wSP
         eRsc/bWip77jDQQWv0f16DEPlDnI6JVzhEMg4ANkovY3nYpo98XDCcvigTCLb+rB2BNW
         VnU//608cAzkh7Ab+HO+s4E1fLuAyIGx7PLth0Xrpm1hmfttsm7/13Q/f89Ci81XdHaD
         6IiopMCoPt6Bor8kykH645VJo5TOo0/PPdDlhoS07CQ6mf1cRA26CsSMNOBXnoZtP9MH
         rP/A==
X-Gm-Message-State: AOAM533dEf9WSOV+lQL+q5u1qYmtF48GIaag49z3NIOP7rt+iOBXGseC
        VRdxzLl4lnztS+7Jty/3p0jiGsVxAAiIG/Sj
X-Google-Smtp-Source: ABdhPJxxixstM+tzY+7mxc2+6F3+pLZYLdodS+6oNjtAB1NtWxM9VJM6oF1KGQCBtUTGez9nGu351A==
X-Received: by 2002:a50:8d47:: with SMTP id t7mr29775435edt.14.1639069996452;
        Thu, 09 Dec 2021 09:13:16 -0800 (PST)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com. [209.85.128.43])
        by smtp.gmail.com with ESMTPSA id h7sm170460edb.89.2021.12.09.09.13.14
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Dec 2021 09:13:15 -0800 (PST)
Received: by mail-wm1-f43.google.com with SMTP id o29so4795852wms.2
        for <linux-nfs@vger.kernel.org>; Thu, 09 Dec 2021 09:13:14 -0800 (PST)
X-Received: by 2002:a05:600c:1914:: with SMTP id j20mr8992229wmq.26.1639069994552;
 Thu, 09 Dec 2021 09:13:14 -0800 (PST)
MIME-Version: 1.0
References: <163906878733.143852.5604115678965006622.stgit@warthog.procyon.org.uk>
 <163906888735.143852.10944614318596881429.stgit@warthog.procyon.org.uk>
In-Reply-To: <163906888735.143852.10944614318596881429.stgit@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 9 Dec 2021 09:12:58 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiTquFUu-b5ME=rbGEF8r2Vh1TXGfaZZuXyOutVrgRzfw@mail.gmail.com>
Message-ID: <CAHk-=wiTquFUu-b5ME=rbGEF8r2Vh1TXGfaZZuXyOutVrgRzfw@mail.gmail.com>
Subject: Re: [PATCH v2 07/67] fscache: Implement a hash function
To:     David Howells <dhowells@redhat.com>
Cc:     linux-cachefs@redhat.com,
        Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Jeff Layton <jlayton@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Omar Sandoval <osandov@osandov.com>,
        JeffleXu <jefflexu@linux.alibaba.com>,
        linux-afs@lists.infradead.org,
        "open list:NFS, SUNRPC, AND..." <linux-nfs@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>, ceph-devel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Dec 9, 2021 at 8:54 AM David Howells <dhowells@redhat.com> wrote:
>
> Implement a function to generate hashes.  It needs to be stable over time
> and endianness-independent as the hashes will appear on disk in future
> patches.

I'm not actually seeing this being endianness-independent.

Is the input just regular 32-bit data in native word order? Because
then it's not endianness-independent, it's purely that there *is* no
endianness to the data at all and it is purely native data.

So the code may be correct, but the explanation is confusing. There is
absolutely nothing here that is about endianness.

           Linus
