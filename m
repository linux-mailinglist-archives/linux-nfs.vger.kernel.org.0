Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B4B570DB59
	for <lists+linux-nfs@lfdr.de>; Tue, 23 May 2023 13:18:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231410AbjEWLSY (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 23 May 2023 07:18:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbjEWLSX (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 23 May 2023 07:18:23 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60C82C4
        for <linux-nfs@vger.kernel.org>; Tue, 23 May 2023 04:18:22 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-96f50e26b8bso973903666b.2
        for <linux-nfs@vger.kernel.org>; Tue, 23 May 2023 04:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684840700; x=1687432700;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0zNJf1ZxIlrz72iFEKXCdEhtPieGC/o/YCVkxcPf5Cw=;
        b=qqA/K+I9B6NMGuLEnngDkghGJwZ4m++6WJoa0t5lTvqmEn+ua7ok+RIH2q19DhyhGA
         cG4ObwfD7/eO0Dwb0r9mHsQ8SLxkSsNx4naXAA1Ch3jClI9WMxzR42PkMMMD+0bjonC5
         JvL1rlaE0DGa7kODDQjxyENLWtOi4nd8WtU5IrrJiAs9a4cpaviv+/Eu/4fi+nFS4pTu
         Z28Y/+wdib8voI+cgFmZg77zGXVBvyjjEPEDfD2/4PT+mxBnKbqy2QNf64oNwgLkAsTw
         rsfyyBFOdZ3aqrKzuM47ataM6u2xXYct/4eaBhvOmSubxXW79JWysFTRKemYiNak+Jcw
         yp6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684840700; x=1687432700;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0zNJf1ZxIlrz72iFEKXCdEhtPieGC/o/YCVkxcPf5Cw=;
        b=Y+fyLv99jVXw0/29e4gXyBTDlqcnRGjjm58F2NDdSJQi3mW21JCL9fRuWfTV7e51gc
         Xohwq5qlUufSUV4rY+6xf5t5R+FUFV09HWGbbysMGYs/h63Zit28RrWiJ8bSUmuCtwzv
         Ofcx+N367KdOIRkn+ViwpJa5h+fR1SfOrC67gMgwjG2IsT5uQ5E8vHoPgZFe3ruqscFC
         zIX/ew8L9t1iD/1lF9sk65+JwVVj+al2MQFny1OPheI/huK+TPP4k0L7LvxsfZM+zgr+
         8wLkczFLtith+ECs21f3g9Krb8RlgV9ch/rjOBKW55Ws2PThjXBZyIuvF7ydLCQAVSjO
         /sbw==
X-Gm-Message-State: AC+VfDyM/0wixDjD8vmT2F2AfLXd50461LT8cLRapU3arHx4ri3Feu4S
        MZq9aZ7iXashCnTNv4zwHgaHQ1QoH77zIxOsM8BEtp2x/FQ=
X-Google-Smtp-Source: ACHHUZ59THj5Tswww4xenEpO4c8mhlINpyXFkxbCi+i4JA9RU6XtgIVQFed0jO+NQcfy2Oiz/sTbAEQgMp4XniOrwSI=
X-Received: by 2002:a17:906:5d04:b0:95e:d74b:d171 with SMTP id
 g4-20020a1709065d0400b0095ed74bd171mr13436332ejt.28.1684840699474; Tue, 23
 May 2023 04:18:19 -0700 (PDT)
MIME-Version: 1.0
References: <CAAmbk-f_U8CPcTQM866L572uUHdK4p5iWKnUQs4r8fkW=6RW9g@mail.gmail.com>
 <1744185.1684489212@warthog.procyon.org.uk>
In-Reply-To: <1744185.1684489212@warthog.procyon.org.uk>
From:   Chris Chilvers <chilversc@gmail.com>
Date:   Tue, 23 May 2023 12:18:08 +0100
Message-ID: <CAAmbk-ffz-6LqkEo+XavgiuefZK7BOHC7648ZhSs0BN88N=M4A@mail.gmail.com>
Subject: Re: [Linux-cachefs] [BUG] fscache writing but not reading
To:     David Howells <dhowells@redhat.com>
Cc:     linux-nfs@vger.kernel.org, linux-cachefs@redhat.com,
        brennandoyle@google.com, Benjamin Maynard <benmaynard@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, 19 May 2023 at 10:40, David Howells <dhowells@redhat.com> wrote:
>
> Chris Chilvers <chilversc@gmail.com> wrote:
>
> > While testing the fscache performance fixes [1] that were merged into 6.4-rc1
> > it appears that the caching no longer works. The client will write to the cache
> > but never reads.
>
> Can you try reading from afs?  You would need to enable CONFIG_AFS_FS in your
> kernel if it's not already set.
>
> Install kafs-client and do:
>
>         systemctl enable afs.mount
>         md5sum /afs/openafs.org/software/openafs/1.9.1/openafs-1.9.1-doc.tar.bz2
>         cat /proc/fs/fscache/stats

FS-Cache statistics
Cookies: n=13 v=7 vcol=0 voom=0
Acquire: n=13 ok=13 oom=0
LRU    : n=1 exp=0 rmv=0 drp=0 at=2833
Invals : n=0
Updates: n=0 rsz=0 rsn=0
Relinqs: n=0 rtr=0 drop=0
NoSpace: nwr=0 ncr=0 cull=0
IO     : rd=0 wr=18
RdHelp : RA=18 RP=0 WB=0 WBZ=0 rr=0 sr=0
RdHelp : ZR=1 sh=0 sk=0
RdHelp : DL=18 ds=18 df=0 di=0
RdHelp : RD=0 rs=0 rf=0
RdHelp : WR=18 ws=18 wf=0

This was on an instance that was only just created, so the cache was
initially unused (all the counters were 0).

>         umount /afs/openafs.org
>         md5sum /afs/openafs.org/software/openafs/1.9.1/openafs-1.9.1-doc.tar.bz2
>         cat /proc/fs/fscache/stats

FS-Cache statistics
Cookies: n=13 v=7 vcol=0 voom=0
Acquire: n=26 ok=26 oom=0
LRU    : n=1 exp=1 rmv=0 drp=0 at=467
Invals : n=0
Updates: n=0 rsz=0 rsn=0
Relinqs: n=13 rtr=0 drop=13
NoSpace: nwr=0 ncr=0 cull=0
IO     : rd=18 wr=18
RdHelp : RA=36 RP=0 WB=0 WBZ=0 rr=0 sr=0
RdHelp : ZR=1 sh=0 sk=0
RdHelp : DL=18 ds=18 df=0 di=0
RdHelp : RD=18 rs=18 rf=0
RdHelp : WR=18 ws=18 wf=0

Looks like the cache is working fine with AFS. The second md5sum
seemed a lot quicker than the first.
