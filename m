Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B3D55F763C
	for <lists+linux-nfs@lfdr.de>; Fri,  7 Oct 2022 11:27:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229773AbiJGJ1n (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 7 Oct 2022 05:27:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbiJGJ11 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 7 Oct 2022 05:27:27 -0400
Received: from mail-vk1-xa36.google.com (mail-vk1-xa36.google.com [IPv6:2607:f8b0:4864:20::a36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 386E7120BEA;
        Fri,  7 Oct 2022 02:27:23 -0700 (PDT)
Received: by mail-vk1-xa36.google.com with SMTP id e5so1977169vkg.6;
        Fri, 07 Oct 2022 02:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EBvzhpA1ilBmSuclZNbt7jPWQVvqovwgFUoNfbc62WE=;
        b=CcT7uFsYbZXoKkJXSE5fuJ4vzMiUduzUSOOXuPNBi5GgkjCt50hukC36ZcQBZDlRnJ
         npmFFFR+q4ljsNjsZIAhA9n1a8wUTPfPXjxdJ81FaQK5EmFVypqXAYH7Pn1SWU4e/w5V
         v3oHO+AocG/3Au4/pa+3ZJpCRvBiHEhW8PcTKwyV3t77fl2ntXUY6Tc8stVMHXy9ut6k
         0mS+43cYyEbrVIDSCPedvWVnEz7kPgR3S/X1XB3TdqTL6y700WtCG0JXx4i1maKaR5CV
         C+YkDz+YKX1gyMxzQLO5AOt0Yhi8u+U0blrKQ1nOYInxVWJUouxhKaCDFtnh5mZH5bZb
         4cYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EBvzhpA1ilBmSuclZNbt7jPWQVvqovwgFUoNfbc62WE=;
        b=ZA2QOIYrNP5RFcUsEw1/pBtY2x4yXjxn+bYO8aATors9O5LbmbLQYkZHJ2HN/3jCno
         xQdcY8DDNvDTpPJkNbxoI6MO7Dd5s8/5P2ASM5W1+9K0bkr/kV/4Rd3dEswdYHxUS9fI
         lGSnO/OE/sVhHAizaz982DIp+fDrzu9PRQyABp1xwe+rwNXrz8KFfFKe1SPHcPZvPDvT
         +Fvn81fKmg0PCtX37K6I9b1iiNarzodXi8OdDdvTPP0Vo4dgysmJ/LjvDmY9Ym2UocIV
         zrtRTdNvqWihU9fcu44eQq2AcZa/qrlYqaLhbsdvk08mn7mbjr9ekvf9vwEzDBoLVuyL
         4EUA==
X-Gm-Message-State: ACrzQf3vFtgpcY2fUF9OvaGjvuGTMixDc7onrTK7xozilsuniGljr9VZ
        YoYckvBgC89UmIFr94hHOFR9om/t1lLFYC0jU5CbVEjk
X-Google-Smtp-Source: AMsMyM6ieDg7cDTYsWkX+0GWd0kWRE9/AcBS0rAj0X/Qk7lOCdEzmR7P76ksqlcCb+1NF99/eqDMyMvqAQQd4bezydA=
X-Received: by 2002:a1f:9cc5:0:b0:3a2:bd20:8fc6 with SMTP id
 f188-20020a1f9cc5000000b003a2bd208fc6mr2142380vke.22.1665134841729; Fri, 07
 Oct 2022 02:27:21 -0700 (PDT)
MIME-Version: 1.0
References: <CAK6vGwma1mALwE1zDUqXhGP+YHjtXdPipykui3Tt0a6NL_KOqw@mail.gmail.com>
 <2DC5A71F-F7B7-401B-954E-6A0656BDC6A9@oracle.com>
In-Reply-To: <2DC5A71F-F7B7-401B-954E-6A0656BDC6A9@oracle.com>
From:   jaganmohan kanakala <jaganmohan.kanakala@gmail.com>
Date:   Fri, 7 Oct 2022 14:57:10 +0530
Message-ID: <CAK6vGwkWCAnKd_rCQm1_vX67o29nXUOYmbSZ8E=VNe--wKgcOQ@mail.gmail.com>
Subject: Re: LINUX NFS support for SHA256 hash types
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Chuck,

Many thanks for your confirmation. It helped me a lot.

BR,
Jaganmohan K

On Thu, 29 Sept 2022 at 21:48, Chuck Lever III <chuck.lever@oracle.com> wrote:
>
>
>
> > On Sep 28, 2022, at 8:04 AM, jaganmohan kanakala <jaganmohan.kanakala@gmail.com> wrote:
> >
> > Hi Linux-NFS team,
> >
> > I'm trying to set up the Kerberos5 setup with MIT as the KDC on my
> > RHEL 8 machines.
> > I'm able to get the setup working with Kerberos encryption types where
> > the hash type is SHA1 (aes128-cts-hmac-sha1-96 and
> > aes256-cts-hmac-sha1-96).
> >
> > As SHA1 is kind of obsolete, my goal is to get my setup working for
> > SHA256 hash types (aes128-cts-hmac-sha256-128,
> > aes256-cts-hmac-sha384-192).
> >
> > I tried that. The communication between the Linux client and MIT KDC
> > is aes128-cts-hmac-sha256-128, but the communication between the Linux
> > client and Linux NFS server is only aes256-cts-hmac-sha1-96.
> >
> > When I checked the Linux upstream code I see that there is no support
> > for SHA256 (and above) hash types.
> >
> > https://github.com/torvalds/linux/blob/5bfc75d92efd494db37f5c4c173d3639d4772966/net/sunrpc/auth_gss/gss_krb5_mech.c
> >
> > Have I looked at the right source code?
> > Does the latest Linux NFS server has support for kerberos encryption
> > types aes128-cts-hmac-sha256-128, aes256-cts-hmac-sha384-192 ?
> >
> > Can anyone confirm?
>
> As far as I know, the Linux in-kernel SunRPC RPCSEC GSS implementation
> does not support the new encryption types defined in RFC 8009. That
> means neither the in-kernel client or server support these types at
> this time.
>
> I'm not aware of plans to implement support for these. Cc'ing the
> crypto mailing list to see if others are considering it.
>
>
> --
> Chuck Lever
>
>
>
