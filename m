Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CD1130D919
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Feb 2021 12:46:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234083AbhBCLps (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 3 Feb 2021 06:45:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234243AbhBCLpp (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 3 Feb 2021 06:45:45 -0500
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B2C5C061786
        for <linux-nfs@vger.kernel.org>; Wed,  3 Feb 2021 03:45:05 -0800 (PST)
Received: by mail-io1-xd29.google.com with SMTP id y19so24877177iov.2
        for <linux-nfs@vger.kernel.org>; Wed, 03 Feb 2021 03:45:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=Hi10Dgo4Dld0hIXGc+9fa8XYhJh1WT36l7hOvsAkqZI=;
        b=cpbrWT3D6hKCfdSyCRc6Qkn4I0dWXvVGyvgJOtKpcHbcK01NPnHYyOzMhd+mI0ruAw
         70pCqwInuHXoobCwfXOchPE4+UgZLF1/oD99j0HEX52ekDYzuo/EUqDg6volGGlE5hqH
         4gCqM1Kpp986LH9J8qHxUrlKWNxZJoa/1nzzFBCYi+1amZ3G3sOmjIiUliQB61cHjWoi
         gRBxQO4Tivo1iNHVCyb6fwVd+2R0TH3IiUwa7aU/c3KCMgTYo0EfbYu1CZhOEIf+NbbY
         1z9mLJOSeAg/pUuuf9BzmM4DGWtTvJt+aVMlLH9TTGdJ95gyJ3UBPH2wzKq3/HeBTyt5
         w48Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=Hi10Dgo4Dld0hIXGc+9fa8XYhJh1WT36l7hOvsAkqZI=;
        b=sQWwVQa7NUmsoFgRRT0bhfmWvKvXTDmwkoqFCvsQvyi8MW8IzpiTRbzn6PMa0E7Qb+
         tJg3TOSm3qYOXu2u+DR/qsjyL/EXyPI/CDu0WFSfwYS64kiSpX8lL6CLTIBt59BQFmux
         /CMsTTesKs0e+obIJrPPhnIJvgcTgB8YyoqbQtAtvie5mxwP03/tD9v4gEVd1BnUTSaR
         WYwWTmrf4RNfQXHrX/vRNw2gw30AWMYprdC/BGoUEenAuVXApkZXN0hn9VZsV5WbR3L8
         WWN13psPVhy5baOGtDKfgiXJhqQNGolFRHZdIrcKd/yskIMJVq86ew+WP4SGRH1n7l/e
         GhEw==
X-Gm-Message-State: AOAM532l0h70uvDdE+j+M4aDGmoP8UBIf896XNB2Ya+b+GTCRmh0K8qu
        OxRimi9xP8QCpGTCjxQMBxUu2Q6AOq9xBEBw6JSPMZyUkawe2w==
X-Google-Smtp-Source: ABdhPJyJn8i1wEnOWaHvjVaOkhOtB66Wzug/PaqbzdtH9LMuE1zo9XADswhPB0iVb+j7dK13Bbzcz338N1xPPvdAMJI=
X-Received: by 2002:a05:6602:c9:: with SMTP id z9mr2114665ioe.174.1612352704925;
 Wed, 03 Feb 2021 03:45:04 -0800 (PST)
MIME-Version: 1.0
From:   Kinglong Mee <kinglongmee@gmail.com>
Date:   Wed, 3 Feb 2021 19:44:53 +0800
Message-ID: <CAB6yy34atCfZ5Wz8ECqYwj6N0Gmz5KhKG8b6RLDXC6Hq5-x0qw@mail.gmail.com>
Subject: Data corrupt after truncate at nfs client v3 mount point when nfs
 server restart
To:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <schumaker.anna@gmail.com>,
        Chuck Lever <chuck.lever@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hello,

I meet a data corrupt problem at nfs client v3 mount point without sync
at centos 7.6. (kernel 3.10.0-957.el7.x86_64).

When runing ltp ftest01 test case with restart/reboot nfs server,
ftest01 reports data corrupt or size mismatch sometimes.

Debugging shows,
1. The WRITE reply contains a write verifier, and the COMMIT reply
    contains a verifer too.The knfsd encodes nfsd_net_id for the
    two verifers, other nfs server (eg, nfs-ganesha) encodes the daemon
    start time. After nfs server restart/reboot, the verifier is changed.
2. For mounting without sync, nfs client uses buffer io, sends WRITE
    request with unstable argument.
    After unstable WRITE success, it is added to commit list, not be
    deleted directly.
3. Following sync(fsync) or setattr(truncate) will occurs a COMMIT,
    if COMMIT success and the returned verifier is same as the unstable
    WRITE in commit list, the unstable WRITE is deleted; otherwise the
    unstable WRITE will be resend to nfs server.
    It's in nfs_commit_release_pages().
4. After nfs server restart, the COMMIT may be processed by the newer
    server that a different verifier is returned with COMMIT success.
    At this case, those unstable WRITE will be resend but COMMIT finish
    without any error and does not wait those resending WRITEs.
5. For sync(fsync), it's okay; but for setattr(truncate), data corrupt
    appears that those resending WRITEs may be send to server with the
    SETATTR for truncate simultaneously.
6. nfs_setattr() only does a nfs_sync_inode without processing the
    result.

/* Write all dirty data */
if (S_ISREG(inode->i_mode))
nfs_sync_inode(inode);

Also, nfs_initiate_commit() does not return error for FLUSH_SYNC
when COMMIT meeting error.

Maybe we should return error to upper caller (the nfs_setattr()) who
doing FLUSH_SYNC commit when COMMIT meets different verifier as those
unstable WRITEs. With the error, upper caller may return error or
do nfs_sync_inode again.

Although I meet this problem at a older kernel, but the logical in the
latest nfs client source does not be updated.

Any suggestion is welcome.

thanks,
Kinglong Mee
