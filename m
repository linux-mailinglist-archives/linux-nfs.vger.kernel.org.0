Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 616D96766A6
	for <lists+linux-nfs@lfdr.de>; Sat, 21 Jan 2023 15:09:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229493AbjAUOJc (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 21 Jan 2023 09:09:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjAUOJb (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 21 Jan 2023 09:09:31 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5690837F03
        for <linux-nfs@vger.kernel.org>; Sat, 21 Jan 2023 06:09:29 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id v30so9782396edb.9
        for <linux-nfs@vger.kernel.org>; Sat, 21 Jan 2023 06:09:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N0EKxn460Zy+TwaNm8ZPBjie5Uw/jdXAOry4i9qo28M=;
        b=pC+fSxxAICcunbO3sTrBp190T8RFyUAOekkdfGtog7Zh3dBSjeD9A1Su085IHVadkR
         UANWKbqHcvplbkWgAz6LPpL3fO7FKpWlJ09SHWvG9Q3lIzprWSpRorrW/m1ENio7gZ5U
         Ur6PgByP6jZE6MoQOAVf3pzC3Re7h5vkZshH/O6iUjpa4eXTwxpIyugh8hpH+b+u7Edg
         AzwaD/oje5s2gEkxb0/82qXDwUjyDar/9NnuwAgqR9JoC/F9ti0FZ4pAucJtvbPLk0HA
         idPHBytBA1Cr5NPD5Lum1Hzc2UNdqKIsphu0kcsWSZUU3H538LmqoNVu8W+045NYbca0
         VgCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N0EKxn460Zy+TwaNm8ZPBjie5Uw/jdXAOry4i9qo28M=;
        b=zFZ3UhRbhjd7Lmk5FCP622ewnm+EgxQjQSuxPVcaU+cQw+RBjDboUwaPghLABhltI5
         sR7VKh2V+kO2eAa98h/kwRtrxznw1flPypdNqt1JvkctxKrngrb0+i6zEdjujaKSX0RO
         YSKOh7Fy/HjFXI2eeJFXY+LHBZHCjVtx9e//fPcw93RPGF/tmzafaIl/H3KSyWftD7L5
         aiWczdR3uwWt8k6a42hLNYol6XeNnmesJ4rZgj3HzZte2gP/0gznERSRmd4T3tqlvCvb
         NqV0bktBvJReHWk/D3z9U1YlgSWbiRSidgY7LRtZIgDySiYq1VNgXOmDA+qmrnTJieSo
         h4RA==
X-Gm-Message-State: AFqh2kp/enKAm/wbw+n3IFFPOSfwMejPe+7cKvn74UcQ0ZQ0axn3CaMY
        7Gq6BCguI6KThccRpyMh/2c=
X-Google-Smtp-Source: AMrXdXudKTN/1NywY4DsAo938x5Wrsew/BgYboL+bd+KEvzvAFTsJCc/sJKysnmwxHQYJ3tF0ek+Gw==
X-Received: by 2002:a50:cddb:0:b0:49e:f591:d8c1 with SMTP id h27-20020a50cddb000000b0049ef591d8c1mr4416564edj.28.1674310167789;
        Sat, 21 Jan 2023 06:09:27 -0800 (PST)
Received: from eldamar.lan (c-82-192-242-114.customer.ggaweb.ch. [82.192.242.114])
        by smtp.gmail.com with ESMTPSA id el14-20020a056402360e00b00458b41d9460sm18096834edb.92.2023.01.21.06.09.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Jan 2023 06:09:27 -0800 (PST)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Received: by eldamar.lan (Postfix, from userid 1000)
        id 4C155BE2EE8; Sat, 21 Jan 2023 15:09:26 +0100 (CET)
Date:   Sat, 21 Jan 2023 15:09:26 +0100
From:   Salvatore Bonaccorso <carnil@debian.org>
To:     Chuck Lever III <chuck.lever@oracle.com>, nfbrown@suse.com
Cc:     yangerkun <yangerkun@huawei.com>, Jeff Layton <jlayton@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "yi.zhang@huawei.com" <yi.zhang@huawei.com>
Subject: Re: Question about CVE-2022-43945
Message-ID: <Y8vyFuQ0UdiiEJRw@eldamar.lan>
References: <48b858aa-028b-1f56-3740-e59eb7a5fca2@huawei.com>
 <265166ff-cd0b-ea5f-ad28-fed756dfd4ff@huawei.com>
 <B00F6DD5-8215-457B-A681-39D7A64B7668@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <B00F6DD5-8215-457B-A681-39D7A64B7668@oracle.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Chuck, 

On Sat, Nov 12, 2022 at 04:11:47PM +0000, Chuck Lever III wrote:
> 
> 
> > On Nov 12, 2022, at 4:04 AM, yangerkun <yangerkun@huawei.com> wrote:
> > 
> > On 2022/11/12 13:01, yangerkun wrote:
> >> Hi, Chuck Lever,
> >> CVE-2022-43945(https://nvd.nist.gov/vuln/detail/CVE-2022-43945) describe that a normal request header ended with garbage data can trigger the nfsd overflow since nfsd share the request and response with the same pages array.
> >> It seems that the patchset(https://lore.kernel.org/linux-nfs/166204973526.1435.6068003336048840051.stgit@manet.1015granger.net/T/#t) has solved NFSv2/NFSv3, but leave NFSv4 still vulnerably?
> 
> I asked the folks who reported this issue to check NFSv4 as well.
> They were not able to exploit NFSv4 in the same way. For now we
> believe this vulnerability does not impact the NFSv4 code paths.
> 
> 
> >> Another question, for stable branch like lts-5.10, since NFSv2/NFSv3 did not switch to xdr_stream, the nfs_request_too_big in nfsd_dispatch will reject the request like READ/READDIR with too large request. So it seems branch without that "switch" seems ok for NFSv2/NFSv3, but NFSv3 still vulnerably. right?
> >> Looking forward to your reply!
> > 
> > Sorry, notice that 76ce4dcec0dc ("NFSD: Cap rsize_bop result based on send buffer size") fix same problem for NFSv4.
> 
> 76ce4dcec0dc is a defensive fix. But, as I stated above, we haven't
> yet found that NFSD's NFSv4 implementation is vulnerable to this
> issue.
> 
> 
> > So, for the stable branch like lts-5.10 which NFSv2/NFSv3 do not switch to xdr_stream, it seems we only need 76ce4dcec0dc"NFSD: Cap rsize_bop result based on send buffer size"). Right?
> 
> At this time we don't believe 76ce4dcec0dc is required. But if
> you want it applied to v5.10 (or any LTS kernel) please first
> test that it does not result in a regression, and then make a
> request to the usual stable maintainers.

I was reviewing open CVEs for Debian, based on the 5.10.y stable
series, and noticed CVE-2022-43945 is yet unfixed in 5.10.162. I see
SUSE did some backporting, with Neil Brown, according to
https://bugzilla.suse.com/show_bug.cgi?id=1205128#c4 . From the set of
fixes the first two of 

Commit 90bfc37b5ab9 ("SUNRPC: Fix svcxdr_init_decode's end-of-buffer calculation")
Commit 1242a87da0d8 ("SUNRPC: Fix svcxdr_init_encode's buflen calculation")
Commit 00b4492686e0 ("NFSD: Protect against send buffer overflow in NFSv2 READDIR")
Commit 640f87c190e0 ("NFSD: Protect against send buffer overflow in NFSv3 READDIR")
Commit 401bc1f90874 ("NFSD: Protect against send buffer overflow in NFSv2 READ")
Commit fa6be9cc6e80 ("NFSD: Protect against send buffer overflow in NFSv3 READ")
Commit 76ce4dcec0dc ("NFSD: Cap rsize_bop result based on send buffer size")

would not be needed, but still the others, though won't apply cleanly
as thei need substantial changes. Neil, would it be possible to have
the fixes backported to the 5.10.y series as well?

Regards,
Salvatore
