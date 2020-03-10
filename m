Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4476B17F351
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Mar 2020 10:18:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726437AbgCJJSU (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 10 Mar 2020 05:18:20 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:33563 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726378AbgCJJST (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 10 Mar 2020 05:18:19 -0400
Received: by mail-il1-f194.google.com with SMTP id k29so6143480ilg.0
        for <linux-nfs@vger.kernel.org>; Tue, 10 Mar 2020 02:18:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Hhr2JQNCTfwAz5fM8AxpKXVAk7m03eW/WPRPp++R3bc=;
        b=CLeuNfcd8lneEopBSQtHp3Kt+HipoV0gZP6IuZpydHV2/p4TlsVqkfu5HowfqMTXt4
         B6Nes0PUjpXtVP2DD/+CYwm5MJkMF1NpiN6Pigz83+0gVtQu29MQJHpZf1loCCFWgnuY
         NvSCicUjakpnIekJzu1+qB/DP+TL60iT/Mg+Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Hhr2JQNCTfwAz5fM8AxpKXVAk7m03eW/WPRPp++R3bc=;
        b=hiBG8INfLzNs4eDW2amLPus4Swsw5Uy8vGtKATKUrUmYkYQwK9z6B5A7H91NmM+VER
         ezo7KLX3vekCUfieqcu/0jYmuY6wsfdWrWATLma43aHN6zMpwn6ut35XkMfMrDB29izS
         zVhTYvtB4Jwhcy+onAElPtPTAEbsjS0hvXyQME12gW5rK5z5hM3i0SSxeMDjWjBoJ8cf
         YKSaInCcYaWSTWQhLkaEVEz6gYyFe8bC24rQhhcGTUurSW1ZZ8CasFCPYdKLaRbDGzEA
         vUtsjA5X5PqcCwFvQ8AnNxgLG6WngvMi9PQrVYPapWqMZpIvSa1NMrGzz9G4z6rZ0I0y
         WshA==
X-Gm-Message-State: ANhLgQ1LCee39einQTul0D/IO8LfkKMQhJwsVvOcUqzXYIPeHM0sLoxh
        phVn6mEG5NHAjyiGVlMV7tkhgghB7/VNZPJLgeAOZw==
X-Google-Smtp-Source: ADFU+vugKYA3Ig1dwzBjyGS81nr/dzb7dU1rNPjVpJ6bTLDiyqMRJ04NHueIU+BRzWkQaOZi8m5WZXZZBMnnCNWaxaA=
X-Received: by 2002:a92:9602:: with SMTP id g2mr18883520ilh.212.1583831899169;
 Tue, 10 Mar 2020 02:18:19 -0700 (PDT)
MIME-Version: 1.0
References: <158376244589.344135.12925590041630631412.stgit@warthog.procyon.org.uk>
 <20200309200238.GB28467@miu.piliscsaba.redhat.com> <537182.1583794373@warthog.procyon.org.uk>
In-Reply-To: <537182.1583794373@warthog.procyon.org.uk>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 10 Mar 2020 10:18:08 +0100
Message-ID: <CAJfpegt9TqfyJuk0G-OJdWLiKuxSeY0cQKK=1GVf1fStA9COBw@mail.gmail.com>
Subject: Re: [PATCH 00/14] VFS: Filesystem information [ver #18]
To:     David Howells <dhowells@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Stefan Metzmacher <metze@samba.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, Aleksa Sarai <cyphar@cyphar.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Linux NFS list <linux-nfs@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Ian Kent <raven@themaw.net>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Christian Brauner <christian@brauner.io>,
        Jann Horn <jannh@google.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Karel Zak <kzak@redhat.com>, Jeff Layton <jlayton@redhat.com>,
        linux-fsdevel@vger.kernel.org,
        LSM <linux-security-module@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Mar 9, 2020 at 11:53 PM David Howells <dhowells@redhat.com> wrote:
>
> Miklos Szeredi <miklos@szeredi.hu> wrote:
>
> > >  (1) It can be targetted.  It makes it easy to query directly by path or
> > >      fd, but can also query by mount ID or fscontext fd.  procfs and sysfs
> > >      cannot do three of these things easily.
> >
> > See above: with the addition of open(path, O_PATH) it can do all of these.
>
> That's a horrible interface.  To query a file by path, you have to do:
>
>         fd = open(path, O_PATH);
>         sprintf(procpath, "/proc/self/fdmount/%u/<attr>");
>         fd2 = open(procpath, O_RDONLY);
>         read(fd2, ...);
>         close(fd2);
>         close(fd);
>
> See point (3) about efficiency also.  You're having to open *two* files.

I completely agree, opening two files is surely going to kill
performance of application needing to retrieve a billion mount
attributes per second.</sarcasm>

> > >  (2) Easier to provide LSM oversight.  Is the accessing process allowed to
> > >      query information pertinent to a particular file?
> >
> > Not quite sure why this would be easier for a new ad-hoc interface than for
> > the well established filesystem API.
>
> You're right.  That's why fsinfo() uses standard pathwalk where possible,
> e.g.:
>
>         fsinfo(AT_FDCWD, "/path/to/file", ...);
>
> or a fairly standard fd-querying interface:
>
>         fsinfo(fd, "", { resolve_flags = RESOLVE_EMPTY_PATH },  ...);
>
> to query an open file descriptor.  These are well-established filesystem APIs.

Yes.  The problem is with the "..." part where you pass random
structures to a function.   That's useful sometimes, but at the very
least it breaks type safety, and not what I would call a "clean" API.

> > Now onto the advantages of a filesystem based API:
> >
> >  - immediately usable from all programming languages, including scripts
>
> This is not true.  You can't open O_PATH from shell scripts, so you can't
> query things by path that you can't or shouldn't open (dev file paths, for
> example; symlinks).

Yes.  However, you just wrote the core of a utility that could do this
(in 6 lines, no less).  Now try that feat with fsinfo(2)!

Thanks,
Miklos
