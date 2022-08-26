Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CBC15A29B6
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Aug 2022 16:41:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344520AbiHZOlF (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 26 Aug 2022 10:41:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344430AbiHZOlA (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 26 Aug 2022 10:41:00 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B057BB02B1
        for <linux-nfs@vger.kernel.org>; Fri, 26 Aug 2022 07:40:58 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id w10so2387660edc.3
        for <linux-nfs@vger.kernel.org>; Fri, 26 Aug 2022 07:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc;
        bh=2mcb8k0VXzXqfM2ZttJcq55uhMWz9wotQDWFSKhCh+M=;
        b=MQd06gUIsCc8mgcyXWvLewZXzrDvOMQOSdpt2jN8HdgfFz2pWsrtmdFaw+r15snKeE
         x5Ny8l0hA4u2PTcwEyhlJLEu9x2EioBLs2keh2oZ6u89rVHfDuOmVkx/Fk6BX9c5eETo
         eBCfndtS+DzOAHClzchPfNRXEog76zehiCF3GxLvJmVI+9KEzkLkmTq4snJ6gkeai6Ee
         isqgQFxk2YmbcmmdVGV52MMj9PpegcM21J5k5Yp6nyNLTBRyOFBJmJsVDze+e/UjewCL
         fBfIKM95z3wF4eaOMoAJPZVb7I7nHyLjJ3eOcKmuFD4vzAFK/TIAzyZrUTRtdlqmeuJW
         8cuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc;
        bh=2mcb8k0VXzXqfM2ZttJcq55uhMWz9wotQDWFSKhCh+M=;
        b=hVm8jJjV7+RUIgU+gWGX8kdTBrwPScnkDrRBJz4v0WRAvdajWsqTgK8HSquhNKKRmz
         UQBGOtZfCM+oRavdi4hb8HPXPO6rRRvKhZv9s1SF8JjyCS8QKoW29TVZBZwYPPSvw/9N
         mUkH0Tif4CwkdmnvaB0cKd1AoNkAA3eP01YQt6ILZQmjV+4i3pdb/ySyqm++bm4u+Fyb
         vZkqfDx8PEhyQvi9e76UAeA1C5sZGNv0Ym4hcOXRWsXNqO+lY3kwdW8mPV7gEsevYrII
         e0Qo3G5cAfB04KEKIVJnqOvYYuRhfBHnFyZuQCACVmCE1/sV3GGEAUX9mefkUsSTMnck
         Q7PA==
X-Gm-Message-State: ACgBeo0zxCrE/I64fRizlXIYNhkILgND93wSyzcsk+jUVcFTpxJ0HGQ1
        7TQJ1sNxfF6gAr45Lwinz8G+MY+pPVhvqTtPr6qIMceM3Is=
X-Google-Smtp-Source: AA6agR4a8ZMafqpcOcRDeKQHujps+0TFWAxkYLLeqo1t3BBAzDeWG77093jlKFWydsDNFBB6yxAteF7pcQ3QNXNgT+U=
X-Received: by 2002:a05:6402:2d6:b0:447:ae9d:d0f1 with SMTP id
 b22-20020a05640202d600b00447ae9dd0f1mr6690104edx.256.1661524856857; Fri, 26
 Aug 2022 07:40:56 -0700 (PDT)
MIME-Version: 1.0
From:   Chris Chilvers <chilversc@gmail.com>
Date:   Fri, 26 Aug 2022 15:40:44 +0100
Message-ID: <CAAmbk-fJ6Ks=xEyiiCPxr+La852ugBE9Tg32Weo9Og2BSRRm1g@mail.gmail.com>
Subject: NFS re-export, READDIR, and large cookies
To:     linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

I've been investigating an issue where an NFSv3 client would receive
NFS3ERR_INVAL in response to a READDIR or READDIRPLUS request when using
a cookie.

The set up is using an intermediate NFS re-export server;
* Source NFS Server: VAST Data
* Proxy NFS Server : Ubuntu 20.04 LTS, Kernel 5.13.18

Several clients were used for testing, including an older 3.10 kernel.
There was no difference between them when mounting the re-export proxy
NFS server. There are differences in behaviour when mounting the source
server directly based upon whether the client's kernel implements
nfs_readdir_use_cookie.

For the test a directory was created on the source NFS server containing
200 files.

While the investigation initially looked at the READDIR issue with a
re-export server it was discovered that the underlying issue can also
cause odd behaviour when the clients mount the source NFS server
directly without the re-export proxy in the middle. The issue can affect
user applications that use telldir, seekdir, lseek, or similar
functions.

When the client running 3.10 accessed the NFS share via the proxy NFS
server the following exchange was observed when the ls command was
executed:

1) Client -> Proxy    : READDIRPLUS (cookie: 0)
2)   Proxy  -> Source : READDIRPLUS (cookie: 0)
3)   Source -> Proxy  : Reply, first 100 files, EOF 0
4)   Proxy  -> Source : READDIRPLUS (cookie: 2551291679986417766)
5)   Source -> Proxy  : Reply, next 200 files, EOF 1
6) Proxy  -> Client   : Reply, all 200 files, EOF 1
7) Client -> Proxy    : READDIRPLUS (cookie: 11500424819426459749)
8) Proxy  -> Client   : NFS3ERR_INVAL

