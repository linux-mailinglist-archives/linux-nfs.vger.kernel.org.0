Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F1457D3B97
	for <lists+linux-nfs@lfdr.de>; Fri, 11 Oct 2019 10:50:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726310AbfJKItU (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 11 Oct 2019 04:49:20 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:42656 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727476AbfJKItU (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 11 Oct 2019 04:49:20 -0400
Received: by mail-pg1-f194.google.com with SMTP id f14so282040pgi.9
        for <linux-nfs@vger.kernel.org>; Fri, 11 Oct 2019 01:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WzukUP2fOUpIs6ihOK4yP5t2SdG/ss8hy7E4MBd5V+0=;
        b=OsF+bKYKzP6kL5xMyZ41pyD1dZA8pDPH3X3C4VKyfBDEzJByqmP8ICzyxF381C2iWq
         418KJct6w3SuWwBGzrdj0LE+QXoBBrKqYiT2qR1p9E5K7gBkgcrnxYOVea/8RqxVu4w8
         XDTmv8qxltEg4YAq9kffpNwX+LXVVi/GvspkuI5JKxb/YeF5P+81UhpnS9IVy+DDMGWW
         0UCDjg8kw0U+rB9BuBGVdruNnO/v/o6mPsr09C4KvJSVmOiDbuwg9VNw3Hlp0vNEqxzT
         Xk84OlQ8m+gMawTQqPlxlspx8Y2FinQKzG4LhPXFoCuLBs024tT2ZjdX+8QuGNQNk0fr
         D3Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WzukUP2fOUpIs6ihOK4yP5t2SdG/ss8hy7E4MBd5V+0=;
        b=lTiVpLPfbgfyBuqe7NQQdQ704deyzW37xHuE6/yTvHATyimQ4be0bLsIBsXJ1Gt4wC
         W5lQyVBn7EvZUps6koSC2WSJKJuWn0qQfH5xs8ogyTg+R+Snzy3iDAU2DIyBX2GaTOYU
         Ny6PM5+NPJSgbQGZhe/GS8OWPze1nMTb+0YFIgK2sfNjIFaRUKlBdZzOkrZHYHG3pmTm
         DF4uDxwJjPyC6d98FvH6HgJlY86ZT0dRIhWIZgxz1GNUiFZEgIITas9n8fY0Vb2mf1bG
         tKXMXnZUXRf5BwgKFJbqKOHFkJe5oBnUPPSg6Q4NLDxqyiu8EoNltmwrpa0DXqba/rBv
         ukGA==
X-Gm-Message-State: APjAAAVi27sMdVPisrRw8kor22grMbfUgBVt2VNKWoBZNSyndzElBqwR
        JeDteoCK5i6oCKw6l8ShlTo0iItfNaM=
X-Google-Smtp-Source: APXvYqwB0Eq34KManmCzBsH8rhJsnBeQKIAkCzBLBsRZDUpxJvENObTiE2+Wzz5aefAV9VDh+O+Hhg==
X-Received: by 2002:a63:fb0a:: with SMTP id o10mr15600476pgh.258.1570783759261;
        Fri, 11 Oct 2019 01:49:19 -0700 (PDT)
Received: from localhost ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id k9sm9477794pfk.72.2019.10.11.01.49.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2019 01:49:18 -0700 (PDT)
Date:   Fri, 11 Oct 2019 16:49:10 +0800
From:   Murphy Zhou <jencce.kernel@gmail.com>
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "jencce.kernel@gmail.com" <jencce.kernel@gmail.com>
Subject: Re: [PATCH] NFSv4: fix stateid refreshing when CLOSE racing with OPEN
Message-ID: <20191011084910.joa3ptovudasyo7u@xzhoux.usersys.redhat.com>
References: <20191010074020.o2uwtuyegtmfdlze@XZHOUW.usersys.redhat.com>
 <f81d80f09c59d78c32fddd535b5604bc05c2a2b5.camel@hammerspace.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f81d80f09c59d78c32fddd535b5604bc05c2a2b5.camel@hammerspace.com>
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Oct 10, 2019 at 02:46:40PM +0000, Trond Myklebust wrote:
> On Thu, 2019-10-10 at 15:40 +0800, Murphy Zhou wrote:
> > Since commit:
> >   [0e0cb35] NFSv4: Handle NFS4ERR_OLD_STATEID in CLOSE/OPEN_DOWNGRADE
> > 
> > xfstests generic/168 on v4.2 starts to fail because reflink call
> > gets:
> >   +XFS_IOC_CLONE_RANGE: Resource temporarily unavailable
> > 
> > In tshark output, NFS4ERR_OLD_STATEID stands out when comparing with
> > good ones:
> > 
> >  5210   NFS 406 V4 Reply (Call In 5209) OPEN StateID: 0xadb5
> >  5211   NFS 314 V4 Call GETATTR FH: 0x8d44a6b1
> >  5212   NFS 250 V4 Reply (Call In 5211) GETATTR
> >  5213   NFS 314 V4 Call GETATTR FH: 0x8d44a6b1
> >  5214   NFS 250 V4 Reply (Call In 5213) GETATTR
> >  5216   NFS 422 V4 Call WRITE StateID: 0xa818 Offset: 851968 Len:
> > 65536
> >  5218   NFS 266 V4 Reply (Call In 5216) WRITE
> >  5219   NFS 382 V4 Call OPEN DH: 0x8d44a6b1/
> >  5220   NFS 338 V4 Call CLOSE StateID: 0xadb5
> >  5222   NFS 406 V4 Reply (Call In 5219) OPEN StateID: 0xa342
> >  5223   NFS 250 V4 Reply (Call In 5220) CLOSE Status:
> > NFS4ERR_OLD_STATEID
> >  5225   NFS 338 V4 Call CLOSE StateID: 0xa342
> >  5226   NFS 314 V4 Call GETATTR FH: 0x8d44a6b1
> >  5227   NFS 266 V4 Reply (Call In 5225) CLOSE
> >  5228   NFS 250 V4 Reply (Call In 5226) GETATTR
> > 
> > It's easy to reproduce. By printing some logs, found that we are
> > making
> > CLOSE seqid larger then OPEN seqid when racing.
> > 
> > Fix this by not bumping seqid when it's equal to OPEN seqid. Also
> > put the whole changing process into seqlock read protection in case
> > really bad luck, and this is the same locking behavior with the
> > old deleted function.
> > 
> > Fixes: 0e0cb35b417f ("NFSv4: Handle NFS4ERR_OLD_STATEID in
> > CLOSE/OPEN_DOWNGRADE")
> > Signed-off-by: Murphy Zhou <jencce.kernel@gmail.com>
> > ---
> >  fs/nfs/nfs4proc.c | 13 ++++++++-----
> >  1 file changed, 8 insertions(+), 5 deletions(-)
> > 
> > diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
> > index 11eafcf..6db5a09 100644
> > --- a/fs/nfs/nfs4proc.c
> > +++ b/fs/nfs/nfs4proc.c
> > @@ -3334,12 +3334,13 @@ static void
> > nfs4_sync_open_stateid(nfs4_stateid *dst,
> >  			break;
> >  		}
> >  		seqid_open = state->open_stateid.seqid;
> > -		if (read_seqretry(&state->seqlock, seq))
> > -			continue;
> >  
> >  		dst_seqid = be32_to_cpu(dst->seqid);
> >  		if ((s32)(dst_seqid - be32_to_cpu(seqid_open)) < 0)
> >  			dst->seqid = seqid_open;
> > +
> > +		if (read_seqretry(&state->seqlock, seq))
> > +			continue;
> 
> What's the intention of this change? Neither dst_seqid nor dst->seqid
> are protected by the state->seqlock so why move this code under the
> lock.

Because seqid_open could have changed when writing to dst->seqid ?

The old nfs4_refresh_open_stateid function put the writing under the lock.

> 
> >  		break;
> >  	}
> >  }
> > @@ -3367,14 +3368,16 @@ static bool
> > nfs4_refresh_open_old_stateid(nfs4_stateid *dst,
> >  			break;
> >  		}
> >  		seqid_open = state->open_stateid.seqid;
> > -		if (read_seqretry(&state->seqlock, seq))
> > -			continue;
> >  
> >  		dst_seqid = be32_to_cpu(dst->seqid);
> > -		if ((s32)(dst_seqid - be32_to_cpu(seqid_open)) >= 0)
> > +		if ((s32)(dst_seqid - be32_to_cpu(seqid_open)) > 0)
> >  			dst->seqid = cpu_to_be32(dst_seqid + 1);
> 
> This negates the whole intention of the patch you reference in the
> 'Fixes:', which was to allow us to CLOSE files even if seqid bumps have
> been lost due to interrupted RPC calls e.g. when using 'soft' or
> 'softerr' mounts.
> With the above change, the check could just be tossed out altogether,
> because dst_seqid will never become larger than seqid_open.

Hmm.. I got it wrong. Thanks for the explanation.

> 
> >  		else
> >  			dst->seqid = seqid_open;
> > +
> > +		if (read_seqretry(&state->seqlock, seq))
> > +			continue;
> > +
> 
> Again, why this change to code that doesn't appear to need protection?
> If the bump does succeed above, then looping back will actually cause
> unpredictable behaviour.

Same as above. This change have nothing to do with the stateid race. I
just found it when reading the patch.

Thanks,
M
> 
> >  		ret = true;
> >  		break;
> >  	}
> -- 
> Trond Myklebust
> Linux NFS client maintainer, Hammerspace
> trond.myklebust@hammerspace.com
> 
> 
