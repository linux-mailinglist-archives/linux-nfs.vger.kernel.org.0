Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 770BA70FB81
	for <lists+linux-nfs@lfdr.de>; Wed, 24 May 2023 18:14:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233072AbjEXQOx (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 24 May 2023 12:14:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234020AbjEXQOv (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 24 May 2023 12:14:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA274122
        for <linux-nfs@vger.kernel.org>; Wed, 24 May 2023 09:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684944851;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fQ8HGz/8PogFAssEpLQqVOmne0GpZ/pJdJitN20arrE=;
        b=D0333hj3xdN9fsDe6+u8hMadWkz5Yfp04dJDP0+fnztB9DV/3ZN6LTkD38MqjFC3cQWc/w
        /KzbG7F5mbJGGiaHALZuNJV0uz1BIlIis2LAuxdrbTisi+lGJpOPw3jzWHdTVb1zHETSmw
        DIdu/LhSCroxQpz1XXpqPIrU4u+UNiE=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-624-tQCucx1rOxuHldRn6Cugxw-1; Wed, 24 May 2023 12:14:09 -0400
X-MC-Unique: tQCucx1rOxuHldRn6Cugxw-1
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-53ba38cf091so241462a12.1
        for <linux-nfs@vger.kernel.org>; Wed, 24 May 2023 09:14:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684944848; x=1687536848;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fQ8HGz/8PogFAssEpLQqVOmne0GpZ/pJdJitN20arrE=;
        b=i77h0FbQuvuVmDtreKrXPXpLsP/nUb4vUIACR8C6S1AlhSVqk6nJVRt3lx/liHykBM
         tW63yz2G/SdbyfU9YWp+2pFD3S0T6lJ5zRRPDh4V1pwiXeGv85X4PyOADmVZ17NJ0gkY
         djMrMO23Q7xZ0cASvVuQIgyLhVAOKrhsZMYE3TIeO2HUi9nCSg7vmw+loqctUD0teZq6
         wVXneg7wh0PZYOO06F2pETXbQUMSy/vktgKWoGDfyJO+4hsirV91jZiDJKhmn3Zyscb4
         eeYCgGFIXDxtHQsuXS7/UlMe6zJ/y9io1Lx0Dao2I88yIr/VBhv07bf0fAC09fYjie+g
         SeWA==
X-Gm-Message-State: AC+VfDxYfSwDou943wnAreNhg+NZ7j0Q3jJlbKU0DVIZKFtPB0L3CJaH
        z650nSqJYppGPDid1rEJgnDVVsJ7mdri35qjQYMC/ZMEmfcfyY2In5IF44Coz4aVUXUEESuZkNM
        iK7Cc+KQvXtAZj5s60S5pdGNQHwHXWdUZ7+CX
X-Received: by 2002:a17:903:32cd:b0:1a9:581b:fbb1 with SMTP id i13-20020a17090332cd00b001a9581bfbb1mr20622412plr.32.1684944848417;
        Wed, 24 May 2023 09:14:08 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6ksRPI6C4Qbm3XTs2zMXExteCDHT1ueFX45NNxUR3Bmh0dl7msPgHXt9a+INLTvOYk2oEw3SpVm/ptycvFULM=
X-Received: by 2002:a17:903:32cd:b0:1a9:581b:fbb1 with SMTP id
 i13-20020a17090332cd00b001a9581bfbb1mr20622391plr.32.1684944848109; Wed, 24
 May 2023 09:14:08 -0700 (PDT)
MIME-Version: 1.0
References: <CAAmbk-f_U8CPcTQM866L572uUHdK4p5iWKnUQs4r8fkW=6RW9g@mail.gmail.com>
 <CALF+zO=1oASFeb5WOezeZm_fbCuw=L8AL-n-mbCt8A==ZMAy3Q@mail.gmail.com>
 <CAAmbk-cgTR+FxLY2C=upuPBwNaBYff=GHedXyQiFf=Hr5i3G0A@mail.gmail.com> <CALF+zO=vjPjs8QevssUmGHA_bZaTaF3HcqQa+OQgxegqB5yzmw@mail.gmail.com>
In-Reply-To: <CALF+zO=vjPjs8QevssUmGHA_bZaTaF3HcqQa+OQgxegqB5yzmw@mail.gmail.com>
From:   David Wysochanski <dwysocha@redhat.com>
Date:   Wed, 24 May 2023 12:13:32 -0400
Message-ID: <CALF+zOn_qX4tcT2ucq4jD3G-1ERqZkL6Cw7hx75OnQF0ivqSeA@mail.gmail.com>
Subject: Re: [Linux-cachefs] [BUG] fscache writing but not reading
To:     Chris Chilvers <chilversc@gmail.com>
Cc:     linux-nfs@vger.kernel.org, linux-cachefs@redhat.com,
        brennandoyle@google.com, Benjamin Maynard <benmaynard@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, May 19, 2023 at 7:53=E2=80=AFAM David Wysochanski <dwysocha@redhat.=
com> wrote:
>
> On Thu, May 18, 2023 at 4:21=E2=80=AFPM Chris Chilvers <chilversc@gmail.c=
om> wrote:
> >
> > On Tue, 16 May 2023 at 20:28, David Wysochanski <dwysocha@redhat.com> w=
rote:
> > >
> > > On Tue, May 16, 2023 at 11:42=E2=80=AFAM Chris Chilvers <chilversc@gm=
ail.com> wrote:
> > > >
> > > > While testing the fscache performance fixes [1] that were merged in=
to 6.4-rc1
> > > > it appears that the caching no longer works. The client will write =
to the cache
> > > > but never reads.
> > > >
> > > Thanks for the report.
> > >
> > > If you reboot do you see reads from the cache?
> >
> > On the first read after a reboot it uses the cache, but subsequent
> > reads do not use the cache.
> >
> > > You can check if the cache is being read from by looking in
> > > /proc/fs/fscache/stats
> > > at the "IO" line:
> > > # grep IO /proc/fs/fscache/stats
> > > IO     : rd=3D80030 wr=3D0
> >
> > Running the tests 4 times (twice before reboot, and twice after) give
> > the following metrics:
> > FS-Cache I/O (delta)
> > Run       rd        wr
> >  1         0    39,250
> >  2       130    38,894
> >  3    39,000         0
> >  4        72    38,991
> >
> > > Can you share:
> > > 1. NFS server you're using (is it localhost or something else)
> > > 2. NFS version
> >
> > The NFS server and client are separate VMs on the same network.
> > Server NFS version: Ubuntu 22.04 jammy, kernel 5.15.0-1021-gcp
> > Client NFS version: Ubuntu 22.04 jammy, kernel 6.4.0-060400rc1-generic
> > (https://kernel.ubuntu.com/~kernel-ppa/mainline/v6.4-rc1/)
> > Client nfs-utils: 2.6.3-rc6
> > Client cachefilesd: 0.10.10-0.2ubuntu1
> >
> > > In addition to checking the above for the reads from the cache, you c=
an also
> > > see whether NFS reads are going over the wire pretty easily with a si=
milar
> > > technique.
> > >
> > > Copy /proc/self/mounstats to a file before your test, then make a sec=
ond copy
> > > after the test, then run mountstats as follows:
> > > mountstats -S /tmp/mountstats.1 -f /tmp/mountstats.2
> >
> > app read    =3D applications read bytes via read(2)
> > client read =3D client read bytes via NFS READ
> >
> > Run           app read        client read
> >  1     322,122,547,200    322,122,547,200
> >  2     322,122,547,200    321,048,805,376
> >  3     322,122,547,200                  0
> >  4     322,122,547,200    321,593,053,184
> >
> > I've put the full data in a GitHub gist, along with a graph collected
> > from a metrics agent:
> > https://gist.github.com/chilversc/54eb76155ad37b66cb85186e7449beaa
> > https://gist.githubusercontent.com/chilversc/54eb76155ad37b66cb85186e74=
49beaa/raw/09828c596d0cfc44bc0eb67f40e4033db202326e/metrics.png
> >
>
> Thanks Chris for all this info.  I see you're using NFSv3 so I'll
> focus on that, and review all this info for clues.
> I also have been working on some updated test cases and see some very
> unusual behavior like you're reporting.
>
> I also confirmed that adding the two patches for "Issue #1"  onto
> 6.4-rc1 resolve _most_ of the caching issues.
> However, even after those patches, in some limited instances, there
> are still NFS reads over the wire when there should only be reads from
> the cache.
> There may be multiple bugs here.

I actually misspoke regarding "multiple bugs", as I forgot to add a
small NFS hunk (see below) needed to dhowells 2nd patch (v6 of mm,
netfs, fscache: Stop read optimisation when folio removed from
pagecache).
After the below small hunk was added on top of dhowells 2nd patch, all
my tests pass.
I've also enhanced my existing tests to check NFS READs, fscache
READs, and fscache WRITEs as expected.
And I added an additional test to create files the size of RAM, read
them multiple times, and check for the ops are as expected.
So I'm confident if we add dhowells 2 patches, plus the below hunk for
NFS, these caching issues will be resolved.

diff --git a/fs/nfs/fscache.c b/fs/nfs/fscache.c
index 8c35d88a84b1..d4a20748b14f 100644
--- a/fs/nfs/fscache.c
+++ b/fs/nfs/fscache.c
@@ -180,6 +180,10 @@ void nfs_fscache_init_inode(struct inode *inode)
                                               &auxdata,      /* aux_data *=
/
                                               sizeof(auxdata),
                                               i_size_read(inode));
+
+       if (netfs_inode(inode)->cache)
+               mapping_set_release_always(inode->i_mapping);
+
 }

 /*

