Return-Path: <linux-nfs+bounces-17028-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 28FF2CB4F00
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Dec 2025 07:54:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5B0203010289
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Dec 2025 06:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F9FE296BCC;
	Thu, 11 Dec 2025 06:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QF3EYF7w"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD360270565
	for <linux-nfs@vger.kernel.org>; Thu, 11 Dec 2025 06:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765436049; cv=none; b=U9JiSfcU/LmgzR3RmgVqeh8TjALXhHh1DdQ161Tz3jvS1Ri4wDK+uey6zWQh67Xn0yPPxnyKFs3m2AifFxEwLz3TS/+vSBXswg2t1dMZvnbUToi50qR5tbYmpAcjSHUpZoYy2DAUL1FRmdYbEl5m6vSAP9GipQe/lfe5yq1fntg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765436049; c=relaxed/simple;
	bh=1E0PfvwR2BUNha0++ZZjdG3WwNz68KQIBnDpTrVcRA4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uH6jdsIaeRrrQq7COEG1bbAdAA6kgV+4zkiY+ua+71I4b7yfjQO+yolPyg/W+C7YeGOLsiqF6OBpl3uJKzFa3Zy5+bRd+cja+sjvDZ7yySbKmJApQoIMBx+5AIQ/9vkiAKAckf6l6v3Gi9DWUG5bTLLMD+a4nkMdWDzGBAYagXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QF3EYF7w; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7b8bbf16b71so730172b3a.2
        for <linux-nfs@vger.kernel.org>; Wed, 10 Dec 2025 22:54:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765436047; x=1766040847; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HutFGm1UQdxTZv7/rV+zQvQKaWoCt+QCbcVEeswy4Mo=;
        b=QF3EYF7w1zftcFMGetaGCZsBPxRqQKFSMtmKY4/J/LvT9tv6hr7JdytTVbOFMVDOeY
         FGDRAFc0FNgMHQIzB/dQXUkhO2sAhXoZWjL0NkBwBjnbnjPcfw6j9x2APrlSu0t5Ao2q
         k5ZoglbjtfINhGT+rWu33VAUBFGH19dpRcNXmLpUBULxtMO67E+pI8zcjsZSzofdTR1T
         HYpAPOfQSuwtRyT115+gqAJXimaLsIvg8ssILm69lWjn4VTsl0Xekl8nWB2f4Er2jHNp
         na9SBRMANgb3OZXcGoIR1iDGopK+KTDbKyMRnZitm9P0KhTUo/8JFAAWxWWUtBGZ7WIV
         nzzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765436047; x=1766040847;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HutFGm1UQdxTZv7/rV+zQvQKaWoCt+QCbcVEeswy4Mo=;
        b=Y0Hvwmpe2CU2Lh/C81NB0HgMBxYUySADEZbOfcNOnDwDWwlKAHhrh1orMckq1qIStz
         cbrJR+P66d115HSVGYhHo5xUP/G3Aha9zcEpL9FpzfWWgDX5wJRTSo6UNWtLeAW5ok0/
         E4N4hlpSPzpJANj0QsCRneJPc3GAPiBTc5iOuwvAncR5sUsBomOjNxu49maDNL39G3hZ
         TZrho1ftMGOpQqlXHKh4ikGDzooafjs9gZ9F16R6lUjiRmmSQLtEtG2GHrw4VXCB0O9K
         7m6wEaI34fiq958jyfXMb20rGWLupD65PYubnAo5n7AnOu9X/cbYAR/u3fSG4ofu9qjr
         Aerg==
X-Forwarded-Encrypted: i=1; AJvYcCVqfdk3lKMj3tmWTvgku0oUBkfGaUUQ9UvhY1xaRQ+HT8OM6oyhzp6wYcV8Q8KCcIflctDrFoyy460=@vger.kernel.org
X-Gm-Message-State: AOJu0YzD5Ne3HX9ysGxIm+TVY4qMgaOLwogBM85ronnWjhpzKXwiYvKi
	BojOC8CKiYvy9CsCgV2hSvWvFKub3ZCgJ5UwrYakH/sUO0yfQuX0bACh
