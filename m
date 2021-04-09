Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDCA035A4C4
	for <lists+linux-nfs@lfdr.de>; Fri,  9 Apr 2021 19:39:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234169AbhDIRjc (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 9 Apr 2021 13:39:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:26735 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233038AbhDIRjb (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 9 Apr 2021 13:39:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617989958;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ctSABw2kjoLnR/9CPsehS2T91aGqZMmVOGM3FfnHLik=;
        b=BH7vAMMCRfOinjpFyXteIZ6epWmq8hl4d8tF38XkXET5lZX8hk5O7L0YmNsGvnqsdmsCGZ
        VtvnrtzZjYt+u0p9d40gEpB7jeyHSW6COIZVlA3zHXrMBwkJgC0V9N4qhvZ6HiStGXqZ5R
        pb7EjJqAw30COglbGc08UtzbdzN5HV8=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-523-aVmiTgpKME2G6yFRSp52dQ-1; Fri, 09 Apr 2021 13:39:16 -0400
X-MC-Unique: aVmiTgpKME2G6yFRSp52dQ-1
Received: by mail-yb1-f199.google.com with SMTP id i6so6059435ybk.2
        for <linux-nfs@vger.kernel.org>; Fri, 09 Apr 2021 10:39:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ctSABw2kjoLnR/9CPsehS2T91aGqZMmVOGM3FfnHLik=;
        b=Imo0csI+x84rzSQFSgJxKG259Hc2/Xln3w4T45NsBcI3G9pE80iwVvzPl7lJH1aok2
         65L86bw+AhBYXQHY5FwnXeTJNK96y99rEY5ANTv8/OR8QBD4mCYs1EXxxu+BQr77g30M
         uRxDyEbZYwWsUVS1rCExR3lbat7hjnFWujROn4wDJiFpG9mUTNPTDNZuVss7HvFyo1i+
         0JBXtqHB5w8DgHBWdWJRGDFoyx7i6VBOs/ktdRCUvP50gi8XXbXTS3rQ7X4PqvoEelej
         PCL9Jv9oW+4IBFsdwCtsnSLKLOhdeCvgY56ZSiQ2p+Kkvlo16qIMZfmSgCXypoyPvePH
         h+MQ==
X-Gm-Message-State: AOAM533EKBueOxkAuKhfg91MZvwGJqp0qItMEm/gUcr7DxnTOEABqAvM
        RJDQa2KD5c3vxoi/yaYJUXD353zyujnVeFsJs1U7588rYqkPjRwatGz+vjXoQHPzH/AKfEMkbVk
        iP9iFVo3G7IhxC4/reYs5pMSp5PqrPeUrZkSg
X-Received: by 2002:a25:c607:: with SMTP id k7mr6756017ybf.227.1617989955815;
        Fri, 09 Apr 2021 10:39:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz+mTXRAzv4p+pKtFBXvvYgqFhiLeH+4Jst89hdPmwIQxdwoJP7Ld4xy5sP/8Zg8hbTmY6FfD9wYvwlUd9JMdk=
X-Received: by 2002:a25:c607:: with SMTP id k7mr6755995ybf.227.1617989955622;
 Fri, 09 Apr 2021 10:39:15 -0700 (PDT)
MIME-Version: 1.0
References: <20210409111254.271800-1-omosnace@redhat.com> <YHBITqlAfOk8IV5w@zeniv-ca.linux.org.uk>
In-Reply-To: <YHBITqlAfOk8IV5w@zeniv-ca.linux.org.uk>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Fri, 9 Apr 2021 19:39:02 +0200
Message-ID: <CAFqZXNuhog5YfaG9CBVmZ+C3mSzAEgZkSC-mrQGOD4vyLEz4Xw@mail.gmail.com>
Subject: Re: [PATCH 0/2] vfs/security/NFS/btrfs: clean up and fix LSM option handling
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        SElinux list <selinux@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org,
        linux-nfs <linux-nfs@vger.kernel.org>,
        linux-btrfs@vger.kernel.org, Paul Moore <paul@paul-moore.com>,
        Olga Kornievskaia <aglo@umich.edu>,
        David Howells <dhowells@redhat.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Apr 9, 2021 at 2:28 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
> On Fri, Apr 09, 2021 at 01:12:52PM +0200, Ondrej Mosnacek wrote:
> > This series attempts to clean up part of the mess that has grown around
> > the LSM mount option handling across different subsystems.
>
> I would not describe growing another FS_... flag

Why is that necessarily a bad thing?

> *AND* spreading the
> FS_BINARY_MOUNTDATA further, with rather weird semantics at that,
> as a cleanup of any sort.

How is this spreading it further? The patches remove one (rather bad)
use of it in SELinux and somewhat reduce its use in btrfs.

Hold on... actually I just realized that with FS_HANDLES_LSM_OPTS it
is possible to do btrfs without FS_BINARY_MOUNTDATA and also eliminate
the need for the workaround in vfs_parse_fs_param() (i.e. [2]).

Basically instead of setting FS_BINARY_MOUNTDATA | FS_HANDLES_LSM_OPTS
in btrfs_fs_type and neither in btrfs_root_fs_type, it is enough to
set neither in btrfs_fs_type and only FS_HANDLES_LSM_OPTS in
btrfs_root_fs_type. The security opts are then applied in the outer
vfs_get_tree() call instead of the inner one, but the net effect is
the same.

That should pretty much do away with both the non-legit users of
FS_BINARY_MOUNTDATA (selinux_set_mnt_opts() and btrfs). All the rest
seem to be in line with the semantic.

Would [something like] the above stand any chance of getting your approval?

[2] https://lore.kernel.org/selinux/20210401065403.GA1363493@infradead.org/T/

--
Ondrej Mosnacek
Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

