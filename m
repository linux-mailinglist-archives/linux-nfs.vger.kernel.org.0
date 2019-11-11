Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B44CF78AC
	for <lists+linux-nfs@lfdr.de>; Mon, 11 Nov 2019 17:25:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726877AbfKKQY7 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 11 Nov 2019 11:24:59 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:46856 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726952AbfKKQY7 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 11 Nov 2019 11:24:59 -0500
Received: by mail-io1-f67.google.com with SMTP id c6so15162999ioo.13
        for <linux-nfs@vger.kernel.org>; Mon, 11 Nov 2019 08:24:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:message-id:subject:from:to:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=OOtJ23XNA5DrBFcFfVCYFuRj1lnoUVTAd8cHNXwkL54=;
        b=FTmikBzm/dgw1aOcK561r+LirNAhKAfON5BaUKJPUY4Erf9QgY1dEuTypGBtlCw3qd
         4M6MPoOjZSqkdkhQzHBl7Y8BxHMl1o+MDgVdWDuieJDgU6xUMrxewTF3EW290x7CjtLU
         Ztl1ALl9q0xJWwgY0ydrovCybecavhDU1MlKwn2GgZA5of6k5A5VbqbythsiWUZOmZRl
         nzB9AbYTTSXgx46lL84kaos6nKMAb6EoSmwRzeukrRq5TKXzRtuzvMO6SdWtBqLEIEZB
         o9t6MC4ev2QPRXLP0P1Exy6V4QRRNCMv3HnSnEH1sGWvqdCL1kpx89BoukNVk7/bcWkH
         V2gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:message-id:subject:from:to:date
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=OOtJ23XNA5DrBFcFfVCYFuRj1lnoUVTAd8cHNXwkL54=;
        b=gSjtzCknVLVR1+Ta+UKYrF+P88qk88K5ekL3xR6YYGWLXEj49joYNrxbaj8jb0hj7K
         MjUyaCTxGY7OlIDDx03Ip0f1YxhMa6L2du7bkdrnnKgiPAxE3CitJwzaj9854OO/6YEW
         MAAXVb9klDVDyh4xL37aG/HHic1x/FJmqdvazovthN8eOsclF+g3kpsKXCGEhj9VQrP1
         9zDFucq0kBS0iTbYJgk0XZuj/aaUf4+VyOVo7qf1l6L8TrTerbrTrWli3pqVaHcJyh85
         MxVA8AcJol+3QoKQXAqvN9RX5oUdllATU6P8150ZTcR/4DORTcXp3j1c1BuUmSbvb7pu
         Gp1w==
X-Gm-Message-State: APjAAAUXWVU4UlGh3rLcib043wofXyCKftOvfPdwhhN4Xuncc/ZTCUu0
        axwzXnUOoMGwz/13/+8ISgmwtePL
X-Google-Smtp-Source: APXvYqzNYEcIWRLdPzyGFDhf94XnJ+PWdF99JR2ZwH6R+VNMvnlvWNzOOOiAV4mNQde8mRnVzg86lA==
X-Received: by 2002:a02:4e84:: with SMTP id r126mr1355872jaa.119.1573489497070;
        Mon, 11 Nov 2019 08:24:57 -0800 (PST)
Received: from gouda.nowheycreamery.com (c-68-32-74-190.hsd1.mi.comcast.net. [68.32.74.190])
        by smtp.googlemail.com with ESMTPSA id d8sm1337734ioq.84.2019.11.11.08.24.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2019 08:24:56 -0800 (PST)
Message-ID: <fa4438011d861431d7c1bf4343527ec9099381fd.camel@gmail.com>
Subject: Re: [PATCH 1/2] NFS: Add FATTR4_WORD1_SPACE_USED to the
 cache_consistency_bitmask
From:   Anna Schumaker <schumaker.anna@gmail.com>
To:     Trond Myklebust <trondmy@hammerspace.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Date:   Mon, 11 Nov 2019 11:24:55 -0500
In-Reply-To: <1296f01521c89e00a9c5f4aff3332829415333c5.camel@hammerspace.com>
References: <20191108210224.33645-1-Anna.Schumaker@Netapp.com>
         <1296f01521c89e00a9c5f4aff3332829415333c5.camel@hammerspace.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Trond,

On Fri, 2019-11-08 at 21:22 +0000, Trond Myklebust wrote:
> On Fri, 2019-11-08 at 16:02 -0500, schumaker.anna@gmail.com wrote:
> > From: Anna Schumaker <Anna.Schumaker@Netapp.com>
> > 
> > Changing a sparse file could have an effect not only on the file
> > size,
> > but also on the number of blocks used by the file in the underlying
> > filesystem. Let's update the SPACE_USED attribute whenever we update
> > SIZE to be as accurate as possible.
> > 
> > This patch fixes xfstests generic/568, which tests that fallocating
> > an
> > unaligned range allocates all blocks touched by that range. Without
> > this
> > patch, `stat` reports 0 bytes used immediately after the fallocate.
> > Adding a `sleep 5` to the test also catches the update, but it's
> > better
> > to just do it when we know something has changed.
> > 
> > Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
> > ---
> >  fs/nfs/nfs4proc.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
> > index ac9063c06205..00a1f3ec7f22 100644
> > --- a/fs/nfs/nfs4proc.c
> > +++ b/fs/nfs/nfs4proc.c
> > @@ -3775,7 +3775,7 @@ static int _nfs4_server_capabilities(struct
> > nfs_server *server, struct nfs_fh *f
> >  
> >  		memcpy(server->cache_consistency_bitmask,
> > res.attr_bitmask, sizeof(server->cache_consistency_bitmask));
> >  		server->cache_consistency_bitmask[0] &=
> > FATTR4_WORD0_CHANGE|FATTR4_WORD0_SIZE;
> > -		server->cache_consistency_bitmask[1] &=
> > FATTR4_WORD1_TIME_METADATA|FATTR4_WORD1_TIME_MODIFY;
> > +		server->cache_consistency_bitmask[1] &=
> > FATTR4_WORD1_TIME_METADATA|FATTR4_WORD1_TIME_MODIFY|FATTR4_WORD1_SPAC
> > E_USED;
> 
> I'd rather not do this. Space used is not a cache consistency attribute
> , as we do not use it to revalidate the cache and it can be rather
> expensive to retrieve on some platforms.

Okay, that makes sense.

> 
> I'd therefore prefer that we just make sure we mark the cache validity
> with NFS_INO_INVALID_OTHER when we have a write succeed on a sparse
> file.

It looks like setting falloc_bitmask to use the standard nfs4_fattr_bitmap
instead of the cache_consistency_bitmask will also update the SPACE_USED
attribute after a fallocate call.

I'll play around with NFS_INO_INVALID_OTHER next, but making use of the trailing
getattr that ALLOCATE and DEALLOCATE already have seems more straightforward to
me.

Anna

> 
> >  		server->cache_consistency_bitmask[2] = 0;
> >  
> >  		/* Avoid a regression due to buggy server */
> -- 
> Trond Myklebust
> Linux NFS client maintainer, Hammerspace
> trond.myklebust@hammerspace.com
> 
> 

