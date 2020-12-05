Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2D792CFAD7
	for <lists+linux-nfs@lfdr.de>; Sat,  5 Dec 2020 10:31:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726069AbgLEJab (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 5 Dec 2020 04:30:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728720AbgLEJ3x (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 5 Dec 2020 04:29:53 -0500
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8354C061A51
        for <linux-nfs@vger.kernel.org>; Sat,  5 Dec 2020 01:29:09 -0800 (PST)
Received: by mail-ej1-x644.google.com with SMTP id lt17so12288231ejb.3
        for <linux-nfs@vger.kernel.org>; Sat, 05 Dec 2020 01:29:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelim-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=S9dms5H6CmpTsJQcqOSIMSdYInJgx/22KnlLyVZuI2E=;
        b=q2pNz3NXgk640V/NDltyDIcopqhbf01tqUs9TlP7YJmG2pzoI9tjzsB+2uX6M6cHej
         7tsFFbmRMUkAs9vbHX9H6WPels1ACMck4aO0wwRBiQdfsqbqkhpb8zdfjmaMO81xX0WY
         lQBElBrUf8Bg2yMEvx+zYRDMDA5gxeXqIgiJlJ8FiGaLueHzS+6mg0dGLPv1B0xVmHl5
         T2Txm81VpkFgUhwDeBpMu9Wg9wvkVMtutgGG3kPqMoeZIki1ENc4OavuwfMfmKrysKI3
         dpQkRkHj9zcD6B4XZzqJJU/s/q9epHEQ6BWs89YG0okrHv0Ha2IWJCY1bCvxA+DRdBHk
         xj1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=S9dms5H6CmpTsJQcqOSIMSdYInJgx/22KnlLyVZuI2E=;
        b=pEeyKXjspLaUmtE8lQE60gF9mqdmRm1GL6+JGVL2C8LckMrGbdixpl+4sx+Vl9LeJx
         M6frluZ93+wjkxYA6uRp3Mz2JZfB8+IyMGi1GK11xNKweoLsvsuqjYByGyjhe1fbjMbC
         B6Cw6Bv7EGOcccvRohrwyRfNj3n9HhBSQ+eNW9UKFN4WVU0mwoHogYV7K7IXyid5q+r9
         1zyLO5yEENldEfqFEBlRt2vW6UPc1tOWOfRMszc80jkVQuN1/NiQrdYVweaqWxd2DeUF
         MEVw/tmsnF8BVTqb4JEhKed1hXGUry5pU6Dc7EQiAea0lddU2Flnlg1PgywAwNyQgo1B
         lFcg==
X-Gm-Message-State: AOAM533vJ7hWXtwrB0wRvucKXk8h+GNdFfjqNmUmVyoHhrHCb9b3FtV0
        O2ImEiQA01wTWURER0U4uDxUmO+FnUm1BaTL
X-Google-Smtp-Source: ABdhPJwhIDxqWHIlsLrhHlpHgMIlb8TNinR+hYa7qVCDWlHYU6Yvku+EFUMRnDjs93neitLLeNfrFw==
X-Received: by 2002:a17:907:41e3:: with SMTP id nb3mr11070470ejb.378.1607160548691;
        Sat, 05 Dec 2020 01:29:08 -0800 (PST)
Received: from gmail.com ([77.125.107.115])
        by smtp.gmail.com with ESMTPSA id u17sm4834076eje.11.2020.12.05.01.29.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Dec 2020 01:29:08 -0800 (PST)
Date:   Sat, 5 Dec 2020 11:29:05 +0200
From:   Dan Aloni <dan@kernelim.com>
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] sunrpc: fix xs_read_xdr_buf for partial pages receive
Message-ID: <20201205092905.GA1943555@gmail.com>
References: <20201204183419.1532347-1-dan@kernelim.com>
 <528fd4a869f0757e0a60e9c733d4625067693588.camel@hammerspace.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <528fd4a869f0757e0a60e9c733d4625067693588.camel@hammerspace.com>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Dec 04, 2020 at 08:52:55PM +0000, Trond Myklebust wrote:
> On Fri, 2020-12-04 at 20:34 +0200, Dan Aloni wrote:
[..]
> > --- a/net/sunrpc/xprtsock.c
> > +++ b/net/sunrpc/xprtsock.c
> > @@ -436,7 +436,7 @@ xs_read_xdr_buf(struct socket *sock, struct
> > msghdr *msg, int flags,
> >                 offset += ret - buf->page_base;
> >                 if (offset == count || msg->msg_flags &
> > (MSG_EOR|MSG_TRUNC))
> >                         goto out;
> > -               if (ret != want)
> > +               if (ret - buf->page_base != want)
> >                         goto out;
> >                 seek = 0;
> >         } else {
> 
> Ouch... Well spotted!
> 
> Hmm... I think we want to just subtract out the buf->page_base from the
> value of 'ret' after we call xs_flush_bvec() and then adjust the
> calculation of 'offset' in the next line. That's more efficient.

Yes, it works out, though after being aware that the positive value of
`ret` when returned from `xs_read_xdr_buf` and propagated upward has no
effect except on traces.

-- 
Dan Aloni