X-Gm-Gg: AY/fxX4B9cJpaX4n8VYjy5mnTnsozOI1HUoXrS8+4ury/j5OTS1l8heULshk/SgvGnj
	wXl8cenNbYgjgs0pgMjqoON3KtDNdFgjzX/I857vkTgIpH6Bupkt1FL2guPWeVuJGlMfGLxKOHg
	m056+m9ICf2k22aWdQnhqaEL5vFbmnEOnbHJS93kRuWKdz4LaZ+wnbFNrpyL9OV3yNFivqCKw4n
	WP/gogOMtK3p/q4WYGNTWld/wv0AKLvaegBL0waaE43nXY61m7JUL9jdHk8RWP+wyvd6N9L8rHl
	3L6Gm6s+4NLsgR9UEMk1sNhS2wrF+gvh4qXXVU/evHpYio3hOEwwW5EzgfzeefvKoqGu9VnFaE0
	OO0Vx1he3i5Za72VduaRWuHUGjosE+XlB7+RNVR2FqFHk9bNAJ6jgBkxZb3UXeqnsA4+4mn3FXl
	rBrSALCLkjXzlQnVSu89g1
X-Google-Smtp-Source: AGHT+IFKvxqFo4NItaaHnLyVzM4sbWnAXUb3F5QTF46SO8F9VK/kzhIS1jNZR2f1PCXHKAl1kqoSdQ==
X-Received: by 2002:a05:6a00:3d0b:b0:7e8:450c:61d5 with SMTP id d2e1a72fcca58-7f230894d5fmr5514568b3a.69.1765436047101;
        Wed, 10 Dec 2025 22:54:07 -0800 (PST)
Received: from google.com ([2401:fa00:95:201:3049:4910:dff7:e912])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7f4c4aa91d0sm1437223b3a.32.2025.12.10.22.54.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Dec 2025 22:54:06 -0800 (PST)
Date: Thu, 11 Dec 2025 14:54:03 +0800
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: Pycode <pycode42@gmail.com>
Cc: Jeff Layton <jlayton@kernel.org>, Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Removed unused variable
Message-ID: <aTpqizefLFrDlxbS@google.com>
References: <aTnfSQJ4QsfwTSf0@raspberrypi>
 <ca38feb0347cc38fd2fe3753628f7644a91aaa7a.camel@kernel.org>
 <aTpdYqy0Q5gGfr3p@raspberrypi>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aTpdYqy0Q5gGfr3p@raspberrypi>

