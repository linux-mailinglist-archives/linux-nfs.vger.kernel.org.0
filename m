Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A1DE7D548D
	for <lists+linux-nfs@lfdr.de>; Tue, 24 Oct 2023 16:59:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234612AbjJXO7L (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 24 Oct 2023 10:59:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234594AbjJXO7L (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 24 Oct 2023 10:59:11 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78E05111;
        Tue, 24 Oct 2023 07:59:09 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id 6a1803df08f44-66d4453ba38so28523926d6.0;
        Tue, 24 Oct 2023 07:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698159548; x=1698764348; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lgC1tceMFuFWQh3HbwcDE2UVKXUmrKtvxdP2vIm+wYw=;
        b=UGBPU5SRcFK8aZpJDcKkOsUzxKplU+fEykeBJceljGnYzk6WvOcnpCo1D59Sy86iV9
         T4/eqEIlydXIE8RAyncrErdpvWWP/n+hroehfPHau08wlWj7MRf7Hh6DUddSKnnNbwQl
         b23Fdn+4DmXFf1dINoZzVIGpJrhH9YKfGwtjGCWfxRsygmHIma3U4T8iMGzXcqEycleP
         El7hzJxDw+MYneyl6548IPhrxy7u1CTsMEscWF1niD4TANBGriDdsy109x2f858p97J9
         xLVNibL2cbQHnRBINBDSAM6zwGkgx1UJWfgNyYGn/t9nLUAA8Qfoa5VC7L95NOwYkPll
         YMaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698159548; x=1698764348;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lgC1tceMFuFWQh3HbwcDE2UVKXUmrKtvxdP2vIm+wYw=;
        b=FgsalX7c5RV9iluJz36J+7Cff3EaSzJzFHCRHzYqMdx0K+EsOm9HcEMs2jJJR030g2
         42sRDRDkNfB4P7kNr7Vn62exxwqpsgsgXdUZkbJkmFlxtdCWqvhbmj0yO294xHT0C7k0
         VSZ6L6VOBRHRVbbSsGJ0Z3Ru7X8wMlUT5WUYV9Pzh59KGDasbUG4kcut/hzn5920QA8V
         zAr/ThbtPX2nFHmchPYtv0KGzO8+AvtgqR77tUO27WJocRVVdZU+Zti7zUikO0d/D6OB
         gMVuGWRy9jaYxo8DgUSPoBpmTkUZlQn4EgEAe2U2VdKLkp4b1+M5nPIn413CjA9dPMca
         uUUA==
X-Gm-Message-State: AOJu0Yw5ngvApwUVQ5TSMsFnYIiEhKbNn3TUlaoqgGIdlvW5FWxN+v8G
        YeFfMAKKUSBunmGiekkVjqwr4HQ720rdQY39m2Q=
X-Google-Smtp-Source: AGHT+IHrPj+CY3Fq33tp7/y60luma0WG70v1g+RWQ4k5Z/GgQWxnimTKhpiCcGrtqeYYftWomBMsfsJMcYyciiCSlQk=
X-Received: by 2002:a05:6214:2266:b0:66d:1174:3b46 with SMTP id
 gs6-20020a056214226600b0066d11743b46mr19435648qvb.50.1698159548459; Tue, 24
 Oct 2023 07:59:08 -0700 (PDT)
MIME-Version: 1.0
References: <20231024110109.3007794-1-amir73il@gmail.com> <1CFE0178-CE91-4C99-B43E-33EF78D0BEBF@redhat.com>
In-Reply-To: <1CFE0178-CE91-4C99-B43E-33EF78D0BEBF@redhat.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 24 Oct 2023 17:58:57 +0300
Message-ID: <CAOQ4uxhe5pH3yRxFS_8pvtCgbXspKB6r9aacRJ8FysGQE2Hu9g@mail.gmail.com>
Subject: Re: [PATCH] nfs: derive f_fsid from server's fsid
To:     Benjamin Coddington <bcodding@redhat.com>
Cc:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        Jeff Layton <jlayton@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Christian Brauner <brauner@kernel.org>,
        Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
        linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Oct 24, 2023 at 5:01=E2=80=AFPM Benjamin Coddington <bcodding@redha=
t.com> wrote:
>
> On 24 Oct 2023, at 7:01, Amir Goldstein wrote:
>
> > Fold the server's 128bit fsid to report f_fsid in statfs(2).
> > This is similar to how uuid is folded for f_fsid of ext2/ext4/zonefs.
> >
> > This allows nfs client to be monitored by fanotify filesystem watch
> > for local client access if nfs supports re-export.
> >
> > For example, with inotify-tools 4.23.8.0, the following command can be
> > used to watch local client access over entire nfs filesystem:
> >
> >   fsnotifywatch --filesystem /mnt/nfs
> >
> > Note that fanotify filesystem watch does not report remote changes on
> > server.  It provides the same notifications as inotify, but it watches
> > over the entire filesystem and reports file handle of objects and fsid
> > with events.
>
> I think this will run into trouble where an NFSv4 will report both
> fsid.major and fsid.minor as zero for the special root filesystem.   We c=
an
> expect an NFSv4 client to have one of these per server.
>
> Could use s_dev from nfs_server for a unique major/minor for each mount o=
n
> the client, but these values won't be stable against a particular server
> export.
>

That's a good point.
Not sure I understand the relation between mount/server/export.

If the client mounts the special NFSv4 root filesystem at /mnt/nfs,
are the rest of the server exports going to be accessible via the same
mount/sb or via new auto mounts of different nfs sb?

In any case, f_fsid does not have to be uniform across all inodes
of the same sb. This is the case with btrfs, where the the btrfs sb
has inodes from the root volume and from sub-volumes.
inodes from btrfs sub-volumes have a different f_fsid than inodes
in the root btrfs volume.

We try to detect this case in fanotify, which currently does not
support watching btrfs sub-volume for that reason.
I have a WIP branch [1] for handling non-uniform f_fsid in
fanotify by introducing the s_op->get_fsid(inode) method.

Anyway, IIUC, my proposed f_fsid change is going to be fine for
NFSv2/3 and best effort for NFSv4:
- For NFSv2/3 mount, f_fsid is a good identifier?
- For NFSv4 mount of a specific export, f_fsid is a good identifier?
- For the NFSv4 root export mount, f_fsid remains zero as it is now

Am I understanding this correctly?
Do you see a reason not to make this change?
Do you see a reason to limit this change for NFSv2/3?

Thanks,
Amir.

[1] https://github.com/amir73il/linux/commits/inode_fsid
