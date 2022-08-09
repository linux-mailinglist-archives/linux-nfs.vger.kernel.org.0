Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BA9F58D9E5
	for <lists+linux-nfs@lfdr.de>; Tue,  9 Aug 2022 15:50:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244637AbiHINu3 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 9 Aug 2022 09:50:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244700AbiHINuP (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 9 Aug 2022 09:50:15 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0B2B1C117
        for <linux-nfs@vger.kernel.org>; Tue,  9 Aug 2022 06:50:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 847ACB815A1
        for <linux-nfs@vger.kernel.org>; Tue,  9 Aug 2022 13:50:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA8C7C433C1;
        Tue,  9 Aug 2022 13:50:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660053001;
        bh=gnWfusfA8hTGUFglGr5om8SSVMqchdB/oghSQxF9Bik=;
        h=Subject:From:To:Date:In-Reply-To:References:From;
        b=B8t65zOiVcALmKjLLY3EsoIIMf5se2DalDxlWYzTGnDVWBTZy+uFXjMfiHSCySL19
         03Bs5nabZ5taNsrZcVo6ZCqXqc//lcKHyX9zriMVbd9mJFMNyoIZ2QF6cJk4oZToRW
         WBSyo7kTYQiMt1iFEiadhRNzAWYpy+v4ErpTfIqC7U3Z0kefWef2rd8FOdGQE4cwew
         hmnnSDygXCluInUysjxf9Tt1Kx9iakU8d4/16w3oZ6So9oSUs0iktk7X6hxYin8v4x
         RBtqJzTmsgF04EqNqiXp0FJt9FdYUN6hVkYDvZ+mIjpVyiYRrSHrM1lqvFM7UK6YVU
         ig5BSlO+NTWSA==
Message-ID: <b5d62b32edcd3c0df17382a3442c5580ad2c9196.camel@kernel.org>
Subject: Re: Strange NFS file glob behavior
From:   Jeff Layton <jlayton@kernel.org>
To:     DANIEL K FORREST <dforrest@wisc.edu>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Date:   Tue, 09 Aug 2022 09:49:59 -0400
In-Reply-To: <20220809011700.bdiikqngwmxp3abf@cosmos.ssec.wisc.edu>
References: <20220809011700.bdiikqngwmxp3abf@cosmos.ssec.wisc.edu>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, 2022-08-09 at 01:17 +0000, DANIEL K FORREST wrote:
> I am seeing a strange glob behavior on NFS that I can't explain.
>=20
> The server has 16 files, foo/bar{01..16}.
>=20
> There are other files in foo/, and there are many other processes on
> the client accessing files in the directory, but the mount is readonly
> so the only create/delete activity is on the server, and it's all
> rsync, so create file and rename file, but no file deletions.
>=20
>=20
> When the 16th file is created (random order) processing is triggered
> by a message from a different host that is running the rsyncs.
>=20
> On the client, I run this command:
>=20
> $ stat -c'%z %n' foo/bar{01..16}
>=20
> And I see all 16 files.
>=20
> However, if I immediately follow that command with:
>=20
> $ stat -c'%z %n' foo/bar*
>=20

You may want to look at an strace of the shell, and see if it's doing
anything different at the syscall level in these two cases.
=20
> On rare occasions I see fewer than 16 files.
>=20
> The missing files are the ones most recently created, they can be seen
> by stat when explicitly enumerated, but the shell glob does not see
> all of the files.  This test is for verifying a problem with a program
> that is also sometimes not seeing files using readdir/glob.
>=20
>=20
> How can all 16 files be seen by stat, but not by readdir/glob?
>=20
>=20
> OS is CentOS 7.9.2009, 3.10.0-1127.19.1.el7.x86_64
> NFS mount is version 3, readonly, nordirplus, lookupcache=3Dpos
>=20
>=20

It'd be hard to say without doing deeper analysis, but in order to
process a glob, the shell has to issue one or more readdir() calls.
Those calls can be split into more than one READDIR RPC on the network
as well.

There is no guarantee that between each READDIR you issue that the
directory remains constant. It's easily possible to issue a readdir for
the first chunk of dentries, and then have a file that's in a later
chunk get renamed so that it's in that chunk.

You're also using v3. The timestamps on most Linux servers have a
granularity of a jiffy (~1ms). If multiple directory operations happen
within the same jiffy then the timestamp on the directory might not
appear to have changed even though some of its children had been
renamed. You may want to consider using v4 just to get the benefit of
its better cache coherency.

Given that you know what the files are named, you're probably better off
not using shell globs at all here. Just provide all of the file names on
the command line (like in your first example) and you avoid READDIR
activity altogether.
--=20
Jeff Layton <jlayton@kernel.org>
