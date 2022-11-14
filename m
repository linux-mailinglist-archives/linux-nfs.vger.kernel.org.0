Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A931628157
	for <lists+linux-nfs@lfdr.de>; Mon, 14 Nov 2022 14:33:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235795AbiKNNdp (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 14 Nov 2022 08:33:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235560AbiKNNdo (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 14 Nov 2022 08:33:44 -0500
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B11ABF7E
        for <linux-nfs@vger.kernel.org>; Mon, 14 Nov 2022 05:33:43 -0800 (PST)
Received: by mail-yb1-xb33.google.com with SMTP id z192so13484484yba.0
        for <linux-nfs@vger.kernel.org>; Mon, 14 Nov 2022 05:33:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dneg.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WP+HYwHdjYCDFg9djfwnhXXz90w93wYmYtQG16AJnX0=;
        b=RpfCqtWkCA7IaqH/z2G/ouRF17SnCrua0KGlWk+d0+rCX2nGUPmHtonZriNnNZeYpD
         0XkPopSzkATiq/7aujjJdvXmFVUyTMMDPt/nQNLyEU+ewNsHhvzEdZFTkx7KzGHUd+GW
         fVmNILam/+7XLKdJuYjY65JIa2qb4c9s7HhUaydPN57o/STenGdNPNNGr/I2VMChaYlc
         0iRvRS4F5/XJvWSc+EYA1ffrs6xJJsNTFAy3JyMULN9MD+My91EZdimdvAFbNS6WjpH3
         dmIq3oegkDvznW5SB6RZzRoub531f02JEaCu3NQtQ4D4CvrLajCGMpidtFwzd4+hlrYf
         AVUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WP+HYwHdjYCDFg9djfwnhXXz90w93wYmYtQG16AJnX0=;
        b=yJfqEoaRBrKj/F+szepyxlWgRd+I+eVOI/aw2/s4GVf1UmsRTZYgvRfJqK6HLRFbpj
         YeaI4x1c7Nuln/mcTZaZUyqWorY1kFNV33566M4mu6pRk1NGgIpTRogWCjV4APs162FY
         ER1FtAbcB285/+h69FoKOMKvMAMJP4gEt/vrAKRKSQqyahHkZZyovF8iJDM+vZwnSp4N
         /4l5G+Fi/0M92NNdQFP3H/RPrFPyMcVp91JD+wnSAmGNG6Tp3/Jh1cHCldc61dWYuJDA
         IIaKfhOPahcFi+yQ9eH0LIp9cdGOCXRp6xTrcWB5ramk9wYRLzNm57+lLH4k/Ei7F63A
         A0Zg==
X-Gm-Message-State: ANoB5plmsxm9/4PCuQ1b6RXgQn9zinYH0nodXwl3W0UybzsrnSSEz6wp
        PZGoTHIJTLppkWof22ALOFOSKmCrVSfoN/xxEYOh5w==
X-Google-Smtp-Source: AA0mqf7LuOJHR5SVvxrPRzhIf+0soaX9o8B6BgwaD8f9F/qQu6GfdUGU1B8gbenuM9GnNTSEJibDNGrCylQaNlkQyuk=
X-Received: by 2002:a25:441:0:b0:6dd:58bd:727f with SMTP id
 62-20020a250441000000b006dd58bd727fmr11856790ybe.621.1668432822251; Mon, 14
 Nov 2022 05:33:42 -0800 (PST)
MIME-Version: 1.0
References: <20221017105212.77588-1-dwysocha@redhat.com> <20221017105212.77588-4-dwysocha@redhat.com>
 <870684b35a45b94c426554a62b63f80f421dbb08.camel@kernel.org>
 <CALF+zOm+-2QLOMu4J7NAK++xfjZ8SQqmMh8zNFcM2H78_qYAzA@mail.gmail.com>
 <0676ecb2bb708e6fc29dbbe6b44551d6a0d021dc.camel@kernel.org>
 <CALF+zOnRH_GiZooiNm1=J+gOpLMEncO72SA4jAmL+agG9RjbYg@mail.gmail.com>
 <CALF+zOmDzp-UhLC0Dk4fmsjEzWgM75m5uOMBjv6TjTFYtbWPAQ@mail.gmail.com>
 <1B2E1442-EB0A-43E3-96BB-15C717E966E5@hammerspace.com> <CA+QRt4vM3NncgCWjKncorHmiWpCrJ7FsLC=y+v7gnEwYpM3PSw@mail.gmail.com>
 <CALF+zOkxbLV4qzkaydBThmKfQKOP07jyq8o10YMfP2TgvAdZMQ@mail.gmail.com> <CA+QRt4v2qP5gAxiwYbyHEQHOCG4=fVDBwSBsXJrXb=GaFCKtYg@mail.gmail.com>
In-Reply-To: <CA+QRt4v2qP5gAxiwYbyHEQHOCG4=fVDBwSBsXJrXb=GaFCKtYg@mail.gmail.com>
From:   Daire Byrne <daire@dneg.com>
Date:   Mon, 14 Nov 2022 13:33:05 +0000
Message-ID: <CAPt2mGMH7_z10mNUytRd29tAjViqW019ffv8+_rn2PJQYRUgMg@mail.gmail.com>
Subject: Re: [PATCH v9 3/5] NFS: Convert buffered read paths to use netfs when
 fscache is enabled
To:     Benjamin Maynard <benmaynard@google.com>
Cc:     David Wysochanski <dwysocha@redhat.com>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Trond Myklebust <trondmy@kernel.org>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        David Howells <dhowells@redhat.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-cachefs@redhat.com" <linux-cachefs@redhat.com>,
        Daire Byrne <daire.byrne@gmail.com>,
        Brennan Doyle <brennandoyle@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, 14 Nov 2022 at 12:44, Benjamin Maynard <benmaynard@google.com> wrote:
>
> Thanks Dave for getting back to me so quickly.
>
> > Due to use of "drop_caches" this is almost certainly the known issue #1
> > I mentioned in the opening post of this series:
> > https://lore.kernel.org/all/20221103161637.1725471-1-dwysocha@redhat.com/
>
> Apologies, I completely missed the known issues in the original
> opening message of the series. Just to clarify, I was only ever
> dropping the caches on the "NFS Client" in the below relationship:
>
> Source NFS Server <-- Re-Export Server (with FS-Cache) <-- NFS Client.
>
> I never dropped the caches on the Re-Export Server (the server running
> FS-Cache) at any point.

So I have never actually done that particular test (I will need to
verify, but I think I would have noticed by now), but dropping caches
on the re-export server definitely caused repeat reads from "source"
NFS server and (re)writes to the fscache disk *without* David's
suggested patch. With the patch, you can drop caches on the re-export
server and get the repeat reads coming from the fscache disk as
expected.

You can certainly try that test too (just source NFS server ->
FS-cache client - read,drop cache,read).

I'm not sure about your particular test, but your re-export server
must have dropped the file from memory otherwise you would see the
repeat read just coming from page cache (with no fscache or disk cache
interaction required)? So I'll assume the file in question is too
large to fit into memory and effectively the cache has been dropped.
So I think the suggested patch on the re-export server will fix that
issue.

I should also add that I had this series working well (+suggested
patch) and the performance to/from disk cache is an order of magnitude
better than mainline (40MB/s vs 5000MB/s with NVMe), but it did expose
a race condition in the fscache use/unuse cookie code (David is
aware). In the NFS re-export case, we have lots of knfsd threads
thrashing around the netfs/fscache functions.

Daire