On Thu, Dec 11, 2025 at 06:57:54AM +0100, Pycode wrote:
> On Thu, Dec 11, 2025 at 08:10:25AM +0900, Jeff Layton wrote:
> > A more descriptive title is preferred: "Remove unused variable from
> > nfs4_ff_alloc_deviceid_node()"
> > 
> 
> Thanks for the advices!
> 
> > On Wed, 2025-12-10 at 21:59 +0100, Pycode wrote:
> > > Signed-off-by: Pycode <pycode42@gmail.com>
> > > 
> > > Removed the unused variable ret in
> > > fs/nfs/flexfilelayout/flexfilelayoutdev.c
> > > 
> > > (Disclaimer this is my first patch, be sorry if I have done anything
> > > wrong!)
> > > ---
> > >  fs/nfs/flexfilelayout/flexfilelayoutdev.c | 4 +---
> > >  1 file changed, 1 insertion(+), 3 deletions(-)
> > > 
> > > diff --git a/fs/nfs/flexfilelayout/flexfilelayoutdev.c b/fs/nfs/flexfilelayout/flexfilelayoutdev.c
> > > index c55ea8fa3bfa..9cd04e85d52f 100644
> > > --- a/fs/nfs/flexfilelayout/flexfilelayoutdev.c
> > > +++ b/fs/nfs/flexfilelayout/flexfilelayoutdev.c
> > > @@ -53,7 +53,7 @@ nfs4_ff_alloc_deviceid_node(struct nfs_server *server, struct pnfs_device *pdev,
> > >  	u32 mp_count;
> > >  	u32 version_count;
> > >  	__be32 *p;
> > > -	int i, ret = -ENOMEM;
> > > +	int i = -ENOMEM;
> > >  
> > 
> > No need to initialize this.
> > 
> > >  	/* set up xdr stream */
> > >  	scratch = folio_alloc(gfp_flags, 0);
> > > @@ -88,7 +88,6 @@ nfs4_ff_alloc_deviceid_node(struct nfs_server *server, struct pnfs_device *pdev,
> > >  	if (list_empty(&dsaddrs)) {
> > >  		dprintk("%s: no suitable DS addresses found\n",
> > >  			__func__);
> > > -		ret = -ENOMEDIUM;
> > >  		goto out_err_drain_dsaddrs;
> > >  	}
> > >  
> > > @@ -134,7 +133,6 @@ nfs4_ff_alloc_deviceid_node(struct nfs_server *server, struct pnfs_device *pdev,
> > >  			dprintk("%s: [%d] unsupported ds version %d-%d\n", __func__,
> > >  				i, ds_versions[i].version,
> > >  				ds_versions[i].minor_version);
> > > -			ret = -EPROTONOSUPPORT;
> > >  			goto out_err_drain_dsaddrs;
> > >  		}
> > >  
> > 
> > What about the dprintk() at the bottom of this function? Does this
> > actually build?
> 
> There is no dprintk() at the bottom that used the variable.

At the bottom of this function, there is a dprintk call that refers to ret:

	dprintk("%s ERROR: returning %d\n", __func__, ret);
	return NULL;

This causes the build to fail:

In file included from ./include/asm-generic/bug.h:31,
                 from ./arch/x86/include/asm/bug.h:193,
                 from ./arch/x86/include/asm/alternative.h:9,
                 from ./arch/x86/include/asm/barrier.h:5,
                 from ./include/asm-generic/bitops/generic-non-atomic.h:7,
                 from ./include/linux/bitops.h:28,
                 from ./include/linux/kernel.h:23,
                 from ./include/linux/uio.h:8,
                 from ./include/linux/socket.h:8,
                 from ./include/uapi/linux/in.h:25,
                 from ./include/linux/in.h:19,
                 from ./include/linux/nfs_fs.h:22,
                 from fs/nfs/flexfilelayout/flexfilelayoutdev.c:10:
fs/nfs/flexfilelayout/flexfilelayoutdev.c: In function ‘nfs4_ff_alloc_deviceid_node’:
fs/nfs/flexfilelayout/flexfilelayoutdev.c:182:55: error: ‘ret’ undeclared (first use in this function); did you mean ‘net’?
  182 |         dprintk("%s ERROR: returning %d\n", __func__, ret);
      |                                                       ^~~
./include/linux/printk.h:484:33: note: in definition of macro ‘printk_index_wrap’
  484 |                 _p_func(_fmt, ##__VA_ARGS__);                           \
      |                                 ^~~~~~~~~~~
./include/linux/sunrpc/debug.h:36:41: note: in expansion of macro ‘printk’
   36 | #  define __sunrpc_printk(fmt, ...)     printk(KERN_DEFAULT fmt, ##__VA_ARGS__)
      |                                         ^~~~~~
./include/linux/sunrpc/debug.h:42:17: note: in expansion of macro ‘__sunrpc_printk’
   42 |                 __sunrpc_printk(fmt, ##__VA_ARGS__);                    \
      |                 ^~~~~~~~~~~~~~~
./include/linux/sunrpc/debug.h:25:9: note: in expansion of macro ‘dfprintk’
   25 |         dfprintk(FACILITY, fmt, ##__VA_ARGS__)
      |         ^~~~~~~~
fs/nfs/flexfilelayout/flexfilelayoutdev.c:182:9: note: in expansion of macro ‘dprintk’
  182 |         dprintk("%s ERROR: returning %d\n", __func__, ret);
      |         ^~~~~~~
fs/nfs/flexfilelayout/flexfilelayoutdev.c:182:55: note: each undeclared identifier is reported only once for each function it appears in
  182 |         dprintk("%s ERROR: returning %d\n", __func__, ret);
      |                                                       ^~~
./include/linux/printk.h:484:33: note: in definition of macro ‘printk_index_wrap’
  484 |                 _p_func(_fmt, ##__VA_ARGS__);                           \
      |                                 ^~~~~~~~~~~
./include/linux/sunrpc/debug.h:36:41: note: in expansion of macro ‘printk’
   36 | #  define __sunrpc_printk(fmt, ...)     printk(KERN_DEFAULT fmt, ##__VA_ARGS__)
      |                                         ^~~~~~
./include/linux/sunrpc/debug.h:42:17: note: in expansion of macro ‘__sunrpc_printk’
   42 |                 __sunrpc_printk(fmt, ##__VA_ARGS__);                    \
      |                 ^~~~~~~~~~~~~~~
./include/linux/sunrpc/debug.h:25:9: note: in expansion of macro ‘dfprintk’
   25 |         dfprintk(FACILITY, fmt, ##__VA_ARGS__)
      |         ^~~~~~~~
fs/nfs/flexfilelayout/flexfilelayoutdev.c:182:9: note: in expansion of macro ‘dprintk’
  182 |         dprintk("%s ERROR: returning %d\n", __func__, ret);
      |         ^~~~~~~
make[5]: *** [scripts/Makefile.build:287: fs/nfs/flexfilelayout/flexfilelayoutdev.o] Error 1
make[4]: *** [scripts/Makefile.build:556: fs/nfs/flexfilelayout] Error 2
make[3]: *** [scripts/Makefile.build:556: fs/nfs] Error 2
make[2]: *** [scripts/Makefile.build:556: fs] Error 2

