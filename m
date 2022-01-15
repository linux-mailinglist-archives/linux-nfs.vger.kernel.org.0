Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD6C248F725
	for <lists+linux-nfs@lfdr.de>; Sat, 15 Jan 2022 14:51:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbiAONvB (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 15 Jan 2022 08:51:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:37458 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229638AbiAONvB (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 15 Jan 2022 08:51:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642254660;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3ZV49E7aqmqZM99y5BEDF0EXRATcaFt/Is0SZbIogOE=;
        b=LdEAtqRjF7UX61jvx6UwBh+npbC7v+jIQGNqyaAfrv2Umg08c4go/DQAObpcaH/MfvHLYo
        +n1wZ4I9UXq7ZU92o3xDZsb/R79IIJIG4/QAsR/1N0BHJm2jvSUSxk83nQeTGwtZmce2wr
        O92+VReZHh6ifE9AW6zkK6zBo31oYdU=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-490-UFU2LC6UMtKRGmMrodX6wA-1; Sat, 15 Jan 2022 08:50:59 -0500
X-MC-Unique: UFU2LC6UMtKRGmMrodX6wA-1
Received: by mail-ed1-f70.google.com with SMTP id j10-20020a05640211ca00b003ff0e234fdfso10504161edw.0
        for <linux-nfs@vger.kernel.org>; Sat, 15 Jan 2022 05:50:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3ZV49E7aqmqZM99y5BEDF0EXRATcaFt/Is0SZbIogOE=;
        b=sv/PCNGCYyn7dqdhULw38HYPmfkEIGtOyCmHQNxB8NhYvaHV17/3iapByhW55WcZbK
         zGaAKATJm9FqKWubkI7THETKnxeTQgmaryx9LJHhkEU59KqHeO6VrbAkpt66z9ma7VEK
         4fnDrurKEDAaElL9ABAoQQw7RuWTb3W+tWiCG012EjFq9GB5sHDjwPpIWYr9TFyPuHL1
         5+HJJs4yb64A+nnKilAzggeWr98S+34dqYCU/WAD59dolzMbW/5Wq4fPMKKyV90uIfy0
         SgPMAMMz0pnnGvle2K86P/pJl8VqpYTCZQ/Pnhc28uTvVaydTAsHsHhmoanKfEYmvWYI
         j6Mw==
X-Gm-Message-State: AOAM532Xs6b2eMawx10vVKpWb5AVxgGOp1IIo2vpMaBNxiyO3+cmRJ/L
        NnM+LpAHj92EnIyGO1f82fgzyAZcVlzYe5dsU9OtrI24QEAMuoUKwdkD+tSAcD4jxE4E4d7+cOj
        uLag9CUHDx7UgRZhyugYHKKsiE/KGcxX0oBxd
X-Received: by 2002:a17:906:ff47:: with SMTP id zo7mr11378794ejb.62.1642254657605;
        Sat, 15 Jan 2022 05:50:57 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxBJZWRWG7Y9wT3J+ql8Ego9/YUxTP7+VT2PzGSI3wjf7ff30xHtyJ3ntfvvCIYgKA+2OihViZ4bYiPEQK4s1M=
X-Received: by 2002:a17:906:ff47:: with SMTP id zo7mr11378785ejb.62.1642254657417;
 Sat, 15 Jan 2022 05:50:57 -0800 (PST)
MIME-Version: 1.0
References: <1639763665-4917-1-git-send-email-dwysocha@redhat.com>
In-Reply-To: <1639763665-4917-1-git-send-email-dwysocha@redhat.com>
From:   David Wysochanski <dwysocha@redhat.com>
Date:   Sat, 15 Jan 2022 08:50:21 -0500
Message-ID: <CALF+zOn4x6VQ434WgsUv1J=fKmY=WPJigBe=XS2Oni1D+ahf3w@mail.gmail.com>
Subject: Fwd: [PATCH v2 0/4] Cleanups for NFS fscache and convert from
 dfprintk to trace events
To:     Anna Schumaker <Anna.Schumaker@netapp.com>
Cc:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        David Howells <dhowells@redhat.com>,
        linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

FYI, these apply cleanly on top of linus tree now after the merge of
dhowells fscache-rewrite
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=8834147f9505661859ce44549bf601e2a06bba7c

I have rebased (no changes needed from the Dec post), did some final
tests (unit and xfstests) and re-pushed to
https://github.com/DaveWysochanskiRH/kernel/tree/nfs-fscache-5.17-rc1

I am not sure if it is too late for the merge window or not, or how
you handle such dependencies,
but wanted to let you know my status.  If you want me to re-post or
anything let me know.

Thanks.


---------- Forwarded message ---------
From: Dave Wysochanski <dwysocha@redhat.com>
Date: Fri, Dec 17, 2021 at 12:54 PM
Subject: [PATCH v2 0/4] Cleanups for NFS fscache and convert from
dfprintk to trace events
To: Anna Schumaker <anna.schumaker@netapp.com>, David Howells
<dhowells@redhat.com>
Cc: <linux-nfs@vger.kernel.org>, <linux-cachefs@redhat.com>


This is a second version of a series posted previously [1]
These ran into conflicts [2] with dhowell's fscache-rewrite patches [3],
and they probably should go in his fscache-rewrite.  Note that a couple
patches have been either dropped or folded into other patches, so there's
only 4 patches left from the original 7.

The patches are also at:
https://github.com/DaveWysochanskiRH/kernel/tree/fscache-rewrite-plus-nfs

Changes since v1
- Rebase on top of dhowells fscache-rewrite (v3) and Anna's linux-next to
avoid future conflicts
- Fold in "NFS: Use nfs_i_fscache() consistently within NFS fscache code"
to other patches
- Drop "NFS: Convert NFS fscache enable/disable dfprintks to tracepoints"
since we can use fscache trace events
- Combine the last two patches into one:
NFS: Remove remaining dfprintks related to fscache cookies
NFS: Remove remaining usages of NFSDBG_FSCACHE
- Dropped Signed-off-by and Reviewed-by tags due to rebase

[1] https://marc.info/?l=linux-nfs&m=163718744111509&w=2
[2] https://marc.info/?l=linux-nfs&m=163974120915758&w=2
[3] https://marc.info/?l=linux-nfs&m=163967071213398&w=2

Dave Wysochanski (4):
  NFS: Cleanup usage of nfs_inode in fscache interface and handle i_size
    properly
  NFS: Rename fscache read and write pages functions
  NFS: Replace dfprintks with tracepoints in fscache read and write page
    functions
  NFS: Remove remaining dfprintks related to fscache and remove
    NFSDBG_FSCACHE

 fs/nfs/fscache.c            | 53 +++++++++-----------------
 fs/nfs/fscache.h            | 45 ++++++++++------------
 fs/nfs/nfstrace.h           | 91 +++++++++++++++++++++++++++++++++++++++++++++
 fs/nfs/read.c               |  4 +-
 include/uapi/linux/nfs_fs.h |  2 +-
 5 files changed, 130 insertions(+), 65 deletions(-)

--
1.8.3.1

