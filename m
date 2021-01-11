Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D78E02F1F9E
	for <lists+linux-nfs@lfdr.de>; Mon, 11 Jan 2021 20:38:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733211AbhAKThz (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 11 Jan 2021 14:37:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730389AbhAKThz (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 11 Jan 2021 14:37:55 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A80DCC061794
        for <linux-nfs@vger.kernel.org>; Mon, 11 Jan 2021 11:37:14 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id u11so134039ljo.13
        for <linux-nfs@vger.kernel.org>; Mon, 11 Jan 2021 11:37:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K8VTkCnvBCZK6GbjTwGTMVvXkH9yfznhMnwKta67CA8=;
        b=QcEVXucCWbRn/O5LNGKliJ0mboxGYOql86IBpcFKOfkQMZw5Nf5sIINIWa6ONi/AJF
         /SAoPq3JfVtcl2Aayk6dTB9lAt9uQM8NGCu27H5Lf120f3QmwMtT3xlPyBYubwzQOmxh
         Wx3CusqUvWVIbuPqzUuXMCq3WLn24gn1FqAp8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K8VTkCnvBCZK6GbjTwGTMVvXkH9yfznhMnwKta67CA8=;
        b=WVOJkw6pBBtmJ45CHl/ElYuuV3XJoaeXswv5V3wk+9caogLS1f+gy/Jsf+9Kjo7Bij
         HlLt9fq5LcI2TSgXIGB7g7vdAF3cfGzE564IzpDgP0Ej3tmMGTWcHMwa/cGiWQLpuBTt
         Yl8+74w8IMG+EGwLaVeQZXZ+7ZuFMgzzEybTs0i7KuUEeZ6YH3PBdyQ/SRun+y6PJWkm
         08rixfjqfNbpvMLKkrDmr1i/MLGczGiK0zuQzAu723dCSwldWsSLil/oC7M2rc4Y9hRH
         fS504xbqUGZUxjI6e400uz9YmeDqEldJ/nnfqzrk8VE1ovlCTI9LEiY/FIjEWT2HfBBc
         HLFQ==
X-Gm-Message-State: AOAM531+XKm8zTUmy24bMetTuvhO52k2kzNId/tkg+NCxSvToa55HzJt
        dnC+bI+T5A7J8CrpUjBwU3zfYRWDDlAlJg==
X-Google-Smtp-Source: ABdhPJya3KleVxBO1DS2PGqT6w1E4JLy+5QAxF+E2GYmjUZymgoCsIo6V3tuV/J5CCKbkW0NCXD2pQ==
X-Received: by 2002:a2e:98cc:: with SMTP id s12mr455928ljj.325.1610393832962;
        Mon, 11 Jan 2021 11:37:12 -0800 (PST)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id h23sm72522ljh.115.2021.01.11.11.37.12
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Jan 2021 11:37:12 -0800 (PST)
Received: by mail-lf1-f46.google.com with SMTP id m25so1188557lfc.11
        for <linux-nfs@vger.kernel.org>; Mon, 11 Jan 2021 11:37:12 -0800 (PST)
X-Received: by 2002:a19:8557:: with SMTP id h84mr432782lfd.201.1610393831913;
 Mon, 11 Jan 2021 11:37:11 -0800 (PST)
MIME-Version: 1.0
References: <BEF46BF0-8B84-468C-B88C-33202C786E7E@oracle.com>
In-Reply-To: <BEF46BF0-8B84-468C-B88C-33202C786E7E@oracle.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 11 Jan 2021 11:36:55 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgcBcEZ3P1YxBp_YmPZpON7P6Envw9wr9=SnwAZPM61Ew@mail.gmail.com>
Message-ID: <CAHk-=wgcBcEZ3P1YxBp_YmPZpON7P6Envw9wr9=SnwAZPM61Ew@mail.gmail.com>
Subject: Re: [GIT PULL] nfsd changes for 5.11-rc
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     Bruce Fields <bfields@fieldses.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Jan 11, 2021 at 6:40 AM Chuck Lever <chuck.lever@oracle.com> wrote:
>
>   git://git.linux-nfs.org/projects/cel/cel-2.6.git 7b723008f9c95624c848fad661c01b06e47b20da

This works, but it's _really_ not very legible in the resulting merge
commit message.

I think you meant for me to pull "tags/nfsd-5.11-1" which does point
to that commit.

That would also have made git-request-pull generate a better
description in this email.

I will do that, but please check what odd scripting or whatever you
had that caused this mess...

            Linus
