Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DD9328E3AB
	for <lists+linux-nfs@lfdr.de>; Wed, 14 Oct 2020 17:57:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728226AbgJNP5P (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 14 Oct 2020 11:57:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726201AbgJNP5P (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 14 Oct 2020 11:57:15 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BFA1C061755
        for <linux-nfs@vger.kernel.org>; Wed, 14 Oct 2020 08:57:15 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id p5so2753103ejj.2
        for <linux-nfs@vger.kernel.org>; Wed, 14 Oct 2020 08:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zJ9svnL+bIyQpL58kb4K7T70FT1JnpLdYsmwMcHg1/w=;
        b=Q5kkJ74Cv+iavEtPAxTTHN9hJgCXQ6bm1YixT0M5cgcGk/dtu8FDMG4Ii1niKWoZD5
         0YaeRxjmeDD9mekxm33OGrfN8h6zduehpE/9C3v3TFNTI7C9ZQ1/0gzYwL/4AXN6yVIc
         7r2VBgffR7yqZckVA9VjfcJhYMrYOuy4DbBYjVZwpqbuAmidILWOf+63rqvIsQDhLP3B
         fXWZIG0UzAWfTyoArGXOWRhC+YHzFXjlWkOXsoR8gw9g2/vEHgD4N7NZO8SfYrr1JPaZ
         6j6E2NMYYPvPIW4vo2VH4rtGQP73lou/jbaZYQuxY37v8/ufpo+gncCjTbShNvRnCviw
         D95A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zJ9svnL+bIyQpL58kb4K7T70FT1JnpLdYsmwMcHg1/w=;
        b=sDy7yMAqpXAppgpZnzpqYY4xTfclJFWjlqkeSfUU48YzGVieYqqCMdRgURUhKWDSis
         WS2b06pA9zGP9FWYKXx+Y0ToxqpfCGsFusuer+T4oryzMq+c42BseQV+v3KosDtaz9kR
         X3nbNNWTDNi4yNDNGwLjIoKeGs/vNgrCDrtY3OW8s+msDgiWsRsZZyJk8Pgub0mza32H
         BsMOY0DNSiDWnVzbjkrXa85lJhLEryufCjc8jIOb1PIijB5O4FcY4megeJglihYSiv3l
         A0aOWFwLRKCYYMG1YMppqGmuion4subAESoC1cbYl0miHL2YRJ8sS6sC1g+MVOZBefER
         gWVg==
X-Gm-Message-State: AOAM531tTClOMQw3qd2qSzq0oRXFLIuf3bO0KC4q7SpW8dC9Qio3wSSg
        Vj+o431JCxUEUsdo6hnS74Wr8D84sg1Z5+EWskxX
X-Google-Smtp-Source: ABdhPJxsmGBsREPTKogvHYAHeiycG4bnzhChPImSAe1eGy1Tu/Boa8yPQA/rYh5g4df7a+OJR70eGm7SGEHQ6JHwvEg=
X-Received: by 2002:a17:906:4811:: with SMTP id w17mr5714111ejq.431.1602691033661;
 Wed, 14 Oct 2020 08:57:13 -0700 (PDT)
MIME-Version: 1.0
References: <CAN-5tyETQWVphrgqWjcPrtTzHHyz5DGrRz741yPYRS9Byyd=3Q@mail.gmail.com>
 <CAHC9VhRP2iJqLWiBg46zPKUqxzZoUOuaA6FPigxOw7qubophdw@mail.gmail.com>
 <CAN-5tyFq775PeOOzqskFexdbCgK3Gk_XB2Yy80SRYSc7Pdj=CA@mail.gmail.com>
 <CAHC9VhTzO1z6NmYz6cOLg5OvJiyQXdH_VmLh4=+h1MrGXx36JQ@mail.gmail.com>
 <CAN-5tyGJxUZb5QdJ=fh+L-6rc2B-MhQbDcDkTZNAZAAJm9Q8YQ@mail.gmail.com>
 <FB6C74CE-5D9F-4469-A49B-93CC8A51D7D5@gmail.com> <CAN-5tyFQbfkiuno07C6Azc7RcF3z3qF3PP0FutFMD3raBgnQmA@mail.gmail.com>
 <CAEjxPJ7PoAG6f+gVdodx=6X8+_Z_WCFXAuxnpB8WmC1gTF4iQQ@mail.gmail.com> <CAN-5tyEy57xoqEbZAThZKHriJywx-5DMKBD5tsXwo5ccGwuctw@mail.gmail.com>
In-Reply-To: <CAN-5tyEy57xoqEbZAThZKHriJywx-5DMKBD5tsXwo5ccGwuctw@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 14 Oct 2020 11:57:02 -0400
Message-ID: <CAHC9VhQpCXFySZY42==KR57hfAkVLdS6mSAcp2UHn-GWjEfVLg@mail.gmail.com>
Subject: Re: selinux: how to query if selinux is enabled
To:     Olga Kornievskaia <aglo@umich.edu>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        Chuck Lever <chucklever@gmail.com>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        SElinux list <selinux@vger.kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Oct 14, 2020 at 10:37 AM Olga Kornievskaia <aglo@umich.edu> wrote:
> On Tue, Oct 13, 2020 at 7:51 PM Stephen Smalley wrote:
> > I would suggest either introducing a new hook for your purpose, or
> > altering the existing one to support a form of query that isn't based
> > on a particular xattr name but rather just checking whether the module
> > supports/uses MAC labels at all.  Options: 1) NULL argument to the
> > existing hook indicates a general query (could hide a bug in the
> > caller, so not optimal), 2) Add a new bool argument to the existing
> > hook to indicate whether the name should be used, or 3) Add a new hook
> > that doesn't take any arguments.
>
> Hi Stephen,
>
> Yes it seems like current api lacks the needed functionality and what
> you are suggesting is needed. Thank you for confirming it.

To add my two cents at this point, I would be in favor of a new LSM
hook rather than hijacking security_ismaclabel().  It seems that every
few years someone comes along and asks for a way to detect various LSM
capabilities, this might be the right time to introduce a LSM API for
this.

My only concern about adding such an API is it could get complicated
very quickly.  One nice thing we have going for us is that this is a
kernel internal API so we don't have to worry about kernel/userspace
ABI promises, if we decide we need to change the API at some point in
the future we can do so without problem.  For that reason I'm going to
suggest we do something relatively simple with the understanding that
we can change it if/when the number of users grow.

To start the discussion I might suggest the following:

#define LSM_FQUERY_VFS_NONE     0x00000000
#define LSM_FQUERY_VFS_XATTRS   0x00000001
int security_func_query_vfs(unsigned int flags);

... with an example SELinux implementation looks like this:

int selinux_func_query_vfs(unsigned int flags)
{
    return !!(flags & LSM_FQUERY_VFS_XATTRS);
}

-- 
paul moore
www.paul-moore.com
