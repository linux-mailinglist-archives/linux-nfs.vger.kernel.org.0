Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EDCD705716
	for <lists+linux-nfs@lfdr.de>; Tue, 16 May 2023 21:29:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbjEPT3q (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 16 May 2023 15:29:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjEPT3p (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 16 May 2023 15:29:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3C66B5
        for <linux-nfs@vger.kernel.org>; Tue, 16 May 2023 12:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684265337;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bYmucfjpnAVSg8OqVdBBlDfXxKfZQdV3kdH7yQdtIZc=;
        b=CkVR47hKoPTC147VQX6b25ISOruwsdzmudzDDv9t6DRNqz0+w3/lLacJBHwCZeGIubbRRm
        HjUEKvCvsHSkxU2evnjqmqwPJBI1gxsOYSlFVWF68WZ/eux7z9xF9vY/5JBOnWQ16xcaiC
        8ITfwFx+xJIw/0IFjcOhWNBMsihN6Z8=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-542-lPumbmrUM46ravYrUqHjLg-1; Tue, 16 May 2023 15:28:55 -0400
X-MC-Unique: lPumbmrUM46ravYrUqHjLg-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-24de504c5fcso32484a91.2
        for <linux-nfs@vger.kernel.org>; Tue, 16 May 2023 12:28:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684265334; x=1686857334;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bYmucfjpnAVSg8OqVdBBlDfXxKfZQdV3kdH7yQdtIZc=;
        b=MTg9S7ZiecKafu6TDmZMbhuUTGFqM3Vt8Fr1nejZRg3x96a7xuZfAP05lC4QlCZwiL
         5CfJO5ITDBDxQXKH5tZyKxd0ZWpgfKDCldPTCw27lwrFsZwFOaS/Scn+8o3tfymAsC6w
         imL0DA5oSS2kNdspCv9sX6tWjdbRfogt+PXipIboo4INAfrScOgCnlS5IbjWDciVpu6Y
         LJD/4a6nyAckvza6xCxomnQODEsiSVyDa6+e3AzcAXY1FQ+M9VNRfEZYVnx5Sg+zZMt8
         k8DKraSRtE2/1E8vtrHYYHRONQ5aJvAprgjKOgJry4il1TUAtVCRpuPNSNgshbcERAxX
         sCKQ==
X-Gm-Message-State: AC+VfDy4fTbwvloK+igEgqK3oOeNRKoFH0TqBfMstnhfUsguQ9pLI8st
        YYXI18q9iWTtWobzu1NFByCgb0UCMjbWwiNDTQ8EW2TtFW+0MOUJNAzMGOpkndSM2YZ36qbBL3E
        TRbPI9K/FnOQOtTo7ZbQgpKrhaqTEK3TGSOUA
X-Received: by 2002:a17:90b:33c7:b0:250:69c7:a95e with SMTP id lk7-20020a17090b33c700b0025069c7a95emr31056918pjb.48.1684265334463;
        Tue, 16 May 2023 12:28:54 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ560AMr/zL3GYG9F5BUX5SUUiepblXLTbu7Ntnw4Qdxg3GHdcGBO4Mz6NonG/zSmGI3irqD6OmgUYCJA2iA5Cw=
X-Received: by 2002:a17:90b:33c7:b0:250:69c7:a95e with SMTP id
 lk7-20020a17090b33c700b0025069c7a95emr31056904pjb.48.1684265334155; Tue, 16
 May 2023 12:28:54 -0700 (PDT)
MIME-Version: 1.0
References: <CAAmbk-f_U8CPcTQM866L572uUHdK4p5iWKnUQs4r8fkW=6RW9g@mail.gmail.com>
In-Reply-To: <CAAmbk-f_U8CPcTQM866L572uUHdK4p5iWKnUQs4r8fkW=6RW9g@mail.gmail.com>
From:   David Wysochanski <dwysocha@redhat.com>
Date:   Tue, 16 May 2023 15:28:17 -0400
Message-ID: <CALF+zO=1oASFeb5WOezeZm_fbCuw=L8AL-n-mbCt8A==ZMAy3Q@mail.gmail.com>
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

On Tue, May 16, 2023 at 11:42=E2=80=AFAM Chris Chilvers <chilversc@gmail.co=
m> wrote:
>
> While testing the fscache performance fixes [1] that were merged into 6.4=
-rc1
> it appears that the caching no longer works. The client will write to the=
 cache
> but never reads.
>
Thanks for the report.

If you reboot do you see reads from the cache?

You can check if the cache is being read from by looking in
/proc/fs/fscache/stats
at the "IO" line:
# grep IO /proc/fs/fscache/stats
IO     : rd=3D80030 wr=3D0

You might consider saving that file before your test, then another copy aft=
er,
and doing a diff:
# diff -u /tmp/fscachestats.1 /tmp/fscachestats.2
--- /tmp/fscachestats.1 2023-05-16 14:48:43.126158403 -0400
+++ /tmp/fscachestats.2 2023-05-16 14:54:05.421402702 -0400
@@ -1,14 +1,14 @@
 FS-Cache statistics
-Cookies: n=3D0 v=3D1 vcol=3D0 voom=3D0
-Acquire: n=3D0 ok=3D0 oom=3D0
-LRU    : n=3D0 exp=3D0 rmv=3D0 drp=3D0 at=3D0
+Cookies: n=3D5 v=3D1 vcol=3D0 voom=3D0
+Acquire: n=3D5 ok=3D5 oom=3D0
+LRU    : n=3D0 exp=3D5 rmv=3D0 drp=3D0 at=3D0
 Invals : n=3D0
-Updates: n=3D0 rsz=3D0 rsn=3D0
+Updates: n=3D5 rsz=3D0 rsn=3D0
 Relinqs: n=3D0 rtr=3D0 drop=3D0
 NoSpace: nwr=3D0 ncr=3D0 cull=3D6
-IO     : rd=3D0 wr=3D0
-RdHelp : RA=3D0 RP=3D0 WB=3D0 WBZ=3D0 rr=3D0 sr=3D0
+IO     : rd=3D40015 wr=3D0
+RdHelp : RA=3D40015 RP=3D0 WB=3D0 WBZ=3D0 rr=3D0 sr=3D0
 RdHelp : ZR=3D0 sh=3D0 sk=3D0
 RdHelp : DL=3D0 ds=3D0 df=3D0 di=3D0
-RdHelp : RD=3D0 rs=3D0 rf=3D0
+RdHelp : RD=3D40015 rs=3D40015 rf=3D0
 RdHelp : WR=3D0 ws=3D0 wf=3D0


> I suspect this is related to known issue #1. However, I tested the client
> with rsize less than, equal to, and greater than readahead, and in all ca=
ses
> I see the issue.
>
> If I apply both the patches [2], [3] from the known issues to 6.4-rc1 the=
n the
> cache works as expected. I suspect only patch [2] is required but have no=
t
> tested patch [2] without [3].
>
Agree it's likely only the patches from issue #1 are needed.
Let me ping dhowells and willy on that thread for issue #1 as it looks
stalled.


> Testing
> =3D=3D=3D=3D=3D=3D=3D
> For the test I was just using dd to read 300 x 1gb files from an NFS
> share to fill the cache, then repeating the read.
>
Can you share:
1. NFS server you're using (is it localhost or something else)
2. NFS version

> In the first test run, /var/cache/fscache steadily filled until reaching
> 300 GB. The read I/O was less than 1 MB/s, and the write speed was fairly
> constant 270 MB/s.
>
> In the second run, /var/cache/fscache remained at 300 GB, so no new data =
was
> being written. However, the read I/O remained at less than 1 MB/s and the=
 write
> rate at 270 MB/s.
>
>     /var/cache/fscache
>                 | 1st run     | 2nd run
>     disk usage  | 0 -> 300 GB | 300 GB
>     read speed  | < 1 MB/s    | < 1 MB/s
>     write speed | 270 MB/s    | 270 MB/s
>
> This seems to imply that the already cached data was being read from the =
source
> server and re-written to the cache.
>

In addition to checking the above for the reads from the cache, you can als=
o
see whether NFS reads are going over the wire pretty easily with a similar
technique.

Copy /proc/self/mounstats to a file before your test, then make a second co=
py
after the test, then run mountstats as follows:
mountstats -S /tmp/mountstats.1 -f /tmp/mountstats.2



> Known Issues
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> 1. Unit test setting rsize < readahead does not properly read from
> fscache but re-reads data from the NFS server
> * This will be fixed with another dhowells patch [2]:
>   "[PATCH v6 2/2] mm, netfs, fscache: Stop read optimisation when
> folio removed from pagecache"
>
> 2. "Cache volume key already in use" after xfstest runs involving
> multiple mounts
> * Simple reproducer requires just two mounts as follows:
>  mount -overs=3D4.1,fsc,nosharecache -o
> context=3Dsystem_u:object_r:root_t:s0  nfs-server:/exp1 /mnt1
>  mount -overs=3D4.1,fsc,nosharecache -o
> context=3Dsystem_u:object_r:root_t:s0  nfs-server:/exp2 /mnt2
> * This should be fixed with dhowells patch [3]:
>   "[PATCH v5] vfs, security: Fix automount superblock LSM init
> problem, preventing NFS sb sharing"
>
> References
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> [1] https://lore.kernel.org/linux-nfs/20230220134308.1193219-1-dwysocha@r=
edhat.com/
> [2] https://lore.kernel.org/linux-nfs/20230216150701.3654894-1-dhowells@r=
edhat.com/T/#mf3807fa68fb6d495b87dde0d76b5237833a0cc81
> [3] https://lore.kernel.org/linux-kernel/217595.1662033775@warthog.procyo=
n.org.uk/
>
> --
> Linux-cachefs mailing list
> Linux-cachefs@redhat.com
> https://listman.redhat.com/mailman/listinfo/linux-cachefs
>

