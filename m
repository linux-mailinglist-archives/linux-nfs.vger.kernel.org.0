Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FD8C2863E6
	for <lists+linux-nfs@lfdr.de>; Wed,  7 Oct 2020 18:28:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726138AbgJGQ2N (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 7 Oct 2020 12:28:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726105AbgJGQ2M (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 7 Oct 2020 12:28:12 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B592BC061755
        for <linux-nfs@vger.kernel.org>; Wed,  7 Oct 2020 09:28:12 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id j22so2380167qtj.8
        for <linux-nfs@vger.kernel.org>; Wed, 07 Oct 2020 09:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r6+uO8I2VW2mJGYPdvvwjqBKkpdtpb+OLtWSFFZnN1E=;
        b=L702T7Ea3ozZq59JPUKLNjoZU79TmQSIiFHEzTZy2zFB16HMwPkQ3nEzx6CC9cdI4r
         /Z4hmZ6J6sLyU6MuGVH1P2sF9p0kJyJT4e9a4on3z+e0j9lcG6pK2tGaUFP+R1g9cVUB
         Tq1QUAfcfH18+FRyOzq5qnIFlhLSqfhIO7RqE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r6+uO8I2VW2mJGYPdvvwjqBKkpdtpb+OLtWSFFZnN1E=;
        b=MOEcMz6v25/zs+MyfUlJ+uAB8E6RbdzVH6SNOHkt0ZHuYQ+UcRx40Vo2XFlu3RiG0D
         nWHN0bLVPtjpkZhZ4fx4qJr8+o94jDLljofA7nIB7YsmJ6BKvJjkAdJsLjV8Aa2IbhA1
         Uw4xxKoxZG8ZtKQrxyOm4J0FA9l4zhLNRSKvu+maMBzQ3WxVrZrzYzKyaOZLretL2VhQ
         +/ijE1NgvAd1CDY3RaxnDmKyAst2YpFCWHqJjuW0+BOs3W3hNppicTv+dZQdI5BheN55
         Uu5fILgCUSDdGXX5j0c07yYA+L8+SW0XH1U1ePKQrh1/rGWwDtaJhZv6JxTPi5o47K8e
         cjaw==
X-Gm-Message-State: AOAM533M7zVvMoPpS0kqdwU9VagaGifT4oOvUH/2yfyiTt1uVyRNuFbQ
        4mcqfh0T0bvC86hJjOd9lSn7+M7wY3oiwacz57a0ig==
X-Google-Smtp-Source: ABdhPJyTWYzpFkOU6dfkHq9ZMfycgJ7qopzsyf+l5TT8Qpe4FIBTlUwp5byjkLTCNKpKHSxFgImJwDrhYB8IUIznAek=
X-Received: by 2002:ac8:100c:: with SMTP id z12mr3924480qti.81.1602088091738;
 Wed, 07 Oct 2020 09:28:11 -0700 (PDT)
MIME-Version: 1.0
References: <20201006151335.GB28306@fieldses.org> <df7b7b26-c6a7-9e6f-edf6-e3c858623462@math.utexas.edu>
In-Reply-To: <df7b7b26-c6a7-9e6f-edf6-e3c858623462@math.utexas.edu>
From:   Igor Ostrovsky <igor@purestorage.com>
Date:   Wed, 7 Oct 2020 09:28:00 -0700
Message-ID: <CAGrwUG4TSTBWXZRRbYLvTyavDkMpryXdx8AREm-13dkueG99NQ@mail.gmail.com>
Subject: Re: unsharing tcp connections from different NFS mounts
To:     Patrick Goetz <pgoetz@math.utexas.edu>
Cc:     "J. Bruce Fields" <bfields@fieldses.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Oct 7, 2020 at 6:57 AM Patrick Goetz <pgoetz@math.utexas.edu> wrote:

> I don't see how sharing a TCP connection can result in a performance
> regression (the performance degradation of *not* sharing a TCP
> connection is why HTTP 1.x is being replaced), or how using different IP
> addresses on the same interface resolves anything.  Does anyone have an
> explanation?
>

The two IPs give you a form of QoS. So, it's about performance isolation
across the mounts, not about improving the aggregate performance.

The example I mentioned was this one:

    dd if=/dev/zero of=/mnt/mount1/zeros &
    ls /mnt/mount2/

The writes to /mnt/mount1 keep the transport busy transmitting data. As
a result, the "ls" GETATTR (or whatever RPC) needs to wait on the
single transport, potentially for seconds. Putting the two mounts on
different IPs solves the problem, at least prior to trunking discovery.
