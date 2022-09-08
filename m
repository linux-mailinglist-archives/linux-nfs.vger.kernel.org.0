Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94E9C5B191F
	for <lists+linux-nfs@lfdr.de>; Thu,  8 Sep 2022 11:45:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231318AbiIHJp3 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 8 Sep 2022 05:45:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231233AbiIHJpX (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 8 Sep 2022 05:45:23 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B781786C3
        for <linux-nfs@vger.kernel.org>; Thu,  8 Sep 2022 02:45:21 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id gb36so36697364ejc.10
        for <linux-nfs@vger.kernel.org>; Thu, 08 Sep 2022 02:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=6ifMuwl302N5V8CWhh2I19JjmWIq6rqdcWETMZVjImY=;
        b=kidGLRNsilg4PEbP+nq+BhJZmJdwwIyTvi3y5BDqU5uRNp4kEcBk+TuiJ0xF/qRwg8
         3cjz2Uo3VptAxt3p/MKaclMyZKTtiL1wInVr/F4o/JY15qtXYFyjGSZ/ObRrb2BbIzGU
         KZCoDkBH1IP52jVqvQ8Ob5w2PGs7BdI79UF3nYj3Q+teIcii4fqW0jKyiI8kT5O+AyPt
         1WSUVJ9U5AyduQjzp0e06nwF3rh6XjEAQ7nVfKOa5g5ftJd6rAzopX0vYesrA3+sABDw
         7/Uy1Z59SLUULTTEHXZEBHqBhH9vpFNVzFrk88yXux9FO1dzuX16l/A4Uj+OGdXlpYtQ
         V5ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=6ifMuwl302N5V8CWhh2I19JjmWIq6rqdcWETMZVjImY=;
        b=LTuisQN/61i3putNQp4Os+waPqEolfM+YgcP3IsishoPXij7tUNnDG0M2riu0Ou6wJ
         Iaa6gL9yX38jbT9WG7+6rGOu5L2qD1qS1h3iqen2+2RDrKDGM87aiFFfSwqToDRYblDK
         mCM4ZRrD5lC+1ypXhIJfbwzbIEmLWqQZRgfr9olWS8lSRJDKlJGZcA33jkycDSk00w8f
         CIQ6D0kV7er9MnvQzElhvcTQRx2pfcv7jv1VtfV6rtboE8s7PjnQVhJPZVoYqIywpubR
         aTuMMTza0QTu6ggkhcYy5BODSAxsyXG8L/nAFalcr6mOION3D+ZpJJlRjARoDMHpht83
         ZF9A==
X-Gm-Message-State: ACgBeo073CiRoY+Yfru7Uf8WD/J8k72za8pvfMMO8qHO/QjmvWV28mqM
        JRgSGsERhAwnPejY5Pq4OnVcXwYtt4Y9GjRjwNUKU5lLHCY=
X-Google-Smtp-Source: AA6agR5WdjqZYBNrXJ+4MwyHHvue2aM/RXMJ1gqYNwy4YOv22VQ6eU3hQQ4EhEiGwwvLS7URmAowS1csLzY1nmSHSxA=
X-Received: by 2002:a17:907:1b0e:b0:72f:9b43:b98c with SMTP id
 mp14-20020a1709071b0e00b0072f9b43b98cmr5404758ejc.710.1662630319247; Thu, 08
 Sep 2022 02:45:19 -0700 (PDT)
MIME-Version: 1.0
References: <CAAmbk-fJ6Ks=xEyiiCPxr+La852ugBE9Tg32Weo9Og2BSRRm1g@mail.gmail.com>
In-Reply-To: <CAAmbk-fJ6Ks=xEyiiCPxr+La852ugBE9Tg32Weo9Og2BSRRm1g@mail.gmail.com>
From:   Chris Chilvers <chilversc@gmail.com>
Date:   Thu, 8 Sep 2022 10:45:10 +0100
Message-ID: <CAAmbk-e-YQAPo6QyNB0aJyc9qzUShmEC+x5eTR7wqp1ABWADsg@mail.gmail.com>
Subject: [BUG] READDIR with 64 bit cookies
To:     linux-nfs@vger.kernel.org
Cc:     benmaynard@google.com, tscales@google.com, brennandoyle@google.com
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

I should have flagged this as a bug on the first email.

I've run into an interesting issue using VAST data, their NFS implementation
makes use of the full 64 bit unsigned range allowed by NFS cookie for READDIR
and READDIRPLUS.

The issue is that this 64 unsigned value is used for the directory's file
position (d_off), which is a 64 bit signed value. This can cause readdir and
telldir to return negative values.

If you then try and use one of these negative values with seekdir the NFS client
treats this as an error and results in EINVAL, for a valid cookie value that was
returned by the NFS client.

If you're using NFS re-export this is pretty much guaranteed to fail at some
point as the NFS server uses vfs_llseek with the cookie value.

I've included the original email below, as it goes into a bit more depth.

On Fri, 26 Aug 2022 at 15:40, Chris Chilvers <chilversc@gmail.com> wrote:
>
> I've been investigating an issue where an NFSv3 client would receive
> NFS3ERR_INVAL in response to a READDIR or READDIRPLUS request when using
> a cookie.
>
> The set up is using an intermediate NFS re-export server;
> * Source NFS Server: VAST Data
> * Proxy NFS Server : Ubuntu 20.04 LTS, Kernel 5.13.18
>
> Several clients were used for testing, including an older 3.10 kernel.
> There was no difference between them when mounting the re-export proxy
> NFS server. There are differences in behaviour when mounting the source
> server directly based upon whether the client's kernel implements
> nfs_readdir_use_cookie.
>
> For the test a directory was created on the source NFS server containing
> 200 files.
>
> While the investigation initially looked at the READDIR issue with a
> re-export server it was discovered that the underlying issue can also
> cause odd behaviour when the clients mount the source NFS server
> directly without the re-export proxy in the middle. The issue can affect
> user applications that use telldir, seekdir, lseek, or similar
> functions.
>
> When the client running 3.10 accessed the NFS share via the proxy NFS
> server the following exchange was observed when the ls command was
> executed:
>
> 1) Client -> Proxy    : READDIRPLUS (cookie: 0)
> 2)   Proxy  -> Source : READDIRPLUS (cookie: 0)
> 3)   Source -> Proxy  : Reply, first 100 files, EOF 0
> 4)   Proxy  -> Source : READDIRPLUS (cookie: 2551291679986417766)
> 5)   Source -> Proxy  : Reply, next 200 files, EOF 1
> 6) Proxy  -> Client   : Reply, all 200 files, EOF 1
> 7) Client -> Proxy    : READDIRPLUS (cookie: 11500424819426459749)
> 8) Proxy  -> Client   : NFS3ERR_INVAL
>
> I'm not certain why the client issued a second READDIRPLUS with a cookie
> since the first request contains the full directory listing as indicated
> by the EOF field.
>
> The cookie in the second request is a valid cookie that was issued by
> the source NFS server. The cookie is for a file about half way through
> the directory listing. While the cookie is valid for the NFS 3 protocol,
> it should be noted that the cookie's value is greater than 2^63-1. When
> interpreted as a signed 64 bit integer the cookie would have the value
> of -6946319254283091867.
>
> Sample of directory entries captured by tcpdump (only includes the name
> and cookie fields for brevity):
>
>     Entry: name .      Cookie: 1
>     Entry: name ..     Cookie: 2
>     Entry: name 1      Cookie: 848716379849752578
>     Entry: name 10     Cookie: 15827834395709931523
>     Entry: name 100    Cookie: 16032066584625283076
>     Entry: name 101    Cookie: 3137853460930625541
>     Entry: name 102    Cookie: 7540226876707438598
>     Entry: name 103    Cookie: 4424272775414284295
>     Entry: name 104    Cookie: 15750249638323552264
>     Entry: name 105    Cookie: 15370663860381941769
>     ...
>
> Tracing how the NFS cookie is handled by nfsd to the point the error is
> generated I found the following:
>
> * The cookie is converted to loff_t. This converts from unsigned to
>   signed.
>
>   nfsd/nfs3proc.c - nfsd3_proc_readdirplus
>       loff_t offset;
>       offset = argp->cookie;
>
> * This offset is then passed to, nfsd_readdir where it is used with
>   vfs_llseek:
>
>   nfsd/vfs.c - nfsd_readdir
>       offset = vfs_llseek(file, offset, SEEK_SET);
>
> * Since the proxy server is re-exporting an NFS volume my assumption is
>   that the underlying VFS driver is NFS and the file handle is a
>   directory, thus vfs_llseek invokes nfs_llseek_dir.
>
>   nfs/dir.c - nfs_llseek_dir
>       switch (whence) {
>       case SEEK_SET:
>           if (offset < 0)
>               return -EINVAL;
>
> * Since offset is < 0, -EINVAL is returned resulting in NFS3ERR_INVAL.
>
> Reading further into the nfs/dir.c source, it seems the cookie value is
> used extensively as the dir's offset position, often being stored in
> ctx->pos.
>
> The issue here is the dir_context pos field is exposed to user
> applications. As a test the proxy NFS was removed, and the clients
> accessed the source NFS directly. In this configuration READDIRPLUS
> worked as expected but issues with telldir and seekdir were observed.
>
> When printing a directory listing using opendir/readdir negative d_off
> values were displayed in the output (left file name, right d_off):
>
>       . - 1
>      .. - 2
>       1 - 848716379849752578
>      10 - -2618909677999620093
>     100 - -2414677489084268540
>     101 - 3137853460930625541
>     102 - 7540226876707438598
>     103 - 4424272775414284295
>     104 - -2696494435385999352
>     105 - -3076080213327609847
>     ...
>
> The directory listing was printed a second time, with an added call to
> seekdir after opendir. If a non-negative d_off value was chosen the
> directory listing would correctly start from that entry. If a negative
> d_off value was chosen the directory listing would start from the first
> entry.
>
> As seekdir has no way to indicate an error, it's likely that the lseek
> call failed. We did not include a test at the time to clear and check
> errno but it's likely this would have indicated EINVAL.
>
> A similar issue was noted with lseek returning negative positions for
> directories on ext4: https://bugzilla.kernel.org/show_bug.cgi?id=200043
> It was noted here that the correct behaviour is not well defined.
> It seems it's not prohibited to return a negative value, but many
> applications tend to interpret negative values as an error. Also lseek
> is now documented to return -1 on an error, which is an issue here as -1
> is a perfectly valid cookie value.
>
> On the older 3.10 kernel, this was not an issue as the 3.10 kernel uses
> the array index position for the offset value instead of the NFS cookie.
>
> --
> Chris
