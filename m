Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 507B149BF83
	for <lists+linux-nfs@lfdr.de>; Wed, 26 Jan 2022 00:26:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234706AbiAYX0O (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 25 Jan 2022 18:26:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234780AbiAYX0K (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 25 Jan 2022 18:26:10 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81A74C06173B
        for <linux-nfs@vger.kernel.org>; Tue, 25 Jan 2022 15:26:10 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id s5so34258794ejx.2
        for <linux-nfs@vger.kernel.org>; Tue, 25 Jan 2022 15:26:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dneg.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jmZvxjTm3Zm/yuEFMFhabb14g7w2JRRBo3QS+6a3Il4=;
        b=S6YBkt5XbYrW+u+CmAI27ZzRjDscQa7ektMYs8AbJrXSq2OvBUHdviC1VkEbm2sWqc
         RkYPH5Xyg1qr97nPnjgrCErM73lLR2l3crdLAjXbbXluIy9Yzca+3ngLq97/cy6/pLVs
         1l3breXdF59rq3XUUG9OE79gzAJGW4YVjVuGPYXjpGPt2i5XmLeSNYh6gUlFTAkkpgdr
         9r7SbrFsMXS35BeA6EeyJfB6cc01Ti7opTdCkdrmfdOGaiuZgnG++VEjlxHdGoVdQHOM
         2IT5zDFdaKUwxeSHZ4cZwP2Um5c/OMMn+X24qIxpWwlbBjVmWHBEXHg0ZLKJuBxLkKG8
         jjiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jmZvxjTm3Zm/yuEFMFhabb14g7w2JRRBo3QS+6a3Il4=;
        b=XTEGr6W08/cqHWBv/iPDuyuAPBBnZyNo+3ghofWPva4LuofRSw23iTMoaKE8KL+Jsv
         KPqImeyaebhzfVT7qvTwe/DpTcq14bCeU9GWLRCsn1cjomhfGcl0eep4t03hwPlavKOb
         BdVqBDzr/i1sjLjfpcARs1OufwEeQ0MSBaCF8DJYuPnWpj/dEujfFyfzH62gPpK4uCWt
         RGPiUHjeJLG3Hin8Jb1Vcm0H6hKv0mqNRh5sEHHDYugVqtYzpUcDTfi2Zk+GpGLiIxhw
         WH08KwwzUkdsCU906/+skoav+Z1FNr2u2nc02XYOJAlPOqOPYKUap8c+R7KTB6APUD0M
         k1Zw==
X-Gm-Message-State: AOAM532EpQ43YJVxZVk0ZZDKYO8QpcynEtUfPtxRaG8df8/2dPC2rdOd
        0bQiiag3XsOWHvS+pCUaijThpXmDmYJfETMUPhMG1g==
X-Google-Smtp-Source: ABdhPJy5sU7OHtcy0bYCjhvhUK/md3cVQo3BE9wqRlJiZ9PtpfNctnAs4nP/+1V5ghaI5pKj74NMuXBP6M+MjNQO7Vc=
X-Received: by 2002:a17:906:3819:: with SMTP id v25mr17574281ejc.539.1643153169137;
 Tue, 25 Jan 2022 15:26:09 -0800 (PST)
MIME-Version: 1.0
References: <CAPt2mGOaRsKOiL_wuSK_D5oYYnn0R-pvVsZc5HYGdEbT2FngtQ@mail.gmail.com>
 <20220124193759.GA4975@fieldses.org> <CAPt2mGOCn5OaeZm24+zh92qRcWTF8h-H2WXqScz9RMfo4r_-Qw@mail.gmail.com>
 <20220124205045.GB4975@fieldses.org> <CAPt2mGPTGgXztawDJfAKsiYqnm6P_mn1rtquSDKjpnSgvJH1YA@mail.gmail.com>
 <20220125135959.GA15537@fieldses.org> <F7C721F7-D906-426F-814F-4D3F34AD6FB1@oracle.com>
 <42867c2c-1ab3-9bb6-0e5a-57d13d667bc6@math.utexas.edu> <20220125215942.GC17638@fieldses.org>
 <7256e781-5ab8-2b39-cb69-58a73ae48786@math.utexas.edu> <CAPt2mGNMGjq+i=k_6oYBYPFPCTR2UdeEtWfyeTU9uUC0OC=T4w@mail.gmail.com>
 <a5627c80-4b03-29f2-1432-6e0f0b5197ef@math.utexas.edu>
In-Reply-To: <a5627c80-4b03-29f2-1432-6e0f0b5197ef@math.utexas.edu>
From:   Daire Byrne <daire@dneg.com>
Date:   Tue, 25 Jan 2022 23:25:33 +0000
Message-ID: <CAPt2mGMsd1q1B42bgdKciaWjB9O+9wezr_vU9JRpzzYEc6m+3g@mail.gmail.com>
Subject: Re: parallel file create rates (+high latency)
To:     Patrick Goetz <pgoetz@math.utexas.edu>
Cc:     Bruce Fields <bfields@fieldses.org>,
        Chuck Lever III <chuck.lever@oracle.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, 25 Jan 2022 at 23:01, Patrick Goetz <pgoetz@math.utexas.edu> wrote:
> On 1/25/22 16:41, Daire Byrne wrote:
> > On Tue, 25 Jan 2022 at 22:11, Patrick Goetz <pgoetz@math.utexas.edu> wrote:
> Thanks for this suggestion! This option didn't even occur to me.  The
> only downside is that this server gets really busy during image
> processing, so I'm a bit worried about loading it down with dozens of
> simultaneous rsync processes. Also, the biggest performance problem in
> this system (which includes multiple GPU-laden workstations and 2 other
> NFS servers) is always I/O bottlenecks.  I suppose the solution is to
> nice all the rsync processes to 19.

Yea, that's always the problem with backups - when do you slow down
production because backups are more important? :)

You could also have another NFS client close (latency) to the server
which would free CPU but it's hard to limit IO. You can still use
rsync+rsyncd for the higher latency hop.

> Question: given that I usually run backups from cron, and given that
> they can take a long time, how does msrsync avoid stepping on itself?

I guess you would need a lockfile or pgrep for a running instance.
TBH, I wrote a simpler version of msrsync in bash that was more suited
to our environment but the principle is the same.

Daire
