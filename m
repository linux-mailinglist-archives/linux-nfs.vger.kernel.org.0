Return-Path: <linux-nfs+bounces-17029-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E11DCB4FC5
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Dec 2025 08:32:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 044AC3005E96
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Dec 2025 07:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 593BA1A9F90;
	Thu, 11 Dec 2025 07:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HOJA+YuA"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73A0A1F936
	for <linux-nfs@vger.kernel.org>; Thu, 11 Dec 2025 07:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765438322; cv=none; b=K0D2butOToBnkzKJT8NwZkazjJoIVoEkaX6bbQEeaTipFTbREwNd8myBKpvG2IZuvD8meeDzNXQZUrDQ0temWgtnauvI1fn122okV6t9AWxJIGsgGWvFLqMtv//gWsqA0+Uwngr7kGEKdwu69Q9nPdPGVaMI+OTJsTBzTlud8RQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765438322; c=relaxed/simple;
	bh=JxIa5O14mcNVljrVu0NGhnRlznn2ApspS0WDdrj3t5k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f1Di6mQulWc946fZ3Iip/NwyBJaPK+c2cqbGS1ESUI8g1Y6NUpxZITFJwMdEy5WrQNtsEptnFLUJuGWkxYuHbHTDyDn8wK6zgiF9CSWGD4PK6v2kPeh4/8Oj6UOxvX4mnq7NKWgYLRAlzYl/TgQnF1ai+1B1HSnxSQS3sHYHyqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HOJA+YuA; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-64981b544a1so822870a12.1
        for <linux-nfs@vger.kernel.org>; Wed, 10 Dec 2025 23:32:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765438319; x=1766043119; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rIvnbpQBBUbR0ix4DkGdM3jUGOF+DuO8l0ykAVt0oCI=;
        b=HOJA+YuAGT7vbAP4fMw76AFY2hzpRaE2Mf2158GFJD85R4a0AhY5KbhhroJagPvRn3
         NtInMoa0pQqlejDE9VFeoj0kNmqMlrlZP7lsosOw880GA6if2Gi8a/Z5lBzbUQ2mEr/E
         WsWCsNaathKyXwGDRteM3zjQuu2GKfvdTJ38Lu+D9bFJUpdnz/f0vfbrr9edaTSWo0lj
         sHO4aC7faFqd3PnuUnf69bzJ1NyVEGoHSLzPMw2qhXSvUob5+kT/mM3jGXGH14EWc0rv
         tqXGmlIG5TWU9YaKU5l3OgKvl6w+j4S/v3+Mu29MUyeOA3tKq61bELHPImeJaPvY9cWl
         wq+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765438319; x=1766043119;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rIvnbpQBBUbR0ix4DkGdM3jUGOF+DuO8l0ykAVt0oCI=;
        b=Z4xbJ4xEJ82hLO0V39EgQVOBRapFQi+OjX3kGkf3WkAL3/X52YcmPzrvHKbj/rb1un
         wtVye4x/jkWnPKPDMQpNxLqFEe7Caki2FGPBLlIuOkZx3JgVfJz4i2/r4hyqLBN9Co8p
         RMnIZJPzELIBd8LxT30hNwZAkWrc5piZzxn+4H1I7H1NDrquQ2OeacWUquMG1vpP/iNd
         F+Mugge9iogkxHt4xOIKxYuqwX0UgGGPu1EPwAkwsm83ik87AcfEhNRMaCA0WZT9AM/S
         NDpqk4z9JNfo2KxPF3x6vwmY39T0Ft82Wy0UU9ADUl5IrIqhDUX0hjyl+xKq5dac/uLt
         M0gw==
X-Forwarded-Encrypted: i=1; AJvYcCXUxvFm9KU5HAX155Eh7LVnO8U6XHCNWW2RQEAbkNG7mdm1z9TOiaoM5KypHxyf4kbEZCtmzFiLEew=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcoXdLWhHMN+Yb+ejCu0nAYjoX1AbYXGcg1Ug54S6/MZ1FoSv5
	tXBF4M42Ac7cA/jfdtOryUR+eaSl06VfAWHgj5qSCgoiYZ/Le55zWxEN
X-Gm-Gg: AY/fxX5g/uRIGuyGmmyJuMTW7uC1QUcxvGJXmWUJ5hVfTDKkR6xy8HmvKP3/7wnCovc
	/1w3pVjmwrMXIsRlrOl8B0CxMMHHa+6ESszLLdIZBqCw290ayOdfMeo4NVEK7O737h/hEJmQwVW
	ShKGGW6dHkp+daEjRXG4JZcXv01G6Mjp+m+iIEO65sMHWeHUquCTklLRayD3qM0M7wCC9kMP1nC
	MM7nt+UAfcZzoTrc/DaqU2VmWy/hbs1NzgfLQzuCbNVoNTYU8A4x/iPosUFn7rXHuxMEqJ+IgWn
	VRPJlfpzh7qXUQTjynCRERqAhnpjnV5n8cO2O0mhOAB6wuYBLK+ghX5/L6LHiNNtLhNC6suYNhh
	tkorIAQv3KNlJCdXewJ8LMiGsypSbs/3YDUoe6fFDFU1QAV7/tTGDrZIAiIh899tfGSKhqdAT5d
	Lb4QG9XK91acsOTGzkpR4cH1hWtuJ3H933hs8EKGBS80ThRZ0Fh1zXQ3Fu2xFZ
