Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CBAF0140CA2
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Jan 2020 15:36:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726974AbgAQOgd (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 17 Jan 2020 09:36:33 -0500
Received: from mail-ed1-f41.google.com ([209.85.208.41]:38010 "EHLO
        mail-ed1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726942AbgAQOgd (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 17 Jan 2020 09:36:33 -0500
Received: by mail-ed1-f41.google.com with SMTP id i16so22446722edr.5;
        Fri, 17 Jan 2020 06:36:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=H4aYYP5AqFJ3Bp+q4OGVka8zI0UJFy5rbCnPHZ0rHek=;
        b=SOk7gZypapa5fJcaGJwMWB9MkSwEn3xhy3XG8XagUdWDSXt9WLNyIQEkCPGh53rwy6
         i47bOsVvLssc660dIBAEbAvXvYKtBJYvFQ1m2wvxm79TY2WYCwoHsXvpNJCosUa8TEgR
         C3Z0F+UG+ymEmwiP1xIBIv+6Hapyj4EmVsamLO7RQqU01buSuLqrt8HuZcd8zIM0qEiQ
         HjyGXBEWGQUxvdMdv+5tiI9YUmMppZpUYWmrL4kTvNGdabiC5jIhA9Qqu1t05q4SjE2E
         p59NHnnqFH2VRXSl4cudW2IX1bADS4V1hmQz6FTyIWBQWt4zspkNYtL00cVclW61FW3b
         UtAw==
X-Gm-Message-State: APjAAAWv3266GEXzwak7k8ONA4ijNQWUnFqGoDrHRFYFgp3RKoX4tduk
        tlNksFztNxcFJKxt479fQ8o=
X-Google-Smtp-Source: APXvYqylfmjgftirP/3R0/bK+q/MT/hT7xjBH4da12u3eRqY+0MPaSabIAFYhwsLRMUWoEM45fNrJg==
X-Received: by 2002:aa7:c591:: with SMTP id g17mr4142644edq.341.1579271791174;
        Fri, 17 Jan 2020 06:36:31 -0800 (PST)
Received: from pi3 ([194.230.155.229])
        by smtp.googlemail.com with ESMTPSA id p24sm978321eds.17.2020.01.17.06.36.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2020 06:36:30 -0800 (PST)
Date:   Fri, 17 Jan 2020 15:36:28 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     David Howells <dhowells@redhat.com>
Cc:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        linux-nfs@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Scott Mayhew <smayhew@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [BISECT BUG] NFS v4 root not working after 6d972518b821 ("NFS:
 Add fs_context support.")
Message-ID: <20200117143628.GA3215@pi3>
References: <20200117131649.GA12406@pi3>
 <CAJKOXPeCVwZfBsCVbc9RQUGi0UfWQw0uFamPiQasiO8fSthFsQ@mail.gmail.com>
 <365390.1579265674@warthog.procyon.org.uk>
 <432921.1579270135@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <432921.1579270135@warthog.procyon.org.uk>
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Jan 17, 2020 at 02:08:55PM +0000, David Howells wrote:
> Can you do:
> 
> 	grep NFS .config
> 
> for your kernel config?

It is a regular exynos_defconfig from the same tree (so linux-next).

Best regards,
Krzysztof