I'm not certain why the client issued a second READDIRPLUS with a cookie
since the first request contains the full directory listing as indicated
by the EOF field.

The cookie in the second request is a valid cookie that was issued by
the source NFS server. The cookie is for a file about half way through
the directory listing. While the cookie is valid for the NFS 3 protocol,
it should be noted that the cookie's value is greater than 2^63-1. When
interpreted as a signed 64 bit integer the cookie would have the value
of -6946319254283091867.

Sample of directory entries captured by tcpdump (only includes the name
and cookie fields for brevity):

    Entry: name .      Cookie: 1
    Entry: name ..     Cookie: 2
    Entry: name 1      Cookie: 848716379849752578
    Entry: name 10     Cookie: 15827834395709931523
    Entry: name 100    Cookie: 16032066584625283076
    Entry: name 101    Cookie: 3137853460930625541
    Entry: name 102    Cookie: 7540226876707438598
    Entry: name 103    Cookie: 4424272775414284295
    Entry: name 104    Cookie: 15750249638323552264
    Entry: name 105    Cookie: 15370663860381941769
    ...

Tracing how the NFS cookie is handled by nfsd to the point the error is
generated I found the following:

* The cookie is converted to loff_t. This converts from unsigned to
  signed.

  nfsd/nfs3proc.c - nfsd3_proc_readdirplus
      loff_t offset;
      offset = argp->cookie;

* This offset is then passed to, nfsd_readdir where it is used with
  vfs_llseek:

  nfsd/vfs.c - nfsd_readdir
      offset = vfs_llseek(file, offset, SEEK_SET);

* Since the proxy server is re-exporting an NFS volume my assumption is
  that the underlying VFS driver is NFS and the file handle is a
  directory, thus vfs_llseek invokes nfs_llseek_dir.

  nfs/dir.c - nfs_llseek_dir
      switch (whence) {
      case SEEK_SET:
          if (offset < 0)
              return -EINVAL;

* Since offset is < 0, -EINVAL is returned resulting in NFS3ERR_INVAL.

Reading further into the nfs/dir.c source, it seems the cookie value is
used extensively as the dir's offset position, often being stored in
ctx->pos.

The issue here is the dir_context pos field is exposed to user
applications. As a test the proxy NFS was removed, and the clients
accessed the source NFS directly. In this configuration READDIRPLUS
worked as expected but issues with telldir and seekdir were observed.

When printing a directory listing using opendir/readdir negative d_off
values were displayed in the output (left file name, right d_off):

      . - 1
     .. - 2
      1 - 848716379849752578
     10 - -2618909677999620093
    100 - -2414677489084268540
    101 - 3137853460930625541
    102 - 7540226876707438598
    103 - 4424272775414284295
    104 - -2696494435385999352
    105 - -3076080213327609847
    ...

The directory listing was printed a second time, with an added call to
seekdir after opendir. If a non-negative d_off value was chosen the
directory listing would correctly start from that entry. If a negative
d_off value was chosen the directory listing would start from the first
entry.

As seekdir has no way to indicate an error, it's likely that the lseek
call failed. We did not include a test at the time to clear and check
errno but it's likely this would have indicated EINVAL.

A similar issue was noted with lseek returning negative positions for
directories on ext4: https://bugzilla.kernel.org/show_bug.cgi?id=200043
It was noted here that the correct behaviour is not well defined.
It seems it's not prohibited to return a negative value, but many
applications tend to interpret negative values as an error. Also lseek
is now documented to return -1 on an error, which is an issue here as -1
is a perfectly valid cookie value.

On the older 3.10 kernel, this was not an issue as the 3.10 kernel uses
the array index position for the offset value instead of the NFS cookie.

--
Chris