X-Google-Smtp-Source: AGHT+IFu9sRXlDhbrrd88CdFqtfY428Z7H7S9qMJuvN+AcbadmN0VLt3h0zJTC5Cono7rl8LUANPHA==
X-Received: by 2002:a05:6402:438a:b0:649:81f6:c35b with SMTP id 4fb4d7f45d1cf-64981f6c7b3mr1668658a12.7.1765438318532;
        Wed, 10 Dec 2025 23:31:58 -0800 (PST)
Received: from raspberrypi (p200300f97f21d40007e88c368107f7e5.dip0.t-ipconnect.de. [2003:f9:7f21:d400:7e8:8c36:8107:f7e5])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-649821316e4sm1698569a12.31.2025.12.10.23.31.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Dec 2025 23:31:58 -0800 (PST)
Date: Thu, 11 Dec 2025 08:31:57 +0100
From: Pycode <pycode42@gmail.com>
To: Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: Jeff Layton <jlayton@kernel.org>, Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Removed unused variable
Message-ID: <aTpzbSVFCSgx7HJp@raspberrypi>
References: <aTnfSQJ4QsfwTSf0@raspberrypi>
 <ca38feb0347cc38fd2fe3753628f7644a91aaa7a.camel@kernel.org>
 <aTpdYqy0Q5gGfr3p@raspberrypi>
 <aTpqizefLFrDlxbS@google.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aTpqizefLFrDlxbS@google.com>

On Thu, Dec 11, 2025 at 02:54:03PM +0800, Kuan-Wei Chiu wrote:
> On Thu, Dec 11, 2025 at 06:57:54AM +0100, Pycode wrote:
> > On Thu, Dec 11, 2025 at 08:10:25AM +0900, Jeff Layton wrote:
> > > A more descriptive title is preferred: "Remove unused variable from
> > > nfs4_ff_alloc_deviceid_node()"
> > > 
> > 
> > Thanks for the advices!
> > 
> > > On Wed, 2025-12-10 at 21:59 +0100, Pycode wrote:
> > > > Signed-off-by: Pycode <pycode42@gmail.com>
> > > > 
> > > > Removed the unused variable ret in
> > > > fs/nfs/flexfilelayout/flexfilelayoutdev.c
> > > > 
> > > > (Disclaimer this is my first patch, be sorry if I have done anything
> > > > wrong!)
> > > > ---
> > > >  fs/nfs/flexfilelayout/flexfilelayoutdev.c | 4 +---
> > > >  1 file changed, 1 insertion(+), 3 deletions(-)
> > > > 
> > > > diff --git a/fs/nfs/flexfilelayout/flexfilelayoutdev.c b/fs/nfs/flexfilelayout/flexfilelayoutdev.c
> > > > index c55ea8fa3bfa..9cd04e85d52f 100644
> > > > --- a/fs/nfs/flexfilelayout/flexfilelayoutdev.c
> > > > +++ b/fs/nfs/flexfilelayout/flexfilelayoutdev.c
> > > > @@ -53,7 +53,7 @@ nfs4_ff_alloc_deviceid_node(struct nfs_server *server, struct pnfs_device *pdev,
> > > >  	u32 mp_count;
> > > >  	u32 version_count;
> > > >  	__be32 *p;
> > > > -	int i, ret = -ENOMEM;
> > > > +	int i = -ENOMEM;
> > > >  
> > > 
> > > No need to initialize this.
> > > 
> > > >  	/* set up xdr stream */
> > > >  	scratch = folio_alloc(gfp_flags, 0);
> > > > @@ -88,7 +88,6 @@ nfs4_ff_alloc_deviceid_node(struct nfs_server *server, struct pnfs_device *pdev,
> > > >  	if (list_empty(&dsaddrs)) {
> > > >  		dprintk("%s: no suitable DS addresses found\n",
> > > >  			__func__);
> > > > -		ret = -ENOMEDIUM;
> > > >  		goto out_err_drain_dsaddrs;
> > > >  	}
> > > >  
> > > > @@ -134,7 +133,6 @@ nfs4_ff_alloc_deviceid_node(struct nfs_server *server, struct pnfs_device *pdev,
> > > >  			dprintk("%s: [%d] unsupported ds version %d-%d\n", __func__,
> > > >  				i, ds_versions[i].version,
> > > >  				ds_versions[i].minor_version);
> > > > -			ret = -EPROTONOSUPPORT;
> > > >  			goto out_err_drain_dsaddrs;
> > > >  		}
> > > >  
> > > 
> > > What about the dprintk() at the bottom of this function? Does this
> > > actually build?
> > 
> > There is no dprintk() at the bottom that used the variable.
> 
> At the bottom of this function, there is a dprintk call that refers to ret:
> 
> 	dprintk("%s ERROR: returning %d\n", __func__, ret);
> 	return NULL;
> 
> This causes the build to fail:
> 
> In file included from ./include/asm-generic/bug.h:31,
>                  from ./arch/x86/include/asm/bug.h:193,
>                  from ./arch/x86/include/asm/alternative.h:9,
>                  from ./arch/x86/include/asm/barrier.h:5,
>                  from ./include/asm-generic/bitops/generic-non-atomic.h:7,
>                  from ./include/linux/bitops.h:28,
>                  from ./include/linux/kernel.h:23,
>                  from ./include/linux/uio.h:8,
>                  from ./include/linux/socket.h:8,
>                  from ./include/uapi/linux/in.h:25,
>                  from ./include/linux/in.h:19,
>                  from ./include/linux/nfs_fs.h:22,
>                  from fs/nfs/flexfilelayout/flexfilelayoutdev.c:10:
> fs/nfs/flexfilelayout/flexfilelayoutdev.c: In function ‘nfs4_ff_alloc_deviceid_node’:
> fs/nfs/flexfilelayout/flexfilelayoutdev.c:182:55: error: ‘ret’ undeclared (first use in this function); did you mean ‘net’?
>   182 |         dprintk("%s ERROR: returning %d\n", __func__, ret);
>       |                                                       ^~~
> ./include/linux/printk.h:484:33: note: in definition of macro ‘printk_index_wrap’
>   484 |                 _p_func(_fmt, ##__VA_ARGS__);                           \
>       |                                 ^~~~~~~~~~~
> ./include/linux/sunrpc/debug.h:36:41: note: in expansion of macro ‘printk’
>    36 | #  define __sunrpc_printk(fmt, ...)     printk(KERN_DEFAULT fmt, ##__VA_ARGS__)
>       |                                         ^~~~~~
> ./include/linux/sunrpc/debug.h:42:17: note: in expansion of macro ‘__sunrpc_printk’
>    42 |                 __sunrpc_printk(fmt, ##__VA_ARGS__);                    \
>       |                 ^~~~~~~~~~~~~~~
> ./include/linux/sunrpc/debug.h:25:9: note: in expansion of macro ‘dfprintk’
>    25 |         dfprintk(FACILITY, fmt, ##__VA_ARGS__)
>       |         ^~~~~~~~
> fs/nfs/flexfilelayout/flexfilelayoutdev.c:182:9: note: in expansion of macro ‘dprintk’
>   182 |         dprintk("%s ERROR: returning %d\n", __func__, ret);
>       |         ^~~~~~~
> fs/nfs/flexfilelayout/flexfilelayoutdev.c:182:55: note: each undeclared identifier is reported only once for each function it appears in
>   182 |         dprintk("%s ERROR: returning %d\n", __func__, ret);
>       |                                                       ^~~
> ./include/linux/printk.h:484:33: note: in definition of macro ‘printk_index_wrap’
>   484 |                 _p_func(_fmt, ##__VA_ARGS__);                           \
>       |                                 ^~~~~~~~~~~
> ./include/linux/sunrpc/debug.h:36:41: note: in expansion of macro ‘printk’
>    36 | #  define __sunrpc_printk(fmt, ...)     printk(KERN_DEFAULT fmt, ##__VA_ARGS__)
>       |                                         ^~~~~~
> ./include/linux/sunrpc/debug.h:42:17: note: in expansion of macro ‘__sunrpc_printk’
>    42 |                 __sunrpc_printk(fmt, ##__VA_ARGS__);                    \
>       |                 ^~~~~~~~~~~~~~~
> ./include/linux/sunrpc/debug.h:25:9: note: in expansion of macro ‘dfprintk’
>    25 |         dfprintk(FACILITY, fmt, ##__VA_ARGS__)
>       |         ^~~~~~~~
> fs/nfs/flexfilelayout/flexfilelayoutdev.c:182:9: note: in expansion of macro ‘dprintk’
>   182 |         dprintk("%s ERROR: returning %d\n", __func__, ret);
>       |         ^~~~~~~
> make[5]: *** [scripts/Makefile.build:287: fs/nfs/flexfilelayout/flexfilelayoutdev.o] Error 1
> make[4]: *** [scripts/Makefile.build:556: fs/nfs/flexfilelayout] Error 2
> make[3]: *** [scripts/Makefile.build:556: fs/nfs] Error 2
> make[2]: *** [scripts/Makefile.build:556: fs] Error 2

Sorry, I didn't see that there were more returns because of the jumps. For some reason, it compiled without any problems for me.



